-- Инициализация сервисов
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Удаление старого GUI, если скрипт перезапускается
if game.CoreGui:FindFirstChild("SquidGamePremiumHub") then
    game.CoreGui.SquidGamePremiumHub:Destroy()
end

-- Создание основы интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SquidGamePremiumHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- КРУГЛАЯ КНОПКА МЕНЮ
local ToggleButton = Instance.new("TextButton")
local UICorner_Toggle = Instance.new("UICorner")

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.BackgroundColor3 = Color3.fromRGB(241, 12, 114)
ToggleButton.Text = "⭕"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
ToggleButton.Active = true
ToggleButton.Draggable = true

UICorner_Toggle.CornerRadius = UDim.new(1, 0) -- Делает кнопку идеально круглой
UICorner_Toggle.Parent = ToggleButton

-- ГЛАВНОЕ ОКНО
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ContentFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 350)
MainFrame.Visible = false -- Скрыто по умолчанию
MainFrame.Active = true
MainFrame.Draggable = true

UICorner_Main.CornerRadius = UDim.new(0, 10)
UICorner_Main.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(241, 12, 114)
Title.Text = "SQUID HUB V3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

local UICorner_Title = Instance.new("UICorner")
UICorner_Title.CornerRadius = UDim.new(0, 10)
UICorner_Title.Parent = Title

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 5, 0, 45)
ContentFrame.Size = UDim2.new(1, -10, 1, -50)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 450)
ContentFrame.ScrollBarThickness = 4

UIListLayout.Parent = ContentFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Функция переключения видимости меню по круглой кнопке
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Функция создания элементов интерфейса
local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    btn.Parent = ContentFrame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createTextBox(placeholder, callback)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, 0, 0, 35)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    box.TextSize = 14
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = box
    box.Parent = ContentFrame
    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then callback(box.Text) end
    end)
    return box
end

-- ==================== ФУНКЦИОНАЛ СЦЕНАРИЯ ====================

-- 1. НАСТРАИВАЕМЫЙ СПИДХАК
local currentSpeed = 16
createTextBox("Введите скорость (напр. 50)", function(val)
    local num = tonumber(val)
    if num then
        currentSpeed = num
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = currentSpeed
end)

-- 2. СТЕКЛЯННЫЙ МОСТ (Подсветка безопасных стекол)
local espEnabled = false
local glassHighlights = {}

createButton("Подсветка Стекол (Вкл/Выкл)", function()
    espEnabled = not espEnabled
    if espEnabled then
        -- Сканирование карты на наличие прозрачных панелей/стекол
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("glass") or obj.Name:lower():find("tile") or obj.Name:lower():find("glasspanel")) then
                -- В большинстве плейсов фальшивое стекло имеет CanCollide = false или специфическое имя/прозрачность
                -- Чтобы подсветить правильные, проверяем их свойства (скрипт красит их в Зеленый, плохие в Красный)
                local highlight = Instance.new("BoxHandleAdornment")
                highlight.Size = obj.Size
                highlight.AlwaysOnTop = true
                highlight.ZIndex = 10
                highlight.Adornee = obj
                highlight.Parent = obj
                
                -- Логика определения (индивидуальна для плейсов, по умолчанию делим по наличию тача или имени)
                if obj:FindFirstChild("TouchInterest") or obj.Name:lower():find("fake") or obj.Size.Y < 0.5 then
                    highlight.Color3 = Color3.fromRGB(255, 0, 0) -- КРАСНОЕ (Опасное стекло)
                else
                    highlight.Color3 = Color3.fromRGB(0, 255, 0) -- ЗЕЛЕНОЕ (Безопасное)
                end
                table.insert(glassHighlights, highlight)
            end
        end
    else
        -- Очистка подсветки
        for _, h in ipairs(glassHighlights) do
            if h then h:Destroy() end
        end
        glassHighlights = {}
    end
end)

-- 3. ТАРГЕТ КИЛЛЕР (Убить и скинуть за карту)
local targetName = ""
createTextBox("Ник жертвы (можно неполный)", function(val)
    targetName = val:lower()
end)

createButton("Выкинуть жертву за карту", function()
    if targetName == "" then return end
    
    local targetPlayer = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():find(targetName) or (p.DisplayName and p.DisplayName:lower():find(targetName)) then
            if p ~= LocalPlayer then
                targetPlayer = p
                break
            end
        end
    end
    
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local targetRoot = targetPlayer.Character.HumanoidRootPart
        
        if myRoot and targetRoot then
            -- Запоминаем исходную позицию читера
            local oldCFrame = myRoot.CFrame
            
            -- Телепортируемся к жертве, жестко толкаем ее под карту в бездну
            for i = 1, 15 do
                task.wait(0.02)
                myRoot.CFrame = targetRoot.CFrame + Vector3.new(0, 2, 0)
                targetRoot.Velocity = Vector3.new(0, -500, 0) -- Импульс падения вниз
                targetRoot.CFrame = CFrame.new(targetRoot.Position.X, -500, targetRoot.Position.Z) -- Принудительный телепорт под текстуры
            end
            
            -- Возвращаемся обратно, чтобы администрация не заметила
            task.wait(0.1)
            myRoot.CFrame = oldCFrame
        end
    end
end)
