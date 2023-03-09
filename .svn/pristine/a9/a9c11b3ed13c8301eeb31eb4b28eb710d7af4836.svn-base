#INCLUDE 'RWMAKE.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

#DEFINE cEnt Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLS500BRWº Autor ³ Leonardo Portella  º Data ³  15/02/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Adiciona botão para impressão de guias na digitação de     º±±
±±º          ³ contas médicas                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PLS500BRW
	
	Local aArea		:= GetArea()
	Local aRet 		:= {}
	//Local _nPosGl	:= Ascan(aRotina,{|x| x[2] == "PLSA500ACT"})
	Local _nPosGl	:= 0
	Local nI		:= 0
	
	aAdd(aRet,{ 'Imprimir guia' ,'U_CABR234' ,0 ,1 })
	
	//----------------------------------------------------------------------
	//Angelo Henrique - Data:16/03/2018
	//----------------------------------------------------------------------
	//Para o processo de glosa 09N foi criado uma rotina para pegar
	//o registro deletado pelo padrão.
	//----------------------------------------------------------------------
//BIANCHINI - 13/08/2020 - RETIRADO POIS ESTAVA SUJANDO AS GUIAS COM GLOSAS QUE NAO OCORRERAM "09N"
/*	
	If Len(aRotina)>0
		For nI := 1 to Len(aRotina)  
			If ValType(aRotina[nI,2]) == "C"
				If aRotina[nI,2] == "PLSA500ACT" 
					_nPosGl	:= nI 
					Exit
				Endif
			Endif
		Next
	Endif
	
	aRotina[_nPosGl][2] :=  "u_RecGlosa()"
*/	
	RestArea(aArea)
	
Return aRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RecGlosa	  Autor ³ Angelo Henrique    º Data ³  16/03/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Recupera item deletado pela rotina padrão caso a mesma     º±±
±±º          ³ esteja deletada.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function RecGlosa
	
	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())
	Local _aArBAU	:= BAU->(GetArea())
	Local _aArBD6	:= BD6->(GetArea())
	Local _cQuery	:= ""	
	Local _cChave	:= &(_aArea[1])->(&(_aArea[1]+"_CODOPE")+&(_aArea[1]+"_CODLDP")+&(_aArea[1]+"_CODPEG")+&(_aArea[1]+"_NUMERO"))
	
	Private _cAlias	:= GetNextAlias()
	Private _cAlias2:= GetNextAlias()
	
	DbSelectArea(_aArea[1])
	DbSetOrder(1)
	&(_aArea[1])->(DbGoTop())
	DbGoTo(_aArea[3]) //Recno da tabela
	
	//------------------------------------------------------------------------------------------
	//Ponterando na BD6 para pegar correto as informações e adicionar mais validações
	//assim não perdendo tempo caso esteja tudo correto.
	//------------------------------------------------------------------------------------------
	DbSelectArea("BD6")
	DbSetORder(1) //BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	If DbSeek(xFilial("BD6") + _cChave )
		
		If !(cEmpAnt == '01' .And. BD6->BD6_CODEMP == '0004')
			
			//--------------------------------------------------------------------
			//Só verifica e recupera o registro se a guia estiver em fase 2
			//o restante das validações deixo com o padrão para resolver
			//--------------------------------------------------------------------
			If BD6->BD6_FASE == "2"
				
				DbSelectArea("BAU")
				DbSetOrder(1)
				If DbSeek(xFilial("BAU") + BD6->BD6_CODRDA) //BAU_CODIGO = BD6_CODRDA
					
					If UPPER(AllTrim(BAU->BAU_TIPPRE)) != "OPE"
						
						While BD6->(!EOF()) .And. _cChave == BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)
							
							DbSelectArea("BDX")
							DbSetOrder(1)//BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN+BDX_CODGLO
							If ! BDX->(MsSeek(xFilial("BDX")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO+BD6_SEQUEN)))
								
								//---------------------------------------------------------------------------
								//Caso não tenha achado, irá varrer para ver se tem alguma critica de 09N
								//---------------------------------------------------------------------------
								_cQuery := u_QryPl500("1")
								
								If Select(_cAlias) > 0
									(_cAlias)->(DbCloseArea())
								EndIf
								
								PLSQuery(_cQuery,_cAlias)
								
								If !(Empty((_cAlias)->RECNO))
									
									//-------------------------------------------------------
									//Rotina que monta a query para realizar o UPDATE
									//-------------------------------------------------------
									_cQuery	:= u_QryUpd("1")
									
									TcSqlExec(_cQuery )
									
								EndIf
								
								If Select(_cAlias) > 0
									(_cAlias)->(DbCloseArea())
								EndIf
								
							Else
								
								//------------------------------------------------------------------------------
								//Neste momento ele achou alguma critica para o procedimento,
								//porém é necessário que seja pesquisado se existem registro criados
								//para o 09N que foi deletado.
								//------------------------------------------------------------------------------
								_cQuery := u_QryPl500("2")
								
								If Select(_cAlias) > 0
									(_cAlias)->(DbCloseArea())
								EndIf
								
								PLSQuery(_cQuery,_cAlias)
								
								//--------------------------------------------------
								//Se não achar irá varrer se tem item deletado.
								//--------------------------------------------------
								If Empty((_cAlias)->RECNO)
									
									//---------------------------------------------------------------------------
									//Caso não tenha achado, irá varrer para ver se tem alguma critica de 09N
									//---------------------------------------------------------------------------
									_cQuery := u_QryPl500("1")
									
									If Select(_cAlias2) > 0
										(_cAlias2)->(DbCloseArea())
									EndIf
									
									PLSQuery(_cQuery,_cAlias2)
									
									If !(Empty((_cAlias2)->RECNO))
																				
										//-------------------------------------------------------
										//Rotina que monta a query para realizar o UPDATE
										//-------------------------------------------------------
										_cQuery	:= u_QryUpd("2")
										
										TcSqlExec(_cQuery )
										
									EndIf
									
									If Select(_cAlias2) > 0
										(_cAlias2)->(DbCloseArea())
									EndIf
									
								EndIf
								
							EndIf
							
							BD6->(DbSkip())
							
						EndDo
						
					EndIf
					
				EndIf
				
			EndIf
			
		EndIf
		//------------------------------------------------------------------------
		//Após recuperar o registro chama a rotina padrão
		//------------------------------------------------------------------------
		PLSA500ACT(_aArea[1], _aArea[3], 7)
	EndIf
	
	DbSelectArea("BD6")
	DbSetORder(1) //BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	If DbSeek(xFilial("BD6") + _cChave )
		
		u_CABA005()
		
	EndIf
		
	RestArea(_aArBD6)
	RestArea(_aArBAU)
	RestArea(_aArea	)
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ QryPl500	  Autor ³ Angelo Henrique    º Data ³  22/03/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina utilizada para realizar a query, uma vez que a mesmaº±±
±±º          ³ era chamada em mais de um lugar.                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QryPl500(_cParam)
	
	Local _cRet		:= ""
	
	Default _cParam := "1"
	
	_cRet := " SELECT 												" + cEnt
	_cRet += " 	MAX(BDX.R_E_C_N_O_)	RECNO							" + cEnt
	_cRet += " FROM													" + cEnt
	_cRet += " 	" + RetSqlName("BDX") +  " BDX						" + cEnt
	_cRet += " WHERE												" + cEnt
	_cRet += " 	BDX.BDX_FILIAL 		= '" + xFilial("BDX")	+ "'	" + cEnt
	_cRet += " 	AND BDX.BDX_CODOPE 	= '" + BD6->BD6_CODOPE 	+ "'	" + cEnt
	_cRet += " 	AND BDX.BDX_CODLDP 	= '" + BD6->BD6_CODLDP 	+ "'	" + cEnt
	_cRet += " 	AND BDX.BDX_CODPEG 	= '" + BD6->BD6_CODPEG 	+ "'	" + cEnt
	_cRet += " 	AND BDX.BDX_NUMERO 	= '" + BD6->BD6_NUMERO 	+ "'	" + cEnt
	_cRet += " 	AND BDX.BDX_CODPAD 	= '" + BD6->BD6_CODPAD 	+ "'	" + cEnt
	_cRet += " 	AND BDX.BDX_CODPRO 	= '" + BD6->BD6_CODPRO 	+ "'	" + cEnt
	_cRet += " 	AND BDX.BDX_SEQUEN 	= '" + BD6->BD6_SEQUEN 	+ "'	" + cEnt
	_cRet += " 	AND BDX.BDX_CODGLO 	= '09N'							" + cEnt
	
	If _cParam == "1"
		
		_cRet += " 	AND BDX.D_E_L_E_T_ 	= '*'						" + cEnt
		
	ElseIf _cParam == "2"
		
		_cRet += " 	AND BDX.D_E_L_E_T_ 	= ' '						" + cEnt
		
	EndIf
		
Return _cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ QryUpd   º Autor ³ Angelo Henrique    º Data ³  22/03/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para fazer a query do update pois a mesma era       º±±
±±º          ³ chamada em dois pontos.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QryUpd(_cParam)
	
	Local _cRet		:= ""
	
	Default _cParam := "1"
	
	_cRet := " UPDATE 																										" + cEnt
	_cRet += " 	" + RetSqlName("BDX") +  " BDX																				" + cEnt
	_cRet += " SET 																											" + cEnt
	_cRet += " 	BDX.D_E_L_E_T_ = ' '																						" + cEnt
	_cRet += " WHERE																										" + cEnt
	_cRet += " 	BDX.BDX_FILIAL 		= '" + xFilial("BDX")	+ "'															" + cEnt
	_cRet += " 	AND BDX.BDX_CODOPE 	= '" + BD6->BD6_CODOPE 	+ "'															" + cEnt
	_cRet += " 	AND BDX.BDX_CODLDP 	= '" + BD6->BD6_CODLDP 	+ "'															" + cEnt
	_cRet += " 	AND BDX.BDX_CODPEG 	= '" + BD6->BD6_CODPEG 	+ "'															" + cEnt
	_cRet += " 	AND BDX.BDX_NUMERO 	= '" + BD6->BD6_NUMERO 	+ "'															" + cEnt
	_cRet += " 	AND BDX.BDX_CODPAD 	= '" + BD6->BD6_CODPAD 	+ "'															" + cEnt
	_cRet += " 	AND BDX.BDX_CODPRO 	= '" + BD6->BD6_CODPRO 	+ "'															" + cEnt
	_cRet += " 	AND BDX.BDX_SEQUEN 	= '" + BD6->BD6_SEQUEN 	+ "'															" + cEnt
	_cRet += " 	AND BDX.BDX_CODGLO 	= '09N'																					" + cEnt
	_cRet += " 	AND BDX.D_E_L_E_T_ 	= '*'																					" + cEnt
	
	If _cParam == "1"
	
		_cRet += " 	AND BDX.R_E_C_N_O_ IN (" + cValToChar((_cAlias)->RECNO - 1) + "," + cValToChar((_cAlias)->RECNO) + ")	" + cEnt
	
	ElseIf _cParam == "2"
	
		_cRet += " 	AND BDX.R_E_C_N_O_ IN (" + cValToChar((_cAlias2)->RECNO - 1) + "," + cValToChar((_cAlias2)->RECNO) + ")	" + cEnt
	
	EndIf
	
Return _cRet