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
ฑฑบPrograma  ณCABC003   บAutor  ณAngelo Henrique     บ Data ณ  07/08/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Consulta Padrใo para a rotina CABA069 PA.                  บฑฑ
ฑฑบ          ณNa matricula do beneficiแrio, liberando mais op็๕es de      บฑฑ
ฑฑบ          ณpesquisas na tela.                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABC003()
	
	Local _aArea 		:= GetArea()
	Local _aArBA1		:= BA1->(GetArea())
	Local lRet 			:= .T.
	
	Local oButton1		:= Nil
	Local oButton2		:= Nil
	Local aItens		:= {"1 - Nome", "2 - Matricula", "3 - CPF" }
	Local cCombo		:= aItens[1]
	Local oGet1			:= Nil
	
	Private oOK   		:= LoadBitmap(GetResources(),"BR_VERDE"		)
	Private oNO   		:= LoadBitmap(GetResources(),"BR_VERMELHO"	)
	Private oListBox1	:= Nil
	Private aDadosBA1 	:= {}
	Private cGet1		:= SPACE(200)
	
	Static _oDlg2		:= Nil
	
	Public _cCodBA1		:= ""
	
	//------------------------------------------------
	//Iniciando o vetor
	//------------------------------------------------
	aAdd( aDadosBA1, { .T., "", "", "", "" } )
	
	DEFINE MSDIALOG _oDlg2 TITLE "Pesquisa de Beneficiarios" FROM 000, 000  TO 400, 820 COLORS 0, 16777215 PIXEL
	
	oCombo:= tComboBox():New(010,004,{|u|if(PCount()>0,cCombo:=u,cCombo)},aItens,100,20,_oDlg2,,{||CABC003C(cCombo)},,,,.T.,,,,,,,,,'cCombo')
	
	@ 010, 120 MSGET oGet1 VAR cGet1 SIZE 200,10 Valid CABC003D(cCombo,cGet1)   OF _oDlg2 PIXEL
	
	@ 030, 004 LISTBOX oListBox1 FIELDS HEADER " ", "Matricula", "Nome", "Plano", "CPF " SIZE 400, 150 OF _oDlg2 COLORS 0, 16777215 COLSIZES 10,50,170,100 PIXEL
	
	@ 185, 004 BUTTON oButton1 PROMPT "Ok" 			SIZE 037, 012 OF _oDlg2 ACTION (IIF(CABC003E(), _oDlg2:End(),.F.)	) PIXEL
	@ 185, 057 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 037, 012 OF _oDlg2 ACTION (_oDlg2:End()						) PIXEL
	
	//--------------------------------------------------------------------
	//Ordenando primeiro por nome, pois ้ a primeira posi็ใo do combobox
	//--------------------------------------------------------------------
	ASORT(aDadosBA1,,, { |x, y| x[3] < y[3] } )
	
	oListBox1:SetArray(aDadosBA1)
	
	oListBox1:bLine := {|| {IIF(aDadosBA1[oListBox1:nAT,01],oOK,oNo),AllTrim(aDadosBA1[oListBox1:nAT,02]),AllTrim(aDadosBA1[oListBox1:nAT,03]),AllTrim(aDadosBA1[oListBox1:nAT,04]),AllTrim(aDadosBA1[oListBox1:nAT,05]) }}
	
	oListBox1:blDblClick := {||IIF(CABC003E(), _oDlg2:End(),.F.)}
	
	ACTIVATE MSDIALOG _oDlg2 CENTERED
	
	RestArea(_aArBA1)
	RestArea(_aArea)
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC003A  บAutor  ณAngelo Henrique     บ Data ณ  06/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Faz a busca das informa็๕es na CABERJ e na INTEGRAL.       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC003A(_cComb, _cGet)
	
	Local cAlias1 	:= GetNextAlias()
	Local cQuery	:= ""
	
	If !(Empty(_cGet))
		
		//-----------------------------------------
		//Iniciando com a chamada para a CABERJ
		//-----------------------------------------
		cQuery := CABC003B(_cComb, _cGet)
		
		//-----------------------------------------
		//Fechando a area caso esteja aberta
		//-----------------------------------------
		If Select(cAlias1) > 0
			(cAlias1)->(DbCloseArea())
		Endif
		
		DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),cAlias1, .F., .T.)
		
		(cAlias1)->(DbGoTop())
		
		If !(cAlias1)->(Eof())
			
			aDadosBA1 	:= {}
			
			Do While (cAlias1)->(!Eof())
				
				aAdd( aDadosBA1, { IIF(Empty((cAlias1)->BLOQUEIO),.T., .F.),(cAlias1)->MATRICULA, (cAlias1)->NOME, (cAlias1)->PLANO, (cAlias1)->CPF } )
				
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
ฑฑบPrograma  ณCABC003B  บAutor  ณAngelo Henrique     บ Data ณ  06/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta a query para a CABERJ e INTEGRAL                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC003B( _cParam1 ,_cParam2)
	
	Local _cRet 		:= ""
	
	Default _cParam1 	:= ""
	Default _cParam2 	:= ""
	
	_cParam2 := UPPER(AllTrim(_cParam2))
	
	
	_cRet := " SELECT 																																" + c_ent
	_cRet += "     BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA,    									" + c_ent
	_cRet += "     TRIM(BA1.BA1_NOMUSR) NOME,                                                                   									" + c_ent
	_cRet += "     TRIM(BI3.BI3_DESCRI) PLANO,                                                                  									" + c_ent
	_cRet += "     BA1.BA1_CPFUSR CPF,                                                                          									" + c_ent
	_cRet += "     BA1.BA1_DATBLO BLOQUEIO                                                                         									" + c_ent
	_cRet += " FROM                                                                                             									" + c_ent
	_cRet += "     " + RetSqlName("BA1") + " BA1                                                                									" + c_ent
	_cRet += "                                                                                                  									" + c_ent
	_cRet += "     INNER JOIN                                                                                   									" + c_ent
	_cRet += "     " + RetSqlName("BI3") + " BI3                                                                									" + c_ent
	_cRet += "     ON                                                                                           									" + c_ent
	_cRet += "         BI3.BI3_FILIAL = '" + xFilial("BI3") + "'                                                   									" + c_ent
	_cRet += "         AND BI3.BI3_CODINT = BA1.BA1_CODINT                                                      									" + c_ent
	_cRet += "         AND BI3.BI3_CODIGO = BA1.BA1_CODPLA                                                     										" + c_ent
	_cRet += "                                                                                                  									" + c_ent
	_cRet += " WHERE                                                                                            									" + c_ent
	_cRet += "     BA1.BA1_FILIAL = '" + xFilial("BA1") + "'                                                       									" + c_ent
	_cRet += "     AND BA1.D_E_L_E_T_ = ' '                                                                     									" + c_ent
	
	If _cParam1 == "1" //Nome
		
		_cRet += "	AND BA1.BA1_NOMUSR LIKE '%" + AllTrim(Upper(_cParam2)) + "%' 																	" + c_ent
		_cRet += " ORDER BY 2																														" + c_ent
		
	ElseIf _cParam1 == "2" //Matricula
		
		_cRet += "	AND BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO LIKE '%" + AllTrim(Upper(_cParam2)) + "%' 	" + c_ent
		_cRet += " ORDER BY 1																														" + c_ent
		
	ElseIf _cParam1 == "3" //CPF
		
		_cRet += "	AND BA1.BA1_CPFUSR LIKE '%" + AllTrim(Upper(_cParam2)) + "%' 																	" + c_ent
		_cRet += " ORDER BY 3																														" + c_ent
		
	EndIf
	
Return _cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC003C  บAutor  ณAngelo Henrique     บ Data ณ  12/07/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para ordenar o vetor da pesquisa.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC003C(_cParam)
	
	Default _cParam := ""
	
	If Len(aDadosBA1) > 1
		
		If SUBSTR(_cParam,1,1) == "1" //Nome
			
			ASORT(aDadosBA1,,, { |x, y| x[3] < y[3] } )
			
		ElseIf SUBSTR(_cParam,1,1) == "2" //Matricula
			
			ASORT(aDadosBA1,,, {|x, y| x[2] < y[2]})
			
		ElseIf SUBSTR(_cParam,1,1) == "3" //CPF
			
			ASORT(aDadosBA1,,, { |x,y|, x[5] < y[5] } )
			
		EndIf
		
	EndIf
	
	oListBox1:Refresh() //Refor็ando a atualiza็ใo da tela
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC003D  บAutor  ณAngelo Henrique     บ Data ณ  12/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para ordenar o vetor da pesquisa conforme บฑฑ
ฑฑบ          ณpreenchido no GET                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC003D(_cParam1,_cParam2)
	
	Default _cParam1 := "" //Op็ใo selecionada no combo
	Default _cParam2 := "" //Caracteres digitados no MSGET
	
	//--------------------------------------------------------------------
	//Chamado a fun็ใo da query, onde ้ montado as informa็๕es
	//--------------------------------------------------------------------
	CABC003A(SUBSTR(_cParam1,1,1), _cParam2)
	//--------------------------------------------------------------------
	
	If !(Len(aDadosBA1) > 0)
		
		//------------------------------------------------
		//Iniciando o vetor
		//------------------------------------------------
		aAdd( aDadosBA1, { .T., "", "", "", "", "" } )
		
	EndIf
	
	oListBox1:SetArray(aDadosBA1)
	oListBox1:bLine := {|| {IIF(aDadosBA1[oListBox1:nAT,01],oOK,oNo),AllTrim(aDadosBA1[oListBox1:nAT,02]),AllTrim(aDadosBA1[oListBox1:nAT,03]),AllTrim(aDadosBA1[oListBox1:nAT,04]),AllTrim(aDadosBA1[oListBox1:nAT,05]) }}
	
	If SUBSTR(_cParam1,1,1) == "1" //Nome
		
		ASORT(aDadosBA1,,, {|x, y| x[3] = UPPER(AllTrim(_cParam2))})
		
	ElseIf SUBSTR(_cParam1,1,1) == "2" //Matricula
		
		ASORT(aDadosBA1,,, {|x, y| x[2] = UPPER(AllTrim(_cParam2))})
		
	ElseIf SUBSTR(_cParam1,1,1) == "3" //CPF
		
		ASORT(aDadosBA1,,, { |x,y|, x[5] = UPPER(AllTrim(_cParam2))})
		
	EndIf
	
	oListBox1:Refresh() //Refor็ando a atualiza็ใo da tela
	
Return aDadosBA1


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC003E  บAutor  ณAngelo Henrique     บ Data ณ  12/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para pegar a linha selecionada ap๓s a     บฑฑ
ฑฑบ          ณpesquisa da consulta padrใo.                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC003E()
	
	Local _lRet			:= .T.
	
	Public _cCodBA1		:= ""
	
	_cCodBA1 := aDadosBA1[oListBox1:nAT][2]
	
Return _lRet