#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "Uso: $0 de fichero"
  exit 1
fi

sed -E 's/@(gmail|hotmail)\.com$/@alu.edu.gva.es/' correo.txt