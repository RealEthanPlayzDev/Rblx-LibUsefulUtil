--[[
File name: LibInstUtil.lua
Author: RadiatedExodus (RealEthanPlayz)
--]]

local LibInstUtil = {}

--// function <number> LibInstUtil.CalculateTotalMass(inst: Instance)
function LibInstUtil.CalculateTotalMass(inst)
    assert(typeof(inst) == "Instance", "LibInstUtil.CalculateTotalMass: expected value type Instance, given value type "..typeof(inst))
    if inst:IsA("BasePart") then
        return inst.Mass
    elseif inst:IsA("Model") then
        local masscount = 0
        for _, v in pairs(inst:GetDescendants()) do
            if v:IsA("BasePart") then
                masscount += v.Mass
            end
        end
    end
end

return LibInstUtil