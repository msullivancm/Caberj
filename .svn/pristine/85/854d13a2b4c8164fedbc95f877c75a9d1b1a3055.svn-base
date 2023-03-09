#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
#INCLUDE "plsa090.ch"
#include "PROTHEUS.CH"
#include "PLSMCCR.CH"
#INCLUDE "plsa092.ch"

#define  bImpGuia 		{|| IF(ExistBlock("PLSA092IMP"),ExecBlock("PLSA092IMP",.F.,.F.),IIf(GetNewPar("MV_PLSTISS","1")=="1" ,PLSR420N(1),PLSR420())) }

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS092M2  ºAutor  ³ Jean Schulz        º Data ³  02/09/2008 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Inserir botao para chamada da rotina de clone de autorizacaoº±±
±±º          ³para alteracoes de dados.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#define __aCdCri187 {"573",STR0130}//"Demanda por requerimento"
#define __aCdCri207 {"09V","Paciente ja esta internado"}

User Function PLS092M2


	Local aArea		:= GetArea()
	Local aRetorno
	Local aSubRot 	:= {}
	Local _nPos 	:= Ascan(aRotina, {|x| x[2] == "PLSA92DtIn(.F.)"	}) //Procura a Chamada da rotina de data de internação
	Local _nPosPg 	:= Ascan(aRotina, {|x| x[1] == "Prorrog. Interna."	}) //Procura a Chamada da rotina de data de internação

	aAdd(aSubRot,{"Cancelar Guia"		, 'U_PLSA092CAN()' 	,0 	,0 })
	//	aAdd(aSubRot,{'Data Alta' 			, 'U_InfAlta()' 	,0	,0 })
	aAdd(aSubRot,{'Dados de Internação' , 'U_PLMENU92()' 	,0	,0 })
	aAdd(aSubRot,{'Revalidar Senha'		, 'U_REVSEN()' 		,0	,0 })
	///	aAdd(aSubRot,{'Copart. Psiquiatria'	, 'U_PSIQUI()' 		,0	,0 }) //Processo de Coparticipação Psiquiatria - descomentar quando subir para produção


	//-------------------------------------------------------------------------------
	//Mateus Medeiros - Data: 03/08/2017
	//-------------------------------------------------------------------------------
	//Chamando a rotina de Impressão de Guia
	//-------------------------------------------------------------------------------
	aAdd(aSubRot,{'Guia ANS'				, 'U_VALIMP42()'	,0	,0 })
	aAdd(aSubRot,{'Implementação Futura'	, 'U_NEGINT()' 		,0	,0 }) //NESTA POSIÇÃO NENHUMA ROTINA FUNCIONA
	aAdd(aSubRot,{'Negar'					, 'U_NEGINT()' 		,0	,0 })
	aAdd(aSubRot,{'Aut. Int.'				, 'U_CABA606()'		,0	,0 })
	aRetorno := {'Outras opções', aSubRot,0,0}

	//-------------------------------------------------------------------------------
	//Angelo Henrique - Data: 11/04/2017
	//-------------------------------------------------------------------------------
	//Chamando a rotina de Data de Internação
	//Pois no Ponto de entrada PLS092M1 era feito um
	//aDel e depois um aSize, modificando assim a estrutura
	//e não chamando corretamente a rotina de prorrogação da internação
	//-------------------------------------------------------------------------------
	If _nPos > 0

		aRotina[_nPos][2] := "U_INFOINT"

	EndIf

	If _nPosPg > 0

		aRotina[_nPosPg][2] := "U_PRORROG"

	EndIf

	RestArea(aArea)

Return(aRetorno)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³PLSA090CAN ³ Autor ³Jean Schulz  			  ³ Data ³ 18.09.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Faz o cancelamento de uma guia de GIH.							  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function PLSA092CAN(lRPC)

	LOCAL cFaseGuia := ""
	LOCAL cSeqPF    := ""

	Local _aArBE4	:= BE4->(GetArea())
	Local _aArBEJ	:= BEJ->(GetArea())
	//Local _aArPBZ	:= PBZ->(GetArea())
	Local _aArBEA	:= BEA->(GetArea())
	Local _aArBE2	:= BE2->(GetArea())

	DEFAULT lRPC	:= .F.


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a guia foi cobrada (custo, VD, Co-Participacao, Etc)         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BCI->(DbSetOrder(1))
	If BCI->(MsSeek(xFilial("BCI")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG)))
		cSeqPF    := BE4->BE4_SEQPF
		cFaseGuia := BE4->BE4_FASE
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se for online nao deixa cancelar por aqui								 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If BE4->( FieldPos("BE4_NRTROL") ) > 0 .And. BE4->( FieldPos("BE4_NRAOPE") ) > 0 .And. !Empty(BE4->BE4_NRTROL) .And. Empty(BE4->BE4_NRAOPE)
			If lRPC
				Return "Guia On-Line, não e possível fazer este tipo de cancelamento!"
			Else
				MsgAlert("Guia On-Line, não e possível fazer este tipo de cancelamento!")
				Return
			EndIf
		EndIf
	Endif

	If ! Empty(cSeqPF)
		If PLSVERCCBG(BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG),BE4->BE4_ANOPAG,BE4->BE4_MESPAG,cSeqPF)
			If lRPC
				Return "Ja gerada a cobranca de custo operacional/co-participacao portanto nao podera ser cancelada"
			Else
				Aviso("Guia Cobrada","Ja gerada a cobranca de custo operacional/co-participacao portanto nao podera ser cancelada",{"Ok"},2)
				Return
			EndIf
		Endif
	Endif

	If cFaseGuia == "4"
		If lRPC
			Return "Guia ja paga portanto nao podera ser cancelada"
		Else
			Aviso("Guia Paga","Guia ja paga portanto nao podera ser cancelada",{"Ok"},2)    //"######
			Return
		EndIf
	Endif

	If BE4->( FieldPos("BE4_CANCEL") ) == 0
		If lRPC
			Return "Campo de CANCELAMENTO não EXISTE!"
		Else
			Alert("Campo de CANCELAMENTO não EXISTE!") //
			Return
		EndIf
	EndIf

	If BE4->BE4_CANCEL == '1'
		If lRPC
			Return "A Guia ja esta CANCELADA!"
		Else
			Alert("A Guia ja esta CANCELADA!'")//
			Return
		EndIf
	EndIf

	If BE4->BE4_STATUS == "3"
		If lRPC
			Return "Guia já cancelada / não autorizada!"
		Else
			Alert("Guia já cancelada / não autorizada!'")
			Return
		EndIf
	EndIf


	If !lRPC .And. !MsgYesNo("Confirma o CANCELAMENTO da GUIA?")//
		Return
	EndIf

	PLSSTAGUI(BE4->BE4_CODOPE,BE4->BE4_ANOINT,BE4->BE4_MESINT,BE4->BE4_NUMINT,"2",NIL,NIL,.T.)

	BE4->(RecLock("BE4",.F.))
	BE4->BE4_STATUS := "3"
	BE4->BE4_CANCEL := "1"
	BE4->(MsUnlock())


	//-------------------------------------------------------------------
	// INICIO - Angelo Henrique - 26/09/2017
	//-------------------------------------------------------------------
	//Ao cancelar a guia os itens na tabela BEJ ficam verdes(ATIVAS).
	//-------------------------------------------------------------------
	DbSelectArea("BEJ")
	DbSetOrder(1) //BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT+BEJ_SEQUEN
	If DbSeek(xFilial("BEJ") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT))

		While BEJ->(!EOF()) .And. BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT) == BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT)

			RecLock("BEJ", .F.)

			BEJ->BEJ_STATUS := "0"

			MsUnLock()

			BEJ->(DbSkip())

		EndDo

	EndIf
	//-------------------------------------------------------------------
	// FIM - Angelo Henrique - 26/09/2017
	//-------------------------------------------------------------------


	//-------------------------------------------------------------------
	// INICIO - Angelo Henrique - 23/10/2017
	//-------------------------------------------------------------------
	//Projeto Copart Psiquiatria
	//-------------------------------------------------------------------
	//Ao cancelar os itens da internação deve ser retirados os itens
	//referentes a mesma na tabela customizada para a coparticipação
	//-------------------------------------------------------------------

	//-----------------------------------------------------------------------------------------------
	//Varrendo os itens no momento da internação
	//-----------------------------------------------------------------------------------------------
	/*DbSelectArea("BEJ") // descomentar quando subir para produção
	DBSetOrder(1) //BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT+BEJ_SEQUEN
	If DbSeek(xFilial("BEJ") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT))

	While BEJ->(!EOF()) .And. BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == BEJ->(BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT)

	DbSelectArea("PBZ")
	DbSetOrder(2) //PBZ_FILIAL+PBZ_CODOPE+PBZ_ANOINT+PBZ_MESINT+PBZ_NUMINT+PBZ_SEQUEN
	If DbSeek(xFilial("PBZ") + BEJ->(BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT + BEJ_SEQUEN))

	RecLock("PBZ", .F.)

	PBZ->PBZ_CANCEL = '1'

	PBZ->(MsUnlock())

	EndIf

	BEJ->(DbSkip())

	EndDo

	EndIf
	*/
	//-------------------------------------------------------------------

	//-------------------------------------------------------------------
	// FIM - Angelo Henrique - 23/10/2017
	//-------------------------------------------------------------------


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ 06/04/2016 -  Roberto Meirelles e Marcela
	// Ajuste efetuado para excluir a guia do Painel de Auditoria por Guia      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("B53")
	dbSetOrder(1)
	If dbSeek( xFilial("B53") + BE4->( BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT ) )

		B53->( RecLock("B53", .F.) )

		B53->( dbdelete() )

		B53->( MsUnLock() )

	EndIf

	//----------------------------------------
	//Reforçando o ponteramento na BEA
	//----------------------------------------
	dbSelectArea("BEA")
	dbSetOrder(1) //BEA_FILIAL+BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT+DTOS(BEA_DATPRO)+BEA_HORPRO
	If dbSeek( xFilial("BEA") + BE4->( BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT ) )

		BEA->( RecLock("BEA", .F.) )

		BEA->BEA_STATUS := '3'
		BEA->BEA_CANCEL := '1'

		BEA->( MsUnLock() )

		BE2->( DbSetOrder(1) ) //BE2_FILIAL + BE2_OPEMOV + BE2_ANOAUT + BE2_MESAUT + BE2_NUMAUT + BE2_SEQUEN
		BE2->( MsSeek( xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) ) )
		While !BE2->(Eof()) .And. BEA->(BEA_FILIAL+BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) == BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)

			BE2->( RecLock("BE2", .F.) )
			BE2->BE2_LIBESP := '0'
			BE2->BE2_AUDITO := '0'
			BE2->BE2_STATUS := '0'
			BE2->( MsUnLock() )
			BE2->( DbSkip() )

		EndDo

	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quando lRPC for .T. nao deve ser exibido mensagem em tela,deve ser retornado uma string³
	//³ Se tudo tiver ok deve ser retornado uma string ""									   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lRPC
		If ExistBlock("PLS090CAN")
			ExecBlock("PLS090CAN",.F.,.F.)
		Endif
	EndIf

	RestArea(_aArBE2)
	RestArea(_aArBEA)
	RestArea(_aArBE4)
	RestArea(_aArBEJ)
	//	RestArea(_aArPBZ)

Return

******************************************************************************************************************************************

//Leonardo Portella	- 14/07/16 - Alteração de data de alta. Solicitado por Roberto Meirelles
//Leonardo Portella	- 18/07/16 - Alteração de escopo. Somente erá possível excluir a data de alta.

User Function InfAlta

	Local lOk			:= .F.


	Local bDesAlta		:={|x|  iif(!Empty(x),GetAdvFVal("BIY","BIY_DESCRI",xFilial('BIY') + PLSINTPAD() + x),cDescAlta := "")}  //{|x|Posicione('BIY',1,xFilial('BIY') + PLSINTPAD() + x,'BIY_DESCRI')}
	Local bValAlta		:= {||If(empty(cTpAlta) /*.and. empty(cTpAlta)*/,(MsgStop('Informe o tipo de alta!',AllTrim(SM0->M0_NOMECOM)),.F.),.T.)}

	//Local bValAlta		:= {||If(!empty(dAlta) .and. empty(cTpAlta),(MsgStop('Informe o tipo de alta!',AllTrim(SM0->M0_NOMECOM)),.F.),.T.)}
	Local lInfAlta		:= ( RetCodUsr() $ ( GetNewPar("MV_XINFALT", "000717") + '|' + GetMv('MV_XGETIN') + '|' + GetMv('MV_XGERIN') ) )
	Local cTit			:= "" // Mateus Medeiros - 16/10/17

	Private nRotina		:= 0

	Private dAlta      	:= BE4->BE4_DTALTA
	Private cHrAlta    	:= If(empty(BE4->BE4_HRALTA),'  :  :  ',Left(PadR(AllTrim(BE4->BE4_HRALTA),6,'0'),2) + ':' + Substr(PadR(AllTrim(BE4->BE4_HRALTA),6,'0'),3,2) + ':' + Right(PadR(AllTrim(BE4->BE4_HRALTA),6,'0'),2))
	Private cTpAlta    	:= BE4->BE4_TIPALT
	Private cDescAlta  	:= EVal(bDesAlta,BE4->BE4_TIPALT)

	Private cUserName   := USRRETNAME(RetCodUsr())


	if BE4->BE4_CODLDP == '0000'

		SetPrvt("oDlgInfAlta","oGrp1InfAlta","oSay1InfAlta","oSay2InfAlta","oSay3InfAlta","oGet1InfAlta","oGet2InfAlta","oGet3InfAlta","oSBtn1InfAlta","oSBtn2InfAlta")

		if (Empty(dAlta) .and. Empty(cTpAlta)  .or. !Empty(dAlta) .and. !Empty(BE4->BE4_HRALTA) .and. Empty(cTpAlta)   )
			cTit := "Informação da Data da Alta"
			nRotina := 1
		else
			cTit := "Exclusão da data de alta"
			nRotina := 2
		endif


		oDlgInfAlta 	:= MSDialog():New( 092,232,277,813,cTit,,,.F.,,,,,,.T.,,,.T. )

		oGrp1InfAlta 	:= TGroup():New( 008,008,064,276,"Informações da alta",oDlgInfAlta,CLR_BLACK,CLR_WHITE,.T.,.F. )

		oSay1InfAlta  	:= TSay():New( 020,012,{||"Data da alta"}		,oGrp1InfAlta,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
		oSay2InfAlta    := TSay():New( 020,104,{||"Hora da alta"}		,oGrp1InfAlta,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
		oSay3InfAlta    := TSay():New( 032,012,{||"Tipo de alta"}		,oGrp1InfAlta,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
		oSay4InfAlta    := TSay():New( 044,012,{||"Descr. tipo alta"}	,oGrp1InfAlta,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)

		//TGet(): New ( [ nRow], [ nCol], [ bSetGet], [ oWnd], [ nWidth], [ nHeight], [ cPict], [ bValid], [ nClrFore], [ nClrBack], [ oFont], [ uParam12], [ uParam13], [ lPixel], [ uParam15], [ uParam16], [ bWhen], [ uParam18], [ uParam19], [ bChange], [ lReadOnly], [ lPassword], [ uParam23], [ cReadVar], [ uParam25], [ uParam26], [ uParam27], [ lHasButton], [ lNoButton] )
		//oCont01       := tGet():New(aTamObj[1],aTamObj[2],{|x| If(PCount() > 0,cFiltroP := x,cFiltroP)},oPainel01,aTamObj[3],aTamObj[4],PesqPict("SBM","BM_GRUPO"),/*valid*/,,,/*font*/,,,.T.,,,/*when*/,,,/*change*/,.F.,.F.,,"cFiltroP")
		oGet1InfAlta    := TGet():New( 020,052,{|u|	If( PCount() == 0,	dAlta	, dAlta   := u	)}	,oGrp1InfAlta,044,008,PesqPict("BE4","BE4_DTALTA"),{ ||  lDataOk(dAlta) } /*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,/*[ uParam18]*/,/*[ uParam19]*/,/*change*/,.F.,.F.,/*[ uParam23]*/,"dAlta",,,,.T.,.F.)
		oGet2InfAlta    := TGet():New( 020,140,{|u| If( PCount() == 0, 	cHrAlta	, cHrAlta := u 	)}	,oGrp1InfAlta,028,008,'99:99:99',{|| lHoraOk(cHrAlta) },CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,/*[ uParam18]*/,/*[ uParam19]*/,/*[ bChange]*/,iif(!empty(cHrAlta),.F.,.T.),.F.,/*[ uParam23]*/,"cHrAlta",,,,.T.,.F.)
		oGet3InfAlta    := TGet():New( 032,052,{|u| If( PCount() == 0, 	cTpAlta	, cTpAlta := u  )}	,oGrp1InfAlta,020,008, ,{||If(empty(cTpAlta).or. ExistCpo('BIY',PLSINTPAD() + cTpAlta),(cDescAlta := If(!empty(cTpAlta),EVal(bDesAlta,cTpAlta),''),.T.),.F.)}	,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,							,.F.,.F.,	,"cTpAlta"		,,)

		oGet3InfAlta:bF3 := &('{|| IIf(ConPad1(,,,"BTWPLS",,,.F.),Eval({|| cTpAlta := BIY->BIY_CODSAI,oGet3InfAlta:Refresh()}),.T.)}')

		oGet4InfAlta    := TGet():New( 044,052,{|| cDescAlta	}	,oGrp1InfAlta,216,008, ,																													,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,							,.T.,.F.,""			,"cDescAlta"	,,)

		oSBtn1InfAlta   := SButton():New( 068,220,1,{||If(EVal(bValAlta),(lOk := .T., oDlgInfAlta:End()),lOk := .F.)}	,oDlgInfAlta,,"", )
		oSBtn2InfAlta   := SButton():New( 068,250,2,{||lOk := .F., oDlgInfAlta:End()}									,oDlgInfAlta,,"", )

		oDlgInfAlta:Activate(,,,.T.)

		If lOk

			If !lInfAlta

				MsgStop('Usuário [ ' + cValToChar(RetCodUsr()) + ' - ' + AllTrim(UsrFullName(RetCodUsr())) + ' ] sem permissão para excluir data de alta!',AllTrim(SM0->M0_NOMECOM))

			ElseIf MsgYesNo('Confirma '+cTit+'!',AllTrim(SM0->M0_NOMECOM))

				if !Empty(dAlta) .and. nRotina == 2
					dAlta 	  := stod('')
					cHrAlta  :=  ''
					cTpAlta  := ''
				endif

				BE4->(Reclock('BE4',.F.))

				BE4->BE4_DTALTA	:= iif(valtype(dAlta) == "C",stod(dAlta),dAlta)
				BE4->BE4_HRALTA := Replace(cHrAlta,':','')
				BE4->BE4_TIPALT	:= cTpAlta
				BE4->BE4_XUSALT := cUserName // Mateus Medeiros - 19/10/2017
				BE4->BE4_XDTALT := ddatabase

				BE4->(MsUnlock())

				MsgInfo('Informações de alta alteradas.', AllTrim(SM0->M0_NOMECOM))

			EndIf

		EndIf
	Else

		MsgStop('Somente é permitido nas Guias de Solicitação de Internação.',  "" )

	Endif

Return

************************************************************************************************************************************

Static Function lHoraOk(cHora)

	Local lOk := .T.
	Local aHr := Separa(cHora,':',.T.)

	Do Case

		Case Empty(AllTrim(Replace(cHora,':','')))

			if nRotina == 1
				MsgStop('Informe a hora no formato HH:MM:SS',AllTrim(SM0->M0_NOMECOM))
				lOk := .F.
			endif

		Case len(aHr) <> 3
			MsgStop('Informe a hora no formato HH:MM:SS',AllTrim(SM0->M0_NOMECOM))
			lOk := .F.

		Case empty(aHr[1]) .or. ( Val(aHr[1]) >= 24 )
			MsgStop('Hora inválida',AllTrim(SM0->M0_NOMECOM))
			lOk := .F.

		Case empty(aHr[2]) .or. ( Val(aHr[2]) >= 60	)
			MsgStop('Minutos inválidos',AllTrim(SM0->M0_NOMECOM))
			lOk := .F.

		Case empty(aHr[3]) .or. ( Val(aHr[3]) >= 60 )
			MsgStop('Segundos inválidos',AllTrim(SM0->M0_NOMECOM))
			lOk := .F.

	EndCase

Return lOk

************************************************************************************************************************************

Static Function lDataOk(dData)

	Local lOk := .T.

	if !Empty(dData) .and. !Empty(BE4->BE4_DATPRO)
		if dData < BE4->BE4_DATPRO
			MsgStop(OemToAnsi('A data de alta não pode ser menor que a data de internação.'))
			lOk := .F.
		endif
	elseif Empty(dData)
		if  nRotina == 1
			MsgStop(OemToAnsi('A data de alta precisa ser preenchida.'))
			lOk := .F.
		endif
	Endif

Return lOk
************************************************************************************************************************************

Static Function lDataOk2(dData)

	Local lOk := .T.
	Local cUserAcc := GetMv("MV_XINFALT")
	Local cPerg := 'lDataOk2'

	PutSx1(cPerg,"01",OemToAnsi("Data de Liberação")			,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})

	if !Empty(dData)

		if dData < BE4->BE4_XDTLIB
			if !(AllTrim(Upper(__cUserId)) $ cUserAcc )
				MsgStop(OemToAnsi('A data da Internação não pode ser menor que a data de liberação.'))
				lOk := .F.
			else
				if msgyesno("Deseja alterar a data de Liberação")
					if Pergunte(cPerg,.t.)
						//mv_par01 := BE4->BE4_XDTLIB
						Reclock("BE4",.f.)
						BE4->BE4_XDTLIB	 := mv_par01
						BE4->(MsUnLock())
					Endif
				else
					lOk := .F.
				endif
			Endif
		endif

	Endif

Return lOk

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³INFOINT   º Autor ³ Joany Peres        º Data ³  04/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Informações complementarespara autorização de internação   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function INFOINT()

	Local _lStat		:= .T.
	//Local _lDtCt 		:= .F. //Angelo Henrique - Data: 29/01/2018
	Local _lRecp		:= .F. //Angelo Henrique - Data: 15/02/2018

	Private dMsg01	 	:= If(Empty(BE4->BE4_MSG01),Space(TamSx3("BE4_MSG01")[1]),BE4->BE4_MSG01 )
	Private dMsg02	 	:= If(Empty(BE4->BE4_MSG02),Space(TamSx3("BE4_MSG02")[1]),BE4->BE4_MSG02 )
	Private dMsg03	 	:= If(Empty(BE4->BE4_MSG03),Space(TamSx3("BE4_MSG03")[1]),BE4->BE4_MSG03 )

	//**********************************************************
	// MATEUS MEDEIROS - 27/11/2018 - INÍCIO
	// VALIDAÇÃO DE BLOQUEIO FUTURO DO BENEFICIÁRIO
	//**********************************************************
	PLSA090USR(BE4->(BE4_CODOPE+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO),dDataBase,BE4->BE4_HORPRO,"BE4")
	//**********************************************************
	// MATEUS MEDEIROS - 27/11/2018 - FIM
	// VALIDAÇÃO DE BLOQUEIO FUTURO DO BENEFICIÁRIO
	//**********************************************************

	//---------------------------------------------
	//Angelo Henrique - Data: 27/01/2017
	//Projeto OPME
	//Validação para não liberar a senha caso
	//não tenha mudado o status para senha liberada
	//---------------------------------------------
	If !Empty(AllTrim(BE4->BE4_YSOPME))

		If !(BE4->BE4_REGINT = "3")

			If !(BE4->BE4_GRPINT = "5")

				If !(BE4->BE4_YSOPME $ "A|B")

					_lStat := .F.

				EndIf

			EndIf

		EndIf

	EndIf

	If !(_lStat)

		Aviso("Atenção","Data de internação não pode ser preenchida, pois a internação ainda não possui a senha liberada.",{"OK"})

	Else


		If (Empty(dMsg03))
			Private oFont         := NIL
			Private nOpca      	  := 2
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Cria Dialog...                                                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE FONT oFont NAME "Arial" SIZE 000,-012 BOLD
			DEFINE MSDIALOG oDlg TITLE "Informações de Internação" FROM 007.2,006.6 TO 016,076 OF GetWndDefault()
			@ 05, 10  Say oSay PROMPT "Mensagem"        SIZE 65,10 OF oDlg PIXEL FONT oFont
			@ 05, 70  MSGET oGet VAR dMsg01				SIZE 200,10 OF oDlg FONT oFont PICTURE "@A" PIXEL


			@ 20, 10  Say oSay PROMPT "Compl. Mensagem" SIZE 65,10 OF oDlg PIXEL FONT oFont
			@ 20, 70  MSGET oGet VAR dMsg02				SIZE 200,10 OF oDlg FONT oFont PICTURE "@A" PIXEL

			@ 35, 10  Say oSay PROMPT "Informação" 	    SIZE 65,10 OF oDlg PIXEL FONT oFont
			@ 35, 70  MSGET oGet VAR dMsg03				SIZE 200,10 OF oDlg FONT oFont PICTURE "@A" PIXEL

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Botoes																	 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			bSalvar			:= TButton():New(50,80, 'Salvar',,{ || Iif(Empty(dMsg03),Alert("O campo Informação é obrigatório"), { nOpca := 0, oDlg:End()} ) } , 040, 012 ,,,,.T.)
			bCancel 		:= TButton():New(50,180, 'Cancelar',,{ || oDlg:End() } , 040, 012 ,,,,.T.)
			ACTIVATE MSDIALOG oDlg CENTERED

			If nOpca == 0
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Inicia transacao...                                                      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				Begin Transaction
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Atualiza as informações de internacao									 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					BE4->( RecLock("BE4", .F.) )
					BE4->BE4_MSG01 := dMsg01
					BE4->BE4_MSG02 := dMsg02
					BE4->BE4_MSG03 := dMsg03

					//-----------------------------------------------------------------------------------
					//Angelo Henrique - Data: 14/02/2017
					//-----------------------------------------------------------------------------------
					//Conforme solicitado, todas as senhas deverão ser liberadas como eletivas
					//caso seja classificadda como urgência na rotina de liberação OPME
					//o campo de BE4_TPADM deverá ser alterado para 5 = "Urgência"
					//-----------------------------------------------------------------------------------
					If AllTrim(BE4->BE4_YATOPM) = "1"

						BE4->BE4_TIPADM := "5"

					EndIf

					BE4->( MsUnLock() )

				End Transaction

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Finaliza transacao...                                                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


				//*********************************************************************************************
				//Função Padrão - Não possui validação da Data da internação menor que a Data de Autorização
				//*********************************************************************************************
				//Chamando rotina clonada do padrão com validação
				//*********************************************************************************************
				//u_CB92DtIn(.F.)
				PLSA92DtIn(.F.)
				//*********************************************************************************************

				//----------------------------------------------------------------------------------------------------------
				//Angelo Henrique - Data: 29/01/2018
				//----------------------------------------------------------------------------------------------------------
				//Após a execução da rotina acima, é necessário validar se a data preenchida esta correta.
				//A data de internação (BE4_DATPRO) deve ser maior ou igual a Data de Liberação/Autorização (BE4_XDTLIB)
				//----------------------------------------------------------------------------------------------------------
				//DATPRO >= XDTLIB
				/*If BE4->BE4_DATPRO > BE4->BE4_XDTLIB

				While !(_lDtCt)

				If _dDtTela > BE4->BE4_XDTLIB .OR. _dDtTela = BE4->BE4_XDTLIB

				_lDtCt := .T.

				EndIf

				EndDo

				EndIf*/

				//----------------------------------------------------------------------
				//Angelo Henrique - Data: 15/02/2018
				//----------------------------------------------------------------------
				//Para as internações psiquiátricas e domiciliares:
				//A data de autorização, deverá ser igual a data de internação
				//----------------------------------------------------------------------
				DbSelectArea("BAU")
				DbSetOrder(1)
				If DbSeek(xFilial("BAU") + BE4->BE4_CODRDA)

					If BAU->BAU_TIPPRE $ "OPE|REC"

						_lRecp := .T.

					EndIf

				EndIf


				If BE4->BE4_GRPINT = "5" .OR. BE4->BE4_REGINT = "3" .OR. _lRecp

					BE4->( RecLock("BE4", .F.) )

					BE4->BE4_XDTLIB := BE4->BE4_DATPRO

					BE4->( MsUnLock() )

				EndIf

			EndIf

		Else

			//-----------------------------------------------------------------------------------
			//Angelo Henrique - Data: 14/02/2017
			//-----------------------------------------------------------------------------------
			//Conforme solicitado, todas as senhas deverão ser liberadas como eletivas
			//caso seja classificadda como urgência na rotina de liberação OPME
			//o campo de BE4_TPADM deverá ser alterado para 5 = "Urgência"
			//-----------------------------------------------------------------------------------
			If AllTrim(BE4->BE4_YATOPM) = "1"

				BE4->( RecLock("BE4", .F.))

				BE4->BE4_TIPADM := "5"

				BE4->( MsUnLock() )

			EndIf
			PLSA92DtIn(.f.)
			//u_CB92DtIn(.F.)

			///----------------------------------------------------------------------
			//Angelo Henrique - Data: 15/02/2018
			//----------------------------------------------------------------------
			//Para as internações psiquiátricas e domiciliares:
			//A data de autorização, deverá ser igual a data de internação
			//----------------------------------------------------------------------
			DbSelectArea("BAU")
			DbSetOrder(1)
			If DbSeek(xFilial("BAU") + BE4->BE4_CODRDA)

				If BAU->BAU_TIPPRE $ "OPE|REC"

					_lRecp := .T.

				EndIf

			EndIf


			If BE4->BE4_GRPINT = "5" .OR. BE4->BE4_REGINT = "3" .OR. _lRecp

				BE4->( RecLock("BE4", .F.) )

				BE4->BE4_XDTLIB := BE4->BE4_DATPRO

				BE4->( MsUnLock() )

			EndIf

		EndIf

	EndIf

return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PRORROG   º Autor ³ Angelo Henrique    º Data ³  28/06/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para tratar o OPME no momento da prorrogação.       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PRORROG()

	Local _cAlias	:= GetNextAlias()
	Local _cAlBE4	:= BE4->(GetArea())
	Local cQry		:= ""

	//-------------------------------------
	//Rotina padrão para a prorrogação
	//-------------------------------------
	PLSA092Mov("BE4",BE4->(RECNO()),9)

	//---------------------------------------------------------------------------
	//Conforme solicitado, caso tenho algum procedimento do tipo Honorário
	//deverá ser aberto a tela de OPME
	//---------------------------------------------------------------------------

	cQry := "SELECT  											" + CRLF
	cQry += "	BR8.BR8_TPPROC, BR8.BR8_TIPEVE,  				" + CRLF
	cQry += "	BR8.BR8_CODPSA, BR8.BR8_DESCRI 					" + CRLF
	cQry += "FROM 												" + CRLF
	cQry += "	" + RetSqlName('BR8') + " BR8,  				" + CRLF
	cQry += "	" + RetSqlName('BQV') + " BQV  					" + CRLF
	cQry += "WHERE   											" + CRLF
	cQry += "	BQV.D_E_L_E_T_ = ' '							" + CRLF
	cQry += "	AND BR8.D_E_L_E_T_ = ' '						" + CRLF
	cQry += "	AND BR8.BR8_FILIAL = ' '						" + CRLF
	cQry += "	AND BR8.BR8_TPPROC = '0'						" + CRLF
	cQry += "	AND BQV.BQV_CODOPE = '" + BE4->BE4_CODOPE + "'	" + CRLF
	cQry += "	AND BQV.BQV_ANOINT = '" + BE4->BE4_ANOINT + "'	" + CRLF
	cQry += "	AND BQV.BQV_MESINT = '" + BE4->BE4_MESINT + "'	" + CRLF
	cQry += "	AND BQV.BQV_NUMINT = '" + BE4->BE4_NUMINT + "'	" + CRLF
	cQry += "	AND BQV.BQV_CODPRO = BR8.BR8_CODPSA				" + CRLF
	cQry += "	AND BQV.BQV_DATPRO >= '" + DTOS(dDataBase)+ "'	" + CRLF

	If Select("_cAlias")>0
		_cAlias->(DbCloseArea())
	EndIf

	TcQuery cQry New Alias _cAlias	

	If !_cAlias->(EOF())

		u_PLSM3A("2")

	EndIf

	If Select("_cAlias")>0
		_cAlias->(DbCloseArea())
	EndIf

	RestArea(_cAlBE4)

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³REVSEN    º Autor ³ Angelo Henrique    º Data ³  28/07/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para atualizar a data de vencimento da solicitação  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function REVSEN

	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())
	Local _dDatVl	:= CTOD(" / / ")

	if empty(BA1->BA1_DATBLO) .or. BA1->BA1_DATBLO > ddatabase


		If Empty(BE4->BE4_SENHA)

			If BE4->BE4_DATVAL < dDatabase

				//---------------------------------------------------------------------
				//Conforme solicitado pela Marcele (GEMASI/BackOffice)
				//---------------------------------------------------------------------
				//Não pode ser trocado a data, a menos que a data de solicitação
				//seja menor que 61 dias
				//---------------------------------------------------------------------
				//Chamado: 41487 Revalidar de Senha
				//---------------------------------------------------------------------
				If dDataBase - BE4->BE4_XDTLIB < 61 //dDataBase - BE4->BE4_DTDIGI < 61

					If MsgYesNo("Deseja realmente alterar a Data de Validade desta internação?")

						DbSelectArea("BE4")
						DbSetOrder(1) //BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_SITUAC+BE4_FASE
						If DbSeek(xFilial("BE4")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_SITUAC+BE4_FASE))

							_dDatVl := BE4->BE4_DATVAL  + GetMV("MV_PLPRZLB")

							RecLock("BE4", .F.)

							BE4->BE4_DATVAL := _dDatVl

							BE4->(MsUnLock())

							Aviso("Atenção","Data de validade alterada para: " + DTOC(BE4->BE4_DATVAL) + ".",{"OK"})

							//-----------------------------------------------------------------------------------------
							//Chamada da rotina da tela de OPME para realizarem alterações caso seja necessário
							//-----------------------------------------------------------------------------------------
							u_PLSM3A()

						EndIf

					EndIf

				Else

					Aviso("Atenção","Não pode ser atualizada a Data, pois a autorização esta maior que 60 dias.",{"OK"})

				EndIf

			Else

				Aviso("Atenção","Esta internação ainda é valida.",{"OK"})

			EndIf

		Else

			Aviso("Atenção","Internação já contem senha e não pode ter a data alterada.",{"OK"})

		EndIf
	else
		Aviso("Atenção","Beneficiario Bloqueado. Não é possivel Revalidar a senha",{"OK"})
	endIf

	RestArea(_aArBE4)
	RestArea(_aArea )

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VALIMP    º Autor ³ Mateus Medeiros    º Data ³  03/08/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para validação da abertura de impressão da Guia     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VALIMP42

	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())

	//	If Empty(BE4->BE4_SENHA) .and. Empty(BE4->BE4_DATPRO)

	U_CABR420N(1)

	//Else

	//		Aviso("Atenção","Esta internação ainda é valida.",{"OK"})

	//	EndIf

	RestArea(_aArBE4)
	RestArea(_aArea )

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NEGINT    º Autor ³ Angelo Henrique    º Data ³  15/08/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para negativar a internação.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NEGINT

	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())
	Local _aArBEJ	:= BEJ->(GetArea())
	Local _lRet		:= .T.
	Local _cQuery	:= ""
	Local _aAreB53	:= GetNextAlias()
	Local lInfNeg	:= ( RetCodUsr() $ ( GetNewPar("MV_XINFALT", "000717") + '|' + GetMv('MV_XGETIN') + '|' + GetMv('MV_XGERIN') ) )
	Local oFont1    := TFont():New( "Times New Roman",0,-19,,.F.,0,,400,.F.,.F.,,,,,, )
	Local oFont2    := TFont():New( "Times New Roman",0,-15,,.F.,0,,400,.F.,.F.,,,,,, )
	Local _nOpc		:= 0
	Local _cMtGet	:= SPACE(100)
	Local _cTpNeg	:= SPACE(4)
	Local _cDsNeg	:= SPACE(TAMSX3("BCT_DESTIS")[1])

	SetPrvt("oFont1","oFont2","oDlg1","oGrp1","oSay1","oSay2","oBtn1","oMGet1","oGet1","oGet2")

	If BE4->BE4_STATUS <> "3" //Não Autorizada

		If BE4->BE4_CODLDP = "0000"

			If lInfNeg

				If BE4->BE4_STATUS <> '1' .OR. (BE4->BE4_STATUS = '1' .And. Empty(BE4->BE4_SENHA))

					//-------------------------------------------------------------------------------
					//Varrer a BEJ, para saber se os itens estão na auditoria
					//e se os mesmo não estão com seu status de executado
					//-------------------------------------------------------------------------------
					DbSelectArea("BEJ")
					DbSetOrder(1) //BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT+BEJ_SEQUEN
					If DbSeek(xFilial("BEJ") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT))

						While !EOF() .And. BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT)

							//-------------------------------------------------------------------------------
							//Não Autorizada e com processo em auditoria
							//-------------------------------------------------------------------------------
							If BEJ->BEJ_STATUS = "0" .And. BEJ->BEJ_AUDITO = "1"

								//--------------------------------------------------------------------------------
								//Visualizar agora se esta no processo de auditoria, ou se já foi feito
								//todas as analises, pois uma vez que é bloqueado pelo processo de auditoria
								//quando tem uma diária o status permanece como autorizado parcialmente
								//--------------------------------------------------------------------------------
								_cQuery := " SELECT " 	+ CRLF
								_cQuery += " 	 B53.B53_NUMGUI, B53.B53_ORIMOV " 	+ CRLF
								_cQuery += " FROM  " + RetSqlName('B53') + " B53 " + CRLF
								_cQuery += " WHERE " + CRLF
								_cQuery += " 	B53.D_E_L_E_T_ 	= ' ' " 	+ CRLF
								_cQuery += " 	AND B53.B53_NUMGUI = '" + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) + "' " 	+ CRLF
								_cQuery += "	AND B53.B53_SITUAC <> '1' " 	+ CRLF

								TcQuery _cQuery New Alias (_aAreB53)

								If !(_aAreB53)->(EOF())

									_lRet := .F.

									Aviso("Atenção", "Existem itens em auditoria, não é possivel negativar esta internação.", {"OK"})

								EndIf

								(_aAreB53)->(DbCloseArea())

							EndIf

							BEJ->(DbSkip())

						EndDo

					EndIf

				Else

					_lRet := .F.

					If !Empty(BE4->BE4_SENHA)

						Aviso("Atenção","Internação não pode ser negada, pois esta com Data de Internação preenchida. ",{"OK"})

					EndIf

				EndIf

			Else

				_lRet := .F.

				Aviso("Atenção","Usuário não possui acesso a esta rotina.",{"OK"})

			EndIf

			If !(Empty(BE4->BE4_SENHA))

				_lRet := .F.

				Aviso("Atenção","Já foi liberado senha para esta internação, não é possivel negativar.",{"OK"})

			EndIf

		Else

			_lRet := .F.

			Aviso("Atenção","Esta guia não é de solicitação, portanto não pode ser negada.",{"OK"})

		EndIf

	Else

		_lRet := .F.

		Aviso("Atenção","Esta guia encontra-se com o status: Não Autorizada, portanto não pode ser negada.",{"OK"})

	EndIf

	//----------------------------------------------------------------------------------
	//Se tiver passado por todas as validações irá realizar a troca do STATUS
	//----------------------------------------------------------------------------------
	If _lRet

		oDlg1      := MSDialog():New( 090,228,309,794,"Negativa Senha",,,.F.,,,,,,.T.,,,.T. )
		oGrp1      := TGroup():New( 000,004,100,276,"  Negativa Senha  ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

		//---------------------------------------------------------------------------------
		//Angelo Henrique - Data:13/09/2021
		//---------------------------------------------------------------------------------
		//Processo de SMS para o beneficiário
		//---------------------------------------------------------------------------------
		oSay2      := TSay():New( 012,008,{||"Negativa"	},oGrp1,,oFont2,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,064,012)
		oGet1      := TGet():New( 010,040,{|u| If(PCount()>0,_cTpNeg:=u,_cTpNeg)},oGrp1,017,012,'',,CLR_BLACK,CLR_WHITE,oFont2,,,.T.,"",,,.F.,.F.,,.F.,.F.,"BCTSMS","_cTpNeg",,)
		oGet2      := TGet():New( 025,008,{|u| If(PCount()>0,_cDsNeg:=u,_cDsNeg)},oGrp1,264,012,'',,CLR_BLACK,CLR_WHITE,oFont2,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","_cDsNeg",,)

		oSay1      := TSay():New( 040,008,{||"Observação"			},oGrp1,,oFont2,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,056,012)

		oMGet1     := TMultiGet():New( 050,008,{|u| If(PCount()>0,_cMtGet:=u,_cMtGet)},oGrp1,264,030,oFont1,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

		oBtn1      := TButton():New( 084,236,"Salvar",oGrp1,{||oDlg1:End(),_nOpc := 1	},037,012,,,,.T.,,"",,,,.F. )

		oDlg1:Activate(,,,.T.)

		If _nOpc = 1

			//----------------------------------------
			//Alterando o STATUS da internação
			//----------------------------------------
			Reclock("BE4", .F.)

			BE4->BE4_STATUS := "3"
			BE4->BE4_SITUAC := "3"
			BE4->BE4_YSOPME := "C"

			BE4->(MsUnlock())

			//--------------------------------------------
			//Atualizando o mural do beneficiário
			//--------------------------------------------
			Reclock("ZZ6", .T.)

			ZZ6->ZZ6_FILIAL := xFilial("ZZ6")
			ZZ6->ZZ6_SEQ	:= "001"
			ZZ6->ZZ6_CODOPE := BE4->BE4_CODOPE
			ZZ6->ZZ6_ANOGUI := BE4->BE4_ANOINT
			ZZ6->ZZ6_MESGUI := BE4->BE4_MESINT
			ZZ6->ZZ6_NUMGUI := BE4->BE4_NUMINT
			ZZ6->ZZ6_MATVID := BE4->BE4_MATVID
			ZZ6->ZZ6_SENHA 	:= BE4->BE4_SENHA
			ZZ6->ZZ6_USU	:= "1" //Tecnico Call Center
			ZZ6->ZZ6_NOMUSR	:= BE4->BE4_NOMUSR
			ZZ6->ZZ6_OPER	:= CUSERNAME
			//ZZ6->ZZ6_TEXT1	:= "Negativa Senha - " + _cTpNeg + " - " + AllTrim(_cDsNeg)
			ZZ6->ZZ6_TEXT1	:= "Solicitação Negada "
			ZZ6->ZZ6_TEXTO	:= _cMtGet
			ZZ6->ZZ6_ALIAS	:= "BE4"
			ZZ6->ZZ6_HORA	:= Left(Replace(Time(),':',''),4)
			ZZ6->ZZ6_DATA  	:= Date()

			ZZ6->(MsUnlock())

			//------------------------------------------------------------------
			//Mudando o Status para todos os itens da internação na BEJ
			//------------------------------------------------------------------
			DbSelectArea("BEJ")
			DbSetOrder(1) //BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT+BEJ_SEQUEN
			If DbSeek(xFilial("BEJ") + BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT))

				While !EOF() .And. BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT) == BEJ->(BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT)

					RecLock("BEJ",.F.)

					BEJ->BEJ_STATUS := "0" //Não Autorizada.

					BEJ->(MsUnlock())

					BEJ->(DbSkip())

				EndDo

			EndIf

			AVISO("Atenção","Internação negativada.", {"OK"})

			//---------------------------------------------------------------------------------
			//Angelo Henrique - Data:13/09/2021
			//---------------------------------------------------------------------------------
			//Rotina que irá gerar um novo protocolo e disparar SMS para o beneficiário
			//---------------------------------------------------------------------------------
			//Comentando a chamada da negativa a pedido da Márcia e do Hugo
			//Chamado: 88063
			//---------------------------------------------------------------------------------
			//u_CABA097(BE4->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT),"C",AllTrim(_cDsNeg))

		EndIf

	EndIf

	RestArea(_aArBEJ)
	RestArea(_aArBE4)
	RestArea(_aArea )

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PSIQUI    º Autor ³ Angelo Henrique    º Data ³  09/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para remover a guia da coparticipação psiquiatrica  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PSIQUI

	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())

	If BE4->BE4_GRPINT = "5" //Internação Psiquiatrica

		If BE4->BE4_XPSIQ

			If MsgYesNo("Deseja realmente remover esta guia do processo de coparticipação?")

				RecLock("BE4", .F.)

				BE4->BE4_XPSIQ := .F.

				BE4->(MsUnlock())

				Aviso("Atenção","Guia removida do processo de coparticipação",{"OK"})

			EndIf

		Else

			Aviso("Atenção","Esta guia não esta participando do processo de coparticipação da psiquiatria.",{"OK"})

		EndIf

	Else

		Aviso("Atenção","Esta guia não é de psiquiatria, não é possível utilizar esta função.",{"OK"})

	EndIf


	RestArea(_aArBE4)
	RestArea(_aArea )

Return

//*-------------------------------------------------------------------
//*Programa: PLMENU92          |      Data:10/11/17                  |
//*-------------------------------------------------------------------
//*Autor: Mateus Medeiros                                            |
//*-------------------------------------------------------------------
//*Desc: Chamada de tela que irá conter o menu das opções referente  |
//* ao processo do OPME.    									     |
//*-------------------------------------------------------------------

User Function PLMENU92

	Local _aArea 	:= GetArea()
	Local _nOpc 	:= 0

	Private _oDlg	:= Nil
	Private _oBtn	:= Nil
	Private _oGroup	:= Nil


	if BE4->BE4_CODLDP == '0000'

		DEFINE MSDIALOG _oDlg FROM 0,0 TO 90,552 PIXEL TITLE 'Dados de Internação'

		_oGroup:= tGroup():New(02,05,40,275,'Selecione uma das opções',_oDlg,,,.T.)

		_oBtn := TButton():New( 15,010,"Data Alta"				,_oDlg,{||_oDlg:End(),_nOpc := 1	},060,012,,,,.T.,,"",,,,.F. )

		_oBtn := TButton():New( 15,075,"Data Autorização" 		,_oDlg,{||_oDlg:End(),_nOpc := 3	},060,012,,,,.T.,,"",,,,.F. )

		_oBtn := TButton():New( 15,140,"Alt. Cabeçalho da Guia"	,_oDlg,{||_oDlg:End(),_nOpc := 2	},060,012,,,,.T.,,"",,,,.F. )

		//----------------------------------------------
		//Angelo Henrique - Data: 22/09/2021
		//----------------------------------------------
		_oBtn := TButton():New( 15,205,"Alt. SMS e E-mail"		,_oDlg,{||_oDlg:End(),_nOpc := 4	},060,012,,,,.T.,,"",,,,.F. )

		ACTIVATE MSDIALOG _oDlg CENTERED

		If _nOpc = 1    // Data

			//--------------------------------------
			//Chamada da função de Data de Alta
			//--------------------------------------
			U_InfAlta()

		ElseIf _nOpc = 2

			//--------------------------------------
			//Chamada da função Laudo Pos OPME
			//--------------------------------------
			fAltIntern()

		ElseIf _nOpc = 3

			//--------------------------------------
			//Chamada da função de Data de Autorização
			//--------------------------------------
			U_InfAutor()

		ElseIf _nOpc = 4 //SMS e E-mail

			//--------------------------------------
			//Chamada da função de Data de Autorização
			//--------------------------------------
			fSmsEmail()

		EndIf
	Else

		MsgStop('Somente é permitido nas Guias de Solicitação de Internação.',  "" )

	Endif
	RestArea(_aArea)

Return

//*-------------------------------------------------------------------
//*Programa: PLMENU92          |      Data:10/11/17                  |
//*-------------------------------------------------------------------
//*Autor: Mateus Medeiros                                            |
//*-------------------------------------------------------------------
//*Desc: Chamada de tela que irá conter o menu das opções referente  |
//* ao processo do OPME.    									     |
//*-------------------------------------------------------------------

Static Function fAltIntern()

	Local aArea		:= GetArea()
	Local aAreaBE4  := BE4->(GetArea())
	Local aYTrans	:= {}
	Local aGrpInt	:= {}
	//*----------------------------------------------------------------------------
	//                                  INÍCIO                                    |
	//Declaração de Variáveis Private que serão utilizadas na criação dos objetos |
	//*----------------------------------------------------------------------------
	Private _oDlgAlt  := Nil
	Private _oSay1    := Nil
	Private _oSay2    := Nil
	Private _oSay3    := Nil
	Private _oSay4    := Nil
	Private _oSay5    := Nil
	Private _oSay6    := Nil
	Private _oSay7    := Nil
	Private _oSay8    := Nil
	Private _oFont	  := Nil
	Private oGrp1     := Nil
	Private oYTrans   := Nil
	Private oGrpInt   := Nil
	Private oTpInt    := Nil
	Private oRegSol   := Nil
	Private oRegExe   := Nil
	Private oCID      := Nil
	Private oInd      := Nil
	Private oRegInt   := Nil
	Private oBtn1     := Nil
	//*-------------------------------------------------------------------------------
	//                                  INÍCIO                                    	 |
	// Declaração de Variáveis para "clonar" as propriedades dos campos da tabela BE4|
	//*-------------------------------------------------------------------------------
	Private cYTrans   := CriaVar("BE4_YTRANS", .T.)
	Private cGrpInt   := CriaVar("BE4_GRPINT", .T.)
	Private cTpInt    := CriaVar("BE4_TIPINT", .T.)
	Private cRegSol   := CriaVar("BE4_REGSOL", .T.)
	Private cRegExe   := CriaVar("BE4_REGEXE", .T.)
	Private cCID      := CriaVar("BE4_CID"   , .T.)
	Private cInd 	  := CriaVar("BE4_INDCLI", .T.)
	Private cRegInt   := CriaVar("BE4_REGINT", .T.)
	Private cDTpInt   := Space(TamSx3("BQR_DESTIP")[1])
	Private cDRegSol  := Space(TamSx3("BB0_NOME")[1])
	Private cDRegExe  := space(TamSx3("BB0_NOME")[1])
	Private cDCID	  := space(TamSx3("BA9_DOENCA")[1])
	Private cEstExe	  := ""
	Private cEstSol	  := ""
	Private cSigla    := ""



	//*----------------------------------------
	// Atribui as informações da Guia na tela.|
	//*----------------------------------------
	cYTrans   := BE4->BE4_YTRANS
	cGrpInt   := BE4->BE4_GRPINT
	cTpInt    := BE4->BE4_TIPINT
	cRegSol   := BE4->BE4_REGSOL
	cRegExe   := BE4->BE4_REGEXE
	cCID      := BE4->BE4_CID
	cInd 	  := BE4->BE4_INDCLI
	cRegInt   := BE4->BE4_REGINT
	cCdPFSO   := BE4->BE4_CDPFSO
	cCdPFRE   := BE4->BE4_CDPFRE
	cSigla    := BE4->BE4_SIGLA

	cDTpInt  := fbChgTpInt(cTpInt)

	if !empty(cCdPFSO)
		cDRegSol := fbChgProf(cCdPFSO,"1")
	endif

	if !empty(cCdPFRE)
		cDRegExe := fbChgProf(cCdPFRE,"1")
	endif

	cDCID 	 := fbChgCID(cCID)

	//*---------------------------------------------
	// Atribui as contidas no combo do X3 ao Vetor.|
	//*---------------------------------------------
	dbSelectArea('SX3')
	SX3->( dbSetOrder(2) )
	SX3->( dbSeek( "BE4_YTRANS" ) )
	aYTrans := strtokarr(alltrim(X3CBOX()),";")
	AAdd(aYTrans," ")
	//	BE4_GRPINT
	SX3->( dbSetOrder(2) )
	SX3->( dbSeek( "BE4_GRPINT" ) )
	aGrpInt := strtokarr(alltrim(X3CBOX()),";")

	//	BE4_GRPINT
	SX3->( dbSetOrder(2) )
	SX3->( dbSeek( "BE4_REGINT" ) )
	aRegInt := strtokarr(alltrim(X3CBOX()),";")


	//*-------------------------------------------------
	// Definicao do Dialog e todos os seus componentes.|
	//*-------------------------------------------------
	_oFont     := TFont():New( "Arial Narrow",0,-13,,.T.,0,,700,.F.,.F.,,,,,, )
	_oDlgAlt   := MSDialog():New( 092,232,500,845,OemtoAnsi(" Alteração do Cabeçalho da Guia "),,,.F.,,,,,,.T.,,,.T. )
	_oPanel1   := TPanel():New( 000,000,"",_oDlgAlt,,.F.,.F.,,,340,296,.T.,.F. )
	oGrp2      := TGroup():New( 008,008,178,300,OemtoAnsi("  Alteração do Cabeçalho da Guia  "),_oPanel1,CLR_BLACK,CLR_WHITE,.T.,.F. )

	_oSay1      := TSay():New( 024,016,{||"Meio Trans. "	},oGrp2,,_oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	_oSay2      := TSay():New( 044,016,{||"Grp.Intern. "	},oGrp2,,_oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	_oSay3      := TSay():New( 064,016,{||"Tipo.Intern "	},oGrp2,,_oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	_oSay5      := TSay():New( 084,016,{||"C.R. Solic. "	},oGrp2,,_oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	_oSay6      := TSay():New( 104,016,{||"C.R. Execut."	},oGrp2,,_oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	_oSay4      := TSay():New( 124,016,{||"CID Princip."	},oGrp2,,_oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	_oSay7      := TSay():New( 144,016,{||"Indic Clínic"	},oGrp2,,_oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)
	_oSay8      := TSay():New( 164,016,{||"Regime Inter"	},oGrp2,,_oFont,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,088,020)

	oYTrans     := TComboBox():New( 024,50,{|u| If(PCount()>0,cYTrans:=u,cYTrans)},aYTrans	,95,010,oGrp2,,        								,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cYTrans )
	oGrpInt     := TComboBox():New( 044,50,{|u| If(PCount()>0,cGrpInt:=u,cGrpInt)},aGrpInt	,95,010,oGrp2,, {|| cTpInt := '',oTpInt:Refresh(),cDTpInt := '',oDTpInt:Refresh()} ,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cGrpInt )

	oTpInt		:= TGet():New( 064,50,{|u|	IIf(PCount() == 0,	cTpInt	, cTpInt    := u)},oGrp2,95,008,/*picture*/,{ || !EMPTY(cGrpInt) .And. BQR->(ExistCpo("BQR", cGrpInt+cTpInt))  }/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.F./*[ uParam18]*/,.F./*[ uParam19]*/,{|| cDTpInt := fbChgTpInt(cTpInt),oDTpInt:Refresh() }/*change*/,.F.,.F.,/*[ uParam23]*/,"cTpInt",,,,.T.,.F. )
	oTpInt:bF3  := &('{|| IIf(ConPad1(,,,"BQVPLS",,,.F.),Eval({|| cTpInt := BQR->BQR_TIPINT,oTpInt:Refresh(),cDTpInt := BQR->BQR_DESTIP,oDTpInt:Refresh()}),.T.)}')
	oDTpInt		:= TGet():New( 064,150,{|u|	IIf(PCount() == 0,	cDTpInt	, cDTpInt    := u)},oGrp2,150,008,/*picture*/,{ || !EMPTY(cGrpInt) .And. BQR->(ExistCpo("BQR", cGrpInt+cTpInt))  }/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.T./*[ uParam18]*/,.F./*[ uParam19]*/,/*change*/,.T.,.F.,/*[ uParam23]*/,"cDTpInt",,,,.F.,.F. )

	oRegSol		:= TGet():New( 084,50,{|u|	IIf(PCount() == 0,	cRegSol	, cRegSol   := u)},oGrp2,95,008,"@R !!!!!!!!!!!!!!!"/*picture*/,{ || !EMPTY(cGrpInt) .And. BQR->(ExistCpo("BQR", cGrpInt+cTpInt))  }/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.F./*[ uParam18]*/,.F./*[ uParam19]*/,{|| cDRegSol := fbChgProf(cRegSol,"2","S"),oDRegSol:Refresh() }/*change*/,.F.,.F.,/*[ uParam23]*/,"cRegSol",,,,.T.,.F.)
	oRegSol:bF3 := &('{|| IIf(ConPad1(,,,"BTYPLS",,,.F.),Eval({|| cRegSol := BB0->BB0_NUMCR,cDRegSol := BB0->BB0_NOME,cCdPFSO := BB0->BB0_CODIGO,cEstSol := BB0->BB0_ESTADO,cSigla:=BB0->BB0_CODSIG ,oDRegSol:Refresh(),oRegSol:Refresh() }),.T.)}')
	oDRegSol	:= TGet():New( 084,150,{|u|	IIf(PCount() == 0,	cDRegSol	, cDRegSol    := u)},oGrp2,150,008,/*picture*/,/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/ ,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.T./*[ uParam18]*/,.F./*[ uParam19]*/,/*change*/,.T.,.F.,/*[ uParam23]*/,"cDRegSol",,,,.F.,.F. )

	oRegExe		:= TGet():New( 104,50,{|u|	IIf(PCount() == 0,	cRegExe	, cRegExe   := u)},oGrp2,95,008,/*picture*/,{|| Vazio() .or. !Empty(cRegExe) }/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.F./*[ uParam18]*/,.F./*[ uParam19]*/,{|| cDRegExe := fbChgProf(cRegExe,"2","E"),oDRegExe:Refresh() }/*change*/,.F.,.F.,/*[ uParam23]*/,"cRegExe",,,,.T.,.F.)
	oRegExe:bF3 := &('{|| IIf(ConPad1(,,,"BTYPLS",,,.F.),Eval({|| cRegExe := BB0->BB0_NUMCR,cDRegExe := BB0->BB0_NOME,cCdPFRE := BB0->BB0_CODIGO,cEstExe := BB0->BB0_ESTADO ,oRegExe:Refresh(),oRegExe:Refresh()}),.T.)}')
	oDRegExe	:= TGet():New( 104,150,{|u|	IIf(PCount() == 0,	cDRegExe	, cDRegExe    := u)},oGrp2,150,008,/*picture*/,/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.T./*[ uParam18]*/,.F./*[ uParam19]*/,/*change*/,.T.,.F.,/*[ uParam23]*/,"cDRegExe",,,,.F.,.F. )


	oCID		:= TGet():New( 124,50,{|u|	IIf(PCount() == 0,	cCID	, cCID      := u)},oGrp2,95,008,/*picture*/,{|| ( !EMPTY(cCID) .Or. BA9->(ExistCpo("BA9",cCID,1))) .and. u_fbVldCID(cCID)   }/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.F./*[ uParam18]*/,.F./*[ uParam19]*/,{|| cDCID := fbChgCID(cCID),oDCID:Refresh() }/*change*/,.F.,.F.,/*[ uParam23]*/,"cCID",,,,.T.,.F.	 )
	oCID:bF3 := &('{|| IIf(ConPad1(,,,"BA9PLS",,,.F.),Eval({|| cCID := BA9->BA9_CODDOE,oCID:Refresh(),cDCID := BA9->BA9_DOENCA,oDCID:Refresh()}),.T.)}')
	oDCID	:= TGet():New( 124,150,{|u|	IIf(PCount() == 0,	cDCID	, cDCID    := u)},oGrp2,150,008,/*picture*/,/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.T./*[ uParam18]*/,.F./*[ uParam19]*/,/*change*/,.T.,.F.,/*[ uParam23]*/,"cDCID",,,,.F.,.F. )

	oInd		:= TGet():New( 144,50,{|u|	IIf(PCount() == 0,	cInd	, cInd   	:= u)},oGrp2,200,008,'@S70'/*picture*/,/*valid*/,CLR_BLACK,CLR_WHITE,/*font*/,/*[ uParam12]*/,/*[ uParam13]*/,.T.,/*[uParam15]*/,/*[ uParam16]*/,/*when*/,.F./*[ uParam18]*/,.F./*[ uParam19]*/,/*change*/,.F.,.F.,/*[ uParam23]*/,"cInd",,,,.T.,.F.	 )
	oGrpInt     := TComboBox():New( 164,50,{|u| If(PCount()>0,cRegInt:=u,cRegInt)},aRegInt	,95,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cRegInt )


	oBtn1      	:= TButton():New( 184,263,"Salvar",_oPanel1,{||	_oDlgAlt:End(),Processa( {||  fGrava()  }, "Gravando dados da internação.","",.T.) },037,012,,,,.T.,,"Clique para salvar"	,,,,.F. )

	_oDlgAlt:Activate(,,,.T.)

	RestArea(aAreaBE4)
	RestArea(aArea)

Return

/* Grava dados da internação*/
Static function fGrava()


	Reclock("BE4",.F.)
	BE4->BE4_YTRANS := cYTrans
	BE4->BE4_GRPINT := cGrpInt
	BE4->BE4_TIPINT	:= cTpInt
	BE4->BE4_REGSOL := cRegSol
	BE4->BE4_REGEXE	:= cRegExe
	BE4->BE4_CID	:= cCID
	BE4->BE4_INDCLI	:= cInd
	BE4->BE4_REGINT := cRegInt
	BE4->BE4_ESTEXE := cEstExe
	BE4->BE4_ESTSOL := cEstSol
	BE4->BE4_CDPFSO := cCdPFSO
	BE4->BE4_CDPFRE := cCdPFRE
	BE4->BE4_CDPFRE := cCdPFRE
	BE4->BE4_NOMEXE := cDRegExe
	BE4->BE4_NOMSOL := cDRegSol

	BE4->(MsUnLock())

	Alert("Dados Alterados com sucesso!")

Return

/* Executado no Change do campo Tipo.Intern */
Static function fbChgTpInt(cInt)

	Local cRet := ""

	cRet  := GetAdvFVal("BQR","BQR_DESTIP",xFilial("BQR")+cGrpInt+cInt,1)

Return cRet
/* Executado no Change do campo Profissional */
Static function fbChgProf(cProf,cOpc,cTipo)

	Local cRet := ""

	if cOpc == "1"

		cRet  := GetAdvFVal("BB0","BB0_NOME",xFilial("BB0")+alltrim(cProf),1)

	else

		cRet  := GetAdvFVal("BB0","BB0_NOME",xFilial("BB0")+alltrim(cProf),7)

		if cTipo == "S"

			cCdPFSO  := GetAdvFVal("BB0","BB0_CODIGO",xFilial("BB0")+alltrim(cProf),7)
			cEstSol	 := GetAdvFVal("BB0","BB0_ESTADO",xFilial("BB0")+alltrim(cProf),7)

		else

			cCdPFRE  := GetAdvFVal("BB0","BB0_CODIGO",xFilial("BB0")+alltrim(cProf),7)
			cEstExe	 := GetAdvFVal("BB0","BB0_ESTADO",xFilial("BB0")+alltrim(cProf),7)

		endif

	endif

Return cRet

/* Executado no Change do campo Profissional */
Static function fbChgCID(pCid)

	Local cRet := ""

	cRet  := GetAdvFVal("BA9","BA9_DOENCA",xFilial("BA9")+alltrim(pCid),1)

Return cRet

//******************************************************
// Autor: Mateus Medeiros
// Validação CID
// Data: 19/12/2017
//******************************************************
User function fbVldCID(pCid)

	Local lRet := .F.

	lRet  := GETADVFVAL("BA9","BA9_XATIVO",xFilial("BA9")+pCid,1) == 'S'

	if !lRet
		MsgStop("CID Bloqueado","CID")
	endif

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CB92DtInºAutor  ³Alexander			 º Data ³  29/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Inclusao,Alteracao e Exclusao da Data de Internacao		  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CB92DtIn(lRpc,dDatIntW,cHorIntW,lPtuOn)

	LOCAL oFont         := NIL
	LOCAL lMostraSenha 	:= .F.
	LOCAL lDataAlt 	 	:= A92BQV()
	LOCAL dDatInt	 	:= If(Empty(BE4->BE4_DATPRO),dDataBase,BE4->BE4_DATPRO )
	LOCAL cHorInt  	 	:= If(Empty(BE4->BE4_HORPRO),StrTran(Time(),":",""),BE4->BE4_HORPRO)
	LOCAL cChave  	 	:= BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)
	LOCAL cChaveInt  	:= BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
	LOCAL cMatric		:= BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG)
	LOCAL nOrdBD6    	:= BD6->(IndexOrd())
	LOCAL nRecBD6	 	:= BD6->(Recno())
	LOCAL nOpca      	:= 3
	LOCAL cMsg			:= ""
	LOCAL lMVPromo := SuperGetMV("MV_PROSAUD", NIL, .F.)  // Promoção a Saude
	LOCAL lMVVEleg := SuperGetMV("MV_VELEGUI", NIL, .F.)  // Promoção a Saude  - verifica elegiveis
	LOCAL nRetBlq		:= 0
	LOCAL aRetFun		:= {}
	LOCAL lBpBlq		:= .F.
	LOCAL nAvs			:= 0
	LOCAL dDatBloq	:= NIL
	DEFAULT lRpc		:= .F.
	DEFAULT dDatIntW	:= Date()
	DEFAULT cHorIntW    := Left(Time(),5)
	DEFAULT lPtuOn      := .F.

	//Se foi cancelada
	If BE4->BE4_SITUAC == '2'
		If lRpc
			cMsg := STR0164//"A Guia selecionada foi cancelada."
			Return {cMsg,"",""}
		Else
			Help("",1,"PLSA092CAN")
			Return
		EndIf
	EndIf

	//Se nao foi autorizada
	If BE4->BE4_STATUS == "3" .OR. BE4->BE4_STATUS == "6"
		If !lRpc
			Aviso( "A guia nao foi autorizada.", "A guia nao foi autorizada." , {  "OK"  }, 2 ) //"A guia nao foi autorizada."
		Else
			cMsg := "A guia nao foi autorizada." //"A guia nao foi autorizada."
		EndIf
		Return {cMsg,"",""}
	EndIf

	aRetFun := PLSDADUSR(cMatric,"1",.T.,dDataBase,nil,nil,nil)
	If !aRetFun[1]
		BDS->(dbSetOrder(1))
		If lRpc
			cMsg := "Problemas com o contrato do beneficiario."
			Return {cMsg,"",""}
		ElseIf BDS->(dbSeek(xFilial("BDS") + cChaveInt)) .And. Empty(BDS->(BDS_CODPAD+BDS_SEQUEN+BDS_CODPRO))
			nAvs:= Aviso("Usuário Bloqueado" ,;//"Usuário Bloqueado"
				"Problemas com o contrato do beneficiário no período do atendimento, porém a crítica de bloqueio foi forçada com a seguinte justificativa:" + CRLF + ;//"Problemas com o contrato do beneficiário no período do atendimento, porém a crítica de bloqueio foi forçada com a seguinte justificativa:"
				"Observação: " + AllTrim(BDS->BDS_OBSMOT) + CRLF +;//"Observação: "
				"Operador: " + AllTrim(BDS->BDS_OPESIS) + " - " + AllTrim(BDS->BDS_NOMOPE) + CRLF + "Deseja Prosseguir?",;//"Operador: " ## "Deseja Prosseguir?"
				{"Sim","Não"},3)
			If nAvs == 2
				Return
			Else
				lBpBlq := .T.
			EndIf
		Else
			Aviso( "Atenção", "Problemas com o contrato do beneficiario." , {  "OK"  }, 2 ) //"Problemas com o contrato do beneficiario."
			Return {cMsg,"",""}
		EndIf

	Endif

	aRetFun := PLSVLDCON(cMatric,dDataBase,nil,nil,'1',dDataBase,nil,BE4->BE4_CODRDA,nil)
	If !aRetFun[1]
		dDatBloq := CtoD(aRetFun[2][3][3])
		BDS->(dbSetOrder(1))
		If lRpc
			If dDatIntW > dDatBloq
				cMsg := "Problemas com o contrato do beneficiario."
				Return {cMsg,"",""}
			EndIf
		ElseIf BDS->(dbSeek(xFilial("BDS") + cChaveInt)) .And. Empty(BDS->(BDS_CODPAD+BDS_SEQUEN+BDS_CODPRO))
			nAvs:= Aviso("Usuário Bloqueado" ,;//"Usuário Bloqueado"
				"Problemas com o contrato do beneficiário no período do atendimento, porém a crítica de bloqueio foi forçada com a seguinte justificativa:" + CRLF + ;//"Problemas com o contrato do beneficiário no período do atendimento, porém a crítica de bloqueio foi forçada com a seguinte justificativa:"
				"Observação: " + AllTrim(BDS->BDS_OBSMOT) + CRLF +;//"Observação: "
				"Operador: " + AllTrim(BDS->BDS_OPESIS) + " - " + AllTrim(BDS->BDS_NOMOPE) + CRLF + "Deseja Prosseguir?",;//"Operador: " ## "Deseja Prosseguir?"
				{"Sim","Não"},3)
			If nAvs == 2
				Return
			Else
				lBpBlq := .T.
			EndIf
		Else
			Aviso( "Atenção", "Problemas com o contrato do beneficiario." , {  "OK"  }, 2 ) //"Problemas com o contrato do beneficiario."
			//Return {cMsg,"",""}
		EndIf
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nao permiti alterar quando for transacao online							 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BE4->( FieldPos("BE4_NRTROL") ) > 0 .And. BE4->( FieldPos("BE4_NRAOPE") ) > 0 .And. !Empty(BE4->BE4_NRTROL) .And. Empty(BE4->BE4_NRAOPE) .And. !lPtuOn
		If !lRpc
			Aviso( "Atenção", "Guia On-Line, não e possível alterar a data de internação!" , {  "OK"  }, 2 ) //"Guia On-Line, não e possível alterar a data de internação!"
		Else
			cMsg := STR0112
		EndIf
		Return {cMsg,"",""}
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	//³ Verifica se o paciente ja esta internado, com excessão se for recem nascido
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	If BE4->BE4_ATERNA == '0'
		if PLSPOSGLO(PLSINTPAD(),__aCdCri207[1],__aCdCri207[2],'','1','')
			If PLSPACINT(cMatric,iif(!lRpc,dDataBase,date()),,,.T.)
				If !lRpc
					Aviso( "Atenção", PLSBCTDESC() , {  "OK"  }, 2 )
				Else
					cMsg := PLSBCTDESC()
				EndIf
				Return {cMsg,"",""}
			EndIf
		endIf
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se for solicitacao Ptu Online    										 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lPtuOn
		nOpca := 0
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define fontes utilizadas somente nesta funcao...                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(BE4->BE4_DTALTA)
		If !lRpc
			Aviso( "Atenção", "Data da alta ja informada."	 , {  "OK"  }, 2 ) //"Data da alta ja informada."
		Else
			cMsg := STR0107
		EndIf
		Return {cMsg,"",""}
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define fontes utilizadas somente nesta funcao...                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lRpc
		DEFINE FONT oFont NAME "Arial" SIZE 000,-016 BOLD
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Dialog...                                                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE MSDIALOG oDlg TITLE STR0117 FROM 008.2,003.3 TO 016,055 OF GetWndDefault() //"Alimentar Data de Internação"
		@ 05, 10  Say oSay PROMPT STR0118 	SIZE 160,10 OF oDlg PIXEL FONT oFont COLOR CLR_HBLUE //"Data da Internação"
		@ 18, 10  MSGET oGet VAR dDatInt				SIZE 70,10 OF oDlg FONT oFont PICTURE "@D" WHEN lDataAlt VALID A360CHEBLO(BE4->BE4_CODRDA,dDatInt) .And. lDataOk2(dDatInt)  PIXEL

		@ 05, 110  Say oSay PROMPT STR0119 SIZE 160,10 	OF oDlg PIXEL FONT oFont COLOR CLR_HBLUE //"Hora da Internação"
		@ 18, 110  MSGET oGet VAR cHorInt 				SIZE 20,10	OF oDlg FONT oFont PICTURE "@R 99:99" WHEN lDataAlt PIXEL
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Botoes																	 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		bInAl			:= TButton():New(38,20, Iif(Empty(BE4->BE4_DATPRO),'Incluir','Alterar'),,{ || nOpca := 0 , oDlg:End() } , 040, 012 ,,,,.T.)
		bExc 			:= TButton():New(38,80, 'Excluir'	,,{ || nOpca := 1,oDlg:End() } , 040, 012 ,,,,.T.)
		bExc:LREADONLY 	:= (!lDataAlt .Or. Empty(BE4->BE4_DATPRO))

		//bFechar := TButton():New(38,140, 'Fechar'	,,{ || nOpca := 2 , oDlg:End() } , 040, 012 ,,,,.T.)
		ACTIVATE MSDIALOG oDlg CENTERED
	Else
		If !A360CHEBLO(BE4->BE4_CODRDA,dDatInt,lRpc) .And. lDataOk2(dDatInt)
			Return STR0124
		Else
			dDatInt := dDatIntW
			cHorInt := cHorIntW
			nOpca   := 0
		EndIf
	EndIf
	//Verifica se usuario está bloqueado na data de internacao
	If nOpca == 0 .And. PLSPOSGLO(PLSINTPAD(),__aCdCri008[1],__aCdCri008[2],"1"/*cLocalExec*/,/*cAtivo*/,"1"/*cTpLocExec*/)
		lBloq := .F.
		aRetBlq := {}
		aRetBlq := PLSIBBLQ(DTOS(dDataBase),DTOS(dDatInt-GetNewPar("MV_PLDIABL",0)),aRetBlq,SubStr(cMatric,1,14),SubStr(cMatric,15,2),""/*cLocSib*/,""/*cExcAns*/)
		For nRetBlq := 1 TO Len(aRetBlq)
			If Len(aRetBlq[nRetBlq]) > 1 .And. aRetBlq[nRetBlq-1] == "0" .And. DTOS(dDatInt+GetNewPar("MV_PLDIABL",0)) > aRetBlq[nRetBlq,3]
				lBloq := .T.
			Elseif Len(aRetBlq[nRetBlq]) > 1 .And. aRetBlq[nRetBlq-1] == "1".And. DTOS(dDatInt+GetNewPar("MV_PLDIABL",0)) > aRetBlq[nRetBlq,3]
				lBloq := .F.
			EndIf
		Next nRetBlq

		If lBloq .And. !lBpBlq
			If !lRPC
				MsgInfo(STR0150)//"Usuario bloqueado na data de internacao"
			EndIf
			Return {STR0150,"",""}
		EndIf

	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca retorno contido no aRetorno...                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOpca < 2

		if lDataOk2(dDatInt) .and.  nOpca == 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a data e maior que alguma da evolucao						 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !lDataAlt .And. nOpca == 0
				BQV->( DbSetOrder(1) )//BQV_FILIAL + BQV_CODOPE + BQV_ANOINT + BQV_MESINT + BQV_NUMINT
				If BQV->( MsSeek(xFilial("BQV")+cChaveInt) )
					While !BQV->(Eof())	.And. BQV->(xFilial("BQV")+BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT) == xFilial("BQV")+cChaveInt
						If BQV->( FieldPos("BQV_DATPRO") ) > 0 .And. BQV->BQV_DATPRO < dDatInt
							If !lRpc
								MsgAlert(STR0120) //"Existe evolucao de GIH com data anterior a data informada!"
							Else
								cMsg := STR0120
							EndIf
							Return {cMsg,"",""}
						EndIf
						BQV->( DbSkip() )
					EndDo
				EndIf
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a data ou hora estao em branco								 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Empty(DToS(dDatInt)) .Or. Empty(cHorInt)
				If !lRpc
					MsgAlert(STR0132) //"Data e/ou hora em branco!"
				Else
					cMsg := STR0132
				EndIf
				Return {cMsg,"",""}
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Exclusao																 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		ElseIf nOpca == 1
			dDatInt := Ctod(Space(8))
			cHorInt := ""
		EndIf


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicia transacao...                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Begin Transaction
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atualiza a data de internacao										     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BE4->( RecLock("BE4", .F.) )
			BE4->BE4_DATPRO := dDatInt
			BE4->BE4_HORPRO := cHorInt
			If Empty(BE4->BE4_SENHA) .And. nOpca == 0
				BE4->BE4_SENHA := PLSSenAut(dDatInt)
				lMostraSenha   := .T.
			Endif

			//BAU_GRALAU = 1 - Grava data de alta automatica
			If BAU->(FieldPos("BAU_GRALAU")) > 0
				BAU->(dbSetOrder(1))
				If BAU->(msSeek(xFilial("BAU")+BE4->BE4_CODRDA)) .And. BAU->BAU_GRALAU == "1"
					aDiaPrs := PLSDIARLIB()
					//BE4->BE4_DTALTA := dDatInt + aDiaPrs[1] + aDiaPrs[2]
					BE4->BE4_DTALTA := dDatInt + BE4->BE4_DIASIN
					BE4->BE4_HRALTA := Left(StrTran(Time(),":",""),5)
				EndIf
			EndIF
			BE4->( MsUnLock() )
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atualiza O BEA														     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BEA->( DbSetOrder(1) ) //BEA_FILIAL + BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT + DTOS(BEA_DATPRO) + BEA_HORPRO
			If BEA->( MsSeek( xFilial("BEA") + cChaveInt ) )
				BEA->( RecLock("BEA", .F.) )
				BEA->BEA_DATPRO := dDatInt
				BEA->BEA_HORPRO := cHorInt
				If lPtuOn .Or. GetNewPar("MV_PLSUNI","1") == "1"  .And.(BEA->BEA_CODEMP == GetNewPar("MV_PLSGEIN","0050").Or. BEA->BEA_TIPPRE == GetNewPar("MV_PLSTPIN","OPE"))
					BEA->BEA_VALSEN := dDatInt+GetNewPar("MV_PLPRZPT",30)
				Else
					BEA->BEA_VALSEN := dDatInt+GetNewPar("MV_PLPRZLB",30)
				EndIf
				If lMostraSenha
					BEA->BEA_SENHA := BE4->BE4_SENHA
					cMsg = ""
				Endif
				BEA->( MsUnLock() )
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Ponto de entrada após confirma a data de internação e após		             ³
			//³a gravação das tabelas "BE4" e "BEA", utilizado para customizações do usuário.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ExistBlock("PLS092INT")
				ExecBlock("PLS092INT",.F.,.F.,{dDatInt,cHorInt,BE4->BE4_SENHA,BE4->BE4_REGINT})
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Mostra a Senha															 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BEJ->( DbSetOrder(1) ) //BEJ_FILIAL + BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT + BEJ_SEQUEN
			BD6->( DbSetOrder(1) ) //BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO
			If BD6->( MsSeek( xFilial("BD6")+cChave ) )
				While BD6->( !EOF() ) .And. cChave == BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV)
					If BEJ->( MsSeek( xFilial("BEJ")+BD6->(BD6_CODOPE+BD6_ANOINT+BD6_MESINT+BD6_NUMINT+BD6_SEQUEN) ) )
						BD6->(RecLock("BD6",.F.))
						BD6->BD6_DATPRO := dDatInt
						BD6->BD6_HORPRO := cHorInt
						BD6->(MsUnLock())
					EndIf
					BD6->(DbSkip())
				EndDo
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Reposiciona o bd6													  	 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BD6->(DbGoTo(nRecBD6))
			BD6->(DbSetOrder(nOrdBD6))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Mostra a Senha															 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		End Transaction
		If lMostraSenha .And. nOpca == 0 .And. !lRpc
			A092Final(BE4->BE4_SENHA,BE4->BE4_CODOPE,BE4->BE4_ANOINT,BE4->BE4_MESINT,BE4->BE4_NUMINT,0,{},"1")
		EndIf
		If lMVPromo .And. FindFunction("PLSPROALE") .AND. nOpca == 0
			BOM->(DbSetOrder(3))
			If (BOM->(MsSeek(xFilial("BOM") + BE4->BE4_MATVID+"1")) .or. BOM->(MsSeek(xFilial("BOM") + BE4->BE4_MATVID+"3")))

				BOA->(DbSetOrder(1))
				IF BOA->(MsSeek(xFilial("BOA") + BOM->BOM_CODPRO))
					If !Empty(BE4->BE4_CID)
						cCid := BE4->BE4_CID
					EndIf

					PLSPROALE("",STR0136 + "  "+ Alltrim(BE4->BE4_NOMUSR)+ "  " + STR0137,dDataBase,Time(),"3",BE4->BE4_MATVID, "0",; //"Pac. " ###  "(entrada na internação)! "
						STR0138 +"  "+ Alltrim(BE4->BE4_NOMUSR)+ "  " +; //	"O Paciente "
						STR0139 + DTOC(dDatInt) + STR0140 +"  "+ Alltrim(BE4->BE4_NOMRDA) + " " + IIF(!Empty(cCid),"CID: " + cCid, ""),; //	" deu entrada na internação em " ### " - Credenciado: "
						"",BOM->BOM_CODPRO,IIF(!Empty(cCid),'0',""),BOM->BOM_CODLOC)

				Endif

			Endif
			If lMVVEleg // VERIFICA ELEGIVEIS NO MOMENTO DA CONFIRMACAO
				PLSELEG(,BE4->BE4_MATVID, , , , , .T., /*cCodCrm*/)
			EndIf
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Finaliza transacao...                                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina															 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return( {cMsg,BEA->BEA_VALSEN,BE4->BE4_SENHA} )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A92BQV    ºAutor  ³Microsiga           º Data ³  06/17/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica se pode ou nao alteracao na data de internacao    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A92BQV()
	LOCAL aArea  := GetArea()
	LOCAL nCount := 0

	If BQV->(MsSeek(xFilial("BQV")+BE4->BE4_CODOPE+BE4->BE4_ANOINT+BE4->BE4_MESINT+BE4->BE4_NUMINT))
		BQV->(DBEval({|| nCount++},,;
			{||BQV_FILIAL+BQV_CODOPE+BQV_ANOINT+BQV_MESINT+BQV_NUMINT == xFilial("BQV")+BE4->BE4_CODOPE+BE4->BE4_ANOINT+BE4->BE4_MESINT+BE4->BE4_NUMINT},,,.F.))
	EndIf

	RestArea(aArea)

Return(nCount==0)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ A092Final ³ Autor ³ Alexander            ³ Data ³ 29.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Exibir a senha de autorizacao de internacao                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function A092Final(cSenhaPLS,cCodOpe,cAnoInt,cMesInt,cNumInt,nTp,aDadSen,cMultSen)
	LOCAL oDlg
	LOCAL oSay
	LOCAL cTit
	LOCAL cText
	LOCAL oFontNum
	LOCAL oFontAutor
	LOCAL oFontTit
	LOCAL cRodape
	LOCAL cNomUser  := BE4->BE4_OPEUSR+'.'+BE4->BE4_CODEMP+'.'+BE4->BE4_MATRIC+'.'+BE4->BE4_TIPREG+" - "+BE4->BE4_NOMUSR
	LOCAL cNomRDA   := TransForm(BE4->BE4_CODRDA,PesqPict("BE4","BE4_CODRDA"))+" - "+BE4->BE4_NOMRDA
	DEFAULT cCodOpe := ""
	DEFAULT cAnoInt := ""
	DEFAULT cMesInt := ""
	DEFAULT cNumInt := ""
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Titulo																	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTp == 0
		cTit  := STR0084 //"Senha de Autorizacao"
		cText := STR0087 //"Senha"
	Else
		cTit  := STR0085 //"Resumo da Evolucao GIH"
		cText := STR0086 //"Senha do procedimento"
	EndIf


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Ponto de entradada para customização de usuário.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ExistBlock("PLA092FIM")
		Execblock("PLA092FIM",.F.,.F.,{(cCodOpe+"."+cAnoInt+"."+cMesInt+"."+cNumInt),BE4->BE4_MATRIC,cSenhaPls})
	EndIf


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// Se mostra somente um ou plscrigen
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cMultSen == "1"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define fontes utilizadas somente nesta funcao...                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE FONT oFontNum 	NAME "Arial" SIZE 000,-016 BOLD
		DEFINE FONT oFontAutor 	NAME "Arial" SIZE 000,-019 BOLD
		DEFINE FONT oFontTit 	NAME "Arial" SIZE 000,-011 BOLD
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Mostra Resumo 															 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE MSDIALOG oDlg TITLE cTit FROM 009,000 TO 024,070 OF GetWndDefault() //"Dados da Evolucao de GIH"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ sButton																	 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SButton():New(097, 005, 1, {|| oDlg:End() },,.T.)
		SButton():New(097, 035, 6, bImpGuia,,.T.)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Say e Get																 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ 007,005 SAY oSay PROMPT STR0088   SIZE 220,010 OF oDlg PIXEL FONT oFontNum //"Internacao Numero   "
		@ 006,095 SAY oSay PROMPT cCodOpe+"."+cAnoInt+"."+cMesInt+"."+cNumInt SIZE 220,010 OF oDlg PIXEL FONT oFontAutor COLOR CLR_HRED

		@ 025,005 SAY oSay PROMPT STR0089   SIZE 220,010 OF oDlg PIXEL //"Usuario              "
		@ 025,065 MSGET cNomUser            SIZE 205,010 OF oDlg PIXEL FONT oFontTit COLOR CLR_HBLUE

		@ 043,005 SAY oSay PROMPT STR0090   SIZE 220,010 OF oDlg PIXEL //"Rede Atendimento     "
		@ 043,065 MSGET cNomRDA             SIZE 205,010 OF oDlg PIXEL FONT oFontTit COLOR CLR_HBLUE

		If !Empty(cSenhaPls)
			@ 063,005 SAY oSay PROMPT cText  SIZE 220,010 OF oDlg PIXEL
			@ 063,065 MSGET cSenhaPls        SIZE 100,010 OF oDlg PIXEL FONT oFontTit COLOR CLR_HBLUE
		Endif
		ACTIVATE MSDIALOG oDlg CENTERED
	Else
		If nTp == 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define fontes utilizadas somente nesta funcao...                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE FONT oFontNum 	NAME "Arial" SIZE 000,-016 BOLD
			DEFINE FONT oFontAutor 	NAME "Arial" SIZE 000,-019 BOLD
			DEFINE FONT oFontTit 	NAME "Arial" SIZE 000,-011 BOLD
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Mostra Resumo 															 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE MSDIALOG oDlg TITLE cTit FROM 009,000 TO 024,070 OF GetWndDefault()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ sButton																	 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SButton():New(097, 005, 1, {|| oDlg:End() },,.T.)
			SButton():New(097, 035, 6, bImpGuia,,.T.)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Say e Get																 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			@ 007,005 SAY oSay PROMPT STR0088   SIZE 220,010 OF oDlg PIXEL FONT oFontNum //"Internacao Numero   "
			@ 006,095 SAY oSay PROMPT cCodOpe+"."+cAnoInt+"."+cMesInt+"."+cNumInt SIZE 220,010 OF oDlg PIXEL FONT oFontAutor COLOR CLR_HRED

			@ 025,005 SAY oSay PROMPT STR0089   SIZE 220,010 OF oDlg PIXEL //"Usuario              "
			@ 025,065 MSGET cNomUser            SIZE 205,010 OF oDlg PIXEL FONT oFontTit COLOR CLR_HBLUE

			@ 043,005 SAY oSay PROMPT STR0090   SIZE 220,010 OF oDlg PIXEL //"Rede Atendimento     "
			@ 043,065 MSGET cNomRDA             SIZE 205,010 OF oDlg PIXEL FONT oFontTit COLOR CLR_HBLUE

			If !Empty(aDadSen)
				@ 063,005 SAY oSay PROMPT cText  SIZE 220,010 OF oDlg PIXEL
				@ 063,065 MSGET aDadSen[1]        SIZE 040,010 OF oDlg PIXEL FONT oFontTit COLOR CLR_HBLUE
			Endif
			ACTIVATE MSDIALOG oDlg CENTERED
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta o Rodape															 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cRodape := STR0088+cCodOpe+"."+cAnoInt+"."+cMesInt+"."+cNumInt+Space(10)
			cRodape += STR0089+cNomUser
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Exibe o resultado													     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			PLSCRIGEN(aDadSen,{ {STR0091,"@C",250},{STR0087,"@C",40} },cTit,Nil,cRodape)
		EndIF
	EndIf


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da Rotina															 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return




//************************************************************************************************************************************** */


User Function InfAutor

	Local oFont14b     := TFont():New("Arial",,-14,.T.,.T.)
	Local oButton1
	Local oButton2
	Local oGet1
	Local dGet1 := BE4->BE4_XDTLIB
	Local oGrp
	Static oDlg
	Local lOk			:= .F.
	Local lInfAlta		:=  ( RetCodUsr() $ (  SUPERGETMV("MV_XALTAUT", .T., "001504") ) )
	Local cTit			:= "Alteração da data da Autorização"

	Private cUserName   := USRRETNAME(RetCodUsr())

	If Vazio(dGet1)

		MsgStop('Internação sem data de autorização.',  "" )
		Return

	EndIf

	if BE4->BE4_CODLDP == '0000'

		DEFINE MSDIALOG oDlg TITLE cTit FROM 000, 000  TO 160, 250 COLORS 0, 16777215 PIXEL

		@ 004, 004 GROUP oGrp TO 057, 122  PROMPT "Data de autorização" OF oDlg  COLOR 0, 16777215  PIXEL
		@ 018, 011 MSGET oGet1 VAR dGet1 SIZE 100, 014 OF oDlg FONT oFont14b COLORS 0, 16777215 PIXEL
		@ 061, 044 BUTTON oButton1 PROMPT "OK" SIZE 035, 012 OF oDlg ACTION {|| lOk := .T., oDlg:End()  }  PIXEL
		@ 061, 087 BUTTON oButton2 PROMPT "Cancelar" SIZE 034, 012 OF oDlg ACTION {||lOk := .F., oDlg:End()}  PIXEL

		ACTIVATE MSDIALOG oDlg CENTERED

		If lOk

			If !lInfAlta

				MsgStop('Usuário [ ' + cValToChar(RetCodUsr()) + ' - ' + AllTrim(UsrFullName(RetCodUsr())) + ' ] sem permissão para alterar data de autorização!',AllTrim(SM0->M0_NOMECOM))

			ElseIf MsgYesNo('Confirma '+cTit,AllTrim(SM0->M0_NOMECOM))

				BE4->(Reclock('BE4',.F.))

				BE4->BE4_XDTLIB := dGet1
				BE4->BE4_DTDIGI := dGet1
				BE4->BE4_XUSALT := cUserName
				BE4->BE4_XDTALT := ddatabase

				BE4->(MsUnlock())

				MsgInfo('Data de autorização alterada.', AllTrim(SM0->M0_NOMECOM))

			EndIf

		EndIf
	Else

		MsgStop('Somente é permitido nas Guias de Solicitação de Internação.',  "" )

	Endif

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function fSmsEmail
Rotina para atualizar os campos de SMS e Email
@author  Angelo Henrique
@since   22/09/2021
@type function
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function fSmsEmail()

	Local _cSMS 	:= BE4->BE4_YNMSMS
	Local _cEmail 	:= BE4->BE4_YMAIL
	Local lOk		:= .F.
	Local oFont1	:= Nil
	Local oDlg1		:= Nil
	Local oGrp1		:= Nil
	Local oSay1		:= Nil
	Local oSay2		:= Nil
	Local oGet1		:= Nil
	Local oGet2		:= Nil
	Local oBtn1		:= Nil
	Local oBtn2		:= Nil

	if BE4->BE4_CODLDP == '0000'

		oFont1     := TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )
		oDlg1      := MSDialog():New( 092,232,270,796,"Atualização SMS e EMAIL",,,.F.,,,,,,.T.,,,.T. )
		oGrp1      := TGroup():New( 000,004,076,272,"     SMS e E-MAIL     ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

		oSay1      := TSay():New( 012,012,{||"SMS"		},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,028,012)
		oGet1      := TGet():New( 012,044,{|u| If(PCount()==0,_cSMS	,_cSMS :=u)},oGrp1,092,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)		

		oSay2      := TSay():New( 028,012,{||"E-mail"	},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,012)
		oGet2      := TGet():New( 028,044,{|u| If(PCount()==0,_cEmail,_cEmail :=u)},oGrp1,220,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)

		oBtn1      := TButton():New( 056,184,"Salvar"	,oGrp1,{||oDlg1:End(), lOk := .T.	},037,012,,,,.T.,,"",,,,.F. )
		oBtn2      := TButton():New( 056,228,"Cancelar"	,oGrp1,{||oDlg1:End()				},037,012,,,,.T.,,"",,,,.F. )

		oDlg1:Activate(,,,.T.)

		If lOk

			BE4->(Reclock('BE4',.F.))

			BE4->BE4_YNMSMS := _cSMS
			BE4->BE4_YMAIL  := _cEmail

			BE4->(MsUnlock())

			MsgInfo('SMS e E-mail atualizados.', AllTrim(SM0->M0_NOMECOM))

		EndIf

	Else

		MsgStop('Somente é permitido nas Guias de Solicitação de Internação.',  "" )

	Endif

Return
