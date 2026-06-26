-- НАСТРОЙКИ АВТОФАРМА
getgenv().TreasureAutoFarm = {
    Enabled = false,       -- Включается через кнопку в GUI
    FlySpeed = 75,         -- Оптимальная скорость полёта, чтобы не кикал анти-чит
    WaitAtChest = 6        -- Время ожидания у сундука (пока идёт анимация золота)
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- СОЗДАНИЕ КРАСИВОГО GUI С ПЕРЕТАСКИВАЕМОЙ КНОПКОЙ
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner_Btn = Instance.new("UICorner")
local MainMenu = Instance.new("Frame")
local UICorner_Menu = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local FarmToggleBtn = Instance.new("TextButton")
local UICorner_Farm = Instance.new("UICorner")

ScreenGui.Name = "BABFT_Perfect_AutoFarm"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Стильная круглая кнопка
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
MainMenu.Size = UDim2.new(0, 280, 0, 160)
MainMenu.Visible = false
UICorner_Menu.CornerRadius = UDim.new(0, 12)
UICorner_Menu.Parent = MainMenu

Title.Name = "Title"
Title.Parent = MainMenu
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Font = Enum.Font.GothamBold
Title.Text = "BUILD A BOAT AUTO-FARM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15

-- Кнопка включения/выключения
FarmToggleBtn.Name = "FarmToggleBtn"
FarmToggleBtn.Parent = MainMenu
FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
FarmToggleBtn.Position = UDim2.new(0, 20, 0, 70)
FarmToggleBtn.Size = UDim2.new(1, -40, 0, 50)
FarmToggleBtn.Font = Enum.Font.GothamSemibold
FarmToggleBtn.Text = "Auto Farm: OFF"
FarmToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleBtn.TextSize = 16
UICorner_Farm.CornerRadius = UDim.new(0, 8)
UICorner_Farm.Parent = FarmToggleBtn

-- Скрипт плавного перетаскивания круглой кнопки (Drag)
local dragging, dragInput, dragStart, startPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = ToggleButton.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
ToggleButton.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Открытие/закрытие меню по нажатию на кружок
ToggleButton.MouseButton1Click:Connect(function() MainMenu.Visible = not MainMenu.Visible end)

-- Переключение автофарма
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

-- ГЛОБАЛЬНЫЙ NOCLIP И АНТИ-УРОН (Защита от застревания и лазеров)
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            end
        end
    end
end)

-- ФУНКЦИЯ ДЛЯ ПЛАВНОГО ПЕРЕМЕЩЕНИЯ (Tween)
local function flyTo(targetCFrame)
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = character.HumanoidRootPart

    -- Создаем невидимую платформу, чтобы персонаж не падал во время полета
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(8, 1, 8)
    platform.Anchored = true
    platform.Transparency = 1
    platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
    platform.Parent = Workspace

    -- Рассчитываем время полета в зависимости от расстояния и скорости
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local duration = distance / getgenv().TreasureAutoFarm.FlySpeed

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local hrpTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    local platTween = TweenService:Create(platform, tweenInfo, {CFrame = targetCFrame * CFrame.new(0, -3.5, 0)})

    hrpTween:Play()
    platTween:Play()

    hrpTween.Completed:Wait()
    platform:Destroy()
end

-- ГЛАВНЫЙ ЦИКЛ ФАРМА
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().TreasureAutoFarm.Enabled then
            pcall(function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                
                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                if not normalStages then return end

                -- 1. Последовательно пролетаем через все 10 стадий
                for i = 1, 10 do
                    if not getgenv().TreasureAutoFarm.Enabled then break end
                    
                    local stageName = "CaveStage" .. i
                    local stage = normalStages:FindFirstChild(stageName)
                    
                    if stage then
                        local darknessPart = stage:FindFirstChild("DarknessPart")
                        if darknessPart then
                            -- Летим точно в центр чекпоинта стадии
                            flyTo(darknessPart.CFrame * CFrame.new(0, 0, 0))
                            task.wait(0.1) -- Микро-пауза, чтобы сервер засчитал локацию
                        end
                    end
                end

                -- 2. Летим к финалу прямо в триггер золотого сундука
                if getgenv().TreasureAutoFarm.Enabled and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    if chest and chest:FindFirstChild("Trigger") then
                        flyTo(chest.Trigger.CFrame)
                        task.wait(getgenv().TreasureAutoFarm.WaitAtChest) -- Ждем золото
                    end
                end

                -- 3. Безопасный респ для запуска следующего круга
                if getgenv().TreasureAutoFarm.Enabled then
                    local respawned = false
                    local connection
                    connection = LocalPlayer.CharacterAdded:Connect(function()
                        respawned = true
                        connection:Disconnect()
                    end)

                    -- Убиваем персонажа, если он сам не зареспавнился, чтобы обновить цикл
                    if character:FindFirstChildOfClass("Humanoid") then
                        character:FindFirstChildOfClass("Humanoid").Health = 0
                    end

                    -- Ждем пока полностью загрузится новый персонаж
                    repeat task.wait(0.2) until respawned
                end
            end)
        end
    end
end)
