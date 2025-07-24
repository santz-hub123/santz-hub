-- SANTZ HUB Script - Versão Corrigida
-- Roblox Local Script

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Criar ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SantzHubGui"
screenGui.Parent = CoreGui

-- Frame principal (tamanho pequeno igual ao original)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 140)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -70)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
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

-- Funcionalidades dos botões

-- Santz Hall Out (Teleporte 10 passos para frente)
local function santzHallOut()
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            -- Teleporta 10 studs (passos) para frente
            local lookDirection = humanoidRootPart.CFrame.LookVector
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + (lookDirection * 10)
        end
    end
end

-- Superman (Velocidade e Pulo) - Corrigido
local supermanActive = false
local function toggleSuperman()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            supermanActive = not supermanActive
            
            if supermanActive then
                humanoid.WalkSpeed = 100
                humanoid.JumpPower = 150
                -- Para Roblox mais novo, usar JumpHeight
                if humanoid:FindFirstChild("JumpHeight") then
                    humanoid.JumpHeight = 50
                end
            else
                humanoid.WalkSpeed = 16 -- Velocidade normal
                humanoid.JumpPower = 50 -- Pulo normal
                if humanoid:FindFirstChild("JumpHeight") then
                    humanoid.JumpHeight = 7.2
                end
            end
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
supermanBtn.MouseButton1Click:Connect(toggleSuperman)
rejoinBtn.MouseButton1Click:Connect(rejoin)

-- Efeitos visuais dos botões
local function addButtonEffects(button)
    local originalColor = Color3.fromRGB(0, 162, 255)
    local hoverColor = Color3.fromRGB(100, 200, 255)
    local clickColor = Color3.fromRGB(0, 100, 200)
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        button.TextColor3 = hoverColor
    end)
    
    button.MouseLeave:Connect(function()
        button.TextColor3 = originalColor
    end)
    
    -- Click effect (fica azul quando clicado)
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

-- Reset automático do personagem para corrigir bugs
player.CharacterAdded:Connect(function(character)
    wait(1)
    supermanActive = false
end)

-- Toggle GUI (Tecla Insert)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("SANTZ HUB carregado! Pressione INSERT para abrir/fechar.")
print("Santz Hall Out: Teleporte 10 passos para frente")
print("Superman: Toggle velocidade/pulo (clique novamente para desativar)")
print("Rejoin: Reconectar ao servidor")
