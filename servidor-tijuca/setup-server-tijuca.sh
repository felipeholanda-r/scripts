#!/bin/bash

#Atualizar PVE para v8.X
echo "Verificações iniciais..."
pve7to8 --full

echo "Atualizando pacotes..."
apt update

echo "Atualizando distribuição..."
apt dist-upgrade -y

echo "Verificando versão atual..."
pveversion

echo "VERIFIQUE SE A VERSÃO É 7.4.15 OU + !!!. ENCERRE CASO NÃO"
sleep 30s

echo "Atualizando repositórios Debian..."
sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list

echo "Adicionando repositório Proxmox VE 8..."
sed -i -e 's/bullseye/bookworm/g' /etc/apt/sources.list.d/pve-install-repo.list

echo "Adicionando repositório Ceph..."
echo "deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription" > /etc/apt/sources.list.d/ceph.list

echo "Atualizando pacotes..."
apt update

echo "Atualizando distribuição..."
apt dist-upgrade -y