#Requires AutoHotkey v2

CoordMode "Mouse", "Screen"  ; Ensure coordinates are relative to the screen
CoordMode "Pixel", "Screen"  ; Ensure pixel color coordinates are relative to the screen

; Function to get RGB color of the pixel at the current mouse position
GetPixelColorAndCoords() {
    MouseGetPos(&x, &y)
    color := PixelGetColor(x, y, true)  ; Get the color of the pixel and convert it to RGB
    red := (color >> 16) & 0xFF
    green := (color >> 8) & 0xFF
    blue := color & 0xFF
    Tooltip("X: " . x . " Y: " . y . "`nRGB: " . red . ", " . green . ", " . blue, x + 10, y + 10)
    A_Clipboard := "X: " . x . " Y: " . y . " RGB: " . red . ", " . green . ", " . blue
    Sleep(2000)  ; Display the tooltip for 2 seconds
    Tooltip()  ; Hide the tooltip
}

; Display coordinates and RGB on right mouse click
~RButton::
{
    GetPixelColorAndCoords()
}
