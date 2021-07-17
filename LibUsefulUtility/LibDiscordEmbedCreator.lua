--[[
File name: LibDiscordEmbedCreator.lua
Author: RadiatedExodus (RealEthanPlayz/RealEthanPlayzDev/ItzEthanPlayz_YT)
Reference links:
- https://discord.com/developers/docs/resources/channel#embed-object
- https://discord.com/developers/docs/resources/channel#embed-object-embed-field-structure
- https://discord.com/developers/docs/resources/channel#embed-object-embed-footer-structure
- https://discord.com/developers/docs/resources/channel#embed-object-embed-author-structure

NOTES:
- I do not have plans to implement image nor thumbnail types yet. I can implement them but I need to research Roblox's ToS further to see if they allow it.
--]]

local LibDiscordEmbedCreator = {}
LibDiscordEmbedCreator.__index = LibDiscordEmbedCreator
LibDiscordEmbedCreator.__metatable = "The metatable is locked"

--// function <LibDiscordEmbedCreator> LibDiscordEmbedCreator:SetTitle(newtitle: string)
function LibDiscordEmbedCreator:SetTitle(newtitle: string)
    assert(typeof(newtitle) == "string", [[LibDiscordEmbedCreator: invalid argument #1 to 'SetTitle' (string expected, got ]]..typeof(newtitle)..[[)]])
    self.embedtable.title = tostring(newtitle)
    return self
end

--// function <LibDiscordEmbedCreator> LibDiscordEmbedCreator:SetDescription(newdesc: string)
function LibDiscordEmbedCreator:SetDescription(newdesc: string)
    assert(typeof(newdesc) == "string", [[LibDiscordEmbedCreator: invalid argument #1 to 'SetDescription' (string expected, got ]]..typeof(newdesc)..[[)]])
    self.embedtable.description = tostring(newdesc)
    return self
end

--// function <LibDiscordEmbedCreator> LibDiscordEmbedCreator:SetColor(newdesc: number)
function LibDiscordEmbedCreator:SetColor(newcolor: string)
    assert(typeof(newcolor) == "number", [[LibDiscordEmbedCreator: invalid argument #1 to 'SetDescription' (number expected, got ]]..typeof(newcolor)..[[)]])
    self.embedtable.color = tostring(newcolor)
    return self
end

--// function <LibDiscordEmbedCreator> LibDiscordEmbedCreator:SetColor(newdesc: number)
function LibDiscordEmbedCreator:SetColor(newcolor: string)
    assert(typeof(newcolor) == "number", [[LibDiscordEmbedCreator: invalid argument #1 to 'SetDescription' (number expected, got ]]..typeof(newcolor)..[[)]])
    self.embedtable.color = tostring(newcolor)
    return self
end

return {
    --// [constructor] function new()
    new = function()
        local self = setmetatable({}, LibDiscordEmbedCreator)

        self.embedtable = {
            title = "";
            description = "";
            color = 0x00000;
            fields = {};
            footer = {};

        }

        return self
    end
}