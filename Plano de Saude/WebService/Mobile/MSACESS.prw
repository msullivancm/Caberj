#Include 'Protheus.ch'

User Function MSACESS()
LOCAL aRet 		:= {.T.,""}
LOCAL dDataLimite	:= GetNewPar("MV_MSDTLOG", cTod("01/01/2015") )
LOCAL cEmpresas	:= GetNewPar("MV_MSEPLIB", "0003")

If BA1->BA1_CODEMP $ cEmpresas  // Excessão para usuários da daberj
Else
	If dDataBase < dDataLimite
		aRet := {.F., "Esta opção só estará disponível a partir do dia "+dToc(dDataLimite)+"."}
	Endif
Endif

Return(aRet)

