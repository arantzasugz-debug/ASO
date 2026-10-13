#!/bin/bash


archivo="$1"

if [[ $# -eq 0 ]]; then
 echo "Uso: $0 de fichero de configuracion"
 exit 1
fi

if [[ ! -f $1 ]]; then
     echo "Error el fichero '$archivo' no existe"
     exit 1
elif
    sed -E '/^#|^$/d' "$archivo"   
fi

