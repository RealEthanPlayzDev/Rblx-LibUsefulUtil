--[[
File name: LibUsefulUtility.lua
Author: RadiatedExodus (RealEthanPlayz)
--]]

local ct = {}
for _, v in ipairs(script:GetChildren()) do
	ct[v.Name] = v
end
return setmetatable(ct, {
	__newindex = function() end,
	__call = function(t, utilname)
		if t[utilname] then
			return require(t[utilname])
		end
		return false
	end,
	__metatable = "This metatable is locked"
})