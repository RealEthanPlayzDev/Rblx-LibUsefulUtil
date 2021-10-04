--[[
File name: LibQueuedDebris.lua
Author: RadiatedExodus (ItzEthanPlayz_YT, RealEthanPlayzDev)
Created at: October 4 2021

Reference links:
- https://gist.github.com/RealEthanPlayzDev/379a7f7f1410df30bf983ad1866d1a3c
--]]

--// CLASS QueuedDebris
local QueuedDebris = {}
QueuedDebris.__index = QueuedDebris

--// function QueuedDebris:AddItem(item: Instance, lifetime: number?): nil
function QueuedDebris:AddItem(item: Instance?, lifetime: number?): nil
	if self.__destroyed then return error("QueuedDebris already destroyed", 2) end
	if #self.__queue > self.__maxItems then
		local st = #self.__queue - self.__maxItems
		for i = 1, st do
			local item = self.__queue[self.__maxItems + i]
			if item and typeof(item) == "Instance" and item.Parent ~= nil then
				xpcall(item.Destroy, warn, item)
				self.__queue[self.__maxItems + i] = nil
			else
				self.__queue[self.__maxItems + i] = nil
			end
		end
	end
	
	task.delay((lifetime or 0), function()
		if item and typeof(item) == "Instance" then
			xpcall(item.Destroy, warn, item)
		end
	end)
	table.insert(self.__queue, item)
	return nil
end

--// function QueuedDebris:AddItem(item: Instance, lifetime: number?): nil
function QueuedDebris:SetMaxItems(amount: number): nil
	assert(typeof(amount) == "number", ("invalid argument #1 to 'SetMaxItems' (number expected, got %s)"):format(typeof(amount)))
	self.maxItems = tonumber(amount)
	return nil
end

--// DESTROYER QueuedDebris:Destroy()
function QueuedDebris:Destroy()
	self.__destroyed = true
	for i, inst in pairs(self.__queue) do
		if inst and typeof(inst) == "Instance" then
			xpcall(inst.Destroy, warn, inst)
			self.__queue[i] = nil
		else
			self.__queue[i] = nil
		end
	end
end

return {
	--// CONSTRUCTOR
	new = function(maxItems: number?)
		return setmetatable({
			__maxItems = tonumber(maxItems) or 1000;
			__queue = {};
			__destroyed = false;
		}, QueuedDebris)
	end,
}