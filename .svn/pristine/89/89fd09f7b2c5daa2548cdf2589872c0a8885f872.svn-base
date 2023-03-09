#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR213   º Autor ³Altamiro              º Data ³ 26/09/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para Litar guia fora do desvio                      º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR213

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR213"
Private cTitulo     := "Listagem de Previas Com por medias  "        

Private cAliastmp 	:= GetNextAlias()

Private cEmpresa 	:= iif (SubStr(cNumEmp,1,2) = "01","Caberj", "empresarial")
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa  lista  Previas e medias dos rdas - para melhor analise "

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Comp Previa","RDA ","Grup. Pagto","Rede ","Vl Hist. Hosp." ,"Vl Atual Hosp.","Guias " ,"Vl Hist. Ambul.","Vl Atual Ambul.","Guias"	,"Vl Hist. Odont." ,"Vl Atual Odont.","Guias ","Vl Total","Guias"}   
                                                                                                                                                    
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
nOrdernar    := mv_par08
nMesesM      := mv_par09                                       

  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel   
   if nGeraEx == 1 
      DlgToExcel({{"ARRAY","Este programa  lista  Previas e medias dos rdas - para melhor analise " ,aCabec1,aDados1}})   
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

cQuery := " SELECT zzp.ZZP_ANOPAG||'/'||zzp.ZZP_MESPAG comp , " + CRLF   
cQuery += "        zzp.zzp_codrda rda2 , BAU_TIPPRE REDE , " + CRLF  
cQuery += "        bau_nome NomeRda , " + CRLF 
cQuery += "        bau_grppag || '-' ||b16_descri grppag , " + CRLF 
cQuery += "        ROUND((zzp1.vlrhosp_hi/"+alltrim(str(nMesesM))+"),2) S_HIST_HOSP , " + CRLF
cQuery += "        sum(zzp.zzp_vlinho) vlrhosp_at , " + CRLF 
cQuery += "        sum(zzp_qtinho) qtdahosp , " + CRLF
cQuery += "        ROUND((zzp1.vlramb_hi/"+alltrim(str(nMesesM))+"),2)  S_HIST_AMB ," + CRLF
cQuery += "        sum(zzp.zzp_vlinam) vlramb_at , " + CRLF
cQuery += "        sum(zzp_qtinam) qtdaAmb , " + CRLF
cQuery += "        ROUND((zzp1.vlrod_hi/"+alltrim(str(nMesesM))+"),2)  S_HIST_ODONT , " + CRLF 
cQuery += "        sum(zzp.zzp_vlinod) vlrod_at , " + CRLF
cQuery += "        sum(zzp_qtinod) qtdaOdt , " + CRLF 
cQuery += "        ( sum(zzp.zzp_vlinho) + sum(zzp.zzp_vlinam) + sum(zzp.zzp_vlinod) ) vltot , " + CRLF
cQuery += "        ( sum(zzp_qtinho)     + sum(zzp_qtinam)     + sum(zzp_qtinod)     ) totguias " + CRLF              

cQuery += " FROM " + RetSqlName('ZZP') +" ZZP  , " + RetSqlName('BAU') +" BAU , " + RetSqlName('B16') +" B16 , " + CRLF

cQuery += "      ( SELECT zzp1.zzp_codrda rda , " + CRLF
cQuery += "               sum(zzp1.zzp_vlinho) vlrhosp_hi , " + CRLF 
cQuery += "               sum(zzp1.zzp_vlinam) vlramb_hi  , " + CRLF 
cQuery += "               sum(zzp1.zzp_vlinod) vlrod_hi     " + CRLF
cQuery += "         FROM  " + RetSqlName('ZZP') +" ZZP1 " + CRLF
cQuery += "        WHERE zzp1.ZZP_FILIAL = '  ' AND zzp1.D_E_L_E_T_ = ' ' " + CRLF  

cQuery += "          AND zzp1.ZZP_ANOPAG||zzp1.ZZP_MESPAG BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+",'YYYYMM'), -"+alltrim(str(nMesesM))+"),'YYYYMM') AND TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+",'YYYYMM'), -1),'YYYYMM') " + CRLF   

//cQuery += "          AND zzp1.ZZP_ANOPAG||zzp1.ZZP_MESPAG BETWEEN (TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+",'YYYYMM'), -"+nMesesM+"),'YYYYMM') AND TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+",'YYYYMM'), -1),'YYYYMM')) " + CRLF   
//cQuery += " TEMP_ZZP                                            (TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+",'YYYYMM'), -13         ),'YYYYMM'),    TO_CHAR(ADD_MONTHS(TO_DATE("+cAnoCmp+cMesCmp+",'YYYYMM'), -1),'YYYYMM'),zzp_codrda,zzp_codrda,' ','3') medforodn, "	+ CRLF

cQuery += "          AND zzp1.zzp_status  NOT IN ( 'PCA' , 'CCA' ) " + CRLF  

if  !empty(cCAnalist)                                      
    cQuery += "   and zzp_codana= '"+cCAnalist+ "'" + CRLF    
EndIf 

If nListar = 1
   cQuery += " and ZZP_TIPREM <> 3 " + CRLF
ElseIf nListar = 2
   cQuery += " and ZZP_TIPREM =  3 " + CRLF
endIf  

cQuery += "          AND zzp1.ZZP_CODRDA BETWEEN '"+cRdaDe+"' and '"+cRdaAte+"' " + CRLF 

cQuery += "     GROUP BY zzp1.zzp_codrda ) zzp1 " + CRLF
cQuery += "  WHERE zzp.ZZP_FILIAL = '  '  AND zzp.D_E_L_E_T_ = ' ' " + CRLF 
cQuery += "    AND bau_filial     = '  '  AND bau.D_E_L_E_T_ = ' ' AND bau.R_E_C_D_E_L_ = 0 " + CRLF
cQuery += "    AND b16_filial     = '  '  AND b16.D_E_L_E_T_ = ' ' " + CRLF 
cQuery += "    AND bau_grppag     = b16.B16_CODIGO AND bau_codigo = zzp.ZZP_CODRDA " + CRLF  

cQuery += "    AND zzp.ZZP_ANOPAG||zzp.ZZP_MESPAG = '"+cAnoCmp+cMesCmp +"' " + CRLF  

cQuery += "    AND zzp.zzp_status  NOT IN ( 'PCA' , 'CCA' ) " + CRLF       

if  !empty(cCAnalist)                                      
    cQuery += "   and zzp_codana= '"+cCAnalist+"'" + CRLF    
EndIf 

If nListar = 1
   cQuery += " and ZZP_TIPREM <> 3 " + CRLF
ElseIf nListar = 2
   cQuery += " and ZZP_TIPREM =  3 " + CRLF
endIf  

cQuery += "    AND  zzp.ZZP_CODRDA BETWEEN '"+cRdaDe+"' and '"+cRdaAte+"' " + CRLF 
cQuery += "    AND zzp1.RDA = zzp.ZZP_CODRDA " + CRLF
cQuery += "  GROUP BY zzp.zzp_codrda, bau_nome , bau_grppag , b16_descri ,  zzp.ZZP_ANOPAG, zzp.ZZP_MESPAG , " + CRLF 
cQuery += "        ROUND((zzp1.vlrhosp_hi/"+alltrim(str(nMesesM))+"),2) , " + CRLF
cQuery += "        ROUND((zzp1.vlramb_hi /"+alltrim(str(nMesesM))+"),2) , " + CRLF 
cQuery += "        ROUND((zzp1.vlrod_hi  /"+alltrim(str(nMesesM))+"),2) , " + CRLF
cQuery += "        BAU_TIPPRE " + CRLF

If nOrdernar   ==  1

   cQuery += " Order By  2 " + CRLF // CODRDA

ElseIf nOrdernar   ==  2 

   cQuery += " Order By 5 " + CRLF // GRUPO DE PAGTO
                         
ElseIf nOrdernar   ==  3            

   cQuery += " Order By 3 " + CRLF // REDE       
   
ElseIf nOrdernar   ==  4            

   cQuery += " Order By 15 desc " + CRLF // REDE          
   
EndIf    

 /*

       
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

*/  	
    If Select(cAliastmp) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())  
       
        aaDD(aDados1,{(cAliastmp)->COMP         ,;    
                      (cAliastmp)->RDA2+' - '+(cAliastmp)->NOMERDA  ,;            
                      (cAliastmp)->REDE         ,; 
                      (cAliastmp)->GRPPAG       ,;
                      (cAliastmp)->S_HIST_HOSP  ,; 
                      (cAliastmp)->vlrhosp_at   ,;
                      (cAliastmp)->qtdahosp     ,;
                      (cAliastmp)->S_HIST_AMB   ,;
                      (cAliastmp)->vlramb_at    ,;
                      (cAliastmp)->qtdaAmb      ,;
                      (cAliastmp)->S_HIST_ODONT ,;
                      (cAliastmp)->vlrod_at     ,;
                      (cAliastmp)->qtdaOdt      ,;
                      (cAliastmp)->vltot        ,;
                      (cAliastmp)->totguias })    
	                                                                                                            
       (cAliastmp)->(dbSkip()) 	   
     EndDo	                   
Return                    

*************************************************************************************************************  
Static Function fGeraRel

Local oReport 
Private cPerg		:= "CABR213"  
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
oReport	:= TReport():New("CABR213","Listagem Previas dos Rda's , Ordenados pelo maiores ofensores do custo",, {|oReport| ReportPrt(oReport)},"Listagem Previas dos Rda's , Ordenados pelo maiores ofensores do custo ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem Previas dos Rda's , Ordenados pelo maiores ofensores do custo  ",,aOrdem)             

   TRCell():New(oDPJ ,'COMPTE'        		,/*TABELA*/	,'Comp Previa'     ,/*Picture*/   		,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'IDRDA'	     	    ,/*TABELA*/	,'RDA        '     ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'GRPPAG'	     	    ,/*TABELA*/	,'Grup. Pagto  '   ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'REDE'	       		,/*TABELA*/	,'Rede '	       ,/*Picture*/ 	    ,03				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 

   TRCell():New(oDPJ ,'VLHHOS'	     		,/*TABELA*/	,'Vl Hist. Hosp.'  ,"@E 9,999,999.99"   ,13				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'VLAHOS'				,/*TABELA*/	,'Vl Atual Hosp.'  ,"@E 9,999,999.99"   ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'QTDHOS'				,/*TABELA*/	,'Guias '          ,"@E      999,999"   ,09			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 

   TRCell():New(oDPJ ,'VLHAMB'	     		,/*TABELA*/	,'Vl Hist. Ambul.' ,"@E 9,999,999.99"   ,13				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'VLAAMB'				,/*TABELA*/	,'Vl Atual Ambul.' ,"@E 9,999,999.99"   ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'QTDAMB'				,/*TABELA*/	,'Guias '          ,"@E      999,999"   ,09			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)  
   
   TRCell():New(oDPJ ,'VLHODN'	     		,/*TABELA*/	,'Vl Hist. Odont.' ,"@E 9,999,999.99"   ,13				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'VLAODN'				,/*TABELA*/	,'Vl Atual Odont.' ,"@E 9,999,999.99"   ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'QTDODN'				,/*TABELA*/	,'Guias '          ,"@E      999,999"   ,09			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   
   TRCell():New(oDPJ ,'VLTOT'				,/*TABELA*/	,'Vl Total '       ,"@E 99,999,999.99"  ,14			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'QTDTOT'				,/*TABELA*/	,'Guias '          ,"@E     9,999,999"  ,09			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   
 
   oBreak01     := TRBreak():New(oDPJ,oDPJ:Cell("COMPTE"),"Totais    "	,.F.)  

   lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
   lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
  TRFunction():New(oDPJ:Cell("VLHHOS")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
  TRFunction():New(oDPJ:Cell("VLAHOS")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
  TRFunction():New(oDPJ:Cell("QTDHOS")  	    ,NIL,"SUM"			,oBreak01,,"@E    99,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
  
  TRFunction():New(oDPJ:Cell("VLHAMB")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
  TRFunction():New(oDPJ:Cell("VLAAMB")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
  TRFunction():New(oDPJ:Cell("QTDAMB")  	    ,NIL,"SUM"			,oBreak01,,"@E    99,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 
  TRFunction():New(oDPJ:Cell("VLHODN")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
  TRFunction():New(oDPJ:Cell("VLAODN")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
  TRFunction():New(oDPJ:Cell("QTDODN")  	    ,NIL,"SUM"			,oBreak01,,"@E    99,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
  
  TRFunction():New(oDPJ:Cell("VLTOT")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 99,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
  TRFunction():New(oDPJ:Cell("QTDTOT")  	    ,NIL,"SUM"			,oBreak01,,"@E    99,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 


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
 
   oDPJ:Cell('COMPTE'  	 ):SetValue(aDados1[i][1])     
   oDPJ:Cell('IDRDA' 	 ):SetValue(aDados1[i][2])
   oDPJ:Cell('GRPPAG' 	 ):SetValue(aDados1[i][4])       
   oDPJ:Cell('REDE'      ):SetValue(aDados1[i][3])  
   
   oDPJ:Cell('VLHHOS'    ):SetValue(aDados1[i][5])                                                        
   oDPJ:Cell('VLAHOS' 	 ):SetValue(aDados1[i][6])                                                                                                                       
   oDPJ:Cell('QTDHOS'  	 ):SetValue(aDados1[i][7])
                                                    
   oDPJ:Cell('VLHAMB'    ):SetValue(aDados1[i][8])                                                        
   oDPJ:Cell('VLAAMB' 	 ):SetValue(aDados1[i][9])                                                                                                                       
   oDPJ:Cell('QTDAMB'  	 ):SetValue(aDados1[i][10])
   
   oDPJ:Cell('VLHODN'    ):SetValue(aDados1[i][11])                                                        
   oDPJ:Cell('VLAODN' 	 ):SetValue(aDados1[i][12])                                                                                                                       
   oDPJ:Cell('QTDODN'  	 ):SetValue(aDados1[i][13])
                                                                                                                                                                
   oDPJ:Cell('VLTOT'  	 ):SetValue(aDados1[i][14])                                                                                                                                                         
   oDPJ:Cell('QTDTOT' 	 ):SetValue(aDados1[i][15])                                                                                                                                                         
    
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
PutSx1(cPerg,"06",OemToAnsi("Selecionar  ")         ,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Caberj","","","","Perfeitura","","","Totdos","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"07",OemToAnsi("Gerar Excel ")         ,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"08",OemToAnsi("Ordernar Por ")        ,"","","mv_ch8","N",01,0,0,"C","","","","","mv_par08","Rda","","","","Grupo Pgto ","","","Rede","","","Maior Ofensores","","","","","",{},{},{}) 
PutSx1(cPerg,"09",OemToAnsi("Qtda de Meses P/ Media ") ,"","","mv_ch9","N",02,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{}) 


//PutSx1(cPerg,"10",OemToAnsi("Ordernar Por ")        ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Lote de pagamento","","","","Rda","","","Tit. Pagto","","","","","","","","",{},{},{}) 
Pergunte(cPerg,.F.)

Return

