///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | cab001.prw| AUTOR |Eduardo Paiva Brust  | DATA | 09/02/2007     |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - U_cab001   ()                                          |//
//|           | Tratamento de Janelas de Recebimento de Titulos                 |//
//|           | 						  	        					    	|//
//|           | 		                                                		|//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR                | DESCRICAO                                 |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
#INCLUDE "PROTHEUS.CH"
#Include "TopConn.Ch"

User Function cab001()

Local oDlg     := Nil
Local cTitulo  := "Tratamento de Janelas de Recebimento de Títulos"
Local cQuery
Local nDiasAt := 0
Local nQtdDia := GetNewPar("MV_TOLJAN",60)
Private cMesAdd := "  "
Private cAnoAdd := "    "
Private oLbx     := Nil
Private aVetor   := {}
Private aVetor2   := {}
Private aAreaAtu
Private cPerg   := "CAB001"  

ValidPerg()
Pergunte(cPerg,.T.)

dDataRef := mv_par01
cMesAdd := mv_par02
cAnoAdd := mv_par03 

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
//cQuery += "   AND E1_CLIENTE IN('013543','029099','024060','022794')"  // ********* RETIRAR APOS TESTES ********
cQuery += "   AND E1_SALDO > 0 "
cQuery += "   AND E1_VENCREA     <= '" + DTOS(mv_par01-nQtdDia) + "' "
cQuery += "   ORDER BY E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_LOJA,E1_NOMCLI,E1_SALDO,E1_VENCREA "

TcQuery cQuery Alias "TMP" New
MemoWrite("C:\CAB001.SQL", cQuery)

DbSelectArea("TMP")
DbGoTop()
If Eof()
	Aviso("Títulos","Nao ha dados a serem exibidos.",{"OK"})
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
	cQuery += "   AND E1_SALDO = 0 "
	cQuery += "   AND E1_CLIENTE = '" + TMP->E1_CLIENTE + "' "
	cQuery += "   AND E1_PREFIXO = '" + TMP->E1_PREFIXO + "' "
	cQuery += "   AND E1_TIPO = '" + TMP->E1_TIPO + "' "
	cQuery += "   AND E1_PARCELA >= '" + TMP->E1_PARCELA + "'"
	cQuery += "   AND E1_VENCREA >= '" + TMP->E1_VENCREA + "'"
	cQuery += "   ORDER BY E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_NOMCLI,E1_SALDO,E1_VENCREA "
	
	TcQuery cQuery Alias "TMP2" New
	
	DbSelectArea("TMP2")
	DbGoTop()
	If !Eof()
		DbSelectArea("TMP2")
		DbCloseArea()
		RestArea(aAreaAtu) 
		
		// calcula os dias em atraso para este titulo com base na data informada  				
		nDiasAt := DateDiffDay( dDataRef , stod(TMP->E1_VENCREA) )
		
		aAdd( aVetor2, { TMP->E1_PREFIXO,TMP->E1_NUM, TMP->E1_PARCELA,TMP->E1_TIPO,"JAN",dDataBase,dDataBase,"Tratamento de Janela",;
		TMP->E1_SALDO,TMP->E1_CLIENTE,TMP->E1_VENCREA,nDiasAt} ) // VETOR QUE GUARDA INFORMACOES DE CADA TITULO EM JANELA
		
		If Ascan(aVetor,{|x|x[1]==TMP->E1_CLIENTE}) == 0  // VETOR QUE MOSTRA CLIENTES EM JANELA NA TELA
			aAdd( aVetor, { TMP->E1_CLIENTE, TMP->E1_NOMCLI,TMP->E1_NUM,TMP->E1_SALDO,TMP->E1_VENCREA } )
		endif
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

If Len( aVetor ) == 0
	Aviso( cTitulo, "Nao existe título a consultar", {"Ok"} )
	Return
Endif


//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 240,500 PIXEL
@ 010,010 LISTBOX oLbx FIELDS HEADER ;
"Cod Cliente", "Nome Cliente" ;
SIZE 230,095 OF oDlg PIXEL ON DBLCLICK( u_EdList(oLbx:nAt)) //no DBCLICK chama funcao  oLbx:nAt onde estou posicionado

oLbx:SetArray( aVetor )
oLbx:bLine := {|| { aVetor[oLbx:nAt,1],;
aVetor[oLbx:nAt,2]}}


@ 106,180 BUTTON "Baixar" SIZE 28,12 PIXEL OF oDlg Action baixa()
@ 106,213 BUTTON "OK" SIZE 28,12 PIXEL ACTION oDlg:end()
ACTIVATE MSDIALOG oDlg CENTER

Return .T.

******************************************************************************
* Funcao......: ValidPerg                                                    												*
* Finalidade..: Valida parametros                                            												*
******************************************************************************
Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"1","Data de Referência para Janela: ","Data de Referência para Janela:","Data de Referência para Janela: ","mv_ch1","D",08,00,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"2","Mês para Adicional: ","Mês para Adicional:","Mês para Adicional: ","mv_ch2","C",02,00,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
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

// ROTINA DE BAIXA DE TITULOS
// 13/02/2007 - EDUARDO BRUST
Static function baixa()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

// DECLARACAO DE VARIAVEIS
Local aVetor3 := {} // vetor que alimenta o execauto
Local _aParcela :={} // vetor que sera passado para funcao GerAdNeg
Local aDadUsr := {} // vetor com dados do usuario
Local nvalTr := 0  // soma o valor da tr
Local nValTit1 := 0 // soma o valor dos titulos baixados por cliente
Local flag   := 0  // indica se pode ou nao gravar o nr do titulo na variavel cTitPri
Local aTitPri := {} // vetor que guardara informacoes do titulo principal
Local cTitPri // guarda o nr do titulo principal
Local cCli
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
Public nValTit  // ira pegar o valor do titulo baixado atraves da variavel nValRec visivel no ponto de entrada fa070tit

cCli := aVetor2[1,10] // PEGA O CODIGO DO PRIMEIRO CLIENTE DA TELA

For i:=1 to Len(aVetor2)
	lMsErroAuto := .F.
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
		IF cCli = aVetor2[i,10]
			nValTit1 += nValTit // nValTit esta recebendo valor da variavel nValRec ( total da baixa)
			if flag = 0
				flag := 1 // indica que nao deve gravar o titulo principal na variavel
				aAdd( aTitPri, { aVetor2[i,1]+aVetor2[i,2]+aVetor2[i,3]+aVetor2[i,4]} )
		    	cTitPri := aVetor2[i,2] 
			else	
				dbSelectArea("SE1") 
				dbSetOrder(1)
				IF dbSeek(xFilial("SE1")+ aVetor2[i,1]+aVetor2[i,2]+aVetor2[i,3]+aVetor2[i,4])
					RecLock("SE1",.F.) // altera o registro
					SE1->E1_XNUM := cTitPri // GRAVA O NR PRINCIPAL DO TITULO NOS DEMAIS TITULOS BAIXADOS PARA ESTE CLIENTE
					MsUnlock()
				endif			
			endif
		else     
		    // gera os add para o ultimo cliente lido
		    IF cCli <> aVetor2[i,10] .OR. i >= len(aVetor2)  // SE MUDAR DE CLIENTE OU FIM DO VETOR DE BAIXA 			
				BBT->(DbSetOrder(7)) //BBT_PREFIX+BBT_NUMTIT+BBT_PARCEL+BBT_TIPTIT+BBT_RECPAG
				BBT->(MsSeek(xFilial("BBT")+aTitPri[1,1]))			
				_cCodInt := BBT->BBT_CODOPE
				_cCodEmp := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CODEMP,Space(25))
				_cMatric  := BBT->BBT_MATRIC
				_cConEmp := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CONEMP,Space(25))
				_cVerCon := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERCON,Space(10))
				_cSubCon := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_SUBCON,Space(25))
				_cVerSub := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERSUB,Space(10))
				_cNiveCob := BBT->BBT_NIVEL
				
				// ALIMENTO _aDadUsr
				aDadUsr := {_cCodInt,_cCodEmp,_cMatric,_cConEmp,_cVerCon,_cSubCon,_cVerSub,_cNiveCob}

				// ALIMENTO _aParcela
				aadd(_aParcela,{cAnoAdd+cMesAdd,nValTit1,cMesAdd+"/"+cAnoAdd,GetNewPar("MV_YCDLJ6","996"),"","","Ajustes de Janela"})
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Chamo Rotina para geracao de adicionais dos titulos baixados para este cliente...                                                      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !U_GerAdNeg(_aParcela,aDadUsr,aTitPri[1,1])
					MsgAlert("Impossível criar adicional para o(s) mês(es) solicitado(s) . Verifique!")
				Else
				//	MsgAlert("Adicional(is) criado(s) com sucesso para o Título Principal: " + cTitPri,"Atenção!")
				Endif
			endif
			
			// pega o codigo do proximo cliente
			cCli := aVetor2[i,10] 
			flag := 0 // zero flag que indica que cTitPri := nr do titulo principal
			nValTit1 := 0  // zero o total do titulo baixado para o cliente
			aTitPri := {} // zero vetor de titulo principal
			cTitPri := "" // zero titulo principal 
			aDadUsr :={}
			_aParcela:={}			
			
			nValTit1 += nValTit // nValTit esta recebendo valor da variavel nValRec ( total da baixa)
			if flag = 0
				flag := 1 // indica que nao deve gravar o titulo principal na variavel
				aAdd( aTitPri, { aVetor2[i,1]+aVetor2[i,2]+aVetor2[i,3]+aVetor2[i,4]} )
		    	cTitPri := aVetor2[i,2]	
			else	
				dbSelectArea("SE1") 
				dbSetOrder(1)
				IF dbSeek(xFilial("SE1")+ aVetor2[i,1]+aVetor2[i,2]+aVetor2[i,3]+aVetor2[i,4])
					RecLock("SE1",.F.) // altera o registro
					SE1->E1_XNUM := cTitPri // GRAVA O NR PRINCIPAL DO TITULO NOS DEMAIS TITULOS BAIXADOS PARA ESTE CLIENTE
					MsUnlock()
				endif				
			endif //IF cCli <> aVetor2[i,10] .OR. i >= len(aVetor2)			
		endif //IF cCli = aVetor2[i,10]
	endif // If lMsErroAuto 
Next
BBT->(DbSetOrder(7)) //BBT_PREFIX+BBT_NUMTIT+BBT_PARCEL+BBT_TIPTIT+BBT_RECPAG
BBT->(MsSeek(xFilial("BBT")+aTitPri[1,1]))			
_cCodInt := BBT->BBT_CODOPE
_cCodEmp := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CODEMP,Space(25))
_cMatric  := BBT->BBT_MATRIC
_cConEmp := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_CONEMP,Space(25))
_cVerCon := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERCON,Space(10))
_cSubCon := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_SUBCON,Space(25))
_cVerSub := Iif(Empty(BBT->BBT_MATRIC),BBT->BBT_VERSUB,Space(10))
_cNiveCob := BBT->BBT_NIVEL
	                                                                                       
// ALIMENTO _aDadUsr
aDadUsr := {_cCodInt,_cCodEmp,_cMatric,_cConEmp,_cVerCon,_cSubCon,_cVerSub,_cNiveCob}

// ALIMENTO _aParcela
aadd(_aParcela,{cAnoAdd+cMesAdd,nValTit1,cMesAdd+"/"+cAnoAdd,GetNewPar("MV_YCDLJ6","996"),"","","Ajustes de Janela"})
				
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamo Rotina para geracao de adicionais dos titulos baixados para este cliente...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !U_GerAdNeg(_aParcela,aDadUsr,aTitPri[1,1])
	MsgAlert("Impossível criar adicional para o(s) mês(es) solicitado(s) . Verifique!")
Else
//	MsgAlert("Adicional(is) criado(s) com sucesso para o Título Principal: " + cTitPri,"Atenção!")
Endif
return // baixa
