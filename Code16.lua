-- ГЛОБАЛЬНЫЕ НАСТРОЙКИ
getgenv().TreasureAutoFarm = {
    Enabled = false,
    FlySpeed = 220,        -- Диапазон от 220 до 1000
    WaitAtChest = 4        -- Ожидание анимации сундука
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- СОЗДАНИЕ ИНТЕРФЕЙСА
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "BABFT_Instant_Farm"
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

-- СТИЛИЗАЦИЯ ИНТЕРФЕЙСА
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
ToggleButton.Text = "🚀"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
ToggleButton.Font = Enum.Font.GothamBold
UICorner_Btn.CornerRadius = UDim.new(1, 0)

MainMenu.Size = UDim2.new(0, 280, 0, 210)
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(20, 15, 25)
MainMenu.Visible = false
UICorner_Menu.CornerRadius = UDim.new(0, 12)

Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "BUILD A BOAT INSTANT-FARM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold

FarmToggleBtn.Size = UDim2.new(1, -40, 0, 45)
FarmToggleBtn.Position = UDim2.new(0, 20, 0, 50)
FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
FarmToggleBtn.Text = "Auto Farm: OFF"
FarmToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleBtn.TextSize = 15
FarmToggleBtn.Font = Enum.Font.GothamSemibold
UICorner_Farm.CornerRadius = UDim.new(0, 8)

SliderText.Size = UDim2.new(1, -40, 0, 20)
SliderText.Position = UDim2.new(0, 20, 0, 110)
SliderText.BackgroundTransparency = 1
SliderText.Text = "Speed: 220"
SliderText.TextColor3 = Color3.fromRGB(230, 230, 230)
SliderText.TextSize = 14
SliderText.Font = Enum.Font.GothamSemibold
SliderText.TextXAlignment = Enum.TextXAlignment.Left

SliderFrame.Size = UDim2.new(1, -40, 0, 14)
SliderFrame.Position = UDim2.new(0, 20, 0, 140)
SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 35, 45)
UICorner_Slider.CornerRadius = UDim.new(0, 6)

SliderButton.Size = UDim2.new(0, 22, 0, 22)
SliderButton.Position = UDim2.new(0, -11, -0.25, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
SliderButton.Text = ""
UICorner_SliderBtn.CornerRadius = UDim.new(1, 0)

-- УНИВЕРСАЛЬНЫЙ ДРАГ (ДЛЯ КНОПКИ И МЕНЮ)
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

ToggleButton.MouseButton1Click:Connect(function() MainMenu.Visible = not MainMenu.Visible end)
-- ЛОГИКА ПОЛЗУНКА СКОРОСТИ (220 - 1000)
local minSpeed, maxSpeed = 220, 1000
local isSliding = false

local function updateSlider(input)
    local sliderWidth = SliderFrame.AbsoluteSize.X
    local mouseX = input.Position.X - SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(mouseX / sliderWidth, 0, 1)
    SliderButton.Position = UDim2.new(percentage, -11, -0.25, 0)
    
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
        FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        FarmToggleBtn.Text = "Auto Farm: ON"
    else
        FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
        FarmToggleBtn.Text = "Auto Farm: OFF"
    end
end)

-- ГЛОБАЛЬНЫЙ NOCLIP
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ГИПЕР-ДВИЖОК ПОЛЁТА С ИЗМЕНЕНИЕМ СКОРОСТИ НА ЛЕТУ
local function hyperFlyTo(targetPos)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart

    local platform = Instance.new("Part")
    platform.Size = Vector3.new(12, 1, 12)
    platform.Anchored = true
    platform.Transparency = 1
    platform.Parent = Workspace

    while getgenv().TreasureAutoFarm.Enabled and (hrp.Position - targetPos).Magnitude > 8 do
        if not LocalPlayer.Character or not hrp.Parent then break end
        
        local currentDist = (targetPos - hrp.Position).Magnitude
        local dir = (targetPos - hrp.Position).Unit
        
        local speedThisFrame = getgenv().TreasureAutoFarm.FlySpeed
        local step = speedThisFrame * RunService.Heartbeat:Wait()
        
        if step > currentDist then step = currentDist end
        
        local nextPos = hrp.Position + dir * step
        
        hrp.CFrame = CFrame.new(nextPos, targetPos)
        hrp.Velocity = Vector3.new(0, 0, 0) -- Полная стабилизация физики
        platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
    end
    
    if hrp and getgenv().TreasureAutoFarm.Enabled then 
        hrp.CFrame = CFrame.new(targetPos) 
    end
    platform:Destroy()
end

-- ГЛАВНЫЙ ЦИКЛ С МОМЕНТАЛЬНЫМ ТЕЛЕПОРТОМ НА СТАДИЮ 1
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().TreasureAutoFarm.Enabled then
            pcall(function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                local hrp = character.HumanoidRootPart
                
                -- Резервные координаты зон
                local startZ = -250
                local stepZ = -775
                
                -- ОПРЕДЕЛЯЕМ КООРДИНАТЫ ПЕРВОЙ СТАДИИ ДЛЯ МОМЕНТАЛЬНОГО ТЕЛЕПОРТА
                local firstStagePos = Vector3.new(-50, 55, startZ + stepZ)
                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                local stage1 = normalStages and normalStages:FindFirstChild("CaveStage1")
                local darkness1 = stage1 and stage1:FindFirstChild("DarknessPart")
                
                if darkness1 then
                    firstStagePos = darkness1.Position
                end
                
                -- МОМЕНТАЛЬНЫЙ ТЕЛЕПОРТ СО СПАВНА НА ЧЕКПОИНТ 1
                if getgenv().TreasureAutoFarm.Enabled then
                    hrp.CFrame = CFrame.new(firstStagePos)
                    hrp.Velocity = Vector3.new(0,0,0)
                    task.wait(0.4) -- Даем серверу долю секунды засчитать появление на 1-й стадии
                end

                -- Полёт по остальным стадиям (начиная со 2-й, так как на 1-й мы уже стоим)
                for i = 2, 10 do
                    if not getgenv().TreasureAutoFarm.Enabled then break end
                    
                    local targetPosition = Vector3.new(-50, 55, startZ + (i * stepZ))
                    local stage = normalStages and normalStages:FindFirstChild("CaveStage" .. i)
                    local darknessPart = stage and stage:FindFirstChild("DarknessPart")
                    
                    if darknessPart then
                        targetPosition = darknessPart.Position
                    end
                    
                    hyperFlyTo(targetPosition)
                    
                    -- Задержка на чекпоинте для 100% зачисления
                    local checkDelay = (getgenv().TreasureAutoFarm.FlySpeed > 600) and 0.55 or 0.35
                    task.wait(checkDelay)
                end

                -- Финал: Летим к сундуку
                if getgenv().TreasureAutoFarm.Enabled and normalStages and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    local trigger = chest and chest:FindFirstChild("Trigger")
                    
                    if trigger then
                        hyperFlyTo(trigger.Position)
                    else
                        hyperFlyTo(Vector3.new(-50, -15, -9200))
                    end
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
