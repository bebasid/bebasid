"""Extract a registrable domain from a GitHub issue form field."""

import argparse
import json
import re
from pathlib import Path
from urllib.parse import urlsplit

import tldextract


# Use the pinned package's PSL snapshot, without network or cache dependencies.
EXTRACT = tldextract.TLDExtract(
    suffix_list_urls=(), cache_dir=None, include_psl_private_domains=True
)


def normalize_domain(value):
    value = value.strip()
    if not value or any(char.isspace() or ord(char) < 32 for char in value):
        raise ValueError("Enter one domain or HTTP/HTTPS URL.")
    parsed = urlsplit(value if "://" in value else "//" + value)
    if parsed.scheme and parsed.scheme.lower() not in ("http", "https"):
        raise ValueError("Only HTTP/HTTPS URLs are supported.")
    if not parsed.hostname or parsed.username is not None or parsed.password is not None:
        raise ValueError("Enter a domain or URL without credentials.")
    # Accessing port also rejects malformed URL ports.
    parsed.port
    hostname = parsed.hostname.rstrip(".").encode("idna").decode("ascii").lower()
    if len(hostname) > 253 or any(
        not re.fullmatch(r"[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?", label)
        for label in hostname.split(".")
    ):
        raise ValueError("Invalid domain name.")
    result = EXTRACT(hostname)
    if not result.domain or not result.suffix:
        raise ValueError("Enter a registrable domain, not an IP address or public suffix.")
    return result.top_domain_under_public_suffix


def domain_from_issue(body, heading):
    match = re.search(
        r"^### " + re.escape(heading) + r"[ \t]*\r?\n(.*?)(?=^### |\Z)",
        body,
        re.MULTILINE | re.DOTALL,
    )
    if not match:
        raise ValueError("Unable to extract domain from issue body.")
    return normalize_domain(match.group(1))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("event_path", type=Path)
    parser.add_argument("heading", choices=("Domain", "Domain atau lain"))
    args = parser.parse_args()
    try:
        event = json.loads(args.event_path.read_text(encoding="utf-8"))
        domain = domain_from_issue(event["issue"]["body"] or "", args.heading)
    except (OSError, KeyError, ValueError) as error:
        parser.exit(1, f"Invalid issue domain: {error}\n")
    print(domain)


if __name__ == "__main__":
    main()
