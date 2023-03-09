
#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"                                                        


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR177   º Autor ³Altamiro              º Data ³ 15/04/15  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para imprimir resumo de titulos pagos por origem    º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR177

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR177"
Private cTitulo     := "Listagem de resumo de titulos baixados "        

Private cAliastmp 	:= GetNextAlias()
                                                                         

cMsg += " Este programa ira fazer Listagem de resumo de titulos baixados "

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Tipo","Qtda","Vlr.Titulo","Vlr.Moviment."}    
    
private Descric := ' '                                                                                                         
 	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cDtInc      := dtos(mv_par01)
cDtFim      := dtos(mv_par02)     

cGeraEx     := mv_par03 

cTitulo     := "Listagem de resumo de titulos baixados "  
cEmpresa    := Iif(cEmpAnt == '01','C','I') 
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel   
if len(adados1) > 0
   if cGeraEx == 1 
      DlgToExcel({{"ARRAY","Listagem de resumo de titulos baixados" ,aCabec1,aDados1}})   
   EndIf 
   fGeraRel()
EndIf   
    
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
cquery := CRLF+" SELECT TOT.TIPO TIPOTOT , SUM (TOT.QTDA) totqtda , SUM(TOT.VALORE2) totvlre2 , SUM(TOT.VALORE5) totvlre5  "
cquery += CRLF+"   FROM (select decode(trim(e2_ORIGEM)||trim(E2_PREFIXO), "
cquery += CRLF+" 'CAB007RLE'  , 'REEMBOLSO'   , 'GPEM670GPE' , 'FINANCEIRO'  , 'FINA050FIN' , 'FINANCEIRO'  , "
cquery += CRLF+" 'FINA050DPJ' , 'FINANCEIRO'  , 'FINA050BO'  , 'FINANCEIRO'  , 'FINA050AXF' , 'AUX_FUNERAL' , 'PLSM152COM' , 'COMISSAO'    , " 
cquery += CRLF+" 'PLSMPAGCLI' , 'PGTO MEDICO' , 'PLSMPAGODN' , 'PGTO MEDICO' , 'PLSMPAGOPE' , 'PGTO MEDICO' , 'PLSMPAGLAB' , 'PGTO MEDICO' , "
cquery += CRLF+" 'PLSMPAGMED' , 'PGTO MEDICO' , 'PLSMPAGINT' , 'PGTO MEDICO' , 'PLSMPAGNUP' , 'PGTO MEDICO' , 'PLSMPAGCON' , 'PGTO MEDICO' , "
cquery += CRLF+" 'PLSMPAGREM' , 'PGTO MEDICO' , 'PLSMPAGSVD' , 'PGTO MEDICO' , 'PLSMPAGHOS' , 'PGTO MEDICO' , 'PLSMPAGCOM' , 'PGTO MEDICO' , "
cquery += CRLF+" 'PLSMPAGAED' , 'PGTO MEDICO' , 'CAB007AXF'  , 'AUX_FUNERAL ', 'O_U_T_R_O') TIPO , "
cquery += CRLF+" count (*) QTDA ,SUM (E2_VALOR) VALORE2  , SUM (E5_VALOR) VALORE5 "
cquery += CRLF+"  from SE2010 SE2 , SE5010 SE5 "
cquery += CRLF+" WHERE e2_filial =  '01' AND SE2.d_e_L_E_T_ = ' '  "

cquery += CRLF+" and e2_baixa >= '"+cDtInc +"' and e2_baixa <= '"+cDtFim +"' "

cquery += CRLF+" and trim(e2_ORIGEM)||trim(E2_PREFIXO) not in ('MATA100UNI' ) "
cquery += CRLF+" AND TRIM(e2_tipo) not in ('TX' , 'INS','ISS','NDF', 'TXA', 'PA')"    
cquery += CRLF+" AND e5_filial =  '01' AND SE5.d_e_L_E_T_ = ' ' "
cquery += CRLF+" AND E5_MOTBX IN('NOR', 'DEB') "
cquery += CRLF+" AND SE5.E5_TIPODOC NOT IN ('ES') AND E5_DATA = e2_baixa AND se2.E2_FORNECE  = se5.E5_CLIFOR "
cquery += CRLF+" AND E5_PREFIXO = E2_PREFIXO AND E5_NUMERO = E2_num and e5_tipo = e2_tipo "           
cquery += CRLF+" and not exists (select null  from se5010 se51 where se51.e5_filial =  '01' AND SE51.d_e_L_E_T_ = ' ' "  
cquery += CRLF+"                    AND se5.E5_PREFIXO = se51.e5_PREFIXO AND se51.E5_NUMERO = se5.E5_NUMERO and se51.e5_tipo = se5.e5_tipo "           
cquery += CRLF+"                    and se51.e5_seq = se5.e5_seq AND se51.E5_CLIFOR  = se5.E5_CLIFOR "
cquery += CRLF+"                    and (SE51.e5_tipodoc = 'ES' OR TRIM(SE5.E5_SITUACA)  = 'C')) " 
cquery += CRLF+" group by E2_ORIGEM , E2_PREFIXO  "
cquery += CRLF+" UNION ALL "      
cquery += CRLF+" select decode(trim(e2_ORIGEM)||trim(E2_PREFIXO)||trim(e2_naturez),'MATA100UNIOPME' ,  'OPME' , 'O_U_T_R_O') TIPO , "
cquery += CRLF+" count (*) QTDA ,SUM (E2_VALOR) VALORE2 ,SUM (E5_VALOR) VALORE5 "
cquery += CRLF+" from SE2010 SE2 , SE5010 SE5 "
cquery += CRLF+" WHERE e2_filial =  '01' AND SE2.d_e_L_E_T_ = ' '  "

cquery += CRLF+" and e2_baixa >= '"+cDtInc +"' and e2_baixa <= '"+cDtFim +"' "

cquery += CRLF+" and trim(e2_ORIGEM)||trim(E2_PREFIXO) in ('MATA100UNI' ) "
cquery += CRLF+" AND TRIM(e2_tipo) not in ('TX' , 'INS','ISS','NDF', 'TXA' , 'PA') "  
cquery += CRLF+" AND e5_filial =  '01' AND SE5.d_e_L_E_T_ = ' ' " 
cquery += CRLF+" AND E5_MOTBX IN('NOR', 'DEB')  "
cquery += CRLF+" AND SE5.E5_TIPODOC NOT IN ('ES') AND E5_DATA = e2_baixa AND se2.E2_FORNECE  = se5.E5_CLIFOR  "
cquery += CRLF+" AND E5_PREFIXO = E2_PREFIXO AND E5_NUMERO = E2_num and e5_tipo = e2_tipo  "          
cquery += CRLF+" and not exists (select null from se5010 se51 where se51.e5_filial =  '01' AND SE51.d_e_L_E_T_ = ' '  "
cquery += CRLF+"                    AND se5.E5_PREFIXO = se51.e5_PREFIXO AND se51.E5_NUMERO = se5.E5_NUMERO and se51.e5_tipo = se5.e5_tipo  "          
cquery += CRLF+"                    and se51.e5_seq = se5.e5_seq AND se51.E5_CLIFOR  = se5.E5_CLIFOR and (SE51.e5_tipodoc = 'ES' OR TRIM(SE5.E5_SITUACA)  = 'C') ) " 
cquery += CRLF+" group by E2_ORIGEM , E2_PREFIXO, E2_NATUREZ "   
cquery += CRLF+" UNION ALL   "   
cquery += CRLF+" select decode(trim(E2_TIPO), 'TX' ,'IMPOSTOS' ,'INS','IMPOSTOS','ISS','IMPOSTOS' ,'NDF','NDF',  "
cquery += CRLF+" 'TXA' ,'IMPOSTOS', 'OUTROS') TIPO , count (*) QTDA ,SUM (E2_VALOR) VALORE2 ,SUM (E5_VALOR) VALORE5 "
cquery += CRLF+"   from SE2010 SE2 , SE5010 SE5 "
cquery += CRLF+"  WHERE e2_filial =  '01' AND SE2.d_e_L_E_T_ = ' '  "

cquery += CRLF+" and e2_baixa >= '"+cDtInc +"' and e2_baixa <= '"+cDtFim +"' "

cquery += CRLF+"  AND TRIM(e2_tipo) in ('TX','INS','ISS','NDF','TXA')  "  
cquery += CRLF+"  AND e5_filial =  '01' AND SE5.d_e_L_E_T_ = ' '  "
cquery += CRLF+"  AND E5_MOTBX IN('NOR', 'DEB') "
cquery += CRLF+"  AND SE5.E5_TIPODOC NOT IN ('ES') AND E5_DATA = e2_baixa AND se2.E2_FORNECE  = se5.E5_CLIFOR  "
cquery += CRLF+"  AND E5_PREFIXO = E2_PREFIXO AND E5_NUMERO = E2_num and e5_tipo = e2_tipo   "         
cquery += CRLF+"  and not exists (select null from se5010 se51 where se51.e5_filial =  '01' AND SE51.d_e_L_E_T_ = ' '   "
cquery += CRLF+"                     AND se5.E5_PREFIXO = se51.e5_PREFIXO AND se51.E5_NUMERO = se5.E5_NUMERO and se51.e5_tipo = se5.e5_tipo  "          
cquery += CRLF+"                     and se51.e5_seq = se5.e5_seq AND se51.E5_CLIFOR  = se5.E5_CLIFOR and (SE51.e5_tipodoc = 'ES' OR TRIM(SE5.E5_SITUACA)  = 'C'))  "
cquery += CRLF+" group by  E2_TIPO "
cquery += CRLF+" UNION ALL  "
cquery += CRLF+" select decode(trim(E2_TIPO), 'PA' , 'PA' , 'OUTROS') TIPO , count (*) QTDA ,SUM (E2_VALOR) VALORE2 ,SUM (E5_VALOR) VALORE5 "
cquery += CRLF+"   from SE2010 SE2 , SE5010 SE5 "
cquery += CRLF+"  WHERE e2_filial =  '01' AND SE2.d_e_L_E_T_ = ' '  "

cquery += CRLF+" and e2_baixa >= '"+cDtInc +"' and e2_baixa <= '"+cDtFim +"' "

cquery += CRLF+"  AND TRIM(e2_tipo) in ('PA') AND e5_filial =  '01' AND SE5.d_e_L_E_T_ = ' ' " 
cquery += CRLF+" AND SE5.E5_TIPODOC NOT IN ('ES') AND E5_DATA = e2_EMISSAO AND se2.E2_FORNECE  = se5.E5_CLIFOR "
cquery += CRLF+" AND E5_PREFIXO = E2_PREFIXO AND E5_NUMERO = E2_num and e5_tipo = e2_tipo  "          
cquery += CRLF+" and not exists (select null from se5010 se51 where se51.e5_filial =  '01' AND SE51.d_e_L_E_T_ = ' ' " 
cquery += CRLF+"                    AND se5.E5_PREFIXO = se51.e5_PREFIXO AND se51.E5_NUMERO = se5.E5_NUMERO and se51.e5_tipo = se5.e5_tipo  "          
cquery += CRLF+"                    and se51.e5_seq = se5.e5_seq AND se51.E5_CLIFOR  = se5.E5_CLIFOR and (SE51.e5_tipodoc = 'ES' OR TRIM(SE5.E5_SITUACA)  = 'C')) "
cquery += CRLF+" group by  E2_TIPO) TOT  "
cquery += CRLF+" GROUP BY TIPO "                       

/////////////////////////////////////////*
	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof()) 
     
      aaDD(aDados1,{(cAliastmp)->TIPOTOT ,;                
                    (cAliastmp)->totqtda ,;                
                    (cAliastmp)->totvlre2 ,;
                    (cAliastmp)->totvlre5 })                                                                                                     
	        
       (cAliastmp)->(dbSkip()) 	   
     EndDo	                   
Return                    

*************************************************************************************************************  
Static Function fGeraRel

Local oReport 
Private cPerg		:= "CABR177"  
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
oReport	:= TReport():New("CABR177","Listagem de titulo baixados por prefixo " ,, {|oReport| ReportPrt(oReport)},"Listagem de titulo baixados por prefixo ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
//oReport:SetLandscape() //Impressao em paisagem.  
oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport," Listagem de titulo baixados por prefixo  " ,,aOrdem)      
//oDPJ := TRSection():New(oReport,"Listagem de coparticipação alocado por competencia de custo - lote de fatuaramento " + cNumLotFat ,,aOrdem)             
       
  
   TRCell():New(oDPJ ,'TIPO'				,/*TABELA*/	,'Tipo'	 		     ,/*Picture*/ 			,25				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'QTDTOT'				,/*TABELA*/	,'Qtda' 	    	 ,"@E 99,999"           ,10			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
   TRCell():New(oDPJ ,'VLRE2'				,/*TABELA*/	,'Vlr.Titulo'        ,"@E 9,999,999.99"  	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'VLRE5'				,/*TABELA*/	,'Vlr.Moviment'      ,"@E 9,999,999.99"  	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)   
  
 
//oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("TIPO"),"Total Geral   "	,.T.)  

//lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
TRFunction():New(oDPJ:Cell("QTDTOT")    	    ,NIL,"SUM"	    	,,,"@E 9,999,999"	    ,/*uFormula*/	, ,lTotFimBrk01)  
TRFunction():New(oDPJ:Cell("VLRE2")    	        ,NIL,"SUM"	    	,,,"@E 999,999,999.99"	,/*uFormula*/	, ,lTotFimBrk01)  
TRFunction():New(oDPJ:Cell("VLRE5")    	        ,NIL,"SUM"	    	,,,"@E 999,999,999.99"	,/*uFormula*/	, ,lTotFimBrk01) 
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

   oDPJ:Cell('TIPO'	 		):SetValue((aDados1[i][1]))     
   oDPJ:Cell('QTDTOT'		):SetValue((aDados1[i][2]))      
   oDPJ:Cell('VLRE2'	 	):SetValue((aDados1[i][3]))     
   oDPJ:Cell('VLRE5'		):SetValue((aDados1[i][4]))    

   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}
  
PutSx1(cPerg,"01",OemToAnsi("Baixa De  ")  		,"","","mv_ch1","D",10,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("baixa Ate ")  		,"","","mv_ch2","D",10,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("Gerar Excel ")     ,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return

