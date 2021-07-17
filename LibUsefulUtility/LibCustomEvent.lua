--[[
File name: LibCustomEvent.lua
Author: RadiatedExodus (RealEthanPlayz/RealEthanPlayzDev/ItzEthanPlayz_YT)
--]]

local LibCustomEvent = {}
local LibCustomEventConnected = {}
LibCustomEvent.__index = LibCustomEvent
LibCustomEventConnected.__index = LibCustomEventConnected

LibCustomEvent.__metatable = "The metatable is locked"
LibCustomEventConnected.__metatable = "The metatable is locked"

--// LibCustomEvent class
--// function <void> LibCustomEvent:Fire(... : variant)
function LibCustomEvent:Fire(...)
    assert(not self.isDestroyed, [[LibCustomEvent: this event has been destroyed and no longer can be used]])
    for _, v in ipairs(self.events) do
        if not typeof(v) == "function" then continue end
        local temp = {...}
        spawn(function() 
            v(unpack(temp))
        end)
    end
    return
end

--// function <LibCustomEventConnected> LibCustomEvent:Connect(func: function)
function LibCustomEvent:Connect(func)
    assert(not self.isDestroyed, [[LibCustomEvent: this event has been destroyed and no longer can be used]])
    assert(typeof(func) == "function", [[LibCustomEvent: invalid argument #1 to 'Connect' (function expected, got ]]..typeof(func)..[[)]])
    local selindex = #self.events + 1
    table.insert(self.events, selindex, func)
    return LibCustomEventConnected.new(self, selindex)
end

--// [deconstructor] function <void> LibCustomEvent:Destroy()
function LibCustomEvent:Destroy()
    self.isDestroyed = true
    table.clear(self.events)
    return
end

--// LibCustomEventConnected class
--// [internal class usage]
function LibCustomEventConnected.new(eventinst, index)
    local newconnectedevent = setmetatable({}, LibCustomEventConnected)

    newconnectedevent.eventinst = eventinst
    newconnectedevent.currentindex = index
    newconnectedevent.Connected = true

    return newconnectedevent
end

--// function <void> LibCustomEventConnected:Disconnect()
function LibCustomEventConnected:Disconnect()
    table.remove(self.eventinst.events, self.currentindex)
    self.Connected = false
    return
end

return {
    --// constructor
	new = function()
		local newevent = setmetatable({}, LibCustomEvent)

		newevent.events = {}
		newevent.isDestroyed = false

		return newevent
	end
}