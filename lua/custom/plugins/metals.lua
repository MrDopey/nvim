return {}
--[[
--dockerfile
RUN curl -fL "https://github.com/coursier/coursier/releases/latest/download/cs-$(uname -m)-pc-linux.gz" | gzip -d > /usr/local/bin/cs \
    && chmod +x /usr/local/bin/cs \
    && cs install --install-dir /usr/local/bin metals
--Neovim
:MetalsInstall
--]]

-- return {
--   {
--     'mason-org/mason.nvim',
--     opts = {},
--   },
--   {
--     'scalameta/nvim-metals',
--     ft = { 'scala', 'sbt', 'java' },
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--     },
--     config = function()
--       local metals = require 'metals'
--
--       local config = metals.bare_config()
--
--       config.settings = {
--         showImplicitArguments = true,
--         showInferredType = true,
--       }
--
--       vim.api.nvim_create_autocmd('FileType', {
--         pattern = { 'scala', 'sbt', 'java' },
--         callback = function()
--           metals.initialize_or_attach(config)
--         end,
--       })
--     end,
--   },
-- }
