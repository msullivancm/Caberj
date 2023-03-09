#Include 'RWMAKE.CH'                               
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PGAUDIMED ºAutor  ³ Jean Schulz        º Data ³  05/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de log de exportacao / importacao de arquivos para a  º±±
±±º          ³ Rio Previdencia.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PGAUDIMED()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina   	:=	{	{ "Pesquisar"	    , 'AxPesqui'	  , 0 , K_Pesquisar  },;
{ "&Visualizar"	, 'AxVisual'	  , 0 , K_Visualizar },;
{ "&Gera Pagto"	, 'U_GERPAGTO'    , 0 , K_Incluir    },;
{ "&Excluir"	, 'U_EXCPAGTO'    , 0 , K_Excluir    } }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo e variavies para indicar o status do arquivo                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCadastro 	:= "Geração adicionais de pagamento Audimed"

/*
PRIVATE aCdCores  	:= { 	{ 'BR_VERMELHO'    ,'Somente Exportado' },;
							{ 'BR_VERDE'       ,'Arquivo Exportado e Importado' } }
PRIVATE aCores      := { { 'ZZ4_STATUS = "1"',aCdCores[1,1] },;
                        { 'ZZ4_STATUS = "2"',aCdCores[2,1] }}                           
*/                        
PRIVATE cPath  := ""                        
PRIVATE cAlias := "ZZ9"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ZZ9->(DBSetOrder(1))
ZZ9->(mBrowse(006,001,022,075,"ZZ9" , , , , , Nil,, , , ,nil, .T.))
ZZ9->(DbClearFilter())

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
User Function GERPAGTO(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca   := 0
LOCAL oEnc
LOCAL aRet
LOCAL bOK        := {|| nOpca := 1, oDlg:End()}
LOCAL bCancel := { || nOpca := 0, oDlg:End() }

PRIVATE cAlias := "ZZ9"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define dialogo...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Enchoice...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Copy cAlias To Memory Blank

oEnc := ZZ9->(MsMGet():New(cAlias,nReg,nOpc,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
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
	aRet := GERAAUDIMED(oEnc:aGets,oEnc:aTela,"",oDlg)
	M->ZZ9_VLRPAG	:= aRet[1]
	M->ZZ9_VLRUNI	:= aRet[2]
	M->ZZ9_QTDCRI	:= aRet[3]
	ZZ9->(PLUPTENC("ZZ9",K_Incluir))

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
Static Function GERAAUDIMED(aGets,aTela,cNomArq,oDlg)
LOCAL aRet := {0,0}

Private nBytes := 0 
Private cTitulo := "Gerando adicionais Audimed"
PRIVATE nHdl
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Testa campos obrigatorios...                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ! Obrigatorio(aGets,aTela)
	Return(aRet)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera os registros adicionais para prestador audimed...              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| aRet := AdicioAudimed() }, cTitulo, "", .T.)

Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ EXCPAGTO   ³ Autor ³ Jean Schulz       ³ Data ³ 05.09.2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Exclui o arquivo e sua composicao                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function EXCPAGTO(cAlias,nReg,nOpc)

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL oDlg
LOCAL nOpca		:= 0
LOCAL oEnc
LOCAL bOK    	:= { || nOpca := 1, oDlg:End() }
LOCAL bCancel	:= { || oDlg:End() }
LOCAL cSQL		:= ""

PRIVATE cAlias := "ZZ9"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define dialogo...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg TITLE cCadastro FROM ndLinIni,000 TO ndLinFin,ndColFin OF GetWndDefault()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Enchoice...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Copy cAlias To Memory

oEnc := ZZ9->(MsMGet():New(cAlias,nReg,K_Visualizar,,,,,{015,004,192,390},,,,,,oDlg,,,.F.))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa o dialogo...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,bOK,bCancel,.F.,{})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Rotina de exclusao de pagamento audimed...                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpca == K_OK

	cSQL := " SELECT COUNT(R_E_C_N_O_) AS TOTAL FROM "+RetSQLName("BGQ")
	cSQL += " WHERE BGQ_YLTAUD = '"+M->ZZ9_CODPAG+"' "
	cSQL += " AND BGQ_NUMLOT <> ' '"
	cSQL += " AND D_E_L_E_T_ = ' '"
	PlsQuery(cSQL,"TRB")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apagar somente registros nao pagos, e limpar guias ja marcadas...   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If TRB->TOTAL = 0		
		cSQL := " UPDATE "+RetSQLName("BGQ")+" SET D_E_L_E_T_ = '*' "
		cSQL += " WHERE BGQ_YLTAUD = '"+M->ZZ9_CODPAG+"' "
		cSQL += " AND BGQ_NUMLOT = ' '"
		cSQL += " AND D_E_L_E_T_ = ' '"
		TCSQLEXEC(cSQL)	  
		
		cSQL := " UPDATE "+RetSQLName("BE4")+" SET BE4_YLTAUD = ' ' "
		cSQL += " WHERE BE4_YLTAUD = '"+M->ZZ9_CODPAG+"' "
		cSQL += " AND D_E_L_E_T_ = ' '"
		TCSQLEXEC(cSQL)
		
		ZZ9->(PLUPTENC("ZZ9",K_Excluir))		
	Else
		MsgAlert("Impossível excluir pagamento Audimed. Adicionais de pagamento já faturados !","Atenção")
	Endif
	
	TRB->(DBCloseArea())
		
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AdicioAudimed ºAutor  ³ Jean Schulz    º Data ³  18/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Geracao dos adicionais ao prestador no parametro.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Microsiga.                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AdicioAudimed()
Local aRet := {}

Local cRDAAud	:= GetNewPar("MV_YRDAAUD","068918")
Local nVlrAud	:= GetNewPar("MV_YVLRAUD",55000.00)
Local nVlrUni	:= 0
Local cSQL		:= ""
Local nProc		:= 0
Local nCont		:= 0
Local nTotReg	:= 0
Local nQtdCri	:= 0
Local nTotQry	:= 0
Local nTotArr	:= 0
Local cCodPla	:= ""
Local cVerPla	:= ""
Local aProcAud	:= {}
Local aPlaQtd	:= {}
Local aErr		:= {}
Local lPerAud	:= .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao de indices para busca...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))
BD6->(DbSetOrder(1))
BQR->(DbSetOrder(1))
BI3->(DbSetOrder(1))
BR8->(DbSetOrder(1))
BID->(DbSetOrder(1))
BB8->(DbSetOrder(1))
BAU->(DbSetOrder(1))
ZZ8->(DbSetOrder(1))
BBB->(DbSetOrder(1))
BFM->(DbSetOrder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montar array com procedimentos que permitem pagto Audimed...        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := " SELECT BR8_CODPSA FROM "+RetSQLName("BR8")
cSQL += " WHERE BR8_YPRAUD = '1' "
cSQL += " AND D_E_L_E_T_ = ' ' "
cSQL += " ORDER BY BR8_CODPSA "
PLSQuery(cSQL,"TRB")	

While !TRB->(Eof())
	aadd(aProcAud,Alltrim(TRB->BR8_CODPSA))
	TRB->(DbSkip())
Enddo             

TRB->(DbCloseArea())


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Consulta principal para validacao das internacoes Audimed...        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCont := 1 to 2
	
	If nCont == 1
		cSQL := " SELECT COUNT(R_E_C_N_O_) AS TOTAL FROM "+RetSQLName("BE4")"
	Else
		cSQL := " SELECT R_E_C_N_O_ AS REGISTRO FROM "+RetSQLName("BE4")
	Endif		

	cSQL += " WHERE BE4_YLTAUD = ' ' "
	cSQL += " AND BE4_ANOPAG = '"+M->ZZ9_ANOPAG+"' "
	cSQL += " AND BE4_MESPAG = '"+M->ZZ9_MESPAG+"' "
	cSQL += " AND BE4_FASE = '4'"
	cSQL += " AND BE4_SITUAC = '1'"
	cSQL += " AND D_E_L_E_T_ = ' ' "
	
	If nCont == 1      
		PLSQuery(cSQL,"TRB")	
		nTotQry := TRB->TOTAL
		TRB->(DbCloseArea())	
	Endif	
	
Next	

PLSQuery(cSQL,"TRB")	

ProcRegua( nTotQry )

Begin Transaction

While ! TRB->(Eof())	

	nProc++
	IncProc("Lendo registro " + AllTrim(Str(nProc)) )

	BE4->(DbGoto(TRB->REGISTRO))
	
	BA1->(MsSeek(xFilial("BA1")+BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG)))
	BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))

	If Empty(BA1->BA1_CODPLA)
		cCodPla := BA3->BA3_CODPLA
		cVerPla := BA3->BA3_VERSAO
	Else
		cCodPla := BA1->BA1_CODPLA
		cVerPla := BA1->BA1_VERSAO	
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Validacoes para regra de pagto audimed...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	lPerAud := .F.
	If Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cCodPla+cVerPla,"BI3_YPRAUD") == "1" //Produto
		If Posicione("BQR",1,xFilial("BQR")+BE4->(BE4_GRPINT+BE4_TIPINT),"BQR_YPRAUD") == "1" //Tipo de internacao
			BD6->(MsSeek(xFilial("BD6")+PLSINTPAD()+BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)))
			
			While BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO) == BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) .And. !BD6->(Eof())
			
				If Ascan(aProcAud,Alltrim(BD6->BD6_CODPRO)) > 0
					lPerAud := .T.
					Exit
				Endif
				
				BD6->(DbSkip())
				
			Enddo
			
			If lPerAud        
			
				lPerAud := .F.			
				
				If BB8->(MsSeek(xFilial("BB8")+BE4->BE4_CODRDA+PLSINTPAD()+BE4->(BE4_CODLOC+BE4_LOCAL)))
					If Posicione("BID",1,xFilial("BID")+BB8->BB8_CODMUN,"BID_YPRAUD") == "1"
						lPerAud := .T.				
				    Endif
				Endif
			
			Endif
		Endif	
		
	Endif
	
	If lPerAud
		BE4->(Reclock("BE4",.F.))
		BE4->BE4_YLTAUD := M->ZZ9_CODPAG		
	    BE4->(MsUnlock())

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Separar quantidade de atendimentos X adicional x plano usuario...   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			    
		If ZZ8->(MsSeek(xFilial("ZZ8")+cCodPla+cVerPla+"1"))
		
		    nPos := Ascan( aPlaQtd, { |x| x[1] == ZZ8->ZZ8_ADIAUD } )
		    
		    If nPos > 0
		    	aPlaQtd[nPos,2]++
		    Else
				aadd(aPlaQtd,{ZZ8->ZZ8_ADIAUD,1})	    
		    Endif
		    
		    nTotReg++
		    
		Else
			aadd(aErr,{"Atenção! Produto/Versao: "+cCodPla+"/"+cVerPla+" não possui cadastro de adicionais para prestador. Verifique!"})
			nQtdCri++
		Endif
		
	Endif

	TRB->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calcular o valor individual...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
If nTotReg > 0
	nVlrUni := nVlrAud/nTotReg

	For nCont := 1 to Len(aPlaQtd)
	
		BBB->(MsSeek(xFilial("BBB")+aPlaQtd[nCont,1]))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Necessario truncar casas decimais, lancando centavo no ultimo adic. ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ					
		BGQ->(Reclock("BGQ",.T.))	
		BGQ->BGQ_FILIAL	:= xFilial("BGQ") 
		BGQ->BGQ_CODSEQ	:= GETSX8NUM("BGQ","BGQ_CODSEQ")
		BGQ->BGQ_CODIGO	:= cRDAAud
		BGQ->BGQ_NOME	:= Posicione("BAU",1,xFilial("BAU")+cRDAAud,"BAU_NOME")
		BGQ->BGQ_ANO	:= M->ZZ9_ANOADI
		BGQ->BGQ_MES	:= M->ZZ9_MESADI
		BGQ->BGQ_CODLAN	:= aPlaQtd[nCont,1]
		BGQ->BGQ_VALOR	:= IIf(nCont <> Len(aPlaQtd),NoRound(nVlrUni*aPlaQtd[nCont,2],2),nVlrAud-nTotArr)
		BGQ->BGQ_QTDCH	:= 0
		BGQ->BGQ_TIPO	:= "2" //Credito
		BGQ->BGQ_TIPOCT	:= "2" //PJ
		BGQ->BGQ_INCIR	:= BBB->BBB_INCIR
		BGQ->BGQ_INCINS	:= BBB->BBB_INCINS
		BGQ->BGQ_INCPIS	:= BBB->BBB_INCPIS
		BGQ->BGQ_INCCOF	:= BBB->BBB_INCCOF
		BGQ->BGQ_INCCSL	:= BBB->BBB_INCCSL
		BGQ->BGQ_VERBA	:= BBB->BBB_VERBA
		BGQ->BGQ_CODOPE	:= PLSINTPAD()
		BGQ->BGQ_CONMFT	:= "0" //Nao
		BGQ->BGQ_OBS	:= "LANCTO PGTO AUDIMED / LOTE: "+M->ZZ9_CODPAG
		BGQ->BGQ_USMES	:= Posicione("BFM",1,PLSINTPAD()+M->(ZZ9_ANOADI+ZZ9_MESADI),"BFM_VALRDA")
		BGQ->BGQ_LANAUT	:= "0" //Nao
		BGQ->BGQ_YLTAUD	:= M->ZZ9_CODPAG
		BGQ->(MsUnlock()) 
		ConfirmSx8()
		
		If nCont <> Len(aPlaQtd)
			nTotArr += BGQ->BGQ_VALOR
		Endif
			
	Next
	
Else	
	aadd(aErr,{"Atenção! Nenhuma guia foi encontrada! Valor total de pagamento será zerado!"})
	nVlrAud := 0
	nVlrUni := 0
	nQtdCri++
Endif	

If Len(aPlaQtd) > 0
	MsgAlert("Pagamento Audimed gerado. Verifique os resultados!")
Endif

End Transaction     

If Len(aErr) > 0
	PLSCRIGEN(aErr,{ {"Descrição da crítica","@C",400}},"Críticas encontradas",.T.)
Endif


TRB->(DbCloseArea())

aRet := {nVlrAud,nVlrUni,nQtdCri}

Return aRet