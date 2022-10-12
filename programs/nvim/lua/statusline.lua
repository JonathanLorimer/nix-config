local api = vim.api

vim.o.laststatus = 3

local modes = {
    n      = 'N',
    i      = 'I',
    c      = 'C',
    V      = 'V',
    [''] = 'B',
    v      = 'v',
    C      = 'C',
    ['r?'] = ':CONFIRM',
    rm     = '--MORE',
    R      = 'R',
    Rv     = 'R&V',
    s      = 'S',
    S      = 'S',
    ['r']  = 'HIT-ENTER',
    [''] = 'SELECT',
    t      = 'T',
    ['!']  = 'SH',
}

local function is_lsp_connected()
  local clients = vim.lsp.buf_get_clients()
  return next(clients) ~= nil
end

local function get_diagnostics()
  if is_lsp_connected() then
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN})
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR})

    return table.concat({
      "%#DiagnosticWarn#",
      tostring(warnings),
      " %#DiagnosticError#",
      tostring(errors)
    })
  else
    return ""
  end
end

local function get_git_branch()
  local head = vim.b.gitsigns_head
  if head and string.len(head) > 0 then
    return api.nvim_buf_get_var(0, "gitsigns_head")
  else
    return ""
  end
end

local function get_lsp_status()
  if not is_lsp_connected() then
    return "⭘"
  else
    return "●"
  end
end

Statusline = {}

function Statusline.active()
  local mode = '%#Bold#  '..modes[api.nvim_get_mode().mode]
  local branch = "(λ #"..get_git_branch()..")"
  local ft = "%#NormalNC#"..vim.bo.filetype..' '
  local diagnostics = get_diagnostics()
  local lsp_status = get_lsp_status()
  local filename = ' %#Comment#~'..string.sub(vim.api.nvim_buf_get_name(0), 1 + string.len(vim.loop.cwd(), -1))

  return table.concat({
    mode,
    filename,
    '%#Normal#',
    branch,
    lsp_status,
    diagnostics,
    '%=',
    ft,
    '%l:%c ',
  }, ' ')
end

function Statusline.inactive()
  local ft = vim.bo.filetype
  return '%#Comment#% %= '..ft..' %='
end

local status_line_group = api.nvim_create_augroup("StatusLine", { clear = true })
api.nvim_create_autocmd(
  {"BufEnter", "WinEnter", "VimEnter"},
  {
    pattern = "*",
    callback = function()
      local ft = vim.bo.filetype
      local zindex = vim.api.nvim_win_get_config(0).zindex
      if zindex or ft == "NvimTree" then
        vim.wo.statusline = "%!v:lua.Statusline.inactive()"
      else
        vim.wo.statusline = "%!v:lua.Statusline.active()"
      end
    end,
    group = status_line_group,
  }
)
api.nvim_create_autocmd(
  {"BufLeave", "WinLeave"},
  {
    pattern = "*",
    callback = function()
      vim.wo.statusline = "%!v:lua.Statusline.inactive()"
    end,
    group = status_line_group,
  }
)
