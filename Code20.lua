-- ГЛОБАЛЬНЫЕ НАСТРОЙКИ ФАРМА
getgenv().TreasureAutoFarm = {
    Enabled = false,
    FlySpeed = 220,        -- Диапазон ползунка: 220 - 1500
    WaitAtChest = 5        -- Время ожидания у сундука
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- СОЗДАНИЕ ОСНОВНОГО КОНТЕЙНЕРА ИНТЕРФЕЙСА
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiFreak_Ultimate_v6"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- КРУГЛАЯ КНОПКА ОТКРЫТИЯ (Шестеренка ⚙️)
local ToggleButton = Instance.new("TextButton")
local UICorner_Btn = Instance.new("UICorner")
local BtnStroke = Instance.new("UIStroke")

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
ToggleButton.Text = "⚙️"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 26
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.ZIndex = 10 -- Поверх всего

UICorner_Btn.CornerRadius = UDim.new(1, 0)
UICorner_Btn.Parent = ToggleButton

BtnStroke.Color = Color3.fromRGB(140, 80, 255)
BtnStroke.Thickness = 2
BtnStroke.Parent = ToggleButton

-- ГЛАВНОЕ МЕНЮ (by @AntiFreakXD)
local MainMenu = Instance.new("Frame")
local UICorner_Menu = Instance.new("UICorner")
local MenuStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local FarmToggleBtn = Instance.new("TextButton")
local UICorner_Farm = Instance.new("UICorner")

MainMenu.Name = "MainMenu"
MainMenu.Parent = ScreenGui
MainMenu.Size = UDim2.new(0, 280, 0, 210)
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainMenu.ClipsDescendants = true
MainMenu.Visible = false
MainMenu.ZIndex = 5

UICorner_Menu.CornerRadius = UDim.new(0, 14)
UICorner_Menu.Parent = MainMenu

MenuStroke.Color = Color3.fromRGB(45, 45, 50)
MenuStroke.Thickness = 1
MenuStroke.Parent = MainMenu

Title.Name = "Title"
Title.Parent = MainMenu
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "by @AntiFreakXD"
Title.TextColor3 = Color3.fromRGB(160, 100, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 6

FarmToggleBtn.Name = "FarmToggleBtn"
FarmToggleBtn.Parent = MainMenu
FarmToggleBtn.Size = UDim2.new(1, -40, 0, 45)
FarmToggleBtn.Position = UDim2.new(0, 20, 0, 55)
FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(230, 50, 50)
FarmToggleBtn.Text = "Auto Farm: OFF"
FarmToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleBtn.TextSize = 14
FarmToggleBtn.Font = Enum.Font.GothamSemibold
FarmToggleBtn.ZIndex = 6

UICorner_Farm.CornerRadius = UDim.new(0, 8)
UICorner_Farm.Parent = FarmToggleBtn

-- ЭЛЕМЕНТЫ ПОЛЗУНКА СКОРОСТИ
local SliderText = Instance.new("TextLabel")
local SliderFrame = Instance.new("Frame")
local UICorner_Slider = Instance.new("UICorner")
local SliderButton = Instance.new("TextButton")
local UICorner_SliderBtn = Instance.new("UICorner")

SliderText.Name = "SliderText"
SliderText.Parent = MainMenu
SliderText.Size = UDim2.new(1, -40, 0, 20)
SliderText.Position = UDim2.new(0, 20, 0, 115)
SliderText.BackgroundTransparency = 1
SliderText.Text = "Speed: 220"
SliderText.TextColor3 = Color3.fromRGB(180, 180, 185)
SliderText.TextSize = 13
SliderText.Font = Enum.Font.GothamSemibold
SliderText.TextXAlignment = Enum.TextXAlignment.Left
SliderText.ZIndex = 6

SliderFrame.Name = "SliderFrame"
SliderFrame.Parent = MainMenu
SliderFrame.Size = UDim2.new(1, -40, 0, 10)
SliderFrame.Position = UDim2.new(0, 20, 0, 145)
SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
SliderFrame.ZIndex = 6

UICorner_Slider.CornerRadius = UDim.new(0, 5)
UICorner_Slider.Parent = SliderFrame

SliderButton.Name = "SliderButton"
SliderButton.Parent = SliderFrame
SliderButton.Size = UDim2.new(0, 20, 0, 20)
SliderButton.Position = UDim2.new(0, -10, -0.5, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
SliderButton.Text = ""
SliderButton.ZIndex = 7

UICorner_SliderBtn.CornerRadius = UDim.new(1, 0)
UICorner_SliderBtn.Parent = SliderButton

-- ПРОСТАЯ И НАДЕЖНАЯ СИСТЕМА ДРАГА (ПЕРЕМЕЩЕНИЯ) ДЛЯ ПК И МОБИЛЬНЫХ
local function makeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(ToggleButton)
makeDraggable(MainMenu)

-- ПЛАВНАЯ АНИМАЦИЯ ОТКРЫТИЯ МЕНЮ (БЕЗ КОНФЛИКТОВ С КЛИКАМИ)
local menuOpen = false
local originalSize = UDim2.new(0, 280, 0, 210)

ToggleButton.MouseButton1Click:Connect(function()
    if not menuOpen then
        MainMenu.Size = UDim2.new(0, 280, 0, 0)
        MainMenu.Visible = true
        TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = originalSize}):Play()
        menuOpen = true
    else
        local closeTween = TweenService:Create(MainMenu, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 280, 0, 0)})
        closeTween:Play()
        closeTween.Completed:Connect(function() if not menuOpen then MainMenu.Visible = false end end)
        menuOpen = false
    end
end)
-- ЛОГИКА РАБОТЫ ПОЛЗУНКА СКОРОСТИ (220 - 1500)
local minSpeed, maxSpeed = 220, 1500
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

-- НАЖАТИЕ НА КНОПКУ ВКЛЮЧЕНИЯ ФАРМА
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

-- ЖЕСТКИЙ ПОКАДРОВЫЙ NOCLIP И УДАЛЕНИЕ УРОНА (GODMODE)
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            elseif part:IsA("TouchTransmitter") and part.Parent and part.Parent.Name ~= "Trigger" then
                part:Destroy() -- Стираем триггеры ловушек, ракет и лазеров на ходу
            end
        end
    end
end)

-- УЛЬТРА-СКОРОСТНОЙ ДВИЖОК С АДАПТИВНЫМИ МИКРО-ШАГАМИ (ДЛЯ СКОРОСТИ 1500)
local function stableFlyTo(targetPos)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    -- Создаем невидимую опору, чтобы избежать багов падения движка
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(14, 1, 14)
    platform.Anchored = true
    platform.Transparency = 1
    platform.Parent = Workspace

    while getgenv().TreasureAutoFarm.Enabled and (hrp.Position - targetPos).Magnitude > 5 do
        if not LocalPlayer.Character or not hrp.Parent then break end
        
        local currentDist = (targetPos - hrp.Position).Magnitude
        local dir = (targetPos - hrp.Position).Unit
        
        local speed = getgenv().TreasureAutoFarm.FlySpeed
        local delta = RunService.Heartbeat:Wait()
        
        -- Если скорость выше 900, делим один кадр на 3 суб-шага. 
        -- Это обманывает античит игры и заставляет хитбоксы триггеров на 100% зафиксировать вас.
        local steps = (speed > 900) and 3 or 1
        local stepDistance = (speed * delta) / steps
        
        for s = 1, steps do
            if (targetPos - hrp.Position).Magnitude <= 4 then break end
            local currentStepDist = math.min(stepDistance, (targetPos - hrp.Position).Magnitude)
            local nextPos = hrp.Position + dir * currentStepDist
            
            hrp.CFrame = CFrame.new(nextPos, targetPos)
            hrp.Velocity = Vector3.new(0, 0, 0) -- Обнуляем физическую инерцию
            platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
        end
    end
    if hrp and getgenv().TreasureAutoFarm.Enabled then hrp.CFrame = CFrame.new(targetPos) end
    platform:Destroy()
end

-- АВТОНОМНЫЙ ЦИКЛ ФАРМА (САМ ОБНОВЛЯЕТ ПЕРСОНАЖА ПОСЛЕ СМЕРТИ)
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().TreasureAutoFarm.Enabled then
            pcall(function()
                -- Каждую итерацию берем новую ссылку на персонажа (не ломается при респавне)
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                local startZ = -250
                local stepZ = -775
                local sideOffset = Vector3.new(35, 0, 0)
                
                -- Высчитываем координаты Stage 1
                local firstStagePos = Vector3.new(-50, 52, startZ + stepZ)
                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                local stage1 = normalStages and normalStages:FindFirstChild("CaveStage1")
                local darkness1 = stage1 and stage1:FindFirstChild("DarknessPart")
                if darkness1 then firstStagePos = Vector3.new(darkness1.Position.X, 52, darkness1.Position.Z) end
                
                -- МОМЕНТАЛЬНЫЙ ТЕЛЕПОРТ СО СПАВНА НА ЧЕКПОИНТ 1
                if getgenv().TreasureAutoFarm.Enabled then
                    hrp.CFrame = CFrame.new(firstStagePos)
                    hrp.Velocity = Vector3.new(0,0,0)
                    task.wait(0.45)
                end

                -- Полёт по чекпоинтам (2 - 10)
                for i = 2, 10 do
                    if not getgenv().TreasureAutoFarm.Enabled then break end
                    
                    local centerPos = Vector3.new(-50, 52, startZ + (i * stepZ))
                    local stage = normalStages and normalStages:FindFirstChild("CaveStage" .. i)
                    local darknessPart = stage and stage:FindFirstChild("DarknessPart")
                    if darknessPart then centerPos = Vector3.new(darknessPart.Position.X, 52, darknessPart.Position.Z) end
                    
                    -- ИСПРАВЛЕНИЕ ДЛЯ ПРОБЛЕМНЫХ СТАДИЙ (3, 6, 9, 10)
                    if i == 3 or i == 6 or i == 9 or i == 10 then
                        stableFlyTo(centerPos)
                        
                        -- Зигзаг-сканирование площади узкого триггера, чтобы сервер точно выдал золото
                        stableFlyTo(centerPos + Vector3.new(15, 0, 0))
                        stableFlyTo(centerPos - Vector3.new(15, 0, 0))
                        stableFlyTo(centerPos)
                        
                        -- Даем серверной задержке игры обработать нас на 1500 скорости
                        local checkDelay = (getgenv().TreasureAutoFarm.FlySpeed > 1000) and 0.8 or 0.55
                        task.wait(checkDelay)
                    else
                        -- Обычные стадии: Облетаем ловушки справа, затем залетаем в центр
                        stableFlyTo(centerPos + sideOffset)
                        stableFlyTo(centerPos)
                        
                        local checkDelay = (getgenv().TreasureAutoFarm.FlySpeed > 1000) and 0.65 or 0.35
                        task.wait(checkDelay)
                    end
                end

                -- ФИНАЛ: ПОДЛЁТ К СУНДУКУ В ОБХОД КОРРОЗИЙНОЙ ВОДЫ ВОДОПАДА
                if getgenv().TreasureAutoFarm.Enabled and normalStages and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    local trigger = chest and chest:FindFirstChild("Trigger")
                    local finalChestPos = trigger and trigger.Position or Vector3.new(-50, -15, -9200)
                    
                    -- Сначала выходим в безопасную точку воздуха НАД водопадом (Высота Y = 85)
                    local safeAirPoint = Vector3.new(finalChestPos.X, 85, finalChestPos.Z + 120)
                    stableFlyTo(safeAirPoint)
                    task.wait(0.15)
                    
                    -- Чисто опускаемся прямо внутрь триггера сундука
                    stableFlyTo(finalChestPos)
                    task.wait(getgenv().TreasureAutoFarm.WaitAtChest)
                end

                -- БЕЗОПАСНЫЙ СБРОС ДЛЯ ПЕРЕХОДА НА СЛЕДУЮЩИЙ КРУГ ФАРМА
                if getgenv().TreasureAutoFarm.Enabled then
                    local respawned = false
                    local conn
                    conn = LocalPlayer.CharacterAdded:Connect(function() respawned = true; conn:Disconnect() end)
                    
                    if char:FindFirstChildOfClass("Humanoid") then 
                        char:FindFirstChildOfClass("Humanoid").Health = 0 
                    end
                    
                    -- Удерживаем поток, пока персонаж не появится заново на спавне
                    repeat task.wait(0.1) until respawned
                end
            end)
        end
    end
end)
