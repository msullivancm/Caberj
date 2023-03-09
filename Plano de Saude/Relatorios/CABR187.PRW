#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "msgraphi.ch"
#include "fileio.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR187  ³ Autor ³ Roberto Meirelles    ³ Data ³ 12/07/2015 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio Profissional de Saúde  - João Paulo(GERED)       |±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR187

Local oReport 
Private cPerg		:= "CABR187"  
Private aOrdem 		:= {'CODIGO'}        
 
Private cSiglaDe	
Private cSiglaAte	
Private cUfDe		 
Private cUfAte		
Private cVinculo 
Private nSintAnal	
Private dDataIni     
Private dDAtaFin     

oReport:= ReportDef()
oReport:PrintDialog()    


Return

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Roberto meirelles    |      |          ³±±
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
Local oRemessa     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()

Pergunte(cPerg,.F.)

/*cSiglaDe	:= mv_par01					//-- Sigla C.R. Inicial
cSiglaAte	:= mv_par02					//-- Sigla C.R. Final
cUfDe		:= mv_par03					//-- Estado C.R. Inicial 
cUfAte		:= mv_par04					//-- Estado C.R. Final
nVinculo	:= mv_par05					//-- Vinculo : Faz parte da Rede ou Nao faz parte da Rede
nSintAnal	:= mv_par06					//-- RElatorio modo sintetico ou analitico
dDataIni    := mv_par07				    //-- Data Inicial de Inclusão 
dDAtaFin    := mv_par08				    //-- Data Final de Inclusão */
cVinculo := STR(mv_par03)
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

oReport	:= TReport():New("CABR187","PROFISSIONAL DE SAÚDE ","CABR187", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de Profissionais de Saúde  por Data de Inclusão")

oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
//oReport:SetLandscape() //Impressao em paisagem.  
oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*

oRemessa := TRSection():New(oReport,"PROFISIONAL")
oRemessa:SetTotalInLine(.F.) 

TRCell():New(oRemessa ,'CODIGO'		 		,     	,'Cod  PRO'		    		,/*Picture*/ 				,08				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'CRM' 		 		,     	,'Cod  CRM'		    		,/*Picture*/ 				,08				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'NOME'		 		,   	,'Descrição'              	,/*Picture*/ 				,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New(oRemessa ,'ENDERECO'			,		,'Endereço '				,/*Picture*/ 				,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//TRCell():New(oRemessa ,'BAIRRO'			,		,'Bairro'     				,/*Picture*/			    ,10	            ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'NUMCR'			    ,       ,'Num CR' 					,/*Picture*/			    ,15          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'CGC'				,		,'CPF' 	                    ,/*Picture*/				,14             ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'ESTADO'			    ,       ,'UF' 						,/*Picture*/				,02          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRemessa ,'DATA'				,		,'Data Inclusão' 	        ,/*Picture*/				,10             ,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

//oBreak01 		:= TRBreak():New(oRemessa,oRemessa:Cell("CODIGO"),"Subtotal por GRUPO PAGTO" 	,.F.)  

//lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
//lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

//TRFunction():New(oRemessa:Cell("VLRTIT")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01/)
//TRFunction():New(oRemessa:Cell("SALTIT")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
//TRFunction():New(oRemessa:Cell("TOTAL")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
//TRFunction():New(oRemessa:Cell("ARECUP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)

Return(oReport)

********************************************************************************************************************************

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
    
    If ( CTOD(dtdigtacao) < mv_par05 ) .or. ( CTOD(dtdigtacao) > mv_par06 )
		cAliastmp->(DbSkip())		    
		Loop
    EndIf
    
    //statusLanca := statusla
    //statusLanca :=(1,'Ativo','Inativo')                                                   
	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)
	oReport:IncMeter()
  
	oRemessa:Cell('CODIGO' 		):SetValue(cAliastmp->(codigo))
	oRemessa:Cell('CRM' 		):SetValue(cAliastmp->(crm))
	oRemessa:Cell('NOME' 		):SetValue(cAliastmp->(nome))
   //oRemessa:Cell('ENDERECO' 	):SetValue(cAliastmp->(endereco))
   //oRemessa:Cell('BAIRRO' 		):SetValue(cAliastmp->(bairro))
    oRemessa:Cell('NUMCR' 		):SetValue(cAliastmp->(numcr))
    oRemessa:Cell('CGC' 		):SetValue(cAliastmp->(cgc))
    oRemessa:Cell('ESTADO'		):SetValue(cAliastmp->(estado))
    oRemessa:Cell('DATA'		):SetValue( dtdigtacao ) 
    
	oRemessa:PrintLine()
		
    cAliastmp->(DbSkip())
    
EndDo

oRemessa:Finish()

cAliastmp->(DbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

Local i := 0

ProcRegua(0)
cVinculo := STR(mv_par03)
For i := 1 to 5
	IncProc('Selecionando registros a serem analisados...')
Next
              
cQuery := "SELECT BB0_VINC vincred, 
cQuery +=       " BB0_CODIGO codigo,
cQuery +=       " BB0_CODSIG crm, 
cQuery +=       " BB0_NOME nome , 
cQuery +=       " BB0_ENDERE endereco ,
cQuery +=       " BB0_BAIRRO bairro, 
cQuery +=       " BB0_ESTADO estado, 
cQuery +=       " BB0_CGC cgc,
cQuery +=       " BB0_NUMCR numcr,  
cQuery +=       " BB0_USERGI datdig      
cQuery += "  from " + RetSqlName('BB0') + " BB0  " 					     				+ CRLF 
cQuery += " where bb0_filial = '" + xFilial('BB0') + "' and bb0.d_E_L_E_T_ = ' '  and bb0_usergi <> '  ' "   		+ CRLF 
cQuery += "   and bb0_vinc = '"+alltrim(cVinculo)+"' "  											+ CRLF

If !empty(mv_par01) 
   cQuery += " AND  bb0_CODSIG IN "+alltrim(FormatIn(mv_par01,","))                             + CRLF 
EndIf        
       
If !empty(mv_par02) 
   cQuery += " and bb0_estado IN "+alltrim(FormatIn(mv_par02,","))    						+ CRLF
EndIf    

   

If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif

TcQuery cQuery New Alias cAliastmp

cAliastmp->(DbGoTop())

nCont := 0

COUNT TO nCont

cAliastmp->(DbGoTop())

Return nCont

********************************************************************************************************************************


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
aAdd(aHelp, "Informe a Sigla CR DE")
PutSX1(cPerg , "01" , "Sigla C.R. " 	,"","","mv_ch1","C",30,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Estado CR DE")
PutSX1(cPerg , "02" , "Estado C.R. " 	,"","","mv_ch2","C",30,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Vinculo ")        
PutSX1(cPerg , "03" , "Vinculo" 	,"","","mv_ch3","N",1,0,0,"C","","","","","mv_par03","Pertence Rede"   ,"","","","N/Pertence Rede","","","","","","","","","","","",aHelp,aHelp,aHelp)

                                                                                                                                                              
aHelp := {}
aAdd(aHelp, "Informe o Tipo Impressao ")
PutSX1(cPerg , "04" , "Tipo Impressao  " 	,"","","mv_ch4","N" ,  1,0,0,"C","","","","","mv_par04","Analitico"   ,"","","","Sintetico","","","","","","","","","","","",aHelp,aHelp,aHelp)
   
aHelp := {}
aAdd(aHelp, "Data Inclusao De") 
PutSX1(cPerg , "05" , "Data Inclusao De" 	,"","","mv_ch5","D", 9,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Data Inclusao Ate") 
PutSX1(cPerg , "06" , "Data Inclusao Ate" 	,"","","mv_ch6","D",9,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
                                                     
RestArea(aArea2)

Return