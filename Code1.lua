if game.CoreGui:FindFirstChild("AntiFreakAndroidGui") then
	game.CoreGui.AntiFreakAndroidGui:Destroy()
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

_G.screenGui = Instance.new("ScreenGui")
_G.screenGui.Name = "AntiFreakAndroidGui"
_G.screenGui.ResetOnSpawn = false

local success = pcall(function() _G.screenGui.Parent = game:GetService("CoreGui") end)
if not success then _G.screenGui.Parent = player:WaitForChild("PlayerGui") end

_G.BG_COLOR = Color3.fromRGB(12, 12, 12)
_G.PANEL_COLOR = Color3.fromRGB(18, 18, 18)
_G.ACCENT_PURPLE = Color3.fromRGB(160, 32, 240)
_G.TEXT_COLOR = Color3.fromRGB(220, 220, 220)
_G.MUTED_TEXT = Color3.fromRGB(120, 120, 120)

local dragButton = Instance.new("TextButton")
dragButton.Name = "DragButton"
dragButton.Size = UDim2.new(0, 60, 0, 60)
dragButton.Position = UDim2.new(0.05, 0, 0.3, 0)
dragButton.BackgroundColor3 = _G.PANEL_COLOR
dragButton.Text = "Menu"
dragButton.TextColor3 = _G.ACCENT_PURPLE
dragButton.TextSize = 14
dragButton.Font = Enum.Font.GothamBold
dragButton.Parent = _G.screenGui

Instance.new("UICorner", dragButton).CornerRadius = UDim.new(1, 0)
local stroke = Instance.new("UIStroke", dragButton)
stroke.Color = _G.ACCENT_PURPLE
stroke.Thickness = 2

_G.mainFrame = Instance.new("Frame")
_G.mainFrame.Name = "MainFrame"
_G.mainFrame.Size = UDim2.new(0, 560, 0, 420)
_G.mainFrame.Position = UDim2.new(0.5, -280, 0.5, -210)
_G.mainFrame.BackgroundColor3 = _G.BG_COLOR
_G.mainFrame.BorderSizePixel = 0
_G.mainFrame.Visible = false
_G.mainFrame.Parent = _G.screenGui

Instance.new("UIStroke", _G.mainFrame).Color = Color3.fromRGB(30, 30, 30)
local line = Instance.new("Frame", _G.mainFrame)
line.Size = UDim2.new(1, 0, 0, 2)
line.BackgroundColor3 = _G.ACCENT_PURPLE
line.BorderSizePixel = 0

local title = Instance.new("TextLabel", _G.mainFrame)
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Text = "mm2 Anti-Freak"
title.TextColor3 = _G.ACCENT_PURPLE
title.TextSize = 14
title.Font = Enum.Font.Code
title.TextXAlignment = Enum.TextXAlignment.Left

dragButton.MouseButton1Click:Connect(function()
	_G.mainFrame.Visible = not _G.mainFrame.Visible
end)

local dragging, dragInput, dragStart, startPos
dragButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = dragButton.Position
		input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
	end
end)
dragButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		dragButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
local iconTabs = Instance.new("Frame", _G.mainFrame)
iconTabs.Size = UDim2.new(1, -40, 0, 40)
iconTabs.Position = UDim2.new(0, 20, 0, 30)
iconTabs.BackgroundTransparency = 1

local iconLayout = Instance.new("UIListLayout", iconTabs)
iconLayout.FillDirection = Enum.FillDirection.Horizontal
iconLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
iconLayout.Padding = UDim.new(0, 40)

local function createIconTab(text, active)
	local btn = Instance.new("TextButton", iconTabs)
	btn.Size = UDim2.new(0, 40, 1, 0)
	btn.BackgroundTransparency = 1
	btn.Text = text
	btn.TextColor3 = active and _G.ACCENT_PURPLE or _G.MUTED_TEXT
	btn.TextSize = 20
	btn.Font = Enum.Font.GothamBold
end
createIconTab("⌖", true)
createIconTab("☼", false)
createIconTab("👤", false)
createIconTab("⚙", false)

local function createSection(name, size, pos)
	local box = Instance.new("Frame", _G.mainFrame)
	box.Size = size
	box.Position = pos
	box.BackgroundColor3 = _G.PANEL_COLOR
	box.BorderSizePixel = 0
	Instance.new("UIStroke", box).Color = Color3.fromRGB(35, 35, 35)
	
	local lbl = Instance.new("TextLabel", box)
	lbl.Size = UDim2.new(0, 90, 0, 16)
	lbl.Position = UDim2.new(0.5, -45, 0, -8)
	lbl.BackgroundColor3 = _G.BG_COLOR
	lbl.Text = name
	lbl.TextColor3 = _G.ACCENT_PURPLE
	lbl.TextSize = 11
	lbl.Font = Enum.Font.SourceSans
	return box
end

_G.opBox = createSection("Options", UDim2.new(0, 250, 0, 320), UDim2.new(0, 15, 0, 80))
_G.chBox = createSection("Chams", UDim2.new(0, 250, 0, 180), UDim2.new(1, -265, 0, 80))
_G.wBox = createSection("World", UDim2.new(0, 250, 0, 125), UDim2.new(1, -265, 0, 275))

local function createSubTabs(parent, tabs)
	local container = Instance.new("Frame", parent)
	container.Size = UDim2.new(1, 0, 0, 22)
	container.BackgroundTransparency = 1
	local layout = Instance.new("UIListLayout", container)
	layout.FillDirection = Enum.FillDirection.Horizontal
	
	for i, name in ipairs(tabs) do
		local btn = Instance.new("TextButton", container)
		btn.Size = UDim2.new(1 / #tabs, 0, 1, 0)
		btn.BackgroundColor3 = i == 2 and Color3.fromRGB(24, 24, 24) or _G.PANEL_COLOR
		btn.BorderSizePixel = 0
		btn.Text = name
		btn.TextColor3 = i == 2 and _G.ACCENT_PURPLE or _G.MUTED_TEXT
		btn.TextSize = 11
		btn.Font = Enum.Font.SourceSansBold
		if i == 2 then
			local line = Instance.new("Frame", btn)
			line.Size = UDim2.new(1, 0, 0, 1)
			line.BackgroundColor3 = _G.ACCENT_PURPLE
			line.BorderSizePixel = 0
		end
	end
end
createSubTabs(_G.opBox, {"Main", "Filters", "Misc", "Other"})
createSubTabs(_G.chBox, {"Main", "Mods"})
local list = Instance.new("Frame", _G.opBox)
list.Size = UDim2.new(1, -20, 1, -35)
list.Position = UDim2.new(0, 12, 0, 30)
list.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0, 5)

local function createCb(parent, name, checked)
	local item = Instance.new("Frame", parent)
	item.Size = UDim2.new(1, 0, 0, 18)
	item.BackgroundTransparency = 1
	
	local box = Instance.new("Frame", item)
	box.Size = UDim2.new(0, 12, 0, 12)
	box.Position = UDim2.new(0, 0, 0.5, -6)
	box.BackgroundColor3 = checked and _G.ACCENT_PURPLE or Color3.fromRGB(30, 30, 30)
	box.BorderSizePixel = 0
	
	local lbl = Instance.new("TextButton", item)
	lbl.Size = UDim2.new(1, -25, 1, 0)
	lbl.Position = UDim2.new(0, 22, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = name
	lbl.TextColor3 = checked and _G.TEXT_COLOR or _G.MUTED_TEXT
	lbl.TextSize = 13
	lbl.Font = Enum.Font.SourceSans
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	
	lbl.MouseButton1Click:Connect(function()
		checked = not checked
		box.BackgroundColor3 = checked and _G.ACCENT_PURPLE or Color3.fromRGB(30, 30, 30)
		lbl.TextColor3 = checked and _G.TEXT_COLOR or _G.MUTED_TEXT
	end)
end

createCb(list, "All", false)
createCb(list, "Players", true)
createCb(list, "Show Team", true)
createCb(list, "Weapons", false)
createCb(list, "Nades", true)
createCb(list, "C4", false)

local function createRightCb(parent, name, checked, pos)
	local f = Instance.new("Frame", parent)
	f.Size = UDim2.new(1, 0, 0, 16)
	f.Position = pos
	f.BackgroundTransparency = 1
	createCb(f, name, checked)
end

createRightCb(_G.chBox, "Enemies (Visible)", true, UDim2.new(0, 12, 0, 30))
createRightCb(_G.chBox, "Enemies (Invisible)", true, UDim2.new(0, 12, 0, 48))
createRightCb(_G.chBox, "Team", false, UDim2.new(0, 12, 0, 66))
createRightCb(_G.chBox, "Local Chams", false, UDim2.new(0, 12, 0, 84))

local function createDd(parent, title, selected, pos)
	local lbl = Instance.new("TextLabel", parent)
	lbl.Size = UDim2.new(1, -20, 0, 14)
	lbl.Position = pos
	lbl.BackgroundTransparency = 1
	lbl.Text = title
	lbl.TextColor3 = _G.TEXT_COLOR
	lbl.TextSize = 11
	lbl.Font = Enum.Font.SourceSansBold
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	
	local dd = Instance.new("Frame", parent)
	dd.Size = UDim2.new(1, -20, 0, 20)
	dd.Position = UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset + 15)
	dd.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Instance.new("UIStroke", dd).Color = Color3.fromRGB(40, 40, 40)
	
	local txt = Instance.new("TextLabel", dd)
	txt.Size = UDim2.new(1, -10, 1, 0)
	txt.Position = UDim2.new(0, 6, 0, 0)
	txt.BackgroundTransparency = 1
	txt.Text = selected
	txt.TextColor3 = _G.MUTED_TEXT
	txt.TextSize = 11
	txt.Font = Enum.Font.SourceSans
	txt.TextXAlignment = Enum.TextXAlignment.Left
end

createDd(_G.chBox, "Hand Chams", "off", UDim2.new(0, 12, 0, 105))
createDd(_G.chBox, "Weapon Chams", "off", UDim2.new(0, 12, 0, 142))

createRightCb(_G.wBox, "Force update Materials", false, UDim2.new(0, 12, 0, 12))
createDd(_G.wBox, "Change Sky", "Default", UDim2.new(0, 12, 0, 30))

local function createSlider(parent, title, percent, pos)
	local lbl = Instance.new("TextLabel", parent)
	lbl.Size = UDim2.new(1, -20, 0, 14)
	lbl.Position = pos
	lbl.BackgroundTransparency = 1
	lbl.Text = title .. "   " .. percent .. "%"
	lbl.TextColor3 = _G.TEXT_COLOR
	lbl.TextSize = 11
	lbl.Font = Enum.Font.SourceSans
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	
	local bg = Instance.new("Frame", parent)
	bg.Size = UDim2.new(1, -20, 0, 5)
	bg.Position = UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset + 16)
	bg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	bg.BorderSizePixel = 0
	
	local fill = Instance.new("Frame", bg)
	fill.Size = UDim2.new(percent / 100, 0, 1, 0)
	fill.BackgroundColor3 = _G.ACCENT_PURPLE
	fill.BorderSizePixel = 0
end

createSlider(_G.wBox, "Brightness percentage", 20, UDim2.new(0, 12, 0, 70))
createSlider(_G.wBox, "Asus percentage", 95, UDim2.new(0, 12, 0, 95))
