#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR222   º Autor ³Altamiro              º Data ³ 26/09/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Listagem de Conferencia de Comissao Prefeitura              º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                      


User Function CABR222

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR222"
Private cTitulo     := "Listagem de Conferencia de Comissao Prefeitura  , Competencia - "        
private nGeraEx     := 1 
Private cAliastmp 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Listagem de Conferencia de Comissao Prefeitura  , Parcelas pagas (identificando o titulos) "

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Pref. Titulo","Num. Titulo","Tipo Titulo","Valor Titulo","Saldo Titulo","Dt.Emis. Fin.","Dt.Baixa Fin.","Valor Saude","Valor Odontol","Valor Total","% Comissão" , "Base de Calculo","Valor Comissao"}          


private Descric := ' '                                                                                                         
	
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cCompMes    := SUBSTR(mv_par01,1,2) 
cCompAno    := SUBSTR(mv_par01,4,4)       

cTitulo     := "Listagem de Conferencia de Comissao Prefeitura  , Competencia - " + cCompMes +'/'+cCompAno       
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel   
   if nGeraEx == 1 
      DlgToExcel({{"ARRAY","Listagem de Conferencia de Comissao Prefeitura  , Competencia - " + cCompMes +'/'+cCompAno ,aCabec1,aDados1}})   
   EndIf   
   
   fGeraRel()
 
    
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
//////////////////////       
             
cquery := CRLF+ "  SELECT E1_PREFIXO  pref , E1_NUM num , E1_TIPO tipo , E1_VALOR vlrtit , E1_SALDO SaldoTit , 
cquery += CRLF+ "         substr(E1_EMISSAO,7,2)||'/'||substr(E1_EMISSAO,5,2)||'/'||substr(E1_EMISSAO,1,4) DatEmis  , " 
cquery += CRLF+ "         substr(E1_BAIXA  ,7,2)||'/'||substr(E1_BAIXA  ,5,2)||'/'||substr(E1_BAIXA  ,1,4) Datbaixa , "
cquery += CRLF+ "         BM11.SAUDE VlrSaud , BM11.ODONTO vlrOdont , BM11.TOTAL vlrTotal , "
cquery += CRLF+ "         BXQ1.PRECOM||'%' prec ,  BXQ1.BASCOM bascom , BXQ1.VLRCOM Vlrcom , "
cquery += CRLF+ "         decode(trim(se1.e1_saldo) ,0 ,  '1', '2') baixado  ,  "         
cquery += CRLF+ "         se1.e1_codemp codemp   "        
cquery += CRLF+ "    FROM "+ RetSqlName("SE1") +" SE1 , "
cquery += CRLF+ "         ( select BXQ_PREFIX  , bxq_num  , bxq_tipo  ,  bxq_percom PRECOM , " 
cquery += CRLF+ "                  sum(bxq_bascom) BASCOM , sum(bxq_vlrcom)VLRCOM  "
cquery += CRLF+ "             from "+ RetSqlName("BXQ") +" BXQ  "
cquery += CRLF+ "            where bxq_filial = '"+xFilial("BXQ")+ "'  and d_E_L_E_T_ = ' ' "    
cquery += CRLF+ "              and bxq_codemp in ( '0024' , '0025','0027','0028') "
cquery += CRLF+ "              and bxq_mes    = '"+cCompMes+"' and bxq_ano = '"+cCompAno+"' "
cquery += CRLF+ "         group by BXQ_PREFIX , bxq_num , bxq_tipo ,  bxq_percom ) BXQ1 , "         

If 	cCompAno+cCompMes > '201607'

    cquery += CRLF+ "         ( SELECT bm1_prefix , bm1_numtit ,BM1_TIPTIT , "             
    cquery += CRLF+ "                  SUM( BM1_VALOR - VALOR_PARTE_DENTAL) Saude   , "
    cquery += CRLF+ "                  SUM(VALOR_PARTE_DENTAL) Odonto  , "
    cquery += CRLF+ "                  SUM(BM1_VALOR) total  "
    cquery += CRLF+ "             FROM "+ RetSqlName("BM1") +" BM1 , SIGA.VALOR_PARTE_ODONTO_PREFEITURA "
    cquery += CRLF+ "            WHERE BM1_FILIAL = '"+xFilial("BM1")+ "'    AND D_e_l_e_t_ = ' ' "
    cquery += CRLF+ "              and bm1_codemp in ( '0024' , '0025','0027','0028') "
    cquery += CRLF+ "              AND BM1_MES ='"+cCompMes +"' AND BM1_ANO =  '"+cCompAno+"' "  
    cquery += CRLF+ "              AND BM1_PREFIX = 'PLS' AND BM1_CODPLA = COD_PLANO AND BM1_CODTIP = '101' "
    cquery += CRLF+ "         GROUP BY bm1_prefix , bm1_numtit , BM1_TIPTIT ) BM11 " 
    
Else

    cquery += CRLF+ "         ( SELECT bm1_prefix , bm1_numtit ,BM1_TIPTIT , "
    cquery += CRLF+ "                  SUM(DECODE(BM1_CODTIP,'101' , BM1_VALOR , 0.00)) Saude   , "
    cquery += CRLF+ "                  SUM(DECODE(BM1_CODTIP,'102' , BM1_VALOR , 0.00)) Odonto  , "
    cquery += CRLF+ "                  SUM(BM1_VALOR ) total  "
    cquery += CRLF+ "             FROM "+ RetSqlName("BM1") +" BM1 "
    cquery += CRLF+ "            WHERE BM1_FILIAL = '"+xFilial("BM1")+ "'    AND D_e_l_e_t_ = ' ' "
    cquery += CRLF+ "              and bm1_codemp in ( '0024' , '0025','0027','0028') "
    cquery += CRLF+ "              AND BM1_MES ='"+cCompMes +"' AND BM1_ANO =  '"+cCompAno+"' "  
    cquery += CRLF+ "              AND BM1_PREFIX = 'PLS' "
    cquery += CRLF+ "         GROUP BY bm1_prefix , bm1_numtit , BM1_TIPTIT ) BM11 " 

EndIf     
cquery += CRLF+ "   WHERE E1_FILIAL ='"+xFilial("SE1")+ "' AND SE1.D_e_l_e_t_ = ' ' "
cquery += CRLF+ "     AND BXQ1.BXQ_PREFIX(+) = E1_PREFIXO "
cquery += CRLF+ "     AND BXQ1.BXQ_NUM(+)    = E1_NUM "
cquery += CRLF+ "     AND BXQ1.bxq_tipo(+)   = E1_TIPO "
cquery += CRLF+ "     AND BM11.BM1_PREFIX = E1_PREFIXO "
cquery += CRLF+ "     AND BM11.BM1_NUMTIT  = E1_NUM "
cquery += CRLF+ "     AND BM11.bM1_tipTIT  = E1_TIPO " 
cquery += CRLF+ "     AND E1_TIPO = 'DP' AND E1_MESBASE ='"+cCompMes +"' AND E1_ANOBASE =  '"+cCompAno+"' "  
 
cquery += CRLF+ "   ORDER BY se1.e1_codemp , decode(trim(se1.e1_saldo) ,0 ,  '1', '2') desc ,BXQ1.PRECOM desc ,  BM11.TOTAL desc  "


/////////////////////////////////////////*
	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())   
                                        
      aaDD(aDados1,{ (cAliastmp)->pref     ,;
                     (cAliastmp)->num      ,; 
                     (cAliastmp)->Tipo     ,;
                     (cAliastmp)->VlrTit   ,;
                     (cAliastmp)->SaldoTit ,; 
                     (cAliastmp)->DatEmis  ,;  
                     (cAliastmp)->DatBaixa ,;    
			    	 (cAliastmp)->VlrSaud  ,;    
					 (cAliastmp)->VlrOdont ,;     
 					 (cAliastmp)->Vlrtotal ,;    
					 (cAliastmp)->Prec     ,;  
					 (cAliastmp)->bascom   ,;         
					 (cAliastmp)->VlrCom   ,;
					 (cAliastmp)->CodEmp   })                                                                                                     

       (cAliastmp)->(dbSkip()) 	                           

     EndDo	                                                    

Return                    

*************************************************************************************************************  
Static Function fGeraRel

Local oReport 
Private cPerg		:= "CABR222"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}              
 
 

oReport:= ReportDef()
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

Static Function ReportDef()

Local oReport 
Local oDPJ    
oReport	:= TReport():New("CABR222","Listagem de Conferencia de Comissao Prefeitura  , Competencia - " + cCompMes +'/'+cCompAno,, {|oReport| ReportPrt(oReport)},"Listagem de Parcelamentos em aberto , Parcelas pagas (identificando o titulos) e nao pagas (identificando os debitos)")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem de Conferencia de Comissao Prefeitura  , Competencia - " + cCompMes +'/'+cCompAno,,aOrdem)             

   TRCell():New(oDPJ ,'CODEMP'       		,/*TABELA*/	,'Cod Empr '    ,/*Picture*/   		,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)                
   
   TRCell():New(oDPJ ,'PREFIX'       		,/*TABELA*/	,'Pref. Titulo'    ,/*Picture*/   		,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'NUMERO'       		,/*TABELA*/	,'Num. Titulo '    ,/*Picture*/ 	    ,09				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'TIPO  '	     		,/*TABELA*/	,'Tipo Titulo '    ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
     
   TRCell():New(oDPJ ,'VLRTIT'				,/*TABELA*/	,'Valor Titulo'    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
   TRCell():New(oDPJ ,'SALTIT'				,/*TABELA*/	,'Saldo Titulo'    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   
   TRCell():New(oDPJ ,'EMIFIN'	        	,/*TABELA*/	,'Dt.Emis. Fin.'    ,/*"@E 99:99"	*/  ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'BAIFIN'	        	,/*TABELA*/	,'Dt.Baixa Fin.'    ,/*"@E 99:99"	*/  ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   
   TRCell():New(oDPJ ,'VLRSAU'				,/*TABELA*/	,'Valor Saude  '    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)       
   TRCell():New(oDPJ ,'VLRODO'				,/*TABELA*/	,'Valor Odontol'    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
   TRCell():New(oDPJ ,'VLRTOT'				,/*TABELA*/	,'Valor Total  '    ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'VLRPRE'				,/*TABELA*/	,'Precentil    '    ,/*"@R     99.99" */ , 6			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)        
   
   TRCell():New(oDPJ ,'VLRBAS'	    		,/*TABELA*/	,'Base de Calculo'  ,"@R 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)       
   TRCell():New(oDPJ ,'VLRCOM'				,/*TABELA*/	,'Valor Comissao'   ,"@E 99,999,999.99"  ,15			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
                                                                          

 oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("CODEMP"),"Total por Empresa "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                     
 TRFunction():New(oDPJ:Cell("VLRTIT")    	,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
 TRFunction():New(oDPJ:Cell("SALTIT")    	,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLRSAU")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLRODO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  

 TRFunction():New(oDPJ:Cell("VLRTOT")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
 TRFunction():New(oDPJ:Cell("VLRBAS")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 TRFunction():New(oDPJ:Cell("VLRCOM")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
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
   oDPJ:Cell('CODEMP'):SetValue((aDados1[i][14]))     
    
   oDPJ:Cell('PREFIX'):SetValue((aDados1[i][01]))     
   oDPJ:Cell('NUMERO'):SetValue((aDados1[i][02]))
   oDPJ:Cell('TIPO  '):SetValue((aDados1[i][03]))       
   oDPJ:Cell('VLRTIT'):SetValue((aDados1[i][04]))    
   oDPJ:Cell('SALTIT'):SetValue((aDados1[i][05]))               
                                            
   oDPJ:Cell('EMIFIN'):SetValue((aDados1[i][06]))      
   oDPJ:Cell('BAIFIN'):SetValue((aDados1[i][07]))  
   oDPJ:Cell('VLRSAU'):SetValue((aDados1[i][08]))
   oDPJ:Cell('VLRODO'):SetValue((aDados1[i][09]))                                                                                            
   
   oDPJ:Cell('VLRTOT'):SetValue((aDados1[i][10]))  
   oDPJ:Cell('VLRPRE'):SetValue((aDados1[i][11]))                                                                                            
   oDPJ:Cell('VLRBAS'):SetValue((aDados1[i][12]))                                                                                           
   oDPJ:Cell('VLRCOM'):SetValue((aDados1[i][13]))                                                                                           
      
   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {} 

PutSx1(cPerg,"01",OemToAnsi("Mes/Ano Comissão  ?  ") 		,"","","mv_ch1","C",07,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","99/9999",aHelpPor,{},{})



Pergunte(cPerg,.F.)

Return
