#include "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS181GR  �Autor  �Renato Peixoto      � Data �  10/15/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para preencher o campo BD7_CODTPA com "H"  ���
���          �no momento da inclus�o de procedimentos na evolu��o GIH.    ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function PLS181GR()
	
	Local cChave   	:= BD6->BD6_CODOPE+BD6->BD6_CODLDP+BD6->BD6_CODPEG+BD6->BD6_NUMERO+BD6->BD6_ORIMOV
	Local aAreaBD7	:= BD7->(GetArea())
	Local _aColC	:= {} //Angelo Henrique - 02/08/2017
	Local _ni		:= 0  //Angelo Henrique - 02/08/2017
	Local _aHead	:= PARAMIXB[2]:AHEADER //Angelo Henrique - 02/08/2017
	Local _aColC	:= PARAMIXB[2]:ACOLS //Angelo Henrique - 02/08/2017
	Local _nPosSeq	:= 0 //Angelo Henrique - 02/08/2017
	Local _cChvBE4	:= "" //Angelo Henrique - 02/08/2017
	
	If AllTrim(FunName()) == "PLSA092"
		
		BD7->(DbSetOrder(1)) //BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_SEQUEN + BD7_CODUNM + BD7_NLANC
		BD7->(MsSeek(xFilial("BD7")+cChave))
		While !BD7->(Eof()) .And. cChave == BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV)
			
			If Empty(BD7->BD7_CODTPA)
				BD7->(RecLock("BD7",.F.))
				BD7->BD7_CODTPA := "H"
				BD7->(MsUnlock())
			Endif
			BD7->(DbSkip())
		EndDo
		
		//--------------------------------------------------------------------------------------------------------------------------------------------------
		//Angelo Henrique - Inicio - Data: 02/08/2017
		//--------------------------------------------------------------------------------------------------------------------------------------------------
		_aHead		:= PARAMIXB[2]:AHEADER
		_aColC		:= PARAMIXB[2]:ACOLS
		_nPosSeq	:= Ascan(_aHead,{|x| AllTrim(x[2]) == "BQV_SEQUEN" })
		_cChvBE4 	:= BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT)
		
		For _ni := 1 To Len(_aColC)
			
			DbSelectArea("BQZ")
			DbSetOrder(1) //BQZ_FILIAL + BQZ_CODOPE + BQZ_ANOINT + BQZ_MESINT + BQZ_NUMINT + BQZ_SEQUEN
			If DbSeek(xFilial("BQZ") + _cChvBE4 + _aColC[_ni][_nPosSeq])
				
				While BQZ->(!EOF()) .And. (_cChvBE4 + _aColC[_ni][_nPosSeq] == BQZ->(BQZ_CODOPE + BQZ_ANOINT + BQZ_MESINT + BQZ_NUMINT + BQZ_SEQUEN))
					
					RecLock("BQZ", .F.)
					
					BQZ->(DbDelete())
					
					BQZ->(MsUnLock())
					
					BQZ->(DbSkip())
					
				EndDo
				
			EndIf
			
		Next _ni
		//--------------------------------------------------------------------------------------------------------------------------------------------------
		//Angelo Henrique - Inicio - Data: 02/08/2017
		//--------------------------------------------------------------------------------------------------------------------------------------------------
		
	EndIf
	
	//-----------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 18/10/2017
	//Criando aqui valida��o para quando a rotina padr�o n�o criar os itens eda auditoria
	//-----------------------------------------------------------------------------------------------
	
	u_CB181AUD()
	
	//-----------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 03/10/2017
	//--------------------------------------------------------------------------------------------------------
	//Chamada para a valida��o do projeto de psiquiatria.
	//--------------------------------------------------------------------------------------------------------
	/*If BE4->BE4_GRPINT = "5" //Interna��o Psiquiatrica
		
		u_CABA601("2")
		
	EndIf*/
	//--------------------------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 03/10/2017
	//--------------------------------------------------------------------------------------------------------
	
	
	RestArea(aAreaBD7)
	
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CB181AUD  �Autor  �Angelo Henrique     � Data �  19/10/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para varrer todos os itens da Interna��o e ���
���          �Prorroga��o para validar se existem itens passiveis de      ���
���          �auditoria e validar se foi criado o cabe�alho desta guia.   ���
���          �Os itens  s�o criados no ponto de entrada: PLSAUDBT.PRW.    ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CB181AUD()
	
	Local _aArea	:= GetArea()
	Local _aArB53	:= B53->(GetArea())
	Local _aArBE4	:= BR4->(GetArea())
	Local _aArBEJ	:= BEJ->(GetArea())
	Local _aArBQV	:= BQV->(GetArea())
	Local _aArBAU	:= BAU->(GetArea())
	Local _lAudit	:= .F.
	
	//---------------------------------------------------------------
	//Varrer os itens da interna��o (BEJ)
	//---------------------------------------------------------------
	DbSelectArea("BEJ")
	DbSetOrder(1) //BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT+BEJ_SEQUEN
	If DbSeek(xFilial("BEJ") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) )
		
		While !(BEJ->(EOF())) .And. BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == BEJ->(BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT)
			
			If BEJ->BEJ_STATUS = "0" //N�o Autorizado
				
				_lAudit := .T.
				
				Exit
				
			EndIf
			
			BEJ->(DbSkip())
			
		EndDo
		
	EndIf
	
	//---------------------------------------------------------------
	//Varrer os itens da prorroga��o (BQV)
	//---------------------------------------------------------------
	//Caso n�o ache nenhum item de auditoria na BEJ que ir� varrer
	//a BQV, pois em qualuqer uma das situa��es eu irei validar
	//se criou ou n�o a B53(Auditoria), caso n�o a mesma ser� criada
	//---------------------------------------------------------------
	If !_lAudit
		
		DbSelectArea("BQV")
		DbSetOrder(1) //BQV_FILIAL+BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT+BQV_SEQUEN
		If DbSeek(xFilial("BQV") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) )
			
			While !(EOF()) .And. BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == BQV->(BQV_CODOPE + BQV_ANOINT + BQV_MESINT + BQV_NUMINT)
				
				If BQV->BQV_STATUS = "0"
					
					_lAudit := .T.
					
					Exit
					
				EndIf
				
				BQV->(DbSkip())
				
			EndDo
			
		EndIf
		
		
	EndIf
	
	//-----------------------------------------------------------------------------
	//Se achou algum item passivel de auditoria verifico se existe a B53
	//-----------------------------------------------------------------------------
	If _lAudit
		
		DbSelectArea("B53")
		DbSetOrder(1) //B53_FILIAL + B53_NUMGUI + B53_ORIMOV
		If !(DbSeek(xFilial("B53") + BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)))
			
			RecLock("B53", .T.)
			
			B53->B53_FILIAL	:= xFilial("B53")
			B53->B53_DATMOV	:= dDataBase
			B53->B53_MATUSU	:= BE4->(BE4_CODOPE + BE4_CODEMP + BE4_MATRIC + BE4_TIPREG + BE4_DIGITO)
			B53->B53_NOMUSR	:= BE4->BE4_NOMUSR
			B53->B53_CODRDA	:= BE4->BE4_CODRDA
			B53->B53_PERAUD	:= "1;"//No padr�o � inclu�do desta forma
			B53->B53_PRIORI	:= "0" //No padr�o � inclu�do desta forma
			B53->B53_NUMGUI	:= BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
			B53->B53_ORIMOV	:= BE4->BE4_ORIMOV
			B53->B53_CODOPE	:= BE4->BE4_CODOPE
			B53->B53_CODLDP	:= BE4->BE4_CODLDP
			B53->B53_CODPEG	:= BE4->BE4_CODPEG
			B53->B53_NUMERO	:= BE4->BE4_NUMERO
			B53->B53_ALIMOV	:= "BE4"
			B53->B53_RECMOV	:= cValToChar(BE4->(RECNO()))
			B53->B53_STATUS	:= "3" //N�O AUTORIZADA
			B53->B53_SITUAC	:= "0" //N�O
			B53->B53_OPERAD	:= "0" //N�O
			B53->B53_DEMAND	:= "0" //N�O
			B53->B53_PARTIC	:= "0" //N�O
			B53->B53_AGEPAR	:= "0" //N�O
			B53->B53_ENCAMI	:= "0" //N�O
			B53->B53_BANCON	:= "0" //N�O
			B53->B53_TIPO	:= "3" //INTERNA��O
			B53->B53_PROINT	:= "0"
			B53->B53_HORMOV	:= BE4->BE4_HHDIGI
			B53->B53_CARINT	:= IIF(BE4->BE4_TIPADM $ "4|5", "U","E")
			B53->B53_REGINT	:= BE4->BE4_REGINT
			B53->B53_CODMUN	:= POSICIONE("BAU",1,xFilial("BAU")+BE4->BE4_CODRDA,"BAU_MUN")
			
			B53->(MsUnlock())
			
		Else
			
			RecLock("B53", .F.)
					
			B53->B53_STATUS	:= "3" //N�O AUTORIZADA			
			
			B53->(MsUnlock())
			
		EndIf
		
	EndIf
	
	RestArea(_aArBAU)
	RestArea(_aArBEJ)
	RestArea(_aArBQV)
	RestArea(_aArBE4)
	RestArea(_aArB53)
	RestArea(_aArea	)
	
Return