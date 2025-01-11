<div align="center">

#### Bahasa / Language
| <img src="https://em-content.zobj.net/thumbs/120/twitter/351/flag-indonesia_1f1ee-1f1e9.png" width="16"/> [Indonesia](README.md) | <img src="https://github.com/twitter/twemoji/blob/master/assets/svg/1f1fa-1f1f8.svg" width="16"/> **English** |
|-|-|

<p align="center">
    <img src="dev/resources/logo-black.svg#gh-light-mode-only" alt="BebasID Logo White" width="445">
    <img src="dev/resources/logo.svg#gh-dark-mode-only" alt="BebasID Logo Black" width="445"><br>
    <i>Helping you surf securely and without limit!</i>
</p>

<a href="#">
<img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fbebasid%2Fbebasid&count_bg=%23222222&title_bg=%23222222&icon=myspace.svg&icon_color=%23FFFFFF&title=TODAY+%5BWATCHERS+%2F+TOTAL%5D&edge_flat=true"/>
</a>

<br>

<a href="LICENSE">
    <img alt="Static Badge" src="https://img.shields.io/badge/MIT-white?style=for-the-badge&logo=andela&logoColor=white&label=License&labelColor=222">
</a>

<img alt="Static Badge" src="https://img.shields.io/badge/2019-white?style=for-the-badge&logo=fireship&logoColor=white&label=Released&labelColor=222">

<br>

<a href="https://discord.gg/bebasid-630415907021389825">
    <img alt="Discord" src="https://img.shields.io/discord/630415907021389825?style=for-the-badge&logo=discord&logoColor=white&label=Discord&labelColor=222&color=white">
</a>

<a href="https://t.me/bebasidbykini">
    <img alt="Static Badge" src="https://img.shields.io/badge/join-white?style=for-the-badge&logo=telegram&logoColor=white&label=Telegram&labelColor=222">
</a>

<a href="https://chat.whatsapp.com/Jmn5Uv4UYj0GdQooI1Jwbi">
    <img alt="Static Badge" src="https://img.shields.io/badge/join-white?style=for-the-badge&logo=whatsapp&logoColor=white&label=WhatsApp&labelColor=222">
</a>

<br>

<a href="https://trakteer.id/bebasidbykini">
    <img alt="Static Badge" src="https://img.shields.io/badge/donate-white?style=for-the-badge&logo=buymeacoffee&logoColor=white&label=Trakteer&labelColor=222">
</a>

<a href="https://saweria.co/bebasid">
    <img alt="Static Badge" src="https://img.shields.io/badge/donate-white?style=for-the-badge&logo=iconjar&logoColor=white&label=Saweria&labelColor=222">
</a>
</p>

## Sponsor

*A freedom-oriented and neutral VPS provider for your needs.*

| <a href="https://atharva.co.id"><img src="https://www.atharva.co.id/images/logo.jpg" width="380"></a> |
|-|
| <p align="center">[atharva.co.id](https://atharva.co.id)</p> |

<!--
| <a href="https://qdei.co">![QDEI Cloud](https://qdei.co/_image?href=%2F_astro%2Fqdei-logo.Dh5viwbv.avif&f=webp)</a> |
| - |
| <p align="center">[qdei.co](https://qdei.co)</p> |

Starting from <b>Rp. **50.000,00**.
[See the complete VPS packages](https://www.atharva.cloud/index.php?rp=/store/cloud-vm-lite)
//-->
</div>


##
> [!IMPORTANT]  
> For ISP that implementing DPI, please read [this](#announcement-concerning-dpi).<br><br>
> We do not support illegal activities such as online gambling. We strive for internet neutrality, not to break the law. Because of that, <b> we will ignore the request to add an online gambling site to our host. </b>

## Table of Content
- [Table of Content](#table-of-content)
- [BebasID](#bebasid)
    - [Windows](#windows)
    - [Linux](#linux)
    - [Android](#android)
    - [macOS](#macos)
 - [Other Methods](#other-methods)
- [Contributing, Question, and Request](#contributing-question-and-request)
 - [Announcement Concerning DPI](#announcement-concerning-dpi)
 - [Frequently Asked Question](#frequently-asked-question)
- [Terms and Conditions](#terms-and-conditions)

## BebasID
With BebasID, you can access any restricted content that is blocked by using [_hosts file_](<https://en.wikipedia.org/wiki/Hosts_(file)>).

### Windows
#### <ins>Graphical User Interface (GUI) - Under Construction</ins>
<!---
You can use [bebasid](https://github.com/bebasid/bebasid/releases/tag/v1.1) to simplify BebasID's hosts installaton.

![bebasid.exe running on Windows 10](https://i.imgur.com/Bcq0rgm.png)

If you need the source code of BebasID (GUI), please visit our repo [BebasID-src](https://github.com/bebasid/bebasid-src).
-->
*Work-in-progress information: [BebasID-src](https://github.com/bebasid/bebasid-src)*

#### PowerShell - Recommended
```
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.ps1 | iex`"" -Verb RunAs -Wait
```

#### BebasHosts Portable
BebasHosts is a rewrite of BebasID software to adjust the hosts file. You can use the [BebasHosts software](https://github.com/bebasid/bebasid/raw/master/releases/BebasHosts%20Portable.zip) with 2 primary functions:
1. `.Host-Update.bat` is used to modify the hosts file with the hosts file from BebasID.
2. `.Host-Reset.bat` reverts the hosts file to the original Windows hosts file.

### Linux
#### BebasID Shell
Install
```
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -O /usr/local/bin/bebasid && sudo chmod +x /usr/local/bin/bebasid
```
Help
```
bebasid --help
```

#### Install Only
```
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -O /etc/hosts
```

### Android
#### Bindhosts (Magisk Module)
Install [bindhosts](https://github.com/backslashxx/bindhosts) module with Magisk, KernelSU or APatch.
Add hosts to bindhosts and run with WebUI [like this](https://imgur.com/a/FGUN2P9).
If you use Magisk, use [KSU WebUI](https://github.com/5ec1cff/KsuWebUIStandalone) to access WebUI from bindhosts.

### macOS
#### BebasID Shell
Install
```
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -o /usr/local/bin/bebasid && sudo chmod +x /usr/local/bin/bebasid
```

Help
```
bebasid --help
```

#### Install Only
```
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -o /etc/hosts
```

### Multiple Hosts
[SwitchHosts](https://github.com/oldj/SwitchHosts) - Application for management & host redirection.

### Other Methods

#### **BebasDNS / BebasID DNS**:
If this hosts is not suitable for you, and using DNS or DoH/DoT version please visit the [BebasDNS](https://github.com/bebasid/bebasdns) repo to use it.

#### **Other Usages**:
For other usage tutorials, please visit [OTHER USAGES](https://github.com/bebasid/bebasid/blob/master/dev/readme/USAGE.en.md) if you understand the usage.

## Contributing, Question, and Request

Please head to [CONTRIBUTING](https://github.com/bebasid/bebasid/blob/master/CONTRIBUTING.md) for the contributing guidelines.

If you have any request or bug report, please [open a new issue](https://github.com/bebasid/bebasid/issues/new/choose).

### Announcement Concerning DPI
<details>
<summary>Click to open the announcement</summary>

For an ISP that uses DPI, use <a href="https://github.com/bebasid/bebasit">bebasit</a> to bypass the DPI or turn on IPv6 if the ISP supports it.

**Signs if the ISP is using DPI:**
| HTTP protocol redirecting to [lamanlabuh.aduankonten.id](http://lamanlabuh.aduankonten.id) | while the HTTPS protocol ended with `ERR_CONNECTION_RESET`/`PR_CONNECT_RESET_ERROR` | 
|:-|:-|
| <img src="https://github.com/bebasid/bebasid/blob/master/dev/resources/http-lamanlabuh-result.png" alt="HTTP Lamanlabuh Result"> | <img src="https://github.com/bebasid/bebasid/blob/master/dev/resources/https-connection-reset.png" alt="HTTPS Connection Reset Result"> |

</br> <a href="https://github.com/bebasid/bebasdns/blob/main/dev/readme/learnmore.md">See more detailed information about DPI</a>.<br></br>

**How to bypass Kominfo DPI in Modem/Router:**
| <a href="https://github.com/bebasid/bebasit/blob/master/docs/openwrt-tutorial.en.md"><img src="https://archive.org/download/github.com-openwrt-openwrt_-_2021-04-13_21-34-02/cover.jpg" width="16"/> OpenWRT</a> | <a href="https://github.com/bebasid/bebasit/blob/master/docs/mikrotik-tutorial.en.md"><img src="https://cdn.discordapp.com/attachments/381569782257811456/1147154206063611994/Sb0qyQ88hIP9IdDM.png" width="16"/> MikroTik</a> |
|:-|:-|

**Operating System (OS):**
| <a href="https://github.com/bebasid/bebasit/blob/master/README.en.md#windows"><img src="https://seeklogo.com/images/W/windows-11-icon-logo-6C39629E45-seeklogo.com.png" width="16"/> Windows</a> | <a href="https://github.com/bebasid/bebasit/blob/master/README.en.md#macos"><img src="https://cdn-icons-png.flaticon.com/512/2/2235.png" width="16"/> MacOS</a> | <a href="https://github.com/bebasid/bebasit/blob/master/README.en.md#linux"><img src="https://cdn-icons-png.flaticon.com/512/226/226772.png" width="16"/> Linux</a> |
|:-|:-|:-|

</details>

### Frequently Asked Question

If you have any problem in using BebasID, you can ask on [Discord](https://discord.gg/EKrxZyu) or you can email to [`dukungan@bebasid.com`](mailto:dukungan@bebasid.com).

## Terms and Conditions

By using the BebasID application, you are deemed to have read, understood, and agreed to all the rules we have made and accept all the consequences that will arise. If you do not agree to accept the existing rules, then you are not allowed to use the BebasID application. For more information about the rules, you can see them on the page. [RULES](https://github.com/bebasid/bebasid/blob/master/dev/readme/RULES.md).

<br>

<p align="center">Share this project</p>
<div id="sosial">
 <p align="center">
  <a href="https://twitter.com/intent/tweet?text=https%3A//github.com/bebasid/bebasid"><img src="https://img.shields.io/badge/Twitter-white?style=for-the-badge&logo=twitter&logoColor=black"/></a>
  <a href="https://www.facebook.com/sharer/sharer.php?u=https%3A//github.com/bebasid/bebasid"><img src="https://img.shields.io/badge/Facebook-white?style=for-the-badge&logo=facebook&logoColor=black"/></a>
 </p>
</div>
