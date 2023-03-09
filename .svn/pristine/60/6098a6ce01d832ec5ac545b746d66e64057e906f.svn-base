#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PL974BXX ºAutor ³ Fred O. C. Jr       º Data ³  17/05/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Tratamento de envio fora da janela 					      º±±
±±º          ³    Jogar para a proxima competencia (quando vindo do HAT)  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PL974BXX()

Local aArea			:= GetArea()
Local aAreaBAU		:= BAU->(GetArea())
Local cChave		:= PARAMIXB[1]
Local lCalend		:= GETNEWPAR("MV_XCALENT", .T.)
Local lEnvMail		:= GETNEWPAR("MV_XENEMCA", .T.)
Local cEMAIL		:= ""
Local cHtml			:= "" 
Local dNewDatMov	:= FirstDate(StoD(SubStr(DtoS(PLSDtX58()),1,6)+"15")+30)

if cChave $ "1|2"	// Submissão do XML

	if lCalend

		if AllTrim(BXX->BXX_CODUSR) == "PLS_HAT"	// tratamento exclusivo para XML's do HAT

			if !U_ChecaComp(BXX->BXX_CODRDA,PLSDtX58())		// Se estiver fora do calendário de envio de XML

				// Mudar competencia no XML submetido
				BXX->(RecLock("BXX",.F.))
					BXX->BXX_DATMOV := dNewDatMov
				BXX->(MsUnlock())

				// Buscar se gerou PEG - ajustar competencia para a do mês seguinte
				BCI->(DbSetOrder(1))
				if BCI->(DbSeek(xFilial("BCI") + PLSINTPAD() + "0002" + BXX->BXX_CODPEG))

					BCI->(RecLock("BCI",.F.))
						BCI->BCI_ANO := SubStr(DtoS(dNewDatMov),1,4)
						BCI->BCI_MES := SubStr(DtoS(dNewDatMov),5,2)
					BCI->(MsUnlock())
				
				endif

				if lEnvMail
				
					BAU->(DbSetOrder(1))
					if BAU->(DbSeek(xFilial("BAU") + BXX->BXX_CODRDA))
						cEmail	:= BAU->BAU_EMAIL						// e-mail do Prestador
					endif

					// Se estiver parametrizado para enviar e-mail (parametro) e prestador tem e-mail cadastrado
					// Enviar e-mail o notificando que o XML enviado foi movimentado para a proxima competencia
					if !empty(cEmail)

						cHtml := '<h1><font color="#FF0000"><b>Atenção:</b></font></h1>'
						cHtml += '<br><b>Prezado Prestador, </b>'
						cHtml += '<br><b>Seu Arquivo: <font color="#FF0000"> '+ BXX->BXX_ARQIN
						cHtml += '</font> foi enviado à operadora <font color="GREEN">' + iif(cEmpAnt == '01',"CABERJ","INTEGRAL SAUDE")
						cHtml += '</font> após o prazo do seu calendário de entrega.</b>'
						cHtml += '<br><b>Por este motivo, caso seu arquivo não tenha sido criticado com eventuais erros ou falhas, </b>'
						cHtml += '<br><b>este passará a integrar seu movimento do próximo mês com data de recebimento em: <font color="#FF0000">'+ DtoC(dNewDatMov) +'</font></b>.'
						cHtml += '<br><b>Fique atento ao status de seu arquivo. </b>'

						U_EnvMail(nil, cEmail, 'ENVIO FORA DE CALENDARIO (Mensagem Automática)', cHtml, nil, nil, nil)
					
					endif
				
				endif
			
			endif
		
		endif
	
	endif

endif

RestArea(aAreaBAU)
RestArea(aArea)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ChecaCompºAutor ³                     º Data ³  17/05/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Verificar janela de envio de XML 					      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ChecaComp(pCodRda, _dTmpDtBs)

Local cQryChk		:= " "
Local cAliasQry		:= "CHKCOMP"
Local cGrpPagto		:= ""
Local cAno			:= ""
Local cMes			:= ""
Local cDia			:= ""
Local lRet			:= .T.
Local aAreaBAU		:= BAU->(GetArea())

Default _dTmpDtBs	:= CTOD(" / / ")

If Empty(_dTmpDtBs)
	_dTmpDtBs := dDataBase
EndIf

cAno := SUBS(DTOS(_dTmpDtBs),1,4)
cMes := SUBS(DTOS(_dTmpDtBs),5,2)
cDia := SUBS(DTOS(_dTmpDtBs),7,2)

BAU->(DbSetOrder(1))
If BAU->(DbSeek(xFilial("BAU")+pCodRda))
	cGrpPagto := BAU->BAU_GRPPAG
Endif
RestArea(aAreaBAU)

//Primeira Checagem - Grupo de Pagamento
cQryChk := " SELECT * FROM " + RetSQLName("PCX") + " PCX "
cQryChk += "  WHERE PCX.PCX_FILIAL = '" + xFilial("PCX") + "'"
cQryChk += "    AND PCX.PCX_GRPPGT = '" + cGrpPagto + "'"
cQryChk += "    AND PCX.PCX_ANO = '" + cAno + "'"
cQryChk += "    AND PCX.PCX_MES = '" + cMes + "'"
cQryChk += "    AND '" + cDia +"' BETWEEN PCX.PCX_DATINI AND PCX.PCX_DATFIM "
cQryChk += "    AND D_E_L_E_T_ = ' ' "

If Select(cAliasQry) > 0
	(cAliasQry)->(DbCloseArea())
EndIf

DbUseArea(.T.,"TopConn",TcGenQry(,,cQryChk),cAliasQry,.T.,.T.)

If (cAliasQry)->(EOF())

	// Segunda Checagem - RDA Fora de data
	cQryChk := " SELECT * FROM " + RetSQLName("PCX") + " PCX "
	cQryChk += "  WHERE PCX.PCX_FILIAL = '" + xFilial("PCX") + "'"
	cQryChk += "    AND PCX.PCX_RDA = '" + pCodRda + "'"
	cQryChk += "    AND PCX.PCX_ANO = '" + cAno + "'"
	cQryChk += "    AND PCX.PCX_MES = '" + cMes + "'"
	cQryChk += "    AND '" + cDia +"' BETWEEN PCX.PCX_DATINI AND PCX.PCX_DATFIM "
	cQryChk += "    AND D_E_L_E_T_ = ' ' "

	If Select(cAliasQry) > 0
		(cAliasQry)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TopConn",TcGenQry(,,cQryChk),cAliasQry,.T.,.T.)

	If (cAliasQry)->(EOF())
		lRet := .F.
	Endif

	(cAliasQry)->(DbCloseArea())
Endif

Return lRet
