return { -- Adds support for remote development and devcontainers to Neovim (just like VSCode)
  'amitds1997/remote-nvim.nvim',
  version = '*', -- Pin to GitHub releases
  dependencies = {
    'nvim-lua/plenary.nvim', -- For standard functions
    'MunifTanjim/nui.nvim', -- To build the plugin UI
    'nvim-telescope/telescope.nvim', -- For picking b/w different remote methods
  },
  config = function()
    ---@diagnostic disable:missing-fields
    require('remote-nvim').setup {
      -- client_callback = function(port, _)
      --   local cmd = ('neovide --server localhost:%s'):format(port)
      --   vim.fn.jobstart(cmd, {
      --     detach = true,
      --   })
      -- end,
      client_callback = function(port, _)
        require('remote-nvim.ui').float_term(('nvim --server localhost:%s --remote-ui'):format(port), function(exit_code)
          if exit_code ~= 0 then
            vim.notify(('Local client failed with exit code %s'):format(exit_code), vim.log.levels.ERROR)
          end
        end)
      end,
    }
  end,
}
