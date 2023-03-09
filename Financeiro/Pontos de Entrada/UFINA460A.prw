#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE 'FWMVCDEF.CH'

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �FINA460A � Autor � Angelo Henrique       � Data �12/08/2019 ���
�������������������������������������������������������������������������Ĵ��
���Descricao �  Ponto de entrada chamado via MVC para atender a rotina    ���
���          �de Liquida��o (Antiga Fatura)                               ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
���������������������������������������������������������������������������*/

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
		//Na valida��o total do modelo.
		//--------------------------------------------------------------------------------
		If cIdPonto == "MODELPOS"
			
			//----------------------------------------------------------------------------
			//Rotina que ir� realizar a valida��o dos totalizadores do t�tulo
			//----------------------------------------------------------------------------
			_lRet := UF460MSG()
			
		EndIf
		
		//--------------------------------------------------------------------------------
		//Ap�s a grava��o total do modelo e fora da transa��o.
		//--------------------------------------------------------------------------------
		If cIdPonto == "MODELCOMMITTTS"
			
			//----------------------------------------------------------------------------
			//Rotina utilizada para validar as seguintes quest�es
			//----------------------------------------------------------------------------
			//Aten��o neste momento o registro esta dentro da transa��o e n�o salvo no
			//mo banco, logo os registros que est�o sendo gravados n�o s�o visualizados
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


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �UF460MSG � Autor � Angelo Henrique       � Data �12/08/2019 ���
�������������������������������������������������������������������������Ĵ��
���Descricao �  Rotina para exibir mensagem caso o total das parcelas     ���
���          �sejam diferentes do valor total dos t�tulos selecionados.   ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
���������������������������������������������������������������������������*/

Static Function UF460MSG()
	
	Local _nValor	:= 0 //Totalizador para os t�tulos que ser�o gerados
	Local _nValGr	:= 0 //Totalizador para os t�tulos que foram marcados
	Local _cMsgErro	:= ""
	Local _cMsgHlp	:= ""
	Local _nI		:= 0
	Local _oModTit	:= "" //Model da estrutura que mostra os t�tulos que ser�o gerados.
	Local _oModNeg	:= "" //Model da estrutura onde s�o selecionados os t�tulos para a negocia��o.
	
	//----------------------------------------------------------------
	//Pegando o Modelo que ficam os dados dos t�tulos selecionados
	//----------------------------------------------------------------
	_oModNeg  := oObj:GetModel("TITSELFO1")
	
	//----------------------------------------------------------------
	//Pegando o Modelo que ficam os dados do t�tulo que ser� gerado.
	//----------------------------------------------------------------
	_oModTit := oObj:GetModel("TITGERFO2")
	
	//-----------------------------------------------
	//Varrendo 	os t�tulos marcados
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
	//Varrendo os t�tulos quer ser�o gerados
	//-----------------------------------------------
	For _nI := 1 To _oModTit:Length()
		
		_oModTit:GoLine(_nI)
		
		//---------------------
		// Linha n�o deletada
		//---------------------
		If !_oModTit:IsDeleted()
			
			//-----------------------------------
			// Pegar um valor do GRID
			//-----------------------------------
			_nValor += _oModTit:GetValue("FO2_VALOR")
			
		EndIf
		
	Next _nI
	
	If _nValor != _nValGr
		
		_cMsgHlp := "Valores digitado(s) na(s) parcela(s) diferente do valor total do(s) t�tulo(s) selecionado(s)."
		
		_cMsgErro := "Favor corrigir os valores das parcelas para que estejam compat�veis "
		_cMsgErro += "com o valor total: " + cValToChar(_nValGr)
		
		Help(NIL, NIL, "FWMODELPOS", NIL, _cMsgHlp, 1, 0, NIL, NIL, NIL, NIL, NIL, {_cMsgErro})
		
		_lRet := .F.
		
	EndIf
	
Return _lRet

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �UF460VLD � Autor � Angelo Henrique       � Data �12/08/2019 ���
�������������������������������������������������������������������������Ĵ��
���Descricao �  Rotina para validar as faturas geradas.                   ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
���������������������������������������������������������������������������*/

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
	Local _cNmProc	:= "" //Numero do Process que faz vinculo nas tabelas da liquida��o
	Local _aArSE1	:= SE1->(GetArea())
	Local _aArSE5	:= SE5->(GetArea())
	Local _aArFO0	:= FO0->(GetArea())
	Local _aArFO1	:= FO1->(GetArea())
	Local _aArFO2	:= FO2->(GetArea())	
	
	//-------------------------------------------------------------------------
	//Neste momento a rotina esta ponterada nos t�tulos negociados.
	//-------------------------------------------------------------------------
	_cCdInt	:= SE1->E1_CODINT
	_cCdEmp	:= SE1->E1_CODEMP
	_cMatrc	:= SE1->E1_MATRIC
	_cSubcn	:= SE1->E1_SUBCON
	_cContr	:= SE1->E1_CONEMP
	
	//----------------------------------------------------------------------------------
	//Neste momento o promeiro registro das faturas geradas tamb�m se encontra ponterado
	//----------------------------------------------------------------------------------
	_cChvFO2 := FO2->(FO2_FILIAL+FO2_PREFIX+FO2_NUM)
	_cNmProc := FO2->FO2_PROCES
	
	//----------------------------------------------------------------------------------
	//Alimentando as informa��es do t�tulo pertinentes a matricula do benefici�rio
	//----------------------------------------------------------------------------------
	If !(Empty(AllTrim(_cCdInt)))			;
			.Or. !(Empty(AllTrim(_cCdEmp))) ;
			.Or. !(Empty(AllTrim(_cMatrc))) ;
			.Or. !(Empty(AllTrim(_cSubcn)))	;
			.Or. !(Empty(AllTrim(_cContr)))
		
		//------------------------------------------------------------------
		// Inicio - Ponterando na Fatura gerada para alimentar as informa��es
		//------------------------------------------------------------------
		DbSelectArea("SE1")
		DbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
		If DbSeek(_cChvFO2)
			
			While SE1->(!EOF()) .And. _cChvFO2 == SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM)
				
				//----------------------------------------------------------------
				//Preenchendo as informa��es pertinentes ao PLS no t�tulo
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
		// Fim - Tabela das faturas que ser�o geradas (FO2)
		//------------------------------------------------------------------
		
	EndIf
	
	//-----------------------------------------------------------------------------------
	//Validar processo de Juros
	//-----------------------------------------------------------------------------------
	//Ponterando na tabela da fatura gerada novamente, por�m na parcela 1 (Regra CABERJ)
	//-----------------------------------------------------------------------------------
	DbSelectArea("SE1")
	DbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
	If DbSeek(_cChvFO2 + PADR("1",TAMSX3("E1_PARCELA")[1]) + FO2->FO2_TIPO)
		
		//If SE1->E1_ACRESC = 0 .And. _lJuros
		If _lJuros
			
			_lJuros		:= .F.
			nValMult 	:= 0
			
			If ApMsgYesNo("Calcula Multa e Juros ? ","Aten��o")
				
				//------------------------------------------------------------------------
				//Ponterar na tabela FO0 (Cabe�alho da Liquida��o)
				//------------------------------------------------------------------------
				DbSelectArea("FO0")
				DBSetOrder(1) //FO0_FILIAL+FO0_PROCES+FO0_VERSAO
				If DbSeek(FO2->(FO2_FILIAL+FO2_PROCES+FO2_VERSAO))
					
					//-------------------------------------------------------------------
					//Ap�s achar o cabe�alho ponterar na movimenta��o banc�ria
					//pegando assim os t�tulos que foram baixados por essa liquida��o
					//-------------------------------------------------------------------
					DbSelectArea("SE5")
					DbSetOrder(10) //E5_FILIAL+E5_DOCUMEN
					If DbSeek(FO0->(FO0_FILIAL + FO0_NUMLIQ))
						
						While SE5->(!EOF()) .And. AllTrim(FO0->FO0_NUMLIQ) == AllTrim(SE5->E5_DOCUMEN)
							
							If AllTrim(SE5->E5_MOTBX) == "LIQ"
								
								//---------------------------------------------------------------
								//Ap�s isso visualizar cada t�tulo baixado/amarrado a
								//liquida��o para calcular os juros
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
						//Gravando no novo titulo as informa��es de juros
						//---------------------------------------------------------------
						//Retornando para o registro do t�tulo que esta sendo gerado
						//pelo processe de fatura pois ele pode ter entrado na
						//varredura dos juros e ter desponterado
						//---------------------------------------------------------------
						If nValMult > 0
							
							DbSelectArea("SE1")
							DbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
							If DbSeek(_cChvFO2 + PADR("1",TAMSX3("E1_PARCELA")[1]) + FO2->FO2_TIPO)
								
								RecLock("SE1",.F.)
								
								SE1->E1_HIST 	:= "VLR ORIG: " + cValToCHar(SE1->E1_VALOR) + " E JUR/MULTA: " + cValToChar(Round(nValMult,2))								
								SE1->E1_SALDO   += nValMult    	// Valor da atualiza��o financeira
								SE1->E1_VALOR   += nValMult    	// Valor da atualiza��o financeira
								SE1->E1_VLCRUZ  += nValMult    	// Valor da atualiza��o financeira
								
								
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