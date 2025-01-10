local stone_eater = {}

stone_eater.set_highlights = function(colors)
  vim.api.nvim_set_hl(0, "Type", { fg="NvimLightYellow" })
  vim.api.nvim_set_hl(0, "StatusLine", { fg="NvimLightGrey3", bg="NvimDarkGrey3" })

  vim.api.nvim_set_hl(0, "Macro", { bold=true })
  vim.api.nvim_set_hl(0, "Include", { link="Macro" })

  vim.api.nvim_set_hl(0, "Constant", { fg="#99e6d5" })
  vim.api.nvim_set_hl(0, "Number", { link="Constant" })

  vim.api.nvim_set_hl(0, "String", { fg="#8cdd92" })

  vim.api.nvim_set_hl(0, "BlinkCmpKind", { link="Normal" })
  vim.api.nvim_set_hl(0, "Identifier", { link="Normal" })

  local blue = "#8ec0ef"
  vim.api.nvim_set_hl(0, "Function", { fg=blue })
  vim.api.nvim_set_hl(0, "Special", { link="Function" })
end

return stone_eater
