local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

if game.CoreGui:FindFirstChild("SquidPremiumV4") then
    game.CoreGui.SquidPremiumV4:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SquidPremiumV4"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local speedHackEnabled = false
local targetSpeed = 16
local selectedPlayerName = ""

-- КРУГЛАЯ КНОПКА
local ToggleButton = Instance.new("TextButton")
local UICorner_Toggle = Instance.new("UICorner")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.BackgroundColor3 = Color3.fromRGB(241, 12, 114)
ToggleButton.Text = "🦑"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 26
ToggleButton.Active = true
ToggleButton.Draggable = true
UICorner_Toggle.CornerRadius = UDim.new(1, 0)
UICorner_Toggle.Parent = ToggleButton

-- ГЛАВНОЕ ОКНО
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Content = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
UICorner_Main.CornerRadius = UDim.new(0, 12)
UICorner_Main.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(241, 12, 114)
Title.Text = "SQUID PREMIUM V4"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold

Content.Name = "Content"
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 10, 0, 55)
Content.Size = UDim2.new(1, -20, 1, -65)
Content.CanvasSize = UDim2.new(0, 0, 0, 550)
Content.ScrollBarThickness = 2

UIListLayout.Parent = Content
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

local menuOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    local targetSize = menuOpen and UDim2.new(0, 280, 0, 380) or UDim2.new(0, 0, 0, 0)
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize})
    tween:Play()
end)

local function applyStyle(element, isButton)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = element
    element.BackgroundColor3 = isButton and Color3.fromRGB(32, 32, 42) or Color3.fromRGB(25, 25, 33)
    if element:IsA("TextButton") or element:IsA("TextLabel") then
        element.TextColor3 = Color3.fromRGB(240, 240, 245)
        element.Font = Enum.Font.GothamMedium
    end
end
local SpeedToggleBtn = Instance.new("TextButton")
SpeedToggleBtn.Size = UDim2.new(1, 0, 0, 35)
SpeedToggleBtn.Text = "Включить спидхак: ВЫКЛ"
applyStyle(SpeedToggleBtn, true)
SpeedToggleBtn.Parent = Content

local SliderFrame = Instance.new("Frame")
SliderFrame.Size = UDim2.new(1, 0, 0, 45)
applyStyle(SliderFrame, false)
SliderFrame.Parent = Content

local SliderLabel = Instance.new("TextLabel")
SliderLabel.Size = UDim2.new(1, 0, 0, 20)
SliderLabel.BackgroundTransparency = 1
SliderLabel.Text = "Скорость: 16"
SliderLabel.TextSize = 12
applyStyle(SliderLabel, false)
SliderLabel.Parent = SliderFrame

local SliderBar = Instance.new("TextButton")
SliderBar.Size = UDim2.new(0.9, 0, 0, 6)
SliderBar.Position = UDim2.new(0.05, 0, 0.65, 0)
SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
SliderBar.Text = ""
Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(1, 0)
SliderBar.Parent = SliderFrame

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(241, 12, 114)
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
SliderFill.Parent = SliderBar

SpeedToggleBtn.MouseButton1Click:Connect(function()
    speedHackEnabled = not speedHackEnabled
    SpeedToggleBtn.Text = speedHackEnabled and "Включить спидхак: ВКЛ" or "Включить спидхак: ВЫКЛ"
    SpeedToggleBtn.BackgroundColor3 = speedHackEnabled and Color3.fromRGB(46, 117, 89) or Color3.fromRGB(32, 32, 42)
    
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = speedHackEnabled and targetSpeed or 16
    end
end)

local function updateSlider(input)
    local percentage = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
    SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
    targetSpeed = math.floor(16 + (percentage * 184))
    SliderLabel.Text = "Скорость: " .. targetSpeed
    
    if speedHackEnabled then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = targetSpeed end
    end
end

local draggingSlider = false
SliderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = true end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(input) end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    RunService.RenderStepped:Wait()
    hum.WalkSpeed = speedHackEnabled and targetSpeed or 16
end)
local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Size = UDim2.new(1, 0, 0, 35)
DropdownBtn.Text = "Выбрать игрока: [ Нажмите ]"
applyStyle(DropdownBtn, true)
DropdownBtn.Parent = Content

local DropdownContainer = Instance.new("Frame")
DropdownContainer.Size = UDim2.new(1, 0, 0, 0)
DropdownContainer.BackgroundTransparency = 1
DropdownContainer.ClipsDescendants = true
DropdownContainer.Parent = Content

local DropdownList = Instance.new("UIListLayout")
DropdownList.Parent = DropdownContainer
DropdownList.Padding = UDim.new(0, 4)

local listOpen = false
DropdownBtn.MouseButton1Click:Connect(function()
    listOpen = not listOpen
    if listOpen then
        for _, child in ipairs(DropdownContainer:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        local count = 0
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                count = count + 1
                local pBtn = Instance.new("TextButton")
                pBtn.Size = UDim2.new(1, 0, 0, 28)
                pBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
                pBtn.TextSize = 12
                applyStyle(pBtn, true)
                pBtn.Parent = DropdownContainer
                
                pBtn.MouseButton1Click:Connect(function()
                    selectedPlayerName = p.Name
                    DropdownBtn.Text = "Цель: " .. p.Name
                    listOpen = false
                    DropdownContainer.Size = UDim2.new(1, 0, 0, 0)
                end)
            end
        end
        DropdownContainer.Size = UDim2.new(1, 0, 0, math.min(count * 32, 120))
    else
        DropdownContainer.Size = UDim2.new(1, 0, 0, 0)
    end
end)

local KillBtn = Instance.new("TextButton")
KillBtn.Size = UDim2.new(1, 0, 0, 40)
KillBtn.Text = "Выкинуть за карту 💥"
KillBtn.BackgroundColor3 = Color3.fromRGB(241, 12, 114)
applyStyle(KillBtn, false)
KillBtn.Font = Enum.Font.GothamBold
KillBtn.Parent = Content

KillBtn.MouseButton1Click:Connect(function()
    if selectedPlayerName == "" then return end
    local targetPlayer = Players:FindFirstChild(selectedPlayerName)
    
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local targetRoot = targetPlayer.Character.HumanoidRootPart
        
        if myRoot and targetRoot then
            -- Запоминаем вашу текущую точку НАДЕЖНО
            local savedPosition = myRoot.CFrame
            
            local bV = Instance.new("BodyVelocity")
            bV.Velocity = Vector3.new(6000, 6000, 6000)
            bV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bV.Parent = myRoot
            
            local bAV = Instance.new("BodyAngularVelocity")
            bAV.AngularVelocity = Vector3.new(0, 99999, 0)
            bAV.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bAV.Parent = myRoot
            
            local t = tick()
            while tick() - t < 1.2 do
                RunService.Heartbeat:Wait()
                if myRoot and targetRoot then
                    myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 0.3)
                end
            end
            
            bV:Destroy()
            bAV:Destroy()
            
            if myRoot then
                myRoot.Velocity = Vector3.new(0,0,0)
                myRoot.RotVelocity = Vector3.new(0,0,0)
                task.wait(0.05)
                -- 100% возврат на исходную позицию
                myRoot.CFrame = savedPosition
            end
        end
    end
end)
local espActive = false
local glassHighlights = {}

local EspBtn = Instance.new("TextButton")
EspBtn.Size = UDim2.new(1, 0, 0, 35)
EspBtn.Text = "Подсветка Стекол: ВЫКЛ"
applyStyle(EspBtn, true)
EspBtn.Parent = Content

EspBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    EspBtn.Text = espActive and "Подсветка Стекол: ВКЛ" or "Подсветка Стекол: ВЫКЛ"
    EspBtn.BackgroundColor3 = espActive and Color3.fromRGB(46, 117, 89) or Color3.fromRGB(32, 32, 42)
    
    if espActive then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("glass") or obj.Name:lower():find("tile") or obj.Name:lower():find("panel")) then
                local highlight = Instance.new("BoxHandleAdornment")
                highlight.Size = obj.Size + Vector3.new(0.05, 0.05, 0.05)
                highlight.AlwaysOnTop = true
                highlight.ZIndex = 10
                highlight.Adornee = obj
                highlight.Parent = obj
                
                if obj.CanCollide == false or obj.Name:lower():find("fake") or obj.Name:lower():find("break") then
                    highlight.Color3 = Color3.fromRGB(255, 30, 30) -- Ломается (Красный)
                else
                    highlight.Color3 = Color3.fromRGB(30, 255, 30) -- Безопасное (Зеленый)
                end
                table.insert(glassHighlights, highlight)
            end
        end
    else
        for _, h in ipairs(glassHighlights) do if h then h:Destroy() end end
        glassHighlights = {}
    end
end)
