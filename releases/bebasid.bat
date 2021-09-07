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
 
	call :BANNER


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
		echo =======================
		echo Terkoneksi ke internet
		echo =======================
		GOTO CEKWIN
	) else (
		echo =============================
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
	timeout 1 >nul &&  if "%version%" == "11.0" echo ===================================== && echo Sistem terdeteksi memakai Windows 11 && echo ===================================== && echo. && echo Mohon tunggu sebentar, bebasid sedang menyiapkan bahan yang diperlukan . . . .
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
	call :BANNER
	echo.
	echo ===========================================================================
	echo.
	echo ===INFORMASI PERANGKAT===
	echo.
	echo [#] Proses pemeriksaan selesai, perangkat kamu terhubung dengan internet
	echo.
	if "%version%" == "11.0" echo [#] Sistem yang ada pada perangkat kamu terdeteksi memakai Windows 11
	if "%version%" == "10.0" echo [#] Sistem yang ada pada perangkat kamu terdeteksi memakai Windows 10
	if "%version%" == "6.3" echo [#] Sistem yang ada pada perangkat kamu terdeteksi memakai Windows 8.1
	if "%version%" == "6.2" echo [#] Sistem yang ada pada perangkat kamu terdeteksi memakai Windows 8
	if "%version%" == "6.1" echo [#] Sistem yang ada pada perangkat kamu terdeteksi memakai Windows 7
	if "%version%" == "6.0" echo [#] Sistem yang ada pada perangkat kamu terdeteksi memakai Windows Vista
	if "%version%" == "5.2" echo [#] Sistem yang ada pada perangkat kamu terdeteksi memakai Windows XP x64
	if "%version%" == "5.1" echo [#] Sistem yang ada pada perangkat kamu terdeteksi memakai Windows XP
	echo.
	echo ===========================================================================
	echo.
	echo ===PERSETUJUAN===
	echo.
	echo [#] Dengan melanjutkan berarti secara langsung dan tidak langsung, kamu menyetujui apa yang ada di syarat dan ketentuan
	echo.
	echo [#] Syarat dan Ketentuan: https://github.com/bebasid/bebasid/blob/master/dev/readme/RULES.md
	echo.
	echo ===========================================================================
	echo.
	echo ===PERINTAH===
	echo.
	>nul findstr /c:"bebasid" C:\Windows\System32\Drivers\etc\hosts && (
	echo [=] Tekan tombol keyboard [Y] kemudian [Enter] untuk membarui hosts
	) || (
	echo [=] Tekan tombol keyboard [Y] kemudian [Enter] jika ingin memulai proses pemasangan
	)
	echo.
	echo [=] Tekan tombol keyboard [N] kemudian [Enter] jika ingin membatalkan dan keluar
	echo.
	echo ===========================================================================
	echo.
	echo ===STATUS===
	echo.
	>nul findstr /c:"bebasid" C:\Windows\System32\Drivers\etc\hosts && (
	>nul findstr /c:"pornhub" C:\Windows\System32\Drivers\etc\hosts && (
	echo [#] bebasid telah terpasang dan menggunakan mode NSFW [Tekan E untuk merubah ke SFW]
	) || (
	echo [#] bebasid telah terpasang dan menggunakan mode SFW [Tekan D untuk merubah ke NSFW]
	)
	) || (
	echo [#] bebasid belum terinstall
	)
	echo.
	echo ===========================================================================
	echo.
	echo ===PERINTAH LAIN===
	echo [!] Tekan tombol keyboard [W], kemudian [Enter] jika ingin mengembalikan hosts ke default
	echo.
	echo ===========================================================================
	echo.
	echo [#] Pilih perintah:
	echo.
)

:KONFIRMASI (
	SET /P yakin=[Y/N/D/E/W]? 
	IF /I "%yakin%" EQU "Y" GOTO YAKIN
	IF /I "%yakin%" EQU "N" GOTO TIDAK
	IF /I "%yakin%" EQU "D" GOTO PENUH
	IF /I "%yakin%" EQU "E" GOTO LITE
	IF /I "%yakin%" EQU "W" GOTO RESTORE
	GOTO KONFIRMASI
)

:YAKIN (
	if "%version%" == "11.0" call :DOWN3
	if "%version%" == "10.0" call :DOWN3
	IF "%version%" == "6.3" call :DOWN3
	IF "%version%" == "6.2" call :DOWN3
	if "%version%" == "6.1" call :DOWN2
	IF "%version%" == "6.0" call :DOWN2
	IF "%version%" == "5.2" call :DOWN2
	IF "%version%" == "5.1" call :DOWN2
	call :FLUSH
	cls
	call :BANNER
	echo BEBASID telah berhasil terpasang
	echo.
	echo Tekan tombol apa saja untuk keluar
	pause >nul
	exit
)

:TIDAK (
	exit
)

:DOWN3 (
	>nul findstr /c:"pornhub" C:\Windows\System32\Drivers\etc\hosts && (
	powershell -command "Invoke-WebRequest 'https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts' -OutFile 'hosts'"
	) || (
	powershell -command "Invoke-WebRequest 'https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw' -OutFile 'hosts'"
	)
	exit /b 0
)

:DOWN2 (
	>nul findstr /c:"pornhub" C:\Windows\System32\Drivers\etc\hosts && (
	powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts', 'hosts')"
	) || (
	powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', 'hosts')"
	)
	exit /b 0
)

:RESTORE
	if "%version%" == "11.0" call :RESTORE3
	if "%version%" == "10.0" call :RESTORE3
	IF "%version%" == "6.3" call :RESTORE3
	IF "%version%" == "6.2" call :RESTORE3
	if "%version%" == "6.1" call :RESTORE2
	IF "%version%" == "6.0" call :RESTORE2
	IF "%version%" == "5.2" call :RESTORE2
	IF "%version%" == "5.1" call :RESTORE2
	call :FLUSH
	cls
	call :BANNER
	echo BEBASID telah berhasil dikembalikan ke default
	echo.
	echo Tekan tombol apa saja untuk keluar
	pause >nul
	exit
)

:RESTORE3 (
	powershell -command "Invoke-WebRequest 'https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts' -OutFile 'hosts'"
	exit /b 0
)

:RESTORE2 (
	powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts', 'hosts')"
	exit /b 0
)

:PENUH (
	if "%version%" == "11.0" call :PENUH3
	if "%version%" == "10.0" call :PENUH3
	IF "%version%" == "6.3" call :PENUH3
	IF "%version%" == "6.2" call :PENUH3
	if "%version%" == "6.1" call :PENUH2
	IF "%version%" == "6.0" call :PENUH2
	IF "%version%" == "5.2" call :PENUH2
	IF "%version%" == "5.1" call :PENUH2
	call :FLUSH
	cls
	call :BANNER
	echo BEBASID telah berhasil terpasang
	echo.
	echo Tekan tombol apa saja untuk keluar
	pause >nul
	exit
)

:PENUH3 (
	powershell -command "Invoke-WebRequest 'https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts' -OutFile 'hosts'"
	exit /b 0
)

:PENUH2 (
	powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts', 'hosts')"
	exit /b 0
)

:LITE (
	if "%version%" == "11.0" call :LITE3
	if "%version%" == "10.0" call :LITE3
	IF "%version%" == "6.3" call :LITE3
	IF "%version%" == "6.2" call :LITE3
	if "%version%" == "6.1" call :LITE2
	IF "%version%" == "6.0" call :LITE2
	IF "%version%" == "5.2" call :LITE2
	IF "%version%" == "5.1" call :LITE2
	call :FLUSH
	cls
	call :BANNER
	echo BEBASID telah berhasil terpasang
	echo.
	echo Tekan tombol apa saja untuk keluar
	pause >nul
	exit
)

:LITE3 (
	powershell -command "Invoke-WebRequest 'https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw' -OutFile 'hosts'"
	exit /b 0
)

:LITE2 (
	powershell -command "(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw', 'hosts')"
	exit /b 0
)

:BANNER (
	echo.
	echo   ____  _____ ____    _    ____ ___ ____ 
	echo "| __ )| ____| __ )  / \  / ___|_ _|  _ \ "
	echo "|  _ \|  _| |  _ \ / _ \ \___ \| || | | |"
	echo "| |_) | |___| |_) / ___ \ ___) | || |_| |"
	echo "|____/|_____|____/_/   \_\____/___|____/ "
	echo.
	echo ==   PEDULI INTERNET NETRAL  ==
	echo.
	exit /b 0
)

:FLUSH (
	ipconfig /flushdns > nul
	ipconfig /release > nul
	ipconfig /renew > nul
	exit /b 0
)
endlocal