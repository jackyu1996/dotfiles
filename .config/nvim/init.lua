local api = vim.api
local fn = vim.fn
local g = vim.g
local lsp = vim.lsp
local mapkey = vim.keymap.set
local opt = vim.opt

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
            "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path
        })
    api.cmd [[packadd packer.nvim]]
end

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

local mapping_opts = { noremap = true, silent = true }

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
mapkey("n", "<F11>", "<cmd>terminal<CR>", mapping_opts)
mapkey("t", "<C-w><ESC>", "<C-\\><C-n>", mapping_opts)
mapkey("n", "<leader>b", "<cmd>SymbolsOutline<CR>", mapping_opts)
mapkey("n", "<leader>e", "<cmd>TroubleToggle<CR>", mapping_opts)
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
mapkey("t", "<Esc>", "<C-\\><C-n>", mapping_opts)
mapkey("n", "/", "/\v", mapping_opts)
mapkey("c", "%s/", "%s/\v", mapping_opts)

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
opt.pastetoggle = "<F12>"
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

require("packer").startup(function(use)
    use { "wbthomason/packer.nvim" }

    use { "junegunn/vim-easy-align" }

    use {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "c", "lua", "python", "go", "rust" },
                sync_install = false,
                auto_install = true,
                enable = true,
                matchup = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    use_languagetree = true,
                }
            }
        end
    }

    use { "nvim-treesitter/nvim-treesitter-context" }

    use { "nvim-treesitter/nvim-treesitter-textobjects" }

    use { "neovim/nvim-lspconfig" }

    use {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup {}
        end
    }

    use {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                automatic_installation = true,
            }
        end
    }

    use {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup {}
        end
    }

    use {
        "hrsh7th/cmp-nvim-lsp",
        config = function()
            local on_attach = function(client, bufnr)
                -- warning: alias variables for vim have to be redefined
                local mapkey = vim.keymap.set
                local lsp = vim.lsp
                local api = vim.api

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
                mapkey("n", "<space>f", lsp.buf.format, bufopts)
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local servers =
            { "bashls", "clangd", "cssls", "dartls", "emmet_ls", "eslint", "gopls", "html", "jdtls",
                "jedi_language_server", "jsonls", "rust_analyzer", "lua_ls", "svelte", "tailwindcss", "tsserver", "zk" }

            for _, server in ipairs(servers) do
                require("lspconfig")[server].setup { capabilities = capabilities, on_attach = on_attach }
            end
        end
    }

    use {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("lsp-inlayhints").setup()
        end
    }

    use {
        "honza/vim-snippets",
        event = "InsertEnter",
    }

    use {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end
    }

    use { "saadparwaiz1/cmp_luasnip" }

    use { "hrsh7th/cmp-buffer" }

    use { "hrsh7th/cmp-path" }

    use { "hrsh7th/cmp-cmdline" }

    use {
        "hrsh7th/nvim-cmp",
        config = function()
            -- local api = vim.api
            --
            -- local has_words_before = function()
            --     local line, col = table.unpack(api.nvim_win_get_cursor(0))
            --     return col ~= 0 and
            --     api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            -- end
            -- local luasnip = require("luasnip")
            local cmp = require("cmp")

            cmp.setup {
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
            }

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
    }

    use {
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup {}
        end
    }

    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {
                fast_wrap = {},
                map_c_h = true,
            }
        end
    }

    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {}
        end
    }

    use {
        "nvim-tree/nvim-tree.lua",
        requires = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup {}
        end
    }

    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.0",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup {
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
            }
        end
    }

    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {}
        end
    }

    use {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup { default = true }
        end
    }

    use {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup {
                options = {
                    theme = "onedark",
                    section_separators = "",
                    component_separators = "",

                },
            }
        end
    }

    use {
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").load()
        end
    }

    use {
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim"
    }

    use {
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps {}
        end
    }

    use {
        "andymass/vim-matchup",
        event = "VimEnter",
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }

    use {
        "RRethy/vim-illuminate",
    }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end
    }

    use {
        "romgrk/barbar.nvim",
        requires = "nvim-web-devicons"
    }

    use {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup {}
        end
    }

    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }
end)
