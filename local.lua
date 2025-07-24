-- SANTZ HUB RGB + Server Hopping - Script Completo
-- Criado por: Santz

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Variáveis globais
local supermanGuiOpen = false
local serverHopGuiOpen = false
local isHopping = false
local serversVisited = 0
local specialBrainrots = 0

-- Sistema de salvamento
local SETTINGS_KEY = "SantzHubSettings_" .. player.UserId
local defaultSettings = {
    speed = 50,
    jump = 100
}

-- Função para salvar configurações
local function saveSettings()
    local settings = {
        speed = currentSpeed,
        jump = currentJump
    }
    _G.SantzHubSavedSettings = settings
end

-- Função para carregar configurações
local function loadSettings()
    local settings = _G.SantzHubSavedSettings or defaultSettings
    return settings
end

-- Carregar configurações salvas
local savedSettings = loadSettings()
local currentSpeed = savedSettings.speed
local currentJump = savedSettings.jump

-- Lista de palavras especiais para server hopping
local secretWords = {"secret", "admin", "vip", "private", "dev", "test", "beta"}
local godWords = {"god", "op", "hack", "cheat", "exploit", "script"}

-- Função para criar notificação
local function createNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
    })
end

-- Função para obter servidores do jogo
local function getServers()
    local success, result = pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local response = HttpService:GetAsync(url)
        return HttpService:JSONDecode(response)
    end)
    
    if success and result.data then
        return result.data
    else
        return {}
    end
end

-- Função para verificar se um servidor tem palavras especiais
local function hasSpecialWords(serverName, wordList)
    if not serverName then return false end
    local lowerName = string.lower(serverName)
    
    for _, word in pairs(wordList) do
        if string.find(lowerName, word) then
            return true
        end
    end
    return false
end

-- Criar ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SantzHubGui"
screenGui.Parent = CoreGui

-- Frame principal RGB
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 170)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -85)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderColor3 = Color3.fromRGB(0, 162, 255)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Arredondar interface
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Efeito RGB na borda
local function createRGBEffect()
    spawn(function()
        local hue = 0
        while wait(0.1) do
            hue = hue + 5
            if hue >= 360 then hue = 0 end
            
            local r = math.sin(math.rad(hue)) * 127 + 128
            local g = math.sin(math.rad(hue + 120)) * 127 + 128
            local b = math.sin(math.rad(hue + 240)) * 127 + 128
            
            mainFrame.BorderColor3 = Color3.fromRGB(r, g, b)
        end
    end)
end

createRGBEffect()

-- Título SANTZ HUB RGB
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 25)
titleLabel.Position = UDim2.new(0, 0, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SANTZ HUB RGB"
titleLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.Arcade
titleLabel.TextStrokeTransparency = 0
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Parent = mainFrame

-- Efeito RGB no título
spawn(function()
    local hue = 0
    while wait(0.1) do
        hue = hue + 10
        if hue >= 360 then hue = 0 end
        
        local r = math.sin(math.rad(hue)) * 127 + 128
        local g = math.sin(math.rad(hue + 120)) * 127 + 128
        local b = math.sin(math.rad(hue + 240)) * 127 + 128
        
        titleLabel.TextColor3 = Color3.fromRGB(r, g, b)
    end
end)

-- TikTok info
local tiktokLabel = Instance.new("TextLabel")
tiktokLabel.Name = "TikTokLabel"
tiktokLabel.Size = UDim2.new(1, 0, 0, 15)
tiktokLabel.Position = UDim2.new(0, 0, 0, 30)
tiktokLabel.BackgroundTransparency = 1
tiktokLabel.Text = "TIKTOK: santzhub.scripts"
tiktokLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
tiktokLabel.TextSize = 10
tiktokLabel.Font = Enum.Font.Arcade
tiktokLabel.TextStrokeTransparency = 0
tiktokLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
tiktokLabel.Parent = mainFrame

-- Botão Santz Hall Out
local hallOutBtn = Instance.new("TextButton")
hallOutBtn.Name = "HallOutBtn"
hallOutBtn.Size = UDim2.new(0.9, 0, 0, 20)
hallOutBtn.Position = UDim2.new(0.05, 0, 0, 55)
hallOutBtn.BackgroundTransparency = 1
hallOutBtn.Text = "Santz Hall Out"
hallOutBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
hallOutBtn.TextSize = 12
hallOutBtn.Font = Enum.Font.Arcade
hallOutBtn.TextStrokeTransparency = 0
hallOutBtn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
hallOutBtn.Parent = mainFrame

-- Botão Superman
local supermanBtn = Instance.new("TextButton")
supermanBtn.Name = "SupermanBtn"
supermanBtn.Size = UDim2.new(0.9, 0, 0, 20)
supermanBtn.Position = UDim2.new(0.05, 0, 0, 85)
supermanBtn.BackgroundTransparency = 1
supermanBtn.Text = "Superman"
supermanBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
supermanBtn.TextSize = 12
supermanBtn.Font = Enum.Font.Arcade
supermanBtn.TextStrokeTransparency = 0
supermanBtn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
supermanBtn.Parent = mainFrame

-- Botão Server Hop
local serverHopBtn = Instance.new("TextButton")
serverHopBtn.Name = "ServerHopBtn"
serverHopBtn.Size = UDim2.new(0.9, 0, 0, 20)
serverHopBtn.Position = UDim2.new(0.05, 0, 0, 115)
serverHopBtn.BackgroundTransparency = 1
serverHopBtn.Text = "Server Hop"
serverHopBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
serverHopBtn.TextSize = 12
serverHopBtn.Font = Enum.Font.Arcade
serverHopBtn.TextStrokeTransparency = 0
serverHopBtn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
serverHopBtn.Parent = mainFrame

-- Botão Rejoin
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Name = "RejoinBtn"
rejoinBtn.Size = UDim2.new(0.9, 0, 0, 20)
rejoinBtn.Position = UDim2.new(0.05, 0, 0, 145)
rejoinBtn.BackgroundTransparency = 1
rejoinBtn.Text = "Rejoin"
rejoinBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
rejoinBtn.TextSize = 12
rejoinBtn.Font = Enum.Font.Arcade
rejoinBtn.TextStrokeTransparency = 0
rejoinBtn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
rejoinBtn.Parent = mainFrame

-- GUI DO SUPERMAN
local supermanGui = Instance.new("Frame")
supermanGui.Name = "SupermanGUI"
supermanGui.Size = UDim2.new(0, 300, 0, 250)
supermanGui.Position = UDim2.new(0.5, -150, 0.5, -125)
supermanGui.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
supermanGui.BorderSizePixel = 0
supermanGui.Visible = false
supermanGui.Active = true
supermanGui.Draggable = true
supermanGui.Parent = screenGui

-- Arredondar Superman GUI
local supermanCorner = Instance.new("UICorner")
supermanCorner.CornerRadius = UDim.new(0, 12)
supermanCorner.Parent = supermanGui

-- Header Superman
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
header.BorderSizePixel = 0
header.Parent = supermanGui

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Título Superman
local supermanTitle = Instance.new("TextLabel")
supermanTitle.Name = "Title"
supermanTitle.Size = UDim2.new(1, -80, 1, 0)
supermanTitle.Position = UDim2.new(0, 10, 0, 0)
supermanTitle.BackgroundTransparency = 1
supermanTitle.Text = "⚡ SUPERMAN"
supermanTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
supermanTitle.TextSize = 16
supermanTitle.TextXAlignment = Enum.TextXAlignment.Left
supermanTitle.Font = Enum.Font.GothamBold
supermanTitle.Parent = header

-- Botão fechar Superman
local closeSupermanBtn = Instance.new("TextButton")
closeSupermanBtn.Name = "CloseButton"
closeSupermanBtn.Size = UDim2.new(0, 30, 0, 30)
closeSupermanBtn.Position = UDim2.new(1, -35, 0, 5)
closeSupermanBtn.BackgroundColor3 = Color3.fromRGB(255, 73, 97)
closeSupermanBtn.BorderSizePixel = 0
closeSupermanBtn.Text = "×"
closeSupermanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeSupermanBtn.TextSize = 16
closeSupermanBtn.Font = Enum.Font.GothamBold
closeSupermanBtn.Parent = header

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 8)
closeBtnCorner.Parent = closeSupermanBtn

-- Container Superman
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(1, -20, 1, -50)
container.Position = UDim2.new(0, 10, 0, 45)
container.BackgroundTransparency = 1
container.Parent = supermanGui

-- Status do boost
local statusFrame = Instance.new("Frame")
statusFrame.Name = "StatusFrame"
statusFrame.Size = UDim2.new(1, 0, 0, 25)
statusFrame.Position = UDim2.new(0, 0, 0, 0)
statusFrame.BackgroundColor3 = Color3.fromRGB(40, 43, 48)
statusFrame.BorderSizePixel = 0
statusFrame.Parent = container

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, -10, 1, 0)
statusLabel.Position = UDim2.new(0, 5, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "🔴 BOOST INATIVO"
statusLabel.TextColor3 = Color3.fromRGB(185, 187, 190)
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = statusFrame

-- GUI DO SERVER HOP
local serverHopGui = Instance.new("Frame")
serverHopGui.Name = "ServerHopGUI"
serverHopGui.Size = UDim2.new(0, 400, 0, 400)
serverHopGui.Position = UDim2.new(0.5, -200, 0.5, -200)
serverHopGui.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
serverHopGui.BorderSizePixel = 0
serverHopGui.Visible = false
serverHopGui.Active = true
serverHopGui.Draggable = true
serverHopGui.Parent = screenGui

-- Arredondar Server Hop GUI
local serverHopCorner = Instance.new("UICorner")
serverHopCorner.CornerRadius = UDim.new(0, 15)
serverHopCorner.Parent = serverHopGui

-- Título do Server Hop
local hopTitleLabel = Instance.new("TextLabel")
hopTitleLabel.Name = "TitleLabel"
hopTitleLabel.Parent = serverHopGui
hopTitleLabel.BackgroundTransparency = 1
hopTitleLabel.Position = UDim2.new(0, 0, 0, 10)
hopTitleLabel.Size = UDim2.new(1, 0, 0, 30)
hopTitleLabel.Font = Enum.Font.GothamBold
hopTitleLabel.Text = "SANTZ HOP PREMIUM"
hopTitleLabel.TextColor3 = Color3.fromRGB(135, 206, 235)
hopTitleLabel.TextScaled = true
hopTitleLabel.TextSize = 24
hopTitleLabel.TextStrokeTransparency = 0
hopTitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Subtítulo Server Hop
local hopSubtitleLabel = Instance.new("TextLabel")
hopSubtitleLabel.Name = "SubtitleLabel"
hopSubtitleLabel.Parent = serverHopGui
hopSubtitleLabel.BackgroundTransparency = 1
hopSubtitleLabel.Position = UDim2.new(0, 0, 0, 40)
hopSubtitleLabel.Size = UDim2.new(1, 0, 0, 20)
hopSubtitleLabel.Font = Enum.Font.Gotham
hopSubtitleLabel.Text = "Servidor hopping avançado"
hopSubtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
hopSubtitleLabel.TextScaled = true
hopSubtitleLabel.TextSize = 14

-- Botão fechar Server Hop
local closeServerHopBtn = Instance.new("TextButton")
closeServerHopBtn.Name = "CloseButton"
closeServerHopBtn.Size = UDim2.new(0, 30, 0, 30)
closeServerHopBtn.Position = UDim2.new(1, -35, 0, 5)
closeServerHopBtn.BackgroundColor3 = Color3.fromRGB(255, 73, 97)
closeServerHopBtn.BorderSizePixel = 0
closeServerHopBtn.Text = "×"
closeServerHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeServerHopBtn.TextSize = 16
closeServerHopBtn.Font = Enum.Font.GothamBold
closeServerHopBtn.Parent = serverHopGui

local closeHopBtnCorner = Instance.new("UICorner")
closeHopBtnCorner.CornerRadius = UDim.new(0, 8)
closeHopBtnCorner.Parent = closeServerHopBtn

-- Frame de status do hop
local hopStatusFrame = Instance.new("Frame")
hopStatusFrame.Name = "StatusFrame"
hopStatusFrame.Parent = serverHopGui
hopStatusFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
hopStatusFrame.BorderSizePixel = 0
hopStatusFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
hopStatusFrame.Size = UDim2.new(0.9, 0, 0.08, 0)

local hopStatusCorner = Instance.new("UICorner")
hopStatusCorner.CornerRadius = UDim.new(0, 8)
hopStatusCorner.Parent = hopStatusFrame

-- Label de status do hop
local hopStatusLabel = Instance.new("TextLabel")
hopStatusLabel.Name = "StatusLabel"
hopStatusLabel.Parent = hopStatusFrame
hopStatusLabel.BackgroundTransparency = 1
hopStatusLabel.Size = UDim2.new(1, 0, 1, 0)
hopStatusLabel.Font = Enum.Font.Gotham
hopStatusLabel.Text = "Status: Pronto"
hopStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
hopStatusLabel.TextScaled = true
hopStatusLabel.TextSize = 14

-- Estatísticas do hop
local hopStatsFrame = Instance.new("Frame")
hopStatsFrame.Name = "StatsFrame"
hopStatsFrame.Parent = serverHopGui
hopStatsFrame.BackgroundTransparency = 1
hopStatsFrame.Position = UDim2.new(0, 0, 0.35, 0)
hopStatsFrame.Size = UDim2.new(1, 0, 0.1, 0)

-- Labels de estatísticas
local serversLabel = Instance.new("TextLabel")
serversLabel.Name = "ServersLabel"
serversLabel.Parent = hopStatsFrame
serversLabel.BackgroundTransparency = 1
serversLabel.Position = UDim2.new(0.05, 0, 0, 0)
serversLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
serversLabel.Font = Enum.Font.Gotham
serversLabel.Text = "Servidores visitados:"
serversLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
serversLabel.TextScaled = true
serversLabel.TextXAlignment = Enum.TextXAlignment.Left

local serversCount = Instance.new("TextLabel")
serversCount.Name = "ServersCount"
serversCount.Parent = hopStatsFrame
serversCount.BackgroundTransparency = 1
serversCount.Position = UDim2.new(0.7, 0, 0, 0)
serversCount.Size = UDim2.new(0.25, 0, 0.5, 0)
serversCount.Font = Enum.Font.GothamBold
serversCount.Text = "0"
serversCount.TextColor3 = Color3.fromRGB(255, 255, 255)
serversCount.TextScaled = true
serversCount.TextXAlignment = Enum.TextXAlignment.Right

local brainrotsLabel = Instance.new("TextLabel")
brainrotsLabel.Name = "BrainrotsLabel"
brainrotsLabel.Parent = hopStatsFrame
brainrotsLabel.BackgroundTransparency = 1
brainrotsLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
brainrotsLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
brainrotsLabel.Font = Enum.Font.Gotham
brainrotsLabel.Text = "Brainrots especiais:"
brainrotsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
brainrotsLabel.TextScaled = true
brainrotsLabel.TextXAlignment = Enum.TextXAlignment.Left

local brainrotsCount = Instance.new("TextLabel")
brainrotsCount.Name = "BrainrotsCount"
brainrotsCount.Parent = hopStatsFrame
brainrotsCount.BackgroundTransparency = 1
brainrotsCount.Position = UDim2.new(0.7, 0, 0.5, 0)
brainrotsCount.Size = UDim2.new(0.25, 0, 0.5, 0)
brainrotsCount.Font = Enum.Font.GothamBold
brainrotsCount.Text = "0"
brainrotsCount.TextColor3 = Color3.fromRGB(255, 255, 255)
brainrotsCount.TextScaled = true
brainrotsCount.TextXAlignment = Enum.TextXAlignment.Right

-- Função para criar botão do server hop
local function createHopButton(name, text, position, size, color, parent)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = parent
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.Position = position
    button.Size = size
    button.Font = Enum.Font.GothamBold
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.TextStrokeTransparency = 0
    button.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    return button
end

-- Criar botões do server hop
local secretButton = createHopButton("SecretButton", "Procurar SECRET", UDim2.new(0.05, 0, 0.5, 0), UDim2.new(0.425, 0, 0.08, 0), Color3.fromRGB(0, 0, 0), serverHopGui)
local godButton = createHopButton("GodButton", "Procurar GOD", UDim2.new(0.525, 0, 0.5, 0), UDim2.new(0.425, 0, 0.08, 0), Color3.fromRGB(138, 43, 226), serverHopGui)
local secretGodButton = createHopButton("SecretGodButton", "Procurar SECRET/GOD", UDim2.new(0.05, 0, 0.6, 0), UDim2.new(0.9, 0, 0.08, 0), Color3.fromRGB(50, 205, 50), serverHopGui)
local espGodButton = createHopButton("EspGodButton", "ESP GOD", UDim2.new(0.05, 0, 0.72, 0), UDim2.new(0.425, 0, 0.08, 0), Color3.fromRGB(138, 43, 226), serverHopGui)
local espSecretButton = createHopButton("EspSecretButton", "ESP SECRET", UDim2.new(0.525, 0, 0.72, 0), UDim2.new(0.425, 0, 0.08, 0), Color3.fromRGB(0, 0, 0), serverHopGui)

-- Sistema inicializado
local systemLabel = Instance.new("TextLabel")
systemLabel.Name = "SystemLabel"
systemLabel.Parent = serverHopGui
systemLabel.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
systemLabel.BorderSizePixel = 0
systemLabel.Position = UDim2.new(0.05, 0, 0.85, 0)
systemLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
systemLabel.Font = Enum.Font.Gotham
systemLabel.Text = "Sistema inicializado com sucesso"
systemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
systemLabel.TextScaled = true

local systemCorner = Instance.new("UICorner")
systemCorner.CornerRadius = UDim.new(0, 8)
systemCorner.Parent = systemLabel

-- Função para fazer server hop
local function serverHop(targetType)
    if isHopping then return end
    isHopping = true
    
    createNotification("SANTZ HOP", "Procurando servidor " .. targetType .. "...", 3)
    hopStatusLabel.Text = "Status: Procurando " .. targetType .. "..."
    
    local servers = getServers()
    if #servers == 0 then
        createNotification("SANTZ HOP", "Erro ao obter lista de servidores!", 5)
        hopStatusLabel.Text = "Status: Erro - Sem servidores"
        isHopping = false
        return
    end
    
    -- Filtrar servidores baseado no tipo
    local targetServers = {}
    
    for _, server in pairs(servers) do
        if server.id ~= game.JobId and server.playing < server.maxPlayers then
            local shouldAdd = false
            
            if targetType == "SECRET" then
                shouldAdd = hasSpecialWords(server.name, secretWords)
            elseif targetType == "GOD" then
                shouldAdd = hasSpecialWords(server.name, godWords)
            elseif targetType == "SECRET/GOD" then
                shouldAdd = hasSpecialWords(server.name, secretWords) or hasSpecialWords(server.name, godWords)
            elseif targetType == "ESP GOD" then
                shouldAdd = hasSpecialWords(server.name, godWords) and server.playing > 10
            elseif targetType == "ESP SECRET" then
                shouldAdd = hasSpecialWords(server.name, secretWords) and server.playing > 10
            end
            
            if shouldAdd then
                table.insert(targetServers, server)
            end
        end
    end
    
    -- Se não encontrou servidores especiais, pegar um aleatório
    if #targetServers == 0 then
        for _, server in pairs(servers) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                table.insert(targetServers, server)
            end
        end
    end
    
    if #targetServers > 0 then
        local randomServer = targetServers[math.random(1, #targetServers)]
        
        -- Verificar se é um servidor especial
        if hasSpecialWords(randomServer.name, secretWords) or hasSpecialWords(randomServer.name, godWords) then
            specialBrainrots = specialBrainrots + 1
        end
        
        serversVisited = serversVisited + 1
        
        createNotification("SANTZ HOP", "Entrando em servidor " .. targetType .. "!", 3)
        hopStatusLabel.Text = "Status: Teleportando..."
        
        -- Teleportar para o servidor
        pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer.id, player)
        end)
    else
        createNotification("SANTZ HOP", "Nenhum servidor " .. targetType .. " encontrado!", 5)
        hopStatusLabel.Text = "Status: Nenhum servidor encontrado"
    end
    
    wait(2)
    isHopping = false
    hopStatusLabel.Text = "Status: Pronto"
end

-- Função para criar slider (Superman)
local function createSlider(name, displayName, minVal, maxVal, defaultVal, yPos)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name .. "Frame"
    sliderFrame.Size = UDim2.new(1, 0, 0, 40)
    sliderFrame.Position = UDim2.new(0, 0, 0, yPos)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 0, 15)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = displayName
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamSemibold
    label.Parent = sliderFrame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "ValueLabel"
    valueLabel.Size = UDim2.new(0, 40, 0, 15)
    valueLabel.Position = UDim2.new(1, -40, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
    valueLabel.TextSize = 10
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Parent = sliderFrame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Name = "SliderBg"
    sliderBg.Size = UDim2.new(1, 0, 0, 4)
    sliderBg.Position = UDim2.new(0, 0, 0, 20)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 43, 48)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = sliderFrame
    
    local sliderBgCorner = Instance.new("UICorner")
    sliderBgCorner.CornerRadius = UDim.new(0, 2)
    sliderBgCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 2)
    sliderFillCorner.Parent = sliderFill
    
    local sliderHandle = Instance.new("Frame")
    sliderHandle.Name = "SliderHandle"
    sliderHandle.Size = UDim2.new(0, 12, 0, 12)
    sliderHandle.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -6, 0, -4)
    sliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderHandle.BorderSizePixel = 0
    sliderHandle.Parent = sliderBg
    
    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(0, 6)
    handleCorner.Parent = sliderHandle
    
    local currentValue = defaultVal
    local dragging = false
    
    local function updateSlider(value)
        currentValue = math.clamp(value, minVal, maxVal)
        local percentage = (currentValue - minVal) / (maxVal - minVal)
        
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderHandle.Position = UDim2.new(percentage, -6, 0, -4)
        valueLabel.Text = tostring(currentValue)
        
        if name == "Speed" then
            currentSpeed = currentValue
        elseif name == "Jump" then
            currentJump = currentValue
        end
        
        -- Salvar automaticamente quando alterar
        saveSettings()
    end
    
    sliderHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local sliderPos = sliderBg.AbsolutePosition.X
            local sliderSize = sliderBg.AbsoluteSize.X
            local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
            local value = math.floor(minVal + percentage * (maxVal - minVal))
            updateSlider(value)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return updateSlider
end

-- Criar sliders compactos
local updateSpeed = createSlider("Speed", "🏃 Velocidade", 1, 200, currentSpeed, 35)
local updateJump = createSlider("Jump", "🦘 Pulo", 1, 300, currentJump, 85)

-- Botão toggle Superman
local toggleSupermanBtn = Instance.new("TextButton")
toggleSupermanBtn.Name = "ToggleButton"
toggleSupermanBtn.Size = UDim2.new(1, 0, 0, 30)
toggleSupermanBtn.Position = UDim2.new(0, 0, 0, 135)
toggleSupermanBtn.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
toggleSupermanBtn.BorderSizePixel = 0
toggleSupermanBtn.Text = "🚀 ATIVAR"
toggleSupermanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleSupermanBtn.TextSize = 12
toggleSupermanBtn.Font = Enum.Font.GothamBold
toggleSupermanBtn.Parent = container

local toggleBtnCorner = Instance.new("UICorner")
toggleBtnCorner.CornerRadius = UDim.new(0, 8)
toggleBtnCorner.Parent = toggleSupermanBtn

-- Botões salvar/reset compactos
local saveBtn = Instance.new("TextButton")
saveBtn.Name = "SaveButton"
saveBtn.Size = UDim2.new(0.48, 0, 0, 25)
saveBtn.Position = UDim2.new(0, 0, 0, 175)
saveBtn.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
saveBtn.BorderSizePixel = 0
saveBtn.Text = "💾"
saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveBtn.TextSize = 10
saveBtn.Font = Enum.Font.GothamBold
saveBtn.Parent = container

local saveBtnCorner = Instance.new("UICorner")
saveBtnCorner.CornerRadius = UDim.new(0, 8)
saveBtnCorner.Parent = saveBtn

local resetBtn = Instance.new("TextButton")
resetBtn.Name = "ResetButton"
resetBtn.Size = UDim2.new(0.48, 0, 0, 25)
resetBtn.Position = UDim2.new(0.52, 0, 0, 175)
resetBtn.BackgroundColor3 = Color3.fromRGB(255, 73, 97)
resetBtn.BorderSizePixel = 0
resetBtn.Text = "🔄"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.TextSize = 10
resetBtn.Font = Enum.Font.GothamBold
resetBtn.Parent = container

local resetBtnCorner = Instance.new("UICorner")
resetBtnCorner.CornerRadius = UDim.new(0, 8)
resetBtnCorner.Parent = resetBtn

-- Variáveis Superman
local isSupermanActive = false
local supermanConnection = nil

-- Funcionalidades dos botões

-- Santz Hall Out (Teleporte 10 passos para frente + 2 segundos na base)
local function santzHallOut()
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            -- Teleporta 10 studs (passos) para frente
            local lookDirection = humanoidRootPart.CFrame.LookVector
            local newPosition = humanoidRootPart.CFrame + (lookDirection * 10)
            humanoidRootPart.CFrame = newPosition
            
            -- Ativa noclip por 2 segundos para ficar dentro da base
            local noclipConnection
            noclipConnection = RunService.Heartbeat:Connect(function()
                if character and character.Parent then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            
            -- Desativa noclip após 2 segundos
            wait(2)
            if noclipConnection then
                noclipConnection:Disconnect()
            end
            
            -- Reativa colisão
            if character and character.Parent then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end

-- Abrir GUI Superman
local function openSupermanGui()
    supermanGuiOpen = not supermanGuiOpen
    supermanGui.Visible = supermanGuiOpen
    
    if supermanGuiOpen then
        -- Animação de entrada
        supermanGui.Size = UDim2.new(0, 0, 0, 0)
        supermanGui.Visible = true
        local openTween = TweenService:Create(supermanGui, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 300, 0, 250)})
        openTween:Play()
    end
end

-- Abrir GUI Server Hop
local function openServerHopGui()
    serverHopGuiOpen = not serverHopGuiOpen
    serverHopGui.Visible = serverHopGuiOpen
    
    if serverHopGuiOpen then
        -- Animação de entrada
        serverHopGui.Size = UDim2.new(0, 0, 0, 0)
        serverHopGui.Visible = true
        local openTween = TweenService:Create(serverHopGui, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 400, 0, 400)})
        openTween:Play()
    end
end

-- Aplicar boost Superman
local function applySupermanBoost()
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        local humanoid = player.Character.Humanoid
        humanoid.WalkSpeed = currentSpeed
        humanoid.JumpPower = currentJump
        -- Para versões mais novas do Roblox
        pcall(function()
            humanoid.JumpHeight = currentJump / 4
        end)
    end
end

-- Toggle Superman boost
local function toggleSupermanBoost()
    isSupermanActive = not isSupermanActive
    
    if isSupermanActive then
        toggleSupermanBtn.Text = "🛑 PARAR"
        toggleSupermanBtn.BackgroundColor3 = Color3.fromRGB(255, 73, 97)
        statusLabel.Text = "🟢 ATIVO - S:" .. currentSpeed .. " J:" .. currentJump
        statusLabel.TextColor3 = Color3.fromRGB(67, 181, 129)
        
        -- Força as mudanças continuamente
        supermanConnection = RunService.Heartbeat:Connect(function()
            applySupermanBoost()
        end)
    else
        toggleSupermanBtn.Text = "🚀 ATIVAR"
        toggleSupermanBtn.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
        statusLabel.Text = "🔴 BOOST INATIVO"
        statusLabel.TextColor3 = Color3.fromRGB(185, 187, 190)
        
        if supermanConnection then
            supermanConnection:Disconnect()
            supermanConnection = nil
        end
        
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = player.Character.Humanoid
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
            pcall(function()
                humanoid.JumpHeight = 7.2
            end)
        end
    end
end

-- Rejoin
local function rejoin()
    TeleportService:Teleport(game.PlaceId, player)
end

-- Função para resetar configurações
local function resetSettings()
    currentSpeed = 50
    currentJump = 100
    updateSpeed(currentSpeed)
    updateJump(currentJump)
    saveSettings()
    print("🔄 Configurações resetadas para padrão!")
end

-- Atualizar contadores na GUI do Server Hop
local function updateStats()
    serversCount.Text = tostring(serversVisited)
    brainrotsCount.Text = tostring(specialBrainrots)
end

-- Conectar eventos dos botões principais
hallOutBtn.MouseButton1Click:Connect(santzHallOut)
supermanBtn.MouseButton1Click:Connect(openSupermanGui)
serverHopBtn.MouseButton1Click:Connect(openServerHopGui)
rejoinBtn.MouseButton1Click:Connect(rejoin)

-- Conectar eventos dos botões Superman
toggleSupermanBtn.MouseButton1Click:Connect(toggleSupermanBoost)
closeSupermanBtn.MouseButton1Click:Connect(function()
    supermanGui.Visible = false
    supermanGuiOpen = false
end)

-- Conectar botões de salvamento
saveBtn.MouseButton1Click:Connect(function()
    saveSettings()
    print("💾 Configurações salvas com sucesso!")
end)

resetBtn.MouseButton1Click:Connect(resetSettings)

-- Conectar eventos dos botões Server Hop
secretButton.MouseButton1Click:Connect(function()
    serverHop("SECRET")
end)

godButton.MouseButton1Click:Connect(function()
    serverHop("GOD")
end)

secretGodButton.MouseButton1Click:Connect(function()
    serverHop("SECRET/GOD")
end)

espGodButton.MouseButton1Click:Connect(function()
    serverHop("ESP GOD")
end)

espSecretButton.MouseButton1Click:Connect(function()
    serverHop("ESP SECRET")
end)

closeServerHopBtn.MouseButton1Click:Connect(function()
    serverHopGui.Visible = false
    serverHopGuiOpen = false
end)

-- Efeitos visuais dos botões principais
local function addButtonEffects(button)
    local originalColor = Color3.fromRGB(0, 162, 255)
    local hoverColor = Color3.fromRGB(100, 200, 255)
    local clickColor = Color3.fromRGB(0, 100, 200)
    
    button.MouseEnter:Connect(function()
        button.TextColor3 = hoverColor
    end)
    
    button.MouseLeave:Connect(function()
        button.TextColor3 = originalColor
    end)
    
    button.MouseButton1Down:Connect(function()
        button.TextColor3 = clickColor
    end)
    
    button.MouseButton1Up:Connect(function()
        button.TextColor3 = hoverColor
    end)
end

addButtonEffects(hallOutBtn)
addButtonEffects(supermanBtn)
addButtonEffects(serverHopBtn)
addButtonEffects(rejoinBtn)

-- Efeito de brilho nos botões do server hop
local function addHoverEffect(button)
    button.MouseEnter:Connect(function()
        button.BackgroundTransparency = 0.2
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundTransparency = 0
    end)
end

-- Adicionar efeitos a todos os botões do server hop
addHoverEffect(secretButton)
addHoverEffect(godButton)
addHoverEffect(secretGodButton)
addHoverEffect(espGodButton)
addHoverEffect(espSecretButton)

-- Loop para atualizar estatísticas do server hop
spawn(function()
    while wait(1) do
        updateStats()
    end
end)

-- Reset automático do personagem
player.CharacterAdded:Connect(function(character)
    wait(1)
    if isSupermanActive then
        applySupermanBoost()
    end
end)

-- Toggle GUI principal (Tecla Insert)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- Notificação de inicialização
createNotification("SANTZ HUB RGB", "Sistema inicializado com sucesso!", 5)

print("SANTZ HUB RGB carregado! Pressione INSERT para abrir/fechar.")
print("✅ Funcionalidades:")
print("- Santz Hall Out (teleporte + noclip)")
print("- Superman (velocidade e pulo customizáveis)")
print("- Server Hop (procurar servidores especiais)")
print("- Rejoin (reconectar)")
print("✅ Configurações carregadas: Speed " .. currentSpeed .. " | Jump " .. currentJump)
