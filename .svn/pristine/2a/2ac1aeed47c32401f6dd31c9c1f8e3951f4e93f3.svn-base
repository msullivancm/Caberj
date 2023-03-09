/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS720AG  ºAutor  ³Microsiga           º Data ³  02/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina destinada a implementar criticas relativas a mudanca º±±
±±º          ³de fase e autorizacoes.                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS720AG
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis da rotina...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
Local cTipoGuia	:= paramixb[1]
Local cLocalExec	:= paramixb[2]
Local cChaveGui	:= paramixb[3]
Local aItensGlo	:= paramixb[4]
Local oBrwIte		:= paramixb[5]
Local aAreaBD7		:= BD7->(GetArea())
Local aAreaBR8		:= BR8->(GetArea())
Local nCont			:= 0
Local lRevalor		:= .F.
Local cSQL720AG	:= ""

BD7->(DbSetOrder(1))            
BR8->(DbSetOrder(1))

For nCont := 1 to Len(aItensGlo)

	//Caso seja reconsiderado e opme, 
	//deve-se bloquear o pagamento do BD7
	If aItensGlo[nCont,7] == "2"

	
		If BD7->(MsSeek(xFilial("BD7")+cChaveGui+aItensGlo[nCont,1]))            
			BR8->(MsSeek(xFilial("BR8")+BD7->(BD7_CODPAD+BD7_CODPRO)))
					
			While !BD7->(Eof()) .And. BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == cChaveGui+aItensGlo[nCont,1]
			
				If BR8->BR8_ALTCUS == "1" .And. !(Alltrim(BD7->BD7_CODPRO) $ GetNewPar("MV_YOPCOP","03990010,02990016,01990012"))
				
					cSQL720AG := " SELECT Count(R_E_C_N_O_) AS TOTREG "
					cSQL720AG += " FROM "+RetSQLName("BDX")+" BDX "
					cSQL720AG += " WHERE BDX_FILIAL = '"+xFilial("BDX")+"' "
					cSQL720AG += " AND BDX_CODOPE = '"+BD7->BD7_CODOPE+"' "
					cSQL720AG += " AND BDX_CODLDP = '"+BD7->BD7_CODLDP+"' "
					cSQL720AG += " AND BDX_CODPEG = '"+BD7->BD7_CODPEG+"' "
					cSQL720AG += " AND BDX_NUMERO = '"+BD7->BD7_NUMERO+"' "
					cSQL720AG += " AND BDX_ORIMOV = '"+BD7->BD7_ORIMOV+"' "
					cSQL720AG += " AND BDX_SEQUEN = '"+BD7->BD7_SEQUEN+"' "
					cSQL720AG += " AND BDX_CODGLO = '067' "
					cSQL720AG += " AND BDX.D_E_L_E_T_ = ' ' "
					
					PLSQuery(cSQL720AG,"TRB720AG")

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Caso nao exista critica de OPME sem NF, deve-se bloquear o pgt do item.  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  										
					If TRB720AG->TOTREG = 0
						BD7->(Reclock("BD7",.F.))
						BD7->BD7_BLOPAG := "1"
						BD7->(MsUnlock())
						
						//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança
						u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .T.,.T.)
						
						lRevalor := .T.
					Endif						
					
					TRB720AG->(DbCloseArea())
										
				Endif
			
				BD7->(DbSkip())
			Enddo						
			
		Endif
	
	Endif

Next

//Caso tenha havido algum bloqueio, revalorizar cobranca.
If lRevalor

	PLSA720EVE(BCL->BCL_TIPGUI,BCL->BCL_GUIREL,.F.,&(BCL->BCL_ALIAS+"->"+BCL->BCL_ALIAS+"_ANOPAG"),;
				&(BCL->BCL_ALIAS+"->"+BCL->BCL_ALIAS+"_MESPAG"),BCL->BCL_ALIAS,cChaveGui,{},cLocalExec,{},.T.,.F.,.F.) //ultimo f para posicionar BD6

Endif

RestArea(aAreaBD7)
RestArea(aAreaBR8)

Return