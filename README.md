# Configuración Personalizada de Neovim

Este repositorio contiene configuraciones personalizadas para Neovim, disponibles en dos formatos:
- **init.lua**: Configuración basada en Lua (recomendada para usuarios con la última versión de Neovim).
- **init.vim**: Configuración basada en Vimscript para versiones más antiguas o preferencia personal.

El script `install.sh` permite automatizar el proceso de instalación y configuración de estas opciones, además de instalar los servidores LSP necesarios para los lenguajes soportados.

## Lenguajes Soportados
- **JavaScript**
- **Python**
- **HTML**
- **CSS**

## Requisitos Previos
1. **Neovim instalado**:
   - Para Lua: Neovim 0.5 o superior.
   - Para Vimscript: Compatible con cualquier versión moderna de Neovim.
2. **Gestor de paquetes `packer.nvim` instalado**:
   ```bash
   git clone --depth 1 https://github.com/wbthomason/packer.nvim \
   ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   
