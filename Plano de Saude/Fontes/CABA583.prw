#INCLUDE 'PROTHEUS.CH'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"
#Include "HBUTTON.CH"


#DEFINE c_ent CHR(13) + CHR(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583   �Autor  �Angelo Henrique     � Data �  11/03/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina de atualiza��o da tabela SLA                        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583()

	//���������������������������������������������������������������������Ŀ
	//� Declaracao de Variaveis                                             �
	//�����������������������������������������������������������������������
	Local aRotAdic	:= {}
	Local cVldAlt	:= "U_CABA583O()"     // Validacao para permitir a inclus�o/alteracao.
	Local cVldExc	:= ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
	aadd(aRotAdic, { "SLA entre Areas","U_SLAARE()", 0 , 6 })
	Private cString	:= "PCG"

	dbSelectArea("PCG")
	dbSetOrder(1)

	AxCadastro(cString,"Cadasto SLA (Protocolo de Atendimento)",cVldExc,cVldAlt,aRotAdic)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583A  �Autor  �Angelo Henrique     � Data �  11/03/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para preencher o campo SLA na tela de     ���
���          �protocolo de atendimento, preenchendo automaticamente  o    ���
���          �campo.                                                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583A

	Local _aArea  	:= GetArea()
	Local _aArPCG	:= PCG->(GetArea())
	Local _nPosTip	:=  Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" })
	Local _cTpDem	:= ""
	Local _cCanal	:= ""
	Local _cPtEnt	:= ""
	Local _cTpSv	:= ""
	Local _nRet		:= 0
	Local _cMsg		:= ""
	Local _nData 	:= 0
	Local _dData 	:= CTOD(" / / ")
	Local _nCont	:= 0

	If !Empty(AllTrim(M->ZX_TPDEM)) .And. !Empty(AllTrim(M->ZX_CANAL)) .And. !Empty(AllTrim(M->ZX_PTENT)) .And. !Empty(AllTrim(aCols[Len(Acols)][_nPosTip]))

		_cTpDem	:= PADR(AllTrim(M->ZX_TPDEM)		,TAMSX3("PCG_CDDEMA")[1])
		_cCanal	:= PADR(AllTrim(M->ZX_CANAL)		,TAMSX3("PCG_CDPORT")[1])
		_cPtEnt	:= PADR(AllTrim(M->ZX_PTENT)		,TAMSX3("PCG_CDDEMA")[1])
		_cTpSv	:= PADR(AllTrim(aCols[Len(Acols)][_nPosTip]) ,TAMSX3("PCG_CDSERV")[1])

		//-----------------------------------
		//Ponterar na Tabela de SLA
		//-----------------------------------
		DbSelectArea("PCG")
		DbSetOrder(1)
		If DbSeek(xFilial("PCG") + _cTpDem + _cPtEnt + _cCanal + _cTpSv)

			M->ZX_SLA := PCG->PCG_QTDSLA
			_nRet := PCG->PCG_QTDSLA

			//----------------------------------
			//Validando dias uteis para SLA
			//----------------------------------
			_nData := 0
			_dData := CTOD(" / / ")

			For _nCont := 1 to PCG->PCG_QTDSLA

				_nData += 1
				_dData := DaySum(dDataBase,_nData)

				If dow(_dData)== 1 //domingo

					_nData += 1
					_dData := DATAVALIDA(DaySum(dDataBase,_nData))

				ElseIf dow(_dData)== 7 //sabado

					_nData += 2
					_dData := DATAVALIDA(DaySum(dDataBase,_nData))

				EndIf

				//Validando se caso n�o � sabado e nem domingo
				//por�m � feriado
				If _dData != DATAVALIDA(DaySum(dDataBase,_nData))

					_dData := DATAVALIDA(DaySum(dDataBase,_nData))

				EndIf

			Next

			_cMsg := "Quantidade de SLA: " + cValToChar(PCG->PCG_QTDSLA) + "." + c_ent
			_cMsg += "Data limite (prevista) para atendimento: " + cValToChar(_dData) + "." + c_ent
			_cMsg += "Favor informar o numero do protocolo: " + M->ZX_SEQ + "."

			Aviso("Aten��o", _cMsg ,{"OK"})

		EndIf

	EndIf

	RestArea(_aArPCG)
	RestArea(_aArea)

Return _nRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583B  �Autor  �Angelo Henrique     � Data �  02/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para preencher o campo area e descri��o no���
���          �protocolo de atendimento, preenchendo automaticamente  o    ���
���          �campo.                                                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583B

	Local _aArea  	:= GetArea()
	Local _aArPBL	:= PBL->(GetArea())
	Local _nPosTip	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" })
	Local _cRet		:= ""
	Local _cTpSv	:= ""

	If !Empty(AllTrim(aCols[Len(Acols)][_nPosTip]))

		_cTpSv := PADR(AllTrim(aCols[Len(Acols)][_nPosTip]),TAMSX3("ZY_TIPOSV")[1])

		//----------------------------------------------
		//Ponterar na Tabela de PBL (Tipo de Servi�o)
		//----------------------------------------------
		DbSelectArea("PBL")
		DbSetOrder(1)
		If DbSeek(xFilial("PBL") + _cTpSv)

			M->ZX_CODAREA := PBL->PBL_AREA
			_cRet := PBL->PBL_AREA


		EndIf

	EndIf

	RestArea(_aArPBL)
	RestArea(_aArea)

Return _cRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583C  �Autor  �Angelo Henrique     � Data �  02/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para preencher o campo area e descri��o no���
���          �protocolo de atendimento, preenchendo automaticamente  o    ���
���          �campo.                                                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583C

	Local _aArea  	:= GetArea()
	Local _aArPBL	:= PBL->(GetArea())
	Local _aArPCF	:= PCF->(GetArea())
	Local _nPosTip	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" })
	Local _cRet		:= ""
	Local _cTpSv	:= ""

	If !Empty(AllTrim(aCols[Len(Acols)][_nPosTip]))

		_cTpSv := PADR(AllTrim(aCols[Len(Acols)][_nPosTip]),TAMSX3("ZY_TIPOSV")[1])

		//----------------------------------------------
		//Ponterar na Tabela de PBL (Tipo de Servi�o)
		//----------------------------------------------
		DbSelectArea("PBL")
		DbSetOrder(1)
		If DbSeek(xFilial("PBL") + _cTpSv)

			DbSelectArea("PCF")
			DbSetOrder(1)
			If DbSeek(xFilial("PCF") + PADR(AllTrim(PBL->PBL_AREA),TAMSX3("PCF_COD")[1]))

				M->ZX_YAGENC := PCF->PCF_DESCRI
				_cRet := PCF->PCF_DESCRI

			EndIf

		EndIf

	EndIf

	RestArea(_aArPCF)
	RestArea(_aArPBL)
	RestArea(_aArea)

Return _cRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583D  �Autor  �Angelo Henrique     � Data �  02/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar o tipo de servi�o inserido.  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583D

	Local _aArea  	:= GetArea()
	Local _aArPBL	:= PBL->(GetArea())
	Local _aArPCF	:= PCF->(GetArea())
	Local _nPosTip	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" })
	Local _lRet		:= .T.
	Local _ni 		:= 0

	If Len(aCols) > 1

		For _ni := 1 To Len(aCols)

			If _ni = 1

				_cTipoSv := AllTrim(aCols[_ni][_nPosTip])

			EndIf

			If _cTipoSv != M->ZY_TIPOSV

				_lRet := .F.

				Aviso("Aten��o","Tipo de servi�o selecionado � diferente do mencionado na linha de cima.", {"OK"})

				Exit

			EndIf

		Next _ni

	EndIf

	RestArea(_aArPCF)
	RestArea(_aArPBL)
	RestArea(_aArea)

Return _lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583E  �Autor  �Angelo Henrique     � Data �  02/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para trazer a informa��o correta do campo ���
���          �de area responsavel.                                        ���
���          � Nesta rotina � mantido o hist�rico das PA's antigas, onde  ���
���          � o usu�rio continuar� olhando a �rea respons�vel como       ���
���          � Centro de Custo, para as novas inclus�es a informa��o que  ���
���          � ser� exibida � referente as novas inclus�es, tabela (PCF). ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583E

	Local _aArea  	:= GetArea()
	Local _aArCTT		:= CTT->(GetArea())
	Local _aArPCF		:= PCF->(GetArea())
	Local _cRet		:= ""

	//----------------------------------------------------
	//Olhando o centro de custo para as PA's antigas
	//Caso o campo n�o esteja preenchido ser� visualizado
	//o campo criado para tratar o Protocolo de Atendimento
	//vers�o 2.0
	//----------------------------------------------------
	If !EMPTY(SZX->ZX_YCUSTO)

		DbSelectArea("CTT")
		DBSetOrder(1)
		If DbSeek(xFilial("CTT") + SZX->ZX_YCUSTO)

			_cRet := CTT->CTT_DESC01

		EndIf

	Else

		DbSelectArea("PCF")
		DbSetOrder(1)
		If DbSeek(xFilial("PCF") + SZX->ZX_CODAREA)

			_cRet := PCF->PCF_DESCRI

		EndIf

	EndIf

	RestArea(_aArCTT)
	RestArea(_aArPCF)
	RestArea(_aArea)

Return _cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583F  �Autor  �Angelo Henrique     � Data �  02/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para trazer os historicos padr�es que     ���
���          �foram vinculados na tabela Tipo Servico x Historico         ���
���          �Rotina � chamada no filtro da consulta padr�o do campo de   ���
���          �hist�rico padr�o na tela do protocolo de atendimento.       ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583F

	Local _aArea 	:= GetArea()
	Local _aArPCE	:= PCE->(GetArea())
	Local _aArPCD	:= PCD->(GetArea())
	Local _cRet		:= ""

	DbSelectArea("PCE")
	DbSetOrder(1)
	If DbSeek(xFilial("PCE") + M->ZY_TIPOSV)

		While !EOF() .And. M->ZY_TIPOSV == PCE->PCE_TIPOSV

			_cRet += PCE->PCE_CDHIST + ","

			PCE->(DBSKIP())

		EndDo

		_cRet := SUBSTR(_cRet,1,Len(_cRet)-1)

	EndIf

	RestArea(_aArPCD)
	RestArea(_aArPCE)
	RestArea(_aArea)

Return _cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583G  �Autor  �Angelo Henrique     � Data �  02/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar se o PA pode ou n�o ser      ���
���          �encerrado, pois deve haver pelo menos uma resposta para     ���
���          �aquele PA.                                                  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
���Programa  �CABA583G  �Autor  �Angelo Henrique     � Data �  15/08/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Acrescentado valida��o para o setor da ouvidoria, onde     ���
���          �os chamados aberto para a Ouvidoria s� poder�o ser fechados ���
���          �por eles, trazendo assim maior controle para as PA's com    ���
���          �maior prioridade.                                           ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583G

	Local _aArea 	:= GetArea()
	Local _aArSZX	:= SZX->(GetArea())
	Local _aArSZY	:= SZY->(GetArea())
	Local _ni		:= 0
	Local _nPosRp	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_RESPOST" }) //Resposta
	Local _nPosHs	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_HISTPAD" }) //Hist�rico Padr�o
	Local _lRet		:= .F.
	Local _cMsg		:= ""
	Local _cUsu		:= PSWRet()[1][1]
	Local _cOuvd	:= GetNewPar("MV_XOVDPA","000923,000876,001023") //Usu�rios com acesso a encerrar quado � ouvidoria
	Local _cRegu	:= GetNewPar("MV_XREGPA","001761,001626,000790,001453") //Usu�rios com acesso a encerrar quado � ouvidoria

	// FRED: na chamada da valida��o no SX3 somente chamava a valida��o se M->ZX_TPINTEL $ '2|4'
	// Como preciso validar os preenchimentos 1 e 3, vou encapsular no IF abaixo toda a valida��o atual
	// e incluir ao final do fonte a valida��o que necessito
	// Chamada no X3_VLDUSER antiga: Pertence("1234").AND.IIF(M->ZX_TPINTEL $ "2|4", U_CABA583G(), .T.)
	// Chamada no X3_VLDUSER nova:   Pertence("1234").AND. U_CABA583G()
	If M->ZX_TPINTEL $ '2|4'

		For _ni := 1 To Len(aCols)

			If !Empty(AllTrim(aCols[_ni][_nPosRp]))

				_lRet := .T.

				Exit

			EndIf

		Next _ni

		If !_lRet

			_cMsg := " Protocolo n�o pode ser encerrado, pois "
			_cMsg += " n�o existe resposta preenchida. Protocolo s� poder� ser encerrado"
			_cMsg += " quando for inclu�da a resposta."

			Aviso("Aten��o", _cMsg, {"OK"})

		EndIf


		//------------------------------------------------------
		//Inicio - Angelo Henrique - Data: 15/08/2016
		//Valida��o para saber se o PA � da ouvidoria
		//------------------------------------------------------
		If _lRet

			If AllTrim(M->ZX_CANAL ) == "000002" //Canal Ouvidoria

				If !(_cUsu $ _cOuvd)

					_lRet := .F.

					_cMsg := " Protocolo n�o pode ser encerrado, pois "
					_cMsg += " usu�rio n�o possui permiss�o para encerrar "
					_cMsg += " protocolos da OUVIDORIA."

					Aviso("Aten��o", _cMsg, {"OK"})

				EndIf

			EndIf

		EndIf
		//------------------------------------------------------
		//Fim    - Angelo Henrique - Data: 15/08/2016
		//------------------------------------------------------

		//------------------------------------------------------
		//Inicio - Angelo Henrique - Data: 30/03/2022
		//Valida��o para saber se o PA � do Regulat�rio
		//------------------------------------------------------
		If _lRet

			If AllTrim(M->ZX_CANAL ) == "000033" //Canal Regulat�rio

				If !(_cUsu $ _cRegu)

					_lRet := .F.

					_cMsg := " Protocolo n�o pode ser encerrado, pois "
					_cMsg += " usu�rio n�o possui permiss�o para encerrar "
					_cMsg += " protocolos do REGULATORIO."

					Aviso("Aten��o", _cMsg, {"OK"})

				EndIf

			EndIf

		EndIf

		//------------------------------------------------------
		//Inicio - Angelo Henrique - Data:19/10/2016
		//------------------------------------------------------
		//Valida��o do STATUS: Em Andamento, pois ele ir�
		//trocar automaticamente
		//------------------------------------------------------
		If _lRet

			If M->ZX_TPINTEL == '3' //Andamento

				For _ni := 1 To Len(aCols)

					If !Empty(AllTrim(aCols[_ni][_nPosHs]))

						If _ni == 1

							_cHistPd := AllTrim(aCols[_ni][_nPosHs])

						Else

							If _cHistPd != AllTrim(aCols[_ni][_nPosHs])

								_lRet := .T.
								Exit

							EndIf

						EndIf

					EndIf

				Next _ni


				If !_lRet

					_cMsg := " Protocolo n�o pode ser alterado para  "
					_cMsg += " EM ANDAMENTO, pois n�o houve mudan�a  "
					_cMsg += " de seu Hist�rico."

					Aviso("Aten��o", _cMsg, {"OK"})

				EndIf

			EndIf

		EndIf
		//------------------------------------------------------
		//Fim    - Angelo Henrique - Data: 15/08/2016
		//------------------------------------------------------

		// FRED: finaliza��o de ajuste detalhado no IF deste ELSE
	else
		_lRet	:= .T.
	EndIf


	// FRED: n�o deixar regredir status de encerrado para acompanhamento para 'pendente' ou 'em andamento'
	if SZX->ZX_SEQ == M->ZX_SEQ		// garantir que estejamos na altera��o (quando for inclus�o - codigos distintos, logo regra n�o se aplica)

		if SZX->ZX_TPINTEL == '4' .and. M->ZX_TPINTEL $ '1|3'

			alert("N�o � permitido retornar um atendimento 'encerrado sob acompanhamento' para 'pendente' ou 'em andamento'.")
			_lRet	:= .F.

		endif

	endif
	// FRED: fim do ajuste

	RestArea(_aArSZY)
	RestArea(_aArSZX)
	RestArea(_aArea)

Return _lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583H  �Autor  �Angelo Henrique     � Data �  06/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar se o tipo de servi�o pode ser���
���          �utilizado para o benefici�rio selecionado, pois conforme    ���
���          �solicitado,um benefici�rio n�o pode repetir tipo de servi�o ���
���          �em outra PA caso a PA esteja aberta.                        ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583H

	Local _aArea 	:= GetArea()
	Local _aArSZX	:= SZX->(GetArea())
	Local _aArSZY	:= SZY->(GetArea())
	Local _lRet		:= .T.
	Local _cQuery	:= ""
	Local cAliQry 	:= GetNextAlias()
	Local _cMsg 	:= ""
	Local _cUsu		:= PSWRet()[1][1]
	Local _cOuvd	:= GetNewPar("MV_XOVDPA","000923,000876,001023") //Usu�rios com acesso a encerrar quado � ouvidoria
	Local l			:= 0


	cAssist := GetAdvFVal("PBL", "PBL_ASSIST" , xFilial("PBL")+M->ZY_TIPOSV , 1, "" )

	cGrau := GetAdvFVal("PBL", "PBL_XGRAUR" , xFilial("PBL")+M->ZY_TIPOSV , 1, "" )

	M->ZX_ASSIST := cAssist

	M->ZX_GRAUR := cGrau

	For l := 1 to Len(_oDlg:ACONTROLS)

		IF Type('_oDlg:ACONTROLS['+cVALTOCHAR(l)+']') != 'U'
			_oDlg:ACONTROLS[l]:REFRESH()
		EndIf

	Next l
	//--------------------------------------------------------------------
	//Quando o usu�rio � do setor da ouvidoria poder� ser aberto
	//um novo protocolo com o mesmo tipo de servi�o
	//--------------------------------------------------------------------
	If !(_cUsu $ _cOuvd)

		//------------------------------------------------------------------
		//Campo ZX_USUARIO � virtual
		//quando � incluido este campo � quebrado nos seguintes campos:
		// - ZX_CODEMP, ZX_MATRIC, ZX_TIPREG, ZX_DIGITO
		//------------------------------------------------------------------
		If !Empty(M->ZX_USUARIO) .AND. INCLUI

			//--------------------------------
			//Estrutura do campo ZX_USUARIO
			//--------------------------------
			//1234 5678 912345 67 8 - CONTADOR
			//0001 0004 054788 01 0 - CAMPO
			//--------------------------------

			_cQuery := " SELECT " + c_ent
			_cQuery += " 	SZX.ZX_SEQ, SZX.ZX_CODEMP, SZX.ZX_MATRIC, SZX.ZX_TIPREG, SZX.ZX_DIGITO, " 			+ c_ent
			_cQuery += " 	SZY.ZY_SEQBA, SZY.ZY_SEQSERV, SZY.ZY_TIPOSV " 										+ c_ent
			_cQuery += " FROM " 																				+ c_ent
			_cQuery += " 	" + RETSQLNAME("SZX") + " SZX, " + RETSQLNAME("SZY") + " SZY " 						+ c_ent
			_cQuery += " WHERE " 								+ c_ent
			_cQuery += " 	SZX.D_E_L_E_T_ = ' ' " 				+ c_ent
			_cQuery += " 	AND SZX.ZX_TPINTEL NOT IN ('2','4') " 		+ c_ent
			_cQuery += " 	AND SZX.ZX_CODINT = '" + SUBSTR(M->ZX_USUARIO,01,TAMSX3("ZX_CODINT")[1]) + "' " 	+ c_ent
			_cQuery += " 	AND SZX.ZX_CODEMP = '" + SUBSTR(M->ZX_USUARIO,05,TAMSX3("ZX_CODEMP")[1]) + "' " 	+ c_ent
			_cQuery += " 	AND SZX.ZX_MATRIC = '" + SUBSTR(M->ZX_USUARIO,09,TAMSX3("ZX_MATRIC")[1]) + "' " 	+ c_ent
			_cQuery += " 	AND SZX.ZX_TIPREG = '" + SUBSTR(M->ZX_USUARIO,16,TAMSX3("ZX_TIPREG")[1]) + "' " 	+ c_ent
			_cQuery += " 	AND SZX.ZX_DIGITO = '" + SUBSTR(M->ZX_USUARIO,17,TAMSX3("ZX_DIGITO")[1]) + "' " 	+ c_ent
			_cQuery += " 	AND SZX.ZX_SEQ 	  = SZY.ZY_SEQBA " 													+ c_ent
			_cQuery += " 	AND SZX.ZX_SEQ = '" + M->ZX_SEQ + "' "												+ c_ent
			_cQuery += " 	AND SZY.ZY_TIPOSV = '" + M->ZY_TIPOSV + "' " 										+ c_ent
			_cQuery += " 	AND SZX.ZX_DATDE = '" + SUBSTR(DTOS(DATE()),1,6) + "' " 						    + c_ent

			If Select(cAliQry)>0
				(cAliQry)->(DbCloseArea())
			EndIf

			DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),cAliQry,.T.,.T.)

			DbSelectArea(cAliQry)

			If !((cAliQry)->(Eof()))

				_lRet := .F.

				_cMsg := "N�o � possivel incluir este tipo de servi�o. " + c_ent
				_cMsg += "Existe um protocolo em aberto para este benefici�rio "
				_cMsg += "com o tipo de servi�o selecionado. " + c_ent
				_cMsg += "Protocolo: " + (cAliQry)->ZX_SEQ + "."

				Aviso("Aten��o",_cMsg,{"OK"})

			EndIf

		EndIf

	EndIf

	If Select(cAliQry)>0
		(cAliQry)->(DbCloseArea())
	EndIf

	RestArea(_aArSZY)
	RestArea(_aArSZX)
	RestArea(_aArea)

Return _lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583I  �Autor  �Angelo Henrique     � Data �  06/06/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para preencher corretamente a descri��o do���
���          �tipo de servi�o na tela de PA, pois para as PA's antigas    ���
���          �estava trazendo a descri��o incorreta, uma vez que o c�digo ���
���          �podia ser cadastrado em duplicidade, mudando a area respons.���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
���Parametros� Recebe o tipo de servi�o                                   ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583I(_cParam)

	Local _aArea 	:= GetArea()
	Local _aArSZX	:= SZX->(GetArea())
	Local _aArSZY	:= SZY->(GetArea())
	Local _aArPBL	:= PBL->(GetArea())
	Local _cRet		:= ""

	Default _cParam 	:= "" //Tipo de Servi�o

	If Val(_cParam) < 1000

		//-------------------------------------------------------------------------------------------------
		//Se for menor que 1000, s�o os c�digos antigos, logo dever� pegar tamb�m o centro de custo
		//pois no protocolo antigo os c�digos poderiam ser criado em duplicidade, mas mudando o
		//c�digo da �rea respons�vel(Antes era utilizsado o centro de custo)
		//-------------------------------------------------------------------------------------------------
		DbSelectArea("PBL")
		DbSetOrder(1)
		If DbSeek(xFilial("PBL") + _cParam + M->ZX_YAGENC)

			_cRet := PBL->PBL_YDSSRV

		EndIf

	Else

		//-------------------------------------------------------------------------------------------------
		//Se for maior ou igual a 1000, s�o os novos c�digos, n�o necessitando do centro de custo
		//-------------------------------------------------------------------------------------------------
		DbSelectArea("PBL")
		DbSetOrder(1)
		If DbSeek(xFilial("PBL") + _cParam)

			_cRet := PBL->PBL_YDSSRV

		EndIf

	EndIf

	RestArea(_aArPBL)
	RestArea(_aArSZY)
	RestArea(_aArSZX)
	RestArea(_aArea)

Return _cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583J  �Autor  �Angelo Henrique     � Data �  06/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada como consulta padr�o para o campo de      ���
���          � Hist�rico Padr�o visualizando a tabela de vinculos.        ���
���          � Tipo de Servi�o x Historico Padr�o PCE.                    ���
�������������������������������������������������������������������������͹��
���          � Altera��o para o projeto de PA x Indica��o de rede         ���
���          � Quando o tipo de servi�o for do GERED no hist�rico padr�o  ���
���          � ser� apresentado a tabela de especialidades				  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583J

	Local _aArea 		:= GetArea()
	Local _aArPCE		:= PCE->(GetArea())
	Local _aArPBL		:= PBL->(GetArea())
	Local lRet 			:= .T.
	Local _nPosTp			:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" })

	Local oButton1		:= Nil
	Local oButton2		:= Nil
	Local cAlias1 		:= GetNextAlias()
	Local aItens		:= {"1 - Codigo","2 - Descricao"}
	Local cCombo		:= aItens[1]
	Local oGet1			:= Nil

	Private oListBox1	:= Nil
	Private aDadosPCE 	:= {}
	Private cGet1		:= SPACE(20)

	Static _oDlg2		:= Nil

	Public _CodPCE		:= ""
	Public _cDsPCE		:= ""

	DbSelectArea("PBL")
	DbSetOrder(1)
	If DbSeek(xFilial("PBL")+aCols[Len(Acols)][_nPosTp])

		//--------------------------------------------------------------------------------------
		//Se n�o for tipo de servi�o GERED ele deve mostrar de fato os hist�ricos padr�es
		//--------------------------------------------------------------------------------------
		If PBL->PBL_GERED <> '1'

			cQuery := " SELECT PCE.PCE_CDHIST, PCD.PCD_DESCRI " + c_ent
			cQuery += " FROM " + RetSqlName("PCE") + " PCE, " + RetSqlName("PCD") + " PCD " + c_ent
			cQuery += " WHERE PCE.D_E_L_E_T_ = ' ' " + c_ent
			cQuery += " AND PCD.D_E_L_E_T_ = ' ' " + c_ent
			cQuery += " AND PCE.PCE_FILIAL = '" + xFilial("PCE") 	+ "' " + c_ent
			cQuery += " AND PCD.PCD_FILIAL = '" + xFilial("PCD") 	+ "' " + c_ent
			cQuery += " AND PCE.PCE_TIPOSV = '" + aCols[Len(Acols)][_nPosTp]	+ "' " + c_ent
			cQuery += " AND TRIM(PCE.PCE_CDHIST) = PCD.PCD_COD " + c_ent

			DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),cAlias1, .F., .T.)

			(cAlias1)->(DbGoTop())

			//-------------------------------------------------
			//Valida��o para saber se a query possui resultados
			//-------------------------------------------------
			If (cAlias1)->(Eof())

				Aviso( "Aten��o", "N�o existem dados a consultar, se o tipo de servi�o n�o estiver preenchido favor preencher.", {"Ok"} )

				lRet := .F.

			Else

				Do While (cAlias1)->(!Eof())

					aAdd( aDadosPCE, { (cAlias1)->PCE_CDHIST, (cAlias1)->PCD_DESCRI} )

					(cAlias1)->(DbSkip())

				Enddo
				(cAlias1)->(DbCloseArea())


				DEFINE MSDIALOG _oDlg2 TITLE "Pesquisa Historico Padrao" FROM 000, 000  TO 400, 820 COLORS 0, 16777215 PIXEL

				oCombo:= tComboBox():New(010,004,{|u|if(PCount()>0,cCombo:=u,cCombo)},aItens,100,20,_oDlg2,,{||CABA583J_1(cCombo)},,,,.T.,,,,,,,,,'cCombo')

				@ 010, 120 MSGET oGet1 VAR cGet1 SIZE 200,10 Valid CABA583J_2(cCombo,cGet1)  OF _oDlg2 PIXEL

				@ 030, 004 LISTBOX oListBox1 FIELDS HEADER "Codigo", "Descricao" SIZE 400, 150 OF _oDlg2 COLORS 0, 16777215 COLSIZES 10,50,170,100 PIXEL

				@ 185, 004 BUTTON oButton1 PROMPT "Ok" 		SIZE 037, 012 OF _oDlg2 ACTION (IIF(CABA583J_3(), _oDlg2:End(),.F.)) PIXEL
				@ 185, 057 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 037, 012 OF _oDlg2 ACTION (_oDlg2:End()) PIXEL

				//--------------------------------------------------------------------
				//Ordenando primeiro por codigo, pois � a primeira posi��o do combobox
				//--------------------------------------------------------------------
				ASORT(aDadosPCE)

				oListBox1:SetArray(aDadosPCE)

				oListBox1:bLine := {|| {aDadosPCE[oListBox1:nAT,01],aDadosPCE[oListBox1:nAT,02]}}

				oListBox1:blDblClick := {||IIF(CABA583J_3(), _oDlg2:End(),.F.)}

				ACTIVATE MSDIALOG _oDlg2 CENTERED

			EndIf

		Else

			//PEGAR NA TABELA DE ESPECIALIDADE (BAQ)
			cQuery := " SELECT	                                                " + c_ent
			cQuery += "     CODIGO,	                                            " + c_ent
			cQuery += "     DESCRICAO		 			  				        " + c_ent
			cQuery += " FROM	                                                " + c_ent
			cQuery += " (	                                                    " + c_ent
			cQuery += "     SELECT												" + c_ent
			cQuery += "         DISTINCT		             					" + c_ent
			cQuery += "         BAQ.BAQ_CODESP CODIGO,	                        " + c_ent
			cQuery += "         BAQ.BAQ_DESCRI DESCRICAO		 			  	" + c_ent
			cQuery += "     FROM                                				" + c_ent
			cQuery += "         " + RETSQLNAME("BAQ") + " BAQ					" + c_ent
			cQuery += "     WHERE                               				" + c_ent
			cQuery += "         BAQ.BAQ_FILIAL = ' '   	                        " + c_ent
			cQuery += "         AND BAQ.BAQ_CODINT = '0001'     				" + c_ent
			cQuery += "         AND BAQ.BAQ_CODESP <> ' '       				" + c_ent
			cQuery += "         AND BAQ.BAQ_YUSO = '1'          				" + c_ent
			cQuery += "         AND BAQ.D_E_L_E_T_ = ' '     	                " + c_ent
			cQuery += "         	                                            " + c_ent
			cQuery += "     UNION ALL	                                        " + c_ent
			cQuery += "     	                                                " + c_ent
			cQuery += "     SELECT	                                            " + c_ent
			cQuery += "         PCD.PCD_COD CODIGO,	                            " + c_ent
			cQuery += "         PCD.PCD_DESCRI DESCRICAO	                    " + c_ent
			cQuery += "     FROM	                                            " + c_ent
			cQuery += "         " + RETSQLNAME("PCD") + " PCD					" + c_ent
			cQuery += "     WHERE	                                            " + c_ent
			cQuery += "         PCD.PCD_FILIAL = ' '	                        " + c_ent			
			cQuery += "         AND PCD.PCD_ESPEC = '1'							" + c_ent		
			cQuery += "         AND PCD.D_E_L_E_T_ = ' '						" + c_ent
			cQuery += " )                                                       " + c_ent

			DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),cAlias1, .F., .T.)

			(cAlias1)->(DbGoTop())

			//-------------------------------------------------
			//Valida��o para saber se a query possui resultados
			//-------------------------------------------------
			If (cAlias1)->(Eof())

				Aviso( "Aten��o", "N�o existem dados a consultar, se o tipo de servi�o n�o estiver preenchido favor preencher.", {"Ok"} )

				lRet := .F.

			Else

				Do While (cAlias1)->(!Eof())

					aAdd( aDadosPCE, { (cAlias1)->CODIGO, (cAlias1)->DESCRICAO} )

					(cAlias1)->(DbSkip())

				Enddo
				(cAlias1)->(DbCloseArea())


				DEFINE MSDIALOG _oDlg2 TITLE "Pesquisa de Especialidades" FROM 000, 000  TO 400, 820 COLORS 0, 16777215 PIXEL

				oCombo:= tComboBox():New(010,004,{|u|if(PCount()>0,cCombo:=u,cCombo)},aItens,100,20,_oDlg2,,{||CABA583J_1(cCombo)},,,,.T.,,,,,,,,,'cCombo')

				@ 010, 120 MSGET oGet1 VAR cGet1 SIZE 200,10 Valid CABA583J_2(cCombo,cGet1)  OF _oDlg2 PIXEL

				@ 030, 004 LISTBOX oListBox1 FIELDS HEADER "Codigo", "Descricao" SIZE 400, 150 OF _oDlg2 COLORS 0, 16777215 COLSIZES 10,50,170,100 PIXEL

				@ 185, 004 BUTTON oButton1 PROMPT "Ok" 		SIZE 037, 012 OF _oDlg2 ACTION (IIF(CABA583J_3(), _oDlg2:End(),.F.)) PIXEL
				@ 185, 057 BUTTON oButton2 PROMPT "Cancelar" 	SIZE 037, 012 OF _oDlg2 ACTION (_oDlg2:End()) PIXEL

				//--------------------------------------------------------------------
				//Ordenando primeiro por codigo, pois � a primeira posi��o do combobox
				//--------------------------------------------------------------------
				ASORT(aDadosPCE)

				oListBox1:SetArray(aDadosPCE)

				oListBox1:bLine := {|| {aDadosPCE[oListBox1:nAT,01],aDadosPCE[oListBox1:nAT,02]}}

				oListBox1:blDblClick := {||IIF(CABA583J_3(), _oDlg2:End(),.F.)}

				ACTIVATE MSDIALOG _oDlg2 CENTERED

			EndIf

		EndIf

	EndIf

	RestArea(_aArPBL)
	RestArea(_aArPCE)
	RestArea(_aArea)

Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583J_1 �Autor  �Angelo Henrique    � Data �  06/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para ordenar o vetor da pesquisa.         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
������������������������������������ �������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA583J_1(_cParam)

	Default _cParam := ""

	If SUBSTR(_cParam,1,1) == "1" //Codigo

		ASORT(aDadosPCE)

	ElseIf SUBSTR(_cParam,1,1) == "2" //Nome

		ASORT(aDadosPCE,,, {|x, y| x[2] < y[2]})

	EndIf

	oListBox1:Refresh() //Refor�ando a atualiza��o da tela
	oListBox1:SetArray(aDadosPCE)
	oListBox1:bLine := {|| {aDadosPCE[oListBox1:nAT,01],aDadosPCE[oListBox1:nAT,02]}}
	oListBox1:Refresh() //Refor�ando a atualiza��o da tela

Return aDadosPCE

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583J_2�Autor  �Angelo Henrique     � Data �  29/10/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para ordenar o vetor da pesquisa conforme ���
���          �preenchido no GET                                           ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA583J_2(_cParam1,_cParam2)

	Default _cParam1 := "" //Op��o selecionada no combo
	Default _cParam2 := "" //Caracteres digitados no MSGET

	If SUBSTR(_cParam1,1,1) == "1" //Codigo

		ASORT(aDadosPCE,,, {|x, y| x[1] = UPPER(AllTrim(_cParam2))})

	ElseIf SUBSTR(_cParam1,1,1) == "2" //Nome

		ASORT(aDadosPCE,,, {|x, y| x[2] = UPPER(AllTrim(_cParam2))})

	EndIf

	oListBox1:Refresh() //Refor�ando a atualiza��o da tela
	oListBox1:SetArray(aDadosPCE)
	oListBox1:bLine := {|| {aDadosPCE[oListBox1:nAT,01],aDadosPCE[oListBox1:nAT,02]}}
	oListBox1:Refresh() //Refor�ando a atualiza��o da tela

Return aDadosPCE

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583J_3�Autor  �Angelo Henrique     � Data �  29/10/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para pegar a linha selecionada ap�s a     ���
���          �pesquisa da consulta padr�o.                                ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA583J_3()

	Local _lRet		:= .T.

	Public _CodPCE	:= ""
	Public _cDsPCE	:= ""

	_CodPCE	:= aDadosPCE[oListBox1:nAT][1]
	_cDsPCE	:= AllTrim(aDadosPCE[oListBox1:nAT][2])

Return _lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583K  �Autor  �Angelo Henrique     � Data �  03/10/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar o preenchimento sequencial   ���
���          � dos campos obrigat�rios na tela de PA.                     ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
���Parametros� _cParam1 := Recebe qual o n�vel de valida��o deve ser      ���
���          � executado.                                                 ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583K(_cParam1)

	Local _aArea 		:= GetArea()
	Local _lRet 		:= .T.
	Local _nPosTp		:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_TIPOSV" 	})
	Local _aSays		:= {}
	Local _aBut			:= {}

	Default _cParam1 	:= "0"

	//-----------------------------------------------------------------
	//Ordem de preenchimento conforme encaminhado pela Maria
	//-----------------------------------------------------------------
	// 1 - Canal
	// 2 - Porta de Entrada
	// 3 - Tipo de Demanda
	// 4 - Tipo de Servi�o
	// 5 - Hist�rico Padr�o
	//-----------------------------------------------------------------

	AADD(_aSays, "Favor preencher os campos na seguinte ordem: ")
	AADD(_aSays, " 1 - Canal "				)
	AADD(_aSays, " 2 - Porta de Entrada "	)
	AADD(_aSays, " 3 - Tipo de Demanda "	)
	AADD(_aSays, " 4 - Tipo de Servi�o " 	)
	AADD(_aSays, " 5 - Hist�rico Padr�o"	)

	AADD(_aBut, {1, .T., {|| lExeFun := .T., FechaBatch()}})



	If _cParam1 == "1" //Valida��o da Porta de Entrada

		If (Empty(M->ZX_CANAL) .OR. M->ZX_CANAL = '000000')

			_lRet := .F.

		EndIf

	ElseIf _cParam1 == "2" //Valida��o do Tipo de Demanda

		If (Empty(M->ZX_CANAL) .OR. M->ZX_CANAL = '000000') .OR. (Empty(M->ZX_PTENT) .OR. M->ZX_PTENT = '000000')

			_lRet := .F.

		EndIf

	ElseIf _cParam1 == "3" //Valida��o do Tipo de Servi�o

		If (Empty(M->ZX_CANAL) .OR. M->ZX_CANAL = '000000') .OR. (Empty(M->ZX_PTENT).OR. M->ZX_PTENT = '000000' ).OR. Empty(M->ZX_TPDEM)

			_lRet := .F.

		EndIf

	ElseIf _cParam1 == "4" //Valida��o do Hist�rico Padr�o
		//Acerto na validacao pra pegar somente na ultima linha do acols
		If (Empty(M->ZX_CANAL) .OR. M->ZX_CANAL = '000000') .OR. (Empty(M->ZX_PTENT) .OR. M->ZX_PTENT = '000000' ) .OR. Empty(M->ZX_TPDEM) .OR. Empty(aCols[Len(aCols)][_nPosTp])

			_lRet := .F.

		EndIf

	EndIf

	If !(_lRet)

		FORMBATCH( "Aten��o", _aSays, _aBut)

	EndIf

	//------------------------------------------------------------------------------------------------------
	//Inicio - Adicionando valida��o para n�o ser preenchido Hist�ricos sem vinculo com o tipo de servi�o
	//------------------------------------------------------------------------------------------------------
	If _lRet .And. _cParam1 == "4"

		If !Empty(aCols[Len(Acols)][_nPosTp])

			//----------------------------------------------------------------------------------
			//Valida��o da linha atual
			//----------------------------------------------------------------------------------
			If !Empty(M->ZY_HISTPAD)

				DbSelectArea("PBL")
				DbSetOrder(1)
				If DbSeek(xFilial("PBL")+aCols[Len(Acols)][_nPosTp])

					//--------------------------------------------------------------------------------------
					//Se n�o for tipo de servi�o GERED ele deve mostrar de fato os hist�ricos padr�es
					//--------------------------------------------------------------------------------------
					If PBL->PBL_GERED <> '1'

						DbSelectArea("PCE")
						DbSetOrder(1)
						If !(DbSeek(xFilial("PCE") + aCols[Len(Acols)][_nPosTp] + PADL(ALLTRIM(M->ZY_HISTPAD),TAMSX3("ZY_HISTPAD")[1],"0") ))

							_lRet := .F.

							Aviso("Aten��o","Hist�rico n�o vinculado com o tipo de servi�o.",{"OK"})

						EndIf

					Else

						DbSelectArea("BAQ")
						DbSetOrder(1)
						If !(DbSeek(xFilial("BAQ") + "0001" + PADR(ALLTRIM(M->ZY_HISTPAD),tamsx3("BAQ_CODESP")[1])))

							DbSelectArea("PCE")
							DbSetOrder(1)
							If !(DbSeek(xFilial("PCE") + aCols[n][_nPosTp] + PADL(ALLTRIM(M->ZY_HISTPAD),TAMSX3("ZY_HISTPAD")[1],"0") ))

								_lRet := .F.

								Aviso("Aten��o","Hist�rico n�o encontrado nos vinculos, favor analisar.",{"OK"})							

							EndIf

						Else

							If BAQ->BAQ_YUSO = '2'

								_lRet := .F.

								Aviso("Aten��o","Especialidade bloqueada no sistema, favor entrar em contato com a GERED.",{"OK"})

							EndIf

						EndIf


					EndIf

				EndIf

			EndIf

		EndIf

	EndIf

	//------------------------------------------------------------------------------------------------------
	//Fim - Adicionando valida��o para n�o ser preenchido Hist�ricos sem vinculo com o tipo de servi�o
	//------------------------------------------------------------------------------------------------------

	RestArea(_aArea)

Return _lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583L  �Autor  �Angelo Henrique     � Data �  11/12/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar o campo de observa��o e de   ���
���          � resposta para que somente o proprio usu�rio possa alterar  ���
���          � este campo.                                                ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583L(_cParam)

	Local _aArea	:= GetArea()
	Local _aAreSZY	:= SZY->(GetArea())
	Local _nPosDig	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_USDIGIT"	})
	Local _nPosLog	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_LOGRESP"	})
	Local _lRet		:= .T.
	Local _cMvUsr	:= GetNewPar("MV_XUSTPSV","")

	//----------------------------------------------
	//Parametros:
	//----------------------------------------------
	//1 - para campo de obersa��o
	//2 - para campo de resposta
	//3 - para campo tipo de servi�o
	//----------------------------------------------
	Default _cParam	:= "1"

	If _cParam = "1"

		If !Empty(aCols[n][_nPosDig])

			If AllTrim(CUSERNAME) != AllTrim(aCols[n][_nPosDig])

				Aviso("Aten��o","N�o � poss�vel alterar este campo, pois voc� n�o � usu�rio responsavel por essa informa��o.",{"OK"})

				_lRet := .F.

			EndIf

		EndIf

	ElseIf _cParam = "2"

		If !Empty(aCols[n][_nPosLog])

			If AllTrim(CUSERNAME) != AllTrim(aCols[n][_nPosLog])

				Aviso("Aten��o","N�o � poss�vel alterar este campo, pois voc� n�o � usu�rio responsavel por essa informa��o.",{"OK"})

				_lRet := .F.

			EndIf

		EndIf

	ElseIf _cParam = "3"

		If AllTrim(CUSERNAME) != AllTrim(aCols[n][_nPosDig])

			If AllTrim(CUSERNAME) != SZX->ZX_USDIGIT

				If !(AllTrim(CUSERNAME) $ _cMvUsr)

					Aviso("Aten��o","Voc� n�o possui permiss�o para alterar este campo.",{"OK"})

					_lRet := .F.

				EndIf

			EndIf

		EndIf

	EndIf

	RestArea(_aAreSZY	)
	RestArea(_aArea		)

Return _lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583M  �Autor  �Angelo Henrique     � Data �  22/01/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para validar o campo canal, pois para o   ���
���          � canal da Diretoria somente os usu�rios cadastrados no      ���
���          � parametro podem utilizar.                                  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583M(_cParam)

	Local _aArea	:= GetArea()
	Local _aAreSZX	:= SZX->(GetArea())
	Local _aAreSZY	:= SZY->(GetArea())
	Local _lRet		:= .T.
	//Local c_CodUsr	:= RetCodUsr() //Chamado 83831 - Angelo Henrique - Data: 09/02/2022

	Default _cParam	:= ""

	If ExistCPO("PCB",PADL(ALLTRIM(M->ZX_CANAL),TAMSX3("ZX_CANAL")[1],"0"))

		/*
		//---------------------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 09/02/2022 - Chamado: 83831
		//---------------------------------------------------------------------------------------------------------
		//A pedido do chamado ser� removido a valida��o de protocolos oriundos da DIRETORIA
		//Este parametro permanece no relat�rio CABR212.
		//---------------------------------------------------------------------------------------------------------
		If !(Upper(AllTrim(c_CodUsr)) $ Upper(AllTrim(GetNewPar("MV_XUSUDIR","")))) .And. _cParam = "000014"

			Aviso("Aten��o","Canal Diretoria permitido apenas para usu�rios espec�ficos.",{"OK"})

			_lRet := .F.

		EndIf
		*/

	Else

		MsgAlert('Canal n�o existe')

		_lRet := .F.

	EndIf

	RestArea(_aAreSZY)
	RestArea(_aAreSZX)
	RestArea(_aArea	 )

Return _lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA583N  �Autor  �Angelo Henrique     � Data �  13/06/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para n�o permitir que a linha digitada no ���
���          � protocolo ap�s ter sido gravada n�o ser alterada por nenhum���
���          � usu�rio conforme solicitado no chamado:50199.              ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA583N()

	Local _aArea	:= GetArea()
	Local _aAreSZX	:= SZX->(GetArea())
	Local _aAreSZY	:= SZY->(GetArea())
	Local _lRet		:= .T.
	Local _cQuery	:= ""
	Local cAliQry 	:= GetNextAlias()
	Local _nPosSrv	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQSERV" })
	Local _nPosObs	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_OBS" 	})
	Local _nPosRep 	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_RESPOST" })
	Local _nPosSeq 	:= Ascan(aHeader,{|x| AllTrim(x[2]) == "ZY_SEQBA" })

	//------------------------------------------------------------------------------------------
	//Caso seja a primeira inclus�o do protocolo o mesmo n�o exibe o sequencial no aCols
	//------------------------------------------------------------------------------------------
	If !Empty(AllTrim(aCols[Len(Acols)][_nPosSrv]))

		_cQuery := " SELECT 												" + c_ent
		_cQuery += "	SZY.ZY_SEQBA PROT,									" + c_ent
		_cQuery += "	SZY.ZY_SEQSERV LINHA,								" + c_ent
		_cQuery += "	NVL(TRIM(SZY.ZY_OBS),' ') OBS,						" + c_ent
		_cQuery += "	NVL(TRIM(SZY.ZY_RESPOST),' ') RESP					" + c_ent
		_cQuery += " FROM													" + c_ent
		_cQuery += " 	" + RETSQLNAME("SZY") + " SZY 						" + c_ent
		_cQuery += " WHERE													" + c_ent
		_cQuery += "	SZY.ZY_FILIAL = '" + xFilial("SZY") + "'			" + c_ent
		_cQuery += " 	AND SZY.D_E_L_E_T_ = ' '							" + c_ent
		_cQuery += " 	AND SZY.ZY_SEQBA = '" + acols[Len(aCols)][_nPosSeq] + "'				" + c_ent
		_cQuery += " 	AND SZY.ZY_SEQSERV = '" +acols[Len(aCols)][_nPosSrv] + "'	" + c_ent

		If Select(cAliQry)>0
			(cAliQry)->(DbCloseArea())
		EndIf

		DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),cAliQry,.T.,.T.)

		DbSelectArea(cAliQry)

		If !((cAliQry)->(Eof()))

			//------------------------------------------------------------------------------------
			//Colocar valida��o aqui para ver se a linha esta diferente do gravado
			//------------------------------------------------------------------------------------
			If aCols[Len(Acols)][_nPosObs] != (cAliQry)->OBS .Or. aCols[Len(Acols)][_nPosRep] != (cAliQry)->RESP .Or. M->ZY_OBS != (cAliQry)->OBS .Or. M->ZY_RESPOST != (cAliQry)->RESP

				_lRet := .F.

				_cMsg := "N�o � possivel alterar esta linha do protocolo, " + c_ent
				_cMsg += "pois a mesma j� foi inclu�da anteriormente no sistema."

				Aviso("Aten��o",_cMsg,{"OK"})

			EndIf

		EndIf

		If Select(cAliQry)>0
			(cAliQry)->(DbCloseArea())
		EndIf

	EndIf

	RestArea(_aAreSZY)
	RestArea(_aAreSZX)
	RestArea(_aArea	 )

Return _lRet


User Function SLAARE()

	Local cQuery := ''
	Local aNumeros := {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"}
	Local aGroups := {}
	Local aObjs := {}
	Local aSizeEsq := {5,5,40}
	Local nHeight :=200
	Local nCont := 0
	Local oFont     := TFont():New( "Arial",,-12,.T.)
	Local nY		:= 0

	Static oDlg
	Static aCombo := {}
	Static nSlaRet := 0
	Static nSlaRec := 0
	Static aSays := {}

	//SELECT PDF_QTDSLA FROM PDF010 WHERE D_E_L_E_T_ = ' ' AND  PDF_CODSLA = 'C     0000020000021001  ' AND PDF_CODARE = '000002'

	cQuery := " SELECT PCF_COD, PCF_DESCRI FROM "+RetSqlName("PCF")+" WHERE D_E_L_E_T_ = ' ' ORDER BY R_E_C_N_O_ "

	cAliasPCF:= MpSysOpenQuery(cQuery)

	If !(cAliasPCF)->(Eof())

		While !(cAliasPCF)->(Eof())

			nCont++

			AADD(aGroups,Nil)
			AADD(aSays,{Nil,Nil,Nil})
			AADD(aCombo,{Nil})

			cCodAre := (cAliasPCF)->PCF_COD
			cDesc :=  (cAliasPCF)->PCF_DESCRI

			cQueryPDF := "SELECT PDF_QTDSLA FROM "+RetSqlName("PDF")+" WHERE PDF_CODSLA = '"+(PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV))+"' AND PDF_CODARE = '"+cCodAre+"' AND D_E_L_E_T_ = ' ' "
			cAliasPDF := MpSysOpenQuery(cQueryPDF)

			cQtdSla := IIF (!(cAliasPDF)->(Eof()),  (cAliasPDF)->PDF_QTDSLA,  "0")

			(cAliasPDF)->(DbCloseArea())

			AADD(aObjs,{&('{|| "'+cCodAre+'"}') ,;
				+AllTrim(cDesc),;
				&('{|| "'+cValToChar(cQtdSla)+'"}') })

			(cAliasPCF)->(DbSkip())

		Enddo

	EndIf

	cQueryPDF := "SELECT PDF_QTDSLA, PDF_ARERET, PDF_AREREC  FROM "+RetSqlName("PDF")+" WHERE PDF_CODSLA = '"+(PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV))+"'  AND (PDF_ARERET = 'T' OR PDF_AREREC = 'T')  AND D_E_L_E_T_ = ' ' "
	cAliasPDF := MpSysOpenQuery(cQueryPDF)

	If !(cAliasPDF)->(Eof())

		While !(cAliasPDF)->(Eof())

			If (cAliasPDF)->PDF_ARERET == 'T'

				nSlaRet := (cAliasPDF)->PDF_QTDSLA

			Else

				nSlaRec := (cAliasPDF)->PDF_QTDSLA

			EndIf

			(cAliasPDF)->(DbSkip())

		Enddo

	EndIf

	nHeight := IIF (nCont > 6 , nCont * 63 ,nHeight)

	DEFINE MSDIALOG oDlg TITLE " SLA X AREAS  " FROM 000, 000  TO 800, 400 COLORS 0, 16777215 PIXEL
	oScroll := TScrollArea():New(oDlg,01,01,100,100)
	oScroll:Align := CONTROL_ALIGN_ALLCLIENT
	oPanel := TPanelCss():New(000,000,nil,oScroll,nil,nil,nil,nil,nil,100,nHeight,nil,nil)

	oScroll:SetFrame( oPanel )

	For nY := 1 To nCont

		aGroups[nY]:= tGroup():New(aSizeEsq[1],aSizeEsq[2], aSizeEsq[3],192,aObjs[nY][2],oPanel,0,0,.T.)

		aSizeEsq[1] += 10

		aSays[nY][1] := TSay():New( aSizeEsq[1] ,010, aObjs[nY][1] ,aGroups[nY],, oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

		aSizeEsq[1] += 5

		aSays[nY][2] := TSay():New( aSizeEsq[1] ,045, {|| "SLA" }  ,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

		aCombo[nY][1] :=   TComboBox():New(aSizeEsq[1],85,aObjs[nY][3], aNumeros,84,010,aGroups[nY],, ,,,,.T.,,,,,,,,,)

		aSizeEsq[1] += 35

		aSizeEsq[3] += 50

	Next

	AADD(aGroups,Nil)
	AADD(aSays,{Nil,Nil,Nil})
	AADD(aCombo,{Nil})

	//nY++

	aGroups[nY]:= tGroup():New(aSizeEsq[1],aSizeEsq[2], aSizeEsq[3],192,'ENTRADA',oPanel,0,0,.T.)

	aSizeEsq[1] += 10

	aSays[nY][1] := TSay():New( aSizeEsq[1] ,010,{ || "E" } ,aGroups[nY],, oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

	aSizeEsq[1] += 5

	aSays[nY][2] := TSay():New( aSizeEsq[1] ,045, {|| "SLA" }  ,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

	aCombo[nY][1] :=   TComboBox():New(aSizeEsq[1],85,{ || cValToChar(nSlaRec) }, aNumeros,84,010,aGroups[nY],, ,,,,.T.,,,,,,,,,)

	aSizeEsq[1] += 35

	aSizeEsq[3] += 50

	nY++

	AADD(aGroups,Nil)
	AADD(aSays,{Nil,Nil,Nil})
	AADD(aCombo,{Nil})

	aGroups[nY]:= tGroup():New(aSizeEsq[1],aSizeEsq[2], aSizeEsq[3],192,'RETORNO',oPanel,0,0,.T.)

	aSizeEsq[1] += 10

	aSays[nY][1] := TSay():New( aSizeEsq[1] ,010, { || "R" }  ,aGroups[nY],, oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

	aSizeEsq[1] += 5

	aSays[nY][2] := TSay():New( aSizeEsq[1] ,045, {|| "SLA" }  ,aGroups[nY],,oFont,.F.,.F.,.F.,.T.,0,CLR_WHITE)

	aCombo[nY][1] :=   TComboBox():New(aSizeEsq[1],85,{ || cValToChar(nSlaRet) }, aNumeros,84,010,aGroups[nY],, ,,,,.T.,,,,,,,,,)

	aSizeEsq[1] += 35

	aSizeEsq[3] += 50

	nY--

	aSizeEsq[1] -= 10

	//oBtn1 := TButton():New( 10,aSizeEsq[1],"Atualizar SLAs" ,oDlg, { || zUPDSLA() },061,015,,,,.T.,,"",,,,.F. )

	@ aSizeEsq[1], 129 BUTTON oButton1 PROMPT "Atualizar SLAs" SIZE 061, 015 OF oPanel ACTION { || zUPDSLA() }  PIXEL

	ACTIVATE MSDIALOG oDlg CENTERED

Return

/*/{Protheus.doc} zUPDSLA
Atualiza SLA
@type function
@version  1.0
@author wallace
@since 01/08/2021
/*/
Static Function zUPDSLA()

	Local nX

	dbSelectArea("PDF")

	dbSetOrder(1)

	For nX := 1 To Len(aCombo)

		nVal := aCombo[nX][1]:nAt -1


		If aSays[nX][1]:cCaption == "E"


			If lSLAExiste({PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV),' ','F','T'})

				cUpd := " UPDATE "+RetSqlName("PDF")+" SET PDF_QTDSLA = '"+cVALTOCHAR(nVal)+"' "
				cUpd += " WHERE PDF_CODSLA = '"+PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV)+"' "
				cUpd += " AND PDF_ARERET = 'F' AND PDF_AREREC = 'T'  AND D_E_L_E_T_ = ' ' AND PDF_CODARE = ' ' "

				nStatus := TCSqlExec(cUpd)

				If (nStatus < 0)
					QOut("TCSQLError() " + TCSQLError())
				EndIf

			Else

				RecLock("PDF", .T.)
				PDF->PDF_CODSLA := PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV)
				PDF->PDF_CODARE := ' '
				PDF->PDF_QTDSLA := nVal
				PDF->PDF_ARERET := .F.
				PDF->PDF_AREREC := .T.
				PDF->PDF_CDDEMA := PCG->PCG_CDDEMA
				PDF->PDF_CDCANA := PCG->PCG_CDPORT
				PDF->PDF_CDPORT := PCG->PCG_CDCANA
				PDF->PDF_CDSERV := PCG->PCG_CDSERV

				MsUnLock()

			EndIf

			Loop

		ElseIf aSays[nX][1]:cCaption == "R"


			If lSLAExiste({PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV),' ','T','F'})

				cUpd := " UPDATE "+RetSqlName("PDF")+" SET PDF_QTDSLA = '"+cVALTOCHAR(nVal)+"' "
				cUpd += " WHERE PDF_CODSLA = '"+PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV)+"' "
				cUpd += " AND PDF_ARERET = 'T' AND PDF_AREREC = 'F'  AND D_E_L_E_T_ = ' ' AND PDF_CODARE = ' ' "

				nStatus := TCSqlExec(cUpd)

				If (nStatus < 0)
					QOut("TCSQLError() " + TCSQLError())
				EndIf

			Else

				RecLock("PDF", .T.)
				PDF->PDF_CODSLA := PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV)
				PDF->PDF_CODARE := ' '
				PDF->PDF_QTDSLA := nVal
				PDF->PDF_ARERET := .F.
				PDF->PDF_AREREC := .T.
				PDF->PDF_CDDEMA := PCG->PCG_CDDEMA
				PDF->PDF_CDCANA := PCG->PCG_CDPORT
				PDF->PDF_CDPORT := PCG->PCG_CDCANA
				PDF->PDF_CDSERV := PCG->PCG_CDSERV

				MsUnLock()

			EndIf

			Loop

		EndIf


		IF dbSeek(xFilial("PDF")+PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV)+aSays[nX][1]:cCaption)     // Filial: 01 / C�digo: 000001 / Loja: 02

			RecLock("PDF", .F.)
			PDF->PDF_QTDSLA := nVal
			MsUnLock()

		ELSE

			RecLock("PDF", .T.)
			PDF->PDF_CODSLA := PCG->(PCG_CDDEMA+PCG_CDPORT+PCG_CDCANA+PCG_CDSERV)
			PDF->PDF_CODARE := aSays[nX][1]:cCaption
			PDF->PDF_QTDSLA := nVal
			PDF->PDF_ARERET := .F.
			PDF->PDF_AREREC := .F.
			PDF->PDF_CDDEMA := PCG->PCG_CDDEMA
			PDF->PDF_CDCANA := PCG->PCG_CDPORT
			PDF->PDF_CDPORT := PCG->PCG_CDCANA
			PDF->PDF_CDSERV := PCG->PCG_CDSERV
			MsUnLock()

		ENDIF

	Next nX

	MsgInfo("SLAs atualizadas!", FunName())

	oDlg:End()

	aCombo := {}

Return

/*/{Protheus.doc} lSLAExiste
Existe SLA
@type function
@version  1.0
@author Wallace
@since 01/08/2021
@param aInfoSLA, array, informa��o
@return variant, verdadeiro ou falso
/*/
Static Function lSLAExiste(aInfoSLA)

	Local lRet:= .F.

	Local cQuery := ''

	Local cAlias

	cQuery := "SELECT *  FROM "+RetSqlName("PDF")+" WHERE PDF_CODSLA = '"+aInfoSLA[1]+"' AND PDF_CODARE = '"+aInfoSLA[2]+"' AND PDF_ARERET = '"+aInfoSLA[3]+"' AND PDF_AREREC = '"+aInfoSLA[4]+"'   AND D_E_L_E_T_ = ' ' "

	cAlias := MpSysOpenQuery(cQuery)

	If !(cAlias)->(Eof())

		lRet := .T.

	EndIf

	//lRet := IIF(,.T.,.F.)

Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA583O �Autor  � Fred O. C. Jr      � Data �  30/09/21   ���
�������������������������������������������������������������������������͹��
���Desc.     �    Validar quem pode alterar/incluir registros             ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CABA583O

	Local lRet      := .T.
	Local cGETIN    := SuperGetMv('MV_XGETIN')  // Usu�rio de TI (GETIN)
	Local cUsLib    := SuperGetMv('MV_XPASLA') // Usu�rio liberado para inclus�o/altera��o da rotina

	if !(__cUserID $ cGETIN) .and. !(__cUserID $ cUsLib)

		lRet    := .F.
		Aviso('ATEN��O', 'Usu�rio n�o habilitado a executar esta rotina. Entrar em contato com a GEATE.', {'Ok'})

	endif

return lRet
