#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "PLSMCCR.CH"
#define __aCdCri049 {"020","O valor contratado e diferente do valor informado/apresentado."}
#define __aCdCri116 {"550","Nao foi possivel localizar o nivel de cobranca."}

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³   ³ Autor ³ 				  ³ Data ³ 01.06.2008 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ 						                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABGLOSA
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o cabecalho da tela de atualizacoes                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cMotivo
Private cStatus
Private cParecer
Private nValRec
Private cUsuGuia 
Private cEOL := chr(13)+chr(10)    
	
PRIVATE aRotina   := { 	{ "Pesquisar"        , 'AxPesqui' , 0 , K_Pesquisar  	, 0 , .f. },;
{ "Visualizar"       , 'U_PL003MOV' , 0 , K_Visualizar 	, 0 , nil},;
{ "Incluir"          , 'U_PL003MOV' , 0 , K_Incluir    	, 0 , nil},;
{ "Alterar"          , 'U_PL003MOV' , 0 , K_Alterar    	, 0 , nil},;
{ "Excluir"          , 'U_PL003MOV' , 0 , K_Excluir    	, 0 , nil},;
{ "Selecionar"		 , 'U_PL003SEL' , 0 , K_Alterar 	, 0 , nil},;
{ "Finalizar"        , 'U_PL003FIN' , 0 , K_Alterar 	, 0 , nil},;
{ "Créditos" 		 ,  'U_P003LAR'  , 0 , K_Alterar 	, 0 , nil},;
{ "Legenda"    	     , 'U_PL003LEG' , 0 , K_Incluir, 0 , nil}}

PRIVATE aCorXA1 := 	{ 	{ "XA1->XA1_STATUS='2'", 'BR_VERDE'    },;
{ "XA1->XA1_STATUS='1'", 'BR_VERMELHO' }}

PRIVATE aCdCoXA1 := { 	{ 'BR_VERMELHO' ,'Recurso encerrado' },;
{ 'BR_VERDE'    ,'Recurso em aberto' }}

PRIVATE cFilter	  := ""
PRIVATE cCadastro := "Manutenção de Recurso"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Endereca a funcao de BROWSE                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1()
u_P003HLP()
BCI->(DbGoTop())
XA1->(DbSetOrder(1))
XA1->(mBrowse(006,001,022,075,"XA1",nil,nil,nil,nil,nil,aCorXA1))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina Principal                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ P003LAR    ³ Autor ³ Daher               ³ Data ³ 07.06.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Lancamentos Déb/Credito RDA                                ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function P003LAR(cAlias,nRec,nOpc)
LOCAL cFiltro    := ""
PRIVATE bDelLine
PRIVATE bEdit


cFiltro := "@BGQ_FILIAL = '"+xFilial("BGQ")+"' AND "
cFiltro += "BGQ_YRECGL = '"+XA1->XA1_OPECRE+XA1->XA1_CODQUE+"' AND D_E_L_E_T_ = ' '"
DbSelectArea("BGQ")
BGQ->(DbSetOrder(9))
SET FILTER TO &cFiltro

bDelLine := { || lOK := IF(Empty(BGQ->BGQ_NUMLOT) .And. Empty(BGQ->BGQ_NMSQLA),.T.,(Help("",1,"PLSA755FAT"),.F.)), IF(lOK,  IF(BGQ->BGQ_LANAUT#" ,0",.T.,Help("",1,"PLSA755LAU")),lOK) .And. Pls755DlBm1() }

bEdit    := { || lOK := IF(Empty(BGQ->BGQ_NUMLOT) .And. Empty(BGQ->BGQ_NMSQLA),.T.,(Help("",1,"PLSA755FAT"),.F.)), IF(lOK,  IF(BGQ->BGQ_LANAUT#" ,0",.T.,Help("",1,"PLSA755LAU")),lOK) }

AxCadastro("BGQ","Creditos Redes de Atendimento","PLSA755DEL()","PLSA755Chk(4)")

DbSelectArea("BGQ")
SET FILTER TO

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ P003DVI    ³ Autor ³ Daher               ³ Data ³ 07.06.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ desVincular a uma guia                                     ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003DVI(cAlias,nRec,nOpc)

If XA1->XA1_STATUS == '1'
	Help("",1,"PLSA003031")
	Return
Endif

If  Empty(XA2->XA2_CODOPE) .and. Empty(XA2->XA2_CODLDP) .and. Empty(XA2->XA2_CODPEG) .and. Empty(XA2->XA2_NUMERO) .and.;
	Empty(XA2->XA2_ORIMOV) .and. Empty(XA2->XA2_SEQUEN) .and. Empty(XA2->XA2_NUMIMP)
	
	Help("",1,"PLSA003032")
	Return
Endif

XA2->(Reclock("XA2",.F.))
XA2->XA2_CODOPE := ""
XA2->XA2_CODLDP := ""
XA2->XA2_CODPEG := ""
XA2->XA2_NUMERO := ""
XA2->XA2_ORIMOV := ""
XA2->XA2_SEQUEN := ""
XA2->XA2_NUMIMP := ""
XA2->(MsUnlock())

MsgStop("Guia desvinculada com sucesso!")
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PL003VIN   ³ Autor ³ Daher               ³ Data ³ 07.06.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Vincular a uma guia                                        ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003VIN(cAlias,nRec,nOpc)

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL cPerg     := "FEF003"
LOCAL cCodOpe   := ""
LOCAL cCodLDP   := ""
LOCAL cCodPeg   := ""
LOCAL cNumero   := ""
LOCAL cNumImp   := ""
LOCAL cChaveGui := ""
LOCAL aRet 		:= 0
LOCAL lFound    := .F.
LOCAL lPerg	    := .T.
LOCAL aDados 	:= {}

If XA1->XA1_STATUS == '1'
	Help("",1,"PLSA003030")
	Return
Endif

do while lPerg
	lPerg := Pergunte(cPerg,.T.)
	
	If !lPerg
		Return
	Endif
	
	cCodOpe := mv_par01
	cCodLDP := mv_par02
	cCodPeg := mv_par03
	cNumero := mv_par04
	cNumImp := mv_par05
	
	BD5->(DbSetOrder(1))
	If !lFound .and. BD5->(MsSeek(xFilial("BD5")+cCodOpe+cCodLDP+cCodPeg+cNumero))
		BD6->(DbSetOrder(1))
		BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)))
		cChaveGui := xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)
		If BD6->BD6_CODOPE == XA1->XA1_OPECRE .and. BD6->BD6_CODRDA == XA1->XA1_CODRDA
			lFound    := .T.
		EndIf
	Endif
	BD5->(DbSetOrder(6))
	If !lFound .and. !Empty(cNumImp) .and. BD5->(MsSeek(xFilial("BD5")+cNumImp))
		BD6->(DbSetOrder(1))
		BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)))
		cChaveGui := xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)
		If BD6->BD6_CODOPE == XA1->XA1_OPECRE .and. BD6->BD6_CODRDA == XA1->XA1_CODRDA
			lFound  := .T.
		EndIf
	Endif
	BE4->(DbSetOrder(1))
	If !lFound .and. BE4->(MsSeek(xFilial("BE4")+cCodOpe+cCodLDP+cCodPeg+cNumero))                 

		BD6->(DbSetOrder(1))
		BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)))
		cChaveGui := xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)
		If BD6->BD6_CODOPE == XA1->XA1_OPECRE .and. BD6->BD6_CODRDA == XA1->XA1_CODRDA
			lFound  := .T.
		EndIf
	Endif
	BE4->(DbSetOrder(6))
	If !lFound .and. !Empty(cNumImp) .and. BE4->(MsSeek(xFilial("BE4")+cNumImp))
		BD6->(DbSetOrder(1))
		BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)))
		cChaveGui := xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)
		If BD6->BD6_CODOPE == XA1->XA1_OPECRE .and. BD6->BD6_CODRDA == XA1->XA1_CODRDA
			lFound  := .T.
		EndIf
	Endif
	
	If !lFound
		Help("",1,"PLSA003029")
	Else
		
		aDados := {}
		While !BD6->(Eof()) .and. cChaveGui == BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)
			If VldGui(XA1->XA1_CODQUE,BD6->BD6_SEQUEN) .and. BD6->BD6_VLRGLO > 0
				aadd(aDados,{BD6->BD6_SEQUEN,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_DESPRO,BD6->BD6_VLRPAG,BD6->BD6_VLRTPF,BD6->BD6_DATPRO,BD6->(Recno())})
			EndIf
			BD6->(DbSkip())
		Enddo
		
		If IsInCallStack("u_PL003MO2")
			If len(aDados)>0
				aRet := TelaItem(aDados,{ {"Seq.","@C",20},;
				{"Tp.Tb.","@C",20},;
				{"Cód. Proc.","@C",40},;
				{"Descrição","@C",100},;
				{"Valor Pgto","@E 999,999,999.99",40},;
				{"Valor Cob.","@E 999,999,999.99",40},;
				{"Data Proc.","@D",60} }, "Selecione o procedimento a ser vinculado",NIL,NIL,NIL,NIL, NIL,NIL,"G",220)
			Else
				MsgInfo("Não existem dados a exibir!")
				aRet := {}
			EndIf
			
			If ValType(aRet)=="A" .and. Len(aRet)>0
				If aRet[1]
					BD6->(DbGoTo(aDados[aRet[2]][8]))
					
					If u_VldItGlosa(BD6->BD6_CODOPE,BD6->BD6_CODLDP,BD6->BD6_CODPEG,BD6->BD6_NUMERO,BD6->BD6_SEQUEN,XA1->XA1_CODRDA)
						
						M->XA2_CODPAD := BD6->BD6_CODPAD
						M->XA2_CODPRO := BD6->BD6_CODPRO
						M->XA2_DESPRO := BD6->BD6_DESPRO
						M->XA2_QTDPRO := BD6->BD6_QTDPRO
						M->XA2_VLRCOB := BD6->BD6_VLRGLO
						nSldGlosa := U_SldGlosa(BD6->BD6_CODOPE,BD6->BD6_CODLDP,BD6->BD6_CODPEG,BD6->BD6_NUMERO,BD6->BD6_SEQUEN,XA1->XA1_CODRDA)
						M->XA2_VLRREC := IIF(nSldGlosa==-1,BD6->BD6_VLRGLO,nSldGlosa)
						M->XA2_CODOPE := BD6->BD6_CODOPE
						M->XA2_CODLDP := BD6->BD6_CODLDP
						M->XA2_CODPEG := BD6->BD6_CODPEG
						M->XA2_NUMERO := BD6->BD6_NUMERO
						M->XA2_ORIMOV := BD6->BD6_ORIMOV
						M->XA2_SEQUEN := BD6->BD6_SEQUEN
						M->XA2_NUMIMP := BD6->BD6_NUMIMP
						M->XA2_SALDO  := 0
						
					Endif
				EndIf
			EndIf
		Else
			If Len(aDados)>0
				aRet := TelaGuia(aDados, "Selecione o procedimento a ser vinculado")
			Else 
				MsgInfo("Não existem dados a exibir!")
				aRet := {}
			EndIf
			
			If len(aRet)>0
			   	For x:=1 to Len(aRet)
			   		If aRet[x][1]
			   		
			   			BD6->(DbGoTo(aRet[x][9]))
			   			If u_VldItGlosa(BD6->BD6_CODOPE,BD6->BD6_CODLDP,BD6->BD6_CODPEG,BD6->BD6_NUMERO,BD6->BD6_SEQUEN,XA1->XA1_CODRDA)
						   
							RecLock("XA2",.T.)
							XA2->XA2_CODPAD := BD6->BD6_CODPAD
							XA2->XA2_CODPRO := BD6->BD6_CODPRO
							XA2->XA2_DESPRO := BD6->BD6_DESPRO
							XA2->XA2_QTDPRO := BD6->BD6_QTDPRO
							XA2->XA2_VLRCOB := BD6->BD6_VLRGLO
							XA2->XA2_CODOPE := BD6->BD6_CODOPE
							XA2->XA2_CODLDP := BD6->BD6_CODLDP
							XA2->XA2_CODPEG := BD6->BD6_CODPEG
							XA2->XA2_NUMERO := BD6->BD6_NUMERO
							XA2->XA2_ORIMOV := BD6->BD6_ORIMOV
							XA2->XA2_SEQUEN := BD6->BD6_SEQUEN
							XA2->XA2_NUMIMP := BD6->BD6_NUMIMP
							XA2->XA2_DESQUE := cMotivo
							XA2->XA2_STATUS := cStatus 
							XA2->XA2_DESNEG := cParecer
							XA2->XA2_VLRREC := nValRec  
							XA2->XA2_SEQQUE := u_BusPrXA2(XA1->XA1_CODQUE,XA1->XA1_OPECRE)
							XA2->XA2_OPECRE := XA1->XA1_OPECRE
							XA2->XA2_CODQUE := XA1->XA1_CODQUE   
							XA2->XA2_DATACO := dDataBase  
							nSldGlosa := U_SldGlosa(BD6->BD6_CODOPE,BD6->BD6_CODLDP,BD6->BD6_CODPEG,BD6->BD6_NUMERO,BD6->BD6_SEQUEN,XA1->XA1_CODRDA)
							XA2->XA2_SALDO  := IIF(nSldGlosa==-1,BD6->BD6_VLRGLO-nValRec,nSldGlosa-nValRec)
							XA2->(MsUnlock())
						
						Endif
			        EndIf
				Next
			EndIf
		EndIf	
		
	
		lPerg := .F.
	Endif
enddo

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PL003FIN   ³ Autor ³ Daher               ³ Data ³ 07.06.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Re-Contestação                                             ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003FIN()
LOCAL cSQL 		:= ""
LOCAL aRetAux   := {}
LOCAL cCodLanc  := GetNewPar("MV_ESLANCR",'004')

XA2->(DbSetOrder(3))
If XA2->(MsSeek(xFilial("XA2")+XA1->XA1_OPECRE+XA1->XA1_CODQUE+"00"))
	Help("",1,"PLSA003010")
	return
Endif

XA2->(DbSetOrder(1))
If !XA2->(MsSeek(xFilial("XA2")+XA1->XA1_OPECRE+XA1->XA1_CODQUE))
	Help("",1,"PLSA003015")
	return
Endif

If XA1->XA1_STATUS == '1'
	Help("",1,"PLSA003013")
	Return
Endif

cSQL := " SELECT COUNT(*) TOTAL FROM "+RetSQLName("XA2")
cSQL += " WHERE "
cSQL += " XA2_FILIAL = '"+xFilial("XA2")+"' AND "
cSQL += " XA2_OPECRE = '"+XA1->XA1_OPECRE+"' AND "
cSQL += " XA2_CODQUE = '"+XA1->XA1_CODQUE+"' AND "
cSQL += " (XA2_CODOPE = ' ' OR XA2_CODLDP = ' ' OR XA2_CODPEG = ' ' OR "
cSQL += " XA2_NUMERO = ' ' OR XA2_ORIMOV = ' ' OR XA2_SEQUEN = ' ') AND "
cSQL += " D_E_L_E_T_ <> '*' "
PLSQuery(cSQL,"TrbXA2")

If TrbXA2->TOTAL > 0
	Help("",1,"PLSA003033")
	TrbXA2->(DbCloseArea())
	Return
Endif
TrbXA2->(DbCloseArea())

aRetAux := PLSXVLDCAL(dDataBase,PLSINTPAD(),.T.,"","")
If ! aRetAux[1]
	Help("",1,"PLSA500CAL")
	Return
Endif

BBB->(DbSetOrder(1))
If ! BBB->(msSeek(xFilial("BBB")+cCodLanc))
	Help("",1,"PLSA003041")
	Return
Endif

If !MsgYesNo("Deseja realmente finalizar o recurso selecionado?")
	Return
Endif

Begin transaction

U_GeraDebCre(cCodLanc)

XA1->(Reclock("XA1",.F.))
XA1->XA1_STATUS := '1'
XA1->(MsUnlock())

End transaction

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ GeraDebCre ³ Autor ³ Daher               ³ Data ³ 07.06.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Re-Contestação                                             ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function GeraDebCre(cCodLanc)
LOCAL nVlrCheio   := 0
LOCAL aLanpag     := {}
LOCAL aRetAux     := PLSXVLDCAL(dDataBase,PLSINTPAD(),.T.,"","")

BBB->(DbSetOrder(1))
If BBB->(MsSeek(xFilial("BBB")+cCodLanc))
	aadd(aLanPag,{	BBB->BBB_CODSER,;//[1]
	BBB->BBB_DESCRI,;//[2]
	BBB->BBB_VLRSER,;//[3]
	BBB->BBB_QTDCH ,;//[4]
	BBB->BBB_TIPSER,;//[5]
	BBB->BBB_TIPOCT,;//[6]
	BBB->BBB_INCIR ,;//[7]
	BBB->BBB_INCINS,;//[8]
	BBB->BBB_INCPIS,;//[9]
	BBB->BBB_INCCOF,;//[10]
	BBB->BBB_INCCSL,;//[11]
	BBB->BBB_VERBA ,;//[12]
	BBB->BBB_CODANT,;//[13]
	BBB->BBB_CONTA ,;//[14]
	BBB->BBB_HISTC ,;//[15]
	BBB->BBB_CONMFT,;//[16]
	BBB->BBB_DIRF,; //[17]
	BBB->BBB_TIPPE,;//[18]
	BBB->BBB_COPCRE})//[19]
Endif



XA2->(DbSetOrder(1))
If  XA2->(MsSeek(xFilial("XA2")+XA1->XA1_OPECRE+XA1->XA1_CODQUE))
	
	lFound := .F.
	BD5->(DbSetOrder(1))
	If !lFound .and. BD5->(MsSeek(xFilial("BD5")+XA2->XA2_CODOPE + XA2->XA2_CODLDP + XA2->XA2_CODPEG + XA2->XA2_NUMERO))
		cUsuGuia := BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG+BD5_DIGITO)
		lFound    := .T.
	Endif
	BE4->(DbSetOrder(1))
	If !lFound .and. BE4->(MsSeek(xFilial("BE4")+XA2->XA2_CODOPE + XA2->XA2_CODLDP + XA2->XA2_CODPEG + XA2->XA2_NUMERO))
		cUsuGuia := BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO)
		lFound  := .T.
	Endif
	
	While !XA2->(Eof()) .and.  xFilial("XA2")+XA1->(XA1_OPECRE+XA1_CODQUE) == XA2->(XA2_FILIAL+XA2_OPECRE+XA2_CODQUE)
		dbSelectArea("BD6")
		dbSetorder(1)
		If dbSeek(xFilial("BD6")+XA2->XA2_CODOPE + XA2->XA2_CODLDP + XA2->XA2_CODPEG + XA2->XA2_NUMERO)
			nVlrCheio := XA2->XA2_VLRREC
			
			If nVlrCheio > 0 .and. XA2->XA2_STATUS == '2'
				BGQ->(Reclock("BGQ",.T.))
				BGQ->BGQ_FILIAL := xFilial("BGQ")
				BGQ->BGQ_CODSEQ := BGQ->(GETSX8NUM("BGQ","BGQ_CODSEQ"));BGQ->(Confirmsx8())
				BGQ->BGQ_CODIGO := XA1->XA1_CODRDA
				BGQ->BGQ_NOME   := XA1->XA1_DESRDA
				BGQ->BGQ_ANO    := aRetAux[4]
				BGQ->BGQ_MES    := aRetAux[5]
				BGQ->BGQ_CODLAN := aLanPag[1][1]
				BGQ->BGQ_TIPO   := '2'
				BGQ->BGQ_LANAUT := '1'
				BGQ->BGQ_VALOR  := nVlrCheio
				BGQ->BGQ_TIPOCT := aLanPag[1][6]
				BGQ->BGQ_QTDCH  := aLanPag[1][4]
				BGQ->BGQ_INCIR  := aLanPag[1][7]
				BGQ->BGQ_INCINS := aLanPag[1][8]
				BGQ->BGQ_INCPIS := aLanPag[1][9]
				BGQ->BGQ_INCCOF := aLanPag[1][10]
				BGQ->BGQ_INCCSL := aLanPag[1][11]
				BGQ->BGQ_VERBA	:= aLanPag[1][12]
				BGQ->BGQ_CONMFT := aLanPag[1][16]
				BGQ->BGQ_COPCRE := aLanPag[1][19]
				BGQ->BGQ_TIPPE  := aLanPag[1][18]
				BGQ->BGQ_OBS    := "GERADO PELA ROTINA DE REC. GLOSA"
				BGQ->BGQ_CHVEST := ''
				BGQ->BGQ_YRECGL	:= XA1->XA1_OPECRE+XA1->XA1_CODQUE
				BGQ->(MsUnLock())
				
			Endif
		EndIf
		XA2->(DbSkip())
	Enddo
Endif

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PL003LEG   ³ Autor ³ Daher               ³ Data ³ 07.06.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Exibe a legenda...                                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003LEG()

BrwLegenda(cCadastro,"Status da contestação" ,aCdCoXA1)

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PL003SLE   ³ Autor ³ Daher               ³ Data ³ 07.06.08 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Exibe a legenda...                                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003SLE()

BrwLegenda(cCadastro,"Status do registro" ,aCdCoXA2)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PL003SEL³ Autor ³ Daher				  ³ Data ³ 01.06.2008 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ 						                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003SEL
LOCAL aPtoEntrada := {}
LOCAL cFiltro     := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o cabecalho da tela de atualizacoes                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aSubRot2  := { {  "Guia"    ,'u_PL003VIN'  , 0, K_Incluir }}
//,;{ "Desvincular Item" ,'u_PL003DVI'  , 0, K_Excluir }}

PRIVATE aRotina   := { 	{ "Pesquisar"        , 'AxPesqui' , 0 , K_Pesquisar  	},;
{ "Visualizar"       , 'u_PL003MO2' , 0 , K_Visualizar 	},;
{ "Incluir"          , 'u_PL003MO2' , 0 , K_Incluir    	},;
{ "Alterar"          , 'u_PL003MO2' , 0 , K_Alterar    	},;
{ "Excluir"          , 'u_PL003MO2' , 0 , K_Excluir    	},;
{ "Legenda"    	     , 'u_PL003SLE' , 0 , K_Incluir		},;
{ "Vincular"    	 ,  aSubRot2  , 0 , K_Incluir    	}}

PRIVATE aCorXA2 := 	{ 	{ "XA2->XA2_STATUS='1'", 'BR_AMARELO'    	},;
{ "XA2->XA2_STATUS='2'", 'BR_VERDE' 	},;
{ "XA2->XA2_STATUS='3'", 'BR_VERMELHO'    	}}

PRIVATE aCdCoXA2 := { 	{ 'BR_AMARELO'  ,'Em negociação'},;
{ 'BR_VERDE'    ,'Recurso Aceito'},;
{ 'BR_VERMELHO' ,'Recurso Negado'}}



cFiltro := "@XA2_FILIAL = '"+xFilial("XA2")+"' AND XA2_OPECRE = '"+XA1->XA1_OPECRE+"' AND XA2_CODQUE = '"+XA1->XA1_CODQUE+"' AND "
cFiltro += "D_E_L_E_T_ = ' '"
XA2->(DbSetFilter({||&cFiltro},cFiltro))

XA2->(DbSetOrder(1))
XA2->(DbGoTop())
XA2->(mBrowse(006,001,022,075,"XA2",nil,nil,nil,nil,nil,aCorXA2))
XA2->(DbClearFilter())
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PL003MO2 ³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Movimentacao 						                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003MO2(cAlias,nReg,nOpc)
LOCAL I__f      := 0
Local nOpca	    := 0
LOCAL aChave 	:= {}
LOCAL aButtons	:= {}
LOCAL bOK       := {|| nOpca := 1,If(U_P003Fin2(oEnchoice,nOpc,nReg),oDlg:End(),nOpca:=2),If(nOpca==1,oDlg:End(),.F.) }
LOCAL bCancel	:= {|| oDlg:End() }
LOCAL bBotao01  := {|| u_PL003VIG()}
LOCAL bBotao02  := {|| u_PL003VIN()}
LOCAL aSize 	:= MsAdvSize()
LOCAL aObjects  := {}
LOCAL aInfo 	:= {}
LOCAL aPosObj 	:= {}
LOCAL oDlg
LOCAL oEnchoice
LOCAL oFolder
LOCAL nRegXA1   := 0

If nOpc == K_Alterar
	If XA1->XA1_STATUS == '1'
		Help("",1,"PLSA003007")
		Return
	Endif
Endif

If nOpc == K_Excluir
	If XA1->XA1_STATUS == '1'
		Help("",1,"PLSA003008")
		Return
	Endif
Endif

If nOpc == K_Incluir
	If XA1->XA1_STATUS == '1'
		Help("",1,"PLSA003009")
		Return
	Endif
Endif

aadd(aButtons,{"RELATORIO",bBotao01,"Visualizar Guia Origem","Guia"})
//Rafael Fernandes I
aadd(aButtons,{"TK_VERTIT",bBotao02,"Buscar Guia","Busca Guia"})
// F

AAdd( aObjects, { 100, 200, .T., .T. } )

aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Dialogo...                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],0 To aSize[6],aSize[5] OF oMainWnd PIXEL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta dados do cabecalho...                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpc == K_Incluir
	Copy "XA2" TO Memory Blank
Else
	Copy "XA2" TO MEMORY
Endif

Zero()
oEnchoice := MsMGet():New(cAlias,nReg,nOpc,,,,,aPosObj[1],,,,,,oDlg,,,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa o Dialogo...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

ACTIVATE MSDIALOG oDlg ON INIT Eval({ || EnchoiceBar(oDlg,bOk,bCancel,.F.,aButtons)  })

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PL003VIG ³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Visualizar guia 						                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003VIG()

LOCAL cAliGui := If(M->XA2_ORIMOV == '2',"BE4","BD5")
LOCAL cCodOpe := M->XA2_CODOPE
LOCAL cCodLdp := M->XA2_CODLDP
LOCAL cCodPeg := M->XA2_CODPEG
LOCAL cNumero := M->XA2_NUMERO
LOCAL nRecGui := 0
LOCAL lOk 	  := .F.

If !Empty(cCodOpe) .and. !Empty(cCodLdp) .and. !Empty(cCodPeg) .and. !Empty(cNumero)
	
	BCI->(DbSetOrder(1))
	BCL->(DbSetOrder(1))
	&(cAliGui+"->(DbSetOrder(1))")
	
	If BCI->(MsSeek(xFilial("BCI")+cCodOpe+cCodLdp+cCodPeg))
		If BCL->(MsSeek(xFilial("BCL")+BCI->(BCI_CODOPE+BCI_TIPGUI)))
			If &(cAliGui+"->(MsSeek('"+xFilial(cAliGui)+cCodOpe+cCodLdp+cCodPeg+cNumero+"'))")
				lOk := .T.
				nRecGui := &(cAliGui+"->(Recno())")
				PLSA500MOV(cAliGui,nRecGui,K_Visualizar)
			Endif
		Endif
	Endif
	
Endif

If !lOk
	Help("",1,"PLSA003023")
Endif


Return lOk
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PL003MOV ³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Movimentacao 						                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003MOV(cAlias,nReg,nOpc)
LOCAL I__f      := 0
Local nOpca	    := 0
LOCAL aChave 	:= {}
LOCAL aButtons	:= {}
LOCAL bOK       := {|| nOpca := 1,If(u_P003Final(oEnchoice,nOpc,nReg),oDlg:End(),nOpca:=2),If(nOpca==1,oDlg:End(),.F.) }
LOCAL bCancel	:= {|| oDlg:End() }
LOCAL aSize 	:= MsAdvSize()
LOCAL aObjects  := {}
LOCAL aInfo 	:= {}
LOCAL aPosObj 	:= {}
LOCAL oDlg
LOCAL oEnchoice
LOCAL oFolder
LOCAL nRegXA1   := 0
LOCAL cTitCob	:= ""
LOCAL cTitPag	:= ""
PRIVATE lAlterar:= .F.
PRIVATE lIncluir:= .F.

If nOpc == K_Excluir
	If XA1->XA1_STATUS == '1'
		Help("",1,"PLSA003011")
		Return
	Endif
Endif

If nOpc == K_Incluir
	lAlterar := .F.
	lIncluir := .T.
Endif

If nOpc == K_Alterar
	lAlterar := .T.
	lIncluir := .F.
	If XA1->XA1_STATUS == '1'
		Help("",1,"PLSA003012")
		Return
	Endif
Endif


AAdd( aObjects, { 100, 200, .T., .T. } )

aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Dialogo...                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg TITLE cCadastro FROM aSize[7],0 To aSize[6],aSize[5] OF oMainWnd PIXEL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta dados do cabecalho...                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpc == K_Incluir
	Copy "XA1" TO Memory Blank
Else
	Copy "XA1" TO MEMORY
Endif

Zero()
oEnchoice := MsMGet():New(cAlias,nReg,nOpc,,,,,aPosObj[1],,,,,,oDlg,,,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa o Dialogo...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

ACTIVATE MSDIALOG oDlg ON INIT Eval({ || EnchoiceBar(oDlg,bOk,bCancel,.F.,aButtons)  })

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PL003VLT ³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Validacao campos				                      		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL003VLT()
LOCAL lRet := .T.



If ReadVar() == "M->XA1_OPEORI"
	If !Empty(M->XA1_OPEORI)
		BA0->(DbSetOrder(1))
		If BA0->(MsSeek(xFilial("BA0")+M->XA1_OPEORI))
			M->XA1_DESORI := BA0->BA0_NOMINT
		Else
			M->XA1_DESORI := ""
			Help("",1,"REGNOIS")
			lRet := .F.
		Endif
	Else
		M->XA1_DESORI := ""
	Endif
Endif

If ReadVar() == "M->XA1_OPEDES"
	If !Empty(M->XA1_OPEDES)
		BA0->(DbSetOrder(1))
		If BA0->(MsSeek(xFilial("BA0")+M->XA1_OPEDES))
			M->XA1_DESDES := BA0->BA0_NOMINT
		Else
			M->XA1_DESDES := ""
			Help("",1,"REGNOIS")
			lRet := .F.
		Endif
	Else
		M->XA1_DESDES := ""
	Endif
Endif

If ReadVar() == "M->XA1_OPECRE"
	If !Empty(M->XA1_OPECRE)
		BA0->(DbSetOrder(1))
		If BA0->(MsSeek(xFilial("BA0")+M->XA1_OPECRE))
			M->XA1_DESCRE := BA0->BA0_NOMINT
			M->XA1_OPEDES := M->XA1_OPECRE
			M->XA1_DESDES := BA0->BA0_NOMINT
		Else
			M->XA1_DESCRE := ""
			Help("",1,"REGNOIS")
			lRet := .F.
		Endif
	Else
		M->XA1_DESCRE := ""
	Endif
Endif


If ReadVar() == "M->XA2_SEQQUE"
	If !Empty(M->XA2_SEQQUE)
		M->XA2_SEQQUE := strzero(val(M->XA2_SEQQUE),len(XA2->XA2_SEQQUE))
	Endif
Endif


If ReadVar() == "M->XA1_CODRDA"
	If !Empty(M->XA1_CODRDA)
		BAU->(DbSetOrder(1))
		If !BAU->(MsSeek(xFilial("BAU")+M->XA1_CODRDA))
			Help("",1,"REGNOIS")
			lRet := .F.
		Else
			BAU->(DbSetOrder(1))
			M->XA1_DESRDA := Posicione("BAU",1,xFilial("BAU")+M->XA1_CODRDA,"BAU_NOME")
		Endif
	Else
		M->XA1_DESRDA := ""
	Endif
Endif

If ReadVar() == "M->XA2_CODPAD"
	If !Empty(M->XA2_CODPAD)
		BR4->(DbSetOrder(1))
		If !BR4->(MsSeek(xFilial("BR4")+M->XA2_CODPAD))
			Help("",1,"REGNOIS")
			lRet := .F.
		Endif
	Endif
Endif

If ReadVar() == "M->XA2_CODPRO"
	If !Empty(M->XA2_CODPRO)
		BR8->(DbSetOrder(1))
		If BR8->(MsSeek(xFilial("BR8")+M->XA2_CODPAD+M->XA2_CODPRO))
			M->XA2_DESPRO := BR8->BR8_DESCRI
		Else
			M->XA2_DESPRO := ""
			Help("",1,"REGNOIS")
			lRet := .F.
		Endif
	Else
		M->XA2_DESPRO := ""
	Endif
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ P003Final³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ 										                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function P003Final(oEnchoice,nOpcx,nReg)
LOCAL lRet    := .T.
LOCAL nH      := 0

If nOpcx == K_Alterar .or. nOpcx == K_Excluir
	XA1->(DbGoTo(nReg))
Endif

If nOpcx <> K_Excluir .and. !Obrigatorio(oEnchoice:aGets,oEnchoice:aTela)
	Return(.F.)
Endif

If nOpcx == K_Excluir
	BGQ->(DbOrderNickName('GLOSA'))
	If BGQ->(MsSeek(xFilial("BGQ")+XA1->(XA1_OPECRE+XA1_CODQUE)))
		While !BGQ->(Eof()) .and. xFilial("BGQ")+XA1->(XA1_OPECRE+XA1_CODQUE) == BGQ->(BGQ_FILIAL+BGQ_YRECGL)
			If !Empty(BGQ->(BGQ_NUMLOT))
				Help('',1,'PLSA003042')
				Return(.F.)
			Endif
			BGQ->(DbSkip())
		Enddo
	Endif
Endif

If  nOpcx <> K_Visualizar
	
	nH  := PLSAbreSem("P003FINAL.SMF")
	
	Begin Transaction
	
	If nOpcx == K_Incluir
		M->XA1_CODQUE   := u_BusPrXA1(M->XA1_OPECRE)
	Endif
	
	If nOpcx == K_Excluir
		
		XA2->(DbSetOrder(1))
		While XA2->(MsSeek(xFilial("XA2")+XA1->(XA1_OPECRE+XA1_CODQUE)))
			XA2->(Reclock("XA2",.F.))
			XA2->(DbDelete())
			XA2->(MsUnlock())
		Enddo
		
		BGQ->(DbOrderNickName('GLOSA'))
		While BGQ->(MsSeek(xFilial("BGQ")+XA1->(XA1_OPECRE+XA1_CODQUE)))
			BGQ->(Reclock("BGQ",.F.))
			BGQ->(DbDelete())
			BGQ->(MsUnlock())
		Enddo
	Endif
	
	PLUPTENC("XA1",nOpcx)
	
	End Transaction
	
	PLSFechaSem(nH,"P003FINAL.SMF")
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ P003Fin2 ³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ 										                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function P003Fin2(oEnchoice,nOpcx,nReg)
LOCAL lRet    := .T.
LOCAL nH   	  := 0
Local nSaldo := 0

If !Obrigatorio(oEnchoice:aGets,oEnchoice:aTela)
	Return(.F.)
Endif

If nOpcx == K_Alterar
	If XA2->XA2_STATUS == '3' .or. M->XA2_VLRREC > XA2->XA2_VLRREC
		nSaldo := U_SldGlosa(M->XA2_CODOPE,M->XA2_CODLDP,M->XA2_CODPEG,M->XA2_NUMERO,M->XA2_SEQUEN,XA1->XA1_CODRDA)
		nSaldo := IIF(nSaldo==-1,BD6->BD6_VLRGLO,nSaldo)
		If M->XA2_VLRREC > XA2->XA2_VLRREC+nSaldo
			MsgInfo("O saldo atual deste item é de R$"+alltrim(Transform( nSaldo ,PesqPict("XA2","XA2_VLRREC")))+" "+cEOL+"Este recurso não poderá ser efetivado!")
			Return .F.
		EndIf
	EndIf
EndIf

If nOpcx == K_Incluir
	nSaldo := U_SldGlosa(M->XA2_CODOPE,M->XA2_CODLDP,M->XA2_CODPEG,M->XA2_NUMERO,M->XA2_SEQUEN,XA1->XA1_CODRDA)
	nSaldo := IIF(nSaldo==-1,BD6->BD6_VLRGLO,nSaldo)
	If M->XA2_VLRREC > nSaldo
		MsgInfo("O saldo atual deste item é de R$"+alltrim(Transform( nSaldo ,PesqPict("XA2","XA2_VLRREC")))+" "+cEOL+"Este recurso não poderá ser efetivado!")
		Return .F.
	EndIf
	
	IF Empty(M->XA2_NUMERO)
		MsgInfo("É necessário que este recurso possua uma guia vinculada!")
		Return .F.
	EndIf
EndIf

If  nOpcx <> K_Visualizar
	
	nH  := PLSAbreSem("P003FINAL.SMF")
	
	Begin Transaction
	
	If nOpcx == K_Incluir
		M->XA2_SEQQUE   := u_BusPrXA2(XA1->XA1_CODQUE,XA1->XA1_OPECRE)
	Endif
	
	M->XA2_OPECRE   := XA1->XA1_OPECRE
	M->XA2_CODQUE   := XA1->XA1_CODQUE
	
	PLUPTENC("XA2",nOpcx)
	
	End Transaction
	
	PLSFechaSem(nH,"P003FINAL.SMF")
Endif

If ExistBlock("P003F2DE")
	ExecBlock("P003F2DE",.F.,.F.,{nOpcx})
Endif

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ P003HLP  ³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ 										                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function P003HLP()

PutHelp("PPLSA003001",{"Não foi possível consultar","posição título.",},{},{},.T.)
PutHelp("SPLSA003001",{"Informe o título a pagar.","",""},{},{},.T.)

PutHelp("PPLSA003002",{"Não foi possível consultar","posição título.",},{},{},.T.)
PutHelp("SPLSA003002",{"Informe o título a cobrar.","",""},{},{},.T.)

PutHelp("PPLSA003003",{"Não foi possível a confirmação",,},{},{},.T.)
PutHelp("SPLSA003003",{"Campo de complemento mandatório","quando o motivo for igual a ","98 (Outros)."},{},{},.T.)

PutHelp("PPLSA003004",{"Não será possível re-contestar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003004",{"o recurso selecionado já"  ,"encontra-se vinculada a outra","recurso."},{},{},.T.)

PutHelp("PPLSA003005",{"Não será possível re-contestar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003005",{"o recurso ainda não foi"  ,"finalizada"},{},{},.T.)

PutHelp("PPLSA003006",{"Não será possível excluir","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003006",{"o recurso selecionado já"  ,"encontra-se vinculada a outra","recurso."},{},{},.T.)

PutHelp("PPLSA003007",{"Não será possível alterar","o item selecionado.",},{},{},.T.)
PutHelp("SPLSA003007",{"o recurso selecionado já"  ,"encontra-se finalizado."},{},{},.T.)

PutHelp("PPLSA003008",{"Não será possível excluir","o item selecionado.",},{},{},.T.)
PutHelp("SPLSA003008",{"o recurso selecionado já"  ,"encontra-se finalizado."},{},{},.T.)

PutHelp("PPLSA003009",{"Não será possível incluir","um item .",},{},{},.T.)
PutHelp("SPLSA003009",{"o recurso selecionado já"  ,"encontra-se finalizado."},{},{},.T.)

PutHelp("PPLSA003010",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003010",{"Existem itens 'Em Negociação'"  ,"para esto recurso."},{},{},.T.)

PutHelp("PPLSA003011",{"Não será possível excluir","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003011",{"o recurso selecionado já"  ,"encontra-se finalizado."},{},{},.T.)

PutHelp("PPLSA003012",{"Não será possível alterar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003012",{"o recurso selecionado já"  ,"encontra-se finalizado."},{},{},.T.)

PutHelp("PPLSA003013",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003013",{"o recurso selecionado já"  ,"encontra-se finalizado."},{},{},.T.)

PutHelp("PPLSA003014",{"Não será possível efetuar","a inclusão.",},{},{},.T.)
PutHelp("SPLSA003014",{"Já existe recurso na"  ,"base de dados com o","sequencial informado."},{},{},.T.)

PutHelp("PPLSA003015",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003015",{"Não existem itens cadastrados"  ,"para esto recurso."},{},{},.T.)

PutHelp("PPLSA003016",{"Não será possível a exclusão","do lote selecionado.",},{},{},.T.)
PutHelp("SPLSA003016",{"Já existem re-contestações ","criadas para o lote informado."},{},{},.T.)

PutHelp("PPLSA003017",{"Não será possível a exclusão","do recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003017",{"A exclusão deverá ser efetuada pela ","rotina de pagamento médico, visto que o","titulo a cobrar vinculado à recurso","foi originado de um pagamento","médico."},{},{},.T.)

PutHelp("PPLSA003018",{"Não será possível a exclusão","do recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003018",{"Titulo a cobrar vinculado à recurso","já foi transferido para banco."},{},{},.T.)

PutHelp("PPLSA003019",{"Não será possível a exclusão","do recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003019",{"Titulo a cobrar vinculado à recurso","já sofreu baixa."},{},{},.T.)

PutHelp("PPLSA003020",{"Não será possível a exclusão","do recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003020",{"A exclusão deverá ser efetuada pela ","rotina de pagamento médico, visto que o","titulo a pagar vinculado à recurso","foi originado de um pagamento","médico."},{},{},.T.)

PutHelp("PPLSA003021",{"Não será possível a exclusão","do recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003021",{"Titulo a pagar vinculado à recurso","já sofreu baixa."},{},{},.T.)

PutHelp("PPLSA003022",{"Não será possível a exclusão","do recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003022",{"Titulo a pagar vinculado à recurso","já foi contabilizado."},{},{},.T.)

PutHelp("PPLSA003023",{"Não foi possível localizar a","guia vinculada a esto recurso.",},{},{},.T.)
PutHelp("SPLSA003023",{"Verifique o conteudo dos campos","que indicam a chave da guia vinculada."},{},{},.T.)

PutHelp("PPLSA003024",{"Não será possível vincular","nenhum lote o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003024",{"o recurso selecionado já"  ,"encontra-se finalizada."},{},{},.T.)

PutHelp("PPLSA003025",{"Não será possível vincular","nenhum lote o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003025",{"o recurso selecionado já"  ,"encontra-se vinculada a um lote"},{},{},.T.)

PutHelp("PPLSA003026",{"Não será possível vincular","nenhum lote o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003026",{"o recurso selecionado foi","incluida automaticamente pelo sistema."},{},{},.T.)

PutHelp("PPLSA003027",{"Não será possível a exclusão","do recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003027",{"A exclusão deverá ser efetuada pela ","rotina de lote de intercâmbio, visto que o","titulo a cobrar vinculado à recurso","foi originado de um lote de","intercâmbio."},{},{},.T.)

PutHelp("PPLSA003028",{"Não será possível a exclusão","do recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003028",{"A exclusão deverá ser efetuada pela ","rotina de lote de cobrança, visto que o","titulo a cobrar vinculado à recurso","foi originado de um lote de","cobrança."},{},{},.T.)

PutHelp("PPLSA003029",{"Não foi possível localizar a","guia para a chave informada.",},{},{},.T.)
PutHelp("SPLSA003029",{"Os parâmetros informados não","são válidos.","","",""},{},{},.T.)

PutHelp("PPLSA003030",{"Não será possível vincular","a uma guia.",},{},{},.T.)
PutHelp("SPLSA003030",{"o recurso selecionado já"  ,"encontra-se finalizada."},{},{},.T.)

PutHelp("PPLSA003031",{"Não será possível desvincular","o item.",},{},{},.T.)
PutHelp("SPLSA003031",{"o recurso selecionado já"  ,"encontra-se finalizada."},{},{},.T.)

PutHelp("PPLSA003032",{"Não será possível desvincular","o item.",},{},{},.T.)
PutHelp("SPLSA003032",{"O item não encontra-se vinculado","a nenhuma guia."},{},{},.T.)

PutHelp("PPLSA003033",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003033",{"Existem itens que não estão","vinculados a nenhuma conta","médica."},{},{},.T.)

PutHelp("PPLSA003034",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003034",{"Fornecedor informado na Rede","de Atendimento inválido."},{},{},.T.)

PutHelp("PPLSA003035",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003035",{"Natureza do credenciado invalida.",""},{},{},.T.)

PutHelp("PPLSA003036",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003036",{"Ponto de entrada PLNATESP","inválido."},{},{},.T.)

PutHelp("PPLSA003037",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003037",{"Natureza da operadora invalida.",""},{},{},.T.)

PutHelp("PPLSA003038",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003038",{"Cliente informado na Rede","de Atendimento inválido."},{},{},.T.)

PutHelp("PPLSA003039",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003039",{"As datas de emissão, de vencimento","e o número do título","devem ser informados."},{},{},.T.)

PutHelp("PPLSA003040",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003040",{"As datas de emissão e de","vencimento devem ser informadas.",""},{},{},.T.)

PutHelp("PPLSA003041",{"Não será possível finalizar","o recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003041",{"Lancamento de credito cadastrado","no parametro, nao localizado.",""},{},{},.T.)

PutHelp("PPLSA003042",{"Não será possível a exclusão","do recurso selecionado.",},{},{},.T.)
PutHelp("SPLSA003042",{"Existem lançamentos de credito","ja faturados para o prestador","","",""},{},{},.T.)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³BusPrXA2      ³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ 				    						                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function BusPrXA2(cCodQue,cOpeCre,cCodRec)
LOCAL nRecXA2 := XA2->(Recno())
LOCAL nOrdXA2 := XA2->(IndexOrd())
LOCAL cNewSeq := ""

XA2->(DbSetOrder(1))
XA2->(DbSeek(xFilial("XA2")+cOpeCre+cCodQue+Replicate("Z",Len(XA2->XA2_SEQQUE)),.T.))
XA2->(DbSkip(-1))

If XA2->(XA2_FILIAL+XA2_OPECRE+XA2_CODQUE) == xFilial("XA2")+cOpeCre+cCodQue
	cNewSeq := Soma1(XA2->XA2_SEQQUE)
Else
	cNewSeq := StrZero(1,Len(XA2->XA2_SEQQUE))
Endif

XA2->(DbSetOrder(nOrdXA2))
XA2->(DbGoTo(nRecXA2))

return cNewSeq
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³BusPrXA1      ³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ 				    						                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function BusPrXA1(cOpeCre)
LOCAL nRecXA1 := XA1->(Recno())
LOCAL nOrdXA1 := XA1->(IndexOrd())
LOCAL cNewSeq := ""
LOCAL nSeqIni := GetNewPar("MV_PL003NI",1)

XA1->(DbSetOrder(1))
XA1->(DbSeek(xFilial("XA1")+cOpeCre+Replicate("Z",Len(XA1->XA1_CODQUE)),.T.))
XA1->(DbSkip(-1))

If XA1->(XA1_FILIAL+XA1_OPECRE) == xFilial("XA1")+cOpeCre
	cNewSeq := Soma1(XA1->XA1_CODQUE)
Else
	cNewSeq := StrZero(nSeqIni,Len(XA1->XA1_CODQUE))
Endif

XA1->(DbSetOrder(nOrdXA1))
XA1->(DbGoTo(nRecXA1))

return cNewSeq

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³PlGerCon      ³ Autor ³ Daher					³ Data ³ 01.06.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ 				    						                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PlGerCon(cOpeCre,cOpeOri,cOpeDes,cSeqImp,cLotOri,cOrigem,cPrefiP,;
cPrefiC,cNumP,cNumC,cParceP,cParceC,cTipoP,cTipoC,nVlToFa,;
nVlToCo,nVlToAc,nVlToPa,cStatCab,cAnoLot,cMesLot)

LOCAL cSeqXA1   := ''
LOCAL cSeqXA2   := ''
LOCAL nH  		:= ''
LOCAL nRecBA0   := BA0->(Recno())
LOCAL nOrdBA0   := BA0->(IndexOrd())
LOCAL cMotQue 	:= ''
LOCAL cDesMot 	:= ''
LOCAL cComQue 	:= ''
DEFAULT cPrefiP := ''
DEFAULT cPrefiC := ''
DEFAULT cNumP   := ''
DEFAULT cNumC   := ''
DEFAULT cParceP := ''
DEFAULT cParceC := ''
DEFAULT cTipoP  := ''
DEFAULT cTipoC  := ''
DEFAULT nVlToFa := 0
DEFAULT nVlToCo := 0
DEFAULT nVlToAc := 0
DEFAULT nVlToPa := 0

cLotOri := cLotOri+SPACE(TamSx3("XA1_LOTORI")[1]-Len(cLotOri))

nH  := PLSAbreSem("P003FINAL.SMF")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vou varrer todos os procedimentos daquele lote de importacao			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BD6->(DbSetOrder(14))
If BD6->(MsSeek(xFilial("BD6")+cSeqImp))
	While !BD6->(Eof()) .and. BD6->(BD6_FILIAL+BD6_SEQIMP) == xFilial("BD6")+cSeqImp
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ So vou criar a contestacao para itens que tenham glosas					 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If BD6->BD6_SITUAC == '1' .and. BD6->BD6_FASE == '4'
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Pega o valor apresentado 		 										 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nVlrApr := 0
			nVlrRec := 0
			If  GetNewPar("MV_P500BD6","0") == '1'
				//nVlrApr := BD6->BD6_VLRAPR*BD6->BD6_QTDAPR       //BD6_QTDAPR DESCONTINUADO
				nVlrApr := BD6->BD6_VLRAPR*BD6->BD6_QTDPRO
				BD7->(DbSetOrder(1))
				If BD7->( MsSeek( xFilial("BD6")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN) ) )
					While !BD7->( Eof() ) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == xFilial("BD6")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
						nVlrRec += BD7->BD7_VLRPAG
						BD7->( DbSkip() )
					Enddo
				Endif
			Else
				BD7->(DbSetOrder(1))
				If BD7->( MsSeek( xFilial("BD6")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN) ) )
					While !BD7->( Eof() ) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == xFilial("BD6")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)
						//nVlrApr += BD7->BD7_VLRAPR*BD6->BD6_QTDAPR    //BD6_QTDAPR DESCONTINUADO
						nVlrApr += BD7->BD7_VLRAPR*BD6->BD6_QTDPRO
						nVlrRec += BD7->BD7_VLRPAG
						BD7->( DbSkip() )
					Enddo
				Endif
			Endif
			
			If abs(nVlrApr - nVlrRec) >  0.01
				XA1->(DbSetOrder(2))
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Se ainda n tem o cabecalho eu crio ele									 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !XA1->(MsSeek(xFilial("XA1")+cOrigem+cLotOri+"000"))//crio o cabeçalho
					cSeqXA1 := u_BusPrXA1(cOpeCre)
					XA1->(Reclock("XA1",.T.))
					XA1->XA1_FILIAL := xFilial("XA1")
					XA1->XA1_OPECRE := cOpeCre
					XA1->XA1_DESCRE := Posicione("BA0",1,xFilial("BA0")+cOpeCre,"BA0_NOMINT")
					XA1->XA1_CODQUE := cSeqXA1
					XA1->XA1_SEQREC := "000"
					XA1->XA1_STATUS := cStatCab
					XA1->XA1_ORIGEM := cOrigem
					XA1->XA1_DTENVI := dDataBase
					XA1->XA1_PREFIP := cPrefiP
					XA1->XA1_NUMP   := cNumP
					XA1->XA1_PARCEP := cParceP
					XA1->XA1_TIPOP  := cTipoP
					XA1->XA1_PREFIC := cPrefiC
					XA1->XA1_NUMC   := cNumC
					XA1->XA1_PARCEC := cParceC
					XA1->XA1_TIPOC  := cTipoC
					XA1->XA1_OPEORI := cOpeOri
					XA1->XA1_DESORI := Posicione("BA0",1,xFilial("BA0")+cOpeOri,"BA0_NOMINT")
					XA1->XA1_OPEDES := cOpeDes
					XA1->XA1_DESDES := Posicione("BA0",1,xFilial("BA0")+cOpeDes,"BA0_NOMINT")
					XA1->XA1_TIPINC := '2'
					XA1->XA1_OPESIS := Upper(PLRETOPE())
					XA1->XA1_LOTORI := cLotOri
					XA1->XA1_VLRTFA := nVlToFa
					XA1->XA1_VLRTCO := nVlToCo
					XA1->XA1_VLRTAC := nVlToAc
					XA1->XA1_VLRTPA := nVlToPa
					XA1->XA1_ANOLOT := cAnoLot
					XA1->XA1_MESLOT := cMesLot
					XA1->XA1_MOMENT := '1'
					XA1->XA1_TIPOIN	:= '1'
					XA1->(MsUnlock())
					dbCommitAll()
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Busco o sequencial do item												 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cSeqXA2 := u_BusPrXA2(XA1->XA1_CODQUE,XA1->XA1_OPECRE,XA1->XA1_SEQREC)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Busco o motivo de questionamento 										 ³
				//| Vou varrer todas as criticas do procedimento, ate que encontre algum que |
				//| esteja preenchido o campo BCT_MOTQUE                                     |
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cMotQue := ""
				cDesMot := ""
				BDX->(DbSetOrder(1))
				If BDX->( MsSeek( xFilial("BDX")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO+BD6_SEQUEN) ) )
					While !BDX->(Eof()) .and. ;
						BDX->(BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN) ==;
						xFilial("BDX")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO+BD6_SEQUEN)
						
						If BDX->BDX_TIPREG == '1'
							cMotQue := BDX->BDX_CODGLO
							cDesMot := BDX->BDX_DESGLO
							exit
						Endif
						
						BDX->(DbSkip())
					Enddo
				Endif
				
				If Empty(cMotQue)
					PLSPOSGLO(PLSINTPAD(),__aCdCri049[1],__aCdCri049[2])
					cMotQue := __aCdCri049[1]
					cDesMot := __aCdCri049[2]
					cComQue := ""
				Endif
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Crio o item																 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				XA2->(Reclock("XA2",.T.))
				XA2->XA2_FILIAL := xFilial("XA2")
				XA2->XA2_OPECRE := XA1->XA1_OPECRE
				XA2->XA2_CODQUE := XA1->XA1_CODQUE
				XA2->XA2_SEQQUE := cSeqXA2
				XA2->XA2_SEQREC := XA1->XA1_SEQREC
				XA2->XA2_CODOPE := BD6->BD6_CODOPE
				XA2->XA2_CODLDP := BD6->BD6_CODLDP
				XA2->XA2_CODPEG := BD6->BD6_CODPEG
				XA2->XA2_NUMERO := BD6->BD6_NUMERO
				XA2->XA2_ORIMOV := BD6->BD6_ORIMOV
				XA2->XA2_SEQUEN := BD6->BD6_SEQUEN
				XA2->XA2_CODPAD := BD6->BD6_CODPAD
				XA2->XA2_CODPRO := BD6->BD6_CODPRO
				XA2->XA2_DESPRO := BD6->BD6_DESPRO
				XA2->XA2_MOTQUE := cMotQue
				XA2->XA2_DESQUE := cDesMot
				XA2->XA2_COMQUE := cComQue
				XA2->XA2_STATUS := '9'
				XA2->XA2_DATACO := dDataBase
				XA2->XA2_VLRCOB := nVlrApr
				XA2->XA2_VLRREC := nVlrRec
				XA2->XA2_VLRACO := 0
				XA2->(MsUnlock())
				
				dbCommitAll()
			Endif
		Endif
		BD6->(DbSkip())
	Enddo
Endif
PLSFechaSem(nH,"P003FINAL.SMF")

BA0->(DbSetOrder(nOrdBA0))
BA0->(DbGoTo(nRecBA0))

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Daher			     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CriaSX1()
LOCAL aRegs	 :=	{}
LOCAL cPerg  := "FEF003"

aadd(aRegs,{cPerg,"01","Operadora"             ,"","","mv_ch1","C",4,0,0 ,"G","U_P003VALSX1('FEF00301')","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS",""})
aadd(aRegs,{cPerg,"02","Local Digit."          ,"","","mv_ch2","C",4,0,0 ,"G","U_P003VALSX1('FEF00302')","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","BAZPLS",""})
aadd(aRegs,{cPerg,"03","Código Peg"            ,"","","mv_ch3","C",8,0,0 ,"G","U_P003VALSX1('FEF00303')","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","BCMPLS",""})
aadd(aRegs,{cPerg,"04","Número Guia"           ,"","","mv_ch4","C",8,0,0 ,"G","U_P003VALSX1('FEF00304')","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""		,""})
aadd(aRegs,{cPerg,"05","Número Impresso"       ,"","","mv_ch5","C",20,0,0,"G","U_P003VALSX1('FEF00305')","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""		,""})

PlsVldPerg( aRegs )
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ P003VALSX1³ Autor ³ Daher			     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ 			                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

User Function P003VALSX1(cPerg)
LOCAL lRet := .F.

If cPerg == "FEF00301"
	lRet := Empty(mv_par01) .or. ExistCpo('BA0',mv_par01)
Endif

If cPerg == "FEF00302"
	lRet := Empty(mv_par02) .or. ExistCpo('BCG',mv_par02+mv_par01)
Endif

If cPerg == "FEF00303"
	lRet := Empty(mv_par03) .or. ExistCpo('BCI',mv_par01+mv_par02+mv_par03)
Endif

If cPerg == "FEF00304"
	lRet := Empty(mv_par04) .or. ExistCpo('BD6',mv_par01+mv_par02+mv_par03+mv_par04)
Endif

If cPerg == "FEF00305"
	BD5->(DbSetOrder(6))
	BE4->(DbSetOrder(6))
	lRet := Empty(mv_par05) .or. BD5->(MsSeek(xFilial("BD5")+mv_par05)) .or. BE4->(MsSeek(xFilial("BE4")+mv_par05))
	If !Empty(mv_par05)
		Help("",1,"REGNOIS")
	Endif
Endif

return lRet

Static Function VldGui(cCodQue,cSequen)
Local lRet   := .T.
Local cQuery := ""

cQuery := " SELECT * FROM "+RetSqlName("XA2")+" "
cQuery += " WHERE D_E_L_E_T_ = '' "
cQuery += " AND XA2_CODQUE = '"+cCodQue+"' "
cQuery += " AND XA2_SEQUEN = '"+cSequen+"' "
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"TRBVLD",.F.,.T.)

dbSelectArea("TRBVLD")
If TRBVLD->(!EOF())
	lRet := .F.
EndIf
dbCloseArea()

Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SldGlosa  ºAutor  ³Rafael Fernandes    º Data ³  04/04/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula o saldo atual do recurso de glosa                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SldGlosa(cCodOpe,cCodLoc,cPEG,cNum,cSeq,cCodRDA)
Local aArea := GetArea()
Local cQuery := ""
Local nRet := 0

cQuery := " SELECT COUNT(*) AS QUANT, MAX(XA2.XA2_VLRCOB)-SUM(XA2.XA2_VLRREC) AS SALDO FROM "+RetSQLName("XA2")+" XA2 "
cQuery += " INNER JOIN "+RetSQLName("XA1")+" XA1 " 
cQuery += " ON XA1.XA1_FILIAL = XA2.XA2_FILIAL "
cQuery += " AND XA1.XA1_CODQUE = XA2.XA2_CODQUE "
cQuery += " AND XA1.D_E_L_E_T_ = XA2.D_E_L_E_T_ "
cQuery += " WHERE XA2.D_E_L_E_T_ = '' "
cQuery += " AND XA2.XA2_FILIAL = '"+xFilial("XA2")+"' "
cQuery += " AND XA2.XA2_CODOPE = '"+cCodOpe+"'
cQuery += " AND XA2.XA2_CODLDP = '"+cCodLoc+"'
cQuery += " AND XA2.XA2_CODPEG = '"+cPEG+"'
cQuery += " AND XA2.XA2_NUMERO = '"+cNum+"'
cQuery += " AND XA2.XA2_SEQUEN = '"+cSeq+"'
cQuery += " AND XA2.XA2_STATUS<>'3' "         
cQuery += " AND XA1.XA1_CODRDA = '"+cCodRDA+"' "
If ALTERA
	cQuery += " AND XA2.XA2_CODQUE <> '"+XA2->XA2_CODQUE+"' "
EndIf            

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"TRBSLD",.F.,.T.)

dbSelectArea("TRBSLD")
If TRBSLD->(!EOF())
	If TRBSLD->QUANT > 0
		nRet := TRBSLD->SALDO
	Else
		nRet := -1
	EndIf
Else
	nRet := -1
EndIf

dbSelectArea("TRBSLD")
TRBSLD->(dbCloseArea())

RestArea(aArea)
Return nRet



User Function VldItGlosa(cCodOpe,cCodLoc,cPEG,cNum,cSeq,cCodRDA)
Local lRet := .T.
Local nSld := 0
Local cMSG := ""

cQuery := " SELECT XA2_CODQUE, XA2_SEQQUE,XA2_STATUS, XA2_SEQUEN, XA1_OPECRE, XA1_CODRDA, XA1_DESRDA,XA1_STATUS  FROM "+RetSQLName("XA2")+" XA2 "
cQuery += " INNER JOIN "+RetSQLName("XA1")+" XA1 "
cQuery += " ON XA1.XA1_FILIAL = XA2.XA2_FILIAL "
cQuery += " AND XA1.XA1_CODQUE = XA2.XA2_CODQUE "
cQuery += " AND XA1.D_E_L_E_T_ = XA2.D_E_L_E_T_ "
cQuery += " WHERE XA2.D_E_L_E_T_ = '' "
cQuery += " AND XA2.XA2_FILIAL = '"+xFilial("XA2")+"' "
cQuery += " AND XA2.XA2_CODOPE = '"+cCodOpe+"' "
cQuery += " AND XA2.XA2_CODLDP = '"+cCodLoc+"' "
cQuery += " AND XA2.XA2_CODPEG = '"+cPEG+"' "
cQuery += " AND XA2.XA2_NUMERO = '"+cNum+"' "
cQuery += " AND XA2.XA2_SEQUEN = '"+cSeq+"' "
cQuery += " AND XA1.XA1_CODRDA = '"+cCodRDA+"' "
//cQuery += " AND XA1.XA1_STATUS <> '1' "

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"TRBVLD2",.F.,.T.)

nSld := U_SldGlosa(cCodOpe,cCodLoc,cPEG,cNum,cSeq,cCodRDA)

dbSelectArea("TRBVLD2")
If TRBVLD2->(!EOF())
	cMsg := " O item "+alltrim(TRBVLD2->XA2_SEQUEN)+" da guia já se foi utilizado em outro recurso "+cEOL
	cMsg += " ___________________________________________________________________________ "+cEOL
	While TRBVLD2->(!EOF())
		cMsg += cEOL+" Operadora:"+TRBVLD2->XA1_OPECRE+"  RDA:"+TRBVLD2->XA1_CODRDA+" - "+XA1_DESRDA+" "+cEOL
		cMsg += " Recurso:"+TRBVLD2->XA2_CODQUE+"  Sequencia:"+TRBVLD2->XA2_SEQQUE+" "+cEOL
		cMsg += " Status: "+IIF(alltrim(TRBVLD2->XA2_STATUS)=='1',"Em Negociação",IIF(alltrim(TRBVLD2->XA2_STATUS)=='2',"Recurso Aceito","Recurso Negado"))
		cMsg += " ___________________________________________________________________________ "+cEOL
		TRBVLD2->(dbSkip())
	EndDo
	cMsg += cEOL+" O saldo atual deste recurso é de R$"+alltrim(Transform( nSld ,PesqPict("XA2","XA2_VLRREC")))+" "+cEOL
	If nSld = 0
		cMsg += " Este recurso não poderá ser efetivado pois o saldo encontra-se zerado!"+cEOL
		MsgInfo(cMsg)
		dbSelectArea("TRBVLD2")
		TRBVLD2->(dbCloseArea())
		Return .F.
	Else
		cMsg += " Deseja incluir um novo recurso?"+cEOL
	EndIf
	
	lRet := MsgYesNo(cMsg)
EndIf
dbSelectArea("TRBVLD2")
TRBVLD2->(dbCloseArea())

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABGLOSA  ºAutor  ³Microsiga           º Data ³  04/11/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function TelaGuia(aDados,cTitulo)

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local y := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local oDlg
Local nOpca      := 0
Local bOK        := { || nOpca := 1, GetVal(@aVetor), oDlg:End() }
Local bCancel    := { || nOpca := 0, oDlg:End() }
Local nFor
Local oCritica
Local nLinSel
Local aButtons := {}
Local bLDblClick := bOk
Local cTpRel     := "G"
Local nTmRel     := 220
Local bBlickUser := { || }
Local aArrayAux  := {}
Local cLin1 := 008.0
Local cLin2 := 036.4
Local cCol1 := 010.3
Local cCol2 := 100.3     
Local   cVar     := ''
Local   oLbx     := NIL
Local oChkMar := nil      
Local lChk := .F.  
Private aVetor := {}      
Private oOk      := LoadBitmap( GetResources(), 'LBOK' )
Private oNo      := LoadBitmap( GetResources(), 'LBNO' )


Define FONT oFont NAME "Courier New" Size 0,-10 BOLD


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define dialogo...                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSize    := MsAdvSize()
aObjects := {}
AAdd( aObjects, { 100, 100, .t., .t.,.t. } )
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects,.T. )

DEFINE MSDIALOG oDlg TITLE cTitulo FROM cLin1,cCol1 TO cLin2,cCol2

For x:=1 to Len(aDados)
	aItem := {}   
	aadd(aItem,.F.)
	For y:=1 to len(aDados[x])
		aadd(aItem,aDados[x][y])
	Next
    aadd(aVetor,aItem)
    aItem := {}
Next

@ 022, 005 Listbox oLbx Var cVar Fields Header "", "Seq.","Tp.Tb.","Cód. Proc.","Descrição","Valor Pgto","Valor Cob.","Data Proc." Size 345,170 Of oDlg Pixel
oLbx:SetArray(  aVetor )           
bBloq := ""
If Len(aVetor)>0
	bBloq:= "{|| {IIf( aVetor[oLbx:nAt, 1], oOk, oNo )"
	For x:=2 to len(aVetor[1])
		bBloq +=",aVetor[oLbx:nAt,"+str(x,4)+"]" 
	Next       
	bBloq+="}}"
EndIf
oLbx:bLine:=&bBloq
//oLbx:bLine := {|| {IIf( aVetor[oLbx:nAt, 1], oOk, oNo ),aVetor[oLbx:nAt, 2],aVetor[oLbx:nAt, 4]}}
oLbx:BlDblClick := { || aVetor[oLbx:nAt, 1] := !aVetor[oLbx:nAt, 1], oChkMar:Refresh(), oLbx:Refresh()}
oLbx:cToolTip   :=  oDlg:cTitle
oLbx:lHScroll   := .F. // NoScroll

@ 200, 005 CheckBox oChkMar Var  lChk Prompt 'Todos'   Message 'Marca / Desmarca Todos' Size 40, 007 Pixel Of oDlg;
on click (Aeval( aVetor,{ |x, y| aVetor[y][1] :=  lChk  } ), oLbx:Refresh() )


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa dialogo....                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ACTIVATE MSDIALOG oDlg ON INIT Eval( { || EnChoiceBar(oDlg,bOK,bCancel,.F.,aButtons) } ) Center

Return aVetor


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABGLOSA  ºAutor  ³Microsiga           º Data ³  04/16/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function TelaItem(aDados,aCabec,cTitulo)

Local oDlg
Local nOpca      := 0
Local bOK        := { || nOpca := 1, nLinSel := oCritica:nAt, oDlg:End() }
Local bCancel    := { || nOpca := 0, oDlg:End() }
Local nFor
Local oCritica
Local nLinSel
Local aButtons := {}
Local bLDblClick := bOk
Local cTpRel     := "G"
Local nTmRel     := 220
Local bBlickUser := { || }
Local aArrayAux  := {}
Local cLin1 := 008.0
Local cLin2 := 036.4
Local cCol1 := 010.3
Local cCol2 := 100.3     
Local   cVar     := ''
Local   oLbx     := NIL
Local aVetor := {}      
Local oChkMar := nil      
Local lChk := .F.

Define FONT oFont NAME "Courier New" Size 0,-10 BOLD


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define dialogo...                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSize    := MsAdvSize()
aObjects := {}
AAdd( aObjects, { 100, 100, .t., .t.,.t. } )
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects,.T. )

DEFINE MSDIALOG oDlg TITLE cTitulo FROM cLin1,cCol1 TO cLin2,cCol2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o browse...                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCritica := TcBrowse():New( 022, 005, 345,170,,,, oDlg,,,,,,,,,,,, .F.,, .T.,, .F., )
oCritica:bLDblClick := { || Eval(bBlickUser,oCritica,aArrayAux), bLDblClick }
oCritica:oFont := IIf(oFont == Nil, oCritica:oFont, oFont)

For nFor := 1 To Len(aCabec)

bBlock := "{ || aDados[oCritica:nAt, "+Str(nFor,4)+"] }"
bBlock := &bBlock
oCritica:AddColumn(TcColumn():New(aCabec[nFor,1],bBlock,;
aCabec[nFor,2],nil,nil,nil,aCabec[nFor,3],.F.,.F.,nil,nil,nil,.F.,nil))

Next
oCritica:SetArray(aDados)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa dialogo....                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

ACTIVATE MSDIALOG oDlg ON INIT Eval( { || EnChoiceBar(oDlg,bOK,bCancel,.F.,aButtons) } ) Center

Return({(nOpca==1),nLinSel})

     
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABGLOSA  ºAutor  ³Microsiga           º Data ³  04/16/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GetVal(aRet)

Local oDlg,oGrp2,oSBtn3,oSBtn4,oSay5,oGet6,oSay7,oCombo8,oSay9,oGet10,oSay11,oGet13
Local nXopx := 0
Local SldGlo := 0

dbSelectArea("XA2")

RegToMemory( "XA2", .T. )
dbSelectArea("BD6")
BD6->(DbGoTo(aVetor[1][9]))

nSldGlosa := U_SldGlosa(BD6->BD6_CODOPE,BD6->BD6_CODLDP,BD6->BD6_CODPEG,BD6->BD6_NUMERO,BD6->BD6_SEQUEN,BD6->BD6_CODRDA)
If nSldGlosa==-1
	M->XA2_VLRREC := BD6->BD6_VLRGLO
	nSldGlosa := BD6->BD6_VLRGLO     
Else
	M->XA2_VLRREC := nSldGlosa
EndIf

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Diálogo"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 706
oDlg:nHeight := 252
oDlg:lShowHint := .F.
oDlg:lCentered := .F.

oGrp2 := TGROUP():Create(oDlg)
oGrp2:cName := "oGrp2"
oGrp2:cCaption := "Dados dos Recursos"
oGrp2:nLeft := 11
oGrp2:nTop := 9
oGrp2:nWidth := 656
oGrp2:nHeight := 157
oGrp2:lShowHint := .F.
oGrp2:lReadOnly := .F.
oGrp2:Align := 0
oGrp2:lVisibleControl := .T.

oSBtn3 := SBUTTON():Create(oDlg)
oSBtn3:cName := "oSBtn3"
oSBtn3:cCaption := "Confirmar"
oSBtn3:nLeft := 500
oSBtn3:nTop := 176
oSBtn3:nWidth := 72
oSBtn3:nHeight := 22
oSBtn3:lShowHint := .F.
oSBtn3:lReadOnly := .F.
oSBtn3:Align := 0
oSBtn3:lVisibleControl := .T.
oSBtn3:nType := 1  
oSBtn3:bAction:= {|| nXopc:=1,IIF( !Empty(M->XA2_DESQUE) .and.( IIF( Substr(M->XA2_STATUS,1,1) <> '1',!Empty(M->XA2_DESNEG),.T.) ).and.!Empty(M->XA2_VLRREC),oDlg:end(),Alert("Dados Inválidos!") )}
                              

oSBtn4 := SBUTTON():Create(oDlg)
oSBtn4:cName := "oSBtn4"
oSBtn4:cCaption := "Cancelar"
oSBtn4:nLeft := 582
oSBtn4:nTop := 176
oSBtn4:nWidth := 72
oSBtn4:nHeight := 22
oSBtn4:lShowHint := .F.
oSBtn4:lReadOnly := .F.
oSBtn4:Align := 0
oSBtn4:lVisibleControl := .T.
oSBtn4:nType := 2  
oSBtn4:bAction:= {|| nXopc:=0, aRet := {}, oDlg:end()}

oSay5 := TSAY():Create(oDlg)
oSay5:cName := "oSay5"
oSay5:cCaption := "Motivo"
oSay5:nLeft := 23
oSay5:nTop := 37
oSay5:nWidth := 38
oSay5:nHeight := 17
oSay5:lShowHint := .F.
oSay5:lReadOnly := .F.
oSay5:Align := 0
oSay5:lVisibleControl := .T.
oSay5:lWordWrap := .F.
oSay5:lTransparent := .F.

oGet6 := TGET():Create(oDlg)
oGet6:cName := "oGet6"
oGet6:nLeft := 79
oGet6:nTop := 35
oGet6:nWidth := 517
oGet6:nHeight := 21
oGet6:lShowHint := .F.
oGet6:lReadOnly := .F.
oGet6:Align := 0
oGet6:cVariable := "M->XA2_DESQUE"
oGet6:bSetGet := {|u| If(PCount()>0,M->XA2_DESQUE:=u,M->XA2_DESQUE) }
oGet6:lVisibleControl := .T.
oGet6:lPassword := .F.
oGet6:lHasButton := .F.

oSay7 := TSAY():Create(oDlg)
oSay7:cName := "oSay7"
oSay7:cCaption := "Status"
oSay7:nLeft := 22
oSay7:nTop := 65
oSay7:nWidth := 38
oSay7:nHeight := 17
oSay7:lShowHint := .F.
oSay7:lReadOnly := .F.
oSay7:Align := 0
oSay7:lVisibleControl := .T.
oSay7:lWordWrap := .F.
oSay7:lTransparent := .F.

oCombo8 := TCOMBOBOX():Create(oDlg)
oCombo8:cName := "oCombo8"
oCombo8:cCaption := "Recurso em Negoc."
oCombo8:nLeft := 79
oCombo8:nTop := 63
oCombo8:nWidth := 145
oCombo8:nHeight := 21
oCombo8:lShowHint := .F.
oCombo8:lReadOnly := .F.
oCombo8:Align := 0  
oCombo8:cVariable := "M->XA2_STATUS"
oCombo8:bSetGet := {|u| If(PCount()>0,M->XA2_STATUS:=u,M->XA2_STATUS) }
oCombo8:lVisibleControl := .T.
oCombo8:aItems := { "1- Recurso em Negoc.","2- Recurso Aceito","3- Recurso Negado"}
oCombo8:nAt := 0
oCombo8:bChange := {||IIF( substr(M->XA2_STATUS,1,1)<>"1",oGet10:lReadOnly:=.F.,eval({|| M->XA2_DESNEG:=space(len(M->XA2_DESNEG)),oGet10:lReadOnly:=.T. }) ) }


oSay9 := TSAY():Create(oDlg)
oSay9:cName := "oSay9"
oSay9:cCaption := "Parecer"
oSay9:nLeft := 23
oSay9:nTop := 93
oSay9:nWidth := 46
oSay9:nHeight := 17
oSay9:lShowHint := .F.
oSay9:lReadOnly := .F.
oSay9:Align := 0
oSay9:lVisibleControl := .T.
oSay9:lWordWrap := .F.
oSay9:lTransparent := .F.

oGet10 := TGET():Create(oDlg)
oGet10:cName := "oGet10"
oGet10:nLeft := 79
oGet10:nTop := 91
oGet10:nWidth := 519
oGet10:nHeight := 21
oGet10:lShowHint := .F.
oGet10:lReadOnly := .T.
oGet10:Align := 0  
oGet10:cVariable := "M->XA2_DESNEG"    
oGet10:bSetGet := {|u| If(PCount()>0,M->XA2_DESNEG:=u,M->XA2_DESNEG) }
oGet10:lVisibleControl := .T.
oGet10:lPassword := .F.
oGet10:lHasButton := .F.
oGet10:bValid  := {|| IIF( substr(M->XA2_STATUS,1,1)<>"1",!Empty(M->XA2_DESNEG),.T.)}


oSay11 := TSAY():Create(oDlg)
oSay11:cName := "oSay11"
oSay11:cCaption := "Vlr.Reco."
oSay11:nLeft := 22
oSay11:nTop := 121
oSay11:nWidth := 48
oSay11:nHeight := 17
oSay11:lShowHint := .F.
oSay11:lReadOnly := .F.
oSay11:Align := 0
oSay11:lVisibleControl := .T.
oSay11:lWordWrap := .F.
oSay11:lTransparent := .F.

oGet13 := TGET():Create(oDlg)
oGet13:cName := "oGet13"
oGet13:nLeft := 79
oGet13:nTop := 119
oGet13:nWidth := 121
oGet13:nHeight := 21
oGet13:lShowHint := .F.
oGet13:lReadOnly := .F.
oGet13:Align := 0  
oGet13:cVariable := "M->XA2_VLRREC" 
oGet13:bSetGet := {|u| If(PCount()>0,M->XA2_VLRREC:=u,M->XA2_VLRREC) }    
oGet13:Picture := PesqPict("XA2","XA2_VLRREC")
oGet13:lVisibleControl := .T.
oGet13:lPassword := .F.
oGet13:lHasButton := .F.
oGet13:bValid  := {|| IIF( M->XA2_VLRREC > nSldGlosa .or. M->XA2_VLRREC > BD6->BD6_VLRGLO,eval({|| alert("Valor inválido!"),.F.}),.T.)}

oDlg:Activate()

cMotivo  := M->XA2_DESQUE
cStatus  := SubStr(M->XA2_STATUS,1,1)
cParecer := M->XA2_DESNEG
nValRec  := M->XA2_VLRREC

Return aVetor
