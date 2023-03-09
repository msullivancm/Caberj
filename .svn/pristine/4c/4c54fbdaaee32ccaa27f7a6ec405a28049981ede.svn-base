#include "PROTHEUS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS181GR  ºAutor  ³Renato Peixoto      º Data ³  10/15/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para preencher o campo BD7_CODTPA com "H"  º±±
±±º          ³no momento da inclusão de procedimentos na evolução GIH.    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
	//Criando aqui validação para quando a rotina padrão não criar os itens eda auditoria
	//-----------------------------------------------------------------------------------------------
	
	u_CB181AUD()
	
	//-----------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 03/10/2017
	//--------------------------------------------------------------------------------------------------------
	//Chamada para a validação do projeto de psiquiatria.
	//--------------------------------------------------------------------------------------------------------
	/*If BE4->BE4_GRPINT = "5" //Internação Psiquiatrica
		
		u_CABA601("2")
		
	EndIf*/
	//--------------------------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 03/10/2017
	//--------------------------------------------------------------------------------------------------------
	
	
	RestArea(aAreaBD7)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CB181AUD  ºAutor  ³Angelo Henrique     º Data ³  19/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para varrer todos os itens da Internação e º±±
±±º          ³Prorrogação para validar se existem itens passiveis de      º±±
±±º          ³auditoria e validar se foi criado o cabeçalho desta guia.   º±±
±±º          ³Os itens  são criados no ponto de entrada: PLSAUDBT.PRW.    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
	//Varrer os itens da internação (BEJ)
	//---------------------------------------------------------------
	DbSelectArea("BEJ")
	DbSetOrder(1) //BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT+BEJ_SEQUEN
	If DbSeek(xFilial("BEJ") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) )
		
		While !(BEJ->(EOF())) .And. BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == BEJ->(BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT)
			
			If BEJ->BEJ_STATUS = "0" //Não Autorizado
				
				_lAudit := .T.
				
				Exit
				
			EndIf
			
			BEJ->(DbSkip())
			
		EndDo
		
	EndIf
	
	//---------------------------------------------------------------
	//Varrer os itens da prorrogação (BQV)
	//---------------------------------------------------------------
	//Caso não ache nenhum item de auditoria na BEJ que irá varrer
	//a BQV, pois em qualuqer uma das situações eu irei validar
	//se criou ou não a B53(Auditoria), caso não a mesma será criada
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
			B53->B53_PERAUD	:= "1;"//No padrão é incluído desta forma
			B53->B53_PRIORI	:= "0" //No padrão é incluído desta forma
			B53->B53_NUMGUI	:= BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
			B53->B53_ORIMOV	:= BE4->BE4_ORIMOV
			B53->B53_CODOPE	:= BE4->BE4_CODOPE
			B53->B53_CODLDP	:= BE4->BE4_CODLDP
			B53->B53_CODPEG	:= BE4->BE4_CODPEG
			B53->B53_NUMERO	:= BE4->BE4_NUMERO
			B53->B53_ALIMOV	:= "BE4"
			B53->B53_RECMOV	:= cValToChar(BE4->(RECNO()))
			B53->B53_STATUS	:= "3" //NÃO AUTORIZADA
			B53->B53_SITUAC	:= "0" //NÃO
			B53->B53_OPERAD	:= "0" //NÃO
			B53->B53_DEMAND	:= "0" //NÃO
			B53->B53_PARTIC	:= "0" //NÃO
			B53->B53_AGEPAR	:= "0" //NÃO
			B53->B53_ENCAMI	:= "0" //NÃO
			B53->B53_BANCON	:= "0" //NÃO
			B53->B53_TIPO	:= "3" //INTERNAÇÃO
			B53->B53_PROINT	:= "0"
			B53->B53_HORMOV	:= BE4->BE4_HHDIGI
			B53->B53_CARINT	:= IIF(BE4->BE4_TIPADM $ "4|5", "U","E")
			B53->B53_REGINT	:= BE4->BE4_REGINT
			B53->B53_CODMUN	:= POSICIONE("BAU",1,xFilial("BAU")+BE4->BE4_CODRDA,"BAU_MUN")
			
			B53->(MsUnlock())
			
		Else
			
			RecLock("B53", .F.)
					
			B53->B53_STATUS	:= "3" //NÃO AUTORIZADA			
			
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