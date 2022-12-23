repeat task.wait() until game:IsLoaded()
--local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
--game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    --if State == Enum.TeleportState.Started then
        --queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/EZEZEZEZZE/FeatherPrivatet/main/mainscript.lua'))()")
    --end
--end)


function betterisfile(path)
    local suc, res = pcall(function() return readfile(path) end)
    return suc and res ~= nil
end
shared["betterisfile"] = betterisfile
local placeid = game.PlaceId
if placeid == 6872274481 or placeid == 8560631822 or placeid == 8444591321 then
    if betterisfile("Feather-Client/Modules/Bedwars.lua") then
        loadstring(readfile("Feather-Client/Modules/Bedwars.lua"))()
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EZEZEZEZZE/FeatherPrivate/main/Modules/Bedwars.lua"))()
    end
elseif placeid == 6872265039 then
    if betterisfile("Feather-Client/Modules/6872265039.lua") then
        loadstring(readfile("CometV2/Modules/6872265039.lua"))()
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EZEZEZEZZE/FeatherPrivate/main/Modules/6872265039.lua"))()
    end
elseif placeid == 4282985734 then
    if betterisfile("Feather-Client/Modules/4282985734.lua") then
        loadstring(readfile("Feather-Client/Modules/4282985734.lua"))()
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EZEZEZEZZE/FeatherPrivate/main/Modules/Key.lua"))()
    end
elseif placeid == 11640391378 then
    if betterisfile("Feather-Client/Modules/11640391378.lua") then
        loadstring(readfile("CometV2/Modules/11640391378.lua"))()
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EZEZEZEZZE/FeatherPrivate/main/Modules/11640391378.lua"))()
    end
else
    if betterisfile("Feather-Client/Modules/Universal.lua") then
        loadstring(readfile("Feather-Client/Modules/Universal.lua"))()
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EZEZEZEZZE/FeatherPrivate/main/Modules/Universal.lua"))()
    end
end
