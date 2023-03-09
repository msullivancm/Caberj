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
oReport := TReport():New("CABR024","Relatório de Posição do RDA",cperg,{|oReport| ReportPrint(oReport,cAlias)},;
"Relatório de Posição do RDA")

oReport:SetPortrait() 
oReport:SetTotalInLine(.F.)

ValidPerg(cperg)

Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 1 - Cabecalho do Pedido                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:cFontBody := "Courier" 
oReport:nFontBody := 11

oSection1 := TRSection():New(oReport,"SPAs em aberto",{"PA0"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
                                                                                                                                             
TRCell():New(oSection1,"PA0_NUM"	,/*Tabela*/	,RetTitle( "PA0_NUM"	), PesqPict("PA0","PA0_NUM"		),TamSx3("PA0_NUM"   )[1]	,/*lPixel*/,{|| (cAlias)->PA0_NUM		})
TRCell():New(oSection1,"PA0_RDA"    ,/*Tabela*/	,RetTitle( "PA0_RDA"	), PesqPict("PA0","PA0_RDA"	    ),TamSx3("PA0_RDA"   )[1]	,/*lPixel*/,{|| (cAlias)->PA0_RDA	    })
TRCell():New(oSection1,"PA0_DTINC"  ,/*Tabela*/	,RetTitle( "PA0_DTINC"  ), PesqPict("PA0","PA0_DTINC"	),TamSx3("PA0_DTINC" )[1]   ,/*lPixel*/,{|| (cAlias)->PA0_DTINC	}) 
TRCell():New(oSection1,"PA0_STATUS" ,/*Tabela*/ ,"Status da Solicitação" , 							 ,20   						,/*lPixel*/,{|| (cAlias)->PA0_STATUS	}) 
TRCell():New(oSection1,"PA0_VLPROT"	,/*Tabela*/	,RetTitle( "PA0_VLPROT"	), PesqPict("PA0","PA0_VLPROT"	),TamSx3("PA0_VLPROT")[1]	,/*lPixel*/,{|| (cAlias)->PA0_VLPROT	})
TRCell():New(oSection1,"PA0_VALOR"	,/*Tabela*/	,RetTitle( "PA0_VALOR"	), PesqPict("PA0","PA0_VALOR"	),TamSx3("PA0_VALOR" )[1]	,/*lPixel*/,{|| (cAlias)->PA0_VALOR    })
TRCell():New(oSection1,"STATUSE2"	,/*Tabela*/	,"Posição do Titulo", ,20,/*lPixel*/,{|| (cAlias)->STATUSE2    })

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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//dbSelectArea("")		
//dbSetOrder(1)			

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
    WHEN E2_NUMBOR <> ' ' AND e2_baixa = ' ' THEN 'Em Borderô'
    WHEN e2_baixa <> ' ' THEN 'Compensado' END)
    )AS STATUSE2,
    (case  
    WHEN PA0_STATUS = ' '  THEN 'Aguardando Aprovação'
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
PutSx1( cperg ,"03","Inclusão inicial:","","","mv_ch3","D",08,0,0,"G","NaoVazio()                           ","      ","S","","mv_par03","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( cperg ,"04","Inclusão Final:","","","mv_ch4","D",08,0,0,"G","NaoVazio()                           ","      ","S","","mv_par04","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
PutSx1( cperg ,"05","Status:","","","mv_ch5","N",02,0,0,"C","","","S","","mv_par05","Aguardando Aprovação","","","","Aprovado","","","Cancelado","","","Reprovado","","","Ambos","","",{},{},{},"")


Return
