#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR106  ³ Autor ³ Leonardo Portella     ³ Data ³29/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de tentativa de atualizacao de cadastro sem      ³±±
±±³          ³ sucesso por validador e usuario   						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR106

Local oReport 
Private cPerg	:= "CABR106"  

oReport:= ReportDef()
oReport:PrintDialog()

Return

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
Local oTotal
Local oRDA
Local oRDA2
Local oCompet

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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport	:= TReport():New("CABR106","Tentativa de atualização de cadastros sem sucesso","CABR106", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de Tentativa de atualização de cadastros sem sucesso")

*'-----------------------------------------------------------------------------------'*
*'Solução para impressão em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //Espaçamento entre colunas. 
oReport:SetLandscape() //Impressão em paisagem.  

*'-----------------------------------------------------------------------------------'*

oTotal := TRSection():New(oReport,"Tentativa de atualização de cadastros sem sucesso")
oTotal:SetTotalInLine(.F.)   
                  
TRCell():New(oTotal ,'BTS_XUSVAL'	,'BTS'	,' ',/*Picture*/	,len(UsrFullName(RetCodUsr()))	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oTotal ,'BTS_XDTVAL'	,'BTS'	,' ',/*Picture*/	,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oTotal ,'BTS_XHRVAL'	,'BTS'	,' ',/*Picture*/	,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oTotal ,'BA1_NOMUSR'	,'BA1'	,' ',/*Picture*/	,/*tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oTotal:SetTotalText("Total geral")

TRFunction():New(oTotal:Cell("BA1_NOMUSR")	,NIL,"COUNT"	,/*oBreak1*/,"@E 999,999,999.99",,/*uFormula*/,.T.,.F.)

oRDA := TRSection():New(oReport,"Tentativa de atualização de cadastros sem sucesso")
oRDA:SetTotalInLine(.F.)   
                  
TRCell():New(oRDA ,'BTS_XUSVAL'	,'BTS'	,'Usuário validou'		,/*Picture*/	,len(UsrFullName(RetCodUsr()))	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BTS_XDTVAL'	,'BTS'	,'Data valid.'			,/*Picture*/	,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BTS_XHRVAL'	,'BTS'	,'Hora valid.'			,/*Picture*/	,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BA1_NOMUSR'	,'BA1'	,'Beneficiário'			,/*Picture*/	,/*tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oRDA2 := TRSection():New(oRDA,"Observação do validador")
oRDA2:SetTotalInLine(.F.) 
                  
TRCell():New(oRDA2 ,'OBS'	,,'Observação do validador'			,/*Picture*/	,220	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

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

Static Function ReportPrint(oReport)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local oBreak01                             

Private oTotal   	:= oReport:Section(1)
Private oRDA   		:= oReport:Section(2)
Private oRDA2  		:= oReport:Section(2):Section(1)
Private cAlias  	:= GetNextAlias()
Private cQuery		:= ''
Private nCont		:= 0
              
MsgRun("Selecionando registros...","GRUPO CABERJ",{||nCont := FilTRep()})

oReport:SetMeter(nCont) 

cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0

oTotal:init()

oTotal:Cell('BTS_XUSVAL'):Hide()
oTotal:Cell('BTS_XDTVAL'):Hide()
oTotal:Cell('BTS_XHRVAL'):Hide()
oTotal:Cell('BA1_NOMUSR'):Hide()

oTotal:Cell('BA1_NOMUSR'):SetBlock({||'COUNT'})

While !( cAlias->(Eof()) )
    
	oTotal:PrintLine()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	    
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Imprimindo a linha " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot)
	oReport:IncMeter()
	
	oRDA:init()
	
	oRDA:Cell('BTS_XUSVAL'):SetValue(UsrFullName(cAlias->(BTS_XUSVAL))	)
	oRDA:Cell('BTS_XDTVAL'):SetValue(DtoC(StoD(cAlias->(BTS_XDTVAL)))	)
	oRDA:Cell('BTS_XHRVAL'):SetValue(cAlias->(BTS_XHRVAL)					)  
	oRDA:Cell('BA1_NOMUSR'):SetValue(cAlias->(BA1_NOMUSR)					)
	
	oRDA:PrintLine()
 	
	oRDA:Finish()
	
	oRDA2:init()   
	
	BTS->(dbGoTo(cAlias->(RECNOBTS)))
	
	cEnt 	:= char(13)+char(10)
	 
	cMemo 	:= MSMM(BTS->BTS_XOBSAT,,,,3,,,"BTS","BTS_XOBSAT")
	
	aTexto 	:= strTokArr(cMemo,cEnt)
	
	For i := 1 to len(aTexto)
        
        aLinhas := qbTexto(aTexto[i],200," ")
		                                
		For j := 1 to len(aLinhas)
		
			oRDA2:Cell('OBS'):SetValue(aLinhas[j])
		
			oRDA2:PrintLine()
			
		Next
		
	Next
	
	oRDA2:Finish()

 	cAlias->(dbSkip())

EndDo        

oTotal:Finish()

cAlias->(dbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQuery += "SELECT DISTINCT BTS_XUSVAL,BTS_XDTVAL,BTS_XHRVAL,BA1_NOMUSR,BTS.R_E_C_N_O_ RECNOBTS" 			+ CRLF
cQuery += "FROM " + RetSqlName('BTS') + ' BTS'							   									+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '" 								+ CRLF
cQuery += "		AND BA1_FILIAL = '" + xFilial('BA1') + "'"													+ CRLF
cQuery += "		AND BA1_MATVID = BTS_MATVID"						   										+ CRLF
cQuery += "WHERE BTS.D_E_L_E_T_ = ' '"																		+ CRLF
cQuery += "		AND BTS_FILIAL = '" + xFilial('BTS') + "'" 													+ CRLF
cQuery += "		AND BTS_XSTATU = 'I'" 																		+ CRLF
cQuery += "		AND BTS_XDTVAL BETWEEN '" + DtoS(mv_par01) + "' AND '" + DtoS(mv_par02) + "'"				+ CRLF

If empty(mv_par08)
	cQuery += "		AND BTS_XUSVAL BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"						+ CRLF                                                                                                       
Else 
	aLogins 	:= strTokArr(allTrim(mv_par08),';')
	cLogins 	:= ''
	cLoginsNEnc := ''
	
	For nI := 1 to len(aLogins)  
	
		PswOrder(2)//Ordem por Login

	    If PswSeek(aLogins[nI],.T.)
	    	aGrupos := Pswret(1)
			cLogins += aGrupos[1][1] + ','
	    Else
	    	cLoginsNEnc += ' - ' + aLogins[nI] + ';' + CRLF	
		EndIf
		
	Next  
	
	If !empty(cLoginsNEnc)                         
		cLoginsNEnc := 'Logins não encontrados' + CRLF + CRLF + cLoginsNEnc             
		logErros(cLoginsNEnc,'Logins não encontrados')
	EndIf
	
	cLogins := left(cLogins,len(cLogins) - 1)
	
	cQuery += "		AND BTS_XUSVAL IN " + FormatIn(cLogins,',') + CRLF                                                                                                       
EndIf

cQuery += "		AND BA1_CODEMP = '" + mv_par05 + "'" 	 													+ CRLF
cQuery += "		AND BA1_MATRIC BETWEEN '" + substr(mv_par06,9,6) + "' AND '" + substr(mv_par07,9,6) + "'"	+ CRLF
cQuery += "ORDER BY BTS_XUSVAL,BTS_XDTVAL,BTS_XHRVAL,BA1_NOMUSR" 							  				+ CRLF

TcQuery cQuery New Alias cAlias

cAlias->(dbGoTop())

nCont := 0
cAlias->(dbEval({||++nCont}))

cAlias->(dbGoTop())

Return nCont

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Leonardo Portella                       ³±±
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
aAdd(aHelp, "Informe a data de validacao inicial")         
PutSX1(cPerg , "01" , "Data Valid. de" 			,"","","mv_ch1","D",08							,0,0,"G",""	,""			,"","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de validacao  final")         
PutSX1(cPerg , "02" , "Data Valid. ate" 		,"","","mv_ch2","D",08							,0,0,"G",""	,""			,"","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o usuario validador inicial")      
PutSX1(cPerg , "03" , "Usr. Valid. de" 			,"","","mv_ch3","C",TamSx3('BTS_XUSVAL')[1]	,0,0,"G",""	,"USRPRO"	,"","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o usuario validador inicial")      
PutSX1(cPerg , "04" , "Usr. Valid. ate" 		,"","","mv_ch4","C",TamSx3('BTS_XUSVAL')[1]	,0,0,"G",""	,"USRPRO"	,"","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a operadora do beneficiário")      
aAdd(aHelp, "(4 primeiros digitos da matricula)")      
PutSX1(cPerg , "05" , "Operadora"  				,"","","mv_ch5","C",TamSx3('BD7_OPEUSR')[1]	,0,0,"G",""	,""			,"","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

//MATUSR -> consulta especifica
aHelp := {}
aAdd(aHelp, "Informe a matricula inicial do beneficiário.")
PutSX1(cPerg , "06" , "Matr. usuário de" 		,"","","mv_ch6","C",TamSx3('BE4_USUARI')[1]	,0,0,"G",""	,"MATUSR"	,"","","mv_par06","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

//MATUSR -> consulta especifica
aHelp := {}
aAdd(aHelp, "Informe a matricula final do beneficiário.")
PutSX1(cPerg , "07" , "Matr. usuário ate" 		,"","","mv_ch7","C",TamSx3('BE4_USUARI')[1]	,0,0,"G",""	,"MATUSR"	,"","","mv_par07","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a lista de logins de usuarios que")
aAdd(aHelp, "se quer filtrar, exemplo: fulano, beltrano")
aAdd(aHelp, "Separe os logins por ','")
PutSX1(cPerg , "08" , "Usuarios" 	 			,"","","mv_ch8","C",99							,0,0,"G",""	,""			,"","","mv_par08","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return

******************************************************************************************************************************


