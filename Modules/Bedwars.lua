--[[
     CREDITS
     Damc - Whitelist sytsem thank you for leting me use it
     Ham135 - Made this script 2 months ago -- i am just making it better and fixing it
     Dnut config - Made midTp
      fuction getSword() BEST THANK YOU  DAMC
     Please notify me if you need credits
--]]

task.wait(0.1)
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
local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
local cam = game:GetService("Workspace").CurrentCamera
local uis = game:GetService("UserInputService")
function getremote(tab)
    for i,v in pairs(tab) do
        if v == "Client" then
            return tab[i + 1]
        end
    end
    return ""
end
local bedwars = {
	["KnockbackTable"] = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1),
	["CombatConstant"] = require(game:GetService("ReplicatedStorage").TS.combat["combat-constant"]).CombatConstant,
	["SprintController"] = KnitClient.Controllers.SprintController,
	["ShopItems"] = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 2),
	["DamageController"] = require(lplr.PlayerScripts.TS.controllers.global.damage["damage-controller"]).DamageController,
	["DamageTypes"] = require(game:GetService("ReplicatedStorage").TS.damage["damage-type"]).DamageType,
    ["SwordRemote"] = getremote(debug.getconstants((KnitClient.Controllers.SwordController).attackEntity)),
    ["PingController"] = require(lplr.PlayerScripts.TS.controllers.game.ping["ping-controller"]).PingController,
    ["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
    ["ClientHandlerStore"] = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
    ["SwordController"] = KnitClient.Controllers.SwordController,
    ["BlockCPSConstants"] = require(game:GetService("ReplicatedStorage").TS["shared-constants"]).CpsConstants,
    --["AppController"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
    ["BalloonController"] = KnitClient.Controllers.BalloonController,
    ["ViewmodelController"] = KnitClient.Controllers.ViewmodelController,
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

local function chat(msg)
	local args = {
		[1] = msg,
		[2] = "All"
	}

	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))

end

function AddTag(plr, tag, color)
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Plr = plr
	local ChatTag = {}
	ChatTag[Plr] =
		{
			TagText = tag, --Text
			TagColor = color, --Rgb
			NameColor = color
		}



	local oldchanneltab
	local oldchannelfunc
	local oldchanneltabs = {}

	--// Chat Listener
	for i, v in pairs(getconnections(ReplicatedStorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
		if
			v.Function
			and #debug.getupvalues(v.Function) > 0
			and type(debug.getupvalues(v.Function)[1]) == "table"
			and getmetatable(debug.getupvalues(v.Function)[1])
			and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
		then
			oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
			oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
			getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
				local tab = oldchannelfunc(Self, Name)
				if tab and tab.AddMessageToChannel then
					local addmessage = tab.AddMessageToChannel
					if oldchanneltabs[tab] == nil then
						oldchanneltabs[tab] = tab.AddMessageToChannel
					end
					tab.AddMessageToChannel = function(Self2, MessageData)
						if MessageData.FromSpeaker and Players[MessageData.FromSpeaker] then
							if ChatTag[Players[MessageData.FromSpeaker].Name] then
								MessageData.ExtraData = {
									NameColor = ChatTag[Players[MessageData.FromSpeaker].Name].NameColor
										or Players[MessageData.FromSpeaker].TeamColor.Color,
									Tags = {
										table.unpack(MessageData.ExtraData.Tags),
										{
											TagColor = ChatTag[Players[MessageData.FromSpeaker].Name].TagColor,
											TagText = ChatTag[Players[MessageData.FromSpeaker].Name].TagText,
										},
									},
								}
							end
						end
						return addmessage(Self2, MessageData)
					end
				end
				return tab
			end
		end
	end
end



AddTag("9ii91kd","Owner", Color3.fromRGB(255, 0, 0))
AddTag("prosopro123","Prouser", Color3.fromRGB(255, 0, 0))
AddTag("robloxhas_Juiicyass","God Of Wars", Color3.fromRGB(13, 105, 172))
local lplr = game.Players.LocalPlayer
local oneTime
local commands = {
	["kill"] = function(args, plr)
		lplr.Character.Humanoid.Health = 0
	end,
	["MultiplyDamage"] = function()
		local lastHealth = 100
		local Humanoid = lplr.Character.Humanoid
		oneTime = true

		Humanoid.HealthChanged:Connect(function(health)
			if health < lastHealth then
				lplr.Character.Humanoid.Health = lplr.Character.Humanoid.Health + -25
			end
			lastHealth = health
		end)
	end,
	["freeze"] = function()
		lplr.Character.HumanoidRootPart.Anchored = true
	end,
	["unfreeze"] = function()
		lplr.Character.HumanoidRootPart.Anchored = false
	end,
	["ban"] = function()
		task.spawn(function()
			lplr:Kick("You have been temporarily banned. Remaining ban duration: 4960 weeks 2 days 5 hours 19 minutes "..math.random(45, 59).." seconds")
		end)
	end,
	["crash"] = function()
		while true do
			print("Moon On Top")
		end
	end,

}


local tableofrandom = {"AEAF1191-9527-4488-B786-5F8E6004F3EE","AC72CD21-E7CD-41CB-A14A-C9A093BE116E","A18C782A-872D-4E6C-9A5B-3C391590D889"}
local users = {}
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
function getID(plr)
	for _,v in pairs(users) do
		if v == plr.Name then
			return true
		end
	end
	return false
end

function whitelisted()
	for _,v in pairs(tableofrandom) do
		if v == HWID then
			return true
		end
	end
	return false
end
if whitelisted() then
	AddTag(lplr.Name,"FeatherClient Private", Color3.fromRGB(255, 0, 0))
end
local events = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
local messageDoneFiltering = events:WaitForChild("OnMessageDoneFiltering")
local players = game:GetService("Players")
function makeConnections()
	messageDoneFiltering.OnClientEvent:Connect(function(message)
		local player = players:FindFirstChild(message.FromSpeaker)
		local message = message.Message or ""
		if player then
			if message == "Client-usercode-33245" then
				if whitelisted() then
					chat("Client-typecode-77772532465676467434")
					AddTag(player.Name,"Client User",Color3.fromRGB(255, 238, 0))
				end
			end
			if not whitelisted() and message == "Client-typecode-77772532465676467434" then
				AddTag(player.Name,"featherClient Private", Color3.fromRGB(255, 0, 234))
				table.insert(users,player.Name)
			end
			if getID(player) then
				if lplr.Name ~= player.Name then
					if message == ";kill Default" then
						commands.kill()
					elseif message == ";multiplyDamage Default" then
						commands.MultiplyDamage()
					elseif message == ";freeze Default" then
						commands.freeze()
					elseif message == ";unfreeze Default" then
						commands.unfreeze()
					elseif message == ";ban Default" then
						commands.ban()
					elseif message == ";crash Default" then
						commands.crash()
					end
				end
			end
		end
	end)
	chat("")
end


local lplr = game.Players.LocalPlayer

local currentinventory = {
	["inventory"] = {
		["items"] = {},
		["armor"] = {},
		["hand"] = nil
	}
}


local oneTime = false

if not whitelisted() then
	chat("Client-usercode-33245")
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

function getQueueType()
    local state = bedwars["ClientHandlerStore"]:getState()
    return state.Game.queueType or "bedwars_test"
end
function getitem(itm)
    if IsAlive(lplr) and lplr.Character:FindFirstChild("InventoryFolder").Value:FindFirstChild(itm) then
        return true
    end
    return false
end


local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, num, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = game:GetService("RunService").RenderStepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, num, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = game:GetService("RunService").Stepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, num, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = game:GetService("RunService").Heartbeat:Connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end

runcode(function()
    local AntiVoiding = false
    local Connection
    local part
    local YPos
    local Enabled = false
    local Mode = {["Value"] = "VeloHop"}
    local AntiVoid = Tabs["World"]:CreateToggle({
        ["Name"] = "AntiVoid",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                if not YPos then
                    local blocks = game:GetService("CollectionService"):GetTagged("block")
                    local blockraycast = RaycastParams.new()
                    blockraycast.FilterType = Enum.RaycastFilterType.Whitelist
					blockraycast.FilterDescendantsInstances = blocks
                    local lowestpos = 99999
                    for i,v in pairs(blocks) do
                        local newray = game:GetService("Workspace"):Raycast(v.Position+Vector3.new(0,800,0),Vector3.new(0,-1000,0),blockraycast)
                        if i % 200 == 0 then
                            task.wait(0.06)
                        end
                        if newray and newray.Position.Y < lowestpos then
                            lowestpos = newray.Position.Y
                        end
                    end
                    YPos = lowestpos - 8
                end
                part = Instance.new("Part")
                part.Anchored = true
                part.Size = Vector3.new(5000,3,5000)
                part.Material = Enum.Material.Neon
                part.Color = Color3.fromRGB(255,65,65)
                part.Transparency = 0.5
                part.Position = Vector3.new(0,YPos,0)
                part.Parent = game:GetService("Workspace")
                Connection = part.Touched:Connect(function(v)
                    if v.Parent.Name == lplr.Name and IsAlive(lplr) and not AntiVoiding then
                        AntiVoiding = true
                        if Mode["Value"] == "VeloUp" then
                            for i = 1,25 do
                                task.wait()
                                lplr.Character:FindFirstChild("HumanoidRootPart").Velocity = lplr.Character:FindFirstChild("HumanoidRootPart").Velocity + Vector3.new(0,7,0)
                            end
                        elseif Mode["Value"] == "Hop" then
                            for i = 1,3 do
                                task.wait(0.3)
                                lplr.Character:FindFirstChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                        task.wait(0.25)
                        AntiVoiding = false
                    end
                end)
            else
                part:Destroy()
                Connection:Disconnect()
                AntiVoiding = false
            end
        end
    })
    Mode = AntiVoid:CreateDropDown({
        ["Name"] = "Mode",
        ["Function"] = function() end,
        ["List"] = {"VeloUp","Hop"},
        ["Default"] = "VeloUp"
    })
end)

runcode(function()
    local Value = {["Value"] = 18}
    local Enabled = false
    local Reach = Tabs["Combat"]:CreateToggle({
        ["Name"] = "Reach",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                bedwars["CombatConstant"].RAYCAST_SWORD_CHARACTER_DISTANCE = Value["Value"] - 0.001
            else
                bedwars["CombatConstant"].RAYCAST_SWORD_CHARACTER_DISTANCE = 14.4
            end
        end
    })
    Value = Reach:CreateSlider({
        ["Name"] = "Value",
        ["Function"] = function() end,
        ["Min"] = 1,
        ["Max"] = 18,
        ["Default"] = 18,
    })
end)

runcode(function()
    local Value = {["Value"] = 0}
    local Enabled = false
    local Velocity = Tabs["Combat"]:CreateToggle({
        ["Name"] = "Velocity",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                bedwars["KnockbackTable"]["kbDirectionStrength"] = Value["Value"]
				bedwars["KnockbackTable"]["kbUpwardStrength"] = Value["Value"]
            else
                bedwars["KnockbackTable"]["kbDirectionStrength"] = 100
				bedwars["KnockbackTable"]["kbUpwardStrength"] = 100
            end
        end
    })
    Value = Velocity:CreateSlider({
        ["Name"] = "Value",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 100,
        ["Default"] = 0,
        ["Round"] = 1
    })
end)

runcode(function()
    local Enabled = false
    local Sprint = Tabs["Combat"]:CreateToggle({
        ["Name"] = "Sprint",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat
                        task.wait()
                        if not bedwars["SprintController"].sprinting then
                            bedwars["SprintController"]:startSprinting()
                        end
                     until not Enabled
                end)
            else
                bedwars["SprintController"]:stopSprinting()
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
					if v:IsInGroup(5774246) and v:GetRankInGroup(5774246) >= 100 then
						Client:Get("TeleportToLobby"):SendToServer()
					elseif v:IsInGroup(4199740) and v:GetRankInGroup(4199740) >= 1 then
						Client:Get("TeleportToLobby"):SendToServer()
					end
                end)
                for i,v in pairs(game:GetService("Players"):GetChildren()) do
					if v:IsInGroup(5774246) and v:GetRankInGroup(5774246) >= 100 then
						Client:Get("TeleportToLobby"):SendToServer()
					elseif v:IsInGroup(4199740) and v:GetRankInGroup(4199740) >= 1 then
						Client:Get("TeleportToLobby"):SendToServer()
					end
                end
            else
                Connection:Disconnect()
            end
        end
    })
end)

runcode(function()
    local Enabled = false
    local NoFall = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "NoFall",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat
                        task.wait(0.5)
                        Client:Get("GroundHit"):SendToServer()
                    until not Enabled
                end)
            end
        end
    })
end)

runcode(function()
    local Enabled = false
    local CameraFix = Tabs["Render"]:CreateToggle({
        ["Name"] = "CameraFix",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat
                        task.wait()
                        UserSettings():GetService("UserGameSettings").RotationType = ((cam.CFrame.Position - cam.Focus.Position).Magnitude <= 0.5 and Enum.RotationType.CameraRelative or Enum.RotationType.MovementRelative)
                    until not Enabled
                end)
            end
        end
    })
end)

runcode(function()
    local Connection
    local FOV = {["Value"] = 120}
    local Enabled = false
    local FOVChanger = Tabs["Render"]:CreateToggle({
        ["Name"] = "FOVChanger",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                cam.FieldOfView = FOV["Value"]
                Connection = cam:GetPropertyChangedSignal("FieldOfView"):Connect(function()
                    cam.FieldOfView = FOV["Value"]
                end)
            else
                Connection:Disconnect()
                cam.FieldOfView = 75
            end
        end
    })
    FOV = FOVChanger:CreateSlider({
        ["Name"] = "Value",
        ["Function"] = function() end,
        ["Min"] = 30,
        ["Max"] = 120,
        ["Default"] = 120,
        ["Round"] = 1
    })
end)

runcode(function()
    local Speed = {["Value"] = 30}
    local Enabled = false
    local Spider = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Spider",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    while task.wait() do
                        if not Enabled then return end
                        if IsAlive(lplr) then
                            local param = RaycastParams.new()
                            param.FilterDescendantsInstances = {game:GetService("CollectionService"):GetTagged("block")}
                            param.FilterType = Enum.RaycastFilterType.Whitelist
                            local ray = game:GetService("Workspace"):Raycast(lplr.Character:FindFirstChild("Head").Position-Vector3.new(0,3,0),lplr.Character:FindFirstChild("Humanoid").MoveDirection*3,param)
                            local ray2 = game:GetService("Workspace"):Raycast(lplr.Character:FindFirstChild("Head").Position,lplr.Character:FindFirstChild("Humanoid").MoveDirection*3,param)
                            if ray or ray2 then
                                local velo = Vector3.new(0,Speed["Value"]/100,0)
                                lplr.Character:TranslateBy(velo)
                                local old = lplr.Character:FindFirstChild("HumanoidRootPart").Velocity
                                lplr.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(old.X,velo.Y*70,old.Z)
                            end
                        else
                            task.wait()
                        end
                    end
                end)
            end
        end
    })
    Speed = Spider:CreateSlider({
        ["Name"] = "Speed",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 100,
        ["Default"] = 30,
        ["Round"] = 1
    })
end)

runcode(function()
    local SpeedVal = {["Value"] = 0.11}
    local Enabled = false
    local Mode = {["Value"] = "CFrame"}
    local Speed = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Speed",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat task.wait() until GetMatchState() ~= 0
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
        ["Default"] = 0.135,
    })
end)

runcode(function()
    local Connection
    local Connection2
    local flydown = false
    local flyup = false
    local usedballoon = false
    local olddeflate
    local velo
    local Enabled = false
    local Mode = {["Value"] = "Moonsoon"}
    local Fly = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "Fly",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    if lplr.Character:FindFirstChild("InventoryFolder").Value:FindFirstChild("balloon") then
                        usedballoon = true
                        olddeflate = bedwars["BalloonController"].deflateBalloon
                        bedwars["BalloonController"].inflateBalloon()
                        bedwars["BalloonController"].deflateBalloon = function() end
                    end
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
                                for i = 1,7 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,i*1.25+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                                for i = 1,7 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,-i*1+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                            elseif Mode["Value"] == "FunnyOld" then
                                for i = 1,15 do
                                    task.wait(0.01)
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,i*1,0)
                                end
                            elseif Mode["Value"] == "Funny" then
                                for i = 1,7 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,i*1.40+(flyup and 38 or 0)+(flydown and -37 or 0),0)
                                end
                            elseif Mode["Value"] == "Moonsoon" then
                                for i = 1,10 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,-i*0.7,0)
                                end
                            elseif Mode["Value"] == "Bounce" then
                                for i = 1,15 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,i*1.25+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                                for i = 1,15 do
                                    task.wait()
                                    if not Enabled then return end
                                    velo.Velocity = Vector3.new(0,-i*1+(flyup and 40 or 0)+(flydown and -40 or 0),0)
                                end
                            elseif Mode["Value"] == "Bounce2" then
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
                if usedballoon == true then
                    usedballoon = false
                    bedwars["BalloonController"].deflateBalloon = olddeflate
                    bedwars["BalloonController"].deflateBalloon()
                    olddeflate = nil
                end
            end
        end
    })
    Mode = Fly:CreateDropDown({
        ["Name"] = "Mode",
        ["Function"] = function(v) 
            Mode["Value"] = v
        end,
        ["List"] = {"Long","Funny","FunnyOld","Moonsoon","Bounce","Bounce2"},
        ["Default"] = "Moonsoon"
    })
end)

runcode(function()
    function GetBeds()
        local beds = {}
        for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
            if string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and v:FindFirstChild("Covers").BrickColor ~= lplr.Team.TeamColor then
                table.insert(beds,v)
            end
        end
        return beds
    end
    function GetPlayers()
        local players = {}
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Team ~= lplr.Team and IsAlive(v) then
                table.insert(players,v)
            end
        end
        return players
    end
    local Enabled = false
    local AutoWin = Tabs["Exploits"]:CreateToggle({
        ["Name"] = "AutoWin",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    if GetMatchState() ~= 1 then
                        repeat task.wait() until GetMatchState() == 1 or not Enabled
                        if not Enabled then return end
                    end
                    local start = tick()
                    local beds = GetBeds()
                    for i,v in pairs(beds) do
                        repeat
                            task.wait(0.01)
                            if lplr:GetAttribute("DenyBlockBreak") == true then
                                lplr:SetAttribute("DenyBlockBreak",nil)
                            end
                            lplr.Character:FindFirstChild("HumanoidRootPart").CFrame = v.CFrame + Vector3.new(0,3,0)
                            local x = math.round(v.Position.X/3)
                            local y = math.round(v.Position.Y/3)
                            local z = math.round(v.Position.Z/3)
                            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.DamageBlock:InvokeServer({
                                ["blockRef"] = {
                                    ["blockPosition"] = Vector3.new(x,y,z)
                                },
                                ["hitPosition"] = Vector3.new(x,y,z),
                                ["hitNormal"] = Vector3.new(x,y,z)
                            })
                        until not v:FindFirstChild("Covers") or not v or not Enabled
                        if not Enabled then return end
                    end
                    local players = GetPlayers()
                    for i,v in pairs(players) do
                        repeat
                            task.wait(0.01)
                            lplr.Character:FindFirstChild("HumanoidRootPart").CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,3,0)
                        until not IsAlive(v)
                    end
                    CreateNotification("AutoWin","Took "..math.abs(start - tick()).." Seconds/Ticks to win Game",5)
                end)
            end
        end
    })
end)

runcode(function()
    local Expand = {["Value"] = 1}
    local function getwool()
        for i,v in pairs(lplr.Character:FindFirstChild("InventoryFolder").Value:GetChildren()) do
            if string.lower(v.Name):find("wool") then
                return {
                    Obj = v,
                    Amount = v:GetAttribute("Amount")
                }
            end
        end
        return nil
    end
    local function getwoolamount()
        local value = 0
        for i,v in pairs(lplr.Character:FindFirstChild("InventoryFolder").Value:GetChildren()) do
            if string.lower(v.Name):find("wool") then
                value = value + v:GetAttribute("Amount")
            end
        end
        return value
    end
    local function getpos()
        local primpart = lplr.Character.PrimaryPart
        local x = math.round(primpart.Position.X/3)
        local y = math.round(primpart.Position.Y/3)
        local z = math.round(primpart.Position.Z/3)
        local realexpand = Expand["Value"] + 1
        return Vector3.new(x,y-1,z) + (lplr.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * math.round(Expand["Value"]))
    end
    local ui
    spawn(function()
        ui = Instance.new("ScreenGui",game:GetService("CoreGui"))
        ui.Name = "ScaffoldUI"
        ui.Enabled = false
        if syn then syn.protect_gui(ui) end
        local label = Instance.new("TextLabel")
        label.TextSize = 16
        label.Position = UDim2.new(0.4404,0,0.4700,0)
        label.Size = UDim2.new(0.1181,0,0.1374,0)
        label.BackgroundColor3 = Color3.fromRGB(255,255,255)
        label.BackgroundTransparency = 1
        label.Text = "Blocks Left: 0"
        label.TextColor3 = Color3.fromRGB(65,65,255)
        label.Parent = ui
    end)
    local old
    local Enabled = false
    local ShowAmount = {["Enabled"] = false}
    local Scaffold = Tabs["Utility"]:CreateToggle({
        ["Name"] = "Scaffold",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                ui.Enabled = true
                spawn(function()
                    old = bedwars["BlockCPSConstants"].BLOCK_PLACE_CPS
                    bedwars["BlockCPSConstants"].BLOCK_PLACE_CPS = 9999
                    while task.wait() do
                        if not Enabled then return end
                        if IsAlive(lplr) then
                            spawn(function()
                                ui.TextLabel.Text = "BlocksLeft: "..getwoolamount()
                            end)
                            if getwool() ~= nil then
                                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.PlaceBlock:InvokeServer({
                                    ["position"] = getpos(),
                                    ["blockType"] = getwool().Obj.Name
                                })
                            end
                        end
                    end
                end)
            else
                ui.Enabled = false
                bedwars["BlockCPSConstants"].BLOCK_PLACE_CPS = old
            end
        end
    })
    Expand = Scaffold:CreateSlider({
        ["Name"] = "Expand",
        ["Function"] = function() end,
        ["Min"] = 1,
        ["Max"] = 10,
        ["Default"] = 1,
        ["Round"] = 1
    })
    ShowAmount = Scaffold:CreateOptionTog({
        ["Name"] = "ShowAmount",
        ["Default"] = true,
        ["Func"] = function(v)
            ShowAmount["Enabled"] = v
            if Enabled then
                ui.Enabled = v
            end
        end
    })
end)

runcode(function()
    local Connection
    local Enabled = false
    local NoClickDelay = Tabs["Utility"]:CreateToggle({
        ["Name"] = "NoNameTag",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                lplr.Character:WaitForChild("Head"):WaitForChild("NameTag"):Destroy()
                Connection = lplr.CharacterAdded:Connect(function(v)
                    v:WaitForChild("Head"):WaitForChild("NameTag"):Destroy()
                end)
            else
                Connection:Disconnect()
            end
        end
    })
end)

runcode(function()
    local MaxStuds = {["Value"] = 18}
    local function ChestStealerFunc()
        for i,v in pairs(game:GetService("CollectionService"):GetTagged("chest")) do
            local mag = (lplr.Character:FindFirstChild("HumanoidRootPart").Position - v.Position).Magnitude
            if mag < MaxStuds["Value"] then
                local chest = v:FindFirstChild("ChestFolderValue")
                chest = chest and chest.Value or nil
                local chestitems = chest and chest:GetChildren() or {}
                if #chestitems > 0 then
                    Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(chest)
                    for i3,v3 in pairs(chestitems) do
                        if v3:IsA("Accessory") then
                            pcall(function()
                                Client:GetNamespace("Inventory"):Get("ChestGetItem"):CallServer(v.ChestFolderValue.Value,v3)
                            end)
                        end
                    end
                    Client:GetNamespace("Inventory"):Get("SetObservedChest"):SendToServer(nil)
                end
            end
        end
    end
    local Enabled = false
    local ChestStealer = Tabs["Utility"]:CreateToggle({
        ["Name"] = "ChestStealer",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    while task.wait(0.01) do
                        if Enabled == false then return end
                        if IsAlive(lplr) then
                            ChestStealerFunc()
                        end
                    end
                end)
            end
        end
    })
    MaxStuds = ChestStealer:CreateSlider({
        ["Name"] = "MaxStuds",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 18,
        ["Default"] = 18,
        ["Round"] = 1
    })
end)

runcode(function()
    local BedwarsSwords = require(game:GetService("ReplicatedStorage").TS.games.bedwars["bedwars-swords"]).BedwarsSwords
    function hashFunc(vec) 
        return {value = vec}
    end
    local function GetInventory(plr)
        if not plr then 
            return {items = {}, armor = {}}
        end

        local suc, ret = pcall(function() 
            return require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil.getInventory(plr)
        end)

        if not suc then 
            return {items = {}, armor = {}}
        end

        if plr.Character and plr.Character:FindFirstChild("InventoryFolder") then 
            local invFolder = plr.Character:FindFirstChild("InventoryFolder").Value
            if not invFolder then return ret end
            for i,v in next, ret do 
                for i2, v2 in next, v do 
                    if typeof(v2) == 'table' and v2.itemType then
                        v2.instance = invFolder:FindFirstChild(v2.itemType)
                    end
                end
                if typeof(v) == 'table' and v.itemType then
                    v.instance = invFolder:FindFirstChild(v.itemType)
                end
            end
        end

        return ret
    end
    local function getSword()
	-- Initialize the highest power value and the returning item to nil.
	local highestPower = -9e9
	local returningItem = nil

	-- Get the inventory of the local player.
	local inventory = GetInventory(lplr)

	-- Loop through the items in the inventory.
	for _, item in pairs(inventory.items) do
		-- Check if the item is a sword.
		local power = table.find(BedwarsSwords, item.itemType)
		if not power then
			-- Skip the item if it is not a sword.
			continue
		end

		-- Check if the power of the current sword is higher than the current highest power.
		if power > highestPower then
			-- Set the returning item to the current sword and update the highest power value.
			returningItem = item
			highestPower = power
		end
	end

	-- Return the item with the highest power.
	return returningItem
end
    local Anims = {
        ["Slow"] = {
            {CFrame = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(90), math.rad(90)),Time = 0.25},
            {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
        },
       ["Zyla"] = {
            {CFrame = CFrame.new(0.3, -2, 0.5) * CFrame.Angles(-math.rad(190), math.rad(110), -math.rad(90)), Time = 0.3},
            {CFrame = CFrame.new(0.3, -1.5, 1.5) * CFrame.Angles(math.rad(120), math.rad(140), math.rad(320)), Time = 0.1}
        },
        ["Self"] = {
            {CFrame = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(90), math.rad(90)),Time = 0.25},
            {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
        },
        ["Butcher"] = {
            {CFrame = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)),Time = 0.3},
            {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.3}
        },
        ["VerticalSpin"] = {
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(8), math.rad(5)), Time = 0.3},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(180), math.rad(3), math.rad(13)), Time = 0.3},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(-5), math.rad(8)), Time = 0.3},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.3}
		},
    }
		local endanim = {
        {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
    }
    local endanim = {
        {CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.25}
    }
    local VMAnim = false
    local DidAttack = false
    local HitRemote = Client:Get(bedwars["SwordRemote"])
    local origC0 = game:GetService("ReplicatedStorage").Assets.Viewmodel.RightHand.RightWrist.C0
    local DistVal = {["Value"] = 21}
    local Tick = {["Value"] = 0.12}
    local AttackAnim = {["Enabled"] = true}
    local CurrentAnim = {["Value"] = "Slow"}
    local Enabled = false
    local KillAura = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "KillAura",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat task.wait() until GetMatchState() ~= 0 or not Enabled
                    if not Enabled then return end
                    while task.wait(Tick["Value"]) do
                        if not Enabled then return end
                        local v = getNearestPlayer(DistVal["Value"])
                        if v.Team ~= lplr.Team and IsAlive(v) and IsAlive(lplr) and not v.Character:FindFirstChild("ForceField") then
                            local sword = getSword()
                            spawn(function()
                                if AttackAnim["Enabled"] then
                                    local anim = Instance.new("Animation")
                                    anim.AnimationId = "rbxassetid://4947108314"
                                    local loader = lplr.Character:FindFirstChild("Humanoid"):FindFirstChild("Animator")
                                    loader:LoadAnimation(anim):Play()
                                    for i,v in pairs(Anims[CurrentAnim["Value"]]) do
                                        game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist,TweenInfo.new(v.Time),{C0 = origC0 * v.CFrame}):Play()
                                        task.wait(v.Time-0.01)
                                    end
                                end
                            end)
                            if sword ~= nil then
                                DidAttack = true
                                bedwars["SwordController"].lastAttack = game:GetService("Workspace"):GetServerTimeNow() - 0.11
                                HitRemote:SendToServer({
                                    ["weapon"] = sword.tool,
                                            ["chargedAttack"] = {chargeRatio = 1},
                                            ["entityInstance"] = v.Character,
                                            ["validate"] = {
                                                ["raycast"] = {
                                                    ["cameraPosition"] = hashFunc(cam.CFrame.Position),
                                                    ["cursorDirection"] = hashFunc(Ray.new(cam.CFrame.Position, v.Character:FindFirstChild("HumanoidRootPart").Position).Unit.Direction)
                                                },
                                                ["targetPosition"] = hashFunc(v.Character:FindFirstChild("HumanoidRootPart").Position),
                                                ["selfPosition"] = hashFunc(lplr.Character:FindFirstChild("HumanoidRootPart").Position + ((lplr.Character:FindFirstChild("HumanoidRootPart").Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude > 14 and (CFrame.lookAt(lplr.Character:FindFirstChild("HumanoidRootPart").Position, v.Character:FindFirstChild("HumanoidRootPart").Position).LookVector * 4) or Vector3.new(0, 0, 0)))
                                            }
                                        })
                            end
                        else
                            DidAttack = false
                        end
                        if not DidAttack then
                            for i,v2 in pairs(endanim) do
                                game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist,TweenInfo.new(v2.Time),{C0 = origC0 * v2.CFrame}):Play()
                            end
                        end
                    end
                end)
            end
        end
    })
    DistVal = KillAura:CreateSlider({
        ["Name"] = "Range",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 21,
        ["Default"] = 21,
        ["Round"] = 1
    })
    Tick = KillAura:CreateSlider({
        ["Name"] = "Tick",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 1,
        ["Default"] = 0.12
    })
    CurrentAnim = KillAura:CreateDropDown({
        ["Name"] = "VMAnimation",
        ["Function"] = function(v) 
            CurrentAnim["Value"] = v
        end,
        ["List"] = {"Slow","Zyla","Self","Butcher","VerticalSpin"},
        ["Default"] = "Zyla"
    })
    AttackAnim = KillAura:CreateOptionTog({
        ["Name"] = "Animation",
        ["Default"] = true,
        ["Func"] = function(v)
            AttackAnim["Enabled"] = v
        end
    })
end)



runcode(function()
    local Connection
    local Enabled = false
    local BetterViewmodel = Tabs["Render"]:CreateToggle({
        ["Name"] = "BetterViewmodel",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
                    if v:FindFirstChild("Handle") then
                        pcall(function()
                            v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
                            v:FindFirstChild("Handle").Material = Enum.Material.Neon
                            v:FindFirstChild("Handle").TextureID = ""
                            v:FindFirstChild("Handle").Color = Color3.fromRGB(255,65,65)
                        end)
                        local vname = string.lower(v.Name)
                        if vname:find("sword") or vname:find("blade") then
                            v:FindFirstChild("Handle").MeshId = "rbxassetid://11216117592"
                        elseif vname:find("snowball") then
                            v:FindFirstChild("Handle").MeshId = "rbxassetid://11216343798"
                        end
                    end
                end)
            else
                Connection:Disconnect()
            end
        end
    })
end)

runcode(function()
    local old
    local Enabled = false
    local NoPingIndicator = Tabs["Render"]:CreateToggle({
        ["Name"] = "NoPingIndicator",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                old = bedwars["PingController"].createIndicator
                bedwars["PingController"].createIndicator = function() end
            else
                bedwars["PingController"].createIndicator = old
                old = nil
            end
        end
    })
end)

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
    local BreakingMsg = false
    local params = RaycastParams.new()
    params.IgnoreWater = true
    function NukerFunction(part)
        local raycastResult = game:GetService("Workspace"):Raycast(part.Position + Vector3.new(0,24,0),Vector3.new(0,-27,0),params)
        if raycastResult then
            local targetblock = raycastResult.Instance
            for i,v in pairs(targetblock:GetChildren()) do
                if v:IsA("Texture") then
                    v:Destroy()
                end
            end
            targetblock.Color = Color3.fromRGB(255,65,65)
            targetblock.Material = Enum.Material.Neon
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.DamageBlock:InvokeServer({
                ["blockRef"] = {
                    ["blockPosition"] = Vector3.new(math.round(targetblock.Position.X/3),math.round(targetblock.Position.Y/3),math.round(targetblock.Position.Z/3))
                },
                ["hitPosition"] = Vector3.new(math.round(targetblock.Position.X/3),math.round(targetblock.Position.Y/3),math.round(targetblock.Position.Z/3)),
                ["hitNormal"] = Vector3.new(math.round(targetblock.Position.X/3),math.round(targetblock.Position.Y/3),math.round(targetblock.Position.Z/3))
            })
            if BreakingMsg == false then
                BreakingMsg = true
                CreateNotification("Nuker","Breaking Bed..",3)
                spawn(function()
                    task.wait(3)
                    BreakingMsg = false
                end)
            end
        end
    end
    function GetBeds()
        local beds = {}
        for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
            if string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and v:FindFirstChild("Covers").BrickColor ~= lplr.Team.TeamColor then
                table.insert(beds,v)
            end
        end
        return beds
    end
    local Enabled = false
    local Distance = {["Value"] = 30}
    local Nuker = Tabs["World"]:CreateToggle({
        ["Name"] = "Nuker",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    while task.wait(0.25) do
                        if not Enabled then return end
                        if IsAlive(lplr) then
                            local beds = GetBeds()
                            for i,v in pairs(beds) do
                                local mag = (v.Position - lplr.Character.PrimaryPart.Position).Magnitude
                                if mag < Distance["Value"] then
                                    NukerFunction(v)
                                end
                            end
                        end
                    end
                end)
            end
        end
    })
    Distance = Nuker:CreateSlider({
        ["Name"] = "Distance",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 30,
        ["Default"] = 30,
        ["Round"] = 10
    })
end)

--[[runcode(function()
    local velo
    local Enabled = false
    local LongJump = Tabs["Blatant"]:CreateToggle({
        ["Name"] = "LongJump",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    while task.wait(0.2) do
                        if not Enabled then return end
                        bedwars["DamageController"].requestSelfDamage(nil,1,bedwars["DamageTypes"].TNT)
                    end
                end)
                velo = Instance.new("BodyVelocity")
                velo.MaxForce = Vector3.new(9e9,9e9,9e9)
                velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
                local MultiplierPower = 0
                spawn(function()
                    for i = 1,10 do
                        task.wait(0.01)
                        MultiplierPower = i * 10 + 20
                    end
                end)
                spawn(function()
                    repeat
                        task.wait()
                        velo.Velocity = lplr.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * MultiplierPower + Vector3.new(0,5,0)
                    until not Enabled
                    CreateNotification("LongJump","Finished",5)
                end)
            else
                velo.Velocity = Vector3.zero
                velo:Destroy()
            end
        end
    })
end)--]]

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
    local Messages = {"Pow!","Thump!","Wham!","Hit!","Smack!","Bang!","Pop!","Boom!"}
    local old
    local Enabled = false
    local FunnyIndicator = Tabs["Render"]:CreateToggle({
        ["Name"] = "FunnyIndicator",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                old = debug.getupvalue(bedwars["DamageIndicator"],10,{Create})
                debug.setupvalue(bedwars["DamageIndicator"],10,{
                    Create = function(self,obj,...)
                        spawn(function()
                            pcall(function()
                                obj.Parent.Text = Messages[math.random(1,#Messages)]
                                obj.Parent.TextColor3 = Color3.fromHSV(tick()%5/5,1,1)
                            end)
                        end)
                        return game:GetService("TweenService"):Create(obj,...)
                    end
                })
            else
                debug.setupvalue(bedwars["DamageIndicator"],10,{
                    Create = old
                })
                old = nil
            end
        end
    })
end)



--[[runcode(function()
    local old
    local Enabled = false
    local HypixelJump = Tabs["Combat"]:CreateToggle({
        ["Name"] = "NoClickDelay",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                old = bedwars["SwordController"].isClickingTooFast
                bedwars["SwordController"].isClickingTooFast = function(self)
                    self.lastSwing = tick()
                    return false
                end
                debug.setconstant(bedwars["SwordController"].attackEntity,23,0.64)
            else
				bedwars["SwordController"].isClickingTooFast = old
				debug.setconstant(bedwars["SwordController"].attackEntity,23,0.8)
            end
        end
    })
end) patched--]]

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

--[[runcode(function()
    local ambience
    local Enabled = false
    local RainbowSky = Tabs["Render"]:CreateToggle({
        ["Name"] = "RainbowSky",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                ambience = Instance.new("Atmosphere",game:GetService("Lighting"))
                ambience.Density = 0
                ambience.Offset = 0
                ambience.Glare = 0.25
                ambience.Haze = 10
                spawn(function()
                    while task.wait() do
                        if not Enabled then return end
                        ambience.Color = Color3.fromHSV(tick()%5/5,1,1)
                        ambience.Decay = Color3.fromHSV(tick()%5/5,1,1)
                    end
                end)
            else
                ambience:Destroy()
            end
        end
    })
end)--]]


runcode(function()
    local Enabled = false
    local AutoPlayAgain = Tabs["Utility"]:CreateToggle({
        ["Name"] = "AutoPlayAgain",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                    repeat task.wait(3) until GetMatchState() == 2 or not Enabled
                    if not Enabled then return end
                    game:GetService("ReplicatedStorage"):FindFirstChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events").joinQueue:FireServer({["queueType"] = getQueueType()})
                    return
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


runcode(function()
  local Enabled = false
    local AutoPlayAgain = Tabs["Utility"]:CreateToggle({
        ["Name"] = "MidTP",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
                spawn(function()
                   game.Players.LocalPlayer.Character.Humanoid.Health = 0
                        wait(3.8)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnView.CFrame
                        wait(0.1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnView.CFrame
                        wait(0.11)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnView.CFrame
                        wait(0.11)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnView.CFrame
                        wait(0.11)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnView.CFrame
                        wait(0.1)
                end)
            end
        end
    })
end)

runcode(function()
    local clone
    local char
    local Enabled = false
    local Blink = Tabs["Render"]:CreateToggle({
        ["Name"] = "Blink",
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
    local Sky = Tabs["Render"]:CreateToggle({
        ["Name"] = "Dark Mountain Sky",
        ["Callback"] = function(Callback)
            Enabled = Callback
            if Enabled then
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/Asset/?ID=12064107"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/Asset/?ID=12064152"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/Asset/?ID=12064121"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/Asset/?ID=12063984"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/Asset/?ID=12064115"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/Asset/?ID=12064131"
            else
            game.Lighting.Sky.SkyboxBk = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxDn = "http://www.roblox.com/asset/?id=6334928194"
            game.Lighting.Sky.SkyboxFt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxLf = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxRt = "http://www.roblox.com/asset/?id=7018684000"
            game.Lighting.Sky.SkyboxUp = "http://www.roblox.com/asset/?id=7018689553"
            game.Lighting.FogColor = Color3.new(1, 1, 1)
            game.Lighting.FogEnd = "10000"
            game.Lighting.FogStart = "0"
            game.Lighting.Ambient = Color3.new(0, 0, 0)
            end
        end
    })
end)
