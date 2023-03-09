#Include 'Protheus.ch'

User Function PLIMPTDO() 

	Local aErrVarVin := {} 
	Local aParam     := ParamIxb
	Local cCodTab    := aParam[2]
	Local cCodProc   := aParam[4]
	Local cCodRda	 := ""
	Local cAliasPCW  := GetNextAlias() 

	/////If !(Funname() == "PLSA973L") //Angelo Henrique - data: 21/01/2020 - Teste HAT

		if(type("cCodRda3X") == "C" ) 
			cCodRda := cCodRda3X
		elseif type("cRdaGuia") == "C" 	
			cCodRda := cRdaGuia
		elseif alltrim(UPPER(funname())) == 'PLSA498'
			cCodRda := BD6->BD6_CODRDA
		endif 	

		BeginSql Alias cAliasPCW
			%noparser%
			SELECT 
			PCW_CODPAD,PCW_CODPSA,PCW_TABPRO, PCW_CODPRO 
			FROM %table:PCW%
			WHERE PCW_CODRDA 	= %exp:cCodRda%
			AND PCW_CODPAD 	= %exp:cCodTab%
			AND PCW_CODPSA 	= %exp:cCodProc%
			AND %notdel%
			ORDER BY PCW_CODPSA
		EndSql 

		if (cAliasPCW)->(!Eof())
			//aErrVarVin := {.F., "", "", ""}
			aErrVarVin := {.F., (cAliasPCW)->PCW_TABPRO, "BR8", (cAliasPCW)->PCW_CODPRO} 
		////else 
			/*cCodTab := GetNewPar("MV_PLCDPXM","01")
			cCodProc := GetNewPar("MV_PLPSPXM","99999994")
			cCodProc := padr(cCodProc,tamsx3("BR8_CODPSA")[1])*/

			//////aErrVarVin := {.T., cCodTab, "BR8", cCodProc}
		endif 

		if select(cAliasPCW) > 0 
			dbselectarea(cAliasPCW)
			dbclosearea()
		endif


	//////Else

	//////	aErrVarVin := {.T., "", "", ""}

	///////EndIf

Return(aErrVarVin)

/*/{Protheus.doc} PLSTPGUIA
Retorna o tipo de guia do XML entre os tipos enviados.
@type function
@author Bruno Iserhardt
@since 19/08/13
@version 1.0
/*/
/*
Function u_cTeste(cTpGuias, aDadosUnic)
Local cRet		:= ""
Local nI		:= 0
Local nIndex	:= 0
Local nj:=0
Local aTpGuias	:={}
Local cAuxCtpGui:=cTpGuias

cAuxCtpGui:=STRTRAN(cAuxCtpGui, "'", "")
aTpGuias:=StrTokarr(cAuxCtpGui, ",")

If (Len(aTpGuias) > 0)
For nI := 1 To Len(aTpGuias)
If (aScan(aDadosUnic,{|x| aTpGuias[nI] $ AllTrim(x[2]) }) > 0)
cRet := aTpGuias[nI]
EXIT
EndIf
Next
EndIf

Return cRet*/