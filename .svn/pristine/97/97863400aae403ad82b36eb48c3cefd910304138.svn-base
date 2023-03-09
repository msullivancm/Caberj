#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC004   บAutor  ณAngelo Henrique     บ Data ณ  17/01/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDESC.     ณ Consulta Padrใo para a rotina CBOS.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABC004()
	
	Local _aArea 		:= GetArea()
	Local _aArB0X		:= B0X->(GetArea())
	Local lRet 			:= .T.
	
	Local oButton1		:= Nil
	Local oButton2		:= Nil
	Local aItens		:= {"1 - Codigo", "2 - Descricao"}
	Local cCombo		:= aItens[1]
	Local oGet1			:= Nil
	
	Local _cAlias 		:= GetNextAlias()
	Local cQuery		:= ""
	
	Private oOK   		:= LoadBitmap(GetResources(),"BR_VERDE"		)
	Private oNO   		:= LoadBitmap(GetResources(),"BR_VERMELHO"	)
	Private oListBox1	:= Nil
	Private aDadosB0X 	:= {}
	Private cGet1		:= SPACE(200)
	
	Static _oDlg2		:= Nil
	
	Public _cCodB0X		:= ""
	
	//-----------------------------------------
	//Iniciando com a chamada para a CABERJ
	//-----------------------------------------
	cQuery := CABC004B()
	
	//-----------------------------------------
	//Fechando a area caso esteja aberta
	//-----------------------------------------
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	Endif
	
	DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),_cAlias, .F., .T.)
	
	(_cAlias)->(DbGoTop())
	
	If !(_cAlias)->(Eof())
		
		aDadosB0X 	:= {}
		
		Do While (_cAlias)->(!Eof())
			
			aAdd( aDadosB0X, { IIF((_cAlias)->ATIVO =="1",.T., .F.),(_cAlias)->COD, (_cAlias)->DESCRI } )
			
			(_cAlias)->(DbSkip())
			
		EndDo
		
	Else
		
		//------------------------------------------------
		//Iniciando o vetor
		//------------------------------------------------
		aAdd( aDadosB0X, { .T., "", "" } )
		
	EndIf
	
	//-----------------------------------------
	//Fechando a area caso esteja aberta
	//-----------------------------------------
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	Endif
	
	DEFINE MSDIALOG _oDlg2 TITLE "Pesquisa de CBOS" FROM 000, 000  TO 400, 820 COLORS 0, 16777215 PIXEL
	
	oCombo:= tComboBox():New(010,004,{|u|if(PCount()>0,cCombo:=u,cCombo)},aItens,100,20,_oDlg2,,{||CABC004C(cCombo)},,,,.T.,,,,,,,,,'cCombo')
	
	@ 010, 120 MSGET oGet1 VAR cGet1 SIZE 200,10 Valid CABC004D(cCombo,cGet1)   OF _oDlg2 PIXEL
	
	@ 030, 004 LISTBOX oListBox1 FIELDS HEADER " ", "Codigo", "Descricao" SIZE 400, 150 OF _oDlg2 COLORS 0, 16777215 COLSIZES 10,50,170,100 PIXEL
	
	@ 185, 004 BUTTON oButton1 PROMPT "Ok" 			SIZE 037, 012 OF _oDlg2 ACTION (IIF(CABC004E(), _oDlg2:End(),.F.)	) PIXEL
	@ 185, 057 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 037, 012 OF _oDlg2 ACTION (_oDlg2:End()						) PIXEL
	
	//--------------------------------------------------------------------
	//Ordenando primeiro por nome, pois ้ a primeira posi็ใo do combobox
	//--------------------------------------------------------------------
	ASORT(aDadosB0X,,, { |x, y| x[3] < y[3] } )
	
	oListBox1:SetArray(aDadosB0X)
	
	oListBox1:bLine := {|| {IIF(aDadosB0X[oListBox1:nAT,01],oOK,oNo),AllTrim(aDadosB0X[oListBox1:nAT,02]),AllTrim(aDadosB0X[oListBox1:nAT,03]) }}
	
	oListBox1:blDblClick := {||IIF(CABC004E(), _oDlg2:End(),.F.)}
	
	ACTIVATE MSDIALOG _oDlg2 CENTERED
	
	RestArea(_aArB0X)
	RestArea(_aArea)
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC004A  บAutor  ณAngelo Henrique     บ Data ณ  06/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDESC.     ณ Faz a busca das informa็๕es na CABERJ e na INTEGRAL.       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC004A(_cComb, _cGet)
	
	Local cAlias1 	:= GetNextAlias()
	Local cQuery	:= ""
	
	If !(Empty(_cGet))
		
		//-----------------------------------------
		//Iniciando com a chamada para a CABERJ
		//-----------------------------------------
		cQuery := CABC004B(_cComb, _cGet)
		
		//-----------------------------------------
		//Fechando a area caso esteja aberta
		//-----------------------------------------
		If Select(cAlias1) > 0
			(cAlias1)->(DbCloseArea())
		Endif
		
		DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),cAlias1, .F., .T.)
		
		(cAlias1)->(DbGoTop())
		
		If !(cAlias1)->(Eof())
			
			aDadosB0X 	:= {}
			
			Do While (cAlias1)->(!Eof())
				
				aAdd( aDadosB0X, { IIF((cAlias1)->ATIVO =="1",.T., .F.),(cAlias1)->COD, (cAlias1)->DESCRI } )
				
				(cAlias1)->(DbSkip())
				
			EndDo
			
		EndIf
		
	EndIf
	
	//-----------------------------------------
	//Fechando a area caso esteja aberta
	//-----------------------------------------
	If Select(cAlias1) > 0
		(cAlias1)->(DbCloseArea())
	Endif
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC004B  บAutor  ณAngelo Henrique     บ Data ณ  06/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDESC.     ณ Monta a query para a CABERJ e INTEGRAL                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC004B( _cParam1 ,_cParam2)
	
	Local _cRet 		:= ""
	
	Default _cParam1 	:= ""
	Default _cParam2 	:= ""
	
	_cParam2 := UPPER(AllTrim(_cParam2))
	
	
	_cRet := " SELECT 																" + c_ent
	_cRet += "     B0X.B0X_XATIVO ATIVO, 											" + c_ent
	_cRet += "     B0X.B0X_CODCBO COD,                                              " + c_ent
	_cRet += "     TRIM(B0X.B0X_DESCBO) DESCRI  	                                " + c_ent
	_cRet += " FROM                                                                 " + c_ent
	_cRet += "     " + RetSqlName("B0X") + " B0X                                    " + c_ent
	_cRet += "                                                                      " + c_ent
	_cRet += " WHERE                                                                " + c_ent
	_cRet += "     B0X.B0X_FILIAL = '" + xFilial("B0X") + "'                        " + c_ent
	_cRet += "     AND B0X.D_E_L_E_T_ = ' '                                         " + c_ent
	
	If _cParam1 == "1" .And. !Empty(AllTrim(_cParam2)) //Codigo
		
		_cRet += "	AND B0X.B0X_CODCBO LIKE '%" + AllTrim(Upper(_cParam2)) + "%'	" + c_ent
		_cRet += " ORDER BY 2														" + c_ent
		
	ElseIf _cParam1 == "2" .And. !Empty(AllTrim(_cParam2)) //Descricao
		
		_cRet += "	AND B0X.B0X_DESCBO LIKE '%" + AllTrim(Upper(_cParam2)) + "%' 	" + c_ent
		_cRet += " ORDER BY 1														" + c_ent
		
	EndIf
	
Return _cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC004C  บAutor  ณAngelo Henrique     บ Data ณ  12/07/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDESC.     ณ Rotina utilizada para ordenar o vetor da pesquisa.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC004C(_cParam)
	
	Default _cParam := ""
	
	If Len(aDadosB0X) > 1
		
		If SUBSTR(_cParam,1,1) == "1" //C๓digo
			
			ASORT(aDadosB0X,,, { |x, y| x[2] < y[2] } )
			
		ElseIf SUBSTR(_cParam,1,1) == "2" //Descricao
			
			ASORT(aDadosB0X,,, {|x, y| x[3] < y[3]})
			
		EndIf
		
	EndIf
	
	oListBox1:Refresh() //Refor็ando a atualiza็ใo da tela
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC004D  บAutor  ณAngelo Henrique     บ Data ณ  17/01/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDESC.     ณ Rotina utilizada para ordenar o vetor da pesquisa conforme บฑฑ
ฑฑบ          ณpreenchido no GET                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC004D(_cParam1,_cParam2)
	
	Default _cParam1 := "" //Op็ใo selecionada no combo
	Default _cParam2 := "" //Caracteres digitados no MSGET
	
	//--------------------------------------------------------------------
	//Chamado a fun็ใo da query, onde ้ montado as informa็๕es
	//--------------------------------------------------------------------
	CABC004A(SUBSTR(_cParam1,1,1), _cParam2)
	//--------------------------------------------------------------------
	
	If !(Len(aDadosB0X) > 0)
		
		//------------------------------------------------
		//Iniciando o vetor
		//------------------------------------------------
		aAdd( aDadosB0X, { .T., "", "" } )
		
	EndIf
	
	oListBox1:SetArray(aDadosB0X)
	oListBox1:bLine := {|| {IIF(aDadosB0X[oListBox1:nAT,01],oOK,oNo),AllTrim(aDadosB0X[oListBox1:nAT,02]),AllTrim(aDadosB0X[oListBox1:nAT,03]) }}
	
	If SUBSTR(_cParam1,1,1) == "1" //Codigo
		
		ASORT(aDadosB0X,,, {|x, y| x[2] = UPPER(AllTrim(_cParam2))})
		
	ElseIf SUBSTR(_cParam1,1,1) == "2" //Descri็ใo
		
		ASORT(aDadosB0X,,, {|x, y| x[3] = UPPER(AllTrim(_cParam2))})
		
	EndIf
	
	oListBox1:Refresh() //Refor็ando a atualiza็ใo da tela
	
Return aDadosB0X


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC004E  บAutor  ณAngelo Henrique     บ Data ณ  17/01/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDESC.     ณ Rotina utilizada para pegar a linha selecionada ap๓s a     บฑฑ
ฑฑบ          ณpesquisa da consulta padrใo.                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC004E()
	
	Local _lRet			:= .T.
	
	Public _cCodB0X		:= ""
	
	_cCodB0X := aDadosB0X[oListBox1:nAT][2]
	
Return _lRet