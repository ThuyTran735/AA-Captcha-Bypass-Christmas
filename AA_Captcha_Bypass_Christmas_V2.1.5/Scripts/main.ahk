#Requires AutoHotkey v2
#SingleInstance Force
CoordMode("Pixel", "Screen")  ; Ensure pixel color coordinates are relative to the screen
CoordMode("Mouse", "Screen")  ; Ensure mouse coordinates are relative to the scree
Unit_Slot_1 := 0
Unit_Slot_2 := 0
Unit_Slot_3 := 0
Unit_Slot_4 := 0
Unit_Slot_5 := 0
Unit_Slot_6 := 0

main := Gui("+AlwaysOnTop")
main.Show("w300 h300 x1610 y0")
StartButton := main.add("Button", "x10 y250 w100", "Start (Ctrl+F4)")
StopButton := main.add("Button", "x120 y250 w100", "Stop (Ctrl+F3)")

StartButton.OnEvent("Click", (*) => Send("{Ctrl Down}{F4}{Ctrl Up}"))
StartButton.OnEvent("Click", (*) => Unit_GUI_Save())
StopButton.OnEvent("Click", (*) => ExitApp())

; Add 6 checkboxes with corresponding dropdowns next to them
main.add("Text", "x10 y10 w150", "Enable Slot")
main.add("Text", "x170 y10 w150", "Placement Amount")

Checkbox1 := main.add("Checkbox", "x10 y30 w150", "Unit Slot 1")
Dropdown1 := main.add("DropDownList", "x170 y30 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox2 := main.add("Checkbox", "x10 y60 w150", "Unit Slot 2")
Dropdown2 := main.add("DropDownList", "x170 y60 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox3 := main.add("Checkbox", "x10 y90 w150", "Unit Slot 3")
Dropdown3 := main.add("DropDownList", "x170 y90 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox4 := main.add("Checkbox", "x10 y120 w150", "Unit Slot 4")
Dropdown4 := main.add("DropDownList", "x170 y120 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox5 := main.add("Checkbox", "x10 y150 w150", "Unit Slot 5")
Dropdown5 := main.add("DropDownList", "x170 y150 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox6 := main.add("Checkbox", "x10 y180 w150", "Unit Slot 6")
Dropdown6 := main.add("DropDownList", "x170 y180 w50", ["1", "2", "3", "4", "5", "6"])
 
Unit_GUI_Save() 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Checkbox1.Value) {
        Unit_Slot_1 := Dropdown1.Value
    } else {
        Unit_Slot_1 := 0
    }
    if (Checkbox2.Value) {
        Unit_Slot_2 := Dropdown2.Value
    } else {
        Unit_Slot_2 := 0
    }
    if (Checkbox3.Value) {
        Unit_Slot_3 := Dropdown3.Value
    } else {
        Unit_Slot_3 := 0
    }
    if (Checkbox4.Value) {
        Unit_Slot_4 := Dropdown4.Value
    } else {
        Unit_Slot_4 := 0
    }
    if (Checkbox5.Value) {
        Unit_Slot_5 := Dropdown5.Value
    } else {
        Unit_Slot_5 := 0
    }
    if (Checkbox6.Value) {
        Unit_Slot_6 := Dropdown6.Value
    } else {
        Unit_Slot_6 := 0
    }
}

; Get the directory of the current script
ScriptDir := A_ScriptDir

OCRScriptDir := A_ScriptDir . "\..\Scripts\scan_text.ahk"

; Define the paths to images
ImagePath1 := ScriptDir . "\..\Images\return.png"
ImagePath2 := ScriptDir . "\..\Images\return_2.png"
ImagePath3 := ScriptDir . "\..\Images\yes.png"
ImagePath4 := ScriptDir . "\..\Images\no.png"
ImagePath5 := ScriptDir . "\..\Images\unit_exit.png"
ImagePath6 := ScriptDir . "\..\Images\unit_maxed.png"
ImagePath7 := ScriptDir . "\..\Images\cards.png"
ImagePath8 := ScriptDir . "\..\Images\next.png"
ImagePath9 := ScriptDir . "\..\Images\ability.png"
ImagePath10 := ScriptDir . "\..\Images\unit.png"
ImagePath11 := ScriptDir . "\..\Images\reconnect.png"

global return_check := 0

; Hotkeys to start and stop the OCR script
^+1:: ; Ctrl+Shift+1 to start the OCR script
{
    Run(OCRScriptDir)
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

; Function to send click at specified coordinates
SendClick_R(x, y)
{
    ; Move the mouse slightly before the main move
    MouseMove(x + 5, y + 5)
    Sleep(100)  ; Short delay to ensure Roblox detects the move
    MouseMove(x, y)  ; Move to the target position
    Sleep(100)  ; Optional delay for stability
    Click("Right", "Down")  ; Press down
    Sleep(50)  ; Hold down for a moment
    Click("Right", "Up")    ; Release
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
            Tooltip("Both return button images found, clicking at 799, 219")
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
            Tooltip("Both return button images not found")
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
            Tooltip("Both yes and no images found, clicking at 883, 187")
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
            return_check := 0
            if !ImagesFound_Yes() {
                Sleep(1000) ; Wait for 1 second 
                Tooltip() ; Hide tooltip
    
                ; Redo Captcha
                MouseMove(300, 300)
                Sleep(100)  ; Small sleep to simulate user activity
                MouseMove(100, 100)  ; Simulate user moving the mouse
                Sleep(500)  ; Ensure Roblox detects it
    
                Sleep(1000)
                SendClick(200, 503)
                Sleep(2000)
                if !ImagesFound_Yes() {
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

                    Sleep(5000)  ; Wait for 5 seconds before checking again
                }
            }
        }
        Sleep(1000)  ; Wait for 1 second before checking again
    }
}

; Function to check if both images are found on the screen within the specified region
ImagesFound_Return()
{
    global return_check
    global ImagePath1, ImagePath2
    ImageSearchResult1 := ImageSearch(&x1, &y1, 0, 0, 1920, 1080, "*50 " . ImagePath1)
    ImageSearchResult2 := ImageSearch(&x2, &y2, 0, 0, 1920, 1080, "*50 " . ImagePath2)
    if (ImageSearchResult1 = 1 && ImageSearchResult2 = 1)
    {
        Tooltip("ImageSearch success: Both return button images found at (" . x1 . ", " . y1 . ") and (" . x2 . ", " . y2 . ")")
        Sleep(100)
        Tooltip() ; Hide tooltip
        return true
    }
    else
    {
        Tooltip("ImageSearch failed: Both return button images not found")
        Sleep(100)
        Tooltip() ; Hide tooltip
        SendClick(971, 930)
        return false
    }
}

ImagesFound_Return_2()
{
    global return_check
    global ImagePath1, ImagePath2
    ImageSearchResult1 := ImageSearch(&x1, &y1, 0, 0, 1920, 1080, "*50 " . ImagePath1)
    ImageSearchResult2 := ImageSearch(&x2, &y2, 0, 0, 1920, 1080, "*50 " . ImagePath2)
    if (ImageSearchResult1 = 1 && ImageSearchResult2 = 1)
    {
        Tooltip("ImageSearch success: Both return button images found at (" . x1 . ", " . y1 . ") and (" . x2 . ", " . y2 . ")")
        Sleep(50)
        Tooltip() ; Hide tooltip
        SendClick(x1, y1)
        return_check := 1
        return true
    }
    else
    {
        Tooltip("ImageSearch failed: Both return button images not found, continuing")
        Sleep(50)
        Tooltip() ; Hide tooltip
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
        Tooltip("ImageSearch success: Both yes and no images found at (" . x3 . ", " . y3 . ") and (" . x4 . ", " . y4 . ")")
        Sleep(50)
        Tooltip() ; Hide tooltip
        return true
    }
    else
    {
        Tooltip("ImageSearch failed: Both yes and no images not found")
        Sleep(50)
        Tooltip() ; Hide tooltip
        SendClick(971, 930)
        return false
    }
}

; Function to check if both images are found on the screen within the specified region
ImageFound_unit_exit()
{
    global ImagePath5
    ImageSearchResult5 := ImageSearch(&x5, &y5, 0, 0, 1920, 1080, "*50 " . ImagePath5)
    if (ImageSearchResult5 = 1)
    {
        Sleep(50)
        return true
    }
    else
    {
        Sleep(50)
        return false
    }
}

; Function to check if both images are found on the screen within the specified region
ImageFound_unit_maxed()
{
    global ImagePath6
    ImageSearchResult6 := ImageSearch(&x6, &y6, 0, 0, 1920, 1080, "*50 " . ImagePath6)
    if (ImageSearchResult6 = 1)
    {
        Sleep(50)
        return true
    }
    else
    {
        Sleep(50)
        SendClick(425, 676)
        Sleep(2000)
        return false
    }
}

; Function to check if both images are found on the screen within the specified region
ImageFound_cards()
{
    global ImagePath7
    ImageSearchResult7 := ImageSearch(&x7, &y7, 0, 0, 1920, 1080, "*50 " . ImagePath7)
    if (ImageSearchResult7 = 1)
    {
        Tooltip("ImageSearch success: Cards image found at (" . x7 . ", " . y7 . ")")
        Sleep(1000)
        Tooltip() ; Hide tooltip
        return true
    }
    else
    {
        Tooltip("ImageSearch failed: Cards not found, continuing")
        Sleep(1000)
        Tooltip() ; Hide tooltip
        return false
    }
}

ImageFound_next()
{
    global ImagePath8
    ImageSearchResult8 := ImageSearch(&x8, &y8, 0, 0, 1920, 1080, "*50 " . ImagePath8)
    if (ImageSearchResult8 = 1)
    {
        Tooltip("ImageSearch success: Next image found at (" . x8 . ", " . y8 . ")")
        Sleep(50)
        Tooltip() ; Hide tooltip
        SendClick(x8,y8)
        return true
    }
    else
    {
        Tooltip("ImageSearch failed: Next button not found, continuing")
        Sleep(50)
        Tooltip() ; Hide tooltip
        return false
    }
}

ImageFound_ability()
{
    global ImagePath9
    ImageSearchResult9 := ImageSearch(&x9, &y9, 0, 0, 1920, 1080, "*50 " . ImagePath9)
    if (ImageSearchResult9 = 1)
    {
        Sleep(50)
        SendClick(x9,y9)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_unit()
{
    global ImagePath10
    ImageSearchResult10 := ImageSearch(&x10, &y10, 0, 0, 1920, 1080, "*50 " . ImagePath10)
    if (ImageSearchResult10 = 1)
    {
        return true
    }
    else
    {
        return false
    }
}

ClickRandomly() {
	minX := 610 ; Minimum x-coordinate
	minY := 220 ; Minimum y-coordinate
	maxX := 1590 ; Maximum x-coordinate
	maxY := 930 ; Maximum y-coordinate
	xx := Random(minX, maxX) ; Generate random x-coordinate within range
	yy := Random(minY, maxY) ; Generate random y-coordinate within range
    saved_xx := xx
    saved_yy := yy

    Sleep(200)
	SendClick(xx, yy) ; Click at the random coordinates
	Sleep(1000)
	return [saved_xx, saved_yy]
}

Unit_Upgrade(num_key) {
    Loop {
        Send(num_key) ; Press a number key to select the unit
        ClickRandomly()
        if (ImageFound_unit_exit()) {
            break
        }
        if (ImageFound_next()) {
            break
        }
        if (ImagesFound_Return_2()) {
            break
        }
        if return_check = 1 {
            break
        }
    }
    Sleep(100)
    Loop {
        if (ImageFound_unit_maxed()) {
            Sleep(100)
            SendClick(551, 356)
            break
        }
        if (ImageFound_next()) {
            break
        }
        if (ImagesFound_Return_2()) {
            break
        }
        if return_check = 1 {
            break
        }
        Sleep(50) 
    }
}

; Function to prompt for a valid number
PromptForNumber() {
    global return_check
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    while true {
        ; Define the maximum integer value
        MaxInt := 2147483647

        ; Define the maximum unit placement number
        MaxUnit_Num := 6

        ; Prompt the user for the number of iterations
        InputBoxResult1 := InputBox("Please enter the number of times you want the loop to run (max: " MaxInt "):", "Enter Loop Count")
        
        ; Get the value entered by the user
        LoopCount := InputBoxResult1.Value

        ; Try to convert LoopCount to a number
        LoopCount := Number(LoopCount)

        if !IsNumber(LoopCount) {  ; Validate if the input is a number
            MsgBox "Invalid input. Please enter a number."
        } else if LoopCount > MaxInt { ; Check if the input exceeds the maximum integer limit 
            MsgBox "The number you entered exceeds the maximum allowed value of " MaxInt ". Please enter a smaller number."
        } else {
            MsgBox "You entered a valid number: " LoopCount

            ; Perform actions with the number here
            Loop LoopCount {
                return_check := 0

                Loop 3 {
                ; Before starting the main script actions, move the mouse first
                MouseMove(300, 300)
                Sleep(100)  ; Small sleep to simulate user activity
                MouseMove(100, 100)  ; Simulate user moving the mouse
                Sleep(500)  ; Ensure Roblox detects it
                }

                Loop 3 {
                Sleep(500)
                SendClick(200, 503)
                }

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

                SendClick(45, 1055)
                Sleep(500)
                SendClick(960, 310)
                Sleep(500)
                Loop 7 {
                    Send("{WheelDown}")
                    Sleep(100)
                }
                Sleep(1000)
                SendClick(1150, 480)
                Sleep(1000)
                SendClick(1305, 232)
                Sleep(500)
                Send("{Tab}")
                Sleep(500)

                Loop 15 {
                    Send("{i down}") ; Hold "i" key down
                    Sleep(100)
                    Send("{i up}") ; Hold "o" key up
                }
                Sleep(500)
                ; Move the mouse down 700 pixels
                MouseMove(960, 700)

                Loop 15 {
                    Send("{o down}") ; Hold "o" key down
                    Sleep(100)
                    Send("{o up}") ; Hold "o" key up
                }
                Sleep(500)

                Send("{Escape}")
                Sleep(500)
                SendClick(805, 204)
                Sleep(500)
                SendClick(632, 375)
                Sleep(500)
                SendClick(893, 374)
                Sleep(500)
                Send("{Escape}")
                
                Loop {     
                    ; Search for the color
                    if PixelSearch(&xxx, &yyy, 0, 0, 1920, 800, 0x006783, 1) {
                        ; If the color is found, move the mouse and right click
                        Loop 3 {
                            SendClick_R(xxx, yyy)
                            Sleep(100)
                        }
                
                        ; Break the loop after clicking
                        break
                    }
                    Send("{Right down}")
                    Sleep(500)
                    Send("{Right up}")
                }
                Sleep(3000)

                Send("{Escape}")
                Sleep(500)
                SendClick(805, 204)
                Sleep(500)
                SendClick(632, 375)
                Sleep(500)
                SendClick(1336, 375)
                Sleep(500)
                Send("{Escape}")
                
                Loop Unit_Slot_1 {
                    Unit_Upgrade("1")
                }

                if return_check = 0 {
                    Loop Unit_Slot_2 {
                        Unit_Upgrade("2")
                    }
                }

                if return_check = 0 {
                    Loop Unit_Slot_3 {
                        Unit_Upgrade("3")
                    }
                }

                if return_check = 0 {
                    Loop Unit_Slot_4 {
                        Unit_Upgrade("4")
                    }
                }

                if return_check = 0 {
                    Loop Unit_Slot_5 {
                        Unit_Upgrade("5")
                    }
                }

                if return_check = 0 {
                    Loop Unit_Slot_6 {
                        Unit_Upgrade("6")
                    }
                }

                if return_check = 0 {
                    ClickUntilImagesFound_Return()
                    Sleep(25000)
                }
            }
            break
        }
    }
}

; Hotkey to trigger the pixel color check and clicking loop
^F4:: ; Ctrl+F4 to start the pixel scan and clicking loop
{
    PromptForNumber()
}
        
; Stop button to close the script
^F3:: ; Ctrl+F3 to stop the script
{
    ExitApp
}