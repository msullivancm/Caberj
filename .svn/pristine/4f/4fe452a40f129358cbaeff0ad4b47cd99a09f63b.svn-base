/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABA998 	∫Autor  ≥Eduardo Brust       ∫ Data ≥  11/04/2007      ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥LANCAMENTO DE ATRASADOS NO PLS E TRATAMENTO DE JANELAS		   ∫±±
±±∫          ≥                                                            	   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Financeiro                                                 	   ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
#INCLUDE "PROTHEUS.CH"
#Include "TopConn.Ch"

User Function CABA998()
Local oDlg     := Nil
Local cTitulo  := "LANCAMENTO DE ATRASADOS NO PLS E TRATAMENTO DE JANELAS"
Local oLbx     := Nil
Private cPerg  := "CAB004" 
Private lOk  := .t. // indica que todos os processamentos foram realizados com sucesso.
Private dDataRef	:= ctod("")
Private cMesAdd		:= ""
Private cAnoAdd		:= ""

ValidPerg()
if ! Pergunte(cPerg,.T.)
	return
endif

dDataRef	:= mv_par01
cMesAdd		:= mv_par02
cAnoAdd		:= mv_par03 

//chama funcao de tratamento de janelas
Janela()

//chama funcao de Negociacao
Negociacao(cMesAdd,cAnoAdd)
if lOk 
	Aviso("Parcelamento","Lancamentos Gerados no Pls com Sucesso !",{"OK"})
endif
return

/*	
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
Funcao....: Janela
Finalidade: Seleciona Titulos em janela
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function Janela()
Local cQuery
Local nQtdDia := GetNewPar("MV_TOLJAN",60)
Private aVetor   := {}
Private aVetor2   := {}
Private aAreaAtu

cQuery := " SELECT E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_LOJA,E1_NOMCLI,E1_SALDO,E1_VENCREA "
cQuery += "   FROM " + RetSqlName("SE1") + " SE1, " + RetSqlName("BBT") + " BBT "
cQuery += " WHERE E1_FILIAL       = '" + xFilial("SE1") + "' "
cQuery += "   AND BBT_FILIAL = '" + xFilial("BBT") + "' "
cQuery += "   AND SE1.D_E_L_E_T_ = ' ' "
cQuery += "   AND BBT.D_E_L_E_T_ = ' ' "
cQuery += "   AND E1_PREFIXO = BBT_PREFIX "
cQuery += "   AND E1_NUM = BBT_NUMTIT "
cQuery += "   AND E1_PARCELA = BBT_PARCEL "
cQuery += "   AND E1_TIPO = BBT_TIPTIT "
cQuery += "   AND E1_SALDO > 0 "
cQuery += "   AND E1_VENCREA     <= '" + DTOS(mv_par01-nQtdDia) + "' "
//Retirando titulos migrados (fixo prefixo PLS). Motta
cQuery += "   AND E1_ORIGEM = 'PLSA510' "

//<<<<<<<<<<<<<<<<

cQuery += "   ORDER BY E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_LOJA,E1_NOMCLI,E1_SALDO,E1_VENCREA "

TcQuery cQuery Alias "TMP" New
MemoWrite("C:\CAB004.SQL", cQuery)

DbSelectArea("TMP")
DbGoTop()
If Eof()
	Aviso("Janelas","Nao ha dados a serem exibidos.",{"OK"})
	DbSelectArea("TMP")
	DbCloseArea()
	Return
EndIf

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+

While !Eof()
	aAreaAtu   := GetArea()
	cQuery := " SELECT E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_NOMCLI,E1_SALDO,E1_VENCREA "
	cQuery += "    FROM " + RetSqlName("SE1") + " SE1, " + RetSqlName("BBT") + " BBT "
	cQuery += " WHERE E1_FILIAL       = '" + xFilial("SE1") + "' "
	cQuery += "   AND BBT_FILIAL = '" + xFilial("BBT") + "' "
	cQuery += "   AND SE1.D_E_L_E_T_ = ' ' "
	cQuery += "   AND BBT.D_E_L_E_T_ = ' ' "
	cQuery += "   AND E1_PREFIXO = BBT_PREFIX "
	cQuery += "   AND E1_NUM = BBT_NUMTIT "
	cQuery += "   AND E1_PARCELA = BBT_PARCEL "
	cQuery += "   AND E1_TIPO = BBT_TIPTIT "
    cQuery += "   AND E1_SALDO = 0 " // PARA OBTER TITULOS EM JANELA PARA AQUELE TITULO QUE ESTA EM ABERTO
	cQuery += "   AND E1_CLIENTE = '" + TMP->E1_CLIENTE + "' "
	cQuery += "   AND E1_PREFIXO = '" + TMP->E1_PREFIXO + "' "
	cQuery += "   AND E1_TIPO = '" + TMP->E1_TIPO + "' "
	cQuery += "   AND E1_PARCELA >= '" + TMP->E1_PARCELA + "'"
	cQuery += "   AND E1_VENCREA >= '" + TMP->E1_VENCREA + "'" 
    cQuery += "   ORDER BY E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_NOMCLI,E1_SALDO,E1_VENCREA "
	
	TcQuery cQuery Alias "TMP2" New
	MemoWrite("C:\CAB004b.SQL", cQuery)
	DbSelectArea("TMP2")
	DbGoTop()
	If !Eof()
		DbSelectArea("TMP2")
		DbCloseArea()
		RestArea(aAreaAtu) 
							
		aAdd( aVetor2, { TMP->E1_PREFIXO,TMP->E1_NUM, TMP->E1_PARCELA,TMP->E1_TIPO,"JAN",dDataBase,dDataBase,"Janela",;
		TMP->E1_SALDO,TMP->E1_CLIENTE,TMP->E1_VENCREA,TMP->E1_VENCREA,dDataRef} ) // VETOR QUE GUARDA INFORMACOES DE CADA TITULO EM JANELA
	else
		DbSelectArea("TMP2")
		DbCloseArea()
		RestArea(aAreaAtu)
	endif
	dbSkip()
End

//LIMPANDO AREA EM MEMORIA
If Select("TMP") > 0
	dbSelectArea("TMP") ; dbCloseArea()
EndIf
If Select("TMP2") > 0
	dbSelectArea("TMP2") ; dbCloseArea()
EndIf

If Len( aVetor2 ) > 0
	BaixaJan() // chama funcao de baixa de tÌtulos
endif

Return 

/*	
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
 Funcao......: BaixaJan
 Finalidade..: Baixa titulos em janela
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static function BaixaJan()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

// DECLARACAO DE VARIAVEIS
Local aVetor3 := {} // vetor que alimenta o execauto
Local _aParcela :={} // vetor que sera passado para funcao GerAdNeg
Local aDadUsr := {} // vetor com dados do usuario

// INFORMACOES QUE SERAO PASSADAS PARA O VETOR aDadUsr
Local _cCodInt
Local _cNivCob
Local _cCodFam	:= Space(25)
Local _cCodEmp	:= Space(04)
Local _cConEmp	:= Space(25)
Local _cVerCon	:= Space(10)
Local _cSubCon	:= Space(25)
Local _cVerSub	:= Space(10)
// INFORMACOES QUE SERAO PASSADAS PARA O VETOR aDadUsr 
Public nValTit2  // ira pegar o valor do titulo baixado atraves da variavel nValRec visivel no ponto de entrada fa070tit

For i:=1 to Len(aVetor2)
	lMsErroAuto := .F.
	lCabe999 := .F.
	//MONTA VETOR QUE SERA PASSADO PARA EXECAUTO DE BAIXA
	aVetor3 := {{"E1_PREFIXO"	 ,aVetor2[i,1]	,Nil},;
	{"E1_NUM"		 			 ,aVetor2[i,2]	,Nil},;
	{"E1_PARCELA"	 			 ,aVetor2[i,3]	,Nil},;
	{"E1_TIPO"	    			 ,aVetor2[i,4]	,Nil},;
	{"AUTMOTBX"	    			 ,aVetor2[i,5]	,Nil},;
	{"AUTDTBAIXA"	 			 ,aVetor2[i,6]	,Nil},;
	{"AUTDTCREDITO" 			 ,aVetor2[i,7]	,Nil},;
	{"AUTHIST"	    			 ,aVetor2[i,8]	,Nil},;
	{"AUTVALREC"	 			 ,aVetor2[i,9]	,Nil }}
	MSExecAuto({|x,y| fina070(x,y)},aVetor3,3) //Inclusao
	
	If lMsErroAuto
		cpath := "\erro_baixa" //PASTA CRIADA ABAIXO DO AP_DATA
		cFile := dtos(dDatabase)+ "_" + aVetor2[i,1]+".log"
		MostraErro(cpath, cFile)//GRAVA LOG DE ERRO NA BAIXA DE TITULOS
	else 
				lCabe999 := .T.
				BBT->(DbSetOrder(7)) //BBT_PREFIX+BBT_NUMTIT+BBT_PARCEL+BBT_TIPTIT+BBT_RECPAG
				BBT->(MsSeek(xFilial("BBT")+aVetor2[i,1]+aVetor2[i,2]+aVetor2[i,3]+aVetor2[i,4]))
				
				If BBT->BBT_NIVEL == "4" 
					BA3->(DbSetOrder(1)) 
			        BA3->(MsSeek(xFilial("BA3")+BBT->BBT_CODOPE+BBT->BBT_CODEMP+BBT->BBT_MATRIC))
			        _cCodInt  := BBT->BBT_CODOPE
					_cCodEmp  := BBT->BBT_CODEMP
					_cMatric  := BBT->BBT_MATRIC
			   		_cConEmp  := BA3->BA3_CONEMP
					_cVerCon  := BA3->BA3_VERCON
					_cSubCon  := BA3->BA3_SUBCON
					_cVerSub  := BA3->BA3_VERSUB
			   		_cNiveCob := BBT->BBT_NIVEL
				Else
				  	_cCodInt  := BBT->BBT_CODOPE
					_cCodEmp  := BBT->BBT_CODEMP
					_cMatric  := BBT->BBT_MATRIC
			   		_cConEmp  := BBT->BBT_CONEMP
			   		_cVerCon  := BBT->BBT_VERCON
					_cSubCon  := BBT->BBT_SUBCON
					_cVerSub  := BBT->BBT_VERSUB
					_cNiveCob := BBT->BBT_NIVEL
				Endif			
				
				// ALIMENTO _aDadUsr
				aDadUsr := {_cCodInt,_cCodEmp,_cMatric,_cConEmp,_cVerCon,_cSubCon,_cVerSub,_cNiveCob}
				
				// calculo juros+multa+igpm         
				nJuros := U_CABA997(stod(aVetor2[i,12]),aVetor2[i,13],nValTit2,.T.) // FSCAB003(DATAINI,DATAFIM,VALOR,CALC IGPM?.)
				nValTit2 := nValTit2 + nJuros
				
				// ALIMENTO _aParcela
				aadd(_aParcela,{cAnoAdd+cMesAdd,nValTit2,cMesAdd+"/"+cAnoAdd,GetNewPar("MV_YCDLJ2","992"),"","","Janela"})
				
				//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
				//≥ Chamo Rotina para geracao de adicionais dos titulos baixados para este cliente... ≥
				//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
				If !U_GerAdNeg(_aParcela,aDadUsr,aVetor2[i,1]+aVetor2[i,2]+aVetor2[i,3]+aVetor2[i,4])  // GerAdNeg(_aParcela,aDadUsr,CHAVE DO TITULO)      
					lOk  := .f.
					MsgAlert("ImpossÌvel criar adicional para o(s) mÍs(es) solicitado(s) . Verifique!")
				Else  
				//	MsgAlert("Adicional(is) criado(s) com sucesso para o TÌtulo Principal: " + cTitPri,"AtenÁ„o!")
				Endif			
			aDadUsr :={}
			_aParcela:={}			
	endif // If lMsErroAuto 
Next
return // BaixaJan    


/*	
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
Funcao....: Negociacao
Finalidade: Seleciona Titulos Negociados
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function Negociacao(cMesAdd,cAnoAdd)
Local cQuery
Local _cMesAdd := space(2)
Local _cAnoAdd := space(4)
Private aVetor   := {}
Private aVetor2   := {}
Private aAreaAtu

_cMesAdd := cMesAdd
_cAnoAdd := cAnoAdd

cQuery := " SELECT Z6_CHAVE,Z6_DATATIT,Z6_VALTIT,Z6_VALPLS,Z6_SEQ,Z6_GERADO "
cQuery += "   FROM " + RetSqlName("SZ6") + " SZ6"
cQuery += " WHERE Z6_GERADO = 'N' "
cQuery += "   AND SZ6.D_E_L_E_T_ = ' ' "
cQuery += "   AND Z6_DATATIT LIKE '" + _cAnoAdd + _cMesAdd + "%' "
cQuery += "   ORDER BY Z6_DATATIT "

TcQuery cQuery Alias "TMP" New
MemoWrite("C:\CAB004c.SQL", cQuery)

DbSelectArea("TMP")
DbGoTop()
If Eof()       
	lOk  := .f.
	Aviso("Parcelamento","Nao ha dados a serem exibidos.",{"OK"})
	DbSelectArea("TMP")
	DbCloseArea()
	Return
EndIf

//+-------------------------------------+
//| Carrega o vetor conforme a condicao |
//+-------------------------------------+

While !Eof() 
		dataParc := TMP->Z6_DATATIT
		valParc  := TMP->Z6_VALTIT
		cNumParc := TMP->Z6_SEQ
		aAreaAtu   := GetArea()		
		
		SE1->(DbSetOrder(1)) 
			SE1->(MsSeek(xFilial("SE1")+TMP->Z6_CHAVE))
									
		aAdd( aVetor2, { SE1->E1_PREFIXO,SE1->E1_NUM, SE1->E1_PARCELA,SE1->E1_TIPO,"NEG",dDataBase,dDataBase,"Negociacao - Parcela: "+cNumParc,;
		SE1->E1_SALDO,SE1->E1_CLIENTE,SE1->E1_VENCREA,SE1->E1_VENCREA,dataParc,valParc} ) // VETOR QUE GUARDA INFORMACOES DE CADA TITULO NEGOCIADO
		
	RestArea(aAreaAtu)
	dbSkip()
End

//LIMPANDO AREA EM MEMORIA
If Select("TMP") > 0
	dbSelectArea("TMP") ; dbCloseArea()
EndIf

If Len( aVetor2 ) > 0
	BaixaNeg(_cMesAdd,_cAnoAdd) // chama funcao de baixa de tÌtulos Negociados
endif

Return 
            
/*	
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
 Funcao......: BaixaNeg
 Finalidade..: Baixa titulos Negociados
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static function BaixaNeg(_cMAdd,_cAAdd)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

// DECLARACAO DE VARIAVEIS
Local _aParcela :={} // vetor que sera passado para funcao GerAdNeg
Local aDadUsr := {} // vetor com dados do usuario

// INFORMACOES QUE SERAO PASSADAS PARA O VETOR aDadUsr
Local _cCodInt
Local _cNivCob
Local _cCodFam	:= Space(25)
Local _cCodEmp	:= Space(04)
Local _cConEmp	:= Space(25)
Local _cVerCon	:= Space(10)
Local _cSubCon	:= Space(25)
Local _cVerSub	:= Space(10)
// INFORMACOES QUE SERAO PASSADAS PARA O VETOR aDadUsr 
Public nValTit2  // ira pegar o valor do titulo baixado atraves da variavel nValRec visivel no ponto de entrada fa070tit

For i:=1 to Len(aVetor2)
	
	lCabe999 := .T.
	BBT->(DbSetOrder(7)) //BBT_PREFIX+BBT_NUMTIT+BBT_PARCEL+BBT_TIPTIT+BBT_RECPAG
	BBT->(MsSeek(xFilial("BBT")+aVetor2[i,1]+aVetor2[i,2]+aVetor2[i,3]+aVetor2[i,4]))			
	
	If BBT->BBT_NIVEL == "4" 
		BA3->(DbSetOrder(1)) 
		BA3->(MsSeek(xFilial("BA3")+BBT->BBT_CODOPE+BBT->BBT_CODEMP+BBT->BBT_MATRIC))
		_cCodInt  := BBT->BBT_CODOPE
		_cCodEmp  := BBT->BBT_CODEMP
		_cMatric  := BBT->BBT_MATRIC
		_cConEmp  := BA3->BA3_CONEMP
		_cVerCon  := BA3->BA3_VERCON
		_cSubCon  := BA3->BA3_SUBCON
		_cVerSub  := BA3->BA3_VERSUB
		_cNiveCob := BBT->BBT_NIVEL
	Else
		_cCodInt  := BBT->BBT_CODOPE
		_cCodEmp  := BBT->BBT_CODEMP
		_cMatric  := BBT->BBT_MATRIC
		_cConEmp  := BBT->BBT_CONEMP
		_cVerCon  := BBT->BBT_VERCON
		_cSubCon  := BBT->BBT_SUBCON
		_cVerSub  := BBT->BBT_VERSUB
		_cNiveCob := BBT->BBT_NIVEL
	Endif	
		                                                                                       
	// ALIMENTO _aDadUsr
	aDadUsr := {_cCodInt,_cCodEmp,_cMatric,_cConEmp,_cVerCon,_cSubCon,_cVerSub,_cNiveCob}

	// calculo juros+multa+igpm         
	nJuros := U_CABA997(aVetor2[i,12],stod(aVetor2[i,13]),aVetor2[i,14],.T.) // FSCAB003(DATAINI,DATAFIM,VALOR,CALC IGPM?.)
	valParc2 := aVetor2[i,14]
	valParc2 := valParc2 + nJuros
				
	// ALIMENTO _aParcela
	aadd(_aParcela,{_cAAdd+_cMAdd,valParc2,_cMAdd+"/"+_cAAdd,GetNewPar("MV_YCDLJ1","991"),"","",aVetor2[i,8]}) 
				                                             
	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥ Chamo Rotina para geracao de adicionais dos titulos baixados para este cliente... ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	If !U_GerAdNeg(_aParcela,aDadUsr,aVetor2[i,1]+aVetor2[i,2]+aVetor2[i,3]+aVetor2[i,4])  // GerAdNeg(_aParcela,aDadUsr,CHAVE DO TITULO)      
		 MsgAlert("ImpossÌvel criar adicional para o(s) mÍs(es) solicitado(s) . Verifique!") 
		lOk  := .f.
	Else
		dbSelectArea("SZ6") 
		dbSetOrder(1)
		IF dbSeek(xFilial("SZ6")+ aVetor2[i,1]+aVetor2[i,2]+aVetor2[i,3]+aVetor2[i,4])
			RecLock("SZ6",.F.) // altera o registro
			SZ6->Z6_GERADO := "S" // GRAVA NO CAMPO Z6_GERADO...INFORMACAO DE QUE O TITULO FOI GERADO NO PLS
			SZ6->Z6_VALPLS := valParc2
			MsUnlock()
		endif
		dbSelectArea("SZ6") 
		dbCloseArea()	
	Endif			
	aDadUsr :={}
	_aParcela:={}			 
Next
return // BaixaNeg  

/*	
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
 Funcao......: ValidPerg
 Finalidade..: Valida parametros
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"1","Data de ReferÍncia para Janela: ","Data de ReferÍncia para Janela:","Data de ReferÍncia para Janela: ","mv_ch1","D",08,00,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"2","MÍs para Adicional: ","MÍs para Adicional:","MÍs para Adicional: ","mv_ch2","C",02,00,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"3","Ano para Adicional: ","Ano para Adicional:","Ano para Adicional: ","mv_ch3","C",04,00,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to Fcount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

dbSelectArea(_sAlias)

Return
