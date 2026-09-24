#!/bin/bash

contar_por_extension() {
local carpeta="$1"
local ext="$2"

local total=$(find "$carpeta" -maxdepth 1 -type f -name "*.$ext" | wc -l) 
echo "$total"
}

directorio="$HOME/ASO/Bash/prueba_bash/datos"

for ext in log txt csv; do
	 cantidad=$(contar_por_extension "$directorio" "$ext")
	 echo "$ext  $cantidad"
done


