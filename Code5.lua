-- === [ЧАСТЬ 1: ОБНОВЛЕННЫЙ ИНТЕРФЕЙС И ДРОПДАУН ИГРОКОВ] ===

if game.CoreGui:FindFirstChild("AntiFreakAndroidGui") then
	game.CoreGui.AntiFreakAndroidGui:Destroy()
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

_G.screenGui = Instance.new("ScreenGui")
_G.screenGui.Name = "AntiFreakAndroidGui"
_G.screenGui.ResetOnSpawn = false

local success = pcall(function() _G.screenGui.Parent = game:GetService("CoreGui") end)
if not success then _G.screenGui.Parent = player:WaitForChild("PlayerGui") end

local BG_COLOR = Color3.fromRGB(15, 15, 15)
local ACCENT_PURPLE = Color3.fromRGB(160, 32, 240)

-- Круглая кнопка меню
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

-- Главное окно
_G.mainFrame = Instance.new("Frame", _G.screenGui)
_G.mainFrame.Size = UDim2.new(0, 230, 0, 310) -- Увеличили под новые функции
_G.mainFrame.Position = UDim2.new(0.5, -115, 0.5, -155)
_G.mainFrame.BackgroundColor3 = BG_COLOR
_G.mainFrame.Visible = false
Instance.new("UICorner", _G.mainFrame).CornerRadius = UDim.new(0, 20)
Instance.new("UIStroke", _G.mainFrame).Color = ACCENT_PURPLE

local title = Instance.new("TextLabel", _G.mainFrame)
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "mm2 Anti-Freak"
title.TextColor3 = ACCENT_PURPLE
title.TextSize = 12
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка-стрелочка для открытия списка игроков
_G.selectedTarget = nil
local dropdownActive = false

local arrowBtn = Instance.new("TextButton", _G.mainFrame)
arrowBtn.Size = UDim2.new(0, 30, 0, 30)
arrowBtn.Position = UDim2.new(1, -35, 0, 0)
arrowBtn.BackgroundTransparency = 1
arrowBtn.Text = "▼"
arrowBtn.TextColor3 = ACCENT_PURPLE
arrowBtn.TextSize = 12

-- Контейнер для выпадающего списка (ScrollingFrame)
local scrollList = Instance.new("ScrollingFrame", _G.mainFrame)
scrollList.Size = UDim2.new(1, -20, 0, 120)
scrollList.Position = UDim2.new(0, 10, 0, 32)
scrollList.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
scrollList.Visible = false
scrollList.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollList.ScrollBarThickness = 4
Instance.new("UICorner", scrollList).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", scrollList).Color = Color3.fromRGB(45, 45, 45)

local listLayout = Instance.new("UIListLayout", scrollList)
listLayout.Padding = UDim.new(0, 2)

local function updateDropdown()
	for _, child in ipairs(scrollList:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= localPlayer then
			local pBtn = Instance.new("TextButton", scrollList)
			pBtn.Size = UDim2.new(1, 0, 0, 25)
			pBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
				arrowBtn.Text = "▼"
			end)
		end
	end
	scrollList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

arrowBtn.MouseButton1Click:Connect(function()
	dropdownActive = not dropdownActive
	scrollList.Visible = dropdownActive
	arrowBtn.Text = dropdownActive and "▲" or "▼"
	if dropdownActive then updateDropdown() end
end)

-- Создание выносных кнопок экрана
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
_G.stalkerActive = false

local function createToggle(text, yPos, callback)
	local btn = Instance.new("TextButton", _G.mainFrame)
	btn.Size = UDim2.new(1, -20, 0, 32)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Text = text .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(150, 150, 150)
	btn.TextSize = 11
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

-- Смещаем тумблеры вниз, чтобы они не перекрывались выпадающим списком игроков
createToggle("Show SHOT Button", 150, function(val) _G.shotButton.Visible = val end)
createToggle("Show TP GUN Button", 185, function(val) _G.tpGunButton.Visible = val end)
createToggle("Player Outline ESP", 220, function(val) _G.espActive = val end)
createToggle("Dropped Gun ESP", 255, function(val) _G.gunEspActive = val end)
createToggle("Tap to Kick Player", 115, function(val) _G.kickActive = val end)
createToggle("Stalk Selected Player Back", 40, function(val) _G.stalkerActive = val end)
-- === [ЧАСТЬ 3: ИГРОВАЯ ЛОГИКА И ИСПРАВЛЕНИЯ] ===

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

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

-- === ПОИСК ПИСТОЛЕТА ===
local function findDroppedGun()
	local gun = Workspace:FindFirstChild("GunDrop")
	if gun then return gun end
	for _, obj in ipairs(Workspace:GetChildren()) do
		if obj.Name == "PlayerLeftGun" or obj:FindFirstChild("GunHandle") then return obj end
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
				bb.Name = "GunLabel" or bb.Name
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

-- === МОЩНЫЙ СЕТЕВОЙ АВТО-ШОТ (УБИЙСТВО СЕТЕВЫМ ПАКЕТОМ) ===
_G.shotButton.MouseButton1Click:Connect(function()
	local char = localPlayer.Character
	if not char then return end
	local gun = char:FindFirstChild("Gun") or localPlayer.Backpack:FindFirstChild("Gun")
	if not gun then return end

	local murderer
	for _, p in ipairs(Players:GetPlayers()) do
		if getPlayerRole(p) == "Murderer" then murderer = p break end
	end

	if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
		if gun.Parent == localPlayer.Backpack then gun.Parent = char end
		task.wait(0.05)
		
		local targetPos = murderer.Character.HumanoidRootPart.Position
		-- Перехват реклиента MM2: отправка вектора попадания пули прямо в голову
		local shootEvent = gun:FindFirstChild("Shoot") or gun:FindFirstChildWhichIsA("RemoteEvent")
		if shootEvent then
			shootEvent:FireServer(targetPos, targetPos, murderer.Character.Head)
		end
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

-- === ФУНКЦИЯ ТРОЛЛИНГА: СЛЕДОВАНИЕ ЗА СПИНОЙ (STALKER) ===
task.spawn(function()
	local step = 0
	local forward = true
	
	while task.wait(0.02) do
		if _G.stalkerActive and _G.selectedTarget and _G.selectedTarget.Character and _G.selectedTarget.Character:FindFirstChild("HumanoidRootPart") then
			local myChar = localPlayer.Character
			local targetChar = _G.selectedTarget.Character
			
			if myChar and myChar:FindFirstChild("HumanoidRootPart") then
				local targetHrp = targetChar.HumanoidRootPart
				local myHrp = myChar.HumanoidRootPart
				
				-- Алгоритм цикличного отдаления/приближения от спины
				if forward then
					step = step + 0.1
					if step >= 6 then forward = false end
				else
					step = step - 0.1
					if step <= 2 then forward = true end
				end
				
				-- Рассчитываем точку строго позади взгляда игрока
				local backPosition = targetHrp.CFrame * CFrame.new(0, 0, step)
				myHrp.CFrame = CFrame.new(backPosition.Position, targetHrp.Position)
			end
		end
	end
end)

-- === ПОЛНОСТЬЮ ПЕРЕПИСАННЫЙ ФИЗИЧЕСКИЙ ПИНОК (FE BYPASS VOID KICK) ===
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
			
			-- Проигрывание удара
			local humanoid = myChar:FindFirstChildOfClass("Humanoid")
			local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
			if animator then
				local anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://12554743452"
				pcall(function() animator:LoadAnimation(anim):Play() end)
			end
			
			-- FE БОМБАРДИРОВКА КООРДИНАТ (Принудительное выталкивание цели из карты)
			task.spawn(function()
				local direction = (targetHrp.Position - myChar.HumanoidRootPart.Position).Unit
				for i = 1, 30 do
					if targetHrp and myChar and myChar:FindFirstChild("HumanoidRootPart") then
						-- Перегружаем CFrame чужого хитбокса за счет микро-коллизий нашего тела
						myChar.HumanoidRootPart.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 1)
						targetHrp.CFrame = targetHrp.CFrame + (direction * 15) + Vector3.new(0, 5, 0)
						targetHrp.AssemblyLinearVelocity = (direction * 500)
					end
					task.wait()
				end
			end)
		end
	end
end)
