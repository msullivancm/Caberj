/*
Ponto de entrada utilizado para alterar as cores da legenda da tela de pesquisa dos Beneficiários.
Autor: Marcelo Giglio
Data: 26/02/2013  
*/
User Function PLSMCORF3()

Local cCor:="ENABLE"
Local cMatric:=paramixb[1]
Local dHoje:=DATE()
Local cCODINT:=SUBSTR(cMatric,1,4)
Local cCODEMP:=SUBSTR(cMatric,6,4)
Local cMATRICULA:=SUBSTR(cMatric,11,6)
Local cTIPREG:=SUBSTR(cMatric,18,2)
Local cDIGITO:=SUBSTR(cMatric,21,1)

Local aArea	:= GetArea()
dBSelectArea("BA1")
dbSetOrder(2)
       
//Se o registro do Beneficiário é encontrado
If BA1->(DbSeek(xFilial("BA1")+cCODINT+cCODEMP+cMATRICULA+cTIPREG+cDIGITO))

	//Se a data de bloqueio não está vazia
	If !Empty(BA1->BA1_DATBLO)
		//Se a data de bloqueio é menor do que a data de hoje a cor é de DISABLE
		If BA1->BA1_DATBLO <  dHoje
			cCor:="DISABLE"                   
		Endif
		// Se a data de bloqueio for superior ou igual a data atual Coloca a cor azul para diferenciar
		If BA1->BA1_DATBLO >=  dHoje
			cCor:="BR_AZUL"                
		Endif                                                                             
	Else    // Se a data de bloqueio está vazia deve testar para ver se é beneficiáriio de empresa de reciprocidade
		
		    //Parametros de BLoqueio de REciprocidade
		
		    cGrpEmpRec	:= SuperGetMv('MV_XBLREGR') //BLoqueio de REciprocidade GRupo
		    cContraRec	:= SuperGetMv('MV_XBLRECO') //BLoqueio de REciprocidade COntrato
		    cVersConRec	:= SuperGetMv('MV_XBLREVC') //BLoqueio de REciprocidade Versao Contrato
		    cSubConRec	:= SuperGetMv('MV_XBLRESC') //BLoqueio de REciprocidade SubContrato
		    cVersSubRec	:= SuperGetMv('MV_XBLREVS') //BLoqueio de REciprocidade Versao Subcontrato

/*
					If 	BA3->BA3_CODEMP == cGrpEmpRec .and. 	;
						BA3->BA3_CONEMP == cContraRec .and. 	;
						BA3->BA3_VERCON == cVersConRec .and. 	;
						BA3->BA3_SUBCON == cSubConRec .and. 	;
						BA3->BA3_VERSUB == cVersSubRec

*/			
					If 	BA1->BA1_CODEMP == cGrpEmpRec 
			
						cCor:="BR_LARANJA"
						                
			       Endif
	 Endif
EndIf     

RestArea(aArea)

//Retorna a cor para a rotina
Return cCor


