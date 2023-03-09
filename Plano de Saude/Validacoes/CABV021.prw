#INCLUDE 'PROTHEUS.CH'

#DEFINE _cEnt Chr(13)+Chr(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABV021   �Autor  �Angelo Henrique     � Data �  16/12/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para validar as di�rias digitadas nas      ���
���          �interna��es, verificando assim se a quantidade de dias      ���
���          �solicitados conferem com os parametrizados nos demais       ���
���          �procedimentos.                                              ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
	//Valida��o para saber se � o caordenador que esta colocando a informa��o
	//-------------------------------------------------------------------------
	If !(_cUsu $ _cMvVld)
		
		DbSelectArea("BR8")
		DbSetOrder(1)
		If DbSeek(xFilial("BR8") + M->BEJ_CODPAD + M->BEJ_CODPRO)
			
			If AllTrim(BR8->BR8_TPPROC) == "4" .And. Len(aCols) = 1
				
				//---------------------------------------
				//S� validar se for:
				//---------------------------------------
				// - 2 = Interna��o Cirurgica
				// - 3 = Interna��o Obstetrica				
				//---------------------------------------
				If M->BE4_GRPINT $ "2|3"
					
					_cMsg := "N�o � possivel realizar valida��es referente a di�rias. " + _cEnt
					_cMsg += "Pois foi selecionado como primeiro conteudo a Di�ria." + _cEnt
					_cMsg += "Favor preencher os demais procedimentos e por ultimo preencher a di�ria"
					
					_lRet 	:= .F.
					
					Aviso("Aten��o",_cMsg, {"OK"} )
					
				EndIf
				
			ElseIf AllTrim(BR8->BR8_TPPROC) == "4" .And. Len(aCols) > 1 //Di�rias
				
				For _ni := 1 to Len(aCols)
					
					//-------------------------------------------------
					//Varendo o vetor e ponterando novamento pois a
					//valida��o de linha atual,
					//vari�vel N n�o esta atualizando
					//-------------------------------------------------
					DbSelectArea("BR8")
					DbSetOrder(1)
					If DbSeek(xFilial("BR8") + aCols[_ni][_nPosPa] + aCols[_ni][_nPosCd])
						
						//---------------------------------------------
						//S� pode valdiar aqui se n�o for tipo di�ria
						//---------------------------------------------
						If AllTrim(BR8->BR8_TPPROC) != "4"
							
							//--------------------------------------------------------
							//Caso tenha mais de um procedimento, ser� pego aquele
							//que possuir o maior n�mero de dias
							//--------------------------------------------------------
							If _nVlMa < BR8->BR8_YQMDIA
								
								_nVlMa := BR8->BR8_YQMDIA
								
							EndIf
							
						EndIf
						
					EndIf
					
				Next _ni
				
				//----------------------------------------------------
				//Se o valor parametrizado no procedimento for
				//menor que o digitado na tela, ser� exibido
				//aviso para corre��o.
				//----------------------------------------------------
				If _nVlMa < M->BEJ_QTDPRO
					
					_cMsg := "Quantidade de di�ria preenchida � maior que a parametrizada." + _cEnt
					_cMsg += "Quantidade m�xima permitida: " + cValToChar(_nVlMa) + "." + _cEnt
					
					_lRet 	:= .F.
					
					Aviso("Aten��o",_cMsg, {"OK"} )
					
				EndIf
				
			EndIf
			
		EndIf
		
	EndIf
	
	RestArea(_aArBR8)
	RestArea(_aArBE4)
	RestArea(_aArBEJ)
	RestArea(_aArea)
	
Return _lRet