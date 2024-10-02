local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"))()

local RunScript = true

--Script variables
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

local FGrab = {
	Enabled = false,
	Size = 3
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
	Visuals = Window:AddTab("Visuals"),
	Rage = Window:AddTab("Rage"),
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

local GrabForceBox = Tabs.Rage:AddLeftGroupbox("Force Grab")

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
	Max = 5,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		FGrab.Size = Value
	end
})

--[[
	VISUALS
]]

local PanicBox = Tabs.Legit:AddRightGroupbox("Panic button")


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

local Folder = Instance.new("Folder",workspace)
Folder.Name = GenString(15)

local MouseIsMoving = false
local MouseWasMoving = false
local LastFace = Vector3.zero
local StoppedAt = tick()

local PositionRecord = {}

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

local function MainScript(Step)
	Camera = workspace.CurrentCamera

	if not RunScript then
		return
	end
	
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


UserInputService.InputChanged:Connect(OnInputChange)
RunService.RenderStepped:Connect(MainScript)
