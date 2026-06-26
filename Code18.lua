-- ГЛОБАЛЬНЫЕ НАСТРОЙКИ С ГАРАНТИРОВАННЫМ СБОРОМ
getgenv().TreasureAutoFarm = {
    Enabled = false,
    FlySpeed = 220,        -- Диапазон ползунка: 220 - 1000
    WaitAtChest = 4        -- Время ожидания у сундука
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- СОЗДАНИЕ ИНТЕРФЕЙСА
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "AntiFreak_Premium_Farm"
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton", ScreenGui)
local UICorner_Btn = Instance.new("UICorner", ToggleButton)
local MainMenu = Instance.new("Frame", ScreenGui)
local UICorner_Menu = Instance.new("UICorner", MainMenu)
local Title = Instance.new("TextLabel", MainMenu)
local FarmToggleBtn = Instance.new("TextButton", MainMenu)
local UICorner_Farm = Instance.new("UICorner", FarmToggleBtn)

local SliderText = Instance.new("TextLabel", MainMenu)
local SliderFrame = Instance.new("Frame", MainMenu)
local UICorner_Slider = Instance.new("UICorner", SliderFrame)
local SliderButton = Instance.new("TextButton", SliderFrame)
local UICorner_SliderBtn = Instance.new("UICorner", SliderButton)

-- СТИЛИЗАЦИЯ КНОПКИ (Шестеренка + Тёмный стиль с обводкой)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleButton.Text = "⚙️"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
ToggleButton.Font = Enum.Font.GothamBold
UICorner_Btn.CornerRadius = UDim.new(1, 0)

local BtnStroke = Instance.new("UIStroke", ToggleButton)
BtnStroke.Color = Color3.fromRGB(140, 80, 255)
BtnStroke.Thickness = 1.5

-- СТИЛИЗАЦИЯ ГЛАВНОГО МЕНЮ (Тёмная тема)
MainMenu.Size = UDim2.new(0, 280, 0, 210)
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainMenu.ClipsDescendants = true
MainMenu.Visible = false
UICorner_Menu.CornerRadius = UDim.new(0, 14)

local MenuStroke = Instance.new("UIStroke", MainMenu)
MenuStroke.Color = Color3.fromRGB(40, 40, 45)
MenuStroke.Thickness = 1

-- Авторский заголовок by @AntiFreakXD
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "by @AntiFreakXD"
Title.TextColor3 = Color3.fromRGB(160, 110, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold

-- Кнопка Включения Автофарма
FarmToggleBtn.Size = UDim2.new(1, -40, 0, 45)
FarmToggleBtn.Position = UDim2.new(0, 20, 0, 55)
FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(230, 50, 50)
FarmToggleBtn.Text = "Auto Farm: OFF"
FarmToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleBtn.TextSize = 14
FarmToggleBtn.Font = Enum.Font.GothamSemibold
UICorner_Farm.CornerRadius = UDim.new(0, 8)

-- Текст Скорости
SliderText.Size = UDim2.new(1, -40, 0, 20)
SliderText.Position = UDim2.new(0, 20, 0, 115)
SliderText.BackgroundTransparency = 1
SliderText.Text = "Speed: 220"
SliderText.TextColor3 = Color3.fromRGB(180, 180, 185)
SliderText.TextSize = 13
SliderText.Font = Enum.Font.GothamSemibold
SliderText.TextXAlignment = Enum.TextXAlignment.Left

-- Ползунок
SliderFrame.Size = UDim2.new(1, -40, 0, 10)
SliderFrame.Position = UDim2.new(0, 20, 0, 145)
SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
UICorner_Slider.CornerRadius = UDim.new(0, 5)

SliderButton.Size = UDim2.new(0, 20, 0, 20)
SliderButton.Position = UDim2.new(0, -10, -0.5, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
SliderButton.Text = ""
UICorner_SliderBtn.CornerRadius = UDim.new(1, 0)

-- ПЛАВНАЯ АНИМАЦИЯ ОТКРЫТИЯ (TWEEN)
local menuOpen = false
local originalSize = UDim2.new(0, 280, 0, 210)

ToggleButton.MouseButton1Click:Connect(function()
    if not menuOpen then
        MainMenu.Size = UDim2.new(0, 280, 0, 0)
        MainMenu.Visible = true
        local openTween = TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = originalSize})
        openTween:Play()
        menuOpen = true
    else
        local closeTween = TweenService:Create(MainMenu, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 280, 0, 0)})
        closeTween:Play()
        closeTween.Completed:Connect(function()
            if not menuOpen then MainMenu.Visible = false end
        end)
        menuOpen = false
    end
end)

-- ДРАГ-СИСТЕМА (ПЕРЕМЕЩЕНИЕ И МЕНЮ, И КНОПКИ)
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
makeDraggable(ToggleButton)
makeDraggable(MainMenu)
-- ЛОГИКА ПОЛЗУНКА СКОРОСТИ (220 - 1000)
local minSpeed, maxSpeed = 220, 1000
local isSliding = false

local function updateSlider(input)
    local sliderWidth = SliderFrame.AbsoluteSize.X
    local mouseX = input.Position.X - SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(mouseX / sliderWidth, 0, 1)
    SliderButton.Position = UDim2.new(percentage, -10, -0.5, 0)
    
    local finalSpeed = math.floor(minSpeed + (percentage * (maxSpeed - minSpeed)))
    getgenv().TreasureAutoFarm.FlySpeed = finalSpeed
    SliderText.Text = "Speed: " .. tostring(finalSpeed)
end

SliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = true end
end)
UserInputService.InputChanged:Connect(function(input)
    if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = false end
end)

FarmToggleBtn.MouseButton1Click:Connect(function()
    getgenv().TreasureAutoFarm.Enabled = not getgenv().TreasureAutoFarm.Enabled
    if getgenv().TreasureAutoFarm.Enabled then
        FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 190, 110)
        FarmToggleBtn.Text = "Auto Farm: ON"
    else
        FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(230, 50, 50)
        FarmToggleBtn.Text = "Auto Farm: OFF"
    end
end)

-- СТАБИЛЬНЫЙ NOCLIP И УДАЛЕНИЕ РЕГИСТРАТОРОВ УРОНА
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            elseif part:IsA("TouchTransmitter") and part.Parent and part.Parent.Name ~= "Trigger" then
                part:Destroy()
            end
        end
    end
end)

-- СТАБИЛИЗИРОВАННЫЙ СМАРТ-ДВИЖОК ДЛЯ СКОРОСТИ ДО 1000
local function hyperFlyTo(targetPos)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart

    local platform = Instance.new("Part")
    platform.Size = Vector3.new(12, 1, 12)
    platform.Anchored = true
    platform.Transparency = 1
    platform.Parent = Workspace

    while getgenv().TreasureAutoFarm.Enabled and (hrp.Position - targetPos).Magnitude > 6 do
        if not LocalPlayer.Character or not hrp.Parent then break end
        
        local currentDist = (targetPos - hrp.Position).Magnitude
        local dir = (targetPos - hrp.Position).Unit
        
        local speedThisFrame = getgenv().TreasureAutoFarm.FlySpeed
        local step = speedThisFrame * RunService.Heartbeat:Wait()
        
        if step > currentDist then step = currentDist end
        
        local nextPos = hrp.Position + dir * step
        
        hrp.CFrame = CFrame.new(nextPos, targetPos)
        hrp.Velocity = Vector3.new(0, 0, 0)
        platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
    end
    
    if hrp and getgenv().TreasureAutoFarm.Enabled then 
        hrp.CFrame = CFrame.new(targetPos) 
    end
    platform:Destroy()
end

-- АЛГОРИТМ 100% СБОРА ЗОН И БЕЗОПАСНОГО ФИНИША
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().TreasureAutoFarm.Enabled then
            pcall(function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                local hrp = character.HumanoidRootPart
                
                local startZ = -250
                local stepZ = -775
                local sideOffset = Vector3.new(35, 0, 0)
                
                local firstStagePos = Vector3.new(-50, 55, startZ + stepZ)
                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                local stage1 = normalStages and normalStages:FindFirstChild("CaveStage1")
                local darkness1 = stage1 and stage1:FindFirstChild("DarknessPart")
                if darkness1 then firstStagePos = darkness1.Position end
                
                -- МОМЕНТАЛЬНЫЙ СТАРТ НА СТАДИЮ 1
                if getgenv().TreasureAutoFarm.Enabled then
                    hrp.CFrame = CFrame.new(firstStagePos)
                    hrp.Velocity = Vector3.new(0,0,0)
                    task.wait(0.45)
                end

                -- Полёт по остальным чекпоинтам (2-10)
                for i = 2, 10 do
                    if not getgenv().TreasureAutoFarm.Enabled then break end
                    
                    local centerPos = Vector3.new(-50, 55, startZ + (i * stepZ))
                    local stage = normalStages and normalStages:FindFirstChild("CaveStage" .. i)
                    local darknessPart = stage and stage:FindFirstChild("DarknessPart")
                    if darknessPart then centerPos = darknessPart.Position end
                    
                    -- Смещение вправо для облёта ракет
                    local approachPos = centerPos + sideOffset
                    hyperFlyTo(approachPos)
                    
                    -- Наведение в центр перед чекпоинтом
                    hyperFlyTo(centerPos)
                    
                    local checkDelay = (getgenv().TreasureAutoFarm.FlySpeed > 600) and 0.6 or 0.38
                    task.wait(checkDelay)
                end

                -- ФИНАЛ: ТРАЕКТОРИЯ В ОБХОД КОРРОЗИЙНОЙ ВОДЫ
                if getgenv().TreasureAutoFarm.Enabled and normalStages and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    local trigger = chest and chest:FindFirstChild("Trigger")
                    local finalChestPos = trigger and trigger.Position or Vector3.new(-50, -15, -9200)
                    
                    -- Зависание над водопадом (Y = 85)
                    local safeAirPoint = Vector3.new(finalChestPos.X, 85, finalChestPos.Z + 120)
                    hyperFlyTo(safeAirPoint)
                    task.wait(0.15)
                    
                    -- Вертикальный спуск к триггеру сундука
                    hyperFlyTo(finalChestPos)
                    task.wait(getgenv().TreasureAutoFarm.WaitAtChest)
                end

                -- Респавн
                if getgenv().TreasureAutoFarm.Enabled then
                    local respawned = false
                    local conn
                    conn = LocalPlayer.CharacterAdded:Connect(function() respawned = true; conn:Disconnect() end)
                    
                    if character:FindFirstChildOfClass("Humanoid") then
                        character:FindFirstChildOfClass("Humanoid").Health = 0
                    end
                    repeat task.wait(0.1) until respawned
                end
            end)
        end
    end
end)
