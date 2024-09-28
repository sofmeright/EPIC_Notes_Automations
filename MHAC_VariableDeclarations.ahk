#SingleInstance Force

boolCallerROI(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolCalmMyStrength(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolPtIsCaller(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 1
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolPtIsMinor(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReferralExists(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReferralExistsPsychiatry(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReferralExistsPsychology(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReferralExistsTherapy(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReq3RDParty(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqED(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqGH(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqMHIOP(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqPsychiatry(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (boolReqPsychiatryEDS() or boolReqPsychiatryIDS() or boolReqPsychiatryMagellan() or boolReqPsychiatryModerate())
			fVar := 1
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqPsychiatryEDS(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqPsychiatryIDS(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqPsychiatryMagellan(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqPsychiatryModerate(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqPsychology(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (boolReqPsychologyEDS() or boolReqPsychologyIDS() or boolReqPsychologyMagellan())
			fVar := 1
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqPsychologyEDS(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqPsychologyIDS(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqPsychologyMagellan(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqSUD(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqTherapy(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (boolReqTherapyEDS() or boolReqTherapyIDS() or boolReqTherapyMagellan() or boolReqTherapyMHCCIntake() or boolReqTherapyModerate())
			fVar := 1
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqTherapyEDS(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqTherapyIDS(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqTherapyMagellan(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqTherapyMHCCIntake(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
boolReqTherapyModerate(txtValue="$get")
	{
		static fVar
		If (fVar != 0 and fVar != 1)
			fVar := 0
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
csvPtConcernCPTs(txtValue="$get") ;This CSV is actually $ separated.
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
csvSolutionsMHCC(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
intScreeningCSRA(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
intScreeningGAD7(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
intScreeningPHQ9(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtAdditionalNotes(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtCallerName(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtCallerPhone(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtCallerRelation(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtGingerCoachingTracking(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtDebugMessages(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtAge(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtConcerns(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtDOB(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtEmail(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtEmail2(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtMRN(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtName(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtNameInitials(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtNamePref(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtPtPhone(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychiatryBy(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychiatryTo(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychiatryPOS(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychiatryAddr(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychiatryPhone(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychiatryFax(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychiatryNPI(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychiatryTaxID(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychiatryVerifStats(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychologyBy(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychologyTo(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychologyPOS(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychologyAddr(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychologyPhone(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychologyFax(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychologyNPI(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychologyTaxID(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralPsychologyVerifStats(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralTherapyBy(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralTherapyTo(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralTherapyPOS(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralTherapyAddr(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralTherapyPhone(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralTherapyFax(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralTherapyNPI(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralTherapyTaxID(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtReferralTherapyVerifStats(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
txtScreeningResult(txtValue="$get")
	{
		static fVar
		If (txtValue = "$get")
			return fVar
			Else fVar := txtValue
	}
	
