-- ============================================================================
-- FLOATING TERMINAL (终极完美版)
-- exit 自动关闭窗口 · 不残留缓冲区 · 完美透明
-- ============================================================================
local augroup = vim.api.nvim_create_augroup("FloatingTerminal", { clear = true })

local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false,
  original_win = nil -- 记录打开前的窗口
}

local function close_terminal()
  if terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, true)
  end
  if terminal_state.buf and vim.api.nvim_buf_is_valid(terminal_state.buf) then
    vim.api.nvim_buf_delete(terminal_state.buf, { force = true })
  end
  terminal_state.is_open = false
  terminal_state.buf = nil
  terminal_state.win = nil
end

function FloatingTerminal()
  -- 如果已经打开，则关闭
  if terminal_state.is_open then
    close_terminal()
    return
  end

  -- 记录当前窗口，关闭后跳回去
  terminal_state.original_win = vim.api.nvim_get_current_win()

  -- 创建缓冲区
  terminal_state.buf = vim.api.nvim_create_buf(false, true)

  -- 窗口大小
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- 打开浮窗
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- 透明
  vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })
  vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
  vim.wo[terminal_state.win].winblend = 0

  -- 打开终端
  vim.fn.termopen(vim.o.shell, {
    on_exit = function()
      close_terminal()
      -- 回到原来的文件窗口
      if vim.api.nvim_win_is_valid(terminal_state.original_win) then
        vim.api.nvim_set_current_win(terminal_state.original_win)
      end
    end,
  })

  terminal_state.is_open = true
  vim.cmd("startinsert")
end

-- 自动设置：终端打开时不显示行号
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- 快捷键
vim.keymap.set("n", "<leader>t", FloatingTerminal, { desc = "Float Terminal" })
vim.keymap.set("t", "<Esc>", close_terminal, { desc = "Close Float Terminal" })
