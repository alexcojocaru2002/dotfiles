return {
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
        "mfussenegger/nvim-dap-python", -- optional
    },
    opts = {
        -- refresh venv list when opening a python file
        auto_refresh = true,
    },
}
