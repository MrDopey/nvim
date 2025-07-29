return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup {}

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'harpoon add to list' })
    vim.keymap.set('n', '<leader>hd', function()
      harpoon:list():remove()
    end, { desc = 'harpoon delete from list' })
    vim.keymap.set('n', '<leader>hj', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'harpoon quick menu' })

    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():select(1)
    end, { desc = 'harpoon select at index 1' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon:list():select(2)
    end, { desc = 'harpoon select at index 2' })
    vim.keymap.set('n', '<C-i>', function()
      harpoon:list():select(3)
    end, { desc = 'harpoon select at index 3' })
    vim.keymap.set('n', '<C-o>', function()
      harpoon:list():select(4)
    end, { desc = 'harpoon select at index 4' })

    vim.keymap.set('n', '<leader>hs', function()
      harpoon:list():prev()
    end, { desc = 'harpoon previous item' })
    vim.keymap.set('n', '<leader>ht', function()
      harpoon:list():next()
    end, { desc = 'harpoon next item' })
  end,
}
