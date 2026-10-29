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
   read - p "Introduce el nombre de usuario" usuario
   if id "$usuario" >/dev/null 2>&1; then
       ps -u "$usuario"
   else
       echo "Error: el usuario '$usuario' no existe."
   fi
}

buscar_procesos() {
 read -p "introduce el nombre del Proceso: " nombre
 procesos=$(ps -eo pid,user,%cpu,comm | grep -i "$nombre" | grep -v "grep")
    if [[ -z "$procesos" ]]; then 
       echo "No se han encontrado procesos de $nombre"
    else 
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

re='^-?[20 -19]+$'

cambiar_prioridad() {
read -p "Introduce el PID" pid
if ! validar_pid "$pid"; then
    echo "ERROR: el proceso $pid no existe o no es un numero"
    return
fi

read -p "Introduce el nuevo valor nice" nice_val
if [[ ! $EUID -eq 0 ]]; then 
    if [ "$nice_val" -lt -20 ] || [ "$nice_val" -gt 19 ]; then
       echo "ERROR: el valor debe estar entre -20 y 19"
       continue
    fi
else
    if [ "$nice_val" -lt 0 ] || [ "$nice_val" -gt 19 ]; then
       echo "ERROR: el valor debe estar entre 0 a 19"
       continue
fi

comando=$(ps -p "$pid" -o comm=)

}

finalizar_proceso() {

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
6) echo "Saliendo del gestor de procesos:"; exit  ;;
*) echo "ERROR: opcion no reconocida" ;;
esac
done