#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "topconn.Ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV063  º Autor ³ Frederico O. C. Jr º Data ³  18/11/2022 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Validar procedimento no reembolso (não incluir duplicado) º±±
±±º          ³ 														      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABV063

Local aArea			:= GetArea()
Local lRet			:= .T.
Local cMatric		:= iif(!empty(M->B1N_MATRIC), M->B1N_MATRIC, M->BOW_USUARI)
Local cCodPad		:= AllTrim(M->B1N_CODPAD)
Local cCodPro		:= AllTrim(M->B1N_CODPRO)
Local dDatPro		:= iif(!empty(M->B1N_DATPRO), M->B1N_DATPRO, M->BOW_XDTEVE)
Local cNextAlias	:= GetNextAlias()
Local cQuery		:= ""

if !empty(cMatric) .and. !empty(cCodPad) .and. !empty(cCodPro) .and. !empty(dDatPro)

	cQuery := " select B44_YCDPTC, B44_PROTOC"
	cQuery += " from " + RetSqlName("B44") + " B44"
	cQuery +=	" inner join " + RetSqlName("B45") + " B45"
	cQuery +=	  " on (    B44_FILIAL = B45_FILIAL"
	cQuery +=		  " and B44_OPEMOV = B45_OPEMOV"
	cQuery +=		  " and B44_ANOAUT = B45_ANOAUT"
	cQuery +=		  " and B44_MESAUT = B45_MESAUT"
	cQuery +=		  " and B44_NUMAUT = B45_NUMAUT)"
	cQuery += " where B44.D_E_L_E_T_ = ' ' and B45.D_E_L_E_T_ = ' '"
	cQuery +=	" and B44_FILIAL = '" +    xFilial("B44")    + "'"
	cQuery +=	" and B44_OPEUSR = '" + SubStr(cMatric, 1,4) + "'"
	cQuery +=	" and B44_CODEMP = '" + SubStr(cMatric, 5,4) + "'"
	cQuery +=	" and B44_MATRIC = '" + SubStr(cMatric, 9,6) + "'"
	cQuery +=	" and B44_TIPREG = '" + SubStr(cMatric,15,2) + "'"
	cQuery +=	" and B45_CODPAD = '" +        cCodPad       + "'"
	cQuery +=	" and B45_CODPRO = '" +        cCodPro       + "'"
	cQuery +=	" and B45_DATPRO = '" +     DtoS(dDatPro)    + "'"
	cQuery +=	" and B44_STATUS <> '3'"							// Nao Autorizada
	cQuery +=	" and (B45_STATUS <> '0' or B45_AUDITO = '1')"		// Nao Autorizada (mas sem estar pendente na auditoria)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cNextAlias,.T.,.T.)

	if !(cNextAlias)->(EOF())

		if !empty((cNextAlias)->B44_YCDPTC) .or. !empty((cNextAlias)->B44_PROTOC)

			lRet := MsgYesNo("O procedimento " + AllTrim(Posicione('BR8',1,xFilial('BR8')+cCodPad+cCodPro,'BR8_DESCRI'))					+;
								" já foi solicitado reembolso para este beneficiário nesta data."						+ CHR(10)+ CHR(13)	+;
								"Reembolso: " + (cNextAlias)->B44_YCDPTC												+ CHR(10)+ CHR(13)	+;
								"Protocolo: " + (cNextAlias)->B44_PROTOC												+ CHR(10)+ CHR(13)	+;
								"Deseja forçar o reembolso do mesmo?")
			
		endif

	endif
	
	(cNextAlias)->(dbCloseArea())

endif

RestArea(aArea)

return lRet
