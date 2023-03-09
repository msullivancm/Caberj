#Define CRLF Chr(13)+Chr(10)
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR143  บ Autor ณ Altamiro Affonso   บ Data ณ  21/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Mapa de Guias por Analista Respossalvem                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR143

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de saldos pendentes por colaborador."
Local cDesc3         := "totalizadp por colaborador e Geral "
Local cPict          := ""

Local titulo         := " Analista responsavel "//+cGroPag +" 
Local nLin           := 80 															
Local Cabec1         := 'Grp  RDA                                       Analista Responsavel       Analista Conferente         Dt.Conf  Confer.   Valor Fase2     Valor Fase3  Valor Fase35   Valor Fase4    Comp.   Stts Ant  Vlr Prot.   Qtd Guias'
          //             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          //             0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21
Local aCabec1       := {}
//{"Grp RDA","Analista Responsavel","Analista Conferente","Dt.Conf","Confer.","Valor Fase2","Valor Fase3","Valor Fase35","Valor Fase4","Comp.","Sts Ant","Vlr Prot.","Qtd Guias"}

Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 080
Private tamanho      := "G"
Private nomeprog     := "CABR143"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR143"
Private cString      := "BD7"
Private cPerg        := "CABR143"
Private valor_tot    := 0.00  
Private valor_col    := 0.00      
private cVlrProt     := 0.00
private cQtdaProt    := 0                                                                
Private cquebra      := " " 
Private lflagtot     :=.F.  
Private adados       := {}
dbSelectArea("BD7")
dbSetOrder(1)

AjustaSX1(cPerg)

Pergunte(cPerg,.T.)

Private cAnoMesI     := SUBSTR(mv_par01,3,4)+SUBSTR(mv_par01,1,2)
Private cAnoMesF     := SUBSTR(mv_par02,3,4)+SUBSTR(mv_par02,1,2)
Private cCodAnaI     := mv_par03   
Private cCodAnaF     := mv_par04        
Private dDtPropI     := mv_par05    
Private dDtPropF     := mv_par06   
Private nListfat     := mv_par07     
Private nExcel       := mv_par08    



//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  31/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cQuery := ' '
dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())   

cQuery := CRLF+"  SELECT bau_grppag||'-'||BD7_CODRDA ||' - '|| BAU_NOME RDA , "
cQuery += CRLF+"         ZN_CODANA  ||' - '|| ZN_NOMANA ANARESP , "
cQuery += CRLF+"         NVL(PBN_NOMANA, 'Nใo Conferido') ANALIS , NVL(PBN_DTALTA, '00000000') DTALTE , "
cQuery += CRLF+"         BD7_FASE , DECODE (BD7_YFAS35 ,'T' ,'Sim','Nใo') FAZ35,"
cQuery += CRLF+"         SUM(CASE WHEN (BD7_FASE = '2' AND BD7_YFAS35 <> 'T') THEN  BD7_VLRPAG ELSE 0 END) CONFER , "
cQuery += CRLF+"         SUM(CASE WHEN (BD7_FASE = '3' AND BD7_YFAS35 <> 'T') THEN  BD7_VLRPAG ELSE 0 END) PRONT , "
cQuery += CRLF+"         SUM(CASE WHEN (BD7_FASE = '3' AND BD7_YFAS35 =  'T') THEN  BD7_VLRPAG ELSE 0 END) PRONT35 , "           
cQuery += CRLF+"         SUM(CASE WHEN (BD7_FASE = '4' AND BD7_YFAS35 =  'T') THEN  BD7_VLRPAG ELSE 0 END) FATURA , "          
cQuery += CRLF+"         BD7_ANOPAG||BD7_MESPAG COMPFAT, DECODE(TRIM(pbn_conant),'S','Sim','Nใo') status_ant "
cQuery += CRLF+"    FROM " + RetSqlName('BD7') + "  bd7 " 
cQuery += CRLF+"    INNER JOIN " + RetSqlName('SZN') + "  SZN ON ZN_FILIAL = '" + xFilial("SZN") + "' "
cQuery += CRLF+"         AND SZN.D_E_L_E_T_ = ' '  "
cQuery += CRLF+"         AND (ZN_VIGFIM = ' ' OR ZN_VIGFIM <= SUBSTR(BD7_NUMLOT,1,6) ) "
cQuery += CRLF+"         AND BD7_CODRDA = ZN_CODrda "
cQuery += CRLF+"         AND ZN_CODANA >= '"+ cCodAnaI + "' AND ZN_CODANA <= '"+ cCodAnaF+"' "
cQuery += CRLF+"   INNER JOIN " + RetSqlName('BAU') + "  BAU  ON BAU_FILIAL = '" + xFilial("BAU") + "' "
cQuery += CRLF+"         AND BAU.D_E_L_E_T_ = ' ' "
cQuery += CRLF+"         AND BD7_CODRDA = BAU_CODIGO  "
cQuery += CRLF+"    LEFT JOIN " + RetSqlName('PBN') + "  PBN  ON PBN_FILIAL = '" + xFilial("PBN") + "' "
cQuery += CRLF+"         AND PBN.D_E_L_E_T_ = ' ' "
cQuery += CRLF+"         AND BD7_FILIAL = PBN_FILBD7 " 
cQuery += CRLF+"         AND BD7_CODOPE = PBN_CODOPE " 
cQuery += CRLF+"         AND BD7_CODLDP = PBN_CODLDP "   
cQuery += CRLF+"         AND BD7_CODPEG = PBN_CODPEG " 
cQuery += CRLF+"         AND BD7_NUMERO = PBN_NUMERO "  
cQuery += CRLF+"         AND BD7_ORIMOV = PBN_ORIMOV " 
cQuery += CRLF+"         AND BD7_SEQUEN = PBN_SEQUEN "  
cQuery += CRLF+"         AND BD7_CODUNM = PBN_CODUNM "   
cQuery += CRLF+"       WHERE BD7_FILIAL = '" + xFilial("BD7") + "'  AND BD7.D_E_L_E_T_ = ' ' "
cQuery += CRLF+"         AND  BD7_SITUAC = '1'   AND  BD7_BLOPAG <> '1' "
if nListfat = 1
   cQuery += CRLF+" AND BD7_FASE not in ('1','4') "  
Else                                               
   cQuery += CRLF+" AND BD7_FASE not in ('1') "
EndIf   
cQuery += CRLF+"         AND (BD7_CONPAG = '1' OR BD7_CONPAG = ' ' ) "
cQuery += CRLF+"         AND bd7_datpro >= '"+dtos(dDtPropI)+"' and  bd7_datpro <= '"+dtos(dDtPropF)+"' "    

If EMPTY (canomesF) .and. !EMPTY (canomesI)
   cQuery += CRLF+" AND  bd7_anopag || bd7_mespag = '"+canomesI+"' " 
Else 
   cQuery += CRLF+" AND  bd7_anopag || bd7_mespag >= '"+canomesI+"' AND  bd7_anopag || bd7_mespag <= '"+canomesF+"' "                 
EndIf   

cQuery += CRLF+"   GROUP BY bau_grppag , BD7_CODRDA , BAU_NOME , ZN_CODANA , ZN_NOMANA , NVL(PBN_NOMANA, 'Nใo Conferido') , NVL(PBN_DTALTA, '00000000'),"
cQuery += CRLF+"         BD7_FASE, DECODE (BD7_YFAS35 ,'T' ,'Sim','Nใo') ,  BD7_ANOPAG, BD7_MESPAG , DECODE(TRIM(pbn_conant),'S','Sim','Nใo') "
cQuery += CRLF+"   ORDER BY BD7_CODRDA||' - '||BAU_NOME , ZN_CODANA||' - '||ZN_NOMANA , NVL(PBN_NOMANA, 'Nใo Conferido')  , NVL(PBN_DTALTA, '00000000') ,"
cQuery += CRLF+"         BD7_FASE, DECODE(BD7_YFAS35 ,'T' ,'Sim','Nใo') , BD7_ANOPAG||BD7_MESPAG , DECODE(TRIM(pbn_conant),'S','Sim','Nใo') "

 If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
 Endif                       
//    TCQuery cQuery Alias "TMP1" New   
    DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),"TMP1",.T.,.T.)
    dbSelectArea("TMP1")
    TMP1->(dbGoTop())       
    While !TMP1->(EOF())                                                                
	  If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	   nLin ++
	Endif
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica o cancelamento pelo usuario...                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif   
	cQuery1 := CRLF+"SELECT sum(zzp_vltgui)vlr, sum(zzp_qtotgu)qtda 
    cQuery1 += CRLF+"  FROM " + RetSqlName('ZZP') + "  ZZP  WHERE  zzp_filial = '" + xFilial("SZN") + "' "
    cQuery1 += CRLF+"   and zzp_codrda = '"+substr(TMP1->RDA,1,06) +" ' "
    cQuery1 += CRLF+"   and zzp_anopag||zzp_mespag = '"+TMP1->compfat +"' and ZZP_STATUS = 'CPR'   "    
    
    If Select(("TMP2")) <> 0 
       ("TMP2")->(DbCloseArea())  
    Endif 
     
    DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery1),"TMP2",.T.,.T.)
    dbSelectArea("TMP2")
    TMP2->(dbGoTop())    
    iF !EOF() 
        cVlrProt  := TMP2->Vlr
        cQtdaProt := TMP2->qtda
    Else                       
        cVlrProt  := 0.00
        cQtdaProt := 0
    EndIf     
   ("TMP2")->(DbCloseArea())        
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do cabecalho do relatorio. . .                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
	 @ nLin,000 PSay  substr(TMP1->RDA,1,45) 
	 @ nLin,047 PSay  substr(TMP1->ANARESP,1,25)	    
	 @ nLin,074 PSay  substr(TMP1->ANALIS,1,20)
  	 @ nLin,101 PSay  sTOd(TMP1->DTALTE) 
  	  	 
     @ nLin,114 PSay  TMP1->faz35   
     @ nLin,120 PSAY  TMP1->CONFER  Picture "@E 9,999,999.99"          
     @ nLin,134 PSAY  TMP1->PRONT   Picture "@E 999,999,999.99"         
     @ nLin,148 PSAY  TMP1->PRONT35 Picture "@E 999,999,999.99"          
     @ nLin,162 PSAY  TMP1->FATURA  Picture "@E 999,999,999.99"         


     @ nLin,178 PSAY  TMP1->compfat    
     @ nLin,190 PSAY  TMP1->status_ant3
               
     @ nLin,195 PSAY  cVlrProt   Picture "@E 9,999,999.99"          
     @ nLin,210 PSAY  cQtdaProt  Picture "@E 9,999"   

////     
        CONFER  := cValtoChar(TMP1->CONFER ) //  Picture "@E 9,999,999.99"          
        PRONT   := cValtoChar(TMP1->PRONT  )// Picture "@E 999,999,999.99"         
        PRONT35 := cValtoChar(TMP1->PRONT35)// Picture "@E 999,999,999.99"          
        FATURA  := cValtoChar(TMP1->FATURA )// Picture "@E 999,999,999.99"         

       cVlrProt :=  cValtoChar(cVlrProt)  // Picture "@E 9,999,999.99"          
       cQtdaProt:=  cValtoChar(cQtdaProt) // Picture "@E 9,999"         
///
     
     aAdd(adados,{substr(TMP1->RDA,1,45), substr(TMP1->ANARESP,1,25), substr(TMP1->ANALIS,1,20), sTOd(TMP1->DTALTE), TMP1->faz35 ,CONFER ,PRONT , PRONT35 , FATURA , TMP1->compfat , TMP1->status_ant3  , cVlrProt , cQtdaProt })                

	nLin ++     // Avanca a linha de impressao
	TMP1->(dbSkip())   // Avanca o ponteiro do registro no arquivo
EndDo    
  @ nLin,000 PSay replicate("_",220)  
  if nExcel == 1 
    aCabec1 := {"Grp RDA","Analista Responsavel","Analista Conferente","Dt.Conf","Confer.","Valor Fase2","Valor Fase3","Valor Fase35","Valor Fase4","Comp.","Sts Ant","Vlr Prot.","Qtd Guias"}
     
  	DlgToExcel({{"ARRAY","relatorio " , aCabec1 ,aDados}})  
 
EndIf 
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บ Autor ณ Jose Carlos Noronhaบ Data ณ 01/08/07    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Parametros para selecao dos titulos do PLS                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/    
Static Function AjustaSX1(cPerg)  

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe MesAno Base Inicial")
PutSX1(cPerg , "01" , "MesAno Base De  ?" 	  ,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
aHelp := {}
aAdd(aHelp, "Informe Mes/Ano Base Final ")
PutSX1(cPerg , "02" , "Mes/Ano Base Ate ?"    ,"","","mv_ch2","C",6,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
aHelp := {}
aAdd(aHelp, "Informe o analista inicial")
PutSX1(cPerg , "03" , "Analista de       "    ,"","","mv_ch3","C",6,0,0,"G","","LOGINU","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
aHelp := {}
aAdd(aHelp, "Informe o analista final")
PutSX1(cPerg , "04" , "Analista ate      " 	  ,"","","mv_ch4","C",6,0,0,"G","","LOGINU","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
aHelp := {}
aAdd(aHelp, "Informe Data Inicial do procedimento ")
PutSx1(cPerg,"05",OemToAnsi("Data Inicial do procedimento ")   	,"","","mv_ch05","D",10,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,{},{})
aHelp := {}
aAdd(aHelp, "Informe Data Final do procedimento ")
PutSx1(cPerg,"06",OemToAnsi("Data Final do procedimento ")   	,"","","mv_ch06","D",10,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelp,{},{})
aHelp := {}
aAdd(aHelp, "nใo Lista Faturados S/N ")
PutSx1(cPerg,"07",OemToAnsi("Nใo Listar Faturados ")   	,"","","mv_ch07","N",01,0,0,"C","","","","","mv_par07","Sim"    ,"","","","Nใo","","","","","","","","","","","",aHelp,{},{})
aAdd(aHelp, "Gera planilha excek ")
PutSx1(cPerg,"08",OemToAnsi("Gera Excel ? ")   	,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Sim"    ,"","","","Nใo","","","","","","","","","","","",aHelp,{},{})


Pergunte(cPerg,.F.)

Return




/*
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

aAdd(aRegs,{cPerg,"01","Mes/Ano Base De  ?","","","mv_ch1","C",07,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
aAdd(aRegs,{cPerg,"02","Mes/Ano Base Ate ?","","","mv_ch2","C",07,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
aHelp := {}
aAdd(aHelp, "Informe o analista inicial")
PutSX1(cPerg , "03" , "Analista de" 	   ,"","","mv_ch3","C",6,0,0,"G","","LOGINU","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o analista final")
PutSX1(cPerg , "04" , "Analista ate" 		,"","","mv_ch4","C",6,0,0,"G","","LOGINU","",""	,"mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)


aAdd(aRegs,{cPerg,"03","Matricula De     ?","","","mv_ch3","C",06,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Matricula Ate    ?","","","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })




For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

RestArea( aAreaAtu )

Return(.T.)

 */