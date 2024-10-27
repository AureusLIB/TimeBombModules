local FGrab = {
	Size = 4,
	Keybind = Enum.KeyCode.Space
}

local Folder = Instance.new("Folder")
Folder.Parent = game.Workspace

local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game.Players
local LocalPlayer = Players.LocalPlayer

local function Main()
	local Character = LocalPlayer.Character
	local Torso: Part = Character:FindFirstChild("Torso")
	local HRP: Part = Character:FindFirstChild("HumanoidRootPart")
	local LeftArm: Part = Character:FindFirstChild("Left Arm")
	local RightArm: Part = Character:FindFirstChild("Right Arm")
	local PC = Folder:FindFirstChild("PlayerClone")
	local PCL,PCR
	if LeftArm then
		if PC then
			PCL = PC:FindFirstChild("Left Arm")
			if PCL then
				PCL.Transparency = 1
				PCL.Orientation = LeftArm.Orientation
				PCL.Position = LeftArm.Position
			end
		end
		LeftArm.Size = Vector3.new(1,2,1)
		LeftArm.Transparency = 0
	end
	if RightArm then
		if PC then
			PCR = PC:FindFirstChild("Right Arm")
			if PCR then
				PCR.Transparency = 1
				PCR.Orientation = RightArm.Orientation
				PCR.Position = RightArm.Position
			end
		end
		RightArm.Size = Vector3.new(1,2,1)
		RightArm.Transparency = 0
	end
	if HRP then
		if not Folder:FindFirstChild("PlayerClone") then
			Character.Archivable = true
			local FChar = Character:Clone()
			FChar.Parent = Folder
			FChar.Name = "PlayerClone"

			local Weld = Instance.new("WeldConstraint")

			for _,v in pairs(FChar:GetChildren()) do
				if v:IsA("Part") then
					if not (v.Name == "Left Arm" or v.Name == "Right Arm") then
						v:Destroy()
					elseif v.Name == "Left Arm" then
						v.CFrame = LeftArm.CFrame
						local Weld = Instance.new("WeldConstraint")
						Weld.Part1 = v
						Weld.Parent = v
						Weld.Part0 = HRP
					elseif v.Name == "Right Arm" then
						v.CFrame = RightArm.CFrame
						local Weld = Instance.new("WeldConstraint")
						Weld.Part1 = v
						Weld.Parent = v
						Weld.Part0 = HRP
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
		if RightArm and LeftArm and PCL and PCR and Torso and UIS:IsKeyDown(FGrab.Keybind) then
			PCL.Transparency = 0
			PCR.Transparency = 0
			LeftArm.Transparency = 1
			RightArm.Transparency = 1
			LeftArm.Size = Vector3.new(GS,GS,GS)
			RightArm.Size = Vector3.new(GS,GS,GS)
		end
	end
end

RS.RenderStepped:Connect(Main)
