// A técnica foi trocar o conteúdo das variáveis Identificador do Título com o Nosso Número, pois
// no modelo 2 o sistema descarta as linhas sem Identificadores de títulos.

#INCLUDE "fileio.ch"

***********************
User Function F200VAR()
	***********************
	Local _cCbSisdeb := ""
	Local _aAreaSE1  := GetArea("SE1")
	Local cIdCnab    := Substr(PARAMIXB[1,16],70,10)  // Adicionado por Luiz Otavio - Considerar Retorno CNAB Banco do Brasil
	Local aPergs     := {} //Adicionado por Luiz Otavio atender CNAB retorno Banco do Brasil 
	Local __aRet     :={}

	//Utiliza d+1 para os arquivos de retorno do SISDEB.
	_cCbSisdeb := Posicione("SEE",1,xFilial("SEE")+mv_par06+mv_par07+mv_par08+mv_par09,"EE_XXTIPO")
	If _cCbSisdeb == "S" .Or. Upper(Alltrim(mv_par05)) == 'ITAU.2RR'
		If Empty(dDataCred) .And. !Empty(dBaixa)
			dDataCred := DataValida(dBaixa + 1)
		ElseIf !Empty(dDataCred)
			dDataCred := DataValida(dDataCred + 1)
		Endif
	Endif
	
	// Marcela Coimbra - 13/07/2016
	// Acerto de impressão de cnab  pois não estava listando os arquivos sem IDCNAB
	If UPPER(ALLTRIM(mv_par05)) = 'BRADESCO.2RR'
		
		dbSelectArea("SE1")
		DbOrderNickName("SE1NOSNUM")
		If dbSeek( xFilial("SE1") + cNumTit )
			//				cAliasCR	:=GetNextAlias()
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
			//				dbselectarea("SE1")
			//				SE1->(dbgoto((cAliasCR)->RECSE1))
			cNossoNum 	:= cNumTit
			
			cNumTit := SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO
			cTipo	  := SE1->E1_TIPO
			
		Else
			
			dbSelectArea("SE1")
			dbSetOrder(16)
			If dbSeek( xFilial("SE1") + cNsNum )
				
				cNumTit := SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO
				cTipo	:= SE1->E1_TIPO
				
			Else
				
				cNumTit := ""
				
			EndIf
			
		EndIf
		
		return

		//FIM Marcela Coimbra - 13/07/2016
	


	//*************condicao adiconado por Luiz Otavio Campos *****************
	ElseIf UPPER(ALLTRIM(mv_par05)) = "BBDEBAUT.RET" .and. mv_par06 = "001"

		dbSelectArea("SE1")
		dbSetOrder(16)
		If dbSeek( xFilial("SE1") + cIdCnab )

			// Pontera no titulo	
			cNumTit := SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO
			cTipo	:= SE1->E1_TIPO		

			// Inclui data de Credito do Banco do Brasil
			/*If Empty(dxDataCred)

				dxDataCred := DataValida(dBaixa+1)
				aAdd(aPergs, {1, "Data Do Crédito", dxDataCred ,  "", ".T.", "", ".T.", 80,  .F.})
				
				lok := .T.

				While lok  
					If ParamBox(aPergs, "Parâmetros - Banco do Brasil ", __aRet)
						dxDataCred := __aRet[1]
						lok :=.F.
					EndIf
				EndDo

				lRetbbras:= .F.

			EndIf	*/

			//dDataCred := dxDataCred
			//pergunte(cPerg,.F.)
		Else
			
			cNumTit := ""

		EndIf		
		
		/***********************************************************************/

	EndIf
	

	//A linha abaixo é para que o Ponto de Entrada somente funcione com o arquivo 112175.
	//De modo que o P.E. seja descartado para o SISDEB e para o caso de algum usuário utilizar o antigo 112.2rr
	If AllTrim(Upper(GetMV("MV_XCNABRR"))) != Upper(AllTrim(mv_par05))
		Return()
	EndIf
	
	//	Obtém o número do Título para os títulos já identificados (112)
	If Type("cNsNum") = "U" .Or. cNsNum == Nil
		cTituloCab := ""
	Else
		cTituloCab := cNsNum
	EndIf
	
	//	Em qualquer caso, devolvo o valor ao nosso numero
	cNsNum := cNumTit
	
	If AllTrim(cTituloCab) != ""
		cNumTit := cTituloCab
		Return
	EndIf
	
	//	Tratamento de cacas na base (Duplicidades)
	If cNumTit $ " 10000000   10000024   10000056   10000064   10000079   10000081   10000085   10000092   10000133   10000134   10000167 "
		cNumTit = ""
		Return()
	ElseIf cNumTit $ " 10000174   10000179   10000187   10000269   10000329   10000393   10000405   10000440   10000444   10000476   10000479 "
		cNumTit = ""
		Return()
	ElseIf cNumTit $ " 10000573   10000574   10000627   10000637   10000710   10000713   10000717   10000724   10000731   10000732   10000737 "
		cNumTit = ""
		Return()
	ElseIf cNumTit $ " 10000777   10000788   10000791   10000793   10000797   4185257 "
		cNumTit = ""
		Return()
	EndIf
	
	If !Empty(cNumTit)
		//Localiza os títulos sem o nosso número preenchido
		SE1->(DBOrderNickName("SE1NOSNUM"))
		
		//Para os títulos não localizados pelo NossoNum, apenas devolvo o número do Título (' ') que teoricamente
		//não será processado, contudo será listado no log e no relatório (FINR650).
		If !SE1->(DbSeek(xfilial("SE1")+cNumTit))
			cNumTit := cTituloCab
		Else
			//Obtém o detalhe do título
			If SE1->E1_PREFIXO != "ANT"
				cNumTit := SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO
				cTipo	  := SE1->E1_TIPO
			Else
				cNumTit := cTituloCab
			EndIf
		EndIf
	Else
		//Casos improváveis porém reais
		cNumTit := cTituloCab
	EndIf
	
	RestArea(_aAreaSE1)
	
Return


/******************************************************************
Static Function fLogSE1(_y0, _y1, _y2, _y3, _y4, _y5, _y6, _y7, _y8)
	//******************************************************************
	/*
	Local _cRegLog
	Local _sArqLog := "M:\Protheus_Data\interface\importa\CNAB\LOG\OUT\T00119.LOG"
	Static _nSeq := 0
	Static _nHLog

Return // Executar apenas em tempo de Debug 	*/

_cRegLog := chr(13) + chr(10) + StrZero(_nSeq,6,0) + ";" + _y0 + ";" + _y1 + ";" + _y2 + ";" + _y3

If _y0 == "2"
	_cRegLog += ";" + _y4 + ";" + _y5 + ";" + _y6 + ";" + Str(_y7) + ";" + Str(_y8)
EndIf

If _nSeq == 0
	_nHLog := FCreate(_sArqLog, FC_NORMAL)
	FWrite(_nHLog, chr(13) + chr(10) + "Iniciado em: " + Dtoc(MsDate())+" "+Time())
	FWrite(_nHLog, chr(13) + chr(10) + "SEQ;TP_LOG;NUMTIT;NOSSONUM;PREFIXO;NUM;PARCELA;TIPO;VALOR;SALDO")
Endif

FWrite(_nHLog, _cRegLog)
_nSeq += 1

Return
