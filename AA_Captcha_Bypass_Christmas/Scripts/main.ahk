#Requires AutoHotkey v2

CoordMode "Pixel", "Screen"  ; Ensure pixel color coordinates are relative to the screen
CoordMode "Mouse", "Screen"  ; Ensure mouse coordinates are relative to the screen

; Get the directory of the current script
ScriptDir := A_ScriptDir
; Define the relative path to your OCR script
OCRScriptPath := ScriptDir . "\scan_text.ahk"
; Define the relative path to your images
ImagePath1 := ScriptDir . "\..\Images\return.png"
ImagePath2 := ScriptDir . "\..\Images\return_2.png"

; Path to the AutoHotkey executable (make sure this path is correct for you)
AutoHotkeyPath := "C:\Program Files\AutoHotkey\v2\AutoHotkey.exe"

; Hotkeys to start and stop the OCR script
^+1:: ; Ctrl+Shift+1 to start the OCR script
{
    Run(AutoHotkeyPath . " " . OCRScriptPath)
}

; Function to send click at specified coordinates
SendClick(x, y) {
    MouseMove(x, y)
    Sleep(500)
    Click
}

; Function to get the RGB color of a pixel at the specified coordinates
GetPixelColor(x, y) {
    color := PixelGetColor(x, y, true)
    red := (color >> 16) & 0xFF
    green := (color >> 8) & 0xFF
    blue := color & 0xFF
    return [red, green, blue]
}

; Function to check if the RGB values match
CheckPixelColors() {
    Pixel1 := GetPixelColor(650, 380)
    Pixel2 := GetPixelColor(701, 380)
    Pixel3 := GetPixelColor(880, 376)
    
    Tooltip("Checking colors: Pixel1 = " . Pixel1[1] . ", " . Pixel1[2] . ", " . Pixel1[3] . " | Pixel2 = " . Pixel2[1] . ", " . Pixel2[2] . ", " . Pixel2[3] . " | Pixel3 = " . Pixel3[1] . ", " . Pixel3[2] . ", " . Pixel3[3])
    Sleep(1000)

    if (Pixel1[1] = 71 && Pixel1[2] = 184 && Pixel1[3] = 253) &&
       (Pixel2[1] = 71 && Pixel2[2] = 184 && Pixel2[3] = 253) &&
       (Pixel3[1] = 78 && Pixel3[2] = 187 && Pixel3[3] = 253) {
        return true
    }
    return false
}

; Function to repeatedly check pixels and click until both images are found
ClickUntilImagesFound() {
    Loop {
        ; Check pixel colors before clicking
        if (CheckPixelColors()) {
            Tooltip("Pixel colors match, clicking at 766, 747")
            Loop 10 {
                SendClick(766, 747)
                Tooltip("Clicked at 766, 747")
                Sleep(500)
                Tooltip() ; Hide tooltip
            }
        } else {
            Tooltip("Pixel colors do not match")
            Sleep(1000) ; Wait for 1 second before checking again
            Tooltip() ; Hide tooltip
        }
        if (ImagesFound()) {
            ; Click X: 799 Y: 219 five times with 500 ms sleep in between
            Tooltip("Both images found, clicking at 799, 219")
            Loop 10 {
                SendClick(799, 219)
                Tooltip("Clicked at 799, 219")
                Sleep(500)
                Tooltip() ; Hide tooltip
            }
            break
        } else {
            Tooltip("Both images not found")
            Sleep(1000) ; Wait for 1 second before checking again
            Tooltip() ; Hide tooltip
        }
        Sleep(1000)  ; Wait for 1 second before checking again
    }
}

; Function to check if both images are found on the screen within the specified region
ImagesFound() {
    global ImagePath1, ImagePath2
    ImageSearchResult1 := ImageSearch(&x1, &y1, 0, 0, 1920, 1080, ImagePath1)
    ImageSearchResult2 := ImageSearch(&x2, &y2, 0, 0, 1920, 1080, ImagePath2)
    if (ImageSearchResult1 = 1 && ImageSearchResult2 = 1) {
        Tooltip("ImageSearch success: Both images found at (" . x1 . ", " . y1 . ") and (" . x2 . ", " . y2 . ")")
        Sleep(1000)
        Tooltip() ; Hide tooltip
        return true
    } else {
        Tooltip("ImageSearch failed: Both images not found")
        Sleep(1000)
        Tooltip() ; Hide tooltip
        return false
    }
}

; Hotkey to trigger the pixel color check and clicking loop
^F4:: ; Ctrl+F4 to start the pixel scan and clicking loop
{
    Sleep(2000) 
    ; Initial click to focus on the Roblox application 
    SendClick(1, 1) 
    Sleep(1000)
    SendClick(163, 503)
    Sleep(1000)
    Send("{a down}") ; Hold "a" key down 
    Sleep(10000) ; Wait for 10 seconds
    Send("{a up}") ; Release "a" key
    Sleep(1000)
    SendClick(1078, 583)
    Sleep(1000)
    SendClick(964, 514)
    Sleep(100)
    
    ; Send Ctrl+Shift+1 to start the OCR script
    Send("^+1")
    Sleep(2000)
    
    ; Send Ctrl+Shift+C
    Send("^+C")
    Sleep(2000)
    SendClick(959, 610)
    Sleep(100)
    Send("^v")

    ; Send Ctrl+Shift+2 to stop the OCR script
    Sleep(500)
    Send("^+2")

    Sleep(20000)
    ClickUntilImagesFound()
}

; Stop button to close the script
^F3:: ; Ctrl+F3 to stop the script
{
    ExitApp
}
