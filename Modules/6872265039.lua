task.wait(0.5)
assert(getrawmetatable)
gmt = getrawmetatable(game)
setreadonly(gmt, false)
old = gmt.__namecall
gmt.__namecall = newcclosure(
	function(self, ...)
	local args = {...}
	if tostring(args[1]) == "RequestStatusUpdate" then
		return
	end
    return old(self, ...)
end)
shared["CometConfigs"] = {
    StrokeTransparency = 0.75,
    Color = Color3.fromRGB(255,65,65),
    Enabled = false
}

local lib
if shared["betterisfile"]("Feather-Client/GuiLibrary.lua") then
    lib = loadstring(readfile("Feather-Client/GuiLibrary.lua"))()
else
    lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ln3242/Feather-Client/main/GuiLibrary.lua"))()
end
local getasset = getsynasset or getcustomasset
local ScreenGuitwo = game:GetService("CoreGui").RektskyNotificationGui
local lplr = game:GetService("Players").LocalPlayer
local cam = game:GetService("Workspace").CurrentCamera
function CreateNotification(title, text, delay2)
    spawn(function()
        if ScreenGuitwo:FindFirstChild("Background") then ScreenGuitwo:FindFirstChild("Background"):Destroy() end
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 100, 0, 115)
        frame.Position = UDim2.new(0.5, 0, 0, -115)
        frame.BorderSizePixel = 0
        frame.AnchorPoint = Vector2.new(0.5, 0)
        frame.BackgroundTransparency = 0.5
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.Name = "Background"
        frame.Parent = ScreenGuitwo
        local frameborder = Instance.new("Frame")
        frameborder.Size = UDim2.new(1, 0, 0, 8)
        frameborder.BorderSizePixel = 0
        frameborder.BackgroundColor3 = Color3.fromRGB(205, 64, 78)
        frameborder.Parent = frame
        local frametitle = Instance.new("TextLabel")
        frametitle.Font = Enum.Font.SourceSansLight
        frametitle.BackgroundTransparency = 1
        frametitle.Position = UDim2.new(0, 0, 0, 30)
        frametitle.TextColor3 = Color3.fromRGB(205, 64, 78)
        frametitle.Size = UDim2.new(1, 0, 0, 28)
        frametitle.Text = "          "..title
        frametitle.TextSize = 24
        frametitle.TextXAlignment = Enum.TextXAlignment.Left
        frametitle.TextYAlignment = Enum.TextYAlignment.Top
        frametitle.Parent = frame
        local frametext = Instance.new("TextLabel")
        frametext.Font = Enum.Font.SourceSansLight
        frametext.BackgroundTransparency = 1
        frametext.Position = UDim2.new(0, 0, 0, 68)
        frametext.TextColor3 = Color3.new(1, 1, 1)
        frametext.Size = UDim2.new(1, 0, 0, 28)
        frametext.Text = "          "..text
        frametext.TextSize = 24
        frametext.TextXAlignment = Enum.TextXAlignment.Left
        frametext.TextYAlignment = Enum.TextYAlignment.Top
        frametext.Parent = frame
        local textsize = game:GetService("TextService"):GetTextSize(frametitle.Text, frametitle.TextSize, frametitle.Font, Vector2.new(100000, 100000))
        local textsize2 = game:GetService("TextService"):GetTextSize(frametext.Text, frametext.TextSize, frametext.Font, Vector2.new(100000, 100000))
        if textsize2.X > textsize.X then textsize = textsize2 end
        frame.Size = UDim2.new(0, textsize.X + 38, 0, 115)
        pcall(function()
            frame:TweenPosition(UDim2.new(0.5, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.15)
            game:GetService("Debris"):AddItem(frame, delay2 + 0.15)
        end)
    end)
end

local lplr = game:GetService("Players").LocalPlayer
local char = lplr.Character
local hrp = char.HumanoidRootPart
local hmd = char.Humanoid
local cam = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client

function runcode(func)
    func()
end

function IsAlive(plr)
    plr = plr or lplr
    if not plr.Character then return false end
    if not plr.Character:FindFirstChild("Head") then return false end
    if not plr.Character:FindFirstChild("Humanoid") then return false end
    if plr.Character:FindFirstChild("Humanoid").Health < 0.11 then return false end
    return true
end
function CanWalk(plr)
    plr = plr or lplr
    if not plr.Character then return false end
    if not plr.Character:FindFirstChild("Humanoid") then return false end
    local state = plr.Character:FindFirstChild("Humanoid"):GetState()
    if state == Enum.HumanoidStateType.Dead then
        return false
    end
    if state == Enum.HumanoidStateType.Ragdoll then
        return false
    end
    return true
end
function GetMatchState()
	return bedwars["ClientHandlerStore"]:getState().Game.matchState
end
function getNearestPlayer(maxdist)
    local obj = lplr
    local dist = math.huge
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        if v.Team ~= lplr.Team and v ~= lplr and IsAlive(v) then
            local mag = (v.Character:FindFirstChild("HumanoidRootPart").Position - lplr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
            if (mag < dist) and (mag < maxdist) then
                dist = mag
                obj = v
            end
        end
    end
    return obj
end

lib:CreateWindow()
local Tabs = {
    ["Combat"] = lib:CreateTab("Combat",Color3.fromRGB(252,80,68),"combat"),
    ["Blatant"] = lib:CreateTab("Blatant",Color3.fromRGB(255,148,36),"movement"),
    ["Render"] = lib:CreateTab("Render",Color3.fromRGB(59,170,222),"render"),
    ["Utility"] = lib:CreateTab("Utility",Color3.fromRGB(83,214,110),"player"),
    ["World"] = lib:CreateTab("World",Color3.fromRGB(52,28,228),"world"),
    ["Exploits"] = lib:CreateTab("Exploits",Color3.fromRGB(157,39,41),"exploit")
}

runcode(function()
    local clone
    local char
    local Enabled = false
    local Disabler = Tabs["Exploits"]:CreateToggle({
        ["Name"] = "Disabler",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                settings():GetService("NetworkSettings").IncomingReplicationLag = 99e99
                char = lplr.Character
                char.Archivable = true
                clone = char:Clone()
                clone.Parent = game:GetService("Workspace")
                cam.CameraSubject = clone:FindFirstChild("Humanoid")
                char.Parent = nil
                lplr.Character = clone
                clone:FindFirstChild("Animate").Disabled = true
                clone:FindFirstChild("Animate").Disabled = false
                clone:FindFirstChild("HumanoidRootPart").Anchored = false
                settings():GetService("NetworkSettings").IncomingReplicationLag = 0
            else
                settings():GetService("NetworkSettings").IncomingReplicationLag = 99e99
                clone:Destroy()
                char.Parent = game:GetService("Workspace")
                lplr.Character = char
                cam.CameraSubject = char:FindFirstChild("Humanoid")
                char:FindFirstChild("Animate").Disabled = true
                char:FindFirstChild("Animate").Disabled = false
                settings():GetService("NetworkSettings").IncomingReplicationLag = 0
            end
        end
    })
end)

runcode(function()
    local Enabled = false
    local Disabler = Tabs["Exploits"]:CreateToggle({
        ["Name"] = "DeathDisabler",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                lib["ToggleFuncs"]["DeathDisabler"](true)
                local hum = lplr.Character:FindFirstChild("Humanoid")
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead,true)
                hum:ChangeState(Enum.HumanoidRootPart.Dead)
                repeat task.wait() until hum.MoveDirection ~= Vector3.zero
                task.wait(0.2)
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead,false)
                hum:ChangeState(Enum.HumanoidRootPart.Running)
                CreateNotification("DeathDisabler","Anticheat Disabled!",5)
            end
        end
    })
end)

runcode(function()
    local function CapeFunction(char,texture)
        local hum = char:WaitForChild("Humanoid")
        local torso = nil
        if hum.RigType == Enum.HumanoidRigType.R15 then
            torso = char:WaitForChild("UpperTorso")
        else
            torso = char:WaitForChild("Torso")
        end
        local p = Instance.new("Part",torso.Parent)
        p.Name = "Cape"
        p.Anchored = false
        p.CanCollide = false
        p.TopSurface = 0
        p.FormFactor = "Custom"
        p.BottomSurface = 0
        p.Size = Vector3.new(0.2,0.2,0.2)
        p.Transparency = 1
        local decal = Instance.new("Decal",p)
        decal.Texture = texture
        decal.Face = "Back"
        local msh = Instance.new("BlockMesh",p)
        msh.Scale = Vector3.new(9,17.5,0.5)
        local motor = Instance.new("Motor",p)
        motor.Part0 = p
        motor.Part1 = torso
        motor.MaxVelocity = 0.01
        motor.C0 = CFrame.new(0,2,0) * CFrame.Angles(0,math.rad(90),0)
        motor.C1 = CFrame.new(0,1,0.45) * CFrame.Angles(0,math.rad(90),0)
        local wave = false
        repeat
            task.wait(1/44)
            decal.Transparency = torso.Transparency
            local ang = 0.1
            local oldmag = torso.Velocity.Magnitude
            local mv = 0.002
            if wave then
                ang = ang + ((torso.Velocity.Magnitude/10) * 0.05) + 0.05
                wave = false
            else
                wave = true
            end
            ang = ang + math.min(torso.Velocity.Magnitude/11,0.5)
            motor.MaxVelocity = math.min((torso.Velocity.Magnitude/111), 0.04)
            motor.DesiredAngle = -ang
            if motor.CurrentAngle < -0.2 and motor.DesiredAngle > -0.2 then
                motor.MaxVelocity = 0.04
            end
            repeat task.wait() until motor.CurrentAngle == motor.DesiredAngle or math.abs(torso.Velocity.Magnitude - oldmag) >= (torso.Velocity.Magnitude/10) + 1
            if torso.Velocity.Magnitude < 0.1 then
                task.wait(0.1)
            end
        until not p or p.Parent ~= torso.Parent
    end
    local Connection
    local Enabled = false
    local Cape = Tabs["Render"]:CreateToggle({
        ["Name"] = "Cape",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    CapeFunction(lplr.Character,getasset("rektsky/assets/cape.png"))
                end)
                Connection = lplr.CharacterAdded:Connect(function(v)
                    task.wait(1.5)
                    spawn(function()
                        CapeFunction(lplr.Character,getasset("rektsky/assets/cape.png"))
                    end)
                end)
            else
                Connection:Disconnect()
                if lplr.Character:FindFirstChild("Cape") then
                    lplr.Character:FindFirstChild("Cape"):Destroy()
                end
            end
        end
    })
end)

local LCE = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"].lobby.out.client.events).LobbyClientEvents
local queuemeta = require(game:GetService("ReplicatedStorage").TS.game["queue-meta"]).QueueMeta

local function getQueueFromName(name)
    for i,v in pairs(queuemeta) do 
        if v.title == name and i:find("voice") == nil then
            return i
        end
    end
    return "bedwars_to1"
end

do
    local aqtoggled = false
    local AQMode = {["Value"] = "bedwars_to1"}
    local aqtog = Tabs["Render"]:CreateToggle({
        ["Name"] = "AutoQueue",
        ["Callback"] = function(v)
            aqtoggled = v
            if (aqtoggled) then
                LCE.joinQueue({
                    queueType = getQueueFromName(AQMode["Value"])
                })
            else
                LCE.leaveQueue:fire()
            end
        end
    })
    AQMode = aqtog:CreateDropDown({
        ["Name"] = "AQMode",
        ["Function"] = function(val) 
            if aqtog["Enabled"] then
                LCE.leaveQueue:fire()
                wait(0.5)
                LCE.joinQueue({
                    queueType = getQueueFromName(val)
                })
            end
        end,
        ["List"] = {},
        ["Default"] = "BedWars (Solo)"
    })
    for i,v in pairs(queuemeta) do 
        if v.title:find("Test") == nil then
            table.insert(AQMode["List"], v.title..(i:find("voice") and " (VOICE)" or "")) 
        end
    end
    for i, v in pairs(AQMode["List"]) do
        print(i, v)
    end
end
runcode(function()
    local SpeedVal = {["Value"] = 0.70}
    local Enabled = false
    local Mode = {["Value"] = "CFrame"}
    local Speed = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Speed",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    while task.wait() do
                        if not Enabled then return end
                        if IsAlive(lplr) and isnetworkowner(lplr.Character:FindFirstChild("HumanoidRootPart")) then
                            local hum = lplr.Character:FindFirstChild("Humanoid")
                            if hum.MoveDirection.Magnitude > 0 then
                                lplr.Character:TranslateBy(hum.MoveDirection * SpeedVal["Value"])
                            end
                        end
                    end
                end)
            end
        end
    })
    SpeedVal = Speed:CreateSlider({
        ["Name"] = "CFSpeed",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 1,
        ["Default"] = 1,
    })
end)


runcode(function()
    local Connection
    local Connection2
    local flydown = false
    local flyup = false
    local velo
    local Enabled = false
    local Mode = {["Value"] = "Long"}
    local Fly = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Fly",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    velo = Instance.new("BodyVelocity")
                    velo.MaxForce = Vector3.new(0,9e9,0)
                    velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
                    Connection = uis.InputBegan:Connect(function(input)
                        if input.KeyCode == Enum.KeyCode.Space then
                            flyup = true
                        end
                        if input.KeyCode == Enum.KeyCode.LeftShift then
                            flydown = true
                        end
                    end)
                    Connection2 = uis.InputEnded:Connect(function(input)
                        if input.KeyCode == Enum.KeyCode.Space then
                            flyup = false
                        end
                        if input.KeyCode == Enum.KeyCode.LeftShift then
                            flydown = false
                        end
                    end)
                    spawn(function()
                        while task.wait() do
                            if not Enabled then return end
                            if Mode["Value"] == "Long" then
                               for i = 1,15 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,i*1.25+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                                velo.Velocity = Vector3.new(0,0,0)
                                task.wait(0.05)
                                for i = 1,15 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,-i*1+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                                task.wait(0.05)
                                velo.Velocity = Vector3.new(0,0,0)
                            else
                                Mode["Value"] = "Long"
                                lib["ToggleFuncs"]["Fly"](true)
                                task.wait(0.1)
                                lib["ToggleFuncs"]["Fly"](true)
                            end
                        end
                    end)
                end)
            else
                velo:Destroy()
                Connection:Disconnect()
                Connection2:Disconnect()
                flyup = false
                flydown = false
            end
        end
    })
    Mode = Fly:CreateDropDown({
        ["Name"] = "Mode",
        ["Function"] = function(v) 
            Mode["Value"] = v
        end,
        ["List"] = {"Long"},
        ["Default"] = "Long"
    })
end)
