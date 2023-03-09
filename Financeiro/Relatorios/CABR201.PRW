
#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"   


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR201   º Autor ³Altamiro              º Data ³ 26/09/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para LiStar Regra de comissão                       º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR201

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR201"
Private cTitulo     := "Listagem de Regras de comissao cadastradas   "        

Private cAliastmp 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa  lista  as regas de comissão conforme páramentros  "

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Ident Empresa","Inicio Vigencia","Inicio Vigencia" , "	"," "," "," ","Parc Inic","	Parc Final" , "	%	" ,"Dt 1. Inclus", "Dt Ult. Incl","Tp Incl.", "Agenciam.","contrato","SubCont","Data ContratInc", "Data Bloq"}
                                                                                                                                      
private Descric := ' '                                                                                                         
	
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.)    

cCodEmpDe    := mv_par01
cCodEmpAte   := mv_par02 
cCodVenDe    := mv_par03
cCodVenAte   := mv_par04
dDtInc       := mv_par05 
dDtFim       := mv_par06
nListFV      := mv_par07
nGeraEx	     := mv_par08        
nOrder       := mv_par09                                              

  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel   
   if nGeraEx == 1 
      DlgToExcel({{"ARRAY","Listagem de Regras de comissao cadastradas" ,aCabec1,aDados1}})   
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
cquery := CRLF+" select bxj_codven ||'-'|| nvl(a3_nome,' ') vendedor   "
cquery += CRLF+"      , bxj_codemp ||'-'|| bg9_descri       Empresa    "    
cquery += CRLF+"      , decode(bxj_tipinc ,'1','1-Plano Novo','2','2-Adesão','3','3-Dependente','4','4-Transferencia','5','5-Adaptação','S/ Classifcaçao') TpInc  "   
cquery += CRLF+"      , bxj_vldini dtviginc , bxj_vldfim dtvigfim , bxj_tippla tippla , bxj_tipinc tipinc , bxj_forcal forcal "
cquery += CRLF+"      , bxk_qtdde qtdde , bxk_qtdate qtdate , bxk_percon percon "
cquery += CRLF+"      , nvl(ba1aux.datinc,' ') datincba1 , nvl(ba1aux.datult,' ') datultba1  "          
IF cEmpAnt == '02'
   cquery += CRLF+"      ,DECODE(BXK_AGENC,'1', 'Sim','Não') Agenci  " 
Else                                                                                   
   cquery += CRLF+"      ,DECODE(BXK_AGENCI,'1', 'Sim','Não') Agenci  " 
EndIf    

cquery += CRLF+"      , ba1aux.conemp , ba1aux.subcon  " 

cquery += CRLF+"      , bqc_datcon dtcont , bqc_datblo dtbloq " 

cquery += CRLF+"   from " + RetSqlName("BXJ") + " BXJ ,"  + RetSqlName("BXK") + " BXK ," + RetSqlName("SA3") + " SA3 ," + RetSqlName("BG9") + " BG9 ," + RetSqlName("BQC") + " BQC ,  "
cquery += CRLF+" (select ba1_codemp ,  nvl(min(ba1_datinc), ' ') datinc  ,nvl(max(ba1_datinc), '  ') datult , ba1_conemp conemp , ba1_subcon subcon "   
cquery += CRLF+"    from  "+ RetSqlName("BA1") + " BA1 where  ba1_filial ='"+xFilial("BA1")+ "'  and ba1.d_E_L_E_T_ = ' '  "
cquery += CRLF+"   group by ba1_codemp, ba1_conemp , ba1_subcon ) ba1aux " 

cquery += CRLF+"  where bxj_filial    = '"+xFilial("BXJ")+ "' and BXJ.d_E_L_E_T_ = ' ' "
cquery += CRLF+"    and bxk_filial    = '"+xFilial("BXK")+ "' and BXK.d_E_L_E_T_ = ' ' "
cquery += CRLF+"    and a3_filial(+)  = '"+xFilial("SA3")+ "' and SA3.d_E_L_E_T_(+) = ' ' "
cquery += CRLF+"    and bg9_filial    = '"+xFilial("BG9")+ "' and BG9.d_E_L_E_T_ = ' ' "
cquery += CRLF+"    and bqc_filial    = '"+xFilial("Bqc")+ "' and BQC.d_E_L_E_T_ = ' ' "

cquery += CRLF+"    and bxj_codemp >= '"+cCodEmpDe+"' and bxj_codemp <= '"+cCodEmpAte+"'  

//cquery += CRLF+"    and bqc_codigo >= '0001"+cCodEmpDe+"' and bqc_codigo <= '0001"+cCodEmpate+"' 
cquery += CRLF+"    and bqc_codigo = '0001'||bxj_codemp and ba1aux.conemp = bqc_numcon and  ba1aux.subcon = bqc_subcon and (bqc_datblo = ' ' or bqc_datblo <='"+dtos(dDtFim)+"') "

if !empty(cCodVenDe)
   cquery += CRLF+"    and bxj_codven >= '"+cCodVenDe+"' and bxj_codven <= '"+cCodVenAte+"' 
EndIf 
if !empty(dDtInc)
    cquery += CRLF+"    and  bxj_vldini  >= '"+dtos(dDtInc)+"' and bxj_vldini <= '"+dtos(dDtFim)+"'   "
EndIf   
If nListFV == 1 
    cquery += CRLF+"    and bxj_vldfim <> ' ' " 
ElseIf nListFV == 2
    cquery += CRLF+"    and bxj_vldfim =  ' '"
EndIf 
cquery += CRLF+"    and ba1aux.ba1_codemp(+) = bxj.bxj_codemp "
cquery += CRLF+"    and bxj_seq = bxk_seqbxj  "
cquery += CRLF+"    and bxj_codven  = a3_cod(+) "
cquery += CRLF+"    and bg9_codigo  = bxj_codemp "
cquery += CRLF+"    and bxj_codemp <> ' ' and bxj_codven <> ' ' "
iF nOrder == 1
   cquery += CRLF+"  ORDER BY  bxj_codemp , bxj_codven  , decode(bxj_tipinc ,'1','1-Plano Novo','2','2-Adesão','3','3-Dependente','4','4-Transferencia','5','5-Adaptação','S/ Classifcaçao'),ba1aux.conemp , ba1aux.subcon "

Elseif nOrder == 2   
   cquery += CRLF+"  ORDER BY  bxj_codven , bxj_codemp , decode(bxj_tipinc ,'1','1-Plano Novo','2','2-Adesão','3','3-Dependente','4','4-Transferencia','5','5-Adaptação','S/ Classifcaçao') ,ba1aux.conemp , ba1aux.subcon " 

Elseif nOrder == 3   
   cquery += CRLF+"  ORDER BY  bxj_codven , bxj_codemp  ,  bxj_vldini  desc, ba1aux.conemp , ba1aux.subcon , decode(bxj_tipinc ,'1','1-Plano Novo','2','2-Adesão','3','3-Dependente','4','4-Transferencia','5','5-Adaptação','S/ Classifcaçao') " 

EndIf   

/////////////////////////////////////////*
	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())                                          
    
      aaDD(aDados1,{(cAliastmp)->vendedor  ,;                
                    (cAliastmp)->Empresa   ,;                
                    (cAliastmp)->dtviginc  ,;
                    (cAliastmp)->dtvigfim  ,;
                    (cAliastmp)->tippla    ,; 
                    (cAliastmp)->tipinc    ,;
                    (cAliastmp)->forcal    ,; 
                    (cAliastmp)->qtdde     ,;
                    (cAliastmp)->qtdate    ,;
   		            (cAliastmp)->percon    ,; 
       		   stod((cAliastmp)->datincba1),;                                                                                                   
               stod((cAliastmp)->datultba1),;
                    (cAliastmp)->TpInc     ,;
                    (cAliastmp)->Agenci    ,;
                    (cAliastmp)->conemp    ,;
                    (cAliastmp)->subcon    ,;
               stod((cAliastmp)->dtcont)   ,;
               stod((cAliastmp)->dtbloq)})                      
                                                                                            
       (cAliastmp)->(dbSkip()) 	   
     EndDo	                   
Return                    

*************************************************************************************************************  
Static Function fGeraRel

Local oReport 
Private cPerg		:= "CABR201"  
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
oReport	:= TReport():New("CABR201","Listagem de Regras de comissao cadastradas",, {|oReport| ReportPrt(oReport)},"Listagem de Regras de comissao cadastradas")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem de log de geração de Lote pagamento X Rda  ",,aOrdem)       

   TRCell():New(oDPJ ,'VENDED'        		,/*TABELA*/	,'Vendedor   '     ,/*Picture*/   		,45				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'EMPRES'	        	,/*TABELA*/	,'Empresa    '     ,/*Picture*/ 	    ,45				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ ,'TPINC'	        	,/*TABELA*/	,'Tp Inclusao'     ,/*Picture*/ 	    ,15				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)    
   TRCell():New(oDPJ ,'VIGINC'	     		,/*TABELA*/	,'Dt VigInc '     ,/*Picture*/ 	        ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'VIGFIM'	     		,/*TABELA*/	,'Dt VigFim '     ,/*Picture*/ 	        ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
  
   TRCell():New(oDPJ ,'QTDADE'	     	    ,/*TABELA*/	,'Q De '        ,/*Picture*/ 	        ,03				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'QTDATE'	     	    ,/*TABELA*/	,'Q Ate'       ,/*Picture*/ 	        ,03				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'PERCEN'				,/*TABELA*/	,'    % '          ,/*Picture*/  	    ,03			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

   TRCell():New(oDPJ ,'DTINCB'	     		,/*TABELA*/	,'Dt inicio'	   ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'DTULTB'	     		,/*TABELA*/	,'Dt Ultima'	   ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'AGENCI'	        	,/*TABELA*/	,'Agenc    '    ,/*Picture*/ 	        ,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   

   TRCell():New(oDPJ ,'CONEMP'	        	,/*TABELA*/	,'Contrato '    ,/*Picture*/ 	        ,13				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)      
   TRCell():New(oDPJ ,'SUBCON'	        	,/*TABELA*/	,'Sub-Contr'    ,/*Picture*/ 	        ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)        
   
   TRCell():New(oDPJ ,'DTCONT'	     		,/*TABELA*/	,'Dt Contr '	   ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'DTBLOQ'	     		,/*TABELA*/	,'Dt Bloq  '	   ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("EMPRES")," Qtda   "	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
   TRFunction():New(oDPJ:Cell("EMPRES")    	  ,NIL,"COUNT"	    	,oBreak01,,"@E 999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
//   TRFunction():New(oDPJ:Cell("VLRTAD")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
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

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local   cImp    :='Não'
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

   oDPJ:Cell('VENDED'  	 ):SetValue((aDados1[i][1]))     
   oDPJ:Cell('EMPRES'  	 ):SetValue((aDados1[i][2]))
   oDPJ:Cell('VIGINC' 	 ):SetValue((aDados1[i][3]))       
   oDPJ:Cell('VIGFIM'    ):SetValue((aDados1[i][4]))
   oDPJ:Cell('QTDADE'    ):SetValue((aDados1[i][8]))                                                        
   oDPJ:Cell('QTDATE' 	 ):SetValue((aDados1[i][9]))                                                                                                                       
   oDPJ:Cell('PERCEN'  	 ):SetValue((aDados1[i][10]))                                                                                                                                                         

   oDPJ:Cell('DTINCB' 	 ):SetValue((aDados1[i][11]))                                                                                                                                                         
   oDPJ:Cell('DTULTB'  	 ):SetValue((aDados1[i][12]))   
   
   oDPJ:Cell('TPINC' 	 ):SetValue((aDados1[i][13]))   
   oDPJ:Cell('AGENCI'    ):SetValue((aDados1[i][14]))

   oDPJ:Cell('CONEMP'    ):SetValue((aDados1[i][15]))
   oDPJ:Cell('SUBCON'    ):SetValue((aDados1[i][16]))   
   
   oDPJ:Cell('DTCONT' 	 ):SetValue((aDados1[i][17]))                                                                                                                                                         
   oDPJ:Cell('DTBLOQ' 	 ):SetValue((aDados1[i][18]))   

   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}         
/*
1)Possa ser gerado em excel
2)Contemple - data de consulta (ou seja), qual a situação da regra na data consultada
3)Data de inclusão da empresa   --- data da primeira inclução de vida
4)Empresa(nome / código)
5)Vendedor(nome / código) de um ou "n", dependendo da quantidade de vendedores para aquela empresa
6)Parcela (nº) - regra de comissão
*/          
/*
select --bxj_codequ ,
  bxj_codven ||'-'|| nvl(a3_nome,' ') 
--, bxlaux.bxl_codequ ||'-'|| bxlaux.bxl_desequ
, bxj_codemp ||'-'|| bg9_descri
, bxj_vldini  ,bxj_vldfim , bxj_tippla  , bxj_tipinc , bxj_forcal 
, bxk_qtdde , bxk_qtdate , bxk_percon
, ba1aux.datinc ,ba1aux.datult   

from bxj020 bxj , bxk020 bxk , sa3020 sa3 , bg9020 bg9  ,

(select ba1_codemp ,  nvl(min(ba1_datinc), '  /  /  ') datinc  ,nvl(max(ba1_datinc), '  /  /  ') datult    from ba1020 ba1 where  ba1_filial = '  ' and ba1.d_E_L_E_T_ = ' ' 
group by ba1_codemp
) ba1aux  

--,(select bxl_codequ , bxl_desequ from bxl020 bxl where bxl_filial =' ' and bxl.d_E_L_E_T_ = ' ' ) bxlaux 

where bxj_filial    = '  ' and bxj.d_E_L_E_T_ = ' ' 
  and bxk_filial    = '  ' and bxK.d_E_L_E_T_ = ' ' 
  and a3_filial(+)  = '  ' and sa3.d_E_L_E_T_(+) = ' ' 
  and bg9_filial    = '  ' and bg9.d_E_L_E_T_ = ' ' 
  
   and ba1aux.ba1_codemp = bxj.bxj_codemp
 --  and bxlaux.bxl_codequ(+) = bxj.bxj_codequ
  and bxj_seq = bxk_seqbxj
  and bxj_codven  = a3_cod(+)
  and bg9_codigo  = bxj_codemp
  and bxj_codemp <> ' ' 
  and bxj_codven <> ' ' 
  order by bxj_codemp , bxj_codven --, bxj_codequ  
  
*/
PutSx1(cPerg,"01",OemToAnsi("Empresa De ") 		    ,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"02",OemToAnsi("Empresa Ate ") 		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Vendedor De ") 	    ,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"04",OemToAnsi("Vendedor Ate ") 	    ,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"05",OemToAnsi("Data Inic. Vigen.") 	,"","","mv_ch5","D",08,0,0,"G","","","","","mv_par05","   ","","","","   ","","","","","","","","","","","",{},{},{})   
PutSx1(cPerg,"06",OemToAnsi("Data Inic. Final.") 	    ,"","","mv_ch6","D",08,0,0,"G","","","","","mv_par06","   ","","","","   ","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"07",OemToAnsi("Listar  ")             ,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","C/Fim de Vigenc.","","","","S/Fim de Vigenc.","","","Todos","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"08",OemToAnsi("Gerar Excel ")         ,"","","mv_ch8","N",01,0,0,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"09",OemToAnsi("Ordernar Por ")        ,"","","mv_ch9","N",01,0,0,"C","","","","","mv_par09","Empresa","","","","Vendedor","","",".","","","","","","","","",{},{},{}) 
/*
PutSx1(cPerg,"05",OemToAnsi("Equipe De ") 	        ,"","","mv_ch5","C",03,0,0,"G","","","","","mv_par05","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"06",OemToAnsi("Equipe Ate ") 	        ,"","","mv_ch6","C",03,0,0,"G","","","","","mv_par06","   ","","","","   ","","","","","","","","","","","",{},{},{})
*/
Pergunte(cPerg,.F.)

Return

