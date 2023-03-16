#include "PLSMGER.CH"   
#include "PRTOPDEF.CH"


#Define cCodigosPF  "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155"

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё PLSR256 Ё Autor Ё Tulio Cesar            Ё Data Ё 24.11.00 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio de Usuarios por Grupo/Empresa                    Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠ЁSintaxe   Ё PLSR256()                                                  Ё╠╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Uso      Ё Advanced Protheus                                          Ё╠╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Alteracoes desde sua construcao inicial                               Ё╠╠╠
╠╠цддддддддддбддддддбдддддддддддддбддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠Ё Data     Ё BOPS Ё Programador Ё Breve Descricao                       Ё╠╠╠
╠╠цддддддддддеддддддедддддддддддддеддддддддддддддддддддддддддддддддддддддд╢╠╠╠
╠╠юддддддддддаддддддадддддддддддддаддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define nome da funcao...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
User Function PLSR256NOVO()
LOCAL aCriticas := {}

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variavaoeis...                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nQtdLin := 58
PRIVATE cNomeProg   := "PLSR256"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 132
PRIVATE cTamanho    := "M"
PRIVATE cTitulo     := "Relatorio da Cobranca"
PRIVATE cDesc1      := "Relatorio da Cobranca"
PRIVATE cDesc2      := ""                         
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "BA3"
PRIVATE cPerg       := "PLR256"
PRIVATE cRel        := "PLR256"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 } 
PRIVATE lAbortPrint := .F.                                                                       
PRIVATE aOrdens     := { "Operadora+Empresa+Contrato+SubContrato+Matricula", "Operadora+Empresa+Contrato+SubContrato+Nome" } 
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.

cCabec1 := "         Matricula Usuario    Tp Nome Usuario                    Cod  Descricao                  Mat. Antiga              Valor"
cCabec2 := "Data     Nome do Prestador              Proced   DescriГЦo AMB                              L.Dg. PEG     Numero          Valor"
           /*      10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
           1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
           */
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chama SetPrint                                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

//Bianchini - 03/08/2020 - Comentando esta funГЦo, pois alem de nao funcionar na versЦo 12, ainda deleta o Pergunte.
//CriaSX1() 

cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se foi cancelada a operacao                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nLastKey  == 27
   Return
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Recebe parametros                                                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(cPerg,.F.)            
nCompara := mv_par01
_cMes    := mv_par02
_cAno    := mv_par03
cOpe     := mv_par04
nTipCon  := mv_par05
cGrupIni := mv_par06
cGrupFim := mv_par07
cContDe  := mv_par08
cContAte := mv_par09                              
cSubConI := mv_par10
cSubConF := mv_par11
cMatrIni := mv_par12
cMatrFin := mv_par13
cMtAnIni := mv_par14
cMtAnFin := mv_par15
cDatFin  := mv_par16
cGrpCIni := mv_par17
cGrpCFin := mv_par18
nTipRel  := mv_par19
nFamZer  := mv_par20
lDetCO	 := mv_par21
cCodPlaI := mv_par23
cCodPlaF := mv_par24
nModPag  := mv_par25
nMatAnt  := mv_par26
cVencTo  := mv_par27
cLancFt	 := Alltrim(mv_par28)
lLisMat  := mv_par29 == 1
lVlrTx	 := mv_par30 == 1

If nTipRel == 2
	cCabec1 := "   Contrato "
	cCabec2 := "      Subcontrato             Descricao                                                                                  Valor"
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Configura Impressora                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cAlias)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta RptStatus...                                                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//MsAguarde( {|| aCriticas := RImp256() }  , "Imprimindo...", "" , .T. )
Proc2BarGauge({|| aCriticas := RImp256() }  , "Imprimindo...") 
                                                                              
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Caso tenha critica...                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If Len(aCriticas) > 0
	PLSCRIGEN(aCriticas,{ {"Matricula","@C",70},{"Critica","@C",170 } },"Criticas do relatorio.")
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da Rotina Principal...                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return


/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё RImp256 Ё Autor Ё Tulio Cesar            Ё Data Ё 24.11.02 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio de contratos.                                    Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define nome da funcao                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
static Function RImp256()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis do IndRegua...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL   nFor
LOCAL	n
LOCAL   lTemUsr
Local   lPrimeiro := .T.
LOCAL 	aVlrFam := {}
LOCAL	aVlrCO  := {}
LOCAL 	aCriticas := {}
LOCAL   aUsuarios := {}
LOCAL	nColCO	:= 0
LOCAL	lImp := .T.
LOCAL	aValAcu := {}
LOCAL	nTotFaA := 0  
LOCAL	lPrSubCon := .F.
PRIVATE cFor
PRIVATE cOrdem
PRIVATE cInd    := CriaTrab(Nil,.F.)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicios de colunas...                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nColEmp := 00
PRIVATE nColCon := 03
PRIVATE nColSub := 06
PRIVATE nColuna := 00
PRIVATE nColUsr := 09
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Controles de quebars...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE cCodEmp := ""
PRIVATE cCodCon := ""
PRIVATE cCodSub := ""
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis de uso generico...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE cLinha  := Space(00)
PRIVATE pMoeda  := "@E 99,999,999.99"
PRIVATE aValor
PRIVATE	lPF := .F.

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Exibe mensagem informativa...                                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//MsProcTXT("Aguarde. Buscando dados no servidor...") 
IncProcG1("Aguarde. Buscando dados no servidor...")
ProcessMessage()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores por Empresa...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nTotCobEmp := 0
PRIVATE nTotRegEmp := 0
Private aQtdusrEmp := 0
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores por Contrato...                                            Ё                                                     
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nTotCobCon := 0
PRIVATE nTotRegCon := 0
Private aQtdusrCon := 0
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores por SubContrato...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nTotCobSub := 0
PRIVATE nTotRegSub := 0
PRIVATE nVlrCob    := 0
Private aQtdusrSub := 0

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta Expressao de filtro...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cFor := "SELECT BA3_CODINT, BA3_CODEMP, BA3_CONEMP, BA3_GRPCOB, BA3_MATANT, BA3_MATEMP, BA3_MATRIC, BA3_SUBCON, BA3_TIPOUS, BA3_VALANT, BA3_VERCON, BA3_VERSUB, BA3.R_E_C_N_O_, BA1_NOMUSR FROM "+RetSqlName("BA3") + " BA3 "

cFor += " LEFT OUTER JOIN " + RetSQLName("BA1") + " BA1 "
cFor += " ON BA1_FILIAL = '" + xFilial("BA1") + "' AND "
cFor += "    BA1_CODINT = BA3_CODINT AND "
cFor += "    BA1_CODEMP = BA3_CODEMP AND "
cFor += "    BA1_MATRIC = BA3_MATRIC AND "
cFor += "    BA1_TIPUSU = 'T' AND "
cFor += "    BA1.D_E_L_E_T_ <> '*' "

cFor += "WHERE BA3_FILIAL = '"+xFilial("BA3")+"' "
cFor += "And BA3_CODINT = '"+cOpe+"' "
cFor += "And BA3_CODEMP >= '"+cGrupIni+"' "
cFor += "And BA3_CODEMP <= '"+cGrupFim+"' "
cFor += "And BA3_DATBAS <= '"+DTOS(cDatFin)+"' "
cFor += "And BA3_CONEMP >= '"+cContDe+"' "
cFor += "And BA3_CONEMP <= '"+cContAte+"' "
cFor += "And BA3_MATRIC >= '"+cMatrIni+"' "
cFor += "And BA3_MATRIC <= '"+cMatrFin+"' "
cFor += "And BA3_MATANT >= '"+cMtAnIni+"' "
cFor += "And BA3_MATANT <= '"+cMtAnFin+"' "
cFor += "And BA3_SUBCON >= '"+cSubConI+"' "
cFor += "And BA3_SUBCON <= '"+cSubConF+"' "
cFor += "And BA3_CODPLA >= '"+cCodPlaI+"' "
cFor += "And BA3_CODPLA <= '"+cCodPlaF+"' "

If Mv_Par22 == 2		// Nao
	cFor += "And (BA3_DESLIG = ' ' OR BA3_DATDES > '" + DtoS(cDatFin) + "') "
Endif

If !Empty(Mv_Par27)
	cFor += "AND BA3_VENCTO IN (" + AllTrim(Mv_Par27) + ") "
Endif

cFor += "And BA3.D_E_L_E_T_ = ' ' "     
If aReturn[8] == 1
   cFor += "Order by BA3_CODINT,BA3_CODEMP,BA3_CONEMP,BA3_SUBCON,BA3_MATRIC "
Else
   cFor += "Order by BA3_CODINT,BA3_CODEMP,BA3_CONEMP,BA3_SUBCON,BA1_NOMUSR "
EndIf
  
PlsQuery(cFor, "TRBBA3")

nQtd:=1
TRBBA3->(DBEval( { | | nQtd ++ }))
BarGauge1Set(nQtd)               

TRBBA3->(DbGoTop())
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta chaves de quebra...                                     .          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cCodEmp := ""
cCodCon := ""
cCodSub := ""
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime cabecalho padrao...                                              Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
R256Cab(.F.)
                            
BQC->(DbSetOrder(1))

While ! TRBBA3->(Eof())

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Apresenta mensagem em tela...                                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	//MsProcTXT("Familia - "+BA3->BA3_CODINT+"."+BA3->BA3_CODEMP+"."+BA3->BA3_MATRIC)
	IncProcG1("Familia ["+TRBBA3->BA3_CODINT+"."+TRBBA3->BA3_CODEMP+"."+TRBBA3->BA3_MATRIC+"]")
	ProcessMessage()
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Posiciona o BA3.                                                         Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	BA3->( dbGoto(TRBBA3->R_E_C_N_O_) )
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica tipo de contrato selecionado                              Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  nTipCon <> 3 .and. ;
		BA3->BA3_TIPOUS <> strzero(nTipCon,1)
		TRBBA3->(DbSkip())
		Loop
	EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Se for pessoa juridica, verifica se pertence ao grupo de           Ё
	//Ё    cobranca informado nos parametros                               Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  BA3->BA3_TIPOUS == "2" .And. Empty(TRBBA3->BA3_GRPCOB) //nivel mais alto e o da familia.
		If  BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB) <> ;
			BQC->(BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB)
			If  ! BQC->(msSeek(xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))
				Aadd(aCriticas, {BA3->BA3_CODINT+"."+BA3->BA3_CODEMP+"."+BA3->BA3_MATRIC,;
								 "Subcontrato nao encontrado"})
				
				TRBBA3->(DbSkip())
				Loop
			EndIf
		Endif
		If  BQC->BQC_GRPCOB < cGrpCIni .or. ;
			BQC->BQC_GRPCOB > cGrpCFin
			TRBBA3->(DbSkip())
			Loop
		EndIf
	Else
		If  TRBBA3->BA3_GRPCOB < cGrpCIni .or. ;
			TRBBA3->BA3_GRPCOB > cGrpCFin
			TRBBA3->(DbSkip())
			Loop
		EndIf	
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica se foi abortada a impressao...                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  Interrupcao(lAbortPrint)
		Exit
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Trata quebras de instituicao...                                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  BA3->BA3_CODEMP <> cCodEmp
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime totais gerais...                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If nTipRel == 2 .and. lPrSubCon
			@ nLi,113      pSay Transform(nTotCobSub,"@E 999,999,999.99")  
			lPrSubCon := .F.
		Endif
		
		If  nTotRegSub > 0 .And. !lPF
			If nTipRel == 1
				R256Tot(nColSub,nTotCobSub,"Total do Subcontrato")
			Endif
			nTotCobSub := 0
			nTotRegSub := 0
			lPF := .F.
		Endif                                    
		
		If  nTotRegCon > 0 .And. !lPF
			R256Tot(nColCon,nTotCobCon,"Total do Contrato")
			nTotCobCon := 0
			nTotRegCon := 0
			lPF := .F.
		Endif
		If  nTotRegEmp > 0 
			R256Tot(nColEmp,nTotCobEmp,"Total do Grupo/Empresa")
			nTotCobEmp := 0
			nTotRegEmp := 0 
		Endif
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Remonta dados de quebra...                                         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cCodEmp    := BA3->BA3_CODEMP
		nTotRegEmp := 0
		nTotCobEmp := 0
		If  lPrimeiro
			lPrimeiro := .F.
		Else
			nLi ++ ; @ nLi, 0 pSay Replicate("-",nLimite)
		Endif
		nLi ++ ; @ nLi, nColEmp pSay cCodEmp+" - "+Posicione("BG9",1,xFilial("BG9")+cOpe+cCodEmp,"BG9_DESCRI")
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Trata quebras de empresas...                                       Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  BA3->BA3_CONEMP <> cCodCon .and. BA3->BA3_TIPOUS == "2"
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime totais gerais...                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If nTipRel == 2 .and. lPrSubCon
			@ nLi,113      pSay Transform(nTotCobSub,"@E 999,999,999.99")  
			lPrSubCon := .F.
		Endif
		
		If  nTotRegSub > 0 .And. !lPF
			If nTipRel == 1
				R256Tot(nColSub,nTotCobSub,"Total do Subcontrato")
			Endif
			nTotCobSub := 0
			nTotRegSub := 0
			lPF := .F.	
		Endif           
		
		If  nTotRegCon > 0 .And. !lPF                                              
			R256Tot(nColCon,nTotCobCon,"Total do Contrato")
			nTotCobCon := 0
			nTotRegCon := 0
			lPF := .F.      
		Endif
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Remonta dados da quebra...                                         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		cCodCon    := BA3->BA3_CONEMP
		nTotCobCon := 0
		nTotRegCon := 0
		nLi ++ ; @ nLi, nColCon pSay "Contrato: "+cCodCon
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Trata quebras de Sub-Contrato...                                   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  BA3->BA3_SUBCON <> cCodSub .and. BA3->BA3_TIPOUS == "2"
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime totais gerais...                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  nTipRel == 1 .and. nTotRegSub > 0 .And. !lPF
		
			R256Tot(nColSub,nTotCobSub,"Total do Subcontrato")
			nTotCobSub := 0
			nTotRegSub := 0
			lPF := .F.
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Remonta dados de quebra...                                         Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			cCodSub    := BA3->BA3_SUBCON
			nTotCobSub := 0
			nTotRegSub := 0
			nLi ++ ; @ nLi, nColSub pSay "SubContrato "+cCodSub+" - "+Posicione("BQC",1,xFilial("BQC")+cOpe+cCodEmp+BA3->BA3_CONEMP+BA3->BA3_VERCON+BA3->BA3_SUBCON+BA3->BA3_VERSUB,"BQC_DESCRI")
			
		Elseif nTipRel == 2
		
				If lPrSubCon		
					@ nLi,113      pSay Transform(nTotCobSub,"@E 999,999,999.99")  
				Endif
		
				cCodSub    := BA3->BA3_SUBCON
				nTotCobSub := 0
				nTotRegSub := 0
				lPF        := .F.
				lPrSubCon  := .T.
				nLi ++ ; @ nLi, nColSub pSay "SubContrato "+cCodSub+" - "+Posicione("BQC",1,xFilial("BQC")+cOpe+cCodEmp+BA3->BA3_CONEMP+BA3->BA3_VERCON+BA3->BA3_SUBCON+BA3->BA3_VERSUB,"BQC_DESCRI")
		Endif
		
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Incrementa a regua...                                              Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	//MsPROCTxt("Imprimindo Matricula "+BA3->(BA3_CODINT+"."+BA3_CODEMP+"-"+BA3_MATRIC)+" ...")
	
	BarGauge2Set(3)     
	IncProcG2("Carregando usuarios ["+BA3->BA3_CODINT+"."+BA3->BA3_CODEMP+"."+BA3->BA3_MATRIC+"]")
	ProcessMessage()
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Posiciona o usuario...                                             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	BA1->(DbSetOrder(2))
	BA1->(msSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))

	aUsuarios := PLSLOADUSR(TRBBA3->BA3_CODINT,TRBBA3->BA3_CODEMP,TRBBA3->BA3_MATRIC,_cAno,_cMes)
					
	If Len(aUsuarios) == 0
	   TRBBA3->( DbSkip() )
	   Loop
	Endif   
    
	IncProcG2("Valor de cobranca ["+BA3->BA3_CODINT+"."+BA3->BA3_CODEMP+"."+BA3->BA3_MATRIC+"]")
	ProcessMessage()
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Apura o valor de cobranca da familia...                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
	aVlrFam := PLSVLRFAM(BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),_cAno,_cMes,,,.T.,,,.T.)
	
	IncProcG2("Imprimindo dados ["+BA3->BA3_CODINT+"."+BA3->BA3_CODEMP+"."+BA3->BA3_MATRIC+"]")
	ProcessMessage()                    
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta matriz com valor de cobranca total.                          Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
	aValor := aClone(aVlrFam[1])                
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Matriz que vem lah do vlrfam que contem o total a ser acumulado na |
	//| competencia								                           Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
	If Len(aVlrFam) >= 4
		aValAcu := aClone(aVlrFam[4])                
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta matriz com o detalhe da movimentacao...                      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	aVlrCO := aClone(aVlrFam[3])
	
	If  Type('aValor') <> "A"
		QOut("[SIGAPLS] Retorno da funcao PLSVLRFAM invalida matricula "+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC))
		TRBBA3->(DbSkip())
		Loop
	Endif
	If  aValor[1] .and. Len(aValor[2]) > 0
		aValor := aValor[2]
	Else
		TRBBA3->(DbSkip())
		Loop
	Endif
	If  nCompara == 1
		nValAux := 0
		For n := 1 To Len(aValor)
			If  ! aValor[n,9]
				nValAux += aValor[n,2]
			Endif
		Next
		If  nValAux == BA3->BA3_VALANT
			TRBBA3->(DbSkip())
			Loop
		Endif
	Endif
	nTotFam   := 0
	nTotFaA   := 0     
	nTotFa2	  := 0
	lTemUsr   := .F.
    If  lLisMat
    	cLinFam   := substr(BA3->BA3_MATEMP,1,8) + " " + BA3->(BA3_CODINT+"."+BA3_CODEMP+"-"+BA3_MATRIC)+"-"
    Else
    	cLinFam   := space(9) + BA3->(BA3_CODINT+"."+BA3_CODEMP+"-"+BA3_MATRIC)+"-"
    Endif    	
    
	BA1->( MsSeek( xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) ) )    
	While (!BA1->(EOF())) .And. (BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC == BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC)
		If  nLi > nQtdLin
			R256Cab(.T.)
		Endif
		If  (! Empty(BA1->BA1_DATBLO) .And. DTOS(BA1->BA1_DATBLO) <= DTOS(cDatFin)) .Or. ;
			DTOS(BA1->BA1_DATINC) > DTOS(cDatFin)
			//! Empty(BA1->BA1_MOTBLO)
			BA1->(DbSkip())
			Loop
		Endif
		cLinUsr := BA1->BA1_TIPREG+Space(2)+BA1->BA1_TIPUSU+Space(02)+Substr(BA1->BA1_NOMUSR,1,30)+Space(2)
		nTotUsr := 0
		For nFor := 1 To Len(aValor)
			// Verifica se o lancamento de faturamento esta na lista dos parametros...
			If !Empty(cLancFt)
				If !(aValor[nFor][3] $ cLancFt)
					Loop
				Endif
			Endif
			
			If  aValor[nFor,7] == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) .And. ! aValor[nFor,9]
				If  nTipRel == 1 // relatorio analitico                 
				
				   	If (nModPag == 1 .and. !(aValor[nFor, 3] $ cCodigosPF)) .or.;
				   	   (nModPag == 2 .and.   aValor[nFor, 3] $ cCodigosPF)  .or.;
				   		nModPag == 3 				   
						                                                   
						If nMatAnt == 1
							cLinAux := substr(aValor[nFor,4]+"-"+Left(aValor[nFor,5],25)+Space(100),1,24)+Space(02)+BA1->BA1_MATANT+;
										TransForm(aValor[nFor,2],PLPMONEY_P)+space(01)
						Else
							cLinAux := substr(aValor[nFor,4]+"-"+aValor[nFor,5]+Space(100),1,43)+;
										TransForm(aValor[nFor,2],PLPMONEY_P)+space(01)
						Endif
						
						nLi ++ 
						@ nLi, nColUsr pSay cLinFam + cLinUsr + cLinAux
						
						cLinFam := space(26)  // (17)
						cLinUsr := space(39)

						If aValor[nFor,1] == '1'
							nTotUsr += aValor[nFor,2]
						Else
							nTotUsr -= aValor[nFor,2]
						Endif
										
					Endif
				Else
					If (nModPag == 1 .and. !(aValor[nFor, 3] $ cCodigosPF)) .or.;
				   	   (nModPag == 2 .and.   aValor[nFor, 3] $ cCodigosPF)  .or.;
				   		nModPag == 3 				   
						                                                   
						If aValor[nFor,1] == '1'
							nTotUsr += aValor[nFor,2]
						Else
							nTotUsr -= aValor[nFor,2]
						Endif
										
					Endif
				Endif
			Endif
		Next
		For nFor := 1 To Len(aValAcu)
			
			If !Empty(cLancFt)
				If !(aValAcu[nFor][3] $ cLancFt)
					Loop
				Endif
			Endif
			
			If  aValAcu[nFor,7] == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) .And. ! aValAcu[nFor,9]
				If  nTipRel == 1 // relatorio analitico                 
								   
				 	If (nModPag == 1 .and. !(aValAcu[nFor, 3] $ cCodigosPF)) .or.;
				   	   (nModPag == 2 .and.   aValAcu[nFor, 3] $ cCodigosPF)  .or.;
				   		nModPag == 3 				   
						                                                   
						If nMatAnt == 1
							cLinAux := substr(aValAcu[nFor,4]+"-"+Left(aValAcu[nFor,5],25)+Space(100),1,24)+Space(02)+BA1->BA1_MATANT+;
										TransForm(aValAcu[nFor,24],PLPMONEY_P)+space(01)
						Else
							cLinAux := substr(aValAcu[nFor,4]+"-"+aValAcu[nFor,5]+Space(100),1,43)+;
										TransForm(aValAcu[nFor,24],PLPMONEY_P)+space(01)
						Endif
						
						nLi ++ 
						@ nLi, nColUsr pSay cLinFam + "                **** ACUMULADO 1 ****  " + cLinAux
						
						cLinFam := space(26)  // (17)
						cLinUsr := space(39)
						
						If aValAcu[nFor,25] > 0
							If nMatAnt == 1
								cLinAux := substr(aValAcu[nFor,4]+"-"+Left(aValAcu[nFor,5],25)+Space(100),1,24)+Space(02)+BA1->BA1_MATANT+;
											TransForm(aValAcu[nFor,25],PLPMONEY_P)+space(01)
							Else
								cLinAux := substr(aValAcu[nFor,4]+"-"+aValAcu[nFor,5]+Space(100),1,43)+;
											TransForm(aValAcu[nFor,25],PLPMONEY_P)+space(01)
							Endif
							
							nLi ++ 
							@ nLi, nColUsr pSay cLinFam + "                **** ACUMULADO 2 ****  " + cLinAux
						Endif
						cLinFam := space(26)  // (17)
						cLinUsr := space(39)
						
						nTotFaA	+=	aValAcu[nFor,24]			
						nTotFa2 += aValAcu[nFor,25]
					Endif
				Else
					If (nModPag == 1 .and. !(aValAcu[nFor, 3] $ cCodigosPF)) .or.;
				   	   (nModPag == 2 .and.   aValAcu[nFor, 3] $ cCodigosPF)  .or.;
				   		nModPag == 3 				   
						                                                   
						nTotFaA	+=	aValAcu[nFor,24]			
						nTotFa2 += aValAcu[nFor,25]
					Endif

				Endif
			Endif
			
		Next	
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime a utilizacao em CO do usuario...                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If lDetCO == 1 .and. ( nModPag == 2 .or. nModPag == 3 ) .and. Empty(cLancFt)
			For nFor := 1 To Len(aVlrCO)    
				If  aVlrCO[nFor][2] == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) //.And. ! aValor[nFor,9]
					If  nTipRel == 1 // relatorio analitico
						If  nLi > nQtdLin
							R256Cab(.T.)
						Endif

						// Posiciona o BD6...
						BD6->( dbGoto(aVlrCO[nFor][1]) )
						
						// Imprime os detalhes...
						nLi ++  
						@ nLi, nColCO pSay dToc(BD6->BD6_DATPRO)+" "+;
								Substr(BD6->BD6_NOMRDA,1,30)+" "+;
								Alltrim(Transform(BD6->BD6_CODPRO,PesqPict("BD6","BD6_CODPRO")))+" "+;
								Substr(BD6->BD6_DESPRO,1,40)+"  "+;
								BD6->BD6_CODLDP+"  "+;
								BD6->BD6_CODPEG+" "+;
								BD6->BD6_NUMERO+" "+;
								Iif(lVlrTx, Transform(BD6->BD6_VLRTPF, "@R 9,999,999.99"),;
										    Transform(BD6->BD6_VLRPF, "@R 9,999,999.99") )
					Endif
				Endif
			Next			
		Endif
		
		nTotFam += nTotUsr
		lTemUsr := .T.
		lImp := .T.
		BA1->(DbSkip())
	EndDo
	
	If  nTipRel == 1 // relatorio analitico
		If  lTemUsr  // tem usuario na familia
			If  nTotFam > 0 .or. nFamZer == 1  // Familia tem valor ou eh para imprimir familia sem valor
				nLi ++ 
				@ nLi, 0 pSay    cLinFam + space(07) + "Total da Familia"+replicate(".",68)+TransForm(nTotFam,PLPMONEY_P)
			Endif
			If  nTotFaA > 0 
				nLi ++ 
				@ nLi, 0 pSay    cLinFam + space(07) + "Total da Familia  **** ACUMULADO 1 ****"+replicate(".",45)+TransForm(nTotFaA,PLPMONEY_P)
			Endif
			If  nTotFa2 > 0 
				nLi ++ 
				@ nLi, 0 pSay    cLinFam + space(07) + "Total da Familia  **** ACUMULADO 2 ****"+replicate(".",45)+TransForm(nTotFa2,PLPMONEY_P)
			Endif
		Endif
		If  nCompara == 1 
			nLi ++  
			@ nLi, 0       pSay cLinFam   + space(07) + "TOTAL SIST ANTIGO:"+Space(66)+TransForm(BA3->BA3_VALANT,PLPMONEY_P)
			nLi ++ 
			@ nLi, nColUsr pSay space(17) + space(07) + "DIFERENCA        :"+Space(66)+TransForm((nTotFam-BA3->BA3_VALANT),PLPMONEY_P)
			nLi ++ 
			@ nLi, nColUsr pSay space(17) + space(07) + "MATRICULA ANTIGA :"+Space(66)+BA3->BA3_MATANT
		Endif
	Endif
	nTotCobEmp += nTotFam
	nTotCobCon += nTotFam
	nTotCobSub += nTotFam
	nTotRegEmp += 1
	nTotRegCon += 1
	nTotRegSub += 1
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Reimprime cabecalho se necessario...                               Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  nLi > nQtdLin
		R256Cab(.T.)
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Proxima familia...                                                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	lPF := (BA3->BA3_TIPOUS == "1")
	TRBBA3->(DbSkip())
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Fim do laco...                                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Enddo

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime totais...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
if nTipRel == 1
	If !lPF
		R256Tot(nColSub,nTotCobSub,"Total do Subcontrato")
	Endif
Else                             
	If lPrSubCon  
		@ nLi,113      pSay Transform(nTotCobSub,"@E 999,999,999.99")  
	Endif
Endif		
If !lPF
	R256Tot(nColCon,nTotCobCon,"Total do Contrato")
Endif
R256Tot(nColEmp,nTotCobEmp,"Total do Grupo/Empresa")
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime rodape...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Roda(0,Space(10))
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha area de trabalho...                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRBBA3->( dbClosearea() )
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1
    Set Printer To
    Ourspool(crel)
Endif
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da impressao do relatorio...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return(aCriticas)

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё R256Cab Ё Autor Ё Tulio Cesar            Ё Data Ё 24.11.02 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Cabecalho do relatorio.                                    Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function R256Cab(lPriVez)

nLi := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))

If  lPriVez
    nLi ++ ; @ nLi, nColEmp pSay cCodEmp+" - "+Posicione("BG9",1,xFilial("BG9")+cOpe+cCodEmp,"BG9_DESCRI")
    If  ! lPF
        nLi ++ ; @ nLi, nColCon pSay "Contrato: "+cCodCon
        nLi ++ ; @ nLi, nColSub pSay "Sub - Contrato "+cCodSub+" - "+Posicione("BQC",1,xFilial("BQC")+cOpe+cCodEmp+BA3->BA3_CONEMP+BA3->BA3_VERCON+BA3->BA3_SUBCON+BA3->BA3_VERSUB,"BQC_DESCRI")
    Endif
Endif   

Return

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё R256Tot Ё Autor Ё Tulio Cesar            Ё Data Ё 24.11.02 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Imprime totais...                                          Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function R256Tot(nColImp,nTotCob,cTit)

nLi ++
@ nLi, nColImp pSay cTit
@ nLi,113      pSay Transform(nTotCob,"@E 999,999,999.99")

Return

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё CriaSX1   Ё Autor Ё Angelo Sperandio     Ё Data Ё 03.02.05 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Atualiza SX1                                               Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/

Static Function CriaSX1()

Local aRegs	:=	{}

If PlsGetVersao() >= 8
	If  SX1->(msSeek(cPerg+"04"))
		If Alltrim(SX1->X1_F3) == "B89" 
			   If SX1->(msSeek(cPerg+"30"))	
		           SX1->(RecLock("SX1",.F.))
	    	       SX1->(dbDelete())
	        	   SX1->(msUnLock())
	           Endif
	    Endif
	
	Endif
Endif

If  ! SX1->(msSeek(cPerg+"30"))
    While .T.
       If  SX1->(MsSeek(cPerg))
           SX1->(RecLock("SX1",.F.))
           SX1->(DbDelete())
           SX1->(MsUnLock())
       Else
           Exit
       Endif
    Enddo
Endif

aadd(aRegs,{cPerg,"01","Comparar valor ?              ","","","mv_ch1","N", 1,0,0,"C",""           ,"mv_par01","Sim"         	,"","","","","Nao"            	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"02","Mes ?                         ","","","mv_ch2","C", 2,0,0,"G","PlsVldMes()","mv_par02",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Ano ?                         ","","","mv_ch3","C", 4,0,0,"G",""           ,"mv_par03",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"04","Operadora ?                   ","","","mv_ch4","C", 4,0,0,"G",""           ,"mv_par04",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"05","Tipo contrato ?               ","","","mv_ch5","N", 1,0,0,"C",""           ,"mv_par05","Fisica"      	,"","","","","Juridica"       	,"","","","","Ambas"         ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"06","Grupo/empresa de ?            ","","","mv_ch6","C", 4,0,0,"G",""           ,"mv_par06",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"07","Grupo/empresa ate ?           ","","","mv_ch7","C", 4,0,0,"G",""           ,"mv_par07",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"08","Contrato de ?                 ","","","mv_ch8","C",12,0,0,"G",""           ,"mv_par08",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7BPLS","B7B"),""})
aadd(aRegs,{cPerg,"09","Contrato ate ?                ","","","mv_ch9","C",12,0,0,"G",""           ,"mv_par09",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7BPLS","B7B"),""})
aadd(aRegs,{cPerg,"10","Subcontrato de ?              ","","","mv_cha","C", 9,0,0,"G",""           ,"mv_par10",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7CPLS","B7C"),""})
aadd(aRegs,{cPerg,"11","Subcontrato ate ?             ","","","mv_chb","C", 9,0,0,"G",""           ,"mv_par11",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7CPLS","B7C"),""})
aadd(aRegs,{cPerg,"12","Matricula de ?                ","","","mv_chc","C", 6,0,0,"G",""           ,"mv_par12",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"13","Matricula ate ?               ","","","mv_chd","C", 6,0,0,"G",""           ,"mv_par13",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"14","Matr antiga de ?              ","","","mv_che","C",17,0,0,"G",""           ,"mv_par14",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"15","Matr antiga ate ?             ","","","mv_chf","C",17,0,0,"G",""           ,"mv_par15",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"16","Data referencia ?             ","","","mv_chg","D", 8,0,0,"G",""           ,"mv_par16",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"17","Grupo cobranca de ?           ","","","mv_chh","C", 4,0,0,"G",""           ,"mv_par17",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BR0PLS","BR0"),""})
aadd(aRegs,{cPerg,"18","Grupo cobranca ate ?          ","","","mv_chi","C", 4,0,0,"G",""           ,"mv_par18",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BR0PLS","BR0"),""})
aadd(aRegs,{cPerg,"19","Tipo relatorio                ","","","mv_chj","N", 1,0,0,"C",""           ,"mv_par19","Analitico"   	,"","","","","Sintetico"      	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"20","Lista familia sem valor       ","","","mv_chk","N", 1,0,0,"C",""           ,"mv_par20","Sim"         	,"","","","","Nao"            	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"21","Lista movimetacao             ","","","mv_chl","N", 1,0,0,"C",""           ,"mv_par21","Sim"         	,"","","","","Nao"            	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"22","Lista demitidos               ","","","mv_chm","N", 1,0,0,"C",""           ,"mv_par22","Sim"         	,"","","","","Nao"            	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"23","Produto de                    ","","","mv_chn","C", 4,0,0,"G",""           ,"mv_par23",""         		,"","","","",""            		,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"24","Produto ate                   ","","","mv_cho","C", 4,0,0,"G",""           ,"mv_par24",""         		,"","","","",""            		,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"25","Modalidade de cobranca        ","","","mv_chp","N", 1,0,0,"C",""           ,"mv_par25","Pre-Pagamento"	,"","","","","C. O."			,"","","","","Ambos"         ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"26","Imprime matricula antiga      ","","","mv_chq","N", 1,0,0,"C",""           ,"mv_par26","Sim" 			,"","","","","Nao"				,"","","","",""         	 ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"27","Vencimentos pessoa fisica (,) ","","","mv_chr","C",50,0,0,"G",""           ,"mv_par27","" 				,"","","","",""					,"","","","",""         	 ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"28","Lancamentos de faturamento    ","","","mv_chs","C",60,0,0,"G",""           ,"mv_par28","" 				,"","","","",""					,"","","","",""         	 ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"29","Listar matric empresa ?       ","","","mv_cht","N", 1,0,0,"C",""           ,"mv_par29","Sim"           ,"","","","","Nao"     		    ,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"30","Aglutina valor da taxa ?      ","","","mv_chu","N", 1,0,0,"C",""           ,"mv_par30","Sim" 				,"","","","","Nao"			,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})

PlsVldPerg( aRegs )
    
Return
