User Function PL130BEN
Local cGruBen	:= paramixb[1]
Local cOper		:= paramixb[2] 
Local cOrig		:= paramixb[3] 
Local cReturn	:= ""
Local cEmpAtu	:= SM0->M0_CODIGO

If cOrig == "V"
	cTabela := "BD6"
Else
	cTabela := "BA1"
EndIf

If cEmpAtu = "01"  
	Do Case
		Case cGruBen == "1" // Expostos Não Beneficiarios	
			cReturn	:=  " SIGA_TIPO_EXPOSICAO_ANS("+cTabela+"_CODEMP,"+cTabela+"_MATRIC,"+cTabela+"_TIPREG,sysdate) = 0 "
		Case cGruBen == "2"
			cReturn	:=  " SIGA_TIPO_EXPOSICAO_ANS("+cTabela+"_CODEMP,"+cTabela+"_MATRIC,"+cTabela+"_TIPREG,sysdate) = 2 "
		Case cGruBen == "3" // Beneficiarios nao expostos
			cReturn	:=  " SIGA_TIPO_EXPOSICAO_ANS("+cTabela+"_CODEMP,"+cTabela+"_MATRIC,"+cTabela+"_TIPREG,sysdate) = 1 "
	EndCase
Else
	Do Case
		Case cGruBen == "1" // Expostos Não Beneficiarios	
			cReturn	:=  " SIGA_TIPO_EXPOSICAO_ANS_INT("+cTabela+"_CODEMP,"+cTabela+"_MATRIC,"+cTabela+"_TIPREG,sysdate) = 0 "
		Case cGruBen == "2"
			cReturn	:=  " SIGA_TIPO_EXPOSICAO_ANS_INT("+cTabela+"_CODEMP,"+cTabela+"_MATRIC,"+cTabela+"_TIPREG,sysdate) = 2 "
		Case cGruBen == "3" // Beneficiarios nao expostos
			cReturn	:=  " SIGA_TIPO_EXPOSICAO_ANS_INT("+cTabela+"_CODEMP,"+cTabela+"_MATRIC,"+cTabela+"_TIPREG,sysdate) = 1 "
	EndCase
EndIf
Return(cReturn)