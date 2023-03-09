#INCLUDE "PlsR580.ch"
#include "PROTHEUS.CH"
#include "PLSMGER.CH"

#DEFINE RESETLIN nLinha := 550
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Funcao    � PLSBOL  � Autor � Jean Schulz            � Data � 27.10.07  ���
��������������������������������������������������������������������������Ĵ��
���Descricao � Impressao do boleto a partir do botao posicao usuario.	   ���
��������������������������������������������������������������������������Ĵ��
��� Uso      � Advanced Protheus                                           ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
/*/
//��������������������������������������������������������������������������Ŀ
//� Define nome da funcao                                                    �
//����������������������������������������������������������������������������
// Altera��es:
//
//		Incluida valida��o para gera��o de CNAB para Ita� e Bradesco  - Rafael Fernandes 15/10/13
//
//����������������������������������������������������������������������������

User Function PLSBOL(cmv_par01, cmv_par02, cmv_par03, cmv_par04, cmv_par05, cmv_par06,;
		cmv_par07, cmv_par08, cmv_par09, cmv_par10, cmv_par11, cmv_par12,;
		cmv_par13, cmv_par14, cmv_par15, cmv_par16, cmv_par17, cmv_par18,;
		cmv_par19, cmv_par20 )

	Local nRegSE1	:= paramixb[1]
	//Local aArray	:= paramixb[2]
	Local nPosBRW	:= 0
	Local cSQL 		:= ""
	Local _nPosCob	:= "" //Angelo Henrique - Data:06/08/2019
	Local _nPosPrf	:= "" //Angelo Henrique - Data:06/08/2019
	Local _nPosNum	:= "" //Angelo Henrique - Data:06/08/2019

	Private cGEFIN	:= GetNewPar("MV_YBOLFIN","001263")
	Private _cObj := ""

	Do Case
	Case oFolder:nOption == 1
		_cObj := "oBrwFin"
		nPosBRW := oBrwFin:oBrowse:NAT
	Case oFolder:nOption == 2
		_cObj := "oBrwFinB"
		nPosBRW := oBrwFinB:oBrowse:NAT
	OtherWise
		_cObj := "oBrwFinT"
		nPosBrw := oBrwFinT:oBrowse:NAT
	EndCase

	nPosBrw := &(_cObj):oBrowse:NAT

	//------------------------------------------------
	//Angelo Henrique - Data: 06/08/2019
	//------------------------------------------------
	_nPosPrf	:= aScan( &(_cObj):AHEADER, { |x| AllTrim(x[2]) == "E1_PREFIXO" })
	_nPosNum	:= aScan( &(_cObj):AHEADER, { |x| AllTrim(x[2]) == "E1_NUM"		})
	_nPosCob	:= aScan( &(_cObj):AHEADER, { |x| AllTrim(x[2]) == "E1_PLNUCOB" })
	//------------------------------------------------

	cSQL := " SELECT E1_TIPO, R_E_C_N_O_ REGIMP , E1_PORTADO, E1_YTPEXP, E1_IDCNAB , E1_NUMBOR, E1_FORMREC, E1_VENCREA FROM "+RetSQLName("SE1")+" SE1 "
	cSQL += " WHERE E1_FILIAL = '"+xFilial("SE1")+"' "

	//---------------------------------------------------------------------
	//Angelo Henrique - Data:06/08/2019
	//---------------------------------------------------------------------
	//Removendo as posi��es fixas, liberando assim a possibilidade
	//do usu�rio poder visualizar mais informa��es no acols
	//---------------------------------------------------------------------
	//cSQL += " AND E1_PREFIXO = '"+&(_cObj):acols[nposbrw,1]+"' "
	//cSQL += " AND E1_NUM = '"+&(_cObj):acols[nposbrw,2]+"' "
	//cSQL += " AND E1_PLNUCOB = '"+&(_cObj):acols[nposbrw,11]+"' "

	cSQL += " AND E1_PREFIXO = '"	+ &(_cObj):acols[nposbrw,_nPosPrf] + "' "
	cSQL += " AND E1_NUM = '"		+ &(_cObj):acols[nposbrw,_nPosNum] + "' "
	cSQL += " AND E1_PLNUCOB = '"	+ &(_cObj):acols[nposbrw,_nPosCob] + "' "
	//---------------------------------------------------------------------

	cSQL += " AND SE1.D_E_L_E_T_ = ' ' "

	PLSQuery(cSQL,"TRBTMP")

	If TRBTMP->REGIMP > 0
		nRegSE1 := TRBTMP->REGIMP

		//Incluido por Rafael Fernandes  - 15/10/13
		// valida��o para gera��o de CNAB para Ita� e Bradesco
		If alltrim(TRBTMP->E1_PORTADO) == '341'


			If TRBTMP->E1_FORMREC == '06' .AND.  TRBTMP->E1_VENCREA  >= DATE()

				Aviso( "D�bito autom�tico","Esse t�tulo foi enviado para cobran�a em d�bito autom�tico e o boleto n�o pode ser impresso.", {"Ok"} )

			Else

				Aviso( "D�bito autom�tico","Forma de pagamento inv�lida, o boleto n�o pode ser impresso.", {"Ok"} )


			EndIf

		ElseIf Alltrim(TRBTMP->E1_PORTADO) == '237'


			If TRBTMP->E1_FORMREC == '06' .AND.  TRBTMP->E1_VENCREA  >= DATE()

				Aviso( "D�bito autom�tico","Esse t�tulo foi enviado para cobran�a em d�bito autom�tico e seu boleto n�o pode ser impresso.", {"Ok"} )

			ElseIf TRBTMP->E1_FORMREC == '06' .AND.  TRBTMP->E1_VENCREA  < DATE()

				Aviso( "D�bito autom�tico","Esse t�tulo foi enviado para cobran�a em d�bito autom�tico por�m encontra-se vencido, o mesmo precisa ser transferido para cobran�a simples.", {"Ok"} )

			ElseIf ( TRBTMP->E1_YTPEXP $ 'L||D' /*.OR. ( cEmpAnt == '02' .AND. TRBTMP->E1_NUMBOR <> ' ')*/ ) .AND. ALLTRIM(TRBTMP->E1_TIPO) == 'DP'

				//-------------------------------------------------------------------
				//Angelo Henrique - Data: 11/03/2021
				//comentado a valida��o para integral , pois conforme solicitado
				//deve respeitar a regra da caberj com registro banc�rio
				//-------------------------------------------------------------------

				U_BOL_integral(nRegSE1)

			ElseIf ( TRBTMP->E1_YTPEXP $ 'L||D' /*.OR. ( cEmpAnt == '02' .AND. TRBTMP->E1_NUMBOR <> ' ')*/ ) .AND. ALLTRIM(TRBTMP->E1_TIPO) == 'FT'

				//-------------------------------------------------------------------
				//Angelo Henrique - Data: 11/03/2021
				//comentado a valida��o para integral , pois conforme solicitado
				//deve respeitar a regra da caberj com registro banc�rio
				//-------------------------------------------------------------------

				dbSelectArea("SE1")
				dbGoTo( nRegSE1 )

				If (RetCodUsr() $ (cGEFIN + SuperGetMv('MV_XGETIN') + '|' + SuperGetMv('MV_XGERIN')))

					U_FatBra(.F.)

				Else

					If MsgYesNo("Deseja enviar por e-mail?")

						U_FatBra(.F.)

					Else

						U_FatLGPD(.F.)

					EndIf

				EndIf

			ElseIf TRBTMP->E1_YTPEXP = 'H' //Op��o de Cancelamento feito manualmente no banco - Angelo Henrique - Data: 26/08/2020

				Aviso( "T�tulo com retorno cancelado no banco!", "O titulo cancelado no banco pela Operadora.", {"Ok"} )

			ElseIf TRBTMP->E1_IDCNAB <> ' '

				Aviso( "T�tulo n�o registrado no banco!", "Ainda n�o foi processada a confirma��o de registro do boleto no banco.", {"Ok"} )

			Else

				Aviso( "T�tulo n�o enviado ao banco!", "O titulo ainda n�o foi enviado para registro no banco.", {"Ok"} )

			EndIf

		EndIf


	Endif

	TRBTMP->(DbCloseArea())

Return
