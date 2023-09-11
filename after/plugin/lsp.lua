local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'intelephense',
    'clangd',
    'pyright',
    'gopls',
    'bashls',
    --'zls',
    'cssls',
    'jsonls',
    'cmake',
    --'dartls',
    'asm_lsp',
    --'glsl',
    'html',
    --'hls',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    --[[ Enable inlay hints for rust
    if client.name == 'rust_analyzer' then
        vim.cmd [[
        augroup lsp_inlay_hints
            autocmd!
            autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.inlay_hints()
        augroup END
        ]]
    --end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.configure('rust_analyzer', {
    on_attach = lsp.on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = "clippy"
            },
        }
    }
})

lsp.configure('intelephense',
    {
        on_attach = lsp.on_attach,
        settings = {
            intelephense = {
                stubs = {
                    "apache",
                    "bcmath",
                    "bz2",
                    "calendar",
                    "com_dotnet",
                    "Core",
                    "ctype",
                    "curl",
                    "date",
                    "dba",
                    "dom",
                    "enchant",
                    "exif",
                    "FFI",
                    "fileinfo",
                    "filter",
                    "fpm",
                    "ftp",
                    "gd",
                    "gettext",
                    "gmp",
                    "hash",
                    "iconv",
                    "imap",
                    "intl",
                    "json",
                    "ldap",
                    "libxml",
                    "mbstring",
                    "mcrypt",
                    "mysqli",
                    "mysqlnd",
                    "oci8",
                    "odbc",
                    "openssl",
                    "pcntl",
                    "pcre",
                    "PDO",
                    "pdo_ibm",
                    "pdo_mysql",
                    "pdo_pgsql",
                    "pdo_sqlite",
                    "pgsql",
                    "Phar",
                    "posix",
                    "pspell",
                    "readline",
                    "recode",
                    "Reflection",
                    "regex",
                    "session",
                    "shmop",
                    "SimpleXML",
                    "snmp",
                    "soap",
                    "sockets",
                    "sodium",
                    "SPL",
                    "sqlite3",
                    "standard",
                    "superglobals",
                    "sysvmsg",
                    "sysvsem",
                    "sysvshm",
                    "tidy",
                    "tokenizer",
                    "xml",
                    "xmlreader",
                    "xmlrpc",
                    "xmlwriter",
                    "xsl",
                    "Zend OPcache",
                    "zip",
                    "zlib",
                    "wordpress",
                    "wp-cli",
                    "woocommerce",
                    "wordpress-globals",
                    "genesis",
                    "polylang",
                    "wordpress-seo"
                },
                evironment = {
                    include_paths = {
                        '~/AppData/Roaming/Composer/vendor/php-stubs',
                        '~/AppData/Roaming/Composer/vendor/wpsyntex/'
                    }
                },
                files = {
                    maxSize = 5000000
                }
            }
        }
    }
)

require 'lspconfig'.dartls.setup({
    cmd = { "C:\\tools\\dart-sdk\\bin\\dart.exe", "language-server", "--protocol=lsp" },
    setting = {
        enableSnippets = true,
    },
    init_options = {
        onlyAnalyzeProjectsWithOpenFiles = false,
    },
    on_attach = lsp.on_attach,
    capabilities = lsp.capabilities,
    --root_dir = require('lspconfig/util').root_pattern("pubspec.yaml", "pubspec.lock", "analysis_options.yaml", ".git"),
    root_dir = function() return vim.loop.cwd() end,
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
