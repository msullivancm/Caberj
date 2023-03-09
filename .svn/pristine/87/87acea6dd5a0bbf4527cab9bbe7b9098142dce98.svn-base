#include "protheus.ch"
#include "topconn.ch"

#define CRLF chr(13) + chr(10)

/*/{Protheus.doc} PLSGRB53
PE da auditoria

@type user function
@author Gabriel Hegler Klok
@since 2019/05
@version 1.0
/*/
user function PLSGRB53
	local nRecB53 := paramixb[1]
	local aArea 	:= getarea()
	local aAreaBA1 	:= BA1->(getarea())
	local aAreaB72 	:= B72->(getarea())
	local aAreaZZ6 	:= ZZ6->(getarea())
	local aAreaB53 	:= B53->(getarea())
	local cID_Item
	local cID_MSG
	local cAlias 	:= getnextalias()
	local cAliasB72 := getnextalias()
	local cSql
	local cAliQry   := getnextalias()
	Local lAtuXDTLIB := .T.
	Local nMaxDtLib
	Local aAreaBEA 	 := BEA->(getarea())
	
	B53->(dbgoto(nRecB53))
	
	cSql := " SELECT R_E_C_N_O_ RECNO FROM " + retsqlname("B72")
	cSql += " WHERE B72_FILIAL = '" + xfilial("B72") + "'"
	cSql += " 		AND B72_ALIMOV = '" + B53->B53_ALIMOV + "'"
	cSql += " 		AND B72_RECMOV = '" + B53->B53_RECMOV + "'"
	cSql += " 		AND D_E_L_E_T_ = ' ' "
	
//	dbusearea(.t., "TOPCONN", TcGenQry(,, cSql), "cAliasB72", .t., .t.)
	tcquery cSql new alias (cAliasB72)
	
	while ! (cAliasB72)->(eof())
	
		B72->(dbgoto( (cAliasB72)->RECNO ))
		
		if !empty(alltrim(B72->B72_OBSANA))
			
			cMatVid := Posicione('BA1',2,xFilial('BA1') + B53->B53_MATUSU,'BA1_MATVID')
			
			cQry := " SELECT NVL(MAX(R_E_C_N_O_),0) RECNO" + CRLF
			cQry += " FROM " + RetSqlName('ZZ6') + CRLF
			cQry += " WHERE ZZ6_FILIAL = '" + xFilial('ZZ6') + "'" + CRLF
			cQry += "	 AND ZZ6_MATVID = '" + cMatVid + "'" + CRLF
			cQry += "	 AND D_E_L_E_T_ = ' '" + CRLF
			
			tcquery cQry new alias (cAlias)
			
			if ( (cAlias)->RECNO > 0 )
				ZZ6->(dbgoto((cAlias)->RECNO))
				cNextSeq := strzero(Val(ZZ6->ZZ6_SEQ) + 1, 3)
			else
				cNextSeq := strZero(1, 3)
			endIf
			
			if select(cAlias) > 0
				dbselectarea(cAlias)
				(cAlias)->(dbclosearea())
			endif
			
			restarea(aArea)
			
			if B53->B53_ALIMOV == 'BEA'
				BEA->(dbgoto(Val(B53->B53_RECMOV)))
				c_Senha := BEA->BEA_SENHA
				
				//U_PLS790GR()
				
			else
				
				BE4->(dbgoto(val(B53->B53_RECMOV)))
				if type("x_senha") == "C"
					if !empty(x_senha)
						if x_senha # BE4->BE4_SENHA
							
							reclock("BE4")
							BE4->BE4_SENHA := x_senha
							BE4->(msunlock())
							
						endif
					endif
				endif
				
				c_Senha := BE4->BE4_SENHA
				
			endif
			
			U_PLS790GR()
			
			ZZ6->(reclock("ZZ6", .T.))
			
			ZZ6->ZZ6_FILIAL := xfilial("ZZ6")
			
			ZZ6->ZZ6_SEQ	:= cNextSeq
			ZZ6->ZZ6_DATA  	:= date()
			ZZ6->ZZ6_HORA  	:= left(replace(time(),':',''),4)
			ZZ6->ZZ6_CODOPE := B53->B53_CODOPE
			ZZ6->ZZ6_ANOGUI := substr(B53->B53_NUMGUI,5,4)
			ZZ6->ZZ6_MESGUI := substr(B53->B53_NUMGUI,9,2)
			ZZ6->ZZ6_NUMGUI := substr(B53->B53_NUMGUI,11,8)
			ZZ6->ZZ6_MATVID := cMatVid
			ZZ6->ZZ6_ALIAS 	:= B53->B53_ALIMOV
			ZZ6->ZZ6_SENHA 	:= c_Senha
			ZZ6->ZZ6_USU	:= "4" //Auditor
			ZZ6->ZZ6_NOMUSR	:= B53->B53_NOMUSR
			ZZ6->ZZ6_OPER	:= upper(alltrim(usrfullname(retcodusr())))
			ZZ6->ZZ6_TEXT1	:= "PARECER DO AUDITOR"
			ZZ6->ZZ6_TEXTO 	:= 'AUDITORIA [ ' + B53->B53_NUMGUI + ' ] ' 														    	+ ;
				'EVENTO [ ' + B72->B72_CODPAD + ' - ' + alltrim(B72->B72_CODPRO) + ' - ' 													+ ;
				upper(alltrim(posicione('BR8',1,xfilial('BR8') + B72->B72_CODPAD + B72->B72_CODPRO,'BR8_DESCRI'))) + ' ]'  + CRLF + CRLF 	+ ;
				alltrim(B72->B72_OBSANA)
			
			ZZ6->(msunlock())
			
			B72->(reclock('B72',.F.))
			
			B72->B72_OBSANA := ' '
			
			B72->(msunlock())
			
			//hml alto custo inicio
			if ( B53->B53_XIDAUT > 0 ) .And. B72->B72_PARECE == "2"
				
				//Envio da mensagem para a Operativa
				
				cQry := "SELECT ID_ITEM"																				+ CRLF
				cQry += "FROM OPERATIVA.AUT_PROCEDIMENTOS_ITENS"														+ CRLF
				cQry += "WHERE ID_AUT = " + cvaltochar(B53->B53_XIDAUT)  												+ CRLF
				cQry += "	AND TISS_TABELA_REFERENCIA = '" + if(B72->B72_CODPAD == '16','22',B72->B72_CODPAD) + "'"	+ CRLF
				cQry += "	AND TISS_CODIGO_PROC = '" + alltrim(B72->B72_CODPRO)	+ "'"								+ CRLF
				
				tcquery cQry new alias (cAlias)
				
				if !(cAlias)->(eof())
					cID_Item := cvaltochar((cAlias)->ID_ITEM)
				else
					msgstop('Erro - mensagem não será enviada para a Operativa. Não localizou o item.', alltrim(SM0->M0_NOMECOM))
				endif
				
				if select(cAlias) > 0
					dbselectarea(cAlias)
					(cAlias)->(dbclosearea())
				endif
				
				cQry := "SELECT NVL(MAX(ID_ITEM),0) + 1 ID_MSG"				+ CRLF
				cQry += "FROM OPERATIVA.AUT_PROCEDIMENTOS_MSG"				+ CRLF
				cQry += "WHERE ID_AUT = " + cvaltochar(B53->B53_XIDAUT)		+ CRLF
				cQry += "	AND ID_ITEM = " + cID_Item 						+ CRLF
				
				tcquery cQry new alias (cAlias)
				
				if !(cAlias)->(eof())
					cID_MSG := cvaltochar((cAlias)->ID_MSG)
				else
					msgstop('Erro - mensagem não será enviada para a Operativa. Não localizou msg.', alltrim(SM0->M0_NOMECOM))
				endif
				
				if select(cAlias) > 0
					dbselectarea(cAlias)
					(cAlias)->(dbclosearea())
				endif
				
				
				restarea(aArea)
				
				if !empty(cID_Item)
					
					//TISS_STATUS_SOLIC = 5 - AGUARDANDO DOCUMENTACAO DO PRESTADOR
					
					cScript := "BEGIN" 																								+ CRLF
					cScript += " "	 																								+ CRLF
					cScript += "INSERT INTO OPERATIVA.AUT_PROCEDIMENTOS_MSG ( ID_AUT, ID_ITEM, ID_MSG, ORIGEM, MENSAGEM ) VALUES " 	+ CRLF
					cScript += "( " 																								+ CRLF
					cScript += cvaltochar(B53->B53_XIDAUT) + ','																	+ CRLF
					cScript += cID_Item + ","																						+ CRLF
					cScript += cID_MSG + ","																						+ CRLF
					cScript += "'CAB',"																								+ CRLF
					cScript += "UTL_RAW.CAST_TO_RAW('" + alltrim(ZZ6->ZZ6_TEXTO) + "')"												+ CRLF
					cScript += ");" 																								+ CRLF
					cScript += " "	 																								+ CRLF
					cScript += "UPDATE OPERATIVA.AUT_PROCEDIMENTOS SET TISS_STATUS_SOLIC = '5'"										+ CRLF
					cScript += "WHERE ID_AUT = " + cvaltochar(B53->B53_XIDAUT) + ";"												+ CRLF
					cScript += " "	 																								+ CRLF
					cScript += "LIBERA.ENVIA_OPERATIVA(" + cvaltochar(B53->B53_XIDAUT) + "," + cID_Item + "," + cID_MSG + ");"		+ CRLF
					cScript += " "	 																								+ CRLF
					cScript += "END;" 																								+ CRLF
					
					if tcsqlexec(cScript) < 0
						logerros('Erro ao inserir mensagem na tabela [ OPERATIVA.AUT_PROCEDIMENTOS_MSG ]. ID_AUT [ ' + cvaltochar(B53->B53_XIDAUT) + ' ], ID_ITEM [ ' + cID_Item + ' ], ID_MSG (novo) [ ' + cID_MSG + ' ]: ' + CRLF + tcsqlerror())
					endif
					
				endif
				
			endif
			//hml alto custo fim
			
		endif

		//FABIO BIANCHINI - 08/04/2021 - CHAMADO ID.: 69993
		//Trecho incluido por causa da desativação da rotina CABA604, chamada 
		//pelo PE PLS090M1, por solicitação da Dra. Evelyn
		//A Data de Liberação será preenchida no Libera Após a Auditoria
		If B72->B72_PARECE == '2'
			lAtuXDTLIB := .F.
		else
			If Empty(nMaxDtLib)
				nMaxDtLib := B72->B72_DATMOV 
			ElseIf nMaxDtLib < B72->B72_DATMOV 
				nMaxDtLib := B72->B72_DATMOV 
			Endif
		endif

		(cAliasB72)->(dbskip())

	enddo
	
	(cAliasB72)->(dbclosearea())

	//FABIO BIANCHINI - 08/04/2021 - CHAMADO ID.: 69993
	//Trecho incluido por causa da desativação da rotina CABA604, chamada 
	//pelo PE PLS090M1, por solicitação da Dra. Evelyn
	//A Data de Liberação será preenchida no Libera Após a Auditoria
	If lAtuXDTLIB .and. B72->B72_ALIMOV == "BEA"
		DbSelectArea("BEA")
		BEA->(DbGoTo(Val(B72->B72_RECMOV)))
		Reclock("BEA", .F.)
			
		BEA->BEA_XDTPR	:= nMaxDtLib
		BEA->BEA_XDTLIB := nMaxDtLib
			
		BEA->(MsUnlock())
	Endif

	/*
	If B53->B53_STATUS != "1"
			
		//-----------------------------------------------------
		//Varrer se ainda existem itens na B53 E b72 para serem
		//analisados.
		//se todos estiveres autorizados realizo a alteração
		//do status na internnação, pois o padrão NÃO está atualizando B53
		//quando se coloca em análise para auditar depois.
		//-----------------------------------------------------
	
		cQry := " SELECT * FROM " + RetSqlName("B72") + " A "
		cQry += "  WHERE A.B72_FILIAL = '" + xFilial("B72") + "'"
		cQry += "    AND A.D_E_L_E_T_ = ' ' "
		cQry += "    AND A.B72_RECMOV = '" + ALLTRIM(B53->B53_RECMOV) + "'"
		cQry += "    AND A.B72_PARECE <> '0' "
		cQry += "    AND NOT EXISTS (SELECT 1 FROM " + RetSqlName('B72') + " X "
		cQry += "                     WHERE X.B72_FILIAL = '" + xFilial('B72') + "'"
		cQry += "                       AND X.D_E_L_E_T_ = ' ' "
		cQry += "                       AND X.B72_PARECE = '0' "
		cQry += "                       AND A.B72_ALIMOV = X.B72_ALIMOV "
		cQry += "                       AND A.B72_RECMOV = X.B72_RECMOV "
		cQry += "                       AND A.B72_SEQPRO = X.B72_SEQPRO "
		cQry += "                       AND A.B72_CODPAD = X.B72_CODPAD "
		cQry += "                       AND A.B72_CODPRO = X.B72_CODPRO "
		cQry += "                       AND A.B72_CODGLO = X.B72_CODGLO) "
	
		TcQuery cQry New Alias (cAliQry)
		
		If (cAliQry)->(EOF())
			
			RecLock("B53", .F.)
			B53->B53_OPERAD := " "
			B53->B53_STATUS := "1" //AUTORIZADA
			B53->B53_SITUAC := '1' 
			
			B53->(MsUnLock())
			
		EndIf
		
		(cAliQry)->(DbCloseArea())
			
	EndIf
	*/
	

	

	BEA->(restarea(aAreaBEA))
	B53->(restarea(aAreaB53))
	BA1->(restarea(aAreaBA1))
	B72->(restarea(aAreaB72))
	ZZ6->(restarea(aAreaZZ6))
	restarea(aArea)
	
return
