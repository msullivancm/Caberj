#INCLUDE 'PROTHEUS.CH'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorno: T -> Considera a mudanca de fase como uma Autorizacao (guia ficara Ativa)                     ³
//³          F -> Considera a mudanca de fase como uma guia no Contas Medicas (guia ficara em Conferencia) ³
//³ Ponto de Entrada chamado somente na mudanca de fase                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Programa  ³PLNEGMFAS º Autor ³ Roberto Guilherme  º Data ³  24/05/10   º 

//Ponto de entrada contido no fonte PLSMCTMD

User Function PLNEGMFAS 

Local lRet 		:= paramixb[1] 
Local aArea		:= GetArea()
Local cLoteBloq	:= ""
Local lContinua	:= .T.
Local aGuiaBloq
Local lTiss	:= .F.
Local c_ChavGuia
Local c_GuEsto 	
Local c_EstOri
Local c__OpeOri	:= ''
Local c__Fase	:= ''	
Local aAreaBD6	:= BD6->(GetArea())
Local c_Amb

BD6->(DbSetOrder(1))

If BCL->BCL_ALIAS == 'BD5'
	c_ChavGuia 	:= BD5->(BD5_FILIAL + BD5_CODOPE + BD5_CODLDP + BD5_CODPEG + BD5_NUMERO)
	c_GuEsto 	:= BD5->BD5_GUESTO 
	c_EstOri 	:= BD5->BD5_ESTORI
ElseIf BCL->BCL_ALIAS == 'BE4'
	c_ChavGuia 	:= BE4->(BE4_FILIAL + BE4_CODOPE + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO)
	c_GuEsto	:= BE4->BE4_GUESTO 
	c_EstOri 	:= BE4->BE4_ESTORI
EndIf

//Leonardo Portella - 31/01/17 - Início - Monitorar erros em threads

If IsInCallStack('PLSPEGBATH')
	
	c_Amb 		:= AllTrim(Upper(GetEnvServer()))
	
	ConOut('- Ponto de entrada: [ PLNEGMFAS ]: Monitorar Mudança de fase em LOTE: Empresa [ ' + cEmpAnt + ' ] Ambiente [ ' + c_Amb + ' ] Alias [ ' + BCL->BCL_ALIAS + ' ] Chave [ ' + BCI->(BCI_CODLDP + BCI_CODPEG) + ' ]')
		
EndIf

//Leonardo Portella - 31/01/17 - Fim - Monitorar erros em threads

//Leonardo Portella - 14/07/14 - Inicio - Quando estiver mudando a fase do clone, preciso limpar os campos da fase 3.5 na guia clonada pois os mesmos sao copiados 
//no clone.

If ( c_EstOri == '0' )//Nao eh a guia origem
	lFas35Clone(c_ChavGuia,c_GuEsto)
EndIf

//Leonardo Portella - 14/07/14 - Fim

//Leonardo Portella - 14/07/14 - Inicio - Verificar BD6_OPEORI. Chamado - ID: 12278
	
If BD6->(MsSeek(c_ChavGuia))

	c__OpeOri 	:= ''
	
	c__Fase		:= &(BCL->BCL_ALIAS + '->' + BCL->BCL_ALIAS + '_FASE')//Leonardo Portella - 02/12/14
	
	While !BD6->(EOF()) .and. ( BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) == c_ChavGuia )
	
		If empty(BD6->BD6_OPEORI)
			If empty(c__OpeOri)
				c__OpeOri := GetOpeOri(BD6->(BD6_CODOPE+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG))
			EndIf
			
			BD6->(Reclock('BD6',.F.))	
			BD6->BD6_OPEORI := c__OpeOri
			BD6->(Msunlock())
		EndIf	
	
		BD6->(DbSkip())
	
	EndDo

EndIf

BD6->(RestArea(aAreaBD6))
RestArea(aArea)

//Leonardo Portella - 14/07/14 - Fim	

//Leonardo Portella - 21/01/13 - Inicio - Emergencial - O Contas Medicas esta desbloqueando pagamento retornando a fase da guia, assim o sistema calcula a glosa 
//toda novamente e eles podem desbloquear manualmente. Erro da rotina padrao feita entre a Caberj e Totvs na epoca do Roberto. Rotina que foi feita em parceria com 
//Caberj esta como Function porem nao esta no padrao...

If ( FunName() $ 'PLSA498|PLSA475' )
	IF ProcName(5) <> "PLSA500RCB" //Verificando o ProcName para deixar passar em caso de revalorizacao de cobranca
		If BCL->BCL_ALIAS == 'BD5'
			If ( BD5->BD5_SITUAC == '1' ) .and. ( BD5->BD5_FASE $ '1|2' )
				cLoteBloq 	:= ""
				lTiss		:= .T.
			ELSEIF ( BD5->BD5_SITUAC == '1' ) .and. ( BD5->BD5_FASE == '3' )
				aGuiaBloq 	:= aGuiaBloq(BD5->BD5_CODOPE,BD5->BD5_CODLDP,BD5->BD5_CODPEG,BD5->BD5_NUMERO)
				cLoteBloq 	:= aGuiaBloq[1]
				lTiss		:= aGuiaBloq[2]
			EndIf
		ElseIf BCL->BCL_ALIAS == 'BE4'
			If ( BE4->BE4_SITUAC == '1' ) .and. ( BE4->BE4_FASE $ '1|2' )
				cLoteBloq 	:= ""
				lTiss		:= .T.
			ELSEIf ( BE4->BE4_SITUAC == '1' ) .and. ( BE4->BE4_FASE == '3' )
				aGuiaBloq	:= aGuiaBloq(BE4->BE4_CODOPE,BE4->BE4_CODLDP,BE4->BE4_CODPEG,BE4->BE4_NUMERO)
				cLoteBloq 	:= aGuiaBloq[1]
				lTiss		:= aGuiaBloq[2]
			EndIf
		EndIf

		If !empty(cLoteBloq)
			MsgStop('Guia encontra-se com bloqueio de pagamento de RDA.' + CRLF + 'Lote [ ' + cLoteBloq + ' ]' + CRLF + 'Não será permitido mudar a fase!',AllTrim(SM0->M0_NOMECOM))
			lContinua := .F.
		ElseIf !lTiss 
			MsgStop('Guia encontra-se liberada para pagamento' + CRLF + 'Favor solicitar ao gerente ou ao coordenador de Contas Médicas que cancele a liberação de pagamento!',AllTrim(SM0->M0_NOMECOM))
			lContinua := .F.
		EndIf	
		
		If !lContinua
			//Coloco em EOF para que a rotina que chama a mudanca de fase nao ocorra, pois ele valida se BCL_FUNMFS esta vazio. Antes ele posiciona na BCL, portanto nao 
			//deve haver problemas em outras mudancas de fase.
			BCL->(DbGoBottom())
			BCL->(DbSkip()) 
		EndIf
	EndIf
Else
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+BCI->(BCI_CODOPE+BCI_TIPGUI)))
EndIf

//Leonardo Portella - 21/01/13 - Fim

If IsInCallStack ("PLSA973")
    lRet := .F.   //A guia ficara em conferência

	//Leonardo Portella - 09/07/14 - Nao se aplica mais na P11
	/*
	//Veio da geracao de guias SADT a partir de guia de internacao
	If ( Select('BD5') > 0 ) .and. !BD5->(EOF()) .and. ( BD5->BD5_XRCBE4 > 0 ) .and. ( Select('BE4') > 0 ) .and. !BE4->(EOF())
		BE4->(DbGoTo(BD5->BD5_XRCBE4))
		U_VldBlqProc(BD5->(BD5_CODOPE + BD5_CODLDP + BD5_CODPEG + BD5_NUMERO))	
	EndIf
	*/
EndIf

RestArea(aArea)
	
Return lRet

**************************************************************************************

//Leonardo Portella - 09/07/14 - Alteracoes para verificar no mesmo loop se esta conferido na fase 3.5

Static Function aGuiaBloq(cCodOpe,cCodLdp,cCodPeg,cNumero)

Local aAreaBD7	:= BD7->(GetArea())
Local aAreaBCI	:= BCI->(GetArea())
Local cChave	:= xFilial('BD7') + cCodOpe + cCodLdp + cCodPeg + cNumero
Local cLoteBloq	:= ""
Local aRetBD7	:= Array(2)
Local lStTiss	:= .F.

BD7->(DbSetOrder(1))//BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODUNM+BD7_NLANC 

BD7->(MsSeek(cChave))

While !BD7->(EOF()) .and. ( BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO) == cChave )

	If !empty(BD7->BD7_LOTBLO) .and. ( At(BD7->BD7_LOTBLO,cLoteBloq) <= 0 )
		cLoteBloq += BD7->BD7_LOTBLO + ','	
	EndIf
	
	BD7->(DbSkip())
	
EndDo 

BCI->(DbSetOrder(1))//BCI_FILIAL+BCI_CODOPE+BCI_CODLDP+BCI_CODPEG+BCI_FASE+BCI_SITUAC

IF BCI->(MsSeek(xFilial('BCI') + cCodOpe + cCodLdp + cCodPeg))
	
	IF BCI->BCI_STTISS <> '3' .AND. BCI->BCI_STTISS <> '6'
		lStTiss	:= .T.
	ENDIF

ENDif

BCI->(RestArea(aAreaBCI))


If !empty(cLoteBloq)
	cLoteBloq 	:= Left(cLoteBloq,len(cLoteBloq) - 1)
EndIf

aRetBD7[1] 	:= cLoteBloq
aRetBD7[2] 	:= lStTiss

BD7->(RestArea(aAreaBD7))

Return aRetBD7

**************************************************************************************

//Leonardo Portella - 14/07/14 - Limpar os campos da fase 3.5 na guia clonada pois os mesmos sao copiados no clone.

Static Function lFas35Clone(c_ChavGuia,c_GuEsto)

Local a_AreaBD7	:= BD7->(GetArea())
Local lMudou 	:= .F.

BD7->(DbSetOrder(1))//BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODUNM+BD7_NLANC 

BD7->(MsSeek(c_ChavGuia))

While !BD7->(EOF()) .and. ( BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO) == c_ChavGuia )

	If BD7->BD7_YFAS35
		BD7->(Reclock('BD7',.F.))
		BD7->BD7_YFAS35 := .F.
		BD7->(MsUnlock())
		
		lMudou := .T.
	EndIf
	
	BD7->(DbSkip())
	
EndDo 

BD7->(RestArea(a_AreaBD7))

Return lMudou

**************************************************************************************

Static Function GetOpeOri(cMatric)

Local a_ArOri 	:= GetArea()
Local a_ArBA1	:= BA1->(GetArea())
Local c_OpeOri	:= ''

BA1->(DbSetOrder(2))

If BA1->(MsSeek(xFilial('BA1') + cMatric))
	c_OpeOri := BA1->BA1_OPEORI
Else
	c_OpeOri := PLSINTPAD()
EndIf

BA1->(RestArea(a_ArBA1))
RestArea(a_ArOri)

Return c_OpeOri

**************************************************************************************

