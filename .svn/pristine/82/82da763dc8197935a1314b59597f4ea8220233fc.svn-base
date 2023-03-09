#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'  

Static CABINCLUI 	:= 3
Static cPropri		:= '0'//Operadora
Static cCodCriDHr 	:= cPropri + 'DH'
Static cDesBloqDHr 	:= 'Proc. real. antes Dt/Hr Intern.'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³INTTISS   ºAutor  ³Leonardo Portella   º Data ³  05/07/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcoes utilizadas na importacao internacao TISS e geracao  º±±
±±º          ³de PEG/Guias em local padrao.                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³INTERNACAO TISS                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function IncIntSADT(c_PegGuia,cCodRDA,cMatric)

Local aGuia := {}
Local aLog	:= {}

BEGIN TRANSACTION

aGuia := U_aGuiaInc(c_PegGuia,cCodRDA,cMatric)//Retorna Guia / Procedimentos / Honorarios

If !empty(aGuia[1])
	aLog := U_aCabSadtInt(cCodLDP,aGuia[1],aGuia[2],aGuia[3],aGuia[4])
EndIf

END TRANSACTION  

Return aLog



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca os dados da PEG/Guia na internacao (BE4)³
//³Ponteira na BE4, BAU, BB8 e BA1.              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function aGuiaInc(c_PegGuia,c_CodRDA,cMatric)

Local aGuia 		:= {}
Local aProcs		:= {}
Local aHonors		:= {}
Local aAutProcs		:= {}
Local lContinua		:= .T.
Local aProcedimento	:= {}
Local aAreaBD6		:= BD6->(GetArea())
Local aAreaBD7		:= BD7->(GetArea())
Local aAreaB43		:= B43->(GetArea())
Local cCpoExcl		:= "CODOPE|CODLDP|CODPEG|NUMERO|TIPGUI|ORIMOV|DATDIG|ANOPAG|MESPAG|DTDIG1|XRDBD6|XRDBD7"

BE4->(DbSetOrder(1))//BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO
BE4->(DbGoTop())

If BE4->(MsSeek(xFilial('BE4') + c_PegGuia)) 
	While !BE4->(EOF()) .and. ( xFilial('BE4') + c_PegGuia == BE4->(BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO) ) 
		If !( lContinua := (c_CodRDA == BE4->BE4_CODRDA) )
			BE4->(DbSkip())
			loop
		Else
			BAU->(DbSetOrder(1))
			BAU->(DbGoTop())
			lContinua := BAU->(MsSeek(xFilial('BAU') + c_CodRDA))
			exit
		EndIf
	EndDo
EndIf

If lContinua
	BA1->(DbSetOrder(2))//BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
	BA1->(DbGoTop())
	lContinua := BA1->(MsSeek(xFilial('BA1')+cMatric))
EndIf

If lContinua
	BB8->(DbSetOrder(1))//BB8_FILIAL + BB8_CODIGO + BB8_CODINT + BB8_CODLOC + BB8_LOCAL
	BB8->(DbGoTop())
	lContinua := BB8->(MsSeek(xFilial("BB8")+BE4->(BE4_CODRDA + BE4_OPERDA + BE4_CODLOC)))
EndIf

If lContinua
	//Considera ponteirado na BE4
	aBuffer 	:= GetGuiProHon(cCpoExcl)
	
	aGuia 		:= aBuffer[1]
	aProcs 		:= aBuffer[2]
	aHonors		:= aBuffer[3]
EndIf

/*
If lContinua
                 
	B43->(DbSetOrder(1))//B43_FILIAL + B43_CODOPE + B43_CODLDP + B43_CODPEG + B43_NUMERO + B43_ORIMOV + B43_SEQUEN
	B43->(DbGoTop())
	
	If B43->(MsSeek(xFilial('B43') + BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)))
                                                                                                      
		While !B43->(EOF()) .and. ;
			(B43->(B43_FILIAL+B43_CODOPE+B43_CODLDP+B43_CODPEG+B43_NUMERO+B43_ORIMOV) == xFilial('B43') + BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV))
		
			aAutProc := {{'FILIAL',B43->B43_FILIAL}}
	            
			SX3->(DbSetOrder(1))
			SX3->(DbSeek("B43"))
			
			Do While !SX3->(EOF()) .and. (SX3->X3_ARQUIVO == "B43")
				If ( cNivel >= SX3->X3_NIVEL ) .and. ( SX3->X3_CONTEXT <> 'V' )
					cCampo 		:= AllTrim(SX3->X3_CAMPO)
					cCpoSAlias 	:= Substr(cCampo,5,len(cCampo) - 4)
					
					If !empty(&('B43->' + cCampo)) .and. ( cCpoSAlias <> 'FILIAL' )
						//Nao inclui os campos que serao os novos na nova PEG
						If !( cCpoSAlias $ cCpoExcl )
							aAdd(aAutProc,{cCpoSAlias,&('B43->' + cCampo)})
						EndIf
					EndIf
				EndIf
	
				SX3->(DbSkip())
			EndDo
			
			If ( len(aAutProc) > 1 )
				aAdd(aAutProcs,aAutProc)
			EndIf

			B43->(DbSkip())
			
		EndDo
			
	EndIf
	
EndIf
*/
BD6->(RestArea(aAreaBD6))
BD7->(RestArea(aAreaBD7))
B43->(RestArea(aAreaB43))

Return {aGuia,aProcs,aHonors,aAutProcs}



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³aRet[1] => Guias        ³
//³aRet[2] => Procedimentos³
//³aRet[3] => Honorarios   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function GetGuiProHon(cCpoExcl)

Local aGuia		:= {}
Local aGuiTmp 	:= {{'FILIAL',xFilial('BD5')}}
Local cCpoExcec := 'BD5_NOMEXE'
Local aProcs 	:= {}
Local aHonors 	:= {}
Local aStruBE4 	:= BE4->(DbStruct())        

//Preenche vetor guias  
SX3->(DbSetOrder(1))
SX3->(DbSeek("BD5"))

Do While !SX3->(EOF()) .and. (SX3->X3_ARQUIVO == "BD5")
            
	cCampo := AllTrim(SX3->X3_CAMPO)
		
	If ( cNivel >= SX3->X3_NIVEL ) .and. ( ( SX3->X3_CONTEXT <> 'V' ) .or. ( cCampo $ cCpoExcec) )
		cCpoSAlias 	:= Substr(cCampo,5,len(cCampo) - 4)
		
		Do Case 
		
			Case cCampo == 'BD5_XRCBE4'
	            //Recno do BE4 que dara origem ao BD5
		    	aAdd(aGuiTmp,{cCpoSAlias,BE4->(Recno())})
		    	
			Case cCampo == 'BD5_FASE'
	            //Fase digitacao. Na mudanca de fase mais a frente ira mudar
		    	aAdd(aGuiTmp,{cCpoSAlias,'1'})
		    
		    Otherwise
				//Campo possui correspondente na BE4
				lCpoBE4BD5 := ( aScan(aStruBE4,{|x|AllTrim(x[1]) == 'BE4_' + cCpoSAlias}) > 0 )
	
				If lCpoBE4BD5 .and. ( cCpoSAlias <> 'FILIAL' ) .and. ( ValType(&('BE4->BE4_' + cCpoSAlias)) == SX3->X3_TIPO )
					
					//Nao inclui os campos que serao os novos na nova PEG
					If !( cCpoSAlias $ cCpoExcl )  .or. ( cCampo $ cCpoExcec)       
						aAdd(aGuiTmp,{cCpoSAlias,&('BE4->BE4_' + cCpoSAlias)})
					EndIf
	            
	            EndIf
	            
		EndCase

	EndIf
         
	SX3->(DbSkip())

EndDo

If len(aGuiTmp) > 3
	nPos := aScan(aGuiTmp,{|x|x[1] == "TIPSAI"}); If(nPos == 0, aAdd(aGuiTmp,{"TIPSAI",BE4->BE4_TIPALT})	,aGuiTmp[nPos][2] := BE4->BE4_TIPALT)
	nPos := aScan(aGuiTmp,{|x|x[1] == "TIPATE"}); If(nPos == 0, aAdd(aGuiTmp,{"TIPATE","07"})				,aGuiTmp[nPos][2] := "07")//SADT Internacao

	aAdd(aGuia,aGuiTmp)
	
	aBuffer := GetProcHon(BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO),BE4->BE4_CODRDA,cCpoExcl)
	
	aProcs 	:= aBuffer[1]
	aHonors := aBuffer[2]
	               
	//Nao foram encontrados procedimentos - nao ira incluir a guia
	If len(aProcs) == 0
		aGuia 	:= {}	
	EndIf
		
EndIf

Return {aGuia,aProcs,aHonors}



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³aRet[1] => Procedimentos³
//³aRet[2] => Honorarios   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function GetProcHon(c_PegGuia,c_CodRDA,cCpoExcl)

Local n_I := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aRet 		:= {}
Local aProcs	:= {}
Local aHonors 	:= {}

//Preenche vetor de procedimentos
BD6->(DbSetOrder(1))
BD6->(DbGoTop())

If BD6->(MsSeek(xFilial('BD6') + c_PegGuia))

	While !BD6->(EOF()) .and. ( BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO ) == xFilial('BD6') + c_PegGuia )

		//Nao grava 2 vezes o mesmo BD6 
		//'0EX' => Bloqueio de procedimentos que sao incluidos duplicados pelo padrao
		If !empty(BD6->BD6_XRDBD6) .or. ( BD6->BD6_CODRDA <> c_CodRDA ) .or. ( BD6->BD6_MOTBPF == '0EX' ) .or. ( BD6->BD6_MOTBPG == '0EX' )
			BD6->(DbSkip())
			loop
		EndIf

		aProcedimento := {{'FILIAL',BD6->BD6_FILIAL}}

		SX3->(DbSetOrder(1))
		SX3->(DbSeek("BD6"))

		Do While !SX3->(EOF()) .and. (SX3->X3_ARQUIVO == "BD6")

			If ( cNivel >= SX3->X3_NIVEL ) .and. ( SX3->X3_CONTEXT <> 'V' )
				cCampo 		:= AllTrim(SX3->X3_CAMPO)
				cCpoSAlias 	:= Substr(cCampo,5,len(cCampo) - 4)

				Do Case

					Case cCampo == 'BD6_XROBD6'
			            //Recno do BD6 original
				    	aAdd(aProcedimento,{cCpoSAlias,BD6->(Recno())})

				 	Case cCampo == 'BD6_FASE'
				        //Fase digitacao. Na mudanca de fase mais a frente ira mudar
			    		aAdd(aProcedimento,{cCpoSAlias,'1'})

				    Otherwise

						If !empty(&('BD6->' + cCampo)) .and. ( cCpoSAlias <> 'FILIAL' )
							//Nao inclui os campos que serao os novos na nova PEG
							If !( cCpoSAlias $ cCpoExcl )
								aAdd(aProcedimento,{cCpoSAlias,&('BD6->' + cCampo)})
							EndIf
						EndIf

				EndCase

			EndIf

			SX3->(DbSkip())

		EndDo

		If ( len(aProcedimento) > 1 )
			nPos := aScan(aProcedimento,{|x|x[1] == "TIPSAI"}); If(nPos == 0, aAdd(aProcedimento,{"TIPSAI",BE4->BE4_TIPALT})	,aProcedimento[nPos][2] := BE4->BE4_TIPALT)
			nPos := aScan(aProcedimento,{|x|x[1] == "TIPATE"}); If(nPos == 0, aAdd(aProcedimento,{"TIPATE","07"})				,aProcedimento[nPos][2] := "07")//SADT Internacao

			aAdd(aProcs,aProcedimento)

			//Pego os honorarios do procedimento
			aHonorProc := GetHonors(c_PegGuia,BD6->BD6_CODRDA,BD6->BD6_SEQUEN,cCpoExcl)

			For n_I := 1 to len(aHonorProc)
				aAdd(aHonors,aHonorProc[n_I])
			Next

		EndIf

		BD6->(DbSkip())	 

	EndDo

EndIf

Return {aProcs,aHonors}



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³aRet => Honorarios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function GetHonors(c_PegGuia,c_CodRDA,cSequen,cCpoExcl)

Local aRet 			:= {}
Local aHonorario 	:= {}

//Preenche vetor de honorarios
BD7->(DbSetOrder(1))
BD7->(DbGoTop())

If BD7->(DbSeek(xFilial('BD7') + c_PegGuia))

	While !BD7->(EOF()) .and. ( BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO ) == xFilial('BD7') + c_PegGuia )

		//Nao grava 2 vezes o mesmo BD7
		If !empty(BD7->BD7_XRDBD7) .or. ( BD7->BD7_CODRDA <> c_CodRDA ) .or. ( BD7->BD7_SEQUEN <> cSequen)
			BD7->(DbSkip())
			loop
		EndIf

		aHonorario := {{'FILIAL',BD7->BD7_FILIAL}}

		SX3->(DbSetOrder(1))
		SX3->(DbSeek("BD7"))

		Do While !SX3->(EOF()) .and. (SX3->X3_ARQUIVO == "BD7")

			If ( cNivel >= SX3->X3_NIVEL ) .and. ( SX3->X3_CONTEXT <> 'V' )
				cCampo 		:= AllTrim(SX3->X3_CAMPO)
				cCpoSAlias 	:= Substr(cCampo,5,len(cCampo) - 4)

				Do Case 

					Case cCampo == 'BD7_XROBD7'
			            //Recno do BD7 original
				    	aAdd(aHonorario,{cCpoSAlias,BD7->(Recno())})

					Case cCampo == 'BD7_FASE'
						//Fase digitacao. Na mudanca de fase mais a frente ira mudar
		    			aAdd(aHonorario,{cCpoSAlias,'1'})

				    Otherwise

						If !empty(&('BD7->' + cCampo)) .and. ( cCpoSAlias <> 'FILIAL' )
							//Nao inclui os campos que serao os novos na nova PEG
							If !( cCpoSAlias $ cCpoExcl )
								aAdd(aHonorario,{cCpoSAlias,&('BD7->' + cCampo)})
							EndIf
						EndIf

				EndCase

			EndIf

			SX3->(DbSkip())

		EndDo        

		aAdd(aRet,aHonorario)

		BD7->(DbSkip())	 

	EndDo

EndIf

Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³aCabSadtIntºAutor  ³Leonardo Portella   º Data ³  05/07/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Inclui dados de uma guia de internacao parcial em PEG/Guia  º±±
±±º          ³SADT para nao fechar a senha e poder realizar o pagamento   º±±
±±º          ³da RDA.                                                     º±±
±±º          ³Ponteirado: BE4, BAU, BA1                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function aCabSadtInt(cCodLDP,aGuia,aProcs,aHonors,aAutProcs)

Local n_J := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aArea   	:= GetArea() //Tentar solucionar o erro "Tc_eof  - No Connection on RECLOCKED(APLIB060.PRW)"
Local aLog		:= {}
Local I__f 		:= 0
Local nH 		:= PLSAbreSem("CABSADTINT.SMF")
Local cNumGuia
Local nFor
Local nTmp
Local nAux
Local aFiles
Local cAliasAux
Local nPos
Local cAliasPri
Local cCpoFase
Local aColsAux
Local cCampos
Local aStruARQ	:= {}
Local aRetCal 	:= PLSXVLDCAL(dDataBase,BA1->BA1_CODINT,.F.)//Valida o calendario de pagamento da operadora
Local cAnoBase 	:= Left(DtoS(dDataBase),4)//aRetCal[4]
Local cMesBase 	:= Substr(DtoS(dDataBase),5,2)//aRetCal[5]
Local nHESP
Local nStackSX8	:= GetSx8Len()
Local aHeaderBE2:= {}
Local nQ       	:= 0
Local lContinua := .T.
Local cTipoGui	:= "02"//SADT
Local cOriMov	:= '1'//1 = Consulta/SADT  

Alert('Passei')

Private cOpeRDA 	:= BE4->BE4_OPERDA
Private c_CodRDA 	:= BAU->BAU_CODIGO
Private cNomRDA 	:= BAU->BAU_NOME
Private cTipRDA 	:= BAU->BAU_TIPPE
Private cFunGRV
Private cTipGRV
Private cGuiRel
Private cNewPEG
Private aDadUSR := PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.T.,dDataBase/*dDatLan*/)  //busca dados do usuario a ser lancado

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe o PEG eletronico do mes para o credenciado...         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !(aRetCal[1])
	aAdd(aLog,"Nao existe calendario de pagamento para a data " + DtoC(dDataBase))
	lContinua := .F.
EndIf

If lContinua
	BCL->(DbSetOrder(1))
	If !BCL->(MsSeek(xFilial("BCL")+PLSINTPAD()+cTipoGui))
		aAdd(aLog,'ERRO: Tipo de guia nao encontrado na BCL - CODINT[ ' + PLSINTPAD() + ' ] Tipo Guia[ ' + cTipoGui + ' ]')
		lContinua := .F.
	EndIf
EndIf

If lContinua

	nHESP := PLSAbreSem("PLSPEG.SMF")
	
	BCI->(DbSetOrder(4))//BCI_FILIAL + BCI_OPERDA + BCI_CODRDA+ BCI_ANO + BCI_MES + BCI_TIPO + BCI_FASE + BCI_SITUAC + BCI_TIPGUI + BCI_CODLDP + BCI_ARQUIV                               
	
	If !BCI->(MsSeek(xFilial("BCI")+cOpeRDA+c_CodRDA+cAnoBase+cMesBase+"211" + cTipoGui + cCodLDP))//2 - incluido eletronicamente; 1-em digitacao; 1- ativo; 02 - SADT (BCL)
		
		cNewPEG := PLSA175Cod(cOpeRDA,cCodLDP)
		
		aAdd(aLog,'1 - PEG incluida [ ' + AllTrim(cNewPEG) + ' ] Local [ ' + cCodLDP + ' - ' + AllTrim(Posicione('BCG',1,xFilial('BCG') + cCodLDP,'BCG_DESCRI')) + ' ]')
		
		BCI->(RecLock("BCI",.T.))

		BCI->BCI_FILIAL := xFilial("BCI")
		BCI->BCI_CODOPE := cOpeRDA
		BCI->BCI_PROTOC := CriaVar("BCI_PROTOC")
		BCI->BCI_CODLDP := cCodLDP 
		BCI->BCI_CODPEG := cNewPEG
		BCI->BCI_OPERDA := cOpeRDA
		BCI->BCI_CODRDA := c_CodRDA
		BCI->BCI_NOMRDA := cNomRDA
		BCI->BCI_TIPSER := "01"
		BCI->BCI_TIPGUI := cTipoGui
		BCI->BCI_TIPPRE := BAU->BAU_TIPPRE
		BCI->BCI_VLRGUI := 0 
		BCI->BCI_DATREC := dDataBase
		BCI->BCI_DTDIGI := dDataBase
		BCI->BCI_QTDDIG := 1
		BCI->BCI_CODCOR := BCL->BCL_CODCOR
		BCI->BCI_FASE   := "1"
		BCI->BCI_SITUAC := "1"
		BCI->BCI_MES    := cMesBase
		BCI->BCI_ANO    := cAnoBase
		BCI->BCI_TIPO   := "2" 
		BCI->BCI_STATUS := "1"

		BCI->(MsUnLock())
		
		While GetSx8Len() > nStackSX8
			BCI->( ConfirmSX8() )
		EndDo
		
	Else
		aAdd(aLog,'1 - PEG selecionada para inclusao de guias [ ' + AllTrim(BCI->BCI_CODPEG) + ' ] Local [ ' + cCodLDP + ' - ' + AllTrim(Posicione('BCG',1,xFilial('BCG') + cCodLDP,'BCG_DESCRI')) + ' ]')
	Endif
	
	PLSFechaSem(nHESP,"PLSPEG.SMF")
	
	cGuiRel   	:= BCL->BCL_GUIREL
	cFunGRV   	:= BCL->BCL_FUNGRV
	cTipGRV   	:= BCL->BCL_TIPGRV
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicio do processo de gravacao das guias...                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aFiles := PLSA500Fil(BCI->BCI_CODOPE,BCI->BCI_TIPGUI)
	
	For nQ := 1 to len(aGuia)
		For nFor := 1 to len(aFiles)
			cAliasAux := aFiles[nFor,1]
			
			If Empty(cAliasPri)
				cAliasPri := aFiles[nFor,1]
				cNumGuia  := PLSA500NUM(cAliasPri,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
			Endif    
			
			If ( cAliasAux == 'BD5' ) .and. ( aFiles[nFor,3] == "2" )
			
				RegToMemory(cAliasAux,.T.,.F.)
	
				//Dados fixos para todos os arquivos a serem processados do contas medicas
				&("M->"+cAliasAux+"_CODOPE") := BCI->BCI_CODOPE
				&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
				&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
				&("M->"+cAliasAux+"_NUMERO") := cNumGuia
				&("M->"+cAliasAux+"_TIPGUI") := BCI->BCI_TIPGUI
				&("M->"+cAliasAux+"_ORIMOV") := cOriMov
				&("M->"+cAliasAux+"_DATDIG") := BCI->BCI_DTDIGI
				&("M->"+cAliasAux+"_ANOPAG") := BCI->BCI_ANO
				&("M->"+cAliasAux+"_MESPAG") := BCI->BCI_MES
				&("M->"+cAliasAux+"_DTDIG1") := BCI->BCI_DTDIGI
				&("M->"+cAliasAux+"_NOMEXE") := BCI->BCI_DTDIGI
				
				//Dados variados para cada arquivo que esta sendo processado
				For nAux := 1 to len(aGuia[nQ])
					&("M->"+cAliasAux+"_"+aGuia[nQ,nAux,1]) := aGuia[nQ,nAux,2]
				Next
				
				PLUPTENC(cAliasAux,CABINCLUI)
				
				If !Empty(cFunGRV)
					aPar   := {CABINCLUI,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.,cAliasPri,cTipoGui,"",cOriMov}
					cMacro := (AllTrim(cFunGRV)+"(aPar)")
					&(cMacro)
				EndIf
			
				aAdd(aLog,cValToChar(nFor + 1) + ' - Guia incluida [ ' + cNumGuia + ' ]')

			ElseIf ( cAliasAux == 'BD6' ) .and. ( aFiles[nFor,3] == "1" )
			
				RegToMemory(cAliasAux,.T.,.F.)

				For n_J := 1 to len(aProcs)

					//Dados fixos para todos os arquivos a serem processados do contas medicas
					&("M->"+cAliasAux+"_CODOPE") := BCI->BCI_CODOPE
					&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
					&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
					&("M->"+cAliasAux+"_NUMERO") := cNumGuia
					&("M->"+cAliasAux+"_TIPGUI") := BCI->BCI_TIPGUI
					&("M->"+cAliasAux+"_ORIMOV") := cOriMov
					&("M->"+cAliasAux+"_ANOPAG") := BCI->BCI_ANO
					&("M->"+cAliasAux+"_MESPAG") := BCI->BCI_MES
					&("M->"+cAliasAux+"_DTDIG1") := BCI->BCI_DTDIGI
	                
					//Dados variados para cada arquivo que esta sendo processado
					For nAux := 1 to len(aProcs[n_J])
						&("M->"+cAliasAux+"_"+aProcs[n_J,nAux,1]) := aProcs[n_J,nAux,2]
					Next
					
					PLUPTENC(cAliasAux,CABINCLUI)
					
					nRecBD6 := BD6->(Recno())
                
					//Ponteira no BD6 origem (antigo)
					BD6->(DbGoTo(BD6->BD6_XROBD6))
					                        
					//Grava na origem (antigo) o RECNO do BD6 destino (novo)
					BD6->(Reclock('BD6',.F.))
					BD6->BD6_XRDBD6 := nRecBD6
					BD6->(MsUnlock())
					
					//Bloqueia o BD6 origem (antigo)
					U_BloqBD6('UIN', 'Int. gerada automaticamente')

					//Ponteira no BD6 destino (novo)
					BD6->(DbGoTo(nRecBD6))
				
				Next

				aAdd(aLog,cValToChar(nFor + 1) + ' - Procedimentos incluidos [ ' + cValToChar(len(aProcs)) + ' ]')

			ElseIf ( cAliasAux == 'BD7' ) .and. ( aFiles[nFor,3] == "1" )

				RegToMemory(cAliasAux,.T.,.F.)

				For n_J := 1 to len(aHonors)

					//Dados fixos para todos os arquivos a serem processados do contas medicas
					&("M->"+cAliasAux+"_CODOPE") := BCI->BCI_CODOPE
					&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
					&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
					&("M->"+cAliasAux+"_NUMERO") := cNumGuia
					&("M->"+cAliasAux+"_TIPGUI") := BCI->BCI_TIPGUI
					&("M->"+cAliasAux+"_ORIMOV") := cOriMov
					&("M->"+cAliasAux+"_ANOPAG") := BCI->BCI_ANO
					&("M->"+cAliasAux+"_MESPAG") := BCI->BCI_MES
					&("M->"+cAliasAux+"_DTDIG1") := BCI->BCI_DTDIGI
					
					//Dados variados para cada arquivo que esta sendo processado
					For nAux := 1 to len(aHonors[n_J])
						&("M->"+cAliasAux+"_"+aHonors[n_J,nAux,1]) := aHonors[n_J,nAux,2]
					Next
					
					PLUPTENC(cAliasAux,CABINCLUI)
					
					nRecBD7 := BD7->(Recno())
                
					//Ponteira no BD7 origem (antigo)
					BD7->(DbGoTo(BD7->BD7_XROBD7))
					                        
					//Grava na origem (antigo) o RECNO do BD7 destino (novo)
					BD7->(Reclock('BD7',.F.))
					
					//Leonardo Portella - 31/01/13 - Inicio
					//Nao solicitar na tela - conforme PE P720GRVG
				   	
				   	If empty(BD7->BD7_CODTPA)// .or. AllTrim(BD7->BD7_CODTPA) == '0'
				   	   	BD7->(Reclock('BD7',.F.))
						BD7->BD7_CODTPA := 'H'
						BD7->(MsUnlock())
					EndIf
			        
					//Leonardo Portella - 31/01/13 - Fim
					
					BD7->BD7_XRDBD7 := nRecBD7
					BD7->(MsUnlock())
					            
					//Bloqueia o BD7 origem (antigo)
					U_BloqBD7('UIN', 'Int. gerada automaticamente')
					
					//Ponteira no BD7 destino (novo)
					BD7->(DbGoTo(nRecBD7))
                
				Next

				aAdd(aLog,cValToChar(nFor + 1) + ' - Honorarios incluidos [ ' + cValToChar(len(aHonors)) + ' ]')
			
			ElseIf ( cAliasAux == 'B43' ) .and. ( aFiles[nFor,3] == "1" )
			    
				aStruARQ := (cAliasAux)->(DbStruct())
		
				RegToMemory(cAliasAux,.T.,.F.)

				For n_J := 1 to len(aAutProcs)

					//Dados fixos para todos os arquivos a serem processados do contas medicas
					&("M->"+cAliasAux+"_OPEMOV") := BCI->BCI_CODOPE
					&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
					&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
					&("M->"+cAliasAux+"_NUMERO") := cNumGuia
					&("M->"+cAliasAux+"_ORIMOV") := cOriMov
					&("M->"+cAliasAux+"_ANOAUT") := BCI->BCI_ANO
					&("M->"+cAliasAux+"_MESAUT") := BCI->BCI_MES
						
					//Dados variados para cada arquivo que esta sendo processado
					For nAux := 1 to len(aAutProcs[n_J])
						nPos := aScan(aStruARQ, {|x| alltrim(x[1]) == cAliasAux+"_"+aAutProcs[n_J,nAux,1]}) //ascan(aStruARQ,aAutProcs[nQ,nAux,1])   //Verifica se o campo a ser gravado nesta tabela corresponde ao do array
						If nPos > 0
							&("M->"+cAliasAux+"_"+aAutProcs[n_J,nAux,1]) := aAutProcs[n_J,nAux,2]
						Endif
					Next
					
					PLUPTENC(cAliasAux,CABINCLUI)
					
				Next
                
				If ( len(aAutProcs) > 0 )
					aAdd(aLog,cValToChar(nFor + 1) + ' - Aut x Proc x Pacote incluidos [ ' + cValToChar(len(aAutProcs)) + ' ]')
				EndIf
			Else
				aAdd(aLog,cValToChar(nFor + 1) + ' - Alias[ ' + aFiles[nFor,1] + ' ] - Controle[ ' + aFiles[nFor,3] + ' ] - Gravacao nao implementada')
			Endif
		Next
	Next                        
	
	//Marco que a BE4 foi utilizada para gerar guia/PEG
	BE4->(Reclock('BE4',.F.))
	BE4->BE4_XINTISS := 'S'
	BE4->(MsUnlock())
	
	U_ValBD4Ori()
	
	//Muda a fase da guia - Ja esta ponteirado na BCL e BCI
	PLSA500FAS('BD5',,,,.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza transacao fisica...                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PLSFechaSem(nH,"CABSADTINT.SMF")

EndIf

RestArea(aArea)//Tentar solucionar o erro "Tc_eof  - No Connection on RECLOCKED(APLIB060.PRW)"

Return aLog



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Considera ponteirado no BD6³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function BloqBD6(cCodMot, cDescr, lGuiaEmConf)
                                         
Default lGuiaEmConf := .F.
     
//Funcao PLSPOSGLO posiciona em uma critica previamente cadastrada no cadastro de critica. Se a critica nao existir no cadastro o sistema inclui automaticamente
PLSPOSGLO(PlsIntPad(),cCodMot,cDescr)           

BD6->(Reclock('BD6',.F.))

//Leonardo Portella - 11/04/13 - Inicio
//O bloqueio ja e feito no BD7_BLOPAG. Quando o campo BD6_BLOPAG esta com "Sim", o padrao bloqueia todos os BD7 ao retornar a fase da guia para digitacao.
/*
BD6->BD6_BLOPAG 	:= '1'
BD6->BD6_MOTBPG 	:= cCodMot
BD6->BD6_DESBPG		:= cDescr
BD6->BD6_MOTBPF 	:= cCodMot
BD6->BD6_DESBPF		:= cDescr
*/
//Leonardo Portella - 11/04/13 - Fim

BD6->BD6_VLRAPR		:= 0
BD6->BD6_BLOCPA 	:= "1"//Bloqueia Cob. Part. Fin.? - 1=Sim;0=Nao
BD6->BD6_STATUS		:= "0"//Nao autorizada - Vermelho no BMP

If lGuiaEmConf
	BD6->BD6_ENVCON 	:= "1"//Envia para conferencia
EndIf

BD6->(MsUnlock())

Return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Considera ponteirado no BD7³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function BloqBD7(cCodCri, cDescr)

//Funcao PLSPOSGLO posiciona em uma critica previamente cadastrada no cadastro de critica. Se a critica nao existir no cadastro o sistema inclui automaticamente
PLSPOSGLO(PlsIntPad(),cCodCri,cDescr)           

BD7->(Reclock('BD7',.F.))

BD7->BD7_BLOPAG := '1' 
BD7->BD7_MOTBLO := cCodCri
BD7->BD7_DESBLO := cDescr 

BD7->(MsUnlock())

//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança
u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .T.,.T.)

Return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Considera ponteirado no BE4 e BD6³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function ValBD4Ori

Local aArea			:= GetArea()
Local aAreaBD6		:= BD6->(GetArea())
Local aAreaBD7		:= BD7->(GetArea())

If ( Select('BE4') > 0 )
	lInternacao := ( BD6->(BD6_NUMINT + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_CODRDA) == BE4->(BE4_NUMINT + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO + BE4_CODRDA) )
Else
   	lInternacao := .F.	
EndIf
    
If lInternacao  

	cChaveBD6 := BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)
	U_AtuBD7TPA(xFilial('BD6') + cChaveBD6) 
	
	lRet := .F.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³BE4_XTISS         ³
	//³1-1:Honorario     ³
	//³2-2:Evolucao      ³
	//³3-3:Tipo Fat.     ³
	//³4-11:Dt alta ori. ³
	//³12-17:Hr alta ori.³
	//³18-25:Dt alta XML ³
	//³26-31:Hr alta XML ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dAltaOri	:= StoD(Substr(BE4->BE4_XTISS,4,8))
	cHrOri		:= Substr(BE4->BE4_XTISS,12,6)
	dAltaXML	:= StoD(Substr(BE4->BE4_XTISS,18,8))
	cHrXML		:= Substr(BE4->BE4_XTISS,26,6) 
	cTipoFat	:= Substr(BE4->BE4_XTISS,3,1)
	
	If ( lAchouDt := !empty(dAltaXML) )
		dMaxProc := dAltaXML
		cMaxHrPr := cHrXML
	ElseIf ( lAchouDt := !empty(dAltaOri) )
		dMaxProc := dAltaOri
		cMaxHrPr := cHrOri
	Else
		dMaxProc := CtoD(' ')
		cMaxHrPr := Space(4)
	EndIf
	
	BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	BD6->(DbGoTop())
	
	BD6->(MsSeek(xFilial('BD6') + cChaveBD6))//Coloca o ponteiro no primeiro BD6 da guia
	
	While !BD6->(EOF()) .and. ( BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) == xFilial('BD6') + cChaveBD6 )

		If !lAchouDt .and. ( (DtoS(dMaxProc) + PadR(cMaxHrPr,6,'0')) < (DtoS(BD6->BD6_DATPRO)+ PadR(BD6->BD6_HORPRO,6,'0')) )
			dMaxProc := BD6->BD6_DATPRO 
			cMaxHrPr := BD6->BD6_HORPRO
		EndIf
 
		BD6->(DbSkip())
		
	EndDo		   	
	
	If cTipoFat == 'T'
		BE4->(Reclock('BE4',.F.))
		BE4->BE4_DTALTA := dMaxProc
		BE4->BE4_HRALTA := Left(cMaxHrPr,4)
		BE4->(MsUnlock())
	EndIf
	   	
EndIf

BD6->(RestArea(aAreaBD6))
BD7->(RestArea(aAreaBD7))
RestArea(aArea)

Return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Considera ponteirado no BE4³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function AtuBD7TPA(cChave)
        
Local cSeq 		:= PadL(Substr(BE4->BE4_XTISS,32,2),3,'0')
Local cCodBB0 	:= Substr(BE4->BE4_XTISS,34,6)

BD7->(DbSetOrder(2))//BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_CODPAD+BD7_CODPRO	 
BD7->(DbGoTop())
			   		
If BD7->(MsSeek(cChave))
   		 	
	While !BD7->(EOF()) .and. ( BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO) == cChave )

        //Nao solicitar na tela - conforme PE P720GRVG
	   	If empty(BD7->BD7_CODTPA) .or. AllTrim(BD7->BD7_CODTPA) == '0'
	   	   	BD7->(Reclock('BD7',.F.))
			BD7->BD7_CODTPA := 'H'
			BD7->(MsUnlock())
		EndIf
	   		          
	   	BD7->(DbSkip())
	 EndDo
	 
EndIf

Return



User Function VldBlqProc(cChavPEG,aProcs,lOrigem)

Local cPropri		:= '0'//Operadora
Local cCodCriExi	:= cPropri + 'EX'
Local cDesBloqExi 	:= 'Proc. existe na guia int. total'
Local cCodCriNIn	:= cPropri + 'NI'
Local cDesBloqNIn 	:= 'Proc. nao inf. na guia int. total'
Local cCodCriDHr	:= cPropri + 'DH'
Local cDesBloqDHr 	:= 'Proc. real. antes Dt/Hr Intern.'
Local lConfProNEx	:= ( GetNewPar('MV_XCOINT','S') == 'S' )//Envia para conferencia procedimentos que nao foram informados na guia de faturamento total e existiam antes.
Local lDataHorOk 	:= .T.
Local a_MatBd6		:= {}
Local l_PLSVLDINB6	:= .F.
Local a_AreaBR8		:= {}
Local a_AreaBD6		:= {}

Default lOrigem		:= .F.//Se verdadeiro a chamada eh do PLSXMVPR, caso contrario do PLNEGMFAS
Default aProcs		:= {}

BD6->(DbSetOrder(1))
BD6->(DbGoTop())
        
If BD6->(DbSeek(xFilial('BD6') + cChavPEG))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³BE4_XTISS         ³
	//³1-1:Honorario     ³
	//³2-2:Evolucao      ³
	//³3-3:Tipo Fat.     ³
	//³4-11:Dt alta ori. ³
	//³12-17:Hr alta ori.³
	//³18-25:Dt alta XML ³
	//³26-31:Hr alta XML ³
	//³32-39:Dt Proc XML ³
	//³40-45:Hr Proc XML ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cTipFat	:= Substr(BE4->BE4_XTISS,3,1)
	dDtProc := StoD(Substr(BE4->BE4_XTISS,32,8))
	cHrProc := PadR(Substr(BE4->BE4_XTISS,40,6),6)
	
	If ( cTipFat == 'T' ) .or. !lOrigem//Total ou vem do PLNEGMFAS, ou seja, esta validando a guia SADT incluida 

		While !BD6->(EOF()) .and. ( BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) == xFilial('BD6') + cChavPEG )
	                
			lDataHorOk := .T.
			
			If !empty(BD6->BD6_DATPRO) .and. !empty(BD6->BD6_HORPRO)
				lDataHorOk 	:= ( DtoS(BD6->BD6_DATPRO) + PadR(BD6->BD6_HORPRO,6,'0') ) >= ( DtoS(BE4->BE4_DATPRO) + PadR(BE4->BE4_HORPRO,6,'0') )
			EndIf

			lProcExist 	:= !empty(aProcs) .and. (aScan(aProcs,AllTrim(BD6->(BD6_CODPAD + BD6_CODPRO))) > 0)
			lSituOk		:= ( BD6->BD6_SITUAC == '1'/*ATIVA*/ ) .and. ( BD6->BD6_BLOPAG <> '1' /*Nao esta bloqueado pagamento*/ )

	        If lSituOk
				If  lProcExist .and. lOrigem

					//Condicoes para a funcao padrao PLSVLDINB6 incluir o procedimento
					l_PLSVLDINB6 := .F. 
					
					a_AreaBR8 := BR8->(GetArea())
					
					BR8->(DbSetOrder(1))//BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
					
					If BR8->(MsSeek(xFilial('BR8') + BD6->(BD6_CODPAD + BD6_CODPRO)))
					
						If AllTrim(BR8->BR8_TPPROC) $ AllTrim( GetNewPar("MV_PLSICRE","Z") )
					        
							a_AreaBD6 	:= BD6->(GetArea())
							a_MatBd6 	:= PLSCARBD6(BD6->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO),.T.)
							BD6->(RestArea(a_AreaBD6 ))
							
							//( nPos := Ascan( aMatBd6,{|x| Empty(x[1]) .And. AllTrim(x[3]+x[4]+x[9]+x[10]) == AllTrim(cCodPad+cCodPro+cDente+cFace) } ) ) > 0
							l_PLSVLDINB6 := ( (aScan( a_MatBd6,{|x| Empty(x[1]) .And. AllTrim(x[3]+x[4]) == AllTrim(BD6->(BD6_CODPAD + BD6_CODPRO)) } ) ) <= 0 )
							
						EndIf
						
					EndIf 
					
					If l_PLSVLDINB6
						//Bloqueia todos os procedimentos que ja existem na guia de faturamento total antes da importacao pois estes serao incluidos pela rotina padrao.
						U_BloqBD6(cCodCriExi, cDesBloqExi)
					EndIf
                    
					BR8->(RestArea(a_AreaBR8))

				//Leonardo Portella - 24/07/12 - Remover o bloqueio de "procedimentos realizados antes da data/hora da internacao" pois o sempre caira no regime de 
				//atendimento. Solicitado por Wallace Oliveira (CM)
				/*
				ElseIf !lDataHorOk
					//Bloqueia procedimentos realizados antes da data/hora da internacao (ja existentes)
					U_BloqBD6(cCodCriDHr, cDesBloqDHr, lConfProNEx)
				*/                                                                    

				//Leonardo Portella - 10/09/12 - Inicio - Incluido verificacao para nao glosar caso seja tabela Simpro/Brasindice - "Todo assistido Caberj/Integral sem 
				//excessoes tem direito a utilizar materiais e medicacoes sob qualquer circunstancia" - Solicitado por Wallace Oliveira - Chamado ID 3463

				ElseIf !lProcExist .and. lOrigem

					If !( BD6->BD6_CODPAD $ '05|09' ) //Nao eh Simpro/Brasindice

						BR8->(DbSetOrder(1))
						
						If BR8->(MsSeek(xFilial('BR8') + BD6->( BD6_CODPAD + BD6_CODPRO )))

							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³BR8_TPPROC            ³
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³'0','Procedimento'    ³
							//³'1','Material'        ³
							//³'2','Medicamento'     ³
							//³'3','Taxas'           ³
							//³'4','Diarias'         ³
							//³'5','Ortese/Protese'  ³
							//³'6','Pacote'          ³
							//³'7','Gases Medicinais'³
							//³'8','Alugueis'		 ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³Procedimentos (Cirurgias) e Ortese/Protese - Wallace Oliveira informou que somente    ³
							//³para estes a critica deve ser utilizada                                               ³
							//³BR8_TIPEVE e BR8_REGATD => 2 = internacao; 3 = ambos (mas estou em guia de internacao)³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							If ( BR8->BR8_TPPROC == '0' .and. ( BR8->BR8_TIPEVE $ '2|3' .or. BR8->BR8_REGATD $ '2|3') ) ;
								.or. ( BR8->BR8_TPPROC == '5' )
							    
								//Classe de procedimentos: Materiais Medicos e Medicamento
								If !( AllTrim(BR8->BR8_CLASSE) $ '000007|000008' )
								
									//Bloqueia todos os procedimentos que nao foram informados na guia de faturamento total antes da importacao.
									U_BloqBD6(cCodCriNIn, cDesBloqNIn, lConfProNEx) 
									
								EndIf
								
							EndIf
							
						EndIf

					EndIf

				//Leonardo Portella - 10/09/12 - Fim

				EndIf
			EndIf

			BD6->(DbSkip())

		EndDo
	
	EndIf

EndIf
        
//Nunca bloquear BD7 conforme solicitacao Leandro CM
/*
BD7->(DbSetOrder(1))
BD7->(DbGoTop())

If BD7->(DbSeek(xFilial('BD7') + cChavPEG))

	While !BD7->(EOF()) .and. ( BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO ) == xFilial('BD7') + cChavPEG ) 

		lDataHorOk := .T.
		
		If !empty(dDtProc) .and. !empty(cHrProc)
			lDataHorOk 	:= ( DtoS(dDtProc) + PadR(cHrProc,6,'0') ) >= ( DtoS(BE4->BE4_DATPRO) + PadR(BE4->BE4_HORPRO,6,'0') )
		EndIf
		
		lProcExist 	:= !empty(aProcs) .and. (aScan(aProcs,AllTrim(BD7->(BD7_CODPAD + BD7_CODPRO))) > 0)
		lSituOk		:= ( BD7->BD7_SITUAC == '1' ) .and. ( BD7->BD7_BLOPAG <> '1' )//ATIVA e nao esta bloqueado pagamento
                
         If lSituOk
			If lProcExist
				//Bloqueia todos os honorarios dos procedimentos que ja existem na guia de faturamento total antes da importacao pois estes serao incluidos 
				//pela rotina padrao
				U_BloqBD7(cCodCriExi, cDesBloqExi)
			
			//Leonardo Portella - 24/07/12 - Remover o bloqueio de "procedimentos realizados antes da data/hora da internacao" pois o sempre caira no regime de 
			//atendimento. Solicitado por Wallace Oliveira (CM)
			
			//ElseIf !lDataHorOk
			//	//Bloqueia procedimentos realizados antes da data/hora da internacao (ja existentes)
			//	U_BloqBD7(cCodCriDHr, cDesBloqDHr)
			//
			
			ElseIf !lProcExist
				//Bloqueia todos os honorarios dos procedimentos que nao informados na guia de faturamento total antes da importacao.
				U_BloqBD7(cCodCriNIn, cDesBloqNIn)
			EndIf
		EndIf

		BD7->(DbSkip())
	EndDo

EndIf
*/
        
Return


