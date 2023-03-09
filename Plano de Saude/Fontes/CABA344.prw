#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA344   º Autor ³ Angelo Henrique    º Data ³  02/12/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina de liberação de beneficiários para geração de       º±±
±±º          ³carteiras                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA344()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	Local _cMvVld	:= GETMV("MV_XLIBCRT") //Parâmetro que contém os responsáveis por aprovarem a liberação de carteira
	Local _aUsu 	:= PswRet()
	Local _cUsu 	:= _aUsu[1][1] //Codigo do usuario
	
	Private _cPerg	:= "CABA344"			
	
	//------------------------------------------------------------
	//Validação para saber se o usuário possui permissão para
	//efetuar movimentações na rotina de liberação
	//------------------------------------------------------------
	If _cUsu $ _cMvVld
				
		If MSGYESNO("Deseja filtrar os beneficiários para liberação de carteira?","Rotina de liberação de beneficiários com débito")
		
			//-----------------------------
			//Cria grupo de perguntas
			//-----------------------------	
			CABA344A(_cPerg)
		
			If Pergunte(_cPerg,.T.)
							
				Processa({||CABA344B()},"Analisando Beneficiários...",,.T.)
			
			EndIf
		
		
		Else
		
			//----------------------------------------------------
			//Chama a rotina sem apresentar a opção de filtro,
			//buscando assim todos os beneficiários disponíveis
			//para liberação
			//----------------------------------------------------			
			Processa({||CABA344B()},"Analisando Beneficiários...",,.T.)
		
		EndIf
		
		
	Else
		
		Aviso("Atenção","Usuário não possui permissão para acessar esta rotina",{"OK"})
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA433A    ºAutor  ³Angelo Henrique   º Data ³  02/12/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de liberação de beneficiários para gerar carteiras   º±±
±±º          ³ -----  Perguntas da Rotina    -------------------          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABA344A(cGrpPerg)
	
	Local aHelpPor 	:= {} //help da pergunta
	Local _nMat		:= 0
	
	_nMat += TAMSX3("BA1_CODINT")[1]
	_nMat += TAMSX3("BA1_CODEMP")[1]
	_nMat += TAMSX3("BA1_MATRIC")[1]
	_nMat += TAMSX3("BA1_TIPREG")[1]
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o nome do beneficiario  	")
	AADD(aHelpPor,"De/Ate a ser utilizado.				")
	
	PutSx1(cGrpPerg,"01","Nome De ? "		,"a","a","MV_CH1"	,"C",TamSX3("BA1_NOMUSR")[1]	,0,0,"G","",""			,"","","MV_PAR01",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Nome Ate ?"		,"a","a","MV_CH2"	,"C",TamSX3("BA1_NOMUSR")[1]	,0,0,"G","",""			,"","","MV_PAR02",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o CPF do beneficiario		")
	AADD(aHelpPor,"De/Ate a ser utilizado.				")
	
	PutSx1(cGrpPerg,"03","CPF De?  "		,"a","a","MV_CH3"	,"C",TamSX3("BA1_CPFUSR")[1]	,0,0,"G","",""			,"","","MV_PAR03",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","CPF Ate ?"		,"a","a","MV_CH4"	,"C",TamSX3("BA1_CPFUSR")[1]	,0,0,"G","",""			,"","","MV_PAR04",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Matricula 				")
	AADD(aHelpPor,"De/Ate a ser utilizado.				")
	
	PutSx1(cGrpPerg,"05","Matricula De?  "	,"a","a","MV_CH5"	,"C",_nMat							,0,0,"G","","BA1JU1"		,"","","MV_PAR05",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"06","Matricula Ate ?"	,"a","a","MV_CH6"	,"C",_nMat							,0,0,"G","","BA1JU1"		,"","","MV_PAR06",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Lote      				")
	AADD(aHelpPor,"De/Ate a ser utilizado.				")
	
	PutSx1(cGrpPerg,"07","Lote De?  "		,"a","a","MV_CH7"	,"C",TamSX3("BA1_CDIDEN")[1]	,0,0,"G","",""			,"","","MV_PAR07",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"08","Lote Ate ?"		,"a","a","MV_CH8"	,"C",TamSX3("BA1_CDIDEN")[1]	,0,0,"G","",""			,"","","MV_PAR08",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA344A  º Autor ³ Angelo Henrique    º Data ³  02/12/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina que realiza o filtro e a montagem da tela.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABA344B()
	
	Local _lRetorno 	:= .F. //Validacao da dialog criada oDlg
	Local _nOpca 		:= 0 //Opcao da confirmacao
	Local bOk 			:= {|| _nOpca:=1,_lRetorno:=.T.,oDlg:End() } //botao de ok
	Local bCancel 	:= {|| _nOpca:=0,oDlg:End() } //botao de cancelamento
	Local _cArqEmp 	:= "" //Arquivo temporario com as empresas a serem escolhidas
	Local _aStruTrb 	:= {} //estrutura do temporario
	Local _aBrowse 	:= {} //array do browse para demonstracao das empresas
	Local _aEmpMigr 	:= {} //array de retorno com as empresas escolhidas
	Local _cAlias 	:= GetNextAlias()
	Local _cAliTmp	:= GetNextAlias()
	Local _nt 			:= 0	
	
	Private lInverte 	:= .F. //Variaveis para o MsSelect
	Private cMarca 	:= GetMark() //Variaveis para o MsSelect
	Private oBrwTrb 	:= Nil //objeto do msselect
	Private oDlg 		:= Nil //objeto do msselect
	
	//--------------------------------------------------------------------------
	//Caso o usuário não faça o filtro colocando as variáveis como default
	//--------------------------------------------------------------------------
	Default MV_PAR01	:= ""
	Default MV_PAR02	:= ""
	Default MV_PAR03	:= ""
	Default MV_PAR04	:= ""
	Default MV_PAR05	:= ""
	Default MV_PAR06	:= ""
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define campos do TRB ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aadd(_aStruTrb,{"MATRICULA" ,"C",20,0})
	
	aadd(_aStruTrb,{"NOME" 		,"C",TAMSX3("BA1_NOMUSR")[1],0})
	
	aadd(_aStruTrb,{"DT_NASC" 	,"D",TAMSX3("BA1_DATNAS")[1],0})
	
	aadd(_aStruTrb,{"PLANO" 		,"C",TAMSX3("BA1_CODPLA")[1],0})
	
	aadd(_aStruTrb,{"DESCRICAO" ,"C",TAMSX3("BI3_DESCRI")[1],0})
	
	aadd(_aStruTrb,{"LOTE" 		,"C",TAMSX3("BA1_CDIDEN")[1],0})
	
	aadd(_aStruTrb,{"OK" 		,"C",02,0})
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define campos do MsSelect ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aadd(_aBrowse,{"OK" 			,,"" 						})
	
	aadd(_aBrowse,{"MATRICULA"	,,"Matricula" 			})
	
	aadd(_aBrowse,{"NOME"		,,"Nome Beneficiario" 	})
	
	aadd(_aBrowse,{"DT_NASC" 	,,"Data de Nascimento" 	})
	
	aadd(_aBrowse,{"PLANO"		,,"Plano" 					})
	
	aadd(_aBrowse,{"DESCRICAO"	,,"Descricao" 			})
	
	aadd(_aBrowse,{"LOTE"		,,"Lote"		 			})
	
	If Select(_cAliTmp) > 0
		
		_cAliTmp->(DbCloseArea())
		
	Endif
	
	_cArqEmp := CriaTrab(_aStruTrb)
	
	dbUseArea(.T.,__LocalDriver,_cArqEmp,_cAliTmp)
	
	//Aqui você monta sua query que serve para gravar os dados no arquivo temporario...
	
	cQuery := " SELECT BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA, "
	cQuery += " BA1.BA1_NOMUSR NOME, BA1.BA1_DATNAS DT_NASC, BA1.BA1_XLTORI LOTE, BA1.BA1_CODPLA PLANO, BI3.BI3_DESCRI DESCRICAO"
	cQuery += " FROM " + RetSQLName("BA1") + " BA1, " + RetSQLName("BI3") + " BI3 "
	cQuery += " WHERE BA1.D_E_L_E_T_ = ' ' "
	cQuery += " AND BI3.D_E_L_E_T_ = ' ' "
	cQuery += " AND BA1.BA1_FILIAL = '" + xFilial("BA1") + "' "
	cQuery += " AND BI3.BI3_FILIAL = '" + xFilial("BI3") + "' "
	cQuery += " AND BA1.BA1_DATBLO = ' ' "
	cQuery += " AND BA1.BA1_CODPLA = BI3.BI3_CODIGO "
	cQuery += " AND BA1.BA1_XLIBCA = 'B' "
	
	//---------------------------------------
	//Parametro de pesquisa por nome
	//---------------------------------------
	If !Empty(AllTrim(MV_PAR01)) .Or. !Empty(AllTrim(MV_PAR02))
		
		cQuery += " AND BA1.BA1_NOMUSR BETWEEN '" + UPPER(AllTrim(MV_PAR01)) + "' AND '" + UPPER(AllTrim(MV_PAR02)) + "'"
		
	EndIf
		
	//---------------------------------------
	//Parametro de pesquisa por CPF
	//---------------------------------------
	If !Empty(AllTrim(MV_PAR03)) .Or. !Empty(AllTrim(MV_PAR04))
		
		cQuery += " AND BA1.BA1_CPFUSR BETWEEN '" + AllTrim(MV_PAR03) + "' AND '" + AllTrim(MV_PAR04) + "'"
		
	EndIf
	
	//---------------------------------------
	//Parametro de pesquisa por Matricula
	//---------------------------------------
	If !Empty(AllTrim(MV_PAR05)) .Or. !Empty(AllTrim(MV_PAR06))
		
		cQuery += " AND BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG BETWEEN '" + AllTrim(MV_PAR05) + "' AND '" + AllTrim(MV_PAR06) + "'"
		
	EndIf
	
	//---------------------------------------
	//Parametro de pesquisa por Lote
	//---------------------------------------
	If !Empty(AllTrim(MV_PAR07)) .Or. !Empty(AllTrim(MV_PAR08))
		
		cQuery += " AND BA1_XLTORI BETWEEN '" + AllTrim(MV_PAR07) + "' AND '" + AllTrim(MV_PAR08) + "'"
		
	EndIf
	
	TCQuery cQuery new Alias (_cAlias)
	
	While (_cAlias)->(!Eof())
		
		_nt ++
		
		IncProc("Analisando Beneficiário: " + AllTrim(Transform(_nt,"@E 9999999")))
		
		RecLock(_cAliTmp,.T.)
		
		(_cAliTmp)->OK 			:= space(2)
		
		(_cAliTmp)->MATRICULA 	:= (_cAlias)->MATRICULA
		
		(_cAliTmp)->NOME 			:= (_cAlias)->NOME
		
		(_cAliTmp)->DT_NASC 		:= STOD((_cAlias)->DT_NASC)
		
		(_cAliTmp)->PLANO 		:= (_cAlias)->PLANO
		
		(_cAliTmp)->DESCRICAO 	:= (_cAlias)->DESCRICAO
		
		(_cAliTmp)->LOTE			:= (_cAlias)->LOTE
		
		MsUnlock()
		
		(_cAlias)->(DbSkip())
		
	Enddo
	
	(_cAlias)->(DbCloseArea())
	
	@ 001,001 TO 400,700 DIALOG oDlg TITLE OemToAnsi("Liberação de Beneficiarios para Carteira")
	
	@ 015,005 SAY OemToAnsi("Selecione os usuário que serão liberados: ")
	
	oBrwTrb := MsSelect():New(_cAliTmp,"OK","",_aBrowse,@lInverte,@cMarca,{025,001,170,350})
	
	oBrwTrb:oBrowse:lCanAllmark := .T.
	
	Eval(oBrwTrb:oBrowse:bGoTop)
	
	oBrwTrb:oBrowse:Refresh()
	
	Activate MsDialog oDlg On Init (EnchoiceBar(oDlg,bOk,bCancel,,)) Centered VALID _lRetorno
	
	(_cAliTmp)->(DbGotop())
	
	If _nOpca == 1
		
		Do While (_cAliTmp)->(!Eof())
			
			If !Empty((_cAliTmp)->OK)//se usuario marcou o registro
				
				aAdd(_aEmpMigr,(_cAliTmp)->MATRICULA)
				
			EndIf
			
			(_cAliTmp)->(DbSkip())
			
		EndDo
		
		If Len(_aEmpMigr) > 0
			
			//--------------------------------------------------
			//Rotina para desbloquear os beneficiários
			//--------------------------------------------------
			Processa({||CABA344C(_aEmpMigr)},"Desbloqueando Beneficiários...",,.T.)
		
		EndIf
		
	Endif
	
	//-------------------------------------------------------
	//fecha area de trabalho e arquivo temporário criados
	//-------------------------------------------------------
	
	If Select(_cAliTmp) > 0
		
		DbSelectArea(_cAliTmp)
		
		DbCloseArea()
		
		Ferase(_cArqEmp+OrdBagExt())
		
	Endif
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA344C  º Autor ³ Angelo Henrique    º Data ³  22/12/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina que realiza o desbloqueio dos beneficiários         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CABA344C(_aEmpMigr)
	
	Local _aArea 	:= GetArea()
	Local _aArBA1 := BA1->(GetArea())
	Local _nz		:= 0
	Local _aUsu	:= PswRet()
	Local _cUsu	:= _aUsu[1][4] //Nome do usuario
	Local _lAtu := .F.
	
	ProcRegua(Len(_aEmpMigr))
	
	For _nz := 1 to Len(_aEmpMigr)
		
		IncProc("Desbloqueando Beneficiário: " + AllTrim(Transform(_nz,"@E 9999999")) + " de: " + AllTrim(Transform(Len(_aEmpMigr),"@E 9999999")))
		
		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + _aEmpMigr[_nz])
			
			RecLock("BA1",.F.)
			
			BA1->BA1_XLIBCA := "L"
			BA1->BA1_XUSRLB := _cUsu
			BA1->BA1_XDTLIB := dDatabase
			
			BA1->(MsUnLock())
			
			_lAtu := .T.
			
		EndIf
		
	Next _nz
	
	If _lAtu
	
		Aviso("Atenção","Beneficiário(s) desbloqueado(s) para geração de carteira(s).",{"OK"})
	
	EndIf
	
	
	RestArea(_aArBA1)
	RestArea(_aArea)
	
Return
