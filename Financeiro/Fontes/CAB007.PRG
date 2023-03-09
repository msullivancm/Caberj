
/*/

Autor	  : Leonardo Miranda (Korus Consultoria Ltda)
-----------------------------------------------------------------------------
Data	  : 18/11/2007
-----------------------------------------------------------------------------
Descricao : Pagamento de Reembolso
-----------------------------------------------------------------------------
Partida   : Menu de Usuario

/*/

#Define CRLF Chr(13)+Chr(10)
#Include "Rwmake.Ch"
#Include "Colors.Ch"
#Include "TbiConn.Ch"
#include "topconn.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"
#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}

User Function CAB007()

	Local nIt := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Define FONT oFont1 	NAME "Arial" SIZE 0,20  Bold
	Define FONT oFont2 	NAME "Arial" SIZE 0,15  Bold

	Private oFntAri13N	:= TFont():New( "Arial"       ,,-13,,.F.,,,,,.F. )
	Private oFntAri11N	:= TFont():New( "Arial"       ,,-11,,.F.,,,,,.F. )
	Private dVencDe		:= Ctod("")
	Private dVencAte	:= Ctod("")
	Private dDttroca    := Ctod("")
	Private dAntDtaV    := Ctod("")
	Private dAntDtaR    := Ctod("")
	Private cNumero		:= Space(TamSx3("EA_NUMBOR" )[1])
	Private cBanco		:= Space(TamSx3("A6_COD"    )[1])
	Private cAgencia	:= Space(TamSx3("A6_AGENCIA")[1])
	Private cConta		:= Space(TamSx3("A6_NUMCON" )[1])
	Private cDvConta	:= Space(TamSx3("A6_DVCTA" )[1])
	Private cModPgto	:= Space(TamSx3("EA_MODELO" )[1])
	Private cTipoPag	:= Space(TamSx3("EA_MODELO" )[1])
	Private cAlias		:= "SE1"
	Private cCampoOk	:= "E1_OK"
	Private aButtons	:= {}
	Private bOk			:= {|| Processa({|| fProcBordero(lExcBord)})}
	//	Private bOk			:= {|| MsgRun("Aguarde... Executando Processo","Aguarde...",{|| fProcBordero(lExcBord)}) }
	Private bCancel		:= {|| oDlgBord:End()                                                                    }
	Private bVldTpPgto	:= {|| MsgRun("Aguarde... Selecionando Registros",,         {|| fMontaBrowse(.f.)})      }
	Private bVldNumero	:= {|| !Empty(cNumero) .And. FExcluiBord() }
	Private bVlddt      := {|| HabilitaDt()  }
	Private cColunas	:= ""
	Private aCampos		:= {}
	Private _cEmp007	:= Iif(Substr(cNumEmp,1,2)=="01","C","I")
	Private cAliasTmp	:= substr(strtran(Alltrim(cUserName), '.', ''),1,5)+'1'+_cEmp007+GetNextAlias()
	//	Private cAliasTmp	:= strtran(Alltrim(cUserName), '.', '')+'1'+_cEmp007+GetNextAlias()  // Marcela Coimbra - Cahamdo 12074
	//	Private cAliasTmp	:= Alltrim(cUserName)+'1'+_cEmp007+GetNextAlias() // Marcela Coimbra - Chamado 2946
	Private oOk			:= LoadBitMap(GetResources() , "LBOK_OCEAN" )
	Private onOk		:= LoadBitMap(GetResources() , "LBNO_OCEAN" )
	//	Private cChave		:= "E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA"
	Private cChave		:= "CODPLANO+B44_YCDPTC"
	Private aStruct		:= {}
	Private nTotReg		:= 0
	Private nTotVlr		:= 0
	Private cNatPln		:= ""
	Private cCusto		:= ""
	Private cPlano		:= " "
	Private aFiltro		:= {"TODOS","AXF" ,"RLE"}
	Private aPgRec      := {"Não", "Sim"}
	Private cPgrec      := Space(13)
	Private cStatusAt	:= Space(06)
	Private aSN			:= {"S" ,"N"}
	Private cSN			:= Space(06)
	Private lBordero	:=  .T.
	Private lMarcaF4	:=  .F.

	private cClaVl      := ' '
	private cItCont     := ' '

	private	cBancoDig  := strTran(GetMv("MV_BCODIG"),"|","','") //GetMv("MV_BCODIG")

	// Trava a rotina para que seja utilizada somente por um usuário.
	If !fProcInUse(.T., {"CAB007"})
		Return .F.
	EndIf
	// --

	cNumero := Soma1(GetMV("MV_NUMBORP"),6)
	While !MayIUseCode("E2_NUMBOR"+xFilial("SE2")+cNumero)
		cNumero := Soma1(cNumero)
	EndDo

	While .T.
		If !MayIUseCode("E2_NUMBOR"+xFilial("SE2")+cNumero)
			Help(" ",1,"A460LIQ")
		Else
			Exit
		EndIf
	EndDo

	SX3->(DbSetOrder(1))
	SX3->(DbSetOrder(2))
	SX3->(DbSeek(cCampoOk))
	Aadd(aCampos, {"", cCampoOk, SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL, SX3->X3_PICTURE})
	Aadd(aStruct, {cCampoOk, SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL})

	SX3->(DbSetOrder(1))
	SX3->(DbSeek(cAlias))
	While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == cAlias
		If (x3Uso(SX3->X3_USADO)                    .And. ;
				cNivel                 >= SX3->X3_NIVEL .And. ;
				SX3->X3_CONTEXT        <> "V"           .And. ;
				SX3->X3_BROWSE         == "S")          .Or.  ;
				Alltrim(SX3->X3_CAMPO) == "E1_SALDO"
			Aadd(aCampos,{SX3->X3_TITULO,SX3->X3_CAMPO,SX3->X3_TIPO   ,SX3->X3_TAMANHO,SX3->X3_DECIMAL,SX3->X3_PICTURE})
			Aadd(aStruct,{SX3->X3_CAMPO ,SX3->X3_TIPO ,SX3->X3_TAMANHO,SX3->X3_DECIMAL                                })
			cColunas += SX3->X3_CAMPO+","
		EndIf
		SX3->(DbSkip())
	EndDo

	// Jean
	aAdd(aCampos,{"PLANO", "CODPLANO", "C", 4, 0, ""})
	aAdd(aStruct,{"CODPLANO", "C", 4, 0})

	aAdd(aCampos,{"B44_OPEUSR", "B44_OPEUSR", "C", 4, 0, ""})
	aAdd(aStruct,{"B44_OPEUSR", "C", 4, 0})

	aAdd(aCampos,{"B44_CODEMP", "B44_CODEMP", "C", 4, 0, ""})
	aAdd(aStruct,{"B44_CODEMP", "C", 4, 0})

	aAdd(aCampos,{"B44_MATRIC", "B44_MATRIC", "C", 6, 0, ""})
	aAdd(aStruct,{"B44_MATRIC", "C", 6, 0})

	aAdd(aCampos,{"B44_TIPREG", "B44_TIPREG", "C", 2, 0, ""})
	aAdd(aStruct,{"B44_TIPREG", "C", 2, 0})

	aAdd(aCampos,{"B44_YCDPTC", "B44_YCDPTC", "C", 8, 0, ""})
	aAdd(aStruct,{"B44_YCDPTC", "C", 8, 0})

	If Select(cAliasTmp) <> 0
		(cAliasTmp)->(DbCloseArea())
	EndIf

	If TcCanOpen(cAliasTmp)
		TcDelFile(cAliasTmp)
	EndIf

	cCol2	:= cColunas + "SE1.D_E_L_E_T_ AS D_E_L_E_T_ ,SE1.R_E_C_N_O_ AS R_E_C_N_O_ , RETORNA_PLANO_USU_MS ( '"
	cCol2 	+= _cEmp007 + "',B44_OPEUSR,SUBSTR (B44_CODEMP,1,4) , B44_MATRIC, B44_TIPREG,'C') AS CODPLANO,"
	cCol2 	+= " B44_OPEUSR, SUBSTR (B44_CODEMP,1,4) B44_CODEMP, "
	cCol2 	+= " B44_MATRIC, B44_TIPREG, B44_YCDPTC "

	cColunas += "D_E_L_E_T_,R_E_C_N_O_ ,CODPLANO, B44_OPEUSR, B44_CODEMP, B44_MATRIC, B44_TIPREG, B44_YCDPTC "

	DbCreate(cAliasTmp,aStruct,"TopConn")

	If Select(cAliasTmp) <> 0
		(cAliasTmp)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TopConn",cAliasTmp,cAliasTmp,.T.,.F.)
	(cAliasTmp)->(DbCreateIndex(cAliasTmp, cChave, {|| &cChave}, .F. ))
	(cAliasTmp)->(DbCommit())
	(cAliasTmp)->(DbClearInd())
	(cAliasTmp)->(DbSetIndex(cAliasTmp))

	oDlgBord:=TDialog():New(000,000,550,900,"Pagamento de Reembolso / Aux. Funeral ",,,,,,,,,.T.)
	oDlgBord:nClrPane:= RGB(255,255,254)
	oDlgBord:bStart  := {||(EnchoiceBar(oDlgBord,bOk,bCancel,,aButtons))}

	oSay01 := TSay():New(033,005,{|| "Numero"                          },oDlgBord,,oFntAri13N,,,,.T.,,,025,10)
	oSay02 := TSay():New(033,082,{|| "Vencto De"                       },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)
	oSay03 := TSay():New(033,187,{|| "Vencto Ate"                      },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)
	oSay11 := TSay():New(033,292,{|| "Listar Titulos"                  },oDlgBord,,oFntAri13N,,,,.T.,,,060,10)
	oSay12 := TSay():New(033,385,{|| "Borderô"                         },oDlgBord,,oFntAri13N,,,,.T.,,,025,10)

	oSay04 := TSay():New(050,005,{|| "Banco"                           },oDlgBord,,oFntAri13N,,,,.T.,,,025,10)
	oSay05 := TSay():New(050,082,{|| "Agencia"                         },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)
	oSay06 := TSay():New(050,187,{|| "Conta"                           },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)
	oSay07 := TSay():New(050,292,{|| "Modelo"                          },oDlgBord,,oFntAri13N,,,,.T.,,,025,10)
	oSay08 := TSay():New(050,385,{|| "Tipo Pgto"                       },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)

	oSay13 := TSay():New(067,005,{|| "Ajusta Dt"                       },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)
	oSay14 := TSay():New(067,187,{|| "Dt Ajuste"                       },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)

	oSay09 := TSay():New(250,005,{|| "Total de Registros Selecionados" },oDlgBord,,oFntAri13N,,,,.T.,,,100,10)
	oSay10 := TSay():New(250,300,{|| "Valor Total"                     },oDlgBord,,oFntAri13N,,,,.T.,,,035,10)

	oGet01 := TGet():New(oSay01:nTop/2,oSay01:nRight/2+10,bSetGet(cNumero ),oDlgBord,035,10,""                        ,{||Eval(bVldNumero)},,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,""   ,"cNumero" )
	oGet02 := TGet():New(oSay02:nTop/2,oSay02:nRight/2+10,bSetGet(dVencDe ),oDlgBord,050,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,""   ,"dVencDe" )
	oGet03 := TGet():New(oSay03:nTop/2,oSay03:nRight/2+10,bSetGet(dVencAte),oDlgBord,050,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,""   ,"dVencAte")

	oCom02 := TComboBox():New( 033,336,bSetGet(cStatusAt),aFiltro ,040,10,oDlgBord,,,,,,.T.,oFntAri13N,,,{||.T.             }                                                          )
	oCom03 := TComboBox():New( 033,425,bSetGet(cSN),aSN  ,023,05,oDlgBord,,,,,,.T.,oFntAri13N,,,{||.T.             }                                                          )

	oGet04 := TGet():New(oSay04:nTop/2,oSay04:nRight/2+10,bSetGet(cBanco  ),oDlgBord,035,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"SA6","cBanco"  )
	oGet05 := TGet():New(oSay05:nTop/2,oSay05:nRight/2+10,bSetGet(cAgencia),oDlgBord,050,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.F.},,,,.F.,,""   ,"cAgencia")
	oGet06 := TGet():New(oSay06:nTop/2,oSay06:nRight/2+10,bSetGet(cConta  ),oDlgBord,050,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.F.},,,,.F.,,""   ,"cConta"  )

	oGet07 := TGet():New(oSay07:nTop/2,oSay07:nRight/2+19,bSetGet(cModPgto),oDlgBord,030,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"58" ,"cModPgto")
	oGet08 := TGet():New(oSay08:nTop/2,oSay08:nRight/2+5,bSetGet(cTipoPag),oDlgBord,025,10,""     					  ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"59" ,"cTipoPag")
	oCom04 := TComboBox():New( 068,040,bSetGet(cPgrec),aPgRec  ,070,10,oDlgBord,,,,,,.T.,oFntAri13N,,,{||Eval(bVlddt)       }                                                   )
	oGet11 := TGet():New(oSay14:nTop/2,oSay14:nRight/2+10,bSetGet(dDttroca),oDlgBord,050,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,""  ,"dDttroca")

	oGet09 := TGet():New(oSay09:nTop/2,oSay09:nRight/2+10,bSetGet(nTotReg ),oDlgBord,050,10,""                        ,{||.T.             },,,oFntAri13N,,,.T.,,,{||.F.},,,,.F.,,""   ,"nToReg" )
	oGet10 := TGet():New(oSay10:nTop/2,oSay10:nRight/2+10,bSetGet(nTotVlr ),oDlgBord,060,10,PesqPict("SE1","E1_SALDO"),{||.T.             },,,oFntAri13N,,,.T.,,,{||.F.},,,,.F.,,""   ,"nTotVlr")

	@ 067,385 Button "Filtrar" 	 Size 050,012 Action Processa( {|| fMontaBrowse(.f.) }, "Executar Seleção ","",.T.) PIXEL OF oDlgBord

	oBrwBord:=TcBrowse():New(080,005,440,160,,,,oDlgBord,,,,,,,oDlgBord:oFont,,,,,.T.,cAliasTmp,.T.,,.F.,,,.F.)

	For nIt := 1 To Len(aCampos)
		c2 := If(nIt == 1," ",aCampos[nIt,1])
		c3 := If(nIt == 1,&("{|| If(Empty("+cAliasTmp+"->"+cCampoOk+"),onOk,oOk)}"),&("{||"+cAliasTmp+"->"+aCampos[nIt,2]+"  }"))
		c4 := If(nIt == 1,5,CalcFieldSize(aCampos[nIt,3],aCampos[nIt,4],aCampos[nIt,5],"",aCampos[nIt,1]))
		c5 := If(nIt == 1,"",aCampos[nIt,6])
		c6 := If(nIt == 1,.T.,.F.)
		oBrwBord:AddColumn(TCColumn():New(c2,c3,c5,,,"LEFT",c4,c6,.F.,,,,.F.))
	Next

	oBrwBord:bLDblClick   := {|| fAtuBrw(cAliasTmp,cCampoOk     )}
	oBrwBord:bHeaderClick := {|| fAtuBrw(cAliasTmp,cCampoOk ,,lMarcaF4:=.T.)}

	oDlgBord:Activate(,,,.T.)

	If Select(cAliasTmp) <> 0
		(cAliasTmp)->(DbCloseArea())
	EndIf

	If TcCanOpen(cAliasTmp)
		TcDelFile(cAliasTmp)
	EndIf

Return(.T.)

Static function fMontaBrowse(lExcBord,cTitulos)

	Local cVencDe	:= Dtos(dVencDe)
	Local cVencAte	:= Dtos(dVencAte)
	Local lRet		:= .T.
	Local cQry		:= ""

	cQry += CRLF+"INSERT INTO "+cAliasTmp+" ("+cCampoOk+","+cColunas
	cQry += CRLF+" ) SELECT "+If(!lExcBord,"' "+"'","'X"+"'")+","+cCol2
	cQry += CRLF+" FROM "+RetSqlName("SE1")+" SE1, "+RetSQLName("SA1")+" SA1, "+RetSQLName("B44")+" B44 "
	cQry += CRLF+" WHERE SE1.E1_FILIAL = '"+xFilial("SE1") + "'"
	If !lExcBord
		cQry += CRLF+" AND   SE1.E1_VENCREA BETWEEN '"+cVencDe+"' AND '"+cVencAte+"'"
		cQry += CRLF+" AND   SE1.E1_SALDO   > 0    "
		cQry += CRLF+" AND   SE1.E1_SITUACA = '0'  "
		cQry += CRLF+" AND   SE1.E1_TIPO    = 'NCC'"
		If cStatusAt <> 'TODOS'
			cQry += CRLF+" AND   SE1.E1_PREFIXO = "+"'"+cStatusAt+"'"
		EndIf
	Else
		cQry += CRLF+" AND   SE1.E1_PREFIXO||SE1.E1_NUM||SE1.E1_PARCELA||SE1.E1_TIPO IN "+cTitulos
	EndIf
	cQry += CRLF+" AND A1_FILIAL = '"+xFilial("SA1")+"' "
	cQry += CRLF+" AND A1_COD = E1_CLIENTE "
	cQry += CRLF+" AND A1_LOJA = E1_LOJA "

	If cModPgto == '01'

		cQry += CRLF+"	AND (TRIM( CASE "
		cQry += CRLF+"	WHEN B44_XBANCO = ' '  AND B44.B44_DTDIGI >= '20180201'  THEN B44_XBANCO"
		cQry += CRLF+"  WHEN B44_XBANCO <> ' ' AND B44.B44_DTDIGI >= '20180201'  THEN B44_XBANCO"
		cQry += CRLF+"   ELSE "
		cQry += CRLF+"  A1_XBANCO"
		cQry += CRLF+"  END  "
		cQry += CRLF+"	) IN  ('"+cBanco+"') )	"

	Else
		If cModPgto = '03'

			cQry += CRLF+"	AND (TRIM( CASE "
			cQry += CRLF+"	WHEN B44_XBANCO = ' ' AND B44.B44_DTDIGI >= '20180201'  THEN B44_XBANCO"
			cQry += CRLF+"  WHEN B44_XBANCO <> ' ' AND B44.B44_DTDIGI >= '20180201'  THEN B44_XBANCO"
			cQry += CRLF+"   ELSE "
			cQry += CRLF+"  A1_XBANCO"
			cQry += CRLF+"  END  "
			cQry += CRLF+"	) NOT IN  (' ','"+cBanco+"') )	""

			// MMT Inicio Chamado 76466
			// retirado banco digital em tipo 03
			cQry += CRLF+"	AND (TRIM( CASE "
			cQry += CRLF+"	WHEN B44_XBANCO = ' ' AND B44.B44_DTDIGI >= '20180201'  THEN B44_XBANCO"
			cQry += CRLF+"  WHEN B44_XBANCO <> ' ' AND B44.B44_DTDIGI >= '20180201'  THEN B44_XBANCO"
			cQry += CRLF+"   ELSE "
			cQry += CRLF+"  A1_XBANCO"
			cQry += CRLF+"  END  "
			cQry += CRLF+"	) NOT IN  ('"+cBancoDig+"') )	""

			// MMT Chamado 76466
			cQry += CRLF+" AND   E1_SALDO   < 5000.00    "

		Else

			If cModPgto $ '41'

				cQry += CRLF+"	AND ((TRIM( CASE "
				cQry += CRLF+"	WHEN B44_XBANCO = ' ' AND B44.B44_DTDIGI >= '20180201'  THEN B44_XBANCO"
				cQry += CRLF+"  WHEN B44_XBANCO <> ' '  AND B44.B44_DTDIGI >= '20180201' THEN B44_XBANCO "
				cQry += CRLF+"   ELSE "
				cQry += CRLF+"  A1_XBANCO"
				cQry += CRLF+"  END  "
				cQry += CRLF+"	) NOT IN  (' ','"+cBanco+"') )	"

				// MMT Inicio Chamado 76466
				// Incluido banco digital tipo 41
				cQry += CRLF+"	AND (TRIM( CASE "
				cQry += CRLF+"	WHEN B44_XBANCO = ' ' AND B44.B44_DTDIGI >= '20180201'  THEN B44_XBANCO"
				cQry += CRLF+"  WHEN B44_XBANCO <> ' ' AND B44.B44_DTDIGI >= '20180201'  THEN B44_XBANCO"
				cQry += CRLF+"   ELSE "
				cQry += CRLF+"  A1_XBANCO"
				cQry += CRLF+"  END  "
				cQry += CRLF+"	)  IN  ('"+cBancoDig+"') )	""
				cQry += CRLF+" OR  E1_SALDO   >= 5000.00    )"
				// MMT Chamado 76466

			EndIf
		EndIf
	EndIf

	cQry += CRLF+" AND   B44.B44_FILIAL = '"+xFilial("B44")+"' "
	cQry += CRLF+" AND   SE1.E1_PREFIXO = B44.B44_PREFIX "
	cQry += CRLF+" AND   SE1.E1_NUM     = B44.B44_NUM "
	cQry += CRLF+" AND   SE1.E1_PARCELA = B44.B44_PARCEL "
	cQry += CRLF+" AND   SE1.E1_TIPO    = B44.B44_TIPO "
	cQry += CRLF+" AND   B44.B44_YSITUA = '2' "

	cQry += CRLF+" AND   SE1.D_E_L_E_T_ = ' ' "
	cQry += CRLF+" AND   SA1.D_E_L_E_T_ = ' ' "
	cQry += CRLF+" AND   B44.D_E_L_E_T_ = ' ' "
	cQry += CRLF+" ORDER BY CODPLANO, B44_YCDPTC "

	MemoWrite("c:\microsiga\cab007.txt",cQry)

	TcSqlExec(cQry)
	TcRefresh(cAliasTmp)

	lBordero := cSN == "S"

	(cAliasTmp)->(DbGoTop())
	If (cAliasTmp)->(RecCount()) == 0
		ApMsgInfo("Não foram encontrados registros com os parametros informados !")
		lRet := .F.
	Else
		oGet01:bWhen := {|| .F.} ; oGet02:bWhen := {|| .F.} ; oGet03:bWhen := {|| .F.} ; oGet04:bWhen := {|| .F.}; oCom02:bWhen := {|| .F.}
		oGet05:bWhen := {|| .F.} ; oGet06:bWhen := {|| .F.} ; oGet07:bWhen := {|| .F.} ; oGet08:bWhen := {|| .F.}; oCom03:bWhen := {|| .F.}
		oGet11:bWhen := {|| .F.} ; oCom04:bWhen := {|| .F.}
		oBrwBord:Refresh()
		oDlgBord:Refresh()
	EndIf

Return(lRet)


Static Function fAtuBrw(cTmpAlias,cCampoOk,cGet,lTodos,lMarcaF4)

	If ((lTodos <> Nil .And. lTodos) .Or. (lMarcaF4))
		(cAliasTmp)->(DbGoTop())

		While (cAliasTmp)->(!Eof())
			fMmarcaTit()

			(cAliasTmp)->(DbSkip())

		EndDo
		(cTmpAlias)->(DbGoTop())
	Else
		fMmarcaTit()
	EndIf

Return(.T.)

Static Function fMmarcaTit()

	B44->(DbSetOrder(3))
	If B44->(DbSeek(xFilial("B44")+(cAliasTmp)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))) .And. B44->B44_YSITUA <> "2"
		If !(lMarcaF4)
			Help(" ",1,"A070NAOPODE",,"Titulo de Reembolso não aprovado."+(Chr(13)+Chr(10))+"Não será possivel a seleção do registro.",1,0)
		EndIf
		Return(.T.)
	EndIf

	SA1->(DbSetOrder(1))
	If SA1->(DbSeek(xFilial("SA1")+(cAliasTmp)->(E1_CLIENTE)+(cAliasTmp)->(E1_LOJA))) .And. !Empty(SA1->A1_CGC)
		(cAliasTmp)->(RecLock(cAliasTmp,.F.))
		(cAliasTmp)->&(cCampoOk) := If(Empty((cAliasTmp)->&(cCampoOk)),"X","")
		(cAliasTmp)->(MsUnLock())
		If Empty((cAliasTmp)->&(cCampoOk))
			nTotReg --
			nTotVlr -= (cAliasTmp)->E1_SALDO
		Else
			nTotReg ++
			nTotVlr += (cAliasTmp)->E1_SALDO
		EndIf
	Else
		If !(lMarcaF4)
			Help(" ",1,"A070NAOPODE",,"Cliente com CNPJ/CPF em branco."+(Chr(13)+Chr(10))+"Não será possivel a seleção do registro.",1,0)
		EndIf
	EndIf

	oGet09  :Refresh()
	oGet10  :Refresh()
	oBrwBord:Refresh()
	oDlgBord:Refresh()

Return(.T.)


Static Function fProcBordero(lExcBord)

	Local aDadSe1	:= {}
	Local aDadSe2	:= {}
	Local aDadSea	:= {}
	Local cCodFor	:= Space(TamSX3("A2_COD")[1])
	Local cLojFor	:= "01"
	Local cContab	:= GETMV("MV_XCTBFOR") //"211119031" - Angelo Henrique - Data: 06/06/2019
	Local cDirf		:= "2"
	Local cHistor	:= "PAGTO. REEMBOLSO"
	Local cFilSa1	:= xFilial("SA1")
	Local cFilSa2	:= xFilial("SA2")
	Local cFilSe1	:= xFilial("SE1")
	Local cFilSe2	:= xFilial("SE2")
	Local cFilSea	:= xFilial("SEA")
	Local cTitOrig	:= Space(TamSx3("E2_TITORIG")[1])
	Local cNumOld	:= ""

	Private lMsHelpAuto	:= .T.
	Private lMsErroAuto	:= .F.
	Private aRotina		:= {{"","",0,1},{"","",0,2},{"","",0,3},{"","",0,4},{"","Fa050Delet",0,5}}
	Private cCadastro	:= ""
	Private lAltera		:= .F.
	Private lF050Auto	:= .T.
	Private nRecno		:= 0

	SA1->(DbSetOrder(1))
	SA2->(DbSetOrder(3))
	SE1->(DbSetOrder(1))
	SE2->(DbSetOrder(1))
	B44->(DbSetOrder(3))

	Begin Transaction
		nRegs := 0
		(cAliasTmp)->(dbGoTop())
		(cAliasTmp)->(dbEval({||nRegs++}))
		(cAliasTmp)->(dbGoTop())
		ProcRegua(nRegs)

		// Verifica utilização do número do bordero.
		cNumOld := cNumero
		While !MayIUseCode("E2_NUMBOR" + xFilial("SE2") + cNumero)
			cNumero := Soma1(cNumero)
		EndDo

		cBancoSEA		:= cBanco
		cAgenciaSEA		:= cAgencia
		cContaSEA		:= cConta

		While (cAliasTmp)->(!Eof())

			IncProc()

			nRecno := (cAliasTmp)->(Recno())
			SA1->(DbSeek(cFilSa1+(cAliasTmp)->E1_CLIENTE+(cAliasTmp)->E1_LOJA))
			If !Empty((cAliasTmp)->&(cCampoOk))

				cAliasB44 := GetNextAlias()

				BeginSql Alias cAliasB44
						%noparser% 
						SELECT PCT.PCT_BANCO,PCT.PCT_NUMAGE,PCT.PCT_NCONTA, PCT.PCT_DVCONT,ZZQ_XTPRGT
						FROM  %table:B44% B44
						INNER JOIN %table:ZZQ%  ZZQ ON
						ZZQ_SEQUEN 		= B44_YCDPTC
						AND ZZQ_FILIAL 	= %xFilial:ZZQ%
						AND ZZQ_DATDIG <> ' '
						INNER JOIN %table:PCT% PCT ON
						PCT_CODIGO 		= ZZQ_DBANCA
						AND PCT_CLIENT  = %exp:(cAliasTmp)->E1_CLIENTE%
						AND PCT_LOJA	= %exp:(cAliasTmp)->E1_LOJA%
						AND PCT_FILIAL 	= %xFilial:PCT%
						WHERE
						B44_FILIAL 		= %xFilial:B44%
						AND B44_PREFIX 	= %exp:(cAliasTmp)->E1_PREFIXO%
						AND B44_NUM   	= %exp:(cAliasTmp)->E1_NUM%
						AND B44_PARCEL 	= %exp:(cAliasTmp)->E1_PARCELA%
						AND B44_TIPO  	= 'NCC'
						AND B44.D_E_L_E_T_ = ' '
						AND PCT.D_E_L_E_T_ = ' '
						AND ZZQ.D_E_L_E_T_ = ' '
				Endsql

				If !Empty((cAliasB44)->PCT_BANCO)
					cBanco 		:= alltrim((cAliasB44)->PCT_BANCO)
					cAgencia 	:= alltrim((cAliasB44)->PCT_NUMAGE)
					cConta 		:= ALLTRIM((cAliasB44)->PCT_NCONTA)
					cDVConta	:= ALLTRIM((cAliasB44)->PCT_DVCONT)
				Else
					cBanco		:= AllTrim(SA1->A1_XBANCO)
					cAgencia	:= AllTrim(SA1->A1_XAGENC)
					cConta		:= AllTrim(SA1->A1_XCONTA)
					cDvConta	:= AllTrim(SA1->A1_XDGCON)
				Endif

				if select(cAliasB44) > 0
					(cAliasB44)->(dbclosearea())
				endif

				SA2->(DbSetOrder(3))
				If !SA2->(DbSeek(cFilSa2+SA1->A1_CGC)) .And. !lExcBord
					cCodFor := GetSX8Num("SA2","A2_COD")

					aDadSa2 := {{"A2_COD"     ,cCodFor         			,Nil},;
						{"A2_LOJA"    ,cLojFor         			,Nil},;
						{"A2_NOME"    ,SA1->A1_NOME    			,Nil},;
						{"A2_NREDUZ"  ,SA1->A1_NREDUZ  			,Nil},;
						{"A2_CGC"     ,SA1->A1_CGC     			,Nil},;
						{"A2_END"     ,SA1->A1_END     			,Nil},;
						{"A2_EST"     ,'RJ'            			,Nil},;
						{"A2_COD_MUN" ,'04557'         			,Nil},;
						{"A2_MUN"     ,'RIO DE JANEIRO'			,Nil},;
						{"A2_CEP"     ,SA1->A1_CEP     			,Nil},;
						{"A2_CONTATO" ,SA1->A1_CONTATO 			,Nil},;
						{"A2_TEL"     ,SA1->A1_TEL     			,Nil},;
						{"A2_DDD"     ,SA1->A1_DDD     			,Nil},;
						{"A2_FAX"     ,SA1->A1_FAX     			,Nil},;
						{"A2_CONTA"   ,cContab         			,Nil},;
						{"A2_TIPO"    ,SA1->A1_TIPO  			,Nil},;
						{"A2_DIRF"    ,cDirf           			,Nil},;
						{"A2_YTPTITU" ,'4'             			,Nil}}

					MSExecAuto({|x,y| MATA020(x,y)},aDadSa2,3)

					If lMsErroAuto
						RollBackSX8()
						DisarmTransaction()
						MostraErro()
						Exit
					Else

						ConfirmSX8()

						//------------------------------------------------------------------
						//Angelo Henrique - Data: 07/05/2019
						//------------------------------------------------------------------
						//Após a migração o ExecAuto estava apresentando erro
						//para as informações que funcionavam na P11
						//------------------------------------------------------------------
						DbSelectArea("SA2")
						DbSetOrder(1)
						If DbSeek(xFilial("SA2") + cCodFor + cLojFor)

							RecLock("SA2", .F.)

							SA2->A2_BAIRRO	:= SA1->A1_BAIRRO
							SA2->A2_EMAIL	:= AllTrim(SA1->A1_EMAIL)

							// MMT 05/08/2022 Chamado 89116
							IF cModPgto $ '41_45'
								SA2->A2_FORMPAG := "45"
							Endif

							SA2->A2_BANCO	:= cBanco
							SA2->A2_AGENCIA	:= cAgencia
							SA2->A2_NUMCON	:= cConta
							SA2->A2_YDAC   	:= cDVConta
							SA2->(MsUnLock())

						Endif

					Endif

				Else

					SA2->(Reclock("SA2",.F.))
					SA2->A2_NOME 	:= SA1->A1_NOME
					SA2->A2_END		:= SA1->A1_END
					SA2->A2_BAIRRO	:= SA1->A1_BAIRRO
					SA2->A2_MUN		:= SA1->A1_MUN
					SA2->A2_EST		:= SA1->A1_EST
					SA2->A2_CEP		:= SA1->A1_CEP
					SA2->A2_CONTATO	:= SA1->A1_CONTATO
					SA2->A2_TEL		:= SA1->A1_TEL
					SA2->A2_DDD		:= SA1->A1_DDD
					SA2->A2_FAX		:= SA1->A1_FAX
					SA2->A2_EMAIL	:= SA1->A1_EMAIL
					SA2->A2_CONTA	:= cContab
					SA2->A2_TIPO	:= SA1->A1_PESSOA
					SA2->A2_BANCO	:= cBanco
					SA2->A2_AGENCIA	:= cAgencia
					SA2->A2_NUMCON	:= cConta
					SA2->A2_YDAC   	:= cDVConta

					SA2->(MsUnlock())

					cCodFor := SA2->A2_COD
				EndIf

				SE1->(DbSeek(cFilSe1+(cAliasTmp)->E1_PREFIXO+(cAliasTmp)->E1_NUM+(cAliasTmp)->E1_PARCELA+(cAliasTmp)->E1_TIPO))
				aDadSe1 :={{"E1_PREFIXO"  ,(cAliasTmp)->E1_PREFIXO , Nil }, {"E1_NUM"      ,(cAliasTmp)->E1_NUM     , Nil },;
					{"E1_PARCELA"  ,(cAliasTmp)->E1_PARCELA , Nil }, {"E1_TIPO"     ,(cAliasTmp)->E1_TIPO    , Nil },;
					{"E1_CLIENTE"  ,(cAliasTmp)->E1_CLIENTE , Nil }, {"E1_LOJA"     ,(cAliasTmp)->E1_LOJA    , Nil },;
					{"AUTMOTBX"    ,'REE'                   , Nil }, {"AUTBANCO"    ,cBanco                  , Nil },;
					{"AUTAGENCIA"  ,cAgencia                , Nil }, {"AUTCONTA"    ,cConta                  , Nil },;
					{"AUTDTBAIXA"  ,dDataBase               , Nil }, {"AUTDTCREDITO",dDataBase               , Nil },;
					{"AUTHIST"     ,cHistor                 , Nil }, {"AUTVALREC"   ,(cAliasTmp)->E1_SALDO   , Nil }}
				lMsErroAuto := .F.
				MsExecAuto({ |x,y| Fina070(x,y)},aDadSe1,if(!lExcBord,3,5))
				If lMsErroAuto
					DisarmTransaction()
					MostraErro()
					Exit
				Else

					DbSelectArea("SE5")
					DbSetOrder(7) //E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ
					If DbSeek(xFilial("SE5") + (cAliasTmp)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))

						Reclock("SE5",.F.)
						SE5->E5_FILORIG := xFilial("SE5") //Reforçando a atualização do campo
						SE5->(MsUnLock())

					EndIf

				Endif

				If cPgrec = "Sim"
					SE1->(Reclock("SE1",.F.))
					SE1->E1_VENCTO  :=  dDttroca
					SE1->E1_VENCREA :=  dDttroca
					SE1->E1_FLUXO := "N"
					SE1->(MsUnlock())
				EndIf

				cTitOrig:= (cAliasTmp)->E1_PREFIXO+(cAliasTmp)->E1_NUM+(cAliasTmp)->E1_PARCELA+(cAliasTmp)->E1_TIPO

				fEmpPla(cTitOrig) // le dados de classe de valor e item contabil

				If lBordero
					aDadSEA := {}
					aAdd(aDadSEA, {"EA_FILIAL"	, cFilSea					})
					aAdd(aDadSEA, {"EA_PORTADO"	, cBancoSEA					})
					aAdd(aDadSEA, {"EA_AGEDEP"	, cAgenciaSEA				})
					aAdd(aDadSEA, {"EA_NUMCON"	, cContaSEA					})
					aAdd(aDadSEA, {"EA_NUMBOR"	, cNumero					})
					aAdd(aDadSEA, {"EA_DATABOR"	, dDataBase					})
					aAdd(aDadSEA, {"EA_PREFIXO"	, (cAliasTmp)->E1_PREFIXO	})
					aAdd(aDadSEA, {"EA_NUM"		, (cAliasTmp)->E1_NUM		})
					aAdd(aDadSEA, {"EA_PARCELA"	, (cAliasTmp)->E1_PARCELA	})
					aAdd(aDadSEA, {"EA_TIPO"	, "REM"						})
					aAdd(aDadSEA, {"EA_FORNECE"	, cCodFor					})
					aAdd(aDadSEA, {"EA_LOJA"	, cLojFor					})
					aAdd(aDadSEA, {"EA_CART"	, "P"						})
					aAdd(aDadSEA, {"EA_MODELO"	, cModPgto					})
					aAdd(aDadSEA, {"EA_TIPOPAG"	, cTipoPag					})
					aAdd(aDadSEA, {"EA_FILORIG"	, cFilAnt					})

					fGeraSEA(aDadSEA, lExcBord)
				Endif

				// Tratamento de centro de custo e natureza por empresa e plano
				cNatPln := (cAliasTmp)->E1_NATUREZ
				If (SubStr(cNumEmp,1,2) == "01")
					cCusto := "998"
					If (cAliasTmp)->E1_PREFIXO <> 'AXF'
						cNatPln = '40001'
					EndIf
				Else
					If (substr(cNumEmp,1,2) == "02")
						cCusto := "99999"
						cNatPln = '40001'
					EndIf
				EndIf
				// --

				B44->(DbSeek(xFilial("B44")+(cAliasTmp)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)))

				aDadSe2 :={{"E2_PREFIXO"  ,TRIM((cAliasTmp)->E1_PREFIXO) ,Nil} , {"E2_NUM"      ,(cAliasTmp)->E1_NUM     ,Nil},;
					{"E2_PARCELA"  ,(cAliasTmp)->E1_PARCELA ,Nil}, {"E2_TIPO"     ,'REM'                   ,Nil},;
					{"E2_NATUREZ"  ,cNatPln                 ,Nil}, {"E2_FORNECE"  ,cCodFor                 ,Nil},;
					{"E2_LOJA"     ,cLojFor                 ,Nil}, {"E2_EMISSAO"  ,(cAliasTmp)->E1_EMISSAO ,NIL},;
					{"E2_VENCTO"   ,(cAliasTmp)->E1_VENCTO  ,NIL}, {"E2_VENCREA"  ,(cAliasTmp)->E1_VENCREA ,NIL},;
					{"E2_HIST"     ,'ASSOC ' + B44->B44_NOMUSR   ,Nil}, {"E2_CCD"      ,cCusto             ,Nil},;
					{"E2_VALOR"    ,(cAliasTmp)->E1_SALDO   ,Nil}, {"E2_NUMB0R"   ,If(!lExcBord,cNumero,""),Nil},;
					{"E2_PORTADO"  ,If(!lExcBord,cBanco,"") ,Nil}, {"E2_TITORIG"  ,cTitOrig                ,Nil},;
					{"E2_CLVL"     ,cClaVl                  ,Nil}, {"E2_ITEMCTA"  ,cItCont                 ,NIL}}

				lMsErroAuto := .F.
				If lExcBord .And. SE2->(DbSeek(cFilSe2+aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_PREFIXO"}),2]+;
						aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_NUM"    }),2]+;
						aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_PARCELA"}),2]+;
						aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_TIPO"   }),2]+;
						aDadSe2[aScan(aDadSe2, {|X| X[1] == "E2_FORNECE"}),2]+;
						aDadSe2[aScan(aDadse2, {|X| X[1] == "E2_LOJA"   }),2]))
					SE2->(RecLock("SE2",.F.)) ; SE2->E2_NUMBOR  := "" ; SE2->E2_PORTADO := "" ; SE2->(MsUnLock())
					RegToMemory("SE2",.F.,.F.)
					Fa050Delet("SE2",SE2->(Recno()),5)
				Else
					MsExecAuto({ |x,y| Fina050(x,y)},aDadSe2,3)
					If lMsErroAuto
						DisarmTransaction()
						MostraErro()
						Exit
					ElseIf !lMsErroAuto .And. !lExcBord

						SE2->(Reclock("SE2",.F.))

						If SE2->E2_PREFIXO <> 'AXF'
							SE2->E2_ORIGEM := 'CAB007'
						EndIf

						If lBordero

							SE2->E2_NUMBOR  := cNumero
							SE2->E2_PORTADO := cBanco

						Endif

						if cPgrec = "Sim"

							SE2->E2_YDTVANT :=  SE2->E2_VENCREA
							SE2->E2_VENCREA :=  dDttroca

						EndIf

						SE2->(MsUnlock())

					Endif
				Endif
			Endif
			(cAliasTmp)->(DbGoTo(nRecno))
			(cAliasTmp)->(DbSkip())
		EndDo
	End Transaction

	If cNumOld != cNumero
		ApMsgAlert("Numero do bordero alterado para " + cNumero)
	EndIf

	If !lMsErroAuto     // MMT Criar mensagem Bordero Gerado
		ApMsgAlert("Bordero gerado numero " + cNumero)
		oDlgBord:End()
	else
		MostraErro()
	Endif

Return(.T.)


Static Function HabilitaDt() //HABILITA O COMBO DA DATA DE ATUALIZAÇÃO

	If cPgrec <> "Não"
		oGet11:bWhen := {|| .T.}
	Else
		oGet11:bWhen := {|| .F.}
		dDttroca  := Ctod("")
	endIf
	oBrwBord:Refresh()
	oDlgBord:Refresh()

Return(.T.)


Static Function fGeraSEA(aDados,lExcBord)

	Local iT := 1

	If !lExcBord
		SEA->(RecLock("SEA",.T.))
		For iT := 1 To Len(aDados)
			SEA->(FieldPut(FieldPos(aDados[iT,1]),aDados[iT,2]))
		Next
		SEA->(MsUnlock())
	Else
		SEA->(DbSetOrder(2))
		If SEA->(DbSeek(xFilial("SEA")+aDados[aScan(aDados, {|X| X[1] == "EA_NUMBOR" }),2]+"P"+;
				aDados[aScan(aDados, {|X| X[1] == "EA_PREFIXO"}),2]+;
				aDados[aScan(aDados, {|X| X[1] == "EA_NUM"    }),2]+;
				aDados[aScan(aDados, {|X| X[1] == "EA_PARCELA"}),2]+;
				aDados[aScan(aDados, {|X| X[1] == "EA_TIPO"   }),2]+;
				aDados[aScan(aDados, {|X| X[1] == "EA_FORNECE"}),2]+;
				aDados[aScan(aDados, {|X| X[1] == "EA_LOJA"   }),2]))
			SEA->(RecLock("SEA",.F.))
			SEA->(DbDelete())
			SEA->(MsUnlock())
		EndIf
	EndIf

	Putmv("MV_NUMBORP",cNumero) // NNT ALERT

Return(.T.)


Static Function fExcluiBord()

	Local   lRetorno := .T.
	Local   cFilSA1  := xFilial("SA1")
	Local   cFilSA2  := xFilial("SA2")
	Local   cFilSE2  := xFilial("SE2")
	Local   cTitulos := ""
	Public  lExcBord := .F.

	SA1->(DbSetOrder(3))
	SA2->(DbSetOrder(1))
	SE2->(DbSetOrder(1))
	SEA->(DbSetOrder(1))

	If SEA->(DbSeek(xFilial("SEA")+cNumero))
		If ApMsgYesNo("Já existe bordero com este numero. Deseja excluir","SIMNAO")
			lExcBord := .T.
			cBanco   := SEA->EA_PORTADO ; cAgencia := SEA->EA_AGEDEP
			cConta   := SEA->EA_NUMCON  ; cModPgto := SEA->EA_MODELO
			cTipoPag := SEA->EA_TIPOPAG
			While SEA->(!Eof()) .And. SEA->EA_NUMBOR == cNumero
				SA2->(DbSeek(cFilSA2+SEA->EA_FORNECE+SEA->EA_LOJA))
				SA1->(DbSeek(cFilSA1+SA2->A2_CGC))
				SE2->(DbSeek(cFilSE2+SEA->EA_PREFIXO+SEA->EA_NUM+SEA->EA_PARCELA+SEA->EA_TIPO+SEA->EA_FORNECE+SEA->EA_LOJA))
				cTitulos  += SE2->E2_TITORIG+"|"
				SEA->(DbSkip())
			EndDo
			cTitulos := FormatIn(cTitulos ,"|")
			oBrwBord:bLDblClick   := {|| .T. }
			oBrwBord:Refresh()
			MsgRun("Aguarde... Selecionando Registros",,{|| fMontaBrowse(lExcBord,cTitulos)})
		Else
			lRetorno := .F.
		EndIf
	EndIf

Return(lRetorno)

/*/{Protheus.doc} fProcInUse
Verifica concorrencia de processos
@type function
@version 1.0 
@author angelo.cassago
@since 23/09/2022
@param lMostraErro, logical, variavel q ira ou nao mostrar o erro
@param aProgs, array, nome da rotina dentro de um array
/*/	
Static Function fProcInUse(lMostraErro, aProgs)

	Local lRet		:= .T.
	Local lOk		:= .T.
	Local aInfo		:= {}
	Local aMonitor	:= {}
	Local cString	:= ""
	Local cLogged	:= ""
	Local nMonitor	:= 1
	Local nElem		:= 0
	Local nThreadId	:= ThreadId()
	Local nProgs 	:= 0
	Local nInfo		:= 0

	lMostraErro := If(lMostraErro == Nil, .F., lMostraErro)

	If aProgs == Nil .Or. Len(aProgs) == 0
		Return(.F.)
	EndIf

	While lOk
		aMonitor := GetUserInfo()
		aInfo    := {}
		For nMonitor := 1 To Len(aMonitor)
			cString := aMonitor[nMonitor][11]
			For nProgs := 1 To Len(aProgs)
				If aProgs[nProgs] $ cString
					If nThreadId <> aMonitor[nMonitor][3]
						nElem := AScan( aInfo ,{ |x|x[1]==cString .And. x[2]==aMonitor[nMonitor][3] } )
						If nElem == 0
							cLogged := If( AT("Logged :", cString) > 0, SubStr( cString, AT("Logged :", cString)+Len("Logged :"), 15), "" )
							aAdd( aInfo , { cString , aMonitor[nMonitor][3] , aMonitor[nMonitor][1] , aMonitor[nMonitor][2] , aProgs[nProgs] , AllTrim(cLogged) } )
						EndIf
					EndIf
				EndIf
			Next nProgs
		Next nMonitor

		lOk := (Len(aInfo) > 0)

		For nInfo := 1 To Len(aInfo)
			AutoGrLog( aInfo[nInfo][5]+" - Rotina bloqueda pelo Login de rede: " + aInfo[nInfo][3] + " na Maquina.: " + aInfo[nInfo][4] + " Usuario/Siga.: " + aInfo[nInfo][6])
		Next nInfo

		If lOk .And. lMostraErro
			MostraErro()
			lRet := ApMsgYesNo( "Deseja Continuar Tentando?")
			If !lRet
				lOk := .F.
			Else
				MsgRun("Aguarde...",,{|| Inkey(2)})
			EndIf
		EndIf
	End
Return(lRet)

///////////altamiro 17/09/2021 chamado 72399
static function fEmpPla(cTit)

	local lRet :=.F.
	local cQuery := " "

	cQuery := " Select Ba3_Codemp Clsvlr, Ba3_Codpla itConta "
	cQuery += CRLF +" From " + RetSqlName("SE1") +  " SE1 , " + RetSqlName("BA3") +  " BA3"
	cQuery += CRLF +" Where E1_Filial = '" + xFilial("SE1") +"' And Se1.D_E_L_E_T_ =' '"
	cQuery += CRLF +" And Ba3_Filial = '" + xFilial("BA3") +"' And Ba3.D_E_L_E_T_ =' '"
	cQuery += CRLF +" And E1_Prefixo || E1_Num || E1_Parcela || E1_Tipo    = '"+cTit+"'"
	cQuery += CRLF +" And Ba3_Codint = E1_Codint "
	cQuery += CRLF +" And Ba3_Codemp = E1_Codemp "
	cQuery += CRLF +" And Ba3_Matric = E1_Matric "

	If Select(("TMP")) <> 0

		("TMP")->(DbCloseArea())

	Endif

	TCQuery cQuery Alias "TMP" New

	If !EMPTY(tmp->Clsvlr)
		lRet := .T.
		If  EMPTY(tmp->itConta)

			cClaVl      := ' '
			cItCont     := ' '
			lRet := .F.

		Else

			cClaVl       := tmp->Clsvlr
			cItCont      := tmp->itConta

		EndIf

	Else

		cClaVl      := ' '
		cItCont     := ' '
		lRet := .F.

	EndIf

Return(lRet)
