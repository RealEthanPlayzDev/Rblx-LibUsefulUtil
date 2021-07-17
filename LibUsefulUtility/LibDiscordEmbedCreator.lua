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
LibDiscordEmbedCreator.ClassName = "LibDiscordEmbedCreator"

local LibDiscordEmbedFieldCreator = {}
LibDiscordEmbedFieldCreator.__index = LibDiscordEmbedFieldCreator
LibDiscordEmbedFieldCreator.__metatable = "The metatable is locked"

--// LibDiscordEmbedCreator class
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
    assert(typeof(newcolor) == "number", [[LibDiscordEmbedCreator: invalid argument #1 to 'SetColor' (number expected, got ]]..typeof(newcolor)..[[)]])
    self.embedtable.color = tostring(newcolor)
    return self
end

--// function <LibDiscordEmbedCreator> LibDiscordEmbedCreator:AddField(fieldname: string, fieldvalue: string, inline: boolean)
function LibDiscordEmbedCreator:AddField(fieldname: string, fieldvalue: string, inline)
    assert(typeof(fieldname) == "string", [[LibDiscordEmbedCreator: invalid argument #1 to 'AddField' (string expected, got ]]..typeof(fieldname)..[[)]])
    assert(typeof(fieldvalue) == "string", [[LibDiscordEmbedCreator: invalid argument #2 to 'AddField' (string expected, got ]]..typeof(fieldvalue)..[[)]])
    local newfield = LibDiscordEmbedFieldCreator.new(fieldname, fieldvalue, inline or false)
    table.insert(self.embedtable.fields, #self.embedtable.fields + 1, newfield.fieldtable)
    return newfield
end

--// function <LibDiscordEmbedCreator> LibDiscordEmbedCreator:SetFooterText(newfootername: string)
function LibDiscordEmbedCreator:SetFooterText(newfootertext: string)
    assert(typeof(newfootertext) == "string", [[LibDiscordEmbedCreator: invalid argument #1 to 'SetFooterText' (string expected, got ]]..typeof(newfootertext)..[[)]])
    self.embedtable.footer.text = tostring(newfootertext)
    return self
end

--// function <LibDiscordEmbedCreator> LibDiscordEmbedCreator:SetFooterIconURL(newfootername: string)
function LibDiscordEmbedCreator:SetFooterIconURL(newiconurl: string)
    assert(typeof(newiconurl) == "string", [[LibDiscordEmbedCreator: invalid argument #1 to 'SetFooterIconURL' (string expected, got ]]..typeof(newiconurl)..[[)]])
    self.embedtable.footer.icon_url = tostring(newiconurl)
    return self
end

--// LibDiscordEmbedFieldCreator class
--// [internal class usage]
function LibDiscordEmbedFieldCreator.new(name: string, value: string, inline: boolean)
    local self = setmetatable({}, LibDiscordEmbedFieldCreator)

    self.fieldtable = {
        name = name;
        value = value;
        inline = inline;
    }

    return self
end

--// function <LibDiscordEmbedFieldCreator> LibDiscordEmbedFieldCreator:SetFieldName(newname: string)
function LibDiscordEmbedFieldCreator:SetFieldName(newname: string)
    assert(typeof(newname) == "string", [[LibDiscordEmbedFieldCreator: invalid argument #1 to 'SetFieldName' (string expected, got ]]..typeof(newname)..[[)]])
    self.fieldtable.name = tostring(newname)
    return self
end

--// function <LibDiscordEmbedFieldCreator> LibDiscordEmbedFieldCreator:SetFieldValue(newvalue: string)
function LibDiscordEmbedFieldCreator:SetFieldValue(newvalue: string)
    assert(typeof(newvalue) == "string", [[LibDiscordEmbedFieldCreator: invalid argument #1 to 'SetFieldValue' (string expected, got ]]..typeof(newvalue)..[[)]])
    self.fieldtable.value = tostring(newvalue)
    return self
end

--// function <LibDiscordEmbedFieldCreator> LibDiscordEmbedFieldCreator:SetFieldInline(newinline: boolean)
function LibDiscordEmbedFieldCreator:SetFieldInline(newinline: boolean)
    assert(typeof(newinline) == "boolean", [[LibDiscordEmbedFieldCreator: invalid argument #1 to 'SetFieldInline' (boolean expected, got ]]..typeof(newinline)..[[)]])
    self.fieldtable.inline = newinline
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
            footer = { text = ""; icon_url = ""; };
        }

        return self
    end
}