getgenv().TreasureAutoFarm = {
    Mode = "None",         -- Текущий режим: "Fly", "TP" или "None"
    FlySpeed = 220,        -- Диапазон скорости ползунка: 220 - 1500
    WaitAtChest = 5        -- Время ожидания у сундука
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Создание ScreenGui контейнера
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiFreak_Final_v9"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Круглая кнопка-шестерёнка ⚙️
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
ToggleButton.Text = "⚙️"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 26
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui

local UICorner_Btn = Instance.new("UICorner")
UICorner_Btn.CornerRadius = UDim.new(1, 0)
UICorner_Btn.Parent = ToggleButton

local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = Color3.fromRGB(140, 80, 255)
BtnStroke.Thickness = 2
BtnStroke.Parent = ToggleButton

-- Главное тёмное меню (by @AntiFreakXD)
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Size = UDim2.new(0, 280, 0, 210)
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainMenu.ClipsDescendants = true
MainMenu.Visible = true 
MainMenu.BackgroundTransparency = 1 -- Скрыто изначально через прозрачность
MainMenu.ZIndex = 5
MainMenu.Parent = ScreenGui

local UICorner_Menu = Instance.new("UICorner")
UICorner_Menu.CornerRadius = UDim.new(0, 14)
UICorner_Menu.Parent = MainMenu

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(45, 45, 50)
MenuStroke.Thickness = 1
MenuStroke.Parent = MainMenu

-- Заголовок by @AntiFreakXD
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "by @AntiFreakXD"
Title.TextColor3 = Color3.fromRGB(160, 100, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextTransparency = 1
Title.ZIndex = 6
Title.Parent = MainMenu

-- Кнопка режима FLY FARM
local FlyToggleBtn = Instance.new("TextButton")
FlyToggleBtn.Name = "FlyToggleBtn"
FlyToggleBtn.Size = UDim2.new(0, 115, 0, 45)
FlyToggleBtn.Position = UDim2.new(0, 20, 0, 50)
FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
FlyToggleBtn.Text = "Fly Farm: OFF"
FlyToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToggleBtn.TextSize = 13
FlyToggleBtn.Font = Enum.Font.GothamSemibold
FlyToggleBtn.BackgroundTransparency = 1
FlyToggleBtn.TextTransparency = 1
FlyToggleBtn.ZIndex = 6
FlyToggleBtn.Parent = MainMenu

local UICorner_Fly = Instance.new("UICorner")
UICorner_Fly.CornerRadius = UDim.new(0, 8)
UICorner_Fly.Parent = FlyToggleBtn

-- Кнопка режима TP FARM
local TpToggleBtn = Instance.new("TextButton")
TpToggleBtn.Name = "TpToggleBtn"
TpToggleBtn.Size = UDim2.new(0, 115, 0, 45)
TpToggleBtn.Position = UDim2.new(0, 145, 0, 50)
TpToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TpToggleBtn.Text = "TP Farm: OFF"
TpToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpToggleBtn.TextSize = 13
TpToggleBtn.Font = Enum.Font.GothamSemibold
TpToggleBtn.BackgroundTransparency = 1
TpToggleBtn.TextTransparency = 1
TpToggleBtn.ZIndex = 6
TpToggleBtn.Parent = MainMenu

local UICorner_Tp = Instance.new("UICorner")
UICorner_Tp.CornerRadius = UDim.new(0, 8)
UICorner_Tp.Parent = TpToggleBtn
-- Элементы слайдера скорости
local SliderText = Instance.new("TextLabel")
SliderText.Name = "SliderText"
SliderText.Size = UDim2.new(1, -40, 0, 20)
SliderText.Position = UDim2.new(0, 20, 0, 120)
SliderText.BackgroundTransparency = 1
SliderText.Text = "Speed: 220"
SliderText.TextColor3 = Color3.fromRGB(180, 180, 185)
SliderText.TextSize = 13
SliderText.Font = Enum.Font.GothamSemibold
SliderText.TextXAlignment = Enum.TextXAlignment.Left
SliderText.TextTransparency = 1
SliderText.ZIndex = 6
SliderText.Parent = MainMenu

local SliderFrame = Instance.new("Frame")
local UICorner_Slider = Instance.new("UICorner")
local SliderButton = Instance.new("TextButton")
local UICorner_SliderBtn = Instance.new("UICorner")

SliderFrame.Name = "SliderFrame"
SliderFrame.Size = UDim2.new(1, -40, 0, 10)
SliderFrame.Position = UDim2.new(0, 20, 0, 150)
SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
SliderFrame.BackgroundTransparency = 1
SliderFrame.ZIndex = 6
SliderFrame.Parent = MainMenu

UICorner_Slider.CornerRadius = UDim.new(0, 5)
UICorner_Slider.Parent = SliderFrame

SliderButton.Name = "SliderButton"
SliderButton.Size = UDim2.new(0, 20, 0, 20)
SliderButton.Position = UDim2.new(0, -10, -0.5, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
SliderButton.Text = ""
SliderButton.BackgroundTransparency = 1
SliderButton.ZIndex = 7
SliderButton.Parent = SliderFrame

UICorner_SliderBtn.CornerRadius = UDim.new(1, 0)
UICorner_SliderBtn.Parent = SliderButton

-- Безопасная система перемещения (Drag) окон без перехвата ивентов клика
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

-- Плавное проявление/исчезновение меню при клике на шестеренку
local menuOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    local targetTrans = menuOpen and 0 or 1
    TweenService:Create(MainMenu, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans}):Play()
    TweenService:Create(MenuStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {Transparency = targetTrans}):Play()
    TweenService:Create(Title, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {TextTransparency = targetTrans}):Play()
    TweenService:Create(FlyToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    TweenService:Create(TpToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    TweenService:Create(SliderText, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {TextTransparency = targetTrans}):Play()
    TweenService:Create(SliderFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans}):Play()
    TweenService:Create(SliderButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans}):Play()
end)

-- Управление ползунком (220 - 1500 спиды)
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

SliderButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = true end end)
UserInputService.InputChanged:Connect(function(input) if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = false end end)

-- Переключение состояний и цветов кнопок активации фармы
local function resetButtons()
    FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    FlyToggleBtn.Text = "Fly Farm: OFF"
    TpToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    TpToggleBtn.Text = "TP Farm: OFF"
end

FlyToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "Fly" then
        getgenv().TreasureAutoFarm.Mode = "None"
        resetButtons()
    else
        getgenv().TreasureAutoFarm.Mode = "Fly"
        resetButtons()
        FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 190, 110)
        FlyToggleBtn.Text = "Fly Farm: ON"
    end
end)

TpToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "TP" then
        getgenv().TreasureAutoFarm.Mode = "None"
        resetButtons()
    else
        getgenv().TreasureAutoFarm.Mode = "TP"
        resetButtons()
        TpToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 255)
        TpToggleBtn.Text = "TP Farm: ON"
    end
end)
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Глобальный Ноуклип и Полное вырезание урона
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Mode ~= "None" and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            elseif part:IsA("TouchTransmitter") and part.Parent and part.Parent.Name ~= "Trigger" then
                part:Destroy()
            end
        end
    end
end)

-- Стабилизированное покадровое перемещение с суб-шагами для обмана античита
local function safeFlyTo(targetPos)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    local platform = Instance.new("Part", Workspace)
    platform.Size = Vector3.new(14, 1, 14)
    platform.Anchored = true
    platform.Transparency = 1

    while getgenv().TreasureAutoFarm.Mode == "Fly" and (hrp.Position - targetPos).Magnitude > 5 do
        if not LocalPlayer.Character or not hrp.Parent then break end
        local dir = (targetPos - hrp.Position).Unit
        local delta = RunService.Heartbeat:Wait()
        
        local speed = getgenv().TreasureAutoFarm.FlySpeed
        local stepDistance = speed * delta
        
        if stepDistance > (targetPos - hrp.Position).Magnitude then stepDistance = (targetPos - hrp.Position).Magnitude end
        
        local nextPos = hrp.Position + dir * stepDistance
        hrp.CFrame = CFrame.new(nextPos, targetPos)
        hrp.Velocity = Vector3.new(0,0,0)
        platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
    end
    if hrp and getgenv().TreasureAutoFarm.Mode == "Fly" then hrp.CFrame = CFrame.new(targetPos) end
    platform:Destroy()
end

-- Автономный бессмертный поток контроля зачисления золота
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().TreasureAutoFarm.Mode ~= "None" then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                local startZ = -250
                local stepZ = -775
                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                
                -- Высчитываем координаты Stage 1 на БЕЗОПАСНОЙ высоте Y = 85 (выше любой лавы и воды)
                local firstStagePos = Vector3.new(-50, 85, startZ + stepZ)
                local stage1 = normalStages and normalStages:FindFirstChild("CaveStage1")
                local darkness1 = stage1 and stage1:FindFirstChild("DarknessPart")
                if darkness1 then firstStagePos = Vector3.new(darkness1.Position.X, 85, darkness1.Position.Z) end
                
                -- Мгновенный перенос со спавна на Чекпоинт 1
                hrp.CFrame = CFrame.new(firstStagePos)
                hrp.Velocity = Vector3.new(0,0,0)
                task.wait(0.4)

                -- Цикл прохождения стадий (2 - 10)
                for i = 2, 10 do
                    if getgenv().TreasureAutoFarm.Mode == "None" then break end
                    
                    local centerPos = Vector3.new(-50, 85, startZ + (i * stepZ))
                    local stage = normalStages and normalStages:FindFirstChild("CaveStage" .. i)
                    local darknessPart = stage and stage:FindFirstChild("DarknessPart")
                    if darknessPart then centerPos = Vector3.new(darknessPart.Position.X, 85, darknessPart.Position.Z) end
                    
                    if getgenv().TreasureAutoFarm.Mode == "Fly" then
                        -- Вариант 1: Плавный скоростной полет в небе
                        safeFlyTo(centerPos)
                        if i == 3 or i == 6 or i == 9 or i == 10 then
                            safeFlyTo(centerPos + Vector3.new(15, 0, 0))
                            safeFlyTo(centerPos - Vector3.new(15, 0, 0))
                            safeFlyTo(centerPos)
                            local checkDelay = (getgenv().TreasureAutoFarm.FlySpeed > 1000) and 0.85 or 0.55
                            task.wait(checkDelay)
                        else
                            local checkDelay = (getgenv().TreasureAutoFarm.FlySpeed > 1000) and 0.6 or 0.35
                            task.wait(checkDelay)
                        end
                    elseif getgenv().TreasureAutoFarm.Mode == "TP" then
                        -- Вариант 2: Мгновенные точечные телепорты с удержанием платформой
                        hrp.CFrame = CFrame.new(centerPos)
                        hrp.Velocity = Vector3.new(0,0,0)
                        
                        local p = Instance.new("Part", Workspace)
                        p.Size = Vector3.new(12, 1, 12)
                        p.Anchored = true
                        p.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
                        p.Transparency = 1
                        
                        task.wait(0.85) -- Надежная задержка при ТР, чтобы сервер 100% выдал золото
                        p:Destroy()
                    end
                end

                -- ФИНАЛ: Перелёт напрямую к Золотому Сундуку
                if getgenv().TreasureAutoFarm.Mode ~= "None" and normalStages and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    local trigger = chest and chest:FindFirstChild("Trigger")
                    local finalChestPos = trigger and trigger.Position or Vector3.new(-50, -15, -9200)
                    
                    hrp.CFrame = CFrame.new(finalChestPos)
                    task.wait(getgenv().TreasureAutoFarm.WaitAtChest)
                end

                -- Сброс здоровья для респавна и автоматического старта нового круга
                if getgenv().TreasureAutoFarm.Mode ~= "None" then
                    local respawned = false
                    local conn
                    conn = LocalPlayer.CharacterAdded:Connect(function() respawned = true; conn:Disconnect() end)
                    if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").Health = 0 end
                    repeat task.wait(0.1) until respawned
                end
            end)
        end
    end
end)
