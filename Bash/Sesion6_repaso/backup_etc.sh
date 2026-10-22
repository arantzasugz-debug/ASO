#!/bin/bash

directorio="${1:-/var/backups}"
max_copia="${2:-7}"
re='^[0-9]+$'

if [ $# -gt 2 ]; then
     echo "Error: se espera como maximo 2 parametro" >&2
     exit 1
fi

registrar() {
    local mensaje="$1"
    local timestamp
    timestamp=$(date "+%F%T")
    echo "$timestamp $mensaje"
    logger -t aso-backup "$mensaje"
}

# Compruebo que el directorio de destino existe
if [[ ! -d "$directorio" ]]; then
     registrar "El directorio de destino $directorio no existe"
     exit 1
fi

if ! [[ "$max_copia" =~ $re ]]; then
     registrar "Error: $max_copia no es un numero"
     exit 1
fi

if (( max_copia <= 0 )); then 
     registrar "Error: el numero maximo de copias debe ser mayor que 0"
     exit 1
fi

fecha=$(date +"%Y%m%d-%H%M%S")
fichero_copia="$destino/etc-$fecha.tar.gz"

if tar -czf "$fichero_copia" /etc 2>/dev/null; then
     registrar "Copia creada: $fichero_copia"
else
     registrar "Error al crear la copia de seguridad"
     exit 1
fi

num=$(ls $directorio | grep -cE '^/etc-[0-9]{8}-[0-9]{6}\.tar.gz$')

if (( num > max_copia )); then
     registrar "Aviso: hay $num copias que el maximo recomendado es $max_copia"
fi



