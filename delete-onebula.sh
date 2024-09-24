#!/bin/bash

# Script para desinstalar OpenNebula en Ubuntu 22.04
# ¡Asegúrate de ejecutar este script como root o usando sudo!

echo "=== Deteniendo los servicios de OpenNebula ==="
systemctl stop opennebula
systemctl stop opennebula-sunstone

echo "=== Desinstalando paquetes de OpenNebula ==="
apt-get purge -y opennebula opennebula-sunstone opennebula-flow opennebula-gate opennebula-novnc

echo "=== Eliminando paquetes no necesarios ==="
apt-get autoremove -y

echo "=== Eliminando archivos de configuración ==="
rm -rf /etc/one

echo "=== Eliminando directorios de almacenamiento ==="
rm -rf /var/lib/one


echo "=== Eliminando usuario y grupo oneadmin ==="
userdel -r oneadmin 2>/dev/null
groupdel oneadmin 2>/dev/null

echo "=== Recargando los demonios del sistema ==="
systemctl daemon-reload

echo "=== OpenNebula ha sido desinstalado correctamente. ==="
