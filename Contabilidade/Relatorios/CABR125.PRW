#INCLUDE "rwmake.ch"
#Include "Protheus.ch"
#Include "TopConn.ch"
//#DEFINE cEnt	Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR995  º Autor ³ Vitor Sbano        º Data ³  27/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório Demonstrativo de Substituição de Titulos         º±±
±±º          ³ a Receber                                                  º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ - SIGAFIN  - Relatoriso                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//	Alteracoes:	07/06/13	- Vitor Sbano	- Adequacoes solicitadas pelo Alan Lemos
//
//
//
//
User Function CABR125

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relatório de Substituição Titulos a Receber- Versao 2013.06.07"
Local cPict          := ""
Local Cabec1         := "" 	
Local Cabec2         := "DT MOVIM. FIL  CLIENTE   NOME                            PRF NUM FAT   PARC TIPO  VALOR           DT EMISSAO  DT VENCTO   PRF NUMERO    PAR TIPO DT EMISSAO  DT VENCTO  VALOR "
Local imprime        := .T.
Local aOrd           := {}
Local cPerg          := "CABR125B"
Local nLinn          := 220

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private titulo       := "CABERJ - Movimentação de Cobranca - Titulos a Receber"
Private nomeprog     := "CABR125" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR125" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString      := "SC5"
Private cAliasQry    := GetNextAlias()
Private cQuery       := ""
Private cAliasQ1     := GetNextAlias()
Private cQuery1      := ""
Private cAliasQ2     := GetNextAlias()
Private cQuery2      := ""
Private aVetExcel    := {}
Private aCabExcel    := {}
//
PutSx1( cPerg,"01","Da  Filial ?"      		    ,"","","mv_ch1","C",02  ,0,0,"G","","SM0","","","MV_PAR01")
PutSx1( cPerg,"02","Ate a Filial ?"      		,"","","mv_ch2","C",02	,0,0,"G","","SM0","","","MV_PAR02")
PutSx1( cPerg,"03","Da Data Movimentacao"       ,"","","mv_ch3","D",08  ,0,0,"G","","   ","","","MV_PAR03")
PutSx1( cPerg,"04","Ate a Data Movimentacao"    ,"","","mv_ch4","D",08 	,0,0,"G","","   ","","","MV_PAR04")
PutSx1( cPerg,"05","Do Cliente?"                ,"","","mv_ch5","C",06  ,0,0,"G","","SA1","","","MV_PAR05")
PutSx1( cPerg,"06","Ate Cliente"                ,"","","mv_ch6","C",06 	,0,0,"G","","SA1","","","MV_PAR06")
PutSx1( cPerg,"07","Do Tipo Titulo?"            ,"","","mv_ch7","C",3   ,0,0,"G","","05","","","MV_PAR07")
PutSx1( cPerg,"08","Ate o Tipo Titulo"          ,"","","mv_ch8","C",3 	,0,0,"G","","05","","","MV_PAR08")
Putsx1( cPerg,"09","Detalhar por Tipo Operacao?","","","mv_ch9","N",1   ,0,0,"C","","","","","MV_PAR09","1-Sim" ,"","","","2-Não","","")
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
Processa({|lEnd| R53Report(wnRel,Cabec1,Cabec2,nLinn)})
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³R53Report º Autor ³ Felipe R Neves     º Data ³  22/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlterações³ Desmembramento do Relatório Analítico - Jader - 02/04/2012 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R53Report(wnRel,Cabec1,Cabec2,nLinn)

Local nOrdem
Local nCountnx := 0
Local cContOrc := ""
Local cDescOrc := ""
Local aTotCC   := {}
Local _aResPla	:=	{} 
Local _aResEve	:=	{}  
Local _aTitulos	:=	{} 

Local _i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
//
Cabec1         := " -------------------------------------------   F  A  T  U  R  A  --------------------------------------------------------------| ------------------------- TITULO ORIGINAL -------------------------------"
Cabec2         := "ORIGEM DT MOVIM. FIL  CLIENTE   NOME                            PRF NUM FAT                 VALOR        DT EMISSAO  DT VENCTO | PRF NUMERO    PAR TIPO DT EMISSAO  DT VENCTO      VALOR           USUARIO"
//
titulo	:= titulo + " - Periodo: "+dtoc(MV_PAR03)+" a "+dtoc(MV_PAR04)
Private nTotGrlx := 0
//
cQuery := " "
cQuery += "SELECT E5_CHAVE, E5_ORIGEM, E5_FILIAL, E5_DATA, E5_FATPREF, E5_FATURA, E5_PARCELA, E5_CLIENTE, E5_LOJA, A1_NREDUZ, E5_VALOR  FROM ( "+CRLF
cQuery += "SELECT  SE5.E5_FATPREF||SE5.E5_FATURA E5_CHAVE, 'SE5' E5_ORIGEM, SE5.E5_FILIAL E5_FILIAL , SE5.E5_DATA E5_DATA , SE5.E5_FATPREF E5_FATPREF, SE5.E5_FATURA E5_FATURA,SE5.E5_PARCELA E5_PARCELA, "+CRLF
cQuery += " SE5.E5_CLIENTE E5_CLIENTE, SE5.E5_LOJA E5_LOJA, SA1.A1_NREDUZ A1_NREDUZ, SUM(SE5.E5_VALOR) E5_VALOR "+CRLF
cQuery += " FROM "+RetSqlname("SE5")+" SE5, "+RetSqlname("SA1")+" SA1 "+CRLF
cQuery += " WHERE SE5.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SA1.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SE5.E5_SITUACA=' ' "+CRLF 
cQuery += " AND SE5.E5_MOTBX = 'FAT' "+CRLF 
cQuery += " AND SE5.E5_TIPODOC='BA' "+CRLF
cQuery += " AND SA1.A1_COD = SE5.E5_CLIENTE "+CRLF
cQuery += " AND SA1.A1_LOJA = SE5.E5_LOJA "+CRLF
cQuery += " AND SE5.E5_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+CRLF
cQuery += " AND SE5.E5_DATA BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF
cQuery += " AND SE5.E5_CLIFOR BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery += " AND SE5.E5_TIPO BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF 
cQuery += " GROUP BY SE5.E5_FATPREF||SE5.E5_FATURA, SE5.E5_FILIAL, SE5.E5_DATA, SE5.E5_FATPREF, SE5.E5_FATURA,SE5.E5_PARCELA, SE5.E5_CLIENTE, SE5.E5_LOJA, SA1.A1_NREDUZ "+CRLF
//
cQuery += " UNION ALL "+CRLF
//          
cQuery += " SELECT SZG.ZG_CODIGO E5_CHAVE, 'SZH' E5_ORIGEM, SZG.ZG_FILIAL E5_FILIAL, SZG.ZG_DTNEG E5_DATA, SZH.ZH_PREFIXO E5_FATPREF, SZH.ZH_NUM E5_FATURA, SZH.ZH_PARCELA E5_PARCELA, "+CRLF
cQuery += " SZG.ZG_CLIENTE E5_CLIENTE, SZG.ZG_LOJA E5_LOJA, SZG.ZG_NOME A1_NREDUZ, SZH.ZH_VALOR E5_VALOR "+CRLF
cQuery += " FROM "+RetSqlname("SZG")+" SZG, "+RetSqlname("SZH")+" SZH "+CRLF  && ,"+RetSqlname("SE1")+" SE1  "+CRLF
cQuery += " WHERE SZG.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SZH.D_E_L_E_T_=' ' "+CRLF
//cQuery += " AND SA1.D_E_L_E_T_=' ' "+CRLF 
cQuery += " AND SZH.ZH_NEGTIPO='S' "+CRLF  
cQuery += " AND SZH.ZH_CODIGO = SZG.ZG_CODIGO "+CRLF
cQuery += " AND SZG.ZG_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "+CRLF
cQuery += " AND SZG.ZG_DTNEG BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF
cQuery += " AND SZG.ZG_CLIENTE BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery += " ) QRY ORDER BY E5_FILIAL, E5_DATA, E5_CHAVE,E5_FATPREF, E5_FATURA, E5_PARCELA, E5_CLIENTE, E5_LOJA"
//
MemoWrite("C:\Temp1\CABR125.txt",cQuery)
//
If Select(cAliasQry) > 0
	dbSelectArea(cAliasQry)
	dbCloseArea()
EndIf
cQuery := ChangeQuery(cQuery)
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
_nTotFat	:=	0
_nTotTit	:=	0
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
	//  SE5.E5_FILIAL, SE5.E5_DATA, SE5.E5_FATPREF, SE5.E5_FATURA, SE5.E5_CLIENTE, SUM(SE5.E5_VALOR) E5_VALOR
	//
	_nTotOrig	:=	0
	_nTotFat	:= 	0
	_nTotTit	:=	0	
	_cORIGEM	:=	(cAliasQry)->E5_ORIGEM
	_cDATA		:=	(cAliasQry)->E5_DATA
	_cCLIENTE	:=	(cAliasQry)->E5_CLIENTE
	_cLOJA		:=	(cAliasQry)->E5_LOJA
	_cDATA		:=	(cAliasQry)->E5_DATA
	_cFILIAL	:=	(cAliasQry)->E5_FILIAL
	_cNREDUZ	:=	substr((cAliasQry)->A1_NREDUZ,1,30)     
	_cCHAVE		:=	(cAliasQry)->E5_CHAVE
	_aTitulos	:=	{} 
	//
	@nLinn,001 PSAY _cORIGEM
	@nLinn,008 PSAY substr(_cDATA,7,2)+"/"+substr(_cDATA,5,2)+"/"+substr(_cDATA,3,2)
	@nLinn,019 PSAY _cFILIAL 
	@nLinn,023 PSAY _cCLIENTE+" "+_cLOJA  
	@nLinn,033 PSAY _cNREDUZ
	//
	Do while !eof() .and. (cAliasQry)->E5_ORIGEM == _cORIGEM .and.(cAliasQry)->E5_FILIAL == _cFILIAL .and. (cAliasQry)->E5_DATA = _cDATA .AND. (cAliasQry)->E5_CHAVE = _cCHAVE
		//
		If nLinn > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLinn := 9
			@nLinn,001 PSAY _cORIGEM
			@nLinn,008 PSAY substr(_cDATA,7,2)+"/"+substr(_cDATA,5,2)+"/"+substr(_cDATA,3,2)
			@nLinn,019 PSAY _cFILIAL 
			@nLinn,023 PSAY _cCLIENTE+" "+_cLOJA  
			@nLinn,033 PSAY _cNREDUZ
			//
		Endif
		//
		_cFATPREF	:=	(cAliasQry)->E5_FATPREF
		_cFATURA	:=	(cAliasQry)->E5_FATURA
		_cPARCELA	:=	(cAliasQry)->E5_PARCELA
		_nTotFat	+=	(cAliasQry)->E5_VALOR
		//	                  
		If _cORIGEM	== "SE5"
			dFATEMIS	:=	Posicione("SE1",1,_cFILIAL+_cFATPREF+_cFATURA,"E1_EMISSAO")
			dFATVENC	:=	Posicione("SE1",1,_cFILIAL+_cFATPREF+_cFATURA,"E1_VENCREA")		
		Else
			dFATEMIS	:=	Posicione("SE1",1,_cFILIAL+_cFATPREF+_cFATURA+_cPARCELA,"E1_EMISSAO")
			dFATVENC	:=	Posicione("SE1",1,_cFILIAL+_cFATPREF+_cFATURA+_cPARCELA,"E1_VENCREA")
		Endif
		@nLinn,066 PSAY _cFATPREF+" "+_cFATURA
		@nLinn,080 PSAY _cPARCELA 				&& Parcela
//		@nLinn,077 PSAY "YYY" 				&& Tipo  
		@nLinn,091 PSAY transform((cAliasQry)->E5_VALOR,"@E 999,999,999.99") 
		@nLinn,107 PSAY dFATEMIS		&& Emissao
		@nLinn,119 PSAY dFATVENC		&& Vencimento
		//
		If _cORIGEM = "SZH"
		
		Endif
		//
		nLinn ++
		DbSelectArea(cAliasQry)
		(cAliasQry)->(dbSkip())
		//
	Enddo	
//	DT MOVIM. FIL  CLIENTE   NOME                            PRF NUM FAT   PARC TIPO  VALOR           DT EMISSAO  DT VENCTO   PRF NUMERO    PAR TIPO DT EMISSAO  DT VENCTO  VALOR
//	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//	DD/MM/AA  12   123456 12 12345678901234567890123456789   123 123456789 12   123   999.999.999.99  dd/mm/aaaa  dd/mm/aaaa  123 123456789 12 123   dd/mm/aaaa  dd/mm/aaaa  999.999.999.99
//	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//	1         12   16     23 26                              58  62        72   77    83              99          111         123 127       137140   146         158         170 
//	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//
	If _cORIGEM == "SE5"
		//
		cQuery1	:= ""	
		cQuery1 += "SELECT SE5.E5_FILIAL, SE5.E5_DATA, SE5.E5_FATPREF, SE5.E5_FATURA, SE5.E5_CLIENTE, SE5.E5_VALOR E5_VALOR, "+CRLF 
		cQuery1 += " SE5.E5_MOTBX, SE5.E5_TIPODOC, SE5.E5_FILORIG, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA, SE5.E5_TIPO, SE5.E5_CLIFOR, SE5.E5_LOJA,"+CRLF 
		cQuery1 += " SE1.E1_EMISSAO, SE1.E1_VENCREA, SE1.E1_VALOR, SE5.E5_FILORIG, SE5.E5_USERLGI"+CRLF 
		cQuery1 += " FROM "+RetSqlname("SE5")+" SE5, "+RetSqlname("SA1")+" SA1 ,"+RetSqlname("SE1")+" SE1 "+CRLF
		cQuery1 += " WHERE SE5.D_E_L_E_T_=' ' "+CRLF
		cQuery1 += " AND SA1.D_E_L_E_T_=' ' "+CRLF
		cQuery1 += " AND SE1.D_E_L_E_T_=' ' "+CRLF
		cQuery1 += " AND SE5.E5_SITUACA=' ' "+CRLF 
		cQuery1 += " AND SE5.E5_MOTBX = 'FAT' "+CRLF 
		cQuery1 += " AND SE5.E5_TIPODOC='BA' "+CRLF
		cQuery1 += " AND SA1.A1_COD = SE5.E5_CLIENTE "+CRLF
		cQuery1 += " AND SA1.A1_LOJA = SE5.E5_LOJA "+CRLF
		cQuery1 += " AND SE1.E1_FILIAL = SE5.E5_FILORIG "+CRLF
		cQuery1 += " AND SE1.E1_PREFIXO = SE5.E5_PREFIXO "+CRLF
		cQuery1 += " AND SE1.E1_NUM = SE5.E5_NUMERO "+CRLF
		cQuery1 += " AND SE1.E1_PARCELA = SE5.E5_PARCELA "+CRLF
		cQuery1 += " AND SE1.E1_TIPO = SE5.E5_TIPO "+CRLF
		cQuery1 += " AND SE1.E1_CLIENTE = SE5.E5_CLIFOR "+CRLF
		cQuery1 += " AND SE1.E1_LOJA = SE5.E5_LOJA "+CRLF
		cQuery1 += " AND SE5.E5_CLIFOR BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
		cQuery1 += " AND SE5.E5_TIPO BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF 
		cQuery1 += " AND SE5.E5_FATPREF = '"+_cFATPREF+" ' "+CRLF 
		cQuery1 += " AND SE5.E5_FATURA = '"+_cFATURA+" ' "+CRLF 
		cQuery1 += " AND SE5.E5_CLIENTE = '"+_cCLIENTE+" ' "+CRLF 
		cQuery1 += " AND SE5.E5_DATA = '"+_cDATA+"' "+CRLF
		cQuery1 += " AND SE5.E5_FILORIG = '"+_cFILIAL+"' "+CRLF
		cQuery1 += "ORDER BY SE5.E5_FILORIG, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA, SE5.E5_TIPO, SE5.E5_CLIFOR, SE5.E5_LOJA"
		MemoWrite("C:\Temp1\CABR1251.txt",cQuery1)
		//
	Else			&& Renegociacao
		//
		cQuery1	:= ""	
		cQuery1 += "SELECT SZH.ZH_FILIAL E5_FILIAL, SZG.ZG_DTNEG E5_DATA,  SZG.ZG_CLIENTE E5_CLIENTE, SZH.ZH_VALOR E5_VALOR, "+CRLF 
		cQuery1 += " SZH.ZH_PREFIXO E5_PREFIXO, SZH.ZH_NUM E5_NUMERO, SZH.ZH_PARCELA E5_PARCELA, SZH.ZH_TIPO E5_TIPO, SZG.ZG_CLIENTE E5_CLIFOR, SZG.ZG_LOJA E5_LOJA,"+CRLF 
		cQuery1 += " SE1.E1_EMISSAO, SE1.E1_VENCREA, SE1.E1_VALOR, SZH.ZH_FILIAL E5_FILORIG, SZH.ZH_USERLGI E5_USERLGI"+CRLF 
		cQuery1 += " FROM "+RetSqlname("SZG")+" SZG, "+RetSqlname("SZH")+" SZH ,"+RetSqlname("SE1")+" SE1 "+CRLF
		cQuery1 += " WHERE SZG.D_E_L_E_T_=' ' "+CRLF
		cQuery1 += " AND SZH.D_E_L_E_T_=' ' "+CRLF
		cQuery1 += " AND SE1.D_E_L_E_T_=' ' "+CRLF
		cQuery1 += " AND SZG.ZG_CODIGO = '"+_cCHAVE+"' "+CRLF 
		cQuery1 += " AND SZH.ZH_CODIGO = SZG.ZG_CODIGO "+CRLF 
		cQuery1 += " AND SZH.ZH_NEGTIPO = 'E' "+CRLF 
		cQuery1 += " AND SE1.E1_FILIAL = SZH.ZH_FILIAL "+CRLF
		cQuery1 += " AND SE1.E1_PREFIXO = SZH.ZH_PREFIXO "+CRLF
		cQuery1 += " AND SE1.E1_NUM = SZH.ZH_NUM "+CRLF
		cQuery1 += " AND SE1.E1_PARCELA = SZH.ZH_PARCELA "+CRLF
		cQuery1 += " AND SE1.E1_TIPO = SZH.ZH_TIPO "+CRLF
		cQuery1 += " AND SE1.E1_CLIENTE = SZG.ZG_CLIENTE "+CRLF
		cQuery1 += " AND SE1.E1_LOJA = SZG.ZG_LOJA "+CRLF
		cQuery1 += "ORDER BY SZH.ZH_FILIAL, SZH.ZH_PREFIXO, SZH.ZH_NUM, SZH.ZH_PARCELA, SZH.ZH_TIPO, SZG.ZG_CLIENTE, SZG.ZG_LOJA"
		MemoWrite("C:\Temp1\CABR1251SZH.txt",cQuery1)
		//	
	Endif	
	//
	If Select(cAliasQ1) > 0	
		dbSelectArea(cAliasQ1)
		dbCloseArea()
	EndIf
	cQuery := ChangeQuery(cQuery1)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery1),cAliasQ1,.T.,.T.)
	//
	nLinn	:= nLinn -1
	//
	Do while !eof() 
		//
		If lAbortPrint
			@nLinn,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		If nLinn > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLinn := 9
			@nLinn,001 PSAY _cORIGEM
			@nLinn,008 PSAY substr(_cDATA,7,2)+"/"+substr(_cDATA,5,2)+"/"+substr(_cDATA,3,2)
			@nLinn,019 PSAY _cFILIAL 
			@nLinn,023 PSAY _cCLIENTE+" "+_cLOJA  
			@nLinn,033 PSAY _cNREDUZ
			//
			nLinn ++
		Endif
		//
		@ nLinn,130 PSAY (cAliasQ1)->E5_PREFIXO+" "+(cAliasQ1)->E5_NUMERO+" "+(cAliasQ1)->E5_PARCELA+" "+(cAliasQ1)->E5_TIPO
		@ nLinn,153 PSAY substr((cAliasQ1)->E1_EMISSAO,7,2)+"/"+substr((cAliasQ1)->E1_EMISSAO,5,2)+"/"+substr((cAliasQ1)->E1_EMISSAO,3,2)
		@ nLinn,166 PSAY substr((cAliasQ1)->E1_VENCREA,7,2)+"/"+substr((cAliasQ1)->E1_VENCREA,5,2)+"/"+substr((cAliasQ1)->E1_VENCREA,3,2)
		@ nLinn,178 PSAY transform((cAliasQ1)->E1_VALOR,"@E 999,999,999.99") 
		@ nLinn,194 PSAY substr(embaralha((cAliasQ1)->E5_USERLGI,1),1,15)
		_nTotTit	+=	(cAliasQ1)->E1_VALOR
		nLinn ++
		(cAliasQ1)->(dbSkip())
		//
	EndDo
	//
	nLinn ++
	@ nLinn,058  psay replicate("-",120)
	nLinn ++
	@ nLinn,048  psay "( "+_cCHAVE+" )   TOTAL......"
	@ nLinn,091 PSAY orm(_nTotFat,"@E 999,999,999.99") 
	@ nLinn,123  psay replicate(".",44)
	@nLinn,170 PSAY transform(_nTotTit,"@E 999,999,999.99") 
	nLinn ++
	//
	If MV_PAR09 == 1		&& Detalhar Resumo Operacao/Composicao BM1
		//
		nLinn ++
		If _cORIGEM == "SE5"
			//
			cQuery2	:= ""	
			cQuery2 += "SELECT DISTINCT BM1.BM1_CODINT, BM1.BM1_CODTIP , BM1.BM1_DESTIP, BM1.BM1_CODPLA, BM1.BM1_DESPLA, BI3.BI3_TIPCON, SUM(BM1.BM1_VALOR) BM1_VALOR "+CRLF
			cQuery2 += "FROM "+RetSqlName("BM1")+" BM1, "+RetSqlname("SE5")+" SE5 ,"+RetSqlName("BI3")+" BI3 "+CRLF
			cQuery2 += "where BM1.D_E_L_E_T_= ' ' "+CRLF 
			cQuery2 += "and SE5.D_E_L_E_T_=' ' "+CRLF
			cQuery2 += "and BI3.D_E_L_E_T_=' ' "+CRLF
			cQuery2 += "and BM1.BM1_PREFIX = SE5.E5_PREFIXO "+CRLF
			cQuery2 += "and BM1.BM1_NUMTIT = SE5.E5_NUMERO "+CRLF
			cQuery2 += "and BM1.BM1_PARCEL = SE5.E5_PARCELA "+CRLF
			cQuery2 += "and BM1.BM1_TIPTIT = SE5.E5_TIPO  "+CRLF
			cQuery2 += "and BI3.BI3_CODINT = BM1.BM1_CODINT "+CRLF
			cQuery2 += "and BI3.BI3_CODIGO = BM1.BM1_CODPLA "+CRLF
			cQuery2 += " AND SE5.E5_FATPREF = '"+_cFATPREF+" ' "+CRLF 
			cQuery2 += " AND SE5.E5_FATURA = '"+_cFATURA+" ' "+CRLF 
			cQuery2 += " AND SE5.E5_CLIENTE = '"+_cCLIENTE+" ' "+CRLF 
			cQuery2 += " AND SE5.E5_DATA = '"+_cDATA+"' "+CRLF
			cQuery2 += " AND SE5.E5_FILORIG = '"+_cFILIAL+"' "+CRLF
			cQuery2 += "GROUP BY BM1.BM1_CODINT, BM1.BM1_CODTIP , BM1.BM1_DESTIP, BM1.BM1_CODPLA, BM1.BM1_DESPLA, BI3.BI3_TIPCON "+CRLF
			cQuery2 += "ORDER BY  BI3.BI3_TIPCON, BM1.BM1_CODPLA, BM1.BM1_DESPLA,BM1.BM1_CODTIP , BM1.BM1_DESTIP "+CRLF		
			MemoWrite("C:\Temp1\CABR1252.txt",cQuery2)
		Else
			//
			cQuery2	:= ""	
			cQuery2 += "SELECT DISTINCT BM1.BM1_CODINT, BM1.BM1_CODTIP , BM1.BM1_DESTIP, BM1.BM1_CODPLA, BM1.BM1_DESPLA, BI3.BI3_TIPCON, SUM(BM1.BM1_VALOR) BM1_VALOR "+CRLF
			cQuery2 += "FROM "+RetSqlName("BM1")+" BM1, "+RetSqlname("SZH")+" SZH ,"+RetSqlName("BI3")+" BI3 "+CRLF
			cQuery2 += "where BM1.D_E_L_E_T_= ' ' "+CRLF 
			cQuery2 += "and SZH.D_E_L_E_T_=' ' "+CRLF
			cQuery2 += "and BI3.D_E_L_E_T_=' ' "+CRLF
			cQuery2 += "and BM1.BM1_PREFIX = SZH.ZH_PREFIXO "+CRLF
			cQuery2 += "and BM1.BM1_NUMTIT = SZH.ZH_NUM "+CRLF
			cQuery2 += "and BM1.BM1_PARCEL = SZH.ZH_PARCELA "+CRLF
			cQuery2 += "and BM1.BM1_TIPTIT = SZH.ZH_TIPO  "+CRLF
			cQuery2 += "and BI3.BI3_CODINT = BM1.BM1_CODINT "+CRLF
			cQuery2 += "and BI3.BI3_CODIGO = BM1.BM1_CODPLA "+CRLF
			cQuery2 += " AND SZH.ZH_CODIGO = '"+_cCHAVE+"' "+CRLF 
			cQuery2 += " AND SZH.ZH_NEGTIPO = 'E' "+CRLF 
			cQuery2 += " AND SZH.ZH_FILIAL = '"+_cFILIAL+"' "+CRLF
			cQuery2 += "GROUP BY BM1.BM1_CODINT, BM1.BM1_CODTIP , BM1.BM1_DESTIP, BM1.BM1_CODPLA, BM1.BM1_DESPLA, BI3.BI3_TIPCON "+CRLF
			cQuery2 += "ORDER BY  BI3.BI3_TIPCON, BM1.BM1_CODPLA, BM1.BM1_DESPLA,BM1.BM1_CODTIP , BM1.BM1_DESTIP "+CRLF		
			MemoWrite("C:\Temp1\CABR1252SZH.txt",cQuery2)
			//		
		Endif	
		//
		If Select(cAliasQ2) > 0	
			dbSelectArea(cAliasQ2)
			dbCloseArea()
		EndIf
		cQuery := ChangeQuery(cQuery2)
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
				@nLinn,001 PSAY substr(_cDATA,7,2)+"/"+substr(_cDATA,5,2)+"/"+substr(_cDATA,3,2)
				@nLinn,012 PSAY _cFILIAL 
				@nLinn,016 PSAY _cCLIENTE+" "+_cLOJA  
				@nLinn,026 PSAY _cNREDUZ
				@nLinn,058 PSAY _cFATPREF+" "+_cFATURA
				@nLinn,083 PSAY transform(_nTotFat,"@E 999,999,999.99") 
	   			@nLinn,099 PSAY dFATEMIS		&& Emissao
				@nLinn,111 PSAY dFATVENC		&& Vencimento
				nLinn ++
			Endif
			// 
			_cCHVPLA	:= (cAliasQ2)->BI3_TIPCON+(cAliasQ2)->BM1_CODPLA+substr((cAliasQ2)->BM1_DESPLA,1,20)
			_cCHVEVE	:= (cAliasQ2)->BM1_CODTIP+(cAliasQ2)->BM1_DESTIP
			//
			@nLinn,083 PSAY (cAliasQ2)->BI3_TIPCON+" "+(cAliasQ2)->BM1_CODPLA+" - "+substr((cAliasQ2)->BM1_DESPLA,1,20)			
			@nLinn,123 PSAY (cAliasQ2)->BM1_CODTIP+" - "+(cAliasQ2)->BM1_DESTIP
			@nLinn,170 PSAY transform((cAliasQ2)->BM1_VALOR,"@E 999,999,999.99") 
			nLinn ++
			//
			_nPos	:=	aScan(_aResPla,{|x| Alltrim(x[1])==Alltrim(_cCHVPLA)})
			If	_nPos	>	0
				_aResPla[_nPos,5]	+=	(cAliasQ2)->BM1_VALOR
			Else           &&  1        2                      3                      4                                   5                     
				AADD(_aResPla,{_cCHVPLA,(cAliasQ2)->BI3_TIPCON,(cAliasQ2)->BM1_CODPLA,substr((cAliasQ2)->BM1_DESPLA,1,20),(cAliasQ2)->BM1_VALOR})
			Endif
			//			     
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
		nLinn ++
		//	
	Endif
	// 
	nLinn ++
	DbSelectArea(cAliasQry)
//	(cAliasQry)->(dbSkip())
	//
Enddo		
//
If eof()
	//
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
		@nLinn, 001 PSAY _aResPla[_i,2]+" "+_aResPla[_i,3]+" "+_aResPla[_i,4]+" "+transform(_aResPla[_i,5],"@E 999,999,999,999.99")
		//@li, 020 PSAY _aResumo[_i,2]
		//@nLinn, 081 PSAY Transform(_aResumo[_i,7],"@E 9,999,999,999,999.99")
		//_nTotalRet	+=	_aResumo[_i,3]
	Next
	//
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
		//@li, 020 PSAY _aResumo[_i,2]
		//@nLinn, 081 PSAY Transform(_aResumo[_i,7],"@E 9,999,999,999,999.99")
		//_nTotalRet	+=	_aResumo[_i,3]
	Next
	//	
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