getgenv().TreasureAutoFarm = {
    Mode = "None",         -- "Fly", "TP" или "None"
    FlySpeed = 220,        -- От 220 до 1500
    WaitAtChest = 5        
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Контейнер GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiFreak_V10_Core"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Кнопка-шестерёнка ⚙️
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

local UICorner_Btn = Instance.new("UICorner", ToggleButton)
UICorner_Btn.CornerRadius = UDim.new(1, 0)

local BtnStroke = Instance.new("UIStroke", ToggleButton)
BtnStroke.Color = Color3.fromRGB(140, 80, 255)
BtnStroke.Thickness = 2

-- Главное меню
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Size = UDim2.new(0, 280, 0, 150) -- Изначально меньше по высоте
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainMenu.ClipsDescendants = true
MainMenu.Visible = true 
MainMenu.BackgroundTransparency = 1 
MainMenu.ZIndex = 5
MainMenu.Parent = ScreenGui

local UICorner_Menu = Instance.new("UICorner", MainMenu)
UICorner_Menu.CornerRadius = UDim.new(0, 14)

local MenuStroke = Instance.new("UIStroke", MainMenu)
MenuStroke.Color = Color3.fromRGB(45, 45, 50)
MenuStroke.Thickness = 1

-- Заголовок
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

-- Контейнер для Fly Farm (Кнопка + Стрелочка)
local FlyFrame = Instance.new("Frame")
FlyFrame.Name = "FlyFrame"
FlyFrame.Size = UDim2.new(0, 115, 0, 45)
FlyFrame.Position = UDim2.new(0, 20, 0, 50)
FlyFrame.BackgroundTransparency = 1
FlyFrame.ZIndex = 6
FlyFrame.Parent = MainMenu

local FlyToggleBtn = Instance.new("TextButton")
FlyToggleBtn.Name = "FlyToggleBtn"
FlyToggleBtn.Size = UDim2.new(0, 85, 1, 0)
FlyToggleBtn.Position = UDim2.new(0, 0, 0, 0)
FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
FlyToggleBtn.Text = "Fly Farm"
FlyToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToggleBtn.TextSize = 12
FlyToggleBtn.Font = Enum.Font.GothamSemibold
FlyToggleBtn.BackgroundTransparency = 1
FlyToggleBtn.TextTransparency = 1
FlyToggleBtn.ZIndex = 7
FlyToggleBtn.Parent = FlyFrame
Instance.new("UICorner", FlyToggleBtn).CornerRadius = UDim.new(0, 6)

local ArrowBtn = Instance.new("TextButton")
ArrowBtn.Name = "ArrowBtn"
ArrowBtn.Size = UDim2.new(0, 25, 1, 0)
ArrowBtn.Position = UDim2.new(0, 90, 0, 0)
ArrowBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ArrowBtn.Text = "▶"
ArrowBtn.TextColor3 = Color3.fromRGB(160, 100, 255)
ArrowBtn.TextSize = 12
ArrowBtn.Font = Enum.Font.GothamBold
ArrowBtn.BackgroundTransparency = 1
ArrowBtn.TextTransparency = 1
ArrowBtn.ZIndex = 7
ArrowBtn.Parent = FlyFrame
Instance.new("UICorner", ArrowBtn).CornerRadius = UDim.new(0, 6)

-- Кнопка TP FARM
local TpToggleBtn = Instance.new("TextButton")
TpToggleBtn.Name = "TpToggleBtn"
TpToggleBtn.Size = UDim2.new(0, 115, 0, 45)
TpToggleBtn.Position = UDim2.new(0, 145, 0, 50)
TpToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TpToggleBtn.Text = "TP Farm: OFF"
TpToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpToggleBtn.TextSize = 12
TpToggleBtn.Font = Enum.Font.GothamSemibold
TpToggleBtn.BackgroundTransparency = 1
TpToggleBtn.TextTransparency = 1
TpToggleBtn.ZIndex = 7
TpToggleBtn.Parent = MainMenu
Instance.new("UICorner", TpToggleBtn).CornerRadius = UDim.new(0, 6)
-- Создание скрытых элементов слайдера
local SliderContainer = Instance.new("Frame")
SliderContainer.Name = "SliderContainer"
SliderContainer.Size = UDim2.new(1, -40, 0, 50)
SliderContainer.Position = UDim2.new(0, 20, 0, 110)
SliderContainer.BackgroundTransparency = 1
SliderContainer.Visible = false
SliderContainer.ZIndex = 6
SliderContainer.Parent = MainMenu

local SliderText = Instance.new("TextLabel")
SliderText.Size = UDim2.new(1, 0, 0, 20)
SliderText.BackgroundTransparency = 1
SliderText.Text = "Speed: 220"
SliderText.TextColor3 = Color3.fromRGB(180, 180, 185)
SliderText.TextSize = 13
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

-- Логика перетаскивания интерфейса
local function makeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = obj.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    obj.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(ToggleButton)
makeDraggable(MainMenu)

-- Анимация открытия главного меню
local menuOpen = false
local normalSize = UDim2.new(0, 280, 0, 120)
local expandedSize = UDim2.new(0, 280, 0, 180)
local currentTargetSize = normalSize

ToggleButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    local targetTrans = menuOpen and 0 or 1
    TweenService:Create(MainMenu, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, Size = menuOpen and currentTargetSize or UDim2.new(0, 280, 0, 0)}):Play()
    TweenService:Create(MenuStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {Transparency = targetTrans}):Play()
    TweenService:Create(Title, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {TextTransparency = targetTrans}):Play()
    TweenService:Create(FlyToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    TweenService:Create(ArrowBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    TweenService:Create(TpToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    
    if not menuOpen then
        SliderContainer.Visible = false
        TweenService:Create(SliderText, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
        TweenService:Create(SliderFrame, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
        TweenService:Create(SliderButton, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
    elseif currentTargetSize == expandedSize then
        SliderContainer.Visible = true
        TweenService:Create(SliderText, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        TweenService:Create(SliderFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
        TweenService:Create(SliderButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end
end)

-- Анимация выпадающей стрелочки скорости
local arrowExpanded = false
ArrowBtn.MouseButton1Click:Connect(function()
    if not menuOpen then return end
    arrowExpanded = not arrowExpanded
    
    if arrowExpanded then
        ArrowBtn.Text = "▼"
        currentTargetSize = expandedSize
        MainMenu:TweenSize(expandedSize, "Out", "Quart", 0.2, true)
        SliderContainer.Visible = true
        TweenService:Create(SliderText, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        TweenService:Create(SliderFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
        TweenService:Create(SliderButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    else
        ArrowBtn.Text = "▶"
        currentTargetSize = normalSize
        MainMenu:TweenSize(normalSize, "Out", "Quart", 0.2, true)
        TweenService:Create(SliderText, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
        TweenService:Create(SliderFrame, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        TweenService:Create(SliderButton, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        task.delay(0.15, function() if not arrowExpanded then SliderContainer.Visible = false end end)
    end
end)
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Ползунок
local minSpeed, maxSpeed = 220, 1500
local isSliding = false
local function updateSlider(input)
    local sliderWidth = SliderFrame.AbsoluteSize.X
    local mouseX = input.Position.X - SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(mouseX / sliderWidth, 0, 1)
    SliderButton.Position = UDim2.new(percentage, -9, -0.5, 0)
    local finalSpeed = math.floor(minSpeed + (percentage * (maxSpeed - minSpeed)))
    getgenv().TreasureAutoFarm.FlySpeed = finalSpeed
    SliderText.Text = "Speed: " .. tostring(finalSpeed)
end
SliderButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = true end end)
UserInputService.InputChanged:Connect(function(input) if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isSliding = false end end)

-- Переключатели режимов
local function resetButtons()
    FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    TpToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    TpToggleBtn.Text = "TP Farm: OFF"
end
FlyToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "Fly" then getgenv().TreasureAutoFarm.Mode = "None"; resetButtons()
    else getgenv().TreasureAutoFarm.Mode = "Fly"; resetButtons(); FlyToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 190, 110) end
end)
TpToggleBtn.MouseButton1Click:Connect(function()
    if getgenv().TreasureAutoFarm.Mode == "TP" then getgenv().TreasureAutoFarm.Mode = "None"; resetButtons()
    else getgenv().TreasureAutoFarm.Mode = "TP"; resetButtons(); TpToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 255); TpToggleBtn.Text = "TP Farm: ON" end
end)

-- Noclip + ПОЛНОЕ ОБНУЛЕНИЕ ВЕСА И ИНЕРЦИИ (Защита от улета за карту)
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Mode ~= "None" and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false
                part.AssemblyLinearVelocity = Vector3.new(0,0,0)   -- Гасим линейную инерцию
                part.AssemblyAngularVelocity = Vector3.new(0,0,0)  -- Гасим вращение тела
            elseif part:IsA("TouchTransmitter") and part.Parent and part.Parent.Name ~= "Trigger" then
                part:Destroy()
            end
        end
    end
end)

-- Стабильный полет по воздуху (Высота Y = 85)
local function safeFlyTo(targetPos)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local platform = Instance.new("Part", Workspace)
    platform.Size = Vector3.new(15, 1, 15)
    platform.Anchored = true; platform.Transparency = 1

    while getgenv().TreasureAutoFarm.Mode == "Fly" and (hrp.Position - targetPos).Magnitude > 5 do
        if not LocalPlayer.Character or not hrp.Parent then break end
        local dir = (targetPos - hrp.Position).Unit
        local step = getgenv().TreasureAutoFarm.FlySpeed * RunService.Heartbeat:Wait()
        if step > (targetPos - hrp.Position).Magnitude then step = (targetPos - hrp.Position).Magnitude end
        hrp.CFrame = CFrame.new(hrp.Position + dir * step, targetPos)
        platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
    end
    if hrp and getgenv().TreasureAutoFarm.Mode == "Fly" then hrp.CFrame = CFrame.new(targetPos) end
    platform:Destroy()
end

-- Основной цикл
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().TreasureAutoFarm.Mode ~= "None" then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                
                -- Старт на Stage 1
                local fPos = Vector3.new(-50, 85, -1025)
                local st1 = normalStages and normalStages:FindFirstChild("CaveStage1")
                if st1 and st1:FindFirstChild("DarknessPart") then fPos = Vector3.new(st1.DarknessPart.Position.X, 85, st1.DarknessPart.Position.Z) end
                hrp.CFrame = CFrame.new(fPos); task.wait(0.4)

                -- Прохождение стадий
                for i = 2, 10 do
                    if getgenv().TreasureAutoFarm.Mode == "None" then break end
                    local centerPos = Vector3.new(-50, 85, -1025 + (i * -775))
                    local stage = normalStages and normalStages:FindFirstChild("CaveStage" .. i)
                    if stage and stage:FindFirstChild("DarknessPart") then centerPos = Vector3.new(stage.DarknessPart.Position.X, 85, stage.DarknessPart.Position.Z) end
                    
                    if getgenv().TreasureAutoFarm.Mode == "Fly" then
                        safeFlyTo(centerPos)
                        if i == 3 or i == 6 or i == 9 or i == 10 then
                            safeFlyTo(centerPos + Vector3.new(15, 0, 0)); safeFlyTo(centerPos - Vector3.new(15, 0, 0)); safeFlyTo(centerPos)
                            task.wait((getgenv().TreasureAutoFarm.FlySpeed > 1000) and 0.85 or 0.55)
                        else
                            task.wait(0.35)
                        end
                    elseif getgenv().TreasureAutoFarm.Mode == "TP" then
                        -- СИСТЕМА ОБМАНА СЕРВЕРА ДЛЯ ТР
                        hrp.CFrame = CFrame.new(centerPos)
                        local p = Instance.new("Part", Workspace)
                        p.Size = Vector3.new(12, 1, 12); p.Anchored = true; p.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0); p.Transparency = 1
                        
                        -- Даем микро-импульс присутствия, чтобы сервер зафиксировал триггер на 100%
                        for Layer = 1, 3 do
                            if getgenv().TreasureAutoFarm.Mode ~= "TP" then break end
                            hrp.CFrame = CFrame.new(centerPos + Vector3.new(0, Layer * 0.2, 0))
                            RunService.Heartbeat:Wait()
                        end
                        task.wait(0.8)
                        p:Destroy()
                    end
                end

                -- Финал (Сундук)
                if getgenv().TreasureAutoFarm.Mode ~= "None" and normalStages and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    local trigger = chest and chest:FindFirstChild("Trigger")
                    if trigger then hrp.CFrame = CFrame.new(trigger.Position) else hrp.CFrame = CFrame.new(-50, -15, -9200) end
                    task.wait(getgenv().TreasureAutoFarm.WaitAtChest)
                end

                -- Респавн
                if getgenv().TreasureAutoFarm.Mode ~= "None" then
                    local respawned = false
                    local conn = LocalPlayer.CharacterAdded:Connect(function() respawned = true end)
                    if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").Health = 0 end
                    repeat task.wait(0.1) until respawned
                    conn:Disconnect()
                end
            end)
        end
    end
end)
