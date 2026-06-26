-- ГЛОБАЛЬНЫЕ НАСТРОЙКИ С ПЕРЕХВАТОМ СМЕРТИ Персонажа
getgenv().TreasureAutoFarm = {
    Enabled = false,
    FlySpeed = 220,        -- Диапазон ползунка: 220 - 1500
    WaitAtChest = 5        -- Ожидание зачисления золота на финише
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- СОЗДАНИЕ ИНТЕРФЕЙСА (ТЁМНЫЙ СТИЛЬ)
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "AntiFreak_Ultra_v5"
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

-- СТИЛИЗАЦИЯ КНОПКИ (Шестеренка ⚙️)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
ToggleButton.Text = "⚙️"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
ToggleButton.Font = Enum.Font.GothamBold
UICorner_Btn.CornerRadius = UDim.new(1, 0)

local BtnStroke = Instance.new("UIStroke", ToggleButton)
BtnStroke.Color = Color3.fromRGB(150, 60, 255)
BtnStroke.Thickness = 1.5

-- СТИЛИЗАЦИЯ ГЛАВНОГО МЕНЮ (by @AntiFreakXD)
MainMenu.Size = UDim2.new(0, 280, 0, 210)
MainMenu.Position = UDim2.new(0.35, 0, 0.35, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainMenu.ClipsDescendants = true
MainMenu.Visible = false
UICorner_Menu.CornerRadius = UDim.new(0, 14)

local MenuStroke = Instance.new("UIStroke", MainMenu)
MenuStroke.Color = Color3.fromRGB(35, 35, 40)
MenuStroke.Thickness = 1

Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "by @AntiFreakXD"
Title.TextColor3 = Color3.fromRGB(160, 100, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold

FarmToggleBtn.Size = UDim2.new(1, -40, 0, 45)
FarmToggleBtn.Position = UDim2.new(0, 20, 0, 55)
FarmToggleBtn.BackgroundColor3 = Color3.fromRGB(230, 50, 50)
FarmToggleBtn.Text = "Auto Farm: OFF"
FarmToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggleBtn.TextSize = 14
FarmToggleBtn.Font = Enum.Font.GothamSemibold
UICorner_Farm.CornerRadius = UDim.new(0, 8)

SliderText.Size = UDim2.new(1, -40, 0, 20)
SliderText.Position = UDim2.new(0, 20, 0, 115)
SliderText.BackgroundTransparency = 1
SliderText.Text = "Speed: 220"
SliderText.TextColor3 = Color3.fromRGB(180, 180, 185)
SliderText.TextSize = 13
SliderText.Font = Enum.Font.GothamSemibold
SliderText.TextXAlignment = Enum.TextXAlignment.Left

SliderFrame.Size = UDim2.new(1, -40, 0, 10)
SliderFrame.Position = UDim2.new(0, 20, 0, 145)
SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
UICorner_Slider.CornerRadius = UDim.new(0, 5)

SliderButton.Size = UDim2.new(0, 20, 0, 20)
SliderButton.Position = UDim2.new(0, -10, -0.5, 0)
SliderButton.BackgroundColor3 = Color3.fromRGB(150, 60, 255)
SliderButton.Text = ""
UICorner_SliderBtn.CornerRadius = UDim.new(1, 0)

-- ПЛАВНАЯ АНИМАЦИЯ ОТКРЫТИЯ (TWEEN)
local menuOpen = false
local originalSize = UDim2.new(0, 280, 0, 210)

ToggleButton.MouseButton1Click:Connect(function()
    if not menuOpen then
        MainMenu.Size = UDim2.new(0, 280, 0, 0)
        MainMenu.Visible = true
        TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = originalSize}):Play()
        menuOpen = true
    else
        local closeTween = TweenService:Create(MainMenu, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 280, 0, 0)})
        closeTween:Play()
        closeTween.Completed:Connect(function() if not menuOpen then MainMenu.Visible = false end end)
        menuOpen = false
    end
end)

-- ДРАГ-СИСТЕМА ДЛЯ ПЕРЕМЕЩЕНИЯ И МЕНЮ, И КНОПКИ
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
