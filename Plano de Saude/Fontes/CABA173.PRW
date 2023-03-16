#Include 'RWMAKE.CH'
#Include 'PROTHEUS.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'
#Include 'UTILIDADES.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "APWEBSRV.CH"
#INCLUDE "APWEBEX.CH"
#INCLUDE "AP5MAIL.CH"

#DEFINE c_ent CHR(13) + CHR(10)

///*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³CABA173    º Autor ³ Fabio Bianchini    º Data ³  17/02/2015 º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDescricao ³ COPIADO DO CABA038 e MODIFICADO - CABERJ                    º±±
//±±º          ³ Gera SOMENTE arquivo texto dos usuarios que possuem         º±±
//±±º          ³ atendimento domiciliar de urgencia SEM GERAR o rateio       º±±
//±±º          ³ no contas médicas                                           º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºAlteração ³ Angelo Henrique - Data: 24/11/2015                          º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±º          ³-Removido comentários desnecessários;                        º±±
//±±º          ³-Removido funções que eram originárias e utilizadas somente  º±±
//±±º          ³ no fonte CABA038, facilitando assim a conferência e         º±±
//±±º          ³ visualização do fonte.                                      º±±
//±±º          ³-Adicionado os grupos solicitados pela BEM Emergência Médica º±±
//±±º          ³pois estavam sendo enviado sgrupos incorretos, gernado assim º±±
//±±º          ³inconformidades no processo.                                 º±±
//±±º          ³-Ajustado a finalização da rotina, pois estava dando erro    º±±
//±±º          ³podendo desta forma liberar para o usuário fazer o processo. º±±
//±±º          ³************************************************************ º±±
//±±º          ³Este fonte é utilizado somente na empresa CABERJ.            º±±
//±±º          ³************************************************************ º±±
//±±ºAlteração ³ Motta - Data: 27/11/2019                                    º±±
//±±º                    Tratar bloqueios temporários                        º±±
//±±ºAlteração ³ Motta - Data: 01/08/2022                                    º±±
//±±º                    Trocar Descrição por Nome Reduzido Plano,           º±±
//±±º                    usar o "filler"  (ch 89240)                         º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ CABERJ                                                      º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
///*/                                                       .

User Function CABA173(_cParam)
			
	Default _cParam := "1"
	
	//---------------------------------------------------
	//Passando:
	//---------------------------------------------------
	//_cParam = '1' ou em branco -- Via MENU
	//_cParam = '2' -- Via SCHEDULE
	//---------------------------------------------------
	
	If ValType(_cParam) == "A" //Array
	
		_cParam := IIF(ValType(_cParam[1]) != "C", cValToChar(_cParam[1]), _cParam[1])
	
	EndIf
	
	QOut("CABA173 - INICIO - Geracao de arquivos da BEM")
	QOut("CABA173 - Parametro enviado: " + _cParam)	
	
	If !Empty(_cParam)
		
		If _cParam == "2"
			
			QOut("CABA173 - Preparacao de ambiente")
			
			RpcSetType(3)
			
			If FindFunction("WfPrepEnv")
				
				WFPrepEnv("01","01", , , "PLS")
				
			Else
				
				PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"  MODULO "PLS"
				
			EndIf
			
			QOut("CABA173 - Empresa Logada: " + cEmpAnt)
			
			QOut("CABA173 - Filial Logada: " + cFilAnt)
			
		EndIf
		
	EndIf
	
	// ***********************************************
	// Rotina da geração do Arquivo
	// ***********************************************
	u_CABA173A(_cParam)
	
	QOut("CABA173 - FIM - Geracao de arquivos da BEM")
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA173A  º Autor ³ Angelo Henrique    º Data ³  12/04/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Após o preparo da onde é chamado (SCHEDULE ou via MENU)    º±±
±±º          ³ A rotina sera executada sem problemas.                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA173A(_cParam)
	
	
	/*BEGINDOC
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄesmo¿
	//³Melhorias a serem feitas.                                ³
	//³1- Eliminar o parâmetro "Gera debito/credito"            ³
	//³2-Mudar nome da rotina principal e chamada da mesma no   ³
	//³menu, visando evitar conflito com a atual rotina de mesmo³
	//³nome que gera pagamento a partir do lançamento de        ³
	//³debito/credito.                                          ³
	//³                                                         ³
	//³Renato Peixoto em 17/12/2010                             ³
	//³Documentation                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄesmoÙ
ENDDOC*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private oGeraTxt
Private cPerg       := "RATADU"
Private cString     := "BA1"
Private nlinha      := 0
Private nlinha1     := 0
Private nTamLin, cLin, cCpo
Private lAbortPrint := .F.
private xUsu        := {}
private aPlano      := {}
private aExcPlano := {}
private aCarGer     := {}
private aExcCarGer := {}
private aVDS        := {}
Private cBF4Name    := RetSQLName("BF4")
Private cBA1Name    := RetSQLName("BA1")
Private cBI3Name    := RetSQLName("BI3")
Private cBT3Name    := RetSQLName("BT3")
Private cBG9Name    := RetSQLName("BG9")
Private lRet        := .T.
Private nTamLin     := 15
Private cLin        := Space(nTamLin) // Variavel para criacao da linha do registros para gravacao
Private nValor      := 0
Private nTusu       := 0
Private cTipo       := ""  //não está em uso
Private _cgc        := ""
Private cNomeProg   := "RATEADU"
Private nCaracter   := 15
Private Tamanho     := "P"
Private cTitulo     := "Quantidade de Usuarios que possuem opcional ADU."
Private cDesc1      := "Emite relatorio com a quantidade de ususarios por"
Private cDesc2      := "produto que possuem direito ao ADU."
Private cDesc3      := ""
Private cCabec1     := "Produtos com ADU"
Private cCabec2     := ""
Private cAlias      := "BA1"
Private wnRel       := "GERAADU"
Private Li          := 99
Private m_pag       := 1
Private aReturn     := {"Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
Private lAbortPrint := .F.
Private aOrdens     := ""
Private lDicion     := .F.
Private lCompres    := .F.
Private lCrystal    := .F.
Private lFiltro     := .T.
Private Limite      := 80
Private cCodEmp     := GETNEWPAR("MV_YCODADU","164")
Private nVlADU      := GETNEWPAR("MV_YVLADU",2.09)
Private nVlVDS      := GETNEWPAR("MV_YVLVDS",60.00)
Private nVlCGER     := GETNEWPAR("MV_YVLCGER",15.40)
Private cRDASP      := GETNEWPAR("MV_YRDASP","106445")
Private cRDARJ      := GETNEWPAR("MV_YRDARJ","126004")
Private cCodRDA     := ""
Private cOrigem     := "RELATORIO"
Private cProADU     := GetMV("MV_XPROADU") //Código de procedimento referente ao projeto ADU
Private cProCGER    := GetMv("MV_XPROCGE") //Código de procedimento referente ao projeto ADU Especial
Private cProVDS     := GetMv("MV_XPROVDS") //Código de procedimento referente ao projeto VDS
Private dDtEvento   := DDATABASE //inicio com a data do dia, mas depois irá assumir o valor do parâmetro...
Private cCompet     := ""
Private nCont       := 0
Private nCont2      := 0
Private aRelExcel   := {}//Variável que irá armazenar os usuários impressos, para exibir um relatório em excel ao final do processo...
Private cTempoRot   := ""
Private _cDir		 	:= GetMv("MV_XDIRBEM") //Diretório onde será gravado o arquivo da BEM

aADD (aRelExcel,{"Projeto", "Código do Plano", "Descrição do Plano", "Matrícula", " Nome do Usuário", "Código do RDA", "Valor","Idade","UF","MUNICIPIO"})

// Criar campo na tabela BT3 (produtos relacionados) para indicar qual será o codigo do lancamento de debito/credito
// a ser incluido no cadastro de debito/credito pela rotina automatica.
// Nome do Campo := BT3_YCDDBCR
// Tipo := C
// Tamanho := 3
// Descricao := Cod. Deb/Cre
// usar a mesma consulta do cadastro de Debito/Credito do campo BGQ_CODLAN (Lancamento)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If _cParam != "2" //Angelo Henrique - Data:20/04/2016
	
	AjustaSX1(cPerg)
	
Else
	
	QOut("CABA173 - Alimentando os parametros")
	
	MV_PAR01 := CTOD("01/06/2016") //Data Inicial?
	MV_PAR02 := dDataBase //Data Final?
	MV_PAR03 := _cDir //Diretorio do Arquivo?
	MV_PAR04 := 1 //Tipos de Usuarios?
	MV_PAR05 := Year(dDatabase)//Ano Competencia?
	MV_PAR06 := Month(dDatabase)//Mes Competencia?
	MV_PAR07 := 1 //Gera o Arquivo?
	MV_PAR08 := 2 //Tipo de Relatório?
	
EndIf

INCLUI := .T. //Chumbado como .T., pq essa variável é utilizada em um inicializador padrão de campo da tabela BD5

dbSelectArea("BA1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Leonardo Portella - 06/07/11 - Inicio

If _cParam != "2" //Angelo Henrique - Data:20/04/2016
	
	Pergunte(cPerg,.F.)
	
	nOpca := 0
	
	aSays := {}
	aAdd(aSays, 'Este programa ira gerar um arquivo texto, conforme os parametros definidos'   )
	aAdd(aSays, 'pelo usuario, com os registros do arquivo de BA1')
	
	aButtons := {}
	aAdd(aButtons, { 1,.T.,{|| nOpca:= 1, FechaBatch()}} )
	aAdd(aButtons, { 2,.T.,{|| FechaBatch() }} )
	aAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T.) }} )
	
	FormBatch( OemToAnsi("Gera‡„o de Arquivo Texto"), aSays, aButtons,, 240, 450 )
	
	If nOpca == 1
		OkGeraTxt(_cParam)
	EndIf
	
Else
			
	OkGeraTxt(_cParam)
	
EndIf

//Leonardo Portella - 06/07/11 - Fim

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ OKGERATXTº Autor ³ AP5 IDE            º Data ³  19/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao chamada pelo botao OK na tela inicial de processamenº±±
±±º          ³ to. Executa a geracao do arquivo texto.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function OkGeraTxt(_cParam)
	
	Local cDirGrava 	:= GetNewPar("MV_PLSDIRC","C:\")
	Local cDirPls 	:= ""
	Private nHdl    	:= 0   //Local
	Private cArquivo 	:= space(0)
	Private cEOL    	:= "CHR(13)+CHR(10)"
	Private oProcess 	:= Nil
	
	QOut("CABA173 - Executando rotina OkGeraTxt")
	
	If Empty(cEOL)
		cEOL := CHR(13)+CHR(10)
	Else
		cEOL := Trim(cEOL)
		cEOL := &cEOL
	Endif
	
	cTempoRot := "Hora de início da rotina: "+Time()
	
	If _cParam != "2" //Angelo Henrique - Data:20/04/2016
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria o arquivo texto                                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//MV_PAR01 não está sendo usado para nada. Verificar se ele poderá ser usado para filtrar na query o ba1_dtinc
		If Empty(mv_par01) .or. Empty(mv_par02) .or. Empty(mv_par04) ;   //.or. Empty(mv_par03)
			.or. Empty(mv_par05) .or. Empty(mv_par06) .or. Empty(mv_par07) .or. Empty(mv_par08)
					
			MsgAlert("Informe os parametros .....")
			//Close(oGeraTxt)
			Return
		Endif
		
	EndIF
	
	dDtEvento := MV_PAR09
	cCompet   := MV_PAR06 + MV_PAR05
	
	MV_PAR08  := 2
	
	_data := (substr(Dtoc(dDataBase),1,2)+ substr(Dtoc(dDataBase),4,2)+ substr(Dtoc(dDataBase),7,2))
	
	cDirPls := alltrim(MV_PAR03)
	
	If !Empty(cDirPls)
		cDirGrava := alltrim(cDirPls)
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se nao informou a barra												³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SubStr(cDirGrava,Len(cDirGrava),1) <> "\"
		cDirGrava += "\"
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria o arquivo texto layout de Informacoes Cadastrais               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If _cParam != "2" //Angelo Henrique - Data:20/04/2016
	
		cArquivo := cDirGrava + "T"+ Alltrim(cCodEmp) + "0001.TXT"   //+Alltrim(mv_par03) + cTipo +_data  + "." + "TXT"
		
	Else
	
		cArquivo := cDirGrava + "CABERJ_BEM_" + Replace(DTOC(dDataBase),"/","_") + ".TXT"  
	
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se e possivel criar o arquivo						³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nHdl := fCreate(cArquivo)
	
	If nHdl == -1
		//Leonardo Portella - 14/10/13 - Virada P11
		If _cParam != "2" //Angelo Henrique - Data:20/04/2016
			
			MsgAlert("O arquivo de nome "+cArquivo+" nao pode ser criado! Verifique os parametros." + CHR(13) + CHR(10) + cDesFerror(FError()),AllTrim(SM0->M0_NOMECOM))
			
		Else
			
			QOut("CABA173 - O arquivo de nome "+cArquivo+" nao pode ser criado! Verifique os parametros.")
			
		EndIf
		
		Return
		
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa a regua de processamento                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If _cParam != "2" //Angelo Henrique - Data:20/04/2016
		
		//Leonardo Portella - 06/07/11
		oProcess := MsNewProcess():New({||ProcTXT(_cParam)},"Processando...","",.F.)
		oProcess:Activate()
		//MsAguarde({|| Processa() }, "Processando...", "", .T.)
		
	Else
		
		ProcTXT(_cParam)
		
	EndIf
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ ProcTXT  º Autor ³ Luzio Tavares      º Data ³  09/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ProcTXT(_cParam)
	
	Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local dDatIni    := CtoD("  /  /    ")
	Local dDtInicial := CtoD("  /  /    ")
	Local aCriticas  := {}
	Local lDescontar := .F.
	//Local cCodPla  := Space(0)
	//Local cCodPla1 := Space(0)
	Local cSql1 := Space(0)
	Local cSql2 := Space(0)
	
	Private cCodPla  := Space(0)
	Private cCodPla1 := Space(0)
	Private nContador := 0
	Private nIdade    := 0
	Private cCodInt   := ""
	Private nContPlano:= 0
	Private nContCGER := 0
	Private nContVDS  := 0
	
	If _cParam != "2" //Angelo Henrique - Data:20/04/2016
	
		oProcess:SetRegua1(0)
		oProcess:SetRegua2(0)
			
		For i := 1 to 5
			oProcess:IncRegua1("Selecionando registros...")
		Next
	
	Else
	
		QOut("CABA173 - Executando a rotina PROCTXT - Execução da Query")
		
	EndIf
	//MsgRun("Selecionando Registros...",,{|| ,CLR_HBLUE})
	
	cSQL := " SELECT BA3.BA3_CODPLA, BA3.BA3_VERSAO, BG9.BG9_DESCRI, BG9.BG9_TIPO, BTS.BTS_DRGUSR, BTS.BTS_CPFUSR, "+c_ent
	cSQL += " Decode(Sign(IDADE_S(BA1_DATNAS)-70),-1,'0023','0024') PROJ, IDADE_S(BA1_DATNAS) IDADE, BA1.* "+c_ent
	cSQL += " FROM " + RetSQLName("BA1") +" BA1, "+ RetSQLName("BG9") + " BG9, " + RetSQLName("BTS") + " BTS, "+c_ent
	cSQL += RetSQLName("BA3") + " BA3, "+RetSQLName("BA0") +" BA0 "+c_ent
	cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"'  AND "+c_ent
	cSQL += " BG9_FILIAL = '"+xFilial("BG9")+"'  AND "+c_ent
	cSQL += " BA3_FILIAL = '"+xFilial("BA3")+"'  AND "+c_ent
	cSQL += " BA0_FILIAL = '"+xFilial("BA0")+"'  AND "+c_ent
	cSQL += " BA1.D_E_L_E_T_ = ' '  AND "+c_ent
	cSQL += " BA3.D_E_L_E_T_ = ' '  AND "+c_ent
	cSQL += " BG9.D_E_L_E_T_ = ' '  AND "+c_ent
	cSQL += " BA0.D_E_L_E_T_ = ' '  AND "+c_ent
	cSQL += " BA3_CODINT = BA1_CODINT AND "+c_ent
	cSQL += " BA3_CODEMP = BA1_CODEMP AND "+c_ent
	cSQL += " BA3_MATRIC = BA1_MATRIC AND "+c_ent
	// motta 26/11/19
	cSQL += " ( ((BA1_DATBLO = '      ' AND BA1_MOTBLO = '  ') OR (BA1_DATBLO >= '"+DTOS(MV_PAR02)+"') ) "+c_ent
	cSQL += "    OR  "+c_ent
	cSQL += "        (RETORNA_MOTIVO_BLOQ(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DATBLO,'C') LIKE '%TEMP%') ) AND "+c_ent
	// fim motta 16/11/19
	cSQL += " BA1_CODEMP NOT IN ('0006','0004','0009','0010') AND "+c_ent
	cSQL += " BA1_DATINC <= '"+DtoS(mv_par02)+"' AND "
	cSQL += " BTS_MATVID = BA1_MATVID AND " +c_ent
	//cSQL += " BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO ='00010002047031000' AND  " +c_ent	
	//cSQL += " BA1_ESTADO = 'RJ' AND "+c_ent
	//cSQL += " BA1_CODMUN IN ('3300456','3303609','3302007','3305109','3302270','3300803','3301850','3303203','3303500','3302858','3302502',"+c_ent
	//cSQL += " '3304300','3305752','3304557','3303302','3304144','3305554','3304904','3301702','3301900','3302700') "+c_ent
	//cSQL += " AND BG9_CODIGO = BA1_CODEMP " + c_ent
	cSQL += " BG9_CODIGO = BA1_CODEMP " + c_ent
	cSQL += " AND BG9_HSPEMP = ' ' " + c_ent
	cSQL += " AND BA0_CODIDE||BA0_CODINT = BA1_OPEDES " + c_ent
	
	//cSQL += " AND BA1_NOMUSR= 'ACIME NAGEM FIGUEIREDO' " + c_ent
	
	cSQL += " ORDER BY BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO"
	
	//memowrit("C:\TEMP\CABA173_1.SQL",cSQL)
	
	PLSQuery(cSQL,"TF4")
	
	TF4->(DbGoTop())
	COUNT TO nCont//Conta o total de registros na tabela trazido pela query...
	
	cCodRDA := cRDASP
	cCodRDA := cRDARJ
	
	
	DbSelectArea("TF4")
	TF4->(Dbgotop())
	
	nCont := 0
	
	COUNT TO nCont
	
	TF4->(Dbgotop())
	
	If _cParam != "2" //Angelo Henrique - Data:20/04/2016
		
		oProcess:SetRegua1(nCont)
		
	EndIf
	
	cTot :=  allTrim(Transform(nCont, "@E 999,999,999,999"))
	nCont := 0
	
	_nSch := 0 //Contador para schedule
	
	nTotal := 0
	
	While !TF4->(Eof())
		
		_lVint := .F.
		_lTmBF4 := .F.
		
		If _cParam != "2" //Angelo Henrique - Data:20/04/2016
			
			oProcess:IncRegua1("Processando usuário " + allTrim(Transform(++nCont, "@E 999,999,999,999")) + ' de ' + cTot )
			
		Else
			
			++nCont
			
			If _nSch = 0 .OR. _nSch = nCont
				
				//------------------------------------------------------
				//Colocando de 1000 em 1000 para não poluir o console
				//------------------------------------------------------
				QOut("Processando usuario " + allTrim(Transform(nCont, "@E 999,999,999,999")) + ' de ' + cTot)
				_nSch += 1000
				
			EndIf
			
		EndIf
		
		If lAbortPrint
			Exit
		Endif
		
		//Referências a MV_PAR05 atualizadas para MV_PAR04 em 21/10/2010 por Renato Peixoto
		//verifcar no parametro qual o tipo de arquivo vou gerar
		// mv_par04 = 1 todos os usuarios validos
		
		// mv_par04 = 2 somente titular se houver dependente valido
		// mv_par04 = 3 todos os titulares
		If mv_par04 = 1  //todos os usuarios validos
			//			If TF4->BA1_TIPREG <> "00"
			//				nIdade :=Calc_Idade(mv_par02,TF4->BA1_DATNAS)
			//				If nIdade > TF4->BA1_YIDMPE
			//					TF4->(DbSkip())
			//					Loop
			//				Endif
			//				If TF4->BA1_YVAIPE = "0"
			//					TF4->(DbSkip())
			//					Loop
			//				Endif
			//			Endif
		ElseIf mv_par04 = 2  //2 somente titular se houver dependente valido
			If TF4->BA1_TIPREG = "00"
				nIdade :=Calc_Idade(mv_par02,TF4->BA1_DATNAS)
				cSql1 := "SELECT COUNT(BA1_MATRIC) AS Total FROM "+ cBA1Name
				cSql1 += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' AND "
				cSql1 += " BA1_CODINT = '"+TF4->BA1_CODINT+"' AND "
				cSql1 += " BA1_CODEMP = '"+TF4->BA1_CODEMP+"' AND "
				cSql1 += " BA1_CONEMP=  '"+TF4->BA1_CONEMP+"' AND "
				cSql1 += " BA1_VERCON = '"+TF4->BA1_VERCON+"' AND "
				cSql1 += " BA1_SUBCON = '"+TF4->BA1_SUBCON+"' AND "
				cSql1 += " BA1_VERSUB = '"+TF4->BA1_VERSUB+"' AND "
				cSql1 += " BA1_MATRIC = '"+TF4->BA1_MATRIC+"' AND "
				//				cSql1 += " BA1_YVAIPE = '1' AND "
				cSql1 += cBA1Name+".D_E_L_E_T_ = ' '"
				PLSQuery(cSQL1,"TBA1")
				DbSelectArea("TBA1")
				If TBA1->Total <= 1
					TBA1->(DbCloseArea("TBA1"))
					TF4->(DbSkip())
					Loop
				Else
					TBA1->(DbCloseArea("TBA1"))
				Endif
			Else
				TF4->(DbSkip())
				Loop
			Endif
		Else  //3 todos os titulares
			If TF4->BA1_TIPREG <> "00"
				TF4->(DbSkip())
				Loop
			Endif
		EndIf
		
		If !Empty(TF4->BA1_CODPLA)
			cCodPla1 := TF4->(BA1_CODPLA+BA1_VERSAO)
			cCodPla  := TF4->(BA1_CODPLA)
		Else
			cCodPla1 := TF4->(BA3_CODPLA+BA3_VERSAO)
			cCodPla  := TF4->(BA3_CODPLA)
		EndIf
		
		dDatIni := CtoD("  /  /    ")
		
		DbSelectArea("BT3")
		
		BT3->(DbSetOrder(1))
		
		If BT3->(DbSeek(xFilial("BT3")+TF4->BA1_CODINT+cCodPla1+"0023")) //BT3_FILIAL + BT3_CODIGO + BT3_VERSAO + BT3_CODPLA + BT3_VERPLA
			If BT3->BT3_TIPVIN == '0'
				//Pesquisa opcional no nivel do usuario
				BF4->(DbSetOrder(1)) //BF4_FILIAL + BF4_CODINT + BF4_CODEMP + BF4_MATRIC + BF4_TIPREG + BF4_CODPRO
				If !BF4->(DbSeek(xFilial("BF4")+TF4->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+"0023")))
					
					cSql2 := "SELECT * "
					cSql2 += " FROM " + RetSQLName("BA3") +" BA3 "
					cSql2 += " WHERE BA3_FILIAL = '"+xFilial("BA3")+"' AND "
					cSql2 += " BA3_CODINT = '"+TF4->BA1_CODINT+"' AND "
					cSql2 += " BA3_CODEMP = '"+TF4->BA1_CODEMP+"' AND "
					cSql2 += " BA3_CONEMP=  '"+TF4->BA1_CONEMP+"' AND "
					cSql2 += " BA3_VERCON = '"+TF4->BA1_VERCON+"' AND "
					cSql2 += " BA3_SUBCON = '"+TF4->BA1_SUBCON+"' AND "
					cSql2 += " BA3_VERSUB = '"+TF4->BA1_VERSUB+"' AND "
					cSql2 += " BA3_MATRIC = '"+TF4->BA1_MATRIC+"' AND "
					cSql2 += " BA3_CODPLA = '"+cCodPla+"' AND "
					cSql2 += "D_E_L_E_T_ = ' '"
					PLSQuery(cSQL2,"TBA3")
					DbSelectArea("TBA3")
					TBA3->(DbGoTop())
					If TBA3->(EOF())
						TBA3->(DbCloseArea("TBA3"))
						TF4->(DbSkip())
						Loop
					Endif
					TBA3->(DbCloseArea("TBA3"))
					
					//Pesquisa opcional no nivel da familia para verificar se o produto eh vinculado
					BF1->(DbSetOrder(1))   //BF1_FILIAL + BF1_CODINT + BF1_CODEMP + BF1_MATRIC + BF1_CODPRO
					If BF1->(DbSeek(xFilial("BF1")+TF4->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+"0023")))
						If BF1->BF1_TIPVIN = '0'  //Nao eh vinculado
							TF4->(DbSkip())
							Loop
						ElseIf !DTOS(BF1->BF1_DATBAS) <= DTOS(mv_par02) .or. !Empty(BF1->BF1_DATBLO) .or. !Empty(BF1->BF1_MOTBLO)
							TF4->(DbSkip())
							Loop
						EndIf
					Else
						TF4->(DbSkip())
						Loop
					EndIf
					dDatIni := BF1->BF1_DATBAS
				Else
					If !DTOS(BF4->BF4_DATBAS) <= DTOS(mv_par02) .or. !Empty(BF4->BF4_DATBLO) .or. !Empty(BF4->BF4_MOTBLO)
						TF4->(DbSkip())
						Loop
					EndIf
					dDatIni := BF4->BF4_DATBAS
				EndIf
				
			Else
				
				//------------------------------------------
				// Angelo Henrique - Data: 10/03/2016
				//------------------------------------------
				// Alguns beneficiários não estavam sendo
				// contemplados
				//------------------------------------------
				_lVint 	:= .T.
				_lTmBF4	:= .T.
				
			EndIf
		Else
			TF4->(DbSkip())
			Loop
		EndIf
		
		cDesPla := "Produto nao Identificado"
		BI3->(DbSetOrder(1))  //BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO = "  00010001001"
		If BI3->(DbSeek(xFilial("BI3")+TF4->BA1_CODINT+cCodPla1))
			cDesPla := BI3->BI3_NREDUZ
		EndIf
		
		dDtInicial := CtoD(substr(DtoC(dDataBase),1,6)+"/"+alltrim(Str(Val(Substr(DtoS(dDataBase),1,4))-65)))
		
		nIdade := Calc_Idade(mv_par02,TF4->BA1_DATNAS)
		
		If nIdade < 70 //65
			
			cCodBEM := "0023"  //Iif(Padr(Alltrim(TF4->BA1_ESTADO),2) == 'RJ',"0023","2323")+;   //"0023"+;   // Codigo de Grupo de Produtos BEM
			
			cCodADU := Space(03)
			
			//Pesquisa qual o codigo de lancamento de debito e credito do produto
			DbSelectArea("BT3")
			BT3->(DbSetOrder(1))  //BT3_FILIAL + BT3_CODIGO + BT3_VERSAO + BT3_CODPLA + BT3_VERPLA = "  000100010010023001"
			If !BT3->(DbSeek(xFilial("BT3")+TF4->BA1_CODINT+cCodPla+"0010023"))
				//Opcional no produto sem o codigo de lancamento
				aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
			ElseIf Empty(BT3_YCDADU)
				aadd(aCriticas,{"BT3","Produto ADU sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla+"]"})
			Else
				cCodADU := BT3->BT3_YCDADU
			EndIf
			//Acrescentado por Renato Peixoto em 08/09/10 para tratar relatório analítico
			//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
			//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
			If MV_PAR08 = 2 //analítico
				//aADD (aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR})  //ba1_tipreg, ba1_digito, ba1_telefo, ba1_sexo, ba1_matant, ba1_matvid, ba1_conemp, ba1_vercon, ba1_subcon, ba1_versub
				aADD (aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlADU,cProADU, TF4->BA1_TIPREG, TF4->BA1_DIGITO, TF4->BA1_TELEFO, TF4->BA1_SEXO, TF4->BA1_MATANT, TF4->BA1_MATVID, TF4->BA1_CONEMP, TF4->BA1_VERCON, TF4->BA1_SUBCON, TF4->BA1_VERSUB, nIdade, "ADU"})
				nContPlano++//incrementa o contador controlador do ADU
				aADD (aRelExcel,{"ADU",cCodPla,cDesPla, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlADU,TF4->IDADE,TF4->BA1_ESTADO,TF4->BA1_MUNICI})
				//chama a rotina que vai gerar o pagamento no contas médicas
				
			Else
				nPos := aScan(aPlano, {|x| x[1] == cCodPla})
				
				If nPos = 0
					Aadd(aPlano,{cCodPla,cDesPla,1,cCodADU})
				Else
					aPlano[nPos,3] := aPlano[nPos,3]+1
				EndIf
			EndIf//Fim alteração Renato.
		Else
			cCodBEM := "0024"
			cCdCGER := Space(03)
			
			DbSelectArea("BT3")
			BT3->(DbSetOrder(1))
			//Pesquisa qual o codigo de lancamento de debito e credito do produto
			If !BT3->(DbSeek(xFilial("BT3")+TF4->BA1_CODINT+cCodPla+"0010023"))
				aadd(aCriticas,{"BT3","Produto CARTEIRA GERENCIADA sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla1+"]"})
			ElseIf Empty(BT3_YCDGER)
				aadd(aCriticas,{"BT3","Produto CARTEIRA GERENCIADA sem codigo de Lancamento de Debito/Credito a nivel de produto ["+cCodPla1+"]"})
			Else
				cCdCGER := BT3->BT3_YCDGER
			EndIf
			
			//Alterado por Renato Peixoto em 08/09/10 para tratar relatório analítico
			//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
			//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
			If MV_PAR08 = 2 //analítico
				//Aadd(aCARGER, {cCodPla,cDesPla,cCdCGer, TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR, nIdade})
				aADD(aCARGER, {cCodPla,cDesPla,cCdCGer,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlCGER,cProCGER, TF4->BA1_TIPREG, TF4->BA1_DIGITO, TF4->BA1_TELEFO, TF4->BA1_SEXO, TF4->BA1_MATANT, TF4->BA1_MATVID, TF4->BA1_CONEMP, TF4->BA1_VERCON, TF4->BA1_SUBCON, TF4->BA1_VERSUB, nIdade, "CARGER"})
				nContCGER++ //Incrementa o contador controlador do Carteira Gerenciada
				aADD(aRelExcel, {"Carteira Gerenciada",cCodPla,cDesPla, TF4->BA1_MATRIC, TF4->BA1_NOMUSR,cCodRDA,nVlCGER,TF4->IDADE,TF4->BA1_ESTADO,TF4->BA1_MUNICI})
			Else
				nPos := aScan(aCARGER, {|x| x[1] == cCodPla})
				If nPos = 0
					Aadd(aCARGER,{cCodPla,cDesPla,1,cCdCGer})
				Else
					aCARGER[nPos,3] := aCARGER[nPos,3]+1
				EndIf
			EndIf//Fim alteração Renato.
		EndIf
		
		cUsu :=(TF4->BA1_CODINT+TF4->BA1_CODEMP+TF4->BA1_MATRIC+TF4->BA1_TIPREG+TF4->BA1_DIGITO)
		
		//Leonardo Portella - 05/07/11 - Inicio
		//Gravacao do projeto ao qual pertence o usuario com 50 ou mais anos
		
		cGrupo1 := Space(4)
		cGrupo2 := Space(4)
		
		//---------------------------------------------------------
		//Angelo Henrique - Data:24/11/2015
		//Trocando as validações conforme atualização do BEM
		//Mantido estes comentários para fins de conferência
		//---------------------------------------------------------
		/*
		If nIdade >= 50
			
			cAliasTmp := GetNextAlias()
			
			cQuery := "SELECT NVL(RETORNA_NUCLEO_MS(BF4_CODINT,BF4_CODEMP,BF4_MATRIC,BF4_TIPREG,'" + DtoS(dDataBase) + "'),' ') AGENCIA" 	+ c_ent
			cQuery += "FROM " + RetSqlName('BF4') 											  												+ c_ent
			cQuery += "WHERE D_E_L_E_T_ = ' '" 																								+ c_ent
			cQuery += "		AND BF4_FILIAL = '" + xFilial('BF4') + "'" 																		+ c_ent
			cQuery += "		AND BF4_CODINT = '" + TF4->BA1_CODINT + "'"    																	+ c_ent
			cQuery += "		AND BF4_CODEMP = '" + TF4->BA1_CODEMP + "'" 																	+ c_ent
			cQuery += "		AND BF4_MATRIC = '" + TF4->BA1_MATRIC + "'" 																	+ c_ent
			cQuery += "		AND BF4_TIPREG = '" + TF4->BA1_TIPREG + "'" 																	+ c_ent
			cQuery += "		AND BF4_MOTBLO = ' '" 		   																					+ c_ent
			cQuery += "		AND (BF4_DATBLO = ' ' OR BF4_DATBLO > '" + DtoS(MV_PAR02) + "')"												+ c_ent
			cQuery += "		AND BF4_MOTBLO = ' '"																							+ c_ent
			
			TcQuery cQuery New Alias cAliasTmp
			
			//Leonardo Portella - 31/10/11 - Inicio
			
			If allTrim(cAliasTmp->(AGENCIA)) $ '1|2|3'
				
				//cGrupo1 := '3547'
				
				//Codigo BEM que identifica que o beneficiario possui mais de 49 anos e esta em uma das agencias (TIJUCA, NITEROI ou BANGU)
				
				Do Case
					
				Case allTrim(cAliasTmp->(AGENCIA)) == '1'//Niteroi
					cGrupo1 := '3548'
					
				Case allTrim(cAliasTmp->(AGENCIA)) == '2'//Tijuca
					cGrupo1 := '3547'
					
				Case allTrim(cAliasTmp->(AGENCIA)) == '3'//Bangu
					cGrupo1 := '3549'
					
				EndCase
				
				//Leonardo Portella - 31/10/11 - Fim
				
				cGrupo2 := Space(4)
				
			EndIf
			
			cAliasTmp->(dbCloseArea())
			
		EndIf
		
		If empty(cGrupo1)//Mesmo conceito de antes, apenas separado por grupo
			
			cGrupo1 := If(cCodBEM == "0023",If(Padr(Alltrim(TF4->BA1_ESTADO),2) == 'RJ',"0023","2323")+Space(04),Space(04)+"0024")
			
			If  cCodBEM == "0023"
				
				If Padr(Alltrim(TF4->BA1_ESTADO),2) == 'RJ'
					
					"0023"
					
				Else
					
					"2323"
					
				EndIf
				
				
			EndIf
			
			
			cGrupo2 := Right(cGrupo1,4)
			cGrupo1 := Left(cGrupo1,4)
		EndIf
		
		*/
		
		_cMunc := "3300456|3303609|3302007|3305109|3302270|3300803|3301850|3303203|3303500|3302858|3302502|3304300|3305752|3304557|3303302|3304144|3305554|3304904|3301702|3301900|3302700"
		
		//-----------------------------------------------------------------------------
		//Angelo Henrique - Data: 10/03/2016
		//Caso tenha entrado na BT3 não há necessidade de validar BF4 e BF1
		//-----------------------------------------------------------------------------
		If !_lVint
			
			cAliasTmp := GetNextAlias()
			
			cQuery := "SELECT BF4.BF4_MATRIC, BF4.BF4_CODPRO, BF1.BF1_CODPRO "								+ c_ent
			cQuery += "FROM " + RetSqlName('BF4') + " BF4, " + RetSqlName('BF1') + " BF1 " 				+ c_ent
			cQuery += "WHERE BF4.D_E_L_E_T_ = ' '" 															+ c_ent
			cQuery += "		AND BF1.D_E_L_E_T_ = ' '" 														+ c_ent
			cQuery += "		AND BF4.BF4_FILIAL = '" + xFilial('BF4') + "'"								+ c_ent
			cQuery += "		AND BF1_FILIAL = '" + xFilial('BF1') + "'"									+ c_ent
			cQuery += "		AND BF4.BF4_CODINT = '" + TF4->BA1_CODINT + "'"  							+ c_ent
			cQuery += "		AND BF4.BF4_CODEMP = '" + TF4->BA1_CODEMP + "'" 								+ c_ent
			cQuery += "		AND BF4.BF4_MATRIC = '" + TF4->BA1_MATRIC + "'" 								+ c_ent
			cQuery += "		AND BF4.BF4_TIPREG = '" + TF4->BA1_TIPREG + "'" 								+ c_ent
			cQuery += "		AND BF4.BF4_MOTBLO = ' '" 		   												+ c_ent
			cQuery += "		AND (BF4.BF4_DATBLO = ' ' OR BF4.BF4_DATBLO > '" + DtoS(MV_PAR02) + "')"	+ c_ent
			cQuery += "		AND BF4.BF4_CODINT = BF1.BF1_CODINT "											+ c_ent
			cQuery += "		AND BF4.BF4_CODEMP = BF1.BF1_CODEMP "											+ c_ent
			cQuery += "		AND BF4.BF4_MATRIC = BF1.BF1_MATRIC "											+ c_ent
			
			TcQuery cQuery New Alias cAliasTmp
			
			While !EOF()
				
				If TF4->BA1_ESTADO = 'RJ' .And. TF4->BA1_CODMUN $ _cMunc
					
					_cBf4Cd := AllTrim(cAliasTmp->BF4_CODPRO)
					_cBf1Cd := AllTrim(cAliasTmp->BF1_CODPRO)
					
					//--------------------------------------------------------------------
					//ADU
					//Quando o beneficiário possui idade igual ou superior a 70 anos
					//se ele tiver código 0038 deverá entrar como carteira gerencial
					//--------------------------------------------------------------------
					If  _cBf4Cd = "0023" .OR. _cBf1Cd  = "0023" .OR. (nIdade >= 70 .AND. (_cBf4Cd = "0038" .OR. _cBf1Cd = "0038"))
						
						_lVint := .T.
						
					EndIf
					
					
				Else
					
					_lTmBF4 := .T.
					
					Exit
					
				EndIf
				
				_lTmBF4 := .T.
				
				cAliasTmp->(DbSkip())
				
			EndDo
			
			cAliasTmp->(dbCloseArea())
			
		EndIf
		
		If TF4->BA1_ESTADO = 'RJ' .And. TF4->BA1_CODMUN $ _cMunc
			
			If _lTmBF4
				
				If nIdade >= 70 .And. (TF4->BA1_CODEMP $ '0001|0002|0005') //MATER e AFINIDADE
					
					If _lVint
						
						cGrupo1 := "3546"
						
					Else
						
						cGrupo1 := "3545"
						
					EndIf
					
				Else
					
					cGrupo1 := "3545"
					
				EndIf
				
			Else
				
				cGrupo1 := "3545"
				
			EndIf
			
		Else
			
			If _lTmBF4 .OR. _lVint
				
				cGrupo1 := "3544"
				
			Else
				
				
				
			EndIf
			
		EndIf
		
		//---------------------------------------------------------
		//FIM - Angelo Henrique - Data:24/11/2015
		//Trocando as validações conforme atualização do BEM
		//---------------------------------------------------------
		
		aAdd(xUsu,{;
			Replicate('0',8)+;//Reservado
		PadR(cUsu,20)+;//Matricula
		PadR(cCodPla,10)+;//Codigo Plano
		Space(10)+;//Filler
		PadR(cDesPla,30)+;//Descricao do plano  //Space(10)+;//Filler		
		IIf(!Empty(dDatIni),DtoS(dDatIni),DtoS(TF4->BA1_DATINC))+;//Data adesao
		Space(08)+;//Filler
		IIf(TF4->BA1_TIPREG == "00","T","D")+;//Tipo Beneficiario - T = Titular; D = Dependente
		PadR(Alltrim(TF4->BA1_NOMUSR),50)+;//Nome associado
		DtoS(TF4->BA1_DATNAS)+;//Data Nascimento
		IIf(TF4->BA1_SEXO == "1","M","F")+;//Sexo
		Space(01)+;//Filler
		PadR(alltrim(TF4->BTS_DRGUSR),15)+;//RG
		PadR(Alltrim(TF4->BTS_CPFUSR),14)+;//CPF
		Space(20)+;//Filler
		PadR(alltrim(TF4->BA1_MUNICI),30)+;//Municipio
		PadR(Alltrim(TF4->BA1_ESTADO),2)+;//UF
		IIf(TF4->BG9_TIPO == "1","0","1")+;//Tipo de pessoa - 0 = Fisica; 1 = Juridica
		DtoS(TF4->BA1_DATBLO)+;//Data de validade
		cGrupo1+;//Codigo de Grupo 1 de Produtos BEM
		cGrupo2+;//Codigo de Grupo 2 de Produtos BEM
		Space(04)+;//Codigo de Grupo 3 de Produtos BEM
		Space(04)+;//Codigo de Grupo 4 de Produtos BEM
		Space(04)+;//Codigo de Grupo 5 de Produtos BEM
		Space(04)+;//Codigo de Grupo 6 de Produtos BEM
		Space(10)+;//Pessoa Juridica
		Space(40)+;//Nome da empresa do associado
		PadR(Alltrim(TF4->BA1_ENDERE),50)+;//Endereco
		PadR(Alltrim(TF4->BA1_NR_END),5)+;//Numero
		PadR(Alltrim(TF4->BA1_COMEND),10)+;//Complemento
		PadR(Alltrim(TF4->BA1_BAIRRO),30)+;//Bairro
		PadR(Alltrim(TF4->BA1_CEPUSR),8)+;//CEP
		PadR(Alltrim(TF4->BA1_DDD)+Alltrim(TF4->BA1_TELEFO),15)+;//Telefone 1
		Space(15)+;//Telefone 2
		Space(15)+;//Telefone 3
		PadR(Substr(Alltrim(TF4->BA1_MATANT),1,20),20)+;//Matricula anterior
		Space(02)+;//Motivo da baixa
		Space(10)+;//Codigo do convenio
		"I";//Operacao - I = Inclusao; E = Exclusao; A = Alteracao
		})
		
		//Leonardo Portella - 05/07/11 - Fim
		
		TF4->(DbSkip())
		
	Enddo
	
	TF4->(DbCloseArea("TF4"))
	
	//Se não houver nenhum usuário selecionado para ADU, CARGER nem VDS, significa que não existe registro a ser processado
	If Len(aPlano) = 0 .AND. Len(aCARGER) = 0 //.AND. Len(aVDS) = 0 não irá mais gerar pagamento VDS. Comentado por Renato Peixoto em 03/02/2011
		
		If _cParam != "2" //Angelo Henrique - Data:20/04/2016
			
			APMSGSTOP("Atenção, não existe pagamento/relatório a ser gerado de acordo com os parâmetros informados. Verifique os parâmetros e execute novamente.","Não existe pagamento a ser gerado para os parâmetros informados!")
			//Close(oGeraTxt)
			
		Else
			
			QOut("Atenção, não existe pagamento/relatório a ser gerado de acordo com os parâmetros informados. Verifique os parâmetros e execute novamente.","Não existe pagamento a ser gerado para os parâmetros informados!")
			
		EndIf
		
		Return
	EndIf
	
	//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
	//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
	If MV_PAR08 = 2 //analítico
		ASort(aPlano , , , {|x,y|x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] < y[1]+y[2]+y[3]+y[4]+y[5]+y[6]+y[7]})
		ASort(aCARGER, , , {|x,y|x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[7] < y[1]+y[2]+y[3]+y[4]+y[5]+y[6]+y[7]})
	EndIf
	
	nLinha := 0
	
	For I:= 1 to len(xUsu)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicio da Gravação do Arquivo Texto                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nlinha ++
		nTamLin := 120
		cLin    := space(Len(xUsu[I,1]))   //Space(nTamLin) // Variavel para criacao da linha do registros para gravacao
		
		//Leonardo Portella - 14/07/11 - Inclusao dos 50 caracteres (obs) no fim de cada linha conforme solicitacao da BEM.
		cCpo := xUsu[I,1] + strZero(nLinha,8) + space(50)
		//cCpo := xUsu[I,1]+strzero(nLinha,8)
		
		cLin := cCpo + cEOL
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Gravacao no arquivo texto. Testa por erros durante a gravacao da    ³
		//³ linha montada.                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			
			If _cParam != "2" //Angelo Henrique - Data:20/04/2016
				
				If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
					Exit
				Endif
				
			Else
				
				QOut("Ocorreu um erro na gravacao do arquivo")
				
			EndIf
			
		Endif
		
	Next
	
	fClose(nHdl)
	
	//Close(oGeraTxt)
	
	If _cParam != "2" //Angelo Henrique - Data:20/04/2016
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Emite relat¢rio                                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		RptStatus({|lEnd| Imprime_Log() }, "Imprimindo relatorio de ocorrencias ...", "", .T.)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Fim do programa                                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cTempoRot += "   /   Hora de término: "+Time()
		Alert(cTempoRot)
		
	EndIf
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Imprime_Log ³ Autor ³ Nelson / Angelo    ³ Data ³ 22/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio de criticas                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Imprime_Log()                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Imprime_Log()
	
	dbSelectArea(cAlias)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama SetPrint                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	wnRel := SetPrint(cAlias,wnRel,"",@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,,lCompres,Tamanho,{},lFiltro,lCrystal)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se foi cancelada a operacao                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  nLastKey  == 27
		Return
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Configura impressora                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetDefault(aReturn,cAlias)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Emite relat¢rio                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RptStatus({|lEnd| Impr_Log() }, "Imprimindo relatorio totalizador ...", "", .T.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim do programa                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Impr_Log ³ Autor ³ Nelson / Angelo       ³ Data ³ 22/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime relatorio de criticas                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Impr_Log()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Impr_Log()
	
	Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define variaveis...                                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local nQtdLin    := 58
	Local nColuna    := 00
	Local nOrdSel    := aReturn[8]
	Local nVlTot     := 0
	Local nTvalor    := 0
	
	Local nLoop      := 0
	Local cProduto   := ""
	Local nTotPrADU  := 0
	Local nTotPrCAGE := 0
	Local nTotPrVDS  := 0
	Local cOperadora := ""
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lista criticas                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If len(aPlano) > 0 .OR. Len(aCARGER) > 0 //.OR. Len(aVDS) > 0  //testo tambem o vetor aCARGER e aVDS. Alterado em 10/12/10. Renato Peixoto.  Não vai mais gerar pagamento VDS
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializa variaveis                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		//Lanc. Produto                                  Quant.  Vlr.Unit       Valor
		//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....9....+....0....+....1....+....2
		//XXX   XXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999999  999,99  9.999.999,99
		
		
		//	cTitulo := "Produtos com ADU - " + Iif(MV_PAR11 = 1," RIO DE JANEIRO"," SAO PAULO")
		cTitulo := "Produtos com ADU"
		cCabec1 := "Ativos ate: "+Dtoc(Mv_Par02)+"   Nome do Arquivo: "+cArquivo
		//Alterado por Renato Peixoto em 08/09/10
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 = 2 //analítico
			Tamanho := "M"
			Limite	:= 132
			//cCabec2 := "Matrícula                        Nome Usuário                                                   Valor Unitário"
			cCabec2 := "Matrícula                        Nome Usuário                                     Idade         Valor Unitário"
		Else
			cCabec2 := "Produto                                  Quant.  Vlr.Unit       Valor"  //"Produto                                            Quant."
		EndIf //Fim alteração Renato.
		Li := 99
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta regua                                                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SetRegua(len(aPlano))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Processa vetor com log de criticas                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For i := 1 to len(aPlano)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se foi cancelada a impressao                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//nLoop++
			
			If  Interrupcao(lAbortPrint)
				Li ++
				@ Li, nColuna pSay PLSTR0002
				Exit
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Movimenta regua                                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncRegua()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime cabecalho                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  Li > nQtdLin
				Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
				Li := 9
			Endif
			//Alteração Renato Peixoto para tratar relatório analítico
			//Verifica se trocou de plano
			//aPlano,{cCodPla,cDesPla,cCodADU,TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR}
			//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
			//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
			If MV_PAR08 = 2 //se for relatório analítico
				If cProduto <> aPlano[i,1]
					If i > 1
						Li++
						@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_NREDUZ"))
						@ Li, 096 pSay nTotPrADU Picture "@R 999,999,999.99"//095
						Li++
						@ Li,  0 pSay Replicate("-",Limite)
						Li++
						nTotPrADU := 0
					EndIf
					cProduto := aPlano[i,1]
					
					Li+=2
					@ Li, 000 pSay /*"Código ADU: "+aPlano[i,3]+" - */"Produto: "+aPlano[I,1] +"-" + aPlano[I,2]
					Li++
					
				EndIf
				Li++
				@ Li, 000 pSay aPlano[I,4]+aPlano[i,5]+aPlano[i,6]
				@ Li, 035 pSay aPlano[I,7]
				@ Li, 084 pSay aPlano[I,21]//idade
				@ Li, 095 pSay nVlADU Picture "@R 999,999,999.99"
				//Li++
				nTusu++
				nVlTot += nVlADU
				nTotPrADU += nVlADU
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime linha de detalhe                                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				@ Li, 000 pSay aPlano[I,4]
				@ Li, 006 pSay aPlano[I,1] +"-" + aPlano[I,2]
				@ Li, 047 pSay aPlano[I,3] Picture "@R 999999"
				@ Li, 055 pSay nVlADU Picture "@R 999,999,999.99"
				@ Li, 063 pSay aPlano[I,3]*nVlADU Picture "@R 9,999,999.99"
				Li ++
				nTusu := nTusu + aPlano[I,3]
				nVlTot += (aPlano[I,3]*nVlADU)
			EndIf
			cOperadora := aPlano[i][4]
		Next
		
		cTitulo := "Produtos com Carteira Gerenciada"
		//Produto                                  Quant.  Vlr.Unit       Valor
		//0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....9....+....0....+....1....+....2
		//XXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999999  999,99  9.999.999,99
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 = 2 //analítico
			Li++
			@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_NREDUZ"))
			@ Li, 096 pSay nTotPrADU Picture "@R 999,999,999.99"//095
			Li++
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			@ Li, 000 pSay "Total ADU"
			@ Li, 034 pSay "Quantidade de Usuários: "
			@ Li, 058 pSay nTusu Picture "@R 99999"
			@ Li, 090 pSay nVlTot Picture "@R 9,999,999.99"
			nTValor += nVlTot
			
			Li ++
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			Li ++
			
			cCabec2 := "Matrícula                        Nome Usuário                                     Idade         Valor Unitário"
			
			Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
			Li := 9
			@ Li, 000 pSay "CARTEIRA GERENCIADA"
			Li ++
			Li ++
		Else
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			@ Li, 000 pSay "Total ADU"
			@ Li, 041 pSay nTusu Picture "@R 99999"
			@ Li, 053 pSay nVlTot Picture "@R 9,999,999.99"
			nTValor += nVlTot
			
			Li ++
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			Li ++
			
			@ Li, 000 pSay "CARTEIRA GERENCIADA"
			Li ++
			Li ++
		EndIf
		
		nTusu := 0
		nVlTot := 0
		//nLoop := 0
		
		For i := 1 to len(aCARGER)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se foi cancelada a impressao                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nLoop++
			If  Interrupcao(lAbortPrint)
				Li ++
				@ Li, nColuna pSay PLSTR0002
				Exit
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Movimenta regua                                                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncRegua()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime cabecalho                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  Li > nQtdLin
				Li := Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")))
				Li := 9
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime linha de detalhe                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//Aadd(aCARGER, {cCodPla,cDesPla,cCdCGer, TF4->BA1_CODINT, TF4->BA1_CODEMP, TF4->BA1_MATRIC, TF4->BA1_NOMUSR})
			//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
			//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
			If MV_PAR08 = 2 //se for relatório analítico
				If cProduto <> aCARGER[i,1]
					If i > 1
						Li++
						@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_NREDUZ"))
						@ Li, 096 pSay nTotPrCAGE Picture "@R 999,999,999.99"
						Li++
						@ Li,  0 pSay Replicate("-",Limite)
						Li++
						nTotPrCAGE := 0
					EndIf
					cProduto := aCARGER[i,1]
					
					Li+=2
					@ Li, 000 pSay /*"Código Carteira Gerenciada: "+aCARGER[i,3]+" - */"Produto: "+aCARGER[I,1] +"-" + aCARGER[I,2]
					Li++
					
				EndIf
				Li++
				@ Li, 000 pSay aCARGER[I,4]+aCARGER[i,5]+aCARGER[i,6]
				@ Li, 035 pSay aCARGER[I,7]
				//@ Li, 084 pSay aCARGER[I,8]//idade
				@ Li, 084 pSay aCARGER[I,21]//idade
				@ Li, 095 pSay nVlCGER Picture "@R 999,999,999.99"
				//Li++
				nTusu++
				nVlTot += nVlCGER
				nTotPrCAGE += nVlCGER
			Else//se for sintético
				@ Li, 000 pSay aCARGER[I,4]
				@ Li, 006 pSay aCARGER[I,1] + "-" + aCARGER[I,2]
				@ Li, 047 pSay aCARGER[I,3] Picture "@R 999999"
				@ Li, 055 pSay nVlCGER Picture "@E 999,999,999.99"
				@ Li, 063 pSay aCARGER[I,3]*nVlCGER Picture "@E 9,999,999.99"
				Li ++
				nTusu := nTusu + aCARGER[I,3]
				nVlTot += (aCARGER[I,3]*nVlCGER)
			EndIf
			cOperadora := aCARGER[i][4]
		Next
		
		cTitulo := "Produtos com VDS"
		//Referências a MV_PAR13 atualizadas para MV_PAR09 em 21/10/2010 por Renato Peixoto
		//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
		If MV_PAR08 = 2 //analítico
			Li++
			@ Li, 000 pSay "TOTAL DO PRODUTO "+cProduto+"-"+AllTrim(POSICIONE("BI3",5,XFILIAL("BI3")+cOperadora+cProduto,"BI3_NREDUZ"))
			@ Li, 096 pSay nTotPrCAGE Picture "@R 999,999,999.99"
			Li++
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			@ Li, 000 pSay "Total CARTEIRA GERENCIADA"
			@ Li, 034 pSay "Quantidade de Usuários: "
			@ Li, 058 pSay nTusu Picture "@R 99999"
			@ Li, 090 pSay nVlTot Picture "@E 9,999,999.99"
			nTValor += nVlTot
			
			Li ++
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			Li ++
			Li ++
		Else
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			@ Li, 000 pSay "Total CARTEIRA GERENCIADA"
			@ Li, 041 pSay nTusu Picture "@R 99999"
			@ Li, 057 pSay nVlTot Picture "@E 9,999,999.99"
			nTValor += nVlTot
			
			Li ++
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			Li ++
		EndIf
		nTusu := 0
		nVlTot := 0
		
		If MV_PAR08 = 2 //analítico
			
			Li ++
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			Li ++
			@ Li, 041 pSay "TOTAL GERAL"
			@ Li, 092 pSay nTValor Picture "@E 9,999,999.99"
		Else
			
			@ Li,  0 pSay Replicate("-",Limite)
			Li ++
			Li ++
			@ Li, 041 pSay "TOTAL GERAL"
			@ Li, 057 pSay nTValor Picture "@E 9,999,999.99"
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime rodape do relatorio...                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Roda(0,space(10),Tamanho)
	Endif
	
	//Ordena o Vetor por ondem alfabética...
	ASort(aRelExcel , , , {|x,y|x[5] < y[5]})
	//Exibe o relatório em excel
	/////DlgToExcel({{"ARRAY","Usuários do programa ADU","",aRelExcel}})
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Libera impressao                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  aReturn[5] == 1
		Set Printer To
		Ourspool(wnRel)
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fim da funcao                                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Luzio Tavares       º Data ³  13/03/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria as perguntas no SX1.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)
	
	Local aRegs		:= {}
	
	/*BEGINDOC
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Alguns parâmetros foram retirados dessa rotina, pois a partir do momento que esta passou a ser³
	//³via inclusão de guias no contas médicas, não seriam mais necessários uma série de parâmetros  ³
	//³que antes eram utilizados nesta mesma rotina, quando a geração do pagamento era feita via l   ³
	//³lançamento débito/crédito.                                                                    ³
	//³                                                                                              ³
	//³By: Renato Peixoto                                                                            ³
	//³Data: 24/12/10                                                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
Aadd(aRegs,{cPerg,"01","Data Inicial?              ","","","MV_CH1","D",08,0,0,"G","           ","Mv_Par01","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Data Final?                ","","","MV_CH2","D",08,0,0,"G","           ","Mv_Par02","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Diretorio do Arquivo?      ","","","MV_CH3","C",60,0,0,"G","           ","Mv_Par03","   ","","","","","   ","","","","","","","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BB3PLS","BB3"),""}) //Local de Gravacao
//Não está em uso. Comentado em 21/10/2010 por Renato Peixoto.
//Aadd(aRegs,{cPerg,"04","Tipos de Arquivo?          ","","","MV_CH4","N",01,0,0,"C","           ","Mv_Par04","Atendimento Domiciliar","","","","","Todos Produtos","","","","","","","","","","","","","","","","","","","",""})
//Os parâmetros abaixo tiveram que ser renomeados, já que os parâmetros MV_PAR04 e MV_PAR09 foram retirados
Aadd(aRegs,{cPerg,"04","Tipos de Usuarios?         ","","","MV_CH4","N",01,0,0,"C","           ","Mv_Par04","Envia todos","","","","","Env.Tit.C/Dep","","","","","Envia so Titular","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"05","Ano Competencia?           ","","","MV_CH5","C",04,0,0,"G","           ","Mv_Par05","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"06","Mes Competencia?           ","","","MV_CH6","C",02,0,0,"G","PlsVldMes()","Mv_Par06","   ","","","","","   ","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07","Gera o Arquivo?            ","","","MV_CH7","N",01,0,0,"C","           ","Mv_Par07","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//MV_PAR09 não está em uso. Comentado em 21/10/2010 por Renato Peixoto.
//Aadd(aRegs,{cPerg,"09","Informa Grupo Empresa?     ","","","MV_CH9","N",01,0,0,"C","           ","Mv_Par09","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})

//MV_PAR08 comentado em 24/12/10, pois não será mais necessário gerar lançamento débito/crédito, já que o pagamento será feito via inclusão de guias no contas médicas. Renato Peixoto em 24/12/10
//Aadd(aRegs,{cPerg,"08","Gera Lanc. Debito/Credito? ","","","MV_CH8","N",01,0,0,"C","           ","Mv_Par08","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//Fim alteração Renato Peixoto.

//MV_PAR11 e 12 não estão em uso. Comentado por Renato Peixoto em 21/10/2010
//Aadd(aRegs,{cPerg,"11","Qual a Localidade?         ","","","MV_CHB","N",01,0,0,"C","           ","Mv_Par11","Rio de Janeiro","","","","","Sao Paulo","","","","","","","","","","","","","","","","","","","",""})
//Aadd(aRegs,{cPerg,"12","Gera Contas Médicas?       ","","","MV_CHC","N",01,0,0,"C","           ","Mv_Par12","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""})
//Renato Peixoto. 24/12/10. Parâmetro MV_PAR09 passa a ser MV_PAR08 devido a eliminação do parâmetro de geração déb./créd.
Aadd(aRegs,{cPerg,"08","Tipo de Relatório?         ","","","MV_CH8","N",01,0,0,"C","           ","Mv_Par08","Sintético","","","","","Analítico","","","","","","","","","","","","","","","","","","","",""})
//Renato Peixoto. 24/12/10. Parâmetro MV_PAR10 passa a ser MV_PAR09 devido a eliminação do parâmetro de geração déb./créd.
Aadd(aRegs,{cPerg,"09","Data do Evento:           ","","","MV_CH9","D",08,0,0,"G","           ","Mv_Par09","","","","","","","","","","","","","","","","","","","","","","","","","",""})

PlsVldPerg( aRegs )

Return(.T.)

