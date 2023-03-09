
#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"   


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR153   º Autor ³Altamiro              º Data ³ 26/09/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para Litar log de geração de lotes de pagamento     º±±
±±º          ³ RDA                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR153

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR153"
Private cTitulo     := "Listagem de log de geração de Lote pagamento X Rda  "        

Private cAliastmp 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa  lista  log de geração de Lote pagamento X Rda  "

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"Lote Custo" , "Cod. Rda" , "Cod. Fornecedor" , "Nome Fornecedor" , "Nome Operador " , "Dt Geração" , "Hora geração", "Titulo" ,"Vlr bruto" , "Saldo","Dt. Baixa" }    
                                                                                                                                                     
private Descric := ' '                                                                                                         
	
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cNumLotDe    := mv_par01
cMeslotDe    := mv_par02 
cAnolotDe    := mv_par03
cNumLotAte   := mv_par04
cMeslotAte   := mv_par05 
cAnolotAte   := mv_par06
cCodRdaDe    := mv_par07
cCodRdaAte   := mv_par08     

dDtGerDe     := mv_par09
dDtGerAte    := mv_par10    

nGeraEx	     := mv_par11        
nOrder       := mv_par12                                              

  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel   
   if nGeraEx == 1 
      DlgToExcel({{"ARRAY","Listagem de log de geração de Lote pagamento X Rda  " ,aCabec1,aDados1}})   
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
cquery := CRLF+" SELECT E2_PLLOTE , E2_CODRDA , E2_FORNECE , E2_NOMFOR , BAF_NOMOPE , BAF_DTDIGI , BAF_HRDIGI , "
cquery += CRLF+" e2_prefixo, e2_num, e2_tipo , (e2_valor+e2_irrf+e2_iss+e2_inss+e2_vretcof+e2_vretpis+e2_vretcsl) valor , e2_saldo, e2_baixa  "
cquery += CRLF+"   FROM "+ RetSqlName("BAF") +" BAF, " + RetSqlName("SE2") +" SE2  "
cquery += CRLF+"  WHERE BAF_FILIAL = '"+xFilial("BAF")+ "' "      
cquery += CRLF+"    AND  E2_FILIAL = '"+xFilial('SE2')+ "'"	


    cquery += CRLF+"    AND BAF_ANOLOT||BAF_MESLOT ||BAF_NUMLOT >= '"+cAnolotDe+cMeslotDe+cNumLotDe+"'"
    cquery += CRLF+"    AND BAF_ANOLOT||BAF_MESLOT ||BAF_NUMLOT <= '"+cAnolotAte+cMeslotAte+cNumLotAte+"'"
    cquery += CRLF+"    AND e2_emissao >= '"+dDtGerDe +"' AND e2_emissao <= '"+dDtGerAte+"' "

cquery += CRLF+"    AND E2_CODRDA  >= '"+cCodRdaDe+"'"  
cquery += CRLF+"    AND E2_CODRDA  <= '"+cCodRdaAte+"'"  
cquery += CRLF+"    AND BAF_ANOLOT || BAF_MESLOT|| BAF_NUMLOT = E2_PLLOTE "
cquery += CRLF+"    AND E2_ORIGEM = 'PLSMPAG' AND E2_TIPO = 'FT' " 
cquery += CRLF+"    AND BAF.D_E_L_E_T_ = ' ' and SE2.D_E_L_E_T_ = ' '  " 
iF nOrder == 1
   cquery += CRLF+"  ORDER BY  1,2 "
Elseif nOrder == 2   
   cquery += CRLF+"  ORDER BY  2,1 " 
Else                                 
   cquery += CRLF+"  ORDER BY  8,9,10,1,2 "   
EndIf   

/////////////////////////////////////////*
	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())   
      aaDD(aDados1,{(cAliastmp)->E2_PLLOTE  ,;                
                    (cAliastmp)->E2_CODRDA  ,;                
                    (cAliastmp)->E2_FORNECE ,;
                    (cAliastmp)->E2_NOMFOR  ,;
                    (cAliastmp)->BAF_NOMOPE ,;  
    		   stod((cAliastmp)->BAF_DTDIGI),;                                                                                                   
		  If (empty((cAliastmp)->BAF_HRDIGI),"00:00" , substr((cAliastmp)->BAF_HRDIGI,1,2)+":"+substr((cAliastmp)->BAF_HRDIGI,3,2)) ,;
		            (cAliastmp)->e2_prefixo+(cAliastmp)->e2_num+(cAliastmp)->e2_tipo , ;
		            (cAliastmp)->valor ,; 
		            (cAliastmp)->e2_saldo  ,; 
		            stod((cAliastmp)->e2_baixa) })                                                                                                     
       (cAliastmp)->(dbSkip()) 	   
     EndDo	                   
Return                    

*************************************************************************************************************  
Static Function fGeraRel

Local oReport 
Private cPerg		:= "CABR153"  
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
oReport	:= TReport():New("CABR153","Listagem de log de geração de Lote pagamento X Rda    ",, {|oReport| ReportPrt(oReport)},"Listagem de log de geração de Lote pagamento X Rda   ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem de log de geração de Lote pagamento X Rda  ",,aOrdem)             

   TRCell():New(oDPJ ,'LOTE'        		,/*TABELA*/	,'Lote Custo'      ,/*Picture*/   		,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'RDA'	        		,/*TABELA*/	,'Cod. Rda'	       ,/*Picture*/ 	    ,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'FORNECE'	     		,/*TABELA*/	,'Cod. Fornecedor ',/*Picture*/ 	    ,06				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'NFORNECE'	     	,/*TABELA*/	,'Nome Fornecedor' ,/*Picture*/ 	    ,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'NOPERAD'				,/*TABELA*/	,'Nome Operador '  ,/*Picture*/  	    ,30			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'DTGERA'	     		,/*TABELA*/	,'Dt Geração'	   ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'HRGERA'	     		,/*TABELA*/	,'Hora geração'	   ,/*"@E 99:99"	*/  ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'TITULO'	     		,/*TABELA*/	,'Tit. Pagto'	   ,/*"@E 99:99"	*/  ,16				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'VLRTIT'				,/*TABELA*/	,'Vlr Tit. Finan.'  ,"@E 9,999,999.99"  ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'SALTIT'				,/*TABELA*/	,'Saldo Tit.Finan.' ,"@E 9,999,999.99"  ,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		) 
   TRCell():New(oDPJ ,'DTBAIXA'	     		,/*TABELA*/	,'Dt Baixa '	   ,/*Picture*/ 	    ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
 
///oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell(" "),"Total Geral   "	,.F.)  

//lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
//lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
//   TRFunction():New(oDPJ:Cell("VLRTPF")    	    ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
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
 
   oDPJ:Cell('LOTE'  	 ):SetValue((aDados1[i][1]))     
   oDPJ:Cell('RDA'   	 ):SetValue((aDados1[i][2]))
   oDPJ:Cell('FORNECE' 	 ):SetValue((aDados1[i][3]))       
   oDPJ:Cell('NFORNECE'  ):SetValue((aDados1[i][4]))
   oDPJ:Cell('NOPERAD'   ):SetValue((TRIM(aDados1[i][5])))                                                        
   oDPJ:Cell('DTGERA' 	 ):SetValue((aDados1[i][6]))                                                                                                                       
   oDPJ:Cell('HRGERA'  	 ):SetValue((aDados1[i][7]))                                                                                                                                                         

   oDPJ:Cell('TITULO'  	 ):SetValue((aDados1[i][8]))                                                                                                                                                         
   oDPJ:Cell('VLRTIT'  	 ):SetValue((aDados1[i][9]))                                                                                                                                                         
   oDPJ:Cell('SALTIT'  	 ):SetValue((aDados1[i][10]))                                                                                                                                                         
   oDPJ:Cell('DTBAIXA' 	 ):SetValue((aDados1[i][11]))                                                                                                                                                         
         
    
   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Num. Lote de Pagto De ") 		,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"02",OemToAnsi("Mes  Lote de Pagto De ") 		,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Ano  Lote de Pagto De ") 	    ,"","","mv_ch3","C",04,0,0,"G","","","","","mv_par03","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Num. Lote de Pagto Ate ") 		,"","","mv_ch4","C",04,0,0,"G","","","","","mv_par04","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"05",OemToAnsi("Mes  Lote de Pagto Ate ") 		,"","","mv_ch5","C",02,0,0,"G","","","","","mv_par05","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Ano  Lote de Pagto Ate ")     ,"","","mv_ch6","C",04,0,0,"G","","","","","mv_par06","   ","","","","   ","","","","","","","","","","","",{},{},{})

PutSx1(cPerg,"07",OemToAnsi("Cod Rda De  ") 	            ,"","","mv_ch7","C",06,0,0,"G","","","","","mv_par07","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Cod Rda Ate ") 		        ,"","","mv_ch8","C",06,0,0,"G","","","","","mv_par08","   ","","","","   ","","","","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"09",OemToAnsi("Data Geração De ")            ,"","","mv_ch9","C",06,0,0,"G","","","","","mv_par09","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Data Geração Ate ")           ,"","","mv_ch10","C",06,0,0,"G","","","","","mv_par10","   ","","","","   ","","","","","","","","","","","",{},{},{}) 


PutSx1(cPerg,"11",OemToAnsi("Gerar Excel ") 	            ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"12",OemToAnsi("Ordernar Por ") 	            ,"","","mv_ch12","N",01,0,0,"C","","","","","mv_par12","Lote de pagamento","","","","Rda","","","Tit. Pagto","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return

