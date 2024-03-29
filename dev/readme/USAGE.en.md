# Other Methods of Usage
## Windows (Manual)

Copy Hosts from [BEBASID](https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts), then paste to
```
C:\Windows\System32\drivers\etc
```
To open the hosts file, use built-in Notepad or Notepad++.
If your are still unable to open the page, you can flush your DNS on the Command Prompt.

```
ipconfig /release
ipconfig /renew
ipconfig /flushdns
```

## Android

### Root

**Manual**

Copy the hosts file and paste to /etc folder and then restart your phone.

**AdAway**

Alternative (if you want to install via app or add other hosts list)

Install [AdAway](https://f-droid.org/en/packages/org.adaway)

```
https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts
```

Open the app, choose Add, then copy above code and paste them.

Turn on "Allow Redirections" in Settings.

**Magisk** (Recommended)

Open Magisk then choose "Module" menu.

After that, tap "+" and then find the bebasid-magisk.zip module.

Tap "Reboot" to start implementing the module.

### Non-Root

Install [Hosts Go](https://play.google.com/store/apps/details?id=dns.hosts.server.change), open the app, tap "Hosts Settings", then choose hosts. Run it.


## Linux

Open the terminal, type or copy the command below, then enter.

```
# Install
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -O /usr/local/bin/bebasid

# Then give the permission to bash folder
sudo chmod +x /usr/local/bin/bebasid

# Help
bebasid --help
```

Alternative (if you just want to install the hosts file):
```
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -O /etc/hosts
```

## BSD / macOS

Open the terminal, type or copy the command below, then enter.

```
# Install
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -o /usr/local/bin/bebasid

# Then give the permission to bash folder
sudo chmod +x /usr/local/bin/bebasid

# Help
bebasid --help
```

Alternative (if you just want to install the hosts file):
```
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -o /etc/hosts
```
