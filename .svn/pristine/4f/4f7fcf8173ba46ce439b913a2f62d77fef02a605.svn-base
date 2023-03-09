#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ACOPRORE  ºAutor  ³Leonardo Portella   º Data ³  05/07/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de acompanhamento do protocolo de reembolso.         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ACOPRORE

Local cAlias := "PBC"
Local aCores := {}

Private cCadastro 	:= "Acompanhamento de Protocolo de Reembolso"
Private aRotina 	:= {}  

aAdd(aRotina,{"Pesquisar" 	,"AxPesqui"	,0,1})  
aAdd(aRotina,{"Visualizar" 	,"AxVisual"	,0,2})
aAdd(aRotina,{"Incluir" 	,"U_INCPBC"	,0,3})
aAdd(aRotina,{"Alterar" 	,"U_ALTPBC"	,0,4})
aAdd(aRotina,{"Excluir" 	,"AxDeleta"	,0,5})
aAdd(aRotina,{"Legenda" 	,"U_LegPBC" ,0,3})

aAdd(aCores,{"PBC->PBC_POSICI == '1'" ,"BR_VERDE" 		})
aAdd(aCores,{"PBC->PBC_POSICI == '2'" ,"BR_AMARELO" 	})

DbSelectArea(cAlias)
DbSetOrder(1)
DbGoTop()

mBrowse(6,1,22,75,cAlias,,,,,2,aCores)

Return 

*******************************************
                
User Function IncPBC

Local nOpca 	:=  AxInclui("PBC",PBC->(Recno()),3, , , ,'U_OKPBC()')

If ( nOpca == 1 ) 
	GrvPBC()
EndIf

Return

*******************************************
                
User Function AltPBC    

Local nOpca 	:=  AxAltera("PBC",PBC->(Recno()),4, , , , ,'U_OKPBC()')

If ( nOpca == 1 ) 
	GrvPBC()
EndIf

Return

*******************************************

Static Function GrvPBC
    
BEGIN TRANSACTION

//AxInclui ja incluiu um registro em branco que esta ponteirado ou AxAltera ja esta ponteirado
PBC->(Reclock('PBC',.F.))
	
PBC->PBC_FILIAL := xFilial('PBC')
PBC->PBC_SEQUEN	:= PBC_SEQUEN 
PBC->PBC_CODINT	:= PBC_CODINT
PBC->PBC_CODEMP	:= PBC_CODEMP
PBC->PBC_MATRIC	:= PBC_MATRIC
PBC->PBC_TIPREG	:= PBC_TIPREG
PBC->PBC_DIGITO	:= PBC_DIGITO
PBC->PBC_NOMUSR	:= PBC_NOMUSR
PBC->PBC_DTDIGI	:= PBC_DTDIGI
PBC->PBC_POSICI	:= PBC_POSICI
PBC->PBC_DTENVI	:= PBC_DTENVI
PBC->PBC_USUARI	:= PBC_USUARI

PBC->(MsUnlock())		

END TRANSACTION 

Return

*******************************************

User Function OkPBC

Local lRet		:= .T.
Local cSeqZero 	:= PadL(AllTrim(M->PBC_SEQUEN),TamSX3('PBC_SEQUEN')[1],'0') 
Local aArea 	:= GetArea()
Local nRecPBC	:= If(ALTERA,PBC->(Recno()),-1)
           
PBC->(DbSetOrder(1))

If PBC->(MsSeek(xFilial('PBC') + cSeqZero))
	While !PBC->(EOF()) .and. ( PBC->(PBC_FILIAL + PBC_SEQUEN) == xFilial('PBC') + cSeqZero )
		If ( M->PBC_POSICI == PBC->PBC_POSICI ) .and. ( nRecPBC <> PBC->(Recno()))
			lRet := .F.
			MsgStop('Ja existe este numero de Protocolo [ ' + cSeqZero + ' ] com esta posicao [ ' + X3Combo('PBC_POSICI',M->PBC_POSICI)+ ' ] !',If(cEmpAnt == '01','CABERJ','INTEGRAL'))
			exit
		EndIf
		
		PBC->(DbSkip())	
	EndDo
EndIf

RestArea(aArea)

Return lRet

******************************************

User Function LegPBC

BrwLegenda(cCadastro, "Legenda", {	{"BR_VERDE"		, X3Combo('PBC_POSICI','1')	},;
									{"BR_AMARELO"	, X3Combo('PBC_POSICI','2')	}})
Return 

*******************************************

User Function lAtuBrwPBC

Local lRet 		:= .T.
Local cSeqZero 	:= PadL(AllTrim(M->PBC_SEQUEN),TamSX3('PBC_SEQUEN')[1],'0') 
              
ZZQ->(DbSetOrder(1))
ZZQ->(DbGoTop())          

If ZZQ->(MsSeek(xFilial('ZZQ') + cSeqZero))
	M->PBC_CODINT := ZZQ->ZZQ_CODINT 
	M->PBC_CODEMP := ZZQ->ZZQ_CODEMP
	M->PBC_MATRIC := ZZQ->ZZQ_MATRIC
	M->PBC_TIPREG := ZZQ->ZZQ_TIPREG
	M->PBC_DIGITO := ZZQ->ZZQ_DIGITO
	M->PBC_NOMUSR := ZZQ->ZZQ_NOMUSR
	M->PBC_DTDIGI := ZZQ->ZZQ_DATDIG
	M->PBC_USUARI := UsrFullName(RetCodUsr())
	M->PBC_SEQUEN := cSeqZero
Else
 	MsgStop('Numero do protocolo nao encontrado!' + CRLF + 'Verifique se o numero digitado esta correto...',If(cEmpAnt == '01','CABERJ','INTEGRAL'))
 	
 	M->PBC_CODINT := Space(TamSx3('ZZQ_CODINT')[1])
	M->PBC_CODEMP := Space(TamSx3('ZZQ_CODEMP')[1])
	M->PBC_MATRIC := Space(TamSx3('ZZQ_MATRIC')[1])
	M->PBC_TIPREG := Space(TamSx3('ZZQ_TIPREG')[1])
	M->PBC_DIGITO := Space(TamSx3('ZZQ_DIGITO')[1])
	M->PBC_NOMUSR := Space(TamSx3('ZZQ_NOMUSR')[1])
	M->PBC_DTDIGI := Space(TamSx3('ZZQ_DATDIG')[1]) 
	
	GetDRefresh()
 
	lRet := .F.
EndIf

Return lRet