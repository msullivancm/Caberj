#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*/{Protheus.doc} CABA231
Rotina utilizada para o programa de CBC (carteira bem cuidada)
para a casa da moeda (CMB)
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
User Function CABA231()

	Local aLegenda      := {}

	Private cCadastro   := "Cuidado Personalizado - CMB"
	Private aRotina     := {}

	aRotina     		:= {  { "Visualizar", "AxVisual"    , 00, 02 } ,;
		{ "Incluir"	 	    , "U_CABA231A"  , 00, 03 } ,;
		{ "Alterar"	 	    , "AxAltera"    , 00, 04 } ,;
		{ "Legenda"         , "U_CABA231B"  , 00, 02 } ,;
		{ "Envio de Email"  , "U_CABA231C"  , 00, 02 } ,;
		{ "Relat de Envio"  , "U_CABR036"   , 00, 02 } ,;
		{ "Relat de Benef"  , "U_CABR037"   , 00, 02 } ,;
		{ "Excluir"	 	    , "U_CABA231D"  , 00, 05 } }

	aLegenda 		    := {{"(PES->PES_FIMVIG < DATE() .AND. !EMPTY(PES->PES_FIMVIG))" 		,"BR_VERMELHO"  },;
		{"EMPTY(PES->PES_FIMVIG) .OR. (PES->PES_FIMVIG >= DATE() .AND. !EMPTY(PES->PES_FIMVIG))"  ,"BR_VERDE"	    }}

	DbSelectArea( "PES" )
	DbGoTop()
	mBrowse(,,,,"PES",,,,,,aLegenda)

Return

/*/{Protheus.doc} CABA231A
Rotina que irá efetuar o disparo de e-mail para o beneficiário
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
User Function CABA231A

	Local _cMat     := ""
	Local _cProt    := ""
	Local _nOpc		:= 0

	_nOpc := AxInclui("PES", 0, 3)

	If _nOpc == 1

		_cMat 		:= PES->PES_USUARI

		//------------------------------------------
		//Criação automática do protocolo
		//------------------------------------------
		_cProt := CABA231C4(_cMat,PES->PES_SERVIC,.F.)

		If !Empty(_cProt)

			Aviso("Atenção","Protocolo criado com sucesso e vinculado ao processo de inclusão",{"OK"})

		Else

			Aviso("Atenção","Problema na inclusão do protocolo de vinculo, favor entrar em contato com a TI",{"OK"})

		EndIF

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1")+_cMat)

			DbSelectArea("PES")
			DbSetOrder(3)
			If DbSeek (xFilial("PES")+_cMat)

				RecLock("PES",.F.)

				PES->PES_CODINT := BA1->BA1_CODINT
				PES->PES_CODEMP := BA1->BA1_CODEMP
				PES->PES_MATRIC := BA1->BA1_MATRIC
				PES->PES_TIPREG := BA1->BA1_TIPREG
				PES->PES_DIGITO := BA1->BA1_DIGITO
				PES->PES_PROTOC	:= _cProt

				PES->(MsUnlock())

			EndIf

		EndIf

	EndIf

Return

/*/{Protheus.doc} CABA231B
Rotina que irá efetuar o disparo de e-mail para o beneficiário
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
User Function CABA231B

	BrwLegenda("Cuidado Personalizado - CMB    ","  Legenda  ",{{"BR_VERMELHO", "Programa Concluido."},;
		{"BR_VERDE"		,"Programa Ativo."	    }})

Return

/*/{Protheus.doc} CABA231C
Rotina que irá efetuar o disparo de e-mail para o beneficiário
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
User Function CABA231C

	Local _aAreBA1		:= BA1->(GetArea())

	Private cGetAssu   	:= Space(250)
	Private cGetCPF    	:= Space(TAMSX3("BA1_CPFUSR")[1])
	Private cGetEmail  	:= Space(TAMSX3("BA1_EMAIL" )[1])
	Private cGetEmpre  	:= Space(250)
	Private cGetMatr   	:= Space(17)
	Private cGetNome   	:= Space(250)
	Private cGetPlano  	:= Space(250)
	Private cMGetCont 	:= SPACE(250)
	Private cGetServ	:= Space(TAMSX3("PBL_YCDSRV" )[1])
	Private cGetDsc		:= Space(TAMSX3("PBL_YDSSRV" )[1])

	Private oFont1		:= NIL
	Private oDlg1		:= NIL
	Private oGrp1		:= NIL
	Private oSayNome	:= NIL
	Private oSayEmail	:= NIL
	Private oSayTpSer	:= NIL
	Private oSayMatr	:= NIL
	Private oSayCPF		:= NIL
	Private oSayEmpre	:= NIL
	Private oSayPlano	:= NIL
	Private oGetEmail	:= NIL
	Private oGetMatr	:= NIL
	Private oGetCPF		:= NIL
	Private oGetEmpre	:= NIL
	Private oGetPlano	:= NIL
	Private oGetServ  	:= Nil
	Private oGetDsc  	:= Nil
	Private oGrp2		:= NIL
	Private oSayAssu	:= NIL
	Private oSayCont	:= NIL
	Private oGetAssu	:= NIL
	Private oMGetCont	:= Nil
	Private oBtn1		:= NIL
	Private oBtn2		:= NIL

	If MsgYesNo("Deseja carregar os dados do beneficiário selecionado?", "Carregar Informações")

		CABA231C1("1")

	EndIf

	oFont1     	:= TFont():New( "MS Sans Serif",0,-13,,.F.,0,,400,.F.,.F.,,,,,, )

	oDlg1      	:= MSDialog():New( 092,232,708,1388,"Envio de E-mail - Cuidado Personalizado - CMB",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      	:= TGroup():New( 000,004,064,568,"     Informações do Beneficiário     ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayNome   	:= TSay():New( 014,236,{||"Nome"			},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,024,008)
	oSayEmail  	:= TSay():New( 048,008,{||"Email:"			},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,024,008)
	oSayTpSer  	:= TSay():New( 048,236,{||"Tipo Serviço:"	},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,040,008)
	oSayMatr   	:= TSay():New( 014,008,{||"Matricula"		},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oSayCPF    	:= TSay():New( 014,140,{||"CPF"				},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,020,008)
	oSayEmpre  	:= TSay():New( 030,008,{||"Empresa"			},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oSayPlano  	:= TSay():New( 030,236,{||"Plano"			},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,024,008)
	oGetNome   	:= TGet():New( 012,260,{|u| If(PCount()>0,cGetNome	:= u ,cGetNome	)},oGrp1,300,010,'',				,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,{||.F.}	,.F.,.F.,					,.F.,.F.,""			,"cGetNome"	,,)
	oGetEmail  	:= TGet():New( 046,040,{|u| If(PCount()>0,cGetEmail	:= u ,cGetEmail	)},oGrp1,188,010,'',				,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,			,.F.,.F.,					,.F.,.F.,""			,"cGetEmail",,)
	oGetMatr   	:= TGet():New( 012,040,{|u| If(PCount()>0,cGetMatr	:= u ,cGetMatr	)},oGrp1,092,010,'',{||CABA231C2()}	,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,			,.F.,.F.,{||CABA231C1("2")} ,.F.,.F.,"CABC03"	,"cGetMatr"	,,)

	oGetCPF    	:= TGet():New( 012,156,{|u| If(PCount()>0,cGetCPF	:= u ,cGetCPF	)},oGrp1,072,010,'',				,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,{||.F.},.F.,.F.,,.F.,.F.,""		,"cGetCPF"		,,)
	oGetEmpre  	:= TGet():New( 028,040,{|u| If(PCount()>0,cGetEmpre	:= u ,cGetEmpre	)},oGrp1,188,010,'',				,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,{||.F.},.F.,.F.,,.F.,.F.,""		,"cGetEmpre"	,,)
	oGetPlano  	:= TGet():New( 028,260,{|u| If(PCount()>0,cGetPlano	:= u ,cGetPlano	)},oGrp1,300,010,'',				,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,{||.F.},.F.,.F.,,.F.,.F.,""		,"cGetPlano"	,,)
	oGetServ  	:= TGet():New( 046,280,{|u| If(PCount()>0,cGetServ	:= u ,cGetServ	)},oGrp1,036,010,'',{||CABA231C5()}	,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,		 ,.F.,.F.,,.F.,.F.,"PBLPA"	,"cGetServ"		,,)
	oGetDsc  	:= TGet():New( 046,324,{|u| If(PCount()>0,cGetDsc	:= u ,cGetDsc	)},oGrp1,236,010,'',				,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,{||.F.},.F.,.F.,,.F.,.F.,""		,"cGetDsc"		,,)

	oGrp2      	:= TGroup():New( 068,004,296,568,"     Informações de Email     ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSayAssu   	:= TSay():New( 084,008,{||"Assunto"			},oGrp2,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,028,008)
	oSayCont   	:= TSay():New( 108,008,{||"Conteudo do Email"},oGrp2,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,064,008)
	oGetAssu   	:= TGet():New( 084,040,{|u| If(PCount()>0,cGetAssu:=u,cGetAssu)},oGrp2,520,010,'',,CLR_BLACK,CLR_WHITE,oFont1,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetAssu",,)
	oMGetCont	:= TMultiGet():New( 120,008,{|u| If(PCount()>0,cMGetCont:=u,cMGetCont)},oGrp2,552,152,oFont1,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

	oBtn1      	:= TButton():New( 276,468,"Enviar"	,oGrp2,{||CABA231C3()	},037,012,,oFont1,,.T.,,"",,,,.F. )
	oBtn2      	:= TButton():New( 276,516,"Cancelar",oGrp2,{||oDlg1:End()	},037,012,,oFont1,,.T.,,"",,,,.F. )

	oGetMatr:SetFocus()

	oDlg1:Activate(,,,.T.)

	RestArea(_aAreBA1)

Return

/*/{Protheus.doc} CABA231C1
Rotina que irá atualizar os campos da tela de envio de email
na parte dos dados do beneficiário
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
Static Function CABA231C1(_cParam)

	Local _aAreBA1 	:= BA1->(GetArea())
	Local _aAreBQC 	:= BQC->(GetArea())
	Local _aAreBI3 	:= BI3->(GetArea())

	DEFAULT _cParam	:= "1"

	If _cParam == "1"

		cGetMatr := PES->PES_USUARI

	EndIf

	If !Empty(AllTrim(cGetMatr))

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + cGetMatr)

			DbSelectArea("BQC")
			DbSetOrder(1)//BQC_FILIAL+BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB
			If DbSeek(xFilial("BQC") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB) )

				DbSelectArea("BI3")
				DbSetOrder(1) //BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
				If DbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA))

					cGetCPF    	:= BA1->BA1_CPFUSR
					cGetEmail  	:= BA1->BA1_EMAIL
					cGetEmpre  	:= BA1->BA1_CODEMP + " - " + AllTrim(BQC->BQC_DESCRI)
					cGetNome   	:= BA1->BA1_NOMUSR
					cGetPlano  	:= BA1->BA1_CODPLA + " - " + AllTrim(BI3->BI3_DESCRI)

				EndIf

			EndIf

		EndIf

	EndIf

	RestArea(_aAreBI3)
	RestArea(_aAreBQC)
	RestArea(_aAreBA1)

Return

/*/{Protheus.doc} CABA231C2
Rotina que irá validar a matricula preenchida
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
Static Function CABA231C2()

	Local _aAreBA1 	:= BA1->(GetArea())
	Local _aAreBQC 	:= BQC->(GetArea())
	Local _aAreBI3 	:= BI3->(GetArea())
	Local _lValid 	:= .T.

	If !Empty(AllTrim(cGetMatr))

		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + cGetMatr)

			DbSelectArea("BQC")
			DbSetOrder(1)//BQC_FILIAL+BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB
			If DbSeek(xFilial("BQC") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB) )

				DbSelectArea("BI3")
				DbSetOrder(1) //BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
				If DbSeek(xFilial("BI3")+BA1->(BA1_CODINT+BA1_CODPLA))

					cGetCPF    	:= BA1->BA1_CPFUSR
					cGetEmail  	:= BA1->BA1_EMAIL
					cGetEmpre  	:= BA1->BA1_CODEMP + " - " + AllTrim(BQC->BQC_NREDUZ)
					cGetNome   	:= BA1->BA1_NOMUSR
					cGetPlano  	:= BA1->BA1_CODPLA + " - " + AllTrim(BI3->BI3_DESCRI)

				Else

					Aviso("Atenção","Produto não localizado para este beneficiário, favor verificar",{"OK"})
					_lValid := .F.

				EndIf

			Else

				Aviso("Atenção","Subcontrato não localizado para este beneficiário, favor verificar",{"OK"})
				_lValid := .F.

			EndIf

		Else

			Aviso("Atenção","Matricula preenchida não localizada, favor verificar",{"OK"})
			_lValid := .F.

		EndIf

		If !_lValid

			cGetCPF    	:= ""
			cGetEmail  	:= ""
			cGetEmpre  	:= ""
			cGetNome   	:= ""
			cGetPlano  	:= ""
			cGetMatr   	:= ""
			cGetMatr   	:= Space(17)

			oDlg1:Refresh()

		EndIf

	EndIf

	RestArea(_aAreBI3)
	RestArea(_aAreBQC)
	RestArea(_aAreBA1)

Return _lValid


/*/{Protheus.doc} CABA231C1
Rotina que irá efetuar o envio apartir do que foi informado em tela
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
Static Function CABA231C3()

	Local _lEnvia 	:= .T.
	Local a_Htm		:= ""
	Local c_CC		:= "protocolodeatendimento@caberj.com.br"

	Private a_Msg	:= {}
	Private _cProt	:= ""

	If MsgYesNo("Será enviado o e-mail para o beneficiário informado, deseja prosseguir?", "Envio de E-mail")

		If Empty(AllTrim(cGetMatr)) .And. _lEnvia

			Aviso("Atenção","Para enviar e-mail o campo matricula não pode estar em branco.",{"OK"})
			_lEnvia := .F.

		EndIf

		If Empty(AllTrim(cGetAssu)) .And. _lEnvia

			Aviso("Atenção","Para enviar e-mail o campo assunto não pode estar em branco.",{"OK"})
			_lEnvia := .F.

		EndIf

		If Empty(AllTrim(cGetEmail)) .And. _lEnvia

			Aviso("Atenção","Para enviar e-mail o campo e-mail não pode estar em branco.",{"OK"})
			_lEnvia := .F.

		EndIf

		If Empty(AllTrim(cMGetCont)) .And. _lEnvia

			Aviso("Atenção","Para enviar e-mail o campo conteudo não pode estar em branco.",{"OK"})
			_lEnvia := .F.

		EndIf

		If _lEnvia

			If cEmpAnt == '01'
				a_Htm := ""
			Else
				a_Htm := "\HTML\CARTEIRABEMCUIDADA.HTML"
			EndIf

			cMGetCont := STRTRAN(cMGetCont,"'"," ")
			cGetAssu  := STRTRAN(cGetAssu,"'"," ")

			aAdd( a_Msg, { "_cBenef"	, cGetNome					}) //Nome do Beneficiário
			aAdd( a_Msg, { "_cConteudo", cMGetCont	}) //Conteudo do E-mail

			//Rotina de disparo
			If Env_1(a_Htm, cGetEmail, c_CC, cGetAssu, a_Msg )

				//--------------------------------------------------------------
				//Gerar protocolo de atendimento deste processo para a CBC
				//--------------------------------------------------------------
				_cProt := CABA231C4(,,.T.)

				//--------------------------------------------------------------
				//Gravar LOG de envio
				//--------------------------------------------------------------
				GRVLOGENV()

				Aviso("Atenção","Email enviado com sucesso. Protocolo gerado para esse envio: " + _cProt,{"OK"})

				oDlg1:End()

			EndIf

		EndIf

	EndIf

Return

/*/{Protheus.doc} CABA231C4
Rotina que irá criar de forma automática o protocolo do envio de e-mail
@type function
@version  1.0
@author angelo.cassago
@since 21/07/2022
@return variant, Retorno do numero do protocolo 
/*/
Static Function CABA231C4(_cMat,_cServico,_lEmail)

	Local _nSla 		:= 0
	Local _cSeq			:= "" //Irá retornar o protocolo gerado
	Local _cCdAre		:= ""
	Local _cDsAre		:= ""
	Local _aArea 		:= GetArea()
	Local _aArZX 		:= SZX->(GetArea())
	Local _aArZY 		:= SZY->(GetArea())
	Local _aArB1 		:= BA1->(GetArea())
	Local _aArBI 		:= BI3->(GetArea())
	Local _aArCG 		:= PCG->(GetArea())
	Local _aArBL 		:= PBL->(GetArea())
	Local _cTpSv		:= ""
	Local _cHst 		:= "000255" //ACOMPANHAMENTO CBC
	Local _cTpDm		:= "I" //Informação (SX5) Tipo da Demanda
	Local _cChvBenf		:= ""
	Local _cCanal		:= "000035" // Ag CMB
	Local _cPotEnt		:= " "
	Local _ni			:= 0
	Local _cMsgPt		:= ""

	DEFAULT _cMat		:= ""
	DEFAULT _cServico	:= ""
	DEFAULT _lEmail		:= .F.

	If !Empty(_cMat)

		_cChvBenf	:= _cMat

	Else

		_cChvBenf	:= cGetMatr

	EndIf

	If !Empty(_cServico)

		_cTpSv := _cServico

	ElseIf Empty(_cServico) .and. _lEmail

		_cTpSv := cGetServ 

	EndIf

	If _lEmail

		_cPotEnt := "000002" //Email

	Else

		_cPotEnt := "000006" //Telefone

	EndIf

	_cSeq := U_GERNUMPA()

	DbSelectArea("SZX")
	DBSetOrder(1)
	_lAchou := DbSeek(xFilial("SZX") + AllTrim(_cSeq))

	RecLock("SZX",!_lAchou)

	SZX->ZX_FILIAL 	:= xFilial("SZX")
	SZX->ZX_SEQ 	:= _cSeq
	SZX->ZX_DATDE 	:= dDataBase
	SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")
	SZX->ZX_TPINTEL	:= "2" 		 //Status Encerrado
	SZX->ZX_USDIGIT	:= "SISTEMA" //Usuário Digitador
	SZX->ZX_PESQUIS := "4"       //Não Avaliado

	SZX->(MsUnLock())

	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + _cChvBenf)

		//------------------------------------------
		//Pegando a quantidade de SLA
		//------------------------------------------
		DbSelectArea("PCG")
		DbSetOrder(1)
		If DbSeek(xFilial("PCG") + PADR(AllTrim(_cTpDm),TAMSX3("PCG_CDDEMA")[1]) + _cPotEnt + _cCanal + PADR(AllTrim(_cTpSv),TAMSX3("PCG_CDSERV")[1]) )

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
				SZX->ZX_CONTATO	:= '('+BA1->BA1_DDD +')'+ BA1->BA1_TELEFO + ' ' + BA1->BA1_YCEL
				SZX->ZX_YPLANO 	:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
				SZX->ZX_TPDEM	:= _cTpDm 	//Tipo de Demanda
				SZX->ZX_CANAL	:= _cCanal
				SZX->ZX_SLA  	:= _nSla	//SLA
				SZX->ZX_PTENT 	:= _cPotEnt	//Porta de Entrada = Telefone
				SZX->ZX_CODAREA := _cCdAre	//Codigo da Area
				SZX->ZX_YAGENC  := _cDsAre	//Descrição da Area
				SZX->ZX_VATEND	:= "3"    	//Seguindo o protocolo anterior (Novo PA não utiliza este campo)
				SZX->ZX_TPATEND := "1" 		//At. CABERJ
				SZX->ZX_USDIGIT	:= CUSERNAME//Usuário Digitador
				SZX->ZX_CPFUSR	:= BA1->BA1_CPFUSR
				SZX->ZX_PESQUIS := "4" 		//Não Avaliado
				SZX->ZX_YDTINC	:= dDataBase

				SZX->(MsUnLock())

				For _ni := 1 to 2

					If _ni = 1
						_cMsgPt := "Protocolo gerado de forma automatica pelo sistema, rotina Cuidado Personalizado - CMB"
					Else

						If Empty(_cMat)

							_cMsgPt := "Foi enviado e-mail para: " + AllTrim(cGetEmail) + " para mais detalhes consulte "
							_cMsgPt += "o Log de envio de e-mail CBC."

						Else

							_cMsgPt := "Este protocolo foi criado no momento da inclusão do beneficiario, gerando assim um registro "
							_cMsgPt += "de vinculo, a numeração desse PA esta cadastrado na rotina de cuidado personalizado."

						EndIf

					EndIf

					//-----------------------------------
					//Itens
					//-----------------------------------
					DbSelectArea("SZY")
					dbSetorder(4)
					_lAchou := DbSeek(xFilial("SZY") + AllTrim(_cSeq) + IIF(_ni = 1, "000001", "000002"))

					RecLock("SZY",!_lAchou)

					SZY->ZY_FILIAL 	:= xFilial("SZY")
					SZY->ZY_SEQBA	:= _cSeq
					SZY->ZY_SEQSERV	:= IIF(_ni = 1, "000001", "000002")
					SZY->ZY_DTSERV	:= dDataBase
					SZY->ZY_HORASV	:= STRTRAN(TIME(),":","")
					SZY->ZY_TIPOSV	:= _cTpSv
					SZY->ZY_OBS 	:= "PROTOCOLO AUTOMATICO"
					SZY->ZY_RESPOST := _cMsgPt
					SZY->ZY_HISTPAD	:= _cHst
					SZY->ZY_USDIGIT	:= CUSERNAME //Usuário Digitador
					SZY->ZY_PESQUIS := "4" //Não Avaliado

					SZY->(MsUnLock())

				Next _ni

			EndIf

		EndIf

	EndIf

	RestArea(_aArBL)
	RestArea(_aArCG)
	RestArea(_aArZX)
	RestArea(_aArZY)
	RestArea(_aArB1)
	RestArea(_aArBI)
	RestArea(_aArea)

Return _cSeq

/*/{Protheus.doc} CABA231C5
Rotina que irá validar o tipo de serviço e irá preencher sua descrição
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
Static Function CABA231C5()

	Local _lRet 	:= .T.
	Local _aArePBL	:= PBL->(GetArea())

	If !Empty(AllTrim(cGetServ))

		DbSelectArea("PBL")
		DbSetOrder(1)
		If DbSeek(xFilial("PBL") + cGetServ)

			cGetDsc := PBL->PBL_YDSSRV
			
			oDlg1:Refresh()

		Else

			Aviso("Atenção","Tipo de serviço não localizado, favor preencher corretamente.",{"OK"})
			_lRet 	:= .F.

		EndIf

	EndIf

	RestArea(_aArePBL)

Return _lRet

/*/{Protheus.doc} CABA231D
Rotina que irá validar se pode ou não excluir um registro
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
User Function CABA231D

	Local cQry 			:= " "
	Local _cProtoc		:= ""

	Private cAliasTRB  	:= GETNEXTALIAS()

	cQry += " SELECT                                                " + CRLF
	cQry += "     USUARI,                                           " + CRLF
	cQry += "     PROTOCOLOENVIO                                    " + CRLF
	cQry += " FROM                                                  " + CRLF
	cQry += "     LOG_ENV_EMAIL_CBC                                 " + CRLF
	cQry += " WHERE                                                 " + CRLF
	cQry += "     USUARI = '" + PES->PES_USUARI+ "'                 " + CRLF
	cQry += "     AND PROTOCOLOENVIO = '" + PES->PES_PROTOC + "'	" + CRLF

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasTRB,.T.,.T.)

	dbSelectArea(cAliasTRB)
	(cAliasTRB)->(dbgotop())

	If (cAliasTRB)->(Eof())

		_cProtoc := PES->PES_PROTOC

		AxDeleta('PES', PES->(RecNo()), 5)

		DbSelectArea("SZX")
		DbSetOrder(1)
		If DbSeek(xFilial("SZX") + _cProtoc)

			SZX->(RecLock("SZX",.F.))
			SZX->(DbDelete())
			SZX->(MsUnlock())

			DbSelectArea("SZY")
			DbSetOrder(1)
			If DbSeek(xFilial("SZY") + _cProtoc)

				SZY->(RecLock("SZY",.F.))
				SZY->(DbDelete())
				SZY->(MsUnlock())

			EndIF

		EndIf

		Aviso("Atenção","Registro e protocolo vinculado excluído com sucesso. ",{"OK"})

	Else

		Aviso("Atenção","Cadastro não pode ser excluído pois existe log de envio de e-mail.",{"OK"})

	EndIf

Return

/*/{Protheus.doc} CABA231E
Rotina que será utilizada para fazer as validações na tela de incluir
@type function
@version  1.0
@author angelo.cassago
@since 12/07/2022
/*/
User Function CABA231E()

	Local _lRet 	:= .T.
	Local _aArePES	:= PES->(GetArea())
	Local _cMsg		:= ""

	If !Empty(M->PES_USUARI) .And. INCLUI .And. !Empty(M->PES_SERVIC)

		//------------------------------------------------------------------------
		//Validação na própria tela
		//------------------------------------------------------------------------
		If _lRet .And. !Empty(M->PES_INIVIG) .AND. !Empty(M->PES_FIMVIG) .And. M->PES_SERVIC == PES->PES_SERVIC

			If M->PES_INIVIG > M->PES_FIMVIG .OR. M->PES_FIMVIG < M->PES_INIVIG

				_cMsg := "A vigência inicial não pode possuir data maior que a vigência final da mesma forma "
				_cMsg += "a vigência final não pode possuir data menor que a vigência inicial."

				AVISO("ATENÇÃO", _cMsg, {"OK"})

				_lRet 	:= .F.

			EndIf

		EndIf

	EndIf

	RestArea(_aArePES)

Return _lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function Env_1
Rotina que irá disparar o e-mail da internação
@author  Angelo Henrique
@version 1.0
@type function 
@since   date 15/09/2021
@return logical, se conseguiu enviar ou não 
/*/
//-------------------------------------------------------------------
Static Function Env_1(c_ArqTxt, c_To, c_CC, c_Assunto, a_Msg )

	Local n_It 			:= 0
	Local _cError     	:= ""
	Local l_Result    	:= .F.                   		// resultado de uma conexão ou envio
	Local nHdl        	:= fOpen(c_ArqTxt,68)
	Local c_Body      	:= space(99999)

	Private _cServer  	:= Trim(GetMV("MV_RELSERV")) 	// smtp.ig.com.br ou 200.181.100.51

	Private _cUser    	:= GetNewPar("MV_XMAILPA", "protocolodeatendimento@caberj.com.br")
	Private _cPass    	:= GetNewPar("MV_XPSWPA" , "Caberj2017@!")

	Private _cFrom    	:= "GRUPO CABERJ PROTHEUS"
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

/*/{Protheus.doc} GRVLOGENV
Rotina que irá gerar o LOG do envio
@type function
@version  1.0
@author angelo.cassago
@since 21/07/2022
/*/
Static Function GRVLOGENV

	Local _cQuery 	:= ""
	Local _aAreBA1	:= BA1->(GetArea())

	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + cGetMatr)

		_cQuery  := "INSERT INTO 																" + CRLF
		_cQuery  += "LOG_ENV_EMAIL_CBC															" + CRLF
		_cQuery  += "VALUES																		" + CRLF
		_cQuery  += "(																			" + CRLF
		_cQuery  += "   '" + BA1->BA1_CODINT + "',												" + CRLF
		_cQuery  += "   '" + BA1->BA1_CODEMP + "',												" + CRLF
		_cQuery  += "   '" + BA1->BA1_MATRIC + "',												" + CRLF
		_cQuery  += "   '" + BA1->BA1_TIPREG + "',												" + CRLF
		_cQuery  += "   '" + BA1->BA1_DIGITO + "',												" + CRLF
		_cQuery  += "   '" + cGetEmail       + "',												" + CRLF
		_cQuery  += "   '" + AllTrim(STRTRAN(cGetAssu	,"'"," ")) + "',						" + CRLF
		_cQuery  += "   '" + AllTrim(STRTRAN(cMGetCont	,"'"," ")) + "',						" + CRLF
		_cQuery  += "   '" + _cProt + "',														" + CRLF
		_cQuery  += "   '" + DTOS(DATE())    + "',												" + CRLF
		_cQuery  += "   '" + TIME()          + "',												" + CRLF
		_cQuery  += "   '" + PSWRET()[1][2]  + "',												" + CRLF
		_cQuery  += "	'" + IIF(cEmpAnt = '01','CABERJ','INTEGRAL') + "',						" + CRLF
		_cQuery  += "   '" + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) + "'	" + CRLF
		_cQuery  += ")  																		" + CRLF

		TcSqlExec(_cQuery)

	EndIf

	RestArea(_aAreBA1)

Return
