lua require('plugins')

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

set termguicolors

lua require'colorizer'.setup(nil, { css = true; })

set number

colorscheme pywal
