return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
            { "folke/neodev.nvim",                   opts = {} },
            { "folke/lazydev.nvim" },
        },

        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            --------------------------------------------------------------------
            -- LspAttach: buffer-local keymaps
            --------------------------------------------------------------------
            local keymap = vim.keymap

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    opts.desc = "Show LSP references"
                    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                    opts.desc = "Go to declaration"
                    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                    opts.desc = "Show definitions"
                    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                    opts.desc = "Show implementations"
                    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                    opts.desc = "Show type definitions"
                    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                    opts.desc = "See available code actions"
                    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                    opts.desc = "Smart rename"
                    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                    opts.desc = "Show buffer diagnostics"
                    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                    opts.desc = "Show line diagnostics"
                    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                    opts.desc = "Prev diagnostic"
                    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                    opts.desc = "Next diagnostic"
                    keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                    opts.desc = "Hover"
                    keymap.set("n", "K", vim.lsp.buf.hover, opts)

                    opts.desc = "Restart LSP"
                    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
                end,
            })

            --------------------------------------------------------------------
            -- Diagnostic icons
            --------------------------------------------------------------------
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            --------------------------------------------------------------------
            -- Global defaults for *all* LSPs
            --------------------------------------------------------------------
            local capabilities = cmp_nvim_lsp.default_capabilities()

            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            --------------------------------------------------------------------
            -- Individual server overrides
            --------------------------------------------------------------------

            -- Lua (fixes undefined global 'vim')
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            })

            -- Python: basedpyright
            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        venvPath = ".", -- search for venvs relative to project
                        venv = ".venv", -- name of the venv folder
                        analysis = {
                            diagnosticMode = "openFilesOnly",
                            inlayHints = {
                                callArgumentNames = true,
                            },
                        },
                    },
                },
            })

            -- Emmet (HTML/CSS/React)
            vim.lsp.config("emmet_ls", {
                filetypes = {
                    "html",
                    "typescriptreact",
                    "javascriptreact",
                    "css",
                    "sass",
                    "scss",
                    "less",
                },
            })

            --------------------------------------------------------------------
            -- Enable the language servers
            --------------------------------------------------------------------
            local servers = {
                "ts_ls",
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "basedpyright",
                "prismals",
                "emmet_ls",
            }

            vim.lsp.enable(servers)
        end,
    },
}
