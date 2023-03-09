#INCLUDE "protheus.ch"  
#INCLUDE 'UTILIDADES.CH'
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA103  º Autor ³ Altamiro Affonso   º Data ³  10/11/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ DEBITO DE COMISSÃO RN412                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABA192

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo fazer debitos na comissão por  "
Local cDesc2         := "motivo de devolução , RN412,  importancia pagas sobre assistido excluido"
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Devolução de Comissão - RN412 "
Local nLin           := 80 															
Local Cabec1         := " Vendedor                                   Empresa                                 Cliente                                   Vlr Base       %          Vlr Com.   Mes/Ano Dev. Dt. Bloqueio  Dt. Inclusão  Origem "
//                       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20
//                       XXXX.XXXX.XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    XXX  XXXXXXXXX   XX  999.999.999,99 999.999.999,99  xx/xx/xxxx   XXXX      XX
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
PRIVATE ADADOS       := {}
PRIVATE  lFaz        := .T.
private nAscan       := 0
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABA192"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABA192"
Private cString      := "SE2"
Private cPerg        := "CABA192   "
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     := .F.
private cNovGrpPag   := " "     

private  nMACob      := ' '                                                   
private  nMADev      := ' '                                                         
private  Vlr_TotCom  := 0.00
private  Vlr_TotBas  := 0.00  

private  VlrTGCom   := 0.00
private  VlrTGBas   := 0.00  
private  cCodVen    := ' '
private  cseq       := ' '

private cAprov      := SuperGetMv('MV_AUTCMS') 
Private _cIdUsuar   := RetCodUsr()

private cOrigem     := ' '
private nContador   := 0
dbSelectArea("SE2")
dbSetOrder(1)

ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif
                                

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
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßƒßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cQuery  := ' '                                          
Local cQuery1 := ' '

dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())       
 
cQuery := CRLF + "SELECT sum(orig.bm1_valor)vlrbase , "
cQuery += CRLF + "       round(sum(orig.bm1_valor * orig.percom/100),2) comissao , "  
cQuery += CRLF + "       round(sum(orig.bm1_valor * orig.percom)/(sum(orig.bm1_valor)),2) perc , "
cQuery += CRLF + "       count(*) qtda , "
cQuery += CRLF + "       orig.codven codven , "
cQuery += CRLF + "       orig.codint codint , "
cQuery += CRLF + "       orig.codemp codemp , "
cQuery += CRLF + "       orig.matric matric , "
cQuery += CRLF + "       orig.tipreg tipreg , "
cQuery += CRLF + "       orig.digito digito , "
cQuery += CRLF + "       orig.NomUsr , "
cQuery += CRLF + "       orig.bg9_descri , "
cQuery += CRLF + "       orig.A3_NOME  , "
cQuery += CRLF + "       ORIG.BXQ_CODEQU , "
cQuery += CRLF + "       ORIG.BXQ_PREFIX , "
cQuery += CRLF + "       ORIG.BXQ_NUM    , "
cQuery += CRLF + "       ORIG.BXQ_PARC   , "
cQuery += CRLF + "       ORIG.BXQ_TIPO   , "
cQuery += CRLF + "       ORIG.BXQ_NUMCON , "
cQuery += CRLF + "       ORIG.BXQ_VERCON , "
cQuery += CRLF + "       ORIG.BXQ_SUBCON , "
cQuery += CRLF + "       ORIG.BXQ_VERSUB , "
cQuery += CRLF + "       ORIG.BXQ_DATA   , "
cQuery += CRLF + "       ORIG.BXQ_SEQBXO , ORIG.BXQ_E2NUM  , "
cQuery += CRLF + "       ORIG.percom     , ORIG.BA1_DATBLO ,ORIG.BA1_DATINC , ORIG.origem origem "

cQuery += CRLF + "  FROM (SELECT TRIM(bm1_origem) || nvl(TRIM(bxq1.bxq_codven), '') origem , " 
cQuery += CRLF + "               bm1_valor  , " 
cQuery += CRLF + "               bca_matric , " 
cQuery += CRLF + "               bca_tipreg , " 
cQuery += CRLF + "               MAX(nvl(bxq.bxq_numpar,'001')) numpar , " 
cQuery += CRLF + "               nvl(bxq1.bxq_numpar,'001')  , "
cQuery += CRLF + "               nvl(bxq1.bxq_percom, '0') percom , "
cQuery += CRLF + "               substr(bca_matric,1,4) codint , "
cQuery += CRLF + "               substr(bca_matric,5,4) codemp , "
cQuery += CRLF + "               substr(bca_matric,9,6) matric , " 
cQuery += CRLF + "               bca_tipreg             tipreg , "
cQuery += CRLF + "               nvl(bxq1.bxq_codven,'000000') codven , "
cQuery += CRLF + "               nvl(bxq1.bxq_digito,'0')      digito , "
cQuery += CRLF + "               ba1_nomusr   NomUsr , "
cQuery += CRLF + "               bg9_descri bg9_descri , " 
cQuery += CRLF + "               A3_NOME A3_NOME ,"         
cQuery += CRLF + "               NVL(BXQ1.BXQ_CODEQU, ' ') BXQ_CODEQU , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_PREFIX,' ')  BXQ_PREFIX , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_NUM,' ')     BXQ_NUM    , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_PARC,' ')    BXQ_PARC   , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_TIPO,' ')    BXQ_TIPO   , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_NUMCON,' ')  BXQ_NUMCON , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_VERCON,' ')  BXQ_VERCON , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_SUBCON,' ')  BXQ_SUBCON , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_VERSUB,' ')  BXQ_VERSUB , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_DATA,' ')    BXQ_DATA   , "
cQuery += CRLF + "               NVL(BXQ1.BXQ_SEQBXO,' ')  BXQ_SEQBXO , "

cQuery += CRLF + "               NVL(BXQ1.BXQ_E2NUM ,' ')  BXQ_E2NUM  , "

cQuery += CRLF + "               BA1_DATBLO  BA1_DATBLO  ,  BA1_DATINC  BA1_DATINC  "
cQuery += CRLF + "         FROM " + RetSqlName('BM1') + " BM1 , "
cQuery += CRLF + "              " + RetSqlName('BCA') + " BCA , "
cQuery += CRLF + "              " + RetSqlName('BXQ') + " BXQ , "
cQuery += CRLF + "              " + RetSqlName('BXQ') + " BXQ1, "
cQuery += CRLF + "              " + RetSqlName('BA1') + " BA1 , "
cQuery += CRLF + "              " + RetSqlName('BG9') + " BG9 , "
cQuery += CRLF + "              " + RetSqlName('SA3') + " SA3   "
cQuery += CRLF + "        WHERE bm1_filial         = '" + xFilial("BM1") +"' AND bm1.d_e_l_e_t_     = ' ' "
cQuery += CRLF + "          AND bca_filial         = '" + xFilial("BCA") +"' AND bca.d_e_l_e_t_     = ' ' "
cQuery += CRLF + "          AND bxq.bxq_filial(+)  = '" + xFilial("BXQ") +"' AND bxq.d_e_l_e_t_(+)  = ' ' "
cQuery += CRLF + "          AND bxq1.bxq_filial(+) = '" + xFilial("BXQ") +"' AND bxq1.d_e_l_e_t_(+) = ' ' "
cQuery += CRLF + "          AND bg9.BG9_FILIAL(+)  = '" + xFilial("BG9") +"' AND BG9.D_e_l_e_t_(+)  = ' ' "
cQuery += CRLF + "          AND sa3.A3_FILIAL(+)   = '" + xFilial("SA3") +"' AND SA3.D_e_l_e_t_(+)  = ' ' "   
cQuery += CRLF + "          AND BA1.BA1_FILIAL(+)  = '" + xFilial("BA1") +"' AND BA1.D_e_l_e_t_(+)  = ' ' "   
cQuery += CRLF + "            AND BG9_codint = bxq1.bxq_codint "
cQuery += CRLF + "            and bg9_codigo = bxq1.bxq_codemp " 
cQuery += CRLF + "            AND bxq1.BXQ_CODVEN = A3_COD "
cQuery += CRLF + "            AND bm1_codtip ='910' AND bm1_codeve = '014' "

cQuery += CRLF + "            AND bm1_mes = '"+MV_PAR02+"' AND bm1_ano =  '"+MV_PAR03+"' AND bm1_codemp = '"+ MV_PAR01+"'"

cQuery += CRLF + "            AND substr(bca_matric,1,4) = ba1.ba1_codint " 
cQuery += CRLF + "            AND substr(bca_matric,5,4) = ba1.ba1_codemp "
cQuery += CRLF + "            AND substr(bca_matric,9,6) = ba1.ba1_matric "
cQuery += CRLF + "            AND bca_tipreg             = ba1.ba1_tipreg "
cQuery += CRLF + "            AND bca.bca_xcredi = bm1_origem "
cQuery += CRLF + "            AND bca.bca_xstatu <> ' ' "
cQuery += CRLF + "            AND substr(bca_matric,1,4) = bxq.bxq_codint(+) "
cQuery += CRLF + "            AND substr(bca_matric,5,4) = bxq.bxq_codemp(+) "
cQuery += CRLF + "            AND substr(bca_matric,9,6) = bxq.bxq_matric(+) "
cQuery += CRLF + "            AND bca_tipreg             = bxq.bxq_tipreg(+) "
// por orientação do diretor Armando foi retirada a possibilidade de cobrar comissoes pagas ao vendedor interno 
cQuery += CRLF + "            AND bxq.bxq_numpar <> '999' and bxq.bxq_codven <> '000215' "
cQuery += CRLF + "            AND substr(bca_matric,1,4)  = bxq1.bxq_codint(+) "
cQuery += CRLF + "            AND substr(bca_matric,5,4)  = bxq1.bxq_codemp(+) "
cQuery += CRLF + "            AND substr(bca_matric,9,6)  = bxq1.bxq_matric(+) "
cQuery += CRLF + "            AND bca_tipreg              = bxq1.bxq_tipreg(+) "
cQuery += CRLF + "         HAVING (MAX(nvl(bxq.bxq_numpar,'001'))) = bxq1.bxq_numpar(+) "
cQuery += CRLF + "          GROUP BY trim(bm1_origem) || nvl(trim(bxq1.bxq_codven), '') , bm1_valor  , bca_matric , bca_tipreg ,bxq1.bxq_numpar, bxq1.bxq_percom , "
cQuery += CRLF + "                   substr(bca_matric,1,4) ,substr(bca_matric,5,4) , substr(bca_matric,9,6) , bca_tipreg , "
cQuery += CRLF + "                   nvl(bxq1.bxq_codven,'000000'), nvl(bxq1.bxq_digito,'0') ,"
cQuery += CRLF + "                   ba1_nomusr , bg9_descri , A3_NOME ,BA1_DATBLO ,  BA1_DATINC , "
cQuery += CRLF + "                   NVL(BXQ1.BXQ_CODEQU, ' ') ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_PREFIX,' ')  ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_NUM,' ')     ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_PARC,' ')    ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_TIPO,' ')    ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_NUMCON,' ')  ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_VERCON,' ')  ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_SUBCON,' ')  ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_VERSUB,' ')  ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_DATA,' ')    ,"
cQuery += CRLF + "                   NVL(BXQ1.BXQ_SEQBXO,' ')  , NVL(BXQ1.BXQ_E2NUM ,' ') ) orig " 
cQuery += CRLF + "       where  orig.codven <> '000215'"       
cQuery += CRLF + "       GROUP  BY orig.codven , orig.codemp , orig.codint , orig.codemp ,orig.matric , orig.tipreg , orig.digito , "
cQuery += CRLF + "              orig.NomUsr ,orig.bg9_descri , orig.A3_NOME , "
cQuery += CRLF + "              ORIG.BXQ_CODEQU ,"
cQuery += CRLF + "              ORIG.BXQ_PREFIX ,"
cQuery += CRLF + "              ORIG.BXQ_NUM    ,"
cQuery += CRLF + "              ORIG.BXQ_PARC   ,"
cQuery += CRLF + "              ORIG.BXQ_TIPO   ,"
cQuery += CRLF + "              ORIG.BXQ_NUMCON ,"
cQuery += CRLF + "              ORIG.BXQ_VERCON ,"
cQuery += CRLF + "              ORIG.BXQ_SUBCON ," 
cQuery += CRLF + "              ORIG.BXQ_VERSUB ,"
cQuery += CRLF + "              ORIG.BXQ_DATA   ,"
cQuery += CRLF + "              ORIG.BXQ_SEQBXO , ORIG.BXQ_E2NUM ,"
cQuery += CRLF + "              ORIG.percom     , ORIG.BA1_DATBLO , ORIG.BA1_DATINC  , ORIG.origem" 	
cQuery += CRLF + "       ORDER  BY orig.codven ,  ORIG.origem ,  orig.codemp , orig.codint , orig.codemp ,orig.matric , orig.tipreg "
 

cQuery1 := CRLF + "       SELECT bsq_codint codint  , " 
cQuery1 += CRLF + "              bsq_codemp codemp  , "
cQuery1 += CRLF + "              bsq_matric matric  , "
cQuery1 += CRLF + "              bsq_codseq codseq  , "
cQuery1 += CRLF + "              bm1_origem origem  , "
cQuery1 += CRLF + "              bsq_valor  valorBSQ, "
cQuery1 += CRLF + "              bm1_valor  valorBM1  "
cQuery1 += CRLF + "         FROM " + RetSqlName('BM1') + " BM1 , " + RetSqlName('BSQ') + " BSQ " 
cQuery1 += CRLF + "        WHERE BM1_filial = '" + xFilial("BM1") +"' AND BM1.d_e_l_e_t_     = ' ' "
cQuery1 += CRLF + "          AND BSQ_filial = '" + xFilial("BSQ") +"' AND BSQ.d_e_l_e_t_     = ' ' " 
cQuery1 += CRLF + "          AND bm1_codtip ='910' AND bm1_codeve = '014' "
cQuery1 += CRLF + "          AND bm1_mes = '"+MV_PAR02+"' AND bm1_ano =  '"+MV_PAR03+"' AND bm1_codemp = '"+ MV_PAR01+"'"
cQuery1 += CRLF + "          and bm1_codseq = bsq_codseq "
cQuery1 += CRLF + "          and BM1.BM1_NUMTIT <> ' '    order by 5 "

 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea())  
 Endif
    TCQuery cQuery Alias "TMP" New 
    dbSelectArea("TMP")
    tmp->(dbGoTop())                                 

 If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea())  
 Endif
    TCQuery cQuery1 Alias "TMP1" New 
    dbSelectArea("TMP1")
    TMP1->(dbGoTop())             
/*
	If (nAscan:=Ascan(aDados , {|e| e[4]+e[5] == trim(substr(tmp->origem,1,8)) + ,;
                                                 trim(substr(tmp->origem,1,8))})) == 0  
*/ 
    While !TMP1->(EOF())
   			
        Aadd(aDados,{ tmp1->codint , tmp1->CodEmp , tmp1->matric , tmp1->CodSeq , tmp1->origem , tmp1->valorBsq , tmp1->valorBm1 , .T.})

            TMP1->(dbSkip())   
    EndDo

    While !TMP->(EOF())                                                                
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
     
        If  cOrigem == tmp->origem 
            
            cOrigem := tmp->origem
            
            tmp->(dbSkip())   

            Loop
            
        EndIf        
        
        cOrigem := tmp->origem

        If cCodVen == ' '
           cCodVen := tmp->codven
        ElseIf cCodVen != tmp->codven 
           cCodVen := tmp->codven
             @ nLin,000 PSay replicate("_",220)  
               nLin ++
             @ nLin,001 PSAY  'Total do Debito para o vendedor '                                                                 
  	         @ nLin,117 PSay  Vlr_TotBas    Picture "@E -999,999,999.99"
	         @ nLin,143 PSAY  Vlr_TotCom    Picture "@E -999,999,999.99"    
               nLin ++
             @ nLin,000 PSay replicate("_",220)
             nLin ++   
             Vlr_TotBas := 0.00
             Vlr_TotCom := 0.00
             
        EndIf                                     

        @ nLin,000 PSay  trim(tmp->codven) + ' - ' + substr(tmp->A3_NOME,1,30)
        @ nLin,045 PSay  trim(tmp->codemp) + ' - ' + substr (tmp->bg9_descri,1,25)
        @ nLin,085 PSay  trim(tmp->matric) +'.'+ trim(tmp->TIPREG) +'.'+ trim(tmp->DIGITO)  +' - '+ SUBSTR (TMP->NOMUSR,1,20)
        @ nLin,118 PSay  (tmp->vlrbase  *-1)   Picture "@E -999,999,999.99"
        @ nLin,136 PSAY   tmp->percom          Picture "@E  9999.99%"  
        @ nLin,144 PSAY  (tmp->comissao *-1)   Picture "@E -999,999,999.99"                                                       
        @ nLin,165 PSAY  MV_par02+"/"+MV_par03                                          
        @ nLin,175 PSAY  substr (tmp->ba1_datblo,7,2) +"/"+substr (tmp->ba1_datblo,5,2)+"/"+substr (tmp->ba1_datblo,1,4)
        @ nLin,188 PSAY  substr (tmp->ba1_datinc,7,2) +"/"+substr (tmp->ba1_datinc,5,2)+"/"+substr (tmp->ba1_datinc,1,4)
        If tmp->ba1_datblo == tmp->ba1_datinc .or. trim(tmp->ba1_datblo) == ''  
           @ nLin,200 PSAY '*'
        EndIf       
        @ nLin,204 PSAY  tmp->origem                                       
        Vlr_TotCom      += (tmp->comissao * -1)
        Vlr_TotBas      += (tmp->VlrBase  * -1)  
        VlrTGCom        += (tmp->comissao * -1)
        VlrTGBas        += (tmp->VlrBase  * -1)                                          
        nLin ++     // Avanca a linha de impressao
        nContador++ 

        If (nAscan:=Ascan(aDados , {|e| e[4] == trim(substr(tmp->origem,1,8))})) != 0 
            ADADOS[nAscan,8] := .F.
        
        EndIf

	tmp->(dbSkip())      // Avanca o ponteiro do registro no arquivo

EndDo

    @ nLin,000 PSay replicate("_",220)  
    nLin ++                                             
    @ nLin,001 PSAY  'Total do Debito para o vendedor '                     
    @ nLin,117 PSay  Vlr_TotBas    Picture "@E -999,999,999.99"
	@ nLin,143 PSAY  Vlr_TotCom    Picture "@E -999,999,999.99"    	
    nLin ++
    @ nLin,000 PSay replicate("_",220)                            
    nLin ++                                                                   
  	@ nLin,001 PSAY  'Total do Debito Geral '

    	@ nLin,100 PSAY  nContador      

    @ nLin,117 PSay  VlrTGBas    Picture "@E -999,999,999.99"
	@ nLin,143 PSAY  VlrTGCom    Picture "@E -999,999,999.99"    
    nLin ++
    IF  mv_par04 == 1 
        @ nLin,001 PSAY " Lançamento na Comissão "
        IF  tmp->bxq_e2num != ' '
            @ nLin,028 PSAY " , Mas a titulos gerados "+tmp->bxq_e2num 
        EndIf   
        nLin ++
    EndIf 
    @ nLin,000 PSay replicate("_",220)                            

    For i := 1  to len(ADADOS)
    
        If  ADADOS[i,8]== .T.

            iF lFaz == .T.

       	       nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	           nLin ++
               nLin ++

               @ nLin,000 PSay  '                            --> VERIFICAR JUNTO AO FINANCEIRO - LANÇAMENTO DE CREDITO SEM IDENTIFICAÇÃO DE COMISSÃO <--'
                
               nLin ++
               nLin ++
               
               lFaz := .F.

            EndIf 

            @ nLin,000 PSay   'Matricula : ' + ADADOS[i,1] +'.' + ADADOS[i,2] +'.'+ ADADOS[i,3]   
            @ nLin,045 PSay  'Codigo de lançamento de Deb/Cred' + ADADOS[i,4] 
            @ nLin,105 PSay  'Valor lançado a credito Empressa R$ ' + Transform(aDados[i][6],'@E  999,999.99')  
              nLin ++

            If  nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
                nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
                nLin ++
                nLin ++
                @ nLin,000 PSay  '                            --> VERIFICAR JUNTO AO FINANCEIRO - LANÇAMENTO DE CREDITO SEM IDENTIFICAÇÃO DE COMISSÃO <--'
                nLin ++
            Endif  
        
        EndIf 
    next

   If  !_cIdUsuar $ cAprov

       MsgAlert("Você Não esta autorizado a fazer lançamentos na Comissão!!! ","Atencao!")

   EndIf
    
IF  mv_par04 == 1  .and. _cIdUsuar $ cAprov   

    If msgyesno("confirma Lançamento na Comissão")  

        tmp->(dbGoTop())                                                         
    
        cOrigem := ' '
    
        While !TMP->(EOF())

            If  cOrigem == tmp->origem   
                
                cOrigem := tmp->origem
                
                tmp->(dbSkip())   

                Loop
                
            EndIf        

       	    reclock("BXQ",.T.)                                                       
            
                cseq:=nextcodtab('BXQ', 'BXQ_SEQ',.T.)
                BXQ->BXQ_FILIAL := xFilial("BXQ") 
                BXQ->BXQ_ANO    := mv_par03  
                BXQ->BXQ_MES    := mv_par02    
                BXQ->BXQ_CODVEN := TMP->CODVEN 
                BXQ->BXQ_CODEQU := TMP->BXQ_CODEQU 
                BXQ->BXQ_PREFIX := TMP->BXQ_PREFIX     
                BXQ->BXQ_NUM    := TMP->BXQ_NUM        
                BXQ->BXQ_PARC   := TMP->BXQ_PARC       
                BXQ->BXQ_TIPO   := TMP->BXQ_TIPO       
                BXQ->BXQ_CODINT := TMP->CODINT 
                BXQ->BXQ_CODEMP := TMP->CODEMP 
                BXQ->BXQ_MATRIC := TMP->MATRIC 
                BXQ->BXQ_TIPREG := TMP->TIPREG 
                BXQ->BXQ_DIGITO := TMP->DIGITO 
                BXQ->BXQ_NUMCON := TMP->BXQ_NUMCON 
                BXQ->BXQ_VERCON := TMP->BXQ_VERCON   
                BXQ->BXQ_SUBCON := TMP->BXQ_SUBCON 
                BXQ->BXQ_VERSUB := TMP->BXQ_VERSUB 
                BXQ->BXQ_DATA   := stod(TMP->BXQ_DATA)   
                BXQ->BXQ_SEQBXO := TMP->BXQ_SEQBXO 
                BXQ->BXQ_SEQ    := cseq    
                BXQ->BXQ_NUMPAR := "999" //TMP->BXQ_NUMPAR 
                BXQ->BXQ_BASCOM := (tmp->vlrbase  *-1)
                BXQ->BXQ_PERCOM := (tmp->percom   *-1)  
                BXQ->BXQ_VLRCOM := (tmp->comissao *-1)
                BXQ->BXQ_REFERE := '1' 
                BXQ->BXQ_PAGCOM := '1' 
                BXQ->BXQ_PAGPER := 100
                
            BXQ->(MsUnlock())	
            
            cOrigem := tmp->origem
            
            tmp->(dbSkip())   // Avanca o ponteiro do registro no arquivo
            
       EndDo

    EndIF
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

cPerg := PADR(cPerg,7)    

PutSx1(cPerg,"01","Mes/Ano Cobrado   "  ,"","","mv_ch01","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" )   
PutSx1(cPerg,"02","Mes/Ano Devolução "  ,"","","mv_ch02","C",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" )  
PutSx1(cPerg,"03","Matr. Completa    "  ,"","","mv_ch03","C",17,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" )  
PutSx1(cPerg,"04","Matr. Completa    "  ,"","","mv_ch04","C",17,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"05","Matr. Completa    "  ,"","","mv_ch05","C",17,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"06","Matr. Completa    "  ,"","","mv_ch06","C",17,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"07","Matr. Completa    "  ,"","","mv_ch07","C",17,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"08","Matr. Completa    "  ,"","","mv_ch08","C",17,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"09","Matr. Completa    "  ,"","","mv_ch09","C",17,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"10","Matr. Completa    "  ,"","","mv_ch10","C",17,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"11","Matr. Completa    "  ,"","","mv_ch11","C",17,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"12","Matr. Completa    "  ,"","","mv_ch12","C",17,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"13","Matr. Completa    "  ,"","","mv_ch13","C",17,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"14","Matr. Completa    "  ,"","","mv_ch14","C",17,0,0,"G","","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"15","Matr. Completa    "  ,"","","mv_ch15","C",17,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"16","Matr. Completa    "  ,"","","mv_ch16","C",17,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"17","Matr. Completa    "  ,"","","mv_ch17","C",17,0,0,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999.9999.999999.99-9", "" ) 
PutSx1(cPerg,"18","Lança Comissão    "  ,"","","mv_ch18","N",01,0,0,"C","","mv_par18","sim ","","","","Nao","","","","","","","","","","","","","","" , "" , "" , "", "", "" )

PutSx1(cPerg,"19","Lança Comissão    "  ,"","","mv_ch19","N",01,0,0,"C","","mv_par19","Deb(-) ","","","","Cred(+)","","","","","","","","","","","","","","" , "" , "" , "", "", "" )
PutSx1(cPerg,"20","Vlr Base Comissao "  ,"","","mv_ch20","N",17,0,0,"C","","mv_par20","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "9999,999.99", "" )   
PutSx1(cPerg,"21","Vlr  Comissao     "  ,"","","mv_ch21","N",17,0,0,"C","","mv_par21","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "999,999.99", "" )  
PutSx1(cPerg,"22","pREC(%) Comissao  "  ,"","","mv_ch22","N",17,0,0,"C","","mv_par22","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99.99", "" )  

Return(.T.)


