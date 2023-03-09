#INCLUDE "protheus.ch"  
#INCLUDE 'UTILIDADES.CH'
#INCLUDE "topconn.ch"
#INCLUDE "rwmake.ch"
#Include "TbiConn.ch"
#include "PLSMGER.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA103  º Autor ³ Altamiro Affonso   º Data ³  10/11/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ DEBITO DE COMISSÃO                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABA103()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo fazer debitos na comissão por  "
Local cDesc2         := "motivo de devolução de importancia pagas sobre assistido excluido"
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Devolução de Comissão - 901 Mensaliade Indevida  "
Local nLin           := 80 															
//Local Cabec1         := " Vendedor                                   Empresa                                 Cliente                                 Vlr Base       %          Vlr Com.    Mes/Ano Cobr.  Mes/Ano Dev.                Valor_901 "
Local Cabec1           := " Vendedor      Empresa   Cliente                                                                 Data Bloqueio               Vlr Base       %          Vlr Com.    Mes/Ano Cobr.  Mes/Ano Dev.                Valor_901 "
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789001234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17         18        19        20        21
//                       XXXX.XXXX.XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    XXX  XXXXXXXXX   XX  999.999.999,99 999.999.999,99  xx/xx/xxxx   XXXX      XX
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABA103"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABA103"
Private cString      := "SE2"
Private cPerg        := "CABA192   "
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00                                                                     
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "     

private cAprov       := SuperGetMv('MV_AUTCMS') 
Private _cIdUsuar    := RetCodUsr()

private  nMACob      := ' '                                                   
private  nMADev      := ' '                                                         
private  vlr_TotCom  := 0.00
private  vlr_TotBas  := 0.00
private  Vlr_Tot901  := 0.00  
private  cseq        :=' '
private  nCont       := 0
private cQuery1      := ' '
private cQuery2      := ' '

private aDetDiv      :={}
private cCodVen      := ' '


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
///////////////////////

cQuery :=       " SELECT distinct *  FROM " + RetSqlName('BXQ') + " BXQ , "
cQuery += CRLF +"          (select bXQ_codint || bXQ_codemp || bXQ_matric || bXQ_tipreg MATRIC ,MAX(bXQ_ano||bXQ_mes) COMPTE_MAX , " 
//cQuery += CRLF +"                  SUBSTR(BA1_DATBLO, 1,6) COMPTE_MIN ," "
 
 //  TRATAMENTO PARA DATA DE BLOQUEIO EM BRANCO 
cQuery += CRLF +" decode(TRIM(ba1_datblo), '' , "
cQuery += CRLF +" ('20'||SUBSTR(TO_CHAR(ADD_MONTHS(TO_DATE(SUBSTR(BA1_DATINC,1,6),'YYYYMM'),DECODE(TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(BA1_DATINC, 1,6),'YYYYMM')),'DD'),SUBSTR(BA1_DATINC, 7,2),1,0))),7,2) "
cQuery += CRLF +"      ||SUBSTR(TO_CHAR(ADD_MONTHS(TO_DATE(SUBSTR(BA1_DATINC,1,6),'YYYYMM'),DECODE(TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(BA1_DATINC, 1,6),'YYYYMM')),'DD'),SUBSTR(BA1_DATINC, 7,2),1,0))),4,2)), "
cQuery += CRLF +"  '20'||SUBSTR(TO_CHAR(ADD_MONTHS(TO_DATE(SUBSTR(BA1_DATBLO,1,6),'YYYYMM'),DECODE(TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(BA1_DATBLO, 1,6),'YYYYMM')),'DD'),SUBSTR(BA1_DATBLO, 7,2),1,0))),7,2) "
cQuery += CRLF +"      ||SUBSTR(TO_CHAR(ADD_MONTHS(TO_DATE(SUBSTR(BA1_DATBLO,1,6),'YYYYMM'),DECODE(TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(BA1_DATBLO, 1,6),'YYYYMM')),'DD'),SUBSTR(BA1_DATBLO, 7,2),1,0))),4,2)) COMPTE_MIN ,"
///// ALTAMIRO  07/03/2022
/*
cQuery += CRLF +" '20'||SUBSTR(TO_CHAR(ADD_MONTHS(TO_DATE(SUBSTR(BA1_DATBLO,1,6),'YYYYMM'),DECODE(TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(BA1_DATBLO, 1,6),'YYYYMM')),'DD'),SUBSTR(BA1_DATBLO, 7,2),1,0))),7,2)"
cQuery += CRLF +"     ||SUBSTR(TO_CHAR(ADD_MONTHS(TO_DATE(SUBSTR(BA1_DATBLO,1,6),'YYYYMM'),DECODE(TO_CHAR(LAST_DAY(TO_DATE(SUBSTR(BA1_DATBLO, 1,6),'YYYYMM')),'DD'),SUBSTR(BA1_DATBLO, 7,2),1,0))),4,2) COMPTE_MIN ,"
*/
cQuery += CRLF +"                  BA1.BA1_NOMUSR NOMUSR , ba1_datblo  datblo " 
cQuery += CRLF +"             from " + RetSqlName('BXQ') + " BXQ ,  " + RetSqlName('BA1') + " BA1 , " + RetSqlName('BM1') + " BM1 ,   
cQuery += CRLF +"                 (select bm1_codint || bm1_codemp || bm1_matric || bm1_tipreg MATRIC901 " 
cQuery += CRLF +"                    from " + RetSqlName('BM1') + " BM1 "    

cQuery += CRLF +"                   where bm1_filial = ' ' and d_E_L_E_T_ = ' ' "  
cQuery += CRLF +"                     and bm1_codemp = '"+ MV_PAR01+"'"  
cQuery += CRLF +"                     and bm1_ano = '"+ MV_PAR03+"' and bm1_mes = '"+ MV_PAR02+"'"
cQuery += CRLF +"                     and bm1_codtip = '901' ) BM12 "
cQuery += CRLF +"            where bXQ_filial = ' ' and BXQ.d_E_L_E_T_= ' ' "
cQuery += CRLF +"              AND ba1_filial = ' ' and BA1.d_E_L_E_T_= ' ' "
cQuery += CRLF +"              and bXQ_codemp = '"+ MV_PAR01+"'" 
cQuery += CRLF +"              and bxq_refere = bxq_pagcom "

cQuery += CRLF +"              and bXQ_codint = substr(BM12.MATRIC901,1,4) "
cQuery += CRLF +"              and bXQ_codemp = substr(BM12.MATRIC901,5,4) "
cQuery += CRLF +"              and bXQ_matric = substr(BM12.MATRIC901,9,6) "
cQuery += CRLF +"              and bXQ_tipreg = substr(BM12.MATRIC901,15,2)" 

cQuery += CRLF +"              and bA1_codint = bXQ_codint "
cQuery += CRLF +"              and bA1_codemp = bXQ_codemp "
cQuery += CRLF +"              and bA1_matric = bXQ_matric "
cQuery += CRLF +"              and bA1_tipreg = bXQ_tipreg "

cQuery += CRLF +"              AND bm1_filial = ' ' and BM1.d_E_L_E_T_ = ' ' " 
cQuery += CRLF +"              and bM1_codint = bXQ_codint "
cQuery += CRLF +"              and bM1_codemp = bXQ_codemp "
cQuery += CRLF +"              and bM1_matric = bXQ_matric " 
cQuery += CRLF +"              and bm1_codtip = '101' "
cQuery += CRLF +"              AND BM1_ANO    = BXQ_ANO "
cQuery += CRLF +"              AND BM1_MES    = BXQ_MES "

cQuery += CRLF +"              and bA1_codint || bA1_codemp || bA1_matric || bA1_tipreg in BM12.MATRIC901 "
cQuery += CRLF +"         GROUP BY bXQ_codint || bXQ_codemp || bXQ_matric || bXQ_tipreg , SUBSTR(BA1_DATBLO, 1,6) "

cQuery += CRLF +"         , BA1.BA1_NOMUSR , ba1.ba1_datblo, ba1.ba1_datINC) BXQA , "
cQuery += CRLF +"            (select bm1_codint || bm1_codemp || bm1_matric || bm1_tipreg MATRIC , "
cQuery += CRLF +"                   (bm1_ano||bm1_mes) COMPTE , BM1_CODTIP ||'-'||BM1_DESTIP DESTIP , "  
cQuery += CRLF +"                    BM1_VALOR VALOR_901 " //, BM1_ORIGEM ORIGEM "
cQuery += CRLF +"               from " + RetSqlName('BM1') + " BM1 "  
cQuery += CRLF +"              where bm1_filial = ' ' and d_E_L_E_T_ = ' ' "
cQuery += CRLF +"            and bm1_codemp = '"+ MV_PAR01+"'" 
cQuery += CRLF +"            and bm1_ano = '"+ MV_PAR03+"' and bm1_mes = '"+ MV_PAR02+"'"
cQuery += CRLF +"            and bm1_codtip = '901') BM1B "
cQuery += CRLF +"      WHERE BM1B.MATRIC = BXQA.MATRIC(+) and bxq_refere = bxq_pagcom "

cQuery += CRLF +"        AND substr(BM1B.MATRIC,1,4)  = bXQ_codint "
cQuery += CRLF +"        AND substr(BM1B.MATRIC,5,4)  = bXQ_codemp "
cQuery += CRLF +"        AND substr(BM1B.MATRIC,9,6)  = bXQ_matric "
cQuery += CRLF +"        AND substr(BM1B.MATRIC,15,2) = bXQ_tipreg "

cQuery += CRLF +"        AND (((datblo = ' ' or datblo > BXQA.COMPTE_MAX)" 
cQuery += CRLF +"        AND bXQ_ano || bXQ_mes  = BXQA.COMPTE_MAX )"
cQuery += CRLF +"         or  (datblo <> ' '  "
cQuery += CRLF +"        AND bXQ_ano || bXQ_mes = BXQA.COMPTE_MAX ))"
//cQuery += CRLF +"        AND bXQ_ano || bXQ_mes <= BXQA.COMPTE_MAX "
//cQuery += CRLF +"        AND bXQ_ano || bXQ_mes >= BXQA.COMPTE_MIN )) "

cQuery += CRLF +"        and bxq_filial = ' ' and BXQ.d_E_L_E_T_ = ' ' "
cQuery += CRLF +"        and bxq_codVen <> '000215' "
cQuery += CRLF +"        and trim(bxq_numpar) not in('999','777')"
cQuery += CRLF +"      order by bxq_codven , BXQ_CODEMP , BXQ_MATRIC , BXQ_TIPREG , BXQ_NUMPAR "   

 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea())  
 Endif
    TCQuery cQuery Alias "TMP" New 
    dbSelectArea("TMP")
    tmp->(dbGoTop())                                         
  
   While !TMP->(EOF())                                               

   if mv_par04 == 1 
      If tmp->datblo == dtos(Lastday(Ctod(substr(tmp->datblo,7,2)+'/'+substr(tmp->datblo,5,2)+'/'+substr(tmp->datblo,1,4)))) //.or. substr(tmp->datblo,7,2) == '01'
         If substr(tmp->datblo,1,4)+substr(tmp->datblo,5,2) >=  tmp->bxq_ano+tmp->bxq_mes
            tmp->(dbSkip())
            Loop
         EndIf   
      EndIf                      
   EndIf 

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
	 @ nLin,000 PSay  tmp->bxq_codven //+ ' - ' + tmp->A3_NOME
	 @ nLin,015 PSay  tmp->bxq_codemp //+ ' - ' + substr (tmp->bg9_descri,1,25)
	 @ nLin,025 PSay  tmp->bxq_matric +'-'+ tmp->bxq_TIPREG +'.'+ tmp->bxq_DIGITO  +'-'+ SUBSTR (TMP->NOMUSR,1,40)
    
    @ nLin,095 PSay  tmp->bxq_numpar

    @ nLin,100 PSay  substr(tmp->datblo,7,2)+'/'+ substr(tmp->datblo,5,2)+'/'+ substr(tmp->datblo,1,4) 
	 @ nLin,118 PSay  (tmp->bxq_bascom*-1)   Picture "@E -999,999,999.99"
	 @ nLin,140 PSAY  tmp->bxq_percom //  Picture "@E %99.99"  
	 @ nLin,144 PSAY  (tmp->bxq_vlrcom*-1)  Picture "@E -999,999,999.99"    
	 nMACob := tmp->bxq_mes +"/"+tmp->bxq_ano                                                          
     @ nLin,165 PSAY  nMACob                                                         
     nMADev := MV_par02+"/"+MV_par03                                                          
     @ nLin,180 PSAY  nMADev
     @ nLin,200 PSAY  tmp->valor_901  Picture "@E 999,999,999.99"   
     if tmp->bxq_bascom > tmp->valor_901
        @ nLin,218 PSAY  "*"           
     elseif tmp->bxq_bascom < tmp->valor_901                   
        @ nLin,218 PSAY  "$"   
     EndIf 
	 vlr_TotCom      += (tmp->bxq_vlrcom * -1)
	 vlr_TotBas      += (tmp->bxq_bascom * -1)
    vlr_Tot901      += (tmp->valor_901)
    nCont++           
     
	 nLin ++

   if tmp->bxq_bascom <> tmp->valor_901

      cQuery1 := CRLF +"select decode(bfq_comiss,'1','Comissiona','Nao Comissiona') tp , bm1_ano ||'/'|| bm1_mes compte, bm1_codtip ||'-'|| bm1_destip destip, bm1_valor valor , bm1_tipo tipo" 
      cQuery1 += CRLF +"  from " + RetSqlName('BM1') + " BM1 ," + RetSqlName('BFQ') + " BFQ " 
      cQuery1 += CRLF +" where bm1_filial =' ' and bm1.d_E_L_E_T_ =' ' "
      cQuery1 += CRLF +"   and bfq_filial =' ' and bfq.d_E_L_E_T_ =' ' "

      cQuery1 += CRLF +"   and ((('" + tmp->datblo +"' = ' ' or '" + substr(tmp->datblo,1,6) +"' > '"+ MV_PAR03+MV_PAR02+"') "
      cQuery1 += CRLF +"   and bm1_ano || bm1_mes     = '"+ MV_PAR03+MV_PAR02+"')"
   
      cQuery1 += CRLF +"         or  ('"+datblo+"' <> ' ' "
      cQuery1 += CRLF +"        AND bm1_ano || bm1_mes <= '"+ MV_PAR03+MV_PAR02 +"'"
      cQuery1 += CRLF +"        AND bm1_ano || bm1_mes >= '"+tmp->COMPTE_MIN +"'))" 

      cQuery1 += CRLF +"   AND BM1_codint  = '0001'" 
      cQuery1 += CRLF +"   AND BM1_codemp  = '"+tmp->bxq_codemp+"'" 
      cQuery1 += CRLF +"   AND BM1_MATRIC  = '"+tmp->bxq_matric+"'" 
      cQuery1 += CRLF +"   AND BM1_tipreg  = '"+tmp->bxq_TIPREG+"'"
      cQuery1 += CRLF +"   and bm1_codtip  not in  ('901') "
      cQuery1 += CRLF +"   and bfq_propri || bfq_codlan = BM1.BM1_CODTIP
      
      If Select(("TMP1")) <> 0 
         ("TMP1")->(DbCloseArea())  
      Endif
         
      TCQuery cQuery1 Alias "TMP1" New 
      dbSelectArea("TMP1")
      tmp1->(dbGoTop())                                         
  
      While !TMP1->(EOF())          

      if mv_par04 == 1
         If tmp->datblo == dtos(Lastday(Ctod(substr(tmp->datblo,7,2)+'/'+substr(tmp->datblo,5,2)+'/'+substr(tmp->datblo,1,4)))) //.or. substr(tmp->datblo,7,2) == '01'
            If substr(tmp->datblo,1,4)+'/'+substr(tmp->datblo,5,2) >=  trim(tmp1->compte)
               tmp1->(dbSkip())
               Loop
            EndIf   
         EndIf                                                       
      EndIf 
      
         @ nLin,015 PSay  '--------->'
	      @ nLin,030 PSay  tmp1->tp
         @ nLin,050 PSay  tmp1->compte
         @ nLin,060 PSay  substr(tmp1->destip,1,40)
         
         If tmp1->tipo == '1'
	         @ nLin,105 PSay  tmp1->valor   Picture "@E 999,999,999.99"
         Else
            @ nLin,105 PSay  (tmp1->valor*-1)   Picture "@E -999,999,999.99"
         EndIf
         
         fGrvDiv(tmp1->tp , tmp1->compte , substr(tmp1->destip,1,40) , tmp1->tipo , tmp1->valor)
         
         nLin ++

         tmp1->(dbSkip())   
      EndDo
      
   EndIf 

	tmp->(dbSkip())    // Avanca o ponteiro do registro no arquivo

EndDo    
    @ nLin,000 PSay replicate("_",220)  
    nLin ++ 
    @ nLin,100 PSay  ncont         Picture "@E 999,999"                                                                 
  	 @ nLin,117 PSay  Vlr_TotBas    Picture "@E -999,999,999.99"
	 @ nLin,143 PSAY  Vlr_TotCom    Picture "@E -999,999,999.99"    
    @ nLin,200 PSAY  Vlr_Tot901    Picture "@E 999,999,999.99"    
	 if mv_par04 = 1    
        nLin ++                                             
        @ nLin,001 PSAY  'Debito Aplicado a comissão do Vendedor'
    EndIF   
    
    nLin ++
    @ nLin,000 PSay replicate("_",220)                     

//////// diferença de matriculas , nao existe na comissao 

cQuery2 := CRLF +"select bm1_codint || bm1_codemp || bm1_matric || bm1_tipreg MATRIC , "
cQuery2 += CRLF +"      (bm1_ano||bm1_mes) COMPTE , BM1_CODTIP ||'-'||BM1_DESTIP DESTIP , "  
cQuery2 += CRLF +"       BM1_VALOR VALOR_901 , BM1_ORIGEM ORIGEM "
cQuery2 += CRLF +"  from " + RetSqlName('BM1') + " BM1 "  
cQuery2 += CRLF +" where bm1_filial = ' ' and d_E_L_E_T_ = ' ' "
cQuery2 += CRLF +"   and bm1_codemp = '"+ MV_PAR01+"'" 
cQuery2 += CRLF +"   and bm1_ano = '"+ MV_PAR03+"' and bm1_mes = '"+ MV_PAR02+"'"
cQuery2 += CRLF +"   and bm1_codtip = '901' ORDER BY 1 "       
  
  If Select(("TMP2")) <> 0 
         ("TMP2")->(DbCloseArea())  
      Endif
         
      TCQuery cQuery2 Alias "TMP2" New 
      dbSelectArea("TMP2")
      tmp2->(dbGoTop())                                         
      tmp->(dbGoTop())
      nLin := 99
      While !TMP2->(EOF())         
  
         If tmp->bxq_codven <> cCodVen
            If empty(cCodVen)
               cCodVen:= tmp->bxq_codven
            Else     
               cCodVen:= tmp->bxq_codven
            //   tmp2->(dbGoTop())
            EndIf    
         EndIf     

         If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
   	      nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	         nLin ++
	      Endif

         If tmp2->MATRIC <  tmp->MATRIC
            @ nLin,000 PSay  'Debito Sem Comissão '
	         @ nLin,022 PSay  tmp2->Matric 
	         @ nLin,040 PSay  tmp2->COMPTE
            @ nLin,050 PSay  substr(tmp2->DESTIP,1,30)
    
	         @ nLin,083 PSay  (tmp2->VALOR_901)   Picture "@E 999,999,999.99"
	         @ nLin,100 PSAY   tmp2->ORIGEM

            @ nLin,110 PSAY   cCodVen

	         tmp2->(dbSkip()) 
     
         ElseIf tmp2->MATRIC >  tmp->MATRIC 
            If Empty(tmp->MATRIC)
                tmp2->(dbSkip())
            EndIf    
            
            tmp->(dbSkip()) 

         ElseIf tmp2->MATRIC ==  tmp->MATRIC 
            
            tmp->(dbSkip()) 
            tmp2->(dbSkip())

         EndIf    

      EndDo      

   If  !_cIdUsuar $ cAprov

       MsgAlert("Você Não esta autorizado a fazer lançamentos na Comissão!!! ","Atencao!")

   EndIf
   
   IF Mv_Par04 == 1  .and. _cIdUsuar $ cAprov  

      If msgyesno("confirma Lançamento na Comissão")

         tmp->(dbGoTop())                                                         
         While !TMP->(EOF())         
/*         
            If tmp->datblo == dtos(Lastday(Ctod(substr(tmp->datblo,7,2)+'/'+substr(tmp->datblo,5,2)+'/'+substr(tmp->datblo,1,4)))) //•.or. substr(tmp->datblo,7,2) == '01'
               If substr(tmp->datblo,1,4)+substr(tmp->datblo,5,2) >=  tmp->bxq_ano+tmp->bxq_mes
                  tmp->(dbSkip())
                  Loop
               EndIf   
            EndIf                     
*/
            reclock("BXQ",.T.)                                                       
            cseq:=nextcodtab('BXQ', 'BXQ_SEQ',.T.)
            BXQ->BXQ_FILIAL := TMP->BXQ_FILIAL  
            BXQ->BXQ_ANO    := mv_par03  
            BXQ->BXQ_MES    := mv_par02    
            BXQ->BXQ_CODVEN := TMP->BXQ_CODVEN 
            BXQ->BXQ_CODEQU := TMP->BXQ_CODEQU 
            BXQ->BXQ_PREFIX := TMP->BXQ_PREFIX     
            BXQ->BXQ_NUM    := TMP->BXQ_NUM        
            BXQ->BXQ_PARC   := TMP->BXQ_PARC       
            BXQ->BXQ_TIPO   := TMP->BXQ_TIPO       
            BXQ->BXQ_CODINT := TMP->BXQ_CODINT 
            BXQ->BXQ_CODEMP := TMP->BXQ_CODEMP 
            BXQ->BXQ_MATRIC := TMP->BXQ_MATRIC 
            BXQ->BXQ_TIPREG := TMP->BXQ_TIPREG 
            BXQ->BXQ_DIGITO := TMP->BXQ_DIGITO 
            BXQ->BXQ_NUMCON := TMP->BXQ_NUMCON 
            BXQ->BXQ_VERCON := TMP->BXQ_VERCON 
            BXQ->BXQ_SUBCON := TMP->BXQ_SUBCON 
            BXQ->BXQ_VERSUB := TMP->BXQ_VERSUB 
            BXQ->BXQ_DATA   := stod(TMP->BXQ_DATA)   
            BXQ->BXQ_SEQBXO := TMP->BXQ_SEQBXO 
            BXQ->BXQ_SEQ    := cseq    
            BXQ->BXQ_NUMPAR := "999" //TMP->BXQ_NUMPAR 
            BXQ->BXQ_BASCOM := (TMP->BXQ_BASCOM * -1)
            BXQ->BXQ_PERCOM := (TMP->BXQ_PERCOM * -1)
            BXQ->BXQ_VLRCOM := (TMP->BXQ_VLRCOM * -1)
            BXQ->BXQ_REFERE := TMP->BXQ_REFERE 
            BXQ->BXQ_PAGCOM := TMP->BXQ_PAGCOM 
            BXQ->BXQ_PAGPER := TMP->BXQ_PAGPER 
            BXQ->(MsUnlock())		
           tmp->(dbSkip())   // Avanca o ponteiro do registro no arquivo
         EndDo    
      
      EndIf

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

static Function fGrvDiv( tmp1_tp , tmp1_compte , tmp1_destip , tmp1_tipo , tmp1_valor)
//local Valor_edd:= IIf (tmp1->tp == '1',(tmp1->valor)   Picture "@E 999,999,999.99" , (tmp1->valor*-1)   Picture "@E -999,999,999.99")
         
      If (nAscan:=Ascan(aDetDiv , {|e| e[1]+e[2]+e[3]+e[4] ==  trim(tmp1_tp)                  + ;
                                                               trim(tmp1_compte)              + ;
                                                               trim(substr(tmp1_destip,1,40)) + ; 
                                                               Trim(tmp1_tipo) })) == 0
         
                     aAdd(aDetDiv,{Trim(tmp1_tp)            ,;
                                   Trim(tmp1_compte)        ,;
                                   Trim(substr(tmp1_destip,1,40)) ,;
                                   Trim(tmp1_tipo)          ,;
                                   tmp1_valor })

      Else 
                  aDetDiv[nAscan,5]+= tmp1->valor
      EndIf 
A:='a'         
Return()

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
