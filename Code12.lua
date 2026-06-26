-- БЛОК ИНИЦИАЛИЗАЦИИ И НАСТРОЕК
getgenv().TreasureAutoFarm = {
    Enabled = false,
    TeleportDelay = 1.5, -- Оптимальная задержка для обхода античита
    TimeBetweenRuns = 4
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- КРАСИВОЕ GUI С ПЕРЕТАСКИВАЕМОЙ КНОПКОЙ
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner_Btn = Instance.new("UICorner")
local MainMenu = Instance.new("Frame")
local UICorner_Menu = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local FarmToggleBtn = Instance.new("TextButton")
local UICorner_Farm = Instance.new("UICorner")

ScreenGui.Name = "BABFT_AutoFarm"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Круглая кнопка
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
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
MainMenu.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
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
Title.Text = "BUILD A BOAT FARM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

-- Кнопка включения фарма
FarmToggleBtn.Name = "FarmToggleBtn"
FarmToggleBtn.Parent = MainMenu
FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
FarmToggleBtn.Position = UDim2.new(0, 20, 0, 65)
FarmToggleBtn.Size = UDim2.new(1, -40, 0, 50)
FarmToggleBtn.Font = Enum.Font.GothamSemibold
FarmToggleBtn.Text = "Auto Farm: OFF"
FarmToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleBtn.TextSize = 16
UICorner_Farm.CornerRadius = UDim.new(0, 8)
UICorner_Farm.Parent = FarmToggleBtn

-- ЛОГИКА ДВИЖЕНИЯ КНОПКИ (Drag)
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

ToggleButton.MouseButton1Click:Connect(function() MainMenu.Visible = not MainMenu.Visible end)

-- Переключение режима фармы
FarmToggleBtn.MouseButton1Click:Connect(function()
    getgenv().TreasureAutoFarm.Enabled = not getgenv().TreasureAutoFarm.Enabled
    if getgenv().TreasureAutoFarm.Enabled then
        FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        FarmToggleBtn.Text = "Auto Farm: ON"
    else
        FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        FarmToggleBtn.Text = "Auto Farm: OFF"
    end
end)

-- СИСТЕМА ОБХОДА БЛОКИРОВОК (NoClip)
RunService.Stepped:Connect(function()
    if getgenv().TreasureAutoFarm.Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ИСПРАВЛЕННЫЙ АЛГОРИТМ АВТОФАРМА
local function startAutoFarm()
    local currentRun = 1
    while true do
        task.wait()
        if getgenv().TreasureAutoFarm.Enabled then
            pcall(function()
                local Character = LocalPlayer.Character
                if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
                local HRP = Character.HumanoidRootPart
                
                local NormalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                if not NormalStages then return end

                -- Безопасный пролет по всем стадиям
                for i = 1, 10 do
                    if not getgenv().TreasureAutoFarm.Enabled then break end
                    local Stage = NormalStages:FindFirstChild("CaveStage" .. i)
                    if Stage then
                        local DarknessPart = Stage:FindFirstChild("DarknessPart")
                        if DarknessPart then
                            -- Создаем платформу под ногами заранее, чтобы не провалиться
                            local TempPart = Instance.new("Part")
                            TempPart.Size = Vector3.new(10, 1, 10)
                            TempPart.Anchored = true
                            TempPart.Transparency = 1
                            TempPart.CFrame = DarknessPart.CFrame * CFrame.new(0, -4, 0)
                            TempPart.Parent = Workspace

                            -- Телепортируем тело
                            HRP.CFrame = DarknessPart.CFrame
                            HRP.Velocity = Vector3.new(0,0,0)
                            
                            task.wait(getgenv().TreasureAutoFarm.TeleportDelay)
                            TempPart:Destroy()
                        end
                    end
                end

                -- Летим к финалу (к сундуку)
                if getgenv().TreasureAutoFarm.Enabled and NormalStages:FindFirstChild("TheEnd") then
                    local Chest = NormalStages.TheEnd:FindFirstChild("GoldenChest")
                    if Chest and Chest:FindFirstChild("Trigger") then
                        HRP.CFrame = Chest.Trigger.CFrame
                        task.wait(2) -- Даем время серверу засчитать сундук
                    end
                end

                -- Ожидание респавна перед следующим кругом
                local Respawned = false
                local Connection
                Connection = LocalPlayer.CharacterAdded:Connect(function()
                    Respawned = true
                    Connection:Disconnect()
                end)

                -- Если персонаж застрял и не умер сам, обнуляем здоровье для респавна
                task.delay(5, function() 
                    if not Respawned and Character:FindFirstChildOfClass("Humanoid") then 
                        Character:FindFirstChildOfClass("Humanoid").Health = 0 
                    end 
                end)

                repeat task.wait(0.5) until Respawned
                task.wait(getgenv().TreasureAutoFarm.TimeBetweenRuns)
                currentRun = currentRun + 1
            end)
        end
    end
end

-- Запуск процесса в отдельном потоке
task.spawn(startAutoFarm)
