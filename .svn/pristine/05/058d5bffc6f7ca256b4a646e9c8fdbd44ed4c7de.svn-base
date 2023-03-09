#include "PLSMGER.CH"
#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

Static cCodDB     := PLSRETLADC()        
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CRJR002 ³ Autor ³ Geraldo Felix Junior   ³ Data ³ 24.11.00 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio gerencial de provisionamento por plano.          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ CRJR0002                                                   ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial                               ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function CRJR002A()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variavaoeis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cPerg       := padr("CRJR002A",10)
PRIVATE nQtdLin 	:= 58
PRIVATE cNomeProg   := "CRJR002a"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio Gerencial de Provisionamento por Plano"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""                         
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "BA3"

PRIVATE cRel        := "CRJR002a"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 } 
PRIVATE lAbortPrint := .F.                                                                       
PRIVATE aOrdens     := { "Codigo do plano" } 
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.
Private cOpe

cCabec1 := "Plano                                         Contr.        Opcionais        Tx Adesao          Debitos         Creditos     Participacao           Tarifa         Farmacia  Guia Medico       Cartão            Total"

/*      
		 10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Plano                                         Contr.        Opcionais        Tx Adesao          Debitos         Creditos     Participacao           Tarifa         Farmacia  Guia Medico       Cartão            Total
9999-999999999999999999999999999999   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999,999.99

*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1(cPerg) 
Pergunte(cPerg,.F.) 

cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey  == 27
   Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe parametros                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
           

cOpe     := mv_par01
_cMes    := mv_par02
_cAno    := mv_par03
_cMesAte := mv_par04
_cAnoAte := mv_par05



nTipCon  := mv_par06
cGrupIni := mv_par07
cGrupFim := mv_par08
cContDe  := mv_par09
cContAte := mv_par10                              
cSubConI := mv_par11
cSubConF := mv_par12
cGrpCIni := mv_par13
cGrpCFin := mv_par14
cCodPlaI := mv_par15
cCodPlaF := mv_par16 
nFazXls  := mv_par17 
cNTraz   := mv_par18 
cMostLanc:= mv_par19
               
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta novo nome do titulo do relatorio mostrando mes/ano                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(_cMes)) + "/" + _cAno

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura Impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta RptStatus...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Proc2BarGauge({|| aCriticas := RJ002Imp()() }  , "Imprimindo...") 
                                                                              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina Principal...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ RJ001Imp³ Autor ³ Geraldo Felix Junior   ³ Data ³ 04.11.07 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio de contratos.                                    ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function RJ002Imp()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do IndRegua...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL i
LOCAL n
LOCAL nTotMen 	:= 0
LOCAL nTotOpc 	:= 0
LOCAL nTotAde 	:= 0
LOCAL nTotDeb 	:= 0
LOCAL nTotCre 	:= 0
LOCAL nTotPar 	:= 0
LOCAL nTotTar	:= 0
LOCAL nTotPla	:= 0
LOCAL nTotFar	:= 0     
LOCAL  total	:= 0
LOCAL nTotal	:= 0
LOCAL pMoeda1	:= "@E 999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL nPos		:= 0
LOCAL nPosTit	:= 0 
LOCAL nPosTitU	:= 0   
LOCAL aTitXls   := {"Mat.Usuario ","Seq.","Digito","Cod.Plano","Nome Usuario ","Dt. Nasc.","Dt. Inclu.","Cpf    ", "Mensalidade ","Qtda Dep.","Vl.Acres. Mens","Vl. Desc. Mens",;
                    "Co-Participação",  "Vl. Total", "Vl. Mora", "Dt. Venc.", "Dt. Geração", "Vl. Pago", "Dt. Pagto","Mat.Usuario ", "Titulo"}
LOCAL aTitulo 	:= {}
LOCAL aPlanos 	:= {}
LOCAL aPlaUsr	:= {}  
local aTipLan   := {}
LOCAL nPosPla	:= 0
LOCAL _cCodPla	:= ''
LOCAL _cVerPla 	:= ''
LOCAL nTotLinha := 0
LOCAL nTotGeral := 0
LOCAL nTotGui := 0
LOCAL nTotCar := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe mensagem informativa...                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IncProcG1("Aguarde. Buscando dados no servidor...")
ProcessMessage()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores por Empresa...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTotCobEmp := 0
PRIVATE nTotRegEmp := 0
Private aQtdusrEmp := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores por Contrato...                                            ³                                                     
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTotCobCon := 0
PRIVATE nTotRegCon := 0
Private aQtdusrCon := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores por SubContrato...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTotCobSub := 0
PRIVATE nTotRegSub := 0
PRIVATE nVlrCob    := 0
Private aQtdusrSub := 0 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Expressao de filtro...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO, BA1_NOMUSR, BM1_CODTIP, BM1_DESTIP, "
cSql +=	"BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BA1_CODPLA,ba1_datnas, ba1_datinc,ba1_cpfusr,"
cSql += "BM1_CODPLA, BM1_DESPLA, BM1_VERPLA, BA1_VERSAO, BM1_AGFTFU "
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
//cSql += "AND BM1.BM1_ANO = '"+ _cAno +"' "
//cSql += "AND BM1.BM1_MES = '"+ _cMes +"' "   
cSql += "AND (BM1.BM1_ANO||BM1.BM1_MES >= '"+ _cAno+_cMes +"' "
cSql += "AND  BM1.BM1_ANO||BM1.BM1_MES <= '"+ _cAnoAte+_cMesAte +"') "   


//cSql += "AND  BM1.BM1_MATRIC = '012149'"   
//cSql += "AND BM1.BM1_NUMTIT  = '758450   '  "  //Comentar Gedilson
if !empty (cNTraz)
   cSql += "AND BM1.BM1_PREFIX  NOT IN ( "+ cNTraz +" ) " //  //Comentar Gedilson
endIf
cSql += "AND BM1.D_E_L_E_T_ = ' ' "
cSql += "AND BA1.D_E_L_E_T_ = ' ' "
cSql += "AND BA1_CODINT = BM1.BM1_CODINT "
cSql += "AND BA1_CODEMP = BM1.BM1_CODEMP "
cSql += "AND BA1_MATRIC = BM1.BM1_MATRIC "
cSql += "AND BA1_TIPREG = BM1.BM1_TIPREG "
cSql += "AND BA1_DIGITO = BM1.BM1_DIGITO "
cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "

PlsQuery(cSql, "TRB")

nQtd:=1
TRB->(DBEval( { | | nQtd ++ }))
BarGauge1Set(nQtd)               

TRB->(DbGoTop())

BFQ->(DbSetOrder(1))
BI3->(dbSetorder(1))
SE1->(dbSetorder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define matriz de planos...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aPlanos := {}        
aTitulo := {}

While ! TRB->(Eof())
	
	cFam := TRB->( BM1_CODINT + BM1_CODEMP + BM1_MATRIC )
	aPlaUsr := {}         
		
	While !TRB->( Eof() ) .and. TRB->( BM1_CODINT + BM1_CODEMP + BM1_MATRIC ) == cFam
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apresenta mensagem em tela...                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProcG1("Familia ["+TRB->BM1_CODINT+"."+TRB->BM1_CODEMP+"."+TRB->BM1_MATRIC+"]")
		ProcessMessage()

	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona a familia do usuario                                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) <> BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			BA3->( MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)) )
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se titulo existe, para ignorar os casos com desconto em folha que nao gera o titulo
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !SE1->( dbSeek(xFilial("SE1")+TRB->(BM1_PREFIX + BM1_NUMTIT + BM1_PARCEL + BM1_TIPTIT)) )
			TRB->( dbSkip() )
			Loop
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define qual o plano do usuario...                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se pode considerar o plano, de acordo com parametros...   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  _cCodPla < cCodPlaI .or. ;
			_cCodPla > cCodPlaF
			TRB->(DbSkip())
			Loop
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi abortada a impressao...                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Interrupcao(lAbortPrint)
			Exit
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Constroi matriz com os planos que serao impressos.                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (nPos := Ascan(aPlanos, {|x| x[1] == _cCodPla} )) == 0
			BI3->( MsSeek(xFilial("BA3")+BA3->BA3_CODINT+_cCodPla) )
			
			Aadd(aPlanos, {	_cCodPla,;		// 01 Plano
			_cVerPla,;			            // 02 Versao do plano
			0,; 			            	// 03 Mensalidades
			0,;					            // 04 Debitos
			0,;					            // 05 Creditos
			0,;					            // 06 Opcionais
			0,;					            // 07 Taxa de adesao
			0,;					            // 08 Co-participacao
			0,;				 	            // 09 Tarifa
			0,;					            // 10 Farmacia
			{},;				            // 11 Titulos a receber que compoem o total.
			BI3->BI3_DESCRI,;	            // 12 Descricao do plano
			0,;					            // 13 Guia medico
			0})					            // 14 Cartao do usuario
			nPos := Len(aPlanos)
		Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Constroi matriz com os Titulos que serao exportados para p XLS     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (nPosTitU := Ascan(aTitulo, {|x| x[1] == cFam} )) == 0
		BI3->( MsSeek(xFilial("BA3")+BA3->BA3_CODINT+_cCodPla) )
        cdatan:= (substr (dtos(trb->ba1_datnas),7,2)+"/"+substr (dtos(trb->ba1_datnas),5,2)+"/"+substr (dtos(trb->ba1_datnas),1,4))	
        cdatai:= (substr (dtos(trb->ba1_datinc),7,2)+"/"+substr (dtos(trb->ba1_datinc),5,2)+"/"+substr (dtos(trb->ba1_datinc),1,4))	
		Aadd(aTitulo,{ cFam , ;		// 01 Maticula do ususario 
		     trb->bm1_tipreg, ;     // 02 dependente 
		     trb->bm1_digito, ;     // 03 digito 
		     _cCodPla +"-"+BI3->BI3_DESCRI , ;		// 04 Cod do Plano   
		     trb->ba1_nomusr, ;     // 05 Nome Usuario 
		     trb->ba1_datnas,;               // 06 Dt Nasc     
		     trb->ba1_datinc,;               // 07 Dt Nasc        
		     trb->ba1_cpfusr ,; 	// 08 CPF Usuario    
		     0,;					// 09 Valor contra prestação (Mensalidade)
   			 0,;					// 10 qtda Dependentes 
			 0,;		            // 11 Debitos
			 0,;		            // 12 Creditos
			 0,;				    // 13 Co-participacao
			 0,; 				    // 14 Vl Total 
    		 0,; 				    // 15 Vl Mora 
    		 se1->e1_vencrea,;      // 16 Dt vencimento
    		 se1->e1_emissao,;      // 17 Dt Geração 
    		 0,;                    // 18 Vl Pago
			 " ",;				    // 19 Dt Pagamento 
			 cFam + trb->bm1_tipreg + trb->bm1_digito,; // 20 matricula completa  Pagamento  
			 TRB->(BM1_PREFIX + BM1_NUMTIT + BM1_PARCEL + BM1_TIPTIT),;			    // 21 Dt Pagamento  
			 0}) //FARMACIA MARCOS ALVES 01/03/11 - ALTAMIRO	
			nPosTitU := Len(aTitulo)
		Endif 
		
	     If trb->bm1_tipreg <> "00"
	        aTitulo[nPosTitU, 10] +=  1  
	     else       
	        If ! empty (se1->e1_baixa) 
	           aTitulo[nPosTitU, 18]:= (se1->e1_valor - se1->E1_SALDO)
	           aTitulo[nPosTitU, 19]:= se1->e1_baixa
	        EndIf   
	        //aTitulo[nPosTitU, 11] +=  SE1->E1_DECRESC                        
	        aTitulo[nPosTitU, 10] :=  0   
	     EndIf                       
	     
		If TRB->BM1_CODTIP $ '101, 118'		// Mensalidade
			aPlanos[nPos, 03] += TRB->BM1_VALOR
			atitulo[nPosTitU, 09] += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP $ '102,133'	// Opcionais
			aPlanos[nPos, 06] += TRB->BM1_VALOR      
			atitulo[nPosTitU, 11] += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP == '103'		// Taxa de adesao
			aPlanos[nPos, 07] += TRB->BM1_VALOR
			atitulo[nPosTitU, 11] += TRB->BM1_VALOR
						
		Elseif TRB->BM1_CODTIP $ cCodigosPF	// Co-participacoes...
			aPlanos[nPos, 08] += TRB->BM1_VALOR
			atitulo[nPosTitU, 13] += TRB->BM1_VALOR
			                                           
		Elseif TRB->BM1_CODTIP == '909'		// Guia medico
			aPlanos[nPos, 13] += TRB->BM1_VALOR			
			atitulo[nPosTitU, 11] += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP $ '107, 908'	// Cartao de identificaçao
			aPlanos[nPos, 14] += TRB->BM1_VALOR
			atitulo[nPosTitU, 11] += TRB->BM1_VALOR
						
		Elseif Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")	// Farmacia
			aPlanos[nPos, 10] += TRB->BM1_VALOR
			atitulo[nPosTitU, 11] += TRB->BM1_VALOR  
			atitulo[nPosTitU, 22] += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP $ cCodDB		// Debitos / creditos...
			If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
				If BFQ->BFQ_DEBCRE == '2' 	// Credito.
					aPlanos[nPos, 05] += TRB->BM1_VALOR
					
        			atitulo[nPosTitU, 12] += TRB->BM1_VALOR
					atitulo[nPosTitU, 14] -= TRB->BM1_VALOR 					 
                    atitulo[nPosTitU, 14] -= TRB->BM1_VALOR 
                    
				Elseif BFQ->BFQ_DEBCRE == '1' // Debitos.
					aPlanos[nPos, 04] += TRB->BM1_VALOR
					atitulo[nPosTitU, 11] += TRB->BM1_VALOR

				Endif
			Endif
		Endif  
		If ((TRB->BM1_CODTIP $ '101 , 103 , 107 , 118 , 102 , 133 , 909 , 908') .or.;
		   (Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998"))           .or.;
		   (TRB->BM1_CODTIP $ cCodDB) .or. (TRB->BM1_CODTIP $ cCodigosPF))             
		 
	       atitulo[nPosTitU, 14] += TRB->BM1_VALOR 
	    EndIf
	       
		// Adiciona os titulos que cobraram os planos...
		If ( nPosTit := Ascan(aPlanos[nPos, 11], TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)) ) == 0
			
			Aadd(aPlanos[nPos, 11], TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT))
			
		Endif   
		
		 If TRB->BM1_CODTIP <> '  ' .and. cMostLanc = 1                                  
	       If (nPos := Ascan(aTipLan, {|x| x[1] == TRB->BM1_CODTIP} )) == 0
		       Aadd(aTipLan, {TRB->BM1_CODTIP,;	
                              TRB->BM1_DESTIP ,;
                              TRB->BM1_VALOR})		
           Else 
               aTipLan[nPos, 3] += TRB->BM1_VALOR                    
   		   Endif                            
   		   
   		EndIf   
		
		TRB->(DbSkip())
	Enddo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim do laco...                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Enddo 
if nFazXls = 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera excel                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DlgToExcel({{"ARRAY","Gravações da Filial" , aTitXls  ,atitulo}})           
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ		        
EndIf
/* 

		 10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Plano                                         Contr.        Opcionais        Tx Adesao          Debitos         Creditos     Participacao           Tarifa         Farmacia  Guia Medico       Cartão            Total
9999-999999999999999999999999999999   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999,999.99
*/  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa impressao                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Asort(aPlanos,,, {|x, y| x[1] < y[1]})
nLi := 1000
For i := 1 To Len(aPlanos)
	
	// Controle de saldo de pagina...
	If  nli > nQtdLin
    	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)                                  
	    nli++               	
	Endif

	nTotLinha := 0
	@ nLi, 000 Psay aPlanos[i, 01] + ' - ' + Substr(aPlanos[i, 12], 1, 30)
    @ nLi, 038 Psay Transform(aPlanos[i, 03], pMoeda2); nTotMen += aPlanos[i, 03]; nTotLinha += aPlanos[i, 03]
    @ nLi, 055 Psay Transform(aPlanos[i, 06], pMoeda2); nTotOpc += aPlanos[i, 06]; nTotLinha += aPlanos[i, 06]
    @ nLi, 072 Psay Transform(aPlanos[i, 07], pMoeda2); nTotAde += aPlanos[i, 07]; nTotLinha += aPlanos[i, 07]
    @ nLi, 089 Psay Transform(aPlanos[i, 04], pMoeda2); nTotDeb += aPlanos[i, 04]; nTotLinha += aPlanos[i, 04]
    @ nLi, 106 Psay Transform(aPlanos[i, 05], pMoeda2); nTotCre += aPlanos[i, 05]; nTotLinha -= aPlanos[i, 05]
    @ nLi, 123 Psay Transform(aPlanos[i, 08], pMoeda2); nTotPar += aPlanos[i, 08]; nTotLinha += aPlanos[i, 08]
    
    // Obtem o valor das tarifas...
    nTarifa := 0
    For n := 1 to Len(aPlanos[i, 11])
    	If SE1->( MsSeek(xFilial("SE1")+aPlanos[i, 11, n]) )
	   		nTarifa += SE1->E1_DECRESC
	   	Endif
	Next
	   		
	@ nLi, 140 Psay Transform(nTarifa		 , pMoeda2); nTotTar += nTarifa; nTotLinha += nTarifa
 	@ nLi, 157 Psay Transform(aPlanos[i, 10], pMoeda2); nTotFar += aPlanos[i, 10]; nTotLinha += aPlanos[i, 10]
 	
 	@ nLi, 175 Psay Transform(aPlanos[i, 13], pMoeda1); nTotGui += aPlanos[i, 13]; nTotLinha += aPlanos[i, 13]
 	@ nLi, 188 Psay Transform(aPlanos[i, 14], pMoeda1); nTotCar += aPlanos[i, 14]; nTotLinha += aPlanos[i, 14]
 	
 	@ nLi, 201 Psay Transform(nTotLinha		 , pMoeda2); nTotGeral += nTotLinha
 	                                   
 	nLi++
Next

// Imprime os totais gerais
If  nli > nQtdLin
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nli++
Endif

@ nLi, 000 Psay Replicate('-', nLimite)
nLi++

@ nLi, 000 Psay "Totais"
@ nLi, 038 Psay Transform(nTotMen, pMoeda2)
@ nLi, 055 Psay Transform(nTotOpc, pMoeda2)
@ nLi, 072 Psay Transform(nTotAde, pMoeda2)
@ nLi, 089 Psay Transform(nTotDeb, pMoeda2)
@ nLi, 106 Psay Transform(nTotCre, pMoeda2)
@ nLi, 123 Psay Transform(nTotPar, pMoeda2)
@ nLi, 140 Psay Transform(nTotTar, pMoeda2)
@ nLi, 157 Psay Transform(nTotFar, pMoeda2)
@ nLi, 175 Psay Transform(nTotGui, pMoeda1)
@ nLi, 188 Psay Transform(nTotCar, pMoeda1)
@ nLi, 201 Psay Transform(nTotGeral, pMoeda2)


i := 1                          
nLi++                                        
@ nLi, 000 Psay Replicate('-', nLimite)
nLi++
If cMostLanc = 1                                  
while i <= len(aTipLan)                      
   @ nLi, 038 Psay aTipLan[i,1]  
   @ nLi, 055 Psay aTipLan[i,2] 
   @ nLi, 110 Psay Transform(aTipLan[i,3], pMoeda2) 
   total +=aTipLan[i,3]
   nLi++
   i ++ 
EndDo                                  
nLi++                                        
@ nLi, 000 Psay Replicate('-', nLimite)   
  nLi++           
@ nLi, 055 Psay ' Total ---- > ' 
@ nLi, 110 Psay Transform(total , pMoeda2) 
nLi++                                        
@ nLi, 000 Psay Replicate('-', nLimite)
EndIf                                    
 nLi++           
@ nLi, 001 Psay ' * Por haver a hipótese de mais de um plano por títulos e ser possível baixa parcial destes títulos, NÃO podemos Garantir a fidelidade do campo Total Recebido' 
nLi++                                        
@ nLi, 000 Psay Replicate('-', nLimite)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodape...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,Space(10))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha area de trabalho...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRB->( dbClosearea() )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
    Set Printer To
    Ourspool(crel)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da impressao do relatorio...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Angelo Sperandio     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CriaSX1(cPerg)

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Operadora ?                 ","","","mv_ch1","C", 4,0,0,"G",""           ,"mv_par01",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Mes De ?                    ","","","mv_ch2","C", 2,0,0,"G","PlsVldMes()","mv_par02",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"03","Ano De?                     ","","","mv_ch3","C", 4,0,0,"G",""           ,"mv_par03",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"04","Mes Ate?                    ","","","mv_ch2","C", 2,0,0,"G","PlsVldMes()","mv_par04",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"05","Ano Ate?                    ","","","mv_ch3","C", 4,0,0,"G",""           ,"mv_par05",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","","",""})

aadd(aRegs,{cPerg,"06","Tipo contrato ?               ","","","mv_ch4","N", 1,0,0,"C",""           ,"mv_par06","Fisica"      	,"","","","","Juridica"       	,"","","","","Ambas"         ,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"07","Grupo/empresa de ?            ","","","mv_ch5","C", 4,0,0,"G",""           ,"mv_par07",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"08","Grupo/empresa ate ?           ","","","mv_ch6","C", 4,0,0,"G",""           ,"mv_par08",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7APLS","B7A"),""})
aadd(aRegs,{cPerg,"09","Contrato de ?                 ","","","mv_ch7","C",12,0,0,"G",""           ,"mv_par09",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7BPLS","B7B"),""})
aadd(aRegs,{cPerg,"10","Contrato ate ?                ","","","mv_ch8","C",12,0,0,"G",""           ,"mv_par10",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7BPLS","B7B"),""})
aadd(aRegs,{cPerg,"11","Subcontrato de ?              ","","","mv_ch9","C", 9,0,0,"G",""           ,"mv_par11",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7CPLS","B7C"),""})
aadd(aRegs,{cPerg,"12","Subcontrato ate ?             ","","","mv_cha","C", 9,0,0,"G",""           ,"mv_par12",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B7CPLS","B7C"),""})
aadd(aRegs,{cPerg,"13","Grupo cobranca de ?           ","","","mv_chb","C", 4,0,0,"G",""           ,"mv_par13",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BR0PLS","BR0"),""})
aadd(aRegs,{cPerg,"14","Grupo cobranca ate ?          ","","","mv_chc","C", 4,0,0,"G",""           ,"mv_par14",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"BR0PLS","BR0"),""})
aadd(aRegs,{cPerg,"15","Produto de                    ","","","mv_chd","C", 4,0,0,"G",""           ,"mv_par15",""         		,"","","","",""            		,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"16","Produto ate                   ","","","mv_che","C", 4,0,0,"G",""           ,"mv_par16",""         		,"","","","",""            		,"","","","",""              ,"","","","",""       ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"17","Gera Excel ?                  ","","","mv_chf","C", 4,0,1,"C",""           ,"mv_par17","Sim"      		,"","","","","Nao"            	,"","","","",""              ,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"18","Tipo Ha NÃO Sair :            ","","","mv_chg","C",20,0,0,"G",""           ,"mv_par18",""            	,"","","","",""               	,"","","","",""              ,"","","","",""       ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"19","Mostra componentes lancamento?","","","mv_chh","C", 1,0,1,"C",""           ,"mv_par19","Sim"      		,"","","","","Nao"            	,"","","","",""              ,"","","","",""       ,"","","","","","","","","",""})

PlsVldPerg( aRegs )
  
Return