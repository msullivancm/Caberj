#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABG007   ºAutor  ³Angelo Henrique     º Data ³  21/09/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela que será chamado no gatilho do campo de matricula     º±±
±±º          ³tela de internação e liberação(PLS).                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABG007(_cParam1)
	
	Local _aArea		:= GetArea()
	Local _aArBA1		:= BA1->(GetArea())
	Local cAlias1 		:= GetNextAlias()
	Local _cRet 		:= ""
	
	Local oOK   		:= LoadBitmap(GetResources(),"BR_VERDE"		)
	Local oNO   		:= LoadBitmap(GetResources(),"BR_VERMELHO"	)
	Local oListBox1		:= Nil
	Local aDadCid		:= {}
	Local oFont1 		:= Nil
	Local oDlg1 		:= Nil
	Local oGrp1 		:= Nil
	Local oSay1 		:= Nil
	Local oSay2 		:= Nil
	Local oBtn1 		:= Nil
	
	Default _cParam1	:= "" //Matricula do beneficiário
	
	DbSelecTArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + _cParam1 )
		
		_cRet := " 	SELECT 												" + c_ent
		_cRet += " 		BF3.BF3_CODDOE CODIGO, 							" + c_ent
		_cRet += " 		TRIM(BA9.BA9_DOENCA) DESCRI						" + c_ent
		_cRet += " 	FROM 												" + c_ent
		_cRet += " 		" + RetSqlName("BF3") + " BF3 					" + c_ent
		_cRet += " 		INNER JOIN 										" + c_ent
		_cRet += " 			" + RetSqlName("BA9") + " BA9 				" + c_ent
		_cRet += " 		ON 												" + c_ent
		_cRet += " 			BA9.D_E_L_E_T_ = ' ' 						" + c_ent
		_cRet += " 			AND BA9.BA9_CODDOE = BF3.BF3_CODDOE 		" + c_ent
		_cRet += " 	WHERE 												" + c_ent
		_cRet += " 		BF3.D_E_L_E_T_ = ' ' 							" + c_ent
		_cRet += " 		AND BF3.BF3_CODDOE <> ' ' 						" + c_ent
		_cRet += " 		AND BF3.BF3_CODINT = '" + BA1->BA1_CODINT + "' 	" + c_ent
		_cRet += " 		AND BF3.BF3_CODEMP = '" + BA1->BA1_CODEMP + "' 	" + c_ent
		_cRet += " 		AND BF3.BF3_MATRIC = '" + BA1->BA1_MATRIC + "' 	" + c_ent
		_cRet += " 		AND BF3.BF3_TIPREG = '" + BA1->BA1_TIPREG + "' 	" + c_ent
		
		//-----------------------------------------
		//Fechando a area caso esteja aberta
		//-----------------------------------------
		If Select(cAlias1) > 0
			(cAlias1)->(DbCloseArea())
		Endif
		
		DbUseArea(.T.,"TOPCONN", TCGENQRY(,,_cRet),cAlias1, .F., .T.)
		
		(cAlias1)->(DbGoTop())
		
		If !(cAlias1)->(Eof())
			
			aDadCid 	:= {}
			
			Do While (cAlias1)->(!Eof())
				
				aAdd( aDadCid, { .T., (cAlias1)->CODIGO, (cAlias1)->DESCRI } )
				
				(cAlias1)->(DbSkip())
				
			EndDo						
			
			/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
			±± Definicao do Dialog e todos os seus componentes.                        ±±
			Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
			oFont1     := TFont():New( "Times New Roman",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )
			
			oDlg1      := MSDialog():New( 092,232,630,927,"Doenças Pre-Existentes",,,.F.,,,,,,.T.,,,.T. )
			
			oGrp1      := TGroup():New( 004,004,240,340,"  Doenças Pré-Existentes  ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
			
			oSay1      := TSay():New( 013,016,{||"Este beneficiário possui em seu cadastro a(s) seguinte(s) doença(s) pré-existente(s):"},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,292,012)
			oSay2      := TSay():New( 023,016,{||"Favor consultar a área técnica antes de prosseguir."},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,167,013)
			
			@ 035, 015 LISTBOX oListBox1 FIELDS HEADER " ", "CID", "Descrição" SIZE 315, 200 OF oDlg1 COLORS 0, 16777215 COLSIZES 10,50,50,100 PIXEL
			
			oListBox1:SetArray(aDadCid)
			
			oListBox1:bLine := {|| {IIF(aDadCid[oListBox1:nAT,01],oOK,oNo),AllTrim(aDadCid[oListBox1:nAT,02]),AllTrim(aDadCid[oListBox1:nAT,03])}}
			
			oBtn1      := TButton():New( 249,294,"Fechar",oGrp1,{||oDlg1:End()},037,012,,oFont1,,.T.,,"",,,,.F. )
			
			oDlg1:Activate(,,,.T.)
		
		EndIf
		
	EndIf
		
	//-----------------------------------------
	//Fechando a area caso esteja aberta
	//-----------------------------------------
	If Select(cAlias1) > 0
		(cAlias1)->(DbCloseArea())
	Endif
	
	RestArea(_aArBA1)
	RestArea(_aArea )
	
Return _cParam1