setlocal enabledelayedexpansion

Rem delete existing uninstall_liquidshca_deps.bat file
if exist "uninstall_liquidshca_deps.bat" (
    del "uninstall_liquidshca_deps.bat"
)

Rem check if SSL certificate (pypicert.pem) exists in the %appdata%\G2-IS\LiquidsHCA folder
if exist "%appdata%\G2-IS\LiquidsHCA\pypicert.pem" (set PYPICERT_EXIST=0) else (set PYPICERT_EXIST=1)

Rem check and write if Gas HCA installed, so that skip uninstalling evoleap_licensing and its dependency python packages
>>  "%cd%\uninstall_liquidshca_deps.bat" Echo;pip show hcapy
>>  "%cd%\uninstall_liquidshca_deps.bat" Echo;if %%errorlevel%% NEQ 0 (set GASHCA_EXIST=1) else (set GASHCA_EXIST=0)

pip show reportlab
if !errorlevel! NEQ 0 (
   call :pip_install reportlab 3.5.59
)

pip show dataclasses
if !errorlevel! NEQ 0 (
    call :pip_install dataclasses 0.6
)
pip show pytz
if !errorlevel! NEQ 0 (
    call :pip_install pytz 2019.3
)

pip show pywin32
if !errorlevel! NEQ 0 (
    call :pip_install pywin32 227
)

pip show pycryptodome
if !errorlevel! NEQ 0 (
    call :pip_install pycryptodome 3.9.9
)

pip show evoleap_licensing
if !errorlevel! NEQ 0 (
    call :pip_install_evoleap
)

pip show azure
if !errorlevel! NEQ 0 (
    >>  "%cd%\uninstall_liquidshca_deps.bat" Echo;powershell "pip list | Select-String -Pattern azure | where-object { pip uninstall -y $_.ToString().Split(' ')[0] }"
    >>  "%cd%\uninstall_liquidshca_deps.bat" Echo;powershell Remove-Item Lib\site-packages\azure -Recurse
    call :pip_install_azure azure 4.0.0
    call :pip_install_azure azure-batch 6.0.0
)

goto end

:pip_install
    if %%PYPICERT_EXIST%% EQU 0 (pip install %~1==%~2 --cert "%appdata%\G2-IS\LiquidsHCA\pypicert.pem") else (pip install %~1==%~2)
    >>  "%cd%\uninstall_liquidshca_deps.bat" Echo;if %%GASHCA_EXIST%% NEQ 0 (pip uninstall %~1 -y)
    EXIT /B 0

:pip_install_evoleap
    if %%PYPICERT_EXIST%% EQU 0 ( pip install  ..\Lib\site-packages\liquidshca\packages\evoleap_licensing-1.1.0.tar.gz --cert "%appdata%\G2-IS\LiquidsHCA\pypicert.pem") else (pip install  ..\Lib\site-packages\liquidshca\packages\evoleap_licensing-1.1.0.tar.gz)
    >>  "%cd%\uninstall_liquidshca_deps.bat" Echo;if %%GASHCA_EXIST%% NEQ 0 (pip uninstall evoleap_licensing -y)
    EXIT /B 0


:pip_install_azure
    if %%PYPICERT_EXIST%% EQU 0 ( pip install %~1==%~2 --cert "%appdata%\G2-IS\LiquidsHCA\pypicert.pem") else (pip install %~1==%~2)
    EXIT /B 0

:end
    EXIT 0