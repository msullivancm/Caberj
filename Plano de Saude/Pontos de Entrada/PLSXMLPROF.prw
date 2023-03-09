/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбддддддддддбдддддддбддддддддддддддддддддддддддддддддбддддддбдддддддддддд©╠╠
╠╠Ё Rdmake    ЁPLSXMLPROFЁ Autor Ё Jean Schulz                    Ё Data Ё 19.07.2007 Ё╠╠
╠╠цдддддддддддеддддддддддадддддддаддддддддддддддддддддддддддддддддаддддддадддддддддддд╢╠╠
╠╠Ё Descri┤└o Ё Rdmake para retorno de profissional de saude (rda,solic ou Execu)	  Ё╠╠
╠╠Ё 		  Ё So entra neste rdmake se nao for informado o cpf ou cnpj			  Ё╠╠
╠╠юдддддддддддаддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
User Function PLSXMLPROF
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variaveis da rotina...                                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL cRet		:= ""
LOCAL cTp       := paramixb[1]
LOCAL cCodigo	:= paramixb[2]  
LOCAL cTipo		:= paramixb[3]  
LOCAL cNumImp	:= paramixb[4]  
LOCAL cOrigem	:= paramixb[5]  
LOCAL nIdx		:= paramixb[6]    
Local aArea		:= GetArea()
Local cLog		:= '[' + cTp + '] - [' + cValToChar(nIdx) + ']'

//зддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁR - Tratamento para codigo da Rda                  Ё
//ЁS - Tratamento para codigo do Solicitante          Ё
//ЁCE - Tratamento para codigo do Executante          Ё
//ЁM - Tratamento para codigo da Matricula do usuario.Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддды

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Procura na base de dados o profissional 								 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Do Case 
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Procura a rda															 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Case cTp == 'R'//Retorno deve ser o Indice 1 da BAU (BAU_CODIGO)
	                    
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Tratar codigo do prestador na operadora, retirando . e - do codigo...    Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

		cCodigo := StrTran(cCodigo,"-","")
		cCodigo := StrTran(cCodigo,".","")

		If nIdx == 1 //Codigo do prestador na operadora 
			
			cCodigo := StrZero(Val(cCodigo),6)
		    
			BAW->( DbSetOrder(2) ) //BAW_FILIAL + BAW_CODINT + BAW_CODIGO //BAW: Operadoras da RDA
			
			If BAW->( MsSeek( xFilial("BAW")+PLSINTPAD()+cCodigo ) )
			   	cRet := BAW->BAW_CODIGO
			EndIf
		
		//CABESP - Reciprocidade envia CNPJ
		ElseIf nIdx == 4 //CPF/CNPJ
        
			BAU->(DbSetOrder(4))//BAU_FILIAL+BAU_CPFCGC
			BAU->(DbGoTop())
			
			If BAU->(MsSeek(xFilial('BAU') + cCodigo))
				cRet := BAU->BAU_CODIGO
			Else
				cRet := cCodigo + ' ( CPF/CNPJ nao encontrado na BAU ' + cLog + ' ) '
			EndIf

		Else
			cRet := cCodigo

		EndIf
	
	Case cTp == 'CE'//Retorno deve ser o Indice 1 da BB0 (BB0_CODIGO)
            
        cCodigo := StrTran(cCodigo,"-","")
		cCodigo := StrTran(cCodigo,".","")
		
		If !empty(cCodigo)	
		
			If nIdx == 1 //1 - Codigo do prestador na operadora 
			
				cCodigo := StrZero(Val(cCodigo),6)
			    cCodBB0 := "" 
	
			    BAU->(DbSetOrder(1))//BAU_FILIAL + BAU_CODIGO                               
	
			    If BAU->(MsSeek(xFilial('BAU') + AllTrim(cCodigo)))
			    	cRet 	:= cCodigo
			    	cCodBB0 := BAU->BAU_CODBB0
	
			    	BB0->(DbSetOrder(1))//BB0_FILIAL + BB0_CODIGO
	
					If BB0->(MsSeek(xFilial('BB0') + cCodBB0))
						cRet := BB0->BB0_CODIGO
					Else
						cRet := AllTrim(cCodigo) + ' (RDA encontrado BAU mas profissional nao encontrado na BB0 - "' + AllTrim(cCodBB0) + '" ' + cLog + ' ) ' 
					EndIf
	
			    Else
			    	cRet 	:= AllTrim(cCodigo) + ' (RDA nao encontrado BAU ' + cLog + ' ) '
			    EndIf
	
			ElseIf nIdx == 4 //4 - CPF/CNPJ
	
		    	//Na busca por CPFs, buscar primeiro na BAU pois existem CPFs duplicados na BB0
			    BAU->(DbSetOrder(4))//BAU_FILIAL+BAU_CPFCGC
				BAU->(DbGoTop())
	
				If BAU->(MsSeek(xFilial('BAU') + cCodigo))
			    	BB0->(DbSetOrder(1))//BB0_FILIAL + BB0_CODIGO
	
					If BB0->(MsSeek(xFilial('BB0') + BAU->BAU_CODBB0))
						cRet := BB0->BB0_CODIGO 
					Else
						cRet := AllTrim(cCodigo) + ' ( RDA encontrado BAU mas profissional nao encontrado na BB0 [ ' + AllTrim(BAU->BAU_CODBB0) + ' ] ' + cLog + ' ) ' 
					EndIf
	
				Else
					BB0->(DbSetOrder(3))//BB0_FILIAL+BB0_CGC
		      		BB0->(DbGoTop())
		      		
					If BB0->(MsSeek(xFilial('BB0') + cCodigo))
						cRet := BB0->BB0_CODIGO								
					Else
						cRet := AllTrim(cCodigo) + ' ( CPF/CNPJ nao encontrado - buscas: [1]BAU [2]BB0 ' + cLog + ' ) '
					EndIf                                 
				EndIf
	
			EndIf
			
		EndIf

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Procura o solicitante													 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Case cTp == 'S'//Retorno deve ser o Indice 1 da BB0 (BB0_CODIGO)

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Tratar codigo do solicitante enviado, retirando . e - do codigo...       Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cCodigo := StrTran(cCodigo,"-","")
		cCodigo := StrTran(cCodigo,".","")

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Tratar codigo do solicitante conforme regras de cadastro da Caberj.      Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		//1-Cod.Prestador na operadora / 3 -CPF/CNPJ
		If nIdx == 1
			If Substr(cCodigo,3,2) == "52" .And. Len(cCodigo)== 13
				cCodigo := Substr(cCodigo,1,2)+"00"+Substr(cCodigo,3)
			Endif

			BB0->( DbSetOrder( 4 ) ) //BB0_FILIAL + BB0_ESTADO + BB0_NUMCR + BB0_CODSIG + BB0_CODOPE
			If BB0->( MsSeek( xFilial("BB0")+cCodigo ) )
			   cRet := BB0->BB0_CODIGO
			EndIf                      
		Endif
		
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Valida matricula do beneficiario									  	 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	Case cTp == 'M'
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Retirar zeros da matricula caso menor que 17 posicoes...			  	 Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If nIdx == 99 //99-sempre sera 99 para matricula usuario.
				If Len(cCodigo) <> 17
					cCodigo := Alltrim(Str(Val(cCodigo)))
				Endif
				If Len(Alltrim(str(val(cCodigo)))) < 14
					cCodigo := Alltrim(Str(Val(cCodigo)))
				Endif
			    cRet := cCodigo
			Endif  
/// altamiro 13/08/2015 -- acerto Profisional de saude em branco , preenchendo com o crm generico caberj 			
/*    Case cTp == 'R'	 
    
          cRet := '0052000000'		     
      */
EndCase 

If empty(cRet)
	cRet := cCodigo
EndIf

RestArea(aArea)

Return cRet
