#!/bin/bash

re='.+@(alu\.)?edu\.gva\.es$'
if [[ $# -eq 0 ]]; then
    echo"Uso: $0 direccion_de_correo"
    exit 1
fi

email="$1"


if [[ $email =~ $re ]]; then 
    if [[ $email == *"@alu."* ]]; then
        echo "$1 es una cuenta de alumno"
    else 
         echo "$1 es una cuenta de profesorado"
    fi
else 
    echo "$1 no es una cuenta educativa"
fi
