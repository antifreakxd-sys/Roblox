getgenv().TreasureAutoFarm = {
    Mode = "None",         -- "Fly" или "None"
    FlySpeed = 220,        -- От 220 до 1500
    WaitAtChest = 3      
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiFreak_V25_Final"
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
BtnStroke.Color = Color3.fromRGB(160, 90, 255)
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
FlyToggleBtn.Text = "🚀 LAUNCH FARM"
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

local SliderContainer = Instance.new("Frame")
SliderContainer.Size = UDim2.new(1, -40, 0, 55)
SliderContainer.Position = UDim2.new(0, 20, 0, 105)
SliderContainer.BackgroundTransparency = 1
SliderContainer.Visible = false
SliderContainer.ZIndex = 6
SliderContainer.Parent = MainMenu

local SliderText = Instance.new("TextLabel")
SliderText.Size = UDim2.new(1, 0, 0, 20)
SliderText.BackgroundTransparency = 1
SliderText.Text = "⚡ SPEED: 220"
SliderText.TextColor3 = Color3.fromRGB(190, 180, 210)
SliderText.TextSize = 11
SliderText.Font = Enum.Font.GothamBold
SliderText.TextXAlignment = Enum.TextXAlignment.Left
SliderText.TextTransparency = 1
SliderText.ZIndex = 7
SliderText.Parent = SliderContainer

local SliderFrame = Instance.new("Frame")
SliderFrame.Size = UDim2.new(1, 0, 0, 6)
SliderFrame.Position = UDim2.new(0, 0, 0, 28)
SliderFrame.BackgroundColor3 = Color3.fromRGB(24, 20, 32)
SliderFrame.BackgroundTransparency = 1
SliderFrame.ZIndex = 7
SliderFrame.Parent = SliderContainer
Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 4)
local SliderFrameStroke = Instance.new("UIStroke", SliderFrame)
SliderFrameStroke.Color = Color3.fromRGB(55, 45, 75)
SliderFrameStroke.Thickness = 1
SliderFrameStroke.Transparency = 1

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(160, 90, 255)
SliderFill.BackgroundTransparency = 1
SliderFill.ZIndex = 7
SliderFill.Parent = SliderFrame
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 4)

local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(0, 16, 0, 16)
SliderButton.Position = UDim2.new(0, -8, -0.7, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(200, 160, 255)
SliderButton.Text = ""
SliderButton.BackgroundTransparency = 1
SliderButton.ZIndex = 8
SliderButton.Parent = SliderFrame
Instance.new("UICorner", SliderButton).CornerRadius = UDim.new(1, 0)
local SliderBtnStroke = Instance.new("UIStroke", SliderButton)
SliderBtnStroke.Color = Color3.fromRGB(255, 255, 255)
SliderBtnStroke.Thickness = 1.5
SliderBtnStroke.Transparency = 1

getgenv().AF_CoreUI = {
    ScreenGui = ScreenGui, ToggleButton = ToggleButton, MainMenu = MainMenu, 
    MenuStroke = MenuStroke, Title = Title, LineSeparator = LineSeparator,
    FlyToggleBtn = FlyToggleBtn, BtnToggleStroke = BtnToggleStroke,
    ArrowBtn = ArrowBtn, ArrowStroke = ArrowStroke, SliderContainer = SliderContainer, 
    SliderText = SliderText, SliderFrame = SliderFrame, SliderFrameStroke = SliderFrameStroke,
    SliderFill = SliderFill, SliderButton = SliderButton, SliderBtnStroke = SliderBtnStroke
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
        UI.SliderContainer.Visible = false
        TweenService:Create(UI.SliderText, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
        TweenService:Create(UI.SliderFrame, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
        TweenService:Create(UI.SliderButton, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
        TweenService:Create(UI.SliderFrameStroke, TweenInfo.new(0.1), {Transparency = 1}):Play()
        TweenService:Create(UI.SliderBtnStroke, TweenInfo.new(0.1), {Transparency = 1}):Play()
        TweenService:Create(UI.SliderFill, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
    elseif currentTargetSize == expandedSize then
        UI.SliderContainer.Visible = true
        TweenService:Create(UI.SliderText, tInfo, {TextTransparency = 0}):Play()
        TweenService:Create(UI.SliderFrame, tInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(UI.SliderButton, tInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(UI.SliderFrameStroke, tInfo, {Transparency = 0}):Play()
        TweenService:Create(UI.SliderBtnStroke, tInfo, {Transparency = 0}):Play()
        TweenService:Create(UI.SliderFill, tInfo, {BackgroundTransparency = 0}):Play()
    end
end)

UI.ArrowBtn.MouseButton1Click:Connect(function()
    if not menuOpen then return end
    arrowExpanded = not arrowExpanded
    local tInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    if arrowExpanded then
        UI.ArrowBtn.Text = "❌"; currentTargetSize = expandedSize
        UI.MainMenu:TweenSize(expandedSize, "Out", "Quart", 0.25, true)
        UI.SliderContainer.Visible = true
        TweenService:Create(UI.SliderText, tInfo, {TextTransparency = 0}):Play()
        TweenService:Create(UI.SliderFrame, tInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(UI.SliderButton, tInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(UI.SliderFrameStroke, tInfo, {Transparency = 0}):Play()
        TweenService:Create(UI.SliderBtnStroke, tInfo, {Transparency = 0}):Play()
        TweenService:Create(UI.SliderFill, tInfo, {BackgroundTransparency = 0}):Play()
    else
        UI.ArrowBtn.Text = "⚙️"; currentTargetSize = normalSize
        UI.MainMenu:TweenSize(normalSize, "Out", "Quart", 0.25, true)
        TweenService:Create(UI.SliderText, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
        TweenService:Create(UI.SliderFrame, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        TweenService:Create(UI.SliderButton, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        TweenService:Create(UI.SliderFrameStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
        TweenService:Create(UI.SliderBtnStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
        TweenService:Create(UI.SliderFill, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        task.delay(0.2, function() if not arrowExpanded then UI.SliderContainer.Visible = false end end)
    end
end)

local minSpeed, maxSpeed = 220, 1500
local isSliding = false
local function updateSlider(input)
    local sliderWidth = UI.SliderFrame.AbsoluteSize.X
    local mouseX = input.Position.X - UI.SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(mouseX / sliderWidth, 0, 1)
    
    UI.SliderButton.Position = UDim2.new(percentage, -8, -0.7, 0)
    UI.SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
    
    local finalSpeed = math.floor(minSpeed + (percentage * (maxSpeed - minSpeed)))
    getgenv().TreasureAutoFarm.FlySpeed = finalSpeed
    UI.SliderText.Text = "⚡ SPEED: " .. tostring(finalSpeed)
end
UI.SliderButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = true end end)
UserInputService.InputChanged:Connect(function(input) if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = false end end)

UI.FlyToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "Fly" then 
        getgenv().TreasureAutoFarm.Mode = "None"
        UI.FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(24, 20, 32)
        UI.FlyToggleBtn.Text = "🚀 LAUNCH FARM"
        TweenService:Create(UI.BtnToggleStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(75, 55, 110)}):Play()
    else 
        getgenv().TreasureAutoFarm.Mode = "Fly"
        UI.FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(140, 75, 255)
        UI.FlyToggleBtn.Text = "⚡ FARM: ACTIVE" 
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

-- ТОТАЛЬНЫЙ CFRAME NOCLIP И ОБНУЛЕНИЕ ФИЗИКИ (Полная блокировка античита и инерции)
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "Fly" and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false
                part.AssemblyLinearVelocity = Vector3.new(0,0,0)   
                part.AssemblyAngularVelocity = Vector3.new(0,0,0)  
            end
        end
    end
end)

-- ФУНКЦИЯ ПЕРЕМЕЩЕНИЯ В КОСМОСЕ (Защита от воды и вылетов)
local function safeFarmTo(targetPos, stageIndex)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Поднимаем координату цели высоко в небо (Y = 650) подальше от ебучей воды
    local spaceTarget = Vector3.new(targetPos.X, 650, targetPos.Z)

    while getgenv().TreasureAutoFarm.Mode == "Fly" and (hrp.Position - spaceTarget).Magnitude > 15 do
        if not LocalPlayer.Character or not hrp.Parent then break end
        local dir = (spaceTarget - hrp.Position).Unit
        local step = getgenv().TreasureAutoFarm.FlySpeed * RunService.Heartbeat:Wait()
        if step > (spaceTarget - hrp.Position).Magnitude then step = (spaceTarget - hrp.Position).Magnitude end
        
        -- Движение чистым CFrame в пустом небе
        hrp.CFrame = CFrame.new(hrp.Position + dir * step, spaceTarget)
    end
    
    if hrp and getgenv().TreasureAutoFarm.Mode == "Fly" then 
        hrp.CFrame = CFrame.new(spaceTarget)
        hrp.Anchored = true -- Фиксируем тело в небе
        
        -- Дистанционный зачет стадии с высоты через пакеты
        if stageIndex then
            pcall(function()
                local darkness = Workspace.BoatStages.NormalStages["CaveStage" .. tostring(stageIndex)]:FindFirstChild("DarknessPart")
                if darkness then
                    for i = 1, 15 do -- Спамим пакеты для 100% зачета на скорости 1500
                        firetouchinterest(hrp, darkness, 0)
                        firetouchinterest(hrp, darkness, 1)
                    end
                end
            end)
            
            -- Небольшое удержание на сверхскорости, чтобы сервер успел выдать золото
            local fixTime = (getgenv().TreasureAutoFarm.FlySpeed >= 1200) and 0.45 or 0.2
            task.wait(fixTime)
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
        
        -- Ждем полной прогрузки персонажа после респавна
        if getgenv().TreasureAutoFarm.Mode == "Fly" and hrp and hum and hum.Health > 0 then
            pcall(function()
                local normalStages = Workspace:WaitForChild("BoatStages", 10):WaitForChild("NormalStages", 10)
                
                -- Мгновенно улетаем в стратосферу подальше от спавна и воды
                hrp.CFrame = CFrame.new(-50, 650, -1025)
                task.wait(0.3)

                -- Безопасный полет по небу над стадиями 1 - 10
                for i = 1, 10 do
                    if getgenv().TreasureAutoFarm.Mode ~= "Fly" then break end
                    
                    local stage = normalStages:FindFirstChild("CaveStage" .. i)
                    local stagePos
                    
                    if stage and stage:FindFirstChild("DarknessPart") then 
                        stagePos = stage.DarknessPart.Position
                    else
                        stagePos = Vector3.new(-50, 85, -1025 + (i * -775))
                    end
                    
                    safeFarmTo(stagePos, i)
                end
                
                -- Пикируем прямо на Золотой Сундук только в самом конце пути
                if getgenv().TreasureAutoFarm.Mode == "Fly" and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    local trigger = chest and chest:FindFirstChild("Trigger")
                    if trigger then 
                        hrp.CFrame = CFrame.new(trigger.Position) 
                        pcall(function() 
                            for i = 1, 10 do
                                firetouchinterest(hrp, trigger, 0) 
                                firetouchinterest(hrp, trigger, 1)
                            end
                        end)
                    else 
                        hrp.CFrame = CFrame.new(-50, -15, -9200) 
                    end
                    task.wait(getgenv().TreasureAutoFarm.WaitAtChest)
                end

                -- Безопасный ресет для перезапуска бесконечного цикла
                if getgenv().TreasureAutoFarm.Mode == "Fly" then
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
