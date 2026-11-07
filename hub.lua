loadstring([[
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Limpieza total previa de duplicados
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "UniversalSafeHub" or gui.Name == "YodanLoadingGui" then gui:Destroy() end
end
for _, gui in pairs(PlayerGui:GetChildren()) do
    if gui.Name == "UniversalSafeHub" or gui.Name == "YodanLoadingGui" then gui:Destroy() end
end

-- ================= BARRA DE CARGA "YODAN HUB" =================
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
    LoadFrame.BackgroundColor3 = Color3.fromRGB(11, 15, 25)
    LoadFrame.BorderSizePixel = 0
    LoadFrame.Parent = LoadGui

    local LoadCorner = Instance.new("UICorner")
    LoadCorner.CornerRadius = UDim.new(0, 12)
    LoadCorner.Parent = LoadFrame

    local LoadStroke = Instance.new("UIStroke")
    LoadStroke.Thickness = 2
    LoadStroke.Color = Color3.fromRGB(56, 189, 248)
    LoadStroke.Parent = LoadFrame

    local LoadTitle = Instance.new("TextLabel")
    LoadTitle.Size = UDim2.new(1, 0, 0, 35)
    LoadTitle.BackgroundTransparency = 1
    LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadTitle.TextSize = 14
    LoadTitle.Font = Enum.Font.GothamBold
    LoadTitle.Text = "⚡ CARGANDO YODAN HUB... JAJAJA"
    LoadTitle.Parent = LoadFrame

    local BarBackground = Instance.new("Frame")
    BarBackground.Size = UDim2.new(0.85, 0, 0, 14)
    BarBackground.Position = UDim2.new(0.075, 0, 0, 55)
    BarBackground.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
    BarBackground.BorderSizePixel = 0
    BarBackground.Parent = LoadFrame

    local BarBgCorner = Instance.new("UICorner")
    BarBgCorner.CornerRadius = UDim.new(0, 7)
    BarBgCorner.Parent = BarBackground

    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
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

    local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local fillTween = TweenService:Create(BarFill, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
    fillTween:Play()

    task.spawn(function()
        for i = 1, 100 do
            PercentText.Text = i .. "%"
            task.wait(0.012)
        end
        PercentText.Text = "¡LISTO!"
    end)

    fillTween.Completed:Wait()
    task.wait(0.3)
    LoadGui:Destroy()
end)

-- ================= INTERFAZ FLOTANTE PRINCIPAL =================
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

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 720)
MainFrame.Position = UDim2.new(0.1, 50, 0.1, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 12)
WindowCorner.Parent = MainFrame

local WindowStroke = Instance.new("UIStroke")
WindowStroke.Thickness = 2
WindowStroke.Color = Color3.fromRGB(56, 189, 248)
WindowStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(37, 99, 235)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.Text = "  ⚡ YODAN HUB - PRO ⚡"
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Visible = true
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, 0, 1, -40)
ContentContainer.Position = UDim2.new(0, 0, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 850)
ContentContainer.ScrollBarThickness = 4
ContentContainer.Visible = true
ContentContainer.Parent = MainFrame

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
        MainFrame.Size = UDim2.new(0, 260, 0, 720)
    end
end)

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

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.Parent = ContentContainer

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
local cartonGraphicsEnabled = false
local blocksEnabled = false
local aimbotEnabled = false
local espUniversalEnabled = false
local autoCollectEggsEnabled = false
local isShootingOrAiming = false

local currentLevel = 1
local currentXP = 0
local maxXP = 100

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch then
        isShootingOrAiming = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch then
        isShootingOrAiming = false
    end
end)

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
        TextHolder.Text = "📦 ¡GRÁFICOS DE CARTÓN ACTIVADOS!"
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

-- ================= MOTOR DE VELOCIDAD ANTI-RUBBERBAND (NUEVO MÉTODO) =================
RunService.RenderStepped:Connect(function(dt)
    if speedEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoid and rootPart then
            humanoid.WalkSpeed = 16 -- Mantenemos velocidad normal para el servidor para que no detecte trampa
            if humanoid.MoveDirection.Magnitude > 0 then
                -- Desplazamiento limpio por CFrame incremental (evita tirones hacia atrás)
                rootPart.CFrame = rootPart.CFrame + (humanoid.MoveDirection * (customSpeed / 35) * dt * 60)
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if jumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
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

task.spawn(function()
    while true do
        task.wait(0.08)
        if autoCollectEggsEnabled and LocalPlayer.Character then
            pcall(function()
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        local name = obj.Name:lower()
                        if name:find("egg") or name:find("huevo") or name:find("collect") or name:find("pickup") then
                            if obj:IsA("BasePart") and (obj.Position - rootPart.Position).Magnitude < 35 then
                                obj.CFrame = rootPart.CFrame
                            elseif obj:IsA("ProximityPrompt") then
                                fireproximityprompt(obj)
                            end
                        end
                    end
                end
            end)
        end
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
                    task.delay(2, function() if block and block.Parent then block:Destroy() end end)
                end)
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
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
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if espUniversalEnabled then
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local char = player.Character
                        local highlight = c
