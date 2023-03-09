//#include "PLSA090.ch"
#include "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
//#INCLUDE "UTILIDADES.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABR259
 Relatório utilizado para exibir o log dos boletos enviados
@author  Angelo Henrique
@since   05/05/2022
@version version
/*/
//-------------------------------------------------------------------
User Function CABR259()

	Local _aArea 	:= GetArea()
	Local oReport	:= Nil

	Private c_Perg 	:= "CABR259"

	CABR259A( c_Perg )

	If Pergunte( c_Perg )

		//----------------------------------------------------
		//Validando se existe o Excel instalado na máquina
		//para não dar erro e o usuário poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")

			oReport := CABR259B()
			oReport:PrintDialog()

		Else

			//Processa({||GeraLogEmail()},'Processando...')

		EndIf

	EndIf

	RestArea(_aArea)

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABR259A
 Rotina responsável pela criação das perguntas do relatório
@author  Angelo Henrique
@since   05/05/2022
@version version
/*/
//-------------------------------------------------------------------
Static Function CABR259A(cPerg)
	
	u_CABASX1(cPerg,"01",OemToAnsi("Ano Base De" 	)	,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"02",OemToAnsi("Ano Base Ate"	)	,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"03",OemToAnsi("Mes Base De"	)	,"","","mv_ch3","C",02,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"04",OemToAnsi("Mes Base Ate"	)	,"","","mv_ch4","C",02,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"05",OemToAnsi("Matricula"		)	,"","","mv_ch5","C",16,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABR259B
Rotina que irá gerar as informações do relatório
@author  Angelo Henrique
@since   05/05/2022
@version version
/*/
//-------------------------------------------------------------------
Static Function CABR259B

	Local oReport		:= Nil
	Local oSection1 	:= Nil

	oReport := TReport():New("CABR259","LOG ENVIO DE BOLETO",c_Perg,{|oReport| CABR259C(oReport)},"LOG ENVIO DE BOLETO")

	oReport:SetLandScape()

	oReport:oPage:setPaperSize(9)

	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"LOG ENVIO DE BOLETO","BA1")

	TRCell():New(oSection1,"EMPRESA" 		,"BA1")
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(20)

	TRCell():New(oSection1,"CPF" 			,"BA1")
	oSection1:Cell("CPF"):SetAutoSize(.F.)
	oSection1:Cell("CPF"):SetSize(20)
	oSection1:Cell("CPF"):SetTitle("CPF") //Reforçando o título aqui pois estava saindo um titulo aleatório.

	TRCell():New(oSection1,"MATRICULA" 		,"BA1")
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(20)

	TRCell():New(oSection1,"NOME" 			,"BA1")
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(250)

	TRCell():New(oSection1,"EMAIL" 			,"BA1")
	oSection1:Cell("EMAIL"):SetAutoSize(.F.)
	oSection1:Cell("EMAIL"):SetSize(250)

	TRCell():New(oSection1,"DATA" 			,"BA1")
	oSection1:Cell("DATA"):SetAutoSize(.F.)
	oSection1:Cell("DATA"):SetSize(10)

	TRCell():New(oSection1,"HORA" 			,"BA1")
	oSection1:Cell("HORA"):SetAutoSize(.F.)
	oSection1:Cell("HORA"):SetSize(10)

	TRCell():New(oSection1,"ENVIADO" 		,"BA1")
	oSection1:Cell("ENVIADO"):SetAutoSize(.F.)
	oSection1:Cell("ENVIADO"):SetSize(10)

	TRCell():New(oSection1,"MOTIVO" 		,"BA1")
	oSection1:Cell("MOTIVO"):SetAutoSize(.F.)
	oSection1:Cell("MOTIVO"):SetSize(50)

	TRCell():New(oSection1,"COMPETENCIA" 	,"BA1")
	oSection1:Cell("COMPETENCIA"):SetAutoSize(.F.)
	oSection1:Cell("COMPETENCIA"):SetSize(20)

	TRCell():New(oSection1,"TITULO" 		,"BA1")
	oSection1:Cell("TITULO"):SetAutoSize(.F.)
	oSection1:Cell("TITULO"):SetSize(20)

	TRCell():New(oSection1,"SALDO" 			,"BA1")
	oSection1:Cell("SALDO"):SetAutoSize(.F.)
	oSection1:Cell("SALDO"):SetSize(20)

	TRCell():New(oSection1,"VENC_REAL" 		,"BA1")
	oSection1:Cell("VENC_REAL"):SetAutoSize(.F.)
	oSection1:Cell("VENC_REAL"):SetSize(20)

	TRCell():New(oSection1,"PROCESSO" 		,"BA1")
	oSection1:Cell("PROCESSO"):SetAutoSize(.F.)
	oSection1:Cell("PROCESSO"):SetSize(20)	

Return oReport



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR244B  ºAutor  ³Angelo Henrique     º Data ³  13/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para montar a query e trazer as informações no       º±±
±±º          ³relatório.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR259C(oReport)

	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""

	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()

	//---------------------------------------------
	//CABR265D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR259D()

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

		oSection1:Cell("EMPRESA"  	):SetValue((_cAlias1)->EMPRESA		)
		oSection1:Cell("CPF"  		):SetValue((_cAlias1)->CPF			)
		oSection1:Cell("MATRICULA"  ):SetValue((_cAlias1)->MATRICULA	)
		oSection1:Cell("NOME"  		):SetValue((_cAlias1)->NOME			)
		oSection1:Cell("EMAIL"  	):SetValue((_cAlias1)->EMAIL		)
		oSection1:Cell("DATA"  		):SetValue((_cAlias1)->DATA			)
		oSection1:Cell("HORA"  		):SetValue((_cAlias1)->HORA			)
		oSection1:Cell("ENVIADO"  	):SetValue((_cAlias1)->ENVIADO		)
		oSection1:Cell("MOTIVO"  	):SetValue((_cAlias1)->MOTIVO		)
		oSection1:Cell("COMPETENCIA"):SetValue((_cAlias1)->COMPETENCIA	)
		oSection1:Cell("TITULO"  	):SetValue((_cAlias1)->TITULO		)
		oSection1:Cell("SALDO"  	):SetValue((_cAlias1)->SALDO		)
		oSection1:Cell("VENC_REAL"  ):SetValue((_cAlias1)->VENC_REAL	)
		oSection1:Cell("PROCESSO"  	):SetValue((_cAlias1)->PROCESSO		)		

		oSection1:PrintLine()

		(_cAlias1)->(DbSkip())

	EndDo

	oSection1:Finish()

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	RestArea(_aArea)

Return(.T.)


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABR259D
 Rotina responsável por tratar a query, facilitando assim a sua
 manutenção
@author  Angelo Henrique
@since   05/05/2022
@version version
/*/
//-------------------------------------------------------------------

Static Function CABR259D()

	Local _cQuery 	:= ""

	_cQuery += " SELECT                                                                     									" + CRLF
	_cQuery += "    DECODE(TRIM(MAIL.EMPRESA),'C','CABERJ','INTEGRAL') EMPRESA ,            									" + CRLF
	_cQuery += "    BA1.BA1_CPFUSR CPF,                                                         								" + CRLF
	_cQuery += "    MAIL.MATRICULA,                                                        										" + CRLF
	_cQuery += "    TRIM(BA1.BA1_NOMUSR) NOME,                                             										" + CRLF
	_cQuery += "    TRIM(MAIL.EMAIL) EMAIL,                                                 									" + CRLF
	_cQuery += "    FORMATA_DATA_MS(MAIL.DATA) DATA,                                        									" + CRLF
	_cQuery += "    MAIL.HORA HORA,                                                         									" + CRLF
	_cQuery += "    MAIL.ENVIADO,                                                           									" + CRLF
	_cQuery += "    NVL(TRIM(MAIL.MOTIVO),' ') MOTIVO,                                      									" + CRLF
	_cQuery += "    SUBSTR(MAIL.COMPETENCIA,1,4)||'/'||SUBSTR(MAIL.COMPETENCIA,5,2) COMPETENCIA,								" + CRLF
	_cQuery += "    NVL(MAIL.TITULO,' ') TITULO,                                            									" + CRLF
	_cQuery += "    NVL(MAIL.SALDO,0) SALDO,                                                									" + CRLF
	_cQuery += "    FORMATA_DATA_MS(MAIL.VENCREA) VENC_REAL,                                									" + CRLF
	_cQuery += "    NVL(MAIL.PROCESSO,' ') PROCESSO,                                        									" + CRLF
	_cQuery += "    CASE                                                                   										" + CRLF
	_cQuery += "        WHEN TRIM(BA1.BA1_TELEFO) IS NOT NULL                              										" + CRLF
	_cQuery += "        THEN '('||LPAD(TRIM(BA1.BA1_DDD),3,'0') || ')' ||BA1.BA1_TELEFO    										" + CRLF
	_cQuery += "        ELSE ' '                                                           										" + CRLF
	_cQuery += "    END TELEFONE ,                                                         										" + CRLF
	_cQuery += " 	CASE                                                                    									" + CRLF
	_cQuery += "        WHEN TRIM(BA1.BA1_YCEL) IS NOT NULL                                										" + CRLF
	_cQuery += "        THEN '('||LPAD(TRIM(BA1.BA1_DDD),3,'0') || ')' ||BA1.BA1_YCEL      										" + CRLF
	_cQuery += "        ELSE ' '                                                           										" + CRLF
	_cQuery += "    END CELULAR ,                                                          										" + CRLF
	_cQuery += "    CASE                                                                   										" + CRLF
	_cQuery += "        WHEN TRIM(BA1.BA1_YTEL2) IS NOT NULL                               										" + CRLF
	_cQuery += "        THEN '('||LPAD(TRIM(BA1.BA1_DDD),3,'0') || ')' ||BA1.BA1_YTEL2    										" + CRLF
	_cQuery += "        ELSE ' '                                                           										" + CRLF
	_cQuery += "    END TELEFONE2                                                           									" + CRLF
	_cQuery += " FROM                                                                       									" + CRLF
	_cQuery += "    SIGA.LOG_ENVIO_BOLETO_EMAIL MAIL                                       										" + CRLF
	_cQuery += "                                                                           										" + CRLF
	_cQuery += "    INNER JOIN                                                             										" + CRLF
	_cQuery += " 		" + RETSQLNAME("BA1") + " BA1 																			" + CRLF
	_cQuery += "    ON                                                                     										" + CRLF
	_cQuery += "        BA1.BA1_FILIAL 	= '" + xFilial("BA1") + "'                   											" + CRLF
	_cQuery += "        AND BA1.BA1_CODINT = SUBSTR(MAIL.MATRICULA,01,4)               											" + CRLF
	_cQuery += "        AND BA1.BA1_CODEMP = SUBSTR(MAIL.MATRICULA,05,4)                   										" + CRLF
	_cQuery += "        AND BA1.BA1_MATRIC = SUBSTR(MAIL.MATRICULA,09,6)                   										" + CRLF
	_cQuery += "        AND BA1.BA1_TIPREG = SUBSTR(MAIL.MATRICULA,15,2)                   										" + CRLF
	_cQuery += "        AND BA1.BA1_DIGITO = SUBSTR(MAIL.MATRICULA,17,1)                   										" + CRLF
	_cQuery += "        AND BA1.D_E_L_E_T_ = ' '                                           										" + CRLF
	_cQuery += "                                                                           										" + CRLF
	_cQuery += " WHERE                                                                      									" + CRLF
	_cQuery += "    MAIL.PROCESSO <> 'EXTRATO'                                                    								" + CRLF
	
	If !Empty(MV_PAR01) .AND. !Empty(MV_PAR02) .AND. !Empty(MV_PAR03) .AND. !Empty(MV_PAR04)
		_cQuery += "    AND MAIL.COMPETENCIA BETWEEN '" + MV_PAR01 + MV_PAR03 + "' AND '" + MV_PAR02 + MV_PAR04 + "'            " + CRLF
	EndIf

	If !Empty(MV_PAR05)
		_cQuery += "    AND MAIL.MATRICULA = '" + MV_PAR05 + "'                													" + CRLF
	EndIf
	
Return _cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} function
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
/*
Static Function GeraLogEmail()

	Local aArea        	:= GetArea()
	Local oFWMsExcel
	Local oExcel
	Local cAliasLog	  	:= GetNextAlias()
	Local cArquivo    	:= GetTempPath()+cvaltochar(randomize(1,100000))+'_CABR259.xml'
	Local cEmpresa    	:= iIf( cEmpAnt=='01', 'C', 'I')	
	Local c_Competencia := mv_par01+mv_par02
	Local nRegs			:= 0

	//Pegando os dados
	//23/7/21 extrato para não misturar com boleto
	BeginSql Alias cAliasLog
		SELECT *
		FROM
			SIGA.LOG_ENVIO_BOLETO_EMAIL
		WHERE
			EMPRESA = %exp:cEmpresa% //AND DATA >= %exp:c_Data%
			AND PROCESSO <> 'EXTRATO'
			AND COMPETENCIA = %exp:c_Competencia%
	EndSql

	if (cAliasLog)->(!eof())

		(cAliasLog)->(dbGoTop())
		(cAliasLog)->(dbEval({||nRegs++}))
		(cAliasLog)->(dbGoTop())
		//Criando o objeto que irá gerar o conteúdo do Excel
		oFWMsExcel := FWMSExcel():New()

		//Aba 01 - Log_Boletos
		oFWMsExcel:AddworkSheet("LOG")
		//Criando a Tabela
		oFWMsExcel:AddTable("LOG","Log_Boletos")
		oFWMsExcel:AddColumn("LOG","Log_Boletos","Matricula",1)
		oFWMsExcel:AddColumn("LOG","Log_Boletos","Data",1)
		oFWMsExcel:AddColumn("LOG","Log_Boletos","Hora",1)
		oFWMsExcel:AddColumn("LOG","Log_Boletos","E-mail",1)
		oFWMsExcel:AddColumn("LOG","Log_Boletos","Enviado",1)
		oFWMsExcel:AddColumn("LOG","Log_Boletos","Motivo",1)
		oFWMsExcel:AddColumn("LOG","Log_Boletos","Competencia",1)
		oFWMsExcel:AddColumn("LOG","Log_Boletos","Titulo",1)
		oFWMsExcel:AddColumn("LOG","Log_Boletos","Saldo",3)
		oFWMsExcel:AddColumn("LOG","Log_Boletos","Vencimento",1)

		ProcRegua(nRegs) // Atribui quantidade de registros que serão impressos

		//Criando as Linhas... Enquanto não for fim da query
		While !((cAliasLog)->(EoF()))
			IncProc()

			oFWMsExcel:AddRow("LOG","Log_Boletos",{;
				(cAliasLog)->MATRICULA,;
				STOD((cAliasLog)->DATA),;
				(cAliasLog)->HORA,;
				(cAliasLog)->EMAIL,;
				(cAliasLog)->ENVIADO,;
				(cAliasLog)->MOTIVO,;
				(cAliasLog)->COMPETENCIA,;
				(cAliasLog)->TITULO,;
				(cAliasLog)->SALDO,;
				(cAliasLog)->VENCREA;
				})

			(cAliasLog)->(DbSkip())

		EndDo

		//Ativando o arquivo e gerando o xml
		oFWMsExcel:Activate()
		oFWMsExcel:GetXMLFile(cArquivo)

		//Abrindo o excel e abrindo o arquivo xml
		oExcel := MsExcel():New()           //Abre uma nova conexão com Excel
		oExcel:WorkBooks:Open(cArquivo)     //Abre uma planilha
		oExcel:SetVisible(.T.)              //Visualiza a planilha
		oExcel:Destroy()                    //Encerra o processo do gerenciador de tarefas

	Else

		Aviso("Não há dados!!!","Não há Log a ser impresso com os parâmetros informados!",{"OK"})

	EndIf

	if select(cAliasLog) > 0
		(cAliasLog)->(DbCloseArea())
	endif

	RestArea(aArea)

Return
*/
