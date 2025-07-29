-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { -- Theme inspired by Atom
    'loctvl842/monokai-pro.nvim',
    priority = 1000,
    config = function(_, opts)
      local monokai = require 'monokai-pro'
      monokai.setup(opts)
      monokai.load()
    end,
  },
  'tpope/vim-fugitive',
  'mbbill/undotree',
}
