#INCLUDE "RwMake.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA280GVR  ºAutor  ³Microsiga           º Data ³  09/28/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada chamado na confirmacao da fatura           º±±
±±º          ³Utilizado para gravar dados complementares nas tabelas do PLSº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINANCEIRO                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

*********************
User Function Fa280()
*********************
Local  aAreaOld    := GetArea()
Local  cQuery      := " "
Local lRet         := .T.
Local nValMult  // recebe o valor de multa+juros+igpm calculados pela funcao generica
Local _aParcela    :={} // vetor que sera passado para funcao GerAdNeg
Local cAnoAdd
Local cMesAdd
Local cNumTit   := " "
Local cPrefixo  := " "
Local cTipo     := " "
Local cParcela  := " "
Local cChave    := " "
Local cQuery    := " "
Local _cNumFat     := SE1->E1_NUM
Local _cPrefFat    := SE1->E1_PREFIXO
Local _cParcFat    := SE1->E1_PARCELA
Local _cTipoFat    := SE1->E1_TIPO
Local _cLojaFat    := SE1->E1_LOJA
Local _cCliente    := SE1->E1_CLIENTE
Local _dtEmissao   := SE1->E1_EMISSAO
Local _nValor      := SE1->E1_SALDO   
local  nValTit     := 0    
local cFazMulJu    := 'N'   
local qtdaFat      := 0//len(AVLCRUZ) // conta quantidade de parcelas na fatura  - Altamiro 03/05/2017

//If Valtype(AVLCRUZ) <> "U"
If IsInCallStack("u_CABA210")

    qtdaFat      := 0
    
Else 
    
	qtdaFat      := len(AVLCRUZ) // conta quantidade de parcelas na fatura  - Altamiro 03/05/2017

EndIf

//|-------------------------------------|
//|GRAVO OS DADOS ADICIONAIS DA FATURA. |
//|-------------------------------------|

RecLock("SE1",.F.)
SE1->E1_HIST    := " Titulo Gerado por Faturas "
SE1->E1_MESBASE := Substr(DTOS(dDataBase),5,2) //Mes do Titulo
SE1->E1_ANOBASE := Substr(DTOS(dDataBase),1,4)
MsUnlock()  
           
// Altamiro -- 05/04/2017 - cobrança de juros e multas nas faturas de titulos em atraso

If  ((_cParcFat == '1' .and. qtdaFat == 1) .or. (_cParcFat == '2' .and. qtdaFat > 1))
    If ApMsgYesNo("Calcula Multa e Juros ? ","SIMNAO")		       
       cFazMulJu   := 'S'
    EndIf 
EndIf    

/// Fim alteração Altamiro - 05/04/2017 

//|------------------------------------------------|
//|SELECAO DOS TITULOS QUE ORIGINARAM AS  FATURAS  |
//|------------------------------------------------|
cQry := " SELECT E1_FILIAL,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_NUM,E1_TIPO,R_E_C_N_O_ RECNOSE1, E1_CODINT, E1_CODEMP, E1_MATRIC"
cQry += " FROM " + RetSqlName("SE1")
cQry += " WHERE D_E_L_E_T_ <> '*' "
cQry += " AND E1_FILIAL     = '" + xFilial("SE1") + "'"
cQry += " AND E1_FATPREF    = '" + _cPrefFat + "'"
cQry += " AND E1_FATURA     = '" + _cNumFat  + "'"

If TcSqlExec(cQry) < 0

	Return

Endif

If Select("TFAT") > 0 

   TFAT->(DbCloseArea()) 

Endif

DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'TFAT', .F., .T.) 
                                                          

**'Marcela Coimbra - Parcelamento de fatura - 24/06/2010'**
**'Bloco mudado de lugar para pegar dados da matricula  '**

If !TFAT->( EOF() )
	
	RecLock("SE1",.F.)
	SE1->E1_CODINT    	:= TFAT->E1_CODINT
	SE1->E1_CODEMP 		:= TFAT->E1_CODEMP
	SE1->E1_MATRIC 		:= TFAT->E1_MATRIC
	MsUnlock()

EndIf    
                                                  
**'FIM - Marcela Coimbra - Parcelamento de fatura - 24/06/2010'**
 
lGrvBBT := .F.
DbGoTop("TFAT")
While !eof()
	
	_aParcela := {}
	aDadUsr   := {}
	
	If !lGrvBBT
		DbSelectArea("BBT")
		dbSetOrder(7)
		If DbSeek(xFilial("BBT")+TFAT->E1_PREFIXO+TFAT->E1_NUM+TFAT->E1_PARCELA+TFAT->E1_TIPO)
			//ACHO OS TITULOS E GRAVO OS VALORES DO PLS EM VARIAVEIS
			If BBT->BBT_NIVEL == "4"
				DbSelectArea("BA3")
				DbSetOrder(1)
				iF MsSeek(xFilial("BA3")+BBT->BBT_CODOPE+BBT->BBT_CODEMP+BBT->BBT_MATRIC)
					_cCodInt  := BBT->BBT_CODOPE
					_cCodEmp  := BBT->BBT_CODEMP
					_cMatric  := BBT->BBT_MATRIC
					_cConEmp  := BA3->BA3_CONEMP
					_cVerCon  := BA3->BA3_VERCON
					_cSubCon  := BA3->BA3_SUBCON
					_cVerSub  := BA3->BA3_VERSUB
					_cNiveCob := BBT->BBT_NIVEL
					_cVersao  := BBT->BBT_VERSAO
					_cCodPla  := BBT->BBT_CODPLA
				Else
					MsgBox("Dados nao localizados na tabela BA3, Favor verificar a ocorrencia")
					Return
				EndIf
			Else
				_cCodInt  := BBT->BBT_CODOPE
				_cCodEmp  := BBT->BBT_CODEMP
				_cMatric  := BBT->BBT_MATRIC
				_cConEmp  := BBT->BBT_CONEMP
				_cVerCon  := BBT->BBT_VERCON
				_cSubCon  := BBT->BBT_SUBCON
				_cVerSub  := BBT->BBT_VERSUB
				_cNiveCob := BBT->BBT_NIVEL
				_cVersao  := BBT->BBT_VERSAO
				_cCodPla  := BBT->BBT_CODPLA
			Endif
			
			//|--------------------------------------------------|
			//|CRIO UM NOVO REGISTRO NA TABELA BBT PARA A FATURA |
			//|--------------------------------------------------|
			If BBT->(DbSeek(xFilial("SE1")+_cPrefFat+_cNumFat+_cParcFat+_cTipoFat))
				lGravaBBT := .F.
			Else
				lGravaBBT := .T.
			endif
			
			RecLock("BBT",lGravaBBT)
			BBT->BBT_FILIAL  := xFilial("BBT")
			BBT->BBT_CODOPE  := _cCodInt
			BBT->BBT_CODEMP  := _cCodEmp
			BBT->BBT_MATRIC  := _cMatric
			BBT->BBT_CONEMP  := _cConEmp
			BBT->BBT_VERCON  := _cVerCon
			BBT->BBT_SUBCON  := _cSubCon
			BBT->BBT_VERSUB  := _cVerSub
			BBT->BBT_NIVEL   := _cNiveCob
			BBT->BBT_PREFIX  := _cPrefFat
			BBT->BBT_NUMTIT  := _cNumFat
			BBT->BBT_PARCEL  := _cParcFat
			BBT->BBT_TIPTIT  := _cTipoFat
			//BBT->BBT_MESTIT  := Substr(DTOS(dDataBase),5,2) //Retirado pois estes campos impediam a geração da cobrança no mesmo mes da geração da fatura.
			//BBT->BBT_ANOTIT  := Substr(DTOS(dDataBase),1,4)
			BBT->BBT_LOJA    := _cLojaFat
			BBT->BBT_DATEMI  := _DtEmissao
			BBT->BBT_CLIFOR  := _cCliente
			BBT->BBT_VALOR   := _nValor
			BBT->BBT_CODPLA  := _cCodPla
			BBT->BBT_VERSAO  := _cVersao
			//BBT->BBT_HIST    := "Fatura Ref.: Mes
			MsUnlock()
			lGrvBBT := .T.
			
		Else
			//If AllTrim(FunName()) != "CABA010" // Comentado por marcela coimbra em 16/05/2012 (nao executar na rotina de negociação)
			If AllTrim(FunName()) != "CABA010" .and. AllTrim(FunName()) != "CABA210"
				MsgBox("Registro nao localizado no movimento do PLS ..: " + TFAT->E1_PREFIXO+TFAT->E1_NUM )
			EndIf
		Endif
		
	Endif
	
	DbSelectArea("SE1")
	DbGoto(TFAT->RecNoSe1)
	
	cNumTit   := SE1->E1_NUM
	cPrefixo  := SE1->E1_PREFIXO
	cTipo     := SE1->E1_TIPO
	cParcela  := SE1->E1_PARCELA
	nValTit2  := SE1->E1_VALLIQ  // Pega Valor da Ultima Baixa do Titulo
	cMesBase  := SE1->E1_MESBASE
	cAnoBase  := SE1->E1_ANOBASE
	cChave    := SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO
	
	//Titulo gerado pela rotina de parcemaneto
	lParcelamento :=  fVerParc(cPrefixo,cParcela,cNumTit,cTipo,cMesBase,cAnoBase)
	If lParcelamento
		lCABE999 := .F. 
    Else 		        
        lCABE999 := .T. 
	Endif
	                                   	
	// Altera status to título informando que foi baixado por fatura.
	SE1->(RecLock("SE1",.F.))
	SE1->E1_YTPEXP := "S" //Baixa por Fatura - TABELA K1
	SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"S", "X5_DESCRI")
	SE1->(MsUnlock())
	
	//TESTA SE VARIAVEL FOI CRIADA PELO FINANCEIRO
/*	If Type("lCABE999") == "U"
		lCABE999 := .F.
	Endif
*/	
	IF SE1->E1_BAIXA > SE1->E1_VENCREA  .AND. lCABE999 // PAULO MOTTA BAIXA RIOPREVI
		
		
		cQuery := "   SELECT BBT_NIVEL,BBT_CODOPE,BBT_MATRIC,BBT_CODEMP,BBT_CONEMP,BBT_VERCON,BBT_SUBCON, "
		cQuery += "   BBT_VERSUB,R_E_C_N_O_ RECNOBBT "
		cQuery += "   FROM " + RetSqlName("BBT")
		cQuery += "   WHERE BBT_FILIAL = '" + xFilial("BBT") + "' "
		cQuery += "   AND   D_E_L_E_T_ = ' ' "
		cQuery += "   AND '" + cPrefixo + "' = BBT_PREFIX "
		cQuery += "   AND '" + cNumTit  + "' = BBT_NUMTIT "
		cQuery += "   AND '" + cParcela + "' = BBT_PARCEL "
		cQuery += "   AND '" + cTipo    + "' = BBT_TIPTIT "
		cQuery += "   AND NOT EXISTS ( SELECT * FROM " + RETSQLNAME("BSQ") + " WHERE D_E_L_E_T_ = ' ' "
		cQuery += "   AND TRIM(BSQ_YNMSE1) = '" + ALLTRIM(cChave) + "' )"
		
		If TcSqlExec(cQuery) < 0
			Return
		Endif
		
		If Select("WTMP") > 0
			WTMP->(DbCloseArea())
		Endif
		
		DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'WTMP', .F., .T.)
		
		WTMP->(DBGOTOP())
		IF !EOF()
			
			DbSelectArea("BBT")
			DbGoTo(WTMP->RECNOBBT)
			
			If BBT->BBT_NIVEL == "4"
				BA3->(DbSetOrder(1))
				BA3->(MsSeek(xFilial("BA3")+BBT->BBT_CODOPE+BBT->BBT_CODEMP+BBT->BBT_MATRIC))
				
				_cCodInt  := BBT->BBT_CODOPE
				_cCodEmp  := BA3->BA3_CODEMP
				_cMatric  := BBT->BBT_MATRIC
				_cConEmp  := BA3->BA3_CONEMP
				_cVerCon  := BA3->BA3_VERCON
				_cSubCon  := BA3->BA3_SUBCON
				_cVerSub  := BA3->BA3_VERSUB
				_cNiveCob := BBT->BBT_NIVEL
			Else
				_cCodInt := BBT->BBT_CODOPE
				_cCodEmp := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CODEMP,Space(25))
				_cMatric  := BBT->BBT_MATRIC
				_cConEmp := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CONEMP,Space(25))
				_cVerCon := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERCON,Space(10))
				_cSubCon := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_SUBCON,Space(25))
				_cVerSub := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERSUB,Space(10))
				_cNiveCob := BBT->BBT_NIVEL
			Endif
		Else
			MsgBox(  " ATENCAO!!! Os valores de juros nao serao calculados para este titulo ",;
			+ " Tit. Nao localizado no modulo PLS ..: " + TFAT->E1_PREFIXO+TFAT->E1_NUM )
			DbSelectArea("TFAT")
			dbSkip()
			Loop
		Endif
		
		/*
		ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
		±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		chama funcao para calculo de juros + multa+ igpm passando como parametro :
		(cod Cliente,Data Titulo,Data Baixa,Valor Titulo)
		Nao Gera IGPM Abril/09 - Motta
		±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
		*/         

		IF ((qtdaFat > 1 .and. _cParcFat == '2') .or. qtdaFat  == 1 ) .and. cFazMulJu == 'S' .and. 	qtdaFat > 0
		   nValMult := U_CABA997(SE1->E1_VENCREA,SE1->E1_BAIXA,SE1->E1_VALLIQ,.F.,SE1->E1_CODEMP,"FA280")
		   nValTit  += nValMult  // pega valor Devido
		End If 
		 
		if nValTit <= 0
			lRet := .F.
			return  lRet
		endif
		
		// ALIMENTO _aDadUsr
		aDadUsr := {_cCodInt,_cCodEmp,_cMatric,_cConEmp,_cVerCon,_cSubCon,_cVerSub,_cNiveCob}
		
		// ALIMENTO _aParcela
		cAnoAdd  := SUBSTR(DTOS(SE1->E1_BAIXA),1,4)
		cMesAdd  := SUBSTR(DTOS(SE1->E1_BAIXA),5,2)
		
		IF  (SE5->E5_MOTBX $"NOR") //Inserido para so gerar cobrança de baixa em atraso no caso de baixas normais.//Gedilson
			aadd(_aParcela,{cAnoAdd+cMesAdd,nValTit,cMesAdd+"/"+cAnoAdd,GetNewPar("MV_YCDLJ3","993"),"","","Baixa Em Atraso"})
		EndIf
		
		
		/*
		ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
		±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		Chamo Rotina para geracao de adicionais dos titulos baixados para este cliente
		±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
		*/
		
		If Len(_aParcela) > 0 .AND.  !U_GerAdNeg(_aParcela,aDadUsr,ALLTRIM(cChave))
			MsgAlert("Impossível criar adicional para o(s) mês(es) solicitado(s) . Verifique!")
			lRet := .F.
		Else
			//	MsgAlert("Adicional(is) criado(s) com sucesso para o Título : " + cNumTit,"Atenção!")
		Endif
		
	ENDIF // TRATAMENTO DE ATRASADO
	
	DbSelectArea("TFAT")
	DbSkip()
	
Enddo                    

// Altamiro - 04/04/2017 - grava juros e multa na 1 parcela da fatura no campo e1_acrescimo      

IF ((qtdaFat > 1 .and. _cParcFat == '2') .or. (qtdaFat  == 1 .and. _cParcFat == '1' )) .and. cFazMulJu == 'S'

    DbSelectArea("SE1")
    DbSetOrder(1)   
 
    If DbSeek(xFilial("SE1") + _cPrefFat + _cNumFat + _cParcFat + _cTipoFat)      
       RecLock("SE1",.F.)
          SE1->E1_ACRESC  += nValTit  // Valor da atualização financeira 
          SE1->E1_SALDO   += nValTit  // Valor da atualização financeira 
          SE1->E1_VALOR   += nValTit  // Valor da atualização financeira    
          SE1->E1_VLCRUZ  += nValTit  // Valor da atualização financeira
       MsUnlock()  
    EndIF
EndIf        
   
 //////

RestArea(aAreaOld)

Return .t.

************************************************************************
Static Function fVerParc(cPrefix,cParcel,cNumTit,cTipo,cMesBase,cAnoBase)
************************************************************************
Local cQry := " "
Local lRet := .F.

cQry := " SELECT COUNT(*) CONT FROM CABE010R3 "
cQry += " WHERE "
cQry += " PREFIXO = '" + cPrefix + "' AND "
cQry += " PARCELA = '" + cParcel + "' AND "
cQry += " NUMERO  = '" + cNumtit + "' AND "
cQry += " TIPO    = '" + cTipo   + "'"// AND "
//cQry += " MESBASE = '" + cMesBase+ "' AND "
//cQry += " ANOBASE = '" + cAnoBase+ "'"

If Select("TMQ") > 0
	TMQ->(DbCloseArea())
Endif

DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'TMQ', .F., .T.)
TMQ->(DBGOTOP())

IF TMQ->CONT > 0          

   If ApMsgYesNo("Titulo em Negociação , deseja Calcula Multa e Juros ? ","SIMNAO")		       

       lRet := .F.

   Else        

       lRet := .T.

   EndIf 

Endif

Return lRet
