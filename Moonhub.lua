repeat task.wait() until game:IsLoaded()

local key = "Moonhub928337666639"
local discord = "https://discord.gg/uyUSpFaKb"

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,50,0,50)
open.Position = UDim2.new(0,20,0.5,-25)
open.BackgroundColor3 = Color3.fromRGB(25,25,25)
open.Text = "M"
open.TextColor3 = Color3.new(1,1,1)
open.Font = Enum.Font.GothamBold
open.TextSize = 24
open.Active = true
open.Draggable = true
Instance.new("UICorner", open).CornerRadius = UDim.new(1,0)

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,220)
main.Position = UDim2.new(0.5,-210,0.5,-110)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Visible = false
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "Moon Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 26

local keybox = Instance.new("TextBox", main)
keybox.Size = UDim2.new(1,-40,0,45)
keybox.Position = UDim2.new(0,20,0,60)
keybox.BackgroundColor3 = Color3.fromRGB(35,35,35)
keybox.PlaceholderText = "Enter Your Key here..."
keybox.Text = ""
keybox.TextColor3 = Color3.new(1,1,1)
keybox.Font = Enum.Font.Code
keybox.TextSize = 18
keybox.ClearTextOnFocus = false
Instance.new("UICorner", keybox).CornerRadius = UDim.new(0,10)

local check = Instance.new("TextButton", main)
check.Size = UDim2.new(0.45,-10,0,40)
check.Position = UDim2.new(0,20,0,120)
check.BackgroundColor3 = Color3.fromRGB(0,170,0)
check.Text = "CHECK KEY"
check.TextColor3 = Color3.new(1,1,1)
check.Font = Enum.Font.GothamBold
check.TextSize = 18
Instance.new("UICorner", check).CornerRadius = UDim.new(0,10)

local getkey = Instance.new("TextButton", main)
getkey.Size = UDim2.new(0.45,-10,0,40)
getkey.Position = UDim2.new(0.55,0,0,120)
getkey.BackgroundColor3 = Color3.fromRGB(0,120,255)
getkey.Text = "GET KEY"
getkey.TextColor3 = Color3.new(1,1,1)
getkey.Font = Enum.Font.GothamBold
getkey.TextSize = 18
Instance.new("UICorner", getkey).CornerRadius = UDim.new(0,10)

local status = Instance.new("TextLabel", main)
status.Size = UDim2.new(1,0,0,30)
status.Position = UDim2.new(0,0,0,170)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.new(1,1,1)
status.Font = Enum.Font.Gotham
status.TextSize = 18

open.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

getkey.MouseButton1Click:Connect(function()
	setclipboard(discord)
	status.Text = "Discord copied!"
end)

check.MouseButton1Click:Connect(function()
	if keybox.Text == key then
		status.Text = "Correct Key!"
		
		loadstring(game:HttpGet("https://rawscripts.net/raw/Eat-the-World-MOON-HUB-212583"))()
	else
		status.Text = "Invalid Key!"
	end
end)
