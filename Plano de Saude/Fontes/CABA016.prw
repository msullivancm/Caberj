#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#include "topconn.ch"
#INCLUDE "APWEBSRV.CH"
#INCLUDE "XMLXFUN.CH"
#Include "PLSMGER.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ CABA016  ³ Autor ³ Luzio Tavares         ³ Data ³ 30/03/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Corrige as vias de carteiras no nivel de usuario           ³±±
±±³          ³ compatibilizando com o cadatro BED                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA016()
LOCAL aSays     := {}
LOCAL aButtons  := {}
LOCAL cCadastro := "Correcao das vias ce cartao do cadastro de usuarios"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Says																	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aSays,"Esta opcao permite a correcao da via do cartao do cadastro de usuario.")
AADD(aSays,"")
AADD(aSays,"Clique no botão OK para iniciar o processamento")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta botoes para janela de processamento                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aButtons, { 5,.T.,{|| } } )
AADD(aButtons, { 1,.T.,{|| Processa( {|| CABA0161() }, "Processando Acerto","Processando Acerto" ) } } )  //"Processando acerto"###"Processando Acerto"
AADD(aButtons, { 2,.T.,{|| FechaBatch() } } )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe janela de processamento                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
FormBatch( cCadastro, aSays, aButtons,,250 )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA0161 ºAutor  ³Microsiga           º Data ³  30/03/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABA0161()
Local cDirExp	:= "\Data\"
Local cNomeArq	:= cDirExp+"DIVCARTAO.TXT"
Local cEOL		:= CHR(13)+CHR(10)
Local cLin 		:= Space(1)+cEOL
Local cCpo		:= ""
local ncont 	:= 0

Local cSQL	:= Space(0)
Local aOk	:= {}
Local cAux	:= ""
Local cMesO
Local cAnoO
Local cMesD
Local cAnoD
Local dData   := CtoD("  /  /    ")
Local dDatVal := CtoD("  /  /    ")
Local lGrava  := .F.
Local nViaCar := 0

//Private cPerg	:= "AJUBSQ"
Private cAnoMesO:= ""
Private cAnoMesD:= ""
Private cLancDC	:= ""
Private nAcao	:= 0
Private cGrpCob	:= ""

PRIVATE nHdl

If msgyesno("Deseja efetivar as alteracoes na via de cartao dos usuarios?")
	lGrava := .T.
EndIf

If U_Cria_TXT(cNomeArq)
	
	cSQL := " SELECT R_E_C_N_O_ AS BA1RECNO, BA1.* "
	cSQL += " FROM "+RetSQLName("BA1")+" BA1 "
	cSQL += " WHERE BA1_FILIAL = ' "+xFilial("BA1")+"' "
	cSQL += " AND BA1_CODINT = '0001' "
	cSQL += " AND BA1_DATBLO = ' ' "
	cSQL += " AND BA1.D_E_L_E_T_ = ' ' "
	PLSQuery(cSQL,"TRB")
	
	Do While !TRB->(Eof())
		
		BA1->(dbgoto(TRB->BA1RECNO))
		
		nViaCar := 0  //BA1->BA1_VIACAR
		cCpo := Space(0)
		
		cSQL := "SELECT R_E_C_N_O_ AS BEDRECNO, BED.* "
		cSQL += "FROM "+RetSQLName("BED")+" BED "
		cSQL += "WHERE BED_FILIAL = ' "+xFilial("BED")+"' "
		cSQL += "AND BED_CODINT = '"+Trb->BA1_CODINT+"' "
		cSQL += "AND BED_CODEMP = '"+Trb->BA1_CODEMP+"' "
		cSQL += "AND BED_MATRIC = '"+Trb->BA1_MATRIC+"' "
		cSQL += "AND BED_TIPREG = '"+Trb->BA1_TIPREG+"' "
		cSQL += "AND BED.D_E_L_E_T_ = ' ' "
		cSQL += "ORDER BY BED_VIACAR "
		PLsQuery(cSql,"TMPBED")
		
		TMPBED->(dbgotop())
		
		If !TMPBED->(EOF())
			While !TMPBED->(EOF())
				nViacar := TMPBED->BED_VIACAR
				dDatVal := TMPBED->BED_DATVAL
				nRecnoBED := TMPBED->BEDRECNO
				TMPBED->(DbSkip())
			EndDo
			
			If BA1->BA1_VIACAR != nViaCar
				
				BED->(dbgoto(nRecnoBED))
				//				TMPBED->(DbSkip(-1))
				
				aadd(aOk,{BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_NOMUSR,BA1->BA1_CONEMP,BA1->BA1_SUBCON,BA1->BA1_VIACAR,BA1->BA1_DTVLCR,BA1->(Recno()),BED->BED_VIACAR,BED->BED_DATVAL,BED->BED_CDIDEN,BED->BED_CODINT,BED->BED_CODEMP,BED->BED_MATRIC,BED->BED_TIPREG,BED->BED_DIGITO,BED->BED_NOMUSR})
				
				//				cCpo :=	BA1->BA1_CODINT+";"+BA1->BA1_CODEMP+";"+BA1->BA1_MATRIC+";"+BA1->BA1_TIPREG+";"+BA1->BA1_DIGITO+";"+BA1->BA1_NOMUSR+";"+BA1->BA1_CONEMP+";"+BA1->BA1_SUBCON+";"+strzero(BA1->BA1_VIACAR,4,0)+";"+DtoC(BA1->BA1_DTVLCR)+";"+strzero(BA1->(Recno()),12,0)+";"+strzero(TMPBED->BED_VIACAR,4,0)+";"+DtoC(TMPBED->BED_DATVAL)+";"+TMPBED->BED_CDIDEN+";"+TMPBED->BED_CODINT+";"+TMPBED->BED_CODEMP+";"+TMPBED->BED_MATRIC+";"+TMPBED->BED_TIPREG+";"+TMPBED->BED_DIGITO
				cCpo :=	"C"+";"+BA1->BA1_CODINT+";"+BA1->BA1_CODEMP+";"+BA1->BA1_MATRIC+";"+BA1->BA1_TIPREG+";"+BA1->BA1_DIGITO+";"+BA1->BA1_NOMUSR+";"+BA1->BA1_CONEMP+";"+BA1->BA1_SUBCON+";"+strzero(BA1->BA1_VIACAR,4,0)+";"+DtoC(BA1->BA1_DTVLCR)+";"+strzero(BA1->(Recno()),12,0)+";"+strzero(BED->BED_VIACAR,4,0)+";"+DtoC(BED->BED_DATVAL)+";"+BED->BED_CDIDEN+";"+BED->BED_CODINT+";"+BED->BED_CODEMP+";"+BED->BED_MATRIC+";"+BED->BED_TIPREG+";"+BED->BED_DIGITO+";"+BED->BED_NOMUSR
				
				If lGrava
					BA1->(RecLock("BA1",.F.))
					BA1->BA1_VIACAR	:=	nViaCar
					BA1->BA1_DTVLCR	:=	dDatVal
					BA1->(MsUnlock())
				EndIf
				
			EndIf
		ElseIf BA1->BA1_VIACAR > 0
			aadd(aOk,{BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_NOMUSR,BA1->BA1_CONEMP,BA1->BA1_SUBCON,BA1->BA1_VIACAR,BA1->BA1_DTVLCR,BA1->(Recno()), NIL, NIL, NIL})
			cCpo :=	"A"+";"+BA1->BA1_CODINT+";"+BA1->BA1_CODEMP+";"+BA1->BA1_MATRIC+";"+BA1->BA1_TIPREG+";"+BA1->BA1_DIGITO+";"+BA1->BA1_NOMUSR+";"+BA1->BA1_CONEMP+";"+BA1->BA1_SUBCON+";"+strzero(BA1->BA1_VIACAR,4,0)+";"+DtoC(BA1->BA1_DTVLCR)+";"+strzero(BA1->(Recno()),12,0)
		EndIf
		
		If Len(AllTrim(cCpo)) > 0
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENÇÃO! NÃO FOI POSSIVEL GRAVAR CORRETAMENTE O REGISTRO! OPERAÇÃO ABORTADA!")
				Return
			Endif
		EndIf
		
		TMPBED->(DbCloseArea())
		Trb->(DbSkip())
		
	Enddo
	U_Fecha_TXT()
	TRB->(DbCloseArea())
EndIf

MsgAlert("Rotina de ajuste finalizada!")

Return