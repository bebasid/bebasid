@echo off && color 0b
Title BEBASID ^> %~nx0

:ARCHITECTURE_VALIDATION (
 if "%PROCESSOR_ARCHITECTURE%" EQU "amd64" ( >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
 ) else ( >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" )
)

:ADMINISTRATOR_VALIDATION (
if '%ErrorLevel%' NEQ '0' ( echo.
echo bebasid sedang meminta hak akses administrator 5 .
timeout 1 >nul && echo. && echo bebasid sedang meminta hak akses administrator 4 . .
timeout 1 >nul && echo. && echo bebasid sedang meminta hak akses administrator 3 . . .
timeout 1 >nul && echo. && echo bebasid sedang meminta hak akses administrator 2 . . . .
timeout 1 >nul && echo. && echo bebasid sedang meminta hak akses administrator 1 . . . . .
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

set server=www.google.com
)

:CEK (
echo. && echo bebasid sedang memeriksa ada tidaknya koneksi internet 5 .
timeout 1 >nul && echo. && echo bebasid sedang memeriksa ada tidaknya koneksi internet 4 . .
timeout 1 >nul && echo. && echo bebasid sedang memeriksa ada tidaknya koneksi internet 3 . . .
timeout 1 >nul && echo. && echo bebasid sedang memeriksa ada tidaknya koneksi internet 2 . . . .
timeout 1 >nul && echo. && echo bebasid sedang memeriksa ada tidaknya koneksi internet 1 . . . . .
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
echo. && echo bebasid sedang melihat versi sistem operasi yang sedang digunakan 5 .
timeout 1 >nul && echo. && echo bebasid sedang melihat versi sistem operasi yang sedang digunakan 4 . .
timeout 1 >nul && echo. && echo bebasid sedang melihat versi sistem operasi yang sedang digunakan 3 . . .
timeout 1 >nul && echo. && echo bebasid sedang melihat versi sistem operasi yang sedang digunakan 2 . . . .
timeout 1 >nul && echo. && echo bebasid sedang melihat versi sistem operasi yang sedang digunakan 1 . . . . .
echo.
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
timeout 1 >nul &&  if "%version%" == "10.0" echo ===================================== && echo Sistem terdeteksi memakai Windows 10 && echo ===================================== && echo. && echo Mohon tunggu sebentar, bebasid sedang menyiapkan bahan yang diperlukan . . . .
timeout 1 >nul &&  if "%version%" == "6.3" echo ===================================== && echo Sistem terdeteksi memakai Windows 8.1 && echo ===================================== && echo. && echo Mohon tunggu sebentar, bebasid sedang menyiapkan bahan yang diperlukan . . . .
timeout 1 >nul &&  if "%version%" == "6.2" echo ===================================== && echo Sistem terdeteksi memakai Windows 8 && echo ===================================== && echo. && echo Mohon tunggu sebentar, bebasid sedang menyiapkan bahan yang diperlukan . . . .
timeout 1 >nul &&  if "%version%" == "6.1" echo ===================================== && echo Sistem terdeteksi memakai Windows 7 && echo ===================================== && echo. && echo Mohon tunggu sebentar, bebasid sedang menyiapkan bahan yang diperlukan . . . .
timeout 1 >nul && if "%version%" == "6.0" echo ===================================== && echo Sistem terdeteksi memakai Windows Vista && echo ===================================== && echo. && echo Mohon tunggu sebentar, bebasid sedang menyiapkan bahan yang diperlukan . . . .
timeout 1 >nul && if "%version%" == "5.2" echo ===================================== && echo Sistem terdeteksi memakai Windows XP x64 && echo ===================================== && echo. && echo Mohon tunggu sebentar, bebasid sedang menyiapkan bahan yang diperlukan . . . .
timeout 1 >nul && if "%version%" == "5.1" echo ===================================== && echo Sistem terdeteksi memakai Windows XP && echo ===================================== && echo. && echo Mohon tunggu sebentar, bebasid sedang menyiapkan bahan yang diperlukan . . . .
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
  echo (#) Proses pemeriksaan selesai, device kamu terhubung dengan internet
  echo.
	if "%version%" == "10.0" echo (#) Sistem yang ada pada device kamu terdeteksi memakai Windows 10
	if "%version%" == "6.3" echo (#) Sistem yang ada pada device kamu terdeteksi memakai Windows 8.1
	if "%version%" == "6.2" echo (#) Sistem yang ada pada device kamu terdeteksi memakai Windows 8
	if "%version%" == "6.1" echo (#) Sistem yang ada pada device kamu terdeteksi memakai Windows 7
	if "%version%" == "6.0" echo (#) Sistem yang ada pada device kamu terdeteksi memakai Windows Vista
	if "%version%" == "5.2" echo (#) Sistem yang ada pada device kamu terdeteksi memakai Windows XP x64
	if "%version%" == "5.1" echo (#) Sistem yang ada pada device kamu terdeteksi memakai Windows XP
echo.
echo (#) Dengan melanjutkan berarti secara langsung dan tidak langsung, kamu menyetujui apa yang ada di syarat dan ketentuan
echo.
echo (#) Syarat dan Ketentuan: https://github.com/bebasid/bebasid/blob/master/dev/readme/RULES.md
echo.
echo ===========================================================================
echo.
echo (!) Tekan tombol keyboard [W], kemudian [Enter] jika ingin mengembalikan hosts ke default
echo.
echo ===========================================================================
echo.
echo (=) Tekan tombol keyboard [Y] kemudian [Enter] jika ingin memulai proses pemasangan
echo.
echo (=) Tekan tombol keyboard [N] kemudian [Enter] jika ingin membatalkan dan keluar
echo.
echo (=) Tekan tombol keyboard [D] kemudian [Enter] jika ingin memasang/mengganti ke hosts versi penuh
echo.
echo ===========================================================================
echo.
echo (#) Yakin ingin melanjutkan?
echo.
)

:KONFIRMASI (
SET /P yakin=[Y/N/D/W]? 
IF /I "%yakin%" EQU "Y" GOTO YAKIN
IF /I "%yakin%" EQU "N" GOTO TIDAK
IF /I "%yakin%" EQU "D" GOTO PENUH
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
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', 'hosts')"
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
powershell -command "Invoke-WebRequest 'https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw' -OutFile 'hosts'"
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

:PENUH (
if "%version%" == "10.0" GOTO PENUH3
if "%version%" == "6.3" GOTO PENUH3
if "%version%" == "6.2" GOTO PENUH3
if "%version%" == "6.1" GOTO PENUH2
if "%version%" == "6.0" GOTO PENUH2
if "%version%" == "5.2" GOTO PENUH2
if "%version%" == "5.1" GOTO PENUH2
)

:PENUH2 (
powershell -command "(new-object System.Net.WebClient).DownloadFile('https://github.com/bebasid/bebasid/raw/master/releases/hosts', 'hosts')"
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

:PENUH3 (
powershell -command "Invoke-WebRequest 'https://github.com/bebasid/bebasid/raw/master/releases/hosts' -OutFile 'hosts'"
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

endlocal
