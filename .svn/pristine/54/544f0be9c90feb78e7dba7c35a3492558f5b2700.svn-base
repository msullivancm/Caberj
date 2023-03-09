#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO3     º Autor ³ AP6 IDE            º Data ³  12/09/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR009
	Local cInd
	Local cDesc1	:= "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2	:= "log de alteração de titulos do contas a receber.    "
	Local cDesc3	:= ""
	Local cPict		:= ""
	Local titulo	:= "Log de Alteração de Títulos do Contas a Receber"
	Local nLin		:= 80
	Local Cabec1	:= "  Data      Hora    Título            Campo         Vlr Antigo    Vlr Novo  Usuário          Histórico"
	Local Cabec2	:= ""
	Local imprime	:= .T.
	Local aOrd		:= {}
    Local aSx1		:= {}
    
	Private cString		:= "SXP"
	Private cAlias		:= "SE1"
	Private cPerg		:= "CBR009"
	Private lEnd		:= .F.
	Private lAbortPrint	:= .F.
	Private CbTxt		:= ""
	Private limite		:= 132
	Private tamanho		:= "M"
	Private nomeprog	:= "CABR009"
	Private nTipo		:= 18
	Private aReturn		:= { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
	Private nLastKey	:= 0
	Private cbtxt		:= Space(10)
	Private cbcont		:= 00
	Private CONTFL		:= 01
	Private m_pag		:= 01
	Private wnrel		:= "CABR009"

	Aadd(aSx1,{"GRUPO", "ORDEM" , "PERGUNT"              , "VARIAVL" , "TIPO" , "TAMANHO" , "DECIMAL","GSC","VALID", "VAR01"   ,"F3" ,"GRPSXG","DEF01"  ,"DEF02"    ,"DEF03"    ,"DEF04","DEF05"})
	Aadd(aSx1,{ cPerg , "01"    , "Alteracao De        " , "mv_ch1"  , "D"    , 8         , 0        ,"G"  ,""     , "mv_par01",""   ,""      ,""       ,""         ,""         ,""     ,""     })
	Aadd(aSx1,{ cPerg , "02"    , "Alteracao Ate       " , "mv_ch2"  , "D"    , 8         , 0        ,"G"  ,""     , "mv_par02",""   ,""      ,""       ,""         ,""         ,""     ,""     })
	Aadd(aSx1,{ cPerg , "03"    , "Prefixo De          " , "mv_ch3"  , "C"    , 3         , 0        ,"G"  ,""     , "mv_par03",""   ,""      ,""       ,""         ,""         ,""     ,""     })
	Aadd(aSx1,{ cPerg , "04"    , "Prefixo Ate         " , "mv_ch4"  , "C"    , 3         , 0        ,"G"  ,""     , "mv_par04",""   ,""      ,""       ,""         ,""         ,""     ,""     })
	Aadd(aSx1,{ cPerg , "05"    , "Titulo De           " , "mv_ch5"  , "C"    , 6         , 0        ,"G"  ,""     , "mv_par05",""   ,""      ,""       ,""         ,""         ,""     ,""     })
	Aadd(aSx1,{ cPerg , "06"    , "Titulo Ate          " , "mv_ch6"  , "C"    , 6         , 0        ,"G"  ,""     , "mv_par06",""   ,""      ,""       ,""         ,""         ,""     ,""     })


	fCriaSX1(cPerg,aSx1)	

	Pergunte(cPerg, .F.)

	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.F.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return


//**************************************************
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
//**************************************************

	Local nOrdem

	cInd := CriaTrab(NIL,.F.)
	
	cFiltro :=       'XP_ALIAS == "' + cAlias + '" '
	cFiltro += '.And. Dtos(XP_DATA) >= "' + Dtos(mv_par01) + '" '
	cFiltro += '.And. Dtos(XP_DATA) <= "' + Dtos(mv_par02) + '" '
	cFiltro += '.And. SubStr(XP_UNICO, 1, 2) == "' + xFilial(cAlias) + '" '

	cFiltro += '.And. SubStr(XP_UNICO, 3, 3) >= "' + mv_par03 + '" '
	cFiltro += '.And. SubStr(XP_UNICO, 3, 3) <= "' + mv_par04 + '" '
	cFiltro += '.And. SubStr(XP_UNICO, 6, 6) >= "' + mv_par05 + '" '
	cFiltro += '.And. SubStr(XP_UNICO, 6, 6) <= "' + mv_par06 + '" '

	dbSelectArea("SXP")
	IndRegua(cString,cInd,"XP_ALIAS+Dtos(XP_DATA)+XP_TIME",,cFiltro,"Selecionando Registros...")

	dbSelectArea(cString)
	(cString)->(dbSetOrder(1))

	SetRegua(RecCount())

	(cString)->(dbGoTop())
	
	While !EOF()

		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		If nLin > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif

		dbSelectArea("SX3")
		dbSetOrder(2)
		dbSeek(SXP->XP_CAMPO)
		
		dbSelectArea("SXP")

		@nLin, 00 pSay Dtoc(SXP->XP_DATA)
		@nLin, 10 pSay SXP->XP_TIME
		
		@nLin, 20 pSay SubStr(SXP->XP_UNICO,  3, 3) + "-" + SubStr(SXP->XP_UNICO,  6, 6) + "-" +;
		               SubStr(SXP->XP_UNICO, 12, 1) + "-" + SubStr(SXP->XP_UNICO, 13, 3)

		@nLin, 38 pSay SX3->X3_TITULO

		@nLin, 52 pSay Val(SXP->XP_ANTVAL) Picture "@E 999,999.99"
		@nLin, 64 pSay Val(SXP->XP_NOVVAL) Picture "@E 999,999.99"

		@nLin, 76 pSay XP_USER

		@nLin, 93 pSay Posicione("SE1", 1, SXP->XP_UNICO, "E1_HIST")

//           1         2         3         4         5         6         7         8         9         10
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//   Data      Hora    Título            Campo         Vlr Antigo    Vlr Novo  Usuário          Histórico
// 99/99/99  99:99:99  999 999999 A 999  xxxxxxxxxxxx  999,999.99  999,999.99  xxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxx

		nLin++

		(cString)->(dbSkip())
	EndDo

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return


//****************************************
Static Function fCriaSx1(cPerg,aSx1,lExcl)
//****************************************
	Local nLin,nCol,cCampo
	lExcl := If(lExcl==Nil, .F., lExcl)

	SX1->(dbSetOrder(1))

	If !lExcl.And.SX1->(DbSeek(cPerg+aSx1[Len(aSx1),2]))
		Return
	EndIf

	SX1->(DbSeek(cPerg))
	While !SX1->(Eof()) .And. Alltrim(SX1->X1_GRUPO) == cPerg
		SX1->(RecLock("SX1",.F.,.F.))
		SX1->(DbDelete())
		SX1->(MsUnLock())
		SX1->(DbSkip())
	End

	For nLin := 2 To Len(aSX1)
		SX1->(RecLock("SX1",.T.))
		For nCol := 1 To Len(aSX1[1])
			cCampo := "X1_"+aSX1[1,nCol]
			SX1->(FieldPut(SX1->(FieldPos(cCampo)),aSx1[nLin,nCol] ))
		Next nCol
		SX1->(MsUnLock())
	Next nLin

Return