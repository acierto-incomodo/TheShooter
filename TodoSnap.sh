#!/bin/bash

# Ejecutar Clear.sh
if [ -f "./Clear.sh" ]; then
    bash ./Clear.sh
    echo "Clear.sh ejecutado correctamente."
else
    echo "Clear.sh no encontrado."
fi

# Ejecutar BuildLinux.sh
if [ -f "./BuildLinux.sh" ]; then
    bash ./BuildLinux.sh
    echo "BuildLinux.sh ejecutado correctamente."
else
    echo "BuildLinux.sh no encontrado."
fi

# Ejecutar BuildSnap.sh
if [ -f "./BuildSnap.sh" ]; then
    bash ./BuildSnap.sh
    echo "BuildSnap.sh ejecutado correctamente."
else
    echo "BuildSnap.sh no encontrado."
fi

echo "Todos los scripts se han ejecutado."
