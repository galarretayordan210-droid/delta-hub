loadstring([[
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Esperar a que el jugador cargue por completo en Murder Mystery
task.wait(1.5)

-- Limpieza total previa
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "UniversalSafeHub" then gui:Destroy() end
end
for _, gui in pairs(PlayerGui:GetChildren()) do
    if gui.Name == "UniversalSafeHub" then gui:Destroy() end
end

-- Creación segura de la interfaz flotante
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalSafeHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent or ScreenGui.Parent ~= CoreGui then
    ScreenGui.Parent = PlayerGui
end

-- Ventana Principal (Estética Azul/Celeste)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 680)
MainFrame.Position = UDim2.new(0.1, 50, 0.1, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- Redondear esquinas
local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 12)
WindowCorner.Parent = MainFrame

-- Borde estilizado
local WindowStroke = Instance.new("UIStroke")
WindowStroke.Thickness = 2
WindowStroke.Color = Color3.fromRGB(56, 189, 248)
WindowStroke.Parent = MainFrame

-- Barra de Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(37, 99, 235)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.GothamBold
Title.Text = "  Δ SAFE UNIVERSAL HUB Δ"
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Visible = true
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Contenedor interior
local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, 0, 1, -40)
ContentContainer.Position = UDim2.new(0, 0, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 750)
ContentContainer.ScrollBarThickness = 4
ContentContainer.Visible = true
ContentContainer.Parent = MainFrame

-- Botón Minimizar / Maximizar ([-] / [+])
local ToggleMinBtn = Instance.new("TextButton")
ToggleMinBtn.Size = UDim2.new(0, 30, 0, 30)
ToggleMinBtn.Position = UDim2.new(1, -35, 0, 5)
ToggleMinBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
ToggleMinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMinBtn.TextSize = 14
ToggleMinBtn.Font = Enum.Font.GothamBold
ToggleMinBtn.Text = "-"
ToggleMinBtn.ZIndex = 10
ToggleMinBtn.Visible = true
ToggleMinBtn.Parent = MainFrame

local MinBtnCorner = Instance.new("UICorner")
MinBtnCorner.CornerRadius = UDim.new(0, 6)
MinBtnCorner.Parent = ToggleMinBtn

local isMinimized = false
ToggleMinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        ToggleMinBtn.Text = "+"
        ContentContainer.Visible = false
        MainFrame.Size = UDim2.new(0, 260, 0, 40)
    else
        ToggleMinBtn.Text = "-"
        ContentContainer.Visible = true
        MainFrame.Size = UDim2.new(0, 260, 0, 680)
    end
end)

-- Subtítulo de Estado con XP Tracker
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 24)
SubTitle.Position = UDim2.new(0, 0, 0, 0)
SubTitle.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
SubTitle.TextColor3 = Color3.fromRGB(56, 189, 248)
SubTitle.TextSize = 10
SubTitle.Font = Enum.Font.GothamBold
SubTitle.Text = "Nivel: 1 | XP: 0 / 100 ⚡"
SubTitle.Visible = true
SubTitle.Parent = ContentContainer

-- Contenedor de Botones (Layout Automático)
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.Parent = ContentContainer

-- Espaciador superior
local Spacer = Instance.new("Frame")
Spacer.Size = UDim2.new(1, 0, 0, 28)
Spacer.BackgroundTransparency = 1
Spacer.Visible = true
Spacer.Parent = ContentContainer

-- ================= VARIABLES DE ESTADO =================
local speedEnabled = false
local customSpeed = 16
local jumpEnabled = false
local customJumpPower = 120
local noclipEnabled = false
local carTurboEnabled = false
local ffGraphicsEnabled = false
local blocksEnabled = false
local aimbotEnabled = false
local rolesEnabled = false
local isShootingOrAiming = false

local currentLevel = 1
local currentXP = 0
local maxXP = 100

-- Detección de clics (Disparar o Apuntar)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch then
        isShootingOrAiming = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch then
        isShootingOrAiming = false
    end
end)

-- ================= FUNCIÓN DE ANIMACIÓN DE COHETE 3D =================
local function launch3DRocketAnimation()
    pcall(function()
        local Viewport = Instance.new("ViewportFrame")
        Viewport.Size = UDim2.new(0, 200, 0, 300)
        Viewport.Position = UDim2.new(0.5, -100, 0.5, -150)
        Viewport.BackgroundTransparency = 1
        Viewport.ZIndex = 20
        Viewport.Parent = ScreenGui

        local VCam = Instance.new("Camera")
        VCam.Parent = Viewport
        Viewport.CurrentCamera = VCam

        local RocketModel = Instance.new("Model")
        RocketModel.Parent = Viewport

        local Body = Instance.new("Part")
        Body.Size = Vector3.new(2, 4.5, 2)
        Body.Position = Vector3.new(0, 0, 0)
        Body.Shape = Enum.PartType.Cylinder
        Body.Material = Enum.Material.SmoothPlastic
        Body.Color = Color3.fromRGB(241, 245, 249)
        Body.Parent = RocketModel

        local Cone = Instance.new("Part")
        Cone.Size = Vector3.new(2.1, 2, 2.1)
        Cone.Position = Vector3.new(0, 3.25, 0)
        Cone.Shape = Enum.PartType.Ball
        Cone.Material = Enum.Material.SmoothPlastic
        Cone.Color = Color3.fromRGB(239, 68, 68)
        Cone.Parent = RocketModel

        local Fire = Instance.new("Part")
        Fire.Size = Vector3.new(1.8, 2, 1.8)
        Fire.Position = Vector3.new(0, -3.2, 0)
        Fire.Shape = Enum.PartType.Cylinder
        Fire.Material = Enum.Material.Neon
        Fire.Color = Color3.fromRGB(251, 191, 36)
        Fire.Parent = RocketModel

        VCam.CFrame = CFrame.new(Vector3.new(0, 0, 9), Body.Position)

        local TextHolder = Instance.new("TextLabel")
        TextHolder.Size = UDim2.new(0, 220, 0, 40)
        TextHolder.Position = UDim2.new(0.5, -110, 1, 10)
        TextHolder.BackgroundTransparency = 1
        TextHolder.TextColor3 = Color3.fromRGB(74, 222, 128)
        TextHolder.TextSize = 14
        TextHolder.Font = Enum.Font.GothamBold
        TextHolder.Text = "🚀 ¡GRÁFICOS SUAVES ACTIVADOS!"
        TextHolder.ZIndex = 25
        TextHolder.Parent = Viewport

        local tweenInfo = TweenInfo.new(0.9, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
        local launchTween = TweenService:Create(Viewport, tweenInfo, {
            Position = UDim2.new(0.5, -100, -0.8, 0)
        })

        launchTween:Play()
        launchTween.Completed:Connect(function()
            Viewport:Destroy()
        end)
    end)
end

-- 1. Función para crear Botones tipo Toggle
local function createToggleButton(baseText, callback)
    local state = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Text = baseText .. ": [ OFF ]"
    btn.Visible = true
    btn.Parent = ContentContainer

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = btn

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

-- 2. Función para barra de ajuste (Slider)
local function createSlider(titleText, minVal, maxVal, defaultVal, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.9, 0, 0, 44)
    container.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    container.Visible = true
    container.Parent = ContentContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 18)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.Text = titleText .. ": " .. defaultVal
    label.Visible = true
    label.Parent = container

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0.9, 0, 0, 8)
    sliderBg.Position = UDim2.new(0.05, 0, 0, 24)
    sliderBg.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    sliderBg.Visible = true
    sliderBg.Parent = container

    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 4)
    bgCorner.Parent = sliderBg

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
    sliderFill.Visible = true
    sliderFill.Parent = sliderBg

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = sliderFill

    local dragging = false

    local function updateInput(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        local val = math.floor(minVal + ((maxVal - minVal) * pos))
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        label.Text = titleText .. ": " .. val
        callback(val)
    end

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateInput(input)
        end
    end)
end

-- 3. Función para botones normales
local function createActionButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(37, 99, 235)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.Visible = true
    pcall(function() btn.Parent = ContentContainer end)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- ================= MOTORES UNIVERSALES OPTIMIZADOS =================

RunService.Heartbeat:Connect(function()
    if speedEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            humanoid.WalkSpeed = customSpeed
            if humanoid.MoveDirection.Magnitude > 0 then
                rootPart.Velocity = Vector3.new(humanoid.MoveDirection.X * customSpeed, rootPart.Velocity.Y, humanoid.MoveDirection.Z * customSpeed)
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if jumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = customJumpPower
        end
    end
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        pcall(function()
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end)

RunService.Heartbeat:Connect(function()
    if carTurboEnabled and LocalPlayer.Character then
        local character = LocalPlayer.Character
        local seat = character:FindFirstChildOfClass("VehicleSeat") or (character.Humanoid and character.Humanoid.SeatPart)
        if seat and seat:IsA("VehicleSeat") then
            seat.MaxSpeed = 300
            seat.Torque = 999999
        end
    end
end)

local lastSpawnPos = Vector3.new(0, 0, 0)
RunService.Heartbeat:Connect(function()
    if blocksEnabled and LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local currentPos = rootPart.Position - Vector3.new(0, 3.2, 0)
            if (currentPos - lastSpawnPos).Magnitude >= 4 then
                lastSpawnPos = currentPos
                pcall(function()
                    local block = Instance.new("Part")
                    block.Size = Vector3.new(4, 1, 4)
                    block.Position = currentPos
                    block.Anchored = true
                    block.Material = Enum.Material.SmoothPlastic
                    block.Color = Color3.fromHSV((tick() % 5) / 5, 1, 1)
                    block.Parent = Workspace
                    
                    task.delay(3, function()
                        if block and block.Parent then
                            block:Destroy()
                        end
                    end)
                end)
            end
        end
    end
end)

-- Sistema de XP automático
task.spawn(function()
    while true do
        task.wait(1)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local root = LocalPlayer.Character.HumanoidRootPart
            if root.Velocity.Magnitude > 5 then
                currentXP = currentXP + 10
                if currentXP >= maxXP then
                    currentXP = 0
                    currentLevel = currentLevel + 1
                    maxXP = maxXP + 50
                end
                SubTitle.Text = "Nivel: " .. currentLevel .. " | XP: " .. currentXP .. " / " .. maxXP .. " ⚡"
            end
        end
    end
end)

-- Motor de Roles ESP específico para MM2 (Sheriff = Azul, Murder = Rojo a través de paredes)
task.spawn(function()
    while true do
        task.wait(0.5)
        if rolesEnabled then
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local char = player.Character
                        local backpack = player:FindFirstChildOfClass("Backpack")
                        local hasGun, hasKnife = false, false
                        
                        for _, item in pairs(char:GetChildren()) do
                            if item:IsA("Tool") then
                                local name = item.Name:lower()
                                if name:find("gun") or name:find("revolver") or name:find("pistol") or name:find("knife") or name:find("cuchillo") then
                                    if name:find("gun") or name:find("revolver") or name:find("pistol") then hasGun = true end
                                    if name:find("knife") or name:find("cuchillo") then hasKnife = true end
                                end
                            end
                        end
                        
                        if backpack then
                            for _, item in pairs(backpack:GetChildren()) do
                                if item:IsA("Tool") then
                                    local name = item.Name:lower()
                                    if name:find("gun") or name:find("revolver") or name:find("pistol") then hasGun = true end
                                    if name:find("knife") or name:find("cuchillo") then hasKnife = true end
                                end
                            end
                        end
                        
                        local highlight = char:FindFirstChild("RoleHighlight")
                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "RoleHighlight"
                            highlight.Parent = char
                        end
                        
                        highlight.AlwaysOnTop = true
                        highlight.Adornee = char
                        
                        if hasGun then
                            highlight.FillColor = Color3.fromRGB(0, 120, 255) -- Azul Sheriff
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.Enabled = true
                        elseif hasKnife then
                            highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Rojo Murder
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.Enabled = true
                        else
                            highlight.Enabled = false
                        end
                    end
                end
            end)
        else
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character and player.Character:FindFirstChild("RoleHighlight") then
                        player.Character.RoleHighlight:Destroy()
                    end
                end
            end)
        end
    end
end)

-- Aim Assist
RunService.RenderStepped:Connect(function()
    if aimbotEnabled and isShootingOrAiming and LocalPlayer.Character then
        pcall(function()
            local closestTarget = nil
            local shortestDistance = math.huge
            local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if myRoot then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
                        local enemyHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
                        
                        if enemyRoot and enemyHumanoid and enemyHumanoid.Health > 0 then
                            if player.Team ~= LocalPlayer.Team or not player.Team then
                                local distance = (enemyRoot.Position - myRoot.Position).Magnitude
                                if distance < shortestDistance then
                                    shortestDistance = distance
                                    closestTarget = enemyRoot
                                end
                            end
                        end
                    end
                end
                
                if closestTarget then
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closestTarget.Position + Vector3.new(0, 0.5, 0))
                end
            end
        end)
    end
end)

-- ================= CREACIÓN DE CONTROLES EN EL MENÚ =================

createToggleButton("⚡ Activar Velocidad", function(state)
    speedEnabled = state
    if not state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
end)

createSlider("Ajustar Velocidad", 1, 100, 16, function(value)
    customSpeed = value
end)

createToggleButton("🦘 Super Salto Modificable", function(state)
    jumpEnabled = state
    if not state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
    end
end)

createToggleButton("👻 Noclip Universal [Anti-Ban]", function(state)
    noclipEnabled = state
end)

createToggleButton("👁️ Roles ESP (MM2: Sheriff/Murder)", function(state)
    rolesEnabled = state
end)

createToggleButton("🎯 Aim Assist [Disparar & Libre]", function(state)
    aimbotEnabled = state
end)

createToggleButton("🏎️ Turbo Vehículo", function(state)
    carTurboEnabled = state
end)

createToggleButton("🧱 Bloques 4x4 de Colores", function(state)
    blocksEnabled = state
end)

createToggleButton("🚀 Gráficos Suaves [FPS Booster]", function(state)
    ffGraphicsEnabled = state
    if state then
        launch3DRocketAnimation()
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.Brightness = 2
            Lighting.OutdoorAmbient = Color3.fromRGB(160, 160, 160)
            
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") then
                    v.Enabled = false
                end
            end
            
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                end
            end
        end)
    end
end)

createActionButton("🔄 Restaurar Valores", function()
    speedEnabled = false
    jumpEnabled = false
    noclipEnabled = false
    carTurboEnabled = false
    blocksEnabled = false
    aimbotEnabled = false
    rolesEnabled = false
    currentLevel = 1
    currentXP = 0
    maxXP = 100
    customSpeed = 16
    customJumpPower = 120
    SubTitle.Text = "Nivel: 1 | XP: 0 / 100 ⚡"
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
    print("[Universal Hub]: Todo reiniciado a la normalidad.")
end)

createActionButton("❌ Cerrar Panel", function()
    ScreenGui:Destroy()
end)

print("[Delta Hub]: ¡Panel cargado exitosamente en Murder Mystery!")
]])()
