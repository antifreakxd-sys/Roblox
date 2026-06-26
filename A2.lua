getgenv().TreasureAutoFarm = {
    Mode = "None",         -- "Fly-TP" или "None"
    SpeedTier = 2,         -- 1, 2 или 3
    WaitAtChest = 2.5      
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiFreak_V26_Hybrid"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(18, 16, 24)
ToggleButton.Text = "🔮"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 28
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
local BtnStroke = Instance.new("UIStroke", ToggleButton)
BtnStroke.Color = Color3.fromRGB(140, 80, 255)
BtnStroke.Thickness = 2

local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Size = UDim2.new(0, 280, 0, 100) 
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(11, 10, 15)
MainMenu.ClipsDescendants = true
MainMenu.BackgroundTransparency = 1 
MainMenu.ZIndex = 5
MainMenu.Parent = ScreenGui
Instance.new("UICorner", MainMenu).CornerRadius = UDim.new(0, 16)

local MenuStroke = Instance.new("UIStroke", MainMenu)
MenuStroke.Color = Color3.fromRGB(55, 45, 75)
MenuStroke.Thickness = 1.5

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "by @AntiFreakXD"
Title.TextColor3 = Color3.fromRGB(180, 120, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextTransparency = 1
Title.ZIndex = 6
Title.Parent = MainMenu

local LineSeparator = Instance.new("Frame")
LineSeparator.Size = UDim2.new(0.9, 0, 0, 1)
LineSeparator.Position = UDim2.new(0.05, 0, 0, 40)
LineSeparator.BackgroundColor3 = Color3.fromRGB(45, 35, 65)
LineSeparator.BackgroundTransparency = 1
LineSeparator.ZIndex = 6
LineSeparator.Parent = MainMenu

local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(0, 250, 0, 45)
FlyFrame.Position = UDim2.new(0, 20, 0, 50)
FlyFrame.BackgroundTransparency = 1
FlyFrame.ZIndex = 6
FlyFrame.Parent = MainMenu

local FlyToggleBtn = Instance.new("TextButton")
FlyToggleBtn.Size = UDim2.new(0, 195, 1, 0)
FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(24, 20, 32)
FlyToggleBtn.Text = "🚀 LAUNCH FLY-TP"
FlyToggleBtn.TextColor3 = Color3.fromRGB(220, 200, 255)
FlyToggleBtn.TextSize = 11
FlyToggleBtn.Font = Enum.Font.GothamBold
FlyToggleBtn.BackgroundTransparency = 1
FlyToggleBtn.TextTransparency = 1
FlyToggleBtn.ZIndex = 7
FlyToggleBtn.Parent = FlyFrame
Instance.new("UICorner", FlyToggleBtn).CornerRadius = UDim.new(0, 8)
local BtnToggleStroke = Instance.new("UIStroke", FlyToggleBtn)
BtnToggleStroke.Color = Color3.fromRGB(75, 55, 110)
BtnToggleStroke.Thickness = 1
BtnToggleStroke.Transparency = 1

local ArrowBtn = Instance.new("TextButton")
ArrowBtn.Size = UDim2.new(0, 40, 1, 0)
ArrowBtn.Position = UDim2.new(0, 200, 0, 0)
ArrowBtn.BackgroundColor3 = Color3.fromRGB(32, 26, 42)
ArrowBtn.Text = "⚙️"
ArrowBtn.TextColor3 = Color3.fromRGB(180, 120, 255)
ArrowBtn.TextSize = 12
ArrowBtn.Font = Enum.Font.GothamBold
ArrowBtn.BackgroundTransparency = 1
ArrowBtn.TextTransparency = 1
ArrowBtn.ZIndex = 7
ArrowBtn.Parent = FlyFrame
Instance.new("UICorner", ArrowBtn).CornerRadius = UDim.new(0, 8)
local ArrowStroke = Instance.new("UIStroke", ArrowBtn)
ArrowStroke.Color = Color3.fromRGB(75, 55, 110)
ArrowStroke.Thickness = 1
ArrowStroke.Transparency = 1

local SpeedContainer = Instance.new("Frame")
SpeedContainer.Size = UDim2.new(1, -40, 0, 55)
SpeedContainer.Position = UDim2.new(0, 20, 0, 105)
SpeedContainer.BackgroundTransparency = 1
SpeedContainer.Visible = false
SpeedContainer.ZIndex = 6
SpeedContainer.Parent = MainMenu

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, 0, 0, 20)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "⚡ SELECT FARM GEAR:"
SpeedTitle.TextColor3 = Color3.fromRGB(190, 180, 210)
SpeedTitle.TextSize = 11
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.TextTransparency = 1
SpeedTitle.ZIndex = 7
SpeedTitle.Parent = SpeedContainer

local Gear1 = Instance.new("TextButton")
Gear1.Size = UDim2.new(0, 70, 0, 25)
Gear1.Position = UDim2.new(0, 0, 0, 25)
Gear1.BackgroundColor3 = Color3.fromRGB(24, 20, 32)
Gear1.Text = "Gear 1"
Gear1.TextColor3 = Color3.fromRGB(255, 255, 255)
Gear1.Font = Enum.Font.GothamBold
Gear1.TextSize = 11
Gear1.BackgroundTransparency = 1
Gear1.TextTransparency = 1
Gear1.ZIndex = 8
Gear1.Parent = SpeedContainer
Instance.new("UICorner", Gear1).CornerRadius = UDim.new(0, 6)
local G1Stroke = Instance.new("UIStroke", Gear1)
G1Stroke.Color = Color3.fromRGB(75, 55, 110)
G1Stroke.Transparency = 1

local Gear2 = Instance.new("TextButton")
Gear2.Size = UDim2.new(0, 70, 0, 25)
Gear2.Position = UDim2.new(0, 85, 0, 25)
Gear2.BackgroundColor3 = Color3.fromRGB(140, 75, 255)
Gear2.Text = "Gear 2"
Gear2.TextColor3 = Color3.fromRGB(255, 255, 255)
Gear2.Font = Enum.Font.GothamBold
Gear2.TextSize = 11
Gear2.BackgroundTransparency = 1
Gear2.TextTransparency = 1
Gear2.ZIndex = 8
Gear2.Parent = SpeedContainer
Instance.new("UICorner", Gear2).CornerRadius = UDim.new(0, 6)
local G2Stroke = Instance.new("UIStroke", Gear2)
G2Stroke.Color = Color3.fromRGB(255, 255, 255)
G2Stroke.Transparency = 1

local Gear3 = Instance.new("TextButton")
Gear3.Size = UDim2.new(0, 70, 0, 25)
Gear3.Position = UDim2.new(0, 170, 0, 25)
Gear3.BackgroundColor3 = Color3.fromRGB(24, 20, 32)
Gear3.Text = "Gear 3"
Gear3.TextColor3 = Color3.fromRGB(255, 255, 255)
Gear3.Font = Enum.Font.GothamBold
Gear3.TextSize = 11
Gear3.BackgroundTransparency = 1
Gear3.TextTransparency = 1
Gear3.ZIndex = 8
Gear3.Parent = SpeedContainer
Instance.new("UICorner", Gear3).CornerRadius = UDim.new(0, 6)
local G3Stroke = Instance.new("UIStroke", Gear3)
G3Stroke.Color = Color3.fromRGB(75, 55, 110)
G3Stroke.Transparency = 1

getgenv().AF_CoreUI = {
    ScreenGui = ScreenGui, ToggleButton = ToggleButton, MainMenu = MainMenu, 
    MenuStroke = MenuStroke, Title = Title, LineSeparator = LineSeparator,
    FlyToggleBtn = FlyToggleBtn, BtnToggleStroke = BtnToggleStroke,
    ArrowBtn = ArrowBtn, ArrowStroke = ArrowStroke, SpeedContainer = SpeedContainer, 
    SpeedTitle = SpeedTitle, Gear1 = Gear1, G1Stroke = G1Stroke, Gear2 = Gear2, 
    G2Stroke = G2Stroke, Gear3 = Gear3, G3Stroke = G3Stroke
}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local UI = getgenv().AF_CoreUI

local function makeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = obj.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    obj.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(UI.ToggleButton)
makeDraggable(UI.MainMenu)

local function addHover(btn, stroke, normalColor, hoverColor)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
        if stroke then TweenService:Create(stroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(200, 150, 255)}):Play() end
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = normalColor}):Play()
        if stroke then TweenService:Create(stroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(75, 55, 110)}):Play() end
    end)
end
addHover(UI.FlyToggleBtn, UI.BtnToggleStroke, Color3.fromRGB(24, 20, 32), Color3.fromRGB(42, 32, 58))
addHover(UI.ArrowBtn, UI.ArrowStroke, Color3.fromRGB(32, 26, 42), Color3.fromRGB(54, 42, 72))

local menuOpen = false
local arrowExpanded = false
local normalSize = UDim2.new(0, 280, 0, 100)
local expandedSize = UDim2.new(0, 280, 0, 170)
local currentTargetSize = normalSize

UI.ToggleButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    local targetTrans = menuOpen and 0 or 1
    local tInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    TweenService:Create(UI.MainMenu, tInfo, {BackgroundTransparency = menuOpen and 0 or 1, Size = menuOpen and currentTargetSize or UDim2.new(0, 280, 0, 0)}):Play()
    TweenService:Create(UI.MenuStroke, tInfo, {Transparency = targetTrans}):Play()
    TweenService:Create(UI.Title, tInfo, {TextTransparency = targetTrans}):Play()
    TweenService:Create(UI.LineSeparator, tInfo, {BackgroundTransparency = menuOpen and 0 or 1}):Play()
    TweenService:Create(UI.FlyToggleBtn, tInfo, {BackgroundTransparency = menuOpen and 0 or 1, TextTransparency = targetTrans}):Play()
    TweenService:Create(UI.ArrowBtn, tInfo, {BackgroundTransparency = menuOpen and 0 or 1, TextTransparency = targetTrans}):Play()
    TweenService:Create(UI.BtnToggleStroke, tInfo, {Transparency = targetTrans}):Play()
    TweenService:Create(UI.ArrowStroke, tInfo, {Transparency = targetTrans}):Play()
    
    if not menuOpen then
        UI.SpeedContainer.Visible = false
        TweenService:Create(UI.SpeedTitle, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
        TweenService:Create(UI.Gear1, TweenInfo.new(0.1), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(UI.Gear2, TweenInfo.new(0.1), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(UI.Gear3, TweenInfo.new(0.1), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(UI.G1Stroke, TweenInfo.new(0.1), {Transparency = 1}):Play()
        TweenService:Create(UI.G2Stroke, TweenInfo.new(0.1), {Transparency = 1}):Play()
        TweenService:Create(UI.G3Stroke, TweenInfo.new(0.1), {Transparency = 1}):Play()
    elseif currentTargetSize == expandedSize then
        UI.SpeedContainer.Visible = true
        TweenService:Create(UI.SpeedTitle, tInfo, {TextTransparency = 0}):Play()
        TweenService:Create(UI.Gear1, tInfo, {BackgroundTransparency = (getgenv().TreasureAutoFarm.SpeedTier == 1) and 0 or 0.5, TextTransparency = 0}):Play()
        TweenService:Create(UI.Gear2, tInfo, {BackgroundTransparency = (getgenv().TreasureAutoFarm.SpeedTier == 2) and 0 or 0.5, TextTransparency = 0}):Play()
        TweenService:Create(UI.Gear3, tInfo, {BackgroundTransparency = (getgenv().TreasureAutoFarm.SpeedTier == 3) and 0 or 0.5, TextTransparency = 0}):Play()
        TweenService:Create(UI.G1Stroke, tInfo, {Transparency = 0}):Play()
        TweenService:Create(UI.G2Stroke, tInfo, {Transparency = 0}):Play()
        TweenService:Create(UI.G3Stroke, tInfo, {Transparency = 0}):Play()
    end
end)

UI.ArrowBtn.MouseButton1Click:Connect(function()
    if not menuOpen then return end
    arrowExpanded = not arrowExpanded
    local tInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    if arrowExpanded then
        UI.ArrowBtn.Text = "❌"; currentTargetSize = expandedSize
        UI.MainMenu:TweenSize(expandedSize, "Out", "Quart", 0.25, true)
        UI.SpeedContainer.Visible = true
        TweenService:Create(UI.SpeedTitle, tInfo, {TextTransparency = 0}):Play()
        TweenService:Create(UI.Gear1, tInfo, {BackgroundTransparency = (getgenv().TreasureAutoFarm.SpeedTier == 1) and 0 or 0.5, TextTransparency = 0}):Play()
        TweenService:Create(UI.Gear2, tInfo, {BackgroundTransparency = (getgenv().TreasureAutoFarm.SpeedTier == 2) and 0 or 0.5, TextTransparency = 0}):Play()
        TweenService:Create(UI.Gear3, tInfo, {BackgroundTransparency = (getgenv().TreasureAutoFarm.SpeedTier == 3) and 0 or 0.5, TextTransparency = 0}):Play()
        TweenService:Create(UI.G1Stroke, tInfo, {Transparency = 0}):Play()
        TweenService:Create(UI.G2Stroke, tInfo, {Transparency = 0}):Play()
        TweenService:Create(UI.G3Stroke, tInfo, {Transparency = 0}):Play()
    else
        UI.ArrowBtn.Text = "⚙️"; currentTargetSize = normalSize
        UI.MainMenu:TweenSize(normalSize, "Out", "Quart", 0.25, true)
        TweenService:Create(UI.SpeedTitle, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
        TweenService:Create(UI.Gear1, TweenInfo.new(0.15), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(UI.Gear2, TweenInfo.new(0.15), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(UI.Gear3, TweenInfo.new(0.15), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(UI.G1Stroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
        TweenService:Create(UI.G2Stroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
        TweenService:Create(UI.G3Stroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
        task.delay(0.2, function() if not arrowExpanded then UI.SpeedContainer.Visible = false end end)
    end
end)

local function updateGearsVisual(selected)
    getgenv().TreasureAutoFarm.SpeedTier = selected
    TweenService:Create(UI.Gear1, TweenInfo.new(0.15), {BackgroundColor3 = (selected == 1) and Color3.fromRGB(140, 75, 255) or Color3.fromRGB(24, 20, 32)}):Play()
    TweenService:Create(UI.G1Stroke, TweenInfo.new(0.15), {Color = (selected == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(75, 55, 110)}):Play()
    
    TweenService:Create(UI.Gear2, TweenInfo.new(0.15), {BackgroundColor3 = (selected == 2) and Color3.fromRGB(140, 75, 255) or Color3.fromRGB(24, 20, 32)}):Play()
    TweenService:Create(UI.G2Stroke, TweenInfo.new(0.15), {Color = (selected == 2) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(75, 55, 110)}):Play()
    
    TweenService:Create(UI.Gear3, TweenInfo.new(0.15), {BackgroundColor3 = (selected == 3) and Color3.fromRGB(140, 75, 255) or Color3.fromRGB(24, 20, 32)}):Play()
    TweenService:Create(UI.G3Stroke, TweenInfo.new(0.15), {Color = (selected == 3) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(75, 55, 110)}):Play()
end

UI.Gear1.MouseButton1Click:Connect(function() updateGearsVisual(1) end)
UI.Gear2.MouseButton1Click:Connect(function() updateGearsVisual(2) end)
UI.Gear3.MouseButton1Click:Connect(function() updateGearsVisual(3) end)

UI.FlyToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "Fly-TP" then 
        getgenv().TreasureAutoFarm.Mode = "None"
        UI.FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(24, 20, 32)
        UI.FlyToggleBtn.Text = "🚀 LAUNCH FLY-TP"
        TweenService:Create(UI.BtnToggleStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(75, 55, 110)}):Play()
    else 
        getgenv().TreasureAutoFarm.Mode = "Fly-TP"
        UI.FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(140, 75, 255)
        UI.FlyToggleBtn.Text = "⚡ FLY-TP: ACTIVE" 
        TweenService:Create(UI.BtnToggleStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 255, 255)}):Play()
    end
end)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    for _, v in pairs(getconnections(LocalPlayer.Idled)) do v:Disable() end
end)

-- АНТИ-ФИЗИЧЕСКИЙ NOCLIP + ПОЛНАЯ БЛОКИРОВКА ЭФФЕКТОВ ВОДЫ
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "Fly-TP" and LocalPlayer.Character then
        local char = LocalPlayer.Character
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false
                part.AssemblyLinearVelocity = Vector3.new(0,0,0)   
                part.AssemblyAngularVelocity = Vector3.new(0,0,0)  
            elseif part:IsA("TouchTransmitter") and part.Parent and (part.Parent.Name == "Water" or part.Parent.Name == "WaterPart") then
                part:Destroy()
            end
        end
    end
end)

-- Двухрежимная функция перемещения Fly-TP с оптимизированным таймингом
local function hybridMoveTo(targetPos, stageIndex)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local tier = getgenv().TreasureAutoFarm.SpeedTier or 2
    local currentSpeed = 750
    local fixTime = 0.65
    local calculatedY = 85
    
    -- НАСТРОЕННЫЕ ТАЙМИНГИ УДЕРЖАНИЯ (С ФИКСОМ ДЛЯ 3-Й ПЕРЕДАЧИ):
    if tier == 1 then
        currentSpeed = 350
        fixTime = 1.10          -- Безопасная микро-пауза (1.1 сек)
        calculatedY = 85         
    elseif tier == 2 then
        currentSpeed = 750
        fixTime = 0.65          -- Оптимальный баланс (0.65 сек)
        calculatedY = 85
    elseif tier == 3 then
        currentSpeed = 1400
        fixTime = 0.50          -- Ровно 0.50 секунды для Gear 3
        calculatedY = 52         -- Уходим в безопасный тоннель над водой
    end

    local dynamicTarget = Vector3.new(targetPos.X, calculatedY, targetPos.Z)

    -- Полет CFrame вектором
    while getgenv().TreasureAutoFarm.Mode == "Fly-TP" and (hrp.Position - dynamicTarget).Magnitude > 15 do
        if not LocalPlayer.Character or not hrp.Parent then break end
        local dir = (dynamicTarget - hrp.Position).Unit
        local step = currentSpeed * RunService.Heartbeat:Wait()
        if step > (dynamicTarget - hrp.Position).Magnitude then step = (dynamicTarget - hrp.Position).Magnitude end
        hrp.CFrame = CFrame.new(hrp.Position + dir * step, dynamicTarget)
    end
    
    if hrp and getgenv().TreasureAutoFarm.Mode == "Fly-TP" then 
        hrp.CFrame = CFrame.new(dynamicTarget)
        hrp.Anchored = true -- Фиксируем торс ровно на указанное время
        
        if stageIndex then
            pcall(function()
                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                local stage = normalStages and normalStages:FindFirstChild("CaveStage" .. stageIndex)
                local darkness = stage and stage:FindFirstChild("DarknessPart")
                
                if not darkness and normalStages then
                    darkness = normalStages:WaitForChild("CaveStage" .. stageIndex, 2):WaitForChild("DarknessPart", 2)
                end
                
                if darkness then
                    -- Пакетный спам тачей для пробития лагов
                    local loops = (tier == 3) and 25 or 12
                    for i = 1, loops do
                        firetouchinterest(hrp, darkness, 0)
                        firetouchinterest(hrp, darkness, 1)
                    end
                end
            end)
            task.wait(fixTime) -- Таймер (0.50 сек для Gear 3)
        end
        hrp.Anchored = false
    end
end

task.spawn(function()
    while true do
        task.wait(0.3)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if getgenv().TreasureAutoFarm.Mode == "Fly-TP" and hrp and hum and hum.Health > 0 then
            pcall(function()
                local normalStages = Workspace:WaitForChild("BoatStages", 10):WaitForChild("NormalStages", 10)
                
                local tier = getgenv().TreasureAutoFarm.SpeedTier or 2
                local startY = (tier == 3) and 52 or 85
                
                local startPos = Vector3.new(-50, startY, -1025)
                local st1 = normalStages:FindFirstChild("CaveStage1")
                if st1 and st1:FindFirstChild("DarknessPart") then 
                    startPos = Vector3.new(st1.DarknessPart.Position.X, startY, st1.DarknessPart.Position.Z) 
                    pcall(function() 
                        firetouchinterest(hrp, st1.DarknessPart, 0) 
                        firetouchinterest(hrp, st1.DarknessPart, 1)
                    end)
                end
                hrp.CFrame = CFrame.new(startPos)
                task.wait(0.3)

                -- Линейный проход стадий 2 - 10
                for i = 2, 10 do
                    if getgenv().TreasureAutoFarm.Mode ~= "Fly-TP" then break end
                    
                    local stage = normalStages:FindFirstChild("CaveStage" .. i)
                    local stagePos
                    
                    if stage and stage:FindFirstChild("DarknessPart") then 
                        stagePos = stage.DarknessPart.Position
                    else
                        stagePos = Vector3.new(-50, 85, -1025 + (i * -775))
                    end
                    
                    hybridMoveTo(stagePos, i)
                    
                    -- Быстрые зигзаги для 1 и 2 передач
                    if tier < 3 and (i == 3 or i == 6 or i == 9 or i == 10) then
                        hybridMoveTo(Vector3.new(stagePos.X + 18, 85, stagePos.Z), false)
                        hybridMoveTo(Vector3.new(stagePos.X - 18, 85, stagePos.Z), false)
                        hybridMoveTo(Vector3.new(stagePos.X, 85, stagePos.Z), i)
                    end
                end
                
                -- Влёт в сундук
                if getgenv().TreasureAutoFarm.Mode == "Fly-TP" and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    local trigger = chest and chest:FindFirstChild("Trigger")
                    if trigger then 
                        hrp.CFrame = CFrame.new(trigger.Position) 
                        pcall(function() 
                            for i = 1, 15 do
                                firetouchinterest(hrp, trigger, 0) 
                                firetouchinterest(hrp, trigger, 1)
                            end
                        end)
                    else 
                        hrp.CFrame = CFrame.new(-50, -15, -9200) 
                    end
                    task.wait(getgenv().TreasureAutoFarm.WaitAtChest)
                end

                -- Сброс персонажа для нового круга
                if getgenv().TreasureAutoFarm.Mode == "Fly-TP" then
                    local respawned = false
                    local conn = LocalPlayer.CharacterAdded:Connect(function() respawned = true end)
                    if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").Health = 0 end
                    repeat task.wait(0.05) until respawned
                    conn:Disconnect()
                end
            end)
        end
    end
end)
