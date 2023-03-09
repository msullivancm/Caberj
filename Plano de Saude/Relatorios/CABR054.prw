#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'   
#INCLUDE 'UTILIDADES.CH'

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR054 ºAutor  ³Renato Peixoto        º Data ³  13/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de valor liberado para pagamento em uma determi- º±±
±±º          ³ nada data, por lote gerado.                                º±±
±±º          ³                                                            º±±   
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Eloiza/ Dr. Haroldo                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//criar um parametro a mais para julgar se considera ou nao os nao baixados, além dos baixados no intervalo especificado
User Function CABR054


Local cQuery       := ""
Local cQuery2      := "" 
Local cQueryM      := ""
Local cQueryR      := ""

Local cArqQry      := GetNextAlias()
Local cArqQry2     := GetNextAlias()  
Local cArqQryM     := GetNextAlias()
Local cArqQryR     := GetNextAlias()

Local nTotTit      := 0
Local nTotImp      := 0
Local nTotGer      := 0 
Local nTotSaldo    := 0
Local nTotPago     := 0

Private cPerg      := "CABR54"
Private aDadosRel  := {}
Private nTotReg    := 0
Private lSeparaLot := .F.
Private cVisaoRel  := "" 
Private cMotBaixa  := ""  
Private nDecresc   := 0   


CriaSX1() 

If !Pergunte(cPerg,.T.)
	Return
EndIf

If MV_PAR03 = 1
	lSeparaLot := .T.
Else
	lSeparaLot := .F.
EndIf
	            
If MV_PAR04 = 1
	cVisaoRel := "Contas"
Else
	cVisaoRel := "Financeiro"
EndIf

If cVisaoRel = "Contas"

	cQuery := "select e2_vencrea , "
	If lSeparaLot
		cQuery += "e2_pllote , "
	EndIf
	cQuery += "sum(e2_valor) vl_titpgto , "
	cQuery += "sum(e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof + e2_iss ) vl_ImpPgto , "
	cQuery += "sum(e2_valor + e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof + e2_iss ) vlr_totgerado "         
	cQuery += "from "+RetSqlName("SE2")+" SE2 "
	cQuery += "where e2_filial ='"+XFILIAL("SE2")+"' and d_E_L_E_T_ = ' ' and e2_vencrea >= '"+DTOS(MV_PAR01)+"' and e2_vencrea <='"+DTOS(MV_PAR02)+"'  and e2_origem = 'PLSMPAG' "
	cQuery += "and e2_tipo not in ('TX ','TXA','INS','ISS') "
	cQuery += "group by e2_vencrea  "
	If lSeparaLot
		cQuery += ", e2_pllote " 
		cQuery += "Order By E2_PLLOTE "
	EndIf

ElseIf MV_PAR10 = 1

	cQuery := "Select E2_baixa ,  E2_PREFIXO , E2_NUM , e2_parcela,  E2_TIPO , e2_fornece, e2_loja, E2_VENCREA,  e2_saldo,e2_valor , (e2_valor - e2_saldo) as valor_pago, E2_DECRESC, "
	//cQuery += "Select E2_baixa ,  E2_PREFIXO , E2_NUM , E2_TIPO , E2_VENCREA,  e2_saldo,e2_valor , (e2_valor - e2_saldo) as valor_pago, "
    cQuery += "sum(e2_valor + e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof+e2_ISS ) vlr_totgerado, "
    cQuery += "sum(e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof+e2_ISS) impostos "
    cQuery += "from "+RetSqlName("SE2")+" SE2 "
  	cQuery += "where e2_filial ='"+XFILIAL("SE2")+"' and d_E_L_E_T_ = ' ' and e2_vencrea >= '"+DTOS(MV_PAR01)+"' and e2_vencrea <='"+DTOS(MV_PAR02)+"'  and e2_origem = 'PLSMPAG' "
  	cQuery += "and e2_tipo not in ('TX ','TXA','INS','ISS') " //--and e2_saldo > 0 
    If !Empty(MV_PAR09)
        cQuery += "and  SUBSTR(e2_PLLOTE,1,6) >= '"+MV_PAR08+"' and SUBSTR(e2_PLLOTE,1,6) <= '"+MV_PAR09+"'    
        
    EndIf     
  	If !Empty(MV_PAR05) .AND. !Empty(MV_PAR06)
  		cQuery += "and ((e2_baixa between '"+DTOS(MV_PAR05)+"' and '"+DTOS(MV_PAR06)+"') "
  		If MV_PAR07 = 1
  			cQuery += " or (e2_baixa = ' ')) "
  		Else
  			cQuery += " ) "
  		EndIf 
  	EndIf
  	cQuery += "group by     E2_baixa ,  E2_PREFIXO , E2_NUM , e2_parcela, E2_TIPO , e2_fornece, e2_loja, E2_VENCREA, e2_saldo,e2_valor, (e2_valor - e2_saldo), E2_DECRESC, e2_pllote "
  	//cQuery += "group by     E2_baixa ,  E2_PREFIXO , E2_NUM , E2_TIPO , E2_VENCREA, e2_saldo,e2_valor, (e2_valor - e2_saldo), e2_pllote "
  	cQuery += "order by  e2_baixa "
  
EndIf                           

If Select(cArqQry)>0
	(cArqQry)->(DbCloseArea())
EndIf

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQry,.T.,.T.)

If (cArqQry)->(Eof())
	APMSGALERT("Atenção, não existem dados a serem exibidos com os parâmetros informados. Por favor, verifique os parâmetros e tente novamente.","Não há dados a serem exibidos!")
	Return
EndIf


If cVisaoRel = "Contas"

	If lSeparaLot
		aAdd ( aDadosRel, { "Vencimento", "Lote", "Valor do Título", "Valor dos Impostos", "Valor Total Gerado" } )
		
		//Rodo a query sem agrupar por lotes para pegar os totais..
		cQuery2 := "select e2_vencrea , "
		cQuery2 += "sum(e2_valor) vl_titpgto , "
		cQuery2 += "sum(e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof + e2_iss) vl_ImpPgto , "
		cQuery2 += "sum(e2_valor + e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof + e2_iss ) vlr_totgerado "         
		cQuery2 += "from "+RetSqlName("SE2")+" SE2 "
		cQuery2 += "where e2_filial ='"+XFILIAL("SE2")+"' and d_E_L_E_T_ = ' ' and e2_vencrea >= '"+DTOS(MV_PAR01)+"' and e2_vencrea <='"+DTOS(MV_PAR02)+"'  and e2_origem = 'PLSMPAG' "
		cQuery2 += "and e2_tipo not in ('TX ','TXA','INS','ISS') "
		cQuery2 += "group by e2_vencrea  "
		
		If Select(cArqQry2) > 0
			(cArqQry2)->(DbCloseArea())
		EndIf
	
		DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery2),cArqQry2,.T.,.T.)
	
		nTotTit := (cArqQry2)->vl_titpgto
		nTotImp := (cArqQry2)->vl_ImpPgto
		nTotger := (cArqQry2)->vlr_totgerado
	
	Else
		aAdd ( aDadosRel, { "Vencimento", "Valor do Título", "Valor dos Impostos", "Valor Total Gerado" } )
	EndIf
Else

	aAdd ( aDadosRel, { "Baixa", "Prefixo", "Número do Título", "Tipo", "Vencimento", "Saldo", "Valor do Título", "Valor Pago", "Valor Total Gerado", "Valor dos Impostos", "Número do Lote", "Motivo da Baixa", "Valor Decréscimo" ,"Parcela","Fornecedor","Loja" } )
		
EndIf

nTotReg := Len(aDadosRel)

While !((cArqQry)->(Eof()))
	
	If cVisaoRel = "Contas"
	
		If lSeparaLot
			aAdd ( aDadosRel, { STOD((cArqQry)->e2_vencrea), (cArqQry)->e2_pllote, (cArqQry)->vl_titpgto, (cArqQry)->vl_ImpPgto, (cArqQry)->vlr_totgerado } )
		Else
			aAdd ( aDadosRel, { STOD((cArqQry)->e2_vencrea), (cArqQry)->vl_titpgto, (cArqQry)->vl_ImpPgto, (cArqQry)->vlr_totgerado } )
	
		EndIf
	
	Else
		//busca o motivo da baixa, quando for o caso (data de baixa estiver preenchida
		If !Empty((cArqQry)->E2_BAIXA)
			//verifica pela chave da SE5: E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA
			cMotBaixa := BscMotBaixa(xFilial("SE2")+(cArqQry)->E2_PREFIXO+(cArqQry)->E2_NUM+(cArqQry)->E2_PARCELA+(cArqQry)->E2_TIPO+(cArqQry)->E2_FORNECE+(cArqQry)->E2_LOJA)
		Else
			cMotBaixa := ""
		EndIf
		
		aAdd ( aDadosRel, { (cArqQry)->E2_BAIXA, (cArqQry)->E2_PREFIXO, (cArqQry)->E2_NUM, (cArqQry)->E2_TIPO, (cArqQry)->E2_VENCREA, (cArqQry)->E2_SALDO,;
		(cArqQry)->E2_VALOR, (cArqQry)->VALOR_PAGO, (cArqQry)->VLR_TOTGERADO, (cArqQry)->IMPOSTOS, (cArqQry)->E2_PLLOTE, cMotBaixa, (cArqQry)->E2_DECRESC, (cArqQry)->E2_PARCELA,;
		(cArqQry)->E2_FORNECE, (cArqQry)->E2_LOJA  } )
		nTotTit   += (cArqQry)->E2_VALOR
		nTotImp   += (cArqQry)->IMPOSTOS
		nTotGer   += (cArqQry)->VLR_TOTGERADO
		nTotSaldo += (cArqQry)->E2_SALDO
		nTotPago  += (cArqQry)->VALOR_PAGO
		
	EndIf
    
    (cArqQry)->(DbSkip())
    
EndDo

If cVisaoRel = "Contas

	If lSeparaLot
		//aAdd ( aDadosRel, { "", "", "", "", ""} )
		aAdd ( aDadosRel, { "", "", "Total Títulos: "+AllTrim(Transform(nTotTit,"@E 999,999,999.99")),"Total Impostos: "+AllTrim(Transform(nTotImp,"@E 999,999,999.99")),"Total Gerado: "+AllTrim(Transform(nTotGer,"@E 999,999,999.99")) } )
	EndIf
	
Else
    
	aAdd ( aDadosRel, { "", "", "", "", "", "Total Saldo: "+AllTrim(Transform(nTotSaldo,"@E 999,999,999.99")), "Total Títulos: "+AllTrim(Transform(nTotTit,"@E 999,999,999.99")),"Total Pago: "+AllTrim(Transform(nTotPago,"@E 999,999,999.99")),"Total Gerado: "+AllTrim(Transform(nTotGer,"@E 999,999,999.99")),"Total Impostos: "+AllTrim(Transform(nTotImp,"@E 999,999,999.99")) } )
	
EndIf

GERAREL()

If APMSGYESNO("Deseja gerar este relatório também em uma planilha Excel?","Geração do relatório em Excel.")
	DlgToExcel({{"ARRAY","Valor liberado para pagamento por data informada.","",aDadosRel}})
EndIf

Return 


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GERAREL  ³ Autor ³ Renato Peixoto        ³ Data ³ 13/09/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Gera o relatório no sistema.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GERAREL(Vetor)                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function GeraRel()
                              

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relatório Valor Lib Pagto por Data"
Local cPict          := ""
Local titulo         := "Rel. Vlr Lib Pagto por Data"
Local nLin           := 80
                                                                                                                                             //cheguei um pra tras  //+1  +1            +1          +1                         +1              +1
Local Cabec1         := IIF(cVisaoRel = "Contas","Vencimento     Lote  	      Valor Título     Valor Impostos      Valor Gerado","Dt. Baixa    Prefixo     Num. Tit.    Tipo  Vencimento          Saldo       Vlr S/ Impostos        Vlr Pago      Vlr Tot. Gerado      Vlr Impostos      Num.Lote      Motivo de Baixa             Valor Decréscimo")
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := IIF(cVisaoRel = "Contas",80,220)
Private tamanho      := IIF(cVisaoRel = "Contas","P","G")
Private nomeprog     := "CABR054" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR054" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString      := ""
/*
dbSelectArea("")
dbSetOrder(1)
 */

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  13/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem 
Local i := 0
/*
dbSelectArea(cString)
dbSetOrder(1)
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(nTotReg)

cMotBaixa := ""

For i := 2 To Len(aDadosRel)
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica o cancelamento pelo usuario...                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If cVisaoRel <> "Contas"
   		If i <> Len(aDadosRel)//tenho que fazer esse tratamento porque a ultima linha do vetor contem apenas 10 posicoes
   			nDecresc := aDadosRel[i][13]
   		EndIf
   EndIf 
   
   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impressao do cabecalho do relatorio. . .                            ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif

   If cVisaoRel = "Contas"
   
   		If lSeparaLot 
   			If i = Len(aDadosRel)
   				nLin+=2
   				@nLin,00 PSAY AllTrim(aDadosRel[i][3])
   				nLin++
   				@nLin,00 PSAY AllTrim(aDadosRel[i][4])
   				nLin++
   				@nLin,00 PSAY AllTrim(aDadosRel[i][5])
   			Else
   				@nLin,00 PSAY aDadosRel[i][1]
   			    @nLin,15 PSAY aDadosRel[i][2]
   				@nLin,27 PSAY aDadosRel[i][3] PICTURE "@E 999,999,999.99"
   				@nLin,42 PSAY aDadosRel[i][4] PICTURE "@E 999,999,999.99"
   				@nLin,60 PSAY aDadosRel[i][5] PICTURE "@E 999,999,999.99"
   			EndIf
   		Else                             
   			@nLin,00 PSAY aDadosRel[i][1]
   			@nLin,27 PSAY aDadosRel[i][2] PICTURE "@E 999,999,999.99"
   			@nLin,42 PSAY aDadosRel[i][3] PICTURE "@E 999,999,999.99"
   			@nLin,60 PSAY aDadosRel[i][4] PICTURE "@E 999,999,999.99"
   		EndIf
    
    Else
        //aAdd ( aDadosRel, { (cArqQry)->E2_BAIXA, (cArqQry)->E2_PREFIXO, (cArqQry)->E2_NUM, (cArqQry)->E2_TIPO, (cArqQry)->E2_VENCREA, (cArqQry)->E2_SALDO,;
		//(cArqQry)->E2_VALOR, (cArqQry)->VALOR_PAGO, (cArqQry)->VLR_TOTGERADO, (cArqQry)->IMPOSTOS, (cArqQry)->E2_PLLOTE }, (cArqQry)->E2_PARCELA, (cArqQry)->E2_FORNECE, (cArqQry)->E2_LOJA  )
        //chave se5: E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA
        If i <> Len(aDadosRel)
        	If aDadosRel[i][8] > 0 //.AND. (aDadosRel[i][6] < aDadosRel[i][8] .AND. aDadosRel[i][6] < aDadosRel[i][7]) 
        		cMotBaixa := BscMotBaixa(xFilial("SE2")+aDadosRel[i][2]+aDadosRel[i][3]+aDadosRel[i][14]+aDadosRel[i][4]+aDadosRel[i][15]+aDadosRel[i][16])
        	EndIf
    	EndIf

    	If i = Len(aDadosRel)
   			nLin+=2
   			@nLin,00 PSAY AllTrim(aDadosRel[i][5])
   			nLin++
   			@nLin,00 PSAY AllTrim(aDadosRel[i][6])
   			nLin++
   			@nLin,00 PSAY AllTrim(aDadosRel[i][7])
            nLin++
   			@nLin,00 PSAY AllTrim(aDadosRel[i][8])
   			nLin++
   			@nLin,00 PSAY AllTrim(aDadosRel[i][9])
   			nLin++
   			@nLin,00 PSAY AllTrim(aDadosRel[i][10])   			
   		Else
   			@nLin,00  PSAY STOD(aDadosRel[i][1])
   		    @nLin,15  PSAY aDadosRel[i][2]
   			@nLin,25  PSAY aDadosRel[i][3] 
   			@nLin,39  PSAY aDadosRel[i][4] 
   			@nLin,45  PSAY STOD(aDadosRel[i][5])
   			If aDadosRel[i][6] = aDadosRel[i][7]
   				@nLin,56  PSAY (aDadosRel[i][6]-nDecresc) PICTURE "@E 99,999,999.99"	
   			Else
   				@nLin,56  PSAY aDadosRel[i][6] PICTURE "@E 99,999,999.99"
   			EndIf
   			@nLin,77  PSAY aDadosRel[i][7] PICTURE "@E 99,999,999.99"
   			@nLin,93  PSAY aDadosRel[i][8] PICTURE "@E 99,999,999.99"
   			@nLin,114 PSAY aDadosRel[i][9] PICTURE "@E 99,999,999.99"
   			@nLin,133 PSAY aDadosRel[i][10]PICTURE "@E 99,999,999.99"
   			@nLin,150 PSAY aDadosRel[i][11]
   			@nLin,172 PSAY cMotBaixa
   			If aDadosRel[i][6] = aDadosRel[i][7]
   				@nLin, 185 PSAY nDecresc PICTURE "@E 99,999,999.99"
   			EndIf
   		EndIf
   	EndIf
    
    nLin := nLin + 1 // Avanca a linha de impressao

   
Next i

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If cVisaoRel = "Contas"
	nLin += 3
	@nLin,10 PSAY "_______________________"
	@nLin,40 PSAY "_______________________"
	nLin+=2
	@nLin,13 PSAY "JOSE PAULO MACEDO"
	@nLin,45 PSAY "ELOIZA COUTO"
Else
	nLin += 3
	@nLin,40 PSAY "_______________________"
	@nLin,75 PSAY "_______________________"
	nLin+=2
	@nLin,42 PSAY "JOSE PAULO MACEDO"
	@nLin,80 PSAY "ELOIZA COUTO"	
EndIf

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BscMotBaixaºAutor ³Renato Peixoto      º Data ³  14/10/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Busca o motivo da baixa quando for o caso.                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

***************************************************************
Static Function BscMotBaixa(cChaveE5)
***************************************************************
local cMotBx:= " " 
//if mv_par07 = 1
DbSelectArea("SE5")
DbSetOrder(7)
If  SE5->( DbSeek(cChaveE5) )

  While ! SE5->(eof()) .and. SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) == cChaveE5 .AND. SE5->E5_DTDISPO <= MV_PAR02

       cMotBx:=SE5->E5_MOTBX 

       SE5->(dbSkip()) 
    
  EndDo 
 
EndIf 
return ( cMotBx )



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CriaSX1  ³ Autor ³ Renato Peixoto        ³ Data ³ 13/09/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Cria/Atualiza perguntas.                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CriaSX1()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CriaSX1()

PutSx1(cPerg,"01",OemToAnsi("Data inicial de Pgto:")  ,"","","mv_ch1","D",08,0,0,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a data inicial desejada"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Data final de Pgto:")    ,"","","mv_ch2","D",08,0,0,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a data final desejada"},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("Separa por lotes?")      ,"","","mv_ch3","C",01,0,0,"C","","   ","","","mv_par03","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Visão Relatório:")       ,"","","mv_ch4","C",01,0,0,"C","","   ","","","mv_par04","Contas Medicas","","","","Financeiro","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Data Baixa de:")         ,"","","mv_ch5","D",08,0,0,"G","","   ","","","mv_par05",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a data inicial da baixa a ser filtrada no relatório"},{""},{""})
PutSx1(cPerg,"06",OemToAnsi("Data Baixa ate:")        ,"","","mv_ch6","D",08,0,0,"G","","   ","","","mv_par06",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a data final da baixa a ser filtrada no relatório"},{""},{""})
PutSx1(cPerg,"07",OemToAnsi("Considera não baxiados?"),"","","mv_ch7","C",01,0,0,"C","","   ","","","mv_par07","Sim","","","","Nao","","","","","","","","","","","",{"Considera também os títulos não baixados? (Sim/Não)"},{},{})
PutSx1(cPerg,"08",OemToAnsi("Comp. Inicial :")        ,"","","mv_ch8","C",06,0,0,"C","","   ","","","mv_par08",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a competecia do custo inicial a ser filtrada no relatório (AnoMes)"},{""},{""})
PutSx1(cPerg,"09",OemToAnsi("Comp. Final   :")        ,"","","mv_ch9","C",06,0,0,"C","","   ","","","mv_par09",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a competecia do custo final a ser filtrada no relatório(AnoMes)"},{""},{""})
PutSx1(cPerg,"10",OemToAnsi("Considera Pagto Medico?"),"","","mv_ch10","C",01,0,0,"C","","   ","","","mv_par10","Sim","","","","Nao","","","","","","","","","","","",{"Considera Pagto Medico ? (Sim/Não)"},{},{})
PutSx1(cPerg,"11",OemToAnsi("Considera OPME ?")       ,"","","mv_ch11","C",01,0,0,"C","","   ","","","mv_par11","Sim","","","","Nao","","","","","","","","","","","",{"Considera OPME ? (Sim/Não)"},{},{})
PutSx1(cPerg,"12",OemToAnsi("Considera Reembolso ?")  ,"","","mv_ch12","C",01,0,0,"C","","   ","","","mv_par12","Sim","","","","Nao","","","","","","","","","","","",{"Considera Reembolso ? (Sim/Não)"},{},{})
PutSx1(cPerg,"13",OemToAnsi("Considera Financeiro?")  ,"","","mv_ch13","C",01,0,0,"C","","   ","","","mv_par13","Sim","","","","Nao","","","","","","","","","","","",{"Considera Reembolso ? (Sim/Não)"},{},{})

Return          



