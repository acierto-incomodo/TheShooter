Clear.ps1
cp main.py launcher_win.py
python -m PyInstaller --onefile --windowed --noconsole --icon=logo_new.ico launcher_win.py
python -m PyInstaller --onefile --windowed --noconsole --icon=logo_new.ico installer_updater.py
echo 1.0.8 > version_win_launcher.txt