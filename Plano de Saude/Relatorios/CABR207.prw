#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR207     ºAutor  ³Angelo Henrique   º Data ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório de Auditoria por guia                             º±±
±±º          ³Query elaborada por Roberto Santos.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR207()
	
	Local _aArea 		:= GetArea()
	Local oReport		:= Nil
	
	Private _cPerg	:= "CABR207"
	
	//Cria grupo de perguntas
	CABR207C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
				
		//----------------------------------------------------
		//Validando se existe o Excel instalado na máquina
		//para não dar erro e o usuário poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
			oReport := CABR207A()
			oReport:PrintDialog()
			
		Else
			
			Processa({||CABR207D()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR207A  ºAutor  ³Angelo Henrique     º Data ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que irá gerar as informações do relatório            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR207A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR207","Auditoria por Guia",_cPerg,{|oReport| CABR207B(oReport)},"Auditoria por Guia")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(12)
	
	//--------------------------------
	//Primeira linha do relatório
	//--------------------------------
	oSection1 := TRSection():New(oReport,"Auditoria","B53, BAU, BEA")
	
	TRCell():New(oSection1,"B53_NOMUSR" 	,"B53") //01
	oSection1:Cell("B53_NOMUSR"):SetAutoSize(.T.)

	TRCell():New(oSection1,"B53_MATUSU" 	,"B53") //02
	oSection1:Cell("B53_MATUSU"):SetAutoSize(.T.)

	TRCell():New(oSection1,"B53_CODRDA" 	,"B53") //03
	oSection1:Cell("B53_CODRDA"):SetAutoSize(.T.)

	TRCell():New(oSection1,"BAU_NOME" 		,"BAU") //04
	oSection1:Cell("BAU_NOME"):SetAutoSize(.T.)

	TRCell():New(oSection1,"B53_STATUS" 	,"B53") //05
	oSection1:Cell("B53_STATUS"):SetAutoSize(.T.)

	TRCell():New(oSection1,"B53_SITUAC" 	,"B53") //06
	oSection1:Cell("B53_SITUAC"):SetAutoSize(.T.)

	TRCell():New(oSection1,"B53_ORIMOV" 	,"B53") //07
	oSection1:Cell("B53_ORIMOV"):SetAutoSize(.T.)

	TRCell():New(oSection1,"B53_TIPO" 		,"B53") //08
	oSection1:Cell("B53_TIPO"):SetAutoSize(.T.)

	TRCell():New(oSection1,"B53_DATMOV" 	,"B53") //09
	oSection1:Cell("B53_DATMOV"):SetAutoSize(.T.)

	TRCell():New(oSection1,"BEA_SENHA" 	    ,"BEA") //10
	oSection1:Cell("BEA_SENHA"):SetAutoSize(.T.)

	TRCell():New(oSection1,"B53_NUMGUI" 	,"B53") //11
	oSection1:Cell("B53_NUMGUI"):SetAutoSize(.T.)
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR207B  ºAutor  ³Angelo Henrique     º Data ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para montar a query e trazer as informações no       º±±
±±º          ³relatório.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR207B(oReport,_cAlias1)
	
	Local _aArea 			:= GetArea()
	Local _cQuery		:= ""

	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()

	//---------------------------------------------
	//CABR207B1 Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR207B1()
	
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
		
		oSection1:Cell("B53_NOMUSR"	):SetValue( (_cAlias1)->BENEF			)
		oSection1:Cell("B53_MATUSU"	):SetValue( (_cAlias1)->MATRIC			)
		oSection1:Cell("B53_CODRDA"	):SetValue( (_cAlias1)->CODREDE			)
		oSection1:Cell("BAU_NOME"	):SetValue( (_cAlias1)->REDE			)
		oSection1:Cell("B53_STATUS"	):SetValue( (_cAlias1)->STATUS			)
		oSection1:Cell("B53_SITUAC"	):SetValue( (_cAlias1)->ANALIS			)
		oSection1:Cell("B53_ORIMOV"	):SetValue( (_cAlias1)->GUIA			)
		oSection1:Cell("B53_TIPO"	):SetValue( (_cAlias1)->TIPO_GUIA		)
		oSection1:Cell("B53_DATMOV"	):SetValue( STOD((_cAlias1)->DT_MOV)	)
		oSection1:Cell("BEA_SENHA"	):SetValue( (_cAlias1)->SENHA			)
		oSection1:Cell("B53_NUMGUI"	):SetValue( (_cAlias1)->NMGUIA			)
		oSection1:PrintLine()
		(_cAlias1)->(DbSkip())

	EndDo
	
	oSection1:Finish()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return(.T.)


Static Function CABR207B1()

	Local _cQuery 		:= ""
	Local _cSituac		:= ""
	
	// Guias de Internação
	_cQuery := " SELECT B53.B53_NOMUSR BENEF, B53.B53_MATUSU MATRIC,  " + CRLF
	_cQuery += " B53.B53_CODRDA CODREDE, " + CRLF
	_cQuery += " BAU.BAU_NOME REDE, " + CRLF
	_cQuery += " DECODE (B53.B53_STATUS,'1','Autorizada','2' ,'Aut. Parcial','3' ,'Nao Autorizada','4','Finalizacao Atendimento','5' ,'Liq. Titulo a Receber') STATUS, " + CRLF
	_cQuery += " DECODE (B53.B53_SITUAC,'0','Nao','1','Sim','2','Em Analise','3','Em Espera','4','Inconsistencia') ANALIS, " + CRLF
	_cQuery += " DECODE (B53.B53_ORIMOV,'1','Guias de Consultas/Servicos','2','Guia de Internacao','3','Outros') GUIA, " + CRLF
	_cQuery += " DECODE (TRIM(B53_TIPO),'1','Consulta','2','SADT','3','Internacao','4','Odontologico','5','Reembolso','6','Anexo Clinico','7','Outros','11','Prorrogacao de Internacao') TIPO_GUIA, " + CRLF
	_cQuery += " B53.B53_DATMOV DT_MOV, " + CRLF
	_cQuery += " BE4.BE4_SENHA SENHA, " + CRLF
	_cQuery += " B53.B53_NUMGUI NMGUIA " + CRLF
	_cQuery += " FROM  " + RetSqlName("B53") + " B53, " + RetSqlName("BE4") + " BE4, " + RetSqlName("BAU") + " BAU " + CRLF
	_cQuery += " WHERE B53.D_E_L_E_T_=' ' " + CRLF
	_cQuery += " AND B53.B53_FILIAL=' ' " + CRLF
	_cQuery += " AND BE4.D_E_L_E_T_=' ' " + CRLF
	_cQuery += " AND BE4.BE4_FILIAL=' ' " + CRLF
	_cQuery += " AND BAU.D_E_L_E_T_=' ' " + CRLF
	_cQuery += " AND BAU.BAU_FILIAL=' ' " + CRLF
	_cQuery += " AND BAU.BAU_CODIGO=B53_CODRDA "
	_cQuery += " AND BE4_CODOPE=SUBSTR (B53.B53_NUMGUI,1,4)  " + CRLF
	_cQuery += " AND BE4_ANOINT=SUBSTR (B53.B53_NUMGUI,5,4)  " + CRLF
	_cQuery += " AND BE4_MESINT=SUBSTR (B53.B53_NUMGUI,9,2)  " + CRLF
	_cQuery += " AND BE4_NUMINT=SUBSTR (B53.B53_NUMGUI,11,8) " + CRLF
	
	//-------------------------------------------------
	//Data de Movimentação (MV_PAR01 e MV_PAR02)
	//-------------------------------------------------
	If !Empty(MV_PAR01) .AND. !Empty(MV_PAR02)
		
		_cQuery += " AND B53.B53_DATMOV BETWEEN '" + DTOS(MV_PAR01) +  "' AND '" + DTOS(MV_PAR02) + "' " + CRLF
		
	EndIf
	
	//-------------------------------------------------
	//Status (MV_PAR03)
	//-------------------------------------------------
	If !Empty(MV_PAR03)
		
		//---------------------------------------------
		// B53_STATUS :
		//---------------------------------------------
		// 1 = Autorizada
		// 2 = Aut. Parcial
		// 3 = Nao Autorizada
		// 4 = Finalizacao Atendimento
		// 5 = Liq. Titulo a Receber
		//---------------------------------------------
		
		_cQuery += " AND B53.B53_STATUS = '" + cValToChar(MV_PAR03) +  "' " + CRLF
		
	EndIf
	
	//-------------------------------------------------
	//Situação (MV_PAR04)
	//-------------------------------------------------
	If !Empty(MV_PAR04)
		
		//-----------------------------------------------------------
		// B53_SITUAC:
		//-----------------------------------------------------------
		// 0 = Nao
		// 1 = Sim
		// 2 = Em Analise
		// 3 = Em Espera
		// 4 = Inconsistencia
		//-----------------------------------------------------------
		
		If MV_PAR04 = 1
			
			_cSituac := "0"
			
		ElseIf MV_PAR04 = 2
			
			_cSituac := "1"
			
		ElseIf MV_PAR04 = 3
			
			_cSituac := "2"
			
		ElseIf MV_PAR04 = 4
			
			_cSituac := "3"
			
		ElseIf MV_PAR04 = 5
			
			_cSituac := "4"
			
		EndIf
		
		_cQuery += " AND B53.B53_SITUAC = '" + _cSituac +  "' " + CRLF
		
	EndIf
	
	//-------------------------------------------------
	//Tipo Guia (MV_PAR05)
	//-------------------------------------------------
	If !Empty(MV_PAR05)
		
		//-----------------------------------------
		// B53_ORIMOV
		//-----------------------------------------
		// 1 = Guias de Consultas/Servicos
		// 2 = Guia de Internacao
		// 3 = Outros
		// 6 = Novo Autorizador
		//-----------------------------------------
		
		_cQuery += " AND B53.B53_ORIMOV = '" + cValToChar(Iif(MV_PAR05==4,6,MV_PAR05)) +  "' " + CRLF //Motta 11/1/22

		
		
	EndIf
	
	_cQuery += " AND B53.B53_ALIMOV='BE4' " + CRLF

	// Guias de SADT
	_cQuery += " UNION ALL " + CRLF
	_cQuery += " SELECT B53.B53_NOMUSR BENEF, B53.B53_MATUSU MATRIC, " + CRLF
	_cQuery += " B53.B53_CODRDA CODREDE, " + CRLF
	_cQuery += " BAU.BAU_NOME REDE, " + CRLF
	_cQuery += " DECODE (B53.B53_STATUS,'1','Autorizada','2' ,'Aut. Parcial','3' ,'Nao Autorizada','4','Finalizacao Atendimento','5' ,'Liq. Titulo a Receber') STATUS, " + CRLF
	_cQuery += " DECODE (B53.B53_SITUAC,'0','Nao','1','Sim','2','Em Analise','3','Em Espera','4','Inconsistencia') ANALIS, " + CRLF
	_cQuery += " DECODE (B53.B53_ORIMOV,'1','Guias de Consultas/Servicos','2','Guia de Internacao','3','Outros') GUIA, " + CRLF
	_cQuery += " DECODE (TRIM(B53_TIPO),'1','Consulta','2','SADT','3','Internacao','4','Odontologico','5','Reembolso','6','Anexo Clinico','7','Outros','11','Prorrogacao de Internacao') TIPO_GUIA, " + CRLF
	_cQuery += " B53.B53_DATMOV DT_MOV, " + CRLF
	_cQuery += " BEA.BEA_SENHA SENHA, " + CRLF
	_cQuery += " B53.B53_NUMGUI NMGUIA " + CRLF
	_cQuery += " FROM  " + RetSqlName("B53") + " B53, " + RetSqlName("BEA") + " BEA, " + RetSqlName("BAU") + " BAU " + CRLF
	_cQuery += " WHERE B53.D_E_L_E_T_=' ' " + CRLF
	_cQuery += " AND B53.B53_FILIAL=' ' " + CRLF
	_cQuery += " AND BEA.D_E_L_E_T_=' ' " + CRLF
	_cQuery += " AND BEA.BEA_FILIAL=' ' " + CRLF
	_cQuery += " AND BAU.D_E_L_E_T_=' ' " + CRLF
	_cQuery += " AND BAU.BAU_FILIAL=' ' " + CRLF
	_cQuery += " AND BAU.BAU_CODIGO=B53_CODRDA " + CRLF
	_cQuery += " AND BEA.BEA_OPEMOV=SUBSTR (B53_NUMGUI,1,4) " + CRLF
	_cQuery += " AND BEA.BEA_ANOAUT=SUBSTR (B53_NUMGUI,5,4) " + CRLF
	_cQuery += " AND BEA.BEA_MESAUT=SUBSTR (B53_NUMGUI,9,2) " + CRLF
	_cQuery += " AND BEA.BEA_NUMAUT=SUBSTR (B53_NUMGUI,11,8) " + CRLF
	
	//-------------------------------------------------
	//Data de Movimentação (MV_PAR01 e MV_PAR02)
	//-------------------------------------------------
	If !Empty(MV_PAR01) .AND. !Empty(MV_PAR02)
		
		_cQuery += " AND B53.B53_DATMOV BETWEEN '" + DTOS(MV_PAR01) +  "' AND '" + DTOS(MV_PAR02) + "' " + CRLF
		
	EndIf
	
	//-------------------------------------------------
	//Status (MV_PAR03)
	//-------------------------------------------------
	If !Empty(MV_PAR03)
		
		_cQuery += " AND B53.B53_STATUS = '" + cValToChar(MV_PAR03) +  "' " + CRLF
		
	EndIf
	
	//-------------------------------------------------
	//Situação (MV_PAR04)
	//-------------------------------------------------
	If !Empty(MV_PAR04)
		
		_cQuery += " AND B53.B53_SITUAC = '" + _cSituac +  "' " + CRLF
		
	EndIf
	
	//-------------------------------------------------
	//Tipo Guia (MV_PAR05)
	//-------------------------------------------------
	If !Empty(MV_PAR05)
		
		_cQuery += " AND B53.B53_ORIMOV = '" + cValToChar(Iif(MV_PAR05==4,6,MV_PAR05)) +  "' " + CRLF //Motta 11/1/22
		
	EndIf
	
	_cQuery += " AND B53.B53_ALIMOV='BEA' " + CRLF
// Guias de Prorrogação (ANDERSON RANGEL - ID 72897 - MAIO/2021)
	_cQuery += " UNION ALL " + CRLF
	_cQuery += " SELECT B53.B53_NOMUSR BENEF, B53.B53_MATUSU MATRIC, " + CRLF
	_cQuery += " B53.B53_CODRDA CODREDE, " + CRLF
	_cQuery += " BAU.BAU_NOME REDE, " + CRLF
	_cQuery += " DECODE (B53.B53_STATUS,'1','Autorizada','2' ,'Aut. Parcial','3' ,'Nao Autorizada','4','Finalizacao Atendimento','5' ,'Liq. Titulo a Receber') STATUS, " + CRLF
	_cQuery += " DECODE (B53.B53_SITUAC,'0','Nao','1','Sim','2','Em Analise','3','Em Espera','4','Inconsistencia') ANALIS, " + CRLF
	_cQuery += " DECODE (B53.B53_ORIMOV,'1','Guias de Consultas/Servicos','2','Guia de Internacao','3','Outros') GUIA, " + CRLF
	_cQuery += " DECODE (TRIM(B53_TIPO),'1','Consulta','2','SADT','3','Internacao','4','Odontologico','5','Reembolso','6','Anexo Clinico','7','Outros','11','Prorrogacao de Internacao') TIPO_GUIA, " + CRLF
	_cQuery += " B53.B53_DATMOV DT_MOV, " + CRLF
	_cQuery += " B4Q.B4Q_SENHA SENHA, " + CRLF
	_cQuery += " B53.B53_NUMGUI NMGUIA " + CRLF
	_cQuery += " FROM  " + RetSqlName("B53") + " B53, " + RetSqlName("B4Q") + " B4Q, " + RetSqlName("BAU") + " BAU " + CRLF
	_cQuery += " WHERE B53.D_E_L_E_T_=' ' " + CRLF
	_cQuery += " AND B53.B53_FILIAL=' ' " + CRLF
	_cQuery += " AND B4Q.D_E_L_E_T_=' ' " + CRLF
	_cQuery += " AND B4Q.B4Q_FILIAL=' ' " + CRLF
	_cQuery += " AND BAU.D_E_L_E_T_=' ' " + CRLF
	_cQuery += " AND BAU.BAU_FILIAL=' ' " + CRLF
	_cQuery += " AND BAU.BAU_CODIGO=B53_CODRDA " + CRLF
	_cQuery += " AND BAU.BAU_CODIGO=B4Q_CODRDA " + CRLF
	_cQuery += " AND B4Q.B4Q_OPEMOV=SUBSTR (B53_NUMGUI,1,4) " + CRLF
	_cQuery += " AND B4Q.B4Q_ANOAUT=SUBSTR (B53_NUMGUI,5,4) " + CRLF
	_cQuery += " AND B4Q.B4Q_MESAUT=SUBSTR (B53_NUMGUI,9,2) " + CRLF
	_cQuery += " AND B4Q.B4Q_NUMAUT=SUBSTR (B53_NUMGUI,11,8) " + CRLF
	
	//-------------------------------------------------
	//Data de Movimentação (MV_PAR01 e MV_PAR02)
	//-------------------------------------------------
	If !Empty(MV_PAR01) .AND. !Empty(MV_PAR02)
		
		_cQuery += " AND B53.B53_DATMOV BETWEEN '" + DTOS(MV_PAR01) +  "' AND '" + DTOS(MV_PAR02) + "' " + CRLF
		
	EndIf
	
	//-------------------------------------------------
	//Status (MV_PAR03)
	//-------------------------------------------------
	If !Empty(MV_PAR03)
		
		_cQuery += " AND B53.B53_STATUS = '" + cValToChar(MV_PAR03) +  "' " + CRLF
		
	EndIf
	
	//-------------------------------------------------
	//Situação (MV_PAR04)
	//-------------------------------------------------
	If !Empty(MV_PAR04)
		
		_cQuery += " AND B53.B53_SITUAC = '" + _cSituac +  "' " + CRLF
		
	EndIf
	
	//-------------------------------------------------
	//Tipo Guia (MV_PAR05)
	//-------------------------------------------------
	If !Empty(MV_PAR05)
		
		_cQuery += " AND B53.B53_ORIMOV = '" + cValToChar(Iif(MV_PAR05==4,6,MV_PAR05)) +  "' " + CRLF //Motta 11/1/22
		
	EndIf
	
	_cQuery += " AND B53.B53_ALIMOV='B4Q' " + CRLF	

	memowrite("C:\temp\cabr207.sql",_cQuery)

Return _cQuery


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR207C  ºAutor  ³Angelo Henrique     º Data ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela geração das perguntas no relatório  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR207C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a a Data de 			")
	AADD(aHelpPor,"Movimentação						")
	
	PutSx1(cGrpPerg,"01","Data Moviment. De ?","a","a","MV_CH1"	,"D",TamSX3("B53_DATMOV")[1]	,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Data Moviment. De ?","a","a","MV_CH2"	,"D",TamSX3("B53_DATMOV")[1]	,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o STATUS		 			")
	AADD(aHelpPor,"           						")
	
	PutSx1(cGrpPerg,"03","STATUS ?"				,"a","a","MV_CH3"	,"C",TamSX3("B53_STATUS")[1]	,0,0,"C","","","","","MV_PAR03","1-Autorizada","","","","2-Aut. Parcial","","","3-Nao Autorizada","","","4-Finalizacao Atendimento","","","5-Liq. Titulo a Receber","","",aHelpPor,{},{},"")
	
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique a situacao da analise	")
	AADD(aHelpPor,"Analisada SIM, NAO, EM ANALISE	")
	
	PutSx1(cGrpPerg,"04","Situacao ?"			,"a","a","MV_CH4"	,"C",TamSX3("B53_SITUAC")[1]	,0,0,"C","","","","","MV_PAR04","0-Nao","","","","1-Sim","","","2-Em Analise","","","3-Em Espera","","","4-Inconsistencia","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o Tipo de Guia			")
	AADD(aHelpPor,"                              	")
	
	PutSx1(cGrpPerg,"05","Tipo Guia ?"			,"a","a","MV_CH5"	,"C",TamSX3("B53_ORIMOV")[1]	,0,0,"C","","","","","MV_PAR05","1-Guia Consulta/Servicos","","","","2-Guia Internacao","","","3-Outros","","","6-Novo Autorizador","","","","","",aHelpPor,{},{},"")
	
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  CABR207D  ºAutor  ³Anderson Rangel     º Data ³  06/05/21    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por gerar o relatório em CSV, pois       º±±
±±º          ³alguns usuários não possuem o Excel.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR207D()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\RELATORIO_GUIA_INTERNACAO"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR207D Realiza toda a montagem da query
	//facilitando a manutenção do fonte
	//---------------------------------------------
	_cQuery := CABR207B1()
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)
	
	While !(_cAlias2)->(EOF())
		
		IncProc()
		
		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabeçalho
		//------------------------------------------------------------------
		If nHandle = 0
			
			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)
			
			If nHandle > 0
				
				cMontaTxt := "NOME_USUARIO;"
				cMontaTxt += "MATRIC_BENEF;"
				cMontaTxt += "CODIGO_RDA;"
				cMontaTxt += "NOME_RDA;"
				cMontaTxt += "GUIA;"
				cMontaTxt += "ANALISADA;"
				cMontaTxt += "ORIGEM_MOVTO;"
				cMontaTxt += "ATENDIMENTO;"			
				cMontaTxt += "DT_MOVIMENT;"
				cMontaTxt += "SENHA;"
				cMontaTxt += "NUM_DA_GUIA;"			
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Atenção","Não foi possível criar o relatório",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := AllTrim((_cAlias2)->BENEF) 		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->MATRIC) 		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->CODREDE) 		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->REDE) 			+ ";"
		cMontaTxt += AllTrim((_cAlias2)->STATUS) 		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->ANALIS)		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->GUIA) 			+ ";"
		cMontaTxt += AllTrim((_cAlias2)->TIPO_GUIA) 	+ ";"
		cMontaTxt += AllTrim(STOD((_cAlias2)->DT_MOV))	+ ";"
		cMontaTxt += AllTrim((_cAlias2)->SENHA) 		+ ";"
		cMontaTxt += AllTrim((_cAlias2)->NMGUIA)		+ ";"
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf
	
	RestArea(_aArea)
	
Return
