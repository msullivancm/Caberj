
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "msgraphi.ch"
#include "fileio.ch"     
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR199  ³ Autor ³ Altamiro affonso     ³ Data ³ 19/06/2015 ³±±
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

User Function CABR199

Local oReport 
Private cPerg		:= "CABR199"  
Private aOrdem 		:= {'MATVID', 'MATBLO'}            

Private adados      := {}
private acabe       := {}

/*private cMesInc     := mv_par01 
private cAnoInc     := mv_par02
private cMesFinal   := mv_par03
private cAnoFinal   := mv_par04
private cRdaInc     := mv_par05
private cRdaFinal   := mv_par06 
private cCodlanInc  := mv_par07
//private cCodLanFinal:= mv_par08
private dDatIni     := mv_par08 
private dDatFinal   := mv_par09
*/

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

oReport	:= TReport():New("CABR199","Relação de usuarios com matriculas Bloqueadas Mas com outra ativa e que deixaram Debitos em aberto ","CABR199", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de Debitos de matriculas bloquedas de usuarios com outra matricula ativa ")

oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
oReport:SetTotalText('Total por matricula da Vida ') 

/*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*/

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

/*'-----------------------------------------------------------------------------------'*/
                                                                
oRemessa := TRSection():New(oReport,"Relação de usuarios com matriculas Bloqueadas Mas com outra ativa e que deixaram Debitos em aberto ",,aOrdem)

TRCell():New(oRemessa ,'MATVID'		 		,     	,'Mat.Vida'		        ,/*Picture*/ 				,08				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'MATBLO'		 		,   	,'Mat. Bloqueada '      ,/*Picture*/ 				,50				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'DATBLO'			    ,    	,'Dt Do Bloq'  	    	,/*Picture*/  				,10         	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oRemessa ,'TITABR'			    ,		,'Tit em Aberto '	    ,/*Picture*/ 				,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'SALDO'			    ,       ,'Saldo Tit.' 	        ,"@E 9,999,999.99" 			,12          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'DESDSP'			    ,		,'Descr. Compos.'	    ,/*Picture*/ 				,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'VLRCMP'			    ,       ,'Vlr Comp.' 	        ,"@E 9,999,999.99" 			,12          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'MATATV'		 		,   	,'Mat. Ativa'           ,/*Picture*/ 				,50				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
TRCell():New(oRemessa ,'DATINC'			    ,    	,'Dt Do Inic'  	    	,/*Picture*/  				,10         	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) 
               
If mv_par06 = 1
   oBreak01 		:= TRBreak():New(oRemessa,oRemessa:Cell("MATBLO"),"Subtotal por Matricula Familia" 	,.F.)  
Else                                                                                                       
   oBreak01 		:= TRBreak():New(oRemessa,oRemessa:Cell("MATVID"),"Subtotal por Matricula da Vida" 	,.F.)  
EndIf
lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

//TRFunction():New(oRemessa:Cell("SALDO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
TRFunction():New(oRemessa:Cell("VLRCMP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)

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
private ddtedt      := stod('20150101')

//Executa query que alimenta o alias cAliasCart 
Processa({||nCont := FilTRep()},AllTrim(SM0->M0_NOMECOM))

//Se nao tiver esta linha, nao imprime os dados
oRemessa:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       
nCritic	:= 0

While !( (cAliastmp)->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf
	    
    //statusLanca := statusla
    //statusLanca :=(1,'Ativo','Inativo')                                                   
	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)
	oReport:IncMeter()        
     
  
	oRemessa:Cell('MATVID'		):SetValue((cAliastmp)->(matvidblq))
	oRemessa:Cell('MATBLO' 		):SetValue((cAliastmp)->(MATRICBLQ))
	ddtedt := stod((cAliastmp)->(DATBLO)) 
	oRemessa:Cell('DATBLO' 		):SetValue(ddtedt)        
    oRemessa:Cell('TITABR'		):SetValue((cAliastmp)->(TIT))      
    oRemessa:Cell('SALDO'		):SetValue((cAliastmp)->(sldtit))
    oRemessa:Cell('DESDSP'		):SetValue((cAliastmp)->(descmp)) 
    oRemessa:Cell('VLRCMP'		):SetValue((cAliastmp)->(vlrcmp))   
    oRemessa:Cell('MATATV'		):SetValue((cAliastmp)->(MATRICATV)) 
  	ddtedt := stod((cAliastmp)->(DTINC))  
    oRemessa:Cell('DATINC'		):SetValue(ddtedt)       

	oRemessa:PrintLine()
	
   aAdd(aDados,{(cAliastmp)->(imageblq)  , ;
            stod((cAliastmp)->(DATBLO))  , ;
                (cAliastmp)->(matvidblq) , ;  
                (cAliastmp)->(MATRICBLQ) , ;
                (cAliastmp)->(descmp)    , ; 
                (cAliastmp)->(vlrcmp)    , ;
            stod((cAliastmp)->(VENCREA)) , ;
                (cAliastmp)->(CODCLI)    , ;
                (cAliastmp)->(TIT)       , ;
                (cAliastmp)->(sldtit)    , ; 
                (cAliastmp)->(MABase)    , ;
            stod((cAliastmp)->(DTINC))   , ;
                (cAliastmp)->(imageatv)  , ;
                (cAliastmp)->(matvidatv) , ; 
                (cAliastmp)->(MATRICATV) } ) 
		
    (cAliastmp)->(DbSkip())
    
EndDo

oRemessa:Finish()

(cAliastmp)->(DbCloseArea())

Return   

/********************************************************************************************************************************/

Static Function FilTRep

Local i := 0

ProcRegua(0)

For i := 1 to 5
	IncProc('Selecionando registros a serem analisados...')
Next

//---------------------------------    

cQuery := " select BA1.ba1_image imageblq , "
cQuery += CRLF +"  BA1.BA1_DATBLO DATBLO , "
cQuery += CRLF +"  BA1.ba1_matvid matvidblq , "
cQuery += CRLF +"  BA1.ba1_codint || '.'||BA1.BA1_CODEMP ||'.'||BA1.BA1_MATRIC || '.'||BA1.BA1_TIPREG ||'-'|| BA1.BA1_NOMUSR MATRICBLQ , "
cQuery += CRLF +"  bm1_codtip||'-'|| bm1_destip descmp , "
cQuery += CRLF +"  BM1.BM1_VALOR vlrcmp , "
cQuery += CRLF +"  se1.E1_VENCREA vencrea , "
cQuery += CRLF +"  BA3.BA3_CODCLI codcli , "
cQuery += CRLF +"  SE1.E1_PREFIXO ||' '||SE1.E1_NUM ||' '||SE1.E1_PARCELA ||' '||SE1.E1_TIPO TIT , "
cQuery += CRLF +"  SE1.E1_SALDO  sldtit, "
cQuery += CRLF +"  SE1.E1_MESBASE||'/'|| SE1.E1_ANOBASE MABase , " 
cQuery += CRLF +"  BA11.BA1_DATINC DTINC , " 
cQuery += CRLF +"  BA11.ba1_image imageatv , "
cQuery += CRLF +"  BA11.ba1_matvid matvidatv , "
cQuery += CRLF +"  BA11.ba1_codint ||'.'|| BA11.BA1_CODEMP ||'.'||BA11.BA1_MATRIC ||'.'|| BA11.BA1_TIPREG||'-'|| BA11.BA1_NOMUSR MATRICATV "  

cQuery += CRLF +"  from " + RetSqlName('BA1') + " BA1 , " + RetSqlName('SE1') + " SE1 , " + RetSqlName('BM1') + " BM1 , " + RetSqlName('BA1') + " BA11 , " + RetSqlName('BA3') + " BA3 "  
cQuery += CRLF +"  WHERE  BA1.BA1_FILIAL = '" + xFilial('BA1') + "' AND  BA1.D_e_l_e_t_ = ' ' " 
cQuery += CRLF +"    AND BA11.BA1_FILIAL = '" + xFilial('BA1') + "' AND BA11.D_e_l_e_t_ = ' ' "
cQuery += CRLF +"    AND  se1.E1_FILIAL  = '" + xFilial('SE1') + "' AND  SE1.D_e_l_e_t_ = ' ' "
cQuery += CRLF +"    AND  bm1.BM1_FILIAL = '" + xFilial('BM1') + "' AND  BM1.D_E_L_E_T_ = ' ' " 
cQuery += CRLF +"  AND BA1.BA1_IMAGE = 'DISABLE' "	
cQuery += CRLF +"  AND BA1.ba1_codint = BM1.bM1_codint "
cQuery += CRLF +"  AND BA1.BA1_CODEMP = BM1.BM1_CODEMP "
cQuery += CRLF +"  AND BA1.BA1_MATRIC = BM1.BM1_MATRIC " 
cQuery += CRLF +"  AND BA1.BA1_TIPREG = BM1.BM1_TIPREG "
cQuery += CRLF +"  AND BM1.BM1_PREFIX = SE1.E1_PREFIXO "
cQuery += CRLF +"  AND BM1.BM1_NUMTIT = SE1.E1_NUM     "
cQuery += CRLF +"  AND BM1.BM1_PARCEL = SE1.E1_PARCELA "
cQuery += CRLF +"  AND BM1.BM1_TIPTIT = SE1.E1_TIPO    "
If !empty(trim(mv_par01))   
    cQuery += CRLF +"  and bm1.bm1_codemp     in "+FormatIn(mv_par01, ",") "
Endif                                                                      
If !empty(trim(mv_par02))   
    cQuery += CRLF +"  and bm1.bm1_codemp NOT in "+FormatIn(mv_par02, ",") "
EndIf                       
If !empty(trim(mv_par03))   
    cQuery += CRLF +"  and bm1.bm1_codtip     in "+FormatIn(mv_par03, ",") "
EndIf                       
If !empty(trim(mv_par04))   
    cQuery += CRLF +"  and bm1.bm1_codtip NOT in "+FormatIn(mv_par04, ",") "
EndIf   
iF mv_par05= 2
   cQuery += CRLF +"  and ( ba3_cobniv = '1' or ba1.ba1_cobniv = '1' ) "
ElseiF mv_par05= 1 
   cQuery += CRLF +"  and ( ba3_cobniv <>  '1' and  ba1.ba1_cobniv <>  '1' ) "
EndIf  
cQuery += CRLF +"  and bm1.bm1_codtip <> '0108' "
cQuery += CRLF +"  AND BA1.BA1_MATVID = BA11.BA1_MATVID  AND BA1.R_E_C_N_O_ <> BA11.R_E_C_N_O_ "
cQuery += CRLF +"  and ba11.ba1_image = 'ENABLE' "
cQuery += CRLF +"  AND BA11.Ba1_codint = BA3.BA3_codint "
cQuery += CRLF +"  AND BA11.BA1_CODEMP = BA3.BA3_CODEMP "
cQuery += CRLF +"  AND BA11.BA1_MATRIC = BA3.BA3_MATRIC " 
    
cQuery += CRLF +"  AND SE1.E1_SALDO > 0  "
if mv_par06 = 1
   cQuery += CRLF +"  ORDER BY  BA1.ba1_codint || BA1.BA1_CODEMP ||BA1.BA1_MATRIC || BA1.BA1_TIPREG "
Else                                                                                                  
   cQuery += CRLF +"  ORDER BY  BA1.BA1_MATVID " 
EndIf     
 cQuery += CRLF +" , SE1.E1_PREFIXO ||' '||SE1.E1_NUM ||' '||SE1.E1_PARCELA ||' '||SE1.E1_TIPO

// -------------------------------
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif
TcQuery cQuery New Alias (cAliastmp)

(cAliastmp)->(DbGoTop())

nCont := 0

COUNT TO nCont

(cAliastmp)->(DbGoTop())

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
aAdd(aHelp, "Informe Empresa a Sair, vazio todos e listado ")
PutSX1(cPerg , "01" , "Empresa a Listar " 	    ,"","","mv_ch1","C",99,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe Empresas a Não Sair, vazio todos e listado ")
PutSX1(cPerg , "02" , "Empresas a Não Listar" 	,"","","mv_ch2","C",99,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe Cod Do Tipo a sair, vazio todos e listado ")
PutSX1(cPerg , "03" , "Cod do Tipo a Sair " 	,"","","mv_ch3","C",99,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe Cod Do Tipo a Não sair, vazio todos e listado ")
PutSX1(cPerg , "04" , "Cod do Tipo a Não Sair " ,"","","mv_ch4","C",99,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe Se lista Cobrança familial , empresa ou em branco Todos")
PutSX1(cPerg , "05" , "Listar ?     " 	,"","","mv_ch5","N",1,0,0,"C","","","","","mv_par05","Empresarial","","","","Colet.Adesao","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Ordermar por Matricula da familia ou por Matricula da Vida ")
PutSX1(cPerg , "06" , "Ordenar Por ? " 	,"","","mv_ch6","N",1,0,0,"C","","","","","mv_par06","Mat.Familia ","","","","Mat.Vida","","","","","","","","","","","",aHelp,aHelp,aHelp)
                                                     
RestArea(aArea2)

Return
