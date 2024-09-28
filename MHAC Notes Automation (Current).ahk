#SingleInstance Force
#Include %A_ScriptDir%\MHAC_Functions.ahk
#Include %A_ScriptDir%\MHAC_VariableDeclarations.ahk
#Include %A_ScriptDir%\MHAC_Strings.ahk
DetectHiddenWindows, On
SetKeyDelay, 50
MyIBMPW := "{#}ItI@1bM"
OnExit, ExitSub

SetTimer, IfPtLookupResetVars, 1000

NoteTakingTrainer:
	GoSub, SendVarstoGUI
	;CareConcerns := "ADHD, anxiety, depression, and stress"
	;/* BlueKP Theme
	MainTextColor := "D9F1FE" ; Fixed? "cDF1FE"/"c9F1FE" Orig "cD9F1FE" 
	EditBoxTextColor := "0D1C3D"
	MainBackgroundColor := "006BA6"
	EditBoxColor := "A6DFFE"
	KPLOGO := A_ScriptDir . "\resource\kp-logo-white.png"
	;*/
	/* ;Dev Special Theme
	MainTextColor := "840099"
	EditBoxTextColor := "840099"
	MainBackgroundColor := "c0ff4f"
	EditBoxColor := "DBFF9B"
	KPLOGO := A_ScriptDir . "\resource\kp-logo.png"
	*/
	Menu, Tray, Icon, %A_ScriptDir%\resource\BrainSmiley.ico
	Gui, Color, %MainBackgroundColor%, %EditBoxColor%
	gui, font, C%MainTextColor% 
	Gui, Add, Text, x10 y10, Patient Info:
	Gui, Add, Checkbox, x+5 gMajorVarChanged Checked%IsPtCaller% vIsPtCaller, Pt=Caller
	Gui, Add, Checkbox, x+5 gMajorVarChanged Checked%boolPtMinor% vboolPtMinor, Minor?
	Gui, Add, Text, x+5, Age:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 R1 w25 gMinorVarChanged vptAge, %ptAge%
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x+5, DOB:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 R1 w67 gMinorVarChanged vptDOB, %ptDOB%
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x10, MRN:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 R1 w55 gMinorVarChanged vptMRN, %ptMRN%
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x+5, Pref. Name:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 R1 w41 gMinorVarChanged vptNamePref, %ptNamePref%
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x+5, Full Name:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 R1 w90 gMinorVarChanged vptName, %ptName%
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x10 w54, Phone #:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 R1 w90 gMinorVarChanged vptNumber, %ptNumber%
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x+5 w44, Email:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 R1 w142 gMinorVarChanged vPtEmail1, %PtEmail1%
	Gui, Add, Text, x10 w346 h5 0x10  ;Horizontal Line > Etched Gray
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x10 +Hidden vtextCallerSegment, Caller Info:
	Gui, Add, Checkbox, x+5 gMinorVarChanged +Hidden Checked%boolCallerROI% vboolCallerROI, ROI?
	Gui, Add, Text, x+5 +Hidden vcallreltxt, Relation:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 w65 gMinorVarChanged +Hidden vCallerRelation, %CallerRelation%   ;w50-75
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x+5 +Hidden vcallnametxt, Name:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 w85 gMinorVarChanged +Hidden vCallerName, %CallerName%
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x10 w54 +Hidden vtextCallerNumber, Callback `#:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 w90 gMinorVarChanged +Hidden vCallerNumber, %CallerNumber%
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x+5 w44 +Hidden vtxtPtEmail2, Email `#2:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x+5 w142 gMinorVarChanged +Hidden vPtEmail2, %PtEmail2%
	Gui, Font, C%MainTextColor% 
	Gui, Add, Text, x10 w346 h5 0x10  ;Horizontal Line > Etched Gray

	Gui, Add, Text, x10, Coverage:
	Gui, Add, DropDownList, x120 y+-15 w95, No Coverage||KP Core|KP PPO|KP Medicare|Molina|N/A
	Gui, Add, Text, x+5, Verified:
	Gui, Add, DropDownList, x+5 w92, Not Verified||DSBS|OHP|Inactive
	
	Gui, Add, Text, x10, Care Concerns:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x120 y+-15 w235 gMinorVarChanged hwndhwndCareConcerns vCareConcerns, %CareConcerns%
	Gui, Font, C%MainTextColor% 

	Gui, Add, Text, x10, Additional Notes:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit, x120 y+-15 w235 r3 gMinorVarChanged vAdditionalNotes, %AdditionalNotes%
	Gui, Font, C%MainTextColor% 
	gui, font, 
	gui, font, C%MainTextColor% W700
	Gui, Add, Text, x10, Screening Result:
	gui, font, 
	gui, font, C%MainTextColor% 
	ScreeningChoice := "N/A|Mild|Routine|Moderate|Emergent"
	If (txtScreeningResult != "")
		StringReplace, ScreeningChoice, ScreeningChoice, %txtScreeningResult%, %txtScreeningResult%|
	Gui, Add, DropDownList, x120 y+-15 w235 gMajorVarChanged vtxtScreeningResult, %ScreeningChoice%
	
	Gui, Add, Text, x13 w110 Center vtxtptPHQ9Score, PHQ9 Score:
	Gui, Add, Text, x+5 w110 Center vtxtptCSRAScore, CSRA Score:
	Gui, Add, Text, x+5 w110 Center vtxtptGAD7Score, GAD7 Score:
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit,  x13 w110 gMajorVarChanged vptPHQ9Score, %ptPHQ9Score%
	Gui, Font, C%MainTextColor% 
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit,  x+5 w110 gMajorVarChanged vptCSRAScore, %ptCSRAScore%
	Gui, Font, C%MainTextColor% 
	Gui, Font, C%EditBoxTextColor% 
		Gui, Add, Edit,  x+5 w110 gMajorVarChanged vptGAD7Score, %ptGAD7Score%
	Gui, Font, C%MainTextColor% 

	Gui, Add, Text, x10 w346 h5 0x10  ;Horizontal Line > Etched Gray
		
	gui, font, 
	gui, font, C%MainTextColor% W700 underline
	Gui, Add, Text,  x10 y+2  w69, Services:
	gui, font, 
	gui, font, C%MainTextColor% W700 underline
		Gui, Add, Text,  x+5, *See below
	gui, font, C%MainTextColor% W700 underline
	Gui, Add, Text, x+5, ;referral exist?
	Gui, Add, Text, x175 y+-13 w180, Solution (*recommended)
	gui, font, 
	gui, font, C%MainTextColor% 

	;gui, font, C%MainTextColor%
	;	Gui, Add, Text,  x10, *Checkboxes below: 
	gui, font, C%MainTextColor% W700

		Gui, Add, Text,  x84 y+2 , (U= Urgent ref., R=Ref., E=Established IDS)
	Gui, Add, Text, x10 y+2 w346 h1 0x10  ;Horizontal Line > Etched Gray
	gui, font, 
	gui, font, C%MainTextColor% W700
	Gui, Add, Text,  x10 y+2 w69, Psychiatry:
	gui, font, 
	gui, font, C%MainTextColor% 
	Gui, Add, Checkbox, x+5 w26 gMajorVarChanged, U
	Gui, Add, Checkbox, x+5 w26 gMajorVarChanged Checked%boolRefExistsPsychiatry% vboolRefExistsPsychiatry, R
	Gui, Add, Checkbox, x+5 w26 gMajorVarChanged, E
	;Add logic to select the right one as last time!
	Gui, Add, DropDownList, x+2 w180 gMajorVarChanged vPsychiatryReq, % PsychiatristSolutionSelection()

	Gui, Add, Text, x10 y+2 w346 h1 0x10  ;Horizontal Line > Etched Gray
	gui, font, 
	gui, font, C%MainTextColor% W700
	Gui, Add, Text,  x10 y+2 w69, Therapy:
	gui, font, 
	gui, font, C%MainTextColor% 
	Gui, Add, Checkbox, x+5 w26 gMajorVarChanged, U
	Gui, Add, Checkbox, x+5 w26 gMajorVarChanged Checked%boolRefExistsTherapy% vboolRefExistsTherapy, R
	Gui, Add, Checkbox, x+5 w26 gMajorVarChanged, E
	;Add logic to select the right one as last time!
	Gui, Add, DropDownList, x+2 w180 gMajorVarChanged vTherapyReq, % TherapistSolutionSelection()

	Gui, Add, Text, x10 y+2 w346 h1 0x10  ;Horizontal Line > Etched Gray
	gui, font, 
	gui, font, C%MainTextColor% W700
	Gui, Add, Text,  x10 y+2 w69, Psychology: ; Gray out solutions if no referral to psychology!
	gui, font, 
	gui, font, C%MainTextColor% 
	Gui, Add, Checkbox, x+5 w26 gMajorVarChanged, U
	Gui, Add, Checkbox, x+5 w26 gMajorVarChanged Checked%boolRefExistsPsychology% vboolRefExistsPsychology, R
	Gui, Add, Checkbox, x+5 w26 gMajorVarChanged, E
	;Add logic to select the right one as last time!
	Gui, Add, DropDownList, x+2 w180 gMajorVarChanged vPsychologyReq, % PsychologistSolutionSelection()
	

	Gui, Add, Text, x10 y+2 w346 h1 0x10  ;Horizontal Line > Etched Gray
	gui, font, 
	gui, font, C%MainTextColor% W700 underline
	Gui, Add, Text, x10 y+2 w69, Other:
	gui, font, 
	gui, font, C%MainTextColor% 
	Gui, Add, Checkbox, x+36 w26 gMinorVarChanged Checked%IsExistingRef% vIsExistingRef, R
	gui, font, 
	gui, font, C%MainTextColor% 
	Gui, Add, Text, x+36, Patient also requests the following:
	
	Gui, Add, Text, x111 y+-93 h98 0x11  ;Vertical Line > Etched Gray
	Gui, Add, Text, x+23 h98 0x11  ;Vertical Line > Etched Gray
	Gui, Add, Text, x79 y+-99 h99 0x11  ;Vertical Line > Etched Gray
	Gui, Add, Text, x+85 h99 0x11  ;Vertical Line > Etched Gray
	
	Gui, Add, Checkbox, x10 gMinorVarChanged Checked%IsSUD% vIsSUD, SUD
	Gui, Add, Checkbox, x+5 gMinorVarChanged Checked%IsMHIOP% vIsMHIOP, MH IOP
	Gui, Add, Checkbox, x+5 gMinorVarChanged Checked%IsED% vIsED, ED (Eating)
	Gui, Add, Checkbox, x+5 gMinorVarChanged Checked%IsGH% vIsGH, GH (Gender)
	Gui, Add, Checkbox, x+5 gMinorVarChanged Checked%Is3RDParty% vIs3RDParty, 3rd Party
	Gui, Add, Text, x10 y+2 w346 h1 0x10  ;Horizontal Line > Etched Gray
	;Gui, Add, ListBox, x175 y+-15 w180 Multi vReqOther, % TXTSolutionListOther() 
	;boolReqPsychiatryEDS(1) . boolReqTherapyEDS(1) . boolReqPsychologyEDS(1)

	Gui, Add, Text, x10 w125, Debug Messages:
	Gui, Add, Text, x+5 w125 vtxtDebugMessages, 
	Gui, Add, Button, gReset x10, Reset
	Gui, Add, Button, gLoadEDSGUI x+89, Provider Details
	
	Gui, Add, Picture, x35 y105 w300 h-1 0x4000000 vPNGKPLogo, %KPLOGO%
	

	IniRead, xpos, %A_ScriptName%, Settings, xpos
	IniRead, ypos, %A_ScriptName%, Settings, ypos
	if (xpos="first")
	  Gui, show,  ; if first run, show gui at default positon
	else
	  Gui, show, x%xpos% y%ypos%
	Edit_SetCueBanner(hwndCareConcerns, "ADHD, anxiety, depression, and stress", 1)
	MainWindowID := WinExist("A")
	GoSub, SendGUItoVars
	GoSub, PtCallerCB
	Return

LoadEDSGUI:
	If (WinExist("ahk_id " . EDSGUIWindowID) = 0)
		{
			Gui, 2:Color, %MainBackgroundColor%, %EditBoxColor%
			If (boolPtIsMinor() = 0)
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Ginger Coaching Tracking #:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vtxtGingerCoachingTracking, %txtGingerCoachingTracking% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Sent Calm and MyStrength info?:
						Gui, 2:Add, Checkbox, x+5 gMinorVarChanged Checked%boolCalmMyStrength% vboolCalmMyStrength,  
				}
			If (boolReferralExistsPsychiatry() or boolReqPsychiatryEDS() or boolReqPsychiatryMagellan())
				{
					Gui, 2:Font, 
					Gui, 2:Font, W700 underline C%MainTextColor%
						Gui, 2:Add, Text,  x10 y+20, Psychiatrist Details
				}
			If (boolReqPsychiatryEDS() or boolReqPsychiatryMagellan())
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor%
						Gui, 2:Add, Text, x175 y+-15 , New Referral #:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit,  x+5 w100, 
				}
			If boolReferralExistsPsychiatry()
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text, x10 w160, Existing Referral #:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit,  x+5 w180, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred/Recommended By:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychiatryRefBy, %PsychiatryRefBy% 
				}
			If (boolReqPsychiatryEDS())
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Verified EDS Provider:
						Gui, 2:Add, DropDownList, x+5 w180 gMinorVarChanged vPsychiatryVerifStats, Not Verified||CPAN|FCH|CMS|Not Contracted
						Gui, 2:Add, Text,  x10 w160, Referred to Provider:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychiatryRefTo, %PsychiatryRefTo% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to POS (Care site):
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychiatryRefPOS, %PsychiatryRefPOS% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Address:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychiatryRefAddr, %PsychiatryRefAddr% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Phone:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychiatryRefTele, %PsychiatryRefTele% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Fax:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychiatryRefFax, %PsychiatryRefFax% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to NPI:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychiatryRefNPI, %PsychiatryRefNPI% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Tax ID:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychiatryRefTaxID, %PsychiatryRefTaxID%
				}
			If (boolReferralExistsTherapy() or boolReqTherapyEDS() or boolReqTherapyMagellan())
				{
					Gui, 2:Font, 
					Gui, 2:Font, W700 underline C%MainTextColor% 
						Gui, 2:Add, Text,  x10, Therapist Details
				}
			If (boolReqTherapyEDS() or boolReqTherapyMagellan())
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor%
						Gui, 2:Add, Text, x175 y+-15 , New Referral #:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit,  x+5 w100, 
				}
			If boolReferralExistsTherapy()
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text, x10 w160, Existing Referral #:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit,  x+5 w180, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred/Recommended By:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vTherapyRefBy, %TherapyRefBy%
				}
			If (boolReqTherapyEDS())
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Verified EDS Provider:
						Gui, 2:Add, DropDownList, x+5 w180 gMinorVarChanged vTherapyVerifStats, Not Verified||CPAN|FCH|CMS|Not Contracted
						Gui, 2:Add, Text,  x10 w160, Referred to Provider:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vTherapyRefTo, %TherapyRefTo% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to POS (Care site):
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vTherapyRefPOS, %TherapyRefPOS% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Address:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vTherapyRefAddr, %TherapyRefAddr% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Phone:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vTherapyRefTele, %TherapyRefTele% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Fax:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vTherapyRefFax, %TherapyRefFax% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to NPI:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vTherapyRefNPI, %TherapyRefNPI% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Tax ID:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vTherapyRefTaxID, %TherapyRefTaxID%
				}
			If (boolReferralExistsPsychology() or boolReqPsychologyEDS() or boolReqPsychologyMagellan())
				{
					Gui, 2:Font, 
					Gui, 2:Font, W700 underline C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Psychologist Details
				}
			If (boolReqPsychologyEDS() or boolReqPsychologyMagellan())
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor%
						Gui, 2:Add, Text, x175 y+-15 , New Referral #:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit,  x+5 w100, 
				}
			If boolReferralExistsPsychology()
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text, x10 w160, Existing Referral #:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit,  x+5 w180, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred/Recommended By:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychologyRefBy, %PsychologyRefBy% 
				}
			If (boolReqPsychologyEDS())
				{
					Gui, 2:Font, 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Verified EDS Provider:
						Gui, 2:Add, DropDownList, x+5 w180 gMinorVarChanged vPsychologyVerifStats, Not Verified||CPAN|FCH|CMS|Not Contracted
						Gui, 2:Add, Text,  x10 w160, Referred to Provider:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychologyRefTo, %PsychologyRefTo% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to POS (Care site):
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychologyRefPOS, %PsychologyRefPOS% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Address:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychologyRefAddr, %PsychologyRefAddr% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Phone:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychologyRefTele, %PsychologyRefTele% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Fax:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychologyRefFax, %PsychologyRefFax% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to NPI:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychologyRefNPI, %PsychologyRefNPI% 
					Gui, 2:Font, C%MainTextColor% 
						Gui, 2:Add, Text,  x10 w160, Referred to Tax ID:
					Gui, 2:Font, C%EditBoxTextColor% 
						Gui, 2:Add, Edit, x+5 w180 gMinorVarChanged vPsychologyRefTaxID, %PsychologyRefTaxID% 
					Gui, 2:Font, C%MainTextColor% 
				}
			Gui, 2:Add, Button, gCloseEDSGUI x175, Close
			IniRead, xpos, %A_ScriptName%, EDSGUI, xpos
			IniRead, ypos, %A_ScriptName%, EDSGUI, ypos
			if (xpos="first")
			  Gui, 2:show,  ; if first run, show gui at default positon
			else
			  Gui, 2:show, x%xpos% y%ypos%
			EDSGUIWindowID := WinExist("A")
		}
		Else
			Goto, CloseEDSGUI
	Return

2GuiClose:
CloseEDSGUI:
	WinGetPos, xpos, ypos, , , ahk_id %EDSGUIWindowID% ; 
	IniWrite, %xpos%, %A_ScriptName%, EDSGUI, xpos
	IniWrite, %ypos%, %A_ScriptName%, EDSGUI, ypos
	Gui, 2:Destroy
	Return

MajorVarChanged:
	Gui, Submit, NoHide
	GoSub, SendGUItoVars
	GoSub, PtCallerCB
	;GoSub, GUIRefresh
	Gosub, eventScreeningResult
	Return

MinorVarChanged:
	Gui, Submit, NoHide
	GoSub, SendGUItoVars
	Return

GUIRefresh:
	WinGetPos, xpos, ypos, , , ahk_id %MainWindowID% ; 
	IniWrite, %xpos%, %A_ScriptName%, Settings, xpos
	IniWrite, %ypos%, %A_ScriptName%, Settings, ypos
	Gui, Destroy
	GoSub, SendVarstoGUI
	GoSub, NoteTakingTrainer
	Return


^!i:: ; Inject Info ; Start in a note field to get mrn and name info without effort. ;Perhaps make it so it will only do this if it is not already done.
	InjectEncounterValues()
	GoSub, MajorVarChanged
	Return

^!d:: ; Check DSBS
	CheckDSBS(MyIBMPW, txtPtMRN())
	Return


^!Numpad1::
^!n::
	Clipboard := GeneratePARNote()
	Send ^v
	/*
	*/
	Return

^!Numpad2:: ;clipboard := "" ; No longer need a reset lol
	Gui, Submit, NoHide
	Clipboard := AppointmentMessagesAll() 
	Send ^v
	Return

	
^!Numpad3::
	Gui, Submit, NoHide
	Clipboard := AppointmentNotesAll() 
	Send ^v
	Return

^!Numpad4:: ;Needs Work new menu
	Gui, Submit, NoHide
	clipboard := "Warm transfer " . txtPtMRN() . " " . txtPtNameInitials() . "`n`n" . GeneratePARNote()
	Send ^v
	Return

^!Numpad5::
	Gui, Submit, NoHide
	clipboard := "Cold transfer " . txtPtMRN() . " " . txtPtNameInitials() . "`n`n" . GeneratePARNote()
	Send ^v
	Return

^!Numpad6::
	Gui, Submit, NoHide
	clipboard := TxtEmailGreeting(txtPtNamePref(), txtCallerName()) . TxtEmailBodyMagellanFU() . TxtEmailSalutation("Kai Hamilton","Patient Access Representative","206-630-1680","kai.l.hamilton@kp.org")
	Send ^v
	Return

^!Numpad7::
	Gui, Submit, NoHide
	clipboard := TxtEmailGreeting(txtPtNamePref(), txtCallerName()) . TxtEmailBodyEDSList(txtPtNamePref(),txtPtAge(),txtPtPhone(),TxtListOfRequestedServices(boolReqPsychiatry(), boolReqTherapy(), boolReqPsychology()),txtPtConcerns()) . TxtEmailSalutation("Kai Hamilton","Patient Access Representative","206-630-1680","kai.l.hamilton@kp.org")
	Send ^v
	Return

^!Numpad8::
	Gui, Submit, NoHide
	clipboard := TxtEmailGreeting(txtPtNamePref(), txtCallerName()) . TxtEmailBodyDigitalCare() . TxtEmailSalutation("Kai Hamilton","Patient Access Representative","206-630-1680","kai.l.hamilton@kp.org")
	Send ^v
	Return

^!Numpad0::
	Gui, Submit, NoHide
	CPTCodeCSV := TxtCPTCodeCSVFromSymptoms(txtPtConcerns())
	Loop, Parse, CPTCodeCSV, $
		{
			If (A_LoopField != "" or A_LoopField != " ")
				Send %A_LoopField%{Enter}
		}
	Sleep, 500
	Return
	
GeneratePARNote()
	{
		f_txt_ReturnValue := AutoFillPARMHACCALL() .  "`n`n"
		If (txtAdditionalNotes() != "")
			f_txt_ReturnValue .= txtAdditionalNotes() .  "`n`n"
		If (boolReqTherapyEDS())
			f_txt_ReturnValue .= getEDSProviderText(boolPtIsCaller(), txtCallerRelation(), txtCallerName(), boolReqTherapyEDS(), "therapist", txtReferralTherapyTo(), txtReferralTherapyBy(), txtReferralTherapyPOS(), txtReferralTherapyAddr(), txtReferralTherapyPhone(), txtReferralTherapyFax(), txtReferralTherapyNPI(), txtReferralTherapyTaxID()) .  "`n`n"
		If (boolReqPsychiatryEDS())
			f_txt_ReturnValue .= getEDSProviderText(boolPtIsCaller(), txtCallerRelation(), txtCallerName(), boolReqPsychiatryEDS(), "psychiatrist", txtReferralPsychiatryTo(), txtReferralPsychiatryBy(), txtReferralPsychiatryPOS(), txtReferralPsychiatryAddr(), txtReferralPsychiatryPhone(), txtReferralPsychiatryFax(), txtReferralPsychiatryNPI(), txtReferralPsychiatryTaxID()) .  "`n`n"
		If (boolReqPsychologyEDS())
			f_txt_ReturnValue .= getEDSProviderText(boolPtIsCaller(), txtCallerRelation(), txtCallerName(), boolReqPsychologyEDS(), "psychologist", txtReferralPsychologyTo(), txtReferralPsychologyBy(), txtReferralPsychologyPOS(), txtReferralPsychologyAddr(), txtReferralPsychologyPhone(), txtReferralPsychologyFax(), txtReferralPsychologyNPI(), txtReferralPsychologyTaxID()) .  "`n`n"
		
		If (txtGingerCoachingTracking() != "")
			f_txt_ReturnValue .= "Established patient with Ginger services the referral was submitted successfully with tracking number " . txtGingerCoachingTracking() . ".`n`n"
		If boolCalmMyStrength()
			f_txt_ReturnValue .= "Provided the patient information regarding complimentary digital self-help programs per their request."
		Return %f_txt_ReturnValue%
	}
	
AutoFillPARMHACCALL()
	{
		If (txtCallerPhone() != "") 			;Prefer the caller's phone number for callback #!
				txtNumber := txtCallerPhone()
		Else txtNumber := txtPtPhone()
		If (boolPtIsCaller())
		{
			txtIsPatientTheCaller := "Yes"
		}
		Else
			{
				txtIsPatientTheCaller := "No"
			}
	If (boolPtIsCaller())
		CallerRelationName := "Not Applicable"
		Else CallerRelationName := txtCallerRelation() . " (" . txtCallerName() . ")"
	If (boolReferralExists() or boolReferralExistsPsychiatry() or boolReferralExistsPsychology() or boolReferralExistsTherapy())
		{
			txtExistingRef := "Yes"
			txtExistingRefCSV := ""
			If (boolReferralExistsTherapy())
				txtExistingRefCSV .= "Therapy,"
			If (boolReferralExistsPsychiatry())
				txtExistingRefCSV .= "Psychiatry,"
			If (boolReferralExistsPsychology())
				txtExistingRefCSV .= "Psychology,"
			If (boolReferralExistsTherapy() or boolReferralExistsPsychiatry() or boolReferralExistsPsychology())
				txtExistingRef .= "; " . formatCSVWithCommasAnd(txtExistingRefCSV)
		}
		Else txtExistingRef := "No"
		
	;Mental Health:
	textMHACSolutions := ""
	If (boolReqTherapy())
		textMHACSolutions .= "MH Counseling, "
	If (boolReqPsychiatry())
		textMHACSolutions .= "Psychiatry/Med Management, "
	If (boolReqGH())
		textMHACSolutions .= "Gender Health, "
	If (boolReqED())
		textMHACSolutions .= "Eating Disorder, "
	If (boolReqMHIOP())
		textMHACSolutions .= "Mental Health Intensive Outpatient Program, "
	;OTHER
	If (boolReqPsychology() or boolReq3RDParty())
		{
			textMHACSolutions .= "Other: "
			If (boolReqPsychology())
				textMHACSolutions .= "Psychology/Psychological Testing, "
			If (boolReq3RDParty())
				textMHACSolutions .= "Third Party (Court, DUI, VA, CPS, L&I)"
		}
	If (textMHACSolutions = "")
		textMHACSolutions .= "Not Applicable"
		
	If (boolReqSUD())
		textSUDSolutions := "{SUDRFC:33606} "
		Else textSUDSolutions := "Not Applicable  "
	If boolPtIsMinor()
		txtScreeningNote :=
		( LTrim Comments
			"Screening Questions:
			""Has your child deliberately harmed themselves or others within the last week?"": " . intScreeningPHQ9() . "
			""Has your child been destroying or damaging things in your homes within the last week?"": " . intScreeningCSRA() . "
			""Is the current Mental Health concern related to Abuse?"": " . intScreeningGAD7()
		)
		Else txtScreeningNote :=
			( LTrim Comments
				"PHQ9 Score: " . intScreeningPHQ9() . "
				CSRA Score: " . intScreeningCSRA() . "
				GAD7 Score: " . intScreeningGAD7()
			)
	
		MHCCPARNote :=
			( LTrim Comments
				"Who is calling?
					`tPatient: yes/no: " . txtIsPatientTheCaller . "
					`tOther: " . CallerRelationName . " 
					`tCall back #: " . txtNumber . "

				Referral on file: yes/no: " . txtExistingRef . "

				Is pt active at MHW specialty clinic?: {yes/no:19077:::1}

				Reason for call:
					`tMental Health:  " . textMHACSolutions . " 
					`tSubstance Use:  " . textSUDSolutions . "
					
				Symptom/Concern: " . txtPtConcerns() . "

				" . txtScreeningNote . "

				Molina Verified: {Molina coverage:33152}

				MHAC Workflow Outcome: {Outcome:33154}"
			)
		Return MHCCPARNote
	}

getEDSProviderText(boolPtIsCaller, txtCallerRelation, txtCallerName, boolReqServiceEDS, txtReqSpecialist, txtReferralServiceTo, txtReferralServiceBy, txtReferralServicePOS, txtReferralServiceAddr, txtReferralServicePhone, txtReferralServiceFax, txtReferralServiceNPI, txtReferralServiceTaxID)    ; txtReqSpecialist := i.e. Psychiatrist
	{
		If (boolReqServiceEDS)
		{
			txtPtDidntKnow := ""
			fTextOut:= ""
			If (txtReferralServiceTo != "")
				fTextOut.= RegExReplace(txtReqSpecialist, "([A-z])(.+)", "$U1$L2") . ": " . txtReferralServiceTo . "`n"
				Else txtPtDidntKnow .= RegExReplace(txtReqSpecialist, "([A-z])(.+)", "$L1$L2") . "'s name,"
			If (txtReferralServiceBy != "")
				fTextOut.= "Referred By: " . txtReferralServiceBy . "`n"
				;Unnecessary Data don't list.
			If (txtReferralServicePOS != "")
				fTextOut.= "Care Site: " . txtReferralServicePOS . "`n"
				;Else txtPtDidntKnow .= "care-site name," ; I dont think its required to have the care site name.
			If (txtReferralServiceAddr != "")
				fTextOut.= "Address: " . txtReferralServiceAddr . "`n"
				Else txtPtDidntKnow .= "address,"
			If (txtReferralServicePhone != "")
				fTextOut.= "Phone: " . txtReferralServicePhone . "`n"
				Else txtPtDidntKnow .= "phone,"
			If (txtReferralServiceFax != "")
				fTextOut.= "Fax: " . txtReferralServiceFax . "`n"
				Else txtPtDidntKnow .= "fax,"
			If (txtReferralServiceNPI != "")
				fTextOut.= "NPI: " . txtReferralServiceNPI . "`n"
				Else txtPtDidntKnow .= "NPI,"
			If (txtReferralServiceTaxID != "")
				fTextOut.= "Tax ID: " . txtReferralServiceTaxID . "`n"
				Else txtPtDidntKnow .= "Tax ID"
			If (txtPtDidntKnow != "")
				{
					If (fTextOut != "")
						fTextOut.= "`n"
					If (boolPtIsCaller)
						fTextOut.= "The patient did not know the " . formatCSVWithCommasAnd(txtPtDidntKnow) . "."
						Else fTextOut.= "" . txtCallerRelation . " (" . txtCallerName . ") did not know the " . formatCSVWithCommasAnd(txtPtDidntKnow) . "."
				}
			fTextOut .= txt_EDSVerificationNote(RegExReplace(txtReqSpecialist, "^(.+)ist", "$1y"))
			Return % get_txt_RemovedPadding(fTextOut) ; Replace any whitespace preceding or at the end of the note!
		}
	}
txt_EDSVerificationNote(f_txt_ServiceName)
	{
		If (RegExMatch(txtReferral%f_txt_ServiceName%VerifStats(), "^Not Verified"))
				fTextOut := ""
				Else If (RegExMatch(txtReferral%f_txt_ServiceName%VerifStats(), "^Not Contracted"))
					fTextOut := "`nI verified the provider was not contracted via CPAN/FCH/CMS."
				Else fTextOut := "`nI verified the provider was contracted via " . txtReferral%f_txt_ServiceName%VerifStats() . "."
		Return %fTextOut%
	}
get_txt_RemovedPadding(ftxt)
	{
		Return % RegExReplace(ftxt, "^\s*(.+?)\s*$", "$1")
	}
	
formatCSVWithCommasAnd(txtList)
	{
		Loop, Parse, txtList, `,
			{	
				If (RegExMatch(A_LoopField, "\w"))
					{
						ftxtList .= A_LoopField . ","
						intItemCount += 1
					}
			}
		ftxtList := RegExReplace(ftxtList, ",$")
		Loop, Parse, ftxtList, `,
			{
				If (txtOutput = "")
					txtOutput := A_LoopField
				Else If (A_Index < intItemCount)
					txtOutput .= ", " . A_LoopField
				Else {
						If (intItemCount > 2)
							txtOutput .= ","
						txtOutput .= " and " . A_LoopField
					}
					
			}
		Return %txtOutput%
	}
	
Reset:
	WinGetPos, xpos, ypos, , , ahk_id %MainWindowID% ; 
	IniWrite, %xpos%, %A_ScriptName%, Settings, xpos
	IniWrite, %ypos%, %A_ScriptName%, Settings, ypos
	ResetAllVars()
	Gui, Destroy
	Goto, NoteTakingTrainer
	Return

PtCallerCB:
	Gui, Submit, NoHide
	if (boolPtIsCaller())
		{
			GuiControl, Hide, callreltxt
			GuiControl, Hide, CallerRelation
			GuiControl, Hide, callnametxt
			GuiControl, Hide, CallerName
			GuiControl, Hide, txtPtEmail2
			GuiControl, Hide, PtEmail2
			GuiControl, Hide, textCallerNumber
			GuiControl, Hide, CallerNumber
			GuiControl, Hide, textCallerSegment
			GuiControl, Hide, boolCallerROI
			GuiControl, Show, PNGKPLogo
		}
	Else
		{
			GuiControl, Show, callreltxt
			GuiControl, Show, CallerRelation
			GuiControl, Show, callnametxt
			GuiControl, Show, CallerName
			GuiControl, Show, txtPtEmail2
			GuiControl, Show, PtEmail2
			GuiControl, Show, textCallerNumber
			GuiControl, Show, CallerNumber
			GuiControl, Show, textCallerSegment
			GuiControl, Show, boolCallerROI
			GuiControl, Hide, PNGKPLogo
		}
	Return

ResetAllVars() 
	{
		Global
		CallerName			:= ""
		CallerRelation		:= ""
		CallerRelationName	:= ""
		callnametxt			:= ""
		callreltxt			:= ""
		CareConcerns		:= ""
		IsAuth				:= ""
		isModerate			:= ""
		IsPtCaller			:= ""
		IsPsychiatry		:= ""
		IsPsychology		:= ""
		isRoutine			:= ""
		IsTherapy			:= ""
		isEmergent			:= ""
		PtEmail1			:= ""
		PtEmail2			:= ""
		ptFirstName			:= ""
		ptInitials			:= ""
		ptMRN				:= ""
		ptNumber			:= ""
		PtProvider			:= ""
		referprovnote		:= ""
		ReqProvider			:= ""
		ScreenResult		:= ""
		boolPtIsCaller("") . boolPtIsMinor("") . boolReferralExists("") . boolReferralExistsPsychiatry("") . boolReferralExistsPsychology("") . boolReferralExistsTherapy("") . boolReq3RDParty("") . boolReqED("") . boolReqGH("") . boolReqMHIOP("")

		boolReqPsychiatryEDS(0) . boolReqPsychiatryIDS(0) . boolReqPsychiatryMagellan(0) . boolReqPsychiatryModerate(0) . boolReqPsychiatry(0)
		boolReqPsychologyEDS(0) . boolReqPsychologyIDS(0) . boolReqPsychologyMagellan(0) . boolReqPsychology(0)

		boolReqSUD("")

		boolReqTherapyEDS(0) . boolReqTherapyIDS(0) . boolReqTherapyMagellan(0) . boolReqTherapyMHCCIntake(0) . boolReqTherapyModerate(0) . boolReqTherapy(0)

		csvPtConcernCPTs("") ;This CSV is actually $ separated.
		csvSolutionsMHCC("")
		intScreeningCSRA("") . intScreeningGAD7("") . intScreeningPHQ9("") . txtAdditionalNotes("") . txtCallerName("") . txtCallerPhone("") . txtCallerRelation("") . boolCallerROI("")
		txtDebugMessages("") . txtPtAge("") . txtPtConcerns("") . txtPtDOB("") . txtPtEmail("") . txtPtEmail2("") . txtPtMRN("") . txtPtName("")
		txtPtNameInitials("")
		txtPtNamePref("") . txtPtPhone("") . txtReferralPsychiatryBy("") . txtReferralPsychiatryTo("") . txtReferralPsychiatryPOS("") . txtReferralPsychiatryAddr("") . txtReferralPsychiatryPhone("") . txtReferralPsychiatryFax("") . txtReferralPsychiatryNPI("") . txtReferralPsychiatryTaxID("") . txtReferralPsychologyBy("") . txtReferralPsychologyTo("") . txtReferralPsychologyPOS("") . txtReferralPsychologyAddr("") . txtReferralPsychologyPhone("") . txtReferralPsychologyFax("") . txtReferralPsychologyNPI("") . txtReferralPsychologyTaxID("") . txtReferralTherapyBy("") . txtReferralTherapyTo("") . txtReferralTherapyPOS("") . txtReferralTherapyAddr("") . txtReferralTherapyPhone("") . txtReferralTherapyFax("") . txtReferralTherapyNPI("") . txtReferralTherapyTaxID("") . txtScreeningResult("")
		boolCalmMyStrength("") . txtGingerCoachingTracking("")
	}

InjectEncounterValues() ;NEW
	{
		Global
		If WinActive("KPWA Production")
			{
				Send .namemrn{Enter}
				Clipboard := "" ; Reset the Clipboard.
				loopInitialTime := A_TickCount
				loopSeconds := 5 ; 5 Seconds after now the loop needs to stop.
				While (RegExMatch(Clipboard, "[A-z0-9]") = 0 and A_TickCount - loopInitialTime < loopSeconds * 1000)
					{
						Send ^a^c 			;Put the dot phrase in the clipboard for later.
					}
				Send ^a{Backspace}
				PtNameMRN := Clipboard
				Loop, Parse, PtNameMRN, `,
					{
						If (A_Index = 1)
							{
								Loop, Parse, A_LoopField, %A_Space% ;parse for space
									{
										If  (A_Index = 1)
											{
												txtPtNamePref(A_LoopField)
												txtPtName("") . txtPtNameInitials("") ;Reset these to ensure initialized!
											}
										txtPtName(txtPtName() . A_LoopField . " ")
										txtPtNameInitials(txtPtNameInitials() . SubStr(A_LoopField, 1, 1) . ".")
									}
							}
						If (A_Index = 2)
							{
								txtPtMRN(SubStr(A_LoopField, 3, 8))
							}
					}
				PtMRNInitials := txtPtMRN() . " " . txtPtNameInitials()
				
				Send .prefname{Enter}
				Clipboard := "" ; Reset the Clipboard.
				loopInitialTime := A_TickCount
				loopSeconds := 5 ; 5 Seconds after now the loop needs to stop.
				While (RegExMatch(Clipboard, "[A-z0-9]") = 0 and A_TickCount - loopInitialTime < loopSeconds * 1000)
					{
						Send ^a^c 			;Put the dot phrase in the clipboard for later.
					}
				Send ^a{Backspace}
				StringReplace, Clipboard, Clipboard, `n, , All
				StringReplace, Clipboard, Clipboard, `r, , All
				StringReplace, Clipboard, Clipboard, %A_Space%, , All
				If (Clipboard != "")
					txtPtNamePref(Clipboard)
				
				Send .phone2{Enter}
				Clipboard := "" ; Reset the Clipboard.
				loopInitialTime := A_TickCount
				loopSeconds := 5 ; 5 Seconds after now the loop needs to stop.
				While (RegExMatch(Clipboard, "[A-z0-9]") = 0 and A_TickCount - loopInitialTime < loopSeconds * 1000)
					{
						Send ^a^c 			;Put the dot phrase in the clipboard for later.
					}
				Send ^a{Backspace}
				StringReplace, Clipboard, Clipboard, `n, , All
				StringReplace, Clipboard, Clipboard, `r, , All
				txtPtPhone(Clipboard)

				Send .email{Enter}
				Clipboard := "" ; Reset the Clipboard.
				loopInitialTime := A_TickCount
				loopSeconds := 5 ; 5 Seconds after now the loop needs to stop.
				While (RegExMatch(Clipboard, "[A-z0-9]") = 0 and A_TickCount - loopInitialTime < loopSeconds * 1000)
					{
						Send ^a^c 			;Put the dot phrase in the clipboard for later.
					}
				Send ^a{Backspace}
				StringReplace, Clipboard, Clipboard, `n, , All
				StringReplace, Clipboard, Clipboard, `r, , All
				txtPtEmail(Clipboard)
				Clipboard := "" ; Reset the Clipboard.

				Send .dob{Enter}
				Clipboard := "" ; Reset the Clipboard.
				loopInitialTime := A_TickCount
				loopSeconds := 5 ; 5 Seconds after now the loop needs to stop.
				While (RegExMatch(Clipboard, "[A-z0-9]") = 0 and A_TickCount - loopInitialTime < loopSeconds * 1000)
					{
						Send ^a^c 			;Put the dot phrase in the clipboard for later.
					}
				Send ^a{Backspace}
				StringReplace, Clipboard, Clipboard, `n, , All
				StringReplace, Clipboard, Clipboard, `r, , All
				txtPtDOB(Clipboard)

				Send .age{Enter}
				Clipboard := "" ; Reset the Clipboard.
				loopInitialTime := A_TickCount
				loopSeconds := 5 ; 5 Seconds after now the loop needs to stop.
				While (RegExMatch(Clipboard, "[A-z0-9]") = 0 and A_TickCount - loopInitialTime < loopSeconds * 1000)
					{
						Send ^a^c 			;Put the dot phrase in the clipboard for later.
					}
				Send ^a{Backspace}
				StringReplace, Clipboard, Clipboard, `n, , All
				StringReplace, Clipboard, Clipboard, `r, , All
				StringReplace, Clipboard, Clipboard, year old, , All
				StringReplace, Clipboard, Clipboard, %A_Space%, , All
				txtPtAge(Clipboard)
				Gui, Submit, NoHide
				If (txtPtAge() >= 18)
					boolPtIsMinor(0)
				If (txtPtAge() < 18)
					boolPtIsMinor(1)
					
				GoSub, GUIRefresh
			}
	}

IfPtLookupResetVars:
	If (WinExist("Patient Lookup") != "0x0")
		{
			WinWaitClose, Patient Lookup
			SetTimer, IfPtLookupResetVarsMoveMsgBox, 50
			SetTimer, UnFocusMsgBox, 75
			LastActiveWin := WinExist("A")
			Gui +OwnDialogs
			MsgBox, 4, New Patient Lookup was detected, Would you like to reset?
			Gui -OwnDialogs
			IfMsgBox, No
				Return
			Else
				{
					ResetAllVars()
					Gui, Destroy
					Goto, NoteTakingTrainer
				}
		}
	Return

UnFocusMsgBox:
SetTimer, UnFocusMsgBox, Off
WinActivate, ahk_id %LastActiveWin%
Return
IfPtLookupResetVarsMoveMsgBox:
	ID := WinExist("New Patient Lookup was detected")
	IfWinNotExist, ahk_id %ID%
		SetTimer, IfPtLookupResetVarsMoveMsgBox, Off
	;IniRead, xpos, %A_ScriptName%, Settings, xpos
	;IniRead, ypos, %A_ScriptName%, Settings, ypos
	WinGetPos, xpos, ypos, wpos, hpos, ahk_id %MainWindowID% ; 
	WinGetPos, x2pos, y2pos, w2pos, h2pos, ahk_id %ID% ; 
	xc := ((wpos - w2pos) / 2) + xpos
	yc := ((hpos - h2pos) / 2) +ypos
	WinMove, ahk_id %ID%,, %xc%, %yc%	; move the MsgBox
	Return
	
ExitSub:
GuiClose:
	WinGetPos, xpos, ypos, , , ahk_id %MainWindowID% ; 
	IniWrite, %xpos%, %A_ScriptName%, Settings, xpos
	IniWrite, %ypos%, %A_ScriptName%, Settings, ypos
	ExitApp
	
	
eventScreeningResult:
EventAdultorMinor:
	Gui, Submit, NoHide
	If boolPtIsMinor() 
		{
			GuiControl, , txtptPHQ9Score, Harmed Self/Others?
			GuiControl, , txtptCSRAScore, Damaging things?
			GuiControl, , txtptGAD7Score, Related to abuse?
		}
		Else  
			{
				GuiControl, , txtptPHQ9Score, PHQ9 Score:
				GuiControl, , txtptCSRAScore, CSRA Score:
				GuiControl, , txtptGAD7Score, GAD7 Score:
			}
	If boolPtIsMinor()
		If (intScreeningPHQ9() != "" or intScreeningCSRA() != "" or intScreeningGAD7() != "")
			GuiControl, , txtScreeningResult, |Mild|Routine|Moderate|Emergent||
	GuiControl, , PsychiatryReq, % "|" . PsychiatristSolutionSelection()
	GuiControl, , TherapyReq, % "|" . TherapistSolutionSelection()
	GuiControl, , PsychologyReq, % "|" . PsychologistSolutionSelection()
	Return
	
Edit_SetCueBanner(hEdit, sText, bFocusShow=0)
	{
		OEL := ErrorLevel
		VarSetCapacity( wText, 2 * len := StrLen( sText ) + 1, 0 )
	   DllCall("kernel32\MultiByteToWideChar", "UInt", 65001, "UInt", 0
		  , "Str", sText, "Int", -1, "Str", wText, "Int", len )
	   SendMessage, 0x1501, bFocusShow, &wText, , ahk_id %hEdit%
	   Return ErrorLevel+0, ErrorLevel := OEL
	}

PsychiatristSolutionSelection()
	{
		If boolReqPsychiatryEDS()
			Return %  RegExReplace(TXTSolutionListPsychiatry(boolPtIsMinor(), txtScreeningResult()), "(\|+EDS[^|]*)\|*","$1||")
		If boolReqPsychiatryIDS()
			Return %  RegExReplace(TXTSolutionListPsychiatry(boolPtIsMinor(), txtScreeningResult()), "(\|+IDS[^|]*)\|*","$1||")
		If boolReqPsychiatryMagellan()
			Return %  RegExReplace(TXTSolutionListPsychiatry(boolPtIsMinor(), txtScreeningResult()), "(\|+Magellan[^|]*)\|*", "$1||")
		If boolReqPsychiatryModerate()
			Return %  RegExReplace(TXTSolutionListPsychiatry(boolPtIsMinor(), txtScreeningResult()), "(\|+IDS[^|]*)\|*", "$1||")
		If (boolReqPsychiatry() = 0)
			{
				Return %  RegExReplace(TXTSolutionListPsychiatry(boolPtIsMinor(), txtScreeningResult()), "(\|*Not Requested[^|]*)\|*", "$1||")
			}
	}
PsychologistSolutionSelection()
	{
		If boolReqPsychologyEDS()
			Return %  RegExReplace(TXTSolutionListPsychology(boolPtIsMinor(), txtScreeningResult()), "(\|+EDS[^|]*)\|*","$1||")
		If boolReqPsychologyIDS()
			Return %  RegExReplace(TXTSolutionListPsychology(boolPtIsMinor(), txtScreeningResult()), "(\|+IDS[^|]*)\|*","$1||")
		If boolReqPsychologyMagellan()
			Return %  RegExReplace(TXTSolutionListPsychology(boolPtIsMinor(), txtScreeningResult()), "(\|+Magellan[^|]*)\|*", "$1||")
		If (boolReqPsychology() = 0)
			{
				Return %  RegExReplace(TXTSolutionListPsychology(boolPtIsMinor(), txtScreeningResult()), "(\|*Not Requested[^|]*)\|*", "$1||")
			}
	}
TherapistSolutionSelection()
	{
		If boolReqTherapyEDS()
			Return %  RegExReplace(TXTSolutionListTherapy(boolPtIsMinor(), txtScreeningResult()), "(\|+EDS[^|]*)[|]*","$1||")
		If boolReqTherapyIDS()
			Return %  RegExReplace(TXTSolutionListTherapy(boolPtIsMinor(), txtScreeningResult()), "(\|+IDS[^|]*)\|*","$1||")
		If boolReqTherapyMagellan()
			Return %  RegExReplace(TXTSolutionListTherapy(boolPtIsMinor(), txtScreeningResult()), "(\|+Magellan[^|]*)\|*", "$1||")
		If boolReqTherapyMHCCIntake()
			Return %  RegExReplace(TXTSolutionListTherapy(boolPtIsMinor(), txtScreeningResult()), "(\|+MHCC Intake[^|]*)\|*", "$1||")
		If boolReqTherapyModerate()
			Return %  RegExReplace(TXTSolutionListTherapy(boolPtIsMinor(), txtScreeningResult()), "(\|+MHCC Intake[^|]*)\|*", "$1||")
		If (boolReqTherapy() = 0)
			{
				Return %  RegExReplace(TXTSolutionListTherapy(boolPtIsMinor(), txtScreeningResult()), "(\|*Not Requested[^|]*)\|*", "$1||")
			}
	}

SendGUItoVars:
	Gui, Submit, NoHide
	boolPtIsCaller(IsPtCaller) . boolPtIsMinor(boolPtMinor) . boolReferralExists(IsExistingRef) . boolReferralExistsPsychiatry(boolRefExistsPsychiatry) . boolReferralExistsPsychology(boolRefExistsPsychology) . boolReferralExistsTherapy(boolRefExistsTherapy) . boolReq3RDParty(Is3RDParty) . boolReqED(IsED) . boolReqGH(IsGH) . boolReqMHIOP(IsMHIOP)

	boolReqPsychiatryEDS(RegExMatch(PsychiatryReq, "^EDS"))
	boolReqPsychiatryIDS(RegExMatch(PsychiatryReq, "^IDS"))
	boolReqPsychiatryMagellan(RegExMatch(PsychiatryReq, "^Magellan"))
	
	If (RegExMatch(txtScreeningResult, "Moderate"))
		{
			boolReqPsychiatryModerate(RegExMatch(PsychiatryReq, "^IDS"))
		}
		Else boolReqPsychiatryModerate(0)
	boolReqPsychiatry(RegExMatch(PsychiatryReq, "^EDS|^IDS|^Magellan"))
	
	boolReqPsychologyEDS(RegExMatch(PsychologyReq, "^EDS"))
	boolReqPsychologyIDS(RegExMatch(PsychologyReq, "^IDS"))
	boolReqPsychologyMagellan(RegExMatch(PsychologyReq, "^Magellan"))
	boolReqPsychology(RegExMatch(PsychologyReq, "^EDS|^IDS|^Magellan"))

	boolReqSUD(IsSUD)

	boolReqTherapyEDS(RegExMatch(TherapyReq, "^EDS"))
	boolReqTherapyIDS(RegExMatch(TherapyReq, "^IDS"))
	boolReqTherapyMagellan(RegExMatch(TherapyReq, "^Magellan"))
	boolReqTherapyMHCCIntake(RegExMatch(TherapyReq, "^MHCC Intake"))
	If (RegExMatch(txtScreeningResult, "Moderate"))
		{
			boolReqTherapyModerate(RegExMatch(TherapyReq, "^MHCC Intake"))
		}
		Else boolReqTherapyModerate(0)
	boolReqTherapy(RegExMatch(TherapyReq, "^EDS|^IDS|^Magellan|^MHCC Intake"))
	
		
	csvPtConcernCPTs() ;This CSV is actually $ separated.
	csvSolutionsMHCC()

	intScreeningCSRA(ptCSRAScore) . intScreeningGAD7(ptGAD7Score) . intScreeningPHQ9(ptPHQ9Score) . txtAdditionalNotes(AdditionalNotes) . txtCallerName(CallerName) . txtCallerPhone(CallerNumber) . txtCallerRelation(CallerRelation) . boolCallerROI(boolCallerROI)

	txtDebugMessages(txtDebugMessages) . txtPtAge(ptAge) . txtPtConcerns(CareConcerns) . txtPtDOB(ptDOB) . txtPtEmail(PtEmail1) . txtPtEmail2(PtEmail2) . txtPtMRN(ptMRN) . txtPtName(ptName)

	txtPtNameInitials()

	txtPtNamePref(ptNamePref) . txtPtPhone(ptNumber) . txtReferralPsychiatryBy(PsychiatryRefBy) . txtReferralPsychiatryTo(PsychiatryRefTo) . txtReferralPsychiatryPOS(PsychiatryRefPOS) . txtReferralPsychiatryAddr(PsychiatryRefAddr) . txtReferralPsychiatryPhone(PsychiatryRefTele) . txtReferralPsychiatryFax(PsychiatryRefFax) . txtReferralPsychiatryNPI(PsychiatryRefNPI) . txtReferralPsychiatryTaxID(PsychiatryRefTaxID) . txtReferralPsychologyBy(PsychologyRefBy) . txtReferralPsychologyTo(PsychologyRefTo) . txtReferralPsychologyPOS(PsychologyRefPOS) . txtReferralPsychologyAddr(PsychologyRefAddr) . txtReferralPsychologyPhone(PsychologyRefTele) . txtReferralPsychologyFax(PsychologyRefFax) . txtReferralPsychologyNPI(PsychologyRefNPI) . txtReferralPsychologyTaxID(PsychologyRefTaxID) . txtReferralTherapyBy(TherapyRefBy) . txtReferralTherapyTo(TherapyRefTo) . txtReferralTherapyPOS(TherapyRefPOS) . txtReferralTherapyAddr(TherapyRefAddr) . txtReferralTherapyPhone(TherapyRefTele) . txtReferralTherapyFax(TherapyRefFax) . txtReferralTherapyNPI(TherapyRefNPI) . txtReferralTherapyTaxID(TherapyRefTaxID) . txtScreeningResult(txtScreeningResult)
	txtReferralTherapyVerifStats(TherapyVerifStats) . txtReferralPsychiatryVerifStats(PsychiatryVerifStats) . txtReferralPsychologyVerifStats(PsychologyVerifStats)
	txtGingerCoachingTracking(txtGingerCoachingTracking)
	boolCalmMyStrength(boolCalmMyStrength)
	Return

SendVarstoGUI:
	Gui, Submit, NoHide
	IsPtCaller := boolPtIsCaller()
	boolCallerROI := boolCallerROI()
	boolPtMinor:= boolPtIsMinor()
	IsExistingRef := boolReferralExists()
	boolRefExistsPsychiatry := boolReferralExistsPsychiatry()
	boolRefExistsPsychology := boolReferralExistsPsychology()
	boolRefExistsTherapy := boolReferralExistsTherapy()
	Is3RDParty := boolReq3RDParty()
	IsED := boolReqED()
	IsGH := boolReqGH()
	IsMHIOP := boolReqMHIOP()

	boolReqPsychiatry()
	boolReqPsychiatryEDS()
	boolReqPsychiatryIDS()
	boolReqPsychiatryMagellan()
	boolReqPsychiatryModerate()
	boolReqPsychology()
	boolReqPsychologyEDS()
	boolReqPsychologyIDS()
	boolReqPsychologyMagellan()

	IsSUD := boolReqSUD()

	boolReqTherapy()
	boolReqTherapyEDS()
	boolReqTherapyIDS()
	boolReqTherapyMagellan()
	boolReqTherapyMHCCIntake()
	boolReqTherapyModerate()

	csvPtConcernCPTs() ;This CSV is actually $ separated.
	csvSolutionsMHCC()

	ptCSRAScore := intScreeningCSRA()
	ptGAD7Score := intScreeningGAD7()
	ptPHQ9Score := intScreeningPHQ9()
	AdditionalNotes := txtAdditionalNotes()
	CallerName := txtCallerName()
	CallerNumber := txtCallerPhone()
	CallerRelation := txtCallerRelation()

	txtDebugMessages := txtDebugMessages()
	ptAge := txtPtAge()
	CareConcerns := txtPtConcerns()
	ptDOB := txtPtDOB()
	PtEmail1 := txtPtEmail()
	PtEmail2 := txtPtEmail2()
	ptMRN := txtPtMRN()
	ptName := txtPtName()

	txtPtNameInitials()

	ptNamePref := txtPtNamePref()
	ptNumber := txtPtPhone()
	PsychiatryRefBy := txtReferralPsychiatryBy()
	PsychiatryRefTo := txtReferralPsychiatryTo()
	PsychiatryRefPOS := txtReferralPsychiatryPOS()
	PsychiatryRefAddr := txtReferralPsychiatryAddr()
	PsychiatryRefTele := txtReferralPsychiatryPhone()
	PsychiatryRefFax := txtReferralPsychiatryFax()
	PsychiatryRefNPI := txtReferralPsychiatryNPI()
	PsychiatryRefTaxID := txtReferralPsychiatryTaxID()
	PsychologyRefBy := txtReferralPsychologyBy()
	PsychologyRefTo := txtReferralPsychologyTo()
	PsychologyRefPOS := txtReferralPsychologyPOS()
	PsychologyRefAddr := txtReferralPsychologyAddr()
	PsychologyRefTele := txtReferralPsychologyPhone()
	PsychologyRefFax := txtReferralPsychologyFax()
	PsychologyRefNPI := txtReferralPsychologyNPI()
	PsychologyRefTaxID := txtReferralPsychologyTaxID()
	TherapyRefBy := txtReferralTherapyBy()
	TherapyRefTo := txtReferralTherapyTo()
	TherapyRefPOS := txtReferralTherapyPOS()
	TherapyRefAddr := txtReferralTherapyAddr()
	TherapyRefTele := txtReferralTherapyPhone()
	TherapyRefFax := txtReferralTherapyFax()
	TherapyRefNPI := txtReferralTherapyNPI()
	TherapyRefTaxID := txtReferralTherapyTaxID()
	TherapyVerifStats:= txtReferralTherapyVerifStats()
	PsychiatryVerifStats := txtReferralPsychiatryVerifStats()
	PsychologyVerifStats := txtReferralPsychologyVerifStats()
	
	txtScreeningResult := txtScreeningResult()
	txtGingerCoachingTracking := txtGingerCoachingTracking()
	boolCalmMyStrength := boolCalmMyStrength()
	Return
	
; template - required
;  xpos and ypos will be updated when "GuiClose" is executed
/*
[settings]
xpos=662
ypos=377
[EDSGUI]
xpos=1626
ypos=385
*/
