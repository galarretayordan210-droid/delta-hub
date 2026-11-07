loadstring([[
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Limpieza previa
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "YodanFootballHub" or gui.Name == "YodanLoadingGui" then gui:Destroy() end
end
for _, gui in pairs(PlayerGui:GetChildren()) do
    if gui.Name == "YodanFootballHub" or gui.Name == "YodanLoadingGui" then gui:Destroy() end
end

-- ================= BARRA DE CARGA YODAN FOOTBALL =================
pcall(function()
    local laughSound = Instance.new("Sound")
    laughSound.SoundId = "rbxassetid://9069176044"
    laughSound.Volume = 2
    laughSound.Parent = SoundService
    laughSound:Play()

    local LoadGui = Instance.new("ScreenGui")
    LoadGui.Name = "YodanLoadingGui"
    LoadGui.Parent = CoreGui

    local LoadFrame = Instance.new("Frame")
    LoadFrame.Size = UDim2.new(0, 320, 0, 110)
    LoadFrame.Position = UDim2.new(0.5, -160, 0.5, -55)
    LoadFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    LoadFrame.BorderSizePixel = 0
    LoadFrame.Parent = LoadGui

    local LoadCorner = Instance.new("UICorner")
    LoadCorner.CornerRadius = UDim.new(0, 12)
    LoadCorner.Parent = LoadFrame

    local LoadStroke = Instance.new("UIStroke")
    LoadStroke.Thickness = 2
    LoadStroke.Color = Color3.fromRGB(34, 197, 94)
    LoadStroke.Parent = LoadFrame

    local LoadTitle = Instance.new("TextLabel")
    LoadTitle.Size = UDim2.new(1, 0, 0, 35)
    LoadTitle.BackgroundTransparency = 1
    LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadTitle.TextSize = 14
    LoadTitle.Font = Enum.Font.GothamBold
    LoadTitle.Text = "⚽ YODAN FOOTBALL HUB... JAJAJA"
    LoadTitle.Parent = LoadFrame

    local BarBackground = Instance.new("Frame")
    BarBackground.Size = UDim2.new(0.85, 0, 0, 14)
    BarBackground.Position = UDim2.new(0.075, 0, 0, 55)
    BarBackground.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    BarBackground.BorderSizePixel = 0
    BarBackground.Parent = LoadFrame

    local BarBgCorner = Instance.new("UICorner")
    BarBgCorner.CornerRadius = UDim.new(0, 7)
    BarBgCorner.Parent = BarBackground

    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
    BarFill.BorderSizePixel = 0
    BarFill.Parent = BarBackground

    local BarFillCorner = Instance.new("UICorner")
    BarFillCorner.CornerRadius = UDim.new(0, 7)
    BarFillCorner.Parent = BarFill

    local PercentText = Instance.new("TextLabel")
    PercentText.Size = UDim2.new(1, 0, 0, 20)
    PercentText.Position = UDim2.new(0, 0, 0, 75)
    PercentText.BackgroundTransparency = 1
    PercentText.TextColor3 = Color3.fromRGB(148, 163, 184)
    PercentText.TextSize = 11
    PercentText.Font = Enum.Font.GothamBold
    PercentText.Text = "0%"
    PercentText.Parent = LoadFrame

    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local fillTween = TweenService:Create(BarFill, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
    fillTween:Play()

    task.spawn(function()
        for i = 1, 100 do
            PercentText.Text = i .. "%"
            task.wait(0.01)
        end
        PercentText.Text = "¡LISTO PARA ATAJAR!"
    end)

    fillTween.Completed:Wait()
    task.wait(0.2)
    LoadGui:Destroy()
end)

-- ================= INTERFAZ PRINCIPAL =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YodanFootballHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 520)
MainFrame.Position = UDim2.new(0.1, 50, 0.1, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 12)
WindowCorner.Parent = MainFrame

local WindowStroke = Instance.new("UIStroke")
WindowStroke.Thickness = 2
WindowStroke.Color = Color3.fromRGB(34, 197, 94)
WindowStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(22, 101, 52)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.Text = "  ⚽ YODAN STREET FOOTBALL"
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, 0, 1, -40)
ContentContainer.Position = UDim2.new(0, 0, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 500)
ContentContainer.ScrollBarThickness = 4
ContentContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ContentContainer

local Spacer = Instance.new("Frame")
Spacer.Size = UDim2.new(1, 0, 0, 10)
Spacer.BackgroundTransparency = 1
Spacer.Parent = ContentContainer

-- ================= ESTADOS Y FUNCIONES =================
local dribbleEnabled = false
local speedEnabled = false
local customSpeed = 19
local autoKeeperEnabled = false

local function createToggleButton(baseText, callback)
    local state = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Text = baseText .. ": [ OFF ]"
    btn.Parent = ContentContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(22, 163, 74)
            btn.Text = baseText .. ": [ ON ]"
        else
            btn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
            btn.Text = baseText .. ": [ OFF ]"
        end
        callback(state)
    end)
    return btn
end

-- ================= MOTORES DE FÚTBOL REALISTA =================

-- 1. Velocidad Realista Anti-Kick
RunService.Heartbeat:Connect(function()
    if speedEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = customSpeed
        end
    end
end)

-- 2. Imán de Balón (Dribble)
task.spawn(function()
    while true do
        task.wait(0.05)
        if dribbleEnabled and LocalPlayer.Character then
            pcall(function()
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        local name = obj.Name:lower()
                        if name:find("ball") or name:find("balon") or name:find("pelota") then
                            if obj:IsA("BasePart") then
                                local dist = (obj.Position - rootPart.Position).Magnitude
                                if dist < 12 then
                                    obj.Velocity = (rootPart.CFrame.LookVector * 15) + Vector3.new(0, 2, 0)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- 3. AUTOPREDICE DE ARQUERO (Auto-Dive / Intercepción Inteligente)
task.spawn(function()
    while true do
        task.wait(0.03)
        if autoKeeperEnabled and LocalPlayer.Character then
            pcall(function()
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        local name = obj.Name:lower()
                        if name:find("ball") or name:find("balon") or name:find("pelota") then
                            if obj:IsA("BasePart") then
                                local dist = (obj.Position - rootPart.Position).Magnitude
                                -- Si el balón viene disparado hacia tu zona (a menos de 45 studs y con velocidad alta)
                                if dist < 45 and obj.AssemblyLinearVelocity.Magnitude > 10 then
                                    -- Predice la posición exacta del balón y mueve instantáneamente al arquero a interceptar
                                    local predictedPos = obj.Position + (obj.AssemblyLinearVelocity * 0.15)
                                    rootPart.CFrame = CFrame.new(Vector3.new(predictedPos.X, rootPart.Position.Y, predictedPos.Z), obj.Position)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ================= INTERFAZ DE BOTONES =================

createToggleButton("🏃 Velocidad de Calle Realista", function(state) speedEnabled = state end)
createToggleButton("⚽ Imán de Balón [Dribble Pegado]", function(state) dribbleEnabled = state end)
createToggleButton("🧤 Autopredice [Arquero Automático]", function(state) autoKeeperEnabled = state end)

local function createActionButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(37, 99, 235)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.Parent = ContentContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

createActionButton("❌ Cerrar Panel", function()
    ScreenGui:Destroy()
end)

print("[Yodan Football Hub]: ¡Modo Arquero Autopredice Activado!")
]])()
