local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- 1. KONFIGURASI KEY (Ganti sesukamu nanti)
_G.CorrectKey = "edisilebaran2026"

local Window = OrionLib:MakeWindow({
    Name = "ZannHub | Blox Fruits Premium", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "ZannHubConfig"
})

-- FUNGSI UNTUK MEMUNCULKAN MENU UTAMA (WAJIB DI ATAS)
function BukaMenuUtama()
    local FarmTab = Window:MakeTab({
        Name = "Main Farm",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    FarmTab:AddToggle({
        Name = "Auto Click (Melee/Sword)",
        Default = false,
        Callback = function(Value)
            _G.AutoClick = Value
            while _G.AutoClick do
                local char = game.Players.LocalPlayer.Character
                if char:FindFirstChildOfClass("Tool") then
                    char:FindFirstChildOfClass("Tool"):Activate()
                end
                task.wait(0.1)
            end
        end    
    })

    FarmTab:AddToggle({
        Name = "Auto Buso Haki",
        Default = false,
        Callback = function(Value)
            _G.AutoHaki = Value
            while _G.AutoHaki do
                local char = game.Players.LocalPlayer.Character
                if not char:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end
                task.wait(1)
            end
        end
    })

    local PremiumTab = Window:MakeTab({
        Name = "Super Premium",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    PremiumTab:AddButton({
        Name = "Activate Bypass & Anti-AFK",
        Callback = function()
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
            end)
            OrionLib:MakeNotification({Name = "ZannHub", Content = "Bypass Aktif!", Time = 5})
        end
    })
end

-- 2. TAB LOGIN (INI YANG MUNCUL PERTAMA)
local KeyTab = Window:MakeTab({
    Name = "Login System",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

KeyTab:AddTextbox({
    Name = "Masukkan Key ZannHub",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        _G.KeyInput = Value
    end      
})

KeyTab:AddButton({
    Name = "Check Key",
    Callback = function()
        if _G.KeyInput == _G.CorrectKey then
            OrionLib:MakeNotification({Name = "Success", Content = "Key Benar! Membuka Fitur...", Time = 5})
            BukaMenuUtama() -- Ini yang bikin menu farm muncul
        else
            OrionLib:MakeNotification({Name = "Error", Content = "Key Salah! Hubungi Zann.", Time = 5})
        end
    end
})

OrionLib:Init()
