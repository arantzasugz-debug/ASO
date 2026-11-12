#!/bin/bash

# Comprobar si se pasa la carpeta remota como parámetro
if [[ $# -ne 1 ]]; then
    echo "Uso: $0 carpeta_remota"
    exit 1
fi

CARPETA_REMOTA="$1"
DESTINO_BASE="$HOME/backups"

# Función para comprobar si el servidor responde sin pedir contraseña
verificar_servidor() {
    ssh -o BatchMode=yes servidor true 2>/dev/null
    return $?
}

# Verificación previa
if ! verificar_servidor; then
    echo "Error: El servidor no responde o pide contraseña."
    exit 1
fi

# Crear estructura y nombre de carpeta con fecha
FECHA=$(date +%F_%H-%M)
CARPETA_DESTINO="$DESTINO_BASE/datos_$FECHA"
mkdir -p "$CARPETA_DESTINO"

# Ejecución de la copia con scp
if scp -r "servidor:$CARPETA_REMOTA" "$CARPETA_DESTINO"; then
    echo "$(date '+%F %T') - Éxito al copiar $CARPETA_REMOTA a $CARPETA_DESTINO" >> "$DESTINO_BASE/backup.log"
    echo "Copia realizada con éxito."
else
    echo "$(date '+%F %T') - Error al copiar $CARPETA_REMOTA" >> "$DESTINO_BASE/backup.log"
    echo "Error durante la copia con scp."
    exit 1
fi

