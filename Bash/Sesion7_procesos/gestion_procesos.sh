#!/bin/bash

#pide el nombre de usuario y comprueba que existe (id) antes
#de mostrar sus procesos con ps.

validar_pid() {
local pid="$1"
if [[ "$pid" =~ $re ]] && ps -p "$pid" > /dev/null 2>&1; then
    return 0
else
    return 1
fi

}

listar_usuario() {
   read -p "Introduce el nombre de usuario: " usuario
   if id "$usuario" >/dev/null 2>&1; then
       echo "Procesos de usuario $usuario:"
       ps -u "$usuario"
   else
       echo "Error: el usuario '$usuario' no existe."
   fi
}

buscar_procesos() {
 read -p "introduce el nombre del Proceso: " nombre
 local procesos=$(ps -eo pid,user,%cpu,comm | grep -i "$nombre" | grep -v "grep")
    if [ -z "$procesos" ]; then 
       echo "No se han encontrado procesos de $nombre"
    else 
       echo "PID USER %CPU COMMAND"
       echo "$procesos"
    fi
}

re='^[0-9]+$'
top_cpu() {
 read -p "Introduce el numero de procesos a mostrar (por defecto 5): " n
  if [ -z "$n" ]; then
    n=5
   fi   
   
   if [ "$n" =~ $re ]; then 
        ps -eo pid,user,%cpu,comm --sort=-%cpu | head -n $((n + 1))
   else 
        echo "ERROR: '$n' no es un numero valido"
   fi

}

re2='^-?[0-9]+$'

cambiar_prioridad() {
read -p "Introduce el PID: " pid
if ! validar_pid "$pid"; then
    echo "ERROR: el proceso $pid no existe o no es un numero"
    return
fi

read -p "Introduce el nuevo valor nice: " nice_val
if ! [[ "$nice_val" =~ $re2 ]]; then
        echo "ERROR: el valor nice debe ser un número entero."
        return
    fi

if [[ $EUID -eq 0 ]]; then 
    if [ "$nice_val" -lt -20 ] || [ "$nice_val" -gt 19 ]; then
       echo "ERROR: el valor debe estar entre -20 y 19"
       return
    fi
else
    if [ "$nice_val" -lt 0 ] || [ "$nice_val" -gt 19 ]; then
       echo "ERROR: el valor debe estar entre 0 a 19"
       return
    fi
fi

local comando=$(ps -p "$pid" -o comm=)

renice "$nice_val" "$pid" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Prioridad del proceso $pid ($comando) cambiada a $nice_val correctamente."
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Cambio de prioridad: PID $pid ($comando) a nice $nice_val" >> ~/gestion_procesos.log
    else
        echo "ERROR: No se pudo cambiar la prioridad con renice."
    fi

}

finalizar_proceso() {
read -p "Introduce el PID del proceso a finalizar: " pid

if ! validar_pid "$pid"; then
        echo "ERROR: el proceso $pid no existe o no es un numero"
        return
    fi

local nombre_cmd=$(ps -p "$pid" -o comm=)

    read -p "¿Finalizar $pid ($nombre_cmd)? (s/n): " confirmacion
    if [[ "$confirmacion" =~ ^[sS]$ ]]; then
        # Enviar SIGTERM
        kill -SIGTERM "$pid" 2>/dev/null
        sleep 3

        # Comprobar si sigue vivo
        if ps -p "$pid" > /dev/null 2>&1; then
            # Si sigue vivo, enviar SIGKILL
            kill -SIGKILL "$pid" 2>/dev/null
            echo "Proceso $pid finalizado con SIGKILL"
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Proceso $pid ($nombre_cmd) finalizado con SIGKILL" >> ~/gestion_procesos.log
        else
            echo "Proceso $pid finalizado con SIGTERM"
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Proceso $pid ($nombre_cmd) finalizado con SIGTERM" >> ~/gestion_procesos.log
        fi
    else
        echo "Operación cancelada."
    fi
}

while  true; do
     echo "===== GESTIÓN DE PROCESOS ====="
     echo "1) Listar los procesos de un usuario"
     echo "2) Buscar un proceso por nombre"
     echo "3) Mostrar los N procesos que más CPU consumen"
     echo "4) Cambiar la prioridad de un proceso"
     echo "5) Finalizar un proceso"
     echo "6) Salir"
     read -p "Introduzca la opcion: " opcion

     case $opcion in 
         1) listar_usuario;;
         2) buscar_procesos;;
         3) top_cpu;;
         4) cambiar_prioridad ;;
         5) finalizar_proceso ;;
         6) echo "Saliendo del gestor de procesos..."; exit 0 ;;
         *) echo "ERROR: opcion no reconocida" ;;
     esac
done