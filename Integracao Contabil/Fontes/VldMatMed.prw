#Include 'TopConn.ch'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldMatMed ºAutor  ³Thiago Machado Correa º Data ³ 17/05/07  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se procedimento eh Material ou Medicamento e se a  º±±
±±º          ³Rda de pagamento recebeu um procedimento.					  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±º          ³Revisão e Padronização para subir ao produto padrão.        º±±
±±º          ³Roger Cangianeli. 										  º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VldMatMed(cCtpl06)	// , cCtpl08, cCtpl09)

Local cCodPad   := BD7->BD7_CODPAD
Local cCodPro   := BD7->BD7_CODPRO
Local cChaGui   := ""
Local aRegBD7   := BD7->(GetArea())
Local lConsulta := .F.
Local cClasse	:= ''
Local cTpProc	:= ''

//If substr(BD7->BD7_CODPRO,1,1) $ cCtpl06+","+cCtpl08+","+cCtpl09

cChaGui := BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV)
BD7->(DbSetOrder(1))
BD7->(MsSeek(xFilial("BD7")+cChaGui))
While BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV)==cChaGui .and. !BD7->(Eof())
	
	If BD7->BD7_BLOPAG <> "1"
		If Select('TRBBR8') > 0
			TRBBR8->(dbCloseArea())
		EndIf
		cSqlBR8	:= "SELECT BR8_CLASSE, BR8_TPPROC FROM "+RetSqlName('BR8')+" WHERE BR8_FILIAL = '"
		cSqlBR8	+= xFilial('BR8')+"' AND BR8_CODPAD = '"+BD7->BD7_CODPAD+"' AND "
		csqlBR8	+= "BR8_CODPSA = '"+BD7->BD7_CODPRO+"' AND D_E_L_E_T_ = ' ' "
		TcQuery cSqlBR8 New Alias 'TRBBR8'
		
		cTpProc	:= TRBBR8->BR8_TPPROC
		cClasse	:= TRBBR8->BR8_CLASSE
		TRBBR8->(dbCloseArea())
		
		// Se não for Mat/Med/Txas
		If !cTpProc $ '1/2/3/4/5/7/8'
			// Se for Consulta
			If Alltrim(BD7->BD7_CODPRO) $ cCtPl06
				lConsulta := .T.
			Else
				cCodPad := BD7->BD7_CODPAD
				cCodPro := BD7->BD7_CODPRO
				lConsulta := .F.
				Exit
			Endif
		Endif
	Endif
	BD7->(DbSkip())
EndDo

//Endif

RestArea(aRegBD7)

Return {cCodPad,cCodPro,lConsulta,cClasse,cTpProc}
