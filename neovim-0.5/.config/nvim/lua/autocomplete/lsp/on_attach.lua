local on_attach = function(client, bufnr)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    require'lsp_signature'.on_attach()
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = {noremap = true, silent = true}
    -- Lspsga mappings
    -- Async LSP finder
    buf_set_keymap('n', 'gl',
                   '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
    -- Code action
    buf_set_keymap('n', '<leader>ac',
                   '<cmd>lua require("lspsaga.codeaction").code_action()<CR>',
                   opts)
    buf_set_keymap('v', '<leader>ac',
                   ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>',
                   opts)

    -- Hover doc
    buf_set_keymap('n', 'K',
                   '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>',
                   opts)
    buf_set_keymap('n', '<C-f>',
                   '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>',
                   opts)
    buf_set_keymap('n', '<C-b>',
                   '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>',
                   opts)
    buf_set_keymap('n', '<C-k>',
                   '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>',
                   opts)

    -- Rename
    buf_set_keymap('n', '<leader>lr',
                   '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)

    -- Preview definition
    buf_set_keymap('n', '<leader>ld',
                   'require("lspsaga.provider").preview_definition()', opts)

    -- Jump to diagnostics
    buf_set_keymap('n', '[g',
                   '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<cr>',
                   opts)
    buf_set_keymap('n', ']g',
                   '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<cr>',
                   opts)

    -- Show diagnostics
    buf_set_keymap('n', '<leader>ld',
                   '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>',
                   opts)

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    buf_set_keymap('n', '<leader>lt',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>ll',
                   '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap('n', '<leader>lf',
                       '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap('n', '<leader>lf',
                       '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi default link LspReferenceText CursorColumn
        hi default link LspReferenceRead LspReferenceText
        hi default link LspReferenceWrite LspReferenceText
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorHold <buffer> lua require('lspsaga.diagnostic').show_cursor_diagnostics()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

return on_attach
