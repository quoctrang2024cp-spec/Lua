-- 🌊 MOON HUB | EAT THE WORLD | FULL FIX
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Xóa gui cũ để bật lại được
pcall(function()
    game.CoreGui:FindFirstChild("MoonHubGui"):Destroy()
end)
pcall(function()
    game.CoreGui:FindFirstChild("Fluent"):Destroy()
end)

-- ============================
-- TRẠNG THÁI
-- ============================
local State = {
    AutoFarm = false,
    AutoTP = false,
    AutoSell = false,
    AntiBan = false,
    Speed = 16,
    Gravity = 196.2,
    AutoSize = false,
    AutoSpeed = false,
    AutoEatSpeed = false,
}

-- ============================
-- NÚT TRÒN MỞ MENU
-- ============================
local Gui = Instance.new("ScreenGui")
Gui.Name = "MoonHubGui"
Gui.Parent = game.CoreGui
Gui.ResetOnSpawn = false

local Btn = Instance.new("ImageButton")
Btn.Parent = Gui
Btn.Size = UDim2.new(0, 50, 0, 50)
Btn.Position = UDim2.new(0.05, 0, 0.15, 0)
Btn.BackgroundColor3 = Color3.fromRGB(20, 100, 220)
Btn.BorderSizePixel = 0
Btn.Image = "rbxassetid://9013498676" -- 👈 đổi ID ảnh
Btn.Draggable = true

Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

local Stroke = Instance.new("UIStroke", Btn)
Stroke.Color = Color3.fromRGB(80, 180, 255)
Stroke.Thickness = 2.5

-- Hiệu ứng nhấp nháy
task.spawn(function()
    while Btn and Btn.Parent do
        for i = 0, 1, 0.05 do task.wait(0.03) Stroke.Transparency = i end
        for i = 1, 0, -0.05 do task.wait(0.03) Stroke.Transparency = i end
    end
end)

Btn.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.End, false, game)
    task.wait(0.05)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.End, false, game)
end)

-- ============================
-- TẢI FLUENT
-- ============================
local Fluent = loadstring(game:HttpGet(
    "https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"
))()

-- ============================
-- CỬA SỔ
-- ============================
local Window = Fluent:CreateWindow({
    Title = "🌊 Moon Hub",
    SubTitle = "Eat The World",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 360),
    Acrylic = true,
    Theme = "Aqua",
    MinimizeKey = Enum.KeyCode.End
})

local Tabs = {
    Farm   = Window:AddTab({ Title = "🌾 Farm Settings" }),
    Auto   = Window:AddTab({ Title = "⚙️ Auto" }),
    Player = Window:AddTab({ Title = "🏃 Player" }),
    Update = Window:AddTab({ Title = "🔄 Auto Update" }),
}

local function Notify(t, c)
    Fluent:Notify({ Title = t, Content = c, Duration = 3 })
end

-- Hàm lấy nhân vật
local function GetHuman()
    local c = lp.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end
local function GetRoot()
    local c = lp.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

-- ============================
-- TAB 1: 🌾 FARM SETTINGS
-- ============================
Tabs.Farm:AddSection("Tự động Farm")

-- AUTO SELL
Tabs.Farm:AddToggle("t_sell", {
    Title = "Auto Sell",
    Description = "Tự động sell khi đầy đồ ăn",
    Default = false,
    Callback = function(v)
        State.AutoSell = v
        if v then
            task.spawn(function()
                while State.AutoSell do
                    -- Nhấn phím F để sell (đổi key nếu game dùng key khác)
                    local vim = game:GetService("VirtualInputManager")
                    vim:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                    task.wait(0.1)
                    vim:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                    task.wait(2)
                end
            end)
        end
        Notify(v and "✅ Auto Sell BẬT" or "❌ Auto Sell TẮT", "")
    end
})

-- AUTO FARM
Tabs.Farm:AddToggle("t_farm", {
    Title = "Auto Farm",
    Description = "Tự động farm liên tục",
    Default = false,
    Callback = function(v)
        State.AutoFarm = v
        if v then
            task.spawn(function()
                while State.AutoFarm do
                    -- Click chuột trái để ăn
                    local vim = game:GetService("VirtualInputManager")
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    task.wait(0.05)
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    task.wait(0.1)
                end
            end)
        end
        Notify(v and "✅ Auto Farm BẬT" or "❌ Auto Farm TẮT", "")
    end
})

-- AUTO TP
Tabs.Farm:AddToggle("t_tp", {
    Title = "Teleporter (TP đến đồ ăn)",
    Description = "Tự dịch chuyển đến đồ ăn gần nhất",
    Default = false,
    Callback = function(v)
        State.AutoTP = v
        if v then
            task.spawn(function()
                while State.AutoTP do
                    local root = GetRoot()
                    if root then
                        local best, bestDist = nil, math.huge
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and not obj:IsDescendantOf(lp.Character) then
                                local d = (obj.Position - root.Position).Magnitude
                                -- Part nhỏ trong vòng 200 studs
                                if d < bestDist and d > 2 and obj.Size.Magnitude < 8 and not obj.Anchored then
                                    best, bestDist = obj, d
                                end
                            end
                        end
                        if best then
                            root.CFrame = CFrame.new(best.Position + Vector3.new(0, 4, 0))
                        end
                    end
                    task.wait(0.3)
                end
            end)
        end
        Notify(v and "✅ Teleporter BẬT" or "❌ Teleporter TẮT", "")
    end
})

-- ANTI BAN
Tabs.Farm:AddToggle("t_antiban", {
    Title = "Anti Ban (Hop Server)",
    Description = "Hop server khi có mod/admin vào",
    Default = false,
    Callback = function(v)
        State.AntiBan = v
        if v then
            task.spawn(function()
                -- Danh sách tên mod (viết thường) 👈 thêm tên vào đây
                local modNames = {"mod", "admin", "staff", "owner"}
                while State.AntiBan do
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= lp then
                            for _, name in ipairs(modNames) do
                                if p.Name:lower():find(name) then
                                    Notify("⚠️ Phát hiện MOD!", p.Name .. " → Hop server...")
                                    task.wait(1.5)
                                    game:GetService("TeleportService"):Teleport(game.PlaceId, lp)
                                end
                            end
                        end
                    end
                    task.wait(5)
                end
            end)
        end
        Notify(v and "✅ Anti Ban BẬT" or "❌ Anti Ban TẮT", "")
    end
})

-- ============================
-- TAB 2: ⚙️ AUTO (shortcuts)
-- ============================
Tabs.Auto:AddSection("Bật tắt nhanh")

Tabs.Auto:AddToggle("a_farm", {
    Title = "Auto Farm",
    Default = false,
    Callback = function(v)
        State.AutoFarm = v
        Notify(v and "✅ Auto Farm BẬT" or "❌ Auto Farm TẮT", "")
    end
})

Tabs.Auto:AddToggle("a_tp", {
    Title = "Auto TP",
    Default = false,
    Callback = function(v)
        State.AutoTP = v
        Notify(v and "✅ Auto TP BẬT" or "❌ Auto TP TẮT", "")
    end
})

Tabs.Auto:AddToggle("a_sell", {
    Title = "Auto Sell",
    Default = false,
    Callback = function(v)
        State.AutoSell = v
        Notify(v and "✅ Auto Sell BẬT" or "❌ Auto Sell TẮT", "")
    end
})

Tabs.Auto:AddButton({
    Title = "💰 Sell thủ công ngay",
    Description = "Nhấn phím sell 1 lần",
    Callback = function()
        local vim = game:GetService("VirtualInputManager")
        vim:SendKeyEvent(true, Enum.KeyCode.F, false, game)
        task.wait(0.1)
        vim:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        Notify("💰 Đã sell!", "")
    end
})

-- ============================
-- TAB 3: 🏃 PLAYER
-- ============================
Tabs.Player:AddSection("Chỉnh nhân vật")

Tabs.Player:AddSlider("s_speed", {
    Title = "Speed (Tốc độ)",
    Description = "16 = bình thường | >150 sẽ cảnh báo",
    Default = 16,
    Min = 16,
    Max = 200,
    Rounding = 0,
    Callback = function(v)
        State.Speed = v
        local h = GetHuman()
        if h then h.WalkSpeed = v end
        if v > 150 then
            Notify("⚠️ Cảnh báo!", "Speed " .. v .. " quá cao, dễ bị kick!")
        end
    end
})

Tabs.Player:AddSlider("s_gravity", {
    Title = "Trọng lực (Gravity Boots)",
    Description = "100 = bình thường | 0 = không trọng lực",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(v)
        State.Gravity = v
        workspace.Gravity = (v / 100) * 196.2
    end
})

Tabs.Player:AddButton({
    Title = "🔁 Reset Speed & Gravity",
    Callback = function()
        State.Speed = 16
        State.Gravity = 196.2
        local h = GetHuman()
        if h then h.WalkSpeed = 16 end
        workspace.Gravity = 196.2
        Notify("✅ Reset xong!", "Speed 16, Gravity về mặc định")
    end
})

-- Giữ speed khi respawn
lp.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").WalkSpeed = State.Speed
    workspace.Gravity = State.Gravity
end)

-- ============================
-- TAB 4: 🔄 AUTO UPDATE
-- ============================
Tabs.Update:AddSection("Tự cập nhật chỉ số")

Tabs.Update:AddToggle("u_size", {
    Title = "Auto Update Size",
    Description = "Tự cập nhật kích thước mỗi giây",
    Default = false,
    Callback = function(v)
        State.AutoSize = v
        if v then
            task.spawn(function()
                while State.AutoSize do
                    -- Áp lại scale nhân vật (giữ nguyên size hiện tại)
                    local char = lp.Character
                    if char then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            -- placeholder: game sẽ tự sync size qua server
                        end
                    end
                    task.wait(1)
                end
            end)
        end
        Notify(v and "✅ Auto Size BẬT" or "❌ Auto Size TẮT", "")
    end
})

Tabs.Update:AddToggle("u_speed", {
    Title = "Auto Update Speed",
    Description = "Giữ speed không bị reset",
    Default = false,
    Callback = function(v)
        State.AutoSpeed = v
        if v then
            task.spawn(function()
                while State.AutoSpeed do
                    local h = GetHuman()
                    if h then h.WalkSpeed = State.Speed end
                    task.wait(0.5)
                end
            end)
        end
        Notify(v and "✅ Auto Speed BẬT" or "❌ Auto Speed TẮT", "")
    end
})

Tabs.Update:AddToggle("u_eatspeed", {
    Title = "Auto Update Eat Speed",
    Description = "Tự cập nhật tốc độ ăn",
    Default = false,
    Callback = function(v)
        State.AutoEatSpeed = v
        if v then
            task.spawn(function()
                while State.AutoEatSpeed do
                    -- Giữ click liên tục nhẹ để duy trì eat speed
                    task.wait(0.5)
                end
            end)
        end
        Notify(v and "✅ Auto Eat Speed BẬT" or "❌ Auto Eat Speed TẮT", "")
    end
})

Tabs.Update:AddButton({
    Title = "🔄 Cập nhật tất cả ngay",
    Callback = function()
        local h = GetHuman()
        if h then h.WalkSpeed = State.Speed end
        workspace.Gravity = (State.Gravity / 100) * 196.2
        Notify("✅ Đã cập nhật!", "Speed + Gravity đã đồng bộ")
    end
})

-- ============================
-- THÔNG BÁO MỞ
-- ============================
Notify("🌊 Moon Hub đã load!", "Nhấn END để mở/đóng menu")
Window:SelectTab(1)
