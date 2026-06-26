-- Улучшенная версия Auto Farm для Build A Boat (русские комментарии)
-- Что сделано:
-- 1) Шаговый (покадровый) flyTo — не "перескакивает" через зоны, даём время на стриминг частей.
-- 2) Слайдер исправлен: инициализация позиции, клики по дорожке, сенсорные события.
-- 3) Увеличен maxSpeed, адаптация логики под высокие скорости.
-- 4) Hotkey H — включение/выключение фарма.
-- 5) GUI в чёрном стиле, статус и скорость отображаются.
-- 6) Защита от наложения (isFarming), отмена твинов при смерти/репавне, таймауты.
-- 7) Много проверок существования объектов и безопасное удаление временных частей.

-- НАСТРОЙКИ АВТОФАРМА (сохраняются в getgenv)
getgenv().TreasureAutoFarm = getgenv().TreasureAutoFarm or {
    Enabled = false,
    FlySpeed = 200,        -- начальная скорость (можно менять ползунком)
    WaitAtChest = 6,       -- время ожидания у сундука
    MinSpeed = 50,
    MaxSpeed = 600,        -- увеличенная максимальная скорость
    StepDistance = 12      -- максимальная длина шага при перемещении (в студиях)
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Ждём игрока и PlayerGui
if not LocalPlayer then
    LocalPlayer = Players:WaitForChild("LocalPlayer")
end
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Утилиты для GUI
local function makeUICorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = radius
    c.Parent = parent
    return c
end

-- Основной ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BABFT_Mobile_AutoFarm"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Стильные цвета
local COLOR_BG = Color3.fromRGB(18, 18, 18)       -- чёрный фон
local COLOR_PANEL = Color3.fromRGB(28, 28, 30)
local COLOR_ACCENT = Color3.fromRGB(0, 170, 255)
local COLOR_ON = Color3.fromRGB(50, 180, 50)
local COLOR_OFF = Color3.fromRGB(220, 60, 60)
local COLOR_TEXT = Color3.fromRGB(230, 230, 230)

-- Кнопка открытия
local ToggleButton = Instance.new("TextButton")
makeUICorner(ToggleButton, UDim.new(1,0))
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = COLOR_ACCENT
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "⚓"
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.TextSize = 24

-- Главное меню
local MainMenu = Instance.new("Frame")
makeUICorner(MainMenu, UDim.new(0,12))
MainMenu.Name = "MainMenu"
MainMenu.Parent = ScreenGui
MainMenu.BackgroundColor3 = COLOR_PANEL
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.Size = UDim2.new(0, 320, 0, 220)
MainMenu.Visible = false

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainMenu
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "BUILD A BOAT — AUTO FARM"
Title.TextColor3 = COLOR_TEXT
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 12, 0, 6)

-- Статус (ON/OFF) и индикация скорости
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainMenu
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 12, 0, 44)
StatusLabel.Size = UDim2.new(0.5, -12, 0, 24)
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.Text = "Status: OFF"
StatusLabel.TextColor3 = COLOR_TEXT
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Name = "SpeedLabel"
SpeedLabel.Parent = MainMenu
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.5, 0, 0, 44)
SpeedLabel.Size = UDim2.new(0.5, -12, 0, 24)
SpeedLabel.Font = Enum.Font.GothamSemibold
SpeedLabel.Text = "Speed: " .. tostring(getgenv().TreasureAutoFarm.FlySpeed)
SpeedLabel.TextColor3 = COLOR_TEXT
SpeedLabel.TextSize = 14
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Right

-- Кнопка вкл/выкл фарма
local FarmToggleBtn = Instance.new("TextButton")
makeUICorner(FarmToggleBtn, UDim.new(0,8))
FarmToggleBtn.Name = "FarmToggleBtn"
FarmToggleBtn.Parent = MainMenu
FarmToggleBtn.BackgroundColor3 = COLOR_OFF
FarmToggleBtn.Position = UDim2.new(0, 12, 0, 76)
FarmToggleBtn.Size = UDim2.new(1, -24, 0, 42)
FarmToggleBtn.Font = Enum.Font.GothamSemibold
FarmToggleBtn.Text = "Auto Farm: OFF (H)"
FarmToggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
FarmToggleBtn.TextSize = 15

-- Ползунок скорости: дорожка и кнопка
local SliderText = Instance.new("TextLabel")
SliderText.Name = "SliderText"
SliderText.Parent = MainMenu
SliderText.BackgroundTransparency = 1
SliderText.Position = UDim2.new(0, 12, 0, 128)
SliderText.Size = UDim2.new(1, -24, 0, 18)
SliderText.Font = Enum.Font.GothamSemibold
SliderText.Text = "Speed"
SliderText.TextColor3 = COLOR_TEXT
SliderText.TextSize = 13
SliderText.TextXAlignment = Enum.TextXAlignment.Left

local SliderFrame = Instance.new("Frame")
makeUICorner(SliderFrame, UDim.new(0,6))
SliderFrame.Name = "SliderFrame"
SliderFrame.Parent = MainMenu
SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
SliderFrame.Position = UDim2.new(0, 12, 0, 150)
SliderFrame.Size = UDim2.new(1, -24, 0, 18)

local SliderButton = Instance.new("TextButton")
makeUICorner(SliderButton, UDim.new(1,0))
SliderButton.Name = "SliderButton"
SliderButton.Parent = SliderFrame
SliderButton.BackgroundColor3 = COLOR_ACCENT
SliderButton.Position = UDim2.new(0, 0, -0.5, 0)
SliderButton.Size = UDim2.new(0, 18, 0, 18)
SliderButton.Text = ""

-- Функции конфигурации
local function getCfg() return getgenv().TreasureAutoFarm end

-- Установка позиции ползунка по текущей скорости
local function setSliderFromSpeed()
    local cfg = getCfg()
    if not SliderFrame then return end
    local minS = cfg.MinSpeed or 50
    local maxS = cfg.MaxSpeed or 600
    local cur = math.clamp(cfg.FlySpeed or 100, minS, maxS)
    local percent = (cur - minS) / math.max(1, (maxS - minS))
    SliderButton.Position = UDim2.new(percent, -9, -0.5, 0)
    SpeedLabel.Text = "Speed: " .. tostring(cur)
end

-- Обновление скорости по позиции мыши/касания
local isSliding = false
local function updateSliderFromInput(posX)
    if not SliderFrame or not SliderFrame.AbsoluteSize then return end
    local sliderPos = SliderFrame.AbsolutePosition
    local sliderWidth = SliderFrame.AbsoluteSize.X
    local mouseX = posX - sliderPos.X
    local percent = math.clamp(mouseX / sliderWidth, 0, 1)
    SliderButton.Position = UDim2.new(percent, -9, -0.5, 0)
    local cfg = getCfg()
    local finalSpeed = math.floor((cfg.MinSpeed or 50) + percent * ((cfg.MaxSpeed or 600) - (cfg.MinSpeed or 50)))
    cfg.FlySpeed = finalSpeed
    SpeedLabel.Text = "Speed: " .. tostring(finalSpeed)
end

-- Подключаем клики и перетаскивание для ползунка
SliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = true
        if input.Position then updateSliderFromInput(input.Position.X) end
    end
end)
SliderButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = false
    end
end)
-- Дорожка реагирует на нажатие (клик по дорожке)
SliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if input.Position then updateSliderFromInput(input.Position.X) end
    end
end)
-- Слежение за движением мыши/касания
UserInputService.InputChanged:Connect(function(input)
    if isSliding and input.Position then
        updateSliderFromInput(input.Position.X)
    end
end)

-- Инициализация позиции ползунка через пару тиков (чтобы AbsoluteSize заполнился)
task.delay(0.1, setSliderFromSpeed)

-- Drag для ToggleButton (перетаскивание на экране)
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

-- Переключение фарма (кнопка)
FarmToggleBtn.MouseButton1Click:Connect(function()
    local cfg = getCfg()
    cfg.Enabled = not cfg.Enabled
    if cfg.Enabled then
        FarmToggleBtn.BackgroundColor3 = COLOR_ON
        FarmToggleBtn.Text = "Auto Farm: ON (H)"
        StatusLabel.Text = "Status: ON"
    else
        FarmToggleBtn.BackgroundColor3 = COLOR_OFF
        FarmToggleBtn.Text = "Auto Farm: OFF (H)"
        StatusLabel.Text = "Status: OFF"
    end
end)

-- Горячая клавиша H для включения/выключения
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        local cfg = getCfg()
        cfg.Enabled = not cfg.Enabled
        if cfg.Enabled then
            FarmToggleBtn.BackgroundColor3 = COLOR_ON
            FarmToggleBtn.Text = "Auto Farm: ON (H)"
            StatusLabel.Text = "Status: ON"
        else
            FarmToggleBtn.BackgroundColor3 = COLOR_OFF
            FarmToggleBtn.Text = "Auto Farm: OFF (H)"
            StatusLabel.Text = "Status: OFF"
        end
    end
end)

-- NOCLIP: применяем только при включённом режиме, и только к коллидируемым деталям
RunService.Heartbeat:Connect(function()
    local cfg = getCfg()
    if cfg.Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- Хелперы для безопасного ожидания частей/стриминга
local function waitForPart(part, timeout)
    timeout = timeout or 5
    local start = tick()
    while tick() - start < timeout do
        if part and part.Parent then return true end
        task.wait(0.1)
    end
    return false
end

-- Шаговый flyTo: разбиваем путь на маленькие твины, даём время на стриминг между шагами
local function flyToPart(targetPart)
    local cfg = getCfg()
    if not cfg.Enabled then return false end
    if not targetPart or not targetPart:IsA("BasePart") then return false end
    if not waitForPart(targetPart, 4) then return false end

    local character = LocalPlayer.Character
    if not character then return false end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    -- Целевая позиция: немного над триггером (чтобы сработать касание)
    local targetCFrame = targetPart.CFrame
    local targetPos = targetCFrame.Position

    local distance = (hrp.Position - targetPos).Magnitude
    if distance < 1 then
        -- уже рядом
        return true
    end

    -- Разбиваем на шаги по StepDistance
    local maxStep = cfg.StepDistance or 12
    local steps = math.max(1, math.ceil(distance / maxStep))
    local totalDuration = math.max(0.05, distance / math.max(1, cfg.FlySpeed or 200))
    local stepDuration = totalDuration / steps

    -- safety connections
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local diedConn
    if humanoid then
        diedConn = humanoid.Died:Connect(function()
            -- ничего: просто шаги остановятся по проверкам ниже
        end)
    end

    local success = true
    for i = 1, steps do
        if not cfg.Enabled then success = false; break end
        if not hrp or not hrp.Parent then success = false; break end
        -- вычисляем промежуточную точку
        local t = i / steps
        local interp = hrp.CFrame:Lerp(CFrame.new(targetPos), t)
        -- чуть выше цели, чтобы не залипать в земле
        local desiredCFrame = CFrame.new(interp.Position + Vector3.new(0, 2, 0), targetPos)
        -- создаём короткий твин
        local ok, tween = pcall(function()
            return TweenService:Create(hrp, TweenInfo.new(math.max(0.02, stepDuration), Enum.EasingStyle.Linear), {CFrame = desiredCFrame})
        end)
        if not ok or not tween then
            success = false
            break
        end

        tween:Play()
        local startTick = tick()
        while tween.PlaybackState == Enum.PlaybackState.Playing do
            task.wait(0.03)
            -- прерывания
            if not cfg.Enabled then
                pcall(function() tween:Cancel() end)
                success = false
                break
            end
            -- если HRP удалён (репавн), прервём
            if not hrp or not hrp.Parent then
                pcall(function() tween:Cancel() end)
                success = false
                break
            end
            -- safety timeout per step
            if tick() - startTick > math.max(1, stepDuration * 4) then
                pcall(function() tween:Cancel() end)
                break
            end
        end
        if not success then break end
        -- даём немного времени на стриминг ближайших частей
        task.wait(0.06)
    end

    -- Сброс скорости/импульса
    pcall(function() if hrp then hrp.Velocity = Vector3.new(0,0,0) end end)
    if diedConn then diedConn:Disconnect() end
    return success
end

-- Вспомогательная: собрать отсортированные CaveStage
local function getSortedCaveStages(normalStages)
    local stages = {}
    if not normalStages then return stages end
    for _, child in pairs(normalStages:GetChildren()) do
        local n = child.Name:match("^CaveStage(%d+)$")
        if n then
            table.insert(stages, {num = tonumber(n), part = child})
        end
    end
    table.sort(stages, function(a,b) return a.num < b.num end)
    return stages
end

-- Защита от наложения
local isFarming = false

-- Основной цикл фарма
task.spawn(function()
    while true do
        task.wait(0.35)
        local cfg = getCfg()
        if cfg.Enabled and not isFarming then
            isFarming = true
            pcall(function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then isFarming = false; return end

                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                if not normalStages then isFarming = false; return end

                -- Получаем сортированные стадии
                local stages = getSortedCaveStages(normalStages)
                for _, entry in ipairs(stages) do
                    if not cfg.Enabled then break end
                    local stage = entry.part
                    if stage then
                        local darknessPart = stage:FindFirstChild("DarknessPart")
                        if darknessPart and darknessPart:IsA("BasePart") then
                            -- Ждём подгрузки части и пытаемся плавно подлететь
                            if waitForPart(darknessPart, 3) then
                                flyToPart(darknessPart)
                            else
                                -- если не подгрузилось — даём чуть больше времени
                                task.wait(0.2)
                            end
                            task.wait(0.04)
                        end
                    end
                end

                -- Финал (сундук)
                if cfg.Enabled and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    if chest and chest:FindFirstChild("Trigger") and chest.Trigger:IsA("BasePart") then
                        -- подлетаем к триггеру сундука, сначала чуть выше, потом на точку
                        if waitForPart(chest.Trigger, 4) then
                            flyToPart(chest.Trigger)
                            -- дополнительно подвинуться точнее чтобы сработал триггер
                            task.wait(0.15)
                            pcall(function() flyToPart(chest.Trigger) end)
                            -- ждём заданное время у сундука
                            local waited = 0; local waitTime = cfg.WaitAtChest or 6
                            while waited < waitTime and cfg.Enabled do
                                task.wait(0.25)
                                waited = waited + 0.25
                            end
                        end
                    end
                end

                -- Респавн: безопасно убиваем персонажа и ждём CharacterAdded
                if cfg.Enabled then
                    local respawned = false
                    local connection
                    connection = LocalPlayer.CharacterAdded:Connect(function()
                        respawned = true
                        if connection then connection:Disconnect() end
                    end)
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        -- безопасное убийство
                        humanoid.Health = 0
                    end
                    local timeout = 15
                    local startt = tick()
                    repeat task.wait(0.2) until respawned or (tick() - startt > timeout)
                end
            end)
            isFarming = false
        end
    end
end)

-- Конец скрипта
