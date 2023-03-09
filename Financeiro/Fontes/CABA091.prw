#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#Include "TOPCONN.CH"
#Include "TBICONN.CH"
#INCLUDE "ap5mail.ch"
#Include "TbiCode.ch"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA091  �Autor  �Angelo Henrique     � Data �  13/03/2019  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina facilitadora do processo de Envio de boletos por     ���
���          �email.                                                      ���
���          �Rotinas envolvidas:                                         ���
���          �CABA615 - Envio de Boletos por E-mail                       ���
���          �CABR259 - Log dos Boletos Enviados                          ���
���          �CABR265 - Relat�rio dos Boletos N�o Enviados.               ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA091()

	Local oFont1 	:= Nil
	Local oFont2	:= Nil
	Local oDlg1 	:= Nil
	Local oGrp1 	:= Nil
	Local oGrp2 	:= Nil
	Local oGrp3 	:= Nil
	Local oGrp4 	:= Nil
	Local oBtn1 	:= Nil
	Local oBtn2 	:= Nil
	Local oBtn3 	:= Nil
	Local oBtn4 	:= Nil
	Local oBtn5 	:= Nil
	Local oBtn6 	:= Nil
	Local oBtn7 	:= Nil
	Local oBtn8 	:= Nil
	Local oBtn9 	:= Nil
	Local oBtn10 	:= Nil
	Local oBtn11 	:= Nil


	/*������������������������������������������������������������������������ٱ�
�� Definicao do Dialog e todos os seus componentes.                        ��
	ٱ�������������������������������������������������������������������������*/
	oFont1     := TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )
	oFont2     := TFont():New( "MS Sans Serif",0,-11,,.F.,0,,400,.F.,.F.,,,,,, )

	oDlg1      := MSDialog():New( 092,230,553,801,"Processos Digitais",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 004,004,080,276,"     Processo de Envio de Boletos por E-mail     "	,oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oBtn1      := TButton():New( 020,012,"Teste Boleto Link"			,oGrp1,{||CABA091N()	},128,012,,oFont1,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 020,152,"Boleto Link"					,oGrp1,{||CABA091B()	},112,012,,oFont1,,.T.,,"",,,,.F. )
	oBtn3      := TButton():New( 040,012,"Log de Boletos Enviados"		,oGrp1,{||u_CABR259()	},128,012,,oFont1,,.T.,,"",,,,.F. )
	oBtn4      := TButton():New( 040,152,"Boletos N�o Enviados"			,oGrp1,{||u_CABR265()	},112,012,,oFont1,,.T.,,"",,,,.F. )
	oBtn5      := TButton():New( 060,012,"Boleto Anexo"					,oGrp1,{||CABA091A()	},128,012,,oFont1,,.T.,,"",,,,.F. )

	oGrp2      := TGroup():New( 084,004,144,276,"     Processo Extrato Digital     "				,oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oBtn6      := TButton():New( 104,012,"Teste Envia Extrato"			,oGrp2,{||CABA091L()	},128,012,,oFont1,,.T.,,"",,,,.F. )
	oBtn7      := TButton():New( 104,152,"Envia Extrato"				,oGrp2,{||CABA091C()	},112,012,,oFont1,,.T.,,"",,,,.F. )
	oBtn8      := TButton():New( 124,012,"Log de Extratos"				,oGrp2,{||CABA091D()	},128,012,,oFont1,,.T.,,"",,,,.F. )

	oGrp3      := TGroup():New( 148,004,180,276,"     Confer�ncia Boleto Digital     "				,oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oBtn9      := TButton():New( 160,012,"Relat�rio de Ades�o"			,oGrp3,{||CABA091H()	},252,012,,oFont1,,.T.,,"",,,,.F. )

	oGrp4      := TGroup():New( 184,004,220,276,"     Processo SMS     "							,oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oBtn10     := TButton():New( 200,012,"Envia SMS"					,oGrp4,{||CABA091J()	},128,012,,oFont1,,.T.,,"",,,,.F. )
	oBtn11     := TButton():New( 200,152,"Log de SMS"					,oGrp4,{||CABA091K()	},112,012,,oFont1,,.T.,,"",,,,.F. )

	oDlg1:Activate(,,,.T.)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA091A �Autor  �Angelo Henrique     � Data �  13/03/2019  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina facilitadora do processo de Envio de boletos por     ���
���          �email.                                                      ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CABA091A()

	Local c_Perg 	:= "CABA615"
	Local aFiles 	:= {}
	Local nCount 	:= 0
	Local nX		:= 0

	CriaSX1( c_Perg )

	If Pergunte( c_Perg )


		//----------------------------------------------------------------------
		//Limpar a pasta com os boletos gerados, limpando arquivos PDF
		//----------------------------------------------------------------------
		aFiles := Directory("\PDF_BOLETO_LOTE\*.PDF")
		nCount := Len( aFiles )
		For nX := 1 to nCount
			FERASE("\PDF_BOLETO_LOTE\" + aFiles[nX][1])
		Next nX

		//----------------------------------------------------------------------
		//Limpar a pasta com os boletos gerados, limpando arquivos REL
		//----------------------------------------------------------------------
		aFiles := Directory("\PDF_BOLETO_LOTE\*.REL")
		nCount := Len( aFiles )
		For nX := 1 to nCount
			FERASE("\PDF_BOLETO_LOTE\" + aFiles[nX][1])
		Next nX

		//----------------------------------------------------------------------
		//Rotina que envia os boletos
		//----------------------------------------------------------------------
		u_CABA615(MV_PAR01,MV_PAR02,MV_PAR03,MV_PAR04)

	EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA091B �Autor  �Angelo Henrique     � Data �  13/03/2019  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina para chamar a rotina individual dos boletos por      ���
���          �email, por�m limpa a pasta de boletos antes.                ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CABA091B()

	Local c_Perg := "CABA091B"

	Perg091B(c_Perg)

	If Pergunte( c_Perg )

		Processa({||EnvMail()},'Processando...')

	EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EnvMail  �Autor  �Angelo Henrique     � Data �  29/05/2020  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina para disparar os e-mails via Procedure no Oracle     ���
���          �                										      ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function EnvMail()

	Local cQuery 	:= ""
	Local _cSisdeb	:= IIF (MV_PAR06 = 1, "S", "N")
	Local _cTest	:= "N"

	ProcRegua(0)

	Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando Envio...')

	cQuery := "BEGIN " + CRLF
	cQuery += " ENVIA_EMAIL_BOLETO_ASS_112('" + MV_PAR01 + "','" + MV_PAR02 + "','" + MV_PAR03 + "','" + MV_PAR04 + "','" + MV_PAR05 + "','" + _cSisdeb + "','" + _cTest + "', ' ' );"
	cQuery += "END;" + CRLF

	If TcSqlExec(cQuery) <> 0
		Aviso("Aten��o","Erro na execu�ao do envio de boletos.",{"OK"})
	Else
		Aviso("Aten��o","Execu��o de envio de boleto finalizada.",{"OK"})
	EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA091C �Autor  �Angelo Henrique     � Data �  27/05/2020  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina para chamar a rotina que ir� enviar os extratos      ���
���          �digitais.        										      ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CABA091C()

	Local c_Perg := "CABA091C"

	CABA091M( c_Perg )

	If Pergunte( c_Perg )

		Processa({||EnvExtr()},'Processando...')

	EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  EnvExtr   �Autor  �Angelo Henrique     � Data �  29/05/2020  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina para disparar os extrato via Procedure no Oracle     ���
���          �                										      ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function EnvExtr()

	Local cQuery := ""

	ProcRegua(0)

	Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando Envio do Extrato...')

	cQuery := "BEGIN " + CRLF
	cQuery += " ENVIA_EMAIL_EXTRATO_ASS('" + MV_PAR01 + "','" + MV_PAR02 + "','" + MV_PAR03 + "','" + MV_PAR04 + "','" + MV_PAR05 + "','N',' ');" + CRLF
	cQuery += "END;" + CRLF

	If TcSqlExec(cQuery) <> 0
		Aviso("Aten��o","Erro na execu�ao do envio de extrato.",{"OK"})
	Else
		Aviso("Aten��o","Execu��o de envio de extrato finalizada.",{"OK"})
	EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA091D �Autor  �Angelo Henrique     � Data �  27/05/2020  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina para chamar o relat�rio de extratos disparados       ���
���          �		        										      ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CABA091D() 

	Local _aArea 	:= GetArea()
	Local oReport	:= Nil

	Private _cPerg 	:= "CABA091D"

	CABA091E( _cPerg )

	If Pergunte( _cPerg )


		//----------------------------------------------------
		//Validando se existe o Excel instalado na m�quina
		//para n�o dar erro e o usu�rio poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")

			oReport := CABA091D1()
			oReport:PrintDialog()

		Else

			Processa({||CABA091G()},'Processando...')

		EndIf

	EndIf

	RestArea(_aArea)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA091D1 �Autor  �Angelo Henrique     � Data �  08/05/20   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� gerar as informa��es do relat�rio            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA091D1

	Local oReport		:= Nil
	Local oSection1 	:= Nil

	oReport := TReport():New("CABA091","LOG EXTRATO DIGITAL",_cPerg,{|oReport| CABA091D2(oReport)},"LOG DE EXTRATO DIGITAL")

	oReport:SetLandScape()

	oReport:oPage:setPaperSize(9)

	//--------------------------------
	//Primeira linha do relat�rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"LOG EXTRATO DIGITAL","BA1")

	TRCell():New(oSection1,"EMPRESA" 		,"BA1")
	oSection1:Cell("EMPRESA"):SetAutoSize(.F.)
	oSection1:Cell("EMPRESA"):SetSize(20)

	TRCell():New(oSection1,"CPF" 			,"BA1")	
	oSection1:Cell("CPF"):SetAutoSize(.F.)
	oSection1:Cell("CPF"):SetSize(20)
	oSection1:Cell("CPF"):SetTitle("CPF") //Refor�ando o t�tulo aqui pois estava saindo um titulo aleat�rio.

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

Static Function CABA091D2(oReport)

	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""

	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()

	//---------------------------------------------
	//CABR265D Realiza toda a montagem da query
	//facilitando a manuten��o do fonte
	//---------------------------------------------
	_cQuery := CABA091Q()

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
		oSection1:Cell("TELEFONE"  	):SetValue((_cAlias1)->TELEFONE		)
		oSection1:Cell("CELULAR"  	):SetValue((_cAlias1)->CELULAR		)
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
���Programa  �CABA091G  �Autor  �Angelo Henrique     � Data �  28/05/20   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel por gerar o relat�rio em CSV, pois       ���
���          �alguns usu�rios n�o possuem o Excel.                        ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA091G()

	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""

	Private _cAlias2	:= GetNextAlias()

	ProcRegua(RecCount())

	cNomeArq := "C:\TEMP\EXTRATO_DIGITAL"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"

	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manuten��o do fonte
	//---------------------------------------------
	_cQuery := CABA091Q()

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

		cMontaTxt := "'" + (_cAlias2)->MATRICULA	+ ";"
		cMontaTxt += "'" + (_cAlias2)->NOME			+ ";"
		cMontaTxt += "'" + (_cAlias2)->EMAIL		+ ";"
		cMontaTxt += "'" + (_cAlias2)->TELEFONE	    + ";"
		cMontaTxt += "'" + (_cAlias2)->CELULAR		+ ";"
		cMontaTxt += "'" + (_cAlias2)->TELEFONE2	+ ";"

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

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA091H �Autor  �Angelo Henrique     � Data �  08/06/2020  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina para chamar o relat�rio de extratos disparados       ���
���          �		        										      ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CABA091H()

	Local _aArea 	:= GetArea()
	Local oReport	:= Nil

	Private _cPerg 	:= "CABA091D" //Padroniza��o das perguntas assim fica mais f�cil

	CABA091E( _cPerg )

	If Pergunte( _cPerg )


		//----------------------------------------------------
		//Validando se existe o Excel instalado na m�quina
		//para n�o dar erro e o usu�rio poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")

			oReport := CABA091H1()
			oReport:PrintDialog()

		Else

			Processa({||CABA091I()},'Processando...')

		EndIf

	EndIf

	RestArea(_aArea)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA091H1 �Autor  �Angelo Henrique     � Data �  08/05/20   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� gerar as informa��es do relat�rio            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA091H1

	Local oReport		:= Nil
	Local oSection1 	:= Nil

	oReport := TReport():New("CABA091","LOG ADES�O BOLETO DIGITAL",_cPerg,{|oReport| CABA091H2(oReport)},"LOG ADES�O BOLETO DIGITAL")

	oReport:SetLandScape()

	oReport:oPage:setPaperSize(9)

	//--------------------------------
	//Primeira linha do relat�rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"LOG ADES�O BOLETO DIGITALL","BA1,SZX")

	TRCell():New(oSection1,"MATRICULA" 		,"BA1")
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(20)

	TRCell():New(oSection1,"NOME" 			,"BA1")
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(TAMSX3("BA1_NOMUSR")[1])

	TRCell():New(oSection1,"PROTOCOLO" 			,"SZX")
	oSection1:Cell("PROTOCOLO"):SetAutoSize(.F.)
	oSection1:Cell("PROTOCOLO"):SetSize(TAMSX3("ZX_SEQ")[1])

	TRCell():New(oSection1,"ADESAO" 		,"BA1")
	oSection1:Cell("ADESAO"):SetAutoSize(.F.)
	oSection1:Cell("ADESAO"):SetSize(20)

	TRCell():New(oSection1,"CANCELAMENTO" 		,"BA1")
	oSection1:Cell("CANCELAMENTO"):SetAutoSize(.F.)
	oSection1:Cell("CANCELAMENTO"):SetSize(20)

	TRCell():New(oSection1,"OPCAO" 		,"BA1")
	oSection1:Cell("OPCAO"):SetAutoSize(.F.)
	oSection1:Cell("OPCAO"):SetSize(20)

	TRCell():New(oSection1,"EMAIL" 			,"BA1")
	oSection1:Cell("EMAIL"):SetAutoSize(.F.)
	oSection1:Cell("EMAIL"):SetSize(TAMSX3("BA1_EMAIL")[1])

	TRCell():New(oSection1,"VIGENCIA" 		,"BA1")
	oSection1:Cell("VIGENCIA"):SetAutoSize(.F.)
	oSection1:Cell("VIGENCIA"):SetSize(20)

	TRCell():New(oSection1,"SOLICITACAO" 		,"BA1")
	oSection1:Cell("SOLICITACAO"):SetAutoSize(.F.)
	oSection1:Cell("SOLICITACAO"):SetSize(20)

	TRCell():New(oSection1,"BOL_DIGITAL" 		,"BA1")
	oSection1:Cell("BOL_DIGITAL"):SetAutoSize(.F.)
	oSection1:Cell("BOL_DIGITAL"):SetSize(20)

Return oReport

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  CABA091H2  �Autor  �Angelo Henrique     � Data �  08/06/20   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina para montar a query e trazer as informa��es no       ���
���          �relat�rio.                                                  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA091H2(oReport)

	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""

	Private oSection1 	:= oReport:Section(1)
	Private _cAlias1	:= GetNextAlias()

	//---------------------------------------------
	//CABR265D Realiza toda a montagem da query
	//facilitando a manuten��o do fonte
	//---------------------------------------------
	_cQuery := CABA091Q("2")

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

		oSection1:Cell("MATRICULA"  	):SetValue((_cAlias1)->MATRICULA	)
		oSection1:Cell("NOME" 			):SetValue((_cAlias1)->NOME			)
		oSection1:Cell("PROTOCOLO" 		):SetValue((_cAlias1)->PROTOCOLO	)
		oSection1:Cell("ADESAO" 		):SetValue((_cAlias1)->DT_ADESAO	)
		oSection1:Cell("CANCELAMENTO" 	):SetValue((_cAlias1)->DT_CANC		)
		oSection1:Cell("OPCAO"  		):SetValue((_cAlias1)->OPCAO		)
		oSection1:Cell("EMAIL"  		):SetValue((_cAlias1)->EMAIL		)
		oSection1:Cell("VIGENCIA"  		):SetValue((_cAlias1)->VIGENCiA		)
		oSection1:Cell("SOLICITACAO"  	):SetValue((_cAlias1)->DTSOL		)
		oSection1:Cell("BOL_DIGITAL"  	):SetValue((_cAlias1)->BOL_DIGITAL	)

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
���Programa  �CABA091G  �Autor  �Angelo Henrique     � Data �  28/05/20   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel por gerar o relat�rio em CSV, pois       ���
���          �alguns usu�rios n�o possuem o Excel.                        ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA091I()

	Local _aArea 	:= GetArea()
	Local _cQuery	:= ""
	Local nHandle 	:= 0
	Local cNomeArq	:= ""
	Local cMontaTxt	:= ""

	Private _cAlias2	:= GetNextAlias()

	ProcRegua(RecCount())

	cNomeArq := "C:\TEMP\EXTRATO_DIGITAL"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"

	//---------------------------------------------
	//CABR244D Realiza toda a montagem da query
	//facilitando a manuten��o do fonte
	//---------------------------------------------
	_cQuery := CABA091Q()

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
				cMontaTxt += "PROTOCOLO		;"
				cMontaTxt += "DATA_ADESAO	;"
				cMontaTxt += "DATA_CANCELA	;"
				cMontaTxt += "OPCAO			;"
				cMontaTxt += "EMAIL			;"
				cMontaTxt += "VIGENCIA		;"

				cMontaTxt += CRLF // Salto de linha para .csv (excel)

				FWrite(nHandle,cMontaTxt)

			Else

				Aviso("Aten��o","N�o foi poss�vel criar o relat�rio",{"OK"})
				Exit

			EndIf

		EndIf

		cMontaTxt := "'" + (_cAlias2)->MATRICULA		+ ";"
		cMontaTxt += "'" + (_cAlias2)->NOME				+ ";"
		cMontaTxt += "'" + (_cAlias2)->PROTOCOLO		+ ";"
		cMontaTxt += "'" + (_cAlias2)->DATAADESAO	    + ";"
		cMontaTxt += "'" + (_cAlias2)->DATACANCELAMENTO	+ ";"
		cMontaTxt += "'" + (_cAlias2)->OPCAO			+ ";"
		cMontaTxt += "'" + (_cAlias2)->EMAIL			+ ";"
		cMontaTxt += "'" + (_cAlias2)->VIGENCiA			+ ";"

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

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  CABA091J   �Autor  �Angelo Henrique     � Data �  10/10/20   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel por disparar a procedure que ir� enviar  ���
���          �os SMS.				                                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA091J()

	Aviso("Aten��o","Rotina em desenvolvimento",{"OK"})

	/*
Local c_Perg := "CABA615" //Mudar o nome do pergunte, a procedure necessita de muitos parametros
Local aFiles := {}
Local nCount := 0

CriaSX1( c_Perg )

If Pergunte( c_Perg )

	Processa({||EnvSMS(MV_PAR01,MV_PAR02,MV_PAR03,MV_PAR04)},'Processando...')

EndIf
	*/

Return


//----------------------------------------------------------------------------------------------------
//Rotina que ir� chamar a procedure com seus res[pectivos parametros.]
//----------------------------------------------------------------------------------------------------
Static Function EnvSMS()

	Local cQuery := ""

	ProcRegua(0)

	Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando Envio...')

	/*////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------------------------------------------------------------------
//Parametros para envio do SMS
//----------------------------------------------------------------------------------------------------
	- Envio para todos benefici�rios com tipo de cobran�a boleto.
    	- PTIPPAG  -- LISTA DE BA3_TIPPAG ex '04/06'
   	- Envio para inadimplentes.
      	- PSITADIMPL    -- A ADIMPLENTES I INADIMPLENTES , BRANCO PARA AMBOS
      	- POPCADIMPL    -- P PARCELAS V SALDO AMAIOR OU IGUAL A , IGNORADO SE PSITADIMPL <> 'A'
      	- PVALADIMPL    -- VALOR ACIMA DE (PARCELAS OU SALDO DEVIDO)
      	- PDIAANTIMPL   -- N�MERO DE DIAS PARA CONSIDERAR O VENCIMENTO
   		- Inclu� Vencimento , opcional
     	- PVENCTO       -- VENCIMENTO , 0 (ZERO) PARA TODOS
   - Envio para grupos. Ex. Previ
       	- REDUNDANTE COM O PTIPPAG
   - Envio para benefici�rios s/ e-mail.
      	- PEMAIL        -- 1 COM OU SEM EMAIL 2 SEM EMAIL 3 COM EMAIL
//----------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------
// Exemplo da Procedure
//----------------------------------------------------------------------------------------------------
 SMS_ENVIO_LINHA_DIGITAVEL (PANOBASE IN VARCHAR2,
                            PMESBASE IN VARCHAR2,
                            PNUMBORDE IN VARCHAR2 DEFAULT '000000',
                            PNUMBORATE IN VARCHAR2  DEFAULT '999999',
                            PTIPPAG IN VARCHAR2 DEFAULT '04',
                            PVENCTO IN NUMBER DEFAULT 0,
                            PSITADIMPL IN VARCHAR2,
                            POPCADIMPL IN VARCHAR2,
                            PVALADIMPL IN NUMBER,
                            PDIAANTIMPL IN NUMBER,
                            PEMAIL IN NUMBER,
                            PMATVIDS IN VARCHAR2)
//----------------------------------------------------------------------------------------------------
	////////////////////////////////////////////////////////////////////////////////////////////////////*/

	cQuery := "BEGIN " + CRLF
	//cQuery += " ENVIA_EMAIL_EXTRATO_ASS('" + MV_PAR01 + "','" + MV_PAR02 + "',' ' );"
	cQuery += "END;" + CRLF

	If TcSqlExec(cQuery) <> 0
		Aviso("Aten��o","Erro na execu�ao do envio de SMS.",{"OK"})
	Else
		Aviso("Aten��o","Execu��o de envio de SMS finalizada.",{"OK"})
	EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  CABA091K   �Autor  �Angelo Henrique     � Data �  10/06/20   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel por log de SMS						      ���
���          �						                                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA091K()

	Local _aArea := GetArea()

	Aviso("Aten��o","Rotina em desenvolvimento",{"OK"})

	RestArea(_aArea)

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA091L
description Rotina para teste do extrato por e-mail
@author  Angelo Henrique
@since   date 14/03/2022
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA091L()

	Local cQuery 	:= ""
	Local _cPerg 	:= "CABA091L"
	Local _cTeste	:= ""

	CABA091L1( _cPerg )

	If Pergunte( _cPerg )

		_cTeste := "S" //IIF(mv_par06 = 1, "S","N")

		If Empty(AllTrim(MV_PAR07)) .And. _cTeste = "S"

			Aviso("Aten��o","Para fins de teste � necess�rio que o campo e-mail esteja preenchido",{"OK"})

		Else

			ProcRegua(0)

			Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando Envio do Teste de Extrato...')

			cQuery := "BEGIN " + CRLF
			cQuery += " ENVIA_EMAIL_EXTRATO_ASS('" + MV_PAR01 + "','" + MV_PAR02 + "','" + MV_PAR03 + "','" + MV_PAR04 + "','" + MV_PAR05 + "','" + _cTeste + "','" + AllTrim(MV_PAR07) + "');" + CRLF
			cQuery += "END;" + CRLF

			If TcSqlExec(cQuery) <> 0
				Aviso("Aten��o","Erro na execu�ao do envio de extrato.",{"OK"})
			Else
				Aviso("Aten��o","Execu��o de envio de extrato finalizada.",{"OK"})
			EndIf

		EndIf

	EndIf

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  CABA091Q   �Autor  �Angelo Henrique     �������� Data �  24/10/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel por tratar a query, facilitando assim    ���
���          �a manuten��o do fonte.                                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA091Q(_cParam)

	Local _cQuery 	:= ""
	Local _lMVPAR02 := .F.

	Default _cParam	:= "1"

	If _cParam = "1"

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
		_cQuery += "    MAIL.PROCESSO = 'EXTRATO'                                                    								" + CRLF
		_cQuery += "    AND MAIL.COMPETENCIA = '" + MV_PAR01 + MV_PAR02 + "'                   										" + CRLF

	Else

		_cQuery += " SELECT                                                                                                         " + CRLF
		_cQuery += "     MATRICULA,                                                                                                 " + CRLF
		_cQuery += "     NOME,                                                                                                      " + CRLF
		_cQuery += "     PROTOCOLO,                                                                                                 " + CRLF
		_cQuery += "     DT_ADESAO,                                                                                                 " + CRLF
		_cQuery += "     DT_CANC,                                                                                                   " + CRLF
		_cQuery += "     OPCAO,                                                                                                     " + CRLF
		_cQuery += "     EMAIL,                                                                                                     " + CRLF
		_cQuery += "     CASE                                                                                                       " + CRLF
		_cQuery += "         VIGENCIA WHEN '/'                                                                                      " + CRLF
		_cQuery += "         THEN ' '                                                                                               " + CRLF
		_cQuery += "         ELSE VIGENCIA                                                                                          " + CRLF
		_cQuery += "     END VIGENCIA ,                                                                                             " + CRLF
		_cQuery += "     DTSOL,                                                                                                     " + CRLF
		_cQuery += "     BOL_DIGITAL                                                                                                " + CRLF
		_cQuery += " FROM                                                                                                           " + CRLF
		_cQuery += "     (                                                                                                          " + CRLF
		_cQuery += "         SELECT                                                                                                 " + CRLF
		_cQuery += "             MATRICULA,                                                                                         " + CRLF
		_cQuery += "             TRIM(BA1_NOMUSR) NOME,                                                                             " + CRLF
		_cQuery += "             PROTOCOLO,                                                                                         " + CRLF
		_cQuery += "             TO_CHAR(TO_DATE(SUBSTR(DTSOL,0,10),'YYYY-MM-DD'),'DD/MM/YYYY') DT_ADESAO,                          " + CRLF
		_cQuery += "             NVL(TO_CHAR(TO_DATE(SUBSTR(DTFIM,0,10),'YYYY-MM-DD'),'DD/MM/YYYY'),' ') DT_CANC,                   " + CRLF
		_cQuery += "             DECODE(OPCAO, 'AD', 'ADERIRAM', 'NA', 'N�O " + " ADERIRAM', 'CA', 'CANCELARAM A ADES�O') OPCAO,	" + CRLF
		_cQuery += "             TRIM(UPPER(EMAIL)) EMAIL,                                                                          " + CRLF
		_cQuery += "             SUBSTR(DTVIG,0,2)|| '/' || SUBSTR(DTVIG,3,4) VIGENCIA ,                                            " + CRLF
		_cQuery += "             TO_CHAR(TO_DATE(SUBSTR(DTSOL,0,10),'YYYY-MM-DD'),'DD/MM/YYYY') DTSOL,                              " + CRLF
		_cQuery += "             DECODE(BA3_XBOLDG,'0','NAO',' ','NAO','SIM') BOL_DIGITAL                                           " + CRLF
		_cQuery += "         FROM                                                                                                   " + CRLF
		_cQuery += "             SIGA.LOG_BOLETO_DIGITAL BOLDIG                                                                     " + CRLF
		_cQuery += "                                                                                                                " + CRLF
		_cQuery += "             INNER JOIN                                                                                         " + CRLF
		_cQuery += "                 " + RetSqlName("BA1") + " BA1                                                                  " + CRLF
		_cQuery += "             ON                                                                                                 " + CRLF
		_cQuery += "                 BA1.BA1_FILIAL      = ' '                                                                      " + CRLF
		_cQuery += "                 AND BA1.BA1_CODINT  = SUBSTR(BOLDIG.MATRICULA,01,4)                                            " + CRLF
		_cQuery += "                 AND BA1.BA1_CODEMP  = SUBSTR(BOLDIG.MATRICULA,05,4)                                            " + CRLF
		_cQuery += "                 AND BA1.BA1_MATRIC  = SUBSTR(BOLDIG.MATRICULA,09,6)                                            " + CRLF
		_cQuery += "                 AND BA1.BA1_TIPREG  = SUBSTR(BOLDIG.MATRICULA,15,2)                                            " + CRLF
		_cQuery += "                 AND BA1.BA1_DIGITO  = SUBSTR(BOLDIG.MATRICULA,17,1)                                            " + CRLF
		_cQuery += "                 AND BA1.D_E_L_E_T_  = ' '                                                                      " + CRLF
		_cQuery += "                                                                                                                " + CRLF
		_cQuery += "             INNER JOIN                                                                                         " + CRLF
		_cQuery += "                 " + RetSqlName("BA3") + " BA3                                                                  " + CRLF
		_cQuery += "             ON                                                                                                 " + CRLF
		_cQuery += "                 BA3.BA3_FILIAL      = BA1.BA1_FILIAL                                                           " + CRLF
		_cQuery += "                 AND BA3.BA3_CODINT  = BA1.BA1_CODINT                                                           " + CRLF
		_cQuery += "                 AND BA3.BA3_CODEMP  = BA1.BA1_CODEMP                                                           " + CRLF
		_cQuery += "                 AND BA3.BA3_MATRIC  = BA1.BA1_MATRIC                                                           " + CRLF
		_cQuery += "                 AND BA3.D_E_L_E_T_  = BA1.D_E_L_E_T_                                                           " + CRLF

		If !(Empty(MV_PAR01)) .Or. !(Empty(MV_PAR02))

			_cQuery += " WHERE                         																				" + CRLF

		EndIf

		If !(Empty(MV_PAR02))

			_lMVPAR02 := .T.
			_cQuery += " 	SUBSTR(DTVIG,0,2) = '" + MV_PAR02 + "'                         											" + CRLF

		EndIf

		If !(Empty(MV_PAR01)) .And.  _lMVPAR02

			_cQuery += "    AND SUBSTR(DTVIG,3,4) = '" + MV_PAR01 + "'                         										" + CRLF

		ElseIf !(Empty(MV_PAR01)) .And.  !_lMVPAR02

			_cQuery += "   SUBSTR(DTVIG,3,4) = '" + MV_PAR01 + "'                         										" + CRLF

		EndIf

		_cQuery += "     ) TAB                                                                                                      " + CRLF
		_cQuery += " ORDER BY 1                                                                                                     " + CRLF

	EndIf

Return _cQuery


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaSX1  �Autor  �Angelo Henrique     � Data �  13/03/2019  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� criar as perguntas que ser� utilizada em     ���
���          �todas as rotinas que envolvem o processo de boleto por e-mail��
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CriaSX1(cPerg)

	PutSx1(cPerg,"01",OemToAnsi("Ano Titulo")			,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("Mes Titulo")			,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03",OemToAnsi("Bordero De")			,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04",OemToAnsi("Bordero Ate")			,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA091E �Autor  �Angelo Henrique     � Data �  27/05/2020  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� criar as perguntas que ser� utilizada em     ���
���          �todas as rotinas que envolvem o processo de extrato digital ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA091E(cPerg)

	u_CABASX1(cPerg,"01",OemToAnsi("Ano Base")			,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"02",OemToAnsi("Mes Base")			,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})

Return



//-------------------------------------------------------------------
/*/{Protheus.doc} function Perg091B
description Perguntas atualizadas para atender a nova demanda de testes
de boletos
@author  author Angelo Henrique
@since   date 12/01/2022
@version version
/*/
//-------------------------------------------------------------------

Static Function Perg091B(cGrpPerg)


	Local aHelpPor := {} //help da pergunta

	aHelpPor := {}
	AADD(aHelpPor,"Informe o Ano:			")

	u_CABASX1(cGrpPerg,"01","Ano: "				,"a","a","MV_CH1"	,"C",TamSX3("E1_ANOBASE")[1]	,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe o M�s:	")

	u_CABASX1(cGrpPerg,"02","Mes: "				,"a","a","MV_CH2"	,"C",TamSX3("E1_MESBASE")[1]	,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Bordero de:	")

	u_CABASX1(cGrpPerg,"03","Bordero de:"		,"a","a","MV_CH3"	,"C",TamSX3("E1_NUMBOR")[1]		,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Bordero Ate:	")

	u_CABASX1(cGrpPerg,"04","Bordero Ate:"		,"a","a","MV_CH4"	,"C",TamSX3("E1_NUMBOR")[1]		,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Informe as matriuclas(CODINT + CODEMP + MATRIC) separado por virgula:	")

	u_CABASX1(cGrpPerg,"05","Matriculas:"		,"a","a","MV_CH5"	,"C",90							,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"SISDEB?	")

	u_CABASX1(cGrpPerg,"06","SISDEB?"			,"a","a","MV_CH6"	,"C",1							,0,0,"C","","","","","MV_PAR06","SIM","","","","NAO","","","","","","","","","","","",aHelpPor,{},{},"")


Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA091L1
description Perguntas para o envio do teste de extrato
@author  Angelo Henrique
@since   date 14/03/2022
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA091L1( cPerg )

	u_CABASX1(cPerg,"01",OemToAnsi("Ano Base")			,"","","mv_ch1","C",04						,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"02",OemToAnsi("Mes Base")			,"","","mv_ch2","C",02						,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"03",OemToAnsi("Bordero De:")		,"","","mv_ch3","C",TAMSX3("E1_NUMBOR")[1]	,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"04",OemToAnsi("Bordero Ate:")		,"","","mv_ch4","C",TAMSX3("E1_NUMBOR")[1]	,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"05",OemToAnsi("Matriculas")		,"","","mv_ch5","C",50						,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"06",OemToAnsi("Teste?")			,"","","mv_ch6","N",01						,0,0,"C","","","","","mv_par06","SIM","","","","NAO","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"07",OemToAnsi("Email Teste")		,"","","mv_ch7","C",50						,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA091M
description Perguntas para o envio de extrato
@author  Angelo Henrique
@since   date 18/03/2022
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA091M( cPerg )

	u_CABASX1(cPerg,"01",OemToAnsi("Ano Base")			,"","","mv_ch1","C",04						,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"02",OemToAnsi("Mes Base")			,"","","mv_ch2","C",02						,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"03",OemToAnsi("Bordero De:")		,"","","mv_ch3","C",TAMSX3("E1_NUMBOR")[1]	,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"04",OemToAnsi("Bordero Ate:")		,"","","mv_ch4","C",TAMSX3("E1_NUMBOR")[1]	,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"05",OemToAnsi("Matriculas")		,"","","mv_ch5","C",50						,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA091N
description Perguntas para o envio dos testes do boleto
@author  Angelo Henrique
@since   date 18/03/2022
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA091N()

	Local cQuery 	:= ""
	Local _cPerg 	:= "CABA091N"
	Local _cTeste	:= ""
	Local _cSisdeb	:= ""

	CABA091N1( _cPerg )

	If Pergunte( _cPerg )

		_cSisdeb := IIF(mv_par06 = 1, "S","N")
		_cTeste  := "S"

		If Empty(AllTrim(MV_PAR08)) .And. _cTeste = "S"

			Aviso("Aten��o","Para fins de teste � necess�rio que o campo e-mail esteja preenchido",{"OK"})

		Else

			ProcRegua(0)

			Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando Envio do Teste de Extrato...')

			cQuery := "BEGIN " + CRLF
			cQuery += " ENVIA_EMAIL_BOLETO_ASS_112('" + MV_PAR01 + "','" + MV_PAR02 + "','" + MV_PAR03 + "','" + MV_PAR04 + "','" + MV_PAR05 + "','" + _cSisdeb + "','" + _cTeste + "','" + AllTrim(MV_PAR08) + "');" + CRLF
			cQuery += "END;" + CRLF

			If TcSqlExec(cQuery) <> 0
				Aviso("Aten��o","Erro na execu�ao do envio de teste de boleto.",{"OK"})
			Else
				Aviso("Aten��o","Execu��o de envio de teste de boleto finalizada.",{"OK"})
			EndIf

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA091N1
description Perguntas para o envio do teste do boleto
@author  Angelo Henrique
@since   date 21/03/2022
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA091N1( cPerg )

	u_CABASX1(cPerg,"01",OemToAnsi("Ano Base")			,"","","mv_ch1","C",04						,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"02",OemToAnsi("Mes Base")			,"","","mv_ch2","C",02						,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"03",OemToAnsi("Bordero De:")		,"","","mv_ch3","C",TAMSX3("E1_NUMBOR")[1]	,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"04",OemToAnsi("Bordero Ate:")		,"","","mv_ch4","C",TAMSX3("E1_NUMBOR")[1]	,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"05",OemToAnsi("Matriculas")		,"","","mv_ch5","C",50						,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"06",OemToAnsi("SISDEB")			,"","","mv_ch6","N",01						,0,0,"C","","","","","mv_par06","SIM","","","","NAO","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"07",OemToAnsi("Teste?")			,"","","mv_ch7","N",01						,0,0,"C","","","","","mv_par07","SIM","","","","NAO","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"08",OemToAnsi("Email Teste")		,"","","mv_ch8","C",50						,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})

Return