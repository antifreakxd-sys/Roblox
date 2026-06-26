getgenv().TreasureAutoFarm = {
    Enabled = false,
    FlySpeed = 220,        -- От 220 до 1500
    WaitAtChest = 5        
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Создание ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiFreak_Fixed_v7"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Круглая кнопка ⚙️
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

-- Главное меню
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Size = UDim2.new(0, 280, 0, 210)
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainMenu.ClipsDescendants = true
MainMenu.Visible = true -- Изменено для стабильности Tween
MainMenu.BackgroundTransparency = 1 -- Скрыто через прозрачность
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
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "by @AntiFreakXD"
Title.TextColor3 = Color3.fromRGB(160, 100, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextTransparency = 1
Title.ZIndex = 6
Title.Parent = MainMenu

-- Кнопка включения фармы
local FarmToggleBtn = Instance.new("TextButton")
FarmToggleBtn.Name = "FarmToggleBtn"
FarmToggleBtn.Size = UDim2.new(1, -40, 0, 45)
FarmToggleBtn.Position = UDim2.new(0, 20, 0, 55)
FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(230, 50, 50)
FarmToggleBtn.Text = "Auto Farm: OFF"
FarmToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleBtn.TextSize = 14
FarmToggleBtn.Font = Enum.Font.GothamSemibold
FarmToggleBtn.BackgroundTransparency = 1
FarmToggleBtn.TextTransparency = 1
FarmToggleBtn.ZIndex = 6
FarmToggleBtn.Parent = MainMenu

local UICorner_Farm = Instance.new("UICorner")
UICorner_Farm.CornerRadius = UDim.new(0, 8)
UICorner_Farm.Parent = FarmToggleBtn

-- Элементы слайдера
local SliderText = Instance.new("TextLabel")
SliderText.Name = "SliderText"
SliderText.Size = UDim2.new(1, -40, 0, 20)
SliderText.Position = UDim2.new(0, 20, 0, 115)
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
SliderFrame.Position = UDim2.new(0, 20, 0, 145)
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

-- Исправленная система драга (Не блокирует клики)
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

-- Плавное и стабильное открытие через прозрачность
local menuOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    local targetTrans = menuOpen and 0 or 1
    
    TweenService:Create(MainMenu, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans}):Play()
    TweenService:Create(MenuStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {Transparency = targetTrans}):Play()
    TweenService:Create(Title, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {TextTransparency = targetTrans}):Play()
    TweenService:Create(FarmToggleBtn, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans, TextTransparency = targetTrans}):Play()
    TweenService:Create(SliderText, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {TextTransparency = targetTrans}):Play()
    TweenService:Create(SliderFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans}):Play()
    TweenService:Create(SliderButton, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {BackgroundTransparency = targetTrans}):Play()
end)
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Исправленная логика ползунка скорости
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

-- Исправленный и 100% рабочий клик по кнопке On/Off
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

-- Ноуклип и удаление лазеров
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

-- Движок суб-шагов (До скорости 1500)
local function stableFlyTo(targetPos)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

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
        
        local steps = (speed > 900) and 3 or 1
        local stepDistance = (speed * delta) / steps
        
        for s = 1, steps do
            if (targetPos - hrp.Position).Magnitude <= 4 then break end
            local currentStepDist = math.min(stepDistance, (targetPos - hrp.Position).Magnitude)
            local nextPos = hrp.Position + dir * currentStepDist
            
            hrp.CFrame = CFrame.new(nextPos, targetPos)
            hrp.Velocity = Vector3.new(0, 0, 0)
            platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
        end
    end
    if hrp and getgenv().TreasureAutoFarm.Enabled then hrp.CFrame = CFrame.new(targetPos) end
    platform:Destroy()
end

-- Автономный цикл фарминга
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().TreasureAutoFarm.Enabled then
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local hrp = char.HumanoidRootPart
                
                local startZ = -250
                local stepZ = -775
                local sideOffset = Vector3.new(35, 0, 0)
                
                local firstStagePos = Vector3.new(-50, 52, startZ + stepZ)
                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                local stage1 = normalStages and normalStages:FindFirstChild("CaveStage1")
                local darkness1 = stage1 and stage1:FindFirstChild("DarknessPart")
                if darkness1 then firstStagePos = Vector3.new(darkness1.Position.X, 52, darkness1.Position.Z) end
                
                if getgenv().TreasureAutoFarm.Enabled then
                    hrp.CFrame = CFrame.new(firstStagePos)
                    hrp.Velocity = Vector3.new(0,0,0)
                    task.wait(0.45)
                end

                for i = 2, 10 do
                    if not getgenv().TreasureAutoFarm.Enabled then break end
                    
                    local centerPos = Vector3.new(-50, 52, startZ + (i * stepZ))
                    local stage = normalStages and normalStages:FindFirstChild("CaveStage" .. i)
                    local darknessPart = stage and stage:FindFirstChild("DarknessPart")
                    if darknessPart then centerPos = Vector3.new(darknessPart.Position.X, 52, darknessPart.Position.Z) end
                    
                    if i == 3 or i == 6 or i == 9 or i == 10 then
                        stableFlyTo(centerPos)
                        stableFlyTo(centerPos + Vector3.new(15, 0, 0))
                        stableFlyTo(centerPos - Vector3.new(15, 0, 0))
                        stableFlyTo(centerPos)
                        
                        local checkDelay = (getgenv().TreasureAutoFarm.FlySpeed > 1000) and 0.8 or 0.55
                        task.wait(checkDelay)
                    else
                        stableFlyTo(centerPos + sideOffset)
                        stableFlyTo(centerPos)
                        local checkDelay = (getgenv().TreasureAutoFarm.FlySpeed > 1000) and 0.65 or 0.35
                        task.wait(checkDelay)
                    end
                end

                if getgenv().TreasureAutoFarm.Enabled and normalStages and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    local trigger = chest and chest:FindFirstChild("Trigger")
                    local finalChestPos = trigger and trigger.Position or Vector3.new(-50, -15, -9200)
                    
                    local safeAirPoint = Vector3.new(finalChestPos.X, 85, finalChestPos.Z + 120)
                    stableFlyTo(safeAirPoint)
                    task.wait(0.15)
                    
                    stableFlyTo(finalChestPos)
                    task.wait(getgenv().TreasureAutoFarm.WaitAtChest)
                end

                if getgenv().TreasureAutoFarm.Enabled then
                    local respawned = false
                    local conn
                    conn = LocalPlayer.CharacterAdded:Connect(function() respawned = true; conn:Disconnect() end)
                    
                    if char:FindFirstChildOfClass("Humanoid") then 
                        char:FindFirstChildOfClass("Humanoid").Health = 0 
                    end
                    repeat task.wait(0.1) until respawned
                end
            end)
        end
    end
end)
