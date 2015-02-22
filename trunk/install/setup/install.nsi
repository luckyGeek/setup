NAME "Geek and Poke"
!define PRODUCT "${project.artifactId}"
!define VERSION "${project.version}"

!define URLInfoAbout "https://sourceforge.net/p/luckygeek/home/Home/"
!define YourName "ctvoigt+chripo2701"


;Installer icon
!define MUI_ICON "lg.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\box-uninstall.ico"

;Headericon
!define MUI_WELCOMEFINISHPAGE_BITMAP "install_sidebar.bmp"

!include "MUI.nsh"

!define HAVE_UPX

!ifdef HAVE_UPX
!packhdr tmp.dat "upx -9 tmp.dat"
!endif

CRCCheck On


OutFile "${project.artifactId}-${VERSION}.exe"
BRANDINGTEXT "(c)2011-2013 ${project.artifactId}"


InstallDir "$PROGRAMFILES\${PRODUCT}"
InstallDirRegKey HKCU "Software\${PRODUCT}" ""


!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_LICENSE "LICENSE"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!define MUI_ABORTWARNING

!insertmacro MUI_LANGUAGE "English"

Section "section_1" section_1
SetOutPath "$INSTDIR"

FILE "*"
FILE /r "*"
createShortCut "$DESKTOP\luckyGeek.lnk" "$INSTDIR\run.bat" "" "$INSTDIR\lg.ico"
MessageBox MB_ICONINFORMATION|MB_OK "Answer next dialog with Y if you use UAC and want to run luckyGeek as normal user."
ExecWait  'cacls * /T /G Everyone:F'
ExecWait  'cacls * /T /G Jeder:F'
;shold not be necessary with new planned folder structure
Delete "$INSTDIR\install_sidebar.bmp"
Delete "$INSTDIR\install.nsi"
SectionEnd

Section Icons
# Insert here your Icons
CreateDirectory "$SMPROGRAMS\${PRODUCT}"
createShortCut "$SMPROGRAMS\luckyGeek\luckyGeek.lnk" "$INSTDIR\run.bat" "" "$INSTDIR\lg.ico"
SectionEnd

Section Uninstaller
 CreateShortCut "$SMPROGRAMS\${PRODUCT}\Uninstall.lnk" "$INSTDIR\uninst.exe" "" "$INSTDIR\uninst.exe" 0
 WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "DisplayName" "${PRODUCT} ${VERSION}"
 WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "DisplayVersion" "${VERSION}"
 WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "URLInfoAbout" "${URLInfoAbout}"
 WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "Publisher" "${YourName}"
 WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "UninstallString" "$INSTDIR\Uninst.exe"
 WriteRegStr HKCU "Software\${PRODUCT}" "" $INSTDIR
 WriteUninstaller "$INSTDIR\Uninst.exe"
SectionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "${PRODUCT} was removed."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure to remove ${PRODUCT}?" IDYES +2
  Abort
FunctionEnd

Section "Uninstall"


Delete "$INSTDIR\*.*"
Delete "$DESKTOP\luckyGeek.lnk"
Delete "$SMPROGRAMS\${PRODUCT}\*.*"
RmDir "$SMPROGRAMS\${PRODUCT}"
DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\${PRODUCT}"
DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}"
RMDir /r "$INSTDIR"
DeleteRegKey /ifempty HKCU "Software\${PRODUCT}"

SetShellVarContext all

Delete "$INSTDIR\*.*"

Delete "$DESKTOP\luckyGeek.lnk"
Delete "$SMPROGRAMS\${PRODUCT}\*.*"
RmDir "$SMPROGRAMS\${PRODUCT}"
DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\${PRODUCT}"
DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}"
RMDir /r "$INSTDIR"
DeleteRegKey /ifempty HKCU "Software\${PRODUCT}"

SectionEnd
