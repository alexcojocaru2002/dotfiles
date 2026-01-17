local opt = vim.opt 

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true 

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if mixed search assumes case sensitive


opt.termguicolors = true

opt.clipboard:append("unnamedplus")

opt.splitright = true -- split always to the right when vertically 
opt.splitbelow = true 


