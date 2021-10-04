--!strict
--[[
File name: DeviceInfo.lua
Author: RadiatedExodus (ItzEthanPlayz_YT/RealEthanPlayzDev)
Version: 2

IMPORTANT NOTE: As of October 4 2021, I have noticed many ways that device detection or platform detection can be false, I no longer gurantee they 100% work and detect as expected.

Reference links:
- https://realethanplayzdev.github.io/Device%20Info/Device%20Info/
- https://www.roblox.com/library/5343169924/Device-Info
- https://devforum.roblox.com/t/device-info-LibDeviceInfo-to-detect-devices-platform-type-etc/716491
--]]

local serv = {
	StarterGui = game:GetService("StarterGui");
	UserInputService = game:GetService("UserInputService");
	GuiService = game:GetService("GuiService");
	RunService = game:GetService("RunService");
}

assert(serv.RunService:IsServer(), "DeviceInfo only runs on the client, not the server")

--// CLASS DeviceInfo
local DeviceInfo = {}

--// Luau custom types
export type DeviceInfo = {
	--// enums
	--// DeviceInfoEnum.PlatformType DeviceInfo.PlatformType
	PlatformType: {
		Computer: string;
		Console: string;
		Mobile: string;
	};
	
	--// DeviceInfoEnum.InputType DeviceInfo.InputType
	InputType: {
		Touchscreen: string;
		KeyboardMouse: string;
		Gamepad: string;
		VR: string;
		Keyboard: string;
		Mouse: string;
	};
	
	--// DeviceInfoEnum.DeviceType DeviceInfo.DeviceType
	DeviceType: {
		Computer: string;
		Phone: string;
		Tablet: string;
		Console: string;
		TouchscreenComputer: string;
	};
	
	--// DeviceInfoEnum.DeviceOrientation DeviceInfo.DeviceOrientation
	DeviceOrientation: {
		Landscape: string;
		Portrait: string;
	};

	--// functions
	--// function DeviceInfo.GetDevicePlatform(): DeviceInfoEnum.PlatformType
	GetDevicePlatform: any;

	--// function DeviceInfo.GetDeviceOrientation(): DeviceInfoEnum.DeviceOrientation
	GetDeviceOrientation: any;

	--// function DeviceInfo.GetWindowResolution(): Vector2
	GetWindowResolution: any;

	--// function DeviceInfo.GetDeviceInput(): DeviceInfoEnum.InputType
	GetDeviceInput: any;

	--// function DeviceInfo.GetDeviceType(): DeviceInfoEnum.DeviceType
	GetDeviceType: any;

	--// function DeviceInfo.GetGraphicsQuality(): Enum.SavedQualitySetting
	GetGraphicsQuality: any;

	--// Bindables
	--// RBXScriptSignal DeviceInfo.InputChanged: DeviceInfoEnum.InputType
	InputChanged: RBXScriptSignal;

	--// RBXScriptSignal DeviceInfo.WindowResolutionChanged: Vector2
	WindowResolutionChanged: RBXScriptSignal;

	--// RBXScriptSignal DeviceInfo.OrientationChanged: DeviceInfoEnum.DeviceOrientation
	OrientationChanged: RBXScriptSignal;

	--// RBXScriptSignal DeviceInfo.GraphicsQualityChanged: Enum.SavedQualitySetting
	GraphicsQualityChanged: RBXScriptSignal;
}

--//local lockedMeta = {__newindex = function() return error("attempt to modify readonly table", 2) end; __metatable = "This metatable is locked."}
--// DeviceInfoEnum.PlatformType DeviceInfo.PlatformType
DeviceInfo.PlatformType = {
	Computer = "DeviceInfo_PlatformType_Computer";
	Console = "DeviceInfo_PlatformType_Console";
	Mobile = "DeviceInfo_PlatformType_Mobile";
}

--// DeviceInfoEnum.InputType DeviceInfo.InputType
DeviceInfo.InputType = {
	Touchscreen = "DeviceInfo_InputType_Touchscreen";
	KeyboardMouse = "DeviceInfo_InputType_KeyboardMouse";
	Gamepad = "DeviceInfo_InputType_Gamepad";
	VR = "DeviceInfo_InputType_VR";
	Keyboard = "DeviceInfo_InputType_Keyboard";
	Mouse = "DeviceInfo_InputType_Mouse";
}

--// DeviceInfoEnum.DeviceType DeviceInfo.DeviceType
DeviceInfo.DeviceType = {
	Computer = "DeviceInfo_DeviceType_Computer";
	Phone = "DeviceInfo_DeviceType_Phone";
	Tablet = "DeviceInfo_DeviceType_Tablet";
	Console = "DeviceInfo_DeviceType_Console";
	TouchscreenComputer = "DeviceType_TouchscreenComputer";
}

--// DeviceInfoEnum.DeviceOrientation DeviceInfo.DeviceOrientation
DeviceInfo.DeviceOrientation = {
	Landscape = "DeviceInfo_DeviceOrientation_Landscape";
	Portrait = "DeviceInfo_DeviceOrientation_Portrait";
}

local previousRes: Vector2, previousInput: string, previousOrientation: string, previousGraphicsQuality: Enum.SavedQualitySetting, oldCamConnection: RBXScriptConnection
local userGameSettings = UserSettings():GetService("UserGameSettings")

--// Bindables to be exposed to scripts
local inputChangeBind = Instance.new("BindableEvent")
local resChangeBind = Instance.new("BindableEvent")
local orientationChangeBind = Instance.new("BindableEvent")
local graphicsQualityChangeBind = Instance.new("BindableEvent")

--// function DeviceInfo.GetDevicePlatform(): DeviceInfoEnum.PlatformType
function DeviceInfo.GetDevicePlatform(): string
	if serv.GuiService:IsTenFootInterface() and serv.UserInputService.GamepadEnabled then
		return DeviceInfo.PlatformType.Console
	elseif serv.UserInputService.TouchEnabled and not serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled then
		return DeviceInfo.PlatformType.Mobile
	else
		return DeviceInfo.PlatformType.Computer
	end
end

--// function DeviceInfo.GetDeviceOrientation(): DeviceInfoEnum.DeviceOrientation
function DeviceInfo.GetDeviceOrientation(): string
	if (workspace.CurrentCamera.ViewportSize.X < workspace.CurrentCamera.ViewportSize.Y) then
		previousOrientation = DeviceInfo.DeviceOrientation.Portrait
		return DeviceInfo.DeviceOrientation.Portrait
	else
		previousOrientation = DeviceInfo.DeviceOrientation.Landscape
		return DeviceInfo.DeviceOrientation.Landscape
	end
end

--// function DeviceInfo.GetWindowResolution(): Vector2
function DeviceInfo.GetWindowResolution(): Vector2
	previousRes = workspace.CurrentCamera.ViewportSize
	return previousRes
end

--// function DeviceInfo.GetDeviceInput(): DeviceInfoEnum.InputType
function DeviceInfo.GetDeviceInput(): string
	if serv.UserInputService.MouseEnabled and serv.UserInputService.KeyboardEnabled then
		previousInput = DeviceInfo.InputType.KeyboardMouse
		return DeviceInfo.InputType.KeyboardMouse
	elseif serv.UserInputService.MouseEnabled and not serv.UserInputService.KeyboardEnabled then
		previousInput = DeviceInfo.InputType.Mouse
		return DeviceInfo.InputType.Mouse
	elseif serv.UserInputService.KeyboardEnabled and not serv.UserInputService.MouseEnabled then
		previousInput = DeviceInfo.InputType.Keyboard
		return DeviceInfo.InputType.Keyboard
	elseif serv.UserInputService.GamepadEnabled then
		previousInput = DeviceInfo.InputType.Gamepad
		return DeviceInfo.InputType.Gamepad
	elseif serv.UserInputService.VREnabled then
		previousInput = DeviceInfo.InputType.VR
		return DeviceInfo.InputType.VR
	else
		previousInput = DeviceInfo.InputType.Touchscreen
		return DeviceInfo.InputType.Touchscreen
	end
end

--// function DeviceInfo.GetDeviceType(): DeviceInfoEnum.DeviceType
function DeviceInfo.GetDeviceType(): string
	if serv.GuiService:IsTenFootInterface() and serv.UserInputService.GamepadEnabled then
		return DeviceInfo.DeviceType.Console
	elseif DeviceInfo.GetDevicePlatform() == DeviceInfo.PlatformType.Mobile and serv.UserInputService.TouchEnabled then
		local orientation = DeviceInfo.GetDeviceOrientation()
		if orientation == DeviceInfo.DeviceOrientation.Landscape then
			if workspace.CurrentCamera.ViewportSize.Y < 600 then
				return DeviceInfo.DeviceType.Phone
            end
			return DeviceInfo.DeviceType.Tablet
		else
			if workspace.CurrentCamera.ViewportSize.X < 600 then
				return DeviceInfo.DeviceType.Phone
            end
			return DeviceInfo.DeviceType.Tablet
		end
	elseif serv.UserInputService.TouchEnabled and serv.UserInputService.KeyboardEnabled and serv.UserInputService.MouseEnabled then
		return DeviceInfo.DeviceType.TouchscreenComputer
	else
		return DeviceInfo.DeviceType.Computer
	end
end

--// function DeviceInfo.GetGraphicsQuality(): Enum.SavedQualitySetting
function DeviceInfo.GetGraphicsQuality(): Enum.SavedQualitySetting
	return userGameSettings.SavedQualityLevel
end

--// Input change detection
serv.UserInputService.LastInputTypeChanged:Connect(function()
	local oldPrevInput = previousInput
	DeviceInfo.GetDeviceInput()
	if previousInput == oldPrevInput then return end
	inputChangeBind:Fire(previousInput)
	return
end)

--// Orienation and window size change detection
local function CameraHook()
	if oldCamConnection then
		oldCamConnection:Disconnect()
		oldCamConnection = nil
	end

	oldCamConnection = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		--// Window size
		local oldPrevRes = previousRes
		DeviceInfo.GetWindowResolution()
		if previousRes ~= oldPrevRes then
			resChangeBind:Fire(previousRes)
		end

		--// Orientation
		local oldPrevOrientation = previousOrientation
		DeviceInfo.GetDeviceOrientation()
		if previousOrientation ~= oldPrevOrientation then
			orientationChangeBind:Fire(previousOrientation)
		end

		return
	end)
end

CameraHook()
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(CameraHook)

--// Graphics quality level change
userGameSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function()
	local oldPrevGraphicsQuality = previousOrientation
	DeviceInfo.GetGraphicsQuality()
	if previousGraphicsQuality ~= oldPrevGraphicsQuality then
		graphicsQualityChangeBind:Fire(previousGraphicsQuality)
	end
	return
end)

--// Expose bindables to script
--// RBXScriptSignal DeviceInfo.InputChanged: DeviceInfoEnum.InputType
DeviceInfo.InputChanged = inputChangeBind.Event

--// RBXScriptSignal DeviceInfo.WindowResolutionChanged: Vector2
DeviceInfo.WindowResolutionChanged = resChangeBind.Event

--// RBXScriptSignal DeviceInfo.OrientationChanged: DeviceInfoEnum.DeviceOrientation
DeviceInfo.OrientationChanged = orientationChangeBind.Event

--// RBXScriptSignal DeviceInfo.GraphicsQualityChanged: Enum.SavedQualitySetting
DeviceInfo.GraphicsQualityChanged = graphicsQualityChangeBind.Event

return DeviceInfo