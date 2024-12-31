#Requires AutoHotkey v2
CoordMode "Pixel", "Screen"  ; Ensure pixel color coordinates are relative to the screen
CoordMode "Mouse", "Screen"  ; Ensure mouse coordinates are relative to the screen

; Get the directory of the current script
ScriptDir := A_ScriptDir

; Define the relative path to your OCR script
OCRScriptPath := ScriptDir . "\..\Scripts\scan_text.ahk"

; Define the paths to images
ImagePath1 := ScriptDir . "\..\Images\return.png"
ImagePath2 := ScriptDir . "\..\Images\return_2.png"
ImagePath3 := ScriptDir . "\..\Images\yes.png"
ImagePath4 := ScriptDir . "\..\Images\no.png"

; Hotkeys to start and stop the OCR script
^+1:: ; Ctrl+Shift+1 to start the OCR script
{
    Run(OCRScriptPath)
}

; Function to send click at specified coordinates
SendClick(x, y)
{
    ; Move the mouse slightly before the main move
    MouseMove(x + 5, y + 5)
    Sleep(100)  ; Short delay to ensure Roblox detects the move
    MouseMove(x, y)  ; Move to the target position
    Sleep(100)  ; Optional delay for stability
    Click("Left", "Down")  ; Press down
    Sleep(50)  ; Hold down for a moment
    Click("Left", "Up")    ; Release
    Sleep(100)  ; Delay after the click
}

; Function to repeatedly check pixels and click until both images are found
ClickUntilImagesFound_Return()
{
    Loop
    {
        if (ImagesFound_Return())
        {
            ; Click X: 799 Y: 219 ten times with 500 ms sleep in between
            Tooltip("Both images found, clicking at 799, 219")
            Loop 10
            {
                SendClick(799, 219)
                Tooltip("Clicked at 799, 219")
                Sleep(500)
                Tooltip() ; Hide tooltip
            }
            break
        }
        else
        {
            Tooltip("Both images not found")
            Sleep(1000) ; Wait for 1 second before checking again
            Tooltip() ; Hide tooltip
						SendClick(770, 700)
						Sleep(1000)
						SendClick(770, 720)
						Sleep(1000)
						SendClick(770, 740)
						Sleep(1000)
						SendClick(770, 760)
						Sleep(1000)
						SendClick(770, 780)
						Sleep(1000)
						SendClick(770, 800)
        }

        Sleep(1000)  ; Wait for 1 second before checking again
    }
}

; Function to repeatedly check pixels and click until both images are found
ClickUntilImagesFound_Yes()
{
    Loop
    {
        if (ImagesFound_Yes())
        {
            ; Click X: 883 Y: 187 five times with 500 ms sleep in between
            Tooltip("Both images found, clicking at 883, 187")
            Loop 10
            {
                SendClick(883, 187)
                Tooltip("Clicked at 883, 187")
                Sleep(500)
                Tooltip() ; Hide tooltip
            }
            break
        }
        else
        {
            Tooltip("Both images not found")
            Sleep(1000) ; Wait for 1 second 
            Tooltip() ; Hide tooltip

            ; Redo Captcha
            MouseMove(300, 300)
            Sleep(100)  ; Small sleep to simulate user activity
            MouseMove(100, 100)  ; Simulate user moving the mouse
            Sleep(500)  ; Ensure Roblox detects it

            Sleep(1000)
            SendClick(200, 503)
            Sleep(1000)
            Send("{a down}") ; Hold "a" key down

            Sleep(7500) ; Wait for 7.5 seconds
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

            Sleep(1000)
            SendClick(787, 695)

            Sleep(1000)
            SendClick(772, 749)

						Sleep(1000)
						SendClick(769, 761)

            Sleep(1000)
            SendClick(799, 219)

            Sleep(10000)  ; Wait for 20 second before checking again
        }

        Sleep(1000)  ; Wait for 1 second before checking again
    }
}

; Function to check if both images are found on the screen within the specified region
ImagesFound_Return()
{
    global ImagePath1, ImagePath2
    ImageSearchResult1 := ImageSearch(&x1, &y1, 0, 0, 1920, 1080, "*50 " . ImagePath1)
    ImageSearchResult2 := ImageSearch(&x2, &y2, 0, 0, 1920, 1080, "*50 " . ImagePath2)
    if (ImageSearchResult1 = 1 && ImageSearchResult2 = 1)
    {
        Tooltip("ImageSearch success: Both images found at (" . x1 . ", " . y1 . ") and (" . x2 . ", " . y2 . ")")
        Sleep(1000)
        Tooltip() ; Hide tooltip
        return true
    }
    else
    {
        Tooltip("ImageSearch failed: Both images not found")
        Sleep(1000)
        Tooltip() ; Hide tooltip
        SendClick(971, 930)
        return false
    }
}

; Function to check if both images are found on the screen within the specified region
ImagesFound_Yes()
{
    global ImagePath3, ImagePath4
    ImageSearchResult3 := ImageSearch(&x3, &y3, 0, 0, 1920, 1080, "*50 " . ImagePath3)
    ImageSearchResult4 := ImageSearch(&x4, &y4, 0, 0, 1920, 1080, "*50 " . ImagePath4)
    if (ImageSearchResult3 = 1 && ImageSearchResult4 = 1)
    {
        Tooltip("ImageSearch success: Both images found at (" . x3 . ", " . y3 . ") and (" . x4 . ", " . y4 . ")")
        Sleep(1000)
        Tooltip() ; Hide tooltip
        return true
    }
    else
    {
        Tooltip("ImageSearch failed: Both images not found")
        Sleep(1000)
        Tooltip() ; Hide tooltip
        SendClick(971, 930)
        return false
    }
}

; Function to prompt for a valid number
PromptForNumber() 
{
    while true {
        ; Prompt the user for the number of iterations
        InputBoxResult := InputBox("Please enter the number of times you want the loop to run:", "Enter Loop Count")

        ; Get the value entered by the user
        LoopCount := InputBoxResult.Value

        ; Try to convert LoopCount to a number
        LoopCount := Number(LoopCount)

        if !IsNumber(LoopCount) {  ; Validate if the input is a number
            MsgBox "Invalid input. Please enter a number."
        } else {
            MsgBox "You entered a valid number: " LoopCount

            ; Perform actions with the number here
            Loop LoopCount {
                ; Your loop actions here
            }

            break
        }
    }
}

; Hotkey to trigger the pixel color check and clicking loop
^F4:: ; Ctrl+F4 to start the pixel scan and clicking loop
{
    PromptForNumber()

    Loop LoopCount
    {
        ; Before starting the main script actions, move the mouse first
        MouseMove(300, 300)
        Sleep(100)  ; Small sleep to simulate user activity
        MouseMove(100, 100)  ; Simulate user moving the mouse
        Sleep(500)  ; Ensure Roblox detects it

        Sleep(1000)
        SendClick(200, 503)
        Sleep(1000)
        Send("{a down}") ; Hold "a" key down

        Sleep(7500) ; Wait for 7.5 seconds
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

        Sleep(1000)
        SendClick(787, 695)

        Sleep(15000)
        ClickUntilImagesFound_Yes()
        Sleep(500)

        ClickUntilImagesFound_Return()
        Sleep(25000)
    }
}

; Stop button to close the script
^F3:: ; Ctrl+F3 to stop the script
{
    ExitApp
}
