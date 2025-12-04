local RunService = game:GetService("RunService")
-- Simple weather controller that sets global _G.CurrentWeather

local weather = {
    mode = "clear",
    coldMultiplier = 1,
    windStrength = 0
}

local function randomize()
    local r = math.random()
    if r < 0.75 then
        weather.mode = "clear"
        weather.coldMultiplier = 1
        weather.windStrength = 0.1
    elseif r < 0.95 then
        weather.mode = "snow"
        weather.coldMultiplier = 1.8
        weather.windStrength = 0.5
    else
        weather.mode = "blizzard"
        weather.coldMultiplier = 3
        weather.windStrength = 1.2
    end
    _G.CurrentWeather = weather
end

RunService.Heartbeat:Connect(function(dt)
    -- change weather rarely
    if math.random() < (1/6000) then
        randomize()
    end
end)

randomize()
return { init = function() print("Weather init, mode:", weather.mode) end }
