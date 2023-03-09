#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR101  ³ Autor ³ Leonardo Portella     ³ Data ³29/04/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de cadastros validados por validador e usuario   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR101

Local oReport 
Private cPerg	:= "CABR101"  

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

oReport	:= TReport():New("CABR101","Cadastros validados","CABR101", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de cadastros validados")

*'-----------------------------------------------------------------------------------'*
*'Solução para impressão em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //Espaçamento entre colunas. 
oReport:SetLandscape() //Impressão em paisagem.  

*'-----------------------------------------------------------------------------------'*

oRDA := TRSection():New(oReport,"Cadastros validados")
oRDA:SetTotalInLine(.F.) 
                  
TRCell():New(oRDA ,'BTS_XUSVAL'	,'BTS'	,'Usuário validou'		,/*Picture*/	,len(UsrFullName(RetCodUsr()))	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BTS_XDTVAL'	,'BTS'	,'Data valid.'			,/*Picture*/	,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BTS_XHRVAL'	,'BTS'	,'Hora valid.'			,/*Picture*/	,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BTS_XCPOAT'	,'BTS'	,'Campos atualizados'	,/*Picture*/	,100							,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BA1_NOMUSR'	,'BA1'	,'Beneficiário'			,/*Picture*/	,/*tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oRDA2 := TRSection():New(oRDA,"Campos alterados x conteúdo atual")
oRDA2:SetTotalInLine(.F.) 
                  
TRCell():New(oRDA2 ,'CPO'	,,'Campos alterados x conteúdo atual'			,/*Picture*/	,220	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

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

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local i  := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local oBreak01                             

Private oRDA   		:= oReport:Section(1)
Private oRDA2  		:= oReport:Section(1):Section(1)
Private cAlias  	:= GetNextAlias()
Private cQuery		:= ''
Private nCont		:= 0

MsgRun("Selecionando registros...","GRUPO CABERJ",{||nCont := FilTRep()})

oReport:SetMeter(nCont) 

cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0      
	
While !( cAlias->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	    
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Imprimindo a linha " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot)
	oReport:IncMeter()
	
	oRDA:init()

	cCposAlt := ' '	            
	aCposAlt := strTokArr(cAlias->(BTS_XCPOAT),'|') 
	
	If !empty(aCposAlt)             
	
		For nI := 1 to len(aCposAlt)
	       
			cBuffer := allTrim(Upper(RetTitle(aCposAlt[nI]))) 
			
			cCposAlt += cBuffer
			
			If left(aCposAlt[nI],2) == 'A1'
			     
				cCposAlt += ' COBR.'
				
			ElseIf cBuffer $ 'ENDERECO|BAIRRO|CEP|NUMERO'
			   	
			   	cCposAlt += ' RES.'
			   	 
			EndIf 		
			
			cCposAlt += ';'
		
		Next
		
		cCposAlt := left(cCposAlt,len(cCposAlt) - 1)
	
	EndIf
	
	If empty(cCposAlt)
	
		cCposAlt := '-'			
		
	EndIf
	
	oRDA:Cell('BTS_XUSVAL'	):SetValue(UsrFullName(cAlias->(BTS_XUSVAL))	)
	oRDA:Cell('BTS_XDTVAL' 	):SetValue(DtoC(StoD(cAlias->(BTS_XDTVAL)))	)
	oRDA:Cell('BTS_XHRVAL' 	):SetValue(cAlias->(BTS_XHRVAL)					)  
	oRDA:Cell('BTS_XCPOAT' 	):SetValue(cCposAlt								)
	oRDA:Cell('BA1_NOMUSR' 	):SetValue(cAlias->(BA1_NOMUSR)					)
	
	oRDA:PrintLine()
 	
 	oRDA:Finish()
 	
 	oRDA2:Init()
 	
 	aCposAlt := strTokArr(cAlias->(BTS_XCPOAT),'|') 
 	
 	DbSelectArea('SX3')    
 	SX3->(DbSetOrder(2)) 
	
	For i := 1 to len(aCposAlt)
        
        SX3->(DbGoTop())
		
		//Por alguma razao desconhecida ocorreu um caso em que o trecho abaixo estava retornando .F. quando as strings eram diferentes  
		//"B01_ALTMOL" != "B"
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³DEBUG do IDE no mesmo ponto e em sequencia:        ³
		//³!("B01_ALTMOL" == "B")							  ³	
		//³.T.  											  ³
		//³"B01_ALTMOL" != "B"                                ³
		//³.F.                                                ³
		//³"B01_ALTMOL" <> "B"                                ³
		//³.F.                                                ³ 
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		If !SX3->(MsSeek(aCposAlt[i])) .or. !( allTrim(SX3->(X3_CAMPO)) == allTrim(aCposAlt[i]) )
			loop
		EndIf                                                             

        uCpo := cAlias->&(aCposAlt[i])
		
		If !empty(uCpo)
		    
			cTitulo := allTrim(Upper(RetTitle(aCposAlt[i]))) 
			
			If left(aCposAlt[i],2) == 'A1'
			     
				cTitulo += ' COBR.'
				
			ElseIf cBuffer $ 'ENDERECO|BAIRRO|CEP|NUMERO'
			   	
			   	cTitulo += ' RES.'
			   	 
			EndIf 		
			
			oRDA2:Cell('CPO'):SetValue( cTitulo + ': ' + If(valType(uCpo) == 'N',cValToChar(uCpo),If(valType(uCpo) == 'D',DtoC(uCpo),uCpo)) )
			
			oRDA2:PrintLine()
			
		EndIf
		
	Next
 	
 	oRDA2:Finish()
 	
    cAlias->(dbSkip())

EndDo     

cAlias->(dbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
cQuery += "SELECT DISTINCT BTS_XUSVAL,BTS_XDTVAL,BTS_XHRVAL,BTS_XCPOAT,BA1_NOMUSR,A1_END,A1_BAIRRO," 		+ CRLF
cQuery += "		A1_CEP,BTS_ENDERE,BTS_NR_END,BTS_COMEND,BTS_CEPUSR,BTS_BAIRRO" 								+ CRLF
*/

cQuery += "SELECT *"																				 		+ CRLF
cQuery += "FROM " + RetSqlName('BTS') + ' BTS'							   									+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '" 								+ CRLF
cQuery += "		AND BA1_FILIAL = '" + xFilial('BA1') + "'"													+ CRLF
cQuery += "		AND BA1_MATVID = BTS_MATVID"						   										+ CRLF 
cQuery 	+= "INNER JOIN " + RetSqlName("BA3") + " BA3 ON BA3.D_E_L_E_T_ = ' '"								+ CRLF
cQuery 	+= "	AND BA3_FILIAL = '" + xFilial('BA3') + "'"													+ CRLF  
cQuery 	+= "	AND BA3_MOTBLO = ' '" 																		+ CRLF 
cQuery 	+= "	AND BA1_CODINT = BA3_CODINT"																+ CRLF 
cQuery 	+= "	AND BA1_CODEMP = BA3_CODEMP"																+ CRLF 
cQuery 	+= "	AND BA1_MATRIC = BA3_MATRIC"																+ CRLF 
cQuery 	+= "INNER JOIN " + RetSqlName("SA1") + " SA1 ON SA1.D_E_L_E_T_ = ' '"								+ CRLF 
cQuery 	+= "	AND A1_FILIAL = '" + xFilial('SA1') + "'"													+ CRLF 
cQuery 	+= "	AND A1_COD = BA3_CODCLI"																	+ CRLF 
cQuery += "WHERE BTS.D_E_L_E_T_ = ' '"																		+ CRLF
cQuery += "		AND BTS_FILIAL = '" + xFilial('BTS') + "'" 													+ CRLF
cQuery += "		AND BTS_XSTATU = 'V'" 																		+ CRLF
cQuery += "		AND BTS_XDTVAL BETWEEN '" + DtoS(mv_par01) + "' AND '" + DtoS(mv_par02) + "'"				+ CRLF                                                                                                       

If empty(mv_par08)
	cQuery += "		AND BTS_XUSVAL BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"						+ CRLF                                                                                                       
Else 
	aLogins 	:= strTokArr(mv_par08,';')
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
cQuery += "ORDER BY BTS_XUSVAL,BTS_XDTVAL,BTS_XHRVAL,BA1_NOMUSR,BTS_XCPOAT" 								+ CRLF

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
aAdd(aHelp, "Informe a operadora do usuario")      
aAdd(aHelp, "(4 primeiros digitos da matricula)")      
PutSX1(cPerg , "05" , "Operadora"  				,"","","mv_ch5","C",TamSx3('BD7_OPEUSR')[1]	,0,0,"G",""	,""			,"","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

//MATUSR -> consulta especifica
aHelp := {}
aAdd(aHelp, "Informe a matricula inicial do usuario.")
PutSX1(cPerg , "06" , "Matr. usuário de" 		,"","","mv_ch6","C",TamSx3('BE4_USUARI')[1]	,0,0,"G",""	,"MATUSR"	,"","","mv_par06","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

//MATUSR -> consulta especifica
aHelp := {}
aAdd(aHelp, "Informe a matricula final do usuario.")
PutSX1(cPerg , "07" , "Matr. usuário ate" 		,"","","mv_ch7","C",TamSx3('BE4_USUARI')[1]	,0,0,"G",""	,"MATUSR"	,"","","mv_par07","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a lista de logins de usuarios que")
aAdd(aHelp, "se quer filtrar, exemplo: fulano, beltrano")
aAdd(aHelp, "Separe os logins por ','")
PutSX1(cPerg , "08" , "Usuarios" 	 			,"","","mv_ch8","C",99							,0,0,"G",""	,""			,"","","mv_par08","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return

******************************************************************************************************************************
