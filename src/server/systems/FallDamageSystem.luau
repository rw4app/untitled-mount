local Players = game:GetService("Players")
local Constants = require(script.Parent.Parent.modules.Constants)

local function onHumanoidState(humanoid)
    -- fallback; implement per character
end

return {
    init = function()
        -- attach to new characters
        Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Connect(function(char)
                local hum = char:WaitForChild("Humanoid")
                local lastY = char:WaitForChild("HumanoidRootPart").Position.Y
                hum.StateChanged:Connect(function(old, new)
                    -- can implement
                end)
                hum.Died:Connect(function() end)
                -- simple fall tracker
                spawn(function()
                    while char.Parent do
                        local y = char.HumanoidRootPart.Position.Y
                        if (lastY - y) > 25 then
                            local damage = (lastY - y) * 2
                            hum:TakeDamage(damage)
                        end
                        lastY = y
                        wait(0.5)
                    end
                end)
            end)
        end)
    end
}
