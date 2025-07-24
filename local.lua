-- SANTZ HUB Script - Cópia Exata
-- Roblox Local Script

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

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
mainFrame.BorderColor3 = Color3.fromRGB(0, 162, 255) -- Azul em vez de verde
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Título SANTZ HUB
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 25)
titleLabel.Position = UDim2.new(0, 0, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SANTZ HUB"
titleLabel.TextColor3 = Color3.fromRGB(0, 162, 255) -- Azul em vez de verde
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.Arcade -- Fonte pixelizada igual ao original
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
tiktokLabel.TextColor3 = Color3.fromRGB(0, 162, 255) -- Azul em vez de verde
tiktokLabel.TextSize = 10
tiktokLabel.Font = Enum.Font.Arcade
titleLabel.TextStrokeTransparency = 0
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
tiktokLabel.Parent = mainFrame

-- Botão Santz Hall Out (estilo simples igual ao original)
local hallOutBtn = Instance.new("TextButton")
hallOutBtn.Name = "HallOutBtn"
hallOutBtn.Size = UDim2.new(0.9, 0, 0, 20)
hallOutBtn.Position = UDim2.new(0.05, 0, 0, 55)
hallOutBtn.BackgroundTransparency = 1
hallOutBtn.Text = "Santz Hall Out"
hallOutBtn.TextColor3 = Color3.fromRGB(0, 162, 255) -- Azul em vez de verde
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
supermanBtn.TextColor3 = Color3.fromRGB(0, 162, 255) -- Azul em vez de verde
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
rejoinBtn.TextColor3 = Color3.fromRGB(0, 162, 255) -- Azul em vez de verde
rejoinBtn.TextSize = 12
rejoinBtn.Font = Enum.Font.Arcade
rejoinBtn.TextStrokeTransparency = 0
rejoinBtn.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
rejoinBtn.Parent = mainFrame

-- Funcionalidades dos botões

-- Santz Hall Out (Noclip)
local noclipEnabled = false
local function toggleNoclip()
    local character = player.Character
    if character then
        noclipEnabled = not noclipEnabled
        
        local function noclip()
            if character and character.Parent and noclipEnabled then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end
        
        if noclipEnabled then
            game:GetService("RunService").Stepped:Connect(noclip)
        end
    end
end

-- Superman (Velocidade e Pulo)
local function superman()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 100
            humanoid.JumpPower = 150
        end
    end
end

-- Rejoin
local function rejoin()
    local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, player)
end

-- Conectar botões
hallOutBtn.MouseButton1Click:Connect(toggleNoclip)
supermanBtn.MouseButton1Click:Connect(superman)
rejoinBtn.MouseButton1Click:Connect(rejoin)

-- Efeito hover simples
local function addHoverEffect(button)
    button.MouseEnter:Connect(function()
        button.TextColor3 = Color3.fromRGB(100, 200, 255)
    end)
    
    button.MouseLeave:Connect(function()
        button.TextColor3 = Color3.fromRGB(0, 162, 255)
    end)
end

addHoverEffect(hallOutBtn)
addHoverEffect(supermanBtn)
addHoverEffect(rejoinBtn)

-- Toggle GUI (Tecla Insert)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("SANTZ HUB carregado! Pressione INSERT para abrir/fechar.")
