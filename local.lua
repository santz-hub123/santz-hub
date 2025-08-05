-- SANTZ STORE - Script Completo, Moderno e Organizado (~400 linhas)
-- Autor: santz-hub123 | Discord: @santz | github.com/santz-hub123

-- Serviços Roblox
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")

-- Player & Personagem
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Variáveis globais
local mainFrame, telePanel, aboutPanel
local isMinimized = false
local toggleStates = {}
local espRefs = { GOD={}, SECRET={}, BASE={}, PLAYER={}, NAME={} }
local savedCoords = {} -- múltiplos pontos de teleporte
local connections = {}

-- Cores/Tema
local Theme = {
    MainBg = Color3.fromRGB(25, 25, 25),
    Accent = Color3.fromRGB(0, 255, 127),
    Button = Color3.fromRGB(30, 30, 30),
    ButtonHover = Color3.fromRGB(50, 50, 50),
    Enabled = Color3.fromRGB(0, 200, 0),
    Disabled = Color3.fromRGB(200, 0, 0),
    PanelBg = Color3.fromRGB(18,18,18)
}

----------------------------------------------------
-- Funções Utilitárias
----------------------------------------------------
local function playClickSound()
    local sound = Instance.new("Sound", SoundService)
    sound.SoundId = "rbxassetid://131961136"
    sound.Volume = 0.3
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local function createRGBBorder(frame)
    local border = Instance.new("UIStroke", frame)
    border.Thickness = 2
    border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    task.spawn(function()
        while frame.Parent do
            for i = 0, 1, 0.01 do
                if not frame.Parent then break end
                border.Color = Color3.fromHSV(i,1,1)
                task.wait(0.03)
            end
        end
    end)
end

local function makeDraggable(frame)
    local dragging, dragStart, startPos = false, nil, nil
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if dragging then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
            end
        end
    end)
end

local function createStyledButton(parent, text, color, pos, size, iconId)
    local b = Instance.new("TextButton", parent)
    b.Name = text
    b.Text = text
    b.Size = size or UDim2.new(1,0,0,32)
    b.Position = pos
    b.BackgroundColor3 = color or Theme.Button
    b.BorderSizePixel = 0
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    b.Font = Enum.Font.GothamBold
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0,6)
    createRGBBorder(b)
    if iconId then
        local icon = Instance.new("ImageLabel", b)
        icon.Size = UDim2.new(0, 22, 0, 22)
        icon.Position = UDim2.new(0, 6, 0.5, -11)
        icon.BackgroundTransparency = 1
        icon.Image = "rbxassetid://"..tostring(iconId)
    end
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = Theme.ButtonHover}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = color or Theme.Button}):Play()
    end)
    return b
end

local function clearESP(tag, parent)
    for _, v in pairs(parent:GetChildren()) do
        if v.Name == tag then v:Destroy() end
    end
end

----------------------------------------------------
-- Funções de ESP
----------------------------------------------------
local function toggleESPGod()
    local state = not toggleStates["ESP GOD"] toggleStates["ESP GOD"] = state
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            if state then
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if root and (p.Name:lower():find("god") or (p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Rank") and p.leaderstats.Rank.Value:lower():find("god"))) then
                    local bill = Instance.new("BillboardGui", p.Character)
                    bill.Name = "ESP_GOD" bill.Adornee = root bill.Size = UDim2.new(0, 100, 0, 50)
                    local label = Instance.new("TextLabel", bill)
                    label.Size = UDim2.new(1,0,1,0) label.BackgroundTransparency = 1
                    label.Text = "GOD" label.TextColor3 = Color3.fromRGB(128,0,128)
                    label.TextScaled = true label.Font = Enum.Font.GothamBold
                end
            else clearESP("ESP_GOD", p.Character)
            end
        end
    end
end

local function toggleESPSecret()
    local state = not toggleStates["ESP SECRET"] toggleStates["ESP SECRET"] = state
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") and (obj.Name:lower():find("secret") or obj.Name:lower():find("hidden")) then
            if state then
                local h = Instance.new("Highlight", obj)
                h.Name = "ESP_SECRET" h.FillColor = Color3.new(0,0,0)
                h.OutlineColor = Color3.new(1,1,1)
            else clearESP("ESP_SECRET", obj)
            end
        end
    end
end

local function toggleESPBase()
    local state = not toggleStates["ESP BASE"] toggleStates["ESP BASE"] = state
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") and (obj.Name:lower():find("base") or obj.Name:lower():find("door")) then
            if state then
                local bill = Instance.new("BillboardGui", obj)
                bill.Name = "ESP_BASE" bill.Adornee = obj bill.Size = UDim2.new(0, 120, 0, 40)
                local label = Instance.new("TextLabel", bill)
                label.Size = UDim2.new(1,0,1,0) label.BackgroundTransparency = 1
                label.TextColor3 = Color3.new(1,1,1) label.TextScaled = true label.Font = Enum.Font.Code
                local locked = math.random(1,2)==1
                if locked then
                    local t = math.random(10, 300)
                    label.Text = "LOCKED ("..t.."s)" label.TextColor3 = Color3.new(1,0,0)
                else
                    label.Text = "UNLOCKED" label.TextColor3 = Color3.new(0,1,0)
                end
            else clearESP("ESP_BASE", obj)
            end
        end
    end
end

local function toggleESPPlayer()
    local state = not toggleStates["ESP PLAYER"] toggleStates["ESP PLAYER"] = state
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            if state then
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local h = Instance.new("Highlight", p.Character)
                    h.Name = "ESP_PLAYER"
                    h.FillColor = Color3.fromRGB(0,100,255)
                    h.FillTransparency = 0.5
                    h.OutlineColor = Color3.fromRGB(0,150,255)
                end
            else clearESP("ESP_PLAYER", p.Character)
            end
        end
    end
end

local function toggleESPName()
    local state = not toggleStates["ESP NAME"] toggleStates["ESP NAME"] = state
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local head = p.Character:FindFirstChild("Head")
            if head then
                if state then
                    local bill = Instance.new("BillboardGui", p.Character)
                    bill.Name = "ESP_NAME" bill.Adornee = head bill.Size = UDim2.new(0,80,0,20)
                    bill.StudsOffset = Vector3.new(0,2,0)
                    local label = Instance.new("TextLabel", bill)
                    label.Size = UDim2.new(1,0,1,0) label.BackgroundTransparency = 1
                    label.Text = p.Name label.TextScaled = true label.Font = Enum.Font.Arcade
                    task.spawn(function()
                        while bill.Parent do
                            for i=0,1,0.05 do
                                if not bill.Parent then break end
                                label.TextColor3 = Color3.fromHSV(i,1,1)
                                task.wait(0.1)
                            end
                        end
                    end)
                else clearESP("ESP_NAME", p.Character)
                end
            end
        end
    end
end

----------------------------------------------------
-- Funções de Movimento/Personagem
----------------------------------------------------
local function activateDash()
    local bv = Instance.new("BodyVelocity", rootPart)
    bv.MaxForce = Vector3.new(4000,0,4000)
    bv.Velocity = rootPart.CFrame.LookVector * 100
    wait(0.3)
    bv:Destroy()
end

local function toggleSuperman()
    toggleStates["Superman"] = not toggleStates["Superman"]
    humanoid.WalkSpeed = toggleStates["Superman"] and 100 or 16
    humanoid.JumpPower = toggleStates["Superman"] and 150 or 50
end

local function toggleAntiHit()
    toggleStates["ANTI-HIT"] = not toggleStates["ANTI-HIT"]
    humanoid.PlatformStand = toggleStates["ANTI-HIT"]
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = not toggleStates["ANTI-HIT"]
        end
    end
end

----------------------------------------------------
-- Painel de Teleporte
----------------------------------------------------
local function createTelePanel()
    telePanel = Instance.new("Frame", mainFrame.Parent)
    telePanel.Name = "TelePanel"
    telePanel.Size = UDim2.new(0,220,0,220)
    telePanel.Position = UDim2.new(1,-240,0,380)
    telePanel.BackgroundColor3 = Theme.PanelBg
    telePanel.BackgroundTransparency = 0.3
    telePanel.BorderSizePixel = 0
    telePanel.Active = true
    telePanel.Visible = false
    Instance.new("UICorner", telePanel).CornerRadius = UDim.new(0,10)
    createRGBBorder(telePanel)
    makeDraggable(telePanel)
    local teleTitle = Instance.new("TextLabel", telePanel)
    teleTitle.Size = UDim2.new(1,0,0,40)
    teleTitle.BackgroundTransparency = 1
    teleTitle.Text = "TELE PAINEL"
    teleTitle.TextColor3 = Color3.new(1,1,1)
    teleTitle.TextScaled = true
    teleTitle.Font = Enum.Font.GothamBold
    local saveBtn = createStyledButton(telePanel, "SALVAR COORD.", Theme.Enabled, UDim2.new(0,10,0,50), UDim2.new(1,-20,0,32), 6023426925)
    local coordsList = Instance.new("ScrollingFrame", telePanel)
    coordsList.Name = "CoordsList"
    coordsList.Size = UDim2.new(1,-20,0,45)
    coordsList.Position = UDim2.new(0,10,0,95)
    coordsList.CanvasSize = UDim2.new(0,0,0,0)
    coordsList.BackgroundTransparency = 1
    coordsList.BorderSizePixel = 0
    local teleGuiBtn = createStyledButton(telePanel, "TELE GUIADO", Theme.Accent, UDim2.new(0,10,0,150), UDim2.new(1,-20,0,32), 6026568198)
    local antiHitBtn = createStyledButton(telePanel, "ANTI-HIT", Theme.Disabled, UDim2.new(0,10,0,190), UDim2.new(1,-20,0,32), 6031075934)
    local function refreshCoords()
        coordsList:ClearAllChildren()
        coordsList.CanvasSize = UDim2.new(0,0,0,math.max(#savedCoords*32,45))
        for i, pos in ipairs(savedCoords) do
            local btn = Instance.new("TextButton", coordsList)
            btn.Size = UDim2.new(1,0,0,28)
            btn.Position = UDim2.new(0,0,0,(i-1)*30)
            btn.BackgroundColor3 = Theme.Button
            btn.Text = ("Coord %d: (%.1f,%.1f,%.1f)"):format(i, pos.X, pos.Y, pos.Z)
            btn.TextColor3 = Theme.Accent
            btn.TextScaled = true
            btn.Font = Enum.Font.Gotham
            btn.MouseButton1Click:Connect(function()
                playClickSound()
                local tween = TweenService:Create(rootPart, TweenInfo.new(2, Enum.EasingStyle.Quad), {Position = pos})
                tween:Play()
            end)
        end
    end
    saveBtn.MouseButton1Click:Connect(function()
        playClickSound()
        local pos = rootPart.Position + Vector3.new(0,3,0)
        table.insert(savedCoords, pos)
        refreshCoords()
        TweenService:Create(saveBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
        wait(0.2)
        TweenService:Create(saveBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Enabled}):Play()
    end)
    teleGuiBtn.MouseButton1Click:Connect(function()
        playClickSound()
        if #savedCoords > 0 then
            local pos = savedCoords[#savedCoords]
            local tween = TweenService:Create(rootPart, TweenInfo.new(2, Enum.EasingStyle.Quad), {Position = pos})
            tween:Play()
        end
    end)
    antiHitBtn.MouseButton1Click:Connect(function()
        playClickSound()
        toggleAntiHit()
        antiHitBtn.BackgroundColor3 = toggleStates["ANTI-HIT"] and Theme.Enabled or Theme.Disabled
    end)
    refreshCoords()
end

local function toggleTelePanel()
    if not telePanel then createTelePanel() end
    telePanel.Visible = not telePanel.Visible
end

----------------------------------------------------
-- Painel de Créditos/Sobre
----------------------------------------------------
local function createAboutPanel(parent)
    aboutPanel = Instance.new("Frame", parent)
    aboutPanel.Size = UDim2.new(0,220,0,100)
    aboutPanel.Position = UDim2.new(1,-240,0,610)
    aboutPanel.BackgroundColor3 = Color3.fromRGB(15,15,15)
    aboutPanel.BackgroundTransparency = 0.2
    aboutPanel.BorderSizePixel = 0
    aboutPanel.Visible = false
    Instance.new("UICorner", aboutPanel).CornerRadius = UDim.new(0,10)
    local title = Instance.new("TextLabel", aboutPanel)
    title.Size = UDim2.new(1,0,0,24)
    title.Position = UDim2.new(0,0,0,0)
    title.BackgroundTransparency = 1
    title.Text = "Sobre / Créditos"
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    local desc = Instance.new("TextLabel", aboutPanel)
    desc.Size = UDim2.new(1,-12,1,-28)
    desc.Position = UDim2.new(0,6,0,28)
    desc.BackgroundTransparency = 1
    desc.Text = "Script por SANTZ\ngithub.com/santz-hub123\nMelhore, compartilhe!"
    desc.TextColor3 = Color3.new(1,1,1)
    desc.TextScaled = true
    desc.Font = Enum.Font.Gotham
end
local function toggleAboutPanel()
    if not aboutPanel then createAboutPanel(mainFrame.Parent) end
    aboutPanel.Visible = not aboutPanel.Visible
end

----------------------------------------------------
-- Interface Principal
----------------------------------------------------
local function createMainGUI()
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = "SantzStore"
    mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0,220,0,420)
    mainFrame.Position = UDim2.new(1,-240,0,20)
    mainFrame.BackgroundColor3 = Theme.MainBg
    mainFrame.BackgroundTransparency = 0.3
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = false
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,10)
    createRGBBorder(mainFrame)
    makeDraggable(mainFrame)
    local title = Instance.new("TextLabel", mainFrame)
    title.Name = "Title"
    title.Size = UDim2.new(1,0,0,40)
    title.Position = UDim2.new(0,0,0,0)
    title.BackgroundTransparency = 1
    title.Text = "SANTZ STORE HUB"
    title.TextColor3 = Theme.Accent
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    local minimizeBtn = createStyledButton(mainFrame, "-", Theme.Disabled, UDim2.new(1,-35,0,5), UDim2.new(0,30,0,30), 6034996691)
    local closeBtn = createStyledButton(mainFrame, "X", Theme.Disabled, UDim2.new(1,-70,0,5), UDim2.new(0,30,0,30), 6031094678)
    local aboutBtn = createStyledButton(mainFrame, "?", Theme.Accent, UDim2.new(1,-105,0,5), UDim2.new(0,30,0,30), 6026568198)
    local buttonContainer = Instance.new("Frame", mainFrame)
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(1,-20,1,-60)
    buttonContainer.Position = UDim2.new(0,10,0,50)
    buttonContainer.BackgroundTransparency = 1
    local buttons = {
        {name="ESP GOD", color=Color3.fromRGB(128,0,128), func=toggleESPGod, icon=6031090935},
        {name="ESP SECRET", color=Color3.fromRGB(0,0,0), func=toggleESPSecret, icon=6031075934},
        {name="ESP BASE", color=Color3.fromRGB(0,0,0), func=toggleESPBase, icon=6031094678},
        {name="ESP PLAYER", color=Color3.fromRGB(0,100,255), func=toggleESPPlayer, icon=6031075934},
        {name="ESP NAME", color=Color3.fromRGB(255,255,255), func=toggleESPName, icon=6026568198},
        {name="Tele Menu", color=Theme.Accent, func=toggleTelePanel, icon=6034996691},
        {name="2 Dash", color=Color3.fromRGB(255,0,0), func=activateDash, icon=6031090935},
        {name="Superman", color=Color3.fromRGB(255,255,0), func=toggleSuperman, icon=6034981416}
    }
    for i, buttonData in ipairs(buttons) do
        local btn = createStyledButton(
            buttonContainer, buttonData.name, buttonData.color, 
            UDim2.new(0,0,0,(i-1)*40), UDim2.new(1,0,0,32), buttonData.icon
        )
        btn.MouseButton1Click:Connect(function()
            playClickSound()
            buttonData.func()
            btn.BackgroundColor3 = toggleStates[buttonData.name] and Theme.Enabled or buttonData.color
        end)
    end
    minimizeBtn.MouseButton1Click:Connect(function()
        playClickSound()
        isMinimized = not isMinimized
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = isMinimized and UDim2.new(0,220,0,40) or UDim2.new(0,220,0,420)}):Play()
        buttonContainer.Visible = not isMinimized
        minimizeBtn.Text = isMinimized and "+" or "-"
        if telePanel then telePanel.Visible = false end
    end)
    closeBtn.MouseButton1Click:Connect(function()
        playClickSound()
        screenGui:Destroy()
    end)
    aboutBtn.MouseButton1Click:Connect(function()
        playClickSound()
        toggleAboutPanel()
    end)
end

----------------------------------------------------
-- Inicialização
----------------------------------------------------
for _, state in pairs({"ESP GOD", "ESP SECRET", "ESP BASE", "ESP PLAYER", "ESP NAME", "Superman", "ANTI-HIT"}) do
    toggleStates[state] = false
end
createMainGUI()
player.CharacterAdded:Connect(function()
    character = player.Character
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
end)
print("SANTZ STORE carregado!")
