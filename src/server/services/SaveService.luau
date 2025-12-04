local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local SaveStore = DataStoreService:GetDataStore("PlayerStats_V1")

local SaveService = {}
SaveService.PlayerCache = {}

-- DEFAULT DATA
local function getDefault()
    return {
        Stamina = 100,
        Oxygen = 100,
        Temperature = 100,
        JacketLevel = 0,
        Mask = false,
        Tank = {Capacity = 100, Current = 100},
        Rope = false,
        Crampons = false,
        IceAxe = false
    }
end


-- LOAD DATA
function SaveService:Load(player)
    local key = "PLAYER_"..player.UserId
    local data

    -- try load
    local success, err = pcall(function()
        data = SaveStore:GetAsync(key)
    end)

    if not success then
        warn("Failed to load data for", player.Name, ":", err)
        data = nil
    end

    if data == nil then
        data = getDefault()
    end

    self.PlayerCache[player.UserId] = data
    return data
end


-- SAVE DATA
function SaveService:Save(player)
    local userId = player.UserId
    local key = "PLAYER_"..userId
    local data = self.PlayerCache[userId]

    if not data then return end

    local success, err
    for i = 1, 3 do -- retry 3x
        success, err = pcall(function()
            SaveStore:SetAsync(key, data)
        end)
        if success then break end
        task.wait(1)
    end

    if not success then
        warn("FAILED TO SAVE PLAYER DATA:", player.Name, err)
    end
end


-- AUTO SAVE ON LEAVE
Players.PlayerRemoving:Connect(function(player)
    SaveService:Save(player)
end)

-- SAFE SHUTDOWN SAVE
game:BindToClose(function()
    for _, player in ipairs(Players:GetPlayers()) do
        SaveService:Save(player)
    end
end)

return SaveService
