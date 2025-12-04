local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = Shared:WaitForChild("remotes")
local UpdateStats = Remotes:WaitForChild("UpdateStats")

-- UI
local gui = player:WaitForChild("PlayerGui"):WaitForChild("StatsUI")
local OxygenBar = gui:WaitForChild("OxygenBar")
local StaminaBar = gui:WaitForChild("StaminaBar")
local TempText = gui:WaitForChild("TempText")

local currentStats = {
	Oxygen = 100,
	Stamina = 100,
	Temperature = 25
}

-- Receive updates from server
UpdateStats.OnClientEvent:Connect(function(data)
	for k, v in pairs(data) do
		currentStats[k] = v
	end
end)

-- Update UI (smooth)
RunService.RenderStepped:Connect(function()
	OxygenBar.Size = UDim2.new(
		math.clamp(currentStats.Oxygen / 100, 0, 1),
		0,
		OxygenBar.Size.Y.Scale, -- keep height
		0
	)

	StaminaBar.Size = UDim2.new(
		math.clamp(currentStats.Stamina / 100, 0, 1),
		0,
		StaminaBar.Size.Y.Scale,
		0
	)

	TempText.Text = "Temp: " .. math.floor(currentStats.Temperature) .. "°C"
end)
