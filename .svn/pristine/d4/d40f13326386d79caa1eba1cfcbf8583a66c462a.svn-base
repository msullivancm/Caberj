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
User Function CABR054A


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

private nTotTitP   := 0
private nTotImpP   := 0
private nTotGerP   := 0
private nTotSaldoP := 0
private nTotPagoP  := 0
private	nTotTitM   := 0
private	nTotImpM   := 0
private	nTotGerM   := 0
private	nTotSaldoM := 0
private	nTotPagoM  := 0
private	nTotTitR   := 0
private	nTotImpR   := 0
private nTotGerR   := 0
private	nTotSaldoR := 0
private	nTotPagoR  := 0
private ccontrole  := " "
Private cPerg      := "CABR54A"
Private aDadosRel  := {}
Private nTotReg    := 0
Private lSeparaLot := .F.
Private cVisaoRel  := "" 
Private cMotBaixa  := ""  
Private nDecresc   := 0      
private nConRda    := 1
private nConOpme   := 1 
private nConRemb   := 1    
private cQuery     := " "


CriaSX1() 

If !Pergunte(cPerg,.T.)
	Return
EndIf

nConRda    := MV_PAR10
nConOpme   := MV_PAR11 
nConRemb   := MV_PAR12     
cCodRda    := MV_PAR13 




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
		cQuery += "e2_pllote , 'P' TipoPgto"
	EndIf
	cQuery += "sum(e2_valor) vl_titpgto , "
	cQuery += "sum(e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof + e2_iss ) vl_ImpPgto , "
	cQuery += "sum(e2_valor + e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof + e2_iss ) vlr_totgerado "         
	cQuery += "from "+RetSqlName("SE2")+" SE2 "
	cQuery += "where e2_filial ='"+XFILIAL("SE2")+"' and d_E_L_E_T_ = ' ' and e2_vencrea >= '"+DTOS(MV_PAR01)+"' and e2_vencrea <='"+DTOS(MV_PAR02)+"'  and e2_origem = 'PLSMPAG' "
	cQuery += "and e2_tipo not in ('TX ','TXA','INS','ISS') "     
	If !Empty(MV_PAR09)
         cQuery += " and  SUBSTR(e2_PLLOTE,1,6) >= '"+MV_PAR08+"' and SUBSTR(e2_PLLOTE,1,6) <= '"+MV_PAR09+"'     
    EndIf    
	cQuery += "group by e2_vencrea  "
	If lSeparaLot
		cQuery += ", e2_pllote " 
		cQuery += "Order By E2_PLLOTE "
	EndIf
Else     
   If nConRemb = 1 
  	  cQuery += " Select e2_codrda ,e2_nomfor,E2_baixa ,  E2_PREFIXO , E2_NUM , e2_parcela,  E2_TIPO , e2_fornece, e2_loja, E2_VENCREA,  e2_saldo,e2_valor , (e2_valor - e2_saldo) as valor_pago, E2_DECRESC, "
      cQuery += " sum(e2_valor + e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof+e2_ISS ) vlr_totgerado, "
      cQuery += " sum(e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof+e2_ISS) impostos ,SubStr(E1_emissao ,1,6) e2_pllote , 'R' TipoPgto "
   	  cQuery += "  FROM " + RetSQLName("SE2") + " SE2, "+ RetSQLName("SE1") + " SE1, "+ RetSQLName("SA2") + " SA2 "
	  cQuery += "  WHERE E2_FILIAL = '" + xFilial("SE2") + "' AND E1_FILIAL = '" + xFilial("SE1") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' "
	  cQuery += " AND SE2.d_e_l_e_t_ = ' ' "
	  cQuery += " AND e2_prefixo = 'RLE'   "
	  cQuery += " AND SE1.d_e_l_e_t_ = ' ' "
	  cQuery += " AND SA2.d_e_l_e_t_ = ' ' "
	  cQuery += " AND e1_prefixo = e2_prefixo"
      cQuery += " AND (e2_tipo    <> 'PA '  AND e2_tipo <> 'TX' AND  E2_TIPO <> 'ISS' AND  E2_TIPO <> 'INS' AND  E2_TIPO <> 'TXA')"   
	  cQuery += " AND e1_tipo    = 'NCC'  "
	  cQuery += " AND e1_num     = e2_num "
	  cQuery += " AND e2_fornece = a2_cod and e2_vencrea >= '"+DTOS(MV_PAR01)+"' and e2_vencrea <='"+DTOS(MV_PAR02)+"' "      
	  if !Empty(MV_PAR09)                                                                                     
	       cQuery += " AND SubStr(E1_emissao ,1,6) >= '" + MV_PAR08     + "' "
	       cQuery += " AND SubStr(E1_emissao ,1,6) <= '" + MV_PAR09     + "' "   
	  EndIf     
	  If !Empty(MV_PAR05) .AND. !Empty(MV_PAR06)
  		  cQuery += " and ((e2_baixa between '"+DTOS(MV_PAR05)+"' and '"+DTOS(MV_PAR06)+"') "
  		 If MV_PAR07 = 1
  			cQuery += " or (e2_baixa = ' ')) "
  		 Else
  			cQuery += " ) "
  		 EndIf 
  	  EndIf
	  cQuery += " group by  e2_codrda ,e2_nomfor,E2_baixa ,  E2_PREFIXO , E2_NUM , e2_parcela, E2_TIPO , e2_fornece, e2_loja, E2_VENCREA, e2_saldo,e2_valor, (e2_valor - e2_saldo), E2_DECRESC, SubStr(E1_emissao ,1,6)"	  
   endif 
   if nConOpme = 1
      if nConRemb = 1
	     cQuery += " UNION "
	  EndIf       
      cQuery += " Select e2_codrda ,e2_nomfor,E2_baixa ,  E2_PREFIXO , E2_NUM , e2_parcela,  E2_TIPO , e2_fornece, e2_loja, E2_VENCREA,  e2_saldo,e2_valor , (e2_valor - e2_saldo) as valor_pago, E2_DECRESC, "
      cQuery += " sum(e2_valor + e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof+e2_ISS ) vlr_totgerado, "
      cQuery += " sum(e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof+e2_ISS) impostos , SubStr(F1_EMISSAO,1,6) e2_pllote , 'M' TipoPgto "
//	  cQuery += "SELECT DISTINCT SE2.R_E_C_N_O_  AS E2_RECNO , a2_nome , 'M' FORNECEDORE , SubStr(F1_EMISSAO,1,4) ANOBASE, SubStr(F1_EMISSAO,5,2) MESBASE"
	  cQuery += "  FROM " + RetSQLName("SE2") + " SE2, "+ RetSQLName("SF1") + " SF1, " + RetSQLName("SA2") + " SA2 "
	  cQuery += " WHERE e2_filial = '"+xFilial("SE2")+"' "
	  cQuery += " AND   f1_filial = '"+xFilial("SF1")+"' "
	  cQuery += " AND SE2.d_e_l_e_t_ = ' '    "
	  cQuery += " AND SF1.d_e_l_e_t_ = ' '    "
	  cQuery += " AND SA2.d_e_l_e_t_ = ' '    "
	  cQuery += " AND F1_SERIE = E2_PREFIXO   "
	  cQuery += " AND F1_DOC = E2_NUM         "
	  cQuery += " AND F1_FORNECE = E2_FORNECE "
      cQuery += " AND (e2_tipo    <> 'PA '  AND e2_tipo <> 'TX' AND  E2_TIPO <> 'ISS' AND  E2_TIPO <> 'INS' AND  E2_TIPO <> 'TXA')"   
	  cQuery += " AND E2_NATUREZ = 'OPME'     and e2_vencrea >= '"+DTOS(MV_PAR01)+"' and e2_vencrea <='"+DTOS(MV_PAR02)+"' "
	  cQuery += " AND e2_fornece = a2_cod  "
	  if !Empty(MV_PAR09)                                                                                     
	       cQuery += " AND SubStr(F1_EMISSAO,1,6) >= '" + MV_PAR08      + "' "
	       cQuery += " AND SubStr(F1_EMISSAO,1,6) <= '" + MV_PAR09     + "' "   
	  EndIf     
	  If !Empty(MV_PAR05) .AND. !Empty(MV_PAR06)
  		  cQuery += " and ((e2_baixa between '"+DTOS(MV_PAR05)+"' and '"+DTOS(MV_PAR06)+"') "
  		 If MV_PAR07 = 1
  			cQuery += " or (e2_baixa = ' ')) "
  		 Else
  			cQuery += " ) "
  		 EndIf 
  	  EndIf
	  cQuery += " group by e2_codrda , e2_nomfor , E2_baixa ,  E2_PREFIXO , E2_NUM , e2_parcela, E2_TIPO , e2_fornece, e2_loja, E2_VENCREA, e2_saldo,e2_valor, (e2_valor - e2_saldo), E2_DECRESC, SubStr(F1_EMISSAO,1,6) "
   EndIf
    
   If nConRda = 1
      if (nConOpme = 1 .or. nConRemb = 1)
	      cQuery += " UNION "
	  EndIf                                              
      cQuery += " Select e2_codrda ,e2_nomfor, E2_baixa ,  E2_PREFIXO , E2_NUM , e2_parcela,  E2_TIPO , e2_fornece, e2_loja, E2_VENCREA,  e2_saldo,e2_valor , (e2_valor - e2_saldo) as valor_pago, E2_DECRESC, "
      cQuery += " sum (e2_valor + e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof+e2_ISS ) vlr_totgerado, "
      cQuery += " sum(e2_inss + e2_irrf + e2_vretpis + e2_vretcsl +e2_vretcof+e2_ISS) impostos , e2_pllote , 'P' TipoPgto "
      cQuery += " from "+RetSqlName("SE2")+" SE2 "
  	  cQuery += " where e2_filial ='"+XFILIAL("SE2")+"' and d_E_L_E_T_ = ' ' and e2_vencrea >= '"+DTOS(MV_PAR01)+"' and e2_vencrea <='"+DTOS(MV_PAR02)+"'  and e2_origem = 'PLSMPAG' "
  	  cQuery += " and e2_tipo not in ('TX ','TXA','INS','ISS') " //--and e2_saldo > 0 
      If !Empty(MV_PAR09)
         cQuery += " and  SUBSTR(e2_PLLOTE,1,6) >= '"+MV_PAR08+"' and SUBSTR(e2_PLLOTE,1,6) <= '"+MV_PAR09+"'     
      EndIf     
  	  If !Empty(MV_PAR05) .AND. !Empty(MV_PAR06)
  		  cQuery += " and ((e2_baixa between '"+DTOS(MV_PAR05)+"' and '"+DTOS(MV_PAR06)+"') "
  		 If MV_PAR07 = 1
  			cQuery += " or (e2_baixa = ' ')) "
  		 Else
  			cQuery += " ) "
  		 EndIf 
  	  EndIf
      If !Empty(cCodRda)
          cQuery += " AND e2_codrda  = '"+ cCodRda+"' "    
      EndIF    
  	  cQuery += " group by  e2_codrda , e2_nomfor ,  E2_baixa ,  E2_PREFIXO , E2_NUM , e2_parcela, E2_TIPO , e2_fornece, e2_loja, E2_VENCREA, e2_saldo,e2_valor, (e2_valor - e2_saldo), E2_DECRESC, e2_pllote "
  	//cQuery += "group by     E2_baixa ,  E2_PREFIXO , E2_NUM , E2_TIPO , E2_VENCREA, e2_saldo,e2_valor, (e2_valor - e2_saldo), e2_pllote "
  EndIf   
   	  cQuery += " order by  16 , 1   "                         
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

	aAdd ( aDadosRel, { "Baixa", "Prefixo", "Número do Título", "Tipo", "Vencimento", "Saldo", "Valor do Título", "Valor Pago", "Valor Total Gerado", "Valor dos Impostos", "Número do Lote", "Motivo da Baixa" , "Valor Decréscimo" ,"Parcela","Fornecedor","Loja" , "TipoPgto", "Comp","Cod. Rda" , "Nome Fornece"} )
		
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
			cMotBaixa := BscMotBaixa(xFilial("SE2")+(cArqQry)->E2_PREFIXO+(cArqQry)->E2_NUM+(cArqQry)->E2_PARCELA+(cArqQry)->E2_TIPO+(cArqQry)->E2_FORNECE+(cArqQry)->E2_LOJA+(cArqQry)->tipopgto)
		Else
			cMotBaixa := "   "
		EndIf
		 IF (cArqQry)->E2_TIPO = 'NDF'        
		     VALOR:=((cArqQry)->E2_VALOR*-1)
		     VALORP:= ((cArqQry)->VALOR_PAGO *-1 ) 
		     VALORT:= ((cArqQry)->VLR_TOTGERADO*-1)
		 ELSE
		     VALOR:=(cArqQry)->E2_VALOR
		     VALORP:= (cArqQry)->VALOR_PAGO  
		     VALORT:= (cArqQry)->VLR_TOTGERADO
		 EndIf    
	   /*	aAdd ( aDadosRel, { (cArqQry)->E2_BAIXA, (cArqQry)->E2_PREFIXO, (cArqQry)->E2_NUM, (cArqQry)->E2_TIPO, (cArqQry)->E2_VENCREA, (cArqQry)->E2_SALDO,;
		(cArqQry)->E2_VALOR, (cArqQry)->VALOR_PAGO, (cArqQry)->VLR_TOTGERADO, (cArqQry)->IMPOSTOS, (cArqQry)->E2_PLLOTE, cMotBaixa, (cArqQry)->E2_DECRESC, (cArqQry)->E2_PARCELA,;
		(cArqQry)->E2_FORNECE, (cArqQry)->E2_LOJA ,(cArqQry)->Tipopgto,substr((cArqQry)->E2_PLLOTE,1,6)  } )
		*/
	     aAdd ( aDadosRel, { (cArqQry)->E2_BAIXA, (cArqQry)->E2_PREFIXO, (cArqQry)->E2_NUM, (cArqQry)->E2_TIPO, (cArqQry)->E2_VENCREA, (cArqQry)->E2_SALDO,;
		VALOR, VALORP ,VALORT, (cArqQry)->IMPOSTOS, (cArqQry)->E2_PLLOTE, cMotBaixa, (cArqQry)->E2_DECRESC, (cArqQry)->E2_PARCELA,;
		(cArqQry)->E2_FORNECE, (cArqQry)->E2_LOJA ,(cArqQry)->Tipopgto,substr((cArqQry)->E2_PLLOTE,1,6) ,(cArqQry)->e2_codrda , (cArqQry)->e2_nomfor } )
                            
		nTotTit   += VALORP  //(cArqQry)->E2_VALOR
		nTotImp   += (cArqQry)->IMPOSTOS
		nTotGer   += VALORT//(cArqQry)->VLR_TOTGERADO
		nTotSaldo += (cArqQry)->E2_SALDO
		nTotPago  += VALORP //(cArqQry)->VALOR_PAGO
		  
		if (cArqQry)->Tipopgto == 'P'
		   nTotTitP   += VALOR //(cArqQry)->E2_VALOR
		   nTotImpP   += (cArqQry)->IMPOSTOS
		   nTotGerP   += VALORT//(cArqQry)->VLR_TOTGERADO
		   nTotSaldoP += (cArqQry)->E2_SALDO
		   nTotPagoP  += VALORP//(cArqQry)->VALOR_PAGO
		Elseif (cArqQry)->Tipopgto == 'M'
		   nTotTitM   += VALOR//(cArqQry)->E2_VALOR
		   nTotImpM   += (cArqQry)->IMPOSTOS
		   nTotGerM   += VALORT//(cArqQry)->VLR_TOTGERADO
		   nTotSaldoM += (cArqQry)->E2_SALDO
		   nTotPagoM  += VALORP//(cArqQry)->VALOR_PAGO
		Elseif (cArqQry)->Tipopgto == 'R'
		   nTotTitR   += VALOR //(cArqQry)->E2_VALOR
		   nTotImpR   += (cArqQry)->IMPOSTOS
		   nTotGerR   += VALORT//(cArqQry)->VLR_TOTGERADO
		   nTotSaldoR += VALORP//(cArqQry)->E2_SALDO
		   nTotPagoR  += (cArqQry)->VALOR_PAGO
		EndIf
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
Local Cabec1         := IIF(cVisaoRel = "Contas","Vencimento     Lote  	      Valor Título     Valor Impostos      Valor Gerado","Dt. Baixa    Prefixo     Num. Tit.    Tipo  Vencimento          Saldo       Vlr S/ Impostos        Vlr Pago      Vlr Tot. Gerado      Vlr Impostos      Num.Lote      Motivo de Baixa    Comp     Valor Decréscimo TPgto")
Local Cabec2         := " "
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
PRIVATE cTipPg       := " " 
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
Local cArqQry        := GetNextAlias()
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
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    ~
   if i == Len(aDadosRel) 
      ccontrole := 'Z'   
      ccontrole1 := cTippg 
   else              
      ccontrole:= aDadosRel[i][17]
   EndIf
   if cTipPg =  ' ' 
      cTippg := ccontrole
   elseif cTippg != ccontrole    
       nlin++
       @ nLin,000 PSay replicate("_",220)   
       nlin++                                               
       if ( cTippg  == 'P') .or. (ccontrole == 'Z' .and. ccontrole1 == 'P')        
   		    @nLin,56  PSAY nTotSaldoP PICTURE "@E 99,999,999.99"
   			@nLin,77  PSAY nTotTitP   PICTURE "@E 99,999,999.99"
   			@nLin,93  PSAY nTotPagoP  PICTURE "@E 99,999,999.99"
   			@nLin,114 PSAY nTotGerP   PICTURE "@E 99,999,999.99"
   			@nLin,133 PSAY nTotImpP   PICTURE "@E 99,999,999.99"
            cTippg := ccontrole 
		Elseif ( cTippg  = 'M') .or. (ccontrole == 'Z' .and. ccontrole1 == 'M')
	 	    @nLin,56  PSAY nTotSaldoM PICTURE "@E 99,999,999.99"
   			@nLin,77  PSAY nTotTitM   PICTURE "@E 99,999,999.99"
   			@nLin,93  PSAY nTotPagoM  PICTURE "@E 99,999,999.99"
   			@nLin,114 PSAY nTotGerM   PICTURE "@E 99,999,999.99"
   			@nLin,133 PSAY nTotImpM   PICTURE "@E 99,999,999.99"
            cTippg := ccontrole
		Elseif ( cTippg  = 'R') .or. (ccontrole == 'Z' .and. ccontrole1 == 'R') 
	 	    @nLin,56  PSAY nTotSaldoR PICTURE "@E 99,999,999.99"
   			@nLin,77  PSAY nTotTitR   PICTURE "@E 99,999,999.99"
   			@nLin,93  PSAY nTotPagoR  PICTURE "@E 99,999,999.99"
   			@nLin,114 PSAY nTotGerR   PICTURE "@E 99,999,999.99"
   			@nLin,133 PSAY nTotImpR   PICTURE "@E 99,999,999.99"
            cTippg := ccontrole
		EndIf
		nlin++                                            
        @ nLin,000 PSay replicate("_",220)  
        if  ccontrole != 'Z' 
            nLin := 99 
        EndIf    
      EndIf
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
 /*if i < Len(aDadosRel) 
      if mv_par14 = 1 .and. aDadosRel[i][17] = 'P'   
         cQuery := " select bd7_anopag, bd7_mespag,bd7_numlot, sum (bd7_vlrpag) "
         cQuery += " from "+RetSqlName("bd7")+" bd7 "
         cQuery += " where bd7_filial = '"+XFILIAL("bd7")+"' and d_E_L_E_T_ = ' ' 
         cQuery += " and  SUBSTR(bd7_numlot,1,6) >= '"+MV_PAR08+"' and SUBSTR(bd7_numlot,1,6) <= '"+MV_PAR09+"'" 
         cQuery += " and bd7_codrda = '"+aDadosRel[i][19] +"' and bd7_anopag || bd7_mespag <> substr(bd7_numlot,1,6) "
  
         If Select(cArqQry)>0
   	        (cArqQry)->(DbCloseArea())
         EndIf

         DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQry,.T.,.T.)

        If (cArqQry)->(Eof())       
             loop 
        EndIf                          
      EndIf
     EndIf 
 */       
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
   			@nLin,183 PSAY aDadosRel[i][18]
   			If aDadosRel[i][6] = aDadosRel[i][7]
   				@nLin,201 PSAY nDecresc PICTURE "@E 9,999.99"
   			EndIf                                 
   			@nLin,213 PSAY aDadosRel[i][17]
   		EndIf
   	EndIf
    nLin := nLin + 1 // Avanca a linha de impressao 
  //EndIf  
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
	@nLin,42 PSAY "Denize Ramiro"
	@nLin,80 PSAY "Alan L. Jefferson"	
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
if empty(cMotBx)
    cMotBx := "   " 
EndIF 
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

PutSx1(cPerg,"01",OemToAnsi("Data inicial de Pgto:")  ,"","","mv_ch1" ,"D",08,0,0,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a data inicial desejada"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Data final de Pgto:")    ,"","","mv_ch2" ,"D",08,0,0,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a data final desejada"},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("Separa por lotes?")      ,"","","mv_ch3" ,"C",01,0,0,"C","","   ","","","mv_par03","Sim","","","","Nao","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Visão Relatório:")       ,"","","mv_ch4" ,"C",01,0,0,"C","","   ","","","mv_par04","Contas Medicas","","","","Financeiro","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Data Baixa de:")         ,"","","mv_ch5" ,"D",08,0,0,"G","","   ","","","mv_par05",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a data inicial da baixa a ser filtrada no relatório"},{""},{""})
PutSx1(cPerg,"06",OemToAnsi("Data Baixa ate:")        ,"","","mv_ch6" ,"D",08,0,0,"G","","   ","","","mv_par06",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a data final da baixa a ser filtrada no relatório"},{""},{""})
PutSx1(cPerg,"07",OemToAnsi("Considera não baxiados?"),"","","mv_ch7" ,"C",01,0,0,"C","","   ","","","mv_par07","Sim","","","","Nao","","","","","","","","","","","",{"Considera também os títulos não baixados? (Sim/Não)"},{},{})
PutSx1(cPerg,"08",OemToAnsi("Comp. Inicial :")        ,"","","mv_ch8" ,"C",06,0,0,"G","","   ","","","mv_par08",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a competecia do custo inicial a ser filtrada no relatório (AnoMes)"},{""},{""})
PutSx1(cPerg,"09",OemToAnsi("Comp. Final   :")        ,"","","mv_ch9" ,"C",06,0,0,"G","","   ","","","mv_par09",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual a competecia do custo final a ser filtrada no relatório(AnoMes)"},{""},{""})
PutSx1(cPerg,"10",OemToAnsi("Considera Pagto Medico?"),"","","mv_ch10","C",01,0,0,"C","","   ","","","mv_par10","Sim","","","","Nao","","","","","","","","","","","",{"Considera Pagto Medico ? (Sim/Não)"},{},{})
PutSx1(cPerg,"11",OemToAnsi("Considera OPME ?")       ,"","","mv_ch11","C",01,0,0,"C","","   ","","","mv_par11","Sim","","","","Nao","","","","","","","","","","","",{"Considera OPME ? (Sim/Não)"},{},{})
PutSx1(cPerg,"12",OemToAnsi("Considera Reembolso ?")  ,"","","mv_ch12","C",01,0,0,"C","","   ","","","mv_par12","Sim","","","","Nao","","","","","","","","","","","",{"Considera Reembolso ? (Sim/Não)"},{},{})
PutSx1(cPerg,"13",OemToAnsi("Cod. do RDA         ?")  ,"","","mv_ch13","C",06,0,0,"G","","   ","","","mv_par13","","","","","","","","","","","","","","","","",{"Informar cod. RDA , Só Ativo se Pagamento Médico "},{},{})
PutSx1(cPerg,"14",OemToAnsi("Lista Rdas Com Outras Comp.?")  ,"","","mv_ch14","C",01,0,0,"C","","   ","","","mv_par14","Sim","","","","Nao","","","","","","","","","","","",{"Considera Reembolso ? (Sim/Não)"},{},{})

Return          



