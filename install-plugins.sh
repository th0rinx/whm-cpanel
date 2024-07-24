#!/bin/bash

# Descargar e instalar Softaculous
wget -N http://files.softaculous.com/install.sh
chmod 755 install.sh
./install.sh

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo apt update && sudo apt upgrade -y

# Instalar CSF
echo "Instalando CSF..."
sudo apt install -y libwww-perl liblwp-protocol-https-perl
cd /usr/src
sudo wget https://download.configserver.com/csf.tgz
sudo tar -xzf csf.tgz
cd csf
sudo bash install.sh

# Configuración básica de CSF
echo "Configurando CSF..."
sudo perl /usr/local/csf/bin/csftest.pl
sudo systemctl start csf
sudo systemctl enable csf

# Instalar el plugin de Acronis para WHM
echo "Instalando el plugin de Acronis para WHM..."
curl -L https://download.acronis.com/ci/cpanel/stable/install_acronis_cpanel.sh | sudo bash || wget -O - https://download.acronis.com/ci/cpanel/stable/install_acronis_cpanel.sh | sudo bash

echo "Plugins instalados correctamente"
