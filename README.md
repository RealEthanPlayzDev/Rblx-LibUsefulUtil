# NO LONGER MAINTAINED
I no longer want to continue to maintain this. The project is pretty much dead and and I can't get ideas that I can implement here. You are free to fork it if you would like and work from your fork if you need to make changes.

# LibUsefulUtil
LibUsefulUtil is a pack of libraries designed to be expandable and easy to use in the Roblox development environment, it utilizes Rojo aswell.
Currently theres still a small amount of libraries, however I will try to write more when I have more ideas.

# Getting the library
There is 2 ways to get the library, you can:
- Build it yourself (Rojo v6 must be installed) and copy the "LibUsefulUtility" ModuleScript inside ServerScriptService to your game.
- Build using "make" (there is a [Makefile](/Makefile)) (make must be installed, note that "make clean" is still broken at the moment.)
- Download "LibUsefulUtility.rbxlx" and copy the "LibUsefulUtility" ModuleScript inside ServerScriptService to your game.
- Releases page (coming soon)

## Building (using Rojo)
You must have Rojo v6 installed and added to your PATH!
There is 2 project json files, [default.project.json](/default.project.json) which is the default and will build into an rbxmx (Roblox XML Model) file, and [place.project.json](place.project.json) which will build into an rbxlx (Roblox XML Place) file.

- To build LibUsefulUtility into an Roblox XML Model file, you can use either one of the commands below:
```
rojo build -o LibUsefulUtility.rbxmx
```
or
```
rojo default.project.json build --output LibUsefulUtility.rbxmx
```
Then you can import the rbxmx file into your game.

- To build LibUsefulUtility into an Roblox XML Place file, you can use the command below:
```
rojo place.project.json build --output LibUsefulUtility.rbxlx
```
You can find the module in ReplicatedStorage which then you can copy the module into your game or make a script and test it.

## Building (using "make")
You must have the "make" command installed (I believe this is default installed on Linux), if you are using Windows then you can use [Chocolatey](https://chocolatey.org/) to install "make".
**WARNING: the clean function is still not functional!!**
There are 4 commands available:
- all (alias of file)
- file (build into a rbxmx file)
- place (build into a rbxlx file)
- clean (broken)

In order to run these commands do "make [command name]"

# Library list
There are some that are compatible in both server and client, and some only on the server or the client.
- [LibInstUtil](/LibUsefulUtility/LibInstUtil.lua) (Client-Server compatible)
- [LibCustomEvent](/LibUsefulUtility/LibCustomEvent.lua) (Client-Server compatible)
- [LibDiscordWebhookSender](/LibUsefulUtility/LibDiscordWebhookSender.lua) (Only server compatible)
- [LibDiscordEmbedCreator](/LibUsefulUtility/LibDiscordEmbedCreator.lua) (Only server compatible) (Is a part of: LibDiscordWebhookSender)
- [LibDeviceInfo](/LibUsefulUtility/LibDeviceInfo.lua) (Only client compatible)

# License
LibUsefulUtility (Rblx-LibUsefulUtility) is licensed under [GNU General Public License v3.0](/LICENSE)

# Contributing
See the [contribution guide](/CONTRIBUTING.MD) for more information.
