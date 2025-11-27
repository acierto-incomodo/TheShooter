[Setup]
AppName=The Shooter Launcher by StormGamesStudios
AppVersion=1.0.2
DefaultDirName={userappdata}\StormGamesStudios\NewGameDir\TheShooterLauncher_New
DefaultGroupName=StormGamesStudios
OutputDir=C:\Users\mapsp\Documents\GitHub\TheShooter\output
OutputBaseFilename=The_Shooter_Launcher_Installer_New
Compression=lzma
SolidCompression=yes
AppCopyright=Copyright © 2025 StormGamesStudios. All rights reserved.
VersionInfoCompany=StormGamesStudios
AppPublisher=StormGamesStudios
SetupIconFile=logo.ico
VersionInfoVersion=1.0.2.0
DisableDirPage=yes
DisableProgramGroupPage=yes

[Files]
; Archivos del lanzador
Source: "C:\Users\mapsp\Documents\GitHub\TheShooter\dist\installer_updater.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\mapsp\Documents\GitHub\TheShooter\logo.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\mapsp\Documents\GitHub\TheShooter\logo.png"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Acceso directo en el escritorio
Name: "{userdesktop}\The Shooter Launcher New"; Filename: "{app}\installer_updater.exe"; IconFilename: "{app}\logo.ico"

; Acceso directo en el menú de inicio dentro de la carpeta StormLauncher_HMCL-Edition
Name: "{commonprograms}\StormGamesStudios\The Shooter Launcher New"; Filename: "{app}\installer_updater.exe"; IconFilename: "{app}\logo.ico"
Name: "{commonprograms}\StormGamesStudios\Desinstalar The Shooter Launcher New"; Filename: "{uninstallexe}"; IconFilename: "{app}\logo.ico"

[Registry]
; Guardar ruta de instalación para poder desinstalar
Root: HKCU; Subkey: "Software\The Shooter Launcher New"; ValueType: string; ValueName: "Install_Dir"; ValueData: "{app}"

[UninstallDelete]
; Eliminar carpeta del appdata y acceso directo
Type: filesandordirs; Name: "{app}"

[Run]
; Ejecutar el lanzador después de la instalación
Filename: "{app}\installer_updater.exe"; Description: "Ejecutar The Shooter Launcher New"; Flags: nowait postinstall skipifsilent
