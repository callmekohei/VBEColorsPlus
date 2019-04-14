@echo off
setlocal

rem ===========================================================================
rem  FILE    : VBEColorsPlus.cmd
rem  AUTHOR  : callmekohei <callmekohei at gmail.com>
rem  License : MIT license
rem ===========================================================================

rem --------------------------------------------------------
rem                        Hex values
rem --------------------------------------------------------
rem see also: dimitropoulos/VBECustomColors https://github.com/dimitropoulos/VBECustomColors

set fstSequence=ffffff00c0c0c0008080800000000000ff00000080000000ffff00008080000000ff00000080000000ffff00008080000000ff0000008000ff00ff0080008000
set sndSequence=00000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00
set vbe7Default=ffffff00c0c0c0008080800000000000ff00000080000000ffff00008080000000ff00000080000000ffff00008080000000ff0000008000ff00ff0080008000
set vs2012theme=000000001e1e1e00343a40003c424800d4d4d400ffffff00264f7800569cd60074b0df00794e8b009f74b100e5140000d69d8500ce917800608b4e00b5cea800

rem --------------------------------------------------------
rem                     Text from binary
rem --------------------------------------------------------
rem HEXRAW format is 12
certutil -f -encodehex VBE7.DLL tmpVBE.txt 12

rem --------------------------------------------------------
rem                  Modify VBE hex values
rem --------------------------------------------------------
set catFile="      (cat tmpVBE.txt) "
set replaceFst="   | %% { $_ -replace \"(.*?)%fstSequence%(.*)\", '$1 %vs2012theme%$2'} "
set replaceSnd="   | %% { $_ -replace \"(.*?)%sndSequence%(.*)\", '$1 %vs2012theme%$2'} "
set deleteSpaces=" | %% { $_ -replace '\s','' } "
set outputFile="   > tmpChangedVBE.txt "
powershell -Command %catFile% %replaceFst% %replaceSnd% %deleteSpaces% %outputFile%

rem --------------------------------------------------------
rem                     Binary from text
rem --------------------------------------------------------
certutil -f -decodehex tmpChangedVBE.txt VBE7.DLL 12

rem --------------------------------------------------------
rem                        Terminate
rem --------------------------------------------------------
del tmpVBE.txt
del tmpChangedVBE.txt

rem --------------------------------------------------------
rem                color setting in registory
rem --------------------------------------------------------

reg add HKEY_CURRENT_USER\software\microsoft\vba\7.1\common /v codebackcolors /t reg_sz /d "2 7 1 13 15 2 2 2 11 9 0 0 0 0 0 0" /f

reg add HKEY_CURRENT_USER\software\microsoft\vba\7.1\common /v codeforecolors /t reg_sz /d "13 5 12 1 6 15 8 5 1 1 0 0 0 0 0 0" /f

