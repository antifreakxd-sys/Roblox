-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner_Btn = Instance.new("UICorner")
local MainMenu = Instance.new("Frame")
local UICorner_Menu = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local FunctionsFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ParryToggleBtn = Instance.new("TextButton")
local UICorner_Parry = Instance.new("UICorner")

-- Настройка контейнера
ScreenGui.Name = "BladeBallGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- 1. Круглая перетаскиваемая кнопка
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "BB"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24

UICorner_Btn.CornerRadius = UDim.new(1, 0)
UICorner_Btn.Parent = ToggleButton

-- 2. Главное меню
MainMenu.Name = "MainMenu"
MainMenu.Parent = ScreenGui
MainMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainMenu.Position = UDim2.new(0.35, 0, 0.3, 0)
MainMenu.Size = UDim2.new(0, 300, 0, 200)
MainMenu.Visible = false

UICorner_Menu.CornerRadius = UDim.new(0, 12)
UICorner_Menu.Parent = MainMenu

Title.Name = "Title"
Title.Parent = MainMenu
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "BLADE BALL MENU"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 18

FunctionsFrame.Name = "FunctionsFrame"
FunctionsFrame.Parent = MainMenu
FunctionsFrame.BackgroundTransparency = 1
FunctionsFrame.Position = UDim2.new(0, 10, 0, 50)
FunctionsFrame.Size = UDim2.new(1, -20, 1, -60)

UIListLayout.Parent = FunctionsFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- Кнопка включения авто-отбивания
ParryToggleBtn.Name = "ParryToggleBtn"
ParryToggleBtn.Parent = FunctionsFrame
ParryToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ParryToggleBtn.Size = UDim2.new(1, 0, 0, 45)
ParryToggleBtn.Font = Enum.Font.GothamSemibold
ParryToggleBtn.Text = "Auto Parry: OFF"
ParryToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ParryToggleBtn.TextSize = 16

UICorner_Parry.CornerRadius = UDim.new(0, 8)
UICorner_Parry.Parent = ParryToggleBtn

-- ЛОГИКА СКРИПТА

-- Скрипт перетаскивания (Drag) для круглой кнопки
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Открытие/закрытие меню по клику на круглую кнопку
ToggleButton.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
end)

-- Переменные для Auto Parry
local autoParryActive = false
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Функция переключения Auto Parry
ParryToggleBtn.MouseButton1Click:Connect(function()
    autoParryActive = not autoParryActive
    if autoParryActive then
        ParryToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        ParryToggleBtn.Text = "Auto Parry: ON"
    else
        ParryToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        ParryToggleBtn.Text = "Auto Parry: OFF"
    end
end)

-- Логика отслеживания мяча и автоматического удара
game:GetService("RunService").Heartbeat:Connect(function()
    if not autoParryActive then return end
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart
    
    -- Ищем мяч в рабочей области (Balls обычно спавнятся в Workspace)
    local ballsFolder = workspace:FindFirstChild("Balls")
    if ballsFolder then
        for _, ball in pairs(ballsFolder:GetChildren()) do
            -- Проверяем, летит ли мяч на игрока (цель)
            if ball:GetAttribute("target") == player.Name or ball:GetAttribute("Target") == player.Name then
                local distance = (ball.Position - hrp.Position).Magnitude
                local ballVelocity = ball.AssemblyLinearVelocity.Magnitude
                
                -- Динамическая дистанция активации в зависимости от скорости мяча
                local activationDistance = math.clamp(ballVelocity * 0.5, 15, 60)
                
                if distance <= activationDistance then
                    -- Симуляция нажатия кнопки блока через RemoteEvent игры
                    -- В Blade Ball это обычно 'Parry' или 'Block' в ReplicatedStorage
                    local parryEvent = replicatedStorage:FindFirstChild("Remotes") and replicatedStorage.Remotes:FindFirstChild("Parry") 
                                       or replicatedStorage:FindFirstChild("Parry")
                                       
                    if parryEvent and parryEvent:IsA("RemoteEvent") then
                        parryEvent:FireServer()
                    end
                end
            end
        end
    end
end)
