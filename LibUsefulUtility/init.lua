--[[
File name: LibUsefulUtility.lua
Author: RadiatedExodus (RealEthanPlayz)
--]]

local ci = script:GetChildren()
return setmetatable(ci, {
	__call = function(t, utilname)
		local indexed = ci[table.find(ci, utilname or nil)]
		if indexed then
			return require(indexed)
		end
		return false
	end,
})