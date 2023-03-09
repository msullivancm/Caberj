#Include "PROTHEUS.CH"
#include "TBICONN.CH"
#include "topconn.ch"
#INCLUDE 'UTILIDADES.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO2     ºAutor  ³Marcela Coimbra     º Data ³  16/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina generica para geração de pedido e Nota fiscal       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function TMP850

	Private c_EOL		:= "CHR(13)+CHR(10)"
	Private c_Mesnagem  := ""

	If Empty(c_EOL)
		c_EOL := CHR(13)+CHR(10)
	Else
		c_EOL := Trim(c_EOL)
		c_EOL := &c_EOL
	Endif

	u_CABA112A()

Return

User Function CABA112A()

	Private oBtPesquisar:= Nil
	Private oButton1	:= Nil
	Private oButton2	:= Nil
	Private oButton3	:= Nil
	Private oButton4	:= Nil
	Private oButton5	:= Nil
	Private oButton6	:= Nil
	Private oButton7	:= Nil
	Private oButton8	:= Nil
	Private oButton9	:= Nil
	Private oButtona	:= Nil
	Private oButtonb	:= Nil
	Private oButtonc	:= Nil
	Private oButtond	:= Nil
	Private oButtone	:= Nil
	Private o_NFGEradas	:= Nil
	Private o_NFTrans	:= Nil
	Private o_NFRec		:= Nil
	Private o_TitSNF	:= Nil
	Private o_ExNaoTra	:= Nil
	Private o_Rio		:= Nil
	Private o_Niteroi	:= Nil
	Private oGet7		:= Nil
	Private oGroup1		:= Nil
	Private oGroup2		:= Nil
	Private oGroup3		:= Nil
	Private oGroup4		:= Nil
	Private oGtBord		:= Nil
	Private oGtCliente	:= Nil
	Private oGtEmAte	:= Nil
	Private oGtEmDe		:= Nil
	Private oGtEmpAte	:= Nil
	Private oGtEmpDe	:= Nil
	Private oGtTitAte	:= Nil
	Private oGtTitDe	:= Nil
	Private oGtVenAte	:= Nil
	Private oGtVencDe	:= Nil
	Private oSay1		:= Nil
	Private oSay10		:= Nil
	Private oSay2		:= Nil
	Private oSay3		:= Nil
	Private oSay4		:= Nil
	Private oSay5		:= Nil
	Private oSay6		:= Nil
	Private oSay7		:= Nil
	Private oSay8		:= Nil
	Private oSay9		:= Nil
	Private oGtCompet	:= Nil
	Private cGtCliente 	:= space(6)
	Private cGtEmpAte 	:= space(4)
	Private cGtEmpDe 	:= space(4)
	Private cGtTitAte 	:= space(9)
	Private cGtTitDe 	:= space(9)
	Private dGtBord 	:= Space(6)
	Private cGtEmAte 	:= CTOD("  /  /    ")
	Private dGtEmDe 	:= CTOD("  /  /    ")
	Private dGtVenAte 	:= CTOD("  /  /    ")
	Private dGtVencDe 	:= CTOD("  /  /    ")
	Private cGtCompet	:= Space(6)
	Private l_NFGEradas := .F.
	Private l_NFTrans	:= .F.
	Private l_NFRec		:= .F.
	Private l_TitSNF	:= .T.
	Private l_ExNaoTra	:= .F.
	Private l_Rio		:= .T.
	Private l_Niteroi	:= .T.
	Private a_Pesquisa	:= {}
	Private oFolder1	:= Nil
	Private oBrRio		:= Nil
	Private oBrNF		:= Nil
	Private aBrRio 		:= {}
	Private oNo         := LoadBitMap(GetResources(),"LBNO")
	Private cCampoOk   	:= "XOK"
	Private c_AliasTmp  := "QRYPESQ"// GetNextAlias()//
	Private c_AliasNF  	:= "QRYPENF"//GetNextAlias()//
	Private cAliasInd  	:= "u_"+c_AliasTmp
	Private cAlIndNF  	:= "u_"+c_AliasNF
	Private aCampos		:= {}
	Private aStruct		:= {}
	Private cChave      := "E1_NUM"
	Private aCamNF		:= {}
	Private aStrNF		:= {}
	Private oOk        	:= LoadBitMap(GetResources() , "LBOK_OCEAN" )
	Private onOk       	:= LoadBitMap(GetResources() , "LBNO_OCEAN" )
	Private nTotReg    	:= 0
	Private nTotVlr    	:= 0
	Private oBranco		:= LoadBitMap(GetResources(),"BR_BRANCO"	)
	Private oVerde   	:= LoadBitMap(GetResources(),"BR_VERDE"		)
	Private oAzul		:= LoadBitMap(GetResources(),"BR_AZUL"		)
	Private oCinza   	:= LoadBitMap(GetResources(),"BR_CINZA"		)
	Private oPreto   	:= LoadBitMap(GetResources(),"BR_PRETO"		)
	Private oAmarelo    := LoadBitMap(GetResources(),"BR_AMARELO"	)

	Define FONT oFont1 	NAME "Arial" SIZE 0,20  Bold

	// Cria estrutura da tela de filtro
	fStrTit()

	// Cria estrutura da tela de NOTAS
	fStrNF()

	Static oDlg

	DEFINE MSDIALOG oDlg TITLE "Emissão de Nota Fiscal" FROM 000, 000  TO 500, 1100 COLORS 0, 16777215 PIXEL

	@ 005, 008 GROUP oGroup1 TO 045, 547 OF oDlg COLOR 0, 16777215 PIXEL

	@ 012, 012 SAY oSay1 PROMPT "Emissão de:" 				SIZE 033, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 012, 057 SAY oSay2 PROMPT "Emissão até:" 				SIZE 032, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 012 MSGET oGtEmDe 	VAR dGtEmDe 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 057 MSGET oGtEmAte 	VAR cGtEmAte 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL

	@ 012, 102 SAY oSay3 PROMPT "Empresa de:" 				SIZE 031, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 012, 147 SAY oSay4 PROMPT "Empresa até:" 				SIZE 034, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 102 MSGET oGtEmpDe 	VAR cGtEmpDe 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 147 MSGET oGtEmpAte 	VAR cGtEmpAte 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL

	@ 012, 192 SAY oSay5 PROMPT "Cliente:" 					SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 192 MSGET oGtCliente VAR cGtCliente 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL

	@ 012, 237 SAY oSay6 PROMPT "Título de: " 				SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 012, 282 SAY oSay7 PROMPT "Título até:" 				SIZE 028, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 237 MSGET oGtTitDe 	VAR cGtTitDe 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 282 MSGET oGtTitAte 	VAR cGtTitAte 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL

	@ 012, 327 SAY oSay8 PROMPT "Borderô" 					SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 326 MSGET oGtBord 	VAR dGtBord 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL

	@ 012, 372 SAY oSay9 PROMPT "Vencimento de:" 			SIZE 042, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 012, 417 SAY oSay10 PROMPT "Vencimento até:" 			SIZE 042, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 372 MSGET oGtVencDe 	VAR dGtVencDe 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 417 MSGET oGtVenAte 	VAR dGtVenAte 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL

	@ 012, 462 SAY oSay10 PROMPT "Competência(Ano Mês):" 	SIZE 070, 007 OF oDlg COLORS 0, 16777215 PIXEL
	@ 023, 462 MSGET oGtCompet 	VAR cGtCompet 				SIZE 040, 010 OF oDlg COLORS 0, 16777215 PIXEL

	@ 023, 505 BUTTON oBtPesquisar PROMPT "&Pesquisar" 		SIZE 037, 012 OF oDlg PIXEL ACTION { || BPesquisa(), bPesqnf() }

	@ 047, 007 FOLDER oFolder1 SIZE 541, 278 OF oDlg ITEMS "Títulos","Notas Geradas" COLORS 0, 16777215 PIXEL

	fBrRio2()

	@ 004, 10 CHECKBOX o_Rio 		VAR l_Rio PROMPT "Rio" 			SIZE 053, 008 FONT oFont1 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL //
	@ 004, 40 CHECKBOX o_Niteroi 	VAR l_Niteroi PROMPT "Niteroi" 	SIZE 053, 008 FONT oFont1 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL

	@ 023, 443 CHECKBOX o_TitSNF 	VAR l_TitSNF PROMPT "Títulos sem nota" 	SIZE 053, 008 OF oFolder1:aDialogs[1] COLORS 0, 16777215 PIXEL

	@ 102, 444 BUTTON oButton1 PROMPT "Filtrar" SIZE 037, 012 OF oFolder1:aDialogs[1] PIXEL ACTION BPesquisa()

	@ 136, 438 GROUP oGroup4 TO 259, 534 OF oFolder1:aDialogs[1] COLOR 0, 16777215 PIXEL
	@ 143, 443 BUTTON oButton4 PROMPT "Gerar Nota" SIZE 087, 012 OF oFolder1:aDialogs[1] PIXEL ACTION { || fbGerar(), bPesqnf(), BPesquisa() }

	fBrNF()

	@ 038, 443 CHECKBOX o_NFGEradas	VAR l_NFGEradas PROMPT "Notas Geradas" 		SIZE 053, 008 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
	@ 053, 443 CHECKBOX o_NFTrans 	VAR l_NFTrans 	PROMPT "Notas Transmitidas" SIZE 058, 008 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL
	@ 068, 443 CHECKBOX o_NFRec 	VAR l_NFRec 	PROMPT "Notas Recusadas" 	SIZE 055, 008 OF oFolder1:aDialogs[2] COLORS 0, 16777215 PIXEL

	@ 102, 444 BUTTON oButton8 PROMPT "Filtrar" SIZE 037, 012 OF oFolder1:aDialogs[2] PIXEL ACTION bPesqnf( l_NFGEradas, l_NFTrans, l_NFRec )
	@ 136, 438 GROUP oGroup4 TO 259, 534 OF oFolder1:aDialogs[2] COLOR 0, 16777215 PIXEL
	@ 143, 443 BUTTON oButton9 PROMPT "Excluir Notas Selecionadas" SIZE 087, 012 OF oFolder1:aDialogs[2] PIXEL Action fExcluiNf()

	@ 015, 002 GROUP oGroup2 TO 260, 432 OF oFolder1:aDialogs[1] COLOR 0, 16777215 PIXEL

	ACTIVATE MSDIALOG oDlg CENTERED

Return


Static Function fBrRio2()

	Local nIt 	:= 0

	DbSelectArea(c_AliasTmp)
	(c_AliasTmp)->(DbGoTop())

	oBrRio:=TcBrowse():New(020,005,425,150,,,,oFolder1:aDialogs[1],,,,,,,oDlg:oFont,,,,,.T.,c_AliasTmp,.T.,,.F.,,,.F.)

	For nIt := 1 To Len(aCampos)

		c2 := If(nIt == 1," ",aCampos[nIt,1])
		c3 := If(nIt == 1,&("{|| If(Empty("+c_AliasTmp+"->"+cCampoOk+"),onOk,oOk)}"),&("{||"+c_AliasTmp+"->"+aCampos[nIt,2]+"  }"))

		c4 := If(nIt == 1,5,CalcFieldSize(aCampos[nIt,3],aCampos[nIt,4],aCampos[nIt,5],"",aCampos[nIt,1]))
		c5 := If(nIt == 1,"",aCampos[nIt,6])
		c6 := If(nIt == 1,.T.,.F.)

		oBrRio:AddColumn(TCColumn():New(c2,c3,c5,,,"LEFT",c4,c6,.F.,,,,.F.))
		oBrRio:bLDblClick   := {|| fAtuBrw(c_AliasTmp,cCampoOk     )}

	Next

	oBrRio:bHeaderClick := {|| fAtuBrw(c_AliasTmp,cCampoOK,,.T.)}

Return


Static Function fAtuBrw(cTmpAlias,cCampoOk,cGet,lTodos)

	Local cMarca := " "

	SA1->(DbSetOrder(1))
	If lTodos <> Nil .And. lTodos
		(c_AliasTmp)->(DbGoTop())
		cMarca := If(Empty((c_AliasTmp)->&(cCampoOk)),"X","")
		While (c_AliasTmp)->(!Eof())
			(c_AliasTmp)->(RecLock(c_AliasTmp,.F.))
			(c_AliasTmp)->&(cCampoOk) := cMarca
			(c_AliasTmp)->(MsUnLock())
			If Empty((c_AliasTmp)->&(cCampoOk))
				nTotReg --
			Else
				nTotReg ++
			Endif
			(c_AliasTmp)->(DbSkip())
		End
		(cTmpAlias)->(DbGoTop())
	Else
		(c_AliasTmp)->(RecLock(c_AliasTmp,.F.))
		(c_AliasTmp)->&(cCampoOk) := If(Empty((c_AliasTmp)->&(cCampoOk)),"X","")
		(c_AliasTmp)->(MsUnLock())
		If Empty((c_AliasTmp)->&(cCampoOk))
			nTotReg --
		Else
			nTotReg ++
		Endif
	Endif

	oBrRio:Refresh()
	oDlg:Refresh()

Return(.T.)

Static Function bPesquisa()

	Local c_Qry 	:= " "
	Local ni		:= 0

	a_Pesquisa := {}

	c_Qry += "SELECT	" + c_EOL
	c_Qry += "    * 	" + c_EOL
	c_Qry += "FROM 		" + c_EOL
	c_Qry += "    ( 	" + c_EOL
	c_Qry += "        SELECT " + c_EOL
	c_Qry += "            DECODE(ST, NULL, 'B', ST) STATUS, " + c_EOL
	c_Qry += "            F.* 	" + c_EOL
	c_Qry += "        FROM 		" + c_EOL
	c_Qry += "            ( 	" + c_EOL
	c_Qry += "                SELECT " + c_EOL
	c_Qry += "                    DISTINCT ' ' XOK, " + c_EOL
	c_Qry += "                    DECODE( SE1.E1_XSTDOC, 'E', 'EMAIL EM BRANCO', 'G', 'GERADO', 'C', 'CANCELADO', ' ' ) POSIC, " + c_EOL
	c_Qry += "                    SA1.A1_COD_MUN,	" + c_EOL
	c_Qry += "                    (					" + c_EOL
	c_Qry += "                        SELECT 		" + c_EOL
	c_Qry += "                            DECODE(SF2.D_E_L_E_T_, '*', 'A', SF2.F2_FIMP)  " + c_EOL
	c_Qry += "                        FROM 				" + c_EOL
	c_Qry += "                            SF2010 SF2	" + c_EOL
	c_Qry += "                        WHERE 			" + c_EOL
	c_Qry += "                            SF2.F2_FILIAL       = SE1.E1_FILIAL	" + c_EOL
	c_Qry += "                            AND SF2.F2_SERIE    = SE1.E1_XSERNF 	" + c_EOL
	c_Qry += "                            AND SF2.F2_DOC      = SE1.E1_XDOCNF  	" + c_EOL
	c_Qry += "                            AND SF2.F2_CLIENTE  = SE1.E1_CLIENTE	" + c_EOL
	c_Qry += "                    ) ST ," + c_EOL
	c_Qry += "                    (		" + c_EOL
	c_Qry += "                        CASE " + c_EOL
	c_Qry += "                        WHEN INSTR(' ',SE1.E1_CODEMP) > 0 THEN 'NIT' 		" + c_EOL
	c_Qry += "                        WHEN INSTR(' ',SE1.E1_CODEMP) > 0 THEN 'RIO' 		" + c_EOL
	c_Qry += "                        ELSE DECODE(SA1.A1_COD_MUN,'04557','RIO','NIT')	" + c_EOL
	c_Qry += "                        END " + c_EOL
	c_Qry += "                    ) MUN,  " + c_EOL
	c_Qry += "                    SE1.E1_FILIAL,	" + c_EOL
	c_Qry += "                    SE1.E1_PREFIXO, 	" + c_EOL
	c_Qry += "                    SE1.E1_NUM, 		" + c_EOL
	c_Qry += "                    NVL((SE1.E1_VALOR - SE1_NCC.E1_VALOR), SE1.E1_VALOR) VALOR, " + c_EOL
	c_Qry += "                    SE1.E1_EMISSAO, 	" + c_EOL
	c_Qry += "                    SE1.E1_CLIENTE, 	" + c_EOL
	c_Qry += "                    SE1.E1_NOMCLI, 	" + c_EOL
	c_Qry += "                    SE1.E1_VENCREA, 	" + c_EOL
	c_Qry += "                    SE1.E1_NUMBOR, 	" + c_EOL
	c_Qry += "                    SE1.E1_XSERNF , 	" + c_EOL
	c_Qry += "                    SE1.E1_XDOCNF, 	" + c_EOL
	c_Qry += "                    SE1.E1_CODEMP, 	" + c_EOL
	c_Qry += "                    SE1.E1_PARCELA, 	" + c_EOL
	c_Qry += "                    SE1.E1_TIPO  		" + c_EOL
	c_Qry += "        FROM " + c_EOL
	c_Qry += "             " + RetSqlName("SE1") + "  SE1 	" + c_EOL
	c_Qry += "            									" + c_EOL
	c_Qry += "            INNER JOIN						" + c_EOL
	c_Qry += "                 " + RetSqlName("BA3") + " BA3" + c_EOL
	c_Qry += "            ON								" + c_EOL
	c_Qry += "                BA3.BA3_FILIAL = '" + xFilial("BA3") + "' " + c_EOL
	c_Qry += "                AND BA3.BA3_CODINT = SE1.E1_CODINT 	" + c_EOL
	c_Qry += "                AND BA3.BA3_CODEMP = SE1.E1_CODEMP 	" + c_EOL
	c_Qry += "                AND BA3.D_E_L_E_T_ = ' '				" + c_EOL
	c_Qry += "            											" + c_EOL
	c_Qry += "            INNER JOIN								" + c_EOL
	c_Qry += "                 " + RetSqlName("BQC") + " BQC		" + c_EOL
	c_Qry += "            ON										" + c_EOL
	c_Qry += "                BQC.BQC_FILIAL      = BA3.BA3_FILIAL	" + c_EOL
	c_Qry += "                AND BQC.BQC_CODIGO  = BA3.BA3_CODINT||BA3.BA3_CODEMP " + c_EOL
	c_Qry += "                AND BQC.BQC_NUMCON  = BA3.BA3_CONEMP	" + c_EOL
	c_Qry += "                AND BQC.BQC_VERCON  = BA3.BA3_VERCON	" + c_EOL
	c_Qry += "                AND BQC.BQC_SUBCON  = BA3.BA3_SUBCON	" + c_EOL
	c_Qry += "                AND BQC.BQC_VERSUB  = BA3.BA3_VERSUB	" + c_EOL
	c_Qry += "                AND BQC.D_E_L_E_T_  = ' '				" + c_EOL
	c_Qry += "            											" + c_EOL
	c_Qry += "            INNER JOIN 								" + c_EOL
	c_Qry += "                 " + RetSqlName("BM1") + " BM1  		" + c_EOL
	c_Qry += "            ON										" + c_EOL
	c_Qry += "                BM1.BM1_FILIAL      = '" + xFilial("BM1") + "' " + c_EOL
	c_Qry += "                AND BM1.BM1_PREFIX  = SE1.E1_PREFIXO 	" + c_EOL
	c_Qry += "                AND BM1.BM1_NUMTIT  = SE1.E1_NUM 		" + c_EOL
	c_Qry += "                AND BM1.BM1_PARCEL  = SE1.E1_PARCELA	" + c_EOL
	c_Qry += "                AND BM1.BM1_TIPTIT  = SE1.E1_TIPO		" + c_EOL
	c_Qry += "                AND BM1.BM1_CODINT  = SE1.E1_CODINT	" + c_EOL
	c_Qry += "                AND BM1.BM1_CODEMP  = SE1.E1_CODEMP   " + c_EOL
	c_Qry += "                AND BM1.D_E_L_E_T_ = ' ' 				" + c_EOL
	c_Qry += "            											" + c_EOL
	c_Qry += "            INNER JOIN								" + c_EOL
	c_Qry += "                 " + RetSqlName("SA1") + " SA1		" + c_EOL
	c_Qry += "            ON										" + c_EOL
	c_Qry += "                SA1.A1_FILIAL       = '" + xFilial("SA1") + "' " + c_EOL
	c_Qry += "                AND SA1.A1_COD      = SE1.E1_CLIENTE " + c_EOL
	c_Qry += "                AND SA1.A1_LOJA     = '01' 	" + c_EOL

	If l_Rio  .and. !l_Niteroi

		c_Qry += "                AND SA1.A1_COD_MUN = '04557' "  + c_EOL

	ElseIf !l_Rio  .and. l_Niteroi

		c_Qry += "                AND SA1.A1_COD_MUN <> '04557' "  + c_EOL

	EndIf

	c_Qry += "                AND SA1.D_E_L_E_T_  = ' '		" + c_EOL
	c_Qry += "            									" + c_EOL
	c_Qry += "            INNER JOIN            			" + c_EOL
	c_Qry += "                 " + RetSqlName("BDC") + " BDC" + c_EOL
	c_Qry += "            ON								" + c_EOL
	c_Qry += "                BDC.BDC_FILIAL      = '" + xFilial("BDC") + "' 	" + c_EOL
	c_Qry += "                AND BDC.BDC_CODOPE  = BM1.BM1_CODINT				" + c_EOL
	c_Qry += "                AND BDC.BDC_NUMERO  = SUBSTR(BM1.BM1_PLNUCO,5,LENGTH(BM1.BM1_PLNUCO)) " + c_EOL
	c_Qry += "                AND BDC.D_E_L_E_T_  = ' ' " + c_EOL
	c_Qry += "            								" + c_EOL
	c_Qry += "            LEFT JOIN                		" + c_EOL
	c_Qry += "                 " + RetSqlName("SE1") + " SE1_NCC 	" + c_EOL
	c_Qry += "            ON										" + c_EOL
	c_Qry += "                SE1_NCC.E1_FILIAL			= SE1.E1_FILIAL	" + c_EOL
	c_Qry += "                AND SE1_NCC.E1_PREFIXO 	= SE1.E1_PREFIXO" + c_EOL
	c_Qry += "                AND SE1_NCC.E1_NUM 		= SE1.E1_NUM    " + c_EOL
	c_Qry += "                AND SE1_NCC.E1_PARCELA 	= SE1.E1_PARCELA" + c_EOL
	c_Qry += "                AND SE1_NCC.E1_TIPO 		= 'NCC'         " + c_EOL
	c_Qry += "                AND SE1_NCC.E1_CLIENTE 	= SE1.E1_CLIENTE" + c_EOL
	c_Qry += "                AND SE1_NCC.E1_LOJA 		= SE1.E1_LOJA   " + c_EOL
	c_Qry += "                AND SE1_NCC.D_E_L_E_T_ 	= ' '     		" + c_EOL
	c_Qry += "                											" + c_EOL
	c_Qry += "            INNER JOIN									" + c_EOL
	c_Qry += "                 " + RetSqlName("ZUM") + " ZUM 			" + c_EOL
	c_Qry += "            ON											" + c_EOL
	c_Qry += "                ZUM.ZUM_FILIAL      = '" + xFilial("ZUM") + "' " + c_EOL
	c_Qry += "                AND ZUM.ZUM_CODEMP  = SE1.E1_CODEMP 	" + c_EOL
	c_Qry += "                AND ZUM.ZUM_ANO     = SE1.E1_ANOBASE  " + c_EOL
	c_Qry += "                AND ZUM.ZUM_MES     = SE1.E1_MESBASE  " + c_EOL
	c_Qry += "                AND ZUM.ZUM_DATLIB  <= '" + DTOS( DATE() )+ "'  " + c_EOL
	c_Qry += "                AND ZUM.D_E_L_E_T_  = ' ' 			" + c_EOL
	c_Qry += "            											" + c_EOL
	c_Qry += "        WHERE 										" + c_EOL
	c_Qry += "            SE1.E1_FILIAL = '" + xFilial("SE1") + "'	" + c_EOL

	If !Empty(DTOS(dGtEmDe)) .OR. !Empty(DTOS(cGtEmAte))

		c_Qry += "       AND SE1.E1_EMISSAO BETWEEN '" + DTOS(dGtEmDe) + "' AND '" + DTOS(cGtEmAte) + "' " + c_EOL

	EndIf

	If !Empty(cGtCliente)

		c_Qry += "       AND SE1.E1_CLIENTE = '" + cGtCliente + "' " + c_EOL

	EndIf

	If !Empty(cGtEmpDe) .OR. !Empty(cGtEmpAte)

		c_Qry += "       AND SE1.E1_CODEMP BETWEEN '" + cGtEmpDe + "' AND '" + cGtEmpAte + "' " + c_EOL

	EndIf

	If !Empty(cGtTitDe) .OR. !Empty(cGtTitAte)

		c_Qry += "       AND SE1.E1_NUM BETWEEN '" + cGtTitDe + "' AND '" + cGtTitAte + "' " + c_EOL

	EndIf

	If !Empty(DTOS(dGtVencDe)) .OR. !Empty(DTOS(dGtVenAte))

		c_Qry += "       AND SE1.E1_VENCREA BETWEEN '" + DTOS(dGtVenDe) + "' AND ' " + DTOS(dGtVenAte) + " " + c_EOL

	EndIf

	If !Empty(cGtCompet)

		c_Qry += "       AND SE1.E1_ANOBASE = '" + SUBSTR(cGtCompet,1,4) + "' "  + c_EOL
		c_Qry += "       AND SE1.E1_MESBASE = '" + SUBSTR(cGtCompet,5,2) + "' "  + c_EOL

	EndIf

	c_Qry += "            AND NOT EXISTS ( " + c_EOL
	c_Qry += "                                SELECT 			" + c_EOL
	c_Qry += "                                    SF2.F2_DOC 	" + c_EOL
	c_Qry += "                                FROM 				" + c_EOL
	c_Qry += "                                    " + RetSqlName("SF2") + " SF2 " + c_EOL
	c_Qry += "                                WHERE 							" + c_EOL
	c_Qry += "                                    SF2.F2_FILIAL       = SE1.E1_FILIAL 	" + c_EOL
	c_Qry += "                                    AND SF2.F2_SERIE    = SE1.E1_XSERNF 	" + c_EOL
	c_Qry += "                                    AND SF2.F2_DOC      = SE1.E1_XDOCNF	" + c_EOL
	c_Qry += "                                    AND SF2.F2_CLIENTE  = SE1.E1_CLIENTE 	" + c_EOL
	c_Qry += "                                    AND SF2.D_E_L_E_T_  = ' ' 			" + c_EOL
	c_Qry += "                            )             								" + c_EOL
	c_Qry += "            AND SE1.E1_ORIGEM = 'PLSA510'              					" + c_EOL
	c_Qry += "            AND SE1.E1_XSTDOC <> 'G' 										" + c_EOL
	c_Qry += "            AND SE1.E1_TIPO = 'DP'             							" + c_EOL
	c_Qry += "            AND ((BDC_MODPAG = '2' AND BQC_YODONT = '1') OR (BDC_MODPAG <> '2'))   " + c_EOL
	c_Qry += "            AND SE1.D_E_L_E_T_ = ' ' " + c_EOL
	c_Qry += "        ) F 	" + c_EOL
	c_Qry += "    ) G 		" + c_EOL

	MemoWrit("C:\Temp\TMP850B010.txt",c_Qry)

	If Select("QRYPESQ") > 0
		DBSELECTAREA("QRYPESQ")
		("QRYPESQ")->(DbCloseArea())
	Endif

	If TcCanOpen("QRYPESQ")
		TcDelFile("QRYPESQ")
	Endif

	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),"QRYPESQ",.T.,.T.)

	For ni := 2 to Len(aStruct)
		If aStruct[ni,2] != 'C'
			TCSetField("QRYPESQ", aStruct[ni,1], aStruct[ni,2],aStruct[ni,3],aStruct[ni,4])
		Endif
	Next

	cTmp2 := CriaTrab(NIL,.F.) //CriaTrab(aStruct,.T.)
	Copy To &cTmp2


	("QRYPESQ")->(dbCloseArea())

	dbUseArea(.T.,,cTmp2,"QRYPESQ",.T.)

	("QRYPESQ")->(DbGoTop())

	If ("QRYPESQ")->(Eof())

		lRet := .F.

	Endif

	oBrRio:Refresh()
	oDlg:Refresh()

Return

Static Function fbGerar()

	// Seleciona area tmp
	dbSelectArea( c_AliasTmp )
	(c_AliasTmp)->( dbGotop())

	While !(c_AliasTmp)->( EOF() )

		If trim((c_AliasTmp)->XOK) == "X"

			If !fGeraNota( (c_AliasTmp)->E1_PREFIXO, (c_AliasTmp)->E1_NUM , @c_Mesnagem)

				c_FilDes := cFilAnt

				AtuF1((c_AliasTmp)->E1_PREFIXO, (c_AliasTmp)->E1_NUM, " ", (c_AliasTmp)->E1_NUM, 'E', c_FilDes, (c_AliasTmp)->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO) )

			EndIf

		EndIf

		(c_AliasTmp)->( dbSkip() )

	EndDo

	(c_AliasTmp)->( dbGotop())

Return


Static Function fBrNF()

	Local nIt := 0

	DbSelectArea(c_AliasNF)
	(c_AliasNF)->(DbGoTop())

	oBrNF:=TcBrowse():New(020,005,415,150,,,,oFolder1:aDialogs[2],,,,,,,oDlg:oFont,,,,,.T.,c_AliasNF,.T.,,.F.,,,.F.)

	For nIt := 1 To Len(aCamNF)

		c2 := If(nIt == 1," ",aCamNF[nIt,1])
		c3 := If(nIt == 1,&("{|| If(Empty("+c_AliasNF+"->"+cCampoOk+"),onOk,oOk)}"),&("{||"+c_AliasNF+"->"+aCamNF[nIt,2]+"  }"))

		c4 := If(nIt == 1,5,CalcFieldSize(aCamNF[nIt,3],aCamNF[nIt,4],aCamNF[nIt,5],"",aCamNF[nIt,1]))
		c5 := If(nIt == 1,"",aCamNF[nIt,6])
		c6 := If(nIt == 1,.T.,.F.)

		oBrNF:AddColumn(TCColumn():New(c2,c3,c5,,,"LEFT",c4,c6,.F.,,,,.F.))
		oBrNF:bLDblClick   := {|| fAtuNf(c_AliasNF,cCampoOk     )}

	Next

	oBrNF:bHeaderClick := {|| fAtuNf(c_AliasNF,cCampoOK,,.T.)}

Return

Static Function fBrSemFil()

	Local oBrSemFil
	Local aBrSemFil := {}

	Aadd(aBrSemFil,{"Check","Status","Prefixo","Numero","Emissão","Cliente","Nome Cliente","Vencimento","Borderô","Empresa","Pessoa"})
	Aadd(aBrSemFil,{"Check","Status","Prefixo","Numero","Emissão","Cliente","Nome Cliente","Vencimento","Borderô","Empresa","Pessoa"})

	@ 005, 003 LISTBOX oBrSemFil Fields HEADER "Check","Status","Prefixo","Numero","Emissão","Cliente","Nome Cliente","Vencimento","Borderô","Empresa","Pessoa" SIZE 418, 226 OF oFolder1:aDialogs[3] PIXEL ColSizes 50,50
	oBrSemFil:SetArray(aBrSemFil)
	oBrSemFil:bLine := {|| {;
		aBrSemFil[oBrSemFil:nAt,1],;
		aBrSemFil[oBrSemFil:nAt,2],;
		aBrSemFil[oBrSemFil:nAt,3],;
		aBrSemFil[oBrSemFil:nAt,4],;
		aBrSemFil[oBrSemFil:nAt,5],;
		aBrSemFil[oBrSemFil:nAt,6],;
		aBrSemFil[oBrSemFil:nAt,7],;
		aBrSemFil[oBrSemFil:nAt,8],;
		aBrSemFil[oBrSemFil:nAt,9],;
		aBrSemFil[oBrSemFil:nAt,10],;
		aBrSemFil[oBrSemFil:nAt,11];
		}}

	oBrSemFil:bLDblClick := {|| aBrSemFil[oBrSemFil:nAt,1] := !aBrSemFil[oBrSemFil:nAt,1],oBrSemFil:DrawSelect()}

Return


Static Function fBrRio()

	Aadd(aBrRio,{.T.," "," "," ",stod("")," "," ",stod("")," "," "," "})

	@ 022, 006 LISTBOX oBrRio Fields HEADER "Check","Status","Prefixo","Numero","Emissão","Cliente","Nome Cliente","Vencimento","Borderô","Empresa","Pessoa" SIZE 418, 226 OF oFolder1:aDialogs[1] PIXEL ColSizes 50,50
	oBrRio:SetArray(aBrRio)
	oBrRio:bLine := {|| {;
		IIf(aBrRio[oBrRio:nAt,1],oOk,oNo)   ,;
		aBrRio[oBrRio:nAt,2],;
		aBrRio[oBrRio:nAt,3],;
		aBrRio[oBrRio:nAt,4],;
		aBrRio[oBrRio:nAt,5],;
		aBrRio[oBrRio:nAt,6],;
		aBrRio[oBrRio:nAt,7],;
		aBrRio[oBrRio:nAt,8],;
		aBrRio[oBrRio:nAt,9],;
		aBrRio[oBrRio:nAt,10],;
		aBrRio[oBrRio:nAt,11];
		}}

	oBrRio:bLDblClick := {|| aBrRio[oBrRio:nAt,1] := !aBrRio[oBrRio:nAt,1],oBrRio:DrawSelect()}

Return

Static Function fGeraNota(c_Prefix, c_Num, c_Critica)

	Local c_Qry 	:= ""
	Local a_Pedido	:= {}
	Local l_Ret 	:= .T.

	c_Qry := " SELECT E1_SUBCON, E1_CODEMP, E1_FILIAL, BM1.BM1_PREFIX, BM1_NUMTIT, SE1.E1_PARCELA, SE1.E1_TIPO, E1_CLIENTE,E1_LOJA, (	CASE WHEN instr('" + GetMv("MV_XEMPNIT") + "',E1_CODEMP) > 0 THEN '04' " + c_EOL
	c_Qry += "                                                 					WHEN instr('" + GetMv("MV_XEMPJAU") + "',E1_CODEMP) > 0 THEN '01'  " + c_EOL
	c_Qry += "                                                 					ELSE DECODE(A1_COD_MUN,'04557','01','04') END)   FILDES,  " + c_EOL
	c_Qry += " A1_EMAIL, "+ c_EOL
	c_Qry += " SUM (DECODE ( BM1_TIPO , 1 ,BM1_VALOR, (BM1_VALOR*-1))) VALOR "+ c_EOL

	c_Qry += " FROM " + RETSQLNAME("BM1") + " BM1 INNER JOIN " + RETSQLNAME("SE1") + " SE1 ON  "+ c_EOL
	c_Qry += "                                          E1_FILIAL = '" + xfilial("SE1") + "'  "+ c_EOL
	c_Qry += "                                          AND E1_PREFIXO = BM1_PREFIX  "+ c_EOL
	c_Qry += "                                          AND E1_NUM = BM1_NUMTIT  "+ c_EOL
	c_Qry += "                                          AND SE1.E1_CODEMP = BM1.BM1_CODEMP "+ c_EOL //Angelo Henrique - Data: 30/08/2019
	c_Qry += "                                          AND SE1.E1_TIPO = 'DP' "+ c_EOL //Angelo Henrique - RELEASE 27 - Data: 23/12/2020
	c_Qry += "                                    INNER JOIN " + RETSQLNAME("SA1") + " SA1 ON  "+ c_EOL
	c_Qry += "                                          A1_FILIAL = ' '  "+ c_EOL
	c_Qry += "                                          AND A1_COD = E1_CLIENTE  "+ c_EOL

	c_Qry += "                                    INNER JOIN " + RETSQLNAME("BFQ") + " BFQ ON "+ c_EOL
	c_Qry += "                                          BFQ_FILIAL = ' '   "+ c_EOL
	c_Qry += "                                          AND BFQ_PROPRI||BFQ_CODLAN = BM1_CODTIP "+ c_EOL

	//---------------------------------------------------------------------
	//Angelo Henrique - Data: 21/02/2022
	//Chamado: 83780
	//Fazer com que a rotina contemple a caberj e a integral
	//---------------------------------------------------------------------
	If cEmpAnt != "01"
		c_Qry += "                                          AND ( (E1_MATRIC <> ' ' AND BFQ_YTPANL <> 'C') OR E1_MATRIC = ' ' ) "+ c_EOL
	EndIf
	c_Qry += "                      	                AND BFQ.D_E_L_E_T_ = ' '  "+ c_EOL


	c_Qry += " WHERE BM1_FILIAL = ' '     "+ c_EOL
	c_Qry += "       AND BM1_PREFIX = '" + c_Prefix + "'   "+ c_EOL
	c_Qry += "       AND BM1_NUMTIT = '" + c_Num    + "'"+ c_EOL
	c_Qry += "       AND BM1_CODTIP NOT IN ( '903','920','907') "+ c_EOL
	c_Qry += "       AND BM1.D_E_L_E_T_ = ' ' "+ c_EOL
	c_Qry += "       AND SE1.D_E_L_E_T_ = ' ' "+ c_EOL
	c_Qry += " GROUP BY  E1_SUBCON, E1_CODEMP, E1_FILIAL, BM1.BM1_PREFIX, BM1_NUMTIT, SE1.E1_PARCELA, SE1.E1_TIPO, E1_CLIENTE,E1_LOJA, (CASE WHEN instr('" + GetMv("MV_XEMPNIT") + "',E1_CODEMP) > 0 THEN '04' WHEN instr('" + GetMv("MV_XEMPJAU") + "',E1_CODEMP) > 0 THEN '01' ELSE DECODE(A1_COD_MUN,'04557','01','04') END) , A1_EMAIL "    + c_EOL

	TCQUERY c_Qry ALIAS "QRYBM1" NEW

	While !QRYBM1->( EOF() )

		dbSelectArea("SD2")
		SD2->(dbOrderNickName("TITPLSD2"))
		If dbSeek(xFilial("SD2") + c_Prefix +  c_Num )

			QRYBM1->( dbSkip() )
			a_Pedido := {}
			Loop

		EndIf

		aadd(a_Pedido, { "SERMED", 1, QRYBM1->VALOR } )

		If cEmpAnt = "02"

			If !Empty( QRYBM1->A1_EMAIL )

				c_FilDes := cFilAnt

				fCriaPedido(cEmpAnt, c_FilDes, QRYBM1->E1_CLIENTE, QRYBM1->E1_LOJA, a_Pedido, c_Prefix, c_Num, QRYBM1->E1_CODEMP, QRYBM1->E1_SUBCON,  QRYBM1->(E1_FILIAL+BM1_PREFIX+BM1_NUMTIT+E1_PARCELA+E1_TIPO))

			Else

				c_Critica :=  "EMAIL EM BRANCO. CLIENTE: " + QRYBM1->E1_CLIENTE + ", TÍTULO:  " + c_Num
				l_Ret := .F.

			EndIf

		Else

			c_FilDes := cFilAnt

			fCriaPedido(cEmpAnt,c_FilDes, QRYBM1->E1_CLIENTE, QRYBM1->E1_LOJA, a_Pedido, c_Prefix, c_Num, QRYBM1->E1_CODEMP, QRYBM1->E1_SUBCON,  QRYBM1->(E1_FILIAL+BM1_PREFIX+BM1_NUMTIT+E1_PARCELA+E1_TIPO))

		EndIf

		QRYBM1->( dbSkip() )
		a_Pedido := {}

	EndDo

	QRYBM1->( dbCloseArea() )

Return l_Ret


Static Function fCriaPedido(c_Empresa, c_Filial, c_Cliente,  c_Loja, a_DPedido, c_PreTit, c_NumTit, c_CodEmp, c_Subcon, c_ChvSe1)

	Local l_Ret 	:= .F.
	Local c_Num		:= ""
	Local a_Cabec   := {}
	Local a_Detalhe := {}
	Local a_ItensT 	:= {}
	Local n_Count	:= 0
	Local n_Total 	:= 0

	c_Num := GetSXENum("SF2","F2_DOC")

	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+c_Cliente+c_Loja)

	For n_Count := 1 to Len(a_DPedido)

		aadd(a_Detalhe,{"D2_ITEM"	, "01"											, Nil})
		aadd(a_Detalhe,{"D2_COD" 	, a_DPedido[n_Count][1]							, Nil})
		aadd(a_Detalhe,{"D2_QUANT"	, a_DPedido[n_Count][2]							, Nil})
		aadd(a_Detalhe,{"D2_PRCVEN"	, a_DPedido[n_Count][3] 						, Nil})
		aadd(a_Detalhe,{"D2_TOTAL"	, a_DPedido[n_Count][2] * a_DPedido[n_Count][3]	, Nil})

		//---------------------------------------------------------------------
		//Angelo Henrique - Data: 21/02/2022
		//Chamado: 83780
		//Fazer com que a rotina contemple a caberj e a integral
		//---------------------------------------------------------------------
		If cEmpAnt = "01"
			aadd(a_Detalhe,{"D2_TES", "600",Nil})
			aadd(a_Detalhe,{"D2_CF",posicione("SF4", 1, XFILIAL("SF4") + PADR("600",TAMSX3("F4_CODIGO")[1]), "F4_CF"),Nil})
		Else
			aadd(a_Detalhe,{"D2_TES", "601",Nil})
			aadd(a_Detalhe,{"D2_CF",posicione("SF4", 1, XFILIAL("SF4") + PADR("601",TAMSX3("F4_CODIGO")[1]), "F4_CF"),Nil})
		EndIf

		aadd(a_Detalhe,{"D2_XPREPLS",c_PreTit,Nil})
		aadd(a_Detalhe,{"D2_XTITPLS",c_NumTit,Nil})

		aadd(a_ItensT,a_Detalhe)

		n_Total += a_DPedido[n_Count][2] * a_DPedido[n_Count][3]

	Next

	iF n_Total <= 0

		Return .F.

	EndIf

	aadd(a_Cabec,{"F2_TIPO"   	, "N"			})
	aadd(a_Cabec,{"F2_FORMUL" 	, "N"			})
	aadd(a_Cabec,{"F2_DOC"    	, c_Num			})
	aadd(a_Cabec,{"F2_SERIE" 	, "UNI"			})
	aadd(a_Cabec,{"F2_EMISSAO"	, dDataBase		})
	aadd(a_Cabec,{"F2_CLIENTE"	, SA1->A1_COD	})
	aadd(a_Cabec,{"F2_TIPOCLI"	, SA1->A1_PESSOA})
	aadd(a_Cabec,{"F2_LOJA"   	, SA1->A1_LOJA	})

	//---------------------------------------------------------------------
	//Angelo Henrique - Data: 21/02/2022
	//---------------------------------------------------------------------
	//Chamado: 83780
	//Fazer com que a rotina contemple a caberj e a integral
	//---------------------------------------------------------------------
	If cEmpAnt = "01"
		aadd(a_Cabec,{"F2_ESPECIE","NF"	})
	Else
		aadd(a_Cabec,{"F2_ESPECIE","RPS"})
	EndIf

	aadd(a_Cabec,{"F2_COND"		,"005"				})
	aadd(a_Cabec,{"F2_DESCONT"	,0					})
	aadd(a_Cabec,{"F2_VALBRUT"	,n_Total 			})
	aadd(a_Cabec,{"F2_VALFAT"	,n_Total 			})
	aadd(a_Cabec,{"F2_FRETE"	,0					})
	aadd(a_Cabec,{"F2_SEGURO"	,0					})
	aadd(a_Cabec,{"F2_DESPESA"	,0					})
	aadd(a_Cabec,{"F2_PREFIXO"	,"1"				})
	aadd(a_Cabec,{"F2_HORA"		,substr(time(),1,5)	})

	lMsErroAuto := .F.

	MSExecAuto({|x,y,z| mata920(x,y,z)},a_Cabec,a_ItensT,3) //Inclusao

	If lMsErroAuto // se ocorrer um erro, avisa e mostra o erro na tela

		Alert("Erro na inclusao!")
		MostraErro()

	Else

		ConfirmSX8()
		AtuF1(c_PreTit, c_NumTit, "UNI", c_Num, 'G', c_Filial, c_ChvSe1 )

		If cEmpAnt = "02"
			AtuF3(c_Num, "UNI", SA1->A1_COD, SA1->A1_LOJA, n_Total, c_Cliente,  c_Loja  )
		EndIf

		AtuF2( c_Filial, "UNI", c_Num, c_CodEmp, c_PreTit, c_NumTit, c_Subcon , n_Total, c_Cliente,  c_Loja)

	EndIf

Return l_Ret

Static Function AtuF2( c_Filial, c_Serie, c_Doc, c_Empresa, c_Prefix, c_NumTit, c_Subcon, n_Total, c_Cliente,  c_Loja )

	Local _aArea 	:= GetArea()
	Local _aArSF2	:= SF2->(GetArea())
	Local _aArSD2	:= SD2->(GetArea())
	Local _aArSA1	:= SA1->(GetArea())

	SF2->( dbCloseArea() )

	dbSelectArea("SF2")
	dbSetOrder(1)
	If dbSeek(xFilial("SF2") + c_Doc+ c_Serie )

		//---------------------------------------------------------------------
		//Angelo Henrique - Data: 21/02/2022
		//---------------------------------------------------------------------
		//Chamado: 83780
		//Fazer com que a rotina contemple a caberj e a integral
		//---------------------------------------------------------------------
		If cEmpAnt = "02"

			dbSelectArea("SF2")
			RecLock("SF2",.F.)

			SF2->F2_XCODEMP  := c_Empresa
			SF2->F2_XNOMEMP  := posicione("BG9", 1, XFILIAL("BG9") + '0001' + c_Empresa, "BG9_NREDUZ")
			SF2->F2_XPREPLS  := c_Prefix
			SF2->F2_XTITPLS  := c_NumTit
			SF2->F2_XSUBCON  := c_Subcon
			SF2->F2_VALBRUT  := n_Total
			SF2->F2_VALFAT   := n_Total

			//Processo filial 01 migração Niteroi
			dbSelectArea("SA1")
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+c_Cliente+c_Loja)

			SF2->F2_COND	:= "005"
			SF2->F2_TIPOCLI := SA1->A1_TIPO
			SF2->F2_RECISS 	:= "2"
			SF2->F2_CLIENT 	:= SA1->A1_COD
			SF2->F2_LOJENT 	:= SA1->A1_LOJA
			SF2->F2_TIPIMP 	:= "1"
			SF2->F2_ESTPRES := "RJ"
			SF2->F2_MUNPRES := "03302"
			SF2->F2_TPCOMPL := "1"

			SF2->( MsUnLock() )

			//Atualiza SD2
			dbSelectArea("SD2")
			dbSetOrder(3)//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
			If dbSeek(xFilial("SD2") + SF2->(F2_DOC + F2_SERIE) )

				RecLock("SD2",.F.)

				SD2->D2_PEDIDO 	:= "000001"
				SD2->D2_ITEMPV 	:= "01"

				SD2->( MsUnLock() )

			EndIf

		Else

			dbSelectArea("SF2")
			RecLock("SF2",.F.)

			SF2->F2_XCODEMP  := c_Empresa
			SF2->F2_XNOMEMP  := posicione("BG9", 1, XFILIAL("BG9") + '0001' + c_Empresa, "BG9_NREDUZ")
			SF2->F2_XPREPLS  := c_Prefix
			SF2->F2_XTITPLS  := c_NumTit
			SF2->F2_XSUBCON  := c_Subcon
			SF2->F2_VALBRUT  := n_Total
			SF2->F2_VALFAT   := n_Total

			SF2->( MsUnLock() )

		EndIf

	EndIf

	RestArea(_aArea )
	RestArea(_aArSF2)
	RestArea(_aArSD2)
	RestArea(_aArSA1)

Return

Static Function AtuF1( c_PreTit, c_NumTit, c_Serie, c_Doc, c_St, c_Filial, c_ChvSe1 )

	Local _aArSE1 := SE1->(GetArea())

	dbSelectArea("SE1")
	dbSetOrder(1)
	If dbSeek(c_ChvSe1) //Angelo Henrique - Data: 02/09/2019

		dbSelectArea("SE1")
		RecLock("SE1",.F.)

		SE1->E1_XSTDOC  := c_St
		SE1->E1_XSERNF  := c_Serie
		SE1->E1_XDOCNF  := IIF(c_St <> 'C', c_Doc    , "")
		SE1->E1_XFILNF  := IIF(c_St <> 'C', c_Filial , "")

		SE1->( MsUnLock() )

	EndIf

	RestArea(_aArSE1)

Return

Static Function fExcluiNf()

	// Seleciona area tmp
	dbSelectArea( c_AliasNF )
	(c_AliasNF)->( dbGotop())

	While !(c_AliasNF)->( EOF() )

		If trim((c_AliasNF)->XOK) == "X"
			fExclui( (c_AliasNF)->E1_PREFIXO, (c_AliasNF)->E1_NUM )
		EndIf
		(c_AliasNF)->( dbSkip() )

	EndDo

	(c_AliasNF)->( dbGotop())

	BPesquisa()
	bPesqnf()
	oBrNF:Refresh()
	oDlg:Refresh()
	oBrRio:Refresh()
	oDlg:Refresh()

Return

Static Function fExclui(c_Prefix, c_Num)

	Local a_Cabec 	:= {}
	Local a_ItensT	:= {}
	Local a_Detalhe	:= {}
	Local c_Serie 	:= ""
	Local c_Doc		:= ""
	Local _cCHvE1	:= ""

	dbSelectArea("SE1")
	dbSetOrder(1)
	If dbSeek(xFilial("SE1") + c_Prefix + c_Num )

		//-------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 23/12/2020
		//-------------------------------------------------------------------------------------
		//Release 27 - São gerados dois títulos em alguns casos (DP e NCC)
		//Tendo assim a necessidade de varrer em qual título a rotina preencheu
		//as informações
		//-------------------------------------------------------------------------------------
		While SE1->(!EOF()) .And. c_Prefix + c_Num == SE1->(E1_PREFIXO+E1_NUM)

			If !Empty(SE1->E1_XDOCNF)

				c_Serie := SE1->E1_XSERNF
				c_Doc	:= SE1->E1_XDOCNF
				_cCHvE1	:= SE1->(E1_FILIAL + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO) //Angelo Henrique - Data: 17/09/2019

				Exit

			EndIf

			SE1->(DbSkip())

		EndDo

	EndIf

	dbSelectArea("SF2")
	dbSetOrder(1)
	If dbSeek( XFilial("SF2") + c_Doc + c_Serie )

		aadd(a_Cabec,{"F2_TIPO"   	,SF2->F2_TIPO	})
		aadd(a_Cabec,{"F2_FORMUL" 	,SF2->F2_FORMUL	})
		aadd(a_Cabec,{"F2_DOC"    	,SF2->F2_DOC	})
		aadd(a_Cabec,{"F2_SERIE"  	,SF2->F2_SERIE	})
		aadd(a_Cabec,{"F2_EMISSAO"	,SF2->F2_EMISSAO})
		aadd(a_Cabec,{"F2_CLIENTE"	,SF2->F2_CLIENTE})
		aadd(a_Cabec,{"F2_TIPOCLI"	,SF2->F2_TIPOCLI})
		aadd(a_Cabec,{"F2_LOJA"   	,SF2->F2_LOJA	})
		aadd(a_Cabec,{"F2_ESPECIE"	,SF2->F2_ESPECIE})
		aadd(a_Cabec,{"F2_COND"		,SF2->F2_COND	})
		aadd(a_Cabec,{"F2_DESCONT"	,SF2->F2_DESCONT})
		aadd(a_Cabec,{"F2_VALBRUT"	,SF2->F2_VALBRUT})
		aadd(a_Cabec,{"F2_VALFAT"	,SF2->F2_VALFAT })
		aadd(a_Cabec,{"F2_FRETE"	,SF2->F2_FRETE	})
		aadd(a_Cabec,{"F2_SEGURO"	,SF2->F2_SEGURO	})
		aadd(a_Cabec,{"F2_DESPESA"	,SF2->F2_DESPESA})
		aadd(a_Cabec,{"F2_PREFIXO"	,SF2->F2_PREFIXO})

		dbSelectArea("SD2")
		dbSetOrder(3)
		If dbSeek(XFilial("SD2") + c_Doc + c_Serie )

			aadd(a_Detalhe,{"D2_ITEM" 	,D2_ITEM	,Nil})
			aadd(a_Detalhe,{"D2_COD" 	,D2_COD		,Nil})
			aadd(a_Detalhe,{"D2_QUANT"	,D2_QUANT	,Nil})
			aadd(a_Detalhe,{"D2_PRCVEN"	,D2_PRCVEN 	,Nil})
			aadd(a_Detalhe,{"D2_TOTAL"	,D2_TOTAL	,Nil})
			aadd(a_Detalhe,{"D2_TES"	,D2_TES		,Nil})
			aadd(a_Detalhe,{"D2_CF"		,D2_CF		,Nil})

			c_PreTit := D2_XPREPLS
			c_NumTit := D2_XTITPLS

			aadd(a_ItensT,a_Detalhe)

		EndIf

		lMsErroAuto := .F.

		MSExecAuto({|x,y,z| mata920(x,y,z)},a_Cabec,a_ItensT,5) //Inclusao

		If lMsErroAuto // se ocorrer um erro, avisa e mostra o erro na tela

			Alert("Erro na Exclusao!")
			MostraErro()

		Else

			ConfirmSX8()
			AtuF1(c_PreTit, c_NumTit, " ", " ", 'C'," ",_cCHvE1)

		EndIf

	EndIf

	oBrNF:Refresh()
	oDlg:Refresh()

Return

Static Function AtualizaE1(c_St, c_Prefix, c_Num)

	dbSelectArea("SE1")
	dbSetOrder(1)
	If dbSeek(xFilial("SE1") + c_Prefix + c_Num)

		SE1->E1_XSTDOC 	:= c_St
		SE1->E1_XSERNF  := " "
		SE1->E1_XDOCNF  := " "

	EndIf

Return

Static Function fStrTit()

	Aadd(aCampos,{" ",cCampoOk,"C",1,0,})
	Aadd(aStruct,{cCampoOk,"C",1,0})

	Aadd(aCampos,{"Mun","MUN","C",3,0,""})
	Aadd(aStruct,{"MUN","C",3,0})

	Aadd(aCampos,{"Prefixo","E1_PREFIXO","C",3,0,""})
	Aadd(aStruct,{"E1_PREFIXO","C",3,0})

	Aadd(aCampos,{"Numero","E1_NUM","C",9,0,""})
	Aadd(aStruct,{"E1_NUM","C",9,0})

	Aadd(aCampos,{"Valor","VALOR","C",10,2,""})
	Aadd(aStruct,{"VALOR","N",10,2})

	Aadd(aCampos,{"Empresa","E1_CODEMP","C",4,0,""})
	Aadd(aStruct,{"E1_CODEMP","C",3,0})

	Aadd(aCampos,{"Emissao","E1_EMISSAO","D",8,0,""})
	Aadd(aStruct,{"E1_EMISSAO","D",8,0})

	Aadd(aCampos,{"Posicao","POSIC","C",30,0,""})
	Aadd(aStruct,{"POSIC","C",10,0})

	Aadd(aCampos,{"Cliente","E1_CLIENTE","C",6,0,""})
	Aadd(aStruct,{"E1_CLIENTE","C",6,0})

	Aadd(aCampos,{"Nome","E1_NOMCLI","C",20,0,""})
	Aadd(aStruct,{"E1_NOMCLI","C",20,0})

	Aadd(aCampos,{"Emissao","E1_VENCREA","C",50,0,""})
	Aadd(aStruct,{"E1_VENCREA","D",8,0})

	Aadd(aCampos,{"Bordero","E1_NUMBOR","C",6,0,""})
	Aadd(aStruct,{"E1_NUMBOR","C",6,0})

	Aadd(aCampos,{"NFS Serie","E1_XSERNF ","C",3,0,""})
	Aadd(aStruct,{"E1_XSERNF ","C",3,0})

	Aadd(aCampos,{"NFS DOC","E1_XDOCNF  ","C",9,0,""})
	Aadd(aStruct,{"E1_XDOCNF  ","C",9,0})

	If Select((c_AliasTmp)) <> 0
		(c_AliasTmp)->(DbCloseArea())
	Endif
	If TcCanOpen(c_AliasTmp)
		TcDelFile(c_AliasTmp)
	Endif

	DbCreate(c_AliasTmp,aStruct,"TopConn")
	If Select(c_AliasTmp) <> 0
		(c_AliasTmp)->(DbCloseArea())
	Endif
	DbUseArea(.T.,"TopConn",c_AliasTmp,c_AliasTmp,.T.,.F.)
	(c_AliasTmp)->(DbCreateIndex(cAliasInd , cChave, {|| &cChave}, .F. ))
	(c_AliasTmp)->(DbCommit())
	(c_AliasTmp)->(DbClearInd())
	(c_AliasTmp)->(DbSetIndex(cAliasInd ))

Return


Static Function fStrNF()

	Aadd(aCamNF,{" ",cCampoOk,"C",1,0,})
	Aadd(aStrNF,{cCampoOk,"C",1,0})

	Aadd(aCamNF,{"Filial","FILIAL","C",7,0,""})
	Aadd(aStrNF,{"FILIAL","C",7,0})


	Aadd(aCamNF,{"Num RPS","F2_DOC","C",9,0,""})
	Aadd(aStrNF,{"F2_DOC","C",9,0})

	Aadd(aCamNF,{"Serie","F2_SERIE","C",3,0,""})
	Aadd(aStrNF,{"F2_SERIE","C",3,0})

	Aadd(aCamNF,{"Hora Trans","F3_HORNFE","C",10,0,""})
	Aadd(aStrNF,{"F3_HORNFE","C",10,0})

	Aadd(aCamNF,{"Nota Fiscal","F3_NFELETR","C",9,0,""})
	Aadd(aStrNF,{"F3_NFELETR","C",9,0})

	Aadd(aCamNF,{"Emissao Nota","F3_EMINFE","D",8,0,""})
	Aadd(aStrNF,{"F3_EMINFE","D",8,0})

	Aadd(aCamNF,{"Valor","F2_VALBRUT","N",10,2,""})
	Aadd(aStrNF,{"F2_VALBRUT","N",10,2})

	Aadd(aCamNF,{"Emissao","E1_EMISSAO","D",8,0,""})
	Aadd(aStrNF,{"E1_EMISSAO","D",8,0})

	Aadd(aCamNF,{"Cliente","E1_CLIENTE","C",6,0,""})
	Aadd(aStrNF,{"E1_CLIENTE","C",6,0})

	Aadd(aCamNF,{"Nome","E1_NOMCLI","C",20,0,""})
	Aadd(aStrNF,{"E1_NOMCLI","C",20,0})

	Aadd(aCamNF,{"Prefixo","E1_PREFIXO","C",3,0,""})
	Aadd(aStrNF,{"E1_PREFIXO","C",3,0})

	Aadd(aCamNF,{"Numero","E1_NUM","C",9,0,""})
	Aadd(aStrNF,{"E1_NUM","C",9,0})

	Aadd(aCamNF,{"Emissao","E1_VENCREA","D",8,0,""})
	Aadd(aStrNF,{"E1_VENCREA","D",8,0})

	Aadd(aCamNF,{"Bordero","E1_NUMBOR","C",6,0,""})
	Aadd(aStrNF,{"E1_NUMBOR","C",6,0})

	Aadd(aCamNF,{"Transmissao","F3_DESCRET","C",250,0,""})
	Aadd(aStrNF,{"F3_DESCRET","C",250,0})

	If Select(c_AliasNF) <> 0
		(c_AliasNF)->(DbCloseArea())
	Endif
	If TcCanOpen(c_AliasNF)
		TcDelFile(c_AliasNF)
	Endif

	DbCreate(c_AliasNF,aStrNF,"TopConn")
	If Select(c_AliasNF) <> 0
		(c_AliasNF)->(DbCloseArea())
	Endif
	DbUseArea(.T.,"TopConn",c_AliasNF,c_AliasNF,.T.,.F.)
	(c_AliasNF)->(DbCreateIndex(cAlIndNF , cChave, {|| &cChave}, .F. ))
	(c_AliasNF)->(DbCommit())
	(c_AliasNF)->(DbClearInd())
	(c_AliasNF)->(DbSetIndex(cAlIndNF ))

Return

Static Function AtuF3(c_Nota, c_Serie, c_Cliente,c_Loja , n_ValDed, c_Cliente,  c_Loja)

	Local _aArF3 := SF3->(GetArea())
	Local _aArFT := SFT->(GetArea())

	dbSelectArea("SF3")
	dbSetOrder(4)
	If dbSeek(xFilial("SF3") + c_Cliente + c_Loja + c_Nota + c_Serie )

		RecLock("SF3",.F.)

		SF3->F3_ISSSUB  := n_ValDed - SF3->F3_BASEICM
		SF3->F3_CLIENT := c_Cliente
		SF3->F3_LOJENT := c_Loja

		SF3->( MsUnLock() )

		//---------------------------------------
		//Atualizando a tabela SFT
		//---------------------------------------
		dbSelectArea("SFT")
		dbSetOrder(1) //FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_ITEM+FT_PRODUTO
		If dbSeek(xFilial("SFT") + "S" + SF3->(F3_SERIE + F3_NFISCAL) )

			RecLock("SFT",.F.)

			SFT->FT_CLIENT := c_Cliente
			SFT->FT_LOJENT := c_Loja

			SFT->( MsUnLock() )

		EndIf

	EndIf

	RestArea(_aArF3)
	RestArea(_aArFT)

Return


Static Function bPesqnf( l_NFGEradas, l_NFTrans, l_NFRec )

	Local c_Qry 	:= ""
	Local ni		:= 0

	a_Pesquisa := {}

	c_Qry += " SELECT		" + c_EOL
	c_Qry += "  	' ' XOK," + c_EOL
	c_Qry += "  	DECODE(SF2.F2_FILIAL, '01', 'RIO','NITEROI') FILIAL," + c_EOL
	c_Qry += "  	SF2.F2_DOC,		" + c_EOL
	c_Qry += "  	SF2.F2_SERIE,	" + c_EOL
	c_Qry += "  	SF3.F3_HORNFE,	" + c_EOL
	c_Qry += "  	SF3.F3_DESCRET,	" + c_EOL
	c_Qry += "  	SF3.F3_NFELETR,	" + c_EOL
	c_Qry += "  	SF3.F3_EMINFE,	" + c_EOL
	c_Qry += "  	SF3.F3_CODNFE,	" + c_EOL
	c_Qry += "  	SF3.F3_DESCRET,	" + c_EOL
	c_Qry += "     SF2.*, 			" + c_EOL
	c_Qry += "     SF2.F2_VALBRUT, 	" + c_EOL
	c_Qry += "     SE1.*			" + c_EOL
	c_Qry += "  FROM  				" + c_EOL
	c_Qry += "  	" + RetSqlName("SE1") + " SE1 	" + c_EOL
	c_Qry += "     									" + c_EOL
	c_Qry += "  		INNER JOIN 					" + c_EOL
	c_Qry += "  			" + RetSqlName("SF2") + " SF2 	" + c_EOL
	c_Qry += "  		ON 									" + c_EOL
	c_Qry += " 			   SF2.F2_FILIAL       = SE1.E1_XFILNF 	" + c_EOL
	c_Qry += "             AND SF2.F2_DOC      = SE1.E1_XDOCNF	" + c_EOL
	c_Qry += "             AND SF2.F2_SERIE    = SE1.E1_XSERNF	" + c_EOL
	c_Qry += "             AND SF2.F2_CLIENTE  = SE1.E1_CLIENTE	" + c_EOL
	c_Qry += "             AND SF2.F2_LOJA     = SE1.E1_LOJA	" + c_EOL
	c_Qry += "             AND SF2.D_E_L_E_T_  = ' '			" + c_EOL
	c_Qry += "   												" + c_EOL
	c_Qry += "         INNER JOIN  								" + c_EOL
	c_Qry += "             " + RetSqlName("SF3") + " SF3 		" + c_EOL
	c_Qry += "  		ON										" + c_EOL
	c_Qry += "             SF3.F3_FILIAL       = SF2.F2_FILIAL	" + c_EOL
	c_Qry += "             AND SF3.F3_NFISCAL  = SF2.F2_DOC		" + c_EOL
	c_Qry += "             AND SF3.F3_SERIE    = SF2.F2_SERIE	" + c_EOL
	c_Qry += "             AND SF3.F3_CLIEFOR  = SF2.F2_CLIENTE " + c_EOL
	c_Qry += "             AND SF3.F3_LOJA     = SF2.F2_LOJA	" + c_EOL
	c_Qry += "             AND SF3.F3_ESTADO   = SF2.F2_EST		" + c_EOL
	c_Qry += "             AND SF3.F3_CODISS   <> ' ' 			" + c_EOL
	
	iF l_NFTrans

		c_Qry += "             AND SF3.F3_NFELETR <> ' ' 		"  + c_EOL

	EndIf
	
	c_Qry += "             AND SF3.D_E_L_E_T_  = ' '			" + c_EOL
	c_Qry += "             										" + c_EOL
	c_Qry += "         INNER JOIN  								" + c_EOL
	c_Qry += "             " + RetSqlName("SA1") + " SA1 		" + c_EOL
	c_Qry += "  		ON										" + c_EOL
	c_Qry += "             SA1.A1_FILIAL       = '" + xFilial("SA1") + "' " + c_EOL
	c_Qry += "             AND SA1.A1_COD      = SF2.F2_CLIENTE	" + c_EOL
	c_Qry += "             AND SA1.A1_LOJA     = SF2.F2_LOJA	" + c_EOL

	If l_Rio  .and. !l_Niteroi

		c_Qry += "             AND A1_COD_MUN = '04557' 		"  + c_EOL

	ElseIf !l_Rio  .and. l_Niteroi

		c_Qry += "             AND A1_COD_MUN <> '04557' 		"  + c_EOL

	EndIf

	c_Qry += "             AND SA1.D_E_L_E_T_  = ' '			" + c_EOL
	c_Qry += "             										" + c_EOL
	c_Qry += "         INNER JOIN        						" + c_EOL
	c_Qry += "             " + RetSqlName("ZUM") + " ZUM 		" + c_EOL
	c_Qry += "         ON										" + c_EOL
	c_Qry += "             ZUM.ZUM_FILIAL      = '" + xFilial("ZUM") + "' " + c_EOL
	c_Qry += "             AND ZUM.ZUM_CODEMP  = SE1.E1_CODEMP 	" + c_EOL
	c_Qry += "             AND ZUM.ZUM_ANO     = SE1.E1_ANOBASE " + c_EOL
	c_Qry += "             AND ZUM.ZUM_MES     = SE1.E1_MESBASE " + c_EOL
	c_Qry += "             AND ZUM_DATLIB 	   <= '" + DTOS( DATE() ) + "'  " + c_EOL
	c_Qry += "             AND ZUM.D_E_L_E_T_  = ' ' 			" + c_EOL
	c_Qry += "             										" + c_EOL
	c_Qry += " WHERE 											" + c_EOL
	c_Qry += "     SE1.E1_FILIAL = '" + xFilial("SE1") + "' 	" + c_EOL

	If !Empty(DTOS(dGtEmDe)) .OR. !Empty(DTOS(cGtEmAte))

		c_Qry += "       AND E1_EMISSAO BETWEEN '" + DTOS(dGtEmDe) + "' AND '" + DTOS(cGtEmAte) + "' " + c_EOL

	EndIf

	If !Empty(cGtCliente)

		c_Qry += "       AND E1_CLIENTE = '" + cGtCliente + "' " + c_EOL

	EndIf

	If !Empty(cGtEmpDe) .OR. !Empty(cGtEmpAte)

		c_Qry += "       AND E1_CODEMP BETWEEN '" + cGtEmpDe + "' AND '" + cGtEmpAte + "' " + c_EOL

	EndIf

	If !Empty(cGtTitDe) .OR. !Empty(cGtTitAte)

		c_Qry += "       AND E1_NUM BETWEEN '" + cGtTitDe + "' AND '" + cGtTitAte + "' " + c_EOL

	EndIf

	If !Empty(DTOS(dGtVencDe)) .OR. !Empty(DTOS(dGtVenAte))

		c_Qry += "       AND E1_VENCREA BETWEEN '" + DTOS(dGtVenDe) + "' AND ' " + DTOS(dGtVenAte) + " " + c_EOL

	EndIf

	c_Qry += "     AND SE1.E1_ORIGEM = 'PLSA510'               			" + c_EOL
	c_Qry += "     AND SE1.D_E_L_E_T_ = ' '   							" + c_EOL

	/*
	c_Qry += " SELECT	" + c_EOL
	c_Qry += " 	' ' XOK," + c_EOL
	c_Qry += " 	DECODE(F2_FILIAL, '01', 'RIO','NITEROI') FILIAL," + c_EOL
	c_Qry += " 	F2_DOC,		" + c_EOL
	c_Qry += " 	F2_SERIE,	" + c_EOL
	c_Qry += " 	F3_HORNFE,	" + c_EOL
	c_Qry += " 	F3_DESCRET,	" + c_EOL
	c_Qry += " 	F3_NFELETR,	" + c_EOL
	c_Qry += " 	F3_EMINFE,	" + c_EOL
	c_Qry += " 	F3_CODNFE,	" + c_EOL
	c_Qry += " 	F3_DESCRET,	" + c_EOL
	c_Qry += "  SF2.*, 		" + c_EOL
	c_Qry += "  F2_VALBRUT, " + c_EOL
	c_Qry += "  SE1.*		" + c_EOL
	c_Qry += " FROM  		" + c_EOL
	c_Qry += " 	" + RetSqlName("SE1") + " SE1 			" + c_EOL
	c_Qry += " 		INNER JOIN 							" + c_EOL
	c_Qry += " 			" + RetSqlName("SF2") + " SF2 	" + c_EOL
	c_Qry += " 		ON 									" + c_EOL
	c_Qry += "			F2_FILIAL = E1_XFILNF			" + c_EOL
	c_Qry += "  		AND F2_DOC = E1_XDOCNF			" + c_EOL
	c_Qry += "  		AND F2_SERIE = E1_XSERNF		" + c_EOL
	c_Qry += "  		AND F2_CLIENTE = E1_CLIENTE		" + c_EOL
	c_Qry += "  	INNER JOIN  						" + c_EOL
	c_Qry += "  		" + RetSqlName("SF3") + " SF3 	" + c_EOL
	c_Qry += " 		ON									" + c_EOL
	c_Qry += "  		F2_FILIAL = E1_XFILNF			" + c_EOL
	c_Qry += "  		AND F3_NFISCAL = F2_DOC			" + c_EOL
	c_Qry += "  		AND F3_SERIE = F2_SERIE			" + c_EOL
	c_Qry += "  		AND F3_CLIEFOR = F2_CLIENTE 	" + c_EOL
	c_Qry += "  	INNER JOIN  						" + c_EOL
	c_Qry += "  		" + RetSqlName("SA1") + " SA1 	" + c_EOL
	c_Qry += " 		ON									" + c_EOL
	c_Qry += "  		A1_FILIAL = '"+xFilial("SA1")+"'" + c_EOL
	c_Qry += "  		AND A1_COD = F2_CLIENTE  		" + c_EOL
	c_Qry += "WHERE E1_FILIAL = '01' 					" + c_EOL

	If !Empty(DTOS(dGtEmDe)) .OR. !Empty(DTOS(cGtEmAte))

		c_Qry += "       AND E1_EMISSAO BETWEEN '" + DTOS(dGtEmDe) + "' AND '" + DTOS(cGtEmAte) + "' " + c_EOL

	EndIf

	If !Empty(cGtCliente)

		c_Qry += "       AND E1_CLIENTE = '" + cGtCliente + "' " + c_EOL

	EndIf

	If !Empty(cGtEmpDe) .OR. !Empty(cGtEmpAte)

		c_Qry += "       AND E1_CODEMP BETWEEN '" + cGtEmpDe + "' AND '" + cGtEmpAte + "' " + c_EOL

	EndIf

	If !Empty(cGtTitDe) .OR. !Empty(cGtTitAte)

		c_Qry += "       AND E1_NUM BETWEEN '" + cGtTitDe + "' AND '" + cGtTitAte + "' " + c_EOL

	EndIf

	If !Empty(DTOS(dGtVencDe)) .OR. !Empty(DTOS(dGtVenAte))

		c_Qry += "       AND E1_VENCREA BETWEEN '" + DTOS(dGtVenDe) + "' AND ' " + DTOS(dGtVenAte) + " " + c_EOL

	EndIf

	If l_Rio  .and. !l_Niteroi

		c_Qry += "       AND A1_COD_MUN = '04557' "  + c_EOL

	ElseIf !l_Rio  .and. l_Niteroi

		c_Qry += "       AND A1_COD_MUN <> '04557' "  + c_EOL

	EndIf

	iF l_NFTrans

		c_Qry += "       AND F3_NFELETR <> ' ' "  + c_EOL

	EndIf

	c_Qry += "       AND E1_ORIGEM = 'PLSA510'  " + c_EOL

	c_Qry += "       AND EXISTS (SELECT * " + c_EOL
	c_Qry += "                   FROM " + RetSqlName("ZUM") + " ZUM " + c_EOL
	c_Qry += "                   WHERE ZUM_FILIAL = ' ' " + c_EOL
	c_Qry += "                         AND ZUM_CODEMP = E1_CODEMP " + c_EOL
	c_Qry += "                         AND ZUM_ANO = E1_ANOBASE  " + c_EOL
	c_Qry += "                         AND ZUM_MES = E1_MESBASE  " + c_EOL
	c_Qry += "                         AND ZUM_DATLIB <= '" + dtos( Date() )+ "'  " + c_EOL
	c_Qry += "                         AND ZUM.D_E_L_E_T_ = ' ' ) " + c_EOL

	c_Qry += "       AND f3_CODISS <> ' ' " + c_EOL
	c_Qry += "       AND SE1.D_E_L_E_T_ = ' ' " + c_EOL
	c_Qry += "       AND SF2.D_E_L_E_T_ = ' ' " + c_EOL
	c_Qry += "       AND SF3.D_E_L_E_T_ = ' ' " + c_EOL
	c_Qry += "       AND SA1.D_E_L_E_T_ = ' ' " + c_EOL
	*/
	MemoWrit("C:\Temp\TMP850B020.txt",c_Qry)

	If TcCanOpen("QRYPENF")
		TcDelFile("QRYPENF")
	Endif

	If Select("QRYPENF") <> 0
		("QRYPENF")->(DbCloseArea())
	Endif

	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),"QRYPENF",.T.,.T.)

	For ni := 2 to Len(aStrNf)
		If aStrNf[ni,2] != 'C'
			TCSetField("QRYPENF", aStrNf[ni,1], aStrNf[ni,2],aStrNf[ni,3],aStrNf[ni,4])
		Endif
	Next

	cTmp3 := CriaTrab(NIL,.F.) //CriaTrab(aStruct,.T.)
	Copy To &cTmp3

	dbCloseArea()

	dbUseArea(.T.,,cTmp3,"QRYPENF",.T.)

	("QRYPENF")->(DbGoTop())

	If ("QRYPENF")->(Eof())

		lRet := .F.

	Endif

	oBrNF:Refresh()
	oDlg:Refresh()

Return


Static Function fAtuNf(cTmpAlias,cCampoOk,cGet,lTodos)

	Local cMarca := " "

	SA1->(DbSetOrder(1))
	If lTodos <> Nil .And. lTodos
		(c_AliasnF)->(DbGoTop())
		cMarca := If(Empty((c_AliasnF)->&(cCampoOk)),"X","")
		While (c_AliasnF)->(!Eof())
			(c_AliasnF)->(RecLock(c_AliasnF,.F.))
			(c_AliasnF)->&(cCampoOk) := cMarca
			(c_AliasnF)->(MsUnLock())
			If Empty((c_AliasnF)->&(cCampoOk))
				nTotReg --
			Else
				nTotReg ++
			Endif
			(c_AliasnF)->(DbSkip())
		End
		(cTmpAlias)->(DbGoTop())
	Else
		(c_AliasnF)->(RecLock(c_AliasnF,.F.))
		(c_AliasnF)->&(cCampoOk) := If(Empty((c_AliasnF)->&(cCampoOk)),"X","")
		(c_AliasnF)->(MsUnLock())
		If Empty((c_AliasnF)->&(cCampoOk))
			nTotReg --
		Else
			nTotReg ++
		Endif
	Endif

	oBrNf:Refresh()
	oDlg:Refresh()

Return(.T.)


User Function ACERTANUM(c_tabela, c_Campo, n_Qtd)

	Local n_Count := 0

	Default n_Qtd := 0

	For n_Count := 1 to n_Qtd

		GetSX8Num(c_tabela,c_Campo)
		ConfirmSX8()

	Next

	Alert("FIM")

Return
