#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                                              
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR245   º Autor ³Altamiro              º Data ³ 24/10/17  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Relatorio de Repasse de Custo Operacional - sintetico/analiticoº±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                                                      

User Function CABR274( )

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR274"
Private cTitulo     := "Relatorio de Repasse de Custo Operacional - sintetico/analitico "        
private aDados1     := {} 
private aDados2     := {}
Private cAliastmp 	:= GetNextAlias()             
private faz         := 1

cMsg += " Este programa ira Gerar Relatorio de Repasse de Custo Operacional - sintetico/analitico" + CRLF
cMsg += "  " + CRLF

***************************************************************************    
 
Private  acabec1:={ "Situação"     ,;
                    "Tp senha"     ,;
                    "Senha"        ,;
                    "Usuario"      ,;
                    "Guia"         ,;
                    "Procedimento" ,;
                    "Rda"          ,;
                    "Lote Pagto"   ,;
                    "Lote Fatura " ,;
                    "Vlr Controle" ,;
                    "Vlr Pagto"    ,;
                    "Vlr Cobrado"  ,;
                    "Qtda Guias"   ,;
                    "Tit Cobrança" }
                   

private  Descric := ' '                                                                                                         

  // AjustaSX1(cPerg)
   

   Pergunte(cPerg,.T.)

 //  cDtEntr    := dtos(mv_par01)     
 //  cdata      := substr(cDtEntr,7,2)+'/'+substr(cDtEntr,5,2)+'/'+substr(cDtEntr,1,4)
   cEmpresa   :=Iif(cEmpAnt == '01', 'Caberj', 'Integral')                   
   
   Processa({||Processa1()}, cTitulo, "", .T.)
   


//lexcel	   := .T.    
  
//Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  
  
// faz ecxel

// if lexcel      
         
   DlgToExcel({{"ARRAY","Repasse de Custo Operacional - sintetico/analitico" ,aCabec1,aDados1}})   

// EndIF

fGeraRel2()    
   
MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*
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
*/
Static Function Processa1() 

Local cquery := ''       

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
///////////////////////////////////

  cQuery := CRLF+ "SELECT  decode(trim(Pd2_Lotfat),'',(decode(trim(pd2_lotpag),'' ,'1-Apontado','2-Pago')),'3-Faturado') status , "
  cQuery += CRLF+          "PD2_TPSENH tpsenha , "
  cQuery += CRLF+          "PD2_SENHA  senha, "
  cQuery += CRLF+          "SUBSTR(Trim(PD2_COdEMP||'-'||PD2_MATRIC||'-'||PD2_TPREG ||'-'||PD2_NOMUSR),1,30)  usuario , "
  
  If Mv_par03 == 2
     cQuery += CRLF+          "Pd2_CODOPE || PD2_CODPEG || PD2_NUMERO || PD2_ORIMOV || Pd2_Sequen || Pd2_Codpad GUIA , "
  Else    
     cQuery += CRLF+          " ' ' GUIA , "
  EndIf 
  
  If Mv_par03 == 2
     cQuery += CRLF+          "SUBSTR(trim(pd2_codpro) ||'-'||trim(pd2_despro),1,30) PROCEDIM ,1 qtda , "
  Else    
     cQuery += CRLF+          "' ' PROCEDIM , COUNT(nvl(bd6_vlrtpf,null)) qtda ,"
  EndIf
  
  cQuery += CRLF+          "SUBSTR(pd2_codrda ||'-'||pd2_nomrda,1,30) rda , "
  cQuery += CRLF+          "Pd2_Lotpag  lotpag, "
  cQuery += CRLF+          "Pd2_Lotfat  lotfat, "
  
   cQuery += CRLF+          "BD6_CODPLA  CodPla , "
  
  cQuery += CRLF+          "sum(CASE WHEN Pd2_Lotpag = ' ' THEN 0.00  Else Pd2_valor END) vlrcont, " 
  cQuery += CRLF+          "sum(CASE WHEN Pd2_Lotpag = ' ' THEN 0.00  Else nvl(bd6_vlrpag,0) END) vlrpag, " 
  cQuery += CRLF+          "sum(CASE WHEN Pd2_Lotpag = ' ' THEN 0.00  Else nvl(bd6_vlrtpf,0) END) vlrfat, "
  
  cQuery += CRLF+          " substr(bg9_descri,1,30) EMPDESC , Pd2_TitCob NumTit  "

  cQuery += CRLF+ "  from "+ RetSqlName("PD2") +" PD2 ,"+ RetSqlName("BD6") +" BD6 ,"+ RetSqlName("BG9") +" BG9"
  cQuery += CRLF+ " where pd2_filial    = '"+xFilial('PD2')+ "'  and pd2.d_E_L_E_T_     = ' ' " 
  cQuery += CRLF+ "   and bd6_filial(+) = '"+xFilial('BD6')+ "'  and bd6.d_E_L_E_T_(+)  = ' ' "
  
  cQuery += CRLF+ "   and bG9_filial(+) = '"+xFilial('BG9')+ "'  and BG9.d_E_L_E_T_(+)  = ' ' "
         
  cQuery += CRLF+ "   AND BD6_CODOPE(+) = '0001' " 
  cQuery += CRLF+ "   and bd6_codldp(+) = pd2_codldp "
  cQuery += CRLF+ "   and bd6_codpeg(+) = pd2_codpeg "
  cQuery += CRLF+ "   AND BD6_NUMERO(+) = PD2_NUMERO " 
  cQuery += CRLF+ "   AND BD6_ORIMOV(+) = PD2_ORIMOV "   
  cQuery += CRLF+ "   AND BD6_SEQUEN(+) = PD2_sequen " 
  cQuery += CRLF+ "   and bd6_codpro(+) = pd2_codpro " 
  cQuery += CRLF+ "   and bd6_codemp(+) = pd2_codemp " 
  cQuery += CRLF+ "   and bd6_vlrpag(+) > 0 "
  
  if !empty (trim(mv_par02))
  
      cQuery += CRLF+ "   and PD2_SENHA ='"+trim(mv_par02)+"'
  
  endIf 
      
      cQuery += CRLF+ "   and PD2_COMPTE  <='201912'
  
  if !empty (trim(mv_par01))
  
      cQuery += CRLF+ "   and Pd2_Lotfat  ='"+trim(mv_par01)+"'
  
  endIf 
  
  cQuery += CRLF+ "   and bg9_codint = '0001' and bg9_codigo = PD2_COdEMP "
   
  //cQuery += CRLF+ "  having    COUNT(nvl(bd6_vlrtpf,null)) > 0 "
         
  cQuery += CRLF+ " group by decode(trim(Pd2_Lotfat),'',(decode(trim(pd2_lotpag),'' ,'Apontado','Pago')),'Faturado'),"
  cQuery += CRLF+ "          PD2_TPSENH , "
  cQuery += CRLF+ "          PD2_SENHA  , "
  cQuery += CRLF+ "          PD2_COdEMP||'-'||PD2_MATRIC||'-'||PD2_TPREG ||'-'||PD2_NOMUSR , "
  cQuery += CRLF+ "          pd2_codrda ||'-'||pd2_nomrda , "
  cQuery += CRLF+ "          Pd2_Lotpag  , "
  
  cQuery += CRLF+ "          BD6_CODPLA  , "
  
  cQuery += CRLF+ "          Pd2_Lotfat  ,substr(bg9_descri,1,30) , Pd2_TitCob"
  If Mv_par03 == 2
     cQuery += CRLF+"       ,Pd2_CODOPE || PD2_CODPEG || PD2_NUMERO || PD2_ORIMOV || Pd2_Sequen || Pd2_Codpad , "
     cQuery += CRLF+"        SUBSTR(trim(pd2_codpro) ||'-'||trim(pd2_despro),1,30)  "
  EndIf
  
  cQuery += CRLF+ "          order by 1,4,3 "  
 
////////////////////////////////////////       
	   	
    TCQuery cQuery New Alias (cAliastmp)
      
    dbSelectArea (cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())   

           aaDD(aDados1,{   (cAliastmp)->status   ,;
							(cAliastmp)->tpsenha  ,;     
							(cAliastmp)->senha    ,;     
							(cAliastmp)->usuario  ,;
							(cAliastmp)->guia     ,;     
							(cAliastmp)->Procedim ,;
							(cAliastmp)->rda      ,;
							(cAliastmp)->lotpag   ,;                                                          
							(cAliastmp)->lotfat   ,;     
							(cAliastmp)->vlrcont  ,;                                                                            
							(cAliastmp)->vlrpag   ,;                                                                            
							(cAliastmp)->vlrfat   ,;
							(cAliastmp)->qtda     ,;
							(cAliastmp)->EMPDESC  ,;
							(cAliastmp)->CodPla   ,;
                     (cAliastmp)->NumTit   })                                 
                  
       (cAliastmp)->(dbSkip()) 	   
    
    EndDo	                   
 
Return    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR274"                                                           ¦

Private aOrdem 		:= {}//{'RDA','Ano/Mes'}            
Private lTPageBreak := .T.         

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************

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
Local oDPJ1                

oReport	:= TReport():New("CABR274","Relatorio de Repasse de Custo operacional - sintetico/analitico"  ,, {|oReport| ReportPrt(oReport)},"Relatorio de Acompanhamento de inclusoes e execlições do Sib - Excel - " + mv_par01 )

oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oReport:SetTotalPageBreak(lTPageBreak)

            
 If Mv_par03 == 2 
 oDPJ := TRSection():New(oReport,"Relatorio de Repasse de Custo Operacional - Analitico" ,,aOrdem)  
 
   TRCell():New(oDPJ ,'SITUAC'	        	   ,	,'Situação  '   ,                   ,10  	,,,,,"LEFT" )   
   TRCell():New(oDPJ ,'TPSENH'         		,	,'Tipo Senha'   ,                   ,10 	,,,,,"LEFT"	)  
   TRCell():New(oDPJ ,'SENHA'         		   ,	,'Senha     '   ,                   ,20  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'USUARI'               ,	,'Usuario   '   ,                   ,30  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'GUIA'         		   ,	,'Guia      '   ,                   ,26  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'PROEDI'         		,	,'Procedimento' ,                   ,30  	,,,,,"LEFT"	)    
   TRCell():New(oDPJ ,'RDA'         		   ,	,'Rda       '   ,                   ,30  	,,,,,"LEFT"	)       
   TRCell():New(oDPJ ,'LOTPAG'         		,	,'Lote Pagto'   ,                   ,10  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'LOTFAT'         		,	,'Lote Fatur'   ,                   ,12  	,,,,,"LEFT"	)
//   TRCell():New(oDPJ ,'VLRCON'         		,	,'Vlr Cont. '   ,"@E 999,999.99" 	,10 	,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'VLRPAG'         		,	,'Vlr Pago  '   ,"@E 999,999.99" 	,10 	,,,,,"RIGHT"	)
//   TRCell():New(oDPJ ,'VLRFAT'         		,	,'Vlr Fatur.'   ,"@E 999,999.99" 	,10 	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'QTDA'         		   ,	,'Qtd'          ,"@E 999"     	   ,03 	,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'NUMTIT'         		,	,'Num Titulo  ' ,                   ,17  	,,,,,"LEFT"	) 
  
  Else

oDPJ := TRSection():New(oReport,"Relatorio de Repasse de Custo Operacional - Sintetico" ,,aOrdem)  

   TRCell():New(oDPJ ,'EMPRES'         		,	,'Empresa   '  ,                 ,30  	,,,,,"LEFT"	)    
   TRCell():New(oDPJ ,'PLANO'         	   	,	,'Plano     '  ,                 ,10  	,,,,,"LEFT"	)    
   TRCell():New(oDPJ ,'SITUAC'	          	,	,'Situação  '  ,                 ,10  	,,,,,"LEFT" )   
   TRCell():New(oDPJ ,'TPSENH'         		,	,'Tipo Senha'  ,                 ,10 	,,,,,"LEFT"	)  
   TRCell():New(oDPJ ,'SENHA'          		,	,'Senha     '  ,                 ,20  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'USUARI'               ,	,'Usuario   '  ,                 ,30  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'RDA'            		,	,'Rda       '  ,                 ,30  	,,,,,"LEFT"	)       
   TRCell():New(oDPJ ,'LOTPAG'         		,	,'Lote Pagto'  ,                 ,10  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'LOTFAT'         		,	,'Lote Fatur'  ,                 ,12  	,,,,,"LEFT"	)
//   TRCell():New(oDPJ ,'VLRCON'         		,	,'Vlr Cont. '  ,"@E 999,999.99" 	,10 	,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'VLRPAG'         		,	,'Vlr Pago  '  ,"@E 999,999.99" 	,10 	,,,,,"RIGHT"	)
//   TRCell():New(oDPJ ,'VLRFAT'         		,	,'Vlr Fatur.'  ,"@E 999,999.99" 	,10 	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'QTDA'            		,	,'Qtd'         ,"@E 999"        	,03 	,,,,,"RIGHT"	)  
   TRCell():New(oDPJ ,'NUMTIT'         		,	,'Num Titulo  ',                 ,17  	,,,,,"LEFT"	) 
  EndIf   
   
   
//If Mv_par03 == 2   
   oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("SITUAC")," totais .....   "	,.F.)  
//Else
//  oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("SENHA")," totais .....   "	,.F.)  
//EndIf 

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
   TRFunction():New(oDPJ:Cell("SITUAC")    	  ,NIL,"COUNT"	    	,oBreak01,,"@E 999,999"	        ,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
  // TRFunction():New(oDPJ:Cell("VLRCON")    	  ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
   TRFunction():New(oDPJ:Cell("VLRPAG")    	  ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)    
  // TRFunction():New(oDPJ:Cell("VLRFAT")    	  ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)    
  
**********************  
  
                                                                                                                         
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
  nCont := Len(aDados1)
  
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

If Mv_par03 == 2 

 oDPJ:Cell('SITUAC'):SetValue((aDados1[i][ 1]))    
 oDPJ:Cell('TPSENH'):SetValue((aDados1[i][ 2]))     
 oDPJ:Cell('SENHA'):SetValue((aDados1[i][  3]))   
 oDPJ:Cell('USUARI'):SetValue((aDados1[i][ 4]))    
 oDPJ:Cell('GUIA'):SetValue((aDados1[i][ 5]))    
 oDPJ:Cell('PROEDI'):SetValue((aDados1[i][ 6]))   
 oDPJ:Cell('RDA'):SetValue((aDados1[i][ 7]))      
 oDPJ:Cell('LOTPAG'):SetValue((aDados1[i][ 8]))      
 oDPJ:Cell('LOTFAT'):SetValue((aDados1[i][ 9]))      
// oDPJ:Cell('VLRCON'):SetValue((aDados1[i][10]))    
 oDPJ:Cell('VLRPAG'):SetValue((aDados1[i][11]))  
// oDPJ:Cell('VLRFAT'):SetValue((aDados1[i][12]))  
 oDPJ:Cell('QTDA'):SetValue((aDados1[i][13]))       
 oDPJ:Cell('NUMTIT'):SetValue((aDados1[i][16]))     

Else 

 oDPJ:Cell('EMPRES'):SetValue((aDados1[i][14]))   
 oDPJ:Cell('PLANO'):SetValue((aDados1[i][15]))   
 oDPJ:Cell('SITUAC'):SetValue((aDados1[i][ 1]))    
 oDPJ:Cell('TPSENH'):SetValue((aDados1[i][ 2]))     
 oDPJ:Cell('SENHA'):SetValue((aDados1[i][ 3]))   
 oDPJ:Cell('USUARI'):SetValue((aDados1[i][ 4]))    
 oDPJ:Cell('RDA'):SetValue((aDados1[i][ 7]))      
 oDPJ:Cell('LOTPAG'):SetValue((aDados1[i][ 8]))      
 oDPJ:Cell('LOTFAT'):SetValue((aDados1[i][ 9]))      
// oDPJ:Cell('VLRCON'):SetValue((aDados1[i][10]))    
 oDPJ:Cell('VLRPAG'):SetValue((aDados1[i][11]))  
// oDPJ:Cell('VLRFAT'):SetValue((aDados1[i][12]))  
 oDPJ:Cell('QTDA'):SetValue((aDados1[i][13]))       
 oDPJ:Cell('NUMTIT'):SetValue((aDados1[i][16]))       

EndIf 

   oDPJ:PrintLine()
   
   Next i

   oDPJ:Finish()      

*********************************************************************************


Return  
*********************************************************************************


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

u_CABASX1(cPerg,"01",OemToAnsi("Lote de Cobrança ")   	         ,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
u_CABASX1(cPerg,"02",OemToAnsi("Senha            ")              ,"","","mv_ch2","C",2,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{}) 
u_CABASX1(cPerg,"03",OemToAnsi("Tipo Relatorio   ")              ,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sintetico","","","","Analitico","","","","","","","","","","","",{},{},{}) 


Pergunte(cPerg,.F.)

Return

