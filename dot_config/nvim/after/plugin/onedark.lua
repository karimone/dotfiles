local is_onedark_present, onedark = pcall(require, 'onedark')

if is_onedark_present then
    onedark.setup {
        style = 'darker'
    }
    onedark.load()
end
