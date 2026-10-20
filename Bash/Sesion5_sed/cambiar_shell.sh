#!/bin/bash

usuario=$1
shell=$2
fichero="Passwd"

if [[ $# -eq 2 ]]; then
 echo "Uso: $0 de parametros"
 exit 1
fi

if [ ! -f "$fichero" ]; then 
     echo "Error: no se encuentra el fichero '$fichero' en la carpeta actual."
     exit 1 
fi


re='^/bin/(bash|sh|zsh)$'

if ! [[ $shell =~ $re]]; then 
     echo "Error: la shell debe ser /bin/bash, /bin/sh o /bin/zsh"
     exit 1
fi

sed -i.bak '/^usuario:/s|:[^:]*$)|:$shell|' "$fichero"

grep -E "^$usuario:" "$fichero"

# En un sistema real, ¿se cambiaría la shell editando /etc/passwd con sed? 
# ¿Qué comando se usa normalmente?
#Respuesta: no, en un sistema real no se cambiaria la shell editando /etc/passwd directamente con sed.
#es peligroso porque puede corromper la estructura del fichero.

#comandos a utilizar:
#chsh - cambia la shell de forma controlada. (chsh -s /bin/zsh usuario).
#usermod - como administrador del sistema. (sudo usermod -s /bin/zsh usuario)