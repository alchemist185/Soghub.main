repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Services
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Screen GUI
local Soghub = Instance.new("ScreenGui", game.CoreGui)
Soghub.Name = "Soghub"
Soghub.IgnoreGuiInset = true
Soghub.ResetOnSpawn = false

local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled and not UIS.MouseEnabled

-- Main Frame
local Main = Instance.new("Frame", Soghub)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Size = isMobile and UDim2.new(0, 310, 0, 370) or UDim2.new(0, 500, 0, 400)
Main.Position = UDim2.new(0.5, -Main.Size.X.Offset / 2, 0.5, -Main.Size.Y.Offset / 2)
Main.BorderSizePixel = 0
Main.BackgroundTransparency = 1
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- Fade-in
task.spawn(function()
	for i = 1, 10 do
		Main.BackgroundTransparency = 1 - (i * 0.1)
		task.wait(0.03)
	end
end)

-- Drag Support
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Header
local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Header.Text = "Soghub | Dead Rails"
Header.TextColor3 = Color3.fromRGB(0, 255, 255)
Header.TextScaled = true
Header.Font = Enum.Font.GothamBold
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

-- Header Buttons
local function CreateControlBtn(symbol, pos, onClick)
	local btn = Instance.new("TextButton", Header)
	btn.Text = symbol
	btn.Size = UDim2.new(0, 40, 1, 0)
	btn.Position = pos
	btn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextScaled = true
	btn.Font = Enum.Font.Gotham
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	btn.MouseButton1Click:Connect(onClick)
	return btn
end

local isMinimized = false
local storedSize = Main.Size
CreateControlBtn("➖", UDim2.new(1, -120, 0, 0), function()
	isMinimized = not isMinimized
	Main.Size = isMinimized and UDim2.new(0, 200, 0, 40) or storedSize
end)
CreateControlBtn("＋", UDim2.new(1, -80, 0, 0), function()
	Main.Size = storedSize
	isMinimized = false
end)
CreateControlBtn("✖", UDim2.new(1, -40, 0, 0), function()
	Soghub:Destroy()
end)

-- Tabs Setup
local tabs = {}
local currentTab = nil
local function CreateTab(name)
	local tab = Instance.new("Frame", Main)
	tab.Name = name
	tab.Size = UDim2.new(1, -10, 1, -50)
	tab.Position = UDim2.new(0, 5, 0, 45)
	tab.BackgroundTransparency = 1
	tab.Visible = false
	tabs[name] = tab
	return tab
end
local function SwitchTab(name)
	for k, v in pairs(tabs) do v.Visible = false end
	if tabs[name] then tabs[name].Visible = true end
	currentTab = name
end

-- Tab Buttons
local TabList = {"Main", "Aim Assist", "Teleports", "Visual", "Humanoid"}
for i, tabName in ipairs(TabList) do
	local btn = Instance.new("TextButton", Main)
	btn.Size = UDim2.new(0, 120, 0, 30)
	btn.Position = UDim2.new(0, 10 + (i - 1) * 130, 0, 5)
	btn.Text = tabName
	btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	btn.TextColor3 = Color3.fromRGB(0, 255, 255)
	btn.TextScaled = true
	btn.Font = Enum.Font.Gotham
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(function() SwitchTab(tabName) end)
	CreateTab(tabName)
end
SwitchTab("Main")

-- Utility: Add Buttons
local function AddButton(tab, name, callback)
	local btn = Instance.new("TextButton", tab)
	btn.Size = UDim2.new(0.9, 0, 0, 35)
	btn.Position = UDim2.new(0.05, 0, #tab:GetChildren() * 0.1, 0)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextScaled = true
	btn.Font = Enum.Font.Gotham
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(callback)
end

-- Main Tab
AddButton(tabs["Main"], "Script by Alchemist (tap to copy)", function()
	setclipboard("https://github.com/alchemist185")
end)

-- Aim Assist
AddButton(tabs["Aim Assist"], "Enable Aimbot", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/alchemist185/Aimbot.main/refs/heads/main/Main"))()
end)
AddButton(tabs["Aim Assist"], "Enable Silent Aim (NPC only)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/alchemist185/slient-aim/refs/heads/main/Slient%20aim%20main"))()
end)

-- Teleports
local tps = {
	{"Teleport to Sterling", "https://raw.githubusercontent.com/ringtaa/sterlingnotifcation.github.io/refs/heads/main/Sterling.lua"},
	{"Teleport to TeslaLab", "https://raw.githubusercontent.com/ringtaa/tptotesla.github.io/refs/heads/main/Tptotesla.lua"},
	{"Teleport to Train", "https://raw.githubusercontent.com/ringtaa/NEWTPTRAIN.github.io/refs/heads/main/TRAIN.LUA"},
	{"Teleport to Fort", "https://raw.githubusercontent.com/ringtaa/Tpfort.github.io/refs/heads/main/Tpfort.lua"},
	{"Teleport to Castle", "https://raw.githubusercontent.com/ringtaa/castletpfast.github.io/refs/heads/main/FASTCASTLE.lua"},
	{"Teleport to The End", "https://raw.githubusercontent.com/hbjrev/tpend.github.io/refs/heads/main/ringta.lua"},
}
for _, v in ipairs(tps) do
	AddButton(tabs["Teleports"], v[1], function() loadstring(game:HttpGet(v[2]))() end)
end

-- Visual
AddButton(tabs["Visual"], "Full Bright", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/alchemist185/Fullbright/refs/heads/main/Main%20lua"))()
end)

-- Humanoid Tab
local humanoid = Player.Character:WaitForChild("Humanoid")
local tab = tabs["Humanoid"]

-- Noclip
local noclip = false
local noclipBox = Instance.new("TextButton", tab)
noclipBox.Size = UDim2.new(0.9, 0, 0, 35)
noclipBox.Position = UDim2.new(0.05, 0, 0.05, 0)
noclipBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
noclipBox.TextColor3 = Color3.new(1, 1, 1)
noclipBox.TextScaled = true
noclipBox.Font = Enum.Font.Gotham
noclipBox.Text = "[ ] Noclip"
Instance.new("UICorner", noclipBox).CornerRadius = UDim.new(0, 6)

noclipBox.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBox.Text = noclip and "[✓] Noclip" or "[ ] Noclip"
end)

RunService.Stepped:Connect(function()
	if noclip and Player.Character then
		for _, v in ipairs(Player.Character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide then
				v.CanCollide = false
			end
		end
	end
end)

-- Slider Utility
local function CreateSlider(name, default, yPos, callback)
	local frame = Instance.new("Frame", tab)
	frame.Size = UDim2.new(0.9, 0, 0, 50)
	frame.Position = UDim2.new(0.05, 0, yPos, 0)
	frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1, 0, 0.5, 0)
	label.Text = name .. ": " .. tostring(default)
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham

	local slider = Instance.new("TextButton", frame)
	slider.Size = UDim2.new(1, 0, 0.5, 0)
	slider.Position = UDim2.new(0, 0, 0.5, 0)
	slider.Text = ""
	slider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 6)

	local fill = Instance.new("Frame", slider)
	fill.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
	fill.Size = UDim2.new(default, 0, 1, 0)
	fill.Name = "Fill"
	fill.BorderSizePixel = 0

	slider.MouseButton1Down:Connect(function()
		local conn
		conn = RunService.RenderStepped:Connect(function()
			local x = math.clamp((UIS:GetMouseLocation().X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(x, 0, 1, 0)
			label.Text = name .. ": " .. string.format("%.5f", x)
			callback(x)
		end)
		UIS.InputEnded:Wait()
		conn:Disconnect()
	end)
end

CreateSlider("Speed", 0.2, 0.2, function(x)
	if humanoid then humanoid.WalkSpeed = x * 100 end
end)
CreateSlider("Jump", 0.2, 0.4, function(x)
	if humanoid then humanoid.JumpPower = x * 100 end
end)
