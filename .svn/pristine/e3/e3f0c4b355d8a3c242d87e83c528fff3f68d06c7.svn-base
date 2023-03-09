#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#Include "Ap5Mail.Ch"
#include "PLSA090.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA412   ºAutor  ³ Altamiro	         º Data ³  19/06/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser do sistema juridico                        º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function caba4122(cNCab,cNproc,cNCompP)

	//User Function caba412(3,'0100092-95.2017.5.01.0079','')
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta matriz com as opcoes do browse...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE aRotina	:=	{	{ "&Visualizar", "U_Cab4122a"		, 0 , 1	 },;
		{ "&Alteracao"	, "U_Cab4122a"		, 0 , 2   },;
		{ "&Incluir"	, "U_Cab4122a"		, 0 , 3	 },;
		{ "Legenda"		, "U_LEG4122"	   , 0 , 3	 }}


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Titulo e variavies para indicar o status do arquivo                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PRIVATE cCadastro	:= "Browser do Sistema juridico "

	PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Processo Incluido '      },;
		{ 'BR_AZUL'     ,'Processo Com Decissão'      },;
		{ 'BR_VERMELHO' ,'Processo Arquivado'         },;
		{ 'BR_AMARELO'  ,'Processo Audiencia Marcada' },;
		{ 'BR_PRETO'    ,'Processo Desdobramento' }}

	PRIVATE aCores	:= {{'!empty(PBY_NUMCOM)', aCdCores[5,1]},;
		{'!empty(PBY_NUMPRO)', aCdCores[1,1]},;
		{'!empty(PBY_NUMPRO)', aCdCores[2,1]},;
		{'!empty(PBY_NUMPRO)', aCdCores[3,1]},;
		{'!empty(PBY_NUMPRO)', aCdCores[4,1]} }
	//PRIVATE cPath  := ""
	PRIVATE cAlias := "PBY"

	PRIVATE cPerg	:= "CABA412"

	PRIVATE cNomeProg   := "CABA412"
	PRIVATE nQtdLin     := 68
	PRIVATE nLimite     := 132
	PRIVATE cControle   := 15
	PRIVATE cTamanho    := "G"
	PRIVATE cTitulo     := "Controle de processos judiciais - Custas e Onus "
	PRIVATE cDesc1      := ""
	PRIVATE cDesc2      := ""
	PRIVATE cDesc3      := ""
	PRIVATE nRel        := "caba412"
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
	PRIVATE cCabec1     := "Controle de Processo judiciais - Custas e Onus  "
	PRIVATE cCabec2     := ""
	PRIVATE nColuna     := 00
	PRIVATE cTpcalc     := '2'
	private cNCab412    := cNCab
	private cNproc412   := cNproc
	private cNCompP412  := cNCompP
	private NopcU       := 0
	PRIVATE cTransf     := Space(50)
	//private cNatPG      := '218801'  // ALTAMIRO 14/06/2020
	//private cNatRC      := '218801'  // ALTAMIRO 14/06/2020

	Private lMUlta       := .F.
	Private lMsHelpAuto	:= .T.
	Private lMsErroAuto	:= .F.

	private lFazAtuaut :='F'

	PRIVATE nRecPe6      := 0
	Private _cUsuario:= SubStr(cUSUARIO,7,15)
	Private _cIdUsuar:= RetCodUsr()
	private cDthr    := (dtos(DATE()) + "-" + Time())

	private dHoje :=  DATE()

	private AnoV   := ' '
	private MesV   := ' '
	private DiaV   := ' '
	private DiaO   := ' '

	PRIVATE cAlcadaN1	:= SuperGetMv('MV_ALJUR1')
	PRIVATE nValorN1	:= SuperGetMv('MV_VLJUR1')

	PRIVATE cAlcadaN2 := SuperGetMv('MV_ALJUR2')
	PRIVATE nValorN2	:= SuperGetMv('MV_VLJUR2')

	PRIVATE cAlcadaN3 := SuperGetMv('MV_ALJUR3')
	PRIVATE nValorN3	:= SuperGetMv('MV_VLJUR3')

	PRIVATE nVlAtuAns := 0.00

	PRIVATE   cTM := SuperGetMV("MV_USRALCJ",.F.,"002")

	Private aParcela    :={'1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}
	private cLjCliFor   := ' '

	PRIVATE cComptAtl   := ' '

	Private lFazAtu     := 'F'

	private aSelic := {}
                   /*  {  0.60 , 0.49 , 0.55 , 0.61 , 0.60 , 0.61 , 0.72 , 0.71 , 0.71 , 0.81 , 0.72 , 0.79 , ;
                        0.85 , 0.79 , 0.77 , 0.82 , 0.87 , 0.82 , 0.95 , 0.87 , 0.91 , 0.95 , 0.84 , 0.96 , ;
                        0.94 , 0.82 , 1.04 , 0.95 , 0.99 , 1.07 , 1.18 , 1.11 , 1.11 , 1.11 , 1.06 , 1.16 , ;
                        1.06 , 1.00 , 1.16 , 1.06 , 1.11 , 1.16 , 1.11 , 1.11 , 1.22 , 1.05 , 1.04 , 1.12 , ;
                        1.09 , 0.87 , 1.05 , 0.79 , 0.93 , 0.81 , 0.80 , 0.80 , 0.64 , 0.64 , 0.57 , 0.54 , ;
                        0.58 , 0.47 , 0.53 , 0.52 , 0.52 , 0.52 , 0.54 , 0.57 , 0.47 , 0.54 , 0.49 , 0.49 , ;
                        0.54 , 0.49 , 0.47 , 0.52 , 0.54 , 0.47 , 0.57 , 0.50 , 0.46 , 0.48 , 0.38 , 0.37 , ;
                        0.38 , 0.29 , 0.34 , 0.28 , 0.24 , 0.21 , 0.19 , 0.16 , 0.16 , 0.16 , 0.15 , 0.16 , ;
                        0.15 , 0.13 , 0.20 , 0.21 , 0.27 , 0.31 , 0.36 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , ;
                        0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , ;
                        0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27 , 0.27  }
*/
	private aCompt := {}
                    /* {  '201301' , '201302' , '201303' , '201304' , '201305' , '201306' , '201307' , '201308' ,'201309' , '201310' , '201311' , '201312' , ;
                        '201401' , '201402' , '201403' , '201404' , '201405' , '201406' , '201407' , '201408' ,'201409' , '201410' , '201411' , '201412' , ;
                        '201501' , '201502' , '201503' , '201504' , '201505' , '201506' , '201507' , '201508' ,'201509' , '201510' , '201511' , '201512' , ;
                        '201601' , '201602' , '201603' , '201604' , '201605' , '201606' , '201607' , '201608' ,'201609' , '201610' , '201611' , '201612' , ;
                        '201701' , '201702' , '201703' , '201704' , '201705' , '201706' , '201707' , '201708' ,'201709' , '201710' , '201711' , '201712' , ;
                        '201801' , '201802' , '201803' , '201804' , '201805' , '201806' , '201807' , '201808' ,'201809' , '201810' , '201811' , '201812' , ;
                        '201901' , '201902' , '201903' , '201904' , '201905' , '201906' , '201907' , '201908' ,'201909' , '201910' , '201911' , '201912' , ;
                        '202001' , '202002' , '202003' , '202004' , '202005' , '202006' , '202007' , '202008' ,'202009' , '202010' , '202011' , '202012' , ;
                        '202101' , '202102' , '202103' , '202104' , '202105' , '202106' , '202107' , '202108' ,'202109' , '202110' , '202111' , '202112' , ;
                        '202201' , '202202' , '202203' , '202204' , '202205' , '202206' , '202207' , '202208' ,'202209' , '202210' , '202211' , '202212' , ;
                        '202301' , '202302' , '202303' , '202304' , '202305' , '202306' , '202307' , '202308' ,'202309' , '202310' , '202311' , '202312'}
*/

	//    fGrvPea()
	//    Return()

	fCargaVet()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Starta mBrowse...                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbselectarea("PBY")
	PBY->(DBSetOrder(1))

	SET FILTER TO (PBY_NUMPRO == cNCab412 .AND. PBY_PROCES == cNproc412 .AND. PBY_NUMCOM == cNCompP412)
	//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))
	PBY->(mBrowse(006,001,022,075,"PBY" , , , , , 2    , aCores, , , ,nil, .F.))
	//mBrowse(006,001,022,075,"PBY" )
	//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
	PBY->(DbClearFilter())
	PBY->(DbCloseArea())
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
User Function LEG4122()
	Local aLegenda

	aLegenda 	:= {{ aCdCores[1,1],aCdCores[1,2] },;
		{ aCdCores[2,1],aCdCores[2,2] },;
		{ aCdCores[3,1],aCdCores[3,2] },;
		{ aCdCores[4,1],aCdCores[4,2] },;
		{ aCdCores[5,1],aCdCores[5,2] } }


	BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

User Function cab4122a(cAlias,nReg,nOpc)

   /*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
   ±± Declaração de cVariable dos componentes                                 ±±
   Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
   Private cAssAud    := Space(100)
   Private cClient    := Space(6)
   Private cFornec    := Space(6)
   Private cHoraRec   := Space(4)
   Private cIdentOnus := Space(15)
   Private cidonus    := Space(9)
   Private cNomClient := Space(40)
   Private cNomFornec := Space(40)
   Private cNumCompP  := Space(20)
   Private cNumGuia   := Space(15)
   Private cNumproc   := Space(30)
   Private cObsOnus
   Private cParcPg    := '0'
   Private cParcRec   := '0'
   Private cPrefPg    := Space(3)
   Private cPrefRec   := Space(3)
   Private cQtdaParc  := Space(2)
   Private cTitPg     := Space(9)
   Private cTitRec    := Space(9)
   Private cTpAut     := Space(15)
   Private cTpProc    := Space(15)
   Private dDtAtuali  := CtoD(" ")
   Private dDtRecPro  := CtoD(" ")
   Private dDtVencPg  := CtoD(" ")
   Private dDtVencRec := CtoD(" ")
   PRIVATE cNatureza  := '46318  '
   Private lAtDt      := .F.
   Private lGTitPag   := .F.
   Private lGTitRec   := .F.
   Private nAtuMonet  := ' '
   Private nClasseOnu := ' '
   Private nNumCab    := 0
   Private nParcela   := 'Nao'
   Private npercent   := 0.00
   Private cTipoPg    := '  '
   Private cTipoRec   := '  '
   Private nTpOnus    := ''
   Private nTpRepas   := ''
   Private nVlAcresR  := 0.00
   Private nVlracresP := 0.00
   Private nVlrAtual  := 0.00
   Private nVlrPgt    := 0.00
   Private nVlrRec    := 0.00

   private pAno       :=' '
   private pMes       :=' '
   private contMes    := 0

   private lCritic    := .F.

   private cVarLolc   := Space(50)


   private nopc412n   := 0
   //private cUsuario   := SubStr(cUSUARIO,7,15)
   /*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
   Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
   SetPrvt("oDlg4122","oSay24","oSay25","oSay26","oGrp13","oBtn1","oBtn2","oBtn3","oBtn4","oBtn5" ,"oGrp11","oSay41","oSay42")
   SetPrvt("oSay4","oSay5","Fornec","oSay3","oSay11","oSay13","oSay14","oSay15","oSay22","oSay23","oSay45")
   SetPrvt("oSay7","oSay8","oSay9","oSay10","oSay12","oSay27","oSay28","oSay29","oSay46","oTpOnus1","oVlrOnus1")
   SetPrvt("oGet3","oCBox3","oGet1","oGet11","oCBox2","oGet13","oGet14","oGet25","oCBox4","oGet2","oGet28","oGet29")
   SetPrvt("oGet5","oGet6","oGet7","oCBox6","oGet15","oGet16","oGet26","oGrp1","oSay1","oSay6","oGet8","oCBox1")
   SetPrvt("oGrp3","oMGet1","oGrp7","oSay16","oSay17","oSay18","oSay19","oSay38","oSay39","oSay40","oSay20","oGrp6")
   SetPrvt("oGet21","oGet22","oHoraRec","dDtRecPro1","oGet23","oGet9","oGet10","oGet24","oGrp2","oSay30","oGrp5")
   SetPrvt("oSay32","oSay33","oSay34","oSay44","oSay47","oCBox7","oGet17","oCBox8","oGet18","oGet19","oGet20")
   SetPrvt("oGrp4","oSay35","oSay36","oSay37","oCBox5")

   /*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
   Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

   //dbselectarea("PBY")

   nopc412n:=nopc
   nOpcU   := nopc
   dbSelectArea("SE2")
   dbSetOrder(1)
   dbSelectArea("SE1")
   dbSetOrder(1)

   If nopc412n == 3
      cidonus :=fPrNPbY()
      //   oBtn2:DISABLE()
      fMPBWVar()

   Else
      dbselectarea("PBY")
      DbGoto(nReg)
      fMArqVar()
      If !empty(nTpOnus) //.and. lGTitPag
         If !fValBx('PGT')
            MsgAlert("Este Titulos a pagar , Já Sofreu Baixa ou esta em bordero  , NÃO pode ser Alterado  !!! ","Atencao!")
            lCritic := .T.
         EndIf
      ElseIf !empty(nTpRepas) //.and. lGTitRec
         If !fValBx('REC')
            MsgAlert("Este Titulos a Receber , Já Sofreu Baixa ou esta em bordero  , NÃO pode ser Alterado  !!! ","Atencao!")
            lCritic := .T.
         EndIf
      EndIf
   EndIf


   /*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
   Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

   oDlg4122      := MSDialog():New( 091,228,611,1193,"Onus da Causa ",,,.F.,,,,,,.T.,,,.T. )
  
   oGrp13     := TGroup():New( 000,260,024,472,"Controles",oDlg4122 ,CLR_BLACK,CLR_WHITE,.T.,.F. )

   oBtn1      := TButton():New( 008,264,"Grava",oGrp13,{||fGrava()},037,012,,,,.T.,,"",,,,.F. )
  
   oBtn3      := TButton():New( 008,306,"At. Monetaria"   ,oGrp13,{||fAtMonet()},037,012,,,,.T.,,"",,,,.F. )
  
   oBtn2      := TButton():New( 008,390,"Deleta",oGrp13,{||fDeleta(),oDlg4122:End()},037,012,,,,.T.,,"",,,,.F. )
  
   oBtn4      := TButton():New( 008,432,"Sair",oGrp13,{||oDlg4122:End()},037,012,,,,.T.,,"",,,,.F. )
  
   oBtn5      := TButton():New( 008,348,"Multa Ans/Agu",oGrp13,{||fMulta()},037,012,,,,.T.,,"",,,,.F. )

   oGrp11     := TGroup():New( 113,004,184,472,"Dados Do Titulo",oDlg4122,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oSay41     := TSay():New( 129,008,{||"Tipo de Ônus"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay42     := TSay():New( 129,176,{||"Valor"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
   oSay43     := TSay():New( 129,268,{||"Data Vencto "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay4      := TSay():New( 121,064,{||"    [--------------------- Identificação  Financeira a Pagar ---------------------]"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,313,008)
   oSay5      := TSay():New( 157,008,{||"Repasse"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   Fornec     := TSay():New( 129,308,{||"Fornecedor"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
   oSay3      := TSay():New( 130,345,{||"Nome / Razão Social  -  Fornecedor "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,099,008)
   oSay11     := TSay():New( 129,452,{||"Gerar "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
   oSay13     := TSay():New( 129,064,{||"Prefixo"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
   oSay14     := TSay():New( 129,088,{||"Numero"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
   oSay15     := TSay():New( 129,132,{||"Parc"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
   oSay22     := TSay():New( 129,148,{||"Tipo"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
   oSay23     := TSay():New( 150,065,{||"[--------------------- Identificação  Financeira a Receber ---------------------]"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,333,008)
   oSay45     := TSay():New( 129,225,{||"Acres/Multa"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,008)
   oSay2      := TSay():New( 158,453,{||"Gerar "},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
   oSay7      := TSay():New( 159,346,{||"Nome / Razão Social  -  Cliente"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,099,008)
   oSay8      := TSay():New( 158,309,{||"Cliente"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
   oSay9      := TSay():New( 158,268,{||"Data Vencto"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay10     := TSay():New( 158,226,{||"Acres/Multa"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,008)
   oSay12     := TSay():New( 158,177,{||"Valor"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
   oSay27     := TSay():New( 158,149,{||"Tipo"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
   oSay28     := TSay():New( 158,133,{||"Parc"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,011,008)
   oSay29     := TSay():New( 158,089,{||"Numero"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
   oSay46     := TSay():New( 158,065,{||"Prefixo"},oGrp11,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
   oTpOnus1   := TComboBox():New( 137,008,{|u| If(PCount()>0,nTpOnus:=u,nTpOnus)},{"" , "Custas Judiciais ","Custas Periciais ","Deposito Judiciais ","Condenações ","Multas","Outros"},052,010,oGrp11,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpOnus )
   oVlrOnus1  := TGet():New( 137,176,{|u| If(PCount()>0,nVlrPgt:=u,nVlrPgt)},oGrp11,044,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrPgt",,)
   oDtOnus1   := TGet():New( 137,268,{|u| If(PCount()>0,dDtVencPg:=u,dDtVencPg)},oGrp11,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtVencPg",,)
   oGet3      := TGet():New( 137,064,{|u| If(PCount()>0,cPrefPg:=u,cPrefPg)},oGrp11,020,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPrefPg",,)

   oCBox3     := TComboBox():New( 166,008,{|u| If(PCount()>0,nTpRepas:=u,nTpRepas)},{"","Nao repassar","Fornecedor","RDA","Cliente","outro"},052,010,oGrp11,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nTpRepas )

   oGet1     := TGet():New( 137,308,{|u| If(PCount()>0,cFornec:=u,cFornec)},oGrp11,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2JUR","cFornec",,)
   oGet1:bF3 := &('{||fc("SA2")}')

   oGet11     := TGet():New( 137,344,{|u| If(PCount()>0,cNomFornec:=u,cNomFornec)},oGrp11,104,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomFornec",,)
   oCBox2     := TCheckBox():New( 137,456,"oCBox2",{|u| If(PCount()>0,lGTitPag:=u,lGTitPag)},oGrp11,008,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

   oGet13      := TGet():New( 137,088,{|u| If(PCount()>0,cTitPg:=u,cTitPg)}   ,oGrp11,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SE2JUR","cTitPg",,)
   oGet13:bF3 := &('{||fc("SE2")}')

   oGet14     := TGet():New( 137,132,{|u| If(PCount()>0,cParcPg:=u,cParcPg)},oGrp11,012,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cParcPg",,)
   oGet28     := TGet():New( 137,148,{|u| If(PCount()>0,cTipoPg:=u,cTipoPg)},oGrp11,016,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTipoPg",,)
   oGet25     := TGet():New( 137,225,{|u| If(PCount()>0,nVlracresP:=u,nVlracresP)},oGrp11,025,008,'@E 9,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlracresP",,)
   oCBox4     := TCheckBox():New( 166,457,"oCBox4",{|u| If(PCount()>0,lGTitRec:=u,lGTitRec)},oGrp11,008,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
   oGet2      := TGet():New( 166,345,{|u| If(PCount()>0,cNomClient:=u,cNomClient)},oGrp11,104,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomClient",,)

   oGet4        := TGet():New( 166,309,{|u| If(PCount()>0,cClient:=u,cClient)},oGrp11,024,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1JUR","cClient",,)
   oGet4:bF3 := &('{||fc("SA1")}')

   oGet5      := TGet():New( 166,268,{|u| If(PCount()>0,dDtVencRec:=u,dDtVencRec)},oGrp11,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtVencRec",,)
   oGet6      := TGet():New( 166,226,{|u| If(PCount()>0,nVlAcresR:=u,nVlAcresR)},oGrp11,025,008,'@E 9,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlAcresR",,)
   oGet7      := TGet():New( 166,177,{|u| If(PCount()>0,nVlrRec:=u,nVlrRec)},oGrp11,044,008,'@E 99,999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrRec",,)
   oGet29     := TGet():New( 166,148,{|u| If(PCount()>0,cTipoRec:=u,cTipoRec)},oGrp11,016,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cTipoRec",,)
   oGet15     := TGet():New( 166,133,{|u| If(PCount()>0,cParcRec:=u,cParcRec)},oGrp11,012,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cParcRec",,)

   oGet16     := TGet():New( 166,089,{|u| If(PCount()>0,cTitRec:=u,cTitRec)},oGrp11,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SE1JUR","cTitRec",,)
   oGet16:bF3 := &('{||fc("SE1")}')

   oGet26     := TGet():New( 166,065,{|u| If(PCount()>0,cPrefRec:=u,cPrefRec)},oGrp11,020,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cPrefRec",,)

   oGrp1      := TGroup():New( 000,004,024,256,"Identificação do Onus ",oDlg4122,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oSay1      := TSay():New( 004,092,{||"Classe do Onus "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
   oSay6      := TSay():New( 004,165,{||"Identificação do Onus "},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,063,008)
   oGet8      := TGet():New( 012,008,{|u| If(PCount()>0,cidonus:=u,cidonus)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cidonus",,)


   If trim(cTpProc) $ "1-PROCESSO INTERNO|2-PROCESSO INTERNO"

      oCBox1     := TComboBox():New( 012,092,{|u| If(PCount()>0,nClasseOnu:=u,nClasseOnu)},{" " ,"Proc.Internos C/R","Proc.Internos C/P"},064,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nClasseOnu )
      oCBox1:bLostFocus:={||fArecpag()}
   Else
      oCBox1     := TComboBox():New( 012,092,{|u| If(PCount()>0,nClasseOnu:=u,nClasseOnu)},{" " , "Judicial C/R","Judicial C/P","ANS C/R","ANS C/P"},064,010,oGrp1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nClasseOnu )
      oCBox1:bLostFocus:={||fArecpag()}
   EndIf

   oGet12     := TGet():New( 012,164,{|u| If(PCount()>0,cIdentOnus:=u,cIdentOnus)},oGrp1,088,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cIdentOnus",,)
   oGrp3      := TGroup():New( 184,004,236,472,"Observações ",oDlg4122,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oMGet1     := TMultiGet():New( 192,008,{|u| If(PCount()>0,cObsOnus:=u,cObsOnus)},oGrp3,460,036,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
   oGrp7      := TGroup():New( 024,004,076,472,"Identificação do Processo",oDlg4122,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oSay16     := TSay():New( 032,228,{||"Tipo Autor "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay17     := TSay():New( 032,292,{||"Tipo Processo "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
   oSay18     := TSay():New( 032,072,{||"Num. Processo "},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
   oSay19     := TSay():New( 032,008,{||"Num. Caberj"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay38     := TSay():New( 027,408,{||"Recebimento"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay39     := TSay():New( 033,439,{||"Hora"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
   oSay40     := TSay():New( 033,389,{||"Data"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
   oSay20     := TSay():New( 032,161,{||"Num. Compl."},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
   oSay21     := TSay():New( 052,009,{||"Assunto :"},oGrp7,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,023,008)
   oGet21     := TGet():New( 042,070,{|u| If(PCount()>0,cNumproc:=u,cNumproc)},oGrp7,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.T.,.F.,"","cNumproc",,)
   oGet22     := TGet():New( 042,008,{|u| If(PCount()>0,nNumCab:=u,nNumCab)},oGrp7,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Num sequencial do processo na Caberj / Integral",,,.F.,.F.,,.T.,.F.,"","nNumCab",,)
   oHoraRec   := TGet():New( 042,440,{|u| If(PCount()>0,cHoraRec:=u,cHoraRec)},oGrp7,016,008,'@E 99:99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cHoraRec",,)
   dDtRecPro1 := TGet():New( 042,389,{|u| If(PCount()>0,dDtRecPro:=u,dDtRecPro)},oGrp7,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","dDtRecPro",,)
   oGet23     := TGet():New( 042,159,{|u| If(PCount()>0,cNumCompP:=u,cNumCompP)},oGrp7,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"Numero do processo",,,.F.,.F.,,.T.,.F.,"","cNumCompP",,)
   oGet9      := TGet():New( 042,228,{|u| If(PCount()>0,cTpAut:=u,cTpAut)},oGrp7,052,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpAut",,)
   oGet10     := TGet():New( 042,292,{|u| If(PCount()>0,cTpProc:=u,cTpProc)},oGrp7,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cTpProc",,)
   oGet24     := TGet():New( 060,008,{|u| If(PCount()>0,cAssAud:=u,cAssAud)},oGrp7,460,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cAssAud",,)

   oGrp2      := TGroup():New( 076,004,112,084,"Parcelamento ?",oDlg4122,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oSay30     := TSay():New( 084,008,{||"Tit Parcelado ?"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
   oSay31     := TSay():New( 084,048,{||"N. Parcelas"},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oCBox7     := TComboBox():New( 092,008,{|u| If(PCount()>0,nParcela:=u,nParcela)},{"Sim","Nao",""},032,010,oGrp2,,,,CLR_BLACK,CLR_WHITE,.T.,,"'show'",,,,,,,nParcela )

   oCBox7:bLostFocus:={||fParc_s_n(nParcela)}

   oGet17     := TGet():New( 092,048,{|u| If(PCount()>0,cQtdaParc:=u,cQtdaParc)},oGrp2,028,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQtdaParc",,)

   oGet17:bLostFocus:={||fCritParc(nParcela, cQtdaParc )}
   nAtuMonet := "Nao"

   oGrp4      := TGroup():New( 076,380,112,472,"Instruções Parcelamento",oDlg4122,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oSay35     := TSay():New( 084,384,{||"'Sim' em 'Tit Parcelado' "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,080,008)
   oSay36     := TSay():New( 092,384,{||"Num. Parcelas , Atualiza Monet."},oGrp4,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,080,008)
   oSay37     := TSay():New( 100,384,{||"% ou Vlr , se tiver Num da guia "},oGrp4,,,.F.,.F.,.F.,.T.,CLR_RED,CLR_WHITE,080,008)

   oGrp8      := TGroup():New( 076,320,112,376,"Natureza Financeira",oDlg4122,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oSay48     := TSay():New( 084,324,{||"Cod. Natureza"},oGrp8,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
  
   oGet3:bLostFocus:={||fVlNat( cPrefPg )}

  If  !empty(cPrefPg)
      If cPrefPg == 'RPD'
         cNatureza := '46318'
      ELSEIf cPrefPg == 'JUD'
         cNatureza := '46317'
      ELSEIf cPrefPg == 'JUT'
         cNatureza := '46313'  
      EndIf  
   EndIf    

   oGet30     := TGet():New( 092,324,{|u| If(PCount()>0,cNatureza:=u,cNatureza)},oGrp8,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SED","cNatureza",,)

   oGrp5      := TGroup():New( 076,088,112,260,"Atualização Monetaria",oDlg4122,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oSay32     := TSay():New( 084,092,{||"Atualiza?"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
   oSay34     := TSay():New( 084,132,{||"% Atual "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
   oSay33     := TSay():New( 084,160,{||"Vlr Atalizacao"},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,036,008)
   oSay47     := TSay():New( 084,208,{||"Num Documento "},oGrp5,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,043,008)
   oCBox8     := TComboBox():New( 092,092,{|u| If(PCount()>0,nAtuMonet:=u,nAtuMonet)},{"Sim","Nao",""},032,010,oGrp5,,,,CLR_BLACK,CLR_WHITE,.T.,,"'show'",,,,,,,nAtuMonet )

   oCBox8:bLostFocus:={||fvalAtMon(nAtuMonet)}

   oGet18     := TGet():New( 092,132,{|u| If(PCount()>0,npercent:=u,npercent)},oGrp5,016,008,'@E 99,99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","npercent",,)
   oGet19     := TGet():New( 092,160,{|u| If(PCount()>0,nVlrAtual:=u,nVlrAtual)},oGrp5,040,008,'@E 9999,999.99',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nVlrAtual",,)

   oGet20     := TGet():New( 092,208,{|u| If(PCount()>0,cNumGuia:=u,cNumGuia)},oGrp5,048,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNumGuia",,)

   oCBox8:enable()
   oGet18:enable()
   oGet18:disable()
   oGet19:enable()

   oGrp6      := TGroup():New( 076,264,112,316,"Atualizar Dt Vencto",oDlg4122,CLR_BLACK,CLR_WHITE,.T.,.F. )
   oSay44     := TSay():New( 082,268,{||"Data Vencto. Atual."},oGrp6,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,041,008)
   oGet27     := TGet():New( 090,268,{|u| If(PCount()>0,dDtAtuali:=u,dDtAtuali)},oGrp6,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDtAtuali",,)
   oCBox5     := TCheckBox():New(102 ,268,"Atualiza Data ?",{|u| If(PCount()>0,lAtDt:=u,lAtDt)},oGrp6,050,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )

   If cIdentOnus != ' '
      fArecpag()
   EndIf
   oDlg4122:Activate(,,,.T.)

Return
////////////////////////////

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

/////////////////////////////

Static Function fMulta()
   U_caba191(cNCab412,cNproc412,cNCompP412)
Return

Static Function fGrava()

   Local x  := 0

    If trim(cPrefPg) ==  'RPD'
       If  ApMsgYesNo("Modelo de Calculo de Correção Monetaria é AGU ","SIMNAO")
           cTpcalc:= '2'
       Else    
           cTpcalc:= '1'
       endIf       
   endIf    

    If  !empty(cPrefPg)
      If cPrefPg == 'RPD'
         cNatureza := '46318'
      ELSEIf cPrefPg == 'JUD'
         cNatureza := '46317'
      ELSEIf cPrefPg == 'JUT'
         cNatureza := '46313'  
      EndIf  
   EndIf   
       
   If (((cParcPg = ' ' .OR. cParcPg = '0') .AND. (cParcRec = ' ' .OR. cParcRec = '0')) .and. (lGTitPag .or. lGTitRec  ).and. nParcela == 'Sim' .and. nOpcU != 3)
      MsgAlert("Este Titulos NÃO pode ser Alterado  , Se for necessario alterar as caracteristicas do titulo , favor excluir e reincluir !!! ","Atencao!")
      lCritic := .T.
   EndIf

   If !empty(nTpOnus)

      if empty(cPrefPg)
         MsgAlert("Prefixo do titulo a Pagar não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet3:SetFocus()
         lCritic := .T.
      ElseIf empty(cTitPg)
         MsgAlert("Numero  do titulo a Pagar não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet13:SetFocus()
         lCritic := .T.
      ElseIf !fValBx('PGT') .and. nOpcU != 3  .and. (lGTitPag .or. lGTitRec  )
         MsgAlert("Titulo a Pagar Ja baixado ou esta em bordero !!! - Titulo Não pode ser Alterado, Mas sera Incluido  ","Atencao!")
         lCritic := .T.
      ElseIf empty(cTipoPg)
         MsgAlert("Tipo do titulo a Pagar não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet28:SetFocus()
         lCritic := .T.
      ElseIf empty(cFornec)
         MsgAlert("Codigo do Fornecedor do titulo a Pagar não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet1:SetFocus()
         lCritic := .T.
      ElseIf empty(cNomFornec)
         MsgAlert("Nome/Razão Social do Fornecedor do titulo a Pagar não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet11:SetFocus()
         lCritic := .T.
      ElseIf empty(dDtVencPg)
         MsgAlert("Data de Vencimento do titulo a Pagar não preenchido !!! - Preencha para continuar ","Atencao!")
         oDtOnus1:SetFocus()
         lCritic := .T.
      ElseIf empty(nVlrPgt)
         MsgAlert("Valor do titulo a Pagar não preenchido !!! - Preencha para continuar ","Atencao!")
         oVlrOnus1:SetFocus()
         lCritic := .T.
         //     ElseIf empty(nVlracresP)
      EndIf

   ElseIf !empty(nTpRepas)

      if  empty(cPrefRec)
         MsgAlert("Prefixo do titulo a Receber não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet16:SetFocus()
         lCritic := .T.
      ElseIf empty(cTitRec)
         MsgAlert("Numero  do titulo a Receber não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet16:SetFocus()
         lCritic := .T.
      ElseIf !fValBx('REC') .and. nOpcU == 3
         MsgAlert("Titulo a Receber Ja baixado ou esta em bordero !!! - Titulo Não pode ser Alterado  ","Atencao!")
      ElseIf empty(cTipoRec)
         MsgAlert("Tipo do titulo a Receber não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet29:SetFocus()
         lCritic := .T.
      ElseIf empty(cClient)
         MsgAlert("Codigo do Cliente do titulo a Receber não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet4:SetFocus()
         lCritic := .T.
      ElseIf empty(cNomClient)
         MsgAlert("Nome/Razão Social do Cliente do titulo a Receber não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet2:SetFocus()
         lCritic := .T.
      ElseIf empty(dDtVencRec)
         MsgAlert("Data de Vencimento do titulo a Receber não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet5:SetFocus()
         lCritic := .T.
      ElseIf empty(nVlrRec)
         MsgAlert("Valor do titulo a receber não preenchido !!! - Preencha para continuar ","Atencao!")
         oGet7:SetFocus()
         lCritic := .T.
         //    ElseIf empty(nVlAcresR)
      EndIf
   Else
      MsgAlert("Tipo do Onus  e Repasse Não Preenchido , favor selecionar tipo de Titulos e preencha dos dados do titulos!!! ","Atencao!")
      oTpOnus1:SetFocus()
      lCritic := .T.
   EndIf

   If lCritic == .F.
      If nopc412n == 2
         RecLock("PBY",.F.)
         fMVarArq(1,0)
         Msunlock("PBY")
         If !empty(nTpOnus) .and.  (nAtuMonet == 'Sim' .or. !empty(dDtAtuali) .or. lFazAtu)
            dbselectArea("SE2")
            dbSetOrder(1)
            If (dbSeek(xFilial("SE2") +  PBY->PBY_PREFPG+;
                  PBY->PBY_TITPGT+;
                  PBY->PBY_PARCPG+;
                  PBY->PBY_TIPOPG+;
                  PBY->PBY_CODFOR))
               //  +;POSICIONE("SA2",1,xFilial("SA2")+cFornec,"A2_LOJA") ))

               RecLock("SE2",.F.)

               if !empty(dDtAtuali)  .and. lAtDt == .T.

                  E2_VENCREA  :=  dDtAtuali
                  e2_vencto   :=  dDtAtuali

               EndIf

               if nVlrAtual > 0 .AND. nAtuMonet == 'Sim'

                  E2_SDACRES  += nVlrAtual
                  E2_ACRESC   += nVlrAtual

               Elseif nVlrAtual < 0 .AND. nAtuMonet == 'Sim'

                  E2_SDDECRE  += (nVlrAtual*-1)
                  E2_DECRESC  += (nVlrAtual*-1)

               ElseIf npercent > 0

                  E2_SDACRES  := ((nVlrPgt * npercent)/100)
                  E2_ACRESC   := ((nVlrPgt * npercent)/100)

               EndIf
               
              /// fAjsVlr()

               Msunlock("SE2")

               //fEnmail("AJT", "PGT", PBY->PBY_PREFPG, PBY->PBY_TITPGT , PBY->PBY_PARCPG , PBY->PBY_TIPOPG , PBY->PBY_CODFOR ,  SE2->E2_LOJA , SA2->A2_NOME , PBY->PBY_DTVPAG , (SE2->E2_SALDO+SE2->E2_SDACRES-SE2->E2_SDDECRE))
               lFazAtuaut :='F'
            Else

               MsgAlert("Titulo no Financeiro Não localizado !!! ","Atencao!")
           
            EndIf

         ElseIf !empty(nTpRepas) .and. (nAtuMonet == 'Sim' .or. !empty(dDtAtuali))

            dbselectArea("SE1")
            dbSetOrder(1)

            If (dbSeek(xFilial("SE1") + PBY->PBY_PREFRC+;
                  PBY->PBY_TITREC+;
                  PBY->PBY_PARCRC+;
                  PBY->PBY_TIPORC+;
                  PBY->PBY_CODCLI+;
                  POSICIONE("SA1",1,xFilial("SA1")+cClient,"A1_LOJA")   ))
               RecLock("SE1",.F.)

               if !empty(dDtAtuali)  .and. lAtDt == .T.
                  E1_VENCREA  :=  dDtAtuali
               EndIf

               if nVlrAtual <> 0 .AND. nAtuMonet == 'Sim'
                  E1_SDACRES  += nVlrAtual
                  E1_ACRESC   += nVlrAtual

                  cObsOnus +=  CRLF + " Valor R$"+transform(nVlrAtual,"@E 99,999.99")+" - Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF + CRLF

               ElseIf npercent > 0

                  E1_SDACRES  += ((nVlrRec * npercent)/100)
                  E1_ACRESC   += ((nVlrRec * npercent)/100)

               EndIf

               Msunlock("SE1")

               //fEnmail("AJT", "REC", PBY->PBY_PREFRC, PBY->PBY_TITREC , PBY->PBY_PARCRC , PBY->PBY_TIPORC , PBY->PBY_CODCLI , SE1->E1_LOJA , SA1->A1_NOME , PBY->PBY_DTVREC , PBY->PBY_VLRREC)
               lFazAtuaut :='F'
            Else
               MsgAlert("Titulo no Financeiro Não localizado !!! ","Atencao!")
            EndIf
         EndIf

      Else

         RecLock("PBY",.T.)
         fMVarArq(1,0)
         Msunlock("PBY")
         If nParcela == 'Nao'
            fGrvse()
         EndIf
         If nParcela == 'Sim'

            For x:=1 to (val(strzero(val(cQtdaParc),2)))
               RecLock("PBY",.T.)
               fMVarArq(2,x)
               Msunlock("PBY")
               fGrvse()
            Next

         EndIf
         
      EndIf

     // If !empty(nRecPe6)
   
     //    fGrvPe6(nRecPe6)
   
     // EndIf 
      
      oDlg4122:End()
   
   Else
      
      MsgAlert("Registro com Critica , AJUSTE a(s) criticas ou Registros NÃO será gravado !!! ","Atencao!")

      lCritic:=.T.

      oDlg4122:End()

   EndIf

return()

//////////////////////////////////
Static Function fPrNPby()
   local ret        := 0
   local cAliastmp  := GetNextAlias()
   Private cQuery   := " "

   cQuery := "select nvl(max(PBY_IDACPR), 0 ) NUMMAX "
   cQuery += CRLF+ " from  " + RetSqlName("PBY") +" PBY "
   cQuery += CRLF+ " where PBY_filial = '"+xFilial('PBY')+ "' and PBY.d_E_L_E_T_ = ' ' "

   cQuery += CRLF+ " and PBY_NUMPRO = "+ str(cNCab412,6,0) +"  and  PBY_PROCES ='"+cNproc412+"' and  PBY_NUMCOM ='"+cNCompP412+"' "
   //(cNCab412,cNproc412,cNCompP412)

   If Select((cAliastmp)) <> 0
      (cAliastmp)->(DbCloseArea())
   Endif

   TCQuery cQuery New Alias (cAliastmp)

   (cAliastmp)->( DbGoTop() )
   ret:= ((cAliastmp)->NUMMAX+1)
   (cAliastmp)->(DbCloseArea())

Return( ret )

////////////////////////////////////
Static Function fDeleta()
// VERIFICAR A EXCLUSAO NAO ESTA FUNCIONANDO ALTAMIRO - 07/08/2021
   local lFaz   := .T.
   local cParel := '0'
   local origem := Iif(PBY->PBY_LTITPG== .T., 'PGT', 'REC') 
   Local x := 0  

   If !fValBx( origem )
      If origem == 'PGT'
         MsgAlert("Onus com Baixa Financeiro ou esta em bordero , Não Pode ser APAGADO !!! - Favor Verificar  ","Atencao!")
      Else
         MsgAlert("Onus com Baixa Financeiro ou esta em bordero , Não Pode ser APAGADO !!! - Favor Verificar  ","Atencao!")
      EndIf
      lFaz := .F.
      x:= cQtdaParc
      Return()
   EndIf

   If ApMsgYesNo("Deseja excluir o Registro. Deseja excluir","SIMNAO")

      If (!PBY->PBY_LTITPG .and. !PBY->PBY_LTITRC)

         PBY->(RecLock("PBY",.F.))
         PBY->(DbDelete())
         PBY->(MsUnlock())

      ElseIf (pby->pby_parcpg == '0' .or. pby->pby_parcrc == '0') .and. (PBY->PBY_LTITPG .OR. PBY->PBY_LTITRC)

         For x:=1 to cQtdaParc

            If !Empty(nTpOnus)

               cParcPg:= aParcela[x]

               If !fValBx( 'PGT' )
                  MsgAlert("Onus com Baixa Financeiro ou esta em bordero , Não Pode ser APAGADO !!! - Favor Verificar  ","Atencao!")
                  lFaz := .F.
                  x:= cQtdaParc
               EndIf

            ElseIf !Empty(nTpRepas)

               cParcRec:= aParcela[x]

               If !fValBx( 'REC' )
                  MsgAlert("Repasae com Baixa Financeiro ou esta em bordero , Não Pode ser APAGADO !!! - Favor Verificar  ","Atencao!")
                  lFaz := .F.
                  x:= cQtdaParc
               EndIf

            EndIf
         Next

         If lFaz == .F.
            MsgAlert("Ha Tiutlos na Compossição que sofrerao baixa  !!! - Compossição nao pode ser Excluida","Atencao!")
         Else
            MsgAlert("Onus  APAGADO com Sucesso  !!! - Email Informando Exclução sera Emitido","Atencao!")

            Dbselectarea("PBY")
            If !empty(nTpOnus)
               PBY->(DbSetOrder(2)) // 3
            ElseIf !empty(nTpRepas)
               PBY->(DbSetOrder(3))  // 4
            EndIf

            For x:=0 to cQtdaParc
                cParel:= Iif(x == 0 , '0' , aParcela[x])
                              
                If !Empty(nTpOnus)
                  If !DbSeek(xFilial("PBY")+str(cidonus,6,0)+str(nNumCab,6,0)+cNumproc+cNumComPr+cPrefPg+cTitPg+cParel+cTipoPg+cFornec)
                     MsgAlert("Não è possivel excluir titulo , Titulo de Onus  NÃO encontrado , Não Pode ser APAGADO !!! - Favor Verificar  ","Atencao!")
                  EndIf
               ElseIf !Empty(nTpRepas)
                  if !DbSeek(xFilial("PBY")+str(cidonus,6,0)+str(cNumCab,6,0)+cNumproc+cNumComPr+cPrefRec+cTitRec+cParel+cTipoRec+cClient)
                     MsgAlert("Não è possivel excluir titulo , Titulo NÃO de Repase encontrado , Não Pode ser APAGADO !!! - Favor Verificar  ","Atencao!")
                  EndIf
               EndIf
               PBY->(RecLock("PBY",.F.))
               PBY->(DbDelete())
               PBY->(MsUnlock())

               If PBY->PBY_LTITPG // .and. x != '0'

                  dbselectarea("SE2")
                  dbsetorder(1)

                  If dbSeek(xFilial("SE2")+cPrefPg+cTitPg+cParel+cTipoPg+cFornec)
                     SE2->(RecLock("SE2",.F.))
                     SE2->(DbDelete())
                     SE2->(MsUnlock())
                  EndIf

               ElseIf PBY->PBY_LTITRC // .and. x != '0'

                  dbselectarea("SE1")
                  dbsetorder(1)

                  If 	dbSeek(xFilial("SE1")+cPrefRec+cTitRec+cParel+cTipoRec)
                     SE1->(RecLock("SE1",.F.))
                     SE1->(DbDelete())
                     SE1->(MsUnlock())
                  EndIF

               EndIF

            NexT

         EndIf
      Else
         MsgAlert("Não è possivel excluir titulo de parcela da compossição, repesentado pela parcela (0), Não Pode ser APAGADO !!! - Favor Verificar  ","Atencao!")
      EndIf

   EndIf

   oDlg4122:End()

Return()

////////
Static Function  fEnmail(cOrigem , cCart , cPpref         , cNum            , cParc           , cTipo           , cCodCF          , cLoja   , cNomCF  ,dDtcenc          , nVlr )
    
   Local aArea      := GetArea() //Armazena a Area atual
   Local _cMensagem := ""   
   local cDest      := "clarissa.santos@caberj.com.br,altamiro@caberj.com.br, alan.jefferson@caberj.com.br "   
   local cAssunt    := ' '
   local ccCC       := ' '
   LOCAL cTpAçao    := ' '

   if cOrigem ==  'INC'
      cTpAçao    := 'Inclusão'
   Elseif cOrigem ==  'ALT'
      cTpAçao    := 'Alteração'
   Elseif cOrigem ==  'AJT'
      cTpAçao    := 'Atualização Monetaria '
   EndIf

   _cMensagem := Chr(10) + Chr(13) + Chr(10) + Chr(13)
   _cMensagem += Chr(13) + Chr(10) +Chr(13) + Chr(10) + "Prezados, em  " + DtoC( Date() ) + ' - ' + alltrim(time())
 
   If cOrigem=="INC"

      if cCart == 'REC'

         cAssunt := 'Inclusao de Titlos de Repase - Contas a Receber - '+  cPpref+ cNum + cParc+cTipo
      else
         cAssunt := 'Inclusao de Titlos de Onus - Contas a Pagar - '+  cPpref+ cNum + cParc+cTipo
      EndIf

   ElseIf cOrigem=="AJT"

      if cCart == 'REC'

         cAssunt := 'Atualização monetaria do Titlos de Repase - Contas a Receber - '+  cPpref+ cNum + cParc+cTipo
      else
         cAssunt := 'Atualização monetaria do Titlos de Onus - Contas a Pagar  - '+  cPpref+ cNum + cParc+cTipo
      EndIf


   ElseIf cOrigem=="ALT"

      if cCart == 'REC'
         cAssunt := 'Alteração de Titlos de Repase - Contas a Receber - '+  cPpref+ cNum + cParc+cTipo
      else
         cAssunt := 'Alteração de Titlos de Onus - Contas a Pagar  - '+  cPpref+ cNum + cParc+cTipo
      EndIf
   ElseIf cOrigem=="DEL"
      if cCart = 'REC'
         cAssunt := 'Exclução de Titlos de Repase - Contas a Receber - '+  cPpref+ cNum + cParc+cTipo
      else
         cAssunt := 'Exclução de Titlos de Onus - Contas a Pagar  - '+  cPpref+ cNum + cParc+cTipo
      EndIf
   EndIf

   _cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) + " Processo Num : " + str(cNumCab,6,0) + " - " + cNumproc + " - " + cNumComPr

   if lGTitPag
      a:='B'
   EndIf
 
   If cOrigem=="INC"
      if cCart == 'REC'
         _cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +  " Foi Gerado o Titulo no Contas a Receber , Conforme Relatado abaixa "
      Else
         _cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +  " Foi Gerado o Titulo no Contas a Pagar  , Conforme Relatado  abaixa "
      EndIf

   ElseIf cOrigem=="AJT"

      if  cCart == 'REC'
         _cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +  " Foi Atualizado Monetariamente  o Titulo no Contas a Receber , Conforme Relatado abaixa "
      Else
         _cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +  " Foi Atualizado Monetariamente o Titulo no Contas a Pagar  , Conforme Relatado  abaixa "
      EndIf
   EndIf

   _cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +   " Prefixo          : " + cPpref
   _cMensagem +=  Chr(13) + Chr(10) +   " Numero           : " + cNum
   _cMensagem +=  Chr(13) + Chr(10) +   " Parcela          : " + cParc
   _cMensagem +=  Chr(13) + Chr(10) +   " Tipo             : " +  cTipo
   if cCart == 'REC'
      _cMensagem +=  Chr(13) + Chr(10) +  " Cliente           : " +  cCodCF
      _cMensagem +=  Chr(13) + Chr(10) +  " Nome Cliente      : " +  cNomCF
   else
      _cMensagem +=  Chr(13) + Chr(10) +  " Fornecedor        : " +  cCodCF
      _cMensagem +=  Chr(13) + Chr(10) +  " Nome Forncecedor  : " +  cNomCF
   EndIf
   _cMensagem +=  Chr(13) + Chr(10) +   " Vencimento       : " + substr(dtos(dDtcenc),7,2)+'/'+substr(dtos(dDtcenc),5,2)+'/'+substr(dtos(dDtcenc),1,4)
   _cMensagem +=  Chr(13) + Chr(10) +   " Valor            : " + transform(nVlr,"@E 999,999,999.99")

   If cOrigem=="AJT"
      if cCart == 'REC'
         _cMensagem +=  Chr(13) + Chr(10) +   " Atualização Monetaria: " + transform(se1->e1_acresc ,"@E 999,999,999.99")
      Else
         _cMensagem +=  Chr(13) + Chr(10) +   " Atualização Monetaria: " + transform(se2->e2_acresc ,"@E 999,999,999.99")
      EndIf
   EndIf

    _cMensagem +=  Chr(13) + Chr(10) +  cObsOnus
  
   _cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +  "Para ciência e providências. "
   _cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +  " Usuario que Comando a Ação de "+cTpAçao + " foi " + cUsu410
   _cMensagem +=  Chr(13) + Chr(10) +Chr(13) + Chr(10) +Chr(13) + Chr(10) +  " * NÃO responda este Email , Email  automatico "
   _cMensagem +=  Chr(13) + Chr(10) +  " "

   EnvEmail1( _cMensagem , cDest , cAssunt , ccCC)

   RestArea(aArea)

Return (.T.)

static function fMPBWVar()
   
   local cAliastmp  := GetNextAlias()   
   local cQuery     := " "

   cQuery := "select PBW_NUMPRO , PBW_PROCES , PBW_NUMCOM , PBW_TPAUTO , PBW_TPACAO , PBW_DTRECB , PBW_HRRECB , PBW_ASSPRO "
   cQuery += CRLF+ " from  " + RetSqlName("PBW") +" PBW "
   cQuery += CRLF+ " where PBW_filial = '"+xFilial('PBW')+ "' and PBW.d_E_L_E_T_ = ' ' "
   cQuery += CRLF+ " and PBW_NUMPRO = "+ str(cNCab412,6,0) +"  and  PBW_PROCES ='"+cNproc412+"' and  PBW_NUMCOM ='"+cNCompP412+"' "

   If Select((cAliastmp)) <> 0
      (cAliastmp)->(DbCloseArea())
   Endif

   TCQuery cQuery New Alias (cAliastmp)

   (cAliastmp)->( DbGoTop() )


   nNumCab  := (cAliastmp)->PBW_NUMPRO
   cNumproc := (cAliastmp)->PBW_PROCES
   cNumCompP:= (cAliastmp)->PBW_NUMCOM
   cTpAut   := (cAliastmp)->PBW_TPAUTO
   cTpProc  := (cAliastmp)->PBW_TPACAO
   dDtRecPro:= stod((cAliastmp)->PBW_DTRECB)
   cHoraRec := (cAliastmp)->PBW_HRRECB
   cAssAud  := (cAliastmp)->PBW_ASSPRO

   (cAliastmp)->(DbCloseArea())

   fConsMult(1)

Return

static function fConsMult(idM)

   local lret := .F.

   cQuery := "Select  pe6_idmult  idmult , nvl(trim(pe6_numgui), '000001') numgui , pe6_dtcons dtcons,  pe6_dt1par dt1par, Pe6_QTDTPR QTDTPR , PE6_tconso tconso , PE6.R_E_C_N_O_ PE6REC "
   cQuery += CRLF+ " from  " + RetSqlName("PE6") +" PE6 "
   cQuery += CRLF+ " where PE6_filial = '"+xFilial('PE6')+ "' and PE6.d_E_L_E_T_ = ' ' "
   cQuery += CRLF+ " and PE6_NUMPRO = "+ str(cNCab412,6,0) +"  and  PE6_PROCES ='"+cNproc412+"' and  PE6_NUMCOM ='"+cNCompP412+"' "

   If Select((cAliastmp1)) <> 0
      (cAliastmp1)->(DbCloseArea())
   Endif

   TCQuery cQuery New Alias (cAliastmp1)

   (cAliastmp1)->( DbGoTop() )

   If idM == 1

      If (cAliastmp1)->idmult <> ' '  .and. cidonus == 1

         If ApMsgYesNo(" Processo com Multa ANS/AGU , Deseja Usar os dados da multa cadastrados ??","SIMNAO")
            lMUlta      :=.T.
            cIdentOnus  :=  (cAliastmp1)->idmult
            cQtdaParc   :=  alltrim(str((cAliastmp1)->QTDTPR))
            nClasseOnu	:=  "ANS C/P"
            nParcela    := 'Sim'
            cNomFornec  := 'AGENCIA NACIONAL DE SAUDE SUPLEMENTAR   '
            cPrefPg     := 'RPD'
            cTitPg      := (cAliastmp1)->Numgui 
            cParcPg     := '0'
            cTipoPg     := 'FT'
            dDtVencPg   := stod((cAliastmp1)->dt1par)
            nVlrPgt     := (cAliastmp1)->TCONSO
            lGTitPag    :=.T.
            cObsOnus    := "Preenchimentos automaticamente com dados Do cadastro de multas - Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF 
            nTpOnus     := 'Multas'
            If  cempant  =='01'
               cFornec  := '000142'
            Else
               cFornec  := '125413'
            EndIf
            nRecPe6      := (cAliastmp1)->PE6REC
         EndIf

      EndIf

   EndIf

   If idM == 2

      If (cAliastmp1)->idmult <> ' '

         lret := .T.

      Else

         MsgAlert("NÃO podemos lançar titulo de multa e NÃO tipificar como multa , Favor Revisar !!! - Favor Revisar !!!","Atencao!")

         lret := .F.

      EndIf

   EndIf
   (cAliastmp1)->(DbCloseArea())

Return()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validar Codigo do custo de custo                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fConsSa(IdTit, TpCons)
   If TpCons == 'PGTO'

      cFornec   := substr(IdTit,1,6)
      cNomFornec:= substr(IdTit,7,40)

      oGet1:refresh()
      oGet11:refresh()

   Else

      cClient   := substr(IdTit,1,6)
      cnomcli   := substr(IdTit,7,40)

      oGet4:refresh()
      oGet5:refresh()

   EndIf
   
Return()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validar Codigo do custo de custo                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fConsSe(IdTit, TpCons)

   If Empty(IdTit)
      If TpCons == 'PGTO'
         oCBox2:enable()
      else
         oCBox4:enable()
      EndIf
   else
      If TpCons == 'PGTO'
         dbselectarea("SE2")
         dbsetorder(1)
         If dbseek(xFilial("SE2")+TRIM(IdTit))
            lGTitPag:=.F.
            oCBox2:disable()
            cPrefPg:=SE2->E2_PREFIXO
            cTitPg:=SE2->E2_NUM
            cParcPg:=SE2->E2_PARCELA
            cTipoPg:=SE2->E2_TIPO
            cFornec:=SE2->E2_FORNECE
            cNomFornec:=SE2->E2_NOMFOR
            dDtVencPg:=SE2->E2_VENCREA
            nVlrPgt:=SE2->E2_VALOR
            nVlracresP:= SE2->E2_ACRESC

         Else

            oCBox2:enable()

         EndIf

         oGet25:Refresh()
         oVlronus1:Refresh()
         oDtOnus1:Refresh()
         oCBox3:Refresh()
         oGet28:Refresh()
         oGet1:Refresh()
         oGet3:Refresh()
         oGet11:Refresh()
         oCBox2:Refresh()
         oGet13:Refresh()
         oGet14:Refresh()

      EndIf

      If TpCons == 'RECB'
         dbselectarea("SE1")
         dbsetorder(1)
         If dbseek(xFilial("SE1")+TRIM(IdTit))

            lGTitRec:=.F.
            oCBox4:disable()
            cPrefRec:=SE1->E1_PREFIXO
            cTitRec:=SE1->E1_NUM
            cParcRec:=SE1->E1_PARCELA
            cTipoRec:=SE1->E1_TIPO
            cClient:=SE1->E1_CLIENTE
            cNomClient:=SE1->E1_NOMCLI
            dDtVencRec:=SE1->E1_VENCREA
            nVlrRec:=SE1->E1_VALOR
            nVlAcresR:=SE1->E1_ACRESC
            oGet25:lReadOnly:=.F.
            oVlronus1:lReadOnly:=.F.
            oDtOnus1:lReadOnly:=.F.
            oCBox3:lReadOnly:=.F.
            oGet28:lReadOnly:=.F.
            oGet1:lReadOnly:=.F.
            oGet3:lReadOnly:=.F.
            oGet11:lReadOnly:=.F.
            oCBox2:lReadOnly:=.F.
            oGet13:lReadOnly:=.F.
            oGet14:lReadOnly:=.F.

         Else

            oCBox4:enable()

         EndIf

         oGet26:Refresh()
         oGet16:Refresh()
         oGet15:Refresh()
         oGet29:Refresh()
         oGet7:Refresh()
         oGet6:Refresh()
         oGet5:Refresh()
         oGet4:Refresh()
         oGet2:Refresh()

      EndIf

   EndIf

Return()


static function fvalAtMon(opcao)

   If opcao== 'Sim'

      If !empty(nTpOnus)
         fValBx( 'PGT' )
      ElseIf !empty(nTpRepas)
         fValBx( 'REC' )
      EndIf

      oGet18:ENABLE()
      oGet19:ENABLE()
      oGet20:ENABLE()
   ElseIf opcao== 'Nao'
      oGet18:DISABLE()
      oGet19:DISABLE()
      oGet20:DISABLE()
      //   oGet20:SetFocus()
   Else
      oCBox8:SetFocus()
   endIf

Return()

static function fvalAtMon1()

   If lFazAtu =='F'

      if _cIdUsuar $ cAlcadaN1

         If nValorN1 < Val(nVlrAtual)

            MsgAlert("Valor Acrescimo  Acima do Limite deste Usuario !!! - Favor Solicitar ao Superior","Atencao!")

            nVlrAtual:= 0.00

            oGet2:Refresh()

            oGet19:SetFocus()

         endIf

      ElseIf _cIdUsuar $ cAlcadaN2

         If nValorN2 < val(nVlrAtual)

            MsgAlert("Valor Digita Acima do Limite deste Usuario !!! - Favor Solicitar ao Superior","Atencao!")

            nVlrAtual:= 0.00

            oGet2:Refresh()

            oGet19:SetFocus()

         endIf

      ElseIf _cIdUsuar $ cAlcadaN3

         If nValorN3 < VAL(nVlrAtual)

            MsgAlert("Valor Digita Acima do Limite deste Usuario !!! - Favor Atualizar Valor junto a TI","Atencao!")

            nVlrAtual:= 0.00

            oGet2:Refresh()

            oGet19:SetFocus()

         endIf

      EndIf

   EndIf
Return()

static function fValTit(Tpacao)

   If !Empty(cidfinan) .and. Tpacao== 'PAGTO'
      oCBox2:disable()
   endIf
   If !Empty(cIdTitRep).and. Tpacao== 'RECB'
      oCBox4:disable()
   endIf

Return()



static function fValGTit(Tpacao)
   If Tpacao== 'PAGTO'
      If lGTitPag
         oGet3:disable()
      Else
         oGet3:enable()
      EndIf
   EndIf
   If Tpacao== 'RECB'
      If lGTitRec
         oGet7:disable()
      Else
         oGet7:enable()
      EndIf
   endIf

Return()

static function fMArqVar()

   cAssAud     :=  PBY_ASSAUD
   cClient     :=  PBY_CODCLI
   cFornec     :=  PBY_CODFOR
   cNumGuia    :=  PBY_IDGUIA
   cHoraRec    :=  PBY_HRREC
   cIdentOnus  :=  PBY_IDENTO
   cidonus     :=  PBY_IDACPR
   cNomClient  :=  PBY_NOMCLI
   cNomFornec  :=  PBY_NOMFOR
   cNumCompP   :=  PBY_NUMCOM
   cQtdaParc   :=  PBY_QTDPAR
   cTitPg      :=  PBY_TITPGT
   cNumproc    :=  PBY_PROCES
   cTitRec     :=  PBY_TITREC
   cObsOnus  	:=  PBY_OBSONS
   cParcPg     :=  PBY_PARCPG
   cParcRec    :=  PBY_PARCRC
   cPrefPg     :=  PBY_PREFPG
   cPrefRec    :=  PBY_PREFRC
   cTpAut      :=  PBY_TPAUTO
   cTpProc     :=  PBY_TPPROC
   dDtAtuali   :=  PBY_DTATUA
   dDtRecPro   :=  PBY_DTRECP
   dDtVencPg   :=  PBY_DTVPAG
   dDtVencRec  :=  PBY_DTVREC
   lGTitPag    :=  PBY_LTITPG
   lGTitRec   	:=  PBY_LTITRC
   nAtuMonet	:=  PBY_ATUMON
   nClasseOnu	:=  PBY_CLSONU
   nTpRepas	   :=  PBY_TITRPS
   nNumCab     :=  PBY_NUMPRO
   nParcela	   :=  PBY_PARCEL
   npercent    :=  PBY_PRECAT
   cTipoPg   	:=  PBY_TIPOPG
   cTipoRec  	:=  PBY_TIPORC
   nTpOnus   	:=  trim(PBY_TPONUS)
   nVlracresP  :=  PBY_VLACPG
   nVlAcresR   :=  PBY_VLACRC
   nVlrAtual   :=  PBY_VLACAT
   nVlrPgt     :=  PBY_VLONUS
   nVlrRec     :=  PBY_VLRREC
   //         PBY_DTPGTO
   //         PBY_DTREC

Return()

static function fMVarArq(ParcSN,nParc)

    //  If empty(dDtAtuali)
     //    dDtAtuali := Date()
     // EndIf

   PBY_ASSAUD	:= cAssAud
   PBY_CODCLI 	:= cClient
   PBY_CODFOR	:= cFornec
   PBY_IDGUIA	:= cNumGuia
   PBY_HRREC	:= cHoraRec
   PBY_IDENTO 	:= cIdentOnus
   PBY_IDACPR 	:= cidonus
   PBY_NOMCLI	:= cNomClient
   PBY_NOMFOR	:= cNomFornec
   PBY_NUMCOM	:= cNumCompP

   If ValType(cQtdaParc) == "N"
      PBY_QTDPAR	:= cQtdaParc
   Else
      PBY_QTDPAR	:= val(strzero(val(cQtdaParc),2))
   EndIf
   PBY_TITPGT	:= cTitPg
   PBY_PROCES 	:= cNumproc
   PBY_TITREC	:= cTitRec
   

   If nParc > 0

      If !empty(nTpOnus)
         PBY_PARCPG	:= aParcela[nParc]
         PBY_VLONUS	:= (nVlrPgt / (val(strzero(val(cQtdaParc),2))))
         PBY_DTVPAG	:= fCaldt(dDtVencPg,nParc)


         //If PBY_PARCPG == '1'
         If PBY_PARCPG == aParcela[(val(strzero(val(cQtdaParc),2)))]
            PBY_VLONUS +=  nVlrPgt - (PBY_VLONUS * val(strzero(val(cQtdaParc),2)))
         EndIf
      Else
         PBY_PARCRC	:= aParcela[nParc]
         PBY_VLRREC := (nVlrRec / (val(strzero(val(cQtdaParc),2))))
         PBY_DTVREC	:= fCaldt(dDtVencRec,nParc)
         //If PBY_PARCRC == '1'
         If PBY_PARCRC == aParcela[(val(strzero(val(cQtdaParc),2)))]
            PBY_VLRREC +=  nVlrRec - (PBY_VLRREC * val(strzero(val(cQtdaParc),2)))
         EndIf
      EndIF

   Else

      PBY_VLONUS	:= nVlrPgt
      PBY_VLRREC 	:= nVlrRec
      PBY_PARCPG	:= cParcPg
      PBY_PARCRC	:= cParcRec
      PBY_DTVPAG	:= dDtVencPg
      PBY_DTVREC	:= dDtVencRec

   EndIf

   If !empty(nTpOnus) .and.  (nAtuMonet == 'Sim'  .or.   nVlracresP != nVlrAtual)


      //      If empty(dDtAtuali)
      //         dDtAtuali := Date()
      //      EndIf

      if nVlracresP != nVlrAtual

         iF lFazAtu =='T'

            nVlrPgt    += nVlrAtual
            nVlracresP := nVlrAtual

         ELSE

            nVlrPgt    += nVlrAtual
            nVlracresP := nVlrAtual

         EndIf

      ElseIf npercent > 0

         nVlrPgt    += ((nVlrPgt * npercent)/100)
         nVlracresP := ((nVlrPgt * npercent)/100)

      Else

         MsgAlert("Não ha valores a serem atualizados  !!! - Favor Verificar ","Atencao!")

      EndIf

      PBY_VLONUS := nVlrPgt

   ElseIf !empty(nTpRepas) .and.  (nAtuMonet == 'Sim'  .or.   nVlAcresR != nVlrAtual)

      //      If empty(dDtAtuali)
      //         dDtAtuali := Date()
      //      EndIf

      if nVlAcresR != nVlrAtual

         If lFazAtu =='T'

            nVlrRec   += nVlrAtual
            nVlAcresR := nVlrAtual

         Else

            nVlrRec   += nVlrAtual
            nVlAcresR := nVlrAtual

         Endif


      ElseIf npercent > 0

         nVlrRec   += ((nVlrRec * npercent)/100)
         nVlAcresR := ((nVlrRec * npercent)/100)

      Else

         MsgAlert("Não ha valores a serem atualizados  !!! - Favor Verificar ","Atencao!")

      EndIf

      PBY_VLRREC := nVlrRec

   EndIf


   PBY_PREFPG	:= cPrefPg
   PBY_PREFRC	:= cPrefRec
   PBY_TPAUTO	:= cTpAut
   PBY_TPPROC	:= cTpProc

   If ValType(dDtAtuali) == "C"
      PBY_DTATUA	:= stod(dDtAtuali)
   Else
      PBY_DTATUA	:= dDtAtuali //stod(dDtAtuali)
   EndIf

   PBY_DTRECP	:= dDtRecPro

   PBY_LTITPG	:= lGTitPag
   PBY_LTITRC	:= lGTitRec
   PBY_ATUMON	:= nAtuMonet
   PBY_CLSONU	:= nClasseOnu
   PBY_TITRPS	:= nTpRepas
   PBY_NUMPRO	:= nNumCab
   PBY_PARCEL	:= nParcela
   PBY_PRECAT	:= npercent
   PBY_TIPOPG	:= cTipoPg
   PBY_TIPORC	:= cTipoRec
   PBY_TPONUS 	:= nTpOnus


   IF !EMPTY(PBY_VLACAT)
      PBY_VLACPG	+= nVlracresP

   Else 
      PBY_VLACPG	:= nVlracresP   
   EndIf    
   
   IF !EMPTY(PBY_VLACRC)  
       PBY_VLACRC	+= nVlAcresR
   ELSE 
       PBY_VLACRC := nVlAcresR
   ENDIF

   IF !EMPTY(PBY_VLACAT)  
       PBY_VLACAT	+= nVlrAtual
   ELSE 
       PBY_VLACAT	:= nVlrAtual
   ENDIF

      //PBY_DTPGTO	:=
   //PBY_DTREC	:=

   If lFazAtuaut =='F' .and. lFazAtu =='T' 
       cObsOnus +=  CRLF + "--> Valor R$"+transform(nVlrAtual,"@E 9,999.99")+" - Atualizado Pelo Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF + CRLF
   EndIf
   
   PBY_OBSONS 	:= cObsOnus

Return()

Static Function fParc_s_n(cPartcela)

   if cPartcela == 'Nao'

      npercent := 0.00
      nVlrAtual:= 0.00
      cNumGuia:= '          '
      dDtAtuali:= '  /  /  '
      nAtuMonet:= ' '

      oGet17:Disable()
   
      oVlrOnus1:lReadOnly := .F.
      oGet25:lReadOnly    := .F.
      oDtOnus1:lReadOnly  := .F.
      oCBox2:lReadOnly    := .F.

      oGet5:lReadOnly     := .F.
      oGet6:lReadOnly     := .F.
      oGet7:lReadOnly     := .F.
      oCBox4:lReadOnly    := .F.

      oTpOnus1:SetFocus()

   Else

      oGet17:Enable()
      oCBox8:Enable()
      oGet18:Enable()
      oGet19:Enable()
      oGet20:Enable()
      oGet27:Enable()

      oGet25:lReadOnly    := .F.
      oDtOnus1:lReadOnly  := .F.
      oCBox2:lReadOnly    := .F.

      oGet5:lReadOnly     := .F.
      oGet6:lReadOnly     := .F.
      oGet7:lReadOnly     := .F.
      oCBox4:lReadOnly    := .F.

      oGet17:SetFocus()

   EndIf

Return()

static function fTpRepas(nTpRepas)
   If !empty(nTpRepas)
      cPrefRec := 'JUD'
      cTitRec  :=  fNumtit('REC' , 'JUD')
      cParcRec := '0'
      cTipoRec := 'DP'

      oGet26:Refresh()
      oGet16:Refresh()
      oGet15:Refresh()
      oGet29:Refresh()
      oCBox4:enable()
      oTpOnus1:lActive:=.F.
      oGet4:SetFocus()
   Else
      oTpOnus1lActive:=.T.
   EndIf

Return()

static function fPTOnus(nTpOnus)

   if !empty(nTpOnus)
      cPrefPg := 'RPD'
      cTitPg  := fNumtit('PGT' , 'RPD')
      cParcPg := '0'
      cTipoPg := 'FT'

      oGet3:refresh()
      oGet13:refresh()
      oGet14:refresh()
      oget28:refresh()
      oCBox2:enable()
      oCBox3:lActive:=.F.
      oGet1:SetFocus()
   Else
      oCBox3:lActive:=.T.
   EndIf

return

Static Function fNumtit(ORIGEM , PREFIXO)
   
   local cAliastmp      := GetNextAlias()
   Private cQuery       := " "



   cQuery := "select
   If origem =='PGT'
      cQuery += CRLF+ " NVL(MAX(E2_NUM),'') NUMTIT from  " + RetSqlName("SE2") +" SE2 "
      cQuery += CRLF+ " where E2_filial = '"+xFilial('SE2')+ "' and d_E_L_E_T_ = ' ' AND E2_PREFIXO = 'JUD' "

   ElseIf origem =='REC'
      cQuery += CRLF+ " NVL(MAX(E1_NUM),'') NUMTIT  from  " + RetSqlName("SE1") +" SE1 "
      cQuery += CRLF+ " where E1_filial = '"+xFilial('SE1')+ "' and d_E_L_E_T_ = ' ' AND E1_PREFIXO = 'JUD' "
   EndIf

   If Select((cAliastmp)) <> 0
      (cAliastmp)->(DbCloseArea())
   Endif

   TCQuery cQuery New Alias (cAliastmp)

   If  trim((cAliastmp)->NUMTIT) == ''

      NUMTIT :='0'

   EndIF

   NUMTIT :=strzero(val((cAliastmp)->NUMTIT)+1,9)

   NUMTIT :='0'

return(NUMTIT)

static function fCritParc(nParcela, cQtdaParc )

   If nParcela == 'Sim'
      If (trim(cQtdaParc) == '' .or. trim(cQtdaParc) == '0' .or. trim(cQtdaParc) == '00')
         MsgAlert("Indicado parcelamento , Mas numero de paracela esta zero ou banco","Atencao!")
         oCBox7:SetFocus()
      ElseIf val(cQtdaParc) > 66
         MsgAlert("Quantidade de parcelas superior ao permitido , que e 66","Atencao!")
         cQtdaParc:= '00'
         oGet17:refresh()
         oCBox7:SetFocus()
      EndIf
   EndIF

Return


   static function VerVlrPar(cNumpar, cVlrTot)

   return(cNumPar)



   static function fCaldt(dtaux,nParc)

      local cdata := dtoS(dtaux)

      If EMPTY(AnoV)
         AnoV   := substr(cdata,1,4)
         MesV   := substr(cdata,5,2)
         DiaV   := substr(cdata,7,2)
         DiaO   := substr(cdata,7,2)
      
      Else
      
         If MesV == '12'

            AnoV :=  strzero((val(AnoV)+1),4)
            MesV := '01
            '
            If   val(DiaO) > 31 
                 DiaV := '31'
            Else 
                 DiaV := DiaO
            EndIF     

         ElseIf  MesV == '01'
            
            If   val(DiaO) > 28 
                 DiaV := '28'
            Else 
                 DiaV := DiaO
            EndIF     
            
               MesV := strzero((val(MesV)+1),2)

         ElseIf  MesV $ '03|05|07|08|10'

            If   val(DiaO) > 30 
                 DiaV := '30'
            Else 
                 DiaV := DiaO
            EndIF     
            
            
            MesV := strzero((val(MesV)+1),2)

         ElseIf  MesV $ '02|04|06|09|11'

            If   val(DiaO) > 31 
                 DiaV := '31'
            Else 
                 DiaV := DiaO
            EndIF     

            MesV := strzero((val(MesV)+1),2)

         EndIF
      EndIF
      
      dDatNova:= DataValida(stod(AnoV+MesV+DiaV),.F.)

   return(dDatNova)

   Static Function fValBx( ORIGEM )

      local lRet:=.T.
      local cAliastmp      := GetNextAlias()
      Private cQuery       := " "

      cQuery := "select
      If origem =='PGT'

         cQuery += CRLF+ " nvl(e2_baixa, ' ') bx, nvl(e2_saldo,0) sald , nvl(e2_numbor,' ') numbor from  " + RetSqlName("SE2") +" SE2 "
         cQuery += CRLF+ " where E2_filial = '"+xFilial('SE2')+ "' and d_E_L_E_T_ = ' ' "
         cQuery += CRLF+ " AND E2_PREFIXO  = '"+cPrefPg+"' "
         cQuery += CRLF+ " AND E2_NUM      = '"+cTitPg+"' "
         cQuery += CRLF+ " AND E2_PARCELA  = '"+cParcPg+"' "
         cQuery += CRLF+ " AND E2_TIPO     = '"+cTipoPg+"' "
         cQuery += CRLF+ " AND E2_FORNECE  = '"+cFornec+"' "

      ElseIf origem =='REC'

         cQuery += CRLF+ " nvl(e1_baixa,' ') bx, nvl(e1_saldo,0) sald  , nvl(e1_numbor,' ') numbor from  " + RetSqlName("SE1") +" SE1 "
         cQuery += CRLF+ " where E1_filial = '"+xFilial('SE1')+ "' and d_E_L_E_T_ = ' ' "
         cQuery += CRLF+ " AND E1_PREFIXO = '"+cPrefRec+"' "
         cQuery += CRLF+ " AND E1_NUM     = '"+cTitRec+"' "
         cQuery += CRLF+ " AND E1_PARCELA = '"+cParcRec+"' "
         cQuery += CRLF+ " AND E1_TIPO    = '"+cTipoRec+"' "
         cQuery += CRLF+ " AND E1_CLIENTE = '"+cClient+"' "

      EndIf

      If Select((cAliastmp)) <> 0
         (cAliastmp)->(DbCloseArea())
      Endif

      TCQuery cQuery New Alias (cAliastmp)
      If Select((cAliastmp)) > 0
         If trim((cAliastmp)->bx) == '' .and. trim((cAliastmp)->numbor) == ''
            lRet := .T.
         Else
            lRet := .F.
         EndIF
      Else
         MsgAlert("Titulo nao encontrado no Financeiro !!! - Favor Verificar ","Atencao!")
         lRet := .F.
      EndIf

   Return( lRet )
   /////////////////////////////
   Static Function fGrPgtoRec()

      local aDadosTit := {}      
      local cNatPG  := '218801'
      local cNatREC := '218801'
      local cHistor := 'Tit Automatico Gerado '
      local clojaF  := POSICIONE("SA2",1,xFilial("SA2")+cFornec,"A2_LOJA")
      local clojaC  := POSICIONE("SA1",1,xFilial("SA1")+cFornec,"A1_LOJA")


      If (SubStr(cNumEmp,1,2) == "01")
         cCusto := "998"
         cNatPG  := '218801'
         cNatREC := '218801'
      ElseIf (substr(cNumEmp,1,2) == "02")
         cCusto := "99999"
         cNatPG  := '218801'
         cNatREC := '218801'
      EndIf

      If !empty(nTpOnus) .and. lGTitPag

         dbselectArea("SE2")
         dbSetOrder(1)
         If !( dbSeek(xFilial("SE2") + PBY->PBY_PREFPG+;
               PBY->PBY_TITPGT+;
               PBY->PBY_PARCPG+;
               PBY->PBY_TIPOPG+;
               PBY->PBY_CODFOR+;
               clojaF ))

            //   Begin Transaction

            aDadosTit :={{"E2_FILIAL"   ,xFilial("SE2")	         ,.F./*Nil*/},;
               {"E2_PREFIXO"  ,PBY->PBY_PREFPG	      ,.F./*Nil*/},;
               {"E2_NUM"      ,PBY->PBY_TITPGT         ,.F./*Nil*/},;
               {"E2_PARCELA"  ,PBY->PBY_PARCPG         ,.F./*Nil*/},;
               {"E2_TIPO"     ,PBY->PBY_TIPOPG         ,.F./*Nil*/},;
               {"E2_NATUREZ"  ,cNatureza               ,.F./*Nil*/},;
               {"E2_FORNECE"  ,PBY->PBY_CODFOR         ,.F./*Nil*/},;
               {"E2_LOJA"     ,clojaF                  ,.F./*Nil*/},;
               {"E2_EMISSAO"  ,dDataBase               ,.F./*Nil*/},;
               {"E2_VENCTO"   ,PBY->PBY_DTVPAG         ,.F./*Nil*/},;
               {"E2_VENCREA"  ,PBY->PBY_DTVPAG         ,.F./*Nil*/},;
               {"E2_HIST"     ,cHistor                 ,.F./*Nil*/},;
               {"E2_CCD"      ,cCusto                  ,.F./*Nil*/},;
               {"E2_VALOR"    ,PBY->PBY_VLONUS         ,.F./*Nil*/},;
               {"E2_JUROS"    ,PBY->PBY_VLACPG         ,.F./*Nil*/},;
               {"E2_VALJUR"   ,PBY->PBY_VLACPG         ,.F./*Nil*/},;
               {"E2_YNPARCE"  ,strzero(val(PBY->PBY_PARCPG),2) + '/' + strzero(PBY->PBY_QTDPAR,2)  ,.F./*Nil*/}}

            aDadosTit :=fwvetbydic(aDadosTit ,"SE2")

            //               MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aDadosTit ,, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
            MsExecAuto({ |x,y,z| Fina050(x,y,z)},aDadosTit,,3)

            If lMsErroAuto
               //		DisarmTransaction()
               MostraErro()
               Return .F.
            EndIf
            //   End Transaction  */
         EndIf
      ElseIf !empty(nTpRepas) .and. lGTitRec

         If !(dbSeek(xFilial("SE1") + PBY->PBY_PREFRC+;
               PBY->PBY_TITREC+;
               PBY->PBY_PARCRC+;
               PBY->PBY_TIPORC+;
               PBY->PBY_CODCLI+;
               clojaC ))

            //   Begin Transaction
            aAdd(aDadosTit, {"E1_FILIAL"	, XFILIAL("SE1")    , Nil})
            aAdd(aDadosTit, {"E1_PREFIXO"	, PBY->PBY_PREFRC	, Nil})
            aAdd(aDadosTit, {"E1_NUM"		, PBY->PBY_TITREC	, Nil})
            aAdd(aDadosTit, {"E1_PARCELA"	, PBY->PBY_PARCRC	  , Nil})
            aAdd(aDadosTit, {"E1_TIPO"		, PBY->PBY_TIPORC   , Nil})
            aAdd(aDadosTit, {"E1_NATUREZ"	, cNatureza    	  , Nil})
            aAdd(aDadosTit, {"E1_CLIENTE"	, PBY->PBY_CODCLI	  , Nil})
            aAdd(aDadosTit, {"E1_LOJA"		, clojaC 			  , Nil})
            aAdd(aDadosTit, {"E1_EMISSAO"	, dDataBase	        , Nil})
            aAdd(aDadosTit, {"E1_VENCTO"	, PBY->PBY_DTVREC   , Nil})
            aAdd(aDadosTit, {"E1_VENCREA"	, PBY->PBY_DTVREC   , Nil})
            aAdd(aDadosTit, {"E1_VALOR"	, PBY->PBY_VLRREC   , Nil})
            aAdd(aDadosTit, {"E1_PORCJUR"	, PBY->PBY_PRECAT 	, Nil})
            aAdd(aDadosTit, {"E1_JUROS"	, PBY->PBY_VLACRC	, Nil})
            aAdd(aDadosTit, {"E1_HIST"		, cHistor	        , Nil})

            MsExecAuto({|x,y| Fina040(x,y)},aDadosTit,3)

            If lMsErroAuto
               //			DisarmTransaction()
               MostraErro()
               Return .F.
            EndIf
            //	End Transaction


         EndIf
      EndIf

      /////////////////////////////////////////////////////////////////////*
      //FGRVSE2()
   return()

   /////////   FIM

   STATIC FUNCTION FGRVSE()
      
      local cNatPG    := '218801'
      local cNatRC    := '218801'
      local cHistor   := 'Tit Automatico Gerado '
      local clojaF    := POSICIONE("SA2",1,xFilial("SA2")+cFornec,"A2_LOJA")
      local cNomFor   := POSICIONE("SA2",1,xFilial("SA2")+cFornec,"A2_NOME")

      local clojaC    := POSICIONE("SA1",1,xFilial("SA1")+cClient,"A1_LOJA")
      local cNomCLI   := POSICIONE("SA1",1,xFilial("SA1")+cClient,"A1_NOME")
      local cTpPessoa := IIf(POSICIONE("SA2",1,xFilial("SA2")+cFornec,"A2_tipo")=='J','1708','0588')


      If (SubStr(cNumEmp,1,2) == "01")
         cCusto := "998"
         cNatPG    := '218801'
         cNatRC    := '218801'
      ElseIf (substr(cNumEmp,1,2) == "02")
         cCusto := "99999"
         cNatPG    := '218801'
         cNatRC    := '218801'
      EndIf


      If !empty(nTpOnus) .and. lGTitPag


         dbselectArea("SE2")
         dbSetOrder(1)
         If !( dbSeek(xFilial("SE2") + PBY->PBY_PREFPG+;
               PBY->PBY_TITPGT+;
               PBY->PBY_PARCPG+;
               PBY->PBY_TIPOPG+;
               PBY->PBY_CODFOR+;
               clojaF ))


            //      If PBY->PBY_DTVPAG >= dDataBase

            RecLock("SE2",.T.)
            E2_FILIAL   := xFilial("SE2")
            E2_PREFIXO  := PBY->PBY_PREFPG
            E2_NUM      := PBY->PBY_TITPGT
            E2_PARCELA  := PBY->PBY_PARCPG
            E2_TIPO     := PBY->PBY_TIPOPG
            E2_NATUREZ  := cNatureza
            E2_FORNECE  := PBY->PBY_CODFOR
            E2_LOJA     := clojaF
            E2_NOMFOR   := cNomFor
            E2_HIST     := cHistor
            E2_VALOR    := PBY->PBY_VLONUS
            E2_SALDO    := PBY->PBY_VLONUS
            E2_VLCRUZ   := PBY->PBY_VLONUS
            E2_SDACRES  := PBY->PBY_VLACPG
            E2_ACRESC   := PBY->PBY_VLACPG
            E2_VLCRUZ   := PBY->PBY_VLONUS
            E2_ORIGEM   := "CABA412"
            E2_MOEDA    := 1
            E2_YLIBPLS  := "S"
            E2_CCD      := cCusto
            E2_EMISSAO  := dHoje //dDataBase
            E2_VENCTO   := PBY->PBY_DTVPAG
            E2_VENCREA  := PBY->PBY_DTVPAG
            E2_EMIS1    := dHoje //dDataBase
            E2_VENCORI  := PBY->PBY_DTVPAG
            E2_INTERFA  := '2'
            E2_YNPARCE  := strzero(val(PBY->PBY_PARCPG),2) + '/' + strzero(PBY->PBY_QTDPAR,2)
            E2_CODRET   := cTpPessoa
            e2_filorig  := xFilial("SE2") 
            e2_multnat  := '2' 

            Msunlock("SE2")
      
         EndIf    
         se2->(DbCloseArea())
      EndIF  
      
         If PBY->PBY_PREFPG  == 'RPD'

            dbselectArea("PEB")
            dbSetOrder(1)

            If !( dbSeek(PBY->PBY_PREFPG+;
                         PBY->PBY_TITPGT+;
                         PBY->PBY_PARCPG+;
                         PBY->PBY_TIPOPG))
           
               RecLock("PEB",.T.)

                  PEB_FILIAL   := xFilial("PEB")  
                  PEB_DEMAND   := PBY->PBY_PROCES 

                  PEB_PREFIX   := PBY->PBY_PREFPG 
                  PEB_NUM      := PBY->PBY_TITPGT  
                  PEB_PARCEL   := PBY->PBY_PARCPG
                  PEB_TIPO     := PBY->PBY_TIPOPG
                  PEB_FORNEC   := PBY->PBY_CODFOR  
                  PEB_VLRTIT   := 0.00//PBY->PBY_VLONUS  
                  PEB_VLRAJA   := 0.00   
                  PEB_VLRAJD   := 0.00   
                  PEB_DATAAJ   := CtoD("  /  /    ")  
                  PEB_USARAR   := ' ' //_cIdUsuar +' - '+_cUsuario + ' - ' + cDthr  
                  PEB_MODCAL   := cTpcalc   
                  PEB_VENC     := PBY->PBY_DTVPAG // CtoD(SUBSTR(PBY->PBY_DTVPAG,7,2)+'/'+SUBSTR(PBY->PBY_DTVPAG,5,2)+'/'+SUBSTR(PBY->PBY_DTVPAG,1,4))            
                  PEB_PARTOT   := PBY->PBY_QTDPAR
                  
               Msunlock("PEB")
            
            EndIf

         EndIf      
            //fEnmail("INC", "PGT", PBY->PBY_PREFPG, PBY->PBY_TITPGT , PBY->PBY_PARCPG , PBY->PBY_TIPOPG , PBY->PBY_CODFOR , clojaF  , cNomFOR , PBY->PBY_DTVPAG , PBY->PBY_VLONUS)

      

      If !empty(nTpRepas) .and. lGTitRec

         dbselectArea("SE1")
         dbSetOrder(1)
         If !(dbSeek(xFilial("SE1") + PBY->PBY_PREFRC+;
               PBY->PBY_TITREC+;
               PBY->PBY_PARCRC+;
               PBY->PBY_TIPORC+;
               PBY->PBY_CODCLI+;
               clojaC ))
            RecLock("SE1",.T.)

            E1_FILIAL := XFILIAL("SE1")
            E1_PREFIXO:= PBY->PBY_PREFRC
            E1_NUM    := PBY->PBY_TITREC
            E1_PARCELA:= PBY->PBY_PARCRC
            E1_TIPO   := PBY->PBY_TIPORC
            E1_NATUREZ:= cNatureza
            E1_CLIENTE:= PBY->PBY_CODCLI
            E1_NOMCLI := cNomCLI
            E1_LOJA   := clojaC
            E1_EMISSAO:= dHoje //dDataBase
            E1_EMIS1  := dHoje //dDataBase
            E1_VENCTO := PBY->PBY_DTVREC
            E1_VENCREA:= PBY->PBY_DTVREC
            E1_VALOR  := PBY->PBY_VLRREC
            E1_VLCRUZ := PBY->PBY_VLRREC
            E1_SALDO  := PBY->PBY_VLRREC
            E1_ACRESC := PBY->PBY_VLACRC
            E1_SDACRES:= PBY->PBY_VLACRC
            E1_HIST   := cHistor
            E1_ORIGEM := "CABA412"
            E1_CODINT := " "
            E1_CODEMP := " "
            E1_MATRIC := " "
            E1_CONEMP := " "
            E1_VERCON := " "
            E1_SUBCON := " "
            E1_VERSUB := " "
            E1_XNUMNEG:= " "
            E1_ANOBASE:= " "//substr(dDataBase,1,4)
            E1_MESBASE:= " "//substr(dDataBase,5,2)

            E1_SITUACA  := '0'
            E1_MOEDA    := 1
            E1_OCORREN  := '01'
            E1_STATUS   := 'A'
            E1_TIPODES  := '1'
            E1_FILORIG  := '01'
            E1_APLVLMN  := '1'
            E1_FLUXO    := 'S'
            E1_MULTNAT  := '2'
            E1_PROJPMS  := '2'
            E1_DESDOBR  := '2'
            E1_MODSPB   := '1'
            E1_SCORGP   := '2'
            E1_RELATO   := '2'
            E1_TPDESC   := 'C'

            Msunlock("SE1")

           // fEnmail("INC", "REC", PBY->PBY_PREFRC, PBY->PBY_TITREC , PBY->PBY_PARCRC , PBY->PBY_TIPORC , PBY->PBY_CODCLI , clojaC  , cNomCLI , PBY->PBY_DTVREC , PBY->PBY_VLRREC)
         EndIf

         se1->(DbCloseArea())

      EndIf

   RETURN()


   static function fArecpag()
      If nClasseOnu $ "Proc.Internos C/R|Judicial C/R|ANS C/R"
         oTpOnus1:DISABLE()
         oVlrOnus1:DISABLE()
         oDtOnus1:DISABLE()
         oGet3:DISABLE()
         oGet11:DISABLE()
         oCBox2:DISABLE()
         oGet13:DISABLE()
         oGet14:DISABLE()
         oGet28:DISABLE()
         oGet25:DISABLE()
         oGet1:DISABLE()

         oCBox3:enable()
         oCBox4:enable()
         oGet2:enable()
         oGet4:enable()
         oGet5:enable()
         oGet6:enable()
         oGet7:enable()
         oGet29:enable()
         oGet15:enable()
         oGet16:enable()
         oGet26:enable()

         nTpOnus     := ' '
         cPrefPg     := ' '
         cTitPg      := ' '
         cParcPg     := ' '
         cTipoPg     := ' '
         cFornec     := ' '
         cNomFornec  := ' '
         nVlracresP  := 0.00
         nVlrPgt     := 0.00
         dDtVencPg   := CtoD(" ")
         lGTitPag    := .F.

      ElseIf nClasseOnu $ "Proc.Internos C/P|Judicial C/P|ANS C/P"

         oCBox3:DISABLE()
         oCBox4:DISABLE()
         oGet2:DISABLE()
         oGet4:DISABLE()
         oGet5:DISABLE()
         oGet6:DISABLE()
         oGet7:DISABLE()
         oGet29:DISABLE()
         oGet15:DISABLE()
         oGet16:DISABLE()
         oGet26:DISABLE()

         oTpOnus1:enable()
         oVlrOnus1:enable()
         oDtOnus1:enable()
         oGet3:enable()
         oGet11:enable()
         oCBox2:enable()
         oGet13:enable()
         oGet14:enable()
         oGet28:enable()
         oGet25:enable()
         oGet1:enable()

         nTpRepas    := ' '
         cPrefRec    := ' '
         cTitRec     := ' '
         cParcRec    := ' '
         cTipoRec    := ' '
         cClient     := ' '
         cNomClient  := ' '
         nVlAcresR   := 0.00
         nVlrRec     := 0.00
         dDtVencRec  := CtoD(" ")
         lGTitRec   := .F.

      EndIf

   Return()


   *--------------------------------------*
   static Function EnvEmail1( _cMensagem , cDest , cAssunt  , ccCC )
      *--------------------------------------*

      /*Local _cMailServer := GetMv( "MV_WFSMTP" )
Local _cMailConta  := GetMv( "MV_WFAUTUS" )
      Local _cMailSenha  := GetMv( "MV_WFAUTSE" )                        */
      Local _cMailServer := GetMv( "MV_RELSERV" )
      Local _cMailConta  := GetMv( "MV_EMCONTA")
      Local _cMailSenha  := GetMv( "MV_EMSENHA" )

      //Local _cTo  	   := "altamiro@caberj.com.br, paulovasques@caberj.com.br, piumbim@caberj.com.br"
      Local _cTo  	   := trim(cDest) //"altamiro@caberj.com.br , carlaramos@caberj.com.br"
      Local _cCC         := " "//"fabiola.silva@caberj.com.br,carlaramos@caberj.com.br,paulahees.juridico@caberj.com.br"
      //Local _cCC       := trim(GetMv( "MV_MLCPJU" ) ) nao esta carregando pelo paramentro ,


      Local _cAssunto    := cAssunt //" Cadastro de processo  - email Automatico "
      Local _cError      := ""
      Local _lOk         := .T.
      Local _lSendOk     := .F.      

      If !Empty(ccCC)

         _cCC:= ccCC

      EndIf

      If !Empty(_cMailServer) .And. !Empty( _cMailConta  )
         // Conecta uma vez com o servidor de e-mails
         CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk

         If _lOk
            SEND MAIL From _cMailConta To _cTo CC _cCC   Subject _cAssunto Body _cMensagem  Result _lSendOk
            //SEND MAIL From _cMailConta To _cTo /*BCC _cCC  */ Subject _cAssunto Body _cMensagem  Result _lSendOk
         Else
            //Erro na conexao com o SMTP Server
            GET MAIL ERROR _cError
            Aviso( "Erro no envio do E-Mail", _cError, { "Fechar" }, 2 )
         EndIf

         If _lOk
            //Desconecta do Servidor
            DISCONNECT SMTP SERVER
         EndIf
      EndIf
   return()
   ///////////////////////

   //user function fAtMonet()
   static function fAtMonet()

      private cvlratu := 0.00
   
      dbselectArea("SE2")
      dbSetOrder(1)

      If (dbSeek(xFilial("SE2") + PBY->PBY_PREFPG+;
            PBY->PBY_TITPGT+;
            PBY->PBY_PARCPG+;
            PBY->PBY_TIPOPG+;
            PBY->PBY_CODFOR+;
            POSICIONE("SA2",1,xFilial("SA2")+cFornec,"A2_LOJA") ))

         If ApMsgYesNo("Parcelamento ANS ? ","SIMNAO")
            fCalAtuANS(substr(dtos(se2->E2_VENCREA),1,6),se2->E2_PARCELA)
         Else
            fCalAtuAGU(substr(dtos(se2->E2_VENCREA),1,6),se2->E2_PARCELA)
         EndIf
         /// atualização da mullta
/*
         RecLock("SE2",.F.)

         if nVlrAtual > 0

            E2_SDACRES  := nVlrAtual
            E2_ACRESC   := nVlrAtual

         ElseIf npercent > 0

            E2_SDACRES  := ((nVlrPgt * npercent)/100)
            E2_ACRESC   := ((nVlrPgt * npercent)/100)

         EndIf

         Msunlock("SE2")

   

         fEnmail("AJT", "PGT", PBY->PBY_PREFPG, PBY->PBY_TITPGT , PBY->PBY_PARCPG , PBY->PBY_TIPOPG , PBY->PBY_CODFOR ,  SE2->E2_LOJA , SA2->A2_NOME , PBY->PBY_DTVPAG , PBY->PBY_VLONUS)
*/
////////

	if !empty(dDtAtuali)  .and. lAtDt == .T.
		E2_VENCREA  :=  dDtAtuali
	EndIf

Else

	MsgAlert("Titulo no Financeiro Não localizado !!! ","Atencao!")

EndIf

return()

//user function fCalAtu(cCompt1 , cParcela1)
static function fCalAtuANS(cCompt1 , cParcela1)

	local nInd1     := 0
	local nInd2     := 0

	local cJuros    := 1
	local cConta    := 0

	local cPercMes := 0.00
	local cPercTot := 0.00
	local nVlrMAnt := 0.00
	local nVlrAtul := 0.00
	local nVlrCor  := 0.00
	local nVlrTcor := 0.00	

	LOCAL IND  := 0

	//nInd1 := aScan( aCompt, cCompt1 )
	nInd1 := Ascan(aCompt,{ |x| x[1] = cCompt1 })

	If nInd1 > 0

		// orientado pelo Sr Alan que se utiliza a selic do mes anterior
		// ja que a do mes de calculo nao existe (nao publicada)
		// ação documentada por email em 09/08/2021

		nInd1--

		nInd2 := nInd1 - ((aScan(aParcela, cParcela1 )) - 1)

		If nInd2 > 0

			cObsOnus +=  CRLF + "--> Modelo ANS - Atualizado Pelo Sistema -  Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF + CRLF

			For IND  := nInd2 to nInd1

				cConta++

				If cConta <= 3

					cPercMes := 0.00
					cPercTot += cPercMes

					cComptAtl:= aCompt[IND][1]

					nVlrMAnt := Se2->e2_valor
					nVlrAtul := nVlrMAnt+((nVlrMAnt*cPercMes)/100)
					nVlrCor  := (nVlrMAnt*cPercMes ) /100

					nVlrTcor := nVlrAtul - Se2->e2_valor

					//               cObsOnus +=  " Parcela "+ Transform(cConta,"@e 999") +"  Valor Base R$ "  + Transform(Se2->e2_valor,"@e 999,999,999.99") + "Valor Atualizado "+ Transform((Se2->e2_valor + ((Se2->e2_valor*cPerc)/100)),"@e 999,999,999.99") +" Atulização :"+ Transform(cPerc,"@e 999.99")+"% "+CRLF

					cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
						" Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
						" Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
						" Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
						" % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
						" % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
						" Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99") + ;
						" Compt Atual.  "+ cComptAtl + CRLF

				ElseIf cConta == 4

					cPercMes := cJuros
					cPercTot += cPercMes

					cComptAtl:= aCompt[IND][1]

					nVlrMAnt :=  nVlrAtul
					nVlrAtul :=  nVlrMAnt+((nVlrMAnt*cPercMes)/100)
					nVlrCor  :=  (nVlrMAnt*cPercMes) /100

					nVlrTcor := nVlrAtul - Se2->e2_valor

					//               cObsOnus +=  " Parcela "+ Transform(cConta,"@e 999") +"  Valor Base R$ "  + Transform(Se2->e2_valor,"@e 999,999,999.99") + "Valor Atualizado "+ Transform((Se2->e2_valor + ((Se2->e2_valor*cPerc)/100)),"@e 999,999,999.99") +" Atulização :"+ Transform(cPerc,"@e 999.99")+"% "+CRLF
					cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
						" Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
						" Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
						" Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
						" % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
						" % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
						" Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99")      +;
						" Compt Atual.  "+ cComptAtl + CRLF
				Else

					cPercMes := Iif (len(aSelic) > IND ,  aSelic[IND][1]  , 0.00)
					cPercTot += cPercMes

					cComptAtl:= aCompt[IND][1]

					nVlrMAnt := nVlrAtul
					nVlrAtul := nVlrMAnt+((nVlrMAnt*cPercMes)/100)
					nVlrCor  := (nVlrMAnt*cPercMes ) /100
					nVlrTcor := nVlrAtul - Se2->e2_valor


					//               cObsOnus +=  " Parcela "+ Transform(cConta,"@e 999") +"  Valor Base R$ "  + Transform(Se2->e2_valor,"@e 999,999,999.99") + "Valor Atualizado "+ Transform((Se2->e2_valor + ((Se2->e2_valor*cPerc)/100)),"@e 999,999,999.99") +" Atulização :"+ Transform(cPerc,"@e 999.99")+"% "+CRLF
					cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
						" Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
						" Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
						" Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
						" % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
						" % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
						" Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99") +;
						" Compt Atual.  "+ cComptAtl + CRLF
				EndIf

			Next IND

		Else

			MsgAlert("SELIC não cadastrada, SELIC Não localizado !!! ","Atencao!")

		EndIf

	Else

		MsgAlert("COMPETENCIA não cadastrada, COMPETENCIA Não localizado !!! ","Atencao!")

	EndIf

	//cObsOnus +=  CRLF + "--> Valor da Atualização Calculado R$ " + Transform(nVlrTcor,"@e 9,999,999.99") + " -  Em "  + cDthr + CRLF

	cObsOnus +=  CRLF + CRLF + "--> Valor Atualizado Automaticamete R$ " + Transform((nVlrTcor+Se2->e2_valor),"@e 999,999.99") + ", Valor da Atualização R$ "+Transform(nVlrTcor,"@e 9,999.99") +" -  Em "  + cDthr + CRLF
	MsgAlert(cObsOnus,"Atencao!")

	nVlrAtual := nVlrTcor
	nAtuMonet:= 'Sim'

	lFazAtu :='T'
	lFazAtuaut :='T'

	oGet2:Refresh()
	oGet19:SetFocus()

RETURN()

static function fCalAtuAGU(cCompt1 , cParcela1)

	local nInd1     := 0
	local nInd2     := 0

	local cJuros    := 1
	local cConta    := 0

	local cPercMes := 0.00
	local cPercTot := 0.00
	local nVlrMAnt := 0.00
	local nVlrAtul := 0.00
	local nVlrCor  := 0.00
	local nVlrTcor := 0.00

	//local cVlrAtuAns := 0.00
	//nVlrAtual
	LOCAL IND := 0

	//  nInd1 := aScan( aCompt, cCompt1 )
	nInd1 := Ascan(aCompt,{ |x| x[1] = cCompt1 })

	If nInd1 > 0

		// orientado pelo Sr Alan que se utiliza a selic do mes anterior
		// ja que a do mes de calculo nao existe (nao publicada)
		// ação documentada por email em 09/08/2021

		nInd1--

		nInd2 := nInd1 - ((aScan(aParcela, cParcela1 )) - 1)

		//     nInd2 := nInd1 - (Ascan(aParcela,{ |x| x[1] = cParcela1 }) - 1)//))(aScan(aParcela, cParcela1 )) - 1)

		If nInd2 > 0

			cObsOnus +=  CRLF + "--> Modelo AGU - Atualizado Pelo Sistema -  Usuario " + _cIdUsuar+ " - "+_cUsuario+" Em "  + cDthr + CRLF
			cObsOnus +=  CRLF + "--> A Selic utilizada e sempre a do mês anterior a da competência "+ CRLF + CRLF

			For IND := nInd2 to nInd1

				cConta++

				If cConta == 1
					cPercMes := 0.00
					cPercTot += cPercMes

					cComptAtl:= aCompt[IND][1]

					nVlrMAnt := Se2->e2_valor
					nVlrAtul := nVlrMAnt+((nVlrMAnt*cPercMes)/100)
					nVlrCor  := (nVlrMAnt*cPercMes ) /100

					nVlrTcor := nVlrAtul - Se2->e2_valor

					// cObsOnus +=  " Parcela "+ Transform(cConta,"@e 999") +"  Valor Base R$ "  + Transform(Se2->e2_valor,"@e 999,999,999.99") + "Valor Atualizado "+ Transform((Se2->e2_valor + ((Se2->e2_valor*cPerc)/100)),"@e 999,999,999.99") +" Atulização :"+ Transform(cPerc,"@e 999.99")+"% "+CRLF

					cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
						" Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
						" Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
						" Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
						" % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
						" % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
						" Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99")+      ;
						" Compt Atual.  "+ cComptAtl + CRLF

				ElseIf cConta == 2

					cPercMes := cJuros
					cPercTot += cPercMes

					cComptAtl:= aCompt[IND][1]

					nVlrMAnt :=  nVlrAtul
					nVlrAtul :=  nVlrMAnt+((nVlrMAnt*cPercMes)/100)
					nVlrCor  :=  (nVlrMAnt*cPercMes) /100
					nVlrTcor := nVlrAtul - Se2->e2_valor

					// cObsOnus +=  " Parcela "+ Transform(cConta,"@e 999") +"  Valor Base R$ "  + Transform(Se2->e2_valor,"@e 999,999,999.99") + "Valor Atualizado "+ Transform((Se2->e2_valor + ((Se2->e2_valor*cPerc)/100)),"@e 999,999,999.99") +" Atulização :"+ Transform(cPerc,"@e 999.99")+"% "+CRLF

					cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
						" Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
						" Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
						" Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
						" % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
						" % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
						" Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99")+      ;
						" Compt Atual.  "+ cComptAtl + CRLF
				Else

					cPercMes := Iif (len(aSelic) > IND ,   aSelic[IND][1]  , 0.00)
					cPercTot += cPercMes

					cComptAtl:= aCompt[IND][1]

					nVlrMAnt := nVlrAtul
					nVlrAtul := nVlrMAnt+((nVlrMAnt*cPercMes)/100)
					nVlrCor  := (nVlrMAnt*cPercMes ) /100
					nVlrTcor := nVlrAtul - Se2->e2_valor

					//               cObsOnus +=  " Parcela "+ Transform(cConta,"@e 999") +"  Valor Base R$ "  + Transform(Se2->e2_valor,"@e 999,999,999.99") + "Valor Atualizado "+ Transform((Se2->e2_valor + ((Se2->e2_valor*cPerc)/100)),"@e 999,999,999.99") +" Atulização :"+ Transform(cPerc,"@e 999.99")+"% "+CRLF
					cObsOnus +=  " Parc "+ Transform(cConta,"@e 999") +;
						" Vlr Orginal R$ " + Transform(Se2->e2_valor,"@e 9,999,999.99") +;
						" Vlr Mes Anterior R$ " + Transform(nVlrMAnt,"@e 9,999,999.99") +;
						" Vlr Atual. "+ Transform((nVlrAtul),"@e 9,999,999.99") +;
						" % Atul. Mesal :"+ Transform(cPercMes,"@e 999.99")+"% -"+;
						" % Atul. Total :"+ Transform(cPercTot,"@e 999.99")+"% -"+;
						" Vlr da Correção "+ Transform(nVlrCor ,"@e 999,999.99")+      ;
						" Compt Atual.  "+ cComptAtl + CRLF
				EndIf

			Next IND

		Else

			MsgAlert("SELIC não cadastrada, SELIC Não localizado !!! ","Atencao!")

		EndIf
	Else

		MsgAlert("COMPETENCIA não cadastrada, COMPETENCIA Não localizado !!! ","Atencao!")

	EndIf

	cObsOnus +=  CRLF + CRLF + "--> Valor Atualizado Automaticamete R$ " + Transform((nVlrTcor+Se2->e2_valor),"@e 999,999.99") + ", Valor Da Atualização R$ "+Transform(nVlrTcor,"@e 9,999.99") +" -  Em "  + cDthr + CRLF

	nVlrAtual := nVlrTcor

	nAtuMonet:= 'Sim'

	lFazAtu :='T'
	lFazAtuaut :='T'

	oGet2:Refresh()
	oGet19:SetFocus()
	//MsgAlert(cObsOnus,"Atencao!")

RETURN()


static function fc(XARQ)

	If XARQ == "SE2"
		ConPad1(,,,"SE2JUR")
	ElseIf XARQ == 'SA2'
		ConPad1(,,,"SA2JUR")
	ElseIf XARQ == 'SA1'
		ConPad1(,,,"SA1JUR")
	ElseIf XARQ == 'SE1'
		ConPad1(,,,"SE1JUR")
	EndIF

	VarInfo( 'aCpoRet', aCpoRet )

	if XARQ == "SE2"

		lGTitPag:=.F.
		oCBox2:disable()
		oGet25:enable()
		oVlronus1:enable()
		oDtOnus1:enable()
		oCBox3:enable()
		oGet28:enable()
		oGet1:enable()
		oGet3:enable()
		oGet11:enable()
		oCBox2:enable()
		oGet13:enable()
		oGet14:enable()

		cPrefPg:=SE2->E2_PREFIXO
		cTitPg:=SE2->E2_NUM
		cParcPg:=SE2->E2_PARCELA
		cTipoPg:=SE2->E2_TIPO
		cFornec:=SE2->E2_FORNECE
		cNomFornec:=SE2->E2_NOMFOR
		dDtVencPg:=SE2->E2_VENCREA
		nVlrPgt:=SE2->E2_VALOR
		nVlracresP:= SE2->E2_ACRESC


		oGet25:Refresh()
		oVlronus1:Refresh()
		oDtOnus1:Refresh()
		oCBox3:Refresh()
		oGet28:Refresh()
		oGet1:Refresh()
		oGet3:Refresh()
		oGet11:Refresh()
		oCBox2:Refresh()
		oGet13:Refresh()
		oGet14:Refresh()

	ElseIf XARQ == 'SA2'

		cFornec:= SA2->A2_COD
		cNomFornec:=SA2->A2_NOME
		cLjCliFor:= SA2->A2_LOJA

		oGet1:Refresh()
		oGet11:Refresh()


	ElseIf XARQ == 'SA1'

		cClient:= SA1->A1_COD
		cNomClient:=SA1->A1_NOME
		cLjCliFor:= SA1->A1_LOJA

		oGet4:Refresh()
		oGet2:Refresh()

	ElseIf XARQ == 'SE1'

		lGTitRec:=.F.
		oCBox4:disable()

		cPrefRec:=SE1->E1_PREFIXO
		cTitRec:=SE1->E1_NUM
		cParcRec:=SE1->E1_PARCELA
		cTipoRec:=SE1->E1_TIPO
		cClient:=SE1->E1_CLIENTE
		cNomClient:=SE1->E1_NOMCLI
		dDtVencRec:=SE1->E1_VENCREA
		nVlrRec:=SE1->E1_VALOR
		nVlAcresR:=SE1->E1_ACRESC

		oGet26:Refresh()
		oGet16:Refresh()
		oGet15:Refresh()
		oGet29:Refresh()
		oGet7:Refresh()
		oGet6:Refresh()
		oGet5:Refresh()
		oGet4:Refresh()
		oGet2:Refresh()
         /*
oGet25:lReadOnly:=.F.
oVlronus1:lReadOnly:=.F.
oDtOnus1:lReadOnly:=.F.
oCBox3:lReadOnly:=.F.
oGet28:lReadOnly:=.F.
oGet1:lReadOnly:=.F.
oGet3:lReadOnly:=.F.
oGet11:lReadOnly:=.F.
oCBox2:lReadOnly:=.F.
oGet13:lReadOnly:=.F.
oGet14:lReadOnly:=.F.
         */
	EndIf

return()

static Function fGrvPe6(nRec)

	DbGoto(nRec)

	RecLock("PE6",.F.)

	PE6_LANCAD := 'T'

	Msunlock("PE6")

return()

static function fCargaVet()

	local ret1       := 0
	local cAliasPea  := GetNextAlias()
	local cQuery     := " "

	cQuery :=  "select * From PEA010 PEA where PEA_FILIAL = '"+  xFilial("PEA") +"'   AND PEA.D_E_L_E_T_ = ' '  order by PEA.PEA_COMPTE "

	If Select((cAliasPea)) <> 0
		(cAliasPea)->(DbCloseArea())
	Endif

	TCQuery cQuery New Alias (cAliasPea)

	(cAliasPea)->( DbGoTop() )

	While !(cAliasPea)->(EOF())

		Aadd(aCompt,{ trim((cAliasPea)->PEA_COMPTE) })
		Aadd(aSelic,{ (cAliasPea)->PEA_VALOR })

		(cAliasPea)->(dbSkip())

		ret1++

	EndDo

	(cAliasPea)->(DbCloseArea())

Return( ret1 )

static function fGrvPea()
	
   Local x := 0

	dbselectArea("PEA")
	dbSetOrder(1)
	For x:=1 to len(aSelic)
		RecLock("PEA",.T.)

		PEA->PEA_FILIAL := xFilial("PEA")
		PEA->PEA_COMPTE := aCompt[x]
		PEA->PEA_VALOR  := aSelic[x]

		Msunlock("PBY")

	Next
return()


Static Function fVlNat(cPrefPg)

	If  !empty(cPrefPg)
		If cPrefPg == 'RPD'
			cNatureza := '46318'
		ELSEIf cPrefPg == 'JUD'
			cNatureza := '46317'
		ELSEIf cPrefPg == 'JUT'
			cNatureza := '46313'
		EndIf
	EndIf

	oGet30:Refresh()

Return
