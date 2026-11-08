-- ==========================================
-- YORDAN HUB - ULTIMATE EDITION (CON BOTÓN MINIMIZAR)
-- ==========================================

-- ==========================================
-- PANTALLA DE CARGA: GOKU BLACK INTRO
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "YordanIntro"
IntroGui.Parent = CoreGui
IntroGui.IgnoreGuiInset = true

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Background.BorderSizePixel = 0
Background.Parent = IntroGui

local GokuImage = Instance.new("ImageLabel")
GokuImage.Size = UDim2.new(0, 200, 0, 200)
GokuImage.Position = UDim2.new(0.5, -100, 0.4, -120)
GokuImage.BackgroundTransparency = 1
GokuImage.Image = "rbxassetid://6023426915" 
GokuImage.ImageColor3 = Color3.fromRGB(180, 0, 255)
GokuImage.ImageTransparency = 1
GokuImage.Parent = Background

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 400, 0, 50)
TitleText.Position = UDim2.new(0.5, -200, 0.6, -20)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "YORDAN HUB"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 28
TitleText.TextTransparency = 1
TitleText.Parent = Background

local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(0, 400, 0, 30)
SubText.Position = UDim2.new(0.5, -200, 0.68, 0)
SubText.BackgroundTransparency = 1
SubText.Font = Enum.Font.Code
SubText.Text = "Cargando poder de Goku Black..."
SubText.TextColor3 = Color3.fromRGB(180, 0, 255)
SubText.TextSize = 14
SubText.TextTransparency = 1
SubText.Parent = Background

task.spawn(function()
    TweenService:Create(GokuImage, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    TweenService:Create(TitleText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    TweenService:Create(SubText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    
    task.wait(2.5)
    
    TweenService:Create(Background, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(GokuImage, TweenInfo.new(0.8), {ImageTransparency = 1}):Play()
    TweenService:Create(TitleText, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    TweenService:Create(SubText, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    
    task.wait(0.8)
    IntroGui:Destroy()
end)

task.wait(3.3)

-- ==========================================
-- CARGA DE LA LIBRERÍA DE UI (KAVO)
-- ==========================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("YORDAN HUB | Goku Black Edition", "DarkTheme")

-- ==========================================
-- MINI HUD FLOTANTE
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
local HudFrame = Instance.new("Frame")
local HudText = Instance.new("TextLabel")

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

ScreenGui.Name = "YordanMiniHUD"
HudFrame.Parent = ScreenGui
HudFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
HudFrame.BackgroundTransparency = 0.4
HudFrame.BorderSizePixel = 0
HudFrame.Position = UDim2.new(0.01, 0, 0.01, 0)
HudFrame.Size = UDim2.new(0, 130, 0, 24)
HudFrame.Active = true
HudFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = HudFrame

HudText.Parent = HudFrame
HudText.BackgroundTransparency = 1
HudText.Size = UDim2.new(1, 0, 1, 0)
HudText.Font = Enum.Font.Code
HudText.TextColor3 = Color3.fromRGB(180, 0, 255)
HudText.TextSize = 10
HudText.Text = "FPS: 60 | BLACK"
HudText.TextXAlignment = Enum.TextXAlignment.Center

local RunService = game:GetService("RunService")
local lastUpdate = 0
RunService.RenderStepped:Connect(function(step)
    if tick() - lastUpdate >= 0.5 then
        lastUpdate = tick()
        local fps = math.floor(1 / step)
        HudText.Text = "FPS: " .. fps .. " | BLACK"
    end
end)

-- ==========================================
-- PESTAÑA: JUGADOR (NOCLIP Y MINIMIZAR)
-- ==========================================
local PlayerTab = Window:NewTab("Jugador")
local PlayerSection = PlayerTab:NewSection("Movimiento y Físicas")

PlayerSection:NewSlider("Velocidad", "WalkSpeed", 200, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

PlayerSection:NewSlider("Salto", "JumpPower", 250, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

getgenv().NoclipEnabled = false
PlayerSection:NewToggle("Noclip Universal (1000%)", "Atraviesa cualquier pared sin fallos", function(state)
    getgenv().NoclipEnabled = state
end)

RunService.RenderStepped:Connect(function()
    if getgenv().NoclipEnabled then
        pcall(function()
            local character = game.Players.LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

RunService.Stepped:Connect(function()
    if getgenv().NoclipEnabled then
        pcall(function()
            local character = game.Players.LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- Botón funcional y seguro para Minimizar / Agrandar el menú
PlayerSection:NewButton("🔄 Minimizar / Agrandar Menú", "Oculta o muestra la interfaz del Hub", function()
    pcall(function()
        local uiMain = CoreGui:FindFirstChild("KavoUI") or CoreGui:FindFirstChild("YORDAN HUB | Goku Black Edition")
        if not uiMain then
            for _, v in pairs(CoreGui:GetChildren()) do
                if v:IsA("ScreenGui") and v:FindFirstChild("Main") then
                    uiMain = v
                    break
                end
            end
        end
        
        if uiMain and uiMain:FindFirstChild("Main") then
            uiMain.Main.Visible = not uiMain.Main.Visible
        end
    end)
end)

-- ==========================================
-- PESTAÑA: ARMAS & ESTANTE DE GUARDIA
-- ==========================================
local WeaponTab = Window:NewTab("Armas & Guardia")
local WeaponSection = WeaponTab:NewSection("Estantes de la Armería")

WeaponSection:NewButton("🛡️ Reclamar Escudo de Guardia", "Fuerza el escudo directamente a tu inventario", function()
    pcall(function()
        local player = game.Players.LocalPlayer
        local backpack = player:FindFirstChild("Backpack")
        
        local itemObj = workspace.Prison_ITEMS.giver:FindFirstChild("Riot Shield")
        if itemObj then
            local clone = itemObj:Clone()
            if clone:FindFirstChild("ITEMPICKUP") then
                clone.ITEMPICKUP:Destroy()
            end
            clone.Parent = backpack
        end
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Yordan Hub",
        Text = "¡Escudo de guardia entregado!",
        Duration = 3
    })
end)

WeaponSection:NewButton("🔓 Reclamar Armas Libres", "Agarra Remington, M4A1, AK-47 y Taser", function()
    pcall(function()
        local Event = workspace.Remote.ItemHandler
        local armas = {"Remington 870", "M4A1", "AK-47", "Taser"}
        for _, arma in pairs(armas) do
            if workspace.Prison_ITEMS.giver:FindFirstChild(arma) then
                Event:InvokeServer(workspace.Prison_ITEMS.giver[arma].ITEMPICKUP)
            end
        end
    end)
end)

-- ==========================================
-- PESTAÑA: COMBATE & SILENT AIM
-- ==========================================
local CombatTab = Window:NewTab("Combate")
local CombatSection = CombatTab:NewSection("Autoapuntado Oculto")

getgenv().SilentAim = false
CombatSection:NewToggle("Activar Silent Aim", "Dispara al enemigo sin mover tu cámara", function(state)
    getgenv().SilentAim = state
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function getClosestEnemy()
    local closestTarget = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") then
            local esEnemigo = false
            if LocalPlayer.Team.Name == "Guards" and player.Team.Name ~= "Guards" then
                esEnemigo = true
            elseif LocalPlayer.Team.Name == "Inmates" and player.Team.Name == "Guards" then
                esEnemigo = true
            elseif LocalPlayer.Team.Name == "Criminals" then
                esEnemigo = true
            end

            if esEnemigo and player.Character.Humanoid.Health > 0 then
                local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
                if onScreen then
                    local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestTarget = player.Character.Head
                    end
                end
            end
        end
    end
    return closestTarget
end

pcall(function()
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        
        if getgenv().SilentAim and method == "FireServer" and tostring(self) == "ShootEvent" then
            local enemyHead = getClosestEnemy()
            if enemyHead and args[1] and type(args[1]) == "table" then
                for i, v in pairs(args[1]) do
                    if type(v) == "table" and v.Ray then
                        v.Ray = Ray.new(v.Ray.Origin, (enemyHead.Position - v.Ray.Origin).Unit * 1000)
                    end
                end
            end
        end
        return old(self, unpack(args))
    end)
end)

-- ==========================================
-- PESTAÑA: TELEPORT
-- ==========================================
local TeleportTab = Window:NewTab("Teleport")
local TeleportSection = TeleportTab:NewSection("Zonas del Mapa")

TeleportSection:NewButton("Patio", "Ir al patio", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(789, 98, 2498)
end)

TeleportSection:NewButton("Armería", "Ir a la armería", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(838, 99, 2269)
end)

TeleportSection:NewButton("Base Criminal", "Ir afuera", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-943, 94, 2054)
end)
