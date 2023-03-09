#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR095  º Autor ³ Altamiro Affonso   º Data ³  10/11/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio log check contas medica                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±                           
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR113()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de inconsistencias ou problemas no processo de pagamento de contas medicas"
Local cDesc3         := " assim possibilitando acoes corretivas "
Local cPict          := ""
Local titulo         := "Log De Processamento Contas Medicas "
Local nLin           := 80 															
Local Cabec1         := "  Codigo     Descrição                                            Saldo"
//                       12345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6          7
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR113"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR113"
Private cString      := "SE2"
Private cPerg        := "CAB113    "
Private valor_tot    := 0.00  
Private valor_col    := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "
private lLista       := .F.      
private _cAliasRdaT  := GetNextAlias()
dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif
if alltrim(SUBSTR (CUSUARIO,7,15))  $ "joana.barbosa|Altamiro Totta"                                      
   lLista := .T.
EndIF   
Private cAnoMes      := mv_par01
Private cGroPag      := mv_par02  
Private cGroPagF     := mv_par13
Private nMstit       := mv_par03   
Private cMatFim      := mv_par04  

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
dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())       
 /* a. Guias a fatura de um gropo de pagamento  - 09           */           
  nLin:=80
 If mv_par09 = 1       
cQuery := CRLF+"  SELECT  BAU_GRPPAG GRPPG , BD7_CODRDA RDA , BAU_NOME NOME , NVL(PBN_NOMANA, 'Não Conferido') ANALIS , NVL(PBN_DTALTA, '00000000') DTALTE , NVL(PBN_HRALTE, '00:00:00') HRALTE," 
cQuery += CRLF+"  DECODE (BD7_YFAS35 ,'T' ,'Sim','Não') FAZ35, BD7_LOTBLO BLOQ ,SUM(BD7_VLRPAG) VLR , BD7_ANOPAG || BD7_MESPAG COMPFAT ,DECODE(TRIM(pbn_conant),'S','Sim','Não') status_ant "
cQuery += CRLF+"  FROM " + RetSqlName('BD7') + "  bd7 "  
 
cQuery += CRLF+"  INNER JOIN " + RetSqlName('BAU') + "  BAU  ON BAU_FILIAL = '" + xFilial("BAU") + "' "
cQuery += CRLF+"                       AND BAU.D_E_L_E_T_ = ' ' "
cQuery += CRLF+"                       AND BD7_CODRDA = BAU_CODIGO "
cQuery += CRLF+"                       AND BAU_GRPPAG >= '"+ cGroPag +"' "
cQuery += CRLF+"                       AND BAU_GRPPAG <= '"+ cGroPagF +"' "
 
cQuery += CRLF+"   LEFT JOIN " + RetSqlName('PBN') + "  PBN  ON PBN_FILIAL = '" + xFilial("PBN") + "' "
cQuery += CRLF+"                        AND PBN.D_E_L_E_T_ = ' ' "
cQuery += CRLF+"                        AND BD7_FILIAL = PBN_FILBD7  "
cQuery += CRLF+"                        AND BD7_CODOPE = PBN_CODOPE  "
cQuery += CRLF+"                        AND BD7_CODLDP = PBN_CODLDP  "  
cQuery += CRLF+"                        AND BD7_CODPEG = PBN_CODPEG  "
cQuery += CRLF+"                        AND BD7_NUMERO = PBN_NUMERO  " 
cQuery += CRLF+"                        AND BD7_ORIMOV = PBN_ORIMOV  "
cQuery += CRLF+"                        AND BD7_SEQUEN = PBN_SEQUEN  " 
cQuery += CRLF+"                        AND BD7_CODUNM = PBN_CODUNM  "  
                       
cQuery += CRLF+"  WHERE BD7_FILIAL = '" + xFilial("BD7") + "' AND BD7.D_E_L_E_T_ = ' ' "
cQuery += CRLF+"    AND BD7_FASE = '3'   AND  BD7_SITUAC = '1'   AND  BD7_BLOPAG <> '1' "
cQuery += CRLF+"    AND BD7_VLRPAG > 0   AND  BD7_NUMLOT = ' '   AND  BD7.D_E_L_E_T_ = ' ' " 
cQuery += CRLF+"    AND ( BD7_CONPAG = '1' OR BD7_CONPAG = ' ' ) "
cQuery += CRLF+"    AND bd7_datpro >= '"+dtos(Mv_par11)+"' and  bd7_datpro <= '"+dtos(Mv_par12)+"' "   
If !EMPTY (canomes) 
   cQuery += CRLF+" AND  bd7_anopag || bd7_mespag = '"+canomes+"' " 
//Else 
//   cQuery += CRLF+" AND  bd7_anopag || bd7_mespag >= '201001' AND  bd7_anopag || bd7_mespag <= '201412'"                 
EndIf   
cQuery += CRLF+"  GROUP BY  BAU_GRPPAG , BD7_CODRDA , BAU_NOME  , PBN_NOMANA  , PBN_DTALTA  , PBN_HRALTE , DECODE (BD7_YFAS35 ,'T' ,'Sim','Não') , BD7_LOTBLO  , BD7_ANOPAG || BD7_MESPAG , DECODE(TRIM(pbn_conant),'S','Sim','Não') "  
cQuery += CRLF+"  ORDER BY  BAU_GRPPAG , BD7_CODRDA  , DTALTE "

 If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
    Endif                       
//    TCQuery cQuery Alias "TMP1" New   
    DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),"TMP1",.T.,.T.)
    dbSelectArea("TMP1")
    TMP1->(dbGoTop())       
    tamanho      := "G"
    titulo         := " Grupo Pag. "+cGroPag +" que Faltam faturar"
    cabec1 := ' Grp Pagto     RDA                                        Blq  Analista                Data     Hora    f35         Valor          Comp.        Status Ant  '   
//             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//             0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21
    While !EOF()                                                                
	  If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
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
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	 @ nLin,000 PSay  TMP1->Grppg 
	 @ nLin,008 PSay  TMP1->Rda +' - ' + TMP1->Nome  
	 If empty(TMP1->Bloq)             
  	    @ nLin,059 PSay  'Não' 
  	 Else                      
  	    @ nLin,059 PSay  'Sim' 
  	 EndIf    
  	 @ nLin,064 PSay  SUBSTR(TMP1->ANALIS,1,20) 
  	 @ nLin,086 PSay  sTOd(TMP1->DTALTE) 
  	 @ nLin,095 PSay  TMP1->HRALTE 
  	  	 
     @ nLin,104 PSay  TMP1->faz35                        
     @ nLin,106 PSAY  TMP1->Vlr Picture "@E 999,999,999.99"         
     @ nLin,130 PSAY  TMP1->compfat    
     @ nLin,150 PSAY  TMP1->status_ant  
     
	nLin ++     // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo    
  @ nLin,000 PSay replicate("_",220)  
EndIF    
 
/* 
 nLin:=80
 If mv_par09 = 1 
cQuery := " SELECT  bau_grppag Grppg , BD7_CODRDA rda , bau_nome nome ,  Decode (bd7_yfas35  ,'T'  ,'Sim','Não')  faz35,  bd7_lotblo  Bloq ,sum(BD7_VLRPAG) vlr FROM " + RetSqlName('BD7') + "  bd7, " + RetSqlName('BAU') + " bau "
cQuery += " WHERE  BD7_FILIAL = ' ' AND bd7.d_E_L_E_T_ = ' '  and bau_FILIAL = ' ' AND bau.d_E_L_E_T_ = ' '  AND ( BD7_CONPAG = '1' OR BD7_CONPAG = ' ' )"
cQuery += " and bd7_codrda = bau_codigo AND  BAU_GRPPAG >= '"+ cGroPag +"' AND  BAU_GRPPAG <= '"+ cGroPagF +"' AND  BD7_FASE = '3' AND  BD7_SITUAC = '1' AND ( BD7_CONPAG = '1' OR BD7_CONPAG = ' ' ) "
cQuery += " AND  BD7_BLOPAG <> '1' AND  BD7_VLRPAG > 0 AND  bd7_numlot =  ' ' AND  bd7.d_E_L_E_T_ = ' ' and bd7_anopag || bd7_mespag = '"+canomes+"' "               
cQuery += " and bd7_datpro >= '"+dtos(Mv_par11)+"' and  bd7_datpro <= '"+dtos(Mv_par12)+"' "
cQuery += " group by bau_grppag ,bd7_codrda ,bau_nome, bd7_yfas35  , bd7_lotblo ORDER BY  bau_grppag, BD7_CODRDA "    

 If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
    Endif                       
//    TCQuery cQuery Alias "TMP1" New   
    DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),"TMP1",.T.,.T.)
    dbSelectArea("TMP1")
    TMP1->(dbGoTop())       
    tamanho      := "P"
    titulo         := " Grupo Pag. "+cGroPag +" que Faltam faturar"
    cabec1 := ' Grp Pagto     RDA                                        Blq  f35         Valor   
//             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//             0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21
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
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	 @ nLin,000 PSay  TMP1->Grppg 
	 @ nLin,008 PSay  TMP1->Rda +' - ' + TMP1->Nome  
	 If empty(TMP1->Bloq)             
  	    @ nLin,059 PSay  'Não' 
  	 Else                      
  	    @ nLin,059 PSay  'Sim' 
  	 EndIf     	 
     @ nLin,064 PSay  TMP1->faz35                        
     @ nLin,066 PSAY  TMP1->Vlr Picture "@E 999,999,999.99"        
     
	nLin ++     // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo    
  @ nLin,000 PSay replicate("_",80)  
EndIF    
*/ 
//a. Guias a fatura com titulos faturados  - 06 
nLin:=80                
If mv_par06 = 1 
cQuery := " SELECT distinct BD7_CODRDA rda, e2_fornece fornecedor, e2_nomfor Nome, e2_prefixo pref, e2_num num, e2_tipo tipo , e2_pllote lote, (E2_VALOR + e2_inss + e2_Irrf + E2_vretpis + e2_vretcof + e2_vretcsl) Vlr_Lote, E2_EMISSAO emissao "
cQuery += " ,BAU_GRPPAG grppag , bd7_codldp loc_Dig FROM " + RetSqlName('BD7') + "  bd7, " + RetSqlName('BAU') + " bau  , "   + RetSqlName('SE2') + " SE2  WHERE  BD7_FILIAL = ' ' AND bd7.d_E_L_E_T_ = ' '  and bau_FILIAL = ' ' AND bau.d_E_L_E_T_ = ' '  and e2_FILIAL = '01' AND SE2.d_E_L_E_T_ = ' ' "
cQuery += " and bd7_codope = '0001' and bd7_codrda = bau_codigo "
if !empty (cGroPag) 
   cQuery += " AND  BAU_GRPPAG = '"+ cGroPag +"' " 
EndIF   
cQuery += " AND  BD7_FASE = '3' AND  BD7_SITUAC = '1'   AND  BD7_BLOPAG <> '1' AND  BD7_VLRPAG > 0 AND  bd7_numlot =  ' ' and   SubStr (e2_pllote,1,6) = '"+cAnoMes+"' AND e2_codrda  = BD7_CODRDA order by BD7_CODRDA"

 If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
    Endif

    TCQuery cQuery Alias "TMP1" New 
    dbSelectArea("TMP1")
    TMP1->(dbGoTop())       
    tamanho      := "G"                  
    titulo         := "Rda's a Faturar com titulo gerados  "
    cabec1 := 'RDA     Fornecedor                                        Pref     Numero  Tipo    Emissao             Valor   Grp.Pag   Loc.Digit.
//             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//             0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21
    While !EOF()       
	  If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
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
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	 @ nLin,000 PSay  TMP1->Rda  
	 @ nLin,008 PSay  TMP1->fornecedor +' - ' + TMP1->Nome              
	 @ nLin,060 PSay  TMP1->Pref
     @ nLin,065 PSay  TMP1->Num 
     @ nLin,077 PSay  TMP1->tipo
     @ nLin,083 PSay  stod (TMP1->emissao)

     @ nLin,095 PSAY  TMP1->Vlr_Lote Picture "@E 999,999,999.99"        
     
     @ nLin,114 PSAY  TMP1->grppag
	                                                                                                                                        
	 @ nLin,124 PSAY  TMP1->loc_Dig

	nLin ++     // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo    
  @ nLin,000 PSay replicate("_",220)  
EndIF    
nLin:=80
 If mv_par04 = 1 
//  lote faturado sem titulo - 04 
cQuery := "  SELECT DISTINCT BD7_CODRDA rda ,bd7_nomrda nome, bd7_numlot numlot, sum(BD7_VLRPAG) vlr FROM " + RetSqlName('BD7') + " bd7 WHERE  BD7_FILIAL = ' ' "
cQuery += "  AND  BD7_FASE = '4' AND  BD7_SITUAC = '1' AND  BD7_BLOPAG <> '1' AND  BD7_VLRPAG > 0 "
cQuery += "  AND  SubStr (bd7_numlot,1,6) = '"+cAnomes +"' AND bd7.d_E_L_E_T_ = ' '  "
cQuery += "  AND not EXISTS (SELECT null FROM " + RetSqlName('SE2') + " SE2 WHERE e2_filial  = '01' and bd7_numlot = e2_pllote "
cQuery += "  AND e2_codrda  = BD7_CODRDA AND d_E_L_E_T_ = ' ' ) GROUP BY BD7_CODRDA ,bd7_nomrda , bd7_numlot ORDER BY  BD7_CODRDA , bd7_numlot "
   
If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
    Endif

    TCQuery cQuery Alias "TMP1" New 
    dbSelectArea("TMP1")
    TMP1->(dbGoTop())       
    tamanho      := "P"                                  
    titulo         := "Rda's Faturados Sem Titulos no financeiro "
    cabec1 := 'RDA      Nome                                    Num. Lote           Valor Lote'
//             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//             0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21
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
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     	
	 @ nLin,000 PSay  TMP1->Rda                                
 	 @ nLin,010 PSay  TMP1->nome                             
	 @ nLin,050 PSay  TMP1->numlot                             
	 @ nLin,080 PSAY  TMP1->Vlr Picture "@E 999,999,999.99"
	 
	nLin ++     // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo    
  @ nLin,000 PSay replicate("_",080)  
EndIF                                                           
  
 //c. Fornecedor no RDA - 05 
 nLin:=80
 If mv_par05 = 1      
 cQuery := " select bau_codigo Rda , bau_nome nome , BAU_CODSA2 Fornec_Rda,bau_codret CodRet ,' ' Tppessoa ,bau_grppag Gr_Pagto,' ' Natureza ,' ' Banco ,' ' Agencia, ' ' Conta, ' ' Fornec_Fin "
 cQuery += " from " + RetSqlName('BAU') + "  BAU  where bau_filial = ' ' and BAU.d_E_L_E_T_ =  ' ' AND BAU_CODSA2 = ' '  and bau_tippre not in ('NUP','MAT')"
 cQuery += " union all "
 cQuery += " select bau_codigo Rda ,  bau_nome nome , bau_codsa2 Fornec_Rda , bau_codret CodRet , a2_tipo Tppessoa ,bau_grppag Gr_Pagto ,A2_naturez Natureza, A2_banco Banco, A2_agencia Agencia, A2_numcon Conta , A2_cod Cod_Fornec_fin "
 cQuery += " from " + RetSqlName('BAU') + "  BAU , " + RetSqlName('SA2') + " SA2 where bau_filial = ' ' and BAU.d_E_L_E_T_ =  ' ' AND  A2_filial = ' ' and SA2.d_E_L_E_T_ =  ' '  "
 cQuery += " AND BAU_CODSA2 = A2_COD  and bau_tippre not in ('NUP','MAT') and (bau_codret = ' ' or bau_grppag = ' ' or A2_NATUREZ = ' ' or A2_BANCO = ' ' or A2_AGENCIA = ' ' or A2_CONTA = ' ' 
 cQuery += " or (bau_codret = '0588' and A2_NATUREZ <> '40002005')or (bau_codret = '0588' and A2_tipo <> 'F') or (bau_codret = '1788' and A2_tipo <> 'J')) "
 cQuery += " order by 1" 

 If Select((_cAliasRdaT)) <> 0 
           (_cAliasRdaT)->(DbCloseArea())  
 Endif   
 
    DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),_cAliasRdaT,.T.,.T.)
//    TCQuery cQuery Alias "TMP1" New 
    dbSelectArea(_cAliasRdaT)
    (_cAliasRdaT)->(dbGoTop())       
    tamanho      := "G"                                       
    titulo         := "Rda's Com cadastro Incompleto "                                           
    cabec1 := 'RDA                                                       Fornec. RDA      Cod Ret/TpPsa    Grp. pagto      Natureza   Banco     Agencia   Conta   Fornc. Financeiro '
//             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//             0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21
    While (_cAliasRdaT)->(!EOF())       
	  If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
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
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
  lLib:=.T.
  	 
	 cQueryBC := " select bc4_data dt , bc4_tipo tipo  , bc4_motblo motblo"
     cQueryBC += " from " + RetSqlName('BC4') + "  BC4   where BC4_FILIAL = ' ' AND D_e_l_e_t_ = ' '  and bc4_codcre = '"+(_cAliasRdaT)->rda+"'"
     cQueryBC += " order by  bc4_codcre  ,  bc4_data desc "    
	 if Select(("TMP11")) <> 0 
        ("TMP11")->(DbCloseArea())  
     Endif

     TCQuery cQueryBC Alias "TMP11" New 
     dbSelectArea("TMP11")
     TMP11->(dbGoTop())       	                     
     if TMP11->(!Eof())              
        if !(empty (TMP11->tipo) .or. TMP11->tipo = '1')
           lLib:=.F.   
        EndIf  
     EndIf
  If lLib      
	 @ nLin,000 PSay  (_cAliasRdaT)->Rda +" - "+ (_cAliasRdaT)->nome 
	 @ nLin,061 PSay  (_cAliasRdaT)->Fornec_Rda              
	 @ nLin,080 PSay  (_cAliasRdaT)->CodRet +' - '+(_cAliasRdaT)->Tppessoa      
     @ nLin,095 PSay  (_cAliasRdaT)->Gr_Pagto
     @ nLin,110 PSay  (_cAliasRdaT)->Natureza
     @ nLin,120 PSay  (_cAliasRdaT)->Banco
     @ nLin,130 PSay  (_cAliasRdaT)->Agencia
     @ nLin,140 PSay  (_cAliasRdaT)->Conta
     @ nLin,155 PSay  (_cAliasRdaT)->Fornec_Fin
   
	nLin ++     // Avanca a linha de impressao
  EndIf	
	(_cAliasRdaT)->(dbSkip())   // Avanca o ponteiro do registro no arquivo
EndDo    
  @ nLin,000 PSay replicate("_",220)  
EndIF    

//troca de gropo de pagamento -07-08 
 nLin:=80
 If mv_par07 = 1 .and. lLista 
    MsgInfo("rotima substituida pelo Processo cabr154")
 EndIF        
nLin:=80 

If mv_par08 = 1 .and. lLista
     MsgInfo("rotima substituida pelo Processo cabr154")
EndIF        

/*a. Duplicidade de Títulos Gerados na mesma competência - 03*/                                                                                                      
 nLin:=80
 If mv_par03 = 1 
    cQuery := " SELECT SE21.E2_PREFIXO Pref1 ,SE21.E2_NUM Num1 , SE21.E2_TIPO tipo1, (SE21.E2_VALOR + SE21.e2_inss + SE21.e2_Irrf + SE21.E2_vretpis + SE21.e2_vretcof + SE21.e2_vretcsl) Vlr_tit1, SE21.E2_EMISSAO emissao1, se21.e2_codrda Rda1, se21.e2_pllote lote1, se21.e2_nomfor nome ,Decode (SE21.E2_SALDO  ,0.00  ,'P',' ') PAGTO1,  "
    cQuery += "        SE22.E2_PREFIXO Pref2 ,SE22.E2_NUM Num2 , SE22.E2_TIPO tipo2, (SE22.E2_VALOR + SE22.e2_inss + SE22.e2_Irrf + SE22.E2_vretpis + SE22.e2_vretcof + SE22.e2_vretcsl) Vlr_tit2, SE22.E2_EMISSAO emissao2, se22.e2_codrda Rda2, se22.e2_pllote lote2 , Decode (SE22.E2_SALDO  ,0.00  ,'P',' ') PAGTO2 "
    cQuery += " FROM  " + RetSqlName('SE2') + " SE21  ," + RetSqlName('SE2') + " SE22 "
    cQuery += " WHERE SE21.E2_FILIAL = '01' AND SE22.E2_FILIAL = '01'  AND SE21.D_e_l_e_t_ = ' ' AND SE22.d_e_l_e_t_ = ' ' "
    cQuery += " AND SE21.E2_FORNECE = SE22.E2_FORNECE "
    cQuery += " AND SUBSTR (SE21.E2_pllote,1,6) = SUBSTR (SE22.E2_pllote,1,6) AND SE21.E2_NUM <> SE22.E2_NUM " 
    cQuery += " AND SE21.E2_ORIGEM = 'PLSMPAG' AND SE22.E2_ORIGEM = 'PLSMPAG' and SE21.e2_tipo not in ('ISS','INS','TX', 'TXA') and SE22.e2_tipo not in ('ISS','INS','TX', 'TXA')" 
    cQuery += " AND SUBSTR (SE21.E2_pllote,1,6)= '" +cAnoMes +"' AND SE21.E2_EMISSAO <= SE22.E2_EMISSAO "
    cQuery += " ORDER BY  SE21.E2_PREFIXO ,SE21.E2_NUM  , SE21.E2_TIPO , SE21.E2_VALOR , SE21.E2_INSS ,SE21.E2_EMISSAO "                                                                                           
    If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
    Endif

    TCQuery cQuery Alias "TMP1" New 
    dbSelectArea("TMP1")
    TMP1->(dbGoTop())  
	tamanho      := "G"                                     
    titulo       := "Rda's Com dois titulos gerados para a competencia  "+cAnoMes 
    cabec1 := 'RDA                                                       Lote                Valor  Pref     Numero  Tipo    Emissao   -    RDA     Lote                Valor  Pref     Numero  Tipo    Emissao  
//             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//             0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21
    While !EOF()                 
	  If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
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
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	 @ nLin,000 PSay  TMP1->Rda1+TMP1->PAGTO1  
     @ nLin,009 PSay  TMP1->nome  	 
	 @ nLin,059 PSay  TMP1->Lote1              
	 @ nLin,070 PSAY  TMP1->Vlr_tit1 Picture "@E 999,999,999.99"    
	 @ nLin,086 PSay  TMP1->Pref1
     @ nLin,092 PSay  TMP1->Num1 
     @ nLin,104 PSay  TMP1->tipo1
     @ nLin,109 PSay  stod (TMP1->emissao1)

     @ nLin,120 PSay  "-->"    

     @ nLin,124 PSay  TMP1->Rda2+TMP1->PAGTO2  
	 @ nLin,133 PSay  TMP1->Lote2              
	 @ nLin,145 PSAY  TMP1->Vlr_tit2 Picture "@E 999,999,999.99"    
	 @ nLin,161 PSay  TMP1->Pref2
     @ nLin,167 PSay  TMP1->Num2 
     @ nLin,179 PSay  TMP1->tipo2
     @ nLin,184 PSay  stod (TMP1->emissao2)


	nLin ++     // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo    
  @ nLin,000 PSay replicate("_",220)  
EndIF    
 
 If mv_par10 = 1 
//   titulo sem guias - 10 

 cQuery := " select e2_fornece , E2_NOMFOR, e2_prefixo , e2_num , e2_tipo , e2_emissao , E2_BAIXA, E2_ORIGEM , E2_PLLOTE , E2_CODRDA , E2_VALOR Vlr "
 cQuery += " from " + RetSqlName('SE2') + " SE2 where E2_FILIAL = '" + xFilial("SE2") + "'  and d_e_l_E_T_ = ' '  AND SUBSTR(E2_PLLOTE,1,6) = '"+cAnoMes +"' "  
 cQuery += "  AND E2_TIPO = 'FT' AND E2_ORIGEM = 'PLSMPAG' AND E2_PREFIXO <> 'OPE' "
 cQuery += "  AND ( not exists ( select NULL from " + RetSqlName('bd7') + " bd7 where d_E_L_E_T_ = ' ' and bd7_FILIAL = '" + xFilial("bd7") + "'  and e2_codrda = bd7_codrda AND E2_PLLOTE = BD7_NUMLOT)  "
 cQuery += "  AND   not exists ( SELECT NULL FROM " + RetSqlName('bgq') + " bgq where d_E_L_E_T_ = ' ' and BGQ_CODIGO = E2_CODRDA and bgq_FILIAL = '" + xFilial("bgq") + "' AND BGQ_CODLAN <> '050' AND BGQ_NUMLOT = E2_PLLOTE))"


If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
    Endif

    TCQuery cQuery Alias "TMP1" New 
    dbSelectArea("TMP1")
    TMP1->(dbGoTop())       
    tamanho      := "P"                                  
    titulo         := "Titulos Financeiro Emitidos Sem Guias  "
    cabec1 := 'Fornecedor                                       Titulo(s)                 Valor 
//             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//             0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21
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
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     	
	 @ nLin,000 PSay  TMP1->e2_fornece +'-'+ TMP1->E2_NOMFOR                                
 	 @ nLin,050 PSay  TMP1->e2_prefixo +' '+ TMP1->e2_num +' '+ TMP1->e2_tipo                             
	 @ nLin,070 PSAY  TMP1->Vlr Picture "@E 999,999.99"                                                                                        
	 
	 
	nLin ++     // Avanca a linha de impressao
	dbSkip()   // Avanca o ponteiro do registro no arquivo
EndDo    
  @ nLin,000 PSay replicate("_",080)  
EndIF     




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


PutSx1(cPerg,"01",OemToAnsi("Ano,Mes Competencia")      ,"","","mv_ch01","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "999999", "" )
PutSx1(cPerg,"02",OemToAnsi("Grupo de Pagamento Inicial")       ,"","","mv_ch02","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
PutSx1(cPerg,"03","+ 1 Titulo Na Competencia?"          ,"","","mv_ch03","N",01,0,0,"C","","","","","mv_par03","Sim ","","","","Não ","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"04","Lote Faturado Sem Titulo?"           ,"","","mv_ch04","N",01,0,0,"C","","","","","mv_par04","Sim ","","","","Não ","","","","","","","","","","","","",{},{}) 
PutSx1(cPerg,"05","Consiste Dados RDA?"                 ,"","","mv_ch05","N",01,0,0,"C","","","","","mv_par05","Sim ","","","","Não ","","","","","","","","","","","","",{},{}) 
PutSx1(cPerg,"06","Guias á Fat C/ tit.Gerados?"         ,"","","mv_ch06","N",01,0,0,"C","","","","","mv_par06","Sim ","","","","Não ","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"07","Otimizar    Pagto Medico?"           ,"","","mv_ch07","N",01,0,0,"C","","","","","mv_par07","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"08","Desfaze Otimização Pagto Medico?"    ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"09","Guias á Fat. Por Grp Pagto?"         ,"","","mv_ch09","",01,0,0,"C","","","","","mv_par09","Sim ","","","","Não ","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"10","Titulos Sem Guias ?  "               ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sim ","","","","Não ","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"11","Considera Procedimento De  : "       ,"","","mv_ch11","D",08,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","","",{},{}) 
PutSx1(cPerg,"12","Considera Procedimento Ate : "       ,"","","mv_ch12","D",08,0,0,"G","","","","","mv_par12","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"13",OemToAnsi("Grupo de Pagamento final") ,"","","mv_ch13","C",04,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999", "" )
PutSx1(cPerg,"14","Otimizar Somente com 3.5 feita ?"    ,"","","mv_ch14","N",01,0,0,"C","","","","","mv_par14","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                
PutSx1(cPerg,"15","Considerar Otimizar Somente com 3.5 feita ?"    ,"","","mv_ch15","N",01,0,0,"C","","","","","mv_par15","Sim ","","","","Não ","","","","","","","","","","","","",{},{})                                                                                                                                                                                


Return(.T.)


