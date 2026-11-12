#!/bin/bash

# Comprobar si se pasa la carpeta remota como parámetro
if [[ $# -ne 1 ]]; then
    echo "Uso: $0 carpeta_remota"
    exit 1
fi

CARPETA_REMOTA="$1"
DESTINO_BASE="$HOME/backups/espejo"

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

mkdir -p "$DESTINO_BASE"

# Ejecución de la copia con scp
if rsync -av "servidor:$CARPETA_REMOTA/" "$DESTINO_BASE/"; then
    echo "$(date '+%F %T') - Éxito al sincronizar $CARPETA_REMOTA a espejo" >> "$HOME/backups/backup.log"
    echo "Sincronizacion rsync realizada con éxito."
else
    echo "$(date '+%F %T') - Error al sincronizar $CARPETA_REMOTA" >> "$HOME/backups/backup.log"
    echo "Error durante la sincronizacion con rsync."
    exit 1
fi

