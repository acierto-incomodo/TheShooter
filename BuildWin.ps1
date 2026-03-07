Clear.ps1
cp main.py launcher_win.py
python -m PyInstaller --onefile --windowed --noconsole --icon=icono.ico launcher_win.py
python -m PyInstaller --onefile --windowed --noconsole --icon=icono.ico installer_updater.py
echo 1.1.0 > version_win_launcher.txt