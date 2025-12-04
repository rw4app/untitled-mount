local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
-- Assume StatsUI Frame exists named "StatsUI" with bars: StaminaBar, OxygenBar, TempBar, AltitudeLabel
local StatsUI = PlayerGui:WaitForChild("StatsUI")

local UIController = {}

function UIController.init()
    spawn(function()
        while true do
            local data = _G.ClientStats
            if data and StatsUI then
                pcall(function()
                    StatsUI.StaminaBar.Size = UDim2.new(data.Stamina / data.MaxStamina, 0, 1, 0)
                    StatsUI.OxygenBar.Size = UDim2.new(data.Oxygen / data.MaxOxygen, 0, 1, 0)
                    StatsUI.TempBar.Size = UDim2.new(data.Temperature / data.MaxTemperature, 0, 1, 0)
                    StatsUI.AltitudeLabel.Text = tostring(data.Altitude) .. " m"
                end)
            end
            wait(0.1)
        end
    end)
end

return UIController
