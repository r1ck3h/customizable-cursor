local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

if not getgenv().CursorConfig then
    getgenv().CursorConfig = {
        Color = Color3.fromRGB(255,255,255),
        OutlineColor = Color3.fromRGB(0,0,0),

        Transparency = 1,
        OutlineTransparency = 1,

        Rainbow = false,
        OutlineRainbow = false,

        DeleteCursor = false
    }
end

local CursorOutline = Drawing.new("Triangle")
CursorOutline.Visible = true
CursorOutline.Transparency = 1
CursorOutline.Color = CursorConfig.OutlineColor
CursorOutline.Thickness = 1
CursorOutline.Filled = true

local Cursor = Drawing.new("Triangle")
Cursor.Visible = true
Cursor.Transparency = 1
Cursor.Color = CursorConfig.Color
Cursor.Thickness = 1
Cursor.Filled = true

Render = RunService.RenderStepped:Connect(function()
    if UserInputService.MouseBehavior == Enum.MouseBehavior.Default then
        UserInputService.MouseIconEnabled = false
        local Mouse = UserInputService:GetMouseLocation()

        Cursor.PointA = Vector2.new(Mouse.X,Mouse.Y + 15)
        Cursor.PointB = Vector2.new(Mouse.X,Mouse.Y)
        Cursor.PointC = Vector2.new(Mouse.X + 10,Mouse.Y + 10)
        Cursor.Color = CursorConfig.Color
        Cursor.Transparency = CursorConfig.Transparency

        CursorOutline.PointA = Vector2.new(Mouse.X,Mouse.Y + 16)
        CursorOutline.PointB = Vector2.new(Mouse.X,Mouse.Y)
        CursorOutline.PointC = Vector2.new(Mouse.X + 11,Mouse.Y + 10)
        CursorOutline.Color = CursorConfig.OutlineColor
        CursorOutline.Transparency = CursorConfig.OutlineTransparency
    else
        Cursor.Transparency = 0
        CursorOutline.Transparency = 0
    end

    if CursorConfig.DeleteCursor then
        Render:Disconnect()
        Cursor:Remove()
        CursorOutline:Remove()
        UserInputService.MouseIconEnabled = true
    end

    if CursorConfig.Rainbow then
        local Hue, Saturation, Value = CursorConfig.Color:ToHSV()
        if Hue == 1 then
            Hue = 0
        end
        CursorConfig.Color = Color3.fromHSV(Hue + 0.001, 1, 1)
    end
    if CursorConfig.OutlineRainbow then
        local Hue, Saturation, Value = CursorConfig.OutlineColor:ToHSV()
        if Hue == 1 then
            Hue = 0
        end
        CursorConfig.OutlineColor = Color3.fromHSV(Hue + 0.001, 1, 1)
    end
end)
