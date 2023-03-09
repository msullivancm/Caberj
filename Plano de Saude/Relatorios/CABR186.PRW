
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "msgraphi.ch"
#include "fileio.ch"     
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR186  ³ Autor ³ Roberto Meirelles    ³ Data ³ 19/06/2015 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Debitos / Creditos - acompanhamento Giordano  |±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR186

Local oReport 
Private cPerg		:= "CABR186"  
Private aOrdem 		:= {'RDA','Ano/Mes'}        

private cMesInc     := mv_par01 
private cAnoInc     := mv_par02
private cMesFinal   := mv_par03
private cAnoFinal   := mv_par04
private cRdaInc     := mv_par05
private cRdaFinal   := mv_par06 
private cCodlanInc  := mv_par07
//private cCodLanFinal:= mv_par08
private dDatIni     := mv_par08 
private dDatFinal   := mv_par09


oReport:= ReportDef()
oReport:PrintDialog()

Return

/********************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Roberto meirelles     |      |          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         

Static Function ReportDef()

Local oReport 
Local oRemessa     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport	:= TReport():New("CABR186","Relação de Debitos - DESCONTO DE REEMBOLSO - por Rda e/ou periodo ","CABR186", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de Debitos de Reembolso por RDA e/ou Competencia")

oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total Geral') 

/*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*/

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

/*'-----------------------------------------------------------------------------------'*/
                                                                
oRemessa := TRSection():New(oReport,"Debitos / Creditos por Rda e/ou periodo",,aOrdem)


TRCell():New(oRemessa ,'CODRDA'		 		,     	,'Ident. RDA'		    ,/*Picture*/ 				,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'COMPET'		 		,   	,'Compet.'              ,/*Picture*/ 				,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'LOTE'			    ,		,'Lote '				,/*Picture*/ 				,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New(oRemessa ,'DESLAN'				,		,'Desc. Lnancamento' 	,/*Picture*/				,40			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'DATDIG'				,		,'Data. Lançamento'     , /*Picture*/				,10	            ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'TOTAL'			    ,       ,'Vl do Lançamento' 	,"@E 9,999,999.99" 			,15          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'STATUS'				,		,'Status Lanc' 	        ,/*Picture*/				,07              ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'TIPDEB'			    ,    	,'Tipo Deb/Cred' 		,/*Picture*/  				,10         	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oRemessa ,'NUMTIT'			    ,    	,'Num Tit Pg' 		    ,/*Picture*/  				,15         	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'DATEMI'			    ,    	,'Dt da Emissao'  		,/*Picture*/  				,10         	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
TRCell():New(oRemessa ,'DATBXA'			    ,    	,'Dt da baixa'  		,/*Picture*/  				,10         	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oRemessa ,'VLRTIT'			    ,       ,'Vl Tit Compensado'	,"@E 9,999,999.99" 			,12          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oRemessa ,'SALTIT'			    ,       ,'Saldo' 		        ,"@E 9,999,999.99" 			,12          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ARECUP'			    ,       ,'à Recuperar '     	,"@E 9,999,999.99" 			,12          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oBreak01 		:= TRBreak():New(oRemessa,oRemessa:Cell("CODRDA"),"Subtotal por GRUPO PAGTO" 	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

TRFunction():New(oRemessa:Cell("VLRTIT")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("SALTIT")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("TOTAL")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("ARECUP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)



Return(oReport)

/********************************************************************************************************************************/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Roberto Meirelles                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrint(oReport)

Private oRemessa 	:= oReport:Section(1)
Private cAliastmp 	:= GetNextAlias()
Private cQuery		:= ''
Private nCont 		:= 0

//Executa query que alimenta o alias cAliasCart 
Processa({||nCont := FilTRep()},AllTrim(SM0->M0_NOMECOM))

//Se nao tiver esta linha, nao imprime os dados
oRemessa:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       
nCritic	:= 0

While !( cAliastmp->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf
	
    dtdigtacao:=(GAVLELOG(cAliastmp->(datdig)))
    dtdigtacao:= substr(dtdigtacao,20,8) 
    
    
    If ( CTOD(dtdigtacao) < mv_par08 ) .or. ( CTOD(dtdigtacao) > mv_par09 )
		cAliastmp->(DbSkip())		    
		Loop
    EndIf
    
    //statusLanca := statusla
    //statusLanca :=(1,'Ativo','Inativo')                                                   
	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)
	oReport:IncMeter()
  
	oRemessa:Cell('CODRDA' 		):SetValue(cAliastmp->(rda))
	oRemessa:Cell('COMPET' 		):SetValue(cAliastmp->(comp))
	oRemessa:Cell('LOTE' 		):SetValue(cAliastmp->(lot))
   //oRemessa:Cell('DESLAN'		):SetValue(cAliastmp->(desclan))      
    oRemessa:Cell('DATDIG'		):SetValue( dtdigtacao )
    oRemessa:Cell('STATUS'		):SetValue( statusla ) 
    oRemessa:Cell('TIPDEB'		):SetValue(cAliastmp->(tip))   
    oRemessa:Cell('NUMTIT'		):SetValue(cAliastmp->(titse2))  
    oRemessa:Cell('DATEMI'		):SetValue(substr(cAliastmp->(emstitse2),7,2)+"/"+substr(cAliastmp->(emstitse2),5,2)+"/"+substr(cAliastmp->(emstitse2),1,4))       
    oRemessa:Cell('DATBXA'		):SetValue(substr(cAliastmp->(bxatitse2),7,2)+"/"+substr(cAliastmp->(bxatitse2),5,2)+"/"+substr(cAliastmp->(bxatitse2),1,4))        
    If!EMPTY(cAliastmp->(titse2)) 
       oRemessa:Cell('VLRTIT'		):SetValue(cAliastmp->(tot))//(cAliastmp->(vlrtitse2))               
    Else                                                                                                   
       oRemessa:Cell('VLRTIT'		):SetValue(0.00)//(cAliastmp->(vlrtitse2))        
    endIf          
    oRemessa:Cell('SALTIT'		):SetValue(cAliastmp->(saldtitse2))  
       
    oRemessa:Cell('ARECUP'		):SetValue(cAliastmp->(tot) + cAliastmp->(vlrtitse2))         
                
    
	oRemessa:Cell('TOTAL'  		):SetValue(cAliastmp->(tot))
	oRemessa:PrintLine()
		
    cAliastmp->(DbSkip())
    
EndDo

oRemessa:Finish()

cAliastmp->(DbCloseArea())

Return   

/********************************************************************************************************************************/

Static Function FilTRep

Local i := 0

ProcRegua(0)

For i := 1 to 5
	IncProc('Selecionando registros a serem analisados...')
Next

//--------------------------------- 
cQuery := "Select bgq_codigo ||'-'||bgq_nome rda , " 
cQuery += CRLF +"  bgq_ano||'/'||bgq_mes comp , "
cQuery += CRLF +"  bgq_numlot lot , "	
cQuery += CRLF +"  bgq_codlan||'-'||bbb_descri desclan , "
cQuery += CRLF +"  bgq_usergi datdig, " 
cQuery += CRLF +"  decode(bgq_ativo, '1' , 'Ativo','Inativo') statusla, "
cQuery += CRLF +"  decode(bgq_tipo , 2 , 'Credito','Debito') tip , "
cQuery += CRLF +"  nvl(e2_pllote,' ') pllotese2  , nvl(e2_codrda,' ') codrdase2, "
cQuery += CRLF +"  nvl(e2_prefixo,' ')|| nvl(e2_num,' ') || nvl(e2_tipo,' ') titse2   , 
cQuery += CRLF +"  nvl(e2_valor,0 ) vlrtitse2 , "
cQuery += CRLF +"  nvl(e2_saldo,0 ) saldtitse2 , nvl(e2_baixa,' ') bxatitse2 , nvl(e2_emissao,' ') emstitse2 , "
cQuery += CRLF +"  sum(decode(bgq_tipo , 2 , bgq_valor, bgq_valor*-1)) tot "
cQuery += CRLF +"  from " + RetSqlName('BGQ') + " BGQ , " + RetSqlName('BBB') + " BBB , " + RetSqlName('SE2') + " SE2 "    

cQuery += CRLF +" where bgq_filial = '" + xFilial('BGQ') + "' and bgq.d_E_L_E_T_ = ' ' " 
cQuery += CRLF +"   and bbb_filial = '" + xFilial('BBB') + "' and bbb.d_E_L_E_T_ = ' ' "
cQuery += CRLF +"   and  E2_filial(+) = '" + xFilial('SE2') + "' and SE2.d_E_L_E_T_(+) = ' ' "
cQuery += CRLF +"   and bgq_codlan <> '050' and bgq_codlan = bbb_codser  
If !empty(mv_par02) 
   cQuery += CRLF +"   and bgq_ano||bgq_mes >= '"+mv_par02+mv_par01+"' "
   cQuery += CRLF +"   and bgq_ano||bgq_mes <= '"+mv_par04+mv_par03+"' " 
EndIf        
       
If !empty(mv_par05) 
   cQuery += CRLF +"   and bgq_codigo>= '"+mv_par05+"' " 
   cQuery += CRLF +"   and bgq_codigo<= '"+mv_par06+"' "
EndIf    
If !empty(mv_par07) 
   cQuery += CRLF +"   and bgq_codlan= '"+mv_par07+"' "
  /// cQuery += CRLF +"   and bgq_codlan<= '"+mv_par08+"' "
EndIf
   
cQuery += CRLF +"   and e2_codrda(+) = bgq_codigo "
cQuery += CRLF +"   and e2_pllote(+) = bgq_numlot "
cQuery += CRLF +"   and e2_tipo(+) = 'NDF' "
cQuery += CRLF +"   group by bgq_codigo ||'-'||bgq_nome , bgq_ano ||'/'|| bgq_mes , "
cQuery += CRLF +"   bgq_numlot , bgq_codlan ||'-'|| bbb_descri , bgq_usergi ,"
cQuery += CRLF +"   decode(bgq_tipo , 2 , 'Credito','Debito'), "
cQuery += CRLF +"   decode(bgq_ativo, '1' , 'Ativo','Inativo'), "
cQuery += CRLF +"   nvl(e2_pllote,' ')  , nvl(e2_codrda,' ') , "
cQuery += CRLF +"   nvl(e2_prefixo,' ') , nvl(e2_num,' ')    , "
cQuery += CRLF +"   nvl(e2_tipo,' ')    , nvl(e2_valor,0)  ,  "
cQuery += CRLF +"   nvl(e2_saldo,0) , nvl(e2_baixa,' ') , nvl(e2_emissao,' ')"   

// -------------------------------
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif
TcQuery cQuery New Alias cAliastmp

cAliastmp->(DbGoTop())

nCont := 0

COUNT TO nCont

cAliastmp->(DbGoTop())

Return nCont

/********************************************************************************************************************************/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Roberto Meirelles                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta as perguntas do SX1                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()


aHelp := {}
aAdd(aHelp, "Informe o mes da competencia inicial")
PutSX1(cPerg , "01" , "Mes Comp. De" 	,"","","mv_ch1","C",2,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano da competencia inicial")
PutSX1(cPerg , "02" , "Ano Comp. De" 	,"","","mv_ch2","C",4,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o mes da competencia final")
PutSX1(cPerg , "03" , "Mes Comp. Ate" 	,"","","mv_ch3","C",2,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano da competencia final")
PutSX1(cPerg , "04" , "Ano Comp. Ate" 	,"","","mv_ch4","C",4,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Codigo do Rda Inicial ")
PutSX1(cPerg , "05" , "Rda De  " 	,"","","mv_ch5","C",6,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
                                                                                                                                                              
aHelp := {}
aAdd(aHelp, "Informe o Codigo do Rda Final ")
PutSX1(cPerg , "06" , "Rda Ate  " 	,"","","mv_ch6","C",6,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
   
aHelp := {}
aAdd(aHelp, "Informe o Codigo Lancamento") 
//aAdd(aHelp, "Informe o Codigo Lanc. Inicial")
PutSX1(cPerg , "07" , "Codigo Lancamento" 	,"","","mv_ch7","C",3,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

/*aHelp := {}
aAdd(aHelp, "Informe o Codigo Lanc. Final")
PutSX1(cPerg , "08" , "Codigo Lanc. Ate" 	,"","","mv_ch8","C",3,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp) */


aHelp := {}
aAdd(aHelp, "Data de digitacao Inicial") 
//aAdd(aHelp, "Informe a Data de Digitação Inicial")
PutSX1(cPerg , "08" , "Data dig. De" 	,"","","mv_ch8","D",9,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Data de digitacao Final") 
//aAdd(aHelp, "Informe a Data de  Digitação Final")
PutSX1(cPerg , "09" , "Data dig. Até" 	,"","","mv_ch9","D",9,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
                                                     
RestArea(aArea2)

Return
