-- return {
--   'yetone/avante.nvim',
--   event = 'VeryLazy',
--   lazy = false,
--   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
--   opts = {
--     -- add any opts here
--     provider = 'ollama',
--     vendors = {
--       ollama = {
--         __inherited_from = 'openai',
--         api_key_name = '',
--         endpoint = 'http://127.0.0.1:11434/v1',
--         model = 'qwen2.5-coder:1.5b',
--       },
--     }, -- for example
--   },
--   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
--   build = 'make',
--   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
--   dependencies = {
--     'stevearc/dressing.nvim',
--     'nvim-lua/plenary.nvim',
--     'MunifTanjim/nui.nvim',
--     --- The below dependencies are optional,
--     'echasnovski/mini.pick', -- for file_selector provider mini.pick
--     'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
--     'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
--     'ibhagwan/fzf-lua', -- for file_selector provider fzf
--     'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
--     'zbirenbaum/copilot.lua', -- for providers='copilot'
--     {
--       -- support for image pasting
--       'HakonHarnes/img-clip.nvim',
--       event = 'VeryLazy',
--       opts = {
--         -- recommended settings
--         default = {
--           embed_image_as_base64 = false,
--           prompt_for_file_name = false,
--           drag_and_drop = {
--             insert_mode = true,
--           },
--           -- required for Windows users
--           use_absolute_path = true,
--         },
--       },
--     },
--     {
--       -- Make sure to set this up properly if you have lazy=true
--       'MeanderingProgrammer/render-markdown.nvim',
--       opts = {
--         file_types = { 'markdown', 'Avante' },
--       },
--       ft = { 'markdown', 'Avante' },
--     },
--   },
-- }

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('codecompanion').setup {
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = 'qwen',
        },
        inline = {
          adapter = 'qwen',
        },
      },
      adapters = {
        qwen = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'qwen', -- Give this adapter a different name to differentiate it from the default ollama adapter
            env = {
              url = 'http://ollama.cfhull.dev:11434',
            },
            schema = {
              model = {
                default = 'qwen2.5-coder:0.5b',
              },
            },
          })
        end,
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.keymap.set({ 'n', 'v' }, '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
  end,
}
