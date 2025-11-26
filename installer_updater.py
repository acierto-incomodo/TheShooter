#!/usr/bin/env python3
import sys
import os
import requests
import subprocess
from pathlib import Path
from threading import Thread
from PySide6 import QtCore, QtWidgets, QtGui

# ---------------- CONFIG ------------------

DOWNLOAD_DIR = Path.cwd() / "WinDownloads"
DOWNLOAD_DIR.mkdir(exist_ok=True)

LAUNCHER_EXE = DOWNLOAD_DIR / "The_Shooter_Launcher_Installer.exe"
VERSION_FILE = DOWNLOAD_DIR / "Version.txt"

URL_LAUNCHER = "https://github.com/acierto-incomodo/The-Shooter-Launcher/releases/latest/download/The_Shooter_Launcher_Installer.exe"
URL_VERSION  = "https://github.com/acierto-incomodo/The-Shooter-Launcher/releases/latest/download/Version.txt"

# ---------------- Utils -------------------

def download(url: str, dest: Path, progress_callback=None):
    resp = requests.get(url, stream=True, timeout=60)
    resp.raise_for_status()

    total = resp.headers.get("content-length")
    total = int(total) if total and total.isdigit() else None

    with open(dest, "wb") as f:
        downloaded = 0
        for chunk in resp.iter_content(chunk_size=8192):
            if not chunk:
                continue
            f.write(chunk)
            downloaded += len(chunk)
            if progress_callback:
                progress_callback(downloaded, total)

# ---------------- GUI ----------------------

class UpdaterWindow(QtWidgets.QWidget):

    def __init__(self):
        super().__init__()
        self.setWindowTitle("Launcher Updater")
        self.setMinimumSize(500, 200)
        self.setMaximumSize(500, 200)
        self.setWindowIcon(QtGui.QIcon.fromTheme("system-software-update"))

        self.setup_ui()
        self.start_check()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)

        # titulo
        title = QtWidgets.QLabel("Actualizando Launcher…")
        title.setAlignment(QtCore.Qt.AlignCenter)
        title.setStyleSheet("font-size:22px; font-weight:bold;")
        layout.addWidget(title)

        # estado
        self.status = QtWidgets.QLabel("Comprobando versión…")
        self.status.setAlignment(QtCore.Qt.AlignCenter)
        layout.addWidget(self.status)

        # barra de progreso
        self.progress = QtWidgets.QProgressBar()
        self.progress.setRange(0, 100)
        layout.addWidget(self.progress)

        # texto de versión
        self.version_display = QtWidgets.QLabel("", alignment=QtCore.Qt.AlignCenter)
        self.version_display.setStyleSheet("font-weight:bold; font-size:14px; margin-top:8px;")
        layout.addWidget(self.version_display)

        layout.addStretch()

    def set_status(self, text):
        self.status.setText(text)

    # ---------------- VERSION CHECK ----------------

    def start_check(self):
        Thread(target=self._check_thread, daemon=True).start()

    def _check_thread(self):
        try:
            resp = requests.get(URL_VERSION, timeout=30)
            resp.raise_for_status()
            remote_version = resp.text.strip()
        except Exception as e:
            QtCore.QMetaObject.invokeMethod(
                self, "show_error",
                QtCore.Qt.QueuedConnection,
                QtCore.Q_ARG(str, f"Error obteniendo versión: {e}")
            )
            return

        QtCore.QMetaObject.invokeMethod(
            self, "on_version_received",
            QtCore.Qt.QueuedConnection,
            QtCore.Q_ARG(str, remote_version)
        )

    @QtCore.Slot(str)
    def on_version_received(self, version):
        self.version_display.setText(f"Versión disponible: {version}")
        self.set_status("Descargando actualización…")
        Thread(target=self._download_all, daemon=True).start()

    # ---------------- DOWNLOAD ----------------

    def _download_all(self):
        try:
            # version file
            version_tmp = VERSION_FILE
            download(URL_VERSION, version_tmp)

            # launcher exe
            def progress_cb(downloaded, total):
                percent = int(downloaded * 100 / total) if total else 0
                QtCore.QMetaObject.invokeMethod(
                    self.progress, "setValue",
                    QtCore.Qt.QueuedConnection,
                    QtCore.Q_ARG(int, percent)
                )

            download(URL_LAUNCHER, LAUNCHER_EXE, progress_cb)

            QtCore.QMetaObject.invokeMethod(
                self, "install_done",
                QtCore.Qt.QueuedConnection
            )

        except Exception as e:
            QtCore.QMetaObject.invokeMethod(
                self, "show_error",
                QtCore.Qt.QueuedConnection,
                QtCore.Q_ARG(str, f"Error de descarga: {e}")
            )

    # ---------------- DONE ----------------

    @QtCore.Slot()
    def install_done(self):
        self.set_status("Instalación completada. Iniciando launcher…")
        self.progress.setValue(100)

        try:
            os.startfile(str(LAUNCHER_EXE))
        except Exception as e:
            self.show_error(f"No se pudo ejecutar el launcher: {e}")
            return

        QtCore.QTimer.singleShot(1500, self.close)

    @QtCore.Slot(str)
    def show_error(self, msg):
        self.set_status(msg)

# ---------------- MAIN ----------------------

def main():
    app = QtWidgets.QApplication(sys.argv)
    w = UpdaterWindow()
    w.show()
    sys.exit(app.exec())

if __name__ == "__main__":
    main()
