-- SANTZ HUB - COM LOGO INTEGRADA

-- SERVIÇOS
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- FUNÇÕES AUXILIARES RGB
local function startRGBText(obj)
    coroutine.wrap(function()
        while obj and obj.Parent do
            for hue = 0, 1, 0.01 do
                if obj and obj.Parent then
                    obj.TextColor3 = Color3.fromHSV(hue, 1, 1)
                end
                task.wait(0.05)
            end
        end
    end)()
end

local function startRGBStroke(obj)
    coroutine.wrap(function()
        while obj and obj.Parent do
            for hue = 0, 1, 0.01 do
                if obj and obj.Parent then
                    obj.Color = Color3.fromHSV(hue, 1, 1)
                end
                task.wait(0.05)
            end
        end
    end)()
end

-- GUI PRINCIPAL
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "SANTZHUB_GUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 240)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -120)
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

-- LOGO GUI (BOTÃO PARA ABRIR O HUB)
local LogoButton = Instance.new("ImageButton", ScreenGui)
LogoButton.Size = UDim2.new(0, 80, 0, 80)
LogoButton.Position = UDim2.new(0, 20, 0, 20)
LogoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LogoButton.BorderSizePixel = 0
LogoButton.Image = "rbxassetid://79925562792133" -- Sua logo do SANTZ HUB
LogoButton.ScaleType = Enum.ScaleType.Fit

local LogoCorner = Instance.new("UICorner", LogoButton)
LogoCorner.CornerRadius = UDim.new(0, 15)

local LogoStroke = Instance.new("UIStroke", LogoButton)
LogoStroke.Thickness = 3
LogoStroke.Transparency = 0.3
LogoStroke.Color = Color3.new(1, 1, 1)
startRGBStroke(LogoStroke)

-- EFEITOS DA LOGO
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

-- FUNÇÃO PARA ABRIR/FECHAR O HUB
LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    
    -- Efeito de clique
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

-- MENSAGEM DE STATUS
local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1, -20, 0, 20)
Status.Position = UDim2.new(0, 10, 1, -30)
Status.Font = Enum.Font.Arcade
Status.TextSize = 18
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.new(1,1,1)
startRGBText(Status)

-- BOTÕES
local SaveCoord = Instance.new("TextButton", MainFrame)
SaveCoord.Size = UDim2.new(1, -40, 0, 30)
SaveCoord.Position = UDim2.new(0, 20, 0, 60)
SaveCoord.Text = "Salvar Coordenada"
SaveCoord.Font = Enum.Font.Arcade
SaveCoord.TextSize = 18
SaveCoord.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SaveCoord.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SaveCoord).CornerRadius = UDim.new(0, 6)
startRGBText(SaveCoord)

local TeleGuiado = Instance.new("TextButton", MainFrame)
TeleGuiado.Size = UDim2.new(1, -40, 0, 30)
TeleGuiado.Position = UDim2.new(0, 20, 0, 100)
TeleGuiado.Text = "Teleguiado"
TeleGuiado.Font = Enum.Font.Arcade
TeleGuiado.TextSize = 18
TeleGuiado.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TeleGuiado.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TeleGuiado).CornerRadius = UDim.new(0, 6)
startRGBText(TeleGuiado)

-- FUNÇÕES TELEGUIADO
local savedPos = nil
local isMoving = false

SaveCoord.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        savedPos = hrp.Position
        Status.Text = "✅ Coordenada Salva"
    else
        Status.Text = "❌ Erro ao salvar coordenada"
    end
end)

-- FUNÇÃO MELHORADA DE TELEGUIADO (VELOCIDADE 40)
local function safeTeleport(targetPos)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local hrp = char.HumanoidRootPart
    local humanoid = char:FindFirstChild("Humanoid")
    
    if not humanoid then
        return false
    end
    
    isMoving = true
    
    -- Configurações de velocidade
    local SPEED = 40 -- Velocidade fixa em studs por segundo
    
    -- Posições
    local startPos = hrp.Position
    local safeTargetPos = Vector3.new(targetPos.X, targetPos.Y + 5, targetPos.Z)
    
    -- Calcula direção e distância
    local direction = (safeTargetPos - startPos).Unit
    local totalDistance = (safeTargetPos - startPos).Magnitude
    
    -- Cria BodyVelocity para velocidade constante (sem mexer no CanCollide)
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Velocity = direction * SPEED
    bodyVelocity.Parent = hrp
    
    -- Loop de movimento com velocidade constante
    local startTime = tick()
    local timeout = totalDistance / SPEED + 8 -- Mais tempo de segurança
    
    while isMoving and (tick() - startTime) < timeout do
        local currentDistance = (hrp.Position - safeTargetPos).Magnitude
        
        -- Para quando chegar próximo do destino
        if currentDistance < 4 then
            break
        end
        
        -- Mantém a velocidade constante na direção do alvo
        local currentDirection = (safeTargetPos - hrp.Position).Unit
        bodyVelocity.Velocity = currentDirection * SPEED
        
        task.wait(0.1)
    end
    
    -- Remove bodyVelocity
    bodyVelocity:Destroy()
    
    -- Para o movimento residual
    if hrp.AssemblyLinearVelocity then
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
    
    task.wait(0.3)
    
    -- Teleporte final para posição exata (com altura segura)
    hrp.CFrame = CFrame.new(targetPos.X, targetPos.Y + 3, targetPos.Z)
    
    isMoving = false
    return true
end

TeleGuiado.MouseButton1Click:Connect(function()
    if isMoving then
        Status.Text = "⚠ Já está em movimento"
        return
    end
    
    if not savedPos then
        Status.Text = "❌ Nenhuma coordenada salva"
        return
    end

    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        Status.Text = "❌ Personagem não encontrado"
        return
    end

    Status.Text = "🚀 Iniciando Teleguiado..."

    coroutine.wrap(function()
        local success = safeTeleport(savedPos)
        if success then
            task.wait(1)
            Status.Text = "✅ Chegou no destino"
        else
            Status.Text = "❌ Falha no teleguiado"
        end
    end)()
end)

-- MINIMIZAR
MinButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- CLEANUP AO RESETAR PERSONAGEM
player.CharacterRemoving:Connect(function()
    isMoving = false
end)

-- INICIALIZAÇÃO
MainFrame.Visible = false -- Começa fechado, abre pela logo
