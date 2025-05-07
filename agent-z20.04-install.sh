#!/bin/bash

# Variables
ZABBIX_REPO_URL="https://repo.zabbix.com/zabbix/7.2/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.2+ubuntu20.04_all.deb"
ZABBIX_REPO_PKG="zabbix-release_latest_7.2+ubuntu20.04_all.deb"
ZABBIX_SERVER_IP="165.232.131.134"
CONFIG_FILE="/etc/zabbix/zabbix_agentd.conf"
HOSTNAME=$(hostname)

# 1. Actualizar lista de paquetes
apt update -y

# 2. Descargar e instalar el repositorio de Zabbix 7.2 para Ubuntu 20.04
wget "$ZABBIX_REPO_URL" -O "/tmp/$ZABBIX_REPO_PKG"
dpkg -i "/tmp/$ZABBIX_REPO_PKG"

# 3. Actualizar luego de agregar el repositorio
apt update -y

# 4. Instalar Zabbix Agent (clásico)
apt install -y zabbix-agent

# 5. Configurar el agente
sed -i "s/^Server=.*/Server=${ZABBIX_SERVER_IP}/" "$CONFIG_FILE"
sed -i "s/^ServerActive=.*/ServerActive=${ZABBIX_SERVER_IP}/" "$CONFIG_FILE"
sed -i "s/^Hostname=.*/Hostname=${HOSTNAME}/" "$CONFIG_FILE"
sed -i "s/^# ListenPort=.*/ListenPort=10050/" "$CONFIG_FILE"
sed -i "s/^# ListenIP=.*/ListenIP=0.0.0.0/" "$CONFIG_FILE"

# 6. Reiniciar y habilitar el agente
systemctl restart zabbix-agent
systemctl enable zabbix-agent

# 7. Verificar estado y puerto
systemctl status zabbix-agent --no-pager
ss -tuln | grep 10050
