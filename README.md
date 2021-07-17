# LibUsefulUtil
LibUsefulUtil is a pack of libraries designed to be expandable and easy to use in the Roblox development environment, it utilizes Rojo aswell.
Currently theres still a small amount of libraries, however I will try to write more when I have more ideas.

# Getting the library
There is 2 ways to get the library, you can:
- Build it yourself (Rojo v6 must be installed) and copy the "LibUsefulUtility" ModuleScript inside ServerScriptService to your game.
- Download "LibUsefulUtility.rbxlx" and copy the "LibUsefulUtility" ModuleScript inside ServerScriptService to your game.
- Releases page (coming soon)

# Building
You must have Rojo v6 installed and added to your PATH!
Simply execute the following command below on the project's root folder:
```
rojo build -o LibUsefulUtility.rbxlx
```
Then open LibUsefulUtility.rbxlx and copy the "LibUsefulUtility" ModuleScript inside ServerScriptService to your game.

# Library list
There are some that are compatible in both server and client, and some only on the server or the client.
- [LibInstUtil](/LibUsefulUtility/LibInstUtil.lua) (Client-Server compatible)
- [LibCustomEvent](/LibUsefulUtility/LibCustomEvent.lua) (Client-Server compatible)
- [LibDiscordWebhookSender](/LibUsefulUtility/LibDiscordWebhookSender.lua) (Only server compatible)
- [LibDiscordEmbedCreator](/LibUsefulUtility/LibDiscordEmbedCreator.lua) (Only server compatible) (Is a part of: LibDiscordWebhookSender)
- [LibDeviceInfo](/LibUsefulUtility/LibDeviceInfo.lua) (Only client compatible)

# License
LibUsefulUtility (Rblx-LibUsefulUtility) is licensed under [GNU General Public License v3.0](/LICENSE)