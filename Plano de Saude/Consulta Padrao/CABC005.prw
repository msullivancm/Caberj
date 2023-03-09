#include 'protheus.ch'
#include 'parmtype.ch'

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABC005   ºAutor  ³Fabio Bianchini     º Data ³  08/07/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDESC.     ³ Consulta Padrão para a MATRIZ DE REEMBOLSO                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function CABC005()
	Local _aArea 		:= GetArea()
	Local _aArBQC		:= BQC->(GetArea())
	Local lRet 			:= .T.
	
	Local oButton1		:= Nil
	Local oButton2		:= Nil
	Local aItens		:= {"1 - Cod.Emp.", "2 - Nome Emp."}
	Local cCombo		:= aItens[1]
	Local oGet1			:= Nil
	
	Local _cAlias 		:= GetNextAlias()
	Local cQuery		:= ""
	
	Private oOK   		:= LoadBitmap(GetResources(),"BR_VERDE"		)
	Private oNO   		:= LoadBitmap(GetResources(),"BR_VERMELHO"	)
	Private oListBox1	:= Nil
	Private aDadosBQC 	:= {}
	Private cGet1		:= SPACE(200)
	
	Static _oDlg2		:= Nil
	
	Public _cCodBQC		:= ""
	
	//-----------------------------------------
	//Iniciando com a chamada para a CABERJ
	//-----------------------------------------
	cQuery := CABC005B()
	
	//-----------------------------------------
	//Fechando a area caso esteja aberta
	//-----------------------------------------
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	Endif
	
	DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),_cAlias, .F., .T.)
	
	(_cAlias)->(DbGoTop())
	
	If !(_cAlias)->(Eof())
		
		aDadosBQC 	:= {}
		
		Do While (_cAlias)->(!Eof())
			
			aAdd( aDadosBQC, { IIF(EMPTY((_cAlias)->BQC_DATBLO),.T., .F.), ALLTRIM((_cAlias)->BQC_CODEMP), ALLTRIM((_cAlias)->BQC_NUMCON), ALLTRIM((_cAlias)->BQC_VERCON), ALLTRIM((_cAlias)->BQC_SUBCON), ALLTRIM((_cAlias)->BQC_VERSUB), ALLTRIM((_cAlias)->BQC_DESCRI), ALLTRIM((_cAlias)->BT6_CODPRO), ALLTRIM((_cAlias)->BT6_VERSAO),ALLTRIM((_cAlias)->PLANO) } )
			
			(_cAlias)->(DbSkip())
			
		EndDo
		
	Else
		
		//------------------------------------------------
		//Iniciando o vetor
		//------------------------------------------------
		aAdd( aDadosBQC, { .T., "", "", "", "", "", "", "", "", "" } )
		
	EndIf
	
	//-----------------------------------------
	//Fechando a area caso esteja aberta
	//-----------------------------------------
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	Endif
	
	DEFINE MSDIALOG _oDlg2 TITLE "Empresas x Contratos x Subcontratos x Planos" FROM 000, 000  TO 400, 820 COLORS 0, 16777215 PIXEL
	
	oCombo:= tComboBox():New(010,004,{|u|if(PCount()>0,cCombo:=u,cCombo)},aItens,100,20,_oDlg2,,{||CABC005C(cCombo)},,,,.T.,,,,,,,,,'cCombo')
	
	@ 010, 120 MSGET oGet1 VAR cGet1 SIZE 200,10 Valid CABC005D(cCombo,cGet1)   OF _oDlg2 PIXEL
	
	@ 030, 004 LISTBOX oListBox1 FIELDS HEADER " ", "Emp.","Contrato","Ver.Cont.","Subc.","Ver.Subc.","Desc.Subc.","Cod.Plano","Ver.Plano","Desc.Plano"    SIZE 400, 150 OF _oDlg2 COLORS 0, 16777215 COLSIZES 10,50,170,100 PIXEL
	
	@ 185, 004 BUTTON oButton1 PROMPT "Ok" 			SIZE 037, 012 OF _oDlg2 ACTION (IIF(CABC005E(), _oDlg2:End(),.F.)	) PIXEL
	@ 185, 057 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 037, 012 OF _oDlg2 ACTION (_oDlg2:End()						) PIXEL
	
	//--------------------------------------------------------------------
	//Ordenando primeiro por nome, pois é a primeira posição do combobox
	//--------------------------------------------------------------------
	ASORT(aDadosBQC,,, { |x, y| cValToChar(x[1])+cValToChar(x[2])+cValToChar(x[3])+cValToChar(x[4])+cValToChar(x[5])+cValToChar(x[7])+cValToChar(x[8]) < cValToChar(y[1])+cValToChar(y[2])+cValToChar(y[3])+cValToChar(y[4])+cValToChar(y[5])+cValToChar(y[7])+cValToChar(y[8]) } )
	
	oListBox1:SetArray(aDadosBQC)
	oListBox1:bLine := {|| {IIF(aDadosBQC[oListBox1:nAT,01],oOK,oNo),AllTrim(aDadosBQC[oListBox1:nAT,02]),AllTrim(aDadosBQC[oListBox1:nAT,03]),AllTrim(aDadosBQC[oListBox1:nAT,04]),AllTrim(aDadosBQC[oListBox1:nAT,05]),AllTrim(aDadosBQC[oListBox1:nAT,06]),AllTrim(aDadosBQC[oListBox1:nAT,07]),AllTrim(aDadosBQC[oListBox1:nAT,08]),AllTrim(aDadosBQC[oListBox1:nAT,09]),AllTrim(aDadosBQC[oListBox1:nAT,10]) }}
	
	oListBox1:blDblClick := {||IIF(CABC005E(), _oDlg2:End(),.F.)}
	
	ACTIVATE MSDIALOG _oDlg2 CENTERED
	
	RestArea(_aArBQC)
	RestArea(_aArea)
		
return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABC005A  ºAutor  ³Fabio Bianchini     º Data ³  06/07/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDESC.     ³ Faz a busca das informações na CABERJ e na INTEGRAL.       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABC005A(_cComb, _cGet)
	
	Local cAlias1 	:= GetNextAlias()
	Local cQuery	:= ""
	
	If !(Empty(_cGet))
		
		//-----------------------------------------
		//Iniciando com a chamada para a CABERJ
		//-----------------------------------------
		cQuery := CABC005B(_cComb, _cGet)
		
		//-----------------------------------------
		//Fechando a area caso esteja aberta
		//-----------------------------------------
		If Select(cAlias1) > 0
			(cAlias1)->(DbCloseArea())
		Endif
		
		DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),cAlias1, .F., .T.)
		
		(cAlias1)->(DbGoTop())
		
		If !(cAlias1)->(Eof())
			
			aDadosBQC 	:= {}
			
			Do While (cAlias1)->(!Eof())
				
				aAdd( aDadosBQC, { IIF(EMPTY((cAlias1)->BQC_DATBLO),.T., .F.),(cAlias1)->BQC_CODEMP, (cAlias1)->BQC_NUMCON, (cAlias1)->BQC_VERCON,(cAlias1)->BQC_SUBCON,(cAlias1)->BQC_VERSUB,(cAlias1)->BQC_DESCRI,(cAlias1)->BT6_CODPRO,(cAlias1)->BT6_VERSAO,(cAlias1)->PLANO } )
				
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABC005B  ºAutor  ³Fabio Bianchini     º Data ³  06/07/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDESC.     ³ Monta a query para a CABERJ e INTEGRAL                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABC005B( _cParam1 ,_cParam2)
	
	Local _cRet 		:= ""
	
	Default _cParam1 	:= ""
	Default _cParam2 	:= ""
	
	_cParam2 := UPPER(AllTrim(_cParam2))
	
	
	_cRet := " SELECT BQC_CODEMP,											" + c_ent
	_cRet += "        BQC_NUMCON,                                           " + c_ent
	_cRet += "        BQC_VERCON, 											" + c_ent
    _cRet += "        BQC_SUBCON, 											" + c_ent
    _cRet += "        BQC_VERSUB, 											" + c_ent
    _cRet += "        BQC_DESCRI, 											" + c_ent
    _cRet += "        BT6_CODPRO, 											" + c_ent
    _cRet += "        BT6_VERSAO, 											" + c_ent
    _cRet += "        SIGA.RETORNA_DESCRI_PLANO('C',BT6_CODPRO) PLANO, 		" + c_ent
    _cRet += "        BQC_DATBLO											" + c_ent
	_cRet += " FROM                                                         " + c_ent
	_cRet += "    " + RetSqlName("BQC") + " BQC, " + RetSqlName("BT6") + " BT6 " + c_ent
	_cRet += "                                                              " + c_ent
	_cRet += " WHERE                                                        " + c_ent
	_cRet += "       BQC.BQC_FILIAL = '" + xFilial("BQC") + "'              " + c_ent
	_cRet += "   AND BT6.BT6_FILIAL = '" + xFilial("BT6") + "'   			" + c_ent
	
	_cRet += "   AND BQC.BQC_CODEMP = BT6.BT6_CODIGO 						" + c_ent
	_cRet += "   AND BQC.BQC_NUMCON = BT6.BT6_NUMCON 						" + c_ent
	_cRet += "   AND BQC.BQC_VERCON = BT6.BT6_VERCON 						" + c_ent
	_cRet += "   AND BQC.BQC_SUBCON = BT6.BT6_SUBCON 						" + c_ent
	_cRet += "   AND BQC.BQC_VERSUB = BT6.BT6_VERSUB 						" + c_ent
	_cRet += "   AND ( BQC.BQC_DATBLO = ' ' OR  							" + c_ent
	_cRet += "         BQC.BQC_DATBLO > TO_CHAR(SYSDATE,'YYYYMMDD') )       " + c_ent
	_cRet += "   AND BT6.D_E_L_E_T_ = ' '                                   " + c_ent
	_cRet += "   AND BQC.D_E_L_E_T_ = ' '                                   " + c_ent
    
	If _cParam1 == "1" .And. !Empty(AllTrim(_cParam2)) //Codigo Empresa
		
		_cRet += "   AND BQC.BQC_CODEMP LIKE '%" + AllTrim(Upper(_cParam2)) + "%'	" + c_ent
		//_cRet += " ORDER BY 2														" + c_ent
		
	ElseIf _cParam1 == "2" .And. !Empty(AllTrim(_cParam2)) //Descricao Subcontrato
		
		_cRet += "   AND BQC.BQC_DESCRI LIKE '%" + AllTrim(Upper(_cParam2)) + "%' 	" + c_ent
		//_cRet += " ORDER BY 1														" + c_ent
		
	EndIf
	
	_cRet += " ORDER BY 1,2,3,4,5,7,8											" + c_ent
	
Return _cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABC005C  ºAutor  ³Fabio Bianchini     º Data ³  12/07/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDESC.     ³ Rotina utilizada para ordenar o vetor da pesquisa.         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABC005C(_cParam)
	
	Default _cParam := ""
	
	If Len(aDadosBQC) > 1
		
		If SUBSTR(_cParam,1,1) == "1" //Código
			ASORT(aDadosBQC,,, { |x, y| cValToChar(x[1])+cValToChar(x[2])+cValToChar(x[3])+cValToChar(x[4])+cValToChar(x[5])+cValToChar(x[7])+cValToChar(x[8]) < cValToChar(y[1])+cValToChar(y[2])+cValToChar(y[3])+cValToChar(y[4])+cValToChar(y[5])+cValToChar(y[7])+cValToChar(y[8]) } )			
			
		ElseIf SUBSTR(_cParam,1,1) == "2" //Descricao
			ASORT(aDadosBQC,,, { |x, y| x[6]+cValToChar(x[1])+cValToChar(x[2])+cValToChar(x[3])+cValToChar(x[4])+cValToChar(x[5])+cValToChar(x[7])+cValToChar(x[8]) < y[6]+cValToChar(y[1])+cValToChar(y[2])+cValToChar(y[3])+cValToChar(y[4])+cValToChar(y[5])+cValToChar(y[7])+cValToChar(y[8]) } )		
			
		EndIf
		
	EndIf
	
	oListBox1:Refresh() //Reforçando a atualização da tela
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABC005D  ºAutor  ³Fabio Bianchini     º Data ³  17/01/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDESC.     ³ Rotina utilizada para ordenar o vetor da pesquisa conforme º±±
±±º          ³preenchido no GET                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABC005D(_cParam1,_cParam2)
	
	Default _cParam1 := "" //Opção selecionada no combo
	Default _cParam2 := "" //Caracteres digitados no MSGET
	
	//--------------------------------------------------------------------
	//Chamado a função da query, onde é montado as informações
	//--------------------------------------------------------------------
	CABC005A(SUBSTR(_cParam1,1,1), _cParam2)
	//--------------------------------------------------------------------
	
	If !(Len(aDadosBQC) > 0)
		
		//------------------------------------------------
		//Iniciando o vetor
		//------------------------------------------------
		aAdd( aDadosBQC, { .T., "", "", "", "", "", "", "", "", "" } )
		
	EndIf
	
	oListBox1:SetArray(aDadosBQC)
	oListBox1:bLine := {|| {IIF(aDadosBQC[oListBox1:nAT,01],oOK,oNo),AllTrim(aDadosBQC[oListBox1:nAT,02]),AllTrim(aDadosBQC[oListBox1:nAT,03]),AllTrim(aDadosBQC[oListBox1:nAT,04]),AllTrim(aDadosBQC[oListBox1:nAT,05]),AllTrim(aDadosBQC[oListBox1:nAT,06]),AllTrim(aDadosBQC[oListBox1:nAT,07]),AllTrim(aDadosBQC[oListBox1:nAT,08]),AllTrim(aDadosBQC[oListBox1:nAT,09]),AllTrim(aDadosBQC[oListBox1:nAT,10]) }}	
	
	If SUBSTR(_cParam1,1,1) == "1" //Codigo Empresa
		ASORT(aDadosBQC,,, {|x, y| cValToChar(x[1])+cValToChar(x[2])+cValToChar(x[3])+cValToChar(x[4])+cValToChar(x[5])+cValToChar(x[7])+cValToChar(x[8]) < cValToChar(y[1])+cValToChar(y[2])+cValToChar(y[3])+cValToChar(y[4])+cValToChar(y[5])+cValToChar(y[7])+cValToChar(y[8]) } )
		//ASORT(aDadosBQC,,, {|x, y| cValToChar(x[1]) = UPPER(AllTrim(_cParam2))})
		
	ElseIf SUBSTR(_cParam1,1,1) == "2" //Descrição Empresa
		ASORT(aDadosBQC,,, {|x, y| x[6]+cValToChar(x[1])+cValToChar(x[2])+cValToChar(x[3])+cValToChar(x[4])+cValToChar(x[5])+cValToChar(x[7])+cValToChar(x[8]) < y[6]+cValToChar(y[1])+cValToChar(y[2])+cValToChar(y[3])+cValToChar(y[4])+cValToChar(y[5])+cValToChar(y[7])+cValToChar(y[8]) } )
		//ASORT(aDadosBQC,,, {|x, y| x[6] = UPPER(AllTrim(_cParam2))})
		
	EndIf
	
	oListBox1:Refresh() //Reforçando a atualização da tela
	
Return aDadosBQC


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABC005E  ºAutor  ³Fabio Bianchini     º Data ³  17/01/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDESC.     ³ Rotina utilizada para pegar a linha selecionada após a     º±±
±±º          ³pesquisa da consulta padrão.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABC005E()
	
	Local _lRet	:= .T.
	Local cTab	:=  ""
	
	Public _cCodBQC	:= ""

	_cCodBQC := aDadosBQC[oListBox1:nAT][2]

	If AllTrim(FunName()) == "CABA359"
		cTab := "PDC"
	ElseIf AllTrim(FunName()) == "CABA360" 
		cTab := "PDD"
	Endif

	&("M->"+cTab+"_NUMCON") := aDadosBQC[oListBox1:nAT][3]
	&("M->"+cTab+"_VERCON") := aDadosBQC[oListBox1:nAT][4]
	&("M->"+cTab+"_SUBCON") := aDadosBQC[oListBox1:nAT][5]
	&("M->"+cTab+"_VERSUB") := aDadosBQC[oListBox1:nAT][6]
	&("M->"+cTab+"_DESSUB") := aDadosBQC[oListBox1:nAT][7]
	&("M->"+cTab+"_CODPLA") := aDadosBQC[oListBox1:nAT][8]
	&("M->"+cTab+"_VERPLA") := aDadosBQC[oListBox1:nAT][9]
	&("M->"+cTab+"_NOMPLA") := aDadosBQC[oListBox1:nAT][10]	
/*		
	M->PDC_NUMCON := aDadosBQC[oListBox1:nAT][3]
	M->PDC_VERCON := aDadosBQC[oListBox1:nAT][4]
	M->PDC_SUBCON := aDadosBQC[oListBox1:nAT][5]
	M->PDC_VERSUB := aDadosBQC[oListBox1:nAT][6]
	M->PDC_DESSUB := aDadosBQC[oListBox1:nAT][7]
	M->PDC_CODPLA := aDadosBQC[oListBox1:nAT][8]
	M->PDC_VERPLA := aDadosBQC[oListBox1:nAT][9]
	M->PDC_NOMPLA := aDadosBQC[oListBox1:nAT][10]
*/	
Return _lRet