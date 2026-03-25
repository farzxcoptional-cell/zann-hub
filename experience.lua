--[[
    ╔════════════════════════════════════════════════╗
    ║        ZannHub V5 PERFECT LOCK - RIVALS        ║
    ║        PREMIUM SMOOTHING & AUTO-PREDICT        ║
    ╚════════════════════════════════════════════════╝
]]

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "ZannHub V5 | Perfect Lock", 
    HidePremium = true, 
    SaveConfig = false,
    IntroText = "ZannHub Precision System",
    IntroEnabled = true
})

-- // SETTINGS (Precision Logic) // --
_G.Aimbot = {
    Enabled = false,
    Key = "zannrivals2026", -- Key Login
    Smoothness = 0.5,       -- Semakin kecil semakin nempel (0.1 - 1.0)
    FOV = 150,
    Headshot = true,
    TeamCheck = true
}

-- // LOGIN SYSTEM // --
local AuthTab = Window:NewTab({Name = "License", Icon = "rbxassetid://4483345998"})
AuthTab:AddTextbox({
    Name = "Enter Access Key",
    Default = "",
    Callback = function(v) _G.InputKey = v end
})

AuthTab:AddButton({
    Name = "Initialize Precision",
    Callback = function()
        if _G.InputKey == _G.Aimbot.Key then
            OrionLib:MakeNotification({Name = "ZannHub", Content = "Precision Engine Loaded!", Time = 3})
            
            -- // MAIN TABS // --
            local Combat = Window:NewTab({Name = "Aimbot Elite", Icon = "rbxassetid://4483345998"})
            local Settings = Window:NewTab({Name = "Settings", Icon = "rbxassetid://4483345998"})

            -- COMBAT FEATURES
            Combat:AddToggle({
                Name = "Enable Perfect Lock",
                Default = false,
                Callback = function(v) _G.Aimbot.Enabled = v end
            })

            Combat:AddToggle({
                Name = "Always Headshot",
                Default = true,
                Callback = function(v) _G.Aimbot.Headshot = v end
            })

            -- SETTINGS (CUSTOMIZE AIM)
            Settings:AddSlider({
                Name = "Smoothing (Smoothness)",
                Min = 1, Max = 10, Default = 5,
                Callback = function(v) _G.Aimbot.Smoothness = v / 10 end
            })

            Settings:AddSlider({
                Name = "FOV Size",
                Min = 50, Max = 500, Default = 150,
                Callback = function(v) _G.Aimbot.FOV = v end
            })

            -- // ENGINE PERFECT LOCK (HIGH PRECISION) // --
            local Camera = workspace.CurrentCamera
            local LocalPlayer = game.Players.LocalPlayer
            local RunService = game:GetService("RunService")
            local TweenService = game:GetService("TweenService")

            RunService.RenderStepped:Connect(function()
                if _G.Aimbot.Enabled then
                    local Target = nil
                    local ShortestDist = _G.Aimbot.FOV
                    
                    for _, p in pairs(game.Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                            -- Team Check Sederhana
                            if p.Team ~= LocalPlayer.Team then
                                local Pos, OnScreen = Camera:WorldToViewportPoint(p.Character.PrimaryPart.Position)
                                if OnScreen then
                                    local MousePos = game:GetService("UserInputService"):GetMouseLocation()
                                    local Dist = (Vector2.new(Pos.X, Pos.Y) - MousePos).Magnitude
                                    if Dist < ShortestDist then
                                        Target = p
                                        ShortestDist = Dist
                                    end
                                end
                            end
                        end
                    end

                    if Target then
                        local Part = _G.Aimbot.Headshot and Target.Character:FindFirstChild("Head") or Target.Character:FindFirstChild("HumanoidRootPart")
                        if Part then
                            -- SMOOTHING LOGIC (Biar gak kaku)
                            local TargetPos = Camera:WorldToScreenPoint(Part.Position)
                            local MousePos = game:GetService("UserInputService"):GetMouseLocation()
                            
                            -- Menggerakkan Kamera secara halus ke arah musuh
                            local LookAt = CFrame.new(Camera.CFrame.Position, Part.Position)
                            Camera.CFrame = Camera.CFrame:Lerp(LookAt, _G.Aimbot.Smoothness)
                        end
                    end
                end
            end)
        else
            OrionLib:MakeNotification({Name = "Error", Content = "Wrong Key!", Time = 3})
        end
    end
})

OrionLib:Init()
