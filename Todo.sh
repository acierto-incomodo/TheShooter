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

# Ejecutar BuildDev.sh
if [ -f "./BuildDev.sh" ]; then
    bash ./BuildDev.sh
    echo "BuildDev.sh ejecutado correctamente."
else
    echo "BuildDev.sh no encontrado."
fi

echo "Todos los scripts se han ejecutado."
