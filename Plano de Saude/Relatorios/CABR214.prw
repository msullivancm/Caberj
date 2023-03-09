#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR214     �Autor  �Angelo Henrique   � Data �  10/05/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �Relat�rio de Protocolo de Atendimento - Hist�rico Padr�o x  ���
���          �Tipo de Servi�os                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABR214()
	
	Local _aArea 		:= GetArea()
	Local oReport		:= Nil
	Private _cPerg	:= "CABR214"
	
	//Cria grupo de perguntas
	CABR214C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		oReport := CABR214A()
		oReport:PrintDialog()
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR214A  �Autor  �Angelo Henrique     � Data �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� gerar as informa��es do relat�rio            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABR214A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR214","PA - Hist�rico Padr�o x Tipo de Servi�o",_cPerg,{|oReport| CABR214B(oReport)},"PA - Hist�rico Padr�o x Tipo de Servi�o")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(9)
	
	//--------------------------------
	//Primeira linha do relat�rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"PA","PCE, PCD, PBL")
	
	TRCell():New(oSection1,"CD_SERV"	,"PCE") //01 -- CODIGO DO TIPO DE SERVI�O
	oSection1:Cell("CD_SERV"):SetAutoSize(.F.)
	oSection1:Cell("CD_SERV"):SetSize(10)
	
	TRCell():New(oSection1,"SERVICO"	,"PCE") //02 -- DESCRI��O DO TIPO DE SERVI�O
	oSection1:Cell("SERVICO"):SetAutoSize(.F.)
	oSection1:Cell("SERVICO"):SetSize(60)
	
	TRCell():New(oSection1,"CD_HIST"	,"PCE") //03 -- CODIGO DO HISTORICO
	oSection1:Cell("CD_HIST"):SetAutoSize(.F.)
	oSection1:Cell("CD_HIST"):SetSize(10)
	
	TRCell():New(oSection1,"HISTORICO"	,"PCE") //04 -- DESCRI��O DO HISTORICO
	oSection1:Cell("HISTORICO"):SetAutoSize(.F.)
	oSection1:Cell("HISTORICO"):SetSize(60)

	TRCell():New(oSection1,"ASSISTENCIAL"	,"PBL") 
	oSection1:Cell("ASSISTENCIAL"):SetAutoSize(.F.)
	oSection1:Cell("ASSISTENCIAL"):SetSize(10)

	TRCell():New(oSection1,"DEPARTAMENTO"	,"PBL") 
	oSection1:Cell("DEPARTAMENTO"):SetAutoSize(.F.)
	oSection1:Cell("DEPARTAMENTO"):SetSize(10)
	
Return oReport

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR214B  �Autor  �Angelo Henrique     � Data �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina para montar a query e trazer as informa��es no       ���
���          �relat�rio.                                                  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABR214B(oReport,_cAlias1)
	
	Local _aArea 			:= GetArea()
	
	Private oSection1 	:= oReport:Section(1)
	Private _cQuery		:= ""
	Private _cAlias1		:= GetNextAlias()
	Private _cEmpAnt		:= cEmpAnt
	
	_cQuery := " SELECT  " + CRLF
	_cQuery += " TRIM(PCE.PCE_TIPOSV) CD_SERV, TRIM(PBL.PBL_YDSSRV) SERVICO, 	" + CRLF
	_cQuery += " TRIM(PCE.PCE_CDHIST) CD_HIST, TRIM(PCD.PCD_DESCRI) HISTORICO,	" + CRLF
	_cQuery += " DECODE(PBL_ASSIST, '1', 'SIM', '2','NAO') ASSISTENCIAL,		" + CRLF
	_cQuery += " PBL_YDEPTO DEPARTAMENTO										" + CRLF
	_cQuery += " FROM " + CRLF
	_cQuery += RetSqlName("PCE") + " PCE, 	" + CRLF
	_cQuery += RetSqlName("PBL") + " PBL, 	" + CRLF
	_cQuery += RetSqlName("PCD") + " PCD  	" + CRLF
	_cQuery += " WHERE " + CRLF
	_cQuery += " 	PCE.D_E_L_E_T_ = ' ' 	" + CRLF
	_cQuery += " 	AND PBL.D_E_L_E_T_ = ' '	" + CRLF
	_cQuery += " 	AND PCD.D_E_L_E_T_ = ' '	" + CRLF
	_cQuery += " 	AND TRIM(PCE.PCE_TIPOSV) = PBL.PBL_YCDSRV " + CRLF
	_cQuery += " 	AND TRIM(PCE.PCE_CDHIST) = PCD.PCD_COD 	" + CRLF
	
	If !Empty(MV_PAR01) .And. !Empty(MV_PAR02)
		
		_cQuery += " 	AND PCE.PCE_TIPOSV BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'	" + CRLF
		
	EndIf
	
	If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
		
		_cQuery += " 	AND PCE.PCE_CDHIST BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'	" + CRLF
		
	EndIf
	
	_cQuery += " ORDER BY PCE.PCE_TIPOSV, PCD.PCD_COD 		" + CRLF
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias1)
	
	oSection1:Init()
	oSection1:SetHeaderSection(.T.)
	
	While !(_cAlias1)->(eof())
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
		
		oSection1:Cell("CD_SERV"		):SetValue( (_cAlias1)->CD_SERV		)//01 -- CODIGO DE SERVI�O
		oSection1:Cell("SERVICO"		):SetValue( (_cAlias1)->SERVICO		)//02 -- DESCRICAO DO SERVI�O
		oSection1:Cell("CD_HIST" 		):SetValue( (_cAlias1)->CD_HIST		)//03 -- CODIGO DE HISTORICO
		oSection1:Cell("HISTORICO"		):SetValue( (_cAlias1)->HISTORICO	)//04 -- DESCRICAO DO HISTORICO
		oSection1:Cell("ASSISTENCIAL"	):SetValue( (_cAlias1)->ASSISTENCIAL)//05 -- 1- SIM / 2 - NAO
		oSection1:Cell("DEPARTAMENTO"	):SetValue( (_cAlias1)->DEPARTAMENTO)//06 -- DESCRICAO DO DEPARTAMENTO
		
		oSection1:PrintLine()
		
		(_cAlias1)->(DbSkip())
		
	EndDo
	
	oSection1:Finish()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return(.T.)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR214C  �Autor  �Angelo Henrique     � Data �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel pela gera��o das perguntas no relat�rio  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABR214C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o tipo de  			")
	AADD(aHelpPor,"Servi�o De/Ate				")
	AADD(aHelpPor,"Branco para todos			")
	
	PutSx1(cGrpPerg,"01","Servi�o De: ?"	,"a","a","MV_CH1"	,"C",TamSX3("PCE_TIPOSV")[1]	,0,0,"G","","PBLPA1","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Servi�o Ate: ?"	,"a","a","MV_CH2"	,"C",TamSX3("PCE_TIPOSV")[1]	,0,0,"G","","PBLPA1","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Historico 		")
	AADD(aHelpPor,"Padr�o						")
	AADD(aHelpPor,"Branco para todos	    	")
	
	PutSx1(cGrpPerg,"03","Historico De:"	,"a","a","MV_CH3"	,"C",TamSX3("PCE_CDHIST")[1]	,0,0,"G","","PCDPA1","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Historico At�:"	,"a","a","MV_CH4"	,"C",TamSX3("PCE_CDHIST")[1]	,0,0,"G","","PCDPA1","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return

