#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE 'COLORS.CH'

#DEFINE c_ent CHR(13) + CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV027  º Autor ³ Angelo Henrique       º Data ³ 16/01/17 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Validação efetuada na tabela BB0(Profissional de Saúde)    º±±
±±º          ³ 									                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABV027(_cParam)

	Local _aArea 	:= GetArea() 	
	Local _aArBB0	:= BB0->(GetArea())	
	Local _lRet		:= .T.
	Local cAlias1 	:= GetNextAlias() 	
	Local cQuery	:= ""
	Local aList 	:= {}	
	Local aBrowse	:= {}
	Local _cNmCrm	:= "0|1|2|3|4|5|6|7|8|9"
	Local _cMvPerc	:= GetNewPar("MV_XSAUD01", "85") //Parametro utilizado para conter o número para o calulco de proximidade da query (Tipo Caracter)

	Private cGETIN 	:= SuperGetMv('MV_XGETIN') 
	Private cGERIN	:= SuperGetMv('MV_XGERIN')  

	Default _cParam	:= "0"

	//----------------------------------------------------------------------------
	//Só entra na validação caso não seja o pessoal da TI
	//conforme solicitado algumas manutenções deverá ser efetuada pela TI.
	//----------------------------------------------------------------------------
	If !( RetCodUsr() $ cGETIN ) .and. !( RetCodUsr() $ cGERIN )

		If UPPER(Alltrim(M->BB0_CODSIG)) = "CRM" 

			//---------------------------------------------------------
			//Validação para o campo de NUMERO CRM (BB0_NUMCR)
			//Para não acrescentar caracteres especiais
			//---------------------------------------------------------
			If _cParam = "1"		

				For _ni := 1 To Len(AllTrim(M->BB0_NUMCR))

					If !(SUBSTR(AllTrim(M->BB0_NUMCR), _ni, 1) $ _cNmCrm)

						Aviso("Atenção","Favor digitar somente numeros neste campo", {"OK"})
						_lRet := .F.
						Exit

					EndIf

				Next _ni 		

			EndIf

			//------------------------------------------------------------------------------
			//Validação direta para a quantidade de caracteres preenchidos no nome
			//------------------------------------------------------------------------------
			If _cParam = "2"

				//--------------------------------------------------------------------------
				//Caso não tenha espaço no nome dar mensagem, pois o usuário
				//só preencheu o primeiro nome do profissional
				//--------------------------------------------------------------------------
				If At(" ", AllTrim(M->BB0_NOME)) = 0 

					_lRet := .F.

					Aviso("Atenção","Favor preencher o nome completo do profissional!",{"OK"})				

				EndIf

			EndIf

			/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
			±± Definicao do Dialog e todos os seus componentes.                        ±±
			Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
			/*
			_oFont1    := TFont():New( "Times New Roman",0,-21,,.T.,0,,700,.F.,.F.,,,,,, )

			If !Empty(Alltrim(M->BB0_NOME)) .And. !Empty(Alltrim(M->BB0_CODSIG)) .And. !Empty(Alltrim(M->BB0_NUMCR)) .And. _lRet

				cQuery	:= " SELECT " + c_ent
				cQuery	+= "	BB0.BB0_CODIGO COD, " + c_ent
				cQuery	+= "    BB0.BB0_NOME NOME, " + c_ent
				cQuery	+= "    BB0_CGC CPF_CNPJ, " + c_ent
				cQuery	+= "    (BB0.BB0_CODSIG||CONVERTE_NUMCRM(BB0.BB0_CODSIG,TRIM(BB0.BB0_NUMCR))||BB0.BB0_ESTADO) CRM " + c_ent
				cQuery	+= "FROM " + c_ent   
				cQuery	+= "	" + RetSqlName("BB0") + " BB0 " + c_ent
				cQuery	+= "WHERE " + c_ent  
				cQuery	+= "	BB0.BB0_FILIAL = '" + xFilial("BB0") + "' " + c_ent
				cQuery	+= "	AND BB0.BB0_CODSIG = '" + M->BB0_CODSIG + "' " + c_ent 
				cQuery	+= "	AND BB0.BB0_DATBLO = ' ' " + c_ent 
				cQuery	+= "	AND (  " + c_ent
				cQuery	+= "			(((UTL_MATCH.JARO_WINKLER_SIMILARITY(TRIM('" + AllTrim(M->BB0_NOME) + "'),TRIM(BB0.BB0_NOME)) + " + c_ent
				cQuery	+= "            UTL_MATCH.EDIT_DISTANCE_SIMILARITY(TRIM('" + AllTrim(M->BB0_NOME) + "'  ),TRIM(BB0.BB0_NOME)))/2) >= " + _cMvPerc + ") " + c_ent
				cQuery	+= "			OR " + c_ent
				cQuery	+= "			('" + M->BB0_CODSIG + "'||CONVERTE_NUMCRM('" + M->BB0_CODSIG + "',TRIM('" + AllTrim(M->BB0_NUMCR) + "'))||'" + AllTrim(M->BB0_ESTADO) + "' = " + c_ent
				cQuery	+= "			BB0.BB0_CODSIG||CONVERTE_NUMCRM(BB0.BB0_CODSIG,TRIM(BB0.BB0_NUMCR))||BB0.BB0_ESTADO)  " + c_ent
				cQuery	+= "		) " + c_ent
				cQuery	+= "	AND BB0.D_E_L_E_T_ = ' ' " + c_ent

				If Select(cAlias1) > 0	
					dbSelectArea(cAlias1)
					dbCloseArea()
				EndIf

				DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),cAlias1, .F., .T.)

				While (cAlias1)->(!Eof())

					_lRet := .F.

					// Vetor com elementos do Browse
					aBrowse := { {(cAlias1)->COD,(cAlias1)->NOME,(cAlias1)->CPF_CNPJ, (cAlias1)->CRM } }	

					(cAlias1)->(DbSkip())

				EndDo

				If !(_lRet)

					_oDlg1 := MSDialog():New( 095,232,470,927,"Validação de Profissional de Saude",,,.F.,,,,,,.T.,,,.T. )

					_oSay1 := TSay():New( 012,040,{||"Já existe Profissional cadastrado com os dados inseridos"},_oDlg1,,_oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,252,016)

					oBrowse := TCBrowse():New( 30 , 05, 338, 130,, {' CODIGO  ',' NOME ',' CPF_CNPJ ',' CRM '},{30,110,40,40}, _oDlg1,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )

					// Seta vetor para a browse
					oBrowse:SetArray(aBrowse)

					// Monta a linha a ser exibina no Browse
					oBrowse:bLine := {||{ ;
					aBrowse[oBrowse:nAt,01],;
					aBrowse[oBrowse:nAt,02],;
					aBrowse[oBrowse:nAt,03],;
					aBrowse[oBrowse:nAT,04] } }

					_oBtn1 := TButton():New( 170,292,"OK",_oDlg1,{||_oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )

					_oDlg1:Activate(,,,.T.)

				EndIf

				If Select(cAlias1) > 0	
					dbSelectArea(cAlias1)
					dbCloseArea()
				EndIf

			EndIf
			*/

		EndIf

	EndIf

	RestArea(_aArBB0)
	RestArea(_aArea	)

Return _lRet
