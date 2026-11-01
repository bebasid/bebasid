import unittest

from issue_domain import domain_from_issue, normalize_domain


class NormalizeDomainTests(unittest.TestCase):
    def test_requested_domain_and_url_forms(self):
        for value in (
            "example.com",
            "https://example.com",
            "https://example.com/",
            "example.example.com",
            "https://example.example.com",
            "https://example.example.com/",
        ):
            with self.subTest(value=value):
                self.assertEqual(normalize_domain(value), "example.com")

    def test_url_components_and_existing_case_normalization(self):
        for value in (
            "  EXAMPLE.COM.  ",
            "http://Sub.Example.COM:8080/path?q=other.net#section",
            "https://sub.example.com./",
            "sub.example.com/path",
        ):
            with self.subTest(value=value):
                self.assertEqual(normalize_domain(value), "example.com")

    def test_public_suffix_boundaries(self):
        for value, expected in (
            ("https://a.example.co.id/", "example.co.id"),
            ("a.example.co.uk", "example.co.uk"),
            ("https://a.project.github.io/", "project.github.io"),
            ("a.example.blogspot.com", "example.blogspot.com"),
            ("www.bücher.de", "xn--bcher-kva.de"),
        ):
            with self.subTest(value=value):
                self.assertEqual(normalize_domain(value), expected)

    def test_invalid_inputs_do_not_become_domain_targets(self):
        for value in (
            "", "_No response_", "https://", "co.id", "github.io",
            "localhost", "127.0.0.1", "https://[::1]/",
            "ftp://example.com/", "https://user:password@example.com/",
            "example.com other.com", "example.com\nEVIL=value",
            "https://example.com:bad/", "-example.com", "example..com",
        ):
            with self.subTest(value=value):
                with self.assertRaises(ValueError):
                    normalize_domain(value)


class IssueFieldTests(unittest.TestCase):
    def test_both_issue_fields_and_line_endings(self):
        for heading in ("Domain", "Domain atau lain"):
            for newline in ("\n", "\r\n"):
                with self.subTest(heading=heading, newline=newline):
                    body = newline.join((
                        "### Deskripsi", "", "other.net", "",
                        f"### {heading}", "", "https://sub.example.com/", "",
                        "### Keterangan", "", "other.org",
                    ))
                    self.assertEqual(domain_from_issue(body, heading), "example.com")

    def test_missing_empty_or_multiple_domain_fields_fail(self):
        for body in (
            "### Keterangan\n\nexample.com",
            "### Domain atau lain\n\nexample.com",
            "### Domain\n\n### Keterangan\n\nexample.com",
            "### Domain\n\nexample.com\nother.com",
        ):
            with self.subTest(body=body):
                with self.assertRaises(ValueError):
                    domain_from_issue(body, "Domain")


if __name__ == "__main__":
    unittest.main()
