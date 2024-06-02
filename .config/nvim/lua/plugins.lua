-- Manage the following with packer
return require('packer').startup(function(use)
    -- Manage packer
    use 'wbthomason/packer.nvim'

    -- Manage pywal.nvim
    use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }

    -- Manage colorizer
    use 'norcalli/nvim-colorizer.lua'
end)
