#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"

//Static CRLF := CHR(13) + CHR(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLS500RF º Autor ³ Jean Schulz           º Data ³ 29/11/06 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Ponto de entrada apos o retorno de fase. 		  		  º±±
±±º          ³ 									                   		  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLS500RF()
	
	Local cTipGui	:= PARAMIXB[1]
	Local cArquivo	:= PARAMIXB[2] //BD5 ou BE4
	Local cCodLdp	:= PARAMIXB[4]
	Local cCodPeg	:= PARAMIXB[5]
	Local cNumero	:= PARAMIXB[6]
	Local cOriMov	:= PARAMIXB[7]
	Local cChave	:= PLSINTPAD()+cCodLdp+cCodPeg+cNumero+cOriMov
	Local cSeqPac	:= ""
	Local aAreaBD6	:= BD6->(GetArea())
	Local aAreaBD7	:= BD7->(GetArea())
	Local aAreaBR8	:= BR8->(GetArea())
	Local _cYopCop 	:= GetNewPar("MV_YOPCOP","03990010,02990016,01990012") //Angelo Henrique - Data: 02/04/2018 - Projeto Otimização da rotina - Mudança de Fase
	Local cQuery    := "" //Angelo Henrique - Data: 02/04/2018 - Projeto Otimização da rotina - Mudança de Fase
	Local _cCntQry	:= "" //Angelo Henrique - Data: 02/04/2018 - Projeto Otimização da rotina - Mudança de Fase
	Local cUpdBd7	:= "" //Angelo Henrique - Data: 02/04/2018 - Projeto Otimização da rotina - Mudança de Fase
	Local cAliasQry := GetNextAlias() //Angelo Henrique - Data: 02/04/2018 - Projeto Otimização da rotina - Mudança de Fase
	Local _cUpd01	:= "" //Angelo Henrique - Data: 02/04/2018 - Projeto Otimização da rotina - Mudança de Fase
	Local _cUpd02	:= "" //Angelo Henrique - Data: 02/04/2018 - Projeto Otimização da rotina - Mudança de Fase
	Local _cUpd03	:= "" //Angelo Henrique - Data: 02/04/2018 - Projeto Otimização da rotina - Mudança de Fase
	
	//Leonardo Portella - 12/11/14 - Inicio - Quando nao vier informado, preencher com "nao informado".
	
	If ( BCL->BCL_ALIAS == 'BE4' ) .and. empty(BE4->BE4_TIPADM)
		BE4->(Reclock('BE4',.F.))
		BE4->BE4_TIPADM := '0'//Nao informado
		BE4->(MsUnlock())
	EndIf
	
	//Leonardo Portella - 12/11/14 - Fim
	
	BDX->(DbSetOrder(1))//BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN+BDX_CODGLO
	
	//BR8->(DbSetOrder(1))  -- Angelo Henrique - Data: 02/04/2018 - Projeto Mudança de Fase - Melhoria
	
	BD6->(DbSetOrder(1))
	BD6->(MsSeek(xFilial("BD6")+cChave))
	
	While ! BD6->(Eof()) .And. cChave == BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV)
		
		//-----------------------------------------------------------------------------------------
		//Inicio - Angelo Henrique - Data:11/11/2015 - Chamado 19190
		//-----------------------------------------------------------------------------------------
		//Quando retornar a fase irá restaurar a condição original da tabela ZRT
		//ZRT(Item da tela de exames e procedimentos)
		//Colocado aqui pois abaixo em algumas situações a BD6 pode ser excluídos
		//garantindo assim que antes dessa exclusão o dado salvo na tabela ZRT seja restaurada
		//-----------------------------------------------------------------------------------------
		DbSelectArea("ZRT")
		DbSetOrder(6)
		If DbSeek(xFilial("ZRT") + BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO))
			
			While ZRT->(!EOF()) .And. ALLTRIM(BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO)) == ALLTRIM(ZRT->ZRT_CHVBD6)
				
				RecLock("ZRT", .F.)
				
				ZRT->ZRT_ATEND 	:= "N"
				ZRT->ZRT_DTCONS	:= CTOD(" / / ")
				ZRT->ZRT_CHVBD6	:= " "
				
				ZRT->(MsUnLock())
				
				ZRT->(DbSkip())
				
			EndDo
			
		EndIf
		//-----------------------------------------------------------------------------------------
		//Fim - Angelo Henrique - Data:11/11/2015 - Chamado 19190
		//-----------------------------------------------------------------------------------------
		
		//Leonardo Portella - 19/12/13 - Inicio - No retorno de fase em algumas situacoes especificas nao esta limpando o envia para conferencia fazendo com que
		//a alteracao na parametrizacao nao tenha efeito e fazendo com que fosse necessario redigitar o procedimento. O sistema sempre deve limpar este campo para
		//ver se a glosa eh correta ou nao conforme parametrizacao do momento.
		
		If ( BD6->BD6_ENVCON == '1' )
			BD6->(Reclock('BD6',.F.))
			BD6->BD6_ENVCON := ' '
			BD6->(Msunlock())
		EndIf
		
		//Leonardo Portella - 19/12/13 - Fim
		
		If !empty(BD6->BD6_DATPRO) .and. ( Len(AllTrim(BD6->BD6_HORPRO)) < 6 )
			BD6->(Reclock('BD6',.F.))
			BD6->BD6_HORPRO := PadR(AllTrim(BD6->BD6_HORPRO),6,'0')
			BD6->(Msunlock())
		EndIf

		aAreaBCI := BCI->(GetArea())
		
		BCI->(DbSetOrder(1))//BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG
		lOkBCI := BCI->(MsSeek(xFilial('BCI') + PLSINTPAD() + cCodLdp + cCodPeg))
		
		If lOkBCI
			lOkBCI := !empty(BCI->BCI_ARQUIV)//Importado
		EndIf
		
		BCI->(RestArea(aAreaBCI))
		
		//Leonardo Portella - 21/01/14 - Fim
		
		//Leonardo Portella - 24/04/13 - Inicio - Em alguns casos o padrao estava bloqueando o BD7 indevidamente. Faco o desbloqueio no retorno de fase pois se for devido
		//o sistema ira bloquear novamente quando for feita a mudanca de fase.
		
		//If BD7->(MsSeek(xFilial("BD7") + cChave)) .and. ( ( BD7->BD7_CODLDP == '0016' ) .or. lOkBCI )
		If BD7->(MsSeek(xFilial("BD7") + cChave)) .or. lOkBCI 
			
			//----------------------------------------------------------------------------------
			// INICIO - Angelo Henrique - Data: 02/04/2018
			//----------------------------------------------------------------------------------
			//Projeto Otimização da rotina - Mudança de Fase
			//----------------------------------------------------------------------------------
			
			//Remover while e colocar para query - gerar update  - Angelo Henrique - Data: 02/04/2018 - Projeto Mudança de Fase Melhoria
			While !BD7->(Eof()) .and. ( cChave == BD7->(BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV) )
				
				BD7->(Reclock('BD7',.F.))
				
				If ( AllTrim(BD7->BD7_CODUNM) <> 'PA' ) .and. ( BD7->BD7_BLOPAG <> '0' )
					BD7->BD7_BLOPAG := '0'
					BD7->BD7_MOTBLO := Space(TamSX3('BD7_MOTBLO')[1])
					BD7->BD7_DESBLO := Space(TamSX3('BD7_DESBLO')[1])
				//BIANCHINI - 16/05/2019 - ELIMINANDO BLOQUEIO/DESBLOQUEIO VIA PE
				//ElseIf ( AllTrim(BD7->BD7_CODUNM) == 'PA' ) .and. ( BD7->BD7_BLOPAG <> '1' )
				//BD7->BD7_BLOPAG := '1'
				EndIf
				
				If empty(BD7->BD7_CODTPA)
					BD7->BD7_CODTPA := "H"
				EndIf
				
				BD7->(Msunlock())

				//BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança
				u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .F.,.F.)

				BD7->(DbSkip())
				
			EndDo
			
		Endif
		
		//Leonardo Portella - 24/04/13 - Fim
		
		BD6->(DbSkip())
		
	Enddo
	
	//--------------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 31/07/2018											|
	//--------------------------------------------------------------------------------------
	// RDM 302 / 2018
	//--------------------------------------------------------------------------------------
	// Projeto - Valoração do Brasíndice – Acrescimento/Desconto.							|
	//--------------------------------------------------------------------------------------
	// Esta rotina irá limpar os campos no momento em que retornar a fase 					|	
	//--------------------------------------------------------------------------------------
	
	/*BD6->(DbGoTop())
	BD6->(DbSetOrder(1))
	If BD6->(MsSeek(xFilial("BD6") + cChave))
	
		u_CABA005A()
	
	EndIf*/
	
	//--------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 31/07/2018												|
	//--------------------------------------------------------------------------------------	
	
	RestArea(aAreaBD6)
	RestArea(aAreaBD7)
	RestArea(aAreaBR8)
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ Pl5WhQry º Autor ³ Angelo Henrique       º Data ³ 03/04/18 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para incrementar as query's elaboradas no ponto de  º±±
±±º          ³ entrada, tentando reduzir assim o excesso de repetições.   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºParametros³ 1 - Acrescenta o sequencial                                º±±
±±º          ³ 2 - Sem o sequencial da BD6.                               º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pl5WhQry(_cParam)
	
	Local _cRet := ""
	
	Default _cParam := "1"
	
	_cRet += " WHERE 																" + CRLF
	_cRet += " 	BD7.BD7_FILIAL = '" + xFilial("BD6") + "'  							" + CRLF
	_cRet += " 	AND BD7.BD7_CODOPE = '" + BD6->BD6_CODOPE + "' 						" + CRLF
	_cRet += " 	AND BD7.BD7_CODLDP = '" + BD6->BD6_CODLDP + "' 						" + CRLF
	_cRet += " 	AND BD7.BD7_CODPEG = '" + BD6->BD6_CODPEG + "' 						" + CRLF
	_cRet += " 	AND BD7.BD7_NUMERO = '" + BD6->BD6_NUMERO + "' 						" + CRLF
	_cRet += " 	AND BD7.BD7_ORIMOV = '" + BD6->BD6_ORIMOV + "' 						" + CRLF
	
	If _cParam = "1"
		
		_cRet += " 	AND BD7.BD7_SEQUEN = '" + BD6->BD6_SEQUEN + "' 					" + CRLF
		
	EndIf
	
Return _cRet