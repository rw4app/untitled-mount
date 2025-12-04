local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = Shared:WaitForChild("remotes")
local RequestUse = Remotes:WaitForChild("RequestUseEquipment")

local EquipmentController = {}

function EquipmentController.init()
    -- sample keybind to use tank (press R to refill small amount locally)
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.R then
            RequestUse:FireServer("use_tank", { amount = 20 })
        end
    end)
end

return EquipmentController
