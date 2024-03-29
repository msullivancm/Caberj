#Include "PROTHEUS.CH"
#Include "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � FA050INC � Autor � Eduardo Folly (Korus) � Data � 22/08/08 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Valida��o do preenchimento do campo de compet�ncia do PA.  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Caberj                                                     ���
��������������������������������������������������������������������������ٱ�
��� Altera��es �                                                          ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

//**********************
User Function FA050INC()
//**********************
	Local lRet := U_VldCompPa()

	M->e2_datalib:=Iif (Trim(M->e2_prefixo) + Trim(M->e2_tipo) + Trim(M->e2_origem) $ ('AEDFTPLSMPAG/CLIFTPLSMPAG/CONFTPLSMPAG/HOSFTPLSMPAG/INTFTPLSMPAG/LABFTPLSMPAG/MEDFTPLSMPAG/NFENFMATA100/NUPFTPLSMPAG/ODNFTPLSMPAG/OPEFTPLSMPAG/REMFTPLSMPAG/SVDFTPLSMPAG/UINNFMATA100'), Stod(""), dDataBase)

	If lRet
		lRet := U_VlCodbar( M->E2_CODBAR, Trim(M->E2_TIPO)  )
	Endif

	If lRet
		lRet := U_VlLinDig( M->E2_LINDIG, Trim(M->E2_TIPO)  )
	Endif

Return lRet

//********************************************
User Function VlCodbar( _cCodBar, _cTipo )
//********************************************

	// MMT - 05/07/2022 - Implementa��o de valida��o do codigo de barras para boletos
	// MMT - 06/07/2022 - Valida��o n�o ser� obrigat�ria para t�tulos gerados via MATA103 via execauto
	Local lRet	:= .T.
	Local cMsg  := "O campo codigo de barras deve ser preenchido."
	Local cTit  := "FA050INC"

	If !IsInCallStack("MATA103")
		If Empty( _cCodBar ) .AND. _cTipo = 'BOL'
			lRet := .F.
			IF !iSBLIND() .AND. !LF050AUTO
				MsgInfo( cMsg, cTit )
			Endif
		EndIf
	Endif

Return lRet

//********************************************
User Function VlLinDig ( _cLinDig, _cTipo )
//********************************************

	// MMT - 05/07/2022 - Implementa��o de valida��o da linha digit�vel
	// MMT - 06/07/2022 - Valida��o n�o ser� obrigat�ria para t�tulos gerados via MATA103 via execauto
	Local lRet	:= .T.
	Local cMsg  := "O campo linha digit�vel deve ser preenchido."
	Local cTit  := "FA050INC"

	If !IsInCallStack("MATA103")
		If Empty( _cLinDig ) .AND. _cTipo = 'BOL'
			lRet := .F.
			IF !iSBLIND() .AND. !LF050AUTO
				MsgInfo( cMsg, cTit )
			Endif
		Endif
	EndIf

Return lRet

//***********************
User Function VldCompPa()
//***********************
	Local lRet	:= .T.
	Local nData	:= Val(SubStr(Dtos(dDataBase), 3, 4))

	If M->E2_TIPO == "PA "
		If Empty(M->E2_YMECPPA) .Or. Empty(M->E2_YANCPPA)
			lRet := .F.
			Help("", 1, "COMPTPA",,"Os campos de mes e ano da competencia do"+chr(10)+chr(13)+"PA devem ser preenchidos.",1)
		EndIf

		If lRet .And. Val(M->E2_YANCPPA + M->E2_YMECPPA) < nData
			lRet := .F.
			Help("", 1, "COMPTPA",,"A data de competencia � inferior a data atual.",1)
		EndIf
	EndIf
Return lRet

/*
User Function MTCOLSE2()

Local aVet := {}

Return (Nil)
*
/*
User Function MT103SE2() 

Local aVet := {}

		If SX3->(MsSeek("E2_CODBAR"))

			AADD(aVet,{TRIM(x3titulo()),;
							SX3->X3_CAMPO,;
							SX3->X3_PICTURE,;
							SX3->X3_TAMANHO,;
							SX3->X3_DECIMAL,;
							"",;
							SX3->X3_USADO,;
							SX3->X3_TIPO,;
							SX3->X3_F3,;
							SX3->X3_CONTEXT,;
							SX3->X3_CBOX,;
							SX3->X3_RELACAO,;
							".T."})
		EndIf

Return(aVet)
*/



