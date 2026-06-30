local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local imageId = "rbxassetid://127425919854173"

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FullScreenImageGui_Ximik"
screenGui.IgnoreGuiInset = true 
screenGui.ResetOnSpawn = false

local success, _ = pcall(function()
    screenGui.Parent = CoreGui
end)

if not success then
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "FullScreenImage"
imageLabel.Size = UDim2.new(1, 0, 1, 0) 
imageLabel.Position = UDim2.new(0, 0, 0, 0)
imageLabel.BackgroundTransparency = 1 
imageLabel.Image = imageId
imageLabel.ScaleType = Enum.ScaleType.Stretch 
imageLabel.Parent = screenGui
