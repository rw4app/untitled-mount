local Constants = {}

-- Altitude zones (meters)
Constants.ZONES = {
    {max = 2000, oxygenRate = 0.01, tempDrop = 0.01},
    {max = 4000, oxygenRate = 0.05, tempDrop = 0.03},
    {max = 8000, oxygenRate = 0.15, tempDrop = 0.06},
    {max = 10000, oxygenRate = 0.3, tempDrop = 0.12}, -- death zone
}

Constants.HEART_DAMAGE_LOW_OXYGEN = 1 -- per tick
Constants.HEART_DAMAGE_FREEFALL = 50

return Constants
