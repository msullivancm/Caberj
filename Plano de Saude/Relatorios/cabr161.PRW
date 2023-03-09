#Define CRLF Chr(13)+Chr(10)
#include "PLSMGER.CH"  
#include "TOPCONN.CH"
#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

Static cCodDB     := PLSRETLADC()
/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±±
±±≥Funcao    ≥ CABR161 ≥ Autor ≥ Altamiro Trotta Affonso≥ Data ≥ 11.11.14 ≥±±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±±
±±≥Descricao ≥ Relatorio de posiÁ„o de clientes ...                       ≥±±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±±
±±≥Sintaxe   ≥ Cabr161                                                    ≥±±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±±
±±≥ Uso      ≥ Advanced Protheus                                          ≥±±±
±±√ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±±
±±≥ Alteracoes desde sua construcao inicial                               ≥±±±
±±√ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±±
±±≥ Data     ≥ BOPS ≥ Programador ≥ Breve Descricao                       ≥±±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Define nome da funcao...                                                 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
User Function CABR161()
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Define variavaoeis...                                                    ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
PRIVATE nQtdLin 	:= 58
PRIVATE cNomeProg   := "CABR161"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 220
PRIVATE cTamanho    := "G"     
PRIVATE cTitulo     := "Relatorio de PosiÁ„o de Clientes   - Contas a Receber "
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "SE1"
PRIVATE cPerg       := padr("CABR161", 10)
PRIVATE cRel        := "CABR161"
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
private cQuery      := ' ' 
private cQuery1     := ' ' 
                            
private cADadTit   := GetNextAlias()
private cADadCli  := GetNextAlias()  

PRIVATE nQtdaDia    := 0
PRIVATE aInter      := {}     
//ALTAMIRO 17/02/2011 - carta janela
private aCabec1     := {"campo","campo1","campo3","campo4","campo5","campo6","campo7","campo8","campo9"}

private aDados      := {}     
private aDados1     := {}
//
/*
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Matricula : xxx.xxxx.xxxx.xxxxxx        Nome : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Referen.                Contr.   Opcionais   Tx Adesao         Debitos        Creditos    Participacao          Tarifa        Farmacia  Guia Medico      Cart„o      Outros           Total 
PLS999999 999   999,999,999.99  999,999.99  999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99   999,999.99  999,999.99  999,999.99  999,999,999.99 

Totais          999,999,999.99  999,999.99  999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99   999,999.99  999,999.99  999,999.99  999,999,999.99 
*/
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Chama SetPrint                                                           ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
CriaSX1()

cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Verifica se foi cancelada a operacao                                     ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
If nLastKey  == 27
	Return
Endif
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Recebe parametros                                                        ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

Pergunte(cPerg,.F.)         
cOpe     	:= mv_par01
nGrEmp      := mv_par02
cMatrInc    := mv_par03  
cMatrFim    := mv_par04  
cClieInc    := mv_par05  
cClieFim    := mv_par06                   
dDtEmisInc  := dtos(mv_par07)
dDtEmisFim  := dtos(mv_par08) 
dDtVencInc  := dtos(mv_par09)
dDtVencFim  := dtos(mv_par10)
dDtBaixInc  := dtos(mv_par11)
dDtBaixFim  := dtos(mv_par12)
nTpSaldo    := mv_par13 
nTpVenco    := mv_par14

nExcel      := mv_par15
	

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Configura Impressora                                                     ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
SetDefault(aReturn,cAlias)

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Monta RptStatus...                                                       ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
   Proc2BarGauge({|| aCriticas := RJ002Imp()() }  , "Imprimindo...")
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Fim da Rotina Principal...                                               ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Return


/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±±
±±≥Funcao    ≥ RJ002Imp≥ Autor ≥ Altamiro Trotta Affonso≥ Data ≥ 03.11.09 ≥±±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±±
±±≥Descricao ≥ Relatorio de contratos.                                    ≥±±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Define nome da funcao                                                    ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Static Function RJ002Imp()
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Variaveis do IndRegua...                                                 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
LOCAL i
LOCAL n

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Exibe mensagem informativa...                                            ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
IncProcG1("Aguarde. Buscando dados no servidor...")
ProcessMessage()
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Totalizadores por Empresa...                                             ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
PRIVATE nTotCobEmp := 0
PRIVATE nTotRegEmp := 0
Private aQtdusrEmp := 0
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Totalizadores por Contrato...                                            ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
PRIVATE nTotCobCon := 0
PRIVATE nTotRegCon := 0
Private aQtdusrCon := 0
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Totalizadores por SubContrato...                                         ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
PRIVATE nTotCobSub := 0
PRIVATE nTotRegSub := 0
PRIVATE nVlrCob    := 0
Private aQtdusrSub := 0   

Private dVenc      := dtos(date())    

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Monta Expressao de filtro...                                             ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

// titulos a receber  identificaÁ„o 
cQuery := CRLF+ "SELECT E1_PREFIXO || E1_NUM || E1_PARCELA || E1_TIPO TITULOS ,E1_CLIENTE CLIENTE, E1_VALOR VALOR , "
cQuery += CRLF+ "E1_EMISSAO EMISSAO , E1_VENCREA VENC , E1_BAIXA DTBAIXA , E1_SALDO  SALDO , "
cQuery += CRLF+ "E1_CODINT||'.'||E1_CODEMP ||'.'||E1_MATRIC || '-'||E1_NOMCLI familia , "
       
cQuery += CRLF+ "NVL(BM1_CODINT,'N„o ha')||'.'||NVL(BM1_CODEMP,'N„o ha') ||'.'||NVL(BM1_MATRIC,'N„o ha ') || '-'||NVL(BM1_TIPREG,'N„o ha ') || '-'|| NVL(BM1_DIGITO,'N„o ha ') || '-'||NVL(BM1_NOMUSR,'N„o ha ') USUARIO , "
cQuery += CRLF+ "NVL(BM1_CODTIP,'N„o H·') || ' - ' || NVL(BM1_DESTIP,'N„o H·') RUBRICAS , NVL(BM1_VALOR,0.00) VL_RUBRICA , "
        
cQuery += CRLF+ "NVL(E5_DATA, 'N„o H·')   DTMOV , NVL(E5_DTDISPO, 'Nao Ha') DT_DISPO , NVL(E5_VALOR,0.00) VLR , "
cQuery += CRLF+ "NVL(E5_VLMOED2,0.00) VLRM2 ,NVL(E5_tipodoc ,'n„o H·') tipodoc ,NVL(E5_motbx,'n„o H·') motbx , NVL(E5_HISTOR,'n„o H·') HISTORICO   "
                                                                                                                
cQuery += CRLF+ "  FROM " +RetSqlName('SE1')+ " SE1 , "+RetSqlName('BM1')+ " BM1 , "+RetSqlName('SE5')+ "  SE5 "    

cQuery += CRLF+ " WHERE  E1_FILIAL    = '" + xFilial('SE1') + "' AND SE1.D_E_L_E_T_    = ' ' "     
cQuery += CRLF+   " AND BM1_FILIAL(+) = '" + xFilial('BM1') + "' AND BM1.D_E_L_E_T_(+) = ' ' "  
cQuery += CRLF+   " AND  E5_FILIAL(+) = '" + xFilial('SE5') + "' AND SE5.D_E_L_E_T_(+) = ' ' " 
  
cQuery += CRLF+   " AND BM1_CODINT(+) = SE1.E1_CODINT "
cQuery += CRLF+   " AND BM1_CODEMP(+) = SE1.E1_CODEMP "
cQuery += CRLF+   " AND BM1_MATRIC(+) = SE1.E1_MATRIC "
cQuery += CRLF+   " AND BM1_PREFIX(+) = SE1.E1_PREFIXO "
cQuery += CRLF+   " AND BM1_PARCEL(+) = SE1.E1_PARCELA "
cQuery += CRLF+   " AND BM1_TIPTIT(+) = SE1.E1_TIPO "
cQuery += CRLF+   " AND BM1_NUMTIT(+) = SE1.E1_NUM "
cQuery += CRLF+   " AND BM1_MES(+)    = SE1.E1_MESBASE "
cQuery += CRLF+   " AND BM1_ANO(+)    = SE1.E1_ANOBASE "
   
cQuery += CRLF+   " AND E5_PREFIXO(+) = SE1.E1_PREFIXO "
cQuery += CRLF+   " AND E5_NUMERO(+)  = SE1.E1_NUM "
cQuery += CRLF+   " AND E5_PARCELA(+) = SE1.E1_PARCELA "
cQuery += CRLF+   " AND E5_TIPO(+)    = SE1.E1_TIPO "
cQuery += CRLF+   " AND E5_CLIFOR(+)  = SE1.E1_CLIENTE "
cQuery += CRLF+   " AND E5_LOJA(+)    = SE1.E1_LOJA "
      
cQuery += CRLF+ "   AND E1_CODEMP = '"+nGrEmp+"' "
cQuery += CRLF+ "   AND E1_MATRIC >= '"+ cMatrInc+"'   AND E1_MATRIC <= '"+ cMatrFim+"' "   
if !empty(dDtEmisFim)
   cQuery += CRLF+ "   and e1_emissao >= '"+dDtEmisInc+"' and e1_emissao <= '"+dDtEmisFim+"' "      
EndIf    
if !empty(dDtBaixFim)
   cQuery += CRLF+ "   and e1_BAIXA   >= '"+dDtBaixInc+"' and e1_BAIXA   <= '"+dDtBaixFim+"' "      
EndIf
if !empty(dDtVencFim)   
   cQuery += CRLF+ "   and e1_VENCREA >= '"+dDtVencInc+"' and e1_VENCREA <= '"+dDtVencFim+"' "       
EndIf
if !empty(cClieFim)   
   cQuery += CRLF+ "   and e1_cliente >= '"+cClieInc+"'   and e1_cliente <= '"+cClieFim+"' "    
EndIf
If nTpSaldo == 1 
   cQuery += CRLF+ " and e1_saldo > 0 and e1_vencto < '"+ dVenc +"'" 
ElseIf nTpSaldo == 2                      
   cQuery += CRLF+ " and e1_saldo = 0 "
EndIf    
         
If nTpVenco == 1      
   cQuery += CRLF+ " and (e1_saldo > 0 and e1_VENCREA < '"+ dVenc +"' or e1_saldo = 0 and e1_VENCREA < e1_baixa)" 
elseIf nTpVenco == 2                                                                                                
   cQuery += CRLF+ " and (e1_saldo > 0 and e1_VENCREA > '"+ dVenc +"' "
EndIf    
cQuery += CRLF+ " ORDER BY  2 " 
 
// usuario , Bloqueio ,se houver 
cQuery1 := CRLF+ " SELECT distinct   A1_COD || ' - ' ||  A1_NOME , A1_END , A1_BAIRRO , A1_MUN , A1_EST, A1_CEP ,  A1_DDD , A1_TEL ,A1_FAX ,  "
cQuery1 += CRLF+       "  BA1_CODINT||'.'||BA1_CODEMP||'.'||BA1_MATRIC ||'.'||BA1_TIPREG||'-'||BA1_DIGITO||'-'|| BA1_NOMUSR , "
cQuery1 += CRLF+       "  DECODE(BA1_TIPUSU,'T','TITULAR', 'D' , 'DEPENDENTE') TIPO , BA1_CODPLA ||'-'|| BI3_DESCRI, BA1_DATBLO , "
cQuery1 += CRLF+       "  Nvl(BCA_DATA,'N„o H·') , Nvl(BCA_MOTBLO,'N„o H·')||'-'||nvl(bg3_desblo,'N„o H·') DESBLC ,Nvl(BCA_OBS,'N„o H·') OBS  "
cQuery1 += CRLF+   " FROM " +RetSqlName('SE1')+ " SE1 , " +RetSqlName('SA1')+ " SA1 "
cQuery1 += CRLF+       ", " +RetSqlName('BA1')+ " BA1 , " +RetSqlName('BI3')+ " BI3 "
cQuery1 += CRLF+       ", " +RetSqlName('BCA')+ " BCA , " +RetSqlName('BG3')+ " BG3 " 
	
cQuery1 += CRLF+ " WHERE E1_FILIAL     = '" + xFilial('SE1') + "' AND SE1.D_E_L_E_T_    = ' ' "     
cQuery1 += CRLF+  "  AND A1_FILIAL     = '" + xFilial('SA1') + "' AND SA1.D_E_L_E_T_    = ' ' "
cQuery1 += CRLF+  "  AND BA1_FILIAL    = '" + xFilial('BA1') + "' AND BA1.D_E_L_E_T_    = ' ' "
cQuery1 += CRLF+  "  AND BI3_FILIAL    = '" + xFilial('BI3') + "' AND BI3.D_E_L_E_T_    = ' ' "
cQuery1 += CRLF+  "  AND BCA_FILIAL(+) = '" + xFilial('BCA') + "' AND BCA.D_E_L_E_T_(+) = ' ' "
cQuery1 += CRLF+  "  AND BG3_FILIAL(+) = '" + xFilial('BG3') + "' AND BG3.D_E_L_E_T_(+) = ' ' "
       
cQuery1 += CRLF+  "  AND BA1_CODEMP = E1_CODEMP AND BA1_MATRIC = E1_MATRIC 
cQuery1 += CRLF+  "  AND A1_COD = E1_CLIENTE
cQuery1 += CRLF+  "  AND BI3_CODIGO = BA1_CODPLA
cQuery1 += CRLF+  "  AND BCA_MATRIC(+) = BA1_CODINT||BA1_CODEMP||BA1_MATRIC
cQuery1 += CRLF+  "  AND BCA_TIPREG(+) = BA1_TIPREG  
cQuery1 += CRLF+  "  AND BG3_CODBLO(+) = BCA_MOTBLO
  
cQuery1 += CRLF+ "   AND E1_CODEMP = '"+nGrEmp+"' "                                              
cQuery1 += CRLF+ "   AND E1_MATRIC >= '"+ cMatrInc+"'   AND E1_MATRIC <= '"+ cMatrFim+"' "   
	
if !empty(dDtEmisFim)
   cQuery1 += CRLF+ "   and e1_emissao >= '"+dDtEmisInc+"' and e1_emissao <= '"+dDtEmisFim+"' "      
EndIf    
if !empty(dDtBaixFim)
   cQuery1 += CRLF+ "   and e1_BAIXA   >= '"+dDtBaixInc+"' and e1_BAIXA   <= '"+dDtBaixFim+"' "      
EndIf
if !empty(dDtVencFim)   
   cQuery1 += CRLF+ "   and e1_VENCREA >= '"+dDtVencInc+"' and e1_VENCREA <= '"+dDtVencFim+"' "       
EndIf
if !empty(cClieFim)   
   cQuery1 += CRLF+ "   and e1_cliente >= '"+cClieInc+"'   and e1_cliente <= '"+cClieFim+"' "    
EndIf
	
If   nTpSaldo == 1 
     cQuery1 += CRLF+ " and e1_saldo > 0   and e1_vencto < '"+ dVenc +"'" 
ElseIf nTpSaldo == 2                      
     cQuery1 += CRLF+ " and e1_saldo = 0 "
EndIf    
 	         
If   nTpVenco == 1      
     cQuery1 += CRLF+ " and (e1_saldo > 0 and e1_VENCREA < '"+ dVenc +"' or e1_saldo = 0 and e1_VENCREA < e1_baixa)" 
ElseIf nTpVenco == 2                                                                                                
     cQuery1 += CRLF+ " and (e1_saldo > 0 and e1_VENCREA > '"+ dVenc +"' "
EndIf    
  	 cQuery1 += CRLF+ "  ORDER BY 1 ,13 , 12  " 

//////////////////////////////////////////////////////////////     
                                                                      


 If Select((cADadCli)) <> 0 
  (cADadCli)->(DbCloseArea()) 
 Endif
     
 TCQuery cQuery New Alias (cADadCli)
    
 dbSelectArea(cADadCli)
   
 (cADadCli)->(dbGoTop())   
     
While (cADadCli)->(!Eof())  
//a:='B'
//nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)

//nli++
                             
                                                                        
		If Select((cADadTit)) <> 0 
		  (cADadTit)->(DbCloseArea()) 
		Endif
		  
		TCQuery cQuery New Alias (cADadTit)  
		    
		dbSelectArea(cADadTit)
		   
		(cADadTit)->(dbGoTop())   
		     
		While (cADadTit)->(!Eof())      //  	       cChave := (_CODINT + _CODEMP + _MATRIC) + TMP->(E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO) 	

		                                  
		a:='B'
		
		EndDo
EndDo
		      
/*	      Endif  
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
	      */ /*                          
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
   */		   /*
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
'	    //ALTAMIRO 17/02/2011 - carta janela   
	    
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
	DlgToExcel({{"ARRAY","GravaÁıes da Filial" ,aCabec1,aDados}})
	    //////	                     
 EndIf 	   
 If nExcel = 1                                                   
    DlgToExcel({{"ARRAY","GravaÁıes da Filial" ,aCabec1,aDados1}}) 
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
                    
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Imprime rodape...                                                  ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Roda(0,Space(10))
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Fecha area de trabalho...                                          ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRBBA1->( dbClosearea() )

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Finaliza e elimina o arquivo fisico do temporario...                     ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
TRB1->( dbCloseArea() )
FErase(cArqTRB  + ".DBF")
FErase(cInd1TRB + OrdBagExt())
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Libera impressao                                                         ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(crel)
Endif
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Fim da impressao do relatorio...                                         ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Return()


*/
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥Programa   ≥ CriaSX1   ≥ Autor ≥ Angelo Sperandio     ≥ Data ≥ 03.02.05 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Descricao  ≥ Atualiza SX1                                               ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/

Static Function CriaSX1()

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Operadora      ? ","","","mv_ch1","C", 04,0,0,"G",""   ,"mv_par01",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","",IIf(PlsGetVersao() >= 8,"B89PLS","B89"),""})
aadd(aRegs,{cPerg,"02","Gr.Empresa     ? ","","","mv_ch2","C", 04,0,0,"G",""   ,"mv_par02",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""}) 
aadd(aRegs,{cPerg,"03","Matricula De   ? ","","","mv_ch3","C", 06,0,0,"G",""   ,"mv_par03",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","","",""}) 
aadd(aRegs,{cPerg,"04","Matricula Ate  ? ","","","mv_ch4","C", 06,0,0,"G",""   ,"mv_par04",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"05","Cliente   De   ? ","","","mv_ch5","C", 06,0,0,"G",""   ,"mv_par05",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","","",""}) 
aadd(aRegs,{cPerg,"06","Cliente   Ate  ? ","","","mv_ch6","C", 06,0,0,"G",""   ,"mv_par06",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","","",""})
aadd(aRegs,{cPerg,"07","Emiss√Oao De   ? ","","","mv_ch7","D", 10,0,0,"G",""   ,"mv_par07",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""}) 
aadd(aRegs,{cPerg,"08","Emiss√O  Ata   ? ","","","mv_ch8","D", 10,0,0,"G",""   ,"mv_par08",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"09","Vencimento De  ? ","","","mv_ch9","D", 10,0,0,"G",""   ,"mv_par09",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""}) 
aadd(aRegs,{cPerg,"10","Vencimento Ata ? ","","","mv_ch10","D", 10,0,0,"G",""  ,"mv_par10",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"11","Dt Baixa De    ? ","","","mv_ch11","D", 10,0,0,"G",""  ,"mv_par11",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""}) 
aadd(aRegs,{cPerg,"12","Dt Baixa Ata   ? ","","","mv_ch12","D", 10,0,0,"G",""  ,"mv_par12",""          ,"","","","",""          ,"","","","",""              ,"","","","",""      	,"","","","","","","","",""   ,""})
aadd(aRegs,{cPerg,"13","Sit.Tit. Saldo ? ","","","mv_ch13","N", 01,0,0,"C",""  ,"mv_par13","Com Saldo" ,"","","","","Sem Saldo" ,"","","","","Ambos"        ,"","","","",""         ,"","","","","","","","","",""})                                                                                                                                                                                                                                                                           
aadd(aRegs,{cPerg,"14","Sit.Tit. Venc. ? ","","","mv_ch14","N", 01,0,0,"C",""  ,"mv_par14","Vencido"   ,"","","","","H· Vencer" ,"","","","","Ambos"         ,"","","","",""         ,"","","","","","","","","",""})                                                                                                                                

aadd(aRegs,{cPerg,"15","Gerar Ecxel      ? ","","","mv_ch19","N", 01,0,0,"C",""  ,"mv_par19","Sim"       ,"","","","","Nao"       ,"","","","",""              ,"","","","",""         ,"","","","","","","","",""   ,""})

PlsVldPerg( aRegs )

Return
                    
