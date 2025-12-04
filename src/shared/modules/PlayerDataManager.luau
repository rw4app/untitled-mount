local Players = game:GetService("Players")
local ProfileService = require(script.Parent.ProfileService)
local PlayerStats = require(script.Parent.PlayerStats)

local DATA_TEMPLATE = {
	Stamina = 100,
	MaxStamina = 100,
	Oxygen = 100,
	Temperature = 25,
	Altitude = 0
}

local ProfileStore = ProfileService.GetProfileStore("PlayerData_v1", DATA_TEMPLATE)

local PlayerProfiles = {}

local module = {}

function module.GetProfile(player)
	return PlayerProfiles[player]
end

Players.PlayerAdded:Connect(function(plr)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. plr.UserId, "ForceLoad")

	if profile then
		profile:AddUserId(plr.UserId)
		profile:Reconcile()

		PlayerProfiles[plr] = profile

		-- load data to PlayerStats
		local stats = PlayerStats.new()
		for k, v in pairs(profile.Data) do
			stats[k] = v
		end

		profile.Data._stats = stats

	else
		plr:Kick("Data gagal dimuat.")
	end
end)

Players.PlayerRemoving:Connect(function(plr)
	local profile = PlayerProfiles[plr]
	if profile then
		-- save back
		local stats = profile.Data._stats
		for k, v in pairs(stats) do
			if k ~= "_stats" then
				profile.Data[k] = v
			end
		end

		profile:Release()
	end

	PlayerProfiles[plr] = nil
end)

return module
