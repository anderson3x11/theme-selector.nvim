local M = {}

function M.get_themes()
  local themes = {}
  local path = vim.fn.stdpath("config") .. "/lua/colorschemes/"
  
  local files = vim.fn.glob(path .. "*.lua", false, true)
  
  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if name ~= "init" then
      table.insert(themes, name)
    end
  end
  
  return themes
end

function M.apply_theme(choice)
  local src = vim.fn.stdpath("config") .. "/lua/colorschemes/" .. choice .. ".lua"
  local dst = vim.fn.stdpath("config") .. "/lua/plugins/colorscheme.lua"

  local file = io.open(src, "r")
  if not file then
    vim.notify("Failed to read : " .. src, vim.log.levels.ERROR)
    return
  end
  local content = file:read("*a")
  file:close()

  local out = io.open(dst, "w")
  if not out then
    vim.notify("Failed to write : " .. dst, vim.log.levels.ERROR)
    return
  end
  out:write(content)
  out:close()

  vim.notify("Theme applied on next launch: " .. choice, vim.log.levels.INFO)
end

function M.open()
  local themes = M.get_themes()

  vim.ui.select(themes, {
    prompt = "Select a theme:",
  }, function(choice)
    if choice then
      M.apply_theme(choice)
    end
  end)
end

function M.setup()
  vim.keymap.set("n", "<leader>ts", M.open, { desc = "Theme Selector" })
end

return M