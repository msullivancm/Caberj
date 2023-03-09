***********************
User Function CABR093()
***********************

   Local cDesc1  := "Este programa tem como objetivo imprimir relatorio "
   Local cDesc2  := "negociacoes realizadas, canceladas e em andamento"
   Local cDesc3  := "de acordo com os parametros informados pelo usuario."
   Local cPict   := ""      
   Local titulo  := "Negociações"
   Local nLin    := 80
   Local Cabec1  := "Cliente                                                  Codigo                   Data     Data   Ident.          Data         Data             Valor       Qunt.          Valor     Parc.        Valor   Parc.       Total"
   Local Cabec2  := "                                                         Plano                  Inicial    Final  Titulo        Vencimento     Baixa         Original       Parc.      Negociado     Pagas         Pago   Aberto   Em Aberto"
                   //          1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21         
                   //01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
                   //999999 9999.9999.999999-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXX - XXXXXXXXXXXXXX  99/9999  99/9999  XXXXXXXXXXXXX  99/99/9999  99/99/9999    999,999.99         99      999,999.99       99   999,999.99      99     999,999.99
   Local imprime := .T.                                                                                                          
   Local aOrd    := {}              
   Private  aDados1    := {}   
   Private  aDados2    := {} 
   Private  acabec1    := {"Cliente ","Codigo","Data inicial ","Datafinal ","Ident. tit","Data Venc","Data Baixa"," Valor Orig"   ,"Qunt.parc"  , "Valor Neg","Parc. Pagas", "Valor Pg", "Parc. Aberto","Total Aberto"}


   Private lEnd     := lAbortPrint  := .F.
   Private CbTxt    := ""
   Private limite   := 220
   Private tamanho  := "G"
   Private nomeprog := "CABR93" // Coloque aqui o nome do programa para impressao no cabecalho
   Private nTipo    := 18
   Private aReturn  := {"Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
   Private nLastKey := 0
   Private cbtxt    := Space(10)
   Private cbcont   := 00
   Private CONTFL   := m_pag := 01
   Private wnrel    := "CABR93"
   Private cPerg    := "CABR93"
   Private nVlBx    := 0.00    
   Private dCompI   := "  "   
   Private dCompF   := "  "   
   Private cInsSql  := "  "                          
   private cStatus  := "  " 
   private cDescric := "  "                       
   private lPago    := .T.
   private cCliant  := " "
   private nqtda    := 1
   private aTotStat := {}  
   private nDadCon  := 1
   PRIVATE cContMatr := ' ' 
   fCriaSX1()
   
   Pergunte(cPerg, .T.)
   If empty (dtos(mv_par10))
      mv_par10:= DATE()
   EndIf                 
   nDadCon  := mv_par14
   DBSelectArea("SZG")
   SE1->(DBSetOrder(1))
   
   wnrel := SetPrint("SZG"  , NomeProg, cPerg, @titulo , cDesc1, cDesc2, cDesc3, .F.    , aOrd    , .T.     ,  Tamanho,  , .T.)      
   
  //cRel := SetPrint (cAlias	, cRel    , cPerg, @cTitulo, cDesc1, cDesc2, cDesc3, lDicion, aOrderns, lCompres, cTamanho, {},	lFiltro	, lCrystal)

   
   If nLastKey == 27    
      Set Filter To
         Return
   EndIf

   SetDefault(aReturn, "SZG")
   If nLastKey == 27 
      Set Filter To
          Return
   EndIf

   nTipo := If(aReturn[4] == 1, 15, 18)

   RptStatus({|| RunReport(Cabec1, Cabec2, Titulo, nLin)}, Titulo)
     Return


*******************************************************
Static Function RunReport(Cabec1, Cabec2, Titulo, nLin)
*******************************************************

Local ii := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local i  := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local x  := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local cTabSZG	:= RetSqlName("SZG")
	Local cTabSZH	:= RetSqlName("SZH")
	Local cTabSE1	:= RetSqlName("SE1")
	Local cTabBSQ	:= RetSqlName("BSQ")  
	Local cTabSA1	:= RetSqlName("SA1")
	Local cTabBA3	:= RetSqlName("BA3")
	Local cTabBG1	:= RetSqlName("BG1")

	Local cFilSZG	:= xFilial("SZG")
	Local cFilSZH	:= xFilial("SZH")
	Local cFilSE1	:= xFilial("SE1")
	Local cFilBSQ	:= xFilial("BSQ") 
	Local cFilSA1	:= xFilial("SA1")
	Local cFilBA3	:= xFilial("BA3")	 
	Local cFilBG1	:= xFilial("BG1")	

   
	lIncluir	:= .T.
	cCriterio	:= ""
	nQuant		:= nTotal	:= nQuantPG		:= nQuantAB		:= nTotalPG		:= nTotalAB		:= nTotOri		:= 0
	nQuantGR	:= nTotalGR	:= nQuantPGGR	:= nQuantABGR	:= nTotalPGGR	:= nTotalABGR	:= nTotOriGR	:= 0   
    If empty (dtos(mv_par10))
       mv_par10:= DATE()
    EndIf                                                                                                                                                                                                                                               
	cQry := "SELECT "+cTabSZG+".* FROM " + cTabSZG +" "
	If mv_par15 = 2
	   cQry += ", " + cTabBA3 + "  "
	EndIf   
	cQry += " WHERE  " + cTabSZG + ".D_E_L_E_T_ = ' ' "
    If mv_par15 = 2	
	   cQry += " AND "+ cTabBA3 + ".D_E_L_E_T_ = ' '  "
	   cQry += " AND BA3_CODINT = ZG_CODINT AND BA3_CODEMP = ZG_CODEMP AND BA3_MATRIC = ZG_MATRIC "

       cQry += " AND BA3_MOTBLO NOT IN (SELECT BG1_CODBLO FROM  " + cTabBG1 +" WHERE  BG1_FILIAL = '" + cFilBG1 + " ' AND  " + cTabBG1 +" .d_E_L_E_T_ = ' ' AND BG1_BLOFAT = '1')
       
	EndIf   
	cQry += "     AND ZG_FILIAL = '" + cFilSZG + "'"
	cQry += "     AND SUBSTR(ZG_PLANO, 1, 4) BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"
	cQry += "     AND ZG_CODINT||ZG_CODEMP||ZG_MATRIC||ZG_TIPREG BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "'"
	cQry += "     AND ZG_CLIENTE BETWEEN '" + mv_par06 + "' AND '" + mv_par07 + "' "                               
	if ! empty (mv_par10)
	     cQry += "  AND  ZG_DTNEG <= '"+ dtos(mv_par10) + "' "  // Marcela Coimbra - 28/01/2012
//	     cQry += "  AND  ZG_DTNEG <= "+ dtos(mv_par10) // Marcela Coimbra - 28/01/2012
	EndIf     
	If  ! Empty(aReturn[7])
     	  cQry += " AND " + ParSQL(Upper(aReturn[7]))  
    Endif
	cQry += " ORDER BY ZG_CODIGO, ZG_CLIENTE, ZG_LOJA, ZG_PLANO, ZG_TEMPOPL"

/*
	cQry := "SELECT DISTINCT NUMNEG, CLIENTE, NOME, PLANO, TMPPLANO FROM CABE010R3, " + RetSqlName("BBT")
	cQry += " WHERE BBT_CLIFOR = CLIENTE AND BBT_NUMTIT = NUMERO AND BBT_PREFIX = PREFIXO AND BBT_PARCEL = PARCELA AND BBT_TIPTIT = TIPO"
	cQry += " AND BBT_CODPLA = SUBSTR(PLANO, 1, 4) AND " + RetSqlName("BBT") + ".D_E_L_E_T_ = ' ' "
	cQry += " AND SUBSTR(PLANO, 1, 4) BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' "
	cQry += " AND BBT_CODOPE||BBT_CODEMP||BBT_MATRIC BETWEEN '" + mv_par04 + "' AND '" + mv_par05 + "' "
	cQry += " AND CLIENTE BETWEEN '" + mv_par06 + "' AND '" + mv_par07 + "' "
	cQry += " GROUP BY NUMNEG, CLIENTE, NOME, PLANO, TMPPLANO"
*/
    //cQry  := ChangeQuery(cQry)
	If Select("TMP1") > 0 
	   TMP1->(DbCloseArea()) 
	Endif
	DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), "TMP1", .F., .T.)

    nRec := 0
    TMP1->(DbGoTop())
    TMP1->(DbEval({||nRec++}))
    TMP1->(DbGoTop())

	SetRegua(nRec)
   
	While TMP1->(!Eof())

		IncRegua()

		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf

		If nLin > 55
			Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
			nLin := 8
		EndIf      

		nQuant := nTotal := nQuantPG := nQuantAB := nTotalPG := nTotalAB := 0

		cQry :="SELECT ZH_MESBASE, ZH_ANOBASE, ZH_VALOR, NVL (E1_VALOR, 0) E1_VALOR, NVL (E1_SALDO, 0) E1_SALDO ,"
		cQry +=" NVL(ZH_VALOR - (E1_SALDO * ZH_VALOR / E1_VALOR), 0) AS BAIXADO" 
		cQry +=" , NVL (e1_prefixo,' ' )e1_prefixo , NVL (e1_num, '0') e1_num , NVL (e1_parcela, ' ' ) e1_parcela , NVL (e1_tipo, ' ') e1_tipo " 
		
		cQry +=" FROM " + cTabSZH

		cQry +=" LEFT JOIN " + cTabBSQ + " ON"
		cQry +="     BSQ_FILIAL = '" + cFilBSQ + "'"
		cQry +="     AND " + cTabBSQ + ".D_E_L_E_T_ = ' '"
		cQry +="     AND BSQ_PREORI = ZH_PREFIXO"
		cQry +="     AND BSQ_NUMORI = ZH_NUM"
		cQry +="     AND BSQ_PARORI = ZH_PARCELA"
		cQry +="     AND BSQ_TIPORI = ZH_TIPO"

		cQry +=" LEFT JOIN " + cTabSE1 + " ON"
		cQry +="         E1_FILIAL = '" + cFilSE1 + "'"
		cQry +="     AND " + cTabSE1 + ".D_E_L_E_T_ = ' '"
		cQry +="     AND BSQ_PREORI = E1_PREFIXO"
		cQry +="     AND BSQ_NUMORI = E1_NUM"
		cQry +="     AND BSQ_PARORI = E1_PARCELA"
		cQry +="     AND BSQ_TIPORI = E1_TIPO"

		cQry +=" WHERE"
		cQry +="        " + cTabSZH + ".D_E_L_E_T_ = ' '"
		cQry +="    AND ZH_FILIAL  = '" + cFilSZH + "'"
		cQry +="    AND ZH_NEGTIPO = 'S'"
		cQry +="    AND ZH_CODIGO  = '" + TMP1->ZG_CODIGO + "'"

		cQry +=" ORDER BY ZH_ANOBASE, ZH_MESBASE"

		If Select("TMP2") > 0 ; TMP2->(DbCloseArea()) ; EndIf
		dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), "TMP2", .F., .T.)
        lPago    := .T.    
        lPVez    := .T.
        
        While !TMP2->(Eof()) 
		
  /////////////////////////////////////////////	         
   	   If TMP2->e1_tipo = '  '	
   	   cQry := " select e1_cliente , e1_prefixo , e1_num , e1_parcela , e1_tipo , e1_vencrea , (CASE WHEN E1_BAIXA > '" + dtos(mv_par10) + "' THEN ' ' ELSE E1_BAIXA END)e1_baixa , bm1_codtip, e1_fatpref"
       cQry += " FROM siga.bm1010 bm1, se1010 se1   "
       cQry += " WHERE bm1_codint = '"+TMP1->ZG_CODINT +"'" 
       cQry += " AND bm1_codemp = '" +TMP1->ZG_CODEMP +"' "  
       cQry += " AND bm1_matric = '" + TMP1->ZG_MATRIC +"'" 
       cQry += " AND bm1_filial = '  '    AND bm1.D_e_l_e_t_ = ' ' " 
       cQry += " AND bm1_codtip = '935' "  
       cQry += " AND bm1_mes = '" + TMP2->ZH_MESBASE + "' "  
       cQry += " AND bm1_ano = '" + TMP2->ZH_ANOBASE + "' "
       cQry += " AND e1_filial = '01' AND se1.d_e_l_e_t_ = ' ' "
       cQry += " AND e1_prefixo = bm1_prefix "
       cQry += " AND e1_num = bm1_numtit     "
       cQry += " AND e1_parcela = bm1_parcel  "
       cQry += " AND e1_tipo = bm1_tiptit     "   
       If mv_par08 = 1
	      cQry += "  AND  e1_vencrea <> ' ' AND  e1_vencrea <= '" + dtos(mv_par09) + "' AND (e1_baixa =  ' ' or e1_baixa > '" + dtos(mv_par09) + "' )"
       EndIf	     
       
       If Select("TMP3") > 0 
          TMP3->(DbCloseArea()) 
       EndIf
	   dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), "TMP3", .F., .T.) 
	EndIf               
   		
	If mv_par08 = 1
//	   If Select("TMP3") = 0 
	   If ((TMP2->e1_tipo = 'PR') .OR. ;
	       (tmp3->e1_vencrea = ' ') .OR. ;
	       (tmp3->e1_vencrea > dtos(mv_par09)) .or. ;
	       (tmp3->e1_vencrea < dtos(mv_par09) .and. (tmp3->e1_baixa <> ' ' .and. tmp3->e1_baixa <=  dtos(mv_par09))))
	       TMP2->(dbSkip())  
	      loop                                            
	   EndIf 
	EndIf   
////////////////////////////////////////////////////		
	If lAbortPrint
       @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
	   Exit
	EndIf
 
	If nLin > 55
	   Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
	   nLin := 8
	EndIf            
	nQuant++
	cCliente := TMP1->ZG_CLIENTE + "-" + TMP1->ZG_CODINT + "." + TMP1->ZG_CODEMP + "." + TMP1->ZG_MATRIC + " " + substr (TMP1->ZG_NOME,1,30)
    cPlano   := AllTrim(TMP1->ZG_PLANO) 
   
	if empty (dCompI)
       dCompI   := TMP2->ZH_MESBASE + "/" + TMP2->ZH_ANOBASE 
    EndIf  
    dCompF   := TMP2->ZH_MESBASE + "/" + TMP2->ZH_ANOBASE 
     If  nDadCon  = 1 .and.   cCliente != cCliant       
         cQry := "SELECT * FROM " + cTabSA1 + " WHERE " + cTabSA1 + ".D_E_L_E_T_ = ' '"
	     cQry += " AND A1_FILIAL = '" + cFilSA1 + "' AND A1_COD = '"+TMP1->ZG_CLIENTE+"'   "     
	
	     If Select("TRB1") > 0 
	        TRB1->(DbCloseArea()) 
	     EndIf
	     DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), "TRB1", .F., .T.)
         Trb1->(DbGoTop())                          
     	@ nLin, 000 Psay 'Nome : '+ TRB1->A1_NOME +' End : '+ TRB1->A1_END +'  Bairro : '+ TRB1-> A1_BAIRRO +'  CEP : '+TRB1->A1_CEP +'  Munic : '+TRB1->A1_MUN + '  Estado : '+TRB1->A1_EST +'  DDD: '+TRB1->A1_DDD  +'  Tel : '+TRB1->A1_TEL
     	  nLin += 1                                                                          
   	    @ nLin, 000 Psay Replicate('-', 220)   	
          nLin += 1                            
    EndIf                                          
	If mv_par03 == 2           
	   If TMP2->e1_tipo = 'PR' .or. tmp3->e1_baixa = ' '          
	      nVlBx := 0.00
	   Else       
	      nVlBx :=TMP2->ZH_VALOR      
	   EndIf   
	   nLin++
	   @nLin,000 PSay cCliente
   	   @nLin,057 PSay substr (cPlano,1,20)                                              
       If cCliente != cCliant  
          cCliant  := cCliente 
       EndIf   
        @nLin,080 PSay TMP2->ZH_MESBASE + "/" + TMP2->ZH_ANOBASE              
       If TMP2->e1_tipo = '  '             
          @nlin,098 PSay tmp3->e1_prefixo + tmp3->e1_num + tmp3->e1_parcela + tmp3->e1_tipo+substr(tmp3->e1_fatpref,1,1)
          @nLin,117 PSay stod(TMP3->e1_vencrea) 
          @nLin,129 PSay stod(TMP3->e1_baixa)
       End       
 	   @nLin,166 PSay TMP2->ZH_VALOR		  			        Picture "@E 999,999.99"
       @nLin,189 PSay nVlBx				                        Picture "@E 999,999.99"
       @nLin,210 PSay TMP2->ZH_VALOR - nVlBx                    Picture "@E 999,999.99"
  
    EndIf                 
 	If TMP2->e1_tipo = 'PR' .OR. tmp3->e1_baixa = ' ' 
		nQuantAB++                               
		nTotalAB	+= TMP2->ZH_VALOR  
		lPago:=.F.
     Else  
		nQuantPG++              
		nTotalPG	+= TMP2->ZH_VALOR 
  	 EndIf 
  	 

	 nTotal		+= TMP2->ZH_VALOR        
	 
	aAdd(aDados1,   {cCliente,;
	                 substr (cPlano,1,20) ,;
	                 TMP2->ZH_MESBASE + "/" + TMP2->ZH_ANOBASE ,"  /  /  ",;
	                 tmp3->e1_prefixo + tmp3->e1_num + tmp3->e1_parcela + tmp3->e1_tipo+substr(tmp3->e1_fatpref,1,1),;
	                 stod(TMP3->e1_vencrea),;
	                  stod(TMP3->e1_baixa) ,Transform(nTotOri,"@E 99,999,999.99")  , Transform(nQuant,"@E 99") ,;
	                 Transform(TMP2->ZH_VALOR,"@E 99,999,999.99")  , Transform(nQuantPG,"@E 999")  ,;
	                 Transform(nVlBx,"@E 99,999,999.99")  ," ",;
	                 Transform((TMP2->ZH_VALOR - nVlBx),"@E 99,999,999.99")})
	   
 
	  nVlBx:=0.00
	 TMP2->(dbSkip())    
  
	EndDo
		
		TMP2->(dbCloseArea())

		IncRegua()

		If nQuant > 0
			nLin++
			If mv_par03 == 1
				@nLin,000 PSay cCliente
  		        @nLin,057 PSay substr (cPlano,1,20)
			Else 
				@nLin,000 PSay Replicate("-", 220)
				nLin++
				@nLin,000 PSay "Total Cliente:"
            EndIf

			nTotOri := TMP1->ZG_VLTOTAL   
			@nLin,080 PSay dCompI    
            @nLin,089 PSay dCompF
			@nLin,137 PSay nTotOri	Picture "@E 9,999,999.99"
			@nLin,158 PSay nQuant	Picture "@E 99"
			@nLin,163 PSay nTotal	Picture "@E 9,999,999.99"
			@nLin,183 PSay nQuantPG	Picture "@E 99"
			@nLin,187 PSay nTotalPG	Picture "@E 9,999,999.99"
			@nLin,205 PSay nQuantAB	Picture "@E 99"
			@nLin,208 PSay nTotalAB	Picture "@E 9,999,999.99"
            dCompI   := ""   
            dCompF   := ""   

			If mv_par03 == 2
				nLin++
				@nLin,000 PSay Replicate("-", 220)
				nLin += 2
			EndIf

			nTotOriGR	+= nTotOri
//			nQuantGR	+= nQuant
			nTotalGR	+= nTotal
//			nQuantPGGR	+= nQuantPG
			nTotalPGGR	+= nTotalPG
//			nQuantABGR	+= nQuantAB
			nTotalABGR	+= nTotalAB
        	If lPago 
		       cStatus := "X"
		       cDescric:= "Neg. Quitada" 
		    Else                  
		       cStatus := "C"
		       cDescric:= "Neg. Concluida " 
		    EndIf   
            fCaregavet(cStatus ,cPlano,cDescric,nqtda)
		EndIf
	
		TMP1->(dBSkip())
	EndDo

	TMP1->(dBCloseArea())

	nLin++
	@nLin,000 PSay Replicate("-", 220)
	nLin++

	@nLin,000 PSay "Total Geral"
	@nLin,137 PSay nTotOriGR	Picture "@E 9,999,999.99"
//	@nLin,140 PSay nQuantGR		Picture "@E 9999999999"
	@nLin,163 PSay nTotalGR		Picture "@E 9,999,999.99"
//	@nLin,168 PSay nQuantPGGR	Picture "@E 9999999999"
	@nLin,187 PSay nTotalPGGR	Picture "@E 9,999,999.99"
//	@nLin,196 PSay nQuantABGR	Picture "@E 9999999999"
	@nLin,208 PSay nTotalABGR	Picture "@E 9,999,999.99"

	nLin++
	@nLin,000 PSay Replicate("-", 220)   
	
/////////////////	
if Len(aDados1) > 0 
   cContMatr := aDados1[1,1]	
   ci := 1           
   lfaz:= .F.
EndIf    
For i := 1 To Len(aDados1)    
    if   cContMatr  != aDados1[I,1]    
         ci := I 
         lfaz:= .F.       
         cContMatr := aDados1[I,1]
    endIf       
   	   if aDados1[I,6] =='  /  /  ' .and. !lfaz
   	      lfaz:= .T.
   	      
   	      for ii := ci to cContMatr  != aDados1[ii,1]   
   	      	aAdd(aDados2,   {aDados1[ii,1],;
	                         aDados1[ii,2],;
	                         aDados1[ii,3],;
 	                         aDados1[ii,4],;
	                         aDados1[ii,5],;
	                         aDados1[ii,6],;
	                         aDados1[ii,7],;
                             aDados1[ii,8],;
                             aDados1[ii,9],;
	                         aDados1[ii,10]})  
	      Next ii                         
   	   EndIf  
Next                
//	
DlgToExcel({{"ARRAY","Relação Conferencia NF " ,aCabec1,aDados1}})	
///////////////  
If mv_par11 = 1     
   nlin   := 99   
   Titulo := "Analitico do Resuno de Negociação "   
   If mv_par12 = 1       
//                          1         2         3         4         5         6   
//               123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
      Cabec1 := "Assitido                            Status  Descrição           Plano                    "
      Cabec2 := " " 
   else              
      Cabec1 := "Assitido                            Status  Descrição             "
      Cabec2 := " "                                          
   EndIf   
   If mv_par13 = 1                                              
      cQry := "SELECT zg_nome , zg_plano , zg_status, (CASE zg_status WHEN 'A'  THEN  'Neg. Aberta ' WHEN 'P'  THEN  'Neg. Proposta ' "
      cQry += " WHEN 'T'  THEN  'Neg. Termo ' ELSE 'Sem Especificação' END) as Descricao "
      cQry += " FROM " + cTabSZG + " WHERE zg_filial = " + cFilSZG + " AND d_e_l_e_t_ = ' ' AND zg_status <> 'C' " 
      cQry += " ORDER BY zg_status "
 
      If Select("TMP5") > 0 
         TMP5->(DbCloseArea()) 
      EndIf
      dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), "TMP5", .F., .T.)
      TMP5->(DbGoTop())
      While !TMP5->(Eof())             
         If nLin > 55                                                        
             nlin:= Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
         EndIf   
	     //nLin := 8   
	     @nLin,003 PSay SUBSTR (TMP5->zg_nome,1,30)                                                                  
   	     @nLin,040 PSay TMP5->zg_status 
   	     @nLin,045 PSay TMP5->descricao   
   	     If mv_par12 = 1                  
   	        @nLin,065 PSay TMP5->zg_plano       	     
   	     Endif  
   	     nLin += 1       
   	     TMP5->(dBSkip())
    //   MsgBox("Vetor : " + aTotStat[x,1] + aTotStat[x,3] + aTotStat[x,2] + aTotStat[x,4],,) 	      
      EndDo      
   
   EndIf           
EndIf 

If mv_par11 = 1                                              
   cQry := "SELECT zg_plano , zg_status, (CASE zg_status WHEN 'A'  THEN  'Neg. Aberta' WHEN 'P'  THEN  'Neg. Proposta' "
   cQry += " WHEN 'T'  THEN  'Neg. Termo' ELSE 'Sem Especificação' END) as Descricao, Count (*) total "
   cQry += " FROM " + cTabSZG + " WHERE zg_filial = " + cFilSZG + " AND d_e_l_e_t_ = ' ' AND zg_status <> 'C' " 
   cQry += " GROUP BY zg_plano ,zg_status, (CASE zg_status WHEN 'A'  THEN  'Neg. Abreta' WHEN 'P'  THEN  'Neg. Proposta' "
   cQry += " WHEN 'T'  THEN  'Neg. Termo' ELSE 'Sem Especificação' END)  ORDER BY zg_status "
 
   If Select("TMP4") > 0 
      TMP4->(DbCloseArea()) 
   EndIf
   dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), "TMP4", .F., .T.)
   TMP4->(DbGoTop())
   While !TMP4->(Eof()) 
         fCaregavet(tmp4->zg_status ,tmp4->zg_plano,tmp4->Descricao,tmp4->total)
     	 TMP4->(dBSkip())
   EndDo            
   nlin   := 99   
   Titulo := "Resuno de Negociação "   
   If mv_par12 = 1                                                        
//                 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
      Cabec1 := "Status  Descrição           Plano                          Qtdel"
      Cabec2 := " " 
   else              
      Cabec1 := "Status  Descrição             Qtde"
      Cabec2 := " "                                          
   EndIf   
   For x:= 1 to len(aTotStat)                                  
       If nLin > 55       
          If mv_par12 = 1  
            nlin:= Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
          else                                                      
             nlin:= Cabec(Titulo, Cabec1, Cabec2, NomeProg, Tamanho, nTipo)
          EndIf   
	  //    nLin := 8   
	   EndIf    
	   @nLin,003 PSay aTotStat[x,1]                                                                 
   	   @nLin,009 PSay aTotStat[x,3]
   	   If mv_par12 = 1  
          @nLin,029 PSay aTotStat[x,2] 
   	      @nLin,059 PSay aTotStat[x,4] Picture "@E 9999"
   	   else
          @nLin,030 PSay aTotStat[x,4] Picture "@E 9999"   	   
   	   EndIf
       nLin += 1    
    //   MsgBox("Vetor : " + aTotStat[x,1] + aTotStat[x,3] + aTotStat[x,2] + aTotStat[x,4],,) 	      
   Next x     
   
EndIf   
 //////////////
	SET DEVICE TO SCREEN

	If aReturn[5] == 1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	EndIf

	MS_FLUSH()

Return(.T.)    

Static Function ParSQL(cFilADV)
 
cFilADV := StrTran(cFilADV,".AND."," AND ")
cFilADV := StrTran(cFilADV,".OR."," OR ")
cFilADV := StrTran(cFilADV,"=="," = ")
cFilADV := StrTran(cFilADV,'"',"'")
cFilADV := StrTran(cFilADV,'$'," IN ")
cFilADV := StrTran(cFilADV,"ALLTRIM","  ")
 
Return(cFilADV)           

//************************
Static Function fCaregavet(cStatus ,cPlano,cDescric,nqtda)
//************************           
If mv_par11 = 1                                              
   If mv_par12 = 1                        
      If (nPosPla := Ascan(aTotStat, {|x| x[1] == alltrim(cStatus)  .and. x[2] == alltrim(cPlano)})) > 0				
   	      aTotStat[nPosPla][4]+= nqtda
   	  else  
   	     aAdd(aTotStat, { AllTrim(cStatus) ,AllTrim(cPlano),AllTrim(cDescric), nqtda}) 
   	  EndIf
   else	    
      If (nPosPla := Ascan(aTotStat, {|x| x[1] == alltrim(cStatus) })) > 0				
   	      aTotStat[nPosPla][4]+= nqtda
   	  else  
   	     aAdd(aTotStat, { alltrim(cStatus) ,"" ,alltrim(cDescric),  nqtda}) 
   	  EndIf
   EndIf	
EndIf                     
Return(.T.)           
 

//************************
Static Function fCriaSX1()
//************************

Local lI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	aPergs	:= {}
	lAltera	:= .F.

	aAdd(aPergs, {"01", "Plano de........?", "", "", "mv_ch1", "C", 04, 0, 0, "G", "", "mv_par01", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "BI3", ""})
	aAdd(aPergs, {"02", "Plano até.......?", "", "", "mv_ch2", "C", 04, 0, 0, "G", "", "mv_par02", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "BI3", ""})
	aAdd(aPergs, {"03", "Tipo............?", "", "", "mv_ch3", "N", 01, 0, 0, "C", "", "mv_par03", "Sintetico", "", "", "", "", "Analitico", "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	aAdd(aPergs, {"04", "Matrícula de....?", "", "", "mv_ch4", "C", 16, 0, 0, "G", "", "mv_par04", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	aAdd(aPergs, {"05", "Matrícula até...?", "", "", "mv_ch5", "C", 16, 0, 0, "G", "", "mv_par05", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	aAdd(aPergs, {"06", "Cliente de......?", "", "", "mv_ch6", "C", 06, 0, 0, "G", "", "mv_par06", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "SA1", ""})
	aAdd(aPergs, {"07", "Cliente até.....?", "", "", "mv_ch7", "C", 06, 0, 0, "G", "", "mv_par07", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "SA1", ""})
	aAdd(aPergs, {"08", "So Vencidos ....?", "", "", "mv_ch8", "N", 01, 0, 0, "C", "", "mv_par08", "Sim"      , "", "", "", "", "Nao"      , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	aAdd(aPergs, {"09", "Vencido até.....?", "", "", "mv_ch9", "D", 08, 0, 0, "G", "", "mv_par09", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	aAdd(aPergs, {"10", "Data até........?", "", "", "mv_ch10","D", 08, 0, 0, "G", "", "mv_par10", ""         , "", "", "", "", ""         , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	aAdd(aPergs, {"11", "Faz Resumo .....?", "", "", "mv_ch11","N", 01, 0, 0, "C", "", "mv_par11", "Sim"      , "", "", "", "", "Nao"      , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})   
    aAdd(aPergs, {"12", "Incluir Plano ..?", "", "", "mv_ch12","N", 01, 0, 0, "C", "", "mv_par12", "Sim"      , "", "", "", "", "Nao"      , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	aAdd(aPergs, {"13", "Detalhar Resumo ?", "", "", "mv_ch13","N", 01, 0, 0, "C", "", "mv_par13", "Sim"      , "", "", "", "", "Nao"      , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})   
	aAdd(aPergs, {"14", "Dados  Contacto ?", "", "", "mv_ch14","N", 01, 0, 0, "C", "", "mv_par14", "Sim"      , "", "", "", "", "Nao"      , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})   
	aAdd(aPergs, {"15", "Listar Bloq.... ?", "", "", "mv_ch15","N", 01, 0, 0, "C", "", "mv_par15", "Sim"      , "", "", "", "", "Nao"      , "", "", "", "", ""     ,"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})   

	SX1->(DBSetOrder(1))
   
	For lI := 1 To Len(aPergs)
		lAltera := SX1->(DBSeek(cPerg+"    "+aPergs[lI][1]))
		RecLock("SX1", !lAltera)
		SX1->X1_GRUPO   := cPerg
		SX1->X1_ORDEM   := aPergs[lI][01]
		SX1->X1_PERGUNT := aPergs[lI][02]
		SX1->X1_PERSPA  := aPergs[lI][03]
		SX1->X1_PERENG  := aPergs[lI][04]
		SX1->X1_VARIAVL := aPergs[lI][05]
		SX1->X1_TIPO    := aPergs[lI][06]
		SX1->X1_TAMANHO := aPergs[lI][07]
		SX1->X1_DECIMAL := aPergs[lI][08]
		SX1->X1_PRESEL  := aPergs[lI][09]
		SX1->X1_GSC     := aPergs[lI][10]
		SX1->X1_VALID   := aPergs[lI][11]
		SX1->X1_VAR01   := aPergs[lI][12]
		SX1->X1_DEF01   := aPergs[lI][13]
		SX1->X1_DEFSPA1 := aPergs[lI][14]
		SX1->X1_DEFENG1 := aPergs[lI][15]
		SX1->X1_CNT02   := aPergs[lI][16]
		SX1->X1_VAR02   := aPergs[lI][17]
		SX1->X1_DEF02   := aPergs[lI][18]
		SX1->X1_DEFSPA2 := aPergs[lI][19]
		SX1->X1_DEFENG2 := aPergs[lI][20]
		SX1->X1_CNT02   := aPergs[lI][21]
		SX1->X1_VAR03   := aPergs[lI][22]
		SX1->X1_DEF03   := aPergs[lI][23]
		SX1->X1_DEFSPA3 := aPergs[lI][24]
		SX1->X1_DEFENG3 := aPergs[lI][25]
		SX1->X1_CNT03   := aPergs[lI][26]
		SX1->X1_VAR04   := aPergs[lI][27]
		SX1->X1_DEF04   := aPergs[lI][28]
		SX1->X1_DEFSPA4 := aPergs[lI][29]
		SX1->X1_DEFENG4 := aPergs[lI][30]
		SX1->X1_CNT04   := aPergs[lI][31]
		SX1->X1_VAR05   := aPergs[lI][32]
		SX1->X1_DEF05   := aPergs[lI][33]
		SX1->X1_DEFSPA5 := aPergs[lI][34]
		SX1->X1_DEFENG5 := aPergs[lI][35]
		SX1->X1_CNT05   := aPergs[lI][36]
		SX1->X1_F3      := aPergs[lI][37]
		SX1->X1_PYME    := aPergs[lI][38]
		SX1->(MsUnlock())             
	Next lI

Return(.T.)
