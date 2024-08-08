return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    require("bufferline").setup {
      options = {
        themable = true,
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    }
  end
}
