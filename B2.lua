getgenv().TreasureAutoFarm = {
    Mode = "None",         -- "Fly", "TP", "AFK" или "None"
    FlySpeed = 220,        -- От 220 до 1500
    WaitAtChest = 3        
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiFreak_V17_Core"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
ToggleButton.Text = "⚙️"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 26
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
local BtnStroke = Instance.new("UIStroke", ToggleButton)
BtnStroke.Color = Color3.fromRGB(140, 80, 255)
BtnStroke.Thickness = 2

local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Size = UDim2.new(0, 280, 0, 145) 
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainMenu.ClipsDescendants = true
MainMenu.BackgroundTransparency = 1 
MainMenu.ZIndex = 5
MainMenu.Parent = ScreenGui
Instance.new("UICorner", MainMenu).CornerRadius = UDim.new(0, 14)
local MenuStroke = Instance.new("UIStroke", MainMenu)
MenuStroke.Color = Color3.fromRGB(45, 45, 50)
MenuStroke.Thickness = 1

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "by @AntiFreakXD"
Title.TextColor3 = Color3.fromRGB(160, 100, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextTransparency = 1
Title.ZIndex = 6
Title.Parent = MainMenu

local FlyFrame = Instance.new("Frame")
FlyFrame.Size = UDim2.new(0, 115, 0, 45)
FlyFrame.Position = UDim2.new(0, 20, 0, 45)
FlyFrame.BackgroundTransparency = 1
FlyFrame.ZIndex = 6
FlyFrame.Parent = MainMenu

local FlyToggleBtn = Instance.new("TextButton")
FlyToggleBtn.Size = UDim2.new(0, 85, 1, 0)
FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
FlyToggleBtn.Text = "Fly Farm"
FlyToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToggleBtn.TextSize = 11
FlyToggleBtn.Font = Enum.Font.GothamSemibold
FlyToggleBtn.BackgroundTransparency = 1
FlyToggleBtn.TextTransparency = 1
FlyToggleBtn.ZIndex = 7
FlyToggleBtn.Parent = FlyFrame
Instance.new("UICorner", FlyToggleBtn).CornerRadius = UDim.new(0, 6)

local ArrowBtn = Instance.new("TextButton")
ArrowBtn.Size = UDim2.new(0, 25, 1, 0)
ArrowBtn.Position = UDim2.new(0, 90, 0, 0)
ArrowBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ArrowBtn.Text = "▶"
ArrowBtn.TextColor3 = Color3.fromRGB(160, 100, 255)
ArrowBtn.TextSize = 11
ArrowBtn.Font = Enum.Font.GothamBold
ArrowBtn.BackgroundTransparency = 1
ArrowBtn.TextTransparency = 1
ArrowBtn.ZIndex = 7
ArrowBtn.Parent = FlyFrame
Instance.new("UICorner", ArrowBtn).CornerRadius = UDim.new(0, 6)

local TpToggleBtn = Instance.new("TextButton")
TpToggleBtn.Size = UDim2.new(0, 115, 0, 45)
TpToggleBtn.Position = UDim2.new(0, 145, 0, 45)
TpToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TpToggleBtn.Text = "TP Farm: OFF"
TpToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpToggleBtn.TextSize = 11
TpToggleBtn.Font = Enum.Font.GothamSemibold
TpToggleBtn.BackgroundTransparency = 1
TpToggleBtn.TextTransparency = 1
TpToggleBtn.ZIndex = 7
TpToggleBtn.Parent = MainMenu
Instance.new("UICorner", TpToggleBtn).CornerRadius = UDim.new(0, 6)

local AfkToggleBtn = Instance.new("TextButton")
AfkToggleBtn.Size = UDim2.new(0, 240, 0, 35)
AfkToggleBtn.Position = UDim2.new(0, 20, 0, 95)
AfkToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
AfkToggleBtn.Text = "AFK Farm: OFF"
AfkToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AfkToggleBtn.TextSize = 11
AfkToggleBtn.Font = Enum.Font.GothamSemibold
AfkToggleBtn.BackgroundTransparency = 1
AfkToggleBtn.TextTransparency = 1
AfkToggleBtn.ZIndex = 7
AfkToggleBtn.Parent = MainMenu
Instance.new("UICorner", AfkToggleBtn).CornerRadius = UDim.new(0, 6)

local SliderContainer = Instance.new("Frame")
SliderContainer.Size = UDim2.new(1, -40, 0, 50)
SliderContainer.Position = UDim2.new(0, 20, 0, 140)
SliderContainer.BackgroundTransparency = 1
SliderContainer.Visible = false
SliderContainer.ZIndex = 6
SliderContainer.Parent = MainMenu

local SliderText = Instance.new("TextLabel")
SliderText.Size = UDim2.new(1, 0, 0, 20)
SliderText.BackgroundTransparency = 1
SliderText.Text = "Speed: 220"
SliderText.TextColor3 = Color3.fromRGB(180, 180, 185)
SliderText.TextSize = 12
SliderText.Font = Enum.Font.GothamSemibold
SliderText.TextXAlignment = Enum.TextXAlignment.Left
SliderText.TextTransparency = 1
SliderText.ZIndex = 7
SliderText.Parent = SliderContainer

local SliderFrame = Instance.new("Frame")
SliderFrame.Size = UDim2.new(1, 0, 0, 8)
SliderFrame.Position = UDim2.new(0, 0, 0, 25)
SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
SliderFrame.BackgroundTransparency = 1
SliderFrame.ZIndex = 7
SliderFrame.Parent = SliderContainer
Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 4)

local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(0, 18, 0, 18)
SliderButton.Position = UDim2.new(0, -9, -0.5, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
SliderButton.Text = ""
SliderButton.BackgroundTransparency = 1
SliderButton.ZIndex = 8
SliderButton.Parent = SliderFrame
Instance.new("UICorner", SliderButton).CornerRadius = UDim.new(1, 0)

getgenv().AF_CoreUI = {
    ScreenGui = ScreenGui, ToggleButton = ToggleButton, MainMenu = MainMenu, 
    MenuStroke = MenuStroke, Title = Title, FlyToggleBtn = FlyToggleBtn, 
    ArrowBtn = ArrowBtn, TpToggleBtn = TpToggleBtn, AfkToggleBtn = AfkToggleBtn,
    SliderContainer = SliderContainer, SliderText = SliderText, 
    SliderFrame = SliderFrame, SliderButton = SliderButton
}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local UI = getgenv().AF_CoreUI

if not UI then return warn("Ошибка: Запусти сначала Часть 1!") end

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

local menuOpen = false
local arrowExpanded = false
local normalSize = UDim2.new(0, 280, 0, 145)
local expandedSize = UDim2.new(0, 280, 0, 200)
local currentTargetSize = normalSize

UI.ToggleButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    local targetTrans = menuOpen and 0 or 1
    TweenService:Create(UI.MainMenu, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, Size = menuOpen and currentTargetSize or UDim2.new(0, 280, 0, 0)}):Play()
    TweenService:Create(UI.MenuStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {Transparency = targetTrans}):Play()
    TweenService:Create(UI.Title, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {TextTransparency = targetTrans}):Play()
    TweenService:Create(UI.FlyToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    TweenService:Create(UI.ArrowBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    TweenService:Create(UI.TpToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    TweenService:Create(UI.AfkToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    
    if not menuOpen then
        UI.SliderContainer.Visible = false
        TweenService:Create(UI.SliderText, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
        TweenService:Create(UI.SliderFrame, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
        TweenService:Create(UI.SliderButton, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
    elseif currentTargetSize == expandedSize then
        UI.SliderContainer.Visible = true
        TweenService:Create(UI.SliderText, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        TweenService:Create(UI.SliderFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
        TweenService:Create(UI.SliderButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end
end)

UI.ArrowBtn.MouseButton1Click:Connect(function()
    if not menuOpen then return end
    arrowExpanded = not arrowExpanded
    if arrowExpanded then
        UI.ArrowBtn.Text = "▼"; currentTargetSize = expandedSize
        UI.MainMenu:TweenSize(expandedSize, "Out", "Quart", 0.2, true)
        UI.SliderContainer.Visible = true
        TweenService:Create(UI.SliderText, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        TweenService:Create(UI.SliderFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
        TweenService:Create(UI.SliderButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    else
        UI.ArrowBtn.Text = "▶"; currentTargetSize = normalSize
        UI.MainMenu:TweenSize(normalSize, "Out", "Quart", 0.2, true)
        TweenService:Create(UI.SliderText, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
        TweenService:Create(UI.SliderFrame, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        TweenService:Create(UI.SliderButton, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        task.delay(0.15, function() if not arrowExpanded then UI.SliderContainer.Visible = false end end)
    end
end)

local minSpeed, maxSpeed = 220, 1500
local isSliding = false
local function updateSlider(input)
    local sliderWidth = UI.SliderFrame.AbsoluteSize.X
    local mouseX = input.Position.X - UI.SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(mouseX / sliderWidth, 0, 1)
    UI.SliderButton.Position = UDim2.new(percentage, -9, -0.5, 0)
    local finalSpeed = math.floor(minSpeed + (percentage * (maxSpeed - minSpeed)))
    getgenv().TreasureAutoFarm.FlySpeed = finalSpeed
    UI.SliderText.Text = "Speed: " .. tostring(finalSpeed)
end
UI.SliderButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = true end end)
UserInputService.InputChanged:Connect(function(input) if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = false end end)

local function resetButtons()
    UI.FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    UI.TpToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    UI.AfkToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    UI.TpToggleBtn.Text = "TP Farm: OFF"
    UI.AfkToggleBtn.Text = "AFK Farm: OFF"
end

UI.FlyToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "Fly" then getgenv().TreasureAutoFarm.Mode = "None"; resetButtons()
    else getgenv().TreasureAutoFarm.Mode = "Fly"; resetButtons(); UI.FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 190, 110) end
end)
UI.TpToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "TP" then getgenv().TreasureAutoFarm.Mode = "None"; resetButtons()
    else getgenv().TreasureAutoFarm.Mode = "TP"; resetButtons(); UI.TpToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 255); UI.TpToggleBtn.Text = "TP Farm: ON" end
end)
UI.AfkToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "AFK" then getgenv().TreasureAutoFarm.Mode = "None"; resetButtons()
    else getgenv().TreasureAutoFarm.Mode = "AFK"; resetButtons(); UI.AfkToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 80); UI.AfkToggleBtn.Text = "AFK Farm: ON" end
end)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    for _, v in pairs(getconnections(LocalPlayer.Idled)) do v:Disable() end
end)

-- УМНЫЙ NOCLIP: Стены не трогают нас, но датчики касания (TouchTransmitter) работают на 100%
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Mode ~= "None" and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false
                part.AssemblyLinearVelocity = Vector3.new(0,0,0)   
                part.AssemblyAngularVelocity = Vector3.new(0,0,0)  
            end
            -- ВАЖНО: Мы вообще не трогаем датчики касания персонажа, чтобы сервер видел хитбоксы стадий!
        end
    end
end)

-- Функция плавного полета (Fly) с жесткой фиксацией и отправкой пакета касания стадии
local function safeFlyTo(targetPos, stageIndex)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    while getgenv().TreasureAutoFarm.Mode == "Fly" and (hrp.Position - targetPos).Magnitude > 15 do
        if not LocalPlayer.Character or not hrp.Parent then break end
        local dir = (targetPos - hrp.Position).Unit
        local step = getgenv().TreasureAutoFarm.FlySpeed * RunService.Heartbeat:Wait()
        if step > (targetPos - hrp.Position).Magnitude then step = (targetPos - hrp.Position).Magnitude end
        hrp.CFrame = CFrame.new(hrp.Position + dir * step, targetPos)
    end
    
    if hrp and getgenv().TreasureAutoFarm.Mode == "Fly" then 
        hrp.CFrame = CFrame.new(targetPos)
        hrp.Anchored = true
        
        -- Если летим по стадиям — жестко скармливаем серверу ивент касания чекпоинта
        if stageIndex then
            pcall(function()
                local darkness = Workspace.BoatStages.NormalStages["CaveStage" .. tostring(stageIndex)]:FindFirstChild("DarknessPart")
                if darkness then
                    firetouchinterest(hrp, darkness, 0) -- Начало касания
                    firetouchinterest(hrp, darkness, 1) -- Конец касания
                end
            end)
        end
        
        -- Небольшая фиксация в зависимости от выкрученной скорости (для 1500 скорости — 0.4 сек)
        local anchorTime = (getgenv().TreasureAutoFarm.FlySpeed >= 1200) and 0.4 or 0.2
        task.wait(anchorTime)
        hrp.Anchored = false
    end
end

-- Функция ступенчатого телепорта (TP) с обходом StreamingEnabled и триггерами голды
local function safeTPTo(targetPos, stageIndex)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local currentPos = hrp.Position
    local distance = (targetPos - currentPos).Magnitude
    local steps = math.ceil(distance / 85) -- Отрезки по 85 единиц для идеального прогруза карты
    
    for i = 1, steps do
        if getgenv().TreasureAutoFarm.Mode ~= "TP" then break end
        local nextPos = currentPos:Lerp(targetPos, i / steps)
        hrp.CFrame = CFrame.new(nextPos)
        RunService.Heartbeat:Wait()
    end
    
    if hrp and getgenv().TreasureAutoFarm.Mode == "TP" then
        hrp.CFrame = CFrame.new(targetPos)
        hrp.Anchored = true
        
        -- Эмулируем касание стадии при телепортации
        if stageIndex then
            pcall(function()
                local darkness = Workspace.BoatStages.NormalStages["CaveStage" .. tostring(stageIndex)]:FindFirstChild("DarknessPart")
                if darkness then
                    firetouchinterest(hrp, darkness, 0)
                    firetouchinterest(hrp, darkness, 1)
                end
            end)
        end
        
        task.wait(0.35)
        hrp.Anchored = false
    end
end

-- Главное ядро управления циклами фарминга
task.spawn(function()
    while true do
        task.wait(0.4)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if getgenv().TreasureAutoFarm.Mode ~= "None" and hrp then
            pcall(function()
                local normalStages = Workspace:WaitForChild("BoatStages", 10):WaitForChild("NormalStages", 10)
                
                -- РЕЖИМЫ 1 И 2: НАШ НАДЕЖНЫЙ FLY / TP С КОРРЕКТНЫМИ ХИТБОКСАМИ
                if getgenv().TreasureAutoFarm.Mode == "Fly" or getgenv().TreasureAutoFarm.Mode == "TP" then
                    -- Старт первой стадии
                    local fPos = Vector3.new(-50, 85, -1025)
                    local st1 = normalStages:FindFirstChild("CaveStage1")
                    if st1 and st1:FindFirstChild("DarknessPart") then 
                        fPos = Vector3.new(st1.DarknessPart.Position.X, 85, st1.DarknessPart.Position.Z) 
                        pcall(function() 
                            firetouchinterest(hrp, st1.DarknessPart, 0) 
                            firetouchinterest(hrp, st1.DarknessPart, 1)
                        end)
                    end
                    hrp.CFrame = CFrame.new(fPos)
                    task.wait(0.4)

                    -- Основной проход стадий со 2 по 10
                    for i = 2, 10 do
                        if getgenv().TreasureAutoFarm.Mode == "None" or getgenv().TreasureAutoFarm.Mode == "AFK" then break end
                        local centerPos = Vector3.new(-50, 85, -1025 + (i * -775))
                        local stage = normalStages:FindFirstChild("CaveStage" .. i)
                        if stage and stage:FindFirstChild("DarknessPart") then centerPos = Vector3.new(stage.DarknessPart.Position.X, 85, stage.DarknessPart.Position.Z) end
                        
                        if getgenv().TreasureAutoFarm.Mode == "Fly" then
                            safeFlyTo(centerPos, i)
                            if i == 3 or i == 6 or i == 9 or i == 10 then
                                -- Дополнительный микро-зигзаг для проверки хитбоксов сервером
                                safeFlyTo(centerPos + Vector3.new(20, 0, 0), false)
                                safeFlyTo(centerPos - Vector3.new(20, 0, 0), false)
                                safeFlyTo(centerPos, i)
                            else
                                task.wait(0.15)
                            end
                        elseif getgenv().TreasureAutoFarm.Mode == "TP" then
                            safeTPTo(centerPos, i)
                        end
                    end
                    
                    -- Телепорт к золотому сундуку в финал
                    if getgenv().TreasureAutoFarm.Mode ~= "None" and normalStages:FindFirstChild("TheEnd") then
                        local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                        local trigger = chest and chest:FindFirstChild("Trigger")
                        if trigger then 
                            hrp.CFrame = CFrame.new(trigger.Position) 
                            pcall(function() 
                                firetouchinterest(hrp, trigger, 0) 
                                firetouchinterest(hrp, trigger, 1)
                            end)
                        else 
                            hrp.CFrame = CFrame.new(-50, -15, -9200) 
                        end
                        task.wait(getgenv().TreasureAutoFarm.WaitAtChest)
                    end

                    -- Моментальный ресет для перезапуска бесконечного цикла фарма
                    if getgenv().TreasureAutoFarm.Mode ~= "None" then
                        local respawned = false
                        local conn = LocalPlayer.CharacterAdded:Connect(function() respawned = true end)
                        if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").Health = 0 end
                        repeat task.wait(0.05) until respawned
                        conn:Disconnect()
                    end

                -- РЕЖИМ 3: ТОТ САМЫЙ АФК-ГЛИТЧ В КУСТАХ ПОД ПЕРВОЙ ЗОНОЙ
                elseif getgenv().TreasureAutoFarm.Mode == "AFK" then
                    -- Ставим персонажа прямо за текстуру водопада/кустов у спавна лодок
                    hrp.CFrame = CFrame.new(-55, -9, -360)
                    
                    local afkPlate = Workspace:FindFirstChild("AntiFreak_GoldGlitchPlate")
                    if not afkPlate then
                        afkPlate = Instance.new("Part", Workspace)
                        afkPlate.Name = "AntiFreak_GoldGlitchPlate"
                        afkPlate.Size = Vector3.new(15, 2, 15)
                        afkPlate.Anchored = true
                        afkPlate.Transparency = 1
                    end
                    afkPlate.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
                    
                    -- Фиксируем тело и запускаем микро-вибрацию CFrame для бесконечного начисления золота
                    hrp.Anchored = true
                    local direction = 1
                    while getgenv().TreasureAutoFarm.Mode == "AFK" do
                        hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, 0.05 * direction)
                        direction = -direction
                        task.wait(0.5)
                    end
                    hrp.Anchored = false
                    if afkPlate then afkPlate:Destroy() end
                end
            end)
        end
    end
end)
