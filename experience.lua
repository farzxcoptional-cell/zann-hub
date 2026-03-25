local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "ZannHub | Blox Fruits Premium", HidePremium = false, SaveConfig = true, ConfigFolder = "ZannHubConfig"})

-- KONFIGURASI
_G.KeyBenar = "edisilebaran2026"
_G.KeySudahMasuk = false

-- TAB 1: LOGIN
local KeyTab = Window:MakeTab({Name = "Login System", Icon = "rbxassetid://4483345998", PremiumOnly = false})

KeyTab:AddTextbox({
    Name = "Masukkan Key",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        _G.InputUser = Value
    end      
})

KeyTab:AddButton({
    Name = "Check Key",
    Callback = function()
        if _G.InputUser == _G.KeyBenar then
            _G.KeySudahMasuk = true
            OrionLib:MakeNotification({Name = "ZannHub", Content = "Key Benar! Fitur Aktif.", Time = 5})
        else
            OrionLib:MakeNotification({Name = "ZannHub", Content = "Key Salah!", Time = 5})
        end
    end
})

-- TAB 2: FARMING (Langsung Muncul Tapi Terkunci)
local FarmTab = Window:MakeTab({Name = "Main Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false})

FarmTab:AddToggle({
    Name = "Auto Click",
    Default = false,
    Callback = function(Value)
        if _G.KeySudahMasuk then
            _G.AutoClick = Value
            while _G.AutoClick do
                local char = game.Players.LocalPlayer.Character
                if char:FindFirstChildOfClass("Tool") then
                    char:FindFirstChildOfClass("Tool"):Activate()
                end
                task.wait(0.1)
            end
        else
            OrionLib:MakeNotification({Name = "Error", Content = "Masukkan Key Dulu!", Time = 5})
        end
    end    
})

-- TAB 3: PREMIUM
local PremiumTab = Window:MakeTab({Name = "Super Premium", Icon = "rbxassetid://4483345998", PremiumOnly = false})

PremiumTab:AddButton({
    Name = "Anti-AFK (Bypass)",
    Callback = function()
        if _G.KeySudahMasuk then
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
            end)
            OrionLib:MakeNotification({Name = "Success", Content = "Anti-AFK Aktif!", Time = 5})
        else
            OrionLib:MakeNotification({Name = "Error", Content = "Masukkan Key Dulu!", Time = 5})
        end
    end
})

OrionLib:Init()
