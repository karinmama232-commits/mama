-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local StartStopBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- Properties
ScreenGui.Name = "TeleportLoopGui"
ScreenGui.Parent = game.CoreGui -- Menggunakan CoreGui agar tetap muncul

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -50)
MainFrame.Size = UDim2.new(0, 150, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = true

StartStopBtn.Name = "StartStopBtn"
StartStopBtn.Parent = MainFrame
StartStopBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
StartStopBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
StartStopBtn.Size = UDim2.new(0, 120, 0, 25)
StartStopBtn.Text = "START"
StartStopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
CloseBtn.Position = UDim2.new(0.8, 0, -0.1, 0)
CloseBtn.Size = UDim2.new(0, 30, 0, 20)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, 0, 0.3, 0)
StatusLabel.Text = "Status: IDLE"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundTransparency = 1

-- Konfigurasi Lokasi
local locations = {
    ["a"] = CFrame.new(1501.09766, 129.999969, 2805.5188, -0.0122844223, -3.60258525e-08, -0.999924541, -1.08405223e-08, 1, -3.58953933e-08, 0.999924541, 1.03987494e-08, -0.0122844223),
    ["b"] = CFrame.new(-61.7280006, 3.53157043, 2770.76807, 0.060647741, -1.02883682e-07, 0.99815923, 3.59632359e-08, 1, 1.00888307e-07, -0.99815923, 2.97783878e-08, 0.060647741),
    ["c"] = CFrame.new(-856.400757, 18.7447453, 468.195251, 0.620325506, 1.80706508e-08, 0.784344494, -6.71981653e-08, 1, 3.01067757e-08, -0.784344494, -7.13825088e-08, 0.620325506),
    ["d"] = CFrame.new(-552.304993, 20.7285309, 183.195007, 0.936509848, 2.21022596e-08, 0.350641221, -5.13101313e-08, 1, 7.40077937e-08, -0.350641221, -8.7300478e-08, 0.936509848),
    ["e"] = CFrame.new(-2921.85791, 3.24999928, 2083.29712, 0.204768002, 1.5838399e-08, 0.978810549, -6.4375719e-08, 1, -2.71381451e-09, -0.978810549, -6.2455932e-08, 0.204768002),
    ["f"] = CFrame.new(3206.97192, -1302.8551, 1417.30005, -0.893320143, 1.9596488e-08, -0.449420899, 5.22924317e-08, 1, -6.03385288e-08, 0.449420899, -7.74029374e-08, -0.893320143),
    ["g"] = CFrame.new(-2168.35742, 53.4869347, 3620.9187, -0.83247894, -6.65910846e-08, -0.554056644, -6.81248657e-09, 1, -1.09952353e-07, 0.554056644, -8.77585151e-08, -0.83247894),
    ["h"] = CFrame.new(1074.37598, 4.02703381, 5098.47705, 0.226213664, 2.63391229e-08, 0.974077702, 2.78977286e-08, 1, -3.35188552e-08, -0.974077702, 3.47569795e-08, 0.226213664),
    ["i"] = CFrame.new(-3656.65405, -134.358368, -963.250977, -0.228406534, -5.55096769e-09, 0.973565876, -8.40281622e-09, 1, 3.73031739e-09, -0.973565876, -7.32866656e-09, -0.228406534),
    ["j"] = CFrame.new(-3597.32397, -275.674347, -1641.224, -0.549922049, 5.50292434e-08, 0.835215986, 9.08502855e-08, 1, -6.06869577e-09, -0.835215986, 7.25422993e-08, -0.549922049),
    ["k"] = CFrame.new(423.339996, 3.67347598, 2184.18896, -0.205867454, -3.34877974e-08, -0.978579879, 3.63091637e-08, 1, -4.18593054e-08, 0.978579879, -4.41488872e-08, -0.205867454),
    ["l"] = CFrame.new(892.046265, 73.1364899, -10177.2588, -0.292134255, -6.27472616e-08, -0.956377327, -2.74013328e-08, 1, -5.72393297e-08, 0.956377327, 9.48444434e-09, -0.292134255),
    ["m"] = CFrame.new(1467.427, 8.56750679, -327.696991, -0.300987154, 5.35984732e-08, -0.953628182, 2.38960016e-08, 1, 4.86626597e-08, 0.953628182, -8.1410656e-09, -0.300987154),
    ["n"] = CFrame.new(2161.39111, -91.1981583, -729.22699, -0.374913067, 1.00757674e-07, 0.927059948, 2.34257751e-08, 1, -9.92115332e-08, -0.927059948, -1.54786033e-08, -0.374913067),
    ["o"] = CFrame.new(1453.83899, -22.1250057, -621.651978, -0.984368861, 7.44942241e-08, -0.176119015, 7.53460654e-08, 1, 1.85046278e-09, 0.176119015, -1.14483374e-08, -0.984368861),
    ["p"] = CFrame.new(-3140.83301, -643.476807, -10415.8057, 0.0199023858, 1.06046208e-07, -0.999801934, 1.41913112e-08, 1, 1.06349709e-07, 0.999801934, -1.63051137e-08, 0.0199023858),
    ["q"] = CFrame.new(-1448.10901, -1041.58875, -10447.0791, -0.0303385258, -2.90017255e-08, 0.999539673, 3.58098684e-09, 1, 2.91237736e-08, -0.999539673, 4.46291093e-09, -0.0303385258),
    ["r"] = CFrame.new(6045.40186, -588.600952, 4608.93799, -0.995750964, 4.33610943e-08, -0.09208709, 4.37900063e-08, 1, -2.63713762e-09, 0.09208709, -6.65842625e-09, -0.995750964),
    ["s"] = CFrame.new(3406.97192, 4.19297075, 3497.08594, 0.710760236, 6.22878531e-08, -0.703434408, -3.75436002e-08, 1, 5.06136182e-08, 0.703434408, -9.56468682e-09, 0.710760236),
    ["t"] = CFrame.new(3349.35107, -297.941223, 3086.00293, 0.736163676, 2.82281776e-09, 0.676803589, -2.37187781e-09, 1, -1.59090119e-09, -0.676803589, -4.34131786e-10, 0.736163676),
    ["u"] = CFrame.new(5729.33398, -904.818481, 15408.0781, 0.968347371, 7.08654682e-08, 0.249606386, -7.13540231e-08, 1, -7.09111925e-09, -0.249606386, -1.09437526e-08, 0.968347371)
}

local locationOrder = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u"}

-- State
local running = false
local waitTime = 333 -- 5 menit dalam detik

local function teleportLoop()
    while running do
        for _, name in ipairs(locationOrder) do
            if not running then break end
            
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                StatusLabel.Text = "Teleport ke: " .. name
                player.Character.HumanoidRootPart.CFrame = locations[name]
                
                -- Jeda 5 menit
                for i = waitTime, 1, -1 do
                    if not running then break end
                    StatusLabel.Text = name .. " (" .. i .. "s)"
                    task.wait(1)
                end
            end
        end
    end
end

-- Button Logic
StartStopBtn.MouseButton1Click:Connect(function()
    running = not running
    if running then
        StartStopBtn.Text = "STOP"
        StartStopBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        task.spawn(teleportLoop)
    else
        StartStopBtn.Text = "START"
        StartStopBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        StatusLabel.Text = "Status: STOPPED"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    running = false
    ScreenGui:Destroy()
end)
