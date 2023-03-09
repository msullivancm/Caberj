#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#include "TOTVS.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA100    � Autor � Angelo Henrique    � Data �  21/05/19 ���
�������������������������������������������������������������������������͹��
���Descricao � Rotina para importar a tabela BC6 - Tabela de Pre�o        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CABA100(_cParam)

	Local aArea    		:= GetArea()
	Local cDescr		:= ""	
	Local cFlag			:= .F.

	Private cProg       := "CABA100"
	Private cArqCSV		:= "C:\"
	Private nOpen		:= -1
	Private cDiretorio	:= " "
	Private oDlg		:= Nil
	Private oGet1		:= Nil
	Private oBtn1		:= Nil
	Private oGrp1		:= Nil
	Private oSay1		:= Nil
	Private oSay2		:= Nil
	Private oSBtn1		:= Nil
	Private oSBtn2		:= Nil
	Private oCombo		:= Nil
	Private nLinhaAtu  	:= 0
	Private cTrbPos
	Private lEnd	    := .F.
	Private _cTime		:= TIME()
	Private _aDadGrv	:= {}

	Default _cParam		:= "2" //1 - Chamado pelo ponto de entrada, 2 - direto pelo menu
	//-----------------------------------------
	//Validar a chamada pelo menu do padr�o
	//usado P.E. PLS105MN
	//-----------------------------------------
	If _cParam = "1"

		cDescr := "Este programa ir� importar/extrair os Itens da Tabela de Pre�o apartir de um arquivo CSV." + CRLF
		cDescr += "Para o RDA: " + BC5->BC5_CODRDA + " - " + Posicione("BAU",1,xFilial("BAU") + BC5->BC5_CODRDA,"BAU_NOME") + "." + CRLF
		cDescr += "Tabela: "  + BC5->BC5_CODTAB + " - Vig�ncia: " + DTOC(BC5->BC5_DATINI) + "."

	Else

		cDescr := "Este programa ir� importar/extrair os Itens da Tabela de Pre�o apartir de um arquivo CSV."

	EndIf

	oDlg              := MSDialog():New( 095,232,301,762,"Importa��o Itens Tabela de Pre�o",,,.F.,,,,,,.T.,,,.T. )
	oGet1             := TGet():New( 062,020,{||cArqCSV},oDlg,206,008,,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cArqCSV",,)
	oGet1:lReadOnly   := .T.

	oButton1          := TBrowseButton():New( 062,228,'...',oDlg,,022,011,,,.F.,.T.,.F.,,.F.,,,)

	*-----------------------------------------------------------------------------------------------------------------*
	*Buscar o arquivo no diretorio desejado.                                                                          *
	*Comando para selecionar um arquivo.                                                                              *
	*Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                       *
	*           GETF_LOCALHARD   - Inclui o Harddisk local.                                                           *
	*-----------------------------------------------------------------------------------------------------------------*

	oButton1:bAction  := {||cArqCSV := cGetFile("Arquivos CSV (*.CSV)|*.csv|","Selecione o .CSV a importar",1,cDiretorio,.T.,GETF_LOCALHARD)}
	oButton1:cToolTip := "Importar CSV"

	oGrp1             := TGroup():New( 008,020,050,252,"",oDlg,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1             := TSay():New( 016,028,{||cDescr},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,226,030)	
	oButton2          := tButton():New(082,092,'Avan�ar' ,oDlg,,35,15,,,,.T.)
	oButton2:bAction  := {||If(empty(cArqCSV) .or. right(allTrim(lower(cArqCSV)),4) != ".csv",MsgAlert("Informe um arquivo!","Aten��o"),(cFlag := .T.,oDlg:End()))}
	oButton2:cToolTip := "Ir para o pr�ximo passo"

	oButton3          := tButton():New(082,144,'Cancelar',oDlg,,35,15,,,,.T.)
	oButton3:bAction  := {||cFlag := .F.,fClose(nOpen),oDlg:End()}
	oButton3:cToolTip := "Cancela a importa��o"

	oButton4          := tButton():New(082,195,'Extrair Layout',oDlg,,35,15,,,,.T.)
	oButton4:bAction  := {||fLayout(_cParam)}
	oButton4:cToolTip := "Extrair Layout"

	oDlg:Activate(,,,.T.)

	If cFlag == .T. .AND. CABA100A(_cParam)
		Processa({|lEnd|ImportCSV(@lEnd, cArqCSV)},"Aguarde...","",.T.)
	EndIf

	RestArea(aArea)

Return

/*/
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������ͻ��
	���Programa  � ImportCSV  � Autor � Angelo Henrique    � Data �  08/01/19 ���
	�������������������������������������������������������������������������͹��
	���Descricao � Efetua a importal�ao do arquivo .CSV                       ���
	�������������������������������������������������������������������������͹��
	���Uso       � CABERJ                                                     ���
	�������������������������������������������������������������������������ͼ��
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
/*/

Static Function ImportCSV(lEnd,cArqCSV)

	Local cLinha 		:= ""
	Local aStruc      	:= {}
	Local _aLinhaOk		:= {}
	Local _lGrava 		:= .T.

	Private nTotal		:= 0

	//-------------------------------------------------------------------------
	//INICIO = Vari�veis que ser�o utilizadas para saber a posi��o do cabe�alho.
	//Ser�o chamadas em outros momentos desse fonte
	//-------------------------------------------------------------------------
	Private _nCODRDA 	:= 0
	Private _nCODTAB 	:= 0
	Private _nCDPRRA 	:= 0
	Private _nCODPRO 	:= 0
	Private _nTIPLAN 	:= 0
	Private _nCODACO 	:= 0
	Private _nUSPCO  	:= 0
	Private _nVRPCO  	:= 0
	Private _nUSRCO  	:= 0
	Private _nVRRCO  	:= 0
	Private _nUSPPP  	:= 0
	Private _nVRPPP  	:= 0
	Private _nUSRPP  	:= 0
	Private _nVRRPP  	:= 0
	Private _nTPLAN  	:= 0
	Private _nCODOPE 	:= 0
	Private _nTPLANP 	:= 0
	Private _nCODPLA 	:= 0
	Private _nCODPAD 	:= 0
	Private _nVIGINI 	:= 0
	Private _nVIGFIM 	:= 0
	Private _nCDNV01 	:= 0
	Private _nCDNV02 	:= 0
	Private _nCDNV03 	:= 0
	Private _nCDNV04 	:= 0
	Private _nNIVEL  	:= 0
	Private _nYRGIMP 	:= 0
	Private _nBANDAP 	:= 0
	Private _nBANDAR 	:= 0
	Private _nPERDES 	:= 0
	Private _nUCO	 	:= 0
	Private _nPERACR 	:= 0
	Private _nXPCPFB 	:= 0
	Private _nYEDICA 	:= 0
	Private _nXDCPFB 	:= 0
	Private _nRECREA 	:= 0
	Private _nCODREA 	:= 0
	//-------------------------------------------------------------------------
	//FIM - Vari�veis que ser�o utilizadas para saber a posi��o do cabe�alho.
	//Ser�o chamadas em outros momentos desse fonte
	//-------------------------------------------------------------------------

	Private _cTime		:= TIME() //Hora inicial da importa��o
	Private aLinha		:= {}

	Private a_ItFim     := {}
	Private a_Cab		:= {"Linha","Problema encontrado"}

	//���������������������������������������������������������������������Ŀ
	//� Criacao do arquivo temporario...                                    �
	//�����������������������������������������������������������������������
	aAdd(aStruc,{"CAMPO","C",500,0})

	cTrbPos := CriaTrab(aStruc,.T.)

	If Select("TrbPos") <> 0
		TrbPos->(dbCloseArea())
	End

	DbUseArea(.T.,,cTrbPos,"TrbPos",.T.)

	lInicio 	:= .T.
	lCabecOk 	:= .T.

	//-------------------------------------------------
	// importa arquivo para tabela tempor�ria
	//-------------------------------------------------
	PLSAppTmp(cArqCSV)

	TRBPOS->(DbGoTop())

	If TRBPOS->(EOF())
		MsgStop("Arquivo Vazio!")
		TRBPOS->(DBCLoseArea())
		Close(oLeTxt)
		lRet := .F.
		Return
	End

	nTotal := TRBPOS->(LastRec()-1)

	ProcRegua(nTotal)

	TRBPOS->(DbGoTop())

	While !TRBPOS->(Eof())

		If lEnd
			MsgAlert("Interrompido pelo usu�rio","Aviso")
			Return
		EndIf

		++nLinhaAtu

		IncProc("Processando a Linha n�mero " + allTrim(Str(nLinhaAtu-1)) + " De " + cValTochar(nTotal))

		//-----------------------------------------------------------------------
		// Faz a leitura da linha do arquivo e atribui a vari�vel cLinha
		//-----------------------------------------------------------------------
		cLinha := UPPER(TRBPOS->CAMPO)

		//-----------------------------------------------------------------------
		// Se ja passou por todos os registros da planilha CSV sai do while
		//-----------------------------------------------------------------------
		if Empty(cLinha) .OR. substring(cLinha,1,1) == ";"
			Exit
		EndIf

		//-----------------------------------------------------------------------
		// Transfoma todos os ";;" em "; ;", de modo que o StrTokArr ir� retornar
		// sempre um array com o n�mero de colunas correto.
		//-----------------------------------------------------------------------
		cLinha := strTran(cLinha,";;","; ;")
		cLinha := strTran(cLinha,";;","; ;")

		//-----------------------------------------------------------------------
		// Para que o �ltimo item nunca venha vazio.
		//-----------------------------------------------------------------------
		cLinha += " ;"

		aLinha := strTokArr(cLinha,";")

		If lInicio
			lInicio := .F.
			IncProc("Lendo cabe�alho...De: "+cValTochar(nTotal))

			//-----------------------------------------------------------------------
			//Valida��o do cabe�alho
			//-----------------------------------------------------------------------
			if !lLeCabec(aLinha)

				MsgAlert("Cabe�alho inv�lido, favor verificar e reimportar","Aviso")

				_lGrava := .F.

				Exit

			else
				lCabecOk :=  .T.
			endif
			//-----------------------------------------------------------------------
			// N�o continua se o cabe�alho n�o estiver Ok
			//-----------------------------------------------------------------------

		Else

			//-----------------------------------------------------------------------
			// n�o � linha em branco
			//-----------------------------------------------------------------------
			If len(aLinha) > 0

				//-------------------------------------------------------------------
				//Colocar aqui a valida��o de todas as linhas
				//-------------------------------------------------------------------
				If fValInf(aLinha)

					IncProc("Validando informa��es inseridas na linha: "+cValTochar(nTotal))

					AADD(_aLinhaOk, aLinha)

				Else

					_lGrava := .F.

				EndIf

			EndIf

		EndIf

		TRBPOS->(dbskip())

	EndDo

	If _lGrava

		//-------------------------------------------------------------------
		//Fun��o para gravar as informa��es do arquivo na tabela
		//-------------------------------------------------------------------
		fProcDad(_aLinhaOk)

	EndIf

	//----------------------------------------------
	//Valida se houve erro e exibe em um excel
	//----------------------------------------------
	If Len(a_ItFim) > 0

		IncProc("Gravando arquivo de Log ")

		Aviso("Aten��o","Importa��o n�o conclu�da favor analisar excel que ser� gerado ap�s essa mensagem..",{"OK"})

		DlgToExcel({{"ARRAY","Log de Importa��o de Lan�amentos, CABA100", a_Cab, a_ItFim}})

	Else

		Aviso("Aten��o","Importa��o finalizada..",{"OK"})

	EndIf

Return

/*/
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������ͻ��
	���Programa  � PLSAppTmp  � Autor � Angelo Henrique    � Data �  08/01/19 ���
	�������������������������������������������������������������������������͹��
	���Descricao � Realiza o append do arquivo em uma tabela temporaria       ���
	�������������������������������������������������������������������������͹��
	���Uso       � CABERJ                                                     ���
	�������������������������������������������������������������������������ͼ��
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
/*/
Static Function PLSAppTmp(cNomeArq)

	DbSelectArea("TRBPOS")
	Append From &(cNomeArq) SDF

Return

/*/
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������ͻ��
	���Programa  � lLeCabec   � Autor � Angelo Henrique    � Data �  08/01/19 ���
	�������������������������������������������������������������������������͹��
	���Descricao � Realiza a valida��o do cabe�alho                           ���
	�������������������������������������������������������������������������͹��
	���Uso       � CABERJ                                                     ���
	�������������������������������������������������������������������������ͼ��
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
/*/
Static Function lLeCabec(aLinha)

	Local lRet 		:= .T.
	Local _ni		:= 0

	//------------------------------------------------------------------------------
	//Realizando o tratamento no cabe�alho antes de executar as valida��es
	//------------------------------------------------------------------------------
	For _ni := 1 To Len(aLinha)

		aLinha[_ni] := u_SemAcento(UPPER(AllTrim(aLinha[_ni])))

	Next _ni

	_nCODRDA 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CODRDA"	})
	_nCODTAB 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CODTAB"	})
	_nCDPRRA 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CDPRRA"	})
	_nCODPRO 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CODPRO"	})
	_nTIPLAN 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_TIPLAN"	})
	_nCODACO 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CODACO"	})
	_nUSPCO  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_USPCO"	})
	_nVRPCO  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_VRPCO"	})
	_nUSRCO  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_USRCO"	})
	_nVRRCO  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_VRRCO"	})
	_nUSPPP  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_USPPP"	})
	_nVRPPP  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_VRPPP"	})
	_nUSRPP  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_USRPP"	})
	_nVRRPP  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_VRRPP"	})
	_nTPLAN  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_TPLAN"	})
	_nCODOPE 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CODOPE"	})
	_nTPLANP 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_TPLANP"	})
	_nCODPLA 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CODPLA"	})
	_nCODPAD 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CODPAD"	})
	_nVIGINI 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_VIGINI"	})
	_nVIGFIM 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_VIGFIM"	})
	_nCDNV01 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CDNV01"	})
	_nCDNV02 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CDNV02"	})
	_nCDNV03 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CDNV03"	})
	_nCDNV04 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CDNV04"	})
	_nNIVEL  	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_NIVEL"	})
	_nYRGIMP 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_YRGIMP"	})
	_nBANDAP 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_BANDAP"	})
	_nBANDAR 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_BANDAR"	})
	_nPERDES 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_PERDES"	})
	_nUCO		:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_UCO"		})
	_nPERACR 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_PERACR"	})
	_nXPCPFB 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_XPCPFB"	})
	_nYEDICA 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_YEDICA"	})
	_nXDCPFB 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_XDCPFB"	})
	_nRECREA 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_RECREA"	})
	_nCODREA 	:= aScan(aLinha,{|x| Alltrim(UPPER(x)) == "BC6_CODREA"	})

	If _nCODRDA == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CODRDA n�o encontrada."})
		lRet := .F.
	ElseIf _nCODTAB == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CODTAB n�o encontrada."})
		lRet := .F.
	ElseIf _nCDPRRA == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CDPRRA n�o encontrada."})
		lRet := .F.
	ElseIf _nCODPRO == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CODPRO n�o encontrada."})
		lRet := .F.
	ElseIf _nTIPLAN == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_TIPLAN n�o encontrada."})
		lRet := .F.
	ElseIf _nCODACO == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CODACO n�o encontrada."})
		lRet := .F.
	ElseIf _nUSPCO  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_USPCO n�o encontrada."})
		lRet := .F.
	ElseIf _nVRPCO  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_VRPCO n�o encontrada."})
		lRet := .F.
	ElseIf _nUSRCO  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_USRCO n�o encontrada."})
		lRet := .F.
	ElseIf _nVRRCO  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_VRRCO n�o encontrada."})
		lRet := .F.
	ElseIf _nUSPPP  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_USPPP n�o encontrada."})
		lRet := .F.
	ElseIf _nVRPPP  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_VRPPP n�o encontrada."})
		lRet := .F.
	ElseIf _nUSRPP  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_USRPP n�o encontrada."})
		lRet := .F.
	ElseIf _nVRRPP  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_VRRPP n�o encontrada."})
		lRet := .F.
	ElseIf _nTPLAN  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_TPLAN n�o encontrada."})
		lRet := .F.
	ElseIf _nCODOPE == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CODOPE n�o encontrada."})
		lRet := .F.
	ElseIf _nTPLANP == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_TPLANP n�o encontrada."})
		lRet := .F.
	ElseIf _nCODPLA == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CODPLA n�o encontrada."})
		lRet := .F.
	ElseIf _nCODPAD == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CODPAD n�o encontrada."})
		lRet := .F.
	ElseIf _nVIGINI == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_VIGINI n�o encontrada."})
		lRet := .F.
	ElseIf _nVIGFIM == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_VIGFIM n�o encontrada."})
		lRet := .F.
	ElseIf _nCDNV01 == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CDNV01 n�o encontrada."})
		lRet := .F.
	ElseIf _nCDNV02 == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CDNV02 n�o encontrada."})
		lRet := .F.
	ElseIf _nCDNV03 == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CDNV03 n�o encontrada."})
		lRet := .F.
	ElseIf _nCDNV04 == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CDNV04 n�o encontrada."})
		lRet := .F.
	ElseIf _nNIVEL  == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_NIVEL n�o encontrada."})
		lRet := .F.
	ElseIf _nYRGIMP == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_YRGIMP n�o encontrada."})
		lRet := .F.
	ElseIf _nBANDAP == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_BANDAP n�o encontrada."})
		lRet := .F.
	ElseIf _nBANDAR == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_BANDAR n�o encontrada."})
		lRet := .F.
	ElseIf _nPERDES == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_PERDES n�o encontrada."})
		lRet := .F.
	ElseIf _nUCO	== 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_UCO n�o encontrada."})
		lRet := .F.
	ElseIf _nPERACR == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_PERACR n�o encontrada."})
		lRet := .F.
	ElseIf _nXPCPFB == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_XPCPFB n�o encontrada."})
		lRet := .F.
	ElseIf _nYEDICA == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_YEDICA n�o encontrada."})
		lRet := .F.
	ElseIf _nXDCPFB == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_XDCPFB n�o encontrada."})
		lRet := .F.
	ElseIf _nRECREA == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_RECREA n�o encontrada."})
		lRet := .F.
	ElseIf _nCODREA == 0
		AADD(a_ItFim,{nLinhaAtu,"Coluna BC6_CODREA n�o encontrada."})
		lRet := .F.
	EndIf

Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fProcDad   �Autor  � Angelo Henrique   � Data �  08/01/19   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o para armazenar os dados lidos do arquivo no vetor   ���
���		     � e gravar na BA1				 							  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function fProcDad(aLinha)

	Local _aArea 	:= GetArea()
	Local _aArBC6	:= BC6->(GetArea())
	Local _na		:= 0
	Local _n1		:= 0
	Local _cVigIn	:= ""
	Local _cVigFi	:= ""

	//-------------------------------------------------------------------------------
	//Antes de realizar a grava��o verificar se existem ainda caracteres especiais
	//-------------------------------------------------------------- -----------------
	For _n1 := 1 To Len(aLinha)

		IncProc("Inserindo informa��es validadas: "+cValTochar(nTotal))
		IncProc("Processando a Linha n�mero " + allTrim(Str(_n1)) + " De " + cValTochar(nTotal))


		For _na := 1 To Len(aLinha[_n1])

			aLinha[_n1][_na] := Replace(Replace(AllTrim(aLinha[_n1][_na]),'"',''),'=','')

			If _na = _nUSPCO ;
					.or. _na = _nVRPCO ;
					.or. _na = _nUSRCO ;
					.or. _na = _nVRRCO ;
					.or. _na = _nUSPPP ;
					.or. _na = _nVRPPP ;
					.or. _na = _nUSRPP ;
					.or. _na = _nVRRPP ;
					.or. _na = _nBANDAP;
					.or. _na = _nBANDAR;
					.or. _na = _nPERDES;
					.or. _na = _nUCO   ;
					.or. _na = _nPERACR;
					.or. _na = _nXPCPFB;
					.or. _na = _nXDCPFB;
					.or. _na = _nRECREA

				aLinha[_n1][_na] := REPLACE( UPPER(aLinha[_n1][_na]),"R","")
				aLinha[_n1][_na] := REPLACE( aLinha[_n1][_na],"$","")

				aLinha[_n1][_na] := VAL(Replace(aLinha[_n1][_na],",","." )) //Num�rico

			EndIf

			If _na = _nVIGINI

				If At("/",AllTrim(aLinha[_n1][_na])) > 0

					_cVigIn := CTOD(AllTrim(aLinha[_n1][_na])) //Data

				Else

					_cVigIn := STOD(AllTrim(aLinha[_n1][_na])) //Data

				EndIf

			EndIf

			If _na = _nVIGFIM

				If At("/",AllTrim(aLinha[_n1][_na]))  > 0

					_cVigFi := CTOD(AllTrim(aLinha[_n1][_na])) //Data

				Else

					_cVigFi := STOD(AllTrim(aLinha[_n1][_na])) //Data

				EndIf

			EndIf

		Next _na

		RecLock("BC6",.T.)

		BC6->BC6_FILIAL	:= xFilial("BC6")
		BC6->BC6_CODINT := "0001"
		BC6->BC6_CODRDA := PADL(AllTrim(aLinha[_n1][_nCODRDA]),TAMSX3("BC6_CODRDA")[1],'0')
		BC6->BC6_CODTAB := PADL(AllTrim(aLinha[_n1][_nCODTAB]),TAMSX3("BC6_CODTAB")[1],'0')
		BC6->BC6_CDPRRA := AllTrim(aLinha[_n1][_nCDPRRA])
		BC6->BC6_CODPRO := AllTrim(aLinha[_n1][_nCODPRO])
		BC6->BC6_TIPLAN := AllTrim(aLinha[_n1][_nTIPLAN])
		BC6->BC6_CODACO := AllTrim(aLinha[_n1][_nCODACO])
		BC6->BC6_USPCO  := aLinha[_n1][_nUSPCO]	 	//Num�rico
		BC6->BC6_VRPCO  := aLinha[_n1][_nVRPCO]	 	//Num�rico
		BC6->BC6_USRCO  := aLinha[_n1][_nUSRCO]  	//Num�rico
		BC6->BC6_VRRCO  := aLinha[_n1][_nVRRCO]  	//Num�rico
		BC6->BC6_USPPP  := aLinha[_n1][_nUSPPP]  	//Num�rico
		BC6->BC6_VRPPP  := aLinha[_n1][_nVRPPP]  	//Num�rico
		BC6->BC6_USRPP  := aLinha[_n1][_nUSRPP]  	//Num�rico
		BC6->BC6_VRRPP  := aLinha[_n1][_nVRRPP]  	//Num�rico
		BC6->BC6_TPLAN  := AllTrim(aLinha[_n1][_nTPLAN ])
		BC6->BC6_CODOPE := AllTrim(aLinha[_n1][_nCODOPE])
		BC6->BC6_TPLANP := AllTrim(aLinha[_n1][_nTPLANP])
		BC6->BC6_CODPLA := AllTrim(aLinha[_n1][_nCODPLA])
		BC6->BC6_CODPAD := PADL(AllTrim(aLinha[_n1][_nCODPAD]),TAMSX3("BC6_CODPAD")[1],'0')
		BC6->BC6_VIGINI := _cVigIn //Data
		BC6->BC6_VIGFIM := _cVigFi //Data
		BC6->BC6_CDNV01 := AllTrim(aLinha[_n1][_nCDNV01])
		BC6->BC6_CDNV02 := AllTrim(aLinha[_n1][_nCDNV02])
		BC6->BC6_CDNV03 := AllTrim(aLinha[_n1][_nCDNV03])
		BC6->BC6_CDNV04 := AllTrim(aLinha[_n1][_nCDNV04])
		BC6->BC6_NIVEL  := AllTrim(aLinha[_n1][_nNIVEL ])
		BC6->BC6_YRGIMP := AllTrim(aLinha[_n1][_nYRGIMP])
		BC6->BC6_BANDAP := aLinha[_n1][_nBANDAP]  	//Num�rico
		BC6->BC6_BANDAR := aLinha[_n1][_nBANDAR]  	//Num�rico
		BC6->BC6_PERDES := aLinha[_n1][_nPERDES]  	//Num�rico
		BC6->BC6_UCO    := aLinha[_n1][_nUCO   ]  	//Num�rico
		BC6->BC6_PERACR := aLinha[_n1][_nPERACR]  	//Num�rico
		BC6->BC6_XPCPFB := aLinha[_n1][_nXPCPFB]  	//Num�rico
		BC6->BC6_YEDICA := AllTrim(aLinha[_n1][_nYEDICA])
		BC6->BC6_XDCPFB := aLinha[_n1][_nXDCPFB]	//Num�rico
		BC6->BC6_RECREA := aLinha[_n1][_nRECREA]	//Num�rico
		BC6->BC6_CODREA := AllTrim(aLinha[_n1][_nCODREA])

		BC6->(MSUnLock())

	Next _n1

	RestArea(_aArBC6)
	RestArea(_aArea )

Return

/*/{Protheus.doc} fLayout
 Rotina utilizada para extrair o layout da importa��o
@type function
@version  1.0
@author angelo.cassago
@since 11/07/2022
/*/
Static Function fLayout(_cParam)

	Local _cPerg    := "CABA100"
	Local aCab      := {}
	Local aItens	:= {}

	AADD(aCab, {"BC6_CODINT"	,"C", TAMSX3("BC6_CODINT")[1], 0})
	AADD(aCab, {"BC6_CODRDA"	,"C", TAMSX3("BC6_CODRDA")[1], 0})
	AADD(aCab, {"BC6_CODTAB"	,"C", TAMSX3("BC6_CODTAB")[1], 0})
	AADD(aCab, {"BC6_CDPRRA"	,"C", TAMSX3("BC6_CDPRRA")[1], 0})
	AADD(aCab, {"BC6_CODPRO"	,"C", TAMSX3("BC6_CODPRO")[1], 0})
	AADD(aCab, {"BC6_TIPLAN"	,"C", TAMSX3("BC6_TIPLAN")[1], 0})
	AADD(aCab, {"BC6_CODACO"	,"C", TAMSX3("BC6_CODACO")[1], 0})
	AADD(aCab, {"BC6_USPCO"		,"N", TAMSX3("BC6_USPCO" )[1], 0})
	AADD(aCab, {"BC6_VRPCO"		,"N", TAMSX3("BC6_VRPCO" )[1], 0})
	AADD(aCab, {"BC6_USRCO"		,"N", TAMSX3("BC6_USRCO" )[1], 0})
	AADD(aCab, {"BC6_VRRCO"		,"N", TAMSX3("BC6_VRRCO" )[1], 0})
	AADD(aCab, {"BC6_USPPP"		,"N", TAMSX3("BC6_USPPP" )[1], 0})
	AADD(aCab, {"BC6_VRPPP"		,"N", TAMSX3("BC6_VRPPP" )[1], 0})
	AADD(aCab, {"BC6_USRPP"		,"N", TAMSX3("BC6_USRPP" )[1], 0})
	AADD(aCab, {"BC6_VRRPP"		,"N", TAMSX3("BC6_VRRPP" )[1], 0})
	AADD(aCab, {"BC6_TPLAN"		,"C", TAMSX3("BC6_TPLAN" )[1], 0})
	AADD(aCab, {"BC6_CODOPE"	,"C", TAMSX3("BC6_CODOPE")[1], 0})
	AADD(aCab, {"BC6_TPLANP"	,"C", TAMSX3("BC6_TPLANP")[1], 0})
	AADD(aCab, {"BC6_CODPLA"	,"C", TAMSX3("BC6_CODPLA")[1], 0})
	AADD(aCab, {"BC6_CODPAD"	,"C", TAMSX3("BC6_CODPAD")[1], 0})
	AADD(aCab, {"BC6_VIGINI"	,"D", TAMSX3("BC6_VIGINI")[1], 0})
	AADD(aCab, {"BC6_VIGFIM"	,"D", TAMSX3("BC6_VIGFIM")[1], 0})
	AADD(aCab, {"BC6_CDNV01"	,"C", TAMSX3("BC6_CDNV01")[1], 0})
	AADD(aCab, {"BC6_CDNV02"	,"C", TAMSX3("BC6_CDNV02")[1], 0})
	AADD(aCab, {"BC6_CDNV03"	,"C", TAMSX3("BC6_CDNV03")[1], 0})
	AADD(aCab, {"BC6_CDNV04"	,"C", TAMSX3("BC6_CDNV04")[1], 0})
	AADD(aCab, {"BC6_NIVEL"		,"C", TAMSX3("BC6_NIVEL" )[1], 0})
	AADD(aCab, {"BC6_YRGIMP"	,"C", TAMSX3("BC6_YRGIMP")[1], 0})
	AADD(aCab, {"BC6_BANDAP"	,"N", TAMSX3("BC6_BANDAP")[1], 0})
	AADD(aCab, {"BC6_BANDAR"	,"N", TAMSX3("BC6_BANDAR")[1], 0})
	AADD(aCab, {"BC6_PERDES"	,"N", TAMSX3("BC6_PERDES")[1], 0})
	AADD(aCab, {"BC6_UCO"		,"N", TAMSX3("BC6_UCO"	 )[1], 0})
	AADD(aCab, {"BC6_PERACR"	,"C", TAMSX3("BC6_PERACR")[1], 0})
	AADD(aCab, {"BC6_XPCPFB"	,"N", TAMSX3("BC6_XPCPFB")[1], 0})
	AADD(aCab, {"BC6_YEDICA"	,"C", TAMSX3("BC6_YEDICA")[1], 0})
	AADD(aCab, {"BC6_XDCPFB"	,"N", TAMSX3("BC6_XDCPFB")[1], 0})
	AADD(aCab, {"BC6_RECREA"	,"N", TAMSX3("BC6_RECREA")[1], 0})
	AADD(aCab, {"BC6_CODREA"	,"C", TAMSX3("BC6_CODREA")[1], 0})

	If _cParam <> "1"

		Perg100(_cPerg)

		If Pergunte( _cPerg )

			If !Empty(MV_PAR01) .and. !Empty(MV_PAR02)

				MsgRun("Aguarde.....", "Selecionando os Registros",{|| ProcDados(aCab, @aItens)})

				MsgRun("Aguarde.....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS",,aCab,aItens}})})

			Else

				Aviso("Aten��o","Necess�rio preencher os dois par�metros: tabela e vig�ncia",{"OK"})

			EndIf

		EndIf

	Else

		If MsgYesNo("Ser� extra�do informa��es do RDA x Tabela de Pre�o selecionado, deseja continuar:", "Aten��o")

			MsgRun("Aguarde.....", "Selecionando os Registros",{|| ProcDados(aCab, @aItens,_cParam)})

			MsgRun("Aguarde.....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS",,aCab,aItens}})})

		EndIf

	EndIf

Return

/*/{Protheus.doc} Perg100
    Rotina utilizada para perguntas
@type function
@version  1.0
@author angelo.cassago
@since 11/07/2022
@param _cPerg, variant, nome da pergunta
/*/
Static Function Perg100(_cPerg)

	U_CABASX1(_cPerg,"01",OemToAnsi("Tabela")           ,"","","mv_ch1","C",TAMSX3("BC6_CODTAB")[1],0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	U_CABASX1(_cPerg,"02",OemToAnsi("Vigencia Inicial")	,"","","mv_ch2","D",TAMSX3("BC6_VIGINI")[1],0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	U_CABASX1(_cPerg,"03",OemToAnsi("Cod. RDA")			,"","","mv_ch3","C",TAMSX3("BC6_CODRDA")[1],0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})

Return

/*/{Protheus.doc} ProcDados
Processa os dados para alimentar o excel
@type function
@version  1.0
@author angelo.cassago
@since 11/07/2022
@param aHeader, array, cont�m o cabe�calho
@param aCols, array, ser� preenchido com os dados da query
/*/
Static Function ProcDados(aHeader, aCols,_cParam)

	Local aItem     := {}
	Local _cQuery 	:= ""
	Local _cAlias2  := GetNextAlias()
	Local nX        := 0

	_cQuery += " SELECT														" + CRLF
	_cQuery += "     BC6.BC6_CODINT,    									" + CRLF
	_cQuery += "     BC6.BC6_CODRDA,    									" + CRLF
	_cQuery += "     BC6.BC6_CODTAB,    									" + CRLF
	_cQuery += "     BC6.BC6_CDPRRA,    									" + CRLF
	_cQuery += "     BC6.BC6_CODPRO,    									" + CRLF
	_cQuery += "     BC6.BC6_TIPLAN,    									" + CRLF
	_cQuery += "     BC6.BC6_CODACO,    									" + CRLF
	_cQuery += "     BC6.BC6_USPCO,     									" + CRLF
	_cQuery += "     BC6.BC6_VRPCO,     									" + CRLF
	_cQuery += "     BC6.BC6_USRCO,     									" + CRLF
	_cQuery += "     BC6.BC6_VRRCO,     									" + CRLF
	_cQuery += "     BC6.BC6_USPPP,     									" + CRLF
	_cQuery += "     BC6.BC6_VRPPP,     									" + CRLF
	_cQuery += "     BC6.BC6_USRPP,     									" + CRLF
	_cQuery += "     BC6.BC6_VRRPP,     									" + CRLF
	_cQuery += "     BC6.BC6_TPLAN,     									" + CRLF
	_cQuery += "     BC6.BC6_CODOPE,    									" + CRLF
	_cQuery += "     BC6.BC6_TPLANP,    									" + CRLF
	_cQuery += "     BC6.BC6_CODPLA,    									" + CRLF
	_cQuery += "     BC6.BC6_CODPAD,    									" + CRLF
	_cQuery += "     BC6.BC6_VIGINI,    									" + CRLF
	_cQuery += "     BC6.BC6_VIGFIM,    									" + CRLF
	_cQuery += "     BC6.BC6_CDNV01,    									" + CRLF
	_cQuery += "     BC6.BC6_CDNV02,    									" + CRLF
	_cQuery += "     BC6.BC6_CDNV03,    									" + CRLF
	_cQuery += "     BC6.BC6_CDNV04,    									" + CRLF
	_cQuery += "     BC6.BC6_NIVEL,     									" + CRLF
	_cQuery += "     BC6.BC6_YRGIMP,    									" + CRLF
	_cQuery += "     BC6.BC6_BANDAP,    									" + CRLF
	_cQuery += "     BC6.BC6_BANDAR,    									" + CRLF
	_cQuery += "     BC6.BC6_PERDES,    									" + CRLF
	_cQuery += "     BC6.BC6_UCO,       									" + CRLF
	_cQuery += "     BC6.BC6_PERACR,    									" + CRLF
	_cQuery += "     BC6.BC6_XPCPFB,    									" + CRLF
	_cQuery += "     BC6.BC6_YEDICA,    									" + CRLF
	_cQuery += "     BC6.BC6_XDCPFB,    									" + CRLF
	_cQuery += "     BC6.BC6_RECREA,    									" + CRLF
	_cQuery += "     BC6.BC6_CODREA     									" + CRLF
	_cQuery += " FROM                   									" + CRLF
	_cQuery += "     " + RetSqlName("BC6") + " BC6							" + CRLF
	_cQuery += " WHERE											    		" + CRLF
	_cQuery += "     BC6.BC6_FILIAL = '" + xFilial("BC6") + "'				" + CRLF

	If _cParam <> "1"

		_cQuery += "     AND BC6.BC6_CODTAB = '" + MV_PAR01 + "'			" + CRLF

		If !Empty(MV_PAR02)
			_cQuery += "     AND BC6.BC6_VIGINI = '" + DTOS(MV_PAR02) + "'	" + CRLF
		EndIf

		If !Empty(MV_PAR03)
			_cQuery += "     AND BC6.BC6_CODRDA = '" + MV_PAR03 + "'		" + CRLF
		EndIf

	Else

		_cQuery += "     AND BC6.BC6_CODTAB = '" + BC5->BC5_CODTAB + "'		" + CRLF
		_cQuery += "     AND BC6.BC6_VIGINI = '" + DTOS(BC5->BC5_DATINI) + "'		" + CRLF
		_cQuery += "     AND BC6.BC6_CODRDA = '" + BC5->BC5_CODRDA + "'		" + CRLF

	EndIf

	_cQuery += "     AND BC6.D_E_L_E_T_ = ' '								" + CRLF

	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)

	While !(_cAlias2)->(EOF())

		IncProc()
		aItem := Array(Len(aHeader))

		For nX := 1 to Len(aHeader)
			If aHeader[nX][2] == "D"
				aItem[nX] := STOD((_cAlias2)->&(aHeader[nX][1]))
			Else
				aItem[nX] := (_cAlias2)->&(aHeader[nX][1])
			EndIf
		Next nX

		AADD(aCols,aItem)
		aItem := {}

		(_cAlias2)->(dbskip())

	EndDo

	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf

Return

/*/{Protheus.doc} fValInf
Fun�ao que ir� validar se os dados est�o corretos.
N�o estando ser� gerado um log dos erros e a importa��o 
n�o ser� conclu�da
@type function
@version  1.0
@author angelo.cassago
@since 16/08/2022
@param aLinha, array, Dados do excel em cada linha
@return _variant, verdadeiro ou falson
/*/
Static Function fValInf(aLinha)

	Local _lRet 	:= .T.

	//---------------------------------------------------------------
	//Se der erro gravar log para que a usu�ria possa
	//corrigir e refazer o processo, mas n�o deve gravar
	//nenhuma informa��o na tabela
	//---------------------------------------------------------------
	//a_ItFim - Vetor que ir� receber os erros
	//Duas posi��es
	//linha e problema

	If Empty(AllTrim(aLinha[_nCODRDA]))

		_lRet 	:= .F.
		AADD(a_ItFim,{nLinhaAtu,"Codigo RDA n�o informado, coluna BC6_CODRDA"})

	EndIf

	If Empty(AllTrim(aLinha[_nCODTAB]))

		_lRet 	:= .F.
		AADD(a_ItFim,{nLinhaAtu,"Codigo da tabela n�o informado, coluna BC6_CODTAP"})

	EndIf

	If Empty(AllTrim(aLinha[_nCODPAD]))

		_lRet 	:= .F.
		AADD(a_ItFim,{nLinhaAtu,"Codigo padr�o n�o informado, coluna BC6_CODPAD"})

	EndIf

	If Empty(AllTrim(aLinha[_nCODPRO]))

		_lRet 	:= .F.
		AADD(a_ItFim,{nLinhaAtu,"Codigo produto n�o informado, coluna BC6_CODPRO"})

	EndIf

	If Empty(AllTrim(aLinha[_nNIVEL ]))

		_lRet 	:= .F.
		AADD(a_ItFim,{nLinhaAtu,"Nivel n�o informado, coluna BC6_NIVEL"})

	EndIf

	If Empty(AllTrim(aLinha[_nVIGINI ]))

		_lRet 	:= .F.
		AADD(a_ItFim,{nLinhaAtu,"Vig�ncia Inicial n�o informada, coluna BC6_VIGINI"})

	EndIf

Return _lRet


/*/{Protheus.doc} CABA100A
Rotina para validar a entrada na rotina
@type function
@version  1.0
@author angelo.cassago
@since 19/10/2022
/*/

Static Function CABA100A(_cOpcio)

	Local _lRet		:= .T.

	Default _cOpcio := "1"

	//--------------------------------------------
	//S� validar se for pelo ponto de entrada
	//--------------------------------------------
	If _cOpcio == "1"

		//-----------------------------------------------------------------------------------
		//Primeiro checar se os dados que ela esta inserindo para o cabe�alho selecionado
		//j� n�o possui dados vinculados
		//-----------------------------------------------------------------------------------
		DbSelectArea("BC6")
		DbSetOrder(1) //BC6_FILIAL+BC6_CODINT+BC6_CODRDA+BC6_CODTAB+BC6_CODPAD+BC6_CODPRO+BC6_NIVEL
		If Dbseek(xFilial("BC6") + BC5->(BC5_CODINT+BC5_CODRDA+BC5_CODTAB))

			Aviso("Aten��o","N�o � poss�vel realizar a importa��o para o registro selecionado pois j� existem dados cadastrados.",{"OK"})

			_lRet := .F.

		EndIf

	EndIf

Return _lRet
