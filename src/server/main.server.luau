local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = Shared:WaitForChild("remotes")

-- Remote event
local UpdateStats = Remotes:WaitForChild("UpdateStats")

-- require systems
local Systems = {}
Systems.StatsSystem = require(script.systems.StatsSystem) -- heartbeat ada di sini
Systems.MovementSystem = require(script.systems.MovementSystem)
Systems.FallDamageSystem = require(script.systems.FallDamageSystem)
Systems.WeatherSystem = require(script.systems.WeatherSystem)
Systems.EquipmentSystem = require(script.systems.EquipmentSystem)

-- initialize systems
for _, sys in pairs(Systems) do
	if type(sys.init) == "function" then
		sys.init()
	end
end

print("Server main initialized")
