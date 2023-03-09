#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR202   º Autor ³Altamiro              º Data ³ 26/09/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para Litar guia fora do desvio                      º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR202

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR202"
Private cTitulo     := "Listagem de entregas fora do desvio "        

Private cAliastmp 	:= GetNextAlias()

Private cEmpresa 	:= iif (SubStr(cNumEmp,1,2) = "01","Caberj", "empresarial")
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa  lista  peg's que tenham seu valor fora do desvio estipula , numero seguro - para melhor analise "

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Comp.Custo" , "Cod. Rda" , "Nome Rda" , "Grupo Pagto " , "Vlr Comp. Hosp " , "Vlr Prod Hosp" ,"Vlr Comp. Amb " , "Vlr Prod Amb" ,"Vlr Comp. Odont " , "Vlr Prod Odont"  }    
                                                                                                                                                    
private Descric := ' '                                                                                                         
	
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 
 
cAnoCmp      := mv_par01
cMesCmp      := mv_par02 
cRdaDe       := mv_par03
cRdaAte      := mv_par04
cCAnalist    := mv_par05 
nListar      := mv_par06                                              
nGeraEx      := mv_par07                                              

  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel   
   if nGeraEx == 1 
      DlgToExcel({{"ARRAY","Este programa  lista  peg's que tenham seu valor fora do desvio estipula , numero seguro - para melhor analise " ,aCabec1,aDados1}})   
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
cQuery := " SELECT  DECODE(ZZP_TIPREM,1, '"+cEmpresa+"', 2 , '"+cEmpresa+"', 3 , 'Prefeitura' ,'outros') TPREM  ,"
cQuery += " zzp_tiprem tiprem ,  ZZP_ANOPAG||'/'||ZZP_MESPAG comp ,   "	+ CRLF
cQuery += " zzp_codrda rda2 , bau_nome NomeRda , bau_grppag || b16_descri grppag, zzp_nomana NOMANA , "	+ CRLF
                
cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+ ",'YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+ ",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','1') medforhos, " 	+ CRLF
cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+ ",'YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+ ",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','2') medforamb, "	+ CRLF
cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+ ",'YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+ ",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','3') medforodn, "	+ CRLF
                
cQuery += " sum(zzp_vlinho) vlrhosp , "	+ CRLF
cQuery += " sum(zzp_vlinam) vlramb  , "	+ CRLF
cQuery += " sum(zzp_vlinod) vlrod   , "	+ CRLF
cQuery += " ( sum(zzp_vlinho) + sum(zzp_vlinam) + sum(zzp_vlinod) ) vltot  "	+ CRLF
cQuery += " FROM " + RetSqlName('ZZP') +" ZZP  , " + RetSqlName('BAU') +" bau , " + RetSqlName('B16') +" b16 "	+ CRLF
cQuery += " WHERE ZZP_FILIAL = '" + xFilial('ZZP') + "' and zzp.D_E_L_E_T_ = ' ' "	+ CRLF
cQuery += "   and bau_filial = '" + xFilial('BAU') + "' and bau.D_E_L_E_T_ = ' ' "	+ CRLF
cQuery += "   and b16_filial = '" + xFilial('B16') + "' and b16.D_E_L_E_T_ = ' ' "	+ CRLF
cQuery += "   and bau_grppag = b16.B16_CODIGO "
cQuery += "   and bau_codigo = ZZP_CODRDA  " + CRLF
cQuery += "   AND ZZP_ANOPAG||ZZP_MESPAG = '"+cAnoCmp+cMesCmp +"' "+ CRLF

cQuery += "   and zzp_status  not in ( 'PCA' , 'CCA' ) " + CRLF     
                                                                   
if  !empty(cCAnalist)                                      
    cQuery += "   and zzp_codana= '"+cCAnalist+ "'" + CRLF    
EndIf 

If nListar = 1
   cQuery += " and ZZP_TIPREM <> 3
ElseIf nListar = 2
   cQuery += " and ZZP_TIPREM =  3
endIf  
cQuery += "   and ZZP_CODRDA >= '"+CRDADE +"' and ZZP_CODRDA <= '"+CRDAATE +"' "	 + CRLF

cQuery += " group by zzp_tiprem , zzp_codrda, bau_nome , bau_grppag , b16_descri , zzp_nomana  , ZZP_ANOPAG,ZZP_MESPAG , " 	+ CRLF
cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+cAnoCmp+cMesCmp +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','1'), "	+ CRLF
cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+cAnoCmp+cMesCmp +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','2'), "	+ CRLF
cQuery += " TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+cAnoCmp+cMesCmp +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','3')  "	+ CRLF
           
cQuery += " having (TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+cAnoCmp+cMesCmp +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','1') < sum(zzp_vlinho) or "	+ CRLF
cQuery += "         TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+cAnoCmp+cMesCmp +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','2') < sum(zzp_vlinam) or "	+ CRLF
cQuery += "         TEMP_ZZP (TO_CHAR(ADD_MONTHS(TO_DATE('"+cAnoCmp+cMesCmp +"','YYYYMM'), -13),'YYYYMM'),TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp +",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','3') < sum(zzp_vlinod) )  "	+ CRLF
                   
cQuery += " order by  14 desc " //zzp_nomana , zzp_codrda "	+ CRLF   
////////////////////

   	
    If Select(cAliastmp) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())  
        if (((cAliastmp)->medforhos != 0 .or.(cAliastmp)->medforhos != 0 .or.(cAliastmp)->medforodn != 0) .or. ;      
           ((((cAliastmp)->medforhos*1.1) < (cAliastmp)->vlrhosp .and. (cAliastmp)->vlrhosp > 0 ) .or. ;
            (((cAliastmp)->medforamb*1.1) < (cAliastmp)->vlramb  .and. (cAliastmp)->vlramb > 0 ) .or. ;
            (((cAliastmp)->medforodn*1.1) < (cAliastmp)->vlrod   .and. (cAliastmp)->vlrod > 0 )))
         
        aaDD(aDados1,{(cAliastmp)->comp    ,;                
                    (cAliastmp)->NOMANA  ,;
                    (cAliastmp)->grppag  ,;    
                    (cAliastmp)->rda2    ,;                
                    (cAliastmp)->NomeRda ,;     
                    (cAliastmp)->medforhos ,;  
    		        (cAliastmp)->vlrhosp ,;                                                                                                   
		            (cAliastmp)->medforamb , ;
		            (cAliastmp)->vlramb ,; 
		            (cAliastmp)->medforodn  ,; 
		            (cAliastmp)->vlrod })    
		EndIf                                                                                                             
       (cAliastmp)->(dbSkip()) 	   
     EndDo	                   
Return                    

*************************************************************************************************************  
Static Function fGeraRel

Local oReport 
Private cPerg		:= "CABR202"  
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
oReport	:= TReport():New("CABR202","Listagem de Rda's que tenham seu valor fora do desvio estipula , numero seguro - para melhor analise  ",, {|oReport| ReportPrt(oReport)},"Listagem de Rda's que tenham seu valor fora do desvio estipula , numero seguro - para melhor analise ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem de Rda's que tenham seu valor fora do desvio estipula , numero seguro - para melhor analise  ",,aOrdem)             


   TRCell():New(oDPJ ,'COMPTE'        		,/*TABELA*/	,'Comp Custo'      ,/*Picture*/   		,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'NOMANA'	     	    ,/*TABELA*/	,'Nome Analista'   ,/*Picture*/ 	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'GRPPAG'	     	    ,/*TABELA*/	,'Grup. Pagto  '   ,/*Picture*/ 	    ,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'RDA'	        		,/*TABELA*/	,'Cod. Rda'	       ,/*Picture*/ 	    ,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'NOMRDA'	     		,/*TABELA*/	,'Nome Rda '       ,/*Picture*/ 	    ,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'MEDHOS'				,/*TABELA*/	,'Vl Seg. Hosptal' ,"@E 9,999,999.99"   ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'REMHOS'				,/*TABELA*/	,'Vl Rem. Hospital',"@E 9,999,999.99"  ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'MEDAMB'				,/*TABELA*/	,'Vl Seg. Ambulat.',"@E 9,999,999.99"  ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'REMAMB'				,/*TABELA*/	,'Vl Rem. Ambulat.',"@E 9,999,999.99"  ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)    
   TRCell():New(oDPJ ,'MEDODN'				,/*TABELA*/	,'Vl Seg. Odontol.',"@E 9,999,999.99"  ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'REMODN'				,/*TABELA*/	,'Vl Rem. Odontol.',"@E 9,999,999.99"  ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
 
/*oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("NOMANA"),"Total Analista   "	,.T.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

*/                                                                   
 // TRFunction():New(oDPJ:Cell("VLRTPF")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
 // TRFunction():New(oDPJ:Cell("VLRTAD")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 // TRFunction():New(oDPJ:Cell("VLGLO")  	    	,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 // TRFunction():New(oDPJ:Cell("VLPRO")    		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
 // TRFunction():New(oDPJ:Cell("VLCOP")   		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
 // TRFunction():New(oDPJ:Cell("NOMANA")  		,NIL,"COUNT"			,oBreak01,,"@E 9,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

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
 
 
 
   oDPJ:Cell('COMPTE'  	 ):SetValue((aDados1[i][1]))     
   oDPJ:Cell('NOMANA' 	 ):SetValue((aDados1[i][2]))
   oDPJ:Cell('GRPPAG' 	 ):SetValue((aDados1[i][3]))       
   oDPJ:Cell('RDA'       ):SetValue((aDados1[i][4]))
   oDPJ:Cell('NOMRDA'    ):SetValue((aDados1[i][5]))                                                        
   oDPJ:Cell('MEDHOS' 	 ):SetValue((aDados1[i][6]))                                                                                                                       
   oDPJ:Cell('REMHOS'  	 ):SetValue((aDados1[i][7]))                                                                                                                                                         
   oDPJ:Cell('MEDAMB'  	 ):SetValue((aDados1[i][8]))                                                                                                                                                         
   oDPJ:Cell('REMAMB'  	 ):SetValue((aDados1[i][9]))                                                                                                                                                         
   oDPJ:Cell('MEDODN'  	 ):SetValue((aDados1[i][10]))                                                                                                                                                         
   oDPJ:Cell('REMODN' 	 ):SetValue((aDados1[i][11]))                                                                                                                                                         
         
    
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
3)Data de inclusão da empresa
4)Empresa(nome / código)
5)Vendedor(nome / código) de um ou "n", dependendo da quantidade de vendedores para aquela empresa
6)Parcela (nº) - regra de comissão
*/

PutSx1(cPerg,"01",OemToAnsi("Competencia Ano  ") 	,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"02",OemToAnsi("Competencia Mes  ") 	,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Rda De ") 	            ,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"04",OemToAnsi("Rda Ate ") 	        ,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"05",OemToAnsi("Analista ") 	        ,"","","mv_ch5","C",06,0,0,"G","","LOGINU","","","mv_par05","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"06",OemToAnsi("Selecionar  ")        ,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Caberj","","","","Perfeitura","","","Totdos","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"07",OemToAnsi("Gerar Excel ")        ,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 


//PutSx1(cPerg,"10",OemToAnsi("Ordernar Por ")        ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Lote de pagamento","","","","Rda","","","Tit. Pagto","","","","","","","","",{},{},{}) 
Pergunte(cPerg,.F.)

Return

