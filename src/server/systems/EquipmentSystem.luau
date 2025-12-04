local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Modules = Shared:WaitForChild("modules")
local EquipmentDefs = require(Modules.EquipmentDefs)
local Players = game:GetService("Players")
local Remotes = Shared:WaitForChild("remotes")
local RequestUse = Remotes:WaitForChild("RequestUseEquipment")

local playerData = {} -- local cache if needed; main data in StatsSystem

RequestUse.OnServerEvent:Connect(function(player, action, args)
    -- simple server validation example: use oxygen tank refill
    if action == "use_tank" then
        -- find player's stats (requires StatsSystem to expose API; for simplicity, use _G)
        local statsObj = _G.PlayerData and _G.PlayerData[player]
        if statsObj then
            local eq = statsObj.data.Equipment
            eq.Tank.Current = math.min(eq.Tank.Capacity, eq.Tank.Current + (args and args.amount or 50))
        end
    end
end)

return { init = function() print("EquipmentSystem init") end }
