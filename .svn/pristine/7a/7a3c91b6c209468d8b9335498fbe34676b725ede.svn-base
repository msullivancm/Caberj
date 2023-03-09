#INCLUDE "rwmake.ch"    
#INCLUDE "topconn.ch"                                                                                                 

#include "PLSMGER.CH"      
#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

Static cCodDB     := PLSRETLADC()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ CRJR004 ³ Autor ³ Geraldo Felix Junior   ³ Data ³ 24.11.00 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio de saldo pendente...                             ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ CRJR0004                                                   ³±±±
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
User Function CRJR004C()           

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variavaoeis...                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin 	:= 58
PRIVATE cNomeProg   := "CRJR004C"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Relatorio de Contas a Receber -  Por Plano e Cliente - saldos pendentes em :"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "BA3"
PRIVATE cPerg       := "CR004C"
PRIVATE cRel        := "CRJR04C"
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
PRIVATE nVlDeb      := 0.00
PRIVATE nEmpAtu     := substr(cNumEmp,1,2)
PRIVATE _cAliasBM1  := " "      
PRIVATE cMotBx      := " " 
PRIVATE lbloq       := .F.   
private Ddtdisp     :=  ctod("  /  /  ") 

/*
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Referen.                Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cartão      Outros         Liquido        Baixados           Saldo
PLS999999 999   999,999,999.99  999,999.99  999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99   999,999.99  999,999.99  999,999.99  999,999,999.99  999,999,999.99  999,999,999.99

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
_cMes		:= mv_par02
_cAno  		:= mv_par03
_dBaixaAt   := mv_par04 
cCodPlaI 	:= mv_par05
cCodPlaF 	:= mv_par06
lAnalitico	:= .T.  //(mv_par07==1)
lListTit	:= .T.  //(mv_par08==1)
nIdent		:= mv_par09
nGeraExcel  := mv_par10   
nGeraExcl   := mv_par11 
nGeraconv   := mv_par12 
nCmpEms     := mv_par13 // 1 - competencia , 2 emissão  
nLisNcc     := mv_par14 // 1 - Sim , 2 Não       
dDateDe     := mv_par15
dDateAte    := mv_par16
nBaidis     := mv_par17 // 1 - data de Baixa , 2 data de Disponivel   

If nBaidis = 1                                                                       
	cCabec1 := "Plano                           "
//	                     1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20                                                                            
//      	    123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//	cCabec2 := "Referen.                Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cartão      Outros         Liquido        Baixados           Saldo"
	cCabec2 := "Referen.                Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cartão      Outros         Saldo      Emissao   Vencto    Baixa                    "

Else
	cCabec1 := "Plano                                                                                                                                                                         "
//	cCabec2 := "                        Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cartão      Outros         Liquido        Baixados           Saldo"
	cCabec2 := "Referen.                Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cartão      Outros         Saldo      Emissao   Vencto    Disponivel               "
	
Endif 

// Variaveis com o primeiro e ultimo dia do mes para controle de baixas...
if ! empty (_cMes   ) 
   dIniMes := cTod('01/'+_cMes+'/'+_cAno) 
   dFimMes := LastDay(dIniMes)
   dIniMes := dTos(dIniMes)
   dFimMes := dTos(dFimMes) 
EndIf   



If ! empty (_dBaixaAt)                          
     cDatacab:= dTos(_dBaixaAt)
Else                           
     cDatacab:= dFimMes
EndIf  
_dBaixaAt:=stod (cDatacab)

//cTitulo := AllTrim(cTitulo) + " - " + PLRETMES(Val(_cMes)) + "/" + _cAno   
cTitulo := AllTrim(cTitulo) + substr(cDatacab,7,2) + "/" + substr(cDatacab,5,2) + "/" + substr (cDatacab,1,4)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura Impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta RptStatus...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 /* */
 Proc2BarGauge({|| aCriticas := RJ002Imp()() }  , "Imprimindo...")         
 //  MsAguarde({|| RJ002Imp()},"Aguarde...","Processando Clientes",.T.)

//a:= RJ002Imp()
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
LOCAL pMoeda1	:= "@E 9,999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL nPos		:= 0
LOCAL nPosTit	:= 0
LOCAL aTitulos 	:= {}
LOCAL aPlaUsr	:= {}
LOCAL nPosPla	:= 0
LOCAL _cCodPla	:= " " 
LOCAL _cVerPla 	:= " "
LOCAL nTotLinha := 0
LOCAL nTitulos	:= 0
LOCAL aParc		:= {}
LOCAL lRateio 	:= .F.
LOCAL lFracao	:= .F.
LOCAL nH		:= 0
LOCAL aRateio	:= {}
LOCAL nSaldo	:= 0
LOCAL nSaldoSE5 := 0
Local aCabec    := {}
Local aDados    := {}	
Local aCampoTRB := {{ "TR1_CODIGO"      , "C", TamSX3("BM1_CODPLA")[1]	    , 0 },;
                    { "TR1_DESCRI" 	    , "C", TamSX3("BM1_DESPLA")[1]	    , 0 },;
                    { "TR1_ANO" 		, "C", TamSX3("BM1_ANO")[1]		    , 0 },;
                    { "TR1_MES"			, "C", TamSX3("BM1_MES")[1]		    , 0 },;  
                    { "TR1_DTEMIS"	    , "D", TamSX3("E1_EMISSAO")[1]		, 0 },;  
                    { "TR1_DTVCTO"	    , "D", TamSX3("E1_EMISSAO")[1]		, 0 },;
                    { "TR1_MOTBX"	    , "C", TamSX3("E5_MOTBX")[1]		, 0 },;
                    { "TR1_DTBXA"    	, "D", TamSX3("E1_EMISSAO")[1]		, 0 },; 
                    { "TR1_DTDIS"    	, "D", TamSX3("E1_EMISSAO")[1]		, 0 },; 
                    { "TR1_CODCLI"		, "C", TamSX3("E1_CLIENTE")[1]      , 0 },; 
                    { "TR1_NOMCLI"		, "C", TamSX3("E1_NOMCLI")[1]       , 0 },;
                    { "TR1_PREFIX"		, "C", TamSX3("E1_PREFIXO")[1]	    , 0 },; 
                    { "TR1_NUM"			, "C", TamSX3("E1_NUM")[1]		    , 0 },;
                    { "TR1_PARCEL"		, "C", TamSX3("E1_PARCELA")[1]	    , 0 },;
                    { "TR1_TIPO"		, "C", TamSX3("E1_TIPO")[1]		    , 0 },;     
                    { "TR1_CANCEL" 	    , "C", 1                    		, 0 },;
                    { "TR1_VALTIT"		, "N", TamSX3("E1_VALOR")[1]		, 2 },;
                    { "TR1_VLRBAI"		, "N", TamSX3("E1_VALOR")[1]		, 2 },;
                    { "TR1_NUMBCO"		, "C", TamSX3("E1_NUMBCO")[1]		, 0 },;
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
                    { "TR1_VLROUT"		, "N", TamSX3("BM1_VALOR")[1]		, 2 },;
                    { "TR1_VLRPAR" 	    , "N", TamSX3("BM1_VALOR")[1]		, 2 }}

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
_cAliasBM1 := Iif(cMotBx <> GetNewPar("MV_PLMOTBC","CAN"),"BM1","BMN")  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Expressao de filtro...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery := "SELECT  DISTINCT  (SE1.R_E_C_N_O_) SE1RECNO "
cQuery += "FROM " + RetSqlName("SE1")+" SE1 , "        
cQuery += RetSqlName("SE5")+" SE5 "

cQuery += "WHERE E1_FILIAL = '" + xFilial("SE1") + "'"                                          

cQuery += " AND ( E5_FILIAL  = '" + xFilial("SE5") + "' OR  TRIM(E5_FILIAL)IS NULL) "         
cQuery += " AND SE1.E1_PREFIXO = SE5.E5_PREFIXO(+) AND SE1.E1_NUM     = SE5.E5_NUMERO(+) AND SE1.E1_PARCELA = SE5.E5_PARCELA(+) "
cQuery += " AND SE1.E1_TIPO    = SE5.E5_TIPO(+) AND SE1.E1_CLIENTE = SE5.E5_CLIFOR(+) AND SE1.E1_LOJA    = SE5.E5_LOJA(+) "


//cQuery += " AND e1_cliente >= '028889' AND e1_cliente <= '028889' "   
                                                         
if nCmpEms = 1 
   cQuery += " AND ((e1_tipo <> 'PR ' and (TRIM(E1_ANOBASE) || TRIM(E1_MESBASE) <= '" + _cAno + _cMes + "')) "
   cQuery += "  or  (TRIM(E1_ANOBASE) || TRIM(E1_MESBASE) = ' ') "
   cQuery += "  or  (e1_tipo =  'PR ' and TRIM(substr(e1_emissao ,1,6)) <= '" + _cAno + _cMes + "' ))" 
   
                                                          
//   cQuery += "  AND TRIM(E1_ANOBASE) || TRIM(E1_MESBASE) <= '" + _cAno + _cMes + "' "    // alterado segundo orientação do bira em 06/09/2011
else
   cQuery += " AND E1_emissao <= '" + cDatacab + "' "  // alterado segundo orientação do bira em 06/09/2011
EndIf
////
//cQuery += " AND E1_emissao <= '" + dFimMes+ "' "   // alterado segundo orientação do bira em 06/09/2011     

cQuery += " AND E1_emissao >= '"+dtos(dDateDe)+"' AND E1_emissao <= '"+dtos(dDateAte)+"'" 

//cQuery += "and  ((e1_saldo <> 0) or ((e1_baixa > '" + cDatacab  + " ') and (e1_movimen > '" + cDatacab  + " '))) 

cQuery += " and  ((e1_saldo <> 0) or( "
if nBaidis = 1
   cQuery += "e1_baixa > '" + cDatacab  + " ' "
Else 
   cQuery += "SE5.E5_DTDISPO >= '" + cDatacab  + " ' "
EndIF 
cQuery += "))"  

// Expressao de filtro do prefixo... deve se considerar apenas os prefixos do PLS.
//cQuery += " AND (E1_PREFIXO IN "+FormatIn(cPrefixos,";") 
cQuery += " AND E1_PREFIXO IN ('PLS' ,'CFD','FAT','ANT')" //"+FormatIn(cPrefixos,";") 

// Nao considera abatimentos
cQuery += " AND E1_TIPO NOT IN " + FormatIn(MVABATIM,"|")               
///
//cQuery += " AND E1_prefixo = 'PLS' "         
//
cQuery += " AND SE1.D_E_L_E_T_ = ' 'AND TRIM (SE5.D_E_L_E_T_) IS NULL   "
if nLisNcc = 2
   cQuery += " AND E1_TIPO <> 'NCC' "
EndIf    
//// aki selecção direta                         
//cQuery += " AND E1_num in ('001307062' ) "                                       
// seta a ordem de acordo com a opcao do usuario
 cQuery += " ORDER BY SE1RECNO "
//cQuery += " ORDER BY E1_EMISSAO ,E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO "     

TCQuery cQuery Alias "TRBSE1" New
//PlsQuery(cQuery, "TRBSE1")

nQtd:=0             
/* */
TRBSE1->(DBEval( { | | nQtd ++ }))
BarGauge1Set(nQtd)

TRBSE1->(DbGoTop())

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

If lListTit
	If nIdent == 1
	//	IndRegua("TRB1",cInd1TRB,"TR1_CODIGO + TR1_ANO + TR1_MES + TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO",,,"Indexando Arquivo de Trabalho") 
		IndRegua("TRB1",cInd1TRB," TR1_CODIGO + TR1_CODCLI + TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO",,,"Indexando Arquivo de Trabalho")
	Else
		IndRegua("TRB1",cInd1TRB,"TR1_CODIGO + TR1_CODCLI +  TR1_ANO + TR1_MES + TR1_NUMBCO",,,"Indexando Arquivo de Trabalho")
		
	Endif
	
Else
	IndRegua("TRB1",cInd1TRB,"TR1_CODIGO + TR1_CODCLI + TR1_CODIGO + TR1_ANO + TR1_MES",,,"Indexando Arquivo de Trabalho")
	
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
/* */
BarGauge2Set(1)

While ! TRBSE1->(Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posicion o registro fisicamente no SE1...                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SE1->( dbGoto(TRBSE1->SE1RECNO) )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apresenta mensagem em tela...                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ       

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o titulo sofreu movimentacao                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nBaixa := 0
	lCanc := .F.  //altamiro  .                                                 
/*altamiro 25/05/2012 --- aki 	
//if nCmpEms  = 1	 
// 	if (SE1->e1_saldo > 0) .or. (!empty (SE1->e1_baixa) .and. (dtos(SE1->e1_baixa) >=(dtos(_dBaixaAt))))
// 	   IF SE1->E1_PREFIXO = 'PLS'
// 	      IF (!empty (SE1->e1_baixa) .and. (dtos(_dBaixaAt)) >= (dtos(SE1->e1_baixa))) .and. se1->e1_saldo = 0 
// 	         TRBSE1->(dbSkip())	
//		     Loop			
//		  EndIf   
// 	   ElseIF (dtos(SE1->e1_baixa) <=(dtos(_dBaixaAt))) .and. se1->e1_saldo = 0          
//               TRBSE1->(dbSkip())	
//	 	       Loop			
//	   EndIf
///*	else      	
//       TRBSE1->(dbSkip())	
//       Loop			
//    EndIf        */
//else    
//    IF (!empty (SE1->e1_baixa) .and. (dtos(SE1->e1_baixa) <=(dtos(_dBaixaAt)))) .and. se1->e1_saldo = 0         
//        TRBSE1->(dbSkip())	
//	    Loop			
//	EndIf 
//EndIf	   
//ate aki 25/05/2012 */	   
 	IncProcG1('Processando titulo - ' + SE1->(E1_PREFIXO + '.' + E1_NUM + '.' + E1_PARCELA + E1_TIPO) + '  _  ' + substr(dtos(SE1->E1_emissao),7,2) + '/' + substr(dtos(SE1->E1_emissao),5,2) + '/' + substr(dtos(SE1->E1_emissao),1,4))
 	ProcessMessage()	
			
	SE5->(dbSetOrder(7))
	cMotBx:= ' '  
	Ddtdisp := ctod('  /  /  ') 
    If  SE5->( MsSeek(xFilial("SE5")+SE1->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + E1_CLIENTE + E1_LOJA)) )
	    lCanc := .F.
	    While ! SE5->(eof()) .and. SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) == ;
											 xFilial("SE5")+SE1->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + E1_CLIENTE + E1_LOJA)
			
//			If TemBxCanc(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ),.T.)
//				SE5->(dbSkip())	
//				Loop
	
//			If SE5->E5_MOTBX == GetNewPar("MV_PLMOTBC","CAN")
//				lCanc := .T. // indica que o titulo foi baixado por motivo de cancelamento
//				SE5->(dbSkip())	
//				Loop			
			
			//Elseif Alltrim(SE5->E5_TIPODOC) $ 'DC,D2,JR,J2,TL,MT,M2,CM,C2,TR,TE' 
		    if Alltrim(SE5->E5_TIPODOC) $ 'D2,J2,TL,MT,M2,CM,C2,TR,TE'
				SE5->(dbSkip())	
				Loop
							
//			ElseIf (dTos(SE5->E5_DATA) <= (dTos(_dBaixaAt)))    
			ElseIf (dTos(SE5->E5_DTDISPO) <= (dTos(_dBaixaAt)))
				If SE5->E5_RECPAG == 'R'
					nBaixa += SE5->E5_VALOR
				Else
					nBaixa -= SE5->E5_VALOR
				Endif				
			Endif  
            Ddtdisp :=se5->e5_dtdispo
			cMotBx  :=SE5->E5_MOTBX
			SE5->(dbSkip())
		Enddo	

		// Titulo sera desconsiderado por ter sido baixado por cancelamento..
		If lCanc
			TRBSE1->( dbSkip() )
			Loop
		Endif
	 
		// O titulo encontra-se baixado, porem nao existe baixas ate o final da competencia do titulo...
		nSaldoSE5 := (SE1->E1_VALOR - nBaixa)
		If nSaldoSE5 <= 0 
			TRBSE1->( dbSkip() )
			Loop
		Endif  
			
     Endif    
//   EndIF   // altamiro 
	If nBaixa == 0
		nTotal += SE1->E1_VALOR
		
	Elseif nBaixa > 0
		nTotal += nBaixa
		
	Elseif nBaixa < 0
		nTotal -= nBaixa
		
	Endif
	nTotal3 += SE1->E1_SALDO
		
	lRateio 	:= .F.
	lFracao	:= .T.
	aRateio 	:= {}
	nQtd		:= 0
	
 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 //³ trata tipo diferentes do pls , nao nativos do pls  , orientação bira ³
 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
//    if SE1->E1_CLIENTE  == '028889'        
//       a:='b''
//    EndIf   
    If SE1->E1_PREFIXO  = 'FAT' .or. SE1->E1_PREFIXO = 'CFD' .or. SE1->E1_PREFIXO = 'ANT'
       Do Case
          Case SE1->E1_PREFIXO = 'FAT' 
               _cCodPla := '1000'            
               DESCRI   := 'FATURA'     
          Case SE1->E1_PREFIXO = 'CFD'
               _cCodPla  := '1001'
               DESCRI    := 'Coop. Folha DiRigida' 
          Case SE1->E1_PREFIXO = 'ANT'
               _cCodPla  := '1002'
               DESCRI    := 'Tit. Saude Anterior Microsiga'     
       EndCase	    
       If nIdent == 1
   		  cChave := _cCodPla + substr(dtos(SE1->E1_emissao),1,4) + substr(dtos(SE1->E1_emissao),5,2) + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO		
	   Else
	      cChave := _cCodPla + substr(dtos(SE1->E1_emissao),1,4) + substr(dtos(SE1->E1_emissao),5,2) +Iif(!Empty(SE1->E1_NUMBCO), SE1->E1_NUMBCO, SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))		
       Endif
					
	  //	 MsProcTxt("Processando ...." + _cCodPla + SE1->E1_CLIENTE + SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+"   R E C N O : "+TRBSE1->SE1RECNO))
		lFound := TRB1->( MsSeek( cChave ) )
		
		TRB1->( RecLock("TRB1", !lFound) )  
		
		If !lFound
			TRB1->TR1_CODIGO 	:= _cCodPla
			TRB1->TR1_DESCRI 	:= DESCRI
	        TRB1->TR1_CODCLI    := SE1->E1_CLIENTE 
			TRB1->TR1_NOMCLI    := SE1->E1_NOMCLI    
            TRB1->TR1_MOTBX     := cMotBx
            TRB1->TR1_DTDIS     := Ddtdisp
	//trata competencia pls	  21/10/10	
	     if nCmpEms  = 1               
			IF SE1->E1_PREFIXO = 'PLS'   
			   TRB1->TR1_ANO		:= SE1->E1_anobase  
			   TRB1->TR1_MES		:= SE1->E1_mesbase
			Else                           
   			   TRB1->TR1_ANO		:= substr(dtos(SE1->E1_emissao),1,4)  
			   TRB1->TR1_MES		:= substr(dtos(SE1->E1_emissao),5,2)
			EndIf
         Else                           
   		    TRB1->TR1_ANO		:= substr(dtos(SE1->E1_emissao),1,4)  
		    TRB1->TR1_MES		:= substr(dtos(SE1->E1_emissao),5,2)	
		 EndIf   
			TRB1->TR1_VLRTAR	:= SE1->E1_DECRESC
			TRB1->TR1_VALTIT	:= SE1->E1_VALOR
			TRB1->TR1_PREFIX	:= SE1->E1_PREFIXO
			TRB1->TR1_NUM		:= SE1->E1_NUM
			TRB1->TR1_PARCEL	:= SE1->E1_PARCELA
			TRB1->TR1_TIPO		:= SE1->E1_TIPO                             
			TRB1->TR1_DTEMIS    := SE1->E1_EMISSAO 
            TRB1->TR1_DTVCTO    := SE1->E1_VENCREA
            TRB1->TR1_DTBXA     := SE1->E1_BAIXA
            TRB1->TR1_DTDIS     := Ddtdisp

         // Caso so exista um plano na composicao, grava o valor total da baixa e nao realiza o rateio...
	    	TRB1->TR1_VLRBAI	:= nBaixa
			
			If !Empty(SE1->E1_NUMBCO)
				TRB1->TR1_NUMBCO	:= SE1->E1_NUMBCO
			Else
				TRB1->TR1_NUMBCO	:= SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
			Endif		
		Endif      
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza matriz com valores do plano                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SE1->E1_PREFIXO = 'FAT'	.or. SE1->E1_PREFIXO = 'ANT'// Mensalidade
			TRB1->TR1_VLRMEN += SE1->E1_valor  
		Elseif 	SE1->E1_PREFIXO = 'CFD'	// Co-participacoes...
			TRB1->TR1_VLRPF  += SE1->E1_valor         		
			
		Endif

		// Libera o registro...
		TRB1->( MsUnlock() )
		 
		

    Else  
    	_cAliasBM1 := Iif(cMotBx <> GetNewPar("MV_PLMOTBC","CAN"),"BM1","BMN")                                                                      
		cSql := "SELECT Distinct("+_cAliasBM1+"_CODPLA) AS BM1_CODPLA "
        cSql += "FROM "+RetSqlName(_cAliasBM1)+" BM1  "  //+RetSqlName("BA1")+" BA1 "
	  
		cSql += "WHERE "+_cAliasBM1+"_FILIAL = '"+xFilial(_cAliasBM1)+"' " 
		
		//cSql += "AND BA1_FILIAL = '"+xFilial("BA1")+"' "
		
		cSql += "AND "+_cAliasBM1+"_PREFIX = '"+SE1->E1_PREFIXO+"' "
		cSql += "AND "+_cAliasBM1+"_NUMTIT = '"+SE1->E1_NUM+"' "
		cSql += "AND "+_cAliasBM1+"_PARCEL = '"+SE1->E1_PARCELA+"' "
		cSql += "AND "+_cAliasBM1+"_TIPTIT = '"+SE1->E1_TIPO+"' "
		cSql += "AND "+_cAliasBM1+"_CODTIP = '101' "      
	    cSql += "AND BM1.D_E_L_E_T_ = ' ' "
///// ALTAMIRO	       
//	    cSql += " AND "+_cAliasBM1+"_CODEMP = '0006' "
//        cSql += " AND "+_cAliasBM1+"_MATRIC = '006737' "

	PlsQuery(cSql, "TRB")
 	TRB->(DBEval( { | | nQtd ++ }))
	
	If	nQtd > 1 // Deve ter pelo menos 2 planos para que seja necessario fazer o rateio...
		lRateio := .T.
	Endif
	TRB->( dbCloseArea() )
	


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona a composicao do titulo...                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSql := "SELECT "+_cAliasBM1+"_CODINT as BM1_CODINT, "+_cAliasBM1+"_CODEMP as BM1_CODEMP, "+_cAliasBM1+"_MATRIC as BM1_MATRIC, "+_cAliasBM1+"_TIPREG  as BM1_TIPREG, BA1_NOMUSR, "+_cAliasBM1+"_CODTIP as BM1_CODTIP, "+_cAliasBM1+"_DESTIP as BM1_DESTIP, "
	cSql +=	" "+_cAliasBM1+"_CODEVE as BM1_CODEVE, "+_cAliasBM1+"_DESEVE  as BM1_DESEVE,"+_cAliasBM1+"_VALOR as BM1_VALOR,"+_cAliasBM1+"_PREFIX as BM1_PREFIX,"+_cAliasBM1+"_NUMTIT as BM1_NUMTIT,"+_cAliasBM1+"_PARCEL as BM1_PARCEL,"+_cAliasBM1+"_TIPTIT as BM1_TIPTIT, BA1_CODPLA, "
	cSql += " "+_cAliasBM1+"_CODPLA as BM1_CODPLA, "+_cAliasBM1+"_DESPLA as BM1_DESPLA,"+_cAliasBM1+"_VERPLA as BM1_VERPLA, BA1_VERSAO, "+_cAliasBM1+"_ANO as BM1_ANO,"+_cAliasBM1+"_MES as BM1_MES, "+_cAliasBM1+"_TIPO as BM1_TIPO , "+_cAliasBM1+"_NIVCOB as BM1_NIVCOB "
	cSql += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName(_cAliasBM1)+" BM1 "
	cSql += "WHERE BA1_FILIAL(+) = '"+xFilial("BA1")+"' "
	cSql += "AND "+_cAliasBM1+"_FILIAL = '"+xFilial(_cAliasBM1)+"' "
	cSql += "AND "+_cAliasBM1+"_PREFIX = '"+SE1->E1_PREFIXO+"' "
	cSql += "AND "+_cAliasBM1+"_NUMTIT = '"+SE1->E1_NUM+"' "
	cSql += "AND "+_cAliasBM1+"_PARCEL = '"+SE1->E1_PARCELA+"' "
	cSql += "AND "+_cAliasBM1+"_TIPTIT = '"+SE1->E1_TIPO+"' "      
	cSql += "AND BM1.D_E_L_E_T_ = ' ' "
	cSql += "AND BA1.D_E_L_E_T_(+) = ' ' " 
/////
//    cSql += " AND BA1_CODEMP = '0006' "
//    cSql += " AND BA1_MATRIC = '006737' "

	cSql += "AND BA1_CODINT(+) = BM1."+_cAliasBM1+"_CODINT "
	cSql += "AND BA1_CODEMP(+) = BM1."+_cAliasBM1+"_CODEMP "
	cSql += "AND BA1_MATRIC(+) = BM1."+_cAliasBM1+"_MATRIC "
	cSql += "AND BA1_TIPREG(+) = BM1."+_cAliasBM1+"_TIPREG "   
	  
//	If nGeraExcl = 2 
//	   cSql += " AND BA1_MOTBLO  <>  '003'  "
//	EndIf

	cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "
	PlsQuery(cSql, "TRB")
	nQtd := 0 
	/* */
 	BarGauge2Set(nQtd)
	aPlaUsr := {}  
	
nVlDeb:= 0.00
if nEmpAtu == '02' .and. (TRB->bm1_nivcob <> '4' .or.	nQtd = 0)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona a Debitos e Creditos - Juros e Multas (baixa em atraso)        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
    	cSql := "SELECT Sum (bsq_valor) as VlDeb "
    	cSql += "FROM "+RetSqlName("BSQ")+" BSQ "
    	cSql += "WHERE BSQ_FILIAL = '"+xFilial("BSQ")+"' "
    	cSql += "AND BSQ_PREFIX = '"+SE1->E1_PREFIXO+"' "
    	cSql += "AND BSQ_NUMTIT = '"+SE1->E1_NUM+"' "
    	cSql += "AND BSQ_PARCEL = '"+SE1->E1_PARCELA+"' "
    	cSql += "AND BSQ_TIPTIT = '"+SE1->E1_TIPO+"' "
    	cSql += "AND (BSQ_CODLAN = '993' or BSQ_CODLAN = '991') " 
    	cSql += "AND BSQ.D_E_L_E_T_ = ' ' "	
	
       If Select("TMP") > 0
          dbSelectArea("TMP")
	      dbclosearea()
       Endif                

       TCQuery cSql Alias "TMP" New
       dbSelectArea("TMP") 
       
       nVlDeb:= TMP->VlDeb	
       dbclosearea()
 //      If TRB->BM1_CODPLA  = ' ' 
 //         TRB->BM1_CODPLA := '0001'
 //      EndIf 
EndIf
		
	While !TRB->( Eof() )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apresenta mensagem em tela...                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//	IncProcG2("Processando Familia - "+ TRB->(BM1_CODINT + '.' + BM1_CODEMP + '.' + BM1_MATRIC )+" - "+Transform(SE1->E1_VALOR, "@E 999,999,999,999.99"))
	//	ProcessMessage()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona a familia do usuario                                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) <> BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)
			BA3->( MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)) )
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Defini qual o plano do usuario...                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		_cCodPla := ''
		_cVerPla := ''
		
		// Regra numero um: Utiliza o plano do BM1.
		If !Empty(TRB->BM1_CODPLA) .and. !Empty(TRB->BM1_VERPLA)
			_cCodPla := TRB->BM1_CODPLA
			_cVerPla := TRB->BM1_VERPLA
			
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
		
		If nGeraExcl = 2    
		   lbloq:= .T. 
	       If (empty(BA3->BA3_DATBLO) .or. BA3->BA3_DATBLO > stod(cDatacab) .or. empty (BA3->BA3_MOTBLO) .or. alltrim (BA3->BA3_MOTBLO)  $ '002,004,021,022,023,024,025,026,028,029')   
	          lbloq:= .F.
	       EndIf   
        EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se pode considerar o plano, de acordo com parametros...   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  _cCodPla < cCodPlaI .or. _cCodPla > cCodPlaF .or.  lBloq   
			nTotal -= SE1->E1_saldo
			TRB->(DbSkip())
			Loop                                              
		EndIf                                                 
		if nGeraconv = 2
		   if TRB->bm1_codemp = '0004'                   
		      nTotal -= SE1->E1_saldo
			  TRB->(DbSkip())
			  Loop   			  
		   EndIf     
		elseif nGeraconv = 3
		   if TRB->bm1_codemp <> '0004'                     
		      nTotal -= SE1->E1_saldo
			  TRB->(DbSkip())
			  Loop   			  
		   EndIf     
		EndIf     
		
		If mv_par19 == 1 .and. (SE1->E1_valor == SE1->E1_saldo .or. SE1->E1_saldo == 0)   
		   nTotal -= SE1->E1_saldo
		   TRB->(DbSkip())
		   Loop                                              
		EndIf
		                                                
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apresenta mensagem em tela...                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	    //IncProcG2("  ")
		//ProcessMessage()
		IncProcG2("Processando Familia - "+ TRB->(BM1_CODINT + '.' + BM1_CODEMP + '.' + BM1_MATRIC)+" - "+Transform(nTotal, "@E 999,999,999,999.99"))
		ProcessMessage()
				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se foi abortada a impressao...                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  Interrupcao(lAbortPrint)
			Exit
		Endif
		
		// Posiciona o produto
		BI3->( MsSeek(xFilial("BA3")+ BA3->BA3_CODINT + _cCodPla) )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Alimenta o arquivo temporario...                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
		
		If lListTit
			If nIdent == 1
				cChave := _cCodPla  +  SE1->E1_CLIENTE + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO
				
			Else
				cChave := _cCodPla + SE1->E1_CLIENTE + Iif(!Empty(SE1->E1_NUMBCO), SE1->E1_NUMBCO, SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))
				
			Endif
					
		Else
			cChave := _cCodPla + SE1->E1_CLIENTE + substr(dtos(SE1->E1_emissao),1,4) + substr(dtos(SE1->E1_emissao),5,2)
			
		Endif      
	//	 MsProcTxt("Processando ...." + _cCodPla + SE1->E1_CLIENTE + SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+"   R E C N O : "+TRBSE1->SE1RECNO))

		lFound := TRB1->( MsSeek( cChave ) )
		
		TRB1->( RecLock("TRB1", !lFound) )
		If !lFound
			TRB1->TR1_CODIGO 	:= _cCodPla
			TRB1->TR1_DESCRI 	:= BI3->BI3_DESCRI   
			TRB1->TR1_CODCLI    := SE1->E1_CLIENTE 
			TRB1->TR1_NOMCLI    := SE1->E1_NOMCLI  
            TRB1->TR1_MOTBX     := cMotBx      
            TRB1->TR1_DTDIS     := Ddtdisp  
		 	if nCmpEms  = 1               
				IF SE1->E1_PREFIXO = 'PLS'   
				   TRB1->TR1_ANO		:= SE1->E1_anobase  
				   TRB1->TR1_MES		:= SE1->E1_mesbase
				Else                           
	   			   TRB1->TR1_ANO		:= substr(dtos(SE1->E1_emissao),1,4)  
				   TRB1->TR1_MES		:= substr(dtos(SE1->E1_emissao),5,2)
				EndIf
	         Else                           
	   		    TRB1->TR1_ANO		:= substr(dtos(SE1->E1_emissao),1,4)  
			    TRB1->TR1_MES		:= substr(dtos(SE1->E1_emissao),5,2)	
			 EndIf   
			TRB1->TR1_VLRTAR	:= SE1->E1_DECRESC
			TRB1->TR1_VALTIT	:= SE1->E1_VALOR
			TRB1->TR1_PREFIX	:= SE1->E1_PREFIXO
			TRB1->TR1_NUM		:= SE1->E1_NUM
			TRB1->TR1_PARCEL	:= SE1->E1_PARCELA
			TRB1->TR1_TIPO		:= SE1->E1_TIPO     
			TRB1->TR1_DTEMIS    := SE1->E1_EMISSAO 
            TRB1->TR1_DTVCTO    := SE1->E1_VENCREA
            TRB1->TR1_DTBXA     := SE1->E1_BAIXA
            TRB1->TR1_DTDIS     := Ddtdisp

			If _cAliasBM1  = 'BM1'
			   TRB1->TR1_CANCEL    := " " 
			Else                          
			   TRB1->TR1_CANCEL    := "*"
			EndIF     
			// Caso so exista um plano na composicao, grava o valor total da baixa e nao realiza o rateio...
				TRB1->TR1_VLRBAI	:= nBaixa
			
			If !Empty(SE1->E1_NUMBCO)
				TRB1->TR1_NUMBCO	:= SE1->E1_NUMBCO
			Else
				TRB1->TR1_NUMBCO	:= SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
			Endif
						
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza matriz com valores do plano                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
  /*		If mv_par19 == 1 .and. (SE1->E1_VALOR == SE1->E1_saldo .or.  SE1->E1_saldo == 0)   
		   TRB->(DbSkip())
            loop 
         EndIf   	*/
		If mv_par18 == 1 .and. TRB1->TR1_VALTIT <> SE1->E1_saldo  .and. SE1->E1_saldo != 0     ////////akki 26/08/214 altamiro

   		        If TRB->BM1_CODTIP $ '935'		// PARCELAMENTO 
					TRB1->TR1_VLRPAR += TRB->BM1_VALOR         
				EndIf

		        If TRB->BM1_CODTIP $ '101, 118'		// Mensalidade
			       TRB1->TR1_VLRMEN += TRB->BM1_VALOR
					
				Elseif TRB->BM1_CODTIP $ '102,133'	// Opcionais
					TRB1->TR1_VLRMEN += TRB->BM1_VALOR
					
				Elseif TRB->BM1_CODTIP == '103'		// Taxa de adesao
					TRB1->TR1_VLRMEN += TRB->BM1_VALOR
					
				Elseif TRB->BM1_CODTIP $ cCodigosPF	// Co-participacoes...
					TRB1->TR1_VLRMEN   += TRB->BM1_VALOR
					
				Elseif TRB->BM1_CODTIP == '909'		// Guia medico
					TRB1->TR1_VLRMEN  += TRB->BM1_VALOR
					
				Elseif TRB->BM1_CODTIP $ '107, 908'	// Cartao de identificaçao
					TRB1->TR1_VLRMEN  += TRB->BM1_VALOR
					
				Elseif Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")	// Farmacia
					TRB1->TR1_VLRMEN  += TRB->BM1_VALOR
					
				Elseif TRB->BM1_CODTIP $ cCodDB		// Debitos / creditos...
					If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
						If BFQ->BFQ_DEBCRE == '2' 	// Credito.
							TRB1->TR1_VLRMEN  += TRB->BM1_VALOR
							
						Elseif BFQ->BFQ_DEBCRE == '1' // Debitos.
							TRB1->TR1_VLRMEN  += TRB->BM1_VALOR
							
						Endif
					Endif
				Else
					TRB1->TR1_VLRMEN += TRB->BM1_VALOR
				Endif

		Else ////////akki 26/08/214 altamiro           /   
		
   		        If TRB->BM1_CODTIP $ '935'		// PARCELAMENTO 
					TRB1->TR1_VLRPAR += TRB->BM1_VALOR         
				EndIf	
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
				    //EM 28/09/2020 - ALTAMIRO - TARTAR LANÇAMENTO A CREDITO 924
					TRB1->TR1_VLROUT +=(Iif(TRB->BM1_TIPO == '1', TRB->BM1_VALOR, (TRB->BM1_VALOR * -1)))
//					TRB1->TR1_VLROUT += TRB->BM1_VALOR
				Endif
		EndIf
	 	nContador += 1
	 //	IncProcG3("Gravados " + nContador  )
	 //	ProcessMessage()

		// Libera o registro...
		TRB1->( MsUnlock() )
		
		// Acumula o valor de cada plano para calcular as partes do rateio...
		If lRateio
			If (nPos := Ascan(aRateio, {|x| x[1] == 	cChave} )) == 0
				Aadd(aRateio, {cChave,Iif(TRB->BM1_TIPO == '1', TRB->BM1_VALOR, (TRB->BM1_VALOR * -1)),0})
				
			Else
				If TRB->BM1_TIPO == '1'
					aRateio[nPos][2] += TRB->BM1_VALOR
					
				Else
					aRateio[nPos][2] -= TRB->BM1_VALOR
					
				Endif
				
			Endif
		Endif
		if nEmpAtu == '02' .and. TRB->bm1_nivcob <> '4'                   
		   TRB1->TR1_VLRDEB += nVlDeb
           nVlDeb:=0.00
        EndIf   
		TRB->(DbSkip())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fim do laco...                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Enddo
	/////////////////////////// 
	if empty (_cCodPla)  	
       If nIdent == 1
   	      cChave := "9999" + substr(dtos(SE1->E1_emissao),1,4) + substr(dtos(SE1->E1_emissao),5,2) + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO		
       Else
	      cChave := "9999" + substr(dtos(SE1->E1_emissao),1,4) + substr(dtos(SE1->E1_emissao),5,2) +Iif(!Empty(SE1->E1_NUMBCO), SE1->E1_NUMBCO, SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))		
       Endif

       lFound := TRB1->( MsSeek( cChave ) )
		
	   TRB1->( RecLock("TRB1", !lFound) )
	   If !lFound
	      TRB1->TR1_CODIGO 	  := "9999"
		  TRB1->TR1_DESCRI 	  := "Outros Titulos - Não PLS"
          TRB1->TR1_CODCLI    := SE1->E1_CLIENTE 
		  TRB1->TR1_NOMCLI    := SE1->E1_NOMCLI   
		  TRB1->TR1_MOTBX     := cMotBx    
   	      TRB1->TR1_DTDIS     := Ddtdisp
		  TRB1->TR1_ANO		  := substr(dtos(SE1->E1_emissao),1,4)  
		  TRB1->TR1_MES		  := substr(dtos(SE1->E1_emissao),5,2)
		  TRB1->TR1_VLRTAR	  := SE1->E1_DECRESC
		  TRB1->TR1_VALTIT	  := SE1->E1_VALOR
		  TRB1->TR1_PREFIX	  := SE1->E1_PREFIXO
		  TRB1->TR1_NUM		  := SE1->E1_NUM
		  TRB1->TR1_PARCEL	  := SE1->E1_PARCELA
		  TRB1->TR1_TIPO	  := SE1->E1_TIPO   
		  TRB1->TR1_DTEMIS    := SE1->E1_EMISSAO 
          TRB1->TR1_DTVCTO    := SE1->E1_VENCREA
          TRB1->TR1_DTBXA     := SE1->E1_BAIXA 
          TRB1->TR1_DTDIS     := Ddtdisp
				
          // Caso so exista um plano na composicao, grava o valor total da baixa e nao realiza o rateio...
    	  TRB1->TR1_VLRBAI	:= nBaixa
			
		  If !Empty(SE1->E1_NUMBCO)
		     TRB1->TR1_NUMBCO	:= SE1->E1_NUMBCO
		  Else
		   	 TRB1->TR1_NUMBCO	:= SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
		  Endif	
		  TRB1->TR1_VLROUT    += SE1->E1_valor  	
		  TRB1->( MsUnlock() ) 
	   Endif  
    Endif        
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza matriz com valores do plano                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		// Libera o registro...

	TRB->( dbCloseArea() )
 Endif	
	TRBSE1->( dbSkip() )
_cCodPla	:= " "
Enddo
                        

/*
0        10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
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
If lAnalitico                  
   If  lListTit
       aCabec1:={"Plano  " ,;
                  "Titulo" ,;
                 "Cliente",; 
              "Referencia",; 
        "Contra Prestação",; 
               "Opcionais",;   
               "Tx Adesao",;
                 "Debitos",;
                "Creditos",;
            "Participacao",;          
                  "Tarifa",;
                "Farmacia",;
             "Guia Medico",;
                  "Cartão",;      
                  "Outros",;
                   "Saldo",;
              "Dt Emissao",;
               "Dt Vencto",;
                "Dt Pagto",; 
               "Mot.Baixa",;
           "Dt Disponivel"}    
   EndIf                 
EndIf 
TRB1->( dbGotop() )

cAnoMes := ''
While !TRB1->( Eof() )
	
	// Controle de saldo de pagina...
	If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif
	
	// Controle de quebra... 
    	cQuebra   := 	TRB1->TR1_CODIGO 
		cDesQuebr := 	TRB1->TR1_CODIGO + ' - ' + TRB1->TR1_DESCRI 
	
	If lAnalitico
		// Imprime plano, dado principal da quebra.
		@ nLi, 000 Psay '==> ' + cDesQuebr
	  	nLi += 2 
	  
	Endif
	
	While !TRB1->( Eof() ) .and. TRB1->TR1_CODIGO == cQuebra
		cCli1 := " "                                                      
		cCLI := TRB1->TR1_CODCLI
//		cAno := TRB1->TR1_ANO
//		cMes := TRB1->TR1_MES
		While !TRB1->( Eof() ) .and. (TRB1->TR1_CODIGO + TRB1->TR1_CODCLI ) == cQuebra + cCli
			
			nTotLinha := 0
			
			nFator := (((TRB1->TR1_VLRBAI * 100) / TRB1->TR1_VALTIT) / 100)
			If TRB1->TR1_VLRBAI > 0 // Se o valor da baixa for menor que o valor do titulo, ativa rateio por coluna...
				nTotal := TRB1->(TR1_VLRMEN+TR1_VLROPC+TR1_VLRTAX+TR1_VLRDEB+TR1_VLRCRE+TR1_VLRPF+TR1_VLRTAR+;
								 TR1_VLRFAR+TR1_VLRGUI+TR1_VLRCAR+TR1_VLROUT)
				
        ///        nSaldo := (nTotal - TRB1->TR1_VLRBAI)   altmairo   
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
			If lAnalitico
				If  nli > nQtdLin
					nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				//	nli++
				Endif
				
				If lListTit                     
					//cQuebra   := TRB1->TR1_CODCLI
					If cCli1 <> TRB1->TR1_CODCLI
						@ nLi, 006 Psay '** ' + TRB1->TR1_CODCLI + ' - ' + TRB1->TR1_NOMCLI
						cCli1 := TRB1->TR1_CODCLI				
				   //		nLi += 2 
				   		nLi += 1
					Endif
					
					// Imprime o titulo quando for analitico e o parametro "listar titulos" for = SIM...
					If nIdent == 1		// Lista numero do titulo
						@ nLi, 000 Psay TRB1->(TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO+TR1_CANCEL)
					
					Else	// Lista nosso numero 
						@ nLi, 000 Psay TRB1->TR1_NUMBCO
					
					Endif
					
			 //	Else
			 //		@ nLi, 000 Psay '** '+Alltrim(TRB1->TR1_ANO) + '/' + Alltrim(TRB1->TR1_MES)
				Endif
				
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
//				@ nLi, 173 Psay Transform(nTotLinha, pMoeda2); nTotGrupo += nTotLinha //nTotLinha
//				@ nLi, 189 Psay Transform(TRB1->TR1_VLRBAI, pMoeda2); nTotBai += TRB1->TR1_VLRBAI; nTotGBai += TRB1->TR1_VLRBAI
                

                if trb1->TR1_CODIGO == '9999'
				   nSaldo := (nTotLinha - TRB1->TR1_VLRBAI)
				else   
				   nSaldo := nTotLinha
                EndIf
				@ nLi, 173 Psay Transform(nSaldo, pMoeda2); nTotSld += nSaldo; nTotGSld += nSaldo
				
				@ nLi, 190 Psay TRB1->TR1_DTEMIS
				@ nLi, 200 Psay TRB1->TR1_DTVCTO    
				if nBaidis  = 1 
   				   @ nLi, 210 Psay TRB1->TR1_DTBXA
   				Else    
                   @ nLi, 210 Psay TRB1->TR1_DTDIS     
                EndIf  
                
	         aaDD(aDados,{TRB1->TR1_CODIGO + ' - ' + TRB1->TR1_DESCRI,;
	                      TRB1->(TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO + TR1_CANCEL),;
	                      TRB1->TR1_CODCLI + ' - ' + TRB1->TR1_NOMCLI,;
		   	    Alltrim(TRB1->TR1_ANO) + '/' + Alltrim(TRB1->TR1_MES), ; 
		                          Transform(TRB1->TR1_VLRMEN, pMoeda2), ;
		                          Transform(TRB1->TR1_VLROPC, pMoeda1), ;
		                          Transform(TRB1->TR1_VLRTAX, pMoeda1), ;
  		                          Transform(TRB1->TR1_VLRDEB, pMoeda2), ;
   		                          Transform(TRB1->TR1_VLRCRE, pMoeda2), ;
  		                          Transform(TRB1->TR1_VLRPF , pMoeda2), ;
                                  Transform(TRB1->TR1_VLRTAR, pMoeda2), ;
                                  Transform(TRB1->TR1_VLRFAR, pMoeda2), ;		             
		                          Transform(TRB1->TR1_VLRGUI, pMoeda1), ;
		                          Transform(TRB1->TR1_VLRCAR, pMoeda1), ;
		                          Transform(TRB1->TR1_VLROUT, pMoeda1), ;
		                          Transform(nSaldo, pMoeda2),;
		                          TRB1->TR1_DTEMIS ,;
                                  TRB1->TR1_DTVCTO  ,;
                                  TRB1->TR1_DTBXA ,;
                                  TRB1->TR1_MOTBX ,;
                                  TRB1->TR1_DTDIS ,;
                                  Transform(TRB1->TR1_VLRPAR, pMoeda1) })                           
		
				
				If lListTit
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
					nTotCSld += nSaldo
				Endif
				
				nLi++
			Else
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
				nTotSld	+= nSaldo; nTotGSld += nSaldo
			Endif
			
			TRB1->( dbSkip() )
		Enddo
		
		If lAnalitico .and. lListTit
			// Imprime o total do plano, finalizando a quebra...
     	//	nLi++
		//	@ nLi, 000 Psay "Total "+cAno  + '/' + cMes
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
//			@ nLi, 173 Psay Transform(nTotCPla, pMoeda2)
//			@ nLi, 189 Psay Transform(nTotCBai, pMoeda2)
			@ nLi, 174 Psay Transform(nTotCSld, pMoeda2)
			
			nLi ++
			@ nLi, 000 Psay Replicate('-', nLimite)
			
			nTotCMen := nTotCOpc := nTotCAde := nTotCDeb := nTotCCre := 0
			nTotCPF  := nTotCTar := nTotCFar := nTotCGui := nTotCCar := 0
			nTotCOut := nTotCPla := nTotcBai := nTotSql  := nTotCSld := 0
			
	//		nLi += 2   
            nLi += 1
		Endif
		
	Enddo
	
	// Controle de saldo de pagina...
	If lAnalitico
 		nLi++
	Endif
	
	If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif
	
	If lAnalitico
		// Imprime o total do plano, finalizando a quebra... 
	
		@ nLi, 000 Psay "Totais Plano "
		@ nLi, 016 Psay Transform(nTotMen, pMoeda2)
		@ nLi, 032 Psay Transform(nTotOpc, pMoeda1)
		@ nLi, 044 Psay Transform(nTotAde, pMoeda1)
		@ nLi, 056 Psay Transform(nTotDeb, pMoeda2)
		@ nLi, 072 Psay Transform(nTotCre, pMoeda2)
		@ nLi, 088 Psay Transform(nTotPF , pMoeda2)
		@ nLi, 104 Psay Transform(nTotTar, pMoeda2)
		@ nLi, 120 Psay Transform(nTotFar, pMoeda2)
		@ nLi, 137 Psay Transform(nTotGui, pMoeda1)
		@ nLi, 149 Psay Transform(nTotCar, pMoeda1)
		@ nLi, 161 Psay Transform(nTotOut, pMoeda1)
//		@ nLi, 173 Psay Transform(nTotGrupo,pMoeda2)
//		@ nLi, 189 Psay Transform(nTotBai, pMoeda2)
		@ nLi, 173 Psay Transform(nTotSld, pMoeda2)
		
		nLi ++
		@ nLi, 000 Psay Replicate('-', nLimite)
		
		nLi += 1
    
	Else
		
		/*
		10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
		1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		Plano                                        Contr.        Opcionais        Tx Adesao          Debitos         Creditos     Participacao           Tarifa    	  Farmacia   "
		9999-999999999999999999999999999999  999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99   999,999,999.99
		*/
		
		// Imprime plano, dado principal da quebra.
		@ nLi, 000 Psay cDesQuebr
		nLi++
		@ nLi, 016 Psay Transform(nTotMen, pMoeda2)
		@ nLi, 032 Psay Transform(nTotOpc, pMoeda1)
		@ nLi, 044 Psay Transform(nTotAde, pMoeda1)
		@ nLi, 056 Psay Transform(nTotDeb, pMoeda2)
		@ nLi, 072 Psay Transform(nTotCre, pMoeda2)
		@ nLi, 088 Psay Transform(nTotPF , pMoeda2)
		@ nLi, 104 Psay Transform(nTotTar, pMoeda2)
		@ nLi, 120 Psay Transform(nTotFar, pMoeda2)
		@ nLi, 137 Psay Transform(nTotGui, pMoeda1)
		@ nLi, 149 Psay Transform(nTotCar, pMoeda1)
		@ nLi, 161 Psay Transform(nTotOut, pMoeda1)
//		@ nLi, 173 Psay Transform(nTotGrupo, pMoeda2)
//		@ nLi, 189 Psay Transform(nTotBai, pMoeda2)
		@ nLi, 173 Psay Transform(nTotSld, pMoeda2)
	
		nLi += 2
	Endif
	// Incrementa total geral do relatorio
	nTotGeral += nTotGrupo
	
	// Reinicia as variaveis totalizadoras...
	nTotMen := nTotOpc := nTotAde := nTotDeb := 0
	nTotCre := nTotPF  := nTotTar := nTotFar := 0
	nTotJur := nTotTit := nTotOut := nTotGrupo := 0
	nTotGui := nTotCar := nTotGrupo := nTotBai := 0
	nTotSld := 0
	
Enddo

// Imprime os totais gerais

If  nli > nQtdLin
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nli++
Endif

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
//@ nLi, 173 Psay Transform(nTotGeral, pMoeda2)
//@ nLi, 189 Psay Transform(nTotGBai, pMoeda2)
@ nLi, 173 Psay Transform(nTotGSld, pMoeda2)

nLi++
@ nLi, 000 Psay Replicate('-', nLimite)
                                         
if nGeraExcel = 1
   DlgToExcel({{"ARRAY","Gravações da Filial" ,aCabec1,aDados}})
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

TRBSE1->( dbClosearea() )

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

aadd(aRegs,{cPerg,"01","Operadora ?        ","","","mv_ch1","C", 4,0,0,"G",""           ,"mv_par01",""                ,"","","","",""               	,"","","","",""     ,"","","","",""    ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Comp. Mes De ?     ","","","mv_ch2","C", 2,0,0,"G",""           ,"mv_par02",""                ,"","","","",""               	,"","","","",""     ,"","","","",""    ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"03","Comp. Ano De ?     ","","","mv_ch3","C", 4,0,0,"G",""           ,"mv_par03",""                ,"","","","",""               	,"","","","",""     ,"","","","",""    ,"","","","","","","","",""   ,""}) 
aadd(aRegs,{cPerg,"04","Dt baixa ate ?     ","","","mv_ch4","D", 8,0,0,"G",""           ,"mv_par04",""                ,"","","","",""               	,"","","","",""     ,"","","","",""    ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"05","Produto de ?       ","","","mv_ch5","C", 4,0,0,"G",""           ,"mv_par05",""                ,"","","","",""            		,"","","","",""     ,"","","","",""    ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"06","Produto ate?       ","","","mv_ch6","C", 4,0,0,"G",""           ,"mv_par06",""         	    ,"","","","",""            		,"","","","",""     ,"","","","",""    ,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B2DPLS","B2D"),""})
aadd(aRegs,{cPerg,"07","Tipo Relatorio?    ","","","mv_ch7","N", 1,0,0,"C",""		   	  ,"mv_par07","Analitico"	    ,"","","","",""      	        ,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"08","Listar titulos?    ","","","mv_ch8","N", 1,0,0,"C",""		      ,"mv_par08","Sim"    	        ,"","","","",""      	        ,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"09","Identificação ?    ","","","mv_ch9","N", 1,0,0,"C",""		      ,"mv_par09","No. Titulo"      ,"","","","","Nosso Numero"    	,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"10","Gerar Excel   ?    ","","","mv_ch10","N", 1,0,2,"C",""		      ,"mv_par10","Sim"    	        ,"","","","","Nao"      	    ,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"11","Listar Excluidos ? ","","","mv_ch11","N", 1,0,2,"C",""		      ,"mv_par11","Sim"    	        ,"","","","","Nao"      	    ,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""}) 
aadd(aRegs,{cPerg,"12","Listar        ?    ","","","mv_ch12","N", 1,0,2,"C",""		      ,"mv_par12","Com Convenio"    ,"","","","","Sem Convenio"	    ,"","","","","Só Convenio"     ,"","","","",""   	,"","","","","","","","",""   	,""}) 
aadd(aRegs,{cPerg,"13","Quando Pls a Considerar ? ","","","mv_ch13","N", 1,0,2,"C",""	  ,"mv_par13","Por Competencia ","","","","","Por Emissão "    ,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"14","Listar NCC's  ?    ","","","mv_ch14","N", 1,0,2,"C",""		      ,"mv_par14","Sim"    	        ,"","","","","Nao"      	    ,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""}) 
aadd(aRegs,{cPerg,"15","Dt Emissao De ?    ","","","mv_ch15","D", 8,0,0,"G",""           ,"mv_par15",""                ,"","","","",""               	,"","","","",""     ,"","","","",""    ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"16","Dt Emissao Ate ?   ","","","mv_ch16","D", 8,0,0,"G",""          ,"mv_par16",""                ,"","","","",""               	,"","","","",""     ,"","","","",""    ,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"17","Selecionar por?    ","","","mv_ch17","N", 1,0,0,"C",""		   	  ,"mv_par17","Baixa "          ,"","","","","Disponivel "    	,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""})


aadd(aRegs,{cPerg,"18","Cont Colun Bx parc ?","","","mv_ch18","N", 1,0,0,"C",""		   	  ,"mv_par18","Sim "          ,"","","","","Não "           	,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""})
aadd(aRegs,{cPerg,"19","So listar Bx parc  ?","","","mv_ch19","N", 1,0,0,"C",""		   	  ,"mv_par19","Sim "          ,"","","","","Não "    	        ,"","","","",""     ,"","","","",""   	,"","","","","","","","",""   	,""})

PlsVldPerg( aRegs )

Return       

