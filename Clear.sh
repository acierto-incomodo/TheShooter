#!/bin/bash

# Array de carpetas a eliminar
folders=("build" "dist" "downloads" "game")

# Array de archivos a eliminar
files=("main.spec")

# Eliminar carpetas si existen
for folder in "${folders[@]}"; do
    if [ -d "$folder" ]; then
        echo "Eliminando carpeta: $folder"
        rm -rf "$folder"
    else
        echo "No existe la carpeta: $folder"
    fi
done

# Eliminar archivos si existen
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Eliminando archivo: $file"
        rm -f "$file"
    else
        echo "No existe el archivo: $file"
    fi
done

echo "Proceso completado."
