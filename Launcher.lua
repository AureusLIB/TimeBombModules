local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"))()

local RunScript = true

--Script variables

--Legit
local TrackAssist = {
	Enabled = false,
	Strength = 2,
	UseGradient = false,
	MinGradient = 0,
	MaxGradient = 1.3,
	GradientCentre = 3,
	UseThreshold = false,
	ActivateThreshold = 0.25,
	DeactivateThreshold = 64,
	MaxDistance = 9,
	Overtime = 0.05
}

local HoldAssist = {
	Enabled = false,
	Strength = 2,
	UseGradient = false,
	MinGradient = 0,
	MaxGradient = 1.3,
	GradientCentre = 3,
	UseThreshold = false,
	ActivateThreshold = 0.25,
	DeactivateThreshold = 64,
	MaxDistance = 20,
	Overtime = 0.05
}

--Semi-rage

local FGrab = {
	Enabled = false,
	Size = 3
}

local Sphere = {
	Enabled = false,
	DefaultSize = 2,
	WallSize = 0.5,
	Visualise = false,
	VisualiseColour = Color3.fromRGB(55,155,255),
	Transparency = 0.8
}


--ESP
local ESP = {
	Enabled = false
}

local SkeletonESP = {
	Enabled = false,
	Colour = Color3.fromRGB(55,155,255),
	SelfSkeleton = false,
	SelfColour = Color3.new(0.205,0.923,0.514)
}

local Window = Library:CreateWindow({
	Title = 'Timebomb',
	Center = true,
	AutoShow = true,
	TabPadding = 8,
	MenuFadeTime = 0
})

local Tabs = {
	Legit = Window:AddTab("Legit"),
	SemiRage = Window:AddTab("Semi-Rage"),
	Visuals = Window:AddTab("Visuals"),
	UISettings = Window:AddTab("UI Settings"),
}

--TRACKING

local LegitMainLeftTab = Tabs.Legit:AddLeftTabbox("Track Assist") --local TabBox = Tabs.Main:AddRightTabbox()

local LegitMainLeft = LegitMainLeftTab:AddTab("Tracking")

local TrackAssistToggle = LegitMainLeft:AddToggle('TrackAssist', {
	Text = 'Track assist',
	Default = false,
	Tooltip = 'Aim assist for tracking',

	Callback = function(Value)
		TrackAssist.Enabled = Value
	end
})

local TAUseGradient = LegitMainLeft:AddToggle('TAUseGradient', {
	Text = 'Use gradient',
	Default = false,
	Tooltip = 'Looks more legit (faster mouse = higher strength)',

	Callback = function(Value)
		TrackAssist.UseGradient = Value
	end
})

local TAThreshold = LegitMainLeft:AddToggle('TAUseThreshold', {
	Text = 'Use activate threshold',
	Default = false,
	Tooltip = 'stops it locking on low and high speeds',

	Callback = function(Value)
		TrackAssist.UseThreshold = Value
	end
})

local TrackAssistKeyPicker = TrackAssistToggle:AddKeyPicker('TrackAssistKeybind', {
	Default = 'LeftAlt',
	SyncToggleState = false,
	Mode = 'Hold',

	Text = 'Tracking aim assist',
	NoUI = true
})

local TAGradientBox = LegitMainLeft:AddDependencyBox()

TAGradientBox:SetupDependencies({
	{ Toggles.TAUseGradient, true }
})

TAGradientBox:AddSlider('TAMinGrad', {
	Text = 'Minimum gradient',
	Default = 0,
	Min = 0,
	Max = 3,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		TrackAssist.MinGradient = Value
	end
})

TAGradientBox:AddSlider('TAMaxGrad', {
	Text = 'Maximum gradient',
	Default = 1.2,
	Min = 0,
	Max = 3,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		TrackAssist.MaxGradient = Value
	end
})

TAGradientBox:AddSlider('TAGradCentre', {
	Text = 'Gradient centre',
	Default = 3,
	Min = 0,
	Max = 32,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		TrackAssist.GradientCentre = Value
	end
})

local TAThresholdBox = LegitMainLeft:AddDependencyBox()

TAThresholdBox:SetupDependencies({
	{ Toggles.TAUseThreshold, true }
})

TAThresholdBox:AddSlider('TAActivateThreshold', {
	Text = 'Activate threshold',
	Default = 0.25,
	Min = 0,
	Max = 5,
	Rounding = 2,
	Compact = false,

	Callback = function(Value)
		TrackAssist.ActivateThreshold = Value
	end
})

TAThresholdBox:AddSlider('TADeactivateThreshold', {
	Text = 'Deactivate threshold',
	Default = 64,
	Min = 0,
	Max = 75,
	Rounding = 0,
	Compact = false,

	Callback = function(Value)
		TrackAssist.DeactivateThreshold = Value
	end
})


LegitMainLeft:AddSlider('TrackAssistStrength', {
	Text = 'Track assist strength',
	Default = 2,
	Min = 0,
	Max = 5,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		TrackAssist.Strength = Value
	end
})

LegitMainLeft:AddSlider('TAOvertime', {
	Text = 'Overtime',
	Default = 0.05,
	Min = 0,
	Max = 0.25,
	Rounding = 2,
	Compact = false,

	Callback = function(Value)
		TrackAssist.Overtime = Value
	end
})

LegitMainLeft:AddSlider('TAMaxDist', {
	Text = 'Max distance',
	Default = 9,
	Min = 0,
	Max = 16,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		TrackAssist.MaxDistance = Value
	end
})



--HOLDING

local LegitMainRight = LegitMainLeftTab:AddTab("Holding")

local HoldAssistToggle = LegitMainRight:AddToggle('HoldAssist', {
	Text = 'Hold assist',
	Default = false,
	Tooltip = 'Aim assist for holding',

	Callback = function(Value)
		HoldAssist.Enabled = Value
	end
})

local HAUseGradient = LegitMainRight:AddToggle('HAUseGradient', {
	Text = 'Use gradient',
	Default = false,
	Tooltip = 'Looks more legit (faster mouse = higher strength)',

	Callback = function(Value)
		HoldAssist.UseGradient = Value
	end
})

local HAThreshold = LegitMainRight:AddToggle('HAUseThreshold', {
	Text = 'Use activate threshold',
	Default = false,
	Tooltip = 'stops it locking on low and high speeds',

	Callback = function(Value)
		HoldAssist.UseThreshold = Value
	end
})

local HoldAssistKeyPicker = HoldAssistToggle:AddKeyPicker('HoldAssistKeybind', {
	Default = 'Space',
	SyncToggleState = false,
	Mode = 'Hold',

	Text = 'Holding aim assist',
	NoUI = true
})

local HAGradientBox = LegitMainRight:AddDependencyBox()

HAGradientBox:SetupDependencies({
	{ Toggles.HAUseGradient, true }
})

HAGradientBox:AddSlider('HAMinGrad', {
	Text = 'Minimum gradient',
	Default = 0,
	Min = 0,
	Max = 3,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		HoldAssist.MinGradient = Value
	end
})

HAGradientBox:AddSlider('HAMaxGrad', {
	Text = 'Maximum gradient',
	Default = 1.2,
	Min = 0,
	Max = 3,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		HoldAssist.MaxGradient = Value
	end
})

HAGradientBox:AddSlider('HAGradCentre', {
	Text = 'Gradient centre',
	Default = 3,
	Min = 0,
	Max = 32,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		HoldAssist.GradientCentre = Value
	end
})

local HAThresholdBox = LegitMainRight:AddDependencyBox()

HAThresholdBox:SetupDependencies({
	{ Toggles.HAUseThreshold, true }
})

HAThresholdBox:AddSlider('HAActivateThreshold', {
	Text = 'Activate threshold',
	Default = 0.25,
	Min = 0,
	Max = 5,
	Rounding = 2,
	Compact = false,

	Callback = function(Value)
		HoldAssist.ActivateThreshold = Value
	end
})

HAThresholdBox:AddSlider('HADeactivateThreshold', {
	Text = 'Deactivate threshold',
	Default = 64,
	Min = 0,
	Max = 75,
	Rounding = 0,
	Compact = false,

	Callback = function(Value)
		HoldAssist.DeactivateThreshold = Value
	end
})


LegitMainRight:AddSlider('HoldAssistStrength', {
	Text = 'Hold assist strength',
	Default = 2,
	Min = 0,
	Max = 5,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		HoldAssist.Strength = Value
	end
})

LegitMainRight:AddSlider('HAOvertime', {
	Text = 'Overtime',
	Default = 0.05,
	Min = 0,
	Max = 0.25,
	Rounding = 2,
	Compact = false,

	Callback = function(Value)
		HoldAssist.Overtime = Value
	end
})

LegitMainRight:AddSlider('HAMaxDist', {
	Text = 'Max distance',
	Default = 20,
	Min = 0,
	Max = 20,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		HoldAssist.MaxDistance = Value
	end
})


--DESYNC

local GrabForceBox = Tabs.SemiRage:AddLeftGroupbox("Force Grab")

local FGrabToggle = GrabForceBox:AddToggle('FGrabToggle', {
	Text = 'Activate force grab',
	Default = false,
	Tooltip = 'Changes your arms size',

	Callback = function(Value)
		FGrab.Enabled = Value
	end
}):AddKeyPicker('FGrabKeybind', {
	Default = 'F',
	SyncToggleState = false,
	Mode = 'Hold',

	Text = 'Force grab',
	NoUI = true
})



GrabForceBox:AddSlider('FGrabSize', {
	Text = 'Arm size',
	Default = 3,
	Min = 1,
	Max = 6,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		FGrab.Size = Value
	end
})

local SphereBox = Tabs.SemiRage:AddRightGroupbox("Sphere")

local SphereToggle = SphereBox:AddToggle('SphereToggle', {
	Text = 'Toggle sphere',
	Default = false,
	Tooltip = 'Lets you give from further',

	Callback = function(Value)
		Sphere.Enabled = Value
	end
}):AddKeyPicker('SphereKeybind', {
	Default = 'Q',
	SyncToggleState = false,
	Mode = 'Hold',

	Text = 'Toggle sphere',
	NoUI = true
})

local VisualiseSphere = SphereBox:AddToggle('VisualuseSphereToggle', {
	Text = 'Visualise sphere',
	Default = false,
	Tooltip = 'Visualise sphere',

	Callback = function(Value)
		Sphere.Visualise = Value
	end
}):AddColorPicker('SphereColour', {
	Default = Color3.new(0.216,0.608,1),
	Title = 'Sphere Visualiser',
	Transparency = nil,

	Callback = function(Value)
		Sphere.VisualiseColour = Value
	end
})

SphereBox:AddSlider('SphereNormalValue', {
	Text = 'Sphere size',
	Default = 2,
	Min = 0,
	Max = 8,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		Sphere.DefaultSize = Value
	end
})

SphereBox:AddSlider('SphereWallValue', {
	Text = 'Through wall size',
	Default = 0.5,
	Min = 0,
	Max = 8,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		Sphere.WallSize = Value
	end
})

--[[
	VISUALS
]]

local ESPMain = Tabs.Visuals:AddLeftGroupbox("ESP")

local ESPToggle = ESPMain:AddToggle('EspToggle', {
	Text = 'ESP',
	Default = false,
	Tooltip = 'Toggle ESP',

	Callback = function(Value)
		ESP.Enabled = Value
	end
}):AddKeyPicker('EspKeybind', {
	Default = '',
	SyncToggleState = false,
	Mode = 'Toggle',

	Text = 'Toggle esp',
	NoUI = true
})


local SkeletonToggle = ESPMain:AddToggle('SkeletonToggle', {
	Text = 'Skeleton ESP',
	Default = false,
	Tooltip = 'skeleton esp',

	Callback = function(Value)
		SkeletonESP.Enabled = Value
	end
}):AddColorPicker('SkeletonColour', {
	Default = Color3.new(0.216,0.608,1),
	Title = 'Skeleon ESP',
	Transparency = nil, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

	Callback = function(Value)
		SkeletonESP.Colour = Value
	end
})

local SDepencency = ESPMain:AddDependencyBox()

SDepencency:SetupDependencies({
	{ Toggles.SkeletonToggle, true }
})

local SelfSkeleton = SDepencency:AddToggle('SelfSkeleton', {
	Text = 'Self skeleton',
	Default = false,
	Tooltip = 'gives you a skeleton',

	Callback = function(Value)
		SkeletonESP.SelfSkeleton = Value
	end
}):AddColorPicker('SelfSkeletonColour', {
	Default = Color3.new(0.205,0.923,0.514),
	Title = 'Skeleon ESP',
	Transparency = nil,

	Callback = function(Value)
		SkeletonESP.SelfColour = Value
	end
})

local MenuGroup = Tabs.UISettings:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() RunScript = false Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder('Aureus')
SaveManager:SetFolder('Aureus/Timebomb')
SaveManager:BuildConfigSection(Tabs.UISettings)
ThemeManager:ApplyToTab(Tabs.UISettings)
SaveManager:LoadAutoloadConfig()

--Script section

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera


local letters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}

local function GenString(length)
	local t = {}
	for _ = 1,length do
		table.insert(t,string.upper(letters[math.random(1,#letters)]))
	end
	return table.concat(t,"")
end

local Folder = Instance.new("Folder")
Folder.Parent = game.Workspace

local ScreenGUI = Instance.new("ScreenGui")
local Viewport = Instance.new("ViewportFrame")

local MouseIsMoving = false
local MouseWasMoving = false
local LastFace = Vector3.zero
local StoppedAt = tick()

local PositionRecord = {}
local SkeletonCache = {}
local PlayerTracker = {}
local PlayerParts = {}

Folder.Name = GenString(15)

Viewport.Transparency = 1
Viewport.Size = UDim2.new(1,0,1,57)
Viewport.Position = UDim2.new(0,0,0,-57)
Viewport.Parent = ScreenGUI
Viewport.CurrentCamera = workspace.CurrentCamera
Viewport.Ambient = Color3.fromRGB(255,255,255)
Viewport.LightColor = Color3.fromRGB(255,255,255)

ScreenGUI.Parent = game.CoreGui

local function UpdatePlayerTracker(Step)
	for _,v in pairs(Players:GetPlayers()) do
		local Character = v.Character
		local PT = PlayerTracker[v.Name]
		if not PT or not v.Character then
			PlayerTracker[v.Name] = {
				["LastPos"] = Vector3.zero,
				["Pos"] = Vector3.zero,
				["Speed"] = 0
			}
		else
			local HRP = Character:FindFirstChild("HumanoidRootPart")
			
			if HRP then
				PlayerTracker[v.Name]["LastPos"] = PT["Pos"]
				PlayerTracker[v.Name]["Pos"] = HRP.Position
				PlayerTracker[v.Name]["Speed"] = (PlayerTracker[v.Name]["Pos"] - PlayerTracker[v.Name]["LastPos"]).Magnitude/Step
			else
				PlayerTracker[v.Name] = {
					["LastPos"] = Vector3.zero,
					["Pos"] = Vector3.zero,
					["Speed"] = 0
				}
			end
			
		end
		
	end
end

local function GetSpeed(Player: Player)
	return PlayerTracker[Player.Name]["Speed"] or 0
end

local function VectorAngle(a,b)
	if a == b then return 0 end
	return math.acos(a.Unit:Dot(b.Unit))
end

local function OnInputChange(Input,gpe)
	if Input.UserInputType == Enum.UserInputType.MouseMovement then
		if math.abs(Input.Delta.X) > 0 then
			MouseIsMoving = true
		end
	end
end

local function Face(Position: Vector3,HumanoidRootPart: Part,Offset)
	if HumanoidRootPart ~= nil then
		local Direction = ((Position - HumanoidRootPart.Position) * Vector3.new(1,0,1)).Unit
		local NewOrientation = CFrame.new(HumanoidRootPart.Position,HumanoidRootPart.Position + Direction) * Offset

		HumanoidRootPart.CFrame = NewOrientation
		return NewOrientation
	end
	return nil
end

local function ClosestPlayer(Pos: Vector3)
	local Dist = math.huge
	local Closest = nil
	local ClosestPosition = nil
	local HumRP = nil

	for _,v in pairs(Players:GetPlayers()) do
		if v == LocalPlayer then continue end
		if v.Character then
			local Humanoid = v.Character:FindFirstChildWhichIsA("Humanoid")
			local HRP = v.Character:FindFirstChild("HumanoidRootPart")
			if Humanoid and HRP and not v.Character:FindFirstChildWhichIsA("Tool") then
				if Humanoid.Health > 0 and HRP:IsA("BasePart") then
					if (HRP.Position - Pos).Magnitude < Dist then
						Closest = v
						ClosestPosition = HRP.Position
						Dist = (HRP.Position - Pos).Magnitude
						HumRP = HRP
					end
				end
			end
		end
	end
	return {Position = ClosestPosition,Player = Closest,Distance = Dist,RootPart = HumRP}
end

local function AimAssist(Position: Vector3,Settings,Step)
	local Character = LocalPlayer.Character
	local HRP = Character:FindFirstChild("HumanoidRootPart")
	local CurrentPos = HRP.Position

	if (CurrentPos - Position).Magnitude > Settings.MaxDistance then
		return
	end

	local ClampedStrength = math.min(TrackAssist.Strength * Step,1)
	local Facing = (((HRP.CFrame * CFrame.new(Vector3.new(-1,0,-1))).Position - HRP.Position) * Vector3.new(1,0,1)).Unit

	local FaceAngle = VectorAngle(Facing,LastFace)/Step

	if FaceAngle > Settings.ActivateThreshold and FaceAngle < Settings.DeactivateThreshold then
		ClampedStrength *= math.clamp(FaceAngle/Settings.GradientCentre,Settings.MinGradient,Settings.MaxGradient)	
	else
		ClampedStrength = 0
	end

	if tick()-StoppedAt < Settings.Overtime and not MouseIsMoving and Settings.OverTime ~= 0 then
		ClampedStrength *= math.clamp((Settings.Overtime - (tick()-StoppedAt))/Settings.Overtime,0,1)
	end

	local CamOffset = HRP.CFrame:ToObjectSpace(Camera.CFrame)
	local FaceFrom = (HRP.CFrame * CFrame.Angles(0,-0.78539816339,0) * Vector3.new(0,0,-(Position-CurrentPos).Magnitude))
	FaceFrom = Vector3.new(FaceFrom.X,HRP.Position.Y,FaceFrom.Z)
	local EP =  FaceFrom + ((Position-FaceFrom) * ClampedStrength)
	if MouseIsMoving or (tick()-StoppedAt < Settings.Overtime) then
		local Dir = Face(EP,HRP,CFrame.Angles(0,0.78539816339,0))
		if Dir then
			Camera.CFrame = Dir * CamOffset
		end
	elseif MouseWasMoving then
		StoppedAt = tick()
	end
end

local function RefreshSGUI()
	ScreenGUI = Instance.new("ScreenGui")
	Viewport = Instance.new("ViewportFrame")
	Viewport.Transparency = 1
	Viewport.Size = UDim2.new(1,0,1,57)
	Viewport.Position = UDim2.new(0,0,0,-57)
	Viewport.Parent = ScreenGUI
	Viewport.CurrentCamera = workspace.CurrentCamera
	Viewport.Ambient = Color3.fromRGB(255,255,255)
	Viewport.LightColor = Color3.fromRGB(255,255,255)
	ScreenGUI.Parent = LocalPlayer.PlayerGui
end

local function DrawLine(Position1,Position2)
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.Parent = workspace
	Part.Color = SkeletonESP.Colour
	local Size = (Position1 - Position2).Magnitude
	Part.Size = Vector3.new(0.05, 0.05,  Size)
	Part.CFrame = CFrame.new(Position1:Lerp(Position2, 0.5),Position2)
	Part.Parent = Viewport
	return Part
end

local function GetLineInfo(Position1,Position2)
	local Size = (Position1 - Position2).Magnitude
	local CF = CFrame.new(Position1:Lerp(Position2, 0.5),Position2)

	return {Size = Vector3.new(0.05,0.05,Size),CFrame = CF}
end

local function GenerateSkeleton(Character: Model)
	local Parts = {}

	local LeftArm = Instance.new("Part")
	LeftArm.CanCollide = false
	LeftArm.Anchored = true
	LeftArm.Size = Vector3.new(0.05,1.3,0.05)
	LeftArm.Color = SkeletonESP.Colour
	LeftArm.Parent = Viewport
	LeftArm.Name = "Left Arm"

	Parts["Left Arm"] = {Part = LeftArm,Offset = CFrame.new(),Connector = false}

	local RightArm = Instance.new("Part")
	RightArm.CanCollide = false
	RightArm.Anchored = true
	RightArm.Size = Vector3.new(0.05,1.3,0.05)
	RightArm.Color = SkeletonESP.Colour
	RightArm.Parent = Viewport
	RightArm.Name = "Right Arm"

	Parts["Right Arm"] = {Part = RightArm,Offset = CFrame.new(),Connector = false}

	local Torso = Instance.new("Part")
	Torso.CanCollide = false
	Torso.Anchored = true
	Torso.Size = Vector3.new(0.05,2,0.05)
	Torso.Color = SkeletonESP.Colour
	Torso.Parent = Viewport
	Torso.Name = "Torso"

	Parts["Torso"] = {Part = Torso,Offset = CFrame.new(Vector3.new(0,0.2,0)),Connector = false}

	local LeftLeg = Instance.new("Part")
	LeftLeg.CanCollide = false
	LeftLeg.Anchored = true
	LeftLeg.Size = Vector3.new(0.05,1.3,0.05)
	LeftLeg.Color = SkeletonESP.Colour
	LeftLeg.Parent = Viewport
	LeftLeg.Name = "Left Leg"

	Parts["Left Leg"] = {Part = LeftLeg,Offset = CFrame.new(),Connector = false}

	local RightLeg = Instance.new("Part")
	RightLeg.CanCollide = false
	RightLeg.Anchored = true
	RightLeg.Size = Vector3.new(0.05,1.3,0.05)
	RightLeg.Color = SkeletonESP.Colour
	RightLeg.Parent = Viewport
	RightLeg.Name = "Right Leg"

	Parts["Right Leg"] = {Part = RightLeg,Offset = CFrame.new(),Connector = false}

	local TRS = Character:FindFirstChild("Torso")
	local LA = Character:FindFirstChild("Left Arm")
	local RA = Character:FindFirstChild("Right Arm")
	local LL = Character:FindFirstChild("Left Leg")
	local RL = Character:FindFirstChild("Right Leg")
	if TRS then
		if LA  then
			Parts["Connector1"] = {Connector = true,Part = DrawLine((LA.CFrame * CFrame.new(Vector3.new(0,0.625,0))).Position,(TRS.CFrame * CFrame.new(Vector3.new(0,0.25,0))).Position)}
		end
		if RA then
			Parts["Connector2"] = {Connector = true,Part = DrawLine((RA.CFrame * CFrame.new(Vector3.new(0,0.625,0))).Position,(TRS.CFrame * CFrame.new(Vector3.new(0,0.25,0))).Position)}
		end
		if LL then
			Parts["Connector3"] = {Connector = true,Part = DrawLine((LL.CFrame * CFrame.new(Vector3.new(0,0.625,0))).Position,(TRS.CFrame * CFrame.new(Vector3.new(0,-0.8,0))).Position)}
		end
		if RL then
			Parts["Connector4"] = {Connector = true,Part = DrawLine((RL.CFrame * CFrame.new(Vector3.new(0,0.625,0))).Position,(TRS.CFrame * CFrame.new(Vector3.new(0,-0.8,0))).Position)}
		end
	end
	return Parts
end

local function DrawSkeleton(Player: Player)
	if Player == LocalPlayer and not SkeletonESP.SelfSkeleton then
		return
	end
	if Player.Character then

		if not SkeletonCache[Player.Name] then
			local Skeleton = GenerateSkeleton(Player.Character)
			
			if Player == LocalPlayer then
				for _,v in pairs(Skeleton) do
					if v.Part then
						v.Part.Color = SkeletonESP.SelfColour
					end
				end
			end
			
			SkeletonCache[Player.Name] = Skeleton

			for i,v in pairs(Skeleton) do
				if not v.Connector then
					local Part = Player.Character:FindFirstChild(i)
					if Part and Part:IsA("BasePart") then
						v.Part.CFrame = Part.CFrame * v.Offset
					else
						v.Transparency = 1
					end
				end
			end
		else
			local PCache = SkeletonCache[Player.Name]

			local TRS = Player.Character:FindFirstChild("Torso")
			local LA = Player.Character:FindFirstChild("Left Arm")
			local RA = Player.Character:FindFirstChild("Right Arm")
			local LL = Player.Character:FindFirstChild("Left Leg")
			local RL = Player.Character:FindFirstChild("Right Leg")

			for i,v in pairs(PCache) do

				if v.Connector then

					if TRS then

						if i == "Connector1" and LA then
							local info = GetLineInfo((LA.CFrame * CFrame.new(Vector3.new(0,0.625,0))).Position,(TRS.CFrame * CFrame.new(Vector3.new(0,0.25,0))).Position)
							v.Part.CFrame = info.CFrame
							v.Part.Size = info.Size
							v.Part.Transparency = 0
						end

						if i == "Connector2" and RA then
							local info = GetLineInfo((RA.CFrame * CFrame.new(Vector3.new(0,0.625,0))).Position,(TRS.CFrame * CFrame.new(Vector3.new(0,0.25,0))).Position)
							v.Part.CFrame = info.CFrame
							v.Part.Size = info.Size
							v.Part.Transparency = 0
						end

						if i == "Connector3" and LL then
							local info = GetLineInfo((LL.CFrame * CFrame.new(Vector3.new(0,0.625,0))).Position,(TRS.CFrame * CFrame.new(Vector3.new(0,-0.8,0))).Position)
							v.Part.CFrame = info.CFrame
							v.Part.Size = info.Size
							v.Part.Transparency = 0
						end

						if i == "Connector4" and RL then
							local info = GetLineInfo((RL.CFrame * CFrame.new(Vector3.new(0,0.625,0))).Position,(TRS.CFrame * CFrame.new(Vector3.new(0,-0.8,0))).Position)
							v.Part.CFrame = info.CFrame
							v.Part.Size = info.Size
							v.Part.Transparency = 0
						end

					end

				else

					local part = Player.Character:FindFirstChild(i)
					if part then
						v.Part.CFrame = part.CFrame
						v.Part.Transparency = 0
					end

				end
			end
		end
	end
end

local function UpdateESP()
	
	if not RunScript then
		ScreenGUI:Destroy()
		return
	end
	
	if not ScreenGUI.Parent then
		RefreshSGUI()
	end
	for i,v in pairs(SkeletonCache) do
		for _,v in pairs(v) do
			if v.Part then
				v.Part.Transparency = 1
				if i == LocalPlayer.Name then
					v.Part.Color = SkeletonESP.SelfColour
				else
					v.Part.Color = SkeletonESP.Colour
				end
			end
		end
	end
	if ESP.Enabled then
	
		if SkeletonESP.Enabled then
			for _,v in pairs(Players:GetPlayers()) do
				DrawSkeleton(v)
			end
		end
	
	end
end

local function UpdateSphere()
	if not RunScript then return end
	local LocalChar = LocalPlayer.Character
	local LHRP,Params
	if LocalChar then
		LHRP = LocalChar:FindFirstChild("HumanoidRootPart")
		Params = RaycastParams.new()
		Params.FilterDescendantsInstances = PlayerParts
		Params.FilterType = Enum.RaycastFilterType.Exclude
	end
	for _,v in pairs(Players:GetPlayers()) do
		if v == LocalPlayer then continue end
		if v.Character then
			local chr = v.Character
			local hrp = chr:FindFirstChild("HumanoidRootPart")
			local Torso = chr:FindFirstChild("Torso")
			if hrp and Torso then


				if LHRP then

					local BehindWall = workspace:Raycast(hrp.Position,LHRP.Position-hrp.Position,Params)
					local SphereSize = Sphere.DefaultSize
					if BehindWall then
						SphereSize = Sphere.WallSize
					end
					hrp.Size = Vector3.new(SphereSize *2 + 2,2,SphereSize*2 + 1)
					hrp.CanCollide = false
					hrp.Transparency = 1

				end	
			end
		end
	end
	if LocalPlayer.Character then
		if not Folder:FindFirstChild("SphereVisualiser") then
			local p = Instance.new("Part")
			p.Shape = Enum.PartType.Ball
			p.CanCollide = false
			p.Transparency = 1
			p.Material = "Neon"
			p.Color = Sphere.VisualiseColour
			p.Size = Vector3.new(Sphere.DefaultSize*2 + 2,Sphere.DefaultSize*2 + 2,Sphere.DefaultSize*2 + 2)
			p.Position = Vector3.zero
			p.Parent = Folder
			p.Name = "SphereVisualiser"
			p.Anchored = true
			p.CanQuery = false
			p.CanTouch = false
		end
		local SphereVis: Part = Folder:FindFirstChild("SphereVisualiser")
		local chr = LocalPlayer.Character
		if chr:FindFirstChildWhichIsA("Tool") and SphereVis then
			local tool = chr:FindFirstChildWhichIsA("Tool")

			if tool:FindFirstChildWhichIsA("BasePart") then
				local Handle = tool:FindFirstChildWhichIsA("BasePart")
				if Handle and Sphere.Visualise then
					SphereVis.Position = Handle.Position
					SphereVis.Transparency  = Sphere.Transparency
					SphereVis.Color = Sphere.VisualiseColour
					SphereVis.Size = Vector3.new(Sphere.DefaultSize*2 + 2,Sphere.DefaultSize*2 + 2,Sphere.DefaultSize*2 + 2)
				else
					SphereVis.Transparency = 1
				end
			end
		end
	end	
end

local function MainScript(Step)
	Camera = workspace.CurrentCamera

	if not RunScript then
		Folder:Destroy()
		return
	end
	
	table.clear(PlayerParts)
	
	for _,v in pairs(Players:GetPlayers()) do
		if v.Character then
			for _,v2 in pairs(v.Character:GetDescendants()) do
				if v2:IsA("Part") or v2:IsA("MeshPart") then
					table.insert(PlayerParts,v2)
				end
			end
		end
	end
	
	if Sphere.Enabled and Options.SphereKeybind:GetState() then
		
		local chr = LocalPlayer.Character
		
		if chr then
		
		if not chr:FindFirstChildWhichIsA("Tool") and Folder:FindFirstChild("SphereVisualiser") then
			Folder.SphereVisualiser.Transparency = 1
		end
		
		end
		
		UpdateSphere()
	else
		if Folder:FindFirstChild("SphereVisualiser") then
			Folder.SphereVisualiser.Transparency = 1
		end
		for _,v in pairs(Players:GetPlayers()) do
			local chr = v.Character
			if chr then
				local hrp = chr:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.Size = Vector3.new(2,2,1)
				end
				
			end
		end
	end
	
	UpdatePlayerTracker(Step)
	local Character: Model = LocalPlayer.Character
	if Character then
		Character.Archivable = true
		local HRP: Part = Character:FindFirstChild("HumanoidRootPart")
		local LeftArm: Part = Character:FindFirstChild("Left Arm")
		local RightArm: Part = Character:FindFirstChild("Right Arm")
		local PC = Folder:FindFirstChild("PlayerClone")
		local PCL,PCR
		if LeftArm then
			if PC then
				PCL = PC:FindFirstChild("Left Arm")
				if PCL then
					PCL.CFrame = LeftArm.CFrame
					PCL.Transparency = 1
				end
			end
			LeftArm.Size = Vector3.new(1,2,1)
			LeftArm.Transparency = 0
		end
		if RightArm then
			if PC then
				PCR = PC:FindFirstChild("Right Arm")
				if PCR then
					PCR.CFrame = RightArm.CFrame
					PCR.Transparency = 1
				end
			end
			RightArm.Size = Vector3.new(1,2,1)
			RightArm.Transparency = 0
		end

		if HRP then
			local ClosestPlayer = ClosestPlayer(HRP.Position)


			if TrackAssist.Enabled then
				local AssistTrack = Options.TrackAssistKeybind:GetState()
				if AssistTrack then
					AimAssist(ClosestPlayer.Position,TrackAssist,Step)
				end
			end

			if HoldAssist.Enabled then
				local AssistHold = Options.HoldAssistKeybind:GetState()
				if AssistHold then
					local Difference = ClosestPlayer.Position - HRP.Position
					AimAssist(HRP.Position - Difference,HoldAssist,Step)
				end
			end

			LastFace = (((HRP.CFrame * CFrame.new(Vector3.new(-1,0,-1))).Position - HRP.Position) * Vector3.new(1,0,1)).Unit
			
			if FGrab.Enabled then
				local ForceGrab = Options.FGrabKeybind:GetState()
				if ForceGrab then
					if not Folder:FindFirstChild("PlayerClone") then
						local FChar = Character:Clone()
						FChar.Parent = Folder
						FChar.Name = "PlayerClone"
						for _,v in pairs(FChar:GetChildren()) do
							if v:IsA("Part") then
								v.Anchored = true
								if not (v.Name == "Left Arm" or v.Name == "Right Arm") then
									v:Destroy()
								elseif v.Name == "Left Arm" then
									v.CFrame = LeftArm.CFrame
								elseif v.Name == "Right Arm" then
									v.CFrame = RightArm.CFrame
								end
							elseif v:IsA("Accessory") then
								v:Destroy()
							end
							if v:IsA("Tool") then
								v:Destroy()
							end
						end
					end
					local GS = FGrab.Size
					if RightArm and LeftArm and PCL and PCR then
						PCL.Transparency = 0
						PCR.Transparency = 0
						LeftArm.Transparency = 1
						RightArm.Transparency = 1
						LeftArm.Size = Vector3.new(GS,GS,GS)
						RightArm.Size = Vector3.new(GS,GS,GS)
					end
				end
			end
		end
	end

	MouseWasMoving = MouseIsMoving
	MouseIsMoving = false
end

local function NearestIndexTo(Timer)
	local MinDiff = math.huge
	local NearestIndex = nil
	for Time,_ in pairs(PositionRecord) do
		if tick()-Time > 1 then
			PositionRecord[Time] = nil
			continue
		end

		local temp = math.abs(Time-Timer)
		if temp < MinDiff then
			NearestIndex = Time
			MinDiff = temp
		end
	end
	return PositionRecord[NearestIndex] or nil
end

local function RemoveFChar()
	local FChar = Folder:FindFirstChild("PlayerClone")
	if FChar then
		FChar:Destroy()
	end
end

LocalPlayer.ChildAdded:Connect(RemoveFChar)

UserInputService.InputChanged:Connect(OnInputChange)
RunService.RenderStepped:Connect(MainScript)
RunService.RenderStepped:Connect(UpdateESP) 
