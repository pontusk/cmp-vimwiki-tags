local utils = require("utils")
local source = {}

source.new = function()
    local self = setmetatable({}, {__index = source})
    self.cache = {}
    return self
end

function source.is_available()
    return vim.bo.filetype == "vimwiki"
end

function source.get_debug_name()
    return "vimwiki-tags"
end

function source.get_trigger_characters()
    return {":"}
end

function source.get_keyword_pattern()
    return [=[\%(\s\|^\)\zs:[[:alnum:]_\-\+]*:\?]=]
end

local function get_vimwiki_tags()
    local file = ".vimwiki_tags"
    local lines = utils.lines_from(file)
    local it = {}
    local used = {}

    for _, v in pairs(lines) do
        local tag = vim.fn.matchstr(v, "^\\S\\+")
        if (not string.match(tag, "^!_.+") and not used[tag]) then
            table.insert(it, {label = ":" .. tag .. ":"})
            used[tag] = true
        end
    end

    return it
end

function source.complete(self, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()
    local items = {}

    if not self.cache[bufnr] then
        items = get_vimwiki_tags()
        if type(items) ~= "table" then
            return callback()
        end
    end

    callback({items = items or {}, isIncomplete = false})
    items = self.cache[bufnr]
end

function source.resolve(completion_item, callback)
    callback(completion_item)
end

function source.execute(completion_item, callback)
    callback(completion_item)
end

return source
