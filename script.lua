repeat task.wait() until game:IsLoaded()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players, RunService, UserInputService, LocalPlayer = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("Players").LocalPlayer
local FlyEnabled, FlySpeed, ESPEnabled, ESPColor = false, 50, false, Color3.fromRGB(255, 0, 0)
local Window = Rayfield:CreateWindow({Name = "Multi-Hack 2026", LoadingTitle = "Загрузка...", LoadingSubtitle = "AI", ConfigurationSaving = {Enabled = false}, KeySystem = true, KeySettings = {Title = "Ключ", Subtitle = "Ввод", Note = "EVENT2026FREE@", FileName = "Key", SaveKey = true, GrabKeyFromUrl = "", Key = {"EVENT2026FREE@"}}})
local MainTab, ESPTab = Window:CreateTab("Основные"), Window:CreateTab("ESP")
MainTab:CreateToggle({Name = "Fly", CurrentValue = false, Callback = function(v) FlyEnabled = v end})
MainTab:CreateSlider({Name = "Fly Speed", Min = 10, Max = 200, CurrentValue = 50, Callback = function(v) FlySpeed = v end})
local bV, bG
RunService.RenderStepped:Connect(function()
    local Char = LocalPlayer.Character local Root = Char and Char:FindFirstChild("HumanoidRootPart") local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
    if FlyEnabled and Root and Hum then
        if not Root:FindFirstChild("FlyVelocity") then
            bV = Instance.new("BodyVelocity", Root) bV.Name = "FlyVelocity" bV.MaxForce = Vector3.new(1,1,1)*math.huge
            bG = Instance.new("BodyGyro", Root) bG.Name = "FlyGyro" bG.MaxTorque = Vector3.new(1,1,1)*math.huge bG.P = 3000
        end
        local cam, dir = workspace.CurrentCamera.CFrame, Vector3.new(0,0,0)
        if not UserInputService:GetFocusedTextBox() then
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.LookVector end if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.RightVector end if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0) end
        end
        bV.Velocity = dir.Magnitude > 0 and dir.Unit * FlySpeed or Vector3.new(0,0,0) bG.CFrame = cam
        if Hum.FloorMaterial ~= Enum.Material.Air then Hum:ChangeState(Enum.HumanoidStateType.Freefall) end
    else if Root then local v=Root:FindFirstChild("FlyVelocity") local g=Root:FindFirstChild("FlyGyro") if v then v:Destroy() end if g then g:Destroy() end end end
end)
ESPTab:CreateToggle({Name = "Enable ESP", CurrentValue = false, Callback = function(v) ESPEnabled = v end})
local function upCol()
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then
        local h = p.Character:FindFirstChild("ESPHighlight") if h then h.FillColor, h.OutlineColor = ESPColor, ESPColor end
        local b = p.Character:FindFirstChild("ESPBillboard") if b and b:FindFirstChild("TextLabel") then b.TextLabel.TextColor3 = ESPColor end
    end end
end
ESPTab:CreateColorPicker({Name = "1. Палитра", Color = Color3.fromRGB(255,0,0), Callback = function(v) ESPColor = v upCol() end})
local r, g, b = 255, 0, 0
ESPTab:CreateSlider({Name = "R", Min = 0, Max = 255, CurrentValue = 255, Callback = function(v) r = v ESPColor = Color3.fromRGB(r,g,b) upCol() end})
ESPTab:CreateSlider({Name = "G", Min = 0, Max = 255, CurrentValue = 0, Callback = function(v) g = v ESPColor = Color3.fromRGB(r,g,b) upCol() end})
ESPTab:CreateSlider({Name = "B", Min = 0, Max = 255, CurrentValue = 0, Callback = function(v) b = v ESPColor = Color3.fromRGB(r,g,b) upCol() end})
ESPTab:CreateInput({Name = "HEX Цвет", PlaceholderText = "FF0000", RemoveTextAfterFocusLost = false, Callback = function(t)
    local c = t:gsub("#", "") if #c == 6 then local nr, ng, nb = tonumber(c:sub(1,2),16), tonumber(c:sub(3,4),16), tonumber(c:sub(5,6),16) if nr and ng and nb then ESPColor = Color3.fromRGB(nr,ng,nb) upCol() end end
end})
RunService.Heartbeat:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        local c, root = p.Character, p.Character.HumanoidRootPart
        if ESPEnabled then
            local h = c:FindFirstChild("ESPHighlight") or Instance.new("Highlight", c) h.Name = "ESPHighlight" h.FillTransparency = 0.5 h.FillColor, h.OutlineColor = ESPColor, ESPColor
            local b = c:FindFirstChild("ESPBillboard") if not b then
                b = Instance.new("BillboardGui", c) b.Name = "ESPBillboard" b.AlwaysOnTop = true b.Size = UDim2.new(0,200,0,50) b.StudsOffset = Vector3.new(0,3,0)
                local tl = Instance.new("TextLabel", b) tl.Name = "TextLabel" tl.Size = UDim2.new(1,0,1,0) tl.BackgroundTransparency = 1 tl.Font = Enum.Font.SourceSansBold tl.TextSize = 14 tl.TextStrokeTransparency = 0
            end
            local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude) or 0)
            b.TextLabel.Text = string.format("%s | %d studs | ID: %d", p.Name, dist, p.UserId) b.TextLabel.TextColor3 = ESPColor
        else local h = c:FindFirstChild("ESPHighlight") local b = c:FindFirstChild("ESPBillboard") if h then h:Destroy() end if b then b:Destroy() end end
    end end
end)
