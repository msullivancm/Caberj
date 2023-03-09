#INCLUDE 'PROTHEUS.CH'

#DEFINE _cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV021   ºAutor  ³Angelo Henrique     º Data ³  16/12/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para validar as diárias digitadas nas      º±±
±±º          ³internações, verificando assim se a quantidade de dias      º±±
±±º          ³solicitados conferem com os parametrizados nos demais       º±±
±±º          ³procedimentos.                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV021()
	
	Local _aArea 	:= GetArea()
	Local _aArBEJ	:= BEJ->(GetArea())
	Local _aArBE4	:= BE4->(GetArea())
	Local _aArBR8	:= BR8->(GetArea())
	Local _nPosCd := Ascan(aHeader,{|x| x[2] = "BEJ_CODPRO"})
	Local _nPosPa := Ascan(aHeader,{|x| x[2] = "BEJ_CODPAD"})
	Local _nPosQt := Ascan(aHeader,{|x| x[2] = "BEJ_QTDPRO"})
	Local _lRet 	:= .T.
	Local _cMsg	:= ""
	Local _ni		:= 0
	Local _nVlMa	:= 0
	Local _cMvVld	:= GETMV("MV_XVLINT")
	Local _aUsu 	:= PswRet()
	Local _cUsu 	:= _aUsu[1][1] //Codigo do usuario
	
	//-------------------------------------------------------------------------
	//Validação para saber se é o caordenador que esta colocando a informação
	//-------------------------------------------------------------------------
	If !(_cUsu $ _cMvVld)
		
		DbSelectArea("BR8")
		DbSetOrder(1)
		If DbSeek(xFilial("BR8") + M->BEJ_CODPAD + M->BEJ_CODPRO)
			
			If AllTrim(BR8->BR8_TPPROC) == "4" .And. Len(aCols) = 1
				
				//---------------------------------------
				//Só validar se for:
				//---------------------------------------
				// - 2 = Internação Cirurgica
				// - 3 = Internação Obstetrica				
				//---------------------------------------
				If M->BE4_GRPINT $ "2|3"
					
					_cMsg := "Não é possivel realizar validações referente a diárias. " + _cEnt
					_cMsg += "Pois foi selecionado como primeiro conteudo a Diária." + _cEnt
					_cMsg += "Favor preencher os demais procedimentos e por ultimo preencher a diária"
					
					_lRet 	:= .F.
					
					Aviso("Atenção",_cMsg, {"OK"} )
					
				EndIf
				
			ElseIf AllTrim(BR8->BR8_TPPROC) == "4" .And. Len(aCols) > 1 //Diárias
				
				For _ni := 1 to Len(aCols)
					
					//-------------------------------------------------
					//Varendo o vetor e ponterando novamento pois a
					//validação de linha atual,
					//variável N não esta atualizando
					//-------------------------------------------------
					DbSelectArea("BR8")
					DbSetOrder(1)
					If DbSeek(xFilial("BR8") + aCols[_ni][_nPosPa] + aCols[_ni][_nPosCd])
						
						//---------------------------------------------
						//Só pode valdiar aqui se não for tipo diária
						//---------------------------------------------
						If AllTrim(BR8->BR8_TPPROC) != "4"
							
							//--------------------------------------------------------
							//Caso tenha mais de um procedimento, será pego aquele
							//que possuir o maior número de dias
							//--------------------------------------------------------
							If _nVlMa < BR8->BR8_YQMDIA
								
								_nVlMa := BR8->BR8_YQMDIA
								
							EndIf
							
						EndIf
						
					EndIf
					
				Next _ni
				
				//----------------------------------------------------
				//Se o valor parametrizado no procedimento for
				//menor que o digitado na tela, será exibido
				//aviso para correção.
				//----------------------------------------------------
				If _nVlMa < M->BEJ_QTDPRO
					
					_cMsg := "Quantidade de diária preenchida é maior que a parametrizada." + _cEnt
					_cMsg += "Quantidade máxima permitida: " + cValToChar(_nVlMa) + "." + _cEnt
					
					_lRet 	:= .F.
					
					Aviso("Atenção",_cMsg, {"OK"} )
					
				EndIf
				
			EndIf
			
		EndIf
		
	EndIf
	
	RestArea(_aArBR8)
	RestArea(_aArBE4)
	RestArea(_aArBEJ)
	RestArea(_aArea)
	
Return _lRet