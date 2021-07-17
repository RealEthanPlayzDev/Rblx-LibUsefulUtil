--[[
File name: DeviceInfo.lua
Author: RadiatedExodus (RealEthanPlayz/RealEthanPlayzDev/ItzEthanPlayz_YT)
Reference links:
- https://realethanplayzdev.github.io/Device%20Info/Device%20Info/
- https://www.roblox.com/library/5343169924/Device-Info
- https://devforum.roblox.com/t/device-info-LibDeviceInfo-to-detect-devices-platform-type-etc/716491
NOTES:
- This was originally an old LibDeviceInfo I made at July 2020, original links are posted on the reference links above.
- The account I used to post the Roblox DevForum post of DeviceInfo was terminated from the DevForum due to a mistake I made, I hope I will never do something like that again...
- The old API Reference on my page no longer matches this version (as I have rewritten this module), please do not use the API reference from there and wait until I remake my website.
    --]]

local LibDeviceInfo = {}
assert(not game:GetService("RunService"):IsServer(), "[DeviceInfo]: DeviceInfo can only be used to the server.")

local serv = {
    UserInputService = game:GetService("UserInputService");
    GuiService = game:GetService("GuiService")
}

local previnput, prevres, prevorientation, prevquality

local inputChanged = Instance.new("BindableEvent")
local resolutionChanged = Instance.new("BindableEvent")
local orientationChanged = Instance.new("BindableEvent")
local graphicsQualityChanged = Instance.new("BindableEvent")

--// Custom Enum creation
LibDeviceInfo.Enum = setmetatable({
	PlatformType = {
		Computer = "PlatformType_Computer",
		Console = "PlatformType_Console",
		Mobile = "PlatformType_Mobile"
	},
	InputType = {
		Touchscreen = "InputType_Touchscreen",
		KeyboardMouse = "InputType_KeyboardMouse",
		Gamepad = "InputType_Gamepad",
		VR = "InputType_VR",
		Keyboard = "InputType_Keyboard",
		Mouse = "InputType_Mouse"
	},
	DeviceType = {
		Computer = "DeviceType_Computer",
		Phone = "DeviceType_Phone",
		Tablet = "DeviceType_Tablet",
		Console = "DeviceType_Console",
		TouchscreenComputer = "DeviceType_TouchscreenComputer"
	},
	DeviceOrientation = {
		Landscape = "DeviceOrientation_Landscape",
		Portrait = "DeviceOrientation_Portrait"
	}
}, { __newindex = function() end; __metatable = "The metatable is locked"; })

--// function <Vector2> LibDeviceInfo.GetRobloxWindowResolution()
function LibDeviceInfo.GetRobloxWindowResolution()
	prevres = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X, game.Workspace.CurrentCamera.ViewportSize.Y)
	return prevres
end

--// function <PlatformType> LibDeviceInfo.GetDevicePlatform()
function LibDeviceInfo.GetDevicePlatform()
	if serv.GuiService:IsTenFootInterface() and serv.UserInputService.GamepadEnabled and not serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled then
		return LibDeviceInfo.Enum.PlatformType.Console
	elseif serv.UserInputService.TouchEnabled and not serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled then
		return LibDeviceInfo.Enum.PlatformType.Mobile
	else
		return LibDeviceInfo.Enum.PlatformType.Computer
	end
end

--// function <InputType> LibDeviceInfo.GetDeviceInput()
function LibDeviceInfo.GetDeviceInput()
    --// KeyboardMouse
	if serv.UserInputService.KeyboardEnabled and serv.UserInputService.MouseEnabled and not serv.UserInputService.GamepadEnabled and not serv.UserInputService.TouchEnabled then
		previnput = LibDeviceInfo.Enum.InputType.KeyboardMouse
		return LibDeviceInfo.Enum.InputType.KeyboardMouse
	
    --// Keyboard
	elseif serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled and not serv.UserInputService.GamepadEnabled and not serv.UserInputService.TouchEnabled then
		previnput = LibDeviceInfo.Enum.InputType.Keyboard
		return LibDeviceInfo.Enum.InputType.Keyboard
		
    --// Mouse
	elseif not serv.UserInputService.KeyboardEnabled and serv.UserInputService.MouseEnabled and not serv.UserInputService.GamepadEnabled and not serv.UserInputService.TouchEnabled then
		previnput = LibDeviceInfo.Enum.InputType.Mouse
		return LibDeviceInfo.Enum.InputType.Mouse
		
    --// Gamepad
	elseif not serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled and serv.UserInputService.GamepadEnabled and not serv.UserInputService.TouchEnabled then
		previnput = LibDeviceInfo.Enum.InputType.Gamepad
		return LibDeviceInfo.Enum.InputType.Gamepad
		
    --// VR
	elseif serv.UserInputService.VREnabled then
		previnput = LibDeviceInfo.Enum.InputType.VR
		return LibDeviceInfo.Enum.InputType.VR
		
    --// Touchscreen
	else
		previnput = LibDeviceInfo.Enum.InputType.Touchscreen
		return LibDeviceInfo.Enum.InputType.Touchscreen
	end
end

--// function <DeviceOrientation> LibDeviceInfo.GetDeviceOrientation()
function LibDeviceInfo.GetDeviceOrientation()
	if LibDeviceInfo.GetDevicePlatform() ~= LibDeviceInfo.Enum.PlatformType.Mobile then return end
	local isPortrait = game.Workspace.Camera.ViewportSize.X < game.Workspace.Camera.ViewportSize.Y
	if isPortrait then
		return LibDeviceInfo.Enum.DeviceOrientation.Portrait
	else
		return LibDeviceInfo.Enum.DeviceOrientation.Landscape
	end
end

--// function <DeviceType> LibDeviceInfo.GetDeviceType()
function LibDeviceInfo.GetDeviceType()
    --// Console
	if serv.GuiService:IsTenFootInterface() and serv.UserInputService.GamepadEnabled and not serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled then
		return LibDeviceInfo.Enum.DeviceType.Console
		
    --// Tablet/Phone
	elseif not serv.GuiService:IsTenFootInterface() and serv.UserInputService.TouchEnabled and not serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled then
		local deviceOrientation = LibDeviceInfo.GetDeviceOrientation()
		if deviceOrientation == LibDeviceInfo.Enum.DeviceOrientation.Landscape then
			
			if workspace.CurrentCamera.ViewportSize.Y < 600 then
				return LibDeviceInfo.Enum.DeviceType.Phone
            end
			return LibDeviceInfo.Enum.DeviceType.Tablet
		elseif deviceOrientation ==  LibDeviceInfo.Enum.DeviceOrientation.Portrait then
			if workspace.CurrentCamera.ViewportSize.X < 600 then
				return LibDeviceInfo.Enum.DeviceType.Phone
            end
			return LibDeviceInfo.Enum.DeviceType.Tablet
		end
		
    --// TouchscreenComputer
	elseif serv.UserInputService.TouchEnabled and serv.UserInputService.KeyboardEnabled and serv.UserInputService.MouseEnabled then
		return LibDeviceInfo.Enum.DeviceType.TouchscreenComputer
		
    --// Computer
	else
		return LibDeviceInfo.Enum.DeviceType.Computer
	end
end

--// function <QualityLevel> LibDeviceInfo.GetGraphicsQuality()
function LibDeviceInfo.GetGraphicsQuality()
	return UserSettings().GameSettings.SavedQualityLevel
end

serv.UserInputService.LastInputTypeChanged:Connect(function()
	--// KeyboardMouse
	if serv.UserInputService.KeyboardEnabled and serv.UserInputService.MouseEnabled and not serv.UserInputService.GamepadEnabled and not serv.UserInputService.TouchEnabled then
		if previnput == LibDeviceInfo.Enum.InputType.KeyboardMouse then return end
		inputChanged:Fire(LibDeviceInfo.Enum.InputType.KeyboardMouse)
		
    --// Keyboard
	elseif serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled and not serv.UserInputService.GamepadEnabled and not serv.UserInputService.TouchEnabled then
		if previnput == LibDeviceInfo.Enum.InputType.Keyboard then return end
		inputChanged:Fire(LibDeviceInfo.Enum.InputType.Keyboard)
		
    --// Mouse
	elseif not serv.UserInputService.KeyboardEnabled and serv.UserInputService.MouseEnabled and not serv.UserInputService.GamepadEnabled and not serv.UserInputService.TouchEnabled then
		if previnput == LibDeviceInfo.Enum.InputType.Mouse then return end
		inputChanged:Fire(LibDeviceInfo.Enum.InputType.Mouse)
		
    --// Gamepad
	elseif not serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled and serv.UserInputService.GamepadEnabled and not serv.UserInputService.TouchEnabled then
		if previnput == LibDeviceInfo.Enum.InputType.Gamepad then return end
		inputChanged:Fire(LibDeviceInfo.Enum.InputType.Gamepad)
		
    --// VR
	elseif serv.UserInputService.VREnabled then
		if previnput == LibDeviceInfo.Enum.InputType.VR then return end
		inputChanged:Fire(LibDeviceInfo.Enum.InputType.VR)

	--// Touchscreen
	else
		if previnput == LibDeviceInfo.Enum.InputType.Touchscreen then return end
		inputChanged:Fire(LibDeviceInfo.Enum.InputType.Touchscreen)
	end
end)

local oldcamsignal = nil

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    if oldcamsignal then
        oldcamsignal:Disconnect()
        oldcamsignal = nil 
    end
    oldcamsignal = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        --// Size changed
        if game.Workspace.CurrentCamera.ViewportSize.X ~= prevres.X and game.Workspace.CurrentCamera.ViewportSize.X ~= prevres.Y then
            prevres = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X, game.Workspace.CurrentCamera.ViewportSize.Y)
            resolutionChanged:Fire(Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X, game.Workspace.CurrentCamera.ViewportSize.Y))
        end
        
        --// Orientation changed
        local newOrientation = LibDeviceInfo.GetDeviceOrientation()
        if newOrientation ~= prevorientation then
            if newOrientation == LibDeviceInfo.Enum.DeviceOrientation.Portrait then
                orientationChanged:Fire(LibDeviceInfo.Enum.DeviceOrientation.Portrait) 
            elseif newOrientation == LibDeviceInfo.Enum.DeviceOrientation.Landscape then
                orientationChanged:Fire(LibDeviceInfo.Enum.DeviceOrientation.Landscape) 
            end
        end
    end)
end)

UserSettings().GameSettings.Changed:Connect(function()
	local quality = LibDeviceInfo.GetGraphicsQuality()
	if quality == prevquality then return end
    graphicsQualityChanged:Fire(quality)
end)

LibDeviceInfo.inputTypeChanged = inputChanged.Event
LibDeviceInfo.screenSizeChanged = resolutionChanged.Event
LibDeviceInfo.screenOrientationChanged = orientationChanged.Event
LibDeviceInfo.graphicsQualityChanged = graphicsQualityChanged.Event

return LibDeviceInfo