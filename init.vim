" Activar soporte para Lua
set runtimepath+=~/.config/nvim

" Instalar vim-plug si no está instalado
call plug#begin('~/.local/share/nvim/plugged')

" Tema Catppuccin
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Plugins de utilidad
Plug 'jiangmiao/auto-pairs'           " Autocierre de paréntesis y otros caracteres
Plug 'preservim/nerdtree'             " Explorador de archivos
Plug 'junegunn/vim-easy-align'        " Alineación fácil de texto
Plug 'christoomey/vim-tmux-navigator' " Navegación entre paneles de tmux

" Plugins para lenguajes (JavaScript, HTML, CSS, Python)
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Autocompletado y más

" Barra de estado
Plug 'nvim-lualine/lualine.nvim'

" Iconos para archivos
Plug 'kyazdani42/nvim-web-devicons'

" Fuzzy finder para búsqueda rápida
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Otros plugins útiles
Plug 'tpope/vim-surround'   " Para manejo de paréntesis y corchetes
Plug 'tpope/vim-commentary' " Para comentar/descomentar rápidamente

" Fin de la instalación de plugins
call plug#end()

" Activar el tema Catppuccin
colorscheme catppuccin-macchiato

lua << EOF
require('lualine').setup {
  options = {
    theme = 'catppuccin',  -- Usamos el tema Catppuccin en la barra de estado
    component_separators = '',  -- Eliminar separadores entre componentes
    section_separators = '',    -- Eliminar los bordes entre las secciones
  },
}
EOF


" Configuración de COC (Completion)
let g:coc_global_extensions = ['coc-tsserver', 'coc-html', 'coc-css', 'coc-python']  " Soporte para JS, HTML, CSS y Python

" Configuración para nvim-web-devicons (iconos para archivos)
lua << EOF
require'nvim-web-devicons'.setup {}
EOF

" Configuración de NERDTree (explorador de archivos)
nnoremap <C-n> :NERDTreeToggle<CR> " Abre/cierra NERDTree con Ctrl+n

" Otros ajustes útiles para la edición
set number              " Mostrar números de línea
" set relativenumber    " Si prefieres números de línea relativos
set autoindent          " Auto indentación
set smartindent         " Indentación inteligente
set tabstop=4           " Usar 4 espacios por tabulación
set shiftwidth=4        " Ajustar tamaño de indentación

" Configuración de búsqueda incremental
set incsearch
set ignorecase
set smartcase

" Otras configuraciones recomendadas
set nowrap              " Desactivar el ajuste automático de líneas
set mouse=a             " Habilitar soporte para el mouse

