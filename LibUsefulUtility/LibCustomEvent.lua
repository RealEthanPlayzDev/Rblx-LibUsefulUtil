--[[
File name: LibCustomEvent.lua
Author: RadiatedExodus (RealEthanPlayz/RealEthanPlayzDev/ItzEthanPlayz_YT)
Version: 2 (revision 1)
NOTES:
- v2 is more readable
--]]

--// Classes
local LibCustomEventConstructor = {} --// Constructor class
local LibCustomEvent = {} --// Base class
local LibCustomEventConnection = {} --// Connection class

--// Class setup
LibCustomEventConstructor.ClassName = "LibCustomEventConstructor"
LibCustomEvent.ClassName = "LibCustomEvent"
LibCustomEventConnection.ClassName = "LibCustomEventConnection"
--// __index
LibCustomEventConstructor.__index = LibCustomEventConstructor
LibCustomEvent.__index = LibCustomEvent
LibCustomEventConnection.__index = LibCustomEventConnection
--// __tostring
function LibCustomEventConstructor:__tostring()
    return self.ClassName
end
function LibCustomEvent:__tostring()
    return self.ClassName
end
function LibCustomEventConnection:__tostring()
    return self.ClassName
end
--// __newindex
LibCustomEventConstructor.__newindex = function()
    error("LibCustomEventConstructor: Attempt to modify a readonly table", 2)
end
LibCustomEvent.__newindex = function()
    error("LibCustomEvent: Attempt to modify a readonly table", 2)
end
LibCustomEventConnection.__newindex = function()
    error("LibCustomEventConnection: Attempt to modify a readonly table", 2)
end


--// CLASS : LibCustomEventConstructor : CONSTRUCTOR \\--
--// function <LibCustomEvent> LibCustomEventConstructor.new()
function LibCustomEventConstructor.new()
    return setmetatable({
        __LCE_EVENTS = {};
        __LCE_DESTROYED = false;
    }, LibCustomEvent)
end

--// CLASS : LibCustomEvent : BASE CLASS \\
--// function <LibCustomEventConnection> LibCustomEvent:Connect(func: function)
function LibCustomEvent:Connect(func)
    assert(typeof(func) == "function", [[LibCustomEvent: invalid argument #1 to 'Connect' (function expected, got ]]..typeof(func)..[[)]])
    local index = #self.__LCE_EVENTS + 1
    rawset(self.__LCE_EVENTS, index, func)
    return setmetatable({
        __LCEC_LCEINST = self;
        __LCEC_LCEINDEX = index;
    }, LibCustomEventConnection)
end

--// function <void> LibCustomEvent:Fire(...)
function LibCustomEvent:Fire(...)
    for _, func in next, self.__LCE_EVENTS do
        if typeof(func) ~= "function" then continue end
        local ta = {...}
        spawn(function()
            func(unpack(ta))
        end)
    end
end

--// function <void> LibCustomEvent:Fire(...)
function LibCustomEvent:FireSync(...)
    for _, func in next, self.__LCE_EVENTS do
        if typeof(func) ~= "function" then continue end
        xpcall(func, function(err)
            spawn(function()
                error(err, 2)
            end)
        end, ...)
    end
    return
end

--// ALIAS OF LibCustomEvent:Fire(...) : function <void> LibCustomEvent:FireAsync(...)
function LibCustomEvent:FireAsync(...)
    return self:Fire(...)
end

--// CLASS : LibCustomEventConnection : CONNECTION CLASS \\
--// boolean LibCustomEventConnection.Connected
LibCustomEventConnection.Connected = true

--// function <void> LibCustomEventConnection:Disconnect()
function LibCustomEventConnection:Disconnect()
    --// Unregister
    if self.Connected then
        rawset(self.__LCEC_LCEINST.__LCE_EVENTS, self.__LCEC_LCEINDEX, nil)
        rawset(self, "Connected", false)
    end
    --// Cleanup
    rawset(self, "__LCEC_LCEINST", nil)
    rawset(self, "__LCEC_LCEINDEX", nil)
    return
end

--// Return the constructor class
return LibCustomEventConstructor