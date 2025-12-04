local PlayerStats = {}
PlayerStats.__index = PlayerStats

local function default()
    return {
        MaxStamina = 100,
        Stamina = 100,
        MaxOxygen = 100,
        Oxygen = 100,
        MaxTemperature = 100,
        Temperature = 100,
        Altitude = 0,
        IsSprinting = false,
        IsClimbing = false,
        Equipment = {
            Mask = false,
            Tank = {Capacity = 100, Current = 100},
            JacketLevel = 0,
            Rope = false,
            Crampons = false,
            IceAxe = false
        }
    }
end

function PlayerStats.new()
    local self = setmetatable({}, PlayerStats)
    self.data = default()
    return self
end

function PlayerStats:toTable()
    return self.data
end

return PlayerStats
