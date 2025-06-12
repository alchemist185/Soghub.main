local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoordinatesGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local coordsLabel = Instance.new("TextLabel")
coordsLabel.Size = UDim2.new(0, 400, 0, 30)
coordsLabel.Position = UDim2.new(0.5, -200, 0, 10) -- Top center
coordsLabel.BackgroundTransparency = 1 -- Fully transparent background
coordsLabel.TextTransparency = 0 -- Fully visible text
coordsLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- will be overridden by rainbow
coordsLabel.Font = Enum.Font.SourceSansBold
coordsLabel.TextSize = 20
coordsLabel.Text = "Coordinates: X: 0 Y: 0 Z: 0"
coordsLabel.Parent = screenGui

-- Rainbow color function
local function HSVToRGB(h, s, v)
	local r, g, b
	local i = math.floor(h * 6)
	local f = h * 6 - i
	local p = v * (1 - s)
	local q = v * (1 - f * s)
	local t = v * (1 - (1 - f) * s)
	i = i % 6
	if i == 0 then r, g, b = v, t, p
	elseif i == 1 then r, g, b = q, v, p
	elseif i == 2 then r, g, b = p, v, t
	elseif i == 3 then r, g, b = p, q, v
	elseif i == 4 then r, g, b = t, p, v
	elseif i == 5 then r, g, b = v, p, q end
	return Color3.new(r, g, b)
end

-- Update coords and rainbow color
local RunService = game:GetService("RunService")
local hue = 0

RunService.RenderStepped:Connect(function()
	local char = player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		local pos = char.HumanoidRootPart.Position
		coordsLabel.Text = string.format("Coordinates: X: %.1f  Y: %.1f  Z: %.1f", pos.X, pos.Y, pos.Z)
	end

	-- Animate rainbow text
	hue = (hue + 0.005) % 1
	coordsLabel.TextColor3 = HSVToRGB(hue, 1, 1)
end)
