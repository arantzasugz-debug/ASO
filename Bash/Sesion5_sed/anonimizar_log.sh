#!/bin/bash


if [[ $# -eq o ]]; then
     echo "Uso: $0 de fichero de registro"
     exit 1
fi


sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/x.x.x.x/' "$1" > copia_accesos.log