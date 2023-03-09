#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR203   º Autor ³Altamiro              º Data ³ 18/12/15  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Este programa fara listagem da Produtividade do cadastro    º±±
±±º          ³ conforme parametros                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR203()

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR203"
Private cTitulo     := "Listagem da Produtividade "        

Private cAliastmp 	:= GetNextAlias()  
 
Private lCritica    :=.F.
Private x           := 0  
private a           := ' '   
private dDtBase     := dtos(dDataBase)

                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa fara listagem da prdutividade do cadastro conforme parametros" 

***************************************************************************    
 
Private aDados1    := {}       
Private acabec1    := {"Matricula","Nome Usuario", "Data Nasc." , "Cpf usuario ","Nome Mãe ","Telefone ","Celilar ","Cod. Plano","Nome Plano","Municipio", "E_mail" }

Private aDados2    := {}       
Private acabec2    := {"Usuario1","Nivel Cobr1", "Data Nasc.1","Idade1" , "Cpf usuario1 ","Bloq1","Matr. Vida1","<<<----->>> ",;
                        "Usuario2","Nivel Cobr2", "Data Nasc.2","Idade2" , "Cpf usuario2 ","Bloq2","Matr. Vida2"}               
                        
Private acabec3    := {"Nome Usuario1","Nivel Cobr1", "Data Nasc.1","Idade1" , "Cpf usuario1 ","Bloq1","Matr. Vida1","Tp Usuario "}   
Private aDados3    := {}  

private Descric     := ' '   
private ctraco      := replicate("_",220)                                                                                                          
 	
  	  
AjustaSX1(cPerg)


cDtIni         := dtos(mv_par01)
cDtFim         := dtos(mv_par02)   
cusuario       := mv_par03
cEmpDe         := mv_par04  
cEmpAte        := mv_par05
  
cMatric        := mv_par06 
nList          := mv_par07
nPrdPla        := 2 
//nPrdPla        := mv_par08 

If nPrdPla == 2
   cTitulo     := "Listagem da Produtividade "
   Processa({||Processa1()}, cTitulo, "", .T.)
   fGeraRel1()
Else        
  cTitulo     := "Listagem da Upgrad de Plano "
  Processa({||Processa1()}, cTitulo, "", .T.)
  fGeraRel2()
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
////////////////////////////////////   
if nPrdPla == 2
		cquery := CRLF+" SELECT decode (bx1_alias,'BA1' ,'USUARIO' , 'BA3' , 'FAMILIA' , 'BTS' , 'VIDA' , ' ' ) ORIGEM , "
		cquery += CRLF+"        decode (BX1_TIPO, 'I' , 'I - Inclusao ',  'E' , 'E - Exclusão ', 'A' , 'A - Alteração' ,' ') TIPO ,"
		cquery += CRLF+"        BX1_USUARI , " 
		cquery += CRLF+"        substr(BX1_DATA,7,2)||'/'||substr(BX1_DATA,5,2)||'/'|| substr(BX1_DATA,1,4) dta , "
		If nList == 2
		   cquery += CRLF+"        BA1_CODINT ||'.'|| BA1_CODEMP ||'.'|| BA1_MATRIC ||'.'|| BA1_TIPREG||'-'|| BA1_DIGITO ||' - '|| BA1.BA1_NOMUSR USUAR, "
		   cquery += CRLF+"        BA1_CODEMP ||'-'|| BG9.BG9_DESCRI EMPRESA , "
		ElseIf nList == 1
		   cquery += CRLF+"        BA1_CODEMP ||'-'|| BG9.BG9_DESCRI EMPRESA , "
		EndIf    
		cquery += CRLF+"        BX2_TITULO CAMPO , BX2_ANTVAL VLANT , BX2_NOVVAL VLATU, "
		cquery += CRLF+"        count(*) QTDA "
		
		cquery += CRLF+"   FROM "+ RetSqlName("BA1") + " BA1 , "
		cquery += CRLF+"        "+ RetSqlName("BTS") + " BTS , "
		cquery += CRLF+"        "+ RetSqlName("BA3") + " BA3 , "  
		cquery += CRLF+"        "+ RetSqlName("BX1") + " BX1 , "  
		cquery += CRLF+"        "+ RetSqlName("BG9") + " BG9 , "  
		cquery += CRLF+"        "+ RetSqlName("BX2") + " BX2  "
		
		cquery += CRLF+"  WHERE BA1_FILIAL = '" + xFilial("BA1") + "' AND BA1.D_E_L_E_T_ = ' ' "
		cquery += CRLF+"    AND BTS_FILIAL = '" + xFilial("BTS") + "' AND BTS.D_E_L_E_T_ = ' ' "
		cquery += CRLF+"    AND BA3_FILIAL = '" + xFilial("BA3") + "' AND BA3.D_E_L_E_T_ = ' ' "  
		cquery += CRLF+"    AND BX1_FILIAL = '" + xFilial("BX1") + "' AND BX1.D_E_L_E_T_ = ' ' "
		cquery += CRLF+"    AND BG9_FILIAL = '" + xFilial("BG9") + "' AND BG9.D_E_L_E_T_ = ' ' "
		cquery += CRLF+"    AND BX2_FILIAL = '" + xFilial("BX2") + "' AND BX2.D_E_L_E_T_ = ' ' "
		cquery += CRLF+"    AND BA1_MATVID = BTS_MATVID AND BA1_CODINT = BA3_CODINT AND BA1_CODEMP = BA3_CODEMP AND BA1_MATRIC = BA3_MATRIC "
		cquery += CRLF+"    AND BG9_CODIGO = BA1_CODEMP "
		
		cquery += CRLF+"    AND bx1_data >= '"+cDtIni+"' and bx1_data < '"+cDtFim+"' "
		
		cquery += CRLF+"    AND BA1_CODEMP >= '" + cEmpDe + "' AND BA1_CODEMP <= '" + cEmpAte + "'"
		
		 If !empty(cusuario) 
		     cquery += CRLF+"        AND BX1_USUARI = '" + cusuario+"'  "                                                 
		  EndIf    
		              
		 If !empty(cMatric) .and. nList == 2
		       cquery += CRLF+"        AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG|| BA1_DIGITO = '"+trim(cMatric)+"' "
		 EndIf 
		       
		cquery += CRLF+"    AND BA1.R_E_C_N_O_ = BX1_RECNO   AND bx1_alias In( 'BA1' , 'BA3' , 'BTS' )"
		cquery += CRLF+"    AND ( BX1_TIPO ='I' or BX1_TIPO ='A' or BX1_TIPO ='E' ) " 
		cquery += CRLF+"    AND BX1_SEQUEN = BX2_SEQUEN "
		
		cquery += CRLF+"  GROUP bY decode (bx1_alias,'BA1' ,'USUARIO' , 'BA3' , 'FAMILIA' , 'BTS' , 'VIDA' , ' ' ) ," 
		cquery += CRLF+"           decode (BX1_TIPO, 'I' , 'I - Inclusao ',  'E' , 'E - Exclusão ', 'A' , 'A - Alteração' ,' ') , "
		cquery += CRLF+"           BX1_USUARI , "
		cquery += CRLF+"          substr(BX1_DATA,7,2)||'/'||substr(BX1_DATA,5,2)||'/'|| substr(BX1_DATA,1,4) , " 
		If nList == 2
		   cquery += CRLF+"        BA1_CODINT ||'.'|| BA1_CODEMP ||'.'|| BA1_MATRIC ||'.'|| BA1_TIPREG||'-'|| BA1_DIGITO ||' - '|| BA1.BA1_NOMUSR , "
		   cquery += CRLF+"        BA1_CODEMP ||'-'|| BG9.BG9_DESCRI  , "
		ElseIf nList == 1
		   cquery += CRLF+"        BA1_CODEMP ||'-'|| BG9.BG9_DESCRI  , "
		EndIf 
		cquery += CRLF+"        BX2_TITULO , BX2_ANTVAL  , BX2_NOVVAL  "
		cquery += CRLF+"  ORDER BY "
		If nList == 2
		   cquery +=" 3,5,6,2,1"
		ElseIf nList == 1
		      cquery +=" 3,5,2,1"
		Else 
		   cquery +=" 3,2,1"      
		EndIf 
		
ElseIf nPrdPla == 1                                                                                  
       cquery := CRLF+ " SELECT ba11.ba1_CODINT ||'.'|| ba11.BA1_CODEMP ||'.'|| ba11.ba1_matric ||'.'|| ba11.BA1_TIPREG , ba11.ba1_nomusr ,  "
       cquery += CRLF+ "        ba11.ba1_motblo , ba11.BA1_DATBLO , ba11.ba1_codpla  , BI31.BI3_DESCRI , "
       cquery += CRLF+ "        ba1.ba1_CODINT ||'.'|| ba1.BA1_CODEMP ||'.'|| ba1.ba1_matric ||'.'|| ba1.BA1_TIPREG , ba1.ba1_nomusr , "
       cquery += CRLF+ "        ba1.ba1_motblo , ba1.BA1_DATBLO , ba1.ba1_codpla , BI3.BI3_DESCRI ,"
       cquery += CRLF+ "        BA1.BA1_MATVID   "
       
    	cquery += CRLF+"   FROM "+ RetSqlName("BA1") + " BA1  , "
		cquery += CRLF+"        "+ RetSqlName("BA1") + " BA11 , "
		cquery += CRLF+"        "+ RetSqlName("BI3") + " BI3  , "  
		cquery += CRLF+"        "+ RetSqlName("BI3") + " BI31  "
		
		cquery += CRLF+"  WHERE BA1.BA1_FILIAL = '" + xFilial("BA1") + "' AND BA1.D_E_L_E_T_ = ' ' "
		cquery += CRLF+"    AND BA11.BA1_FILIAL = '" + xFilial("BA1") + "' AND BA11.D_E_L_E_T_ = ' ' "
		cquery += CRLF+"    AND BI3.BI3_FILIAL = '" + xFilial("BA3") + "' AND BI3.D_E_L_E_T_ = ' ' "  
		cquery += CRLF+"    AND BI31.BI3_FILIAL = '" + xFilial("BA3") + "' AND BI31.D_E_L_E_T_ = ' ' "  
		cquery += CRLF+"    and ba11.BA1_MOTBLO = '019' "
    	cquery += CRLF+"    and ba11.ba1_datblo = ba1.ba1_datinc "
    	cquery += CRLF+"    and ba11.ba1_datblo>='20150101' and ba11.ba1_datblo <= '20150131' "
		cquery += CRLF+"    and BA1.BA1_MATVID = BA11.BA1_MATVID "
		cquery += CRLF+"    and ba11.r_E_C_N_O_ <> ba1.r_E_C_N_O_ "
		cquery += CRLF+"    AND BI3.BI3_CODIGO  = BA1.BA1_CODPLA "
		cquery += CRLF+"    AND BI3.BI3_VERSAO  = BA1.BA1_VERSAO "
		cquery += CRLF+"    AND BI31.BI3_CODIGO  = BA11.BA1_CODPLA "
		cquery += CRLF+"    AND BI31.BI3_VERSAO  = BA11.BA1_VERSAO "
		cquery += CRLF+"  ORDER  BY 15 "
EndIf   
//////
If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif
  
 TCQuery cQuery New Alias (cAliastmp)  
    
 dbSelectArea(cAliastmp)
   
 (cAliastmp)->(dbGoTop())   
 

While (cAliastmp)->(!Eof())                     
/***********************/   

  If nList == 2
     aaDD(aDados1,{  (cAliastmp)->ORIGEM  ,;
                     (cAliastmp)->TIPO    ,;
              substr((cAliastmp)->BX1_USUARI,1,30),; 
                     (cAliastmp)->dta     ,; 
                     (cAliastmp)->USUAR   ,; 
                     (cAliastmp)->EMPRESA ,;
                     (cAliastmp)->CAMPO   ,;
                     (cAliastmp)->VLANT   ,;
                     (cAliastmp)->VLATU   ,;
                     (cAliastmp)->QTDA })
  
  ElseIf nList == 1
     aaDD(aDados1,{  (cAliastmp)->ORIGEM  ,;
                     (cAliastmp)->TIPO    ,;
              substr((cAliastmp)->BX1_USUARI,1,30),; 
                     (cAliastmp)->dta     ,; 
                     ' ' ,; 
                     (cAliastmp)->EMPRESA ,;
                     (cAliastmp)->CAMPO   ,;
                     (cAliastmp)->VLANT   ,;
                     (cAliastmp)->VLATU   ,;
                     (cAliastmp)->QTDA })
                     
  Else
     aaDD(aDados1,{  (cAliastmp)->ORIGEM  ,;
                     (cAliastmp)->TIPO    ,;
              substr((cAliastmp)->BX1_USUARI,1,30),; 
                     (cAliastmp)->dta     ,; 
                     ' ' ,; 
                     ' ' ,;
                     (cAliastmp)->CAMPO   ,;
                     (cAliastmp)->VLANT   ,;
                     (cAliastmp)->VLATU   ,;
                     (cAliastmp)->QTDA })                     
  
  
  
  EndIf
  
       (cAliastmp)->(dbSkip()) 	   
EndDo	                   
                                          

Return    
                
*************************************************************************************************************   

Static Function fGeraRel1

Local oReport 
Private cPerg		:= "CABR203"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef1()
oReport:PrintDialog()


Return
/********************************************************************************************************************************
/*
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
*/                         
Static Function ReportDef1()

Local oReport 
Local oDPJ    
oReport	:= TReport():New("CABR203","Listagem da Produtividade" ,, {|oReport| ReportPrt(oReport)},"Listagem da Produtividade" )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

 oDPJ := TRSection():New(oReport,"Listagem da Produtividade " ,,aOrdem)  
 
 
  If nList == 2       
 
     TRCell():New(oDPJ ,'ORIGEM'	      	,/*TABELA*/	,'Cadastro '     ,/*Picture*/ 	       ,20		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
     TRCell():New(oDPJ ,'TIPO'             ,/*TABELA*/ 	,'Tipo Ação'     ,/*Picture*/ 	       ,12		  	    ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
     TRCell():New(oDPJ ,'USUAR'	          	,/*TABELA*/	,'Usuario  '     ,/*Picture*/ 	       ,15			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
     TRCell():New(oDPJ ,'DATA'	            ,/*TABELA*/	,'Data     '     ,/*Picture*/ 	       ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
     TRCell():New(oDPJ ,'BENEFI'	    	,/*TABELA*/	,'Beneficiario'  ,/*Picture*/ 	       ,60			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
     TRCell():New(oDPJ ,'EMPRE' 	    	,/*TABELA*/	,'Empresa  '     ,/*Picture*/ 	       ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
     TRCell():New(oDPJ ,'CAMPO'		     	,/*TABELA*/	,'Campo    '     ,/*Picture*/         ,15	    	  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
     TRCell():New(oDPJ ,'VLANT'	        	,/*TABELA*/	,'Valor Ant.'    ,/*Picture*/ 	       ,20			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
     TRCell():New(oDPJ ,'VLATU'	        	,/*TABELA*/	,'Valor Atual'   ,/*Picture*/ 	       ,20			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
     TRCell():New(oDPJ ,'QTDA'	        	,/*TABELA*/	,'Quant'         ,/*Picture*/ 	       ,06			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

  ElseIf nList == 1
 
     TRCell():New(oDPJ ,'ORIGEM'        	,/*TABELA*/	,'Cadastro '	 ,/*Picture*/ 	       ,20		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
     TRCell():New(oDPJ ,'TIPO'             ,/*TABELA*/ 	,'Tipo Ação'     ,/*Picture*/ 	       ,12		  	    ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
     TRCell():New(oDPJ ,'USUAR'	          	,/*TABELA*/	,'Usuario  '     ,/*Picture*/ 	       ,15			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
     TRCell():New(oDPJ ,'DATA'	   	        ,/*TABELA*/	,'Data     '     ,/*Picture*/ 	       ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
     TRCell():New(oDPJ ,'EMPRE' 	    	,/*TABELA*/	,'Empresa  '     ,/*Picture*/ 	       ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
     TRCell():New(oDPJ ,'CAMPO'		     	,/*TABELA*/	,'Campo    '     ,/*Picture*/          ,25	    	  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
     TRCell():New(oDPJ ,'VLANT'	        	,/*TABELA*/	,'Valor Ant.'    ,/*Picture*/ 	       ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
     TRCell():New(oDPJ ,'VLATU'	        	,/*TABELA*/	,'Valor Atual'   ,/*Picture*/ 	       ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
     TRCell():New(oDPJ ,'QTDA'	        	,/*TABELA*/	,'Quant'         ,/*Picture*/ 	       ,06			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
 
  Else 
 
     TRCell():New(oDPJ ,'ORIGEM'        	,/*TABELA*/	,'Cadastro '	 ,/*Picture*/ 	       ,20		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
     TRCell():New(oDPJ ,'TIPO'             ,/*TABELA*/ 	,'Tipo Ação'     ,/*Picture*/ 	       ,12		  	    ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
     TRCell():New(oDPJ ,'USUAR'	          	,/*TABELA*/	,'Usuario  '     ,/*Picture*/ 	       ,15			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
     TRCell():New(oDPJ ,'DATA'	   	        ,/*TABELA*/	,'Data     '     ,/*Picture*/ 	       ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
     TRCell():New(oDPJ ,'CAMPO'		     	,/*TABELA*/	,'Campo    '     ,/*Picture*/          ,25		    	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
     TRCell():New(oDPJ ,'VLANT'	        	,/*TABELA*/	,'Valor Ant.'    ,/*Picture*/ 	       ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
     TRCell():New(oDPJ ,'VLATU'	        	,/*TABELA*/	,'Valor Atual'   ,/*Picture*/ 	       ,30			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
     TRCell():New(oDPJ ,'QTDA'	        	,/*TABELA*/	,'Quant'         ,/*Picture*/ 	       ,07			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RINGT"		)

  EndIf  
 
oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("USUAR"),"Total Usuario  "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                    
   TRFunction():New(oDPJ:Cell("QTDA")          ,NIL,"SUM"	     	,oBreak01,,"@E 999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
// TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
 
 
 
Return(oReport)

/*
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
*/

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
   If nList == 2       
		
      oDPJ:Cell('ORIGEM' 		):SetValue((aDados1[i][1]))        
      oDPJ:Cell('TIPO'    	  	):SetValue((aDados1[i][2]))   
      oDPJ:Cell('USUAR'	 		):SetValue((aDados1[i][3]))   
      oDPJ:Cell('DATA'	     	):SetValue((aDados1[i][4]))         
      oDPJ:Cell('BENEFI'        ):SetValue((aDados1[i][5]))           
      oDPJ:Cell('EMPRE' 		):SetValue((aDados1[i][6]))           
      oDPJ:Cell('CAMPO' 		):SetValue((aDados1[i][7]))        
      oDPJ:Cell('VLANT'  		):SetValue((aDados1[i][8]))               
      oDPJ:Cell('VLATU'	 		):SetValue((aDados1[i][9]))       
      oDPJ:Cell('QTDA' 	        ):SetValue((aDados1[i][10])) 
	   
  ElseIf nList == 1

      oDPJ:Cell('ORIGEM' 		):SetValue((aDados1[i][1]))        
      oDPJ:Cell('TIPO'    	  	):SetValue((aDados1[i][2]))   
      oDPJ:Cell('USUAR'	 		):SetValue((aDados1[i][3]))   
      oDPJ:Cell('DATA'	     	):SetValue((aDados1[i][4]))         
	  oDPJ:Cell('EMPRE' 		):SetValue((aDados1[i][6]))           
	  oDPJ:Cell('CAMPO' 		):SetValue((aDados1[i][7]))        
      oDPJ:Cell('VLANT'  		):SetValue((aDados1[i][8]))               
      oDPJ:Cell('VLATU'	 		):SetValue((aDados1[i][9]))       
      oDPJ:Cell('QTDA' 	        ):SetValue((aDados1[i][10])) 
 
  Else 

      oDPJ:Cell('ORIGEM' 		):SetValue((aDados1[i][1]))        
      oDPJ:Cell('TIPO'    	  	):SetValue((aDados1[i][2]))   
      oDPJ:Cell('USUAR'	 		):SetValue((aDados1[i][3]))   
      oDPJ:Cell('DATA'	     	):SetValue((aDados1[i][4]))         
      oDPJ:Cell('CAMPO'  		):SetValue((aDados1[i][7]))        
      oDPJ:Cell('VLANT'  		):SetValue((aDados1[i][8]))               
      oDPJ:Cell('VLATU'	 		):SetValue((aDados1[i][9]))       
      oDPJ:Cell('QTDA' 	        ):SetValue((aDados1[i][10])) 
      
  EndIf  
   
	
   oDPJ:PrintLine()
   
Next i

oDPJ:Finish()

Return   

******************************************************************************************

Static Function AjustaSX1(cPerg)         

Local aHelpPor := {} 

PutSx1(cPerg,"01",OemToAnsi("Data Inicio ") 		,"","","mv_ch1","D",10,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Data Fim    ") 		,"","","mv_ch2","D",10,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})

PutSx1(cPerg,"03",OemToAnsi("Usuaria     ") 	   ,"","","mv_ch03","C",20,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"04",OemToAnsi("Empresa de  ") 	   ,"","","mv_ch04","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"05",OemToAnsi("Empresa Ate ") 	   ,"","","mv_ch05","C",04,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","","",{},{})

PutSx1(cPerg,"06",OemToAnsi("Matricula Comp.") 	   ,"","","mv_ch06","C",17,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","","",{},{})

PutSx1(cPerg,"07",OemToAnsi("Listar por ?") 	   ,"","","mv_ch07","N",01,0,0,"C","","","","","mv_par07","Empresa ","","","","Matricula","","","Sintetico","","","","","","","","",{},{},{}) 

PutSx1(cPerg,"08",OemToAnsi("Listar     ?") 	   ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Upgrad plano ","","","","Produtividade","","","Sintetico","","","","","","","","",{},{},{}) 


Pergunte(cPerg,.T.)

Return


