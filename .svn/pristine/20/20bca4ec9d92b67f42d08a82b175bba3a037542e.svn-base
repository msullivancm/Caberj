#include "PLSA090.ch" 
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
±±ºPrograma  ³NLGRPREV  ºAutor  ³ Jean Schulz        º Data ³  05/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de log de exportacao / importacao de arquivos para a  º±±
±±º          ³ Rio Previdencia.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NLGRPREV( )             

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina	:=	{	{ "Pesquisar"	, 'AxPesqui'		, 0, K_Pesquisar	},;
						{ "&Visualizar"	, 'AxVisual'		, 0, K_Visualizar	},;
						{ "E&xportar"	, 'U_EXPRIOPR'		, 0, K_Incluir		},;
						{ "&Composicao"	, 'U_COMRIOPR'		, 0, K_Incluir		},;
						{ "&Excluir"	, 'U_EXCRIOPR'		, 0, K_Excluir		},;
						{ "&Importar Erros"	, 'ERROPRE'	, 0, K_Incluir		},;
						{ "&Importar Baixa"	, 'U_UUUPPREVI'	, 0, K_Incluir		},;
						{ "&Verifica"   , 'U_VERBXPRE'		, 0, K_Incluir		},;
						{ "&Baixar"	    , 'U_IMPRIOPR'		, 0, K_Incluir		},;
						{ "Legenda"		, 'U_LEGRIOPR(1)'	, 0, K_Incluir		} }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro	:= "Log de envio/receb. arquivos Rio Previdência"

PRIVATE aCdCores	:= { 	{ 'BR_VERDE'    ,'Arquivo Gerado' },;
							{ 'BR_AZUL'     ,'Arquivo Exportado e Importado' } }

PRIVATE aCores	:= {{'ZZ4_STATUS = "1"', aCdCores[1,1]},;
					{'ZZ4_STATUS = "2"', aCdCores[2,1]}	}
PRIVATE cPath  := ""                        
PRIVATE cAlias := "ZZ4" 

PRIVATE cPerg	:= "PLYRPR"

PRIVATE cNomeProg   := "IMPRIOPR"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "M"
PRIVATE cTitulo     := "Imp. Rio Previdência"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "IMPRIOPR"
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
PRIVATE cCabec1     := "Importação Rio Previdência"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00

// Dados do banco, agencia e conta 
// p/ realizar a movimentação bancária.
Private cBanco		:= "341"
Private cAgencia	:= "6015 "
Private cConta		:= "017251"
Private cLote		:= ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ZZ4->(DBSetOrder(1))
ZZ4->(mBrowse(006,001,022,075,"ZZ4" , , , , , Nil    , aCores, , , ,nil, .T.))
ZZ5->(DbClearFilter())

Return
              
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ EXPRIOPR   ³ Autor ³ Jean Schulz       ³ Data ³ 05.09.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Importa Arquivo de Usuario para Layout Padrao.             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function EXPRIOPR(cAlias,nReg,nOpc)
LOCAL oDlg
LOCAL nOpca   := 0
LOCAL oEnc
LOCAL aRet
LOCAL bOK		:= { || nOpca := 1, oDlg:End() }
LOCAL bCancel	:= { || nOpca := 0, oDlg:End() }
LOCAL aCampos := {}
local i__f

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Enchoice...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
COPY "ZZ4" TO Memory Blank

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define dialogo...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()

oEnc := ZZ4->(MsMGet():New(cAlias,nReg,nOpc,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa o dialogo...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define tratamento de acordo com a opcao...                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpca == K_OK
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inclui movimento...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aRet := EXPARQRIO(oEnc:aGets,oEnc:aTela,"",oDlg)
	M->ZZ4_QTDENV	:= aRet[1]
	M->ZZ4_VALREM	:= aRet[2]
	M->ZZ4_DATREM	:= dDatabase
	ZZ4->(PLUPTENC("ZZ4",K_Incluir))
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ EXPARQRIO  ³ Autor ³ Jean Schulz       ³ Data ³ 05.09.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Trata rotina externa                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function EXPARQRIO(aGets,aTela,cNomArq,oDlg)
LOCAL aRet := {0,0}

Private nBytes := 0 
Private cTitulo := "Export. Rio Previdência"
PRIVATE nHdl
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa campos obrigatorios...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! Obrigatorio(aGets,aTela)
	Return(aRet)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera a exportacao do arquivo RIO PREVIDENCIA...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| aRet := GeraExport() } , cTitulo                           , "", .T.)

Return aRet


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
User Function LEGRIOPR(nTipLeg)
Local aLegenda

If nTipLeg = 2

	aCdCores  	:= { 	{ 'BR_VERDE'       ,'Enviado' }		,;
						{ 'BR_VERMELHO'    ,'Erro Envio Detectado'},;
						{ 'BR_AZUL'        ,'Baixa Autorizada' }	,;
						{ 'BR_AMARELO'     ,'Baixa Não Autorizada' } }
						
	aCores      := {	{ 'ZZ5_STATUS = "1"',aCdCores[1,1] },;
						{ 'ZZ5_STATUS = "2"',aCdCores[2,1] },;
						{ 'ZZ5_STATUS = "3"',aCdCores[3,1] },;						
						{ 'ZZ5_STATUS = "4"',aCdCores[4,1] } }                           

	aLegenda 	:= { 	{ aCdCores[1,1],aCdCores[1,2] },;
						{ aCdCores[2,1],aCdCores[2,2] },;
						{ aCdCores[3,1],aCdCores[3,2] },;
	              		{ aCdCores[4,1],aCdCores[4,2] } }
Else
	aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
					{ aCdCores[2,1],aCdCores[2,2] } }
Endif
	                     	
BrwLegenda(cCadastro,"Status" ,aLegenda)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ EXCRIOPR   ³ Autor ³ Jean Schulz       ³ Data ³ 05.09.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exclui o arquivo e sua composicao                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function EXCRIOPR(cAlias,nReg,nOpc)
LOCAL oDlg
LOCAL nOpca   := 0
LOCAL oEnc
LOCAL bOK     := { || nOpca := 1, oDlg:End() }
LOCAL bCancel := { || oDlg:End() }
LOCAL cPreRem := ZZ4->ZZ4_PREREM
LOCAL cCodRem := ZZ4->ZZ4_CODREM
local i__f

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define dialogo...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Enchoice...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Copy cAlias To Memory

oEnc := ZZ4->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa o dialogo...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define tratamento de acordo com a opcao...                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpca == K_OK
                                            
    If ZZ4->ZZ4_STATUS <> "1"
       MsgInfo("Nao e possivel excluir! Arquivo já importado!")
	Else

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Deleta todas as linhas do arquivo excluido...                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BEGIN TRANSACTION
		
		
		cSQL := " SELECT ZZ5_PRETIT, ZZ5_NUMTIT, ZZ5_PARTIT, ZZ5_TIPTIT "
		cSQL += " FROM "+RetSQLName("ZZ5")
		cSQL += " WHERE ZZ5_FILIAL = '"+xFilial("ZZ5")+"' " 
		cSQL += " AND ZZ5_PREREM = '"+cPreRem+"' "
		cSQL += " AND ZZ5_CODREM = '"+cCodRem+"' "
		cSQL += " AND D_E_L_E_T_ = ' ' "
		cSQL += " GROUP BY ZZ5_PRETIT, ZZ5_NUMTIT, ZZ5_PARTIT, ZZ5_TIPTIT "
		
		PLSQuery(cSQL,"TRB")		
		
		TRB->(DbGotop())
		
		While !TRB->(Eof())
		
			If SE1->(MsSeek(xFilial("SE1")+TRB->(ZZ5_PRETIT+ZZ5_NUMTIT+ZZ5_PARTIT+ZZ5_TIPTIT)))
				SE1->(Reclock("SE1",.F.))
				SE1->E1_YTPEXP	:= ""
				SE1->E1_YTPEDSC	:= ""
				SE1->(MsUnlock())			
			Endif
			
			TRB->(DbSkip())	
		Enddo
		
		TRB->(DbCloseArea())		

		/*cSQL := " DELETE FROM " + RetSQLName("ZZ5")+" "
		cSQL += " WHERE ZZ5_FILIAL = '"+xFilial("ZZ5")+"' " 
		cSQL += " AND ZZ5_PREREM = '"+cPreRem+"' "
		cSQL += " AND ZZ5_CODREM = '"+cCodRem+"' "
		cSQL += " AND D_E_L_E_T_ = ' '"
		PLSSQLEXEC(cSQL)
        */ 
        
        dbSelectArea("ZZ5")
        dbSetOrder(1)
        If dbSeeK( xFilial("ZZ5") + cPreRem + cCodRem )
        
        	While !ZZ5->( EOF() ) .AND. ZZ5->ZZ5_PREREM == cPreRem .and. ZZ5->ZZ5_CODREM = cCodRem     
        	
        			ZZ5->(RecLock("ZZ5",.F.))   
        			
						ZZ5->(dbDelete())
					
					ZZ5->(MsUnlock())
        	                               
        		ZZ5->( dbSkip() )
        	
        	EndDo
        
        EndIf
        
		ZZ4->(PLUPTENC("ZZ4",K_Excluir))
		
		END TRANSACTION
		
	Endif

Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ COMRIOPR   ³ Autor ³ Antonio de Padua    ³ Data ³ 28.08.03 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Mostra Composicao do Arquivo                               ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function COMRIOPR()
Private aFilAdic := {.T.,"('01','02')"}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³                                
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina   	:=	{	{ "Pesquisar"	    , 'AxPesqui'	  , 0 , K_Pesquisar  },;
{ "Visualizar"	, 'AxVisual'	    , 0 , K_Visualizar } ,;
{ "Legenda"     , "U_LEGRIOPR(2)"	, 0 , K_Incluir     },;
{ "Filtro"      , "U_FILRIOPR"	    , 0 , K_Incluir     } }

ZZ5->(DbClearFilter())

aCdCores  	:= { 	{ 'BR_VERDE'       ,'Enviado' }		,;
					{ 'BR_VERMELHO'    ,'Erro Detectado'},;
					{ 'BR_AZUL'        ,'Baixa Autorizada' }	,;
					{ 'BR_AMARELO'     ,'Baixa Não Autorizada' } }
aCores      := {	{ 'ZZ5_STATUS = "1"',aCdCores[1,1] },;
					{ 'ZZ5_STATUS = "2"',aCdCores[2,1] },;
					{ 'ZZ5_STATUS = "3"',aCdCores[3,1] },;						
					{ 'ZZ5_STATUS = "4"',aCdCores[4,1] } }                           

PRIVATE cAlias    := "ZZ5"

PRIVATE cFil := ""

cFil := "@ZZ5_FILIAL = '"+xFilial("ZZ5")+"'"
cFil += " AND ZZ5_PREREM = '"+ZZ4->ZZ4_PREREM+"' "
cFil += " AND ZZ5_CODREM = '"+ZZ4->ZZ4_CODREM+"' "
cFil += " AND D_E_L_E_T_ = ' '"

ZZ5->(DBSetOrder(1))
DbSelectArea("ZZ5")
SET FILTER TO &cFil
                                                                                            
ZZ5->(mBrowse(006,001,022,075,"ZZ5" ,nil ,nil ,nil ,nil , 4    , aCores,nil ,nil ,nil ,,.T.,nil))
ZZ5->(DbClearFilter())

aCdCores  	:= { 	{ 'BR_VERDE'		,'Arquivo Gerado' }				,;
					{ 'BR_AZUL'			,'Arquivo Exportado e Importado' }	}
aCores      := {	{ 'ZZ4_STATUS = "1"',aCdCores[1,1] }	,;
					{ 'ZZ4_STATUS = "2"',aCdCores[2,1] }	}                           
cAlias		:= "ZZ5"
cFil		:= ""

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GeraExportºAutor  ³Jean Schulz         º Data ³  06/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera exportacao para Rio Previdencia, conforme parametros   º±±
±±º          ³repassados anteriormente...                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GeraExport

Local nLin		:= 100
Local cSQL      := ""
Local nReg		:= 0
Local cDirExp	:= GETNEWPAR("MV_YLGRIPR","\interface\exporta\RioPrevi\")
Local cEOL		:= CHR(13)+CHR(10)
Local cCpo		:= ""
Local nCont		:= 0

Local aCritica	:= {}
Local aDetalhe	:= {}
Local aExpVal	:= {}
Local aExpTit	:= {}
Local cMatEmp	:= ""
Local cMatric	:= ""
Local cNomUsr	:= ""
Local nPos		:= 0
Local nSeq		:= 0
Local nVlrTot	:= 0
Local aRet		:= {0,0}

Local cPreTit	:= ""
Local cNumTit	:= ""
Local cParTit	:= ""
Local cTipTit	:= ""

Local cCodErr	:= "0"
Local _cCodEve 	:= ""
Local _nRecNoBA1:= 0
Local _nRec		:= 0
Local _nVlrRes	:= 0
Local _nVlrCob	:= 0
Local aExpValClo:= {}
Local _nAjusta	:= 0
Local lExisOdo	:= .F.
Local _nVlrOdo	:= 0
Local _nPosCop	:= 0

Local nContNeg	:= 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define indices e tabelas para uso.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SE1->(DbSetOrder(1))
BA1->(DbSetOrder(2))
BHH->(DbSetOrder(1))
BSP->(DbSetOrder(1))
BSQ->(DbSetOrder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacao para emitir somente se nao houverem titulos som. de copart³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := " SELECT Count(BM1F.R_E_C_N_O_ ) AS TOTAL 	"
cSQL += " FROM "+RetSQLName("BM1")+" BM1F, "+RetSQLName("BA3")+" BA3, "+RetSQLName("SE1")+ " SE1 " 
cSQL += " WHERE BM1F.BM1_FILIAL = '"+xFilial("BM1")+"' "
cSQL += " AND BM1F.BM1_MES = '"+M->ZZ4_MESREM+"' "
cSQL += " AND BM1F.BM1_ANO = '"+M->ZZ4_ANOREM+"' "
cSQL += " AND BA3_FILIAL = '"+xFilial("BA3")+"' "
cSQL += " AND BM1F.BM1_CODINT = BA3_CODINT "
cSQL += " AND BM1F.BM1_CODEMP = BA3_CODEMP "
cSQL += " AND BM1F.BM1_MATRIC = BA3_MATRIC "
cSQL += " AND E1_FILIAL = '"+xFilial("SE1")+"' "
cSQL += " AND E1_PREFIXO = BM1_PREFIX "
cSQL += " AND E1_NUM = BM1_NUMTIT "
cSQL += " AND E1_PARCELA = BM1_PARCEL "
cSQL += " AND E1_TIPO = BM1_TIPTIT "
cSQL += " AND E1_YTPEXP = ' ' " 

If M->ZZ4_TIPREM == "2" //Previ
	cSQL += " AND BA3_GRPCOB IN ("+GetNewPar("MV_YGRIOP","'1001','1002','1003'")+") "
ElseIf M->ZZ4_TIPREM == "3" //BERJ
	cSQL += " AND BA3_GRPCOB IN ("+GetNewPar("MV_YGBERJ","'1500'")+") "
Else //Controle de erros - nao envia nada...
	cSQL += " AND 0 = 1 "
Endif

cSQL += " AND BA3_TIPPAG <> '00' "
cSQL += " AND E1_FORMREC <> '00' "
cSQL += " AND E1_FORMREC <> ' ' " 
cSQL += " AND ( BA3_DATBLO = ' ' AND ( " 
cSQL += "   SELECT Count(R_E_C_N_O_) "
cSQL += "   FROM BA1010 "
cSQL += "   WHERE BA1_FILIAL = '  ' "
cSQL += "   AND BA1_CODINT = BA3_CODINT "
cSQL += "   AND BA1_CODEMP = BA3_CODEMP "
cSQL += "   AND BA1_MATRIC = BA3_MATRIC " 
cSQL += "   AND BA1_DATBLO = ' ' " 
cSQL += "   AND BA1010.D_E_L_E_T_ = ' ' "
cSQL += "  ) > 0 ) "
cSQL += " AND ( "
cSQL += "   SELECT Count(R_E_C_N_O_) "
cSQL += "   FROM BM1010 BM1I  "
cSQL += "   WHERE BM1I.BM1_FILIAL = BM1F.BM1_FILIAL "
cSQL += "   AND BM1I.BM1_PREFIX = BM1F.BM1_PREFIX "
cSQL += "   AND BM1I.BM1_NUMTIT = BM1F.BM1_NUMTIT "
cSQL += "   AND BM1I.BM1_PARCEL = BM1F.BM1_PARCEL "
cSQL += "   AND BM1I.BM1_TIPTIT = BM1F.BM1_TIPTIT "
cSQL += "   AND BM1I.BM1_CODTIP = '101' "
cSQL += "   AND BM1I.D_E_L_E_T_ = ' ' "
cSQL += " ) = 0 "
cSQL += " AND BM1F.D_E_L_E_T_ = ' ' "
cSQL += " AND BA3.D_E_L_E_T_ = ' ' "
cSQL += " AND SE1.D_E_L_E_T_ = ' ' " 


PLSQuery(cSQL,"TRB")
	
If TRB->TOTAL > 0
	MsgAlert("Existem títulos a serem exportados para Rio Previdência sem mensalidade! Impossível continuar! Geração abortada!")
	TRB->(DbCloseArea())		
	Return {0,0}
Endif
TRB->(DbCloseArea())	


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso nao exista nenhum titulo somente com copart, continuar a rotina³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCont := 1 to 2

	If nCont = 1
		cSQL := " SELECT COUNT("+RetSQLName("BM1")+".R_E_C_N_O_) AS TOTAL "
	Else
		cSQL := " SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO, BM1_CONEMP, BM1_VERCON, BM1_SUBCON, BM1_VERSUB,  "
		cSQL += " BM1_MES, BM1_ANO, BM1_VALOR, BM1_CODTIP, BM1_CODEVE, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, "
		cSQL += " BA3_VALSAL, BA3_DATBLO, BA3_MOTBLO , BA3_CODPLA, BA3_MATEMP, BA3_TIPPAG, BA3_GRPCOB "
	Endif
	
	cSQL += " FROM "+RetSQLName("BM1")+", "+RetSQLName("BA3")+", "+RetSQLName("SE1")
	cSQL += " WHERE BM1_FILIAL = '"+xFilial("BM1")+ "' "
	cSQL += " AND BM1_CODINT = '"+M->ZZ4_CODINT+ "' "
	cSQL += " AND BM1_ANO = '"+M->ZZ4_ANOREM+"' "
	cSQL += " AND BM1_MES = '"+M->ZZ4_MESREM+"' "
	cSQL += " AND BA3_FILIAL = '"+xFilial("BA3")+ "' "
	cSQL += " AND BM1_CODINT = BA3_CODINT "
	cSQL += " AND BM1_CODEMP = BA3_CODEMP "
	cSQL += " AND BM1_MATRIC = BA3_MATRIC "
	
	//NAO ENVIAR OS CASOS PARA O MES 11/07
	/*
	cSQL += " AND BM1_CODTIP <> '937' " 
	cSQL += " AND BM1_CODTIP <> '102' "
	cSQL += " AND BM1_CODINT||BM1_CODEMP||BM1_MATRIC <> '00010001020987' "
	cSQL += " AND BM1_PLNUCO = '000100000510' "
	*/
	//Nova implementacao: filtro por grupo de cobranca.
	
	If M->ZZ4_TIPREM == "2" //Previ
		cSQL += " AND BA3_GRPCOB IN ("+GetNewPar("MV_YGRIOP","'1001','1002','1003'")+") "
	ElseIf M->ZZ4_TIPREM == "3" //BERJ
		cSQL += " AND BA3_GRPCOB IN ("+GetNewPar("MV_YGBERJ","'1500'")+") "
	Else //Controle de erros - nao envia nada...
		cSQL += " AND 0 = 1 "
	Endif
	
	cSQL += " AND (BA3_TIPPAG <> '00') "
	cSQL += " AND E1_FORMREC <> '00' "
	cSQL += " AND E1_FORMREC <> ' ' "    
	If M->ZZ4_TIPREM == "2" //Previ
	  cSQL += " AND E1_FORMREC IN ('01','08') "
	Endif
	//Fim da nova implementacao: filtro por grupo de cobranca.	
	cSQL += " AND E1_FILIAL  = '"+xFilial("SE1")+ "' "
	cSQL += " AND E1_PREFIXO = BM1_PREFIX "
	cSQL += " AND E1_NUM     = BM1_NUMTIT "
	cSQL += " AND E1_PARCELA = BM1_PARCEL "
	cSQL += " AND E1_TIPO    = BM1_TIPTIT "
	cSQL += " AND E1_YTPEXP = ' ' "
	cSQL += " AND "+RetSQLName("BM1")+".D_E_L_E_T_ <> '*' " 
	cSQL += " AND "+RetSQLName("BA3")+".D_E_L_E_T_ <> '*' " 
	cSQL += " AND "+RetSQLName("SE1")+".D_E_L_E_T_ <> '*' " 	
	
	//Raios
	/*
	MsgAlert("Atencao! Processo nao esta sendo gerado por completo! AVISE A INFORMATICA!!!")
	cSQL += " AND BA3_CODINT = '0001' AND BA3_CODEMP = '0001' AND BA3_MATRIC <= '002795' "
	*/
	
	If nCont > 1
		cSQL += " ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG "   		
	Endif
	
	PLSQuery(cSQL,"TRB")
	
	If nCont = 1
		nTotReg := TRB->TOTAL
		TRB->(DbCloseArea())	

		If nTotReg <= 0
			Help("",1,"RECNO")
			Return aRet
		Endif				
		
	Endif
	
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Geracao do texto para empresa...     	  ³  
//³ Formato do nome: REMNNNNN.TXT onde:       ³  
//³ REM: Indica a arquivo de remessa     	  ³  
//³ NNNNN: Sequencial de remessa do arquivo.  ³  
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ProcRegua(nTotReg)
cNomeArq := cDirExp+M->(ZZ4_PREREM+ZZ4_CODREM)+".TXT"

cDatRem := DtoS(M->ZZ4_DATREM)
cDatRem := Substr(cDatRem,7,2)+"/"+Substr(cDatRem,5,2)+"/"+Substr(cDatRem,1,4)

If nTotReg > 0

	If U_Cria_TXT(cNomeArq)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de cabecalho...                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cLin := Space(1)+cEOL

	/*	cCpo := "890"
		cCpo += "30100100001" // Filler
		cCpo += "00" // Ordem
           mbc
		 
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O CABEÇALHO! OPERAÇÃO ABORTADA!")
			Return aRet
		Endif	
	         */
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha detalhe...                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		While ! TRB->(EOF())
		
			nReg++
			IncProc("Registro: "+StrZero(nReg,6)+"/"+StrZero(nTotReg,6))
		
			If TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO) <> cMatric .And. cMatric <> ""
			
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Regra para abatimento odontologico (Rio Previdencia).               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
				If lExisOdo
					
					_nPosCop := ascan(aExpVal,{|x| x[1] == "621"})
					
					If _nPosCop = 0
						_nPosCop := ascan(aExpVal,{|x| x[1] == "625"})
					Endif
					
					If _nPosCop > 0
						aExpVal[_nPosCop,2] -= _nVlrOdo
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Array para critica caso valor da composicao seja negativo...        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
						If aExpVal[_nPosCop,2] < 0
						
							For nContNeg := 1 to Len(aExpVal)
								aExpVal[nContNeg,3] := "1" //Valor Negativo
								
							Next
							aadd(aCritica,{"Usuário com item menor que zero! "+cMatric})
						Endif							
												
					Endif
					
					//Reduzir valor do "RES"
					_nPosCop := ascan(aExpVal,{|x| x[1] == "RES"})
					
					If _nPosCop > 0
						aExpVal[_nPosCop,2] -= _nVlrOdo

						If aExpVal[_nPosCop,2] <= 0 
							adel(aExpVal,_nPosCop)
							asize(aExpVal,Len(aExpVal)-1)
						Endif
						
					Endif									
					
				Endif

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Conforme solicitado, tratar como unica verba caso exista credito... ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
				//Regra de aglutinacao desativada...
				//Nova regra: nao enviar nenhuma verba de credito...
				_nRec := aScan(aExpVal,{|x| x[1] == "RES"})
				
				//Nova regra definida por Caberj
				If _nRec > 0
					aExpVal[_nRec,3] := "3" //Creditos diversos / nao enviar...
				Endif
				
				/*
				//Regra de aglutinacao desativada...
				If _nRec > 0
					aExpValClo := aClone(aExpVal)
					
					asort(aExpValClo,,,{|x,y| x[1] < y[1]})
					
					//Montar a nova matriz aExpVal, com o valor zerado do 1o item...
					aExpVal := {}
					aadd(aExpVal,{aExpValClo[1,1],0,aExpValClo[1,3]})
					
					_nVlrRes := 0
					_nVlrCob := 0
					
					//Ajustar o valor e inserir em aExpVal
					For _nAjusta := 1 To Len(aExpValClo)
						If aExpValClo[_nAjusta,1] == "RES"
							_nVlrRes += aExpValClo[_nAjusta,2]
						Else
							_nVlrCob += aExpValClo[_nAjusta,2]
						Endif
					Next
					aExpVal[1,2] := _nVlrCob-_nVlrRes
					
					If aExpVal[1,2] < 0
						aExpVal[1,3] := "1" //Valor Negativo
					Endif     
					
					aExpValClo :={}
					
				Endif		
				*/
			
				For nCont := 1 to Len(aExpVal)
	
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Valida criticas de exportacao. Caso nao encontre, exportar...       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
					If aExpVal[nCont,3] == "0"
					
						nSeq++		
						cLin := Space(1)+cEOL
					  	cCpo := "1"+cMatEmp+space(11)+cNomUsr+StrZero((aExpVal[nCont,2])*100,13)+aExpVal[nCont,1]+StrZero(nSeq,7)+space(40)+Substr(cMatric,1,16)
					  //	cCpo := Alltrim(cMatEmp)+Space(15-Len(Alltrim(cMatEmp)))+cMatric+aExpVal[nCont,1]+StrZero((aExpVal[nCont,2])*100,12)+cSequen
						
						If !(U_GrLinha_TXT(cCpo,cLin))
							MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O REGISTRO DETALHE! OPERAÇÃO ABORTADA!")
							Return aRet
						Endif		
						
					Endif
								
					ZZ5->(RecLock("ZZ5",.T.))
					ZZ5->ZZ5_FILIAL	:= xFilial("ZZ5")
					ZZ5->ZZ5_STATUS	:= Iif(aExpVal[nCont,3]=="0","1","2")
					ZZ5->ZZ5_PREREM	:= M->ZZ4_PREREM
					ZZ5->ZZ5_CODREM := M->ZZ4_CODREM
					ZZ5->ZZ5_PRETIT := cPreTit
					ZZ5->ZZ5_NUMTIT := cNumTit
					ZZ5->ZZ5_PARTIT := cParTit
					ZZ5->ZZ5_TIPTIT := cTipTit
					ZZ5->ZZ5_CODINT := Substr(cMatric,1,4)
					ZZ5->ZZ5_CODEMP := Substr(cMatric,5,4)
					ZZ5->ZZ5_MATRIC := Substr(cMatric,9,6)
					ZZ5->ZZ5_TIPREG := Substr(cMatric,15,2)
					ZZ5->ZZ5_DIGITO := Substr(cMatric,17,1)
					ZZ5->ZZ5_CODDES := aExpVal[nCont,1]
					ZZ5->ZZ5_VLRDES := aExpVal[nCont,2]     
					ZZ5->ZZ5_CODERR := aExpVal[nCont,3]
					**'Marcela Coimbra - 03/02/2012 - Cadastro código do evento na ZZ5 para conferência furtura'**
					ZZ5->ZZ5_CODEVE := aExpVal[nCont,4]
					**'Marcela Coimbra - 03/02/2012 - Fim - Cadastro código do evento na ZZ5 para conferência furtura'**
								
					ZZ5->(MsUnlock())         
					
					nPos := aScan(aExpTit,SE1->(Recno()))
					
					If ZZ5->ZZ5_CODERR == "0"
						nVlrTot += ZZ5->ZZ5_VLRDES
					Endif
					
					If nPos == 0
						aadd(aExpTit,SE1->(Recno()))
					Endif
								
				Next
				
				cMatEmp := ""
				cNomUsr := ""
				cPreTit	:= ""
				cNumTit	:= ""
				cParTit	:= ""
				cTipTit	:= ""								
				aExpVal := {}
				cCodErr := "0"
				lExisOdo:= .F.
				_nVlrOdo:= 0
				
			Endif
			
			cMatric	:= TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)
			cPreTit	:= TRB->BM1_PREFIX
			cNumTit	:= TRB->BM1_NUMTIT
			cParTit	:= TRB->BM1_PARCEL		
			cTipTit	:= TRB->BM1_TIPTIT
							
			If ! SE1->(DbSeek(xFilial("SE1")+TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)))
				MsgAlert("TITULO: "+TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)+" NÃO ENCONTRADO NO CTS A RECEBER! OPERAÇÃO ABORTADA!" )
				Return aRet                             	
			Else        
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Caso o titulo ja tenha sido enviado, nao reenviar...                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
				If !Empty(SE1->E1_YTPEXP)
					aadd(aCritica,{"Título já exportado em outra remessa! "+SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)})
					TRB->(DbSkip())
					Loop
				Endif   
				
				If SE1->E1_SALDO <= 0
					aadd(aCritica,{"Título com saldo menor ou igual a zero! "+TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)})
					TRB->(DBSkip())
					Loop
				Endif  
				
				
				If SE1->(E1_ANOBASE+E1_MESBASE)	>= Substr(DtoS(TRB->BA3_DATBLO),1,6) .And. !Empty(TRB->BA3_DATBLO)
					cCodErr := "9" //Familia bloqueada...
				Endif    
				
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Array para critica caso valor da composicao seja negativo...        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If TRB->BM1_VALOR < 0
				cCodErr := "1" //Valor Negativo
			Endif	
			
			//Criticar caso salario menor que 700 e Rio Prev.			
			If TRB->BA3_VALSAL < GetNewPar("MV_YVLSLP",700) .And. TRB->BA3_TIPPAG = '01' .And. TRB->BA3_GRPCOB $ GetNewPar("MV_YGRIOP","'0001','1001','1002','1003'")
				aadd(aCritica,{"Usuário não encontrado no cadastro! "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)})      
				Alert("1" + TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO) )
				cCodErr := "8" //Salario incompativel com Rio Prev
			Endif
			
			If ! BA1->(MsSeek(xFilial("BA1")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)))			
				aadd(aCritica,{"Usuário não encontrado no cadastro! "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)})
				
				Alert("1" + TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO) )
				
				TRB->(DBSkip())
				Loop	
			Else
			    //cMatEmp := Alltrim(Substr(BA1->BA1_MATEMP,1,9))+Space(9-Len(Alltrim(Substr(BA1->BA1_MATEMP,1,9))))
   				cMatEmp := Replicate('0',(9-Len(Alltrim(Substr(TRB->BA3_MATEMP,1,9))))) + Alltrim(Substr(TRB->BA3_MATEMP,1,9))
   				// Motta 14/8/7
   				cNomUsr	:= alltrim(BA1->BA1_NOMUSR)+space(50-Len(alltrim(BA1->BA1_NOMUSR)))
				
			    //MELHORIA JEAN
			    //BUSCA NO TITULAR
			    If Empty(alltrim(cMatEmp))
				    _nRecNoBA1 := BA1->(Recno())
	   			    If BA1->(MsSeek(xFilial("BA1")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+"00")))
					   //cMatEmp := Alltrim(Substr(BA1->BA1_MATEMP,1,9))+Space(9-Len(Alltrim(Substr(BA1->BA1_MATEMP,1,9))))
	   			       	cMatEmp := Replicate('0',(9-Len(Alltrim(Substr(TRB->BA3_MATEMP,1,9))))) + Alltrim(Substr(TRB->BA3_MATEMP,1,9))
   				        // Motta 14/8/7
	   			    Endif
				    BA1->(DbGoTo(_nRecNoBA1))
			    Endif

				//BUSCA NA FAMILIA
			    If Empty(alltrim(cMatEmp))
					//cMatEmp := Alltrim(Substr(BA1->BA1_MATEMP,1,9))+Space(9-Len(Alltrim(Substr(BA1->BA1_MATEMP,1,9))))
					cMatEmp := Replicate('0',(9-Len(Alltrim(Substr(TRB->BA3_MATEMP,1,9))))) + Alltrim(Substr(TRB->BA3_MATEMP,1,9))
   			     	// Motta 14/8/7
			    Endif			    			    			    
			    //FIM MELHORIA JEAN  
								
				If Empty(alltrim(cMatEmp)) 
					aadd(aCritica,{"Usuário não possui matrícula funcional! "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)})
					TRB->(DBSkip())
					Loop				
				Endif
			Endif
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Array para critica caso usuario possua processo judicial...         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ					
			//Comentado em 18/10/07
			/*			
			If BHH->(MsSeek(xFilial("BHH")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)))
			
				While !BHH->(Eof()) .And. TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC) == BHH->(BHH_CODINT+BHH_CODEMP+BHH_MATRIC)
				
				    If BHH->BHH_CODSAD $ GetNewPar("MV_YSITADV","004,005")
				    	cCodErr := "2" //Processo Judicial
				    	Exit
				    Endif
			    	BHH->(DbSkip())
			    
			    Enddo
			    
			Endif   
			*/
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se existe credito odontologico. Se existir, abater da copart.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If Alltrim(TRB->BM1_CODEVE) == GetNewPar("MV_YCDLCOD","994")
				lExisOdo := .T.
				_nVlrOdo := TRB->BM1_VALOR
			Endif			
			//Jean - Fim do odontologico...
			
			_cCodEve := Alltrim(TRB->BM1_CODEVE)
			If Len(Alltrim(_cCodEve)) < 4 //.And. Alltrim(_cCodEve) $ "116,127"
				_cCodEve := Alltrim(TRB->BA3_CODPLA)
			Endif
			
			If ! ZZ3->(MsSeek(xFilial("ZZ3")+Alltrim(TRB->BM1_CODTIP)+Alltrim(_cCodEve)+"001"))
				aadd(aCritica,{"De x Para de lançamentos de faturamento não encontrado! Lançamento: "+TRB->BM1_CODTIP+" Produto: "+;
				                Alltrim(_cCodEve)+" Usuário: "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)})
				TRB->(DBSkip())
				Loop				
			Else
			
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verificar se linha ja foi exportada, e analisada...                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ZZ5->(MsSeek(xFilial("ZZ5")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO+BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)+ZZ3->ZZ3_CODDES)) .And. !(ZZ5->ZZ5_STATUS $ "1,2")
					aadd(aCritica,{"Item de faturamento já enviado! Usuario: "+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)+" Titulo: "+TRB->(BM1_PREFIX+BM1_NUMTIT+BM1_PARCEL+BM1_TIPTIT)+" Despesa: "+ZZ3->ZZ3_CODDES})
					TRB->(DbSkip())	
					Loop
				Endif
	
				nPos := aScan(aExpVal,{|x| x[1] == ZZ3->ZZ3_CODDES})
				
				If nPos > 0
					aExpVal[nPos,2] += TRB->BM1_VALOR
					/*
					If aExpVal[nPos,3] == "0"
						nVlrTot += TRB->BM1_VALOR
					Endif
					*/
				Else 
					aadd(aExpVal,{ZZ3->ZZ3_CODDES,TRB->BM1_VALOR,cCodErr, ZZ3->ZZ3_CODPRO})
					/*
					If cCodErr == "0"
						nVlrTot += TRB->BM1_VALOR
					Endif
					*/
				Endif
				
			Endif
				
			TRB->(DbSkip())
			                                             
		Enddo
		
		TRB->(DbCloseArea())

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprimir as ultimas linhas da exportacao...                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Conforme solicitado, tratar como unica verba caso exista credito... ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Regra para abatimento odontologico (Rio Previdencia).               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
		If lExisOdo
			
			_nPosCop := ascan(aExpVal,{|x| x[1] == "621"})
			
			If _nPosCop = 0
				_nPosCop := ascan(aExpVal,{|x| x[1] == "625"})
			Endif
			
			If _nPosCop > 0
				aExpVal[_nPosCop,2] -= _nVlrOdo
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Array para critica caso valor da composicao seja negativo...        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
				If aExpVal[_nPosCop,2] < 0
					For nContNeg := 1 to Len(aExpVal)
						aExpVal[nContNeg,3] := "1" //Valor Negativo
					Next
					aadd(aCritica,{"Usuário com item menor que zero! "+cMatric})
				Endif							
				
			Endif

			//Reduzir valor do "RES"
			_nPosCop := ascan(aExpVal,{|x| x[1] == "RES"})
			
			If _nPosCop > 0
				aExpVal[_nPosCop,2] -= _nVlrOdo
				
				If aExpVal[_nPosCop,2] <= 0 
					adel(aExpVal,_nPosCop)
					asize(aExpVal,Len(aExpVal)-1)
				Endif
				
			Endif			
			
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Conforme solicitado, tratar como unica verba caso exista credito... ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
		//Regra de aglutinacao desativada...
		//Nova regra: nao enviar nenhuma verba de credito...
		_nRec := aScan(aExpVal,{|x| x[1] == "RES"})
		
		//Nova regra definida por Caberj
		If _nRec > 0
			aExpVal[_nRec,3] := "3" //Creditos diversos / nao enviar...
		Endif
		
		For nCont := 1 to Len(aExpVal)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Valida criticas de exportacao. Caso nao encontre, exportar...       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
			If aExpVal[nCont,3] == "0"
			
				nSeq++		
				cLin := Space(1)+cEOL
				cCpo := "1"+cMatEmp+space(11)+cNomUsr+StrZero((aExpVal[nCont,2])*100,13)+aExpVal[nCont,1]+StrZero(nSeq,7)+space(40)+Substr(cMatric,1,16)
				//cCpo := Alltrim(cMatEmp)+Space(15-Len(Alltrim(cMatEmp)))+cMatric+aExpVal[nCont,1]+StrZero((aExpVal[nCont,2])*100,12)+cSequen
				
				If !(U_GrLinha_TXT(cCpo,cLin))
					MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O REGISTRO DETALHE! OPERAÇÃO ABORTADA!")
					Return aRet
				Endif		
				
			Endif
			
			ZZ5->(RecLock("ZZ5",.T.))
			ZZ5->ZZ5_FILIAL	:= xFilial("ZZ5")
			ZZ5->ZZ5_STATUS	:= Iif(aExpVal[nCont,3]=="0","1","2")
			ZZ5->ZZ5_PREREM	:= M->ZZ4_PREREM
			ZZ5->ZZ5_CODREM := M->ZZ4_CODREM
			ZZ5->ZZ5_PRETIT := cPreTit
			ZZ5->ZZ5_NUMTIT := cNumTit
			ZZ5->ZZ5_PARTIT := cParTit
			ZZ5->ZZ5_TIPTIT := cTipTit
			ZZ5->ZZ5_CODINT := Substr(cMatric,1,4)
			ZZ5->ZZ5_CODEMP := Substr(cMatric,5,4)
			ZZ5->ZZ5_MATRIC := Substr(cMatric,9,6)
			ZZ5->ZZ5_TIPREG := Substr(cMatric,15,2)
			ZZ5->ZZ5_DIGITO := Substr(cMatric,17,1)
			ZZ5->ZZ5_CODDES := aExpVal[nCont,1]
			ZZ5->ZZ5_VLRDES := aExpVal[nCont,2]     
			ZZ5->ZZ5_CODERR := aExpVal[nCont,3]
			**'Marcela Coimbra - 03/02/2012 - Cadastro código do evento na ZZ5 para conferência furtura'** 
			ZZ5->ZZ5_CODEVE := aExpVal[nCont,4]
			**'Marcela Coimbra - 03/02/2012 - Fim - Cadastro código do evento na ZZ5 para conferência furtura'** 
			
			ZZ5->(MsUnlock())
			
			If Empty(SE1->E1_YTPEXP)
				SE1->(Reclock("SE1",.F.))
								
				If ZZ5->ZZ5_CODERR == "0"
					SE1->E1_YTPEXP	:= "A"  //Rio Previdencia - ENVIO OK - TABELA K1
					SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"A", "X5_DESCRI")
				Else
					SE1->E1_YTPEXP	:= "M"  //Rio Previdencia - ERRO ENVIO - TABELA K1
					SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"M", "X5_DESCRI")
				Endif
				
				SE1->(MsUnlock())
			Endif
			
			If ZZ5->ZZ5_CODERR == "0"
				nVlrTot += ZZ5->ZZ5_VLRDES
			Endif   	
			
		Next
		
		cMatEmp := ""
		cNomUsr := ""
		cPreTit	:= ""
		cNumTit	:= ""
		cParTit	:= ""
		cTipTit	:= ""								
		aExpVal := {}
		cCodErr := "0"
		lExisOdo:= .F.
		_nVlrOdo:= 0
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime linha de rodape...                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cLin := Space(1)+cEOL
		cCpo := "9"+M->(ZZ4_TIPREM+ZZ4_PREREM+ZZ4_CODREM)+space(2)+cDatRem+space(49)+StrZero((nVlrTot*100),13)+space(3)+StrZero(nSeq,7)+space(56)
		
		If !(U_GrLinha_TXT(cCpo,cLin))
			MsgAlert("ATENÇÃO! NÃO FOI POSSÍVEL GRAVAR CORRETAMENTE O RODAPÉ! OPERAÇÃO ABORTADA!")
			Return aRet
		Endif  	
	
		U_Fecha_TXT()
		
		aRet := {nSeq,nVlrTot}
		
	Endif       

	For nCont := 1 to Len(aExpTit)
	
		SE1->(DbGoTo(aExpTit[nCont]))	
		
		If Empty(SE1->E1_YTPEXP)
			SE1->(Reclock("SE1",.F.))
			SE1->E1_YTPEXP	:= "A"  //Rio Previdencia  - ENVIO - TABELA K1
			SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"A", "X5_DESCRI")
			SE1->(MsUnlock())
		Endif
		
	Next
	aExpTit := {}	
	
	If Len(aCritica) > 0
		PLSCRIGEN(aCritica,{ {"Descrição da crítica","@C",300}},"Críticas encontradas / Exportação...",.T.)
	Endif
	
	aCritica := {}

Endif

Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³N2LGRIO   ºAutor  ³Microsiga           º Data ³  08/30/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FILRIOPR
	Local cFilAdic := BuildExpr("ZZ5",oMainWnd,"")

	cFil := "@ZZ5_FILIAL = '"+xFilial("ZZ5")+"'"
	cFil += " AND ZZ5_PREREM = '"+ZZ4->ZZ4_PREREM+"' "
	cFil += " AND ZZ5_CODREM = '"+ZZ4->ZZ4_CODREM+"' "
	If !Empty(cFilAdic)
		cFilAdic := StrTran(cFilAdic,'"',"'")
		cFilAdic := StrTran(cFilAdic,'==','=')
		cFilAdic := StrTran(cFilAdic,'.AND.','AND') 
		cFilAdic := StrTran(cFilAdic,'.OR.','OR') 
		cFil += " AND "+cFilAdic
	Endif

	cFil += " AND D_E_L_E_T_ = ' '"

	ZZ5->(DBSetOrder(1))
	DbSelectArea("ZZ5")
	SET FILTER TO &cFil

	CloseBrowse()
                                                                                            
	ZZ5->(mBrowse(006,001,022,075,"ZZ5" ,nil ,nil ,nil ,nil , 4    , aCores,nil ,nil ,nil ,,.T.,nil))
	ZZ5->(DbClearFilter())

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ IMPRIOPR   ³ Autor ³ Jean Schulz       ³ Data ³ 26.10.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Importa o arquivo e sua composicao                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function IMPRIOPR(cAlias,nReg,nOpc)
	Local cNmArq := ""
	Private nTpMov := 1

	AjustaSX1(cPerg)

	If !Pergunte(cPerg,.T.)
		Return
	End

	Pergunte(cPerg,.F.)

/*	cNmArq	:= mv_par01
	nTpMov	:= mv_par02
*/  
    
	dDataBaixa	:= stod(alltrim(str(mv_par01))) 	
	
	If dDataBaixa > Date()
		MsgStop("Data Inválida")
		Return
	Endif

	Processa({|| Processa1(dDataBaixa) }, cTitulo, "", .T.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³ Jean Schulz          º Data ³ 26/10/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cria / ajusta as perguntas da rotina                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)
    //	PutSx1(cPerg,"01",OemToAnsi("Arquivo a importar:"),"","","mv_ch1","C",60,0,0,"G","U_fGetFile('Txt     (*.txt)            | *.Txt | ')","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	//  PutSx1(cPerg,"02",OemToAnsi("Movimento Bancário:"),"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Total","","","","Unitário","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"01",OemToAnsi("Data Baixa"),"","","mv_ch1","D",08,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  26/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Processa1(dDataBaixa)

	Local aStruc		:= {}
	Local nLinha		:= 0
	Local cLinha		:= ""
	Local aHeader		:= {}
	Local aDetalhe		:= {}
	Local aTrailler	:= {}
	Local nCont			:= 0
	Local nPos			:= 0

	Private cCodRem		:= ""
	Private cCodInt		:= ""
	Private cCodEmp		:= ""
	Private cMatric		:= ""
	Private cTipReg		:= ""
	Private cConEmp		:= ""
	Private cVerCon		:= ""
	Private cSubCon		:= ""
	Private cVerSub		:= ""
	Private cBsqUsu		:= ""
	Private cCodDes		:= ""
	Private nValor		:= 0
	Private cComent		:= Alltrim(Substr(cLinha,105,30))
	Private cCodPro		:= ""
	Private cVerPro		:= ""
	Private cLanFat		:= ""
	Private cDatBai		:= ""
	Private dDatBai		:= Stod("")
	Private cChaveTit	:= ""
	Private lPrima		:= .T.
	Private aArrAux		:= {}
	Private cMatEmp		:= ""
	Private lAchou		:= .F.
	Private aBaixa		:= {}
	Private aCopBai		:= {}
	Private lBaixou		:= .T.
	Private lSemTit		:= .F.
	Private aParcela	:= {}
	Private aDadUsr		:= {}
	Private aErrImp		:= {}
	Private cTrb
	Private nTotBaixas	:= 0
	Private c_Qry	:= ""


//	MsgRun("Atualizando Arquivo...",,{|| U_PLSAppendTmp(cNmArq),CLR_HBLUE})
	//MsgRun("Atualizando Arquivo...",,{|| MSAPPEND( (cNmArq), CLR_HBLUE )})
	
	dDataAtu  := dDataBase
	dDataBase := dDataBaixa

	ProcRegua(10000)
	cTotal := 10000
	
	ZZ3->(DbSetOrder(2))
	ZZ5->(DbSetOrder(4))
	BA1->(DbSetOrder(2))
	BA3->(DbSetOrder(1))

	BQC->(DbSetOrder(1))
	BT5->(DbSetOrder(1))
	ZZ4->(DbSetOrder(1))					

	nLin := 1
	cChaveTit := ""
    
	//Modificado por Jean emergencialmente.
	//Necessita-se rever conceito da rotina, 
	//pois o lote nao deveria ser usado para 
	//este fim.
	//LoteCont( "FIN" )
	cLote := "00008850" 
	cLote := Soma1(cLote)

	dbSelectArea("SE5")
	dbSetOrder(5)
	While dbSeek(xFilial("SE5")+cLote)
		While !Eof() .and. SE5->E5_LOTE == cLote .and. E5_FILIAL == xFilial()
			If SE5->E5_RECPAG == "R"
				cLote := Soma1(cLote)
				Exit
			EndIf
			dbSkip()
		EndDo
	EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validar a composicao do arquivo de retorno e criar array de baixa...³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	MontaTmp( ZZ4->ZZ4_CODREM, ZZ4->ZZ4_ANOREM + ZZ4->ZZ4_MESREM )


 	While !QRYNGL->(Eof())
		nLinha++
		IncProc("Processando Linha ... ")
                                              
                 
			ZZ5->( dbGoTo( QRYNGL->reczz5 ) )
			
			cCodInt	:= "0001"
			cCodEmp	:= QRYNGL->ZZ5_CODEMP
			cMatric	:= QRYNGL->ZZ5_MATRIC
			cTipReg	:= QRYNGL->ZZ5_TIPREG
			cCodDes	:= QRYNGL->EVENTO
			cDatBai	:= DTOS(dDataBase)
			dDatBai	:= Iif(Empty(cDatBai),dDataBase,StoD(cDatBai))
			nValor	:= QRYNGL->VALOR
			cComent	:= '00'//Alltrim(Substr(cLinha,105,30))   
			cCodRem := ZZ5->ZZ5_CODREM

			cCodPro := ""
			cVerPro := ""

			If nValor > 0
				If BA1->(MsSeek(xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg))
					BA3->(MsSeek(xFilial("BA3")+cCodInt+cCodEmp+cMatric))

					cConEmp := BA1->BA1_CONEMP
					cVerCon := BA1->BA1_VERCON
					cSubCon := BA1->BA1_SUBCON
					cVerSub := BA1->BA1_VERSUB
					cBsqUsu := BA1->(	BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO )
					cMatEmp	:= StrZero(Val(BA3->BA3_MATEMP),15)
				
					If BA3->BA3_COBNIV == "1" .Or. BA1->BA1_COBNIV == "1"
						cConEmp := ""
						cVerCon := ""
						cSubCon := ""
						cVerSub := ""
					Else
						If Posicione("BQC",1,xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB),"BQC_COBNIV") <> "1"
							cSubCon := ""
							cVerSub := ""
						Endif
						
						If Posicione("BT5",1,xFilial("BT5")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON),"BT5_COBNIV") <> "1"
							cConEmp := ""
							cVerCon := ""						
						Endif					
					Endif
					If Empty(BA1->BA1_CODPLA)
						cCodPro := BA3->BA3_CODPLA
						cVerPro := BA3->BA3_VERSAO			
					Else
						cCodPro := BA1->BA1_CODPLA
						cVerPro := BA1->BA1_VERSAO
					Endif
					If Val(cMatEmp) = 0
						cMatEmp	:= StrZero(Val(BA3->BA3_MATEMP),15)
					Endif
				Endif
				If !(ZZ5->ZZ5_STATUS $ "3,4")   

					**'Marcela Coimbra - 03/02/2012 - Se tiver cadastradocódigo do evento na ZZ5 uso ele para pegar o plano'** 
					cCodPro := alltrim(iIf( Empty(ZZ5->ZZ5_CODEVE), cCodPro,  ZZ5->ZZ5_CODEVE ))
					**'Marcela Coimbra - 03/02/2012 - Se tiver cadastradocódigo do evento na ZZ5 uso ele para pegar o plano'** 
		
					cLanFat := Posicione("ZZ3",2,xFilial("ZZ3")+cCodPro+cVerPro+cCodDes,"ZZ3_CODLAN")
					If .t.//mbc !Empty(cLanFat)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Alimentar matriz de baixa e parcelamento, conforme o caso...        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						cChaveTit := ZZ5->(ZZ5_PRETIT+ZZ5_NUMTIT+ZZ5_PARTIT+ZZ5_TIPTIT)
						nPos := Ascan( aBaixa, { |x| AllTrim(x[1]+x[2]+x[3]+x[4]+x[5]) == AllTrim(Iif(Substr(cComent,1,2) == "00","NOR","NEG")+cChaveTit) } )
						If nPos == 0
							//Implementada esta funcao para melhorar o desempenho
							If Len(aBaixa)>0
								BxTitulo()
								aBaixa := {}
							Endif						
							aAdd(aBaixa,{Iif(Substr(cComent,1,2) == "00","NOR","NEG"),ZZ5->ZZ5_PRETIT,ZZ5->ZZ5_NUMTIT,ZZ5->ZZ5_PARTIT,ZZ5->ZZ5_TIPTIT,dDatBai,"BX. AUTOM. RIO PREV. " + cLote,nValor,{{cCodDes,nValor}}})
						Else
							aBaixa[nPos,8] += nValor
							aArrAux := aClone(aBaixa[1,9])
							nPos2 := aScan(aArrAux,{|x| AllTrim(x[1]) == Alltrim(cCodDes)})						
							If nPos2 == 0
								aadd(aBaixa[nPos,9],{cCodDes,nValor})
							Else
								aBaixa[nPos,9,nPos2,2] += nValor
							Endif
							aArrAux := {}
						Endif								
					Else
						aadd(aErrImp,{"Codigo de despesa x Lancto. faturamento não encontrado! Remessa: "+cCodRem+" Benef.: "+cCodInt+"."+cCodEmp+"."+cMatric+"."+cTipReg+" Despesa: "+cCodDes})
					Endif						
				Else
					aadd(aErrImp,{"Registro não encontrado! Remessa: "+cCodRem+" Benef.: "+cCodInt+"."+cCodEmp+"."+cMatric+"."+cTipReg+" Despesa: "+cCodDes})
				Endif
			Else
				aadd(aErrImp,{"Valor de baixa menor ou igual a Zero! Remessa: "+cCodRem+" Benef.: "+cCodInt+"."+cCodEmp+"."+cMatric+"."+cTipReg+" Despesa: "+cCodDes})
			Endif
		
		QRYNGL->(DbSkip())
	    
	Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ultimo registro...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aBaixa) > 0
		BxTitulo()
		aBaixa := {}
	Endif

//	Gera movimentação bancária e atualiza saldo caso
//	a movimentação bancária seja baseada no valor total.
	If nTpMov == 1 .And. nTotBaixas > 0
		// Gerar movimentação bancária
		Reclock( "SE5" , .T. )
		SE5->E5_FILIAL	:= xFilial()
		SE5->E5_BANCO	:= cBanco
		SE5->E5_AGENCIA	:= cAgencia
		SE5->E5_CONTA	:= cConta
		SE5->E5_VALOR	:= nTotBaixas
		SE5->E5_RECPAG	:= "R"
		SE5->E5_HISTOR	:= "BX. AUTOM. RIO PREV. " + cLote
		SE5->E5_DTDIGIT	:= dDataBase
		SE5->E5_DATA	:= dDataBase
		SE5->E5_NATUREZ	:= "BX.RIOPR"
		SE5->E5_LOTE	:= cLote
		SE5->E5_TIPODOC := "BL"
		SE5->E5_DTDISPO	:= dDataBase
		If SpbInUse()
			SE5->E5_MODSPB := "1"
		Endif
		MsUnlock()

		// Atualizar saldo.
//		AtuSalBco(cBanco, cAgencia, cConta, dDatabase, nTotBaixas, "+") 
             /*
		ZZ4->(Reclock("ZZ4",.F.))      
		
			ZZ4->ZZ4_STATUS := "2"
		
		ZZ4->(MsUnlock())	
	      */
	EndIf

	QRYNGL->(DbCloseArea()) 

	ProcRegua(Len(aBaixa))

	If Len(aErrImp) > 0
		PLSCRIGEN(aErrImp,{ {"Descrição da crítica","@C",300}},"Críticas encontradas / Importação...",.T.)
	Endif          
	
	

	aErrImp		:= {}
	aBaixa		:= {}
	aParcela	:= {}
	aDadUsr		:= {}
      
dDataBase := dDataAtu 

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BxTitulo  ºAutor  ³Microsiga           º Data ³  09/20/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Baixa de titulo individual, para melhorar performance do    º±±
±±º          ³sistema.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function BxTitulo()
	Local aAreaZZ5 := ZZ5->(GetArea())
	Local nCont2	:= 0
	Local _cRecSE1	:= 0
    local i__f
    local nCont
	ZZ5->(DbSetOrder(1)) //ZZ5_FILIAL+ZZ5_PREREM+ZZ5_CODREM+ZZ5_PRETIT+ZZ5_NUMTIT+ZZ5_PARTIT+ZZ5_TIPTIT

//	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//	³ Inicia a transacao / garantia de integridade na baixa do arquivo... ³
//	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Begin Transaction 

//	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//	³ Baixar os titulos conforme matriz de baixa...                       ³
//	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCont := 1 to Len(aBaixa)
	
//		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//		³ Verificar se o titulo possui alguma composicao como baixa normal.   ³
//		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		nPos := Ascan( aBaixa, { |x| x[1] == "NOR" } )	
	
//		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//		³ Caso nenhuma baixa ok seja encontrada, nao realizar operacao nenhuma³
//		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		lBaixou := .F.
		lSemTit := .F.
	
		If nPos > 0
			lBaixou := BaixaTitulo(aBaixa[nCont,1],aBaixa[nCont,2],aBaixa[nCont,3],aBaixa[nCont,4],aBaixa[nCont,5],aBaixa[nCont,6],aBaixa[nCont,7],aBaixa[nCont,8])
		Else
			aadd(aErrImp,{"Nenhuma baixa autorizada no título: "+aBaixa[nCont,2]+aBaixa[nCont,3]+aBaixa[nCont,4]+aBaixa[nCont,5]})
			lSemTit := .T.
		Endif
		
		If lBaixou
			nTotBaixas += aBaixa[nCont,8]
		EndIf

//		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//		³ Modificar o status da composicao e do cabecalho da exportacao...    ³
//		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nCont2 := 1 To Len(aBaixa[nCont,9])	
			ZZ5->(MsSeek(xFilial("ZZ5")+cCodRem+aBaixa[nCont,2]+aBaixa[nCont,3]+aBaixa[nCont,4]+aBaixa[nCont,5]))
			While !ZZ5->(Eof()) .And. ZZ5->(ZZ5_PRETIT+ZZ5_NUMTIT+ZZ5_PARTIT+ZZ5_TIPTIT) == aBaixa[nCont,2]+aBaixa[nCont,3]+aBaixa[nCont,4]+aBaixa[nCont,5]

				If ZZ5->ZZ5_CODDES == aBaixa[nCont,9,nCont2,1]
					ZZ5->(Reclock("ZZ5",.F.))
					ZZ5->ZZ5_STATUS := Iif(aBaixa[nCont,1]=="NOR","3","4")
					If lSemTit 
						ZZ5->ZZ5_CODERR := "5" // Nenhuma baixa autorizada no titulo...
						_cRecSE1 := SE1->(Recno())
						SE1->(MsSeek(xFilial("SE1")+ZZ5->(ZZ5_PRETIT+ZZ5_NUMTIT+ZZ5_PARTIT+ZZ5_TIPTIT)))
						SE1->(Reclock("SE1",.F.))
						SE1->E1_YTPEXP	:= "N" // Retorno Rio Prev - nenhuma bx autorizada - Tabela K1
						SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"N", "X5_DESCRI")
						SE1->(MsUnlock())			
						SE1->(DbGoTo(_cRecSE1))
					Endif
					If !lBaixou
						ZZ5->ZZ5_CODERR := "6" // Problema na baixa...
					Endif				
					
					**'Marcela Coimbra - 03/02/2012 - Cadastro código do evento na ZZ5 para conferência furtura'**
					
					If lBaixou  .and. !lSemTit
						
						ZZ5->ZZ5_BAIXAD := DATE()
					
					EndIf				

					**'Marcela Coimbra - 03/02/2012 - Cadastro código do evento na ZZ5 para conferência furtura'**
					
					ZZ5->(MsUnlock())
				Endif

				ZZ5->(DbSkip())

			EndDo
		Next

		If lPrima
			lPrima := .F.
			If ZZ4->(MsSeek(xFilial("ZZ4")+cCodRem))	
				If ZZ4->ZZ4_STATUS == "1"
					ZZ4->(Reclock("ZZ4",.F.))
					ZZ4->ZZ4_STATUS := "2"
					ZZ4->(MsUnlock())										
				Endif
			Endif
		Endif
			
		If aBaixa[nCont,1] == "NEG" .And. !lSemTit
			cAnoMesAd := U_SomaComp(Substr(DtoS(dDataBase),1,6))
			aadd(aParcela,{cAnoMesAd,aBaixa[nCont,8],"",GetNewPar("MV_YCDLNEG","999"),"","","LANCTO AUTOMATICO RIO PREV."})
			aDadUsr := {cCodInt,cCodEmp,cMatric,cConEmp,cVerCon,cSubCon,cVerSub,"",cBsqUsu}
			If !U_GerAdNeg(aParcela,aDadUsr,SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))
				MsgAlert("Impossível criar adicional para o(s) mês(es) solicitado(s) . Verifique!")
			Endif			
		Endif					
	Next

   End Transaction
	RestArea(aAreaZZ5)
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³BaixaTituloº Autor ³ Jean Schulz       º Data ³  27/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Baixa de titulo financeiro, conforme parametros...         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function BaixaTitulo(cMotBx,cPrefixo,cNumero,cParcela,cTipo,dDtBaixa,cHisBaixa,nVlrBaixa)
	Local lRet := .F.

	Private lmsErroAuto := .f.
	Private lmsHelpAuto := .t. // para mostrar os erros na tela   
                                        
	
	If SE1->(MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo))

		If SE1->E1_SALDO > 0
			nVlrBaixa := If(nVlrBaixa > SE1->E1_SALDO, SE1->E1_SALDO, nVlrBaixa)
			SA6->(DbSetOrder(1)) //A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
			SA6->(MsSeek(xFilial("SA6")+cBanco+cAgencia+cConta))

			aCamposSE5 := {}
			aAdd(aCamposSE5, {"E1_FILIAL"	, xFilial("SE1")	, Nil})
			aAdd(aCamposSE5, {"E1_PREFIXO"	, cPrefixo			, Nil})
			aAdd(aCamposSE5, {"E1_NUM"		, cNumero			, Nil})
		//	aAdd(aCamposSE5, {"E1_PARCELA"	, cParcela			, Nil})
			aAdd(aCamposSE5, {"E1_TIPO"		, cTipo				, Nil})
	     	aAdd(aCamposSE5, {"E1_LOTE"		, cLote				, Nil})
			aAdd(aCamposSE5, {"AUTMOTBX"	, cMotBx			, Nil})
			aAdd(aCamposSE5, {"AUTBANCO"	, SA6->A6_COD		, Nil})
			aAdd(aCamposSE5, {"AUTAGENCIA"	, SA6->A6_AGENCIA	, Nil})
			aAdd(aCamposSE5, {"AUTCONTA"	, SA6->A6_NUMCON	, Nil})

			aAdd(aCamposSE5, {"AUTDTBAIXA"	, dDtBaixa			, Nil})
			aAdd(aCamposSE5, {"AUTDTCREDITO", dDtBaixa			, Nil})
			aAdd(aCamposSE5, {"AUTHIST"		, cHisBaixa			, Nil})
			aAdd(aCamposSE5, {"AUTVALREC"	, nVlrBaixa			, Nil})
	
			msExecAuto({|x,y| Fina070(x,y)}, aCamposSE5, 3)

			If lMsErroAuto
				lRet := .F.
				aadd(aErrImp,{"Ocorreu um erro na baixa do titulo "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
				MostraErro()
				SE1->(Reclock("SE1",.F.))
				SE1->E1_YTPEXP	:= "F" // RETORNO RIO PREVIDENCIA - ERRO - TABELA K1
				SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"F", "X5_DESCRI")
				SE1->(MsUnlock())
			Else
				SE1->(Reclock("SE1",.F.))
				SE1->E1_YTPEXP	:= "E" // RETORNO RIO PREVIDENCIA - OK - TABELA K1
				SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"E", "X5_DESCRI")
				SE1->(MsUnlock())
				// Informa o lote no movimento totalizador
				If nTpMov == 1
					SE5->(Reclock("SE5",.F.))
					SE5->E5_TIPODOC	:= "BA"
					SE5->E5_LOTE	:= cLote
					SE5->(MsUnlock())			
				EndIf
				lRet := .T.
			EndIf
		Else
			aadd(aErrImp,{"O titulo encontra-se baixado. "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
		Endif
	Endif     
	

	

	
Return lRet     

Static  Function MontaTmp( c_CodRem, c_AnoMes )

Local aEstrutura := {;    
					{'zz5_numtit','C', 9,0}, ;    
					{'ZZ5_CODEMP','C', 4,0}, ;    
					{'ZZ5_MATRIC','C', 6,0}, ;    
					{'ZZ5_TIPREG','C', 2,0}, ;    
					{'EVENTO'    ,'C', 3,0}, ;       
					{'VALOR'     ,'N',10,2}, ;  // Cria a tabela com a RDD corrente
					{'reczz5'    ,'N',10,0}  }// Cria a tabela com a RDD corrente
					

//PORTELLA - ALTERAR TITULOS QUE NAO PODEM SER BAIXADOS AQUI
/*
c_Qry := " SELECT zz5_numtit, ZZ5_CODEMP, ZZ5_MATRIC, ZZ5_TIPREG,  RETORNO.evento, REMESSA.VALOR , reczz5 "
c_Qry += " FROM ( "
c_Qry += "         select lpad(trim(substr(trim(ba3_matemp) , 1, length(trim(ba3_matemp)) -1 )), 10, '0') matricula , zz5010.r_e_c_n_o_ reczz5,  zz5_numtit, ZZ5_CODEMP, ZZ5_MATRIC, ZZ5_TIPREG, zz5_coddes evento ,  sum(zz5_vlrdes) valor "
c_Qry += "         from  ba1010, ba3010, zz5010 "
c_Qry += "         where ba3_filial = ' '       "
c_Qry += "               and ba3_codint = '0001'"
c_Qry += "               and ba3_codemp in ('0001','0002','0005') "
c_Qry += "               and ba1_filial = ' '                     "
c_Qry += "               and ba1_codint = ba3_codint              "
c_Qry += "               and ba1_codemp = ba3_codemp              "
c_Qry += "               and ba1_matric = ba3_matric              "
c_Qry += "               and zz5_codrem = '" + c_CodRem + "'                 "
c_Qry += "               and ba1_codemp = zz5_codemp              "
c_Qry += "               and ba1_matric = zz5_matric              "
c_Qry += "               and ba1_tipreg = zz5_tipreg			  " 
c_Qry += "               and ba1010.d_e_l_e_t_ = ' '              "
c_Qry += "               and ba3010.d_e_l_e_t_ = ' '              "
c_Qry += "               and zz5010.d_e_l_e_t_ = ' '              "
c_Qry += "         group by lpad(trim(substr(trim(ba3_matemp), 1, length(trim(ba3_matemp)) -1 )), 10, '0'),zz5010.r_e_c_n_o_,  zz5_numtit, ZZ5_CODEMP, ZZ5_MATRIC, ZZ5_TIPREG, zz5_coddes ) remessa, "

c_Qry += "         ( select lpad(substr(matricula, 2, 6),10,'0') matricula , substr(evento, 3,3) evento, sum(valor) valor  "
c_Qry += "           from an_previ "
c_Qry += "           where anomes =  '" + c_AnoMes + "' "
c_Qry += "           group by lpad(substr(matricula, 2, 6),10,'0'), substr(evento, 3,3) ) retorno "
          
c_Qry += " where remessa.matricula =  retorno.matricula "
c_Qry += " and remessa.evento =  retorno.evento         "
c_Qry += " order by 1         "  
*/
c_Qry := " SELECT zz5_numtit, e1_valor,ZZ5_CODEMP, ZZ5_MATRIC, ZZ5_TIPREG,  RETORNO.evento, RETORNO.VALOR , remessa.valor, reczz5  "
c_Qry += "  FROM (  "
c_Qry += "           select lpad(trim(substr(trim(BA3_YDEPHI) , 1, length(trim(BA3_YDEPHI)) -1 )), 10, '0') matricula , zz5010.r_e_c_n_o_ reczz5,  zz5_numtit, ZZ5_CODEMP, ZZ5_MATRIC, ZZ5_TIPREG, zz5_coddes evento ,  sum(zz5_vlrdes) valor  "
c_Qry += "           from  ba1010, ba3010, zz5010  "
c_Qry += "           where ba3_filial = ' ' "       
c_Qry += "                 and ba3_codint = '0001' "
c_Qry += "                 and ba3_codemp in ('0001','0002','0005')  "
c_Qry += "                 and ba1_filial = ' ' "                     
c_Qry += "                 and ba1_codint = ba3_codint "
c_Qry += "                 and ba1_codemp = ba3_codemp "              
c_Qry += "                 and ba1_matric = ba3_matric "              
c_Qry += "                 and zz5_codrem = '" + c_CodRem + "'    "              
c_Qry += "                 and ba1_codemp = zz5_codemp "              
c_Qry += "                 and ba1_matric = zz5_matric "              
c_Qry += "                 and ba1_tipreg = zz5_tipreg "			    
c_Qry += "                 and ba1010.d_e_l_e_t_ = ' ' "              
c_Qry += "                 and ba3010.d_e_l_e_t_ = ' ' "              
c_Qry += "                 and zz5010.d_e_l_e_t_ = ' ' "              
c_Qry += "           group by lpad(trim(substr(trim(BA3_YDEPHI), 1, length(trim(BA3_YDEPHI)) -1 )), 10, '0'),zz5010.r_e_c_n_o_,  zz5_numtit, ZZ5_CODEMP, ZZ5_MATRIC, ZZ5_TIPREG, zz5_coddes ) remessa,  "

c_Qry += "           ( select lpad(substr(matricula, 2, 6),10,'0') matricula , substr(evento, 3,3) evento, sum(valor) valor  "
c_Qry += "             from an_previ  "                            

c_Qry += "             where anomes =  '" + c_AnoMes + "'  "
c_Qry += "             group by lpad(substr(matricula, 2, 6),10,'0'), substr(evento, 3,3) ) retorno  , se1010 e1   "
          
c_Qry += "   where remessa.matricula =  retorno.matricula  "
//c_Qry += "   and remessa.evento =  retorno.evento   "       
c_Qry += "   and e1.e1_filial = '01'        "
c_Qry += "   and e1.e1_prefixo = 'PLS'   "
c_Qry += "   and e1.e1_saldo > 0   "
c_Qry += "   and e1.e1_num = zz5_numtit   "
  
c_Qry += "   order by 1  "

TCQUERY c_Qry ALIAS "tmpqry" NEW

DBCREATE('\system\N2LGRIO.dbf', aEstrutura)    
					
dbUseArea(.T., NIL, '\system\N2LGRIO.dbf', "QRYNGL", .F.)

While !tmpqry->( EOF() )

	QRYNGL->(Reclock("QRYNGL",.T.))    
	
		QRYNGL->zz5_numtit := tmpqry->zz5_numtit
		QRYNGL->ZZ5_CODEMP := tmpqry->ZZ5_CODEMP
		QRYNGL->ZZ5_MATRIC := tmpqry->ZZ5_MATRIC
		QRYNGL->ZZ5_TIPREG := tmpqry->ZZ5_TIPREG
		QRYNGL->EVENTO     := tmpqry->EVENTO
		QRYNGL->VALOR      := tmpqry->VALOR
		QRYNGL->reczz5     := tmpqry->reczz5
		
	QRYNGL->(MsUnlock())			
	
	tmpqry->( dbSkip() )

EndDo

tmpqry->( dbCloseArea() )  

QRYNGL->( dbGoTop() )

Return

**'Marcela - Importa arquivo de baixa'**
User Function UUUPPREVI(cAlias,nReg)
                        
Local cPerg	       		:= "COMPFAI"

Private cComboBx1                                        
Private cTitRotina 		:= "Importação de arquivo de baixa"
Private lLayout    		:= .T.
Private oDlg
Private c_dirimp   		:= space(100)
Private _nOpc	  		:= 0
Private c_Separador 	:= ""
Private a_Erro 		:= {}
Private l_Importa := .F.

Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold

DEFINE MSDIALOG oDlg TITLE "Importação de arquivo de baixa" FROM 000,000 TO 175,320 PIXEL

@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg  //015
@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg   //030   008
@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg  //038

*-----------------------------------------------------------------------------------------------------------------*
*Buscar o arquivo no diretorio desejado.                                                                          *
*Comando para selecionar um arquivo.                                                                              *
*Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                       *
*           GETF_LOCALHARD   - Inclui o Harddisk local.                                                           *
*-----------------------------------------------------------------------------------------------------------------* 

@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,GETF_LOCALHARD))
@ 045,009 Say  "Delimitador"      Size 045,008 PIXEL OF oDlg   

aCombo := {"Somente relatorio","Executar atualização"}  
cCombo := space(1)      
                                      
@ 045,038 COMBOBOX oCombo VAR cCombo ITEMS aCombo SIZE 20,10 PIXEL OF oDlg

*-----------------------------------------------------------------------------------------------------------------*
@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()

ACTIVATE MSDIALOG oDlg CENTERED

c_Separador := ';'

c_QryTot :=  " select sum(valor) TOTAL ""
c_QryTot +=  "  from an_previ  "
c_QryTot +=  "  where anomes = '" + ZZ4->ZZ4_ANOREM + ZZ4->ZZ4_MESREM + "'" 
	
	
If Select("QRYIMPO") > 0    

   dbSelectArea("QRYIMPO")
   dbclosearea()

Endif

TCQUERY c_QryTot ALIAS "QRYIMPO" NEW   

If QRYIMPO->TOTAL > 0

	If MsgYesNo("Arquivo já importado, total do período: R$" + Transform(QRYIMPO->TOTAL,"999,999,999.99") + ". Deseja reimportar ?")  
	
		c_QrytTot :=  "  delete from an_previ  "
		c_QrytTot +=  "  where anomes = '" + ZZ4->ZZ4_ANOREM + ZZ4->ZZ4_MESREM + "'" 
	
		TCSQLEXEC(c_QrytTot)   
         
		l_Importa := .T.

	Else
	
		l_Importa := .F.
	
	EndIf	


Else
	
	If _nOpc == 1       
	
		l_Importa := .T.
		
	Endif  
	
EndIf

If l_Importa
     
	Processa({|| COMPFAIA(ZZ4->ZZ4_ANOREM + ZZ4->ZZ4_MESREM)},"Importando de arquivo de baixa...", "", .T.)
	
	//		Processa({|| aRet := GeraExport() }, cTitulo, "", .T.)
	
	c_QryTot :=  " select sum(valor) TOTAL ""
	c_QryTot +=  "  from an_previ  "
	c_QryTot +=  "  where anomes = '" + ZZ4->ZZ4_ANOREM + ZZ4->ZZ4_MESREM + "'"
	
	If Select("QRYTOT") > 0
		
		dbSelectArea("QRYTOT")
		dbclosearea()
		
	Endif
	
	TCQUERY c_QryTot ALIAS "QRYTOT" NEW
	
	If 	QRYTOT->TOTAL > 0
		
		If MsgYesNo("Total importado R$" + Transform(QRYTOT->TOTAL,"999,999,999.99")+". Deseja processar a baixa?")
			
			u_IMPRIOPR(cAlias,nReg,K_Incluir)
			
		EndIf
		
	Else
		
		Alert("Nenhum valor foi importado")
		
	EndIf
	
	
EndIf

Return

*------------------------------------------------------------------*
Static Function COMPFAIA(cAnoMes)
*------------------------------------------------------------------*
* função para importar o arquivo                                          
*------------------------------------------------88------------------*

Local c_Arq		:= c_dirimp
Local n_Lin   	:= 0
Local c_Qry    	:= ""
Local n_QtdLin	:= 0           
Private A_ERRO := {}

IF !Empty(c_Arq)

	FT_FUSE(c_Arq)
	FT_FGOTOP()

Else

	Alert("Informe o Arquivo a ser importado!")

Endif     

n_QtdLin := FT_FLASTREC()
c_QtdLin := allTrim(Transform( n_QtdLin,'@E 999,999,999'))   

ProcRegua( n_QtdLin )

n_QtdLin := 0
	
aDados := {}
	
While !FT_FEOF()
	
	IncProc('Processando linha ' + allTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...

	c_Buffer   := FT_FREADLN()
	n_Loop     := 0
		                                                           
	a_TmpDados := {}
	aAdd (a_TmpDados , {"","","","","","",""} )

	c_Script := "insert into AN_PREVI values  ( " 
  	
  	c_Script += "'" + substr(c_Buffer, 05 , 07 ) + "', "  // Matricula
  	c_Script += "'" + substr(c_Buffer, 12 , 01 ) + "', "// Dígito
  	c_Script += "'" + substr(c_Buffer, 13 , 35 ) + "', "// Nome
  	c_Script += "'" + substr(c_Buffer, 48 , 06 ) + "', "// Evento
  	c_Script += substr(c_Buffer, 58 , 09 ) + "." + substr(c_Buffer, 67 , 02 ) + ", " // Valor 	
  	c_Script += "'" + substr(c_Buffer, 69 , 11 ) + "', "// CPF
  	c_Script += "'" + cAnoMes + "', "
  	c_Script += "'N', "
  	c_Script += "'" + alltrim(str(n_QtdLin)) + "') "
	
	TCSQLEXEC(c_Script)       
    

	FT_FSKIP()
		
Enddo

FT_FUSE()
	

Return       


Static Function ERROPRE()
                        
Local cPerg	       		:= "COMPFAI"

Private cComboBx1                                        
Private cTitRotina 		:= "Importa erros Previ"
Private lLayout    		:= .T.
Private oDlg
Private c_dirimp   		:= space(100)
Private _nOpc	  		:= 0
Private c_Separador 	:= ""
Private a_Erro 		:= {}

Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold

DEFINE MSDIALOG oDlg TITLE "Importa erros Previ" FROM 000,000 TO 175,320 PIXEL

@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg  //015
@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg   //030   008
@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg  //038

*-----------------------------------------------------------------------------------------------------------------*
*Buscar o arquivo no diretorio desejado.                                                                          *
*Comando para selecionar um arquivo.                                                                              *
*Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                       *
*           GETF_LOCALHARD   - Inclui o Harddisk local.                                                           *
*-----------------------------------------------------------------------------------------------------------------* 

@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,GETF_LOCALHARD))
@ 045,009 Say  "Delimitador"      Size 045,008 PIXEL OF oDlg   

aCombo := {"Somente relatorio","Executar atualização"}  
cCombo := space(1)      

@ 045,038 COMBOBOX oCombo VAR cCombo ITEMS aCombo SIZE 20,10 PIXEL OF oDlg

*-----------------------------------------------------------------------------------------------------------------*
@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()

ACTIVATE MSDIALOG oDlg CENTERED

c_Separador := ';'

If _nOpc == 1
	
	Processa({ERRCOMPFAIA()},"Importando arquivo de erros Previ...")
	
Endif

Return

*------------------------------------------------------------------*
Static Function ERRCOMPFAIA()
*------------------------------------------------------------------*
* função para importar o arquivo                                          
*------------------------------------------------88------------------*

Local c_Arq		:= c_dirimp
Local n_Lin   	:= 0
Local c_Qry    	:= ""
Local n_QtdLin	:= 0           
Private A_ERRO := {}

IF !Empty(c_Arq)

	FT_FUSE(c_Arq)
	FT_FGOTOP()

Else

	Alert("Informe o Arquivo a ser importado!")

Endif     

n_QtdLin := FT_FLASTREC()
c_QtdLin := allTrim(Transform( n_QtdLin,'@E 999,999,999'))   



ProcRegua( n_QtdLin )

n_QtdLin := 0

//FT_FSKIP() //o primeiro registro pode ser avançado, pois contém somente os nomes das colunas
	
aDados := {}
	
While !FT_FEOF()
	
	IncProc('Processando linha ' + allTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...

	c_Buffer   := FT_FREADLN()
	n_Loop     := 0
		
   //	x_Pos := AT( c_Separador, c_Buffer) 
                                                           
	a_TmpDados := {}
	aAdd (a_TmpDados , {"","","","","","",""} )
    // tipo varchar(1), matricula varchar(7), digito varchar(1), valor float, cod_erro varchar(2)
	c_Script := "insert into an_erro_previ values  ( " 
  	
  	c_Script += "' ', "  // Tipo
  	c_Script += "'" + substr(c_Buffer, 17 , 07 ) + "', "// Matricula    	
  	c_Script += "'" + substr(c_Buffer, 24 , 01 ) + "', "// Digito
  	c_Script += substr(c_Buffer, 46 , 06 ) + "." + substr(c_Buffer, 52 , 02 ) + ", " // Valor 	
  	c_Script += "'" + substr(c_Buffer, 133 , 2 ) + "',"// CPF
  	c_Script += "'201408')"// CPF
	
	TCSQLEXEC(c_Script)   

	FT_FSKIP()
		
Enddo

FT_FUSE()

alert("Fim")
	

Return      

