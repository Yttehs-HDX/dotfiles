local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local opt = vim.opt

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

-- Hide startup promotion
opt.shortmess:append("sI")

-- Enable line numbers
opt.number = true

-- Enable relative line numbers
opt.relativenumber = true

-- Set tab spacing
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Disable line wrapping
opt.wrap = false

require('lazy').setup { import = 'plugins' }
