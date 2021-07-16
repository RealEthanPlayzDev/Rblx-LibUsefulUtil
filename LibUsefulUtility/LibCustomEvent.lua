--[[
File name: LibCustomEvent.lua
Author: RadiatedExodus (RealEthanPlayz)
--]]

local LibCustomEvent = {}
LibCustomEvent.__index = LibCustomEvent
--// LibCustomEvent.__newindex = function() end
LibCustomEvent.__metatable = "The metatable is locked"

function LibCustomEvent:Fire(...)
    assert(not self.isDestroyed, [[LibCustomEvent: this event has been destroyed and no longer can be used]])
    for _, v in ipairs(self.events) do
        if not typeof(v) == "function" then continue end
        v(...)
    end
    return
end

function LibCustomEvent:Connect(func)
    assert(not self.isDestroyed, [[LibCustomEvent: this event has been destroyed and no longer can be used]])
    assert(typeof(func) == "function", [[LibCustomEvent: invalid argument #1 to 'Connect' (function expected, got ]]..typeof(func)..[[)]])
    table.insert(self.events, #self.events + 1, func)
    return
end

function LibCustomEvent:Destroy()
    self.isDestroyed = true
    table.clear(self.events)
    return
end

return {
	new = function()
		local newevent = setmetatable({}, LibCustomEvent)

		newevent.events = {}
		newevent.isDestroyed = false

		return newevent
	end
}