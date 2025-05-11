api = vim.api
fn = vim.fn
g = vim.g
lsp = vim.lsp
mapkey = vim.keymap.set
opt = vim.opt
loop = vim.loop
env = vim.env

lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
    fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
opt.rtp:prepend(lazypath)

g.mapleader = " "
g.maplocalleader = " "

g.gui_font_default_size = 12
g.gui_font_size = g.gui_font_default_size
g.gui_font_face = "FiraCode Nerd Font"

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

RefreshGuiFont = function()
    opt.guifont = string.format("%s:h%s", g.gui_font_face, g.gui_font_size)
end

ResizeGuiFont = function(delta)
    g.gui_font_size = g.gui_font_size + delta
    RefreshGuiFont()
end

ResetGuiFont = function()
    g.gui_font_size = g.gui_font_default_size
    RefreshGuiFont()
end

mapping_opts = { noremap = true, silent = true }

mapkey("c", "<C-n>", "<down>", mapping_opts)
mapkey("c", "<C-p>", "<up>", mapping_opts)
mapkey("i", "jk", "<ESC>", mapping_opts)
mapkey("n", "<C-+>", "<cmd>lua ResizeGuiFont(1)<CR>", mapping_opts)
mapkey("n", "<C-->", "<cmd>lua ResizeGuiFont(-1)<CR>", mapping_opts)
mapkey("n", "<C-BS>", ResetGuiFont, mapping_opts)
mapkey("n", "<C-h>", "<C-w>h", mapping_opts)
mapkey("n", "<C-j>", "<C-w>j", mapping_opts)
mapkey("n", "<C-k>", "<C-w>k", mapping_opts)
mapkey("n", "<C-l>", "<C-w>l", mapping_opts)
mapkey("n", "<F11>", "<cmd>split | resize 20 | terminal<CR>", mapping_opts)
mapkey("t", "<C-w><ESC>", "<C-\\><C-n>", mapping_opts)
mapkey("n", "<leader>b", "<cmd>SymbolsOutline<CR>", mapping_opts)
mapkey("n", "<leader>e", "<cmd>Trouble<CR>", mapping_opts)
mapkey("n", "<leader>h", "<cmd>set hlsearch!<CR>", mapping_opts)
mapkey("n", "<leader>k", "<cmd>Telescope keymaps<CR>", mapping_opts)
mapkey("n", "<leader>n", "<cmd>Telescope buffers<CR>", mapping_opts)
mapkey("n", "<leader>p", "<cmd>Telescope find_files<CR>", mapping_opts)
mapkey("n", "<leader>q", "<cmd>hide<CR>", mapping_opts)
mapkey("n", "<leader>r", "<cmd>Telescope live_grep<CR>", mapping_opts)
mapkey("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", mapping_opts)
mapkey("n", "<leader>w", "<cmd>write<CR>", mapping_opts)
mapkey("n", "<leader>x", "<cmd>quitall!<CR>", mapping_opts)
mapkey("x", "<leader>a", "<cmd>EasyAlign<CR>", mapping_opts)
mapkey("n", "<F5>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", mapping_opts)
mapkey("n", "<F6>", "<cmd>lua require'dap'.continue()<CR>", mapping_opts)
mapkey("n", "<F7>", "<cmd>lua require'dap'.step_into()<CR>", mapping_opts)
mapkey("n", "<F8>", "<cmd>lua require'dap'.step_over()<CR>", mapping_opts)
mapkey("n", "<F9>", "<cmd>lua require'dap'.step_out()<CR>", mapping_opts)
mapkey("n", "[d", vim.diagnostic.goto_prev, mapping_opts)
mapkey("n", "]d", vim.diagnostic.goto_next, mapping_opts)
mapkey("t", "<Esc>", "<C-\\><C-n>", mapping_opts)
mapkey("c", "%s/", "%s/\\v", mapping_opts)

opt.autoindent = true
opt.autoread = true
opt.backspace = "indent,eol,start"
opt.completeopt = "menuone,noselect"
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.conceallevel = 1
opt.cursorline = true
opt.expandtab = true
opt.foldenable = true
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.hlsearch = false
opt.ignorecase = true
opt.incsearch = true
opt.lazyredraw = true
opt.list = true
opt.listchars = { tab = "» ", extends = "›", precedes = "‹", space = "·", trail = "·" }
opt.mouse = "a"
opt.startofline = false
opt.number = true
opt.relativenumber = true
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
opt.shiftround = true
opt.shiftwidth = 4
opt.showmatch = true
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = 4
opt.spell = true
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.virtualedit = "block"
opt.whichwrap = "b,s,h,l,<,>,[,]"

api.nvim_create_augroup("LspAttach_inlayhints", {})
api.nvim_create_autocmd("LspAttach", {
    group = "LspAttach_inlayhints",
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end

        local bufnr = args.buf
        local client = lsp.get_client_by_id(args.data.client_id)
        require("lsp-inlayhints").on_attach(client, bufnr)
    end,
})

function get_python_path(workspace)
    if env.VIRTUAL_ENV then
        return fn.resolve(env.VIRTUAL_ENV .. '/bin/python')
    end

    for _, pattern in ipairs({ '*', '.*' }) do
        local match = fn.glob(fn.resolve(workspace .. '/' .. pattern .. '/pyvenv.cfg'))
        if match ~= '' then
            return fn.resolve(fn.resolve(match) .. '/bin/python')
        end
    end

    -- Fallback to system Python.
    return fn.exepath('python3') or fn.exepath('python') or 'python'
end

require("lazy").setup({
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        build = "make",
        opts = {
            provider = "gemini",
            gemini = {
                proxy = "http://127.0.0.1:8080",
            }
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
    },
    { "nvim-treesitter/nvim-treesitter-context" },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "lua", "python", "go", "rust", "bash",
                    "css", "javascript", "html", "diff", "json",
                    "latex", "sql", "xml", "yaml"
                },
                sync_install = false,
                auto_install = true,
                enable = true,
                highlight = {
                    enable = true,
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')

            lspconfig.pylsp.setup({
                before_init = function(_, config)
                    config.settings.python.pythonPath = get_python_path(config.root_dir)
                end
            })

            lspconfig.emmet_ls.setup({
                filetypes = {
                    "astro", "css", "eruby", "html", "htmldjango",
                    "javascriptreact", "less", "pug", "sass", "scss",
                    "svelte", "typescriptreact", "vue", "template"
                }
            })

            lspconfig.html.setup({
                filetypes = {
                    "html", "template"
                }
            })
        end
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        config = function()
            require("mason").setup({})
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({})
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({})
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        config = function()
            local on_attach = function(client, bufnr)
                api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                mapkey("n", "gD", lsp.buf.declaration, bufopts)
                mapkey("n", "gd", lsp.buf.definition, bufopts)
                mapkey("n", "gr", lsp.buf.references, bufopts)
                mapkey("n", "gi", lsp.buf.implementation, bufopts)
                mapkey("n", "K", lsp.buf.hover, bufopts)
                mapkey("n", "<C-S-k>", lsp.buf.signature_help, bufopts)
                mapkey("n", "<space>D", lsp.buf.type_definition, bufopts)
                mapkey("n", "<space>rn", lsp.buf.rename, bufopts)
                mapkey("n", "<space>ca", lsp.buf.code_action, bufopts)
                mapkey("n", "<space>f", function()
                    lsp.buf.format { async = true }
                end, bufopts)
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local servers = {
                "bashls", "clangd", "cssls", "cssmodules_ls", "emmet_ls", "eslint", "gopls", "html", "jdtls",
                "biome", "pylsp", "kotlin_language_server", "rust_analyzer", "lua_ls", "svelte",
                "tailwindcss", "ts_ls", "zk", "lemminx", "sqlls", "texlab", "docker_compose_language_service",
                "pyre", "remark_ls", "yamlls"
            }

            for _, server in ipairs(servers) do
                require("lspconfig")[server].setup({ capabilities = capabilities, on_attach = on_attach })
            end
        end
    },
    {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("lsp-inlayhints").setup()
        end
    },
    {
        "honza/vim-snippets",
        event = "InsertEnter",
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end
    },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                })
            })

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                })
            })
        end
    },
    {
        "junegunn/vim-easy-align",
        event = "VeryLazy"
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                fast_wrap = {},
                map_c_h = true,
            })
        end
    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
        },
        keys = {
            { "<leader>/", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup({})
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        event = "VeryLazy",
        config = function()
            require("nvim-tree").setup({})
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    }
                }
            })
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({})
        end
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "onedark",
                    section_separators = "",
                    component_separators = "",

                },
            })
        end
    },
    {
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").load()
        end
    },
    {
        "sindrets/diffview.nvim"
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        config = function()
            require("leap").set_default_keymaps {}
        end
    },
    {
        "andymass/vim-matchup",
        event = "VimEnter",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({})
        end
    },
    { "RRethy/vim-illuminate" },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup({})
        end
    },
    {
        "romgrk/barbar.nvim"
    },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup({})
        end
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({})
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            dap.adapters.python = function(cb, config)
                if config.request == 'attach' then
                    local port = (config.connect or config).port
                    local host = (config.connect or config).host or '127.0.0.1'
                    cb({
                        type = 'server',
                        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                        host = host,
                        options = {
                            source_filetype = 'python',
                        },
                    })
                else
                    cb({
                        type = 'executable',
                        command = get_python_path('.'),
                        args = { '-m', 'debugpy.adapter' },
                        options = {
                            source_filetype = 'python',
                        },
                    })
                end
            end
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            }
            dap.adapters.delve = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = 'dlv',
                    args = { 'dap', '-l', '127.0.0.1:${port}' },
                }
            }

            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",

                    program = "${file}",
                    pythonPath = get_python_path('.')
                },
            }
            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return fn.input('Path to executable: ', fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                },
            }
            dap.configurations.rust = dap.configurations.c
            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = "${file}"
                },
                {
                    type = "delve",
                    name = "Debug test", -- configuration for debugging test files
                    request = "launch",
                    mode = "test",
                    program = "${file}"
                },
                -- works with go.mod packages and sub packages
                {
                    type = "delve",
                    name = "Debug test (go.mod)",
                    request = "launch",
                    mode = "test",
                    program = "./${relativeFileDirname}"
                }
            }
        end
    }
})
