#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 19/09/13                  ³
//³Rotina para verificar duplicidades nas tabelas³
//³SX2, SX3 e SIX.                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CorrSX

Local cMsg 	:= ''
Local nOpca	:= 0

cMsg += 'ATENÇÃO:' 														+ CRLF
cMsg += 'Esta rotina altera o SX3, SX2 e SIX da empresa corrente!' 		+ CRLF
cMsg += '' 																+ CRLF
cMsg += '==>FAÇA BACKUP DESTAS TABELAS NA EMPRESA:<=='					+ CRLF
cMsg += '==>' + AllTrim(SM0->M0_NOMECOM) + '<=='						+ CRLF
cMsg += '' 																+ CRLF
cMsg += 'Continua???'													+ CRLF

If MsgYesNo(cMsg,AllTrim(SM0->M0_NOMECOM))

	nOpca := Aviso('ATENÇÃO','Corrigir quais tabelas?',{'SX3','SX2','SIX','Todas','Cancelar'})
	
	If nOpca == 1 .or. nOpca == 4
		CorrSX3()
	EndIf
	
	If nOpca == 2 .or. nOpca == 4
		CorrSX2()
	EndIf
	
	If nOpca == 3 .or. nOpca == 4
		CorrSIX()
	EndIf
	
EndIf

Return

***********************************************************************************************************************************************

Static Function CorrSX3

Local nQtd	:= 0

Private cTmpSX3		:= 'TMPSX3'
Private cTrabSX3	:= ''

DbSelectArea('SX3')

SX3->(DbGoTop())

COUNT TO nQtd

Processa({||PCorrSX3(nQtd)},'Processando SX3...')

Return

***********************************************************************************************************************************************

Static Function PCorrSX3(nQtd)

Local n_Cont 	:= 0
Local cTot		:= AllTrim(Transform(nQtd,'@E 999,999,999'))
Local lDupl		:= .F. 

CriaTmpSX3()

ProcRegua(nQtd)

SX3->(DbSetOrder(1))

SX3->(DbGoTop())

While !SX3->(EOF())

	IncProc('Processando SX3 [ ' + AllTrim(Transform(++n_Cont,'@E 999,999,999')) + ' ] de [ ' + cTot + ' ]')
    
    (cTmpSX3)->(DbGoTop())             
    
	If (cTmpSX3)->(DbSeek(SX3->X3_CAMPO))

		lDupl := .T.
		
		(cTmpSX3)->(Reclock(cTmpSX3,.F.))
	    
		(cTmpSX3)->(OBS)	:= 'DUPLICADO'
		
		(cTmpSX3)->(MsUnlock())
    Else
	    lDupl := .F.
	EndIf

    (cTmpSX3)->(Reclock(cTmpSX3,.T.))
    
	(cTmpSX3)->(NOME) 	:= SX3->X3_CAMPO
	(cTmpSX3)->(TIPO) 	:= SX3->X3_TIPO
	(cTmpSX3)->(REC)	:= SX3->(RECNO())
	
	If lDupl
		(cTmpSX3)->(OBS)	:= 'DUPLICADO'
	EndIf
	
	(cTmpSX3)->(MsUnlock())

	SX3->(DbSkip())
	/*
	//TESTE     
	If n_Cont > 100
		Exit	
	EndIf
    */
EndDo

If Select(cTmpSX3) > 0
	(cTmpSX3)->(DbCloseArea())
EndIf

If File('\System\' + cTrabSX3 + '.dtc')
	FRename('\System\' + cTrabSX3 + '.dtc','\System\A_CORRSX3_' + DtoS(dDataBase) + '.dtc')
	If File('\System\' + cTrabSX3 + '.dtc')
		FErase('\System\' + cTrabSX3 + '.dtc')
	EndIf
EndIf

If File('\System\' + cTrabSX3 + '.cdx')
	FErase('\System\' + cTrabSX3 + '.cdx')
EndIf

Return

***********************************************************************************************************************************************

Static Function CriaTmpSX3

Local a_Cpos 	:= {}
Local aStru		:= {}
Local cIndice 	:= "NOME"       

If Select(cTmpSX3) > 0
	(cTmpSX3)->(DbCloseArea())
EndIf

aAdd(aStru,{ "NOME"	,"C",10	, 0})
aAdd(aStru,{ "TIPO"	,"C",1	, 0})
aAdd(aStru,{ "REC"	,"N",10	, 0})
aAdd(aStru,{ "OBS"	,"C",20	, 0})

cTrabSX3 := CriaTrab(aStru, .T.)

USE &cTrabSX3 ALIAS &cTmpSX3 NEW

INDEX ON &cIndice To &cTrabSX3

Return

***********************************************************************************************************************************************

Static Function CorrSX2

Return

***********************************************************************************************************************************************

Static Function CorrSIX

Return

***********************************************************************************************************************************************