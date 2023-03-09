#INCLUDE "PROTHEUS.CH"
#INCLUDE "COMMON.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE 'AP5MAIL.CH'
#INCLUDE "PLSMGER.CH"
#INCLUDE "PLSMGER2.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CDPROTREE º Autor ³ Jean Schulz        º Data ³  18/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³   Cadastro para possibilitar a inclusao de protocolos a    º±±
±±º          ³  serem pagos para beneficiarios. Devera ser utilizado 	  º±±
±±º          ³  junto a rotina padrao de Reembolso.                       º±±
±±º          ³															  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CDPROTREE()

Private cCadastro	:= "Cadastro de Protocolo de Reembolso"
Private aRotina		:= {{"Pesquisar",		'AxPesqui',			0, K_Pesquisar	},;
						{"Visualizar",		'U_VisProtR',		0, K_Visualizar	},;
						{"Incluir",			'U_IncProtR',		0, K_Incluir	},;
						{"Imp. Protocolo",	'U_ImpRelPr',		0, K_Alterar	},;
						{"Cancelar",		'U_CanProtR(1)',	0, K_Alterar	},;
						{"Conhecimento",	'MsDocument',		0, K_Alterar	},;
						{"Legenda",			"U_LegProtr",		0, K_Alterar	}}
Private aCores		:= CdProLeg()
Private cAlias		:= "ZZQ"

ZZQ->(DBSetOrder(1))
ZZQ->(mBrowse(006,001,022,075,cAlias,,,,,Nil,aCores,,,,nil,.F.))

return


/*/{Protheus.doc} CdProLeg
//Descrição: Criação das legendas
@author Mateus Medeiros
@since 29/09/2017
/*/
Static Function CdProLeg()

Local aCores	:= {}

aAdd(aCores, {'AllTrim(ZZQ->ZZQ_STATUS) == "1" .and. AllTrim(ZZQ->ZZQ_XWEB) <> "1"', 'BR_VERDE'		})
aAdd(aCores, {'AllTrim(ZZQ->ZZQ_STATUS) == "2" .and. AllTrim(ZZQ->ZZQ_XWEB) <> "1"', 'BR_VERMELHO'	})
aAdd(aCores, {'AllTrim(ZZQ->ZZQ_STATUS) == "3" .and. AllTrim(ZZQ->ZZQ_XWEB) <> "1"', 'BR_AZUL'		})
aAdd(aCores, {'AllTrim(ZZQ->ZZQ_STATUS) == "4" .and. AllTrim(ZZQ->ZZQ_XWEB) <> "1"', 'BR_AMARELO'	})
aAdd(aCores, {'AllTrim(ZZQ->ZZQ_XWEB)   == "1"',									 'BR_CINZA'		})

return aCores


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ VisProtR   ³ Autor ³ Jean Schulz       ³ Data ³ 18.05.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Visualizar registro de protocolo de reembolso.             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VisSenhas(cCodBen)

if !empty(cCodBen)

	BA1->(DbSetOrder(2))
	if BA1->(DbSeek(xFilial("BA1") + cCodBen )) .and. len(AllTrim(cCodBen)) == 17
		U_PLSPSQLIB(cCodBen)
	else
		MsgInfo("Beneficiário não localizado!")
	endif

else 
	MsgInfo("Beneficiário não informado!")
endif

return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ VisProtR   ³ Autor ³ Jean Schulz       ³ Data ³ 18.05.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Visualizar registro de protocolo de reembolso.             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VisProtR(cAlias,nReg,nOpc)

Local oDlg
Local oEnc	
Local bOK			:= { || oDlg:End() }

Local aSizeAut		:= MsAdvSize()
Local aInfo			:= {}
Local aPosObj		:= {}
Local aButtons		:= {}

aObjects	:= {}
AAdd( aObjects, { 315,  30, .T., .T. } )
AAdd( aObjects, { 100,  70, .T., .T. } )

aInfo	:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj	:= MsObjSize( aInfo, aObjects, .T. )

aAdd(aButtons, {"S4WB007N",  {|| MostraRee(ZZQ->ZZQ_SEQUEN, oEnc)				}, "Reembolso"				})
aAdd(aButtons, {"ANALITICO", {|| MsDocument("ZZQ", ZZQ->(recno()), K_Incluir)	}, "Banco de Conhecimento"	})
aAdd(aButtons, {"ANALITICO", {|| VisSenhas(ZZQ->ZZQ_CODBEN)						}, "Senhas Int."			})

RegToMemory(cAlias, .F.)

// Define dialogo
DEFINE MSDIALOG oDlg TITLE cCadastro From aSizeAut[7], 00 To aSizeAut[6], aSizeAut[5] OF oMainWnd PIXEL

	oEnc := ZZQ->(MsMGet():New(cAlias,nReg,nOpc,,,,,{aPosObj[2,2]+25,aPosObj[2,2]-3,aPosObj[2,3],aPosObj[2,4]},,,,,,oDlg,,,.F.))

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bOK,.F.,aButtons)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MostraRee ºAutor  ³Jean Schulz         º Data ³  07/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Mostra tela da guia de reembolso                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MostraRee(cChave, oEnc)

Local aAreaB44		:= B44->(GetArea())
Local aOldRotina	:= aClone(aRotina)

aRotina	:= {{'Pesquisar',	'AxPesqui', 0, K_Pesquisar	},;
			{'Visualizar',	'PL001MOV', 0, K_Visualizar	},;
			{'Incluir',		'PL001MOV', 0, K_Incluir	},;
			{'Excluir',		'PL001MOV', 0, K_Excluir	}}

B44->(DbSetOrder(9))	// B44_FILIAL+B44_YCDPTC
if B44->(DbSeek(xFilial("B44") + cChave)) .and. !empty(cChave)

	// Salva as variaveis private
	aOldGets	:= aClone(oEnc:aGets)
	aOldTela	:= aClone(oEnc:aTela)
	aGets		:= {}
	aTela		:= {}

	PL001MOV("B44", B44->(Recno()), 2)

	// Recoloca as variaveis
	oEnc:aGets	:= aClone(aOldGets)
	oEnc:aTela	:= aClone(aOldTela)

else
	MsgInfo("Não localizado reembolso calculado para este protocolo!")
endif

aRotina := aClone(aOldRotina)

RestArea(aAreaB44)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ IncProtR   ³ Autor ³ Jean Schulz       ³ Data ³ 18.05.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Inclui registro de protocolo de reembolso.                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function IncProtR(cAlias,nReg,nOpc)

Local oDlg
Local nOpca		:= 0
Local oEnc
Local lRetorno
Local bOK		:= {|| nOpca := 1, lRetorno := iif(Obrigatorio(oEnc:aGets,oEnc:aTela), U_VldCadPro(), .F.), lRetorno := iif(lRetorno, Eval({|| oDlg:End()}), (nOpca:=3 , .F.))}
Local bCancel	:= {|| nOpca := 0, oDlg:End() }
Local aButtons	:= {}

Local cNumCRM	:= ""
Local cSigla	:= ""
Local cEst		:= ""
Local aBcoCn	:= {}
Local i			:= 0
Local cCodRDA	:= AllTrim(GETMV("MV_YRDAREE"))
Local cProOri	:= ""
Local aFields	:= FWSX3Util():GetAllFields( "B1N" )
Local aEvePro	:= {}
Local nTotPro	:= 0
Local nAjuEve	:= 0

Local aSizeAut	:= MsAdvSize()
Local aInfo 	:= {}
Local aPosObj 	:= {}

Private _cNumPA		:= ""
Private _cPtEnt		:= "000012"		// WEB
Private _cCanal		:= "000005"		// Fale Conosco
Private _cHst		:= "000015"
Private _cTpSv		:= "1019"		// Reembolso
Private _cNomUsr	:= ""
Private _cCodInt	:= ""
Private _cCodEmp	:= ""
Private _cMatric	:= ""
Private _cTipReg	:= ""
Private _cTipAt		:= '2'
Private _cEmail		:= ""
Private _cRDA		:= ""
Private _cPlano		:= ""
Private _cCpf		:= ""
Private _TpDm		:= ""
Private _nSla		:= 0
Private _cCdAre		:= ""
Private _cObs 		:= "Inclusão de Protocolo de Reembolso"
Private _cTpDm		:= "T"			// Tipo de Demanda - Solicitação
Private cMatBen		:= ""
Private _cMail		:= Space(TamSx3("BA1_EMAIL" )[1])
Private _cCodCli	:= ""
Private _cLojCli	:= ""
Private _aClient	:= {}

aObjects		:= {}
aAdd( aObjects, { 315,  30, .T., .T. } )
aAdd( aObjects, { 100,  70, .T., .T. } )

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects, .T. )

aAdd(aButtons, {"ANALITICO", {|| VisSenhas(M->ZZQ_CODBEN) }, "Senhas Int." })

RegToMemory(cAlias, .T.)

// Define dialogo
DEFINE MSDIALOG oDlg TITLE cCadastro From aSizeAut[7]+10, 00 To aSizeAut[6]+10, aSizeAut[5] OF oMainWnd PIXEL

	oEnc := ZZQ->(MsMGet():New(cAlias,nReg,nOpc,,,,,{aPosObj[2,2]+25,aPosObj[2,2],aPosObj[2,3],aPosObj[2,4]},,,,,,oDlg,,,.F.,,))

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,aButtons)

if nOpca == K_OK .And. lRetorno

	ZZQ->(PLUPTENC("ZZQ", K_Incluir))

	BA1->(DbSetOrder(2))
	BA1->(DbSeek(xFilial("BA1") + ZZQ->ZZQ_CODBEN ))

	// Criar novo protocolo de reembolso (padrão)
	RecLock("BOW",.T.)
		BOW->BOW_FILIAL	:= xFilial("ZZQ")
		BOW->BOW_YCDPTC	:= ZZQ->ZZQ_SEQUEN
		BOW->BOW_PROTOC	:= ZZQ->ZZQ_XNUMPA
		BOW->BOW_TIPPAC	:= GetNewPar("MV_PLSTPAA","1")
		BOW->BOW_STATUS	:= "1"
		BOW->BOW_USUARI	:= ZZQ->ZZQ_CODBEN
		BOW->BOW_NOMUSR	:= BA1->BA1_NOMUSR
		BOW->BOW_CODCLI	:= ZZQ->ZZQ_CODCLI
		BOW->BOW_LOJA	:= ZZQ->ZZQ_LOJCLI
		BOW->BOW_NOMCLI	:= Posicione("SA1", 1, xFilial("SA1") + ZZQ->(ZZQ_CODCLI+ZZQ_LOJCLI), "A1_NOME" )
		BOW->BOW_MATANT	:= BA1->BA1_MATANT
		BOW->BOW_TIPUSR	:= "01"							// 01=Eventual; 02=Repasse; 99=Usuario Local
		BOW->BOW_VIACAR	:= BA1->BA1_VIACAR
		BOW->BOW_CODEMP	:= BA1->BA1_CODEMP
		BOW->BOW_MATRIC	:= BA1->BA1_MATRIC
		BOW->BOW_TIPREG	:= BA1->BA1_TIPREG
		BOW->BOW_DIGITO	:= BA1->BA1_DIGITO
		BOW->BOW_MATUSA	:= "1"							// 1=Matricula Principal;2=Matricula Antiga
		BOW->BOW_XCDPLA	:= BA1->BA1_CODPLA
		BOW->BOW_PADINT	:= U_CabRetAc( BA1->(RECNO()) )
		BOW->BOW_DTDIGI	:= dDatabase
		BOW->BOW_OPERDA	:= PLSINTPAD()
		BOW->BOW_CODRDA	:= cCodRDA
		BOW->BOW_NOMRDA	:= Posicione("BAU", 1, xFilial("BAU") + cCodRDA, "BAU_NOME"  )
		BOW->BOW_TIPPRE	:= Posicione("BAU", 1, xFilial("BAU") + cCodRDA, "BAU_TIPPRE")
		BOW->BOW_NUMGUI	:= ""
		BOW->BOW_CONEMP	:= BA1->BA1_CONEMP
		BOW->BOW_VERCON	:= BA1->BA1_VERCON
		BOW->BOW_SUBCON	:= BA1->BA1_SUBCON
		BOW->BOW_VERSUB	:= BA1->BA1_VERSUB
		BOW->BOW_UFATE	:= BA1->BA1_ESTADO
		BOW->BOW_MUNATE	:= BA1->BA1_CODMUN
		BOW->BOW_DESMUN	:= BA1->BA1_MUNICI
		BOW->BOW_LOCATE	:= Posicione("BB8", 1, xFilial("BB8") + cCodRDA, "BB8_CODLOC+BB8_LOCAL")
		BOW->BOW_ENDLOC	:= Posicione("BB8", 1, xFilial("BB8") + cCodRDA, "BB8_END" )
		BOW->BOW_SENHA	:= PLSSenAut(Date())
		BOW->BOW_CODESP	:= Posicione("BAX", 1, xFilial("BAX") + cCodRDA + PLSINTPAD() + SUBS(BOW->BOW_LOCATE,1,3), "BAX_CODESP")
		BOW->BOW_DESESP	:= Posicione("BAQ", 1, xFilial("BAQ") + PLSINTPAD() + BOW->BOW_CODESP, "BAQ_DESCRI")

		// Rede não referencaida
		BOW->BOW_CODREF	:= ZZQ->ZZQ_CPFEXE
		BOW->BOW_NOMREF	:= ZZQ->ZZQ_NOMEXE

		// Prof. Solicitante (não preeenchido)
		/*
		BOW->BOW_OPESOL	:= ""		// Solicitante:  BB0_CODOPE
		BOW->BOW_ESTSOL	:= ""		// Solicitante:  BB0_ESTADO
		BOW->BOW_REGSOL	:= ""		// Solicitante:  BB0_NUMCR
		BOW->BOW_CONREG	:= ""		// Solicitante:  BB0_CODSIG
		BOW->BOW_NOMSOL	:= ""		// Solicitante:  BB0_NOME
		BOW->BOW_CDPFSO	:= ""		// Solicitante:  BB0_CODIGO
		*/

		// Prof. Executante
		cNumCRM	:= PadR(AllTrim(ZZQ->ZZQ_REGEXE), TamSx3("BB0_NUMCR" )[1])
		cSigla	:= PadR(AllTrim(ZZQ->ZZQ_SIGEXE), TamSx3("BB0_CODSIG")[1])
		cEst	:= PadR(AllTrim(ZZQ->ZZQ_ESTEXE), TamSx3("BB0_ESTADO")[1])

		BB0->(DbSetOrder(4))	// BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
		if BB0->(DbSeek(xFilial("BB0") + cEst + cNumCRM + cSigla )) .and. !empty(cEst) .and. !empty(cNumCRM) .and. !empty(cSigla)

			BOW->BOW_OPEEXE	:= BB0->BB0_CODOPE
			BOW->BOW_ESTEXE	:= BB0->BB0_ESTADO
			BOW->BOW_REGEXE	:= BB0->BB0_NUMCR
			BOW->BOW_SIGLA	:= BB0->BB0_CODSIG
			BOW->BOW_NOMEXE	:= BB0->BB0_NOME
			BOW->BOW_CDPFRE	:= BB0->BB0_CODIGO
		
		else

			BB0->(DbSetOrder(3))	// BB0_FILIAL+BB0_CGC
			if BB0->(DbSeek(xFilial("BB0") + ZZQ->ZZQ_CPFEXE )) .and. !empty(ZZQ->ZZQ_CPFEXE)

				BOW->BOW_OPEEXE	:= BB0->BB0_CODOPE
				BOW->BOW_ESTEXE	:= BB0->BB0_ESTADO
				BOW->BOW_REGEXE	:= BB0->BB0_NUMCR
				BOW->BOW_SIGLA	:= BB0->BB0_CODSIG
				BOW->BOW_NOMEXE	:= BB0->BB0_NOME
				BOW->BOW_CDPFRE	:= BB0->BB0_CODIGO

			endif

		endif

		BOW->BOW_XDTEVE	:= ZZQ->ZZQ_DTEVEN
		BOW->BOW_DATPAG	:= ZZQ->ZZQ_DATPRE
		BOW->BOW_XTPPAG	:= ZZQ->ZZQ_XTPRGT
		
		BOW->BOW_OPEMOV	:= PLSINTPAD()
		BOW->BOW_MESAUT	:= ""		// SubStr(DtoS(dDatabase),5,2)
		BOW->BOW_ANOAUT	:= ""		// SubStr(DtoS(dDatabase),1,4)
		BOW->BOW_OPEUSR	:= BA1->BA1_CODINT
		BOW->BOW_EMPMOV	:= cEmpAnt + cFilAnt
		BOW->BOW_CODLDP	:= ""
		BOW->BOW_CODPEG	:= ""
		BOW->BOW_NUMAUT	:= ""
		BOW->BOW_ORIMOV	:= ""
		BOW->BOW_GUIIMP	:= ""
		BOW->BOW_PREFIX	:= ""
		BOW->BOW_NUM	:= ""
		BOW->BOW_PARCEL	:= ""
		BOW->BOW_TIPO	:= ""
		BOW->BOW_CDOPER	:= retcodusr()
		BOW->BOW_NOMOPE	:= cUserName
		BOW->BOW_VLRAPR	:= ZZQ->ZZQ_VLRTOT
		BOW->BOW_XVLAPR	:= ZZQ->ZZQ_VLRTOT
		BOW->BOW_NROBCO	:= ZZQ->ZZQ_XBANCO
		BOW->BOW_DESBCO	:= cValtoChar(RestDBanco(ZZQ->ZZQ_XBANCO))
		BOW->BOW_NROAGE	:= AllTrim(ZZQ->ZZQ_XAGENC) + AllTrim(ZZQ->ZZQ_XDVAGE)
		BOW->BOW_NROCTA	:= AllTrim(ZZQ->ZZQ_XCONTA)
		BOW->BOW_XDGCON	:= AllTrim(ZZQ->ZZQ_XDGCON)
		BOW->BOW_NF		:= ""
		BOW->BOW_NPROCE	:= ""
		BOW->BOW_TIPINT	:= ""
		BOW->BOW_DESTIP	:= ""
		BOW->BOW_VLRREE	:= 0
		BOW->BOW_MOTIND	:= ""
		BOW->BOW_NUMEMP	:= ""
		BOW->BOW_FORNEC	:= ""
		BOW->BOW_TELCON	:= ZZQ->ZZQ_SMS
		BOW->BOW_USRRES	:= ""
		BOW->BOW_MOTPAD	:= ""
		BOW->BOW_PARCE	:= ""
		BOW->BOW_PGMTO	:= ""
		BOW->BOW_DTCANC	:= StoD("")
		BOW->BOW_TIPCAN	:= ""
		BOW->BOW_TITCAN	:= ""
		BOW->BOW_GRPINT	:= ""
		BOW->BOW_PRXCAN	:= ""
		BOW->BOW_PROCLO	:= ""
		BOW->BOW_PROORI	:= ""
		BOW->BOW_REGINT	:= ""
		BOW->BOW_PADCON	:= ""
		BOW->BOW_CODTAB	:= ""
		BOW->BOW_ORIGEM	:= "00"				// IIF(nModulo == 33,"02",IIF(nModulo == 13,"03","00"))
		BOW->BOW_OBS	:= ZZQ->ZZQ_OBSPRO
		BOW->BOW_XTPEVE	:= iif(ZZQ->ZZQ_TPSOL == '1' .and. ZZQ->ZZQ_TIPPRO == '9', '2', '1' )	// 1=TDE de HM/Evento;2=TDE de Porte Anestesico

	BOW->(MsUnLock())

	// Se tiver protocolo vinculado - já migrarei os eventos do protocolo inicial
	if !empty(ZZQ->ZZQ_PROORI)

		cProOri	:= Posicione("BOW", 8, xFilial("BOW") + ZZQ->ZZQ_PROORI, "BOW_PROTOC")

		B1N->(DbSetOrder(1))	// B1N_FILIAL+B1N_PROTOC+B1N_CODPAD+B1N_CODPRO
		if B1N->(DbSeek(xFilial("B1N") + cProOri )) .and. !empty(cProOri)

			while B1N->(!EOF()) .and. B1N->B1N_PROTOC == cProOri

				nTotPro	+= B1N->B1N_VLRREE

				B1N->(DbSkip())
			end

			B1N->(DbSeek(xFilial("B1N") + cProOri ))

			while B1N->(!EOF()) .and. B1N->B1N_PROTOC == cProOri

				// Jogar registro atual pra memória (usar ele em memória para ser copiado)
				RegToMemory("B1N",.F.,.F.)

				// Gravação Dinâmica
				B1N->(RecLock("B1N", .T. ))
				
					for i := 1 to len(aFields)
						if X3Uso(GetSx3Cache(aFields[i],"X3_USADO")) .and. GetSx3Cache(aFields[i],"X3_CONTEXT") <> "V"	// usado e não virtual
							&( "B1N->" + aFields[i] ) := &( "M->" + aFields[i] )
						endif
					next

					nAjuEve	+= round( M->B1N_VLRREE * ZZQ->ZZQ_VLRTOT / nTotPro, 2 )
					
					B1N->B1N_PROTOC := ZZQ->ZZQ_XNUMPA
					B1N->B1N_QTDPRO	:= 1						// fixando quantidade com 1 para evitar problema de casas decimais com um valor total
					B1N->B1N_VLRAPR	:= round( M->B1N_VLRREE * ZZQ->ZZQ_VLRTOT / nTotPro, 2 )
					B1N->B1N_VLRTOT	:= round( M->B1N_VLRREE * ZZQ->ZZQ_VLRTOT / nTotPro, 2 )
					B1N->B1N_VLRREE := 0
					B1N->B1N_ABATPF	:= "0"
				
				B1N->(MsUnLock())

				B1N->(DbSkip())
			end

			if nAjuEve <> ZZQ->ZZQ_VLRTOT	// problema de casas decimais nas contas - atribuir diferença no primeiro evento

				B1N->(DbSetOrder(1))	// B1N_FILIAL+B1N_PROTOC+B1N_CODPAD+B1N_CODPRO
				if B1N->(DbSeek(xFilial("B1N") + ZZQ->ZZQ_XNUMPA ))

					B1N->(RecLock("B1N", .F. ))
						B1N->B1N_VLRAPR += (ZZQ->ZZQ_VLRTOT - nAjuEve)
						B1N->B1N_VLRTOT	+= (ZZQ->ZZQ_VLRTOT - nAjuEve)
					B1N->(MsUnLock())

				endif

			endif

		endif

	endif

	if MsgYesNo("Deseja anexar documentos ao protocolo?")

		// Incluir banco de conhecimento na ZZQ
		MsDocument("ZZQ", ZZQ->(recno()), K_Incluir)

		// Replicar banco de conhecimento na BOW
		AC9->(DbSetOrder(2))	// AC9_FILIAL+AC9_ENTIDA+AC9_FILENT+AC9_CODENT+AC9_CODOBJ
		if AC9->(DbSeek(xFilial("AC9") + "ZZQ" + xFilial("ZZQ") + ZZQ->(ZZQ_FILIAL+ZZQ_SEQUEN+ZZQ_CODBEN) ))

			while AC9->(!EOF()) .and. AllTrim(AC9->(AC9_ENTIDA+AC9_FILENT+AC9_CODENT)) == AllTrim("ZZQ" + xFilial("ZZQ") + ZZQ->(ZZQ_FILIAL+ZZQ_SEQUEN+ZZQ_CODBEN))

				aAdd(aBcoCn, AC9->AC9_CODOBJ)

				AC9->(DbSkip())
			end

			for i := 1 to len(aBcoCn)

				AC9->(Reclock("AC9",.T.))
					AC9->AC9_FILIAL	:= xFilial("AC9")
					AC9->AC9_FILENT	:= xFilial("BOW")
					AC9->AC9_ENTIDA	:= "BOW"
					AC9->AC9_CODENT	:= xFilial("BOW") + ZZQ->ZZQ_XNUMPA
					AC9->AC9_CODOBJ	:= aBcoCn[i]
					AC9->AC9_XUSU	:= cUserName
					AC9->AC9_XDTINC	:= date()
					AC9->AC9_HRINC	:= StrTran(Time(),":","")
				AC9->(MsUnlock())

			next

		endif

	endif

	if MsgYesNo("Deseja imprimir o protocolo?")
		U_ImpRelPr()
	endif

	// Realiza a inclusão de Protocolo de Atendimento
	_cCanal		:= ZZQ->ZZQ_CANAL
	_cPtEnt		:= ZZQ->ZZQ_XWEB
	
	CriaPA(ZZQ->ZZQ_XNUMPA)			// Cria Protocolo de Atendimento

	cSql := " UPDATE " + RetSqlName("SZY") + " SET D_E_L_E_T_ = '*' WHERE ZY_SEQBA = '" + ZZQ->ZZQ_XNUMPA + "' AND ZY_SEQSERV = ' '"
	TcSqlExec(cSql)

else

	cSql := " UPDATE " + RetSqlName("SZX") + " SET D_E_L_E_T_ = '*' WHERE ZX_SEQ   = '" + M->ZZQ_XNUMPA + "'"
	TcSqlExec(cSql)

	cSql := " UPDATE " + RetSqlName("SZY") + " SET D_E_L_E_T_ = '*' WHERE ZY_SEQBA = '" + M->ZZQ_XNUMPA + "'"
	TcSqlExec(cSql)

endif

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CanProtR   ³ Autor ³ Jean Schulz       ³ Data ³ 18.05.2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Cancela registro de protocolo de reembolso.                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CanProtR(nTp)

Local aArea		:= (GetArea())
Local aAreaB44	:= B44->(GetArea())
Local aAreaBOW	:= BOW->(GetArea())
Local aAreaZZQ	:= ZZQ->(GetArea())
Local lOk		:= .F.
Local oDlgIt
Local lCancela 	:= .F.
Local bAction	:= {|| lCancela := .T., oDlgIt:End() }
Local cAlias	:= GetNextAlias()
Local cObs		:= ""
Local cSomaSrv	:= ""

Local _cHst		:= SuperGetMv("MV_XHISTRE",.F.,'000072')
Local _cTpSv	:= SuperGetMv("MV_XTPSVRE",.F.,'1056')

Local oReg1
Local cReg1		:= ZZQ->ZZQ_OBSCAN

Private cMotCan	:= Space(3)
//Private cMsg01	:= Space(50)
//Private cMsg02	:= Space(50)

if nTp == 1			// Cad. Prot. Reemb. (ZZQ)

	BOW->(DbSetOrder(8))	// BOW_FILIAL+BOW_YCDPTC
	if BOW->(DbSeek(xFilial("BOW") + ZZQ->ZZQ_SEQUEN ))
		lOk	:= .T.
	endif

elseif nTp == 2		// Prot. Reemb. (BOW)

	ZZQ->(DbSetOrder(1))	// ZZQ_FILIAL+ZZQ_SEQUEN+ZZQ_CODBEN
	if ZZQ->(DbSeek(xFilial("ZZQ") + BOW->BOW_YCDPTC ))
		lOk	:= .T.
	endif

endif

if lOk

	if ZZQ->ZZQ_STATUS <> "2"

		B44->(DbSetOrder(9))	// B44_FILIAL+B44_YCDPTC
		if !B44->(MsSeek(xFilial("B44") + ZZQ->ZZQ_SEQUEN))

			DEFINE MSDIALOG oDlgIt TITLE "Cancelar Protocolo" FROM 000,000 TO 022,100 OF GetWndDefault()

				@ 033,025 Say "Mot. Canc:"			Size 036,008	COLOR CLR_BLACK PIXEL OF oDlgIt
				@ 033,055 Get cMotCan		Picture "@!"	Valid (ExistCpo("SX5","ZQ"+Alltrim(cMotCan)))	F3 "ZQ"

				@ 047,025 Say "Obs:"				Size 036,008	COLOR CLR_BLACK PIXEL OF oDlgIt
				@ 047,055 Get oReg1		Var cReg1	Size 275, 100 OF oDlgIt MULTILINE HSCROLL Pixel 
				oReg1:bRClicked		:= {|| AllwaysTrue()}
				oReg1:oFont			:= TFont():New("Courier New",0,16)
			
			ACTIVATE MSDIALOG oDlgIt CENTERED ON INIT EnchoiceBar(oDlgIt,bAction,{||oDlgIt:End()},.F.,{})
			
			if lCancela

				if Empty(cMotCan)
					MsgAlert("Obrigatório informar o motivo do cancelamento!")
				elseif Empty(cReg1)
					MsgAlert("Obrigatório informar uma observação sobre o cancelamento!")
				else

					if MsgYesNo("Confirma o cancelamento do protocolo de reembolso?")

						Begin Transaction

							ZZQ->(Reclock("ZZQ", .F.))
								ZZQ->ZZQ_STATUS	:= "2"
								ZZQ->ZZQ_MOTCAN	:= cMotCan
								ZZQ->ZZQ_OBSCAN	:= cReg1
								//ZZQ->ZZQ_CANOB1	:= cMsg01
								//ZZQ->ZZQ_CANOB2	:= cMsg02
								ZZQ->ZZQ_YUSRCA	:= cUserName
								ZZQ->ZZQ_DTCAN	:= dDataBase
								ZZQ->ZZQ_HRCAN	:= StrTran(Time(),':','')
							ZZQ->(MsUnlock())

							cObs	:= AllTrim(BOW->BOW_OBS)
							cObs	+= chr(10)+chr(13) + chr(10)+chr(13)
							cObs	+= "-----------------------------------------------------------------"										+ chr(10)+chr(13)
							cObs	+= "-- PROTOCOLO CANCELADO --"																				+ chr(10)+chr(13)
							cObs	+= " * Motivo: "		+ cMotCan + " - " + Posicione("SX5",1,xFilial("SX5")+"ZQ"+cMotCan, "X5_DESCRI" )	+ chr(10)+chr(13)
							cObs	+= " * Observação: "	+ AllTrim(cReg1)																	+ chr(10)+chr(13)
							//cObs	+= " * Observação: "	+ AllTrim(cMsg01) + iif(!empty(cMsg02), " - " + AllTrim(cMsg02), "")				+ chr(10)+chr(13)
							cObs	+= " * Usuário: "		+ cUserName																			+ chr(10)+chr(13)
							cObs	+= " * Data: "			+ DtoC(dDataBase)																	+ chr(10)+chr(13)
							cObs	+= " * Hora: "			+ Time()																			+ chr(10)+chr(13)
							cObs	+= "-----------------------------------------------------------------"
							
							BOW->(Reclock("BOW", .F.))
								BOW->BOW_STATUS	:= "8"		// Glosado
								BOW->BOW_DTCANC	:= dDataBase
								BOW->BOW_OBS	:= cObs
							BOW->(MsUnlock())

							// GRAVAÇÃO SZY
							BeginSQL Alias cAlias
							
								SELECT MAX(ZY_SEQSERV) MAXSERV
								FROM %TABLE:SZY%
								WHERE ZY_SEQBA = %EXP:ZZQ->ZZQ_XNUMPA%
							
							EndSql

							if (cAlias)->(!EOF())
								cSomaSrv := soma1((cAlias)->MAXSERV)
							endif
							(cAlias)->(dbclosearea())

							SZX->(DbSetOrder(1))
							if SZX->(DbSeek(xFilial("SZX") + ZZQ->ZZQ_XNUMPA))

								RecLock("SZY",.T.)
									SZY->ZY_FILIAL	:= xFilial("SZY")
									SZY->ZY_DTSERV	:= dDataBase
									SZY->ZY_HORASV	:= StrTran(Time(),":","")
									SZY->ZY_TIPOSV	:= _cTpSv
									SZY->ZY_HISTPAD	:= _cHst
									SZY->ZY_USDIGIT	:= usrretname(retcodusr())
									SZY->ZY_SEQBA	:= ZZQ->ZZQ_XNUMPA
									SZY->ZY_SEQSERV	:= cSomaSrv
									SZY->ZY_OBS		:= "Cancelamento de Protocolo de Reembolso"
								SZY->(MsUnLock())
							
							endif
						
						End Transaction
						
					endif
				
				endif
			
			endif
		
		else
			MsgAlert("Protocolo já vinculado a um reembolso. Cancelamento não permitido!")
		endif

	else
		MsgInfo("Protocolo já cancelado!")
	endif

else
	MsgInfo("Protocolo de reembolso sem vinculo entre o cadastro do protocolo e o protocolo em si!")
endif

RestArea(aAreaB44)
RestArea(aAreaBOW)
RestArea(aAreaZZQ)
RestArea(aArea)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ LEGPROTR   ³ Autor ³ Jean Schulz         ³ Data ³ 18.05.07 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Exibe a legenda...                                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LegProtr

Local aLegenda := {}

aAdd(aLegenda, { 'BR_VERDE'		, 'Ativo'		})
aAdd(aLegenda, { 'BR_VERMELHO'	, 'Cancelado'	})
aAdd(aLegenda, { 'BR_AZUL'		, 'Vinculado'	})
aAdd(aLegenda, { 'BR_AMARELO'	, 'Em Análise'	})
aAdd(aLegenda, { 'BR_CINZA'		, 'Web'			})

BrwLegenda(cCadastro, "Status", aLegenda)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldCadPro ºAutor  ³ Jean Schulz        º Data ³  07/04/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Valida os dados antes de gravar.                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VldCadPro

Local lRet		:= .T.
Local _cMsg		:= ""

if lRet .and. M->ZZQ_XTPRGT == "1" .and. (Empty(M->ZZQ_XAGENC) .or. Empty(M->ZZQ_XBANCO) .or. Empty(M->ZZQ_XCONTA) .or. Empty(M->ZZQ_CPFTIT))
	MsgAlert("Informe os dados bancários corretamente!")
	lRet	:= .F.
endif

if lRet .and. M->ZZQ_XTPRGT == "2" .and. Empty(M->ZZQ_CPFTIT)
	MsgAlert("Para opção cheque é necessário preencher o CPF/CGC!")
	lRet	:= .F.
endif

// Validação para a nova parametrização de dias de pagamento no produto ou no subcontrato
if Empty(M->ZZQ_DATPRE)

	_cMsg := "Favor verificar a parametrização de previsão de pagamento no nivel do subcontrato ou do produto saúde."
	_cMsg += " Favor contactar o setor de cadastro."
	Aviso("Atenção", _cMsg, {"OK"})

	lRet	:= .F.

endif

return lRet



/*
Valida o campo SMS
*/
User Function ValSMS(cSMS)

Local lRet		:= .T.
Local _cDDD		:= GetNewPar("MV_XDDD","11,12,13,14,15,16,17,18,19,21,22,24,27,28,31,32,33,34,35,37,38,41,42,43,44,45,46,47,48,49,51,53,54,55,61,62,63,64,65,66,67,68,69,71,73,74,75,77,79,81,82,83,84,85,86,87,88,89,91,92,93,94,95,96,97,98,99")

if !Empty(cSMS)

	lRet	:= Type(Trim(Replace(cSMS,',','x'))) == "N"
	if lRet
		lRet	:= (Substr(Trim(cSMS),1,2) $ AllTrim(_cDDD))
		if lRet
			lRet := (Length(Trim(cSMS)) == 11)
			if lRet
				lRet	:= Substr(Trim(cSMS),3,1) $ "7,8,9"
			endif
		endif
	endif

endif

if !lRet
	Alert("SMS invalido!")
endif

return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CabVdSMS  º Autor ³ Angelo Henrique    º Data ³  02/02/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina utilizada para validar o campo ZZQ_SMS, tem por     º±±
±±º          ³ obejtivo a validação do DDD e dos caracteres digitados no  º±±
±±º          ³ campo.                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CabVdSMS()

Local _aArZZ0	:= ZZQ->(GetArea())
Local _cMsg		:= ""
Local _lRet		:= .T.
Local _cDDD		:= GetNewPar("MV_XDDD","11,12,13,14,15,16,17,18,19,21,22,24,27,28,31,32,33,34,35,37,38,41,42,43,44,45,46,47,48,49,51,53,54,55,61,62,63,64,65,66,67,68,69,71,73,74,75,77,79,81,82,83,84,85,86,87,88,89,91,92,93,94,95,96,97,98,99")
Local _ni		:= 1

// Valida se o DDD é valido
if !(SUBSTR(M->ZZQ_SMS,1,2) $ _cDDD)
	_cMsg := "DDD informado: " + SUBSTR(M->ZZQ_SMS,1,2) + ", incorreto. Favor digitar o DDD correto."
endif

// Validação para saber se somente números foram digitados no campo, por ser campo caracter acaba permitindo
if Empty(_cMsg)

	for _ni := 1 to Len(ALLTRIM(M->ZZQ_SMS))
		if !(SUBSTR(ALLTRIM(M->ZZQ_SMS),_ni,1) $ "0|1|2|3|4|5|6|7|8|9")
			_cMsg := "Favor corrigir o campo SMS, preencher somente numeros."
			Exit
		endif
	next _ni

endif

if !Empty(_cMsg)
	Aviso("Atenção", _cMsg, {"OK"})
	_lRet := .F.
endif

RestArea(_aArZZ0)

return _lRet



/*/{Protheus.doc} ImpRel
//Descrição: Relatório de Protocolo de atendimento Reembolso.
@author Mateus Medeiros
@since 29/09/2017
/*/
User Function ImpRelPr()

Local _aArZQ		:= ZZQ->(GetArea())
Local nJ			:= 0
Local cOpcao		:= "Relatório de Reembolso"

Private cUpd		:= ""
Private cParams		:= cEmpAnt + ";" + ZZQ->ZZQ_SEQUEN
Private cParImpr	:= "1;0;1;Protocolo de Reembolso"

if ZZQ->ZZQ_DATDIG >= ctod('01/02/2018')

	ProcRegua(0)

	for nJ := 0 to 5
		IncProc('Comunicação com Crystal Reports - ' + cOpcao)
	next

	CallCrys("PROT_AT_REEMBOLSO",cParams,cParImpr)

else
	Aviso("Atenção", OemToAnsi("Impressão disponível somente para protocolos a partir de 01/02/2018"), {"OK"})
endif

RestArea(_aArZQ)

return



// Gerar Protocolo de Atendimento
Static Function CriaPA(_cSeq,cTipo)

Private _xTpEnv := cTipo

/*
	1- Exclusão referente aux funeral ficará:
		Tipo de serviço:	1005 (exclusão do plano)
		Histórico padrão:	000036 (falecimento)
		Porta de entrada:	(todas)
		Canal:				(todos)
		Demanda:			T (SOLICITAÇÃO)
	
	2- Reembolso
		Tipo de serviço:	1019 (reembolso)
		Histórico padrão:	000015 (entrada de pedido)
		Porta de entrada:	(todas)
		Canal:				(todos)
		Demanda:			T (SOLICITAÇÃO)
*/

// Tipo de Demanda:	Solicitação (T)
// Canal:				Ura mater/Afinidade (00004), Ag Bangu(000010)
// Agencia:				Copacabana(000009), Ag Tijuca(000008), Ag Centro(000011)
// Porta de Entrada:	Email(00002), correio(000005), presencial(000007), telefone(000006)
// Tipo de Serviço:		Auxilio Funeral (1013)
// Histórico Padrão:	Entrada de pedido (15)

if ZZQ->ZZQ_TIPPRO == "04" .and. empty(cTipo)
	_cTpSv	:= "1013"
	_cHst	:= "000015 (entrada de pedido)"
endif

BA1->(DbSetOrder(2))
if BA1->(DbSeek(xFilial("BA1") + ZZQ->ZZQ_CODBEN))

	_cNomUsr	:= BA1->BA1_NOMUSR
	_cCodInt	:= BA1->BA1_CODINT
	_cCodEmp	:= BA1->BA1_CODEMP
	_cMatric	:= BA1->BA1_MATRIC
	_cTipReg	:= BA1->BA1_TIPREG
	_cDigito	:= BA1->BA1_DIGITO
	_dDtNasc	:= BA1->BA1_DATNAS
	_cEmail		:= IIF(!Empty(ZZQ->ZZQ_EMAIL),ZZQ->ZZQ_EMAIL,BA1->BA1_EMAIL)
	_cTel		:= BA1->BA1_TELEFO
	_cMatTit	:= BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
	cMatBen		:= BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
	_cPlano		:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
	_cCPF		:= BA1->BA1_CPFUSR

endif

// Pegando a quantidade de SLA
PCG->(DbSetOrder(1))
if PCG->(DbSeek(xFilial("PCG") + PADR(AllTrim(_cTpDm),TAMSX3("PCG_CDDEMA")[1]) + PADR(AllTrim(_cPtEnt),TAMSX3("PCG_CDPORT")[1]) + PADR(AllTrim(_cCanal),TAMSX3("PCG_CDCANA")[1]) + PADR(AllTrim(_cTpSv),TAMSX3("PCG_CDSERV")[1]) ))
	_nSla := PCG->PCG_QTDSLA
else
	_nSla := 0
endif

//Ponterar na Tabela de PBL (Tipo de Serviço)
PBL->(DbSetOrder(1))
if PBL->(DbSeek(xFilial("PBL") + PADR(AllTrim(_cTpSv),TAMSX3("PBL_YCDSRV")[1])))
	_cCdAre := PBL->PBL_AREA
endif

SZX->(DbSetOrder(1))
if SZX->(DbSeek(xFilial("SZX") + _cSeq))

	RecLock("SZX",.F.)
		SZX->ZX_FILIAL	:= xFilial("SZX")
		SZX->ZX_SEQ		:= _cSeq
		SZX->ZX_DATDE	:= dDataBase
		SZX->ZX_HORADE	:= StrTran(Time(),":","")
		SZX->ZX_DATATE	:= dDataBase
		SZX->ZX_HORATE	:= StrTran(Time(),":","")
		SZX->ZX_NOMUSR	:= _cNomUsr
		SZX->ZX_CODINT	:= _cCodInt
		SZX->ZX_CODEMP	:= _cCodEmp
		SZX->ZX_MATRIC	:= _cMatric
		SZX->ZX_TIPREG	:= _cTipReg
		SZX->ZX_DIGITO	:= _cDigito
		SZX->ZX_TPINTEL	:= _cTipAt
		SZX->ZX_YDTNASC	:= _dDtNasc
		SZX->ZX_EMAIL	:= _cEmail
		SZX->ZX_RDA		:= _cRDA
		SZX->ZX_CONTATO	:= _cTel
		SZX->ZX_YPLANO	:= _cPlano
		SZX->ZX_TPDEM	:= _cTpDm
		SZX->ZX_CANAL	:= iif(!Empty(ZZQ->ZZQ_CANAL), ZZQ->ZZQ_CANAL, _cCanal)
		SZX->ZX_SLA		:= _nSLA
		SZX->ZX_PTENT	:= iif(!Empty(ZZQ->ZZQ_XWEB),  ZZQ->ZZQ_XWEB,  _cPtEnt)
		SZX->ZX_CODAREA	:= _cCdAre
		SZX->ZX_VATEND	:= "3"
		SZX->ZX_TPATEND	:= "1"
		SZX->ZX_YDTINC	:= dDataBase
		SZX->ZX_USDIGIT	:= AllTrim(UsrRetName(RetCodUsr()))
		SZX->ZX_CPFUSR	:= _cCPF
		SZX->ZX_PESQUIS	:= "4"			// Não avaliado
	SZX->(MsUnLock())

	DbSelectArea("SZY")

	RecLock("SZY", .T.)
		SZY->ZY_FILIAL	:= xFilial("SZY")
		SZY->ZY_SEQBA	:= _cSeq
		SZY->ZY_SEQSERV	:= "000001"
		SZY->ZY_DTSERV	:= dDataBase
		SZY->ZY_HORASV	:= StrTran(Time(),":","")
		SZY->ZY_TIPOSV	:= _cTpSv
		SZY->ZY_OBS		:= _cObs
		SZY->ZY_HISTPAD	:= _cHst
		SZY->ZY_USDIGIT	:= AllTrim(UsrRetName(RetCodUsr()))
		SZY->ZY_PESQUIS	:= "4"			// Não avaliado
	SZY->(MsUnLock())

	cSql := " UPDATE " + RetSqlName("SZY") + " SET D_E_L_E_T_ = '*' WHERE ZY_SEQBA = '" + _cSeq + "' AND ZY_SEQSERV = ' '"
	TcSqlExec(cSql)

	/*
		Tipo de serviço:	1005 (exclusão do plano)
		Histórico padrão:	000036 (falecimento)
		Porta de entrada:	(todas)
		Canal:				(todos)
		Demanda:			T (SOLICITAÇÃO)
	*/

	GeraEmail(_cSeq)		// Envia E-mail do reembolso

	if ZZQ->ZZQ_TIPPRO == "04"  .and. empty(cTipo)

		_cTpSv	:= "1005"
		_cHst	:= "000036"
		_cSeq	:= U_GerNumPA()	// Gera número do PA
		CriaPA(_cSeq, "AUX")
	
	endif

endif

return


// Envia e-mail com protocolo
Static Function GeraEmail(_cSeq)

Local _aArea		:= GetArea()
Local _aArSZX		:= SZX->(GetArea())
Local _aArBA1		:= BA1->(GetArea())
Local _aArBI3		:= BI3->(GetArea())
Local a_Msg			:= {}
Local a_Htm			:= ""
Local c_To			:= ""
Local c_CC			:= " "
Local c_Assunto		:= "Protocolo de Atendimento - CABERJ"
Local _cDscPln		:= ""
Local _cMat			:= ""
Local _cTpSrv		:= ""
Local _cHora		:= ""
Local _cMail		:= ''
Local _nCntZy		:= 0
Local _cTpSv		:= ""
Local _cHst			:= ""
Local _cDigt		:= ""

SetPrvt("oDlg1","oGrp1","oSay1","oGet1","oBtn1","oBtn2")

SZX->(DbSetOrder(1))
if SZX->(DbSeek(xFilial("SZX") + _cSeq))

	_cMail	:= SZX->ZX_EMAIL + SPACE(200)
	c_To	:= _cMail
	_cMat	:= SZX->ZX_CODINT + "." + SZX->ZX_CODEMP + "." + SZX->ZX_MATRIC + "-" + SZX->ZX_TIPREG + "." + SZX->ZX_DIGITO

	if cEmpAnt == "01"

		if SZX->ZX_CODEMP $ "0024|0025|0027|0028"
			a_Htm := "\HTML\PAPREF.HTML"
		else
			a_Htm := "\HTML\PAGERAL.HTML"
		endif
	
	else
		a_Htm := "\HTML\PAINTEGRAL.HTML"
	endif

	// Caso o protocolo seja para um beneficiário registrado irá pegar informações pertinentes ao plano, caso contrário não irá preenche-lo
	BA1->(DbSetOrder(2))
	if BA1->(DbSeek(xFilial("SZX") + SZX->ZX_CODINT + SZX->ZX_CODEMP + SZX->ZX_MATRIC + SZX->ZX_TIPREG + SZX->ZX_DIGITO))

		BI3->(DbSetOrder(1))	// BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
		if BI3->(DbSeek(xFilial("BI3") + BA1->BA1_CODINT + BA1->BA1_CODPLA))
			_cDscPln := AllTrim(BI3->BI3_DESCRI)
		else
			_cDscPln := ""
		endif
	
	else
		_cDscPln := ""
	endif

	// Pegando o primeiro registro do tipo de serviço para poder encaminhar no e-mail
	SZY->(DbSetOrder(1))
	if SZY->(DbSeek(xFilial("SZY") + SZX->ZX_SEQ))

		PBL->(DbSetOrder(1))
		if PBL->(DBSeek(xFilial("PBL") + SZY->ZY_TIPOSV))
			_cTpSrv := PBL->PBL_YDSSRV
		endif
	
	endif

	_cHora	:= SUBSTR(SZX->ZX_HORADE,1,2) + ":" + SUBSTR(SZX->ZX_HORADE,3,2)

	aAdd(a_Msg, { "_cBenef"		, SZX->ZX_NOMUSR		}) // Nome do Beneficiário
	aAdd(a_Msg, { "_cPlan"		, _cDscPln 				}) // Descrição do Plano do Beneficiário
	aAdd(a_Msg, { "_cMat"		, _cMat 				}) // Matricula do Beneficiário
	aAdd(a_Msg, { "_cSeq"		, SZX->ZX_SEQ 			}) // Número do Protocolo
	aAdd(a_Msg, { "_cTpServ"	, _cTpSrv				}) // Descrição do Tipo de Serviço
	aAdd(a_Msg, { "_cDtDe"		, DTOC(SZX->ZX_DATDE)	}) // Data de Abertura do Protocolo
	aAdd(a_Msg, { "_cHora"		, _cHora				}) // Hora de Abertura do Protocolo

	// Função para envio de e-mail
	if Env_1(a_Htm, c_To, c_CC, c_Assunto, a_Msg )

		if Empty(_xTpEnv)
			Aviso("Atenção", "Protocolo enviado com sucesso!",{"OK"})
		endif

		if MsgYesNo("Deseja atualizar o e-mail no protocolo de atendimento?","Atenção")
		
			RecLock("SZX",.F.)
				SZX->ZX_EMAIL	:= c_To
			SZX->(MsUnLock())
		
		endif

		// Gravando mais uma linha na SZY de histórico do envio de e-mail
		SZY->(DbSetOrder(1))
		if SZY->(DbSeek(xFilial("SZY") + SZX->ZX_SEQ))

			_nCntZy := 1

			while SZY->(!EOF()) .and. SZX->ZX_SEQ == SZY->ZY_SEQBA

				_nCntZy ++

				_cTpSv	:= SZY->ZY_TIPOSV
				_cHst	:= SZY->ZY_HISTPAD
				_cDigt	:= SZY->ZY_USDIGIT

				SZY->(DbSkip())
			end

			RecLock("SZY", .T.)
				SZY->ZY_SEQBA	:= SZX->ZX_SEQ
				SZY->ZY_SEQSERV	:= STRZERO(_nCntZy,TAMSX3("ZY_SEQSERV")[1])
				SZY->ZY_DTSERV	:= dDatabase
				SZY->ZY_HORASV	:= SUBSTR(TIME(),1,2) + SUBSTR(TIME(),4,2)
				SZY->ZY_TIPOSV	:= _cTpSv
				SZY->ZY_OBS		:= "E-mail enviado para: " + c_To
				SZY->ZY_HISTPAD	:= 	_cHst
				SZY->ZY_USDIGIT	:= _cDigt
			SZY->(MsUnLock())
		
		endif
	
	else
		Aviso("Atenção", "Protocolo não enviado, favor verificar se o e-mail esta correto!",{"OK"})
	endif

else

	if Empty(SZX->ZX_EMAIL)
		Aviso("Atenção","Este protocolo não possui um e-mail cadastrado para ser enviado.",{"OK"})
	endif

endif

RestArea(_aArBI3)
RestArea(_aArBA1)
RestArea(_aArSZX)
RestArea(_aArea)

return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Env_1     ºAutor  ³Angelo Henrique     º Data ³  30/03/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função generica responsavel pelo envio de e-mails.         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Env_1(c_ArqTxt, c_To, c_CC, c_Assunto, a_Msg )

Local n_It			:= 0
Local _cError		:= ""
Local l_Result		:= .F.								// resultado de uma conexão ou envio
Local nHdl			:= fOpen(c_ArqTxt,68)
Local c_Body		:= space(99999)

Private _cServer	:= Trim(GetMV("MV_RELSERV"))
Private _cUser		:= GetNewPar("MV_XMAILPA", "protocolodeatendimento@caberj.com.br")
Private _cPass		:= GetNewPar("MV_XPSWPA" , "Caberj2017@!")
Private _cFrom		:= "CABERJ PROTHEUS"
Private cMsg		:= ""

if !(nHdl == -1)

	nBtLidos		:= fRead(nHdl,@c_Body,99999)
	fClose(nHdl)

	for n_It := 1 to Len( a_Msg )
		c_Body	:= StrTran(c_Body, a_Msg[n_It][1] , a_Msg[n_It][2])
	next

	// Tira quebras de linha para nao dar problema no WebMail da Caberj
	c_Body	:= StrTran(c_Body,CHR(13)+CHR(10), "")

	// Contecta o servidor de e-mail
	CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result

	if !l_Result

		GET MAIL ERROR _cError

		DISCONNECT SMTP SERVER RESULT lOk
	
	else

		SEND MAIL FROM _cUser TO c_To SUBJECT c_Assunto BODY c_Body  RESULT l_Result

		if !l_Result

			GET MAIL ERROR _cError
		
		endif
	
	endIf

endif

return l_Result



Static Function RestDBanco(cCodBco)

Local cDescBanco	:= ""
Local aBancos		:= {{'100','Planner Corretora de Valores S.A.                                               '},;
						{'101','Renascença Distribuidora de Títulos e Valores Mobiliários Ltda.                 '},;
						{'102','XP Investimentos Corretora de Câmbio Títulos e Valores Mobiliários S.A.         '},;
						{'104','Caixa Econômica Federal                                                         '},;
						{'105','Lecca Crédito; Financiamento e Investimento S/A                                 '},;
						{'107','Banco BBM S.A.                                                                  '},;
						{'108','PortoCred S.A. Crédito; Financiamento e Investimento                            '},;
						{'111','Oliveira Trust Distribuidora de Títulos e Valores Mobiliários S.A.              '},;
						{'113','Magliano S.A. Corretora de Cambio e Valores Mobiliarios                         '},;
						{'114','Central das Cooperativas de Economia e Crédito Mútuo do Estado do Espírito Santo'},;
						{'117','Advanced Corretora de Câmbio Ltda.                                              '},;
						{'118','Standard Chartered Bank (Brasil) S.A. Banco de Investimento                     '},;
						{'119','Banco Western Union do Brasil S.A.                                              '},;
						{'120','Banco Rodobens SA                                                               '},;
						{'121','Banco Agiplan S.A.                                                              '},;
						{'122','Banco Bradesco BERJ S.A.                                                        '},;
						{'124','Banco Woori Bank do Brasil S.A.                                                 '},;
						{'125','Brasil Plural S.A. Banco Múltiplo                                               '},;
						{'126','BR Partners Banco de Investimento S.A.                                          '},;
						{'127','Codepe Corretora de Valores e Câmbio S.A.                                       '},;
						{'128','MS Bank S.A. Banco de Câmbio                                                    '},;
						{'129','UBS Brasil Banco de Investimento S.A.                                           '},;
						{'130','Caruana S.A. Sociedade de Crédito; Financiamento e Investimento                 '},;
						{'131','Tullett Prebon Brasil Corretora de Valores e Câmbio Ltda.                       '},;
						{'132','ICBC do Brasil Banco Múltiplo S.A.                                              '},;
						{'133','Confederação Nacional Coop. Centrais Créd. Econ. Familiar Solidária – CONFESOL  '},;
						{'134','BGC Liquidez Distribuidora de Títulos e Valores Mobiliários Ltda.               '},;
						{'135','Gradual Corretora de Câmbio; Títulos e Valores Mobiliários S.A.                 '},;
						{'136','Confederação Nacional das Cooperativas Centrais Unicred Ltda – Unicred do Brasil'},;
						{'137','Multimoney Corretora de Câmbio Ltda                                             '},;
						{'138','Get Money Corretora de Câmbio S.A.                                              '},;
						{'139','Intesa Sanpaolo Brasil S.A. - Banco Múltiplo                                    '},;
						{'140','Easynvest - Título Corretora de Valores SA                                      '},;
						{'142','Broker Brasil Corretora de Câmbio Ltda.                                         '},;
						{'143','Treviso Corretora de Câmbio S.A.                                                '},;
						{'144','Bexs Banco de Câmbio S.A.                                                       '},;
						{'145','Levycam - Corretora de Câmbio e Valores Ltda.                                   '},;
						{'146','Guitta Corretora de Câmbio Ltda.                                                '},;
						{'147','Rico Corretora de Títulos e Valores Mobiliários S.A.                            '},;
						{'149','Facta Financeira S.A. - Crédito Financiamento e Investimento                    '},;
						{'157','ICAP do Brasil Corretora de Títulos e Valores Mobiliários Ltda.                 '},;
						{'163','Commerzbank Brasil S.A. - Banco Múltiplo                                        '},;
						{'167','S. Hayata Corretora de Câmbio S.A.                                              '},;
						{'169','Banco Olé Bonsucesso Consignado S.A.                                            '},;
						{'173','BRL Trust Distribuidora de Títulos e Valores Mobiliários S.A.                   '},;
						{'177','Guide Investimentos S.A. Corretora de Valores                                   '},;
						{'180','CM Capital Markets Corretora de Câmbio; Títulos e Valores Mobiliários Ltda.     '},;
						{'182','Dacasa Financeira S/A - Sociedade de Crédito; Financiamento e Investimento      '},;
						{'183','Socred S.A. - Sociedade de Crédito ao Microempreendedor                         '},;
						{'184','Banco Itaú BBA S.A.                                                             '},;
						{'188','Ativa Investimentos S.A. Corretora de Títulos Câmbio e Valores                  '},;
						{'189','HS Financeira S/A Crédito; Financiamento e Investimentos                        '},;
						{'191','Nova Futura Corretora de Títulos e Valores Mobiliários Ltda.                    '},;
						{'204','Banco Bradesco Cartões S.A.                                                     '},;
						{'208','Banco BTG Pactual S.A.                                                          '},;
						{'212','Banco Original S.A.                                                             '},;
						{'213','Banco Arbi S.A.                                                                 '},;
						{'217','Banco John Deere S.A.                                                           '},;
						{'218','Banco Bonsucesso S.A.                                                           '},;
						{'222','Banco Credit Agrícole Brasil S.A.                                               '},;
						{'224','Banco Fibra S.A.                                                                '},;
						{'233','Banco Cifra S.A.                                                                '},;
						{'237','Banco Bradesco S.A.                                                             '},;
						{'241','Banco Clássico S.A.                                                             '},;
						{'243','Banco Máxima S.A.                                                               '},;
						{'246','Banco ABC Brasil S.A.                                                           '},;
						{'248','Banco Boavista Interatlântico S.A.                                              '},;
						{'249','Banco Investcred Unibanco S.A.                                                  '},;
						{'250','BCV - Banco de Crédito e Varejo S/A                                             '},;
						{'253','Bexs Corretora de Câmbio S/A                                                    '},;
						{'254','Parana Banco S. A.                                                              '},;
						{'263','Banco Cacique S. A.                                                             '},;
						{'265','Banco Fator S.A.                                                                '},;
						{'266','Banco Cédula S.A.                                                               '},;
						{'300','Banco de la Nacion Argentina                                                    '},;
						{'318','Banco BMG S.A.                                                                  '},;
						{'320','China Construction Bank (Brasil) Banco Múltiplo S/A                             '},;
						{'341','Itaú Unibanco  S.A.                                                             '},;
						{'366','Banco Société Générale Brasil S.A.                                              '},;
						{'370','Banco Mizuho do Brasil S.A.                                                     '},;
						{'376','Banco J. P. Morgan S. A.                                                        '},;
						{'389','Banco Mercantil do Brasil S.A.                                                  '},;
						{'394','Banco Bradesco Financiamentos S.A.                                              '},;
						{'399','Kirton Bank S.A. - Banco Múltiplo                                               '},;
						{'412','Banco Capital S. A.                                                             '},;
						{'422','Banco Safra S.A.                                                                '},;
						{'456','Banco de Tokyo-Mitsubishi UFJ Brasil S.A.                                       '},;
						{'464','Banco Sumitomo Mitsui Brasileiro S.A.                                           '},;
						{'473','Banco Caixa Geral - Brasil S.A.                                                 '},;
						{'477','Citibank N.A.                                                                   '},;
						{'479','Banco ItauBank S.A.                                                             '},;
						{'487','Deutsche Bank S.A. - Banco Alemão                                               '},;
						{'488','JPMorgan Chase Bank; National Association                                       '},;
						{'492','ING Bank N.V.                                                                   '},;
						{'494','Banco de La Republica Oriental del Uruguay                                      '},;
						{'495','Banco de La Provincia de Buenos Aires                                           '},;
						{'505','Banco Credit Suisse (Brasil) S.A.                                               '},;
						{'545','Senso Corretora de Câmbio e Valores Mobiliários S.A.                            '},;
						{'600','Banco Luso Brasileiro S.A.                                                      '},;
						{'604','Banco Industrial do Brasil S.A.                                                 '},;
						{'610','Banco VR S.A.                                                                   '},;
						{'611','Banco Paulista S.A.                                                             '},;
						{'612','Banco Guanabara S.A.                                                            '},;
						{'613','Banco Pecúnia S. A.                                                             '},;
						{'623','Banco Pan S.A.                                                                  '},;
						{'626','Banco Ficsa S. A.                                                               '},;
						{'630','Banco Intercap S.A.                                                             '},;
						{'633','Banco Rendimento S.A.                                                           '},;
						{'634','Banco Triângulo S.A.                                                            '},;
						{'637','Banco Sofisa S. A.                                                              '},;
						{'641','Banco Alvorada S.A.                                                             '},;
						{'643','Banco Pine S.A.                                                                 '},;
						{'652','Itaú Unibanco Holding S.A.                                                      '},;
						{'653','Banco Indusval S. A.                                                            '},;
						{'654','Banco A. J. Renner S.A.                                                         '},;
						{'655','Banco Votorantim S.A.                                                           '},;
						{'707','Banco Daycoval S.A.                                                             '},;
						{'712','Banco Ourinvest S.A.                                                            '},;
						{'719','Banif - Bco Internacional do Funchal (Brasil) S.A.                              '},;
						{'735','Banco Neon S.A.                                                                 '},;
						{'739','Banco Cetelem S.A.                                                              '},;
						{'741','Banco Ribeirão Preto S.A.                                                       '},;
						{'743','Banco Semear S.A.                                                               '},;
						{'745','Banco Citibank S.A.                                                             '},;
						{'746','Banco Modal S.A.                                                                '},;
						{'747','Banco Rabobank International Brasil S.A.                                        '},;
						{'748','Banco Cooperativo Sicredi S. A.                                                 '},;
						{'751','Scotiabank Brasil S.A. Banco Múltiplo                                           '},;
						{'752','Banco BNP Paribas Brasil S.A.                                                   '},;
						{'753','Novo Banco Continental S.A. - Banco Múltiplo                                    '},;
						{'754','Banco Sistema S.A.                                                              '},;
						{'755','Bank of America Merrill Lynch Banco Múltiplo S.A.                               '},;
						{'756','Banco Cooperativo do Brasil S/A - Bancoob                                       '},;
						{'757','Banco Keb Hana do Brasil S. A.                                                  '},;
						{'001','Banco do Brasil S.A.                                                            '},;
						{'003','Banco da Amazônia S.A.                                                          '},;
						{'004','Banco do Nordeste do Brasil S.A.                                                '},;
						{'007','Banco Nacional de Desenvolvimento Econômico e Social BNDES                      '},;
						{'010','Credicoamo Crédito Rural Cooperativa                                            '},;
						{'011','Credit Suisse Hedging-Griffo Corretora de Valores S.A.                          '},;
						{'012','Banco Inbursa de Investimentos S.A.                                             '},;
						{'014','Natixis Brasil S.A. Banco Múltiplo                                              '},;
						{'015','UBS Brasil Corretora de Câmbio; Títulos e Valores Mobiliários S.A.              '},;
						{'016','Coop de Créd. Mútuo dos Despachantes de Trânsito de SC e Rio Grande do Sul      '},;
						{'017','BNY Mellon Banco S.A.                                                           '},;
						{'018','Banco Tricury S.A.                                                              '},;
						{'021','Banestes S.A. Banco do Estado do Espírito Santo                                 '},;
						{'024','Banco Bandepe S.A.                                                              '},;
						{'025','Banco Alfa S.A.                                                                 '},;
						{'029','Banco Itaú Consignado S.A.                                                      '},;
						{'033','Banco Santander (Brasil) S. A.                                                  '},;
						{'036','Banco Bradesco BBI S.A.                                                         '},;
						{'037','Banco do Estado do Pará S.A.                                                    '},;
						{'040','Banco Cargill S.A.                                                              '},;
						{'041','Banco do Estado do Rio Grande do Sul S.A.                                       '},;
						{'047','Banco do Estado de Sergipe S.A.                                                 '},;
						{'060','Confidence Corretora de Câmbio S.A.                                             '},;
						{'062','Hipercard Banco Múltiplo S.A.                                                   '},;
						{'063','Banco Bradescard S.A.                                                           '},;
						{'064','Goldman Sachs do Brasil  Banco Múltiplo S. A.                                   '},;
						{'065','Banco AndBank (Brasil) S.A.                                                     '},;
						{'066','Banco Morgan Stanley S. A.                                                      '},;
						{'069','Banco Crefisa S.A.                                                              '},;
						{'070','Banco de Brasília S.A.                                                          '},;
						{'074','Banco J. Safra S.A.                                                             '},;
						{'075','Banco ABN Amro S.A.                                                             '},;
						{'076','Banco KDB do Brasil S.A.                                                        '},;
						{'077','Banco Inter S.A.                                                                '},;
						{'078','Haitong Banco de Investimento do Brasil S.A.                                    '},;
						{'079','Banco Original do Agronegócio S.A.                                              '},;
						{'080','BT Corretora de Câmbio Ltda.                                                    '},;
						{'081','BBN Banco Brasileiro de Negocios S.A.                                           '},;
						{'082','Banco Topazio S.A.                                                              '},;
						{'083','Banco da China Brasil S.A.                                                      '},;
						{'084','Uniprime Norte do Paraná - Coop. de Econ e Crédito Mútuo dos Medicos;...        '},;
						{'085','Cooperativa Central de Crédito Urbano - Cecred                                  '},;
						{'089','Cooperativa de Crédito Rural da Região da Mogiana                               '},;
						{'090','Cooperativa Central de Economia e Crédito Mútuo - Sicoob Unimais                '},;
						{'091','Central de Cooperativas de Economia e Crédito Mútuo do Est RS - Unicred         '},;
						{'092','Brickell S.A. Crédito; Financiamento e Investimento                             '},;
						{'093','Pólocred Sociedade de Crédito ao Microempreendedor e à Empresa de Pequeno Porte '},;
						{'094','Banco Finaxis S.A.                                                              '},;
						{'095','Banco Confidence de Câmbio S.A.                                                 '},;
						{'097','Cooperativa Central de Crédito Noroeste Brasileiro Ltda - CentralCredi          '},;
						{'098','Credialiança Cooperativa de Crédito Rural                                       '},;
						{'099','Uniprime Central – Central Interestadual de Cooperativas de Crédito Ltda.       '}}

nPos := ascan(aBancos,{|x| x[1] == alltrim(cCodBco) })
if nPos > 0
	cDescBanco	:= aBancos[nPos][2]
else
	cDescBanco	:= ""
endif

Return cDescBanco



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CabRetAc º Autor ³ Fred. O. C. Jr.    º Data ³  18/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³   Retornar acomodação									  º±±
±±º          ³															  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CabRetAc(nRecBA1)

Local aAreaBA1	:= BA1->(GetArea())
Local aAreaBA3	:= BA3->(GetArea())
Local cRet		:= ""

BA1->(DbGoTo(nRecBA1))

BA3->(DbSetOrder(1))	// BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
if BA3->(DbSeek(xFilial("BA3") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC) ))

	if BA3->BA3_TIPOUS == "1"
		
		BI3->(DbSetOrder(1))	// BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
		if BI3->(MsSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO) ) )
			cRet := BI3->BI3_CODACO
		endif
	
	else

		BT6->(DbSetOrder(1))	// BT6_FILIAL+BT6_CODINT+BT6_CODIGO+BT6_NUMCON+BT6_VERCON+BT6_SUBCON+BT6_VERSUB+BT6_CODPRO+BT6_VERSAO
		if BT6->(MsSeek(xFilial("BT6")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO) ) )
			cRet := BT6->BT6_CODACO
		endIf
	
	endif

endif

RestArea(aAreaBA1)
RestArea(aAreaBA3)

return cRet



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VlRNRCGC º Autor ³ Fred. O. C. Jr.    º Data ³  18/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³   Validar rede não referenciada - ter CGC				  º±±
±±º          ³															  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VlRNRCGC( cCod )

Local lRet		:= .F.

if empty(cCod)
	lRet	:= .T.
else
	
	BK6->(DbSetOrder(3))	// BK6_FILIAL+BK6_CODIGO
	if BK6->(DbSeek( xFilial("BK6") + cCod ))

		if empty(BK6->BK6_CGC)
			Alert("A rede não referenciada a ser utilizada no reembolso precisa ter o CPF/CNPJ preenchido no cadastro.")
		else
			lRet	:= .T.
		endif

	else
		Alert("Rede não referenciada não localizada na sistema.")
	endif

endif

return lRet



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VlTbReem º Autor ³ Fred. O. C. Jr.    º Data ³  18/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³   Validar TDE se esta habilitada para reembolso			  º±±
±±º          ³															  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VlTbReem( cCod )

Local lRet		:= .F.

if empty(cCod)
	lRet	:= .T.
else
	
	BF8->(DbSetOrder(3))	// BF8_FILIAL+BF8_CODIGO
	if BF8->(DbSeek( xFilial("BF8") + cCod ))

		if BF8->BF8_XREEMB <> '1'
			Alert("A TDE informada não está habilitada para ser usada no reembolso.")
		else
			lRet	:= .T.
		endif

	else
		Alert("TDE não localizada na sistema.")
	endif

endif

return lRet



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VlPrtVnc º Autor ³ Fred. O. C. Jr.    º Data ³  18/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³   Trazer dados do protocolo original pro complemento		  º±±
±±º          ³															  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VlPrtVnc( cCod )

Local lRet		:= .T.
Local aAreaZZQ	:= ZZQ->(GetArea())
Local nRecZZQ	:= ZZQ->(RECNO())

if !empty(cCod)

	ZZQ->(DbSetOrder(1))	// ZZQ_FILIAL+ZZQ_SEQUEN
	if ZZQ->(DbSeek( xFilial("ZZQ") + cCod ))

		if ZZQ->ZZQ_CODBEN == M->ZZQ_CODBEN

			if ZZQ->ZZQ_STATUS == '3'
			
				M->ZZQ_CODCLI	:= ZZQ->ZZQ_CODCLI
				M->ZZQ_LOJCLI	:= ZZQ->ZZQ_LOJCLI
				M->ZZQ_NOMCLI	:= Posicione("SA1", 1, xFilial("SA1") + ZZQ->(ZZQ_CODCLI + ZZQ_LOJCLI), "A1_NOME")
				M->ZZQ_XCPFCL	:= Posicione("SA1", 1, xFilial("SA1") + ZZQ->(ZZQ_CODCLI + ZZQ_LOJCLI), "A1_CGC" )
				M->ZZQ_DTEVEN	:= ZZQ->ZZQ_DTEVEN
				M->ZZQ_TPSOL	:= ZZQ->ZZQ_TPSOL
				M->ZZQ_TIPPRO	:= ZZQ->ZZQ_TIPPRO
				M->ZZQ_TIPDES	:= ZZQ->ZZQ_TIPDES
				M->ZZQ_XTPRGT	:= ZZQ->ZZQ_XTPRGT
				M->ZZQ_DBANCA	:= ZZQ->ZZQ_DBANCA
				M->ZZQ_XBANCO	:= ZZQ->ZZQ_XBANCO
				M->ZZQ_XAGENC	:= ZZQ->ZZQ_XAGENC
				M->ZZQ_XDVAGE	:= ZZQ->ZZQ_XDVAGE
				M->ZZQ_XCONTA	:= ZZQ->ZZQ_XCONTA
				M->ZZQ_XDGCON	:= ZZQ->ZZQ_XDGCON
				M->ZZQ_EXECUT	:= ZZQ->ZZQ_EXECUT
				M->ZZQ_CPFEXE	:= ZZQ->ZZQ_CPFEXE
				M->ZZQ_SIGEXE	:= ZZQ->ZZQ_SIGEXE
				M->ZZQ_ESTEXE	:= ZZQ->ZZQ_ESTEXE
				M->ZZQ_REGEXE	:= ZZQ->ZZQ_REGEXE
				M->ZZQ_NOMEXE	:= ZZQ->ZZQ_NOMEXE
				M->ZZQ_SMS		:= ZZQ->ZZQ_SMS
				M->ZZQ_EMAIL	:= ZZQ->ZZQ_EMAIL

			else
				MsgInfo("Protocolo " + iif(ZZQ->ZZQ_STATUS == '1', "ainda não calculado!", "cancelado!") )
				lRet		:= .F.
			endif

		else
			MsgInfo("Protocolo não pertence ao beneficiário deste reembolso!")
			lRet		:= .F.
		endif

	else
		MsgInfo("Protocolo não localizado no sistema!")
		lRet		:= .F.
	endif
	
endif

ZZQ->(DbGoTo(nRecZZQ))

RestArea(aAreaZZQ)

return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABAPRBE  ºAutor  ³ Frederico O. C. Jr º Data ³  22/08/22  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Pesquisa de protocolos pro beneficiário			      º±±
±±º          ³                                                            º±± 
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABAPRBE()

Local cTitulo			:= "Pesquisa de Protocolos"
Local oDlgPes			:= nil
Local oTipoPes			:= nil
Local cTipoPes			:= ""
Local aTipoPes			:= {"1-Cod. Reembolso",	"2-Num. Protocolo"}
Local oChkChk			:= nil
Local lChkChk			:= .F.
Local oGetChave			:= nil
Local cChave			:= Space(50)
Local cValid			:= "{|| Eval(bRefresh) }"
Local bRefresh			:= { || PsqPrBnf(AllTrim(cChave),Subs(cTipoPes,1,1),lChkChk,aBrowPes,aVetPad1,oBrowPes) }
Local oBrowPes			:= nil
Local aVetPad1			:= { {"","",StoD(""),"",StoD(""),""} }
Local aCampos			:= {"Cod. Reembolso", "Protocolo", "Data Digit.", "Desc. Reembolso", "Data Evento", "Valor"}
Local aBrowPes			:= aClone(aVetPad1)
Local nLin				:= 1
Local nOpca				:= 0
Local bOK				:= { || nLin := oBrowPes:nAt, nOpca := 1, oDlgPes:End() }
Local bCanc				:= { ||                       nOpca := 3, oDlgPes:End() }

DEFINE MSDIALOG oDlgPes TITLE cTitulo FROM 008.2,000 TO 026,ndColFin OF GetWndDefault()

	@ 033,008 COMBOBOX oTipoPes		Var cTipoPes	ITEMS aTipoPes							SIZE 090,010 OF oDlgPes PIXEL COLOR CLR_HBLUE
	@ 033,319 CHECKBOX oChkChk		Var lChkChk		PROMPT "Pesquisar Palavra Chave"		SIZE 080,010 OF oDlgPes PIXEL

	oGetChave := TGet():New(033,103,{ | U | IF( PCOUNT() == 0, cChave, cChave := U ) },oDlgPes,210,008,"@!S50",&cValid,nil,nil,nil,nil,nil,.T.,nil,.F.,nil,.F.,nil,nil,.F.,nil,nil,cChave)

	// Monta Browse
	oBrowPes := TcBrowse():New( 050, 008, 378, 075,,,, oDlgPes,,,,,,,,,,,, .F.,, .T.,, .F., )

	oBrowPes:AddColumn(TcColumn():New(aCampos[1]		,nil,nil,nil,nil,nil,060,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[1]:BDATA		:= { || aBrowPes[oBrowPes:nAt,1] }

	oBrowPes:AddColumn(TcColumn():New(aCampos[2]		,nil,nil,nil,nil,nil,080,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[2]:BDATA		:= { || aBrowPes[oBrowPes:nAt,2] }

	oBrowPes:AddColumn(TcColumn():New(aCampos[3]		,nil,nil,nil,nil,nil,045,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[3]:BDATA		:= { || aBrowPes[oBrowPes:nAt,3] }
	
	oBrowPes:AddColumn(TcColumn():New(aCampos[4]		,nil,nil,nil,nil,nil,080,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[4]:BDATA	:= { || aBrowPes[oBrowPes:nAt,4] }
	
	oBrowPes:AddColumn(TcColumn():New(aCampos[5]		,nil,nil,nil,nil,nil,045,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[5]:BDATA	:= { || aBrowPes[oBrowPes:nAt,5] }

	oBrowPes:AddColumn(TcColumn():New(aCampos[6]		,nil,nil,nil,nil,nil,060,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[6]:BDATA	:= { || aBrowPes[oBrowPes:nAt,6] }

	oBrowPes:SetArray(aBrowPes)
	oBrowPes:BLDBLCLICK := bOK
	Eval(bRefresh)

ACTIVATE MSDIALOG oDlgPes ON INIT Eval({ || EnChoiceBar(oDlgPes,bOK,bCanc,.F.) })

if nOpca == K_OK

	M->ZZQ_PROORI := aBrowPes[nLin,1]

endif

return (nOpca == K_OK)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Buscar dados dos protocolos do beneficiário...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function PsqPrBnf(cChave, cFiltro, lChkChk, aBrowPes, aVetPad1, oBrowPes)

Local cQuery		:= ""
Local cAliasFil

aBrowPes 	:= {}		// Limpa resultado

cQuery := " select ZZQ_SEQUEN, ZZQ_XNUMPA, ZZQ_DATDIG, PCR_DESCRI, ZZQ_DTEVEN, ZZQ_VLRTOT"
cQuery += " from " + RetSqlName("ZZQ") + " ZZQ"
cQuery +=	" left join " + RetSqlName("PCR") + " PCR"
cQuery +=	  " on (    PCR.D_E_L_E_T_ = ' '"
cQuery +=		  " and PCR_FILIAL = ZZQ_FILIAL"
cQuery +=		  " and PCR_TIPOSO = ZZQ_TPSOL"
cQuery +=		  " and PCR_CODIGO = ZZQ_TIPPRO)"
cQuery += " where ZZQ.D_E_L_E_T_ = ' '"
cQuery +=	" and ZZQ_FILIAL = '" + xFilial("ZZQ") + "'"
cQuery +=	" and ZZQ_STATUS = '3'"
cQuery +=	" and ZZQ_CODBEN = '" +  M->ZZQ_CODBEN + "'"

if !empty(cChave)

	if cFiltro == '1'			// Cod. Reembolso
		cQuery += " and ZZQ_SEQUEN like '%" + cChave + "%'"
	elseif cFiltro == '2'		// Prot. Reembolso
		cQuery += " and ZZQ_XNUMPA like '%" + cChave + "%'"
	endif

endif

cQuery	+= " order by ZZQ_SEQUEN desc"

cAliasFil := MpSysOpenQuery(cQuery)

DbSelectArea( cAliasFil )
while !(cAliasFil)->(Eof())

	aAdd(aBrowPes, {AllTrim((cAliasFil)->ZZQ_SEQUEN)							,;
					AllTrim((cAliasFil)->ZZQ_XNUMPA)							,;
					StoD( (cAliasFil)->ZZQ_DATDIG )								,;
					Upper(AllTrim((cAliasFil)->PCR_DESCRI))						,;
					StoD( (cAliasFil)->ZZQ_DTEVEN )								,;
					Transform((cAliasFil)->ZZQ_VLRTOT, "@E 999,999,999.99")		})

	(cAliasFil)->(DbSkip())
end
dbselectarea(cAliasFil)
(cAliasFil)->(dbclosearea())

// Testa resultado da pesquisa...
if Len(aBrowPes) == 0
	aBrowPes := aClone(aVetPad1)
endif

// Atualiza browse...
oBrowPes:nAt := 1
oBrowPes:SetArray(aBrowPes)
oBrowPes:Refresh()
oBrowPes:SetFocus()

return .T.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABLIBSN  ºAutor  ³ Frederico O. C. Jr º Data ³  24/08/22  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Pesquisa de senhas liberadas						      º±±
±±º          ³                                                            º±± 
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABLIBSN()

Local cTitulo			:= "Pesquisa Senhas Liberadas"
Local oDlgPes			:= nil
Local oTipoPes			:= nil
Local cTipoPes			:= ""
Local aTipoPes			:= {"1-Cod. RDA", "2-Nome RDA" }
Local oChkChk			:= nil
Local lChkChk			:= .F.
Local oGetChave			:= nil
Local cChave			:= Space(50)
Local cValid			:= "{|| Eval(bRefresh) }"
Local bRefresh			:= { || PsqSnBnf(AllTrim(cChave),Subs(cTipoPes,1,1),lChkChk,aBrowPes,aVetPad1,oBrowPes) }
Local oBrowPes			:= nil
Local aVetPad1			:= { {"","",StoD(""),"","","","",""} }
Local aCampos			:= {"Senha","Tipo Guia","Num. Guia","Data Autor.","Cod. RDA","Nome RDA","Prev. Anest."}
Local aBrowPes			:= aClone(aVetPad1)
Local nLin				:= 1
Local nOpca				:= 0
Local bOK				:= { || nLin := oBrowPes:nAt, nOpca := 1, oDlgPes:End() }
Local bCanc				:= { ||                       nOpca := 3, oDlgPes:End() }
Local aButtons			:= { {"RELATORIO", { || ShowGuia(aBrowPes[oBrowPes:nAt,2], aBrowPes[oBrowPes:nAt,8]) }, "Mostrar Guia"} }
Local _oBkpFld			:= oFolder

DEFINE MSDIALOG oDlgPes TITLE cTitulo FROM 008.2,000 TO 026,ndColFin OF GetWndDefault()

	@ 033,008 COMBOBOX oTipoPes		Var cTipoPes	ITEMS aTipoPes							SIZE 090,010 OF oDlgPes PIXEL COLOR CLR_HBLUE
	@ 033,319 CHECKBOX oChkChk		Var lChkChk		PROMPT "Pesquisar Palavra Chave"		SIZE 080,010 OF oDlgPes PIXEL

	oGetChave := TGet():New(033,103,{ | U | IF( PCOUNT() == 0, cChave, cChave := U ) },oDlgPes,210,008,"@!S50",&cValid,nil,nil,nil,nil,nil,.T.,nil,.F.,nil,.F.,nil,nil,.F.,nil,nil,cChave)

	// Monta Browse
	oBrowPes := TcBrowse():New( 050, 008, 378, 075,,,, oDlgPes,,,,,,,,,,,, .F.,, .T.,, .F., )

	oBrowPes:AddColumn(TcColumn():New(aCampos[1]		,nil,nil,nil,nil,nil,060,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[1]:BDATA		:= { || aBrowPes[oBrowPes:nAt,1] }

	oBrowPes:AddColumn(TcColumn():New(aCampos[2]		,nil,nil,nil,nil,nil,040,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[2]:BDATA		:= { || aBrowPes[oBrowPes:nAt,2] }

	oBrowPes:AddColumn(TcColumn():New(aCampos[3]		,nil,nil,nil,nil,nil,080,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[3]:BDATA		:= { || aBrowPes[oBrowPes:nAt,3] }
	
	oBrowPes:AddColumn(TcColumn():New(aCampos[4]		,nil,nil,nil,nil,nil,045,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[4]:BDATA		:= { || aBrowPes[oBrowPes:nAt,4] }
	
	oBrowPes:AddColumn(TcColumn():New(aCampos[5]		,nil,nil,nil,nil,nil,040,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[5]:BDATA		:= { || aBrowPes[oBrowPes:nAt,5] }

	oBrowPes:AddColumn(TcColumn():New(aCampos[6]		,nil,nil,nil,nil,nil,080,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[6]:BDATA		:= { || aBrowPes[oBrowPes:nAt,6] }

	oBrowPes:AddColumn(TcColumn():New(aCampos[7]		,nil,nil,nil,nil,nil,040,.F.,.F.,nil,nil,nil,.F.,nil))
	oBrowPes:ACOLUMNS[7]:BDATA		:= { || aBrowPes[oBrowPes:nAt,7] }

	oBrowPes:SetArray(aBrowPes)
	oBrowPes:BLDBLCLICK := bOK
	Eval(bRefresh)

ACTIVATE MSDIALOG oDlgPes ON INIT Eval({ || EnChoiceBar(oDlgPes,bOK,bCanc,.F.,aButtons) })

if nOpca == K_OK

	M->BOW_XSENHA := aBrowPes[nLin,1]

endif

oFolder		:= _oBkpFld

return (nOpca == K_OK)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Buscar dados das senhas do beneficiário...    		                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function PsqSnBnf(cChave, cFiltro, lChkChk, aBrowPes, aVetPad1, oBrowPes)

Local cQuery		:= ""
Local cAliasFil

aBrowPes 	:= {}		// Limpa resultado

cQuery := " select BEA_SENHA as SENHA,"
cQuery +=		 " DECODE(BEA_TIPGUI,'01','CONSULTA','02','SADT') as TIP_GUIA,"
cQuery +=		 " BEA_OPEMOV||'.'||BEA_ANOAUT||'.'||BEA_MESAUT||'.'||BEA_NUMAUT as NUM_GUIA,"
cQuery +=		 " BEA_DATPRO as DATPRO,"
cQuery +=		 " BEA_CODRDA as CODRDA,"
cQuery +=		 " BEA_NOMRDA as NOMRDA,"
cQuery +=		 " 0 as PRV_ANEST,"
cQuery +=		 " BEA.R_E_C_N_O_ GUIREC"
cQuery += " from " + RetSqlName("BEA") + " BEA"
cQuery += " where BEA.D_E_L_E_T_ = ' '"
cQuery +=	" and BEA_FILIAL = '" + xFilial("BEA") + "'"
cQuery +=	" and BEA_OPEUSR = '" + SubStr(M->BOW_USUARI, 1, 4) + "'"
cQuery +=	" and BEA_CODEMP = '" + SubStr(M->BOW_USUARI, 5, 4) + "'"
cQuery +=	" and BEA_MATRIC = '" + SubStr(M->BOW_USUARI, 9, 6) + "'"
cQuery +=	" and BEA_TIPREG = '" + SubStr(M->BOW_USUARI,15, 2) + "'"
cQuery +=	" and BEA_TIPGUI in ('01','02')"
cQuery +=	" and BEA_SENHA <> ' '"

if !empty(cChave)

	if cFiltro == '1'			// Cod. Reembolso
		cQuery += " and BEA_CODRDA like '%" + cChave + "%'"
	elseif cFiltro == '2'		// Prot. Reembolso
		cQuery += " and BEA_NOMRDA like '%" + cChave + "%'"
	endif

endif

cQuery += " union all"

cQuery += " select BE4_SENHA as SENHA,"
cQuery +=		 " 'INTERNACAO' as TIP_GUIA,"
cQuery +=		 " BE4_CODOPE||'.'||BE4_ANOINT||'.'||BE4_MESINT||'.'||BE4_NUMINT as NUM_GUIA,"
cQuery +=		 " BE4_DATPRO as DATPRO,"
cQuery +=		 " BE4_CODRDA as CODRDA,"
cQuery +=		 " BE4_NOMRDA as NOMRDA,"
cQuery +=		 " BE4_YMEDAN as PRV_ANEST,"
cQuery +=		 " BE4.R_E_C_N_O_ GUIREC"
cQuery += " from " + RetSqlName("BE4") + " BE4"
cQuery += " where BE4.D_E_L_E_T_ = ' '"
cQuery +=	" and BE4_FILIAL = '" + xFilial("BEA") + "'"
cQuery +=	" and BE4_OPEUSR = '" + SubStr(M->BOW_USUARI, 1, 4) + "'"
cQuery +=	" and BE4_CODEMP = '" + SubStr(M->BOW_USUARI, 5, 4) + "'"
cQuery +=	" and BE4_MATRIC = '" + SubStr(M->BOW_USUARI, 9, 6) + "'"
cQuery +=	" and BE4_TIPREG = '" + SubStr(M->BOW_USUARI,15, 2) + "'"
cQuery +=	" and BE4_TIPGUI = '03'"
cQuery +=	" and BE4_SENHA <> ' '"

if !empty(cChave)

	if cFiltro == '1'			// Cod. Reembolso
		cQuery += " and BE4_CODRDA like '%" + cChave + "%'"
	elseif cFiltro == '2'		// Prot. Reembolso
		cQuery += " and BE4_NOMRDA like '%" + cChave + "%'"
	endif

endif

cQuery += " order by DATPRO"

cAliasFil := MpSysOpenQuery(cQuery)

DbSelectArea( cAliasFil )
while !(cAliasFil)->(Eof())

	//{"Senha","Tipo Guia","Num. Guia","Data Autor.","Cod. RDA","Nome RDA","Prev. Anest."}
	aAdd(aBrowPes, {AllTrim((cAliasFil)->SENHA)									,;
					AllTrim((cAliasFil)->TIP_GUIA)								,;
					AllTrim((cAliasFil)->NUM_GUIA)								,;
					StoD( (cAliasFil)->DATPRO )									,;
					AllTrim((cAliasFil)->CODRDA)								,;
					AllTrim((cAliasFil)->NOMRDA)								,;
					Transform((cAliasFil)->PRV_ANEST, "@E 999,999,999.99")		,;
					(cAliasFil)->GUIREC											})

	(cAliasFil)->(DbSkip())
end
dbselectarea(cAliasFil)
(cAliasFil)->(dbclosearea())

// Testa resultado da pesquisa...
if Len(aBrowPes) == 0
	aBrowPes := aClone(aVetPad1)
endif

// Atualiza browse...
oBrowPes:nAt := 1
oBrowPes:SetArray(aBrowPes)
oBrowPes:Refresh()
oBrowPes:SetFocus()

return .T.





Static Function ShowGuia(cTipo, nRecGuia)

Local aArea	 		:= GetArea()

Local aDimen		:= MsAdvSize()
Local aObjects		:= {}
Local aInfo			:= {}
Local aPosObj		:= {}
Local aPos1			:= {}

Local cAlias1		:= ""
Local cAlias2		:= ""
Local oDlg1
Local bOK1			:= {|| oDlg1:End() }
Local oSay1
Local cSenha1		:= ""
Local cGuia1		:= ""
Local aHeader2		:= {}
Local aColsTr2		:= {}
Local aTrab1		:= {}
Local oBrw1

DEFINE FONT oFontAutor NAME "Arial" SIZE 000,-016 BOLD

AAdd( aObjects, { 100, 020, .T., .F., .F. } )
AAdd( aObjects, { 100, 100, .T., .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T., .T. } )

aInfo	:= { aDimen[1], aDimen[2], aDimen[3], aDimen[4], 5, 5 }
aPosObj	:= MsObjSize( aInfo, aObjects, .T. )

aPos1 := {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]}

if Alltrim(cTipo) == Alltrim("INTERNACAO")

	BE4->(DbSetOrder(2))
	BE4->(DbGoTo( nRecGuia ) )

	cAlias1		:= "BE4"
	cAlias2		:= "BEJ"
	cGuia1		:= BE4->(BE4_CODOPE+"."+BE4_ANOINT+"."+BE4_MESINT+"."+BE4_NUMINT)
	cSenha1		:= BE4->BE4_SENHA

	Store Header "BEJ" TO aHeader2 For .T.

	BEJ->( DbSetOrder(1) )
	If !BEJ->( DbSeek( xFilial("BEJ") + BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT) ) )
		Store COLS Blank "BEJ" TO aColsTr2 FROM aHeader2
	Else
		Store COLS "BEJ" TO aColsTr2 FROM aHeader2 VETTRAB aTrab1 While xFilial("BE4")+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT) == BEJ->(BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT)
	EndIf

elseif Alltrim(cTipo) == Alltrim("CONSULTA") .or. Alltrim(cTipo) == Alltrim("SADT")

	BEA->(DbSetOrder(1))
	BEA->(DbGoTo( nRecGuia ))

	cAlias1		:= "BEA"
	cAlias2		:= "BE2"
	cGuia1		:= BEA->(BEA_OPEMOV+"."+BEA_ANOAUT+"."+BEA_MESAUT+"."+BEA_NUMAUT)
	cSenha1		:= BEA->BEA_SENHA

	Store Header "BE2" TO aHeader2 For .T.

	BE2->( DbSetOrder(1) )
	If !BE2->( DbSeek( xFilial("BE2") + BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) ) )
		Store COLS Blank "BE2" TO aColsTr2 FROM aHeader2
	Else
		Store COLS "BE2" TO aColsTr2 FROM aHeader2 VETTRAB aTrab1 While xFilial("BEA")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) == BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)
	EndIf

endif

DEFINE MSDIALOG oDlg1 TITLE "Apresentação de Senha de Autorização" FROM aDimen[7],000 TO aDimen[6],aDimen[5] OF oMainWnd pixel

	//aPos1[1], aPos1[2] GROUP oGrupo1 TO aPos1[3], aPos1[4] PIXEL OF oDlg1 LABEL "Informações" COLOR CLR_HBLUE, CLR_HRED
	@ aPos1[1]+7,aPos1[2]+5  Say oSay1 PROMPT If ( cAlias1 == "BE4", "Internação Número: ", "Autorização Número: " )	SIZE 220,010 OF oDlg1 PIXEL FONT oFontAutor
	@ aPos1[1]+7,aPos1[2]+90 Say oSay1 PROMPT cGuia1																	SIZE 220,010 OF oDlg1 PIXEL COLOR CLR_HRED FONT oFontAutor

	if !Empty( iif( cAlias1 == "BE4", BE4->BE4_SENHA, BEA->BEA_SENHA ) )
		@ aPos1[1]+7,aPos1[2]+200  Say oSay1 PROMPT "Senha: "	SIZE 220,010 OF oDlg1 PIXEL FONT oFontAutor
		@ aPos1[1]+7,aPos1[2]+233  Say oSay1 PROMPT cSenha1		SIZE 220,010 OF oDlg1 PIXEL COLOR CLR_HRED FONT oFontAutor
	endif

	if cAlias1 == "BE4"

		DEFINE FONT oFont NAME "Arial" SIZE 0,-11 //BOLD

		@ aPosObj[1,1]+17,aPosObj[1,2]+5   Say oSay1 PROMPT "Internado em: " + DtoC(BE4->BE4_DATPRO) + " - " + Transform(BE4->BE4_HORPRO, "@R 99:99")  SIZE 150,010 OF oDlg1 PIXEL FONT oFont
		@ aPosObj[1,1]+17,aPosObj[1,2]+120 Say oSay1 PROMPT "Data de Alta: " + DtoC(BE4->BE4_DTALTA)												   SIZE 150,010 OF oDlg1 PIXEL FONT oFont

	endif

	RegTomemory(cAlias1,.F.)

	Enchoice(cAlias1,nRecGuia,2,,,,{},aPosObj[2],{},3,,,,oDlg1,.F.,.T.,.F.,,.F.,.T.)
	
	@ aPosObj[3,1], aPosObj[3,2] FOLDER oFolder SIZE aPosObj[3,3], aPosObj[3,4] OF oDlg1 PIXEL PROMPTS "Eventos"

	oBrw1 := TPLSBrw():New(2,2,aPosObj[3,3]-6,aPosObj[3,4]-15,nil,oFolder:aDialogs[1],nil,,nil,nil,nil,.T.,nil,.T.,nil,aHeader2,aColsTr2,.F.,cAlias2,2,"Eventos",nil,nil,nil,aTrab1)

ACTIVATE MSDIALOG oDlg1 ON INIT EnchoiceBar(oDlg1,bOK1,bOK1,.F.,{})

RestArea(aArea)

Return()













// Criação das BOW com base nas ZZQ
user function FredZZQ()
/*
Local cCodRDA	:= AllTrim(GETMV("MV_PLSRDAG"))
Local cNumCRM	:= ""
Local cSigla	:= ""
Local cEst		:= ""
Local cObs		:= ""
Local cAux		:= ""
Local i			:= 0
Local nRecAC9	:= 0
Local aAux		:= {}

if MsgYesNo("Deseja gerar as BOW a partir da ZZQ?")

	ZZQ->(DbSetOrder(1))
	ZZQ->(DBGoTop())

	while ZZQ->(!EOF())

		BA1->(DbSetOrder(2))
		if BA1->(DbSeek(xFilial("BA1") + ZZQ->ZZQ_CODBEN )) .and. !empty(ZZQ->ZZQ_CODBEN)

			BOW->(DbSetOrder(1))	// BOW_FILIAL+BOW_PROTOC
			if !BOW->(DbSeek(xFilial("BOW") + ZZQ->ZZQ_XNUMPA ))	// se não existir - cria

				// Criar novo protocolo de reembolso (padrão)
				RecLock("BOW",.T.)

					BOW->BOW_CODTAB	:= "F"							// flag que nasceu daqui

					BOW->BOW_FILIAL	:= xFilial("ZZQ")
					BOW->BOW_YCDPTC	:= ZZQ->ZZQ_SEQUEN
					BOW->BOW_PROTOC	:= ZZQ->ZZQ_XNUMPA
					BOW->BOW_TIPPAC	:= GetNewPar("MV_PLSTPAA","1")

					// 1=Ativo;2=Cancelado;3=Vinculado
					// 1=Protocolado;2=Em analise;3=Deferido;4=Indeferido;5=Em digitação;6=Lib. financeiro;7=Não lib. financeiro;8=Glosado;9=Auditoria
					BOW->BOW_STATUS	:= iif(ZZQ->ZZQ_STATUS == '1', '1', iif(ZZQ->ZZQ_STATUS == '3', '6', iif(ZZQ->ZZQ_STATUS == '2', '8', ' ')))

					BOW->BOW_USUARI	:= ZZQ->ZZQ_CODBEN
					BOW->BOW_NOMUSR	:= BA1->BA1_NOMUSR
					BOW->BOW_CODCLI	:= ZZQ->ZZQ_CODCLI
					BOW->BOW_LOJA	:= ZZQ->ZZQ_LOJCLI
					BOW->BOW_NOMCLI	:= Posicione("SA1", 1, xFilial("SA1") + ZZQ->(ZZQ_CODCLI+ZZQ_LOJCLI), "A1_NOME" )
					BOW->BOW_MATANT	:= BA1->BA1_MATANT
					BOW->BOW_TIPUSR	:= "01"							// 01=Eventual; 02=Repasse; 99=Usuario Local
					BOW->BOW_VIACAR	:= BA1->BA1_VIACAR
					BOW->BOW_CODEMP	:= BA1->BA1_CODEMP
					BOW->BOW_MATRIC	:= BA1->BA1_MATRIC
					BOW->BOW_TIPREG	:= BA1->BA1_TIPREG
					BOW->BOW_DIGITO	:= BA1->BA1_DIGITO
					BOW->BOW_MATUSA	:= "1"							// 1=Matricula Principal;2=Matricula Antiga
					BOW->BOW_XCDPLA	:= BA1->BA1_CODPLA
					BOW->BOW_PADINT	:= U_CabRetAc( BA1->(RECNO()) )
					BOW->BOW_DTDIGI	:= ZZQ->ZZQ_DATDIG
					BOW->BOW_OPERDA	:= PLSINTPAD()
					BOW->BOW_CODRDA	:= cCodRDA
					BOW->BOW_NOMRDA	:= Posicione("BAU", 1, xFilial("BAU") + cCodRDA, "BAU_NOME"  )
					BOW->BOW_TIPPRE	:= Posicione("BAU", 1, xFilial("BAU") + cCodRDA, "BAU_TIPPRE")
					BOW->BOW_NUMGUI	:= ""
					BOW->BOW_CONEMP	:= BA1->BA1_CONEMP
					BOW->BOW_VERCON	:= BA1->BA1_VERCON
					BOW->BOW_SUBCON	:= BA1->BA1_SUBCON
					BOW->BOW_VERSUB	:= BA1->BA1_VERSUB
					BOW->BOW_UFATE	:= BA1->BA1_ESTADO
					BOW->BOW_MUNATE	:= BA1->BA1_CODMUN
					BOW->BOW_DESMUN	:= BA1->BA1_MUNICI
					BOW->BOW_LOCATE	:= Posicione("BB8", 1, xFilial("BB8") + cCodRDA, "BB8_CODLOC+BB8_LOCAL")
					BOW->BOW_ENDLOC	:= Posicione("BB8", 1, xFilial("BB8") + cCodRDA, "BB8_END" )
					BOW->BOW_SENHA	:= PLSSenAut(ZZQ->ZZQ_DATDIG)
					BOW->BOW_CODESP	:= Posicione("BAX", 1, xFilial("BAX") + cCodRDA + PLSINTPAD() + SUBS(BOW->BOW_LOCATE,1,3), "BAX_CODESP")
					BOW->BOW_DESESP	:= Posicione("BAQ", 1, xFilial("BAQ") + PLSINTPAD() + BOW->BOW_CODESP, "BAQ_DESCRI")

					BOW->BOW_XDTEVE	:= ZZQ->ZZQ_DTEVEN
					BOW->BOW_DATPAG	:= ZZQ->ZZQ_DATPRE
					BOW->BOW_XTPPAG	:= ZZQ->ZZQ_XTPRGT
					
					BOW->BOW_OPEMOV	:= PLSINTPAD()
					BOW->BOW_OPEUSR	:= BA1->BA1_CODINT
					BOW->BOW_EMPMOV	:= cEmpAnt + cFilAnt
					BOW->BOW_TELCON	:= ZZQ->ZZQ_SMS
					BOW->BOW_ORIGEM	:= "00"				// IIF(nModulo == 33,"02",IIF(nModulo == 13,"03","00"))

					BOW->BOW_CDOPER	:= "000000"
					BOW->BOW_NOMOPE	:= "Administrador"
					BOW->BOW_VLRAPR	:= ZZQ->ZZQ_VLRTOT	// sistema recalcula este campo na gravação do protocolo
					BOW->BOW_XVLAPR	:= ZZQ->ZZQ_VLRTOT
					BOW->BOW_NROBCO	:= ZZQ->ZZQ_XBANCO
					BOW->BOW_DESBCO	:= cValtoChar(RestDBanco(ZZQ->ZZQ_XBANCO))
					BOW->BOW_NROAGE	:= AllTrim(ZZQ->ZZQ_XAGENC) + AllTrim(ZZQ->ZZQ_XDVAGE)
					BOW->BOW_NROCTA	:= AllTrim(ZZQ->ZZQ_XCONTA)
					BOW->BOW_XDGCON	:= AllTrim(ZZQ->ZZQ_XDGCON)
					BOW->BOW_XTPEVE	:= iif(ZZQ->ZZQ_TPSOL == '1' .and. ZZQ->ZZQ_TIPPRO == '9', '2', '1' )	// 1=TDE de HM/Evento;2=TDE de Porte Anestesico

					BOW->BOW_OBS	:= "Protocolo criado automaticamente na implantação do novo reembolso."

					if ZZQ->ZZQ_STATUS == '3'	// vinculado

						B44->(DbSetOrder(9))	// B44_FILIAL+B44_YCDPTC
						if B44->(DbSeek(xFilial("B44") + ZZQ->ZZQ_SEQUEN ))

							BOW->BOW_MESAUT	:= B44->B44_MESPAG
							BOW->BOW_ANOAUT	:= B44->B44_ANOPAG
							BOW->BOW_CODLDP	:= B44->B44_CODLDP
							BOW->BOW_CODPEG	:= B44->B44_CODPEG
							BOW->BOW_NUMAUT	:= B44->B44_NUMGUI
							BOW->BOW_ORIMOV	:= B44->B44_ORIMOV
							BOW->BOW_PREFIX	:= B44->B44_PREFIX
							BOW->BOW_NUM	:= B44->B44_NUM
							BOW->BOW_PARCEL	:= B44->B44_PARCEL
							BOW->BOW_TIPO	:= B44->B44_TIPO
							BOW->BOW_VLRREE	:= B44->B44_VLRPAG
							BOW->BOW_PGMTO	:= DtoC(B44->B44_DATVEN)
						
						endif
					
					elseif ZZQ->ZZQ_STATUS == '2'	// 2=Cancelado

						cObs	:= AllTrim(BOW->BOW_OBS)
						cObs	+= chr(10)+chr(13) + chr(10)+chr(13)
						cObs	+= "-----------------------------------------------------------------"													+ chr(10)+chr(13)
						cObs	+= "-- PROTOCOLO CANCELADO --"																							+ chr(10)+chr(13)
						cObs	+= " * Motivo: "		+ ZZQ->ZZQ_MOTCAN + " - " + Posicione("SX5",1,xFilial("SX5")+"ZQ"+ZZQ->ZZQ_MOTCAN, "X5_DESCRI" )+ chr(10)+chr(13)
						cObs	+= " * Observação: "	+ AllTrim(ZZQ->ZZQ_CANOB1) + iif(!empty(ZZQ->ZZQ_CANOB2), " - " + AllTrim(ZZQ->ZZQ_CANOB2), "")	+ chr(10)+chr(13)
						cObs	+= " * Usuário: "		+ ZZQ->ZZQ_YUSRCA																				+ chr(10)+chr(13)
						cObs	+= " * Data: "			+ DtoC(ZZQ->ZZQ_DTCAN)																			+ chr(10)+chr(13)
						cObs	+= " * Hora: "			+ SubStr(ZZQ->ZZQ_HRCAN,1,2) + ":" + SubStr(ZZQ->ZZQ_HRCAN,3,2)									+ chr(10)+chr(13)
						cObs	+= "-----------------------------------------------------------------"

						BOW->BOW_DTCANC	:= dDataBase
						BOW->BOW_OBS	:= cObs

					endif

					// Rede não referencaida
					BOW->BOW_CODREF	:= ZZQ->ZZQ_CPFEXE
					BOW->BOW_NOMREF	:= ZZQ->ZZQ_NOMEXE

					// Prof. Executante
					cNumCRM	:= PadR(AllTrim(ZZQ->ZZQ_REGEXE), TamSx3("BB0_NUMCR" )[1])
					cSigla	:= PadR(AllTrim(ZZQ->ZZQ_SIGEXE), TamSx3("BB0_CODSIG")[1])
					cEst	:= PadR(AllTrim(ZZQ->ZZQ_ESTEXE), TamSx3("BB0_ESTADO")[1])

					// Tratamento para retirar todos os caracteres não numericos enviados
					cAux	:= ""
					for i := 1 to len(cNumCRM)
						if IsDigit( SubStr(cNumCRM, i, 1) )
							cAux += SubStr(cNumCRM, i, 1)
						endif
					next
					cAux	:= AllTrim(str(val(cAux)))

					if val(cAux) > 0
						cNumCRM	:= cAux
					endif

					BB0->(DbSetOrder(4))	// BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
					if BB0->(DbSeek(xFilial("BB0") + cEst + cNumCRM + cSigla )) .and. !empty(cEst) .and. !empty(cNumCRM) .and. !empty(cSigla)

						BOW->BOW_OPEEXE	:= BB0->BB0_CODOPE
						BOW->BOW_ESTEXE	:= BB0->BB0_ESTADO
						BOW->BOW_REGEXE	:= BB0->BB0_NUMCR
						BOW->BOW_SIGLA	:= BB0->BB0_CODSIG
						BOW->BOW_NOMEXE	:= BB0->BB0_NOME
						BOW->BOW_CDPFRE	:= BB0->BB0_CODIGO

					endif

				BOW->(MsUnLock())

			endif

		endif

		ZZQ->(DbSkip())
	end

endif

if MsgYesNo("Deseja migrar o banco de conhecimento para o protocolo de reembolso?")

	BOW->(DbSetOrder(1))
	BOW->(DBGoTop())

	while BOW->(!EOF())

		if !empty(BOW->BOW_PROTOC)

			cAux := "ZZQ" + xFilial("ZZQ") + BOW->(BOW_FILIAL+BOW_YCDPTC+BOW_USUARI)

			AC9->(DbSetOrder(2))	 // AC9_FILIAL+AC9_ENTIDA+AC9_FILENT+AC9_CODENT+AC9_CODOBJ
			if AC9->(DbSeek( xFilial("AC9") + cAux ))

				while AC9->(!EOF()) .and. AllTrim(AC9->(AC9_ENTIDA+AC9_FILENT+AC9_CODENT)) == cAux

					nRecAC9	:= AC9->(RECNO())

					aAux	:= {AC9->AC9_CODOBJ, AC9->AC9_XUSU, AC9->AC9_XDTINC, AC9->AC9_HRINC}

					AC9->(Reclock("AC9",.T.))
						AC9->AC9_FILIAL	:= xFilial("AC9")
						AC9->AC9_FILENT	:= xFilial("BOW")
						AC9->AC9_ENTIDA	:= "BOW"
						AC9->AC9_CODENT	:= xFilial("BOW") + BOW->BOW_PROTOC
						AC9->AC9_CODOBJ	:= aAux[1]
						AC9->AC9_XUSU	:= aAux[2]
						AC9->AC9_XDTINC	:= aAux[3]
						AC9->AC9_HRINC	:= aAux[4]
					AC9->(MsUnlock())

					AC9->(DbGoTo(nRecAC9))
					
					AC9->(DbSkip())
				end

			endif

		endif
		
		BOW->(DbSkip())
	end

endif
*/
return

