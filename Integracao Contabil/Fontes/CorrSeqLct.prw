#Include 'topconn.ch'
#Include 'protheus.ch'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄaD¿
//³Funcão de correção da numeração. Inconsistência gerada ³
//³no passado pelo programa UPLSCTB.                      ³
//³Roger Cangianeli - 06/01/08 - Ud.Novo Hamburgo         ³
//³                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄaDÙ

User Function CorrSeqLct()

Local aArea
Private aDocs

aArea	:= GetArea()
aDocs	:= {}

aAdd(aDocs, xFilial('CT2')+'20070601'+'008850'+'001'+'000009')
aAdd(aDocs, xFilial('CT2')+'20070601'+'008850'+'001'+'000010')
aAdd(aDocs, xFilial('CT2')+'20070615'+'008850'+'001'+'000009')
aAdd(aDocs, xFilial('CT2')+'20070625'+'008850'+'001'+'000005')
aAdd(aDocs, xFilial('CT2')+'20070626'+'008850'+'001'+'000008')

If Len(aDocs) > 0 .and. MsgYesNo('Esta rotina ajusta sequencia de lancamentos. Deseja continuar?')
	MsAguarde({|| fProc(aDocs) }, "Ajustando sequencia de lancamentos...", "", .T.)
	MsgAlert('Processo Finalizado')

Else
	MsgStop( 'Não há dados a processar')

EndIf

Return



// Funcao estática de renumeração de sequência dos documentos
Static Function fProc(aDocs)

Local nVez, nSeq, cFil, cDoc, cData, cLote, cSLote

dbSelectArea('CT2')
dbSetOrder(10)

For nVez := 1 to Len(aDocs)
	
	nSeq	:= 0
	cSeq	:= StrZero( 0, Len(CT2->CT2_LINHA) )
	cFil 	:= Subs(aDocs[nVez],01,02)
	cData	:= Subs(aDocs[nVez],03,08)
	dData	:= Stod(cData)
	cLote	:= Subs(aDocs[nVez],11,06)
	cSLote	:= Subs(aDocs[nVez],17,03)
	cDoc	:= Subs(aDocs[nVez],20,06)
	
	If dbSeek(cFil+cData+cLote+cSLote+cDoc, .F.)
		While !Eof() .and. CT2->CT2_FILIAL == cFil .and. CT2->CT2_DATA == dData .and.;
			CT2->(CT2_LOTE+CT2_SBLOTE+CT2_DOC) == cLote+cSLote+cDoc
			
			nSeq++
			MsProcTxt("Renumerando " + cDoc + '/' + StrZero(nSeq, 6)+"... ")
			ProcessMessages()

			cSeq	:= SomaIt(cSeq)
//			If StrZero(nSeq,3) <> CT2->CT2_LINHA
			If cSeq <> CT2->CT2_LINHA
				RecLock('CT2', .F.)
//				CT2->CT2_LINHA	:= StrZero(nSeq, 3)'
				CT2->CT2_LINHA	:= cSeq
				msUnlock()
			EndIf
			CT2->(dbSkip())
			
		EndDo
	EndIf
Next


Return

