-- Instalar packer.nvim si no está instalado
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Configuración de plugins
require('packer').startup(function(use)
  -- Administrador de paquetes
  use 'wbthomason/packer.nvim'

  -- Tema Catppuccin
  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- Configuración de LSP y autocompletado
  use 'neovim/nvim-lspconfig'    -- Configuración básica de LSP
  use 'hrsh7th/nvim-cmp'         -- Motor de autocompletado
  use 'hrsh7th/cmp-nvim-lsp'     -- Fuente de autocompletado para LSP
  use 'hrsh7th/cmp-buffer'       -- Autocompletado desde el buffer
  use 'hrsh7th/cmp-path'         -- Autocompletado de rutas de archivo
  use 'L3MON4D3/LuaSnip'         -- Snippets para autocompletado

  -- Plugins de utilidad
  use 'jiangmiao/auto-pairs'           -- Autocierre de paréntesis y otros caracteres
  use 'preservim/nerdtree'             -- Explorador de archivos
  use 'junegunn/fzf'                   -- Fuzzy Finder
  use 'junegunn/fzf.vim'               -- Extensión de FZF para Neovim
  use 'tpope/vim-surround'             -- Manejo de caracteres delimitadores
  use 'tpope/vim-commentary'           -- Comentar líneas fácilmente
  use 'nvim-lualine/lualine.nvim'      -- Barra de estado
  use 'kyazdani42/nvim-web-devicons'   -- Iconos para archivos
  use 'christoomey/vim-tmux-navigator' -- Navegación entre paneles de tmux
  use 'junegunn/vim-easy-align'        -- Alineación de texto

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Configuración general
vim.opt.number = true                -- Mostrar números de línea
vim.opt.relativenumber = false       -- Números relativos desactivados
vim.opt.autoindent = true            -- Autoindentación
vim.opt.smartindent = true           -- Indentación inteligente
vim.opt.tabstop = 4                  -- Tamaño de tabulación
vim.opt.shiftwidth = 4               -- Tamaño de indentación
vim.opt.mouse = 'a'                  -- Habilitar soporte para el mouse
vim.opt.wrap = false                 -- Desactivar ajuste de líneas
vim.opt.ignorecase = true            -- Ignorar mayúsculas en búsqueda
vim.opt.smartcase = true             -- Habilitar búsqueda inteligente
vim.opt.incsearch = true             -- Habilitar búsqueda incremental

-- Configuración del tema Catppuccin
vim.cmd.colorscheme('catppuccin-macchiato')

-- Configuración de lualine (barra de estado)
require('lualine').setup {
  options = {
    theme = 'catppuccin',        -- Usar el tema Catppuccin
    component_separators = '',  -- Sin separadores de componentes
    section_separators = '',    -- Sin separadores entre secciones
  },
}

-- Configuración de nvim-web-devicons (iconos para archivos)
require('nvim-web-devicons').setup {}

-- Atajo para NERDTree
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Configuración básica de LSP (nvim-lspconfig)
local lspconfig = require('lspconfig')

-- Configuración de servidores de lenguaje
lspconfig.pyright.setup{}   -- Python
lspconfig.ts_ls.setup{}     -- TypeScript/JavaScript
lspconfig.html.setup{}      -- HTML
lspconfig.cssls.setup{}     -- CSS

-- Configuración de autocompletado con nvim-cmp
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Configuración de autocompletado para LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.util.default_config = vim.tbl_extend(
  'force',
  lspconfig.util.default_config,
  { capabilities = capabilities }
)
