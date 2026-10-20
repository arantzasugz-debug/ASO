#!/bin/bash


archivo="$1"

if [[ $# -eq 1 ]]; then
 echo "Uso: $0 de fichero de configuracion"
 exit 1
fi

if [[ ! -f "$archivo" ]]; then
     echo "Error: el fichero '$archivo' no existe"
     exit 1
fi 

sed -E '/^#|^$/d' "$archivo"   

