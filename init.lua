vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.cursorline = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "AlphaTechnolog/pywal.nvim",
      name = "pywal",
      config = function()
        require("pywal").setup()
        vim.cmd("colorscheme pywal")
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#595959" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })
      end,
    },

    { "nvim-tree/nvim-web-devicons" },

    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            theme = "pywal",
            icons_enabled = true,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
          },
        })
      end,
    },
    
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-web-devicons" },
      config = function()
        require("nvim-tree").setup({
          view = {
            width = 30,
          },
        })
        vim.keymap.set("n", "<leader>", ":NvimTreeToggle<CR>", { silent = true })
      end,
    },
    
    {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = { "nvim-web-devicons" },
      config = function()
        require("bufferline").setup({
          options = {
            diagnostics = "nvim_lsp",
            separator_style = "thin",
            offsets = {
              {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true,
              },
            },
          },
        }) 
        vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
        vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
      end,
    },
  },  
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
