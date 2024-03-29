#INCLUDE "rwmake.ch"
#INCLUDE "TopConn.ch"
#include "protheus.ch"

User Function CABR025()
Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

***************************************************************************************************************************************************

Static Function ReportDef()
Local oReport                                         
Local oSection
Local oBreak
Local cperg    	:= padr("CABR0259",10)
Local cAlias 	:=  "CABPA0"

Local cent 		:=CHR(13)+CHR(10)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿎riacao do componente de impressao                                      �
//�                                                                        �
//쿟Report():New                                                           �
//쿐xpC1 : Nome do relatorio                                               �
//쿐xpC2 : Titulo                                                          �
//쿐xpC3 : Pergunte                                                        �
//쿐xpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//쿐xpC5 : Descricao                                                       �
//�                                                                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
oReport := TReport():New("CABR024","Relat�rio de Posi豫o do RDA",cperg,{|oReport| ReportPrint(oReport,cAlias)},;
"Relat�rio de Posi豫o do RDA")

oReport:SetPortrait() 
oReport:SetTotalInLine(.F.)

ValidPerg(cperg)

Pergunte(oReport:uParam,.F.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿎riacao da secao utilizada pelo relatorio                               �
//�                                                                        �
//쿟RSection():New                                                         �
//쿐xpO1 : Objeto TReport que a secao pertence                             �
//쿐xpC2 : Descricao da se�ao                                              �
//쿐xpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   �
//�        sera considerada como principal para a se豫o.                   �
//쿐xpA4 : Array com as Ordens do relat�rio                                �
//쿐xpL5 : Carrega campos do SX3 como celulas                              �
//�        Default : False                                                 �
//쿐xpL6 : Carrega ordens do Sindex                                        �
//�        Default : False                                                 �
//�                                                                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿎riacao da celulas da secao do relatorio                                �
//�                                                                        �
//쿟RCell():New                                                            �
//쿐xpO1 : Objeto TSection que a secao pertence                            �
//쿐xpC2 : Nome da celula do relat�rio. O SX3 ser� consultado              �
//쿐xpC3 : Nome da tabela de referencia da celula                          �
//쿐xpC4 : Titulo da celula                                                �
//�        Default : X3Titulo()                                            �
//쿐xpC5 : Picture                                                         �
//�        Default : X3_PICTURE                                            �
//쿐xpC6 : Tamanho                                                         �
//�        Default : X3_TAMANHO                                            �
//쿐xpL7 : Informe se o tamanho esta em pixel                              �
//�        Default : False                                                 �
//쿐xpB8 : Bloco de c�digo para impressao.                                 �
//�        Default : ExpC2                                                 �
//�                                                                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Secao 1 - Cabecalho do Pedido                                          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

oReport:cFontBody := "Courier" 
oReport:nFontBody := 11

oSection1 := TRSection():New(oReport,"SPAs em aberto",{"PA0"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
                                                                                                                                             
TRCell():New(oSection1,"PA0_NUM"	,/*Tabela*/	,RetTitle( "PA0_NUM"	), PesqPict("PA0","PA0_NUM"		),TamSx3("PA0_NUM"   )[1]	,/*lPixel*/,{|| (cAlias)->PA0_NUM		})
TRCell():New(oSection1,"PA0_RDA"    ,/*Tabela*/	,RetTitle( "PA0_RDA"	), PesqPict("PA0","PA0_RDA"	    ),TamSx3("PA0_RDA"   )[1]	,/*lPixel*/,{|| (cAlias)->PA0_RDA	    })
TRCell():New(oSection1,"PA0_DTINC"  ,/*Tabela*/	,RetTitle( "PA0_DTINC"  ), PesqPict("PA0","PA0_DTINC"	),TamSx3("PA0_DTINC" )[1]   ,/*lPixel*/,{|| (cAlias)->PA0_DTINC	}) 
TRCell():New(oSection1,"PA0_STATUS" ,/*Tabela*/ ,"Status da Solicita豫o" , 							 ,20   						,/*lPixel*/,{|| (cAlias)->PA0_STATUS	}) 
TRCell():New(oSection1,"PA0_VLPROT"	,/*Tabela*/	,RetTitle( "PA0_VLPROT"	), PesqPict("PA0","PA0_VLPROT"	),TamSx3("PA0_VLPROT")[1]	,/*lPixel*/,{|| (cAlias)->PA0_VLPROT	})
TRCell():New(oSection1,"PA0_VALOR"	,/*Tabela*/	,RetTitle( "PA0_VALOR"	), PesqPict("PA0","PA0_VALOR"	),TamSx3("PA0_VALOR" )[1]	,/*lPixel*/,{|| (cAlias)->PA0_VALOR    })
TRCell():New(oSection1,"STATUSE2"	,/*Tabela*/	,"Posi豫o do Titulo", ,20,/*lPixel*/,{|| (cAlias)->STATUSE2    })

TRFunction():New(oSection1:Cell("PA0_VLPROT"),,"SUM",,,,, .f., .T. )	
TRFunction():New(oSection1:Cell("PA0_VALOR"),,"SUM",,,,, .f., .T. )	

Return oReport

***************************************************************************************************************************************************

Static Function ReportPrint(oReport,cAlias)

Local lFirst   := .T.
Local cPedAnt  :="   "
Local  cent :=CHR(13)+CHR(10)
Local  cOrder := ""
Local cTemp   := ""

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿟ransforma parametros Range em expressao SQL                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
MakeSqlExpr(oReport:uParam)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿑iltragem do relat�rio                                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//dbSelectArea("")		
//dbSetOrder(1)			

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿜uery do relat�rio da secao 1                                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cOrder  := "%BD7F.BD7_FASE%"

c_RDA 		:= MV_PAR01
                  
Do Case

	case MV_PAR04 == 1
		c_Status := " "
	case MV_PAR04 == 2
		c_Status := "A"
	case MV_PAR04 == 3
		c_Status := "C"
	case MV_PAR04 == 4
		c_Status := "R"
	case MV_PAR04 == 5
		c_Status := "A','C',' ','R"

EndCase
	

oReport:Section(1):BeginQuery()	
BeginSql Alias cAlias   
   
SELECT PA0_NUM, PA0_RDA, PA0_VALOR, PA0_VLPROT, PA0_DTINC, PA0_PAGSUG, E2_BAIXA,E2_NUMBOR,
Decode( E2_BAIXA, NULL, ' ', (case  
    WHEN E2_NUMBOR = ' '  AND e2_baixa = ' ' THEN 'Em Aberto'
    WHEN E2_NUMBOR <> ' ' AND e2_baixa = ' ' THEN 'Em Border�'
    WHEN e2_baixa <> ' ' THEN 'Compensado' END)
    )AS STATUSE2,
    (case  
    WHEN PA0_STATUS = ' '  THEN 'Aguardando Aprova豫o'
    WHEN PA0_STATUS = 'R'  THEN 'Reprovado pelo aprovador'
    WHEN PA0_STATUS = 'C'  THEN 'Cancelado'
    WHEN PA0_STATUS = 'A'  THEN 'Aprovada'
    END) AS PA0_STATUS

FROM %table:PA0% PA0 LEFT JOIN %table:SE2% SE2 ON
    E2_FILIAL = %xfilial:SE2%
	AND E2_PREFIXO = 'SPA'
	AND E2_TIPO = 'PA'
	AND E2_NUM = PA0_NUM
	AND E2_FORNECE = PA0_FORNEC 
    AND SE2.%notDel% 
WHERE
    PA0_FILIAL = ' ' 	
	AND PA0_RDA = %Exp:c_RDA%
	AND PA0.%notDel%    
	AND PA0_DTINC >= %Exp:MV_PAR02%
	AND PA0_DTINC <= %Exp:MV_PAR03%
	AND PA0_STATUS IN (%Exp:c_Status%)

EndSql

oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

While !oReport:Cancel() .And. !(cAlias)->(Eof())// .And. (cAlias)->_FILIAL = xFilial("")
			
	If oReport:Row() > 2500 .or. lfirst	
		oReport:EndPage(.T.)
		oReport:SkipLine(1)                                               
	
	EndIf
	lFirst := .F.    

    oReport:Section(1):Init()  
	oReport:Section(1):PrintLine() 
	// oReport:FatLine()   
	
	dbSelectArea(cAlias)
	dbSkip()
		
	If (cAlias)->(Eof())
		oReport:Section(1):Finish()
	EndIf
		
EndDo  

oReport:Section(1):SetPageBreak(.T.)

Return

***************************************************************************************************************************************************
                 
/*
*******************************************************************************
* Funcao    : ValidPerg   * Autor :                                           *
*******************************************************************************
* Descricao : Funcao auxiliar para verificacao das perguntas do relatorio.    *
*             Se as mesmas nao existirem, o sistema cria as perguntas.        *
*******************************************************************************
* Uso       : Programa principal                                              *
*******************************************************************************
*/

Static Function ValidPerg(cperg)  // Valida pergunta (SX1)

PutSx1( cperg ,"01","RDA                   ","","","mv_ch1","C",06,0,0,"G","                                     ","BAUPLS","S","","mv_par01","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( cperg ,"02","RDA                   ","","","mv_ch2","C",06,0,0,"G","                                     ","BAUPLS","S","","mv_par02","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( cperg ,"03","Inclus�o inicial:","","","mv_ch3","D",08,0,0,"G","NaoVazio()                           ","      ","S","","mv_par03","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( cperg ,"04","Inclus�o Final:","","","mv_ch4","D",08,0,0,"G","NaoVazio()                           ","      ","S","","mv_par04","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( cperg ,"05","Status:","","","mv_ch5","N",02,0,0,"C","","","S","","mv_par05","Aguardando Aprova豫o","","","","Aprovado","","","Cancelado","","","Reprovado","","","Ambos","","",{},{},{},"")


Return
