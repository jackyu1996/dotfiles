local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap
local opt = vim.opt
-- local autocmd = vim.api.nvim_create_autocmd
-- local cmd = vim.api.nvim_command

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path
    }
    )
    vim.cmd [[packadd packer.nvim]]
end

g.mapleader = " "
g.maplocalleader = " "

local mapping_opts = { noremap = true, silent = true }

map("i", "jk", "<ESC>", mapping_opts)
map("c", "<C-n>", "<down>", mapping_opts)
map("c", "<C-p>", "<up>", mapping_opts)
map("n", "<C-h>", "<C-w>h", mapping_opts)
map("n", "<C-j>", "<C-w>j", mapping_opts)
map("n", "<C-k>", "<C-w>k", mapping_opts)
map("n", "<C-l>", "<C-w>l", mapping_opts)
map("n", "<F11>", ":terminal<CR>", mapping_opts)
map("n", "<leader>e", ":TroubleToggle<CR>", mapping_opts)
map("n", "<leader>h", ":set hlsearch!<CR>", mapping_opts)
map("n", "<leader>q", ":quit!<CR>", mapping_opts)
map("n", "<leader>w", ":write<CR>", mapping_opts)
map("n", "<leader>x", ":quitall!<CR>", mapping_opts)
map("n", "<F8>", ":NvimTreeToggle<CR>", mapping_opts)
map("n", "<leader>p", ":Telescope find_files<CR>", mapping_opts)
map("n", "<leader>r", ":Telescope live_grep<CR>", mapping_opts)
map("n", "<leader>n", ":Telescope buffers<CR>", mapping_opts)
map("n", "<leader>k", ":Telescope keymaps<CR>", mapping_opts)
map("", "f",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
    , {})
map("", "F",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
    , {})
map("", "t",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
    , {})
map("", "T",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
    , {})

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
opt.foldlevelstart = 0
opt.foldmethod = "indent"
opt.hlsearch = true
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

require("packer").startup(function(use)
    use { "wbthomason/packer.nvim" }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
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

    use {
        "neovim/nvim-lspconfig",
    }

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
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

            local servers =
            { "bashls", "clangd", "cmake", "cssls", "dartls", "denols", "emmet_ls", "eslint", "gopls", "html", "jdtls",
                "jedi_language_server", "jsonls", "rust_analyzer", "sumneko_lua", "svelte", "tailwindcss", "tsserver" }


            for _, server in ipairs(servers) do
                require("lspconfig")[server].setup { capabilities = capabilities, on_attach = on_attach }
            end

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

    use {
        "saadparwaiz1/cmp_luasnip"
    }

    use "hrsh7th/cmp-buffer"

    use "hrsh7th/cmp-path"

    use "hrsh7th/cmp-cmdline"

    use {
        "hrsh7th/nvim-cmp",
        config = function()
            local has_words_before = function()
                local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local luasnip = require("luasnip")
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
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
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
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }

    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {}
        end
    }

    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end
    }

    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.0",
        requires = {
            "nvim-lua/plenary.nvim",
        },
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
        "mfussenegger/nvim-dap"
    }

    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {}
        end
    }

    use {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup { default = true }
        end
    }

    use {
        "feline-nvim/feline.nvim",
        config = function()
            require("feline").setup {}
        end
    }

    use {
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("bufferline").setup {}
        end
    }

    use {
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").load()
        end
    }

    use {
        "phaazon/hop.nvim",
        config = function()
            require("hop").setup {}
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
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }

    use {
        "lewis6991/spellsitter.nvim",
        config = function()
            require("spellsitter").setup()
        end
    }

    use {
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient")
        end
    }
end)

