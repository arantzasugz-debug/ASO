#!/bin/bash

re1='^127\.'
re2='^(10|192\.168\.|172\.(1[6-9]|2[0-9]|3[0-1]))\.'

if [[ "$1"  =~ $re1 ]]; then
    echo "$1 es una direccion loopback"
elif [[ "$1" =~ $re2 ]]; then
     echo "$1 es una direccion privada"
else
     echo "$1 es una direccion publica"
fi

