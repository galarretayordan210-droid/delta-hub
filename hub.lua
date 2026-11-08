-- ==========================================
-- NOCLIP ULTRA-POTENTE (1000% EFECTIVO)
-- ==========================================
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
