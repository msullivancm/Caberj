#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'APWEBSRV.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'AP5MAIL.CH' 
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA595  �Autor  �Angelo Henrique     � Data �  22/03/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina criada para atender a RN412 ANS.                     ���
���          �Processo de Cancelamento de Plano e retorno de relat�rio    ���
���          �e realiza a inser��o do protocolo de atendimento.           ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA595()

	Local _aArea 		:= GetArea()

	Private _cChvBenef	:= ""
	Private _cCanal		:= ""
	Private _cPerg		:= "CABA595"

	CABA595A(_cPerg)

	If Pergunte(_cPerg,.T.)

		If !(Empty(AllTrim(MV_PAR01)))

			_cChvBenef  := MV_PAR01
			_cPtEnt		:= MV_PAR02
			_cCanal		:= MV_PAR03

			Processa({||U_CABA595B(_cChvBenef, _cPtEnt, _cCanal)},'Processando...')

		Else

			Aviso("Aten��o","Favor preencher a matricula do benefici�rio.",{"OK"})

		EndIf

	EndIf

	RestArea(_aArea)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABR595A  �Autor  �Angelo Henrique     � Data �  17/08/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel pela gera��o das perguntas no relat�rio  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CABA595A(cGrpPerg)

	Local aHelpPor := {} //help da pergunta
	Local _nTamMat := 0
	Local _nTamCan := 0	
	Local _nTamPot := 0	

	_nTamMat := TamSx3("BA1_CODINT")[1]
	_nTamMat += TamSx3("BA1_CODEMP")[1]
	_nTamMat += TamSx3("BA1_MATRIC")[1]

	_nTamCan := TamSx3("ZX_CANAL")[1]
	_nTamPot := TamSx3("ZX_PTENT")[1]


	aHelpPor := {}
	AADD(aHelpPor,"Informe o beneficiario para 	")
	AADD(aHelpPor,"realizar o bloqueio - RN 412	")	

	PutSx1(cGrpPerg,"01","Benefici�rio: ?"			,"a","a","MV_CH1"	,"C",_nTamMat 	,0,0,"G","","CAB595","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","Porta de Entrada: ?"		,"a","a","MV_CH2"	,"C",_nTamPot	,0,0,"G","","PCA1"	,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
	PutSx1(cGrpPerg,"03","Canal: ?"					,"a","a","MV_CH3"	,"C",_nTamCan	,0,0,"G","","PCB"	,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA595B �Autor  �Angelo Henrique     � Data �  22/03/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� executar o cancelamento e eventuais processos���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA595B(_cChvBenef, _cPtEnt, _cCanal)

	Local _aArea 		:= GetArea()
	Local _aArBA1 		:= BA1->(GetArea())
	Local _nCont 		:= 0
	Local _lBlq			:= .F.
	Local _cProtoc		:= ""
	Local _cMsg			:= ""
	Local _lRetorno 	:= .F. //Validacao da dialog criada oDlg
	Local _nOpca 		:= 0 //Opcao da confirmacao
	Local bOk 			:= {|| _nOpca:=1,_lRetorno:=.T.,oDlg:End() } //botao de ok
	Local bCancel 		:= {|| _nOpca:=0,oDlg:End() } //botao de cancelamento
	Local _cArqEmp 		:= "" //Arquivo temporario com as empresas a serem escolhidas	
	Local _cAlias 		:= GetNextAlias()	
	Local _nt 			:= 0	

	Private lInverte 	:= .F. //Variaveis para o MsSelect
	Private cMarca 		:= GetMark() //Variaveis para o MsSelect
	Private oBrwTrb 	:= Nil //objeto do msselect
	Private oDlg 		:= Nil //objeto do msselect
	Private _cAliTmp	:= GetNextAlias()
	Private _aStruTrb 	:= {} //estrutura do temporario
	Private _aBrowse	:= {} //array do browse para demonstracao das empresas
	Private _aEmpMigr 	:= {} //array de retorno com as empresas escolhidas

	//----------------------------------------------------------------------
	//Colocar o MsSelect para selecionar os benefici�rios que ser�o 
	//bloqueados e ter�o o protocolo gerado.
	//Quando for titular a familia inteira ser� bloqueada e um �nico 
	//protocolo ser� gerado.
	//----------------------------------------------------------------------

	//��������������������������������������������������������Ŀ
	//� Define campos do TRB �
	//����������������������������������������������������������

	aadd(_aStruTrb,{"MATRICULA" ,"C",20,0})

	aadd(_aStruTrb,{"NOME" 		,"C",TAMSX3("BA1_NOMUSR")[1],0})

	aadd(_aStruTrb,{"DT_NASC" 	,"D",TAMSX3("BA1_DATNAS")[1],0})

	aadd(_aStruTrb,{"PLANO" 	,"C",TAMSX3("BA1_CODPLA")[1],0})

	aadd(_aStruTrb,{"DESCRICAO" ,"C",TAMSX3("BI3_DESCRI")[1],0})	

	aadd(_aStruTrb,{"OK" 		,"C",02,0})


	//��������������������������������������������������������Ŀ
	//� Define campos do MsSelect �
	//����������������������������������������������������������

	aadd(_aBrowse,{"OK" 		,,"" 					})

	aadd(_aBrowse,{"MATRICULA"	,,"Matricula" 			})

	aadd(_aBrowse,{"NOME"		,,"Nome Beneficiario" 	})

	aadd(_aBrowse,{"DT_NASC" 	,,"Data de Nascimento" 	})

	aadd(_aBrowse,{"PLANO"		,,"Plano" 				})

	aadd(_aBrowse,{"DESCRICAO"	,,"Descricao" 			})	

	If Select(_cAliTmp) > 0

		_cAliTmp->(DbCloseArea())

	Endif

	_cArqEmp := CriaTrab(_aStruTrb)

	dbUseArea(.T.,__LocalDriver,_cArqEmp,_cAliTmp)

	cQuery := " SELECT BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA, "
	cQuery += " BA1.BA1_NOMUSR NOME, BA1.BA1_DATNAS DT_NASC, BA1.BA1_CODPLA PLANO, BI3.BI3_DESCRI DESCRICAO,"
	cQuery += " DECODE(BA1.BA1_TIPUSU,'T','1','D','2') TIPO "
	cQuery += " FROM " + RetSqlName("BA1") + " BA1, " + RetSqlName("BI3") + " BI3 "
	cQuery += " WHERE BA1.D_E_L_E_T_ = ' ' "
	cQuery += " AND BI3.D_E_L_E_T_ = ' ' "
	cQuery += " AND BA1.BA1_FILIAL = '" + xFilial("BA1") + "' "
	cQuery += " AND BI3.BI3_FILIAL = '" + xFilial("BI3") + "' "
	cQuery += " AND BA1.BA1_DATBLO = ' ' "
	cQuery += " AND BA1.BA1_CODPLA = BI3.BI3_CODIGO "	

	//---------------------------------------
	//Parametro de pesquisa por Matricula
	//---------------------------------------
	If !Empty(AllTrim(MV_PAR01))

		cQuery += " AND BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC = '" + AllTrim(MV_PAR01) + "' "

	EndIf	

	cQuery += " ORDER BY MATRICULA, TIPO"

	TCQuery cQuery new Alias (_cAlias)

	While (_cAlias)->(!Eof())

		_nt ++

		IncProc("Analisando Benefici�rio: " + AllTrim(Transform(_nt,"@E 9999999")))

		RecLock(_cAliTmp,.T.)

		(_cAliTmp)->OK 			:= space(2)

		(_cAliTmp)->MATRICULA 	:= (_cAlias)->MATRICULA

		(_cAliTmp)->NOME 		:= (_cAlias)->NOME

		(_cAliTmp)->DT_NASC 	:= STOD((_cAlias)->DT_NASC)

		(_cAliTmp)->PLANO 		:= (_cAlias)->PLANO

		(_cAliTmp)->DESCRICAO 	:= (_cAlias)->DESCRICAO

		MsUnlock()

		(_cAlias)->(DbSkip())

	Enddo

	(_cAlias)->(DbCloseArea())

	@ 001,001 TO 400,700 DIALOG oDlg TITLE OemToAnsi("Beneficiarios para Bloqueio RN-412")

	@ 015,005 SAY OemToAnsi("Selecione os usu�rios que ser�o Bloqueados - RN412: ")

	oBrwTrb := MsSelect():New(_cAliTmp,"OK","",_aBrowse,@lInverte,@cMarca,{025,001,170,350})
	oBrwTrb:bMark := {|| Disp()}	

	Eval(oBrwTrb:oBrowse:bGoTop)

	oBrwTrb:oBrowse:Refresh()

	Activate MsDialog oDlg On Init (EnchoiceBar(oDlg,bOk,bCancel,,)) Centered VALID _lRetorno

	(_cAliTmp)->(DbGotop())

	If _nOpca == 1

		Do While (_cAliTmp)->(!Eof())

			If !Empty((_cAliTmp)->OK) //se usuario marcou o registro

				aAdd(_aEmpMigr,(_cAliTmp)->MATRICULA)

			EndIf

			(_cAliTmp)->(DbSkip())

		EndDo	

		If Len(_aEmpMigr) > 0

			//--------------------------------------------------
			//Rotina para bloquear os benefici�rios
			//--------------------------------------------------
			Processa({||U_CABA595C(_aEmpMigr)},"Bloqueando Benefici�rios...",,.T.)

		EndIf

		//-------------------------------------------------------
		//fecha area de trabalho e arquivo tempor�rio criados
		//-------------------------------------------------------

		If Select(_cAliTmp) > 0

			DbSelectArea(_cAliTmp)

			DbCloseArea()

			Ferase(_cArqEmp+OrdBagExt())

		Endif

	EndIf

	RestArea(_aArea)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � DISP     �Autor  �Angelo Henrique     � Data �  22/03/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� marcar/desmarcar um registro.                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/   
Static Function Disp()

	RecLock((_cAliTmp),.F.)

	If Marked("OK")

		(_cAliTmp)->OK := cMarca

	Else

		(_cAliTmp)->OK := ""

	Endif

	MSUNLOCK()

	oBrwTrb:oBrowse:Refresh()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA595C �Autor  �Angelo Henrique     � Data �  22/03/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� montar os benefici�rios que ir�o ser         ���
���          �bloqueados pelo processo da RN412.                          ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA595C(_aEmpMigr)

	Local _nz 		:= 0
	Local _aArBA1 	:= BA1->(GetArea())
	Local _aArSZX 	:= SZX->(GetArea())
	Local _aArSZY 	:= SZY->(GetArea())
	Local _cTel  	:= ""
	Local _cHora	:= "" 
	Local _nOpc 	:= 0
	Local _aLinha 	:= {}  
	Local _nCont 	:= 0

	Private _cMail	:= SPACE(TAMSX3("BA1_EMAIL" )[1])
	Private _cNwTel	:= SPACE(60) //Somando os tr�s campos de telefones criados na BA1

	SetPrvt("oFont1","oFont2"	,"oFont3"	,"oDlg1"	,"oPanel1"	,"oSay1"	)
	SetPrvt("oGrp1"	,"oSay2"	,"oSay3"	,"oSay4"	,"oSay9" 	,"oGrp2"	)
	SetPrvt("oSay5"	,"oSay6"	,"oSay7"	,"oSay8"	,"oGet1"	,"oGet2"	)
	SetPrvt("oBtn1"	,"oSay11"	,"oSay12"	,"oSay13"	,"oSay14"	,"oSay15"	)

	oFont1     := TFont():New( "MS Sans Serif",0,-19,,.F.,0,,400,.F.,.F.,,,,,, 	)
	oFont2     := TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, 	)
	oFont3     := TFont():New( "MS Sans Serif",0,-13,,.F.,0,,400,.F.,.F.,,,,,, 	)

	ProcRegua(Len(_aEmpMigr))

	For _nz := 1 to Len(_aEmpMigr)

		IncProc("Bloqueando Benefici�rio: " + AllTrim(Transform(_nz,"@E 9999999")) + " de: " + AllTrim(Transform(Len(_aEmpMigr),"@E 9999999")))

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + _aEmpMigr[_nz])

			//----------------------------------------------------------
			//Confirmo se o benefici�rio esta realmente bloqueado
			//Caso n�o esteja bloqueado tento mais 3 vezes
			//se n�o conseguir paro o processamento do bloqueio
			//---------------------------------------------------------- 
			If Empty(BA1->BA1_DATBLO)

				//------------------------------------------
				//Rotina de bloqueio de benefici�rio
				//------------------------------------------
				u_CABA595D(_aEmpMigr[_nz])

				DbSelectArea("BA1")
				DbSetOrder(2)
				If DbSeek(xFilial("BA1") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))

					//----------------------------------------------------------
					//Confirmo se o benefici�rio esta realmente bloqueado
					//Caso n�o esteja bloqueado tento mais 3 vezes
					//se n�o conseguir paro o processamento do bloqueio
					//---------------------------------------------------------- 
					If Empty(BA1->BA1_DATBLO)

						_lBlq := .F. //Refor�ando que a vari�vel ser� zerada.

						While _nCont < 4

							//------------------------------------------
							//Rotina de bloqueio de benefici�rio
							//------------------------------------------
							u_CABA595D(_aEmpMigr[_nz])

							DbSelectArea("BA1")
							DbSetOrder(2)
							If DbSeek(xFilial("BA1") + _aEmpMigr[_nz])

								If !Empty(BA1->BA1_DATBLO)

									_lBlq := .T.
									Exit

								EndIf

							EndIf

							_nCont ++

						EndDo

					Else

						_lBlq := .T.

					EndIf

					//------------------------------------------------------------------------------------
					//Se bloqueou ir� continuar com o processamento
					//------------------------------------------------------------------------------------
					//Neste momento ser� criado o Protocolo de Atendimento
					//------------------------------------------------------------------------------------
					If _lBlq

						_nCont := 0

						//------------------------------------------
						//Cria��o do Protocolo de Atendimento
						//------------------------------------------					
						While _nCont < 4

							_cProtoc := u_CABA595E(_aEmpMigr[_nz],_cPtEnt, _cCanal) 

							If  !(Empty(AllTrim(_cProtoc)))

								Exit

							EndIf

							_nCont ++

						EndDo

						//--------------------------------------------------------------------
						//Valida��o para saber se o protocolo foi gerado
						//Caso n�o seja poss�vel a rotina ir� exibir a mensagem 
						//para que o usuario continue o processo de forma manual.
						//--------------------------------------------------------------------
						If !Empty(AllTrim(_cProtoc))

							_cTel := "" //Zerando a vari�vel

							//--------------------------------------------------------------------
							//Se conseguiu criar o protocolo continuo com o processamento
							//Relat�rio	
							//--------------------------------------------------------------------
							//Aviso("Aten��o","Protocolo Gerado: " + _cProtoc,{"OK"})

							DbSelectArea("SZX")
							DbSetOrder(1)
							If DbSeek(xFilial("SZX") + _cProtoc)

								DbSelectArea("BA1")
								DbSetOrder(2)
								If DbSeek(xFilial("BA1") + SZX->(ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO))

									//--------------------------------------------------------
									//Pegando as informa��es pertinentes ao protocolo
									//--------------------------------------------------------
									_cHora := SUBSTR(SZX->ZX_HORADE,1,2) + ":" + SUBSTR(SZX->ZX_HORADE,3,2)

									If !Empty(BA1->BA1_TELEFO)

										_cTel  := BA1->BA1_TELEFO

									EndIf

									If !Empty(BA1->BA1_YTEL2)

										If !Empty(_cTel)

											_cTel  += " ; "

										EndIf

										_cTel  += BA1->BA1_YTEL2													

									EndIf

									If !Empty(BA1->BA1_YCEL)

										If !Empty(_cTel)

											_cTel  += " ; "

										EndIf

										_cTel  += BA1->BA1_YCEL  

									EndIf

									oDlg1      := MSDialog():New( 092,232,699,927,"Cancelamento de Plano - RN 412",,,.F.,,,,,,.T.,,,.T. )
									oPanel1    := TPanel():New( 004,004,"",oDlg1,,.F.,.F.,,,336,292,.T.,.F. )
									oSay1      := TSay():New( 008,112,{||"Encerramento do Plano"},oPanel1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,108,012)

									oGrp1      := TGroup():New( 024,004,124,332,"  Dados do Bloqueio  ",oPanel1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
									oSay2      := TSay():New( 044,012,{||"Numero do Protocolo: " 	+ SZX->ZX_SEQ + ". "				},oGrp1,,oFont3,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,204,008)
									oSay3      := TSay():New( 056,012,{||"Data do Protocolo: " 		+ DTOC(SZX->ZX_DATDE) + ". "		},oGrp1,,oFont3,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,104,008)
									oSay4      := TSay():New( 068,012,{||"Hora do Protocolo: " 		+ _cHora + ". "						},oGrp1,,oFont3,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,084,008)
									oSay9      := TSay():New( 080,012,{||"E-mail Atual: " 			+ ALLTRIM(BA1->BA1_EMAIL) + ". "	},oGrp1,,oFont3,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,308,008)
									oSay10     := TSay():New( 092,012,{||"Telefone Atual: " 		+ _cTel + ". "						},oGrp1,,oFont3,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,312,008)

									oSay14     := TSay():New( 104,012,{||"Aten��o, caso seja solicitado o bloqueio do Titular, a Fam�lia inteira ser� bloqueada."			},oGrp1,,oFont3,.F.,.F.,.F.,.T.,CLR_HRED ,CLR_WHITE,304,008)
									oSay15     := TSay():New( 112,012,{||"Neste caso ser� gerado apenas um �nico protocolo de atendimento."									},oGrp1,,oFont3,.F.,.F.,.F.,.T.,CLR_HRED ,CLR_WHITE,252,008)

									//--------------------------------------------------------------------------------------------------------------------------
									//Parte da Tela onde � informado as informa��es de envio de e-mail e atualiza��o do cadastro na BA1 e BTS
									//--------------------------------------------------------------------------------------------------------------------------
									oGrp2      := TGroup():New( 132,004,256,332,"  Envio de E-mail / Atualiza��o Cadastral:  ",oPanel1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

									oSay5      := TSay():New( 148,012,{||"Confirme os dados abaixo para encaminhar o e-mail do protocolo de cancelamento de plano."			},oGrp2,,oFont3,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,304,012)
									oSay6      := TSay():New( 160,012,{||"Caso os dados sejam alterados nesta tela, essas informa��es ser�o  atualizadas no benefici�rio."	},oGrp2,,oFont3,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,316,008)

									oSay7      := TSay():New( 180,012,{||"E-mail: "		},oGrp2,,oFont2,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
									oSay8      := TSay():New( 208,012,{||"Telefone: "	},oGrp2,,oFont2,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)

									oSay11     := TSay():New( 220,100,{||"ATEN��O AO PREENCHER O CAMPO TELEFONE!!"															},oGrp2,,oFont3,.F.,.F.,.F.,.T.,CLR_HRED ,CLR_WHITE,164,008)
									oSay12     := TSay():New( 232,012,{||"-> � POSS�VEL INCLUIR AT� TR�S NOVOS NUMEROS."													},oGrp2,,oFont3,.F.,.F.,.F.,.T.,CLR_HRED ,CLR_WHITE,308,008)
									oSay13     := TSay():New( 244,012,{||"-> EXEMPLO: 21999999999 ; 21999999999 ; 21999999999 - SEPARADO POR PONTO E VIRGULA (;)"			},oGrp2,,oFont3,.F.,.F.,.F.,.T.,CLR_HRED ,CLR_WHITE,316,008)

									//-----------------------------------------------------------------
									//Atualizando as variaveis para serem apresentadas em tela
									//-----------------------------------------------------------------
									_cMail	   := BA1->BA1_EMAIL
									_cNwTel	   := _cTel
									//-----------------------------------------------------------------

									oGet1      := TGet():New( 176,048,{|u| If(PCount()==0,_cMail	,_cMail:=u	)},oGrp2,256,012,'',,CLR_BLACK,CLR_WHITE,oFont2,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","_cMail"	,,)
									oGet2      := TGet():New( 204,048,{|u| If(PCount()==0,_cNwTel	,_cNwTel:=u	)},oGrp2,256,012,'',,CLR_BLACK,CLR_WHITE,oFont2,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","_cNwTel",,)																	

									oBtn1      := TButton():New( 272,268,"Confirmar",oPanel1,{||IIF(ValdTl(),(oDlg1:End(),_nOpc := 1), .F.)},064,012,,,,.T.,,"",,,,.F. )

									oDlg1:Activate(,,,.T.)

									//-------------------------------------------------------------------
									//Validar se pelo menos o campo do e-mail esta preenchido para 
									//enviar e-mail 
									//-------------------------------------------------------------------
									If _nOpc = 1 

										//------------------------------------------
										// INICIO - Atualizar informa��es na BA1
										//------------------------------------------
										RecLock("BA1", .F.)

										BA1->BA1_EMAIL := _cMail

										If !(Empty(_cNwTel))

											_aLinha := StrTokArr(_cNwTel , ";" )

											If Len(_aLinha) = 1

												BA1->BA1_TELEFO  :=  _aLinha[1]

											ElseIf Len(_aLinha) = 2

												BA1->BA1_YTEL2 := _aLinha[2]

											ElseIf Len(_aLinha) = 3

												BA1->BA1_YCEL := _aLinha[3]

											EndIf											   

										EndIf

										BA1->(MsUnLock())	

										//------------------------------------------
										// FIM - Atualizar informa��es na BA1
										//------------------------------------------

										//------------------------------------------
										//Envio do E-mail gerado para o benefici�rio
										//------------------------------------------
										U_CABA595F(_cProtoc)

										//------------------------------------------
										//Pergunta se quer gerar o relat�rio para 
										//atendimento presencial 
										//------------------------------------------
										If MSGYESNO("Deseja gerar o relat�rio para entrega ao benefici�rio?","ATEN��O")

											U_CABA595G(_cProtoc)

										EndIf

										//------------------------------------------
										//Envio do E-mail gerado para as �reas  
										//------------------------------------------
										U_CABA595F(_cProtoc,"1")


									EndIf

								EndIf

							EndIf

						Else

							_cMsg := "N�o foi poss�vel realizar a cria��o do protocolo de atendimento." 
							_cMsg += "O benefici�rio foi bloqueado como solicitado."
							_cMsg += "Favor realizar o processo de forma manual:"
							_cMsg += " - Criar o protocolo de atendimento."
							_cMsg += " - Gerar o relat�rio de T�tulos em Aberto."

							Aviso("Aten��o", _cMsg, {"OK"})

						EndIf

					Else

						_cMsg := "N�o foi poss�vel realizar o bloqueio deste benefici�rio, favor realizar o processo de forma manual"

						Aviso("Aten��o", _cMsg, {"OK"})

					EndIf

				EndIf

			Else

				//---------------------------------------------------------------------
				//Caso seja a primeira vez e o benefici�rio esteja bloqueado
				//ser� exebida a mensagem de benefici�rio bloqueado
				//---------------------------------------------------------------------
				If _nz = 1

					Aviso("Aten��o","Benefici�rio j� encontra-se bloqueado.",{"OK"})

				EndIf

			EndIf

		Else

			Aviso("Aten��o","Benefici�rio n�o localizado, favor verificar.",{"OK"})

		EndIf

	Next _nz

	RestArea(_aArSZY)
	RestArea(_aArSZX)
	RestArea(_aArBA1)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA595D �Autor  �Angelo Henrique     � Data �  22/03/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� executar o bloqeuio do beneficiario.         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function  CABA595D(_cChvBenf)

	Local _aArea	:= GetArea()
	Local (cAliQry) := GetNextAlias()	
	Local cQry		:= ""
	Local _nTamCd 	:= TamSX3("BA1_CODINT")[1] 				//Contador do BA1_CODINT
	Local _nTamEp 	:= _nTamCd + 1							//Contador do BA1_CODEMP
	Local _nTamMt 	:= _nTamEp + TamSX3("BA1_CODEMP")[1] 	//Contador do BA1_MATRIC
	Local _nTamRg 	:= _nTamMt + TamSX3("BA1_MATRIC")[1] 	//Contador do BA1_TIPREG
	Local _nTamDg 	:= _nTamRg + TamSX3("BA1_TIPREG")[1] 	//Contador do BA1_DIGITO	
	Local _aArBA1	:= BA1->(Getarea())	
	Local _cMvFam	:= ""
	Local _cMvUsu	:= "" 

	If cEmpAnt == "01"

		_cMvFam	:= GetNewPar("MV_XBQFAM","844") 
		_cMvUsu	:= GetNewPar("MV_XBQUSU","075") 

	Else

		_cMvFam	:= GetNewPar("MV_XBQFAM","996")
		_cMvUsu	:= GetNewPar("MV_XBQUSU","094")

	EndIf		

	cQry += " SELECT " 	+ CRLF
	cQry += " 	BA1.BA1_CODINT, BA1.BA1_CODEMP, BA1.BA1_MATRIC, BA1.BA1_TIPREG,  " 							+ CRLF 
	cQry += " 	BA1.BA1_DIGITO, BA1.BA1_TIPUSU, " 															+ CRLF
	cQry += " 	BA1.R_E_C_N_O_ RECNO " 																		+ CRLF
	cQry += " FROM " + RetSqlName('BA1') + " BA1" 															+ CRLF
	cQry += " INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3_FILIAL = '" + xFilial('BA3') + "' " 			+ CRLF
	cQry += " 	AND BA3.BA3_CODINT = BA1.BA1_CODINT" 														+ CRLF
	cQry += " 	AND BA3.BA3_CODEMP = BA1.BA1_CODEMP" 														+ CRLF
	cQry += " 	AND BA3.BA3_MATRIC = BA1.BA1_MATRIC" 														+ CRLF
	cQry += " 	AND BA3.D_E_L_E_T_ = ' '" 																	+ CRLF
	cQry += " WHERE BA1.BA1_FILIAL = '" + xFilial('BA1') + "' " 											+ CRLF	
	cQry += " 	AND BA1.BA1_CODINT = '" + SUBSTR(_cChvBenf,1		,TamSX3("BA1_CODINT")[1]) + "' "		+ CRLF
	cQry += " 	AND BA1.BA1_CODEMP = '" + SUBSTR(_cChvBenf,_nTamEp	,TamSX3("BA1_CODEMP")[1]) + "' "		+ CRLF
	cQry += " 	AND BA1.BA1_MATRIC = '" + SUBSTR(_cChvBenf,_nTamMt	,TamSX3("BA1_MATRIC")[1]) + "' "		+ CRLF
	cQry += " 	AND BA1.BA1_TIPREG = '" + SUBSTR(_cChvBenf,_nTamRg	,TamSX3("BA1_TIPREG")[1]) + "' "		+ CRLF
	cQry += " 	AND BA1.BA1_DIGITO = '" + SUBSTR(_cChvBenf,_nTamDg	,TamSX3("BA1_DIGITO")[1]) + "' "		+ CRLF
	cQry += " 	AND BA1.BA1_DATBLO = ' '" 																	+ CRLF
	cQry += " 	AND BA1.D_E_L_E_T_ = ' '" 																	+ CRLF

	TcQuery cQry New Alias (cAliQry)

	While !(cAliQry)->(EOF())

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + (cAliQry)->BA1_CODINT + (cAliQry)->BA1_CODEMP + (cAliQry)->BA1_MATRIC + (cAliQry)->BA1_TIPREG + (cAliQry)->BA1_DIGITO)

			//-------------------------------------------------------------------------------
			//Refo�ando aqui a valida��o do bloqueio, porque sea primeira linha for t�tular
			//a rotina ir� bloquear toda a familia logo n�o haver� necessidade de executar
			//a rotina de bloqueia para o dependente.
			//-------------------------------------------------------------------------------
			If Empty(BA1->BA1_DATBLO)

				If BA1->BA1_TIPUSU == "T"
															
					//---------------------------------------------------------------------------------------------------
					//Bloqueio e desbloqueio da familia e grupo familiar
					//---------------------------------------------------------------------------------------------------
					//PL260BLOCO(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,nP20,aLog,lGrav,lblqAut, lMsg)
					//---------------------------------------------------------------------------------------------------
					// cMotivo - Visualizar a tabela de Motivo de bloqueio Familia (BG1)
					//---------------------------------------------------------------------------------------------------
					PL260BLOCO("BA1", BA1->(Recno()),4,.T.,_cMvFam,dDataBase,"1",,,,.F.,.F.)

					//----------------------------------------------------------------------------------
					//Efetua o bloqueio e desbloqueio de familias que fazem parte do grupo familiar
					//----------------------------------------------------------------------------------
					PlsGrpFam(.F.,.T.,BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATRIC)

				Else

					//---------------------------------------------------------------------------------------------------
					//Bloquear/Desbloquear Usuario
					//---------------------------------------------------------------------------------------------------
					//PL260BLOUS(cAlias,nReg,nOpc,lDireto,cMotivo,dData,cBloFat,lFiltro,nP20,aLog,lGrav,lMsg)
					//---------------------------------------------------------------------------------------------------
					// cMotivo - Visualizar a tabela de Motivo de bloqueio Usu�rio (BG3)
					//---------------------------------------------------------------------------------------------------
					PL260BLOUS("BA1", BA1->(Recno()), 4, .T.,_cMvUsu,dDataBase,"1")

				EndIf								

			EndIf

		EndIf

		(cAliQry)->(DbSkip())

	EndDo

	(cAliQry)->(DbCloseArea())

	RestArea(_aArBA1)
	RestArea(_aArea)

Return 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA595E �Autor  �Angelo Henrique     � Data �  22/03/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� executar a cria��o do protocolo de atendimento��
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA595E(_cChvBenf, _cPtEnt, _cCanal) 

	Local _nSla 	:= 0
	Local _cSeq		:= ""
	Local _cCdAre	:= ""
	Local _cDia		:= ""
	Local _cCntPA	:= ""	
	Local _cRegAns	:= ""
	Local _aArea 	:= GetArea()
	Local _aArZX 	:= SZX->(GetArea())
	Local _aArZY 	:= SZY->(GetArea())
	Local _aArB1 	:= BA1->(GetArea())	
	Local _aArBI 	:= BI3->(GetArea())
	Local _aArCG 	:= PCG->(GetArea())
	Local _aArBL 	:= PBL->(GetArea())
	Local _aArBC 	:= BCA->(GetArea())
	Local _aArPF 	:= PCF->(GetArea())		
	Local _cTpSv	:= "1005" //Exclus�o do Plano
	Local _cDia	 	:= GetMV("MV_XDIAPA" ) //Possui a data atual da PA
	Local _cCntPA	:= GetMV("MV_XCNTPA" ) //Possui o contador atual da PA
	Local _cRegAns 	:= GetMV("MV_XREGANS") //Possui o n�mero do registro na ANS
	Local _cTpDm	:= "T" //Solicita��o (SX5) Tipo da Demanda
	Local _cHst 	:= "000132" //Motivos Particulares
	Local _cAgenc	:= "" //Descri��o da Area respons�vel
	Local cAliQry	:= GetNextAlias()
	Local cQry 		:= ""

	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + _cChvBenf)		
		
		/*
		//------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 06/12/2017
		//------------------------------------------------------------------------------------------
		//Mudan�a no processo de gera��o do sequencial
		//conforme RN 395 - ANS
		//Novo sequencial ser� composto de:
		//------------------------------------------------------------------------------------------
		//XXXXXXAAAAMMDDNNNNNN
		//------------------------------------------------------------------------------------------
		//XXXXXX = REGISTRO DA ANS DA OPERADORA
		//AAAA = ANO
		//MM = MES
		//DD = DIA
		//NNNNNN = SEQUENCIAL QUE IDENTIFIQUE A ORDEM DE ENTRADA DA RECLAMA��O NA OPERADORA		
		//------------------------------------------------------------------------------------------	

		_cCntPA := SOMA1(_cCntPA)

		PUTMV("MV_XCNTPA",_cCntPA) //Colocando para o Webservice sempre contar um a mais

		If cValToChar(Day(dDatabase)) <> _cDia

			_cCntPA	 := SOMA1("000000")

			PUTMV("MV_XDIAPA",cValToChar(Day(dDatabase)))				
			PUTMV("MV_XCNTPA",_cCntPA)											

		EndIf

		_cSeq := _cRegAns + DTOS(dDatabase) + _cCntPA
		*/
		_cSeq := u_GerNumPA() // Gera��o de n�mero da PA

		//------------------------------------------
		//Pegando a quantidade de SLA
		//------------------------------------------
		DbSelectArea("PCG")
		DbSetOrder(1)
		If DbSeek(xFilial("PCG") + PADR(AllTrim(_cTpDm),TAMSX3("PCG_CDDEMA")[1]) + _cPtEnt + _cCanal + PADR(AllTrim(_cTpSv),TAMSX3("PCG_CDSERV")[1]) )

			_nSla := PCG->PCG_QTDSLA

		Else

			_nSla := 0

		EndIf

		//----------------------------------------------
		//Ponterar na Tabela de PBL (Tipo de Servi�o)
		//Pegando assim a Area
		//----------------------------------------------
		DbSelectArea("PBL")
		DbSetOrder(1)
		If DbSeek(xFilial("PBL") + PADR(AllTrim(_cTpSv),TAMSX3("PBL_YCDSRV")[1]))

			_cCdAre := PBL->PBL_AREA

			//-----------------------------------------
			//Pegando a Descri��o da area respons�vel
			//-----------------------------------------
			DbSelectArea("PCF")
			DbSetOrder(1)
			If DbSeek(xFilial("PCF") + PADR(AllTrim(PBL->PBL_AREA),TAMSX3("PCF_COD")[1]))

				_cAgenc := PCF->PCF_DESCRI				

			EndIf

		EndIf

		//------------------------------------------------------------------------------
		//Inicio do Processo de leitura das informa��es encaminhadas para grava��o
		//------------------------------------------------------------------------------

		DbSelectArea("SZX")
		DbSetOrder(1)
		_lAchou := DbSeek( xFilial("SZX") + _cSeq)	

		While _lAchou 

			_cCntPA	:= GetMV("MV_XCNTPA")

			PUTMV("MV_XCNTPA",SOMA1(_cCntPA))

			_cSeq := _cRegAns + DTOS(dDatabase) + _cCntPA 

			//-----------------------------------
			//Cabe�alho
			//-----------------------------------
			DbSelectArea("SZX")
			DbSetOrder(1)
			_lAchou := DbSeek( xFilial("SZX") + _cSeq)				

		EndDo 

		RecLock("SZX",.T.)

		SZX->ZX_FILIAL 	:= xFilial("SZX") 
		SZX->ZX_SEQ 	:= _cSeq
		SZX->ZX_DATDE 	:= dDataBase
		SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")		
		SZX->ZX_NOMUSR 	:= BA1->BA1_NOMUSR
		SZX->ZX_CODINT 	:= BA1->BA1_CODINT
		SZX->ZX_CODEMP 	:= BA1->BA1_CODEMP
		SZX->ZX_MATRIC 	:= BA1->BA1_MATRIC
		SZX->ZX_TIPREG 	:= BA1->BA1_TIPREG
		SZX->ZX_DIGITO 	:= BA1->BA1_DIGITO
		SZX->ZX_TPINTEL	:= "1" 		//Status em aberto
		SZX->ZX_YDTNASC	:= BA1->BA1_DATNAS
		SZX->ZX_EMAIL 	:= BA1->BA1_EMAIL
		SZX->ZX_CONTATO	:= AllTrim(BA1->BA1_TELEFO) + " - " + AllTrim(BA1->BA1_YTEL2) + " - " + AllTrim(BA1->BA1_YCEL) 
		SZX->ZX_YPLANO 	:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
		SZX->ZX_TPDEM	:= _cTpDm 	//Tipo de Demanda
		SZX->ZX_CANAL	:= _cCanal  //Canal selecionado no momento da montagem da rotina
		SZX->ZX_SLA  	:= _nSla	//SLA			
		SZX->ZX_PTENT 	:= _cPtEnt  //Porta de Entrada 
		SZX->ZX_CODAREA := _cCdAre	//Codigo da Area
		SZX->ZX_YAGENC	:= _cAgenc  //Descri��o da Ag�ncia
		SZX->ZX_VATEND	:= "3"    	//Seguindo o protocolo anterior (Novo PA n�o utiliza este campo)
		SZX->ZX_TPATEND := "1"		
		SZX->ZX_CPFUSR	:= BA1->BA1_CPFUSR
		SZX->ZX_PESQUIS	:= "4" //N�O AVALIADO
		
		If _cPtEnt == "000012"
		
			SZX->ZX_USDIGIT := "WEB"
		
		EndIf
		
		// FRED: equalizado os campos
		//If cEmpAnt = "01"
			SZX->ZX_YDTINC	:= dDataBase
		/*
		Else
			SZX->ZX_YDTINIC	:= dDataBase
		EndIf
		*/
		// FRED: fim altera��o
		
		SZX->ZX_RN412	:= "S" 		//Sim para facilitar a RN 412 nos processos de relat�rios e filtros
		SZX->ZX_USDIGIT := CUSERNAME//Usu�rio que realizou a opera��o 

		SZX->(MsUnLock())

		//-----------------------------------
		//Itens
		//-----------------------------------
		DbSelectArea("SZY")

		RecLock("SZY",.T.)

		SZY->ZY_FILIAL 	:= xFilial("SZY") 
		SZY->ZY_SEQBA	:= _cSeq
		SZY->ZY_SEQSERV	:= "000001"
		SZY->ZY_DTSERV	:= dDataBase	
		SZY->ZY_HORASV	:= STRTRAN(TIME(),":","")
		SZY->ZY_TIPOSV	:= _cTpSv	
		SZY->ZY_OBS		:= "Solicitado o cancelamento do plano, este protocolo foi criado automaticamente pela rotina. Conforme RN 412, o cancelamento foi efetuado de forma autom�tica ap�s a solicita��o do benefici�rio."		
		SZY->ZY_HISTPAD	:= _cHst //000132
		SZY->ZY_PESQUIS := "4" //N�O AVALIADO
		
		If _cPtEnt == "000012"
		
			SZY->ZY_USDIGIT	:= "WEB"
		
		EndIf
		
		SZY->(MsUnLock())


		//---------------------------------------------------
		//Gravar informa��es na tabela de bloqueio
		//---------------------------------------------------
		If BA1->BA1_TIPUSU = "T" //Como � bloqueio de familia deve ser alimentado todas as linhas desse benefici�rio 

			cQry += " SELECT " 																			+ CRLF
			cQry += " 	BCA.BCA_MATRIC, BCA_TIPREG, BCA.BCA_DATA, BCA.BCA_TIPO" 						+ CRLF 		
			cQry += " FROM " + RetSqlName('BCA') + " BCA" 												+ CRLF		
			cQry += " WHERE BCA.BCA_FILIAL = '" + xFilial('BCA') + "' " 								+ CRLF					
			cQry += " 	AND BCA.BCA_MATRIC = '" + BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC) + "' "	+ CRLF
			cQry += " 	AND BCA.BCA_DATA = '" +  DTOS(BA1->BA1_DATBLO) + "' "							+ CRLF
			cQry += " 	AND BCA.BCA_TIPO = '0' "														+ CRLF					
			cQry += " 	AND BCA.D_E_L_E_T_ = ' '" 														+ CRLF

			TcQuery cQry New Alias (cAliQry)

			While !(cAliQry)->(EOF())

				DbSelectArea("BCA")
				DbSetOrder(1)
				If DbSeek(xFilial("BCA") + (cAliQry)->(BCA_MATRIC + BCA_TIPREG + BCA_DATA + BCA_TIPO ))

					If Empty(BCA->BCA_OBS)

						RecLock("BCA", .F.)

						BCA->BCA_OBS := "Solicitado pelo protocolo: " + _cSeq

						BCA->(MsUnLock())

					EndIf

				EndIf

				(cAliQry)->(DbSkip())

			EndDo

			(cAliQry)->(DbCloseArea())

		Else

			//-------------------------------------------------------------------------
			//Se for individual por dependente onde ser� gerado um protocolo 
			//para cada, o processo muda, n�o permitindo assim que a BCA que
			//j� foi acrescentada o protocolo n�o seja alterada
			//-------------------------------------------------------------------------
			DbSelectArea("BCA")
			DbSetOrder(1) //BCA_FILIAL+BCA_MATRIC+BCA_TIPREG+DTOS(BCA_DATA)+BCA_TIPO
			If DbSeek(xFilial("BCA") + BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG) + DTOS(BA1->BA1_DATBLO) + "0" )

				If Empty(BCA->BCA_OBS)

					RecLock("BCA", .F.)

					BCA->BCA_OBS := "Solicitado pelo protocolo: " + _cSeq

					BCA->(MsUnLock())

				EndIf

			EndIf

		EndIf		

	EndIf	

	RestArea(_aArPF)
	RestArea(_aArBC)
	RestArea(_aArBL)	
	RestArea(_aArCG) 	
	RestArea(_aArZX)
	RestArea(_aArZY)
	RestArea(_aArB1)
	RestArea(_aArBI)
	RestArea(_aArea)

Return _cSeq


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � ValdTl   �Autor  �Angelo Henrique     � Data �  26/04/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� validar os campos preenchidos no envio de    o��
���          �e-mail                                                      ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function ValdTl

	Local _lRet := .T.
	Local _cMsg := ""

	If Empty(_cMail) 

		_cMsg := "Campo e-mail n�o esta preenchido, favor preencher para que o e-mail possa ser enviado."

		Aviso("Aten��o",_cMsg,{"OK"})

		_lRet := .F.

	EndIf

	If Empty(_cNwTel)	   

		_cMsg := "Campo telefone n�o esta preenchido." + CRLF
		_cMsg += "N�o impede o envio do e-mail, mais o mesmo n�o ser� gravado no benefici�rio" + CRLF
		_cMsg += "Caso queira atualizar o telefone ap�s este processo, encaminhe a demanda para o setor de CADASTRO." + CRLF

		Aviso("Aten��o",_cMsg,{"OK"})

	EndIf

Return _lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CABA595F �Autor  �Angelo Henrique     � Data �  26/04/2017 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que ir� enviar e-mail para o benefici�rio.           o��
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CABA595F(_cParam, _cParam2)

	Local _aArea 	:= GetArea()
	Local _aArBa1	:= BA1->(GetArea()) 
	Local _aArSZX	:= SZX->(GetArea())
	Local _aArSZY	:= SZY->(GetArea())
	Local _aArBI3	:= BI3->(GetArea())
	Local a_Htm		:= "" //Variavel que ir� receber o template do HTML a ser utilizado.
	Local _cTpSrv	:= "" //Primeiro tipo de servi�o criado no protocolo
	Local _nCntZy 	:= 0  //Contador utilizado para pegar o pr�ximo n�mero sequencial do protocolo
	Local _cTpSv 	:= "" //Tipo de Servi�o gravado no protocolo
	Local _cHst		:= "" //Hist�rico Padr�o gravado no protocolo 
	Local _cAlias 	:= GetNextAlias()	 
	Local cQuery	:= ""
	Local _cDscPln	:= "" //Descri��o do plano do benefici�rio
	Local _cMat 	:= "" //Matricula do benefici�rio que abriu o protocolo
	Local _cTexto 	:= "" //Vari�vel que ir� receber os benefici�rios bloqueados
	Local c_To		:= _cMail //Pegando o e-mail digitado na tela
	Local c_CC		:= ""
	Local c_Assunto := "Encerramento de Plano"
	Local a_Msg		:= {}	
	Local _cCanDp	:= ""	
	Local _cEmArea	:= GetNewPar("MV_XEMAREA","hugo.paiva@caberj.com.br")

	Default _cParam := ""
	Default _cParam2:= "" //Utilizado para montar o layout do e-mail das �reas

	//NESTA ROTINA DEVO ENTRAR NO PROTOCOLO, PEGAR AS INFORMA��ES DELE PARA MONTAR O HTML.
	//DEVO VISUALIZAR SE � REFERENTE A TITULAR O BLOQUEIO E DESTA FORMA PEGAR TODOS OS
	//BENEFICI�RIOS QUE FORAM BLOQUEADOS NA MESMA DATA DO TITULAR E PREENCHER NO HTML

	If !Empty(_cParam)

		//Abrindo o protocolo de atendimento
		DbSelectArea("SZX")
		DbSetOrder(1)
		If DbSeek(xFilial("SZX") + _cParam )

			If Empty(_cParam2)

				If cEmpAnt == "01"

					If SZX->ZX_CODEMP $ "0024|0025|0027|0028"

						a_Htm := "\HTML\PAPREF412.HTML"

					Else   

						a_Htm := "\HTML\PAGERAL412.HTML"

					Endif

				Else

					a_Htm := "\HTML\PAINTEGRAL412.HTML"

				EndIf

			Else

				a_Htm := "\HTML\RN412.HTML" //TEMPLATE criado para as areas

			EndIf

			//----------------------------------------------------------------
			//Caso o protocolo seja para um benefici�rio registrado 
			//ir� pegar informa��es pertinentes ao plano, 
			//caso contr�rio n�o ir� preenche-lo
			//----------------------------------------------------------------
			DbSelectArea("BA1")
			DbSetOrder(2)
			If DbSeek(xFilial("SZX") + SZX->ZX_CODINT + SZX->ZX_CODEMP + SZX->ZX_MATRIC + SZX->ZX_TIPREG + SZX->ZX_DIGITO)

				_cMat := SZX->ZX_CODINT + "." + SZX->ZX_CODEMP + "." + SZX->ZX_MATRIC + "-" + SZX->ZX_TIPREG + "." + SZX->ZX_DIGITO

				DbSelectArea("BI3")
				DbSetOrder(1) //BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
				If DbSeek(xFilial("BI3") + BA1->BA1_CODINT + BA1->BA1_CODPLA)

					_cDscPln := AllTrim(BI3->BI3_DESCRI)

				Else

					_cDscPln := ""

				EndIf

				//------------------------------------------------------------------------------------------------------------------------
				//Query utilizada para pegar os benefici�rios que foram bloqueados no processo
				//caso a solicita��o tenha partido do titular, onde pela regra da CABERJ
				//ao bloquear o t�tular a familia inteira � bloqueada
				//------------------------------------------------------------------------------------------------------------------------				
				cQuery := " SELECT " 																						+ CRLF
				cQuery += "   TRIM(BA1.BA1_NOMUSR) NOME, " 																	+ CRLF
				cQuery += "   BA1.BA1_CODPLA PLANO, " 																		+ CRLF
				cQuery += "   TRIM(BI3.BI3_DESCRI) DESC_PLAN, " 															+ CRLF
				cQuery += "   BA1_CODINT||'.'||BA1_CODEMP||'.'||BA1_MATRIC||'-'||BA1_TIPREG||'.'||BA1_DIGITO MATRICULA " 	+ CRLF
				cQuery += " FROM  " 																						+ CRLF
				cQuery += "   " + RetSqlName("BA1") + " BA1 " 																+ CRLF
				cQuery += "   INNER JOIN  " 																				+ CRLF
				cQuery += "     " + RetSqlName("BI3") + " BI3 " 																+ CRLF
				cQuery += "   ON " 																							+ CRLF
				cQuery += "     BI3.BI3_FILIAL = BA1.BA1_FILIAL " 															+ CRLF
				cQuery += "     AND BI3.BI3_CODINT = BA1.BA1_CODINT  " 														+ CRLF
				cQuery += "     AND BI3.BI3_CODIGO = BA1.BA1_CODPLA  " 														+ CRLF
				cQuery += " WHERE " 																						+ CRLF
				cQuery += "   BA1.D_E_L_E_T_ = ' ' " 																		+ CRLF
				cQuery += "   AND BA1.BA1_CODINT = '" + BA1->BA1_CODINT + "' " 												+ CRLF
				cQuery += "   AND BA1.BA1_CODEMP = '" + BA1->BA1_CODEMP + "' " 												+ CRLF
				cQuery += "   AND BA1.BA1_MATRIC = '" + BA1->BA1_MATRIC + "' " 												+ CRLF				

				//---------------------------------------------------------------------------------------------
				//Se for t�tular dever� buscar os dependentes que foram bloqueados juntamente com o titular
				//---------------------------------------------------------------------------------------------
				If BA1->BA1_TIPUSU = "T"

					cQuery += "   AND BA1.BA1_DATBLO = '" + DTOS(BA1->BA1_DATBLO) + "' "									+ CRLF

				Else

					cQuery += "   AND BA1.BA1_TIPREG = '" + BA1->BA1_TIPREG + "' " 											+ CRLF
					cQuery += "   AND BA1.BA1_DIGITO = '" + BA1->BA1_DIGITO + "' " 											+ CRLF

				EndIf

				_cTexto := "" //Limpando a vari�vel	

				//-----------------------------------------------------------------------------
				//Neste momento caso tenho sido bloqueio de familia
				//vou alimentar o html na m�o v�rias vezes, para mostrar 
				//todos os benefici�rios que foram bloqueados dentro da fam�lia
				//-----------------------------------------------------------------------------
				TCQuery cQuery new Alias (_cAlias)							

				While (_cAlias)->(!Eof())

					_cTexto += '<span style="font-size: 10pt;"><strong>Nome&#58; </strong>' + (_cAlias)->NOME + '</span><br>' + CRLF
					_cTexto += '<span style="font-size: 10pt;"><strong>Plano&#58; </strong>' + (_cAlias)->DESC_PLAN + '</span><br>' + CRLF
					_cTexto += '<span style="font-size: 10pt;"><strong>Matr&iacute;cula&#58; </strong>' + (_cAlias)->MATRICULA + '</span><br><br>' + CRLF

					(_cAlias)->(DbSkip())

				EndDo

				//Pegando o primeiro registro do tipo de servi�o 
				//para poder encaminhar no e-mail
				DbSelectArea("SZY")
				DbSetOrder(1)
				If DbSeek(xFilial("SZY") + SZX->ZX_SEQ)

					DbSelectArea("PBL")
					DbSetOrder(1)
					If DBSeek(xFilial("PBL") + SZY->ZY_TIPOSV)

						_cTpSrv := PBL_YDSSRV

					EndIf

				EndIf

				_cHora := SUBSTR(SZX->ZX_HORADE,1,2) + ":" + SUBSTR(SZX->ZX_HORADE,3,2)

				_cCanDp := GetAdvFVal("PCA","PCA_DESCRI",xFilial("PCA")+SZX->ZX_PTENT,1)//IIF(SZX->ZX_PTENT = "000006", "TELEFONE", "PRESENCIAL")

				aAdd( a_Msg, { "_cBenef"	, SZX->ZX_NOMUSR			}) //Nome do Benefici�rio			
				aAdd( a_Msg, { "_cDtDe"		, DTOC(SZX->ZX_DATDE)		}) //Data de Abertura do Protocolo
				aAdd( a_Msg, { "_cHora"		, _cHora					}) //Hora de Abertura do Protocolo
				aAdd( a_Msg, { "_cDtOnt"	, DTOC(DATE())				}) //Data da Mensalidade (Um dia anterior)
				aAdd( a_Msg, { "_cPtEnt"	, _cCanDp					}) //Descri��o do CANAL
				aAdd( a_Msg, { "_cProtoc"	, SZX->ZX_SEQ 				}) //N�mero do Protocolo
				aAdd( a_Msg, { "_cPlan"		, _cDscPln 					}) //Descri��o do Plano do Benefici�rio			
				aAdd( a_Msg, { "_cMat"		, _cMat						}) //Matricula do Benefici�rio
				aAdd( a_Msg, { "_cTexto"	, _cTexto					}) //Informa��es benefici�rios bloqueados																			

				//-----------------------------------------------------
				//Caso seja e-mail para as areas 
				//acrescentar aqui os emails dos respons�veis
				//-----------------------------------------------------
				If !(Empty(_cParam2))

					c_To := _cEmArea
					
				Else

					c_To += ";protocolodeatendimento@caberj.com.br"

				EndIf				

				//-----------------------------------------------------
				//Fun��o para envio de e-mail
				//-----------------------------------------------------
				If Env_1(a_Htm, c_To, c_CC, c_Assunto, a_Msg )

					If Empty(_cParam2)

						Aviso("Aten��o", "Protocolo enviado com sucesso!",{"OK"})

					EndIf

				EndIf

				//--------------------------------------------------------------------------------------------------
				//Se for e-mail para as areas n�o ir� alimentar a informa��o no protocolo gerado no sistema
				//--------------------------------------------------------------------------------------------------
				If Empty(_cParam2)

					//-----------------------------------------------------------------
					//Gravando mais uma linha na SZY de hist�rico do envio de e-mail.
					//-----------------------------------------------------------------
					DbSelectArea("SZY")
					DbSetOrder(1)
					If DbSeek(xFilial("SZY") + SZX->ZX_SEQ)

						_nCntZy := 1 

						While !Eof() .And. SZX->ZX_SEQ == SZY->ZY_SEQBA						

							_nCntZy ++

							_cTpSv 	:= SZY->ZY_TIPOSV 
							_cHst	:= SZY->ZY_HISTPAD	 												

							SZY->(DbSkip())

						EndDo

						RecLock("SZY", .T.)

						SZY->ZY_SEQBA 	:= SZX->ZX_SEQ
						SZY->ZY_SEQSERV	:= STRZERO(_nCntZy,TAMSX3("ZY_SEQSERV")[1])
						SZY->ZY_DTSERV	:= dDatabase
						SZY->ZY_HORASV	:= SUBSTR(TIME(),1,2) + SUBSTR(TIME(),4,2) 
						SZY->ZY_TIPOSV	:= _cTpSv
						SZY->ZY_OBS		:= "E-mail enviado para: " + c_To
						SZY->ZY_HISTPAD	:= 	_cHst
						SZY->ZY_PESQUIS	:= "4" //N�O AVALIADO								

						SZY->(MsUnLock())

					EndIf

				EndIf

			EndIf

		EndIf

	EndIf  

	RestArea(_aArBI3)
	RestArea(_aArSZY)
	RestArea(_aArSZX)
	RestArea(_aArBa1)
	RestArea(_aArea	)

Return 


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Env_1     �Autor  �Angelo Henrique     � Data �  30/03/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o generica responsavel pelo envio de e-mails.         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function Env_1(c_ArqTxt, c_To, c_CC, c_Assunto, a_Msg )

	Local n_It 			:= 0

	Local oMsg
	Local _cError     	:= ""
	Local l_Result    	:= .F.                   		// resultado de uma conex�o ou envio
	Local nHdl        	:= fOpen(c_ArqTxt,68)
	Local c_Body      	:= space(99999)

	Private _cServer  	:= Trim(GetMV("MV_RELSERV")) 	// smtp.ig.com.br ou 200.181.100.51

	Private _cUser    	:= GetNewPar("MV_XMAILPA", "protocolodeatendimento@caberj.com.br")
	Private _cPass    	:= GetNewPar("MV_XPSWPA" , "Caberj2017@!") 

	Private _cFrom    	:= "CABERJ PROTHEUS"
	Private cMsg      	:= ""	

	If !(nHdl == -1)

		nBtLidos := fRead(nHdl,@c_Body,99999)
		fClose(nHdl)

		For n_It:= 1 to Len( a_Msg )

			c_Body  := StrTran(c_Body, a_Msg[n_It][1] , a_Msg[n_It][2])		

		Next

		// Tira quebras de linha para nao dar problema no WebMail da Caberj
		c_Body  := StrTran(c_Body,CHR(13)+CHR(10) , "")

		// Contecta o servidor de e-mail
		CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result

		If !l_Result

			GET MAIL ERROR _cError

			DISCONNECT SMTP SERVER RESULT lOk			

		Else

			SEND MAIL FROM _cUser TO c_To SUBJECT c_Assunto BODY c_Body  RESULT l_Result

			If !l_Result

				GET MAIL ERROR _cError			

			Endif

		EndIf

	Endif

Return l_Result


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA595G  �Autor  �Angelo Henrique     � Data �  28/02/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o para gerar o relat�rio presencial para o            ���
���          � benfici�rio.                                               ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA595G(_cProtoc)

	Local _aArea 	:= GetArea()	

	Private cParams	:= ""                                                 

	Private cParIpr	:="1;0;1;Protocolo de Solicita��o de Cancelamento"

	cParams := SUBSTR(cEmpAnt,2,1) + ";" + _cProtoc

	DbSelectArea("SZX")
	DbSetOrder(1)		
	If DbSeek(XFilial("SZX") + _cProtoc)

		If UPPER(SZX->ZX_RN412) == "S"

			CallCrys("PROT_AT_CANC",cParams,cParIpr)

		Else

			Aviso("Aten��o","Este protocolo n�o � de cancelamento da rotina RN 412",{"OK"})

		EndIf

	EndIf

	RestArea(_aArea)

Return
