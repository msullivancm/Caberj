#Include 'Protheus.ch'

User Function MSACES09()
LOCAL cEmpFil := GetPvProfString( getWebJob(), "PrepareIn", "", GetADV97() )
LOCAL cEmp := substr(cEmpFil,1,2)
LOCAL aRet := {.t., "","",""}

If cEmp == "01" 
	//  Caberj  
	//If 	BA1->BA1_CODEMP != "0004" .and.;
	If	BA1->BA1_CODEMP != "0009" .and.;
		BA1->BA1_CODEMP != "0024" .and.;
		BA1->BA1_CODEMP != "0025" .and.;
		BA1->BA1_CODEMP != "0027" .and.;
		BA1->BA1_CODEMP != "0028" 

		aRet := {.T., "","caberj_frente.png","caberj_verso.png"}
	
	// Prefeitura
	Elseif	BA1->BA1_CODEMP == "0024" .or.;
			BA1->BA1_CODEMP == "0025" .or.;
			BA1->BA1_CODEMP == "0027" .or.;
			BA1->BA1_CODEMP == "0028"
			
		aRet := {.T., "","caberj_pref_frente.png","caberj_pref_verso.png"}
	
	// Demais não acessam o cartao	
	Else
		aRet := {.F., "","",""}
		
	Endif

Elseif cEmp == "02"
	// Integral
	aRet := aRet := {.T., "","integral_frente.png","integral_verso.png"}
	
Else
	// Demais não tem acesso
	aRet := {.F., "","",""}

Endif
	
Return aRet

