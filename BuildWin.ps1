.\Clear.ps1
cp main.py Fusion_Arena_Launcher_Portable.py
python -m PyInstaller --onefile --windowed --noconsole --icon=download-icon.ico --add-data "download-icon.png:." launcher_win.py
python -m PyInstaller --onefile --windowed --noconsole --icon=icono.ico Fusion_Arena_Launcher_Portable.py
python -m PyInstaller --onefile --windowed --noconsole --icon=icono.ico installer_updater.py
echo 1.1.2 > version_win_launcher.txt