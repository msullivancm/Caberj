
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR116  º Autor ³ Altamiro Affonso   º Data ³  10/11/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio Conferencia de cobrança - reajuste               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR118()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de Usuario que não sofreram reajuste               "
Local cDesc3         := " na competencia especificada                       "
Local cPict          := ""
Local titulo         := " Conferencia de Cobrança "
Local nLin           := 80 															
Local Cabec1         := "Identificação      Usuario                                 MesReaj  Forma Pgto      Vlr.Tab   Inclusao "
//                       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        1         2         3         4         5         6         7         8         9         20        1         2        7
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99                     99/99/2011
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO)                
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR118"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR118"
Private cString      := "BM1"
Private cPerg        := "CABa18   "
Private valor_tot    := 0.00  
Private valor_col    := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "           
private lLista   	 := .F. 
private cnum         := "  "
private nTottit      := 0.00 
private nTotsal      := 0.00
private lSair        := .F.   
private lpassa       := .T.
private X            :=1   
private alinha       :={}  
private aCabec1      :={"Usuario" , "Mes de Reaj." , "      Vl Pgto" , "       Vl Tab" , "Inclusao" , " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " " } 
private ind          := 0     
private Y            := 0
dbSelectArea("BM1")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif                          
Private cMesRea     := mv_par01 
Private cComps      := mv_par02
Private nComptab    := mv_par03                                                                   
Private cCtAnoMes   := "tmp->(A101"+mv_par04+")"   
Private cCtAnoMes1  := "" 
Private cCtAnoMes2  := ""           
Private aAnoMes     := {}           
private nMostComp   := mv_par05    
private lImp        :=.T.
private cTpPag      := ""           
private cCodLan     := ""          
private lLib        := .F.
Do Case
   Case MV_PAR09 == 1 // 01 - Mater Aposentado e 08 - Mater Aposentado Vinc
        cTpPag      := "'01', '08'" 
   Case MV_PAR09 == 2 // 02 - Banco Liq   
        cTpPag      := "'02'" 
   Case MV_PAR09 == 3 // 03 - Mater Empresa   
        cTpPag      := "'03'" 
   Case MV_PAR09 == 4 // 04 - Boleto 112 , 05 - Boleto 175 e SisDeb   
        cTpPag      := "'04' , '05' , '06'" 
   Case MV_PAR09 == 5 // 07 - Emp. Itau       
        cTpPag      := "'07'" 
   EndCase	 
Do Case
   Case MV_PAR06 == 1 // 
        cCodLan     := "'101'" 
   Case MV_PAR06 == 2 //   
        cCodLan     := "'925'" 
   Case MV_PAR06 == 3 //    
        cCodLan     := "'101','925'" 
   EndCase	   

//mv_par07//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

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
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  31/08/07   º±±
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
Local cQuery := ' '

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())       
///    
//cQuery := " select  bm1_codemp ||'.'|| bm1_MATRIC ||'.'|| bm1_TIPREG ||' - '|| ba1_nomusr ident ,  bm1_ano, ba3_mesrea, IDADE_S(BA1_DATNAS) Idade ,           "
cQuery := " select  bm1_codemp ||'.'|| bm1_MATRIC ||'.'|| bm1_TIPREG ||' - '|| ba1_nomusr ident , ba3_mesrea, IDADE_S(BA1_DATNAS) Idade ,           "
cQuery += " substr (BA1_DATINC,7,2)||'/'||substr (BA1_DATINC,5,2) ||'/'|| substr (BA1_DATINC,1,4)  dt_inclusao , BA1_CODPLA ||' - '|| BI3_DESCRI PLANO,       "
cQuery += " BDK_VALOR VALOR_Tab,  CASE (ba3_tippag)  WHEN '01' THEN 'Contra-Cheque ' WHEN '02' THEN 'Contra-Cheque'  WHEN '08' THEN 'Contra-Cheque'           "
cQuery += " WHEN '03' THEN 'Colaborador'  WHEN '04' THEN 'Boleto  '  WHEN '05' THEN 'Boleto  '  WHEN '06' THEN 'Debito  '  ELSE 'INDEFINIDO' END tp_pagto   , "
                      
aAnoMes := strTokArr(cComps,',')

//Do While !lsair  .or. X > 54 

For i := 1 to len(aAnoMes)
	If i > 6 
		exit
	EndIf 
	cAnoMes := trim(aAnoMes[i])
      If MV_PAR06 = 1 .or. MV_PAR06 = 3    
         cQuery += " sum ( case when bm1_codtip = '101' and bm1_ano||bm1_mes = '"+canomes+"' then  bm1_valor else 0.00 end) A101"+canomes + ","
      EndIF                                 
      If MV_PAR06 = 2 .or. MV_PAR06 = 3   
         cQuery += "  sum ( case when bm1_codtip = '925' and bm1_ano||bm1_mes = '"+canomes+"' then  bm1_valor else 0.00 end) A925"+canomes+ ","
      EndIf      
Next

cQuery := left(cQuery,len(cQuery)-1)

cQuery += " from " + RetSqlName('BM1')+ " BM1, "+RetSqlName('BA3')+ " BA3 , "+RetSqlName('BA1')+" BA1 ,"+RetSqlName('BI3')+ " BI3 ,"+ RetSqlName('BDK')+ " bdk "
cQuery += " where bm1_filial = '" + xFilial("BM1") +"' and BM1.d_E_L_E_T_ = ' ' AND bA1_filial = '" + xFilial("BA1") +"' and BA1.d_E_L_E_T_ = ' 'AND bA3_filial = '" + xFilial("BA3") +"' and BA3.d_E_L_E_T_ = ' ' "
cQuery += " AND bI3_filial = '" + xFilial("BI3") +"' and BI3.d_E_L_E_T_ = ' ' and BDK_FILIAL = '" + xFilial("BDK") +"' AND bdk.D_e_l_E_t_ = ' ' " 
cQuery += " AND BA1_CODEMP = bm1_codemp AND BA1_MATRIC = bm1_MATRIC AND BA1_TIPREG = bm1_TIPREG and ba1_image = 'ENABLE' "       
//
cQuery += " AND BA1_CODEMP = '0001' AND BA1_MATRIC = '038949' AND BA1_TIPREG = '10' and ba1_image = 'ENABLE' "       
//
if mv_par08 = 1
   If !empty(cTpPag) 
      cQuery += " and ba3_tippag in ("+ cTpPag +") "
   EndIF            
EndIF   
If !empty(cMesRea) 
   cQuery += " and ba3_mesrea in ('"+ cMesRea +"') "
EndIF           
cQuery += " AND BI3_CODIGO = BA1_CODPLA AND BA3_CODEMP = bm1_codemp AND BA3_MATRIC = bm1_MATRIC  and bm1_codtip in ("+cCodLan+")" 
cQuery += " AND bm1_ano||bm1_mes IN " + FormatIn(cComps, ',')
//cQuery += " AND  (bm1_codemp IN ('0001','0002','0005') or bm1_codemp = '0003' and bm1_tipreg <> '00') 
cQuery += " AND Ba1_CODINT = BDK_CODINT  AND Ba1_CODEMP = BDK_CODEMP AND Ba1_MATRIC = BDK_MATRIC AND Ba1_TIPREG = BDK_TIPREG "     
cQuery += " AND (( BA1_MUDFAI = 0 and BA1_FAICOB = BDK_CODFAI ) or ( BA1_MUDFAI <> 0 and IDADE_S(BA1_DATNAS) >= BDK_IDAINI AND IDADE_S(BA1_DATNAS) <= BDK_IDAFIN)) "                      
//cQuery += " group by bm1_codemp ||'.'|| bm1_MATRIC ||'.'|| bm1_TIPREG ||' - '|| ba1_nomusr ,  bm1_ano, ba3_mesrea, IDADE_S(BA1_DATNAS), BA1_DATINC, BA1_CODPLA ||' - '|| BI3_DESCRI ,BDK_VALOR , ba3_tippag "      
cQuery += " group by bm1_codemp ||'.'|| bm1_MATRIC ||'.'|| bm1_TIPREG ||' - '|| ba1_nomusr ,  ba3_mesrea, IDADE_S(BA1_DATNAS), BA1_DATINC, BA1_CODPLA ||' - '|| BI3_DESCRI ,BDK_VALOR , ba3_tippag "      

cQuery += " order by bm1_codemp||'.'|| bm1_MATRIC ||'.'||bm1_TIPREG ||' - '|| ba1_nomusr "                     
Y:= 5
   For i := 1 to len(aAnoMes)
	     If i > 6  
	        exit
	     EndIf 
	     if MV_PAR06 = 3   
	                    
	        Cabec1         += " A101"+trim(aAnoMes[i])                                      
	        Cabec1         += " A925"+trim(aAnoMes[i])          
	        acabec1[i+Y]   := " A101"+trim(aAnoMes[i])
	        acabec1[i+Y+1]   := " A925"+trim(aAnoMes[i])                                         
	        Y:=Y+1
	     Elseif MV_PAR06 = 1               
	        Cabec1         += " A101"+trim(aAnoMes[i])    
            acabec1[i+Y]   := " A101"+trim(aAnoMes[i])                                 
            Y:=Y+1
	     Elseif MV_PAR06 = 2                                       
	        Cabec1         += " A925"+trim(aAnoMes[i]) 
            acabec1[i+Y+1]   := " A925"+trim(aAnoMes[i])                                                    
	        Y:=Y+1
	     EndIf                                                  
      Next  

 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea())  
 Endif
 TCQuery cQuery Alias "TMP" New 
 dbSelectArea("TMP")
 tmp->(dbGoTop())
 nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
 nLin ++      
 While !EOF()                                                      
  If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
    nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
    nLin ++
  Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  If lAbortPrint
	@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
	Exit
  Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Comparação entre a tabela e o mes escolhido                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	lImp :=.T.                                  
	lLib :=.F.
  if nMostComp != 3
    if nComptab = 1
      if nMostComp == 1 
         If tmp->VALOR_Tab !=  &cCtAnoMes       
            lImp :=.F.
         EndIF   
      Else    
         If tmp->VALOR_Tab ==  &cCtAnoMes      
            lImp :=.F. 
         EndIF 
      EndIf                 
    Else                       
      For i := 1 to (len(aAnoMes)-1)
  //    For i := 1 to MaxaAnoMes
 //	        If i > 6  .or. (i + 1) > len(aAnoMes)
//    	        exit
//	        EndIf         
	        cCtAnoMes1   := "tmp->(A101"+aAnoMes[i]+")"  
	        cCtAnoMes2   := "tmp->(A101"+aAnoMes[i+1]+")"  
	        if    (!empty (&cCtAnoMes1) .and. &cCtAnoMes1 > 0) .and. (!empty (&cCtAnoMes2) .and. &cCtAnoMes2 > 0) .and. lLib == .F. 
	           lLib:=.T.                        
	        EndIf    
        If nMostComp == 1 .and. lLib == .T.   
           If &cCtAnoMes1   !=  &cCtAnoMes2        
              lImp :=.F. 
              EXIT 
           EndIF         
        ElseIf &cCtAnoMes1  ==  &cCtAnoMes2 .and. lLib == .T.     
               lImp :=.F.
            ElseIf lLib == .T.
               lImp :=.T.
               Exit    
        EndIF                                                                                                                              
      Next  
    EndIF           
EndIF   
                        
Y:=5   
if nComptab = 2   
   if lImp .and. llib == .T.
      lpassa:= .T.
      else           
      lpassa:= .F.  
   EndIf   
Elseif lImp 
      lpassa:= .T.
      else           
      lpassa:= .F.      
EndIf    

If lpassa
    @ nLin,000 PSay  tmp->ident
    @ nLin,062 PSay  tmp->ba3_mesrea    
    @ nLin,069 PSay  tmp->tp_pagto  
    @ nLin,083 PSay  Transform(tmp->VALOR_Tab, "@E 999,999.99")       
    @ nLin,094 PSay  tmp->dt_inclusao
    cValor := Transform(tmp->VALOR_Tab, "@E 999,999.99")   
    xx:=104       
    aAdd(alinha,{tmp->ident, tmp->ba3_mesrea, tmp-> tp_pagto, cValor,tmp->dt_inclusao,"0,00","0,00","0,00","0,00","0,00","0,00","0,00","0,00","0,00","0,00","0,00","0,00"}) 
    ind:= len(alinha)
     For i := 1 to len(aAnoMes)
	     If i > 6  
	        exit
	     EndIf 
	     if MV_PAR06 = 3               
	        cCtAnoMes1   := "tmp->(A101"+aAnoMes[i]+")"       
   	      @ nLin,xx PSay  Transform(&cCtAnoMes1, "@E 999,999.99")   
   	       cValor := Transform(&cCtAnoMes1, "@E 999,999.99")        
   	        alinha[ind][i+Y]:= cValor
	        xx:=xx+11                                           
	        cCtAnoMes1   := "tmp->(A925"+aAnoMes[i]+")"         
	      @ nLin,xx PSay  Transform(&cCtAnoMes1, "@E 999,999.99")
	        cValor := Transform(&cCtAnoMes1, "@E 999,999.99")        
   	        alinha[ind][i+Y+1]:= cValor
	        xx:=xx+11        
	        Y:=Y+1                           
	     Elseif MV_PAR06 = 1               
	        cCtAnoMes1   := "tmp->(A101"+aAnoMes[i]+")"       
   	      @ nLin,xx PSay  Transform(&cCtAnoMes1, "@E 999,999.99")            
   	        cValor := Transform(&cCtAnoMes1, "@E 999,999.99")        
   	        alinha[ind][i+Y]:= cValor 
	        xx:=xx+11      
	        Y:=Y+1 
	     Elseif MV_PAR06 = 2                                       
	        cCtAnoMes1   := "tmp->(A925"+aAnoMes[i]+")"         
	      @ nLin,xx PSay  Transform(&cCtAnoMes1, "@E 999,999.99")   
  	        cValor := Transform(&cCtAnoMes1, "@E 999,999.99")        
   	        alinha[ind][i+Y+1]:= cValor
	        xx:=xx+11        
	        Y :=Y+1
	     EndIf                                               
      Next  
  	    
 nLin ++     // Avanca a linha de impressao
EndIf     
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo
if mv_par07 = 1
   DlgToExcel({{"ARRAY","Inconsistencia  da Filial" ,aCabec1 ,alinha}})      
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Parametros para selecao dos titulos do PLS                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg()

cPerg := PADR(cPerg,6)    

PutSx1(cPerg,"01","Mes de Reajuste         ","","","mv_ch01","C", 02,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"02","AnoMes a Listar (anomes)","","","mv_ch02","C", 60,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )                                                              
PutSx1(cPerg,"03","Comparar Tab X Cobranca ","","","mv_ch03","N", 01,0,0,"C","","","","","mv_par03","Tabela","","","","Cobranca","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"04","Qual Anomes Comparar    ","","","mv_ch04","C", 06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" )                                            
PutSx1(cPerg,"05","Mostrar                 ","","","mv_ch05","N", 01,0,0,"C","","","","","mv_par05","Igualdade","","","","Diferenças","","","Ambos","","","","","","","","","","","" , "" , "" , "", "", "" )                                                                                                                                                                                           
PutSx1(cPerg,"06","Listar Codigos          ","","","mv_ch06","N", 01,0,0,"C","","","","","mv_par06","101","","","","925","","","101 e 925","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"07","Gerar Excel             ","","","mv_ch07","N", 01,0,0,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"08","Considera Tp de Cobrança","","","mv_ch08","N", 01,0,0,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"09","Tipo de Cobrança        ","","","mv_ch09","N", 01,0,0,"C","","","","","mv_par09","Mater Aposent","","","","Banco liq","","","Mater Empresa","","","Bol 112,175,Sisdeb","","","Emp. Itau","","","","","" , "" , "" , "", "", "" )                                                                                                                                                                                           

Return(.T.)                       
