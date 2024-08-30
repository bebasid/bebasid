$url = 'https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts'
$tempPath = "$env:TEMP\hosts"
$destPath = 'C:\Windows\System32\drivers\etc\hosts'

Write-Host 'Starting process...'
try {
    Write-Host 'Downloading hosts file...'
    Invoke-WebRequest -Uri $url -OutFile $tempPath -UseBasicParsing
    Write-Host 'Downloaded hosts file successfully.'

    Write-Host 'Copying hosts file...'
    Copy-Item -Path $tempPath -Destination $destPath -Force
    Write-Host 'Copied hosts file successfully.'

    Write-Host 'Releasing IP configuration...'
    ipconfig /release | Out-Null; 
    Write-Host 'IP configuration released.'

    Write-Host 'Renewing IP configuration...'
    ipconfig /renew | Out-Null; 
    Write-Host 'IP configuration renewed.'

    Write-Host 'Flushing DNS cache...'
    ipconfig /flushdns | Out-Null; 
    Write-Host 'DNS cache flushed.'

    Write-Host 'Process completed successfully.'
    pause
} catch {
    Write-Host 'An error occurred: ' + $_.Exception.Message -ForegroundColor Red
}
