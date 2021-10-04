--[[
File name: LibBetterRequire.lua
Author: RadiatedExodus (RealEthanPlayz/RealEthanPlayzDev/ItzEthanPlayz_YT)
Version: 1

An better version of require that allows loading latest version of id modules. (but doesn't work if the owner does not own the module)
]]

local serv = {
    InsertService = game:GetService("InsertService");
    RunService = game:GetService("RunService")
}

return function(assetId)
    if typeof(assetId) == "number" or tonumber(assetId) then
        assert(serv.RunService:IsServer(), ("require(assetId) cannot be called from a client. assetId = "):format(tostring(assetId)))
        return require(serv.InsertService:LoadAssetVersion(serv.InsertService:GetLatestAssetVersionAsync(tonumber(assetId))):GetChildren()[1])
    elseif typeof(assetId) == "Instance" and assetId:IsA("ModuleScript") then
        return require(assetId)
    else
        return error("Attempted to call require with invalid argument(s).", 2)
    end
end