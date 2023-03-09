#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR137   º Autor ³Altamiro              º Data ³ 27/12/13  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio para controle de Pagamento de Comissão           º±±
±±º          ³ Por Empresa e Subcontarato                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR137
Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR137"
Private cTitulo     := "Lista de Controle de Pagto de Comissao - Competencia "        

Private cAliastmp 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer listagem de de Controle de Pagto de Comissao  " + CRLF

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1    :={"TITULO" ,"CLIENTE","INSS","ISS","IR","PIS","COFINS","CSLL","LIQ","SALDO","VLRBRT","VENCTO","BAIXA"}

private Descric := ' '
private cTitVar := ' '                                                                                                          
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 
cCodEmpI    := mv_par01 
cCodEmpF    := mv_par02
cMesBase    := mv_par03
cAnoBase  	:= mv_par04  
cGeraEx	   := mv_par05   
cSoBaixa    := mv_par06

cTitulo     := "Lista de Controle de Pagto de Comissao - Competencia "+cAnoBase+"/"+cMesBase        

Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel
if cGeraEx == 1 
    DlgToExcel({{"ARRAY","Lista de Controle de Pagto de Comissao - Competencia " ,aCabec1,aDados1}})   
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
/*cquery := CRLF+" SELECT DISTINCT BXQ_E2PREF|| BXQ_E2NUM TITULO ,   BQC_CODCLI ||'-'||BQC_DESCRI CLIENTE ,  "
cquery += CRLF+"        E2_INSS INSS, E2_ISS ISS , E2_IRRF IR, E2_VRETPIS PIS, E2_VRETCOF COFINS, E2_VRETCSL CSLL, E2_VALOR LIQ, E2_SALDO SALDO, "
cquery += CRLF+"        (E2_INSS + E2_ISS + E2_IRRF + E2_VRETPIS + E2_VRETCOF + E2_VRETCSL + E2_VALOR) VLRBRT , "
cquery += CRLF+"        SUBSTR(E2_VENCREA,7,2)||'/'||SUBSTR(E2_VENCREA,5,2)||'/'|| SUBSTR(E2_VENCREA,1,4) VENC, "
cquery += CRLF+"        SUBSTR(E2_BAIXA,7,2)  ||'/'||SUBSTR(E2_BAIXA,5,2)  ||'/'|| SUBSTR(E2_BAIXA,1,4) Baixa   "
*/                         

cquery := CRLF+" SELECT DISTINCT BXQ_E2PREF|| BXQ_E2NUM TITULO_COM , SUBSTR (E2_NOMFOR,1,20) NOMVEN_COM,   BQC_CODCLI ||'-'||BQC_DESCRI CLIENTE ,  "
cquery += CRLF+"        nvl(E2_VALOR,0.00) LIQ_COM, nvl(E2_SALDO,0.00) SALDO_COM, nvl((E2_INSS + E2_ISS + E2_IRRF + E2_VRETPIS + E2_VRETCOF + E2_VRETCSL + E2_VALOR),0.00) VLRBRT_COM , "
cquery += CRLF+"        SUBSTR(E2_VENCREA,7,2)||'/'||SUBSTR(E2_VENCREA,5,2)||'/'|| SUBSTR(E2_VENCREA,1,4) VENC_COM , "
cquery += CRLF+"        SUBSTR(E2_BAIXA,7,2)  ||'/'||SUBSTR(E2_BAIXA,5,2)  ||'/'|| SUBSTR(E2_BAIXA,1,4) Baixa_COM  , " 

//cquery += CRLF+"        BXQ_PREFIX || BXQ_NUM  TITULO_CLIENT  , (DECODE(e1_TIPO,'NCC',-1,1)* e1_valor)LIQ_RECEBER , (DECODE(e1_TIPO,'NCC',-1,1)* E1_SALDO) SALDO_RECEBER , "
cquery += CRLF+"        E1_PREFIXO || E1_NUM || E1_TIPO  TITULO_CLIENT  , DECODE(e1_TIPO,'NCC',-1,1) * e1_valor  LIQ_RECEBER , DECODE(e1_TIPO,'NCC',-1,1)* E1_SALDO SALDO_RECEBER , "
cquery += CRLF+"        DECODE(e1_TIPO,'NCC',-1,1)*(E1_INSS + E1_ISS + E1_IRRF + E1_PIS + E1_COFINS + E1_CSLL + E1_VALOR) VLRBRT_RECEBER  , "

cquery += CRLF+"        SUBSTR(E1_VENCREA,7,2)||'/'||SUBSTR(E1_VENCREA,5,2)||'/'|| SUBSTR(E1_VENCREA,1,4) VENC_RECEBER   , " 
cquery += CRLF+"        SUBSTR(E1_BAIXA,7,2)  ||'/'||SUBSTR(E1_BAIXA,5,2)  ||'/'|| SUBSTR(E1_BAIXA,1,4)   BAIXA_RECEBER  ,  bxq_ano||'/'||bxq_mes cptcom "
cquery += CRLF+"  FROM  "+ RetSqlName("Bxq") + " Bxq ,"+ RetSqlName("Bqc") + " Bqc ,"+ RetSqlName("se2") + " se2 ,"  + RetSqlName("se1") + " se1 "    
cquery += CRLF+" WHERE  BXQ_FILIAL = '" + xFilial('BXQ') + "'  AND BXQ.D_E_L_E_T_ = ' ' AND  BQC_FILIAL = '" + xFilial('BQC') + "' AND BQC.D_E_L_E_T_ = ' ' "
cquery += CRLF+"   AND  E2_FILIAL  = '" + xFilial('SE2') + "'  AND se2.D_E_L_E_T_ = ' ' AND   E1_FILIAL = '" + xFilial('SE1') + "' AND se1.D_E_L_E_T_ = ' ' "

If !empty(cAnoBase) 
   cquery += CRLF+"     AND  BXQ_ANO = '"+ cAnoBase +"'"
EndIf 

If !empty(cMesBase) 
   cquery += CRLF+"     AND BXQ_MES = '"+cMesBase+"' "
EndIf 

If cSoBaixa  = 1 
   cquery += CRLF+"     and e2_baixa <> ' ' and e2_saldo = 0 "
EndIF                  
cquery += CRLF+"        AND  BQC_NUMCON = BXQ_NUMCON AND BQC_VERCON  = BXQ_VERCON AND  BQC_subCON = BxQ_subCON and bqc_versub = bxq_versub AND BXQ_CODEMP >= '"+cCodEmpI+"' AND BXQ_CODEMP <= '"+cCodEmpF+"' " 
cquery += CRLF+"        AND  BQC_CODEMP = BXQ_CODEMP AND  BXQ_E2PREF = E2_PREFIXO AND BXQ_E2NUM = E2_NUM AND  BXQ_E2TIPO =  E2_TIPO AND  bxq_e2forn = e2_fornece "
cquery += CRLF+"        AND  BXQ_PREFIX = E1_PREFIXO  AND  BXQ_NUM   = E1_NUM "

cquery += CRLF+"        AND  E1_TIPO iN ('DP','NCC')  and  bxq_numpar not in('999','777')" 
if mv_par07 == 1
   cquery += CRLF+"    order by 2, 1 "
else 
   cquery += CRLF+"    order by 3, 1 "    
EndIf

/////////////////////////////////////////*
	   	
If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif
  
TCQuery cQuery New Alias (cAliastmp)  
    
dbSelectArea(cAliastmp)
   
(cAliastmp)->(dbGoTop())   
     
While (cAliastmp)->(!Eof())      
     
       aaDD(aDados1,{(cAliastmp)->TITULO_COM     ,; 
                     (cAliastmp)->CLIENTE        ,; 
                     (cAliastmp)->LIQ_COM        ,;
                     (cAliastmp)->SALDO_COM      ,;    
                     (cAliastmp)->VLRBRT_COM     ,;
                     (cAliastmp)->VENC_COM       ,;
                     (cAliastmp)->Baixa_COM      ,;
                     (cAliastmp)->TITULO_CLIENT  ,;
                     (cAliastmp)->LIQ_RECEBER    ,;
                     (cAliastmp)->SALDO_RECEBER  ,; 
                     (cAliastmp)->VLRBRT_RECEBER ,;    
                     (cAliastmp)->VENC_RECEBER   ,;
                     (cAliastmp)->BAIXA_RECEBER  ,;
                     (cAliastmp)->NOMVEN_COM    ,;
                     0,;
                     (cAliastmp)->cptcom })    
                     

       (cAliastmp)->(dbSkip()) 	   
     EndDo	         
     
     if len(aDados1) > 1
       For i := 1 To len(aDados1)
         if i != 1 .and.  (aDados1[i][1]) == cTitVar     
            aDados1[i][1] := ' '  
            aDados1[i][14]:= ' ' 
            aDados1[i][3] := ' '         
            aDados1[i][4] := ' '                 
            aDados1[i][5] := ' '           
            aDados1[i][6] := '   '                                                                            
            aDados1[i][7] := '   '
            aDados1[i][15]:= grup_reg              
         else     
          If i == 1 
             grup_reg := 1            
             aDados1[i][15]:= grup_reg
             cTitVar := (aDados1[i][1]) 
          else
             grup_reg++                
             aDados1[i][15]:= grup_reg
             cTitVar := (aDados1[i][1]) 
         endIf    
        endIf            
       Next i      
     EndIf
         
Return                    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR130"  
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
oReport	:= TReport():New("CABR137","Lista de Controle de Pagto de Comissao - Competencia "+cAnoBase+"/"+cMesBase  ,, {|oReport| ReportPrt(oReport)},"Lista de Controle de Pagto de Comissao"+cAnoBase+"/"+cMesBase  )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Lista de Controle de Pagto de Comissao - Competencia "+cAnoBase+"/"+cMesBase  ,,aOrdem)             

   TRCell():New(oDPJ ,'TITULO_COM'	   		,/*TABELA*/	,'Titulo Comissao'    ,/*Picture*/   	    ,17				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'VENDEDOR'	     	,/*TABELA*/	,'Vendedor '          ,/*Picture*/ 	        ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'LIQ_COM'	       	    ,/*TABELA*/	,'Vl.Liq Comissao'    ,"@E 99,999,999.99" 	,14				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'SALDO_COM'	      	,/*TABELA*/	,'Saldo Comissao'     ,"@E 99,999,999.99" 	,14				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'VLRBRT_COM'	     	,/*TABELA*/	,'Vl.Bruto Comissao'  ,"@E 99,999,999.99" 	,14				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'VENCTO_COM'	     	,/*TABELA*/	,'Dt.Vencto Comissao' ,/*Picture*/ 	        ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'BAIXA_COM'	   		,/*TABELA*/	,'Dt.Baixa Comissao ' ,/*Picture*/ 	        ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ ,'CLIENTE'	     		,/*TABELA*/	,'Ident. Cliente'     ,/*Picture*/ 	        ,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'TITULO_CLI'	   		,/*TABELA*/	,'Titulo Cliente   '    ,/*Picture*/   	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'LIQ_CLI'	       	    ,/*TABELA*/	,'Vl.Liq Cliente'     ,"@E 99,999,999.99" 	,14				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'SALDO_CLI'	      	,/*TABELA*/	,'Saldo Cliente'      ,"@E 99,999,999.99" 	,14				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'VLRBRT_CLI'	     	,/*TABELA*/	,'Vl.Bruto Cliente'   ,"@E 99,999,999.99" 	,14				,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'VENCTO_CLI'	     	,/*TABELA*/	,'Dt.Vencto Cliente'  ,/*Picture*/ 	        ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'BAIXA_CLI'	   		,/*TABELA*/	,'Dt.Baixa Cliente '  ,/*Picture*/ 	        ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'GRUPO'	     		,/*TABELA*/	,'Grupo'              ,/*Picture*/ 	        ,02				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
   TRCell():New(oDPJ ,'COMPTECOM'	     		,/*TABELA*/	,'Compte Comissão'              ,/*Picture*/ 	        ,015				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  


 if mv_par07 == 9
      oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("VENDEDOR"),"Total por Cliente "	,.F.) 
 else 
      oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell('GRUPO'),"Total por Cliente "	,.F.)  
 EndIf
lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

 if mv_par07 == 1                                                                   
  //   TRFunction():New(oDPJ:Cell("VENDEDOR")  	    ,NIL,"COUNT"		,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("LIQ_COM")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("SALDO_COM")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("VLRBRT_COM")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)     

     TRFunction():New(oDPJ:Cell("LIQ_CLI")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("SALDO_CLI")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("VLRBRT_CLI")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)   
  
 Else   
     TRFunction():New(oDPJ:Cell("CLIENTE")  	    ,NIL,"COUNT"		,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("LIQ_COM")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("SALDO_COM")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("VLRBRT_COM")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)    
     
     TRFunction():New(oDPJ:Cell("LIQ_CLI")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("SALDO_CLI")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
     TRFunction():New(oDPJ:Cell("VLRBRT_CLI")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)   

 EndIf    
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

       oDPJ:Cell('TITULO_COM' 		):SetValue((aDados1[i][1])) 
       oDPJ:Cell('VENDEDOR'     	):SetValue((aDados1[i][14]))
       oDPJ:Cell('CLIENTE'	 		):SetValue((aDados1[i][2]))    
       oDPJ:Cell('LIQ_COM'    		):SetValue((aDados1[i][3]))          
       oDPJ:Cell('SALDO_COM'	  	):SetValue((aDados1[i][4]))                 
       oDPJ:Cell('VLRBRT_COM'	 	):SetValue((aDados1[i][5]))           
       oDPJ:Cell('VENCTO_COM'	 	):SetValue((aDados1[i][6]))                                                                            
       oDPJ:Cell('BAIXA_COM'	 	):SetValue((aDados1[i][7]))          
       oDPJ:Cell('TITULO_CLI'	   	):SetValue((aDados1[i][8])) 
       oDPJ:Cell('LIQ_CLI'	        ):SetValue((aDados1[i][9])) 
       oDPJ:Cell('SALDO_CLI'	    ):SetValue((aDados1[i][10])) 
       oDPJ:Cell('VLRBRT_CLI'	    ):SetValue((aDados1[i][11])) 
       oDPJ:Cell('VENCTO_CLI'	    ):SetValue((aDados1[i][12])) 
       oDPJ:Cell('BAIXA_CLI'	   	):SetValue((aDados1[i][13]))          
       oDPJ:Cell('GRUPO'    	   	):SetValue((aDados1[i][15]))
       oDPJ:Cell('COMPTECOM' 	   	):SetValue((aDados1[i][16]))         
       

   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Cod. Empresa De ")    		,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"02",OemToAnsi("Cod. Empresa Ate ")   		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"03",OemToAnsi("Mes Base  ")       		,"","","mv_ch3","C",02,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"04",OemToAnsi("Ano Base  ")       		,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","",{},{})    
PutSx1(cPerg,"05",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"06",OemToAnsi("So Baixados  ") 	        ,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"07",OemToAnsi("Ordenar Por  ") 	        ,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Vendedor ","","","","Cliente ","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return

