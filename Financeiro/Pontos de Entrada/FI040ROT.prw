#INCLUDE 'PROTHEUS.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FI040ROT  ºAutor  ³Angelo Henrique     º Data ³  10/10/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para criar ñovas opções no menu, porém     ?±±
±±º          ³só esta exibindo no Contas a Receber e não no Funções.      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj  			                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FI040ROT()
	
	Local aRotRet := AClone(PARAMIXB)
	
	aAdd( aRotRet,{"Bol. Aluguel", "u_VldAlg()", 0, 7})
	
Return aRotRet


User Function VldAlg()
	
	Local _aArea 	:= GetArea()
	Local _cMvPref	:= GetNewPar("MV_XPRFBOL", "ALG") //Prefixo para identificar que o boleto é de Aluguel
	
	If SE1->E1_PREFIXO = _cMvPref .And. cEmpAnt = "02"
		
		If MsgYesNo("Este titulo é um boleto Aluguel, deseja de fato atualizar as informações do boleto?","Valida Boleto.")
			
			//----------------------------------------------------------------------------
			//Rotina BolAlg() encontra-se dentro do ponto de entrada FA040GRV
			//----------------------------------------------------------------------------
			u_BolAlg()
			
		EndIf
		
	Else
		
		Aviso("Atenção","Processo utilizado pela INTEGRAL e para boletos identificados como ALUGUEL.",{"OK"})
		
	EndIf
	
	RestArea(_aArea)
	
Return