vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("n", "Y", "yg$")
-- J appends next line to current with space. Cursor now stays in place
vim.keymap.set("n", "J", "mzJ`z")
-- Half page jumping, but cursor stays in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Same but for jump up
-- Keeps the cursor in middle when search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--[[
vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)
]]
-- Paste over selected without the removed text becoming the new paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank into system clickboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete to void instead of paste
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Ctrl-c maps to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Unmaps Q
vim.keymap.set("n", "Q", "<nop>")

-- Switch between projects with tmux
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Format using language server
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search current word in file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make current file executable
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Go to the packer file
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/AppData/Local/nvim/lua/kennyomg/packer.lua<CR>");
-- Make it rain!
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- Source it
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
