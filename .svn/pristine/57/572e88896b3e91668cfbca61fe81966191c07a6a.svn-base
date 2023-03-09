
#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"   


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR085   º Autor ³Altamiro              º Data ³ 01/10/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para importacao e Critica de NF carioca             º±±
±±º          ³ conforme arquivo importado do site da receita municipal    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR145

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR145"
Private cTitulo     := "Listagem de coparticipação alocado por competencia de custo "        

Private cAliastmp 	:= GetNextAlias()
                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer listagem de de coparticipação alocado por competencia de custo "

***************************************************************************    
 
Private  aDados1     := {}       
Private  acabec1     :={"COD OPERADORA" , "COD EMPRESA" , "MATRICULA" , "TIP REG" , "DIGITO" , "DATA PROCEDIMENTO" , "NOME USUARIO" , "COD RDA" , "NOME RDA" , "DESC. PROCEDIMENTO" ,"VLR COPART" , "VLRTAD" ,"NUM IMPRESSO" ,"COD OPERADORA" ,"lOCAL DIG" ,"PEG"  ,"NUMERO GUIA" ,"ORIG.MOV" ,"SEQUEN",;                                                                                                     
		   		        "COD PROCED" , "NUM. LOTE" , "OPER. ORIGEM" , "ANO FAT" , "MES FAT" , "YMTREP" , "COD. RDA" , "TIP PESSOA RDA" , "NOME RDA" , "PREFIXO" , "NUM TIT" , "TIPO TIT" , "DT. EMISSAO " , "BAIXA", "COMPT.CUSTO" , "DT. DIGITAÇÃO", "Guia Origem"}    
private Descric := ' '                                                                                                         
 	
  	  
AjustaSX1(cPerg)

Pergunte(cPerg,.T.) 

cNumLotFat  := mv_par01
cEmpDe      := mv_par02 
cEmpAte     := mv_par03
cTpRel      := mv_par04
cGeraEx	    := mv_par05   
cLoteCustD  := mv_par06   
cLoteCustA  := mv_par07  
cTitulo     := "Listagem de coparticipação alocado por competencia de custo - lote de faturamento " + cNumLotFat 
cEmpresa    := Iif(cEmpAnt == '01','C','I') 
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel   
if len(adados1) > 0
   if cTpRel == 1
      aSort( aDados1,,,{|x,y| x[1] < y[1]} )
   else                                     
      aSort( aDados1,,,{|x,y| x[3] < y[3]} )        
   endIf   
   if cGeraEx == 1 
      DlgToExcel({{"ARRAY","Listagem de coparticipação alocado por competencia de custo - lote de faturamento " + cNumLotFat ,aCabec1,aDados1}})   
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
if cTpRel == 2  
cquery := CRLF+" SELECT BD6_CODOPE, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO, bd6_dtdigi, bd6_guiori,"
cquery += CRLF+"        BD6_NOMUSR, BD6_CODRDA, BD6_NOMRDA, BD6_DESPRO, BD6_VLRTPF, BD6_VLRTAD, BD6_NUMIMP, "
cquery += CRLF+"        BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPRO, "
cquery += CRLF+"        BD6_NUMLOT ,BDH_OPEORI ||' - ' || BA0_NOMINT OPEORI, BDH_ANOFT , BDH_MESFT, BA1_YMTREP, "
cquery += CRLF+"        BAU_CODIGO, BAU_TIPPE, BAU_NOME , BDH_PREFIX , BDH_NUMTIT , BDH_TIPTIT , e1_emissao, e1_baixa " 
else 
cquery := CRLF+" SELECT SUM(BD6_VLRTPF) BD6_VLRTPF,SUBSTR(BD6_NUMLOT,1,6) BD6_NUMLOT " 

endif                   
cquery += CRLF+"   FROM "+ RetSqlName("BDH") +" BDH, "+ RetSqlName("BD6") +" BD6, "+ RetSqlName("BA1") +" Ba1, " 
cquery += CRLF+"        "+ RetSqlName("BAU") + " BAU, "+ RetSqlName("BA0") + " BA0, "+ RetSqlName("SE1") +" SE1  "
          
cquery += CRLF+"  WHERE BDH_OPEFAT = '0001'"
cquery += CRLF+"    AND BDH_NUMFAT = '0001"+cNumLotFat+"' "
cquery += CRLF+"    AND BDH_OPEORI = '0001' "
cquery += CRLF+"    AND BDH_CODINT = '0001' "                         
If !empty(mv_par03) 
   cquery += CRLF+"    AND BDH_CODEMP >= '"+mv_par02 +"' AND BDH_CODEMP <= '"+mv_par03 +"'"
EndIf
cquery += CRLF+"    AND BDH_FILIAL = '"+xFilial("BDH")+ "' "      
cquery += CRLF+"    AND BA0_FILIAL = '"+xFilial('BA0')+ "'"	
cquery += CRLF+"    AND BA1_FILIAL = '"+xFilial('BA1')+ "'"    
cquery += CRLF+"    AND BA1_CODINT = BDH_CODINT "
cquery += CRLF+"    AND BA1_CODEMP = BDH_CODEMP "
cquery += CRLF+"    AND BA1_MATRIC = BDH_MATRIC "
cquery += CRLF+"    AND BA1_TIPREG = BDH_TIPREG "
cquery += CRLF+"    AND TRIM(ba0_codide)||TRIM(ba0_codint) = bdh_opeori  "
cquery += CRLF+"    AND BD6_FILIAL = '" + xFilial('BD6') + "' "      
cquery += CRLF+"    AND BD6_OPEUSR = BDH_CODINT "
cquery += CRLF+"    AND BD6_CODEMP = BDH_CODEMP "
cquery += CRLF+"    AND BD6_MATRIC = BDH_MATRIC " 
cquery += CRLF+"    AND BD6_TIPREG = BDH_TIPREG " 
cquery += CRLF+"    AND BD6_ANOPAG = BDH_ANOFT "
cquery += CRLF+"    AND BD6_MESPAG = BDH_MESFT "
cquery += CRLF+"    AND BD6_SEQPF =  BDH_SEQPF "
cquery += CRLF+"    AND BD6_NUMSE1 = BDH_NUMSE1 "          
cquery += CRLF+"    AND BD6_PREFIX = BDH_PREFIX AND  BD6_NUMTIT = BDH_NUMTIT AND   BD6_PARCEL = BDH_PARCEL AND  BD6_TIPTIT = BDH_TIPTIT "
cquery += CRLF+"    AND BAU_FILIAL = '" + xFilial('BAU') + "' " 
cquery += CRLF+"    AND BAU_CODIGO = BD6_CODRDA "
cquery += CRLF+"    AND BA1.D_E_L_E_T_ = ' ' AND BDH.D_E_L_E_T_ = ' ' AND BD6.D_E_L_E_T_ = ' ' AND BAU.D_E_L_E_T_ = ' ' AND BA0.D_E_L_E_T_ = ' ' "
cquery += CRLF+"    AND E1_FILIAL = '" + xFilial('SE1') + "' AND SE1.D_E_L_E_T_ = ' ' "
cquery += CRLF+"    AND E1_PREFIXO = BDH_PREFIX AND E1_NUM = BDH_NUMTIT AND E1_TIPO = BDH_TIPTIT "  

//cquery += CRLF+"        AND E1_EMISSAO >= '01012014' AND E1_EMISSAO <= '31012014' 
if cTpRel == 2     
   cquery += CRLF+"        AND BD6_NUMLOT >= '"+cLoteCustD+"' AND BD6_NUMLOT <= '"+cLoteCustA+"'   "
EndIf   

if cTpRel == 1  

cquery += CRLF+" GROUP BY SUBSTR(BD6_NUMLOT,1,6) " 
cquery += CRLF+"  ORDER BY SUBSTR(BD6_NUMLOT,1,6)  "
else
cquery += CRLF+"  ORDER BY BD6_NOMUSR  "

endif             

MEMOWRITE("C:\TEMP\CABR145.SQL",cquery)

/////////////////////////////////////////*
	   	
    If Select((cAliastmp)) <> 0 
       (cAliastmp)->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias (cAliastmp)  
    
    dbSelectArea(cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())       
    if cTpRel == 1              
       
           aaDD(aDados1,{substr((cAliastmp)->BD6_NUMLOT,1,6)      ,;
                         (cAliastmp)->BD6_VLRTPF      })
       /*If (nAscan:=Ascan(aDados1, {|e| e[1] == substr((cAliastmp)->BD6_NUMLOT,1,6) })) == 0
	       aaDD(aDados1,{substr((cAliastmp)->BD6_NUMLOT,1,6)      ,;
                         (cAliastmp)->BD6_VLRTPF      })                           
  	   Else
    	    aDados1[nAscan,2]+=(cAliastmp)->BD6_VLRTPF 
       Endif	*/
    Else 
      aaDD(aDados1,{(cAliastmp)->BD6_CODOPE ,;                
                    (cAliastmp)->BD6_CODEMP ,;                
                    (cAliastmp)->BD6_MATRIC ,;
                    (cAliastmp)->BD6_TIPREG ,;
                    (cAliastmp)->BD6_DIGITO ,;  
    		   stod((cAliastmp)->BD6_DATPRO),;                                                                                                     // 2
				    (cAliastmp)->BD6_NOMUSR       ,;                                                                                                     // 3
				    (cAliastmp)->BD6_CODRDA       ,;                                                                                                     // 4
				    (cAliastmp)->BD6_NOMRDA       ,;                                                                                                     // 5
				    (cAliastmp)->BD6_DESPRO       ,;                                                                                                     // 6
				    (cAliastmp)->BD6_VLRTPF       ,;                                                                                                     // 7
				    (cAliastmp)->BD6_VLRTAD       ,;                                                                                                     // 8
				    (cAliastmp)->BD6_NUMIMP       ,;                                                                                                     // 9
				    (cAliastmp)->BD6_CODOPE       ,;                                                                                                     //10
				    (cAliastmp)->BD6_CODLDP       ,;                                                                                                     //11
				    (cAliastmp)->BD6_CODPEG       ,;                                                                                                     //12
				    (cAliastmp)->BD6_NUMERO       ,;                                                                                                     //13
				    (cAliastmp)->BD6_ORIMOV       ,;                                                                                                     //14
				    (cAliastmp)->BD6_SEQUEN       ,;                                                                                                     //15
				    (cAliastmp)->BD6_CODPRO       ,;                                                                                                     //16
		            (cAliastmp)->BD6_NUMLOT       ,;                                                                                                     //17
				    (cAliastmp)->OPEORI           ,;                                                                                                     //18
				    (cAliastmp)->BDH_ANOFT        ,;                                                                                                     //19
				    (cAliastmp)->BDH_MESFT        ,;                                                                                                     //20
				    (cAliastmp)->BA1_YMTREP       ,;                                                                                                     //21
				    (cAliastmp)->BAU_CODIGO       ,;                                                                                                     //22
				    (cAliastmp)->BAU_TIPPE        ,;                                                                                                     //23
				    (cAliastmp)->BAU_NOME         ,;                                                                                                     //24
				    (cAliastmp)->BDH_PREFIX       ,;                                                                                                     //25
				    (cAliastmp)->BDH_NUMTIT       ,;                                                                                                     //26
				    (cAliastmp)->BDH_TIPTIT       ,;                                                                                                     //27
				    stod((cAliastmp)->e1_emissao) ,;                                                                                                     //28
				    stod((cAliastmp)->e1_baixa)   ,;
				    substr((cAliastmp)->BD6_NUMLOT ,1,6) ,;
				    stod((cAliastmp)->bd6_dtdigi),;
				    (cAliastmp)->bd6_guiori })                                                                                                     
	        endIf 
       (cAliastmp)->(dbSkip()) 	   
     EndDo	                   
Return                    

*************************************************************************************************************  
Static Function fGeraRel

Local oReport 
Private cPerg		:= "CABR145"  
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
oReport	:= TReport():New("CABR145","Listagem de coparticipação alocado por competencia de custo  - lote de fatuaramento " + cNumLotFat,, {|oReport| ReportPrt(oReport)},"Listagem de coparticipação alocado por competencia de custo - lote de fatuaramento " + cNumLotFat)
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem de coparticipação alocado por competencia de custo - lote de fatuaramento " + cNumLotFat ,,aOrdem)             

if cTpRel == 1       
   TRCell():New(oDPJ ,'LOTE'				,/*TABELA*/	,'Num Lote'	 				,/*Picture*/   				,15				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'VLRTPF'				,/*TABELA*/	,'Vlr. Coparte' 	    	,"@E 99,999,999.99"  		,20			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
Else 
   TRCell():New(oDPJ ,'LOTE'        		,/*TABELA*/	,'Lote Custo'      ,/*Picture*/   		,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'USUARIO'	    		,/*TABELA*/	,'uSUARIO ' 	   ,/*Picture*/   	    ,48				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'RDA'	        		,/*TABELA*/	,'Ident.Rda'	   ,/*Picture*/ 	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'GUIA'	     		,/*TABELA*/	,'Ident.Guia'	   ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
   TRCell():New(oDPJ ,'PROCED'	     		,/*TABELA*/	,'Procedimento'	   ,/*Picture*/ 	    ,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'VLRTPF'				,/*TABELA*/	,'Vlr. Coparte'    ,"@E 9,999,999.99"  	,13			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
   TRCell():New(oDPJ ,'TITREC'	     		,/*TABELA*/	,'Tit.Receb.'	   ,/*Picture*/ 	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)                
   TRCell():New(oDPJ ,'DTEMIS'	     		,/*TABELA*/	,'Dt.Emissao'	   ,/*Picture*/ 	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ ,'DTBX'	     		,/*TABELA*/	,'Dt. Baixa '	   ,/*Picture*/ 	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
  
EndIf 
 
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
if cTpRel == 1       
   oDPJ:Cell('LOTE'	 		):SetValue((aDados1[i][1]))     
   oDPJ:Cell('VLRTPF'		):SetValue((aDados1[i][2]))    
Else               
   oDPJ:Cell('LOTE'  	 ):SetValue((aDados1[i][21]))     
   oDPJ:Cell('USUARIO'	 ):SetValue((aDados1[i][1])+'.'+(aDados1[i][2])+'.'+(aDados1[i][3])+'.'+(aDados1[i][4])+'-'+(aDados1[i][5])+' - '+(aDados1[i][7]))
   oDPJ:Cell('RDA'	  	 ):SetValue((aDados1[i][8])+' - '+(aDados1[i][9]))       
   oDPJ:Cell('GUIA'  	 ):SetValue((aDados1[i][15])+'.'+(aDados1[i][16])+'.'+(aDados1[i][17])+'.'+(aDados1[i][18])+'-'+(aDados1[i][19]))
   oDPJ:Cell('PROCED'  	 ):SetValue((TRIM(aDados1[i][20]))+' - '+(aDados1[i][10]))                                                        
   oDPJ:Cell('VLRTPF' 	 ):SetValue((aDados1[i][11]))                                                                                                                       
   oDPJ:Cell('TITREC'  	 ):SetValue((aDados1[i][29])+'.'+(aDados1[i][30])+'.'+(aDados1[i][31]))                                                                                                                                                         
   oDPJ:Cell('DTEMIS' 	 ):SetValue((aDados1[i][32]))                                                                                                                       
   oDPJ:Cell('DTBX' 	 ):SetValue((aDados1[i][33]))                                                                                                                       
EndIf                 
    
   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Lote de Cobrança ") 		,"","","mv_ch1","C",08,0,0,"G","","","","","mv_par01","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"02",OemToAnsi("Empresa De  ") 		    ,"","","mv_ch2","C",06,0,0,"G","","","","","mv_par02","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Empresa Ate  ") 		    ,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","   ","","","","   ","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Tipo de Relatiorio ") 	    ,"","","mv_ch4","N",01,0,0,"C","","","","","mv_par04","Sintetico ","","","","Analitico","","","","","","","","","","","",{},{},{})  
//PutSx1(cPerg,"02",OemToAnsi("Tipo de Relatiorio ") 	    ,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Sintetico ","","","","Analitico","","","Ambos","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"05",OemToAnsi("Gerar Excel ") 	        ,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"06",OemToAnsi("Lote de Custo De ") 		,"","","mv_ch6","C",10,0,0,"G","","","","","mv_par06","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"07",OemToAnsi("Lote de Custo Ate") 		,"","","mv_ch7","C",10,0,0,"G","","","","","mv_par07","   ","","","","   ","","","","","","","","","","","",{},{},{}) 
Pergunte(cPerg,.F.)

Return

