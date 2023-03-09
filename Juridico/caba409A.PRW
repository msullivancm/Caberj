#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA409   ºAutor  ³ Altamiro	         º Data ³  19/06/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de browser do sistema juridico                        º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function caba409A()                 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina	:=	{	{ "&Visualizar"	, "U_Caba410A"		, 0 , 1	 },; 
				     	{ "&Alteracao"	, "U_Caba410A"		, 0 , 2  },;
                        { "&Incluir"	, "U_Caba410A"		, 0 , 3	 },;
                        { "Legenda"		, "U_LEGPROS9"	    , 0 , 3	 }}  
						
						

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro	:= "Browser do Sistema juridico "

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Processo Incluido '         },;
							{ 'BR_AZUL'     ,'Processo Com Decissão'      },; 
							{ 'BR_VERMELHO' ,'Processo Arquivado'         },;							
							{ 'BR_AMARELO'  ,'Processo Audiencia Marcada' },;
							{ 'BR_PRETO'    ,'Processo Desdobramento' }}

PRIVATE aCores	:= {{'!empty(PBW_DTARQ)' , aCdCores[3,1]},;
                    {'!empty(PBW_NUMCOM)', aCdCores[5,1]},;
                    {'!empty(PBW_NUMPRO)', aCdCores[1,1]},;
					{'!empty(PBW_NUMPRO)', aCdCores[2,1]},;
					{'!empty(PBW_NUMPRO)', aCdCores[4,1]} }
//PRIVATE cPath  := ""                        
PRIVATE cAlias := "PBW" 

PRIVATE cPerg	:= "CABA409"

PRIVATE cNomeProg   := "CABA409"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "G"
PRIVATE cTitulo     := "Controle de processos judiciais"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "caba409"
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
PRIVATE cCabec1     := "Controle de Processo judiciais"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
Private cFiltro     := ' '

private cUsu410   := subStr(cUSUARIO,7,15)  
private cUsu410J  := trim(GetMv("MV_USRJUR"))                                          
private cUsu410F  := trim(GetMv("MV_USRFIN"))  
private cUsu410R  := trim(GetMv("MV_USRREG"))  


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³         
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
dbselectarea("PBW")
PBW->(DBSetOrder(1))

//cFiltro:=cCompte  

//If cFiltro:="(substr(cTpProc,1,4) $ "ALER|DECO|MINI|PROC|RECE|ACAO|EXEC")"

//Para Filtrar por umA COMPTENCIA 
If ( __cUserID $ AllTrim(cUsu410J) )
     Set Filter to (substr(PBW->PBW_TPACAO,1,4) $ "ALER|DECO|MINI|PROC|RECE|ACAO|EXEC|OUTR")
//    cFiltro:= (substr(PBW->PBW_TPACAO,1,4) $ "ALER|DECO|MINI|PROC|RECE|ACAO|EXEC|OUTR")
ElseIf ( __cUserID $ AllTrim(cUsu410R) )
     Set Filter to (substr(PBW->PBW_TPACAO,1,3) $ "ANS|PAP|REP|REV|OUT")
//    cFiltro := (substr(PBW->PBW_TPACAO,1,4) $ "ANS|PAP|REPE|REVI|OUTR")
ElseIf ( __cUserID $ AllTrim(cUsu410F) )	 
     Set Filter to (substr(PBW->PBW_TPACAO,1,4) $ "1-PR|2-PR")
//    cfiltro := (substr(PBW->PBW_TPACAO,1,4) $ "1-PR|OUTR")
EndIf

//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , Nil    , aCores, , , ,nil, .T.))  
//PBW->(mBrowse(006,001,022,075,"PBW" , , , , , 2    , aCores, , , ,nil, .F., , ,cFiltro)) 
PBW->(mBrowse(006,001,022,075,"PBW" , , , , , 2    , aCores, , , ,nil, .F.)) 
//mBrowse(6, 1, 22, 75, "PBW",,,,,,aCores)
PBW->(DbClearFilter())
DbCloseArea()
Return()
              
a:='b'

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
User Function LEGPROS9()
Local aLegenda

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              		{ aCdCores[4,1],aCdCores[4,2] },;
	              		{ aCdCores[5,1],aCdCores[5,2] } }

	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return




