#include "PLSMGER.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSR038 ³ Autor ³ Eduardo Motta          ³ Data ³ 22.04.04 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio de Carteirinhas                                  ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSR038()                                                  ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLSR038_NOVO(cMv_par01,cMv_par02,cMv_par03,cMv_par04,cMv_par05,cMv_par06,cMv_par07,cMv_par08,;
				 cMv_par09,cMv_par10,cMv_par11,cMv_par12,cMv_par13,cMv_par14)

Private nQtdLin     := 55
Private cNomeProg   := "PLSR038"
Private nLimite     := 132
Private cTamanho    := "G"
Private cTitulo     := "Carteirinhas"
Private cDesc1      := "Carteirinhas"
Private cDesc2      := ""
Private cDesc3      := ""
Private cAlias      := "BDH"
Private cPerg       := "PLR038"
Private cRel        := "PLSR038"
Private nLi         := nQtdLin+1
Private m_pag       := 1
Private lCompres    := .F.
Private lDicion     := .F.
Private lFiltro     := .T.
Private lCrystal    := .F.
Private aOrderns    := {}
Private aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private lAbortPrint := .F.
Private cCabec1 	:= ""
Private cCabec2 	:= ""
Private dData1
Private dData2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta perguntas                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1() //nova pergunta...
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessa parametros do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe parametros padroes...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cMv_par01 # Nil
	mv_par01 := cMv_par01
	mv_par02 := cMv_par02
	mv_par03 := Iif(!Empty(cMv_par03), cMv_par03, cTod('31/12/99'))
	mv_par04 := cMv_par04
	mv_par05 := Iif(!Empty(cMv_par05), cMv_par05, Replicate('Z', len(BDE->BDE_EMPATE)) )
	mv_par06 := cMv_par06   
	mv_par07 := Iif(!Empty(cMv_par07), cMv_par07, Replicate('Z', len(BDE->BDE_CONATE)) )
	mv_par08 := cMv_par08   
	mv_par09 := Iif(!Empty(cMv_par09), cMv_par09, Replicate('Z', len(BDE->BDE_SUBATE)) )   
	mv_par10 := Subs(cMv_par10,1,6)
	mv_par11 := Iif(!Empty(cMv_par11), Subs(cMv_par11,1,6), Replicate('Z', len(Subs(BDE->BDE_MATATE,1,6))) )      
	mv_par12 := cMv_par12
	mv_par13 := cMv_par13   
	mv_par14 := cMv_par14   
	mv_par15 := 2  // pergunta nova para indicar se salta pagina a cada subcontrato - 1=Sim   2=Nao
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrderns,lCompres,cTamanho,{},lFiltro,lCrystal)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valida SX1...			                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR13==2
	If !(MV_PAR14 >= 1 .and. MV_PAR14 <= 3)
		MsgStop("Número de colunas deve ser entre 1 e 3")
		Return
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey  == 27
   Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite relat¢rio                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsAguarde({|| R038Imp() }, cTitulo, "", .T.)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R038Imp  ³ Autor ³ Eduardo Motta         ³ Data ³ 22.04.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Emite relatorio de Carteirinhas Emitidas                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function R038Imp()

Local cLinha	:= ""
Local cDesCom	:= ""
Local cDesPer1	:= ""
Local cDesPer2	:= ""
Local cSql		:= ""
Local cArqTmp	:= ""
Local cIndTmp	:= ""
Local cEmpAnt	:= ""
Local cEstCob   := ""
Local nCont		:= 0
Local nI		:= 0
Local nPos		:= 0
Local nTotal	:= 0
Local nJ		:= 0
Local nTotLin	:= 0
Local nLin		:= 0
Local aResp		:= {}
Local aLin		:= {}
Local aResumo	:= {}
Local cConAnt   := ""
Local cSubAnt   := ""
Local nTotSub   := 0
Local aStru := {{"TMP_CODUSR","C",20,0},;
                 {"TMP_NOMUSR","C",40,0},;
                 {"TMP_CODEMP","C",04,0},;
                 {"TMP_NOMEMP","C",40,0},;
                 {"TMP_CONEMP","C",12,0},;
                 {"TMP_VERCON","C",03,0},;
                 {"TMP_SUBCON","C",09,0},;
                 {"TMP_VERSUB","C",03,0},;
                 {"TMP_VIA","N",02,0},;
                 {"TMP_LOTE","C",12,0},;
                 {"TMP_DATVAL","D",08,0},;
                 {"TMP_DATNAS","D",08,0},;
                 {"TMP_BA1REC","N",12,0},;
                 {"TMP_DATSOL","D",08,0},;
                 {"TMP_ESTCOB","C",01,0}}
Local	cNomTit := space(40)

cArqTmp := CriaTrab(aStru,.t.)
cIndTmp := CriaTrab(NIL,.f.)

DbUseArea(.t.,nil,cArqTmp,"TMP",.F.)
Index On TMP_CODEMP+TMP_CONEMP+TMP_VERCON+TMP_SUBCON+TMP_VERSUB+TMP_CODUSR To &cIndTmp

If mv_par13==1
	cCabec1 := "Codigo do Usuario   Nome do Usuario                          Nome Titular                              Nascimento  Validade   Dt.Solic.  Lote         Via  Estado da Cobranca"
	cCabec2 := ""
Else
	cCabec1 := ""
	cCabec2 := ""
EndIf

cSQL := " SELECT BED_CDIDEN, BED_FILIAL, BED_CODINT, BED_CODEMP, BED_MATRIC, BED_CONEMP, BED_VERCON, BED_SUBCON, "
cSQL += 	   " BED_VERSUB, BED_DATVAL, BED_NOMUSR, BED_VIACAR, BED_DATVAL, BED_DTSOLI, R_E_C_N_O_ "
cSQL += " FROM " + RetSQLName("BED")
cSQL += " WHERE BED_FILIAL = '" + xFilial("BED") + "' AND "
cSQL += 	  " BED_CODINT = '" + MV_PAR01 + "'"
If !Empty(MV_PAR02) .and. !Empty(MV_PAR03)
   cSQL += 	  " AND BED_DATVAL >= '" + DtoS(MV_PAR02)+	"' AND BED_DATVAL <= '"+DtoS(MV_PAR03)+"'"
EndIf
cSQL += 	  " AND BED_CODEMP >= '"+MV_PAR04+	"' AND BED_CODEMP <= '"+MV_PAR05+"'"
cSQL += 	  " AND BED_CONEMP >= '"+mv_par06+	"' AND BED_CONEMP <= '"+mv_par07+"'"
cSQL += 	  " AND BED_SUBCON >= '"+mv_par08+	"' AND BED_SUBCON <= '"+mv_par09+"'"
cSQL += 	  " AND BED_MATRIC >= '"+mv_par10+	"' AND BED_MATRIC <= '"+mv_par11+"'"

If !Empty(mv_par12)
   cSQL += " AND BED_CDIDEN = '"+mv_par12+"'"
EndIf   

cSQL += " AND D_E_L_E_T_ <> '*' "

If Select("BEDTRB") > 0
   BEDTRB->(DbCloseArea())
EndIf

PLSQuery(cSQL,"BEDTRB")

BQC->(DbSetorder(1))
BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))

While BEDTRB->(!Eof())

	BED->(DbGoto(BEDTRB->R_E_C_N_O_))

	BA1->(DbSeek(xFilial("BA1")+BED->(BED_CODINT+BED_CODEMP+BED_MATRIC+BED_TIPREG+BED_DIGITO)))
	BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
	BQC->(DbSeek(xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))

	TMP->(RecLock("TMP",.T.))
	TMP->TMP_CODUSR := BED->(BED_CODINT+BED_CODEMP+BED_MATRIC+BED_TIPREG+BED_DIGITO)
	TMP->TMP_NOMUSR := BA1->BA1_NOMUSR
	
	If Empty(BED->BED_CODEMP)
		TMP->TMP_CODEMP := "0000"
		TMP->TMP_NOMEMP := "PESSOA FISICA"
	Else
		TMP->TMP_CODEMP := BED->BED_CODEMP
		TMP->TMP_NOMEMP := BQC->BQC_DESCRI
	EndIf

	TMP->TMP_CONEMP := BA3->BA3_CONEMP
	TMP->TMP_VERCON := BA3->BA3_VERCON
	TMP->TMP_SUBCON := BA3->BA3_SUBCON
	TMP->TMP_VERSUB := BA3->BA3_VERSUB
	TMP->TMP_VIA    := BED->BED_VIACAR
	TMP->TMP_DATVAL := BED->BED_DATVAL
	TMP->TMP_DATSOL := BED->BED_DTSOLI
	TMP->TMP_LOTE   := BED->BED_CDIDEN
	TMP->TMP_DATNAS := BA1->BA1_DATNAS
	TMP->TMP_BA1REC := BA1->(Recno())
	TMP->TMP_ESTCOB := BED->BED_FATUR
	TMP->(MsUnlock())
	
	BEDTRB->(DbSkip())
EndDo

BEDTRB->(DbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho do relatorio...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par13 == 1

	cEmpAnt := "xxxxxxxxxxxxxxxxxxx"
	
	TMP->(DbGoTop())
	
	cFamAnt := Substr(TMP->TMP_CODUSR,1,14)
	
	While !TMP->(Eof())
		cNomTit := space(40)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o cancelamento pelo usuario...                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			@nLi,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		If cEmpAnt <> TMP->TMP_CODEMP
			nLi := nQtdLin+10
			R038Pag()
			If TMP->TMP_CODEMP <> "0000"
				@ ++nLi, 00 pSay "Empresa : "+TMP->TMP_CODEMP+" "+TMP->TMP_NOMEMP
			Else
				@ ++nLi, 00 pSay TMP->TMP_NOMEMP
			EndIf   
			nLi++
			cEmpAnt := TMP->TMP_CODEMP
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Conforme solicitado pelo usuario, imprimir linha a cada familia.    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cFamAnt <> Substr(TMP->TMP_CODUSR,1,14)
			@ ++nLi, 00 pSay Replicate("-",50)
			cFamAnt := Substr(TMP->TMP_CODUSR,1,14)
			nLi++
		Endif
		
		nPos := aScan(aResumo,{|x|x[1]==TMP->TMP_CODEMP} )
		
		If nPos == 0
			aadd(aResumo,{TMP->TMP_CODEMP,TMP->TMP_NOMEMP,0} )
			nPos := Len(aResumo)
		EndIf   
		
		Do Case
			Case TMP->TMP_ESTCOB == "0"
				cEstCob := "Nao Faturado"
			Case TMP->TMP_ESTCOB == "1"
				cEstCob := "Faturado"
			Case TMP->TMP_ESTCOB == "2"
				cEstCob := "Titulo em Aberto"
			Case TMP->TMP_ESTCOB == "3"
				cEstCob := "Titulo Baixado"
			Otherwise
				cEstCob := ""
		EndCase
		
		aResumo[nPos,3]++
		R038Pag()
	
		BA1->(DbSeek(xFilial("BA1")+SubStr(TMP->TMP_CODUSR,1,14)+"00"))
		
		cNomTit := BA1->BA1_NOMUSR
		
		@ ++nLi, 00 pSay TMP->TMP_CODUSR+PadR(TMP->TMP_NOMUSR,40)+"  "+PadR(cNomTit,40)+"  "+mDtoC(TMP->TMP_DATNAS)+"  "+mDtoC(TMP->TMP_DATVAL)+"  "+mDtoC(TMP->TMP_DATSOL)+"  "+TMP->TMP_LOTE+"  "+StrZero(TMP->TMP_VIA,2)+"  "+cEstCob
      cConAnt   := TMP->TMP_CONEMP
      cSubAnt   := TMP->TMP_SUBCON
      nTotSub++
		TMP->(DbSkip())
		If cEmpAnt # TMP->TMP_CODEMP .OR. cConAnt # TMP->TMP_CONEMP .or. cSubAnt # TMP->TMP_SUBCON
           @ ++nLi, 00 pSay Space(20)+"Total de carteirinhas emitidas deste SubContrato  ("+cConAnt+"/"+cSubAnt+") => "+Str(nTotSub,4)
           If  mv_par15 == 1
               nLi := 99
           Else
               nLi++
           Endif
		   nTotSub := 0
		EndIf
	EndDo

    nLi := nQtdLin+10
    cCabec1 := Space(40)+PadC("Total de carteirinhas emitidas por empresa",50)
    cCabec2 := ""
    nTotal := 0

   For nI := 1 to Len(aResumo)
      R038Pag()
      @ ++nLi, 00 pSay Space(40)+aResumo[nI,1]+" "+aResumo[nI,2]+" "+Str(aResumo[nI,3],4)
      nTotal+=aResumo[nI,3]
   Next

   nLi++
   R038Pag()
   @ ++nLi, 00 pSay Space(40)+PadR("       Total de carteirinhas emitidas ",46)+Str(nTotal,4)

Else

	TMP->(DbGoTop())

	While !TMP->(Eof())

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o cancelamento pelo usuario...                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o Corpo do Boleto										   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ColIni := 0
		nI := 1
		nJ := 0
		aLin := Array(5,mv_par14)

		While nI <= mv_par14
		
			BA1->(DbGoto(TMP->TMP_BA1REC))
		
			aLin[1,nI]:= Substr(("CODIGO : " +BA1->BA1_CODINT+"-"+BA1->BA1_CODEMP+"-"+BA1->BA1_MATRIC+"-"+BA1->BA1_TIPREG),1,42)
			aLin[2,nI]:= Substr(BA1->BA1_NOMUSR,1,42)
			aLin[3,nI]:= Substr(Alltrim(BA1->BA1_ENDERE)+",",1,36)+BA1->BA1_NR_END
			aLin[4,nI]:= Substr(AllTrim(BA1->BA1_BAIRRO)+" - "+ AllTrim(BA1->BA1_MUNICI),1,42)
			aLin[5,nI]:= Substr(BA1->BA1_ESTADO+"  CEP:"+Subst(BA1->BA1_CEPUSR,1,5)+"-"+Subst(BA1->BA1_CEPUSR,6,3),1,42)
			
			TMP->(DbSkip())
			
			nI += 1
			If TMP->(Eof())
				nI := mv_par14 + 1
			Endif
			
		EndDo

		nI:= 0
		
		For nJ := 1 to 5
			For nI := 1 TO mv_par14
				ColIni := (nI-1) * 73
				@ nLin,ColIni PSAY aLin[nJ,nI]
			Next
			nLin += 1
		Next
		nLin += 1
		
		If nTotLin = 10
			nTotLin := 0
			eject
		Else
			nTotLin++
		Endif
		
	EndDo
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(cRel)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim do Relat¢rio                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TMP->(DbCloseArea())
FErase(cArqTmp)
FErase(cIndTmp)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ R038Pag  ³ Autor ³   Eduardo Motta       ³ Data ³ 20.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Avanca pagina caso necessario...                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function R038Pag()

If nLi > nQtdLin
	nLi := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
Endif   

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ mDtoc    ³ Autor ³   Microsiga	         ³ Data ³ 		   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Retorna data no formato caracter com Ano com 4 digitos     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function mDtoC(dData)
Local cData := SubStr(DtoC(dData),1,6)
cData += SubStr(DtoS(dData),1,4)
Return cData

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ Plsr038Vld ³ Autor ³ Microsiga	           ³ Data ³ 		 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao de validacao para pergunte.                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
Static Function Plsr038Vld()

If Vazio()
   Return .T.
EndIf
If mv_par12="AVULSA"
   Return .T.
EndIf


Return ExistCpo("BDE",PlsIntPad()+mv_par12)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Angelo Sperandio     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/

Static Function CriaSX1()

LOCAL aRegs	 :=	{}

aadd(aRegs,{cPerg,"15","Salta Pag. Subcontrato?","","","mv_chh","N", 1,0,2,"C","","mv_par15","Sim"         ,"","","","","Nao"            ,"","","","",""               ,"","","","",""       			  ,"","","","","","","","",""   	,""})
		                                                                                                                                                                   
PlsVldPerg( aRegs )
    
Return
