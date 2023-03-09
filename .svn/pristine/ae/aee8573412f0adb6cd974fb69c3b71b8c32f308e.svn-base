#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR205  ºAutor  ³ Frederico O. C. Jr º Data ³  20/10/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório Reembolso				                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAPLS                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR205()

Local aArea         := GetArea()
Local oReport

Private cPerg       := "CABR205"

CriaSX1(cPerg)		// Cria grupo de perguntas

if !Pergunte(cPerg, .T.)
	return
endif

oReport := ReportH()
oReport:PrintDialog()

RestArea(aArea)

return


//**********************************************************//
//                  Geração do relatório                    //
//**********************************************************//
Static Function ReportH()

Local aAreaSM0      := SM0->(GetArea())
Local oSection
Local oReport
Local cTit          := "Relatório de Reembolso"

oReport := TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cTit)
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.T.)

Pergunte(oReport:uParam,.F.)

oSection := TRSection():New(oReport,"Relatório de Reembolso",)

	TRCell():New(oSection,"",,"Empresa"				, "", 010, .F., {|| (cAliasRee)->EMPRESA			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Protocolo"			, "", 008, .F., {|| (cAliasRee)->PROTOCOLO			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Matricula"			, "", 022, .F., {|| (cAliasRee)->MATRICULA			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Nome"				, "", 080, .F., {|| (cAliasRee)->BENEFICIARIO		}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Plano"				, "", 060, .F., {|| (cAliasRee)->PLANO				}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Cod. Cliente"		, "", 006, .F., {|| (cAliasRee)->COD_CLIENTE		}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Nome Cliente"		, "", 040, .F., {|| (cAliasRee)->CLIENTE			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"CNPJ/CPF"			, "", 020, .F., {|| (cAliasRee)->CPF_CNPJ			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Data Protoc."		, "", 010, .F., {|| (cAliasRee)->DAT_DIG			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Data Calculo"		, "", 010, .F., {|| (cAliasRee)->DAT_CALC			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Data Proced."		, "", 010, .F., {|| (cAliasRee)->DT_PROCED			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Prev. Pagto."		, "", 010, .F., {|| (cAliasRee)->DAT_PREV			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Valor Protoc"		, "", 015, .F., {|| (cAliasRee)->VLR_PROTOC			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Valor Pagto"			, "", 015, .F., {|| (cAliasRee)->VLR_PAGO			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Banco"				, "", 003, .F., {|| (cAliasRee)->BANCO				}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Agencia"				, "", 005, .F., {|| (cAliasRee)->AGENCIA			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Conta"				, "", 011, .F., {|| (cAliasRee)->CONTA				}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Dv Conta"			, "", 001, .F., {|| (cAliasRee)->DIGITO				}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Digitador"			, "", 030, .F., {|| (cAliasRee)->DIGITADOR			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Analista"			, "", 030, .F., {|| (cAliasRee)->ANALISTA			}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Porta Entrada"		, "", 070, .F., {|| (cAliasRee)->PORTA_ENTRADA		}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Canal"				, "", 070, .F., {|| (cAliasRee)->CANAL				}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Tipo Reemb."			, "", 015, .F., {|| (cAliasRee)->TIPO_REEMBOLSO		}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Titulo Financ."		, "", 020, .F., {|| (cAliasRee)->TITULO				}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Status"				, "", 010, .F., {|| (cAliasRee)->STATUS				}, "LEFT", .T., "LEFT" )
	TRCell():New(oSection,"",,"Situcao"				, "", 015, .F., {|| (cAliasRee)->SITUACAO			}, "LEFT", .T., "LEFT" )

RestArea( aAreaSM0 )

Return(oReport)


//**********************************************************//
//                   Query do relatório                     //
//**********************************************************//
Static Function ReportPrt(oReport)

Local oSection
Local cQuery		:= ""
Local cEmpresa		:= iif(cEmpAnt == '01', 'C', 'I')

Private cAliasRee	:= GetNextAlias()

oSection   := oReport:Section(1)

cQuery	:= " SELECT '" + iif(cEmpAnt == '01', 'CABERJ', 'INTEGRAL') + "'                                          AS EMPRESA,"
cQuery	+=			" FORMATA_MATRICULA_MS(ZZQ_CODBEN)                                                            AS MATRICULA,"
cQuery	+=			" TRIM(BA1_NOMUSR)                                                                            AS BENEFICIARIO,"
cQuery	+=			" RETORNA_DESC_PLANO_MS('" + cEmpresa + "', BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG)   AS PLANO,"
cQuery	+=			" A1_COD                                                                                      AS COD_CLIENTE,"
cQuery	+=			" TRIM(A1_NOME)                                                                               AS CLIENTE,"
cQuery	+=			" FORMATA_CPF_CNPJ(A1_CGC)                                                                    AS CPF_CNPJ,"
cQuery	+=			" ZZQ_SEQUEN                                                                                  AS PROTOCOLO,"
cQuery	+=			" TO_DATE(TRIM(ZZQ_DATDIG),'YYYYMMDD')                                                        AS DAT_DIG,"
cQuery	+=			" TO_DATE(TRIM(B44_DTDIGI),'YYYYMMDD')                                                        AS DAT_CALC,"
cQuery	+=			" TO_DATE(TRIM(ZZQ_DTEVEN),'YYYYMMDD')                                                        AS DT_PROCED,"
cQuery	+=			" TO_DATE(TRIM(CASE WHEN E2_VENCREA <> ' ' THEN E2_VENCREA"
cQuery	+=							  " WHEN B44_DATPAG <> ' ' THEN B44_DATPAG ELSE ZZQ_DATPRE END), 'YYYYMMDD')  AS DAT_PREV,"
cQuery	+=			" 'R$ ' || TO_CHAR(ZZQ_VLRTOT, 'FM999G999G999D90')                                            AS VLR_PROTOC,"
cQuery	+=			" CASE WHEN B44_VLRPAG > 0 THEN 'R$ ' || TO_CHAR(B44_VLRPAG, 'FM999G999G999D90') ELSE ' ' END AS VLR_PAGO,"
cQuery	+=			" ZZQ_XBANCO                                                                                  AS BANCO,"
cQuery	+=			" ZZQ_XAGENC                                                                                  AS AGENCIA,"
cQuery	+=			" TRIM(ZZQ_XCONTA)                                                                            AS CONTA,"
cQuery	+=			" ZZQ_XDGCON                                                                                  AS DIGITO,"
cQuery	+=			" B44_PREFIX||B44_NUM||B44_PARCEL||B44_TIPO                                                   AS TITULO,"
cQuery	+=			" TRIM(ZZQ_USRDIG)                                                                            AS DIGITADOR,"
cQuery	+=			" TRIM(B44_YUSSIS)                                                                            AS ANALISTA,"
cQuery	+=			" TRIM(PCA_DESCRI)                                                                            AS PORTA_ENTRADA,"
cQuery	+=			" TRIM(PCB_DESCRI)                                                                            AS CANAL,"
cQuery	+=			" CASE WHEN ZZQ_TPSOL = '1' THEN 'SOL. REEMBOLSO' ELSE 'SOL. ESPECIAL' END                    AS TIPO_REEMBOLSO,"
cQuery	+=			" DECODE(ZZQ_STATUS, '1','ATIVO', '2','CANCELADO', '3','VINCULADO')                           AS STATUS,"
cQuery	+=			" DECODE(B44_YSITUA,'1', 'AGUARD. APROV', '2','APROVADO', '3','NAO APROVADO')                 AS SITUACAO"
cQuery	+= " FROM " + RetSqlName("ZZQ") + " ZZQ"
cQuery	+=	 " INNER JOIN " + RetSqlName("BA1") + " BA1"
cQuery	+=	   " ON (    BA1_FILIAL = ZZQ_FILIAL"
cQuery	+=		   " AND BA1_CODINT = SUBSTR(ZZQ_CODBEN, 1,4)"
cQuery	+=		   " AND BA1_CODEMP = SUBSTR(ZZQ_CODBEN, 5,4)"
cQuery	+=		   " AND BA1_MATRIC = SUBSTR(ZZQ_CODBEN, 9,6)"
cQuery	+=		   " AND BA1_TIPREG = SUBSTR(ZZQ_CODBEN,15,2)"
cQuery	+=		   " AND BA1_DIGITO = SUBSTR(ZZQ_CODBEN,17,1))"
cQuery	+=	 " INNER JOIN " + RetSqlName("SA1") + " SA1"
cQuery	+=	   " ON (    A1_FILIAL = '" + xFilial("SA1") + "'"
cQuery	+=		   " AND A1_COD    = ZZQ_CODCLI"
cQuery	+=		   " AND A1_LOJA   = ZZQ_LOJCLI)"
cQuery	+=	 " LEFT JOIN " + RetSqlName("PCA") + " PCA"
cQuery	+=	   " ON (    PCA.D_E_L_E_T_ = ' '"
cQuery	+=		   " AND PCA_FILIAL = '" + xFilial("PCA") + "'"
cQuery	+=		   " AND PCA_COD    = ZZQ_XWEB)"
cQuery	+=	 " LEFT JOIN " + RetSqlName("PCB") + " PCB"
cQuery	+=	   " ON (    PCB.D_E_L_E_T_ = ' '"
cQuery	+=		   " AND PCB_FILIAL = '" + xFilial("PCB") + "'"
cQuery	+=		   " AND PCB_COD    = ZZQ_CANAL)"
cQuery	+=	 " LEFT JOIN " + RetSqlName("B44") + " B44"
cQuery	+=	   " ON (    B44.D_E_L_E_T_ = ' '"
cQuery	+=		   " AND B44_FILIAL = ZZQ_FILIAL"
cQuery	+=		   " AND B44_YCDPTC = ZZQ_SEQUEN)"
cQuery	+=	 " LEFT JOIN " + RetSqlName("SE1") + " SE1"
cQuery	+=	   " ON (    SE1.D_E_L_E_T_ = ' '"
cQuery	+=		   " AND E1_FILIAL  = '" + xFilial("SE1") + "'"
cQuery	+=		   " AND E1_PREFIXO = B44_PREFIX"
cQuery	+=		   " AND E1_NUM     = B44_NUM"
cQuery	+=		   " AND E1_PARCELA = B44_PARCEL"
cQuery	+=		   " AND E1_TIPO    = B44_TIPO)"
cQuery	+=	 " LEFT JOIN " + RetSqlName("SE2") + " SE2"
cQuery	+=	   " ON (    SE2.D_E_L_E_T_ = ' '"
cQuery	+=		   " AND E2_FILIAL  = '" + xFilial("SE2") + "'"
cQuery	+=		   " AND E2_TITORIG = B44_PREFIX||B44_NUM||B44_PARCEL||B44_TIPO"
cQuery	+=		   " AND E2_TITORIG <> ' ')"
cQuery	+= " WHERE ZZQ.D_E_L_E_T_ = ' ' AND SA1.D_E_L_E_T_ = ' '"
cQuery	+=	 " AND ZZQ_FILIAL = '" + xFilial("ZZQ") + "'"
cQuery	+=	 " AND NOT (ZZQ_TPSOL = '1' AND ZZQ_TIPPRO = '4')"					// N? LISTAR REEMBOLSO DE FUNERAL

if !empty(MV_PAR01)
	cQuery += " AND ZZQ_DATDIG >= '" + DtoS(MV_PAR01) + "'"
endif

if !empty(MV_PAR02)
	cQuery += " AND ZZQ_DATDIG <= '" + DtoS(MV_PAR02) + "'"
endif

if !empty(MV_PAR03)
	cQuery += " AND B44_DTDIGI >= '" + DtoS(MV_PAR03) + "'"
endif

if !empty(MV_PAR04)
	cQuery += " AND B44_DTDIGI <= '" + DtoS(MV_PAR04) + "'"
endif

if MV_PAR05 <> 4
	cQuery += " AND B44_YSITUA = '" + AllTrim(str(MV_PAR05)) + "'"
endif

if MV_PAR06 == 1
	cQuery += " AND ZZQ_STATUS = '3'"
elseif MV_PAR06 == 2
	cQuery += " AND ZZQ_STATUS = '2'"
endif

if MV_PAR07 == 1
	cQuery	+= " ORDER BY ZZQ_SEQUEN"
elseif MV_PAR07 == 2
	cQuery	+= " ORDER BY B44_DTDIGI"
elseif MV_PAR07 == 3
	cQuery	+= " ORDER BY CASE WHEN E2_VENCREA <> ' ' THEN E2_VENCREA WHEN B44_DATPAG <> ' ' THEN B44_DATPAG ELSE ZZQ_DATPRE END"
endif

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasRee,.T.,.T.)

dbSelectArea(cAliasRee)
(cAliasRee)->(dbgotop())

oReport:SetMeter((cAliasRee)->(LastRec()))

//Imprime os dados do relatorio
if (cAliasRee)->(EOF())
    MsgInfo("Nao foram encontrados dados!")
else

    oSection:Init()

    while !(cAliasRee)->(EOF())

        oReport:IncMeter()
        oSection:PrintLine()

        (cAliasRee)->(DbSkip())
    end

    oReport:FatLine()
    oReport:Section(1):Finish()

    (cAliasRee)->(DbCloseArea())

endif

return



//---------------------------------------------
// Rotina para Criar PERGUNTE 
//---------------------------------------------
Static Function CriaSX1(_cPerg)      
 
Local aHelpPor	:= {}

aHelpPor	:= {}
aAdd(aHelpPor,"Informe a data do protoloco do reembolso")
U_CABASX1(_cPerg,"01","Data Protoc. de: ?"	,"","","MV_CH1","D",08,0,0,"G","","","","","MV_PAR01",""				,"","","",""			,"","",""				,"","",""		,"","","","","",aHelpPor,{},{},"")
U_CABASX1(_cPerg,"02","Data Protoc. até: ?"	,"","","MV_CH2","D",08,0,0,"G","","","","","MV_PAR02",""				,"","","",""			,"","",""				,"","",""		,"","","","","",aHelpPor,{},{},"")

aHelpPor	:= {}
aAdd(aHelpPor,"Informe a data do calculo do reembolso")
U_CABASX1(_cPerg,"03","Data Calculo de: ?"	,"","","MV_CH3","D",08,0,0,"G","","","","","MV_PAR03",""				,"","","",""			,"","",""				,"","",""		,"","","","","",aHelpPor,{},{},"")
U_CABASX1(_cPerg,"04","Data Calculo até: ?"	,"","","MV_CH4","D",08,0,0,"G","","","","","MV_PAR04",""				,"","","",""			,"","",""				,"","",""		,"","","","","",aHelpPor,{},{},"")

aHelpPor	:= {}
aAdd(aHelpPor,"Informe a Situação")
U_CABASX1(_cPerg,"05","Situação: ?"			,"","","MV_CH5","N",01,0,0,"C","","","","","MV_PAR05","Aguard. Aprov."	,"","","","Aprovado"	,"","","Não Aprovado"	,"","","Todos"	,"","","","","",aHelpPor,{},{},"")

aHelpPor	:= {}
aAdd(aHelpPor,"Informe o Status")
U_CABASX1(_cPerg,"06","Status: ?"			,"","","MV_CH6","N",01,0,0,"C","","","","","MV_PAR06","Vinculados"		,"","","","Cancelados"	,"","","Ambos"			,"","",""		,"","","","","",aHelpPor,{},{},"")

aHelpPor	:= {}
aAdd(aHelpPor,"Ordenacao do relatorio")
U_CABASX1(_cPerg,"07","Ordem: ?"			,"","","MV_CH7","N",01,0,0,"C","","","","","MV_PAR07","Protocolo"		,"","","","Dt. Calculo"	,"","","Dt. Pagto"		,"","",""		,"","","","","",aHelpPor,{},{},"")

return
