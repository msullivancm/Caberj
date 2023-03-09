#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#include "topconn.ch"
#include "SIGAWIN.CH"
/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ATENCAO - MANUTENCAO NESTE FONTES DEVERAR SER ESPELHADA NO FONTES CABA101 - QUE ATENDE A SEDE       ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ CABA083  ³ Autor ³ Jose Carlos Noronha   ³ Data ³ 09/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Manutencao de Titulos do PLS - Digitacao da NF             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³ Alterações ³ Edilson Leal: 04/01/08                                   ³±±
±±³-Critica entre valor total das notas e valor do titulo.                ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA101a

Private cTipoMov := ""
Private lCmp := .F.  
Private lSair1 := .F.
Private lFlagVaz := .T.
aRotina :=  {{ "Pesquisar"    , "AxPesqui   "  , 0 , 1},;
{ "Visualizar"   , "U_FMOB021()"  , 0 , 2},;
{ "Digitar Nota" , "U_FMOBal()"  , 0 , 3},;
{ "Excluir Nota" , "U_FMOB023()"  , 0 , 2},;
{ "Relatorio"    , "U_CABR084()"  , 0 , 2},;
{ "Compensar"    , "U_CABR085()"  , 0 , 2}}

cCadastro := "Digitacao da Nota Fiscal - RDA"

DBSelectArea("SZB")
DBSetOrder(1)

DbGotop()

MBrowse(06,01,22,75,"SZB")

Return()

************************
Static Function FMOB021()
************************
lSair1:=.F.
cTipoMov := "011"

MontaTela(cTipoMov)

Return()


// Inclusao
************************
//Static Function FMOB022()
user Function FMOBal()
************************
lSair1:=.F.
cTipoMov := "012"
Do While !lSair1
   lSair1:=.T.
   MontaTela(cTipoMov) 
Enddo

Return()

// Excluir
************************
Static Function FMOB023()
************************
lSair1:=.F.
cTipoMov := "013"

MontaTela(cTipoMov)

Return()

************************
Static Function CABR085()
************************

cTipoMov := "014"

MontaTela(cTipoMov)

Return()


***********************************
Static Function VldAcols()             // Criticar os Produtos Informados Como Referencia
***********************************    // Verificar se os Saldos do Alm 02 podem cobrir

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

lRetorna := .t.
_nTotDig := 0

For i:= 1 to Len(aCols)
	
	If _nVLBruto = 0
		Alert("Não Foram Encontrados Titulos no Financeiro Para Este RDA.")
		Return(.f.)
	Endif
	
	If Empty(aCols[i,1]) .And. aCols[i,len(aHeader)+1] = .F.
		Return(.f.)
	EndIf
	If Empty(aCols[i,2]) .And. aCols[i,len(aHeader)+1] = .F.
		Return(.f.)
	EndIf
	If Empty(aCols[i,3]) .And. aCols[i,len(aHeader)+1] = .F.
		Return(.f.)
	EndIf
	obj1:Refresh()
Next

Return(lRetorna)


//*************************************************************************
Static Function MontaTela(cTipoMov)
//*************************************************************************
Private _oDlg
// Variaveis que definem a Acao do Formulario
Private VISUAL      := .F.
Private INCLUI      := .F.
Private ALTERA      := .F.
Private DELETA      := .F.
Private _nVLBruto   := 0
Private _nVLInform  := 0
Private _nINSS      := 0
Private _nIRF       := 0
Private _nDecres    := 0
Private _nISS       := 0
Private _nSEST      := 0
Private _nAcres     := 0
Private _nPIS       := 0
Private _nMulta     := 0
Private _nCOFINS    := 0
Private _nLiquid    := 0
Private _nCSLL      := 0
Private cMesAno     := "  /    "
Private _cTitulo    := SPACE(6)
Private lSair       := .F.
Private _cGruPag    := space(4)
Private _cCabGrp    := ""
Private _cTipo      := ""
Private _cParc      := ""
Private _cFornec    := ""
Private _cLoja      := ""
Private _cPref      := ""
Private _cFormDt    := ""
Private oDtMesAno
Private lLibNF       := .F.
Private _nAdiant     := 0
Private lConsRDA     := .F.
Private f_ok         := .T.
Private aVetBx       := {}
Private oDlg2        := Nil
Private nVlCOmpensar := 0
Private xFornece     := " "
private _nVlDpj      :=0
aHeader := {}

DbSelectArea("SZB")

DbSelectArea("SX3")
SX3->(DbSetOrder(1))
SX3->(dbSeek("SZB"))
_Recno := Recno()
Do While !Eof() .And. (X3_ARQUIVO == "SZB")
	If X3_CAMPO = "ZB_NOTA" .or. X3_CAMPO = "ZB_EMISSAO" .or. X3_CAMPO = "ZB_VTOTAL" .or. X3_CAMPO = "ZB_OBS"
		Aadd(aHeader,{Trim(X3_TITULO), X3_CAMPO, X3_PICTURE, X3_TAMANHO, X3_DECIMAL,".T.", X3_USADO, X3_TIPO, X3_ARQUIVO, X3_CONTEXT})
	Endif
	dbSkip()
Enddo
DbGoto(_Recno)

AADD(aHeader,{ "", x3_campo, "",x3_tamanho, x3_decimal,".F.",x3_usado, x3_tipo, x3_arquivo, x3_context } )

dDataAux                := CTOD("  /  /  ")
aCOLS                   := {}
aCols                   := Array(1,Len(aHeader)+1)
aCOLS[1][1]             := SPACE(6)     // NF
aCOLS[1][2]             := dDataAux     // DATA EMISSAO
aCOLS[1][3]             := 0            // VALOR TOTAL
aCOLS[1][4]             := SPACE(150)   // OBSERVACAO
aCols[1,len(aHeader)+1] := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Tela de Entrada dos Dados                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cMesAno    := "  /    "
_cCodRDA   := SPACE(6)
_cNome_RDA := SPACE(40)
fMonta     := .T.
_cFormDt   := "Formato: MM/AAAA"

// 13/08/2007                       // 14/08/07
If cTipoMov $ "011|013|014" // Visualizar/Exlcluir
	cMesAno    := Substr(SZB->ZB_ANOMES,5,2)+"/"+Substr(SZB->ZB_ANOMES,1,4)
	_cCodRDA   := SZB->ZB_CODRDA
	_cPref     := SZB->ZB_PREFIXO
	_cTitulo   := SZB->ZB_TITULO
	_cParc	  := SZB->ZB_PARCELA
	_cTipo	  := SZB->ZB_TIPO
	_cFornec   := SZB->ZB_FORNECE
	_cLoja     := SZB->ZB_LOJA
	_nVLBruto  := SZB->ZB_VBRUTO
	_nVLInform := SZB->ZB_VINFORM
	_nVlDpj    := fbuscaVlDpj(xFilial("SE2"),_cTitulo,_cTipo,_cFornec,_cLoja) 
		
	i          := 0
	
	dbselectarea("SZB")
	dbsetorder(4)
	dbseek(xFilial("SZB")+Substr(cMesAno,4,4)+Left(cMesAno,2)+_cCodRDA+_cPref+_cTitulo)
	Do While !Eof() .and. xFilial("SZB")+Substr(cMesAno,4,4)+Left(cMesAno,2)+_cCodRDA+_cPref+_cTitulo = ;
		SZB->ZB_FILIAL+SZB->ZB_ANOMES+SZB->ZB_CODRDA+SZB->ZB_PREFIXO+SZB->ZB_TITULO
		i++
		dbskip()
	Enddo
	aCols := Array(i,5)
	i     := 1
	dbseek(xFilial("SZB")+Substr(cMesAno,4,4)+Left(cMesAno,2)+_cCodRDA+_cPref+_cTitulo)
	Do While !Eof() .and. xFilial("SZB")+Substr(cMesAno,4,4)+Left(cMesAno,2)+_cCodRDA+_cPref+_cTitulo = ;
		SZB->ZB_FILIAL+SZB->ZB_ANOMES+SZB->ZB_CODRDA+SZB->ZB_PREFIXO+SZB->ZB_TITULO
		If i>Len(aCols)
			Exit
		Endif
		aCols[i][1] := SZB->ZB_NOTA
		aCols[i][2]	:=	SZB->ZB_EMISSAO
		aCols[i][3]	:=	SZB->ZB_VTOTAL
		aCols[i][4]	:=	SZB->ZB_OBS
		i++
		dbskip()
	Enddo
	
	dbsetorder(1)
	dbselectarea("SE2")
	dbsetorder(1)
	dbseek(xFilial("SE2")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
	If Found()
		_nINSS     := SE2->E2_INSS
		_nIRF      := SE2->E2_IRRF
		_nDecres   := SE2->E2_DECRESC
		_nISS      := SE2->E2_ISS
		_nSEST     := SE2->E2_SEST
		_nAcres    := SE2->E2_ACRESC
		_nMulta    := SE2->E2_MULTA
		_nPIS      := SE2->E2_VRETPIS
		_nCOFINS   := SE2->E2_VRETCOF
		_nCSLL     := SE2->E2_VRETCSL
		_cFormDt   := ""
		_nLiquid   := _nVLBruto - _nIRF - _nINSS - _nSEST - _nPIS - _nCOFINS - _nCSLL - _nISS 
		_nLiquid   := _nLiquid - _nDecres + _nAcres - _nMulta
	
		// Buscar Adiantamentos
		dbSelectArea("SE5")
		dbsetorder(7)
		dbseek(xFilial("SE5")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
		Do While !EOF() .and. xFilial("SE5")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja = ;
			E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_FORNECE+E5_LOJA
			If ALLTRIM(E5_TIPODOC) = "CP"
				_nAdiant  := SE5->E5_VALOR
			Else
				If ALLTRIM(E5_TIPODOC) = "ES"
					_nAdiant  := 0
				Endif
			Endif
			dbskip()
		Enddo
		dbsetorder(1)
	Endif
Endif

// DEFINE MSDIALOG _oDlg TITLE " Digitacao da Nota Fiscal - RDA - Revisão 29/11/2007" FROM C(178),C(181) TO C(620),(965) OF _oDlg PIXEL STYLE DS_MODALFRAME STATUS
DEFINE MSDIALOG _oDlg TITLE " Digitacao da Nota Fiscal - RDA - Revisão 29/11/2007" FROM C(178),C(181) TO C(620),(1100) OF _oDlg PIXEL STYLE DS_MODALFRAME STATUS

//DEFINE MSDIALOG _oDlg TITLE " Digitacao da Nota Fiscal - RDA - Revisão 29/11/2007" FROM C(178),C(181) TO C(610),C(935) PIXEL
//178 181 593 833
// Cria as Groups do Sistema
@ C(005),C(001) TO C(059),C(330) LABEL "RDA" PIXEL OF _oDlg
@ C(060),C(001) TO C(140),C(225) LABEL "Dados Pagamento" PIXEL OF _oDlg //129
@ C(060),C(230) TO C(140),C(330) LABEL "Impostos" PIXEL OF _oDlg
//128                //140
// Cria Componentes Padroes do Sistema
If cTipoMov $ "011|013|014" // Visualizar/Exlcluir/compensar
	lVisual := fValRDA(_cCodRDA,_oDlg)
	@ C(012),C(037) MsGet cMesAno WHEN .F. Picture "99/9999" Size 20,12 COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(026),C(036) MsGet _cCodRDA WHEN .F. Size C(040),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
Else
	@ C(012),C(037) MsGet oDtMesAno Var cMesAno Picture "99/9999" Valid(fValMesAno(cMesAno))Size 20,12 COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(026),C(036) MsGet _cCodRDA Valid(fValRDA(_cCodRDA,_cFornec,_oDlg)) Size C(040),C(009) F3 "BAUNFE" COLOR CLR_BLACK PIXEL OF _oDlg
Endif
@ C(014),C(005) Say   "Mes/Ano" Size C(024),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(014),C(067) Say   _cFormDt   Size C(054),C(008) COLOR CLR_BLUE PIXEL OF _oDlg
@ C(027),C(006) Say   "Prestador" Size C(024),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(027),C(081) Say   _cNome_RDA COLOR CLR_BLUE PIXEL OF _oDlg
@ C(027),C(220) Say   "Grupo"   Size C(024),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(025),C(240) MsGet _cCabGrp   WHEN .F. Size C(080),C(009) COLOR CLR_BLACK PIXEL OF _oDlg

//---- altamiro - 15/07/09 - orientacao do antonio do financeiro , NAO SOMAR O VALOR DO DPJ NO VALOR DO TITULO 
// documentado por email nesta data.

//@ C(039),C(150) MsGet Round(_nVLBruto+_nVlDpj,2)  WHEN .F. Size C(059),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg  
@ C(039),C(150) MsGet round (_nVLBruto,2)  WHEN .F. Size C(059),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(041),C(048) MsGet _nVLInform WHEN .F. Size C(053),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(041),C(120) Say   "Valor Bruto"  Size C(028),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(043),C(007) Say   "Valor Informado" Size C(039),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(039),C(240) MsGet _cTitulo  WHEN .F.  Size C(030),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(040),C(220) Say   "Titulo" Size C(015),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(069),C(264) MsGet _nIRF     WHEN .F. Size C(054),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(071),C(043) MsGet _nDecres  WHEN .F. Size C(060),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(071),C(234) Say   "IRRF"    Size C(014),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(071),C(007) Say   "Decrescimo"    Size C(030),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(071),C(110) Say   "Adiant. a Compensar" Size C(050),C(008) COLOR CLR_BLACK PIXEL OF _oDlg 
if ((!empty (_cCodRDA)) .or. lFlagVaz = .T.)
   @ C(071),C(156) MsGet  CargaVetor(.F.)  WHEN .F. Size C(060),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg   
EndIf   
@ C(084),C(110) Say   "Saldo a Pagar" Size C(050),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(084),C(156) MsGet  Round(_nLiquid - _nAdiant ,2)  WHEN .F. Size C(060),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg

@ C(097),C(110) Say   "Deposito Judicial" Size C(050),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(097),C(156) MsGet  _nVlDpj   WHEN .F. Size C(060),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
	
@ C(081),C(264) MsGet _nISS  WHEN .F. Size C(054),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
//@ C(081),C(264) MsGet _nSEST WHEN .F. Size C(054),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(082),C(234) Say   "ISS"  Size C(010),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
//@ C(082),C(235) Say   "SEST" Size C(016),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(084),C(007) Say   "Acrescimo" Size C(026),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(084),C(043) MsGet _nAcres WHEN .F. Size C(060),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(093),C(234) Say   "PIS"    Size C(010),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(093),C(264) MsGet _nPIS    WHEN .F. Size C(054),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(096),C(007) Say   "Multa"  Size C(015),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(097),C(043) MsGet _nMulta  WHEN .F. Size C(060),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(105),C(234) Say   "COFINS" Size C(021),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(105),C(264) MsGet _nCOFINS WHEN .F. Size C(054),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(110),C(043) MsGet _nLiquid WHEN .F. Size C(060),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(111),C(007) Say   "Liquido" Size C(019),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(117),C(264) MsGet _nCSLL    WHEN .F. Size C(054),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg
@ C(118),C(234) Say   "CSLL"    Size C(015),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

@ C(129),C(234) Say   "INSS"    Size C(014),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(128),C(264) MsGet _nINSS    WHEN .F. Size C(054),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg

@ C(126),C(007) Say   "Vl.Compensado" Size C(035),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(122),C(043) MsGet _nAdiant  WHEN .F. Size C(060),C(009) COLOR CLR_BLACK picture "@E 999,999,999.99" PIXEL OF _oDlg

If cTipoMov == "012"   // Inclusao
	
	@ 180,001 TO 260,430 MULTILINE MODIFY DELETE VALID VldAcols() object obj1
  fMonta := .T.
	
ElseIf cTipoMov $ "011|013|014" // Visualizar/Exlcluir
	@ 180,001 TO 260,430 MULTILINE object obj1
Endif

if fMonta
  //	@ 070,385 Button OemToAnsi("Sair") Size 40,13 Action Fecha_dlg1()
	//ACTIVATE MSDIALOG _oDlg CENTERED
   ACTIVATE MSDIALOG _oDlg CENTER ON INIT MyEnchoBar(_oDlg,{||Iif(MsgYesNo("Deseja sair ?","Confirmação"),_oDlg:End(),.F.)})
Endif

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cancelar Digitacao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Canc_Dlg1

// Limpar Variaveis
_nVLBruto  := 0
_nVLInform := 0
_nINSS     := 0
_nIRF      := 0
_nDecres   := 0
_nISS      := 0
_nSEST     := 0
_nAcres    := 0
_nPIS      := 0
_nMulta    := 0
_nCOFINS   := 0
_nLiquid   := 0
_nCSLL     := 0
_cTitulo   := SPACE(6)
_cGruPag   := space(4)
_cCabGrp   := ""
_cTipo     := ""
_cParc     := ""
_cFornec   := ""
_cLoja     := ""
_cCodRDA	  := space(6)
_cNome_RDA := ""
_nAdiant   := 0

// Limpa aCols
aCols       := {}
aCols       := Array(1,Len(aHeader)+1)
aCols[1][1] := SPACE(6)
aCols[1][2] := CTOD("  /  /  ")
aCols[1][3] := 0
aCOLS[1][4] := SPACE(150)
aCols[1,len(aHeader)+1] := .F.
oDtMesAno:=SetFocus()
obj1:Refresh()
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validar MEs/Ano Informados                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fValMesAno(cMesAno)

fRet := .T.
If Empty(Left(cMesAno,2)) .or. Empty(Substr(cMesAno,4,2))
	If lSair = .F.
		_cFormDt := "Formato: MM/AAAA"
		Return(fRet)
	Endif
Endif
_cFormDt := ""
Return(fRet)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validar Codigo do RDA Informado                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fValRDA(_cCodRDA,_cFornec,cMesAno,_oDlg)

fRet := .T.
If Empty(_cCodRDA)
   fRet := .F.
Else
	fRet := fTrazNome(_cCodRDA,_oDlg)
Endif

Return(fRet)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Trazer o Nome do RDA Informado e grupo,busca valor informado e titulos      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function fTrazNome(_cCodRDA,_oDlg)

f_ok := .T.

// Busca Grupo
dbselectarea("BAU")
dbsetorder(1)
dbseek(xFilial("BAU")+_cCodRDA)
_cNome_RDA := BAU->BAU_NOME
_cGruPag   := BAU->BAU_GRPPAG
If !Found()  // 31/08/07 - Noronha
	msgBox("Codigo de RDA Não Cadastrado.","Sem Cadastro:","INFO")
	Return(.F.)
Endif
dbselectarea("B16")
dbsetorder(1)
dbseek(xFilial("B16")+_cGruPag)
_cDesGrP := B16->B16_DESCRI
_cCabGrp := _cGruPag+"-"+alltrim(_cDesGrP)

If cTipoMov $ "011|013|014" // Visualizar/Exlcluir
	Return(.T.)
Endif

// Busca Valor Informado
_nVLInform := 0
_cMes      := Left(cMesAno,2)
_cAno      := Substr(cMesAno,4,4)
dbselectarea("ZZP")
ZZP->(DbSetOrder(1))
ZZP->(MsSeek(xFilial("ZZP")+_cCodRDA+_cMes+_cAno))
Do While !EOF() .and. xFilial("ZZP")+_cCodRDA+_cMes+_cAno = ZZP->ZZP_FILIAL+ZZP->ZZP_CODRDA+ZZP->ZZP_MESPAG+ZZP->ZZP_ANOPAG    
   IF ZZP->ZZP_VLTGUI = 0
	  _nVLInform += ZZP->ZZP_VLRTOT  
   Else                              
	  _nVLInform += ZZP->ZZP_VLTGUI  
   EndIf    	
	dbskip()
Enddo

// Busca Titulos Baixados 05/10/2007 - Noronha
cQuery      := "SELECT * FROM "+RetSqlName("SE2")
cQuery      += " WHERE SUBSTR(E2_ORIGEM,1,3) = 'PLS' AND D_E_L_E_T_ = ' '"
cQuery      += " AND E2_FILIAL = '" + xFilial("SE2") + "' "
cQuery      += " AND E2_SALDO = 0 "
cQuery      += " AND E2_CODRDA = '" + _cCodRDA + "' "
cQuery      += " AND E2_ANOBASE = '" + _cAno + "' "
cQuery      += " AND E2_MESBASE = '" + _cMes + "' "
If Select("TMPBX") >0
	dbSelectArea("TMPBX")
	dbclosearea()
Endif
TCQuery cQuery Alias "TMPBX" New
dbSelectArea("TMPBX")
If !EOF()
	lBaixado := .T.
Else
	lBaixado := .F.
Endif
dbclosearea()
//

// Busca Titulos
cQuery      := "SELECT * FROM "+RetSqlName("SE2")
cQuery      += " WHERE SUBSTR(E2_ORIGEM,1,3) = 'PLS' AND D_E_L_E_T_ = ' '"
cQuery      += " AND E2_FILIAL = '" + xFilial("SE2") + "' "
cQuery      += " AND E2_SALDO > 0 "
cQuery      += " AND E2_CODRDA = '" + _cCodRDA + "' "
cQuery      += " AND E2_ANOBASE = '" + _cAno + "' "
cQuery      += " AND E2_MESBASE = '" + _cMes + "' "
cQuery      += " AND E2_YLIBPLS NOT IN ('S','M','L')"      // S=Liberado NF   M=Liberacao Manual   L=Pendente Liberacao Manual

If Select("TMPTIT") >0
	dbSelectArea("TMPTIT")
	dbclosearea()
Endif

_cAliasTemp := GetNextAlias()

TCQuery cQuery Alias "TMPTIT" New

dbSelectArea("TMPTIT")

// Composicao Valor Bruto e Valor Liquido
_nINSS    := TMPTIT->E2_INSS
_nIRF     := TMPTIT->E2_IRRF
_nDecres  := TMPTIT->E2_DECRESC
_nISS     := TMPTIT->E2_ISS
_nSEST    := TMPTIT->E2_SEST
_nAcres   := TMPTIT->E2_ACRESC
_nPIS     := TMPTIT->E2_VRETPIS
_nMulta   := TMPTIT->E2_MULTA
_nCOFINS  := TMPTIT->E2_VRETCOF
_nLiquid  := TMPTIT->E2_SALDO
_nCSLL    := TMPTIT->E2_VRETCSL                                                      // 14/08/07
_nVLBruto := TMPTIT->E2_SALDO + _nIRF + _nINSS + _nSEST + _nPIS + _nCOFINS + _nCSLL  + _nISS
_cTitulo  := TMPTIT->E2_NUM
_cPref    := TMPTIT->E2_PREFIXO
_nLiquid  := _nLiquid - _nDecres + _nAcres - _nMulta
_cTipo    := TMPTIT->E2_TIPO
_cParc    := TMPTIT->E2_PARCELA
_cFornec  := TMPTIT->E2_FORNECE
_cLoja    := TMPTIT->E2_LOJA
_nAdiant  := 0

//14/08/2007
_cChve    := _cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja
lConsRDA  := .F.


//////////////////////////// 
If !Empty(_cChve)
   cQuery := " SELECT A2_YDDPJ "
   cQuery += " FROM " + RetSqlName("SA2")
   cQuery += " WHERE D_E_L_E_T_ = ' ' "
   cQuery += " AND A2_FILIAL    =  ' '"
   cQuery += " AND A2_COD       =  '" + _cFornec + "'"

   cQuery := ChangeQuery(cQuery)

   If Select("TMP1") <> 0
      DbSelectArea("TMP1")
	  DbCloseArea()
   Endif

   dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery), 'TMP1', .F., .T.)
   dbselectarea("TMP1")   
    If !Empty (TMP1->A2_YDDPJ) 
       Alert("ATENÇÃO : " +  TMP1->A2_YDDPJ + "!!!")
    EndIf 
EndIf   

////////////////////////////



If !Empty(_cChve)
	//13/08/2007
	// Buscar Adiantamentos - 17/08/2007 - Correcao da rotina
	dbSelectArea("SE5")
	dbsetorder(7)
	dbseek(xFilial("SE5")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
	Do While !EOF() .and. xFilial("SE5")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja = ;
		E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_FORNECE+E5_LOJA
		If ALLTRIM(E5_TIPODOC) = "CP"
			/*------------------------------------------------*/
			/* Alterado por Jeferson Couto 		em 15/10/2007 */
			/*                                                */
			/* Alterado para refazer o valor original do      */
			/* adiantamento para que seja refeito o valor     */
			/* bruto do titulo corretamente                   */
			/*------------------------------------------------*/
			//_nAdiant := SE5->E5_VALOR
			//_nAdiant := (SE5->E5_VALOR - SE5->E5_VLJUROS - SE5->E5_VLMULTA + SE5->E5_VLCORRE + SE5->E5_VLDESCO)
			_nAdiant += (SE5->E5_VALOR - SE5->E5_VLJUROS - SE5->E5_VLMULTA + SE5->E5_VLCORRE + SE5->E5_VLDESCO)
		Else
			If ALLTRIM(E5_TIPODOC) = "ES"
				_nAdiant  := 0
			Endif
		Endif
		dbskip()
	Enddo
	dbsetorder(1)
	_nVLBruto += _nAdiant
	
Else
	//14/08/2007
	dbselectarea("SZB")
	dbsetorder(1)
	dbseek(xFilial("SZB")+Substr(cMesAno,4,4)+Left(cMesAno,2)+_cCodRDA)
	If Found()
		If !cTipoMov $ "011|013|014" // Visualizar/Exlcluir/Compensar
			msgBox("Existe NF Digitada Neste Periodo Para Este RDA: NF-"+SZB->ZB_NOTA,"Utilize a Opção Visualizar","INFO")
			//f_ok := .F.
		Endif
	Else  // Noronha - 31/08/07 - Mostrar mensagem quando nao encontra titulos
		If lBaixado            // 05/10/2007 - Noronha
			msgBox("Titulo Para Este RDA Nesta Competencia Já Foi Baixado.","Titulo Baixado:","INFO")
			f_ok := .F.
		Else
			msgBox("Não Foram Encontrados Titulos no Financeiro Para Este RDA.","Sem Titulos:","INFO")
			f_ok := .F.
		Endif
	Endif
Endif

Return(.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³   C()   ³ Autores ³ Norbert/Ernani/Mansano ³ Data ³10/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao responsavel por manter o Layout independente da       ³±±
±±³           ³ resolucao horizontal do Monitor do Usuario.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C(nTam)
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor
If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)
	nTam *= 0.8
ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600
	nTam *= 1
Else	// Resolucao 1024x768 e acima
	nTam *= 1.28
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tratamento para tema "Flat"³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If "MP8" $ oApp:cVersion
	If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()
		nTam *= 0.90
	EndIf
EndIf
Return Int(nTam)

****************************
Static Function Fecha_dlg1()   // Sair
****************************

lSair := .T.
Close(_oDlg)

Return



********************************
Static Function Grv_Dados()   // Gravar Dados Apos Critica
********************************
Local lComp := .F.

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

lSair1:=.F.                        

lcmp  := .F.
CargaVetor(.T.)

If !f_ok
	MsgBox("Registro não pode ser gravado!")
EndIf

If lConsRDA
	Canc_Dlg1()
	Return
Endif

If f_ok
	dbselectarea("SZB")
	dbsetorder(1)
	For i:= 1 to Len(aCols)
		dbseek(xFilial("SZB")+Substr(cMesAno,4,4)+Left(cMesAno,2)+_cCodRDA+aCols[i][1])
		If Found()
			Alert("Nota Fiscal "+aCols[i][1]+" Já Foi Usada em Outro Titulo.")
			f_ok := .F.
			Exit
		Endif
	Next i
	
Endif

If f_ok
	
	_nTotDig := 0
	
	For i:= 1 to Len(aCols)
		If aCols[i,len(aHeader)+1] = .F.
			_nTotDig += aCols[i,3]
		Endif
	Next i
	
	If _cGruPag $ GETMV("MV_XGRPPLS")  // Grupo do Interior
		If (_nTotDig = _nVLBruto .or. _nTotDig = _nVLInform) .And. _nTotDig <> 0
			f_ok := .T.
		Else
			f_ok := .F.
			Alert("Valor Total Informado Não é Correto.")
		EndIf
	Else
		If _nTotDig = _nVLBruto .And. _nTotDig <> 0
			f_ok := .T.
		Else
			f_ok := .F.
			Alert("Valor Total Informado Não é Correto.")
		Endif
	EndIf
	
EndIf

If f_ok
	For i:= 1 to Len(aCols)
		dbselectarea("SZB")
		RecLock("SZB",.T.)
		ZB_FILIAL  := xFILIAL("SZB")
		ZB_NOTA    := aCols[i][1]
		ZB_EMISSAO := aCols[i][2]
		ZB_VTOTAL  := aCols[i][3]
		ZB_OBS     := Time()+"-"+aCols[i][4]
		ZB_ANOMES  := Substr(cMesAno,4,4)+Left(cMesAno,2)
		ZB_CODRDA  := _cCodRDA
		ZB_PREFIXO := _cPref
		ZB_TITULO  := _cTitulo
		ZB_VINFORM := _nVLInform
		ZB_VBRUTO  := _nVLBruto
		ZB_TIPO    := _cTipo
		ZB_PARCELA := _cParc
		ZB_FORNECE := _cFornec
		ZB_LOJA    := _cLoja
		ZB_USUAR   := SubStr(cUSUARIO,7,15)
		ZB_DTDIGIT := dDataBase
		
		Msunlock("SZB")
	Next i
	
	// Caso as NFs Informadas tenham +60Dias entre data de emissao e data de vencimento do Titulo do PLS nao liberar
	lLibNF := .F.
	dbselectarea("SE2")
	SE2->(DbSetOrder(1))
	dbSeek(xFilial("SE2")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
	If Found()
		For i:= 1 to Len(aCols)
//			If (dDataBase-SE2->E2_VENCREA) > GETMV("MV_DIASPLS")
            If (SZB->ZB_EMISSAO - SE2->E2_VENCREA) > GETMV("MV_DIASPLS")
				msgBox("Titulo Ficou Pendente de Liberação Manual !","Diferença Superior a "+Str(GETMV("MV_DIASPLS"))+" Dias","INFO")
				lLibNF := .T.
				Exit
			Endif
		Next i
	Endif
	// Libera Titulos
	dbselectarea("SE2")
	dbSeek(xFilial("SE2")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
	If Found()
		RecLock("SE2",.F.)
		SE2->E2_YLIBPLS := IIf(lLibNF,"L","S")
		SE2->E2_YDTDGNF := dDataBase
		SE2->E2_YHRDGNF := Time()
		// Altera Data de Vencimento (+2 Dias Uteis apos a Data de Liberacao)
		//SE2->E2_VENCTO  := (DDATABASE+2)
		//Edilson Leal 15/01/08 - Retirado a pedido do Antonio.
		//SE2->E2_VENCREA := DataValida(SE2->E2_VENCTO,.T.)
		Msunlock("SE2")
		VerImpostos("1")
	   
	   If SE2->E2_YLIBPLS == "S"
	      If lCmp
	         lCOmp  := .T.
	      Endif
	   Endif
	      
	Endif
	
	// Limpar Variaveis
	_nVLBruto  := 0
	_nVLInform := 0
	_nINSS     := 0
	_nIRF      := 0
	_nDecres   := 0
	_nISS      := 0
	_nSEST     := 0
	_nAcres    := 0
	_nPIS      := 0
	_nMulta    := 0
	_nCOFINS   := 0
	_nLiquid   := 0
	_nCSLL     := 0
	_cTitulo   := SPACE(6)
	_cGruPag   := space(4)
	_cCabGrp   := ""
	_cTipo     := ""
	_cParc     := ""
	_cFornec   := ""
	_cLoja     := ""
	_cCodRDA	  := space(6)
	_cNome_RDA := ""
	
	// Limpa aCols
	aCols       := {}
	aCols       := Array(1,Len(aHeader)+1)
	aCols[1][1] := SPACE(6)
	aCols[1][2] := CTOD("  /  /  ")
	aCols[1][3] := 0
	aCOLS[1][4] := SPACE(150)
	aCols[1,len(aHeader)+1] := .F.
	obj1:Refresh()
	
//	If lComp (altamiro 07/10/2008)
	If lCmp
	   If MsgYesNo("Existem Titulos a Serem Compensados , deseja fazer agora ?")
	      fSelecTit(.F.)
	   Endif
	Endif 

Endif
Return

***************************
Static Function Exc_Dados()   // Excluir NF
***************************

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

f_ok := .T.
lSair1:=.F.
If f_ok
	dbselectarea("SE2")
	SE2->(DbSetOrder(1))
	dbSeek(xFilial("SE2")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
	If Found()
		If Empty(SE2->E2_SALDO) .OR. !Empty(SE2->E2_NUMBOR)
			msgBox("Titulo Já Foi Baixado ou Esta em Bordero !","Não Pode Excluir Esta NF","INFO")
			Return
		Else
			If MsgYesNo("Confirma Exclusão Desta Nota Fiscal ?")
				// Bloqueia Novamente os Titulos
				dbselectarea("SE2")
				dbSeek(xFilial("SE2")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
				If Found()
					RecLock("SE2",.F.)
					SE2->E2_YLIBPLS := "N" 
					SE2->E2_YDTDGNF := CTOD("  /  /  ")
		            SE2->E2_YHRDGNF := " "
					Msunlock("SE2")
					VerImpostos("2")   // Bloqueia Titulos de Impostos
					dbselectarea("SZB")
					dbsetorder(1)
					For i:= 1 to Len(aCols)
						dbseek(xFilial("SZB")+Substr(cMesAno,4,4)+Left(cMesAno,2)+_cCodRDA+aCols[i][1])
						If Found()
							RecLock("SZB",.F.)
							ZB_USUAR := SubStr(cUSUARIO,7,15)  // Usuario Que Excluiu a NF
							dbdelete()
							Msunlock("SZB")
						Endif
					Next i
					
					dbSelectArea("SE5")
		         dbsetorder(7)
		         If  dbseek(xFilial("SE5")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
		            Do While !EOF() .and. xFilial("SE5")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja = ;
			           E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_FORNECE+E5_LOJA
			           If ALLTRIM(E5_TIPODOC) = "CP"
						     CmpTitulo("014",4)
					     Endif   
					     SE5->(DbSkip())
					   Enddo
					Endif
					  
					dbselectarea("SZB")
					dbgotop()
				Endif
			Endif
		Endif
	Else
		// msgBox("Titulo Não Encontrado !","Não Pode Excluir Esta NF","INFO")
		// 17/08/2007 - Noronha - Solicitacao Gisele/Antonio poder excluir Nota de titulos excluidos
		If MsgYesNo("Confirma Exclusão Desta Nota Fiscal ?")
			dbselectarea("SZB")
			dbsetorder(1)
			For i:= 1 to Len(aCols)
				dbseek(xFilial("SZB")+Substr(cMesAno,4,4)+Left(cMesAno,2)+_cCodRDA+aCols[i][1])
				If Found()
					RecLock("SZB",.F.)
					ZB_USUAR := SubStr(cUSUARIO,7,15)  // Usuario Que Excluiu a NF
					dbdelete()
					Msunlock("SZB")
				Endif
			Next i
			dbselectarea("SZB")
			dbgotop()
		Endif
	Endif
	// Limpar Variaveis
	_nVLBruto  := 0
	_nVLInform := 0
	_nINSS     := 0
	_nIRF      := 0
	_nDecres   := 0
	_nISS      := 0
	_nSEST     := 0
	_nAcres    := 0
	_nPIS      := 0
	_nMulta    := 0
	_nCOFINS   := 0
	_nLiquid   := 0
	_nCSLL     := 0
	_cTitulo   := SPACE(6)
	_cGruPag   := space(4)
	_cCabGrp   := ""
	_cTipo     := ""
	_cParc     := ""
	_cFornec   := ""
	_cLoja     := ""
	_cCodRDA	  := space(6)
	_cNome_RDA := ""
	
	// Limpa aCols
	aCols       := {}
	aCols       := Array(1,Len(aHeader)+1)
	aCols[1][1] := SPACE(6)
	aCols[1][2] := CTOD("  /  /  ")
	aCols[1][3] := 0
	aCOLS[1][4] := SPACE(150)
	aCols[1,len(aHeader)+1] := .F.
	obj1:Refresh()
	
Endif
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³VerImpostos ³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verificar se Tem Titulos de Impostos do PLS                ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ VerImpostos(cLibBlq)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static FuncTion VerImpostos(cLibBlq)

LOCAL cPrefixo := _cPref
LOCAL cNum	   := _cTitulo
LOCAL cParcPai

DbSelectArea("SE2")
nReg := RECNO()
If SE2->E2_ISS > 0
	nValorPai := SE2->E2_ISS
	cParcPai  := SE2->E2_PARCISS
	cTipoPai  := MVISS
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_INSS > 0
	nValorPai := SE2->E2_INSS
	cParcPai  := SE2->E2_PARCINS
	cTipoPai  := MVINSS
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_SEST > 0
	nValorPai := SE2->E2_SEST
	cParcPai  := SE2->E2_PARCSES
	cTipoPai  := "SES"
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_PIS > 0
	nValorPai := SE2->E2_PIS
	cParcPai  := SE2->E2_PARCPIS
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_COFINS > 0
	nValorPai := SE2->E2_COFINS
	cParcPai  := SE2->E2_PARCCOF
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_CSLL > 0
	nValorPai := SE2->E2_CSLL
	cParcPai  := SE2->E2_PARCSLL
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_IRRF > 0
	nValorPai := SE2->E2_IRRF
	cParcPai  := SE2->E2_PARCIR
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AchaImpostos³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Achar Titulos de Impostos do PLS                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AchaImpostos(nValorPai,cParcPai,cTipoPai,xFilial,xPrefixo,cNum,cLibBlq)
dbSelectArea("SE2")
If dbSeek(xFilial+xPrefixo+cNum)
	While !Eof() .and. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) == xFilial+xPrefixo+cNum
		If cParcPai == SE2->E2_PARCELA .and. cTipoPai = SE2->E2_TIPO
			If nValorPai != 0
				RecLock("SE2",.F.)
				If cLibBlq = "1"
					SE2->E2_YLIBPLS := IIf(lLibNF,"L","S")
				Else
					SE2->E2_YLIBPLS := "N"
				Endif
				// Altera Data de Vencimento (+2 Dias Uteis apos a Data de Liberacao)
				// Retirado a pedido do Antonio
				//		SE2->E2_VENCTO  := (DDATABASE+2)
				//	   SE2->E2_VENCREA := DataValida(SE2->E2_VENCTO,.T.)
				MSunlock()
				Exit
			EndIf
		EndIf
		DbSkip()
	Enddo
EndIf
dbSelectArea("SE2")
dbgoto(nReg)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA101   ºAutor  ³Microsiga           º Data ³  09/15/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
***************************************
STATIC FUNCTION MyEnchoBar(oObj,bObj)
***************************************

LOCAL oBar, lOk, lVolta, lLoop, oBtnCop, oBtnRec, oBtnCol, oBtnOk, oBtnCalc,oBtnCmp,oBtnFim

DEFINE BUTTONBAR oBar SIZE 25,25 3D TOP OF oObj
DEFINE BUTTON oBtnCop  RESOURCE "S4WB005N" Of oBar Action NaoDisp()           TOOLTIP "Copiar"      NoBorder
DEFINE BUTTON oBtnRec  RESOURCE "S4WB006N" Of oBar Action NaoDisp()           TOOLTIP "Recortar"    NoBorder
DEFINE BUTTON oBtnCol  RESOURCE "S4WB007N" Of oBar Action NaoDisp()           TOOLTIP "Colar"       NoBorder
DEFINE BUTTON oBtnCalc RESOURCE "S4WB008N" Of oBar Action Calculadora()       TOOLTIP "Calc"        NoBorder

If cTipoMov == "014" //COMPENSAR
   DEFINE BUTTON oBtnCmp  RESOURCE "CLIENTE"  OF oBar ACTION MsAguarde({||CmpTitulo("014",3)})  TOOLTIP "Compensar"   NoBorder //fCargaCmp
ElseIf cTipoMov $ "012|013"
   DEFINE BUTTON oBtOk    RESOURCE "OK"       OF oBar ACTION (IIf(cTipoMov =="013",Exc_Dados(),IIF(cTipoMov=="012",Grv_Dados(),Setfocus(2)))), Setfocus (2) TOOLTIP "Confirma"    NoBorder
//    DEFINE BUTTON oBtOk    RESOURCE "OK"       OF oBar ACTION (IIf(cTipoMov =="013",Exc_Dados(),IIF(cTipoMov=="012",Grv_Dados(),_odlg:end()))),_odlg:end() TOOLTIP "Confirma"    NoBorder

Endif                                                                                                                                         

DEFINE BUTTON oBtnFim  RESOURCE "CANCEL"   OF oBar ACTION oObj:End()          TOOLTIP "Sair"        NoBorder

oBar:bRClicked:={||AllwaysTrue()}
RETURN NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³                  ³ Tonieto           	³ Data ³ 23.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Visualiza dados do titulo selecionado                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³          	           									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³                         									  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
*****************************************************
Static Function Marca(lMarca,oLbx2,aVetBx,nOp,Odlg2)
*****************************************************
Local i := 0
Local nSomaTot := 0

If nOp == 2 //Marca/Desmarca Totos
	For I := 1 To Len(aVetBx)
   	   aVetBx[i][1] := lMarca
	   If lMarca
    	  nSomaTot += aVetBx[I,6] 
	   Endif
	Next 
Else
	For I := 1 To Len(aVetBx)
   		  If aVetBx[I,1] == .T.
   		     nSomaTot += aVetBx[I,6] 
	      Endif
	Next 
Endif

@ 240,190 Say "T O T A L :" SIZE 40,10 PIXEL OF ODLG2
@ 238,225 MSGET nSomaTot  PICTURE "@e 999,999.99" WHEN .F. SIZE 40,10 PIXEL OF oDlg2

oLbx2:Refresh()
Return
	  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA101   ºAutor  ³Microsiga           º Data ³  09/15/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
**********************************
Static Function CargaVetor(lMarca)
**********************************
Local cQuery      := " "
Local nVlCompensa := 0
If _cCodRDA = " "   
    lFlagVaz:=.F.
    Return Round(nVlCompensa,2) 
else             
    lFlagVaz:=.T.
EndIf                      

If Empty(xFornece)
	dbselectarea("BAU")
	dbsetorder(1)
	If dbseek(xFilial("BAU")+_cCodRDA)
		xFornece := BAU->BAU_CODSA2
	Endif
Endif

cQuery := " SELECT SUM(E2_SALDO) VALOR"
cQuery += " FROM " + RetSqlName("SE2")
cQuery += " WHERE D_E_L_E_T_ = ' ' "
cQuery += " AND E2_FILIAL    =  '" + cFilAnt              + "'"
cQuery += " AND E2_FORNECE   =  '" + xFornece             + "'"
cQuery += " AND E2_YMECPPA  <=  '" + Substr(cMesAno,1,2)  + "'"
cQuery += " AND E2_YANCPPA  <=  '" + Substr(cMesAno,6,2)  + "'"
cQuery += " AND E2_SALDO     >  0   "
cQuery += " AND E2_TIPO      = 'PA '"

cQuery := ChangeQuery(cQuery)

If Select("TMP") <> 0
	DbSelectArea("TMP")
	DbCloseArea()
Endif

dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery), 'TMP', .F., .T.)
dbselectarea("TMP")

//If !eof() (altamiro 07/10/2008) 
if TMP->VALOR > 0
	nVlCompensa := TMP->VALOR
   lCmp := .T.
Endif
lCmp := .F.             
nVlCompensa := 0.00
_Odlg:Refresh()	 
                              
 Return Round(nVlCompensa,2)
   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA101   ºAutor  ³Microsiga           º Data ³  09/15/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
**********************************
Static Function fSelecTit(lMarca)
**********************************
Local cQuery      := " "

If Empty(xFornece)
	dbselectarea("BAU")
	dbsetorder(1)
	If dbseek(xFilial("BAU")+_cCodRDA)
		xFornece := BAU->BAU_CODSA2
	Endif
Endif

cQuery := " SELECT E2_FILIAL,E2_PREFIXO,E2_NUM,E2_TIPO,E2_HIST,E2_YMECPPA,E2_YANCPPA,E2_FORNECE,E2_NOMFOR,E2_SALDO,R_E_C_N_O_ RECNOSE2"
cQuery += " FROM " + RetSqlName("SE2") 
cQuery += " WHERE  D_E_L_E_T_ = ' ' "
cQuery += " AND E2_FILIAL    =  '" + cFilAnt  + "'"
cQuery += " AND E2_FORNECE   =  '" + xFornece + "'"
cQuery += " AND E2_YMECPPA  <= '" + Substr(cMesAno,1,2)  + "'"
cQuery += " AND E2_YANCPPA  <= '" + Substr(cMesAno,6,2)  + "'"
cQuery += " AND E2_SALDO     >  0   "
cQuery += " AND E2_TIPO     <> 'PA ' AND E2_YLIBPLS IN ('S','M') " // L=LIBERADO , M=LIBERADO MANUALMENTE

cQuery := ChangeQuery(cQuery)

If Select("TMP") <> 0
	DbSelectArea("TMP")
	DbCloseArea()
Endif

dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery), 'TMP', .F., .T.)
dbselectarea("TMP")

While !eof()
	aAdd(aVetBx,{lMarca,TMP->E2_YMECPPA,TMP->E2_YANCPPA,TMP->E2_FORNECE,TMP->E2_NOMFOR,TMP->E2_SALDO,TMP->E2_PREFIXO,TMP->E2_NUM,TMP->E2_TIPO,TMP->E2_HIST,TMP->RECNOSE2})
	DbSelectArea("TMP")
	DBsKIP()
Enddo

 If Len(aVetBx) > 0                   
    fCargaCmp()
 Else
     Alert("Nao Existe Titulo a Ser Compensado !!!")
     Return
 Endif
     
_Odlg:Refresh()	

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA101   ºAutor  ³Microsiga           º Data ³  09/25/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

***************************************************************************
Static Function fCargaCmp()
***************************************************************************
Local cQuery      := " "
Local oLbx2       := Nil
Local oChk        := Nil
Local lMark       := .F.
Local oOk         := LoadBitMap(GetResources(),"LBOK")
Local oNo         := LoadBitMap(GetResources(),"LBNO")
Local lChk
Local Odlg2       := Nil
Local cTitulo     := "Selecione os Titulos a Serem Compensados !!!"
//Local lMark       := .F.
Local nVlCompensa := 0


DEFINE MSDIALOG oDlg2 TITLE cTitulo FROM 000,000 TO 510,850  OF oDlg2 PIXEL

If Len(aVetBx) <= 0
   Alert("Nao Existem titulos a compensar !!!")
   Return
Endif   

@ 010,010 LISTBOX oLbx2 FIELDS HEADER " ","Mes", "Ano","Fornecedor","Nome","Valor","Prefixo","Numero","Tipo","Historico","Recno" ;
SIZE 410,220 OF oDlg2 PIXEL ON DBLCLICK( MsAguarde({||aVetBx[oLbx2:nAt,1] := !aVetBx[oLbx2:nAt,1],Marca(lChk,oLbx2,aVetBx,1,Odlg2),oLbx2:Refresh()}))
	
		oLbx2:SetArray( aVetBx )
		oLbx2:bLine := {||{IIf(aVetBx[oLbx2:nAt,1],oOk,oNo),;
		aVetBx[oLbx2:nAt,2] ,;
		aVetBx[oLbx2:nAt,3] ,;
		aVetBx[oLbx2:nAt,4] ,;
		aVetBx[oLbx2:nAt,5] ,;
		Transform(aVetBx[oLbx2:nAt,6],"999,999.99"),;
		aVetBx[oLbx2:nAt,7],;
		aVetBx[oLbx2:nAt,8],;
		aVetBx[oLbx2:nAt,9],;
		aVetBx[oLbx2:nAt,10],;
		aVetBx[OLbx2:nAt,11]}}
	
	@ 233,300 CHECKBOX oChk VAR lChk PROMPT "Marca/Desmarca Todos os Registros" SIZE 110,007 PIXEL OF oDlg2;
	ON CLICK(Iif(lChk,Marca(lChk,oLbx2,aVetBx,2),Marca(lChk,oLbx2,aVetBx,2)))

  @ 235,030 BUTTON "&Confirma " SIZE 36,16 PIXEL ACTION MsAguarde({||CmpTitulo(" ",3),odlg2:end()})
  @ 235,080 BUTTON "&Sair     " SIZE 36,16 PIXEL ACTION oDlg2:End()
  
ACTIVATE MSDIALOG oDlg2 CENTER
Return .T.


****************************************
Static Function CmpTitulo(cTipoMov,nOp)
***************************************
Local I:= 0
Local aArea := GetArea()

If cTipoMov == "014"//compensar
   dbselectarea("SE2")
   SE2->(DbSetOrder(1))
   If dbSeek(xFilial("SE2")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)   
	   FINA340(nOp)
   Else
      Alert("Nao existem titulos a serem compensados com a nota selecionada!!!")
   Endif
Else   
   DbSelectArea("SE2")
   For I:= 1 to Len(aVetBx)
      If aVetBx[I,1]
         dbGoTo(aVetBx[I,11])
         FINA340(nOp)
      Endif
   Next
Endif     
RestArea(aArea)
Return  

******************************************************************
Static Function fbuscaVlDpj(cFilAtu,cNTitulo,cTipo,cFornece,cLoja)
******************************************************************
Local cQuery := " " 
Local nVldpj := 0 

cQuery := " SELECT SUM(E2_VALOR) VL_DPJ "
cQuery += " FROM " + RetSqlName("SE2")
cQuery += " WHERE D_E_L_E_T_  = ' '         AND "
cQuery += " E2_FILIAL  = '" + cFilAtu  + "' AND "
cQuery += " E2_PREFIXO = 'DPJ'              AND "
cQuery += " E2_NUM     = '" + cNtitulo + "' AND "
cQuery += " E2_FORNECE = '" + cFornece + "' AND "
cQuery += " E2_LOJA    = '" + cLoja    + "'"

If Select("TDPJ") > 0
	dbSelectArea("TDPJ")
	dbclosearea()
Endif

TCQuery cQuery Alias "TDPJ" New
dbSelectArea("TDPJ")

If !EOF()
	nVldpj := TDPJ->VL_DPJ 
Endif

Return nVldpj	
	
