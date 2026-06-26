local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if game.CoreGui:FindFirstChild("SquidMobileDark") then
    game.CoreGui.SquidMobileDark:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SquidMobileDark"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local speedEnabled = false
local currentSpeed = 16
local selectedPlayer = ""

-- Маленькая темная кнопка-переключатель
local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0, 40, 0, 40)
Toggle.Position = UDim2.new(0.05, 0, 0.15, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
Toggle.Text = "S"
Toggle.TextColor3 = Color3.fromRGB(180, 180, 180)
Toggle.TextSize = 18
Toggle.Active = true
Toggle.Draggable = true
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)
Toggle.Parent = ScreenGui

-- Компактная серая панель
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 240)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
Frame.Visible = false
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)
Frame.Parent = ScreenGui

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -10, 1, -15)
Content.Position = UDim2.new(0, 5, 0, 10)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 0, 320)
Content.ScrollBarThickness = 0
Content.Parent = Frame

local Layout = Instance.new("UIListLayout")
Layout.Parent = Content
Layout.Padding = UDim.new(0, 8)

Toggle.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

local function styleElement(el)
    Instance.new("UICorner", el).CornerRadius = UDim.new(0, 6)
    el.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    el.TextColor3 = Color3.fromRGB(200, 200, 200)
    el.Font = Enum.Font.SourceSans
    el.TextSize = 14
end
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(1, 0, 0, 30)
SpeedBtn.Text = "Спидхак: ВЫКЛ"
styleElement(SpeedBtn)
SpeedBtn.Parent = Content

local Slider = Instance.new("TextButton")
Slider.Size = UDim2.new(1, 0, 0, 35)
styleElement(Slider)
Slider.Text = "Перетащи палец: Скорость 16"
Slider.Parent = Content

SpeedBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    SpeedBtn.Text = speedEnabled and "Спидхак: ВКЛ" or "Спидхак: ВЫКЛ"
    SpeedBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(45, 65, 45) or Color3.fromRGB(40, 40, 45)
end)

-- Сенсорное управление ползунком для телефонов
local function handleTouch(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        local relativeX = math.clamp((input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1)
        currentSpeed = math.floor(16 + (relativeX * 134)) -- Максимум 150 для защиты от кика
        Slider.Text = "Скорость: " .. currentSpeed
    end
end

Slider.InputBegan:Connect(handleTouch)
Slider.InputChanged:Connect(handleTouch)

-- Постоянное поддержание скорости без багов при спавне
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = speedEnabled and currentSpeed or 16
    end
end)
local Dropdown = Instance.new("TextButton")
Dropdown.Size = UDim2.new(1, 0, 0, 30)
Dropdown.Text = "Выбрать игрока"
styleElement(Dropdown)
Dropdown.Parent = Content

local DropFrame = Instance.new("Frame")
DropFrame.Size = UDim2.new(1, 0, 0, 0)
DropFrame.BackgroundTransparency = 1
DropFrame.ClipsDescendants = true
DropFrame.Parent = Content
Instance.new("UIListLayout", DropFrame).Padding = UDim.new(0, 3)

Dropdown.MouseButton1Click:Connect(function()
    for _, c in ipairs(DropFrame:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    local c = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            c = c + 1
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 25)
            b.Text = p.Name
            styleElement(b)
            b.Parent = DropFrame
            b.MouseButton1Click:Connect(function()
                selectedPlayer = p.Name
                Dropdown.Text = "Цель: " .. p.Name
                DropFrame.Size = UDim2.new(1, 0, 0, 0)
            end)
        end
    end
    DropFrame.Size = DropFrame.Size.Y.Offset == 0 and UDim2.new(1, 0, 0, math.min(c * 28, 90)) or UDim2.new(1, 0, 0, 0)
end)

local Kill = Instance.new("TextButton")
Kill.Size = UDim2.new(1, 0, 0, 35)
Kill.Text = "Выкинуть за карту"
styleElement(Kill)
Kill.BackgroundColor3 = Color3.fromRGB(70, 35, 35)
Kill.Parent = Content

Kill.MouseButton1Click:Connect(function()
    local tPlayer = Players:FindFirstChild(selectedPlayer)
    local myChar = LocalPlayer.Character
    local tChar = tPlayer and tPlayer.Character
    
    if myChar and tChar and myChar:FindFirstChild("HumanoidRootPart") and tChar:FindFirstChild("HumanoidRootPart") then
        local myRoot = myChar.HumanoidRootPart
        local tRoot = tChar.HumanoidRootPart
        local oldPos = myRoot.CFrame
        
        -- Смена угла хитбокса (новый мобильный обход флинга)
        local start = tick()
        while tick() - start < 1.0 do
            RunService.Heartbeat:Wait()
            if myRoot and tRoot then
                myRoot.Velocity = Vector3.new(0, -100, 0)
                -- Врезаемся боком на огромной скорости вращения
                myRoot.CFrame = tRoot.CFrame * CFrame.Angles(math.rad(90), 0, 0)
            end
        end
        
        -- Полная очистка инерции перед возвратом
        task.wait(0.05)
        myRoot.Velocity = Vector3.new(0, 0, 0)
        myRoot.RotVelocity = Vector3.new(0, 0, 0)
        myRoot.CFrame = oldPos
    end
end)

-- Подсветка стеклянного моста
local esp = false
local highlights = {}
local EspBtn = Instance.new("TextButton")
EspBtn.Size = UDim2.new(1, 0, 0, 30)
EspBtn.Text = "Стекла: ВЫКЛ"
styleElement(EspBtn)
EspBtn.Parent = Content

EspBtn.MouseButton1Click:Connect(function()
    esp = not esp
    EspBtn.Text = esp and "Стекла: ВКЛ" or "Стекла: ВЫКЛ"
    EspBtn.BackgroundColor3 = esp and Color3.fromRGB(45, 65, 45) or Color3.fromRGB(40, 40, 45)
    
    if esp then
        for _, o in ipairs(workspace:GetDescendants()) do
            if o:IsA("BasePart") and (o.Name:lower():find("glass") or o.Name:lower():find("tile")) then
                local h = Instance.new("BoxHandleAdornment")
                h.Size = o.Size + Vector3.new(0.1, 0.1, 0.1)
                h.AlwaysOnTop = true
                h.Adornee = o
                h.Parent = o
                h.Color3 = (o.CanCollide == false or o.Name:lower():find("fake")) and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(50, 200, 50)
                table.insert(highlights, h)
            end
        end
    else
        for _, h in ipairs(highlights) do if h then h:Destroy() end end
        highlights = {}
    end
end)
