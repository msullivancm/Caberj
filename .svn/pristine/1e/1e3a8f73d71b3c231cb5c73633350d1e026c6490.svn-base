#Define CRLF Chr(13)+Chr(10)
#INCLUDE "rwmake.ch"
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR224  บ Autor ณ Altamiro Affonso   บ Data ณ  10/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Aprova็ใo de pagamento Primavida              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR224( cano , cmes )  

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de Aprova็ใo de pagamento da Primavida             "
Local cDesc3         := "                                                   "
Local cPict          := ""
Local titulo         := "        Repasse Primavida      "

Local Cabec1         := "  " //Codigo     Descri็ใo                                            Saldo"
//                       12345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6          7
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := " "
Local imprime        := .T.
Local aOrd           := {}
Private nLin         := 220  
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 100
Private tamanho      := "P"
Private nomeprog     := "CABR224"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR224"
Private cString      := "BM1"
Private cPerg        := "CABR224   "
Private valor_tot    := 0.00  
Private valor_col    := 0.00                                                                      
Private cquebra      := " "        
Private cttitpgto    :=' '   
private cqtdavend    := 0 
private ctraco80     := replicate("_",080)  
Private lflagtot     :=.F.
/*Private cAliastmp    := GetNextAlias()
Private cAliastmp1 	 := GetNextAlias()
Private cAliastmp2 	 := GetNextAlias()      
Private cAliastmp3 	 := GetNextAlias()
Private cAliastmp4 	 := GetNextAlias()    
Private cAliastmp5 	 := GetNextAlias()
Private cAliastmp6 	 := GetNextAlias() 
Private cAliastmp7 	 := GetNextAlias()
Private cAliastmp8 	 := GetNextAlias()
*/
Private cQuery        := " "   

/*
ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif                                     
*/
Private cAnoMes      := cano + cmes    //substr(mv_par01,4,4)+substr(mv_par01,1,2)      
Private cMesAno1     := cmes +'/'+cano //substr(mv_par01,1,2)+'/'+substr(mv_par01,4,4) 
Private cMes1        := cmes           //substr(mv_par01,1,2)+'/'+substr(mv_par01,4,4)
Private cAno1        := cano //substr(mv_par01,1,2)+'/'+substr(mv_par01,4,4)
//private nopco        := opco
/* 
Private cEmpInc      := mv_par02 
Private cEmpFim      := mv_par03
Private cVendInc     := mv_par04   
Private cVendFim     := mv_par05                                     

cmes:= val(substr(mv_par01,1,2))
cano:= val(substr(mv_par01,4,4))
Private cAnoMesa      := str(iif(cmes==01,cano-1, cano),4)+strzero(iif(cmes==01,12,(cmes-1)),2) */

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

local nqtdaf      := 0	  		  
local nVlr_Caberj := 0.00        
local nqtdaPp     := 0   		         
local nVlr_Calc   := 0.00       
		      
local nqtdaTpi    := 0 		               
local nVlrtiTpi   := 0.00       
		      
local nqtdaDpi    := 0       
local nVlrtiDpi   := 0.00      

local nqtdaTpp    := 0      
local nVlrtiTpp   := 0.00       
		      
local nqtdaDpp    := 0
local nVlrtiDpp   := 0.00       
		      
local nqtdaTpn    := 0       
local nVlrtiTpn   := 0.00
		      
local nqtdaDpn    := 0       
local nVlrtiDpn   := 0.00          

local nqtdaE      := 0       
local nVlrE       := 0.00  

local nqtdaM      := 0       
local nVlrM       := 0.00  

local nVlraR      := 0.00        

local NqtdaTotPE  := 0        
local NvlRecTPE   := 0.00

local NqtdaTotPM  := 0 
local NvlRecTPM   := 0.00

dbSelectArea(cString)
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())                    

// --resumo Pgto    

If 	cAnoMes <='201607'
    cQuery :=       " SELECT  "
	cQuery += CRLF +"       CASE   WHEN (   trim(BM1_CODEVE)  = '0103' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"              WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 20.12 ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"              WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Parc. ' "
	cQuery += CRLF +"              WHEN (   trim(BM1_CODEVE)  = '0103' AND  BM1_YVLPRI = 0.00  ) THEN ' Nใo Pagto ' "
	cQuery += CRLF +"              WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 0.00  ) THEN ' Nใo Pagto ' "
	cQuery += CRLF +"              ELSE 'Nao Classificado ' END statu ,  "
	cQuery += CRLF +"       DECODE(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') T_USUA , "
	cQuery += CRLF +"       COUNT(BM1_VALOR) Qtda ,     "
	cQuery += CRLF +"       SUM(BM1_VALOR) Vlr_base ,   "   
	cQuery += CRLF +"       SUM(bm1_yvlprI) Vlr_Calc  , "    
	cQuery += CRLF +"       SUM(DECODE(trim(BM1_CODEVE) ,'0103',7.14,'0105',20.12,0.00) - ( bm1_yvlprI+bm1_yvlpr1)) saldo_pgto  ,  bm1_yvlprI vlrpri ,  "

	cQuery += CRLF +"       SUM(CASE   WHEN (trim(BM1_CODEVE) = '0103' AND ba1.BA1_TIPUSU = 'T' AND  BM1_YVLPRI = 0     ) THEN bm1_valor 
	cQuery += CRLF +"                  WHEN (trim(BM1_CODEVE) = '0103' AND ba1.BA1_TIPUSU = 'T' AND  BM1_YVLPRI = 7.14  ) THEN 0
	cQuery += CRLF +"                  WHEN (trim(BM1_CODEVE) = '0105' AND ba1.BA1_TIPUSU = 'T' AND  BM1_YVLPRI > 7.14  ) THEN 0 
	cQuery += CRLF +"                  WHEN (trim(BM1_CODEVE) = '0105' AND ba1.BA1_TIPUSU = 'T' AND  BM1_YVLPRI = 7.14  ) THEN (bm1_valor - 7.56)
	cQuery += CRLF +"                  WHEN (trim(BM1_CODEVE) = '0105' AND ba1.BA1_TIPUSU = 'T' AND  BM1_YVLPRI = 0     ) THEN (bm1_valor )

	cQuery += CRLF +"                  WHEN (trim(BM1_CODEVE) = '0103' AND ba1.BA1_TIPUSU = 'D' AND  BM1_YVLPRI = 0     ) THEN bm1_valor 
	cQuery += CRLF +"                  WHEN (trim(BM1_CODEVE) = '0103' AND ba1.BA1_TIPUSU = 'D' AND  BM1_YVLPRI = 7.14  ) THEN 0
	cQuery += CRLF +"                  WHEN (trim(BM1_CODEVE) = '0105' AND ba1.BA1_TIPUSU = 'D' AND  BM1_YVLPRI = 20.12 ) THEN 0 
	cQuery += CRLF +"                  WHEN (trim(BM1_CODEVE) = '0105' AND ba1.BA1_TIPUSU = 'D' AND  BM1_YVLPRI = 0     ) THEN (bm1_valor )              
	cQuery += CRLF +"                  ELSE bm1_valor END )saldo_RECEBER 

	cQuery += CRLF +"  FROM  " + RetSqlName("BM1") + " BM1  ," + RetSqlName("BA1") + " BA1 "
	cQuery += CRLF +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"'"   
	cQuery += CRLF +"   AND BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  "  

	cQuery += CRLF +"   AND BM1_MES    = '"+cMes1 +"' "
	cQuery += CRLF +"   AND BM1_ANO    = '"+cAno1 +"' " 
   
	cQuery += CRLF +"   AND BM1_CODEMP in ( '0024' , '0025','0027','0028')   "     
	cQuery += CRLF +"   AND BM1_CODTIP = '102' and BM1_CODEVE IN  ('0103','0105')  "
	cQuery += CRLF +"   AND BM1_CODINT = ba1.BA1_CODINT  "
	cQuery += CRLF +"   AND BM1_CODEMP = ba1.BA1_CODEMP  "
	cQuery += CRLF +"   AND BM1_MATRIC = ba1.BA1_MATRIC  "
	cQuery += CRLF +"   AND BM1_TIPREG = ba1.BA1_TIPREG  "
	cQuery += CRLF +"   AND BM1_DIGITO = ba1.BA1_DIGITO  "           
 
	cQuery += CRLF +"   AND (( bm1_yvlprI = 0 and bm1.d_E_L_E_T_ = ' ') or  ( bm1_yvlprI <> 0 )) "             

	cQuery += CRLF +"   GROUP BY " 
	cQuery += CRLF +"         CASE WHEN (   trim(BM1_CODEVE)  = '0103' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"              WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 20.12 ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"              WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 7.14  ) THEN ' Pagto Parc. ' "
	cQuery += CRLF +"              WHEN (   trim(BM1_CODEVE)  = '0103' AND  BM1_YVLPRI = 0.00  ) THEN ' Nใo Pagto '   "
	cQuery += CRLF +"              WHEN (   trim(BM1_CODEVE)  = '0105' AND  BM1_YVLPRI = 0.00  ) THEN ' Nใo Pagto '   "
	cQuery += CRLF +"              ELSE 'Nao Classificado ' END , "
	cQuery += CRLF +"         DECODE(ba1.BA1_TIPUSU,'T', 'Titular','Dependente')  ,  bm1_yvlprI  "

Else   

	cQuery :=       " SELECT " 
	cQuery += CRLF +"   CASE WHEN ( BM1_YVLPRI =  round(( VALOR_PARTE_DENTAL * 0.75 ),2) ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"             WHEN ( BM1_YVLPRI <> round(( VALOR_PARTE_DENTAL * 0.75 ),2) AND BM1_YVLPRI <> 0.00  ) THEN ' Pagto Parc. ' " 
	cQuery += CRLF +"             WHEN ( BM1_YVLPRI = 0.00  ) THEN ' Nใo Pagto ' "
	cQuery += CRLF +"        ELSE 'Nao Classificado ' END statu ,  "
	cQuery += CRLF +" DECODE(BA1.BA1_TIPUSU,'T', 'Titular','Dependente') T_USUA , "
	cQuery += CRLF +" COUNT(*) QTDA , "    
	cQuery += CRLF +" SUM(VALOR_PARTE_DENTAL) VLR_BASE , "     
	cQuery += CRLF +" SUM(BM1_YVLPRI) VLR_CALC ,  "                                
//	cQuery += CRLF +" round((VALOR_PARTE_DENTAL* 0.75),2) VLRPRI  , "  28/10/2016 altamiro     
    
	cQuery += CRLF +" VALOR_PARTE_DENTAL VLR_BASE1 , "  
	
	cQuery += CRLF +" BM1_YVLPRI  VLRPRI  ,  "       
	
	cQuery += CRLF +" NOME_PLANO  NOM_PLAN , "     
	 
	cQuery += CRLF +" SUM(CASE WHEN ( BM1_YVLPRI = 0  ) THEN VALOR_PARTE_DENTAL "
	cQuery += CRLF +"          WHEN ( BM1_YVLPRI = round(( VALOR_PARTE_DENTAL * 0.75 ),2) ) THEN 0 " 
	
	cQuery += CRLF +"          WHEN ( BM1_YVLPRI <> round(( VALOR_PARTE_DENTAL * 0.75 ),2) and BM1_YVLPRI <> 0 ) THEN (VALOR_PARTE_DENTAL - 7.56) "
	cQuery += CRLF +"     ELSE VALOR_PARTE_DENTAL END ) SALDO_RECEBER , "         
	
	cQuery += CRLF +"      SUM( round(( VALOR_PARTE_DENTAL * 0.75 ),2) - ( BM1_YVLPRI+BM1_YVLPR1)) SALDO_PGTO  " 
	                         
	cQuery += CRLF +"  FROM  " + RetSqlName("BM1") + " BM1  ," + RetSqlName("BA1") + " BA1 , SIGA.VALOR_PARTE_ODONTO_PREFEITURA  "
	cQuery += CRLF +" WHERE BM1_FILIAL = '" + xFilial("BM1") +"'"   
	cQuery += CRLF +"   AND BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  "  
	cQuery += CRLF +"   AND BM1_MES    = '"+cMes1 +"' "
	cQuery += CRLF +"   AND BM1_ANO    = '"+cAno1 +"' "  
	cQuery += CRLF +"   AND BM1_CODEMP IN ( '0024' , '0025','0027','0028') "       
	cQuery += CRLF +"   AND BM1_CODTIP = '101' "
	cQuery += CRLF +"   AND BM1_CODINT = BA1.BA1_CODINT "
	cQuery += CRLF +"   AND BM1_CODEMP = BA1.BA1_CODEMP " 
	cQuery += CRLF +"   AND BM1_MATRIC = BA1.BA1_MATRIC " 
	cQuery += CRLF +"   AND BM1_TIPREG = BA1.BA1_TIPREG " 
	cQuery += CRLF +"   AND BM1_DIGITO = BA1.BA1_DIGITO "            
	cQuery += CRLF +"   AND BM1_CODPLA = COD_PLANO "
	cQuery += CRLF +"   AND (( BM1_YVLPRI = 0 AND BM1.D_E_L_E_T_ = ' ') OR  ( BM1_YVLPRI <> 0 )) "
	cQuery += CRLF +" GROUP BY CASE WHEN ( BM1_YVLPRI =  round(( VALOR_PARTE_DENTAL * 0.75 ),2) ) THEN ' Pagto Integ ' "
	cQuery += CRLF +"               WHEN ( BM1_YVLPRI <> round(( VALOR_PARTE_DENTAL * 0.75 ),2) AND BM1_YVLPRI <> 0.00  ) THEN ' Pagto Parc. ' " 
	cQuery += CRLF +"               WHEN ( BM1_YVLPRI = 0.00  ) THEN ' Nใo Pagto ' "
	cQuery += CRLF +"          ELSE 'Nao Classificado ' END ,  "
	cQuery += CRLF +"       DECODE(BA1.BA1_TIPUSU,'T', 'Titular','Dependente')  , BM1_YVLPRI   , NOME_PLANO , VALOR_PARTE_DENTAL"

EndIf

If Select(("TMP")) <> 0 
          ("TMP")->(DbCloseArea()) 
Endif
    
TCQuery cQuery Alias "TMP" New 
                                                                                           
dbSelectArea("TMP")
   
    tmp->(dbGoTop())                    
   
    While !(TMP->(Eof()))                                                                                                                                                                                                   

		  nqtdaf      += tmp->Qtda	  		  
  		  nVlr_Caberj += tmp->Vlr_base        
		  nVlr_Calc   += tmp->Vlr_Calc          
   	      nVlraR      += tmp->saldo_receber        
   	      
   	      If  tmp->VLR_BASE1 == 7.56 .OR. tmp->VLR_BASE1 == 11.43
   	                     
   	          NqtdaTotPE  += tmp->Qtda       
              NvlRecTPE += tmp->VLR_BASE  

          ElseIf  tmp->VLR_BASE1 == 30.36 .OR. tmp->VLR_BASE1 == 34.23

              NqtdaTotPM  += tmp->Qtda
              NvlRecTPM += tmp->VLR_BASE 
   	      
   	      EndIf 
		  
		  If  tmp->vlrpri  == 5.67 .or. tmp->vlrpri  == 8.57             
		  
              nqtdaE      += tmp->Qtda       
              nVlrE       += tmp->Vlr_Calc  		  
		  
		  Elseif  tmp->vlrpri  == 22.77 .or. tmp->vlrpri  == 25.67        
          
              nqtdaM      += tmp->Qtda       
              nVlrM       += tmp->Vlr_Calc  		  
		  
		  Endif 
		   
		  If     alltrim(tmp->statu) == 'Pagto Integ'  
		  
		      If alltrim(tmp->T_USUA) == 'Titular'     
		      
		         nqtdaTpi  += tmp->Qtda 
		  	     nqtdaPp   += tmp->Qtda		               
		         nVlrtiTpi += tmp->Vlr_Calc       
		      
		      ElseIf  alltrim(tmp->T_USUA) == 'Dependente'
		      
   		         nqtdaDpi  += tmp->Qtda       
		  	     nqtdaPp   += tmp->Qtda   		         
		         nVlrtiDpi += tmp->Vlr_Calc       

		      EndIF 
		  
		  ElseIf alltrim(tmp->statu) == 'Pagto Parc.'         
		  
		  	  If alltrim(tmp->T_USUA) == 'Titular'         
		  	  
		  	     nqtdaTpp  += tmp->Qtda   
		  	     nqtdaPp   += tmp->Qtda
		         nVlrtiTpp += tmp->saldo_pgto  
		      
		      ElseIf  alltrim(tmp->T_USUA) == 'Dependente' 
		      
    		     nqtdaDpp  += tmp->Qtda
   		  	     nqtdaPp   += tmp->Qtda       
		         nVlrtiDpp += tmp->Vlr_Calc    
		         nVlrtiDpn += tmp->saldo_pgto   
		         
		      EndIF 
		      
		  ElseIf alltrim(tmp->statu) == 'Nใo Pagto'
		  
		  	  If alltrim(tmp->T_USUA) == 'Titular'         
		  	  
  		  	     nqtdaTpn  += tmp->Qtda       
		         nVlrtiTpn += tmp->saldo_pgto        
		      
		      ElseIf  alltrim(tmp->T_USUA) == 'Dependente'

    		     nqtdaDpn  += tmp->Qtda       
		         nVlrtiDpn += tmp->saldo_pgto        
		         		      
		      EndIF 		  
		  
		  EndIf 
		  
///////  Fim monta vetor 		  

         tmp->(DbSkip())
   EndDo


	If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	   nLin ++
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica o cancelamento pelo usuario...                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
	 //	Exit                                                      
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do cabecalho do relatorio. . .                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
	//identificacao da empresa (contratante)                                   
//If nopco == 1 	
    @ nLin,001 PSAY "                        H I S T O R I C O    D E    P A G A M E N T O  "            
      nlin++   
    @ nLin,001 PSAY ctraco80
      nlin++  
    @ nLin,001 PSAY "Referente ao pagamento do repasse a PRIMAVIDA da compet๊ncia : " +  cMesAno1                
	  nlin++            
    @ nLin,001 PSAY ctraco80
      nlin++    
      nlin++
    @ nLin,001 PSAY "  Quantidade de Vidas Faturadas Odontol๓gicas   ->>       " + Transform(nqtdaf,"@R 999,999")          
  	  nlin++             
  	  nlin++
    @ nLin,001 PSAY "  Valor Faturadas Odontol๓gico                  ->> " +Transform(nVlr_Caberj,"@E 99,999,999.99")            
  	  nlin++               
      nlin++ 
      
    @ nLin,001 PSAY "  Saldo a Receber Odontol๓gico                  ->> " +Transform(nVlraR ,"@E 99,999,999.99")            
  	  nlin++               
      nlin++
            
    @ nLin,001 PSAY "  Quantidade de Vidas Repassadas para PrimaVida ->>       " +Transform(nqtdaPp,"@R 999,999")            
  	  nlin++             
  	  nlin++
  	    	  
    @ nLin,001 PSAY "  Valor do Repasse Odontol๓gico PrimaVida       ->> " +Transform(nVlr_Calc,"@E 99,999,999.99")         
  	  nlin++ 	  
    @ nLin,001 PSAY ctraco80
      nlin++        
  	  nlin++ 
	  nlin++ 	            
                                                       
    @ nLin,001 PSAY "Informa็๕es Complementares :       
      nlin++ 
      nlin++	                
    @ nLin,001 PSAY " Quant. de Vidas nใo repassadas             -->>           " +Transform(nqtdaDpn,"@R 999,999")            
  	  nlin++   
    @ nLin,001 PSAY "   -- dependente por inadimpl๊ncia  "             
  	  nlin++ 
  	  nlin++  	    	                
    @ nLin,001 PSAY " Valores  nใo repassadas                    -->>     " +Transform(nVlrtiDpn,"@E 99,999,999.99")                  
  	  nlin++                                                                                                                                                  
    @ nLin,001 PSAY "   -- dependente por inadimpl๊ncia  "
  	  nlin++                                                                                                                                                  
  	  nlin++                   	    	  
    @ nLin,001 PSAY " Quant. de Vidas repassadas parcialmente    -->>           " +Transform(nqtdaTpp ,"@R 999,999")           
  	  nlin++                  
    @ nLin,001 PSAY "   -- Titulares com baixa parcial / inadimpl๊ntes "           
  	  nlin++                   
   	  nlin++                   	  
    @ nLin,001 PSAY " Saldo nใo repassadas                       -->>     " +Transform(nVlrtiTpp,"@E 99,999,999.99")         
     nlin++                     
    @ nLin,001 PSAY "   -- Titulares com baixa parcial / inadimpl๊ntes  "        
      nlin++                         
  	  nlin++                   	  
    @ nLin,001 PSAY " Quant. de Vidas nใo repassadas             -->>           " +Transform(nqtdaTpn ,"@R 999,999")       
  	  nlin++                  
    @ nLin,001 PSAY "   -- Titulares por inadimpl๊ncia (Baixa Total  Apos Cแlculo) "        
  	  nlin++                   	  
  	  nlin++                   	    	  
    @ nLin,001 PSAY " Valores  nใo repassadas                    -->>     " +Transform(nVlrtiTpn,"@E 99,999,999.99")         
  	  nlin++                      
    @ nLin,001 PSAY "   -- Titulares por inadimpl๊ncia (Baixa Total  Apos Cแlculo) "       
  	  nlin++      
  	  nlin++
    @ nLin,001 PSAY " Quant. Total de Vida no Plano Essencial    -->>           " +Transform(NqtdaTotPE,"@E 999,999")         
  	  nlin++                        	    	  
    @ nLin,001 PSAY " Valor  Total Cobrado do Plano Essencial    -->>     " +Transform(NvlRecTPE,"@E 99,999,999.99")         
  	  nlin++                      
    @ nLin,001 PSAY " Quant. Total de Vida no Plano Multi        -->>           " +Transform(NqtdaTotPM,"@E 999,999")         
  	  nlin++                        	    	  
    @ nLin,001 PSAY " Valor  Total Cobrado do Plano Multi        -->>     " +Transform(NvlRecTPM,"@E 99,999,999.99")         
  	                   	  
  	  nlin++ 
 	  nlin++ 	  
    @ nLin,001 PSAY ctraco80
 	  nlin++ 	                                       	  
    @ nLin,001 PSAY "Valor a ser repassado เ PrimaVida -->>  " +Transform(nVlr_Calc,"@E 99,999,999.99")     
  	  nlin++                     
    @ nLin,001 PSAY ctraco80 
 	  nlin++ 	                                   	  
    @ nLin,001 PSAY "Favor ter aten็ใo a dizima peri๓dica ao aplicar o percentual da PrimaVida "      
  	  nlin++                     
    @ nLin,001 PSAY ctraco80 
//ElseIf nopco == 2 
      nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)   
      nLin ++
	   
    @ nLin,001 PSAY "                A U T O R I Z A ว ร O    D E    P A G A M E N T O  "       
      nlin++   
    @ nLin,001 PSAY ctraco80
      nlin++  
    @ nLin,001 PSAY "Referente ao pagamento do repasse a PRIMAVIDA da compet๊ncia : " +  cMesAno1                
	  nlin++            
    @ nLin,001 PSAY ctraco80
      nlin++    
      nlin++
    @ nLin,001 PSAY "  Quantidade de Vidas Repassadas para PrimaVida ->>       " +Transform(nqtdaPp,"@R 999,999")            
  	  nlin++             
  	  nlin++  
    @ nLin,001 PSAY "  Valor do Repasse Odontol๓gico PrimaVida       ->> " +Transform(nVlr_Calc,"@E 99,999,999.99")         
  	  nlin++ 	  
    @ nLin,001 PSAY ctraco80
      nlin++        
  	  nlin++ 
	  nlin++ 	                                                                   
    @ nLin,001 PSAY "Informa็๕es Complementares :       
      nlin++ 
      nlin++	                
    @ nLin,001 PSAY " Quant. de Vidas Dental Essencial                 -->>           " +Transform(nqtdaE,"@R 999,999")            
  	  nlin++ 
  	  nlin++  	    
    @ nLin,001 PSAY " Valor Dental Essencial(Vl Unit R$5,67 ou R$8,57) -->>     " +Transform(nVlrE,"@E 99,999,999.99")                  
  	  nlin++                                                                                                                                                  
  	  nlin++                                                                                                                                                  
  	  nlin++                   	    	  
    @ nLin,001 PSAY " Quant. de Vidas Dental Multi                     -->>           " +Transform(nqtdaM ,"@R 999,999")           
  	  nlin++                  
  	  nlin++                   
    @ nLin,001 PSAY " Valor Dental Multi (Vl Unit(R$25,67 ou R$22,77)  -->>     " +Transform(nVlrM,"@E 99,999,999.99")         
  	  nlin++                       	  
  	  nlin++ 
 	  nlin++ 	  
    @ nLin,001 PSAY ctraco80
 	  nlin++ 	                                       	  
    @ nLin,001 PSAY "Valor a ser repassado เ PrimaVida -->>  " +Transform(nVlr_Calc,"@E 99,999,999.99")     
  	  nlin++                     
    @ nLin,001 PSAY ctraco80 
/////////////////////////////////////////////////
// Autoriza็๕es        	
      nlin++              
      nlin++  
      nlin++  
      nlin++        
    @ nLin,028 PSAY " A U T O R I Z A ว ี E S "  
	  nlin++          
      nlin++            
    @ nLin,015 PSAY "G E R E M "  
    @ nLin,035 PSAY "S U R E M "  
    @ nLin,055 PSAY "D I T E C "  
	  nlin++          
      nlin++            
      nlin++            
    @ nLin,013 PSAY "_____________"  
    @ nLin,033 PSAY "_____________"
    @ nLin,053 PSAY "_____________"  

//ElseIf nopco == 3 
      nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)   
      nLin ++

    @ nLin,001 PSAY "                      E X T R A T O    P R I M A V I D A   "             
      nlin++   
    @ nLin,001 PSAY ctraco80
      nlin++  
    @ nLin,001 PSAY "Referente ao pagamento do repasse a PRIMAVIDA da compet๊ncia : " +  cMesAno1                
	  nlin++            
    @ nLin,001 PSAY ctraco80
      nlin++    
      nlin++
    @ nLin,001 PSAY "  Quantidade de Vidas Repassadas para PrimaVida ->>       " +Transform(nqtdaPp,"@R 999,999")            
  	  nlin++             
  	  nlin++  
    @ nLin,001 PSAY "  Valor do Repasse Odontol๓gico PrimaVida       ->> " +Transform(nVlr_Calc,"@E 99,999,999.99")         
  	  nlin++ 	  
    @ nLin,001 PSAY ctraco80
      nlin++        
  	  nlin++ 
	  nlin++ 	                                                                   
    @ nLin,001 PSAY "Informa็๕es Complementares :       
      nlin++ 
      nlin++	                
    @ nLin,001 PSAY " Quant. de Vidas Dental Essencial              -->>           " +Transform(nqtdaE,"@R 999,999")            
  	  nlin++ 
  	  nlin++  	    
    @ nLin,001 PSAY " Valor Dental Essencial                        -->>     " +Transform(nVlrE,"@E 99,999,999.99")                  
  	  nlin++                                                                                                                                                  
  	  nlin++                                                                                                                                                  
  	  nlin++                   	    	  
    @ nLin,001 PSAY " Quant. de Vidas Dental Multi                  -->>           " +Transform(nqtdaM ,"@R 999,999")           
  	  nlin++                  
  	  nlin++                   
    @ nLin,001 PSAY " Valor Dental Multi                            -->>     " +Transform(nVlrM,"@E 99,999,999.99")         
  	  nlin++                       	  
  	  nlin++ 
 	  nlin++ 	  
    @ nLin,001 PSAY ctraco80
 	  nlin++ 	                                       	  
    @ nLin,001 PSAY "Valor a ser repassado เ PrimaVida -->>  " +Transform(nVlr_Calc,"@E 99,999,999.99")     
  	  nlin++                     
    @ nLin,001 PSAY ctraco80 

//EndIf     

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
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Mes/Ano Comissao?","","","mv_ch1","C",07,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
/*aAdd(aRegs,{cPerg,"02","Cod Empresa De ?","","","mv_ch2","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
  aAdd(aRegs,{cPerg,"03","Cod Empresa Ate?","","","mv_ch3","C",04,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
  aAdd(aRegs,{cPerg,"04","Vendedor De    ?","","","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" }) 
  aAdd(aRegs,{cPerg,"05","Vendedor Ate   ?","","","mv_ch5","C",06,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
//aadd(aRegs,{cPerg,"11","Bloqueados ?     ","","","mv_cha","N", 1,0,0,"C","","mv_par11","Sim","","","","","Nao","","","","","Ambos","","","","","","","","","","","","","",""      ,""})
*/
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
