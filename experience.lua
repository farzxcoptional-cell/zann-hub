local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "ZannHub | Blox Fruits Premium", HidePremium = false, SaveConfig = true, ConfigFolder = "ZannHubConfig"})

-- CONFIG KEY
_G.KeyBenar = "edisilebaran2026"

-- TAB LOGIN (WAJIB ADA)
local KeyTab = Window:MakeTab({
	Name = "Login System",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

KeyTab:AddTextbox({
	Name = "Masukkan Key",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		_G.KeyInput = Value
	end	  
})

KeyTab:AddButton({
	Name = "Check Key",
	Callback = function()
		if _G.KeyInput == _G.KeyBenar then
			OrionLib:MakeNotification({
				Name = "ZannHub Success",
				Content = "Key Benar! Membuka Fitur Banana...",
				Time = 5
			})
			-- MEMANGGIL SCRIPT UTAMA (BANANA HUB ENGINE)
			loadstring(game:HttpGet("https://raw.githubusercontent.com/ObiWanHuji/BananaHub/main/BananaHub.lua"))()
		else
			OrionLib:MakeNotification({
				Name = "ZannHub Error",
				Content = "Key Salah! Hubungi Admin.",
				Time = 5
			})
		end
	end
})

OrionLib:Init()
