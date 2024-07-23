#!/bin/bash

# Verifica si el archivo /etc/cpupdate.conf no existe
if [ ! -f /etc/cpupdate.conf ]; then
    # Si no existe, crea el archivo y agrega la línea para la versión LTS
    echo 'CPANEL=lts' | sudo tee /etc/cpupdate.conf
fi

# Mensaje indicando el inicio de la descarga e instalación de WHM
echo 'Descargando e instalando la última versión de WHM...'

# Cambia al directorio /home
cd /home

# Descarga el instalador de WHM y lo guarda como 'latest'
curl -o latest -L https://securedownloads.cpanel.net/latest

# Ejecuta el instalador de WHM con permisos de superusuario
sudo sh latest

# Mensaje indicando la finalización de la instalación y configuración de WHM
echo 'Instalación y configuración de WHM completadas.'
