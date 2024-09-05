#!/bin/bash

# Activar ionCube Loader
echo "Activando ionCube Loader..."
/usr/local/cpanel/scripts/phpextensionmgr install IonCubeLoader

# Configurar ionCube como el cargador predeterminado
echo "Configurando ionCube como el cargador predeterminado..."
/usr/local/cpanel/bin/whmapi1 set_tweaksetting key=phploader value=ioncube

# Reiniciar Apache para aplicar los cambios
echo "Reiniciando Apache..."
service httpd restart

# Descargar e instalar Softaculous
echo "Descargando e instalando Softaculous..."
wget -N http://files.softaculous.com/install.sh
chmod 755 install.sh
./install.sh --quiet  # Se agrega --quiet para reducir la interacción

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Instalar CSF
echo "Instalando CSF..."
sudo apt-get install -y libwww-perl liblwp-protocol-https-perl
cd /usr/src
sudo wget https://download.configserver.com/csf.tgz
sudo tar -xzf csf.tgz
cd csf
sudo bash install.sh -y

# Configuración básica de CSF
echo "Configurando CSF..."
sudo perl /usr/local/csf/bin/csftest.pl
sudo systemctl start csf
sudo systemctl enable csf

# Instalar el plugin de Acronis para WHM
echo "Instalando el plugin de Acronis para WHM..."


wget https://download.acronis.com/ci/cpanel/current/deb/acronis-backup-cpanel_1.9.0.773_amd64.deb && dpkg -i acronis-backup-cpanel_1.9.0.773_amd64.deb

echo "Plugins instalados correctamente"
