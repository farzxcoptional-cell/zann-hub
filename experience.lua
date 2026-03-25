local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- 1. KONFIGURASI KEY (zannhubbb! )
local CorrectKey = "edisilebaran2026"

local Window = OrionLib:MakeWindow({
    Name = "ZannHub | Blox Fruits Super Premium", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "ZannHubConfig"
})

-- 2. TAB LOGIN (Hanya ini yang muncul pertama kali)
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
		if _G.KeyInput == CorrectKey then
			OrionLib:MakeNotification({
				Name = "ZannHub Success",
				Content = "Key Benar! Membuka Fitur Premium...",
				Time = 5
			})
			-- MEMANGGIL SEMUA FITUR DI BAWAH
			ZannMainFeatures()
		else
			OrionLib:MakeNotification({
				Name = "ZannHub Error",
				Content = "Key Salah!.",
				Time = 5
			})
		end
	end
})

-- 3. SEMUA FITUR DIMASUKKAN KE DALAM FUNGSI INI
function ZannMainFeatures()
    -- Tab Farming
    local FarmTab = Window:MakeTab({
        Name = "Zann Farming",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    FarmTab:AddToggle({
        Name = "Auto Click (Melee/Sword)",
        Default = false,
        Callback = function(Value)
            _G.ZannAutoClick = Value
            while _G.ZannAutoClick do
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

    -- Tab Bypass & Premium
    local PremiumTab = Window:MakeTab({
        Name = "Super Bypass",
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
            OrionLib:MakeNotification({
                Name = "ZannHub Premium",
                Content = "Bypass & Anti-Kick Aktif!",
                Time = 5
            })
        end
    })
    
    -- Tab Info Akun (Biar harga jual naik)
    local InfoTab = Window:MakeTab({
        Name = "Account Info",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    
    InfoTab:AddLabel("Status: ZannHub Premium User")
    InfoTab:AddLabel("Build: 2026 March Edition")
end

OrionLib:Init()
