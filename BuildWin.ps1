Clear.bat
cp main.py launcher_win.py
python -m PyInstaller --onefile --windowed --noconsole --icon=logo.ico launcher_win.py
python -m PyInstaller --onefile --windowed --noconsole --icon=logo.ico installer_updater.py
echo 1.0.5 > version_win_launcher.txt