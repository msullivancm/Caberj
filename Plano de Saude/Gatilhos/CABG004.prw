#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABG004  ºAutor  ³Angelo Henrique     º Data ³  03/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho criado para preencher o campo de data no momento do º±±
±±º          ³preenchimento do protocolo de reembolso.                    º±±
±±º          ³Atendendo assim o chamado: 35659.                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function CABG004()
	
	Local _aArea 	:= GetArea()
	Local _aArZQ 	:= ZZQ->(GetArea())
	Local _aArB1 	:= BA1->(GetArea())
	Local _aArB3 	:= BI3->(GetArea())
	Local _aArQC 	:= BQC->(GetArea())
	Local _dRet	 	:= CTOD(" / / ")
	
	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1")+M->ZZQ_CODBEN)
		
		//------------------------------------------------------------------
		//Ponterar no subcontrato para validar se a parametrização esta
		//nesse nivel ou no nível do produto
		//------------------------------------------------------------------
		DbSelectArea("BQC")
		DbSetOrder(1) //BQC_FILIAL+BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB
		If DbSeek(xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB))
			
			//1 - Sim 2 - Não - Parametrização no nivel do subcontrato
			If BQC->BQC_XNIVEL == '1'
				
				If BQC->BQC_XREEM1 != 0 .OR. BQC->BQC_XREEM2 != 0 .OR. BQC->BQC_XREEM3 != 0 .OR. BQC->BQC_XREEM4 != 0
					
					If alltrim(M->ZZQ_TIPPRO) $ "|C|6" .and. alltrim(M->ZZQ_COMPAG) $ 'CONSULTA' //.AND. cEmpAnt == "02" //1=Anestesia e Honorarios Medicos
						
						
						if BQC->BQC_XREEM1 > 0  // caso seja igual a 0 soma 30 dias
							_dRet :=  Datavalida(DaySum(dDatabase,BQC->BQC_XREEM1), .F.)
						else
							_dRet :=  Datavalida(DaySum(dDatabase,30), .F.)
						endif
							
						//ElseIf alltrim(M->ZZQ_TIPPRO) $ "|1|9|D" //1=Anestesia e Honorarios Medicos
						
						//	_dRet :=  Datavalida(DaySum(dDatabase,BQC->BQC_XREEM1))
						
					ElseIf alltrim(M->ZZQ_TIPPRO) $ "|2|8|A|B|C||1|9|D" //2=Consultas, Exames e Procedimentos
						
						if BQC->BQC_XREEM2 > 0  // caso seja igual a 0 soma 30 dias
							_dRet := Datavalida(DaySum(dDatabase,BQC->BQC_XREEM2), .F.)
						else
							_dRet := Datavalida(DaySum(dDatabase,30), .F.)
						endif
						
					ElseIf alltrim(M->ZZQ_TIPPRO) $ "3" //3=Projetos Especiais/Atend. Domiciliar
						
						if BQC->BQC_XREEM3 > 0  // caso seja igual a 0 soma 30 dias
							_dRet := Datavalida(DaySum(dDatabase,BQC->BQC_XREEM3), .F.)
						else
							_dRet := Datavalida(DaySum(dDatabase,30), .F.)
						endif
						
						
					ElseIf alltrim(M->ZZQ_TIPPRO) $ "4|5|6|7|" //4=Aux Funeral
						
						if BQC->BQC_XREEM4 > 0  // caso seja igual a 0 soma 30 dias
							_dRet := Datavalida(DaySum(dDatabase,BQC->BQC_XREEM4), .F.)
						else
							_dRet := Datavalida(DaySum(dDatabase,30), .F.)
						endif
						
					EndIf
					
				EndIf
				
			Else
				
				//-----------------------------------------------------------
				//Irá procurar na parametrização no nível do produto
				//-----------------------------------------------------------
				DbSelectArea("BI3")
				DbSetOrder(1)
				If DbSeek(xFilial("BA1")+BA1->(BA1_CODINT+BA1_CODPLA))
					
					//------------------------------------------------------
					//Validando qual o campo de dias do reembolso
					//a rotina irá olhar, pois depende do tipo
					//selecionado no momento da inclusão do reembolso
					//------------------------------------------------------
					
					If BI3->BI3_XREEM1 != 0 .OR. BI3->BI3_XREEM2 != 0 .OR. BI3->BI3_XREEM3 != 0 .OR. BI3->BI3_XREEM4 != 0
						
						If alltrim(M->ZZQ_TIPPRO) $ "|1|9|D" //1=Anestesia e Honorarios Medicos
							// caso seja igual a 0 soma 30 dias
							if BI3->BI3_XREEM1 > 0  // caso seja igual a 0 soma 30 dias
								_dRet :=  Datavalida(DaySum(dDatabase,BI3->BI3_XREEM1), .F.)
							else
								_dRet :=  Datavalida(DaySum(dDatabase,BI3->BI3_XREEM1), .F.)
							endif
							
						ElseIf alltrim(M->ZZQ_TIPPRO) $ "|2|8|A|B|C|" //2=Consultas, Exames e Procedimentos
							// caso seja igual a 0 soma 30 dias
							if BI3->BI3_XREEM2 > 0  // caso seja igual a 0 soma 30 dias
								_dRet := Datavalida(DaySum(dDatabase,BI3->BI3_XREEM2), .F.)
							else
								_dRet := Datavalida(DaySum(dDatabase,BI3->BI3_XREEM2), .F.)
							endif
						ElseIf alltrim(M->ZZQ_TIPPRO) $ "3" //3=Projetos Especiais/Atend. Domiciliar
							// caso seja igual a 0 soma 30 dias
							if BI3->BI3_XREEM3 > 0  // caso seja igual a 0 soma 30 dias
								_dRet := Datavalida(DaySum(dDatabase,BI3->BI3_XREEM3), .F.)
							else
								_dRet := Datavalida(DaySum(dDatabase,30), .F.)
							endif
						ElseIf alltrim(M->ZZQ_TIPPRO) $ "4|5|6|7|" //4=Aux Funeral
							if BI3->BI3_XREEM4 > 0  // caso seja igual a 0 soma 30 dias
								_dRet := Datavalida(DaySum(dDatabase,BI3->BI3_XREEM4), .F.)
							else
								_dRet := Datavalida(DaySum(dDatabase,30), .F.)
							endif
						EndIf
						
					EndIf
					
				EndIf
				
			EndIf
			
		EndIf
		
	EndIf
	
	If Empty(_dRet)
		
		Aviso("Atenção","Não foi encontrado parametrização para a previsão de data de pagamento. Será atribuído 30 dias contados a partir de hoje.",{"OK"})
		_dRet := Datavalida(dDatabase + 30, .F.)
		
	EndIf
	
	RestArea(_aArQC)
	RestArea(_aArB3)
	RestArea(_aArB1)
	RestArea(_aArZQ)
	RestArea(_aArea)
	
return _dRet
