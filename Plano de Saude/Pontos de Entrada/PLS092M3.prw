#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS092M3  º Autor ³ Angelo Henrique    º Data ³  18/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Ponto de entrada utilizado para acrescentar nova opção Menuº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS092M3()

	Local aArea		:= GetArea()
	Local _aRet		:= {}

	_aRet := {'Auditoria/OPME', 'U_PLMENUCB()',0,10}

	RestArea(aArea)

Return _aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLMENUCB  º Autor ³ Angelo Henrique    º Data ³  24/01/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Chamada de tela que irá conter o menu das opções referente º±±
±±º          ³ ao processo do OPME.                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLMENUCB

	Local _aArea 	:= GetArea()
	Local _nOpc 	:= 0
	LOCAL   nDiasBloq  := GetNewPar("MV_PLDIABL",0) // 27/11/18 - INCLUIDO - MATEUS MEDEIROS

	Private _oDlg	:= Nil
	Private _oBtn	:= Nil
	Private _oGroup	:= Nil

	//**********************************************************
	// MATEUS MEDEIROS - 27/11/2018 - INÍCIO
	// VALIDAÇÃO DE BLOQUEIO FUTURO DO BENEFICIÁRIO
	//**********************************************************
	PLSA090USR(BE4->(BE4_CODOPE+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO),dDataBase,BE4->BE4_HORPRO,"BE4")
	//**********************************************************
	// MATEUS MEDEIROS - 27/11/2018 - FIM
	// VALIDAÇÃO DE BLOQUEIO FUTURO DO BENEFICIÁRIO
	//**********************************************************

	DEFINE MSDIALOG _oDlg FROM 0,0 TO 90,380 PIXEL TITLE 'Autorização/Laudo Pos OPME'

	_oGroup:= tGroup():New(02,05,40,175,'Selecione uma das opções',_oDlg,,,.T.)

	_oBtn := TButton():New( 15,020,"Autorização OPME"	,_oDlg,{||_oDlg:End(),_nOpc := 1	},060,012,,,,.T.,,"",,,,.F. )
	_oBtn := TButton():New( 15,100,"Utilização OPME"	,_oDlg,{||_oDlg:End(),_nOpc := 2	},060,012,,,,.T.,,"",,,,.F. )

	ACTIVATE MSDIALOG _oDlg CENTERED

	If _nOpc = 1

		//--------------------------------------
		//Chamada da função de Autorização OPME
		//--------------------------------------
		u_PLSM3A()

	ElseIf _nOpc = 2

		//--------------------------------------
		//Chamada da função Laudo Pos OPME
		//--------------------------------------
		u_PLSM3B()

	EndIf

	RestArea(_aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSM3A    º Autor ³ Angelo Henrique    º Data ³  24/01/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina utilizada para imputar informações pertinente ao    º±±
±±º          ³tecnico de CALL CENTER no processo de OPME durante a        º±±
±±º          ³internação.                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSM3A(_cParam)

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de cVariable dos componentes                                 ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	Local nOpc 		:= GD_INSERT+GD_DELETE+GD_UPDATE
	Local cIniCpos  := "++ZZ6_SEQ"  // Nome dos campos do tipo caracter que utilizarao incremento automatico.

	Local aAux 		:= {}
	Local _ni		:= 0

	Private aCoBrw1 := {}
	Private aHoBrw1 := {}
	Private noBrw1  := 0
	Private _aAlter	:= {"ZZ6_TEXTO"}

	Private _aUtil  := {" ","SIM","NAO"}
	Private _aAtnd  := {" ","POS","URGENCIA","ELETIVO"}
	Private _aPac   := {" ","NAO","SIM"}
	Private _aDoc   := {" ","ELETRONICO/EMAIL","FISICO/AGENCIA","FISICO/DIRETORIA", "PORTAL"}
	Private _aEnt   := {}
	Private _aStat  := {" ","ANALIS. ADM","EXIG. ADM","ANALIS. AUD.","EXIG. AUD.","CUMPRIMENTO AUDITORIA","JUNTA MEDICA","ANALIS. OPME","OPME FINALIZADO","AGUARDANDO LIB.","INTERNACAO LIB.","OPME AUT FORNEC/PRESTADOR","NEGADO"} //MOTTA 13/3/20

	Private cBxUtil	:= _aUtil[1]
	Private cBxAtnd	:= _aAtnd[1]
	Private cBxPac  := _aPac[2]
	Private cBxDoc 	:= _aDoc[1]
	Private cBxEnt  := ""
	Private cBxStat := _aStat[1]
	Private dDatAut	:= CtoD(" ")
	Private dDatPro	:= CtoD(" ")
	PRIVATE _nDiasAut := SupergetMV("MV_XDAUTEL", .F., 15)
	PRIVATE _nDiasDay := SupergetMV("MV_XDAUDAY", .F., 15)

	Default _cParam := "1" //1 é original da rotina || 2 - é quando a internação é prorrogada

	If cEmpAnt = "01"

		//_aEnt   := {" ","ELETIVO "+cValTocHar(_nDiasAut)+" DIAS","DAY CLIN 12 DIAS","PACIENTE INTERNA 24 H","LIMINAR 24 H","NIP 72 H","URGENCIA/EMERGENCIA","CIRURG ONCOLOGICA 48 H"}
		_aEnt   := {" ","ELETIVO "+cValTocHar(_nDiasAut)+" DIAS","DAY CLIN " + cValTocHar(_nDiasDay) + " DIAS","PACIENTE INTERNA 24 H","LIMINAR 24 H","NIP 72 H","URGENCIA/EMERGENCIA","CIRURG ONCOLOGICA 96 H"}

	Else

		//_aEnt   := {" ","ELETIVO "+cValTocHar(_nDiasAut)+" DIAS","DAY CLIN 12 DIAS","PACIENTE INTERNA 24 H","LIMINAR 24 H","NIP 72 H","URGENCIA/EMERGENCIA","CIRURG ONCOLOGICA 48 H"}
		_aEnt   := {" ","ELETIVO "+cValTocHar(_nDiasAut)+" DIAS","DAY CLIN " + cValTocHar(_nDiasDay) + " DIAS","PACIENTE INTERNA 24 H","LIMINAR 24 H","NIP 72 H","URGENCIA/EMERGENCIA","CIRURG ONCOLOGICA 96 H"}

	EndIf

	cBxEnt  := _aEnt[1]

	//--------------------------------------------------------------------------------------
	//Chamada da função para alimentar as informações no momento da abertura da tela
	//caso já tenha sido alimentada alguma informação na internação
	//Primeira parte, não é os campos do mural (ZZ6)
	//--------------------------------------------------------------------------------------
	u_PLSM3A2()

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de Variaveis Private dos Objetos                             ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	SetPrvt("_oFont1","_oDlg1","_oPanel1","oGrp2","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oSay7","oSay8")
	SetPrvt("oDatAut","oDatPro","oBtn1","oBtn2","oBxUtil","oBxAtnd","oBxPac","oBxDoc","oBxEnt","oBxStat","oBrw1")

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Defi_nicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	_oFont1    := TFont():New( "Arial Narrow",0,-16,,.T.,0,,700,.F.,.F.,,,,,, )
	_oDlg1     := MSDialog():New( 092,232,699,927," Autorizacao ",,,.F.,,,,,,.T.,,,.T. )
	_oPanel1   := TPanel():New( 000,000,"",_oDlg1,,.F.,.F.,,,340,296,.T.,.F. )
	oGrp2      := TGroup():New( 008,008,168,332,"  Autorizacao  ",_oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )

	oSay1      := TSay():New( 024,016,{||"Utiliza OPME ?"			},oGrp2,,_oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	oSay2      := TSay():New( 044,016,{||"Atendimento OPME"			},oGrp2,,_oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	oSay3      := TSay():New( 064,016,{||"Pacote OPME"				},oGrp2,,_oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	oSay4      := TSay():New( 084,016,{||"Origem Documento"			},oGrp2,,_oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	oSay5      := TSay():New( 104,016,{||"Classificacao de Entrada"	},oGrp2,,_oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	oSay6      := TSay():New( 124,016,{||"Status Eletivo"			},oGrp2,,_oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	oSay7      := TSay():New( 144,016,{||"Data prevista Autorizacao"},oGrp2,,_oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,016)

	If _cParam == "2"

		//----------------------------------------------------------------------------------
		//Data para Prorrogação
		//Esta data só deve aparecer quando a chamada vier da rotina de prorrogação
		//----------------------------------------------------------------------------------
		oSay8      := TSay():New( 024,240,{||"Data Prorrogação"			},oGrp2,,_oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
		oDatPro    := TGet():New( 040,225,{|u| If(PCount()>0,dDatPro:=u,dDatPro) , dDatAut := u_PLSM3A3(_cParam)},oGrp2,088,008,'@99/99/9999',{||U_CABV043("2")},CLR_BLACK,CLR_WHITE,_oFont1,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDatPro",,)

		//----------------------------------------------------------------------------------
		//Colocando a classificação para PAciente Interna 24H, por ser prorrogação
		//----------------------------------------------------------------------------------
		cBxEnt := _aEnt[4] //PACIENTE INTERNA

	EndIf

	oDatAut    := TGet():New( 144,112,{|u| If(PCount()>0,dDatAut:=u,dDatAut)},oGrp2,088,008,'@99/99/9999',,CLR_BLACK,CLR_WHITE,_oFont1,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDatAut",,)

	oGrp1      := TGroup():New( 172,008,272,332," Observacao: ",_oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )

	oBxUtil    := TComboBox():New( 024,112,{|u| If(PCount()>0,cBxUtil:=u,cBxUtil)},_aUtil	,088,010,_oPanel1,,										,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cBxUtil )
	oBxAtnd    := TComboBox():New( 044,112,{|u| If(PCount()>0,cBxAtnd:=u,cBxAtnd)},_aAtnd	,088,010,_oPanel1,,										,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cBxAtnd )
	oBxPac     := TComboBox():New( 064,112,{|u| If(PCount()>0,cBxPac:=u	,cBxPac	)},_aPac	,088,010,_oPanel1,,										,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cBxPac 	)
	oBxDoc     := TComboBox():New( 084,112,{|u| If(PCount()>0,cBxDoc:=u	,cBxDoc	)},_aDoc	,088,010,_oPanel1,,										,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cBxDoc 	)
	oBxEnt     := TComboBox():New( 104,112,{|u| If(PCount()>0,cBxEnt:=u	,cBxEnt	)},_aEnt	,088,010,_oPanel1,,{||iif(!Empty(cBxEnt),dDatAut := u_PLSM3A3(_cParam),MsgStop("Favor informar a classificação de Entrada!","Classificação") ) }	,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cBxEnt 	)
	oBxStat    := TComboBox():New( 124,112,{|u| If(PCount()>0,cBxStat:=u,cBxStat)},_aStat	,088,010,_oPanel1,,{||u_PLSM3A4("1")}					,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cBxStat )

	//-------------------------------------------
	//Montagem do aHeader (Cabeçalho) ZZ6 - Mural
	//-------------------------------------------
	aHoBrw1 	:= u_PLSHEAD()

	//----------------------------------------
	// Inicio - Montagem do Acols (Itens)
	//----------------------------------------
	aCoBrw1 	:= u_PLSITEM("1",aHoBrw1)

	oBrw1 		:= MsNewGetDados():New(184,016,264,324,nOpc,'AllwaysTrue()','AllwaysTrue()',cIniCpos,_aAlter,000,999,'AllwaysTrue()','','AllwaysTrue()',_oPanel1,aHoBrw1,aCoBrw1 )

	//-----------------------
	//Botões
	//-----------------------
	oBtn1      	:= TButton():New( 276,288,"Salvar",_oPanel1,{|| IIF(U_CABV043("2"),u_PLSM3A1(_cParam),)	},037,012,,,,.T.,,"Clique para salvar"	,,,,.F. )

	_oDlg1:Activate(,,,.T.)

	//------------------------------------------------------------
	//Conforme solicitado pela ANS quando ocorre internação
	//é necessário que um protocolo de atendimento seja
	//criado
	//------------------------------------------------------------
	If VAL(BE4->BE4_ANOINT) >= 2017

		//Rotina responsável por criar o protocolo de atendimento
		U_PLSM3C()

	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSM3A1   º Autor ³ Angelo Henrique    º Data ³  28/12/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para gravar as informações inseridas na tela do OPMEº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSM3A1(_cParam)

	Local _aArea 	:= GetArea()
	Local _aArB4 	:= BE4->(GetArea())
	Local _aArZ6 	:= ZZ6->(GetArea())
	Local _cAlias	:= GetNextAlias()
	Local _cAlias1	:= GetNextAlias()
	Local cQry		:= ""
	Local _cLib  	:= ""
	Local _cNaoLb  	:= ""
	Local _cLib2  	:= ""
	Local _cNaoLb2 	:= ""

	Local _cUtil 	:= ""
	Local _cAtnd	:= ""
	Local _cPac 	:= ""
	Local _cDoc 	:= ""
	Local _cEnt 	:= ""
	Local _cStat 	:= ""
	Local _lValid	:= .T.
	Local _cElet	:= ""

	Local aCabec 	:= aClone(oBrw1:aHeader)
	Local aItens	:= aClone(oBrw1:aCols)
	Local i,j		:= 0
	Local nPosSeq	:= Ascan(aCabec,{|x| AllTrim(x[2]) == "ZZ6_SEQ"		})
	Local nPosPar	:= Ascan(aCabec,{|x| AllTrim(x[2]) == "ZZ6_TEXTO"	}) //Valindo para não gravar linhas não preenchidas
	Local _cChvB4	:= BE4->BE4_CODOPE + BE4->BE4_ANOINT + BE4->BE4_MESINT + BE4->BE4_NUMINT

	Default _cParam	:= "1" //1 - Quando é original dda rotina||2- Quando vem da prorrogação

	//--------------------------------------------------------------
	//Inicio do processo de validação das informações selecionadas.
	//--------------------------------------------------------------
	//If UPPER(AllTrim(cBxUtil)) == "SIM" .OR. Empty(AllTrim(cBxUtil))- Mateus muniz - 04/12/2017 - Não permitir campo vazio.

	If Empty(AllTrim(cBxUtil))

		Aviso("Atenção","Favor selecionar uma das opções no campo de Utilização OPME ",{"OK"})
		_lValid := .F.

	ElseIf Empty(AllTrim(cBxAtnd))

		Aviso("Atenção","Favor selecionar uma das opções no campo de Atendimento OPME ",{"OK"})
		_lValid := .F.

	ElseIf Empty(AllTrim(cBxPac))

		Aviso("Atenção","Favor selecionar uma das opções no campo de Pacote OPME ",{"OK"})
		_lValid := .F.

	ElseIf Empty(AllTrim(cBxDoc))

		Aviso("Atenção","Favor selecionar uma das opções no campo de Origem Documento ",{"OK"})
		_lValid := .F.

	ElseIf Empty(AllTrim(cBxEnt))

		Aviso("Atenção","Favor selecionar uma das opções no campo de Classificacao de Entrada",{"OK"})
		_lValid := .F.

	ElseIf Empty(AllTrim(cBxStat))

		Aviso("Atenção","Favor selecionar uma das opções no campo de Status Eletivo ",{"OK"})
		_lValid := .F.

	ElseIf Empty(dDatAut)

		Aviso("Atenção","Favor selecionar uma das opções no campo Data Prevista ",{"OK"})
		_lValid := .F.

	EndIf

	//EndIf

	//--------------------------------------------------------------
	//Fim do processo de validação das informações selecionadas.
	//--------------------------------------------------------------

	//-----------------------------------------------------------------------------
	//Validação para saber se pode ir direto para a opção de senha liberada
	//-----------------------------------------------------------------------------
	If UPPER(AllTrim(cBxStat)) == "INTERNACAO LIB." .And. UPPER(AllTrim(cBxUtil)) == "SIM"

		If !(AllTrim(BE4->BE4_TIPADM) $ "4|5" .And. UPPER(AllTrim(cBxAtnd)) == "POS")

			If !(BE4->BE4_YSOPME $ "8|9") .And. Empty(BE4->BE4_SENHA)

				Aviso("Atenção","Selecionado opção de utilização OPME, não pode ter senha liberada diretamente",{"OK"})
				_lValid := .F.

			EndIf

		EndIf

	EndIf

	If !(BE4->BE4_YSOPME $ "4|5|6") .And. _lValid

		If UPPER(AllTrim(cBxStat)) $ ("EXIG. AUD.|CUMPRIMENTO AUDITORIA|JUNTA MEDICA|ANALIS. OPME|OPME AUT FORNEC/PRESTADOR")

			Aviso("Atenção","Não e permitido trocar o status, pois o processo esta em outro nível",{"OK"})
			_lValid := .F.

		EndIf

	EndIf

	//---------------------------------
	//Validação para os status
	//---------------------------------
	If !Empty(AllTrim(cBxStat))

		If !(u_PLSM3A4("1"))

			_lValid := .F.

		EndIf

	EndIf

	If _lValid

		//----------------------------
		//Fechando a tela
		//----------------------------
		_oDlg1:End()

		//-------------------------------------------------------
		//Validando as informações escolhidas na tela OPME
		//inserindo assim a informação correta no campo
		//-------------------------------------------------------
		//-------------------------------------------------------
		//Utiliza OPME ?
		//0=Sim;1=Nao
		//-------------------------------------------------------
		If UPPER(AllTrim(cBxUtil)) == "SIM"

			_cUtil := "0"

		ElseIf UPPER(AllTrim(cBxUtil)) == "NAO"

			_cUtil := "1"

		EndIf

		//-------------------------------------------------------
		//Atendimento OPME
		//-------------------------------------------------------
		//0=POS;1=URGENCIA;2=ELETIVO
		//-------------------------------------------------------
		If UPPER(AllTrim(cBxAtnd)) == "POS"

			_cAtnd := "0"

		ElseIf UPPER(AllTrim(cBxAtnd)) == "URGENCIA"

			_cAtnd := "1"

		ElseIf UPPER(AllTrim(cBxAtnd)) == "ELETIVO"

			_cAtnd := "2"

		EndIf

		//-------------------------------------------------------
		//Pacote OPME
		//-------------------------------------------------------
		//0=NAO;1=SIM
		//-------------------------------------------------------
		If UPPER(AllTrim(cBxPac)) == "NAO"

			_cPac := "0"

		ElseIf UPPER(AllTrim(cBxPac)) == "SIM"

			_cPac := "1"

		EndIf

		//-------------------------------------------------------
		//Origem Documento
		//-------------------------------------------------------
		//1=Eletronico/email;2=Fisico/Agencia;3=Fisico/Diretoria
		//-------------------------------------------------------
		If UPPER(AllTrim(cBxDoc)) == "ELETRONICO/EMAIL"

			_cDoc := "1"

		ElseIf UPPER(AllTrim(cBxDoc)) == "FISICO/AGENCIA"

			_cDoc := "2"

		ElseIf UPPER(AllTrim(cBxDoc)) == "FISICO/DIRETORIA"

			_cDoc := "3"

		EndIf


		//-------------------------------------------------------
		//Classificação de entrada
		//-------------------------------------------------------
		//1=ELETIVO 12 DIAS; 2=DAY CLIN 12 DIAS;
		//3=PACIENTE INTERNA 24 H;4=LIMINAR 24 H;5=NIP 72 H
		//-------------------------------------------------------
		If cEmpAnt == '01'

			_cElet := "ELETIVO "+cValTocHar(_nDiasAut)+" DIAS"

		Else

			_cElet := "ELETIVO "+cValTocHar(_nDiasAut)+" DIAS"

		EndIf


		If cEmpAnt == '01'

			_cDay := "DAY CLIN "+cValTocHar(_nDiasDay)+" DIAS"

		Else

			_cDay := "DAY CLIN "+cValTocHar(_nDiasDay)+" DIAS"

		EndIf


		If UPPER(AllTrim(cBxEnt)) == _cElet

			_cEnt := "1"

		ElseIf UPPER(AllTrim(cBxEnt)) == _cDay

			_cEnt := "2"

		ElseIf UPPER(AllTrim(cBxEnt)) == "PACIENTE INTERNA 24 H"

			_cEnt := "3"

		ElseIf UPPER(AllTrim(cBxEnt)) == "LIMINAR 24 H"

			_cEnt := "4"

		ElseIf UPPER(AllTrim(cBxEnt)) == "NIP 72 H"

			_cEnt := "5"

		ElseIf UPPER(AllTrim(cBxEnt)) == "URGENCIA/EMERGENCIA"

			_cEnt := "6"

			//ElseIf UPPER(AllTrim(cBxEnt)) == "CIRURG ONCOLOGICA 48 H"
		ElseIf UPPER(AllTrim(cBxEnt)) == "CIRURG ONCOLOGICA 96 H"

			_cEnt := "7"

		EndIf

		//-------------------------------------------------------
		//Status Eletivo
		//-------------------------------------------------------
		//1=ANALIS. ADM, 2=EXIG. ADM, 3=ANALIS. AUD.,
		//4=EXIG. AUD., 5=ANALIS. OPME, 6=OPME AUT, 7=SENHA LIB
		//_aStat  := {" ","ANALIS. ADM","EXIG. ADM","ANALIS. AUD.","EXIG. AUD.","CUMPRIMENTO AUDITORIA","JUNTA MEDICA","ANALIS. OPME","OPME FINALIZADO","AGUARDANDO LIB.","INTERNACAO LIB.","OPME AUT FORNEC/PRESTADOR","NEGADO"} //MOTTA 13/3/20
		//-------------------------------------------------------
		//If UPPER(AllTrim(cBxStat)) == "ANALIS. ADM"
		If UPPER(AllTrim(cBxStat)) == "ANALIS. ADM" .or. EMPTY(AllTrim(cBxStat))

			_cStat := "1"

		ElseIf UPPER(AllTrim(cBxStat)) == "EXIG. ADM"

			_cStat := "2"

		ElseIf UPPER(AllTrim(cBxStat)) == "ANALIS. AUD."

			_cStat := "3"

		ElseIf UPPER(AllTrim(cBxStat)) == "EXIG. AUD."

			_cStat := "4"

		ElseIf UPPER(AllTrim(cBxStat)) == "CUMPRIMENTO AUDITORIA"

			_cStat := "5"

		ElseIf UPPER(AllTrim(cBxStat)) == "JUNTA MEDICA"

			_cStat := "6"

		ElseIf UPPER(AllTrim(cBxStat)) == "ANALIS. OPME"

			_cStat := "7"

		ElseIf UPPER(AllTrim(cBxStat)) == "OPME FINALIZADO"

			_cStat := "8"

		ElseIf UPPER(AllTrim(cBxStat)) == "AGUARDANDO LIB."

			_cStat := "9"

		ElseIf UPPER(AllTrim(cBxStat)) == "INTERNACAO LIB."

			_cStat := "A"

		ElseIf UPPER(AllTrim(cBxStat)) == "OPME AUT FORNEC/PRESTADOR"

			_cStat := "B"

		ElseIf UPPER(AllTrim(cBxStat)) == "NEGADO"   //MOTTA 13/3/20
			//MOTTA 13/3/20
			_cStat := "C"				             //MOTTA 13/3/20

		EndIf

		//------------------------------------------------------------
		// Mateus Medeiros - 08/11/2017
		// Envio de E-mail para o RDA caso
		// alteração DE AGUARDANDO LIBERAÇÃO para Internação Liberada
		// Em Fase de testes
		//------------------------------------------------------------
		//BE4_STATUS - 1=Autorizada;2=Autorizada Parcialmente;
		//3=Nao Autorizada;4=Aguardando finalizacao do atendimento
		if !(BE4->BE4_STATUS $ '|2|3|')
			If (BE4->BE4_YOPME == "0") // Tem OPME
				If (Trim(BE4->BE4_YSOPME) == "9") .And. !Empty(_cStat)

					If(_cStat == 'B' )
						/* // -- Comentado pois não entrará neste momento em produção;
						 	if MsgYesNo("Deseja enviar e-mail?","Envio E-mail RDA")

						 		TelaMail()

						endif */

					endif

				EndIf

			Elseif (BE4->BE4_YOPME == "1") // Não Tem OPME

				If (Trim(BE4->BE4_YSOPME) == "9") .And. !Empty(_cStat)

					If(_cStat == 'A' )
						/* // -- Comentado pois não entrará neste momento em produção;
						 	if MsgYesNo("Deseja enviar e-mail?","Envio E-mail RDA")

						 		TelaMail()

						endif */

					endif

				EndIf

			Endif

		Endif
		//*--------------------------------*
		//* Mateus Medeiros - 08/11/2017   *
		//*                 FIM            *
		//*--------------------------------*



		BE4->( RecLock("BE4", .F.) )

		BE4->BE4_YOPME 	:= _cUtil
		BE4->BE4_YATOPM := _cAtnd
		BE4->BE4_YPOPME := _cPac
		BE4->BE4_XORIG 	:= _cDoc
		BE4->BE4_XENT 	:= _cEnt
		BE4->BE4_YSOPME	:= _cStat
		BE4->BE4_XDTPR 	:= dDatAut

		//------------------------------------------------------------
		//Guardando o usuário que colocou na opção de liberação
		//------------------------------------------------------------
		If _cStat == 'A' .And. Empty(BE4->BE4_XUSLIB)

			BE4->BE4_XUSLIB := CUSERNAME
			BE4->BE4_XDTLIB := Date()

			//calculando a nova data de validade com base na data de autorização
			BE4->BE4_DATVAL := DaySum(Date(), 30)

		EndIf

		//---------------------------------------------------------------------------------
		//Angelo Henrique - Data:13/09/2021
		//---------------------------------------------------------------------------------
		//Rotina que irá gerar um novo protocolo e disparar SMS para o beneficiário
		//---------------------------------------------------------------------------------
		If (_cStat == 'A' .and. BE4->BE4_YOPME == "1") .Or. (_cStat == 'B' .and. BE4->BE4_YOPME == "0") .Or. _cStat == 'C'
			u_CABA097(BE4->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT),_cStat)
		EndIf
		//---------------------------------------------------------------------------------

		If _cParam == "2" //Prorrogação

			BE4->BE4_XDTPRO := dDatPro

		EndIf

		//---------------------------------------------------------------------------------
		//Conforme analisado alguns itens ainda não estão parametrizados para
		//auditoria, logo existe a necessidade de varrer os itens da BEJ e da BQV
		//para saber se existe algum item em auditoria
		//---------------------------------------------------------------------------------

		//-----------------------------------------
		//Varrendo primeiro a internação
		//-----------------------------------------
		cQry := "SELECT 		 										" + CRLF
		cQry += "	BEJ.BEJ_STATUS										" + CRLF
		cQry += "FROM	 												" + CRLF
		cQry += "	" + RetSqlName('BE4') + " BE4, 						" + CRLF
		cQry += "	" + RetSqlName('BEJ') + " BEJ 						" + CRLF
		cQry += "WHERE         											" + CRLF
		cQry += "	BE4.BE4_FILIAL 		= '" + xFilial("BE4") 	+ "' 	" + CRLF
		cQry += "	AND BE4.BE4_CODOPE 	= '" + BE4->BE4_CODOPE	+ "' 	" + CRLF
		cQry += "	AND BE4.BE4_ANOINT 	= '" + BE4->BE4_ANOINT	+ "' 	" + CRLF
		cQry += "	AND BE4.BE4_MESINT 	= '" + BE4->BE4_MESINT	+ "' 	" + CRLF
		cQry += "	AND BE4.BE4_NUMINT 	= '" + BE4->BE4_NUMINT 	+ "' 	" + CRLF
		cQry += "	AND BEJ.BEJ_FILIAL 	= BE4.BE4_FILIAL				" + CRLF
		cQry += "	AND BEJ.BEJ_CODOPE 	= BE4.BE4_CODOPE				" + CRLF
		cQry += "	AND BEJ.BEJ_ANOINT 	= BE4.BE4_ANOINT				" + CRLF
		cQry += "	AND BEJ.BEJ_MESINT 	= BE4.BE4_MESINT				" + CRLF
		cQry += "	AND BEJ.BEJ_NUMINT 	= BE4.BE4_NUMINT				" + CRLF
		cQry += "	AND BE4.D_E_L_E_T_ 	= ' '							" + CRLF
		cQry += "	AND BEJ.D_E_L_E_T_ 	= ' '							" + CRLF

		If Select("_cAlias")>0
			_cAlias->(DbCloseArea())
		EndIf

		TcQuery cQry New Alias _cAlias

		While !_cAlias->(EOF())

			// -- 1=Autorizada;0=Nao Autorizada
			If _cAlias->BEJ_STATUS = "1"

				_cLib := "1"

			Else

				_cNaoLb := "2"

			EndIf

			_cAlias->(DbSkip())

		EndDo

		_cAlias->(DbCloseArea())


		//-----------------------------------------
		//Varrendo agora a prorrogação
		//-----------------------------------------
		cQry := "SELECT 		 										" + CRLF
		cQry += "	BQV.BQV_STATUS										" + CRLF
		cQry += "FROM	 												" + CRLF
		cQry += "	" + RetSqlName('BE4') + " BE4, 						" + CRLF
		cQry += "	" + RetSqlName('BQV') + " BQV 						" + CRLF
		cQry += "WHERE         											" + CRLF
		cQry += "	BE4.BE4_FILIAL 		= '" + xFilial("BE4") 	+ "' 	" + CRLF
		cQry += "	AND BE4.BE4_CODOPE 	= '" + BE4->BE4_CODOPE	+ "' 	" + CRLF
		cQry += "	AND BE4.BE4_ANOINT 	= '" + BE4->BE4_ANOINT	+ "' 	" + CRLF
		cQry += "	AND BE4.BE4_MESINT 	= '" + BE4->BE4_MESINT	+ "' 	" + CRLF
		cQry += "	AND BE4.BE4_NUMINT 	= '" + BE4->BE4_NUMINT 	+ "' 	" + CRLF
		cQry += "	AND BQV.BQV_FILIAL 	= BE4.BE4_FILIAL				" + CRLF
		cQry += "	AND BQV.BQV_CODOPE 	= BE4.BE4_CODOPE				" + CRLF
		cQry += "	AND BQV.BQV_ANOINT 	= BE4.BE4_ANOINT				" + CRLF
		cQry += "	AND BQV.BQV_MESINT 	= BE4.BE4_MESINT				" + CRLF
		cQry += "	AND BQV.BQV_NUMINT 	= BE4.BE4_NUMINT				" + CRLF
		cQry += "	AND BE4.D_E_L_E_T_ 	= ' '							" + CRLF
		cQry += "	AND BQV.D_E_L_E_T_ 	= ' '							" + CRLF

		If Select("_cAlias1")>0
			_cAlias1->(DbCloseArea())
		EndIf

		TcQuery cQry New Alias _cAlias1

		While !_cAlias1->(EOF())

			// -- 1=Autorizada;0=Nao Autorizada
			If _cAlias1->BQV_STATUS = "1"

				_cLib2 := "1"

			Else

				_cNaoLb2 := "2"

			EndIf

			_cAlias1->(DbSkip())

		EndDo

		_cAlias1->(DbCloseArea())


		//1=Autorizada;2=Autorizada Parcialmente;3=Nao Autorizada;4=Aguardando finalizacao do atendimento
		If !Empty(_cLib) .And. Empty(_cNaoLb) .And. Empty(_cLib2) .And. Empty(_cNaoLb2)

			BE4->BE4_STATUS := "1"

		ElseIf !Empty(_cLib) .And. Empty(_cNaoLb) .And. !Empty(_cLib2) .And. Empty(_cNaoLb2)

			BE4->BE4_STATUS := "1"

		ElseIf !Empty(_cLib) .And. !Empty(_cNaoLb)

			BE4->BE4_STATUS := "2"

		ElseIf !Empty(_cLib) .And. Empty(_cNaoLb) .And. !Empty(_cLib2) .And. !Empty(_cNaoLb2)

			BE4->BE4_STATUS := "2"

		ElseIf !Empty(_cLib) .And. Empty(_cNaoLb) .And. Empty(_cLib2) .And. !Empty(_cNaoLb2)

			BE4->BE4_STATUS := "2"

		ElseIf Empty(_cLib) .And. !Empty(_cNaoLb) .Or. Empty(_cLib2) .And. Empty(_cNaoLb2)

			BE4->BE4_STATUS := "3"

		EndIf

		BE4->( MsUnLock() )

		//---------------------------------------------
		//Inicio da gravação dos itens ZZ6 (Mural)
		//---------------------------------------------
		For i:=1 to Len(aItens)

			If !aItens[i][Len(aCabec)+1] .And. !Empty(AllTrim(aItens[i,nPosPar]))

				DbSelectArea("ZZ6")
				DbSetOrder(3)
				lFound := DbSeek(xFilial("ZZ6") + _cChvB4 + "1" + aItens[i,nPosSeq])

				If !(lFound) .OR. (lFound .And. UPPER(AllTrim(ZZ6->ZZ6_OPER)) == UPPER(AllTrim(CUSERNAME)))

					Reclock("ZZ6", !lFound)

					For j:=1 to Len(aCabec)
						FieldPut(FieldPos(aCabec[j,2]),aItens[i,j])
					Next

					ZZ6->ZZ6_FILIAL := xFilial("ZZ6")
					ZZ6->ZZ6_CODOPE := BE4->BE4_CODOPE
					ZZ6->ZZ6_ANOGUI := BE4->BE4_ANOINT
					ZZ6->ZZ6_MESGUI := BE4->BE4_MESINT
					ZZ6->ZZ6_NUMGUI := BE4->BE4_NUMINT
					ZZ6->ZZ6_MATVID := BE4->BE4_MATVID
					ZZ6->ZZ6_SENHA 	:= BE4->BE4_SENHA
					ZZ6->ZZ6_USU	:= "1" //Tecnico Call Center
					ZZ6->ZZ6_NOMUSR	:= BE4->BE4_NOMUSR
					ZZ6->ZZ6_OPER	:= CUSERNAME
					ZZ6->ZZ6_TEXT1	:= "PARECER CALL CENTER"
					ZZ6->ZZ6_ALIAS	:= "BE4"

					MsUnlock()

				EndIf

			Else

				DbSelectArea("ZZ6")
				DbSetOrder(3)
				If DbSeek(xFilial("ZZ6") + _cChvB4 + "1" + aItens[i,nPosSeq])

					Reclock("ZZ6", .F.)
					DbDelete()
					MsUnlock()

				EndIf

			EndIf

		Next

		//---------------------------------------------
		//Fim da gravação dos itens ZZ6 (Mural)
		//---------------------------------------------

	EndIf

	RestArea(_aArZ6)
	RestArea(_aArB4)
	RestArea(_aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSM3A2   º Autor ³ Angelo Henrique    º Data ³  28/12/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para trazer as informações inseridas na tela do OPMEº±±
±±º          ³caso a tela seja reaberta pelo usuário, mostrando assim as  º±±
±±º          ³informações preenchidas anteriormente.                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSM3A2

	Local _aArea 	:= GetArea()
	Local _aArB4 	:= BE4->(GetArea())

	//----------------------------------------------------------------
	//----------------------------------------------------------------
	//OBSERVAÇÃO:
	//----------------------------------------------------------------
	//PRIMEIRA POSIÇÃO DE TODOS OS VETORES É BRANCA, PARA MOSTRAR
	//AO USUÁRIO QUE ELE NÃO SELECIONOU NENHUMA INFORMAÇÃO.
	//POREM ISSO FOI MUDADA EM ALGUNS CAMPOS
	//----------------------------------------------------------------
	//----------------------------------------------------------------

	//-------------------------------------------------------
	//Utiliza OPME ?
	//0=Sim;1=Nao
	//-------------------------------------------------------
	If Empty(AllTrim(BE4->BE4_YOPME))

		cBxUtil	:= _aUtil[1]

	ElseIf AllTrim(BE4->BE4_YOPME) == "0"

		cBxUtil	:= _aUtil[2]

	ElseIf AllTrim(BE4->BE4_YOPME) == "1"

		cBxUtil	:= _aUtil[3]

	EndIf

	//-------------------------------------------------------
	//Atendimento OPME
	//-------------------------------------------------------
	//0=POS;1=URGENCIA;2=ELETIVO
	//-------------------------------------------------------
	If Empty(AllTrim(BE4->BE4_YATOPM))

		cBxAtnd := _aAtnd[1]

	ElseIf BE4->BE4_YATOPM == "0"

		cBxAtnd := _aAtnd[2]

	ElseIf BE4->BE4_YATOPM == "1"

		cBxAtnd := _aAtnd[3]

	ElseIf BE4->BE4_YATOPM == "2"

		cBxAtnd := _aAtnd[4]

	EndIf

	//-------------------------------------------------------
	//Pacote OPME
	//-------------------------------------------------------
	//0=NAO;1=SIM
	//-------------------------------------------------------
	If Empty(AllTrim(BE4->BE4_YPOPME))

		cBxPac := _aPac[1]

	ElseIf BE4->BE4_YPOPME == "0"

		cBxPac := _aPac[2]

	ElseIf BE4->BE4_YPOPME == "1"

		cBxPac := _aPac[3]

	EndIf

	//-------------------------------------------------------
	//Origem Documento
	//-------------------------------------------------------
	//1=Eletronico/email;2=Fisico/Agencia;3=Fisico/Diretoria
	//-------------------------------------------------------
	If Empty(AllTrim(BE4->BE4_XORIG))

		cBxDoc := _aDoc[1]

	ElseIf AllTrim(BE4->BE4_XORIG) 	== "1"

		cBxDoc := _aDoc[2]

	ElseIf AllTrim(BE4->BE4_XORIG) == "2"

		cBxDoc := _aDoc[3]

	ElseIf AllTrim(BE4->BE4_XORIG) 	== "3"

		cBxDoc := _aDoc[4]
	
	ElseIf AllTrim(BE4->BE4_XORIG) 	== "4"

		cBxDoc := _aDoc[5]

	EndIf

	//-------------------------------------------------------
	//Classificação de entrada
	//-------------------------------------------------------
	//1=LIMINAR 24/8 H;2=PACIENTE INTERNA 6/24 H;
	//3=MATER AFINIDADE 72H;4=PREFEITURA 15 DIAS;5=21 DIAS
	//-------------------------------------------------------
	If Empty(AllTrim(BE4->BE4_XENT))

		cBxEnt := _aEnt[1]

	ElseIf AllTrim(BE4->BE4_XENT) ==  "1"

		cBxEnt := _aEnt[2]

	ElseIf AllTrim(BE4->BE4_XENT) == "2"

		cBxEnt := _aEnt[3]

	ElseIf AllTrim(BE4->BE4_XENT) == "3"

		cBxEnt := _aEnt[4]

	ElseIf AllTrim(BE4->BE4_XENT) == "4"

		cBxEnt := _aEnt[5]

	ElseIf AllTrim(BE4->BE4_XENT) == "5"

		cBxEnt := _aEnt[6]

	ElseIf AllTrim(BE4->BE4_XENT) == "6"

		cBxEnt := _aEnt[7]

	ElseIf AllTrim(BE4->BE4_XENT) == "7"

		cBxEnt := _aEnt[8]

	EndIf

	//-------------------------------------------------------
	//Status Eletivo
	//-------------------------------------------------------
	//1=ANALIS. ADM, 2=EXIG. ADM, 3=ANALIS. AUD.,
	//4=EXIG. AUD., 5=ANALIS. OPME, 6=OPME AUT, 7=SENHA LIB
	//-------------------------------------------------------
	If Empty(AllTrim(BE4->BE4_YSOPME))

		cBxStat := _aStat[1]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "1"

		cBxStat := _aStat[2]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "2"

		cBxStat := _aStat[3]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "3"

		cBxStat := _aStat[4]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "4"

		cBxStat := _aStat[5]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "5"

		cBxStat := _aStat[6]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "6"

		cBxStat := _aStat[7]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "7"

		cBxStat := _aStat[8]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "8"

		cBxStat := _aStat[9]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "9"

		cBxStat := _aStat[10]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "A"

		cBxStat := _aStat[11]

	ElseIf AllTrim(BE4->BE4_YSOPME)	== "B"

		cBxStat := _aStat[12]

	EndIf

	dDatAut := BE4->BE4_XDTPR

	RestArea(_aArB4)
	RestArea(_aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSM3A3   º Autor ³ Angelo Henrique    º Data ³  28/12/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para realizar o calculo da data prevista.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSM3A3(_cParam)

	Local _aArea 	:= GetArea()
	Local _dRet 	:= CTOD(" ")
	Local _nCalc	:= 0
	Local _cElet	:= ""
	PRIVATE	_nDiasAut := SupergetMV("MV_XDAUTEL", .F., 15)
	PRIVATE	_nDiasDay := SupergetMV("MV_XDAUDAY", .F., 15)
	Default _cParam := "1" //1 - Quando vem da rotina Original || 2 - Quando vem da prorrogação

	//-------------------------------------------------------
	//Classificação de entrada
	//-------------------------------------------------------
	//1=ELETIVO 15 DIAS; 2=DAY CLIN 10 DIAS;
	//3=PACIENTE INTERNA 24 H;4=LIMINAR 24 H;5=NIP 72 H
	//-------------------------------------------------------

	If cEmpAnt = '01'

		_cElet := "ELETIVO "+cValtoChar(_nDiasAut)+" DIAS" //"ELETIVO 15 DIAS"

	Else

		_cElet := "ELETIVO "+cValtoChar(_nDiasAut)+" DIAS" //"ELETIVO 20 DIAS"

	EndIf

	If cEmpAnt = '01'

		_cDay := "DAY CLIN "+cValtoChar(_nDiasDay)+" DIAS" //"DAY CLIN"

	Else

		_cDay := "DAY CLIN "+cValtoChar(_nDiasDay)+" DIAS" //"DAY CLIN"

	EndIf

	If UPPER(AllTrim(cBxEnt)) == _cElet

		If cEmpAnt = '01'

			_nCalc := _nDiasAut //15

		Else

			_nCalc := _nDiasAut //20

		EndIf

	ElseIf UPPER(AllTrim(cBxEnt)) == _cDay

		_nCalc := _nDiasDay

	ElseIf UPPER(AllTrim(cBxEnt)) == "PACIENTE INTERNA 24 H"

		_nCalc := 1

	ElseIf UPPER(AllTrim(cBxEnt)) == "LIMINAR 24 H"

		_nCalc := 1

	ElseIf UPPER(AllTrim(cBxEnt)) == "NIP 72 H"

		_nCalc := 3

	ElseIf UPPER(AllTrim(cBxEnt)) == "URGENCIA/EMERGENCIA"

		_nCalc := 0 //Emergencia/Urgencia

		//ElseIf UPPER(AllTrim(cBxEnt)) == "CIRURG ONCOLOGICA 48 H"
	ElseIf UPPER(AllTrim(cBxEnt)) == "CIRURG ONCOLOGICA 96 H"

		_nCalc := 2

	EndIf

	If _cParam == "1"

		If !(Empty(BE4->BE4_YDTSOL))

			_dRet :=  DaySum(BE4->BE4_YDTSOL, _nCalc)

		Else

			_dRet :=  DaySum(dDataBase, _nCalc)

		EndIf

	Else

		If !(Empty(dDatPro))

			_dRet :=  DaySum(dDatPro, _nCalc)

		Else

			_dRet :=  DaySum(dDataBase, _nCalc)

		EndIf

	EndIf

	RestArea(_aArea)

Return _dRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSM3A4   º Autor ³ Angelo Henrique    º Data ³  23/01/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina utilizada para validar o campo de status            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSM3A4(_cParam)

	Local _lRet 	:= .T.
	Local _cStat	:= ""
	Local _cOptSt	:= ""
	Local cCodUsr 	:= RetCodUsr()

	Default _cParam := ""

	If _cParam == "1"

		_cOptSt := cBxStat

	ElseIf _cParam == "2"

		_cOptSt := cStat1

	ElseIf _cParam == "3"

		_cOptSt := cStat2

	EndIf

	//-------------------------------------------------------
	//Status Eletivo
	//-------------------------------------------------------
	//1=ANALIS. ADM, 2=EXIG. ADM, 3=ANALIS. AUD.,
	//4=EXIG. AUD., 5=ANALIS. OPME, 6=OPME AUT, 7=SENHA LIB
	//-------------------------------------------------------
	If UPPER(AllTrim(_cOptSt)) == "ANALIS. ADM"

		_cStat := "1"

	ElseIf UPPER(AllTrim(_cOptSt)) == "EXIG. ADM"

		_cStat := "2"

	ElseIf UPPER(AllTrim(_cOptSt)) == "ANALIS. AUD."

		_cStat := "3"

	ElseIf UPPER(AllTrim(_cOptSt)) == "EXIG. AUD."

		_cStat := "4"

	ElseIf UPPER(AllTrim(_cOptSt)) == "CUMPRIMENTO AUDITORIA"

		_cStat := "5"

	ElseIf UPPER(AllTrim(_cOptSt)) == "JUNTA MEDICA"

		_cStat := "6"

	ElseIf UPPER(AllTrim(_cOptSt)) == "ANALIS. OPME"

		_cStat := "7"

	ElseIf UPPER(AllTrim(_cOptSt)) == "OPME FINALIZADO"

		_cStat := "8"

	ElseIf UPPER(AllTrim(_cOptSt)) == "AGUARDANDO LIB."

		_cStat := "9"

	ElseIf UPPER(AllTrim(_cOptSt)) == "INTERNACAO LIB."

		_cStat := "A"


	ElseIf UPPER(AllTrim(_cOptSt)) == "OPME AUT FORNEC/PRESTADOR"

		_cStat := "B"

	ElseIf UPPER(AllTrim(_cOptSt)) == "NEGADO"     //MOTTA 13/3/20
		//MOTTA 13/3/20
		_cStat := "C"	                           //MOTTA 13/3/20

	EndIf

	If _cParam == "1"

		If Empty(BE4->BE4_YSOPME) .And. !(Empty(_cStat))

			If !(UPPER(AllTrim(cBxUtil)) == "NAO" .And. _cStat = "9")

				If !(_cStat $ ("1|2|3"))

					Aviso("Atenção","Opção não pode ser escolhida, somente Analise ou Exigência ADM.",{"OK"})
					_lRet := .F.

				EndIf

			Else

				If BE4->BE4_AUDITO = "1" //1=Sim;0=Nao

					Aviso("Atenção","Opção de STATUS não disponivel pois a internação possui auditoria.",{"OK"})
					_lRet := .F.

				EndIf

				If BE4->BE4_AUDITO = "0"

					If !Empty(AllTrim(BE4->BE4_YSOPME))

						If !(AllTrim(BE4->BE4_YSOPME) $ ("1|2"))

							Aviso("Atenção","Opção de STATUS não disponivel pois a internação ja teve movimentações no Status.",{"OK"})
							_lRet := .F.

						EndIf

					EndIf

				EndIf

			EndIf

		EndIf

		If !(_cStat $ ("1|2|3|A")) .And. _lRet //Tecnico Call Center

			//------------------------------------------------------------------------------------
			//Validação para saber se na tela do tecnico de call center foi selecionado a
			//opção de CUMPRIMENTO DE AUDITORIA E JUNTA MEDICA
			//------------------------------------------------------------------------------------
			If _cStat $ ("4|5|6")

				If !Empty(AllTrim(BE4->BE4_YSOPME))

					If BE4->BE4_YSOPME $ ("4|5|6") .And. _cStat $ ("4|5|6")

						//--------------------------------------------------------------------------
						//Se o processo esta em exigência pelo auditor
						//então deve se olhar na tabela de operador de saude
						//para saber se o profissional pode realizar alteração nesse processo
						//--------------------------------------------------------------------------
						DbSelectArea("BX4")
						DbSetOrder(1)
						If DbSeek(xFilial("BX4") + cCodUsr + "0001")

							If BX4->BX4_XJTMED != "1"

								Aviso("Atenção","Opção não pode ser escolhida, pois o usuário não possui acesso. Verificar cadastro de Operador de Sistema.",{"OK"})
								_lRet := .F.

							EndIf

						EndIf

					Else

						Aviso("Atenção","Opção de STATUS não disponivel, pois o processo não esta em Exig. Auditor.",{"OK"})
						_lRet := .F.

					EndIf

				Else

					If !(UPPER(AllTrim(cBxUtil)) == "NAO" .And. _cStat = "9")

						Aviso("Atenção","Opção de STATUS não disponivel, pois o processo não esta em Exig. Auditor.",{"OK"})
						_lRet := .F.

					EndIf

				EndIf

			Else

				If !( UPPER(AllTrim(cBxUtil)) == "NAO" .And. _cStat = "9")

					//--------------------------------------------------------------------------------------------------------------
					//Se já estiver gravado que o OPME finalizou o seu processo, poderá colocar a opção de aguardando liberação
					//--------------------------------------------------------------------------------------------------------------
					If BE4->BE4_YSOPME <> "8"

						Aviso("Atenção","Opção de STATUS não disponivel, pois o processo não esta em Exig. Auditor.",{"OK"})
						_lRet := .F.

					EndIf

				EndIf

			EndIf

		EndIf

		If _cStat = "A" .And. !(BE4->BE4_YSOPME $ "8|9" ) .And. _lRet .And. Empty(BE4->BE4_SENHA) .And. UPPER(AllTrim(cBxUtil)) == "SIM"

			Aviso("Atenção","Opção de STATUS não disponivel para o setor.",{"OK"})
			_lRet := .F.

		EndIf

		//-------------------------------------------------------------------------
		//Se passou pelas validações anteriores, prosseguir com as demais
		//-------------------------------------------------------------------------
		If _lRet

			If !Empty(AllTrim(BE4->BE4_YSOPME))

				If !(BE4->BE4_YSOPME $ ("1|2|3|8|9|A"))

					//------------------------------------------------------------------------------------
					//Validação para saber se na tela do tecnico de call center foi selecionado a
					//opção de CUMPRIMENTO DE AUDITORIA E JUNTA MEDICA
					//------------------------------------------------------------------------------------
					If _cStat $ ("4|5|6")

						If !(BE4->BE4_YSOPME $ ("4|5|6"))

							Aviso("Atenção","Status não pode ser mudado pois esta em processo com outro setor.",{"OK"})
							_lRet := .F.

						EndIf

					Else

						Aviso("Atenção","Status não pode ser mudado pois esta em processo com outro setor.",{"OK"})
						_lRet := .F.

					EndIf

				EndIf

			EndIf

		Else

			If _cStat $ ("5|6") .And. _lRet

				Aviso("Atenção","Status não pode ser mudado pois esta em processo com outro setor.",{"OK"})
				_lRet := .F.

			EndIf

		EndIf

	ElseIf _cParam == "2" //Tecnico OPME

		If !Empty(AllTrim(BE4->BE4_YSOPME))

			If _cStat = "B" //Autorização fornecedor

				If  BE4->BE4_YSOPME != "A" .And. BE4->BE4_YSOPME != "B"//Senha Liberada

					Aviso("Atenção","Status não pode ser mudado para autorização, pois a senha ainda não foi liberada.",{"OK"})
					_lRet := .F.

				EndIf

				If  BE4->BE4_YSOPME != "A"

					Aviso("Atenção","Status não pode ser mudado para autorização, pois a senha ainda não foi liberada.",{"OK"})
					_lRet := .F.

				EndIf

				If BE4->BE4_YSOPME == "B" .And. _lRet //Internação Liberada

					Aviso("Atenção","Status não pode ser mudado, pois a senha já foi liberada.",{"OK"})
					_lRet := .F.

				EndIf

			EndIf

			If !(_cStat $ ("7|8|B")) .And. _lRet

				Aviso("Atenção","Status não pode ser mudado pois esta em processo com outro setor.",{"OK"})
				_lRet := .F.

			EndIf

		Else

			Aviso("Atenção","Opção de STATUS não disponivel para o setor.",{"OK"})
			_lRet := .F.

		EndIf

	EndIf

	If Empty(_cStat) .And. !(Empty(BE4->BE4_YSOPME))

		Aviso("Atenção","Status não pode ser deixado em branco.",{"OK"})
		_lRet := .F.

	EndIf


Return _lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSHEAD   º Autor ³ Angelo Henrique    º Data ³  23/01/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para montar o aHeader da tabela ZZ6 (Mural)         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSHEAD()

	Local _aCbcHd := {}

	noBrw1 := 0 //Zerando o contador aqui para não dar problema.

	RegToMemory("ZZ6")

	DbSelectArea("SX3")
	DbSetOrder(1)
	If DbSeek("ZZ6", .T.)

		While !Eof() .And. SX3->X3_ARQUIVO == "ZZ6"

			If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL

				If !(ALLTRIM(SX3->X3_CAMPO) $ "ZZ6_FILIAL|ZZ6_MATVID|ZZ6_NOMUSR|ZZ6_USU")

					noBrw1++

					AADD(_aCbcHd,{ AllTrim(X3Titulo()),;
						SX3->X3_CAMPO,;
						SX3->X3_PICTURE,;
						IIF(ALLTRIM(SX3->X3_CAMPO)!="ZZ6_TEXT1",SX3->X3_TAMANHO,20),;
						SX3->X3_DECIMAL,;
						SX3->X3_VALID,;
						SX3->X3_USADO,;
						SX3->X3_TIPO,;
						SX3->X3_F3,;
						SX3->X3_CONTEXT,;
						SX3->X3_CBOX,;
						SX3->X3_RELACAO,;
						SX3->X3_WHEN,;
						SX3->X3_VISUAL,;
						SX3->X3_VLDUSER,;
						SX3->X3_PICTVAR,;
						SX3->X3_OBRIGAT})

				EndIf

			EndIf

			DbSkip()

		EndDo

	EndIf

Return _aCbcHd

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSITEM   º Autor ³ Angelo Henrique    º Data ³  23/01/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para montar o aCols   da tabela ZZ6 (Mural)         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSITEM(_cParam,_aCab)

	Local _aArea 	:= GetArea()
	Local _aArZ6 	:= ZZ6->(GetArea())
	Local _aArPr 	:= GetNextAlias()
	Local nCntFor	:= 0
	Local _aItens	:= {}

	Default _cParam := ""
	Default _aCab	:= {}

	If select(_aArPr)>0
		dbSelectArea(_aArPr)
		dbCloseArea()
	EndIf

	DbSelectArea("ZZ6")
	DbSetOrder(1)

	BeginSql alias _aArPr
		%noparser%

		SELECT *
		FROM
			%table:ZZ6% ZZ6
		WHERE
			ZZ6_FILIAL = %xFilial:ZZ6%
			AND ZZ6_CODOPE = %exp:BE4->BE4_CODOPE%
			AND ZZ6_ANOGUI = %exp:BE4->BE4_ANOINT%
			AND ZZ6_MESGUI = %exp:BE4->BE4_MESINT%
			AND ZZ6_NUMGUI = %exp:BE4->BE4_NUMINT%
			AND ZZ6_USU = %exp:_cParam%
			AND //Para pegar somente os pareceres tecnicos do Call Center
			%notDel%
	EndSql

	While (!(_aArPr)->(Eof()))

		Aadd(_aItens,Array(noBrw1+1))

		For nCntFor := 1 To noBrw1

			If ( _aCab[nCntFor][10] != "V" )

				If ( _aCab[nCntFor][8] != "M" )

					If ( _aCab[nCntFor][8] != "D" )

						_aItens[Len(_aItens)][nCntFor] := (_aArPr)->&(_aCab[nCntFor][2])

					Else

						_aItens[Len(_aItens)][nCntFor] := STOD((_aArPr)->&(_aCab[nCntFor][2]))

					EndIf

				Else

					//-------------------------------------------
					//Tratamento para campo Memo
					//-------------------------------------------
					DbSelectArea("ZZ6")
					DbSetOrder(3) //ZZ6_FILIAL+ZZ6_CODOPE+ZZ6_ANOGUI+ZZ6_MESGUI+ZZ6_NUMGUI+ZZ6_USU+ZZ6_SEQ
					If DbSeek(xFilial("ZZ6")+(_aArPr)->(ZZ6_CODOPE+ZZ6_ANOGUI+ZZ6_MESGUI+ZZ6_NUMGUI+ZZ6_USU+ZZ6_SEQ) )

						_aItens[Len(_aItens)][nCntFor] := ZZ6->&(_aCab[nCntFor][2])

					EndIf

				EndIf

			Else

				_aItens[Len(_aItens)][nCntFor] := CriaVar(_aCab[nCntFor][2])

			EndIf

		Next nCntFor

		_aItens[Len(_aItens)][Len(_aCab)+1] := .F.

		(_aArPr)->(dbSkip())

	EndDo

	If select(_aArPr)>0
		dbSelectArea(_aArPr)
		dbCloseArea()
	EndIf

	RestArea(_aArZ6 )
	RestArea(_aArea )

Return _aItens



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSM3B    º Autor ³ Angelo Henrique    º Data ³  24/01/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina utilizada para imputar informações pertinente ao    º±±
±±º          ³tecnico de OPME aonde ele irá atualizar a tela de utilizaçãoº±±
±±º          ³do OPME.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSM3B()

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de cVariable dos componentes                                 ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	Local nOpc 		:= GD_INSERT+GD_DELETE+GD_UPDATE
	Local cIniCpos  := "++ZZ6_SEQ"  // Nome dos campos do tipo caracter que utilizarao incremento automatico.
	Local cAlias	:= GetNextAlias()
	Local cQry		:= ""

	//---------------------------------------------
	//Cabeçalho e Itens da MSNewGetDados
	//---------------------------------------------
	Private _aCabec1 := {}
	Private _aCabec2 := {}
	Private _aItens1 := {}
	Private _aItens2 := {}
	Private noBrw1   := 0 //Contador
	Private _aAlter	 := {"ZZ6_TEXTO"}

	Private dDatOp	 := CtoD(" ")

	Private _aStat1  := {" ","ANALIS. ADM","EXIG. ADM","ANALIS. AUD.","EXIG. AUD.","CUMPRIMENTO AUDITORIA","JUNTA MEDICA","ANALIS. OPME","OPME FINALIZADO","AGUARDANDO LIB.","INTERNACAO LIB.","OPME AUT FORNEC/PRESTADOR","NEGADO"}  //MOTTA 13/3/20

	Private cStat1   := _aStat1[1]

	Private cPfor	 := SPACE(TAMSX3("C7_NUM" )[1])
	Private cPfat	 := SPACE(TAMSX3("C7_NUM" )[1])
	Private cPnom	 := SPACE(TAMSX3("A2_NOME")[1])
	Private nPval	 := 0

	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de Variaveis Private dos Objetos                             ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	SetPrvt("oFont1","oDlg2","oPanel1","oSay1","oSay2","oSay3","oSay4","oGrp1","oBrw1","oGet1","oGet2","oDatOp")
	SetPrvt("oGrp2","oBrw2","oBtn1","oBtn2","oGet4","oGet5")

	If BE4->BE4_YOPME == "0"

		//---------------------------------------------------------------------
		//Inicio
		//---------------------------------------------------------------------
		//Validação das variaveis
		//caso já tenha sido preenchido trazer os campos automaticamente
		//---------------------------------------------------------------------

		//-------------------------------------------------------
		//Status Eletivo
		//-------------------------------------------------------
		//1=ANALIS. ADM, 2=EXIG. ADM, 3=ANALIS. AUD.,
		//4=EXIG. AUD., 5=ANALIS. OPME, 6=OPME AUT, 7=SENHA LIB
		//-------------------------------------------------------
		If Empty(AllTrim(BE4->BE4_YSOPME))

			cStat1 := _aStat1[1]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "1"

			cStat1 := _aStat1[2]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "2"

			cStat1 := _aStat1[3]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "3"

			cStat1 := _aStat1[4]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "4"

			cStat1 := _aStat1[5]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "5"

			cStat1 := _aStat1[6]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "6"

			cStat1 := _aStat1[7]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "7"

			cStat1 := _aStat1[8]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "8"

			cStat1 := _aStat1[9]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "9"

			cStat1 := _aStat1[10]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "A"

			cStat1 := _aStat1[11]

		ElseIf AllTrim(BE4->BE4_YSOPME)	== "B"

			cStat1 := _aStat1[12]

		EndIf

		If !Empty(BE4->BE4_YDOPME)

			dDatOp := BE4->BE4_YDOPME

		EndIf

		If !Empty(AllTrim(BE4->BE4_XPFOR))

			cPfor := BE4->BE4_XPFOR

		EndIf

		If !Empty(AllTrim(BE4->BE4_XPFAT))

			cPfat := BE4->BE4_XPFAT

		EndIf

		//---------------------------------------------------------------------
		//Fim
		//---------------------------------------------------------------------
		//Validação das variaveis
		//caso já tenha sido preenchido trazer os campos automaticamente
		//---------------------------------------------------------------------

		/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
		±± Definicao do Dialog e todos os seus componentes.                        ±±
		Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
		oFont1     := TFont():New( "Arial Narrow",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )
		oDlg2      := MSDialog():New( 092,232,699,927,"Utilização OPME",,,.F.,,,,,,.T.,,,.T. )
		oPanel1    := TPanel():New( 004,004,"",oDlg2,,.F.,.F.,,,336,288,.T.,.F. )

		oSay1      := TSay():New( 100,012,{||"Autorização de Fornecimento:"	},oPanel1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,096,012)
		oSay2      := TSay():New( 144,012,{||"Data OPME Prestador:"			},oPanel1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,008)
		oSay3      := TSay():New( 100,120,{||"Autorização de Faturamento:"	},oPanel1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,108,012)
		oSay4      := TSay():New( 100,232,{||"Status Eletivo"				},oPanel1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,008)
		oSay5      := TSay():New( 144,120,{||"Fornecedor"					},oPanel1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,012)
		oSay6      := TSay():New( 144,232,{||"Valor"						},oPanel1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,010)

		oGrp1      := TGroup():New( 008,008,092,332," Autorização OPME ",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )

		//-------------------------------------------
		//Montagem do aHeader (Cabeçalho) ZZ6 - Mural
		//-------------------------------------------
		_aCabec1 := u_PLSHEAD()

		//----------------------------------------
		// Inicio - Montagem do Acols (Itens)
		//----------------------------------------
		_aItens1 := u_PLSITEM("2",_aCabec1)

		If !Empty(BE4->BE4_SENHA)

			//---------------------------------------------------------
			//Inicio - Montagem das informações de Compras
			//---------------------------------------------------------
			cQry := "SELECT DISTINCT " 											+ CRLF
			cQry += "	NVL(( " 												+ CRLF
			cQry += "		SELECT " 											+ CRLF
			cQry += "			SC7_1.C7_NUM " 									+ CRLF
			cQry += "		FROM " 												+ CRLF
			cQry += "			" + RetSqlName('SC7') + " SC7_1 " 				+ CRLF
			cQry += "		WHERE " 											+ CRLF
			cQry += "			SC7_1.D_E_L_E_T_ = ' ' " 						+ CRLF
			cQry += "			AND SC7_1.C7_XAUTOP = '1' " 					+ CRLF
			cQry += "			AND SC7_1.C7_XSENHA = SC7_PRIM.C7_XSENHA " 		+ CRLF
			cQry += "		GROUP BY SC7_1.C7_NUM " 							+ CRLF
			cQry += "		), ' ') FORNECIMENTO, " 							+ CRLF
			cQry += "	NVL(( " 												+ CRLF
			cQry += "		SELECT  " 											+ CRLF
			cQry += "			SC7_2.C7_NUM " 									+ CRLF
			cQry += "		FROM  " 											+ CRLF
			cQry += "			" + RetSqlName('SC7') + " SC7_2  " 				+ CRLF
			cQry += "		WHERE  " 											+ CRLF
			cQry += "			SC7_2.D_E_L_E_T_ = ' ' " 						+ CRLF
			cQry += "			AND SC7_2.C7_XAUTOP = '2' " 					+ CRLF
			cQry += "			AND SC7_2.C7_XSENHA = SC7_PRIM.C7_XSENHA " 		+ CRLF
			cQry += "		GROUP BY SC7_2.C7_NUM " 							+ CRLF
			cQry += "	),' ') FATURAMENTO, " 									+ CRLF
			cQry += "	NVL(( " 												+ CRLF
			cQry += "		SELECT  " 											+ CRLF
			cQry += "			SUM(SC7_3.C7_TOTAL) TOTAL " 					+ CRLF
			cQry += "		FROM " 												+ CRLF
			cQry += "			" + RetSqlName('SC7') + " SC7_3  " 				+ CRLF
			cQry += "		WHERE  " 											+ CRLF
			cQry += "			SC7_3.D_E_L_E_T_ = ' ' " 						+ CRLF
			cQry += "			AND SC7_3.C7_XAUTOP = '2' " 					+ CRLF
			cQry += "			AND SC7_3.C7_XSENHA = SC7_PRIM.C7_XSENHA " 		+ CRLF
			cQry += "		GROUP BY SC7_3.C7_NUM " 							+ CRLF
			cQry += "	),0) VALOR, " 											+ CRLF
			cQry += "	SC7_PRIM.C7_FORNECE, " 									+ CRLF
			cQry += "	SC7_PRIM.C7_LOJA, " 									+ CRLF
			cQry += "	SA2.A2_NOME NOME " 										+ CRLF
			cQry += "	FROM " 													+ CRLF
			cQry += "		" + RetSqlName('SC7') + " SC7_PRIM, " 				+ CRLF
			cQry += "		" + RetSqlName('SA2') + " SA2 " 					+ CRLF
			cQry += "	WHERE  " 												+ CRLF
			cQry += "		SC7_PRIM.D_E_L_E_T_ = ' ' " 						+ CRLF
			cQry += "		AND SC7_PRIM.C7_XSENHA = '" + BE4->BE4_SENHA + "' "	+ CRLF
			cQry += "		AND SC7_PRIM.C7_FORNECE = SA2.A2_COD " 				+ CRLF
			cQry += "		AND SC7_PRIM.C7_LOJA = SA2.A2_LOJA " 				+ CRLF

			TcQuery cQry New Alias cAlias

			If !cAlias->(EOF())

				cPfor	 := cAlias->FORNECIMENTO
				cPfat	 := cAlias->FATURAMENTO
				cPnom	 := cAlias->NOME
				nPval	 := cAlias->VALOR

			EndIf

			cAlias->(DbCloseArea())

		EndIf

		//---------------------------------------------------------
		//Fim  - Montagem das informações de Compras
		//---------------------------------------------------------

		oBrw1	 := MsNewGetDados():New(020,016,084,324,nOpc,'AllwaysTrue()','AllwaysTrue()',cIniCpos,_aAlter,0,99,'AllwaysTrue()','','AllwaysTrue()',oGrp1,_aCabec1,_aItens1 )

		oGet1    := TGet():New( 116,012,{|u| If(PCount()==0,cPfor,cPfor:=u)},oPanel1,088,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cPfor",,)

		oGet2    := TGet():New( 116,120,{|u| If(PCount()==0,cPfat,cPfat:=u)},oPanel1,088,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cPfat",,)

		oDatOp   := TGet():New( 156,012,{|u| If(PCount()>0,dDatOp:=u,dDatOp)},oPanel1,088,008,'@99/99/9999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDatOp",,)

		oGet4    := TGet():New( 156,120,{|u| If(PCount()==0,cPnom,cPnom:=u)},oPanel1,088,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cPnom",,)

		oGet5    := TGet():New( 156,232,{|u| If(PCount()==0,nPval,nPval:=u)},oPanel1,088,008,'@E 999,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nPval",,)

		oCBox1   := TComboBox():New( 116,232,{|u| If(PCount()>0,cStat1:=u,cStat1)},_aStat1,088,010,oPanel1,,{||u_PLSM3A4("2")},,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cStat1 )

		oGrp2    := TGroup():New( 176,008,264,328,"Laudo Pós OPME",oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )

		//-------------------------------------------
		//Montagem do aHeader (Cabeçalho) ZZ6 - Mural
		//-------------------------------------------
		_aCabec2 := u_PLSHEAD()

		//----------------------------------------
		// Inicio - Montagem do Acols (Itens)
		//----------------------------------------
		_aItens2 := u_PLSITEM("3",_aCabec2)

		oBrw2      := MsNewGetDados():New(184,016,256,320,nOpc,'AllwaysTrue()','AllwaysTrue()',cIniCpos,_aAlter,0,99,'AllwaysTrue()','','AllwaysTrue()',oGrp2,_aCabec2,_aItens2 )

		oBtn1      := TButton():New( 272,/*244*/ 288,"Salvar",oPanel1,{||u_PLSM3B1()	},037,012,,,,.T.,,"",,,,.F. )

		oDlg2:Activate(,,,.T.)

	Else

		Aviso("Atenção","Esta Internação não possui OPME", {"OK"})

	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSM3B1   º Autor ³ Angelo Henrique    º Data ³  28/12/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para gravar as informações inseridas na tela do OPMEº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSM3B1

	Local _aArea 	:= GetArea()
	Local _aArB4 	:= BE4->(GetArea())
	Local _aArZ6 	:= ZZ6->(GetArea())

	Local _cStat 	:= ""
	Local _lValid	:= .T.

	Local aCabec1 	:= aClone(oBrw1:aHeader)
	Local aItens1	:= aClone(oBrw1:aCols)
	Local aCabec2 	:= aClone(oBrw2:aHeader)
	Local aItens2	:= aClone(oBrw2:aCols)
	Local i,j		:= 0
	Local nPosSeq	:= Ascan(aCabec1,{|x| AllTrim(x[2]) == "ZZ6_SEQ"	})
	Local nPosPar	:= Ascan(aCabec1,{|x| AllTrim(x[2]) == "ZZ6_TEXTO"	}) //Valindo para não gravar linhas não preenchidas
	Local _cChvB4	:= BE4->BE4_CODOPE + BE4->BE4_ANOINT + BE4->BE4_MESINT + BE4->BE4_NUMINT

	//---------------------------------
	//Validação para os status
	//---------------------------------
	If !Empty(AllTrim(cStat1))

		If !(u_PLSM3A4("2"))

			_lValid := .F.

		EndIf
	Else
		//BIANCHINI - 07/08/2020 - Criado Este Else para não ser mais possível colocar Status Em Branco
		Aviso("Atenção","Status não pode ser deixado em branco.",{"OK"})
		_lValid := .F.
	EndIf

	If _lValid

		//Fechando a tela
		oDlg2:End()

		//-------------------------------------------------------
		//Status Eletivo
		//-------------------------------------------------------
		//1=ANALIS. ADM, 2=EXIG. ADM, 3=ANALIS. AUD.,
		//4=EXIG. AUD., 5=ANALIS. OPME, 6=OPME AUT, 7=SENHA LIB
		//-------------------------------------------------------
		If UPPER(AllTrim(cStat1)) == "ANALIS. OPME"

			_cStat := "7"

		ElseIf UPPER(AllTrim(cStat1)) == "OPME FINALIZADO"

			_cStat := "8"

		ElseIf UPPER(AllTrim(cStat1)) == "AGUARDANDO LIB."     //MOTTA 12/3/20
			//MOTTA 12/3/20
			_cStat := "9"                                      //MOTTA 12/3/20
			//MOTTA 12/3/20
		ElseIf UPPER(AllTrim(cStat1)) == "INTERNACAO LIB."     //MOTTA 12/3/20
			//MOTTA 12/3/20
			_cStat := "A"                                      //MOTTA 12/3/20

		ElseIf UPPER(AllTrim(cStat1)) == "OPME AUT FORNEC/PRESTADOR"

			_cStat := "B"

		ElseIf UPPER(AllTrim(cStat1)) == "NEGADO"  //MOTTA 13/3/20
			//MOTTA 13/3/20
			_cStat := "C"	                       //MOTTA 13/3/20

		EndIf

		BE4->( RecLock("BE4", .F.) )

		BE4->BE4_YSOPME	:= _cStat
		BE4->BE4_YDOPME := dDatOp
		BE4->BE4_XPFOR	:= cPfor
		BE4->BE4_XPFAT  := cPfat

		BE4->( MsUnLock() )

		//---------------------------------------------
		//Inicio da gravação dos itens ZZ6 (Mural)
		//Primeira gravação é do Tecnico OPME
		//---------------------------------------------

		For i:=1 to Len(aItens1)

			If !aItens1[i][Len(aCabec1)+1] .And. !Empty(AllTrim(aItens1[i,nPosPar]))

				DbSelectArea("ZZ6")
				DbSetOrder(3)
				lFound := DbSeek(xFilial("ZZ6") + _cChvB4  + "2" + aItens1[i,nPosSeq])

				Reclock("ZZ6", !lFound)

				For j:=1 to Len(aCabec1)
					FieldPut(FieldPos(aCabec1[j,2]),aItens1[i,j])
				Next

				ZZ6->ZZ6_FILIAL := xFilial("ZZ6")
				ZZ6->ZZ6_CODOPE := BE4->BE4_CODOPE
				ZZ6->ZZ6_ANOGUI := BE4->BE4_ANOINT
				ZZ6->ZZ6_MESGUI := BE4->BE4_MESINT
				ZZ6->ZZ6_NUMGUI := BE4->BE4_NUMINT
				ZZ6->ZZ6_MATVID := BE4->BE4_MATVID
				ZZ6->ZZ6_SENHA 	:= BE4->BE4_SENHA
				ZZ6->ZZ6_USU	:= "2" //Tecnico opme
				ZZ6->ZZ6_NOMUSR	:= BE4->BE4_NOMUSR
				ZZ6->ZZ6_OPER	:= CUSERNAME
				ZZ6->ZZ6_TEXT1	:= "PARECER TEC. OPME"
				ZZ6->ZZ6_ALIAS	:= "BE4"

				MsUnlock()

			Else

				DbSelectArea("ZZ6")
				DbSetOrder(3)
				If DbSeek(xFilial("ZZ6") + _cChvB4 + "2" + aItens1[i,nPosSeq])

					Reclock("ZZ6", .F.)
					DbDelete()
					MsUnlock()

				EndIf

			EndIf

		Next

		//---------------------------------------------
		//Fim da gravação dos itens ZZ6 (Mural)
		//---------------------------------------------

		//---------------------------------------------
		//Inicio da gravação dos itens ZZ6 (Mural)
		//Segunda gravação é do Tecnico OPME POS
		//---------------------------------------------

		For i:=1 to Len(aItens2)

			If !aItens2[i][Len(aCabec2)+1] .And. !Empty(AllTrim(aItens2[i,nPosPar]))

				DbSelectArea("ZZ6")
				DbSetOrder(3)
				lFound := DbSeek(xFilial("ZZ6") + _cChvB4  + "3" + aItens2[i,nPosSeq])

				Reclock("ZZ6", !lFound)

				For j:=1 to Len(aCabec2)
					FieldPut(FieldPos(aCabec2[j,2]),aItens2[i,j])
				Next

				ZZ6->ZZ6_FILIAL := xFilial("ZZ6")
				ZZ6->ZZ6_CODOPE := BE4->BE4_CODOPE
				ZZ6->ZZ6_ANOGUI := BE4->BE4_ANOINT
				ZZ6->ZZ6_MESGUI := BE4->BE4_MESINT
				ZZ6->ZZ6_NUMGUI := BE4->BE4_NUMINT
				ZZ6->ZZ6_MATVID := BE4->BE4_MATVID
				ZZ6->ZZ6_SENHA 	:= BE4->BE4_SENHA
				ZZ6->ZZ6_USU	:= "3" //Tecnico opme
				ZZ6->ZZ6_NOMUSR	:= BE4->BE4_NOMUSR
				ZZ6->ZZ6_OPER	:= CUSERNAME
				ZZ6->ZZ6_TEXT1	:= "PARECER TEC. OPME POS"
				ZZ6->ZZ6_ALIAS	:= "BE4"

				MsUnlock()

			Else

				DbSelectArea("ZZ6")
				DbSetOrder(3)
				If DbSeek(xFilial("ZZ6") + _cChvB4 + "3" + aItens2[i,nPosSeq])

					Reclock("ZZ6", .F.)
					DbDelete()
					MsUnlock()

				EndIf

			EndIf

		Next

		//---------------------------------------------
		//Fim da gravação dos itens ZZ6 (Mural)
		//---------------------------------------------

		//---------------------------------------------------------------------------------
		//Angelo Henrique - Data:13/09/2021
		//---------------------------------------------------------------------------------
		//Rotina que irá gerar um novo protocolo e disparar SMS para o beneficiário
		//---------------------------------------------------------------------------------
		If (_cStat == 'A' .and. BE4->BE4_YOPME == "1") .Or. (_cStat == 'B' .and. BE4->BE4_YOPME == "0") .Or. _cStat == 'C'
			u_CABA097(BE4->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT),_cStat)
		EndIf
		//---------------------------------------------------------------------------------

	EndIf

	RestArea(_aArZ6)
	RestArea(_aArB4)
	RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSM3C    º Autor ³ Angelo Henrique    º Data ³  24/04/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para criar um novo protocolo de atendimento         º±±
±±º          ³conforme orientado pela ANS.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSM3C(_cTpPar)

	Local _nSla 	:= 0
	Local _cSeq		:= ""
	Local _cCdAre	:= ""
	Local _cDsAre	:= ""
	Local _aArea 	:= GetArea()
	Local _aArZX 	:= SZX->(GetArea())
	Local _aArZY 	:= SZY->(GetArea())
	Local _aArB1 	:= BA1->(GetArea())
	Local _aArBI 	:= BI3->(GetArea())
	Local _aArCG 	:= PCG->(GetArea())
	Local _aArBL 	:= PBL->(GetArea())
	Local _cTpSv	:= IIF(AllTrim(BE4->BE4_TIPADM) $ '4|5',"1016","1036") //BE4_TIPADM = 4 ou 5 (emergência ou urgência)
	Local _cHst 	:= "000015" //Entrada de Pedido
	Local _cTpDm	:= "T" //Solicitação (SX5) Tipo da Demanda
	Local _cChvBenf	:= ""
	Local _cCanal	:= ""
	Local _lAchou	:= .T.

	Default _cTpPar	:= "1" //Se for 1 - Vem da Internação / 2 - Liberação de Internação

	If _cTpPar == "1"

		_cChvBenf	:= BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO)

		//-------------------------------------------------------------
		//Neste campo terá uma chamada para a rotina PLSM3D
		//Esta rotina irá criar automáticamente a numeração e
		//gravar ela no banco
		//-------------------------------------------------------------
		_cSeq 		:= BE4->BE4_XPROTC

	Else

		_cChvBenf	:= BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO)

		//-------------------------------------------------------------
		//Neste campo terá uma chamada para a rotina PLSM3D
		//Esta rotina irá criar automáticamente a numeração e
		//gravar ela no banco
		//-------------------------------------------------------------
		_cSeq 		:= BEA->BEA_XPROTC

	EndIf

	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + _cChvBenf)

		//---------------------------------------------------------------------------
		//Validação do Canal a ser utilizado
		//Pois conforme informado pela Márcia deve ser seguido a regra abaixo
		//---------------------------------------------------------------------------
		If cEmpAnt == "01" //CABERJ

			/*
			||--------------------------------||
			||CODIGO| DESCRICAO				  ||
			||--------------------------------||
			||0001	| MATER PLENO             ||
			||0002	| MATER EXECUTIVO		  ||
			||0003	| MATER MAXIMUS           ||
			||0004	| MATER BASICO            ||
			||0006	| AFINIDADE I             ||
			||0007	| AFINIDADE PLENO         ||
			||0008	| AFINIDADE BASICO        ||
			||0063	| MATER EXECUTIVO I       ||
			||0064	| MATER BASICO I          ||
			||0065	| MATER PLENO I           ||
			||0070	| AFINIDADE EXECUTIVO     ||
			||--------------------------------||
			*/
			If BA1->BA1_CODPLA $ "0001|0002|0003|0004|0006|0007|0008|0063|0064|0065|0070"

				_cCanal := "000004" //ura mater afinidade

			Else

				_cCanal := "000021" //ura integral multipatrocínio

			EndIf

		Else

			_cCanal := "000021" //ura integral multipatrocínio

		EndIf

		//------------------------------------------
		//Pegando a quantidade de SLA
		//------------------------------------------
		DbSelectArea("PCG")
		DbSetOrder(1)
		If DbSeek(xFilial("PCG") + PADR(AllTrim(_cTpDm),TAMSX3("PCG_CDDEMA")[1]) + "000006" + _cCanal + PADR(AllTrim(_cTpSv),TAMSX3("PCG_CDSERV")[1]) )

			_nSla := PCG->PCG_QTDSLA

		Else

			_nSla := 0

		EndIf

		//----------------------------------------------
		//Ponterar na Tabela de PBL (Tipo de Serviço)
		//Pegando assim a Area
		//----------------------------------------------
		DbSelectArea("PBL")
		DbSetOrder(1)
		If DbSeek(xFilial("PBL") + PADR(AllTrim(_cTpSv),TAMSX3("PBL_YCDSRV")[1]))

			_cCdAre := PBL->PBL_AREA
			_cDsAre := PBL->PBL_YDEPTO

		EndIf

		DbSelectArea("SZX")
		DbSetOrder(1)
		If DbSeek(xFilial("SZX") + _cSeq)

			If UPPER(Alltrim(SZX->ZX_USDIGIT)) == "SISTEMA"

				RecLock("SZX",.F.)

				SZX->ZX_FILIAL 	:= xFilial("SZX")
				SZX->ZX_DATDE 	:= dDataBase
				SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")
				SZX->ZX_DATATE 	:= dDataBase
				SZX->ZX_HORATE 	:= STRTRAN(TIME(),":","")
				SZX->ZX_NOMUSR 	:= BA1->BA1_NOMUSR
				SZX->ZX_CODINT 	:= BA1->BA1_CODINT
				SZX->ZX_CODEMP 	:= BA1->BA1_CODEMP
				SZX->ZX_MATRIC 	:= BA1->BA1_MATRIC
				SZX->ZX_TIPREG 	:= BA1->BA1_TIPREG
				SZX->ZX_DIGITO 	:= BA1->BA1_DIGITO
				SZX->ZX_TPINTEL	:= "2" 		//Status Encerrado
				SZX->ZX_YDTNASC	:= BA1->BA1_DATNAS
				SZX->ZX_EMAIL 	:= BA1->BA1_EMAIL
				SZX->ZX_CONTATO	:= ""
				SZX->ZX_YPLANO 	:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
				SZX->ZX_TPDEM	:= _cTpDm 	//Tipo de Demanda
				SZX->ZX_CANAL	:= _cCanal
				SZX->ZX_SLA  	:= _nSla	//SLA
				SZX->ZX_PTENT 	:= "000006" //Porta de Entrada = Telefone
				SZX->ZX_CODAREA := _cCdAre	//Codigo da Area
				SZX->ZX_YAGENC  := _cDsAre	//Descrição da Area
				SZX->ZX_VATEND	:= "3"    	//Seguindo o protocolo anterior (Novo PA não utiliza este campo)
				SZX->ZX_TPATEND := "1" 		//At. CABERJ
				SZX->ZX_USDIGIT	:= CUSERNAME//Usuário Digitador
				SZX->ZX_CPFUSR	:= BA1->BA1_CPFUSR
				SZX->ZX_PESQUIS := "4" //Não Avaliado

				// FRED: campo igualado em ambas as empresas
				//If cEmpAnt = "01"
				SZX->ZX_YDTINC	:= dDataBase
				/*
				Else
					SZX->ZX_YDTINIC	:= dDataBase
				EndIf
				*/
				// FRED: fim da alteração

				SZX->(MsUnLock())

				//-----------------------------------
				//Itens
				//-----------------------------------
				DbSelectArea("SZY")
				dbSetorder(1)
				_lAchou := DbSeek(xFilial("SZY") + AllTrim(_cSeq))

				RecLock("SZY",!_lAchou)

				SZY->ZY_FILIAL 	:= xFilial("SZY")
				SZY->ZY_SEQBA	:= _cSeq
				SZY->ZY_SEQSERV	:= "000001"
				SZY->ZY_DTSERV	:= dDataBase
				SZY->ZY_HORASV	:= STRTRAN(TIME(),":","")
				SZY->ZY_TIPOSV	:= _cTpSv

				If _cTpPar == "1"

					SZY->ZY_OBS		:= "Protocolo referente a liberação número: " + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT)

				Else

					SZY->ZY_OBS		:= "Protocolo referente a liberação número: " + BEA->(BEA_CODRDA + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT)

				EndIf

				SZY->ZY_RESPOST := "Protocolo gerado de forma automatica pelo sistema."
				SZY->ZY_HISTPAD	:= _cHst
				SZY->ZY_USDIGIT	:= CUSERNAME //Usuário Digitador
				SZY->ZY_PESQUIS := "4" //Não Avaliado

				SZY->(MsUnLock())

			EndIf

		EndIf

	EndIf

	If INCLUI

		If _cTpPar == "1"

			Aviso("Atenção","Foi gerado o protocolo de atendimento: " + _cSeq + " referente a esta internação.", {"OK"} )

		Else

			Aviso("Atenção","Foi gerado o protocolo de atendimento: " + _cSeq + " referente a esta liberação.", {"OK"} )

		EndIf

	EndIf

	RestArea(_aArBL)
	RestArea(_aArCG)
	RestArea(_aArZX)
	RestArea(_aArZY)
	RestArea(_aArB1)
	RestArea(_aArBI)
	RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSM3D    º Autor ³ Angelo Henrique    º Data ³  08/08/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para gerar a numeração do PA e já gravar a numeraçãoº±±
±±º          ³pois conforme visto, a ANS pede que a numeração seja        º±±
±±º          ³informada no inicio da internação.                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLSM3D

	Local _cRet 	:= "" //Irá retornar o protocolo gerado
	Local _cDia	 	:= GetMV("MV_XDIAPA" ) //Possui a data atual da PA
	Local _cCntPA	:= GetMV("MV_XCNTPA" ) //Possui o contador atual da PA
	Local _cRegAns 	:= GetMV("MV_XREGANS") //Possui o número do registro na ANS
	Local _lAchou	:= .T.

	_cRet := U_GERNUMPA()

	DbSelectArea("SZX")
	DBSetOrder(1)
	_lAchou := DbSeek(xFilial("SZX") + AllTrim(_cRet))

	RecLock("SZX",!_lAchou)

	SZX->ZX_FILIAL 	:= xFilial("SZX")
	SZX->ZX_SEQ 	:= _cRet
	SZX->ZX_DATDE 	:= dDataBase
	SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")
	SZX->ZX_TPINTEL	:= "2" 		 //Status Encerrado

	//------------------------------------------------------------------------------
	//Inicialmente será criado o PA com este usuário, para caso
	//o mesmo não seja efetuado (criado), possa ser excluído automáticamente
	//se a internação for inserida a informação do digitador será atualizada
	//------------------------------------------------------------------------------
	SZX->ZX_USDIGIT	:= "SISTEMA" //Usuário Digitador
	SZX->ZX_PESQUIS := "4" //Não Avaliado

	SZX->(MsUnLock())

	//Endif

Return _cRet

//*----------------------------------------------------------------------------
//*Função: TelaMail                                                           *
//*----------------------------------------------------------------------------
// Autor: Mateus Medeiros       |    Data: 09/11/2017                         *
//*----------------------------------------------------------------------------
//* Função para realizar a montagem da tela onde será informado o e-mail do   *
//* prestador                                                                 *
//*----------------------------------------------------------------------------
Static Function TelaMail()

	//*----------------------------
	//* Declaração de Variáveis   *
	//*----------------------------
	Local oGroup 	:= Nil
	Local oSay   	:= Nil
	Local oGet   	:= Nil
	Local cTit 	   	:= "Envio de Email Prestador"
	Private oDlg   	:= Nil
	Private cMail  	:= BE4->BE4_XEMAIL

	//*-----------------------------------------------------
	//* Definicao do Dialog e todos os seus componentes.   *
	//*-----------------------------------------------------
	oDlg    	:= MSDialog():New( 092,237,251,625,cTit,,,.F.,,,,,,.T.,,,.T. )
	oGrp      	:= TGroup():New( 008,005,070,189,"",oDlg,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay      	:= TSay():New( 020,050,{|| "Informe o E-mail do Prestador" },oGrp,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,136,008)
	oGet		:= TGet():New( 035,008,{|u|	IIf(PCount() == 0,	cMail	, cMail   := u)},oGrp,180,008,/*picture*/,{|| u_CABV037( cMail )}/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.F./*[ uParam18]*/,.F./*[ uParam19]*/,/*change*/,.F.,.F.,/*[ uParam23]*/,"cMail",,,,.T.,.F.)
	oBtn1       := TButton():New( 056,145,"Enviar",oGrp,{ || if( u_CABV037( cMail ),Processa( {|| EnviaMail() }, "Aguarde...", "Enviando E-mail para o Prestador e Beneficiário...",.F.),alert(OemtoAnsi("Informe um e-mail válido!"))) },037,012,,,,.T.,,"",,,,.F. )

	oDlg:Activate(,,,.T.)

Return

//*----------------------------------------------------------------------------
//*Função: EnviaMail                                                          *
//*----------------------------------------------------------------------------
//*Autor: Mateus Medeiros       |    Data: 09/11/2017                         *
//*----------------------------------------------------------------------------
//* Função para realizar a montagem do e-mail e chamada da função ZSendMail   *
//*----------------------------------------------------------------------------
Static Function EnviaMail()

	Local cMensagem := ""
	Local cAssunto  := OemToAnsi(iif(cEmpAnt == "01","HOMOLOGAÇÃO CABERJ - ","HOMOLOGAÇÃO INTEGRAL - ")+"Autorização de Internação: "/*+BE4->BE4_XBRSEN*/)
	Local nX 		:= 0
	Local nOk		:= 0

	Private cEmail    := cMail
	// Desta forma por ter que enviar somente dois e-mais, um para o fornecedor e outro para o beneficiário
	For nX := 1 to 2

		cMensagem := MontaMail(nX)

		if u_ZSendMail(/*cAccount*/,/*cPassword*/,/*cServer*/,/*cFrom*/,cEmail,cAssunto,cMensagem,/*cAttach*/,/*cEmailCCC*/,/*lMsg1*/)
			nOk += 1

		endif

	Next nX

	If nOk > 0
		oDlg:End()
		MsgBox("Email enviado com Sucesso !!","Informação","INFO")
	Endif

Return

//*------------------------------------------------------
//*Função: EnviaMail                                    *
//*------------------------------------------------------
//*Autor: Mateus Medeiros       |    Data: 09/11/2017   *
//*------------------------------------------------------
//* Montagem de E-mail que será enviado ao Prestador.   *
//*------------------------------------------------------
// Parâmetros:

//*------------------------------------------------------

Static Function MontaMail(nTpEnv)

	Local cArqTxt     := IIF(cEmpAnt == '01',"\HTML\AUTINTERNACAO_CABERJ.HTML","\HTML\AUTINTERNACAO_INTEGRAL.HTML")   // Local do Modelo HTML (Protheus_Data\...)
	Local nHdl        := fOpen(cArqTxt,68)
	Local cBody	  	  := ""
	Local cPlano   	  := ""
	Local cNomBenef	  := ""
	Local cMat 		  := BE4->(BE4_CODOPE+"."+BE4_CODEMP+"."+BE4_MATRIC+"."+BE4_TIPREG+"-"+BE4_DIGITO)
	Local cMatric     := BE4->(BE4_CODOPE+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO)
	Local cAlias      := GetNextAlias()

	If nHdl == -1
		//alert("O arquivo de nome "+cArqTxt+" nao pode ser aberto! Verifique os parametros.","Atencao!")
		Return ""
	Endif

	nBtLidos := fRead(nHdl,@cBody,99999)
	fClose(nHdl)

	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + cMatric)

		cNomBenef := BA1->BA1_NOMUSR
		cPlano    := Alltrim(GetAdvFVal("BI3","BI3_DESCRI",xFilial("BA1")+BA1_CODINT+BA1->BA1_CODPLA,5))
		if nTpEnv > 1
			cEmail    := BA1->BA1_EMAIL
		endif
	EndIf

	if select(cAlias) > 0
		dbselectarea(cAlias)
		dbclosearea()
	endif


	cBody := StrTran(cBody,"_cBenef"   		, cNomBenef)
	cBody := StrTran(cBody,"_cPrest"   		, iif(nTpEnv == 1,BE4->BE4_NOMRDA,cNomBenef) )
	cBody := StrTran(cBody,"_cPlan"   		, cPlano)


	cMatric := StrTran(cMatric,"."   			, "&#46;")
	cMatric := StrTran(cMatric,"-"   			, "&#45;")

	cBody := StrTran(cBody,"_cMat"   		, cMatric)
	cBody := StrTran(cBody,"_nIntern"   	, BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT))
	cBody := StrTran(cBody,"_nPa"   		, BE4->BE4_XPROTC)

Return cBody
