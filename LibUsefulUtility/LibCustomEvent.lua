--[[
File name: LibCustomEvent.lua
Author: RadiatedExodus (RealEthanPlayz)
--]]

local LibCustomEvent = {}
LibCustomEvent.__index = LibCustomEvent
LibCustomEvent.__newindex = function() end
LibCustomEvent.__metatable = "The metatable is locked"

function LibCustomEvent.new()
    local self = setmetatable({}, LibCustomEvent)

    self.events = {}
    self.isDestroyed = false

    return self
end

function LibCustomEvent:Fire(...)
    for _, v in ipairs(self.events) do
        v(...)
    end
    return
end

function LibCustomEvent:Connect(func)
    assert(typeof(func) == "function", [[LibCustomEvent: invalid argument #1 to 'Connect' (function expected, got ]]..typeof(func)..[[)]])
    table.insert(self.events, #self.events + 1, func)
    return
end

return LibCustomEvent