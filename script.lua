local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Создание и настройка звука
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://10782024916754"
sound.Volume = 1 -- Безопасная стандартная громкость (макс. комфортная обычно до 2-3)
sound.Looped = true
sound.Parent = SoundService
sound:Play()

-- Настройка интерфейса
local imageId = "rbxassetid://127425919854173"

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FullScreenImageGui_Ximik"
screenGui.IgnoreGuiInset = true 
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui -- Прямое назначение без лишних pcall

local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "FullScreenImage"
imageLabel.Size = UDim2.new(1, 0, 1, 0) 
imageLabel.Position = UDim2.new(0, 0, 0, 0)
imageLabel.BackgroundTransparency = 1 
imageLabel.Image = imageId
imageLabel.ScaleType = Enum.ScaleType.Fit -- Fit или Crop сохранят пропорции картинки
imageLabel.Parent = screenGui
