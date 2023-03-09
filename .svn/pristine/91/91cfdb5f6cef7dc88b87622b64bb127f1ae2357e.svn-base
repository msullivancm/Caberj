#include "PROTHEUS.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "RWMAKE.CH"

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбддддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё CRJR022 Ё Autor Ё Thiago Machado Correa  Ё Data Ё 13.08.08 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддаддддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio gerencial de provisionamento por plano.          Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

User Function CRJR022()

Private oLeTxt
Private cPerg := "CRJ022"

CriaSX1(cPerg)

@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Provisionamento DИbito x CrИdito por Plano")
@ 02,10 TO 65,180
@ 10,018 Say " Este relatСrio tem por objetivo listar de forma agrupada por "
@ 18,018 Say " DИbito/CrИdito informaГУes de provisionamento no formato "
@ 26,018 Say " anaМtico e sintИtico."

@ 70,098 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)
@ 70,128 BMPBUTTON TYPE 01 ACTION Processa({|| Processa1(cPerg)},"Preparando Ambiente...")
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё Processa1Ё Autor Ё Thiago Machado Correa Ё Data Ё 13.08.08 Ё╠╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Relatorio gerencial de provisionamento por plano.          Ё╠╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function Processa1(cPerg)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define variaveis...                                                      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nQtdLin 	:= 73
PRIVATE cNomeProg   := "CRJR022"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Provisionamento DИbito x CrИdito por Plano"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""                         
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "------------------------------------ DИbito -------------------------------------   ------------------------------------- CrИdito -----------------------------------  ----------------"
PRIVATE cCabec2     := "Contra-PrestaГЦo  Co-ParticipaГЦo    Parcelamento          Outros           Total   Contra-PrestaГЦo  Co-ParticipaГЦo    Parcelamento          Outros           Total       Total Geral"
PRIVATE cAlias      := "BA3"
PRIVATE cRel        := "CRJR022"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 } 
PRIVATE lAbortPrint := .F.                                                                       
PRIVATE aOrdens     := {} 
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chama SetPrint                                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
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

cOpe     := mv_par01
_cMes    := mv_par02
_cAno    := mv_par03
nTipCon  := mv_par04
cGrupIni := mv_par05
cGrupFim := mv_par06
cContDe  := mv_par07
cContAte := mv_par08                              
cSubConI := mv_par09
cSubConF := mv_par10
cGrpCIni := mv_par11
cGrpCFin := mv_par12
cCodPlaI := mv_par13
cCodPlaF := mv_par14
nTipRel  := mv_par15
               
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta novo nome do titulo do relatorio mostrando mes/ano                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(_cMes)) + "/" + _cAno

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Configura Impressora                                                     Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cAlias)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta RptStatus...                                                       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Processa({|| RJ022Imp()},"Imprimindo...")
                                                                              
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fim da Rotina Principal...                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Return


/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠╠
╠╠ЁFuncao    Ё RJ022ImpЁ Autor Ё Thiago Machado Correa Ё Data Ё 14.08.08 Ё╠╠╠
╠╠цддддддддддедддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠╠
╠╠ЁDescricao Ё Funcao Principal				                             Ё╠╠╠
╠╠юддддддддддаддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function RJ022Imp()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis do IndRegua...                                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL i
LOCAL n
LOCAL nDebCon 	:= 0
LOCAL nDebCop 	:= 0
LOCAL nDebPar 	:= 0
LOCAL nDebOut 	:= 0
LOCAL nDebTot 	:= 0
LOCAL nCreCon 	:= 0
LOCAL nCreCop 	:= 0
LOCAL nCrePar 	:= 0
LOCAL nCreOut 	:= 0
LOCAL nCreTot 	:= 0
LOCAL nTotGer 	:= 0
LOCAL pMoeda1	:= "@E 9,999,999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL nPos		:= 0
LOCAL aPlanos 	:= {}
LOCAL aPlaUsr	:= {}
LOCAL nPosPla	:= 0
LOCAL nQtd      := 0
LOCAL _cCodPla	:= ""
LOCAL _cVerPla 	:= ""
LOCAL cCodDB    := PLSRETLADC()        

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Totalizadores...                                            			 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE nPlaDebCon 	:= 0
PRIVATE nPlaDebCop 	:= 0
PRIVATE nPlaDebPar 	:= 0
PRIVATE nPlaDebOut 	:= 0
PRIVATE nPlaDebTot 	:= 0
PRIVATE nPlaCreCon 	:= 0
PRIVATE nPlaCreCop 	:= 0
PRIVATE nPlaCrePar 	:= 0
PRIVATE nPlaCreOut 	:= 0
PRIVATE nPlaCreTot 	:= 0
PRIVATE nPlaTotGer 	:= 0
PRIVATE nTotDebCon 	:= 0
PRIVATE nTotDebCop 	:= 0
PRIVATE nTotDebPar 	:= 0
PRIVATE nTotDebOut 	:= 0
PRIVATE nTotDebTot 	:= 0
PRIVATE nTotCreCon 	:= 0
PRIVATE nTotCreCop 	:= 0
PRIVATE nTotCrePar 	:= 0
PRIVATE nTotCreOut 	:= 0
PRIVATE nTotCreTot 	:= 0
PRIVATE nTotTotGer 	:= 0

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta Expressao de filtro...                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BA1_NOMUSR, BM1_CODTIP, BM1_DESTIP, BM1_TIPO, "
cSql +=	"BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BA1_CODPLA, BA1_VERSAO, "
cSql += "BM1_CODPLA, BM1_VERPLA, BM1_AGFTFU "
cSql += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BM1")+" BM1 "
cSql += "WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
cSql += "AND BM1_FILIAL = '"+xFilial("BM1")+"' "
cSql += "AND BM1.BM1_CODINT = '"+cOpe+"' "
cSql += "AND BM1.BM1_CODEMP >= '"+cGrupIni+"' "
cSql += "AND BM1.BM1_CODEMP <= '"+cGrupFim+"' "
cSql += "AND BM1.BM1_CONEMP >= '"+cContDe +"' "
cSql += "AND BM1.BM1_CONEMP <= '"+cContAte+"' "
cSql += "AND BM1.BM1_SUBCON >= '"+cSubConI+"' "
cSql += "AND BM1.BM1_SUBCON <= '"+cSubConF+"' "
cSql += "AND BM1.BM1_ANO = '"+ _cAno +"' "
cSql += "AND BM1.BM1_MES = '"+ _cMes +"' "
cSql += "AND BM1.D_E_L_E_T_ = ' ' "
cSql += "AND BA1.D_E_L_E_T_ = ' ' "
cSql += "AND BA1_CODINT = BM1.BM1_CODINT "
cSql += "AND BA1_CODEMP = BM1.BM1_CODEMP "
cSql += "AND BA1_MATRIC = BM1.BM1_MATRIC "
cSql += "AND BA1_TIPREG = BM1.BM1_TIPREG "
cSql += "AND BA1_DIGITO = BM1.BM1_DIGITO "
cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "

PlsQuery(cSql, "TRB")

TRB->(DBEval( { | | nQtd++ }))

ProcRegua(nQtd)

TRB->(DbGoTop())

BQC->(DbSetOrder(1))
BFQ->(DbSetOrder(1))
BI3->(dbSetorder(1))
SE1->(dbSetorder(1))

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define matriz de planos...                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aPlanos := {}

While ! TRB->(Eof())
	
	cFam := TRB->( BM1_CODINT + BM1_CODEMP + BM1_MATRIC )
	aPlaUsr := {}
		
	While !TRB->( Eof() ) .and. TRB->( BM1_CODINT + BM1_CODEMP + BM1_MATRIC ) == cFam
	
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Apresenta mensagem em tela...                                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		IncProc("Familia ["+TRB->BM1_CODINT+"."+TRB->BM1_CODEMP+"."+TRB->BM1_MATRIC+"]")

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Ignora BM1 diferente de debitos e creditos...                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If ! (TRB->BM1_CODTIP $ cCodDB)
			TRB->( dbSkip() )
			Loop
		Endif

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Posiciona a familia do usuario                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) <> BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			BA3->( MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)) )
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se titulo existe, para ignorar os casos com desconto em folha que nao gera o titulo
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If !SE1->( dbSeek(xFilial("SE1")+TRB->(BM1_PREFIX + BM1_NUMTIT + BM1_PARCEL + BM1_TIPTIT)) )
			TRB->( dbSkip() )
			Loop
		Endif

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Define qual o plano do usuario...                                  Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		_cCodPla := ''
		_cVerPla := ''
		
		// Regra numero um: Utiliza o plano do BM1.
		If !Empty(TRB->BM1_CODPLA) .and. !Empty(TRB->BM1_VERPLA)
			_cCodPla := TRB->BM1_CODPLA
			_cVerPla := TRB->BM1_VERPLA
			
		Else
			// Regra numero dois: Utiliza o plano informado na mensalidade para os demais eventos.
			If TRB->BM1_CODTIP $ '101'		// Mensalidade
				_cCodPla := Alltrim(TRB->BM1_CODEVE)
				_cVerPla := '001'
				
				// Guarda o plano do usuario
				Aadd(aPlaUsr, {TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG), '101', Alltrim(TRB->BM1_CODEVE)})
				
			Else
				// Considera o plano informado no BM1_CODEVE da mensalidade 101...
				If (nPosPla := Ascan(aPlaUsr, {|x| x[1] == TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG) .and.;
					x[2] == '101'})) > 0
					_cCodPla := aPlaUsr[nPosPla][3]
					_cVerPla := '001'
				Endif
			Endif
		Endif
		
		// Regra numero tres: Utiliza o plano do usuario ou da familia.
		If Empty(_cCodPla)
			If !Empty(TRB->BA1_CODPLA)
				_cCodPla := TRB->BA1_CODPLA
				_cVerPla := TRB->BA1_VERSAO
			Else
				_cCodPla := BA3->BA3_CODPLA
				_cVerPla := BA3->BA3_VERSAO
			Endif
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se pode considerar o plano, de acordo com parametros...   Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  _cCodPla < cCodPlaI .or. _cCodPla > cCodPlaF
			TRB->(DbSkip())
			Loop
		EndIf
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica se foi abortada a impressao...                            Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If  Interrupcao(lAbortPrint)
			Exit
		Endif

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Posiciona Tipo de Lancamento de Faturamento...                     Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		BFQ->(MsSeek(xFilial("BFQ")+cOpe+TRB->BM1_CODTIP))
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Constroi matriz com os planos que serao impressos.                 Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPos := Ascan(aPlanos, {|x| x[1] == _cCodPla .and. x[2] == _cVerPla .and. x[3] == TRB->BM1_CODTIP} )
		
		If nPos == 0
			Aadd(aPlanos,{_cCodPla,_cVerPla,TRB->BM1_CODTIP,BFQ->BFQ_DEBCRE,BFQ->BFQ_YTPCTB,TRB->BM1_VALOR})
		Else
			aPlanos[nPos][6] += TRB->BM1_VALOR
		Endif
		
		TRB->(DbSkip())
	Enddo
	
Enddo

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicializa impressao                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Asort(aPlanos,,, {|x, y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3]})

If nTipRel == 1 //Analitico
	cCabec1 := "                                     " + cCabec1
	cCabec2 := "Lancamento de Faturamento            " + cCabec2
Else
	cCabec1 := "                                     " + cCabec1
	cCabec2 := "Plano/Versao                         " + cCabec2
Endif

// Controle de saldo de pagina...
nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
nli++               	

nPos := 1

While nPos <= Len(aPlanos)

	// Controle de saldo de pagina...
	If  nli > nQtdLin
	   	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    nli++               	
	Endif

	_cCodPla := aPlanos[nPos][1]
	_cVerPla := aPlanos[nPos][2]

	BI3->(MsSeek(xFilial("BI3")+cOpe+_cCodPla+_cVerPla))

	If nTipRel == 1 //Analitico
		@ nLi, 000 Psay "Plano: " + _cCodPla + "." + _cVerPla + " - " + BI3->BI3_DESCRI
	 	nLi++
	 	nLi++
    Endif
    
	While (nPos <= Len(aPlanos)) .and. (_cCodPla+_cVerPla) == (aPlanos[nPos][1]+aPlanos[nPos][2])

		// Controle de saldo de pagina...
		If  nli > nQtdLin
		   	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
		    nli++               	
		Endif

		//Inicializa Variaveis
		nDebCon 	:= 0
		nDebCop 	:= 0
		nDebPar 	:= 0
		nDebOut 	:= 0
		nDebTot 	:= 0
		nCreCon 	:= 0
		nCreCop 	:= 0
		nCrePar 	:= 0
		nCreOut 	:= 0
		nCreTot 	:= 0
		nTotGer 	:= 0
		                                      
		If aPlanos[nPos][4] == "1" //Debito
		
			Do Case
				Case aPlanos[nPos][5] == "1" 
					nDebCon := aPlanos[nPos][6] //Contra-Prestacao
				Case aPlanos[nPos][5] == "2" 
					nDebCop := aPlanos[nPos][6] //Co-Participacao
				Case aPlanos[nPos][5] == "3" 
					nDebPar := aPlanos[nPos][6] //Parcelamento
				OtherWise                   
					nDebOut := aPlanos[nPos][6] //Outros
			EndCase
			
			nDebTot := (nDebCon+nDebCop+nDebPar+nDebOut)

		Else

			Do Case
				Case aPlanos[nPos][5] == "1" 
					nCreCon := aPlanos[nPos][6] //Contra-Prestacao
				Case aPlanos[nPos][5] == "2" 
					nCreCop := aPlanos[nPos][6] //Co-Participacao
				Case aPlanos[nPos][5] == "3" 
					nCrePar := aPlanos[nPos][6] //Parcelamento
				OtherWise                   
					nCreOut := aPlanos[nPos][6] //Outros
			EndCase
			
			nCreTot := (nDebCon+nDebCop+nDebPar+nDebOut)
					
		Endif
		
		nTotGer := (nDebTot-nCreTot)

		If nTipRel == 1 //Analitico
			BFQ->(MsSeek(xFilial("BFQ")+cOpe+aPlanos[nPos][3]))
	
			@ nLi,000 Psay aPlanos[nPos][3] + "-" + BFQ->BFQ_DESCRI + "   " + Transform(nDebCon,pMoeda1)+;
											  				 		   " " + Transform(nDebCop,pMoeda1)+;
											  				 		   "  " + Transform(nDebPar,pMoeda2)+;
											  				 		   "  " + Transform(nDebOut,pMoeda2)+;
											  				 		   "  " + Transform(nDebTot,pMoeda2)+;
											  				 		   "   " + Transform(nCreCon,pMoeda1)+;
											  				 		   " " + Transform(nCreCop,pMoeda1)+;
											  				 		   "  " + Transform(nCrePar,pMoeda2)+;
											  				 		   "  " + Transform(nCreOut,pMoeda2)+;
											  				 		   "  " + Transform(nCreTot,pMoeda2)+;
											  				 		   "  " + Transform(nTotGer,pMoeda1)
		 	nLi++
		Endif

		//Acumula Totalizadores do Plano
		nPlaDebCon 	+= nDebCon
		nPlaDebCop 	+= nDebCop
		nPlaDebPar 	+= nDebPar
		nPlaDebOut 	+= nDebOut
		nPlaDebTot 	+= nDebTot
		nPlaCreCon 	+= nCreCon
		nPlaCreCop 	+= nCreCop
		nPlaCrePar 	+= nCrePar
		nPlaCreOut 	+= nCreOut
		nPlaCreTot 	+= nCreTot
		nPlaTotGer 	+= nTotGer
		
		nPos++
 	EndDo

	// Controle de saldo de pagina...
	If  nli+3 > nQtdLin
	   	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    nli++               	
	Endif

	If nTipRel == 1 //Analitico
	 	nLi++
		@ nLi, 000 Psay Replicate('-', nLimite)
	 	nLi++
		@ nLi,000 Psay "Total do Plano " + _cCodPla + "." + _cVerPla + ":" + Space(10)+; 
												"   " + Transform(nPlaDebCon,pMoeda1)+;
										  		" " + Transform(nPlaDebCop,pMoeda1)+;
										  		"  " + Transform(nPlaDebPar,pMoeda2)+;
										  		"  " + Transform(nPlaDebOut,pMoeda2)+;
										  		"  " + Transform(nPlaDebTot,pMoeda2)+;
										  		"   " + Transform(nPlaCreCon,pMoeda1)+;
										  		" " + Transform(nPlaCreCop,pMoeda1)+;
										  		"  " + Transform(nPlaCrePar,pMoeda2)+;
										  		"  " + Transform(nPlaCreOut,pMoeda2)+;
										  		"  " + Transform(nPlaCreTot,pMoeda2)+;
										  		"  " + Transform(nPlaTotGer,pMoeda1)
	 	nLi++
		@ nLi, 000 Psay Replicate('-', nLimite)
	 	nLi++
	 	nLi++
    Else
		@ nLi,000 Psay _cCodPla + "." + _cVerPla + " - " + substring(BI3->BI3_DESCRI,1,23)+;
												"   " + Transform(nPlaDebCon,pMoeda1)+;
										  		" " + Transform(nPlaDebCop,pMoeda1)+;
										  		"  " + Transform(nPlaDebPar,pMoeda2)+;
										  		"  " + Transform(nPlaDebOut,pMoeda2)+;
										  		"  " + Transform(nPlaDebTot,pMoeda2)+;
										  		"   " + Transform(nPlaCreCon,pMoeda1)+;
										  		" " + Transform(nPlaCreCop,pMoeda1)+;
										  		"  " + Transform(nPlaCrePar,pMoeda2)+;
										  		"  " + Transform(nPlaCreOut,pMoeda2)+;
										  		"  " + Transform(nPlaCreTot,pMoeda2)+;
										  		"  " + Transform(nPlaTotGer,pMoeda1)
	 	nLi++
    Endif
    
	//Acumula Totalizadores Gerais
	nTotDebCon 	+= nPlaDebCon
	nTotDebCop 	+= nPlaDebCop
	nTotDebPar 	+= nPlaDebPar
	nTotDebOut 	+= nPlaDebOut
	nTotDebTot 	+= nPlaDebTot
	nTotCreCon 	+= nPlaCreCon
	nTotCreCop 	+= nPlaCreCop
	nTotCrePar 	+= nPlaCrePar
	nTotCreOut 	+= nPlaCreOut
	nTotCreTot 	+= nPlaCreTot
	nTotTotGer 	+= nPlaTotGer

	//Limpa Variaveis
	nPlaDebCon := 0
	nPlaDebCop := 0
	nPlaDebPar := 0
	nPlaDebOut := 0
	nPlaDebTot := 0
	nPlaCreCon := 0
	nPlaCreCop := 0
	nPlaCrePar := 0
	nPlaCreOut := 0
	nPlaCreTot := 0
	nPlaTotGer := 0

EndDo

// Controle de saldo de pagina...
If  nli+3 > nQtdLin
   	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
    nli++               	
Endif

nLi++
@ nLi, 000 Psay Replicate('=', nLimite)
nLi++
@ nLi,000 Psay "T O T A L   G E R A L" + ":" + Space(12)+;
										"   " + Transform(nTotDebCon,pMoeda1)+;
								  		" " + Transform(nTotDebCop,pMoeda1)+;
								  		"  " + Transform(nTotDebPar,pMoeda2)+;
								  		"  " + Transform(nTotDebOut,pMoeda2)+;
								  		"  " + Transform(nTotDebTot,pMoeda2)+;
								  		"   " + Transform(nTotCreCon,pMoeda1)+;
								  		" " + Transform(nTotCreCop,pMoeda1)+;
								  		"  " + Transform(nTotCrePar,pMoeda2)+;
								  		"  " + Transform(nTotCreOut,pMoeda2)+;
								  		"  " + Transform(nTotCreTot,pMoeda2)+;
								  		"  " + Transform(nTotTotGer,pMoeda1)
nLi++
@ nLi, 000 Psay Replicate('=', nLimite)
nLi++

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fecha area de trabalho...                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRB->( dbClosearea() )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Libera impressao                                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If  aReturn[5] == 1
    Set Printer To
    Ourspool(crel)
Endif

Return

/*/
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠здддддддддддбдддддддддддбдддддддбддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁPrograma   Ё CriaSX1   Ё Autor Ё Thiago Machado CorreaЁ Data Ё 13.08.08 Ё╠╠
╠╠цдддддддддддедддддддддддадддддддаддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao  Ё Atualiza SX1                                               Ё╠╠
╠╠юдддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function CriaSX1(cPerg)

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Operadora ?                   ","","","mv_ch1","C", 4,0,0,"G",""           ,"mv_par01",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Mes ?                         ","","","mv_ch2","C", 2,0,0,"G","PlsVldMes()","mv_par02",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Ano ?                         ","","","mv_ch3","C", 4,0,0,"G",""           ,"mv_par03",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"04","Tipo contrato ?               ","","","mv_ch4","N", 1,0,0,"C",""           ,"mv_par04","Fisica"      	,"","","","","Juridica"       	,"","","","","Ambas"         ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"05","Grupo/empresa de ?            ","","","mv_ch5","C", 4,0,0,"G",""           ,"mv_par05",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"06","Grupo/empresa ate ?           ","","","mv_ch6","C", 4,0,0,"G",""           ,"mv_par06",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"07","Contrato de ?                 ","","","mv_ch7","C",12,0,0,"G",""           ,"mv_par07",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7BPLS","B7B"),""})
aadd(aRegs,{cPerg,"08","Contrato ate ?                ","","","mv_ch8","C",12,0,0,"G",""           ,"mv_par08",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7BPLS","B7B"),""})
aadd(aRegs,{cPerg,"09","Subcontrato de ?              ","","","mv_ch9","C", 9,0,0,"G",""           ,"mv_par09",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7CPLS","B7C"),""})
aadd(aRegs,{cPerg,"10","Subcontrato ate ?             ","","","mv_cha","C", 9,0,0,"G",""           ,"mv_par10",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7CPLS","B7C"),""})
aadd(aRegs,{cPerg,"11","Grupo cobranca de ?           ","","","mv_chb","C", 4,0,0,"G",""           ,"mv_par11",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BR0PLS","BR0"),""})
aadd(aRegs,{cPerg,"12","Grupo cobranca ate ?          ","","","mv_chc","C", 4,0,0,"G",""           ,"mv_par12",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BR0PLS","BR0"),""})
aadd(aRegs,{cPerg,"13","Produto de                    ","","","mv_chd","C", 4,0,0,"G",""           ,"mv_par13",""         	,"","","","",""            		,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"14","Produto ate                   ","","","mv_che","C", 4,0,0,"G",""           ,"mv_par14",""         	,"","","","",""            		,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"15","Tipo de ImpressЦo ?           ","","","mv_chf","N", 1,0,0,"C",""           ,"mv_par15","Analitico"   	,"","","","","Sintetico"       	,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})

PlsVldPerg( aRegs )
    
Return