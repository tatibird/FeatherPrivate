--[[
     CREDITS
     Damc Killaura and Nuker
     Spring67 Killaura and Nuker
--]]


task.wait(0.5)
shared["Feather-ClientConfigs"] = {
    StrokeTransparency = 0.75,
    Color = Color3.fromRGB(255,65,65),
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
local uis = game:GetService("UserInputService")
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
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	cam = (workspace.CurrentCamera or workspace:FindFirstChildWhichIsA("Camera") or Instance.new("Camera"))
end)
--value

runcode(function()
    local SpeedVal = {["Value"] = 1}
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



--functions

runcode(function()
    local Enabled = false
    local Watermark = {["Enabled"] = true}
    local ArrayList = Tabs["Render"]:CreateToggle({
        ["Name"] = "ArrayList",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                shared["Feather-ClientConfigs"].Enabled = true
            else
                shared["Feather-ClientConfigs"].Enabled = false
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
    local velo
    local Enabled = false
    local HighJump = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "HighJump",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
                velo = Instance.new("BodyVelocity")
                velo.Velocity = Vector3.new(0,0,0)
                velo.MaxForce = Vector3.new(0,9e9,0)
                velo.Parent = hrp
                spawn(function()
                    while task.wait() do
                        if not Enabled then return end
                        for i = 1,20 do
                            task.wait()
                            if not Enabled then return end
                            velo.Velocity = velo.Velocity + Vector3.new(0,i*0.50,0)
                        end
                    end
                end)
            else
                if velo then
                    velo:Destroy()
                    velo = nil
                end
            end
        end
    })
end)



runcode(function()
    local Enabled = false
    local InstaKillExploit = Tabs["Combat"]:CreateToggle({
        ["Name"] = "InstaKillExploit",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                _G.InstaKillExploit = true
			while _G.InstaKillExploit do wait()
				if workspace[game.Players.LocalPlayer.Name]:FindFirstChild("wood_sword") then
					local args = {
						[1] = {
							[1] = {
								[1] = "\18",
								[2] = "wood_sword",
								[3] = nil,
								[4] = Vector3.new(-0.6882433295249939, -5.313460338385312e-09, -0.7254799008369446),
								[5] = {
									[1] = nil,
									[2] = nil,
									[3] = nil,
									[4] = nil,
									[5] = nil,
									[6] = nil,
									[7] = nil,
									[8] = nil,
									[9] = nil,
									[10] = nil,
									[11] = nil,
									[12] = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg,
									[13] = game:GetService("Players").LocalPlayer.Character.LeftFoot,
									[14] = game:GetService("Players").LocalPlayer.Character.RightFoot,
									[15] = game:GetService("Players").LocalPlayer.Character.RightLowerLeg,
									[16] = game:GetService("Players").LocalPlayer.Character.RightUpperLeg,
									[17] = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg,
									[18] = game:GetService("Players").LocalPlayer.Character.LeftHand,
									[19] = game:GetService("Players").LocalPlayer.Character.LeftLowerArm,
									[20] = game:GetService("Players").LocalPlayer.Character.LowerTorso,
									[21] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
									[22] = game:GetService("Players").LocalPlayer.Character.UpperTorso,
									[23] = game:GetService("Players").LocalPlayer.Character.RightLowerArm,
									[24] = game:GetService("Players").LocalPlayer.Character.wood_sword.Handle,
									[25] = game:GetService("Players").LocalPlayer.Character.wood_sword.SwordPart,
									[26] = game:GetService("Players").LocalPlayer.Character.RightUpperArm,
									[27] = game:GetService("Players").LocalPlayer.Character.LeftUpperArm,
									[28] = nil,
									[29] = game:GetService("Players").LocalPlayer.Character.RightHand,
									[30] = game:GetService("Players").LocalPlayer.Character.wood_sword.SwordPart,
									[31] = game:GetService("Players").LocalPlayer.Character.wood_sword.SwordPart,
									[32] = game:GetService("Players").LocalPlayer.Character.Head,
									[33] = nil
								}
							}
						}
					}

					game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
				end
			end
            else
              _G.InstaKillExploit = false
			while _G.InstaKillExploit do wait()
				if workspace[game.Players.LocalPlayer.Name]:FindFirstChild("wood_sword") then
					local args = {
						[1] = {
							[1] = {
								[1] = "\18",
								[2] = "wood_sword",
								[3] = nil,
								[4] = Vector3.new(-0.6882433295249939, -5.313460338385312e-09, -0.7254799008369446),
								[5] = {
									[1] = nil,
									[2] = nil,
									[3] = nil,
									[4] = nil,
									[5] = nil,
									[6] = nil,
									[7] = nil,
									[8] = nil,
									[9] = nil,
									[10] = nil,
									[11] = nil,
									[12] = game:GetService("Players").LocalPlayer.Character.LeftLowerLeg,
									[13] = game:GetService("Players").LocalPlayer.Character.LeftFoot,
									[14] = game:GetService("Players").LocalPlayer.Character.RightFoot,
									[15] = game:GetService("Players").LocalPlayer.Character.RightLowerLeg,
									[16] = game:GetService("Players").LocalPlayer.Character.RightUpperLeg,
									[17] = game:GetService("Players").LocalPlayer.Character.LeftUpperLeg,
									[18] = game:GetService("Players").LocalPlayer.Character.LeftHand,
									[19] = game:GetService("Players").LocalPlayer.Character.LeftLowerArm,
									[20] = game:GetService("Players").LocalPlayer.Character.LowerTorso,
									[21] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
									[22] = game:GetService("Players").LocalPlayer.Character.UpperTorso,
									[23] = game:GetService("Players").LocalPlayer.Character.RightLowerArm,
									[24] = game:GetService("Players").LocalPlayer.Character.wood_sword.Handle,
									[25] = game:GetService("Players").LocalPlayer.Character.wood_sword.SwordPart,
									[26] = game:GetService("Players").LocalPlayer.Character.RightUpperArm,
									[27] = game:GetService("Players").LocalPlayer.Character.LeftUpperArm,
									[28] = nil,
									[29] = game:GetService("Players").LocalPlayer.Character.RightHand,
									[30] = game:GetService("Players").LocalPlayer.Character.wood_sword.SwordPart,
									[31] = game:GetService("Players").LocalPlayer.Character.wood_sword.SwordPart,
									[32] = game:GetService("Players").LocalPlayer.Character.Head,
									[33] = workspace.PlacedItems.UnseperatedMap.concrete.concrete
								}
							}
						}
					}

					game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
				end

			end
		end
	end
    })
end)

runcode(function()
    local SpeedVal = {["Value"] = 1}
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
    local Enabled = false
    local Nuker = Tabs["World"]:CreateToggle({
        ["Name"] = "Nuker",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                Nuker1 = true
            repeat task.wait(0.1)
                for _,v in pairs(workspace.PlacedItems:GetChildren()) do
                        local args = {
                            [1] = {
                                [1] = {
                                    [1] = "\11",
                                    [2] = "wooden_pickaxe",

                                    [3] = v
                                }
                            }
                        }

                        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
                    end
            until not Nuker1
		else
			Nuker1 = false
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
        ["Function"] = function(v)
            if Enabled then
                game:GetService("Workspace").Gravity = v
            end
        end,
        ["Min"] = 0,
        ["Max"] = 200,
        ["Default"] = 0,
        ["Round"] = 10
    })
end)
