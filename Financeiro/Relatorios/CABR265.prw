#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR265  �Autor  �Angelo Henrique     � Data �  12/03/2019  ���
�������������������������������������������������������������������������͹��
���Desc.     �Relat�rio utilizado para mostrar os boletos que n�o foram   ���
���          �enviados por e-mail.                                        ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABR265(_cParam1, _cParam2)
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg	:= "CABR265"
	
	Default _cParam1 := ""
	Default _cParam2 := ""
	
	If Empty(_cParam1) .And. Empty(_cParam2)
		
		//Cria grupo de perguntas
		CABR265A(_cPerg)
		
		If Pergunte(_cPerg,.T.)
			
			//----------------------------------------------------
			//Validando se existe o Excel instalado na m�quina
			//para n�o dar erro e o usu�rio poder visualizar em
			//outros programas como o LibreOffice
			//----------------------------------------------------
			If ApOleClient("MSExcel")
				
				oReport := CABR265B()
				oReport:PrintDialog()
				
			Else
				
				Processa({||CABR265E()},'Processando...')
				
			EndIf
			
		EndIf
		
	Else
		
		MV_PAR01 := _cParam1
		MV_PAR02 := _cParam2
		
		//----------------------------------------------------
		//Validando se existe o Excel instalado na m�quina
		//para n�o dar erro e o usu�rio poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
			oReport := CABR265B()
			oReport:PrintDialog()
			
		Else
			
			Processa({||CABR265E()},'Processando...')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR265A  �Autor  �Angelo Henrique     � Data �  22/05/18   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel pela gera��o das perguntas no relat�rio  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABR265A(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Ano Base	")
	
	PutSx1(cGrpPerg,"01","Ano Base "	,"a","a","MV_CH1"	,"C",TamSX3("E1_ANOBASE")[1]	,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o M�s Base	")
	
	PutSx1(cGrpPerg,"02","M�s Base "	,"a","a","MV_CH2"	,"C",TamSX3("E1_MESBASE")[1]	,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR265B  �Autor  �Angelo Henrique     � Data �  08/05/18   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� gerar as informa��es do relat�rio            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABR265B
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR265","BOLETOS N�O ENVIADOS",_cPerg,{|oReport| CABR265C(oReport)},"BOLETOS N�O ENVIADOS")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(9)
	
	//--------------------------------
	//Primeira linha do relat�rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"BOLETOS N�O ENVIADOS","BA1")
	
	TRCell():New(oSection1,"MATRICULA" 		,"BA1")
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(20)
	
	TRCell():New(oSection1,"NOME" 			,"BA1")
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(TAMSX3("BA1_NOMUSR")[1])
	
	TRCell():New(oSection1,"EMAIL" 			,"BA1")
	oSection1:Cell("EMAIL"):SetAutoSize(.F.)
	oSection1:Cell("EMAIL"):SetSize(TAMSX3("BA1_EMAIL")[1])
	
	TRCell():New(oSection1,"TITULO" 		,"SE1")
	oSection1:Cell("TITULO"):SetAutoSize(.F.)
	oSection1:Cell("TITULO"):SetSize(TAMSX3("E1_NUM")[1])
	
	TRCell():New(oSection1,"SALDO" 			,"SE1")
	oSection1:Cell("SALDO"):SetAutoSize(.F.)
	oSection1:Cell("SALDO"):SetSize(TAMSX3("E1_SALDO")[1])
	
	TRCell():New(oSection1,"VENCIMENTO" 	,"SE1")
	oSection1:Cell("VENCIMENTO"):SetAutoSize(.F.)
	oSection1:Cell("VENCIMENTO"):SetSize(15)
	
	TRCell():New(oSection1,"TELEFONE" 		,"BA1")
	oSection1:Cell("TELEFONE"):SetAutoSize(.F.)
	oSection1:Cell("TELEFONE"):SetSize(20)
	
	TRCell():New(oSection1,"CELULAR" 		,"BA1")
	oSection1:Cell("CELULAR"):SetAutoSize(.F.)
	oSection1:Cell("CELULAR"):SetSize(20)
	
	TRCell():New(oSection1,"TELEFONE2" 		,"BA1")
	oSection1:Cell("TELEFONE2"):SetAutoSize(.F.)
	oSection1:Cell("TELEFONE2"):SetSize(20)
	
Return oReport


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR244B  �Autor  �Angelo Henrique     � Data �  13/10/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina para montar a query e trazer as informa��es no       ���
���          �relat�rio.                                                  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABR265C(oReport)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	
	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()
	
	//---------------------------------------------
	//CABR265D Realiza toda a montagem da query
	//facilitando a manuten��o do fonte
	//---------------------------------------------
	_cQuery := CABR265D()
	
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
		
		oSection1:Cell("MATRICULA"  ):SetValue((_cAlias1)->MATRICULA	)
		oSection1:Cell("NOME" 		):SetValue((_cAlias1)->NOME			)
		oSection1:Cell("EMAIL" 		):SetValue((_cAlias1)->EMAIL		)
		oSection1:Cell("TITULO" 	):SetValue((_cAlias1)->TITULO		)
		oSection1:Cell("SALDO" 		):SetValue((_cAlias1)->SALDO		)
		oSection1:Cell("VENCIMENTO" ):SetValue((_cAlias1)->VENCIMENTO	)
		oSection1:Cell("TELEFONE" 	):SetValue((_cAlias1)->TELEFONE		)
		oSection1:Cell("CELULAR" 	):SetValue((_cAlias1)->CELULAR		)
		oSection1:Cell("TELEFONE2"  ):SetValue((_cAlias1)->TELEFONE2	)
		
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
���Programa  �CABR265D  �Autor  �Angelo Henrique     � Data �  24/10/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel por tratar a query, facilitando assim    ���
���          �a manuten��o do fonte.                                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABR265D()
	
	Local _cQuery 	:= ""
	
	_cQuery += " SELECT                                                                         	" + CRLF
	_cQuery += "     DISTINCT                                                                   	" + CRLF
	_cQuery += "     BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRICULA ,     	" + CRLF
	_cQuery += "     TRIM(BA1_NOMUSR) NOME,                                                     	" + CRLF
	_cQuery += "     TRIM(BA1_EMAIL) EMAIL,                                                     	" + CRLF
	_cQuery += "     E1_NUM TITULO,                                                             	" + CRLF
	_cQuery += "     E1_SALDO SALDO,                                                            	" + CRLF
	_cQuery += "     SIGA.FORMATA_DATA_MS(E1_VENCTO) VENCIMENTO,                                	" + CRLF
	_cQuery += "     '('||BA1_DDD || ')' ||BA1_TELEFO TELEFONE ,                                	" + CRLF
	_cQuery += "     BA1.BA1_YCEL CELULAR ,                                                     	" + CRLF
	_cQuery += "     BA1.BA1_YTEL2 TELEFONE2                                                    	" + CRLF
	_cQuery += " FROM                                                                           	" + CRLF
	_cQuery += "     (                                                                          	" + CRLF
	_cQuery += "         SELECT                                                                 	" + CRLF
	_cQuery += "             BA3_MATRIC ,                                                       	" + CRLF
	_cQuery += "             BA3_CODINT ,                                                       	" + CRLF
	_cQuery += "             BA3_CODEMP,                                                        	" + CRLF
	_cQuery += "             E1_SALDO,                                                          	" + CRLF
	_cQuery += "             SE1.E1_VENCTO,                                                     	" + CRLF
	_cQuery += "             E1_NUM                                                             	" + CRLF
	_cQuery += "         FROM                                                                   	" + CRLF
	_cQuery += " 			" + RetSqlName("BA3") + " BA3,     										" + CRLF
	_cQuery += " 			" + RetSqlName("SE1") + " SE1      										" + CRLF
	_cQuery += "         WHERE                                                                  	" + CRLF
	_cQuery += "             BA3_TIPPAG = '04'                                                  	" + CRLF
	_cQuery += "             AND BA3_DATBLO = ' '                                               	" + CRLF
	_cQuery += "             AND BA3_CODEMP IN ('0001','0002','0005')                           	" + CRLF
	_cQuery += "             AND BA3.D_E_L_E_T_ = ' '                                           	" + CRLF
	_cQuery += "             AND SE1.E1_CODEMP = BA3_CODEMP                                     	" + CRLF
	_cQuery += "             AND SE1.E1_MATRIC = BA3_MATRIC                                     	" + CRLF
	_cQuery += "             AND SE1.E1_CODINT = BA3_CODINT                                     	" + CRLF
	_cQuery += "             AND SE1.E1_ANOBASE = '" + MV_PAR01 + "'                            	" + CRLF
	_cQuery += "             AND SE1.E1_MESBASE = '" + MV_PAR02 + "'                            	" + CRLF
	_cQuery += "             AND SE1.D_E_L_E_T_ = ' '                                           	" + CRLF
	_cQuery += "             AND SE1.E1_SALDO > 0                                               	" + CRLF
	_cQuery += "             AND SE1.E1_PREFIXO IN ('PLS','FAT')                                	" + CRLF
	_cQuery += "             AND NOT EXISTS                                                     	" + CRLF
	_cQuery += "                             (                                                  	" + CRLF
	_cQuery += "                                 SELECT                                         	" + CRLF
	_cQuery += "                                     MATRICULA                                  	" + CRLF
	_cQuery += "                                 FROM                                           	" + CRLF
	_cQuery += "                                     SIGA.LOG_ENVIO_BOLETO_EMAIL                	" + CRLF
	_cQuery += "                                 WHERE                                          	" + CRLF
	_cQuery += "                                     COMPETENCIA IN ('" + MV_PAR01 + MV_PAR02 + "')	" + CRLF
	_cQuery += "                                     AND SUBSTR(MATRICULA,1,4) = BA3.BA3_CODINT 	" + CRLF
	_cQuery += "                                     AND SUBSTR(MATRICULA,5,4) = BA3.BA3_CODEMP 	" + CRLF
	_cQuery += "                                     AND SUBSTR(MATRICULA,9,6) = BA3.BA3_MATRIC 	" + CRLF
	_cQuery += "                             ) 														" + CRLF
	_cQuery += "     ),                                                                         	" + CRLF
	_cQuery += " 	" + RetSqlName("BA1") + " BA1           										" + CRLF
	_cQuery += " WHERE                                                                          	" + CRLF
	_cQuery += "     BA1_MATRIC = BA3_MATRIC                                                    	" + CRLF
	_cQuery += "     AND BA1_CODINT = BA3_CODINT                                                	" + CRLF
	_cQuery += "     AND BA1_CODEMP = BA3_CODEMP                                                	" + CRLF
	_cQuery += "     AND BA1.D_E_L_E_T_ = ' '                                                   	" + CRLF
	_cQuery += "     AND BA1_TIPUSU = 'T'                                                       	" + CRLF
	
	
Return _cQuery


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR265E  �Autor  �Angelo Henrique     � Data �  08/05/18   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel por gerar o relat�rio em CSV, pois       ���
���          �alguns usu�rios n�o possuem o Excel.                        ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABR265E()
	
	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""
	
	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\BOLETO_NAO_ENVIADO"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manuten��o do fonte
	//---------------------------------------------
	_cQuery := CABR265D()
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)
	
	While !(_cAlias2)->(EOF())
		
		IncProc()
		
		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabe�alho
		//------------------------------------------------------------------
		If nHandle = 0
			
			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)
			
			If nHandle > 0
				
				cMontaTxt := "MATRICULA		;"
				cMontaTxt += "NOME			;"
				cMontaTxt += "EMAIL			;"
				cMontaTxt += "TITULO		;"
				cMontaTxt += "SALDO			;"
				cMontaTxt += "VENCIMENTO	;"
				cMontaTxt += "TELEFONE		;"
				cMontaTxt += "CELULAR		;"
				cMontaTxt += "TELEFONE2		;"
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Aten��o","N�o foi poss�vel criar o relat�rio",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := "'" + (_cAlias1)->MATRICULA	+ ";"
		cMontaTxt += "'" + (_cAlias1)->NOME			+ ";"
		cMontaTxt += "'" + (_cAlias1)->EMAIL		+ ";"
		cMontaTxt += "'" + (_cAlias1)->TITULO		+ ";"
		cMontaTxt += "'" + (_cAlias1)->SALDO		+ ";"
		cMontaTxt += "'" + (_cAlias1)->VENCIMENTO	+ ";"
		cMontaTxt += "'" + (_cAlias1)->TELEFONE	    + ";"
		cMontaTxt += "'" + (_cAlias1)->CELULAR		+ ";"
		cMontaTxt += "'" + (_cAlias1)->TELEFONE2	+ ";"
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	If nHandle > 0
		
		// encerra grava��o no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf
	
	RestArea(_aArea)
	
Return
