#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tela para selecionar e apos imprimir as carteirinhas de associado a serem impressas.³
//³Relatorio em Crystal que imprime as carteirinhas.                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CABR075

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cIDsInt		:= ''
Local cIDsOdo		:= ''
Local cIDsMat		:= ''
Local cIDsRec 		:= ''

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")
Private oNaoImpr 	:= LoadBitMap(GetResources(),"BR_VERDE")
Private Impresso 	:= LoadBitMap(GetResources(),"BR_VERMELHO")
Private aCartAss	:= {}         
Private lConfirm	:= .F.
Private aIDsSelec 	:= {}
Private aPesq		:= {'Lote','Nome','Matricula'}
Private cCombo 		:= aPesq[1]   
Private cCombo2 	:= 'Nao impressos'
Private nOpca		:= 0     
Private nTam		:= Len(UsrFullName(RetCodUsr()))
Private cBusca		:= Space(nTam)
Private lPalChave	:= .F.  
Private oDlg 		:= nil
Private oBrowse		:= nil
Private oSBtn1     	:= Nil
Private oSBtn2     	:= Nil
Private bPesq		:= {||.T.,nOpca := Pesquisa(aCartAss,cCombo,allTrim(cBusca),lPalChave,oBrowse:nAt),If(nOpca > 0,(oBrowse:nAt := nOpca, oBrowse:Refresh()),)}
Private aCab		:= {" "," ","Lote","Empresa","Nome","Validade","Matricula","Plano",'Cab/Int','Dental'}
Private aTam		:= {20,50,50,100,50,80,50}
Private bDesMarca	:= {||aCartAss := DesMarca(aCartAss)}
Private lBuffer		:= .F.
Private lUnicaMar 	:= .F.
Private nFiltro		:= 0

nFiltro := Aviso('Filtro','Selecione os registros:',{'Nao impres.','Ambos'})

MakeDlg(nFiltro <> 1)

If lConfirm 
	
	For i := 1 to len(aCartAss)
		//Concatena os IDs para depois passar para o Crystal imprimir
		If aCartAss[i][1]
		    
			Do Case
			        
				Case AllTrim(aCartAss[i][10]) == 'SIM'//Odontologico
					cIDsOdo += If(!empty(cIDsOdo),',','') + cValToChar(aCartAss[i][len(aCartAss[i])])
				
				Case Substr(AllTrim(aCartAss[i][7]),6,4) == '0004'//Reciprocidade
					cIDsRec += If(!empty(cIDsRec),',','') + cValToChar(aCartAss[i][len(aCartAss[i])])

				Case AllTrim(aCartAss[i][9]) == 'INTEGRAL'
				    cIDsInt += If(!empty(cIDsInt),',','') + cValToChar(aCartAss[i][len(aCartAss[i])])
				    
				Case AllTrim(aCartAss[i][9]) == 'CABERJ'
					cIDsMat += If(!empty(cIDsMat),',','') + cValToChar(aCartAss[i][len(aCartAss[i])])
				
			EndCase
			
		EndIf
		
	Next
	
	If !empty(cIDsOdo)
		Processa({||PrintCart(cIDsOdo,'DENTAL')},'Crystal Reports')
	EndIf
	
	If !empty(cIDsRec)
		Processa({||PrintCart(cIDsRec,'RECIPROCIDADE')},'Crystal Reports')
	EndIf

	If !empty(cIDsInt)
		Processa({||PrintCart(cIDsInt,'INTEGRAL')},'Crystal Reports')
	EndIf
	
	If !empty(cIDsMat)
		Processa({||PrintCart(cIDsMat,'MATER')},'Crystal Reports')
	EndIf

EndIf

Return 

*********************************************************************************************************

Static Function DesMarca(aDes)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

For i := 1 to len(aDes)
	aDes[i][1] := .F.
Next

Return aDes

*********************************************************************************************************

Static Function MakeDlg(lImpressos)

Default lImpressos := .F.

Processa({||aCartAss := BuscCart(lImpressos)})

oDlg := MSDialog():New(0,0,510,850,"Seleção de carteiras a serem impressas",,,.F.,,,,,,.T.,,,.T. )

    oCombo1 := TComboBox():New(010,010,{|u|If(PCount()>0,cCombo:=u,cCombo)},aPesq,40,20,oDlg,,bPesq,,,,.T.,,,,,,,,,'cCombo')
    
	oGet1 	:= TGet():New( 010,50,{|u|If(PCount()>0,cBusca:=u,cBusca),cBusca := PadR(cBusca,nTam)},oDlg,208,008,'',bPesq,CLR_BLACK,CLR_WHITE,,,,.T.,'',,,.F.,.F.,bPesq,.F.,.F.,"","cBusca",,)

	oCheck1 := TCheckBox():New(010,260,'Palavra-chave',{||lPalChave},oDlg,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
	oCheck1:bLClicked := {||lPalChave := !lPalChave}

	bClick 	:= {||lBuffer := !aCartAss[oBrowse:nAt,1],If(lUnicaMar,Eval(bDesMarca),),aCartAss[oBrowse:nAt,1] := lBuffer, oBrowse:Refresh()}                                                                          

	oBrowse 	:= TcBrowse():New(030,010,410,190,,aCab,aTam,oDlg,,,,,bClick,,,,,,,.F.,,.T.,,.F.,,, )
	oBrowse:SetArray(aCartAss) 

	oBrowse:bLine := {||{If(aCartAss[oBrowse:nAt,1],oOk,oNo)	 		,;
						If(aCartAss[oBrowse:nAt,2],Impresso,oNaoImpr)	,;
						aCartAss[oBrowse:nAt,3]  		   				,;
						aCartAss[oBrowse:nAt,4] 					 	,;
						aCartAss[oBrowse:nAt,5]					,;
						StoD(aCartAss[oBrowse:nAt,6])							,;
						aCartAss[oBrowse:nAt,7]							,;
						aCartAss[oBrowse:nAt,9]  						,;
						aCartAss[oBrowse:nAt,10]  						,;
						aCartAss[oBrowse:nAt,11]						}}  
						
	oBrowse:nScrollType := 1 // Scroll VCR

  	oSBtn1     	:= SButton():New(230,365,1,{||lConfirm := .T.,oDlg:End()}	,oDlg,,"", )
	oSBtn2     	:= SButton():New(230,395,2,{||oDlg:End()}					,oDlg,,"", )

oDlg:Activate(,,,.T.)

Return

***********************************************************************************

Static Function BuscCart(lImpressos)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
      
Local aRet 		:= {}
Local aUsers	:= {}
Local nQtd 		:= 0
Local nCont		:= 0
Local cTot 		:= ""
Local cQryAss	:= ''
Local cAliasAss	:= GetNextAlias()

Default lImpressos	:= .T.

ProcRegua(0)

For i := 1 to 5
	IncProc('Selecionando registros...')
Next

cQryAss := "SELECT *" 			  	 												+ CRLF
cQryAss += "FROM CART_ASSOCIADO"  	 												+ CRLF
cQryAss += "WHERE CAB_INT = '" + If(cEmpAnt == '01','CABERJ','INTEGRAL') + "'"		+ CRLF

If !lImpressos
	cQryAss += "AND NVL(LOGIN_IMPRES,' ') = ' '" 									+ CRLF
EndIf

cQryAss += "ORDER BY LOTE, NOME, MATRICULA"		 									+ CRLF

TcQuery cQryAss New Alias cAliasAss

COUNT TO nQtd

ProcRegua(nQtd)

cAliasAss->(DbGoTop())

While !cAliasAss->(EOF())

    IncProc('Carteirinha ' + cValToChar(++nCont) + ' de ' + cTot)

    aAdd(aRet,{.F.,										;
    				!empty(cAliasAss->(LOGIN_IMPRES)),	;
    				cAliasAss->(LOTE),					;
    				cAliasAss->(EMPRESA),				;
    				cAliasAss->(NOME),					;
    				cAliasAss->(VALIDADE),				;
    				cAliasAss->(MATRICULA),			 	;
    				cAliasAss->(PLANO),					;
    				cAliasAss->(CAB_INT),	 			;
    				cAliasAss->(ODONTO),	   			;
    				cAliasAss->(ID) 			 		})
    
    cAliasAss->(DbSkip())

EndDo

cAliasAss->(DbCloseArea())

Return aRet

*********************************************************************************************************

Static Function Pesquisa(aCartAss,cCombo,cBusca,lPalChave,nAt)
    
Local nOpca := nAt

If !empty(cBusca)

	Do Case
	
		Case cCombo == 'Nome'
		
			If lPalChave
				nOpca := aScan(aCartAss,{|x| Upper(cBusca) $ Upper(x[5]) }, nAt + 1)
			Else
				nOpca := aScan(aCartAss,{|x| Upper(cBusca) == left(Upper(x[5]),len(cBusca)) }, nAt + 1)
			EndIf
		
		Case cCombo == 'Matricula'
		
			cBusca := StrTran(StrTran(cBusca,'.',''),'-','')
			
			If lPalChave
				nOpca := aScan(aCartAss,{|x| Upper(cBusca) $ Upper(StrTran(StrTran(x[7],'.',''),'-','')) }, nAt + 1)
			Else
				nOpca := aScan(aCartAss,{|x| Upper(cBusca) == left(Upper(StrTran(StrTran(x[7],'.',''),'-','')),len(cBusca)) }, nAt + 1)
			EndIf
			
		Case cCombo == 'Lote'
		                       
			nOpca := aScan(aCartAss,{|x| cBusca $ x[3] }, nAt + 1)

	EndCase

EndIf

Return nOpca

*********************************************************************************************************

Static Function PrintCart(cIDs,cOpcao)
        
Local nJ			:= 0

Private cUpd		:= ""
Private cParams		:= ""
Private cParImpr	:="1;0;1;Impressão de carteirinhas de associados"       

ProcRegua(0)

For nJ := 0 to 5
	IncProc('Comunicação com Crystal Reports - ' + cOpcao)
Next
        
cParams := cIDs        

Do Case

	Case cOpcao == 'RECIPROCIDADE'

		CallCrys("CARTAO_INTEGRAL",cParams,cParImpr) 
	
	Case cOpcao == 'INTEGRAL'

		CallCrys("CARTAO_INTEGRAL",cParams,cParImpr) 
		
	Case cOpcao == 'DENTAL'
	
		CallCrys("CARTAO_DENTAL",cParams,cParImpr) 
		
	Case cOpcao == 'MATER'
	
		CallCrys("CARTAO_MATER",cParams,cParImpr) 
		
EndCase

cUpd 	:= "UPDATE CART_ASSOCIADO SET QTD_IMPRES = NVL(QTD_IMPRES,0) + 1,"		+ CRLF //Quantidade impressa
cUpd 	+= "DT_IMPRESSAO = '" + DtoS(Date()) + "',"				 			+ CRLF //Data de impressao
cUpd 	+= "HR_IMPRESSAO = '" + Time() + "',"						 			+ CRLF //Hora da impressao
cUpd 	+= "LOGIN_IMPRES = '" + AllTrim(UsrRetName(RetCodUsr())) + "'"			+ CRLF //Login
cUpd 	+= "WHERE ID IN (" + cParams + ")"

If ( TcSqlExec(cUpd) < 0 )    
	MsgStop("Erro na atualização de dados da tabela 'CART_ASSOCIADO'" + CRLF + CRLF + TcSqlError(),AllTrim(SM0->M0_NOMECOM)) 
EndIf
		
Return

