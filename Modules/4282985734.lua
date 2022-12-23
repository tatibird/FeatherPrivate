task.wait(0.5)
shared["Feather-ClientConfigs"] = {
    StrokeTransparency = 0.75,
    Color = Color3.fromRGB(255,65,65),
    Watermark = true,
    Enabled = false
}
local lib
if shared["betterisfile"]("Feather-ClientConfigs/GuiLibrary") then
    lib = loadstring(readfile("Feather-ClientConfigs/GuiLibrary.lua"))()
else
    lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ln3242/Feather-Client/main/GuiLibrary.lua"))()
end
local getasset = getsynasset or getcustomasset
local ScreenGuitwo = game:GetService("CoreGui").RektskyNotificationGui
local lplr = game:GetService("Players").LocalPlayer
function runcode(func)
    func()
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

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")



ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.Position = UDim2.new(0.37873137, 0, 0, 0)
Frame.Size = UDim2.new(0.216417894, 0, 0.0667475611, 0)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0, 0, 0, -36)
TextLabel.Size = UDim2.new(0, 311, 0, 37)
TextLabel.Font = Enum.Font.Merriweather
TextLabel.Text = "Moderators can ban you at any time, Always use alts."--skid vape for now sorry
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextSize = 40.000

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

function getNearestPlayer(maxdist)
    local obj = lplr
    local dist = 99e99
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
--value





--functions

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
        ["Max"] = 0.70,
        ["Default"] = 0.70,
    })
end)


runcode(function()
    local Enabled = false
    local AutoParry = Tabs["Combat"]:CreateToggle({
        ["Name"] = "AutoParry/AnitParry",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                  local Magnitude = 15

local players = game:GetService("Players")
local client = players.LocalPlayer
local camera = workspace.CurrentCamera

local function iskeydown(enum)
   return game:GetService("UserInputService"):IsKeyDown(enum)
end
local function keyclick(enum)
   local vim = game:GetService("VirtualInputManager")
   return vim:SendKeyEvent(true, enum, false, game) and task.wait() and vim:SendKeyEvent(false, enum, false, game)
end

local function lookAt(character)
   spawn(function()
       for i=0, 1, 0.1  do
           local goal = camera.CFrame:Lerp(CFrame.lookAt(camera.CFrame.Position, character.HumanoidRootPart.Position), i)
           camera.CFrame = goal
           task.wait()
       end
   end)
end
local function islooking(chr, sensitivity)
   return chr.HumanoidRootPart.CFrame.LookVector:Dot(client.Character.HumanoidRootPart.Position) >= sensitivity
end






function Update(plr : Player)
   if plr ~= client then
       local function onRespawn(chr)
           local tool;
           repeat
               task.wait()
               if chr:FindFirstChild("SemiTransparentShield") and chr:FindFirstChild("HumanoidRootPart") and chr:FindFirstChildOfClass("Tool") and chr:FindFirstChildOfClass("Tool"):FindFirstChild("Hitboxes") then
                   tool = chr:FindFirstChildOfClass("Tool")
               end
           until tool and tool:IsA("Tool") and tool:FindFirstChild("Hitboxes")
           print(plr.DisplayName..":)")

           do -- [[Auto Parry]]
               local function autoParry(child)
                   if client.Character:FindFirstChildOfClass("Tool") and client.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Hitboxes") and child:IsA("Sound") and not iskeydown(Enum.KeyCode.C) and child:IsA("Sound") and (chr.HumanoidRootPart.Position - client.Character.HumanoidRootPart.Position).Magnitude < Magnitude then
                       local looking = islooking(chr, 0.25)
                       if looking then
                           keyclick(Enum.KeyCode.F)
                       else
                           lookAt(chr)
                           keyclick(Enum.KeyCode.F)
                       end
                   end
               end

               if tool.Hitboxes:FindFirstChild("Hitbox") then
                   print("applied")
                   tool.Hitboxes.Hitbox.ChildAdded:Connect(autoParry)
               elseif tool.Hitboxes:FindFirstChild("Weapon1Hitbox") and tool.Hitboxes:FindFirstChild("Weapon2Hitbox") then
                   print("applied")
                   tool.Hitboxes.Weapon1Hitbox.ChildAdded:Connect(autoParry)
                   tool.Hitboxes.Weapon2Hitbox.ChildAdded:Connect(autoParry)
               end
           end

           do -- [[Anti Parry]]
               local function antiParry(child)
                   if child:IsA("Sound") and client.Character:FindFirstChildOfClass("Tool") and client.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Hitboxes") and (chr.HumanoidRootPart.Position - client.Character.HumanoidRootPart.Position).Magnitude < Magnitude then
                       local looking = islooking(chr, 0.25)
                       if looking then
                           local tool = client.Character:FindFirstChildOfClass("Tool")
                           client.Character.Humanoid:UnequipTools()
                           chr.SemiTransparentShield:GetPropertyChangedSignal("Transparency"):Wait()
                           client.Character.Humanoid:EquipTool(tool)
                       end
                   end
               end
               chr.SemiTransparentShield.ChildAdded:Connect(antiParry)
           end
       end

       if plr.Character ~= nil then
           task.spawn(onRespawn, plr.Character)
       end
       plr.CharacterAdded:Connect(function(chr)
           warn('respawning', chr)
           task.spawn(onRespawn, chr)
       end)
   end
end

for _,v in next, players:GetPlayers() do
   task.spawn(Update, v)
end
players.PlayerAdded:Connect(function(plr)
   task.spawn(Update, plr)
end)
end
end

    })
end)

runcode(function()
    local Enabled = false
    local NewGravity = {["Value"] = 0}
    local Gravity = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Gravity",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    while task.wait() do
                        if not Enabled then return end
                        game:GetService("Workspace").Gravity = NewGravity["Value"]
                    end
                end)
            else
                game:GetService("Workspace").Gravity = 196.2
            end
        end
    })
    NewGravity = Gravity:CreateSlider({
        ["Name"] = "New",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 200,
        ["Default"] = 0,
        ["Round"] = 1
    })
end)

runcode(function()
    local Enabled = false
    local ArrayList = Tabs["Render"]:CreateToggle({
        ["Name"] = "ArrayList",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                shared["Feather-ClientConfigs"].Enabled = true
            else
                shared["CFeather-ClientConfigs"].Enabled = false
            end
        end
    })
end)

runcode(function()
    local Enabled = false
    local ArrayList = Tabs["Render"]:CreateToggle({
        ["Name"] = "Anti Radgoll",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                game:GetService("Players").LocalPlayer.Character.Humanoid.RagdollRemoteEvent:FireServer(false)
            end
        end
    })
end)


runcode(function()
    local Connection
    local Enabled = false
    local StaffDetector = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "StaffDetector",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                Connection = game:GetService("Players").PlayerAdded:Connect(function(v)
					if v:IsInGroup(5192826) and v:GetRankInGroup(5192826) >= 100 then
						CreateNotification("StaffDetector","Staff Joined..",60)
					elseif v:IsInGroup(16315665) and v:GetRankInGroup(16315665) >= 1 then
						CreateNotification("StaffDetector","Someone in SHRED_IMPACT group joined..",60)
					end
                end)
                for i,v in pairs(game:GetService("Players"):GetChildren()) do
					if v:IsInGroup(5192826) and v:GetRankInGroup(5192826) >= 100 then
						CreateNotification("StaffDetector","Staff Joined..",60)
					elseif v:IsInGroup(16315665) and v:GetRankInGroup(16315665) >= 1 then
						CreateNotification("StaffDetector","Someone in SHRED_IMPACT group joined..",60)
					end
                end
            else
                Connection:Disconnect()
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

runcode(function()
    local Enabled = false
    local getallemotes = Tabs["Render"]:CreateToggle({
        ["Name"] = "FreeEmotes",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                for i,v in pairs(getgc(true)) do
            if typeof(v) == "table" and rawget(v, "gamepassIdRequired") then
                if v.gamepassIdRequired ==  "danceEmotes" then
                    v.gamepassIdRequired = nil
                elseif v.gamepassIdRequired == "toxicEmotes" then
                    v.gamepassIdRequired = nil
                elseif v.gamepassIdRequired == "respectEmotes" then
                    v.gamepassIdRequired = nil
                end
            end
        end
   end
end
 })
end)

runcode(function()
    local Enabled = false
    local Night = Tabs["Render"]:CreateToggle({
        ["Name"] = "Night",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                game.Lighting.TimeOfDay = "1:00:00"
            else
               game.Lighting.TimeOfDay = "13:00:00"
            end
        end
    })
end)

--local plr1 = game.Players.LocalPlayer
--CreateNotification("Feather-Client","Logged in as "..(plr1.Name or plr1.DisplayName)",10)
