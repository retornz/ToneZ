; ToneZ installer script, Copyright T0NIT0 RMX 2019.
; Based on Cabbage Installer Script, Copyright Rory Walsh 2017.
; Based on the Csound 6.09 Installer script by Mike Goggins. 

#define MyAppName "ToneZ_V2"
#define MyAppVersion "2.0.0"
#define MyAppPublisher "Retornz"
#define MyAppURL "https://www.retornz.com"
#define BuildDir "/x64"

;CHANGE THIS !!!
#define MyPluginName "ToneZ_V2"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{62E24904-48B8-4B69-AA1D-26B0A726CF87}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf64}\Steinberg\vstplugins
DisableProgramGroupPage=yes
LicenseFile= "Utils/LICENSE"
OutputBaseFilename=ToneZ_V2_x64_{#MyAppVersion}_Setup
SetupIconFile=Utils/ToneZ.ico
Compression=lzma
SolidCompression=yes
WizardSmallImageFile=Utils/ToneZbaneer.bmp
WizardImageFile=Utils/ToneZend.bmp
DisableDirPage=no
DisableReadyPage=yes
ChangesEnvironment=yes
UninstallFilesDir=C:\ProgramData\Retornz\{#MyPluginName}\data
DirExistsWarning=no
AppendDefaultDirName=no

[Types]
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "vst2"; Description: "VST plugin installation"; Types: custom;
Name: "vst3"; Description: "VST3 plugin installation"; Types: custom;


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"


[CustomMessages]
CustomMessage=Undefined //just in case (should be equal to English)
english.CustomMessage=No component selected 
french.CustomMessage=Aucun composent sélectionné

[Messages]
french.SelectDirLabel3=L'assistant va installer le plugin [name] dans le dossier suivant. Pour continuer, cliquez sur Suivant. Si vous souhaitez choisir un dossier différent, cliquez sur Parcourir.
french.SelectDirBrowseLabel=Plugin VST 64-bit
english.SelectDirLabel3=Setup will install [name] plugin into the following folder. To continue, click Next. If you would like to select a different folder, click Browse.
english.SelectDirBrowseLabel=64-bit VST plugin

[Files]
Source: "{#BuildDir}\{#MyPluginName}\*"; DestDir: "C:\ProgramData\Retornz\{#MyPluginName}\"; Flags: ignoreversion recursesubdirs; Components: vst2 vst3; Permissions: users-full;
Source: "{#BuildDir}/{#MyPluginName}.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: vst2; Permissions: users-full;
Source: "{#BuildDir}/csound64.dll"; DestDir: "C:\Program Files\Csound6_x64\bin"; Flags: ignoreversion; Components: vst2 vst3; Permissions: users-full;
Source: "Utils\Discord.bmp"; Components: vst2 vst3; Flags: dontcopy
Source: "{#BuildDir}/{#MyPluginName}.vst3\Contents\x86_64-win\*"; DestDir: "C:\Program Files\Common Files\VST3\{#MyPluginName}.vst3\Contents\x86_64-win\"; Flags: ignoreversion; Components: vst3; Permissions: users-full;

[Code]
//	ModPathName defines the name of the task defined above
//	ModPathType defines whether the 'user' or 'system' path will be modified;
//		this will default to user if anything other than system is set
//	setArrayLength must specify the total number of dirs to be added
//	Result[0] contains first directory, Result[1] contains second, etc.
const ModPathName = 'modifypath';
ModPathType = 'system';

function ModPathDir(): TArrayOfString;
begin
	setArrayLength(Result, 1);
	Result[0] := ExpandConstant('{pf64}\Csound6_x64\bin');
end;

procedure ModPath();
var
	oldpath:	String;
	newpath:	String;
	updatepath:	Boolean;
	pathArr:	TArrayOfString;
	aExecFile:	String;
	aExecArr:	TArrayOfString;
	i, d:		Integer;
	pathdir:	TArrayOfString;
	regroot:	Integer;
	regpath:	String;
begin

	// Get constants from main script and adjust behavior accordingly
	// ModPathType MUST be 'system' or 'user'; force 'user' if invalid
	if ModPathType = 'system' then begin
		regroot := HKEY_LOCAL_MACHINE;
		regpath := 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';
	end else begin
		regroot := HKEY_CURRENT_USER;
		regpath := 'Environment';
	end;

	// Get array of new directories and act on each individually
	pathdir := ModPathDir();
	for d := 0 to GetArrayLength(pathdir)-1 do begin
		updatepath := true;

		// Modify WinNT path
		if UsingWinNT() = true then begin

			// Get current path, split into an array
			RegQueryStringValue(regroot, regpath, 'Path', oldpath);
			oldpath := oldpath + ';';
			i := 0;

			while (Pos(';', oldpath) > 0) do begin
				SetArrayLength(pathArr, i+1);
				pathArr[i] := Copy(oldpath, 0, Pos(';', oldpath)-1);
				oldpath := Copy(oldpath, Pos(';', oldpath)+1, Length(oldpath));
				i := i + 1;

				// Check if current directory matches app dir
				if pathdir[d] = pathArr[i-1] then begin
					// if uninstalling, remove dir from path
					if IsUninstaller() = true then begin
						continue;
					// if installing, flag that dir already exists in path
					end else begin
						updatepath := false;
					end;
				end;

				// Add current directory to new path
				if i = 1 then begin
					newpath := pathArr[i-1];
				end else begin
					newpath := newpath + ';' + pathArr[i-1];
				end;
			end;

			// Append app dir to path if not already included
			if (IsUninstaller() = false) AND (updatepath = true) then
				newpath := newpath + ';' + pathdir[d];

			// Write new path
			RegWriteStringValue(regroot, regpath, 'Path', newpath);

		// Modify Win9x path
		end else begin

			// Convert to shortened dirname
			pathdir[d] := GetShortName(pathdir[d]);

			// If autoexec.bat exists, check if app dir already exists in path
			aExecFile := 'C:\AUTOEXEC.BAT';
			if FileExists(aExecFile) then begin
				LoadStringsFromFile(aExecFile, aExecArr);
				for i := 0 to GetArrayLength(aExecArr)-1 do begin
					if IsUninstaller() = false then begin
						// If app dir already exists while installing, skip add
						if (Pos(pathdir[d], aExecArr[i]) > 0) then
							updatepath := false;
							break;
					end else begin
						// If app dir exists and = what we originally set, then delete at uninstall
						if aExecArr[i] = 'SET PATH=%PATH%;' + pathdir[d] then
							aExecArr[i] := '';
					end;
				end;
			end;

			// If app dir not found, or autoexec.bat didn't exist, then (create and) append to current path
			if (IsUninstaller() = false) AND (updatepath = true) then begin
				SaveStringToFile(aExecFile, #13#10 + 'SET PATH=%PATH%;' + pathdir[d], True);

			// If uninstalling, write the full autoexec out
			end else begin
				SaveStringsToFile(aExecFile, aExecArr, False);
			end;
		end;
	end;
end;

// Split a string into an array using passed delimeter
procedure MPExplode(var Dest: TArrayOfString; Text: String; Separator: String);
var
	i: Integer;
begin
	i := 0;
	repeat
		SetArrayLength(Dest, i+1);
		if Pos(Separator,Text) > 0 then	begin
			Dest[i] := Copy(Text, 1, Pos(Separator, Text)-1);
			Text := Copy(Text, Pos(Separator,Text) + Length(Separator), Length(Text));
			i := i + 1;
		end else begin
			 Dest[i] := Text;
			 Text := '';
		end;
	until Length(Text)=0;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
	taskname:	String;
begin
	taskname := ModPathName;
	if CurStep = ssPostInstall then
			ModPath();
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
	aSelectedTasks:	TArrayOfString;
	i:				Integer;
	taskname:		String;
	regpath:		String;
	regstring:		String;
	appid:			String;
begin
	// only run during actual uninstall
	if CurUninstallStep = usUninstall then begin
		// get list of selected tasks saved in registry at install time
		appid := '{#emit SetupSetting("AppId")}';
		if appid = '' then appid := '{#emit SetupSetting("AppName")}';
		regpath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\'+appid+'_is1');
		RegQueryStringValue(HKLM, regpath, 'Inno Setup: Selected Tasks', regstring);
		if regstring = '' then RegQueryStringValue(HKCU, regpath, 'Inno Setup: Selected Tasks', regstring);

		// check each task; if matches modpath taskname, trigger patch removal
		if regstring <> '' then begin
			taskname := ModPathName;
			MPExplode(aSelectedTasks, regstring, ',');
			if GetArrayLength(aSelectedTasks) > 0 then begin
				for i := 0 to GetArrayLength(aSelectedTasks)-1 do begin
					if comparetext(aSelectedTasks[i], taskname) = 0 then
						ModPath();
				end;
			end;
		end;
	end;
end;

function NeedRestart(): Boolean;
var
	taskname:	String;
begin
	taskname := ModPathName;
	if IsTaskSelected(taskname) and not UsingWinNT() then begin
		Result := True;
	end else begin
		Result := False;
	end;
end;








procedure MyImageClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExec('open', 'https://www.retornz.com/redir/ToneZinstallerDiscord.html', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure CreateMyImage();
begin
  ExtractTemporaryFile('Discord.bmp');
  with TBitmapImage.Create(WizardForm) do
  begin
    Parent := WizardForm.FinishedPage;
    Bitmap.LoadFromFile(ExpandConstant('{tmp}\Discord.bmp'));
    AutoSize := True;
    Left := 220;
    Top := WizardForm.FinishedPage.Top + WizardForm.FinishedPage.Height - Height - 90;
    Cursor := crHand;
    OnClick := @MyImageClick;
  end;
end;







// link in installer footer
procedure URLLabelOnClick(Sender: TObject);
var
	ErrorCode: Integer;
begin
	ShellExecAsOriginalUser('open', '{#MyAppURL}', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure InitializeWizard;
var
	URLLabel: TNewStaticText;
begin
  CreateMyImage();
	URLLabel := TNewStaticText.Create(WizardForm);
	URLLabel.Caption := ExpandConstant('www.retornz.com');
	URLLabel.Cursor := crHand;
	URLLabel.OnClick := @URLLabelOnClick;
	URLLabel.Parent := WizardForm;
	URLLabel.Font.Style := URLLabel.Font.Style + [fsUnderline];
	URLLabel.Font.Color := clBlue;
	URLLabel.Top := WizardForm.ClientHeight - URLLabel.Height - 15;
	URLLabel.Left := ScaleX(20);
end;



procedure CurPageChanged(CurPageID: Integer);
begin
  // On fresh install the last pre-install page is "Select Program Group".
  // On upgrade the last pre-install page is "Read to Install"
  // (forced even with DisableReadyPage)
  if (CurPageID = wpSelectComponents) or (CurPageID = wpReady) then
    WizardForm.NextButton.Caption := SetupMessage(msgButtonInstall)
  // On the Finished page, use "Finish" caption.
  else if (CurPageID = wpFinished) then
    WizardForm.NextButton.Caption := SetupMessage(msgButtonFinish)
  // On all other pages, use "Next" caption.
  else
    WizardForm.NextButton.Caption := SetupMessage(msgButtonNext);
end;


function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = wpSelectComponents then
  begin
    if WizardSelectedComponents(False) = '' then
    begin
      MsgBox(ExpandConstant('{cm:CustomMessage}'), mbError, MB_OK);
      Result := False;
    end;
  end;
end;