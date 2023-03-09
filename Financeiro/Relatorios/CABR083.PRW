#include "PLSMGER.CH"
#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

Static cCodDB     := PLSRETLADC()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CABR094 ³ Autor ³ Altamiro Trotta Affonso³ Data ³ 03.11.99 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio de bloqueados por matricula...                   ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ Cabr094                                                    ³±±±
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
User Function CABR083()
//User Function CABR094()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variavaoeis...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin 	:= 58
PRIVATE cNomeProg   := "CABR94"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"     
PRIVATE cTitulo     := "Relatorio de Posição de Clientes   - Contas a Receber "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "BA3"
PRIVATE cPerg       := padr("CABR094", 10)
PRIVATE cRel        := "CABR094"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE aOrdens     := { "Codigo do plano" }
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.   
PRIVATE cDatacab    := " "  
PRIVATE cCodcli     := " " 
PRIVATE	nContador   := 0  
PRIVATE cCli1       := "  " 
PRIVATE cCli        := "  " 
PRIVATE	Identif     := " " 
PRIVATE cTpNLis     := " " 
private nQtdaSai    := 0
PRIVATE aContr      := {}
PRIVATE nPos1		:= 0

PRIVATE nQtdaDia    := 0
PRIVATE aInter      := {}     
//ALTAMIRO 17/02/2011 - carta janela
private aCabec1     := {"campo","campo1","campo3","campo4","campo5","campo6","campo7","campo8","campo9"}

private aDados      := {}     
private aDados1     := {}
PRIVATE ccab1:=ccab2:=ccab3:=ccab4:=ccab5:=cdet1:=ctit1:=ctit2:= " "  
//
alert(":-D")

/*
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Matricula : xxx.xxxx.xxxx.xxxxxx        Nome : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Referen.                Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cartão      Outros           Total 
PLS999999 999   999,999,999.99  999,999.99  999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99   999,999.99  999,999.99  999,999.99  999,999,999.99 

Totais          999,999,999.99  999,999.99  999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99   999,999.99  999,999.99  999,999.99  999,999,999.99 
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1()     



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

Pergunte(cPerg,.F.)         

cOpe     	:= mv_par01
nCodMotivo  := MV_PAR02 //iif (mv_par02 = " " , " " , "003")//mv_par02 
nGrEmpInc   := mv_par03 
nGrEmpFim   := mv_par04
dDtInicio   := dtos(mv_par05)
dDtFim  	:= dtos(mv_par06)
nListar     := mv_par07
nExcel      := mv_par08 
nAnalitico  := mv_par09
cTpNLis     := mv_par10
nQtdaSai    := mv_par11
nQtdaInc    := mv_par19
nQtdaFim    := mv_par20

// Inicio Marcela Coimbra

d_IniBlo	:= dtos(mv_par21)
d_FimBlo	:= dtos(mv_par22)

// Fim Marcela Coimbra

if mv_par12 = 1
   cTpPesoa := "F" 
elseif mv_par12 = 2 
   cTpPesoa := "J" 
else                     
   cTpPesoa := " "
Endif                  

cTpPgto     := mv_par13      

cMatr       := mv_par14
cTipReg     := mv_par15
cDigido     := mv_par16    
nDadCon     := mv_par17
nQtdaDia    := Iif(!empty(mv_par18),mv_par18,0)
dVenc       := dtos(date())

/*
                         10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220 
                1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
*/
If nanalitico = 2                                                                                                                                                                                                             
	cCabec1 := "Referen.                Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cartão      Outros           Total Emissao   Venc.     Baixa    Brd"
ElseIf nanalitico = 1                                                                                                                                                                                                        
	cCabec1 := "Referen.                Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cartão      Outros           Total " 
EndIf	
//	cCabec2 := "                        Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cartão      Outros         Liquido        Baixados           Saldo"
	

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
±±³Funcao    ³ RJ002Imp³ Autor ³ Altamiro Trotta Affonso³ Data ³ 03.11.09 ³±±±
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

// Total da competencia...
LOCAL nTotCMen 	:= 0
LOCAL nTotCOpc 	:= 0
LOCAL nTotCAde 	:= 0
LOCAL nTotCDeb 	:= 0
LOCAL nTotCCre 	:= 0
LOCAL nTotCPF  	:= 0
LOCAL nTotCTar 	:= 0
LOCAL nTotCFar 	:= 0
LOCAL nTotCGui 	:= 0
LOCAL nTotCCar 	:= 0
LOCAL nTotCOut 	:= 0
LOCAL nTotCPla	:= 0
LOCAL nTotCBai	:= 0
LOCAL nTotCSld	:= 0

// Quebra do grupo
LOCAL nTotMen 	:= 0
LOCAL nTotOpc 	:= 0
LOCAL nTotAde 	:= 0
LOCAL nTotDeb 	:= 0
LOCAL nTotCre 	:= 0
LOCAL nTotPar 	:= 0
LOCAL nTotTar	:= 0
LOCAL nTotFar	:= 0
LOCAL nTotPF	:= 0
LOCAL nTotOut 	:= 0
LOCAL nTotGui	:= 0
LOCAL nTotCar	:= 0
LOCAL nTotGrupo := 0
LOCAL nTotBai   := 0 
LOCAL nTotSld	:= 0

// Total geral
LOCAL nTotGMen 	:= 0
LOCAL nTotGOpc 	:= 0
LOCAL nTotGAde 	:= 0
LOCAL nTotGDeb 	:= 0
LOCAL nTotGCre 	:= 0
LOCAL nTotGPF  	:= 0
LOCAL nTotGTar 	:= 0
LOCAL nTotGFar 	:= 0
LOCAL nTotGOut 	:= 0
LOCAL nTotGGui	:= 0
LOCAL nTotGCar  := 0
LOCAL nTotGeral	:= 0
LOCAL nTotGBai 	:= 0 
LOCAL nTotGSld	:= 0

LOCAL nTotal	:= 0
LOCAL nTotal1	:= 0  
LOCAL nTotal3	:= 0
LOCAL pMoeda1	:= "@E 999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL nPos		:= 0
LOCAL nPosTit	:= 0
LOCAL aTitulos 	:= {}
LOCAL aPlaUsr	:= {}
LOCAL nPosPla	:= 0
LOCAL _cCodPla	:= ''
LOCAL _cVerPla 	:= ''
LOCAL nTotLinha := 0
LOCAL nTitulos	:= 0
LOCAL aParc		:= {}
LOCAL lRateio 	:= .F.
LOCAL lFracao	:= .F.
LOCAL nH		:= 0
LOCAL aRateio	:= {}
LOCAL nSaldo	:= 0
LOCAL nSaldoSE5 := 0

LOCAL _CODINT := " "
LOCAL _CODEMP := " "    
LOCAL _MATRIC := " "
LOCAL _TIPREG := " "
LOCAL _DIGITO := " "
LOCAL _NOMUSR := " "
LOCAL _DATBLO := stod("20010101") 
LOCAL _MOTBLO := " "    
LOCAL _CLIENTE:= " "
						 


Local aCampoTRB := {{ "TR1_CODINT"      , "C", TamSX3("BA1_CODINT")[1]	    , 0 },;
                    { "TR1_CODEMP" 	    , "C", TamSX3("BA1_CODEMP")[1]	    , 0 },;
                    { "TR1_MATRIC" 		, "C", TamSX3("BA1_MATRIC")[1]	    , 0 },;
                    { "TR1_TIPREG"		, "C", TamSX3("BA1_TIPREG")[1]	    , 0 },;  
                    { "TR1_DIGITO"		, "C", TamSX3("BA1_DIGITO")[1]      , 0 },; 
                    { "TR1_NOMUSR"		, "C", TamSX3("A1_NOME")[1]         , 0 },; // A1_NOME
                    { "TR1_ENDERE "		, "C", TamSX3("A1_END")[1]          , 0 },; // A1_END        
                    { "TR1_BAIRRO "		, "C", TamSX3("A1_BAIRRO")[1]       , 0 },; // A1_BAIRRO 
                    { "TR1_MUNICI"		, "C", TamSX3("A1_MUN")[1]          , 0 },; // A1_MUN
                    { "TR1_ESTADO"		, "C", TamSX3("A1_EST")[1]          , 0 },; //  A1_EST
                    { "TR1_DDD "		, "C", TamSX3("A1_DDD")[1]          , 0 },; //  BA1_DDD
                    { "TR1_CEP  "		, "C", TamSX3("A1_CEP")[1]          , 0 },; //  A1_CEP 
                    { "TR1_YTEL2"		, "C", TamSX3("A1_TEL")[1]          , 0 },; // A1_TEL
                    { "TR1_YCEL"		, "C", TamSX3("A1_FAX")[1]          , 0 },; // A1_FAX  
                    { "TR1_NOMUSU"		, "C", TamSX3("BM1_NOMUSR")[1]      , 0 },; 
                    { "TR1_DATBLO"		, "D", TamSX3("BA3_DATBLO")[1]      , 0 },;  
                    { "TR1_MOTBLO"		, "C", TamSX3("BA3_MOTBLO")[1]      , 0 },;  
                    { "TR1_DTEMIS"		, "D", TamSX3("BA3_DATBLO")[1]      , 0 },;  
                    { "TR1_DTVCT"		, "D", TamSX3("BA3_DATBLO")[1]      , 0 },;  
                    { "TR1_DTBXA"		, "D", TamSX3("BA3_DATBLO")[1]      , 0 },;  
                    { "TR1_PREFIX"		, "C", TamSX3("E1_PREFIXO")[1]	    , 0 },; 
                    { "TR1_NUM"			, "C", TamSX3("E1_NUM")[1]		    , 0 },;
                    { "TR1_PARCEL"		, "C", TamSX3("E1_PARCELA")[1]	    , 0 },;  
                    { "TR1_TIPO"		, "C", TamSX3("E1_TIPO")[1]		    , 0 },;   
                    { "TR1_CODCLI"		, "C", TamSX3("E1_CLIENTE")[1]	    , 0 },;   
                    { "TR1_MESBAS"		, "C", TamSX3("E1_MESBASE")[1]	    , 0 },;  
                    { "TR1_ANOBAS"		, "C", TamSX3("E1_ANOBASE")[1]	    , 0 },;  
                    { "TR1_VALTIT"		, "N", TamSX3("E1_VALOR")[1]		, 2 },;
                    { "TR1_VLRBAI"		, "N", TamSX3("E1_VALOR")[1]		, 2 },;
                    { "TR1_NUMBCO"		, "C", TamSX3("E1_NUMBCO")[1]		, 0 },;
                    { "TR1_NUMBOR"		, "C", TamSX3("E1_NUMBOR")[1]		, 0 },;
                    { "TR1_VLRMEN"		, "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLRDEB"		, "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLRCRE"		, "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLROPC"		, "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLRTAX"		, "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLRPF"		, "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLRTAR"		, "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLRFAR" 	    , "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLRGUI" 	    , "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLRCAR" 	    , "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLROUT"		, "N", TamSX3("BM1_VALOR")[1]		, 2 }}

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


// Monta variaveis com os prefixo utilizados pelo SIGAPLS para gerar titulos no contas a receber...
SX5->( dbSetorder(01) )
cPrefixos := ''
If SX5->( dbSeek(xFilial("SX5")+"BK") )
	While SX5->( !Eof() ) .and. Alltrim(SX5->X5_TABELA) == 'BK'
		cPrefixos += IIf(Empty(cPrefixos), "", ";")+ Alltrim(SX5->X5_CHAVE)
		
		SX5->( dbSkip() )
	Enddo
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Expressao de filtro...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery := "SELECT DISTINCT  e1_cliente, e1_prefixo, e1_num, e1_parcela , e1_tipo, e1_emissao , e1_vencto ,e1_baixa, e1_numbor, a1_cod, E1_ANOBASE,E1_MESBASE"   

cQuery += " FROM " + RetSqlName("BA1") + " BA1 ,"  + RetSqlName("SE1") + " SE1 , " + RetSqlName("BM1")+" BM1 , " + RetSqlName("SA1")+" SA1 "
cQuery += " WHERE E1_FILIAL = '" + xFilial("SE1") + "' "    
cQuery += " AND BM1_FILIAL = '" + xFilial("BM1") +"' " 
cQuery += " AND BA1_FILIAL = '" + xFilial("BA1") +"' "     

cQuery += " AND A1_FILIAL = '" + xFilial("SA1") +"' "     
cQuery += " AND SA1.D_E_L_E_T_ = ' ' "

cQuery += " AND BM1.D_E_L_E_T_ = ' ' "
cQuery += " AND BA1.D_E_L_E_T_ = ' ' "
cQuery += " AND SE1.D_E_L_E_T_ = ' ' "             

if nCodMotivo = "  "     

   cQuery += " AND BA1_MOTBLO  in ( ' ','002','004','021','022','028','039','041','044') "
 
Else   

   cQuery += " AND BA1_MOTBLO  = '"+nCodMotivo+"' " 
   	
   	If !Empty ( d_IniBlo ) 
   	
   		cQuery += " AND BA1_DATBLO >= '"+d_IniBlo+"' "
   	
   	EndIf
	
	If !Empty ( d_FimBlo )    
   		
   		cQuery += " AND BA1_DATBLO <= '"+d_FimBlo+"' "   
   		
   	EndIf
   
EndIf

cQuery += " AND BA1_CODEMP >= '"+ nGrEmpInc + "' "
cQuery += " AND BA1_CODEMP <= '"+ nGrEmpFim + "' "

/////

If !empty (cMatr)
   cQuery += " AND BA1_MATRIC = '" + cMatr   +"'"
EndIf 
If !empty (cTipReg)  
   cQuery += " AND ba1_tipreg = '" + cTipReg +"'"
EndIf
If !empty (cDigido)
   cQuery += " AND ba1_digito = '" + cDigido +"'"
EndIf

/////
cQuery += " AND BA1_CODINT = BM1_CODINT "
cQuery += " AND BA1_CODEMP = BM1_CODEMP "
cQuery += " AND BA1_MATRIC = BM1_MATRIC "
cQuery += " AND ba1_tipreg = bm1_tipreg "
cQuery += " AND ba1_digito = bm1_digito "
cQuery += " AND ba1_filial = bm1_filial "

cQuery += " AND bm1_prefix = e1_prefixo "
CQuery += " AND bm1_numtit = e1_num     "
cQuery += " AND bm1_tiptit = e1_tipo    "
cQuery += " AND bm1_parcel = e1_parcela "  

If cTpPgto = 3 
   cQuery += " AND e1_saldo > 0  and e1_vencto < '"+ dVenc +"'" 
ElseIf cTpPgto = 2                                       
   cQuery += " AND e1_saldo > 0  "                                                  
ElseIf cTpPgto = 1                                       
   cQuery += " AND e1_saldo = 0  "
EndIf                                                      

cQuery += " AND A1_COD = E1_cliente    "
                                                                                  
If !empty (cTpPesoa) 
    cQuery += " AND a1_pessoa   = '"+ cTpPesoa +"'"
EndIf                                        
            
If !empty (cTpNLis) 
   cQuery += " and e1_prefixo not in ( " + cTpNLis + " ) "
EndIf 
                                                                       
cQuery += " AND E1_ANOBASE||E1_MESBASE >='"+ substr (dDtInicio,1,6)+"'"   
cQuery += " AND E1_ANOBASE||E1_MESBASE <='"+ substr (dDtFim,1,6)+"'"   
cQuery += " ORDER BY  e1_cliente, e1_prefixo, e1_num, e1_parcela , e1_tipo   "
      
//////////////////////////////////////////////////////////////

PlsQuery(cQuery, "TRBBA1")

nQtd:=0             

TRBBA1->(DBEval( { | | nQtd ++ }))
BarGauge1Set(nQtd)

TRBBA1->(DbGoTop())

BQC->(DbSetOrder(1))
BFQ->(DbSetOrder(1))
BI3->(dbSetorder(1))
SE1->(dbSetorder(1))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o Arquivo de Trabalho que armazenara os valores por produto...      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTRB := CriaTrab(aCampoTRB, .T.)

dbUseArea(.T.,,cArqTRB,"TRB1",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice 1 do Arquivo de Trabalho com a Grade Curricular do aluno.    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cInd1TRB := CriaTrab(Nil, .F.)                                                          

If nAnalitico > 1 
//	IndRegua("TRB1",cInd1TRB," TR1_CODINT + TR1_CODEMP + TR1_MATRIC + TR1_TIPREG + TR1_DIGITO + TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO ",,,"Indexando Arquivo de Trabalho")
	IndRegua("TRB1",cInd1TRB," TR1_CODINT + TR1_CODEMP + TR1_MATRIC + TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO ",,,"Indexando Arquivo de Trabalho")
Else
	IndRegua("TRB1",cInd1TRB," TR1_CODINT + TR1_CODEMP + TR1_MATRIC  ",,,"Indexando Arquivo de Trabalho")	
Endif
 


TRB1->( dbClearIndex() )

TRB1->(dbSetIndex(cInd1TRB + OrdBagExt()))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define matriz de planos...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aPlanos := {}


nTotal := 0
nTotal1 := 0 
nTotal3 := 0
//BarGauge2Set(1)

While ! TRBBA1->(Eof())               
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posicion o registro fisicamente no SE1...                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncProcG1('Processando titulo . . .  ' )
	ProcessMessage()	
if nListar <> 2	 .AND. TRBBA1->E1_PREFIXO = 'PLS'		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona a composicao do titulo...                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO,  BA1_NOMUSR, BM1_CODTIP, BM1_DESTIP, "
	cSql +=	" BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BA1_CODPLA, BA1_DATBLO , "
	cSql += " BM1_CODPLA, BM1_DESPLA, BM1_VERPLA, BA1_VERSAO, BM1_ANO, BM1_MES, BM1_TIPO , BA1_MOTBLO ,  " 
	cSql += " A1_NOME ,   A1_END , A1_BAIRRO , A1_MUN , A1_EST, A1_CEP , A1_DDD , A1_TEL, A1_FAX "
	
	cSql += " FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BM1")+" BM1 , "+RetSqlName("SA1")+" SA1 ""
	cSql += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSql += " AND BM1_FILIAL = '"+xFilial("BM1")+"' "  
	cSql += " AND A1_FILIAL  = '"+xFilial("SA1")+"' "
	cSql += " AND BM1_PREFIX = '"+TRBBA1->E1_PREFIXO+"' "
	cSql += " AND BM1_NUMTIT = '"+TRBBA1->E1_NUM+"' "
	cSql += " AND BM1_PARCEL = '"+TRBBA1->E1_PARCELA+"' "
	cSql += " AND BM1_TIPTIT = '"+TRBBA1->E1_TIPO+"' "   
	
	cSql += " AND BM1.D_E_L_E_T_ = ' ' "
	cSql += " AND BA1.D_E_L_E_T_ = ' ' " 
	cSql += " AND SA1.D_E_L_E_T_ = ' ' "
	cSql += " AND BA1_CODINT = BM1.BM1_CODINT "
	cSql += " AND BA1_CODEMP = BM1.BM1_CODEMP "
	cSql += " AND BA1_MATRIC = BM1.BM1_MATRIC "
	cSql += " AND BA1_TIPREG = BM1.BM1_TIPREG " 
	cSql += " AND A1_COD = '"+TRBBA1->E1_CLIENTE+"' "
    


If !empty (cMatr)
   cSql += " AND BA1_MATRIC = '" + cMatr   +"'"
EndIf 
If !empty (cTipReg)  
  cSql += " AND ba1_tipreg = '" + cTipReg +"'"
EndIf
If !empty (cDigido)
   cSql += " AND ba1_digito = '" + cDigido +"'"
EndIf

	
	cSql += " ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "
	
	PlsQuery(cSql, "TRB")                                                   
	TRB->(DBEval( { | | nQtd }))
	//nQtd := 0      
	TRB->(DbGoTop())
	BarGauge2Set(nQtd)
	aPlaUsr := {}

	While !TRB->( Eof() ) 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ Apresenta mensagem em tela...                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProcG2("Processando Familia - "+ TRB->(BM1_CODINT + '.' + BM1_CODEMP + '.' + BM1_MATRIC + '.' + BM1_TIPREG  + '.' + BM1_DIGITO)+" - "+Transform(nTotal, "@E 999,999,999,999.99"))
		ProcessMessage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alimenta o arquivo temporario...                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	
   	    If nAnalitico > 1 
  	       cChave := TRB->(BM1_CODINT + BM1_CODEMP + BM1_MATRIC + BM1_PREFIX + BM1_NUMTIT + BM1_PARCEL + BM1_TIPTIT) 	
		Else
           cChave := TRB->(BM1_CODINT + BM1_CODEMP + BM1_MATRIC )
		Endif
					
	
		lFound := TRB1->( MsSeek( cChave ) )
		
		TRB1->( RecLock("TRB1", !lFound) )

		If !lFound
			TRB1->TR1_CODINT 	:= TRB->BM1_CODINT
			TRB1->TR1_CODEMP 	:= TRB->BM1_CODEMP     
            TRB1->TR1_MATRIC    := TRB->BM1_MATRIC 
            TRB1->TR1_TIPREG    := TRB->BM1_TIPREG
            TRB1->TR1_DIGITO	:= TRB->BM1_DIGITO 
            
            TRB1->TR1_DTEMIS    := TRBBA1->E1_EMISSAO  
            TRB1->TR1_DTVCT     := TRBBA1->E1_VENCTO 
            TRB1->TR1_DTBXA     := TRBBA1->E1_BAIXA 
            TRB1->TR1_NUMBOR    := TRBBA1->E1_NUMBOR 
            TRB1->TR1_CODCLI    := TRBBA1->E1_CLIENTE                                
            TRB1->TR1_MESBAS    := TRBBA1->E1_MESBASE
            TRB1->TR1_ANOBAS    := TRBBA1->E1_ANOBASE  
            
            TRB1->TR1_NOMUSR    := TRB->A1_NOME
            TRB1->TR1_ENDERE    := TRB->A1_END
            TRB1->TR1_BAIRRO    := TRB->A1_BAIRRO
            TRB1->TR1_MUNICI    := TRB->A1_MUN
            TRB1->TR1_ESTADO    := TRB->A1_EST
            TRB1->TR1_CEP       := TRB->A1_CEP
            TRB1->TR1_DDD       := TRB->A1_DDD 
            TRB1->TR1_YTEL2     := TRB->A1_TEL
            TRB1->TR1_YCEL      := TRB->A1_FAX    
 
			_CODINT := TRB->BM1_CODINT
            _CODEMP := TRB->BM1_CODEMP 
            _MATRIC := TRB->BM1_MATRIC 
            _TIPREG := TRB->BM1_TIPREG
            _DIGITO := TRB->BM1_DIGITO
			 
            TRB1->TR1_NOMUSU    := TRB->BA1_NOMUSR
            TRB1->TR1_DATBLO    := TRB->BA1_DATBLO  
            TRB1->TR1_MOTBLO    := TRB->BA1_MOTBLO

            _NOMUSR := TRB->BA1_NOMUSR
            _DATBLO := TRB->BA1_DATBLO   
            _MOTBLO := TRB->BA1_MOTBLO
						 
   			TRB1->TR1_PREFIX	:= TRB->BM1_PREFIXO
			TRB1->TR1_NUM		:= TRB->BM1_NUMTIT
			TRB1->TR1_PARCEL	:= TRB->BM1_PARCEL
			TRB1->TR1_TIPO		:= TRB->BM1_TIPTIT   
		 
            If (nPos := Ascan(aContr, {|x| x[1] == TRB->(BM1_CODINT + BM1_CODEMP + BM1_MATRIC )})) == 0       
   	            Aadd(aContr, {TRB->(BM1_CODINT + BM1_CODEMP + BM1_MATRIC ),1})           
     	    Else 
  	            aContr[nPos][2]  += 1 
            EndIf 

      	
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza matriz com valores do plano                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If TRB->BM1_CODTIP $ '101, 118'		// Mensalidade
			TRB1->TR1_VLRMEN += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP $ '102,133'	// Opcionais
			TRB1->TR1_VLROPC += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP == '103'		// Taxa de adesao
			TRB1->TR1_VLRTAX += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP $ cCodigosPF	// Co-participacoes...
			TRB1->TR1_VLRPF  += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP == '909'		// Guia medico
			TRB1->TR1_VLRGUI += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP $ '107, 908'	// Cartao de identificaçao
			TRB1->TR1_VLRCAR += TRB->BM1_VALOR
			
		Elseif Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")	// Farmacia
			TRB1->TR1_VLRFAR += TRB->BM1_VALOR
			
		Elseif TRB->BM1_CODTIP $ cCodDB		// Debitos / creditos...
			If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
				If BFQ->BFQ_DEBCRE == '2' 	// Credito.
					TRB1->TR1_VLRCRE += TRB->BM1_VALOR
					
				Elseif BFQ->BFQ_DEBCRE == '1' // Debitos.
					TRB1->TR1_VLRDEB += TRB->BM1_VALOR
					
				Endif
			Endif
		Else
			TRB1->TR1_VLROUT += TRB->BM1_VALOR
			
		Endif

	 	nContador += 1
	 //	IncProcG3("Gravados " + nContador  ))
	 //	ProcessMessage()

		// Libera o registro...
		TRB1->( MsUnlock() )

		TRB->(DbSkip())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fim do laco...                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Enddo 

EndIf	
if nListar <> 1	.and. _CLIENTE <> TRBBA1->E1_CLIENTE	
_CLIENTE :=  TRBBA1->E1_CLIENTE	
////////////////////////////////////////////////
//  Pesquiza Fatura - Pelo Codigo do Cliente //
///////////////////////////////////////////////	
cQuery := "SELECT  DISTINCT  e1_prefixo, e1_num,  e1_parcela , e1_tipo , e1_saldo ,e1_cliente, E1_EMISSAO , E1_VENCTO, e1_baixa, E1_ANOBASE, E1_MESBASE , A1_NOME ,   A1_END , A1_BAIRRO , A1_MUN , A1_EST, A1_CEP , A1_DDD , A1_TEL, A1_FAX "
cQuery += " FROM "  + RetSqlName("SE1") + " SE1 ,"  + RetSqlName("SA1") + " SA1" 
cQuery += " WHERE E1_FILIAL = '" + xFilial("SE1") + "' and  A1_FILIAL = '" + xFilial("SA1") + "' "    
cQuery += " AND SE1.D_E_L_E_T_ = ' ' AND SA1.D_E_L_E_T_ = ' '"   
cQuery += " AND (E1_PREFIXO  = 'FAT' OR E1_PREFIXO  = 'ANT' OR E1_PREFIXO  = 'PR ')"
If !empty (cTpNLis) 
   cQuery += " and e1_prefixo not in ( " + cTpNLis + " ) "
EndIf
//cQuery += " AND E1_TIPO     = 'FT' "  
If cTpPgto = 3 
   cQuery += " AND e1_saldo > 0  and e1_vencto < '"+ dVenc +"'" 
ElseIf cTpPgto = 2                                       
   cQuery += " AND e1_saldo > 0  "                                                  
ElseIf cTpPgto = 1                                       
   cQuery += " AND e1_saldo = 0  "
EndIf                                                      

                                                                                 
                     
//cQuery += " AND E1_SALDO > 0  "                      
cQuery += " AND E1_CLIENTE  =  '"+TRBBA1->E1_CLIENTE+"' "  
cQuery += " AND E1_CLIENTE  =  A1_COD"                              
cQuery += " AND E1_ANOBASE||E1_MESBASE <='"+ substr (dDtinicio,1,6)+"'"
cQuery += " AND E1_ANOBASE||E1_MESBASE <='"+ substr (dDtFim,1,6)+"'"

//////////////////////////////////////////////////////////////

PlsQuery(cQuery, "TMP")	

///////////////////////////
/*    if !TMP->( Eof() )            
       If (nPos := Ascan(aContr, {|x| x[1] == (_CODINT + _CODEMP + _MATRIC )})) == 0      
	       Aadd(aContr, {(_CODINT + _CODEMP + _MATRIC ),1})           
   	   Else 
  	       aContr[nPos][2]  += 1 
       EndIf 
    EndIf   
*/	
	While !TMP->( Eof() ) 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	    //³ Apresenta mensagem em tela...                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncProcG2("Processando Familia - " + _CODINT + '.' + _CODEMP + '.' + _MATRIC + '.' + _TIPREG  + '.' + _DIGITO + " - "+Transform(nTotal, "@E 999,999,999,999.99"))
		ProcessMessage()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alimenta o arquivo temporario...                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
			
		
   	    If nAnalitico > 1 
  	       cChave := (_CODINT + _CODEMP + _MATRIC) + TMP->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO) 	
		Else
           cChave := (_CODINT + _CODEMP + _MATRIC )
		Endif
					
	
		lFound := TRB1->( MsSeek( cChave ) )
		
		TRB1->( RecLock("TRB1", !lFound) )

		If !lFound            
							 
			TRB1->TR1_CODINT 	:= _CODINT
			TRB1->TR1_CODEMP 	:= _CODEMP     
            TRB1->TR1_MATRIC    := _MATRIC 
            TRB1->TR1_TIPREG    := _TIPREG
            TRB1->TR1_DIGITO	:= _DIGITO   
            
            TRB1->TR1_NOMUSR    := TMP->A1_NOME
            TRB1->TR1_ENDERE    := TMP->A1_END
            TRB1->TR1_BAIRRO    := TMP->A1_BAIRRO
            TRB1->TR1_MUNICI    := TMP->A1_MUN
            TRB1->TR1_ESTADO    := TMP->A1_EST
            TRB1->TR1_CEP       := TMP->A1_CEP
            TRB1->TR1_DDD       := TMP->A1_DDD 
            TRB1->TR1_YTEL2     := TMP->A1_TEL
            TRB1->TR1_YCEL      := TMP->A1_FAX    
            
            
            TRB1->TR1_DTEMIS    := TMP->E1_EMISSAO  
            TRB1->TR1_DTVCT     := TMP->E1_VENCTO 
            TRB1->TR1_DTBXA     := TMP->E1_BAIXA 						 
            TRB1->TR1_NOMUSU    := _NOMUSR
            TRB1->TR1_DATBLO    := _DATBLO  
            TRB1->TR1_MOTBLO    := _MOTBLO
   
   			TRB1->TR1_PREFIX	:= TMP->E1_PREFIXO
			TRB1->TR1_NUM		:= TMP->E1_NUM
			TRB1->TR1_PARCEL	:= TMP->E1_PARCELA
			TRB1->TR1_TIPO		:= TMP->E1_TIPO 
			TRB1->TR1_MESBAS    := TMP->E1_MESBASE
            TRB1->TR1_ANOBAS    := TMP->E1_ANOBASE  
     		If (nPos := Ascan(aContr, {|x| x[1] == (_CODINT + _CODEMP + _MATRIC)})) == 0 
		       Aadd(aContr, {(_CODINT + _CODEMP + _MATRIC),1})        
  	        Else   
	           aContr[nPos][2]  += 1 
            EndIf 	   
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza matriz com valores do plano                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		// SALDO - FATURA  
		TRB1->TR1_VLRMEN += TMP->E1_SALDO 
			
	

		// Libera o registro...
		TRB1->( MsUnlock() )
		

		TMP->(DbSkip())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fim do laco...                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Enddo  
	TMP->( dbCloseArea() )        
EndIf
/////////////////////////// 
if nListar <> 2			
	TRB->( dbCloseArea() )            	
EndIf 
	TRBBA1->( dbSkip() )

Enddo

/*
10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
2007/10  999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999.99   999,999.99   999,999,999.99   999,999,999.99  999,999,999.99
Plano
Referen.         Contr.        Opcionais        Tx Adesao          Debitos         Creditos     Participacao           Tarifa         Farmacia  Guia Medico       Cartão           Outros          Liquido        
9999-999999999999999999999999999999
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa impressao                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLi := 1000
TRB1->( dbGotop() )

cAnoMes := ''
While !TRB1->( Eof() )
	 
	
	nPos1 := Ascan(aContr, {|x| x[1] == TRB1->(TR1_CODINT + TR1_CODEMP + TR1_MATRIC )}) 
 //	If   aContr[nPos1][2] < nQtdaSai
 	If aContr[nPos1][2] < nQtdaInc  .or. aContr[nPos1][2] > nQtdaFim      //ajustado a pedido da keila para trazer um intervalo de titulos em aberto  
	   //  aContr[nPos][2]  += 1                                          //afim de otimizar o trabalho - em 20/10/2010 - altamiro 
	     TRB1->( dbSkip() ) 
	     loop
	EndIf 	
	// Controle de saldo de pagina...
	If  nli > nQtdLin   
	
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			
		nli++
	Endif
	
	// Controle de quebra...    
   	cQuebra   :=    TRB1->TR1_CODINT + TRB1->TR1_CODEMP + TRB1->TR1_MATRIC
	cDesQuebr := 	TRB1->TR1_CODINT + '.' + TRB1->TR1_CODEMP + '.' + TRB1->TR1_MATRIC + '.' + TRB1->TR1_TIPREG + '.' + TRB1->TR1_DIGITO + ' - ' + TRB1->TR1_NOMUSU 
	
	// Imprime matricula .     
If nAnalitico < 3	
	If TRB1->TR1_MOTBLO <> '003'
 	   @ nLi, 000 Psay '==> ' + cDesQuebr + ' *** Codigo do Cliente : ' + TRB1->TR1_CODCLI
 	Else                                                                                  
 	   @ nLi, 000 Psay '==> ' + cDesQuebr + ' *** Codigo do Cliente : ' + TRB1->TR1_CODCLI + '                        *** Bloqueado em : '+ dtoc(TRB1->TR1_DATBLO)
 	EndIf   
 	nLi += 1   
    If  nDadCon  = 1
     	@ nLi, 000 Psay 'Nome : '+ TRB1->TR1_NOMUSR +' End : '+ TRB1->TR1_ENDERE  +'  Bairro : '+ TRB1->TR1_BAIRRO +'  CEP : '+TRB1->TR1_CEP +'  Munic : '+TRB1->TR1_MUNICI + '  Estado : '+TRB1->TR1_ESTADO  +'  DDD: '+TRB1->TR1_DDD  +'  Tel : '+TRB1->TR1_YTEL2
     	nLi += 1                                                                          
   	    @ nLi, 000 Psay Replicate('-', nLimite)   	
        nLi += 1 
    EndIf                                                                              
EndIf      
//ALTAMIRO 17/02/2011 - carta janela                                                                 
    ccab1:=ccab2:=ccab3:=ccab4:=ccab5:=cdet1:=ctit1:=ctit2:=ctit3:= " "
//     
	While !TRB1->( Eof() ) .and.  (TRB1->TR1_CODINT + TRB1->TR1_CODEMP + TRB1->TR1_MATRIC) == cQuebra
	      nTotLinha := 0
			
		  nFator := (((TRB1->TR1_VLRBAI * 100) / TRB1->TR1_VALTIT) / 100)
		  If TRB1->TR1_VLRBAI > 0 // Se o valor da baixa for menor que o valor do titulo, ativa rateio por coluna...
		   	 nTotal := TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+;
			   		   TR1_VLRFAR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)
            nTotal1 :=(Round((nTotal1 * nFator),2)) 
			nTotal := ((Round((TRB1->TR1_VLRMEN * nFator),3)) + (Round((TRB1->TR1_VLROPC * nFator),2)) + ;
					   (Round((TRB1->TR1_VLRTAX * nFator),2)) + (Round((TRB1->TR1_VLRDEB * nFator),2)) + ;
					   (Round((TRB1->TR1_VLRCRE * nFator),2)) + (Round((TRB1->TR1_VLRPF  * nFator),2)) + ;
					   (Round((TRB1->TR1_VLRTAR * nFator),2)) + (Round((TRB1->TR1_VLRFAR * nFator),2)) + ;
					   (Round((TRB1->TR1_VLRGUI * nFator),2)) + (Round((TRB1->TR1_VLRCAR * nFator),2)))
				// Altera os aplicando o fator sobre os valores ja apurados...
			TRB1->( RecLock("TRB1", .F.) )
			  	  TRB1->TR1_VLRMEN := (TRB1->TR1_VLRMEN - (Round((TRB1->TR1_VLRMEN * nFator),3))) 
				  TRB1->TR1_VLROPC := (TRB1->TR1_VLROPC - (Round((TRB1->TR1_VLROPC * nFator),2)))
				  TRB1->TR1_VLRTAX := (TRB1->TR1_VLRTAX - (Round((TRB1->TR1_VLRTAX * nFator),2)))
				  TRB1->TR1_VLRDEB := (TRB1->TR1_VLRDEB - (Round((TRB1->TR1_VLRDEB * nFator),2)))
				  TRB1->TR1_VLRCRE := (TRB1->TR1_VLRCRE - (Round((TRB1->TR1_VLRCRE * nFator),2)))
				  TRB1->TR1_VLRPF  := (TRB1->TR1_VLRPF  - (Round((TRB1->TR1_VLRPF  * nFator),2)))
				  TRB1->TR1_VLRTAR := (TRB1->TR1_VLRTAR - (Round((TRB1->TR1_VLRTAR * nFator),2)))
				  TRB1->TR1_VLRFAR := (TRB1->TR1_VLRFAR - (Round((TRB1->TR1_VLRFAR * nFator),2)))
				  TRB1->TR1_VLRGUI := (TRB1->TR1_VLRGUI - (Round((TRB1->TR1_VLRGUI * nFator),2)))
				  TRB1->TR1_VLRCAR := (TRB1->TR1_VLRCAR - (Round((TRB1->TR1_VLRCAR * nFator),2)))
					                                  
					// Recalcula valores
			nTotal := TRB1->(TR1_VLRMEN + TR1_VLROPC + TR1_VLRTAX + TR1_VLRDEB + TR1_VLRCRE +;
			          TR1_VLRPF + TR1_VLRTAR + TR1_VLRFAR + TR1_VLRGUI + TR1_VLRCAR)
					// Eh possivel existir diferenca de centavos em funcao do fator...					
			nDif := nTotal1 - nTotal 
					// Se existir diferenca, adicina na coluna de contra prestacao...
			If nDif > 0
			   TRB1->TR1_VLRMEN += nDif
    		Endif
		    TRB1->( MsUnlock() )
		  Endif				
			// Controle de saldo de pagina...
 		  If  nli > nQtdLin
 		  	
		      nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		      	
				nli++
	      Endif  
   	      If nAnalitico = 2 
   
     		 @ nLi, 000 Psay TRB1->(TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO)
				
			 @ nLi, 016 Psay Transform(TRB1->TR1_VLRMEN, pMoeda2); nTotMen += TRB1->TR1_VLRMEN; nTotGMen += TRB1->TR1_VLRMEN; nTotLinha += TRB1->TR1_VLRMEN
			 @ nLi, 032 Psay Transform(TRB1->TR1_VLROPC, pMoeda1); nTotOpc += TRB1->TR1_VLROPC; nTotGOpc += TRB1->TR1_VLROPC; nTotLinha += TRB1->TR1_VLROPC
			 @ nLi, 044 Psay Transform(TRB1->TR1_VLRTAX, pMoeda1); nTotAde += TRB1->TR1_VLRTAX; nTotGAde += TRB1->TR1_VLRTAX; nTotLinha += TRB1->TR1_VLRTAX
			 @ nLi, 056 Psay Transform(TRB1->TR1_VLRDEB, pMoeda2); nTotDeb += TRB1->TR1_VLRDEB; nTotGDeb += TRB1->TR1_VLRDEB; nTotLinha += TRB1->TR1_VLRDEB
			 @ nLi, 072 Psay Transform(TRB1->TR1_VLRCRE, pMoeda2); nTotCre += TRB1->TR1_VLRCRE; nTotGCre += TRB1->TR1_VLRCRE; nTotLinha -= TRB1->TR1_VLRCRE
			 @ nLi, 088 Psay Transform(TRB1->TR1_VLRPF , pMoeda2); nTotPF  += TRB1->TR1_VLRPF;  nTotGPF	+= TRB1->TR1_VLRPF ; nTotLinha += TRB1->TR1_VLRPF
			 @ nLi, 104 Psay Transform(TRB1->TR1_VLRTAR, pMoeda2); nTotTar += TRB1->TR1_VLRTAR; nTotGTar += TRB1->TR1_VLRTAR; nTotLinha += TRB1->TR1_VLRTAR
			 @ nLi, 120 Psay Transform(TRB1->TR1_VLRFAR, pMoeda2); nTotFar += TRB1->TR1_VLRFAR; nTotGFar += TRB1->TR1_VLRFAR; nTotLinha += TRB1->TR1_VLRFAR
			 @ nLi, 137 Psay Transform(TRB1->TR1_VLRGUI, pMoeda1); nTotGui += TRB1->TR1_VLRGUI; nTotGGui += TRB1->TR1_VLRGUI; nTotLinha += TRB1->TR1_VLRGUI
			 @ nLi, 149 Psay Transform(TRB1->TR1_VLRCAR, pMoeda1); nTotCar += TRB1->TR1_VLRCAR; nTotGCar += TRB1->TR1_VLRCAR; nTotLinha += TRB1->TR1_VLRCAR
			 @ nLi, 161 Psay Transform(TRB1->TR1_VLROUT, pMoeda1); nTotOut += TRB1->TR1_VLROUT; nTotGOut += TRB1->TR1_VLROUT; nTotLinha += TRB1->TR1_VLROUT
//			 @ nLi, 173 Psay Transform(nTotLinha, pMoeda2); nTotGrupo += nTotLinha //nTotLinha
//			 @ nLi, 189 Psay Transform(TRB1->TR1_VLRBAI, pMoeda2); nTotBai += TRB1->TR1_VLRBAI; nTotGBai += TRB1->TR1_VLRBAI
				
			 nSaldo := nTotLinha
			@ nLi, 173 Psay Transform(nSaldo, pMoeda2); nTotSld += nSaldo; nTotGSld += nSaldo   
			
			@ nLi, 189 Psay TRB1->TR1_DTEMIS   
			@ nLi, 199 Psay TRB1->TR1_DTVCT				
         	@ nLi, 209 Psay TRB1->TR1_DTBXA			
         	If TRB1->TR1_NUMBOR <> ' ' 		
               @ nLi, 219 Psay '*'
            Else                     
               @ nLi, 219 Psay ' '
               
            EndIf       
          	      //ALTAMIRO 17/02/2011 - carta janela      
   	         if ctit1 = " " 
   	            ctit1 := "(*)"+TRB1->(TR1_PREFIX + TR1_NUM )+"Emissao : " + dtoc(TRB1->TR1_DTEMIS) + " Vencto : " + dtoc(TRB1->TR1_DTVCT)+" Valor : R$" + Transform(nSaldo - (TRB1->TR1_VLRBAI)  ,"9,999.99")	 
   	         elseIf ctit2 = " "
   	            ctit2 := "(*)"+TRB1->(TR1_PREFIX + TR1_NUM )+"Emissao : " + dtoc(TRB1->TR1_DTEMIS) + " Vencto : " + dtoc(TRB1->TR1_DTEMIS)+" Valor : R$" + Transform(nSaldo - (TRB1->TR1_VLRBAI)  ,"9,999.99")	 	 
   	         else 
   	            ctit3 := "(*)"+TRB1->(TR1_PREFIX + TR1_NUM )+"Emissao : " + dtoc(TRB1->TR1_DTEMIS) + " Vencto : " + dtoc(TRB1->TR1_DTEMIS)+" Valor : R$" + Transform(nSaldo - (TRB1->TR1_VLRBAI)  ,"9,999.99")	 	 
   
   	         EndIf 
   	         ccab1:=TRB1->TR1_NOMUSR
	         ccab2:=DATE()
	         ccab3:=TRB1->TR1_ENDERE 
	         ccab4:= trim(TRB1->TR1_BAIRRO)+'-'+trim(TRB1->TR1_MUNICI)+'-'+trim(TRB1->TR1_ESTADO) 
	         ccab5:="Cep : " + TRB1->TR1_CEP     
	         //Aadd(aDados, {TRB1->TR1_NOMUSR,TRB1->TR1_ENDERE,"","",TRB1->TR1_CEP,trim(TRB1->TR1_MUNICI),trim(TRB1->TR1_ESTADO),trim(TRB1->TR1_BAIRRO), "" }) 
	     /*    Aadd(aDados, {TRB1->TR1_NOMUSR })                      
	         Aadd(aDados, {TRB1->TR1_ENDERE })                     	         
	         Aadd(aDados, {trim(TRB1->TR1_BAIRRO) + ' - ' + trim(TRB1->TR1_MUNICI) + ' - ' +  trim(TRB1->TR1_ESTADO)})                     
	         Aadd(aDados, {"CEP.: " + TRB1->TR1_CEP    })     
	         Aadd(aDados, {TRB1->TR1_DDD  })
	         Aadd(aDados, {TRB1->TR1_YTEL2}) 
             Aadd(aDados, {TRB1->TR1_YCEL })           
	         Aadd(aDados, { "" })                    
	      */                            
	       Aadd(aDados, {TRB1->TR1_NOMUSR ,;
	                     TRB1->TR1_ENDERE ,;                     	         
	                     trim(TRB1->TR1_BAIRRO) + ' - ' + trim(TRB1->TR1_MUNICI) + ' - ' +  trim(TRB1->TR1_ESTADO),;                     
	                     "CEP.: " + TRB1->TR1_CEP    ,;     
	                     TRB1->TR1_DDD  ,;
	                     TRB1->TR1_YTEL2 ,; 
                         TRB1->TR1_YCEL ,;
                         Transform(nSaldo, pMoeda2),;
                         TRB1->TR1_DTEMIS })                   
   	      //  
   	      Aadd(aDados1, {cDesQuebr,;       
   	                     TRB1->TR1_ANOBAS+'/'+TRB1->TR1_MESBAS, ;
   	                     TRB1->TR1_DDD  , ;
   	                     TRB1->TR1_YTEL2, ;
   	                     TRB1->TR1_YCEL , ;                                            
                         TRB1->(TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO),;
                         TRB1->TR1_VLRMEN,;
			             TRB1->TR1_VLROPC,;
			             TRB1->TR1_VLRTAX,;
			             TRB1->TR1_VLRDEB,;
  			           ((TRB1->TR1_VLRCRE)*-1),;
			             TRB1->TR1_VLRPF,;
                         TRB1->TR1_VLRTAR,; 
                         TRB1->TR1_VLRFAR,; 
                         TRB1->TR1_VLRGUI,; 
                         TRB1->TR1_VLRCAR,; 
                         TRB1->TR1_VLROUT,; 
                         nSaldo,;
                         TRB1->TR1_DTEMIS,;   
			             TRB1->TR1_DTVCT,;				
         	             TRB1->TR1_DTBXA}) 			
            	nli++
		elseIf nAnalitico = 1 
			// Totaliza por plano para imprimir em uma unica linha sintetica...
		    nTotMen 	+= TRB1->TR1_VLRMEN; nTotGMen += TRB1->TR1_VLRMEN; nTotLinha += TRB1->TR1_VLRMEN
		    nTotOpc 	+= TRB1->TR1_VLROPC; nTotGOpc += TRB1->TR1_VLROPC; nTotLinha += TRB1->TR1_VLROPC
		    nTotAde 	+= TRB1->TR1_VLRTAX; nTotGAde += TRB1->TR1_VLRTAX; nTotLinha += TRB1->TR1_VLRTAX
		    nTotDeb 	+= TRB1->TR1_VLRDEB; nTotGDeb += TRB1->TR1_VLRDEB; nTotLinha += TRB1->TR1_VLRDEB
		    nTotCre 	+= TRB1->TR1_VLRCRE; nTotGCre += TRB1->TR1_VLRCRE; nTotLinha -= TRB1->TR1_VLRCRE
		    nTotPF		+= TRB1->TR1_VLRPF;  nTotGPF  += TRB1->TR1_VLRPF ; nTotLinha += TRB1->TR1_VLRPF
		    nTotTar 	+= TRB1->TR1_VLRTAR; nTotGTar += TRB1->TR1_VLRTAR; nTotLinha += TRB1->TR1_VLRTAR
		    nTotFar 	+= TRB1->TR1_VLRFAR; nTotGFar += TRB1->TR1_VLRFAR; nTotLinha += TRB1->TR1_VLRFAR
		    nTotGui 	+= TRB1->TR1_VLRGUI; nTotGGui += TRB1->TR1_VLRGUI; nTotLinha += TRB1->TR1_VLRGUI
		    nTotCar 	+= TRB1->TR1_VLRCAR; nTotGCar += TRB1->TR1_VLRCAR; nTotLinha += TRB1->TR1_VLRCAR
		    nTotOut 	+= TRB1->TR1_VLROUT; nTotGOut += TRB1->TR1_VLROUT; nTotLinha += TRB1->TR1_VLROUT
		    nTotBai 	+= TRB1->TR1_VLRBAI; nTotGBai += TRB1->TR1_VLRBAI
		    nTotGrupo += nTotLinha
		//nTotSld	+= nSaldo; nTotGSld += nSaldo 
		    nTotSld	+= nTotLinha; nTotGSld += nTotLinha
		EndIf		
		nTotCMen += TRB1->TR1_VLRMEN
		nTotCOpc += TRB1->TR1_VLROPC
		nTotCAde += TRB1->TR1_VLRTAX
		nTotCDeb += TRB1->TR1_VLRDEB
		nTotCCre += TRB1->TR1_VLRCRE
		nTotCPF  += TRB1->TR1_VLRPF
		nTotCTar += TRB1->TR1_VLRTAR
		nTotCFar += TRB1->TR1_VLRFAR
		nTotCGui += TRB1->TR1_VLRGUI
		nTotCCar += TRB1->TR1_VLRCAR
		nTotCOut += TRB1->TR1_VLROUT
		nTotCPla += nTotLinha
		nTotCBai += TRB1->TR1_VLRBAI
		nTotCSld += nTotLinha
			
	    if nQtdaDia > 0
		   nIndJan:= NoRound ((( dDataBase - TRB1->TR1_DTVCT) / nQtdaDia),0) 
//	       aInter[nIndJan][1]  = (nIndjan*val(nQtdaDia)) 
//		   aInter[nIndJan][2]  = ((nIndjan*val(nQtdaDia)) + val(nQtdaDia))
//		   aInter[nIndJan][3]  += 1 
		   If (nPos := Ascan(aInter, {|x| x[1] == (nIndjan) })) == 0       
 /*             aInter[nIndJan][1]  = nIndjan		   
		      aInter[nIndJan][2]  = (nIndjan*nQtdaDia) 
		      aInter[nIndJan][3]  = ((nIndjan*nQtdaDia) + nQtdaDia)
		      aInter[nIndJan][4]  = 1
   */		   
   	           Aadd(aInter, {nIndjan,(nIndjan*nQtdaDia) ,((nIndjan*nQtdaDia) + nQtdaDia),1})           
     	   Else 
  	           aInter[nPos][4]  += 1 
           EndIf  
           
       EndIf  
        
	  		
		TRB1->( dbSkip() )
	Enddo
    If nAnalitico < 3
  	   @ nLi, 000 Psay "*Tot.Cliente" 

	   @ nLi, 017 Psay Transform(nTotCMen, pMoeda2)
	   @ nLi, 033 Psay Transform(nTotCOpc, pMoeda1)
	   @ nLi, 045 Psay Transform(nTotCAde, pMoeda1)
	   @ nLi, 057 Psay Transform(nTotCDeb, pMoeda2)
	   @ nLi, 073 Psay Transform(nTotCCre, pMoeda2)
	   @ nLi, 089 Psay Transform(nTotCPF , pMoeda2)
	   @ nLi, 105 Psay Transform(nTotCTar, pMoeda2)
	   @ nLi, 121 Psay Transform(nTotCFar, pMoeda2)
	   @ nLi, 138 Psay Transform(nTotCGui, pMoeda1)
	   @ nLi, 150 Psay Transform(nTotCCar, pMoeda1)
	   @ nLi, 162 Psay Transform(nTotCOut, pMoeda1)
	   @ nLi, 174 Psay Transform(nTotCSld, pMoeda2)
			
	   nLi ++
	   @ nLi, 000 Psay Replicate('-', nLimite)                   
	    //ALTAMIRO 17/02/2011 - carta janela   
	    
	   cdet1 := "R$" + Transform(nTotCSld  ,"9,999.99")+" - " + "(" + Extenso(nTotCSld ,.F.,1) + ")"                  
	                                                                                             
	   if mv_par23 = 1
	    //Chama rotina de carta   
	      if empty (ctit2)
            //lret := u_cartajanela(ccab1,ccab2,ccab3,ccab4,ccab5,cdet1,ctit1,ctit2,ctit3) 
                      u_cartajanela(ccab1,ccab2,ccab3,ccab4,ccab5,cdet1,ctit1,ctit2,ctit3)
          endIf       
       EndIf   
 	    //		
	   nTotCMen := nTotCOpc := nTotCAde := nTotCDeb := nTotCCre := 0
	   nTotCPF  := nTotCTar := nTotCFar := nTotCGui := nTotCCar := 0
	   nTotCOut := nTotCPla := nTotcBai := nTotSql  := nTotCSld := 0
		
	//		nLi += 2   
        nLi += 1
	EndIf	
Enddo                           
 if mv_par24 = 1
    //gera excel para etiquetas
	DlgToExcel({{"ARRAY","Gravações da Filial" ,aCabec1,aDados}})
	    //////	                     
 EndIf 	   
 If nExcel = 1                                                   
    DlgToExcel({{"ARRAY","Gravações da Filial" ,aCabec1,aDados1}}) 
 EndIf   
	// Controle de saldo de pagina...
	
	// Reinicia as variaveis totalizadoras...
	nTotMen := nTotOpc := nTotAde := nTotDeb := 0
	nTotCre := nTotPF  := nTotTar := nTotFar := 0
	nTotJur := nTotTit := nTotOut := nTotGrupo := 0
	nTotGui := nTotCar := nTotGrupo := nTotBai := 0
	nTotSld := 0
	
// Imprime os totais gerais


If  nli > nQtdLin
	
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		
	nli++
Endif
If nAnalitico < 3
   // Imprime o total do plano, finalizando a quebra...
   @ nLi, 000 Psay "Total geral "
   @ nLi, 016 Psay Transform(nTotGMen, pMoeda2)
   @ nLi, 032 Psay Transform(nTotGOpc, pMoeda1)
   @ nLi, 044 Psay Transform(nTotGAde, pMoeda1)
   @ nLi, 056 Psay Transform(nTotGDeb, pMoeda2)
   @ nLi, 072 Psay Transform(nTotGCre, pMoeda2)
   @ nLi, 088 Psay Transform(nTotGPF , pMoeda2)
   @ nLi, 104 Psay Transform(nTotGTar, pMoeda2)
   @ nLi, 120 Psay Transform(nTotGFar, pMoeda2)
   @ nLi, 137 Psay Transform(nTotGGui, pMoeda1)
   @ nLi, 149 Psay Transform(nTotGCar, pMoeda1)
   @ nLi, 161 Psay Transform(nTotGOut, pMoeda1)
// @ nLi, 173 Psay Transform(nTotGeral, pMoeda2)
// @ nLi, 189 Psay Transform(nTotGBai, pMoeda2)  
   @ nLi, 173 Psay Transform(nTotGSld, pMoeda2)

   nLi++
   @ nLi, 000 Psay Replicate('-', nLimite)
endif 
If nAnalitico >1   
  if nQtdaDia > 0
       nli++
     @ nLi, 030 Psay "resumo por intervalor de  atraso"
       nli++                                                  
     @ nLi, 000 Psay Replicate('-', nLimite)                
       nli++
     @ nLi, 035 Psay "De         Ate         Qtda"     
       nli++                                               
       i = 1      
       
       	aSort( aInter,,,{|x,y| x[1] < y[1]} )            
       
       While i <= len(aInter) 
          @ nLi, 035 Psay aInter[i][2] 
          @ nLi, 046 Psay aInter[i][3]
          @ nLi, 058 Psay aInter[i][4]     
            nli++   
            i++                                                                                              
   	   Enddo 
   EndIf   	 
EndIf   
                    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodape...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,Space(10))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha area de trabalho...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRBBA1->( dbClosearea() )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza e elimina o arquivo fisico do temporario...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRB1->( dbCloseArea() )
FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())
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

Static Function CriaSX1()

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Operadora      ? ","","","mv_ch1","C", 04,0,0,"G",""           ,"mv_par01",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Cod. Bloqueio    ","","","mv_ch2","C", 03,0,0,"G",""           ,"mv_par02",""           ,"","","","",""            	  ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Gr.Empr.Inicial? ","","","mv_ch3","C", 04,0,0,"G",""           ,"mv_par03",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})  
aadd(aRegs,{cPerg,"04","Gr.Empr.Final  ? ","","","mv_ch4","C", 04,0,0,"G",""           ,"mv_par04",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""}) 
aadd(aRegs,{cPerg,"05","Data  De       ? ","","","mv_ch5","D", 10,0,0,"G",""           ,"mv_par05",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""}) 
aadd(aRegs,{cPerg,"06","Data  Ata      ? ","","","mv_ch6","D", 10,0,0,"G",""           ,"mv_par06",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"07","Listar         ? ","","","mv_ch7","N", 01,0,0,"C",""           ,"mv_par07","Tit. PLS "  ,"","","","","Faturas"         ,"","","","","PLS / Fatura"  ,"","","","",""       ,"","","","","","","","",""   ,""})                                                                                                                                
aadd(aRegs,{cPerg,"08","Gerar Ecxel    ? ","","","mv_ch8","N", 01,0,0,"C",""           ,"mv_par08","Sim"        ,"","","","","Nao"             ,"","","","",""              ,"","","","",""       ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"09","Tipo de Relat. ? ","","","mv_ch9","N", 01,0,0,"C",""           ,"mv_par09","Sintetico"  ,"","","","","Analitico"       ,"","","","","Resumo"              ,"","","","",""		,"","","","","","","","",""   ,""})


aadd(aRegs,{cPerg,"10","Pref. NAO Sair     ","","","mv_ch10","C", 20,0,0,"G",""        ,"mv_par10",""           ,"","","","",""                ,"","","","",""           ,"","","","",""		,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"11","Qtda. p/Considerar ","","","mv_ch11","N", 02,0,0,"G",""        ,"mv_par11",""           ,"","","","",""                ,"","","","",""           ,"","","","",""		,"","","","","","","","",""   ,""})   
aadd(aRegs,{cPerg,"12","Tipo Pessoa      ? ","","","mv_ch12","N", 01,0,0,"C",""        ,"mv_par12","Fisica   "  ,"","","","","Juridica "       ,"","","","","Fisica/Juridica","","","","",""        ,"","","","","","","","",""   ,""})                                                                                                                                

aadd(aRegs,{cPerg,"13","Situação dos titulos ? ","","","mv_ch13","N", 01,0,0,"C",""    ,"mv_par13","Pagos  "     ,"","","","","Não Pagos "     ,"","","","","Vencidos ","","","","","Ambos"             ,"","","","","","","","","",""})                                                                                                                                
 

aadd(aRegs,{cPerg,"14","Matricula  ? ","","","mv_ch14","C", 06,0,0,"G",""           ,"mv_par014",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"15","Tipo Reg   ? ","","","mv_ch15","C", 02,0,0,"G",""           ,"mv_par015",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"16","Digito Mat ? ","","","mv_ch16","C", 01,0,0,"G",""           ,"mv_par016",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","","",""})

aadd(aRegs,{cPerg,"17","Dados Contacto ? ","","","mv_ch17","N", 01,0,0,"C",""       ,"mv_par17","Sim "        ,"","","","","Não "     ,"","","","","","","","","",""      ,"","","","","","","","","",""})                                                                                                                                
                                                                                                           
aadd(aRegs,{cPerg,"18","Interv. de Atraso, Em Dias","","","mv_ch18","N", 03,0,0,"G","" ,"mv_par18",""            ,"","","","",""         ,"","","","","","","","","",""      ,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"19","Qtda. p/Considerar Inicial  ","","","mv_ch19","N", 02,0,0,"G",""        ,"mv_par19",""           ,"","","","",""                ,"","","","",""           ,"","","","",""		,"","","","","","","","",""   ,""})   
aadd(aRegs,{cPerg,"20","Qtda. p/Considerar Final    ","","","mv_ch20","N", 02,0,0,"G",""        ,"mv_par20",""           ,"","","","",""                ,"","","","",""           ,"","","","",""		,"","","","","","","","",""   ,""})   

aadd(aRegs,{cPerg,"21","Bloqueio De       ? ","","","mv_chl","D", 10,0,0,"G",""        ,"mv_par21",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""}) 
aadd(aRegs,{cPerg,"22","Bloqueio Até      ? ","","","mv_chm","D", 10,0,0,"G",""        ,"mv_par22",""           ,"","","","",""                ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"23","Gerar Carta       ? ","","","mv_ch23","N", 01,0,0,"C",""       ,"mv_par23","Sim "       ,"","","","","Não "     ,"","","","","","","","","",""      ,"","","","","","","","","",""})                                                                                                                                
aadd(aRegs,{cPerg,"24","Gerar Etiquetas   ? ","","","mv_ch24","N", 01,0,0,"C",""       ,"mv_par24","Sim "       ,"","","","","Não "     ,"","","","","","","","","",""      ,"","","","","","","","","",""})                                                                                                                                

PlsVldPerg( aRegs )

Return
