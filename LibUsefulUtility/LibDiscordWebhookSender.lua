--[[
File name: LibDiscordWebhookSender.lua
Author: RadiatedExodus (RealEthanPlayz/RealEthanPlayzDev/ItzEthanPlayz_YT)
--]]

local serv = {
    HttpService = game:GetService("HttpService");
}

local LibDiscordWebhookSender = {}
LibDiscordWebhookSender.__index = LibDiscordWebhookSender
LibDiscordWebhookSender.__metatable = "This metatable is locked"
LibDiscordWebhookSender.ClassName = "LibDiscordWebhookSender"

local function CheckHttpEnabled()
    return pcall(function()
        serv.HttpService:GetAsync("https://www.google.com")
        return true
    end)
end

--// function <boolean> LibDiscordWebhookSender:SendData()
function LibDiscordWebhookSender:SendData()
    --// https://developer.roblox.com/en-us/api-reference/function/HttpService/RequestAsync
    assert(CheckHttpEnabled(), "LibDiscordWebhookSender: Http requests are not enabled. Enable via game settings")
    local sendsuccess, sendattempt, sendresult = false, 0, nil
    sendsuccess, sendresult = pcall(function()
        return serv.HttpService:RequestAsync({
            Url = tostring(self.webhookurl);
            Method = "POST";
            Headers = { ["Content-Type"] = "application/json" };
            Body = serv.HttpService:JSONEncode(self.webhookluatabledata)
        })
    end)

    if sendsuccess and sendresult.Success == true then
        return true
    else
        return error("LibDiscordWebhookSender: unable to send webhook data\nStatusCode: "..sendresult.StatusCode.."\nStatusMessage: "..sendresult.StatusMessage, 2)
    end
end

--// function <LibDiscordWebhookSender> LibDiscordWebhookSender:SetUsername(newname: string)
function LibDiscordWebhookSender:SetUsername(newname: string)
    assert(typeof(newname) == "string", [[LibDiscordWebhookSender: invalid argument #1 to 'SetUsername' (string expected, got ]]..typeof(newname)..[[)]])
    self.webhookluatabledata.username = tostring(newname)
    return self
end

--// function <LibDiscordWebhookSender> LibDiscordWebhookSender:SetAvatarUrl(newavatarurl: string)
function LibDiscordWebhookSender:SetAvatarUrl(newavatarurl: string)
    assert(typeof(newavatarurl) == "string", [[LibDiscordWebhookSender: invalid argument #1 to 'SetAvatarUrl' (string expected, got ]]..typeof(newavatarurl)..[[)]])
    self.webhookluatabledata.avatar_url = tostring(newavatarurl)
    return self
end

--// function <LibDiscordWebhookSender> LibDiscordWebhookSender:SetAvatarUrl(newavatarurl: string)
function LibDiscordWebhookSender:SetContent(newcontent: string)
    assert(typeof(newcontent) == "string", [[LibDiscordWebhookSender: invalid argument #1 to 'SetContent' (string expected, got ]]..typeof(newcontent)..[[)]])
    self.webhookluatabledata.content = tostring(newcontent)
    return self
end

return {
    --// [constructor] function <LibDiscordWebhookSender> new(webhookurl: string)
    new = function(webhookurl: string)
        assert(typeof(webhookurl) == "string", [[LibDiscordWebhookSender: invalid argument #1 to 'new' (string expected, got ]]..typeof(webhookurl)..[[)]])
        local self = setmetatable({}, LibDiscordWebhookSender)

        self.webhookurl = webhookurl
        self.webhookluatabledata = {
            username = ""; --// Webhook username
            avatar_url = ""; --// Webhook avatar
            content = ""; --// Webhook message (max 2000 characters as defined by Discord)
            embeds = {}; --// Webhook embeds
        }

        return self
    end
}