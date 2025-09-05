return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = "gpt-4.1", -- AI model to use
      temperature = 0.1, -- Lower = focused, higher = creative
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float'
        width = 0.5, -- 50% of screen width
      },
      auto_insert_mode = true, -- Enter insert mode when opening
    },
    config = function(_, opts)
      -- Initialize CopilotChat with your opts
      require("CopilotChat").setup(opts)

      -- Keymaps for diff reviewing inside CopilotChat buffer
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "copilot-chat",
        callback = function()
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
          end
          map("gd", "<Plug>(copilot-chat-diff-preview)", "Preview nearest diff")
          map("gj", "<Plug>(copilot-chat-diff-next)", "Next diff")
          map("gk", "<Plug>(copilot-chat-diff-prev)", "Previous diff")
          map("<C-y>", "<Plug>(copilot-chat-diff-accept)", "Accept nearest diff")
          map("gqd", "<Plug>(copilot-chat-diff-quickfix)", "Send diffs to quickfix")
        end,
      })
    end,
  },
}
