#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSAUTF2  �Autor  �Microsiga           � Data �  09/02/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para manipular titulos a exibir no botao de���
���          �posicao financeira. Tratar titulos cancelados.              ���
�������������������������������������������������������������������������͹��
���Uso       � MP8                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PLSAUTF2

	Local lRet 		:= .T.
	//Local cSQL 	:= ""
	//Local nRegAnt := SE5->(RecNo())
	Local aArea    	:= GetArea()
	Local aArSE5   	:= SE5->(GetArea()) //Angelo Henrique - Data: 22/08/2019
	Local _cMvTp	:= GETMV("MV_XTPUSUA") //Angelo Henrique - Data: 22/08/2019

	//-----------------------------------------------------------------------
	//Angelo Henrique - Data: 28/06/2022
	//-----------------------------------------------------------------------
	//A pedido do chamado 86580 - Foi solicitado que os titulos baixados por 
	//cancelamento sejam exibidos na posi��o usu�rio.
	//-----------------------------------------------------------------------
	/*
	//���������������������������������������������������������������������Ŀ
	//� Regra: caso esteja baixado por cancelamento, nao demonstrar o titu- �
	//� lo na tela de posicao financeira.                                   �
	//�����������������������������������������������������������������������
	If !Empty(SE1->E1_BAIXA)
		
		cSQL := " SELECT MAX(R_E_C_N_O_) AS REGSE5 "
		
		//---------------------------------------------------------------
		//Angelo Henrique - Data: 05/09/2019
		//---------------------------------------------------------------
		//Corrigindo para olhar a empresa correta 
		//---------------------------------------------------------------
		//cSQL += " FROM SE5010 "
		
		cSQL += " FROM " + RetSqlName("SE5")
		
		cSQL += " WHERE E5_FILIAL = '"+xFilial("SE5")+"' "
		cSQL += " AND E5_PREFIXO = '"+SE1->E1_PREFIXO+"' "
		cSQL += " AND E5_NUMERO = '"+SE1->E1_NUM+"' "
		cSQL += " AND E5_PARCELA = '"+SE1->E1_PARCELA+"' "
		cSQL += " AND E5_TIPO = '"+SE1->E1_TIPO+"' "
		cSQL += " AND D_E_L_E_T_ = ' ' "
		PLSQuery(cSQL,"TRBTMP")
		
		If TRBTMP->REGSE5 > 0
			
			SE5->(DbGoTo(TRBTMP->REGSE5))
			If SE5->E5_MOTBX == "CAN"
				lRet := .F.
			Endif
			
			SE5->(DbGoTo(nRegAnt))
		Endif
		
		TRBTMP->(DbCloseArea())
		
	Endif
	*/
	
	//----------------------------------------------------------------------------------
	//Angelo Henrique - Data: 22/08/2019
	//Solicitado que t�tulos PR n�o sejam exibidos na tela de posi��o usu�rio.
	//----------------------------------------------------------------------------------
	If AllTrim(SE1->E1_TIPO) $ _cMvTp
		
		lRet := .F.
		
	EndIf
	
	RestArea(aArSE5	) //Angelo Henrique - Data: 22/08/2019
	RestArea(aArea	)
	
Return lRet
