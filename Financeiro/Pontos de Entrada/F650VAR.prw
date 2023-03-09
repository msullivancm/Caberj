// A técnica foi trocar o conteúdo das variáveis Identificador do Título com o Nosso Número, pois
// no modelo 2 o sistema descarta as linhas sem Identificadores de títulos.

************************
User Function F650VAR()
	************************
	
	Local _aAreaSE1 := GetArea("SE1")
	
	// A linha abaixo é para que o Ponto de Entrada somente funcione com o arquivo 112175.
	// De modo que o P.E. seja descartado para o SISDEB e para o caso de algum usuário utilizar o antigo 112.2rr
	IF UPPER(ALLTRIM(GETMV("MV_XCNABRR"))) != UPPER(ALLTRIM(mv_par02)) .and. !(UPPER(ALLTRIM(mv_par02)) == 'BRADESCO.2RR' .or. UPPER(ALLTRIM(mv_par02)) == 'BRADETST.2RR' )
		Return
	ENDIF
	
	// Obtém o número do Título para os títulos já identificados (112)
	IF Type("cNossoNum") == "U" .Or. cNossoNum == Nil
		cTituloCab := ""
	ELSE
		cTituloCab := cNossoNum
	ENDIF
	
	// Marcela Coimbra - 13/07/2016
	// Acerto de impressão de cnab  pois não estava listando os arquivos sem IDCNAB
	If UPPER(ALLTRIM(mv_par02)) == 'BRADESCO.2RR'
		
		dbSelectArea("SE1")
		DbOrderNickName("SE1NOSNUM")
		If dbSeek( xFilial("SE1") + cNumTit )
			
			//			cAliasCR	:=GetNextAlias()
			//
			//			BEGINSQL ALIAS cAliasCR
			//				SELECT R_E_C_N_O_ RECSE1 FROM SE1010 SE1
			//				WHERE
			//				E1_NUMBCO = %exp:cNumTit%
			//				AND E1_CONTA = '5380'
			//				AND E1_PORTADO = '237'
			//				AND E1_AGEDEP= '3369'
			//				AND SE1.%NOTDEL%
			//			ENDSQL
			//
			//			if (cAliasCR)->(!Eof()) // retirar
			//	dbselectarea("SE1")
			//SE1->(dbgoto((cAliasCR)->RECSE1))
			
			
			
			
			cNossoNum 	:= cNumTit
			
			cNumTit	 	:= SE1->E1_IDCNAB//E1_NUM
			cTipo  		:= SE1->E1_TIPO
			
		Else
			
			dbSelectArea("SE1")
			dbSetOrder(16)
			If !empty(cNossoNum) .and. dbSeek( xFilial("SE1") + cNossoNum )//Leonardo Portella - 15/07/16 - Inclusão do trecho [ !empty(cNossoNum) .and. ]
				
				cNumTit	 	:= SE1->E1_IDCNAB//E1_NUM
				cTipo  		:= SE1->E1_TIPO
				
			Else
				
				cNossoNum 	:= cNumTit //Trecho normalmente feito no ponto de entrada
				
			EndIf
			
		EndIf
		//			IF select(cAliasCR) > 0
		//				dbselectarea(cAliasCR)
		//				dbclosearea()
		//			endif
		
		return
		
	EndIf
	//FIM MBC
	
	// Em qualquer caso, devolvo o valor ao nosso numero
	cNossoNum 	:= cNumTit
	
	// Para os títulos com nosso número preenchido, apenas devolvo o número do título
	If AllTrim(cTituloCab) != ""
		cNumTit 		:= cTituloCab
		Return
	EndIf
	
	// Localiza os títulos sem o nosso número preenchido
	SE1->(DBOrderNickName("SE1NOSNUM"))
	
	IF !SE1->(DbSeek(xfilial("SE1")+cNumTit))
		cNumTit  := cTituloCab
	ELSE
		// Obtém o detalhe do título
		cNumTit 	:= SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA
		cTipo 	:= SE1->E1_TIPO
	ENDIF
	
	//Altedado por Wellington -> pegar descricao do layout do sisdeb quendo o codigo de ocorrencia for igual ao do cnab
	IF Posicione("SEE",1,xFilial("SEE")+mv_par03+mv_par04+mv_par05+mv_par06,"EE_XXTIPO") == "S"
		cDescr := cOcorr + "- " + Subs(SEB->EB_DESCSIS,1,27)
	Endif
	
Return
