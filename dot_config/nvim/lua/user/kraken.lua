-- [[
-- Script to test Python code.
-- Run one of the following user commands:
--   * :TestFunction
--   * :TestClass
--   * :TestFile
-- The command also accepts arguments, so it can be run with:
--   * :TestFunction --create-db
-- ]]

local ts_utils = require('nvim-treesitter.ts_utils')

local test_cmd = "inv localdev.pytest -s -vv"

local function run_test_cmd(cmd)
  cmd = ":tab | TcloseAll! | T " .. cmd
  vim.cmd(cmd)
end

local function get_parent_node_by_type(current_node, type, err_on_nil)
  local parent = current_node

  while parent do
    if parent:type() == type then
      return parent
    end
    parent = parent:parent()
  end

  if err_on_nil then
    error("Not inside a " .. type .. "!!!")
  end
end

local function get_current_node()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    error("Invalid node under cursor")
  end
  return current_node
end

local function build_test_cmd_from_suffix_and_args(suffix, args)
  return table.concat({
    test_cmd,
    args,
    vim.fn.expand("%") .. suffix,
  }, " ")
end

local function test_function(opts)
  local current_node = get_current_node()

  local parent_function = get_parent_node_by_type(
    current_node, "function_definition", true
  )
  local function_name = vim.treesitter.get_node_text(
    parent_function:child(1), 0
  )

  local parent_class = get_parent_node_by_type(
    parent_function, "class_definition", false
  )

  local test_suffix
  if not parent_class then
    test_suffix = "::" .. function_name
  else
    local class_name = vim.treesitter.get_node_text(
      parent_class:child(1), 0
    )
    test_suffix = "::" .. class_name .. "::" .. function_name
  end

  local cmd = build_test_cmd_from_suffix_and_args(test_suffix, opts.args)
  run_test_cmd(cmd)
end

local function test_class(opts)
  local current_node = get_current_node()

  local parent_class = get_parent_node_by_type(
    current_node, "class_definition", true
  )
  local class_name = vim.treesitter.get_node_text(
    parent_class:child(1), 0
  )
  print(class_name)
  local test_suffix = "::" .. class_name

  local cmd = build_test_cmd_from_suffix_and_args(test_suffix, opts.args)
  run_test_cmd(cmd)
end

local function test_file(opts)
  local cmd = build_test_cmd_from_suffix_and_args("", opts.args)
  run_test_cmd(cmd)
end

vim.api.nvim_create_user_command("TestFunction", test_function, {
  -- Zero or one arguments are accepted
  nargs="?",
  -- Can't be used in visual mode too.
  range=false,
})
vim.api.nvim_create_user_command("TestClass", test_class, {
  -- Zero or one arguments are accepted
  nargs="?",
  -- Can't be used in visual mode too.
  range=false,
})
vim.api.nvim_create_user_command("TestFile", test_file, {
  -- Zero or one arguments are accepted
  nargs="?",
  -- Can't be used in visual mode too.
  range=false,
})
