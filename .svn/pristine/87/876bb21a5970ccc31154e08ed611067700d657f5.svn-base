#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR212     ∫Autor  ≥Angelo Henrique   ∫ Data ≥  10/05/16   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥RelatÛrio de Protocolo de Atendimento                       ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ CABERJ                                                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

User Function CABR212()

	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	Private _cPerg	:= "CABR212"

	//Cria grupo de perguntas
	CABR212C(_cPerg)

	If Pergunte(_cPerg,.T.)

		//----------------------------------------------------
		//Validando se existe o Excel instalado na m·quina
		//para n„o dar erro e o usu·rio poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")

			oReport := CABR212A()
			oReport:PrintDialog()

		Else

			Processa({||CABR212E()},'Processando...')

		EndIf

	EndIf

	RestArea(_aArea)

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR212A  ∫Autor  ≥Angelo Henrique     ∫ Data ≥  17/08/15   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Rotina que ir· gerar as informaÁıes do relatÛrio            ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ CABERJ                                                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

Static Function CABR212A

	Local oReport		:= Nil
	Local oSection1 	:= Nil

	oReport := TReport():New("CABR212","PROTOCOLO DE ATENDIMENTO",_cPerg,{|oReport| CABR212B(oReport)},"PROTOCOLO DE ATENDIMENTO")

	oReport:SetLandScape()

	oReport:oPage:setPaperSize(12)

	//--------------------------------
	//Primeira linha do relatÛrio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"PA","ZX, ZY, BAU, BA1, BI3, PBL, PCF, PCB, PCD, PCA, PCG, PCB, PCD, SX5, BG9")

	TRCell():New(oSection1,"PROTOCOLO","ZX")
	oSection1:Cell("PROTOCOLO"):SetAutoSize(.F.)
	oSection1:Cell("PROTOCOLO"):SetSize(10)

	TRCell():New(oSection1,"NUMERO_SERVICO","ZY")
	oSection1:Cell("NUMERO_SERVICO"):SetAutoSize(.F.)
	oSection1:Cell("NUMERO_SERVICO"):SetSize(15) // ANDERSON RANGEL - MAR«O/2021 - ID 74286 e 74279 (MELHORIA)

	TRCell():New(oSection1,"DEMANDA","SX5")
	oSection1:Cell("DEMANDA"):SetAutoSize(.F.)
	oSection1:Cell("DEMANDA"):SetSize(15)

	TRCell():New(oSection1,"DATA_PROTOCOLO","ZX")
	oSection1:Cell("DATA_PROTOCOLO"):SetAutoSize(.F.)
	oSection1:Cell("DATA_PROTOCOLO"):SetSize(10)

	TRCell():New(oSection1,"HORA_PROTOCOLO","ZX")
	oSection1:Cell("HORA_PROTOCOLO"):SetAutoSize(.F.)
	oSection1:Cell("HORA_PROTOCOLO"):SetSize(10)

	TRCell():New(oSection1,"DATA_ENCERRAMENTO","ZX")
	oSection1:Cell("DATA_ENCERRAMENTO"):SetAutoSize(.F.)
	oSection1:Cell("DATA_ENCERRAMENTO"):SetSize(10)

	TRCell():New(oSection1,"DATA_SERVICO","ZY")
	oSection1:Cell("DATA_SERVICO"):SetAutoSize(.F.)
	oSection1:Cell("DATA_SERVICO"):SetSize(10)

	TRCell():New(oSection1,"HORA_SERVICO","ZY")
	oSection1:Cell("HORA_SERVICO"):SetAutoSize(.F.)
	oSection1:Cell("HORA_SERVICO"):SetSize(10)

	TRCell():New(oSection1,"CART_BEM_CUIDADA","ZX")
	oSection1:Cell("CART_BEM_CUIDADA"):SetAutoSize(.F.)
	oSection1:Cell("CART_BEM_CUIDADA"):SetSize(05)

// -[ chamado 87962 - gus - ini ]--------------------------------------------------------
	TRCell():New( oSection1 , "MITIGACAO_RISCO" , "ZX" )
	oSection1:Cell( "MITIGACAO_RISCO" ):SetAutoSize(.F.)
	oSection1:Cell( "MITIGACAO_RISCO" ):SetSize(05)
// -[ chamado 87962 - gus - fim ]--------------------------------------------------------
// -[ chamado 88753 - gus - ini ]--------------------------------------------------------
    TRCell():New( oSection1 , "MIT_DATA" , "ZX" )
    oSection1:Cell( "MIT_DATA" ):SetAutoSize(.F.)
    oSection1:Cell( "MIT_DATA" ):SetSize(10)
// -----------
    TRCell():New( oSection1 , "MIT_HORA" , "ZX" )
    oSection1:Cell( "MIT_HORA" ):SetAutoSize(.F.)
    oSection1:Cell( "MIT_HORA" ):SetSize(05)
// -----------
    TRCell():New( oSection1 , "MIT_USER" , "ZX" )
    oSection1:Cell( "MIT_USER" ):SetAutoSize(.F.)
    oSection1:Cell( "MIT_USER" ):SetSize(06)
// -----------
    TRCell():New( oSection1 , "MIT_NOME" , "ZX" )
    oSection1:Cell( "MIT_NOME" ):SetAutoSize(.F.)
    oSection1:Cell( "MIT_NOME" ):SetSize(30)
// -[ chamado 88753 - gus - fim ]--------------------------------------------------------

// -[ chamado 88956 - gus - ini ]--------------------------------------------------------
	TRCell():New( oSection1 , "NAO_EMAIL_CEL" , "ZX" )
	oSection1:Cell( "NAO_EMAIL_CEL" ):SetAutoSize(.F.)
	oSection1:Cell( "NAO_EMAIL_CEL" ):SetSize(05)
// -----------
    TRCell():New( oSection1 , "EMACEL_DATA" , "ZX" )
    oSection1:Cell( "EMACEL_DATA" ):SetAutoSize(.F.)
    oSection1:Cell( "EMACEL_DATA" ):SetSize(10)
// -----------
    TRCell():New( oSection1 , "EMACEL_HORA" , "ZX" )
    oSection1:Cell( "EMACEL_HORA" ):SetAutoSize(.F.)
    oSection1:Cell( "EMACEL_HORA" ):SetSize(05)
// -[ chamado 88956 - gus - fim ]--------------------------------------------------------

	TRCell():New(oSection1,"MATRICULA","ZX")
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(10)

	TRCell():New(oSection1,"IDADE","BA1")
	oSection1:Cell("IDADE"):SetAutoSize(.F.)
	oSection1:Cell("IDADE"):SetSize(10)

	TRCell():New(oSection1,"COD_PLANO","BI3")
	oSection1:Cell("COD_PLANO"):SetAutoSize(.F.)
	oSection1:Cell("COD_PLANO"):SetSize(10)

	TRCell():New(oSection1,"PLANO_DESCR","BI3")
	oSection1:Cell("PLANO_DESCR"):SetAutoSize(.F.)
	oSection1:Cell("PLANO_DESCR"):SetSize(25)

	TRCell():New(oSection1,"NOME_USUARIO","SZX")
	oSection1:Cell("NOME_USUARIO"):SetAutoSize(.F.)
	oSection1:Cell("NOME_USUARIO"):SetSize(TAMSX3("ZX_NOMUSR")[1])

	TRCell():New(oSection1,"MUNICIPIO_USUARIO","BA1")
	oSection1:Cell("MUNICIPIO_USUARIO"):SetAutoSize(.F.)
	oSection1:Cell("MUNICIPIO_USUARIO"):SetSize(TAMSX3("BA1_MUNICI")[1])

	TRCell():New(oSection1,"ATENDIMENTO","ZX")
	oSection1:Cell("ATENDIMENTO"):SetAutoSize(.F.)
	oSection1:Cell("ATENDIMENTO"):SetSize(10)

	TRCell():New(oSection1,"SITUACAO","PCA")
	oSection1:Cell("SITUACAO"):SetAutoSize(.F.)
	oSection1:Cell("SITUACAO"):SetSize(20)

	TRCell():New(oSection1,"CONTATO","ZX")
	oSection1:Cell("CONTATO"):SetAutoSize(.F.)
	oSection1:Cell("CONTATO"):SetSize(10)

	TRCell():New(oSection1,"DIGITADOR","ZX")
	oSection1:Cell("DIGITADOR"):SetAutoSize(.F.)
	oSection1:Cell("DIGITADOR"):SetSize(10)

	TRCell():New(oSection1,"CODIGO_SERVICO","ZY")
	oSection1:Cell("CODIGO_SERVICO"):SetAutoSize(.F.)
	oSection1:Cell("CODIGO_SERVICO"):SetSize(15)

	TRCell():New(oSection1,"SERVICO","PBL")
	oSection1:Cell("SERVICO"):SetAutoSize(.F.)
	oSection1:Cell("SERVICO"):SetSize(10)

	TRCell():New(oSection1,"CODIGO_HISTPAD","PCD")
	oSection1:Cell("CODIGO_HISTPAD"):SetAutoSize(.F.)
	oSection1:Cell("CODIGO_HISTPAD"):SetSize(15)

	TRCell():New(oSection1,"HIST_PADRAO","PCD")
	oSection1:Cell("HIST_PADRAO"):SetAutoSize(.F.)
	oSection1:Cell("HIST_PADRAO"):SetSize(15)

	TRCell():New(oSection1,"OBSERVACAO","ZY")
	oSection1:Cell("OBSERVACAO"):SetAutoSize(.F.)
	oSection1:Cell("OBSERVACAO"):SetSize(25)

	TRCell():New(oSection1,"DATA_RESPOSTA","ZY")
	oSection1:Cell("DATA_RESPOSTA"):SetAutoSize(.F.)
	oSection1:Cell("DATA_RESPOSTA"):SetSize(20)

	TRCell():New(oSection1,"HORA_RESPOSTA","ZY")
	oSection1:Cell("HORA_RESPOSTA"):SetAutoSize(.F.)
	oSection1:Cell("HORA_RESPOSTA"):SetSize(10)

	TRCell():New(oSection1,"RESPOSTA","ZY")
	oSection1:Cell("RESPOSTA"):SetAutoSize(.F.)
	oSection1:Cell("RESPOSTA"):SetSize(10)

	TRCell():New(oSection1,"USU_RESP","ZY")
	oSection1:Cell("USU_RESP"):SetAutoSize(.F.)
	oSection1:Cell("USU_RESP"):SetSize(25)

	TRCell():New(oSection1,"COD_AREA","ZX")
	oSection1:Cell("COD_AREA"):SetAutoSize(.F.)
	oSection1:Cell("COD_AREA"):SetSize(15)

	TRCell():New(oSection1,"AREA_RESP","PCF")
	oSection1:Cell("AREA_RESP"):SetAutoSize(.F.)
	oSection1:Cell("AREA_RESP"):SetSize(15)

	TRCell():New(oSection1,"COD_CANAL","ZX")
	oSection1:Cell("COD_CANAL"):SetAutoSize(.F.)
	oSection1:Cell("COD_CANAL"):SetSize(15)

	TRCell():New(oSection1,"CANAL","PCB")
	oSection1:Cell("CANAL"):SetAutoSize(.F.)
	oSection1:Cell("CANAL"):SetSize(15)

	TRCell():New(oSection1,"META_SLA","PCG")
	oSection1:Cell("META_SLA"):SetAutoSize(.F.)
	oSection1:Cell("META_SLA"):SetSize(10)

	TRCell():New(oSection1,"DIAS_UTEIS","SZX")
	oSection1:Cell("DIAS_UTEIS"):SetAutoSize(.F.)
	oSection1:Cell("DIAS_UTEIS"):SetSize(20)

	TRCell():New(oSection1,"DURACAO","ZX")
	oSection1:Cell("DURACAO"):SetAutoSize(.F.)
	oSection1:Cell("DURACAO"):SetSize(15)

	TRCell():New(oSection1,"PORTA_ENTRADA","PCA")
	oSection1:Cell("PORTA_ENTRADA"):SetAutoSize(.F.)
	oSection1:Cell("PORTA_ENTRADA"):SetSize(15)

	TRCell():New(oSection1,"COD_RDA","BAU")
	oSection1:Cell("COD_RDA"):SetAutoSize(.F.)
	oSection1:Cell("COD_RDA"):SetSize(10)

	TRCell():New(oSection1,"RDA","BAU")
	oSection1:Cell("RDA"):SetAutoSize(.F.)
	oSection1:Cell("RDA"):SetSize(20)

	TRCell():New(oSection1,"DIAS_EX","SZX")
	oSection1:Cell("DIAS_EX"):SetAutoSize(.F.)
	oSection1:Cell("DIAS_EX"):SetSize(10)

	TRCell():New(oSection1,"S_N_EXP","SZX")
	oSection1:Cell("S_N_EXP"):SetAutoSize(.F.)
	oSection1:Cell("S_N_EXP"):SetSize(10)

	TRCell():New(oSection1,"GRUPO_EMPRESA","BG9")
	oSection1:Cell("GRUPO_EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("GRUPO_EMPRESA"):SetSize(25)

	TRCell():New(oSection1,"EMAIL","BA1")
	oSection1:Cell("EMAIL"):SetAutoSize(.F.)
	oSection1:Cell("EMAIL"):SetSize(20)

	TRCell():New(oSection1,"USU_VIP","BA1")
	oSection1:Cell("USU_VIP"):SetAutoSize(.F.)
	oSection1:Cell("USU_VIP"):SetSize(20)

	TRCell():New(oSection1,"ANEXO","SZX")
	oSection1:Cell("ANEXO"):SetAutoSize(.F.)
	oSection1:Cell("ANEXO"):SetSize(10)

	TRCell():New(oSection1,"PESQUISA","SZX")
	oSection1:Cell("PESQUISA"):SetAutoSize(.F.)
	oSection1:Cell("PESQUISA"):SetSize(50)

Return oReport

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR212B  ∫Autor  ≥Angelo Henrique     ∫ Data ≥  17/08/15   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Rotina para montar a query e trazer as informaÁıes no       ∫±±
±±∫          ≥relatÛrio.                                                  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ CABERJ                                                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

Static Function CABR212B(oReport)

	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	Local _aAreAC9 		:= AC9->(GetArea())
	Local _cChavAC9		:= ""
	Local _cUsuResp		:= ""

	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	Private _cEmpAnt	:= cEmpAnt

	//---------------------------------------------
	//CABR212D Realiza toda a montagem da query
	//facilitando a manutenÁ„o do fonte
	//---------------------------------------------
	_cQuery := CABR212D()

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias1,.T.,.T.)

	oSection1:Init()
	oSection1:SetHeaderSection(.T.)

	While !(_cAlias1)->(EOF())

		oReport:IncMeter()

		If oReport:Cancel()
			Exit
		EndIf

		If !Empty((_cAlias1)->USDIGITSV)

			_cUsuResp := (_cAlias1)->USDIGITSV

		Else

			_cUsuResp := (_cAlias1)->USDIGRESP

		EndIf

		oSection1:Cell("PROTOCOLO"			):SetValue( (_cAlias1)->PROTOCOLO			)
		oSection1:Cell("NUMERO_SERVICO"		):SetValue( (_cAlias1)->SEQUEN				)
		oSection1:Cell("DEMANDA" 			):SetValue( (_cAlias1)->DEMANDA				)
		oSection1:Cell("DATA_PROTOCOLO"		):SetValue( (_cAlias1)->DATADE				)
		oSection1:Cell("HORA_PROTOCOLO"		):SetValue( (_cAlias1)->HORADE				)
		oSection1:Cell("DATA_ENCERRAMENTO"	):SetValue( (_cAlias1)->DATAATE				)
		oSection1:Cell("DATA_SERVICO" 		):SetValue( (_cAlias1)->DATASERV			)
		oSection1:Cell("HORA_SERVICO" 		):SetValue( (_cAlias1)->HORASERV			)
		oSection1:Cell("MATRICULA"			):SetValue( (_cAlias1)->MATRIC				)
		oSection1:Cell("CART_BEM_CUIDADA"	):SetValue( (_cAlias1)->CART_BEM_CUIDADA	)

// -----[ chamado 87962 - gus - ini ]----------------------------------------------------
		oSection1:Cell( "MITIGACAO_RISCO" ):SetValue( (_cAlias1)->MITIGACAO_RISCO )
// -----[ chamado 87962 - gus - fim ]----------------------------------------------------

// -----[ chamado 88753 - gus - ini ]----------------------------------------------------
        oSection1:Cell( "MIT_DATA" ):SetValue(        stod( (_cAlias1)->MIT_DATA         ) )
        oSection1:Cell( "MIT_HORA" ):SetValue(      substr( (_cAlias1)->MIT_HORA , 1 , 2 ) + ':' + ;
		                                            substr( (_cAlias1)->MIT_HORA , 3 , 2 ) )
        oSection1:Cell( "MIT_USER" ):SetValue(              (_cAlias1)->MIT_USER           )
        oSection1:Cell( "MIT_NOME" ):SetValue( UsrFullName( (_cAlias1)->MIT_USER         ) )
// -----[ chamado 88753 - gus - fim ]----------------------------------------------------

// -----[ chamado 88956 - gus - ini ]----------------------------------------------------
		oSection1:Cell( "NAO_EMAIL_CEL" ):SetValue(         (_cAlias1)->NAO_EMAIL_CEL )
        oSection1:Cell( "EMACEL_DATA"   ):SetValue(   stod( (_cAlias1)->EMACEL_DATA ) )
        oSection1:Cell( "EMACEL_HORA"   ):SetValue( substr( (_cAlias1)->EMACEL_HORA , 1 , 2 ) + ':' + ;
		                                            substr( (_cAlias1)->EMACEL_HORA , 3 , 2 ) )
// -----[ chamado 88956 - gus - fim ]----------------------------------------------------

		oSection1:Cell("COD_PLANO"			):SetValue( (_cAlias1)->PLANO 				)
		oSection1:Cell("PLANO_DESCR"		):SetValue( (_cAlias1)->PLANODESC			)
		oSection1:Cell("NOME_USUARIO"		):SetValue( (_cAlias1)->NOMEUSR				)
		oSection1:Cell("IDADE"				):SetValue( cValToChar((_cAlias1)->IDADE)	)
		oSection1:Cell("MUNICIPIO_USUARIO"	):SetValue( (_cAlias1)->MUNICIPIO_USUARIO	)
		oSection1:Cell("ATENDIMENTO"		):SetValue( (_cAlias1)->ATENDIMENTO			)
		oSection1:Cell("SITUACAO"			):SetValue( (_cAlias1)->SITUACAO			)
		oSection1:Cell("CONTATO"			):SetValue( (_cAlias1)->CONTATO				)
		oSection1:Cell("DIGITADOR"			):SetValue( (_cAlias1)->USDIGIT				)
		oSection1:Cell("CODIGO_SERVICO"		):SetValue( (_cAlias1)->TIPOSV				)
		oSection1:Cell("SERVICO" 			):SetValue( (_cAlias1)->SERVICO				)
		oSection1:Cell("CODIGO_HISTPAD"		):SetValue( (_cAlias1)->COD_HIST			)
		oSection1:Cell("HIST_PADRAO" 		):SetValue( (_cAlias1)->HISTORICO_PADRAO	)
		oSection1:Cell("OBSERVACAO" 		):SetValue( (_cAlias1)->OBS					)
		oSection1:Cell("DATA_RESPOSTA" 		):SetValue( (_cAlias1)->DATA_RESPOSTA		)
		oSection1:Cell("HORA_RESPOSTA" 		):SetValue( (_cAlias1)->HORA_RESPOSTA		)
		oSection1:Cell("RESPOSTA" 			):SetValue( (_cAlias1)->RESPOSTA			)
		oSection1:Cell("USU_RESP" 			):SetValue( _cUsuResp						)
		oSection1:Cell("COD_AREA" 			):SetValue( (_cAlias1)->COD_AREA			)
		oSection1:Cell("AREA_RESP" 			):SetValue( (_cAlias1)->AREA_RES			)
		oSection1:Cell("COD_CANAL" 			):SetValue( (_cAlias1)->COD_CANAL			)
		oSection1:Cell("CANAL" 				):SetValue( (_cAlias1)->CANAL				)
		oSection1:Cell("META_SLA" 			):SetValue( (_cAlias1)->META_SLA			)
		oSection1:Cell("DIAS_UTEIS" 		):SetValue( (_cAlias1)->DIAS_UTEIS 			)
		oSection1:Cell("DURACAO" 			):SetValue( (_cAlias1)->DURACAO 			)
		oSection1:Cell("PORTA_ENTRADA" 		):SetValue( (_cAlias1)->TIPO_ENTRADA		)
		oSection1:Cell("COD_RDA"			):SetValue( (_cAlias1)->RDA					)
		oSection1:Cell("RDA"				):SetValue( (_cAlias1)->NOME				)

		If (_cAlias1)->TPINTEL == "1" //Em Aberto

			oSection1:Cell("DIAS_EX"	):SetValue( STRTRAN(cValToChar((_cAlias1)->DIAS_EX), "-","")	)
			oSection1:Cell("S_N_EXP"	):SetValue( (_cAlias1)->EXPIRA									)

		Else //Encerrada

			oSection1:Cell("DIAS_EX"	):SetValue( STRTRAN(cValToChar((_cAlias1)->DIAS_EX), "-","")	)

			If val((_cAlias1)->META_SLA) -(_cAlias1)->DIAS_UTEIS >= 0
				oSection1:Cell("S_N_EXP"	):SetValue( "SLA ATINGIDO"									)
			Else
				oSection1:Cell("S_N_EXP"	):SetValue( "FORA SLA"										)
			EndIf
		EndIf

		oSection1:Cell("GRUPO_EMPRESA"	):SetValue( (_cAlias1)->GRUPO_EMPRESA							)
		oSection1:Cell("EMAIL"			):SetValue( lower((_cAlias1)->EMAIL)							)
		oSection1:Cell("USU_VIP"		):SetValue( lower((_cAlias1)->VIP)								)

		//-------------------------------------------------
		//Pegando se o protocolo possui ou n„o anexo
		//-------------------------------------------------
		_cChavAC9 := xFilial("AC9") + "SZX" + xFilial("SZX")
		_cChavAC9 += xFilial("SZX") + (_cAlias1)->PROTOCOLO + (_cAlias1)->MATRIC
		_cChavAC9 += AllTrim((_cAlias1)->DATADE ) + AlLTrim(REPLACE(AllTrim((_cAlias1)->HORADE),":",""))
		_cChavAC9 += AllTrim((_cAlias1)->DATAATE) + AlLTrim(REPLACE(AllTrim((_cAlias1)->HORATE),":",""))

		DbSelectArea("AC9")
		DbSetOrder(2) //AC9_FILIAL+AC9_ENTIDA+AC9_FILENT+AC9_CODENT+AC9_CODOBJ
		If DbSeek(_cChavAC9)

			oSection1:Cell("ANEXO"	):SetValue( "SIM")

		Else

			oSection1:Cell("ANEXO"	):SetValue( "NAO")

		EndIf

		if (_cAlias1)->PESQUISA == '1'
			oSection1:Cell("PESQUISA"	):SetValue( 'N√O SE APLICA'	)
		elseif 	(_cAlias1)->PESQUISA == '2'
			oSection1:Cell("PESQUISA"	):SetValue( 'SATISFEITO'	)
		elseif 	(_cAlias1)->PESQUISA == '3'
			oSection1:Cell("PESQUISA"	):SetValue( "INSATISFEITO"	)
		elseif 	(_cAlias1)->PESQUISA == '4'
			oSection1:Cell("PESQUISA"	):SetValue( 'N√O AVALIADO'	)
		else
			oSection1:Cell("PESQUISA"	):SetValue( 'N√O AVALIADO'	)
		endif

		oSection1:PrintLine()

		(_cAlias1)->(DbSkip())

	EndDo

	oSection1:Finish()

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	RestArea(_aArea	 )
	RestArea(_aAreAC9)

Return(.T.)


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR212C  ∫Autor  ≥Angelo Henrique     ∫ Data ≥  17/08/15   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Rotina responsavel pela geraÁ„o das perguntas no relatÛrio  ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ CABERJ                                                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

Static Function CABR212C(cGrpPerg)

	Local aHelpPor := {} //help da pergunta

	aHelpPor := {}
	AADD(aHelpPor,"Informe o protocolo de 			")
	AADD(aHelpPor,"Atendimento 						")
	AADD(aHelpPor,"Branco para todos				")

	PutSx1(cGrpPerg,"01","Protocolo: ?"			,"a","a","MV_CH1"	,"C",TamSX3("ZX_SEQ")[1],0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe a Matricula do assistido	")
	AADD(aHelpPor,"Branco para todos	    	   	")

	PutSx1(cGrpPerg,"02","Matricula"			,"a","a","MV_CH2"	,"C",17	,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe o tipo de demanda    	")
	AADD(aHelpPor,"Branco para todos				")

	PutSx1(cGrpPerg,"03","Tipo demanda:"		,"a","a","MV_CH3"	,"C",TamSX3("ZX_TPDEM")[1]	,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")


	aHelpPor := {}
	AADD(aHelpPor,"Informe o perÌodo de abertura   ")
	AADD(aHelpPor,"do protocolo				   	   ")

	PutSx1(cGrpPerg,"04","Data de abertura de: ","a","a","MV_CH4"	,"D",TamSX3("ZX_DATDE")[1]	,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe o perÌodo de abertura   ")
	AADD(aHelpPor,"do protocolo				   	   ")

	PutSx1(cGrpPerg,"05","Data de abertura atÈ: ","a","a","MV_CH5"	,"D",TamSX3("ZX_DATDE")[1]	,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")


	aHelpPor := {}
	AADD(aHelpPor,"Informe a porta de entrada 		")
	AADD(aHelpPor,"Branco para todos		  		")

	PutSx1(cGrpPerg,"06","Porta de Entrada:"	,"a","a","MV_CH6"	,"C",TamSX3("ZX_PTENT")[1]	,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")


	aHelpPor := {}
	AADD(aHelpPor,"Informe o Canal			  		")
	AADD(aHelpPor,"Branco para todos		  		")

	PutSx1(cGrpPerg,"07","Canal:"		,"a","a","MV_CH7"	,"C",TamSX3("ZX_CANAL")[1]	,0,0,"G","","","","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe a area  					")
	AADD(aHelpPor,"Branco para todos		  		")

	PutSx1(cGrpPerg,"08","Area respons·vel:"	,"a","a","MV_CH8"	,"C",TamSX3("ZX_CODAREA")[1]	,0,0,"G","","","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Tipo de ServiÁo	 		  		")
	AADD(aHelpPor,"Branco para todos		  		")

	PutSx1(cGrpPerg,"09","Tipo de serviÁo:"	,"a","a","MV_CH09"	,"C",TamSX3("ZY_TIPOSV")[1]	,0,0,"G","","","","","MV_PAR09","Autorizado","","","","Pago","","","Ambos","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe o histÛrico padrao 	")
	AADD(aHelpPor,"Branco para todos         	")

	PutSx1(cGrpPerg,"10","HistÛrico padrao: "		,"a","a","MV_CH10"	,"C",TamSX3("ZY_HISTPAD")[1]		,0,0,"G","","","","","MV_PAR10","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe o Status			 		")
	AADD(aHelpPor,"Ambos para todos          	")

	PutSx1(cGrpPerg,"11","Status:"	,"a","a","MV_CH11"	,"C",1		,0,0,"C","","","","","MV_PAR11","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe o Grupo do Plano 		")
	AADD(aHelpPor,"Ambos para todos          	")

	PutSx1(cGrpPerg,"12","Grupo Plano:"	,"a","a","MV_CH12"	,"C",1		,0,0,"C","","","","","MV_PAR12","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Tipo de Atendimento 			")
	AADD(aHelpPor,"Ambos para todos          	")

	PutSx1(cGrpPerg,"13","Tipo Atendimento:"	,"a","a","MV_CH13"	,"C",1		,0,0,"C","","","","","MV_PAR13","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Grupo/Empresa 			")
	AADD(aHelpPor,"Branco para todos          	")

	PutSx1(cGrpPerg,"14","Grupo/Empresa:"	,"a","a","MV_CH14"	,"C",TamSX3("BG9_CODIGO")[1]		,0,0,"G","","","","","MV_PAR14","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	// INICIO - ANDERSON RANGEL - MAR«O/2021 - ID 74286 e 74279 (MELHORIA)
	aHelpPor := {}
	AADD(aHelpPor,"Informe o perÌodo de Data de Resposta ")
	AADD(aHelpPor,"do protocolo				   	   ")

	PutSx1(cGrpPerg,"15","Data de Resposta De: ","a","a","MV_CH15"	,"D",TamSX3("ZY_DTRESPO")[1]	,0,0,"G","","","","","MV_PAR15","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe o perÌodo de Data de Resposta ")
	AADD(aHelpPor,"do protocolo				   	   ")

	PutSx1(cGrpPerg,"16","Data de Resposta Ate: ","a","a","MV_CH16"	,"D",TamSX3("ZY_DTRESPO")[1]	,0,0,"G","","","","","MV_PAR16","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	// FIM

	// INICIO - ANDERSON RANGEL - MAR«O/2021 - ID 74009
	aHelpPor := {}
	AADD(aHelpPor,"Informe se o Benefici·rio 		")
	AADD(aHelpPor,"Possui inclus„o no 				")
	AADD(aHelpPor,"Carteira Bem Cuidada				")
	AADD(aHelpPor,"Ambos para todos          	")

	PutSx1(cGrpPerg,"17","Carteira Bem Cuidada: ?"	,"a","a","MV_CH17"	,"C",TamSX3("ZX_CBCD")[1],0,0,"G","","","","","MV_PAR017","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	//FIM

// -[ chamado 87962 - gus - ini ]--------------------------------------------------------
	aHelpPor := {}
	aadd( aHelpPor , 'Informe se o Benefici·rio 		' )
	aadd( aHelpPor , 'possui inclus„o no 				' )
	aadd( aHelpPor , 'MitigaÁ„o de Risco / GEATE        ' )
	aadd( aHelpPor , 'Ambos para todos          	    ' )
	putsx1( cGrpPerg, '18' 	, 'MitigaÁ„o de Risco / GEATE ?' , 'a'  , 'a'   , 'MV_CH18' , 'C' , tamsx3( 'ZX_MITRIS' )[1] , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR018' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , aHelpPor , {} , {} , '' )
// -[ chamado 87962 - gus - fim ]--------------------------------------------------------

// -[ chamado 88956 - gus - ini ]--------------------------------------------------------
	aHelpPor := {}
	aadd( aHelpPor , 'Informe se o Benefici·rio 		' )
	aadd( aHelpPor , 'n„o possui email + celular        ' )
	aadd( aHelpPor , '                                  ' )
	aadd( aHelpPor , 'Ambos para todos          	    ' )
	putsx1( cGrpPerg, '19' 	, 'N„o tem Email + Celular ?' , 'a'  , 'a'   , 'MV_CH19' , 'C' , tamsx3( 'ZX_EMACEL' )[1] , 0 , 0 , 'G' , '' , '' , '' , '' , 'MV_PAR019' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , '' , aHelpPor , {} , {} , '' )
// -[ chamado 88956 - gus - fim ]--------------------------------------------------------

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR212D  ∫Autor  ≥Angelo Henrique     ∫ Data ≥  24/10/16   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Rotina responsavel por tratar a query, facilitando assim    ∫±±
±±∫          ≥a manutenÁ„o do fonte.                                      ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ CABERJ                                                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

Static Function CABR212D()

	Local _cQuery 		:= ""
	Local c_CodUsr		:= RetCodUsr()
	Local xz 			:= 0

	Private __cEmpAnt	:= cEmpAnt

	_cQuery += " SELECT																													" 	+ CRLF
	_cQuery += " 	PROTOCOLO, 																											" 	+ CRLF
	_cQuery += " 	SEQUEN, 																											" 	+ CRLF
	_cQuery += " 	NVL(TO_CHAR(DATADE,'DD/MM/YY'),' ') DATADE,     																	" 	+ CRLF
	_cQuery += " 	NVL(TO_CHAR(DATAATE,'DD/MM/YY'),' ') DATAATE,   																	" 	+ CRLF
	_cQuery += " 	CART_BEM_CUIDADA,                               																	" 	+ CRLF
	_cQuery += " 	MATRIC,                                         																	" 	+ CRLF
	_cQuery += " 	PLANO,                                          																	" 	+ CRLF
	_cQuery += " 	PLANODESC,                                      																	" 	+ CRLF
	_cQuery += " 	NOMEUSR,                                        																	" 	+ CRLF
	_cQuery += " 	IDADE,                                          																	" 	+ CRLF
	_cQuery += " 	MUNICIPIO_USUARIO,                              																	" 	+ CRLF
	_cQuery += " 	RDA,                                            																	" 	+ CRLF
	_cQuery += " 	NOME,                                           																	" 	+ CRLF
	_cQuery += " 	ATENDIMENTO,                                    																	" 	+ CRLF

// -[ chamado 87962 - gus - ini ]--------------------------------------------------------
	_cQuery += " 	MITIGACAO_RISCO, 																									" 	+ CRLF
// -[ chamado 87962 - gus - fim ]--------------------------------------------------------
// -[ chamado 88753 - gus - ini ]--------------------------------------------------------
	_cQuery += "    MIT_DATA, "                                                                                                         + CRLF
	_cQuery += "    MIT_HORA, "                                                                                                         + CRLF
	_cQuery += "    MIT_USER, "                                                                                                         + CRLF
// -[ chamado 88753 - gus - fim ]--------------------------------------------------------

// -[ chamado 88956 - gus - ini ]--------------------------------------------------------
	_cQuery += " 	NAO_EMAIL_CEL, " + CRLF
	_cQuery += "    EMACEL_DATA,   " + CRLF
	_cQuery += "    EMACEL_HORA,   " + CRLF
// -[ chamado 88956 - gus - fim ]--------------------------------------------------------

	_cQuery += " 	SITUACAO,                                       																	" 	+ CRLF
	_cQuery += " 	CONTATO,                                        																	" 	+ CRLF
	_cQuery += " 	USDIGIT,	                                    																	" 	+ CRLF
	_cQuery += " 	NVL(TO_CHAR(DATASERV,'DD/MM/YY'),' ') DATASERV,																		" 	+ CRLF
	_cQuery += " 	HORASERV,                                       																	" 	+ CRLF
	_cQuery += " 	TIPOSV,                                         																	" 	+ CRLF
	_cQuery += " 	SERVICO,                                        																	" 	+ CRLF
	_cQuery += " 	META_SLA,                                       																	" 	+ CRLF
	_cQuery += " 	DIAS_UTEIS,                                     																	" 	+ CRLF
	_cQuery += " 	OBS,                                            																	" 	+ CRLF
	_cQuery += " 	COD_HIST,                                       																	" 	+ CRLF
	_cQuery += " 	HISTORICO_PADRAO,                               																	" 	+ CRLF
	_cQuery += " 	DATA_RESPOSTA,                                  																	" 	+ CRLF
	_cQuery += " 	HORA_RESPOSTA,                                  																	" 	+ CRLF
	_cQuery += " 	RESPOSTA,                                       																	" 	+ CRLF
	_cQuery += " 	USDIGRESP, 																											" 	+ CRLF
	_cQuery += " 	USDIGITSV,                                      																	" 	+ CRLF
	_cQuery += " 	DURACAO,                                        																	" 	+ CRLF
	_cQuery += " 	COD_AREA,                                       																	" 	+ CRLF
	_cQuery += " 	AREA_RES,                                       																	" 	+ CRLF
	_cQuery += " 	TIPO_ENTRADA,                                   																	" 	+ CRLF
	_cQuery += " 	DEMANDA,                                        																	" 	+ CRLF
	_cQuery += " 	COD_CANAL,                                      																	" 	+ CRLF
	_cQuery += " 	CANAL,                                          																	" 	+ CRLF
	_cQuery += " 	DIAS_EX,                                        																	" 	+ CRLF
	_cQuery += " 	EXPIRA,                                         																	" 	+ CRLF
	_cQuery += " 	TPINTEL,                                        																	" 	+ CRLF
	_cQuery += " 	GRUPO_EMPRESA,                                  																	" 	+ CRLF
	_cQuery += " 	HORADE,                                         																	" 	+ CRLF
	_cQuery += " 	HORATE,                                         																	" 	+ CRLF
	_cQuery += " 	PESQUISA,                                       																	" 	+ CRLF
	_cQuery += " 	EMAIL,                                           																	" 	+ CRLF
	_cQuery += " 	VIP                                           																		" 	+ CRLF
	_cQuery += " FROM (																													" 	+ CRLF
	_cQuery += " 	SELECT  																											" 	+ CRLF
	_cQuery += " 		ZX.ZX_PESQUIS PESQUISA,																							" 	+ CRLF // MATEUS MEDEIROS - 24/10/18
	_cQuery += " 		ZX.ZX_SEQ PROTOCOLO,																							" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_SEQSERV,' ') SEQUEN,																					" 	+ CRLF
	_cQuery += " 		TO_DATE(TRIM(ZX.ZX_DATDE||ZX.ZX_HORADE),'YYYYMMDDHH24MI') DATADE,												" 	+ CRLF
	_cQuery += " 		(CASE																											" 	+ CRLF
	_cQuery += " 		   WHEN (TRIM(ZX.ZX_DATATE) IS NULL OR TRIM(ZX.ZX_HORATE) IS NULL) THEN NULL									" 	+ CRLF
	_cQuery += " 		   ELSE TO_DATE(TRIM(ZX.ZX_DATATE||ZX.ZX_HORATE),'YYYYMMDDHH24MI')												" 	+ CRLF
	_cQuery += " 		END) DATAATE,																									" 	+ CRLF
	_cQuery += "		DECODE(ZX.ZX_CBCD,'1','SIM','N√O') CART_BEM_CUIDADA,															" 	+ CRLF //ANDERSON RANGEL - MAR«O/2021 - ID 74009 (INCLUS√O DO CAMPO "CART_BEM_CUIDADA")

// -[ chamado 87962 - gus - ini ]--------------------------------------------------------
	_cQuery += "		DECODE(ZX.ZX_MITRIS,'1','SIM','N√O') MITIGACAO_RISCO, "                                                             + CRLF
// -[ chamado 87962 - gus - fim ]--------------------------------------------------------
// -[ chamado 88753 - gus - ini ]--------------------------------------------------------
	_cQuery += "        ZX.ZX_MRDATA MIT_DATA, "                                                                                        + CRLF
	_cQuery += "        ZX.ZX_MRHORA MIT_HORA, "                                                                                        + CRLF
	_cQuery += "        ZX.ZX_MRUSER MIT_USER, "                                                                                        + CRLF
// -[ chamado 88753 - gus - fim ]--------------------------------------------------------

// -[ chamado 88956 - gus - ini ]--------------------------------------------------------
	_cQuery += "		DECODE(ZX.ZX_EMACEL,'1','SIM','N√O') NAO_EMAIL_CEL, " + CRLF
	_cQuery += "        ZX.ZX_ECDATA EMACEL_DATA, "                           + CRLF
	_cQuery += "        ZX.ZX_ECHORA EMACEL_HORA, "                           + CRLF
// -[ chamado 88956 - gus - fim ]--------------------------------------------------------

	_cQuery += " 		ZX.ZX_CODINT||ZX.ZX_CODEMP||ZX.ZX_MATRIC||ZX.ZX_TIPREG||ZX.ZX_DIGITO MATRIC,									" 	+ CRLF
	_cQuery += " 		BA1.BA1_CODPLA PLANO,																							" 	+ CRLF
	_cQuery += " 		BI3.BI3_DESCRI PLANODESC,																						"	+ CRLF
	_cQuery += "		BA1.BA1_MUNICI MUNICIPIO_USUARIO,																				"	+ CRLF
	_cQuery += " 		ZX.ZX_NOMUSR NOMEUSR,																							"	+ CRLF
	_cQuery += " 		IDADE(TO_DATE(BA1.BA1_DATNAS,'YYYYMMDD')) IDADE,																" 	+ CRLF // ANDERSON RANGEL - MAR«O/2021 - ID 74286 e 74279 (MELHORIA)
	_cQuery += " 		ZX.ZX_RDA RDA,																									" 	+ CRLF
	_cQuery += " 		NVL(																											" 	+ CRLF
	_cQuery += " 		(																												" 	+ CRLF
	_cQuery += " 			SELECT 																										" 	+ CRLF
	_cQuery += " 				BAU.BAU_NOME																							" 	+ CRLF
	_cQuery += " 			FROM 																										" 	+ CRLF
	_cQuery += " 				" + RETSQLNAME("BAU") + " BAU																			" 	+ CRLF
	_cQuery += " 			WHERE 																										" 	+ CRLF
	_cQuery += " 				BAU.D_E_L_E_T_ = ' '																					" 	+ CRLF
	_cQuery += " 				AND BAU.BAU_FILIAL = '" + xFilial("BAU") + "'															" 	+ CRLF
	_cQuery += " 				AND BAU.BAU_CODIGO = ZX.ZX_RDA																			" 	+ CRLF
	_cQuery += " 		) 																												" 	+ CRLF
	_cQuery += " 		,' ') NOME,																										" 	+ CRLF
	_cQuery += " 		ZX.ZX_TPATEND,DECODE(ZX.ZX_TPATEND,'1','At.Caberj',' ') ATENDIMENTO,											" 	+ CRLF
	_cQuery += " 		ZX.ZX_TPINTEL,DECODE(ZX.ZX_TPINTEL,'1','Pendente','2','Encerrado','3','Em Andamento','4','Encerrado em acompanhamento',' ') SITUACAO, " 	+ CRLF
	_cQuery += " 		ZX.ZX_CONTATO CONTATO,																							" 	+ CRLF
	_cQuery += " 		ZX.ZX_USDIGIT USDIGIT,																							" 	+ CRLF
	_cQuery += " 		(CASE																											" 	+ CRLF
	_cQuery += " 		   WHEN (TRIM(ZY.ZY_DTSERV) IS NULL OR TRIM(ZY.ZY_HORASV) IS NULL) THEN NULL									" 	+ CRLF
	_cQuery += " 		   ELSE TO_DATE(ZY.ZY_DTSERV||ZY.ZY_HORASV,'YYYYMMDDHH24MI')													" 	+ CRLF
	_cQuery += " 		END) DATASERV,																									" 	+ CRLF
	_cQuery += " 		NVL2(TRIM(ZY.ZY_HORASV),SUBSTR(ZY.ZY_HORASV,1,2)||':'||SUBSTR(ZY.ZY_HORASV,3,2),' ') HORASERV, 					" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_TIPOSV, ' ') TIPOSV,																					" 	+ CRLF
	_cQuery += " 		PBL.PBL_YDSSRV SERVICO,																							" 	+ CRLF
	_cQuery += " 		DECODE(TRIM(ZX.ZX_SLA),NULL,'X',ZX.ZX_SLA) META_SLA,															" 	+ CRLF
	_cQuery += " 		N_DIAS_UTEIS_PERIODO(TO_DATE(TRIM(ZX_DATDE ||ZX_HORADE),'YYYYMMDDHH24MI'), 							            " 	+ CRLF
	_cQuery += " 		                     NVL(TO_DATE(TRIM(ZX_DATATE||ZX_HORATE),'YYYYMMDDHH24MI'), SYSDATE)) DIAS_UTEIS,			" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_OBS,' ') OBS,																							" 	+ CRLF
	_cQuery += " 		CASE PBL.PBL_GERED 																								" 	+ CRLF
	_cQuery += " 		    WHEN '1' THEN NVL(BAQ.BAQ_CODESP,' ')   																	" 	+ CRLF
	_cQuery += " 		    ELSE NVL(PCD.PCD_COD,' ')               																	" 	+ CRLF
	_cQuery += " 		END COD_HIST,																									" 	+ CRLF
	_cQuery += " 		CASE PBL.PBL_GERED                          																	" 	+ CRLF
	_cQuery += " 		    WHEN '1' THEN NVL(BAQ.BAQ_DESCRI,' ')   																	" 	+ CRLF
	_cQuery += " 		    ELSE NVL(PCD.PCD_DESCRI,' ')            																	" 	+ CRLF
	_cQuery += " 		END HISTORICO_PADRAO,				        																	" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_DTRESPO,' ') DATA_RESPOSTA,																			" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_HRRESPO,' ') HORA_RESPOSTA,																			" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_RESPOST,' ') RESPOSTA,																				" 	+ CRLF
	_cQuery += " 		(																												" 	+ CRLF
	_cQuery += " 	    	SELECT                                                      												" 	+ CRLF
	_cQuery += " 	        	SZY_RESP.ZY_LOGRESP                                     												" 	+ CRLF
	_cQuery += " 	    	FROM                                                        												" 	+ CRLF
	_cQuery += " 	        	" + RETSQLNAME("SZY") + " SZY_RESP                                         								" 	+ CRLF
	_cQuery += " 	    	WHERE                                                       												" 	+ CRLF
	_cQuery += " 	        	SZY_RESP.ZY_FILIAL      = ZY.ZY_FILIAL                  												" 	+ CRLF
	_cQuery += " 	        	AND SZY_RESP.ZY_SEQBA   = ZY.ZY_SEQBA                   												" 	+ CRLF
	_cQuery += " 	        	AND SZY_RESP.ZY_LOGRESP <> ' '                          												" 	+ CRLF
	_cQuery += " 	        	AND SZY_RESP.D_E_L_E_T_ = ' '                           												" 	+ CRLF
	_cQuery += " 	        	AND SZY_RESP.R_E_C_N_O_ = (                             												" 	+ CRLF
	_cQuery += " 	            	SELECT                                              												" 	+ CRLF
	_cQuery += " 	                	MAX(SZY_INT.R_E_C_N_O_)                         												" 	+ CRLF
	_cQuery += " 	            	FROM                                                												" 	+ CRLF
	_cQuery += " 	                	" + RETSQLNAME("SZY") + " SZY_INT                                  								" 	+ CRLF
	_cQuery += " 	            	WHERE                                               												" 	+ CRLF
	_cQuery += " 	                	SZY_INT.ZY_FILIAL      = SZY_RESP.ZY_FILIAL     												" 	+ CRLF
	_cQuery += " 	                	AND SZY_INT.ZY_SEQBA   = SZY_RESP.ZY_SEQBA      												" 	+ CRLF
	_cQuery += " 	                	AND SZY_INT.ZY_LOGRESP <> ' '                   												" 	+ CRLF
	_cQuery += " 	                	AND SZY_INT.D_E_L_E_T_ = SZY_RESP.D_E_L_E_T_    												" 	+ CRLF
	_cQuery += " 	        )                                                       													" 	+ CRLF
	_cQuery += " 		)USDIGRESP,                                                     												" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_USDIGIT,' ') USDIGITSV,																				" 	+ CRLF
	_cQuery += " 		S_HORAS_UTEIS_PERIODO(TO_DATE(TRIM(ZX.ZX_DATDE||ZX.ZX_HORADE) ,'YYYYMMDDHH24MI'), 								" 	+ CRLF
	_cQuery += " 		NVL(TO_DATE(TRIM(ZX.ZX_DATATE||ZX.ZX_HORATE),'YYYYMMDDHH24MI'), SYSDATE)) DURACAO,								" 	+ CRLF
	_cQuery += " 		NVL(TRIM(ZX.ZX_CODAREA),' ') COD_AREA,																			" 	+ CRLF
	_cQuery += " 		NVL(TRIM(PCF.PCF_DESCRI),' ') AREA_RES,																			" 	+ CRLF
	_cQuery += " 		NVL(TRIM(PCA_DESCRI),' ') TIPO_ENTRADA,																			" 	+ CRLF
	_cQuery += " 		TRIM(SX5.X5_DESCRI) DEMANDA,																					"	+ CRLF
	_cQuery += " 		ZX.ZX_CANAL COD_CANAL,																							" 	+ CRLF
	_cQuery += " 		TRIM(PCB.PCB_DESCRI) CANAL,																						" 	+ CRLF
	_cQuery += "     	(																												" 	+ CRLF
	_cQuery += "     			DECODE(TRIM(ZX.ZX_SLA),NULL,'X',ZX.ZX_SLA) - 															" 	+ CRLF
	_cQuery += "     			(																										" 	+ CRLF
	_cQuery += " 					TRUNC(((N_HORAS_UTEIS_PERIODO(TO_DATE(TRIM(ZX_DATDE ||ZX_HORADE),'YYYYMMDDHH24MI'), 				" 	+ CRLF
	_cQuery += " 					NVL(TO_DATE(TRIM(ZX_DATATE||ZX_HORATE),'YYYYMMDDHH24MI'), SYSDATE)) /9)/60),0) 						" 	+ CRLF
	_cQuery += "     			) 																										" 	+ CRLF
	_cQuery += "     	) DIAS_EX,  																									" 	+ CRLF
	_cQuery += "     	DECODE 																											" 	+ CRLF
	_cQuery += "    		( 																											" 	+ CRLF
	_cQuery += "     			SUBSTR 																									" 	+ CRLF
	_cQuery += "     			( 																										" 	+ CRLF
	_cQuery += "     				(   																								" 	+ CRLF
	_cQuery += "     					DECODE(TRIM(ZX.ZX_SLA),NULL,'X',ZX.ZX_SLA) - 													" 	+ CRLF
	_cQuery += "     					(   																							" 	+ CRLF
	_cQuery += " 							TRUNC(((N_HORAS_UTEIS_PERIODO(TO_DATE(TRIM(ZX_DATDE ||ZX_HORADE),'YYYYMMDDHH24MI'), 		" 	+ CRLF
	_cQuery += " 							NVL(TO_DATE(TRIM(ZX_DATATE||ZX_HORATE),'YYYYMMDDHH24MI'), SYSDATE)) /9)/60),0) 				" 	+ CRLF
	_cQuery += "     					)   																							" 	+ CRLF
	_cQuery += "     				)   																								" 	+ CRLF
	_cQuery += "     			,1,1   																									" 	+ CRLF
	_cQuery += "     			)   																									" 	+ CRLF
	_cQuery += "     		,'-','EXPIRADO','0','EXPIRADO','A EXPIRAR'   																" 	+ CRLF
	_cQuery += "     		)EXPIRA,   																									" 	+ CRLF
	_cQuery += "     		ZX.ZX_TPINTEL TPINTEL, 																						" 	+ CRLF
	_cQuery += "     		NVL(BG9_DESCRI,' ') GRUPO_EMPRESA, 																			" 	+ CRLF  //sergio cunha 05/12/16
	_cQuery += "     		NVL2(TRIM(ZX.ZX_HORADE),SUBSTR(ZX.ZX_HORADE,1,2)||':'||SUBSTR(ZX.ZX_HORADE,3,2),' ') HORADE,  				" 	+ CRLF
	_cQuery += "     		NVL2(TRIM(ZX.ZX_HORATE),SUBSTR(ZX.ZX_HORATE,1,2)||':'||SUBSTR(ZX.ZX_HORATE,3,2),' ') HORATE,  				" 	+ CRLF
	_cQuery += "     		TRIM(BA1_EMAIL) EMAIL,  																					" 	+ CRLF
	_cQuery += "     		DECODE(BA1_USRVIP,'1','SIM','NAO') VIP  																	" 	+ CRLF	
	_cQuery += " 			FROM  																										" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("SZX") + " ZX, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("SZY") + " ZY, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("BA1") + " BA1, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("BI3") + " BI3, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PBL") + " PBL, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PCF") + " PCF, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PCB") + " PCB, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PCD") + " PCD, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PCA") + " PCA, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("BG9") + " BG9, 																			" 	+ CRLF
	_cQuery += "				SX5010 SX5,		  																						" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("BAQ") + " BAQ 																			" 	+ CRLF
	_cQuery += " 			WHERE 																										" 	+ CRLF
	_cQuery += " 				ZY.ZY_FILIAL  	= ZX.ZX_FILIAL																			" 	+ CRLF
	_cQuery += " 				AND ZY.ZY_SEQBA  	= ZX.ZX_SEQ																			" 	+ CRLF

	If !Empty(MV_PAR04) .And. !Empty(MV_PAR05)

		_cQuery += " 				AND TRIM(ZX.ZX_DATDE) BETWEEN '" + ALLTRIM(DTOS(Mv_Par04)) + "' AND '" + ALLTRIM(DTOS(Mv_Par05)) + "' 	" 	+ CRLF

	EndIf

	If !Empty(MV_PAR15) .And. !Empty(MV_PAR16)

		_cQuery += " 				AND TRIM(ZY.ZY_DTRESPO) BETWEEN '" + ALLTRIM(DTOS(Mv_Par15)) + "' AND '" + ALLTRIM(DTOS(Mv_Par16)) + "' 	" 	+ CRLF

	EndIf

	If MV_PAR17 == 1
		_cQuery += " 				AND ZX.ZX_CBCD = '1'													" 	+ CRLF
	Elseif MV_PAR17 == 0
		_cQuery += " 				AND ZX.ZX_CBCD IN ('0',' ')												" 	+ CRLF
	Elseif MV_PAR17 == 3
		_cQuery += " 				AND ZX.ZX_CBCD IN ('0','1',' ')											" 	+ CRLF
	EndIf

// -[ chamado 87962 - gus - ini ]--------------------------------------------------------
	if MV_PAR18 == 1
		_cQuery += " 				AND ZX.ZX_MITRIS = '1'    												"	+ CRLF
	elseif MV_PAR18 == 2
		_cQuery += " 				AND ZX.ZX_MITRIS IN ('0',' ') 											"   + CRLF
	elseif MV_PAR18 == 3
		_cQuery += " 				AND ZX.ZX_MITRIS IN ('0','1',' ') 										" 	+ CRLF
	endif
// -[ chamado 87962 - gus - fim ]--------------------------------------------------------

// -[ chamado 88956 - gus - ini ]--------------------------------------------------------
	    if MV_PAR19 == 1
		_cQuery += " 				AND ZX.ZX_EMACEL = '1'            " + CRLF
	elseif MV_PAR19 == 2
		_cQuery += " 				AND ZX.ZX_EMACEL IN ('0',' ')     " + CRLF
	elseif MV_PAR19 == 3
		_cQuery += " 				AND ZX.ZX_EMACEL IN ('0','1',' ') " + CRLF
	endif
// -[ chamado 88956 - gus - fim ]--------------------------------------------------------

	//------------------------------------------------------------------
	// Angelo Henrique - Data: 23/01/2018
	//------------------------------------------------------------------
	// ValidaÁ„o criada para n„o exibir os protocolos que s„o criados
	// na DIRETORIA
	//------------------------------------------------------------------
	If !(Upper(AllTrim(c_CodUsr)) $ Upper(AllTrim(GetNewPar("MV_XUSUDIR",""))))

		_cQuery += " 				AND ZX.ZX_CANAL <> '000014' 																		" 	+ CRLF

	EndIf

	_cQuery += " 				AND BA1.BA1_CODINT = ZX.ZX_CODINT																		" 	+ CRLF
	_cQuery += " 				AND BA1.BA1_CODEMP = ZX.ZX_CODEMP																		" 	+ CRLF
	_cQuery += " 				AND BA1.BA1_MATRIC = ZX.ZX_MATRIC																		" 	+ CRLF
	_cQuery += " 				AND BA1.BA1_TIPREG = ZX.ZX_TIPREG																		" 	+ CRLF
	_cQuery += " 				AND BG9_FILIAL = BA1_FILIAL																				" 	+ CRLF
	_cQuery += " 				AND BG9_CODINT = BA1_CODINT																				" 	+ CRLF
	_cQuery += " 				AND BG9_CODIGO = BA1_CODEMP																				" 	+ CRLF
	_cQuery += " 				AND BI3.BI3_CODIGO = BA1.BA1_CODPLA 																	" 	+ CRLF
	_cQuery += " 				AND PBL.PBL_YCDSRV = ZY.ZY_TIPOSV																		" 	+ CRLF
	_cQuery += " 				AND BA1.BA1_CODINT = ZX.ZX_CODINT																		" 	+ CRLF
	_cQuery += " 				AND BA1.BA1_CODEMP = ZX.ZX_CODEMP																		" 	+ CRLF
	_cQuery += " 				AND BA1.BA1_MATRIC = ZX.ZX_MATRIC																		" 	+ CRLF
	_cQuery += " 				AND BA1.BA1_TIPREG = ZX.ZX_TIPREG																		" 	+ CRLF
	_cQuery += " 				AND BA1.BA1_DIGITO = ZX.ZX_DIGITO																		" 	+ CRLF
	_cQuery += " 				AND ZX.ZX_CODAREA = PCF.PCF_COD																			" 	+ CRLF
	_cQuery += " 				AND ZX.ZX_CANAL   = PCB.PCB_COD																			" 	+ CRLF
	_cQuery += " 				AND ZX.ZX_PTENT   = PCA.PCA_COD																			" 	+ CRLF

	If !Empty(MV_PAR01)
		_cQuery += " 				AND TRIM(ZX.ZX_SEQ)= '" + ALLTRIM(MV_PAR01) + "'													" 	+ CRLF
	EndIf

	If !Empty(MV_PAR14)
		_cQuery += " 				AND TRIM(ZX.ZX_CODEMP)   = '"+ALLTRIM(MV_PAR14)+"'													" 	+ CRLF
	EndIf

	If !Empty(MV_PAR02)
		_cQuery += " 				AND ZX.ZX_CODINT||ZX.ZX_CODEMP||ZX.ZX_MATRIC||ZX.ZX_TIPREG||ZX.ZX_DIGITO  = '"+ALLTRIM(MV_PAR02)+"'	" 	+ CRLF
	EndIf

	cTpIntel :=  ""

	aTpIntel := StrTokArr( MV_PAR11, ";" )
	For xz := 1 To Len(aTpIntel)
		cTpIntel += IIF(xz == Len(aTpIntel), "'"+aTpIntel[xz]+"'" , "'"+aTpIntel[xz]+"',")
	Next

	_cQuery += " 				AND ZX.ZX_TPINTEL      IN (  "+ cTpIntel +"   )	" 	+ CRLF

	If !Empty(MV_PAR08)
		_cQuery += " 				AND TRIM(ZX.ZX_CODAREA) = '"+ALLTRIM(MV_PAR08)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(ZX.ZX_CODAREA) <> ' '																		"	+ CRLF
	EndIf

	If !Empty(MV_PAR09)
		_cQuery += " 				AND TRIM(PBL.PBL_YCDSRV) = '"+ALLTRIM(MV_PAR09)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(PBL.PBL_YCDSRV) <> ' '																		" 	+ CRLF
	EndIf

	If !Empty(MV_PAR10)
		_cQuery += " 				AND PCD.PCD_COD (+)= '"+ALLTRIM(MV_PAR10)+"'													" 	+ CRLF
	EndIf

	_cQuery += " 				AND PCD.PCD_COD (+)= ZY.ZY_HISTPAD  																	" 	+ CRLF

	If !Empty(MV_PAR03)
		_cQuery += " 				AND TRIM(ZX.ZX_TPDEM)   = '"+ALLTRIM(MV_PAR03)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(ZX.ZX_TPDEM)   <> ' ' 																		" 	+ CRLF
	EndIf

	If !Empty(MV_PAR06)
		_cQuery += " 				AND TRIM(ZX.ZX_PTENT)   = '"+ALLTRIM(MV_PAR06)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(ZX.ZX_PTENT)   <> ' '																		" 	+ CRLF
	EndIf

	If !Empty(MV_PAR07)
		_cQuery += " 				AND TRIM(ZX.ZX_CANAL)   = '"+ALLTRIM(MV_PAR07)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(ZX.ZX_CANAL)   <> ' '																		" 	+ CRLF
	EndIf

	_cQuery += " 				AND SX5.X5_TABELA   = 'ZT'																				" 	+ CRLF
	_cQuery += " 				AND SX5.X5_CHAVE    = ZX.ZX_TPDEM 																		" 	+ CRLF
	_cQuery += " 				AND BAQ_CODINT      (+)= '0001'																			" 	+ CRLF
	_cQuery += " 				AND BAQ.BAQ_CODESP  (+)= ZY.ZY_HISTPAD																	" 	+ CRLF
	_cQuery += " 				AND ZX.ZX_FILIAL 	= '" 	+ xFilial("SZX") + "'														" 	+ CRLF
	_cQuery += " 				AND ZY.ZY_FILIAL 	= '" 	+ xFilial("SZY") + "'														" 	+ CRLF
	_cQuery += " 				AND BA1.BA1_FILIAL 	= '" 	+ xFilial("BA1") + "'														" 	+ CRLF
	_cQuery += " 				AND BI3.BI3_FILIAL 	= '" 	+ xFilial("BI3") + "'														" 	+ CRLF
	_cQuery += " 				AND PBL.PBL_FILIAL 	= '" 	+ xFilial("PBL") + "'														" 	+ CRLF
	_cQuery += " 				AND PCF.PCF_FILIAL 	= '" 	+ xFilial("PCF") + "'														" 	+ CRLF
	_cQuery += " 				AND PCB.PCB_FILIAL 	= '" 	+ xFilial("PCB") + "'														" 	+ CRLF
	_cQuery += " 				AND PCD.PCD_FILIAL 	(+)= '" + xFilial("PCD") + "'														" 	+ CRLF
	_cQuery += " 				AND PCA.PCA_FILIAL 	= '" 	+ xFilial("PCA") + "'														" 	+ CRLF
	_cQuery += " 				AND SX5.X5_FILIAL 	= '" 	+ xFilial("SX5") + "'														" 	+ CRLF
	_cQuery += " 				AND BAQ.BAQ_FILIAL 	(+)= '" + xFilial("BAQ") + "'														" 	+ CRLF
	_cQuery += " 				AND ZX.D_E_L_E_T_  	= ' ' 																				"	+ CRLF
	_cQuery += " 				AND ZY.D_E_L_E_T_	= ' ' 																				" 	+ CRLF
	_cQuery += " 				AND BA1.D_E_L_E_T_	= ' ' 																				" 	+ CRLF
	_cQuery += " 				AND BI3.D_E_L_E_T_	= ' ' 																				" 	+ CRLF
	_cQuery += " 				AND PBL.D_E_L_E_T_	= ' ' 																				" 	+ CRLF
	_cQuery += " 				AND PCF.D_E_L_E_T_	= ' ' 																				" 	+ CRLF
	_cQuery += " 				AND PCB.D_E_L_E_T_	= ' ' 																				" 	+ CRLF
	_cQuery += " 				AND BG9.D_E_L_E_T_	= ' ' 																				" 	+ CRLF
	_cQuery += " 				AND PCD.D_E_L_E_T_	(+)= ' ' 																			" 	+ CRLF
	_cQuery += " 				AND PCA.D_E_L_E_T_	= ' ' 																				" 	+ CRLF
	_cQuery += " 				AND SX5.D_E_L_E_T_	= ' ' 																				" 	+ CRLF
	_cQuery += " 				AND BAQ.D_E_L_E_T_  (+)= ' ' 																			"	+ CRLF

	//---------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data:16/08/2016
	//---------------------------------------------------------------------------------------------------
	//Acrescentado UNION para pegar os benefici·rios que ainda n„o possuem cadastro no sistema,
	//n„o possuindo assim vinculo com a BA1 e nem com a BI3
	//---------------------------------------------------------------------------------------------------

	_cQuery += " UNION 																													" 	+ CRLF
	_cQuery += "	SELECT  																											" 	+ CRLF
	_cQuery += " 		ZX.ZX_PESQUIS PESQUISA,																							" 	+ CRLF // MATEUS MEDEIROS - 24/10/18
	_cQuery += " 		ZX.ZX_SEQ PROTOCOLO,																							" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_SEQSERV,' ') SEQUEN,																					" 	+ CRLF
	_cQuery += " 		TO_DATE(TRIM(ZX.ZX_DATDE||ZX.ZX_HORADE),'YYYYMMDDHH24MI') DATADE,												" 	+ CRLF
	_cQuery += " 		(CASE																											" 	+ CRLF
	_cQuery += " 		   WHEN (TRIM(ZX.ZX_DATATE) IS NULL OR TRIM(ZX.ZX_HORATE) IS NULL) THEN NULL									" 	+ CRLF
	_cQuery += " 		   ELSE TO_DATE(TRIM(ZX.ZX_DATATE||ZX.ZX_HORATE),'YYYYMMDDHH24MI')												" 	+ CRLF
	_cQuery += " 		END) DATAATE,																									" 	+ CRLF
	_cQuery += "		DECODE(ZX.ZX_CBCD,'1','SIM','N√O') CART_BEM_CUIDADA,															" 	+ CRLF //ANDERSON RANGEL - MAR«O/2021 - ID 74009 (INCLUS√O DO CAMPO "CART_BEM_CUIDADA")

// -[ chamado 87962 - gus - ini ]--------------------------------------------------------
	_cQuery += "		DECODE(ZX.ZX_MITRIS,'1','SIM','N√O') MITIGACAO_RISCO, "                                                             + CRLF
// -[ chamado 87962 - gus - fim ]--------------------------------------------------------
// -[ chamado 88753 - gus - ini ]--------------------------------------------------------
	_cQuery += "        ZX.ZX_MRDATA MIT_DATA, "                                                                                        + CRLF
	_cQuery += "        ZX.ZX_MRHORA MIT_HORA, "                                                                                        + CRLF
	_cQuery += "        ZX.ZX_MRUSER MIT_USER, "                                                                                        + CRLF
// -[ chamado 88753 - gus - fim ]--------------------------------------------------------

// -[ chamado 88956 - gus - ini ]--------------------------------------------------------
	_cQuery += "		DECODE(ZX.ZX_EMACEL,'1','SIM','N√O') NAO_EMAIL_CEL, " + CRLF
	_cQuery += "        ZX.ZX_ECDATA EMACEL_DATA, "                           + CRLF
	_cQuery += "        ZX.ZX_ECHORA EMACEL_HORA, "                           + CRLF
// -[ chamado 88956 - gus - fim ]--------------------------------------------------------

	_cQuery += " 		ZX.ZX_CODINT||ZX.ZX_CODEMP||ZX.ZX_MATRIC||ZX.ZX_TIPREG||ZX.ZX_DIGITO MATRIC,									" 	+ CRLF
	_cQuery += " 		' ' PLANO,																										" 	+ CRLF
	_cQuery += " 		' ' MUNICIPIO_USUARIO,																							" 	+ CRLF
	_cQuery += " 		' ' PLANODESC,																									"	+ CRLF
	_cQuery += " 		ZX.ZX_NOMUSR NOMEUSR,																							" 	+ CRLF
	_cQuery += " 		IDADE(TO_DATE('','YYYYMMDD')) IDADE,																			" 	+ CRLF // ANDERSON RANGEL - MAR«O/2021 - ID 74286 e 74279 (MELHORIA)
	_cQuery += " 		ZX.ZX_RDA RDA,																									" 	+ CRLF
	_cQuery += " 		NVL(																											" 	+ CRLF
	_cQuery += " 		(																												" 	+ CRLF
	_cQuery += " 			SELECT 																										" 	+ CRLF
	_cQuery += " 				BAU.BAU_NOME																							" 	+ CRLF
	_cQuery += " 			FROM 																										" 	+ CRLF
	_cQuery += " 				" + RETSQLNAME("BAU") + "  BAU																			" 	+ CRLF
	_cQuery += " 			WHERE 																										" 	+ CRLF
	_cQuery += " 				BAU.D_E_L_E_T_ = ' '																					"	+ CRLF
	_cQuery += " 				AND BAU.BAU_FILIAL = '" + xFilial("BAU") + "'															" 	+ CRLF
	_cQuery += " 				AND BAU.BAU_CODIGO = ZX.ZX_RDA																			" 	+ CRLF
	_cQuery += " 		) 																												" 	+ CRLF
	_cQuery += " 		,' ') NOME,																										" 	+ CRLF
	_cQuery += " 		ZX.ZX_TPATEND,DECODE(ZX.ZX_TPATEND,'1','At.Caberj',' ') ATENDIMENTO,											" 	+ CRLF
	_cQuery += " 		ZX.ZX_TPINTEL,DECODE(ZX.ZX_TPINTEL,'1','Pendente','2','Encerrado','3','Em Andamento','4','Encerrado em acompanhamento',' ') SITUACAO, " 	+ CRLF
	_cQuery += " 		ZX.ZX_CONTATO CONTATO,																							" 	+ CRLF
	_cQuery += " 		ZX.ZX_USDIGIT USDIGIT,																							" 	+ CRLF
	_cQuery += " 		(CASE																											" 	+ CRLF
	_cQuery += " 		   WHEN (TRIM(ZY.ZY_DTSERV) IS NULL OR TRIM(ZY.ZY_HORASV) IS NULL) THEN NULL									" 	+ CRLF
	_cQuery += " 		   ELSE TO_DATE(ZY.ZY_DTSERV||ZY.ZY_HORASV,'YYYYMMDDHH24MI')													" 	+ CRLF
	_cQuery += " 		END) DATASERV,																									" 	+ CRLF
	_cQuery += " 		NVL2(TRIM(ZY.ZY_HORASV),SUBSTR(ZY.ZY_HORASV,1,2)||':'||SUBSTR(ZY.ZY_HORASV,3,2),' ') HORASERV, 					" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_TIPOSV, ' ') TIPOSV,																					" 	+ CRLF
	_cQuery += " 		PBL.PBL_YDSSRV SERVICO,																							" 	+ CRLF
	_cQuery += " 		DECODE(TRIM(ZX.ZX_SLA),NULL,'X',ZX.ZX_SLA) META_SLA,															" 	+ CRLF
	_cQuery += " 		N_DIAS_UTEIS_PERIODO(TO_DATE(TRIM(ZX_DATDE ||ZX_HORADE),'YYYYMMDDHH24MI'), 							            " 	+ CRLF
	_cQuery += " 		                     NVL(TO_DATE(TRIM(ZX_DATATE||ZX_HORATE),'YYYYMMDDHH24MI'), SYSDATE)) DIAS_UTEIS,			" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_OBS,' ') OBS,																							" 	+ CRLF
	_cQuery += " 		CASE PBL.PBL_GERED 																								" 	+ CRLF
	_cQuery += " 		    WHEN '1' THEN NVL(BAQ.BAQ_CODESP,' ')   																	" 	+ CRLF
	_cQuery += " 		    ELSE NVL(PCD.PCD_COD,' ')               																	" 	+ CRLF
	_cQuery += " 		END COD_HIST,																									" 	+ CRLF
	_cQuery += " 		CASE PBL.PBL_GERED                          																	" 	+ CRLF
	_cQuery += " 		    WHEN '1' THEN NVL(BAQ.BAQ_DESCRI,' ')   																	" 	+ CRLF
	_cQuery += " 		    ELSE NVL(PCD.PCD_DESCRI,' ')            																	" 	+ CRLF
	_cQuery += " 		END HISTORICO_PADRAO,				        																	" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_DTRESPO,' ') DATA_RESPOSTA,																			" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_HRRESPO,' ') HORA_RESPOSTA,																			" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_RESPOST,' ') RESPOSTA,																				" 	+ CRLF
	_cQuery += " 		(																												" 	+ CRLF
	_cQuery += " 	    	SELECT                                                      												" 	+ CRLF
	_cQuery += " 	        	SZY_RESP.ZY_LOGRESP                                     												" 	+ CRLF
	_cQuery += " 	    	FROM                                                        												" 	+ CRLF
	_cQuery += " 	        	" + RETSQLNAME("SZY") + " SZY_RESP                                         								" 	+ CRLF
	_cQuery += " 	    	WHERE                                                       												" 	+ CRLF
	_cQuery += " 	        	SZY_RESP.ZY_FILIAL      = ZY.ZY_FILIAL                  												" 	+ CRLF
	_cQuery += " 	        	AND SZY_RESP.ZY_SEQBA   = ZY.ZY_SEQBA                   												" 	+ CRLF
	_cQuery += " 	        	AND SZY_RESP.ZY_LOGRESP <> ' '                          												" 	+ CRLF
	_cQuery += " 	        	AND SZY_RESP.D_E_L_E_T_ = ' '                           												" 	+ CRLF
	_cQuery += " 	        	AND SZY_RESP.R_E_C_N_O_ = (                             												" 	+ CRLF
	_cQuery += " 	            	SELECT                                              												" 	+ CRLF
	_cQuery += " 	                	MAX(SZY_INT.R_E_C_N_O_)                         												" 	+ CRLF
	_cQuery += " 	            	FROM                                                												" 	+ CRLF
	_cQuery += " 	                	" + RETSQLNAME("SZY") + " SZY_INT                                  								" 	+ CRLF
	_cQuery += " 	            	WHERE                                               												" 	+ CRLF
	_cQuery += " 	                	SZY_INT.ZY_FILIAL      = SZY_RESP.ZY_FILIAL     												" 	+ CRLF
	_cQuery += " 	                	AND SZY_INT.ZY_SEQBA   = SZY_RESP.ZY_SEQBA      												" 	+ CRLF
	_cQuery += " 	                	AND SZY_INT.ZY_LOGRESP <> ' '                   												" 	+ CRLF
	_cQuery += " 	                	AND SZY_INT.D_E_L_E_T_ = SZY_RESP.D_E_L_E_T_    												" 	+ CRLF
	_cQuery += " 	        )                                                       													" 	+ CRLF
	_cQuery += " 		)USDIGRESP,                                                     												" 	+ CRLF
	_cQuery += " 		NVL(ZY.ZY_USDIGIT,' ') USDIGITSV,																				" 	+ CRLF
	_cQuery += " 		S_HORAS_UTEIS_PERIODO(TO_DATE(TRIM(ZX.ZX_DATDE||ZX.ZX_HORADE) ,'YYYYMMDDHH24MI'),								" 	+ CRLF
	_cQuery += " 		NVL(TO_DATE(TRIM(ZX.ZX_DATATE||ZX.ZX_HORATE),'YYYYMMDDHH24MI'), SYSDATE)) DURACAO,								" 	+ CRLF
	_cQuery += " 		NVL(TRIM(ZX.ZX_CODAREA),' ') COD_AREA,																			"	+ CRLF
	_cQuery += " 		NVL(TRIM(PCF.PCF_DESCRI),' ') AREA_RES,																			"	+ CRLF
	_cQuery += " 		NVL(TRIM(PCA.PCA_DESCRI),' ') TIPO_ENTRADA, 																	" 	+ CRLF
	_cQuery += " 		TRIM(SX5.X5_DESCRI) DEMANDA,																					" 	+ CRLF
	_cQuery += " 		ZX.ZX_CANAL COD_CANAL,																							"	+ CRLF
	_cQuery += " 		TRIM(PCB.PCB_DESCRI) CANAL,																						" 	+ CRLF

	//------------------------------------------------------------
	// Angelo Henrique - Data: 29/06/2016
	//------------------------------------------------------------
	//ValidaÁ„o de dias que se encontra ou n„o em atraso
	//------------------------------------------------------------
	_cQuery += "     	(																												" 	+ CRLF
	_cQuery += "     			DECODE(TRIM(ZX.ZX_SLA),NULL,'X',ZX.ZX_SLA) - 															" 	+ CRLF
	_cQuery += "     			(																										" 	+ CRLF
	_cQuery += " 					TRUNC(((N_HORAS_UTEIS_PERIODO(TO_DATE(TRIM(ZX_DATDE ||ZX_HORADE),'YYYYMMDDHH24MI'), 				" 	+ CRLF
	_cQuery += " 					NVL(TO_DATE(TRIM(ZX_DATATE||ZX_HORATE),'YYYYMMDDHH24MI'), SYSDATE)) /9)/60),0) 						" 	+ CRLF
	_cQuery += "     			)																										" 	+ CRLF
	_cQuery += "     	) DIAS_EX, 																										" 	+ CRLF

	//Colocando informaÁ„o se vai expirar ou n„o
	_cQuery += "     	DECODE																											" 	+ CRLF
	_cQuery += "    		(																											" 	+ CRLF
	_cQuery += "     			SUBSTR																									" 	+ CRLF
	_cQuery += "     			(																										" 	+ CRLF
	_cQuery += "     				(  																									" 	+ CRLF
	_cQuery += "     					 DECODE(TRIM(ZX.ZX_SLA),NULL,'X',ZX.ZX_SLA) - 													" 	+ CRLF
	_cQuery += "     					(  																								" 	+ CRLF
	_cQuery += " 							TRUNC(((N_HORAS_UTEIS_PERIODO(TO_DATE(TRIM(ZX_DATDE ||ZX_HORADE),'YYYYMMDDHH24MI'), 		" 	+ CRLF
	_cQuery += " 							NVL(TO_DATE(TRIM(ZX_DATATE||ZX_HORATE),'YYYYMMDDHH24MI'), SYSDATE)) /9)/60),0) 				" 	+ CRLF
	_cQuery += "     					)  																								" 	+ CRLF
	_cQuery += "     				)  																									" 	+ CRLF
	_cQuery += "     			,1,1  																									" 	+ CRLF
	_cQuery += "     			)  																										" 	+ CRLF
	_cQuery += "     		,'-','EXPIRADO','0','EXPIRADO','A EXPIRAR'  																" 	+ CRLF
	_cQuery += "     		)EXPIRA,  																									" 	+ CRLF
	_cQuery += "     		ZX.ZX_TPINTEL TPINTEL, 																						" 	+ CRLF
	_cQuery += "     		' ' GRUPO_EMPRESA, 																							" 	+ CRLF  //sergio cunha 05/12/16
	_cQuery += "     		NVL2(TRIM(ZX.ZX_HORADE),SUBSTR(ZX.ZX_HORADE,1,2)||':'||SUBSTR(ZX.ZX_HORADE,3,2),' ') HORADE, 				" 	+ CRLF
	_cQuery += "     		NVL2(TRIM(ZX.ZX_HORATE),SUBSTR(ZX.ZX_HORATE,1,2)||':'||SUBSTR(ZX.ZX_HORATE,3,2),' ') HORATE,  				" 	+ CRLF
	_cQuery += "     		TRIM(ZX_EMAIL) EMAIL, 																					    " 	+ CRLF
	_cQuery += "     		'NAO' VIP  																									" 	+ CRLF	
	_cQuery += " 			FROM  																										" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("SZX") + " ZX,  																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("SZY") + " ZY,  																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PBL") + " PBL, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PCF") + " PCF, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PCB") + " PCB, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PCD") + " PCD, 																			" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("PCA") + " PCA, 																			" 	+ CRLF
	_cQuery += "				SX5010 SX5,  																							" 	+ CRLF
	_cQuery += "				" + RETSQLNAME("BAQ") + " BAQ 																			" 	+ CRLF
	_cQuery += " 			WHERE 																										"   + CRLF
	_cQuery += " 				ZY.ZY_FILIAL  		 = ZX.ZX_FILIAL																		"	+ CRLF
	_cQuery += " 				AND ZY.ZY_SEQBA   	 = ZX.ZX_SEQ																		" 	+ CRLF
	_cQuery += " 				AND ZX.ZX_MATRIC 	 = ' '																				"	+ CRLF

	If !Empty(MV_PAR04) .And. !Empty(MV_PAR05)

		_cQuery += " 				AND TRIM(ZX.ZX_DATDE) BETWEEN '" + ALLTRIM(DTOS(Mv_Par04)) + "' AND '" + ALLTRIM(DTOS(Mv_Par05)) + "' 	" 	+ CRLF

	EndIf

	If !Empty(MV_PAR15) .And. !Empty(MV_PAR16)

		_cQuery += " 				AND TRIM(ZY.ZY_DTRESPO) BETWEEN '" + ALLTRIM(DTOS(Mv_Par15)) + "' AND '" + ALLTRIM(DTOS(Mv_Par16)) + "' 	" 	+ CRLF

	EndIf

	If MV_PAR17 == 1
		_cQuery += " 				AND ZX.ZX_CBCD = '1'													" 	+ CRLF
	Elseif MV_PAR17 == 0
		_cQuery += " 				AND ZX.ZX_CBCD IN ('0',' ')												" 	+ CRLF
	Elseif MV_PAR17 == 3
		_cQuery += " 				AND ZX.ZX_CBCD IN ('0','1',' ')											" 	+ CRLF
	EndIf

// -[ chamado 87962 - gus - ini ]--------------------------------------------------------
	if MV_PAR18 == 1
		_cQuery += " 				AND ZX.ZX_MITRIS = '1' 													" 	+ CRLF
	elseif MV_PAR18 == 2
		_cQuery += " 				AND ZX.ZX_MITRIS IN ('0',' ') 											"   + CRLF
	elseif MV_PAR18 == 3
		_cQuery += " 				AND ZX.ZX_MITRIS IN ('0','1',' ') 										" 	+ CRLF
	endif
// -[ chamado 87962 - gus - fim ]--------------------------------------------------------

// -[ chamado 88956 - gus - ini ]--------------------------------------------------------
	    if MV_PAR19 == 1
		_cQuery += " 				AND ZX.ZX_EMACEL = '1'            " + CRLF
	elseif MV_PAR19 == 2
		_cQuery += " 				AND ZX.ZX_EMACEL IN ('0',' ')     " + CRLF
	elseif MV_PAR19 == 3
		_cQuery += " 				AND ZX.ZX_EMACEL IN ('0','1',' ') " + CRLF
	endif
// -[ chamado 88956 - gus - fim ]--------------------------------------------------------

	//------------------------------------------------------------------
	// Angelo Henrique - Data: 23/01/2018
	//------------------------------------------------------------------
	// ValidaÁ„o criada para n„o exibir os protocolos que s„o criados
	// na DIRETORIA
	//------------------------------------------------------------------
	If !(Upper(AllTrim(c_CodUsr)) $ Upper(AllTrim(GetNewPar("MV_XUSUDIR",""))))

		_cQuery += " 				AND ZX.ZX_CANAL <> '000014' 																		" 	+ CRLF

	EndIf

	_cQuery += " 				AND PBL.PBL_YCDSRV = ZY.ZY_TIPOSV																		" 	+ CRLF
	_cQuery += " 				AND ZX.ZX_CODAREA  = PCF.PCF_COD																		" 	+ CRLF
	_cQuery += " 				AND ZX.ZX_CANAL    = PCB.PCB_COD																		" 	+ CRLF
	_cQuery += " 				AND ZX.ZX_PTENT    = PCA.PCA_COD																		" 	+ CRLF

	If !Empty(MV_PAR01)
		_cQuery += " 				AND TRIM(ZX.ZX_SEQ)= '" + ALLTRIM(MV_PAR01) + "'													" 	+ CRLF
	EndIf

	If !Empty(MV_PAR14)
		_cQuery += " 				AND TRIM(ZX.ZX_CODEMP)   = '"+ALLTRIM(MV_PAR14)+"'													" 	+ CRLF
	EndIf

	If !Empty(MV_PAR02)
		_cQuery += " 				AND ZX.ZX_CODINT||ZX.ZX_CODEMP||ZX.ZX_MATRIC||ZX.ZX_TIPREG||ZX.ZX_DIGITO  = '"+ALLTRIM(MV_PAR02)+"'	" 	+ CRLF
	EndIf

	_cQuery += " 				AND ZX.ZX_TPINTEL      IN (  "+ cTpIntel +"   )	" 	+ CRLF

	If !Empty(MV_PAR08)
		_cQuery += " 				AND TRIM(ZX.ZX_CODAREA) = '"+ALLTRIM(MV_PAR08)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(ZX.ZX_CODAREA) <> ' '																		"	+ CRLF
	EndIf

	If !Empty(MV_PAR09)
		_cQuery += " 				AND TRIM(PBL.PBL_YCDSRV) = '"+ALLTRIM(MV_PAR09)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(PBL.PBL_YCDSRV) <> ' '																		" 	+ CRLF
	EndIf

	If !Empty(MV_PAR10)
		_cQuery += " 				AND PCD.PCD_COD (+)= '"+ALLTRIM(MV_PAR10)+"'													" 	+ CRLF	
	EndIf

	_cQuery += " 				AND PCD.PCD_COD (+)= ZY.ZY_HISTPAD  																	" 	+ CRLF

	If !Empty(MV_PAR03)
		_cQuery += " 				AND TRIM(ZX.ZX_TPDEM)   = '"+ALLTRIM(MV_PAR03)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(ZX.ZX_TPDEM)   <> ' ' 																		" 	+ CRLF
	EndIf

	If !Empty(MV_PAR06)
		_cQuery += " 				AND TRIM(ZX.ZX_PTENT)   = '"+ALLTRIM(MV_PAR06)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(ZX.ZX_PTENT)   <> ' '																		" 	+ CRLF
	EndIf

	If !Empty(MV_PAR07)
		_cQuery += " 				AND TRIM(ZX.ZX_CANAL)   = '"+ALLTRIM(MV_PAR07)+"'													" 	+ CRLF
	Else
		_cQuery += " 				AND TRIM(ZX.ZX_CANAL)   <> ' '																		"  	+ CRLF
	EndIf

	If !Empty(MV_PAR14)
		_cQuery += " 				AND TRIM(ZX.ZX_CODEMP)   = '"+ALLTRIM(MV_PAR14)+"'													" 	+ CRLF
	EndIf

	_cQuery += " 				AND SX5.X5_TABELA   	= 'ZT'																			" 	+ CRLF
	_cQuery += " 				AND SX5.X5_CHAVE    	= ZX.ZX_TPDEM 																	" 	+ CRLF
	_cQuery += " 				AND BAQ_CODINT      	(+)= '0001'																		" 	+ CRLF
	_cQuery += " 				AND BAQ.BAQ_CODESP  	(+)= ZY.ZY_HISTPAD																" 	+ CRLF
	_cQuery += " 				AND ZX.ZX_FILIAL 		= '" + xFilial("SZX") + "'														" 	+ CRLF
	_cQuery += " 				AND ZY.ZY_FILIAL 		= '" + xFilial("SZY") + "'														" 	+ CRLF
	_cQuery += " 				AND PBL.PBL_FILIAL 		= '" + xFilial("PBL") + "'														" 	+ CRLF
	_cQuery += " 				AND PCF.PCF_FILIAL 		= '" + xFilial("PCF") + "'														" 	+ CRLF
	_cQuery += " 				AND PCB.PCB_FILIAL 		= '" + xFilial("PCB") + "'														" 	+ CRLF
	_cQuery += " 				AND PCD.PCD_FILIAL 		(+)= '" + xFilial("PCD") + "'														" 	+ CRLF
	_cQuery += " 				AND PCA.PCA_FILIAL 		= '" + xFilial("PCA") + "'														" 	+ CRLF
	_cQuery += " 				AND SX5.X5_FILIAL 		= '" + xFilial("SX5") + "'														" 	+ CRLF
	_cQuery += " 				AND BAQ.BAQ_FILIAL 		(+)= '" + xFilial("BAQ") + "'														" 	+ CRLF
	_cQuery += " 				AND ZX.D_E_L_E_T_  		= ' ' 																			"	+ CRLF
	_cQuery += " 				AND ZY.D_E_L_E_T_  		= ' ' 																			"	+ CRLF
	_cQuery += " 				AND PBL.D_E_L_E_T_  	= ' ' 																			"	+ CRLF
	_cQuery += " 				AND PCF.D_E_L_E_T_  	= ' ' 																			"	+ CRLF
	_cQuery += " 				AND PCB.D_E_L_E_T_  	= ' ' 																			"	+ CRLF
	_cQuery += " 				AND PCD.D_E_L_E_T_  	(+)= ' ' 																		"	+ CRLF
	_cQuery += " 				AND PCA.D_E_L_E_T_  	= ' ' 																			"	+ CRLF
	_cQuery += " 				AND SX5.D_E_L_E_T_  	= ' ' 																			"	+ CRLF
	_cQuery += " 				AND BAQ.D_E_L_E_T_  	(+)= ' ' 																		"	+ CRLF
	_cQuery += "	)																													" 	+ CRLF
	_cQuery += "ORDER BY 3, 1, 2 																										"   + CRLF

	memowrite("C:\temp\cabr212.sql",_cQuery)

Return _cQuery


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABR212E  ∫Autor  ≥Angelo Henrique     ∫ Data ≥  24/10/16   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥Rotina responsavel por gerar o relatÛrio em CSV, pois       ∫±±
±±∫          ≥alguns usu·rios n„o possuem o Excel.                        ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ CABERJ                                                     ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

Static Function CABR212E()

	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""

	Private _cAlias2	:= GetNextAlias()

	ProcRegua(RecCount())

	cNomeArq := "C:\TEMP\PROTOCOLO_PA"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"

	//---------------------------------------------
	//CABR212D Realiza toda a montagem da query
	//facilitando a manutenÁ„o do fonte
	//---------------------------------------------
	_cQuery := CABR212D()

	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)

	While !(_cAlias2)->(EOF())

		IncProc()

		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabeÁalho
		//------------------------------------------------------------------
		If nHandle = 0

			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)

			If nHandle > 0

				cMontaTxt := "PROTOCOLO ;"
				cMontaTxt += "NUMERO_SERVICO;"
				cMontaTxt += "DEMANDA;"
				cMontaTxt += "DATA_PROTOCOLO;"
				cMontaTxt += "HORA_PROTOCOLO;"
				cMontaTxt += "DATA_ENCERRAMENTO;"
				cMontaTxt += "DATA_SERVICO;"
				cMontaTxt += "MATRICULA;"
				cMontaTxt += "CART_BEM_CUIDADA;"

// -------------[ chamado 87962 - gus - ini ]--------------------------------------------
				cMontaTxt += "MITIGACAO_RISCO;"
// -------------[ chamado 87962 - gus - fim ]--------------------------------------------
// -------------[ chamado 88753 - gus - ini ]--------------------------------------------
				cMontaTxt += "MIT_DATA;"
				cMontaTxt += "MIT_HORA;"
				cMontaTxt += "MIT_USER;"
// -------------[ chamado 88753 - gus - fim ]--------------------------------------------

// -------------[ chamado 88956 - gus - ini ]--------------------------------------------
				cMontaTxt += "NAO_EMAIL_CEL;"
				cMontaTxt += "EMACEL_DATA;"
				cMontaTxt += "EMACEL_HORA;"
// -------------[ chamado 88956 - gus - fim ]--------------------------------------------

				cMontaTxt += "COD_PLANO;"
				cMontaTxt += "PLANO_DESCR;"
				cMontaTxt += "NOME_USUARIO;"
				cMontaTxt += "IDADE;"
				cMontaTxt += "MUNICIPIO_USUARIO;"
				cMontaTxt += "ATENDIMENTO;"
				cMontaTxt += "SITUACAO;"
				cMontaTxt += "CONTATO;"
				cMontaTxt += "DIGITADOR;"
				cMontaTxt += "CODIGO_SERVICO;"
				cMontaTxt += "SERVICO;"
				cMontaTxt += "CODIGO_HISTPAD;"
				cMontaTxt += "HIST_PADRAO;"
				cMontaTxt += "OBSERVACAO;"
				cMontaTxt += "DATA_RESPOSTA;"
				cMontaTxt += "HORA_RESPOSTA;"
				cMontaTxt += "RESPOSTA;"
				cMontaTxt += "USU_RESP;"
				cMontaTxt += "COD_AREA;"
				cMontaTxt += "AREA_RESP;"
				cMontaTxt += "COD_CANAL;"
				cMontaTxt += "CANAL;"
				cMontaTxt += "META_SLA;"
				cMontaTxt += "DIAS_UTEIS;"
				cMontaTxt += "DURACAO;"
				cMontaTxt += "PORTA_ENTRADA;"
				cMontaTxt += "COD_RDA;"
				cMontaTxt += "Avaliado;"
				cMontaTxt += "DIAS_EX;"
				cMontaTxt += "S_N_EXP;"
				cMontaTxt += "GRUPO_EMPRESA;"
				cMontaTxt += "EMAIL;"
				cMontaTxt += "VIP;"

				cMontaTxt += CRLF // Salto de linha para .csv (excel)

				FWrite(nHandle,cMontaTxt)

			Else

				Aviso("AtenÁ„o","N„o foi possÌvel criar o relatÛrio",{"OK"})
				Exit

			EndIf

		EndIf

		cMontaTxt := "'" + AllTrim((_cAlias2)->PROTOCOLO) 		+ ";"
		cMontaTxt += "'" + AllTrim(PADL((_cAlias2)->SEQUEN,TAMSX3("ZY_SEQSERV")[1],"0")) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DEMANDA) 				+ ";"
		cMontaTxt += AllTrim(DTOC((_cAlias2)->DATADE))			+ ";"
		cMontaTxt += AllTrim((_cAlias2)->HORADE)				+ ";"
		cMontaTxt += AllTrim(DTOC((_cAlias2)->DATAATE))			+ ";"
		cMontaTxt += AllTrim(DTOC((_cAlias2)->DATASERV))		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->MATRIC) 				+ ";"
		cMontaTxt += AllTrim((_cAlias2)->CART_BEM_CUIDADA) 		+ ";"

// -----[ chamado 87962 - gus - ini ]----------------------------------------------------
		cMontaTxt += AllTrim((_cAlias2)->MITIGACAO_RISCO)       + ";"
// -----[ chamado 87962 - gus - fim ]----------------------------------------------------
// -----[ chamado 88753 - gus - ini ]----------------------------------------------------
        cMontaTxt += alltrim(              (_cAlias2)->MIT_DATA  ) + ";"
        cMontaTxt += alltrim(              (_cAlias2)->MIT_HORA  ) + ";"
        cMontaTxt += alltrim(              (_cAlias2)->MIT_USER  ) + ";"
        cMontaTxt += alltrim( UsrFullName( (_cAlias2)->MIT_USER) ) + ";"
// -----[ chamado 88753 - gus - fim ]----------------------------------------------------

// -----[ chamado 88956 - gus - ini ]----------------------------------------------------
		cMontaTxt += alltrim( (_cAlias2)->NAO_EMAIL_CEL ) + ";"
        cMontaTxt += alltrim( (_cAlias2)->MIT_DATA      ) + ";"
        cMontaTxt += alltrim( (_cAlias2)->MIT_HORA      ) + ";"
// -----[ chamado 88956 - gus - fim ]----------------------------------------------------

		cMontaTxt += "'" + AllTrim((_cAlias2)->PLANO) 			+ ";"
		cMontaTxt += AllTrim((_cAlias2)->PLANODESC) 			+ ";"
		cMontaTxt += AllTrim((_cAlias2)->NOMEUSR) 				+ ";"
		cMontaTxt += AllTrim(cValToChar((_cAlias1)->IDADE))		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->MUNICIPIO)				+ ";"
		cMontaTxt += AllTrim((_cAlias2)->ATENDIMENTO) 			+ ";"
		cMontaTxt += AllTrim((_cAlias2)->SITUACAO) 				+ ";"
		cMontaTxt += AllTrim((_cAlias2)->CONTATO) 				+ ";"
		cMontaTxt += AllTrim((_cAlias2)->USDIGIT)		 		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->TIPOSV) 				+ ";"
		cMontaTxt += AllTrim((_cAlias2)->SERVICO) 				+ ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_HIST) 		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->HISTORICO_PADRAO) 		+ ";"
		cMontaTxt += AllTrim(Replace((_cAlias2)->OBS,";",","))	+ ";"
		cMontaTxt += AllTrim(IIF(ValType((_cAlias2)->DATA_RESPOSTA) = "C",DTOC((_cAlias2)->DATA_RESPOSTA),DTOC((_cAlias2)->DATA_RESPOSTA))) + ";"
		cMontaTxt += AllTrim((_cAlias2)->HORA_RESPOSTA) 		+ ";"
		cMontaTxt += AllTrim(Replace((_cAlias2)->RESPOSTA,";",","))	+ ";"
		cMontaTxt += AllTrim((_cAlias2)->USDIGITSV) 			+ ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_AREA) 		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->AREA_RES) 				+ ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_CANAL)		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->CANAL) 				+ ";"
		cMontaTxt += AllTrim(cValToChar((_cAlias2)->META_SLA))	+ ";"
		cMontaTxt += AllTrim(cValToChar((_cAlias2)->DIAS_UTEIS))+ ";"
		cMontaTxt += AllTrim((_cAlias2)->DURACAO) 				+ ";"
		cMontaTxt += AllTrim((_cAlias2)->TIPO_ENTRADA) 			+ ";"
		cMontaTxt += AllTrim((_cAlias2)->RDA) 					+ ";"
		cMontaTxt += AllTrim((_cAlias2)->NOME) 					+ ";"

		If (_cAlias2)->TPINTEL == "1" //Em Aberto

			cMontaTxt += AllTrim(STRTRAN(cValToChar((_cAlias2)->DIAS_EX), "-","")) + ";"
			cMontaTxt += AllTrim((_cAlias2)->EXPIRA) + ";"

		Else //Encerrada

			cMontaTxt += AllTrim(STRTRAN(cValToChar((_cAlias2)->DIAS_EX), "-","")) + ";"

			If val((_cAlias1)->META_SLA) -(_cAlias1)->DIAS_UTEIS >= 0
				cMontaTxt += "SLA ATINGIDO;"
			else
				cMontaTxt += "FORA SLA;"
			EndIf
		EndIf
		cMontaTxt += AllTrim((_cAlias2)->GRUPO_EMPRESA)			+ ";"
		cMontaTxt += AllTrim(lower((_cAlias2)->EMAIL))			+ ";"
		cMontaTxt += AllTrim(lower((_cAlias2)->VIP))			+ ";"
		cMontaTxt += CRLF // Salto de linha para .csv (excel)

		FWrite(nHandle,cMontaTxt)

		(_cAlias2)->(DbSkip())

	EndDo

	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf

	If nHandle > 0

		// encerra gravaÁ„o no arquivo
		FClose(nHandle)

		MsgAlert("Relatorio salvo em: "+cNomeArq)

	EndIf

	RestArea(_aArea)

Return
