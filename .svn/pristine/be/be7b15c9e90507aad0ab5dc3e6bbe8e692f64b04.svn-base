#INCLUDE "rwmake.ch"
#Include "Protheus.ch"
#Include "TopConn.ch"
//#DEFINE cEnt	Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR128  º Autor ³ Vitor Sbano        º Data ³  21/08/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório Demonstrativo de Titulos a Receber               º±±
±±º          ³ - Apoio Analise Contabilizacao                             º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ - SIGACTB  - Relatoriso                             º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±º Atualiz  ³ 11/09/13 - Vitor Sbano                                     º±±
±±º          ³ - Inclusao de  Identificador de Provisao Ctb (E1_LAPRO)    º±±
±±º          ³ e cancelamento de Lote Pagamento                           º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±º          ³ 17/09/13 - Vitor Sbano                                     º±±
±±º          ³ - Inclusao de Opcao de Impressao de Relatorio para Titulos º±±
±±º          ³ de Cobranca cancelador (Lote Cobranca Cancelado)           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±

±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//
//
//
//
User Function CABR128

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relatório de Suporte Contabilizacao - Receita- Versao 2013.09.17"
Local cPict          := ""
//Local Cabec1       := "                DADOS TITULOS                                                                                             TIP  PLANO                        LAN  PLANO         "
//Local Cabec2     :=  "EMISSAO    FIL  PREF NUMERO    PAR TIPO CLIENTE                        EMISSAO     VENCTO       ORIGEM        VALOR       CON  COD  DESCRICAO               D/C  COD  DESCRICAO                         VALOR"

Local Cabec1         := "                DADOS TITULOS                                                                                          PR  LT    TIP  PLANO                        LAN  PLANO         "
Local Cabec2         := "EMISSAO    FIL  PREF NUMERO    PAR TIPO CLIENTE                        EMISSAO     VENCTO       ORIGEM        VALOR    REC CAN   CON  COD  DESCRICAO               D/C  COD  DESCRICAO                         VALOR"


Local imprime        := .T.
Local aOrd           := {}
Local cPerg          := "CABR128E"
Local nLinn          := 220
//
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private titulo       := "CABERJ - Relatorio de Apoio Contabilizacao - Receita - Titulos Receber (PLS)"
Private nomeprog     := "CABR128" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR128" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString      := "SE1"
Private cAliasQry    := GetNextAlias()
Private cQuery       := ""
Private cAliasQ1     := GetNextAlias()
Private cQuery1      := ""
Private cAliasQ2     := GetNextAlias()
Private cQuery2      := ""
Private aVetExcel    := {}
Private aCabExcel    := {}
Private aGerXls		:= {}		
//
PutSx1( cPerg,"01","Da  Filial ?"               ,"","","mv_ch1","C",02  ,0,0,"G","","SM0","","","MV_PAR01")
PutSx1( cPerg,"02","Ate a Filial ?"             ,"","","mv_ch2","C",02  ,0,0,"G","","SM0","","","MV_PAR02")
PutSx1( cPerg,"03","Da Data Emissao/Canc"       ,"","","mv_ch3","D",08  ,0,0,"G","","   ","","","MV_PAR03")
PutSx1( cPerg,"04","Ate Data Emissao/Canc"      ,"","","mv_ch4","D",08  ,0,0,"G","","   ","","","MV_PAR04")
PutSx1( cPerg,"05","Do Cliente?"                ,"","","mv_ch5","C",06  ,0,0,"G","","SA1","","","MV_PAR05")
PutSx1( cPerg,"06","Ate Cliente"                ,"","","mv_ch6","C",06  ,0,0,"G","","SA1","","","MV_PAR06")
PutSx1( cPerg,"07","Do Tipo Titulo?"            ,"","","mv_ch7","C",3   ,0,0,"G","","05" ,"","","MV_PAR07")
PutSx1( cPerg,"08","Ate o Tipo Titulo"          ,"","","mv_ch8","C",3   ,0,0,"G","","05" ,"","","MV_PAR08")
PutSx1( cPerg,"09","Do Prefixo?"                ,"","","mv_ch9","C",3   ,0,0,"G","","   ","","","MV_PAR09")
PutSx1( cPerg,"10","Ate o Prefixo"              ,"","","mv_chA","C",3   ,0,0,"G","","   ","","","MV_PAR10")
Putsx1( cPerg,"11","Detalhar por Tipo Operacao?","","","mv_chB","N",1   ,0,0,"C","","","","","MV_PAR11","1-Sim" ,"","","","2-Não","","")
Putsx1( cPerg,"12","Somente Tit.Lote Cobrança?" ,"","","mv_chC","N",1   ,0,0,"C","","","","","MV_PAR12","1-Sim" ,"","","","2-Não","","")
Putsx1( cPerg,"13","Gerar Planilha Auxiliar?"   ,"","","mv_chD","N",1   ,0,0,"C","","","","","MV_PAR13","1-Sim" ,"","","","2-Não","","")
Putsx1( cPerg,"14","Emissao Titulos Lot.Cobr"   ,"","","mv_chE","N",1   ,0,0,"C","","","","","MV_PAR14","1-Ativos" ,"","","","2-Canc Lt Cobr","","")
//
Pergunte( cPerg , .T. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//       SetPrint(cAlias, cNomeRel, cPerg, cDesc1, cDesc2, cDesc3, cDesc4, lDic, aOrdem, lComp, cClass)
//wnrel := SetPrint(cString,NomeProg,cPerg  ,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
wnrel := SetPrint(cString,NomeProg,cPerg  ,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.F.,.F.)

//
If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//RptStatus({|| R53Report(Cabec1,Cabec2,Titulo,nLinn) },Titulo)
//
If MV_PAR14 = 1 		&& Emissao de Relatorio de Titulos Ativos
	//
	Processa({|lEnd| R53Report(wnRel,Cabec1,Cabec2,nLinn)})
	//
Else   			&& Emissao de Relatorio de Titulos de Lote Cobranca Cancelados
	//
	Processa({|lEnd| R63CReport(wnRel,Cabec1,Cabec2,nLinn)})
	//

Endif
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³R53Report º Autor ³ Vitor Sbano        º Data ³  21/08/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlterações³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R53Report(wnRel,Cabec1,Cabec2,nLinn)

Local nOrdem
Local nCountnx  := 0
Local cContOrc  := ""
Local cDescOrc  := ""
Local aTotCC    := {}
Local _aResPla	:=	{} 
Local _aResEve	:=	{}  
Local _aTitulos	:=	{}

Local _i      	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
 
//
If MV_PAR13 = 1	&& Gerar Planilha - 1 Sim / 2 Nao
	//
	AADD(aGerXls,{"TIPO",;
	"FILIAL",;
	"EMISSAO",;
	"PREFIXO",;
	"NUMERO",;
	"PARCELA",;
	"TIPO",;
	"CLIENTE",;
	"LOJA",;
	"NOME",;
	"EMISSAO",;
	"VENCIMENTO",;
	"ORIGEM",;
	"VALOR_TITULO",;
	"TIPO_CON",;
	"PLANO",;
	"DESC_PLANO",;
	"LANCTO",;
	"COD_PRODUTO",; 
	"DESC_PRODUTO",;
	"VALOR_PRODUTO",;
	"PROV_CTB",;
	"LOTE_CANC",;
	"Competencia",;
	"Cod.Emp"})
	//
Endif
//
//Cabec1         := "                 DADOS TITULOS                                                                                             TIP  PLANO                        LAN  PLANO         "
 //Cabec2         :=  "EMISSAO    FIL  PREF NUMERO    PAR TIPO CLIENTE                        EMISSAO     VENCTO       ORIGEM        VALOR       CON  COD  DESCRICAO               D/C  COD  DESCRICAO                         VALOR"
//
Cabec1         := "                 DADOS TITULOS                                                                                            PRV LOT   TIP  PLANO                        LAN  PLANO         "
Cabec2         :=  "EMISSAO    FIL  PREF NUMERO    PAR TIPO CLIENTE                        EMISSAO     VENCTO       ORIGEM        VALOR      REC CAN   CON  COD  DESCRICAO               D/C  COD  DESCRICAO                         VALOR"
//                 123456789112345678921234567893123456789412345678941234567896123456789112345678921234567893123456789412345678941234567896123456789112345678921234567893123456789412345678941234567896123456789112345678921234567893123456789412345678941234567896
 //                          1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21
//
titulo	:= titulo + " - Periodo: "+dtoc(MV_PAR03)+" a "+dtoc(MV_PAR04)
Private nTotGrlx := 0
//
//
//		01	Da  Filial ?
//		02	Ate a Filial ?
//		03	Da Data Emissao
//		04	Ate a Data Emissao
//		05	Do Cliente?
//		06	Ate Cliente
//		07	Do Tipo Titulo?
//		08	Ate o Tipo Titulo
//		09	Do Prefixo?
//		10	Ate o Prefixo
//		11	Detalhar por Tipo Operacao?
//		//
//
cQuery := " "
cQuery += "SELECT SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, "+CRLF 
cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR, SE1.E1_EMIS1, SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, "+CRLF
cQuery += " SA1.A1_NREDUZ, SE1.E1_HIST, SE1.E1_LAPRO "+CRLF

cQuery += " , E1_ANOBASE , E1_MESBASE  "+CRLF // ALTAMIRO 04/07/2017 

cQuery += " , E1_CODEMP   "+CRLF // ALTAMIRO 13/10/2017

cQuery += " FROM "+RetSqlname("SE1")+" SE1, "+RetSqlname("SA1")+" SA1 "+CRLF
cQuery += " WHERE SE1.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SA1.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF
cQuery += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
cQuery += " AND SE1.E1_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+CRLF
cQuery += " AND SE1.E1_EMIS1 BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF
cQuery += " AND SE1.E1_CLIENTE BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery += " AND SE1.E1_TIPO BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF
cQuery += " AND SE1.E1_PREFIXO BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"' "+CRLF
//
If MV_PAR12 = 1	&& Somente Titulos Lote Cobranca ? 1 Sim / 2 Nao
	//
	cQuery += " AND SE1.E1_ORIGEM = 'PLSA510' "+CRLF
	//
Endif
//
cQuery += " ORDER BY SE1.E1_FILIAL, SE1.E1_EMIS1, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA"+CRLF
//
MemoWrite("C:\Temp1\CABR128.txt",cQuery)
//
If Select(cAliasQry) > 0
	dbSelectArea(cAliasQry)
	dbCloseArea()
EndIf
//cQuery := ChangeQuery(cQuery)// altamiro 14/07/2016
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
//
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Contagem dos arquivos para o "Processa"³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While (cAliasQry)->(!Eof())
	nCountnx ++
	(cAliasQry)->(DbSkip())
EndDo
(cAliasQry)->(DbGoTop())
//
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//
_nTotVlr	:= 	0			&& E1_VALOR - Total por Dia
_nTotGer	:=	0			&& E1_VALOR	- Total Relatorio
//
ProcRegua(nCountnx)
//            
While (cAliasQry)->(!Eof())
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//
	If lAbortPrint
		@nLinn,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	//
	If nLinn > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLinn := 9
	Endif
	//
	_nTotVlr	:= 	0
	_dEMIS1		:=	(cAliasQry)->E1_EMIS1
	_cFILIAL	:=	(cAliasQry)->E1_FILIAL
	_aTitulos	:=	{} 
	//                           20130821
	@nLinn,001 PSAY substr(_dEMIS1,7,2)+"/"+substr(_dEMIS1,5,2)+"/"+substr(_dEMIS1,1,4)
	@nLinn,012 PSAY _cFILIAL 
	//
	Do while !eof() .and. (cAliasQry)->E1_EMIS1 == _dEMIS1 .and.(cAliasQry)->E1_FILIAL == _cFILIAL
		//
		If nLinn > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLinn := 9
			@nLinn,001 PSAY substr(_dEMIS1,7,2)+"/"+substr(_dEMIS1,5,2)+"/"+substr(_dEMIS1,1,4)
			@nLinn,012 PSAY _cFILIAL 
			//
		Endif
		//
		_cPREFIXO	:=	(cAliasQry)->E1_PREFIXO
		_cNUM		:=	(cAliasQry)->E1_NUM
		_cPARCELA	:=	(cAliasQry)->E1_PARCELA
		_cTIPO		:=	(cAliasQry)->E1_TIPO
		_cCLIENTE	:=	(cAliasQry)->E1_CLIENTE
		_cLOJA		:=	(cAliasQry)->E1_LOJA
		_cNOMCLI	:=	(cAliasQry)->E1_NOMCLI
		_cEMISSAO	:=	(cAliasQry)->E1_EMISSAO
		_cVENCREA	:=	(cAliasQry)->E1_VENCREA
		_cORIGEM	:=	(cAliasQry)->E1_ORIGEM
		_nVALOR		:=	(cAliasQry)->E1_VALOR
		_cCOMPT     :=	(cAliasQry)->E1_MESBASE+"/" +(cAliasQry)->E1_ANOBASE 
	    _cCodEmp    :=  (cAliasQry)->E1_codemp 
		_cLAPRO		:=	Iif((cAliasQry)->E1_LAPRO="F","N","S")		&& Provisao Contabil (rotina CABA323) - Provisao Receita
		_cLOTECAN	:= "?"
		_nTotVlr	+= 	_nVALOR
		_nTotGer	+=	_nVALOR
		//
		If MV_PAR13 = 1	&& Gerar Planilha - 1 Sim / 2 Nao
			//
			AADD(aGerXls,{"TITULO",;				&& 		Tipo LInha
							chr(160)+_cFILIAL,;		&&				"FILIAL",;
							_dEMIS1,;				&&				"EMISSAO",;
							chr(160)+_cPREFIXO,;	&&				"PREFIXO",;
							chr(160)+_cNUM,;		&&				"NUMERO",;
							chr(160)+_cPARCELA,;	&&				"PARCELA",;
							chr(160)+_cTIPO,;		&&				"TIPO",;
							chr(160)+_cCLIENTE,;	&&				"CLIENTE",;
							chr(160)+_cLOJA,;		&&				"LOJA",;
							chr(160)+_cNOMCLI,;		&&				"NOME",;
							_cEMISSAO,;				&&				"EMISSAO",;
							_cVENCREA,;				&&				"VENCIMENTO",;
							_cORIGEM,;				&&				"ORIGEM",;
							_nVALOR,;				&&				"VALOR_TITULO",;
							"  ",;					&&				"TIPO_CON",;
							"  ",;					&&				"PLANO",;
							"  ",;					&&				"DESC_PLANO",;
							"  ",;					&&				"LANCTO",;
							"  ",;					&&				"COD_PRODUTO",; 
							"  ",;					&&				"DESC_PRODUTO",;
							"  ",;					&&				"VALOR_PRODUTO"})
							_cLAPRO,;				&&				Provisao Receita (E1_LAPRO
							_cLOTECAN,; 			&&				Cancelado Lote Pagamento
	                        _cCOMPT,;			    &&				Competencia de emissao  
	                        _cCODEMP})			    &&				Cod Empresa         
				//
		Endif
		//				
		@nLinn,017 PSAY _cPREFIXO
		@nLinn,022 PSAY _cNUM
		@nLinn,032 PSAY _cPARCELA
		@nLinn,036 PSAY _cTIPO
		@nLinn,041 PSAY _cCLIENTE+" "+_cLOJA
		@nLinn,051 PSAY substr(_cNOMCLI,1,20)
		@nLinn,072 PSAY substr(_cEMISSAO,7,2)+"/"+substr(_cEMISSAO,5,2)+"/"+substr(_cEMISSAO,1,4)
		@nLinn,084 PSAY substr(_cVENCREA,7,2)+"/"+substr(_cVENCREA,5,2)+"/"+substr(_cVENCREA,1,4)
		@nLinn,096 PSAY _cORIGEM
		@nLinn,104 PSAY transform(_nVALOR,"@E 999,999,999,999.99")
		@nLinn,124 PSAY _cLAPRO 
		@nLinn,128 PSAY _cLOTECAN
		//
		If MV_PAR11 == 1		&& Detalhar Resumo Operacao/Composicao BM1
			//
			cQuery2	:= ""	
			cQuery2 += "SELECT DISTINCT BM1.BM1_CODINT, BM1.BM1_CODTIP , BM1.BM1_DESTIP, BM1.BM1_CODPLA, BM1.BM1_DESPLA, BM1.BM1_TIPO, BI3.BI3_TIPCON, SUM(BM1.BM1_VALOR) BM1_VALOR "+CRLF
			cQuery2 += " , bm1.BM1_ANO , bm1.BM1_MES "+CRLF // ALTAMIRO 04/07/2017    
			
			cQuery2 += " , bm1.BM1_CODEMP  "+CRLF // ALTAMIRO 13/10/2017   
			
			cQuery2 += "FROM "+RetSqlName("BM1")+" BM1, "+RetSqlname("SE1")+" SE1 ,"+RetSqlName("BI3")+" BI3 "+CRLF
			cQuery2 += "where BM1.D_E_L_E_T_= ' ' "+CRLF 
			cQuery2 += "and SE1.D_E_L_E_T_=' ' "+CRLF
			cQuery2 += "and BI3.D_E_L_E_T_=' ' "+CRLF
			cQuery2 += "and BM1.BM1_PREFIX = SE1.E1_PREFIXO "+CRLF
			cQuery2 += "and BM1.BM1_NUMTIT = SE1.E1_NUM "+CRLF
			cQuery2 += "and BM1.BM1_PARCEL = SE1.E1_PARCELA "+CRLF
			cQuery2 += "and BM1.BM1_TIPTIT = SE1.E1_TIPO  "+CRLF  
						                                          
          //  cQuery2 += "and BM1.BM1_CODTIP NOT IN ('149','141','950','139','151','152')  "+CRLF  						
						
			cQuery2 += "and BI3.BI3_CODINT = BM1.BM1_CODINT "+CRLF
			cQuery2 += "and BI3.BI3_CODIGO = BM1.BM1_CODPLA "+CRLF
			cQuery2 += " AND SE1.E1_PREFIXO = '"+_cPREFIXO+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_NUM = '"+_cNUM+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_PARCELA = '"+_cPARCELA+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_TIPO = '"+_cTIPO+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_CLIENTE = '"+_cCLIENTE+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_LOJA = '"+_cLOJA+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_FILIAL = '"+_cFILIAL+"' "+CRLF
			cQuery2 += "GROUP BY BM1.BM1_CODINT, BM1.BM1_CODTIP , BM1.BM1_DESTIP, BM1.BM1_CODPLA, BM1.BM1_DESPLA, BM1.BM1_TIPO, BI3.BI3_TIPCON ,  bm1.BM1_ANO , bm1.BM1_MES , bm1.BM1_CODEMP "+CRLF
			cQuery2 += "ORDER BY  BI3.BI3_TIPCON, BM1.BM1_CODPLA, BM1.BM1_DESPLA,BM1.BM1_CODTIP , BM1.BM1_DESTIP ,  bm1.BM1_ANO , bm1.BM1_MES"+CRLF		
			MemoWrite("C:\Temp1\CABR1282.txt",cQuery2)
			//
			If Select(cAliasQ2) > 0	
				dbSelectArea(cAliasQ2)
				dbCloseArea()
			EndIf
 //			cQuery := ChangeQuery(cQuery2) // altamiro 14/07/2016
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),cAliasQ2,.T.,.T.)
			//
			Do while !eof() 
				//
				If lAbortPrint
					@nLinn,00 PSAY "*** CANCELADO PELO OPERADOR ***"
					Exit
				Endif
				If nLinn > 55
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLinn := 8
					@ nLinn,017 PSAY _cPREFIXO
					@ nLinn,022 PSAY _cNUM
					@ nLinn,032 PSAY _cPARCELA
					@ nLinn,036 PSAY _cTIPO
					@ nLinn,041 PSAY _cCLIENTE+" "+_cLOJA
					@ nLinn,051 PSAY substr(_cNOMCLI,1,20)
					@ nLinn,072 PSAY substr(_cEMISSAO,7,2)+"/"+substr(_cEMISSAO,5,2)+"/"+substr(_cEMISSAO,1,4)
					@ nLinn,084 PSAY substr(_cVENCREA,7,2)+"/"+substr(_cVENCREA,5,2)+"/"+substr(_cVENCREA,1,4)
					@ nLinn,096 PSAY _cORIGEM
					@ nLinn,104 PSAY transform(_nVALOR,"@E 999,999,999,999.99") 
					@ nLinn,124 PSAY _cLAPRO 
					@ nLinn,128 PSAY _cLOTECAN
					nLinn ++
				Endif
				// 
				_cCHVPLA	:= (cAliasQ2)->BI3_TIPCON+(cAliasQ2)->BM1_CODPLA+substr((cAliasQ2)->BM1_DESPLA,1,20)
				_cCHVEVE	:= (cAliasQ2)->BM1_CODTIP+(cAliasQ2)->BM1_DESTIP
				//
				If MV_PAR13 = 1	&& Gerar Planilha - 1 Sim / 2 Nao
					//
					AADD(aGerXls,{"DETALHE",;	 							&& 		Tipo LInha
							chr(160)+_cFILIAL,;								&&				"FILIAL",;
							_dEMIS1,;										&&				"EMISSAO",;
							chr(160)+_cPREFIXO,;							&&				"PREFIXO",;
							chr(160)+_cNUM,;								&&				"NUMERO",;
							chr(160)+_cPARCELA,;							&&				"PARCELA",;
							chr(160)+_cTIPO,;								&&				"TIPO",;
							chr(160)+_cCLIENTE,;							&&				"CLIENTE",;
							chr(160)+_cLOJA,;								&&				"LOJA",;
							chr(160)+_cNOMCLI,;								&&				"NOME",;
							_cEMISSAO,;										&&				"EMISSAO",;
							_cVENCREA,;										&&				"VENCIMENTO",;
							_cORIGEM,;										&&				"ORIGEM",;
							_nVALOR,;										&&				"VALOR_TITULO",;
							(cAliasQ2)->BI3_TIPCON,;						&&				"TIPO_CON",;
							(cAliasQ2)->BM1_CODPLA,;						&&				"PLANO",;
							substr((cAliasQ2)->BM1_DESPLA,1,20),;			&&				"DESC_PLANO",;
							IIf((cAliasQ2)->BM1_TIPO='1','[DEB]','[CRE]'),;		&&				"LANCTO",;
							(cAliasQ2)->BM1_CODTIP,;						&&				"COD_PRODUTO",; 			
							(cAliasQ2)->BM1_DESTIP,;						&&				"DESC_PRODUTO",;
							(cAliasQ2)->BM1_VALOR,;							&&				"VALOR_PRODUTO"})
							_cLAPRO,;										&&				Provisao Receita (E1_LAPRO
							_cLOTECAN,;										&&				Cancelado Lote Pagamento 
							(cAliasQ2)->BM1_MES+'/'+(cAliasQ2)->BM1_ANO  ,; &&		    	Competencia de Emissao  
							(cAliasQ2)->BM1_CODEMP                       }) &&		    	Cod Empresa  							
							
				  
						//
				Endif
				//
				@nLinn,135 PSAY (cAliasQ2)->BI3_TIPCON+" "+(cAliasQ2)->BM1_CODPLA+" "+substr((cAliasQ2)->BM1_DESPLA,1,17)+" "+IIf((cAliasQ2)->BM1_TIPO='1','[DEB]','[CRE]')+" "+(cAliasQ2)->BM1_CODTIP+" "+substr((cAliasQ2)->BM1_DESTIP,1,27)
				@nLinn,205 PSAY transform((cAliasQ2)->BM1_VALOR,"@E 999,999,999.99")                                                                                    
				nLinn ++
				//
				_nPos	:=	aScan(_aResPla,{|x| Alltrim(x[1])==Alltrim(_cCHVPLA)})
				If	_nPos	>	0
					_aResPla[_nPos,5]	+=	(cAliasQ2)->BM1_VALOR
				Else           &&  1        2                      3                      4                                   5                     
					AADD(_aResPla,{_cCHVPLA,(cAliasQ2)->BI3_TIPCON,(cAliasQ2)->BM1_CODPLA,substr((cAliasQ2)->BM1_DESPLA,1,20),(cAliasQ2)->BM1_VALOR})
				Endif
				//			     
				_nPos	:=	aScan(_aResEve,{|x| Alltrim(x[1])==Alltrim(_cCHVEVE)})
				If	_nPos	>	0
					_aResEve[_nPos,4]	+=	(cAliasQ2)->BM1_VALOR
				Else           &&  1        2                      3                      4
					AADD(_aResEve,{_cCHVEVE,(cAliasQ2)->BM1_CODTIP,(cAliasQ2)->BM1_DESTIP,(cAliasQ2)->BM1_VALOR})
				Endif
				//			     
				(cAliasQ2)->(dbSkip())
				//
			EndDo
			//
		Endif	
		nLinn ++
		DbSelectArea(cAliasQry)
		(cAliasQry)->(dbSkip())
		//
	EndDo
	//
	nLinn ++
	@ nLinn,005  psay replicate("-",120)
	nLinn ++
	@ nLinn,001  psay substr(_dEMIS1,7,2)+"/"+substr(_dEMIS1,5,2)+"/"+substr(_dEMIS1,1,4)+"   ....  TOTAL......"
	@ nLinn,104 PSAY transform(_nTotVlr,"@E 999,999,999,999.99") 
	nLinn ++
	//
	nLinn ++
	DbSelectArea(cAliasQry)
//	(cAliasQry)->(dbSkip())
	//
Enddo		
//
If eof()
	//
	nLinn ++
	@ nLinn,005  psay replicate("-",120)
	nLinn ++
	@ nLinn,001  psay "TOTAL GERAL ......"
	@ nLinn,104 PSAY transform(_nTotGer,"@E 999,999,999,999.99") 
	nLinn ++
	nLinn ++
	//
	_nResPla	:= 0
	_nResEve	:= 0
	aSort(_aResPla,,,{|x,y| x[1]<y[1]})
	//
	If nLinn > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLinn := 8
		nLinn ++
	Endif
	//
	@nLinn, 001 PSAY "----------------------------------------------------------------------------------------------------"
	nLinn++
	@nLinn, 001 PSAY "                                 Resumo por Plano"
	nLinn++
	@nLinn, 001 PSAY "----------------------------------------------------------------------------------------------------"
	
	_nTotalRet	:=	0
	
	For	_i	:=	1	To	Len(_aResPla)
		nLinn++
		//
		If nLinn > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLinn := 8
			nLinn ++
		Endif
		//
		@nLinn, 001 PSAY _aResPla[_i,2]+" "+_aResPla[_i,3]+"     "+_aResPla[_i,4]+"    "+transform(_aResPla[_i,5],"@E 999,999,999,999.99")
		_nResPla	+= _aResPla[_i,5]
		//
	Next
	//
	//
	If nLinn > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLinn := 8
		nLinn ++
	Endif
	//
	nLinn ++
	@ nLinn,001  psay replicate("-",120)
	nLinn ++
	@ nLinn,001  psay "TOTAL POR PLANO ......"
	@ nLinn,60 PSAY transform(_nResPla,"@E 999,999,999,999.99") 
	nLinn ++
	@ nLinn,001  psay replicate("-",120)
	//	
	//
	aSort(_aResEve,,,{|x,y| x[1]<y[1]})
	//
	If nLinn > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLinn := 8
		nLinn ++
	Endif
	//
	nLinn++
	nLinn++
	@nLinn, 001 PSAY "----------------------------------------------------------------------------------------------------"
	nLinn++
	@nLinn, 001 PSAY "                                 Resumo por Evento"
	nLinn++
	@nLinn, 001 PSAY "----------------------------------------------------------------------------------------------------"
	
	_nTotalRet	:=	0
	
	For	_i	:=	1	To	Len(_aResEve)
		nLinn++
		//
		If nLinn > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLinn := 8
			nLinn ++
		Endif
		//
		@nLinn, 001 PSAY _aResEve[_i,2]+" "+_aResEve[_i,3]+" "+transform(_aResEve[_i,4],"@E 999,999,999,999.99")
		_nResEve += _aResEve[_i,4]
		//
	Next
	//	
	nLinn ++
	@ nLinn,001  psay replicate("-",120)
	nLinn ++
	@ nLinn,001  psay "TOTAL POR EVENTO ......"
	@ nLinn,60 PSAY transform(_nResEve,"@E 999,999,999,999.99") 
	nLinn ++
	@ nLinn,001  psay replicate("-",120)

	//
Endif
//
If mv_par13 == 1  	&& Gerar Arquivo XLS - Excel
	//
	DlgToExcel({{"ARRAY","","",aGerXls}})
    //
Endif
//
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return  
//
// *******************************************************************************************************************************************
// *******************************************************************************************************************************************
// *******************************************************************************************************************************************
//
//     *****  FIM RELATORIO - TITULOS ATIVOS ******************************8
//
// *******************************************************************************************************************************************
// *******************************************************************************************************************************************
// *******************************************************************************************************************************************
//
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³R63CReport º Autor ³ Vitor Sbano        º Data ³  17/09/13  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±º          ³                                                            º±±
±±º          ³ *** IMPRESSAO DE TITULOS CANCELADOS - LOTE DE COBRANCA     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlterações³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R63CReport(wnRel,Cabec1,Cabec2,nLinn)

Local nOrdem
Local nCountnx := 0
Local cContOrc := ""
Local cDescOrc := ""
Local aTotCC   := {}
Local _aResPla	:=	{} 
Local _aResEve	:=	{}  
Local _aTitulos	:=	{} 

Local _i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

local lCanc :=.F.
//
If MV_PAR13 = 1	&& Gerar Planilha - 1 Sim / 2 Nao
	//
	AADD(aGerXls,{"TIPO",;
	"FILIAL",;
	"EMISSAO",;
	"PREFIXO",;
	"NUMERO",;
	"PARCELA",;
	"TIPO",;
	"CLIENTE",;
	"LOJA",;
	"NOME",;
	"EMISSAO",;
	"VENCIMENTO",;
	"ORIGEM",;
	"VALOR_TITULO",;
	"TIPO_CON",;
	"PLANO",;
	"DESC_PLANO",;
	"LANCTO",;
	"COD_PRODUTO",; 
	"DESC_PRODUTO",;
	"VALOR_PRODUTO",;
	"PROV_CTB",;
	"LOTE_CANC",;
	"COMPETENCIA"})
	//
Endif
//
//Cabec1         := "                 DADOS TITULOS                                                                                             TIP  PLANO                        LAN  PLANO         "
 //Cabec2         :=  "EMISSAO    FIL  PREF NUMERO    PAR TIPO CLIENTE                        EMISSAO     VENCTO       ORIGEM        VALOR       CON  COD  DESCRICAO               D/C  COD  DESCRICAO                         VALOR"
//
Cabec1         := "DATA            DADOS TITULOS                                                                                            PRV LOT   TIP  PLANO                        LAN  PLANO         "
Cabec2         := "CANCEL.    FIL  PREF NUMERO    PAR TIPO CLIENTE                        EMISSAO     VENCTO       ORIGEM        VALOR      REC CAN   CON  COD  DESCRICAO               D/C  COD  DESCRICAO                         VALOR"
//
titulo       := "CABERJ - Apoio Contabilizacao - Cancelamento Receita (Lote Cobranca Cancelado) / Tit. Receber (PLS)"

titulo	:= titulo + " - Periodo: "+dtoc(MV_PAR03)+" a "+dtoc(MV_PAR04)
Private nTotGrlx := 0
//
//
cQuery := " "
//	cQuery += "SELECT SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, "+CRLF 
//	cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR, SE1.E1_EMIS1, SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, "+CRLF
//	cQuery += " SA1.A1_NREDUZ, SE1.E1_HIST, SE1.E1_LAPRO "+CRLF
//	
//cQuery += "SELECT SE5.E5_FILIAL, SE5.E5_DATA, SE5.E5_VALOR, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA, SE5.E5_TIPO, SE5.E5_CLIFOR, SE5.E5_LOJA,"+CRLF
//cQuery += " SE5.E5_HISTOR,SE5.E5_TIPODOC, SE5.E5_MOTBX, SE5.R_E_C_N_O_ SE5RECN,"+CRLF
//cQuery += " SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, SE1.E1_NATUREZ,"+CRLF 
//cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR, SE1.E1_EMIS1, SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, "+CRLF 
//cQuery += " SA1.A1_NREDUZ, SE1.E1_HIST, SE1.R_E_C_N_O_ SE1RECN "+CRLF
//
//
//	PutSx1( cPerg,"01","Da  Filial ?"      		    ,"","","mv_ch1","C",02  ,0,0,"G","","SM0","","","MV_PAR01")
//	PutSx1( cPerg,"02","Ate a Filial ?"      		,"","","mv_ch2","C",02	,0,0,"G","","SM0","","","MV_PAR02")
//	PutSx1( cPerg,"03","Da Data Emissao"            ,"","","mv_ch3","D",08  ,0,0,"G","","   ","","","MV_PAR03")
//	PutSx1( cPerg,"04","Ate a Data Emissao"         ,"","","mv_ch4","D",08 	,0,0,"G","","   ","","","MV_PAR04")
//	PutSx1( cPerg,"05","Do Cliente?"                ,"","","mv_ch5","C",06  ,0,0,"G","","SA1","","","MV_PAR05")
//	PutSx1( cPerg,"06","Ate Cliente"                ,"","","mv_ch6","C",06 	,0,0,"G","","SA1","","","MV_PAR06")
//	PutSx1( cPerg,"07","Do Tipo Titulo?"            ,"","","mv_ch7","C",3   ,0,0,"G","","05" ,"","","MV_PAR07")
//	PutSx1( cPerg,"08","Ate o Tipo Titulo"          ,"","","mv_ch8","C",3 	,0,0,"G","","05" ,"","","MV_PAR08")
//	PutSx1( cPerg,"09","Do Prefixo?"                ,"","","mv_ch9","C",3   ,0,0,"G","","   ","","","MV_PAR09")
//	PutSx1( cPerg,"10","Ate o Prefixo"              ,"","","mv_chA","C",3 	,0,0,"G","","   ","","","MV_PAR10")
//	Putsx1( cPerg,"11","Detalhar por Tipo Operacao?","","","mv_chB","N",1   ,0,0,"C","","","","","MV_PAR11","1-Sim" ,"","","","2-Não","","")
//	Putsx1( cPerg,"12","Somente Tit.Lote Cobrança?" ,"","","mv_chC","N",1   ,0,0,"C","","","","","MV_PAR12","1-Sim" ,"","","","2-Não","","")
//	Putsx1( cPerg,"13","Gerar Planilha Auxiliar?"   ,"","","mv_chD","N",1   ,0,0,"C","","","","","MV_PAR13","1-Sim" ,"","","","2-Não","","")
//	Putsx1( cPerg,"14","Emissao Titulos Lot.Cobr"   ,"","","mv_chE","N",1   ,0,0,"C","","","","","MV_PAR14","1-Ativos" ,"","","","2-Canc Lt Cobr","","")
	
if lCanc

	cQuery += "SELECT SE5.E5_DATA E1_EMIS1, SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, "+CRLF 
	cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR, "+CRLF
	//SE1.E1_EMIS1,
	cQuery += " SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, "+CRLF
	cQuery += " SA1.A1_NREDUZ, SE1.E1_HIST, SE1.E1_LAPRO , SE1.E1_CODEMP "+CRLF   
	cQuery += " , E1_ANOBASE , E1_MESBASE , SE1.E1_CODEMP , SE1.E1_MATRIC ,SE1.E1_PLNUCOB "+CRLF // ALTAMIRO 04/07/2017
	cQuery += " FROM "+RetSqlname("SE5")+" SE5, "+RetSqlname("SE1")+" SE1, "+RetSqlname("SA1")+" SA1 "+CRLF
	cQuery += " WHERE SE5.D_E_L_E_T_=' '"+CRLF 
	cQuery += " AND SE1.D_E_L_E_T_=' '"+CRLF 
	cQuery += " AND SA1.D_E_L_E_T_=' ' "+CRLF
	cQuery += " AND SE5.E5_FILORIG BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+CRLF
	cQuery += " AND SE5.E5_DATA BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF   
	cQuery += " AND SE5.E5_CLIFOR BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF   
	cQuery += " AND SE5.E5_TIPO BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF   
	cQuery += " AND SE5.E5_PREFIXO BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"' "+CRLF   
	cQuery += " AND SE1.E1_FILIAL = SE5.E5_FILORIG"+CRLF
	cQuery += " AND SE1.E1_PREFIXO = SE5.E5_PREFIXO "+CRLF
	cQuery += " AND SE1.E1_NUM = SE5.E5_NUMERO "+CRLF
	cQuery += " AND SE1.E1_PARCELA = SE1.E1_PARCELA "+CRLF
	cQuery += " AND SE1.E1_TIPO = SE5.E5_TIPO "+CRLF
	cQuery += " AND SE1.E1_CLIENTE = SE5.E5_CLIFOR "+CRLF
	cQuery += " AND SE1.E1_LOJA = SE1.E1_LOJA "+CRLF
	cQuery += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF 
	cQuery += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
	cQuery += " AND SE1.E1_FILIAL BETWEEN '  ' AND 'zz' "+CRLF 
	cQuery += " AND SE5.E5_TIPODOC = 'BA' "+CRLF
	cQuery += " AND SE5.E5_MOTBX = 'CAN' "+CRLF
	cQuery += " AND SE5.E5_HISTOR  LIKE '%Titulo cancelado pelo Plano de Saude%' "+CRLF
	///cQuery += " ORDER BY SE1.E1_FILIAL, SE5.E5_DATA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA"+CRLF
	//
	cQuery += "union all "+CRLF
EndIf 

	cQuery += "SELECT SE1.E1_emis1 E1_EMIS1 , SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, "+CRLF 
	cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR," +CRLF
	//SE1.E1_EMIS1,
	cQuery += " SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, "+CRLF
	cQuery += " SA1.A1_NREDUZ, SE1.E1_HIST, SE1.E1_LAPRO , SE1.E1_CODEMP "+CRLF   
	cQuery += " , E1_ANOBASE , E1_MESBASE , SE1.E1_CODEMP , SE1.E1_MATRIC , SE1.E1_PLNUCOB"+CRLF // ALTAMIRO 04/07/2017
	cQuery += " FROM  "+RetSqlname("SE1")+" SE1, "+RetSqlname("SA1")+" SA1 "+CRLF
	cQuery += " WHERE SE1.D_E_L_E_T_='*'"+CRLF 
	cQuery += " AND SA1.D_E_L_E_T_=' ' "+CRLF
	cQuery += " AND SE1.E1_FILial  BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+CRLF
	cQuery += " AND SE1.E1_emissao BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF   
	cQuery += " AND SE1.E1_CLIENTE BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF   
	cQuery += " AND SE1.E1_TIPO BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF   
	cQuery += " AND SE1.E1_PREFIXO BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"' "+CRLF   

	cQuery += " AND SE1.E1_LAPRO = 'T'"+CRLF

	cQuery += " AND SE1.E1_PARCELA = SE1.E1_PARCELA "+CRLF

	cQuery += " AND SE1.E1_LOJA = SE1.E1_LOJA "+CRLF
	cQuery += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF 
	cQuery += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
	cQuery += " AND SE1.E1_FILIAL BETWEEN '  ' AND 'zz' "+CRLF 
	//cQuery += " ORDER BY SE1.E1_FILIAL, E1_EMIS1, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA"+CRLF
	cQuery += " ORDER BY E1_FILIAL, E1_EMIS1 , E1_PREFIXO , E1_NUM , E1_PARCELA , E1_TIPO , E1_CLIENTE , E1_LOJA"+CRLF

MemoWrite("C:\Temp1\CABR128CANC.txt",cQuery)
//
If Select(cAliasQry) > 0
	dbSelectArea(cAliasQry)
	dbCloseArea()
EndIf
//cQuery := ChangeQuery(cQuery)// altamiro 14/07/2016
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
//
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Contagem dos arquivos para o "Processa"³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While (cAliasQry)->(!Eof())
	nCountnx ++
	(cAliasQry)->(DbSkip())
EndDo
(cAliasQry)->(DbGoTop())
//
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//
_nTotVlr	:= 	0			&& E1_VALOR - Total por Dia
_nTotGer	:=	0			&& E1_VALOR	- Total Relatorio
//
ProcRegua(nCountnx)
//            
While (cAliasQry)->(!Eof())
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//
	If lAbortPrint
		@nLinn,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	//
	If nLinn > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLinn := 9
	Endif
	//
	_nTotVlr	:= 	0
	_dEMIS1		:=	(cAliasQry)->E1_EMIS1
	_cFILIAL	:=	(cAliasQry)->E1_FILIAL
	_aTitulos	:=	{} 
	//                           20130821
	@nLinn,001 PSAY substr(_dEMIS1,7,2)+"/"+substr(_dEMIS1,5,2)+"/"+substr(_dEMIS1,1,4)
	@nLinn,012 PSAY _cFILIAL 
	//
	Do while !eof() .and. (cAliasQry)->E1_EMIS1 == _dEMIS1 .and.(cAliasQry)->E1_FILIAL == _cFILIAL
		//
		If nLinn > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLinn := 9
			@nLinn,001 PSAY substr(_dEMIS1,7,2)+"/"+substr(_dEMIS1,5,2)+"/"+substr(_dEMIS1,1,4)
			@nLinn,012 PSAY _cFILIAL 
			//
		Endif
		//
		_cPREFIXO	:=	(cAliasQry)->E1_PREFIXO
		_cNUM		:=	(cAliasQry)->E1_NUM
		_cPARCELA	:=	(cAliasQry)->E1_PARCELA
		_cTIPO		:=	(cAliasQry)->E1_TIPO
		_cCLIENTE	:=	(cAliasQry)->E1_CLIENTE
		_cLOJA		:=	(cAliasQry)->E1_LOJA
		_cNOMCLI	:=	(cAliasQry)->E1_NOMCLI
		_cEMISSAO	:=	(cAliasQry)->E1_EMISSAO
		_cVENCREA	:=	(cAliasQry)->E1_VENCREA
		_cORIGEM	:=	(cAliasQry)->E1_ORIGEM
		_nVALOR		:=	(cAliasQry)->E1_VALOR
		_cLAPRO		:=	Iif((cAliasQry)->E1_LAPRO="F","N","S")		&& Provisao Contabil (rotina CABA323) - Provisao Receita
		_cLOTECAN	:= "CANC"
		_nTotVlr	+= 	_nVALOR
		_nTotGer	+=	_nVALOR
		_cCOMPT     :=  (cAliasQry)->E1_MESBASE+'/'+(cAliasQry)->E1_ANOBASE  
		_cCODEMP    :=  (cAliasQry)->E1_CODEMP
		_cMATRIC    :=  (cAliasQry)->E1_MATRIC   
		_cNUMCOB    :=  (cAliasQry)->E1_PLNUCOB
		//
		If MV_PAR13 = 1	&& Gerar Planilha - 1 Sim / 2 Nao
			//
			AADD(aGerXls,{"TITULO",;				&& 		Tipo LInha
							chr(160)+_cFILIAL,;		&&				"FILIAL",;
							_dEMIS1,;				&&				"EMISSAO",;
							chr(160)+_cPREFIXO,;	&&				"PREFIXO",;
							chr(160)+_cNUM,;		&&				"NUMERO",;
							chr(160)+_cPARCELA,;	&&				"PARCELA",;
							chr(160)+_cTIPO,;		&&				"TIPO",;
							chr(160)+_cCLIENTE,;	&&				"CLIENTE",;
							chr(160)+_cLOJA,;		&&				"LOJA",;
							chr(160)+_cNOMCLI,;		&&				"NOME",;
							_cEMISSAO,;				&&				"EMISSAO",;
							_cVENCREA,;				&&				"VENCIMENTO",;
							_cORIGEM,;				&&				"ORIGEM",;
							_nVALOR,;				&&				"VALOR_TITULO",;
							"  ",;					&&				"TIPO_CON",;
							"  ",;					&&				"PLANO",;
							"  ",;					&&				"DESC_PLANO",;
							"  ",;					&&				"LANCTO",;
							"  ",;					&&				"COD_PRODUTO",; 
							"  ",;					&&				"DESC_PRODUTO",;
							"  ",;					&&				"VALOR_PRODUTO"})
							_cLAPRO,;				&&				Provisao Receita (E1_LAPRO
							_cLOTECAN ,;            &&				Cancelado Lote Pagamento
							_cCOMPT	  ,;  			&&				Competencia 
							_cCODEMP  })			&&				Cod Empresa
								
				//
		Endif
		//				
		@nLinn,017 PSAY _cPREFIXO
		@nLinn,022 PSAY _cNUM
		@nLinn,032 PSAY _cPARCELA
		@nLinn,036 PSAY _cTIPO
		@nLinn,041 PSAY _cCLIENTE+" "+_cLOJA
		@nLinn,051 PSAY substr(_cNOMCLI,1,20)
		@nLinn,072 PSAY substr(_cEMISSAO,7,2)+"/"+substr(_cEMISSAO,5,2)+"/"+substr(_cEMISSAO,1,4)
		@nLinn,084 PSAY substr(_cVENCREA,7,2)+"/"+substr(_cVENCREA,5,2)+"/"+substr(_cVENCREA,1,4)
		@nLinn,096 PSAY _cORIGEM
		@nLinn,104 PSAY transform(_nVALOR,"@E 999,999,999,999.99")
		@nLinn,124 PSAY _cLAPRO 
		@nLinn,128 PSAY _cLOTECAN
		//
		If MV_PAR11 == 1		&& Detalhar Resumo Operacao/Composicao BMN
			//
			cQuery2	:= ""	
            
			If lCanc
				cQuery2 += "SELECT DISTINCT BMN.BMN_CODINT CODINT , BMN.BMN_CODTIP CODTIP , BMN.BMN_DESTIP DESTIP , BMN.BMN_CODPLA CODPLA , BMN.BMN_DESPLA DESPLA , BMN.BMN_TIPO TIPO, BI3.BI3_TIPCON, SUM(BMN.BMN_VALOR) VALOR "+CRLF
				cQuery2 += " , BMN_ANO ANO , BMN_MES MES "+CRLF // ALTAMIRO 04/07/2017
				cQuery2 += "FROM "+RetSqlName("BMN")+" BMN, "+RetSqlname("SE1")+" SE1 ,"+RetSqlName("BI3")+" BI3 "+CRLF
				cQuery2 += "where BMN.D_E_L_E_T_= ' ' "+CRLF 
				cQuery2 += "and SE1.D_E_L_E_T_=' ' "+CRLF
				cQuery2 += "and BI3.D_E_L_E_T_=' ' "+CRLF
				cQuery2 += "and BMN.BMN_PREFIX = SE1.E1_PREFIXO "+CRLF
				cQuery2 += "and BMN.BMN_NUMTIT = SE1.E1_NUM "+CRLF
				cQuery2 += "and BMN.BMN_PARCEL = SE1.E1_PARCELA "+CRLF
				cQuery2 += "and BMN.BMN_TIPTIT = SE1.E1_TIPO  "+CRLF			
				cQuery2 += "and BI3.BI3_CODINT = BMN.BMN_CODINT "+CRLF
				cQuery2 += "and BI3.BI3_CODIGO = BMN.BMN_CODPLA "+CRLF
				cQuery2 += " AND SE1.E1_PREFIXO = '"+_cPREFIXO+" ' "+CRLF 
				cQuery2 += " AND SE1.E1_NUM = '"+_cNUM+" ' "+CRLF 
				cQuery2 += " AND SE1.E1_PARCELA = '"+_cPARCELA+" ' "+CRLF 
				cQuery2 += " AND SE1.E1_TIPO = '"+_cTIPO+" ' "+CRLF 
				cQuery2 += " AND SE1.E1_CLIENTE = '"+_cCLIENTE+" ' "+CRLF 
				cQuery2 += " AND SE1.E1_LOJA = '"+_cLOJA+" ' "+CRLF 
				cQuery2 += " AND SE1.E1_FILIAL = '"+_cFILIAL+"' "+CRLF

				cQuery2 += "GROUP BY BMN.BMN_CODINT, BMN.BMN_CODTIP , BMN.BMN_DESTIP, BMN.BMN_CODPLA, BMN.BMN_DESPLA, BMN.BMN_TIPO, BI3.BI3_TIPCON , BMN_ANO , BMN_MES"+CRLF
	//			cQuery2 += "ORDER BY  BI3.BI3_TIPCON, BMN.BMN_CODPLA, BMN.BMN_DESPLA,BMN.BMN_CODTIP , BMN.BMN_DESTIP "+CRLF		
			
	        	cQuery2	+=" UNION ALL "
	        
			Endif

        	cQuery2 += "SELECT DISTINCT BM1.BM1_CODINT CODINT, BM1.BM1_CODTIP CODTIP , BM1.BM1_DESTIP DESTIP , BM1.BM1_CODPLA CODPLA, BM1.BM1_DESPLA DESPLA, BM1.BM1_TIPO TIPO , BI3.BI3_TIPCON, SUM(BM1.BM1_VALOR) VALOR "+CRLF
		    cQuery2 += " , BM1_ANO ANO , BM1_MES MES  "+CRLF // ALTAMIRO 04/07/2017
			cQuery2 += "FROM "+RetSqlName("BM1")+" BM1, "+RetSqlname("SE1")+" SE1 ,"+RetSqlName("BI3")+" BI3 "+CRLF
			cQuery2 += "where BM1.D_E_L_E_T_= '*' "+CRLF 
			cQuery2 += "and SE1.D_E_L_E_T_='*' "+CRLF
			cQuery2 += "and BI3.D_E_L_E_T_=' ' "+CRLF
			cQuery2 += "and BM1.BM1_PREFIX = SE1.E1_PREFIXO "+CRLF
			cQuery2 += "and BM1.BM1_NUMTIT = SE1.E1_NUM "+CRLF
			cQuery2 += "and BM1.BM1_PARCEL = SE1.E1_PARCELA "+CRLF
			cQuery2 += "and BM1.BM1_TIPTIT = SE1.E1_TIPO  "+CRLF			
			cQuery2 += "and BI3.BI3_CODINT = BM1.BM1_CODINT "+CRLF
			cQuery2 += "and BI3.BI3_CODIGO = BM1.BM1_CODPLA "+CRLF
			cQuery2 += " AND SE1.E1_PREFIXO = '"+_cPREFIXO+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_NUM = '"+_cNUM+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_PARCELA = '"+_cPARCELA+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_TIPO = '"+_cTIPO+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_CLIENTE = '"+_cCLIENTE+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_LOJA = '"+_cLOJA+" ' "+CRLF 
			cQuery2 += " AND SE1.E1_FILIAL = '"+_cFILIAL+"' "+CRLF
	
			cQuery2 += " AND SE1.E1_LAPRO  =  'T' "+CRLF

			cQuery2 += "and BM1.BM1_CODEMP  = '"+_cCODEMP +"'"+CRLF
	//		cQuery2 += "and BM1.BM1_MATRIC  = '"+_cMATRIC +"'"+CRLF

        	cQuery2 += "and BM1.BM1_PLNUCO  = '"+_cNUMCOB+"'"+CRLF

			cQuery2 += "GROUP BY BM1.BM1_CODINT, BM1.BM1_CODTIP , BM1.BM1_DESTIP, BM1.BM1_CODPLA, BM1.BM1_DESPLA, BM1.BM1_TIPO, BI3.BI3_TIPCON , BM1_ANO , BM1_MES"+CRLF
			cQuery2 += "ORDER BY BI3_TIPCON, CODPLA , DESPLA , CODTIP , DESTIP "+CRLF		

			MemoWrite("C:\Temp1\CABR1282canc.txt",cQuery2)
			//
			If Select(cAliasQ2) > 0	
				dbSelectArea(cAliasQ2)
				dbCloseArea()
			EndIf
 //			cQuery := ChangeQuery(cQuery2) // altamiro 14/07/2016
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),cAliasQ2,.T.,.T.)
			//
			Do while !eof() 
				//
				If lAbortPrint
					@nLinn,00 PSAY "*** CANCELADO PELO OPERADOR ***"
					Exit
				Endif
				If nLinn > 55
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLinn := 8
					@ nLinn,017 PSAY _cPREFIXO
					@ nLinn,022 PSAY _cNUM
					@ nLinn,032 PSAY _cPARCELA
					@ nLinn,036 PSAY _cTIPO
					@ nLinn,041 PSAY _cCLIENTE+" "+_cLOJA
					@ nLinn,051 PSAY substr(_cNOMCLI,1,20)
					@ nLinn,072 PSAY substr(_cEMISSAO,7,2)+"/"+substr(_cEMISSAO,5,2)+"/"+substr(_cEMISSAO,1,4)
					@ nLinn,084 PSAY substr(_cVENCREA,7,2)+"/"+substr(_cVENCREA,5,2)+"/"+substr(_cVENCREA,1,4)
					@ nLinn,096 PSAY _cORIGEM
					@ nLinn,104 PSAY transform(_nVALOR,"@E 999,999,999,999.99") 
					@ nLinn,124 PSAY _cLAPRO 
					@ nLinn,128 PSAY _cLOTECAN
					nLinn ++
				Endif
				// 
				_cCHVPLA	:= (cAliasQ2)->BI3_TIPCON+(cAliasQ2)->CODPLA+substr((cAliasQ2)->DESPLA,1,20)
				_cCHVEVE	:= (cAliasQ2)->CODTIP+(cAliasQ2)->DESTIP
				//
				If MV_PAR13 = 1	&& Gerar Planilha - 1 Sim / 2 Nao
					//
					AADD(aGerXls,{"DETALHE",;	 							&& 		Tipo LInha
							chr(160)+_cFILIAL,;								&&				"FILIAL",;
							_dEMIS1,;										&&				"EMISSAO",;
							chr(160)+_cPREFIXO,;							&&				"PREFIXO",;
							chr(160)+_cNUM,;								&&				"NUMERO",;
							chr(160)+_cPARCELA,;							&&				"PARCELA",;
							chr(160)+_cTIPO,;								&&				"TIPO",;
							chr(160)+_cCLIENTE,;							&&				"CLIENTE",;
							chr(160)+_cLOJA,;								&&				"LOJA",;
							chr(160)+_cNOMCLI,;								&&				"NOME",;
							_cEMISSAO,;										&&				"EMISSAO",;
							_cVENCREA,;										&&				"VENCIMENTO",;
							_cORIGEM,;										&&				"ORIGEM",;
							_nVALOR,;										&&				"VALOR_TITULO",;
							(cAliasQ2)->BI3_TIPCON,;						&&				"TIPO_CON",;
							(cAliasQ2)->CODPLA,;						&&				"PLANO",;
							substr((cAliasQ2)->DESPLA,1,20),;			&&				"DESC_PLANO",;
							IIf((cAliasQ2)->TIPO='1','[DEB]','[CRE]'),;	&&				"LANCTO",;
							(cAliasQ2)->CODTIP,;						&&				"COD_PRODUTO",; 			
							(cAliasQ2)->DESTIP,;						&&				"DESC_PRODUTO",;
							(cAliasQ2)->VALOR,;							&&				"VALOR_PRODUTO"})
							_cLAPRO,;										&&				Provisao Receita (E1_LAPRO
							_cLOTECAN,;										&&				Cancelado Lote Pagamento       
							(cAliasQ2)->MES+'/'+(cAliasQ2)->ANO})  	&&				Competencia        							
							
					//
				Endif
				//
				@nLinn,135 PSAY (cAliasQ2)->BI3_TIPCON+" "+(cAliasQ2)->CODPLA+" "+substr((cAliasQ2)->DESPLA,1,17)+" "+IIf((cAliasQ2)->TIPO='1','[DEB]','[CRE]')+" "+(cAliasQ2)->CODTIP+" "+substr((cAliasQ2)->DESTIP,1,27)
				@nLinn,205 PSAY transform((cAliasQ2)->VALOR,"@E 999,999,999.99")                                                                                    
				nLinn ++
				//
				_nPos	:=	aScan(_aResPla,{|x| Alltrim(x[1])==Alltrim(_cCHVPLA)})
				If	_nPos	>	0
					_aResPla[_nPos,5]	+=	(cAliasQ2)->VALOR
				Else           &&  1        2                      3                      4                                   5                     
					AADD(_aResPla,{_cCHVPLA,(cAliasQ2)->BI3_TIPCON,(cAliasQ2)->CODPLA,substr((cAliasQ2)->DESPLA,1,20),(cAliasQ2)->VALOR})
				Endif
				//			     
				_nPos	:=	aScan(_aResEve,{|x| Alltrim(x[1])==Alltrim(_cCHVEVE)})
				If	_nPos	>	0
					_aResEve[_nPos,4]	+=	(cAliasQ2)->VALOR
				Else           &&  1        2                      3                      4
					AADD(_aResEve,{_cCHVEVE,(cAliasQ2)->CODTIP,(cAliasQ2)->DESTIP,(cAliasQ2)->VALOR})
				Endif
				//			     
				(cAliasQ2)->(dbSkip())
				//
			EndDo
			//
		Endif	
		nLinn ++
		DbSelectArea(cAliasQry)
		(cAliasQry)->(dbSkip())
		//
	EndDo
	//
	nLinn ++
	@ nLinn,005  psay replicate("-",120)
	nLinn ++
	@ nLinn,001  psay substr(_dEMIS1,7,2)+"/"+substr(_dEMIS1,5,2)+"/"+substr(_dEMIS1,1,4)+"   ....  TOTAL......"
	@ nLinn,104 PSAY transform(_nTotVlr,"@E 999,999,999,999.99") 
	nLinn ++
	//
	nLinn ++
	DbSelectArea(cAliasQry)
//	(cAliasQry)->(dbSkip())
	//
Enddo		
//
If eof()
	//
	nLinn ++
	@ nLinn,005  psay replicate("-",120)
	nLinn ++
	@ nLinn,001  psay "TOTAL GERAL ......"
	@ nLinn,104 PSAY transform(_nTotGer,"@E 999,999,999,999.99") 
	nLinn ++
	nLinn ++
	//
	_nResPla	:= 0
	_nResEve	:= 0
	aSort(_aResPla,,,{|x,y| x[1]<y[1]})
	//
	If nLinn > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLinn := 8
		nLinn ++
	Endif
	//
	@nLinn, 001 PSAY "----------------------------------------------------------------------------------------------------"
	nLinn++
	@nLinn, 001 PSAY "                                 Resumo por Plano"
	nLinn++
	@nLinn, 001 PSAY "----------------------------------------------------------------------------------------------------"
	
	_nTotalRet	:=	0
	
	For	_i	:=	1	To	Len(_aResPla)
		nLinn++
		//
		If nLinn > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLinn := 8
			nLinn ++
		Endif
		//
		@nLinn, 001 PSAY _aResPla[_i,2]+" "+_aResPla[_i,3]+"     "+_aResPla[_i,4]+"    "+transform(_aResPla[_i,5],"@E 999,999,999,999.99")
		_nResPla	+= _aResPla[_i,5]
		//
	Next
	//
	//
	If nLinn > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLinn := 8
		nLinn ++
	Endif
	//
	nLinn ++
	@ nLinn,001  psay replicate("-",120)
	nLinn ++
	@ nLinn,001  psay "TOTAL POR PLANO ......"
	@ nLinn,60 PSAY transform(_nResPla,"@E 999,999,999,999.99") 
	nLinn ++
	@ nLinn,001  psay replicate("-",120)
	//	
	//
	aSort(_aResEve,,,{|x,y| x[1]<y[1]})
	//
	If nLinn > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLinn := 8
		nLinn ++
	Endif
	//
	nLinn++
	nLinn++
	@nLinn, 001 PSAY "----------------------------------------------------------------------------------------------------"
	nLinn++
	@nLinn, 001 PSAY "                                 Resumo por Evento"
	nLinn++
	@nLinn, 001 PSAY "----------------------------------------------------------------------------------------------------"
	
	_nTotalRet	:=	0
	
	For	_i	:=	1	To	Len(_aResEve)
		nLinn++
		//
		If nLinn > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLinn := 8
			nLinn ++
		Endif
		//
		@nLinn, 001 PSAY _aResEve[_i,2]+" "+_aResEve[_i,3]+" "+transform(_aResEve[_i,4],"@E 999,999,999,999.99")
		_nResEve += _aResEve[_i,4]
		//
	Next
	//	
	nLinn ++
	@ nLinn,001  psay replicate("-",120)
	nLinn ++
	@ nLinn,001  psay "TOTAL POR EVENTO ......"
	@ nLinn,60 PSAY transform(_nResEve,"@E 999,999,999,999.99") 
	nLinn ++
	@ nLinn,001  psay replicate("-",120)

	//
Endif
//
If mv_par13 == 1  	&& Gerar Arquivo XLS - Excel
	//
	DlgToExcel({{"ARRAY","","",aGerXls}})
    //
Endif
//
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return