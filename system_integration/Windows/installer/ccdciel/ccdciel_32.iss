; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!
 
[Setup]
ArchitecturesInstallIn64BitMode=x64
AppName=CCDciel
AppVerName=CCDciel V3
AppPublisherURL=http://sourceforge.net/projects/ccdciel
AppSupportURL=http://sourceforge.net/projects/ccdciel
AppUpdatesURL=http://sourceforge.net/projects/ccdciel
DefaultDirName={commonpf32}\CCDciel
UsePreviousAppDir=false
DefaultGroupName=CCDciel
AllowNoIcons=true
InfoBeforeFile=Presetup\readme.txt
OutputDir=.\
OutputBaseFilename=ccdciel-windows-x32
Compression=lzma
SolidCompression=true
Uninstallable=true
UninstallLogMode=append
DirExistsWarning=no
ShowLanguageDialog=yes
WizardStyle=modern
AppID={{6570df38-f18f-11e4-9532-fb2d36b55e00}

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}

[Files]
Source: Data\ccdciel.exe; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace; AfterInstall: UpdateFirewallRules
Source: Data\exiv2.exe; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\FPack.exe; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\Funpack.exe; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\cfitsio.dll; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\libccdcielwcs.dll; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\libeay32.dll; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\libexpat.dll; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\libpasraw.dll; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\ssleay32.dll; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\zlib1.dll; DestDir: {app}; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\data\*; DestDir: {app}\data; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\doc\*; DestDir: {app}\doc; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;
Source: Data\scripts\*; DestDir: {app}\scripts; Flags: ignoreversion recursesubdirs createallsubdirs restartreplace;

[Icons]
Name: {group}\CCDciel; Filename: {app}\ccdciel.exe; WorkingDir: {app}
Name: {commondesktop}\CCDciel; Filename: {app}\ccdciel.exe; WorkingDir: {app}; Tasks: desktopicon
 
[Code]
{Uninstall previous version to avoid 32bit/64bit mismatch}
function GetUninstallString: string;
var
  sUnInstPathWOW64,sUnInstPath: string;
  sUnInstallString: String;
begin
  Result := '';
  sUnInstallString := '';
  sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{{6570df38-f18f-11e4-9532-fb2d36b55e00}_is1'); 
  sUnInstPathWOW64 := ExpandConstant('Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{{6570df38-f18f-11e4-9532-fb2d36b55e00}_is1'); 
  if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
    if not RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString) then 
    if not RegQueryStringValue(HKLM, sUnInstPathWOW64, 'UninstallString', sUnInstallString) then
    RegQueryStringValue(HKCU, sUnInstPathWOW64, 'UninstallString', sUnInstallString);
  Result := sUnInstallString;
end;

function IsUpgrade: Boolean;
begin
  Result := (GetUninstallString() <> '');
end;

function InitializeSetup: Boolean;
var
  iResultCode: Integer;
  sUnInstallString: string;
begin
  Result := True; { in case when no previous version is found }
  if IsUpgrade then  
  begin
      sUnInstallString := GetUninstallString();
      sUnInstallString :=  RemoveQuotes(sUnInstallString);
      Exec(ExpandConstant(sUnInstallString), '/SILENT', '', SW_SHOW, ewWaitUntilTerminated, iResultCode);
      Result := True; 
  end;
end;

procedure UpdateFirewallRules();
var
  ResultCode: Integer;
begin
  Exec('netsh.exe', 'advfirewall firewall delete rule name="CCDciel" dir=in program=' + AddQuotes(ExpandConstant('{app}\ccdciel.exe')), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('netsh.exe', 'advfirewall firewall add rule name="CCDCiel" dir=in action=block program=' + AddQuotes(ExpandConstant('{app}\ccdciel.exe')) + ' profile=public,Domain', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Exec('netsh.exe', 'advfirewall firewall add rule name="CCDCiel" dir=in action=allow program=' + AddQuotes(ExpandConstant('{app}\ccdciel.exe')) + ' profile=private', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;
