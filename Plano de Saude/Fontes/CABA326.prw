#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "TBICONN.CH"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verificar procedimentos realizados no periodo informado e gerar uma PEG    ³
//³com as guias no valor do procedimento informado. Verifica os procedimentos ³
//³realizados pelo RDA e gera a PEG para o RDA do rateio.                     ³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Exibir relatorio com os procedimentos utilizados e so gerar apos confirmar.³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³cMesPag   	- Mes da PEG que sera gerada								  ³
//³cAnoPag   	- Ano da PEG que sera gerada                                  ³
//³cAnoPeg 		- Ano dos procedimentos que serao buscados (sempre o mes ante-³
//³               rior                                                        ³
//³cMesPeg		- Mes dos procedimentos que serao buscados (sempre o mes ante-³
//³               rior                                                        ³
//³dDtEvento 	- Data dos procedimentos nas guias da PEG que sera gerada     ³ 
//³dIniCalc 	- Data inicial para busca dos eventos. Sera usado para incluir³
//³               os procedimentos na nova PEG                                ³
//³dFimCalc		- Data final para busca dos eventos. Sera usado para incluir  ³
//³               os procedimentos na nova PEG                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CABA326()

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

PRIVATE lDebuggg  := .F.//MsgYesNo('Debugar???')//.T.
                           
Private cPerg     := "RATEIOINT"  
Private cMesPag   := ""
Private cAnoPag   := ""
Private cCodInt   := "0001"
Private cNomInt   := POSICIONE("BA0",1,xFilial("BA0")+cCodInt,"BA0_NOMINT")
Private cOpeRDA   := ""                                                    
Private cNomRDA   := ""
Private lExistRat := .F.
Private dDtEvento 
Private cCodPad   := ""
Private cCodProc  := ""
Private aArray1   := {} 
Private nValorRDA := 0
Private nVlrPgRDA := 0 //valor ja gerado para o RDA no mes+ano em questao
Private nQtdIntern:= 0
Private nQtdPgRDA := 0
Private nVlrIndRDA:= 0
Private nVlrDecr  := 0 //valor a ser subtraido, caso ja tenha sido gerado o rateio parcialmente
Private lOkAux    := .F.
Private nQtdAux   := 0
Private cCodRDA   //:= '138738'//Pedro Mano
Private cCodLDP   := '0017'//"0001"
Private cCodPEG   := ""
Private cGuiaRat  := ""   
Private nRecPAQ	  := 0	
Private aRecPAQ	  := {}
Private cCodProc  := "10102019"
Private cCodPla   := ""      
Private nVlraju   := 0
Private nRadio 	  := 1
Private n_VlrPEG  := 0
Private n_ProcPEG := 0
Private n_GuiaPEG := 0

Public l_Primeira := "" 

/*
//BIANCHINI - 14/08/2014 - POR CAUSA DESSA CONDICAO A INTEGRAL SEMPRE BUSCAVA GUIAS COM O CODIGO 10102019. ENTAO CONVERSANDO COM 
//			  O SALACIER DECIDIMOS MANTER A MESMA REGRA PARA INTEGRAL. O MESMO IRA DEFINIR COM DR GIORDANO SE FICARAO ESTES MESMOS
//			  CODIGOS.
//cCodProc  := If( ( cEmpAnt == '01' .and. cCodRDA == '106593' ),'80010342','10102019')//HCJ eh outro codigo, visita internista
cCodProc  := If( cCodRDA == '106593','80010342','10102019' )//HCJ eh outro codigo, visita internista
*/
INCLUI := .T. //adicionado para solucionar problema no inicializador padrão do campo bd5_opesol

CriaSX1()

If !Pergunte(cPerg,.T.)
	Return
EndIf
		
cMesPag   := MV_PAR01//Mes da PEG que sera gerada
cAnoPag   := MV_PAR02//Ano da PEG que sera gerada
dDtEvento := MV_PAR03//Data dos procedimentos nas guias da PEG que sera gerada  

//Leonardo Portella - 15/09/14 - Inicio - Chamado - ID: 13370 - Apos a competencia 08/2014, utilizar somente o codigo 10102019

Do Case

	Case Len(AllTrim(cMesPag)) <> 2
		MsgStop('Mês deve ter 2 dígitos!',AllTrim(SM0->M0_NOMECOM))
		Return

	Case Len(AllTrim(cAnoPag)) <> 4
		MsgStop('Ano deve ter 4 dígitos!',AllTrim(SM0->M0_NOMECOM))
		Return

	Otherwise
		cCodProc := GetCodPro('', cAnoPag + cMesPag)

EndCase

//Leonardo Portella - 15/09/14 - Fim

Private dIniCalc 	:= StoD('')//Data inicial para busca dos eventos. Sera usado para incluir os procedimentos na nova PEG
Private dFimCalc	:= StoD('')//Data final para busca dos eventos. Sera usado para incluir os procedimentos na nova PEG

cMesPeg := cMesPag 
cAnoPeg := cAnoPag 

If u_nfDefRDATx(cAnoPag, cMesPag) // MBC

	DbSelectArea("PAR")
	DbSetOrder(1) 
	
	If DbSeek(xFilial("PAR")+cMesPag+cAnoPag)
	
		While !PAR->(EOF()) .and. ( PAR->(PAR_FILIAL+PAR_COMPET) == xFilial("PAR")+cMesPag+cAnoPag )
		
			If ( PAR->PAR_CODRDA == cCodRDA )
		   
				If MsgYesNo("Atenção: Já existe rateio lançado para a competência informada para este RDA. Somente serão gerados rateios que ainda não foram processados para essa competência. Deseja continuar?","Existe rateio nessa competência!")
					lExistRat := .T.
					GERARATINT()
				Else
					Return
				EndIf 
				
				Exit
				
			EndIf
			
			PAR->(DbSkip())
			
		EndDo 
		
		If !lExistRat
		 	GERARATINT()
		EndIf
		
	Else
		GERARATINT()
	EndIf
	
	For nI := 1 to len(aRecPAQ)
		DbSelectArea('PAQ')
		DbGoTo(aRecPAQ[nI])
		
		PAQ->(Reclock('PAQ',.F.))
		PAQ->(DbDelete())
		PAQ->(MsUnlock())
	Next
		
EndIf // MBC

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ GERARATINT ³ Autor ³ Renato Peixoto    ³ Data ³ 15/06/2011 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GERARATINT()

Local lret

Private cTitulo := "Rateio internista"

Processa({|| lret := ProcRatInt() }, cTitulo, "", .T.)

Return lret

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ProcRatInt    ºAutor  ³ Renato Peixoto º Data ³  15/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Processamento do rateio dos internistas.                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ProcRatInt()

Local i 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nI 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cQuery	  := ""
Local cQuery2     := ""
Local cQuery3     := ""
Local cQuery4     := ""
Local cQuery5     := ""
Local cQryTotPg   := ""                         
Local cQryTotInt  := ""
Local cAliasQry   := GetNextAlias()
Local _2cAliasQry := GetNextAlias()
Local _3cAliasQry := GetNextAlias()
Local _4cAliasQry := GetNextAlias() 
Local _5cAliasQry := GetNextAlias()
Local cArqQryPG   := GetNextAlias()  
Local cArqQryInt  := GetNextAlias()
Local cArqTotGui  := GetNextAlias()
Local cMacroTab   := ""
Local cLocalBB8   := ""
Local cDesLocBB8  := ""
Local cBB8END     := ""
Local cBB8NR_END  := ""
Local cBB8COMEND  := ""
Local cBB8Bairro  := ""
Local cCodEsp     := ""
Local nTotQry	  := 0
Local cCrmSolic   := ""
Local cTipoPgto   := ""
Local cTelefone   := ""
Local cSexo       := "" 
Local lGerouRat   := .F.
Local cSelect     := ""

ProcRegua(0)

For nI := 1 to 5
	IncProc('Gerando rateio internista...')
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao de indices para busca...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("BAU")
BAU->(DbSetOrder(1)) //Tabela das RDAS
//ZZV->(DbSetOrder(1)) //Tabela que guarda os rateios dos internistas / AAG
DbSelectArea("BE4")
BE4->(DbSetOrder(11))//Tabela de internacoes

cQuery3 := " SELECT /*+ INDEX(" + If(cEmpAnt == '01','BD6010 BD6010TMP','BD6020 BD6020TMP') + ") */ Count(DISTINCT(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)) AS TOTAL " 		+ CRLF
cQuery3 += " FROM "+RetSQLName("BD6") 																			+ CRLF
cQuery3 += " WHERE BD6_FILIAL = '" + xFilial('BD6')+ "'" 														+ CRLF
cQuery3 += " AND BD6_CODOPE = '" + PLSINTPAD() + "' " 															+ CRLF
cQuery3 += " AND SUBSTR(BD6_NUMLOT,1,6) = '" + cAnoPeg + cMesPeg + "'" 											+ CRLF           
//    cQuery3 += " AND SUBSTR(BD6_NUMLOT,1,6) IN ('201602','202102','202103','202104') " 						+ CRLF //motta 16/3/16   
cQuery3 += " AND BD6_DATPRO BETWEEN '" + DtoS(dIniCalc) + "' AND '" +  DtoS(dFimCalc) + "'"					+ CRLF 
cQuery3 += " AND D_E_L_E_T_ = ' ' " 																			+ CRLF
cQuery3 += " AND BD6_CODPRO = '"+cCodProc+"'" 																	+ CRLF
cQuery3 += " AND BD6_CODRDA = '"+cCodRDA+"'" 																	+ CRLF
cQuery3 += " AND BD6_SITUAC = '1' "        																		+ CRLF
cQuery3 += " AND BD6_VLRPAG > 0 "        																		+ CRLF
cQuery3 += " AND BD6_MOTBPF <> '501'" 																			+ CRLF

//cQuery3 += " AND BD6_QTDPRO > 1"
//cQuery3 += " AND ROWNUM <= 10 "        																		+ CRLF

/*
If lExistRat
	cQuery3 += " AND BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO NOT IN (SELECT PAR_CODINT||PAR_CODEMP||PAR_MATRIC||PAR_TIPREG||PAR_DIGITO "
 	cQuery3 += " FROM "+RetSqlName("PAR")+" PAR  "
	cQuery3 += " WHERE D_E_L_E_T_ = ' ' AND PAR_FILIAL = '"+xFilial("PAR")+"' AND PAR_CODRDA = '"+cCodRDA+"' AND PAR_COMPET = '"+cMesPag+cAnoPag+"' ) "
EndIf                                                                                                     
*/   

If Select(_3cAliasQry) <> 0 
	(_3cAliasQry)->(DbCloseArea()) 
Endif 

If lDebuggg .and. !MsgYesNo(AllTrim(ProcName()) + ' :  Continua?')
	Return
EndIf

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery3),_3cAliasQry,.T.,.T.)
	
If (_3cAliasQry)->TOTAL > 0
	lOkAux    := .T.
	nQtdAux   := (_3cAliasQry)->TOTAL
	nTotQry   := (_3cAliasQry)->TOTAL
	
	ProcRegua(nTotQry)
	
	//rodo a query que vai servir para qualquer auxiliar de internista
	cSelect := "BD6_CODPLA,BD6_OPERDA,BD6_CODRDA,BD6_CODOPE,BD6_CODPAD,BD6_CODPRO,BD6_DATPRO,BD6_HORPRO,BD6_NOMUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,BD6_QTDAPR,BD6_QTDPRO"//LOCAL DE DIGITACAO, PEG E NUMERO ACRESCENTADOS POR RENATO PEIXOTO EM 28/02/12
	aSelect := strTokArr(cSelect,',')
	aStru := {}
	
	dbSelectArea('SX3')
	dbSetOrder(2)
	
	For i := 1 to len(aSelect)
		
		If dbSeek(aSelect[i])
			aAdd(aStru,{SX3->X3_CAMPO,SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})	
		EndIf
	
	Next
	
	cQuery4 := " SELECT /*+ INDEX(" + If(cEmpAnt == '01','BD6010 BD6010TMP','BD6020 BD6020TMP') + ") */ " + cSelect + CRLF	
	cQuery4 += " FROM "+RetSQLName("BD6") 																			+ CRLF
	cQuery4 += " WHERE BD6_FILIAL = '" + xFilial('BD6')+ "'" 														+ CRLF
	cQuery4 += " AND BD6_CODOPE = '" + PLSINTPAD() + "' " 															+ CRLF
    cQuery4 += " AND BD6_DATPRO BETWEEN '" + DtoS(dIniCalc) + "' AND '" +  DtoS(dFimCalc) + "'"					+ CRLF  
    cQuery4 += " AND SUBSTR(BD6_NUMLOT,1,6) = '" + cAnoPeg + cMesPeg + "'" 											+ CRLF    
    //cQuery4 += " AND SUBSTR(BD6_NUMLOT,1,6) IN ('201602','202102','202103','202104') " 							+ CRLF  //motta 16/3/16  
	   
	cQuery4 += " AND D_E_L_E_T_ = ' ' " 																			+ CRLF
	cQuery4 += " AND BD6_CODPRO = '"+cCodProc+"'" 																	+ CRLF
	cQuery4 += " AND BD6_CODRDA = '"+cCodRDA+"'" 																	+ CRLF
	cQuery4 += " AND BD6_SITUAC = '1' "        																		+ CRLF
	cQuery4 += " AND BD6_VLRPAG > 0 "        																		+ CRLF
    cQuery4 += " AND BD6_MOTBPF <> '501'" 																			+ CRLF

//	cQuery4 += " AND BD6_QTDPRO > 1"
//	cQuery4 += " AND ROWNUM <= 10 "        																		+ CRLF

	/*If lExistRat
		cQuery4 += " AND BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO NOT IN (SELECT PAR_CODINT||PAR_CODEMP||PAR_MATRIC||PAR_TIPREG||PAR_DIGITO "
   		cQuery4 += " FROM "+RetSqlName("PAR")+" PAR  "
    	cQuery4 += " WHERE D_E_L_E_T_ = ' ' AND PAR_FILIAL = '"+xFilial("PAR")+"' AND PAR_CODRDA = '"+cCodRDA+"' AND PAR_COMPET = '"+cMesPag+cAnoPag+"' ) "
   	EndIf
	*/
	
	If Select(_4cAliasQry) <> 0 
		(_4cAliasQry)->(DbCloseArea()) 
	Endif

	If lDebuggg .and. !MsgYesNo(AllTrim(ProcName()) + ' :  Continua?')
		Return
	EndIf

	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery4),_4cAliasQry,.T.,.T.)
	
	DbSelectArea(_4cAliasQry)
	cArqTrab := CriaTrab(aStru, .T.)
		
	DbUseArea(.T.,__LocalDriver,cArqTrab,_5cAliasQry,.F.)
	
	While !(_4cAliasQry)->(EOF())
	
		(_5cAliasQry)->(RecLock((_5cAliasQry),.T.))
		
		For i := 1 to len(aStru)
	
			If aStru[i][2] = "D"
				(_5cAliasQry)->&(aStru[i][1]) := STOD((_4cAliasQry)->&(aStru[i][1]))
			Else
				(_5cAliasQry)->&(aStru[i][1]) := (_4cAliasQry)->&(aStru[i][1])
			EndIf
		
		Next
		
		(_5cAliasQry)->(MsUnlock())
		
		(_4cAliasQry)->(dbSkip())          
		
	EndDo
	
EndIf

DbSelectArea("PAQ")
DbSetOrder(1)

//PAQ->(DbGoTop()) 
PAQ->(DbGoTo(aRecPAQ[1]))

//While !(PAQ->(Eof()))
    
    /*      
	If PAQ->PAQ_CODRDA = "136190"
    	Alert("Chegou no segundo auxiliar!")
    EndIf
    */
    aArray1 := {}//zero o vetor a cada loop
    nValorRDA := PAQ->PAQ_VALOR
    /*
    If PAQ->PAQ_AUX = "S"
    	If !lOkAux
    		PAQ->(DbSkip())
    		Loop
    	EndIf
    EndIf           
    */ 
    /*
    //MBC                  
    // Se for Individual e ano/mes diferente do informado, pula o registro
    If PAQ->PAQ_TIPORT <> 'I' .or. ( PAQ->PAQ_ANO + PAQ->PAQ_MES <> cAnoPag + cMesPag )
    
    	PAQ->(DbSkip())
    	Loop
    
    EndIf
    */
	If BAU->(DbSeek(xFilial("BAU")+PAQ->PAQ_CODRDA))
		cCrmSolic := BAU->BAU_CONREG
		cTipoPgto := BAU->BAU_GRPPAG
		cNomRDA   := BAU->BAU_NOME
		cCodRda   := BAU->BAU_CODIGO
	EndIf
	 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consulta para verificar o total de internacoes solicitadas pela RDA ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If PAQ->PAQ_AUX == "N"
		cQuery := " SELECT  /*+ INDEX(" + If(cEmpAnt == '01','BD6010 BD6010TMP','BD6020 BD6020TMP') + ") */ Count(DISTINCT(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)) AS TOTAL "	+ CRLF
		cQuery += " FROM "+RetSQLName("BD6") 																					  		+ CRLF
		cQuery += " WHERE BD6_FILIAL = '" + xFilial('BD6')+ "'" 											  							+ CRLF
		cQuery += " AND BD6_CODOPE = '" + PLSINTPAD() + "' " 												   							+ CRLF
		cQuery += " AND BD6_DATPRO BETWEEN '" + DtoS(dIniCalc) + "' AND '" +  DtoS(dFimCalc) + "'"										+ CRLF 
		cQuery += " AND SUBSTR(BD6_NUMLOT,1,6) = '" + cAnoPeg + cMesPeg + "'" 															+ CRLF   
		// Query += " AND SUBSTR(BD6_NUMLOT,1,6) IN ('201602','202102','202103','202104') " 											+ CRLF //MOTTA 16/3/16 
		cQuery += " AND D_E_L_E_T_ = ' ' " 																	   							+ CRLF
		cQuery += " AND BD6_CODPRO = '"+cCodProc+"'" 															   						+ CRLF
		cQuery += " AND BD6_CODRDA = '"+cCodRDA+"'" 																					+ CRLF
		cQuery += " AND BD6_SITUAC = '1' "        																						+ CRLF
		cQuery += " AND BD6_VLRPAG > 0 "     					   																		+ CRLF
        cQuery += " AND BD6_MOTBPF <> '501'"  																							+ CRLF

//		cQuery += " AND BD6_QTDPRO > 1"
//		cQuery += " AND ROWNUM <= 10 "        																		+ CRLF

		If lExistRat
			cQuery += " AND BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO NOT IN (SELECT PAR_CODINT||PAR_CODEMP||PAR_MATRIC||PAR_TIPREG||PAR_DIGITO "
   		 	cQuery += "FROM "+RetSqlName("PAR")+" PAR  "
    		cQuery += "WHERE D_E_L_E_T_ = ' ' AND PAR_FILIAL = '"+xFilial("PAR")+"' AND PAR_CODRDA = '"+cCodRDA+"' AND PAR_COMPET = '"+cMesPag+cAnoPag+"' ) "
   		EndIf
		
		If Select(cAliasQry) <> 0 
			(cAliasQry)->(DbCloseArea()) 
		Endif
		
		If lDebuggg .and. !MsgYesNo(AllTrim(ProcName()) + ' :  Continua?')
			Return
		EndIf

		DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
	
		nTotQry := (cAliasQry)->TOTAL
			
		If nTotQry == 0
			MsgAlert("Nao existe atendimentos para o RDA "+AllTrim(cNomRDA)+" neste periodo ou o pagamento ja foi gerado anteriormente !!!")
			(cAliasQry)->(DbCloseArea())
			/*
			PAQ->(DbSkip())
			Loop   
			*/
		Else
			lGerouRat := .T. //identifica que houve rateio ao menos para um internista
			ProcRegua(nTotQry)
		EndIf
	
	Else
		ProcRegua(nTotQry)	
	EndIf	
	
	//Estabelece o valor que será rateeado para cada beneficiário atendido
	If PAQ->PAQ_AUX == "N"
		
		If PAQ->PAQ_TIPORT == 'I' //.AND. DbSeek(xFilial("PAR")+cMesPag+cAnoPag+PAQ->PAQ_CODRDA) //se encontrar qualquer rateio gerado para o RDA na competencia em questao, tem que buscar o valor ja gerado
		
			nVlrIndRDA := PAQ->PAQ_VALOR
			
		EndIf

	EndIf
	
	If Select(cArqQryPG) <> 0
		(cArqQryPG)->(DbCloseArea())
	EndIf
	 
	If Select(cArqQryInt)<>0
		(cArqQryInt)->(DbCloseArea())
	EndIf
	
	If PAQ->PAQ_AUX == "N"
		                   //BD6_CODPLA, BD6_OPERDA, BD6_CODRDA, BD6_CODOPE, BD6_CODPAD, BD6_CODPRO, BD6_DATPRO, BD6_HORPRO, BD6_NOMUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,BD6_DIGITO,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO
		cQuery2 := " SELECT  /*+ INDEX(" + If(cEmpAnt == '01','BD6010 BD6010TMP','BD6020 BD6020TMP') + ") */ BD6_CODPLA, BD6_OPERDA, BD6_CODRDA, BD6_CODOPE, BD6_CODPAD, BD6_CODPRO, BD6_DATPRO, BD6_HORPRO, BD6_NOMUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_QTDAPR, BD6_QTDPRO "
		cQuery2 += " FROM "+RetSQLName("BD6") 																					  		+ CRLF
		cQuery2 += " WHERE BD6_FILIAL = '" + xFilial('BD6')+ "'" 											  							+ CRLF
		cQuery2 += " AND BD6_CODOPE = '" + PLSINTPAD() + "' " 												   							+ CRLF
		cQuery2 += " AND BD6_DATPRO BETWEEN '" + DtoS(dIniCalc) + "' AND '" +  DtoS(dFimCalc) + "'"									+ CRLF 
		cQuery2 += " AND SUBSTR(BD6_NUMLOT,1,6) = '" + cAnoPeg + cMesPeg + "'" 															+ CRLF  
	    //cQuery2 += " AND SUBSTR(BD6_NUMLOT,1,6) IN ('201602','202102','202103','202104')  " 											+ CRLF  Motta
		cQuery2 += " AND D_E_L_E_T_ = ' ' " 																	   						+ CRLF
		cQuery2 += " AND BD6_CODPRO = '"+cCodProc+"'" 															   						+ CRLF
		cQuery2 += " AND BD6_CODRDA = '"+cCodRDA+"'" 																					+ CRLF
		cQuery2 += " AND BD6_SITUAC = '1' "        																						+ CRLF
		cQuery2 += " AND BD6_VLRPAG > 0 " 					       																		+ CRLF
        cQuery3 += " AND BD6_MOTBPF <> '501'" 	   																						+ CRLF

// 		cQuery2 += " AND BD6_QTDPRO > 1"
//		cQuery2 += " AND ROWNUM <= 10 "        																		+ CRLF

		If lExistRat
			cQuery2 += " AND BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO NOT IN (SELECT PAR_CODINT||PAR_CODEMP||PAR_MATRIC||PAR_TIPREG||PAR_DIGITO "
   		 	cQuery2 += "FROM "+RetSqlName("PAR")+" PAR  "
    		cQuery2 += "WHERE D_E_L_E_T_ = ' ' AND PAR_FILIAL = '"+xFilial("PAR")+"' AND PAR_CODRDA = '"+cCodRDA+"' AND PAR_COMPET = '"+cMesPag+cAnoPag+"' ) "
   		EndIf
				
		If Select(_2cAliasQry) <> 0 
			(_2cAliasQry)->(DbCloseArea()) 
		Endif
        
		If lDebuggg .and. !MsgYesNo(AllTrim(ProcName()) + ' :  Continua?')
			Return
		EndIf

		DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery2),_2cAliasQry,.T.,.T.)
	
    Else
    	(_5cAliasQry)->(DbGoTop())
	EndIf
		
	//busca o local de atendimento e especialidade
    DbSelectArea("BAU")
	DbSetOrder(1)
	If DbSeek(xFilial("BAU")+cCodRDA)
		cLocalBB8  := POSICIONE("BB8",1,xFilial("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE	,"BB8_CODLOC")
		cDesLocBB8 := POSICIONE("BB8",1,xFilial("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE	,"BB8_DESLOC")
		cBB8END    := POSICIONE("BB8",1,xFilial("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE	,"BB8_END")
		cBB8NR_END := POSICIONE("BB8",1,xFilial("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE	,"BB8_NR_END")
		cBB8COMEND := POSICIONE("BB8",1,xFilial("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE	,"BB8_COMEND")
		cBB8Bairro := POSICIONE("BB8",1,xFilial("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE	,"BB8_BAIRRO")
		cCodEsp    := POSICIONE("BAX",1,xFilial("BAX")+cCodRDA+cCodInt+cLocalBB8		,"BAX_CODESP")
	EndIf	
	
	If PAQ->PAQ_AUX == "N"
		cMacroTab := '("' + _2cAliasQry + '")'
	Else
		cMacroTab := '("' + _5cAliasQry + '")'
	EndIf
	
	DbSelectArea(&cMacroTab)
	
	n_Cont 	:= 0
	n_I 	:= 0
	
	COUNT TO n_Cont
	
	(&cMacroTab)->(DbGoTop())
	
	ProcRegua(n_Cont)
		
	While !((&cMacroTab)->(Eof()))
	
		IncProc('Incluindo guias [ ' + cValToChar(++n_I) + ' ] de [ ' + cValToChar(n_Cont) + ' ] - RDA [ ' + BAU->BAU_CODIGO + ' - ' + AllTrim(BAU->BAU_NOME) + ' ]')
	    
	    //Verifico se já existe o registro na PAR, significando que já foi gravado rateio para o registro em questão. Renato Peixoto em 11/07/11
		DbSelectArea("PAR")
	    DbSetOrder(1)
	    
	    If DbSeek(xFilial("PAR")+cMesPag+cAnoPag+cCodRDA+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO)
		//	&cMacroTab->(DbSkip())
	 	//	Loop
		EndIf
		
		cOpeRDA := &cMacroTab->BD6_OPERDA
		cCodPad := &cMacroTab->BD6_CODPAD
	
		//busca o telefone do usuário
		cTelefone := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_TELEFO")
		//busca o sexo do usuario
		cSexo := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_SEXO")
		//busca a matricula anterior
		cMatAnt := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_MATANT")
		//busca a matricula da vida
		cMatVid := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_MATVID")
    	//busca a empresa do usuario
    	cCodEmpUsu := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_CODEMP")
    	//busca dados do contrato e sub-contrato do usuario
    	cConEmp := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_CONEMP")
		cVerCon := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_VERCON")	
		cSubCon := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_SUBCON")
		cVerSub := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_VERSUB")
        //
        //busca operadora de origem  do usuario
        //CRIADO PARA TRATAR OPERADORA DE ORIGEM QUANDO EMPRESA 0004  CONVENIO DE RECIPROCIDADE -- ALTAMIRO 08/08/2017 
        cOPEORI := POSICIONE("BA1",2,xFilial("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_OPEORI")
	    //{"OPEUSR", cOPEORI,;  
		aArray1 := {}//zero o vetor a cada loop
		aAdd ( aArray1  , { {"FILIAL",xFilial("BAU")},;
		{"CODRDA",cCodRDA},;
		{"OPERDA",cOpeRDA},;
		{"CODINT",cCodInt},;  
		{"NOMINT",cNomInt},;
		{"DATA",IIF(ValType(&cMacroTab->BD6_DATPRO)=="D",&cMacroTab->BD6_DATPRO,STOD(&cMacroTab->BD6_DATPRO))},; 
		{"DATPRO",IIF(ValType(&cMacroTab->BD6_DATPRO)=="D",&cMacroTab->BD6_DATPRO,STOD(&cMacroTab->BD6_DATPRO))},; 
		{"HORPRO",&cMacroTab->BD6_HORPRO/*STRTRAN(substr(time(),1,5),":","")*/},;
		{"NOMUSR",&cMacroTab->BD6_NOMUSR},;
		{"TELEFO",cTelefone},;
		{"CODESP",cCodEsp},; 
		{"CODLOC",cLocalBB8},; 
		{"LOCAL",PAQ->PAQ_LOCATE},; 
		{"SIGLA",BAU->BAU_SIGLCR},;
		{"ESTCR",BAU->BAU_ESTCR},;  
		{"REGSOL",BAU->BAU_CONREG},;
		{"NOMSOL",BAU->BAU_NOME},;
		{"CDPFSO",BAU->BAU_CODBB0},;
		{"REGEXE",BAU->BAU_CONREG},; 
		{"TIPCON","1"},;  
		{"SEXO",cSexo},;
		{"ANOPAG",cAnoPag},;
		{"MESPAG",cMesPag},;
		{"MATANT",cMatAnt},;    
		{"MATVID",cMatVid},;
        {"OPEUSR",cCodInt},;    
        {"OPEORI",cOPEORI },;      // INCLUIDO AOTAMIRO 10/08/2017 TRATAMENTO DA OPERADORA DE ORIGEM 
		{"TIPRDA",BAU->BAU_TIPPE},;
		{"MATRIC",&cMacroTab->BD6_MATRIC},;  
		{"TIPREG",&cMacroTab->BD6_TIPREG},;	   
		{"CPFRDA",BAU->BAU_CPFCGC},; 
		{"DIGITO",&cMacroTab->BD6_DIGITO},;
		{"NOMRDA",BAU->BAU_NOME},;  
		{"CODEMP",cCodEmpUsu},;  
		{"CONEMP",cConEmp},;
		{"VERCON",cVerCon},;
		{"SUBCON",cSubCon},;	
		{"VERSUB",cVerSub},;
		{"DATDIG",DDATABASE},;
		{"CODPAD","01"},;
		{"CODPRO",cCodProc},;
		{"TIPPRE",BAU->BAU_TIPPRE},;
		{"DTDIG1",DDATABASE},;
		{"VALOR" , nVlrIndRDA + If(n_I == n_Cont,nVlraju * If(nRadio == 1,1,-1),0) },;
		{"YVLTAP", nVlrIndRDA + If(n_I == n_Cont,nVlraju * If(nRadio == 1,1,-1),0) },;
		{"VLRAPR", nVlrIndRDA + If(n_I == n_Cont,nVlraju * If(nRadio == 1,1,-1),0) },;
		{"QTDAPR", &cMacroTab->BD6_QTDAPR},;//{"QTDAPR", 1},;
		{"QTDPRO", &cMacroTab->BD6_QTDPRO},;//{"QTDPRO", 1},;
		{"INDCLI", "Pagamento do Rateio dos auxiliares e dos internistas."},;
		{"BLOCPA", If(&cMacroTab->BD6_CODEMP == '0004','0','1')},;  
		{"DESBPF", "RATEIO INTERNISTAS"},; 
		{"TIPSAI", "5"},;
		{"ORIMOV", "1"},; 
		{"DESLOC", cDesLocBB8},;
		{"ENDLOC", AllTrim(cBB8END)+"+"+AllTrim(cBB8NR_END)+"-"+AllTrim(cBB8COMEND)+"-"+AllTrim(cBB8BAIRRO)},; 
		{"MOTBPF", "999"},;     // INFORME O CODIGO DO BLOQUEIO DA COPARTICIPACAO DE ACORDO COM A TABELA DE BLOQUEIO  Na BD5 é MOTBPG
		{"TIPATE", "04"},; //}) //código 04 - Consulta
		{"CODPLA", &cMacroTab->BD6_CODPLA} })  //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED. Alterado para pegar do vetor por Renato Peixoto. 

		n_VlrPEG  += ( nVlrIndRDA + If(n_I == n_Cont,nVlraju * If(nRadio == 1,1,-1),0) )
		//n_ProcPEG += &cMacroTab->BD6_QTDAPR   //DESCONTINUADO P12
		n_ProcPEG += &cMacroTab->BD6_QTDPRO
		n_GuiaPEG++
				
		//{"REGEXE", cCRMProf},;
		//{"OPEEXE", cOperProf},;
		//{"NOMEXE", cNomProf},; 
		//{"CDPFRE", cCodProf},; 
		//{"ESTEXE", cUFProf},; 
		//{"SIGEXE", cSiglaProf},;
		//{"REGPRE", cCRMProf},;
		//{"NOMPRE", cNomProf} })
		
		//Atualiza o conteudo da variavel cCodPla
		cCodPla := &cMacroTab->BD6_CODPLA       
		
	    //chama a rotina que vai gravar as guias do rateio dos internistas no contas médicas
	    //Begin Transaction  
	    
	    If lDebuggg .and. !MsgYesNo(AllTrim(ProcName()) + ' :  Continua?')
			Exit
		EndIf
	    
	    //===>ponto relatorio
	    u_nGERARATINT()
	    
	    //So vao para a query com BD6_VLRPAG > 0
	    /*
	    //bloqueio o pagamento na BD5, BD6 e BD7 das guias incluidas manualmente pelo contas médicas com valor zerado.
	    DbSelectArea("BD5")
	    DbSetOrder(1)
	    If DbSeek(xFilial("BD5")+&cMacroTab->BD6_CODOPE+&cMacroTab->BD6_CODLDP+&cMacroTab->BD6_CODPEG+&cMacroTab->BD6_NUMERO)
	    	RecLock("BD5",.F.)
	    	BD5->BD5_BLOPAG := "1"
	    	BD5->BD5_DESBPG := "Bloqueado automaticamente pela rotina de rateio dos internistas."
	    	BD5->(MsUnlock())
	    EndIf
	    
	    DbSelectArea("BD6")
	    DbSetOrder(1)
	    If DbSeek(xFilial("BD6")+&cMacroTab->BD6_CODOPE+&cMacroTab->BD6_CODLDP+&cMacroTab->BD6_CODPEG+&cMacroTab->BD6_NUMERO)
	    	RecLock("BD6",.F.)
	    	BD6->BD6_BLOPAG := "1"
	    	BD6->BD6_DESBPG := "Bloqueado automaticamente pela rotina de rateio dos internistas."
	    	BD6->(MsUnlock())
	    EndIf
	    
	    DbSelectArea("BD7")
	    DbSetOrder(2)
	    BD7->(DbGotop())
	    If DbSeek(xFilial("BD7")+&cMacroTab->BD6_CODOPE+&cMacroTab->BD6_CODLDP+&cMacroTab->BD6_CODPEG+&cMacroTab->BD6_NUMERO)
 	    	While !(BD7->(Eof())) .AND. (&cMacroTab->BD6_CODOPE+&cMacroTab->BD6_CODLDP+&cMacroTab->BD6_CODPEG+&cMacroTab->BD6_NUMERO = BD7->BD7_CODOPE+BD7->BD7_CODLDP+BD7->BD7_CODPEG+BD7->BD7_NUMERO)
	    		RecLock("BD7",.F.)
	    		BD7->BD7_BLOPAG := "1"
	    		BD7->BD7_DESBLO := "Bloqueado automaticamente pela rotina de rateio dos internistas."
	    		BD7->(MsUnlock())
	    		BD7->(DbSkip())
	    	EndDo
	    EndIf
	    */
	    
	    //Gravo o registro que acabei de gerar no contas medicas na tabela PAR, que eh uma tabela de controle para impedir a duplicidade no contas medicas
	    DbSelectArea("PAR")
	    DbSetOrder(1)
	    If !(DbSeek(xFilial("PAR")+cMesPag+cAnoPag+cCodRDA+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO))
	    	
	    	RecLock("PAR",.T.)
	    	PAR->PAR_FILIAL  := xFilial("PAR")
	    	PAR->PAR_COMPET  := cMesPag+cAnoPag
	    	PAR->PAR_CODRDA  := cCodRDA
	    	PAR->PAR_CODINT  := cCodInt
	    	PAR->PAR_NOMINT  := cNomInt
	    	PAR->PAR_CODEMP  := &cMacroTab->BD6_CODEMP
	    	PAR->PAR_MATRIC  := &cMacroTab->BD6_MATRIC
	    	PAR->PAR_TIPREG  := &cMacroTab->BD6_TIPREG
	    	PAR->PAR_DIGITO  := &cMacroTab->BD6_DIGITO
	    	PAR->PAR_NOMUSR  := &cMacroTab->BD6_NOMUSR
	    	PAR->PAR_VLRRAT  := nVlrIndRDA
	    	PAR->PAR_AUXILI  := PAQ->PAQ_AUX
	    	PAR->PAR_USUSIS  := AllTrim(__cuserid)
	    	PAR->PAR_NOUSIS  := cUserName 
	    	PAR->PAR_CODOPE  := cCodInt
	    	PAR->PAR_CODLDP  := cCodLDP
	    	PAR->PAR_CODPEG  := cCodPEG
	    	PAR->PAR_NUMGUI  := cGuiaRAT
	    	PAR->(MsUnlock())
	    	
	    	lGerouRat := .T. //identifica que houve rateio ao menos para um internista
	    	
	    EndIf
	    	
	    //End Transaction
	    
		&cMacroTab->(DbSkip())
		
	EndDo
	
	//Altera o quantitativo gerado para a PEG que acabou de ser finalizada...
	cQuery5 := "SELECT Count(par_codrda) TOT_GUIAS " 		+ CRLF
	cQuery5 += "FROM "+RetSqlName("PAR")+" PAR " 			+ CRLF
	cQuery5 += "WHERE D_E_L_E_T_ = ' ' " 					+ CRLF
	cQuery5 += "AND par_filial = '"+xFilial("PAR")+"' " 	+ CRLF
	cQuery5 += "AND par_compet = '"+cMesPag+cAnoPag+"' " 	+ CRLF
	cQuery5 += "AND par_codrda = '"+cCodRDA+"' " 			+ CRLF
    
	If Select(cArqTotGui)>0
		(cArqTotGui)->(DbCloseArea())
	EndIf
	
	If lDebuggg .and. !MsgYesNo(AllTrim(ProcName()) + ' :  Continua?')
		Return
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery5),cArqTotGui,.T.,.T.)
	
	DbSelectArea("BCI")
	DbSetOrder(1)
	If DbSeek(xFilial("BCI")+cCodInt+cCodLDP+cCodPEG)
		RecLock("BCI",.F.)  
		
		BCI->BCI_QTDEVE := n_ProcPEG
		BCI->BCI_VLRGUI := n_VlrPEG
		BCI->BCI_QTDDIG := n_GuiaPEG
	
		BCI->(MsUnlock())
	EndIf
	
	(cArqTotGui)->(DbCloseArea())
	//Fim alteracao totalizacao guias dentro da PEG. Renato Peixoto em 21/03/2012
//	PAQ->(DbSkip())
	
//EndDo

If lGerouRat
	MsgAlert("Rateio da RDA gerado. Verifique os resultados!",AllTrim(SM0->M0_NOMECOM))
Else
	MsgAlert("Não foi gerado rateio de internista para esta competência. Provavelmente este rateio já foi gerado anteriormente ou o sistema não encontrou nenhuma guia para estes internistas/auxiliares na competência informada. Favor verificar.",AllTrim(SM0->M0_NOMECOM))
EndIf

If Select(cAliasQry) > 0
	(cAliasQry)->(DbCloseArea())
EndIf

If lGerouRat
	
	If Select(&cMacroTab)> 0
		&cMacroTab->(DbCloseArea())
	EndIf
	
	If Select(_2cAliasQry) > 0
		(_2cAliasQry)->(DbCloseArea())
	EndIf
	
	If Select(_3cAliasQry) > 0
		(_3cAliasQry)->(DbCloseArea())
	EndIf
	
EndIf

Return           


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CriaSX1  ³ Autor ³ Renato Peixoto        ³ Data ³ 22/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Cria/Atualiza perguntas.                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CriaSX1()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CriaSX1()

PutSx1(cPerg,"01",OemToAnsi("Mes Pgto:")     ,"","","mv_ch1","C",02,0,0,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será o mês de Pgto no formato mm"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Ano Pgto:")     ,"","","mv_ch2","C",04,0,0,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será o ano do Pgto no formato aaaa"},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("Data do Evento"),"","","mv_ch3","D",08,0,0,"G","","   ","","","mv_par03",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será a data do evento que irá aparecer na guia"},{""},{""})

Return  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GERARATINTºAutor  ³Renato Peixoto      º Data ³  15/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera o rateio, incluindo uma guia para cada usuário que foi º±±
±±º          ³atendido pelos internistas.                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function nGERARATINT()

Local nQ 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local I__f 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL nH := PLSAbreSem("GERARATINT.SMF")
LOCAL cNumGuia
LOCAL nFor
LOCAL nAux
LOCAL nQ 
LOCAL aFiles
LOCAL cAliasAux
LOCAL nPos
LOCAL cAliasPri
LOCAL cCpoFase
LOCAL aStruARQ    := {}
LOCAL aHeaderBE2  := {}

LOCAL aRetCal     := PLSXVLDCAL(dDtEvento,cCodInt,.F.)    // Valida o calendario de pagamento da operadora
//Local aPar        := {}
Local aRetAux     := {}
LOCAL nHESP
Local cMacro 
LOCAL nStackSX8   := GetSx8Len()     

PRIVATE cFunGRV
PRIVATE cTipGRV
PRIVATE cTipoGuia
PRIVATE cGuiRel

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe o PEG eletronico do mes para o credenciado...         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("BCI")
BCI->(DbSetOrder(4))

If !(aRetCal[1])
	APMSGSTOP("Atenção, não existe calendario de pagamento para a data em questão ou os parâmetros de pagamento desse mês não foram configurados. Favor Verificar antes de realizar este processo.","Processo não pode ser realizado.")
	Return
EndIf

If lDebuggg .and. !MsgYesNo(AllTrim(ProcName()) + ' :  Continua?')
	Return
EndIf

nHESP := PLSAbreSem("PLSPEG.SMF")
//Ordem 4 da BCI: BCI_FILIAL + BCI_OPERDA + BCI_CODRDA+ BCI_ANO + BCI_MES + BCI_TIPO + BCI_FASE + BCI_SITUAC + BCI_TIPGUI + BCI_CODLDP + BCI_ARQUIV                               
//If ! BCI->(DbSeek(xFilial("BCI")+cOpeRDA+cCodRDA+cAnoPag+cMesPag+"211"+"02"+"0001")) 
If ! BCI->(DbSeek(xFilial("BCI")+cOpeRDA+cCodRDA+cAnoPag+cMesPag+"211"+"02"+"0017")) 

	cNewPEG := PLSA175Cod(cOpeRDA,"0001")//GetNewPar("MV_PLSPEGE","0000"))
	
	BCI->(RecLock("BCI",.T.))
	BCI->BCI_FILIAL := xFilial("BCI")
	BCI->BCI_CODOPE := cOpeRDA
	BCI->BCI_PROTOC := CriaVar("BCI_PROTOC")
	BCI->BCI_CODLDP := '0017'//"0001" //GetNewPar("MV_PLSPEGE","0001")
	BCI->BCI_CODPEG := cNewPEG
	BCI->BCI_OPERDA := cOpeRDA
	BCI->BCI_CODRDA := cCodRDA//cOpeRDA  
	BCI->BCI_NOMRDA := cNomRDA
	BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
	BCI->BCI_TIPGUI := GetNewPar("MV_PLSTPGS","01")//GetNewPar("MV_PLSTPGC","01")  alterado para guia de serviços a pedido do Dr. Jose Paulo por Renato Peixoto.
	BCI->BCI_TIPPRE := BAU->BAU_TIPPRE
	
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
	//BCI->BCI_QTDGUI := 1
	BCI->BCI_VLRGUI := nValorRDA//REVER
	BCI->BCI_DATREC := dDataBase//Base
	//BCI->BCI_DTPRPG := ctod("")
	BCI->BCI_DTDIGI := dDtEvento
	BCI->BCI_QTDDIG := 1
	//BCI->BCI_VALDIG := 0 //REVER
	BCI->BCI_CODCOR := BCL->BCL_CODCOR
	BCI->BCI_FASE   := "1"
	BCI->BCI_SITUAC := "1"
	BCI->BCI_MES    := cMesPag
	BCI->BCI_ANO    := cAnoPag
	BCI->BCI_TIPO   := "2" 
	BCI->BCI_STATUS := "1"
	BCI->(MsUnLock())
	
	While GetSx8Len() > nStackSX8
		BCI->( ConfirmSX8() )
	EndDo
	
Else
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
Endif

PLSFechaSem(nHESP,"PLSPEG.SMF")

cTipoGuia := BCL->(BCL_TIPGUI)
cGuiRel   := BCL->BCL_GUIREL
cFunGRV   := BCL->BCL_FUNGRV
cTipGRV   := BCL->BCL_TIPGRV  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do processo de gravacao das guias...                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFiles := PLSA500Fil(BCI->BCI_CODOPE,BCI->BCI_TIPGUI)

For nQ := 1 to Len(aArray1)  //Loop para gerar uma guia para cada usuario contido no array
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta os Objetivos...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nFor := 1 To Len(aFiles)
		cAliasAux := aFiles[nFor,1]
		
		If Empty(cAliasPri)
			cAliasPri := aFiles[nFor,1]
			cNumGuia  := PLSA500NUM(cAliasPri,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
		Endif
		
		If aFiles[nFor,3] == "2"
			aStruARQ := (cAliasAux)->(DbStruct())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta RegToMemory...                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Copy cAliasAux To Memory Blank
						
			//Dados fixos para todos os arquivos a serem procesados do contas medicas
			&("M->"+cAliasAux+"_CODOPE") := BCI->BCI_CODOPE
			&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
			&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
			&("M->"+cAliasAux+"_NUMERO") := cNumGuia
			&("M->"+cAliasAux+"_TIPGUI") := BCI->BCI_TIPGUI
			
			//Dados variados para cada arquivo que esta sendo processado
			For nAux := 1 To Len(aArray1[nQ])   //Processa a quantida de campos contidos no array do usuario em questao
				nPos := ascan(aStruARQ, {|x| alltrim(x[1]) = cAliasAux+"_"+aArray1[nQ,nAux,1]}) //ascan(aStruARQ,aArray1[nQ,nAux,1])   //Verifica se o campo a ser gravado nesta tabela corresponde ao do array
				If nPos > 0
					&("M->"+cAliasAux+"_"+aArray1[nQ,nAux,1]) := aArray1[nQ,nAux,2]
				Endif
			Next
			
			PLUPTENC(cAliasAux,K_Incluir)
		Else
			CONOUT("Gravacao de itens nao implementada") //
		Endif  
		                        
	Next 
	
Next

//Crio o vetor aHeaderBE2 com os dados do SX3 para os campos BE2_CODPAD, BE2_CODPRO e BE2_STATUS
DbSelectArea("SX3")
SX3->(DbSetOrder(1))
SX3->(dbSeek("BE2"))

_Recno := Recno() 

Do While !Eof() .And. (X3_ARQUIVO == "BE2")
	If X3_CAMPO = "BE2_CODPAD" .or. X3_CAMPO = "BE2_CODPRO" .or. X3_CAMPO = "BE2_STATUS"
		Aadd(aHeaderBE2,{Trim(X3_TITULO), X3_CAMPO, X3_PICTURE, X3_TAMANHO, X3_DECIMAL,".T.", X3_USADO, X3_TIPO, X3_ARQUIVO, X3_CONTEXT})
	Endif
	dbSkip()
Enddo 

DbGoto(_Recno)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa funcao de gravacao dos dados...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cFunGRV)
	aPar   := {K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.,cAliasPri,"01","","1",{{cCodPad,cCodProc,"1"}}, aHeaderBE2 }//{K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.}
	cMacro := (AllTrim(cFunGRV)+"(aPar)")
	&(cMacro)
Endif

//Gravo os campos BD6_YVLTAP com o valor correspondente ao NUPRE e o campo QTDAPR
DbSelectArea("BD6")
RecLock("BD6",.F.)

nPos := 0

BD6->BD6_YVLTAP := If( ( nPos := aScan(aArray1[1],{|x|x[1] == 'YVLTAP'}) ) > 0,aArray1[1][nPos][2],nVlrIndRDA)
BD6->BD6_VLRAPR := If( ( nPos := aScan(aArray1[1],{|x|x[1] == 'VLRAPR'}) ) > 0,aArray1[1][nPos][2],nVlrIndRDA)
BD6->BD6_QTDPRO := If( ( nPos := aScan(aArray1[1],{|x|x[1] == 'QTDPRO'}) ) > 0,If(aArray1[1][nPos][2] > 0,aArray1[1][nPos][2],1),1)
//BD6->BD6_QTDAPR := If( ( nPos := aScan(aArray1[1],{|x|x[1] == 'QTDAPR'}) ) > 0,If(aArray1[1][nPos][2] > 0,aArray1[1][nPos][2],1),1) 

**'Beg - Comentado e alterado por Marcela Coimbra para não bloquear a copart para convenio 28/11/2014'**
//BD6->BD6_BLOCPA := "1"
BD6->BD6_BLOCPA := If(BD6->BD6_CODEMP == '0004','0','1')//"1"                              
**'Fim - Comentado e alterado por Marcela Coimbra para não bloquear a copart para convenio 28/11/2014'**      

BD6->BD6_DESBPF := "RATEIO INTERNISTAS"
BD6->BD6_MOTBPF := "501"

//Renato Peixoto em 11/07/12: Verifico se foi gravado na BD6 o codigo do plano correto. Se nao gravou, atualizo com o plano correto.
If BD6->BD6_CODPLA <> cCodPla
	BD6->BD6_CODPLA := cCodPla
EndIf

BD6->(MsUnlock())

//Verifico na BD7 se foi gravado o plano corretamente e altero se necessario
If BD7->BD7_CODPLA <> cCodPla
	RecLock("BD7",.F.)
	BD7->BD7_CODPLA := cCodPla
	BD7->(MsUnlock())
EndIf
//Fim alteração Renato Peixoto. 
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Muda a fase da guia...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCpoFase := (cAliasPri+"->"+cAliasPri+"_FASE")

If !Empty(BCL->BCL_FUNMFS)
     
     //Leonardo Portella - 14/10/13 - Inicio - Virada P11: alteracao nos parametros. Incluido vetor de glosas
     
     aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri,{}}
     //aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri}
         
     //Leonardo Portella - 14/10/13 - Fim
     
     cMacro := (AllTrim(BCL->BCL_FUNMFS)+"(aPar)")
     
     aRetAux := &(cMacro)
Endif 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza transacao fisica...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PLSFechaSem(nH,"GERARATINT.SMF")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//alimento as variáveis para controle no espelho do rateio
cCodPEG := BCI->BCI_CODPEG
cGuiaRat := cNumGuia

Return .T.

**'----------------------------------------------------------------------------------------------------------------'**
**'----------------------------------------------------------------------------------------------------------------'**
User Function nfDefRDATx(c_Ano, c_Mes)
**'----------------------------------------------------------------------------------------------------------------'**

Local n_Ct := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local l_Ret 	:= .F.
Local a__Area 	:= GetArea()

Private _oDlg	

// Variaveis que definem a Acao do Formulario
Private VISUAL := .F.                        
Private INCLUI := .F.                        
Private ALTERA := .F.                        
Private DELETA := .F.    

// Privates das NewGetDados
Private oGet
Private aHeader    	:= {}// Array a ser tratado internamente na MsNewGetDados como aHeader                    
Private aCols      	:= {}// Array a ser tratado internamente na MsNewGetDados como aCols

Private bVlrAjuste 	:= 	{||If(empty(aCols[1][3]) .or. nVlraju < aCols[1][3],.T.,(MsgStop('Valor absoluto do ajuste não pode ser maior ou igual ao valor absoluto do procedimento!',AllTrim(SM0->M0_NOMECOM)),.F.))}


Define FONT oFont1 	NAME "Arial" SIZE 0,20  Bold
Define FONT oFont2 	NAME "Arial" SIZE 0,15  Bold    
Define FONT oFont3 	NAME "Arial" SIZE 0,13  Bold

DEFINE MSDIALOG _oDlg TITLE "Define valor por guia" FROM 178,189 TO 552,722 PIXEL

	// Cria as Groups do Sistema
	@ 005,004 TO 037,080 LABEL "" 						PIXEL OF _oDlg
	@ 001,082 TO 037,165 LABEL "Período para cálculo" 	PIXEL OF _oDlg
	@ 001,169 TO 037,235 LABEL "Prévia" 				PIXEL OF _oDlg
	@ 004,237 TO 037,265 LABEL "" 						PIXEL OF _oDlg
	@ 039,004 TO 119,265 LABEL "" 						PIXEL OF _oDlg
	@ 121,004 TO 159,265 LABEL "Ajuste no valor total" 	PIXEL OF _oDlg
	@ 161,004 TO 186,265 LABEL "" 						PIXEL OF _oDlg

	// Cria Componentes Padroes do Sistema
	@ 007,008 Say "Ano"  Size 015,008 FONT oFont1 COLOR CLR_BLUE PIXEL OF _oDlg
	@ 007,026 Say c_Ano  Size 020,008 FONT oFont1 COLOR CLR_BLUE PIXEL OF _oDlg
	@ 007,048 Say "Mês"  Size 015,008 FONT oFont1 COLOR CLR_BLUE PIXEL OF _oDlg
	@ 007,068 Say c_Mes  Size 020,008 FONT oFont1 COLOR CLR_BLUE PIXEL OF _oDlg   
	@ 022,008 Say If(cEmpAnt == '01','CABERJ','INTEGRAL') Size 045,008 FONT oFont1 COLOR CLR_BLUE PIXEL OF _oDlg
	
	@ 010,085 Say "De"  Size 015,008 					COLOR CLR_BLACK PIXEL OF _oDlg
	@ 010,095 MsGet dIniCalc  WHEN .T. Size 054,009 	COLOR CLR_BLACK PIXEL OF _oDlg
	@ 024,085 Say "Até"  Size 015,008 					COLOR CLR_BLACK PIXEL OF _oDlg
	@ 024,095 MsGet dFimCalc  WHEN .T. Size 054,009 	COLOR CLR_BLACK PIXEL OF _oDlg
	
	//Chamadas das GetDados do Sistema
    fGetDados1(c_Ano, c_Mes)         
    
	oRadio := TRadMenu():New (130,10,{'Positivo','Negativo'},{|u| If(PCount()>0,nRadio:=u,nRadio)},_oDlg,,,CLR_BLACK,CLR_WHITE,"",,,35,14,,.F.,.F.,.T. )
	
	oSay   	:= TSay():New(130,060,,_oDlg,,oFont3,,,,.T.,CLR_BLUE,,400,900)
	oSay:SetText('Valor ajuste') 
	
	oGet1  	:= TGet():New( 130,095,{|u| If(PCount()>0,nVlraju:=u,nVlraju)},_oDlg,056,008,'@E 999,999,999.99',bVlrAjuste,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlraju",,)
	
	oSay2   := TSay():New(008,173,,_oDlg,,oFont3,,,,.T.,CLR_BLUE,,400,900)
	oSay2:SetText(u_cPrev326())
	
	oBtnBmp := TBtnBmp2():New(028,487,030,030,'TK_REFRESH',,,,{||If(Eval(bVlrAjuste),oSay2:SetText(u_cPrev326()),),_oDlg:Refresh()},_oDlg,,,.T. )
	oBtnBmp:cToolTip := "Atualizar prévia..."
	
	@ 168,181 Button "Ok"      Size 037,012 PIXEL OF _oDlg ACTION ( If(VldDtas(dIniCalc,dFimCalc) .and. Eval(bVlrAjuste) .and. ;
			If(u_cPrev326(.T.)=='-',(MsgStop('Valor do procedimento zerado!',AllTrim(SM0->M0_NOMECOM)),.F.),MsgYesNo('Confirma a geração do rateio?',AllTrim(SM0->M0_NOMECOM))),(l_Ret:=.T.,_oDlg:End()),) )
	@ 168,224 Button "Cancela" Size 037,012 PIXEL OF _oDlg ACTION ( l_Ret:=.F., _oDlg:End() )
	
ACTIVATE MSDIALOG _oDlg CENTERED 

RestArea(a__Area)
    
//PAQ - CAD INTERNISTAS E AUXILIARES
  
If l_Ret

	For n_Ct := 1 to Len( aCols )	 
	    
		cCodRDA := aCols[n_Ct][1]
		
		DbSelectArea("PAQ")
		
		nVlrIndRDA := aCols[n_Ct][3]  
		
		If aCols[n_Ct][4] > 0
		
			DbGoTo(aCols[n_Ct][4])
				
			c_PAQ_CODRDA := PAQ->PAQ_CODRDA
			c_PAQ_NOMRDA := PAQ->PAQ_NOMRDA
			n_PAQ_VALOR  := aCols[n_Ct][3] 
			c_PAQ_AUX    := PAQ->PAQ_AUX   
			c_PAQ_CODAUX := PAQ->PAQ_CODAUX
			c_PAQ_RDASUP := PAQ->PAQ_RDASUP
			c_PAQ_LOCATE := PAQ->PAQ_LOCATE
			c_PAQ_ANO    := PAQ->PAQ_ANO
			c_PAQ_MES    := PAQ->PAQ_MES
			c_PAQ_TIPORT :=	PAQ->PAQ_TIPORT             
		    
			RecLock("PAQ",.T.)
				
			PAQ_CODRDA := c_PAQ_CODRDA
			PAQ_NOMRDA := c_PAQ_NOMRDA
			PAQ_VALOR  := n_PAQ_VALOR 
			PAQ_AUX    := c_PAQ_AUX   
			PAQ_CODAUX := c_PAQ_CODAUX
			PAQ_RDASUP := c_PAQ_RDASUP
			PAQ_LOCATE := If(empty(c_PAQ_LOCATE),'001',PAQ_LOCATE)
			PAQ_ANO    := c_Ano
			PAQ_MES    := c_Mes
			PAQ_TIPORT := 'I' //Tipo de rateio                       
		
			PAQ->(MsUnlock())
			
			nRecPAQ := PAQ->(RECNO())
			
		Else
			
			RecLock("PAQ",.T.)
				
			PAQ_CODRDA := aCols[n_Ct][1]
			PAQ_NOMRDA := aCols[n_Ct][2]
			PAQ_VALOR  := aCols[n_Ct][3]
			PAQ_LOCATE := '001' 
			/*
			PAQ_AUX    := c_PAQ_AUX   
			PAQ_CODAUX := c_PAQ_CODAUX
			PAQ_RDASUP := c_PAQ_RDASUP
			PAQ_LOCATE := c_PAQ_LOCATE
			*/
			PAQ_ANO    := c_Ano
			PAQ_MES    := c_Mes
			PAQ_TIPORT := 'I'//Tipo de rateio                       
		
			PAQ->(MsUnlock())	
			
		EndIf
		
		aAdd(aRecPAQ,PAQ->(RECNO()))//Novo recno a ser deletado depois
	       
	Next
   
EndIf  

Return(l_Ret) 

*******************************************************

Static Function VldDtas(dIni,dFim)

Local lOk := .T.

Do Case 

	Case empty(dIni)
		MsgStop('Informe a data inicial!',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.

	Case empty(dFim)
		MsgStop('Informe a data final!',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.

	Case dIni > dFim
		MsgStop('Data inicial NÃO pode ser maior que a data final!',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.

End Case

Return lOk 

********************************************************************************************

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³fGetDados1()³ Autor ³ Ricardo Mansano           ³ Data ³11/11/2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Montagem da GetDados                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao ³ O Objeto oGetDados1 foi criado como Private no inicio do Fonte   ³±±
±±³           ³ desta forma voce podera trata-lo em qualquer parte do            ³±±
±±³           ³ seu programa:                                                    ³±±
±±³           ³                                                                  ³±±
±±³           ³ Para acessar o aCols desta MsNewGetDados: oGetDados1:aCols[nX,nY]³±±
±±³           ³ Para acessar o aHeader: oGetDados1:aHeader[nX,nY]                ³±±
±±³           ³ Para acessar o "n"    : oGetDados1:nAT                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fGetDados1(c_Ano, c_Mes)
// Variaveis deste Form                                                                                                         
Local nX			:= 0                                                                                                              

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis da MsNewGetDados()      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Vetor responsavel pela montagem da aHeader
Local aCpoGDa       	:= {"PAQ_CODRDA", "PAQ_NOMRDA", "PAQ_VALOR"}                                                                                                 

// Vetor com os campos que poderao ser alterados                                                                                
Local aAlter       	:= {"PAQ_VALOR"}
Local nSuperior    	:= 048           // Distancia entre a MsNewGetDados e o extremidade superior do objeto que a contem
Local nEsquerda    	:= 010           // Distancia entre a MsNewGetDados e o extremidade esquerda do objeto que a contem
Local nInferior    	:= 108           // Distancia entre a MsNewGetDados e o extremidade inferior do objeto que a contem
Local nDireita     	:= 256           // Distancia entre a MsNewGetDados e o extremidade direita  do objeto que a contem

// Posicao do elemento do vetor aRotina que a MsNewGetDados usara como referencia  
Local nOpc         	:= GD_INSERT+GD_DELETE+GD_UPDATE                                                                            
Local cLinhaOk     	:= "AllwaysTrue"    // Funcao executada para validar o contexto da linha atual do aCols                  
Local cTudoOk      	:= "AllwaysTrue"    // Funcao executada para validar o contexto geral da MsNewGetDados (todo aCols)      
Local cIniCpos     	:= ""               // Nome dos campos do tipo caracter que utilizarao incremento automatico.            
                                         // Este parametro deve ser no formato "+<nome do primeiro campo>+<nome do            
                                         // segundo campo>+..."                                                               
Local nFreeze      	:= 000              // Campos estaticos na GetDados.                                                               
Local nMax         	:= 999              // Numero maximo de linhas permitidas. Valor padrao 99                           
Local cCampoOk     	:= "AllwaysTrue"    // Funcao executada na validacao do campo                                           
Local cSuperApagar 	:= ""               // Funcao executada quando pressionada as teclas <Ctrl>+<Delete>                    
Local cApagaOk     	:= ".F."    // Funcao executada para validar a exclusao de uma linha do aCols                   
// Objeto no qual a MsNewGetDados sera criada                                      
Local oWnd          	:= _oDlg                                                                                                  
Local _6cAliasQry := GetNextAlias()// MBC

Private aRotina 	:={ { "Pesquisar"	,"AxPesqui"		,0,1	} ,;
		            	{ "Visualizar"	,"u_cb19Visu"	,0,2	} ,;
		             	{ "Incluir"		,"u_cb19inclui"	,0,3	} ,;
		             	{ "Cancela"		,"u_cb19Estrona",0,7	} ,;
		             	{ "Legenda"		,"u_c19Legend"	,0,6	} ,;// 
		             	{ "Alterar"     ,"u_CABTMP"	,0,8	} ,;		             	
		             	{ "Relatorio"   ,"u_CABR025"	,0,8	} } 

                                                                                                                                
// Carrega aHead                                                                                                                
DbSelectArea("SX3")                                                                                                             
SX3->(DbSetOrder(2)) // Campo                                                                                                   
For nX := 1 to Len(aCpoGDa)                                                                                                     
	If SX3->(DbSeek(aCpoGDa[nX]))                                                                                                 
		Aadd(aHeader,{ AllTrim(X3Titulo()),;                                                                                         
			SX3->X3_CAMPO	,;                                                                                                       
			SX3->X3_PICTURE,;                                                                                                       
			SX3->X3_TAMANHO,;                                                                                                       
			SX3->X3_DECIMAL,;                                                                                                       
			SX3->X3_VALID	,;                                                                                                       
			SX3->X3_USADO	,;                                                                                                       
			SX3->X3_TIPO	,;                                                                                                       
			SX3->X3_F3 		,;                                                                                                       
			SX3->X3_CONTEXT,;                                                                                                       
			SX3->X3_CBOX	,;                                                                                                       
			SX3->X3_RELACAO})                                                                                                       
	Endif                                                                                                                         
Next nX             

aAdd(aHeader,{	'RECNO'		,;
	           	'RECNO'		,;
	           	''	   		,;
	           	10	 		,;
	           	0			,;
	           	""			,;
	           	""			,;
	           	'N'			,;
	           	""			,;
	           	"" } )
	                                                                                                              
//Trazer no browse a informacao do mes anterior

If c_Mes == '01'
	c_MesAnt := '12'
	c_AnoAnt := strzero( val( c_Ano )-1 , 4) 
Else     
	c_MesAnt := strzero( val( c_Mes )-1 , 2) 
	c_AnoAnt := c_Ano
EndIf                        
/*
cQuery6 := " SELECT * "   															+ CRLF                                
cQuery6 += " FROM " + RETSQLNAME("PAQ") + " "                                    	+ CRLF
cQuery6 += " WHERE  PAQ_FILIAL = '" + xFilial("PAQ") + "' " 	                 	+ CRLF
cQuery6 += "       AND PAQ_ANO || PAQ_MES <= '" + c_AnoAnt + c_MesAnt + "'"        	+ CRLF
cQuery6 += "       AND PAQ_CODRDA = '" + cCodRDA + "'" 			  					+ CRLF
cQuery6 += "       AND PAQ_TIPORT = '1'"			 			  					+ CRLF
cQuery6 += "       AND D_E_L_E_T_ = ' ' "                                    		+ CRLF
cQuery6 += "ORDER BY PAQ_ANO || PAQ_MES DESC,R_E_C_N_O_ DESC"                 		+ CRLF

If Select(_6cAliasQry) <> 0 
	(_6cAliasQry)->(DbCloseArea()) 
Endif

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery6),_6cAliasQry,.T.,.T.)

While !( _6cAliasQry )->( EOF() )
    
		aAux := {}                                                                                                                         
	    aadd(aAux, ( _6cAliasQry )->PAQ_CODRDA )
	    aadd(aAux, ( _6cAliasQry )->PAQ_NOMRDA )
	    aadd(aAux, 0  ) 
	    aadd(aAux, ( _6cAliasQry )->R_E_C_N_O_ ) 
	    Aadd(aAux, .F.)
	    
	( _6cAliasQry )->( dbSkip() )
	                                                                                           
	Aadd(aCols,aAux)   
	
	Exit 
	
EndDo 
*/
/*                                                                                  
FUNCOES PARA AUXILIO NO USO DA NEWGETDADOS                                          
PARA MAIORES DETALHES ESTUDE AS FUNCOES AO FIM DESTE FONTE                          
==========================================================                          
                                                                                    
// Retorna numero da coluna onde se encontra o Campo na NewGetDados                 
Ex: NwFieldPos(oGet1,"A1_COD")                                                      
                                                                                    
// Retorna Valor da Celula da NewGetDados                                           
// OBS: Se nLinha estiver vazia ele acatara o oGet1:nAt(Linha Atual) da NewGetDados 
Ex: NwFieldGet(oGet1,"A1_COD",nLinha)                                               
                                                                                    
// Alimenta novo Valor na Celula da NewGetDados                                     
// OBS: Se nLinha estiver vazia ele acatara o oGet1:nAt(Linha Atual) da NewGetDados 
Ex: NwFieldPut(oGet1,"A1_COD",nLinha,"Novo Valor")                                  
                                                                                    
// Verifica se a linha da NewGetDados esta Deletada.                                
// OBS: Se nLinha estiver vazia ele acatara o oGet1:nAt(Linha Atual) da NewGetDados 
Ex: NwDeleted (oGet1,nLinha)                                                        
*/                                                                                  
                                                                                    
//oGetDados1:= MsNewGetDados():New(nSuperior,nEsquerda,nInferior,nDireita,nOpc,cLinhaOk,cTudoOk,cIniCpos,;                               
//                             aAlter,nFreeze,nMax,cCampoOk,cSuperApagar,cApagaOk,oWnd,aHead,aCols)    

nMaxLinhas := 1

oGet:= MSGetDados():New(nSuperior,nEsquerda,nInferior,nDireita,3,,,"",,,,,nMaxLinhas)
oGet:Refresh()

                                                            
Return Nil                                                                                                                      

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³   C()   ³ Autores ³ Norbert/Ernani/Mansano ³ Data ³10/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao responsavel por manter o Layout independente da       ³±±
±±³           ³ resolucao horizontal do Monitor do Usuario.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C(nTam)
                                                         
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor     
	If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)  
		nTam *= 0.8                                                                
	ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600                
		nTam *= 1                                                                  
	Else	// Resolucao 1024x768 e acima                                           
		nTam *= 1.28                                                               
	EndIf                                                                         
                                                                                
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                                               
	//³Tratamento para tema "Flat"³                                               
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                                               
	If "MP8" $ oApp:cVersion                                                      
		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()                      
			nTam *= 0.90                                                            
		EndIf                                                                      
	EndIf                                                                         
Return Int(nTam)                                                                

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ NwFieldPos ³ Autor ³ Ricardo Mansano       ³ Data ³06/09/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Retorna numero da coluna onde se encontra o Campo na         ³±±
±±³           ³ NewGetDados                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ oObjeto := Objeto da NewGetDados                             ³±±
±±³           ³ cCampo  := Nome do Campo a ser localizado                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ Numero da coluna localizada pelo aScan                       ³±±
±±³           ³ OBS: Se retornar Zero significa que nao localizou o Registro ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function NwFieldPos(oObjeto,cCampo)                                      
Local nCol := aScan(oObjeto:aHeader,{|x| AllTrim(x[2]) == Upper(cCampo)})       
Return(nCol)                                                                    
                                                                                
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ NwFieldGet ³ Autor ³ Ricardo Mansano       ³ Data ³06/09/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Retorna Valor da Celula da NewGetDados                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ oObjeto := Objeto da NewGetDados                             ³±±
±±³           ³ cCampo  := Nome do Campo a ser localizado                    ³±±
±±³           ³ nLinha  := Linha da GetDados, caso o parametro nao seja      ³±±
±±³           ³            preenchido o Default sera o nAt da NewGetDados    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ xRet := O Valor da Celula independente de seu TYPE           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function NwFieldGet(oObjeto,cCampo,nLinha)                               
Local nCol := aScan(oObjeto:aHeader,{|x| AllTrim(x[2]) == Upper(cCampo)})       
Local xRet                                                                      
// Se nLinha nao for preenchida Retorna a Posicao de nAt do Objeto              
Default nLinha := oObjeto:nAt                                                   
	xRet := oObjeto:aCols[nLinha,nCol]                                            
Return(xRet)                                                                    
                                                                                
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ NwFieldPut ³ Autor ³ Ricardo Mansano       ³ Data ³06/09/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Alimenta novo Valor na Celula da NewGetDados                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ oObjeto := Objeto da NewGetDados                             ³±±
±±³           ³ cCampo  := Nome do Campo a ser localizado                    ³±±
±±³           ³ nLinha  := Linha da GetDados, caso o parametro nao seja      ³±±
±±³           ³            preenchido o Default sera o nAt da NewGetDados    ³±±
±±³           ³ xNewValue := Valor a ser inputado na Celula.                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function NwFieldPut(oObjeto,cCampo,nLinha,xNewValue)                     
Local nCol := aScan(oObjeto:aHeader,{|x| AllTrim(x[2]) == Upper(cCampo)})       
// Se nLinha nao for preenchida Retorna a Posicao de nAt do Objeto              
Default nLinha := oObjeto:nAt                                                   
	// Alimenta Celula com novo Valor se este foi preenchido                      
	If !Empty(xNewValue)                                                          
		oObjeto:aCols[nLinha,nCol] := xNewValue                                    
	Endif                                                                         
Return Nil                                                                      
                                                                                
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ NwDeleted  ³ Autor ³ Ricardo Mansano       ³ Data ³06/09/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Verifica se a linha da NewGetDados esta Deletada.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ oObjeto := Objeto da NewGetDados                             ³±±
±±³           ³ nLinha  := Linha da GetDados, caso o parametro nao seja      ³±±
±±³           ³            preenchido o Default sera o nAt da NewGetDados    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³ lRet := True = Linha Deletada / False = Nao Deletada         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function NwDeleted(oObjeto,nLinha)                                       
Local nCol := Len(oObjeto:aCols[1])                                             
Local lRet := .T.                                                               
// Se nLinha nao for preenchida Retorna a Posicao de nAt do Objeto              
Default nLinha := oObjeto:nAt                                                   
	// Alimenta Celula com novo Valor                                             
	lRet := oObjeto:aCols[nLinha,nCol]                                            
Return(lRet)                                                                    

*****************************************************************************************************************************************************

User Function cPrev326(lRetTotal)

Local cRet 			:= ''

Default lRetTotal 	:= .F.  

/*
//BIANCHINI - 14/08/2014 - Quando eh HCJ (106593) sempre cai no SENAO do IF la da linha 66 e o procedimento eh atribuido errado 
If empty(cCodRDA) .and. (cCodProc =='10102019') 
	cCodRDA := aCols[1][1]   
	
	//BIANCHINI - 14/08/2014 - POR CAUSA DESSA CONDICAO A INTEGRAL SEMPRE BUSCAVA GUIAS COM O CODIGO 10102019. ENTAO CONVERSANDO COM 
	//			  O SALACIER DECIDIMOS MANTER A MESMA REGRA PARA INTEGRAL. O MESMO IRA DEFINIR COM DR GIORDANO SE FICARAO ESTES MESMOS
	//			  CODIGOS.
	//cCodProc  := If( ( cEmpAnt == '01' .and. cCodRDA == '106593' ),'80010342','10102019')//HCJ eh outro codigo, visita internista
	cCodProc  := If( cCodRDA == '106593','80010342','10102019' )//HCJ eh outro codigo, visita internista
Endif
*/

If !empty(aCols[1][1])
	If empty(cCodRDA)
		cCodRDA 	:= aCols[1][1]
		cCodProc 	:= GetCodPro(cCodRDA, cAnoPag + cMesPag)
	EndIf

	cRet := cQtdPrev(aCols[1][1])

	If cRet <> '-'
		cRet := cRet + CRLF + 'Valor:' + CRLF + 'R$ ' + AllTrim(Transform(Val(cRet)*aCols[1][3] + ( nVlraju*If(nRadio == 1,1,-1) ),'@E 999,999,999.99'))
	EndIf

	If lRetTotal
		Return If( Val(cRet)*aCols[1][3] > 0,'R$ ' + AllTrim(Transform(Val(cRet)*aCols[1][3] + ( nVlraju*If(nRadio == 1,1,-1) ),'@E 999,999,999.99')),'-')
	EndIf
Else
	cRet := '-'
	If lRetTotal
		Return cRet
	EndIf

EndIf

cRet := 'Procedimentos:' + CRLF + cRet

Return cRet

*****************************************************************************************************************************************************

Static Function cQtdPrev(c_CodRDA) 

Local c_Ret := ''

Processa({||c_Ret := PcQtdPrev(c_CodRDA)},'Atualizando prévia...')

Return c_Ret

*****************************************************************************************************************************************************

Static Function PcQtdPrev(c_CodRDA)

Local aArea 	:= GetArea()
Local cQry		:= ''
Local cAlias	:= GetNextAlias()
Local cRet		:= '-'
Local n_I 		:= 0

ProcRegua(0)

For n_I := 1 to 5
	IncProc('Atualizando...')
Next

cQry := " SELECT /*+ INDEX(" + If(cEmpAnt == '01','BD6010 BD6010TMP','BD6020 BD6020TMP') + ") */ Count(*) AS TOTAL " 		+ CRLF
cQry += " FROM "+RetSQLName("BD6") 																   							+ CRLF
cQry += " WHERE BD6_FILIAL = '" + xFilial('BD6')+ "'" 										  								+ CRLF
cQry += " AND BD6_CODOPE = '" + PLSINTPAD() + "' " 												   							+ CRLF
cQry += " AND SUBSTR(BD6_NUMLOT,1,6) = '" + cAnoPeg + cMesPeg + "'" 														+ CRLF   
//cQry += " AND SUBSTR(BD6_NUMLOT,1,6) IN ('201602','202102','202103','202104') " 											+ CRLF   

cQry += " AND BD6_DATPRO BETWEEN '" + DtoS(dIniCalc) + "' AND '" +  DtoS(dFimCalc) + "'"			 						+ CRLF 
cQry += " AND D_E_L_E_T_ = ' ' " 																	 						+ CRLF
cQry += " AND BD6_CODPRO = '"+cCodProc+"'" 															 						+ CRLF
cQry += " AND BD6_CODRDA = '"+c_CodRDA+"'" 																					+ CRLF
cQry += " AND BD6_SITUAC = '1' "        															  						+ CRLF
cQry += " AND BD6_VLRPAG > 0 "        																 						+ CRLF
cQry += " AND BD6_MOTBPF <> '501'" 																	  						+ CRLF

TcQuery cQry New Alias cAlias

If !cAlias->(EOF()) .and. ( cAlias->TOTAL > 0 )
	cRet := cValToChar(cAlias->TOTAL) 
EndIf

cAlias->(DbCloseArea())

RestArea(aArea)

Return cRet

****************************************************************************************************************************************************

Static Function GetCodPro(c_CodRDA, c_Compet)

Local c_CodPro := ''

Do Case

	Case empty(cCodRDA)
		c_CodPro := '10102019' 		
		
	Case cCodRDA == '104841'//Chamado - ID: 28458 E DEPOIS 0029284
    	c_CodPro := '80010342'	
		
	Case c_Compet >= '201408'//Chamado - ID: 13370 e Chamado - ID: 13472
		c_CodPro := '10102019'  	
	
	Case cCodRDA == '106593'
		c_CodPro := '80010342' 
		
	Otherwise
		c_CodPro := '10102019'
		
EndCase

Return c_CodPro