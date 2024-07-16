local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MouseIsMoving = false
local MouseIsMovingLF = false
local LastFace = Vector3.new(0,0,0)
local DirChange = 0

local Bind = Enum.KeyCode.Space
local Strength = 5

local UseGradient = true
local GradientCentre = 3
local MinGradient = 0
local MaxGradient = 1.2
local ActivateThreshold = 0.25
local DeactivateThreshold = 64
local OverTime = 0.05
local MaxDistance = 9



local StoppedAt = tick()

local function VectorAngle(a,b)
	if a == b then return 0 end
	return math.acos(a.Unit:Dot(b.Unit))
end

local function OnChange(Input,gpe)
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

local function Main(step)
	if LocalPlayer.Character then
		local Character = LocalPlayer.Character
		if Character:FindFirstChild("HumanoidRootPart") then
			local HRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
			local Camera = workspace.CurrentCamera
			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				local Target = ClosestPlayer(HRP.Position)
				if Target.RootPart and Target.Distance <= MaxDistance then
					local TargetPos = Target.RootPart.Position
					local CurrentPos = HRP.Position
					local ClampedStrength = math.min(Strength * step,1)
					local Facing = (((HRP.CFrame * CFrame.new(Vector3.new(-1,0,-1))).Position - HRP.Position) * Vector3.new(1,0,1)).Unit
					
					local FaceAngle = VectorAngle(Facing,LastFace)/step
					if FaceAngle > ActivateThreshold and FaceAngle < DeactivateThreshold then
						ClampedStrength *= math.clamp(FaceAngle/GradientCentre,MinGradient,MaxGradient)	
					else
						ClampedStrength = 0
					end
					
					
					if tick()-StoppedAt < OverTime and not MouseIsMoving and OverTime ~= 0 then
						ClampedStrength *= math.clamp((OverTime - (tick()-StoppedAt))/OverTime,0,1)
					end
					
					local CamOffset = HRP.CFrame:ToObjectSpace(Camera.CFrame)
					local FaceFrom = (HRP.CFrame * CFrame.Angles(0,-0.78539816339,0) * Vector3.new(0,0,-(TargetPos-CurrentPos).Magnitude))
					FaceFrom = Vector3.new(FaceFrom.X,HRP.Position.Y,FaceFrom.Z)
					local EP =  FaceFrom + ((TargetPos-FaceFrom) * ClampedStrength)
					if MouseIsMoving or (tick()-StoppedAt < OverTime) then
						local Dir = Face(EP,HRP,CFrame.Angles(0,0.78539816339,0))
						if Dir then
							Camera.CFrame = Dir * CamOffset
						end
					elseif MouseIsMovingLF then
						StoppedAt = tick()
					end
				end
			end
			LastFace = (((HRP.CFrame * CFrame.new(Vector3.new(-1,0,-1))).Position - HRP.Position) * Vector3.new(1,0,1)).Unit
		end
	end
	MouseIsMovingLF = MouseIsMoving
	MouseIsMoving = false
end

UIS.InputChanged:Connect(OnChange)
RunService.RenderStepped:Connect(Main)
