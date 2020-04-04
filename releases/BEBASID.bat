@echo off && color 0b
Title BEBASID ^> %~nx0

:ARCHITECTURE_VALIDATION (
 if "%PROCESSOR_ARCHITECTURE%" EQU "amd64" ( >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
 ) else ( >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" )
)

:ADMINISTRATOR_VALIDATION (
if '%ErrorLevel%' NEQ '0' ( echo.
echo BEBASID sedang meminta hak akses administrator 5 .
timeout 1 >nul && echo. && echo Memulai proses meminta hak akses administrator 4 . .
timeout 1 >nul && echo. && echo Memulai proses meminta hak akses administrator 3 . . .
timeout 1 >nul && echo. && echo Memulai proses meminta hak akses administrator 2 . . . .
timeout 1 >nul && echo. && echo Memulai proses meminta hak akses administrator 1 . . . . .
GOTO :UAC_PROMPT
 ) else ( GOTO :GOT_ADMIN )
)

:UAC_PROMPT (
 set params= %*
 
 echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
 echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"
 
 "%temp%\getadmin.vbs" && del "%temp%\getadmin.vbs"
 
 exit /b
) 

:GOT_ADMIN (
pushd "%CD%" && CD /D "%~dp0" && GOTO :INITIALIZE
)

:INITIALIZE (
cd /d %SystemRoot%\System32\Drivers\etc\

  echo.
  echo   ____  _____ ____    _    ____ ___ ____  
  echo "| __ )| ____| __ )  / \  / ___|_ _|  _ \ "
  echo "|  _ \|  _| |  _ \ / _ \ \___ \| || | | |"
  echo "| |_) | |___| |_) / ___ \ ___) | || |_| |"
  echo "|____/|_____|____/_/   \_\____/___|____/ "
  echo.
  echo ==   PEDULI INTERNET NETRAL  ==
  echo.

echo. && echo Mengecek koneksi internet
set server=www.google.com
)

:CEK (
echo. && echo Memulai proses ping 5 .
timeout 1 >nul && echo. && echo Memulai proses ping 4 . .
timeout 1 >nul && echo. && echo Memulai proses ping 3 . . .
timeout 1 >nul && echo. && echo Memulai proses ping 2 . . . .
timeout 1 >nul && echo. && echo Memulai proses ping 1 . . . . .
echo.
ping %server% > NUL
if %ERRORLEVEL%==0 (
@echo =======================
echo Terkoneksi ke internet
echo =======================
GOTO CEKWIN
) else (
@echo =============================
echo Tidak terkoneksi ke internet
echo =============================
echo. && echo Pastikan kamu terkoneksi ke internet

echo. && echo Tekan tombol apa saja untuk keluar
pause >nul
exit
)
)

:CEKWIN (
echo. && echo Mengecek versi Windows 5 .
timeout 1 >nul && echo. && echo Mengecek versi Windows 4 . .
timeout 1 >nul && echo. && echo Mengecek versi Windows 3 . . .
timeout 1 >nul && echo. && echo Mengecek versi Windows 2 . . . .
timeout 1 >nul && echo. && echo Mengecek versi Windows 1 . . . . .
echo.
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" echo Sistem terdeteksi memakai Windows 10
if "%version%" == "6.3" echo Sistem terdeteksi memakai Windows 8.1
if "%version%" == "6.2" echo Sistem terdeteksi memakai Windows 8
if "%version%" == "6.1" echo Sistem terdeteksi memakai Windows 7
if "%version%" == "6.0" echo Sistem terdeteksi memakai Windows Vista
if "%version%" == "5.2" echo Sistem terdeteksi memakai Windows XP x64
if "%version%" == "5.1" echo Sistem terdeteksi memakai Windows XP
rem etc etc
GOTO TANYA
)

:TANYA {
cls
  echo.
  echo   ____  _____ ____    _    ____ ___ ____  
  echo "| __ )| ____| __ )  / \  / ___|_ _|  _ \ "
  echo "|  _ \|  _| |  _ \ / _ \ \___ \| || | | |"
  echo "| |_) | |___| |_) / ___ \ ___) | || |_| |"
  echo "|____/|_____|____/_/   \_\____/___|____/ "
  echo.
  echo ==   PEDULI INTERNET NETRAL  ==
  echo.
  echo.
echo (#) Apa kamu yakin ingin membuka akses pada website yang diblokir oleh internet positif?
echo.
echo (#) Dengan melanjutkan berarti secara langsung dan tidak langsung, kamu menyetujui apa yang ada di RULES.md
echo.
echo (#) Untuk mengembalikan hosts ke default, kamu cukup menekan tombol keyboard [W], kemudian tekan tombol keyboard [Enter]
echo.
echo (#) Untuk mengonfirmasi, kamu cukup menekan salah satu tombol keyboard [Y] atau [N] kemudian tekan tombol keyboard [Enter]
echo.
)

:KONFIRMASI (
SET /P yakin=[Y/N/W]? 
IF /I "%yakin%" EQU "Y" GOTO YAKIN
IF /I "%yakin%" EQU "N" GOTO TIDAK
IF /I "%yakin%" EQU "W" GOTO RESTORE
GOTO KONFIRMASI
)

:YAKIN (
if "%version%" == "10.0" GOTO DOWN3
if "%version%" == "6.3" GOTO DOWN3
if "%version%" == "6.2" GOTO DOWN3
if "%version%" == "6.1" GOTO DOWN2
if "%version%" == "6.0" GOTO DOWN2
if "%version%" == "5.2" GOTO DOWN2
if "%version%" == "5.1" GOTO DOWN2
)

:TIDAK (
exit
)

:DOWN2 (
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts', 'hosts')"
ipconfig /flushdns
ipconfig /release
ipconfig /renew
cls
  echo.
  echo   ____  _____ ____    _    ____ ___ ____  
  echo "| __ )| ____| __ )  / \  / ___|_ _|  _ \ "
  echo "|  _ \|  _| |  _ \ / _ \ \___ \| || | | |"
  echo "| |_) | |___| |_) / ___ \ ___) | || |_| |"
  echo "|____/|_____|____/_/   \_\____/___|____/ "
  echo.
  echo ==   PEDULI INTERNET NETRAL  ==
  echo.
echo BEBASID telah berhasil terpasang
echo.
echo Tekan tombol apa saja untuk keluar
pause >nul
exit
)

:DOWN3 (
powershell -command "Invoke-WebRequest 'https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts' -OutFile 'hosts'"
ipconfig /flushdns
ipconfig /release
ipconfig /renew
cls
  echo.
  echo   ____  _____ ____    _    ____ ___ ____  
  echo "| __ )| ____| __ )  / \  / ___|_ _|  _ \ "
  echo "|  _ \|  _| |  _ \ / _ \ \___ \| || | | |"
  echo "| |_) | |___| |_) / ___ \ ___) | || |_| |"
  echo "|____/|_____|____/_/   \_\____/___|____/ "
  echo.
  echo ==   PEDULI INTERNET NETRAL  ==
  echo.
echo BEBASID telah berhasil terpasang
echo.
echo Tekan tombol apa saja untuk keluar
pause >nul
exit
)

:RESTORE
if "%version%" == "10.0" GOTO RESTORE3
if "%version%" == "6.3" GOTO RESTORE3
if "%version%" == "6.2" GOTO RESTORE3
if "%version%" == "6.1" GOTO RESTORE2
if "%version%" == "6.0" GOTO RESTORE2
if "%version%" == "5.2" GOTO RESTORE2
if "%version%" == "5.1" GOTO RESTORE2
)

:RESTORE2
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts', 'hosts')"
ipconfig /flushdns
ipconfig /release
ipconfig /renew
cls
  echo.
  echo   ____  _____ ____    _    ____ ___ ____  
  echo "| __ )| ____| __ )  / \  / ___|_ _|  _ \ "
  echo "|  _ \|  _| |  _ \ / _ \ \___ \| || | | |"
  echo "| |_) | |___| |_) / ___ \ ___) | || |_| |"
  echo "|____/|_____|____/_/   \_\____/___|____/ "
  echo.
  echo ==   PEDULI INTERNET NETRAL  ==
  echo.
echo BEBASID telah berhasil dikembalikan ke default
echo.
echo Tekan tombol apa saja untuk keluar
pause >nul
exit
)

:RESTORE3
powershell -command "Invoke-WebRequest 'https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts' -OutFile 'hosts'"
ipconfig /flushdns
ipconfig /release
ipconfig /renew
cls
  echo.
  echo   ____  _____ ____    _    ____ ___ ____  
  echo "| __ )| ____| __ )  / \  / ___|_ _|  _ \ "
  echo "|  _ \|  _| |  _ \ / _ \ \___ \| || | | |"
  echo "| |_) | |___| |_) / ___ \ ___) | || |_| |"
  echo "|____/|_____|____/_/   \_\____/___|____/ "
  echo.
  echo ==   PEDULI INTERNET NETRAL  ==
  echo.
echo BEBASID telah berhasil dikembalikan ke default
echo.
echo Tekan tombol apa saja untuk keluar
pause >nul
exit
)

endlocal
