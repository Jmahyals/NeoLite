#!/bin/bash

# Directorio de configuración de Neovim
NVIM_CONFIG_DIR="$HOME/.config/nvim"

# Crear el directorio si no existe
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    mkdir -p "$NVIM_CONFIG_DIR"
fi

# Función para instalar paquetes necesarios
install_dependencies() {
    echo "Instalando dependencias necesarias..."
    sudo apt update
    sudo apt install -y curl git nodejs npm python3 python3-pip
    echo "Instalando packer.nvim..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    echo "Dependencias instaladas."
}

# Función para instalar LSPs y herramientas relacionadas
install_lsps() {
    echo "Instalando servidores LSP..."
    npm install -g typescript typescript-language-server
    npm install -g vscode-langservers-extracted
    npm install -g pyright
    echo "Servidores LSP instalados."
}

# Preguntar al usuario si desea usar init.lua o init.vim
echo "¿Qué archivo de configuración deseas instalar?"
echo "1. init.lua (recomendado)"
echo "2. init.vim"
read -p "Ingresa el número de tu elección: " choice

case $choice in
    1)
        # Copiar init.lua
        cp init.lua "$NVIM_CONFIG_DIR/init.lua"
        echo "Archivo init.lua copiado a $NVIM_CONFIG_DIR"
        ;;
    2)
        # Copiar init.vim
        cp init.vim "$NVIM_CONFIG_DIR/init.vim"
        echo "Archivo init.vim copiado a $NVIM_CONFIG_DIR"
        ;;
    *)
        echo "Opción inválida. Saliendo..."
        exit 1
        ;;
esac

# Instalar dependencias y servidores LSP
install_dependencies
install_lsps

# Mensaje final
echo "Instalación completada. Abre Neovim y ejecuta ':PackerSync' para instalar los plugins."

