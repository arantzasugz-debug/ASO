#!/bin/bash

accion=$1
re1='^[a-zA-Z]+$'
re2='^[a-zA-Z]+\ [a-zA-Z]+$'
re3='^alu[a-z]{5}$'

mostrar_error() {
    echo "Error: $1"
    echo "Uso: ./gestion_usuarios.sh alta | baja identificador"
    exit 1
}

generar_id() {
    local nom=$(echo "$1" | tr 'A-Z' 'a-z' | cut -c1-2)
    local ap1=$(echo "$2" | cut -d' ' -f1 | tr 'A-Z' 'a-z' | cut -c1-2)
    local ap2=$(echo "$2" | cut -d' ' -f2 | tr 'A-Z' 'a-z' | cut -c1-2 | cut -c1)
    echo "alu${nom}${ap1}${ap2}"
}

if [[ "$accion" == "alta" ]]; then
    read -p "Nombre: " nombre
    read -p "Apellidos: " apellidos

    if [[ ! "$nombre" =~ $re1 ]]; then
        mostrar_error "el nombre debe ser una sola palabra"
    fi
    if [[ ! "$apellidos" =~ $re2 ]]; then
        mostrar_error "escribe los dos apellidos separados por un espacio"
    fi

    id=$(generar_id "$nombre" "$apellidos")
    echo "Identificador generado: $id"

    if id "$id" &>/dev/null; then
        mostrar_error "el usuario $id ya existe"
    else
        echo "Para crearlo: sudo useradd -m -s /bin/bash -c \"$nombre $apellidos\" $id"
    fi

elif [[ "$accion" == "baja" ]]; then
    id=$2
    if [[ -z "$id" ]]; then
        mostrar_error "falta el identificador"
    fi
    if [[ ! "$id" =~ $re3 ]]; then
        mostrar_error "$id no tiene el formato aluXXYYZ"
    fi
    if ! id "$id" &>/dev/null; then
        mostrar_error "el usuario $id no existe"
    fi
    echo "Para borrarlo: sudo userdel -r $id"

else
    if [[ -z "$accion" ]]; then
        mostrar_error "falta la acción"
    else
        mostrar_error "la acción $accion no es válida"
    fi
fi