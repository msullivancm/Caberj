#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EXCLPEG   ºAutor  ³Leonardo Portella	 º Data ³  07/10/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Exclusao de PEGs baseada nas querys enviadas pela Totvs em  º±±
±±º          ³chamado.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ExclPEG

Local cAutorizados 	:= GetMv('MV_XGETIN') + '|' + GetMv('MV_XGERIN')
Local nCount 		:= 0

Private cMesCompet 
Private cAnoCompet
Private cLocalDig
Private cCodOpe	
Private cDiaImp	
Private c_CodPeg	
Private c_RDA
Private nTot1		:= 0  
Private oProcess	:= nil
Private cAlias1		:= GetNextAlias()
Private cPerg		:= 'EXCLPEG'
Private nPEGsExcl	:= 0
Private nTipExcl 	:= 0

If !(RetCodUsr() $ cAutorizados)
   	MsgStop('Acesso permitido somente a T.I.!',SM0->M0_NOMECOM)
   	Return
EndIf

AjustaSX1()

Pergunte(cPerg,.F.)  

mv_par06 	:= '  '
nOpca 		:= 0
nTipExcl 	:= Aviso('Exclusao de PEGs','Informe o tipo de exclusao:',{'Individual','Lote','Cancelar'})

If nTipExcl == 1 

	aSays := {}
	aAdd(aSays, 'Este programa irá excluir as PEGs conforme os parâmetros definidos'   )
	aAdd(aSays, 'pelo usuário.')
	           
	aButtons := {}
	aAdd(aButtons, { 1,.T.,{|| nOpca:= 1, FechaBatch()}} )
	aAdd(aButtons, { 2,.T.,{|| FechaBatch() }} )
	aAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T.) }} )
	 
	FormBatch( OemToAnsi("Gera‡„o de Arquivo Texto"), aSays, aButtons,, 240, 450 )
	    
	If nOpca == 1 
	
		c_RDA		:= mv_par01
		c_CodPeg	:= mv_par02
		cLocalDig	:= mv_par03
		cAnoCompet	:= mv_par04
		cMesCompet 	:= StrZero(Val(mv_par05),2)
		cDiaImp		:= If(!empty(mv_par06),StrZero(Val(mv_par06),2),'  ')
		cCodOpe		:= PlsIntPad()                             
		
		cMsg := 'Confirma a exclusão da PEG abaixo?'  											  						+ CRLF + CRLF
		cMsg += ' - EMPRESA: ' + If(cEmpAnt == '01','CABERJ','INTEGRAL')												+ CRLF
		cMsg += ' - RDA: ' + c_RDA + ' (' + AllTrim(Posicione('BAU',1,xFilial('BAU') + c_RDA,'BAU_NOME')) + ' | ' + AllTrim(Posicione('BAU',1,xFilial('BAU') + c_RDA,'BAU_NFANTA')) +')'		+ CRLF
		cMsg += ' - PEG: ' + c_CodPeg 										 	 										+ CRLF
		cMsg += ' - LOCAL: ' + cLocalDig 	   										   									+ CRLF
		cMsg += ' - ANO: ' + cAnoCompet 																				+ CRLF
		cMsg += ' - MÊS: ' + cMesCompet	   																				+ CRLF
		cMsg += ' - DIA (OPCIONAL): ' + cDiaImp	  									 									+ CRLF
		
		If MsgYesNo(cMsg,SM0->M0_NOMECOM)
		            
			oProcess := MsNewProcess():New({||ProcExcPEGs()},"CABERJ","",.T.)
			oProcess:Activate()
			
			MsgInfo(allTrim(Transform(nPEGsExcl,'@E 999,999,999'))  + ' PEG excluída!')
			
		EndIf
	
	EndIf

ElseIf nTipExcl == 2
    
    cMsg := "Informe em cada linha: RDA, PEG, Local de Digitacao, Ano de Competencia e Mes de Competencia. Separe os codigos por ponto-e-virgula ( ; )" + CRLF + CRLF
	cMsg += 'CONTINUA?'
	
	If MsgYesNo(cMsg,SM0->M0_NOMECOM)
	             
		cPEGs := LogErros('','Exclui PEGs em lote. (Informe: RDA;PEG;LocalDig;AnoComp;MesComp p/ linha)',.F.,'M')
		
		If empty(cPEGs)
	    	MsgStop('',SM0->M0_NOMECOM)
		Else
		    
		    aBuffer := {}
		    aBuffer := Separa(cPEGs,CHR(13) + CHR(10))
		    aPEGs 	:= {}
		    
		    For nCount := 1 to len(aBuffer)
		    	aAdd(aPEGs,Separa(aBuffer[nCount],';'))
		    Next
		    
			For nCount := 1 to len(aPEGs)
			    
				If ValType(aPEGs) <> 'A' 
			   		MsgStop('Linha ' + cValToChar(nCount + ' : Erro nos parametros. Retorno do Separa(cLinha,";") nao eh array!'),SM0->M0_NOMECOM)
					Return
				ElseIf len(aPEGs[nCount]) <> 5    
					MsgStop('Linha ' + cValToChar(nCount + ' : Informada a quantidade errada de parametros!'),SM0->M0_NOMECOM)
					Return			
				EndIf 
				
			Next
			
			Processa({||ProcPEGs(aPEGs)},'Exclusao PEGs em lote')
		    
			MsgInfo(AllTrim(Transform(nPEGsExcl,'@E 999,999,999'))  + ' PEGs excluídas!')

		EndIf
		
		
    EndIf
    
EndIf
	   
Return

***************************************************************************************************************

Static Function ProcPEGs(aPEGs)

Local nCount 		:= 0

ProcRegua(len(aPEGs))

For nCount := 1 to len(aPEGs)
			
	IncProc('Processando ' + cValToChar(nCount) + ' de ' + cValToChar(len(aPEGs)))
	
	c_RDA		:= aPEGs[nCount][1]
	c_CodPeg	:= aPEGs[nCount][2]
	cLocalDig	:= aPEGs[nCount][3]
	cAnoCompet	:= aPEGs[nCount][4]
	cMesCompet 	:= aPEGs[nCount][5]
	cCodOpe		:= PlsIntPad()                             
	
	oProcess := MsNewProcess():New({||ProcExcPEGs(len(aPEGs),nCount)},"CABERJ","",.T.)
	oProcess:Activate()
	
Next

Return			
                
***************************************************************************************************************

Static Function ProcExcPEGs(nQtdPEGs,nContador)
           
Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
           
Local nCount 		:= 0

Default nQtdPEGs 	:= 0     
Default nContador 	:= 0     

oProcess:SetRegua1(0)
oProcess:SetRegua2(0)

For i := 1 to 5
	oProcess:IncRegua1("Coletando informações...") 
	oProcess:IncRegua2()
Next

cQuery1 := "SELECT DISTINCT BCI_CODPEG, BCI_CODRDA"			  						+ CRLF
cQuery1 += "FROM " + RetSqlName('BCI')				  								+ CRLF
cQuery1 += "WHERE D_E_L_E_T_ = ' '"					  								+ CRLF
cQuery1 += "  AND BCI_FILIAL = '" + xFilial('BCI') + "'"							+ CRLF 
cQuery1 += "  AND BCI_CODOPE = '" + cCodOpe + "'"		   							+ CRLF
cQuery1 += "  AND BCI_CODLDP = '" + cLocalDig + "'"									+ CRLF
cQuery1 += "  AND BCI_MES = '" + cMesCompet + "'"									+ CRLF
cQuery1 += "  AND BCI_ANO = '" + cAnoCompet + "'" 									+ CRLF
cQuery1 += "  AND BCI_CODPEG = '" + c_CodPeg + "'"	  	 							+ CRLF
cQuery1 += "  AND BCI_CODRDA = '" + c_RDA + "'"										+ CRLF
cQuery1 += "ORDER BY BCI_CODRDA,BCI_CODPEG"			   								+ CRLF
	
TcQuery cQuery1 New Alias cAlias1

If nQtdPEGs > 0
	nTot1 := nQtdPEGs
Else
	COUNT TO nTot1
EndIf

oProcess:SetRegua1(nTot1)

cTot1 := allTrim(Transform(nTot1,'@E 999,999,999')) 

nTot1 := If(nContador > 0,nContador,1)

cAlias1->(DbGoTop())

If !cAlias1->(EOF())
    
	For nCount := 1 to nTot1 
   		oProcess:IncRegua1("Processando: " + allTrim(Transform(nTot1,'@E 999,999,999')) + ' de ' + cTot1) 
 	Next
    
    aArea1 := cAlias1->(GetArea())
     
    DelPEG(cAlias1->BCI_CODRDA, cAlias1->BCI_CODPEG)
    
    cAlias1->(RestArea(aArea1))
    
	cAlias1->(DbSkip())
	
EndIf

cAlias1->(DbCloseArea())

Return

***************************************************************************************************************

Static Function DelPEG(cRDA, cPEG)
    
Local cAlias2 := GetNextAlias()
Local cQuery2 := ""
Local nTot2	  := 0
Local cTot2	  := ""
Local cAlias3 
Local cQuery3 := ""
Local nTot3	  := 0
Local cTot3	  := ""
Local cAlias4 
Local cQuery4 := ""
Local nTot4	  := 0
Local cTot4	  := ""
Local cAlias5 
Local cQuery5 := ""
Local nTot5	  := 0
Local cTot5	  := ""
Local cAlias6 
Local cQuery6 := ""
Local nTot6	  := 0
Local cTot6	  := ""
Local cAlias7 
Local cQuery7 := ""
Local nTot7	  := 0
Local cTot7	  := ""
Local cAlias8 
Local cQuery8 := ""
Local nTot8	  := 0
Local cTot8	  := ""
Local cAlias9 
Local cQuery9 := ""
Local nTot9	  := 0
Local cTot9	  := ""  
Local lExcluiu := .F.
          
aBloq := aBloqPag(cRDA, cPEG)

If empty(aBloq)

	Begin Transaction 
	
	cQuery2 := "SELECT DISTINCT R_E_C_N_O_ REC"											+ CRLF
	cQuery2 += "FROM " + RetSqlName('BE2')  											+ CRLF
	cQuery2 += "WHERE BE2_FILIAL = '" + xFilial('BE4') + "'"											+ CRLF 
    cQuery2 += "	AND BE2_OPEMOV = '" + PLSINTPAD() + "'"											+ CRLF
	cQuery2 += "    AND BE2_ANOAUT = '" + cAnoCompet + "'"							+ CRLF
	cQuery2 += "    AND BE2_MESAUT = '" + cMesCompet + "'"							+ CRLF
	cQuery2 += "  AND BE2_CODPEG  = '" + cPEG + "'"										+ CRLF
	cQuery2 += "  AND D_E_L_E_T_ = ' '"													+ CRLF
	cQuery2 += "  AND BE2_FILIAL||BE2_OPEMOV||BE2_ANOAUT||BE2_MESAUT||BE2_NUMAUT IN ("	+ CRLF
	cQuery2 += "     SELECT BEA_FILIAL||BEA_OPEMOV||BEA_ANOAUT||BEA_MESAUT||BEA_NUMAUT"	+ CRLF
	cQuery2 += "     FROM " + RetSqlName('BEA') 										+ CRLF
	cQuery2 += "     WHERE BEA_FILIAL = '" + xFilial('BEA') + "'"						+ CRLF
	cQuery2 += "       AND BEA_OPEMOV = '" + PLSINTPAD() + "'"							+ CRLF
    cQuery2 += "       AND BEA_ANOAUT = '" + cAnoCompet + "'"							+ CRLF
	cQuery2 += "       AND BEA_MESAUT = '" + cMesCompet + "'"							+ CRLF
	cQuery2 += "       AND BEA_CODRDA = '" + cRDA + "'"									+ CRLF
	cQuery3 += "       AND BEA_CODPEG  = '" + cPEG + "'"									+ CRLF 
	cQuery2 += "       AND D_E_L_E_T_ = ' ' "											+ CRLF
	cQuery2 += "       AND BEA_ARQIMP <> ' ' )"											+ CRLF
	                     
	TcQuery cQuery2 New Alias cAlias2
	
	COUNT TO nTot2           
	
	oProcess:SetRegua2(nTot2)
	
	cTot2 := allTrim(Transform(nTot2,'@E 999,999,999')) 
	
	nTot2 := 0
	
	cAlias2->(DbGoTop())
	
	While !cAlias2->(EOF())
	
		lExcluiu := .T.
		
		oProcess:IncRegua2('Processando: ' + allTrim(Transform(++nTot2,'@E 999,999,999')) + ' de ' + cTot2) 
		
		BE2->(DbGoTo(cAlias2->REC))
	    
	    BE2->(Reclock('BE2',.F.))
		BE2->(DbDelete())
		BE2->(MsUnlock())
		
		cAlias2->(DbSkip())
		
	EndDo
	
	cAlias2->(DbCloseArea())
	
	*'------------------------------------------------------------------------'*
	
	cAlias3 := GetNextAlias()
	
	cQuery3 := "SELECT DISTINCT R_E_C_N_O_ REC"												+ CRLF
	cQuery3 += "FROM " + RetSqlName('BEG')  								 				+ CRLF
	cQuery3 += "WHERE BEG_FILIAL||BEG_OPEMOV||BEG_ANOAUT||BEG_MESAUT||BEG_NUMAUT IN ("		+ CRLF
	cQuery3 += "     SELECT BEA_FILIAL||BEA_OPEMOV||BEA_ANOAUT||BEA_MESAUT||BEA_NUMAUT"	+ CRLF
	cQuery3 += "     FROM " + RetSqlName('BEA') 										+ CRLF
	cQuery3 += "     WHERE BEA_FILIAL = '" + xFilial('BEA') + "'"						+ CRLF
	cQuery3 += "       AND BEA_OPEMOV = '" + PLSINTPAD() + "'"							+ CRLF
	cQuery3 += "       AND BEA_ANOAUT = '" + cAnoCompet + "'"							+ CRLF
	cQuery3 += "       AND BEA_MESAUT = '" + cMesCompet + "'"							+ CRLF
	cQuery3 += "       AND BEA_CODRDA = '" + cRDA + "'"									+ CRLF
	cQuery3 += "         AND BEA_CODPEG  = '" + cPEG + "'"									+ CRLF 
	cQuery3 += "       AND D_E_L_E_T_ = ' ' "											+ CRLF
	cQuery3 += "       AND BEA_ARQIMP <> ' ' )"											+ CRLF
	cQuery3 += "  AND D_E_L_E_T_ = ' '"														+ CRLF  
	
	TcQuery cQuery3 New Alias cAlias3
	
	COUNT TO nTot3           
	
	oProcess:SetRegua2(nTot3)
	
	cTot3 := allTrim(Transform(nTot3,'@E 999,999,999')) 
	
	nTot3 := 0
	
	cAlias3->(DbGoTop())
	
	While !cAlias3->(EOF())
	
		lExcluiu := .T.
		
		oProcess:IncRegua2('Processando: ' + allTrim(Transform(++nTot3,'@E 999,999,999')) + ' de ' + cTot3) 
		
		BEG->(DbGoTo(cAlias3->REC))
	    
	    BEG->(Reclock('BEG',.F.))
		BEG->(DbDelete())
		BEG->(MsUnlock())
		
		cAlias3->(DbSkip())
		
	EndDo
	
	cAlias3->(DbCloseArea())
	
	*'------------------------------------------------------------------------'*
	
	cAlias4 := GetNextAlias()
	  
	cQuery4 := "SELECT DISTINCT R_E_C_N_O_ REC"				  							+ CRLF
	cQuery4 += "     FROM " + RetSqlName('BEA') 										+ CRLF
	cQuery4 += "     WHERE BEA_FILIAL = '" + xFilial('BEA') + "'"						+ CRLF
	cQuery4 += "       AND BEA_OPEMOV = '" + PLSINTPAD() + "'"							+ CRLF
	cQuery4 += "       AND BEA_ANOAUT = '" + cAnoCompet + "'"							+ CRLF
	cQuery4 += "       AND BEA_MESAUT = '" + cMesCompet + "'"							+ CRLF
	cQuery4 += "       AND BEA_CODRDA = '" + cRDA + "'"									+ CRLF
	cQuery4 += "       AND BEA_CODPEG  = '" + cPEG + "'"								+ CRLF 
	cQuery4 += "       AND D_E_L_E_T_ = ' ' "											+ CRLF
	cQuery4 += "       AND BEA_ARQIMP <> ' '"											+ CRLF

	TcQuery cQuery4 New Alias cAlias4
	
	COUNT TO nTot4           
	
	oProcess:SetRegua2(nTot4)
	
	cTot4 := allTrim(Transform(nTot4,'@E 999,999,999')) 
	
	nTot4 := 0
	
	cAlias4->(DbGoTop())
	
	While !cAlias4->(EOF())
	
		lExcluiu := .T.
		
		oProcess:IncRegua2('Processando: ' + allTrim(Transform(++nTot4,'@E 999,999,999')) + ' de ' + cTot4) 
		
		BEA->(DbGoTo(cAlias4->REC))
	    
		BEA->(Reclock('BEA',.F.))
		BEA->(DbDelete())
		BEA->(MsUnlock())
		
		cAlias4->(DbSkip())

	EndDo

	cAlias4->(DbCloseArea())

	*'------------------------------------------------------------------------'*

	cAlias5 := GetNextAlias()

	cQuery5 := "SELECT DISTINCT R_E_C_N_O_ REC"					+ CRLF
	cQuery5 += "FROM " + RetSqlName('BCI')  					+ CRLF
	cQuery5 += "WHERE BCI_FILIAL = '" + xFilial('BCI')+ "'"		+ CRLF
	cQuery5 += "  AND BCI_CODLDP = '" + cLocalDig + "'"			+ CRLF
	cQuery5 += "  AND BCI_CODRDA = '" + cRDA + "'"				+ CRLF
	cQuery5 += "  AND BCI_MES = '" + cMesCompet + "'"			+ CRLF
	cQuery5 += "  AND BCI_ANO = '" + cAnoCompet + "'" 			+ CRLF
	cQuery5 += "  AND BCI_CODPEG  = '" + cPEG + "'"				+ CRLF 
	cQuery5 += "  AND D_E_L_E_T_ = ' '"							+ CRLF

	TcQuery cQuery5 New Alias cAlias5

	COUNT TO nTot5           

	oProcess:SetRegua2(nTot5)

	cTot5 := allTrim(Transform(nTot5,'@E 999,999,999')) 

	nTot5 := 0

	cAlias5->(DbGoTop())

	While !cAlias5->(EOF())

		lExcluiu := .T.

		oProcess:IncRegua2('Processando: ' + allTrim(Transform(++nTot5,'@E 999,999,999')) + ' de ' + cTot5) 

		BCI->(DbGoTo(cAlias5->REC))
	    
		BCI->(Reclock('BCI',.F.))
		BCI->(DbDelete())
		BCI->(MsUnlock())
		
		cAlias5->(DbSkip())
		
	EndDo
	
	cAlias5->(DbCloseArea())
	
	*'------------------------------------------------------------------------'*
	
	cAlias6 := GetNextAlias()
	
	cQuery6 := "SELECT DISTINCT R_E_C_N_O_ REC"					+ CRLF
	cQuery6 += "FROM " + RetSqlName('BD5')  					+ CRLF
	cQuery6 += "WHERE BD5_FILIAL = '" + xFilial('BD5')+ "'"		+ CRLF
	cQuery6 += "  AND BD5_CODOPE = '" + cCodOpe + "'"			+ CRLF
	cQuery6 += "  AND BD5_CODLDP = '" + cLocalDig + "'"			+ CRLF
	cQuery6 += "  AND BD5_MESPAG = '" + cMesCompet + "'"		+ CRLF
	cQuery6 += "  AND BD5_ANOPAG = '" + cAnoCompet + "'"		+ CRLF
	cQuery6 += "  AND BD5_CODRDA = '" + cRDA + "'"				+ CRLF
	cQuery6 += "  AND BD5_CODPEG  = '" + cPEG + "'"				+ CRLF
	cQuery6 += "  AND D_E_L_E_T_ = ' '"							+ CRLF
	
	TcQuery cQuery6 New Alias cAlias6
	
	COUNT TO nTot6
	
	oProcess:SetRegua2(nTot6)
	
	cTot6 := allTrim(Transform(nTot6,'@E 999,999,999')) 
	
	nTot6 := 0
	
	cAlias6->(DbGoTop())
	
	While !cAlias6->(EOF())
	
		lExcluiu := .T.
		
		oProcess:IncRegua2('Processando: ' + allTrim(Transform(++nTot6,'@E 999,999,999')) + ' de ' + cTot6) 
		
		BD5->(DbGoTo(cAlias6->REC))
	    
	    BD5->(Reclock('BD5',.F.))
		BD5->(DbDelete())
		BD5->(MsUnlock())
		
		cAlias6->(DbSkip())
		
	EndDo
	
	cAlias6->(DbCloseArea())
	
	*'------------------------------------------------------------------------'*
	
	cAlias7 := GetNextAlias()
	
	cQuery7 := "SELECT DISTINCT R_E_C_N_O_ REC"					+ CRLF
	cQuery7 += "FROM " + RetSqlName('BD6')  					+ CRLF
	cQuery7 += "WHERE BD6_FILIAL = '" + xFilial('BD6')+ "'"		+ CRLF
	cQuery7 += "  AND BD6_CODOPE = '" + cCodOpe + "'"			+ CRLF
	cQuery7 += "  AND BD6_CODLDP = '" + cLocalDig + "'"			+ CRLF
	cQuery7 += "  AND BD6_MESPAG = '" + cMesCompet + "'"		+ CRLF
	cQuery7 += "  AND BD6_ANOPAG = '" + cAnoCompet + "'"		+ CRLF
	cQuery7 += "  AND BD6_CODRDA = '" + cRDA + "'"				+ CRLF
	cQuery7 += "  AND BD6_CODPEG  = '" + cPEG + "'"				+ CRLF
	cQuery7 += "  AND D_E_L_E_T_ = ' '"							+ CRLF
	
	TcQuery cQuery7 New Alias cAlias7
	
	COUNT TO nTot7
	
	oProcess:SetRegua2(nTot7)
	
	cTot7 := allTrim(Transform(nTot7,'@E 999,999,999')) 
	
	nTot7 := 0
	
	cAlias7->(DbGoTop())
	
	While !cAlias7->(EOF())
	
		lExcluiu := .T.
		
		oProcess:IncRegua2('Processando: ' + allTrim(Transform(++nTot7,'@E 999,999,999')) + ' de ' + cTot7) 
		
		BD6->(DbGoTo(cAlias7->REC))
	    
		BD6->(Reclock('BD6',.F.))
		BD6->(DbDelete())
		BD6->(MsUnlock())
		
		cAlias7->(DbSkip())
		
	EndDo
	
	cAlias7->(DbCloseArea())
	
	*'------------------------------------------------------------------------'*
	
	cAlias8 := GetNextAlias()
	
	cQuery8 := "SELECT DISTINCT R_E_C_N_O_ REC"					+ CRLF
	cQuery8 += "FROM " + RetSqlName('BD7')  					+ CRLF
	cQuery8 += "WHERE BD7_FILIAL = '" + xFilial('BD7')+ "'"		+ CRLF
	cQuery8 += "  AND BD7_CODOPE = '" + cCodOpe + "'"			+ CRLF
	cQuery8 += "  AND BD7_CODLDP = '" + cLocalDig + "'"			+ CRLF
	cQuery8 += "  AND BD7_MESPAG = '" + cMesCompet + "'"		+ CRLF
	cQuery8 += "  AND BD7_ANOPAG = '" + cAnoCompet + "'"		+ CRLF
	cQuery8 += "  AND BD7_CODRDA = '" + cRDA + "'"				+ CRLF
	cQuery8 += "  AND BD7_CODPEG  = '" + cPEG + "'"				+ CRLF
	cQuery8 += "  AND D_E_L_E_T_ = ' '"							+ CRLF
	
	TcQuery cQuery8 New Alias cAlias8
	
	COUNT TO nTot8
	
	oProcess:SetRegua2(nTot8) 
	
	cTot8 := allTrim(Transform(nTot8,'@E 999,999,999')) 
	
	nTot8 := 0
	
	cAlias8->(DbGoTop())
	
	While !cAlias8->(EOF())
	
		lExcluiu := .T.
		
		oProcess:IncRegua2('Processando: ' + allTrim(Transform(++nTot8,'@E 999,999,999')) + ' de ' + cTot8) 
		
		BD7->(DbGoTo(cAlias8->REC))
	    
		BD7->(Reclock('BD7',.F.))
		BD7->(DbDelete())
		BD7->(MsUnlock())
		
		cAlias8->(DbSkip())
		
	EndDo
	
	cAlias8->(DbCloseArea())
	
	*'------------------------------------------------------------------------'*
	
	cAlias9 := GetNextAlias()
	
	cQuery9 := "SELECT DISTINCT R_E_C_N_O_ REC"			   							+ CRLF
	cQuery9 += "FROM " + RetSqlName('BSA')  				  						+ CRLF
	cQuery9 += "WHERE D_E_L_E_T_ = ' '"	  											+ CRLF
	cQuery9 += "  AND BSA_FILIAL = '" + xFilial('BSA')+ "'"	  						+ CRLF
	cQuery9 += "  AND SubStr(BSA_NUMSEQ,1,6) = '" + cAnoCompet + cMesCompet + "'"	+ CRLF
	cQuery9 += "  AND SubStr(BSA_CONTEU,1,6) = '" + cRDA + "'"			  			+ CRLF
	
	If !empty(cDiaImp)
		cQuery9 += "  AND SubStr(BSA_NUMSEQ,7,2) = '" + cDiaImp + "'"				+ CRLF
	EndIf
	
	TcQuery cQuery9 New Alias cAlias9
	
	COUNT TO nTot9
	
	oProcess:SetRegua2(nTot9)
	
	cTot9 := allTrim(Transform(nTot9,'@E 999,999,999')) 
	
	nTot9 := 0
	
	cAlias9->(DbGoTop())
	
	While !cAlias9->(EOF())
	
		lExcluiu := .T.
		
		oProcess:IncRegua2('Processando: ' + allTrim(Transform(++nTot9,'@E 999,999,999')) + ' de ' + cTot9) 
		
		BSA->(DbGoTo(cAlias9->REC))
	    
		BSA->(Reclock('BSA',.F.))
		BSA->(DbDelete())
		BSA->(MsUnlock())
		
		cAlias9->(DbSkip())
		
	EndDo
	
	cAlias9->(DbCloseArea())
	
	*'------------------------------------------------------------------------'*
	
	BE2->(DbCommit())
	BEG->(DbCommit())
	BEA->(DbCommit())
	BCI->(DbCommit())
	BD5->(DbCommit())
	BD6->(DbCommit())
	BD7->(DbCommit())
	BSA->(DbCommit())      
	
	End Transaction
	    
	If lExcluiu
		++nPEGsExcl
	EndIf
	
Else
	Alert('PEG com bloqueio de pagamento de RDA!')
EndIf
	
Return 

*******************************************************************************************

Static Function aBloqPag(cRDA, cPEG)

Local cQryPgto 		:= ""
Local cAliasPgto	:= GetNextAlias()
Local aRet			:= {}

cQryPgto := "SELECT DISTINCT BD7_LOTBLO, BD7_CODRDA, BD7_CODPEG"	+ CRLF
cQryPgto += "FROM " + RetSqlName('BD7')								+ CRLF
cQryPgto += "WHERE D_E_L_E_T_ = ' '"								+ CRLF
cQryPgto += "  AND BD7_FILIAL = '" + xFilial('BD7') + "'"			+ CRLF
cQryPgto += "  AND BD7_LOTBLO <> ' '"								+ CRLF
cQryPgto += "  AND BD7_CODRDA = '" + cRDA + "'"						+ CRLF
cQryPgto += "  AND BD7_CODPEG  = '" + cPEG + "'"					+ CRLF
  
TcQuery cQryPgto New Alias cAliasPgto  

While !cAliasPgto->(EOF())
                          
	aAdd(aRet,{cAliasPgto->BD7_CODRDA,cAliasPgto->BD7_CODPEG,cAliasPgto->BD7_LOTBLO})
	
	cAliasPgto->(DbSkip())
	
EndDo                                                                 

cAliasPgto->(DbCloseArea())

Return aRet

************************************************************************************************************************************

Static Function AjustaSX1

Local aHelp 	:= {}
Local aArea		:= GetArea()  

aAdd(aHelp, "RDA")      
PutSX1(cPerg , "01" , "RDA" 	  			,"","","mv_ch1","C",TamSx3('BAU_CODIGO')[1]		,0,0,"G",""	,""		,"","","mv_par01",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "PEG")      
PutSX1(cPerg , "02" , "PEG"    				,"","","mv_ch2","C"	,TamSx3('BCI_CODPEG')[1]		,0,0,"G",""	,""		,"","","mv_par02",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "LOCAL DE DIGITACAO")      
PutSX1(cPerg , "03" , "Local Digitacao" 	,"","","mv_ch3","C",TamSx3('BD5_CODLDP')[1]		,0,0,"G",""	,""		,"","","mv_par03",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "ANO COMPETENCIA")      
PutSX1(cPerg , "04" , "ANO" 				,"","","mv_ch4","C",4	 							,0,0,"G",""	,""		,"","","mv_par04",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "MES")    
PutSX1(cPerg , "05" , "MES"  				,"","","mv_ch5","C",TamSx3('BD7_OPEUSR')[1]		,0,0,"G",""	,""		,"","","mv_par05",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "DIA (OPCIONAL)")      
PutSX1(cPerg , "06" , "DIA (OPCIONAL)" 		,"","","mv_ch6","C",2								,0,0,"G",""	,""		,"","","mv_par06",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea)                                                                           

Return   

