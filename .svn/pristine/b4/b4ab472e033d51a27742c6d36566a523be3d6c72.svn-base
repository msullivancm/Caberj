#INCLUDE 'RWMAKE.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA601   ºAutor  ³Angelo Henrique     º Data ³  03/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para gravar as internações de psiquiatria.º±±
±±º          ³ Projeto  de Coparticipação de Psiquiatria.                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA601(_cParam)
	
	Local _aArea 	:= GetArea()
	Local _aArBEJ 	:= BEJ->(GetArea())
	Local _aArBQV 	:= BQV->(GetArea())
	Local _aArBR8 	:= BR8->(GetArea())
	Local _lFound	:= .F.
	
	Default _cParam := "1" //Parametro para saber se vem da Internação ou da Prorrogação.
	
	If _cParam = "1" //Internação
		
		//-----------------------------------------------------------------------------------------------
		//Varrendo os itens no momento da internação
		//-----------------------------------------------------------------------------------------------
		DbSelectArea("BEJ")
		DBSetOrder(1) //BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT+BEJ_SEQUEN
		If DbSeek(xFilial("BEJ") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT))
			
			While BEJ->(!EOF()) .And. BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == BEJ->(BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT)
				
				//validar se é diária
				DbSelecTArea("BR8")
				DbSetOrder(1) //BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
				If DbSeek(xFilial("BR8") + BEJ->BEJ_CODPAD + BEJ->BEJ_CODPRO)
					
					//------------------------------------------------------------------------
					//Colocar aqui o tipo de diária e validar se é diária de psiquiatria
					//------------------------------------------------------------------------
					If BR8->BR8_TIPDIA == "9"
						
						DbSelectArea("PBZ")
						DbSetOrder(2) //PBZ_FILIAL+PBZ_CODOPE+PBZ_ANOINT+PBZ_MESINT+PBZ_NUMINT+PBZ_SEQUEN
						_lFound := DbSeek(xFilial("PBZ") + BEJ->(BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT + BEJ_SEQUEN) + "BEJ")
						
						RecLock("PBZ", !_lFound)
						
						//------------------------------------------------
						//Link da PBZ com a BE4
						//------------------------------------------------
						PBZ->PBZ_FILIAL := BE4->BE4_FILIAL
						PBZ->PBZ_CODOPE := BE4->BE4_CODOPE
						PBZ->PBZ_ANOINT := BE4->BE4_ANOINT
						PBZ->PBZ_MESINT := BE4->BE4_MESINT
						PBZ->PBZ_NUMINT := BE4->BE4_NUMINT
						PBZ->PBZ_SENHA 	:= BE4->BE4_SENHA
						
						//------------------------------------------------
						//Link da PBZ com a BA1
						//------------------------------------------------
						PBZ->PBZ_CODEMP := BE4->BE4_CODEMP
						PBZ->PBZ_MATRIC := BE4->BE4_MATRIC
						PBZ->PBZ_TIPREG := BE4->BE4_TIPREG
						PBZ->PBZ_DIGITO := BE4->BE4_DIGITO
						PBZ->PBZ_MATVID := BE4->BE4_MATVID
						
						//------------------------------------------------
						//Para calcular a quantidade
						//------------------------------------------------
						PBZ->PBZ_ALIAS 	:= "BEJ"
						PBZ->PBZ_QTDPRO := BEJ->BEJ_QTDPRO
						PBZ->PBZ_DATPRO := BEJ->BEJ_DATPRO
						PBZ->PBZ_SEQUEN := BEJ->BEJ_SEQUEN
						
						//------------------------------------------------
						//Se a internação foi cancelado 1 = Sim e 2 = Não
						//------------------------------------------------
						PBZ->PBZ_CANCEL := "2"
						
						PBZ->(MsUnLock())
						
					EndIf
					
				EndIf
				
				BEJ->(DbSkip())
				
			EndDo
			
		EndIf
		
	ElseIf _cParam = "2" //Prorrogação
		
		//-----------------------------------------------------------------------------------------------
		//Na prorrogação existe a possibilidade de excluir os itens ao clicar em delete
		//Logo, antes de atualizar os itens é necessário varrer e conferir cada item,
		//para saber se o mesmo não foi excluído
		//-----------------------------------------------------------------------------------------------		
		DbSelectArea("PBZ")
		DBSetOrder(1) //PBZ_FILIAL+PBZ_CODOPE+PBZ_ANOINT+PBZ_MESINT+PBZ_NUMINT+PBZ_ALIAS
		If DbSeek(xFilial("PBZ") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) + "BQV")
			
			While !EOF() .And. BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == PBZ->(PBZ_CODOPE+PBZ_ANOINT+PBZ_MESINT+PBZ_NUMINT)
				
				If PBZ->PBZ_ALIAS = "BQV"
					
					DbSelectArea("BQV")
					DBSetOrder(1) //BQV_FILIAL+BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT+BQV_SEQUEN
					If !(DbSeek(xFilial("BQV") + PBZ->(PBZ_CODOPE+PBZ_ANOINT+PBZ_MESINT+PBZ_NUMINT+PBZ_SEQUEN)))
						
						RecLock("PBZ",.F.)
						
						DbDelete()
						
						MsUnLock()
						
					EndIf
					
				EndIf
				
				PBZ->(DbSkip())
				
			EndDo
			
		EndIf
						
		//-----------------------------------------------------------------------------------------------
		//Varrendo os itens no momento da internação
		//-----------------------------------------------------------------------------------------------
		DbSelectArea("BQV")
		DBSetOrder(1) //BQV_FILIAL+BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT+BQV_SEQUEN
		If DbSeek(xFilial("BQV") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT))
			
			While BQV->(!EOF()) .And.  BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == BQV->(BQV_CODOPE + BQV_ANOINT + BQV_MESINT + BQV_NUMINT)
				
				DbSelecTArea("BR8")
				DbSetOrder(1) //BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
				If DbSeek(xFilial("BR8") + BEJ->BEJ_CODPAD + BEJ->BEJ_CODPRO)
					
					//------------------------------------------------------------------------
					//Colocar aqui o tipo de diária e validar se é diária de psiquiatria
					//------------------------------------------------------------------------
					If BR8->BR8_TIPDIA == "9" //TABELA SX5 - B5
						
						DbSelectArea("PBZ")
						DbSetOrder(2) //PBZ_FILIAL+PBZ_CODOPE+PBZ_ANOINT+PBZ_MESINT+PBZ_NUMINT+PBZ_SEQUEN
						_lFound := DbSeek(xFilial("PBZ") + BQV->(BQV_CODOPE + BQV_ANOINT + BQV_MESINT + BQV_NUMINT + BQV_SEQUEN) + "BQV")
						
						RecLock("PBZ", !_lFound)
						
						//------------------------------------------------
						//Link da PBZ com a BE4
						//------------------------------------------------
						PBZ->PBZ_FILIAL := BE4->BE4_FILIAL
						PBZ->PBZ_CODOPE := BE4->BE4_CODOPE
						PBZ->PBZ_ANOINT := BE4->BE4_ANOINT
						PBZ->PBZ_MESINT := BE4->BE4_MESINT
						PBZ->PBZ_NUMINT := BE4->BE4_NUMINT
						PBZ->PBZ_SENHA 	:= BE4->BE4_SENHA
						
						//------------------------------------------------
						//Link da PBZ com a BA1
						//------------------------------------------------
						PBZ->PBZ_CODEMP := BE4->BE4_CODEMP
						PBZ->PBZ_MATRIC := BE4->BE4_MATRIC
						PBZ->PBZ_TIPREG := BE4->BE4_TIPREG
						PBZ->PBZ_DIGITO := BE4->BE4_DIGITO
						PBZ->PBZ_MATVID := BE4->BE4_MATVID
						
						//------------------------------------------------
						//Para calcular a quantidade
						//------------------------------------------------
						PBZ->PBZ_ALIAS 	:= "BQV"
						PBZ->PBZ_QTDPRO := BQV->BQV_QTDPRO
						PBZ->PBZ_DATPRO := BQV->BQV_DATPRO
						PBZ->PBZ_SEQUEN := BQV->BQV_SEQUEN
						
						//------------------------------------------------
						//Se a internação foi cancelado 1 = Sim e 2 = Não
						//------------------------------------------------
						PBZ->PBZ_CANCEL := "2"
						
						PBZ->(MsUnLock())
						
					EndIf
					
				EndIf
				
				BQV->(DbSkip())
				
			EndDo
			
		EndIf
		
	EndIf
	
	RestArea(_aArBR8)
	RestArea(_aArBQV)
	RestArea(_aArBEJ)
	RestArea(_aArea	)
	
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA601A  ºAutor  ³Angelo Henrique     º Data ³  06/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para calcular a quantidade de diárias casoº±±
±±º          ³ o mesmo já tenha passado será alertado na tela.            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA601A(_cParam)
	
	Local _aArea		:= GetArea()
	Local _aArPBZ		:= PBZ->(GetArea())
	Local _aArBEJ		:= BEJ->(GetArea())
	Local _aArBQV		:= BQV->(GetArea())
	Local _aArBE4		:= BE4->(GetArea())
	Local _cAlias		:= GetNextAlias()
	Local _cQuery		:= ""
	Local _lRet			:= .T.
	Local _cMsg			:= ""
	Local _lAchou		:= .F.
	Local _nDiaria		:= 0
	
	Default _cParam		:= "1" //1 = internação || 2 = prorrogação
	
	If _cParam == "1"
		
		_nDiaria := M->BEJ_QTDPRO
		
	Else
		
		_nDiaria := M->BQV_QTDPRO
		
	EndIf
	
	//------------------------------------------------------------------------------------------------
	//Validar se esta prorrogando uma senha que antes não iria ser coparticipada
	//Pois quando é internação não foi gerado o número ainda, porém na prorrogação ele acha
	//------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------
	//Validação para saber se a guia será ou não coparticipada
	//------------------------------------------------------------------------------------------------
	_cQuery	:= " SELECT 																			" + cEnt
	_cQuery	+= " 	PBZ_1.PBZ_CODOPE||PBZ_1.PBZ_ANOINT||PBZ_1.PBZ_MESINT||PBZ_1.PBZ_NUMINT  GUIAS,	" + cEnt
	_cQuery	+= " 	(																				" + cEnt
	_cQuery	+= " 		SELECT																		" + cEnt
	_cQuery	+= " 			SUM(PBZ_2.PBZ_QTDPRO) TOTAL 											" + cEnt
	_cQuery	+= " 		FROM																		" + cEnt
	_cQuery	+= " 			" + RetSqlName("PBZ") + " PBZ_2											" + cEnt
	_cQuery	+= " 		WHERE																		" + cEnt
	_cQuery	+= " 			PBZ_2.D_E_L_E_T_ = ' '													" + cEnt
	_cQuery	+= " 			AND PBZ_2.PBZ_FILIAL = '" + xFilial("BE4") + "'							" + cEnt
	_cQuery	+= " 			AND PBZ_2.PBZ_CODOPE = '" + SUBSTR(M->BE4_USUARI,1,4 ) + "' 			" + cEnt
	_cQuery	+= " 			AND PBZ_2.PBZ_CODEMP = '" + SUBSTR(M->BE4_USUARI,5,4 ) + "' 			" + cEnt
	_cQuery	+= " 			AND PBZ_2.PBZ_MATRIC = '" + SUBSTR(M->BE4_USUARI,9,6 ) + "' 			" + cEnt
	_cQuery	+= " 			AND PBZ_2.PBZ_TIPREG = '" + SUBSTR(M->BE4_USUARI,15,2) + "' 			" + cEnt
	_cQuery	+= " 			AND PBZ_2.PBZ_DIGITO = '" + SUBSTR(M->BE4_USUARI,17,1) + "' 			" + cEnt
	_cQuery	+= " 			AND PBZ_2.PBZ_CANCEL = '2'							 					" + cEnt
	_cQuery	+= " 	) TOTAL																			" + cEnt
	_cQuery	+= " FROM 																				" + cEnt
	_cQuery	+= " 	" + RetSqlName("PBZ") + " PBZ_1													" + cEnt
	_cQuery	+= " WHERE 																				" + cEnt
	_cQuery	+= " 	PBZ_1.D_E_L_E_T_ = ' ' 															" + cEnt
	_cQuery	+= " 	AND PBZ_1.PBZ_FILIAL = '" + xFilial("BE4")  + "' 								" + cEnt
	_cQuery	+= " 	AND PBZ_1.PBZ_CODOPE = '" + SUBSTR(M->BE4_USUARI,1,4 ) + "' 					" + cEnt
	_cQuery	+= " 	AND PBZ_1.PBZ_CODEMP = '" + SUBSTR(M->BE4_USUARI,5,4 ) + "' 					" + cEnt
	_cQuery	+= " 	AND PBZ_1.PBZ_MATRIC = '" + SUBSTR(M->BE4_USUARI,9,6 ) + "' 					" + cEnt
	_cQuery	+= " 	AND PBZ_1.PBZ_TIPREG = '" + SUBSTR(M->BE4_USUARI,15,2) + "' 					" + cEnt
	_cQuery	+= " 	AND PBZ_1.PBZ_DIGITO = '" + SUBSTR(M->BE4_USUARI,17,1) + "' 					" + cEnt
	_cQuery	+= " 	AND PBZ_1.PBZ_CANCEL = '2'									 					" + cEnt
	/*
	Colocar aqui as questões de data para saber se esta dentro do processo
	de aniversário
	*/
	
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias)
	
	If !(_cAlias)->(EOF())
		
		If !(Empty(M->BE4_NUMINT))
			
			While !(_cAlias)->(EOF())
				
				If  M->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == (_cAlias)->GUIAS
					
					_lAchou := .T.
					
					Exit
					
				EndIf
				
				(_cAlias)->(DbSkip())
				
			EndDo
			
		EndIf
		
		//-------------------------------------------------------------------------------
		//Ver aqui para olhar o que estiver parametrizado no subcontrato
		//caso não esteja manter para 30 dias (Criar parametro para armazenar)
		//-------------------------------------------------------------------------------
		
		//-----------------------------------------------------------------------------------------------------
		//Caso na contagem já tenha dado 30 de diárias será flegado o campo para coparticipação
		//Caso contrário será avisado em tela que o valor inserido irá ultrapassar os 30 dias,
		//senão der igual a 30 não será feito nada a não ser armazenar esta informação na tabela PBZ.
		//-----------------------------------------------------------------------------------------------------
		If _lAchou .And. ((_cAlias)->TOTAL + _nDiaria) > 30
			
			_lRet := .F.
			
		ElseIf (_cAlias)->TOTAL > 30 .OR. (_cAlias)->TOTAL = 30
			
			M->BE4_XPSIQ := .T.
			
		ElseIf ((_cAlias)->TOTAL + _nDiaria) > 30
			
			_lRet := .F.
			
		EndIf
		
	EndIf
	
	//---------------------------------------------------------------------------------------------------------------------------------
	//Caso tenha passado pelas validações e negativado em alguma delas, será exibida uma mensagem para que seja aberta uma nova senha
	//---------------------------------------------------------------------------------------------------------------------------------
	If !(_lRet)
		
		_cMsg := "Processo de psiquiatria (COPARTICIPAÇÃO), quantidade informada maior que a contratada para não coparticipar."  + cEnt
		_cMsg += "Favor fechar quantidade exata para esta guia não ser coparticipada e abrir uma nova senha." + cEnt
		_cMsg += "Quantidade contratada para o subcontrato: " + cValToChar(30) + cEnt
		_cMsg += "Quantidade já utilizada até o momento: " + cValToChar((_cAlias)->TOTAL) + cEnt
		
		Aviso("Atenção", _cMsg, {"OK"})
		
	EndIf
	
	If Select(_cAlias) > 0
		(_cAlias)->(DbCloseArea())
	EndIf
	
	RestArea(_aArBE4)
	RestArea(_aArBQV)
	RestArea(_aArBEJ)
	RestArea(_aArPBZ)
	RestArea(_aArea	)
	
Return _lRet