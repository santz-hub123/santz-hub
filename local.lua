-- SANTZ HUB - Teleguiado Inteligente com velocidade fixa em 50 e ESP RGB

-- SERVIÇOS
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- FUNÇÕES RGB MELHORADAS
local function startRGBText(obj)
    if not obj then return end
    coroutine.wrap(function()
        local hue = 0
        while obj and obj.Parent do
            hue = (hue + 0.005) % 1
            if obj and obj.Parent then
                obj.TextColor3 = Color3.fromHSV(hue, 1, 1)
            end
            task.wait(0.03)
        end
    end)()
end

local function startRGBStroke(obj)
    if not obj then return end
    coroutine.wrap(function()
        local hue = 0
        while obj and obj.Parent do
            hue = (hue + 0.005) % 1
            if obj and obj.Parent then
                obj.Color = Color3.fromHSV(hue, 1, 1)
            end
            task.wait(0.03)
        end
    end)()
end

-- ESP
local espEnabled = false
local espConnections = {}
local espLabels = {}

local function createESP(targetPlayer)
    if targetPlayer == player then return end
    local function updateESP()
        local character = targetPlayer.Character
        if not character or not character:FindFirstChild("Head") then return end
        local head = character.Head
        if espLabels[targetPlayer.Name] then
            espLabels[targetPlayer.Name]:Destroy()
            espLabels[targetPlayer.Name] = nil
        end
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "ESP_" .. targetPlayer.Name
        billboardGui.Adornee = head
        billboardGui.Size = UDim2.new(0, 120, 0, 25)
        billboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
        billboardGui.AlwaysOnTop = true
        billboardGui.Parent = head
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Parent = billboardGui
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = targetPlayer.Name
        nameLabel.Font = Enum.Font.Arcade
        nameLabel.TextSize = 12
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        nameLabel.TextScaled = false
        startRGBText(nameLabel)
        espLabels[targetPlayer.Name] = billboardGui
    end
    local connections = {}
    table.insert(connections, targetPlayer.CharacterAdded:Connect(updateESP))
    if targetPlayer.Character then
        updateESP()
        if targetPlayer.Character:FindFirstChild("Humanoid") then
            table.insert(connections, targetPlayer.Character.Humanoid.Died:Connect(function()
                if espLabels[targetPlayer.Name] then
                    espLabels[targetPlayer.Name]:Destroy()
                    espLabels[targetPlayer.Name] = nil
                end
            end))
        end
    end
    espConnections[targetPlayer.Name] = connections
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= player then
                createESP(targetPlayer)
            end
        end
        espConnections["PlayerAdded"] = Players.PlayerAdded:Connect(function(newPlayer)
            if newPlayer ~= player then
                createESP(newPlayer)
            end
        end)
        Status.Text = "✅ ESP NAME Ativado (RGB + Minecraft Font)"
    else
        for playerName, connections in pairs(espConnections) do
            if connections then
                if typeof(connections) == "table" then
                    for _, connection in pairs(connections) do
                        if connection and connection.Connected then
                            connection:Disconnect()
                        end
                    end
                elseif connections.Connected then
                    connections:Disconnect()
                end
            end
        end
        espConnections = {}
        for playerName, label in pairs(espLabels) do
            if label then
                label:Destroy()
            end
        end
        espLabels = {}
        Status.Text = "❌ ESP NAME Desativado"
    end
end

-- GUI PRINCIPAL
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "SANTZHUB_GUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 320)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

MainFrame:TweenPosition(UDim2.new(0.4, 0, 0.3, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "SANTZ HUB"
Title.Font = Enum.Font.Arcade
Title.TextSize = 22
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextXAlignment = Enum.TextXAlignment.Left
startRGBText(Title)

local MinButton = Instance.new("TextButton", MainFrame)
MinButton.Size = UDim2.new(0, 20, 0, 20)
MinButton.Position = UDim2.new(1, -50, 0, 5)
MinButton.Text = "-"
MinButton.Font = Enum.Font.Arcade
MinButton.TextSize = 20
MinButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinButton.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MinButton).CornerRadius = UDim.new(0, 6)

local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Size = UDim2.new(0, 80, 0, 80)
LogoButton.Position = UDim2.new(0, 20, 0, 20)
LogoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LogoButton.BorderSizePixel = 0
LogoButton.Image = "rbxassetid://79925562792133"
LogoButton.ScaleType = Enum.ScaleType.Fit

local LogoCorner = Instance.new("UICorner", LogoButton)
LogoCorner.CornerRadius = UDim.new(0, 15)

local LogoStroke = Instance.new("UIStroke", LogoButton)
LogoStroke.Thickness = 3
LogoStroke.Transparency = 0.3
LogoStroke.Color = Color3.new(1, 1, 1)
startRGBStroke(LogoStroke)

LogoButton.MouseEnter:Connect(function()
    local hoverTween = TweenService:Create(LogoButton, 
        TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 90, 0, 90)}
    )
    hoverTween:Play()
    local strokeTween = TweenService:Create(LogoStroke,
        TweenInfo.new(0.2, Enum.EasingStyle.Quart),
        {Thickness = 5, Transparency = 0.1}
    )
    strokeTween:Play()
end)
LogoButton.MouseLeave:Connect(function()
    local leaveTween = TweenService:Create(LogoButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 80, 0, 80)}
    )
    leaveTween:Play()
    local strokeTween = TweenService:Create(LogoStroke,
        TweenInfo.new(0.2, Enum.EasingStyle.Quart),
        {Thickness = 3, Transparency = 0.3}
    )
    strokeTween:Play()
end)
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    local clickTween = TweenService:Create(LogoButton,
        TweenInfo.new(0.1, Enum.EasingStyle.Bounce),
        {Size = UDim2.new(0, 75, 0, 75)}
    )
    clickTween:Play()
    clickTween.Completed:Connect(function()
        local returnTween = TweenService:Create(LogoButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Bounce),
            {Size = UDim2.new(0, 80, 0, 80)}
        )
        returnTween:Play()
    end)
end)

local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1, -20, 0, 20)
Status.Position = UDim2.new(0, 10, 1, -30)
Status.Font = Enum.Font.Arcade
Status.TextSize = 16
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.new(1,1,1)
startRGBText(Status)

local SaveCoord = Instance.new("TextButton", MainFrame)
SaveCoord.Size = UDim2.new(1, -40, 0, 30)
SaveCoord.Position = UDim2.new(0, 20, 0, 60)
SaveCoord.Text = "Salvar Coordenada"
SaveCoord.Font = Enum.Font.Arcade
SaveCoord.TextSize = 16
SaveCoord.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SaveCoord.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SaveCoord).CornerRadius = UDim.new(0, 6)
startRGBText(SaveCoord)

local TeleGuiado = Instance.new("TextButton", MainFrame)
TeleGuiado.Size = UDim2.new(1, -40, 0, 30)
TeleGuiado.Position = UDim2.new(0, 20, 0, 100)
TeleGuiado.Text = "Teleguiado Inteligente"
TeleGuiado.Font = Enum.Font.Arcade
TeleGuiado.TextSize = 16
TeleGuiado.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TeleGuiado.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TeleGuiado).CornerRadius = UDim.new(0, 6)
startRGBText(TeleGuiado)

local ESPButton = Instance.new("TextButton", MainFrame)
ESPButton.Size = UDim2.new(1, -40, 0, 30)
ESPButton.Position = UDim2.new(0, 20, 0, 140)
ESPButton.Text = "ESP NAME [OFF]"
ESPButton.Font = Enum.Font.Arcade
ESPButton.TextSize = 16
ESPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ESPButton.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", ESPButton).CornerRadius = UDim.new(0, 6)
startRGBText(ESPButton)

-- TELEGUIADO INTELIGENTE - velocidade fixa 50
local savedPos = nil
local isMoving = false

local function smartTeleport(targetPos)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        Status.Text = "❌ Personagem não encontrado"
        return false
    end
    local hrp = char.HumanoidRootPart
    isMoving = true
    Status.Text = "🚀 Calculando rota..."

    local speed = 50 -- << VELOCIDADE FIXA AGORA EM 50
    local direction = (targetPos - hrp.Position).Unit
    local connection

    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(8000, 8000, 8000)
    bodyVel.Velocity = direction * speed
    bodyVel.Parent = hrp

    local startTime = tick()
    connection = RunService.Heartbeat:Connect(function()
        if not isMoving or not hrp.Parent then
            connection:Disconnect()
            if bodyVel then bodyVel:Destroy() end
            return
        end
        direction = (targetPos - hrp.Position).Unit
        bodyVel.Velocity = direction * speed

        local currentPos = hrp.Position
        local remainingDistance = (targetPos - currentPos).Magnitude
        Status.Text = string.format("✈ Indo... %.1fm", remainingDistance)

        if remainingDistance < 3 then
            Status.Text = "✅ Chegou ao destino!"
            isMoving = false
            connection:Disconnect()
            if bodyVel then bodyVel:Destroy() end
        end

        if tick() - startTime > 30 then
            Status.Text = "⚠ Timeout - Muito longe?"
            isMoving = false
            connection:Disconnect()
            if bodyVel then bodyVel:Destroy() end
        end
    end)
    return true
end

SaveCoord.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        savedPos = hrp.Position
        Status.Text = string.format("✅ Posição salva: %.1f, %.1f, %.1f", savedPos.X, savedPos.Y, savedPos.Z)
    else
        Status.Text = "❌ Erro ao salvar posição"
    end
end)

TeleGuiado.MouseButton1Click:Connect(function()
    if isMoving then
        isMoving = false
        Status.Text = "⚠ Teleguiado cancelado"
        return
    end
    if not savedPos then
        Status.Text = "❌ Salve uma posição primeiro"
        return
    end
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        Status.Text = "❌ Personagem não encontrado"
        return
    end
    smartTeleport(savedPos)
end)

ESPButton.MouseButton1Click:Connect(function()
    toggleESP()
    ESPButton.Text = espEnabled and "ESP NAME [ON]" or "ESP NAME [OFF]"
end)

MinButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

player.CharacterRemoving:Connect(function()
    isMoving = false
    for playerName, connections in pairs(espConnections) do
        if connections and typeof(connections) == "table" then
            for _, connection in pairs(connections) do
                if connection and connection.Connected then
                    connection:Disconnect()
                end
            end
        elseif connections and connections.Connected then
            connections:Disconnect()
        end
    end
    for playerName, label in pairs(espLabels) do
        if label and label.Parent then
            label:Destroy()
        end
    end
    espConnections = {}
    espLabels = {}
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if espLabels[leavingPlayer.Name] then
        espLabels[leavingPlayer.Name]:Destroy()
        espLabels[leavingPlayer.Name] = nil
    end
    if espConnections[leavingPlayer.Name] then
        local connections = espConnections[leavingPlayer.Name]
        if typeof(connections) == "table" then
            for _, connection in pairs(connections) do
                if connection and connection.Connected then
                    connection:Disconnect()
                end
            end
        elseif connections and connections.Connected then
            connections:Disconnect()
        end
        espConnections[leavingPlayer.Name] = nil
    end
end)

MainFrame.Visible = false
Status.Text = "SANTZ HUB v2.0 - Pronto! 🚀"
