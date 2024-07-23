#!/bin/bash

# Variables
ZABBIX_SERVER_IP="165.232.131.134"
HOSTNAME=$(hostname)
CONFIG_FILE="/etc/zabbix/zabbix_agent2.conf"

# Instalar el repositorio de Zabbix
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu22.04_all.deb
dpkg -i zabbix-release_6.4-1+ubuntu22.04_all.deb
apt update

# Instalar Zabbix agent2
apt install -y zabbix-agent2 zabbix-agent2-plugin-*

# Modificar ListenPort, Server, ServerActive y Hostname en el archivo de configuración
sed -i "s/^ListenPort=.*/ListenPort=10050/" $CONFIG_FILE
sed -i "s/^Server=.*/Server=${ZABBIX_SERVER_IP}/" $CONFIG_FILE
sed -i "s/^ServerActive=.*/ServerActive=${ZABBIX_SERVER_IP}/" $CONFIG_FILE
sed -i "s/^Hostname=.*/Hostname=${HOSTNAME}/" $CONFIG_FILE

# Reiniciar el servicio de Zabbix Agent 2 y habilitar en el arranque del sistema
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2

# Verificar estado del servicio
systemctl status zabbix-agent2
