#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI005     ºAutor  ³Angelo Henrique   º Data ³  16/03/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inicializador padrão criado para mostrar o status da ANS.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function CABI005(_cParam)
	
	Local _aArea 	:= GetArea()
	Local _aArE4 	:= BE4->(GetArea())
	Local _cRet		:= ""
	
	Default _cParam = "1"
	
	/*	--------------------------------------------------------------------------------------------------------------
	||1 - AUTORIZADO   										|| BE4_STATUS - 1 = Autorizada
	||2 - EM ANALISE   										|| BE4_YSOPME $ (1|2|3)
	||3 - NEGADO 											|| BE4_STATUS = 3 .AND. BE4_CANCEL <> 1
	||4 - AGUARDANDO JUSTIFICATIVA TECNICA DO SOLICITANTE  	|| Não vai disponibilizar
	||5 - AGUARDANDO DOCUMENTACAO DO PRESTADOR  			|| BE4_YSOPME = 4	= EXIG. AUD.
	||6 - SOLICITACAO CANCELADA  							|| BE4_CANCEL = 1 .And. BE4_STATUS = 3 = Nao Autorizada
	||7 - AUTORIZADO PARCIALMENTE   						|| BE4_STATUS = 2 = Autorizada Parcialmente
	||	--------------------------------------------------------------------------------------------------------------*/
	
	If BE4->BE4_FASE == "1" .AND. Empty(AllTrim(BE4->BE4_GUIINT))
		
		If BE4->BE4_STATUS = "1" .AND. (!(EMPTY(BE4->BE4_SENHA)) .OR. !(EMPTY(BE4->BE4_XDTLIB))) .AND. BE4->BE4_SITUAC = "1"
			
			If _cParam = "1"
				
				_cRet := "1" //AUTORIZADO
				
			Else
				
				_cRet := "AUTORIZADO"
				
			Endif
			
		ElseIf (BE4->BE4_STATUS == "3" .AND. BE4->BE4_CANCEL <> "1" .AND. BE4->BE4_SITUAC $ "1|3");
				.OR. (BE4->BE4_STATUS == "3" .And. !(ALLTRIM(BE4->BE4_TIPADM) $ "4|5" ) .AND. ;
				BE4->BE4_SITUAC == "3" .AND. BE4->BE4_CANCEL <> "1")
			
			If _cParam = "1"
				
				_cRet := "3" //NEGADO
				
			Else
				
				_cRet := "NEGADO"
				
			Endif
			
		ElseIf (BE4->BE4_CANCEL == "1" .AND. BE4->BE4_STATUS == "3");
				.OR. (BE4->BE4_SITUAC = "2" .AND. BE4->BE4_STATUS = "1" .AND. ;
				EMPTY(ALLTRIM(BE4->BE4_YSOPME)) .AND. EMPTY(ALLTRIM(BE4->BE4_CANCEL)));
				.OR. BE4->BE4_SITUAC = "3" .OR. (BE4->BE4_SITUAC = "2" .And. BE4->BE4_YSOPME = "B")			
			
			If _cParam = "1"
				
				_cRet := "6" //SOLICITAÇÃO CANCELADA
				
			Else
				
				_cRet := "SOLICITAÇÃO CANCELADA"
				
			Endif
						
				ElseIf (BE4->BE4_YSOPME $ ('1|2|3|5|6|7|8|9|A');
				.AND. (EMPTY(BE4->BE4_SENHA) .OR. (ALLTRIM(BE4->BE4_TIPADM) $ "4|5" .AND. !(EMPTY(BE4->BE4_SENHA)))));
				.OR. (BE4->BE4_SITUAC = "1" .AND. BE4->BE4_STATUS = "1" .AND. EMPTY(ALLTRIM(BE4->BE4_CANCEL));
				.AND. EMPTY(ALLTRIM(BE4->BE4_YSOPME)));
				.OR. (BE4->BE4_SITUAC = "1" .And. BE4->BE4_STATUS = "1" .And. BE4->BE4_YSOPME = "B" .And. Empty(BE4->BE4_SENHA));
				.OR. U_CABI05A()			
			
			If _cParam = "1"
				
				_cRet := "2" //EM ANALISE
				
			Else
				
				_cRet := "EM ANALISE"
				
			Endif
			
		ElseIf BE4->BE4_YSOPME == "4" .AND. EMPTY(BE4->BE4_SENHA)
			
			If _cParam = "1"
				
				_cRet := "5" //AGUARDANDO DOCUMENTAÇÃO DO PRESTADOR
				
			Else
				
				_cRet := "AGUARDANDO DOCUMENTAÇÃO DO PRESTADOR"
				
			Endif
						
		ElseIf BE4->BE4_STATUS = "2" .OR. (BE4->BE4_SITUAC = "1" .And. BE4->BE4_STATUS = "2" .And. BE4->BE4_YSOPME = "B")
			
			If _cParam = "1"
				
				_cRet := "7" //AUTORIZADO PARCIALMENTE
				
			Else
				
				_cRet := "AUTORIZADO PARCIALMENTE"
				
			Endif
			
		EndIf
		
	EndIf
	
	RestArea(_aArE4)
	RestArea(_aArea)
	
return _cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABI05A     ºAutor  ³Angelo Henrique   º Data ³  21/09/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação efetuada para saber se a internação não teve      º±±
±±º          ³todos os itens analisados pela auditoria.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABI05A()
	
	Local _aArea 	:= GetArea()
	Local _aArB53 	:= B53->(GetArea())
	Local _aArBEL 	:= BEL->(GetArea())
	Local _lRet		:= .F.
	
	DbSelectArea("B53")
	DbSetOrder(1) //B53_FILIAL + B53_NUMGUI + B53_ORIMOV
	If DbSeek(xFilial("B53") + BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT))
		
		DbSelectArea("B72")
		DbSetOrder(1)
		If MsSeek(xFilial("B72")+B53->(B53_ALIMOV+B53_RECMOV) )
			
			While !B72->(Eof()) .And. B53->(B53_ALIMOV+B53_RECMOV) == B72->(B72_ALIMOV+B72_RECMOV) .And. !_lRet
				
				If B72->B72_PARECE == '2'
					
					DbSelectArea("BEL")
					DbSetOrder(1) //BEL_FILIAL + BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT + BEL_SEQUEN
					If DbSeek(xFilial("BEL") + B53->B53_NUMGUI)
						
						While BEL->(!EOF()) .And. B53->B53_NUMGUI ==  BEL->(BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT)
							
							//-----------------------------------------------------------------
							//Varrer se algum item não foi analisado, para não colocar a
							//informação errada no campo do STATUS ANS
							//-----------------------------------------------------------------
							If AllTrim(BEL->BEL_PENDEN) == "0"
								
								_lRet := .T.
								Exit //Se tiver algum item em analise não precisa varrer o resto
								
							EndIf
							
							BEL->(DbSkip())
							
						EndDo
						
					EndIf
					
				EndIf
				
				B72->(DbSkip())
				
			EndDo
			
		EndIf
		
	EndIf
	
	RestArea(_aArBEL)
	RestArea(_aArB53)
	RestArea(_aArea )
	
Return _lRet