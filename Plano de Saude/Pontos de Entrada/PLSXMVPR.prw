#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Rdmake    ³PLSXMVPR  ³ Autor ³ Jean Schulz     		          ³ Data ³ 14.11.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡„o ³ Rdmake para modificar o aDados e aItens conforme necessidade do       ³±±
±±³ 	      ³ cliente.                                                     		  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSXMVPR 

Local nFor := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local _aDados	:= paramixb[1]
Local _aItens	:= paramixb[2]
Local _lImpXml	:= paramixb[3]
Local _cTipoGrv	:= paramixb[4]
Local _cCdPfSo	:= PLSRETDAD( _aDados,"CDPFSO","003383")
Local _cCodEsp	:= PLSRETDAD( _aDados,"CODESP","")      
Local _cCodRDA  := PLSRETDAD( _aDados,"CODRDA","")
Local c_RDAOri 	:= PLSRETDAD(_aDados,"RDAORI","")
Local _nPos		:= 0
Local aAreaBD7	:= BD7->(GetArea())
Local aAreaBE4	:= BE4->(GetArea())
Local aAreaBB0	:= BB0->(GetArea())
Local aAreaBAX	:= BAX->(GetArea())
Local aAreaBEA	:= BEA->(GetArea())
Local aAreaBE2	:= BE2->(GetArea())
Local nPos      := 0 

VincProtPEG()//Leonardo Portella - 08/12/16 - Vínculo entre Protocolo de entrega e PEG

//Leonardo Portella - 24/02/14 - Inicio 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quando a guia for de resumo de internacao ( TIPGUI = '05' ), devera ³
//³buscar o codigo do profissional solicitante da guia de solicitacao  ³
//³( TIPGUI = '03' ), a menos que venha informado na GRI.              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If ( PLSRETDAD( _aDados,"TIPGUI","") == '05' ) .and. ( empty(_cCdPfSo) .or. ( _cCdPfSo == "003383" ) )
	_cCdPfSo := U_GetSolic(PLSRETDAD(_aDados,"NUMSOL","003383"),_cCdPfSo)
EndIf       

//Leonardo Portella - 24/02/14 - Fim
            
//Leonardo Portella - 05/06/13 - Inicio 
//Nunca devera pagar para outro prestador que nao seja o prestador original  

If !empty(c_RDAOri) .and. ( _cCodRDA <> c_RDAOri ) 
	n_PosAjuste := aScan(_aDados,{|x| x[1] == "CODRDA"})
	If(n_PosAjuste > 0,_aDados[n_PosAjuste][2] := c_RDAOri,)
	
	n_PosAjuste := aScan(_aDados,{|x| x[1] == "NOMRDA"})  
	If(n_PosAjuste > 0,_aDados[n_PosAjuste][2] := PLSRETDAD( _aDados,"ORINME",""),)
	
	n_PosAjuste := aScan(_aDados,{|x| x[1] == "TPCRDA"})  
	If(n_PosAjuste > 0,_aDados[n_PosAjuste][2] := PLSRETDAD( _aDados,"ORITPE",""),)	
	
	n_PosAjuste := aScan(_aDados,{|x| x[1] == "CCRDA"})  
	If(n_PosAjuste > 0,_aDados[n_PosAjuste][2] := PLSRETDAD( _aDados,"ORIDOC",""),)
EndIf
//Leonardo Portella - 05/06/13 - Fim


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Conforme regra definida por sr. Jose Paulo em 13/11/07, importar arquivo ³
//³ TISS mesmo que solicitante nao encontrado. Importar como generico.       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
If _cCdPfSo == "003383"
	aadd(_aDados, {"OPESOL",PLSINTPAD()})
	aadd(_aDados, {"CDPFSO","003383"})
Else

	BB0->(DbSetOrder(1))
	If !BB0->(MsSeek(xFilial("BB0")+_cCdPfSo))
	
		_nPos := Ascan(_aDados,{ |x| AllTrim( x[1] ) == AllTrim( "CDPFSO" ) } )	
		If _nPos > 0
			_aDados[_nPos,2] := "003383"
		Endif
		
	//Leonardo Portella - 01/08/13 - Inicio
		
	Else
    
		//Alteracao do codigo da BB0 (Prof. Saude) pegando com mesma sigla, numcr e estado mas que nao esteja bloqueado na data do procedimento
		
		dRealProc := PLSRETDAD( _aDados,"DATPRO",StoD(""))
		
		//Se tiver sido bloqueado antes da realizacao do procedimento
		If !empty(BB0->BB0_DATBLO) .and. ( BB0->BB0_DATBLO < dRealProc) .and. ( PLSRETDAD(_aDados,'TIPO',' ') <> '1' ) //nao eh Consulta
		    
			a__Area 	:= GetArea()
			
			c__Alias 	:= GetNextAlias()
			
			c_Qry := "SELECT BB0_CODSIG,BB0_ESTADO,BB0_CODIGO" 									+ CRLF 
			c_Qry += "FROM " + RetSqlName('BB0') 												+ CRLF 
			c_Qry += "WHERE BB0_FILIAL = '" + xFilial('BB0') + "'" 								+ CRLF 
			c_Qry += "   AND BB0_CODSIG = '" + BB0->BB0_CODSIG + "'" 							+ CRLF  
			c_Qry += "   AND BB0_NUMCR = '" + BB0->BB0_NUMCR + "'" 								+ CRLF  
			c_Qry += "   AND BB0_ESTADO = '" + BB0->BB0_ESTADO + "'" 							+ CRLF  
			c_Qry += "   AND ( BB0_DATBLO = ' ' OR BB0_DATBLO >= '" + DtoS(dRealProc) + "' )" 	+ CRLF  
			c_Qry += "   AND D_E_L_E_T_ = ' '" 													+ CRLF  
			c_Qry += "ORDER BY BB0_CODSIG,BB0_ESTADO,BB0_CODIGO" 								+ CRLF  
			
			TcQuery c_Qry New Alias c__Alias 
			
			If !c__Alias->(EOF())
			   
				_nPos := aScan(_aDados,{ |x| AllTrim( x[1] ) == AllTrim( "CDPFSO" ) } )	
	
				If _nPos > 0
					_aDados[_nPos,2] := c__Alias->BB0_CODIGO
				Else
					aAdd(_aDados, {"OPESOL",PLSINTPAD()})
					aAdd(_aDados, {"CDPFSO",c__Alias->BB0_CODIGO})
				EndIf
				
			EndIf
			
			
			
			c__Alias->(DbCloseArea())
			
			RestArea(a__Area)
		
		EndIf
			
		//Leonardo Portella - 01/08/13 - Fim
	
	EndIf

Endif  

//Leonardo Portella - 02/04/12 - Inicio
//CRM solicitante devera ser o mesmo do executante em guias de consulta

If PLSRETDAD(_aDados,'TIPO',' ') == '1' //Consulta
    
    If ( nPosExec := aScan(_aDados,{|x|AllTrim(x[1]) == AllTrim("CDPFEX")}) ) > 0 
		If ( nPosSol := aScan(_aDados,{|x|AllTrim(x[1]) == AllTrim("CDPFSO")}) ) > 0
			_aDados[nPosSol][2] := _aDados[nPosExec][2]
			If ( nPosOpeSol := aScan(_aDados,{|x|AllTrim(x[1]) == AllTrim("OPESOL")}) ) > 0
				_aDados[nPosOpeSol][2] := PLSINTPAD()
			Else	
				aAdd(_aDados, {"OPESOL",PLSINTPAD()})
			EndIf
		Else
			aAdd(_aDados, {"OPESOL",PLSINTPAD()})
			aAdd(_aDados, {"CDPFSO",_aDados[nPosExec][2]})				
		EndIf
	EndIf	

EndIf  

//Leonardo Portella - 02/04/12 - Fim

//Leonardo Portella - 29/10/13 - Inicio
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³O numero impresso apresentava critica na importacao pois prestadores haviam enviado com o numero impresso deles mesmo como se fossem da Caberj, gerando erro³
//³nos prestadores que estao enviando corretamente hoje.                                                                                                       ³
//³Validacao de acordo com a validacao do padrao (trecho retirado do PLSXMOV) para so fazer intervencao quando cair na critica do padrao                       ³
//³Pontos de entrada PLNIMPXML e PLSVLDIM nao funcionam na importacao TISS desta versao/rpo.                                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//³Criterio para buscar somente dentro do prazo de 1 ano, conforme definido por Joana, Agda e Marcia (vide chamado ID 8538).                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o numero do impresso ja foi utilizado       				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cNumImp := PLSRETDAD( _aDados,"NUMIMP","" )

If _lImpXml
    If !Empty(_cNumImp)    
        lSaldo := .F. //Reinicializa variavel de Saldo
        DbSelectArea("BEA")
	    BEA->( DbSetOrder(9) ) //BEA_FILIAL + BEA_NUMIMP
	    If BEA->( MsSeek( xFilial("BEA")+_cNumImp ))
	        While Alltrim(BEA->BEA_NUMIMP) == _cNumImp .And. !BEA->( Eof())
                //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                //³ Verifica se e o impresso e de uma Rda ja utilizada                		 ³
                //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                If BEA->BEA_CODRDA == Alltrim(_cCodRDA)  
                    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                    //³ Verifica se ha saldo a ser baixado na solicitacao encontrada     		 ³
                    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	                DbSelectArea("BE2") 
                    BE2->(DbSetOrder(6))//BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+BE2_CODPAD+BE2_CODPRO
                    For nFor := 1 to Len(_aItens)  
                    	If BE2->(MsSeek(xFilial("BE2")+_cNumImp+Alltrim(PLSRETDAD(_aItens[nFor],"CODPAD")+PLSRETDAD(_aItens[nFor],"CODPRO")))) .And. BE2->BE2_SALDO > 0
                           lSaldo:= .T.
                        EndIf                   		
                    Next
                    If !lSaldo //Se nao houver saldo para baixar, o sistema critica a guia
                    	If BEA->BEA_DTDIGI < ( MsDate() - ( GetNewPar("MV_XMESIMP",12) * 30 ) ) //Verifica se a data do impresso eh menor que o parametrizado
	                    	BEA->(Reclock('BEA',.F.))
	                    	BEA->BEA_NUMIMP := Left('OLD' + _cNumImp,TamSx3('BEA_NUMIMP')[1])
	                    	BEA->(MsUnlock())
	                    EndIf
	                    //lContinua := .F.                                      
                        Exit
	                EndIf    
	            EndIf 
		        BEA->(DbSkip())	     
	       	EndDo
        EndIf     
    EndIf    
EndIf

//Leonardo Portella - 29/10/13 - Fim

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratar especialidade do RDA caso nao CBO informada nao seja coerente ao  ³
//³ cadastro do RDA (campo opcional nao deve ser alimentado se incorreto) -  ³
//³ regra definida pelo cliente.                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
If !Empty(_cCodEsp)
	BAX->(DbSetOrder(3))
	If !BAX->(MsSeek(xFilial("BAX")+PLSINTPAD()+_cCodEsp+_cCodRDA))
		_nPos := Ascan(_aDados,{ |x| AllTrim( x[1] ) == "CODESP" } )	
		If _nPos > 0
			_aDados[_nPos,2] := ""
		Endif
    Endif
Endif

lImpXML	:= PLSRETDAD(_aDados,'IMPXML',.F.)

If lImpXML .and. ( PLSRETDAD(_aDados,'TIPO',' ') == '3' ) .and. !BE4->(EOF())//Importacao Internacao
    
	cCodPEG		:= PLSRETDAD(_aDados,'NUMPEG',' ')
	cTipFat		:= PLSRETDAD(_aDados,'TIPFAT',' ')
	lResInt		:= PLSRETDAD(_aDados,'RESINT',.F.)
	dDtProc		:= PLSRETDAD(_aDados,'DATPRO',CtoD(''))
	cHrProc		:= PLSRETDAD(_aDados,'HORAPRO',' ')
	dDtAlta		:= PLSRETDAD(_aDados,'DTALTA',CtoD(''))
	cHrAlta		:= PLSRETDAD(_aDados,'HRALTA',' ')
	cCODRDA 	:= PLSRETDAD(_aDados,'CODRDA',' ')
	cNOMRDA		:= PLSRETDAD(_aDados,'NOMRDA',' ')
	aUnMed     	:= PLSRETDAD(_aDados,"AUNMED",{} )
	
	If ValType(aUnMed) <> 'A' .or. empty(aUnMed)
		aUnMed     := PLSXBKC()
	EndIf 
	
	//Honorarios do instrumentador - BD7
	aAdd(aUnMed,{'INSO','O'})  
	
	nPosUnMed := aScan(_aDados,{|x|AllTrim(x[1]) == "AUNMED"})	
	
	If ( nPosUnMed == 0 )
		aAdd(_aDados,{'AUNMED',aUnMed})
	Else
		_aDados[nPosUnMed][2] := aUnMed	
	EndIf 	
	
	//Leonardo Portella - 05/11/13 - Inicio - Virada P11 - Importacao no local 0016 nao sera utilizada
    /*
	
	//Se a fatura eh parcial nao deveria ter data de alta
	If !empty(dDtAlta) .and. (cTipFat == 'P')
		nPosDtAlta 	:= aScan(_aDados,{|x|AllTrim(x[1]) == 'DTALTA'})
		_aDados[nPosDtAlta][2] := CtoD("")
	EndIf 

	aProcs		:= {}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³BE4_XTISS         ³
	//³1-1:Honorario     ³
	//³2-2:Evolucao      ³
	//³3-3:Tipo Fat.     ³
	//³4-11:Dt alta ori. ³
	//³12-17:Hr alta ori.³
	//³18-25:Dt alta XML ³
	//³26-31:Hr alta XML ³
	//³32-39:Dt Proc XML ³
	//³40-45:Hr Proc XML ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cXTISS 	:= BE4->BE4_XTISS
	cXTISS	:= Stuff(cXTISS,3,1,cTipFat)
	cXTISS	:= Stuff(cXTISS,18,8,PadR(AllTrim(DtoS(dDtAlta)),8))
	cXTISS	:= Stuff(cXTISS,26,6,PadR(cHrAlta,6))
	cXTISS	:= Stuff(cXTISS,32,8,PadR(AllTrim(DtoS(dDtProc)),8))
	cXTISS	:= Stuff(cXTISS,40,6,PadR(cHrProc,6))
	       
	BE4->(Reclock('BE4',.F.))
	BE4->BE4_XTISS := cXTISS    
	BE4->(MsUnlock())
	
	//A importacao de guias de internacao total inclui os procedimentos novos. No caso do procedimento nao existir no XML a rotina bloqueia, todavia caso o procedimento 
	//ja exista a rotina inclui sobre o ja existente, podendo pagar duplicado. 
	//Bloqueio dos procedimentos e honorarios que ja existem na BD6 e BD7 e existem no XML de resumo de internacao pois os mesmos serao incluidos pela rotina padrao.
	If !empty(cCodPEG)
        
		//Atualiza aItens de modo que nao apresente a critica 095 - Resumo de Internacao - Rede de Atendimento nao informada
		If !empty(cCODRDA) .and. !empty(cNOMRDA) .and. lResInt
			For nI := 1 to len(_aItens)
				nPosATPPAR	:= aScan(_aItens[nI],{|x|AllTrim(x[1]) == 'ATPPAR'}) 
				If nPosATPPAR > 0 .and. ValType(_aItens[nI][nPosATPPAR][2]) == 'A' 
					For nJ := 1 to len(_aItens[nI][nPosATPPAR][2])
						If ( len(_aItens[nI][nPosATPPAR][2][nJ]) >= 3 ) .and. empty(_aItens[nI][nPosATPPAR][2][nJ][2])
							//AllTrim(_aItens[nI][nPosATPPAR][2][nJ][1]) == 'O'//Instrumentador - BWT_CODPAR - TIPO DE COPARTIPACAO  
							_aItens[nI][nPosATPPAR][2][nJ][2] := cCODRDA
							_aItens[nI][nPosATPPAR][2][nJ][3] := cNOMRDA
						EndIf
					Next
				EndIf
			Next
		EndIf   

		If lResInt .and. ( cTipFat == 'T' )

 			For n_I := 1 to len(_aItens)                
			    If (len(_aItens[n_I]) >= 3) .and. (len(_aItens[n_I][2]) >= 2) .and. (len(_aItens[n_I][3]) >= 2) 
			    	aAdd(aProcs,AllTrim(_aItens[n_I][2][2] + _aItens[n_I][3][2]))
				EndIf    
			Next
	        
	        cChavPEG := cCodPEG
	
			//Validacao dos procedimentos ja existentes
			U_VldBlqProc(cChavPEG,aProcs,.T.)
		    
		EndIf
	
	EndIf             
    */
    //Leonardo Portella - 05/11/13 - Fim
    
EndIf
	
		
BD7->(RestArea(aAreaBD7))
BE4->(RestArea(aAreaBE4))
BEA->(RestArea(aAreaBEA))
BE2->(RestArea(aAreaBE2))

//Leonardo Portella - 03/05/12 - Fim

RestArea(aAreaBB0)
RestArea(aAreaBAX)

Return {_aDados,_aItens}

******************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca o codigo do profissional de saude solicitante da guia de ³
//³solicitacao ( TIPGUI = '03' )                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function GetSolic(c_Senha,cBB0Sol)

Local aArea 	:= GetArea()
Local cQry 		:= ''
Local cSolic	:= ''
Local cAlias

Default cBB0Sol := ''

If !empty(c_Senha)
    
	cQry := "SELECT BB0_CODIGO" 			  											   		+ CRLF
	cQry += "FROM " +RetSqlName('BE4') + " BE4"			   										+ CRLF
	cQry += "INNER JOIN " +RetSqlName('BB0') + " BB0 ON BB0_FILIAL = '" + xFilial('BB0') + "'"	+ CRLF 
	cQry += "	AND BB0_ESTADO = BE4_ESTSOL" 													+ CRLF
	cQry += "	AND BB0_NUMCR = BE4_REGSOL"														+ CRLF
	cQry += "	AND BB0_CODSIG = BE4_SIGLA"														+ CRLF
	cQry += "   AND BB0.D_E_L_E_T_ = ' '"														+ CRLF
	cQry += "WHERE BE4_FILIAL = '" + xFilial('BE4') + "'"  										+ CRLF
	cQry += "   AND BE4_SENHA = '" + c_Senha + "'" 		  										+ CRLF
	cQry += "   AND BE4_TIPGUI = '03'"			 		   										+ CRLF
	cQry += "   AND BE4.D_E_L_E_T_ = ' '"														+ CRLF
	
	cAlias := GetNextAlias()
	
	TcQuery cQry New Alias cAlias
	
	If !cAlias->(EOF())
		cBB0Sol := cAlias->BB0_CODIGO
	EndIf 
	
	cAlias->(DbCloseArea())

EndIf

RestArea(aArea)

Return cBB0Sol

*******************************************************************************************

//Leonardo Portella - 08/12/16 - Realiza o vinculo entre protocolo de entrega e PEG
//Ponto de entrada está ponteirado na PEG

Static Function VincProtPEG

Local aArea 	:= GetArea()
Local c_Alias	:= GetNextAlias()
Local cQry		:= ''
Local nProtRem	:= 0

cQry := "SELECT ZZP_NUMREM PROT_TOTAL"															+ CRLF
cQry += "FROM " + RetSqlName('ZRW') + " ZRW" 													+ CRLF
cQry += "INNER JOIN " + RetSqlName('ZZP') + " ZZP ON ZZP_FILIAL = '" + xFilial('ZZP') + "'" 	+ CRLF  
cQry += "  AND ZZP_NUMREM = ZRW_NUMREM" 														+ CRLF
cQry += "  AND ZZP_IDOPER = ZRW_IDTOTA" 														+ CRLF
cQry += "  AND ZZP_STATUS = 'CPR'" 																+ CRLF 
cQry += "  AND ZZP_ANOPAG = '" + BCI->BCI_ANO + "'" 											+ CRLF 
cQry += "  AND ZZP_MESPAG = '" + BCI->BCI_MES + "'" 											+ CRLF 
cQry += "  AND ZZP_CODRDA = '" + BCI->BCI_CODRDA + "'" 											+ CRLF 

If BCI->BCI_CODLDP == '0010'
	//Tipo 1: Recuperação/recurso de glosa
	cQry += "  AND ZZP_TIPPRO = '1'" 															+ CRLF
Else
	cQry += "  AND ZZP_TIPPRO <> '1'" 															+ CRLF
EndIf

cQry += "  AND ZZP.D_E_L_E_T_ = ' '" 															+ CRLF  
cQry += "WHERE ZRW_FILIAL = '" + xFilial('ZRW') + "'" 											+ CRLF 
cQry += "  AND UPPER(ZRW_XML) = '" + Alltrim(Upper(BCI->BCI_ARQUIV)) + "'" 						+ CRLF
cQry += "  AND ZRW.D_E_L_E_T_ = ' '" 															+ CRLF 

TcQuery cQry New Alias c_Alias

If !c_Alias->(EOF())
	nProtRem	:= c_Alias->PROT_TOTAL
EndIf

c_Alias->(DbCloseArea())

If nProtRem > 0
	
	BCI->(Reclock('BCI',.F.))

	BCI->BCI_YPTREM := cValToChar(nProtRem)
	
	BCI->(Msunlock())	
	
EndIf

RestArea(aArea)

Return
