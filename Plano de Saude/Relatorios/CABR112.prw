#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR112  ³ Autor ³ Leonardo Portella     ³ Data ³20/06/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de inclusão - dados pessoais.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR112()

Local oReport 
Private cPerg	:= "CABR112"  

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
Local oUsr
Local oUsr2
Local oUsr3
Local oUsr4
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

oReport	:= TReport():New("CABR112","Relatorio de inclusão - dados pessoais","CABR112", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de inclusões - dados pessoais")

*'-----------------------------------------------------------------------------------'*
*'Solução para impressão em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(0) //Espaçamento entre colunas. 
oReport:SetLandscape() //Impressão em paisagem.  

*'-----------------------------------------------------------------------------------'*

oUsr := TRSection():New(oReport,"Relatorio de inclusão - dados pessoais")
oUsr:SetTotalInLine(.F.)   
 
nTamMatric := TamSx3('BA1_CODINT')[1] + TamSx3('BA1_CODEMP')[1] + TamSx3('BA1_MATRIC')[1] + TamSx3('BA1_TIPREG')[1] + TamSx3('BA1_DIGITO')[1] + 4

TRCell():New(oUsr ,'MATRIC'		,		,'Matricula'			,/*Picture*/	,nTamMatric		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_NOMUSR'	,'BA1'	,						,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_CPFUSR'	,'BA1'	,						,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_DATNAS'	,'BA1'	,						,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_DATINC'	,'BA1'	,						,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'CARENCIA'	,		,'Dt carencia'	  		,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_DESUSU'	,'BA1'	,'Tipo usuario'			,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_DESCIV'	,'BA1'	,'Estado civil'			,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_DESGRA'	,'BA1'	,'Parentesco'			,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_YDTLIM'	,'BA1'	,						,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oUsr2 := TRSection():New(oUsr,"Informações complementares")
oUsr2:SetTotalInLine(.F.)     

TRCell():New(oUsr2 ,'BA1_MAE'  		,'BA1',					,/*Picture*/	,TamSX3('BA1_NOMUSR')[1]	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr2 ,'BA1_CPFPRE'	,'BA1',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr2 ,'BA1_NOMPRE'	,'BA1',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr2 ,'BA1_NOMTIT'	,'BA1',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr2 ,'BA3_MATEMP'	,'BA3',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr2 ,'BA3_AGMTFU'	,'BA1',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr2 ,'BI3_NREDUZ'	,'BI3','Plano'			,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr2 ,'BA1_ORIEND'	,'BA1',					,/*Picture*/	,13				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oUsr3 := TRSection():New(oUsr,"Endereços")
oUsr3:SetTotalInLine(.F.)     

TRCell():New(oUsr3 ,'BA1_ENDERE' 	,'BA1',	"End. Res."		,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr3 ,'BA1_NR_END'	,'BA1',	"Num. Res."		,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr3 ,'BA1_COMEND'	,'BA1',	"Complemento"	,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr3 ,'BA1_TELEFO'	,'BA1',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr3 ,'BA1_YCEL'		,'BA1',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr3 ,'A1_END'  		,'SA1',	"End. Cobr."	,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oUsr4 := TRSection():New(oUsr,"Contrato e subcontrato")
oUsr4:SetTotalInLine(.F.)     

TRCell():New(oUsr4 ,'BQC_NUMCON' 	,'BQC',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr4 ,'BQC_VERCON' 	,'BQC',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr4 ,'BQC_SUBCON' 	,'BQC',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr4 ,'BQC_VERSUB' 	,'BQC',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr4 ,'BQC_DESCRI' 	,'BQC',					,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

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

Local oBreak01                             

Private oUsr   		:= oReport:Section(1)
Private oUsr2  		:= oReport:Section(1):Section(1)
Private oUsr3  		:= oReport:Section(1):Section(2)
Private oUsr4  		:= oReport:Section(1):Section(3)
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
	
	oUsr:init()
	
	oUsr:Cell('MATRIC'		):SetValue(cAlias->(MATRIC)				)
	oUsr:Cell('BA1_NOMUSR'	):SetValue(cAlias->(BA1_NOMUSR)	  		)
	oUsr:Cell('BA1_CPFUSR'	):SetValue(cAlias->(BA1_CPFUSR)	  		)  
	oUsr:Cell('BA1_DATNAS'	):SetValue(StoD(cAlias->(BA1_DATNAS))	)
	oUsr:Cell('BA1_DATINC'	):SetValue(StoD(cAlias->(BA1_DATINC))	)
	oUsr:Cell('CARENCIA'	):SetValue(StoD(cAlias->(CARENCIA))	)
	oUsr:Cell('BA1_YDTLIM'	):SetValue(StoD(cAlias->(BA1_YDTLIM))	)
   	oUsr:Cell('BA1_DESUSU'	):SetValue(Posicione("BIH",1,xFilial("BIH") + cAlias->(BA1_TIPUSU),"BIH_DESCRI")			)
	oUsr:Cell('BA1_DESCIV'	):SetValue(Posicione("SX5",1,xFilial("SX5") + "33" + cAlias->(BA1_ESTCIV),"X5_DESCRI") 	)
	oUsr:Cell('BA1_DESGRA'	):SetValue(Posicione("BRP",1,xFilial("BRP") + cAlias->(BA1_GRAUPA),"BRP_DESCRI")			)

	oUsr:PrintLine()
 	
	oReport:FatLine()     
    
 	oUsr:Finish()
	
	oUsr2:init()   
	               
	oUsr2:Cell('BA1_MAE'	):SetValue(cAlias->(BA1_MAE)   		)
	oUsr2:Cell('BA1_CPFPRE'	):SetValue(cAlias->(BA1_CPFPRE)		)
	oUsr2:Cell('BA1_NOMPRE'	):SetValue(cAlias->(BA1_NOMPRE)		)
	oUsr2:Cell('BA1_NOMTIT'	):SetValue(cAlias->(BA1_NOMTIT)		)
	oUsr2:Cell('BA3_MATEMP'	):SetValue(cAlias->(BA3_MATEMP)		)
	oUsr2:Cell('BA3_AGMTFU'	):SetValue(cAlias->(MATR_FUNCIONAL)	)
	oUsr2:Cell('BI3_NREDUZ'	):SetValue(cAlias->(BI3_NREDUZ)		)
	oUsr2:Cell('BA1_ORIEND'	):SetValue(cAlias->(ORIEND)			)
		
	oUsr2:PrintLine()
	
	oUsr2:Finish()
	
	oUsr3:init()   
	               
	oUsr3:Cell('BA1_ENDERE'	):SetValue(cAlias->(BA1_ENDERE)  	)
	oUsr3:Cell('BA1_NR_END'	):SetValue(cAlias->(BA1_NR_END)		)
	oUsr3:Cell('BA1_COMEND'	):SetValue(cAlias->(BA1_COMEND)		)
	oUsr3:Cell('BA1_TELEFO'	):SetValue(cAlias->(BA1_TELEFO)		)
	oUsr3:Cell('BA1_YCEL'	):SetValue(cAlias->(BA1_YCEL)		)
	oUsr3:Cell('A1_END'		):SetValue(cAlias->(A1_END)			)

	oUsr3:PrintLine()
	
	oUsr3:Finish() 
	
	oUsr4:init()   

	oUsr4:Cell('BQC_NUMCON'	):SetValue(cAlias->(BQC_NUMCON)  	)
	oUsr4:Cell('BQC_VERCON'	):SetValue(cAlias->(BQC_VERCON)		)
	oUsr4:Cell('BQC_SUBCON'	):SetValue(cAlias->(BQC_SUBCON)		)
	oUsr4:Cell('BQC_VERSUB'	):SetValue(cAlias->(BQC_VERSUB)		)
	oUsr4:Cell('BQC_DESCRI'	):SetValue(cAlias->(BQC_DESCRI)		)
	
	oUsr4:PrintLine()
	
	oUsr4:Finish()
	
	oReport:PrintText(Replicate('-',300),,,CLR_BLACK,,,.T.)  
	
	cAlias->(dbSkip())

EndDo        

cAlias->(dbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                                                                          
cQuery += "SELECT BA1_CODINT||'.'||BA1_CODEMP||'.'||BA1_MATRIC||'.'||BA1_TIPREG||'-'||BA1_DIGITO MATRIC,BA1_NOMUSR,BA1_CPFUSR,BA1_DATNAS," 		+ CRLF
cQuery += "BA1_MAE,BA1_CPFPRE,BA1_NOMPRE,BA1_DATINC,BA1_DATCAR CARENCIA,BA1_YDTLIM,BA1_NOMTIT,BA1_ENDERE,BA1_NR_END,BA1_COMEND,BA1_TELEFO," 	+ CRLF
cQuery += "BA1_YCEL,A1_END,BA3_MATEMP,BA3_AGMTFU MATR_FUNCIONAL,BA1_ESTCIV,BA1.R_E_C_N_O_ RECBA1,BA1_TIPUSU,BA1_GRAUPA,BI3_NREDUZ,BQC_DESCRI,"	+ CRLF
cQuery += "BQC_NUMCON,BQC_VERCON,BQC_SUBCON,BQC_VERSUB,DECODE(BA1_ORIEND,'1','TITULAR','2','CLIENTE','3','SUBCONTRATO','4','VIDA','-') ORIEND"	+ CRLF
cQuery += "FROM " + RetSqlName('BTS') + " BTS" 																									+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '" 																	+ CRLF
cQuery += " 	AND BA1_FILIAL = '" + xFilial('BA1') + "'" 																						+ CRLF
cQuery += " 	AND BA1_MATVID = BTS_MATVID" 																									+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3.D_E_L_E_T_ = ' '" 																	+ CRLF
cQuery += " 	AND BA3_FILIAL = '" + xFilial('BA3') + "'" 																						+ CRLF
cQuery += " 	AND BA3_MOTBLO = ' '" 																											+ CRLF
cQuery += " 	AND BA1_CODINT = BA3_CODINT" 																									+ CRLF
cQuery += " 	AND BA1_CODEMP = BA3_CODEMP" 																									+ CRLF
cQuery += " 	AND BA1_MATRIC = BA3_MATRIC" 																									+ CRLF
cQuery += "INNER JOIN " + RetSqlName('SA1') + " SA1 ON SA1.D_E_L_E_T_ = ' '" 																	+ CRLF
cQuery += " 	AND A1_FILIAL = '" + xFilial('SA1') +"'" 																						+ CRLF
cQuery += " 	AND A1_COD = BA3_CODCLI" 																										+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BI3') + " BI3 ON BI3.D_E_L_E_T_ = ' '" 																	+ CRLF 
cQuery += "  AND BI3_FILIAL = '" + xFilial('BI3') + "'" 																						+ CRLF 
cQuery += "  AND BI3_CODINT = BA1_CODINT" 																										+ CRLF
cQuery += "  AND BI3_CODIGO = BA1_CODPLA" 																										+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BQC') + " BQC ON BQC.D_E_L_E_T_ = ' '" 																	+ CRLF 
cQuery += "  AND BQC_NUMCON = BA3_CONEMP" 																										+ CRLF
cQuery += "  AND BQC_VERCON = BA3_VERCON" 																										+ CRLF
cQuery += "  AND BQC_SUBCON = BA3_SUBCON" 																										+ CRLF
cQuery += "  AND BQC_VERSUB = BA3_VERSUB" 																										+ CRLF
cQuery += "  AND BQC_CODINT = BA1_CODINT" 																										+ CRLF
cQuery += "  AND BQC_CODEMP = BA1_CODEMP" 																										+ CRLF
cQuery += "WHERE BTS.D_E_L_E_T_ = ' '" 																											+ CRLF
cQuery += "  	AND BA1_CODINT = '" + mv_par01 + "'" 																							+ CRLF
cQuery += "  	AND BA1_CODEMP BETWEEN '" + mv_par02 + "' AND '" + mv_par03 + "'" 																+ CRLF
cQuery += "  	AND BA3_DATCON BETWEEN '" + DtoS(mv_par04) + "' AND '" + DtoS(mv_par05) + "'" 													+ CRLF
cQuery += "  	AND BA1_DATINC BETWEEN '" + DtoS(mv_par06) + "' AND '" + DtoS(mv_par07) + "'" 													+ CRLF
cQuery += "  	AND BTS_FILIAL = '" + xFilial('BTS') + "'" 																						+ CRLF

If !empty(mv_par08)
 
	cQuery += "		AND BA3_USUOPE IN " + FormatIn(allTrim(mv_par08),';') + CRLF                                                                                                       
	
EndIf                            

cQuery += "ORDER BY BI3_NREDUZ,MATRIC" 	+ CRLF

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
aAdd(aHelp, "Informe a operadora")         
PutSX1(cPerg , "01" , "Operadora" 			,"","","mv_ch1","C",TamSX3('BA1_CODINT')[1]		,0,0,"G",""	,"","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o grupo empresa inicial")         
PutSX1(cPerg , "02" , "Grp/Emp de" 			,"","","mv_ch2","C",TamSx3('BA1_CODEMP')[1]		,0,0,"G",""	,"","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o grupo empresa final")         
PutSX1(cPerg , "03" , "Grp/Emp ate" 		,"","","mv_ch3","C",TamSx3('BA1_CODEMP')[1]			,0,0,"G",""	,"","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de digitacao inicial")      
PutSX1(cPerg , "04" , "Dt digitacao de" 	,"","","mv_ch4","D",08								,0,0,"G",""	,"","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de digitacao final")      
PutSX1(cPerg , "05" , "Dt digitacao ate" 	,"","","mv_ch5","D",08								,0,0,"G",""	,"","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe data de inclusao inicial")      
PutSX1(cPerg , "06" , "Dt inclusao de" 		,"","","mv_ch6","D",08								,0,0,"G",""	,"","","","mv_par06","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe data de inclusao final")      
PutSX1(cPerg , "07" , "Dt inclusao de" 		,"","","mv_ch7","D",08								,0,0,"G",""	,"","","","mv_par07","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Consulta Especifica:                            ³
//³Chama a funcao u_RetLogin                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aHelp := {}
aAdd(aHelp, "Informe os usuarios.")
aAdd(aHelp, "Caso este parametro nao seja preenchido,")
aAdd(aHelp, "serao considerados todos os usuarios.")
PutSX1(cPerg , "08" , "Usuarios" 	 			,"","","mv_ch8","C",99	,0,0,"G",""	,"LOGIN"	,"","","mv_par08","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return

******************************************************************************************************************************


