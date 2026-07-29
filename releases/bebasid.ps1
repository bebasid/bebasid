# ============================================================ #
#  BEBASID - Hosts File Installer for Windows (PowerShell)
#  https://github.com/bebasid/bebasid
#  Copyright (c) 2019-$((Get-Date).Year) BEBASID (MIT License)
# ============================================================ #

# ----- Configuration ----- #

$hostsUrl   = 'https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts'
$defaultUrl = 'https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts'
$destPath   = 'C:\Windows\System32\drivers\etc\hosts'
$tempPath   = "$env:TEMP\bebasid-hosts.tmp"
$rulesUrl   = 'https://github.com/bebasid/bebasid/blob/master/dev/readme/RULES.md'

# ----- Helper Functions ----- #

function Show-Banner {
    Write-Host ''
    Write-Host '   ____  _____ ____    _    ____ ___ ____  ' -ForegroundColor Cyan
    Write-Host '  | __ )| ____| __ )  / \  / ___|_ _|  _ \ ' -ForegroundColor Cyan
    Write-Host '  |  _ \|  _| |  _ \ / _ \ \___ \| || | | |' -ForegroundColor Cyan
    Write-Host '  | |_) | |___| |_) / ___ \ ___) | || |_| |' -ForegroundColor Cyan
    Write-Host '  |____/|_____|____/_/   \_\____/___|____/ ' -ForegroundColor Cyan
    Write-Host ''
    Write-Host '  ==  PEDULI INTERNET NETRAL  ==' -ForegroundColor DarkCyan
    Write-Host ''
}

function Get-WindowsVersionName {
    $ver = [Environment]::OSVersion.Version
    $build = $ver.Build

    if ($ver.Major -eq 10 -and $build -ge 22000) { return 'Windows 11' }
    if ($ver.Major -eq 10)                        { return 'Windows 10' }
    if ($ver.Major -eq 6 -and $ver.Minor -eq 3)   { return 'Windows 8.1' }
    if ($ver.Major -eq 6 -and $ver.Minor -eq 2)   { return 'Windows 8' }
    if ($ver.Major -eq 6 -and $ver.Minor -eq 1)   { return 'Windows 7' }
    if ($ver.Major -eq 6 -and $ver.Minor -eq 0)   { return 'Windows Vista' }
    return "Windows (unknown: $($ver.ToString()))"
}

function Test-BebasidInstalled {
    if (Test-Path $destPath) {
        $content = Get-Content $destPath -Raw -ErrorAction SilentlyContinue
        return ($null -ne $content -and $content -match 'bebasid')
    }
    return $false
}

function Backup-HostsFile {
    if (Test-Path $destPath) {
        $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $backupPath = "$env:TEMP\hosts.bak.$timestamp"
        try {
            Copy-Item -Path $destPath -Destination $backupPath -Force
            Write-Host "  [+] Hosts file backed up to: $backupPath" -ForegroundColor DarkGray
            return $true
        } catch {
            Write-Host "  [!] Failed to backup hosts file: $($_.Exception.Message)" -ForegroundColor Yellow
            return $false
        }
    }
    return $true
}

function Test-DownloadedFile {
    param([string]$FilePath)

    if (-not (Test-Path $FilePath)) {
        Write-Host '  [X] Downloaded file does not exist.' -ForegroundColor Red
        return $false
    }

    $fileInfo = Get-Item $FilePath
    if ($fileInfo.Length -eq 0) {
        Write-Host '  [X] Downloaded file is empty.' -ForegroundColor Red
        return $false
    }

    $content = Get-Content $FilePath -Raw -ErrorAction SilentlyContinue
    if ($null -eq $content) {
        Write-Host '  [X] Cannot read downloaded file.' -ForegroundColor Red
        return $false
    }

    # Hosts file should contain IP-to-domain mappings
    if ($content -notmatch '(127\.0\.0\.1|0\.0\.0\.0)') {
        Write-Host '  [X] Downloaded file does not look like a valid hosts file.' -ForegroundColor Red
        Write-Host '      Expected entries with 127.0.0.1 or 0.0.0.0 but found none.' -ForegroundColor Yellow
        return $false
    }

    return $true
}

function Install-Hosts {
    param(
        [string]$Url,
        [string]$Label
    )

    Write-Host ''
    Write-Host "  [$Label] Starting..." -ForegroundColor Cyan

    # Backup existing hosts file
    Write-Host '  [~] Backing up current hosts file...' -ForegroundColor Gray
    if (-not (Backup-HostsFile)) {
        Write-Host '  [X] Aborting — backup failed.' -ForegroundColor Red
        return $false
    }

    # Download
    Write-Host '  [~] Downloading hosts file...' -ForegroundColor Gray
    try {
        Invoke-WebRequest -Uri $Url -OutFile $tempPath -UseBasicParsing -ErrorAction Stop
        Write-Host '  [+] Download complete.' -ForegroundColor Green
    } catch {
        Write-Host "  [X] Download failed: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }

    # Validate
    Write-Host '  [~] Validating downloaded file...' -ForegroundColor Gray
    if (-not (Test-DownloadedFile -FilePath $tempPath)) {
        Write-Host '  [X] Aborting — file validation failed.' -ForegroundColor Red
        Remove-Item -Path $tempPath -Force -ErrorAction SilentlyContinue
        return $false
    }
    Write-Host '  [+] Validation passed.' -ForegroundColor Green

    # Copy to system
    Write-Host '  [~] Applying hosts file...' -ForegroundColor Gray
    try {
        Copy-Item -Path $tempPath -Destination $destPath -Force -ErrorAction Stop
        Write-Host '  [+] Hosts file applied successfully.' -ForegroundColor Green
    } catch {
        Write-Host "  [X] Failed to apply hosts file: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }

    # Cleanup temp file
    Remove-Item -Path $tempPath -Force -ErrorAction SilentlyContinue

    # Flush DNS
    Write-Host '  [~] Flushing DNS cache...' -ForegroundColor Gray
    try {
        ipconfig /flushdns | Out-Null
        Write-Host '  [+] DNS cache flushed.' -ForegroundColor Green
    } catch {
        Write-Host '  [!] DNS flush warning — you may need to flush manually.' -ForegroundColor Yellow
    }

    return $true
}

# ----- Main Script ----- #

# Administrator check & self-elevation
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)

if (-not $isAdmin) {
    Write-Host 'Requesting administrator privileges...' -ForegroundColor Yellow
    try {
        Start-Process powershell.exe -Verb RunAs -ArgumentList (
            "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
        )
    } catch {
        Write-Host "Failed to elevate: $($_.Exception.Message)" -ForegroundColor Red
        pause
    }
    exit
}

# Clear screen and show banner
Clear-Host
Show-Banner

# Windows version
$winVersion = Get-WindowsVersionName
Write-Host "  OS detected: $winVersion" -ForegroundColor DarkGray
Write-Host ''

# Connectivity check
Write-Host '  [~] Checking internet connection...' -ForegroundColor Gray
$connected = Test-Connection -ComputerName 'www.google.com' -Count 1 -Quiet -ErrorAction SilentlyContinue
if (-not $connected) {
    Write-Host '  [X] No internet connection detected.' -ForegroundColor Red
    Write-Host '      Please check your network and try again.' -ForegroundColor Red
    Write-Host ''
    pause
    exit
}
Write-Host '  [+] Connected to the internet.' -ForegroundColor Green
Write-Host ''

# Status detection
$installed = Test-BebasidInstalled
Write-Host '  ==========================================================' -ForegroundColor DarkGray
Write-Host '   STATUS' -ForegroundColor White
Write-Host '  ==========================================================' -ForegroundColor DarkGray
if ($installed) {
    Write-Host '   bebasid is installed.' -ForegroundColor Green
} else {
    Write-Host '   bebasid is not installed.' -ForegroundColor Yellow
}
Write-Host '  ==========================================================' -ForegroundColor DarkGray
Write-Host ''

# Terms & Conditions
Write-Host '  By continuing, you agree to the Terms & Conditions:' -ForegroundColor DarkGray
Write-Host "  $rulesUrl" -ForegroundColor DarkCyan
Write-Host ''

# Menu
Write-Host '  ==========================================================' -ForegroundColor DarkGray
Write-Host '   COMMANDS' -ForegroundColor White
Write-Host '  ==========================================================' -ForegroundColor DarkGray
if ($installed) {
    Write-Host '   [I] Update bebasid hosts' -ForegroundColor White
} else {
    Write-Host '   [I] Install bebasid hosts' -ForegroundColor White
}
Write-Host '   [W] Restore default hosts file' -ForegroundColor White
Write-Host '   [Q] Quit' -ForegroundColor White
Write-Host '  ==========================================================' -ForegroundColor DarkGray
Write-Host ''

# Input loop
do {
    $choice = Read-Host '  Select [I/W/Q]'
    $choice = $choice.Trim().ToUpper()

    switch ($choice) {
        'I' {
            $label = if ($installed) { 'UPDATE' } else { 'INSTALL' }
            $success = Install-Hosts -Url $hostsUrl -Label $label

            Write-Host ''
            if ($success) {
                Write-Host '  ==========================================================' -ForegroundColor Green
                Write-Host '   bebasid has been installed/updated successfully!' -ForegroundColor Green
                Write-Host '  ==========================================================' -ForegroundColor Green
            } else {
                Write-Host '  ==========================================================' -ForegroundColor Red
                Write-Host '   Operation failed. See errors above.' -ForegroundColor Red
                Write-Host '  ==========================================================' -ForegroundColor Red
            }
            Write-Host ''
            pause
            exit
        }
        'W' {
            $success = Install-Hosts -Url $defaultUrl -Label 'RESTORE'

            Write-Host ''
            if ($success) {
                Write-Host '  ==========================================================' -ForegroundColor Green
                Write-Host '   Hosts file has been restored to default.' -ForegroundColor Green
                Write-Host '  ==========================================================' -ForegroundColor Green
            } else {
                Write-Host '  ==========================================================' -ForegroundColor Red
                Write-Host '   Restore failed. See errors above.' -ForegroundColor Red
                Write-Host '  ==========================================================' -ForegroundColor Red
            }
            Write-Host ''
            pause
            exit
        }
        'Q' {
            exit
        }
        default {
            Write-Host '  Invalid choice. Please enter I, W, or Q.' -ForegroundColor Yellow
        }
    }
} while ($true)
