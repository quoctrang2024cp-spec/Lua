repeat task.wait() until game:IsLoaded()

--// CONFIG
local correctKey = "Bnanahub74757900006978655"
local saveFile = "banana_key.txt"
local discordLink = "https://discord.gg/yNNEdHbs2"

--// LOAD KEY
local savedKey = nil
if isfile and isfile(saveFile) then
savedKey = readfile(saveFile)
end

--// GUI
local gui = Instance.new("ScreenGui", game.CoreGui)

-- FUNCTION BO GÓC
local function round(obj, radius)
local c = Instance.new("UICorner", obj)
c.CornerRadius = UDim.new(0, radius)
end

-- KEY FRAME
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,320,0,200)
frame.Position = UDim2.new(0.5,-160,0.5,-100)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true
round(frame, 12)

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8,0,0,40)
box.Position = UDim2.new(0.1,0,0.3,0)
box.PlaceholderText = "Enter key..."
box.Text = savedKey or ""
round(box, 8)

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1,0,0,30)
status.Position = UDim2.new(0,0,0.55,0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(1,1,1)

local check = Instance.new("TextButton", frame)
check.Size = UDim2.new(0.5,0,0,35)
check.Position = UDim2.new(0.25,0,0.75,0)
check.Text = "Check Key"
round(check, 10)

-- MAIN MENU
local function loadMain()
frame:Destroy()

local main = Instance.new("Frame", gui)  
main.Size = UDim2.new(0,350,0,230)  
main.Position = UDim2.new(0.5,-175,0.5,-115)  
main.BackgroundColor3 = Color3.fromRGB(25,25,25)  
main.Active = true  
main.Draggable = true  
round(main, 12)  

local title = Instance.new("TextLabel", main)  
title.Size = UDim2.new(1,0,0,40)  
title.Text = "BananaHub 🍌"  
title.TextScaled = true  
title.BackgroundTransparency = 1  
title.TextColor3 = Color3.new(1,1,1)  

-- CLOSE  
local close = Instance.new("TextButton", main)  
close.Size = UDim2.new(0,30,0,30)  
close.Position = UDim2.new(1,-35,0,5)  
close.Text = "X"  
round(close, 8)  

local open = Instance.new("TextButton", gui)  
open.Size = UDim2.new(0,100,0,40)  
open.Position = UDim2.new(0,10,0.5,0)  
open.Text = "Open"  
open.Visible = false  
round(open, 10)  

close.MouseButton1Click:Connect(function()  
    main.Visible = false  
    open.Visible = true  
end)  

open.MouseButton1Click:Connect(function()  
    main.Visible = true  
    open.Visible = false  
end)  

-- BUTTON DEMO  
local btn = Instance.new("TextButton", main)  
btn.Size = UDim2.new(0.8,0,0,40)  
btn.Position = UDim2.new(0.1,0,0.35,0)  
btn.Text = "Test Button"  
round(btn, 10)  

-- DISCORD PRO  
local discordBtn = Instance.new("TextButton", main)  
discordBtn.Size = UDim2.new(0.8,0,0,40)  
discordBtn.Position = UDim2.new(0.1,0,0.6,0)  
discordBtn.Text = "Join Discord"  
discordBtn.BackgroundColor3 = Color3.fromRGB(88,101,242)  
discordBtn.TextColor3 = Color3.new(1,1,1)  
round(discordBtn, 10)  

local status2 = Instance.new("TextLabel", main)  
status2.Size = UDim2.new(1,0,0,25)  
status2.Position = UDim2.new(0,0,0.82,0)  
status2.BackgroundTransparency = 1  
status2.TextColor3 = Color3.new(1,1,1)  

-- HOVER  
discordBtn.MouseEnter:Connect(function()  
    discordBtn.BackgroundColor3 = Color3.fromRGB(114,137,218)  
end)  

discordBtn.MouseLeave:Connect(function()  
    discordBtn.BackgroundColor3 = Color3.fromRGB(88,101,242)  
end)  

-- CLICK  
discordBtn.MouseButton1Click:Connect(function()  
    setclipboard(discordLink)  
    status2.Text = "Copied Discord Link!"  
    task.delay(2, function()  
        status2.Text = ""  
    end)  
end)

end

-- AUTO LOGIN
if savedKey == correctKey then
loadMain()
end

-- CHECK KEY
check.MouseButton1Click:Connect(function()
if box.Text == correctKey then
status.Text = "Correct Key ✅"

if writefile then  
        writefile(saveFile, box.Text)  
    end  

    wait(1)  
    loadMain()  
else  
    status.Text = "Invalid Key ❌"  
end

end)
