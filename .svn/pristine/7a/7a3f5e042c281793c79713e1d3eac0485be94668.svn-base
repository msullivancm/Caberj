#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "protheus.ch"
#include "fileio.ch"

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CABA320     ³ Autor ³ Ana Claudia         ³ Data ³ 20.08.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta a tela para mostrar os dados                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINANCEIRO - CABERG                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Caba320()
Local cUso :=""
Local aSize    	:= {}
Local aObjects 	:= {}
Local aInfo   	:= {}
Local aPosObj 	:= {}
Local lInverte	:= .f.
Local oValor	:= 0
Local oQtdTit 	:= 0
Local nValor 	:= 0
Local nQtdTit  	:= 0
Local cPerg := "CAs320"   

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

private  cTipoSql := " "
private  cParcSql := " " 
private  cflag    := " " 

Private cMarca		:= GetMark()
Private cCadastro := "Retorno de títulos transferidos"

If cFilAnt != GETMV("MV_XFILGER")
	MsgStop("A Rotina de Retorno só pode ser executada na filial que recebe a transferência dos títulos.","ATENÇÃO")
	Return
EndIf	

ParSX1(cPerg)
IF !Pergunte(cPerg,.T.)
	Return
EndIF

#IFNDEF TOP
	Local cIndex		:= ""           
	Local nIndex
#ENDIF

SE2->(DbSetOrder(1))
cChave := SE2->(IndexKey())

dbSelectArea( "SE2" )
#IFDEF TOP
	cAliasSE2 := "QRYSE2"
	cQuery	 := ""
	aStru		 := SE2->(DbStruct())
	aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
	cQuery := "SELECT SE2.R_E_C_N_O_ RECNO, BAU.BAU_NOME E2_TITADT "+cQuery
	cQuery += " FROM "+RetSqlName("SE2")+ " SE2, "+RetSqlName("BAU")+ " BAU "
	cQuery += " WHERE " + FA580ChecF()
	cQuery += "   And se2.D_E_L_E_T_ = ' '"
	cQuery += " ORDER BY " + SqlOrder(cChave)
	Aadd(aStru, {"RECNO","N",10,0})
	cArqTrab := CriaTrab(aStru,.T.) // Nome do arquivo temporario
	dbUseArea(.T.,__LocalDriver,cArqTrab,cAliasSe2,.F.)
	Processa({||SqlToTrb(cQuery, aStru, cAliasSe2)}) // Cria arquivo temporario
#ELSE
	cAliasSe2 := "SE2"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta express„o do Filtro para sele‡„o                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cIndex		:= CriaTrab(nil,.f.)
	nOldIndex	:= IndexOrd()
	IndRegua("SE2",cIndex,cChave,,FA580ChecF(),OemToAnsi( "Selecionando Registros..." ) ) // "Selecionando Registros..."
	nIndex := RetIndex("SE2")
	dbSelectArea("SE2")
	#IFNDEF TOP
		dbSetIndex(cIndex+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndex+1)	
#ENDIF	
dbGoTop()
If !Eof()
	nOpcA	:= 0
	aCampos := {}

	AADD(aCampos,{"E2_OK","","  ",""})
	AADD(aCampos,{"E2_NUM"		,	,"Número"   		,"@!"				})
	AADD(aCampos,{"E2_PREFIXO"	,	,"Prefixo"			,"@!"				})
	AADD(aCampos,{"E2_TIPO"		,	,"Tipo"				,"@!"				})
	AADD(aCampos,{"E2_VALOR"	,	,"Valor"			,"@E 99,999,999.99"	})
	AADD(aCampos,{"E2_VENCTO"	,	,"Vencimento"    	,"@!"				})
	AAdd(aCampos,{"E2_CODRDA"   ,   ,"",""})
	AAdd(aCampos,{"E2_TITADT"   ,   ,"Nome RDA"         ,"@!S20"               })
	AADD(aCampos,{"E2_ISS"		,	,"Valor ISS"     	,"@E 99,999,999.99"	})
	AADD(aCampos,{"E2_IRRF"		,	,"Valor IRRF"    	,"@E 99,999,999.99"	})
	AADD(aCampos,{"E2_COFINS"	,	,"Valor COFINS"  	,"@E 99,999,999.99"	})
	AADD(aCampos,{"E2_PIS"		,	,"Valor PIS"     	,"@E 99,999,999.99"	})
	AADD(aCampos,{"E2_CSLL"		,	,"Valor CSLL"    	,"@E 99,999,999.99"	})
	AADD(aCampos,{"E2_INSS"		,	,"Valor INSS"    	,"@E 99,999,999.99"	})
	AADD(aCampos,{"E2_FORNECE"	,	,"Fornecedor"		,"@!"				})
	AADD(aCampos,{"E2_LOJA"		,	,"Loja"  			,"@!"				})
	AADD(aCampos,{"E2_NOMFOR"	,	,"Nome Forn."		,"@!S40"			})
	AADD(aCampos,{"E2_VENCREA"	,	,"Venc. Real"    	,"@!"				})
	AADD(aCampos,{"E2_ORIGEM"	,	,"Origem"         	,"@!"				})
	AADD(aCampos,{"E2_FILORIG"	,	,"Filial Origem" 	,"@!"				})
	AADD(aCampos,{"RECNO"		,	,"No.Registro" 		,"@E 99999999"	})
	
	dbSelectArea("SX3") 
	dbSetOrder(2)
	For nI := 1 to Len(aCampos)
		If "E2_TITADT" $ aCampos[nI][1]
			Loop
		EndIf	
		If SX3->(dbSeek(aCampos[nI][1]))
			aCampos[nI][3] := X3Titulo()
			aCampos[nI][4] := SX3->X3_PICTURE
		Endif
	Next nI
 	
	dbSelectArea(cAliasSe2)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Calculo das dimensoes da Janela                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSize    := MsAdvSize()
	aObjects := {}
	AAdd( aObjects, { 015, 015, .T., .F. } )
	AAdd( aObjects, { 120, 100, .T., .T. } )

	aInfo   := { aSize[ 1 ],aSize[ 2 ],aSize[ 3 ],aSize[ 4 ],02,02 }
	aPosObj := MsObjSize( aInfo, aObjects, .F. )

	DEFINE MSDIALOG oDlg1 TITLE OemToAnsi(cCadastro) From aSize[7],0 to aSize[6],aSize[5] of oMainWnd PIXEL
	@ 1.6 , 01	Say "Valor Selecionado " SIZE 50,12 //"Valor Selecionado "
	@ 1.6 , 24	Say "Títulos Selecionados " SIZE 50,12 //"Títulos Selecionados "
	@ 1.6 , 10	Say oValor		VAR nValor		Picture "@E 999,999,999.99" 
	@ 1.6 , 34	Say oQtdTit 	VAR nQtdTit 	Picture "9999"  

	oMark:= MsSelect():New(cAliasSe2,"E2_OK",,aCampos,@lInverte,@cMarca	,{aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4]})
	oMark:bMark := {||Fa580Exibe(cAliasSE2,cMarca,oValor,oQtdTit,@nValor,@nQtdTit)}
	oMark:oBrowse:lhasMark		:= .t.
	oMark:oBrowse:lCanAllmark	:= .t.
	oMark:oBrowse:bAllMark		:= { || FA580Inverte(cMarca,cAliasSe2,oValor,oQtdTit,@nValor,@nQtdTit)}
	
	ACTIVATE MSDIALOG oDlg1 ON INIT EnchoiceBar(	oDlg1,{|| nOpca := 1,oDlg1:End()},;
									 		  {|| nOpca := 0,ODlg1:End()} ) CENTER
	
	dbSelectArea(cAliasSe2)
	
	If nOpca == 1
		lLibera := .F.
/*		If MsgYesNo("Deseja efetuar liberação de registros retornados?")
			_cUser := RetCodUsr()

			SZA->(DbSetOrder(1))
			If SZA->(dbseek(xFilial("SZA")+_cUser))
				If SZA->ZA_LIBPLS == "N" //.Or. SZA->ZA_DIAS < (dDatabase - (cAliasTmp)->E2_VENCREA)
					MsgALERT("Usuário sem permissão para liberar títulos do PLS.","Atenção")
				Else
					lLibera := .T.	
				Endif
			Else
				MsgAlert("Usuário não está cadastrado nas permissões. Favor verificar com o administrador do sistema","Atenção")
			EndIf	
		EndIf	*/
		dbSelectArea(cAliasSe2)
		MsUnlockall()
		dbgotop()
		nSucesso := 0
		Processa({||RetornaDados(lLibera,@nSucesso,cMarca)},"Processando Registros")

		If nSucesso == 0
			MsgAlert("Registros retornados "+IIf(lLibera,"e liberados ","")+"com sucesso","Atenção")
		Else
			MsgAlert("Alguns títulos falharam no retorno. Favor verificar.","Atenção")
		EndIf		
	End
Else
	Help(" ",1,"RECNO")
Endif	
#IFDEF TOP
	DbSelectArea(cAliasSe2)
	DbCloseArea()
#ELSE
	RetIndex("SE2")
	If !Empty(cIndex)
		fErase(cIndex+OrdBagExt())
	Endif
	Set Filter to
#ENDIF

Return (.T.)

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³fa580blank³ Autor ³ Fernando Dourado 		  ³ Data ³ 21/03/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Limpa o campo E2_OK para efetuar marca‡„o. 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³fa580blank() 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³FINA580																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fa580Blank()

Reclock("SE2")
Replace E2_OK with "  "
MsUnlock()

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³fa580ChecF³ Autor ³ Fernando Dourado 	  ³ Data ³ 21/03/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Retorna Condi‡„o para Indice Condicional						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³fa580ChecF() 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fa580ChecF()

Local cFiltro := ""

#IFDEF TOP    
	cFiltro += " E2_FILIAL = '"+GETMV("MV_XFILGER")+"'"
	cFiltro += "   And E2_ORIGEM = 'PLSMPAG' "
	cFiltro += "   AND E2_FORNECE >= '"+MV_PAR09+"' AND E2_LOJA >= '"+MV_PAR10+"' "
	cFiltro += "   AND E2_FORNECE <= '"+MV_PAR11+"' AND E2_LOJA <= '"+MV_PAR12+"'"
	cFiltro += "   AND E2_NUM >= '"+MV_PAR01+"' AND E2_NUM <= '"+MV_PAR02+"'"
	cFiltro += "   AND E2_PREFIXO >= '"+MV_PAR03+"' AND E2_PREFIXO <= '"+MV_PAR04+"'"
	cFiltro += "   AND E2_EMISSAO >= '"+DTOS(MV_PAR05)+"' AND E2_EMISSAO <= '"+DTOS(MV_PAR06)+"'"
	cFiltro += "   AND E2_VENCTO >= '"+DTOS(MV_PAR07)+"' AND E2_VENCTO <= '"+DTOS(MV_PAR08)+"'"
	cFiltro += "   AND E2_CODRDA >= '"+MV_PAR13+"' AND E2_CODRDA <= '"+MV_PAR14+"'"
	cFiltro += "   And E2_FILORIG = '"+StrZero(Val(MV_PAR15),2)+"'"
	cFiltro += "   And BAU.BAU_FILIAL = '"+XFILIAL("BAU")+"'"
	cFiltro += "   AND SE2.E2_CODRDA = BAU.BAU_CODIGO"      
	cFiltro += "   AND SE2.E2_saldo > 0 "
	cFiltro += "   AND BAU.D_E_L_E_T_ = ' '"     
	cFiltro += "   AND BAU.BAU_TIPPE = 'J'"
	cFiltro += "   AND E2_TIPO NOT IN ('"+MVTAXA+"','"+MVISS+"','"+MVINSS+"') "
#ELSE	
	cFiltro  := "E2_FILIAL = '"+xFilial("SE2")+"'"
	cFiltro  += ".AND.(E2_FORNECE+E2_LOJA>='"+mv_par09+mv_par10+"'.AND.E2_FORNECE+E2_LOJA<='"+mv_par11+mv_par12+"'"
	cFiltro  += ".AND.E2_CODRDA>='"+mv_par13+"'.AND.E2_CODRDA<='"+mv_par14+"'"
	cFiltro  += ".AND.DTOS(E2_VENCTO)>='"+DTOS(mv_par07)+"'"
	cFiltro	+= ".AND.dtos(E2_VENCTO)<='"+Dtos(mv_par08)+"'"
	cFiltro  += ".AND.dtos(E2_EMISSAO)>='"+dTOS(mv_par09)+"'"
	cFiltro	+= ".AND.dtos(E2_EMISSAO<='"+DTOS(mv_par10)+"'"
	cFIltro	+= ".AND.E2_PREFIXO>='"+mv_par03+"'.AND.E2_PREFIXO<='"+mv_par04+"'"
	cFiltro	+= ".AND.!(E2_TIPO$'"+MVABATIM+"/"+MVISS+"/"+MVINSS+"')"
	cFiltro  += ".AND.E2_NUM>='"+MV_PAR01+"' .AND. E2_NUM<='"+MV_PAR02+"'"
#ENDIF

Return cFiltro

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³FA580Inver³ Autor ³ Fernando Dourado		  ³ Data ³ 19/03/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Marca / Desmarca todos os titulos								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINA580																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fa580Inverte(cMarca,cAlias,oValor,oQtdTit,nValor,nQtdTit)

Local aArea		:= GetArea()

dbSelectArea(cAlias)
DbGoTop()

While !Eof() .and. xFilial("SE2") == (cAlias)->E2_FILIAL
	RecLock(cAlias)
	IF (cAlias)->E2_OK == cMarca
		(cAlias)->E2_OK	:= "  "
		nValor -= Round(NoRound(xMoeda((cAlias)->(E2_SALDO+E2_SDACRES-E2_SDDECRE),(cAlias)->E2_MOEDA,1,,3),3),2)
		nQtdTit--
	Else
		(cAlias)->E2_OK	:= cMarca
		nValor += Round(NoRound(xMoeda((cAlias)->(E2_SALDO+E2_SDACRES-E2_SDDECRE),(cAlias)->E2_MOEDA,1,,3),3),2)
		nQtdTit++
	Endif
	MsUnlock()
	dbSkip()
Enddo
RestArea(aArea)
oValor:Refresh()
oQtdTit:Refresh()
oMark:oBrowse:Refresh(.t.)
Return Nil

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³FA580Exibe³ Autor ³ Mauricio Pequim Jr.   ³ Data ³ 19/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Exibe Totais de titulos selecionados							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ FA580Exibe()															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ FINA580																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fa580Exibe(cAlias,cMarca,oValor,oQtdTit,nValor,nQtdTit)
If (cAlias)->E2_OK == cMarca
	nValor += Round(NoRound(xMoeda((cAlias)->(E2_SALDO+E2_SDACRES-E2_SDDECRE),(cAlias)->E2_MOEDA,1,,3),3),2)
	nQtdTit++
Else
	nValor -= Round(NoRound(xMoeda((cAlias)->(E2_SALDO+E2_SDACRES-E2_SDDECRE),(cAlias)->E2_MOEDA,1,,3),3),2)
	nQtdTit--
Endif
nQtdTit:= Iif(nQtdTit<0,0,nQtdTit)
oValor:Refresh()
oQtdTit:Refresh()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ParSX1       ºAutor  ³Jean Schulz     º Data ³  18/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria parametros para rotina.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ParSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Titulo de") 			,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{"Título inicial para filtragem"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Titulo até")			,"","","mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{"Título final para filtragem"},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("Prefixo de")			,"","","mv_ch3","C",03,0,1,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{"Prefixo inicial para filtragem"},{""},{""})
PutSx1(cPerg,"04",OemToAnsi("Prefixo até")			,"","","mv_ch4","C",03,0,1,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{"Prefixo final para filtragem"},{""},{""})
PutSx1(cPerg,"05",OemToAnsi("Data Emissão de")		,"","","mv_ch5","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{"Data inicial da emissão dos títulos para filtro dos dados apresentados"},{""},{""})
PutSx1(cPerg,"06",OemToAnsi("Data Emissão até")		,"","","mv_ch6","D",08,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{"Data final da emissão dos títulos para filtro dos dados apresentados"},{""},{""})
PutSx1(cPerg,"07",OemToAnsi("Data Vencimento de")	,"","","mv_ch7","D",08,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{"Data inicial de vencimento dos títulos para filtro dos dados apresentados"},{""},{""})
PutSx1(cPerg,"08",OemToAnsi("Data Vencimento até")	,"","","mv_ch8","D",08,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",{"Data final de vencimento dos títulos para filtro dos dados apresentados"},{""},{""})
PutSx1(cPerg,"09",OemToAnsi("Fornecedor de")		,"","","mv_ch9","C",06,0,1,"G","","SA2","","","mv_par09","","","","","","","","","","","","","","","","",{"Determina o início do filtro por fornecedores"},{""},{""})
PutSx1(cPerg,"10",OemToAnsi("Loja de")				,"","","mv_cha","C",02,0,1,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",{"Filtra a/as lojas do fornecedor inicial escolhido"},{""},{""})
PutSx1(cPerg,"11",OemToAnsi("Fornecedor até")		,"","","mv_chb","C",06,0,1,"G","","SA2","","","mv_par11","","","","","","","","","","","","","","","","",{"Determina até que código de fornecedor será feito o filtro"},{""},{""})
PutSx1(cPerg,"12",OemToAnsi("Loja até")				,"","","mv_chc","C",02,0,1,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",{"Filtra a/as lojas do fornecedor final escolhido"},{},{})
PutSx1(cPerg,"13",OemToAnsi("RDA de")				,"","","mv_chd","C",06,0,1,"G","","BAUPLS","","","mv_par13","","","","","","","","","","","","","","","","",{"Código inicial do Médico/Clínica/Hospital e demais"},{""},{""})
PutSx1(cPerg,"14",OemToAnsi("RDA até")				,"","","mv_che","C",06,0,1,"G","","BAUPLS","","","mv_par14","","","","","","","","","","","","","","","","",{"Código final do Médico/Clínica/Hospital e demais"},{""},{""})
PutSx1(cPerg,"15",OemToAnsi("Filial Retorno")		,"","","mv_chf","C",02,0,1,"G","","","","","mv_par15","","","","","","","","","","","","","","","","",{"Filial para onde o título será retornado"},{""},{""})

Return

Static Function RetornaDados(lLibera,nSucesso,cMarca)

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

ProcRegua((cAliasSE2)->(RecCount()))
While !Eof()
	IncProc()
	If (cAliasSe2)->E2_OK == cMarca
		BEGIN TRANSACTION
	
		dbSelectArea(cAliasSe2)
		#IFDEF TOP
			If (cAliasSe2)->(FieldPos("RECNO")) > 0
				DbSelectArea("SE2")
				MsGoto((cAliasSe2)->RECNO)
				DbSelectArea(cAliasSe2)
			Endif	
		#ENDIF  
		
		cQuery := " UPDATE "+RetSqlName("SE2")
		cQuery += " SET E2_FILORIG = '  ' , E2_FILIAL = '"+QRYSE2->E2_FILORIG+"'"
		If lLibera                    
			cQuery += "	, E2_USUALIB = '"+Substr(SZA->ZA_NOME,1,15)+"', E2_YDTLBPG = '"+Dtos(dDatabase)+"', E2_YLIBPLS = 'M'"
		EndIf	
		cQuery += " WHERE E2_FILIAL = '"+QRYSE2->E2_FILIAL+"' "
		cQuery += "   AND R_E_C_N_O_ = "+Trim(Str(QRYSE2->RECNO))
   	    cQuery += "   AND E2_ORIGEM = 'PLSMPAG' "
		cQuery += "   AND D_E_L_E_T_ = ' ' "
	
		nSucesso += TcSqlExec(cQuery)
        
	     For x:=1 To 6 Step 1                       
         cflag := " "                      
            if x == 1
               if QRYSE2->e2_PARCISS <> " "  .OR. QRYSE2->e2_ISS > 0
                  cTipoSql := "ISS"
                  cParcSql := QRYSE2->e2_parciss    
                  cflag := "X"                     
               endIf   
            elseif x == 2
               if QRYSE2->e2_PARCIR <> " "  .OR. QRYSE2->e2_IRRF > 0
                  cTipoSql := "TX "
                  cParcSql := QRYSE2->e2_parcir
                  cflag := "X"                     
               endIf   
            elseif x == 3
               if QRYSE2->e2_PARCSLL <> " " .OR. QRYSE2->e2_VRETCSL > 0
                  cTipoSql := "TX "
                  cParcSql := QRYSE2->e2_parcsll                           
                  cflag := "X"                     
               endIf   
            elseif x == 4
               if QRYSE2->e2_PARCCOF <> " " .OR. QRYSE2->e2_VRETCOF > 0
                  cTipoSql := "TX "
                  cParcSql := QRYSE2->e2_parccof                         
                  cflag := "X"                     
               endIf   
            elseif x == 5
               if QRYSE2->e2_PARCPIS <> " " .OR. QRYSE2->e2_VRETPIS > 0
                  cTipoSql := "TX "
                  cParcSql := QRYSE2->e2_parcpis    
                  cflag := "X"       
               endIf   
            elseif x == 6
               if QRYSE2->e2_PARCINS <> " " .OR. QRYSE2->e2_INSS > 0
                  cTipoSql := "INS "
                  cParcSql := QRYSE2->e2_parcinss    
                  cflag := "X"                                      
               EndIf                           
            EndIf   
            If cflag = "X"  
 		       cQuery := " UPDATE "+RetSqlName("SE2")
		       cQuery += " SET E2_FILIAL = '"+QRYSE2->E2_FILORIG+"' , E2_FILORIG = '  ' "
		       If lLibera
			      cQuery += ", E2_USUALIB = '"+Substr(SZA->ZA_NOME,1,15)+"', E2_YDTLBPG = '"+Dtos(dDatabase)+"', E2_YLIBPLS = 'M'"
		       EndIf	
		       cQuery += " WHERE E2_FILIAL = '"+QRYSE2->E2_FILIAL+"' "
		       cQuery += "   AND E2_NUM = '"+QRYSE2->E2_NUM +"' "
		       cQuery += "   AND E2_PREFIXO = '"+QRYSE2->E2_PREFIXO + "' "
		       cQuery += "   AND E2_TIPO = '"+cTipoSql+"' "          
		       cQuery += "   AND E2_PARCELA = '"+cParcSql+"' "
//		       cQuery += "   AND E2_TIPO IN ('"+MVTAXA+"','"+MVISS+"','"+MVINSS+"') "
		       cQuery += "   AND E2_VALOR IN ("+Trim(Str(QRYSE2->E2_ISS))+","+Trim(Str(QRYSE2->E2_IRRF))+","
		       cQuery += Trim(Str(QRYSE2->E2_COFINS))+","+Trim(Str(QRYSE2->E2_PIS))+","+Trim(Str(QRYSE2->E2_CSLL))+","+Trim(Str(QRYSE2->E2_INSS))+")"
		       cQuery += "   AND E2_ORIGEM = 'PLSMPAG' "
		       cQuery += "   AND D_E_L_E_T_ = ' ' "
		
		nSucesso := TcSqlExec(cQuery)
		EndIf
      Next x
		END TRANSACTION
	EndIf
	dbSelectArea(cAliasSe2)
	DbSkip()
Enddo

Return(nSucesso)                           
  