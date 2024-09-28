#SingleInstance Force
#Include %A_ScriptDir%\MHAC_Functions.ahk
SetKeyDelay, 200
;SetMouseDelay, 500
SendMode Input
Gui, Add, Text, x10 w125, Debug Messages:
Gui, Add, Text, x+10 w125 vtxtDebugMessages, 
Gui, show, w500
Return

!^`:: ; Open a Magellan referral from WQ and then with the status field active hit tab.
PtMRNInitials 		:= ""
TXTOldReferralNo 	:= ""
TXTNewReferralNo 	:= ""
TXTOldLocationPOS 	:= ""
TxtOldProvider 		:= ""
TxtOldDepartment 	:= ""
TxtOldTreatmentSpl 	:= ""
CSVOldDx 			:= ""
MyIBMPW := "{#}ItI@1bM"



;ImageSearch, fx,fy,0,0, a_screenWidth, a_screenHeight, %A_ScriptDir%\resource\Button_groupedref.jpg
;msgbox % ErrorLevel "`n" fx "x" fy
;Click %fx% %fy%
;CheckDSBS(MyIBMPW, "04493700")
;Return




CSVCurRefGeneral := GetInfoCSVCurRefGene()
Loop, Parse, CSVCurRefGeneral, $
	{
		;MsgBox % CSVCurRefGeneral . "," . A_Index . "," . A_LoopField
		If (A_Index = 1)
			TXTOldReferralNo 	:= A_LoopField
		If (A_Index = 2)
			TXTOldLocationPOS 	:= A_LoopField
		If (A_Index = 3)
			TxtOldProvider 		:= A_LoopField
		If (A_Index = 4)
			TxtOldDepartment 	:= A_LoopField
		If (A_Index = 5)
			TxtOldTreatmentSpl 	:= A_LoopField
	}
; CSVOldDx := GetInfoCSVCurRefDXPX() ; For speed skip this segment for MAGELLAN reworks. Alternatively use the distribute fields.

Click 200, 620 ; Click Grouped Referrals Button.
Send !d
WinWaitActive, Referral Lookup, , 7
	If ErrorLevel = 0 ; If the referral screen is ready for entry...
		Send !n ; Create a new referral
	Else Return ; If screen does not populate we have bigger issues so abort!
WinWaitActive, KPWA Production, , 7
	If ErrorLevel = 0 ; If the new referral is created and the screen is ready...
		Send !t{Down}{Enter}
	Else Return ; If new referral is not created does not populate we have bigger issues so abort!
WinWaitActive, Template Select, , 7
	If ErrorLevel = 0 ; If Template Select is working right!
		{
			IfInString, TxtOldTreatmentSpl, Counseling
				{
					Send 442612{Enter}!a
					Sleep, 1000
					Send !a
				}
			Else IfInString, TxtOldTreatmentSpl, Psychiatry
				{
					Send 442611{Enter}!a
					Sleep, 1000
					Send !a
				}
			Else IfInString, TxtOldTreatmentSpl, Psychology
				{
					Send 442617{Enter}!a
					Sleep, 1000
					Send !a
				}
			Else IfInString, TxtOldTreatmentSpl, Neuropsychology
				{
					Send 442618{Enter}!a
					Sleep, 1000
					Send !a
				}
			Else Return	; If it is not a referral for therapy psychiatry or psychology abandon ship! After this we will process the referral so this is important.
		}
	Else Return ; If template select does not populate we have bigger issues so abort!
Sleep, 500
TXTNewReferralNo := GetInfoCSVCurRefNumber() ; Get the new referral then after this we should make all edits.

SetInfoCSVCurRefGene(TXTOldLocationPOS,TxtOldProvider,TxtOldDepartment,"MHS MAGELLAN PROVIDER","Office","MAGELLAN PROVIDER [79999999]",TxtOldTreatmentSpl)
;SetInfoCSVCurRefDXPX(CSVOldDx) ; For speed skip this segment for MAGELLAN reworks. Alternatively use the distribute fields.
SetInfoCSVCurRefAuth("t", "y{+}1", "Preservice")
SetInfoCSVCurRefNote("Approval Review Complete","Magellan rework referral, original referral number " . TXTOldReferralNo . ".")
SetInfoCSVCurRefAddi()
SetInfoCSVCurRefFlag()


Click 60, 195 ; Go back to the original referral.
Sleep, 2000
SetInfoCSVCurRefNote("General","Magellan rework referral, new referral number " . TXTNewReferralNo . ".")
Sleep, 2000
Click 172, 618 ; Go to grouped referrals.
Send !l

TxtErrorLVL := ""
ImageSearch, fx,fy,0,0, a_screenWidth, a_screenHeight, %A_ScriptDir%\resource\CheckBox_by Provider.jpg
If (ErrorLevel != 1 and ErrorLevel != 2) 
	Click %fx% %fy%
TxtErrorLVL .=  ErrorLevel "`n" fx "x" fy "`n`n" 
MouseMove, 0, 0
;msgbox % ErrorLevel "`n" fx "x" fy
Sleep 500
ImageSearch, fx,fy,0,0, a_screenWidth, a_screenHeight, %A_ScriptDir%\resource\CheckBox_by Location-POS.jpg
If (ErrorLevel != 1 and ErrorLevel != 2) 
	Click %fx% %fy%
TxtErrorLVL .=  ErrorLevel "`n" fx "x" fy "`n`n" 
MouseMove, 0, 0
Sleep 1000
ImageSearch, fx,fy,0,0, a_screenWidth, a_screenHeight, %A_ScriptDir%\resource\CheckBox_by Department.jpg
If (ErrorLevel != 1 and ErrorLevel != 2) 
	Click %fx% %fy%
TxtErrorLVL .=  ErrorLevel "`n" fx "x" fy "`n`n" 
MouseMove, 0, 0
;Sleep 2000
Send {End}
Sleep 500
ImageSearch, fx,fy,0,0, a_screenWidth, a_screenHeight, %A_ScriptDir%\resource\CheckBox_Diagnosis.jpg
If (ErrorLevel != 1 and ErrorLevel != 2) 
	Click %fx% %fy%
TxtErrorLVL .=  ErrorLevel "`n" fx "x" fy "`n`n" 
;msgbox % ErrorLevel "`n" fx "x" fy
MouseMove, 0, 0
Sleep 500
ImageSearch, fx,fy,0,0, a_screenWidth, a_screenHeight, %A_ScriptDir%\resource\CheckBox_Questionnaires.jpg
If (ErrorLevel != 1 and ErrorLevel != 2) 
	Click %fx% %fy%
TxtErrorLVL .=  ErrorLevel "`n" fx "x" fy "`n`n" 
;msgbox % TxtErrorLVL
MouseMove, 0, 0

SendEvent {Click, 1650 257}
Send Canceled{Tab}Duplicate{Tab}

Clipboard := PtMRNInitials . ", " . TXTOldReferralNo . ", " . TXTNewReferralNo . ", " . TxtOldTreatmentSpl
;MsgBox % GetInfoCSVCurRefGene() . "`n`n" . GetInfoCSVCurRefDXPX()

WinActivate, DSBS I&E

FileAppend, %Clipboard%`n, %A_ScriptDir%\Magellan Rework AutoLog.txt
Return

GetInfoCSVCurRefNumber()
	{
		Clipboard := "" ; Reset the Clipboard.
		Click 176, 382 ; Click General Tab.
		Sleep, 2000
		Click 1652, 212 ; Click referral # box.
		Send ^a^c 			;Put the New referral # in the clipboard for later.
		Sleep, 2000
		Return Clipboard
	}
GetInfoCSVCurRefGene() ; CSV = (Referral #,Location/POS,Provider,Department)
	{
		Clipboard := "" ; Reset the Clipboard.
		Click 176, 382 ; Click General Tab.
		Sleep, 2000
		Click 1652, 212 ; Click referral # box.
		Send ^a^c 			;Put the New referral # in the clipboard for later.
		Sleep, 1000
		ReferralNo := Clipboard
		Clipboard := "" ; Reset the Clipboard.
		/* For speed skip this segment for MAGELLAN reworks. Alternatively use the distribute fields.
		Click 693, 588 ; Click Location/POS
		Send ^a^c
		Sleep, 2000
		LocationPOS := Clipboard
		Clipboard := "" ; Reset the Clipboard.
		Click 1477, 591
		Send ^a^c
		Sleep, 2000
		Provider := Clipboard
		Clipboard := "" ; Reset the Clipboard.
		Click 690, 631
		Send ^a^c
		Sleep, 2000
		Department := Clipboard
		Clipboard := "" ; Reset the Clipboard.
		*/ ; For speed skip this segment for MAGELLAN reworks. Alternatively use the distribute fields.
		Click 1477, 840
		Send ^a^c
		Sleep, 1000
		ProviderSpecialty := Clipboard
		Clipboard := "" ; Reset the Clipboard.
		Return ReferralNo . "$" . LocationPOS . "$" . Provider .  "$" . Department .  "$" . ProviderSpecialty
	}
GetInfoCSVCurRefDXPX() ; CSV = (Diagnoses)
	{
		CSVDx := ""
		Clipboard := "" ; Reset the Clipboard.
		Click 172, 405 ; Click Dx/Px Tab.
		Sleep, 2000
		Click 348, 602 ; Click 1st Dx.
		Loop
			{
				Send ^a^c
				Sleep, 2000
				If (Clipboard != "")
					{
						Send {Tab}
						If (CSVDx = "")
							CSVDx := Clipboard
						Else CSVDx .= "$" . Clipboard
							Clipboard := "" ; Reset the Clipboard.
					}
				Else break
			}
		Return CSVDx
	}
SetInfoCSVCurRefGene(LocationPOS,Provider,Department,PlaceofService,PosType,ProviderPOS,ProviderSpecialty)
	{
		Sleep, 2000
		Click 176, 382 ; Click General Tab.
		Sleep, 2000
		Click 429, 546 ; Click Override
		Sleep, 2000
		
		/* For speed skip this segment for MAGELLAN reworks. Alternatively use the distribute fields.
		Click 693, 588 ; Click Location/POS
		Send %LocationPOS%
		SubmitRefField()
		Click 1477, 591
		Sleep, 1000
		
		;Fix the provider Name.
		StringReplace, Provider, Provider, [, $, All
		StringReplace, Provider, Provider, ], $, All
		IfInString, Provider, $
			{
				Loop, Parse, Provider, $
					{
						If (A_Index = 1)
							{
								LoopProviderName := A_LoopField
							}
						If (A_Index = 2)
							{
								Provider := A_LoopField
							}
						
					}
			}
		
		
		Send %Provider%
		SubmitRefField()
		
		Click 690, 631
		Send %Department%
		SubmitRefField()
		*/ ; For speed skip this segment for MAGELLAN reworks. Alternatively use the distribute fields.
		
		;Click 1481, 705
		;Send %PlaceofService% ; Epic is recommended to set provider with Provider/POS alternatively.
		;SubmitRefField()
		Click 1481, 750
		Send %PosType%
		Click 1481, 797
		Send %ProviderPOS%
		Send {Enter}
		WinWaitActive, Provider Finder, , 7
			If ErrorLevel = 0 ; If Provider Finder Came Up!
				{
					Sleep, 1000
					Click 600, 63
					Sleep, 2000
					Send {Backspace}{Enter}
					Sleep, 2000
					Send {Enter}
				} ; If provider finder does not come up we will assume the provider was specific enough it was accepted ez!
		WinWaitActive, KPWA Production, , 3
			If ErrorLevel ; If Provider Selection failed ask for help!
				{
					MsgBox Please assist with making a selection.
				}
		Sleep, 1000
		Click 1481, 839
		Send %ProviderSpecialty%
		Return
	}
SetInfoCSVCurRefDXPX(CSVDx)
	{
		WarnIfStuckonEntry()
		Click 172, 405 ; Click Dx/Px Tab.
		Sleep, 2000
		Click 348, 602 ; Click 1st Dx.
		Global LoopICD
		Global LoopSymptoms
		LoopDx := ""
		LoopICD := ""
		LoopSymptoms := ""
		Loop, Parse, CSVDx, $
			{
				If (A_LoopField != "")
					{
						StringReplace, LoopDx, A_LoopField, %A_Space%(ICD-10-CM) -%A_Space%, $, All
						Loop, Parse, LoopDx, $
							{
								If (A_Index = 1)
									{
										If (A_LoopField != "")
											{
												Send %A_LoopField%
												Sleep, 2000
												Send {Tab}
												If (LoopICD = "")
													LoopICD .= A_LoopField
												Else LoopICD .= "," . A_LoopField
											}
									}
								Else If (A_Index = 2)
									{
										If (A_LoopField != "")
											{
												If (LoopSymptoms = "")
													LoopSymptoms .= A_LoopField
												Else LoopSymptoms .= "$" . A_LoopField
											}
									}
							}
					}
			}
		Return
	}
SetInfoCSVCurRefAuth(start, end, AuthType)
	{
		WarnIfStuckonEntry()
		Click 172, 450 ; Click Auth Tab.
		Sleep, 2000
		Click 691, 672 ; Click Start
		Send %start%
		Sleep, 2000
		Send {Tab}
		Sleep, 2000
		Send %end%
		Sleep, 2000
		Click  1487, 765 ; Click initial request type.
		Send %AuthType%{Tab}
		Return
	}
SetInfoCSVCurRefNote(TXTSubject, TXTMessage)
	{
		Global PtMRNInitials
		Global MyIBMPW
		ptInitials := ""
		Click 172, 480 ; Click Notes Tab.
		Sleep, 2000
		Send !w
		Sleep, 1000
		Send %TXTSubject%{Tab}{Tab}{Tab}{Tab}
		Sleep, 1000
		If (PtMRNInitials = "")
			{
				Send .namemrn{Enter}
				Clipboard := "" ; Reset the Clipboard.
				loopInitialTime := A_TickCount
				loopSeconds := 5 ; 5 Seconds after now the loop needs to stop.
				While (RegExMatch(Clipboard, "[A-z0-9]") = 0 && A_TickCount - loopInitialTime < loopSeconds * 1000)
					{
						Send ^a^c 			;Put the dot phrase in the clipboard for later.
					}
				Send ^a{Backspace}
				PtNameMRN := Clipboard
				Clipboard := "" ; Reset the Clipboard.
				Loop, Parse, PtNameMRN, `,
					{
						If (A_Index = 1)
							{
								Loop, Parse, A_LoopField, %A_Space% ;parse for space
									ptInitials .= SubStr(A_LoopField, 1, 1) . "."
							}
						If (A_Index = 2)
							{
								ptMRN := SubStr(A_LoopField, 3, 8)
							}
					}
				PtMRNInitials := ptMRN . " " . ptInitials
				
				Sleep, 500
				CheckDSBS(MyIBMPW, ptMRN)
			}
		WinActivate, KPWA Production
		Sleep, 500
		Send %TXTMessage%
		Return
	}
SetInfoCSVCurRefAddi()
	{
		WarnIfStuckonEntry()
		Click 172, 500 ; Click Additional Info Tab.
		Sleep, 2000
		Click 660,500 ; Click Recieved time.
		Sleep, 1000
		Send t{Tab}
		Sleep, 1000
		Send v{Tab}
	}
SetInfoCSVCurRefFlag()
	{
		WarnIfStuckonEntry()
		Click 172, 550 ; Click Flags Tab.
		Sleep, 2000
		Send MHAC PAR{Tab}
	}
SubmitRefField()
	{
		Send {Enter}
		Sleep, 3000
		Click 600, 63
		Sleep, 2000
		Send {Backspace}{Enter}
		Sleep, 2000
		Send {Enter}
		Sleep, 2000
		
		WarnIfStuckonEntry()
		
		; Still needs a way to validate that the correct selection was made.
		
		Return
	}
	
WarnIfStuckonEntry()
	{
		ffinderstillopen := "0x0"
		If (ffinderstillopen = "0x0")
			ffinderstillopen := WinExist("Category Select")
		If (ffinderstillopen = "0x0")
			ffinderstillopen := WinExist("Item Information")
		If (ffinderstillopen = "0x0")
			ffinderstillopen := WinExist("Location Finder")
		If (ffinderstillopen = "0x0")
			ffinderstillopen := WinExist("Provider Finder")
		If (ffinderstillopen = "0x0")
			ffinderstillopen := WinExist("Record Select")
		If (ffinderstillopen = "0x0")
			ffinderstillopen := WinExist("Select a Diagnosis")
		If (ffinderstillopen = "0x0")
			ffinderstillopen := WinExist("Template Select")
		If (ffinderstillopen != "0x0") ; If a window is still open there is a problem
			MsgBox Please assist with making a selection. %ffinderstillopen%
	}
;GetInfoCSVCurRefAuth() ; CSV = (Diagnoses) Not Needed ASAP will be setting not capturing.
;GetInfoCSVCurRefNote() ; CSV = (Diagnoses) Not Needed ASAP will be setting not capturing.
;GetInfoCSVCurRefAddi() ; CSV = (Diagnoses) Not Needed ASAP will be setting not capturing.
;GetInfoCSVCurRefQues() ; CSV = (Diagnoses) Not Needed ASAP will be difficult to automate.
;GetInfoCSVCurRefFlag() ; CSV = (Diagnoses) Not Needed ASAP will be setting not capturing.
;GetInfoCSVCurRefNoti() ; CSV = (Diagnoses) Not Needed.
;GetInfoCSVCurRefComm() ; CSV = (Diagnoses) Not Needed.
;GetInfoCSVCurRefGrou() ; CSV = (Diagnoses) Not Needed ASAP will be manipulating not capturing.

;SetInfoCSVCurRefFlag()
;SetInfoCSVCurRefAddi()
;SetInfoCSVCurRefNote("General","Magellan rework referral, original referral number 8264584.")
;SetInfoCSVCurRefAuth("t", "y{+}1", "Preservice")
;SetInfoCSVCurRefDXPX("F41.9$F90.9$F31.9")
;SetInfoCSVCurRefGene("GENERIC PLACE OF SERVICE FOR REFERRALS","GENERIC PROVIDER FOR REFERRALS [79999997]","","MHS MAGELLAN PROVIDER","Office","MAGELLAN PROVIDER [79999999]","Mental Health Counseling")
;MsgBox % GetInfoCSVCurRefGene() . "`n`n" . GetInfoCSVCurRefDXPX()
