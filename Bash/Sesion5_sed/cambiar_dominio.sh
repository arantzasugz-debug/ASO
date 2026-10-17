#!/bin/bash

if [[ $# -eq 1 ]]; then
  echo "Uso: $0 de fichero"
  exit 1
fi
fichero="$1"

if [[ ! -f "$fichero" ]]; then
   echo "Error: El fichero '$fichero' no existe."
   exit 1
fi

sed -E 's/@(gmail|hotmail)\.com$/@alu.edu.gva.es/g' correo.txt