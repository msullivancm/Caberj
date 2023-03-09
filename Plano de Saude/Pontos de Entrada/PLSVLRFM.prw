#INCLUDE "PROTHEUS.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSVLRFM  �Autor  �Marcela Coimbra     � Data �  08/08/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para bloquear a cobran�a de mensalidade   ���
���          � caso o motivo de bloqueio esteja informado no par�metro    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/     

User Function PLSVLRFM()

	Local aRet    	:= paramixb[1]
	//Local cMatric 	:= paramixb[2] // Matricula
	//Local cAno    	:= paramixb[3] // Ano
	//Local cMes    	:= paramixb[4] //Mes
	Local aJaFat  	:= paramixb[5]
	Local aRetMov 	:= paramixb[6]
	//Local aVazio  	:= paramixb[7]
	Local aRetAcF 	:= paramixb[8]
	Local aRetAcu 	:= paramixb[9]
	Local n_Count 	:= 0
	Local n_Cont	:= 0
	Local c_AnoMes	:= ""
	Local a_Area 	:= BA3->( GETAREA() )
	Local a_Areabm1 := BM1->( GETAREA() )
	Local n_ValTot 	:= 0

	n_Total := Len( aRet )

	For n_Count := 1 to n_Total

		If aRet[n_Count][3] == '118'

			c_AnoMes := PLSDIMAM(aRet[n_Count][41],aRet[n_Count][42],"0")

			dbSelectArea("BM1")
			dbSetOrder(1)
			If dbSeek(XFILIAL("BM1") + SUBSTR(aRet[n_Count][7], 1, 14 ) + c_AnoMes + SUBSTR(aRet[n_Count][7], 15, 02 ) ) // BM1_FILIAL+BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_ANO+BM1_MES+BM1_TIPREG+BM1_SEQ

				c_Filtro := XFILIAL("BM1") + SUBSTR(aRet[n_Count][7], 1, 14 ) + c_AnoMes + SUBSTR(aRet[n_Count][7], 15, 02 )

				While !BM1->( EOF() ) .AND. BM1->(BM1_FILIAL+BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_ANO+BM1_MES+BM1_TIPREG) == c_Filtro

					If BM1->BM1_CODTIP == '101'

						adel(aRet,n_Count)
						asize(aRet,Len(aRet)-1)
						n_Count--

					EndIf

					BM1->( dbSkip() )

				EndDo

			EndIf

		EndIf

		If n_Count == Len(aRet)

			exit

		EndIf

	Next

	//**'RN 412 - Marcela Coimbra - Escreve na BCA o status da cobran�a'**
	If FunName() == "PLSA627"

		For n_Cont := 1 to Len( aRet )

			n_ValTot += Iif( aRet[ n_Cont ][ 1 ] == "1", aRet[ n_Cont ][ 2 ] , aRet[ n_Cont ][ 2 ]*-1 )

		Next

		If n_ValTot <> 0

			dbSelectArea("BCA")
			dbSetOrder(1)
			If dbSeek( xFilial("BCA") + SUBSTR(aRet[1][7], 1, 14) )

				While !BCA->( EOF() ) .AND. BCA->BCA_MATRIC = SUBSTR(aRet[1][7], 1, 14)

					If (BCA->BCA_MOTBLO == Replace(GetMv("MV_XBQFFAM"),"'",'') .OR. BCA->BCA_MOTBLO ==  Replace(GetMv("MV_XBQFUSU"),"'",'') ) .AND. BCA->BCA_XSTATU == "2"  .AND. !Empty( BCA->BCA_XSTATU )

						RecLock("BCA",.F.)

						BCA->BCA_XSTATU := iif( n_ValTot > 0, "3" , "4" )

						MsUnLock()

					EndIf

					//-----------------------------------------------------------------------------------
					//Angelo Henrique - Data: 19/07/2019 - RN 438 - Processo de Portabilidade
					//-----------------------------------------------------------------------------------
					If (BCA->BCA_MOTBLO == GetMv("MV_XBQPOUS") .OR. BCA->BCA_MOTBLO == GetMv("MV_XBQPOFM") ) .AND. BCA->BCA_XSTATU == "2"  .AND. !Empty( BCA->BCA_XSTATU )

						RecLock("BCA",.F.)

						BCA->BCA_XSTATU := iif( n_ValTot > 0, "5" , "4" )

						MsUnLock()

					EndIf

					//-----------------------------------------------------------------------------------
					//Angelo Henrique - Data: 19/07/2019 - RN 438 - Processo de Obito
					//-----------------------------------------------------------------------------------
					If (BCA->BCA_MOTBLO == GetMv("MV_XBQOBUS") .OR. BCA->BCA_MOTBLO == GetMv("MV_XBQOBFM") ) .AND. BCA->BCA_XSTATU == "2"  .AND. !Empty( BCA->BCA_XSTATU )

						RecLock("BCA",.F.)

						BCA->BCA_XSTATU := iif( n_ValTot > 0, "5" , "4" )

						MsUnLock()

					EndIf

					BCA->( dbSkip() )

				EndDo

			EndIf

		EndIf

	EndIf
	//**' Fim - Marcela Coimbra - GLPI 28567 - Data: 21/06/2016'**

	//-----------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 06/01/2023
	//-----------------------------------------------------------------------------------------
	//Aten��o esta valida��o no PE PLSFTMCB e era usada somente l�, devido a alguns casos
	//o PE PLSFTMCB n�o bloquear a cobran�a essa valida��o passou a ser inseriada aqui tamb�m.
	//-----------------------------------------------------------------------------------------
	//Necess�rio refor�ar a valida��o aqui do PE PLSFTMCB
	//Pois em alguns casos estava trazendo valor para o benefici�rio, onde n�o deveria
	//Isso ocorria mesmo no PE PLSFTMCB mandando bloquear o faturamento
	//-----------------------------------------------------------------------------------------
	If u_VLDBLQFT("2")

		aRet := {}

	EndIf
	//-----------------------------------------------------------------------------------------

	//-----------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 09/02/2023
	//Valida��o para remover os lan�amentos de d�bito e cr�dito que n�o fazem parte do processo
	//Quando for mensalidade BDC_MODPAG = 1 s� podem entrar lan�amentos BSQ parametrizados para
	//mensalidade
	//Quando for coparticipa��o (custo operacional) - BDC_MODPAG = 2, s� podem entrar
	//lan�amentos BSQ que fazem parte e est�o parametrizadas como coparticipa��o
	//-----------------------------------------------------------------------------------------
	If BDC->BDC_MODPAG <> '3'
		aRet := vldBSQ(aRet)
	EndIf
	//-----------------------------------------------------------------------------------------

	RestArea(a_Area)
	RestArea(a_AreaBM1)

Return({aRet,aJaFat,aRetMov,{},aRetAcF,aRetAcu})

/*/{Protheus.doc} vldBSQ
	Valida��o para remover os lan�amentos de d�bito e cr�dito que n�o fazem parte do processo
	Quando for mensalidade BDC_MODPAG = 1 s� podem entrar lan�amentos BSQ parametrizados para
	mensalidadel.
	Quando for coparticipa��o (custo operacional) - BDC_MODPAG = 2, s� podem entrar
lan�amentos BSQ que fazem parte e est�o parametrizadas como coparticipa��o
@type function
@version  1.0
@author angelo.cassago
@since 10/02/2023
@param aParam, array, cont�m as informa�~"oes da cobran�a e os lan�amentos de BSQ que ser�o
	utilizados na cobran�a
@return variant, retorna o novo vetor onde s� ir� constar as cobran�as pertinentes
/*/
Static function vldBSQ(aParam)

	Local _aRet 	:= {}
	Local _ni		:= 0
	Local _cTip		:= IIF(BDC->BDC_MODPAG = "1","M","C")

	Default aParam 	:= {}

	For _ni := 1 to Len(aParam)

		If aParam[_ni][16] = "BSQ"

			dbSelectArea("BFQ")
			dbSetOrder(1) //BFQ_FILIAL, BFQ_CODINT, BFQ_PROPRI, BFQ_CODLAN, R_E_C_N_O_, D_E_L_E_T_
			If Dbseek(xFilial("BFQ")+BDC->BDC_CODOPE+aParam[_ni][3])

				If UPPER(ALLTRIM(BFQ->BFQ_YTPANL)) <> _cTip

					adel(aParam,_ni)
					asize(aParam,Len(aParam)-1)

					_ni--

				EndIF

			EndIf

		EndIf

		If _ni == Len(aParam)

			exit

		EndIf

	Next

	_aRet := aParam

Return _aRet
