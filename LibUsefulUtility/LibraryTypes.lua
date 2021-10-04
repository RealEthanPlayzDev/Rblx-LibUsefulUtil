local LibraryTypes = {}

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

	--// function DeviceInfo.GetWindowSize(): Vector2
	GetWindowSize: any;

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

export type LibInstUtil = {

}

export type LibQueuedDebris = {

}

export type LibCustomEvent = {

}

return LibraryTypes