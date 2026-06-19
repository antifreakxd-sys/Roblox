-- === [ЧАСТЬ 1: ДВУХРЯДНЫЙ ИНТЕРФЕЙС И ГАРАНТИРОВАННЫЙ FOV] ===

if game.CoreGui:FindFirstChild("AntiFreakAndroidGui") then
	game.CoreGui.AntiFreakAndroidGui:Destroy()
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

_G.screenGui = Instance.new("ScreenGui")
_G.screenGui.Name = "AntiFreakAndroidGui"
_G.screenGui.ResetOnSpawn = false

local success = pcall(function() _G.screenGui.Parent = game:GetService("CoreGui") end)
if not success then _G.screenGui.Parent = localPlayer:WaitForChild("PlayerGui") end

local BG_COLOR = Color3.fromRGB(15, 15, 15)
local PANEL_COLOR = Color3.fromRGB(25, 25, 25)
local ACCENT_PURPLE = Color3.fromRGB(160, 32, 240)

-- Круглая кнопка открытия меню
local dragButton = Instance.new("TextButton", _G.screenGui)
dragButton.Size = UDim2.new(0, 50, 0, 50)
dragButton.Position = UDim2.new(0.05, 0, 0.3, 0)
dragButton.BackgroundColor3 = BG_COLOR
dragButton.Text = "Menu"
dragButton.TextColor3 = ACCENT_PURPLE
dragButton.TextSize = 13
dragButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", dragButton).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", dragButton).Color = ACCENT_PURPLE

-- Новое расширенное Главное Окно
_G.mainFrame = Instance.new("Frame", _G.screenGui)
_G.mainFrame.Size = UDim2.new(0, 340, 0, 190) -- Широкое двухрядное меню
_G.mainFrame.Position = UDim2.new(0.5, -170, 0.5, -95)
_G.mainFrame.BackgroundColor3 = BG_COLOR
_G.mainFrame.Visible = false
Instance.new("UICorner", _G.mainFrame).CornerRadius = UDim.new(0, 16)
Instance.new("UIStroke", _G.mainFrame).Color = ACCENT_PURPLE

local title = Instance.new("TextLabel", _G.mainFrame)
title.Size = UDim2.new(1, -40, 0, 35)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "mm2 Anti-Freak"
title.TextColor3 = ACCENT_PURPLE
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка-стрелка выпадающего списка
_G.selectedTarget = nil
local dropdownActive = false

local arrowBtn = Instance.new("TextButton", _G.mainFrame)
arrowBtn.Size = UDim2.new(0, 35, 0, 35)
arrowBtn.Position = UDim2.new(1, -40, 0, 0)
arrowBtn.BackgroundTransparency = 1
arrowBtn.Text = "▼"
arrowBtn.TextColor3 = ACCENT_PURPLE
arrowBtn.TextSize = 12

-- Контейнер для кнопок функций (Два ряда)
_G.buttonContainer = Instance.new("Frame", _G.mainFrame)
_G.buttonContainer.Size = UDim2.new(1, -20, 1, -45)
_G.buttonContainer.Position = UDim2.new(0, 10, 0, 40)
_G.buttonContainer.BackgroundTransparency = 1

local gridLayout = Instance.new("UIGridLayout", _G.buttonContainer)
gridLayout.CellSize = UDim2.new(0, 155, 0, 32) -- Идеальный размер под два ряда кнопок
gridLayout.CellPadding = UDim2.new(0, 10, 0, 8)

-- Скролл-список игроков (с авто-раздвижением меню)
local scrollList = Instance.new("ScrollingFrame", _G.mainFrame)
scrollList.Size = UDim2.new(1, -20, 0, 110)
scrollList.Position = UDim2.new(0, 10, 0, 35)
scrollList.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
scrollList.Visible = false
scrollList.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollList.ScrollBarThickness = 4
Instance.new("UICorner", scrollList).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", scrollList).Color = Color3.fromRGB(45, 45, 45)
local listLayout = Instance.new("UIListLayout", scrollList)

local function updateDropdown()
	for _, child in ipairs(scrollList:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= localPlayer then
			local pBtn = Instance.new("TextButton", scrollList)
			pBtn.Size = UDim2.new(1, 0, 0, 25)
			pBtn.BackgroundColor3 = PANEL_COLOR
			pBtn.Text = p.DisplayName or p.Name
			pBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
			pBtn.TextSize = 11
			pBtn.Font = Enum.Font.SourceSansBold
			Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 4)
			
			pBtn.MouseButton1Click:Connect(function()
				_G.selectedTarget = p
				title.Text = "Target: " .. p.Name
				dropdownActive = false
				scrollList.Visible = false
				_G.buttonContainer.Position = UDim2.new(0, 10, 0, 40)
				_G.mainFrame.Size = UDim2.new(0, 340, 0, 190) -- Возвращаем размер меню назад
				arrowBtn.Text = "▼"
			end)
		end
	end
	scrollList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

-- Логика динамического растягивания меню вниз при клике на стрелочку
arrowBtn.MouseButton1Click:Connect(function()
	dropdownActive = not dropdownActive
	scrollList.Visible = dropdownActive
	arrowBtn.Text = dropdownActive and "▲" or "▼"
	if dropdownActive then
		updateDropdown()
		_G.mainFrame.Size = UDim2.new(0, 340, 0, 310) -- Плавно увеличиваем высоту фрейма
		_G.buttonContainer.Position = UDim2.new(0, 10, 0, 155) -- Смещаем кнопки вниз под список
	else
		_G.buttonContainer.Position = UDim2.new(0, 10, 0, 40)
		_G.mainFrame.Size = UDim2.new(0, 340, 0, 190) -- Сужаем меню обратно
	end
end)

-- Создание 100% рабочего FOV-круга через интерфейс Roblox (Замена Drawing API)
_G.fovRadiusValue = 160
local fovFrame = Instance.new("Frame", _G.screenGui)
fovFrame.Name = "AntiFreakFOV"
fovFrame.Size = UDim2.new(0, _G.fovRadiusValue * 2, 0, _G.fovRadiusValue * 2)
fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
fovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
fovFrame.BackgroundTransparency = 1
local fovCorner = Instance.new("UICorner", fovFrame)
fovCorner.CornerRadius = UDim.new(1, 0)
local fovStroke = Instance.new("UIStroke", fovFrame)
fovStroke.Color = ACCENT_PURPLE
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.6

task.spawn(function()
	while task.wait(0.01) do
		if fovFrame then fovFrame.Position = UDim2.new(0, camera.ViewportSize.X/2, 0, camera.ViewportSize.Y/2) end
	end
end)

-- Выносная кнопка SHOT
_G.shotButton = Instance.new("TextButton", _G.screenGui)
_G.shotButton.Size = UDim2.new(0, 75, 0, 75)
_G.shotButton.Position = UDim2.new(0.8, 0, 0.4, 0)
_G.shotButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
_G.shotButton.Text = "SHOT"
_G.shotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
_G.shotButton.TextSize = 16
_G.shotButton.Font = Enum.Font.GothamBold
_G.shotButton.Visible = false
Instance.new("UICorner", _G.shotButton).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", _G.shotButton).Color = Color3.fromRGB(255, 255, 255)

-- Выносная кнопка TP GUN
_G.tpGunButton = Instance.new("TextButton", _G.screenGui)
_G.tpGunButton.Size = UDim2.new(0, 60, 0, 60)
_G.tpGunButton.Position = UDim2.new(0.8, 7, 0.4, 85)
_G.tpGunButton.BackgroundColor3 = Color3.fromRGB(20, 140, 20)
_G.tpGunButton.Text = "TP GUN"
_G.tpGunButton.TextColor3 = Color3.fromRGB(255, 255, 255)
_G.tpGunButton.TextSize = 12
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
-- === [ЧАСТЬ 2: ДВУХРЯДНЫЕ ТУМБЛЕРЫ ФУНКЦИЙ] ===

_G.espActive = false
_G.gunEspActive = false
_G.kickActive = false
_G.stalkerActive = false

local function createToggle(text, callback)
	local btn = Instance.new("TextButton", _G.buttonContainer)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Text = text .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(150, 150, 150)
	btn.TextSize = 10
	btn.Font = Enum.Font.GothamBold
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	local active = false
	btn.MouseButton1Click:Connect(function()
		active = not active
		btn.Text = text .. (active and ": ON" or ": OFF")
		btn.TextColor3 = active and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(150, 150, 150)
		callback(active)
	end)
end

-- Автоматически распределяются сеткой UIGridLayout на 2 ряда по 3 кнопки
createToggle("Stalk Target", function(val) _G.stalkerActive = val end)
createToggle("Tap to Kick", function(val) _G.kickActive = val end)
createToggle("Show SHOT Btn", function(val) _G.shotButton.Visible = val end)
createToggle("Show TP GUN Btn", function(val) _G.tpGunButton.Visible = val end)
createToggle("Player ESP", function(val) _G.espActive = val end)
createToggle("Dropped Gun ESP", function(val) _G.gunEspActive = val end)
-- === [ЧАСТЬ 3: ПОЛНОСТЬЮ ПЕРЕПИСАННАЯ РАБОЧАЯ ЛОГИКА] ===

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local function getPlayerRole(p)
	if not p then return "Innocent" end
	if p:FindFirstChild("Backpack") then
		if p.Backpack:FindFirstChild("Knife") then return "Murderer" end
		if p.Backpack:FindFirstChild("Gun") then return "Sheriff" end
	end
	if p.Character then
		if p.Character:FindFirstChild("Knife") then return "Murderer" end
		if p.Character:FindFirstChild("Gun") then return "Sheriff" end
	end
	return "Innocent"
end

-- Проверка нахождения Мардера в GUI-круге
local function getMurdererInFov()
	local murderer
	for _, p in ipairs(Players:GetPlayers()) do
		if getPlayerRole(p) == "Murderer" then murderer = p break end
	end
	if not murderer and Workspace:FindFirstChild("Knife") then
		murderer = Players:GetPlayerFromCharacter(Workspace.Knife.Parent)
	end

	if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
		local screenPos, onScreen = camera:WorldToViewportPoint(murderer.Character.HumanoidRootPart.Position)
		if onScreen then
			local mousePos = camera.ViewportSize / 2
			local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
			if distance <= _G.fovRadiusValue then return murderer end
		end
	end
	return nil
end

-- === PLAYER OUTLINE ESP ===
task.spawn(function()
	while task.wait(0.5) do
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= localPlayer and p.Character then
				local char = p.Character
				local hl = char:FindFirstChild("AntiFreakESP")
				if _G.espActive then
					if not hl then
						hl = Instance.new("Highlight", char)
						hl.Name = "AntiFreakESP"
						hl.FillTransparency = 0.5
						hl.OutlineTransparency = 0.1
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					end
					local role = getPlayerRole(p)
					if role == "Murderer" then hl.FillColor = Color3.fromRGB(255,0,0) hl.OutlineColor = Color3.fromRGB(255,0,0)
					elseif role == "Sheriff" then hl.FillColor = Color3.fromRGB(0,100,255) hl.OutlineColor = Color3.fromRGB(0,100,255)
					else hl.FillColor = Color3.fromRGB(255,255,255) hl.OutlineColor = Color3.fromRGB(255,255,255) end
				else
					if hl then hl:Destroy() end
				end
			end
		end
	end
end)

-- === ОБНОВЛЕННЫЙ ПОИСК ПИСТОЛЕТА ПО КЛАССАМ И ХЕНДЛАМ ===
local function findDroppedGun()
	local gun = Workspace:FindFirstChild("GunDrop") or Workspace:FindFirstChild("PlayerLeftGun")
	if gun then return gun end
	for _, obj in ipairs(Workspace:GetChildren()) do
		if obj:IsA("Tool") and obj.Name:match("Gun") then return obj end
		if obj:IsA("BasePart") and obj.Name == "GunHandle" then return obj.Parent end
	end
	return nil
end

task.spawn(function()
	while task.wait(0.5) do
		local gunDrop = findDroppedGun()
		if gunDrop and _G.gunEspActive then
			local mainPart = gunDrop:FindFirstChild("GunHandle") or gunDrop:FindFirstChildWhichIsA("BasePart") or gunDrop
			if mainPart and not mainPart:FindFirstChild("GunHighlightESP") then
				local hl = Instance.new("Highlight", gunDrop)
				hl.Name = "GunHighlightESP"
				hl.FillColor = Color3.fromRGB(0, 255, 0)
				hl.OutlineColor = Color3.fromRGB(0, 255, 0)
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				
				local bb = Instance.new("BillboardGui", mainPart)
				bb.Name = "GunLabel"
				bb.Size = UDim2.new(0, 120, 0, 40)
				bb.AlwaysOnTop = true
				bb.StudsOffset = Vector3.new(0, 2.5, 0)
				local text = Instance.new("TextLabel", bb)
				text.Size = UDim2.new(1, 0, 1, 0)
				text.BackgroundTransparency = 1
				text.Text = "★ PISTOL HERE ★"
				text.TextColor3 = Color3.fromRGB(0, 255, 0)
				text.Font = Enum.Font.GothamBold
				text.TextSize = 13
			end
		elseif not _G.gunEspActive or not gunDrop then
			for _, v in ipairs(Workspace:GetDescendants()) do
				if v.Name == "GunHighlightESP" or v.Name == "GunLabel" then v:Destroy() end
			end
		end
	end
end)

-- === ЖЕСТКИЙ АВТО-ШОТ ЧЕРЕЗ АКТИВАЦИЮ ПРЕДМЕТА ===
_G.shotButton.MouseButton1Click:Connect(function()
	local char = localPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local gun = char:FindFirstChild("Gun") or localPlayer.Backpack:FindFirstChild("Gun")
	if not gun then return end

	local murderer = getMurdererInFov()
	if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
		-- Снаряжаем пистолет на физическом уровне персонажа
		if gun.Parent == localPlayer.Backpack then gun.Parent = char end
		task.wait(0.05)
		
		-- Доворачиваем камеру и тело ровно в торс врага
		local targetPos = murderer.Character.HumanoidRootPart.Position
		char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position, Vector3.new(targetPos.X, char.HumanoidRootPart.Position.Y, targetPos.Z))
		camera.CFrame = CFrame.new(camera.CFrame.Position, targetPos)
		
		task.wait(0.02)
		gun:Activate() -- Легитный физический выстрел самого тула (Обходит любые фиксы пакетов!)
	end
end)

-- === ТЕЛЕПОРТ К ПИСТОЛЕТУ ===
_G.tpGunButton.MouseButton1Click:Connect(function()
	local char = localPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local gunDrop = findDroppedGun()
	if gunDrop then
		local targetPart = gunDrop:FindFirstChild("GunHandle") or gunDrop:FindFirstChildWhichIsA("BasePart") or gunDrop
		if targetPart then
			local oldCFrame = char.HumanoidRootPart.CFrame
			char.HumanoidRootPart.CFrame = targetPart.CFrame
			task.wait(0.6)
			char.HumanoidRootPart.CFrame = oldCFrame
		end
	end
end)

-- === СГЛАЖЕННЫЙ ТАРГЕТ СТАЛКЕР БЕЗ ДЁРГАНИЙ И СТОЛКНОВЕНИЙ ===
task.spawn(function()
	local loopTime = 0
	while task.wait(0.01) do
		if _G.stalkerActive and _G.selectedTarget and _G.selectedTarget.Character then
			local myChar = localPlayer.Character
			local targetChar = _G.selectedTarget.Character
			if myChar and myChar:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChild("HumanoidRootPart") then
				local myHrp = myChar.HumanoidRootPart
				local targetHrp = targetChar.HumanoidRootPart
				
				-- Отключаем коллизии тела, чтобы плавно пролетать за игроком сквозь дверные проемы
				pcall(function()
					for _, part in ipairs(myChar:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = false end
					end
				end)
				
				loopTime = loopTime + 0.15
				local dynamicDist = 1.3 + (math.sin(loopTime) * 0.4) -- Короткая дистанция, ходит вплотную
				local targetBackPos = targetHrp.CFrame * CFrame.new(0, 0, dynamicDist)
				
				myHrp.CFrame = myHrp.CFrame:Lerp(CFrame.new(targetBackPos.Position, targetHrp.Position), 0.25)
			end
		end
	end
end)

-- === СДВИГ FE ДЛЯ КЛИК-ПИНКА НА СЕНСОРЕ ===
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
			
			local humanoid = myChar:FindFirstChildOfClass("Humanoid")
			local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
			if animator then
				local anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://12554743452"
				pcall(function() animator:LoadAnimation(anim):Play() end)
			end
			
			task.spawn(function()
				local direction = (targetHrp.Position - myChar.HumanoidRootPart.Position).Unit
				for i = 1, 25 do
					if targetHrp and myChar and myChar:FindFirstChild("HumanoidRootPart") then
						myChar.HumanoidRootPart.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 0.8)
						targetHrp.CFrame = targetHrp.CFrame + (direction * 18) + Vector3.new(0, 4, 0)
						targetHrp.AssemblyLinearVelocity = (direction * 600)
					end
					task.wait()
				end
			end)
		end
	end
end)
