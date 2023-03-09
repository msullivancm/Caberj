#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
//#INCLUDE 'UTILIDADES.CH'
#INCLUDE "FWMVCDEF.CH"

#DEFINE PLS__ALIAS 	"B53"
#DEFINE PLS_TITULO 	STR0001 //"Guias em Analise"
#DEFINE PLS_CORLIN 	"#D6E4EA"
#DEFINE PLS_MODELO 	"PLSA790M"
#define __aCdCri585 {"585","Quantidade de diarias Solicitadas diferente do Configurado na Tabela Padrao"} //"Quantidade de diarias Solicitadas diferente do Configurado na Tabela Padrao"}
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSAUDBT    ºAutor  ³Angelo Henrique   º Data ³  29/02/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada utilizado para incluir novas opções no menuº±±
±±º          ³das ações relacionadas no menu de auditoria.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSAUDBT
	
	//Leonardo Portella - 20/02/17 - Início
	
	Local aArea		:= GetArea()
	Local aRetorno
	Local aSubRot 	:= {}
	Local _nPosAn	:= Ascan(aRotina,{|x| AllTrim(x[1]) == "Analisar" 			 })
	Local _nPosEv	:= Ascan(aRotina,{|x| AllTrim(x[1]) == "Evolução de intern." })
	
	aAdd(aSubRot,{"Libera Guia"		, 'U_FFLIPAUD()' 	,0 	,0 })
	aAdd(aSubRot,{'Histórico Msg' 	, 'U_MSGAUD()' 		,0	,0 })
	
	//---------------------------------------------------------------------------------------
	//Conforme solicitado é necessário liberar a opção de Auditoria OPME
	//na tela da própria auditoria, pois alguns auditores dão
	//prosseguimento ao processo, dessa forma remove a necessidade de
	//se abrir duas telas
	//---------------------------------------------------------------------------------------
	
	aAdd(aSubRot,{'Auditoria/OPME' 	, 'U_AUDOPME()' 	,0	,0 })
	
	//---------------------------------------------------------------------------------------
	
	aRetorno := {'Outras opções', aSubRot}
	
	//-----------------------------------------------
	//Angelo Henrique - Data: 20/03/2017
	//Correção das criticas na auditoria
	//-----------------------------------------------
	If _nPosAn > 0 //Analise da Auditoria
		
		//--------------------------------------------------------------
		//Atualizo a chamada da rotina padrão para pimeiro
		//chamar a rotina que irá atualizar as tabelas que
		//a auditoria tem deletado e depois mando a rotina seguir
		//a chamada padrão
		//--------------------------------------------------------------
		aRotina[_nPosAn][2] := "U_ATUAUD('1')"
		
	EndIf
	
	If _nPosEv > 0 //Evolução da Internação
		
		//--------------------------------------------------------------
		//Atualização da tabela para o processo de Evolução
		//--------------------------------------------------------------
		aRotina[_nPosEv][2] := "U_ATUAUD('2')"
		
	EndIf
	//-----------------------------------------------
	//Angelo Henrique - Data: 20/03/2017 - Fim
	//-----------------------------------------------
	
	RestArea(aArea)
	
	//Return {"Libera Guia","U_FFLIPAUD"}
	
	//Leonardo Portella - 20/02/17 - Fim
	
Return aRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FFLIPAUD    ºAutor  ³Angelo Henrique   º Data ³  29/02/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para liberar a reserva efetuada.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FFLIPAUD
	
	Local _cMsg 		:= ""
	Local _aArea		:= GetArea()
	Local _aAreaB53	:= B53->(GetArea())
	Local _aAreaB72	:= B72->(GetArea())
	Local cUpdate		:= ""
	Local cTabCrit	:= ""
	
	_cMsg := "Beneficiário: "  + B53->B53_NOMUSR + CHR(10) + CHR(13)
	_cMsg += "Reservado por: " + Alltrim(USRFULLNAME(B53->B53_OPERAD)) + CHR(10) + CHR(13)
	_cMsg += ". Deseja continuar?"
	
	If MsgYesNo(_cMsg)
		
		If B53->B53_ALIMOV $ 'BE4,BEA'
			
			B72->(DbSetOrder(1))
			If B72->(MsSeek(xFilial("B72")+B53->(B53_ALIMOV+B53_RECMOV) ))
				
				While !B72->(Eof()) .And. B53->(B53_ALIMOV+B53_RECMOV) == B72->(B72_ALIMOV+B72_RECMOV)
					
					If B72->B72_PARECE == '2'
						
						If B72->B72_ALIMOV == 'BE4'
							
							cTabCrit:= 'BEL'
							
							cUpdate := " UPDATE "	+ RetSqlName(cTabCrit)		+ " SET "	+ cTabCrit + "_OPERAD = ' ' "
							cUpdate += " WHERE "		+ RetSqlName(cTabCrit)		+ ".D_E_L_E_T_ = ' ' "
							cUpdate += "AND "			+ cTabCrit	+ "_FILIAL = '" 	+ xFilial(cTabCrit)				+ "' "
							cUpdate += "AND "			+ cTabCrit	+ "_CODOPE = '" 	+ SubStr(B53->B53_NUMGUI,1,4)  	+ "' "
							cUpdate += "AND "			+ cTabCrit	+ "_ANOINT = '" 	+ SubStr(B53->B53_NUMGUI,5,4)  	+ "' "
							cUpdate += "AND "			+ cTabCrit	+ "_MESINT = '" 	+ SubStr(B53->B53_NUMGUI,9,2)  	+ "' "
							cUpdate += "AND "			+ cTabCrit	+ "_NUMINT = '" 	+ SubStr(B53->B53_NUMGUI,11,8) 	+ "' "
							cUpdate += "AND "			+ cTabCrit	+ "_SEQUEN = '" 	+ B72->B72_SEQPRO					+ "' "
							
						Else
							
							cTabCrit := 'BEG'
							
							cUpdate := " UPDATE "	+ RetSqlName(cTabCrit) 		+ " SET " + cTabCrit + "_OPERAD = ' ' "
							cUpdate += " WHERE "		+ RetSqlName(cTabCrit) 		+ ".D_E_L_E_T_ = ' ' "
							cUpdate += "AND "			+ cTabCrit+ "_FILIAL = '" 	+ xFilial(cTabCrit)				+ "' "
							cUpdate += "AND "			+ cTabCrit+ "_OPEMOV = '" 	+ SubStr(B53->B53_NUMGUI,1,4)	+ "' "
							cUpdate += "AND "			+ cTabCrit+ "_ANOAUT = '" 	+ SubStr(B53->B53_NUMGUI,5,4)	+ "' "
							cUpdate += "AND "			+ cTabCrit+ "_MESAUT = '" 	+ SubStr(B53->B53_NUMGUI,9,2)	+ "' "
							cUpdate += "AND "			+ cTabCrit+ "_NUMAUT = '" 	+ SubStr(B53->B53_NUMGUI,11,8)	+ "' "
							cUpdate += "AND "			+ cTabCrit+ "_SEQUEN = '" 	+ B72->B72_SEQPRO					+ "' "
							
						EndIf
						
						If TcSqlExec(cUpdate ) < 0
							
							MsgStop("Ocorreu um erro interno ao tentar liberar a guia. Entre em contato com a equipe de T.I. ")
							
						EndIf
						
					EndIf
					
					B72->(DbSkip())
					
				EndDo
				
			EndIf
			
		EndIf
		
		B53->(RecLock("B53", .F.))
		
		B53->B53_SITUAC := "0"
		B53->B53_OPERAD := ""
		
		B53->(MsUnlock())
		
		MsgAlert("Reserva do auditor foi removida com sucesso.")
		
	EndIf
	
	RestArea(_aAreaB72)
	RestArea(_aAreaB53)
	RestArea(_aArea)
	
Return

//****************************************************************************************************************************************************

//Leonardo Portella - 03/03/17 - Exibe as mensagens anteriores de auditoria

User Function MSGAUD(cOpcao)
	
	Local aArea 	:= GetArea()
	Local aAreaZZ6	:= ZZ6->(GetArea())
	Local nI
	Local lFim		:= .F.
	Local cScript	:= ''
	local cEmpb53   := ''//Motta
	
	Default cOpcao	:= 'AUDITORIA'
	
	//Motta
	If cEmpAnt = "01"
		cEmpb53 := 'CAB'
	Else
		cEmpb53 := 'INT'
	Endif
	
	//hml alto custo inicio
	If cOpcao == 'AUDITORIA'
		
		//Verifica se a solicitação já foi criada com mensagem.
		cScript := "BEGIN"  													                          	+ CRLF
		cScript += "LIBERA.STATUS_AUDITADAS( " + "'" + cEmpb53 + "'," + cValToChar(B53->(RECNO())) + " );"	+ CRLF//Motta
		cScript += "COMMIT;"													                        	+ CRLF
		cScript += "END;"														                        	+ CRLF
		
		If TcSqlExec(cScript) < 0
			LogErros('Erro ao inserir verificar status da mensagem [ STATUS_AUDITADAS ]' + CRLF + TcSqlError())
		EndIf
		
	EndIf
	
	While !lFim
		
		aRecs 	:= aRecsMural(B53->B53_MATUSU, B53->B53_NUMGUI, cOpcao)
		
		aRet 	:= LogAudit(aRecs, cOpcao)
		lFim 	:= aRet[1]
		cOpcao 	:= aRet[2]
		
	EndDo
	//hml alto custo inicio
	ZZ6->(RestArea(aAreaZZ6))
	RestArea(aArea)
	
Return

//***************************************************************************************************************************

//Leonardo Portella - 03/03/17 - Seleciona os registros a serem exibidos

Static Function aRecsMural(cMatric, cNumGui, cOpcao)
	
	Local aArea 	:= GetArea()
	Local cAlias	:= GetNextAlias()
	Local cQry
	Local aRet 		:= {}
	
	cOpcao := AllTrim(Upper(cOpcao))
	
	cQry := "SELECT ZZ6.R_E_C_N_O_ RECZZ6" 															+ CRLF
	cQry += "FROM " + RetSqlName('ZZ6') + " ZZ6" 													+ CRLF
	cQry += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1_FILIAL = '" + xFilial('BA1') + "'" 	+ CRLF
	cQry += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + cMatric + "'" 	+ CRLF
	cQry += "  AND BA1.D_E_L_E_T_ = ' '" 															+ CRLF
	cQry += "WHERE ZZ6_FILIAL = '" + xFilial('ZZ6') + "'" 											+ CRLF
	cQry += "  AND ZZ6_MATVID = BA1_MATVID" 														+ CRLF
	
	If cOpcao == 'AUDITORIA'
		
		cQry += "  AND ZZ6_CODOPE = '" + Substr(cNumGui,1,4) + "'" 									+ CRLF
		cQry += "  AND ZZ6_ANOGUI = '" + Substr(cNumGui,5,4) + "'" 									+ CRLF
		cQry += "  AND ZZ6_MESGUI = '" + Substr(cNumGui,9,2) + "'" 									+ CRLF
		cQry += "  AND ZZ6_NUMGUI = '" + Substr(cNumGui,11,8) + "'" 								+ CRLF
		cQry += "  AND ZZ6_ALIAS = 'BEA'" 															+ CRLF
		
	EndIf
	
	cQry += "  AND ZZ6.D_E_L_E_T_ = ' '" 															+ CRLF
	cQry += "ORDER BY ZZ6_DATA DESC, ZZ6_HORA DESC"													+ CRLF
	
	
	TcQuery cQry New Alias (cAlias)
	
	While !(cAlias)->(EOF())
		
		aAdd(aRet, (cAlias)->RECZZ6)
		
		(cAlias)->(DbSkip())
		
	EndDo
	
	
	if select(cAlias) > 0
		dbselectarea(cAlias)
		(cAlias)->(DbCloseArea())
	endif
	
	RestArea(aArea)
	
Return aRet

//***************************************************************************************************************************

//Leonardo Portella - 03/03/17 - Tela de exibição de mensagem anteriores, gravadas no mural (ZZ6)

Static Function LogAudit(aRecs, cOpcao, lAudXVida)
	
	Local aArea 		:= GetArea()
	Local aAreaZZ6 		:= ZZ6->(GetArea())
	Local nSpinBox
	Local nI
	Local aItens		:= {'Auditoria','Vida'}
	Local bChangeCB
	
	Local nPos			:= 0
	Local lFim 			:= .T.
	
	Default lAudXVida 	:= .T.
	
	Private cMGet1		:= ' '
	Private cMGet2		:= ' '
	Private cMGet3		:= ' '
	Private aRecMsg		:= {}
	Private cCombo1		:= ''
	
	Default  aRecs		:= {}
	cOpcao 		:= AllTrim(Upper(cOpcao))
	
	If ( nPos := aScan(aItens,{|x|Upper(AllTrim(x)) == cOpcao}) ) > 0
		cCombo1		:= aItens[nPos]
	Else
		cCombo1		:= aItens[1]
	EndIf
	
	bChangeCB 	:= 	{|| lFim 	:= .F.,;
		cOpcao 	:= cCombo1,;
		oDlg1:End();
		}
	
	aSort(aRecs,,,{|x,y| x > y})
	
	For nI := 1 to len(aRecs)
		aAdd(aRecMsg,{aRecs[nI], len(aRecs) - nI + 1})
	Next
	
	If len(aRecs) > 3
		nSpinBox	:= len(aRecs) - 2
	Else
		nSpinBox	:= 1
	EndIf
	
	SetPrvt("oDlg1","oGrp1","oSay1","oGrp2","oMGet1","oGrp3","oMGet2","oGrp4","oMGet3","oSBtn1")
	
	oDlg1      	:= MSDialog():New( 101,243,739,1305,"Mensagens" + If(cOpcao == 'AUDITORIA'," auditoria",""),,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      	:= TGroup():New( 004,005,284,529,If(cOpcao == 'AUDITORIA',"Auditoria ","") + "- " + StrZero(len(aRecs),3) + ' mensage' + If(len(aRecs) > 1,'ns','m') ,oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	
	oSay1      	:= TSay():New( 014,013,{||"Exibir mensagens a partir da: "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,080,008)
	
	oSpinBox 	:= TSpinBox():New(011, 85, oGrp1, {|x| nSpinBox := x, AtuMulGet(nSpinBox)}, 30, 13,"Selecione a partir de qual mensagem deverá será exibido. Mensagens em ordem decrescente de tempo.")
	oSpinBox:SetRange(1, len(aRecs))
	oSpinBox:SetStep(1)
	oSpinBox:SetValue(nSpinBox)
	
	oSay2      	:= TSay():New( 014,130,{||"Mensagens da:"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,080,008)
	
	oCombo1 	:= TComboBox():New(012, 170,{|u|If(PCount()>0,cCombo1:=u,cCombo1)},aItens,100,20,oDlg1,,bChangeCB,,,,.T.,,,,,,,,,'cCombo1')
	
	If !lAudXVida
		oCombo1:Disable()
	EndIf
	
	oTBitmap1 	:= TBitmap():New(010,495,015,015,,"",.T.,oGrp1,,,.F.,.F.,,,.F.,,.T.,,.F.)
	oTBitmap1:Load("CLOCK01")
	
	oTBitmap2 	:= TBitmap():New(010,508,015,015,,"",.T.,oGrp1,,,.F.,.F.,,,.F.,,.T.,,.F.)
	oTBitmap2:Load("PMSSETAUP")
	
	oGrp2      	:= TGroup():New( 028,013,104,521," ",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oMGet1     	:= TMultiGet():New( 036,020,{|u| If(PCount()>0,cMGet1:=u,cMGet1)},oGrp2,495,060,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
	oMGet1:lReadOnly := .T.
	oMGet1:GoTop()
	
	oGrp3      	:= TGroup():New( 112,013,188,521," ",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oMGet2     	:= TMultiGet():New( 120,020,{|u| If(PCount()>0,cMGet2:=u,cMGet2)},oGrp3,495,060,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
	oMGet2:lReadOnly := .T.
	oMGet2:GoTop()
	
	oGrp4      	:= TGroup():New( 196,013,276,521," ",oGrp1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oMGet3     	:= TMultiGet():New( 204,020,{|u| If(PCount()>0,cMGet3:=u,cMGet3)},oGrp4,495,060,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
	oMGet3:lReadOnly := .T.
	oMGet3:GoTop()
	
	oSBtn1     	:= SButton():New( 288,504,1,{||oDlg1:End()},oDlg1,,"", )
	
	AtuMulGet(nSpinBox)
	
	oDlg1:Activate(,,,.T.)
	
	ZZ6->(RestArea(aAreaZZ6))
	RestArea(aArea)
	
Return { lFim, cOpcao }

//***************************************************************************************************************************

//Leonardo Portella - 03/03/17 - Função auxiliar da LogAudit. Atualiza os MGets

Static Function AtuMulGet(nSpinBox)
	
	Local nSpin		:= nSpinBox
	Local nMsg01
	Local nMsg02
	Local nMsg03	:= aScan(aRecMsg,{|x|x[2] == nSpinBox})
	Local nAux 		:= 0
	
	If ( nMsg03 == 0 ) .or. ( len(aRecs) == 0 )
		
		nMsg01 	:= 0
		nMsg02 	:= 0
		nMsg03	:= 0
		
	ElseIf nMsg03 == 1
		
		nMsg01 	:= 1
		nMsg02 	:= 0
		nMsg03	:= 0
		
	ElseIf nMsg03 == 2
		
		nMsg01 	:= 1
		nMsg02 	:= 2
		nMsg03	:= 0
		
	ElseIf nMsg03 >= 3
		
		nMsg01 	:= nMsg03 - 2
		nMsg02 	:= nMsg03 - 1
		
	EndIf
	
	AtuMGets(	1,;//ID do MGet
	IIf(nMsg01 > 0,aRecMsg[nMsg01, 1],0),;//Recno ZZ6
	IIf(nMsg01 > 0,aRecMsg[nMsg01, 2],0),,;//Numeração da mensagem
	)
	
	AtuMGets(	2,;//ID do MGet
	IIf(nMsg02 > 0,aRecMsg[nMsg02, 1],0),;//Recno ZZ6
	IIf(nMsg02 > 0,aRecMsg[nMsg02, 2],0),,;//Numeração da mensagem
	)
	
	AtuMGets(	3,;//ID do MGet
	IIf(nMsg03 > 0,aRecMsg[nMsg03, 1],0),;//Recno ZZ6
	IIf(nMsg03 > 0,aRecMsg[nMsg03, 2],0),,;//Numeração da mensagem
	)
	
Return

//***************************************************************************************************************************

//Leonardo Portella - 03/03/17 - Função auxiliar da AtuMulGet. Atualiza os MGets individualmente

Static Function AtuMGets(nGet, nRec, nMsg)
	
	Local lSemMsg := .F.
	
	If nRec > 0
		ZZ6->(DbGoTo(nRec))
	Else
		lSemMsg := .T.
	EndIf
	
	Do Case
		
	Case nGet == 1
		
		If !lSemMsg
			oGrp2:cCaption 	:= "Mensagem " + StrZero(nMsg,3) + " - " + DtoC(ZZ6->ZZ6_DATA) + ' ' + Left(ZZ6->ZZ6_HORA,2) + ':' + Right(ZZ6->ZZ6_HORA,2) + ' - ' + AllTrim(Upper(ZZ6->ZZ6_OPER))
			cMGet1			:= AllTrim(Upper(ZZ6->ZZ6_TEXTO))
		Else
			oGrp2:cCaption 	:= "Sem mensagem"
			cMGet1	:= ' '
		EndIf
		
		oMGet1:GoTop()
		
	Case nGet == 2
		
		If !lSemMsg
			oGrp3:cCaption 	:= "Mensagem " + StrZero(nMsg,3) + " - " + DtoC(ZZ6->ZZ6_DATA) + ' ' + Left(ZZ6->ZZ6_HORA,2) + ':' + Right(ZZ6->ZZ6_HORA,2) + ' - ' + AllTrim(Upper(ZZ6->ZZ6_OPER))
			cMGet2			:= AllTrim(Upper(ZZ6->ZZ6_TEXTO))
		Else
			oGrp3:cCaption 	:= "Sem mensagem"
			cMGet2	:= ' '
		EndIf
		
		oMGet2:GoTop()
		
	Case nGet == 3
		
		If !lSemMsg
			oGrp4:cCaption 	:= "Mensagem " + StrZero(nMsg,3) + " - " + DtoC(ZZ6->ZZ6_DATA) + ' ' + Left(ZZ6->ZZ6_HORA,2) + ':' + Right(ZZ6->ZZ6_HORA,2) + ' - ' + AllTrim(Upper(ZZ6->ZZ6_OPER))
			cMGet3			:= AllTrim(Upper(ZZ6->ZZ6_TEXTO))
		Else
			oGrp4:cCaption 	:= "Sem mensagem"
			cMGet3	:= ' '
		EndIf
		
		oMGet3:GoTop()
		
	EndCase
	
Return

//***************************************************************************************************************************

//Obs: Quando criado um fonte com o nome PLSANALM.PRW o botão de "Parecer" desapareceu. Após muitos testes descobriu-se que
//não poderia ser criado o ponto de entrada com o mesmo nome e por isso este ponto de entrada está nesta função.

//Leonardo Portella - 06/03-17 - Ponto de entrada no parecer da auditoria criado pelo model (PLSANALM) do FWMBrose
//do Padrão (PLSA790V - FWLoadModel)

User Function PLSANALM
	
	Local aArea			:= GetArea()
	Local aAreaBEA		:= BEA->(GetArea())
	Local aAreaBE4		:= BE4->(GetArea())
	Local xRet 			:= .T.
	Local oObj 			:= ''
	Local cIdPonto 		:= ''
	Local cIdModel 		:= ''
	
	If ( len(PARAMIXB) >= 3 )
		
		oObj 		:= PARAMIXB[1]
		cIdPonto 	:= PARAMIXB[2]
		cIdModel 	:= PARAMIXB[3]
		
		Do Case
			
		Case cIdPonto == 'BUTTONBAR' //Adiciona botão
			
			xRet := { {'Histórico Msg', 'CLOCK01', { || U_MSGAUD() }, 'Exibe histórico de mensagens' } }
			
		Case cIdPonto == 'MODELVLDACTIVE' //No início da criação da tela
			
			AtuParecer()
			
		Case cIdPonto == 'MODELCOMMITTTS' //Dentro do controle de transação
			
			AtuParecer()
			
		Case cIdPonto == 'MODELCOMMITNTTS' //ultimo ponto apos confirmar
			
			//------------------------------------------------------------------
			// Angelo Henrique - Data: 1/03/2016
			//------------------------------------------------------------------
			//Rotina que realiza as atualizações nas tabelas de internação
			//para o processo de OPME e auditoria
			//------------------------------------------------------------------
			U_PLS790GR()
			
		EndCase
		
	EndIf
	
	BEA->(RestArea(aAreaBEA))
	BE4->(RestArea(aAreaBE4))
	RestArea(aArea)
	
Return xRet

//*************************************************************************************************

//Leonardo Portella - 06/03-17 - Transforma a B72 em uma linha do mural, caso esteja preenchido. Limpa a observação
//pois ela já se tornou uma linha do mural.

Static Function AtuParecer
	
	Local aArea 	:= GetArea()
	Local aAreaBA1 	:= BA1->(GetArea())
	Local aAreaB72 	:= B72->(GetArea())
	Local aAreaZZ6 	:= ZZ6->(GetArea())
	Local aAreaB53 	:= B53->(GetArea())
	Local cID_Item
	Local cID_MSG
	Local cAlias    := GetNextAlias()
	
	If !empty(AllTrim(B72->B72_OBSANA))
		
		cMatVid := Posicione('BA1',2,xFilial('BA1') + B53->B53_MATUSU,'BA1_MATVID')
		
		cQry := "SELECT NVL(MAX(R_E_C_N_O_),0) RECNO"			+ CRLF
		cQry += "FROM " + RetSqlName('ZZ6') 					+ CRLF
		cQry += "WHERE ZZ6_FILIAL = '" + xFilial('ZZ6') + "'" 	+ CRLF
		cQry += "	AND ZZ6_MATVID = '" + cMatVid + "'" 		+ CRLF
		cQry += "	AND D_E_L_E_T_ = ' '" 						+ CRLF
		
		TcQuery cQry New Alias (cAlias)
		
		If ( (cAlias)->RECNO > 0 )
			ZZ6->(DbGoTo((cAlias)->RECNO))
			cNextSeq := StrZero(Val(ZZ6->ZZ6_SEQ) + 1, 3)
		Else
			cNextSeq := StrZero(1, 3)
		EndIf
		
		if select(cAlias) > 0
			dbselectarea(cAlias)
			(cAlias)->(DbCloseArea())
		endif
		
		RestArea(aArea)
		
		If B53->B53_ALIMOV == 'BEA'
			BEA->(DbGoTo(Val(B53->B53_RECMOV)))
			c_Senha := BEA->BEA_SENHA
		Else
			
			BE4->(DbGoTo(Val(B53->B53_RECMOV)))
			if type("x_senha") == "C"
				if !empty(x_senha)
					if x_senha # BE4->BE4_SENHA
						
						RecLock("BE4")
						BE4->BE4_SENHA := x_senha
						BE4->(MsUnLock())
						
					endif
				endif
			endif
			
			
			
			c_Senha := BE4->BE4_SENHA
			
		EndIf
		
		ZZ6->(Reclock("ZZ6", .T.))
		
		ZZ6->ZZ6_FILIAL := xFilial("ZZ6")
		
		ZZ6->ZZ6_SEQ	:= cNextSeq
		ZZ6->ZZ6_DATA  	:= Date()
		ZZ6->ZZ6_HORA  	:= Left(Replace(Time(),':',''),4)
		ZZ6->ZZ6_CODOPE := B53->B53_CODOPE
		ZZ6->ZZ6_ANOGUI := Substr(B53->B53_NUMGUI,5,4)
		ZZ6->ZZ6_MESGUI := Substr(B53->B53_NUMGUI,9,2)
		ZZ6->ZZ6_NUMGUI := Substr(B53->B53_NUMGUI,11,8)
		ZZ6->ZZ6_MATVID := cMatVid
		ZZ6->ZZ6_ALIAS 	:= B53->B53_ALIMOV
		ZZ6->ZZ6_SENHA 	:= c_Senha
		ZZ6->ZZ6_USU	:= "4" //Auditor
		ZZ6->ZZ6_NOMUSR	:= B53->B53_NOMUSR
		ZZ6->ZZ6_OPER	:= Upper(AllTrim(UsrFullName(RetCodUsr())))
		ZZ6->ZZ6_TEXT1	:= "PARECER DO AUDITOR"
		ZZ6->ZZ6_TEXTO 	:= 'AUDITORIA [ ' + B53->B53_NUMGUI + ' ] ' 														    	+ ;
			'EVENTO [ ' + B72->B72_CODPAD + ' - ' + AllTrim(B72->B72_CODPRO) + ' - ' 													+ ;
			Upper(AllTrim(Posicione('BR8',1,xFilial('BR8') + B72->B72_CODPAD + B72->B72_CODPRO,'BR8_DESCRI'))) + ' ]'  + CRLF + CRLF 	+ ;
			AllTrim(B72->B72_OBSANA)
		
		ZZ6->(MsUnlock())
		
		B72->(Reclock('B72',.F.))
		
		B72->B72_OBSANA := ' '
		
		B72->(MsUnlock())
		
		//hml alto custo inicio
		If ( B53->B53_XIDAUT > 0 ) .And. B72->B72_PARECE = "2"
			
			//Envio da mensagem para a Operativa
			
			cQry := "SELECT ID_ITEM"																				+ CRLF
			cQry += "FROM OPERATIVA.AUT_PROCEDIMENTOS_ITENS"														+ CRLF
			cQry += "WHERE ID_AUT = " + cValToChar(B53->B53_XIDAUT)  												+ CRLF
			cQry += "	AND TISS_TABELA_REFERENCIA = '" + If(B72->B72_CODPAD == '16','22',B72->B72_CODPAD) + "'"	+ CRLF
			cQry += "	AND TISS_CODIGO_PROC = '" + AllTrim(B72->B72_CODPRO)	+ "'"								+ CRLF
			
			TcQuery cQry New Alias (cAlias)
			
			If !(cAlias)->(EOF())
				cID_Item := cValToChar((cAlias)->ID_ITEM)
			Else
				MsgStop('Erro - mensagem não será enviada para a Operativa. Não localizou o item.', AllTrim(SM0->M0_NOMECOM))
			EndIf
			
			if select(cAlias) > 0
				dbselectarea(cAlias)
				(cAlias)->(DbCloseArea())
			endif
			
			cQry := "SELECT NVL(MAX(ID_ITEM),0) + 1 ID_MSG"				+ CRLF
			cQry += "FROM OPERATIVA.AUT_PROCEDIMENTOS_MSG"				+ CRLF
			cQry += "WHERE ID_AUT = " + cValToChar(B53->B53_XIDAUT)		+ CRLF
			cQry += "	AND ID_ITEM = " + cID_Item 						+ CRLF
			
			TcQuery cQry New Alias (cAlias)
			
			If !(cAlias)->(EOF())
				cID_MSG := cValToChar((cAlias)->ID_MSG)
			Else
				MsgStop('Erro - mensagem não será enviada para a Operativa. Não localizou msg.', AllTrim(SM0->M0_NOMECOM))
			EndIf
			
			if select(cAlias) > 0
				dbselectarea(cAlias)
				(cAlias)->(DbCloseArea())
			endif
			
			
			RestArea(aArea)
			
			If !empty(cID_Item)
				
				//TISS_STATUS_SOLIC = 5 - AGUARDANDO DOCUMENTACAO DO PRESTADOR
				
				cScript := "BEGIN" 																								+ CRLF
				cScript += " "	 																								+ CRLF
				cScript += "INSERT INTO OPERATIVA.AUT_PROCEDIMENTOS_MSG ( ID_AUT, ID_ITEM, ID_MSG, ORIGEM, MENSAGEM ) VALUES " 	+ CRLF
				cScript += "( " 																								+ CRLF
				cScript += cValToChar(B53->B53_XIDAUT) + ','																	+ CRLF
				cScript += cID_Item + ","																						+ CRLF
				cScript += cID_MSG + ","																						+ CRLF
				cScript += "'CAB',"																								+ CRLF
				cScript += "UTL_RAW.CAST_TO_RAW('" + AllTrim(ZZ6->ZZ6_TEXTO) + "')"												+ CRLF
				cScript += ");" 																								+ CRLF
				cScript += " "	 																								+ CRLF
				cScript += "UPDATE OPERATIVA.AUT_PROCEDIMENTOS SET TISS_STATUS_SOLIC = '5'"										+ CRLF
				cScript += "WHERE ID_AUT = " + cValToChar(B53->B53_XIDAUT) + ";"												+ CRLF
				cScript += " "	 																								+ CRLF
				cScript += "LIBERA.ENVIA_OPERATIVA(" + cValToChar(B53->B53_XIDAUT) + "," + cID_Item + "," + cID_MSG + ");"		+ CRLF
				cScript += " "	 																								+ CRLF
				cScript += "END;" 																								+ CRLF
				
				If TcSqlExec(cScript) < 0
					LogErros('Erro ao inserir mensagem na tabela [ OPERATIVA.AUT_PROCEDIMENTOS_MSG ]. ID_AUT [ ' + cValToChar(B53->B53_XIDAUT) + ' ], ID_ITEM [ ' + cID_Item + ' ], ID_MSG (novo) [ ' + cID_MSG + ' ]: ' + CRLF + TcSqlError())
				EndIf
				
			EndIf
			
		EndIf
		//hml alto custo fim
		
		
	EndIf
	
	B53->(RestArea(aAreaB53))
	BA1->(RestArea(aAreaBA1))
	B72->(RestArea(aAreaB72))
	ZZ6->(RestArea(aAreaZZ6))
	RestArea(aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATUAUD      ºAutor  ³Angelo Henrique   º Data ³  20/03/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina chamada antes do processo de analise de auditoria    º±±
±±º          ³pois a rotina padrão em alguns momentos limpava as criticas º±±
±±º          ³impedindo assim o auditor de realizar o processo de auditoria±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ATUAUD(_cParam)
	
	Local _aArea 	:= GetArea()
	Local _aAr53 	:= B53->(GetArea())
	Local _aArEJ 	:= BEJ->(GetArea())
	Local _aArEL 	:= BEL->(GetArea())
	Local _aArB4 	:= BE4->(GetArea())
	Local _lPrs		:= .T.
	Local cQry		:= ""
	Local (cAliQry) := GetNextAlias()
	Local _cExec	:= ""
	Local _ni		:= 0
	Local _cCdSeq 	:= ""
	Local _cCdGlo 	:= ""
	Local _cSqCri 	:= ""
	Local _nRecB53  := B53->(recno())
	
	Private  x_senha
	Private cRet     := ""
	//1 _ processo de analise || 2 - processo de evolução da internação.
	Default _cParam := "1" //Parametro definido para saber em que momento a rotina esta sendo chamado
	
	
	If B53->B53_STATUS == "1"
		
		_lPrs := .F.
		Help("Esta guia ja foi analisada",1,"EXBMHELP")
		
	EndIf
	
	If B53->B53_OPERAD != RETCODUSR() .And. _lPrs
		
		_lPrs := .F.
		Help("Guia reservada para outro Operador",1,"EXBMHELP")
		
	EndIf
	
	//Rotina de analise a tabela que deve ser olhada é a BEL
	If _cParam == "1"
		
		//-----------------------------------------------------------------------------
		//Se passar por todas as validações criadas irá de fato entrar na rotina
		//-----------------------------------------------------------------------------
		If _lPrs
			
			//-----------------------------------------------------
			//Varrer se a rotina excluiu os dados da BEL
			//Em alguns momentos ela se perde e entende
			//que a analise da guia já foi efetuada
			//e por isso ele deleta as informações
			//-----------------------------------------------------
			cQry := " SELECT " 	+ CRLF
			cQry += " 	BEL.BEL_CODOPE, BEL.BEL_SEQUEN, BEL.BEL_CODGLO, BEL.BEL_DESGLO, " 	+ CRLF
			cQry += " 	BEL.BEL_INFGLO, BEL.BEL_ANOINT, BEL.BEL_MESINT, BEL.BEL_NUMINT, " 	+ CRLF
			cQry += " 	BEL.BEL_SEQCRI " 	+ CRLF
			cQry += " FROM  " + RetSqlName('BEL') + " BEL " + CRLF
			cQry += " WHERE " + CRLF
			cQry += " 	BEL.BEL_CODOPE 		= '" + SUBSTR(B53->B53_NUMGUI,1,4) + "' " 	+ CRLF
			cQry += " 	AND BEL.BEL_ANOINT 	= '" + SUBSTR(B53->B53_NUMGUI,5,4) + "' " 	+ CRLF
			cQry += " 	AND BEL.BEL_MESINT 	= '" + SUBSTR(B53->B53_NUMGUI,9,2) + "' " 	+ CRLF
			cQry += " 	AND BEL.BEL_NUMINT 	= '" + SUBSTR(B53->B53_NUMGUI,11 ) + "' " 	+ CRLF
			cQry += " 	AND BEL.BEL_PENDEN 	= '1' " 	+ CRLF
			cQry += " 	AND BEL.D_E_L_E_T_ 	= '*' " 	+ CRLF //VARRER SÓ OS DELETADOS
			
			TcQuery cQry New Alias (cAliQry)
			
			If !(cAliQry)->(EOF())
				
				While !(cAliQry)->(EOF())
					
					_cExec := " UPDATE " + CRLF
					_cExec += RetSqlName("BEL") + " BEL " + CRLF
					_cExec += " SET BEL.D_E_L_E_T_ = ' '"  + CRLF
					_cExec += " WHERE " + CRLF
					_cExec += " 	BEL.BEL_SEQUEN 		= '" + (cAliQry)->BEL_SEQUEN + "' " + CRLF
					_cExec += " 	AND BEL.BEL_SEQCRI 	= '" + (cAliQry)->BEL_SEQCRI + "' " + CRLF
					_cExec += " 	AND BEL.BEL_CODOPE 	= '" + (cAliQry)->BEL_CODOPE + "' " + CRLF
					_cExec += " 	AND BEL.BEL_ANOINT 	= '" + (cAliQry)->BEL_ANOINT + "' " + CRLF
					_cExec += " 	AND BEL.BEL_MESINT 	= '" + (cAliQry)->BEL_MESINT + "' " + CRLF
					_cExec += " 	AND BEL.BEL_NUMINT 	= '" + (cAliQry)->BEL_NUMINT + "' " + CRLF
					
					TCSQLEXEC(_cExec)
					
					(cAliQry)->(DbSkip())
					
				EndDo
				
			Else
				
				(cAliQry)->(DbCloseArea())
				
				//---------------------------------------------------------------
				//Se não achar nenhum deletado, verifico se existe criado
				//em alguns momentos a rotina não cria as informações na
				//tabela BEL, impedindo assim o auditor de prosseguir
				//---------------------------------------------------------------
				cQry := " SELECT " 	+ CRLF
				cQry += " 	BEJ.BEJ_CODOPE, BEJ.BEJ_SEQUEN, BEJ.BEJ_QTDPRO, BEJ.BEJ_CODPAD, " 	+ CRLF
				cQry += " 	BEJ.BEJ_ANOINT, BEJ.BEJ_MESINT, BEJ.BEJ_NUMINT, BEJ.BEJ_STATUS, " 	+ CRLF
				cQry += " 	BEJ.BEJ_CHVNIV, BEJ.BEJ_DATPRO 									" 	+ CRLF
				cQry += " FROM  " + RetSqlName('BEJ') + " BEJ " + CRLF
				cQry += " WHERE " + CRLF
				cQry += " 	BEJ.BEJ_CODOPE 		= '" + SUBSTR(B53->B53_NUMGUI,1,4)  + "' " + CRLF
				cQry += " 	AND BEJ.BEJ_ANOINT 	= '" + SUBSTR(B53->B53_NUMGUI,5,4) 	+ "' " 	+ CRLF
				cQry += " 	AND BEJ.BEJ_MESINT 	= '" + SUBSTR(B53->B53_NUMGUI,9,2) 	+ "' " 	+ CRLF
				cQry += " 	AND BEJ.BEJ_NUMINT 	= '" + SUBSTR(B53->B53_NUMGUI,11 ) 	+ "' " 	+ CRLF
				cQry += " 	AND BEJ.BEJ_STATUS 	= '0' " 	+ CRLF //NÃO AUTORIZADO
				cQry += " 	AND BEJ.D_E_L_E_T_ 	= ' ' " 	+ CRLF
				
				TcQuery cQry New Alias (cAliQry)
				
				While !(cAliQry)->(EOF())
					
					DbSelectArea("BEL")
					DbSetOrder(1) //BEL_FILIAL + BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT + BEL_SEQUEN
					If !(DbSeek(xFilial("BEL") + (cAliQry)->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT+BEJ_SEQUEN)))
						
						//------------------------------------------------------------------
						//Criando duas linhas de critica para o processo prosseguir
						//------------------------------------------------------------------
						For _ni := 1 To 2
							
							RecLock("BEL", .T.)
							
							BEL->BEL_CODOPE	:= (cAliQry)->BEJ_CODOPE
							BEL->BEL_SEQUEN	:= (cAliQry)->BEJ_SEQUEN
							
							If _ni = 1
								
								BEL->BEL_CODGLO	:= "025"
								BEL->BEL_DESGLO	:= "Para este procedimento necessita pericia medica."
								BEL->BEL_INFGLO	:= " "
								
							Else
								
								BEL->BEL_CODGLO	:= " "
								BEL->BEL_DESGLO	:= "025 - Nivel: BRV - Planos e Grupos de Cobertura"
								BEL->BEL_INFGLO	:= "02 - Atualizacoes / Produto Saude / Produto Saude --> Folder Cobertura/Carencias / Grupos Determinados"
								
							Endif
							
							BEL->BEL_ANOINT	:= (cAliQry)->BEJ_ANOINT
							BEL->BEL_MESINT	:= (cAliQry)->BEJ_MESINT
							BEL->BEL_NUMINT	:= (cAliQry)->BEJ_NUMINT
							BEL->BEL_TIPO	:= "1"
							BEL->BEL_SEQCRI	:= u_CNTBEL() //FAZER CONTADOR
							
							BEL->(MsUnlock())
							
						Next _ni
						
					EndIf
					
					(cAliQry)->(DbSkip())
					
				EndDo
				
			EndIf
			
			(cAliQry)->(DbCloseArea())
			
		EndIf
		
	EndIf
	
	//Rotina de evolução da internação, a tabela que deve ser olhada é a BQZ
	If _cParam == "2"
		
		//-----------------------------------------------------------------------------
		//Se passar por todas as validações criadas irá de fato entrar na rotina
		//-----------------------------------------------------------------------------
		If _lPrs
			
			//-----------------------------------------------------------------------------
			//Limpando a tabela B67 (Itens de critica, processo de evolução da internação)
			//-----------------------------------------------------------------------------
			cQry := " SELECT  " 	+ CRLF
			cQry += "      B67_OPEMOV, B67_ANOAUT, B67_MESAUT, B67_NUMAUT " 	+ CRLF
			cQry += " FROM   " + RetSqlName('B67') + " B67 " + CRLF
			cQry += " WHERE  " 	+ CRLF
			cQry += "     B67.B67_OPEMOV = '" + SUBSTR(B53->B53_NUMGUI,1,4) + "' " 	+ CRLF
			cQry += "     AND B67.B67_ANOAUT = '" + SUBSTR(B53->B53_NUMGUI,5,4) + "' " 	+ CRLF
			cQry += "     AND B67.B67_MESAUT = '" + SUBSTR(B53->B53_NUMGUI,9,2) + "' " 	+ CRLF
			cQry += "     AND B67.B67_NUMAUT = '" + SUBSTR(B53->B53_NUMGUI,11 ) + "' " 	+ CRLF
			
			TcQuery cQry New Alias (cAliQry)
			
			If !(cAliQry)->(EOF())
				
				_cExec := " DELETE FROM " + CRLF
				_cExec += RetSqlName("B67") + " B67 " + CRLF
				_cExec += " WHERE " + CRLF
				_cExec += "  	B67.B67_OPEMOV 		= '" + (cAliQry)->B67_OPEMOV + "' " + CRLF
				_cExec += " 	AND B67.B67_ANOAUT 	= '" + (cAliQry)->B67_ANOAUT + "' " + CRLF
				_cExec += " 	AND B67.B67_MESAUT 	= '" + (cAliQry)->B67_MESAUT + "' " + CRLF
				_cExec += " 	AND B67.B67_NUMAUT 	= '" + (cAliQry)->B67_NUMAUT + "' " + CRLF
				
				TCSQLEXEC(_cExec)
				
			EndIf
			
			(cAliQry)->(DbCloseArea())
			
			//----------------------------------------------------------------
			// INICIO - Varrer os itens da BQZ para ver se tem duplicidade
			// a Rotina no Padrão estava duplicando itens e bloqueando o
			// processo.
			//----------------------------------------------------------------
			cQry := " SELECT " 	+ CRLF
			cQry += " 	BQZ.BQZ_CODOPE, BQZ.BQZ_SEQUEN, BQZ.BQZ_CODGLO, BQZ.BQZ_DESGLO, " 	+ CRLF
			cQry += " 	BQZ.BQZ_INFGLO, BQZ.BQZ_ANOINT, BQZ.BQZ_MESINT, BQZ.BQZ_NUMINT,  " 	+ CRLF
			cQry += " 	BQZ.BQZ_SEQCRI " 	+ CRLF
			cQry += " FROM  " + RetSqlName('BQZ') + " BQZ " + CRLF
			cQry += " WHERE " + CRLF
			cQry += " 	BQZ.BQZ_CODOPE 		= '" + SUBSTR(B53->B53_NUMGUI,1,4) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_ANOINT 	= '" + SUBSTR(B53->B53_NUMGUI,5,4) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_MESINT 	= '" + SUBSTR(B53->B53_NUMGUI,9,2) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_NUMINT 	= '" + SUBSTR(B53->B53_NUMGUI,11 ) + "' " 	+ CRLF
			cQry += " ORDER BY BQZ.BQZ_SEQCRI		" 	+ CRLF
			
			TcQuery cQry New Alias (cAliQry)
			
			If !(cAliQry)->(EOF())
				
				_nCntQz := 1
				
				_cCdSeq := (cAliQry)->BQZ_SEQUEN
				_cCdGlo := (cAliQry)->BQZ_CODGLO
				_cSqCri := (cAliQry)->BQZ_SEQCRI
				
				While !(cAliQry)->(EOF())
					
					If _nCntQz != 1
						
						If (cAliQry)->BQZ_SEQUEN = _cCdSeq .And. (cAliQry)->BQZ_CODGLO = _cCdGlo .And. (cAliQry)->BQZ_SEQCRI = _cSqCri
							
							
							_cExec := " DELETE 	" + CRLF
							_cExec += " FROM 	" + CRLF
							_cExec += "		" + RetSqlName("BQZ") + " BQZ " + CRLF
							_cExec += " WHERE " + CRLF
							_cExec += " 	BQZ.BQZ_SEQUEN 		= '" + (cAliQry)->BQZ_SEQUEN + "' " + CRLF
							_cExec += " 	AND BQZ.BQZ_SEQCRI 	= '" + (cAliQry)->BQZ_SEQCRI + "' " + CRLF
							_cExec += " 	AND BQZ.BQZ_CODOPE 	= '" + (cAliQry)->BQZ_CODOPE + "' " + CRLF
							_cExec += " 	AND BQZ.BQZ_ANOINT 	= '" + (cAliQry)->BQZ_ANOINT + "' " + CRLF
							_cExec += " 	AND BQZ.BQZ_MESINT 	= '" + (cAliQry)->BQZ_MESINT + "' " + CRLF
							_cExec += " 	AND BQZ.BQZ_NUMINT 	= '" + (cAliQry)->BQZ_NUMINT + "' " + CRLF
							
							TCSQLEXEC(_cExec)
							
							//----------------------------------------------------
							//Após deletar pula para o próximo registro
							//prosseguindo com a validação
							//----------------------------------------------------
							(cAliQry)->(DbSkip())
							
							_cCdSeq := (cAliQry)->BQZ_SEQUEN
							_cCdGlo := (cAliQry)->BQZ_CODGLO
							_cSqCri := (cAliQry)->BQZ_SEQCRI
							
						Else
							
							(cAliQry)->(DbSkip())
							
						EndIf
						
					EndIf
					
					_nCntQz ++
					
				EndDo
				
			EndIf
			//----------------------------------------------------------------
			// FIM - Varrer os itens da BQZ para ver se tem duplicidade
			//----------------------------------------------------------------
			
			//-----------------------------------------------------
			//Varrer se a rotina excluiu os dados da BQZ
			//Em alguns momentos ela se perde e entende
			//que a analise da guia já foi efetuada
			//e por isso ele deleta as informações
			//-----------------------------------------------------
			(cAliQry)->(DbCloseArea())
			
			cQry := " SELECT " 	+ CRLF
			cQry += " 	BQZ.BQZ_CODOPE, BQZ.BQZ_SEQUEN, BQZ.BQZ_CODGLO, BQZ.BQZ_DESGLO, " 	+ CRLF
			cQry += " 	BQZ.BQZ_INFGLO, BQZ.BQZ_ANOINT, BQZ.BQZ_MESINT, BQZ.BQZ_NUMINT,  " 	+ CRLF
			cQry += " 	BQZ.BQZ_SEQCRI " 	+ CRLF
			cQry += " FROM  " + RetSqlName('BQZ') + " BQZ " + CRLF
			cQry += " WHERE " + CRLF
			cQry += " 	BQZ.BQZ_CODOPE 		= '" + SUBSTR(B53->B53_NUMGUI,1,4) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_ANOINT 	= '" + SUBSTR(B53->B53_NUMGUI,5,4) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_MESINT 	= '" + SUBSTR(B53->B53_NUMGUI,9,2) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_NUMINT 	= '" + SUBSTR(B53->B53_NUMGUI,11 ) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_PENDEN 	<> '0' 	" 	+ CRLF
			cQry += " 	AND BQZ.D_E_L_E_T_ 	= '*'  	" 	+ CRLF //VARRER SÓ OS DELETADOS
			cQry += " ORDER BY BQZ.BQZ_SEQCRI		" 	+ CRLF
			
			TcQuery cQry New Alias (cAliQry)
			
			If !(cAliQry)->(EOF())
				
				While !(cAliQry)->(EOF())
					
					_cExec := " UPDATE " + CRLF
					_cExec += RetSqlName("BQZ") + " BQZ " + CRLF
					_cExec += " SET BQZ.D_E_L_E_T_ = ' '" + CRLF
					_cExec += " WHERE " + CRLF
					_cExec += " 	BQZ.BQZ_SEQUEN 		= '" + (cAliQry)->BQZ_SEQUEN + "' " + CRLF
					_cExec += " 	AND BQZ.BQZ_SEQCRI 	= '" + (cAliQry)->BQZ_SEQCRI + "' " + CRLF
					_cExec += " 	AND BQZ.BQZ_CODOPE 	= '" + (cAliQry)->BQZ_CODOPE + "' " + CRLF
					_cExec += " 	AND BQZ.BQZ_ANOINT 	= '" + (cAliQry)->BQZ_ANOINT + "' " + CRLF
					_cExec += " 	AND BQZ.BQZ_MESINT 	= '" + (cAliQry)->BQZ_MESINT + "' " + CRLF
					_cExec += " 	AND BQZ.BQZ_NUMINT 	= '" + (cAliQry)->BQZ_NUMINT + "' " + CRLF
					
					TCSQLEXEC(_cExec)
					
					(cAliQry)->(DbSkip())
					
				EndDo
				
			Else
				
				(cAliQry)->(DbCloseArea())
				
				//---------------------------------------------------------------
				//Se não achar nenhum deletado, verifico se existe criado
				//em alguns momentos a rotina não cria as informações na
				//tabela BEL, impedindo assim o auditor de prosseguir
				//---------------------------------------------------------------
				cQry := " SELECT " 	+ CRLF
				cQry += " 	BQV.BQV_CODOPE, BQV.BQV_SEQUEN, BQV.BQV_QTDPRO, BQV.BQV_CODPRO, " 	+ CRLF
				cQry += " 	BQV.BQV_ANOINT, BQV.BQV_MESINT, BQV.BQV_NUMINT, BQV.BQV_STATUS, " 	+ CRLF
				cQry += " 	BQV.BQV_CHVNIV													" 	+ CRLF
				cQry += " FROM  " + RetSqlName('BQV') + " BQV " + CRLF
				cQry += " WHERE " + CRLF
				cQry += " 	BQV.BQV_CODOPE 		= '" + SUBSTR(B53->B53_NUMGUI,1,4)  + "' "  + CRLF
				cQry += " 	AND BQV.BQV_ANOINT 	= '" + SUBSTR(B53->B53_NUMGUI,5,4) 	+ "' " 	+ CRLF
				cQry += " 	AND BQV.BQV_MESINT 	= '" + SUBSTR(B53->B53_NUMGUI,9,2) 	+ "' " 	+ CRLF
				cQry += " 	AND BQV.BQV_NUMINT 	= '" + SUBSTR(B53->B53_NUMGUI,11 ) 	+ "' " 	+ CRLF
				cQry += " 	AND BQV.BQV_STATUS 	= '0' " 	+ CRLF //NÃO AUTORIZADO
				cQry += " 	AND BQV.D_E_L_E_T_ 	= ' ' " 	+ CRLF
				
				TcQuery cQry New Alias (cAliQry)
				
				While !(cAliQry)->(EOF())
					
					DbSelectArea("BQZ")
					DbSetOrder(1) //BQZ_FILIAL + BQZ_CODOPE + BQZ_ANOINT + BQZ_MESINT + BQZ_NUMINT + BQZ_SEQUEN
					If !(DbSeek(xFilial("BQZ") + (cAliQry)->(BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT+BQV_SEQUEN)))
						
						//------------------------------------------------------------------
						//Criando duas linhas de critica para o processo prosseguir
						//------------------------------------------------------------------
						For _ni := 1 To 2
							
							RecLock("BQZ", .T.)
							
							BQZ->BQZ_CODOPE	:= (cAliQry)->BQV_CODOPE
							BQZ->BQZ_SEQUEN	:= (cAliQry)->BQV_SEQUEN
							
							If _ni = 1
								
								BQZ->BQZ_CODGLO	:= "025"
								BQZ->BQZ_DESGLO	:= "Para este procedimento necessita pericia medica."
								BQZ->BQZ_INFGLO	:= " "
								
							Else
								
								BQZ->BQZ_CODGLO	:= " "
								BQZ->BQZ_DESGLO	:= "025 - Nivel: BRV - Planos e Grupos de Cobertura"
								BQZ->BQZ_INFGLO	:= "02 - Atualizacoes / Produto Saude / Produto Saude --> Folder Cobertura/Carencias / Grupos Determinados"
								
							Endif
							
							BQZ->BQZ_ANOINT	:= (cAliQry)->BQV_ANOINT
							BQZ->BQZ_MESINT	:= (cAliQry)->BQV_MESINT
							BQZ->BQZ_NUMINT	:= (cAliQry)->BQV_NUMINT
							BQZ->BQZ_SEQCRI	:= u_CNTBQZ() //FAZER CONTADOR
							BQZ->BQZ_PENDEN	:= '1'
							BQZ->(MsUnlock())
							
						Next _ni
						
					EndIf
					
					(cAliQry)->(DbSkip())
					
				EndDo
				
			EndIf
			
			(cAliQry)->(DbCloseArea())
			
		EndIf
		
	EndIf
	
	//----------------------------------------------------
	//Se for internação o tipo na B53 deve estar como 3
	//o padrão em alguns momentos estava preenchendo como
	//consulta.
	//----------------------------------------------------
	If B53->B53_ALIMOV == "BE4"
		
		If B53->B53_TIPO != "3"
			
			RecLock("B53", .F.)
			
			B53->B53_TIPO := "3"
			
			B53->(MsUnlock())
			
		EndIf
		
	EndIf
	
	If _cParam == "1" //Analise da Auditoria.
		
		DbSelectArea("BE4")
		DbSetOrder(2) //BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
		If DbSeek(xFilial("BE4") + B53->B53_NUMGUI)
			x_senha := BE4->BE4_SENHA
			//---------------------------------------------------
			//Chama a rotina padrão de analise da auditoria
			//---------------------------------------------------
			u_CABAANA(0)   // função padrão ajustada para um melhor funcionamento = 21/12/2017 - Mateus
			//PLS790ANA(0) // comentada por estar gerando inconsistencias nos registros de auditoria = 21/12/2017 - Mateus
		Else
			
			//u_CABAANA(0)
			u_CABAANA(0)
			
		Endif
		
	ElseIf _cParam = "2" //Evolução da Internação
		
		PLS790ANA(2)
		//u_CABAANA(2)
		//-----------------------------------------------------------
		//Se for diferente de autorizada
		//é necessário verificar se esta
		//correto, pois a rotina em alguns
		//momentos esta se perdendo
		//-----------------------------------------------------------
		If B53->B53_STATUS != "1"
			
			//-----------------------------------------------------
			//Varrer se ainda existem itens na BQZ para serem
			//analisados.
			//se todos estiveres autorizados realizo a alteração
			//do status na internnação, pois o padrão esta tratando
			//de forma incorreta o processo
			//-----------------------------------------------------
			cQry := " SELECT " 	+ CRLF
			cQry += " 	BQZ.BQZ_CODOPE, BQZ.BQZ_SEQUEN, BQZ.BQZ_CODGLO, BQZ.BQZ_DESGLO, " 	+ CRLF
			cQry += " 	BQZ.BQZ_INFGLO, BQZ.BQZ_ANOINT, BQZ.BQZ_MESINT, BQZ.BQZ_NUMINT,  " 	+ CRLF
			cQry += " 	BQZ.BQZ_SEQCRI " 	+ CRLF
			cQry += " FROM  " + RetSqlName('BQZ') + " BQZ " + CRLF
			cQry += " WHERE " + CRLF
			cQry += " 	BQZ.BQZ_CODOPE 		= '" + SUBSTR(B53->B53_NUMGUI,1,4) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_ANOINT 	= '" + SUBSTR(B53->B53_NUMGUI,5,4) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_MESINT 	= '" + SUBSTR(B53->B53_NUMGUI,9,2) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_NUMINT 	= '" + SUBSTR(B53->B53_NUMGUI,11 ) + "' " 	+ CRLF
			cQry += " 	AND BQZ.BQZ_PENDEN 	<> '1' " 	+ CRLF //Pendente 0=Não;1=Sim (Em alguns casos fica em branco também)
			cQry += " 	AND BQZ.D_E_L_E_T_ 	= ' '  " 	+ CRLF
			
			TcQuery cQry New Alias (cAliQry)
			
			If (cAliQry)->(EOF())
				
				RecLock("B53", .F.)
				
				B53->B53_STATUS := "1" //AUTORIZADA
				
				BE4->(MsUnLock())
				
				
			EndIf
			
			(cAliQry)->(DbCloseArea())
			
		EndIf
		
		DbSelectArea("BE4")
		DbSetOrder(2) //BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
		If DbSeek(xFilial("BE4") + B53->B53_NUMGUI)
			
			//-------------------------------------------------------------------------------
			//Se o status estiver com 1 = Autorizada ou 2 = Autorizada parcialmente
			//-------------------------------------------------------------------------------
			//Deve entrar para validar se esta com os itens liberados
			//pois em alguns momentos a rotina se perde neste STATUS e
			//deixa de atualizar o status da internação (BE4)
			//-------------------------------------------------------------------------------
			If B53->B53_STATUS $ "1"
				
				If !Empty(BE4->BE4_SENHA)
					
					RecLock("BE4", .F.)
					
					BE4->BE4_STATUS := "1" //AUTORIZADA
					
					BE4->(MsUnLock())
					
				EndIf
				
			ElseIf B53->B53_STATUS == "2"
				
				RecLock("BE4", .F.)
				
				BE4->BE4_STATUS := "2" //AUTORIZADA PARCIALMENTE
				
				BE4->(MsUnLock())
				
			EndIf
			
		EndIf
		
	EndIf
	
	//--------------------------------------------------
	//Validação do processo de Liberação
	//Pois estava ficando com o Status incoerente
	//--------------------------------------------------
	If B53->B53_ALIMOV == "BEA"
		
		U_PLAUDST()
		
	EndIf
	//--------------------------------------------------
	
	RestArea(_aArB4)
	RestArea(_aArEL)
	RestArea(_aArEJ)
	RestArea(_aAr53)
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CNTBEL      ºAutor  ³Angelo Henrique   º Data ³  27/07/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina criada para s do processo de analise de auditoria    º±±
±±º          ³pois a rotina padrão em alguns momentos limpava as criticas º±±
±±º          ³impedindo assim o auditor de realizar o processo de auditoria±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CNTBEL
	
	Local _aArea 	:= GetArea()
	Local _aArBEL	:= BEL->(GetArea())
	Local _cCont	:= "0"
	Local _cQuery	:= ""
	Local _cAliQry	:= GetNextAlias()
	
	_cQuery	:= " SELECT " 	+ CRLF
	_cQuery	+= " 	MAX(BEL.BEL_SEQCRI) SEQUENC " 	+ CRLF
	_cQuery	+= " FROM  " + RetSqlName('BEL') + " BEL " + CRLF
	_cQuery	+= " WHERE " 	+ CRLF
	_cQuery	+= " 	BEL.D_E_L_E_T_ = ' ' " 	+ CRLF
	_cQuery	+= " 	AND BEL.BEL_CODOPE = '" + SUBSTR(B53->B53_NUMGUI,1,4) + "' " 	+ CRLF
	_cQuery	+= " 	AND BEL.BEL_ANOINT = '" + SUBSTR(B53->B53_NUMGUI,5,4) + "' " 	+ CRLF
	_cQuery	+= " 	AND BEL.BEL_MESINT = '" + SUBSTR(B53->B53_NUMGUI,9,2) + "' " 	+ CRLF
	_cQuery	+= " 	AND BEL.BEL_NUMINT = '" + SUBSTR(B53->B53_NUMGUI,11 ) + "' " 	+ CRLF
	_cQuery	+= " 	AND BEL.BEL_SEQCRI <> ' ' " 	+ CRLF
	
	TcQuery _cQuery New Alias (_cAliQry)
	
	If !(_cAliQry)->(EOF())
		
		_cCont	:= (_cAliQry)->SEQUENC
		
	EndIf
	
	If _cCont = "0" .Or. Empty(AllTrim(_cCont))
		
		_cCont	:= "1"
		
	EndIf
	
	_cCont := STRZERO(Val(_cCont),TAMSX3("BEL_SEQCRI")[1])
	
	(_cAliQry)->(DbCloseArea())
	
	RestArea(_aArBEL)
	RestArea(_aArea)
	
Return _cCont


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CNTBQZ      ºAutor  ³Angelo Henrique   º Data ³  27/07/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina criada para s do processo de analise de auditoria    º±±
±±º          ³pois a rotina padrão em alguns momentos limpava as criticas º±±
±±º          ³impedindo assim o auditor de realizar o processo de auditoria±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CNTBQZ
	
	Local _aArea 	:= GetArea()
	Local _aArBQZ	:= BQZ->(GetArea())
	Local _cCont	:= "0"
	Local _cQuery	:= ""
	Local _cAliQry	:= GetNextAlias()
	
	_cQuery	:= " SELECT " 	+ CRLF
	_cQuery	+= " 	MAX(BQZ.BQZ_SEQCRI) SEQUENC " 	+ CRLF
	_cQuery	+= " FROM  " + RetSqlName('BQZ') + " BQZ " + CRLF
	_cQuery	+= " WHERE " 	+ CRLF
	_cQuery	+= " 	BQZ.D_E_L_E_T_ = ' ' " 	+ CRLF
	_cQuery	+= " 	AND BQZ.BQZ_CODOPE = '" + SUBSTR(B53->B53_NUMGUI,1,4) + "' " 	+ CRLF
	_cQuery	+= " 	AND BQZ.BQZ_ANOINT = '" + SUBSTR(B53->B53_NUMGUI,5,4) + "' " 	+ CRLF
	_cQuery	+= " 	AND BQZ.BQZ_MESINT = '" + SUBSTR(B53->B53_NUMGUI,9,2) + "' " 	+ CRLF
	_cQuery	+= " 	AND BQZ.BQZ_NUMINT = '" + SUBSTR(B53->B53_NUMGUI,11 ) + "' " 	+ CRLF
	_cQuery	+= " 	AND BQZ.BQZ_SEQCRI <> ' ' " 	+ CRLF
	
	TcQuery _cQuery New Alias (_cAliQry)
	
	If !(_cAliQry)->(EOF())
		
		_cCont	:= (_cAliQry)->SEQUENC
		
	EndIf
	
	If _cCont = "0" .Or. Empty(AllTrim(_cCont))
		
		_cCont	:= "1"
		
	EndIf
	
	_cCont := STRZERO(Val(_cCont),TAMSX3("BQZ_SEQCRI")[1])
	
	(_cAliQry)->(DbCloseArea())
	
	RestArea(_aArBQZ)
	RestArea(_aArea)
	
Return _cCont


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AUDOPME     ºAutor  ³Angelo Henrique   º Data ³  23/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para chamar a tela de Auditoria/OPME       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function AUDOPME
	
	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())
	Local _aArB53	:= B53->(GetArea())
	
	//-----------------------------------------------------------------
	//Como a rotina visualiza somente a internção antes de chamar
	//a rotina é necessário realizar o ponteramento na tabela da
	//internação (BE4)
	//-----------------------------------------------------------------
	DbSelectArea("BE4")
	DbSetOrder(2) //BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
	If DbSeek(xFilial("BE4") + B53->B53_NUMGUI)
		
		U_PLMENUCB()
		
	EndIf
	
	RestArea(_aArB53)
	RestArea(_aArBE4)
	RestArea(_aArea	)
	
Return


/*
Data: 01/12/2017
Autor: Mateus Medeiros
Função que será executada caso o Parecer seja Autorizado .

*/
/*Static Function GrvOpera()

Local cQry := ""
Local cID  := ""

If ( B72->B72_PARECE == "0" ) // Parecer Autorizado
	
	//Envio da mensagem para a Operativa
	
	cScript := "BEGIN																												"+ CRLF
	cScript += " 																													"+ CRLF
	cScript += "	INSERT INTO OPERATIVA.AUT_PROCEDIMENTOS_ITENS (																	"+ CRLF
	cScript += "ID_AUT, ID_ITEM, CHAVEPROCESSO, TISS_TABELA_REFERENCIA, TISS_CODIGO_PROC,											"+ CRLF
	cScript += "TISS_DESCRICAO_PROC, TISS_QUANTIDADE_SOLICITADA, TISS_COD_NEGATIVA, TISS_DESCR_NEGATIVA,							"+ CRLF
	cScript += "TISS_QUANTIDADE_AUTORIZADA, TISS_VALOR_MATERIAL_SOLIC, TISS_VALOR_MATERIAL_AUTOR,									"+ CRLF
	cScript += "TISS_ORDEM_OPCAO_FABRIC,																							"+ CRLF
	cScript += "TISS_REGISTRO_ANVISA, TISS_COD_REFER_FABRIC, TISS_COD_NEGATIVA_MAT, TISS_DESCR_NEGATIVA_MAT,						"+ CRLF
	cScript += "TISS_OBSERVACAO_MAT																									"+ CRLF
	cScript += " )																													"+ CRLF
	cScript += "																													"+ CRLF
	cScript += "(																													"+ CRLF
	cScript += " 																													"+ CRLF
	cScript += " SELECT 	ID_AUT, ID_ITEM,																						"+ CRLF
	cScript += "(																													"+ CRLF
	cScript += "SELECT MAX(CHAVEPROCESSO)  FROM  OPERATIVA.AUT_PROCEDIMENTOS_ITENS													"+ CRLF
	cScript += " ) CHAVEPROCESSO,																									"+ CRLF
	cScript += "TISS_TABELA_REFERENCIA, TISS_CODIGO_PROC,																			"+ CRLF
	cScript += "		TISS_DESCRICAO_PROC, TISS_QUANTIDADE_SOLICITADA,' ' TISS_COD_NEGATIVA, ' ' TISS_DESCR_NEGATIVA,				"+ CRLF
	cScript += "		"+cValTochar(B72->B72_QTDAUT)+" TISS_QUANTIDADE_AUTORIZADA, TISS_VALOR_MATERIAL_SOLIC, 						"+ CRLF
	cScript += "		TISS_VALOR_MATERIAL_AUTOR,TISS_ORDEM_OPCAO_FABRIC,															"+ CRLF
	cScript += "				TISS_REGISTRO_ANVISA, TISS_COD_REFER_FABRIC, ' ' TISS_COD_NEGATIVA_MAT,' ' TISS_DESCR_NEGATIVA_MAT, "+ CRLF
	cScript += "TISS_OBSERVACAO_MAT																								    "+ CRLF
	cScript += "              FROM OPERATIVA.AUT_PROCEDIMENTOS_ITENS																"+ CRLF
	cScript += "  WHERE ID_AUT = '"+cValToChar(B53->B53_XIDAUT)+"'																	"+ CRLF
	cScript += "AND TISS_TABELA_REFERENCIA = '" + If(B72->B72_CODPAD == '16','22',B72->B72_CODPAD) + "'								"+ CRLF
	cScript += "AND TISS_CODIGO_PROC = '" +AllTrim(B72->B72_CODPRO)+"'																"+ CRLF
	cScript += " );
		
	If TcSqlExec(cScript) < 0
		LogErros('Erro ao inserir mensagem na tabela [ OPERATIVA.AUT_PROCEDIMENTOS_MSG ]. ID_AUT [ ' + cValToChar(B53->B53_XIDAUT) + ' ], ID_ITEM [ ' + cID_Item + ' ], ID_MSG (novo) [ ' + cID_MSG + ' ]: ' + CRLF + TcSqlError())
	EndIf
	
EndIf


Return*/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³PLS790ANA³ Autor ³ Totvs                  ³ Data ³ 16.02.11 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Faz a chamada do menu de analise da guia					  ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABAANA(nTp)
	
	LOCAL _aArea	:= GetArea()
	LOCAL cFil 		:= ""
	LOCAL cAliGen	:= ""
	LOCAL cChaveBE2	:= ""
	LOCAL aFolder	:= {"Procedimentos"} //"Procedimentos"
	LOCAL oFWLayer	:= NIL
	LOCAL oPLUp 	:= NIL
	LOCAL oPLDown	:= NIL
	LOCAL oPLPro 	:= NIL
	LOCAL oTFolder	:= NIL
	LOCAL oB53Sit 	:= NIL
	LOCAL aChvInd		:= {}
	LOCAL aResFilt	:= {}
	LOCAL nI			:= 0
	Local aAreaB		:= B53->(GetArea())
	LOCAL aValRet   := {}
	Private o790C 	:= CABA790C():New()
	
	/*IF (nTp == 2 .AND. B53->B53_ROTGEN == "1")
	Alert ("STR0059")
Return
ENDIF*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ quando prorrogação, verifica se a guia é de internação.
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If nTp == 2 .AND. AllTrim(B53->B53_TIPO) != "3"
	
	PutHelp("PPL790V",{"Esta guia não é do tipo internação."},{},{},.T.)
	Help("",1,"PL790V")
Return
ElseIf nTp == 0 .and. (AllTrim(B53->B53_TIPO) == "3" .or. AllTrim(B53->B53_TIPO) == "11")
	
	if u_CAB790VDIA(B53->B53_NUMGUI, AllTrim(B53->B53_TIPO) )
		
		MsgAlert("Esta guia possui diárias a serem analisadas", "Atenção")
		
	endIf
	
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Lista de procedimento para negar participacao
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If nTp == 1
	o790C:SetNegPar(.T.)
Else
	o790C:SetNegPar(.F.)
EndIf

If nTp == 0 .and. (B53->B53_SITUAC <> '2')
	PLS790RTG("2")
endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Verifica se pode analisar a guia
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If nTp == 2
	
	If !o790C:VldAcessoGui(.T.,.F.,.T.,,,.T.)
		Return
	EndIf
	
	nTp := 0
ElseIf nTp == 0 .And. !o790C:VldAcessoGui(.T.,.F.,.T.)
Return
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Redefine a aRotina
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
aRotina := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ MsDialog
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
__oDlgAna := MSDialog():New(3,0,560,890,Iif(nTp == 0,'Analise da Auditoria','Procedimentos Autorizados' ),,,,,,,,,.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Cria o conteiner onde serão colocados s browses
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oFWLayer := FWLayer():New()
oFWLayer:Init( __oDlgAna, .F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Divisao da tela em duas linhas de 50%
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If nTp == 0
	oFWLayer:AddLine('Up',50,.F.)
	oFWLayer:AddLine('Down',50,.F.)
Else
	oFWLayer:AddLine('Up',100,.F.)
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Monta obj de Linha
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
oPLUp := oFWLayer:GetLinePanel( 'Up' )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Analise de procedimentos
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If nTp == 0
	oPLDown := oFWLayer:GetLinePanel( 'Down' )
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Odonto ou Reembolso
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If o790C:lOdonto .Or. o790C:lReembolso
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Matriz do folter
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If o790C:lOdonto
		cAliGen := "BYS"
		AaDd(aFolder,"Dentes/Faces") //"Dentes/Faces"
	ElseIf o790C:lReembolso
		cAliGen := "B47"
		AaDd(aFolder,"Composição") //"Composição"
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Folter
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oTFolder 		:= TFolder():New( 000,000,aFolder,,oPLUp,,,,.T.,,449,140)
	oTFolder:Align:= CONTROL_ALIGN_ALLCLIENT
	oPLPro 			:= oTFolder:aDialogs[1]
Else
	oPLPro := oPLUp
EndIf

If o790C:cAIte == "BE2"
	
	dbSelectArea("BE2")
	dbSetOrder(1)
	
	cChaveBE2 := xFilial("BE2")+Left(B53->B53_NUMGUI,4)+SubStr(B53->B53_NUMGUI,5,4)+SubStr(B53->B53_NUMGUI,9,2)+ Right(B53->B53_NUMGUI,8)
	
	If dbSeek(cChaveBE2)
		While !BE2->(Eof()) .And. BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT) == cChaveBE2
			If BE2->BE2_QTDSOL == 0
				BE2->(Reclock("BE2",.F.))
				BE2->BE2_QTDSOL :=  BE2->BE2_QTDPRO
				BE2->(MsUnlock())
			EndIf
			BE2->(DbSkip())
		EndDo
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Monta filtro de Itens
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
cFil := "@"     + o790C:cAIte+"_FILIAL = '" + xFilial("B53") + "' "
cFil += " AND " + o790C:cAIte+"_OPEMOV = '" + Left(B53->B53_NUMGUI,4) + "' "
cFil += " AND " + o790C:cAIte+"_ANOAUT = '" + SubStr(B53->B53_NUMGUI,5,4)+ "' "
cFil += " AND " + o790C:cAIte+"_MESAUT = '" + SubStr(B53->B53_NUMGUI,9,2)+ "' "
cFil += " AND " + o790C:cAIte+"_NUMAUT = '" + Right(B53->B53_NUMGUI,8)+ "' "
cFil += " AND " + o790C:cAIte+"_AUDITO = 1 "
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ,0ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Somente procedimentos autorizados
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If nTp == 1
	cFil += " AND " + o790C:cAIte + "_STATUS = '1' "
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Verifica campo conforme a guia
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
cFil := o790C:SetFieldGui(cFil)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Browse Procedimentos
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

oBPRO := FWmBrowse():New()
oBPRO:SetOwner( oPLPro )
oBPRO:SetAlias( o790C:cAIte )
oBPRO:SetDescription( aFolder[1] )

If nTp == 0
	oBPRO:SetMenuDef( 'XXXXX' )
Else
	oBPRO:SetMenuDef( "CABANALM" )
EndIf
oBPRO:DisableDetails()
oBPRO:DisableSaveConfig()
oBPRO:SetProfileID( "100" )
oBPRO:SetBlkBackColor( {||PLS_CORLIN} )
oBPRO:SetAmbiente(.F.)
oBPRO:SetWalkThru(.F.)
oBPRO:SetFilterDefault(cFil)
IF o790C:cAIte <> "B4C"
	oBPRO:AddLegend( o790C:cAIte + "_STATUS == '1' ", "GREEN", "Autorizada",,.F. ) // "Autorizada"
	oBPRO:AddLegend( o790C:cAIte + "_STATUS == '0' ", "RED" 	, "Não Autorizada",,.F. ) // "Não Autorizada"
ENDIF
oBPRO:Activate()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Analise de procedimentos
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If nTp == 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Odontologico ou Reembolso
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If o790C:lOdonto .Or. o790C:lReembolso
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³ Browse
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		oBGEN := FWmBrowse():New()
		oBGEN:SetOwner( oTFolder:aDialogs[2] )
		oBGEN:SetAlias( cAliGen )
		oBGEN:SetDescription( aFolder[2] )
		oBGEN:SetMenuDef( 'XXXXX' )
		oBGEN:DisableDetails()
		oBGEN:DisableSaveConfig()
		oBGEN:SetProfileID( "101" )
		oBGEN:SetBlkBackColor( {||PLS_CORLIN} )
		oBGEN:SetAmbiente(.F.)
		oBGEN:SetWalkThru(.F.)
		oBGEN:Activate()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³ Relacao do Browse Mestre com os Detail
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		oRPROGEN := FWBrwRelation():New()
		If o790C:cAIte == 'B4Q' 
			oRPROGEN:AddRelation( oBPRO, oBGEN, {	;
				{ cAliGen+'_FILIAL', 'xFilial("' + cAliGen + '")' },;
				{ cAliGen+'_OPEMOV', o790C:SetFieldGui(o790C:cAIte+'_OPEMOV') },;
				{ cAliGen+'_ANOAUT', o790C:SetFieldGui(o790C:cAIte+'_ANOAUT') },;
				{ cAliGen+'_MESAUT', o790C:SetFieldGui(o790C:cAIte+'_MESAUT') },;
				{ cAliGen+'_NUMAUT', o790C:SetFieldGui(o790C:cAIte+'_NUMAUT') } } )
		Else
			oRPROGEN:AddRelation( oBPRO, oBGEN, {	;
				{ cAliGen+'_FILIAL', 'xFilial("' + cAliGen + '")' },;
				{ cAliGen+'_OPEMOV', o790C:SetFieldGui(o790C:cAIte+'_OPEMOV') },;
				{ cAliGen+'_ANOAUT', o790C:SetFieldGui(o790C:cAIte+'_ANOAUT') },;
				{ cAliGen+'_MESAUT', o790C:SetFieldGui(o790C:cAIte+'_MESAUT') },;
				{ cAliGen+'_NUMAUT', o790C:SetFieldGui(o790C:cAIte+'_NUMAUT') },;
				{ cAliGen+'_SEQUEN', o790C:cAIte+'_SEQUEN' } } )
		Endif
		oRPROGEN:Activate()
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Browse Criticas
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//MenuDef()
	oBCRI := FWmBrowse():New()
	oBCRI:SetOwner( oPLDown )
	oBCRI:SetDescription( "Criticas" ) //"Criticas"
	oBCRI:SetMenuDef( "CABANALM" )
	oBCRI:SetAlias( o790C:cACri )
	oBCRI:SetProfileID( "102" )
	oBCRI:DisableDetails()
	oBCRI:ForceQuitButton()
	oBCRI:SetAmbiente(.F.)
	oBCRI:SetWalkThru(.F.)
	oBCRI:SetBlkBackColor( {||PLS_CORLIN} )
	oBCRI:Activate()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Relacao do Browse Mestre com os Detail
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oRPROCRI := FWBrwRelation():New()
	If (o790C:cACri == 'BQZ') .and. (o790C:cAIte == 'B4Q') 
	oRPROCRI:AddRelation( oBPRO, oBCRI, {	;
		{ o790C:cACri+'_FILIAL', 'xFilial("' + o790C:cACri + '")' },;
		{ o790C:SetFieldGui(o790C:cACri+'_CODOPE'), o790C:SetFieldGui(o790C:cAIte+'_OPEMOV') },;
		{ o790C:SetFieldGui(o790C:cACri+'_ANOINT'), o790C:SetFieldGui(o790C:cAIte+'_ANOAUT') },;
		{ o790C:SetFieldGui(o790C:cACri+'_MESINT'), o790C:SetFieldGui(o790C:cAIte+'_MESAUT') },;
		{ o790C:SetFieldGui(o790C:cACri+'_NUMINT'), o790C:SetFieldGui(o790C:cAIte+'_NUMAUT') } } )	
	Else
	oRPROCRI:AddRelation( oBPRO, oBCRI, {	;
		{ o790C:cACri+'_FILIAL', 'xFilial("' + o790C:cACri + '")' },;
		{ o790C:SetFieldGui(o790C:cACri+'_OPEMOV'), o790C:SetFieldGui(o790C:cAIte+'_OPEMOV') },;
		{ o790C:SetFieldGui(o790C:cACri+'_ANOAUT'), o790C:SetFieldGui(o790C:cAIte+'_ANOAUT') },;
		{ o790C:SetFieldGui(o790C:cACri+'_MESAUT'), o790C:SetFieldGui(o790C:cAIte+'_MESAUT') },;
		{ o790C:SetFieldGui(o790C:cACri+'_NUMAUT'), o790C:SetFieldGui(o790C:cAIte+'_NUMAUT') },;
		{ o790C:cACri+'_SEQUEN', o790C:cAIte+'_SEQUEN' } } )
	Endif
	oRPROCRI:Activate()
	//!o790C:VldAcessoGui(.T.,.F.,.T.,.T.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Filtro se ja foi analisada
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//	cFil := o790C:cACri+'_PENDEN <> "0" .AND. ' + o790C:cACri+'_CODGLO <> " " '
	cFil := o790C:cACri+'_PENDEN <> "0"  '
	oBCRI:AddFilter( "Pendente",cFil,.T.,.T.) //"Pendente"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Executa filtro
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oBCRI:ExecuteFilter()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Ativando componentes de tela
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
__oDlgAna:lCentered := .T.
__oDlgAna:Activate()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Caso a guia esteja bloqueada por algum departamento, apos a guia ser
//	totalmente auditada, é liberada para ser auditada por qualquer departamento
//	novamente.
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
If B53->B53_SITUAC == "1"
	oB53Sit := PLSSTRUC():New("B53",4,,B53->( Recno() ))
	oB53Sit:SetValue("B53_CODDEP","" )
	oB53Sit:CRUD()
EndIF

If Existblock("PLSGRB53")
	Execblock("PLSGRB53", .F., .F., {B53->(Recno())} )
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³ Rest nas linhas do browse e na area
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
PLSADESV()

RestArea( _aArea )
RestArea(aAreaB)

If o790C:cAIte == "B4C"
	B4A->(DbSetOrder(1))
	If B4A->(MsSeek(xFilial("B4A") + o790C:cNumGuia))
		
		If B4A->B4A_GUIREF == cGuia
			
			aValRet := PLSCFGUAX(cGuia)
			IF (Len(aValRet[1]) == 0)
				PLSCNGUIA()
			EndIf
		EndIf
	EndIf
EndIf

Return NIL


//--------------------------------------------------------------------------------
/*/{Protheus.doc} PPL790VDIA
Verifica se uma internação possui critica de diaria para ser analisada pelo auditor
@author Karine Riquena Limp
@since 15/09/2016
@version P12
/*/
//---------------------------------------------------------------------------------
User function CAB790VDIA(cNumGui, cTipGui)
	local lRet := .F.
	local lProcDia := .F.
	local aAreaCri := BEL->(getArea())
	local aAreaPro := BEJ->(getArea())
	
	if !empty(cNumGui)
		
		if cTipGui == "3"
			
			BEJ->(dbSetOrder(1))
			BEJ->(dbGoTop())
			BR8->(dbSelectArea("BR8"))
			BR8->(dbSetOrder(1))
			
			If BEJ->(dbSeek( xFilial("BEJ")+B53->B53_NUMGUI))
				
				While !BEJ->(EOF()) .AND. xFilial("BEJ")+B53->B53_NUMGUI == BEJ->(BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT)
					
					//se tiver procedimento de diaria na guia não precisa olar a critica de diaria pois vai pelo procedimento
					If BR8->( MsSeek(xFilial("BR8")+BEJ->BEJ_CODPAD+BEJ->BEJ_CODPRO) ) .AND. BR8->BR8_TPPROC=='4'
						
						lProcDia := .T.
						exit
						
					Endif
					
					
					BEJ->(dbSkip())
					
				EndDo
				
			EndIf
			
			if !lProcDia
				
				BEL->(DbSetOrder(1))//BEL_FILIAL + BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT + BEL_SEQUEN
				
				If BEL->(msSeek(xFilial("BEL")+cNumGui))
					
					While !BEL->(EoF()) .and. xFilial("BEL")+cNumGui == BEL->(BEL_FILIAL+BEL_CODOPE+BEL_ANOINT+BEL_MESINT+BEL_NUMINT)
						
						if BEL->BEL_CODGLO == __aCdCri585[1]
							
							lRet := .T.
							exit
							
						endIf
						BEL->(DbSkip())
					EndDo
					
				EndIf
				
			endIf
			
		elseif cTipGui == "11"
			
			aAreaCri := BQZ->(getArea())
			aAreaPro := BQV->(getArea())
			
			BQV->(dbSetOrder(1))
			BQV->(dbGoTop())
			BR8->(dbSelectArea("BR8"))
			BR8->(dbSetOrder(1))
			
			If BQV->(dbSeek( xFilial("BQV")+B53->B53_NUMGUI))
				
				While !BQV->(EOF()) .AND. xFilial("BQV")+B53->B53_NUMGUI == BQV->(BQV_FILIAL+BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT)
					
					//se tiver procedimento de diaria na guia não precisa olar a critica de diaria pois vai pelo procedimento
					If BR8->( MsSeek(xFilial("BR8")+BQV->BQV_CODPAD+BQV->BQV_CODPRO) ) .AND. BR8->BR8_TPPROC=='4'
						
						lProcDia := .T.
						exit
						
					Endif
					
					
					BQV->(dbSkip())
					
				EndDo
				
			EndIf
			
			if !lProcDia
				
				BQZ->(DbSetOrder(1))//BEL_FILIAL + BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT + BEL_SEQUEN
				
				If BQZ->(msSeek(xFilial("BQZ")+cNumGui))
					
					While !BQZ->(EoF()) .and. xFilial("BQZ")+cNumGui == BQZ->(BQZ_FILIAL+BQZ_CODOPE+BQZ_ANOINT+BQZ_MESINT+BQZ_NUMINT)
						
						if BQZ->BQZ_CODGLO == __aCdCri585[1]
							
							lRet := .T.
							exit
							
						endIf
						BQZ->(DbSkip())
					EndDo
					
				EndIf
				
			endIf
			
		endIf
		
	EndIf
	
	restArea(aAreaCri)
	restArea(aAreaPro)
	
return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³PLS790ALS³ Autor ³ Totvs                  ³ Data ³ 16.02.11 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Faz a chamada do botao acao para analise da guia Get       ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CAB790ALS(cAlias)
	LOCAL aArea 	 	:= GetArea()
	LOCAL oPADC 	 	:= CABPADRC():New(cAlias)
	LOCAL oB72		 	:= NIL
	LOCAL oB70		 	:= NIL
	LOCAL lOk		 	:= .F.
	Local cAlias1		:= GetNextAlias()
	Local nOperation 	:=  MODEL_OPERATION_INSERT
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Alimenta variavel static para exibicao no ultimo registro de critina B72
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If oPADC:lMDAnaliseGui .And. !o790C:lIntSau .And. (o790C:cACri)->&(o790C:cACri+"_PENDEN") == "1"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		//³ Se o registro existe
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
		oB72 := CABREGIC():New()
		//If (o790C:cAIte) == 'B4Q'
			
		//Else
			oB72:GetDadReg("B72",1, xFilial("B72") + B53->(B53_ALIMOV+B53_RECMOV) + (o790C:cAIte)->&( o790C:cAIte+"_SEQUEN" ) + (o790C:cACri)->&(o790C:cACri+"_CODGLO"),,,.F. )
		//Endif
		//devido o problema da verificação da existencia da b72, a query foi feita
		beginsql alias cAlias1
			
			SELECT COUNT(B72_ALIMOV) CONT
			FROM %TABLE:B72%
			WHERE B72_ALIMOV = %exp:B53->B53_ALIMOV%
			AND B72_RECMOV = %exp:B53->B53_RECMOV%
			and %notdel%
			
		endsql
		
		
		If oB72:lFound //.OR. (cAlias1)->CONT > 0
			nOperation := MODEL_OPERATION_UPDATE
		EndIf
		
		if select(cAlias1) > 0
			(cAlias1)->(dbclosearea())
		endif
		
		oB72:Destroy()
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ se o procedimento pode ser auditado
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	
	If !o790C:VldAcessoGui(.T.,.F.,.T.,.T.)
		Return
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Se o procedimento for paticipativo e existir registro no folder participativo
	//  o auditor é informado no momento de auditar o procedimento.
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If BE2->( FieldPos("BE2_PARTIC") ) > 0
		o790C:ProcPart()
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Entrada de dados da analise GET
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	FWExecView("Analise da Auditoria","CABANALM", nOperation,/*oDlg*/,/*bCloseOnOk*/,{ |oModel| lOk := oPADC:VWOkButtonVLD(oModel,cAlias) },30 )/*bOK*/ //"Analise da Auditoria"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Atualiza browse de itens
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	oBPRO:Refresh(.T.)
	oBCRI:Refresh(.T.)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Fim da Rotina
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	restarea(aArea)
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³PLAUDST  ³ Autor ³ Angelo Henrique        ³ Data ³ 07/12/2018±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Corrige o status na solicitação de liberação.              ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLAUDST
	
	Local _aArea	:= GetArea()
	Local _aArBEA	:= BEA->(GetArea())
	Local cQry		:= ""
	Local (cAliQry) := GetNextAlias()
	Local (cAliQr1) := GetNextAlias()
	
	cQry := " SELECT 															" 	+ CRLF
	cQry += "     B53.B53_RECMOV,                                       		" 	+ CRLF
	cQry += "     B53.B53_NUMGUI,                                       		" 	+ CRLF
	cQry += "     B53.B53_ALIMOV,                                       		" 	+ CRLF
	cQry += "     B53.B53_ORIMOV,                                       		" 	+ CRLF
	cQry += "     B72.B72_CODPRO,                                       		" 	+ CRLF
	cQry += "     B72.B72_QTDAUT                                        		" 	+ CRLF
	cQry += " FROM                                                      		" 	+ CRLF
	cQry += "     	"	+ RetSqlName("B53")		+ " B53							" 	+ CRLF
	cQry += "                                                           		" 	+ CRLF
	cQry += "     INNER JOIN                                            		" 	+ CRLF
	cQry += "     	"	+ RetSqlName("B72")		+ " B72							" 	+ CRLF
	cQry += "     ON                                                    		" 	+ CRLF
	cQry += "         B72.B72_FILIAL      = B53.B53_FILIAL              		" 	+ CRLF
	cQry += "         AND B72.B72_ALIMOV  = B53.B53_ALIMOV              		" 	+ CRLF
	cQry += "         AND B72.B72_RECMOV  = B53.B53_RECMOV              		" 	+ CRLF
	cQry += "         AND B72.B72_PARECE  = '0'									" 	+ CRLF
	cQry += "         AND B72.D_E_L_E_T_  = ' '                         		" 	+ CRLF
	cQry += "                                                           		" 	+ CRLF
	cQry += "     INNER JOIN                                            		" 	+ CRLF
	cQry += "     	"	+ RetSqlName("BEA")		+ " BEA							" 	+ CRLF
	cQry += "     ON                                                    		" 	+ CRLF
	cQry += "         BEA.BEA_FILIAL = B53.B53_FILIAL                   		" 	+ CRLF
	cQry += "         AND BEA.BEA_OPEMOV = '" + SUBSTR(B53->B53_NUMGUI,1,4) + "'" 	+ CRLF
	cQry += "         AND BEA.BEA_ANOAUT = '" + SUBSTR(B53->B53_NUMGUI,5,4) + "'" 	+ CRLF
	cQry += "         AND BEA.BEA_MESAUT = '" + SUBSTR(B53->B53_NUMGUI,9,2) + "'" 	+ CRLF
	cQry += "         AND BEA.BEA_NUMAUT = '" + SUBSTR(B53->B53_NUMGUI,11)  + "'" 	+ CRLF
	cQry += "         AND BEA.BEA_STATUS = '1'                          		" 	+ CRLF
	cQry += "         AND BEA.D_E_L_E_T_ = ' '                          		" 	+ CRLF
	cQry += "                                                           		" 	+ CRLF
	cQry += "     INNER JOIN                                            		" 	+ CRLF
	cQry += "     	"	+ RetSqlName("BE2")		+ " BE2							" 	+ CRLF
	cQry += "     ON                                                    		" 	+ CRLF
	cQry += "         BE2.BE2_FILIAL      = BEA.BEA_FILIAL              		" 	+ CRLF
	cQry += "         AND BE2.BE2_OPEMOV  = BEA.BEA_OPEMOV              		" 	+ CRLF
	cQry += "         AND BE2.BE2_ANOAUT  = BEA.BEA_ANOAUT              		" 	+ CRLF
	cQry += "         AND BE2.BE2_MESAUT  = BEA.BEA_MESAUT              		" 	+ CRLF
	cQry += "         AND BE2.BE2_NUMAUT  = BEA.BEA_NUMAUT              		" 	+ CRLF
	cQry += "         AND BE2.BE2_QTDSOL  > BE2.BE2_SALDO               		" 	+ CRLF
	cQry += "         AND BE2.D_E_L_E_T_  = ' '                         		" 	+ CRLF
	cQry += "                                                           		" 	+ CRLF
	cQry += " WHERE                                                     		" 	+ CRLF
	cQry += "                                                           		" 	+ CRLF
	cQry += "     B53.B53_FILIAL = '" + xFilial("B53") + "'               		" 	+ CRLF
	cQry += "     AND B53.B53_NUMGUI = '" + B53->B53_NUMGUI + "'      			" 	+ CRLF
	cQry += "     AND B53.B53_ORIMOV = '" + B53->B53_ORIMOV + "'        		" 	+ CRLF
	cQry += "     AND B53.B53_ALIMOV = 'BEA'                            		" 	+ CRLF
	cQry += "     AND B53.D_E_L_E_T_ = ' '                              		" 	+ CRLF
	
	If Select(cAliQry) > 0
		dbSelectArea(cAliQry)
		dbCloseArea()
	EndIf
	
	TcQuery cQry New Alias (cAliQry)
	
	If !(cAliQry)->(EOF())
		
		While !(cAliQry)->(EOF())
			
			DbSelectArea("BEA")
			DbSetORder(1)
			If DbSeek(xFilial("BEA") + B53->B53_NUMGUI)
				
				RecLock("BEA", .F.)
				
				BEA->BEA_STATUS := "2"
				
				BEA->(MsUnLock())
				
				//-------------------------------------------------
				//Varrer a BE2 com base nos itens da B72
				//corrigindo assim o saldo
				//-------------------------------------------------
				cQry := " SELECT 													" + CRLF
				cQry += "     B72.B72_CODPRO,                                       " + CRLF
				cQry += "     B72.B72_QTDAUT,                                       " + CRLF
				cQry += "     BE2.BE2_SALDO,                                        " + CRLF
				cQry += "     BE2.BE2_QTDSOL,                                       " + CRLF
				cQry += "     BE2.BE2_OPEMOV, 	                                    " + CRLF
				cQry += "     BE2.BE2_ANOAUT,   	                                " + CRLF
				cQry += "     BE2.BE2_MESAUT,       	                            " + CRLF
				cQry += "     BE2.BE2_NUMAUT,           	                        " + CRLF
				cQry += "     BE2.BE2_SEQUEN                	                    " + CRLF
				cQry += " FROM                                                      " + CRLF
				cQry += "     	"	+ RetSqlName("B53")	+ " B53						" + CRLF
				cQry += "                               	                        " + CRLF
				cQry += "     INNER JOIN                                            " + CRLF
				cQry += "     	"	+ RetSqlName("B72")	+ " B72						" + CRLF
				cQry += "     ON                                                    " + CRLF
				cQry += "         B72.B72_FILIAL      = B53.B53_FILIAL              " + CRLF
				cQry += "         AND B72.B72_ALIMOV  = B53.B53_ALIMOV              " + CRLF
				cQry += "         AND B72.B72_RECMOV  = B53.B53_RECMOV              " + CRLF
				cQry += "         AND B72.B72_PARECE  = '0'							" + CRLF
				cQry += "         AND B72.D_E_L_E_T_  = ' '                         " + CRLF
				cQry += "                                                           " + CRLF
				cQry += "     INNER JOIN                                            " + CRLF
				cQry += "     	"	+ RetSqlName("BEA")	+ " BEA						" + CRLF
				cQry += "     ON                                                    " + CRLF
				cQry += "         BEA.BEA_FILIAL = B53.B53_FILIAL                   " + CRLF
				cQry += "         AND BEA.BEA_OPEMOV = SUBSTR(B53.B53_NUMGUI,1,4)	" + CRLF
				cQry += "         AND BEA.BEA_ANOAUT = SUBSTR(B53.B53_NUMGUI,5,4)	" + CRLF
				cQry += "         AND BEA.BEA_MESAUT = SUBSTR(B53.B53_NUMGUI,9,2)   " + CRLF
				cQry += "         AND BEA.BEA_NUMAUT = SUBSTR(B53.B53_NUMGUI,11)    " + CRLF
				cQry += "         AND BEA.D_E_L_E_T_ = ' '                          " + CRLF
				cQry += "                                                           " + CRLF
				cQry += "     INNER JOIN                                            " + CRLF
				cQry += "     	"	+ RetSqlName("BE2")		+ " BE2					" + CRLF
				cQry += "     ON                                                    " + CRLF
				cQry += "         BE2.BE2_FILIAL      = BEA.BEA_FILIAL              " + CRLF
				cQry += "         AND BE2.BE2_OPEMOV  = BEA.BEA_OPEMOV              " + CRLF
				cQry += "         AND BE2.BE2_ANOAUT  = BEA.BEA_ANOAUT              " + CRLF
				cQry += "         AND BE2.BE2_MESAUT  = BEA.BEA_MESAUT              " + CRLF
				cQry += "         AND BE2.BE2_NUMAUT  = BEA.BEA_NUMAUT              " + CRLF
				cQry += "         AND BE2.BE2_CODPRO  = B72.B72_CODPRO              " + CRLF
				cQry += "         AND BE2.BE2_SALDO  <> B72.B72_QTDAUT           	" + CRLF
				cQry += "         AND BE2.D_E_L_E_T_  = ' '                         " + CRLF
				cQry += "                                                           " + CRLF
				cQry += " WHERE                                                     " + CRLF
				cQry += "                                                           " + CRLF
				cQry += "     B53.B53_FILIAL = '" + xFilial("B53") + "'             " + CRLF
				cQry += "     AND B53.B53_NUMGUI = '" + B53->B53_NUMGUI + "'      	" + CRLF
				cQry += "     AND B53.B53_ORIMOV = '" + B53->B53_ORIMOV + "'      	" + CRLF
				cQry += "     AND B53.B53_ALIMOV = 'BEA'                            " + CRLF
				cQry += "     AND B53.D_E_L_E_T_ = ' '                              " + CRLF
				
				If Select(cAliQr1) > 0
					dbSelectArea(cAliQr1)
					dbCloseArea()
				EndIf
				
				TcQuery cQry New Alias (cAliQr1)
				
				If !(cAliQr1)->(EOF())
					
					While !(cAliQr1)->(EOF())
						
						DbSelectArea("BE2")
						DbSetORder(1)
						If DbSeek(xFilial("BE2") + (cAliQr1)->(BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+BE2_SEQUEN))
							
							RecLock("BE2", .F.)
							
							BE2->BE2_SALDO  := (cAliQr1)->B72_QTDAUT
							BE2->BE2_QTDPRO := (cAliQr1)->B72_QTDAUT
							
							BE2->(MsUnLock())
							
						EndIf
						
						(cAliQr1)->(DbSkip())
						
					EndDo
					
					
				EndIf
				
				If Select(cAliQr1) > 0
					dbSelectArea(cAliQr1)
					dbCloseArea()
				EndIf
				
				(cAliQry)->(DbSkip())
				
			EndIf
			
		EndDo
		
	EndIf
	
	If Select(cAliQry) > 0
		dbSelectArea(cAliQry)
		dbCloseArea()
	EndIf
	
	RestArea(_aArBEA)
	RestArea(_aArea	)
	
Return
