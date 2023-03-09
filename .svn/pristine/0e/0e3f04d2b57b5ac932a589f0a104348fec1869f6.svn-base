#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁEXFTMITA  ╨Autor  ЁJean Schulz         ╨ Data Ё  15/11/06   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁLog de exportacao para Itau. Exporta usr. de empresa/ctr.   ╨╠╠
╠╠╨          Ёespecifico, conforme parametrizado.                         ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё MP8                                                        ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
User Function EXFTMITA
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta matriz com as opcoes do browse...                             Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE aRotina   	:=	{	{ "Pesquisar"	    , 'AxPesqui'	  , 0 , K_Pesquisar  },;
{ "&Visualizar"	, 'AxVisual'	  , 0 , K_Visualizar	},;
{ "E&xportar"	, 'U_EXPFATM'     , 0 , K_Incluir		},;
{ "&Excluir"	, 'U_EXCFATM'     , 0 , K_Excluir		},;
{ "&Importar"	, 'U_IMPFATM'     , 0 , K_Incluir		},;
{ "&Canc. Imp"	, 'U_CANCIMP'     , 0 , K_Incluir		},;
{ "Legenda"     , 'U_LEGFATM'     , 0 , K_Incluir		} }

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Titulo e variavies para indicar o status do arquivo                 Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE cCadastro 	:= "Log de envio/receb. arquivos Rio PrevidЙncia"

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Titulo e variavies para indicar o status do arquivo                 Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE cCadastro	:= "Log de envio/receb. arquivos Fat. Mod. ItaЗ"
PRIVATE aCdCores  	:= { 	{ 'BR_VERDE'    ,'Arquivo Gerado' },;
{ 'BR_AZUL'     ,'Arquivo Exportado e Importado' } }
PRIVATE aCores      := {	{ 'ZZH_STATUS = "1"',aCdCores[1,1] }	,;
{ 'ZZH_STATUS = "2"',aCdCores[2,1] }	}


PRIVATE cPath 		:= ""
PRIVATE cAlias		:= "ZZH"
PRIVATE cCodExp		:= ""

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Declaracao de Variaveis                                             Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE cNomeProg   := "EXFTMITA"
PRIVATE nQtdLin     := 50
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "M"
PRIVATE cTitulo     := "Exportacao Ft.Mod. ItaЗ"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "ZZH"
PRIVATE cPerg       := "YEXITA"
PRIVATE nRel        := "EXFTMITA"
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
PRIVATE cCabec1     := "Protocolo de exportaГЦo de movimentacao de usuАrios ItaЗ"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0
PRIVATE cString     := "ZZH"
PRIVATE nTipo		:=GetMv("MV_COMP")
PRIVATE nReg		:= 0
PRIVATE nHdl

PRIVATE cNameBD7	:= RetSQLName("BD7") 

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Starta mBrowse...                                                   Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ZZH->(DBSetOrder(1))

ZZH->(mBrowse(006,001,022,075,"ZZH" , , , , , Nil    , aCores, , , ,nil, .T.))
ZZH->(DbClearFilter())

Return

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁEXPFATM   ╨Autor  ЁMicrosiga           ╨ Data Ё  21/11/06   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁChama rotina de exportacao FTM Itau...                      ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
User Function EXPFATM
Local cNomeArq	:= ""


//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis de parametros do relatorio.                               Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE cCodEmp		:= ""
PRIVATE cNumSE1		:= ""
PRIVATE cLayout		:= ""

ParSX1()
If !Pergunte(cPerg,.T.)
	MsgAlert("ExportaГЦo abortada!")
	Return
Endif

If Empty(cAno) .or. empty(cMes)
	MsgAlert("A T E N C A O ! Ano e/ou Mes de competencia nao informado(s)!")
	Return
Endif

WnRel := SetPrint(cString,nrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
End

Processa({|| ImpRel() }, "Buscando dados...", "", .T.)

If  aReturn[5] == 1
	Set Printer To
	Ourspool(nRel)
End
MS_FLUSH()

Return




/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁImpRel    ╨Autor  ЁJean Schulz         ╨ Data Ё  15/11/06   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁFuncao chamada pela funcao processa para imprimir protocolo ╨╠╠
╠╠╨          Ёe gerar texto para empresa.                                 ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function ImpRel

Local aFatExp	:= {}
Local nLin		:= 100
Local nReg		:= 0
Local cDirExp	:= GETNEWPAR("MV_YEXFTIT","\Exporta\FTMITAU\")
Local cEOL		:= CHR(13)+CHR(10)
Local cCpo		:= ""
Local nTotCob   := 0
Local cMatEmpr	:= ""
Local cMatrAnt	:= ""
Local dDatPro	:= CtoD("")
Local cDatPro	:= ""

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis de utilizacao da rotina...  			                    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local nCont		:= 1
Local cNumFun	:= ""
Local cNumDep	:= ""
Local cCPFUsr	:= ""
Local cNomUsr	:= ""
Local cMatTit	:= ""
Local cIndFM	:= "N"
Local nVlrPro	:= 0
Local nQtdExc	:= 0
Local aErro		:= {}

Local cMatAnt	:= ""

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis de totalizador...           			                    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local nQtdProcF		:= 0
Local nVlrProcF		:= 0
Local nQtdProFM		:= 0
Local nVlrCobFM		:= 0
Local nVlrAgrFM 	:= 0
Local nVlrTFaFM 	:= 0
Local nVltTotPro	:= 0
Local nTotProcFM	:= 0
Local nTotCobrFM	:= 0
Local nTotAgreFM	:= 0
Local nTotTtFaFM	:= 0
Local aRetUti		:= {}

Local cPadAnt		:= ""
Local cProAnt		:= ""
Local nPos			:= 0
Local nPos1			:= 0

Local aArBA1		:= {}
Local aArBD6		:= {}
Local aArBKD		:= {}
Local aArBKE		:= {}
Local aArBD6New		:= {}
Local aGetUsr		:= {}

Local lPodImp20		:= .F.

Local cMatEmpAgr	:= ""
Local dDatBlo	:= CtoD("  /  /    ")

Local nRegAgBA1		:= 0
Local nQtdImp		:= 0
Local aImpresso		:= {}
Local nQtdTPF		:= 0
Local nVlrTPF		:= 0
Local cNomArqH14	:= GetNewPar("MV_YFTMNM","MOVIMENTO DE UTILIZACAO")

Local _cCodigo		:= ""
Local nVlrTotBD7	:= 0
Local cSQLTmp		:= ""


PRIVATE cCodEmp	:= ""
PRIVATE cConEmp	:= ""
PRIVATE cVerCon	:= ""
PRIVATE cAno	:= ""
PRIVATE cMes	:= ""
PRIVATE cObser	:= ""
PRIVATE nTotReg	:= 0

PRIVATE aVetUti := {}

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Atualiza variaveis a partir dos parametros do pergunte.             Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Atu_Var()


//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define indices e tabelas para uso.                                  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA0->(DbSetOrder(1))
BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))
BD5->(DbSetOrder(1))
BE4->(DbSetOrder(1))
BD6->(DbSetOrder(10))
BD7->(DbSetOrder(1))
BKD->(DbSetOrder(4))
BKE->(DbSetOrder(1))
BK6->(DbSetOrder(3))
BR8->(DbSetOrder(3))
ZZG->(DbSetOrder(1))
ZZH->(DbSetOrder(1))
BAU->(DbSetOrder(1)) //BAU_FILIAL + BAU_CODIGO

MsgRun("Selecionando Registros...",,{|| BuscaRegs(),CLR_HBLUE})

If nTotReg = 0
	Return
Endif

//зддддддддддддддддддддддддддддддддддддддддддд©
//Ё Geracao do texto para convenio Itau. 	  Ё
//Ё Formato do nome: PS9DDMMAA.TXT onde:  	  Ё
//Ё PS9: Prefixo indicando arq. FTM.	   	  Ё
//Ё A/I: A-Ativos / I-Inativos			   	  Ё
//Ё MM: Mes de geracao do arquivo        	  Ё
//Ё AA: Ano de geracao do arquivo        	  Ё
//юддддддддддддддддддддддддддддддддддддддддддды
ProcRegua(nTotReg)
cDiaGer := cMes+Substr(cAno,3,2)
cNomeArq := cDirExp+"PS9"+Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"A","I")+cDiaGer+".TXT"

_cCodigo := GetSx8Num("ZZH","ZZH_CODIGO")
ConfirmSx8()

Begin Transaction

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Gravacao do registro de log da exportacao...                        Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ZZH->(RecLock("ZZH",.T.))
ZZH->ZZH_FILIAL	:= xFilial("ZZH")
ZZH->ZZH_STATUS	:= "1" //Gerado...
ZZH->ZZH_CODIGO := _cCodigo
ZZH->ZZH_DATEXP	:= dDataBase
ZZH->ZZH_OBSERV	:= cObser
ZZH->ZZH_CODEMP	:= cCodEmp
ZZH->ZZH_CONVER	:= cConEmp+cVerCon
ZZH->ZZH_ANO	:= cAno
ZZH->ZZH_MES	:= cMes
ZZH->(MsUnlock())

cCodExp := ZZH->ZZH_CODIGO

If U_Cria_TXT(cNomeArq)
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Montagem do Header...                                               Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cLin := Space(1)+cEOL
	cCpo :=	"01"+; //H01
	Replicate("0",11)+; //H02
	Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123")+; //H03
	Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705")+; //H04
	Alltrim(Posicione("BA0",1,xFilial("BA0")+PLSINTPAD(),"BA0_NOMINT"))+Space(50-Len(Alltrim(Posicione("BA0",1,xFilial("BA0")+PLSINTPAD(),"BA0_NOMINT"))))+; //H05
	Posicione("BA0",1,xFilial("BA0")+PLSINTPAD(),"BA0_CGC")+; //H06
	Space(10)+; //H07
	"01"+; //H08
	cCodExp+; //H09
	"002"+; //H10
	"001"+; //H11
	Substr(DtoS(dDataBase),7,2)+"."+Substr(DtoS(dDataBase),5,2)+"."+Substr(DtoS(dDataBase),1,4)+; //H12
	StrTran(Time(),":","")+; //H13
	cNomArqH14+Space(50-Len(cNomArqH14))+; //H14
	Space(303)+; //H15
	Space(10)+; //H16
	StrZero(nCont,10) //H17
	
	nCont++
	
	If !(U_GrLinha_TXT(cCpo,cLin))
		MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE O CABEгALHO! OPERAгцO ABORTADA!")
		Return
	Endif
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Obter historico de utilizacao de todos os usuarios do arquivo...    Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nCont1 := 0
	cFamAnt := ""
	cFamilia := ""

	While ! TRB->(EOF())
		
		cFamilia := ""
		nCont1++
		IncProc("Buscando histСrico: "+StrZero(nCont1,6))
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Quando familia diferente, buscar o historico dos agregados...       Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If !Empty(cFamAnt) .And. cFamAnt <> TRB->BD6_OPEUSR+TRB->BD6_CODEMP+TRB->BD6_MATRIC

//Inserido por Luzio em 03/04/08 para que imprima a matricula que esta no BD6 e nao existe no BA1
			cFamilia := TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)+"-"+BD6->BD6_NOMUSR
			
			BA1->(DbSetOrder(2))
			BA1->(MsSeek(xFilial("BA1")+cFamAnt+"00"))
			IF !BA1->(FOUND())
				TRB->(DbSkip())
				aadd(aErro,{"Titular nao encontrado! - Nivel 1" + cFamAnt+"00"})
				loop
			EndIf
			
			cMatEmpAgr := BA1->BA1_MATEMP
			
			If !Empty(cMatEmpAgr)
				
				BA1->(DbSetOrder(6)) //MATEMP
				BA1->(MsSeek(xFilial("BA1")+cMatEmpAgr))
				
				While !BA1->(Eof()) .And. BA1->BA1_MATEMP == cMatEmpAgr
					
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Garantir que familia ja exportada anteriormente nao seja reenviada. Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					If cFamAnt <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)

//Inserido por Luzio em 02/07/08 para que recupere a data de bloqueio do usuario contida no BA1
						dDatBlo    := BA1->BA1_DATBLO
					
						BD6->( dbOrderNickName( "INDITAU" ) )
						BD6->(MsSeek(xFilial("BD6")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)))
						
						While !BD6->(Eof()) .And. BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)==BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
						
							If BD6->(BD6_CONEMP+BD6_VERCON) <> cConEmp+cVerCon
								BD6->(DbSkip())
								Loop				
							Endif						
						
							If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
								If BD7->BD7_FASE <> '4' .OR. SubStr(BD7->BD7_NUMLOT,1,6) <> cAno+cMes 
									BD6->(DbSkip())
									Loop
								Endif							
							Endif
							/*
							If BD6->(BD6_ANOPAG+BD6_MESPAG) <> cAno+cMes
								BD6->(DbSkip())
								Loop
							Endif
							*/
							
							AtuUtil(@aVetUti,BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_CONEMP,BA1->BA1_VERCON,BA1->BA1_SUBCON,BA1->BA1_VERSUB,BD6->BD6_CODPAD,BD6->BD6_CODPRO, cAno, cMes)
							
							BD6->(DbSkip())
							
						Enddo
						
					Endif
					
					BA1->(DbSkip())
					
				Enddo				
				
			Else
//				aadd(aErro,{"UsuАrio sem matrМcula da empresa informada! "+BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)})				
				aadd(aErro,{"UsuАrio sem matrМcula da empresa informada! " + cFamAnt + "00"})
			Endif
			
		Endif
		
		AtuUtil(@aVetUti,TRB->BD6_OPEUSR,TRB->BD6_CODEMP,TRB->BD6_MATRIC,TRB->BD6_TIPREG,TRB->BD6_DIGITO,TRB->BD6_CONEMP,TRB->BD6_VERCON,TRB->BD6_SUBCON,TRB->BD6_VERSUB,TRB->BD6_CODPAD,TRB->BD6_CODPRO, cAno, cMes)
		cFamAnt := TRB->BD6_OPEUSR+TRB->BD6_CODEMP+TRB->BD6_MATRIC
		cPadAnt	:= TRB->BD6_CODPAD
		cProAnt	:= TRB->BD6_CODPRO
//Inserido por Luzio em 03/04/08 para que imprima a matricula que esta no BD6 e nao existe no BA1
		cFamilia := TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)+"-"+TRB->BD6_NOMUSR
		
		TRB->(DbSkip())
		
	Enddo        

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Observar o ultimo registro do arquivo, e buscar seus agregados...   Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
	BA1->(DbSetOrder(2))
	BA1->(MsSeek(xFilial("BA1")+cFamAnt+"00"))

//Inserido por Luzio em 03/04/08 para que imprima a matricula que esta no BD6 e nao existe no BA1
	IF !BA1->(FOUND())
		aadd(aErro,{"Titular nao encontrado! - Nivel 2" + cFamAnt + "00"})
	Else	
	
	cMatEmpAgr := BA1->BA1_MATEMP
	
	If !Empty(cMatEmpAgr)
		
		BA1->(DbSetOrder(6)) //MATEMP
		BA1->(MsSeek(xFilial("BA1")+cMatEmpAgr))
		
		While !BA1->(Eof()) .And. BA1->BA1_MATEMP == cMatEmpAgr
			
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Garantir que familia ja exportada anteriormente nao seja reenviada. Ё
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If cFamAnt <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)

//Inserido por Luzio em 02/07/08 para que recupere a data de bloqueio do usuario contida no BA1
				dDatBlo    := BA1->BA1_DATBLO
			
				BD6->( dbOrderNickName( "INDITAU" ) )
				BD6->(MsSeek(xFilial("BD6")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)))
				
				While !BD6->(Eof()) .And. BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)==BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
				
					If BD6->(BD6_CONEMP+BD6_VERCON) <> cConEmp+cVerCon
						BD6->(DbSkip())
						Loop				
					Endif
                      
					If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
						If BD7->BD7_FASE <> '4' .OR. SubStr(BD7->BD7_NUMLOT,1,6) <> cAno+cMes 
							BD6->(DbSkip())
							Loop
						Endif							
					Endif

					/*					
					If BD6->(BD6_ANOPAG+BD6_MESPAG) <> cAno+cMes
						BD6->(DbSkip())
						Loop
					Endif
					*/
									
					AtuUtil(@aVetUti,BA1->BA1_CODINT,BA1->BA1_CODEMP,BA1->BA1_MATRIC,BA1->BA1_TIPREG,BA1->BA1_DIGITO,BA1->BA1_CONEMP,BA1->BA1_VERCON,BA1->BA1_SUBCON,BA1->BA1_VERSUB,BD6->BD6_CODPAD,BD6->BD6_CODPRO, cAno, cMes)
					
					BD6->(DbSkip())
					
				Enddo					
				
			Endif
			
			BA1->(DbSkip())
			
		Enddo				
	Else
//		aadd(aErro,{"UsuАrio sem matrМcula da empresa informada! "+BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)})		
		aadd(aErro,{"UsuАrio sem matrМcula da empresa informada! " + cFamAnt})
	Endif	
	EndIf	
	BA1->(DbSetOrder(2))	
	TRB->(DbGotop())
	ProcRegua(nTotReg)
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Gerar linhas de detalhe (registro 3)                                Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cFamAnt := ""
	cFamilia := ""
	While ! TRB->(EOF())
		
		IncProc("Registro: "+StrZero(nCont,6))
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Ao verificar que proximo usuario eh diferente, buscar reembolsos... Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If cMatAnt <> TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
			
			If BKD->(MsSeek(xFilial("BKD")+Substr(cMatAnt,1,16)+cAno+cMes))
				
				While !BKD->(Eof()) .And. BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS) == Substr(cMatAnt,1,16)+cAno+cMes
					
					BKE->(MsSeek(xFilial("BKE")+BKD->BKD_CODRBS))
					
					While !BKE->(Eof()) .And. BKD->BKD_CODRBS == BKE->BKE_CODRBS
						
						If !Empty(BKE->BKE_YFTITA)
							BKE->(DbSkip())
							Loop
						Endif											
						
						If ascan(aImpresso,"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)))) <> 0
							BKE->(DbSkip())
							Loop
						Endif                                                                                                                          
						
						aadd(aImpresso,"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO))))
						
// Trecho de codigo incluido por Luzio em 02/07/08, para que critique quando a data de atendimento 
// for maior que a data de bloqueio do usuario.
						If BKD->BKD_DATA > dDatBlo
							aadd(aErro,{"Data do Atendimento maior que a data do bloqueio, sujeito a rejeicao. Verifique! "+BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS)})
							BKE->(DbSkip())
							Loop
						Endif

						dDatPro := BKD->BKD_DATA
						cDatPro := Substr(DtoS(dDatPro),7,2)+"."+Substr(DtoS(dDatPro),5,2)+"."+Substr(DtoS(dDatPro),1,4)
						
						cIndFM := "N"
						
						If Len(aVetUti)>0
						
							nPos1 := 0
							nPos := Ascan(aVetUti, { |x| AllTrim(x[1]) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) } )
							
							If nPos > 0
								
								While nPos <= Len(aVetUti)
									
									If aVetUti[nPos,1] <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
										nPos1 := 0
										Exit
									Endif
									
									If aVetUti[nPos,3] $ Iif(Alltrim(BKE->BKE_CODPRO)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),"00010014",Alltrim(BKE->BKE_CODPRO))
										nPos1 := nPos
										Exit
									Endif
									
									nPos++
								Enddo
								
								If nPos1 > 0
									If aVetUti[nPos1,7] > 0
										cIndFM := "S"
									Endif
									
									
									//Se qtd permitida < soma do historico+impresso+item em questao
									If aVetUti[nPos1,7] < aVetUti[nPos1,4]+nQtdImp+BKE->BKE_QTDPRO .And. aVetUti[nPos1,7] > 0										
										nQtdExc := BKE->BKE_QTDPRO
										nVlrPro := (aVetUti[1,8]*nQtdExc)
									Endif
								Endif
								
							Endif
							
						Endif
						
						cLin := Space(1)+cEOL
						cCpo :=	"10"+; //D01
						cNumFun+; //D02 e D03 //Iif(Empty(cNumDep),"00",cNumDep)+; //D03
						Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123")+; //D04
						Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705")+; //D05
						cCPFUsr+; //D06
						cNomUsr+; //D07
						BA1->BA1_MATRIC+Space(4)+; //D08
						cMatTit+; //D09
						BA1->BA1_TIPREG+Space(2)+; //D10
						"05"+; //D11
						BKD->(BKD_ANOBAS+BKD_MESBAS)+; //D12
						cDatPro+; //D13
						Alltrim(Posicione("BK6",3,xFilial("BK6")+BKD->BKD_CODCRE,"BK6_NOME"))+Space(50-Len(Alltrim(Posicione("BK6",3,xFilial("BK6")+BKD->BKD_CODCRE,"BK6_NOME"))))+; //D14
						Alltrim(Posicione("BR8",3,xFilial("BR8")+BKE->BKE_CODPRO,"BR8_DESCRI"))+Space(90-Len(Alltrim(Posicione("BR8",3,xFilial("BR8")+BKE->BKE_CODPRO,"BR8_DESCRI"))))+; //D15
						"D"+; //D16
						StrZero(BKE->BKE_VLRRBS*100,15)+; //D17
						cIndFM+; //D18
						StrZero(nVlrPro*100,15)+; //D19
						"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)))+; //D20
						Space(20)+; //D21
						"I"+; //D22
						Space(145)+; //D23
						Space(1)+;//D24
						Space(10)+;//D25
						StrZero(nCont,10) //D26
						
						If !(U_GrLinha_TXT(cCpo,cLin))
							MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAгцO ABORTADA!")
							Return
						Endif
						
						If cIndFM == "S"
							nQtdImp+=BKE->BKE_QTDPRO
						Endif
						
						BKE->(Reclock("BKE",.F.))
						BKE->BKE_YFTITA := cCodExp
						BKE->BKE_YERITA := "00"
						BKE->BKE_YVLITA := nVlrPro
						BKE->BKE_YMTEMI := cNumFun
						BKE->BKE_YINFTM := cIndFM					
						BKE->(MsUnlock())
						
						nCont++
						lPodImp20 := .T.
						
						//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Totais para linha de Trailler do detalhe...                         Ё
						//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						nQtdProcF ++
						nVlrProcF += BKE->BKE_VLRRBS
						nQtdProFM += Iif(cIndFM=="S",1,0)
						nVlrCobFM += nVlrPro
						
						nVlrAgrFM += Iif(U_BusTipUsu(BKD->BKD_CODINT, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) == "T",0,nVlrPro)
						nVlrTFaFM += Iif(U_BusTipUsu(BKD->BKD_CODINT, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) <> "T",0,nVlrPro)
						
						
						//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Totais para linha de Trailler geral do arquivo...                   Ё
						//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						nVltTotPro += BKE->BKE_VLRRBS
						nTotProcFM += Iif(cIndFM=="S",1,0)
						nTotCobrFM += nVlrPro
						nTotAgreFM += Iif(U_BusTipUsu(BKD->BKD_CODINT, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) == "T",0,nVlrPro)
						nTotTtFaFM += Iif(U_BusTipUsu(BKD->BKD_CODINT, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) <> "T",0,nVlrPro)
						
						//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Zerar variaveis de fator moderador Itau...                          Ё
						//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						cIndFm := "N"
						nQtdExc := 0
						nVlrPro := 0
												
						BKE->(DbSkip())
						
					Enddo
					
					BKD->(DbSkip())
					
				Enddo
				
			Endif
			
		Endif
		
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprimir rodape do detalhe (registro 4)                             Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If cFamAnt <> TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC) .And. !Empty(cFamAnt)
			
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Mudanca de escopo, mudar busca de agregados (Reembolso e Cts MedicasЁ
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			aArBA1 := BA1->(GetArea())
			aArBD6 := BD6->(GetArea())
			aArBKD := BKD->(GetArea())
			aArBKE := BKE->(GetArea())
			
			nQtdImp := 0
			
			BA1->(DbSetOrder(2))
			BA1->(MsSeek(xFilial("BA1")+cFamAnt+"00"))
			
			If !BA1->(FOUND())
				aadd(aErro,{"Titular nao encontrado! - Nivel 3" + cFamAnt + "00"})
			ELse
			
			cMatEmpAgr := BA1->BA1_MATEMP
						
			If !Empty(cMatEmpAgr)
				
				BA1->(DbSetOrder(6)) //MATEMP
				BA1->(MsSeek(xFilial("BA1")+cMatEmpAgr))				
				
				While !BA1->(Eof()) .And. BA1->BA1_MATEMP == cMatEmpAgr
				
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Garantir que familia ja exportada anteriormente nao seja reenviada. Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					If cFamAnt <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)

//Inserido por Luzio em 02/07/08 para que recupere a data de bloqueio do usuario contida no BA1
						dDatBlo    := BA1->BA1_DATBLO
						
						nQtdImp := 0
						
						//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Informacoes necessarias para a exportacao dos dados...              Ё
						//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						If BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
// Comentado por Luzio em 02/07/08, para que a rotina envie toda a matricula contida no campo BA1_MATEMP
/*							If Len(Alltrim(BA1->BA1_MATEMP)) > 9
								//cNumFun := StrZero(Val(BA1->BA1_MATEMP),9)
								cNumFun := Substr(Alltrim(BA1->BA1_MATEMP),1,9)
								If Len(Alltrim(cNumFun)) < 9
									cNumFun := Alltrim(cNumFun)+Space(9-Len(cNumFun))
								Endif

							Else
								cNumFun := Replicate("0",9-Len(Alltrim(BA1->BA1_MATEMP)))+Alltrim(BA1->BA1_MATEMP)
							Endif
*/							
							cNumFun := Replicate("0",11-Len(Alltrim(BA1->BA1_MATEMP)))+Alltrim(BA1->BA1_MATEMP)
							If Substr(Alltrim(BA1->BA1_MATEMP),1,1) = "_"
							  cNumFun := Substr(Alltrim(BA1->BA1_MATEMP),2,11)
							Endif
//							If Len(Alltrim(cNumFun)) < 11
//								cNumFun := Alltrim(cNumFun)+Space(11-Len(cNumFun))
//							Endif

							aGetUsr := BA1->(GetArea())
							BA1->(DbSetOrder(2))
							If Empty(cMatTit) .Or. BA1->BA1_TIPREG <> "00"
								If BA1->(MsSeek(xFilial("BA1")+cFamAnt+"00"))
									cMatTit := Substr(BA1->BA1_CODINT,2,3)+BA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
								Else
									aadd(aErro,{"Titular nao encontrado! "+cFamAnt+"00"})
									BA1->(DbSkip())
									Loop
								Endif
							Endif
							
							RestArea(aGetUsr)
							cCPFUsr := Iif(Empty(BA1->BA1_CPFUSR),BA1->BA1_CPFPRE,BA1->BA1_CPFUSR)
							cNomUsr	:= Substr(Alltrim(BA1->BA1_NOMUSR),1,30)+Space(30-Len(Substr(Alltrim(BA1->BA1_NOMUSR),1,30)))
							cMatTit := Iif(BA1->BA1_TIPREG == "00",Substr(BA1->BA1_CODINT,2,3)+BA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG),Alltrim(cMatTit))
							cNumDep := BA1->BA1_YDEPEN
							
						Else
							aadd(aErro,{"Familia nao encontrada! "+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)})
							BA1->(DbSkip())
							Loop
						Endif
						
						//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Buscar e imprimir reembolsos dos agregados...                       Ё
						//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						If BKD->(MsSeek(xFilial("BKD")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)+cAno+cMes))
							
							While !BKD->(Eof()) .And. BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)+cAno+cMes
										
								BKE->(MsSeek(xFilial("BKE")+BKD->BKD_CODRBS))
								
								While !BKE->(Eof()) .And. BKD->BKD_CODRBS == BKE->BKE_CODRBS
									
									If !Empty(BKE->BKE_YFTITA)
										BKE->(DbSkip())
										Loop
									Endif

									If ascan(aImpresso,"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)))) <> 0
										BKE->(DbSkip())
										Loop
									Endif                                                                                                                          									
									aadd(aImpresso,"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO))))

// Trecho de codigo incluido por Luzio em 02/07/08, para que critique quando a data de atendimento 
// for maior que a data de bloqueio do usuario.
									If BKD->BKD_DATA > dDatBlo
										aadd(aErro,{"Data do Atendimento maior que a data do bloqueio, sujeito a rejeicao. Verifique! "+BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS)})
										BKE->(DbSkip())
										Loop
									Endif
																		
									dDatPro := BKD->BKD_DATA
									cDatPro := Substr(DtoS(dDatPro),7,2)+"."+Substr(DtoS(dDatPro),5,2)+"."+Substr(DtoS(dDatPro),1,4)
									
									If Len(aVetUti)>0
									
										nPos1 := 0
										nPos := Ascan(aVetUti, { |x| AllTrim(x[1]) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) } )
										
										If nPos > 0
											
											While nPos <= Len(aVetUti)
												
												If aVetUti[nPos,1] <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
													nPos1 := 0
													Exit
												Endif
												
												If aVetUti[nPos,3] $ Iif(Alltrim(BKE->BKE_CODPRO)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),"00010014",Alltrim(BKE->BKE_CODPRO))
													nPos1 := nPos
													Exit
												Endif
												
												nPos++
											Enddo
											
											If nPos1 > 0
												If aVetUti[nPos1,7] > 0
													cIndFM := "S"
												Endif
												
												
												//Se qtd permitida < soma do historico+impresso+item em questao
												If aVetUti[nPos1,7] < aVetUti[nPos1,4]+nQtdImp+BKE->BKE_QTDPRO .And. aVetUti[nPos1,7] > 0													
													nQtdExc := BKE->BKE_QTDPRO
													nVlrPro := (aVetUti[1,8]*nQtdExc)
												Endif
											Endif
											
										Endif
										
									Endif
									
									
									cLin := Space(1)+cEOL
									cCpo :=	"10"+; //D01
									cNumFun+; //D02 e D03 //Iif(Empty(cNumDep),"00",cNumDep)+; //D03
									Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123")+; //D04
									Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705")+; //D05
									cCPFUsr+; //D06
									cNomUsr+; //D07
									BA1->BA1_MATRIC+Space(4)+; //D08
									cMatTit+; //D09
									BA1->BA1_TIPREG+Space(2)+; //D10
									"05"+; //D11
									BKD->(BKD_ANOBAS+BKD_MESBAS)+; //D12
									cDatPro+; //D13
									Alltrim(Posicione("BK6",3,xFilial("BK6")+BKD->BKD_CODCRE,"BK6_NOME"))+Space(50-Len(Alltrim(Posicione("BK6",3,xFilial("BK6")+BKD->BKD_CODCRE,"BK6_NOME"))))+; //D14
									Alltrim(Posicione("BR8",3,xFilial("BR8")+BKE->BKE_CODPRO,"BR8_DESCRI"))+Space(90-Len(Alltrim(Posicione("BR8",3,xFilial("BR8")+BKE->BKE_CODPRO,"BR8_DESCRI"))))+; //D15
									"D"+; //D16
									StrZero(BKE->BKE_VLRRBS*100,15)+; //D17
									cIndFM+; //D18
									StrZero(nVlrPro*100,15)+; //D19
									"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)))+; //D20
									Space(20)+; //D21
									"I"+; //D22
									Space(145)+; //D23
									Space(1)+;//D24
									Space(10)+;//D25
									StrZero(nCont,10) //D26
									
									If !(U_GrLinha_TXT(cCpo,cLin))
										MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAгцO ABORTADA!")
										Return
									Endif
									
									BKE->(Reclock("BKE",.F.))
									BKE->BKE_YFTITA := cCodExp
									BKE->BKE_YERITA := "00"
									BKE->BKE_YVLITA := nVlrPro
									BKE->BKE_YMTEMI := cNumFun
									BKE->BKE_YINFTM := cIndFM									
									BKE->(MsUnlock())
									
									If cIndFM == "S"
										nQtdImp+=BKE->BKE_QTDPRO
									Endif
									
									nCont++
									lPodImp20 := .T.
									
									//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
									//Ё Totais para linha de Trailler do detalhe...                         Ё
									//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
									nQtdProcF ++
									nVlrProcF += BKE->BKE_VLRRBS
									nQtdProFM += Iif(cIndFM=="S",1,0)
									nVlrCobFM += nVlrPro
									nVlrAgrFM += Iif(U_BusTipUsu(BKD->BKD_CODINT, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) == "T",0,nVlrPro)
									nVlrTFaFM += Iif(U_BusTipUsu(BKD->BKD_CODINT, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) <> "T",0,nVlrPro)
									
									
									//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
									//Ё Totais para linha de Trailler geral do arquivo...                   Ё
									//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
									nVltTotPro += BKE->BKE_VLRRBS
									nTotProcFM += Iif(cIndFM=="S",1,0)
									nTotCobrFM += nVlrPro
									nTotAgreFM += Iif(U_BusTipUsu(BKD->BKD_CODINT, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) == "T",0,nVlrPro)
									nTotTtFaFM += Iif(U_BusTipUsu(BKD->BKD_CODINT, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) <> "T",0,nVlrPro)
									
									
									//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
									//Ё Zerar variaveis de fator moderador Itau...                          Ё
									//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
									cIndFm := "N"
									nQtdExc := 0
									nVlrPro := 0
									
									BKE->(DbSkip())
									
								Enddo
								
								BKD->(DbSkip())
								
							Enddo
							
						Endif
						
						//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
						//Ё Imprimir itens de contas dos agregados...                           Ё
						//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						//BD6->(DbSetOrder(10))
						//Criar indice / Chave: BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO
						BD6->( dbOrderNickName( "INDITAU" ) )
						BD6->(MsSeek(xFilial("BD6")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)))
						
						While !BD6->(Eof()) .And. BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)==BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
						
							If BD6->(BD6_CONEMP+BD6_VERCON) <> cConEmp+cVerCon
								BD6->(DbSkip())
								Loop				
							Endif
					
							If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
								If BD7->BD7_FASE <> '4' .OR. SubStr(BD7->BD7_NUMLOT,1,6) <> cAno+cMes 
									BD6->(DbSkip())
									Loop
								Endif							
							Endif

							/*
							If BD6->(BD6_ANOPAG+BD6_MESPAG) <> cAno+cMes
								BD6->(DbSkip())
								Loop
							Endif
							*/
							
							If ascan(aImpresso,BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)) <> 0
								BD6->(DbSkip())
								Loop
							Endif                                                                                                                          									
							aadd(aImpresso,BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN))
							
// Trecho de codigo incluido por Luzio em 02/07/08, para que critique quando a data de atendimento 
// for maior que a data de bloqueio do usuario.
							If BD6->BD6_DATPRO > dDatBlo
								aadd(aErro,{"Data do Atendimento maior que a data do bloqueio, sujeito a rejeicao. Verifique! "+BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)})
								BD6->(DbSkip())
								Loop
							Endif
							
							dDatPro := Iif(Empty(BD6->BD6_DATPRO),	Iif(BD6->BD6_ORIMOV=="1",Posicione("BD5",1,xFilial("BD5")+BD6->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BD5_DATPRO"),Posicione("BE4",1,xFilial("BE4")+BD6->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BE4_DATPRO")),BD6->BD6_DATPRO)
							cDatPro := Substr(DtoS(dDatPro),7,2)+"."+Substr(DtoS(dDatPro),5,2)+"."+Substr(DtoS(dDatPro),1,4)
							
							If Len(aVetUti)>0
								
								nPos1 := 0
								nPos := Ascan(aVetUti, { |x| AllTrim(x[1]) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) } )
								
								If nPos > 0
									
									While nPos <= Len(aVetUti)
										
										If aVetUti[nPos,1] <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
											nPos1 := 0
											Exit
										Endif
										
										If aVetUti[nPos,3] $ Iif(Alltrim(BD6->BD6_CODPRO)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),"00010014",Alltrim(BD6->BD6_CODPRO))
											nPos1 := nPos
											Exit
										Endif
										
										nPos++
									Enddo
									
									If nPos1 > 0
										If aVetUti[nPos1,7] > 0
											cIndFM := "S"
										Endif
										
										
										//Se qtd permitida < soma do historico+impresso+item em questao
										If aVetUti[nPos1,7] < aVetUti[nPos1,4]+nQtdImp+BD6->BD6_QTDPRO .And. aVetUti[nPos1,7] > 0											
											nQtdExc := BD6->BD6_QTDPRO	
											nVlrPro := (aVetUti[1,8]*nQtdExc)
										Endif
									Endif
									
								Endif
								
							Endif
							
							cSQLTmp := " SELECT SUM(BD7_VLRPAG) AS TOTPAG "
							cSQLTmp += " FROM "+cNameBD7+" BD7 " 
							cSQLTmp += " WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
							cSQLTmp += " AND BD7_CODOPE = '"+BD6->BD6_CODOPE+"' "
							cSQLTmp += " AND BD7_CODLDP = '"+BD6->BD6_CODLDP+"' "
							cSQLTmp += " AND BD7_CODPEG = '"+BD6->BD6_CODPEG+"' "
							cSQLTmp += " AND BD7_NUMERO = '"+BD6->BD6_NUMERO+"' "
							cSQLTmp += " AND BD7_ORIMOV = '"+BD6->BD6_ORIMOV+"' "
							cSQLTmp += " AND BD7_SEQUEN = '"+BD6->BD6_SEQUEN+"' "
							cSQLTmp += " AND BD7_CODPRO = '"+BD6->BD6_CODPRO+"' "
							cSQLTmp += " AND SubStr(BD7_NUMLOT,1,6) = '"+cAno+cMes+"' "
							cSQLTmp += " AND D_E_L_E_T_ = ' ' "
							
							PLSQUERY(cSQLTmp,"TRBBD7")							
							nVlrTotBD7 := TRBBD7->TOTPAG							
							TRBBD7->(DbCloseArea())
							
							cNomRDABD6 := BD6->BD6_NOMRDA
							If Empty(cNomRDABD6)
								cNomRDABD6 := Posicione("BAU",1,xFilial("BAU")+BD6->BD6_CODRDA,"BAU_NOME")
							Endif
							
							cLin := Space(1)+cEOL
							cCpo :=	"10"+; //D01
							cNumFun+; //D02 e D03  //Iif(Empty(cNumDep),"00",cNumDep)+; //D03
							Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123")+; //D04
							Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705")+; //D05
							cCPFUsr+; //D06
							cNomUsr+; //D07
							BA1->BA1_MATRIC+Space(4)+; //D08
							cMatTit+; //D09
							BA1->BA1_TIPREG+Space(2)+; //D10
							"01"+; //D11
							BD6->(BD6_ANOPAG+BD6_MESPAG)+; //D12
							cDatPro+; //D13
							Alltrim(cNomRDABD6)+Space(50-Len(Alltrim(cNomRDABD6)))+; //D14
							Alltrim(BD6->BD6_DESPRO)+Space(90-Len(Alltrim(BD6->BD6_DESPRO)))+; //D15
							"D"+; //D16
							StrZero(nVlrTotBD7*100,15)+; //D17
							cIndFM+; //D18
							StrZero(nVlrPro*100,15)+; //D19
							BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)+Space(6)+; //D20
							Space(20)+; //D21
							"I"+; //D22
							Space(145)+; //D23
							Space(1)+;//D24
							Space(10)+;//D25
							StrZero(nCont,10) //D26
							
							nCont++
							lPodImp20 := .T.
							
							If !(U_GrLinha_TXT(cCpo,cLin))
								MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAгцO ABORTADA!")
								Return
							Endif
							
							If cIndFM == "S"
								nQtdImp+=BD6->BD6_QTDPRO
							Endif
							
							//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Nova regra: mesma guia pode ser exportada varias vezes, porem soh   Ё
							//Ё deve ser marcada na primeira exportacao. Nas demais, nao marcar...  Ё
							//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды							
							If Empty(BD6->BD6_YFTITA)
								BD6->(Reclock("BD6",.F.))
								BD6->BD6_YFTITA := cCodExp
								BD6->BD6_YERITA := "00"
								BD6->BD6_YVLITA := nVlrPro
								BD6->BD6_YMTEMI := cNumFun
								BD6->BD6_YINFTM := cIndFM
								BD6->(MsUnlock())
							Endif
								
							//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Totais para linha de Trailler do detalhe...                         Ё
							//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							nQtdProcF ++
							nVlrProcF += nVlrTotBD7
							nQtdProFM += Iif(cIndFM=="S",1,0)
							nVlrCobFM += nVlrPro
							nVlrAgrFM += Iif(U_BusTipUsu(BD6->BD6_OPEUSR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG) == "T",0,nVlrPro)
							nVlrTFaFM += Iif(U_BusTipUsu(BD6->BD6_OPEUSR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG) <> "T",0,nVlrPro)
							
							
							//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Totais para linha de Trailler geral do arquivo...                   Ё
							//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							nVltTotPro += nVlrTotBD7
							nTotProcFM += Iif(cIndFM=="S",1,0)
							nTotCobrFM += nVlrPro
							nTotAgreFM += Iif(U_BusTipUsu(BD6->BD6_OPEUSR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG) == "T",0,nVlrPro)
							nTotTtFaFM += Iif(U_BusTipUsu(BD6->BD6_OPEUSR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG) <> "T",0,nVlrPro)
							
							
							//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Zerar variaveis de fator moderador Itau...                          Ё
							//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							cIndFm := "N"
							nQtdExc := 0
							nVlrPro := 0							
							nVlrTotBD7 := 0
							
							BD6->(DbSkip())
							
						Enddo
						
					Endif
					
					BA1->(DbSkip())
					
				Enddo
			Else
//				aadd(aErro,{"UsuАrio sem matrМcula da empresa informada! "+BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)})			
				aadd(aErro,{"UsuАrio sem matrМcula da empresa informada! " + cFamAnt })			
			Endif
			EndIf
			
			RestArea(aArBA1)
			RestArea(aArBD6)
			RestArea(aArBKD)
			RestArea(aArBKE)
			
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Final da mudanca de escopo / busca de agregados...                  Ё
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды						
			If lPodImp20
				cLin := Space(1)+cEOL
				cCpo :=	"20"+; //TD01
				cNumFun+; //TD02
				Replicate("9",12)+; //TD03
				StrZero(nQtdProcF,9)+; //TD04
				StrZero(nVlrProcF*100,15)+; //TD05
				StrZero(nQtdProFM,9)+; //TD06
				StrZero(nVlrCobFM*100,15)+; //TD07
				StrZero(nVlrAgrFM*100,15)+; //TD08
				StrZero(nVlrTFaFM*100,15)+; //TD09
				Space(370)+; //TD10
				Replicate("0",9)+; //TD11
				Space(10)+; //TD12
				StrZero(nCont,10) //TD13
				
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE O CABEгALHO! OPERAгцO ABORTADA!")
					Return
				Endif
				
				nQtdTPF += nQtdProcF
				nVlrTPF += nVlrProcF
				
				nQtdProcF := 0
				nVlrProcF := 0
				nQtdProFM := 0
				nVlrCobFM := 0
				nVlrAgrFM := 0
				nVlrTFaFM := 0
				
				nCont++
				lPodImp20 := .F.
				
			Endif
			
		Endif
		
		cFamAnt := TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)
		cMatAnt := TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)
		
		If BA3->(MsSeek(xFilial("BA3")+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)))
			
			If Empty(cMatTit) .Or. TRB->BD6_TIPREG <> "00"
				If BA1->(MsSeek(xFilial("BA1")+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)+"00"))
					cMatTit := Substr(BA1->BA1_CODINT,2,3)+BA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
				Else
					aadd(aErro,{"Titular nao encontrado! "+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)+"00"})
					TRB->(DbSkip())
					Loop
				Endif
			Endif
			
			If BA1->(MsSeek(xFilial("BA1")+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)))
				cCPFUsr := Iif(Empty(BA1->BA1_CPFUSR),BA1->BA1_CPFPRE,BA1->BA1_CPFUSR)
				cNomUsr	:= Substr(Alltrim(BA1->BA1_NOMUSR),1,30)+Space(30-Len(Substr(Alltrim(BA1->BA1_NOMUSR),1,30)))
				cMatTit := Iif(BA1->BA1_TIPREG == "00",Substr(BA1->BA1_CODINT,2,3)+BA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG),Alltrim(cMatTit))
				cNumDep := BA1->BA1_YDEPEN
				
// Comentado por Luzio em 02/07/08, para que a rotina envie toda a matricula contida no campo BA1_MATEMP
/*				If Len(Alltrim(BA1->BA1_MATEMP)) > 9
					//cNumFun := StrZero(Val(BA1->BA1_MATEMP),9)
					cNumFun := Substr(Alltrim(BA1->BA1_MATEMP),1,9)
					If Len(Alltrim(cNumFun)) < 9
						cNumFun := Alltrim(cNumFun)+Space(9-Len(cNumFun))
					Endif

					
				Else
					cNumFun := Replicate("0",9-Len(Alltrim(BA1->BA1_MATEMP)))+Alltrim(BA1->BA1_MATEMP)
				Endif
*/
				cNumFun := Replicate("0",11-Len(Alltrim(BA1->BA1_MATEMP)))+Alltrim(BA1->BA1_MATEMP)
				If Substr(Alltrim(BA1->BA1_MATEMP),1,1) = "_"
				  cNumFun := Substr(Alltrim(BA1->BA1_MATEMP),2,11)
				Endif
//				If Len(Alltrim(cNumFun)) < 11
//					cNumFun := Alltrim(cNumFun)+Space(11-Len(cNumFun))
//				Endif
			Else
				aadd(aErro,{"Usuario nao encontrado! "+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG)})
				TRB->(DbSkip())
				Loop
			Endif
		Else
			aadd(aErro,{"Familia nao encontrada! "+TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC)})
			TRB->(DbSkip())
			Loop
		Endif
		
		If ascan(aImpresso,TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)) <> 0
			TRB->(DbSkip())
			Loop
		Endif                                                                                                                          									
		aadd(aImpresso,TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN))				
		
// Trecho de codigo incluido por Luzio em 02/07/08, para que critique quando a data de atendimento 
// for maior que a data de bloqueio do usuario.
		If TRB->BD6_DATPRO > dDatBlo
			aadd(aErro,{"Data do Atendimento maior que a data do bloqueio, sujeito a rejeicao. Verifique! "+TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)})
			TRB->(DbSkip())
			Loop
		Endif
							
		dDatPro := Iif(Empty(TRB->BD6_DATPRO),	Iif(TRB->BD6_ORIMOV=="1",Posicione("BD5",1,xFilial("BD5")+TRB->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BD5_DATPRO"),Posicione("BE4",1,xFilial("BE4")+TRB->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BE4_DATPRO")),TRB->BD6_DATPRO)
		cDatPro := Substr(DtoS(dDatPro),7,2)+"."+Substr(DtoS(dDatPro),5,2)+"."+Substr(DtoS(dDatPro),1,4)
		
		If Len(aVetUti)>0            
		
			nPos1 := 0
			nPos := Ascan(aVetUti, { |x| AllTrim(x[1]) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) } )
			
			If nPos > 0
				
				While nPos <= Len(aVetUti)
					
					If aVetUti[nPos,1] <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
						nPos1 := 0
						Exit
					Endif
					
					If aVetUti[nPos,3] $ Iif(Alltrim(TRB->BD6_CODPRO)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),"00010014",Alltrim(TRB->BD6_CODPRO))
						nPos1 := nPos
						Exit
					Endif
					
					nPos++
				Enddo
				
				If nPos1 > 0
					If aVetUti[nPos1,7] > 0
						cIndFM := "S"
					Endif
					
					
					//Se qtd permitida < soma do historico+impresso+item em questao
					If aVetUti[nPos1,7] < aVetUti[nPos1,4]+nQtdImp+TRB->BD6_QTDPRO .And. aVetUti[nPos1,7] > 0						
						nQtdExc := TRB->BD6_QTDPRO
						nVlrPro := (aVetUti[1,8]*nQtdExc)
					Endif
				Endif
				
			Endif
			
		Endif
		
		cSQLTmp := " SELECT SUM(BD7_VLRPAG) AS TOTPAG "
		cSQLTmp += " FROM "+cNameBD7+" BD7 " 
		cSQLTmp += " WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
		cSQLTmp += " AND BD7_CODOPE = '"+TRB->BD6_CODOPE+"' "
		cSQLTmp += " AND BD7_CODLDP = '"+TRB->BD6_CODLDP+"' "
		cSQLTmp += " AND BD7_CODPEG = '"+TRB->BD6_CODPEG+"' "
		cSQLTmp += " AND BD7_NUMERO = '"+TRB->BD6_NUMERO+"' "
		cSQLTmp += " AND BD7_ORIMOV = '"+TRB->BD6_ORIMOV+"' "
		cSQLTmp += " AND BD7_SEQUEN = '"+TRB->BD6_SEQUEN+"' "
		cSQLTmp += " AND BD7_CODPRO = '"+TRB->BD6_CODPRO+"' "
		cSQLTmp += " AND SubStr(BD7_NUMLOT,1,6) = '"+cAno+cMes+"' "
		cSQLTmp += " AND D_E_L_E_T_ = ' ' "
		
		PLSQUERY(cSQLTmp,"TRBBD7")							
		nVlrTotBD7 := TRBBD7->TOTPAG							
		TRBBD7->(DbCloseArea())		
		
		cNomRDABD6 := TRB->BD6_NOMRDA
		If Empty(cNomRDABD6)
			cNomRDABD6 := Posicione("BAU",1,xFilial("BAU")+TRB->BD6_CODRDA,"BAU_NOME")
		Endif
		
		cLin := Space(1)+cEOL
		cCpo :=	"10"+; //D01
		cNumFun+; //D02 e D03 //Iif(Empty(cNumDep),"00",cNumDep)+; //D03
		Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123")+; //D04
		Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705")+; //D05
		cCPFUsr+; //D06
		cNomUsr+; //D07
		BA1->BA1_MATRIC+Space(4)+; //D08
		cMatTit+; //D09
		BA1->BA1_TIPREG+Space(2)+; //D10
		"01"+; //D11
		TRB->(BD6_ANOPAG+BD6_MESPAG)+; //D12
		cDatPro+; //D13
		Alltrim(cNomRDABD6)+Space(50-Len(Alltrim(cNomRDABD6)))+; //D14
		Alltrim(TRB->BD6_DESPRO)+Space(90-Len(Alltrim(TRB->BD6_DESPRO)))+; //D15
		"D"+; //D16
		StrZero(nVlrTotBD7*100,15)+; //D17
		cIndFM+; //D18
		StrZero(nVlrPro*100,15)+; //D19
		TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)+Space(6)+; //D20
		Space(20)+; //D21
		"I"+; //D22
		Space(145)+; //D23
		Space(1)+;//D24
		Space(10)+;//D25
		StrZero(nCont,10) //D26
		
		nCont++
		lPodImp20 := .T.
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAгцO ABORTADA!")
			Return
		Endif
		
		If cIndFM == "S"
			nQtdImp+=TRB->BD6_QTDPRO
		Endif
		
		BD6->(DbGoto(TRB->(REGBD6)))
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Nova regra: mesma guia pode ser exportada varias vezes, porem soh   Ё
		//Ё deve ser marcada na primeira exportacao. Nas demais, nao marcar...  Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды							
		If Empty(BD6->BD6_YFTITA)
			BD6->(Reclock("BD6",.F.))
			BD6->BD6_YFTITA := cCodExp
			BD6->BD6_YERITA := "00"
			BD6->BD6_YVLITA := nVlrPro
			BD6->BD6_YMTEMI := cNumFun
			BD6->BD6_YINFTM := cIndFM
			BD6->(MsUnlock())
		Endif
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totais para linha de Trailler do detalhe...                         Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nQtdProcF ++
		nVlrProcF += nVlrTotBD7
		nQtdProFM += Iif(cIndFM=="S",1,0)
		nVlrCobFM += nVlrPro
		nVlrAgrFM += Iif(U_BusTipUsu(TRB->BD6_OPEUSR, TRB->BD6_CODEMP, TRB->BD6_MATRIC, TRB->BD6_TIPREG) == "T",0,nVlrPro)
		nVlrTFaFM += Iif(U_BusTipUsu(TRB->BD6_OPEUSR, TRB->BD6_CODEMP, TRB->BD6_MATRIC, TRB->BD6_TIPREG) <> "T",0,nVlrPro)
		
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totais para linha de Trailler geral do arquivo...                   Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nVltTotPro += nVlrTotBD7
		nTotProcFM += Iif(cIndFM=="S",1,0)
		nTotCobrFM += nVlrPro
		nTotAgreFM += Iif(U_BusTipUsu(TRB->BD6_OPEUSR, TRB->BD6_CODEMP, TRB->BD6_MATRIC, TRB->BD6_TIPREG) == "T",0,nVlrPro)
		nTotTtFaFM += Iif(U_BusTipUsu(TRB->BD6_OPEUSR, TRB->BD6_CODEMP, TRB->BD6_MATRIC, TRB->BD6_TIPREG) <> "T",0,nVlrPro)
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Zerar variaveis de fator moderador Itau...                          Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cIndFm := "N"
		nQtdExc := 0
		nVlrPro := 0
		nVlrTotBD7 := 0
		
		TRB->(DbSkip())
		
	EndDo
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verificar se existe reembolso para o ultimo usuario...                          Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If BKD->(MsSeek(xFilial("BKD")+Substr(cMatAnt,1,16)+cAno+cMes))
		
		While !BKD->(Eof()) .And. BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS) == Substr(cMatAnt,1,16)+cAno+cMes
			
			BKE->(MsSeek(xFilial("BKE")+BKD->BKD_CODRBS))
			
			While !BKE->(Eof()) .And. BKD->BKD_CODRBS == BKE->BKE_CODRBS
				
// Trecho de codigo incluido por Luzio em 02/07/08, para que critique quando a data de atendimento 
// for maior que a data de bloqueio do usuario.
				If BKD->BKD_DATA > dDatBlo
					aadd(aErro,{"Data do Atendimento maior que a data do bloqueio, sujeito a rejeicao. Verifique! "+BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS)})
					BKE->(DbSkip())
					Loop
				Endif

				dDatPro := BKD->BKD_DATA
				cDatPro := Substr(DtoS(dDatPro),7,2)+"."+Substr(DtoS(dDatPro),5,2)+"."+Substr(DtoS(dDatPro),1,4)
				
				If !Empty(BKE->BKE_YFTITA)
					BKE->(DbSkip())
					Loop
				Endif											

				If ascan(aImpresso,"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)))) <> 0
					BKE->(DbSkip())
					Loop
				Endif                                                                                                                          									
				aadd(aImpresso,"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO))))
				
				If Len(aVetUti)>0
					
					nPos1 := 0
					nPos := Ascan(aVetUti, { |x| AllTrim(x[1]) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) } )
					
					If nPos > 0
						
						While nPos <= Len(aVetUti)
							
							If aVetUti[nPos,1] <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
								nPos1 := 0
								Exit
							Endif
							
							If aVetUti[nPos,3] $ Iif(Alltrim(BKE->BKE_CODPRO)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),"00010014",Alltrim(BKE->BKE_CODPRO))
								nPos1 := nPos
								Exit
							Endif
							
							nPos++
						Enddo
						
						If nPos1 > 0
							If aVetUti[nPos1,7] > 0
								cIndFM := "S"
							Endif
							
							
							//Se qtd permitida < soma do historico+impresso+item em questao
							If aVetUti[nPos1,7] < aVetUti[nPos1,4]+nQtdImp+BKE->BKE_QTDPRO .And. aVetUti[nPos1,7] > 0								
								nQtdExc := BKE->BKE_QTDPRO								
								nVlrPro := (aVetUti[1,8]*nQtdExc)
							Endif
						Endif
						
					Endif
					
				Endif
				
				cLin := Space(1)+cEOL
				cCpo :=	"10"+; //D01
				cNumFun+; //D02 e D03 //Iif(Empty(cNumDep),"00",cNumDep)+; //D03
				Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123")+; //D04
				Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705")+; //D05
				cCPFUsr+; //D06
				cNomUsr+; //D07
				BA1->BA1_MATRIC+Space(4)+; //D08
				cMatTit+; //D09
				BA1->BA1_TIPREG+Space(2)+; //D10
				"01"+; //D11
				BKD->(BKD_ANOBAS+BKD_MESBAS)+; //D12
				cDatPro+; //D13
				Alltrim(Posicione("BK6",3,xFilial("BK6")+BKD->BKD_CODCRE,"BK6_NOME"))+Space(50-Len(Alltrim(Posicione("BK6",3,xFilial("BK6")+BKD->BKD_CODCRE,"BK6_NOME"))))+; //D14
				Alltrim(Posicione("BR8",3,xFilial("BR8")+BKE->BKE_CODPRO,"BR8_DESCRI"))+Space(90-Len(Alltrim(Posicione("BR8",3,xFilial("BR8")+BKE->BKE_CODPRO,"BR8_DESCRI"))))+; //D15
				"D"+; //D16
				StrZero(BKE->BKE_VLRRBS*100,15)+; //D17
				cIndFM+; //D18
				StrZero(nVlrPro*100,15)+; //D19
				"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)))+; //D20
				Space(20)+; //D21
				"I"+; //D22
				Space(145)+; //D23
				Space(1)+;//D24
				Space(10)+;//D25
				StrZero(nCont,10) //D26
				
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAгцO ABORTADA!")
					Return
				Endif
				
				If cIndFM == "S"
					nQtdImp+=BKE->BKE_QTDPRO
				Endif
				
				nCont++ 
				lPodImp20 := .T.
				
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Totais para linha de Trailler do detalhe...                         Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				nQtdProcF ++
				nVlrProcF += BKE->BKE_VLRRBS
				nQtdProFM += Iif(cIndFM=="S",1,0)
				nVlrCobFM += nVlrPro
				nVlrAgrFM += Iif(U_BusTipUsu(BKD->BKD_OPEUSR, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) == "T",0,nVlrPro)
				nVlrTFaFM += Iif(U_BusTipUsu(BKD->BKD_OPEUSR, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) <> "T",0,nVlrPro)
				
				
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Totais para linha de Trailler geral do arquivo...                   Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				nVltTotPro += BKE->BKE_VLRRBS
				nTotProcFM += Iif(cIndFM=="S",1,0)
				nTotCobrFM += nVlrPro
				nTotAgreFM += Iif(U_BusTipUsu(BKD->BKD_OPEUSR, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) == "T",0,nVlrPro)
				nTotTtFaFM += Iif(U_BusTipUsu(BKD->BKD_OPEUSR, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) <> "T",0,nVlrPro)
				
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Zerar variaveis de fator moderador Itau...                          Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				cIndFm := "N"
				nQtdExc := 0
				nVlrPro := 0
				
				BKE->(DbSkip())
				
			Enddo
			
			BKD->(DbSkip())
			
		Enddo
		
	Endif
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Mudanca de escopo, mudar busca de agregados (Reembolso e Cts MedicasЁ
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aArBA1 := BA1->(GetArea())
	aArBD6 := BD6->(GetArea())
	aArBKD := BKD->(GetArea())
	aArBKE := BKE->(GetArea())
	
	BA1->(DbSetOrder(2))
	BA1->(MsSeek(xFilial("BA1")+cFamAnt+"00"))
	If !BA1->(Found())
		aadd(aErro,{"Titular nao encontrado! - Nivel 4" + cFamAnt + "00"})
	Else
	
	cMatEmpAgr := BA1->BA1_MATEMP
	
	If !Empty(cMatEmpAgr)
		
		BA1->(DbSetOrder(6)) //MATEMP
		BA1->(MsSeek(xFilial("BA1")+cMatEmpAgr))		
		
		While !BA1->(Eof()) .And. BA1->BA1_MATEMP == cMatEmpAgr
			
			//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Garantir que familia ja exportada anteriormente nao seja reenviada. Ё
			//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If cFamAnt <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)

//Inserido por Luzio em 02/07/08 para que recupere a data de bloqueio do usuario contida no BA1
				dDatBlo    := BA1->BA1_DATBLO
				
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Informacoes necessarias para a exportacao dos dados...              Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				nQtdImp := 0
				If BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
// Comentado por Luzio em 02/07/08, para que a rotina envie toda a matricula contida no campo BA1_MATEMP
/*					If Len(Alltrim(BA1->BA1_MATEMP)) > 9
						//cNumFun := StrZero(Val(BA1->BA1_MATEMP),9)
						cNumFun := Substr(Alltrim(BA1->BA1_MATEMP),1,9)
						If Len(Alltrim(cNumFun)) < 9
							cNumFun := Alltrim(cNumFun)+Space(9-Len(cNumFun))
						Endif

					Else
						cNumFun := Replicate("0",9-Len(Alltrim(BA1->BA1_MATEMP)))+Alltrim(BA1->BA1_MATEMP)
					Endif
*/
					cNumFun := Replicate("0",11-Len(Alltrim(BA1->BA1_MATEMP)))+Alltrim(BA1->BA1_MATEMP)
					If Substr(Alltrim(BA1->BA1_MATEMP),1,1) = "_"
					  cNumFun := Substr(Alltrim(BA1->BA1_MATEMP),2,11)
					Endif
//					If Len(Alltrim(cNumFun)) < 11
//						cNumFun := Alltrim(cNumFun)+Space(11-Len(cNumFun))
//					Endif
					
					aGetUsr := BA1->(GetArea())
					BA1->(DbSetOrder(2))
					If Empty(cMatTit) .Or. BA1->BA1_TIPREG <> "00"
						If BA1->(MsSeek(xFilial("BA1")+cFamAnt+"00"))
							cMatTit := Substr(BA1->BA1_CODINT,2,3)+BA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						Else
							aadd(aErro,{"Titular nao encontrado! "+cFamAnt+"00"})
							BA1->(DbSkip())
							Loop
						Endif
					Endif
					
					RestArea(aGetUsr)
					cCPFUsr := Iif(Empty(BA1->BA1_CPFUSR),BA1->BA1_CPFPRE,BA1->BA1_CPFUSR)
					cNomUsr	:= Substr(Alltrim(BA1->BA1_NOMUSR),1,30)+Space(30-Len(Substr(Alltrim(BA1->BA1_NOMUSR),1,30)))
					cMatTit := Iif(BA1->BA1_TIPREG == "00",Substr(BA1->BA1_CODINT,2,3)+BA1->(BA1_CODEMP+BA1_MATRIC+BA1_TIPREG),Alltrim(cMatTit))
					cNumDep := BA1->BA1_YDEPEN
					
				Else
					aadd(aErro,{"Familia nao encontrada! "+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)})
					BA1->(DbSkip())
					Loop
				Endif
				
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Buscar e imprimir reembolsos dos agregados...                       Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If BKD->(MsSeek(xFilial("BKD")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)+cAno+cMes))
					
					While !BKD->(Eof()) .And. BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)+cAno+cMes
						
						BKE->(MsSeek(xFilial("BKE")+BKD->BKD_CODRBS))
						
						While !BKE->(Eof()) .And. BKD->BKD_CODRBS == BKE->BKE_CODRBS
							
							If !Empty(BKE->BKE_YFTITA)
								BKE->(DbSkip())
								Loop
							Endif
							
							If ascan(aImpresso,"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)))) <> 0
								BKE->(DbSkip())
								Loop
							Endif                                                                                                                          									
							aadd(aImpresso,"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO))))
														
// Trecho de codigo incluido por Luzio em 02/07/08, para que critique quando a data de atendimento 
// for maior que a data de bloqueio do usuario.
							If BKD->BKD_DATA > dDatBlo
								aadd(aErro,{"Data do Atendimento maior que a data do bloqueio, sujeito a rejeicao. Verifique! "+BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS)})
								BKE->(DbSkip())
								Loop
							Endif

							dDatPro := BKD->BKD_DATA
							cDatPro := Substr(DtoS(dDatPro),7,2)+"."+Substr(DtoS(dDatPro),5,2)+"."+Substr(DtoS(dDatPro),1,4)
							
							If Len(aVetUti)>0
								
								nPos1 := 0
								nPos := Ascan(aVetUti, { |x| AllTrim(x[1]) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) } )
								
								If nPos > 0
									
									While nPos <= Len(aVetUti)
										
										If aVetUti[nPos,1] <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
											nPos1 := 0
											Exit
										Endif
										
										If aVetUti[nPos,3] $ Iif(Alltrim(BKE->BKE_CODPRO)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),"00010014",Alltrim(BKE->BKE_CODPRO))
											nPos1 := nPos
											Exit
										Endif
										
										nPos++
									Enddo
									
									If nPos1 > 0
										If aVetUti[nPos1,7] > 0
											cIndFM := "S"
										Endif
										
										
										//Se qtd permitida < soma do historico+impresso+item em questao
										If aVetUti[nPos1,7] < aVetUti[nPos1,4]+nQtdImp+BKE->BKE_QTDPRO .And. aVetUti[nPos1,7] > 0											
											nQtdExc := BKE->BKE_QTDPRO											
											nVlrPro := (aVetUti[1,8]*nQtdExc)
										Endif
									Endif
									
								Endif
								
							Endif
							
							cLin := Space(1)+cEOL
							cCpo :=	"10"+; //D01
							cNumFun+; //D02 e D03 //Iif(Empty(cNumDep),"00",cNumDep)+; //D03
							Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123")+; //D04
							Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705")+; //D05
							cCPFUsr+; //D06
							cNomUsr+; //D07
							BA1->BA1_MATRIC+Space(4)+; //D08
							cMatTit+; //D09
							BA1->BA1_TIPREG+Space(2)+; //D10
							"05"+; //D11
							BKD->(BKD_ANOBAS+BKD_MESBAS)+; //D12
							cDatPro+; //D13
							Alltrim(Posicione("BK6",3,xFilial("BK6")+BKD->BKD_CODCRE,"BK6_NOME"))+Space(50-Len(Alltrim(Posicione("BK6",3,xFilial("BK6")+BKD->BKD_CODCRE,"BK6_NOME"))))+; //D14
							Alltrim(Posicione("BR8",3,xFilial("BR8")+BKE->BKE_CODPRO,"BR8_DESCRI"))+Space(90-Len(Alltrim(Posicione("BR8",3,xFilial("BR8")+BKE->BKE_CODPRO,"BR8_DESCRI"))))+; //D15
							"D"+; //D16
							StrZero(BKE->BKE_VLRRBS*100,15)+; //D17
							cIndFM+; //D18
							StrZero(nVlrPro*100,15)+; //D19
							"RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)+Space(30-Len("RBS"+BKD->BKD_CODRBS+Alltrim(BKE->BKE_CODPRO)))+; //D20
							Space(20)+; //D21
							"I"+; //D22
							Space(145)+; //D23
							Space(1)+;//D24
							Space(10)+;//D25
							StrZero(nCont,10) //D26
							
							If !(U_GrLinha_TXT(cCpo,cLin))
								MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAгцO ABORTADA!")
								Return
							Endif
							
							If cIndFM == "S"
								nQtdImp+= BKE->BKE_QTDPRO
							Endif
							
							BKE->(Reclock("BKE",.F.))
							BKE->BKE_YFTITA := cCodExp
							BKE->BKE_YERITA := "00"
							BKE->BKE_YVLITA := nVlrPro
							BKE->BKE_YMTEMI := cNumFun
							BKE->BKE_YINFTM := cIndFM																
							BKE->(MsUnlock())
							
							nCont++
							lPodImp20 := .T.
							
							//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Totais para linha de Trailler do detalhe...                         Ё
							//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							nQtdProcF ++
							nVlrProcF += BKE->BKE_VLRRBS
							nQtdProFM += Iif(cIndFM=="S",1,0)
							nVlrCobFM += nVlrPro
							nVlrAgrFM += Iif(U_BusTipUsu(BKD->BKD_OPEUSR, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) == "T",0,nVlrPro)
							nVlrTFaFM += Iif(U_BusTipUsu(BKD->BKD_OPEUSR, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) <> "T",0,nVlrPro)
							
							
							
							//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Totais para linha de Trailler geral do arquivo...                   Ё
							//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							nVltTotPro += BKE->BKE_VLRRBS
							nTotProcFM += Iif(cIndFM=="S",1,0)
							nTotCobrFM += nVlrPro
							nTotAgreFM += Iif(U_BusTipUsu(BKD->BKD_OPEUSR, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) == "T",0,nVlrPro)
							nTotTtFaFM += Iif(U_BusTipUsu(BKD->BKD_OPEUSR, BKD->BKD_CODEMP, BKD->BKD_MATRIC, BKD->BKD_TIPREG) <> "T",0,nVlrPro)
							
							//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
							//Ё Zerar variaveis de fator moderador Itau...                          Ё
							//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
							cIndFm := "N"
							nQtdExc := 0
							nVlrPro := 0
							
							BKE->(DbSkip())
							
						Enddo
						
						BKD->(DbSkip())
						
					Enddo
					
				Endif
				
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Imprimir itens de contas dos agregados...                           Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				//BD6->(DbSetOrder(10))
				BD6->( dbOrderNickName( "INDITAU" ) )
				BD6->(MsSeek(xFilial("BD6")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)))
				
				While !BD6->(Eof()) .And. BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO)==BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
				
					If BD6->(BD6_CONEMP+BD6_VERCON) <> cConEmp+cVerCon
						BD6->(DbSkip())
						Loop				
					Endif				
				                                         
					If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
						If BD7->BD7_FASE <> '4' .OR. SubStr(BD7->BD7_NUMLOT,1,6) <> cAno+cMes 
							BD6->(DbSkip())
							Loop
						Endif							
					Endif

					/*					
					If BD6->(BD6_ANOPAG+BD6_MESPAG) <> cAno+cMes
						BD6->(DbSkip())
						Loop
					Endif
					*/
					
					If ascan(aImpresso,BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)) <> 0
						BD6->(DbSkip())
						Loop
					Endif                                                                                                                          									
					aadd(aImpresso,BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN))

// Trecho de codigo incluido por Luzio em 02/07/08, para que critique quando a data de atendimento 
// for maior que a data de bloqueio do usuario.
					If BD6->BD6_DATPRO > dDatBlo
						aadd(aErro,{"Data do Atendimento maior que a data do bloqueio, sujeito a rejeicao. Verifique! "+BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)})
						BD6->(DbSkip())
						Loop
					Endif

					dDatPro := Iif(Empty(BD6->BD6_DATPRO),	Iif(BD6->BD6_ORIMOV=="1",Posicione("BD5",1,xFilial("BD5")+BD6->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BD5_DATPRO"),Posicione("BE4",1,xFilial("BE4")+BD6->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BE4_DATPRO")),BD6->BD6_DATPRO)
					cDatPro := Substr(DtoS(dDatPro),7,2)+"."+Substr(DtoS(dDatPro),5,2)+"."+Substr(DtoS(dDatPro),1,4)
					
					If Len(aVetUti)>0
					
						nPos1 := 0
						nPos := Ascan(aVetUti, { |x| AllTrim(x[1]) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) } )
						
						If nPos > 0
							
							While nPos <= Len(aVetUti)
								
								If aVetUti[nPos,1] <> BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
									nPos1 := 0
									Exit
								Endif
								
								If aVetUti[nPos,3] $ Iif(Alltrim(BD6->BD6_CODPRO)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),"00010014",Alltrim(BD6->BD6_CODPRO))
									nPos1 := nPos
									Exit
								Endif
								
								nPos++
							Enddo
							
							If nPos1 > 0
								If aVetUti[nPos1,7] > 0
									cIndFM := "S"
								Endif
								
								
								//Se qtd permitida < soma do historico+impresso+item em questao
								If aVetUti[nPos1,7] < aVetUti[nPos1,4]+nQtdImp+BD6->BD6_QTDPRO .And. aVetUti[nPos1,7] > 0									
									nQtdExc := BD6->BD6_QTDPRO
									nVlrPro := (aVetUti[1,8]*nQtdExc)
								Endif
							Endif
							
						Endif
						
					Endif   
					
					cSQLTmp := " SELECT SUM(BD7_VLRPAG) AS TOTPAG "
					cSQLTmp += " FROM "+cNameBD7+" BD7 " 
					cSQLTmp += " WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "
					cSQLTmp += " AND BD7_CODOPE = '"+BD6->BD6_CODOPE+"' "
					cSQLTmp += " AND BD7_CODLDP = '"+BD6->BD6_CODLDP+"' "
					cSQLTmp += " AND BD7_CODPEG = '"+BD6->BD6_CODPEG+"' "
					cSQLTmp += " AND BD7_NUMERO = '"+BD6->BD6_NUMERO+"' "
					cSQLTmp += " AND BD7_ORIMOV = '"+BD6->BD6_ORIMOV+"' "
					cSQLTmp += " AND BD7_SEQUEN = '"+BD6->BD6_SEQUEN+"' "
					cSQLTmp += " AND BD7_CODPRO = '"+BD6->BD6_CODPRO+"' "
					cSQLTmp += " AND SubStr(BD7_NUMLOT,1,6) = '"+cAno+cMes+"' "
					cSQLTmp += " AND D_E_L_E_T_ = ' ' "
					
					PLSQUERY(cSQLTmp,"TRBBD7")							
					nVlrTotBD7 := TRBBD7->TOTPAG							
					TRBBD7->(DbCloseArea())

					cNomRDABD6 := BD6->BD6_NOMRDA
					If Empty(cNomRDABD6)
						cNomRDABD6 := Posicione("BAU",1,xFilial("BAU")+BD6->BD6_CODRDA,"BAU_NOME")
					Endif					
			
					cLin := Space(1)+cEOL
					cCpo :=	"10"+; //D01
					cNumFun+; //D02 e D03 //Iif(Empty(cNumDep),"00",cNumDep)+; //D03
					Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"01115","01123")+; //D04
					Iif(GetNewPar("MV_YCONITA","000000000001")==cConEmp,"04697","04705")+; //D05
					cCPFUsr+; //D06
					cNomUsr+; //D07
					BA1->BA1_MATRIC+Space(4)+; //D08
					cMatTit+; //D09
					BA1->BA1_TIPREG+Space(2)+; //D10
					"01"+; //D11
					BD6->(BD6_ANOPAG+BD6_MESPAG)+; //D12
					cDatPro+; //D13
					Alltrim(cNomRDABD6)+Space(50-Len(Alltrim(cNomRDABD6)))+; //D14
					Alltrim(BD6->BD6_DESPRO)+Space(90-Len(Alltrim(BD6->BD6_DESPRO)))+; //D15
					"D"+; //D16
					StrZero(nVlrTotBD7*100,15)+; //D17
					cIndFM+; //D18
					StrZero(nVlrPro*100,15)+; //D19
					BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)+Space(6)+; //D20
					Space(20)+; //D21
					"I"+; //D22
					Space(145)+; //D23
					Space(1)+;//D24
					Space(10)+;//D25
					StrZero(nCont,10) //D26
					
					nCont++
					lPodImp20 := .T.
					
					If !(U_GrLinha_TXT(cCpo,cLin))
						MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAгцO ABORTADA!")
						Return
					Endif
					
					If cIndFM == "S"
						nQtdImp+=BD6->BD6_QTDPRO
					Endif
					
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Nova regra: mesma guia pode ser exportada varias vezes, porem soh   Ё
					//Ё deve ser marcada na primeira exportacao. Nas demais, nao marcar...  Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды							
					If Empty(BD6->BD6_YFTITA)					
						BD6->(Reclock("BD6",.F.))
						BD6->BD6_YFTITA := cCodExp
						BD6->BD6_YERITA := "00"
						BD6->BD6_YVLITA := nVlrPro
						BD6->BD6_YMTEMI := cNumFun
						BD6->BD6_YINFTM := cIndFM
						BD6->(MsUnlock())
					Endif
					
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Totais para linha de Trailler do detalhe...                         Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					nQtdProcF ++
					nVlrProcF += nVlrTotBD7
					nQtdProFM += Iif(cIndFM=="S",1,0)
					nVlrCobFM += nVlrPro
					nVlrAgrFM += Iif(U_BusTipUsu(BD6->BD6_OPEUSR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG) == "T",0,nVlrPro)
					nVlrTFaFM += Iif(U_BusTipUsu(BD6->BD6_OPEUSR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG) <> "T",0,nVlrPro)

					lPodImp20 := .T.
					
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Totais para linha de Trailler geral do arquivo...                   Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					nVltTotPro += nVlrTotBD7
					nTotProcFM += Iif(cIndFM=="S",1,0)
					nTotCobrFM += nVlrPro
					nTotAgreFM += Iif(U_BusTipUsu(BD6->BD6_OPEUSR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG) == "T",0,nVlrPro)
					nTotTtFaFM += Iif(U_BusTipUsu(BD6->BD6_OPEUSR, BD6->BD6_CODEMP, BD6->BD6_MATRIC, BD6->BD6_TIPREG) <> "T",0,nVlrPro)
					
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Zerar variaveis de fator moderador Itau...                          Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					cIndFm := "N"
					nQtdExc := 0
					nVlrPro := 0
					nVlrTotBD7 := 0
					
					BD6->(DbSkip())
					
				Enddo
				
			Endif
			
			BA1->(DbSkip())
			
		Enddo
	Else
		aadd(aErro,{"UsuАrio sem matrМcula da empresa informada! "+BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)})			
	Endif
	EndIf
	
	RestArea(aArBA1)
	RestArea(aArBD6)
	RestArea(aArBKD)
	RestArea(aArBKE)	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Final da mudanca de escopo / busca de agregados...                  Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprimir ultimo rodape do detalhe (registro 4)                      Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If lPodImp20
		cLin := Space(1)+cEOL
		cCpo :=	"20"+; //TD01
		cNumFun+; //TD02
		Replicate("9",12)+; //TD03
		StrZero(nQtdProcF,9)+; //TD04
		StrZero(nVlrProcF*100,15)+; //TD05
		StrZero(nQtdProFM,9)+; //TD06
		StrZero(nVlrCobFM*100,15)+; //TD07
		StrZero(nVlrAgrFM*100,15)+; //TD08
		StrZero(nVlrTFaFM*100,15)+; //TD09
		Space(370)+; //TD10
		Replicate("0",9)+; //TD11
		Replicate("0",10)+; //TD12
		StrZero(nCont,10) //TD13
		
		nCont++
		lPodImp20 := .F.
		
		nQtdTPF += nQtdProcF
		nVlrTPF += nVlrProcF
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE O TRAILLER DO DETALHE! OPERAгцO ABORTADA!")
			Return
		Endif
		
		nQtdProcF := 0
		nVlrProcF := 0
		nQtdProFM := 0
		nVlrCobFM := 0
		nVlrAgrFM := 0
		nVlrTFaFM := 0
	Endif

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Montagem do Trailler...                                             Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cLin := Space(1)+cEOL
	cCpo :=	"99"+; //T01
	Replicate("9",21)+; //T02
	StrZero(nCont,9)+; //T03
	StrZero(nVlrTPF*100,15)+; //T04
	StrZero(nTotProcFM,9)+; //T05
	StrZero(nTotCobrFM*100,15)+; //T06
	StrZero(nTotAgreFM*100,15)+; //T07
	StrZero(nTotTtFaFM*100,15)+; //T08
	Space(379)+; //T09
	Space(10)+; //T10
	StrZero(nCont,10) //TD11
	
	nCont++
	
	If !(U_GrLinha_TXT(cCpo,cLin))
		MsgAlert("ATENгцO! NцO FOI POSSмVEL GRAVAR CORRETAMENTE O REGISTRO TRAILLER! OPERAгцO ABORTADA!")
		Return
	Endif
	
	TRB->(DbCloseArea())
	U_Fecha_TXT()
	
	If Len(aErro) > 0
		PLSCRIGEN(aErro,{ {"DescriГЦo","@C",230} },"InconsistЙncias na exportaГЦo...",.T.)
	Endif
	
	
	//зддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Impressao do protocolo de exportacao.	  Ё
	//юддддддддддддддддддддддддддддддддддддддддддды
	If nLin > nQtdLin
		nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
	Endif
	
	@ nLin,000 PSay Replicate("-",63)
	nLin++
	@ nLin,000 PSay "GERAгцO DO ARQUIVO DE EXPORTAгцO FATOR MODERADOR / ITAз"
	nLin++
	@ nLin,000 PSay Replicate("-",64)
	nLin++
	@ nLin,000 PSay "Valor total exportado................: "+Transform(nVlrTPF,"@E 999,999,999.99")
	nLin++
	@ nLin,000 PSay "Qtd de registros com Fat. Moderador..: "+Transform(nTotProcFM,"@E 999,999,999.99")
	nLin++
	@ nLin,000 PSay "Valor total de Fat. Moderador........: "+Transform(nTotCobrFM,"@E 999,999,999.99")
	nLin++
	@ nLin,000 PSay "Total de Fat. Moderador Agregados....: "+Transform(nTotAgreFM,"@E 999,999,999.99")
	nLin++
	@ nLin,000 PSay "Total de Fat. Moderador Titulares....: "+Transform(nTotTtFaFM,"@E 999,999,999.99")
	nLin++
	
Endif

End Transaction

Return


/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммммммкмммммммяммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  Ё ParSX1       ╨Autor  ЁJean Schulz     ╨ Data Ё  15/11/05   ╨╠╠
╠╠лммммммммммьммммммммммммммймммммммоммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁCria parametros para exportacao.                            ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function ParSX1()

If cPerg == "YEXITA"
	PutSx1(cPerg,"01",OemToAnsi("Empresa")					,"","","mv_ch1","C",04,0,0,"G","","BG9A","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("Contrato/Versao")			,"","","mv_ch2","C",15,0,0,"G","","BT5PLS","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03",OemToAnsi("Ano Compet.")				,"","","mv_ch3","C",04,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04",OemToAnsi("MЙs Compet.")				,"","","mv_ch4","C",02,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"05",OemToAnsi("ObservaГЦo")				,"","","mv_ch5","C",60,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
Else
	PutSx1(cPerg,"01",OemToAnsi("Arquivo a importar "),"","","mv_ch1","C",60,0,0,"G","U_fGetFile('A0     (*.A0)            | *.A0 | ')","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
Endif

Return

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммммммкмммммммяммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  Ё Atu_Var      ╨Autor  ЁJean Schulz     ╨ Data Ё  25/10/05   ╨╠╠
╠╠лммммммммммьммммммммммммммймммммммоммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁAtualiza variaveis de parametros para uso no relatorio.     ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function Atu_Var()

cCodEmp	:= mv_par01
cConEmp	:= Substr(mv_par02,1,12)
cVerCon	:= Substr(mv_par02,13,3)
cAno	:= mv_par03
cMes	:= mv_par04
cObser	:= mv_par05
cCodExp := ""

Return




/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁBuscaRegs ╨Autor  ЁMicrosiga           ╨ Data Ё  15/10/06   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁSeleciona registros a serem utilizados pela rotina...       ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function BuscaRegs()
Local nCont	:= 1
Local cSQL	:= ""

For nCont := 1 to 2
	
	If nCont = 1
		cSQL := " SELECT COUNT(BD6.R_E_C_N_O_) AS TOTAL "
	Else
		cSQL := " SELECT DISTINCT BD6_CODOPE, BD6_FASE, BD6_SITUAC, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, "
		cSQL += " BD6_CONEMP, BD6_VERCON, BD6_SUBCON, BD6_VERSUB, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, "
		cSQL += " BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_DATPRO, BD6_ANOPAG, BD6_MESPAG, BD6_NOMRDA, BD6_DESPRO, "
		cSQL += " BD6_VLRPAG, BD6_QTDPRO, BD6.R_E_C_N_O_ AS REGBD6, BD6_VLRPAG, BD6_NOMUSR "
	Endif
	cSQL += " FROM BD6010 BD6, BD7010 BD7"
	cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
	cSQL += " AND BD6_OPEUSR = '"+PLSINTPAD()+"' "
	cSQL += " AND BD6_CODEMP = '"+cCodEmp+"' "
	cSQL += " AND BD6_CONEMP = '"+cConEmp+"' "
	cSQL += " AND BD6_VERCON = '"+cVerCon+"' "
	cSQL += " AND BD6_FASE = '4' "
	cSQL += " AND BD6_SITUAC = '1' "
	cSQL += " AND BD6_VLRPAG > 0 " // Inserido por Luzio em 10/06/08 para que nao considere valores de pagamento zerados
	cSQL += " AND BD7_FILIAL = '"+xFilial("BD7")+"' "
	cSQL += " AND BD7_CODOPE = BD6_CODOPE "
	cSQL += " AND BD7_CODLDP = BD6_CODLDP "
	cSQL += " AND BD7_CODPEG = BD6_CODPEG "
	cSQL += " AND BD7_NUMERO = BD6_NUMERO "
	cSQL += " AND BD7_ORIMOV = BD6_ORIMOV "
	cSQL += " AND BD7_SEQUEN = BD6_SEQUEN "
	cSQL += " AND SubStr(BD7_NUMLOT,1,6) = '"+cAno+cMes+"' "
	cSQL += " AND BD6_YFTITA = ' ' "	
	cSQL += " AND BD6.D_E_L_E_T_ =  ' ' "
	cSQL += " AND BD7.D_E_L_E_T_ =  ' ' "
	

	
//Jean - Rotina antiga - comentada...
/*
	cSQL += " FROM BD6010 "
	cSQL += " WHERE BD6_FILIAL = '  ' "
	cSQL += " AND BD6_OPEUSR = '"+PLSINTPAD()+"' "
	cSQL += " AND BD6_CODEMP = '"+cCodEmp+"' "
	cSQL += " AND BD6_ANOPAG = '"+cAno+"' "
	cSQL += " AND BD6_MESPAG = '"+cMes+"' "
//    cSQL += " AND BD6_MESPAG BETWEEN '07' AND '"+cMes+"' "
	cSQL += " AND BD6_CONEMP = '"+cConEmp+"' "
	cSQL += " AND BD6_VERCON = '"+cVerCon+"' "
	cSQL += " AND BD6_BLOPAG <> '1' "
	cSQL += " AND BD6_FASE IN ('3','4') "
	cSQL += " AND BD6_SITUAC = '1' "
	cSQL += " AND BD6_YFTITA = ' ' "
	cSQL += " AND "+RetSQLName("BD6")+".D_E_L_E_T_ <> '*' "
*/	

	
	//Temporariamente incluido... - 
	//cSQL += " AND (BD6_CODEMP||BD6_MATRIC = '0006002822' OR BD6_CODEMP||BD6_MATRIC = '0006004258')"
	//cSQL += " AND BD6_CODEMP||BD6_MATRIC||BD6_TIPREG = '000600683000'"
	//cSQL += " AND (BD6_CODEMP = '0006' AND BD6_MATRIC <= '000500')"
	//cSQL += " AND (BD6_CODEMP||BD6_MATRIC = '0006007521')"
	
	//cSQL += " AND (BD6_CODEMP = '0006' AND BD6_MATRIC IN ('007179') )"

	If nCont > 1
		cSQL += " ORDER BY BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_CODPAD, BD6_CODPRO, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO "
	Endif
	
	PLSQuery(cSQL,"TRB")
	
	//Temporariamente incluido...
	If nCont = 2
		MsgAlert("AtenГЦo! Rotina esta gerando apenas registros nao marcados!!! Verificar com TI!","MENSAGEM EMERGENCIAL")
	Endif
	

	If nCont = 1
		nTotReg := TRB->TOTAL
		TRB->(DbCloseArea())
		
		If nTotReg <= 0
			Help("",1,"RECNO")
			Return
		Endif
		
	Endif
	
Next

Return Nil


/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁBuscaUtil ╨Autor  Ё Jean Schulz        ╨ Data Ё  16/11/06   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁBusca a utilizacao de determinado procedimento, utilizando  ╨╠╠
╠╠╨          Ёo ano civil, conforme regra Itau...                         ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё MP8                                                        ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function BuscaUtil(cOpeUsr, cCodEmp, cMatric, cTipReg, cDigito, cConEmp, cVerCon, cSubCon, cVerSub, cCodPad, cCodPro, cAno, cMes, dDatPro, cCodLdp, cCodPeg, cNumero, cTipUsr)
Local aRet		:= {}
Local nCont		:= 0
Local nCont1	:= 0
Local nCont2	:= 0
Local cTipo		:= ""
Local nQtdMax	:= 0
Local nVlrFat	:= 0
Local aCodUsr	:= {}
Local nQtdTit	:= 0
Local nQtdAgr	:= 0
Local nQtdUti	:= 0
Local aCodPro	:= {}
Local nNivel	:= 0

Local aAreaBA1	:= BA1->(GetArea())
Local aAreaBKD	:= BKD->(GetArea())
Local aAreaBKE	:= BKE->(GetArea())
Local aAreaBD6	:= BD6->(GetArea())

Local cCodPro1 := Iif(Alltrim(cCodPro)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),AllTrim(cCodPro))
Local cCodTmp  := Iif(Alltrim(cCodPro)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),"00010014",Alltrim(cCodPro))

ZZG->(MsSeek(xFilial("ZZG")+cCodEmp))
nNivel := 0

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Buscar parametrizacao de procedimento, conforme usuario...          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
While !ZZG->(Eof()) .And. ZZG->ZZG_CODEMP == cCodEmp
	
	If ZZG->ZZG_CODTAB == cCodPad .And. Alltrim(ZZG->ZZG_CODPRO) $ cCodTmp .And. Substr(DtoS(ZZG->ZZG_VIGINI),1,6) <= cAno+cMes ;
		.And. (Empty(ZZG->ZZG_VIGFIN) .Or. (!Empty(ZZG->ZZG_VIGFIN) .And. cAno+cMes <= Substr(DtoS(ZZG->ZZG_VIGFIN),1,6) ) )
		
		If (!Empty(ZZG->ZZG_SUBCON) .And. ZZG->(ZZG_SUBCON+ZZG_VERSUB) == cSubCon+cVerSub) .And. (!Empty(ZZG->ZZG_CONEMP) .And. ZZG->(ZZG_CONEMP+ZZG_VERCON) == cConEmp+cVerCon)
			
			cTipo := ZZG->ZZG_TIPO
			nQtdMax := ZZG->ZZG_QTDMAX
			nVlrFat := ZZG->ZZG_VLRFAT
			nNivel	:= 3
		Else
			
			If !Empty(ZZG->ZZG_CONEMP) .And. ZZG->(ZZG_CONEMP+ZZG_VERCON) == cConEmp+cVerCon .And. nNivel <= 2
				
				cTipo := ZZG->ZZG_TIPO
				nQtdMax := ZZG->ZZG_QTDMAX
				nVlrFat := ZZG->ZZG_VLRFAT
				nNivel 	:= 2
				
			Else
				If nNivel <= 1
					cTipo := ZZG->ZZG_TIPO
					nQtdMax := ZZG->ZZG_QTDMAX
					nVlrFat := ZZG->ZZG_VLRFAT
					nNivel	:= 1
				Endif
				
			Endif
			
		Endif
		
	Endif
	
	ZZG->(DbSkip())
	
Enddo

If cTipo == "1" //Familia
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Se o usuario em questao for Agregado, regra igual a usuario, fixa qtd = 2    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	BA1->(DbSetOrder(2))
	If BA1->(MsSeek(xFilial("BA1")+cOpeUsr+cCodEmp+cMatric+cTipReg))
		If cTipUsr == "A"
			Aadd(aCodUsr,cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito)
			nQtdMax := 2
		Else
			BA1->(DbGoTop())
			BA1->(MsSeek(xFilial("BA1")+cOpeUsr+cCodEmp+cMatric))
			
			While !BA1->(Eof()) .And. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)==cOpeUsr+cCodEmp+cMatric
				If BA1->BA1_TIPUSU <> "A"
					Aadd(aCodUsr,BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
				Endif
				BA1->(DbSkip())
			Enddo
		Endif
	Endif
	
Else
	Aadd(aCodUsr,cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito)
Endif


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Conforme solicitacao do cliente em 11/12/06, tratar consulta alem de 00010014Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aCodPro := {{cCodPad,cCodPro1}}

If Alltrim(cCodPro) == "00010014"
	aCodPro := {}
	
	While .T.
		
		If At(",",cCodPro1) > 0
			aadd(aCodPro,{cCodPad,Substr(cCodPro1,1,At(",",cCodPro1)-1)})
			cCodPro1 := Substr(cCodPro1,At(",",cCodPro1)+1)
		Else
			aadd(aCodPro,{cCodPad,Substr(cCodPro1,1)})
			Exit
		Endif
		
	Enddo
	
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Ordenar Array para  do usuario, quantidade de utilizacoes ja realizadas...   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aSort(aCodPro,,, { |x,y| x[1]+x[2] < y[1]+y[2] })

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Buscar no historico do usuario, quantidade de utilizacoes ja realizadas...   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nQtdUti := 0
If !Empty(cTipo)
	
	For nCont := 1 to Val(cMes)
		
		For nCont1 := 1 to Len(aCodUsr)
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Itens de notas...                                                            Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			//			For nCont2 := 1 to Len(aCodPro)
			//BD6->( dbOrderNickName( "INDITAU" ) )
			
			BD6->(DbSetOrder(10))
			BD6->(DbGoTop())
			
			If BD6->(MsSeek(xFilial("BD6")+aCodUsr[nCont1]+cAno+StrZero(nCont,2)))
				
				While !BD6->(Eof()) .And. BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+BD6_MESPAG+BD6_ANOPAG) == aCodUsr[nCont1]+StrZero(nCont,2)+cAno
				
					If BD6->(BD6_CONEMP+BD6_VERCON) <> cConEmp+cVerCon
						BD6->(DbSkip())
						Loop				
					Endif
					
					If Alltrim(BD6->BD6_CODPRO) $ Iif(Alltrim(cCodTmp)=="00010014",GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),Alltrim(cCodTmp)) .And. ;
						(BD6->BD6_CODPRO <= cCodPro .And. Substr(aCodUsr[nCont1],15,2) == cTipReg .Or. Substr(aCodUsr[nCont1],15,2) < cTipReg )
						//(BD6->BD6_CODPRO <= cCodPro .And. Substr(aCodUsr[nCont1],15,2) == cTipReg .Or. Substr(aCodUsr[nCont1],15,2) <> cTipReg )
						
						If BD6->BD6_FASE $ "3,4" .And. BD6->BD6_SITUAC == "1" //.And. Iif(Empty(BD6->BD6_DATPRO),Iif(BD6->BD6_ORIMOV=="1",Posicione("BD5",1,xFilial("BD5")+BD6->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BD5_DATPRO"),Posicione("BE4",1,xFilial("BE4")+BD6->(BD6_OPEUSR+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO),"BE4_DATPRO")),BD6->BD6_DATPRO) < dDatPro
							
							//If BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) <= cCodLdp+cCodPeg+cNumero
							//If BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) <> cCodLdp+cCodPeg+cNumero
							If BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) < cCodLdp+cCodPeg+cNumero
								
								nQtdUti += BD6->BD6_QTDPRO
								If U_BusTipUsu(cOpeUsr, cCodEmp, cMatric, cTipReg) == "T"
									nQtdTit += BD6->BD6_QTDPRO
								Else
									nQtdAgr += BD6->BD6_QTDPRO
								Endif
								
								
							Endif
							
						Endif
						
					Endif
					
					BD6->(DbSkip())
					
				Enddo
				
			Endif
			//			Next
			
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Reembolso...                                                                 Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If BKD->(MsSeek(xFilial("BKD")+Substr(aCodUsr[nCont1],1,16)+cAno+StrZero(nCont,2)))
				
				While !BKD->(Eof()) .And. BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS) == Substr(aCodUsr[nCont1],1,16)+cAno+StrZero(nCont,2)
					
					For nCont2 := 1 to Len(nCont2)
						
						If BKE->(MsSeek(xFilial("BKE")+BKD->BKD_CODRBS))
							
							While !BKE->(Eof()) .And. BKE->BKE_CODRBS == BKD->BKD_CODRBS
								
								If Alltrim(BKE->BKE_CODPRO) $ Iif(Alltrim(cCodTmp)=="00010014",GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),Alltrim(cCodTmp)) .And. BKE->BKE_CODPRO <= cCodPro
									
									nQtdUti += BKE->BKE_QTDPRO
									
									If BKD->BKD_TIPREG == "00"
										nQtdTit += BKE->BKE_QTDPRO
									Else
										nQtdAgr += BKE->BKE_QTDPRO
									Endif
									
								Endif
								
								BKE->(DbSkip())
								
							Enddo
							
						Endif
						
					Next
					
					BKD->(DbSkip())
				Enddo
				
			Endif
			
		Next
		
	Next
	
Endif

aadd(aRet,{cTipo,nQtdMax,nVlrFat,nQtdUti,nQtdTit,nQtdAgr})

RestArea(aAreaBA1)
RestArea(aAreaBKD)
RestArea(aAreaBKE)
RestArea(aAreaBD6)

Return aRet

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддбдддддддбдддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё LEGFATM    Ё Autor Ё Jean Schulz         Ё Data Ё 21.11.06 Ё╠╠╠
╠╠цддддддддддеддддддддддддадддддддадддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Exibe a legenda...                                         Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function LEGFATM()
Local aLegenda

aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
{ aCdCores[2,1],aCdCores[2,2] } }

BrwLegenda(cCadastro,"Status" ,aLegenda)

Return


/*
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддбдддддддбдддддддддддддддддддбддддддбдддддддддддд©╠╠
╠╠ЁPrograma  Ё EXCFATM    Ё Autor Ё Jean Schulz       Ё Data Ё 21.11.2006 Ё╠╠
╠╠цддддддддддеддддддддддддадддддддадддддддддддддддддддаддддддадддддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Exclui o arquivo e sua composicao                          Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
User Function EXCFATM(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca		:= 0
LOCAL oEnc
LOCAL bOK		:= { || nOpca := 1, oDlg:End() }
LOCAL bCancel	:= { || oDlg:End() }

PRIVATE cAlias	:= "ZZH"

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define dialogo...                                                   Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Enchoice...                                                         Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Copy cAlias To Memory

oEnc := ZZH->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Ativa o dialogo...                                                  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define tratamento de acordo com a opcao...                          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nOpca == K_OK
	
	if ZZH->ZZH_STATUS <> "1"
		MsgInfo("Nao И possМvel excluir! Arquivo jА importado!")
	Else
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Deleta registro excluido e desmarca os itens ja exportados...       Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		BEGIN TRANSACTION
		MsgRun("Desmarcando Registros Exportados...",,{|| DesmacaRegs(ZZH->ZZH_CODIGO),CLR_HBLUE})
		ZZH->(PLUPTENC("ZZH",K_Excluir))
		END TRANSACTION
		
	Endif
	
Endif

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da Rotina...                                                    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ZZH->(DbClearFilter())

Return


/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммямммммммммммкммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁDesmacaRegs╨Autor ЁMicrosiga           ╨ Data Ё  21/11/06   ╨╠╠
╠╠лммммммммммьмммммммммммйммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁDesmarca registros (emite mensagem na tela)                 ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function DesmacaRegs(cCodExp)
Local cSQL := ""

cSQL := " UPDATE "+RetSQLName("BD6")+" SET BD6_YFTITA = ' ', BD6_YERITA = ' ', BD6_YVLITA = 0, BD6_YMTEMI = ' ', BD6_YINFTM = ' ' "
cSQL += " WHERE BD6_YFTITA = '"+cCodExp+"' "
cSQL += " AND D_E_L_E_T_ = ' ' "
TCSQLEXEC(cSQL)

cSQL := " UPDATE "+RetSQLName("BKE")+" SET BKE_YFTITA = ' ', BKE_YERITA = ' ', BKE_YVLITA = 0, BKE_YMTEMI = ' ', BKE_YINFTM = ' ' "
cSQL += " WHERE BKE_YFTITA = '"+cCodExp+"' "
cSQL += " AND D_E_L_E_T_ = ' ' "
TCSQLEXEC(cSQL)

Return Nil


/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁIMPFATM   ╨Autor  ЁMicrosiga           ╨ Data Ё  22/11/06   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁImporta arquivo referente ao retorno Itau.                  ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
User Function IMPFATM
Local cNmArq := ""

cPerg := "YIMITA"

ParSX1()
If !Pergunte(cPerg,.T.)
	MsgAlert("ImportaГЦo abortada!")
	Return
Endif

cNmArq	:= mv_par01

If !File(cNmArq)
	MsgStop("Arquivo invalido. ImpossМvel importar!")
	Return
Endif

Processa({|| Processa1(cNmArq) }, cTitulo, "", .T.)

Return



/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Fun┤└o    Ё PROCESSA1╨ Autor Ё Jean Schulz        ╨ Data Ё  26/10/06   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Descri┤└o Ё Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ╨╠╠
╠╠╨          Ё monta a janela com a regua de processamento.               ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё Programa principal                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function Processa1(cNmArq)

Local aStruc	:= {}
Local aErr		:= {}
Local aCritica	:= {}
Local aBD6		:= {}
Local aBKE		:= {}
Local nLinha	:= 0
Local cLinha	:= ""
Local lReemb	:= .F.

Private cTrb

//Cria estrutura em area de trabalho para importar arquivo
aAdd(aStruc,{"CAMPO","C",500,0})

cTrb := CriaTrab(aStruc,.T.)

If Select("TRB") <> 0
	TRB->(dbCloseArea())
EndIf

DbUseArea(.T.,,cTrb,"TRB",.T.)

MsgRun("Atualizando Arquivo...",,{|| U_PLSAppendTmp(cNmArq),CLR_HBLUE})

TRB->(DbGoTop())
If TRB->(EOF())
	MsgStop("Arquivo Vazio!")
	TRB->(DBCLoseArea())
	lRet := .F.
	Return
End

ProcRegua(TRB->(LastRec()))
TRB->(DbGoTop())

ZZH->(DbSetOrder(1))
BD6->(DbSetOrder(1))

nLin := 1

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Validar a composicao do arquivo de retorno e criar array de baixa...Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
While !TRB->(Eof())
	
	nLinha++
	IncProc("Processando Linha... "+strzero(nLinha,6)+" / "+strzero(TRB->(LastRec()),6))
	
	cLinha := TRB->CAMPO
	
	Do Case
		
		Case Substr(cLinha,1,2) == "01" //Registro Header
			If !ZZH->(MsSeek(xFilial("ZZH")+Substr(cLinha,100,006)))
				MsgStop("Registro referente a exportaГЦo nЦo encontrado. ImportaГЦo abortada!")
				Return
			Else
				If ZZH->ZZH_STATUS <> "1"
					MsgStop("Status nЦo permite importaГЦo! Verifique!")
					Return
				Endif
			Endif
			
		Case Substr(cLinha,1,2) == "10" //Registro Detalhe
			lReemb := Iif(Substr(cLinha,284,3)=="RBS",.T.,.F.) //Valida se guia tem origem de reembolso ou nao...
			
			If !lReemb
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Caso nao seja reembolso, devera buscar registros no BD6...          Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If BD6->(MsSeek(xFilial("BD6")+PLSINTPAD()+Substr(cLinha,284,24)))
				
					//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
					//Ё Nova rotina: somente gravar caso cod. de exportacao == cod exp guia!Ё
					//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
					If Alltrim(ZZH->ZZH_CODIGO) == BD6->BD6_YFTITA
						If Substr(cLinha,480,1) == "R" //Registro rejeitado - Gravar conteudo no item de nota...
							aadd(aBD6,{BD6->(Recno()),StrZero(Val(Substr(cLinha,481,2)),2)})
						Else
							aadd(aCritica,{"Guia/Item com crМtica, porИm aceito. Chave: "+PLSINTPAD()+Substr(cLinha,284,24),StrZero(Val(Substr(cLinha,481,2)),2)})
						Endif
					Endif
				Else
					aadd(aErr,{"Guia/Item nЦo localizado. Chave: "+PLSINTPAD()+Substr(cLinha,284,24)})
				Endif
				
			Else
				//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Se Reembolso, buscar nos itens de reembolso (BKE)...                Ё
				//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				If BKE->(MsSeek(xFilial("BKE")+Substr(cLinha,287,22))) //CODIGO REEMBOLSO + COD. PROCEDIMENTO (CHAVE 1 BKE)
					If Substr(cLinha,480,1) == "R" //Registro rejeitado - Gravar conteudo no item de nota...
						aadd(aBKE,{BKE->(Recno()),StrZero(Val(Substr(cLinha,481,2)),2)})
					Else
						aadd(aCritica,{"Reembolso/Item com crМtica, porИm aceito. Chave: "+Substr(cLinha,287,22),StrZero(Val(Substr(cLinha,481,2)),2)})
					Endif
					
				Else
					aadd(aErr,{"Reembolso/Item nЦo localizado. Chave: "+Substr(cLinha,287,22)})
				Endif
				
			Endif
			
			
	EndCase
	
	TRB->(DbSkip())
	
Enddo

TRB->(DbCloseArea())

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Iniciar transacao e efetuar todas as manutencoes de uma so vez...   Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

Begin Transaction

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Alterar o status para importado...                                  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ZZH->(Reclock("ZZH",.F.))
ZZH->ZZH_STATUS := "2"
ZZH->(MsUnlock())

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Atualizar registros que possuiram erros apontados no arquivo...     Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
MsgRun("Atualizando status dos registros retornados...",,{|| AtualizaRegs(aBD6,aBKE),CLR_HBLUE})

End Transaction


//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Apresentar criticas e erros encontrados durante a importacao...     Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If Len(aCritica) > 0
	PLSCRIGEN(aCritica,{ {"DescriГЦo da crМtica","@C",200},{"CСdigo da crМtica","@C",50} },"CrМticas encontradas! (ImportaГЦo)",.T.)
Endif

If Len(aErr) > 0
	PLSCRIGEN(aErr,{ {"DescriГЦo do erro!","@C",300}},"AtenГЦo! Erros encontrados! (ImportaГЦo)",.T.)
Endif

aErr		:= {}

Return



/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммямммммммммммммкмммммммямммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁAtualizaRegs ╨Autor  ЁMicrosiga        ╨ Data Ё  22/11/06   ╨╠╠
╠╠лммммммммммьмммммммммммммймммммммомммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁAtualiza registros retornados pelo arquivo Itau.            ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function AtualizaRegs(aBD6,aBKE)
Local nCont := 1

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Alterar registros de BD6 (Cts Medicas)retornados no arquivo retorno Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
For nCont := 1 to Len(aBD6)
	BD6->(DbGoTo(aBD6[nCont,1]))
	BD6->(RecLock("BD6",.F.))
	BD6->BD6_YERITA := aBD6[nCont,2]
	//BD6->BD6_YMESEN := '12'
	BD6->(MsUnlock())
Next

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Alterar registros de BKE (Reembolso) retornados no arquivo retorno  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
For nCont := 1 to Len(aBKE)
	BKE->(DbGoTo(aBKE[nCont,1]))
	BKE->(RecLock("BKE",.F.))
	BKE->BKE_YERITA := aBKE[nCont,2]
	//BKE->BKE_YMESEN := '12'
	BKE->(MsUnlock())
Next

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Zerar matrizes que tiveram suas atualizacoes...                     Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aBD6 := {}
aBKE := {}

Return Nil

/*
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддбдддддддбдддддддддддддддддддбддддддбдддддддддддд©╠╠
╠╠ЁPrograma  Ё EXCFATM    Ё Autor Ё Jean Schulz       Ё Data Ё 21.11.2006 Ё╠╠
╠╠цддддддддддеддддддддддддадддддддадддддддддддддддддддаддддддадддддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Exclui o arquivo e sua composicao                          Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
User Function CANCIMP(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca		:= 0
LOCAL oEnc
LOCAL bOK		:= { || nOpca := 1, oDlg:End() }
LOCAL bCancel	:= { || oDlg:End() }

PRIVATE cAlias	:= "ZZH"

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define dialogo...                                                   Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Enchoice...                                                         Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Copy cAlias To Memory

oEnc := ZZH->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Ativa o dialogo...                                                  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define tratamento de acordo com a opcao...                          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nOpca == K_OK
	
	if ZZH->ZZH_STATUS == "1"
		MsgInfo("Somente И possМvel cancelar a importaГЦo quando o registro estА com status jА importado!")
	Else
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Deleta registro excluido e desmarca os itens ja exportados...       Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		BEGIN TRANSACTION
		MsgRun("Cancelando importaГЦo...",,{|| CancelaImp(ZZH->ZZH_CODIGO),CLR_HBLUE})
		ZZH->(Reclock("ZZH",.F.))
		ZZH->ZZH_STATUS := "1"
		ZZH->(MsUnlock())
		END TRANSACTION
		
	Endif
	
Endif

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da Rotina...                                                    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
ZZH->(DbClearFilter())

Return

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммямммммммммммкммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁDesmacaRegs╨Autor ЁMicrosiga           ╨ Data Ё  21/11/06   ╨╠╠
╠╠лммммммммммьмммммммммммйммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁDesmarca registros (emite mensagem na tela)                 ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP                                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function CancelaImp(cCodExp)
Local cSQL := ""

cSQL := " UPDATE "+RetSQLName("BD6")+" SET BD6_YERITA = '00' "
cSQL += " WHERE BD6_YFTITA = '"+cCodExp+"' "
cSQL += " AND D_E_L_E_T_ = ' ' "
TCSQLEXEC(cSQL)

cSQL := " UPDATE "+RetSQLName("BKE")+" SET BKE_YERITA = '00' "
cSQL += " WHERE BKE_YFTITA = '"+cCodExp+"' "
cSQL += " AND D_E_L_E_T_ = ' ' "
TCSQLEXEC(cSQL)

Return Nil

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁBuscaUtil ╨Autor  Ё Jean Schulz        ╨ Data Ё  16/11/06   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁBusca a utilizacao de determinado procedimento, utilizando  ╨╠╠
╠╠╨          Ёo ano civil, conforme regra Itau...                         ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё MP8                                                        ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function AtuUtil(aRet, cOpeUsr, cCodEmp, cMatric, cTipReg, cDigito, cConEmp, cVerCon, cSubCon, cVerSub, cCodPad, cCodPro, cAno, cMes)
Local nCont		:= 0
Local nCont1	:= 0
Local nCont2	:= 0
Local cTipo		:= ""
Local nQtdMax	:= 0
Local nVlrFat	:= 0
Local aCodUsr	:= {}
Local nQtdTit	:= 0
Local nQtdAgr	:= 0
Local nQtdUti	:= 0
Local aCodPro	:= {}
Local nNivel	:= 0
Local nPos		:= 0

Local aAreaBA1	:= BA1->(GetArea())
Local aAreaBKD	:= BKD->(GetArea())
Local aAreaBKE	:= BKE->(GetArea())
Local aAreaBD6	:= BD6->(GetArea())

Local cCodPro1 := Iif(Alltrim(cCodPro)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),AllTrim(cCodPro))
Local cCodTmp  := Iif(Alltrim(cCodPro)$GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),"00010014",Alltrim(cCodPro))

ZZG->(MsSeek(xFilial("ZZG")+cCodEmp))
nNivel := 0

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Buscar parametrizacao de procedimento, conforme usuario...          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
While !ZZG->(Eof()) .And. ZZG->ZZG_CODEMP == cCodEmp
	
	If ZZG->ZZG_CODTAB == cCodPad .And. Alltrim(ZZG->ZZG_CODPRO) $ cCodTmp .And. Substr(DtoS(ZZG->ZZG_VIGINI),1,6) <= cAno+cMes ;
		.And. (Empty(ZZG->ZZG_VIGFIN) .Or. (!Empty(ZZG->ZZG_VIGFIN) .And. cAno+cMes <= Substr(DtoS(ZZG->ZZG_VIGFIN),1,6) ) )
		
		If (!Empty(ZZG->ZZG_SUBCON) .And. ZZG->(ZZG_SUBCON+ZZG_VERSUB) == cSubCon+cVerSub) .And. (!Empty(ZZG->ZZG_CONEMP) .And. ZZG->(ZZG_CONEMP+ZZG_VERCON) == cConEmp+cVerCon)
			
			cTipo := ZZG->ZZG_TIPO
			nQtdMax := ZZG->ZZG_QTDMAX
			nVlrFat := ZZG->ZZG_VLRFAT
			nNivel	:= 3
		Else
			
			If !Empty(ZZG->ZZG_CONEMP) .And. ZZG->(ZZG_CONEMP+ZZG_VERCON) == cConEmp+cVerCon .And. nNivel <= 2
				
				cTipo := ZZG->ZZG_TIPO
				nQtdMax := ZZG->ZZG_QTDMAX
				nVlrFat := ZZG->ZZG_VLRFAT
				nNivel 	:= 2
				
			Else
				If nNivel <= 1
					cTipo := ZZG->ZZG_TIPO
					nQtdMax := ZZG->ZZG_QTDMAX
					nVlrFat := ZZG->ZZG_VLRFAT
					nNivel	:= 1
				Endif
				
			Endif
			
		Endif
		
	Endif
	
	ZZG->(DbSkip())
	
Enddo

If cTipo == "1" //Familia
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Se o usuario em questao for Agregado, regra igual a usuario, fixa qtd = 2    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	BA1->(DbSetOrder(2))
	If BA1->(MsSeek(xFilial("BA1")+cOpeUsr+cCodEmp+cMatric+cTipReg))
		If U_BusTipUsu(cOpeUsr, cCodEmp, cMatric, cTipReg) == "A" 
			Aadd(aCodUsr,cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito)
			nQtdMax := 2
		Else
			BA1->(DbGoTop())
			BA1->(MsSeek(xFilial("BA1")+cOpeUsr+cCodEmp+cMatric))
			
			While !BA1->(Eof()) .And. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)==cOpeUsr+cCodEmp+cMatric
				If BA1->BA1_TIPUSU <> "A"
					Aadd(aCodUsr,BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
				Endif
				BA1->(DbSkip())
			Enddo
		Endif
	Endif
	
Else
	Aadd(aCodUsr,cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito)
Endif


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Conforme solicitacao do cliente em 11/12/06, tratar consulta alem de 00010014Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aCodPro := {{cCodPad,cCodPro1}}

If Alltrim(cCodTmp) == "00010014"
	aCodPro := {}
	
	While .T.
		
		If At(",",cCodPro1) > 0
			aadd(aCodPro,{cCodPad,Substr(cCodPro1,1,At(",",cCodPro1)-1)})
			cCodPro1 := Substr(cCodPro1,At(",",cCodPro1)+1)
		Else
			aadd(aCodPro,{cCodPad,Substr(cCodPro1,1)})
			Exit
		Endif
		
	Enddo
	
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Ordenar Array para  do usuario, quantidade de utilizacoes ja realizadas...   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aSort(aCodPro,,, { |x,y| x[1]+x[2] < y[1]+y[2] })

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Buscar no historico do usuario, quantidade de utilizacoes ja realizadas...   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nQtdUti := 0
If !Empty(cTipo) .And. Val(cMes) > 1
	
	For nCont := 1 to (Val(cMes)-1)
		
		For nCont1 := 1 to Len(aCodUsr)
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Itens de notas...                                                            Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			BD6->(DbSetOrder(10))
			BD6->(DbGoTop())
			
			If BD6->(MsSeek(xFilial("BD6")+aCodUsr[nCont1]+cAno+StrZero(nCont,2)))
				
				While !BD6->(Eof()) .And. BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+BD6_MESPAG+BD6_ANOPAG) == aCodUsr[nCont1]+StrZero(nCont,2)+cAno
				
					If BD6->(BD6_CONEMP+BD6_VERCON) <> cConEmp+cVerCon
						BD6->(DbSkip())
						Loop				
					Endif
				
					If Alltrim(BD6->BD6_CODPRO) $ Iif(Alltrim(cCodTmp)=="00010014",GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),Alltrim(cCodTmp)) .And. ;
						(Substr(aCodUsr[nCont1],15,2) == cTipReg .Or. Substr(aCodUsr[nCont1],15,2) <> cTipReg )																	
					
						If BD6->BD6_FASE $ "3,4" .And. BD6->BD6_SITUAC == "1"
							
							nQtdUti += BD6->BD6_QTDPRO
							If U_BusTipUsu(cOpeUsr, cCodEmp, cMatric, cTipReg) == "T"
								nQtdTit += BD6->BD6_QTDPRO
							Else
								nQtdAgr += BD6->BD6_QTDPRO
							Endif
							
						Endif
						
					Endif
					
					BD6->(DbSkip())
					
				Enddo
				
			Endif
			
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Reembolso...                                                                 Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If BKD->(MsSeek(xFilial("BKD")+Substr(aCodUsr[nCont1],1,16)+cAno+StrZero(nCont,2)))
				
				While !BKD->(Eof()) .And. BKD->(BKD_CODINT+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_ANOBAS+BKD_MESBAS) == Substr(aCodUsr[nCont1],1,16)+cAno+StrZero(nCont,2)
					
					For nCont2 := 1 to Len(nCont2)
						
						If BKE->(MsSeek(xFilial("BKE")+BKD->BKD_CODRBS))
							
							While !BKE->(Eof()) .And. BKE->BKE_CODRBS == BKD->BKD_CODRBS
								
								If Alltrim(BKE->BKE_CODPRO) $ Iif(Alltrim(cCodTmp)=="00010014",GetNewPar("MV_YCDCON","00010014,00010022,00010065,80020410,80110010,80170366,85000140,85000159,86000012"),Alltrim(cCodTmp)) .And. BKE->BKE_CODPRO <= cCodPro
									
									nQtdUti += BKE->BKE_QTDPRO
									
									If U_BusTipUsu(cOpeUsr, cCodEmp, cMatric, cTipReg) == "T"
										nQtdTit += BKE->BKE_QTDPRO
									Else
										nQtdAgr += BKE->BKE_QTDPRO
									Endif
									
								Endif
								
								BKE->(DbSkip())
								
							Enddo
							
						Endif
						
					Next
					
					BKD->(DbSkip())
				Enddo
				
			Endif
			
		Next
		
	Next
	
Endif

nPos := Ascan(aRet, { |x| AllTrim(x[1]+x[3]) == cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito+cCodTmp } )
If nPos == 0 .And. nQtdMax > 0
	aadd(aRet,{cOpeUsr+cCodEmp+cMatric+cTipReg+cDigito,U_BusTipUsu(cOpeUsr, cCodEmp, cMatric, cTipReg),cCodTmp,nQtdUti,nQtdTit,nQtdAgr,nQtdMax,nVlrFat})
Endif

RestArea(aAreaBA1)
RestArea(aAreaBKD)
RestArea(aAreaBKE)
RestArea(aAreaBD6)

Return .T.
