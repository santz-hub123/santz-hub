-- SANTZ HUB Script - Com Tabela Superman
-- Roblox Local Script

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Variáveis Superman
local supermanGuiOpen = false

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
    -- Simula salvamento local (em memória durante a sessão)
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

-- Criar ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SantzHubGui"
screenGui.Parent = CoreGui

-- Frame principal (mais transparente)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 140)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -70)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.3 -- Mais transparente
mainFrame.BorderColor3 = Color3.fromRGB(0, 162, 255)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Arredondar interface
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Título SANTZ HUB
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 25)
titleLabel.Position = UDim2.new(0, 0, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SANTZ HUB"
titleLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.Arcade
titleLabel.TextStrokeTransparency = 0
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Parent = mainFrame

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

-- Botão Rejoin
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Name = "RejoinBtn"
rejoinBtn.Size = UDim2.new(0.9, 0, 0, 20)
rejoinBtn.Position = UDim2.new(0.05, 0, 0, 115)
rejoinBtn.BackgroundTransparency = 1
rejoinBtn.Text = "Rejoin"
rejoinBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
rejoinBtn.TextSize = 12
rejoinBtn.Font = Enum.Font.Arcade
rejoinBtn.TextStrokeTransparency = 0
rejoinBtn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
rejoinBtn.Parent = mainFrame

-- GUI DO SUPERMAN (tamanho normal, conteúdo compacto)
local supermanGui = Instance.new("Frame")
supermanGui.Name = "SupermanGUI"
supermanGui.Size = UDim2.new(0, 300, 0, 250) -- Mais compacto
supermanGui.Position = UDim2.new(0.5, -150, 0.5, -125)
supermanGui.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
supermanGui.BorderSizePixel = 0
supermanGui.Visible = false
supermanGui.Active = true
supermanGui.Draggable = true
supermanGui.Parent = screenGui5, -250)
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

-- Header Superman (compacto)
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40) -- Menor
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
header.BorderSizePixel = 0
header.Parent = supermanGui

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Título Superman (compacto)
local supermanTitle = Instance.new("TextLabel")
supermanTitle.Name = "Title"
supermanTitle.Size = UDim2.new(1, -80, 1, 0)
supermanTitle.Position = UDim2.new(0, 10, 0, 0)
supermanTitle.BackgroundTransparency = 1
supermanTitle.Text = "⚡ SUPERMAN"
supermanTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
supermanTitle.TextSize = 16 -- Menor
supermanTitle.TextXAlignment = Enum.TextXAlignment.Left
supermanTitle.Font = Enum.Font.GothamBold
supermanTitle.Parent = header

-- Botão fechar Superman (compacto)
local closeSupermanBtn = Instance.new("TextButton")
closeSupermanBtn.Name = "CloseButton"
closeSupermanBtn.Size = UDim2.new(0, 30, 0, 30) -- Menor
closeSupermanBtn.Position = UDim2.new(1, -35, 0, 5)
closeSupermanBtn.BackgroundColor3 = Color3.fromRGB(255, 73, 97)
closeSupermanBtn.BorderSizePixel = 0
closeSupermanBtn.Text = "×"
closeSupermanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeSupermanBtn.TextSize = 16 -- Menor
closeSupermanBtn.Font = Enum.Font.GothamBold
closeSupermanBtn.Parent = header

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 8)
closeBtnCorner.Parent = closeSupermanBtn

-- Container Superman (compacto)
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(1, -20, 1, -50) -- Menor
container.Position = UDim2.new(0, 10, 0, 45)
container.BackgroundTransparency = 1
container.Parent = supermanGui

-- Status do boost (compacto)
local statusFrame = Instance.new("Frame")
statusFrame.Name = "StatusFrame"
statusFrame.Size = UDim2.new(1, 0, 0, 25) -- Menor
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
statusLabel.TextSize = 11 -- Menor
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = statusFrame

-- Função para criar slider (versão compacta)
local function createSlider(name, displayName, minVal, maxVal, defaultVal, yPos)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name .. "Frame"
    sliderFrame.Size = UDim2.new(1, 0, 0, 40) -- 3x menor
    sliderFrame.Position = UDim2.new(0, 0, 0, yPos)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 0, 15) -- Menor
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = displayName
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 10 -- Menor
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamSemibold
    label.Parent = sliderFrame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "ValueLabel"
    valueLabel.Size = UDim2.new(0, 40, 0, 15) -- Menor
    valueLabel.Position = UDim2.new(1, -40, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
    valueLabel.TextSize = 10 -- Menor
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Parent = sliderFrame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Name = "SliderBg"
    sliderBg.Size = UDim2.new(1, 0, 0, 4) -- Menor
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
    sliderHandle.Size = UDim2.new(0, 12, 0, 12) -- Menor
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
        sliderHandle.Position = UDim2.new(percentage, -6, 0, -4) -- Ajustado para handle menor
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

-- Botão toggle Superman (compacto)
local toggleSupermanBtn = Instance.new("TextButton")
toggleSupermanBtn.Name = "ToggleButton"
toggleSupermanBtn.Size = UDim2.new(1, 0, 0, 30) -- Menor
toggleSupermanBtn.Position = UDim2.new(0, 0, 0, 135)
toggleSupermanBtn.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
toggleSupermanBtn.BorderSizePixel = 0
toggleSupermanBtn.Text = "🚀 ATIVAR"
toggleSupermanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleSupermanBtn.TextSize = 12 -- Menor
toggleSupermanBtn.Font = Enum.Font.GothamBold
toggleSupermanBtn.Parent = container

-- Botões salvar/reset compactos
local saveBtn = Instance.new("TextButton")
saveBtn.Name = "SaveButton"
saveBtn.Size = UDim2.new(0.48, 0, 0, 25) -- Menor
saveBtn.Position = UDim2.new(0, 0, 0, 175)
saveBtn.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
saveBtn.BorderSizePixel = 0
saveBtn.Text = "💾"
saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveBtn.TextSize = 10
saveBtn.Font = Enum.Font.GothamBold
saveBtn.Parent = container

local resetBtn = Instance.new("TextButton")
resetBtn.Name = "ResetButton"
resetBtn.Size = UDim2.new(0.48, 0, 0, 25) -- Menor
resetBtn.Position = UDim2.new(0.52, 0, 0, 175)
resetBtn.BackgroundColor3 = Color3.fromRGB(255, 73, 97)
resetBtn.BorderSizePixel = 0
resetBtn.Text = "🔄"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.TextSize = 10
resetBtn.Font = Enum.Font.GothamBold
resetBtn.Parent = container

-- Variáveis Superman
local isSupermanActive = false
local supermanConnection = nil

-- Função para mostrar feedback de salvamento (removida - sem espaço)
local function showSaveFeedback(message, color)
    -- Feedback visual simplificado no console
    print(message)
end

-- Função para resetar configurações
local function resetSettings()
    currentSpeed = 50
    currentJump = 100
    updateSpeed(currentSpeed)
    updateJump(currentJump)
    saveSettings()
    showSaveFeedback("🔄 Resetado!")
end

-- Função para resetar configurações
local function resetSettings()
    currentSpeed = 50
    currentJump = 100
    updateSpeed(currentSpeed)
    updateJump(currentJump)
    saveSettings()
    spawn(function()
        showSaveFeedback("🔄 Configurações resetadas para padrão!", Color3.fromRGB(255, 73, 97))
    end)
end

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
    local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, player)
end

-- Conectar botões
hallOutBtn.MouseButton1Click:Connect(santzHallOut)
supermanBtn.MouseButton1Click:Connect(openSupermanGui)
rejoinBtn.MouseButton1Click:Connect(rejoin)
toggleSupermanBtn.MouseButton1Click:Connect(toggleSupermanBoost)
closeSupermanBtn.MouseButton1Click:Connect(function()
    supermanGui.Visible = false
    supermanGuiOpen = false
end)

-- Conectar botões de salvamento
saveBtn.MouseButton1Click:Connect(function()
    saveSettings()
    spawn(function()
        showSaveFeedback("💾 Configurações salvas com sucesso!", Color3.fromRGB(67, 181, 129))
    end)
end)

resetBtn.MouseButton1Click:Connect(resetSettings)

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
addButtonEffects(rejoinBtn)

-- Reset automático do personagem
player.CharacterAdded:Connect(function(character)
    wait(1)
    isSupermanActive = false
    if supermanConnection then
        supermanConnection:Disconnect()
        supermanConnection = nil
    end
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

print("SANTZ HUB carregado! Pressione INSERT para abrir/fechar.")
print("Clique em Superman para abrir a tabela de configurações!")
print("✅ Configurações carregadas: Speed " .. currentSpeed .. " | Jump " .. currentJump)
