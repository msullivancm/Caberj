#INCLUDE 'RWMAKE.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'UTILIDADES.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS720FIM ºAutor  ³Renato Peixoto      º Data ³  13/04/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de Entrada para zerar os valores de coparticipação   º±±
±±º          ³ no momento da analise da glosa quando a empresa for 0004.  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS720FIM

Local cCodOpe    := BD5->BD5_CODOPE
Local cCodLdp    := BD5->BD5_CODLDP
Local cCodPeg    := BD5->BD5_CODPEG
Local cNumero    := BD5->BD5_NUMERO 
Local cCodEmp    := ""

//Variáveis declaradas em 27/05/11. Renato Peixoto
Local nVlTADBD5 := 0
Local nVlCopBD5 := 0
Local lCopOPME  := .F.  
Local cProOPME  := GetMv("MV_XPROOPM")
Local cQuery    := ""  
Local cAliasQry := GetNextAlias()

TRY
	//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Type('BE4_CODLDP') == 'C'//BE4_CODLDP == "0000"
	Return
CATCH
	cCodEmp := BD5->BD5_CODEMP
ENDCATCH
	
//alterar aqui tb para só zerar coparticipacao se o procedimento na bd6 for diferente de medicamentos participacao e material participacao
//Só vai entrar se existir BD5 para a guia em questão
If cCodEmp <> NIL .and. cEmpAnt = "01" /*.and. cCodEmp == "0004"*/ .AND. BD5->BD5_CODLDP = "0013"
	//Ponteiro na BD6
	DbSelectArea("BD6")
	DbSetOrder(2)
	If DbSeek(XFILIAL("BD6")+BD5->BD5_CODOPE+BD5->BD5_CODLDP+BD5->BD5_CODPEG+BD5->BD5_NUMERO)
		//Só vai entrar se estiver logado na Caberj, a empresa for 0004 e o local de digitação for 0013 (OPME)
		//If cEmpAnt = "01" .AND. BD5_CODEMP = "0004" .AND. BD5_CODLDP = "0013"
		While !BD6->(Eof()) .AND. BD6->BD6_CODOPE+BD6->BD6_CODLDP+BD6->BD6_CODPEG+BD6->BD6_NUMERO = BD5->BD5_CODOPE+BD5->BD5_CODLDP+BD5->BD5_CODPEG+BD5->BD5_NUMERO
			
			If (AllTrim(BD6->BD6_CODPRO) $(cProOPME))//se for um dos codigos especificados no parametro, nao posso deixar zerar a coparticipacao
				BD6->(DbSkip())
				Loop
			EndIf
			
			//If cEmpAnt = "01"  .AND. BD6->BD6_CODLDP = "0013"  .AND. BD6->BD6_CODPAD = "06" .AND. !(AllTrim(BD6->BD6_CODPRO) $(cProOPME))
		
			lCopOPME := .T.
			//verifico o valor total de coparticipação, verificando aqueles procedimentos que devem ter coparticipação (Medicamentos Participação e Material Participação)
			cQuery := "SELECT SUM(BD6_VLRTPF) VLCOP FROM "+RetSqlName("BD6")+ " BD6 "
			cQuery += "WHERE D_E_L_E_T_ = ' ' "
			cQuery += "AND BD6_FILIAL = '  ' "
			cQuery += "AND BD6_CODOPE = '"+BD6->BD6_CODOPE+"' "
			cQuery += "AND BD6_CODLDP = '"+BD6->BD6_CODLDP+"' "
			cQuery += "AND BD6_CODPEG = '"+BD6->BD6_CODPEG+"' "
			cQuery += "AND BD6_NUMERO = '"+BD6->BD6_NUMERO+"' "
			cQuery += "AND BD6_CODPAD = '06' "//Código da tabela padrao no OPME
			cQuery += "AND BD6_CODPRO IN ("+cProOPME+") " 
		
			If Select(cAliasQry)>0
				(cAliasQry)->(DbCloseArea())
			EndIf
			
			DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
		
			DbSelectArea(cAliasQry)
		
			If !((cAliasQry)->(Eof()))
		
				nVlCopBD5 := (cAliasQry)->VLCOP
			
			EndIf
		
			//Limpo os campos de coparticipação na BD5
			RecLock("BD5",.F.)
			BD5->BD5_VLRBPF := 0
			BD5->BD5_VLRPF  := 0
			//DbSelectArea("BD6")
			//DbSetOrder(2)
			//If DbSeek(XFILIAL("BD6")+BD5->BD5_CODOPE+BD5->BD5_CODLDP+BD5->BD5_CODPEG+BD5->BD5_NUMERO)
			BD5->BD5_VLRTPF := BD6->BD6_VLRTAD
			//EndIf
			BD5->(MsUnlock())
			//Limpo os campos de coparticipação na BD6
			//DbSelectArea("BD6")
			//DbSetOrder(2)
			//If DbSeek(XFILIAL("BD6")+BD5->BD5_CODOPE+BD5->BD5_CODLDP+BD5->BD5_CODPEG+BD5->BD5_NUMERO)//BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO+ BD6_ORIMOV + BD6_SITUAC + BD6_FASE + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO                      
			//While !(BD6->(Eof())) .AND. (BD6->BD6_CODOPE+BD6->BD6_CODLDP+BD6->BD6_CODPEG+BD6->BD6_NUMERO = cCodOpe+cCodLdp+cCodPeg+cNumero)
			RecLock("BD6",.F.)
			BD6->BD6_VLRBPF := 0
			BD6->BD6_VLRPF  := 0
			BD6->BD6_PERCOP := 0
			BD6->BD6_VLRTPF := BD6->BD6_VLRTAD  //verificar se o valor da taxa vai aparecer no relatório de compra material/medicamento (OPME)
			BD6->(MsUnlock())                   
			//BD6->(DbSkip())
			//	EndDo
			//EndIf
		
			//Limpo os campos de coparticipação na BD7
			/*
			cQuery2 := "UPDATE "+RetSqlName("BD7")+" BD7 "
			cQuery2 += "SET BD7_VLRTPF = 0, BD7_COEFPF = 0, BD7_PERPF = 0, BD7_VLRBPF = 0 "
			cQuery2 += "WHERE D_E_L_E_T_ = ' ' AND BD7_FILIAL = '"+XFILIAL("BD7")+"' AND BD7_CODOPE = '"+BD6->BD6_CODOPE+"' AND BD7_CODLDP = '"+BD6->BD6_CODLDP+"' "
			cQuery2 += "AND BD7_CODPEG = '"+BD6->BD6_CODPEG+"' AND BD7_NUMERO = '"+BD6->BD6_NUMERO+"' "
			cQuery2 += "AND BD7_CODPAD = '06' AND BD7_CODPRO = '"+BD6->BD6_CODPRO+"' "
			
			If TcSqlExec(cQuery) < 0
				APMSGINFO("Atenção, houve um erro ao retirar a coparticipação da tabela BD7. Favor entrar em contato com a informática.","Erro ao limpar coparticipação OPME.")
			EndIf */
			DbSelectArea("BD7")
			DbSetOrder(2)
			If DbSeek(XFILIAL("BD7")+BD6->BD6_CODOPE+BD6->BD6_CODLDP+BD6->BD6_CODPEG+BD6->BD6_NUMERO)
				While !(BD7->(Eof())) .AND. (BD7->BD7_CODOPE+BD7->BD7_CODLDP+BD7->BD7_CODPEG+BD7->BD7_NUMERO = cCodOpe+cCodLdp+cCodPeg+cNumero)
					If BD7->BD7_CODPRO <> BD6->BD6_CODPRO
						BD7->(DbSkip())
						Loop
					EndIf
					RecLock("BD7",.F.)
					BD7->BD7_VLRTPF := BD7->BD7_VLRTAD
					BD7->BD7_COEFPF := 0
					BD7->BD7_PERPF  := 0
					BD7->BD7_VLRBPF := 0
					BD7->(MsUnlock()) 
					BD7->(DbSKip())
				EndDo
			EndIf
    	   
    		BD6->(DbSKip())
    		
    	EndDo
		
			If lCopOPME
				BD5->(RecLock("BD5",.F.))
				BD5->BD5_VLRBPF := nVlCopBD5
				BD5->BD5_VLRPF  := nVlCopBD5
				BD5->BD5_VLRTPF := nVlCopBD5
				BD5->(MsUnlock())                 
			EndIf
		
		
	EndIf
EndIf



Return