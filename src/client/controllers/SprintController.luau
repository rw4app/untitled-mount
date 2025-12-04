local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local stats = _G.ClientStats

local SprintController = {}
local isSprinting = false
local sprintSpeed = 24
local walkSpeed = 16

function SprintController.init()
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.LeftShift then
            isSprinting = true
            if humanoid and _G.ClientStats and _G.ClientStats.Stamina > 5 then
                humanoid.WalkSpeed = sprintSpeed
                _G.ClientStats.IsSprinting = true
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftShift then
            isSprinting = false
            if humanoid then
                humanoid.WalkSpeed = walkSpeed
                _G.ClientStats.IsSprinting = false
            end
        end
    end)

    -- local stamina check loop
    spawn(function()
        while true do
            if _G.ClientStats then
                if _G.ClientStats.Stamina <= 5 and isSprinting then
                    -- force stop
                    humanoid.WalkSpeed = walkSpeed
                    isSprinting = false
                    _G.ClientStats.IsSprinting = false
                end
            end
            wait(0.15)
        end
    end)
end

return SprintController
