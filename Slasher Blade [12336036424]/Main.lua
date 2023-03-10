--[[

<<----------- Made by NoclippyT ----------->>
Please do not link-shrink my scripts, thanks.

]]

--//Player Setup
if not game:IsLoaded() then game.Loaded:wait() end;
local Players = game:GetService("Players")

local LP = Players.LocalPlayer
local LPChar = LP.Character or LP.CharacterAdded:Wait()
local LPRoot; local LPHum;

if LPChar then
	LPRoot = LPChar:WaitForChild("HumanoidRootPart")
	LPHum = LPChar:WaitForChild("Humanoid")
end

LP.CharacterAdded:Connect(function(NewChar)
	LPChar = NewChar
	LPRoot = NewChar:WaitForChild("HumanoidRootPart")
	LPHum = NewChar:WaitForChild("Humanoid")
	LPHum.WalkSpeed = NewWalkSpeed
end)

local DoINFGems --\\ INF Gems
local DoFastKill --\\ Fast Kill
local FastKillRange = 15 --\\ Fast kill range

--//Remotes
local RemEvents = game:GetService("ReplicatedStorage").Remote.Event

local R_DamageMob = RemEvents.Fight["[C-S]TakeDamage"]
local R_GetReward = RemEvents.DailyMission["[C-S]PlayerGetReward"]
local R_CoinUpgrade = RemEvents.Eco["[C-S]PlayerTryUpUp"]

--//Functions
function GetMobs()
	for _,ActiveRoom in pairs(workspace.Room:GetChildren()) do
		if not ActiveRoom:WaitForChild("Players"):FindFirstChild(LP.Name) then continue end
		return ActiveRoom:WaitForChild("Mob"):GetChildren()
	end
end

function ResetUpgrades()
	R_CoinUpgrade:FireServer("Coinadd", ".01") --\\ Breaks the upgrading system

	task.wait(1)

	local PlayersList = {}

	for _, Player in pairs(Players:GetPlayers()) do
		if Player ~= LP then
			table.insert(PlayersList, Player)
		end
	end

	if #PlayersList <= 1 then
		LP:Kick()
		wait()
		game:GetService('TeleportService'):Teleport(game.PlaceId, LP)
	else
		game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
	end
end


spawn(function() --\\ INF Gems
	while true do

		if DoINFGems then
			R_GetReward:FireServer("Q1")
			R_GetReward:FireServer("Q2")
			task.wait(2)
		else
			task.wait(.5)
		end

	end
end)

spawn(function() --\\ Fast Kill
	while true do

		if DoFastKill then

			if not LPRoot then task.wait(2.5) end
			local RootPos = LPRoot.Position
			local Mobs = GetMobs() or {}

			for _, Mob in ipairs(Mobs) do
				if Mob and Mob:FindFirstChild("Humanoid") then
					local Distance = (Mob.HumanoidRootPart.Position - RootPos).Magnitude

					if Distance <= FastKillRange then
						pcall(function() R_DamageMob:FireServer(Mob.Humanoid) end)
					end

				end
			end
		else
			task.wait(.05)
		end

		task.wait()
	end
end)

--//Ui Lib
local engine = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()

local Window1 = engine.new({
	text = "Slasher Blade ⚔️ [NoclipyT]",
	position = UDim2.new(.01, 0, .65, 0),
	size = Vector2.new(300, 200)
})
Window1.open()

task.wait(.05)

local Tab1 = Window1.new({text = "Main"})

local label1 = Tab1.new("label", {text = "You need at least 1 useable upgrade."})

local Btn1 = Tab1.new("button",{text = "Reset upgrades (free + rejoin)"})

Btn1.event:Connect(ResetUpgrades)

local Sw1 = Tab1.new("switch", {text = "INF Gems (slow)"})

Sw1.event:Connect(function(bool) DoINFGems = bool end)
Sw1.set(true)

local Sw2 = Tab1.new("switch", {text = "Auto Fast Kill"})

Sw2.event:Connect(function(bool) DoFastKill = bool end)
Sw2.set(true)

local label2 = Tab1.new("label", {text = "Range for fast kill, Default 15."})

local Sl1 = Tab1.new("slider", {
	text = "Range",
	color = Color3.new(1, 0.45, 0.45),
	min = 7,
	max = 25,
	value = 15,
	rounding = 1
})

Sl1.event:Connect(function(value) FastKillRange = value end)
Sl1.set(15)

local Sl2 = Tab1.new("slider", {
	text = "WalkSpeed",
	color = Color3.new(1, 0.45, 0.45),
	min = 16,
	max = 100,
	value = 16,
	rounding = 1
})

Sl2.event:Connect(function(value) NewWalkSpeed = value; LPHum.WalkSpeed = value end)
Sl2.set(60)