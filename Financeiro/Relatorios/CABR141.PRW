#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR141  º Autor ³Altamiro               º Data ³ 20/02/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Acompanhamento de empresa X contrato X Sub-contrato        º±±
±±º          ³ analise gerencial  - informação de datas limites ou        º±±
±±º          ³ vigencia do contrato                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR141

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR141"
Private cTitulo     := "Acompanhamento de empresa X contrato X Sub-contrato - analise gerencial "

Private cAliastmp 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer Listagem Acompanhamento de empresa X contrato X Sub-contrato  " + CRLF
cMsg += "  analise gerencial  - informação de datas limites ou vigencia do contrato " + CRLF       

 

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Competencia","Matric - Nome Usuario","Tipo","Evento","Valor","Ano Ir","Ident. Tit.","Dt. Vencto","Dt. Baixa"}
private  Descric     := ' '        

/***********/  
private cM0  := ' ' 
private cM1  := ' '  
private cM2  := ' ' 
private cM3  := ' ' 
private cM4  := ' ' 
private cM5  := ' ' 
private cM6  := ' '  
private cM7  := ' ' 
private cM8  := ' ' 
private cM9  := ' ' 
private cM10 := ' ' 
private cM11 := ' ' 
   	             	
/***********/                                                                                                
 	
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cAMInc    	:= mv_par01   
cAMFim    	:= mv_par02  
cEmpresInc  := mv_par03    
cEmpresFim  := mv_par04  
cdiferen    := mv_par05
cVerifdif   := mv_par06
cDetVida    := mv_par07 
cDetTit     := mv_par08
cGeraEx     := mv_par09 

cEmpresa    := Iif(cEmpAnt == '01','C','I') 
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel
if cGeraEx == 1 
    DlgToExcel({{"ARRAY","Acompanhamento de empresa X contrato X Sub-contrato - analise gerencial",aCabec1,aDados1}})   
EndIF
fGeraRel2()    
MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Processa1()        

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
////////////////////////////////////      

cquery :=      " SELECT   bm1_codemp ||' - ' || bqc_descri  emp , bm1_conemp cont, bm1_vercon vercon, bm1_subcon subcon, bm1_versub versub, bqc_datcon dtcon, "

cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-11),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M11,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-11),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M11Q,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-11),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M11T ,"
               
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-10),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M10,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-10),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M10Q,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-10),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M10T ,"
               
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-9 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M9,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-9 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M9Q,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-9 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M9T ,"

cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-8 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M8, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-8 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M8Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-8 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M8T ,"
               
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-7 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M7, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-7 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M7Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-7 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M7T ,"
               
cquery += CRLF+" SUM(case when BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-6 ),'YYYYMM') then (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) else 0 end) M6,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-6 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M6Q,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-6 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M6T ,"
               
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-5 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M5, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-5 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M5Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-5 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M5T ,"
                
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-4 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M4, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-4 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M4Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-4 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M4T ,"
             
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-3 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M3, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-3 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M3Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-3 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M3T ,"
                            
cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-2 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M2, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-2 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M2Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-2 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M2T ,"

cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-1 ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M1, "
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-1 ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M1Q, "
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),-1 ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' ' END) M1T ,"

cquery += CRLF+" SUM(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0  ),'YYYYMM') THEN (DECODE(BM1_TIPO,'1',1,-1) * BM1_VALOR) ELSE 0 END) M0 ,"
cquery += CRLF+" COUNT(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0  ),'YYYYMM') THEN (DECODE(BM1_CODTIP,'101',1,NULL)) ELSE NULL END) M0Q ,"
cquery += CRLF+" MAX(CASE WHEN BM1_ANO||BM1_MES = TO_CHAR(ADD_MONTHS(TO_DATE('"+cAMFim +"' ,'YYYYMM'),0  ),'YYYYMM') THEN (DECODE(TRIM(BM1_NUMTIT),NULL,' ',BM1_PREFIX ||'-'||BM1_NUMTIT ||'-'||BM1_TIPTIT||'-'||(TO_CHAR(TO_DATE(trim(e1_baixa) ,'YYYYMMDD'), 'DD/MM/YY')))) ELSE ' '  END ) M0T "
 
cquery += CRLF+" FROM BM1020 BM1 , BQC020 BQC , SE1020 SE1 "                            
cquery += CRLF+" WHERE BM1_FILIAL = ' ' AND BM1.D_E_L_E_T_ = ' ' AND BQC_FILIAL = ' ' AND BQC.D_E_L_E_T_ = ' ' AND E1_FILIAL = '01' AND SE1.D_E_L_E_T_ = ' ' "
cquery += CRLF+" AND BQC_NUMCON = BM1_CONEMP AND BQC_VERCON = BM1_VERCON AND BQC_SUBCON = BM1_SUBCON AND BQC_VERSUB = BM1_VERSUB AND BQC_CODEMP = BM1_CODEMP "
cquery += CRLF+" AND BM1_PREFIX = E1_PREFIXO AND BM1_NUMTIT = E1_NUM AND E1_parcela = BM1_PARCEL and BM1_TIPTIT = e1_tipo AND BM1_CODTIP NOT IN ('108')" 

// cEmpresInc//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

cquery += CRLF+" AND BM1_CODEMP >= '"+cEmpresInc+"' AND BM1_CODEMP <= '"+cEmpresFim+"'"
cquery += CRLF+" AND BM1_ANO ||BM1_MES >= '"+cAMInc +"' and  BM1_ANO ||BM1_MES <= '"+cAMFim +"'

cquery += CRLF+" GROUP BY   BM1_CODEMP , BQC_DESCRI , BM1_CONEMP , BM1_VERCON, BM1_SUBCON , BM1_VERSUB, BQC_DATCON "
cquery += CRLF+" ORDER BY BM1_CODEMP  , BM1_CONEMP , BM1_SUBCON "
     
/////////////////////////////////////////*
	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   

      fGeraDt (cAMFim)
           
    While (cAliastmp)->(!Eof())    
       Datacon:=STOD((cAliastmp)->dtcon)            
       contarcto := substr((cAliastmp)->cont,3,12)
       
       aaDD(aDados1,{(cAliastmp)->emp        ,;  // 1
                                  contarcto  ,;  // 2
	                 ((cAliastmp)->vercon)   ,;  // 3
	                 ((cAliastmp)->subcon)   ,;  // 4
	                 ((cAliastmp)->versub)   ,;  // 5
	                              Datacon    ,;  // 6
	   	             (cAliastmp)->M0         ,;  // 7
   	             	 (cAliastmp)->M0Q        ,;  // 8
	   	             (cAliastmp)->M0T        ,;  // 9
	   	             (cAliastmp)->M1         ,;  // 10
   	             	 (cAliastmp)->M1Q        ,;  // 11
	   	             (cAliastmp)->M1T        ,;  // 12
	   	             (cAliastmp)->M2         ,;  // 13
   	             	 (cAliastmp)->M2Q        ,;  // 14
	   	             (cAliastmp)->M2T        ,;  // 15
	   	             (cAliastmp)->M3         ,;  // 16
   	             	 (cAliastmp)->M3Q        ,;  // 17
	   	             (cAliastmp)->M3T        ,;  // 18
	   	             (cAliastmp)->M4         ,;  // 19
   	             	 (cAliastmp)->M4Q        ,;  // 20
	   	             (cAliastmp)->M4T        ,;  // 21
	   	             (cAliastmp)->M5         ,;  // 22
   	             	 (cAliastmp)->M5Q        ,;  // 23
	   	             (cAliastmp)->M5T        ,;  // 24
	   	             (cAliastmp)->M6         ,;  // 25
   	             	 (cAliastmp)->M6Q        ,;  // 26
	   	             (cAliastmp)->M6T        ,;  // 27 
	   	             (cAliastmp)->M7         ,;  // 28
   	             	 (cAliastmp)->M7Q        ,;  // 29
	   	             (cAliastmp)->M7T        ,;  // 30
	   	             (cAliastmp)->M8         ,;  // 31
   	             	 (cAliastmp)->M8Q        ,;  // 32
	   	             (cAliastmp)->M8T        ,;  // 33
	   	             (cAliastmp)->M9         ,;  // 34
   	             	 (cAliastmp)->M9Q        ,;  // 35
	   	             (cAliastmp)->M9T        ,;  // 36
	   	             (cAliastmp)->M10        ,;  // 37
   	             	 (cAliastmp)->M10Q       ,;  // 38
	   	             (cAliastmp)->M10T       ,;  // 39
	   	             (cAliastmp)->M11        ,;  // 40 
   	             	 (cAliastmp)->M11Q       ,;  // 41
	   	             (cAliastmp)->M11T    })  // 42               
       (cAliastmp)->(dbSkip()) 	   
     EndDo	                   
Return    
*************************************************************************************************************
  
Static Function fGeraDt (CAnoMes) 

local nCompM:= val(substr(CAnoMes,5,2))   
local nCompA:= val(substr(CAnoMes,1,4))   
          
cM0 := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
              
if nCompM > 1
   nCompM := nCompM - 1 
   cM1    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM1    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf          
if nCompM > 1
   nCompM := nCompM - 1 
   cM2    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM2    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM3    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM3    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM4    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM4    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM5    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM5    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM6    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM6    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM7    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM7    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM8    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM8    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM9    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM9    := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf 
if nCompM > 1
   nCompM := nCompM - 1 
   cM10   := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM10   := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf  
if nCompM > 1
   nCompM := nCompM - 1 
   cM11   := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
else                   
   nCompM := 12 
   nCompA := nCompA - 1                      
   cM11   := ltrim(str(nCompM))+'/'+ltrim(str(nCompA))
EndIf          

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR141"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef2()

Local oReport 
Local oDPJ
//Local oDPJ1     
oReport	:= TReport():New("CABR141","Acompanhamento de empresa X contrato X Sub-contrato - analise gerencial",, {|oReport| ReportPrt(oReport)},"Acompanhamento de empresa X contrato X Sub-contrato - analise gerencial ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Demonstrativo de Evolução de contratos por empresa ",,aOrdem)             

//If cEmpresa  == 'C' 
   TRCell():New(oDPJ ,'EMPRES'	    		,/*TABELA*/	,'Empr' 	             ,/*Picture*/   ,04			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'DESEMP'	    		,/*TABELA*/	,'esa' 	                 ,/*Picture*/   ,16			,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'CONTR'	     		,/*TABELA*/	,'Contrato    '          ,/*Picture*/ 	,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'VERCON'	     		,/*TABELA*/	,'V.C'                   ,/*Picture*/ 	,03				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'SUBCON'		        ,/*TABELA*/	,'S.Cont.  '             ,/*Picture*/ 	,09			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'VERSUB'	      	    ,/*TABELA*/	,'V.S.C'                 ,/*Picture*/ 	,03			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'DTCON'	     		,/*TABELA*/	,'Dt.Cont.'              ,/*Picture*/   ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  

   TRCell():New(oDPJ ,'M0'	     		,/*TABELA*/	, cM0                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M01'     		,/*TABELA*/	, cM1                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M02'	     		,/*TABELA*/	, cM2                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M03'	     		,/*TABELA*/	, cM3                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M04'	     		,/*TABELA*/	, cM4                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M05'	     		,/*TABELA*/	, cM5                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M06'	     		,/*TABELA*/	, cM6                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M07'	     		,/*TABELA*/	, cM7                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M08'	     		,/*TABELA*/	, cM8                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M09'	     		,/*TABELA*/	, cM9                    ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M010'	    	,/*TABELA*/	, cM10                   ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'M011'     		,/*TABELA*/	, cM11                   ,/*Picture*/   ,14				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   

oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRES"),"Total por Empresa "	,.T.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
 TRFunction():New(oDPJ:Cell("EMPRES")    	    ,NIL,"count"		,oBreak01,,"@E 9,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
// TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
//********************************************************/ 
//oDPJ1 := TRSection():New(oReport,"Demonstrativo de Evolução de contratos por empresa ",,aOrdem)             

//If cEmpresa  == 'C' 
//   TRCell():New(oDPJ1,'COMP1'	    		,/*TABELA*/	,cM11 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
//   TRCell():New(oDPJ1,'COMP2'	    		,/*TABELA*/	,cM10 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//   TRCell():New(oDPJ1,'COMP3'	    		,/*TABELA*/	,cM9 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//   TRCell():New(oDPJ1,'COMP4'	    		,/*TABELA*/	,cM8 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//   TRCell():New(oDPJ1,'COMP5'	    		,/*TABELA*/	,cM7 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//   TRCell():New(oDPJ1,'COMP6'	    		,/*TABELA*/	,cM6 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//   TRCell():New(oDPJ1,'COMP7'	    		,/*TABELA*/	,cM5 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//   TRCell():New(oDPJ1,'COMP8'	    		,/*TABELA*/	,cM4 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//   TRCell():New(oDPJ1,'COMP9'	    		,/*TABELA*/	,cM3 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//   TRCell():New(oDPJ1,'COMP10'	    		,/*TABELA*/	,cM2 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
 //  TRCell():New(oDPJ1,'COMP11'	    		,/*TABELA*/	,cM1 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
 //  TRCell():New(oDPJ1,'COMP12'	    		,/*TABELA*/	,cM0 	         ,/*Picture*/   ,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

//EndIf 
 
//oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("IDENT"),"Total por Usuario "	,.F.)  

//lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
//lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
// TRFunction():New(oDPJ:Cell("VALOR")    	    ,NIL,"SUM"		,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
// TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrt(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados
oDPJ:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados1)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf  
  
       oDPJ:Cell('EMPRES'	 		):SetValue(SUBSTR(aDados1[i][1],1,4))     
       oDPJ:Cell('DESEMP'	 		):SetValue(SUBSTR(aDados1[i][1],5,16))
       oDPJ:Cell('CONTR'	 		):SetValue((aDados1[i][2]))    
       oDPJ:Cell('VERCON'	 		):SetValue((aDados1[i][3]))    
       oDPJ:Cell('SUBCON'  	  		):SetValue((aDados1[i][4]))       
       oDPJ:Cell('VERSUB'  	    	):SetValue((aDados1[i][5]))   
       oDPJ:Cell('DTCON'  	        ):SetValue((aDados1[i][6]))    
       oDPJ:Cell('M0'   	 		):SetValue(ltrim(Transform(aDados1[i][07],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][08],'@E 999')) )   
       oDPJ:Cell('M01'   	 		):SetValue(ltrim(Transform(aDados1[i][10],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][11],'@E 999')) ) 
       oDPJ:Cell('M02'   	 		):SetValue(ltrim(Transform(aDados1[i][13],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][14],'@E 999')) )    
       oDPJ:Cell('M03'   	 		):SetValue(ltrim(Transform(aDados1[i][16],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][17],'@E 999')) )     
       oDPJ:Cell('M04'   	 		):SetValue(ltrim(Transform(aDados1[i][19],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][20],'@E 999')) )     
       oDPJ:Cell('M05'   	 		):SetValue(ltrim(Transform(aDados1[i][22],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][23],'@E 999')) )    
       oDPJ:Cell('M06'   	 		):SetValue(ltrim(Transform(aDados1[i][25],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][26],'@E 999')) )     
       oDPJ:Cell('M07'   	 		):SetValue(ltrim(Transform(aDados1[i][28],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][29],'@E 999')) )    
       oDPJ:Cell('M08'   	 		):SetValue(ltrim(Transform(aDados1[i][31],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][32],'@E 999')) )     
       oDPJ:Cell('M09'   	 		):SetValue(ltrim(Transform(aDados1[i][34],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][35],'@E 999')) )     
       oDPJ:Cell('M010'   	 		):SetValue(ltrim(Transform(aDados1[i][37],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][38],'@E 999')) )     
       oDPJ:Cell('M011'   	 		):SetValue(ltrim(Transform(aDados1[i][40],'@E 9999999.99'))  + ' ' +  ltrim(Transform(aDados1[i][41],'@E 999')) )     
       
       oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Ano / mes Ref. Incial ") 	,"","","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Ano / mes Ref. Final  ") 	,"","","mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})

PutSx1(cPerg,"03",OemToAnsi("Cod. Empresa Incial ") 	,"","","mv_ch3","C",04,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})      
PutSx1(cPerg,"04",OemToAnsi("Cod. Empresa Final  ") 	,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","",{},{})     
PutSx1(cPerg,"05",OemToAnsi("%diferença ") 	    	    ,"","","mv_ch5","C",02,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","","",{},{})            

PutSx1(cPerg,"06",OemToAnsi("Verif. da Diferença ")     ,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Meses adjacentes","","","","entre meses","","","mes incial e final","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"07",OemToAnsi("Detalha vidas ") 	        ,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",{},{},{})  

PutSx1(cPerg,"08",OemToAnsi("Detalha Titulos ")         ,"","","mv_ch8","N",01,0,0,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","",{},{},{})  

PutSx1(cPerg,"09",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch9","N",01,0,0,"C","","","","","mv_par09","Sim","","","","Não","","","","","","","","","","","",{},{},{})  

Pergunte(cPerg,.F.)

Return

