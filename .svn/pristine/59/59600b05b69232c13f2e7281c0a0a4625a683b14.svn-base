#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE 'FWMVCDEF.CH'

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³FINA460A ³ Autor ³ Angelo Henrique       ³ Data ³12/08/2019 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³  Ponto de entrada chamado via MVC para atender a rotina    ³±±
±±³          ³de Liquidação (Antiga Fatura)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function FINA460A()
	
	Local _aArea		:= GetArea()
	Local _aArSE1		:= SE1->(GetArea())
	Local _aArSE5		:= SE5->(GetArea())
	Local _aArFO0		:= FO0->(GetArea())
	Local _aArFO1		:= FO1->(GetArea())
	Local _aArFO2		:= FO2->(GetArea())
	
	Private aParam  	:= PARAMIXB
	Private oObj 		:= Nil
	Private cIdPonto 	:= Nil
	Private cIdModel 	:= Nil
	Private _lRet		:= .T.
	
	If aParam <> NIL
		
		oObj		:= aParam[1]
		cIdPonto 	:= aParam[2]
		cIdModel 	:= aParam[3]
		
		//--------------------------------------------------------------------------------
		//Na validação total do modelo.
		//--------------------------------------------------------------------------------
		If cIdPonto == "MODELPOS"
			
			//----------------------------------------------------------------------------
			//Rotina que irá realizar a validação dos totalizadores do título
			//----------------------------------------------------------------------------
			_lRet := UF460MSG()
			
		EndIf
		
		//--------------------------------------------------------------------------------
		//Após a gravação total do modelo e fora da transação.
		//--------------------------------------------------------------------------------
		If cIdPonto == "MODELCOMMITTTS"
			
			//----------------------------------------------------------------------------
			//Rotina utilizada para validar as seguintes questões
			//----------------------------------------------------------------------------
			//Atenção neste momento o registro esta dentro da transação e não salvo no
			//mo banco, logo os registros que estão sendo gravados não são visualizados
			//por query, somento po DBSELECTAREA
			//----------------------------------------------------------------------------
			UF460VLD()
			
		EndIf
		
	EndIf
	
	RestArea(_aArFO2)
	RestArea(_aArFO1)
	RestArea(_aArFO0)
	RestArea(_aArSE5)
	RestArea(_aArSE1)
	RestArea(_aArea	)
	
Return _lRet


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³UF460MSG ³ Autor ³ Angelo Henrique       ³ Data ³12/08/2019 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³  Rotina para exibir mensagem caso o total das parcelas     ³±±
±±³          ³sejam diferentes do valor total dos títulos selecionados.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function UF460MSG()
	
	Local _nValor	:= 0 //Totalizador para os títulos que serão gerados
	Local _nValGr	:= 0 //Totalizador para os títulos que foram marcados
	Local _cMsgErro	:= ""
	Local _cMsgHlp	:= ""
	Local _nI		:= 0
	Local _oModTit	:= "" //Model da estrutura que mostra os títulos que serão gerados.
	Local _oModNeg	:= "" //Model da estrutura onde são selecionados os títulos para a negociação.
	
	//----------------------------------------------------------------
	//Pegando o Modelo que ficam os dados dos títulos selecionados
	//----------------------------------------------------------------
	_oModNeg  := oObj:GetModel("TITSELFO1")
	
	//----------------------------------------------------------------
	//Pegando o Modelo que ficam os dados do título que será gerado.
	//----------------------------------------------------------------
	_oModTit := oObj:GetModel("TITGERFO2")
	
	//-----------------------------------------------
	//Varrendo 	os títulos marcados
	//-----------------------------------------------
	For _nI := 1 To _oModNeg:Length()
		
		_oModNeg:GoLine(_nI)
		
		//---------------------
		// Linha Marcada
		//---------------------
		If _oModNeg:GetValue("FO1_MARK")
			
			//-----------------------------------
			// Pegar um valor do GRID
			//-----------------------------------
			_nValGr += _oModNeg:GetValue("FO1_SALDO")
			
		EndIf
		
	Next _nI
	
	//-----------------------------------------------
	//Varrendo os títulos quer serão gerados
	//-----------------------------------------------
	For _nI := 1 To _oModTit:Length()
		
		_oModTit:GoLine(_nI)
		
		//---------------------
		// Linha não deletada
		//---------------------
		If !_oModTit:IsDeleted()
			
			//-----------------------------------
			// Pegar um valor do GRID
			//-----------------------------------
			_nValor += _oModTit:GetValue("FO2_VALOR")
			
		EndIf
		
	Next _nI
	
	If _nValor != _nValGr
		
		_cMsgHlp := "Valores digitado(s) na(s) parcela(s) diferente do valor total do(s) título(s) selecionado(s)."
		
		_cMsgErro := "Favor corrigir os valores das parcelas para que estejam compatíveis "
		_cMsgErro += "com o valor total: " + cValToChar(_nValGr)
		
		Help(NIL, NIL, "FWMODELPOS", NIL, _cMsgHlp, 1, 0, NIL, NIL, NIL, NIL, NIL, {_cMsgErro})
		
		_lRet := .F.
		
	EndIf
	
Return _lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³UF460VLD ³ Autor ³ Angelo Henrique       ³ Data ³12/08/2019 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³  Rotina para validar as faturas geradas.                   ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function UF460VLD()
	
	Local _cMes		:= STRZERO(Month(dDatabase),TAMSX3("E1_MESBASE")[1])
	Local _cAno		:= STRZERO(Year(dDatabase) ,TAMSX3("E1_ANOBASE")[1])
	Local _cCdInt	:= ""
	Local _cCdEmp	:= ""
	Local _cMatrc	:= ""
	Local _cSubcn	:= ""
	Local _cContr	:= ""
	Local _lJuros	:= .T.
	Local nValMult	:= 0		
	Local _cChvFO2	:= "" //Chave da FO2
	Local _cNmProc	:= "" //Numero do Process que faz vinculo nas tabelas da liquidação
	Local _aArSE1	:= SE1->(GetArea())
	Local _aArSE5	:= SE5->(GetArea())
	Local _aArFO0	:= FO0->(GetArea())
	Local _aArFO1	:= FO1->(GetArea())
	Local _aArFO2	:= FO2->(GetArea())	
	
	//-------------------------------------------------------------------------
	//Neste momento a rotina esta ponterada nos títulos negociados.
	//-------------------------------------------------------------------------
	_cCdInt	:= SE1->E1_CODINT
	_cCdEmp	:= SE1->E1_CODEMP
	_cMatrc	:= SE1->E1_MATRIC
	_cSubcn	:= SE1->E1_SUBCON
	_cContr	:= SE1->E1_CONEMP
	
	//----------------------------------------------------------------------------------
	//Neste momento o promeiro registro das faturas geradas também se encontra ponterado
	//----------------------------------------------------------------------------------
	_cChvFO2 := FO2->(FO2_FILIAL+FO2_PREFIX+FO2_NUM)
	_cNmProc := FO2->FO2_PROCES
	
	//----------------------------------------------------------------------------------
	//Alimentando as informações do título pertinentes a matricula do beneficiário
	//----------------------------------------------------------------------------------
	If !(Empty(AllTrim(_cCdInt)))			;
			.Or. !(Empty(AllTrim(_cCdEmp))) ;
			.Or. !(Empty(AllTrim(_cMatrc))) ;
			.Or. !(Empty(AllTrim(_cSubcn)))	;
			.Or. !(Empty(AllTrim(_cContr)))
		
		//------------------------------------------------------------------
		// Inicio - Ponterando na Fatura gerada para alimentar as informações
		//------------------------------------------------------------------
		DbSelectArea("SE1")
		DbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
		If DbSeek(_cChvFO2)
			
			While SE1->(!EOF()) .And. _cChvFO2 == SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM)
				
				//----------------------------------------------------------------
				//Preenchendo as informações pertinentes ao PLS no título
				//----------------------------------------------------------------
				If FO2->FO2_TIPO == SE1->E1_TIPO 	;
						.Or. Empty(SE1->E1_MESBASE) ;
						.Or. Empty(SE1->E1_ANOBASE) ;
						.Or. Empty(SE1->E1_CODINT)	;
						.Or. Empty(SE1->E1_CODEMP)	;
						.Or. Empty(SE1->E1_MATRIC)
					
					Reclock("SE1", .F.)
					
					SE1->E1_MESBASE := _cMes
					SE1->E1_ANOBASE := _cAno
					SE1->E1_CODINT  := _cCdInt
					SE1->E1_CODEMP  := _cCdEmp
					SE1->E1_MATRIC  := _cMatrc
					SE1->E1_SUBCON	:= _cSubcn
					SE1->E1_CONEMP	:= _cContr
					
					SE1->(MsUnlock())
					
					
				EndIf
				
				SE1->(DbSkip())
				
			EndDo
			
		EndIf
		//------------------------------------------------------------------
		// Fim - Tabela das faturas que serão geradas (FO2)
		//------------------------------------------------------------------
		
	EndIf
	
	//-----------------------------------------------------------------------------------
	//Validar processo de Juros
	//-----------------------------------------------------------------------------------
	//Ponterando na tabela da fatura gerada novamente, porém na parcela 1 (Regra CABERJ)
	//-----------------------------------------------------------------------------------
	DbSelectArea("SE1")
	DbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
	If DbSeek(_cChvFO2 + PADR("1",TAMSX3("E1_PARCELA")[1]) + FO2->FO2_TIPO)
		
		//If SE1->E1_ACRESC = 0 .And. _lJuros
		If _lJuros
			
			_lJuros		:= .F.
			nValMult 	:= 0
			
			If ApMsgYesNo("Calcula Multa e Juros ? ","Atenção")
				
				//------------------------------------------------------------------------
				//Ponterar na tabela FO0 (Cabeçalho da Liquidação)
				//------------------------------------------------------------------------
				DbSelectArea("FO0")
				DBSetOrder(1) //FO0_FILIAL+FO0_PROCES+FO0_VERSAO
				If DbSeek(FO2->(FO2_FILIAL+FO2_PROCES+FO2_VERSAO))
					
					//-------------------------------------------------------------------
					//Após achar o cabeçalho ponterar na movimentação bancária
					//pegando assim os títulos que foram baixados por essa liquidação
					//-------------------------------------------------------------------
					DbSelectArea("SE5")
					DbSetOrder(10) //E5_FILIAL+E5_DOCUMEN
					If DbSeek(FO0->(FO0_FILIAL + FO0_NUMLIQ))
						
						While SE5->(!EOF()) .And. AllTrim(FO0->FO0_NUMLIQ) == AllTrim(SE5->E5_DOCUMEN)
							
							If AllTrim(SE5->E5_MOTBX) == "LIQ"
								
								//---------------------------------------------------------------
								//Após isso visualizar cada título baixado/amarrado a
								//liquidação para calcular os juros
								//---------------------------------------------------------------
								DbSelectArea("SE1")
								DbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
								If DbSeek(SE5->(E5_FILIAL + E5_PREFIXO + E5_NUMERO + E5_PARCELA + E5_TIPO ))
									
									While !(SE1->(Eof())) 								;
											.And. SE5->E5_FILIAL 	== SE1->E1_FILIAL	;
											.And. SE5->E5_PREFIXO	== SE1->E1_PREFIXO	;
											.And. SE5->E5_NUMERO	== SE1->E1_NUM		;
											.And. SE5->E5_PARCELA	== SE1->E1_PARCELA	;
											.And. SE5->E5_TIPO 		== SE1->E1_TIPO
										
										nValMult += U_CABA997(SE1->E1_VENCREA,SE1->E1_BAIXA,SE1->E1_VALLIQ,.F.,SE1->E1_CODEMP,"FA280") 
										
										SE1->(DbSkip())
										
									EndDo
									
								EndIf
								//---------------------------------------------------------------
								//Fim do ponteramento da SE1
								//---------------------------------------------------------------
								
							EndIf
							
							SE5->(DbSkip())
							
						EndDo
						
						//---------------------------------------------------------------
						//Gravando no novo titulo as informações de juros
						//---------------------------------------------------------------
						//Retornando para o registro do título que esta sendo gerado
						//pelo processe de fatura pois ele pode ter entrado na
						//varredura dos juros e ter desponterado
						//---------------------------------------------------------------
						If nValMult > 0
							
							DbSelectArea("SE1")
							DbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
							If DbSeek(_cChvFO2 + PADR("1",TAMSX3("E1_PARCELA")[1]) + FO2->FO2_TIPO)
								
								RecLock("SE1",.F.)
								
								SE1->E1_HIST 	:= "VLR ORIG: " + cValToCHar(SE1->E1_VALOR) + " E JUR/MULTA: " + cValToChar(Round(nValMult,2))								
								SE1->E1_SALDO   += nValMult    	// Valor da atualização financeira
								SE1->E1_VALOR   += nValMult    	// Valor da atualização financeira
								SE1->E1_VLCRUZ  += nValMult    	// Valor da atualização financeira
								
								
								SE1->(MsUnlock())
								
							EndIf
							
						EndIf
						
					EndIf
					//---------------------------------------------------------------
					//Fim do ponteramento da SE5
					//---------------------------------------------------------------
					
				EndIf
				//---------------------------------------------------------------
				//Fim do ponteramento da FO0
				//---------------------------------------------------------------
				
			EndIf
			
		EndIf
		
	EndIf
	
	RestArea(_aArFO2)
	RestArea(_aArFO1)
	RestArea(_aArFO0)
	RestArea(_aArSE5)
	RestArea(_aArSE1)
	
Return