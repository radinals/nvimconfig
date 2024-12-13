local telescope= require("telescope.builtin")

-- vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })

local Key = {
  {
    mode = "n",
    lhs = "<leader>rf",
    rhs = "<cmd>RunFile<CR>",
    opts = {
      desc = "RunFile",
      noremap = true,
      silent = true,
    }
  },

  {
    mode = "n",
    lhs = "<leader>r",
    rhs = "<cmd>RunCode<CR>",
    opts = {
      desc = "RunCode",
      noremap = true,
      silent = true,
    }
  },

  {
    mode = "n",
    lhs = "<leader>rc",
    rhs = "<cmd>RunClose<CR>",
    opts = {
      desc = "RunClose",
      noremap = true,
      silent = true,
    }
  },

  {
    mode = "n",
    lhs = "<S-h>",
    rhs = "<cmd>bprevious<CR>",
    opts = {
      desc = "Go to previous buffer",
      noremap = true,
      silent = true,
    }
  },

  {
    mode = "n",
    lhs = "<S-l>",
    rhs = "<cmd>bnext<CR>",
    opts = {
      desc = "Go to next buffer",
      noremap = true,
      silent = true,
    }
  },

  {
    mode = "n",
    lhs = "<leader>cc",
    rhs = require('tiny-code-action').code_action,
    opts = {
      desc = "Telescope Code Action",
      noremap = true,
      silent = true,
    }
  },

  {
    mode = "n",
    lhs = "<leader>rn",
    rhs = vim.lsp.buf.rename,
    opts = {
      desc = "Toggle Terminal",
      noremap = true,
      silent = true,
    }
  },

  {
    mode = "n",
    lhs = "<leader>ot",
    rhs = "<cmd>ToggleTerm<CR>",
    opts = {
      desc = "Toggle Terminal"
    }
  },

  {
    mode = "n",
    lhs = "<leader>ff",
    rhs = telescope.find_files,
    opts = {
      desc = "Telescope Find Files"
    }
  },

  {
    mode = "n",
    lhs = "<leader>ts",
    rhs = telescope.treesitter,
    opts = {
      desc = "Telescope Treesitter"
    }
  },

  {
    mode = "n",
    lhs = "<leader>fg",
    rhs = telescope.live_grep,
    opts = {
      desc = "Telescope File Grep"
    }
  },

  {
    mode = "n",
    lhs = "<leader>fb",
    rhs = telescope.buffers,
    opts = {
      desc = "Telescope buffers"
    }
  },

  {
    mode = "n",
    lhs = "<leader>wv",
    rhs = "<cmd>vsplit<CR>",
    opts = {
      desc = "Open Vertical Split"
    }
  },

  {
    mode = "n",
    lhs = "<leader>wh",
    rhs = "<cmd>split<CR>",
    opts = {
      desc = "Open Horizontal Split"
    }
  }
}

for _, binding in ipairs(Key) do
  vim.keymap.set(binding.mode, binding.lhs, binding.rhs, binding.opts)
end
