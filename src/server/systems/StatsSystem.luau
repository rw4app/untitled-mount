local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = Shared:WaitForChild("remotes")
local UpdateStats = Remotes:WaitForChild("UpdateStats")

local StatsSystem = {}

local playerStats = {} -- tempat stats player

function StatsSystem.init()
	-- buat stats saat player join
	Players.PlayerAdded:Connect(function(plr)
		playerStats[plr] = {
			Oxygen = 100,
			Stamina = 100,
			Temperature = 25,
			Altitude = 0,
			MaxStamina = 100
		}
	end)

	-- hapus saat player leave
	Players.PlayerRemoving:Connect(function(plr)
		playerStats[plr] = nil
	end)

	-- Heartbeat loop (update stats)
	RunService.Heartbeat:Connect(function()
		for plr, stats in pairs(playerStats) do

			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")

			if hrp then
				stats.Altitude = math.floor(hrp.Position.Y)
			end

			-- OXYGEN
			if stats.Altitude >= 4000 then
				stats.Oxygen -= 0.15
			elseif stats.Altitude >= 2000 then
				stats.Oxygen -= 0.05
			end

			-- STAMINA REGEN
			if stats.Stamina < stats.MaxStamina then
				stats.Stamina += 0.2
			end

			-- TEMPERATURE DROP
			if stats.Altitude > 3000 then
				stats.Temperature -= 0.05
			end

			-- LOW OXYGEN DAMAGE
			if stats.Oxygen <= 0 then
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				if hum then hum:TakeDamage(1) end
			end

			-- sync ke client
			UpdateStats:FireClient(plr, {
				Oxygen = stats.Oxygen,
				Stamina = stats.Stamina,
				Temperature = stats.Temperature
			})
		end
	end)

	print("StatsSystem initialized.")
end

return StatsSystem
