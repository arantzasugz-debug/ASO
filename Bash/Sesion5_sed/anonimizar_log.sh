#!/bin/bash

fichero="$1"
if [[ $# -eq o ]]; then
     echo "Uso: $0 de fichero de registro"
     exit 1
fi

if [ ! -f "$fichero" ]; then
      echo "Error: El fichoro '$1' no existe."
      exit 1
fi

fichero_salida="${$fichero}.anonimo"
sed -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/x.x.x.x/' "$1" > copia_accesos.log

echo "Fichero anonimizado: $fichero_salida"