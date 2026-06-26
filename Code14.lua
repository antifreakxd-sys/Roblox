-- НАСТРОЙКИ АВТОФАРМА
getgenv().TreasureAutoFarm = {
    Enabled = false,
    FlySpeed = 100,        -- Начальная скорость (меняется ползунком)
    WaitAtChest = 6        -- Время ожидания у сундука
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- СОЗДАНИЕ GUI С КНОПКОЙ И ПОЛЗУНКОМ
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner_Btn = Instance.new("UICorner")
local MainMenu = Instance.new("Frame")
local UICorner_Menu = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local FarmToggleBtn = Instance.new("TextButton")
local UICorner_Farm = Instance.new("UICorner")

-- Элементы ползунка
local SliderFrame = Instance.new("Frame")
local UICorner_Slider = Instance.new("UICorner")
local SliderButton = Instance.new("TextButton")
local UICorner_SliderBtn = Instance.new("UICorner")
local SliderText = Instance.new("TextLabel")

ScreenGui.Name = "BABFT_Mobile_AutoFarm"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Круглая кнопка открытия меню
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "⚓"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
UICorner_Btn.CornerRadius = UDim.new(1, 0)
UICorner_Btn.Parent = ToggleButton

-- Главное меню
MainMenu.Name = "MainMenu"
MainMenu.Parent = ScreenGui
MainMenu.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.Size = UDim2.new(0, 280, 0, 210)
MainMenu.Visible = false
UICorner_Menu.CornerRadius = UDim.new(0, 12)
UICorner_Menu.Parent = MainMenu

Title.Name = "Title"
Title.Parent = MainMenu
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "BUILD A BOAT FARM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15

-- Кнопка Вкл/Выкл
FarmToggleBtn.Name = "FarmToggleBtn"
FarmToggleBtn.Parent = MainMenu
FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
FarmToggleBtn.Position = UDim2.new(0, 20, 0, 50)
FarmToggleBtn.Size = UDim2.new(1, -40, 0, 45)
FarmToggleBtn.Font = Enum.Font.GothamSemibold
FarmToggleBtn.Text = "Auto Farm: OFF"
FarmToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleBtn.TextSize = 15
UICorner_Farm.CornerRadius = UDim.new(0, 8)
UICorner_Farm.Parent = FarmToggleBtn

-- Текст над ползунком скорости
SliderText.Name = "SliderText"
SliderText.Parent = MainMenu
SliderText.BackgroundTransparency = 1
SliderText.Position = UDim2.new(0, 20, 0, 110)
SliderText.Size = UDim2.new(1, -40, 0, 20)
SliderText.Font = Enum.Font.GothamSemibold
SliderText.Text = "Speed: 100"
SliderText.TextColor3 = Color3.fromRGB(200, 200, 200)
SliderText.TextSize = 14
SliderText.TextXAlignment = Enum.TextXAlignment.Left

-- Дорожка ползунка
SliderFrame.Name = "SliderFrame"
SliderFrame.Parent = MainMenu
SliderFrame.BackgroundColor3 = Color3.fromRGB(45, 52, 71)
SliderFrame.Position = UDim2.new(0, 20, 0, 140)
SliderFrame.Size = UDim2.new(1, -40, 0, 16)
UICorner_Slider.CornerRadius = UDim.new(0, 4)
UICorner_Slider.Parent = SliderFrame

-- Ползунок (Кнопка ползунка)
SliderButton.Name = "SliderButton"
SliderButton.Parent = SliderFrame
SliderButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderButton.Position = UDim2.new(0.33, 0, -0.25, 0)
SliderButton.Size = UDim2.new(0, 24, 0, 24)
SliderButton.Text = ""
UICorner_SliderBtn.CornerRadius = UDim.new(1, 0)
UICorner_SliderBtn.Parent = SliderButton
-- ЛОГИКА ДЛЯ ПОЛЗУНКА СКОРОСТИ
local minSpeed = 50
local maxSpeed = 200
local isSliding = false

local function updateSlider(input)
    local sliderWidth = SliderFrame.AbsoluteSize.X
    local mouseX = input.Position.X - SliderFrame.AbsolutePosition.X
    local percentage = math.clamp(mouseX / sliderWidth, 0, 1)
    SliderButton.Position = UDim2.new(percentage, -12, -0.25, 0)
    local finalSpeed = math.floor(minSpeed + (percentage * (maxSpeed - minSpeed)))
    getgenv().TreasureAutoFarm.FlySpeed = finalSpeed
    SliderText.Text = "Speed: " .. tostring(finalSpeed)
end

SliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = true
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSlider(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = false
    end
end)

-- Перетаскивание круглой кнопки (Drag)
local dragging, dragInput, dragStart, startPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = ToggleButton.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
ToggleButton.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleButton.MouseButton1Click:Connect(function() MainMenu.Visible = not MainMenu.Visible end)

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

-- СКВОЗЬ СТЕНЫ (NOCLIP)
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ФУНКЦИЯ ПЛАВНОГО ПОЛЁТА
local function flyTo(targetCFrame)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart

    local platform = Instance.new("Part")
    platform.Size = Vector3.new(8, 1, 8)
    platform.Anchored = true
    platform.Transparency = 1
    platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
    platform.Parent = Workspace

    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local duration = distance / getgenv().TreasureAutoFarm.FlySpeed

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local hrpTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    local platTween = TweenService:Create(platform, tweenInfo, {CFrame = targetCFrame * CFrame.new(0, -3.5, 0)})

    hrpTween:Play(); platTween:Play()
    hrpTween.Completed:Wait()
    if hrp then hrp.Velocity = Vector3.new(0,0,0) end
    platform:Destroy()
end

-- ЦИКЛ ФАРМА
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().TreasureAutoFarm.Enabled then
            pcall(function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                if not normalStages then return end

                -- Пролет стадий
                for i = 1, 10 do
                    if not getgenv().TreasureAutoFarm.Enabled then break end
                    local stage = normalStages:FindFirstChild("CaveStage" .. i)
                    if stage then
                        local darknessPart = stage:FindFirstChild("DarknessPart")
                        if darknessPart then flyTo(darknessPart.CFrame); task.wait(0.05) end
                    end
                end

                -- Финал (Сундук)
                if getgenv().TreasureAutoFarm.Enabled and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    if chest and chest:FindFirstChild("Trigger") then
                        flyTo(chest.Trigger.CFrame)
                        task.wait(getgenv().TreasureAutoFarm.WaitAtChest)
                    end
                end

                -- Респавн
                if getgenv().TreasureAutoFarm.Enabled then
                    local respawned = false
                    local connection
                    connection = LocalPlayer.CharacterAdded:Connect(function() respawned = true; connection:Disconnect() end)
                    if character:FindFirstChildOfClass("Humanoid") then character:FindFirstChildOfClass("Humanoid").Health = 0 end
                    repeat task.wait(0.2) until respawned
                end
            end)
        end
    end
end)
