local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local climbing = false

local ClimbController = {}

function ClimbController.init()
    -- simple automatic climb when touching ladder-like parts (tag them "Climbable")
    character.DescendantAdded:Connect(function(desc)
        -- noop
    end)

    humanoid.Touched:Connect(function(part)
        if part:FindFirstChild("Climbable") then
            climbing = true
            _G.ClientStats.IsClimbing = true
            humanoid.WalkSpeed = 8
        end
    end)

    humanoid.TouchEnded:Connect(function(part)
        if part:FindFirstChild("Climbable") then
            climbing = false
            _G.ClientStats.IsClimbing = false
            humanoid.WalkSpeed = 16
        end
    end)
end

return ClimbController
