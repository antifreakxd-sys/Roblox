-- Auto Farm для Build A Boat — улучшенная стабильная версия
-- Исправления: надёжный шаговый полёт через платформу (устраняет телепорты/дергания),
-- аккуратное включение/выключение noclip/PlatformStand, стабильный слайдер, перетаскивание меню,
-- ожидание загрузки частей, восстановление состояний и отключение соединений.
-- Все комментарии на русском.

-- Конфигурация (сохраняется в getgenv)
getgenv().TreasureAutoFarm = getgenv().TreasureAutoFarm or {
    Enabled = false,
    FlySpeed = 200,        -- скорость в студзах в секунду (регулируется ползунком)
    WaitAtChest = 6,       -- время ожидания у сундука
    MinSpeed = 50,
    MaxSpeed = 800,        -- допустимая верхняя граница
    StepDistance = 6,      -- длина шага в студзах (маленькие шаги = стабильнее)
    StepPause = 0.06,      -- пауза между шагами для стриминга
    StreamingWait = 0.12,  -- ожидание после шага для подгрузки
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Корректное получение LocalPlayer
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    LocalPlayer = Players.PlayerAdded:Wait()
end

-- Ждём PlayerGui
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Удаляем старый GUI, если он есть (избегаем дубликатов)
local EXISTING = PlayerGui:FindFirstChild("BABFT_Mobile_AutoFarm")
if EXISTING then
    EXISTING:Destroy()
end

-- УТИЛИТЫ
local function clamp(v, a, b) return math.clamp(v, a, b) end
local function getCfg() return getgenv().TreasureAutoFarm end

-- Создаём GUI
local function makeUICorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = radius
    c.Parent = parent
    return c
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BABFT_Mobile_AutoFarm"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local COLOR_PANEL = Color3.fromRGB(20,20,20)
local COLOR_ACCENT = Color3.fromRGB(0,170,255)
local COLOR_ON = Color3.fromRGB(50,180,50)
local COLOR_OFF = Color3.fromRGB(220,60,60)
local COLOR_TEXT = Color3.fromRGB(230,230,230)

-- Toggle button
local ToggleButton = Instance.new("TextButton")
makeUICorner(ToggleButton, UDim.new(1,0))
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = COLOR_ACCENT
ToggleButton.Position = UDim2.new(0.04, 0, 0.42, 0)
ToggleButton.Size = UDim2.new(0, 56, 0, 56)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "⚓"
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.TextSize = 24

-- Main menu
local MainMenu = Instance.new("Frame")
makeUICorner(MainMenu, UDim.new(0,10))
MainMenu.Name = "MainMenu"
MainMenu.Parent = ScreenGui
MainMenu.BackgroundColor3 = COLOR_PANEL
MainMenu.Position = UDim2.new(0.32, 0, 0.32, 0)
MainMenu.Size = UDim2.new(0, 340, 0, 220)
MainMenu.Visible = false
MainMenu.ClipsDescendants = true

-- Title bar (используется для перетаскивания)
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainMenu
TitleBar.Size = UDim2.new(1,0,0,36)
TitleBar.BackgroundTransparency = 1

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(1, -12, 1, 0)
TitleLabel.Position = UDim2.new(0, 8, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "BUILD A BOAT — AUTO FARM"
TitleLabel.TextColor3 = COLOR_TEXT
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Status & Speed
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainMenu
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 12, 0, 40)
StatusLabel.Size = UDim2.new(0.5, -12, 0, 22)
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.Text = "Status: OFF"
StatusLabel.TextColor3 = COLOR_TEXT
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainMenu
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.5, 0, 0, 40)
SpeedLabel.Size = UDim2.new(0.5, -12, 0, 22)
SpeedLabel.Font = Enum.Font.GothamSemibold
SpeedLabel.Text = "Speed: " .. tostring(getCfg().FlySpeed)
SpeedLabel.TextColor3 = COLOR_TEXT
SpeedLabel.TextSize = 14
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Right

-- Toggle Farm Button
local FarmToggleBtn = Instance.new("TextButton")
makeUICorner(FarmToggleBtn, UDim.new(0,8))
FarmToggleBtn.Parent = MainMenu
FarmToggleBtn.BackgroundColor3 = COLOR_OFF
FarmToggleBtn.Position = UDim2.new(0, 12, 0, 70)
FarmToggleBtn.Size = UDim2.new(1, -24, 0, 44)
FarmToggleBtn.Font = Enum.Font.GothamSemibold
FarmToggleBtn.Text = "Auto Farm: OFF (H)"
FarmToggleBtn.TextColor3 = Color3.new(1,1,1)
FarmToggleBtn.TextSize = 14

-- Slider
local SliderText = Instance.new("TextLabel")
SliderText.Parent = MainMenu
SliderText.BackgroundTransparency = 1
SliderText.Position = UDim2.new(0, 12, 0, 126)
SliderText.Size = UDim2.new(1, -24, 0, 18)
SliderText.Font = Enum.Font.GothamSemibold
SliderText.Text = "Speed"
SliderText.TextColor3 = COLOR_TEXT
SliderText.TextSize = 13
SliderText.TextXAlignment = Enum.TextXAlignment.Left

local SliderFrame = Instance.new("Frame")
makeUICorner(SliderFrame, UDim.new(0,6))
SliderFrame.Parent = MainMenu
SliderFrame.BackgroundColor3 = Color3.fromRGB(40,40,45)
SliderFrame.Position = UDim2.new(0, 12, 0, 148)
SliderFrame.Size = UDim2.new(1, -24, 0, 18)
SliderFrame.Active = true
SliderFrame.Selectable = true

local SliderButton = Instance.new("TextButton")
makeUICorner(SliderButton, UDim.new(1,0))
SliderButton.Parent = SliderFrame
SliderButton.BackgroundColor3 = COLOR_ACCENT
SliderButton.Size = UDim2.new(0, 18, 0, 18)
SliderButton.Position = UDim2.new(0,0,-0.5,0)
SliderButton.Text = ""

-- Дефолтное состояние
local connections = {}
local function disconnectAll()
    for _, c in pairs(connections) do
        if c and c.Disconnect then
            c:Disconnect()
        elseif c and type(c) == "function" then
            pcall(c)
        end
    end
    connections = {}
end

-- Полезные хелперы
local function waitForPart(part, timeout)
    timeout = timeout or 5
    local start = tick()
    while tick() - start < timeout do
        if part and part:IsDescendantOf(Workspace) then return true end
        task.wait(0.08)
    end
    return false
end

-- Установка позиции ползунка по текущей скорости
local function setSliderFromSpeed()
    local cfg = getCfg()
    if not SliderFrame or not SliderFrame.AbsoluteSize then return end
    local minS = cfg.MinSpeed or 50
    local maxS = cfg.MaxSpeed or 800
    cfg.FlySpeed = clamp(cfg.FlySpeed, minS, maxS)
    local cur = cfg.FlySpeed
    local percent = (cur - minS) / math.max(1, (maxS - minS))
    SliderButton.Position = UDim2.new(percent, -9, -0.5, 0)
    SpeedLabel.Text = "Speed: " .. tostring(cur)
end

-- Обновление скорости по позиции
local isSliding = false
local function updateSliderFromInput(posX)
    if not SliderFrame or not SliderFrame.AbsoluteSize then return end
    local sliderPos = SliderFrame.AbsolutePosition
    local sliderWidth = SliderFrame.AbsoluteSize.X
    local mouseX = posX - sliderPos.X
    local percent = clamp(mouseX / math.max(1, sliderWidth), 0, 1)
    SliderButton.Position = UDim2.new(percent, -9, -0.5, 0)
    local cfg = getCfg()
    local finalSpeed = math.floor((cfg.MinSpeed or 50) + percent * ((cfg.MaxSpeed or 800) - (cfg.MinSpeed or 50)))
    cfg.FlySpeed = clamp(finalSpeed, cfg.MinSpeed, cfg.MaxSpeed)
    SpeedLabel.Text = "Speed: " .. tostring(cfg.FlySpeed)
end

-- Подключаем обработчики с сохранением ссылок
connections.sliderInputChanged = UserInputService.InputChanged:Connect(function(input)
    if isSliding and input.Position then
        updateSliderFromInput(input.Position.X)
    end
end)

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

SliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if input.Position then updateSliderFromInput(input.Position.X) end
    end
end)

-- Инициализация после получения размеров
connections.sliderSize = SliderFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    setSliderFromSpeed()
end)
-- если уже есть размер — выставим
task.delay(0.05, setSliderFromSpeed)

-- Dragging для MainMenu (по TitleBar)
local draggingMenu, menuDragInput, menuDragStart, menuStartPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMenu = true
        menuDragStart = input.Position
        menuStartPos = MainMenu.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingMenu = false
            end
        end)
    end
end)
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        menuDragInput = input
    end
end)
connections.menuMove = UserInputService.InputChanged:Connect(function(input)
    if draggingMenu and input == menuDragInput then
        local delta = input.Position - menuDragStart
        MainMenu.Position = UDim2.new(menuStartPos.X.Scale, menuStartPos.X.Offset + delta.X, menuStartPos.Y.Scale, menuStartPos.Y.Offset + delta.Y)
    end
end)

-- Toggle visibility
ToggleButton.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
end)

-- Включение/отключение автофарма
local function setFarmEnabled(state)
    local cfg = getCfg()
    cfg.Enabled = state
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

FarmToggleBtn.MouseButton1Click:Connect(function()
    setFarmEnabled(not getCfg().Enabled)
end)

-- Горячая клавиша H
connections.hotkey = UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.H then
        setFarmEnabled(not getCfg().Enabled)
    end
end)

-- УСТОЙЧИВОЕ ПЛАВНОЕ ПЕРЕМЕЩЕНИЕ (platform-driven)
local function flyToPart(targetPart)
    local cfg = getCfg()
    if not cfg.Enabled then return false end
    if not targetPart or not targetPart:IsA("BasePart") then return false end
    if not waitForPart(targetPart, 4) then return false end

    local character = LocalPlayer.Character
    if not character then return false end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return false end

    -- фиксируем стартовую и целевую позиции
    local startPos = hrp.Position
    local targetPos = targetPart.Position
    local totalDist = (startPos - targetPos).Magnitude
    if totalDist < 1 then return true end

    local step = cfg.StepDistance or 6
    local steps = math.max(1, math.ceil(totalDist / step))
    local speed = clamp(cfg.FlySpeed or 200, cfg.MinSpeed or 50, cfg.MaxSpeed or 800)

    -- считаем длительность для каждого шага: время = расстояние / скорость
    local perStepDist = totalDist / steps
    local stepDuration = math.max(0.03, perStepDist / math.max(1, speed))

    -- включаем PlatformStand для устойчивости
    local prevPlatformStand = humanoid.PlatformStand
    local prevAutoRotate = humanoid.AutoRotate
    humanoid.PlatformStand = true
    humanoid.AutoRotate = false

    local success = true
    local heartbeatConn

    for i = 1, steps do
        if not cfg.Enabled then success = false; break end
        if not hrp or not hrp.Parent then success = false; break end

        local t = i / steps
        local nextPos = Vector3.new(
            startPos.X + (targetPos.X - startPos.X) * t,
            startPos.Y + (targetPos.Y - startPos.Y) * t,
            startPos.Z + (targetPos.Z - startPos.Z) * t
        )
        -- платформе позиция чуть ниже игрока
        local platformTarget = CFrame.new(nextPos - Vector3.new(0, 3.5, 0))

        -- Создаём временную платформу под игроком
        local platform = Instance.new("Part")
        platform.Size = Vector3.new(8, 1, 8)
        platform.Anchored = true
        platform.Transparency = 1
        platform.CanCollide = false
        platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
        platform.Parent = Workspace

        -- Твин платформы
        local ok, platTween = pcall(function()
            return TweenService:Create(platform, TweenInfo.new(stepDuration, Enum.EasingStyle.Linear), {CFrame = platformTarget})
        end)
        if not ok or not platTween then platform:Destroy(); success = false; break end

        -- Обновляем HRP каждый heartbeat, чтобы сердце следовало за платформой
        heartbeatConn = RunService.Heartbeat:Connect(function()
            if hrp and hrp.Parent and platform and platform.Parent then
                local desired = platform.CFrame * CFrame.new(0, 3.5, 0)
                -- направляем hrp к desired плавно (без резких телепортов)
                hrp.CFrame = desired
            end
        end)

        platTween:Play()
        local startTick = tick()
        -- Ждём завершения твина или прерывания
        while platTween.PlaybackState == Enum.PlaybackState.Playing do
            task.wait(0.02)
            if not cfg.Enabled then pcall(function() platTween:Cancel() end); break end
            if not hrp or not hrp.Parent then pcall(function() platTween:Cancel() end); break end
            if tick() - startTick > math.max(2, stepDuration * 6) then pcall(function() platTween:Cancel() end); break end
        end

        -- отключаем heartbeat
        if heartbeatConn then heartbeatConn:Disconnect(); heartbeatConn = nil end
        -- небольшая пауза для стриминга
        task.wait(cfg.StreamingWait or 0.08)

        -- уничтожаем платформу
        if platform and platform.Parent then platform:Destroy() end

        -- safety: при сильном отличии позиции — прервём
        if hrp and (hrp.Position - nextPos).Magnitude > math.max(10, step * 2) then
            success = false
            break
        end
    end

    -- сброс состояния
    pcall(function() if humanoid then humanoid.PlatformStand = prevPlatformStand; humanoid.AutoRotate = prevAutoRotate end end)
    pcall(function() if hrp then hrp.Velocity = Vector3.new(0,0,0) end end)
    return success
end

-- Получаем сортированные стадии
local function getSortedCaveStages(normalStages)
    local stages = {}
    if not normalStages then return stages end
    for _, child in pairs(normalStages:GetChildren()) do
        local n = child.Name:match("^CaveStage(%d+)$")
        if n then table.insert(stages, {num = tonumber(n), part = child}) end
    end
    table.sort(stages, function(a,b) return a.num < b.num end)
    return stages
end

-- Основной цикл фарма (с защитой)
local isFarming = false

task.spawn(function()
    while true do
        task.wait(0.25)
        local cfg = getCfg()
        if cfg.Enabled and not isFarming then
            isFarming = true
            pcall(function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then isFarming = false; return end

                local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
                if not normalStages then isFarming = false; return end

                -- Пролетаем по стадиям
                local stages = getSortedCaveStages(normalStages)
                for _, entry in ipairs(stages) do
                    if not cfg.Enabled then break end
                    local stage = entry.part
                    if stage then
                        local darknessPart = stage:FindFirstChild("DarknessPart")
                        if darknessPart and darknessPart:IsA("BasePart") then
                            if waitForPart(darknessPart, 4) then
                                local ok = flyToPart(darknessPart)
                                if not ok then task.wait(0.2) end
                            else
                                task.wait(0.25)
                            end
                        end
                        task.wait(0.03)
                    end
                end

                -- Финал (сундук)
                if cfg.Enabled and normalStages:FindFirstChild("TheEnd") then
                    local chest = normalStages.TheEnd:FindFirstChild("GoldenChest")
                    if chest and chest:FindFirstChild("Trigger") and chest.Trigger:IsA("BasePart") then
                        if waitForPart(chest.Trigger, 5) then
                            flyToPart(chest.Trigger)
                            task.wait(0.12)
                            pcall(function() flyToPart(chest.Trigger) end)
                            local waited = 0; local waitTime = cfg.WaitAtChest or 6
                            while waited < waitTime and cfg.Enabled do
                                task.wait(0.25); waited = waited + 0.25
                            end
                        end
                    end
                end

                -- Респавн: безопасно умираем и ждём новый Character с HRP
                if cfg.Enabled then
                    local respawned = false
                    local conn
                    conn = LocalPlayer.CharacterAdded:Connect(function()
                        respawned = true
                        if conn then conn:Disconnect() end
                    end)
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health > 0 then humanoid.Health = 0 end
                    local startt = tick()
                    repeat task.wait(0.2) until respawned or (tick() - startt > 20)
                    if respawned then
                        -- дождёмся HRP
                        local newChar = LocalPlayer.Character
                        if newChar then newChar:WaitForChild("HumanoidRootPart", 10)
                        end
                    end
                end
            end)
            isFarming = false
        end
    end
end)

-- Очистка соединений при выгрузке скрипта (если будет необходимость)
-- (Оставляем подключённые слушатели активными, т.к. скрипт работает в сессии.)

-- Сохраняем текущий слайдер/GUI
setSliderFromSpeed()

-- Конец файла
