#include "PLSMGER.CH"
#Define cCodigosPF  "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155"
#Define PLSVALOR "@E 99,999,999,999.99"
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
user Function PLSR256a() 

Local aCriticas     := {}

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variavaoeis...                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private nQtdLin     := 58
Private cNomeProg   := "PLSR256a"
Private nCaracter   := 15
Private nLimite     := 152
Private cTamanho    := "G"
Private cTitulo     := "Relatorio da Cobranca"
Private cDesc1      := "Relatorio da Cobranca"
Private cDesc2      := ""                         
Private cDesc3      := ""
Private cCabec1     := "                                                                                                      "
Private cCabec2     := ""
Private cAlias      := "BA3"
Private cPerg       := "PLR256a"
Private cRel        := "PLR256a"
Private nLi         := 01
Private m_pag       := 1
Private aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 } 
Private lAbortPrint := .F.                                                                       
Private aOrdens     := { "Operadora+Empresa+Contrato+SubContrato+Matricula", "Operadora+Empresa+Contrato+SubContrato+Nome" } 
Private lDicion     := .F.
Private lCompres    := .F.
Private lCrystal    := .F.
Private lFiltro     := .T.

//здддддддддддддддддддд©
//Ё Ajusta SX1 e SXB   Ё
//юдддддддддддддддддддды
AjustaSX1()
AjustaSXB()

cCabec1 := "                  Matricula Usuario    Tp Nome Usuario                                     Cod  Descricao                  Mat. Antiga                     Valor"
cCabec2 := "Data     Nome do Prestador               Proced            DescriГЦo AMB    Idade                   Dente   Face       L.Dg. PEG      Numero             Valor"
           /*      10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
           1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
           */
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chama SetPrint                                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё VerIfica se foi cancelada a operacao                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nLastKey  == 27
   Return
EndIf
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
EndIf
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Configura Impressora                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cAlias)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta RptStatus...                                                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Proc2BarGauge({|| aCriticas := RImp256() }  , "Imprimindo...") 
                                                                              
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Caso tenha critica...                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If Len(aCriticas) > 0
	PLSCRIGEN(aCriticas,{ {"Matricula","@C",70},{"Critica","@C",170 } },"Criticas do relatorio.")
EndIf

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
Local   nFor
Local	n
Local   lTemUsr
Local   lPrimeiro  := .T.
Local 	aVlrFam    := {}
Local	aVlrCO     := {}
Local 	aCriticas  := {}
Local   aUsuarios  := {}
Local	nColCO	   := 0
Local	lImp       := .T.        
Local  	lAchou     := .F.
Local	aValAcu    := {}
Local	nTotFaA    := 0  
Local	lPrSubCon  := .F.
Local 	cMatricFam := ""
Local 	cChave     := ""			
Local   nVlrDBSub  := 0
Local   nVlrDBCon  := 0
Local   nVlrDBEmp  := 0
Local 	aCobUsr    := {}
Local	cCodint	   := ""	
Private cFor
Private cOrdem
Private cInd       := CriaTrab(Nil,.F.)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicios de colunas...                                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private nColEmp    := 00
Private nColCon    := 03
Private nColSub    := 06
Private nColuna    := 00
Private nColUsr    := 09
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Controles de quebars...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private cCodEmp    := ""
Private cCodCon    := ""
Private cCodSub    := ""
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis de uso generico...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private cLinha     := Space(00)
Private pMoeda     := "@E 99,999,999,999.99"
Private aValor
Private	lPF        := .F.

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Exibe mensagem informativa...                                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//MsProcTXT("Aguarde. Buscando dados no servidor...") 
IncProcG1("Aguarde. Buscando dados no servidor...")
ProcessMessage()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores por Empresa...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private nTotCobEmp := 0
Private nTotRegEmp := 0
Private aQtdusrEmp := 0
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores por Contrato...                                            Ё                                                     
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private nTotCobCon := 0
Private nTotRegCon := 0
Private aQtdusrCon := 0
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores por SubContrato...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Private nTotCobSub := 0
Private nTotRegSub := 0
Private nVlrCob    := 0
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

If Mv_Par22 == 2 //Lista demitidos ? 1=Sim 2=Nao
	cFor += "And (BA3_DESLIG = ' ' OR BA3_DATDES > '" + DtoS(cDatFin) + "') "
EndIf

If !Empty(Mv_Par27) // Vencimento pessoa fisica
	cFor += "AND BA3_VENCTO IN (" + AllTrim(Mv_Par27) + ") "
EndIf

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
                            
BQC->(DbSetOrder(1))

While ! TRBBA3->(Eof())

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Apresenta mensagem em tela...                                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	IncProcG1("Familia ["+TRBBA3->BA3_CODINT+"."+TRBBA3->BA3_CODEMP+"."+TRBBA3->BA3_MATRIC+"]")
	ProcessMessage()
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Posiciona o BA3.                                                         Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	BA3->( dbGoto(TRBBA3->R_E_C_N_O_) )
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё VerIfica tipo de contrato selecionado                              Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  nTipCon <> 3 .and. ; // 1=Fisica 2=Juridica 3=Ambas
		BA3->BA3_TIPOUS <> strzero(nTipCon,1)
		cMatricFam := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
		cChave	   := BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)
		TRBBA3->(DbSkip())
		Loop
	EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Se for pessoa juridica, verIfica se pertence ao grupo de           Ё
	//Ё    cobranca informado nos parametros                               Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  BA3->BA3_TIPOUS == "2" .And. Empty(TRBBA3->BA3_GRPCOB) //nivel mais alto e o da familia.
		If  BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB) <> ;
			BQC->(BQC_CODIGO+BQC_NUMCON+BQC_VERCON+BQC_SUBCON+BQC_VERSUB)
			If  ! BQC->(msSeek(xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))
				Aadd(aCriticas, {BA3->BA3_CODINT+"."+BA3->BA3_CODEMP+"."+BA3->BA3_MATRIC,;
								 "Subcontrato nao encontrado"})
				
				cMatricFam := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
				cChave	   := BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)
				TRBBA3->(DbSkip())
				Loop
			EndIf
		EndIf
		If  BQC->BQC_GRPCOB < cGrpCIni .or. ; // Grupo de cobranca inicial
			BQC->BQC_GRPCOB > cGrpCFin // Grupo de cobranca final
			cMatricFam := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			cChave	   := BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)
			TRBBA3->(DbSkip())
			Loop
		EndIf
	Else
		If  TRBBA3->BA3_GRPCOB < cGrpCIni .or. ; // Grupo de cobranca inicial
			TRBBA3->BA3_GRPCOB > cGrpCFin  // Grupo de cobranca final
			cMatricFam := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			cChave	   := BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)
			TRBBA3->(DbSkip())
			Loop
		EndIf	
	EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё VerIfica se foi abortada a impressao...                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  Interrupcao(lAbortPrint)
		Exit
	EndIf
	
	If lPrimeiro
		A256Cab(.T.,BA3->BA3_CODINT,.T.,BA3->BA3_CODEMP,.T.,BA3->(BA3_CONEMP+BA3_VERCON),.T.,BA3->(BA3_SUBCON+BA3_VERSUB))
		lPrimeiro := .F.
	EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Trata quebras de instituicao...                                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  BA3->BA3_CODEMP <> cCodEmp	

		nVlrDBSub := R256DB(cMatricFam,_cAno,_cMes,"3",cChave,.T.)
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime totais gerais...                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If nTipRel == 2 .and. lPrSubCon
									
			@ nLi,111      pSay Transform(nTotCobSub + nVlrDBSub,PLSVALOR)
			lPrSubCon := .F.
			
		EndIf
		
		If  (nTotRegSub > 0 .or. nVlrDBSub <> 0) .And. !lPF 		
			If nTipRel == 1				
				R256Tot(nColSub,nTotCobSub + nVlrDBSub,"Total do Subcontrato")
			EndIf
			nTotCobSub := 0
			nTotRegSub := 0
		EndIf
		nTotCobCon += nVlrDBSub
		nTotCobEmp += nVlrDBSub		
		nVlrDBCon := R256DB(cMatricFam,_cAno,_cMes,"2",cChave,.T.)
		
		If  (nTotRegCon > 0 .OR. nVlrDBCon <> 0 .or. nTotCobCon <> 0) .And. !lPF											

			nLi--; R256Tot(nColCon,nTotCobCon + nVlrDBCon,"Total do Contrato")
			nTotCobEmp += nVlrDBCon
			nTotCobCon := 0
			nTotRegCon := 0

		EndIf
		
		If  nTotRegEmp > 0 .or. nTotCobEmp <> 0  
			R256Tot(nColEmp,nTotCobEmp,"Total do Grupo/Empresa")
			nLi ++ ; @ nLi, 0 pSay Replicate("-",nLimite); nLi++
			A256Cab(.F.,BA3->BA3_CODINT,.T.,BA3->BA3_CODEMP,.T.,BA3->(BA3_CONEMP+BA3_VERCON),.T.,BA3->(BA3_SUBCON+BA3_VERSUB))

		EndIf
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Remonta dados de quebra...                                         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nTotRegEmp := 0; nTotCobEmp := 0
		nTotRegCon := 0; nTotCobCon := 0
		nTotRegSub := 0; nTotCobSub := 0; nVlrDBSub := 0
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Trata quebras de empresas...                                       Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If  BA3->(BA3_CONEMP+BA3_VERCON) <> cCodCon .and. BA3->BA3_TIPOUS == "2"

		nVlrDBSub := R256DB(cMatricFam,_cAno,_cMes,"3",cChave,.T.)
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime totais gerais...                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If nTipRel == 2 .and. lPrSubCon
			@ nLi,111      pSay Transform(nTotCobSub + nVlrDBSub,PLSVALOR)  
			lPrSubCon := .F.
		EndIf
		
		If  (nTotRegSub > 0 .or. nVlrDBSub <> 0) .And. !lPF							
			If nTipRel == 1
				R256Tot(nColSub,nTotCobSub + nVlrDBSub,"Total do Subcontrato")
			EndIf
			nTotCobSub := 0
			nTotRegSub := 0
		EndIf
		
		nTotCobCon += nVlrDBSub
		nTotCobEmp += nVlrDBSub		
		nVlrDBCon := R256DB(cMatricFam,_cAno,_cMes,"2",cChave,.T.)
										
		If  (nTotRegCon > 0 .OR. nVlrDBCon <> 0 .or. nTotCobCon <> 0) .And. !lPF  

			nLi--; R256Tot(nColCon,nTotCobCon + nVlrDBCon,"Total do Contrato")
			nTotCobEmp += nVlrDBCon
			nTotCobCon := 0
			nTotRegCon := 0
			lPF := .F.      
			
		EndIf		

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Remonta dados da quebra...                                         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nTotCobCon := 0; nTotRegCon := 0
		nTotCobSub := 0; nTotRegSub := 0; nVlrDBSub  := 0
	EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Trata quebras de Sub-Contrato...                                   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If (BA3->(BA3_SUBCON+BA3_VERSUB) <> cCodSub .and. BA3->BA3_TIPOUS == "2" .And. BA3->BA3_CODEMP == cCodEmp) .Or.; // Quebra de subcontrato mesma empresa e mesmo contrato 
	   (BA3->(BA3_CONEMP+BA3_VERCON) != cCodCon .And. BA3->(BA3_SUBCON+BA3_VERSUB) == cCodSub .and. BA3->BA3_TIPOUS == "2" .And. BA3->BA3_CODEMP == cCodEmp) // Quebra de subcontrato mesma empresa e contrato diferente

		nVlrDBSub := R256DB(cMatricFam,_cAno,_cMes,"3",cChave,.T.)		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime totais gerais...                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  nTipRel == 1 .and. (((nTotRegSub > 0 .Or. nVlrDBSub <> 0) .Or. BA3->(BA3_CONEMP+BA3_VERCON) != cCodCon) .And. !lPF) .OR. 	(BA3->(BA3_SUBCON+BA3_VERSUB) <> cCodSub)
		
			If !Empty(cCodSub) .And. BA3->(BA3_CONEMP+BA3_VERCON) == cCodCon
				R256Tot(nColSub,nTotCobSub + nVlrDBSub,"Total do Subcontrato")
			EndIf
			nTotCobSub := 0
			nTotRegSub := 0
			lPF := .F.
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё Remonta dados de quebra...                                         Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды			
			nTotCobSub := 0
			nTotRegSub := 0
			A256Cab(.F.,cOpe,Iif(BA3->BA3_CODEMP<>cCodEmp,.T.,.F.),BA3->BA3_CODEMP,Iif(BA3->(BA3_CONEMP+BA3_VERCON)<>cCodCon,.T.,.F.),BA3->(BA3_CONEMP+BA3_VERCON),Iif(BA3->(BA3_SUBCON+BA3_VERSUB)<>cCodSub .Or. BA3->(BA3_CONEMP+BA3_VERCON)<>cCodCon,.T.,.F.),BA3->(BA3_SUBCON+BA3_VERSUB))
			
		ElseIf nTipRel == 2
		
				If lPrSubCon .And. (nTotCobSub > 0 .Or. nVlrDBSub <> 0)
				@ nLi,111      pSay Transform(nTotCobSub + nVlrDBSub,PLSVALOR)  
			EndIf		
			nTotCobSub := 0
			nTotRegSub := 0
			lPF        := .F.
			lPrSubCon  := .T.
				A256Cab(.F.,cOpe,.F.,cCodEmp,.F.,BA3->(BA3_CONEMP+BA3_VERCON),.T.,BA3->(BA3_SUBCON+BA3_VERSUB))
		EndIf	

		nTotCobCon += nVlrDBSub
		nTotCobEmp += nVlrDBSub
		
	EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Incrementa a regua...                                              Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
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
	   cMatricFam := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
	   cChave	   := BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)
	   TRBBA3->( DbSkip() )
	   Loop
	EndIf   
    
	IncProcG2("Valor de cobranca ["+BA3->BA3_CODINT+"."+BA3->BA3_CODEMP+"."+BA3->BA3_MATRIC+"]")
	ProcessMessage()
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Apura o valor de cobranca da familia...                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
	aVlrFam := PLSVLRFAM(BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),_cAno,_cMes,,,.T.,aUsuarios,,.T.)
	
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
	EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Monta matriz com o detalhe da movimentacao...                      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If Len(aVlrFam) >= 3 // Se o retorno for apenas criticas, nao sera feito o aClone (tratamento de estouro de array).
		aVlrCO := aClone(aVlrFam[3])
	EndIf
	
	If  Type('aValor') <> "A"
		CONOUT("[SIGAPLS] Retorno da funcao PLSVLRFAM invalida matricula "+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC))
		cMatricFam := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
		cChave	   := BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)
		lPF := (BA3->BA3_TIPOUS == "1")
		TRBBA3->(DbSkip())
		Loop
	EndIf
	If  aValor[1] .and. Len(aValor[2]) > 0
		aValor := aValor[2]
	Else
		cMatricFam := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
		cChave	   := BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)
		lPF := (BA3->BA3_TIPOUS == "1")
		TRBBA3->(DbSkip())
		Loop
	EndIf
	If  nCompara == 1
		nValAux := 0
		For n := 1 To Len(aValor)
			If  ! aValor[n,9]
				nValAux += aValor[n,2]
			EndIf
		Next
		If  nValAux == BA3->BA3_VALANT
			cMatricFam := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			cChave	   := BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)
			lPF := (BA3->BA3_TIPOUS == "1")
			TRBBA3->(DbSkip())
			Loop
		EndIf
	EndIf
	nTotFam   := 0
	nTotFaA   := 0     
	nTotFa2	  := 0
	lTemUsr   := .F.
    If  lLisMat
    	cLinFam   := substr(BA3->BA3_MATEMP,1,8) + " " + BA3->(BA3_CODINT+"."+BA3_CODEMP+"-"+BA3_MATRIC)+"-"
    Else
    	cLinFam   := space(9) + BA3->(BA3_CODINT+"."+BA3_CODEMP+"-"+BA3_MATRIC)+"-"
    EndIf    	
    
	BA1->( MsSeek( xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) ) )    
	While (!BA1->(EOF())) .And. (BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC == BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC)
		If  nLi > nQtdLin
			A256Cab(.T.,BA3->BA3_CODINT,.T.,BA3->BA3_CODEMP,.T.,BA3->(BA3_CONEMP+BA3_VERCON),.T.,BA3->(BA3_SUBCON+BA3_VERSUB))
		EndIf            
		
		// VerIfica as regras de cobranca para usuarios bloqueados  
		aCobUsr := AnalisaUsr(_cAno,_cMes)       
		If ! aCobUsr[1]
			BA1->(dbSkip())
			Loop
		EndIf
		
		cLinUsr := BA1->BA1_TIPREG+Space(2)+BA1->BA1_TIPUSU+Space(02)+Substr(BA1->BA1_NOMUSR,1,30)+Space(2)+Str(Calc_Idade( dDataBase,BA1->BA1_DATNAS ),2 )+ " Anos" +Space(10)
		nTotUsr := 0
		For nFor := 1 To Len(aValor)
			// VerIfica se o lancamento de faturamento esta na lista dos parametros...
			If !Empty(cLancFt)
				If !(aValor[nFor][3] $ cLancFt)
					Loop
				EndIf
			EndIf
			
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁTratamento para verIficar se odeb/cred pertence a essa familiaЁ
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
						
			If aValor[nFor,16] = "BSQ" 
			    DbSelectArea("BSQ")
			    DbGoto(aValor[nFor,27])
			    If !BSQ->BSQ_USUARI=aValor[nFor,7]
			        Loop
			    EndIf
			    DbSelectArea("BA1")
			EndIf
			If  aValor[nFor,7] == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) .And. ! aValor[nFor,9]
				If  nTipRel == 1 // relatorio analitico  
				   	If (nModPag == 1 .and. !(aValor[nFor, 3] $ cCodigosPF)) .or.;
				   	   (nModPag == 2 .and.   aValor[nFor, 3] $ cCodigosPF)  .or.;
				   		nModPag == 3 	                                   
						If nMatAnt == 1
							cLinAux := substr(aValor[nFor,4]+"-"+Left(aValor[nFor,5],25)+Space(80),1,22)+Space(02)+BA1->BA1_MATANT+space(13)+;
										TransForm(aValor[nFor,2],PLSVALOR)+space(01)
						Else
							cLinAux := substr(aValor[nFor,4]+"-"+aValor[nFor,5]+Space(80),1,41)+space(13)+;
										TransForm(aValor[nFor,2],PLSVALOR)+space(01)
						EndIf
						nLi ++ 
						@ nLi, nColUsr pSay cLinFam + cLinUsr + cLinAux     ////altamiro
						cLinFam := space(26)
						cLinUsr := space(56)
						If aValor[nFor,1] == '1'
							nTotUsr += aValor[nFor,2]
						Else
							nTotUsr -= aValor[nFor,2]
						EndIf		
					EndIf
				Else // Relatorio sintetico
					If (nModPag == 1 .and. !(aValor[nFor, 3] $ cCodigosPF)) .or.;
				   	   (nModPag == 2 .and.   aValor[nFor, 3] $ cCodigosPF)  .or.;
				   		nModPag == 3                                      
						If aValor[nFor,1] == '1'
							nTotUsr += aValor[nFor,2]
						Else
							nTotUsr -= aValor[nFor,2]
						EndIf			
					EndIf
				EndIf
			EndIf
		Next
		For nFor := 1 To Len(aValAcu)
			If !Empty(cLancFt)
				If !(aValAcu[nFor][3] $ cLancFt)
					Loop
				EndIf
			EndIf
			If  aValAcu[nFor,7] == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) .And. ! aValAcu[nFor,9]
				If  nTipRel == 1 // relatorio analitico   
				 	If (nModPag == 1 .and. !(aValAcu[nFor, 3] $ cCodigosPF)) .or.;
				   	   (nModPag == 2 .and.   aValAcu[nFor, 3] $ cCodigosPF)  .or.;
				   		nModPag == 3                                       
						If nMatAnt == 1
							cLinAux := substr(aValAcu[nFor,4]+"-"+Left(aValAcu[nFor,5],25)+Space(100),1,22)+Space(02)+BA1->BA1_MATANT+Space(13)+;
										TransForm(aValAcu[nFor,24],PLSVALOR)+space(01)
						Else
							cLinAux := substr(aValAcu[nFor,4]+"-"+aValAcu[nFor,5]+Space(100),1,41)+Space(13)+;
										TransForm(aValAcu[nFor,24],PLSVALOR)+space(01)
						EndIf
						nLi ++ 
						@ nLi, nColUsr pSay cLinFam + "                **** ACUMULADO 1 ****  " + cLinAux
						cLinFam := space(26)  // (17)
						cLinUsr := space(56)
						If aValAcu[nFor,25] > 0
							If nMatAnt == 1
								cLinAux := substr(aValAcu[nFor,4]+"-"+Left(aValAcu[nFor,5],25)+Space(100),1,22)+Space(02)+BA1->BA1_MATANT+;
											TransForm(aValAcu[nFor,25],PLSVALOR)+space(01)
							Else
								cLinAux := substr(aValAcu[nFor,4]+"-"+aValAcu[nFor,5]+Space(100),1,41)+;
											TransForm(aValAcu[nFor,25],PLSVALOR)+space(01)
							EndIf
							nLi ++ 
							@ nLi, nColUsr pSay cLinFam + "                **** ACUMULADO 2 ****  " + cLinAux
						EndIf
						cLinFam := space(26)  // (17)
						cLinUsr := space(56)
						nTotFaA	+=	aValAcu[nFor,24]			
						nTotFa2 += aValAcu[nFor,25]
					EndIf
				Else
					If (nModPag == 1 .and. !(aValAcu[nFor, 3] $ cCodigosPF)) .or.;
				   	   (nModPag == 2 .and.   aValAcu[nFor, 3] $ cCodigosPF)  .or.;
				   		nModPag == 3                                    
						nTotFaA	+=	aValAcu[nFor,24]			
						nTotFa2 += aValAcu[nFor,25]
					EndIf
				EndIf
			EndIf
		Next	
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime a utilizacao em CO do usuario...                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If lDetCO == 1 .and. ( nModPag == 2 .or. nModPag == 3 ) .and. Empty(cLancFt)
			For nFor := 1 To Len(aVlrCO)    
				If  aVlrCO[nFor][2] == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) //.And. ! aValor[nFor,9]
					If  nTipRel == 1 // relatorio analitico
						If  nLi > nQtdLin
							A256Cab(.T.,BA1->BA1_CODINT,.T.,BA1->BA1_CODEMP,.T.,BA1->(BA1_CONEMP+BA1_VERCON),.T.,BA1->(BA1_SUBCON+BA1_VERSUB))
						EndIf

						// Posiciona o BD6...
						BD6->( dbGoto(aVlrCO[nFor][1]) )
						// Imprime os detalhes...
						nLi ++  
						@ nLi, nColCO pSay dToc(BD6->BD6_DATPRO)+" "+;
											Substr(BD6->BD6_NOMRDA,1,30)+" "+;
											Transform(BD6->BD6_CODPRO,PesqPict("BD6","BD6_CODPRO"))+" "+;
											Substr(BD6->BD6_DESPRO,1,40)+" "+;
											BD6->BD6_DENREG+space(05)+;
											pad(SubStr(BD6->BD6_FADENT,1,05),05)+" "+;
											BD6->BD6_CODLDP+space(01)+;
											BD6->BD6_CODPEG+space(03)+;
											BD6->BD6_NUMERO+space(02)+;
											IIf(lVlrTx, Transform(BD6->BD6_VLRTPF, PLSVALOR),;
													    Transform(BD6->BD6_VLRPF, PLSVALOR) )
					EndIf
				EndIf
			Next			
		EndIf
		
		nTotFam += nTotUsr
		lTemUsr := .T.
		lImp := .T.
		BA1->(DbSkip())
	EndDo
	
	If  nTipRel == 1 // relatorio analitico
		If  lTemUsr  // tem usuario na familia
			If  nTotFam > 0 .or. nFamZer == 1  // Familia tem valor ou eh para imprimir familia sem valor
				nLi ++ 
				@ nLi, 0 pSay    cLinFam + space(07) + "Total da Familia"+replicate(".",96)+TransForm(nTotFam,PLSVALOR)
			EndIf
			If  nTotFaA > 0 
				nLi ++ 
				@ nLi, 0 pSay    cLinFam + space(07) + "Total da Familia  **** ACUMULADO 1 ****"+replicate(".",73)+TransForm(nTotFaA,PLSVALOR)
			EndIf
			If  nTotFa2 > 0 
				nLi ++ 
				@ nLi, 0 pSay    cLinFam + space(07) + "Total da Familia  **** ACUMULADO 2 ****"+replicate(".",73)+TransForm(nTotFa2,PLSVALOR)
			EndIf
		EndIf
		If  nCompara == 1 
			nLi ++  
			@ nLi, 0       pSay cLinFam   + space(07) + "TOTAL SIST ANTIGO:"+Space(64)+TransForm(BA3->BA3_VALANT,PLSVALOR)
			nLi ++ 
			@ nLi, nColUsr pSay space(17) + space(07) + "DIfERENCA        :"+Space(64)+TransForm((nTotFam-BA3->BA3_VALANT),PLSVALOR)
			nLi ++ 
			@ nLi, nColUsr pSay space(17) + space(07) + "MATRICULA ANTIGA :"+Space(64)+BA3->BA3_MATANT
		EndIf
	EndIf
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
		A256Cab(.T.,BA3->BA3_CODINT,.T.,BA3->BA3_CODEMP,.T.,BA3->(BA3_CONEMP+BA3_VERCON),.T.,BA3->(BA3_SUBCON+BA3_VERSUB))
	EndIf
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Proxima familia...                                                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cMatricFam := BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
	cChave	   := BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)
	lPF := (BA3->BA3_TIPOUS == "1")
	TRBBA3->(DbSkip())
	cCodEmp := BA3->BA3_CODEMP
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Fim do laco...                                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Enddo

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime totais...                                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nVlrDBSub := R256DB(cMatricFam,_cAno,_cMes,"3",cChave,.T.)

If nTipRel == 1
	If !lPF
		R256Tot(nColSub,nTotCobSub + nVlrDBSub,"Total do Subcontrato")
	EndIf
Else                             
	If lPrSubCon  
		@ nLi,111      pSay Transform(nTotCobSub + nVlrDBSub,PLSVALOR)  
	EndIf
EndIf

nTotCobCon += nVlrDBSub	  
nTotCobEmp += nVlrDBSub 

If !lPF
	nVlrDBCon := R256DB(cMatricFam,_cAno,_cMes,"2",cChave,.T.)		
	nLi--; R256Tot(nColCon,nTotCobCon+nVlrDBCon,"Total do Contrato") 
	nTotCobEmp += nVlrDBCon 	
EndIf

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
EndIf
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da impressao do relatorio...                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return(aCriticas)  

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
@ nLi,nColImp pSay cTit
@ nLi,144     pSay Transform(nTotCob,"@E 999,999,999,999.99")

Return
    

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё R256DB Ё Autor Ё David de Oliveira      Ё Data Ё 28.05.08 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Imprime DИbitos e CrИditos...                              Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function R256DB(cMatricFam,cAno,cMes,cNivel,cChave,lConsNiv) 
Local aVlrDB 	:= {}
Local nRet		:= 0
Local nI		:= 0
Local cLinAux	:= ""
Local cLin		:= "(D)Иbitos e (C)rИditos"
Local cTip		:= ""

cLin	:= cLin+Space(63-Len(cLin))
aVlrDB := PLSSLDDCF(cMatricFam,cAno,cMes,nil,nil,.T.,cNivel,cChave,,lConsNiv)

For nI:= 1 to Len(aVlrDB)
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁTratamento para que nЦo calcule os deb/cred dos itens ja calculados na falimiliaЁ
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If cNivel $ "1,2"  
		If !EmpTy(aVlrDB[nI,13]) // se pertece a uma familia
		    Loop
		EndIf
	EndIf
	
  	If cNivel == "3"  
		BSQ->(Dbgoto(aVlrDB[nI,8])) // se pertece a um usuario jА foi considerado na familia
		If !Empty(BSQ->BSQ_MATRIC)
		    Loop
		Endif
	Endif
   
	If aVlrDB[nI,5] == "1" 
		nRet += aVlrDB[nI,6]
		cTip := "(D)"
	ElseIf aVlrDB[nI,5] == "2"  
		nRet -= aVlrDB[nI,6]		
		cTip := "(C)"
	EndIf
	If  nTipRel == 1
		nLi++		
		cLinAux := cTip+substr(aVlrDB[nI,3]+"-"+aVlrDB[nI,4]+Space(100),1,40)+;
  				   TransForm(aVlrDB[nI,6],PLSVALOR)+space(01)		 
		If  nLi > nQtdLin
			R256Cab(.T.)
		EndIf		
		@ nLi, nColUsr pSay cLin + cLinAux
		cLin := space(63)
	EndIf
Next

nLi ++  

Return(nRet)
    

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠Ё Fun┤┘o    ЁAjustaSX1 Ё Autor Ё Julio C.Guerato       Ё Data Ё 17/03/10 Ё╠╠
╠╠цдддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠Ё Descri┤┘o |Ajusta SX1 com as consultas padrУes                         Ё╠╠
╠╠цдддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso       Ё                                                            Ё╠╠
╠╠цдддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function AjustaSX1()  

cPerg := padr("PLR256",Len(SX1->X1_GRUPO))

DbSelectArea("SX1")
SX1->(DbSetOrder(1))

If SX1->(MsSeek(cPerg+"12")) .AND. Alltrim(SX1->X1_F3) <> "BA1PLS" 
	SX1->(RecLock("SX1",.F.))
	SX1->X1_F3   := "BA1PLS"
	SX1->X1_PYME := "N"
	SX1->(MsUnLock())
EndIf

If SX1->(MsSeek(cPerg+"13")) .AND. Alltrim(SX1->X1_F3) <> "BA1PLS" 
	SX1->(RecLock("SX1",.F.))
	SX1->X1_F3   := "BA1PLS"
	SX1->X1_PYME := "N"
	SX1->(MsUnLock())
EndIf 

Return
         

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠Ё Fun┤┘o    ЁAjustaSXB Ё Autor Ё Timoteo Bega          Ё Data Ё 23/04/10 Ё╠╠
╠╠цдддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠Ё Descri┤┘o |Ajusta SXB; F3 de Grupo empresa do tipo 6 ( SCCWNI ).       Ё╠╠
╠╠цдддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso       Ё                                                            Ё╠╠
╠╠цдддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function AjustaSXB() 

Local nJ      := 0 
Local nI      := 0
Local aSXB 	  := {}
Local bAtu	  := .F.      
Local aEstrut := {"XB_ALIAS","XB_TIPO","XB_SEQ","XB_COLUNA","XB_DESCRI","XB_DESCSPA","XB_DESCENG","XB_CONTEM","XB_WCONTEM"}
                             
dbSelectArea("SXB")
SXB->(DbSetOrder(1))

If !SXB->(MsSeek("B7APLS"+"6"+"01"+"01")) .Or. SXB->(MsSeek("B7APLS"+"6"+"01"+"01")) .And. SXB->XB_CONTEM  <> 'PlsFilTp6("BG9")' 
	bAtu := .T.
	aAdd(aSXB,{	"B7APLS","6","01","01","","","",'PlsFilTp6("BG9")'})
EndIf 

If !SXB->(DbSeek("BA1PLS"))        
	bAtu := .T.
    aAdd(aSXB,{"BA1PLS","1","01","DB","Usuarios","Usuarios","Users","BA1",""})	 
	aAdd(aSXB,{"BA1PLS","2","01","02","Matricula","Matricula","Registration","",""})
	aAdd(aSXB,{"BA1PLS","2","02","03","Nome","Nombre","Name","",""})                 
	aAdd(aSXB,{"BA1PLS","2","03","01","Numero do Contrato","Numero del Contrato","Contract Number","",""})
	aAdd(aSXB,{"BA1PLS","2","04","05","Matric Sist.Antigo","Matric Sist.Anterior","Former System Reg.","",""})
	aAdd(aSXB,{"BA1PLS","4","01","01","Matricula","Matricula","Registration","BA1->(BA1_CODINT+'.'+BA1_CODEMP+'.'+BA1_MATRIC + '-' + BA1_TIPREG+'-'+BA1_DIGITO)",""})
	aAdd(aSXB,{"BA1PLS","4","01","02","Nome do Usuario","Nombre del Usuario","User Name","BA1_NOMUSR",""})
	aAdd(aSXB,{"BA1PLS","4","02","01","Matricula","Matricula","Registration","BA1->(BA1_CODINT+'.'+BA1_CODEMP+'.'+BA1_MATRIC + '-' + BA1_TIPREG+'-'+BA1_DIGITO)",""})
	aAdd(aSXB,{"BA1PLS","4","02","02","Nome do Usuario","Nombre del Usuario","User Name","BA1_NOMUSR",""})
	aAdd(aSXB,{"BA1PLS","4","03","01","Numero do Contrato","Numero del Contrato","Contract Number","BA1_NUMCON",""})
	aAdd(aSXB,{"BA1PLS","4","03","02","Nome do Usuario","Nombre del Usuario","User Name","BA1_NOMUSR",""})
	aAdd(aSXB,{"BA1PLS","4","04","01","Matric Sist.Antigo","Matric Sist.Anterior","Former System Reg.","BA1->(BA1_MATANT+BA1_TIPANT)",""})
	aAdd(aSXB,{"BA1PLS","4","04","02","Matricula","Matricula","Registration","BA1->(BA1_CODINT+'.'+BA1_CODEMP+'.'+BA1_MATRIC + '-' + BA1_TIPREG+'-'+BA1_DIGITO)",""})
	aAdd(aSXB,{"BA1PLS","4","04","03","Nome do Usuario","Nombre del Usuario","User Name","BA1_NOMUSR",""})
	aAdd(aSXB,{"BA1PLS","5","01","01","","","","BA1_MATRIC",""})
	aAdd(aSXB,{"BA1PLS","6","01","01","","","","PLSFilTp6('BA1')",""})						 
EndIf 

If bAtu	
	For nI := 1 To Len(aSXB)
		If !SXB->(MsSeek(aSXB[nI][1]+aSXB[nI][2]+aSXB[nI][3]+aSXB[nI][4]))
			RecLock("SXB",.T.)
		Else
			RecLock("SXB",.F.)
		EndIf  
		For nJ:=1 To Len(aSXB[nI])
			If !Empty(FieldName(FieldPos(aEstrut[nJ]))) .And. aSXB[nI,nJ] != NIL
				FieldPut(FieldPos(aEstrut[nJ]),aSXB[nI,nJ])
			EndIf
		Next nJ
		dbCommit()
		MsUnLock()
	Next nI
EndIf

Return

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁA256Cab   ╨Autor  ЁMicrosiga           ╨ Data Ё  23/11/2011 ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     Ё Imprime o cabecalho dos grupos empresa/contrato/subcontrato╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё SIGAPLS                                                    ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function A256Cab(lCabRel,cOpe,lEmp,cEmp,lCon,cCon,lSub,cSub)

If lCabRel
	nLi := cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
EndIf

If lEmp .And. !Empty(cEmp) //Grupo empresa
	nLi ++ ; @ nLi, nColEmp pSay "Empresa: " + cEmp + " - " + Posicione("BG9",1,xFilial("BG9")+cOpe+cEmp,"BG9_DESCRI")
	cCodEmp := cEmp
EndIf

If (lCon .Or. lEmp) .And. !Empty(cCon) //Contrato
	nLi ++ ; @ nLi, nColCon pSay "Contrato: " + cCon
	cCodCon := cCon
EndIf

If (lSub .Or. lEmp) .And. !Empty(cSub) //Subcontrato
	nLi ++ ; @ nLi, nColSub pSay "Subcontrato: " + cSub + " - " + Posicione("BQC",1,xFilial("BQC")+cOpe+cEmp+cCon+cSub,"BQC_DESCRI")
	cCodSub := cSub
EndIf

Return Nil 
