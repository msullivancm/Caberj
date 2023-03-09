#include "Protheus.ch"
#define CRLF Chr(13) + Chr(10)
#define MOEDA "@E 9999999.99"
#define DMED "DMED - Declara็ใo de servi็os m้dicos e Sa๚de"
#define MSGIGN " registro ignorado pelo ponto de entrada"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PLSM260  บAutor  ณMicrosiga           บ Data ณ  23/02/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Selecao e envio de informacoes referentes a DMED           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAPLS                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER Function cabr110()
Local nOpca     := 0
Local aSays     := {}
Local aButtons  := {}
Local cCadastro := DMED
Private cPerg   := "PLSM260"
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta texto para janela de processamento                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aAdd(aSays,"Gera็ใo do arquivo DMED")//Aplicacao de reducao de custo nas contas medicas
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta botoes para janela de processamento                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aAdd(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T.)}})
aAdd(aButtons, { 1,.T.,{|| nOpca := 1, If( ConaOk() .And. M260Perg(),FechaBatch(),nOpca := 0)}}) //Processamento
aAdd(aButtons, { 2,.T.,{|| FechaBatch()}})
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Exibe janela de processamento                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

FormBatch(cCadastro, aSays, aButtons, , 160)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processa importacao do arquivo texto                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nOpca == 1
    Processa( {||PLSM260Pro(cPerg) },DMED,"Processando...",.T. )
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSM260ProบAutor  ณMicrosiga                       บ Data ณ  02/23/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Selecao e envio de informacoes referentes a DMED, abaixo o layout da   บฑฑ
ฑฑบ          ณ da matriz a ser criada                                                 บฑฑ
ฑฑบ          ณ                                                                        บฑฑ
ฑฑบ          ณ aDMED                                                                  บฑฑ
ฑฑบ          ณ 1 - MV_PAR01 ( Ano referencia )                                        บฑฑ
ฑฑบ          ณ 2 - MV_PAR02 ( Ano calendario )                                        บฑฑ
ฑฑบ          ณ 3 - MV_PAR03 S - Retificadora;N - Original ( Indicador  retiricadora ) บฑฑ 
ฑฑบ          ณ 4 - MV_PAR04 ( Numero do recibo )                                      บฑฑ
ฑฑบ          ณ 5 - aRESPO															  บฑฑ
ฑฑบ          ณ 5.1 - MV_PAR05 ( Cpf )												  บฑฑ
ฑฑบ          ณ 5.2 - MV_PAR06 ( Nome )												  บฑฑ
ฑฑบ          ณ 5.3 - MV_PAR07 ( DDD )												  บฑฑ
ฑฑบ          ณ 5.4 - MV_PAR08 ( Telefone )											  บฑฑ
ฑฑบ          ณ 5.5 - MV_PAR09 ( Ramal )												  บฑฑ
ฑฑบ          ณ 5.6 - MV_PAR10 ( Fax )												  บฑฑ
ฑฑบ          ณ 5.7 - MV_PAR11 ( Email )												  บฑฑ
ฑฑบ          ณ 6 aDECPJ																  บฑฑ
ฑฑบ          ณ 6.1 - M0_CGC ( CNPJ )												  บฑฑ
ฑฑบ          ณ 6.2 - M0_NOMECOM ( Nome empresarial )								  บฑฑ
ฑฑบ          ณ 6.3 - 2 ( Tipo declarante )											  บฑฑ
ฑฑบ          ณ 6.4 - BA0_SUSEP ( Registro ANS )										  บฑฑ
ฑฑบ          ณ 6.5 - M0_CNES ( CNES )												  บฑฑ
ฑฑบ          ณ 6.6 - MV_PAR12 ( CPF responsavel pelo CNPJ )							  บฑฑ
ฑฑบ          ณ 6.7 - MV_PAR13 (S - Declaracao especial,N  - Nao e especial )		  บฑฑ
ฑฑบ          ณ 6.8 - MV_PAR14 ( Data do evento )									  บฑฑ
ฑฑบ          ณ 7 - aTOP																  บฑฑ
ฑฑบ          ณ 7.1 - BA1_CPFUSR ( BA1_TIPUSR = MV_PLCDTIT )							  บฑฑ
ฑฑบ          ณ 7.2 - BA1_NOMUSR ( Nome )											  บฑฑ
ฑฑบ          ณ 7.3 - BM1_VALOR ( Valor pago no ano com o titular )					  บฑฑ
ฑฑบ          ณ 7.4 - aRTOP															  บฑฑ
ฑฑบ          ณ 7.4.1 - BAU_CPFCGC - CPF/CNPJ do prestador de servico. BAU_TIPPE (F,J) บฑฑ
ฑฑบ          ณ 7.4.2 - BAU_NOME/BAU_NFANTA ( Nome/Fantasia do prestador de servico )  บฑฑ
ฑฑบ          ณ 7.4.3 - B44_VLRPAG ( Valor reembolso do ano calendario ) 			  บฑฑ
ฑฑบ          ณ 7.4.4 - B44_VLRPAG ( Valor reembolso de anos anteriores )			  บฑฑ
ฑฑบ          ณ 7.5 - aDTOP															  บฑฑ
ฑฑบ          ณ 7.5.1 - BA1_CPFUSR ( BA1_TIPUSR <> MV_PLCDTIT ) (CPF dependente)		  บฑฑ
ฑฑบ          ณ 7.5.2 - BA1_DATNAS ( Data nascimento )								  บฑฑ
ฑฑบ          ณ 7.5.3 - BA1_NOMUSR ( Nome )											  บฑฑ
ฑฑบ          ณ 7.5.4 - BA1_GRAUPA ( Relacao dependencia )							  บฑฑ
ฑฑบ          ณ 7.5.5 - Utilizacao ( Valor pago no ano com o dependente )			  บฑฑ
ฑฑบ          ณ 7.5.6 - aRDTOP														  บฑฑ
ฑฑบ          ณ 7.5.6.1 - BAU_CPFCGC ( CPF/CNPJ prestador de servico BAU_TIPPE (F,J)   บฑฑ
ฑฑบ          ณ 7.5.6.2 - BAU_NOME/BAU_NFANTA ( Nome/Fantasia do prestador de servico )บฑฑ
ฑฑบ          ณ 7.5.6.3 - B44_VLRPAG ( Valor reembolso do ano calendario )			  บฑฑ
ฑฑบ          ณ 7.5.6.4 - B44_VLRPAG ( Valor reembolso de anos anteriores )			  บฑฑ
ฑฑบ          ณ 8 - {} ( HSP )														  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAPLS                                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PLSM260Pro()
Local cCodTit  := GetNewPar("MV_PLCDTIT","T") // Codigo Identificador de titular do plano
Local cSUSEP   := "" // BA0->BA0_SUSEP - codigo de registro da operadora na ANS
Local cRelDep  := "" // Relacao de dependencia do beneficiario com o titular
Local cArqDmed := AllTrim(mv_par15) // path a ser concatenado para formar o nome do arquivo
Local cInicio,cTermino := "" // Data e horario do inicio e termino do processamento
//Variaves auxiliares utilizadas para aglutinar os valores do beneficiario por CPF
Local cCPFUsr := ""
Local cNomUsr := ""
Local cCodInt := ""
Local cCodEmp := ""
Local cMatric := ""
Local cTipReg := ""
Local cDigito := ""
Local cDtNasc := ""
Local nVlrUsr  := 0 // Valor declarado para o usuario
Local lUltGrv := .F. // Indicador de que ja processei o ultimo registro do arquivo TTOP
Local lUltReg   := .F. // Indicador de que o processamento chegou ao final do arquivo TTOP
Local aRetPto := {} // matriz para receber o retorno do ponto de entrada
Local lConReg := .T. // o registro posicionado sera considerado para escrita do arquivo
Local lTitZero := .F. // Indica se o titular tem valor = 0
Local aTitZero := {} // Dados do titular com valor = 0
private nRegua := 0 // Tamanho da regua       
private nProc  := 0 // Quantidade de registros processados
Private cArqLog := "PLSDMED_" + Dtos(dDataBase) + "_" + Replace(Time(),":","") + ".LOG" // Nome do arquivo de log da execucao
Private cCodEve := GetNewPar("MV_PLSEVDM","") // Codigos de eventos que nao serao considerados 

ProcessMessage()
Pergunte(cPerg,.F.)
nRegua := M260Regua(cCodTit)
ProcRegua(nRegua)
IncProc("Consultando registros a serem processados")

cArqDmed += AllTrim(SM0->M0_CGC) + "-Dmed-" + AllTrim(Str(mv_par01)) + "-" + AllTrim(Str(mv_par02)) + "-" + If(mv_par03 == 1,'ORIG','RETI') + "-" + If(mv_par03 == 1,'N','S') + ".txt"

cInicio := Dtos(dDataBase) + " " + Time()

FErase(cArqDmed)
nArqDmed := FCreate(cArqDmed)

If nArqDmed <= 0
	MsgInfo("Nใo foi possํvel criar o arquivo " + cArqDmed)
	Return .F.
EndIf

dbSelectArea("BA0")
BA0->(dbSetOrder(1))
If BA0->(dbSeek(xFilial("BA0")+PlsIntPad()))
	cSUSEP := AllTrim(BA0->BA0_SUSEP)
Else
	MsgInfo("N๚mero de registro da operadora na ANS nใo encontrado ou inดvalido." + CLRF +;
			"Operadora: " + PlsIntPad() + " - Num Reg ANS ( BA0_SUSEP ).")
	FClose(nArqDmed)
	FErase(nArqDmed)
	Return .F.
EndIf

PlsLogFil("Gera็ใo do arquivo DMED - Inํcio: " + Dtos(dDatabase) + " " + Time(),cArqLog)

//3.1 - Registro de informacao da declaracao ( identificador Dmed )
FWrite(nArqDmed,"Dmed|" +; // Identificador de registro
	AllTrim(Str(mv_par02)) + "|" +; // Ano referencia
	AllTrim(Str(mv_par01)) + "|" +; // Ano calendario
	If(mv_par03 == 1,'N','S') + "|" +; // Identificador de retificadora
	If(mv_par03 == 1,"",mv_par04) + "|" +; // Numero do recibo
	"L1101M|" + CRLF) // Identificador de estrutura do layout

//PlsLogFil("Gravado o registro Dmed",cArqLog)

//3.2 - Registro do responsavel pelo preenchimento ( identificador RESPO )
FWrite(nArqDmed,"RESPO" + "|" +; // Identificador de registro
	mv_par05 + "|" +; // CPF
	AllTrim(mv_par06) + "|" +; // Nome
	AllTrim(Str(mv_par07)) + "|" +; // DDD
	AllTrim(Str(mv_par08)) + "|" +; // Telefone
	AllTrim(Str(mv_par09)) + "|" +; // Ramal
	AllTrim(Str(mv_par10)) + "|" +; // Fax
	AllTrim(mv_par11) + "|" + CRLF ) // Email
	
//PlsLogFil("Gravado o registro RESPO",cArqLog)

//3.3 - Registro de informacao do declarante pessoa juridica ( identificador DECPJ )
FWrite(nArqDmed,"DECPJ|" +; //Identificador de registro
	SM0->M0_CGC + "|" +; // CNPJ
	AllTrim(SM0->M0_NOMECOM) + "|" +; // Nome
	AllTrim(Str(mv_par17)) + "|" +; // Tipo do declarante
	cSUSEP + "|" +; // Registro ANS
	/*SM0->M0_CNES +*/ "|" +; // CNES
	mv_par12 + "|" +; // CPF responsavel perante o CNPJ
	If(mv_par13 == 1,'S','N') + "|" +; // Indicador de situacao da declaracao
	If(mv_par13 == 1,Dtos(mv_par14),'') + "|" + CRLF ) // Data do evento
	
//PlsLogFil("Gravado o registro DECPJ",cArqLog)

//3.4 - Registro de informacao da operadora de plano privado de assistencia a saude ( identificador OPPAS )
FWrite(nArqDmed,"OPPAS|" + CRLF)
//PlsLogFil("Gravado o registro OPPAS",cArqLog)

cSqlTop := "SELECT BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO, BA1_NOMUSR,BA1_CPFUSR  ,ba1_tipusu,BA1_DATNAS , Sum(VALOR) valor "
cSqlTop += " FROM  " + RetSqlName("BA1") + " ba1 ,"
if  cEmpAnt == '01'
    cSqlTop += " ir_benef_separ_fat ir "
elseif    cEmpAnt == '02'            
    cSqlTop += " ir_benef_separ_int ir "
EndIF     

cSqlTop += " WHERE ANOBASEIR  = '"+ AllTrim(Str(mv_par01)) +"' "

cSqlTop += " AND CODINT = '0001'   "
cSqlTop += " AND CODEMP = '0003'   "
//cSqlTop += " AND MATRIC >= '036904' " // AND MATRIC <= '001016' "
//cSqlTop += " AND TIPREG = '00'     "
//cSqlTop += " AND DIGITO = '7'      "

cSqlTop += " AND CODINT = BA1_CODINT  "
cSqlTop += " AND CODEMP = BA1_CODEMP  "
cSqlTop += " AND MATRIC = BA1_MATRIC  "
cSqlTop += " AND TIPREG = BA1_TIPREG  "
cSqlTop += " AND DIGITO = BA1_DIGITO  "
cSqlTop += " AND BA1.D_E_L_E_T_ = ' ' "
cSqlTop += " AND BA1_FILIAL = '  '    "
 
cSqlTop += " AND BA1_CPFUSR <> ' '    "

cSqlTop += " AND BA1_TIPUSU = 'T'    "
cSqlTop += " GROUP BY BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_NOMUSR , BA1_CPFUSR ,ba1_tipusu, BA1_DATNAS "
cSqlTop += " ORDER BY To_Number (Trim (BA1_CPFUSR)) , BA1_DATNAS,  BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_CPFUSR , ba1_tipusu         "

cStmTop := ChangeQuery(cSqlTop)
//PlsLogFil("Query a ser executada " + Dtos(dDatabase) + " " + Time() + ":",cArqLog)
//PlsLogFil(cStmTop + CRLF,cArqLog)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStmTop),"TTOP",.F.,.T.)
//PlsLogFil("Execu็ใo finalizada as " + Dtos(dDatabase) + " " + Time(),cArqLog)
//// INCLUSAO PARA TRATAR COLABORADOR SEM MOVIMENTO FINANCEIRO EM 2010
cSqlTop1 := " SELECT BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO , BA1_NOMUSR , BA1_CPFUSR , ba1_tipusu , BA1_DATNAS "
cSqlTop1 += " FROM BA1010 ba1 "
cSqlTop1 += " WHERE BA1_CODINT = '0001' AND BA1_CODEMP = '0003' AND BA1.D_E_L_E_T_ = ' ' "
cSqlTop1 += " AND BA1_FILIAL = '  '   AND BA1_CPFUSR <> ' '   AND BA1_TIPUSU = 'T' "
cSqlTop1 += " AND ((BA1_IMAGE = 'ENABLE' AND BA1_DATINC < '20110101' )OR (BA1_IMAGE = 'DISABLE' AND BA1_DATBLO > '20100101' )) "
cSqlTop1 += " ORDER BY To_Number (Trim (BA1_CPFUSR)) , BA1_DATNAS,  BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_CPFUSR , ba1_tipusu "        
                     
cStmTop := ChangeQuery(cSqlTop1)
//PlsLogFil("Query a ser executada " + Dtos(dDatabase) + " " + Time() + ":",cArqLog)
//PlsLogFil(cStmTop + CRLF,cArqLog)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStmTop),"TTOP1",.F.,.T.)
/////////////////////


//Primeiro titular encontrado
if alltrim(TTOP->BA1_CPFUSR) <= alltrim(TTOP1->BA1_CPFUSR)
   cCPFUsr := TTOP->BA1_CPFUSR
   cNomUsr := AllTrim(TTOP->BA1_NOMUSR)
   nVlrUsr := TTOP->VALOR
   cCodInt := TTOP->BA1_CODINT
   cCodEmp := TTOP->BA1_CODEMP
   cMatric := TTOP->BA1_MATRIC
   cTipReg := TTOP->BA1_TIPREG     
   cDigito := TTOP->BA1_DIGITO
else         
   cCPFUsr := TTOP1->BA1_CPFUSR
   cNomUsr := AllTrim(TTOP1->BA1_NOMUSR) 
   nVlrUsr := 0.00
   cCodInt := TTOP1->BA1_CODINT
   cCodEmp := TTOP1->BA1_CODEMP
   cMatric := TTOP1->BA1_MATRIC
   cTipReg := TTOP1->BA1_TIPREG     
   cDigito := TTOP1->BA1_DIGITO
EndIf    
While !TTOP->(Eof()) .and. !TTOP->(Eof()) 
   IF TTOP->BA1_CODEMP = '0003'
      A:= 'b'
   ENDiF   
	nProc++
   	IncProc(AllTrim(Str(nProc)) + "/" + AllTrim(Str(nRegua)) + "  -  " + AllTrim(cNomUsr))
    cNomUsr:=consNome(cNomUsr)
	FWrite(nArqDmed,"TOP" + "|" +; // Identificador de registro
         AllTrim(cCPFUsr) + "|" +; // CPF do titular
  	              cNomUsr + "|" +; // Nome
         AllTrim(Replace(Transform(nVlrUsr,MOEDA),',','')) + "|" + CRLF) // Valor pago no ano com o titular

	
	//3.6 - Registro de informacao de reembolso do titular do plano ( identificador RTOP )
	M260Reemb("RTOP",AllTrim(Str(mv_par01)),cCodInt,cCodEmp,cMatric,cTipReg,cDigito,nProc,nRegua,cArqlog)
	
	//3.7 - Registro de informacao de dependente do titular ( identificador DTOP )

cSqlDtop := "SELECT BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO, BA1_NOMUSR," 
cSqlDtop += " CASE  WHEN  BA1_CPFUSR = '" +cCPFUsr +"' THEN CASE  WHEN BA1_DATNAS > '19921231' THEN ' ' ELSE BA1_CPFUSR END ELSE bA1_CPFUSR END bA1_CPFUSR ,"
cSqlDtop += "  BA1_DATNAS ,BA1_GRAUPA ,ba1_tipusu, Sum(VALOR) valor "  
cSqlDtop += "  FROM  " + RetSqlName("BA1") + " ba1 ,
if  cEmpAnt == '01'
    cSqlDtop += " ir_benef_separ ir "
elseif    cEmpAnt == '02'            
    cSqlDtop += " ir_benef_separ_int ir "
EndIF     
cSqlDtop += " WHERE ANOBASEIR  = '"+ AllTrim(Str(mv_par01)) +"' "  
cSqlDtop += " AND CODINT = '" + cCodInt + "' "
cSqlDtop += " AND CODEMP = '" + cCodEmp + "' "
cSqlDtop += " AND MATRIC = '" + cMatric + "' "
cSqlDtop += " AND CODINT = BA1_CODINT "  
cSqlDtop += " AND CODEMP = BA1_CODEMP " 
cSqlDtop += " AND MATRIC = BA1_MATRIC "  
cSqlDtop += " AND TIPREG = BA1_TIPREG "  
cSqlDtop += " AND DIGITO = BA1_DIGITO "

cSqlDtop += " AND ((BA1_CPFUSR <> ' ' ) or  (BA1_CPFUSR = ' ' AND (BA1_DATNAS > '19921231')))"   

cSqlDtop += " AND ((BA1_CPFUSR <>  '" +cCPFUsr +" ' ) or  (BA1_CPFUSR = '" +cCPFUsr +" ' AND (BA1_DATNAS > '19921231')))"

cSqlDtop += " AND BA1_TIPUSU <> '" + cCodTit + "' "
cSqlDtop += " AND BA1.D_E_L_E_T_ = ' ' " 
cSqlDtop += " AND BA1_FILIAL = '  '   "  
cSqlDtop += " GROUP by   BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO, BA1_NOMUSR, BA1_CPFUSR , BA1_DATNAS ,BA1_GRAUPA ,ba1_tipusu,BA1_DATNAS  "
cSqlDtop += " ORDER by   CASE  WHEN  BA1_CPFUSR = '" +cCPFUsr +"' THEN CASE  WHEN BA1_DATNAS > '19921231' THEN ' ' ELSE BA1_CPFUSR END ELSE bA1_CPFUSR END "
cSqlDtop += " , BA1_DATNAS , BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO             "
//To_Number (Trim (BA1_CPFUSR)) 


	cStmDtop := ChangeQuery(cSqlDtop)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStmDtop),"DTOP",.F.,.T.)
	
	While !DTOP->(Eof())

		cRelDep := M260GrPa(DTOP->BA1_GRAUPA) // Verifico a relacao do dependente com o titular
		if cCPFUsr != DTOP->BA1_CPFUSR
		   cCPFDep := DTOP->BA1_CPFUSR
		else 
		   cCPFDep := ""
		EndIf   
		cDtNasc := DTOP->BA1_DATNAS
		cNomDep := AllTrim(DTOP->BA1_NOMUSR)
		nVlrDep := DTOP->VALOR                                                                 
		
		
 
		If lConReg
		
 /*			If lTitZero // inicialmente eu nao gravo titular zerado, mas se o dependente teve valor preciso amarrar ele ao titular zerado mesmo
		     	aTitZero[1,2] := consnome(aTitZero[1,2])
				FWrite(nArqDmed,"TOP|"+; // Identificador de registro
					AllTrim(aTitZero[1,1]) + "|" +; // CPF do titular
					aTitZero[1,2] + "|" +; // Nome
					"0|" + CRLF) // dependente teve valor mas titular nao
					
 //				PlsLogFil("TOP - " + aTitZero[1,1] + " - " + AllTrim(aTitZero[1,2]),cArqLog)
				aTitZero := {}
				lTitZero := .F.
			EndIf
*/          cnomdep:=consnome(cnomdep)
			FWrite(nArqDmed,"DTOP|"+; // Identificador de registro
				AllTrim(cCPFDep) + "|" +; // CPF do dependente
				cDtNasc + "|" +; // Data de nascimento
				cNomDep + "|" +; // Nome
				cRelDep + "|" +; // Relacao de dependencia
				AllTrim(Replace(Transform(nVlrDep,MOEDA),',','')) + "|" + CRLF) // Valor pago no ano com o dependente

//			PlsLogFil("DTOP - " + cCPFDep + " - " + cNomDep,cArqLog)
//		Else
//			PlsLogFil("DTOP - " + cCPFDep + " - " + cNomDep + MSGIGN,cArqLog)
		EndIf
		
		//3.8 - Registro de informacao de reembolso do dependente ( identificador RDTOP )		
		M260Reemb("RDTOP",AllTrim(Str(mv_par01)),DTOP->BA1_CODINT,DTOP->BA1_CODEMP,DTOP->BA1_MATRIC,DTOP->BA1_TIPREG,DTOP->BA1_DIGITO,cArqlog)

		DTOP->(dbSkip())

    EndDo
	DTOP->(dbCloseArea())		
	If alltrim(TTOP->BA1_CPFUSR) <= alltrim(TTOP1->BA1_CPFUSR) 
	   TTOP->(dbSkip())                      
	   If alltrim(TTOP->BA1_CPFUSR) = alltrim(TTOP1->BA1_CPFUSR)                                              
          TTOP1->(dbSkip())	   
       EndIf       
    Else               
       TTOP1->(dbSkip())	             
    EndIF           
   	If alltrim(TTOP->BA1_CPFUSR) <= alltrim(TTOP1->BA1_CPFUSR)    
       cCPFUsr := TTOP->BA1_CPFUSR
       cNomUsr := AllTrim(TTOP->BA1_NOMUSR)
       nVlrUsr := TTOP->VALOR
       cCodInt := TTOP->BA1_CODINT
       cCodEmp := TTOP->BA1_CODEMP
       cMatric := TTOP->BA1_MATRIC
       cTipReg := TTOP->BA1_TIPREG     
       cDigito := TTOP->BA1_DIGITO
    Else         
       cCPFUsr := TTOP1->BA1_CPFUSR
       cNomUsr := AllTrim(TTOP1->BA1_NOMUSR) 
       nVlrUsr := 0.00
       cCodInt := TTOP1->BA1_CODINT
       cCodEmp := TTOP1->BA1_CODEMP
       cMatric := TTOP1->BA1_MATRIC
       cTipReg := TTOP1->BA1_TIPREG     
       cDigito := TTOP1->BA1_DIGITO
    EndIf         

EndDo

//Geracao da Dmed para beneficiarios com desconto em folha
//If mv_par16 == 1
//	M260GPE(nArqDmed,cCodTit,cArqlog)
//EndIf

TTOP->(dbCloseArea())  
//3.12 - Registro identificador do termino da declaracao ( identificador FIMDmed )
FWrite(nArqDmed,"FIMDmed|" + CRLF)
FClose(nArqDmed)
cTermino := Dtos(dDataBase) + " " + Time()
//PlsLogFil("Arquivo para envio da DMED gerado com sucesso!" + CRLF + cArqDmed + CRLF + "Inicio: " + cInicio + "  - Termino: " + cTermino,cArqLog)
MsgInfo("Arquivo para envio da DMED gerado com sucesso!" + CRLF + cArqDmed + CRLF + "Inicio: " + cInicio + "  - Termino: " + cTermino)
      
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณM260Reem  บAutor  ณMicrosiga           บ Data ณ  03/03/11                             บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao criada para escrever no arquivo DMED os valores de reembolso dos registros:    บฑฑ
ฑฑบ          ณ                                                                                      บฑฑ
ฑฑบ          ณ3.6 - Registro de informacao de reembolso do titular do plano ( identificador RTOP )  บฑฑ
ฑฑบ          ณ3.8 - Registro de informacao de reembolso do dependente ( identificador RDTOP )       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSIGAPLS                                                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function M260Reemb(cRegistro,cAno,cCodInt,cCodEmp,cMatric,cTipReg,cDigito,cArqlog)
Local lNewReem := If(GetNewPar("MV_PLSREDM","1") == "1",.T.,.F.) // Utilizar nova rotina de reembolso ( PLSA001 ) para DMED ?
Local lConReg := .T. // o registro posicionado sera considerado para escrita do arquivo
Local aRetPto := {} // matriz para receber o retorno do ponto de entrada
Local cReeCPF := "" // CPF / CNPJ do prestador de servico
Local cReeNom := "" // Nome do prestador de servico
Local nReeVlr := 0 // Valor do reembolso                                                      

//cSql := " SELECT   trim (BB0_CGC) CPFCGC,  trim (BB0_NOME) NOME ,  SUM(c.B44_VLRPAG) VALOR "  
                                                                                                   
//cSql := " SELECT   trim (PAK_CPF) CPFCGC,  trim (PAK_NOME) NOME ,  SUM(c.B44_VLRPAG) VALOR "   
cSql := " SELECT   trim (PAK_CPF) CPFCGC,    SUM(c.B44_VLRPAG) VALOR "  
cSql += "   FROM " + RetSqlName("ZZQ") + " P ," 
cSql += " " + RetSqlName("B44") + " C ," 

cSql += " "+ RetSqlName("SE1") + " SE1 ," 
cSql += " "+ RetSqlName("BA1") + " U ," 
//cSql += " "+ RetSqlName("bb0") + " BB0 "  

cSql += " "+ RetSqlName("pak") + " PAK "

cSql += "  WHERE B44_FILIAL = '" + xFilial("B44") + "'"
cSql += "    AND ZZQ_FILIAL = '" + xFilial("ZZQ") + "'"
cSql += "    AND BA1_FILIAL = '" + xFilial("BA1") + "'"
cSql += "    AND E1_FILIAL  = '" + xFilial("SE1") + "'"  

cSql += "    AND PAK_FILIAL  = '" + xFilial("PAK") + "'"   


//cSql += "    AND BB0_FILIAL = '" + xFilial("BB0") + "'"

cSql += "    AND ZZQ_SEQUEN = B44_YCDPTC "
cSql += "    AND ZZQ_STATUS = '3'        "
// 
cSql += "    AND B44_OPEUSR = '" + cCodInt + "'"
cSql += "    AND B44_CODEMP = '" + cCodEmp + "'"
cSql += "    AND B44_MATRIC = '" + cMatric + "'"
cSql += "    AND B44_TIPREG = '" + cTipReg + "'"
cSql += "    AND B44_DIGITO = '" + cDigito + "'"
//                                            
//cSql += "    AND  b44_regexe <> ' '   "
//cSql += "    AND BB0_NUMCR  = b44_regexe   "
//cSql += "    AND BB0_CGC	 <>  ' '       "
cSql += "    AND B44_PREFIX = E1_PREFIXO   "
cSql += "    AND B44_NUM    = E1_NUM       "                   
cSql += "    AND  B44_PARCEL = E1_PARCELA  "
cSql += "    AND B44_TIPO =    E1_TIPO "

cSql += "    AND U.BA1_CODINT = B44_OPEUSR "
cSql += "    AND U.BA1_CODEMP = B44_CODEMP "
cSql += "    AND U.BA1_MATRIC = B44_MATRIC "
cSql += "    AND U.BA1_TIPREG = B44_TIPREG "
cSql += "    AND E1_BAIXA BETWEEN  '20100101'  AND '20101231' "
cSql += "    AND P.D_E_L_E_T_   = ' ' AND  C.D_E_L_E_T_ = ' ' "
cSql += "    AND SE1.D_E_L_E_T_ = ' ' AND  U.D_E_L_E_T_ = ' ' AND  PAK.D_e_l_e_t_ = ' ' "

cSql += "    AND B44_YCDPTC     =  PAK_PROTOC  "
             
//cSql += " GROUP BY  to_number (trim (PAK_CPF)) ,  trim (PAK_NOME) "
//cSql += " ORDER BY  to_number (trim (PAK_CPF)) ,  trim (PAK_NOME)  "  
cSql += " GROUP BY  trim (PAK_CPF) "
cSql += " ORDER BY  to_number (trim (PAK_CPF))   "
 

cStm := ChangeQuery(cSql)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStm),"REEM",.F.,.T.)

/// 
If !REEM->(Eof())  
    cSql1:= " SELECT   to_number (trim (PAK_CPF)) CPFCGC, trim (PAK_NOME) NOME, SUM(c.B44_VLRPAG) VALOR "  
    cSql1 += "   FROM " + RetSqlName("ZZQ") + " P ," 
    cSql1+= " " + RetSqlName("B44") + " C ," 

    cSql1 += " "+ RetSqlName("SE1") + " SE1 ," 
    cSql1 += " "+ RetSqlName("BA1") + " U ," 
    cSql1 += " "+ RetSqlName("pak") + " PAK "

    cSql1 += "  WHERE B44_FILIAL = '" + xFilial("B44") + "'"
    cSql1 += "    AND ZZQ_FILIAL = '" + xFilial("ZZQ") + "'"
    cSql1 += "    AND BA1_FILIAL = '" + xFilial("BA1") + "'"
    cSql1 += "    AND E1_FILIAL  = '" + xFilial("SE1") + "'"  
    
    cSql1 += "    AND PAK_FILIAL  = '" + xFilial("PAK") + "'"   

    cSql1 += "    AND ZZQ_SEQUEN = B44_YCDPTC "
    cSql1 += "    AND ZZQ_STATUS = '3'        "
// 
    cSql1 += "    AND B44_OPEUSR = '" + cCodInt + "'"
    cSql1 += "    AND B44_CODEMP = '" + cCodEmp + "'"
    cSql1 += "    AND B44_MATRIC = '" + cMatric + "'"
    cSql1 += "    AND B44_TIPREG = '" + cTipReg + "'"
    cSql1 += "    AND B44_DIGITO = '" + cDigito + "'"
//                                            
    cSql1 += "    AND B44_PREFIX = E1_PREFIXO   "
    cSql1 += "    AND B44_NUM    = E1_NUM       "                   
    cSql1 += "    AND  B44_PARCEL = E1_PARCELA  "
    cSql1 += "    AND B44_TIPO =    E1_TIPO "

    cSql1 += "    AND U.BA1_CODINT = B44_OPEUSR "
    cSql1 += "    AND U.BA1_CODEMP = B44_CODEMP "
    cSql1 += "    AND U.BA1_MATRIC = B44_MATRIC "
    cSql1 += "    AND U.BA1_TIPREG = B44_TIPREG "
    cSql1 += "    AND E1_BAIXA BETWEEN  '20100101'  AND '20101231' "
    cSql1 += "    AND P.D_E_L_E_T_   = ' ' AND  C.D_E_L_E_T_ = ' ' "
    cSql1 += "    AND SE1.D_E_L_E_T_ = ' ' AND  U.D_E_L_E_T_ = ' ' AND  PAK.D_e_l_e_t_ = ' ' "

    cSql1 += "    AND B44_YCDPTC     =  PAK_PROTOC  "
             
//cSql += " GROUP BY  to_number (trim (PAK_CPF)) ,  trim (PAK_NOME) "
//cSql += " ORDER BY  to_number (trim (PAK_CPF)) ,  trim (PAK_NOME)  "  
   cSql1 += " GROUP BY  to_number (trim (PAK_CPF)) , trim (PAK_NOME)"
   cSql1 += " ORDER BY  to_number (trim (PAK_CPF)) , trim (PAK_NOME)  "
 
   cStm := ChangeQuery(cSql1)
   dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStm),"REE1",.F.,.T.)    
 //  cReeNom := AllTrim(REE1->NOME)  
   cReeNom := AllTrim(REE1->NOME)    
   REE1->(dbCloseArea())
EndIf 
//

While !REEM->(Eof())

	IncProc(AllTrim(Str(nProc)) + "/" + AllTrim(Str(nRegua)) + "  -  Verificando reembolso")

	cReeCPF :=REEM->CPFCGC
   //	cReeNom := AllTrim(REE1->NOME)
	nReeVlr := REEM->VALOR
	lConReg := .T.
 
//	If ExistBlock("PLSM260")
//		aRetPto := ExecBlock("PLSM260",.F.,.F.,{cRegistro,cReeCPF,cReeNom,nReeVlr,cCodInt+cCodEmp+cMatric+cTipReg+cDigito})
//		cReeCPF := aRetPto[1]
//		cReeNom := aRetPto[2]
//		nReeVlr := aRetPto[3]
//		lConReg := If(Len(aRetPto) >= 4,aRetPto[4],.T.)
//	EndIf
         
	If lConReg
        cReeNom:=consnome(cReeNom)
		FWrite(nArqDmed,cRegistro + "|" +; // Identificador de registro
	    alltrim(cReeCPF) + "|" +; // CPF / CNPJ do prestador de servico
		cReeNom + "|" +; // Nome / nome empresarial do prestador de servico
		AllTrim(Replace(Transform(nReeVlr,MOEDA),',','')) + "|" +; // Valor do reembolso do ano-calendario
		'0|' + CRLF) // Valor do reembolso de anos anteriores

//		PlsLogFil(cRegistro + " - " + Alltrim(str(cReeCPF)) + " - " + cReeNom,cArqLog)
//	Else
//		PlsLogFil(cRegistro + " - " + Alltrim(str(cReeCPF)) + " - " + cReeNom + MSGIGN,cArqLog)
	EndIf

	REEM->(dbSkip())

EndDo
REEM->(dbCloseArea())

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ M260Perg บAutor  ณMicrosiga           บ Data ณ  03/21/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao criada para validar o preenchimento das perguntas   บฑฑ
ฑฑบ          ณ SX1                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAPLS                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function M260Perg()
Local lRet := .T.
Local cMsg := ""

If Empty(mv_par01)
	lRet := .F.
	cMsg := "Ano de refer๊ncia" + CRLF
EndIf

If Empty(mv_par02)
	lRet := .F.
	cMsg += "Ano calendแrio" + CRLF
EndIf

If Empty(mv_par05)
	lRet := .F.
	cMsg += "CPF do responsแvel" + CRLF
EndIf

If Empty(mv_par06) 
	lRet := .F.
	cMsg += "Nome do responsแvel" + CRLF
EndIf

If Empty(mv_par07) 
	lRet := .F.
	cMsg += "DDD do responsแvel" + CRLF
EndIf

If Empty(mv_par08) 
	lRet := .F.
	cMsg += "Telefone do responsแvel" + CRLF
EndIf

If Empty(mv_par12) 
	lRet := .F.
	cMsg += "CPF declarante" + CRLF
EndIf

If !lRet
	MsgInfo("Informe os parโmetros: " + CRLF  + CRLF + cMsg)
EndIf

Return lRet               
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSM260   บAutor  ณaltamiro	         บ Data ณ  31/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณremove carracteres invalidos do nomes                       บฑฑ
ฑฑบ          |                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณdmed                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION ConsNome(cReeNom)
PRIVATE lverde := .T.
PRIVATE nnumro := 0
PRIVATE x  := 1   
//private num := "0123456789ABXCDEFGHIJLMNOPQRSTUVXZabcdefghiflmnopqrstuvxz*"
x:= 1  
a:=''  
while x <= len(cReeNom)    
//while x <= len(num) 
//     if lverde
        if (substr(cReeNom ,x , 1)) $ ".|-|_|/|'|=|:"  
            a+=' '
        elseif (substr(cReeNom ,x , 1)) $ "0"  
            a+='O'
        else 
            a+= substr(cReeNom ,x , 1) 
        endIf    
       // nnumro:= Asc (substr(num,x , 1))
      //  lverde := ( ( nnumro = 32) .or. ( nnumro > 47 .and. nnumro < 58 ) .or.  ( nnumro > 64 .and. nnumro < 91 ) .or. ( nnumro > 96 .and. nnumro < 123 ) ) 
    // endif    
    // if  Empty(M->e2_num) .or. !lverde
       // ALERT ("Caractere Invalida na Composi็ใo do Campo ")   
      //  x :=  len(M->e2_num)     
      //  lverde := .F.
    // endif
     x++
enddo
Return(a)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSM260   บAutor  ณMicrosiga           บ Data ณ  03/17/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณContagem de registros para montagem da regua                บฑฑ
ฑฑบ          |                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSIGAPLS                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function M260Regua(cCodTit)
Local nRet := 0   


cSql := "SELECT COUNT (*) QTDE from (SELECT COUNT(*)  "
cSql += " FROM  " + RetSqlName("BA1") + " ba1 ,"
if  cEmpAnt == '01'
    cSql += " ir_benef_separ ir "
elseif    cEmpAnt == '02'            
    cSql += " ir_benef_separ_int ir "
EndIF     

cSql += " WHERE ANOBASEIR  = '"+ AllTrim(Str(mv_par01)) +"' "

cSql += " AND CODINT = BA1_CODINT  "
cSql += " AND CODEMP = BA1_CODEMP  "
cSql += " AND MATRIC = BA1_MATRIC  "
cSql += " AND TIPREG = BA1_TIPREG  "
cSql += " AND DIGITO = BA1_DIGITO  "
cSql += " AND BA1.D_E_L_E_T_ = ' ' "
cSql += " AND BA1_FILIAL = '  '    "
 
cSql += " AND BA1_CPFUSR <> ' '    "

cSql += " AND BA1_TIPUSU = 'T'    "       
cSql += " GROUP BY BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_NOMUSR , BA1_CPFUSR ,ba1_tipusu, BA1_DATNAS ) TAB1 "
//cSql += " ORDER BY To_Number (Trim (BA1_CPFUSR)) , BA1_DATNAS,  BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_CPFUSR , ba1_tipusu         "




//cSql := "SELECT COUNT(1) QTDE FROM " + RetSqlName("BA1") + " WHERE D_E_L_E_T_ = ' ' AND BA1_FILIAL = '" + xFilial("BA1") + "' AND BA1_TIPUSU = '" + cCodTit + "'"
cStm := ChangeQuery(cSql)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStm),"TRAB",.F.,.T.)
nRet := TRAB->QTDE
TRAB->(dbCloseArea())

Return nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ M260GPE  บAutor  ณMicrosiga           บ Data ณ  03/17/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao criada para informar na Dmed os valores de beneficia-บฑฑ
ฑฑบ          ณcom desconto em folha                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSIGAPLS                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function M260GPE(nArqDmed,cCodTit,cArqlog)
Local cVerDem := GetNewPar("MV_PLSVEDM","")
Local cSqlGPE := "" // Query titular
Local cStmGPE := "" // Query titular  
Local cSqlDGP := "" // Query dependente
Local cStmDGP := "" // Query dependente
Local cRelDep := "" // Relacao de dependente com o titular
Local cCPFUsr := "" // CPF do titular
Local cCPFDep := "" // CPF do dependente
Local cNomUsr := "" // Nome do titular
Local cNomDep := "" // Nome do dependente 
Local cCodInt := "" // Operadora
Local cCodEmp := "" // Empresa
Local cMatric := "" // Matricula
Local cTipReg := "" // Tipo de registro
Local cDigito := "" // Digito
Local cDtNasc := "" // Data de nascimento do dependente
Local nVlrUsr := 0 // Valor declarado para o titular
Local nVlrDep := 0 // Valor declarado para o dependente

IncProc("Processando beneficiแrios com desconto em folha")

//3.5 - Registro de informacao do titular do plano ( identificador TOP )
cSqlGPE := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO, BA1_CPFUSR, BA1_NOMUSR, Sum(CASE BM1_TIPO WHEN '1' THEN BM1_VALOR ELSE -BM1_VALOR END) BM1_VALOR "
cSqlGPE += "FROM " + RetSqlName("BM1") + ", " + RetSqlName("B1T") + ", " + RetSqlName("BA1") + " "
cSqlGPE += "WHERE BM1_FILIAL = '" + xFilial("BM1") + "' AND B1T_FILIAL = '" + xFilial("B1T") + "' AND BA1_FILIAL = '" + xFilial("BA1") + "' "
cSqlGPE += "AND BM1_FILIAL = BA1_FILIAL AND BM1_CODINT = BA1_CODINT AND BM1_CODEMP = BA1_CODEMP AND BM1_MATRIC = BA1_MATRIC AND BM1_TIPREG = BA1_TIPREG AND BM1_DIGITO = BA1_DIGITO "
cSqlGPE += "AND BM1_CODINT = B1T_CODINT AND BM1_CODEMP = B1T_CODEMP AND BM1_MATRIC = B1T_MATRIC AND BM1_ANO = B1T_ANO AND BM1_MES = B1T_MES AND BM1_VERSIG = B1T_VERSIG "
cSqlGPE += "AND ( (BM1_ANO = '" + AllTrim(Str(mv_par02)) + "' AND BM1_MES >= '02') OR (BM1_ANO = '" + AllTrim(Str(mv_par01)) + "' AND BM1_MES = '01')) "
If !Empty(AllTrim(cVerDem))
	cVerDem := "'" + Replace(AllTrim(cVerDem),",","','") + "'"
	cSqlGPE += "AND BM1_CODTIP NOT IN (" + cVerDem + ") "
EndIf
If !Empty(AllTrim(cCodEve)) //MV_PLSEVDM Codigos de eventos que nao serao considerados 
	cSqlTop += "AND BM1_CODEVE NOT IN (" + cCodEve + ") "
EndIf     
cSqlGPE += "AND  BA1_CPFUSR <> ' ' "
cSqlGPE += "AND BA1_TIPUSU = '" + cCodTit + "' "
cSqlGPE += "AND " + RetSqlName("BM1") + ".D_E_L_E_T_ = ' ' AND " + RetSqlName("B1T") + ".D_E_L_E_T_ = ' ' AND " + RetSqlName("BA1") + ".D_E_L_E_T_ = ' ' "
cSqlGPE += "GROUP BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO,BA1_CPFUSR, BA1_NOMUSR "
cSqlGPE += "ORDER BY To_Number (Trim (BA1_CPFUSR))"           
                  

cStmGPE := ChangeQuery(cSqlGPE)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStmGPE),"DGPE",.F.,.T.)

While !DGPE->(Eof())

	IncProc("Colaborador: " + AllTrim(DGPE->BA1_NOMUSR))

	cCPFUsr := DGPE->BA1_CPFUSR
	nVlrUsr := DGPE->BM1_VALOR
	cNomUsr := AllTrim(DGPE->BA1_NOMUSR)
	cCodInt := DGPE->BM1_CODINT
	cCodEmp := DGPE->BM1_CODEMP
	cMatric := DGPE->BM1_MATRIC
	cTipReg := DGPE->BM1_TIPREG
	cDigito := DGPE->BM1_DIGITO	

//	If ExistBlock("PLSM260")
//		aRetPto := ExecBlock("PLSM260",.F.,.F.,{'TOP',cCPFUsr,cNomUsr,nVlrUsr,cCodInt+cCodEmp+cMatric+cTipReg+cDigito})
//		cCPFUsr := aRetPto[1]
//		cNomUsr := aRetPto[2]
//		nVlrUsr := aRetPto[3]
//		lConReg := If(Len(aRetPto) >= 4,aRetPto[4],.T.)
//	EndIf	
    cNomUsr:= consnome(cNomUsr)
	FWrite(nArqDmed,"TOP" + "|" +; // Identificador de registro
		AllTrim(cCPFUsr) + "|" +; // CPF do titular
		AllTrim(cNomUsr) + "|" +; // Nome
		AllTrim(Replace(Transform(nVlrUsr,MOEDA),',','')) + "|" + CRLF) // Valor pago no ano com o titular	
		
//	PlsLogFil("TOP - " + cCPFUsr + " - " + AllTrim(cNomUsr),cArqLog)
	
	//3.6 - Registro de informacao de reembolso do titular do plano ( identificador RTOP )
	M260Reemb("RTOP",AllTrim(Str(mv_par01)),DGPE->BM1_CODINT,DGPE->BM1_CODEMP,DGPE->BM1_MATRIC,DGPE->BM1_TIPREG,DGPE->BM1_DIGITO,cArqlog)	

	//3.7 - Registro de informacao de dependente do titular ( identificador DTOP )	
	cSqlDGP := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO, "
	cSqlDGP += " CASE  WHEN  BA1_CPFUSR = '" +cCPFUsr +"' THEN CASE  WHEN BA1_DATNAS > '19921231' THEN ' ' ELSE BA1_CPFUSR END ELSE bA1_CPFUSR END bA1_CPFUSR ,"

	cSqlDGP += " BA1_NOMUSR, BA1_DATNAS, BA1_GRAUPA, Sum(BM1_VALOR) BM1_VALOR "
	cSqlDGP += "FROM " + RetSqlName("BM1") + ", " + RetSqlName("B1T") + ", " + RetSqlName("BA1") + " "
	cSqlDGP += "WHERE BM1_FILIAL = '" + xFilial("BM1") + "' AND B1T_FILIAL = '" + xFilial("B1T") + "' AND BA1_FILIAL = '" + xFilial("BA1") + "' "
	cSqlDGP += "AND BM1_FILIAL = BA1_FILIAL AND BM1_CODINT = BA1_CODINT AND BM1_CODEMP = BA1_CODEMP AND BM1_MATRIC = BA1_MATRIC AND BM1_TIPREG = BA1_TIPREG AND BM1_DIGITO = BA1_DIGITO "
	cSqlDGP += "AND BM1_CODINT = B1T_CODINT AND BM1_CODEMP = B1T_CODEMP AND BM1_MATRIC = B1T_MATRIC AND BM1_ANO = B1T_ANO AND BM1_MES = B1T_MES AND BM1_VERSIG = B1T_VERSIG "
	cSqlDGP += "AND BM1_CODINT = '" + DGPE->BM1_CODINT + "' AND BM1_CODEMP = '" + DGPE->BM1_CODEMP + "' AND BM1_MATRIC = '" + DGPE->BM1_MATRIC + "' "
	cSqlDGP += "AND ( (BM1_ANO = '" + AllTrim(Str(mv_par02)) + "' AND BM1_MES >= '02') OR (BM1_ANO = '" + AllTrim(Str(mv_par01)) + "' AND BM1_MES = '01')) "
	cSqlDGP += "AND BA1_TIPUSU <> '" + cCodTit + "' AND BM1_TIPO = '1' "
	If !Empty(AllTrim(cVerDem))
		cSqlDGP += " AND BM1_CODTIP NOT IN (" + cVerDem + ") "
	EndIf
	If !Empty(AllTrim(cCodEve)) //MV_PLSEVDM Codigos de eventos que nao serao considerados 
		cSqlDGP += " AND BM1_CODEVE NOT IN (" + cCodEve + ") "
	EndIf
	cSqlDGP += "AND BA1_DATNAS <=  '20101231' "
	
cSqlDGP += " AND ((BA1_CPFUSR <> ' ' ) or  (BA1_CPFUSR = ' ' AND (BA1_DATNAS > '19921231')))"   

cSqlDGP += " AND ((BA1_CPFUSR <>  '" +cCPFUsr +" ' ) or  (BA1_CPFUSR = '" +cCPFUsr +" ' AND (BA1_DATNAS > '19921231')))"

		
	cSqlDGP += " AND " + RetSqlName("BM1") + ".D_E_L_E_T_ = ' ' AND " + RetSqlName("B1T") + ".D_E_L_E_T_ = ' ' AND " + RetSqlName("BA1") + ".D_E_L_E_T_ = ' ' "
	cSqlDGP += " GROUP BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO, BA1_CPFUSR , BA1_NOMUSR, BA1_DATNAS, BA1_GRAUPA "                         
    cSqlDGP += " ORDER by CASE  WHEN  BA1_CPFUSR = '" +cCPFUsr +"' THEN CASE  WHEN BA1_DATNAS > '19921231' THEN ' ' ELSE BA1_CPFUSR END ELSE bA1_CPFUSR END  , BA1_DATNAS " 

//	cSqlDGP += "ORDER BY To_Number (Trim (BA1_CPFUSR))"

	cStmDGP := ChangeQuery(cSqlDGP)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStmDGP),"DDGP",.F.,.T.)
	
	While !DDGP->(Eof())

		IncProc("Dependente: " + AllTrim(DDGP->BA1_NOMUSR))
	
		cRelDep := M260GrPa(DDGP->BA1_GRAUPA)   
		if cCPFUsr != DDGP->BA1_CPFUSR // DTOP-> marcela
		   cCPFDep := DDGP->BA1_CPFUSR
		else 
		   cCPFDep := ""
		EndIf   
		
		//cCPFDep := DDGP->BA1_CPFUSR
		cDtNasc := DDGP->BA1_DATNAS
		cNomDep := AllTrim(DDGP->BA1_NOMUSR)
		nVlrDep := DDGP->BM1_VALOR

		If ExistBlock("PLSM260")
			aRetPto := ExecBlock("PLSM260",.F.,.F.,{"DTOP",cCPFDep,cDtNasc,cNomDep,nVlrDep,DDGP->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO)})
			cCPFDep := aRetPto[1]
			cDtNasc := aRetPto[2]
			cNomDep := aRetPto[3]
			nVlrDep := aRetPto[4]			
			lConReg := If(Len(aRetPto) >= 5,aRetPto[5],.T.)
		EndIf
	    cNomDep := consnome(cNomDep)
		FWrite(nArqDmed,"DTOP|"+; // Identificador de registro
			AllTrim(cCPFDep) + "|" +; // CPF do dependente
			AllTrim(cDtNasc) + "|" +; // Data de nascimento
			AllTrim(cNomDep) + "|" +; // Nome
			cRelDep + "|" +; // Relacao de dependencia
			AllTrim(Replace(Transform(nVlrDep,MOEDA),',','')) + "|" + CRLF) // Valor pago no ano com o dependente
		
//		PlsLogFil("DTOP - " + cCPFDep + " - " + AllTrim(cNomDep),cArqLog)

		//3.8 - Registro de informacao de reembolso do dependente ( identificador RDTOP )		
		M260Reemb("RDTOP",AllTrim(Str(mv_par01)),DDGP->BM1_CODINT,DDGP->BM1_CODEMP,DDGP->BM1_MATRIC,DDGP->BM1_TIPREG,DDGP->BM1_DIGITO,cArqlog)
		
		DDGP->(dbSkip())
	
	EndDo
	DDGP->(dbCloseArea())
	
	DGPE->(dbSkip())

EndDo
DGPE->(dbCloseArea())

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณM260GrPa  บAutor  ณMicrosiga           บ Data ณ  03/17/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao criada para retornar o grau de parentesco do beneficiบฑฑ
ฑฑบ          ณa ser informado para a Dmed                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSIGAPLS                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function M260GrPa(cGrpPau)
Local cRet := ""

dbSelectArea("BRP")
BRP->(dbSetOrder(1))

If BRP->(dbSeek(xFilial("BRP")+cGrpPau))
	cRet := BRP->BRP_CODSIB
Else
	Do Case
		Case cGrpPau == '03'
			cRet := '03'
		Case cGrpPau $ '04,05'
			cRet := '04'
		Case cGrpPau $ '06,07'
			cRet := '06'
		Case cGrpPau $ '08,09'
			cRet := '08'
		Case cGrpPau $ '10,11'
			cRet := '10'
		OtherWise
			cRet := '10'
	EndCase
EndIf

Return cRet