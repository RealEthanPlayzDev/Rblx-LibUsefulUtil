--[[
File name: LibInstUtil.lua
Author: RadiatedExodus (RealEthanPlayz)
--]]

local LibInstUtil = {}

--// function <number> LibInstUtil.CalculateTotalMass(inst: Instance)
function LibInstUtil.CalculateTotalMass(inst: Instance)
    assert(typeof(inst) == "Instance", [[LibInstUtil: invalid argument #2 to 'Create' (Instance expected, got ]]..typeof(inst)..[[)]])
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

--// function <Instance> LibInstUtil.Create(classname: string, data: table)
function LibInstUtil.Create(classname: string, data: table)
    assert(typeof(classname) == "string", [[LibInstUtil: invalid argument #1 to 'Create' (string expected, got ]]..typeof(classname)..[[)]])
    assert(typeof(data) == "table", [[LibInstUtil: invalid argument #2 to 'Create' (table expected, got ]]..typeof(classname)..[[)]])
    local newinst = Instance.new(classname)
    local parentpropertyavailable = nil
    for property, value in pairs(data) do
        if not property == "Parent" then
            newinst[property] = value
        else
            parentpropertyavailable = value
        end
    end
    if parentpropertyavailable then newinst.Parent = parentpropertyavailable end
    parentpropertyavailable = nil
    return newinst
end

--// function <void> LibInstUtil.SetAllBasePartTransparency(inst: Instance, newtransparency: number)
function LibInstUtil.SetAllBasePartTransparency(inst: Instance, newtransparency: number)
    assert(typeof(inst) == "Instance", [[LibInstUtil: invalid argument #1 to 'SetAllBasePartTransparency' (Instance expected, got ]]..typeof(inst)..[[)]])
    assert(typeof(newtransparency) == "Instance", [[LibInstUtil: invalid argument #2 to 'SetAllBasePartTransparency' (number expected, got ]]..typeof(newtransparency)..[[)]])
    if inst:IsA("BasePart") then
        inst.Transparency = newtransparency
    else
        for _, v in pairs(inst:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = newtransparency
            end
        end
    end
    return
end

return LibInstUtil