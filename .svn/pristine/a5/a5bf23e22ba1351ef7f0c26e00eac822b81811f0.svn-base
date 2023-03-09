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
ฑฑบPrograma  ณCABC002   บAutor  ณAngelo Henrique     บ Data ณ  06/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Consulta Padrใo para os tipos de Bloqueios nos nํveis do   บฑฑ
ฑฑบ          ณSubContrato, familia e usuแrio.                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABC002()

	Local _aArea 		:= GetArea()
	Local lRet 			:= .T.

	Local oButton1		:= Nil
	Local oButton2		:= Nil	

	Private oOK   		:= LoadBitmap(GetResources(),"BR_VERDE"		)
	Private oNO   		:= LoadBitmap(GetResources(),"BR_VERMELHO"	)
	Private oListBox1	:= Nil
	Private aDadosBLQ 	:= {}	

	Static _oDlg2		:= Nil

	Public _cCodBlq		:= ""

	//------------------------------------------------
	//Iniciando o vetor
	//------------------------------------------------
	CABC002A(MV_PAR14)

	DEFINE MSDIALOG _oDlg2 TITLE "Pesquisa de Tipos de Bloqueio" FROM 000, 000  TO 400, 820 COLORS 0, 16777215 PIXEL		

	@ 010, 004 LISTBOX oListBox1 FIELDS HEADER " ", "Tipo de Bloqueio", "Codigo" , "Descri็ใo" SIZE 400, 170 OF _oDlg2 COLORS 0, 16777215 COLSIZES 10,50,50,100 PIXEL

	@ 185, 320 BUTTON oButton1 PROMPT "Ok" 			SIZE 037, 012 OF _oDlg2 ACTION (IIF(CABC002B(), _oDlg2:End(),.F.)	) PIXEL
	@ 185, 367 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 037, 012 OF _oDlg2 ACTION (_oDlg2:End()						) PIXEL

	//--------------------------------------------------------------------
	//Ordenando primeiro por nome, pois ้ a primeira posi็ใo do combobox
	//--------------------------------------------------------------------
	ASORT(aDadosBLQ,,, { |x, y| x[3] < y[3] } )

	oListBox1:SetArray(aDadosBLQ)

	oListBox1:bLine := {|| {IIF(aDadosBLQ[oListBox1:nAT,01],oOK,oNo),AllTrim(aDadosBLQ[oListBox1:nAT,02]),AllTrim(aDadosBLQ[oListBox1:nAT,03]),AllTrim(aDadosBLQ[oListBox1:nAT,04])}}

	oListBox1:blDblClick := {||IIF(CABC002B(), _oDlg2:End(),.F.)}

	ACTIVATE MSDIALOG _oDlg2 CENTERED	

	RestArea(_aArea)

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC002A  บAutor  ณAngelo Henrique     บ Data ณ  06/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta a query para a CABERJ e INTEGRAL                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC002A(_nParam1) 
	
	Local cAlias1 	:= GetNextAlias()	
	Local _cRet 	:= ""
	Local _cTip		:= ""

	Default _nParam1 	:= 0

	If _nParam1 <> 0		

		_cRet := " SELECT " + c_ent

		If _nParam1 = 1 //Nivel SubContrato
			
			_cTip := "Sub-Contrato"
			
			_cRet += " 	BQU_CODBLO CODIGO,	" + c_ent
			_cRet += " 	BQU_DESBLO DESCRI	" + c_ent
			_cRet += " FROM 				" + c_ent
			_cRet += " 	" + RetSqlName("BQU") + c_ent
			_cRet += " WHERE				" + c_ent
			_cRet += " 	D_E_L_E_T_ = ' '	" + c_ent
			_cRet += " 	AND BQU_TIPBLO = '0'" + c_ent //Somente tipo Bloqueio	

		ElseIf _nParam1 = 2 //Nivel Familia
			
			_cTip := "Familia"
			
			_cRet += " 	BG1_CODBLO CODIGO,	" + c_ent
			_cRet += " 	BG1_DESBLO DESCRI	" + c_ent
			_cRet += " FROM 				" + c_ent
			_cRet += " 	" + RetSqlName("BG1") + c_ent
			_cRet += " WHERE				" + c_ent
			_cRet += " 	D_E_L_E_T_ = ' '	" + c_ent
			_cRet += " 	AND BG1_TIPBLO = '0'" + c_ent //Somente tipo Bloqueio	

		ElseIf _nParam1 = 3 //Nivel Usuแrio
		
			_cTip := "Usuario"

			_cRet += " 	BG3_CODBLO CODIGO,	" + c_ent
			_cRet += " 	BG3_DESBLO DESCRI	" + c_ent
			_cRet += " FROM 				" + c_ent
			_cRet += " 	" + RetSqlName("BG3") + c_ent
			_cRet += " WHERE				" + c_ent
			_cRet += " 	D_E_L_E_T_ = ' '	" + c_ent
			_cRet += " 	AND BG3_TIPBLO = '0'" + c_ent //Somente tipo Bloqueio	

		EndIf
		//-----------------------------------------
		//Fechando a area caso esteja aberta
		//-----------------------------------------
		If Select(cAlias1) > 0		
			(cAlias1)->(DbCloseArea())		
		Endif

		DbUseArea(.T.,"TOPCONN", TCGENQRY(,,_cRet),cAlias1, .F., .T.)

		(cAlias1)->(DbGoTop())

		If !(cAlias1)->(Eof())

			aDadosBLQ 	:= {}			

			Do While (cAlias1)->(!Eof())

				aAdd( aDadosBLQ, { .T., _cTip, (cAlias1)->CODIGO, (cAlias1)->DESCRI } )

				(cAlias1)->(DbSkip())

			EndDo

		EndIf

		//-----------------------------------------
		//Fechando a area caso esteja aberta
		//-----------------------------------------
		If Select(cAlias1) > 0		
			(cAlias1)->(DbCloseArea())			
		Endif

	EndIf

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABC002B  บAutor  ณAngelo Henrique     บ Data ณ  12/07/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para pegar a linha selecionada ap๓s a     บฑฑ
ฑฑบ          ณpesquisa da consulta padrใo.                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABC002B()

	Local _lRet			:= .T.

	Public _cCodBlq		:= ""	

	_cCodBlq := aDadosBLQ[oListBox1:nAT][3]			

Return _lRet