local stone_eater = {}

stone_eater.set_highlights = function(colors)
  vim.api.nvim_set_hl(0, "Type", { fg="NvimLightYellow" })
  vim.api.nvim_set_hl(0, "StatusLine", { fg="NvimLightGrey3", bg="NvimDarkGrey3" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg="NvimDarkGrey3", bold=true })

  vim.api.nvim_set_hl(0, "Macro", { bold=true })
  vim.api.nvim_set_hl(0, "Include", { link="Macro" })

  vim.api.nvim_set_hl(0, "Constant", { fg="#99e6d5" })
  vim.api.nvim_set_hl(0, "Number", { link="Constant" })

  vim.api.nvim_set_hl(0, "String", { fg="#90a959" })

  vim.api.nvim_set_hl(0, "Identifier", { fg="NvimLightGrey2" })
  vim.api.nvim_set_hl(0, "BlinkCmpKind", { link="Identifier" })

  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg="#90a959" })

  local blue = "#8ec0ef"
  vim.api.nvim_set_hl(0, "Function", { fg=blue })
  vim.api.nvim_set_hl(0, "Special", { link="Function" })
end

return stone_eater
