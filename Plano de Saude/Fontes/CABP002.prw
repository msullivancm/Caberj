#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#include "topconn.ch"
#INCLUDE "APWEBSRV.CH"
#INCLUDE "XMLXFUN.CH"
#Include "PLSMGER.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ CABP002  ณ Autor ณ Luzio Tavares         ณ Data ณ 29/08/07 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Corrige a data de bloqueio das familias cujo titular esta  ณฑฑ
ฑฑณ          ณ desbloqueado                                               ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ Caberj                                                     ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABP002()
LOCAL aSays     := {}
LOCAL aButtons  := {}
LOCAL cCadastro := "Correcao da data de bloqueio das familias do Itau"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Says																	 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
AADD(aSays,"Esta opcao permite a correcao da data de bloqueio do cadastro de familia.")
AADD(aSays,"")
AADD(aSays,"Clique no botใo OK para iniciar o processamento")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta botoes para janela de processamento                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
AADD(aButtons, { 5,.T.,{|| } } )
AADD(aButtons, { 1,.T.,{|| Processa( {|| AjComp() }, "Processando Acerto","Processando Acerto" ) } } )  //"Processando acerto"###"Processando Acerto"
AADD(aButtons, { 2,.T.,{|| FechaBatch() } } )
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Exibe janela de processamento                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
FormBatch( cCadastro, aSays, aButtons,,250 )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjComp    บAutor  ณMicrosiga           บ Data ณ  27/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjComp()
Local cDirExp	:= "\interface\importa\itaubenef\recebidos\financeiro\"
Local cNomeArq	:= cDirExp+"FAMBLOCOR.TXT"
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
Local dDatBlo := CtoD("  /  /    ")
Local lGrava  := .F.

//Private cPerg	:= "AJUBSQ"
Private cAnoMesO:= ""
Private cAnoMesD:= ""
Private cLancDC	:= ""
Private nAcao	:= 0
Private cGrpCob	:= ""

PRIVATE nHdl

//CriaParSX()

//If !Pergunte( cPerg, .T. )
//	Return(.F.)
//Endif

//cAnoMesO:= Alltrim(mv_par01)
//cAnoMesD:= Alltrim(mv_par02)
//cLancDC	:= Alltrim(mv_par03)
//nAcao	:= mv_par04
//cGrpCob	:= Alltrim(mv_par05)


//cAnoO := Substr(cAnoMesO,1,4)
//cMesO := Substr(cAnoMesO,5,2)
//cAnoD := Substr(cAnoMesD,1,4)
//cMesD := Substr(cAnoMesD,5,2)

//BSQ->(DbSetOrder(4))

If msgyesno("Deseja efetivar as alteracoes no cadastro de clientes?")
	lGrava := .T.
EndIf

If U_Cria_TXT(cNomeArq)
	
	cSQL := " SELECT R_E_C_N_O_ AS BA1RECNO, BA1.* "
	cSQL += " FROM "+RetSQLName("BA1")+" BA1 "
	cSQL += " WHERE BA1_FILIAL = ' "+xFilial("BA1")+"' "
	cSQL += " AND BA1_CODINT = '0001' "
	cSQL += " AND BA1_CODEMP = '0006' "
	cSQL += " AND BA1_TIPREG = '00' "
	cSQL += " AND BA1_DATBLO = ' ' "
	cSQL += " AND BA1.D_E_L_E_T_ = ' ' "
	PLSQuery(cSQL,"TRB")
	
	Do While !TRB->(Eof())
		
		dData := CtoD("  /  /    ")
		
		cSQL := " SELECT * "
		cSQL += " FROM "+RetSQLName("BCA")+" BCA "
		cSQL += " WHERE BCA_FILIAL = ' "+xFilial("BCA")+"' "
		cSQL += " AND BCA_MATRIC = '"+Trb->BA1_CODINT+Trb->BA1_CODEMP+Trb->BA1_MATRIC+"'"
		cSQL += " AND BCA_TIPREG = '"+Trb->BA1_TIPREG+"'"
		cSQL += " AND BCA_TIPO   = '1' "   //Desbloqueio
		cSQL += " AND BCA_NIVBLQ = 'U' "   //Nivel de Usuario
		cSQL += " AND BCA.D_E_L_E_T_ = ' ' "
		cSQL += " ORDER BY R_E_C_N_O_ DESC "
		PLsQuery(cSql,"TMPBCA")
		
		If !TMPBCA->(EOF())
			dData := TmpBCA->BCA_DATA
		EndIf
		
		cSql := "SELECT R_E_C_N_O_ AS BA3RECNO, BA3.* FROM "+RetSqlName("BA3")+" BA3 "
		cSql += " WHERE BA3_FILIAL = '"+xFilial("BA3")+"' "
		cSql += " AND BA3_CODINT = '"+Trb->BA1_CODINT+"'"
		cSql += " AND BA3_CODEMP = '"+Trb->BA1_CODEMP+"'"
		cSql += " AND BA3_CONEMP = '"+Trb->BA1_CONEMP+"'"
		cSql += " AND BA3_VERCON = '001' "
		cSql += " AND BA3_SUBCON = '"+Trb->BA1_SUBCON+"' "
		cSql += " AND BA3_VERSUB = '001' "
		cSql += " AND BA3_MATRIC = '"+Trb->BA1_MATRIC+"' "
		cSql += " AND BA3_DATBLO <> ' ' "
		cSql += " AND BA3.D_E_L_E_T_ = ' ' "
		PLsQuery(cSql,"TMPBA3")
		
		While !TMPBA3->(EOF())
			BA1->(dbgoto(TRB->BA1RECNO))
			
			BA3->(dbgoto(TMPBA3->BA3RECNO))

			dDatBlo := BA3->BA3_DATBLO
			
			aadd(aOk,{BA3->BA3_CODINT,BA3->BA3_CODEMP,BA3->BA3_MATRIC,BA3->BA3_CONEMP,BA3->BA3_SUBCON,BA3->BA3_DATBLO,BA3->(RECNO()),BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_NOMUSR,BA1->BA1_CONEMP,BA1->BA1_SUBCON,TRB->BA1RECNO,dData})
			
			cCpo :=	BA3->BA3_CODINT+";"+BA3->BA3_CODEMP+";"+BA3->BA3_MATRIC+";"+BA3->BA3_CONEMP+";"+BA3->BA3_SUBCON+";"+DtoC(BA3->BA3_DATBLO)+";"+strzero(TmpBA3->BA3RECNO,12,0)+";"+strzero(BA3->(RECNO()),12,0)+";"+BA1->BA1_CODINT+";"+BA1->BA1_CODEMP+";"+BA1->BA1_MATRIC+";"+BA1->BA1_TIPREG+";"+BA1->BA1_DIGITO+";"+BA1->BA1_CONEMP+";"+BA1->BA1_SUBCON+";"+strzero(BA1->(Recno()),12,0)+";"+DtoC(dData)

			If lGrava               

//				BA3->(dbgoto(BA3RECNO))
				BA3->(RecLock("BA3",.F.))
				BA3->BA3_MOTBLO	:=	Space(03)
				BA3->BA3_DATBLO	:=	CtoD("  /  /    ")
				BA3->(MsUnlock())
				
				BC3->(Reclock("BC3",.T.))
				BC3->BC3_FILIAL := xFilial("BC3")
				BC3->BC3_MATRIC := TmpBA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
				//				BC3->BC3_TIPREG := "00"
				BC3->BC3_TIPO   := "1"
				BC3->BC3_DATA   := dDatBlo      //dData
				BC3->BC3_MOTBLO := "022"
				BC3->BC3_OBS    := "Desbloqueado pela rotina CABP002"
				BC3->BC3_BLOFAT := "0"
				BC3->BC3_NIVBLQ := "F"
				BC3->BC3_USUOPE := cUserName
				BC3->(MsUnlock())
			EndIf
			
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENวรO! NรO FOI POSSIVEL GRAVAR CORRETAMENTE O REGISTRO! OPERAวรO ABORTADA!")
				Return
			Endif
			
			TMPBA3->(DbSkip())
		EndDo
		TMPBCA->(DbCloseArea())
		TMPBA3->(DbCloseArea())
		
		Trb->(DbSkip())
	Enddo
	U_Fecha_TXT()
	TRB->(DbCloseArea())
EndIf

MsgAlert("Rotina de ajuste finalizada!")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaNovoParSX1บAutor  ณJean Schulz     บ Data ณ  10/14/05   บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros do relatorio.                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CriaParSX()

PutSx1(cPerg,"01",OemToAnsi("Ano/Mes Origem")  			,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Ano/Mes Destino") 			,"","","mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("C๓d. Lancto:")   		  	,"","","mv_ch3","C",03,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("A็ใo:")					,"","","mv_ch4","C",01,0,0,"C","","","","","mv_par04","Analisa","","","","Modifica","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Grupo Cobranca:")			,"","","mv_ch5","C",04,0,0,"G","","BR0","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})

Return
