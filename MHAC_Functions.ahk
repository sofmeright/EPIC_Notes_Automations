#SingleInstance Force
#Include %A_ScriptDir%\MHAC_VariableDeclarations.ahk
;ExitApp ; This is not code we would like to exectute so escape if trying to execute.
;All CSV Separated by $ alternatively to `,
CheckDSBS(DSBSPW, KPMRN)
	{
		LastActiveWin := WinExist("A")
		Run, microsoft-edge:http://ghp1:3915/GHCWEB/CZ920HL.html
		WinWaitActive, DSBS I&E, , 7
			If ErrorLevel
				{
					WinWaitActive, Windows Security, , 7
						If ErrorLevel = 0
							{
								Send %DSBSPW%{Tab}{Tab}{Enter} ; Send %DSBSPW%{Tab}{Space}{Tab}{Enter} ; Old method was unchecking the remember info box. ; Perhaps eventually will full auto log and pw?
								WinWaitActive, DSBS I&E, , 5
									If ErrorLevel ; If it is still not logged in abort!
										{
											;MsgBox DSBD Timed Out...
											WinActivate, ahk_id %LastActiveWin%
											Return ; If failed to login abort DSBS.
										}
							}
						Else Return ; If something is really going wrong escape!
				}
			; Else ; If DSBS already signed in?
		WinActivate, DSBS I&E
		WinWaitActive, DSBS I&E, , 4
			If ErrorLevel = 0 ; If DSBS is working right!
				{
					loopInitialTime := A_TickCount
					loopSeconds := 5 ; 5 Seconds after now the loop needs to stop.
					While (A_TickCount - loopInitialTime < loopSeconds * 1000)
						{
							ImageSearch, fx,fy,0,0, a_screenWidth, a_screenHeight, %A_ScriptDir%\resource\Button_DSBS_IAgree.jpg
								If (ErrorLevel != 1 and ErrorLevel != 2)
									{
										Click %fx% %fy%
										Break
									}
						}
					loopInitialTime := A_TickCount
					loopSeconds := 5 ; 5 Seconds after now the loop needs to stop.
					While (A_TickCount - loopInitialTime < loopSeconds * 1000)
						{
							ImageSearch, fx,fy,0,0, a_screenWidth, a_screenHeight, %A_ScriptDir%\resource\TXT-DSBS-Screen-Eligibility_Coverage.png
								If (ErrorLevel != 1 and ErrorLevel != 2)
									{
										Send %KPMRN%{Enter}
										Break
									}
						}
					Sleep, 500
					;MsgBox, Take a moment to review coverage.
				}
		;Else MsgBox DSBD Timed Out...
		WinActivate, ahk_id %LastActiveWin%
	}
TxtCPTCodeCSVFromSymptoms(getcptcodesin) ; Get CPT codes from a text list of symptoms
	{
		getcptcodestrings := ""
		StringReplace, getcptcodesin, getcptcodesin, %space%and%space%, $, All
		StringReplace, getcptcodesin, getcptcodesin, `,, $, All
		StringReplace, getcptcodesin, getcptcodesin, ., $, All
		Loop, Parse, getcptcodesin, $
			{
				;MsgBox, % A_LoopField
				If (A_LoopField = "" or A_LoopField = " ")
					Continue
				if (getcptcodestrings != "")
					getcptcodestrings .= "$"	
				IfInString, A_LoopField, anxiety
					{
						IfNotInString, getcptcodestrings, F41.9
							getcptcodestrings .= "F41.9"
					}
				Else If (RegExMatch(A_LoopField, "\bADD\b") != 0 or RegExMatch(A_LoopField, "\bADHD\b") != 0)
					{	
						IfNotInString, getcptcodestrings, F90.9
							getcptcodestrings .= "F90.9"
					}
				Else IfInString, A_LoopField, Bipolar
					{	
						IfNotInString, getcptcodestrings, F31.9
							getcptcodestrings .= "F31.9"
					}
				Else IfInString, A_LoopField, Depress
					{
						IfNotInString, getcptcodestrings, F32.9
							getcptcodestrings .= "F32.9"
					}
				Else IfInString, A_LoopField, OCD
					{	
						IfNotInString, getcptcodestrings, F91.9
							getcptcodestrings .= "F91.9"
					}
				Else If (InStr(A_LoopField, "PTSD") != 0 or InStr(A_LoopField, "Trauma") != 0)
					{	
						IfNotInString, getcptcodestrings, F43.10
							getcptcodestrings .= "F43.10"
					}
				Else If (RegExMatch(A_LoopField, "\bED\b") != 0 or InStr(A_LoopField, "Eating Disorder") != 0)
					{
						IfNotInString, getcptcodestrings, F50.9
							getcptcodestrings .= "F50.9"
					}
				Else IfInString, A_LoopField, Stress
					{	
						IfNotInString, getcptcodestrings, F43.9
							getcptcodestrings .= "F43.9"
					}
				Else IfNotInString, getcptcodestrings, F43.20
					{	
						IfNotInString, getcptcodestrings, F43.20
							getcptcodestrings .= "F43.20"
					}
			}
		Return getcptcodestrings
	}
TxtEmailBodyDigitalCare()
	{
		return "The following information is regarding complimentary digital self-help programs that we offer for members 18 years of age or older; Calm and myStrength. You can self-refer to these services by using the instructions below.`n`nCalm`nCalm is an app that uses meditation and mindfulness to improve sleep, decrease stress, and reduce anxiety. It includes guided meditations, calming sounds, programs taught by world-renowned experts, sleep stories, and mindful movement videos.`n`nYou can choose from many meditations for specific situations or just select the ""Daily Calm"" on your home screen. It may take some practice to see results, but over time, mindfulness can offer benefits to your health and wellbeing, and help you build resilience.`n`n**Please use the URL below to create an account. Do not sign up for the 7-day free trial through the app.**`n`n1.	From a web browser, go to www.kp.org/wa/mhw to access Calm for the first time.`n2.	Click the Get Calm button and sign in to kp.org with your user ID and password.`n3.	You'll be asked if you have a Calm account.`n4.	To create a new account with Calm, enter your email address, a password, and your first name, and click Sign Up.`n5.	If you have a Calm account, you will be asked to log in.  If you currently have a free Calm account, you'll get access to the premium subscription for free. If you already have premium access, you can sign up using KP instructions when your existing subscription has expired to receive the benefit.`n`nOnce you accept Calm's terms of use, you will get access to Calm Premium for free for 12 months. You can start using the Calm in your web browser or download the mobile app on your smartphone and sign in with the email and password you created at sign up.`n`nmyStrength`nmyStrength is an online program that teaches skills for mental health and wellbeing.  myStrength has guided focus areas for many common life challenges like stress, anxiety, sleep, chronic pain, and depression. You can track preferences and goals, current emotional states, and ongoing life events to improve your awareness and change behaviors. There is also a large library of activities you can browse and use as needed.`n`nThis program is available to you, at no cost.   Use it as often as you want. The more you do, the more personalized the experience will become. Explore activities and techniques that can benefit anyone - they can help you build resilience and set goals.`n`nHow to get started:`n`n1.	On a desk or laptop, use your web browser, go to kp.org/wa/mhw`n2.	Click on the Get myStrength button and sign into kp.org with your Member ID and Password.`n3.	Select Continue to myStrength.com link and register for myStrength.`n`nOnce signed up, use myStrength anytime on your mobile device or tablet through the app or browser or on your computer at mystrength.com."
	}
TxtEmailBodyEDSList(txtName,txtAge,txtPhone,txtRequestedSvcs, txtMHConcern)
	{
		If (txtName = "")
			txtName := "XXXXXXXX"
		If (txtAge = "")
			txtAge := "XX"
		If (txtPhone = "")
			txtPhone := "xxx-xxx-xxxx"
		return,
		( LTrim Comments
		"Per our recent conversation I wanted to provide some materials to assist with your search for an external provider.

		There are different ways to access External providers
		" . A_Tab . "KP Provider Directory, First Choice Health Network, Psychology Today

		KP Provider Directory
		Please copy the following URL and paste it into your browser for a list of therapists contracted with Kaiser Permanente:
		https://wa-doctors.kaiserpermanente.org/?network_id=9&locale=en_us&ci=kaiserpermanente
		Please filter by your zip code and insurance to find the best possible options for you.
		Tips - do not sign in to the provider directory or it will only show you HMO providers.
		NOTE: We are referring you to a contracted provider outside of our Kaiser Permanente clinics.  When searching the provider directory, skip over any provider that has a KP address, (those are the KP Clinic providers and for this purpose we are not wanting to schedule with them). 

		First Choice
		Please copy the following URL and paste it into your browser to access the First Choice Health Network provider directory: 
		https://www.fchn.com/ProviderSearch
		TIPS:  When searching on this website try both provider's name and the name of their therapy practice.
		Use ALL CAPS when entering name of city - in your search. 
		 
		Psychology Today
		Please copy the following URL and paste it into your browser to search for a provider via Psychology Today:
		https://www.psychologytoday.com/us
		This website allows us to search for providers with a little more information.
		Be sure to verify with the provider that they accept your Core Kaiser plan.

		Once you have located a handful of providers you think may be a good fit - and you confirm are contracted with KP and/or FCHN - call to see who may have availability that matches yours.  I would suggest calling approximately 10 providers and leaving a brief message- example would be:
		""Hi, my name is " . txtName . " - I am a " . txtAge . " year old needing access to " . txtRequestedSvcs . " services related to " . txtMHConcern . ". My phone number is: " . txtPhone . " - please let me know if you might be a good fit/have availability OR have a Waitlist..""

		Then reply to this MyChart message with the following information:
		- Name of provider and/or business
		- Address of provider
		- Telephone number of provider
		If First Choice Health provider, please also include:
		- Tax ID
		- NPI #
		 
		If you have any questions, feel free to reply to this message or you can reach out to us at 888-287-2680 or 206-630-1680 - we are available Monday-Friday from 8am to 5pm."
		)
	}
TxtEmailBodyMagellanFU()
	{
		return "Per our conversation I wanted to send you some details on how to follow up with Magellan to expedite the process of them finding your appointment. If you have not heard from them within 10-business days (" . TxtMonthandDayXDaysFromNow(14) . "), reach out and request an update on your referral at 800-424-4493, option number 2. All emails from Magellan will come from kpwareferralinquiry@magellanhealth.com."
	}
TxtEmailGreeting(txtPtFirstName, txtCallerName)
	{
		If (txtCallerName != "")
			{
				StringReplace, txtCallerName, txtCallerName, `,%A_Space%, `,
				IfInString, txtCallerName, `, ; If Last, First then get all characters after the first name.
					Loop, parse, txtCallerName, `,
						{
							If (A_Index = 2)
								txtCallerName := A_LoopField
						}
				Loop, parse, txtCallerName, %A_Space% ; If there is a middle name only get the first name!
					{
						If (A_Index = 1)
							txtCallerName := A_LoopField
					}
				Return "Good " . TxtMorningAfternoonOrEvening() . " " . txtPtFirstName . " and/or " . txtCallerName . ", `n`n"
			}
		Return "Good " . TxtMorningAfternoonOrEvening() . " " . txtPtFirstName . ", `n`n"
	}
TxtEmailSalutation(RepName,RepTitle,RepPhone,RepEmail) ; TxtEmailSalutation("Kai Hamilton","Patient Access Representative","206-630-1680","kai.l.hamilton@kp.org")
	{
		return "`n`nWarm regards,`n`n" . RepName . "`n"  . RepTitle . "`nMental Health Access Center`n1200 SW 27th Street, Renton WA 98057`nGlacier Building`nMHAC: " . RepPhone . "`nEmail: " . RepEmail
	}
TxtListOfRequestedServices(boolPyschiatry, boolTherapy, boolPyschology) ; TxtListOfRequestedServices(IsPyschiatry, IsTherapy, IsPyschology)
	{
		fServices := ""
		If (boolPyschiatry = 1)
			fServices .= "psychiatry"
		If (boolTherapy = 1) 
			{
				If (fServices != "") 
					fServices .= "/"
				fServices .= "therapy"
			}
		If (boolPyschology = 1) 
			{
				If (fServices != "") 
					fServices .= "/"
				fServices .= "psychology"
			}
		Return fServices
	}
TxtMonthandDayXDaysFromNow(integerDays)
	{
		FormatTime, Date1,, yyyyMMdd
		EnvAdd, Date1, %integerDays%, days
		FormatTime, Date1, %Date1%, MMMM dd
		Return Date1
	}
TxtMorningAfternoonOrEvening()
	{
		if A_Hour between 6 and 11
			return "morning"
		if A_Hour between 12 and 16
			return "afternoon"
		if (A_Hour >= 17 or A_Hour < 6)	
			Return "evening"
	}
TxtReqDescription(txtCallerName, txtCallerRelationtoPt, boolPtHasReferral, boolPtNeedsAuth, txtPtRefProvider, txtPtReqProvider, txtCareConcerns, txtRequestedSvcs) ; TxtReqDescription(CallerName, CallerRelation, IsExistingRef, PtProvider, ReqProvider, CareConcerns, TxtReqServices())
	{
		CallerRelationName := ""
		If (txtCallerName != "") ; If the patient is not the caller.
			CallerRelationName := txtCallerRelationtoPt . " (" . txtCallerName . ") "

		If (txtPtRefProvider != "")
			{
				If (boolPtHasReferral = 1)
					referprovnote := " per a referral from their provider " . txtPtRefProvider
				Else referprovnote := " per a recommendation from their provider " . txtPtRefProvider
			}
		Else referprovnote := ""

		If (boolPtNeedsAuth = 0 or boolPtNeedsAuth ="")
			Return "Patient " . CallerRelationName . "called in and requested access to " . txtRequestedSvcs . " related to " . txtCareConcerns . referprovnote . "."
		Else Return "Patient " . CallerRelationName . "called in and requested authorization to " . txtPtReqProvider . " for " . txtRequestedSvcs . " related to " . txtCareConcerns . referprovnote . "."
	}	
AppointmentMessagesAll() 
	{
		AppointmentMessagesAll := ""
		If boolReqPsychiatryIDS()
		{
			If (AppointmentMessagesAll != "")
				AppointmentMessagesAll .= "`n"
			AppointmentMessagesAll .= AppointmentMessageIndividual(boolReqPsychiatryIDS()+boolReqTherapyIDS()+boolReqTherapyMHCCIntake()+boolReqPsychologyIDS(),"Psychiatry")
		}
		If (boolReqTherapyIDS() or boolReqTherapyMHCCIntake())
			{
				If (AppointmentMessagesAll != "")
					AppointmentMessagesAll .= "`n"
				AppointmentMessagesAll .= AppointmentMessageIndividual(boolReqPsychiatryIDS()+boolReqTherapyIDS()+boolReqTherapyMHCCIntake()+boolReqPsychologyIDS(),"Therapy")
			}
		If boolReqPsychologyIDS()
			{
				If (AppointmentMessagesAll != "")
					AppointmentMessagesAll .= "`n"
				AppointmentMessagesAll .= AppointmentMessageIndividual(boolReqPsychiatryIDS()+boolReqTherapyIDS()+boolReqTherapyMHCCIntake()+boolReqPsychologyIDS(),"Psychology")
			}
		Return % AppointmentMessagesAll
	}
	
AppointmentMessageIndividual(intPARServicesCount, txtProviderSpecialty)
	{
		If (txtCallerName() != "")
		{
			CallerRelationName := txtCallerRelation() . " (" . txtCallerName() . ")"
			AppointmentMessage .= "Appt scheduled by " . CallerRelationName
		}
		If (txtProviderSpecialty = "Therapy" or txtProviderSpecialty = "Psychology")
			{
				If (AppointmentMessage != "")
					AppointmentMessage .= " / "
				AppointmentMessage .= "Disclosure emailed to " . txtPtEmail()
				If (txtPtEmail2() != "")
					AppointmentMessage .= " and " . txtPtEmail2()
			}
		/* ; NO MORE BARS ASSESSMENTS
		If (boolPtIsMinor() != 1)
			If (RegExMatch(txtPtConcerns(), "\bADD\b") != 0 or RegExMatch(txtPtConcerns(), "\bADHD\b") != 0)
				{
					If (AppointmentMessage != "")
						AppointmentMessage .= " / "
					AppointmentMessage .= "BAARS Assessment Sent"
				}
			*/ ; NO MORE BARS ASSESSMENTS
		If (AppointmentMessage != "")
			AppointmentMessage .= " / "
		AppointmentMessage .= "Sent SMS instructions / Failed Magellan search"
		
		If (intPARServicesCount > 1)
			Return % txtProviderSpecialty . " Appt. Msg: `n" . AppointmentMessage
			Else Return % AppointmentMessage
	}
AppointmentNotesAll() 
	{
		AppointmentNotesAll := ""
		If boolReqPsychiatryIDS()
		{
			If (AppointmentNotesAll != "")
				AppointmentNotesAll .= "`n"
			AppointmentNotesAll .= AppointmentNoteIndividual(boolReqPsychiatryIDS()+boolReqTherapyIDS()+boolReqTherapyMHCCIntake()+boolReqPsychologyIDS(),"Psychiatry")
		}
		If (boolReqTherapyIDS() or boolReqTherapyMHCCIntake())
			{
				If (AppointmentNotesAll != "")
					AppointmentNotesAll .= "`n"
				AppointmentNotesAll .= AppointmentNoteIndividual(boolReqPsychiatryIDS()+boolReqTherapyIDS()+boolReqTherapyMHCCIntake()+boolReqPsychologyIDS(),"Therapy")
			}
		If boolReqPsychologyIDS()
			{
				If (AppointmentNotesAll != "")
					AppointmentNotesAll .= "`n"
				AppointmentNotesAll .= AppointmentNoteIndividual(boolReqPsychiatryIDS()+boolReqTherapyIDS()+boolReqTherapyMHCCIntake()+boolReqPsychologyIDS(),"Psychology")
			}
		Return % AppointmentNotesAll
		
	}
AppointmentNoteIndividual(intPARServicesCount, txtProviderSpecialty)
	{
		AppointmentNote := "MHAC"
		If (txtCallerPhone() != "") 			;Prefer the caller's phone number for callback #!
				txtNumber := txtCallerPhone()
		Else txtNumber := txtPtPhone()
		
		If (txtScreeningResult() = "Moderate" and txtProviderSpecialty = "Psychiatry" and boolReqPsychiatryModerate())
			AppointmentNote .= " / Moderate - Do Not Cancel Without Consulting with MH RN"
		If (txtScreeningResult() = "Moderate" and txtProviderSpecialty = "Therapy" and boolReqTherapyModerate())
			AppointmentNote .= " / Moderate - Do Not Cancel Without Consulting with MH RN"
		If (txtProviderSpecialty = "Psychology" or txtProviderSpecialty = "Therapy")
			AppointmentNote .= " / Disclosure Sent"
		AppointmentNote .= " / HCA email " . txtPtEmail() . "/call/text/Phone appt " . txtNumber . "/FTF appt /  " . txtPtConcerns()
		
		If (intPARServicesCount > 1)
			Return % txtProviderSpecialty . " Appt. Note: `n" . AppointmentNote
			Else Return % AppointmentNote
	}
