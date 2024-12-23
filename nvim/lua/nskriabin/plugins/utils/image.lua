return {
    "3rd/image.nvim",
    opts = {
        processor = "magick_cli",
        integrations = {
            markdown = {
                only_render_image_at_cursor = true,
            },
        },
    },
}
