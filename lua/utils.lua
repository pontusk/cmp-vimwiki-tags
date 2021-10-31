local utils = {}

utils.lines_from = function(file)
    if not utils.file_exists(file) then
        return {}
    end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

return utils
