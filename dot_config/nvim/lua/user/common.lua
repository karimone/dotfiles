local function set(mode, shortcut, command, desc)
  -- Wrapper to easily set the description of the map
  opts = nil
  if desc then
    opts = { desc = desc }
  end

  vim.keymap.set(mode, shortcut, command, opts)

end

return {
  set = set
}


