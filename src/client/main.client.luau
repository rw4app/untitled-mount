local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = Shared:WaitForChild("remotes")
local UpdateStats = Remotes:WaitForChild("UpdateStats")
local Players = game:GetService("Players")

-- load controllers
local StatsController = require(script.controllers.StatsController)
local SprintController = require(script.controllers.SprintController)
local ClimbController = require(script.controllers.ClimbController)
local UIController = require(script.controllers.UIController)
local EquipmentController = require(script.controllers.EquipmentController)

StatsController.init(UpdateStats, Players.LocalPlayer)
UIController.init()
SprintController.init()
ClimbController.init()
EquipmentController.init()
