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
		local indexed = t[table.find(t, utilname or nil)]
		if indexed then
			return require(indexed)
		end
		return false
	end,
	__metatable = "This metatable is locked"
})