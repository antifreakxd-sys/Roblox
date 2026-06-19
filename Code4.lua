-- === [ЧАСТЬ 1: ИНТЕРФЕЙС И КНОПКИ] ===

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

local BG_COLOR = Color3.fromRGB(15, 15, 15)
local ACCENT_PURPLE = Color3.fromRGB(160, 32, 240)

local dragButton = Instance.new("TextButton", _G.screenGui)
dragButton.Name = "DragButton"
dragButton.Size = UDim2.new(0, 50, 0, 50)
dragButton.Position = UDim2.new(0.05, 0, 0.3, 0)
dragButton.BackgroundColor3 = BG_COLOR
dragButton.Text = "Menu"
dragButton.TextColor3 = ACCENT_PURPLE
dragButton.TextSize = 13
dragButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", dragButton).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", dragButton).Color = ACCENT_PURPLE

_G.mainFrame = Instance.new("Frame", _G.screenGui)
_G.mainFrame.Size = UDim2.new(0, 220, 0, 245)
_G.mainFrame.Position = UDim2.new(0.5, -110, 0.5, -122)
_G.mainFrame.BackgroundColor3 = BG_COLOR
_G.mainFrame.Visible = false
Instance.new("UICorner", _G.mainFrame).CornerRadius = UDim.new(0, 20)
Instance.new("UIStroke", _G.mainFrame).Color = ACCENT_PURPLE

local title = Instance.new("TextLabel", _G.mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "mm2 Anti-Freak"
title.TextColor3 = ACCENT_PURPLE
title.TextSize = 12
title.Font = Enum.Font.GothamBold

_G.shotButton = Instance.new("TextButton", _G.screenGui)
_G.shotButton.Size = UDim2.new(0, 80, 0, 80)
_G.shotButton.Position = UDim2.new(0.8, 0, 0.4, 0)
_G.shotButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
_G.shotButton.Text = "SHOT"
_G.shotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
_G.shotButton.TextSize = 18
_G.shotButton.Font = Enum.Font.GothamBold
_G.shotButton.Visible = false
Instance.new("UICorner", _G.shotButton).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", _G.shotButton).Color = Color3.fromRGB(255, 255, 255)

_G.tpGunButton = Instance.new("TextButton", _G.screenGui)
_G.tpGunButton.Size = UDim2.new(0, 65, 0, 65)
_G.tpGunButton.Position = UDim2.new(0.8, 8, 0.4, 90)
_G.tpGunButton.BackgroundColor3 = Color3.fromRGB(20, 140, 20)
_G.tpGunButton.Text = "TP GUN"
_G.tpGunButton.TextColor3 = Color3.fromRGB(255, 255, 255)
_G.tpGunButton.TextSize = 13
_G.tpGunButton.Font = Enum.Font.GothamBold
_G.tpGunButton.Visible = false
Instance.new("UICorner", _G.tpGunButton).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", _G.tpGunButton).Color = Color3.fromRGB(255, 255, 255)

dragButton.MouseButton1Click:Connect(function() _G.mainFrame.Visible = not _G.mainFrame.Visible end)

local function makeDraggable(guiObj)
	local dragging, dragInput, dragStart, startPos
	guiObj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true dragStart = input.Position startPos = guiObj.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	guiObj.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			guiObj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end
makeDraggable(dragButton)
makeDraggable(_G.shotButton)
makeDraggable(_G.tpGunButton)
-- === [ЧАСТЬ 2: ПЕРЕКЛЮЧАТЕЛИ В МЕНЮ] ===

_G.espActive = false
_G.gunEspActive = false
_G.kickActive = false

local function createToggle(text, yPos, callback)
	local btn = Instance.new("TextButton", _G.mainFrame)
	btn.Size = UDim2.new(1, -30, 0, 32)
	btn.Position = UDim2.new(0, 15, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Text = text .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(150, 150, 150)
	btn.TextSize = 12
	btn.Font = Enum.Font.GothamBold
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	
	local active = false
	btn.MouseButton1Click:Connect(function()
		active = not active
		btn.Text = text .. (active and ": ON" or ": OFF")
		btn.TextColor3 = active and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(150, 150, 150)
		callback(active)
	end)
end

createToggle("Show SHOT Button", 40, function(val) _G.shotButton.Visible = val end)
createToggle("Show TP GUN Button", 80, function(val) _G.tpGunButton.Visible = val end)
createToggle("Player ESP Role", 120, function(val) _G.espActive = val end)
createToggle("Dropped Gun ESP", 160, function(val) _G.gunEspActive = val end)
createToggle("Tap to Kick Player", 200, function(val) _G.kickActive = val end)
-- === [ЧАСТЬ 3: ИГРОВАЯ ЛОГИКА И ФУНКЦИИ] ===

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

local function getPlayerRole(p)
	if not p or not p.Character then return "Innocent" end
	if p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then return "Murderer"
	elseif p.Character:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Gun") then return "Sheriff" end
	return "Innocent"
end

-- === ИСПРАВЛЕННЫЙ PLAYER ESP ===
task.spawn(function()
	while task.wait(1) do
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= localPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = p.Character.HumanoidRootPart
				local box = hrp:FindFirstChild("RoleHighlight")
				if _G.espActive then
					if not box then
						box = Instance.new("BoxHandleAdornment", hrp)
						box.Name = "RoleHighlight"
						box.AlwaysOnTop = true
						box.ZIndex = 5
						box.Adornee = hrp
						box.Size = Vector3.new(2.5, 5, 2.5)
						box.Transparency = 0.5
					end
					local role = getPlayerRole(p)
					if role == "Murderer" then box.Color3 = Color3.fromRGB(255, 0, 0)
					elseif role == "Sheriff" then box.Color3 = Color3.fromRGB(0, 0, 255)
					else box.Color3 = Color3.fromRGB(255, 255, 255) end
				else
					if box then box:Destroy() end
				end
			end
		end
	end
end)

-- === МОБИЛЬНЫЙ ПОИСК ПИСТОЛЕТА ПО ТРИГГЕРАМ ===
local function findDroppedGun()
	local gun = Workspace:FindFirstChild("GunDrop")
	if gun then return gun end
	for _, object in ipairs(Workspace:GetChildren()) do
		if object.Name == "PlayerLeftGun" or object:FindFirstChild("GunHandle") then return object end
	end
	return nil
end

task.spawn(function()
	while task.wait(0.5) do
		local gunDrop = findDroppedGun()
		if gunDrop and _G.gunEspActive then
			local mainPart = gunDrop:FindFirstChild("GunHandle") or gunDrop:FindFirstChildWhichIsA("BasePart") or gunDrop
			if mainPart and not mainPart:FindFirstChild("GunHighlight") then
				local box = Instance.new("BoxHandleAdornment", mainPart)
				box.Name = "GunHighlight"
				box.AlwaysOnTop = true
				box.Size = Vector3.new(3, 3, 3)
				box.Color3 = Color3.fromRGB(0, 255, 0)
				box.Transparency = 0.4
				box.Adornee = mainPart
				
				local bb = Instance.new("BillboardGui", mainPart)
				bb.Name = "GunLabel"
				bb.Size = UDim2.new(0, 120, 0, 40)
				bb.AlwaysOnTop = true
				bb.StudsOffset = Vector3.new(0, 3, 0)
				local text = Instance.new("TextLabel", bb)
				text.Size = UDim2.new(1, 0, 1, 0)
				text.BackgroundTransparency = 1
				text.Text = "PISTOL HERE"
				text.TextColor3 = Color3.fromRGB(0, 255, 0)
				text.Font = Enum.Font.GothamBold
				text.TextSize = 14
			end
		elseif not _G.gunEspActive or not gunDrop then
			for _, v in ipairs(Workspace:GetDescendants()) do
				if v.Name == "GunHighlight" or v.Name == "GunLabel" then v:Destroy() end
			end
		end
	end
end)

-- === СТОПРОЦЕНТНЫЙ АВТО-ШОТ (РАЗВОРОТ + ТРИГГЕР) ===
_G.shotButton.MouseButton1Click:Connect(function()
	local char = localPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local gun = char:FindFirstChild("Gun") or localPlayer.Backpack:FindFirstChild("Gun")
	if not gun then return end

	local murderer
	for _, p in ipairs(Players:GetPlayers()) do
		if getPlayerRole(p) == "Murderer" then murderer = p break end
	end

	if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
		if gun.Parent == localPlayer.Backpack then gun.Parent = char end
		task.wait(0.1)
		
		local targetPos = murderer.Character.HumanoidRootPart.Position
		char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position, Vector3.new(targetPos.X, char.HumanoidRootPart.Position.Y, targetPos.Z))
		Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, targetPos)
		
		task.wait(0.05)
		gun:Activate() -- Принудительная активация пистолета (выстрел)
	end
end)

-- === ТЕЛЕПОРТ К ПИСТОЛЕТУ И ОБРАТНО ===
_G.tpGunButton.MouseButton1Click:Connect(function()
	local char = localPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local gunDrop = findDroppedGun()
	
	if gunDrop then
		local mainPart = gunDrop:FindFirstChild("GunHandle") or gunDrop:FindFirstChildWhichIsA("BasePart") or gunDrop
		if mainPart then
			local oldCFrame = char.HumanoidRootPart.CFrame
			char.HumanoidRootPart.CFrame = mainPart.CFrame
			task.wait(0.6) -- Оптимальная задержка под пинг смартфона
			char.HumanoidRootPart.CFrame = oldCFrame
		end
	end
end)

-- === МОБИЛЬНЫЙ ТАП-ПИНОК (TOUCH TAP KICK С FE BYPASS) ===
UserInputService.TouchTapInWorld:Connect(function(screenPos, ray)
	if not _G.kickActive then return end
	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {localPlayer.Character}
	
	local raycastResult = Workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
	if raycastResult and raycastResult.Instance then
		local hitModel = raycastResult.Instance:FindFirstAncestorOfClass("Model")
		if hitModel and hitModel:FindFirstChild("HumanoidRootPart") and hitModel:FindFirstChildOfClass("Humanoid") then
			local targetHrp = hitModel.HumanoidRootPart
			local myChar = localPlayer.Character
			if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
			
			-- 1. Исправленный вызов анимации через Animator
			local humanoid = myChar:FindFirstChildOfClass("Humanoid")
			local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
			if animator then
				local anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://12554743452"
				local track = animator:LoadAnimation(anim)
				track:Play()
			end
			
			-- 2. Обход FE фильтрации (Силовой толчок персонажем)
			task.spawn(function()
				local duration = 0.3
				local startTime = os.clock()
				local direction = (targetHrp.Position - myChar.HumanoidRootPart.Position).Unit
				
				while os.clock() - startTime < duration do
					if targetHrp and myChar:FindFirstChild("HumanoidRootPart") then
						-- Передаем физический импульс напрямую координатной сетке хитбокса врага
						targetHrp.AssemblyLinearVelocity = (direction * 180) + Vector3.new(0, 90, 0)
					end
					task.wait()
				end
			end)
		end
	end
end)
