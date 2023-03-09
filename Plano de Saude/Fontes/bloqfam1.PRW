#INCLUDE "PROTHEUS.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "TCBROWSE.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BLOQFAMLIMºAutor  ³RAQUEL              º Data ³  10/04/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ SEPARA BLOQUEIO DATA LIMITE                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function BLOQFAMLIM(	cmv_par01, cmv_par02, cmv_par03, cmv_par04,;
							cmv_par05, cmv_par06,  cmv_par07,  cmv_par08,;
							cmv_par09,  cmv_par10)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis dos parametros...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cIntDe	:= cmv_par01
Private cIntAte	:= cmv_par02
Private cGruDe	:= cmv_par03
Private cGruAte	:= cmv_par04
Private cMatrDe	:= cmv_par05
Private cMatrAte:= cmv_par06


Private nBloLim	:= 1
Private cMotLim	:= cmv_par07

Private dDatDe	:= cmv_par08
Private dDatAte	:= cmv_par09
Private dDatBlo	:= cmv_par10

Private cA770ret:= ''
Private lAmbos  := .t.
Private aUsrBlo := {}
Private aBlqFin	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca dados dos parametros...                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cMv_Par01 == Nil
	CriaSX1('L')
	
	If !Pergunte("BLOLIM",.T.)
		Return(.F.)
	Endif
	
	//Parametros cadastrais.
	cIntDe   := mv_par01
	cIntAte  := mv_par02
	cGruDe   := mv_par03
	cGruAte  := mv_par04
	cMatrDe  := mv_par05
	cMatrAte := mv_par06
	
	// Relativos ao financeiro
	nBloFin  := 0
	dRefFin	 := ' '
	cMotFin  := ' '
	
	// Limete de permanencia no plano apos demissao ou aposentadoria.
	cMotLim  := mv_par07
	
	// Relativos a maioridade.
	nBloMai  := 0
	cMotMai  := ' '
	cGrauPa	 := ' '
	nIdaMai	 := ' '
	nIdaUni  := ' '
	dDatDe   := mv_par08
	dDatAte  := mv_par09
	dDatBlo  := mv_par10
Endif
Mv_Par20:=Mv_Par11
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa funcao que ira bloquear os contratos...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa( {|| A770Blo(cIntDe,cIntAte,cGruDe,cGruAte,cMatrDe,cMatrAte,dDatBlo,"BLOLIM", dDatDe, dDatAte) }, "Processando...")

Return(.T.)

/*FIM BLOQUEIO DATA LIMITE**/


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BLOQFIN   ºAutor  ³RAQUEL              º Data ³  24/04/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ SEPARA BLOQUEIO FINANCEIRO                                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function BLOQFIN(	cmv_par01, cmv_par02,  cmv_par03,  cmv_par04,;
						cmv_par05, cmv_par06,  cmv_par07,  cmv_par08)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis dos parametros...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cIntDe	:= cmv_par01
Private cIntAte	:= cmv_par02
Private cGruDe	:= cmv_par03
Private cGruAte	:= cmv_par04
Private cMatrDe	:= cmv_par05
Private cMatrAte:= cmv_par06

Private nBloFin	:= 1
Private dRefFin	:= cmv_par07
Private cMotFin	:= ""  //cmv_par08

// Private dDatBlo	:= cmv_par09

Private cA770ret:= ''
Private lAmbos  := .t.
Private aUsrBlo := {}
Private aBlqFin	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca dados dos parametros...                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cMv_Par01 == Nil
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ajusta perguntas                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CriaSX1('F')
	
	If !Pergunte("BLOFIN",.T.)
		Return(.F.)
	Endif
	
	//Parametros cadastrais.
	cIntDe   := mv_par01
	cIntAte  := mv_par02
	cGruDe   := mv_par03
	cGruAte  := mv_par04
	cMatrDe  := mv_par05
	cMatrAte := mv_par06
	
	// Relativos ao financeiro
	dRefFin	 := mv_par07
	cMotFin  := "" //mv_par08
	
	// Limete de permanencia no plano apos demissao ou aposentadoria.
	nBloLim  := 0
	cMotLim  := ' '
	
	// Relativos a maioridade.
	nBloMai  := 0
	cMotMai  := ' '
	cGrauPa	 := ' '
	nIdaMai	 := ' '
	nIdaUni  := ' '
	dDatDe   := ' '
	dDatAte  := ' '
	// dDatBlo  := mv_par09
Endif
Mv_Par20:=Mv_Par08
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa funcao que ira bloquear os contratos...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa( {|| A770Blo(cIntDe,cIntAte,cGruDe,cGruAte,cMatrDe,cMatrAte,dDataBase/*CToD("  /  /    ")*/,"BLOFIN", ,dRefFin) }, "Processando...")

Return(.T.)

/*FIM BLOQUEIO FINANCEIRO**/


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ PLSA770 ³ Autor ³ Tulio Cesar            ³ Data ³ 14.09.00 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Tratamento para bloqueio automatico de familias.           ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Sintaxe   ³ PLSA770()                                                  ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Uso      ³ Advanced Protheus                                          ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Alteracoes desde sua construcao inicial.                              ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³ Data     ³ BOPS ³ Programador ³ Breve Descricao                       ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³05.02.2001³      ³ Guilherme   ³ Inclusao do parametro dDatFin         ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³06.02.2001³      ³ Michele     ³ Verifica se o usuario ja estava       ³±±±
±±³          ³      ³             ³ boloqueado                            ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±±
±±³12.05.2004³      ³ Jota!       ³ reestruturacao da rotina para versao  ³±±±
±±³          ³      ³             ³ 8.11. Agora chama funcao generica.    ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function BLOQFAM(cmv_par01, cmv_par02, cmv_par03, cmv_par04,;
cmv_par05, cmv_par06, cmv_par07, cmv_par08,;
cmv_par09, cmv_par10, cmv_par11, cmv_par12,;
cmv_par13, cmv_par14, cmv_par15, cmv_par16,;
cmv_par17, cmv_par18, cmv_par19)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis dos parametros...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cIntDe	:= cmv_par01
Private cIntAte	:= cmv_par02
Private cGruDe	:= cmv_par03
Private cGruAte	:= cmv_par04
Private cMatrDe	:= cmv_par05
Private cMatrAte:= cmv_par06

Private nBloFin	:= cmv_par07
//Private dRefFin	:= cmv_par08
Private cMotFin	:= ""  //cmv_par09

Private nBloLim	:= cmv_par10
Private cMotLim	:= cmv_par11

Private nBloMai	:= cmv_par12
Private cMotMai	:= cmv_par13
Private cGrauPa	:= cmv_par14
Private nIdaMai	:= cmv_par15
Private nIdaUni	:= cmv_par16
Private dDatDe	:= cmv_par17
Private dDatAte	:= cmv_par18
Private dDatBlo	:= cmv_par19

Private cA770ret:= ''
Private lAmbos  := .t.
Private aUsrBlo := {}
Private aBlqFin	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca dados dos parametros...                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cMv_Par01 == Nil
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ajusta perguntas                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CriaSX1('F')
	
	If !Pergunte("PLA770",.T.)
		Return(.F.)
	Endif
	
	//Parametros cadastrais.
	cIntDe   := mv_par01
	cIntAte  := mv_par02
	cGruDe   := mv_par03
	cGruAte  := mv_par04
	cMatrDe  := mv_par05
	cMatrAte := mv_par06
	
	// Relativos ao financeiro
	nBloFin  := mv_par07
	//	dRefFin	 := mv_par08
	dRefFin	 := mv_par08
	cMotFin  := ""  //mv_par09
	
	// Limete de permanencia no plano apos demissao ou aposentadoria.
	nBloLim  := mv_par10
	cMotLim  := mv_par11
	
	// Relativos a maioridade.
	nBloMai  := mv_par12
	cMotMai  := mv_par13
	cGrauPa	 := mv_par14
	nIdaMai	 := mv_par15
	nIdaUni  := mv_par16
	dDatDe   := mv_par17
	dDatAte  := mv_par18
	dDatBlo  := mv_par19
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa funcao que ira bloquear os contratos...                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa( {|| A770Blo(cIntDe,cIntAte,cGruDe,cGruAte,cMatrDe,cMatrAte,dDatBlo,"PLA770", , dRefFin) }, "Processando...")

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ A770BLO ³ Autor ³ Tulio Cesar            ³ Data ³ 14.09.00 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Bloqueia familias automaticamente de acordo com regras.    ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A770Blo(cIntDe,cIntAte,cGruDe,cGruAte,cMatrDe,cMatrAte,dDatBlo,cPergunta, dBloIni, dBloFin)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cInd    		:= CriaTrab(nil,.F.)
Local cOrdem    	:= ''
Local cFor			:= ''
Local nQtdMes 		:= 0
Local lBloqFam	 	:= .F.
Local nRecBA3		:= BA3->( Recno() )
Local nRecBA1		:= BA1->( Recno() )
Local cTitular 		:= SuperGetMv("MV_PLCDTIT")
Local nIdade		:= 0
Local aDadUsr		:= {}
Local aPosFin		:= {}
Local __cNivBlq		:= '0'
Local cMotBlo		:= ''
Local aRet			:= {}
Local aLog			:= {}
Local aAreaSA1		:= SA1->(GetArea())
Local aAreaSE1		:= SE1->(GetArea())
Local dDataBloq      :=''
Local cAcao := "FAMILIA BLOQUEADA!"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definicao de variaveis utilizadas no relatorio de emissao do LOG³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel   	:= "PLSA770"			// Nome do Arquivo utilizado no Spool
Local Titulo 	:= "Relatorio de análise de bloqueio de Família/Usuário"
Local cDesc1 	:= "Este programa irá emitir uma relação famílias e usuários encontradas"
Local cDesc2 	:= "no arquivo que atendam as regras dos parametros informados e"
Local cDesc3 	:= "serão posteriormente bloqueados."
Local nomeprog	:= "PLSA770.PRW"		// nome do programa
Local cString 	:= ""					// Alias utilizado na Filtragem
Local lDic    	:= .F. 					// Habilita/Desabilita Dicionario
Local lComp   	:= .F. 					// Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro 	:= .F. 					// Habilita/Desabilita o Filtro

Private Tamanho := "P"					// P/M/G
Private Limite  := 80					// 80/132/220
Private aReturn := { 	"Zebrado",;		//[1] Reservado para Formulario
						1,;				//[2] Reservado para N§ de Vias
						"Administração",;	//[3] Destinatario
						2,;				//[4] Formato => 1-Comprimido 2-Normal
						2,;	    		//[5] Midia   => 1-Disco 2-Impressora
						1,;				//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						"",;				//[7] Expressao do Filtro
						1 } 				//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)

Private m_pag   := 1					// Contador de Paginas
Private nLastKey:= 0					// Controla o cancelamento da SetPrint e SetDefault
Private cPerg   := cPergunta			// Pergunta do Relatorio
Private aOrdem  := {}					// Ordem do Relatorio
Private nQtdLin := 0					//qtd de bloqueados 

Default dBloIni := StoD(' ')

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define ordem default no arquivo de contas a receber...              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SE1->(DbSetOrder(GETMV("MV_PLORDE1")))
BA1->( dbSetorder(2) )
SA1->(DbSetOrder(1))  
                      
//Leonardo Portella - 22/03/13 - Inicio - Melhoria de performance. Ao inves de varrer toda a BA3, seleciono os R_e_c_n_o_ via SQL e ponteiro nela.

cQuery := "SELECT R_E_C_N_O_" 															   						+ CRLF
cQuery += "FROM " + RetSqlName('BA3') 															  				+ CRLF
cQuery += "WHERE BA3_FILIAL = '" + xFilial('BA3') + "'"												 			+ CRLF
cQuery += "		AND BA3_CODINT BETWEEN '"+cIntDe+"'  AND '"+cIntAte+"'"			 								+ CRLF
cQuery += "		AND BA3_CODEMP BETWEEN '"+cGruDe+"'  AND '"+cGruAte+"'"			 					  			+ CRLF
cQuery += "		AND BA3_MATRIC BETWEEN '"+cMatrDe+"' AND '"+cMatrAte+"'" 							   			+ CRLF
  
//Leonardo Portella - 09/04/13 - Inicio - Quando for a chamada da data limite e bloqueio por viagem ao exterior (028), ira desbloquear o usuario e bloquea-lo com a 
//data informada. O filtro da data de bloqueio devera estar entre a data limite inicial e final, conforme conversado com Ana Paula em 09/04/13

//cQuery += "		AND ( BA3_MOTBLO = ' ' OR ( BA3_MOTBLO = '028' AND BA3_DATBLO >= '" + DTOS(dBloFin) + "' ) )" 	+ CRLF
If !empty(dBloIni)
	cQuery += "		AND ( BA3_MOTBLO = ' ' OR ( BA3_MOTBLO = '028' AND BA3_DATBLO BETWEEN '" + DTOS(dBloIni) + "' AND '" + DTOS(dBloFin) + "' ) )" 	+ CRLF
Else
	cQuery += "		AND BA3_MOTBLO = ' '" 																		+ CRLF
EndIf                                   


// Motta 17/6/14 tratar empresa 0013	SERJUS              
cQuery += "		AND ( (BA3_COBNIV = '1' OR BA3_CODEMP IN ('0004','0009'))  " 							 		+ CRLF
cQuery += "	          OR  " 							 		+ CRLF
cQuery += "		      (BA3_COBNIV = '0' OR BA3_CODEMP = '0013') ) " 							 		+ CRLF
// Motta 17/6/14

// Marcela Coimbra
cQuery += "		AND ( BA3_YSITBQ = ' ' OR BA3_YSITBQ = '1' ) " 							 		+ CRLF

//Leonardo Portella - 09/04/13 - Fim

cQuery += "		AND D_E_L_E_T_ = ' '" 							 												+ CRLF

cAlias := GetNextAlias()

TcQuery cQuery New Alias cAlias

If cAlias->(EOF())
	Help("",1,"RECNO")
	cAlias->(DbCloseArea())
	Return(.F.)
EndIf

nQtd := 0

COUNT TO nQtd

cAlias->(DbGoTop())

ProcRegua(nQtd)

BA3->(DbGoTop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a verificacao das familias selecionadas...                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While !cAlias->(EOF())
    
	BA3->(DbGoTo(cAlias->(R_E_C_N_O_)))
	
	IncProc( "Analisando familia - "+Transform((BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_MATRIC), __cPictFam) )
	
	cAcao := "FAMILIA BLOQUEADA!"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona o grupo empresa...                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BG9->(DbSetOrder(1))
	BG9->(DbSeek(xFilial("BG9")+BA3->BA3_CODEMP))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciono o contrato...                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(BA3->BA3_CONEMP)
		BT5->( dbSetorder(01) )
		BT5->( dbSeek(xFilial("BT5")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_CONEMP+BA3->BA3_VERCON) )
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciono o sub contrato...                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(BA3->BA3_SUBCON)
		BQC->( dbSetorder(01) )
		BQC->( dbSeek(xFilial("BT5")+BA3->BA3_CODINT+BA3->BA3_CODEMP+BA3->BA3_CONEMP+BA3->BA3_VERCON+BA3->BA3_SUBCON+BA3->BA3_VERSUB) )
	Endif

	If nBloLim == 1
//  TESTE COM MATRICULAS FIXAS
//	If nBloLim == 1 .and. BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC) $ ('00010001002527|00010001003487|00010001013826|00010001014238|00010001019261|00010001019829|00010001028667|00010001030256|00010001033260|00010001033260|00010001034872|00010001037751|00010001038586|00010001039326')
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona o titular da familia...                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA1->( dbSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)) )
		If BA1->( FieldPos("BA1_YDTLIM") ) > 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se houve desligamento do titular por demissao ou aposentadoria |
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(BA1->BA1_YDTLIM)

				If (dTos(BA1->BA1_YDTLIM) >= dTos(dDatDe) .and.;
					dTos(BA1->BA1_YDTLIM) <= dTos(dDatAte))
					lBloqFam  := .T.
					__cNivBlq := '1'
					
				Endif
			Endif
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida situacao financeira...                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If  nBloFin == 1 .and. !lBloqFam

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona o titular da familia...                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		x := BA1->( dbSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)) )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta matriz padrao com os dados do usuario...                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aRet := PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase,nil,nil,nil)
		If aRet[1]
			aDadUsr := PLSGETUSR()
		Else                                             
			BA3->(DbSkip())
			lBloqFam := .F.
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia a posicao financeira da familia usando funcao generia.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	   //	aPosFin := PLSVLDFIN(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),dRefFin,'','','1',aDadUsr)
		aPosFin := VerTitAb( BA1->BA1_CODEMP, BA1->BA1_MATRIC, dRefFin)
		If Len(aPosFin) <> 0
		//If !aPosFin[1]
			// Para indicar o bloqueio
			lBloqFam := .T.
			__cNivBlq := '2'
		Endif
		
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ A familia nao foi bloqueada, agora analiza regras individuais       ³
	//³ para ver se algum usuario sera bloqueado...                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lBloqFam
		// Regra 1 - Data Limite. Caso seja considerado via perguntas.
		If nBloLim == 1
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Processa todos os usuarios da familia, exceto Titular.                    |
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If BA1->( MsSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)) )

				While	BA1->( !Eof() )						.AND.;
					BA1->BA1_FILIAL == xFilial("BA1")	.AND.;
					BA1->BA1_CODINT == BA3->BA3_CODINT	.AND.;
					BA1->BA1_CODEMP == BA3->BA3_CODEMP	.AND.;
					BA1->BA1_MATRIC == BA3->BA3_MATRIC
					// Caso seja um dependente selecionado.
				   
					If !Empty(BA1->BA1_YDTLIM) .AND. BA1->BA1_TIPUSU # cTitular .AND. ;
					    (BA1->BA1_MOTBLO = ' ' .AND. (BA1->BA1_MOTBLO = '028' .OR. BA1->BA1_DATBLO >= dBloFin .OR. Empty(BA1->BA1_DATBLO) ) )
						//BIANCHINI - 13/06/2013 - Nao tratava os associados que deveriam ser bloqueados que estivessem ativos
						//(BA1->BA1_MOTBLO = ' ' .AND. (BA1->BA1_MOTBLO = '028' .OR. BA1->BA1_DATBLO >= dBloFin ) )
					
						If (dTos(BA1->BA1_YDTLIM) >= dTos(dDatDe) .and.;
							dTos(BA1->BA1_YDTLIM) <= dTos(dDatAte))
							__cNivBlq:='1'
							dDataBloqueio:=dDatblo
							If Empty(dDataBloqueio)
								dDataBloqueio :=BA1->BA1_YDTLIM
							Endif
							If Mv_Par20 == 1		// Analisa e nao bloqueia
								//Aadd( aLog, " -----------> BLOQUEIO POR DATA LIMITE" ) // em 16.07.2014 - OSP chamado 12396
								Aadd( aLog, " -----------> BLOQUEIO POR DATA LIMITE"+if(!empty(BA1->BA1_YMTREP)," (Repasse)","") )
								Aadd( aLog, " Matricula--> " + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) )
								Aadd( aLog, " Nome-------> " + BA1->BA1_NOMUSR )
								Aadd( aLog, " Cd.Cliente-> " + BA3->BA3_CODCLI ) //Gedilson - Inserido codigo do cliente conforme soli.Caberj
								Aadd( aLog, " Motivo-----> " + cMotLim )
								Aadd( aLog, " Nascimento-> " + DtoC(BA1->BA1_DATNAS) )
								Aadd( aLog, " Bloqueio---> " + DtoC(dDataBloqueio) )
								Aadd( aLog, " Idade Hoje-> " + AllTrim(StrZero( ( (dDataBase - BA1->BA1_DATNAS) / 365.25 ),3)) )
								Aadd( aLog, " Idade Bloq-> " + AllTrim(StrZero( ( (dDataBloqueio - BA1->BA1_DATNAS) / 365.25 ),3)) )
								Aadd( aLog, " ")
								nQtdLin := nQtdLin + 1
							Endif
							If Mv_Par20 == 2		// Efetua o bloqueio

								//Trecho de codigo modificado em 02/12/2009 por Luzio.
								//Esta condicao foi criada para que execute o bloqueio efetivo do beneficiario no caso de data limite.
								//Atender a INTEGRAL 

								If Alltrim(cPerg) == "BLOLIM" .or. Alltrim(cPerg) == "PLA770"
									PL260BLOUS("BA1",BA1->( Recno() ),4,.T.,cMotLim,dDataBloqueio,BG1->BG1_BLOFAT)
								Else
									RecLock("BA3",.F.)
									BA3->BA3_YSITBQ := "1" //MARCADO PARA BLOQUEIO   
									cMatMarq := (BA3->ba3_codemp+BA3->ba3_matric+";")
									BA3->(MsUnlock())
								EndIf
								aadd(aUsrBlo,{BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),Substr(BA1->BA1_NOMUSR,1,30),cMotLim,DtoC(dDataBloqueio)})
								nQtdLin := nQtdLin + 1
							Endif
							If Mv_Par20 == 3
								Aadd( aLog, { "BA1", BA1->( Recno() ) } )
							Endif
							dDataBloqueio := CtoD("//")
						Endif
					Endif
					BA1->( dbSkip() )
				Enddo
			Endif
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Testa se a familia deve ser marcada para bloqueio                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica origem do bloqueio e posiciona o cadastro...               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If __cNivBlq == '1'
			cMotBlo := cMotLim
			
		Elseif __cNivBlq == '2'
			cMotBlo := ""  //cMotFin
			
		Endif
		BG1->( dbSetorder(01) )
		BG1->( dbSeek(xFilial("BG1")+cMotBlo) )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona o titular da familia...                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BA1->( dbSeek(xFilial("BA1")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)) )
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Para cada familia lida verifico bloqueio...                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dDataBloqueio:=dDatBlo
		If Empty(dDataBloqueio)
			if __cNivBlq == '2'
				dDataBloqueio := dDataBase			// Finaneiro
			Endif
			if __cNivBlq == '1'
				dDataBloqueio :=BA1->BA1_YDTLIM
			Endif
			
			If Mv_Par20 == 1		// Analisa e nao bloqueia
				If __cNivBlq == '1'
                    //Aadd( aLog, " -----------> BLOQUEIO DA FAMÍLIA POR DATA LIMITE") // em 16.07.2014 - OSP chamado 12396
                    Aadd( aLog, " -----------> BLOQUEIO DA FAMÍLIA POR DATA LIMITE"+if(!empty(BA1->BA1_YMTREP)," (Repasse)",""))
				Elseif __cNivBlq == '2'
                    //Aadd( aLog, " -----------> BLOQUEIO DA FAMÍLIA POR MOTIVO FINANCEIRO") // em 16.07.2014 - OSP chamado 12396
					Aadd( aLog, " -----------> BLOQUEIO DA FAMÍLIA POR MOTIVO FINANCEIRO"+if(!empty(BA1->BA1_YMTREP)," (Repasse)",""))
				Endif
				Aadd( aLog, " Matricula--> " + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) + " " + " Cd.Cliente-> " + BA3->BA3_CODCLI )
				Aadd( aLog, " Nome-------> " + BA1->BA1_NOMUSR + " " + " Idade Hoje-> " + AllTrim(StrZero( ( (dDataBase - BA1->BA1_DATNAS) / 365.25 ),3)))
				//Aadd( aLog, " Cd.Cliente-> " + BA3->BA3_CODCLI )
				//Aadd( aLog, " Motivo-----> " + cMotBlo )
				//Aadd( aLog, " Nascimento-> " + DtoC(BA1->BA1_DATNAS) )
				//Aadd( aLog, " Bloqueio---> " + DtoC(dDataBloqueio) )
				//Aadd( aLog, " Idade Hoje-> " + AllTrim(StrZero( ( (dDataBase - BA1->BA1_DATNAS) / 365.25 ),3)) )
				// //Aadd( aLog, " Idade Bloq-> " + AllTrim(StrZero( ( (dDataBloqueio - BA1->BA1_DATNAS) / 365.25 ),3)) )  
				
			
				If __cNivBlq == '2'
					Aadd( aLog, " Prc aberto-> " + "???" + " " + " Vlr aberto-> " + Transform( aPosFin[3] ,"999,999.99") + " " + " Dia aberto-> " + Transform( aPosFin[4] ,"999,999.99") )
					//Aadd( aLog, " Prc aberto-> " + aPosFin[2,2,3] + " " + " Vlr aberto-> " + aPosFin[2,4,3] + " " + " Dia aberto-> " + aPosFin[2,3,3])
					//Aadd( aLog, " Prc aberto-> " + aPosFin[2,2,3] + " " + " Vlr aberto-> " + aPosFin[2,4,3] + " " + " Dia aberto-> " + aPosFin[2,3,3])
					//Aadd( aLog, " Vlr aberto-> " + aPosFin[2,4,3] )
					//Aadd( aLog, " Dia aberto-> " + aPosFin[2,3,3] )
				End if
				Aadd( aLog, " ")
				nQtdLin := nQtdLin + 1
			Endif
			If Mv_Par20 == 2		// Efetua o bloqueio

				//Trecho de codigo modificado em 02/12/2009 por Luzio.
				//Esta condicao foi criada para que execute o bloqueio efetivo do beneficiario no caso de data limite.
				//Atender a INTEGRAL
				If Alltrim(cPerg) == "BLOLIM" .or. Alltrim(cPerg) == "PLA770"                    
					//Leonardo Portella - 22/03/13
					//PL260BLOCO("BA3",BA3->(RecNo()),4,.T.,cMotBlo,dDataBloqueio,BG1->BG1_BLOFAT)
					BloqFamUsr("BA3",BA3->(RecNo()),4,.T.,cMotBlo,dDataBloqueio,BG1->BG1_BLOFAT)
				Else       

					RecLock("BA3",.F.)
					BA3->BA3_YSITBQ := "1" //MARCADO PARA BLOQUEIO    
					cMatMarq := (BA3->ba3_codemp+BA3->ba3_matric+";")
					BA3->(MsUnlock())
					cAcao := "FAMILIA MARCADA!"
				EndIf
				aadd(aUsrBlo,{BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),cAcao,cMotBlo,DtoC(dDataBloqueio)})
				nQtdLin := nQtdLin + 1
				If Len(aPosFin) > 0
					AlimCarta(BA3->BA3_CODCLI, BA3->BA3_LOJA, @aBlqFin, aPosFin)
				Endif
			Endif
			If Mv_Par20 == 3
				Aadd( aLog, { "BA1", BA1->( Recno() ) } )
			Endif
			dDataBloqueio := CtoD("//")
		Else
			If Mv_Par20 == 1		// Analisa e nao bloqueia
				If __cNivBlq == '1'
                    //Aadd( aLog, " -----------> BLOQUEIO DA FAMÍLIA POR DATA LIMITE") // em 16.07.2014 - OSP chamado 12396
                    Aadd( aLog, " -----------> BLOQUEIO DA FAMÍLIA POR DATA LIMITE"+if(!empty(BA1->BA1_YMTREP)," (Repasse)",""))
				Elseif __cNivBlq == '2'                                                                                               
				    //Aadd( aLog, " -----------> BLOQUEIO DA FAMÍLIA POR MOTIVO FINANCEIRO") // em 16.07.2014 - OSP chamado 12396
					Aadd( aLog, " -----------> BLOQUEIO DA FAMÍLIA POR MOTIVO FINANCEIRO"+if(!empty(BA1->BA1_YMTREP)," (Repasse)",""))
				Endif
				Aadd( aLog, " Matricula--> " + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) + " " + " Cd.Cliente-> " + BA3->BA3_CODCLI )
				Aadd( aLog, " Nome-------> " + BA1->BA1_NOMUSR + " " + " Idade Hoje-> " + AllTrim(StrZero( ( (dDataBase - BA1->BA1_DATNAS) / 365.25 ),3)))
				//Aadd( aLog, " Cd.Cliente-> " + BA3->BA3_CODCLI )
				//Aadd( aLog, " Motivo-----> " + cMotBlo )
				//Aadd( aLog, " Nascimento-> " + DtoC(BA1->BA1_DATNAS) )
				//Aadd( aLog, " Bloqueio---> " + DtoC(dDataBloqueio) )
				//Aadd( aLog, " Idade Hoje-> " + AllTrim(StrZero( ( (dDataBase - BA1->BA1_DATNAS) / 365.25 ),3)) )
				// //Aadd( aLog, " Idade Bloq-> " + AllTrim(StrZero( ( (dDataBloqueio - BA1->BA1_DATNAS) / 365.25 ),3)) )
				If __cNivBlq == '2'                       
				// mbc  aadd( a_Ret, STOD( (c_Alias)->VENCIMENTO ), (c_Alias)->QUANTIDADE, (c_Alias)->SALDO ) , STOD( (c_Alias)->VENCIMENTO ) - Date() )
					Aadd( aLog, " Prc aberto-> " + "???" + " " + " Vlr aberto-> " + Transform( aPosFin[3] ,"999,999.99") + " " + " Dia aberto-> " + Transform( aPosFin[4] ,"999,999.99"))
					// mbc Aadd( aLog, " Prc aberto-> " + aPosFin[2,2,3] + " " + " Vlr aberto-> " + aPosFin[2,4,3] + " " + " Dia aberto-> " + aPosFin[2,3,3])
					//Aadd( aLog, " Vlr aberto-> " + aPosFin[2,4,3] )
					//Aadd( aLog, " Dia aberto-> " + aPosFin[2,3,3] )
				End if
				Aadd( aLog, " ")
				nQtdLin := nQtdLin + 1
			Endif
			If Mv_Par20 == 2		// Efetua o bloqueio
				//Trecho de codigo modificado em 02/12/2009 por Luzio.
				//Esta condicao foi criada para que execute o bloqueio efetivo do beneficiario no caso de data limite.
				//Atender a INTEGRAL
				If Alltrim(cPerg) == "BLOLIM" .or. Alltrim(cPerg) == "PLA770"
					if cMotBlo == GetNewPar("MV_YBLQFPR","024")
						RecLock("BA3",.F.) //Gedilson
						BA3->BA3_YTPPAG := BA3->BA3_TIPPAG //Guardo o tipo de pagamento da familia bloqueada.
						BA3->BA3_TIPPAG := "00" //Altera tipo de pagto da familia - Sem Envio de cobrança
						BA3->(MsUnlock()) //Gedilson
					Endif
					
					//Leonardo Portella - 22/03/13
					//PL260BLOCO("BA3",BA3->(RecNo()),4,.T.,cMotBlo,dDataBloqueio,BG1->BG1_BLOFAT)
					BloqFamUsr("BA3",BA3->(RecNo()),4,.T.,cMotBlo,dDataBloqueio,BG1->BG1_BLOFAT)
				Else
					RecLock("BA3",.F.)
					BA3->BA3_YSITBQ := "1" //MARCADO PARA BLOQUEIO    
					cMatMarq := (BA3->ba3_codemp+BA3->ba3_matric+";")
					BA3->(MsUnlock())
					cAcao := "FAMILIA MARCADA!"
				EndIf
				aadd(aUsrBlo,{BA3->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC),cAcao,cMotBlo,DtoC(dDataBloqueio)})
				nQtdLin := nQtdLin + 1
				If Len(aPosFin) > 0
					AlimCarta(BA3->BA3_CODCLI, BA3->BA3_LOJA, @aBlqFin, aPosFin)
				Endif
			Endif
			If Mv_Par20 == 3
				Aadd( aLog, { "BA1", BA1->( Recno() ) } )
			Endif
		Endif
	Endif
	
	cAlias->(DbSkip())
	//BA3->(DbSkip())
	lBloqFam := .F.
Enddo   

cAlias->(DbCloseArea())

//Leonardo Portella - 22/03/13 - Fim - Melhoria de performance. Ao inves de varrer toda a BA3, seleciono os R_e_c_n_o_ via SQL e ponteiro nela.

cMatMarq := (BA3->ba3_codemp+BA3->ba3_matric+";")
MemoWrit("\marcela\BORD.TXT", cMatMarq)

cMatMarq := (BA3->ba3_codemp+BA3->ba3_matric+";")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totaliza rel                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd( aLog, " ")
Aadd( aLog, " ")
Aadd( aLog, "Quantidade ===========>      " + StrZero(nQtdLin,6))
Aadd( aLog, " ")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza dados em disco...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA3->( DbCommitAll())
BA3->( dbClearFilter() )
BA3->( dbGoto(nRecBA3) )

BA1->( DbCommitAll())
BA1->( dbGoto(nRecBA1) )

BE7->( DbCommitAll())

RestArea(aAreaSA1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza dados em disco...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aUsrBlo) > 0
	PLSCRIGEN(aUsrBlo,{ {"Matric. Usuario","@C",50},{"Nome do Usuario","@C",100},{"Mot.Bx.","@C",10},{"Dat.Bloq.","@C",15} },"Usuários Bloqueados",.T.)
Endif
aUsrBlo := {}

If Mv_Par20 == 1		// Apenas avaliacao
	Pergunte(cPerg, .F.)
	
	wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
	
	If (nLastKey <> 27)
		SetDefault(aReturn,cString)
	Endif
	
	RptStatus( {|lEnd| ImpLog(@lEnd,wnRel,cString,nomeprog,Titulo,aLog) }, Titulo)
Endif

If Mv_Par20 == 3		// Executa o rdmake de emissao do relatorio especifico
	If FindFunction("U_PL770REL")
		U_PL770REL( aLog )
	Endif
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Emite carta de bloqueio...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//200 If mv_par20 == 2  .And. __cNivBlq == '2'
//200	U_INADIMP(aBlqFin)
//200 Endif

Return(.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PLSAVERNIV  ³ Autor ³ Padua             ³ Data ³ 02.09.2002 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Esta funcao ira tratar o nivel de cobranca do usuario      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCodInt - Codigo da Instituicao                            ³±±
±±³          ³ cCodEmp - Codigo da Empresa                                ³±±
±±³          ³ cMat    - Matricula do Usuarios                            ³±±
±±³          ³ cTipCon - F = Fisica, J = Juridica                         ³±±
±±³          ³ cNumCon - Numero do Contrato                               ³±±
±±³          ³ cVerCon - Versao do Contrato                               ³±±
±±³          ³ cSubCon - Sub Contrato                                     ³±±
±±³          ³ cVerSub - Versao do Sub-Contrato                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ aRet[01] - Codigo do Cliente                               ³±±
±±³          ³ aRet[02] - Loja do Cliente                                 ³±±
±±³          ³ aRet[03] - Nome do Cliente                                 ³±±
±±³          ³ aRet[04] - Endereco 										  ³±±
±±³          ³ aRet[05] - Municipio 		    						  ³±±
±±³          ³ aRet[06] - Estado    			    					  ³±±
±±³          ³ aRet[07] - Natureza 										  ³±±
±±³          ³ aRet[08] - Bairro 										  ³±±
±±³          ³ aRet[09] - Estado 										  ³±±
±±³          ³ aRet[10] - CEP 						    				  ³±±
±±³          ³ aRet[11] - Telefone 										  ³±±
±±³          ³ aRet[12] - CGC 							    			  ³±±
±±³          ³ aRet[13] - Inscricao Estadual  				    		  ³±±
±±³          ³ aRet[14] - Tipo da Cobranca (2 - Aberta,1 - Fechada)		  ³±±
±±³          ³ aRet[15] - Tipo da Empresa  (1 - Fisica,2 - Juridica)	  ³±±
±±³          ³ aRet[16] - Dia do Vencimento                            	  ³±±
±±³          ³ aRet[17] - Tipo (1 - Cliente, 2 - Fornecedor)           	  ³±±
±±³          ³ aRet[18] - Nivel(6/Operadora(Intercambio)5Usuario/4Familia ³±±
±±³          ³                  /3SubCon/2Contr/1Empresa)                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

/*/
User Function PLS770NIV(cCodInt,cCodEmp,cMat,cTipCon,cNumCon,cVerCon,cSubCon,cVerSub,_nTipFam,lHelp)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Locais...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cSql := ""
Local aCliFor := {{	"ZZZZZZ",	"ZZ","","",	"",	"",	"",	"",	"",	"",	"",	"",	"",	" ",;
" ", 0, "1", 	"1", " "}}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define se e uma cobranca que vai ate o nivel de usuario...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFAULT  lHelp    := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz as Verificacoes de Niveis de acordo com o tipo de contrato...   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if cTipCon $ "F,1"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso a cobranca esteja no nivel da Familia...                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BA3->BA3_COBNIV == "1"  .And. (!Empty(BA3->BA3_CODCLI) .OR. !Empty(BA3->BA3_CODFOR)) // Familia
		if !Empty(BA3->BA3_CODCLI)
			aCliFor := PLSAPGEND(BA3->BA3_CODCLI,BA3->BA3_LOJA,"2",BG9->BG9_TIPO,BA3->BA3_VENCTO,"4")
		Else
			aCliFor := PLSARCEND(BA3->BA3_CODFOR,BA3->BA3_LOJFOR,"2",BG9->BG9_TIPO,BA3->BA3_VENCTO,"4")
		Endif
	Else
		If lHelp
			//Help("",1,"PLSVNPFI")
		Endif
		Return(aCliFor)
	Endif
	
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso a cobranca esteja no nivel da Familia...                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BA3->BA3_COBNIV == "1"  .And. (!Empty(BA3->BA3_CODCLI) .Or. !Empty(BA3->BA3_CODFOR)) // Familia
		if !Empty(BA3->BA3_CODCLI)
			aCliFor := PLSAPGEND(BA3->BA3_CODCLI,BA3->BA3_LOJA,"1",BG9->BG9_TIPO,BA3->BA3_VENCTO,"4",BQC->BQC_GRATUI)
		Else
			aCliFor := PLSARCEND(BA3->BA3_CODFOR,BA3->BA3_LOJFOR,"1",BG9->BG9_TIPO,BA3->BA3_VENCTO,"4",BQC->BQC_GRATUI)
		Endif
	Elseif BQC->BQC_COBNIV == "1"  .And. (!Empty(BQC->BQC_CODCLI) .OR. !Empty(BQC->BQC_CODFOR)) //Sub-Conbtrato
		if !Empty(BQC->BQC_CODCLI)
			aCliFor := PLSAPGEND(BQC->BQC_CODCLI,BQC->BQC_LOJA,BQC->BQC_COBTIP,BG9->BG9_TIPO,BQC->BQC_VENCTO,"3",BQC->BQC_GRATUI)
		Else
			aCliFor := PLSARCEND(BQC->BQC_CODFOR,BQC->BQC_LOJFOR,BQC->BQC_COBTIP,BG9->BG9_TIPO,BQC->BQC_VENCTO,"3",BQC->BQC_GRATUI)
		Endif
	Elseif BT5->BT5_COBNIV == "1" .And. (!Empty(BT5->BT5_CODCLI) .Or. !Empty(BT5->BT5_CODFOR)) //Contrato
		if !Empty(BT5->BT5_CODCLI)
			aCliFor := PLSAPGEND(BT5->BT5_CODCLI,BT5->BT5_LOJA,BT5->BT5_COBTIP,BG9->BG9_TIPO,BT5->BT5_VENCTO,"2",BQC->BQC_GRATUI)
		Else
			aCliFor := PLSARCEND(BT5->BT5_CODFOR,BT5->BT5_LOJFOR,BT5->BT5_COBTIP,BG9->BG9_TIPO,BT5->BT5_VENCTO,"2",BQC->BQC_GRATUI)
		Endif
	Elseif (!Empty(BG9->BG9_CODCLI) .Or. !Empty(BG9->BG9_CODFOR))   //Empresa
		if !Empty(BG9->BG9_CODCLI)
			aCliFor := PLSAPGEND(BG9->BG9_CODCLI,BG9->BG9_LOJA,BG9->BG9_COBTIP,BG9->BG9_TIPO,BG9->BG9_VENCTO,"1",BQC->BQC_GRATUI)
		Else
			aCliFor := PLSARCEND(BG9->BG9_CODFOR,BG9->BG9_LOJA,BG9->BG9_COBTIP,BG9->BG9_TIPO,BG9->BG9_VENCTO,"1",BQC->BQC_GRATUI)
		Endif
	Endif
Endif

Return(aCliFor)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaSX1   ºAutor  ³Armando M. Tessaroliº Data ³  09/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Manutencao das perguntas do arquivo SX1.                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PLS                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaSX1(tipo)

Local aRegs	:=	{}
Local cPerg	:=" "
if tipo=="L"
	cPerg	:=	"BLOLIM"     //tela de bloqueio por data Limite
	Aadd(aRegs, { cPerg,"01","Operadora De ?","?De operadora ?","From operator ?","mv_ch1","C",04,0,0,"G","",                     "mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS","","",""})
	Aadd(aRegs, { cPerg,"02","Operadora Ate ?","?A operadora ?","To operator ?","mv_ch2","C",04,0,0,"G","",                     "mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS","","",""})
	Aadd(aRegs, { cPerg,"03","Grupo/Empresa De ?","?De Grupo / Empresa ?","From Group/Company ?","mv_ch3","C",04,0,0,"G","",                     "mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","BJLPLS","","",""})
	Aadd(aRegs, { cPerg,"04","Grupo/Empresa Ate ?","?A Grupo/Empresa Ate ?","To Group/Company ?","mv_ch4","C",04,0,0,"G","",                     "mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","BJLPLS","","",""})
	Aadd(aRegs, { cPerg,"05","Matricula De ?","?De Matricula ?","From registration ?","mv_ch5","C",06,0,0,"G","",                     "mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","B92PLS","","",""})
	Aadd(aRegs, { cPerg,"06","Matricula Ate ?","?A Matricula ?","To registration ?","mv_ch6","C",06,0,0,"G","",                     "mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","B92PLS","","",""})
	Aadd(aRegs, { cPerg,"07","Mot Bloq Limite ?","?Mot.bloq.limite ?","Reason for block. limit ?","mv_ch7","C",03,0,0,"G","",                     "mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","BAEPLS","","",""})
	Aadd(aRegs, { cPerg,"08","Data Ini Limite ?","?De fecha ","From date ?","mv_ch8","D",08,0,0,"G","",                     "mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"09","Data Fim Limite ?","?A fecha ","To date ?","mv_ch9","D",08,0,0,"G","",                     "mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"10","Data Bloqueio ?","?Fecha de bloqueo ?","Blocking date ?","mv_cha","D",08,0,0,"G","",                     "mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"11","Ação do Programa ?","?Accion del Proceso ?","Lawsuit measure ?","mv_chb","N",01,0,1,"C","",                     "mv_par11","Analisa","","","","","Bloqueia","","","","","Relatório","","","","","","","","","","","","","","","","",""})
Elseif tipo=="F"    //tela de bloqueio financeiro
	cPerg	:="BLOFIN"
	Aadd(aRegs, { cPerg,"01","Operadora De ?","?De operadora ?","From operator ?","mv_ch1","C",04,0,0,"G","",                     "mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS","","",""})
	Aadd(aRegs, { cPerg,"02","Operadora Ate ?","?A operadora ?","To operator ?","mv_ch2","C",04,0,0,"G","",                     "mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS","","",""})
	Aadd(aRegs, { cPerg,"03","Grupo/Empresa De ?","?De Grupo / Empresa ?","From Group/Company ?","mv_ch3","C",04,0,0,"G","",                     "mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","BJLPLS","","",""})
	Aadd(aRegs, { cPerg,"04","Grupo/Empresa Ate ?","?A Grupo/Empresa Ate ?","To Group/Company ?","mv_ch4","C",04,0,0,"G","",                     "mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","BJLPLS","","",""})
	Aadd(aRegs, { cPerg,"05","Matricula De ?","?De Matricula ?","From registration ?","mv_ch5","C",06,0,0,"G","",                     "mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","B92PLS","","",""})
	Aadd(aRegs, { cPerg,"06","Matricula Ate ?","?A Matricula ?","To registration ?","mv_ch6","C",06,0,0,"G","",                     "mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","B92PLS","","",""})
	Aadd(aRegs, { cPerg,"07","Data Ref Financeiro ?","?Fecha ref. financiero ?","Financials reference date ?","mv_ch7","D",08,0,0,"G","",                     "mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	// Aadd(aRegs, { cPerg,"08","Mot Bloq Financeiro ?","?Mot.Bloq.financiero ?","Reason for block. financials ?","mv_ch8","C",03,0,0,"G","",                     "mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","BAEPLS","","",""})
	// Aadd(aRegs, { cPerg,"09","Data Bloqueio ?","?Fecha de bloqueo ?","Blocking date ?","mv_ch9","D",08,0,0,"G","",                     "mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"08","Ação do Programa ?","?Accion del Proceso ?","Lawsuit measure ?","mv_ch8","N",01,0,1,"C","",                     "mv_par08","Analisa","","","","","Marca","","","","","Relatório","","","","","","","","","","","","","","","","",""})
ELSE //tela de bloqueio geral
	cPerg	:="PLA770"
	Aadd(aRegs, { cPerg,"01","Operadora De        ","?De operadora ?","From operator ?","mv_ch1","C",04,0,0,"G","",                     "mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS","","",""})
	Aadd(aRegs, { cPerg,"02","Operadora Ate       ","?A operadora ?","To operator ?","mv_ch2","C",04,0,0,"G","",                     "mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","B89PLS","","",""})
	Aadd(aRegs, { cPerg,"03","Grupo/Empresa De    ","?De Grupo / Empresa ?","From Group/Company ?","mv_ch3","C",04,0,0,"G","",                     "mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","BJLPLS","","",""})
	Aadd(aRegs, { cPerg,"04","Grupo/Empresa Ate   ","?A Grupo/Empresa Ate ?","To Group/Company ?","mv_ch4","C",04,0,0,"G","",                     "mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","BJLPLS","","",""})
	Aadd(aRegs, { cPerg,"05","Matricula De        ","?De Matricula ?","From registration ?","mv_ch5","C",06,0,0,"G","",                     "mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","B92PLS","","",""})
	Aadd(aRegs, { cPerg,"06","Matricula Ate       ","?A Matricula ?","To registration ?","mv_ch6","C",06,0,0,"G","",                     "mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","B92PLS","","",""})
	Aadd(aRegs, { cPerg,"07","Bloqueia financeiro ","?Bloquea financiero ?","Block financials ?","mv_ch7","N",01,0,0,"C","",                     "mv_par07","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"08","Data ref. financeiro","?Fecha ref. financiero ?","Financials reference date ?","mv_ch8","D",08,0,0,"G","",                     "mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"09","Mot. bloq.financeiro","?Mot.Bloq.financiero ?","Reason for block. financials ?","mv_ch9","C",03,0,0,"G","",                     "mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","BAEPLS","","",""})
	Aadd(aRegs, { cPerg,"10","Consid. Data Limite ","?Consid.fecha limite ?","Consider deadline ?","mv_cha","N",01,0,0,"C","",                     "mv_par10","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"11","Mot. bloq. Limite   ","?Mot.bloq.limite ?","Reason for block. limit ?","mv_chb","C",03,0,0,"G","",                     "mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","BAEPLS","","",""})
	Aadd(aRegs, { cPerg,"12","Bloq.por Maioridade ","?Bloq. por mayoria de edad ?","Lock due to Majority ?","mv_chc","N",01,0,0,"C","",                     "mv_par12","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"13","Mot. bloq. Maiori   ","?Mot. Bloq.Mayoria de Edad ?","Reason for Lck.Majority ?","mv_chd","C",03,0,0,"G","",                     "mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","BAE","","",""})
	Aadd(aRegs, { cPerg,"14","Parentesco Consider ","?Parentesco Consider. ?","Kinship considered ?","mv_che","C",20,0,0,"G","PL770F3GRP(@cA770ret)","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"15","<Idade Maioridade>  ","?Edad ?","Age ?","mv_chf","N",02,0,0,"G","",                     "mv_par15","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"16","<Idade Universit.>  ","?Edad Universitaria ?","Universit. age ?","mv_chg","N",02,0,0,"G","",                     "mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"17","Data Ini, Lim/Maior ","?De fecha ?","From date ?","mv_chh","D",08,0,0,"G","",                     "mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"18","Data Fim, Lim/Maior ","?A fecha ?","To date ?","mv_chi","D",08,0,0,"G","",                     "mv_par18","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"19","<Data Bloq. Geral>  ","?Fecha de bloqueo ?","Blocking date ?","mv_chj","D",08,0,0,"G","",                     "mv_par19","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	Aadd(aRegs, { cPerg,"20","Ação do Programa    ","?Accion del Proceso ?","Lawsuit measure ?","mv_chk","N",01,0,1,"C","",                     "mv_par20","Analisa","","","","","Bloqueia","","","","","Relatório","","","","","","","","","","","","","","","","",""})
endif
PlsVldPerg( aRegs )

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL770F3GRPºAutor  ³Geraldo Felix Juniorº Data ³  05/24/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina F3 com markbrowse para selecionar os tipo de depend.º±±
±±º          ³ que serao considerados no bloq. por maioridade.            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PL770F3GRP(cString)
Local aDados 	:= {}
Local nCnt
Local oDlgMar
Local oDados
Local bOk		:= {|| nOpca := 1, oDlgMar:End() }
Local bCancel	:= {|| nOpca := 2, oDlgMar:End() }
Local nOpca		:= 0
Default cString := ''

BRP->( dbSetorder(01) )
BRP->( dbSeek(xFilial("BRP")) )
BRP->( dbEval({|| Aadd(aDados, {.F., BRP_CODIGO, BRP_DESCRI, BRP_SEXO})},,;
{|| BRP_FILIAL == xFilial("BRP")}) )

DEFINE MSDIALOG oDlgMar TITLE "Grau de Parentesco" FROM 018,005 TO 28, 100

oDados := TcBrowse():New( 013, 002, 372, 062,,,, oDlgMar,,,,,,,,,,,, .F.,, .T.,, .F., )
ADD COLUMN TO oDados BITMAP DATA IF(!aDados[oDados:nAt,1],LoadBitmap( GetResources(), "LBNO" ),;
LoadBitmap( GetResources(), "LBOK" )) TITLE "" WIDTH 015 NOHILITE

oDados:AddColumn(TcColumn():New("Grau Parentesto",nil,;
nil,nil,nil,nil,075,.F.,.F.,nil,nil,nil,.F.,nil))
oDados:ACOLUMNS[2]:BDATA     := {|| aDados[oDados:nAt,2] }

oDados:AddColumn(TcColumn():New("Descricao",nil,;
nil,nil,nil,nil,115,.F.,.F.,nil,nil,nil,.F.,nil))
oDados:ACOLUMNS[3]:BDATA     := {|| aDados[oDados:nAt,3] }

oDados:AddColumn(TcColumn():New("Sexo",nil,;
nil,nil,nil,nil,050,.F.,.F.,nil,nil,nil,.F.,nil))
oDados:ACOLUMNS[4]:BDATA     := {|| X3COMBO("BRP_SEXO",aDados[oDados:nAt,4]) }

oDados:BLDBLCLICK := {|| (aDados[oDados:nAt][1] := Iif(aDados[oDados:nAt][1], .F., .T.),;
oDados:SetArray(aDados),;
oDados:Refresh()) }
oDados:SetArray(aDados)
oDados:Refresh()

ACTIVATE MSDIALOG oDlgMar ON INIT Eval({||EnChoiceBar(oDlgMar,{||Eval(bOk)},{||Eval(bCancel)},.F.)} )

If nOpca == K_OK
	For nCnt := 1 To Len(aDados)
		If aDados[nCnt][1]
			cString += Alltrim(aDados[nCnt][2])+','
		Endif
	Next
	cString := Substr(cString, 1, (Len(Alltrim(cString))-1))
Endif

MV_PAR14 := cString
lRefresh := .T.

Return( cString)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MaioridadeºAutor  ³Armando M. Tessaroliº Data ³  09/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a idade limite de maioridade definida nos niveis dosº±±
±±º          ³sub-contratos, contratos e grupo/empresa, obedecebdo esta orº±±
±±º          ³dem de avaliacao.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PLS                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Maioridade()

// SubContrato
If BQC->( FieldPos("BQC_MAIORI") ) > 0
	BQC->( DbSetOrder(1) )		// BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB
	BQC->( MsSeek(xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)) )
	If BQC->BQC_MAIORI <> 0		// Zero
		Return(BQC->BQC_MAIORI)
	Endif
Endif

// Contrato
If BT5->( FieldPos("BT5_MAIORI") ) > 0
	BT5->( DbSetOrder(1) )		// BT5_FILIAL + BT5_CODINT + BT5_CODIGO + BT5_NUMCON + BT5_VERSAO
	BT5->( MsSeek(xFilial("BT5")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON)) )
	If BT5->BT5_MAIORI <> 0		// Zero
		Return(BT5->BT5_MAIORI)
	Endif
Endif

// Grupo/Empresa
If BG9->( FieldPos("BG9_MAIORI") ) > 0
	BG9->( DbSetOrder(1) )		// BG9_FILIAL + BG9_CODINT + BG9_CODIGO + BG9_TIPO
	BG9->( MsSeek(xFilial("BG9")+BA1->(BA1_CODINT+BA1_CODEMP)) )
	If BG9->BG9_MAIORI <> 0		// Zero
		Return(BG9->BG9_MAIORI)
	Endif
Endif

Return(0)		// Zero


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpLog    ºAutor  ³Armando M. Tessaroliº Data ³  10/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que ira imprimir o arquivo de LOG.                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Unimed CI.                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpLog(lEnd,wnrel,cString,nomeprog,Titulo,aLog)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao Do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nLi		:= 0			// Linha a ser impressa
Local nMax		:= 58			// Maximo de linhas suportada pelo relatorio
Local cbCont	:= 0			// Numero de Registros Processados
Local cbText	:= SPACE(10)	// Mensagem do Rodape
Local cCabec1	:= "" 			// Label dos itens
Local cCabec2	:= "" 			// Label dos itens

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de variaveis especificas para este relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nI		:= 0			// Controle de laco

cCabec1 := "Relatório de análise do bloqueio de família e usuário"

SetRegua( Len(aLog) )

For nI := 1 To Len(aLog)
	
	IncRegua()
	
	If lEnd
		@Prow()+1,000 PSay "CANCELADO PELO OPERADOR..."
		Exit
	Endif
	
	IncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000 PSay aLog[nI]
	
Next nI

If nLi == 0
	IncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi+1,000 PSay "Não há informações para imprimir este relatório"
Endif

Roda(cbCont,cbText,Tamanho)

Set Device To Screen
If ( aReturn[5] = 1 )
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IncLine   ºAutor  ³Armando M. Tessaroliº Data ³  06/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Incrementa o contador de linhas para impressão nos relatoº±±
±±º          ³rios e verifica se uma nova pagina sera iniciada.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ nLi      - Numero da linha em que sera impresso            º±±
±±º          ³ nInc     - Quantidade de linhas a serem incrementadas      º±±
±±º          ³ nMax     - Numero maximo de linhas por pagina              º±±
±±º          ³ Titulo   - Titulo do cabecalho do relatorio                º±±
±±º          ³ cCabec1  - Primeira linha do lalbel do relatorio           º±±
±±º          ³ cCabec2  - Segunda linha do label do relatorio             º±±
±±º          ³ NomeProg - Nome do programa que sera impresso no cabecalho º±±
±±º          ³ Tamanho  - Tamanho de colunas do relatorio                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function IncLine(	nLi,		nInc,		nMax,		Titulo,;
cCabec1,	cCabec2,	NomeProg,	Tamanho)

Local nChrComp	:= IIF(aReturn[4]==1,15,18)		// Define se o caracter sera comprimido ou normal

nLi+=nInc
If nLi > nMax .or. nLi < 5
	nLi := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,nChrComp)
	nLi++
Endif

Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AlimCarta ºAutor  ³Microsiga           º Data ³  27/02/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AlimCarta(cCodCli, cLoja, aCarta, aPosFin)
/*
====================================================================
Layout Matriz aCarta (Dimensoes) (emissao da carta de inadimplentes)
--------------------------------------------------------------------
1-Nome Cliente
2-Logradouro + Numero + Complemento
3-Bairro
4-Cidade
5-Estado
6-Cep
7-Valor devido
8-Data limite para comparecimento
====================================================================
*/
Local aAreaSA1	:= SA1->(GetArea())
Local aAreaSE1	:= SE1->(GetArea())
Local nVlrDeb	:= 0

If SA1->(MsSeek(xFilial("SA1")+cCodCli+cLoja))
	
// mbc	If !aPosFin[1]
	If Len(aPosFin) > 0
		// mbc If Alltrim(aPosFin[2,1,1]) == "004"
			nVlrDeb := Val(Transform( aPosFin[3] ,"999,999.99"))
			aadd(aCarta,{SA1->A1_NOME, SA1->A1_END, SA1->A1_BAIRRO, SA1->A1_MUN, SA1->A1_EST, SA1->A1_CEP, nVlrDeb,(dDataBloqueio+60)})
		// mbc Endif
	Endif
	
Endif

RestArea(aAreaSA1)
RestArea(aAreaSE1)

Return .T.

Static Function VerTitAb( c_CodEmp, c_Matric, dRefFin)

Local c_Qry 	:= ""  
Local c_Alias	:= GetNextAlias()  
Local a_Ret		:= {}       

c_Qry += " SELECT min(E1_VENCREA) VENCIMENTO, count(*) QUANTIDADE, SUM(E1_SALDO) SALDO "
c_Qry += " FROM " + RETSQLNAME("SE1") + " E1 "
c_Qry += " WHERE E1_FILIAL = '" + xFilial("SE1") + "' "
c_Qry += "       AND E1_CODINT = '0001' "
c_Qry += "       AND E1_CODEMP = '" + c_CodEmp + "' "
c_Qry += "       AND E1_MATRIC = '" + c_Matric + "' "
c_Qry += "       AND TRIM(E1_TIPO) <> 'PR' "
c_Qry += "       AND E1_SALDO > 0 "        
c_Qry += "       AND D_E_L_E_T_ = ' ' "


If TcCanOpen(c_Alias)
	TcDelFile(c_Alias)
Endif

//c_Qry := ChangeQuery(c_Qry)
If Select(c_Alias) <> 0 ; (c_Alias)->(DbCloseArea()) ; Endif
DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),c_Alias,.T.,.T.)    

If !(c_Alias)->( EOF() ) .AND. dRefFin - STOD( (c_Alias)->VENCIMENTO )  >= 60  

	a_Ret := {STOD( (c_Alias)->VENCIMENTO ), (c_Alias)->QUANTIDADE, (c_Alias)->SALDO  , dRefFin - STOD( (c_Alias)->VENCIMENTO )  }

EndIf 

(c_Alias)->(dbCloseArea())

Return a_Ret

**************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 22/03/13                                                                     ³
//³Rotina que chama a PL260BLOCO para bloquear familia e usuario. A funcao padrao PL260BLOCO ja     ³
//³estava neste programa. Criei esta funcao para verificar se a familia ja estava bloqueada, pois a ³
//³PL260BLOCO tambem funciona para desbloquear, que nao e a finalidade desta rotina, exceto quando  ³
//³for motivo de viagem ao exterior, quando deve ser desbloqueado e bloqueado com o motivo definiti-³
//³vo.                                                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function BloqFamUsr(cAliasTab,nReg,nOpc,lDireto,cMotivo,dData,cBloFat)
      
Local aArea := GetArea()

If cAliasTab == 'BA3'
	
	BA3->(DbGoTo(nReg))
	
	If ( BA3->BA3_MOTBLO == '028' )//Bloqueio por viagem ao exterior
		//Rotina padrao no PLSA260 que bloqueia familia e usuario incluindo seus historicos na BCA e BC3
		//Caso o beneficiario esteja bloqueado por viagem ao exterior a rotina ira desbloquear
		PL260BLOCO(cAliasTab,nReg,nOpc,lDireto,'029'/*029 Motivo: Retorno do exterior - Combinado com Ana Paula em 09/04/13*/,dData,cBloFat)
	EndIf
	
	If empty(BA3->BA3_MOTBLO)
		//Caso o beneficiario esteja bloqueado por viagem ao exterior a rotina ira bloquear com o motivo certo. 
		//Rotina padrao no PLSA260 que bloqueia familia e usuario incluindo seus historicos na BCA e BC3
	 	PL260BLOCO(cAliasTab,nReg,nOpc,lDireto,cMotivo,dData,cBloFat)
	EndIf
	
EndIf

RestArea(aArea)

Return