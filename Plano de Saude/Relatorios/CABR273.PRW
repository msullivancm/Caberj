#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                                              
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR245   º Autor ³Altamiro              º Data ³ 24/10/17  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Repasse de Custo Operacional                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                                                      

User Function CABR273( )

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR273"
Private cTitulo     := "Relatorio de Repasse de Custo Operacional"        
private aDados1     := {} 
private aDados2     := {}
Private cAliastmp 	:= GetNextAlias()             
private faz         := 1

cMsg += " Este programa ira Gerar Relatorio de Repasse de Custo Operacional" + CRLF
cMsg += "  " + CRLF

***************************************************************************    
 
Private  acabec1:={ "Usuario"      ,;
                    "Tp senha"     ,;
                    "Senha"        ,;
                    "Titulo"       ,;
                    "Emissao"      ,;
                    "Vencimento"   ,;
                    "Baixa "       ,;
                    "Vlr Titulo"   ,;
                    "Saldo Titulo" ,;
                    "Valor Custo"  ,;
                    "Valor Cobrado",;
                    "Qtda Guias"   ,;
                    "Empresa"      }
                   

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
         
   DlgToExcel({{"ARRAY","Repasse  de Custo Operacional" ,aCabec1,aDados1}})   

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

	cQuery := CRLF+ "select pd2_codemp ||'.'||pd2_matric ||'.'||pd2_tpreg ||' - ' ||pd2_nomusr usuario , "
	cQuery += CRLF+ "       pd2_tpsenh tiposenha ,  pd2_senha senha,   " 
	cQuery += CRLF+ "       e1_prefixo ||e1_num || e1_tipo  Titulo , "
	cQuery += CRLF+ "       substr(e1_emissao,7,2)||'/'||substr(e1_emissao,5,2)||'/'||substr(e1_emissao,1,4)emissao , "
	cQuery += CRLF+ "       substr(e1_vencrea,7,2)||'/'||substr(e1_vencrea,5,2)||'/'||substr(e1_vencrea,1,4)Venc_real , "
	cQuery += CRLF+ "       substr(e1_baixa,7,2)  ||'/'||substr(e1_baixa,5,2)  ||'/'||substr(e1_baixa,1,4)baixa , "
	cQuery += CRLF+ "       e1_valor vlrtit, e1_saldo saldotit , " 
	cQuery += CRLF+ "       sum(bd6_vlrtpf) custo ,  sum (pd2_valor) vlrcob , count(*) Qtda , substr(bg9_descri,1,30) EMPDESC" 
	cQuery += CRLF+ "  from "+ RetSqlName("PD2") +" PD2 ,"+ RetSqlName("BD6") +" BD6 , "+ RetSqlName("SE1") +" SE1 , "+ RetSqlName("BG9") +" BG9 "
	cQuery += CRLF+ " where pd2_filial = '"+xFilial('PD2')+ "'  and pd2.d_E_L_E_T_  = ' ' " 
	cQuery += CRLF+ "   and bd6_filial = '"+xFilial('BD6')+ "'  and bd6.d_E_L_E_T_  = ' ' "
	cQuery += CRLF+ "   and e1_filial  = '"+xFilial('SE1')+ "'  and se1.d_E_L_E_T_ = ' ' "
    cQuery += CRLF+ "   and bg9_filial = '"+xFilial('BG9')+ "'  and BG9.d_E_L_E_T_  = ' ' "
	
	cQuery += CRLF+ "   AND BD6_CODOPE = '0001' "
	cQuery += CRLF+ "   and bd6_codldp = pd2_codldp "
	cQuery += CRLF+ "   and bd6_codpeg = pd2_codpeg "
	cQuery += CRLF+ "   AND BD6_NUMERO = PD2_NUMERO "
	cQuery += CRLF+ "   AND BD6_ORIMOV = PD2_ORIMOV " 
	cQuery += CRLF+ "   AND BD6_SEQUEN = PD2_sequen "
	cQuery += CRLF+ "   and bd6_codpro = pd2_codpro " 
	cQuery += CRLF+ "   and bd6_codemp = pd2_codemp " 
	cQuery += CRLF+ "   and bd6_vlrpag > 0 "
	cQuery += CRLF+ "   and bd6_prefix = e1_prefixo " 
	cQuery += CRLF+ "   and bd6_numtit = e1_num     " 
   	cQuery += CRLF+ "   and bd6_parcel = e1_parcela " 
   	cQuery += CRLF+ "   and bd6_tiptit = e1_tipo    " 
   	IF !EMPTY(MV_PAR01)
   	   cQuery += CRLF+ "   and bd6_numfat LIKE  '%"+MV_PAR01+'%" 
   	   IF !EMPTY(MV_PAR02)
   	       cQuery += CRLF+ "   and pd2_senha LIKE  '%"+MV_PAR02+'%"
   	   endif 
   ElseIf !EMPTY(MV_PAR02)
   	       cQuery += CRLF+ "   and pd2_senha LIKE  '%"+MV_PAR02+'%" 	        
  EndIf  
  	             
   	cQuery += CRLF+ "   and pd2_lotfat    <> ' ' " 
   	
    cQuery += CRLF+ "   and bg9_codint = '0001' and bg9_codigo = PD2_COdEMP "
   	 
 	cQuery += CRLF+ " group by pd2_codemp ||'.'||pd2_matric ||'.'||pd2_tpreg ||' - ' ||pd2_nomusr , "
	cQuery += CRLF+ "       e1_prefixo ||e1_num || e1_tipo , "
    cQuery += CRLF+ "       substr(e1_emissao,7,2)||'/'||substr(e1_emissao,5,2)||'/'||substr(e1_emissao,1,4) , "
	cQuery += CRLF+ "       substr(e1_vencrea,7,2)||'/'||substr(e1_vencrea,5,2)||'/'||substr(e1_vencrea,1,4) , " 
	cQuery += CRLF+ "       substr(e1_baixa,7,2)||'/'||substr(e1_baixa,5,2)||'/'||substr(e1_baixa,1,4)       , "
	cQuery += CRLF+ "       e1_valor , e1_saldo  , pd2_tpsenh ,  pd2_senha ,  "
	cQuery += CRLF+ "       pd2_tpsenh ,  pd2_senha ,  substr(bg9_descri,1,30)"
/*
	cQuery += CRLF+ " union all "

	cQuery += CRLF+ "select ba1_codemp ||'.'||ba1_matric ||'.'||ba1_tipreg ||' - ' ||ba1_nomusr usuario ," 
	cQuery += CRLF+ "       'Deb/Cred'  tiposenha , bsq_codseq  senha, "  
	cQuery += CRLF+ "       e1_prefixo ||e1_num || e1_tipo  Titulo , "
	cQuery += CRLF+ "       substr(e1_emissao,7,2)||'/'||substr(e1_emissao,5,2)||'/'||substr(e1_emissao,1,4)emissao ,"
	cQuery += CRLF+ "       substr(e1_vencrea,7,2)||'/'||substr(e1_vencrea,5,2)||'/'||substr(e1_vencrea,1,4)Venc_real ,"
	cQuery += CRLF+ "       substr(e1_baixa,7,2)  ||'/'||substr(e1_baixa,5,2)  ||'/'||substr(e1_baixa,1,4)baixa , "
	cQuery += CRLF+ "       sum(decode (bsq_tipo,'1',(bsq_valor * -1),bsq_valor)) vlrtit, "
	cQuery += CRLF+ "       sum(decode (bsq_tipo,'1',(bsq_valor * -1),bsq_valor)) saldotit,"  
	cQuery += CRLF+ "       sum(decode (bsq_tipo,'1',(bsq_valor * -1),bsq_valor)) custo ,  sum(decode (bsq_tipo,'1',(bsq_valor * -1),bsq_valor)) vlrcob , count(*) QTDA 

	cQuery += CRLF+ "  from "+ RetSqlName("BSQ") +" BSQ ,"+ RetSqlName("BA1") +" BA1 , "+ RetSqlName("SE1") +" SE1 "
	cQuery += CRLF+ " where BSQ_filial = '"+xFilial('BSQ')+ "'  and BSQ.d_E_L_E_T_  = ' ' " 
	cQuery += CRLF+ "   and BA1_filial = '"+xFilial('BA1')+ "'  and BA1.d_E_L_E_T_  = ' ' "
	cQuery += CRLF+ "   and E1_filial  = '"+xFilial('SE1')+ "'  and se1.d_E_L_E_T_ = ' ' "

	cQuery += CRLF+ "   and e1_plnucob =  '000100041294' "
	cQuery += CRLF+ "   AND E1_TIPO = 'NCC' "
   
	cQuery += CRLF+ "   and bsq_prefix = e1_prefixo " 
	cQuery += CRLF+ "   and bsq_numtit = e1_num     " 
	cQuery += CRLF+ "   and bsq_parcel = e1_parcela "
	cQuery += CRLF+ "   and bsq_tiptit = e1_tipo "     
	cQuery += CRLF+ "   and bsq_numcob = '000100041294' "       
   
	cQuery += CRLF+ "   and ba1_codint = '0001' "
	cQuery += CRLF+ "   and ba1_codemp = bsq_codemp " 
	cQuery += CRLF+ "   and ba1_matric = bsq_matric "
	cQuery += CRLF+ "   and Ba1_Tipreg = '00' "
	cQuery += CRLF+ " group by  ba1_codemp ||'.'||ba1_matric ||'.'||ba1_tipreg ||' - ' ||ba1_nomusr , "
	cQuery += CRLF+ "       bsq_codseq , "   
    cQuery += CRLF+ "       e1_prefixo ||e1_num || e1_tipo , "
    cQuery += CRLF+ "       substr(e1_emissao,7,2)||'/'||substr(e1_emissao,5,2)||'/'||substr(e1_emissao,1,4) , "
    cQuery += CRLF+ "       substr(e1_vencrea,7,2)||'/'||substr(e1_vencrea,5,2)||'/'||substr(e1_vencrea,1,4) , "
    cQuery += CRLF+ "       substr(e1_baixa,7,2)  ||'/'||substr(e1_baixa,5,2)  ||'/'||substr(e1_baixa,1,4)"
*/
	cQuery += CRLF+ " order by 4 "
 
////////////////////////////////////////       
	   	
    TCQuery cQuery New Alias (cAliastmp)
      
    dbSelectArea (cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())   

           aaDD(aDados1,{   (cAliastmp)->usuario    ,;
							(cAliastmp)->tiposenha  ,;     
							(cAliastmp)->senha      ,;     
							(cAliastmp)->Titulo     ,;     
							(cAliastmp)->emissao    ,;
							(cAliastmp)->venc_real  ,;
							(cAliastmp)->baixa      ,;                                                          
							(cAliastmp)->vlrtit     ,;     
							(cAliastmp)->saldotit   ,;                                                                            
							(cAliastmp)->custo      ,;                                                                            
							(cAliastmp)->vlrcob     ,;
							(cAliastmp)->qtda       ,;
							(cAliastmp)->EMPDESC    })                                 
                  
       (cAliastmp)->(dbSkip()) 	   
    
    EndDo	                   
 
Return    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR273"                                                           ¦

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

oReport	:= TReport():New("CABR273","Relatorio de Repasse de Custo Operacional "  ,, {|oReport| ReportPrt(oReport)},"Relatorio de Acompanhamento de inclusoes e execlições do Sib - Excel - " + mv_par01 )

oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(3) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oReport:SetTotalPageBreak(lTPageBreak)

oDPJ := TRSection():New(oReport,"Relatorio de Repasse de Custo Operacional" ,,aOrdem)              


   TRCell():New(oDPJ ,'EMPRES'	        	,	,'Empresa    '   ,    ,30  	,,,,,"LEFT" )   
   TRCell():New(oDPJ ,'USUARI'	        	,	,'Usuario    '   ,    ,50  	,,,,,"LEFT" )   
   TRCell():New(oDPJ ,'TPSENH'         		,	,'Tipo Senha '   ,    ,12 	,,,,,"LEFT"	)  
   TRCell():New(oDPJ ,'SENHA'         		,	,'Senha      '   ,    ,20  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'TITULO'         		,	,'Titulo     '   ,    ,15  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'DTEMIS'         		,	,'Dt Emissao '   ,    ,10  	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'DTVENC'         		,	,'Dt Vencim. '   ,    ,10 	,,,,,"LEFT"	)
   TRCell():New(oDPJ ,'DTBAIX'         		,	,'Dt Baixa   '   ,    ,10 	,,,,,"LEFT"	)      
//   TRCell():New(oDPJ ,'VLRTIT'         		,	,'Vlr Titulo '   ,"@E 99,999,999.99" 	,14 	,,,,,"RIGHT"	)
//   TRCell():New(oDPJ ,'SLDTIT'         		,	,'Sld Titulo '   ,"@E 99,999,999.99" 	,14 	,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'VLRCUS'         		,	,'Vlr Custo  '   ,"@E 99,999,999.99" 	,14 	,,,,,"RIGHT"	)   
   TRCell():New(oDPJ ,'VLRCOB'         		,	,'Vlr Cobranc'   ,"@E 99,999,999.99" 	,14 	,,,,,"RIGHT"	)
   TRCell():New(oDPJ ,'QTDA'         		,	,'Qtda Guias'    ,"@E 9,999,999"     	,10 	,,,,,"RIGHT"	)
   
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("TITULO")," totais .....   "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
   TRFunction():New(oDPJ:Cell("TITULO")    	  ,NIL,"COUNT"	    	,oBreak01,,"@E 999,999"	        ,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
   TRFunction():New(oDPJ:Cell("VLRCUS")    	  ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
   TRFunction():New(oDPJ:Cell("VLRCOB")    	  ,NIL,"SUM"	    	,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)    
  
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


 oDPJ:Cell('EMPRES'):SetValue((aDados1[i][13]))    
 oDPJ:Cell('USUARI'):SetValue((aDados1[i][ 1]))    
 oDPJ:Cell('TPSENH'):SetValue((aDados1[i][ 2]))     
 oDPJ:Cell('SENHA'):SetValue((aDados1[i][ 3]))   
 oDPJ:Cell('TITULO'):SetValue((aDados1[i][ 4]))    
 oDPJ:Cell('DTEMIS'):SetValue((aDados1[i][ 5]))    
 oDPJ:Cell('DTVENC'):SetValue((aDados1[i][ 6]))   
 oDPJ:Cell('DTBAIX'):SetValue((aDados1[i][ 7]))      
// oDPJ:Cell('VLRTIT'):SetValue((aDados1[i][ 8]))      
// oDPJ:Cell('SLDTIT'):SetValue((aDados1[i][ 9]))      
 oDPJ:Cell('VLRCUS'):SetValue((aDados1[i][10]))    
 oDPJ:Cell('VLRCOB'):SetValue((aDados1[i][11]))    
 oDPJ:Cell('QTDA'):SetValue((aDados1[i][12]))       

   oDPJ:PrintLine()
   
   Next i

   oDPJ:Finish()      

*********************************************************************************


Return  
*********************************************************************************


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Lote de Cobrança ") 		      ,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Senha            ")               ,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Caberj","","","","Integral","","","Todas","","","","","","","","",{},{},{}) 



Pergunte(cPerg,.F.)

Return

