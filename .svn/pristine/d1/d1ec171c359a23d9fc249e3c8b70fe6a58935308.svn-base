#INCLUDE 'PROTHEUS.CH'
#DEFINE _cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV022   ºAutor  ³Angelo Henrique     º Data ³  21/12/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para validar as diárias digitadas nas      º±±
±±º          ³internações, verificando assim se a quantidade de dias      º±±
±±º          ³solicitados conferem com os parametrizados nos demais       º±±
±±º          ³procedimentos.                                              º±±
±±º          ³Neste momento será utilziado como gatilho porém usando a    º±±
±±º          ³lógica do CABV021, por isso não deixei em gatilhos.;        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABV022()
	
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
	
	DbSelectArea("BR8")
	DbSetOrder(1)
	If DbSeek(xFilial("BR8") + M->BEJ_CODPAD + M->BEJ_CODPRO)
		
		If AllTrim(BR8->BR8_TPPROC) == "4" .And. Len(aCols) > 1 //Diárias
			
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
					//Só pode validar aqui se não for tipo diária
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
			
			//---------------------------------------------
			//Aplicando gatilho para o campo BEJ_QTDPRO
			//---------------------------------------------
			M->BEJ_QTDPRO := _nVlMa			
		
		Else
		
		_nVlMa := M->BEJ_QTDPRO
		
			
		EndIf
		
	EndIf
	
	RestArea(_aArBR8)
	RestArea(_aArBE4)
	RestArea(_aArBEJ)
	RestArea(_aArea)
	
Return _nVlMa
