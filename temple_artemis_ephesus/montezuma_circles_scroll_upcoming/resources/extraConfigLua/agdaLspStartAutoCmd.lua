vim.api.nvim_create_autocmd('FileType', {
    pattern = 'agda',
    callback = function(event)
        vim.lsp.start({
            name = 'agda_ls',
            cmd = {'als'},
            root_dir = vim.fs.root(event.buf, {'lakefile.toml',})
        })
    end,
})
