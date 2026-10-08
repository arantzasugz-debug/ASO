#!/bin/bash


if [[ $# -eq 0 ]]; then
 echo "Uso: $0 de password"
 exit 1
fi

pasw="$1"
segura=true
re1='.{12,}'
re2='[0-9]'
re3='[A-Z]'
re4='[^a-zA-Z0-9]'

if [[ "$pasw" =~ $re1 ]]; then 
    echo "Tiene al menos 12 caracteres: si"
else 
     echo "Tiene al menos 12 caracteres: no"
     segura=false
fi

if [[ "$pasw" =~ $re2 ]]; then
    echo "contiene algun digito: si"
else 
    echo "contiene algun digito: no"
    segura=false
fi

if [[ "$pasw" =~ $re3 ]]; then
     echo "Contiene alguna mayúscula: si"
else 
     echo "Contiene alguna mayúscula: no"
     segura=false
fi

if [[ "$pasw" =~ $re4 ]]; then
     echo "Contiene algún símbolo: si"
else
     echo "Contiene algún símbolo: no"
     segura=false
fi

if grep -i -w "$pasw" /usr/share/dict/spanish >/dev/null 2>&1; then
    echo "No es una palabra del diccionario: no"
    segura=false
else
    echo "No es una palabra del diccionario: sí"
fi

if [[ "$segura" = true ]]; then
     echo "La contraseña es segura"
else
     echo "La contraseña no es segura"
fi

#Pregunta: Caminas2026! cumple todas las condiciones. #¿Te parece realmente una contraseña segura?
#No realmente.
#¿Por qué? Responde en un comentario al final del script.
#Apesar de que cumple las indicaciones del script, porque herramientas de hacking prueban palabras comunes con el año en curso y signos al final por lo que es facil de descifrar. 
