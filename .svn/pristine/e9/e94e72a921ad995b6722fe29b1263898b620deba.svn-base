
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ                  
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA191   ºAutor  ³ Altamiro	         º Data ³  19/06/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser do sistema juridico                        º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function caba191(cNCab191,cNproc191,cNCompP191)

// rever apos o incendio 
	PUBLIC __cNCab191   := str(cNCab191,6,0)
	PUBLIC __cNproc191  := trim(cNproc191)
	PUBLIC __cNCompP191 := trim(cNCompP191)
//
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE aRotina	:=	{	{ "&Visualizar"	, "U_Caba191a"		, 0 , 1	 },;
		{ "&Alteracao"	, "U_Caba191a"		, 0 , 2  },;
		{ "&Incluir"	, "U_Caba191a"		, 0 , 3	 },;
		{ "Legenda"		, "U_LEGPR191"	, 0 , 3	 }}



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE cCadastro	:= "Browser do Sistema juridico "

	PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Processo Incluido '         },;
		{ 'BR_AZUL'     ,'Processo Com Decissão'      },;
		{ 'BR_VERMELHO' ,'Processo Arquivado'         },;
		{ 'BR_AMARELO'  ,'Processo Audiencia Marcada' },;
		{ 'BR_PRETO'    ,'Processo Desdobramento' }}

	PRIVATE aCores	:= {{'!empty(PE6_NUMCOM)', aCdCores[5,1]},;
		{'!empty(PE6_NUMPRO)', aCdCores[1,1]},;
		{'!empty(PE6_NUMPRO)', aCdCores[2,1]},;
		{'!empty(PE6_NUMPRO)', aCdCores[3,1]},;
		{'!empty(PE6_NUMPRO)', aCdCores[4,1]} }
//PRIVATE cPath  := ""                        
	PRIVATE cAlias := "PE6"

	PRIVATE cPerg	:= "CABA191"

	PRIVATE cNomeProg   := "CABA191"
	PRIVATE nQtdLin     := 68
	PRIVATE nLimite     := 132
	PRIVATE cControle   := 15
	PRIVATE cTamanho    := "G"
	PRIVATE cTitulo     := "Controle de Multas ANS / AGU  - Cadastro de Multas "
	PRIVATE cDesc1      := ""
	PRIVATE cDesc2      := ""
	PRIVATE cDesc3      := ""
	PRIVATE nRel        := "caba191"
	PRIVATE nlin        := 100
	PRIVATE nOrdSel     := 1
	PRIVATE m_pag       := 1
	PRIVATE lCompres    := .F.
	PRIVATE lDicion     := .F.
	PRIVATE lFiltro     := .T.
	PRIVATE lCrystal    := .F.
	PRIVATE aOrdens     := {}
	PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
	PRIVATE lAbortPrint := .F.
	PRIVATE cCabec1     := "Controle de Multas ANS / AGU  - Cadastro de Multas "
	PRIVATE cCabec2     := ""
	PRIVATE nColuna     := 00
	private nopc191n    := 0
//private cUsuario    := SubStr(cUSUARIO,7,15)  
	private cAssunto    := ' '
	private aDados      := {}
	private aDados1     := {}


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
	dbselectarea("PE6")
	PE6->(DBSetOrder(1))

	SET FILTER TO (PE6_NUMPRO == __cNCab191 .AND. trim(PE6_PROCES) == __cNproc191 .AND. trim(PE6_NUMCOM) == __cNCompP191)
//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))  
	PE6->(mBrowse(006,001,022,075,"PE6" , , , , , 2    , aCores, , , ,nil, .F.))
//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
	PE6->(DbClearFilter())
	DbCloseArea()
Return()


/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
	±±³Funcao    ³ CBIMPLEG   ³ Autor ³ Jean Schulz         ³ Data ³ 06.09.06 ³±±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
	±±³Descricao ³ Exibe a legenda...                                         ³±±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LEGPR191()
	Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
		{ aCdCores[2,1],aCdCores[2,2] },;
		{ aCdCores[3,1],aCdCores[3,2] },;
		{ aCdCores[4,1],aCdCores[4,2] },;
		{ aCdCores[5,1],aCdCores[5,2] } }


	BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

user Function  caba191a(cAlias,nReg,nOpc)

	Private cAssAud    := Space(100)
	Private cIdMulta   := Space(20)
	Private cNumcab    := Space(1)
	Private cNumCompP  := Space(20)
	private nopc191n   := nOpc
	Private cNumproc   := Space(30)
	Private cObsMulta
	Private cTpAut     := Space(15)
	Private cTpProc    := Space(15)
	Private dDtConsil  := CtoD(" ")
	Private dDtIncParc := CtoD(" ")
	Private dDtPrcAtua := CtoD(" ")
	Private dDtPrParc  := CtoD(" ")
	Private dDtRecPro  := CtoD(" ")
	Private dDtUltCont := CtoD(" ")
	Private dDtUltParc := CtoD(" ")
	Private nEncargLeg := 0
	Private nIdParcAtu := '0'
	Private nJuroSelic := 0
	Private nMultMora  := 0
	Private nMultOfic  := 0
	Private nQtdParc   := 0
	Private nTotConsl  := 0
	Private nUltParc   := ' '
	Private nvlrAtProj := 0
	Private nVlrbase   := 0
	Private nVlrParAtu := 0
	Private nVlrParcba := 0
	Private nVlrPres   := 0
	Private nVlrArrend := 0
	Private lLancado   := .F.
	Private cNumGuia   := Space(9)

	If nOpc == 2
		fMArqVar()
	EndIf

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg191","oSay24","oSay26","oGrp13","oBtn1","oBtn2","oBtn4","oGrp1","oSay6","oSay1","oGet8")
SetPrvt("oGet45","oGrp3","oMGet1","oGrp7","oSay16","oSay17","oSay18","oSay19","oSay40","oSay20","oSay21")
SetPrvt("oGet22","dDtRecPro","oGet23","oGet9","oGet10","oGet24","oGrp9","oSay49","oSay50","oSay51","oSay52")
SetPrvt("oSay54","oSay55","oSay56","oSay57","oSay58","oSay59","oSay37","oSay2","oSay3","oSay4","oSay5")
SetPrvt("oGet31","oGet32","oGet33","oGet34","oGet35","oGet36","oGet37","oGet38","oGet39","oGet40","oGet41")
SetPrvt("oGet2","oGet3","oGet4","oGet5","oGet6","oGet7","oGet11","oCBox1" )

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg191    := MSDialog():New( 126,297,674,1265,"Cadastro de Multa ",,,.F.,,,,,,.T.,,,.T. )
//oSay24     := TSay():New( 000,164,{||"Tipo"},oDlg191,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
//oSay26     := TSay():New( 000,088,{||"Numero"},oDlg191,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
/*
oGrp13     := TGroup():New( 000,260,036,472,"Controles",oDlg191,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 016,262,"Grava",oGrp13,{|| fgrava(),oDlg191:End()},048,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 016,341,"Deleta",oGrp13,{||fDeleta()},049,012,,,,.T.,,"",,,,.F. )
oBtn4      := TButton():New( 016,420,"Sair",oGrp13,{||oDlg191:End()},048,012,,,,.T.,,"",,,,.F. )
*/
	oGrp13     := TGroup():New( 000,296,036,472,"Controles",oDlg191,CLR_BLACK,CLR_WHITE,.T.,.F. )
//oBtn1      := TButton():New( 016,298,"Grava",oGrp13,{|| IF fGrava(),oDlg191:End()},048,012,,,,.T.,,"",,,,.F. )
	oBtn1      := TButton():New( 016,298,"Grava",oGrp13,{|| fGrava()},048,012,,,,.T.,,"",,,,.F. )


	oBtn2      := TButton():New( 016,357,"Deleta",oGrp13,{||fDeleta()},049,012,,,,.T.,,"",,,,.F. )
	oBtn4      := TButton():New( 016,412,"Sair",oGrp13,{||oDlg191:End()},048,012,,,,.T.,,"",,,,.F. )

/*
oGrp1      := TGroup():New( 000,004,036,256,"Identificação do Parcelamento ",oDlg191,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay6      := TSay():New( 004,197,{||"Dt Venc. 1ª Parcela "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,051,008)
oSay1      := TSay():New( 004,124,{||"Dt Consolidação "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
oGet8      := TGet():New( 016,008,{|u| If(PCount()>0,cIdMulta:=u,cIdMulta)},oGrp1,084,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cIdMulta",,)
oGet45     := TGet():New( 016,124,{|u| If(PCount()>0,dDtConsil:=u,dDtConsil)},oGrp1,057,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtConsil",,)
oGet12     := TGet():New( 016,196,{|u| If(PCount()>0,(dDtPrParc:=u,fAtuValor(3)),dDtPrParc)},oGrp1,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtPrParc",,)
*/
	oGrp1      := TGroup():New( 000,004,036,292,"Identificação do Parcelamento ",oDlg191,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay6      := TSay():New( 004,145,{||"Dt Venc. 1ª Parc. "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
	oSay1      := TSay():New( 004,092,{||"Dt Consolidação "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
	oSay9      := TSay():New( 004,194,{||"Num. Guia"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
	oGet8      := TGet():New( 016,008,{|u| If(PCount()>0,cIdMulta:=u,cIdMulta)},oGrp1,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cIdMulta",,)
	oGet12     := TGet():New( 016,144,{|u| If(PCount()>0,(dDtPrParc:=u,fAtuValor(3)),dDtPrParc)},oGrp1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtPrParc",,)
	oGet12:bLostFocus:={||fVddat(1)}
	oGet45     := TGet():New( 016,092,{|u| If(PCount()>0,dDtConsil:=u,dDtConsil)},oGrp1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtConsil",,)
	oGet45:bLostFocus:={||fVddat(2)}
	oGet11     := TGet():New( 016,193,{|u| If(PCount()>0,cNumGuia:=u,cNumGuia)},oGrp1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNumGuia",,)
	oCBox1     := TCheckBox():New( 016,240,"Lançado?",{|u| If(PCount()>0,lLancado:=u,lLancado)},oGrp1,036,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

	oGrp3      := TGroup():New( 196,004,264,472,"Observações ",oDlg191,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oGrp7      := TGroup():New( 036,004,096,472,"Identificação do Processo",oDlg191,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay16     := TSay():New( 048,244,{||"Tipo Autor "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay17     := TSay():New( 048,320,{||"Tipo Processo "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
	oSay18     := TSay():New( 048,068,{||"Num. Processo "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay19     := TSay():New( 048,008,{||"Num. Caberj"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay40     := TSay():New( 049,421,{||"Dt Recebimento"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
	oSay20     := TSay():New( 048,161,{||"Num. Compl."},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
	oSay21     := TSay():New( 072,009,{||"Assunto :"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,023,008)
	oGet21     := TGet():New( 058,066,{|u| If(PCount()>0,cNumproc:=u,cNumproc)},oGrp7,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.T.,.F.,"","cNumproc",,)
	oGet22     := TGet():New( 058,008,{|u| If(PCount()>0,cNumCab:=u,cNumcab)},oGrp7,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Num sequencial do processo na Caberj / Integral",,,.F.,.F.,,.T.,.F.,"","cNumcab",,)
	dDtRecPro  := TGet():New( 058,420,{|u| If(PCount()>0,dDtRecPro:=u,dDtRecPro)},oGrp7,047,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtRecPro",,)
//oGet23     := TGet():New( 058,161,{|u| If(PCount()>0,cNumCompP:=u,cNumCompP)},oGrp7,057,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.T.,.F.,"","cNumCompP",,)
	oGet23     := TGet():New( 058,157,{|u| If(PCount()>0,cNumCompP:=u,cNumCompP)},oGrp7,075,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.T.,.F.,"","cNumCompP",,)
	oGet9      := TGet():New( 058,243,{|u| If(PCount()>0,cTpAut:=u,cTpAut)},oGrp7,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpAut",,)
	oGet10     := TGet():New( 058,322,{|u| If(PCount()>0,cTpProc:=u,cTpProc)},oGrp7,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpProc",,)
	oGet24     := TGet():New( 080,008,{|u| If(PCount()>0,cAssAud:=u,cAssAud)},oGrp7,460,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cAssAud",,)
	oGrp9      := TGroup():New( 099,004,196,472,"Dados da Multa",oDlg191,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay49     := TSay():New( 111,008,{||"Data Inicio Parcelamento"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay50     := TSay():New( 139,008,{||"Valor Principal"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay51     := TSay():New( 139,089,{||"Juros Selic"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay52     := TSay():New( 139,162,{||"Multa Oficio"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay53     := TSay():New( 139,245,{||"Multa Mora"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay54     := TSay():New( 139,325,{||"Encargos Legais"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay55     := TSay():New( 139,409,{||"Total Consolidado"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay56     := TSay():New( 167,009,{||"Qtda Total  Parcelas"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay57     := TSay():New( 167,089,{||"Vlr Parcela Base"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay58     := TSay():New( 167,162,{||"Valor Presente"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay59     := TSay():New( 167,325,{||"Data Ultima Contabiliz."},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay37     := TSay():New( 167,246,{||"Valor atual. Projetada"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay2      := TSay():New( 111,089,{||"Data Parcela Atual "},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay3      := TSay():New( 111,325,{||"Data Ultima Parcela"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay4      := TSay():New( 111,162,{||"Parcelas Atual"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay5      := TSay():New( 111,407,{||"Ultima  Parcelas "},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay7      := TSay():New( 112,246,{||"Vlr Parcela Atual"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
	oSay8      := TSay():New( 167,407,{||"Valor Arredondado"},oGrp9,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)

	oGet31     := TGet():New( 123,008,{|u| If(PCount()>0,dDtIncParc:=u,dDtIncParc)},oGrp9,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtIncParc",,)

	oGet32     := TGet():New( 150,008,{|u| If(PCount()>0,(nVlrbase:=u,fAtuValor(1)),nVlrbase)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrbase",,)

	oGet33     := TGet():New( 150,087,{|u| If(PCount()>0,(nJuroSelic:=u,fAtuValor(1)),nJuroSelic)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nJuroSelic",,)

	oGet34     := TGet():New( 150,163,{|u| If(PCount()>0,(nMultOfic:=u,fAtuValor(1)),nMultOfic)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nMultOfic",,)

	oGet35     := TGet():New( 150,246,{|u| If(PCount()>0,(nMultMora:=u,fAtuValor(1)),nMultMora)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nMultMora",,)

	oGet36     := TGet():New( 150,326,{|u| If(PCount()>0,(nEncargLeg:=u,fAtuValor(1)),nEncargLeg)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nEncargLeg",,)

	oGet37     := TGet():New( 150,405,{|u| If(PCount()>0,nTotConsl:=u,nTotConsl)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nTotConsl",,)
	oGet38     := TGet():New( 179,009,{|u| If(PCount()>0,(nQtdParc:=u,fAtuValor(2)),nQtdParc)},oGrp9,060,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nQtdParc",,)

	oGet39     := TGet():New( 179,088,{|u| If(PCount()>0,nVlrParcba:=u,nVlrParcba)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrParcba",,)
	oGet40     := TGet():New( 179,163,{|u| If(PCount()>0,nVlrPres:=u,nVlrPres)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrPres",,)
	oGet41     := TGet():New( 179,325,{|u| If(PCount()>0,dDtUltCont:=u,dDtUltCont)},oGrp9,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtUltCont",,)
	oGet44     := TGet():New( 179,246,{|u| If(PCount()>0,nvlrAtProj:=u,nvlrAtProj)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nvlrAtProj",,)
	oGet2      := TGet():New( 123,087,{|u| If(PCount()>0,dDtPrcAtua:=u,dDtPrcAtua)},oGrp9,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtPrcAtua",,)
	oGet3      := TGet():New( 123,326,{|u| If(PCount()>0,dDtUltParc:=u,dDtUltParc)},oGrp9,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtUltParc",,)
	oGet4      := TGet():New( 123,163,{|u| If(PCount()>0,nIdParcAtu:=u,nIdParcAtu)},oGrp9,060,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nIdParcAtua",,)
	oGet5      := TGet():New( 123,406,{|u| If(PCount()>0,nUltParc:=u,nUltParc)},oGrp9,060,008,'@E 999',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nUltParc",,)
	oGet6      := TGet():New( 124,245,{|u| If(PCount()>0,nVlrParAtu:=u,nVlrParAtu)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","nVlrParAtu",,)
	oGet7      := TGet():New( 179,407,{|u| If(PCount()>0,nVlrArrend:=u,nVlrArrend)},oGrp9,060,008,'@E 999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrArrend",,)
	oMGet1     := TMultiGet():New( 204,008,{|u| If(PCount()>0,cObsMulta:=u,cObsMulta)},oGrp3,460,056,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )

	fMPBWVar()


	oGet8:setfocus()

	oDlg191:Activate(,,,.T.)

Return

static function fAtuValor(Ind)
	If ind == 1
		nTotConsl:=(nVlrbase + nJuroSelic + nMultOfic + nMultMora + nEncargLeg)
		oGet37:refresh()
	EndIf

	if  ind == 2
		If  nQtdParc > 0
			nVlrParcba:= (nTotConsl / nQtdParc)
			oGet39:refresh()
		Else
			Alert("A quantidade de Parcela Não Pode ser zero ")
			oGet38:setfocus()
		EndIf
	EndIf

	If  ind == 3
		dDtIncParc:=dDtPrParc
	EndIf

Return()

static function fVddat(iddat)

	If  Iddat == 1
		If  empty(dDtPrParc)

			MsgAlert("A Data da Primeira parcela TEM que ser Informada", " Data Invalida")
			oGet12:setfocus()

		EndIf
	EndIf

	If  Iddat == 2
		If  empty(dDtConsil)

			MsgAlert("A Data da Consolidação TEM que ser Informada", " Data Invalida")
			oGet45:setfocus()

		EndIf
	EndIf

Return()

static function fMPBWVar()

	local cAliastmp := GetNextAlias()
	local cQuery    := " "

	cQuery := "select PBW_NUMPRO , PBW_PROCES , PBW_NUMCOM , PBW_TPAUTO , PBW_TPACAO , PBW_DTRECB , PBW_HRRECB , PBW_ASSPRO "
	cQuery += CRLF+ " from  " + RetSqlName("PBW") +" PBW "
	cQuery += CRLF+ " where PBW_filial = '"+xFilial('PBW')+ "' and PBW.d_E_L_E_T_ = ' ' "
	cQuery += CRLF+ " and PBW_NUMPRO = "+ str(val(__cNCab191)) +"  and  PBW_PROCES ='"+__cNproc191+"' and  PBW_NUMCOM ='"+__cNCompP191+"' "

	If Select((cAliastmp)) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif

	TCQuery cQuery New Alias (cAliastmp)

	(cAliastmp)->( DbGoTop() )


	cNumCab  := (cAliastmp)->PBW_NUMPRO
	cNumproc := (cAliastmp)->PBW_PROCES
	cNumCompP:= (cAliastmp)->PBW_NUMCOM
	cTpAut   := (cAliastmp)->PBW_TPAUTO
	cTpProc  := (cAliastmp)->PBW_TPACAO
	dDtRec   := (cAliastmp)->PBW_DTRECB
	cAssAud  := (cAliastmp)->PBW_ASSPRO

	(cAliastmp)->(DbCloseArea())

Return()

static function fMArqVar()
	cIdMulta     := PE6_IDMULT
	dDtConsil    := PE6_DTCONS
	dDtPrParc    := PE6_DT1PAR
	cNumcab      := PE6_NUMPRO
	cNumproc     := PE6_PROCES
	cNumCompP    := PE6_NUMCOM

	dDtIncParc   := PE6_DTINPR
	dDtPrcAtua   := PE6_DTPATU
	nIdParcAtu   := PE6_PARATU
	nVlrParAtu   := PE6_VLPATU
	dDtUltParc   := PE6_DTULTP
	nUltParc     := PE6_PARULT
	nVlrbase     := PE6_VLRBAS
	nJuroSelic   := PE6_JURSEL
	nMultOfic    := PE6_MULOFI
	nMultMora    := PE6_MULMOR
	nEncargLeg   := PE6_ENCLEG
	nTotConsl    := PE6_TCONSO
	nQtdParc     := PE6_QTDTPR
	nVlrParcba   := PE6_VLBSPR
	nVlrPres     := PE6_VLRPRE
	nvlrAtProj   := PE6_VLATPJ
	dDtUltCont   := PE6_DTULCT
	cObsMulta    := PE6_OBS
	nVlrArrend   := PE6_VLRARR

	lLancado     := Iif(PE6_LANCAD == 'T', .T., .F.)
	cNumGuia     := PE6_NUMGUI

	fMPBWVar()

Return()

static function fMVarArq()

	PE6_IDMULT   := cIdMulta
	PE6_DTCONS   := dDtConsil
	PE6_DT1PAR   := dDtPrParc
	PE6_NUMPRO   := str(cNumcab,6,0)
	PE6_PROCES   := cNumproc
	PE6_NUMCOM   := cNumCompP

	PE6_DTINPR   := dDtIncParc
	PE6_DTPATU   := dDtPrcAtua
	PE6_PARATU   := nIdParcAtu
	PE6_VLPATU   := nVlrParAtu
	PE6_DTULTP   := dDtUltParc
	PE6_PARULT   := nUltParc
	PE6_VLRBAS   := nVlrbase
	PE6_JURSEL   := nJuroSelic
	PE6_MULOFI   := nMultOfic
	PE6_MULMOR   := nMultMora
	PE6_ENCLEG   := nEncargLeg
	PE6_TCONSO   := nTotConsl
	PE6_QTDTPR   := nQtdParc
	PE6_VLBSPR   := nVlrParcba
	PE6_VLRPRE   := nVlrPres
	PE6_VLATPJ   := nvlrAtProj
	PE6_DTULCT   := dDtUltCont
	PE6_OBS      := cObsMulta
	PE6_VLRARR   := nVlrArrend

	PE6_LANCAD   := Iif (lLancado == .T.,'T', 'F')
	PE6_NUMGUI   := cNumGuia
Return()

static function fLimpVar()

	cAssAud    := Space(100)
	cIdMulta   := Space(20)
	cNumcab    := Space(1)
	cNumCompP  := Space(20)
	cNumproc   := Space(30)
	cObsMulta  := Space(30)
	cTpAut     := Space(15)
	cTpProc    := Space(15)
	dDtConsil  := CtoD(" ")
	dDtIncParc := CtoD(" ")
	dDtPrcAtua := CtoD(" ")
	dDtPrParc  := CtoD(" ")
	dDtRecPro  := CtoD(" ")
	dDtUltCont := CtoD(" ")
	dDtUltParc := CtoD(" ")
	nEncargLeg := 0
	nIdParcAtu := '0'
	nJuroSelic := 0
	nMultMora  := 0
	nMultOfic  := 0
	nQtdParc   := 0
	nTotConsl  := 0
	nUltParc   := 0
	nvlrAtProj := 0
	nVlrbase   := 0
	nVlrParAtu := 0
	nVlrParcba := 0
	nVlrPres   := 0

Return()


Static Function fGrava()
//PE6_FILIAL
//PE6_IDMULT
	Local lRet := .T.
	Local cMsg := ""

// Implementa validações antes da gravação
	If  Empty(dDtPrParc)
		lRet := .F.
		cMsg := "A Data da Primeira parcela TEM que ser Informada. "
	EndIf

	If  Empty(dDtConsil)
		lRet := .F.
		cMsg := "A Data da Consolidação TEM que ser Informada. "
	EndIf

	If !lRet
		Alert(cMsg + " NÃO será  possivel Efetivar Alterações ")
		Return
	Endif

	If lRet // Só prossegue se campos estiverem validados
		dbselectarea("PE6")
		PE6->(DbSetOrder(1))
		If dbSeek(xFilial("PE6")+ cIdMulta )

			If nopc191n == 2

				If EMPTY(PE6->PE6_DTULCT)

					RecLock("PE6",.F.)

					fMVarArq()
					Msunlock("PE6")

					fMonEmail(nopc191n)

				Else

					Alert("Multa Já Contabilizada , NÃO e possivel Efetivar Alterações ")

				EndIf

			EndIf

		Else

			RecLock("PE6",.T.)
			fMVarArq()
			Msunlock("PE6")

			// retirado do codigo por sugestao da Marcia
			//If (ApMsgYesNo("Deseja Contabilizar Esta Multa ","SIMNAO"))

			u_CTB191(cIdMulta)

			//EndIf

			fMonEmail(nopc191n)

		EndIf

		oDlg191:End()

	Endif

return()

//Return(lRet)

Static Function fPrNPbx()
	local ret        := 0
	local cAliastmp  := GetNextAlias()
	Private cQuery   := " "

	cQuery := "select nvl(max(PE6_IDACPR), 0 ) NUMMAX "
	cQuery += CRLF+ " from  " + RetSqlName("PE6") +" PE6 "
	cQuery += CRLF+ " where PE6_filial = '"+xFilial('PE6')+ "' and PE6.d_E_L_E_T_ = ' ' "
	cQuery += CRLF+ " and PE6_NUMPRO = "+ str(__cNCab191,6,0) +"  and  PE6_PROCES ='"+__cNproc191+"' and  PE6_NUMCOM ='"+__cNCompP191+"' "

	If Select((cAliastmp)) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif

	TCQuery cQuery New Alias (cAliastmp)

	(cAliastmp)->( DbGoTop() )
	ret:= ((cAliastmp)->NUMMAX+1)
	(cAliastmp)->(DbCloseArea())

Return( ret )

Static Function fDeleta()

	local cMensagem := "Deseja excluir o Registro. "+CRLF+CRLF+" Exclusão de registro"
	//      If ApMsgYesNo("Deseja excluir o Registro. Deseja excluir","SIMNAO")

	If EMPTY(PE6->PE6_DTULCT)

		If  ApMsgYesNo(cMensagem,"SIMNAO")

			//     fEnmail("DEL")

//        fMonEmail(4)   
			PE6->(RecLock("PE6",.F.))
			PE6->(DbDelete())
			PE6->(MsUnlock())

			MsgAlert("Multa ANS / AGU  APAGADO com Sucesso  !!! - Email Informando Exclução sera Emitido","Atençao!")

			fMonEmail(4)

			oDlg191:End()

		EndIf
	Else

		Alert("Multa Já Contabilizada , NÃO e possivel Efetivar exclução rações ")

	EndIf

Return()

/*--------------------------------------------------------*/ 

static function fMonEmail(opc)

	local cDest := ' '
	//Local _cMensagem := ""
	//local ccCC := ''
	Local ind1 := 1
	Local I    := 1
	private aDados:= {}
	private cEmailenv1:= 'altamiro@caberj.com.br'
	private cEmailenv2:= 'piumbim@caberj.com.br'
	private cEmailenv3:= 'alan.jefferson@caberj.com.br'
	private cEmailenv4:= 'contabilidade@caberj.com.br'
 /*                  
 If susbtr(cTpProc,1,3) == 'ANS
    ccCC := '' 
 EndIf    
  */
	if (!empty(trim(cEmailenv1)))
		cDest += alltrim(cEmailenv1)+','
		// aAdd(aDados,{cDest})
	EndIf
	if (!empty(trim(cEmailenv2)))
		cDest += alltrim(cEmailenv2)+','
		// aAdd(aDados,{cDest})
	EndIf
	if (!empty(trim(cEmailenv3)))
		cDest += alltrim(cEmailenv3)+','
		// aAdd(aDados,{cDest})
	EndIf
	if (!empty(trim(cEmailenv4)))
		cDest += alltrim(cEmailenv4)+','
		//  aAdd(aDados,{cDest})
	EndIf

	aDados1 := separa(cDest,',',.T.)
	for ind1:=1 to len(aDados1)
		If !empty(aDados1[ind1])
			aAdd(aDados,{aDados1[ind1]})
		EndIf
	Next

	// Replace(adados1[ind1],'$$','ANS')

	for I:=1 to len(aDados)

		u_EnvEmail1( fBcoEmail( 1 , opc) , aDados[I,1] , cAssunto, ' ' )

	Next

Return()

STATIC FUNCTION fBcoEmail( NUM, nOpc ) // REGULATORIO - ANS

	Local _cMensagem    := ""
	local cEmCopia      := ' '
	local dddata        := dtos(DATE())
	Local Ind           := 1

	cAssunto  := "Multas ANS / AGU "

	If cEmpant == '01'
		cAssunto  += " - Empresa Caberj "
	Else
		cAssunto  += " - Empresa Intergal"
	EndIf

	If nOpc == 2

		cAssunto  += " - Reenvio por alteração "

	ElseIf nOpc == 4

		cAssunto  += " - Reenvio por deleção "

	Else

		cAssunto  += " - Inclusao  "

	EndIf

//   _cMensagem +=  Chr(13) + Chr(10) +  " Encaminhamos a/o  "+trim(cTpProc)+"  nº "+ str(cNumCab,6,0)  + ' - ' + cNumproc  + ' - ' + cNumComPr    
	_cMensagem +=  Chr(13) + Chr(10) +  " Identificação do Processo   "+trim(cTpProc)+"  nº "  + cNumproc  + ' - ' + cNumComPr
	_cMensagem +=  Chr(13) + Chr(10) +  Chr(13) + Chr(10)+ "Prezados ,  "

	_cMensagem +=  Chr(13) + Chr(10) +  "Informamos que a multa Ans / Agu  de identificação  "+ cIdMulta +' ,'

	If nOpc == 2
		_cMensagem +=  Chr(13) + Chr(10) +  " registrada no processo acima identificado foi alterado no  sistema na data de "+ substr(dddata,7,2)+"/"+ substr(dddata,5,2)+"/"+ substr(dddata,1,4)+"."

	ElseIf nOpc == 4
		_cMensagem +=  Chr(13) + Chr(10) +  " registrada no processo acima identificado foi Excluida do  sistema na data de "+ substr(dddata,7,2)+"/"+ substr(dddata,5,2)+"/"+ substr(dddata,1,4)+"."

	Else
		_cMensagem +=  Chr(13) + Chr(10) +  " registrada no processo acima identificado foi Incluida no sistema na data de "+ substr(dddata,7,2)+"/"+ substr(dddata,5,2)+"/"+ substr(dddata,1,4)+", "
		_cMensagem +=  Chr(13) + Chr(10) +  " Multa Numero "+ trim(cIdMulta) +" , no valor Total de R$ " + transform(nTotConsl,"@E 999,999.99") +" , parcelada em " + transform(nQtdParc,"@E 999") +" , no valor base de R$ " + transform(nVlrParcba,"@E 99,999.99")

		_cMensagem +=  Chr(13) + Chr(10) +  " "

		_cMensagem +=  Chr(13) + Chr(10) +  "Valor da Multa              R$" + transform(__M_VLRMLT,"@E 999,999.99")
		_cMensagem +=  Chr(13) + Chr(10) +  "Valor das Desp. Financeiras R$" + transform(__M_FINMLT,"@E 999,999.99")
		_cMensagem +=  Chr(13) + Chr(10) +  "Valor Curto Prazo           R$" + transform(__M_VLRCRT,"@E 999,999.99")      // multa
		_cMensagem +=  Chr(13) + Chr(10) +  "Valor Longo Prazo           R$" + transform(__M_VLRLNG,"@E 999,999.99")    // desp  financeiras

	EndIf

	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+   "<b> Prezado NÃO respondam a este Email , Email Automatico. </b>"

	for Ind := 1 to len(adados)
		cEmCopia+= adados[Ind,1] +' , '
	next

	_cMensagem +=  Chr(13) + Chr(10) + Chr(13) + Chr(10)+ 'Ps.: Em Copia :' + cEmCopia

	_cMensagem +=  Chr(10) + Chr(13) + Chr(10) + Chr(13)+ Chr(10) + Chr(13) + Chr(10) + Chr(13)+"                    Rio de Janeiro , " +  DtoC( Date() )


return(_cMensagem)


 /*--------------------------------------------------*/ 

User Function CTB191(cNumMult)

	Local   iMlt        := 1
	private  nMesbs     := val(substr(dtos(dDtPrParc),5,2))

	private  cLgnCrt    := 'C1'

	PRIVATE  nVlrArrend    := (nTotConsl - (pe6_vlbspr*nQtdParc))

	PUBLIC  __M_VLRMLT  := pe6_vlrbas  // multa
	PUBLIC  __M_FINMLT  := (pe6_jursel +pe6_mulmor+pe6_encleg) // desp  financeiras
	PUBLIC  __M_VLRCRT  := 0  // multa
	PUBLIC  __M_VLRLNG  := 0  // desp  financeiras

// retirado do codigo pos sugestao da Marcia 
/*
If !(ApMsgYesNo("Confirma a Contabilização desta Multa ","SIMNAO"))    

   Return()

EndIf
*/
	for iMlt:=1 to nQtdParc

		If  cLgnCrt == 'C1'

			If  nMesbs == 12

				nMesbs := 1
				cLgnCrt := 'C2'
				__M_VLRCRT  += pe6_vlbspr

			Else

				__M_VLRCRT  += pe6_vlbspr
				nMesbs += 1

			EndIf

		ElseIf  cLgnCrt == 'C2'

			If  nMesbs == 12

				nMesbs := 1
				cLgnCrt  := 'C3'
				__M_VLRCRT  += pe6_vlbspr

			Else

				__M_VLRCRT  += pe6_vlbspr
				nMesbs += 1

			EndIf

		ElseIf  cLgnCrt == 'C3'

			__M_VLRLNG  += pe6_vlbspr
			nMesbs += 1

		EndIf

	Next

	__M_VLRLNG  += nVlrArrend
	cPadrao     := "870"
	lPadrao     := VerPadrao(cPadrao)
//dDatabase	:=	lastday(stod(mv_par04+"01"))
	dDatabase	:=	dDtPrParc
	cLote       := "008870"
//
//MOSTRA LANÇAMENTO
	l_Mostra    := .T.
	lAglutina   := .T.
//
	cArquivo    := ""
	nHdlPrv     := HeadProva(cLote,"MLT",Substr(cUsuario,7,6),@cArquivo)
	_aArea	    :=	GetArea()
//
	nTotReg	    := 0
	nValLan	    := 0
	nSeq	    := 0

	nTotReg	++
//  
	IncProc(" Processando ..." + cIdMulta )
//
	_nVALOR		:= 0
	_nTotal     := 0
//
	_nTotal     += DetProva(nHdlPrv,cPadrao,"MLT",cLote)
	nSeq ++
//
	RodaProva(nHdlPrv,_nTotal)
	cA100Incl(cArquivo,nHdlPrv,3,cLote,l_Mostra,lAglutina)
	nSeq := 0
//
	dDtUltCont  := DATE()
	cObsMulta   := ' Contabilizado Provisao Inicial em ' + dtos(dDtUltCont)
	oGet41:CtrlRefresh()
	oGet7:CtrlRefresh()

	RecLock("PE6",.F.)

	PE6_DTULCT   := dDtUltCont
	PE6_OBS      := cObsMulta
	PE6_VLRARR   := nVlrArrend

	Msunlock("PE6")

return
