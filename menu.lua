[18.07.2026 20:17] Legenda: local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local settings = {WH = true, SkillCheck = true}

local function waitForRound()
    while not player.Character or not player.Character:FindFirstChild("Humanoid") do wait(0.5) end
    wait(1)
end
waitForRound()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RyzenMenu"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 110)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.new(1, 0.5, 0)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixels = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "Меню Ryzen"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local whBtn = Instance.new("TextButton")
whBtn.Size = UDim2.new(0, 100, 0, 30)
whBtn.Position = UDim2.new(0, 5, 0, 40)
whBtn.BackgroundColor3 = Color3.new(0, 1, 0)
whBtn.Text = "ВХ: ВКЛ"
whBtn.TextColor3 = Color3.new(1, 1, 1)
whBtn.TextScaled = true
whBtn.Font = Enum.Font.Gotham
whBtn.Parent = frame

whBtn.MouseButton1Click:Connect(function()
    settings.WH = not settings.WH
    whBtn.Text = settings.WH and "ВХ: ВКЛ" or "ВХ: ВЫКЛ"
    whBtn.BackgroundColor3 = settings.WH and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
end)

local scBtn = Instance.new("TextButton")
scBtn.Size = UDim2.new(0, 100, 0, 30)
scBtn.Position = UDim2.new(0, 115, 0, 40)
scBtn.BackgroundColor3 = Color3.new(0, 1, 0)
scBtn.Text = "Скилл: ВКЛ"
scBtn.TextColor3 = Color3.new(1, 1, 1)
scBtn.TextScaled = true
scBtn.Font = Enum.Font.Gotham
scBtn.Parent = frame

scBtn.MouseButton1Click:Connect(function()
    settings.SkillCheck = not settings.SkillCheck
    scBtn.Text = settings.SkillCheck and "Скилл: ВКЛ" or "Скилл: ВЫКЛ"
    scBtn.BackgroundColor3 = settings.SkillCheck and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
end)

local function createESP(plr)
    if plr == player or not settings.WH then return end
    local char = plr.Character
    if not char or not char:FindFirstChild("Head") then return end
    for _, v in pairs(char.Head:GetChildren()) do if v:IsA("BillboardGui") and v.Name == "RyzenESP" then v:Destroy() end end
    local bill = Instance.new("BillboardGui")
    bill.Name = "RyzenESP"
    bill.Size = UDim2.new(0, 0, 0, 0)
    bill.StudsOffset = Vector3.new(0, 2, 0)
    bill.AlwaysOnTop = true
    bill.Parent = char.Head
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 15, 0, 15)
    dot.BackgroundTransparency = 0
    dot.BorderSizePixels = 0
    dot.Position = UDim2.new(0.5, -7.5, 0.5, -7.5)
    dot.Parent = bill
    local roleText = ""
    for _, child in pairs(char.Head:GetChildren()) do
        if child:IsA("BillboardGui") and child.Name ~= "RyzenESP" then
            local txt = child:FindFirstChild("TextLabel")
            if txt and txt.Text then roleText = txt.Text break end
        end
    end
    if roleText:find("Мафия") or roleText:find("Mafia") then
        dot.BackgroundColor3 = Color3.new(1, 0, 0)
    elseif roleText:find("Выживший") or roleText:find("Survivor") then
        dot.BackgroundColor3 = Color3.new(0, 1, 0)
    else
        dot.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    end
end

for _, plr in pairs(game.Players:GetChildren()) do createESP(plr) end
game.Players.PlayerAdded:Connect(function(plr) plr.CharacterAdded:Connect(function() wait(0.5) createESP(plr) end) end)

game:GetService("RunService").Heartbeat:Connect(function()
    if not settings.WH then
        for _, plr in pairs(game.Players:GetChildren()) do
            if plr ~= player and plr.Character and plr.Character.Head then
                for _, v in pairs(plr.Character.Head:GetChildren()) do
[18.07.2026 20:17] Legenda: if v:IsA("BillboardGui") and v.Name == "RyzenESP" then v:Destroy() end
                end
            end
        end
        return
    end
    for _, plr in pairs(game.Players:GetChildren()) do
        if plr ~= player and plr.Character and plr.Character.Head then
            local hasESP = false
            for _, v in pairs(plr.Character.Head:GetChildren()) do
                if v:IsA("BillboardGui") and v.Name == "RyzenESP" then hasESP = true end
            end
            if not hasESP then createESP(plr) end
        end
    end
end)

local function updateSelfDot()
    local char = player.Character
    if not char or not char.Head then return end
    for _, v in pairs(char.Head:GetChildren()) do if v:IsA("BillboardGui") and v.Name == "RyzenESP_Self" then v:Destroy() end end
    local myRole = ""
    for _, child in pairs(char.Head:GetChildren()) do
        if child:IsA("BillboardGui") and child.Name ~= "RyzenESP" and child.Name ~= "RyzenESP_Self" then
            local txt = child:FindFirstChild("TextLabel")
            if txt and txt.Text then myRole = txt.Text break end
        end
    end
    local selfBill = Instance.new("BillboardGui")
    selfBill.Name = "RyzenESP_Self"
    selfBill.Size = UDim2.new(0, 0, 0, 0)
    selfBill.StudsOffset = Vector3.new(0, 3, 0)
    selfBill.AlwaysOnTop = true
    selfBill.Parent = char.Head
    local selfDot = Instance.new("Frame")
    selfDot.Size = UDim2.new(0, 20, 0, 20)
    selfDot.BackgroundTransparency = 0
    selfDot.BorderSizePixels = 0
    selfDot.Position = UDim2.new(0.5, -10, 0.5, -10)
    selfDot.Parent = selfBill
    if myRole:find("Мафия") or myRole:find("Mafia") then
        selfDot.BackgroundColor3 = Color3.new(1, 0, 0)
    elseif myRole:find("Выживший") or myRole:find("Survivor") then
        selfDot.BackgroundColor3 = Color3.new(0, 1, 0)
    else
        selfDot.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    end
end

updateSelfDot()
player.CharacterAdded:Connect(function() wait(1) updateSelfDot() end)

game:GetService("RunService").RenderStepped:Connect(function()
    if not settings.SkillCheck then return end
    local skillCheck = nil
    for _, gui in pairs(game.CoreGui:GetDescendants()) do
        if gui:IsA("Frame") and (gui.Name:lower():find("skill") or gui.Name:lower():find("check")) then
            local success = gui:FindFirstChild("SuccessZone") or gui:FindFirstChild("GreenZone") or gui:FindFirstChild("HitZone")
            if success and success:IsA("GuiObject") and success.Visible then
                skillCheck = success
                break
            end
        end
    end
    if skillCheck then
        local absPos = skillCheck.AbsolutePosition
        local absSize = skillCheck.AbsoluteSize
        mouse.Move(UDim2.new(0, absPos.X + absSize.X/2, 0, absPos.Y + absSize.Y/2))
        mouse.Button1Click()
        wait(0.05)
    end
end)
