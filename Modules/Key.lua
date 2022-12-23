local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Key System", HidePremium = false, SaveConfig = true, ConfigFolder = "FeatherClient"})
OrionLib:MakeNotification({
    Name = "Logged in!",
    Content = "Welcome To Feather Client!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

_G.Key = "e!j@#0r27NPbi2!W"
_G.KeyInput = "string"

function MakeScriptHub()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Ln3242/Feather-Client/main/Modules/4282985734.lua"))()
    OrionLib:Destroy()
end

function CorrectKeyNotification()
    OrionLib:MakeNotification({
        Name = "Correct Key!",
        Content = "You had entered the correct key.",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

function InCorrectKeyNotification()
    OrionLib:MakeNotification({
        Name = "InCorrect Key!",
        Content = "You had entered the wrong key.",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end


local Tab = Window:MakeTab({
    Name = "Feather Client",
    Icon = "rbxassetid://11449961861",
    PremiumOnly = false
})

Tab:AddTextbox({
    Name = "Enter Key",
    Default = "Key Here",
    TextDisappear = true,
    Callback = function(Value)
        _G.KeyInput = Value
    end
})

Tab:AddButton({
    Name = "Check key!",
    Callback = function()
        if _G.KeyInput == _G.Key then
       MakeScriptHub()
       CorrectKeyNotification()
       else
           IncorrectKeyNotification()
        end
      end
})

Tab:AddLabel("Feather Client key in (discord.gg/VNHfjWvWcn)")

local p = game.Players.LocalPlayer
if p:IsInGroup(16218098) then                    
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Ln3242/Feather-Client/main/Modules/4282985734.lua"))()
      OrionLib:Destroy()
   end
