-- NVIM tree

require('nvim-tree').setup({
  -- Allow using gx
  disable_netrw = false,
  hijack_netrw = false,
  update_cwd = true,
  view = {
    width = 50,
    side = "left",
    -- auto_resize = true,
    number = false,
    relativenumber = false,
  },
})
