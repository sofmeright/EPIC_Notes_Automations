#SingleInstance Force

TXTSolutionListPsychiatry(boolPtIsMinor, txtScreening) 
	{ 
		If boolReferralExistsPsychiatry() ; Dont load unless pt has a referral
			{
				If (boolPtIsMinor = 0)
					{
						If (txtScreening = "PtUnavailable") ;Pt is 18+ and the caller is a different person. Please address and handle!
							{
								Return "Not Requested|Magellan (*Recommended)|EDS|IDS|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
							}
						Else If (txtScreening = "Mild" or txtScreening = "Routine") ;Mild or Routine
							{
								Return "Not Requested|Magellan (*Recommended)|EDS|IDS|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
							}
						Else If (txtScreening = "Moderate") ;Moderate
							{
								Return "Not Requested|Magellan (*w/ Moderate Therapy)|EDS|IDS (*w/ High-Priority Wait List)|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
							}
						Else If (txtScreening = "Emergent") ;Emergent
							{
								Return "Not Requested|Magellan|EDS|IDS|MHCC Warm Transfer (*Emergent)" 
							}
						Else Return "Not Requested|Magellan|EDS|IDS|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
					}
					
				If (boolPtIsMinor = 1)
					{
						If (txtScreening = "Mild" or txtScreening = "Routine") ;Mild or Routine
							{
								Return "Not Requested|Magellan|EDS|IDS (*Recommended)|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
							}
						Else If (txtScreening = "Moderate" or txtScreening = "Emergent") ;Moderate or Emergent
							{
								Return "Not Requested|Magellan|EDS|IDS|MHCC Warm Transfer (*Emergent)" 
							}
						Else Return "Not Requested|Magellan|EDS|IDS (*Recommended)|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
					}
			}
			Else 
				{
					If (txtScreening = "Emergent") ;Emergent
						Return "Not Requested (*referral required)|Magellan|EDS|IDS|PCAC Cold Transfer|MHCC Warm Transfer (*Emergent)|MHCC Cold Transfer|MHCC CRM"
						Else Return "Not Requested (*referral required)|Magellan|EDS|IDS|PCAC Cold Transfer (*Recommended)|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM"
				}
	}
TXTSolutionListTherapy(boolPtIsMinor, txtScreening) 
	{ 
		If (boolPtIsMinor = 0)
			{
				If (txtScreening = "PtUnavailable") ;Pt is 18+ and the caller is a different person. Please address and handle!
					{
						Return "Not Requested|Magellan|EDS|IDS|MHCC Intake (*Recommended)|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
					}
				Else If (txtScreening = "Mild") ;Mild
					{
						Return "Not Requested|Magellan (*Recommended)|EDS|MHCC Intake|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
					}
				Else If (txtScreening = "Routine") ;Routine
					{
						Return "Not Requested|Magellan (*Recommended)|EDS|MHCC Intake|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
					}
				Else If (txtScreening = "Moderate") ;Moderate
					{
						Return "Not Requested|Magellan (*w/ Moderate Psychiatry)|EDS|MHCC Intake (*Recommended)|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
					}
				Else If (txtScreening = "Emergent") ;Emergent
					{
						Return "Not Requested|Magellan|EDS|MHCC Intake|MHCC Warm Transfer (*Emergent)" 
					}
				Else Return "Not Requested|Magellan|EDS|MHCC Intake|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
			}
			
		If (boolPtIsMinor = 1)
			{
				If (txtScreening = "NoROI") ;Pt is <18 and the caller does not have ROI. Please address and handle!
					{
						Return "Not Requested|Magellan (*Recommended)|EDS|IDS|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
					}
				Else If (txtScreening = "Mild" or txtScreening = "Routine") ;Mild or Routine
					{
						;Return "Not Requested|Magellan|EDS|IDS < 30 days (*Recommended)" 
						Return "Not Requested|Magellan|EDS|IDS < 30 days or EDS (*Recommended)|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM"  ; causing issue with EDS in it
					}
				Else If (txtScreening = "Moderate" or txtScreening = "Emergent") ;Moderate or Emergent
					{
						Return "Not Requested|Magellan|EDS|IDS|MHCC Warm Transfer (*Emergent)" 
					}
				Else Return "Not Requested|Magellan|EDS|IDS|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
			}
	}
TXTSolutionListPsychology(boolPtIsMinor, txtScreening) ;Need to add a note about Bariatric scheduling.
	{  
		If (boolPtIsMinor = 0)
			{
				If (txtScreening = "ThirdParty") ;Court, DUI, VA, CPS
					{
						Return "Not Requested|Magellan|EDS|IDS|Cold transfer MHCC (*Recommended)|MHCC CRM" 
					}
				Else If (txtScreening = "Mild" or txtScreening = "Routine" or txtScreening = "Moderate") ;Moderate
					{
						Return "Not Requested|Magellan|EDS|IDS (*Recommended)|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
					}
				Else If (txtScreening = "Emergent") ;Emergent
					{
						Return "Not Requested|Magellan|EDS|IDS (*PsyD Never Urgent)|MHCC Warm Transfer (*Emergent)"
					}
				Else Return "Not Requested|Magellan|EDS|IDS|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM"
			}
			
		If (boolPtIsMinor = 1) ; If no referral PCP must put in a referral.
			{
				If (txtScreening = "Mild" or txtScreening = "Routine") ;Normal
					{
						Return "Not Requested|Magellan|EDS|IDS (*Recommended)|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
					}
				Else If (txtScreening = "Moderate" or txtScreening = "Emergent") ;Alert
					{
						Return "Not Requested|Magellan|EDS|IDS (*PsyD Never Urgent)|MHCC Warm Transfer (*Emergent)"
					}
				Else Return "Not Requested|Magellan|EDS|IDS|MHCC Warm Transfer|MHCC Cold Transfer|MHCC CRM" 
			}
	}
TXTSolutionListOther() 
	{
		Return "SUD|MH IOP|Eating Disorder|Gender Health|3rd Party"
	}
	
