local StatsController = {}
local UpdateStatsEvent
local player

function StatsController.init(updateEvent, plr)
    UpdateStatsEvent = updateEvent
    player = plr
    UpdateStatsEvent.OnClientEvent:Connect(function(data)
        -- forward to UI controller via Bindable or direct call
        _G.ClientStats = data
    end)
end

return StatsController
