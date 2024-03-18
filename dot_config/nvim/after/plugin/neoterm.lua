vim.api.nvim_create_user_command(
  "MarioServer",
  ":tabnew | TcloseAll! | T mario-server",
  {}
)

vim.api.nvim_create_user_command(
  "OrServer",
  ":tabnew | TcloseAll! | T or-server",
  {}
)

vim.api.nvim_create_user_command(
  "OrServerddt",
  ":tabnew | TcloseAll! | T or-server-ddt",
  {}
)


vim.api.nvim_create_user_command("CopyRelPath", "call setreg('+', expand('%'))", {})

-- add a command to list the current directory in a new terminal
vim.api.nvim_create_user_command("ListDir", "tabnew | TcloseAll! | T ls", {})

vim.api.nvim_create_user_command(
  'OEFindOriginPlugins',
  function ()
    require('telescope.builtin').find_files({
      cwd="~/Code/octopus/kraken-core/src/octoenergy/plugins/clients/origin/",
      prompt_title = 'Find Files in Origin Plugin',
    })
  end,
  {}
)

vim.api.nvim_create_user_command(
  'OEFindAusPlugins',
  function ()
    require('telescope.builtin').find_files(
      {
        cwd="~/Code/octopus/kraken-core/src/octoenergy/plugins/territories/aus",
        prompt_title = 'Find Files in Aus Territory',
      })
  end,
  {}
)

vim.api.nvim_create_user_command(
  'OEGrepOriginPlugins',
  function ()
    require('telescope.builtin').live_grep({
      cwd="~/Code/octopus/kraken-core/src/octoenergy/plugins/clients/origin/",
      prompt_title = 'Grep Files in Origin Plugin',
    })
  end,
  {}
)

vim.api.nvim_create_user_command(
  'OEGrepAusPlugins',
  function ()
    require('telescope.builtin').live_grep({
      cwd="~/Code/octopus/kraken-core/src/octoenergy/plugins/territories/aus",
      prompt_title = 'Grep Files in Aus Territory',
    })
  end,
  {}
)

vim.api.nvim_create_user_command(
  'OEFindAusPlugins',
  function ()
    require('telescope.builtin').find_files(
      {
        cwd="~/Code/octopus/kraken-core/src/octoenergy/plugins/territories/aus",
        prompt_title = 'Find Files in Aus Territory',
      })
  end,
  {}
)


local function lint()
  local file_name = vim.fn.expand('%:p')
  local file_extension = file_name:match("^.+(%..+)$")

  if file_extension == ".py" then
    vim.cmd("!black %")
    vim.cmd("!echo '--- BLACK FINISHED ---'")
    vim.cmd("!ruff --fix %")
    vim.cmd("!echo '--- RUFF FINISHED ---'")
    vim.cmd(":Flake")
    return
  elseif file_extension == ".cpp" then
    vim.cmd("!clang-format -i --style=LLVM %")
    vim.cmd("!echo '--- clang-format FINISHED ---'")
  elseif file_extension == ".c" then
    vim.cmd("!clang-format -i --style=LLVM %")
    vim.cmd("!echo '--- clang-format FINISHED ---'")
  elseif file_extension == ".sql" then
    vim.cmd("!sqlformat --reindent --keywords upper --identifiers lower --indent_columns % -o %")
    vim.cmd("!echo '--- sqlformat FINISHED ---'")
  elseif file_extension == ".md" then
    -- error format required for the output of the command.
    vim.cmd("set errorformat+=%f:%l\\ %m")
    vim.cmd(table.concat({
      "cexpr ",
      "system('",
      "markdownlint ",
      vim.api.nvim_buf_get_name(0),
      "')"
    }, ""))
    vim.cmd("copen")
  else
    vim.cmd("echoerr 'Linter does not support this file extension'")
  end
end


vim.keymap.set("n", "<Leader>lint", lint)
