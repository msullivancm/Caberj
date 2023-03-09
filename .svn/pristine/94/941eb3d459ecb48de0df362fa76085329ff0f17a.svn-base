#Include "Topconn.ch"    
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
USER Function cabr110c()
Local nOpca     := 0
Local aSays     := {}
Local aButtons  := {}
Local cCadastro := DMED
Private cPerg   := "PLSM260"     
private admedt   := {} 
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
private cCodTit  := GetNewPar("MV_PLCDTIT","T") // Codigo Identificador de titular do plano
private cSUSEP   := "" // BA0->BA0_SUSEP - codigo de registro da operadora na ANS
private cRelDep  := " " // Relacao de dependencia do beneficiario com o titular
private cArqDmed := AllTrim(mv_par15) // path a ser concatenado para formar o nome do arquivo
private cInicio,cTermino := "" // Data e horario do inicio e termino do processamento
//Variaves auxiliares utilizadas para aglutinar os valores do beneficiario por CPF   
private cNomDep := ""
private cCPFUsr := "" 
private cCPFDep := ""
private cNomUsr := ""  
private cMtVidT := "" 
private cMtVidd := ""
private cCodInt := ""
private cCodEmp := ""
private cMatric := ""
private cTipReg := ""
private cDigito := ""
private cDtNasc := ""   
private cCPFPre := "" 
private cNomPre := ""
private nVlrUsr := 0 // Valor declarado para o usuario
private lUltGrv := .F. // Indicador de que ja processei o ultimo registro do arquivo TTOP
private lUltReg := .F. // Indicador de que o processamento chegou ao final do arquivo TTOP
private aRetPto := {} // matriz para receber o retorno do ponto de entrada
private lConReg := .T. // o registro posicionado sera considerado para escrita do arquivo
private lTitZero:= .F. // Indica se o titular tem valor = 0
private aTitZero:= {} // Dados do titular com valor = 0
private nRegua  := 0 // Tamanho da regua       
private nProc   := 0 // Quantidade de registros processados
Private cArqLog := "PLSDMED_" + Dtos(dDataBase) + "_" + Replace(Time(),":","") + ".LOG" // Nome do arquivo de log da execucao
Private cCodEve := GetNewPar("MV_PLSEVDM","") // Codigos de eventos que nao serao considerados 
private nVlFam  := 0.00
private lPvez   := .T.
private nPontV  := 0
private cCPFUsr := "" 
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
	"      |" + CRLF)    // Identificador de estrutura do layout - descontinuado em 2019
    //  "S5830B|" + CRLF)    // Identificador de estrutura do layout 2017    
	//"P8915U|" + CRLF)    // Identificador de estrutura do layout 2016
    // "L9368Z|" + CRLF) // Identificador de estrutura do layout 2015
	// "S8859L|" + CRLF) // Identificador de estrutura do layout 2014
    // "D2013L|" + CRLF) // Identificador de estrutura do layout 2013
    // "R2609P|" + CRLF) // Identificador de estrutura do layout 2012

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
	If(mv_par13 == 1,Dtos(mv_par14),'') + "|S|" + CRLF ) // Data do evento
	
//PlsLogFil("Gravado o registro DECPJ",cArqLog)

//3.4 - Registro de informacao da operadora de plano privado de assistencia a saude ( identificador OPPAS )
FWrite(nArqDmed,"OPPAS|" + CRLF)
//PlsLogFil("Gravado o registro OPPAS",cArqLog)

cSqlTop := "SELECT BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO, REM_TODOS_CARACTERS_ESPEC(BA1_NOMUSR) BA1_NOMUSR, BA1_CPFUSR  ,ba1_tipusu,BA1_DATNAS ,BA1_MATVID,  Sum(VALOR) valor "
cSqlTop += " FROM  " + RetSqlName("BA1") + " ba1 ,"
if  cEmpAnt == '01'
    cSqlTop += " ir_benef_separ_fat ir "
elseif    cEmpAnt == '02'            
    cSqlTop += " ir_benef_separ_int ir "
EndIF     
cSqlTop += " WHERE ANOBASEIR  = '"+ AllTrim(Str(mv_par01)) +"' "
//daki   
//cSqlTop += " AND CODINT  =  '0001' "   
////////////                                  
cSqlTop += " AND ba1_CODINT = '0001'   "
//cSqlTop += " AND ba1_CODEMP = '0001'   "
//cSqlTop += " AND ba1_MATRIC IN ('011668')  " 
//////////                                 
//cSqlTop += " AND ba1_CODEMP = '0005'   "
//cSqlTop += " AND CODINT||CODEMP || MATRIC || TIPREG in ('0001000200663900','0001002400000100','0001002400000200','0001002400000300','0001000201907100','0001002400000600','0001002500005100','0001000104080600')     "
//cSqlTop += " AND DIGITO = '6'      "
//akki                                    

//cSqlTop += " AND ba1_CODEMP >= '0013' AND ba1_CODEMP <= '0013'  "   // aki 2018 - altamiro	 19/03/2018 so teste                                                           

cSqlTop += " AND CODINT = BA1_CODINT  "
cSqlTop += " AND CODEMP = BA1_CODEMP  "
cSqlTop += " AND MATRIC = BA1_MATRIC  "
cSqlTop += " AND TIPREG = BA1_TIPREG  "
cSqlTop += " AND DIGITO = BA1_DIGITO  "
cSqlTop += " AND BA1.D_E_L_E_T_ = ' ' "
cSqlTop += " AND BA1_FILIAL = ' '     "
cSqlTop += " AND BA1_CPFUSR <> ' '    "
//                                      
//cSqlTop += " AND valor >= 0 "
//

cSqlTop += " AND VAL_CPF(TRIM(BA1_CPFUSR)) = 1   "           
cSqlTop += " AND BA1_TIPUSU = 'T'     "
cSqlTop += " GROUP BY BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, REM_TODOS_CARACTERS_ESPEC(BA1_NOMUSR), BA1_CPFUSR ,ba1_tipusu, BA1_DATNAS ,BA1_MATVID"
cSqlTop += " ORDER BY To_Number (Trim (BA1_CPFUSR)) , BA1_DATNAS,  BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_CPFUSR , ba1_tipusu         "

cStmTop := cSqlTop

//PlsLogFil("Query a ser executada " + Dtos(dDatabase) + " " + Time() + ":",cArqLog)
//PlsLogFil(cStmTop + CRLF,cArqLog)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStmTop),"TTOP",.F.,.T.)
//PlsLogFil("Execu็ใo finalizada as " + Dtos(dDatabase) + " " + Time(),cArqLog)
//// INCLUSAO PARA TRATAR COLABORADOR SEM MOVIMENTO FINANCEIRO EM 2010

cSqlTop1 := " SELECT BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO , REM_TODOS_CARACTERS_ESPEC(BA1_NOMUSR) BA1_NOMUSR , BA1_CPFUSR , ba1_tipusu , BA1_DATNAS , BA1_MATVID"
cSqlTop1 += " FROM  " + RetSqlName("BA1") + " ba1 ," + RetSqlName("BA3") + " ba3 " 
if  cEmpAnt == '01'	                                         //'0003'                                                              
    cSqlTop1 += " WHERE BA1_CODINT = '0001' AND BA1_CODEMP in ('9999')  "
 // cSqlTop1 += " WHERE BA1_CODINT = '0001' AND BA1_CODEMP not in ('0001','0002','0003','0004','0005') AND BA1.D_E_L_E_T_ = ' ' "
else
    cSqlTop1 += " WHERE BA1_CODINT = '0001' AND BA1_CODEMP = '9999' AND BA1.D_E_L_E_T_ = ' ' "
endIf         
cSqlTop1 += " AND BA1_FILIAL = '  '  AND BA3_FILIAL = '  'AND BA1.D_E_L_E_T_ = ' ' AND BA3.D_E_L_E_T_ = ' '  "
cSqlTop1 += " AND BA1_CPFUSR <> ' '  AND BA1_TIPUSU = 'T' "   
 
cSqlTop1 += " AND ba3_CODINT = '0001'   "
cSqlTop1 += " AND ba1_CODEMP = ba3_CODEMP   "
cSqlTop1 += " AND ba1_MATRIC = ba3_MATRIC  "    
                                                
//cSqlTop1 += " AND ba1_CODEMP = '0003'   "
//cSqlTop1 += " AND ba1_MATRIC = '037053'  "    

cSqlTop1 += " AND ((BA1_IMAGE = 'ENABLE' AND BA1_DATINC < '20220101' )OR (BA1_IMAGE = 'DISABLE' AND BA1_DATBLO >= '20210101' AND BA1_DATBLO < '20220101' )) "
cSqlTop1 += " ORDER BY To_Number (Trim (BA1_CPFUSR)) , BA1_DATNAS,  BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO, BA1_CPFUSR , ba1_tipusu "        
                     
cStmTop := cSqlTop1
//PlsLogFil("Query a ser executada " + Dtos(dDatabase) + " " + Time() + ":",cArqLog)
//PlsLogFil(cStmTop + CRLF,cArqLog)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStmTop),"TTOP1",.F.,.T.)
/////////////////////

//Primeiro titular encontrado

if ( (alltrim(TTOP->BA1_CPFUSR) <= alltrim(TTOP1->BA1_CPFUSR) ).and. !TTOP->(Eof()) ).or. TTOP1->(Eof()) 
      cCPFUsr := TTOP->BA1_CPFUSR
	  cNomUsr := AllTrim(TTOP->BA1_NOMUSR)
	  nVlrUsr := TTOP->VALOR
	  cCodInt := TTOP->BA1_CODINT
	  cCodEmp := TTOP->BA1_CODEMP
	  cMatric := TTOP->BA1_MATRIC
	  cTipReg := TTOP->BA1_TIPREG     
	  cDigito := TTOP->BA1_DIGITO  
	  cMtVidT := TTOP->BA1_MATVID                               
Else         
      cCPFUsr := TTOP1->BA1_CPFUSR
	  cNomUsr := AllTrim(TTOP1->BA1_NOMUSR) 
	  nVlrUsr := 0.00                                                                  
	  cCodInt := TTOP1->BA1_CODINT
	  cCodEmp := TTOP1->BA1_CODEMP
	  cMatric := TTOP1->BA1_MATRIC
	  cTipReg := TTOP1->BA1_TIPREG     
	  cDigito := TTOP1->BA1_DIGITO  
	  cMtVidT := TTOP1->BA1_MATVID 
EndIf                                    
		
Procesa1( )        

cSqlTop2 := " SELECT REM_TODOS_CARACTERS_ESPEC(BA1_NOMUSR) BA1_NOMUSR, BA1_CPFUSR ,BA1_TIPUSU, BA1_DATNAS ,BA1_MATVID, " 
cSqlTop2 += " REM_TODOS_CARACTERS_ESPEC(BA1_NOMPRE) BA1_NOMPRE, BA1_CPFPRE ,
cSqlTop2 += " BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO, SUM(VALOR) VALOR  "
cSqlTop2 += " FROM  " + RetSqlName("BA1") + " ba1 ,"
if  cEmpAnt == '01'
    cSqlTop2 += " ir_benef_separ_fat ir "
elseif    cEmpAnt == '02'            
    cSqlTop2 += " ir_benef_separ_int ir "
EndIF     
cSqlTop2 += " WHERE ANOBASEIR  = '"+ AllTrim(Str(mv_par01)) +"' "
cSqlTop2 += " AND CODINT  =  '0001' "      
cSqlTop2 += " AND CODINT = BA1_CODINT "  
cSqlTop2 += " AND CODEMP = BA1_CODEMP "  
cSqlTop2 += " AND MATRIC = BA1_MATRIC "  
cSqlTop2 += " AND TIPREG = BA1_TIPREG "  
cSqlTop2 += " AND DIGITO = BA1_DIGITO "  
cSqlTop2 += " AND BA1.D_E_L_E_T_ = ' ' " 
cSqlTop2 += " AND BA1_FILIAL = ' ' "     
cSqlTop2 += " AND BA1_CPFUSR = ' ' "    

//cSqlTop2 +=  " AND ba1_CODEMP = '0005'   "

cSqlTop2 += " AND VAL_CPF(TRIM(BA1_CPFUSR)) = 1  "   
cSqlTop2 += " AND (IDADE_S(TRIM(BA1_DATNAS),'20211231')  < 0 AND BA1_TIPUSU  = 'T') AND BA1_NOMPRE <> ' ' AND BA1_CPFPRE <> ' ' "
cSqlTop2 += " GROUP BY REM_TODOS_CARACTERS_ESPEC(BA1_NOMUSR) , BA1_CPFUSR ,BA1_TIPUSU, BA1_DATNAS ,BA1_MATVID, REM_TODOS_CARACTERS_ESPEC(BA1_NOMPRE) , "
cSqlTop2 += " BA1_CPFPRE ,BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO "
cSqlTop2 += " ORDER BY 7,1" 

cStmTop := cSqlTop2

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStmTop),"TTOP2",.F.,.T.)        

cCPFUsr := TTOP2->BA1_CPFPRE
cNomUsr := AllTrim(TTOP2->BA1_NOMPRE)
nVlrUsr := 0.00
cCodInt := TTOP2->BA1_CODINT
cCodEmp := TTOP2->BA1_CODEMP
cMatric := TTOP2->BA1_MATRIC
cTipReg := TTOP2->BA1_TIPREG     
cDigito := TTOP2->BA1_DIGITO  
cMtVidT := TTOP2->BA1_MATVID                    
cCPFDep := ""
cDtNasc := TTOP2->BA1_DATNAS
cNomDep := AllTrim(TTOP2->BA1_NOMUSR)
nVlrDep := TTOP2->VALOR  
cMtVidD := TTOP2->ba1_matvid   

if  cEmpAnt == '99'
    Procesa2( )   
 //   a:='b'    
Endif

GravaTxt( )

TTOP->(dbCloseArea())  
//3.12 - Registro identificador do termino da declaracao ( identificador FIMDmed )
FWrite(nArqDmed,"FIMDmed|" + CRLF)
FClose(nArqDmed)
cTermino := Dtos(dDataBase) + " " + Time()
//PlsLogFil("Arquivo para envio da DMED gerado com sucesso!" + CRLF + cArqDmed + CRLF + "Inicio: " + cInicio + "  - Termino: " + cTermino,cArqLog)
MsgInfo("Arquivo para envio da DMED gerado com sucesso!" + CRLF + cArqDmed + CRLF + "Inicio: " + cInicio + "  - Termino: " + cTermino)
      
Return .T.

Static FUNCTION Procesa1( )
		
//While !TTOP->(Eof()) .and. !TTOP1->(Eof())  
  While !TTOP->(Eof()) .or. !TTOP1->(Eof()) 
		nProc++
	   	IncProc(AllTrim(Str(nProc)) + "/" + AllTrim(Str(nRegua)) + "  -  " + AllTrim(cNomUsr))      
	   	cFamilia:= cCodInt + cCodEmp + cMatric

/*
	    If ((cCODEMP == '0325'  .and. cMATRIC == '001135') .or.  cCPFUsr =='00052212777')

		   a:='b'
	
		EndIf   
*/		   	
		if !(Val_cpf( cFamilia ))	
			
		   If (alltrim(TTOP->BA1_CPFUSR) <= alltrim(TTOP1->BA1_CPFUSR)) .or. TTOP1->(Eof()) 
	          If alltrim(TTOP->BA1_CPFUSR) = alltrim(TTOP1->BA1_CPFUSR)                                              
	             TTOP1->(dbSkip())	   
	          EndIf        
		         TTOP->(dbSkip())                      
	       Else               
	          TTOP1->(dbSkip())	             
	       EndIF    
//20131103 - altamiro
	       if (alltrim(TTOP->BA1_CPFUSR) <= alltrim(TTOP1->BA1_CPFUSR)) .or. TTOP1->(Eof()) 
			   cCPFUsr := TTOP->BA1_CPFUSR
			   cNomUsr := AllTrim(TTOP->BA1_NOMUSR)
			   nVlrUsr := TTOP->VALOR
			   cCodInt := TTOP->BA1_CODINT
			   cCodEmp := TTOP->BA1_CODEMP
			   cMatric := TTOP->BA1_MATRIC
			   cTipReg := TTOP->BA1_TIPREG     
			   cDigito := TTOP->BA1_DIGITO  
			   cMtVidT := TTOP->BA1_MATVID 
			else         
			   cCPFUsr := TTOP1->BA1_CPFUSR
			   cNomUsr := AllTrim(TTOP1->BA1_NOMUSR) 
			   nVlrUsr := 0.00                                                                  
			   cCodInt := TTOP1->BA1_CODINT
			   cCodEmp := TTOP1->BA1_CODEMP
			   cMatric := TTOP1->BA1_MATRIC
			   cTipReg := TTOP1->BA1_TIPREG     
			   cDigito := TTOP1->BA1_DIGITO  
			   cMtVidT := TTOP1->BA1_MATVID 
			EndIf  
//20131103 - altamiro
        	loop
		EndIf    
        If !lPvez 
           if nVlFam > 0.00 .or. admedt[nPontV,12]== .T. // 09/03/2020 altamiro
		      admedt[nPontV,12]:= .T.
		   else          
		      admedt[nPontV,12]:=.F.   
		   EndIf                     
	  	     
	    EndIf   
		          				
   		lPvez  := .F.       
		nVlFam := 0.00   
		    
		If (nAscan:=Ascan(admedt , {|e| e[1]+e[2]+e[3] == "1TOP" + cCPFUsr+cMtVidt})) == 0    
			Aadd(admedt , {"1TOP"   ,;
			cCPFUsr ,;
			cMtVidt ,;
			" "     ,;
			" "     ,; 
			" "     ,;
			cNomUsr ,;
			" "     ,; 
			" "     ,;
			" "     ,;                               
			nVlrUsr ,;
			lPvez   ,;
			0.00    ,;
			cCodInt ,;
			cCodEmp ,;
			cMatric ,;
			cTipReg ,;     
			cDigito ,;
			0.00    ,;
			0.00    })
	 	Else 
	 	    admedt[nAscan,11]+= nVlrUsr
	 	EndIf     
		 	       
			 	
		nVlFam +=nVlrUsr   	                      
	    nPontV:=Ascan(admedt , {|e| e[1]+e[2]+e[3] == "1TOP" + cCPFUsr+cMtVidt}) 
		
		//3.6 - Registro de informacao de reembolso do titular do plano ( identificador RTOP )
		M260Reemb("2RTOP"   ,AllTrim(Str(mv_par01)),cCodInt,cCodEmp,cMatric,cTipReg,cDigito,nProc,nRegua,cArqlog, cCPFUsr , cMtVidT ,cCPFDep ,cMtVidD , cDtNasc)
		
		//3.7 - Registro de informacao de dependente do titular ( identificador DTOP )
		
		cSqlDtop := "SELECT BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO, REM_TODOS_CARACTERS_ESPEC(BA1_NOMUSR) BA1_NOMUSR," 
		//cSqlDtop += " CASE  WHEN  BA1_CPFUSR = '" +cCPFUsr +"' THEN CASE  WHEN BA1_DATNAS > '19931231' THEN ' ' ELSE BA1_CPFUSR END ELSE bA1_CPFUSR END bA1_CPFUSR ,"  
		//cSqlDtop += "   CASE  WHEN BA1_DATNAS > '19931231' THEN ' ' ELSE BA1_CPFUSR END  bA1_CPFUSR ,"
		//cSqlDtop += "   CASE  WHEN BA1_DATNAS > '19941231' THEN ' ' ELSE BA1_CPFUSR END  bA1_CPFUSR ,"
		cSqlDtop += "   CASE WHEN IDADE_S(TRIM(BA1_DATNAS),'20211231') < 0 THEN ' ' ELSE BA1_CPFUSR END BA1_CPFUSR ,"
		
		cSqlDtop += "  BA1_DATNAS ,BA1_GRAUPA ,ba1_tipusu, ba1_matvid,Sum(VALOR) valor "  
		cSqlDtop += "  FROM  " + RetSqlName("BA1") + " ba1 ,
		if  cEmpAnt == '01'
		    cSqlDtop += " ir_benef_separ_fat ir "
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
		
	/////cSqlDtop += " AND ((BA1_CPFUSR <> ' ' ) or  (BA1_CPFUSR = ' ' AND (BA1_DATNAS > '19931231')))"   
		
    //  cSqlDtop += " AND ((BA1_CPFUSR <>  '" +cCPFUsr +" ' ) or  (BA1_CPFUSR = '" +cCPFUsr +" ' AND (BA1_DATNAS > '19931231')))"
		cSqlDtop += " AND ((BA1_CPFUSR <>  '" +cCPFUsr +" ' ) or  (BA1_CPFUSR = '" +cCPFUsr +" ' AND IDADE_S(TRIM(BA1_DATNAS)) < 0))"
		//                                     
        cSqlDTop += " AND valor >= 0 "
		//
		cSqlDtop += " AND BA1_CPFUSR <> ' ' "
		cSqlDtop += " AND VAL_CPF(TRIM(BA1_CPFUSR)) = 1 " 
		cSqlDtop += " AND BA1_TIPUSU <> '" + cCodTit + "' "
		cSqlDtop += " AND BA1.D_E_L_E_T_ = ' ' " 
		cSqlDtop += " AND BA1_FILIAL = '  '   "  
		cSqlDtop += " GROUP by   BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO, REM_TODOS_CARACTERS_ESPEC(BA1_NOMUSR), BA1_CPFUSR , BA1_DATNAS ,BA1_GRAUPA ,ba1_tipusu,BA1_DATNAS  , ba1_matvid"
		/////cSqlDtop += " ORDER by   CASE  WHEN BA1_DATNAS > '19931231' THEN ' ' ELSE BA1_CPFUSR END  "
		////cSqlDtop += " ORDER by   CASE  WHEN BA1_DATNAS > '19941231' THEN ' ' ELSE BA1_CPFUSR END  "
		cSqlDtop += " ORDER BY CASE WHEN IDADE_S(TRIM(BA1_DATNAS),'20211231') < 0 THEN ' ' ELSE BA1_CPFUSR END  "   
		cSqlDtop += "        , BA1_DATNAS , BA1_CODINT , BA1_CODEMP , BA1_MATRIC , BA1_TIPREG , BA1_DIGITO     "
		//To_Number (Trim (BA1_CPFUSR)) 
		
		
		cStmDtop :=cSqlDtop
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
			cMtVidD := DTOP->ba1_matvid  
				
			cCodInt := DTOP->BA1_CODINT
			cCodEmp := DTOP->BA1_CODEMP
			cMatric := DTOP->BA1_MATRIC
			cTipReg := DTOP->BA1_TIPREG     
			cDigito := DTOP->BA1_DIGITO                                                               
		
			If lConReg
				          
	   //cnomdep:=consnome(cnomdep)
	   //  tipreg,CPFTIT ,cMtVidT, CPFDEP , cMtVidd ,DtNasc , NomUsr , RelDep , cpfreemb , nomereemb , Vlusr            
	         	If (nAscan:=Ascan(admedt , {|e| e[1]+e[2]+e[3]+e[4]+e[5]+e[6] == "3DTOP" + cCPFUsr + cMtVidT + cCPFDep + cMtVidd + cDtNasc })) == 0    
	 	            Aadd(admedt, { "3DTOP" ,;
	 	   	                      cCPFUsr ,; 
	 	   	                      cMtVidT ,;
	 	   	                      iif(alltrim(cCPFDep)=='','00000000000' ,cCPFDep) ,;
	 	   	                      cMtVidD ,;
	 	   	                      cDtNasc ,;
	 	   	                      cNomDep ,;
	 	   	                      cRelDep ,;
	 	   	                      " "     ,;
	 	   	                      " "     ,;                           
	 	   	                      nVlrDep ,;
	 	   	                      " "     ,;
	 	   	                      0.00	  ,;
	 	   	                      cCodInt ,;
		  						  cCodEmp ,;
								  cMatric ,;
								  cTipReg ,;     
								  cDigito ,;
	                              0.00    ,;
								  0.00    })
	 	        Else 
	 	           admedt[nAscan,11]+= nVlrDep
	 	        EndIf 
			    nVlFam +=nVlrdep      
		    EndIf		
	//3.8 - Registro de informacao de reembolso do dependente ( identificador RDTOP )		
			M260Reemb("4RDTOP",AllTrim(Str(mv_par01)),DTOP->BA1_CODINT,DTOP->BA1_CODEMP,DTOP->BA1_MATRIC,DTOP->BA1_TIPREG,DTOP->BA1_DIGITO,nProc,nRegua,cArqlog,cCPFUsr , cMtVidT ,cCPFDep ,cMtVidD , cDtNasc)
		   
			DTOP->(dbSkip())
		
		EndDo
			DTOP->(dbCloseArea())
		if  cEmpAnt == '01'			
		    If (alltrim(TTOP->BA1_CPFUSR) <= alltrim(TTOP1->BA1_CPFUSR)) .or. TTOP1->(Eof()) 
		
		       If alltrim(TTOP->BA1_CPFUSR) == alltrim(TTOP1->BA1_CPFUSR)  .or. TTOP->(Eof())                                            
		          TTOP1->(dbSkip())	   
		       EndIf        
			      TTOP->(dbSkip())                      
		    Else               
		       TTOP1->(dbSkip())	             
		    EndIF                 
		else                      
		      TTOP->(dbSkip())
		endIf 
  	
	if ((alltrim(TTOP->BA1_CPFUSR) <= alltrim(TTOP1->BA1_CPFUSR)) .or. TTOP1->(Eof())) .and. !TTOP->(Eof())     
       cCPFUsr := TTOP->BA1_CPFUSR
       cNomUsr := AllTrim(TTOP->BA1_NOMUSR)
       nVlrUsr := TTOP->VALOR
       cCodInt := TTOP->BA1_CODINT
       cCodEmp := TTOP->BA1_CODEMP
       cMatric := TTOP->BA1_MATRIC
       cTipReg := TTOP->BA1_TIPREG     
       cDigito := TTOP->BA1_DIGITO
       cMtVidT := TTOP->BA1_MATVID 
    ElseIf !(TTOP1->(Eof()))        
       cCPFUsr := TTOP1->BA1_CPFUSR
       cNomUsr := AllTrim(TTOP1->BA1_NOMUSR) 
       nVlrUsr := 0.00
       cCodInt := TTOP1->BA1_CODINT
       cCodEmp := TTOP1->BA1_CODEMP
       cMatric := TTOP1->BA1_MATRIC
       cTipReg := TTOP1->BA1_TIPREG     
       cDigito := TTOP1->BA1_DIGITO
       cMtVidT := TTOP1->BA1_MATVID 
    EndIf   
		     
EndDo

If !lPvez 
   if nVlFam > 0.00  .or. nVlrUsr > 0.00 
      admedt[nPontV,12]:= .T.
   else          
      admedt[nPontV,12]:=.F.   
   EndIf
EndIf   
   lPvez := .F.       
   nVlFam:= 0.00     
Return .T.        

//////////////////////////processa 2 ///////// TITULAR SEM CPG
Static FUNCTION Procesa2( )		

  While !TTOP2->(Eof()) 
		nProc++
	   	IncProc(AllTrim(Str(nProc)) + "/" + AllTrim(Str(nRegua)) + "  -  " + AllTrim(cNomUsr))      
	   	cFamilia:= cCodInt + cCodEmp + cMatric                                                                        		 	   	                      
		 	   	                      	   	
		If (nAscan:=Ascan(admedt , {|e| e[1]+e[2] == "1TOP" +  cCPFUsr}))  != 0     
		    cCPFUsr :=  admedt[nAscan,2] 
   	        cMtVidT :=  admedt[nAscan,3]
		    Aadd(admedt, { "3DTOP" ,;
   	                       cCPFUsr ,; 
   	                       cMtVidT ,;
		 	   	           iif(alltrim(cCPFDep) == '','00000000000' ,cCPFDep) ,; 
		 	   	           cMtVidD ,;
		 	   	           cDtNasc ,;
		 	   	           cNomDep ,;
		 	   	           "08" ,;
		 	   	           " "     ,;
		 	   	           " "     ,;                           
		 	   	           nVlrDep ,;
		 	   	           " "     ,;
		 	   	           0.00    ,;
	   	                   cCodInt ,;
						   cCodEmp ,;
				           cMatric ,;
						   cTipReg ,;                                                                    
						   cDigito ,;
			               0.00    ,;
			               0.00    })
      	                                                                       
		ElseIf (nAscan:=Ascan(admedt , {|e| e[1]+e[4] == "3DTOP" + cCPFUsr})) != 0     
		    cCPFUsr :=  admedt[nAscan,2] 
   	        cMtVidT :=  admedt[nAscan,3]
		    Aadd(admedt, { "3DTOP" ,;
   	                       cCPFUsr ,; 
   	                       cMtVidT ,;
		 	   	           iif(alltrim(cCPFDep) == '','00000000000' ,cCPFDep) ,;
		 	   	           cMtVidD ,;
		 	   	           cDtNasc ,;
		 	   	           cNomDep ,;
		 	   	           "08"    ,;
		 	   	           " "     ,;
		 	   	           " "     ,;                           
		 	   	           nVlrDep ,;
		 	   	           " "     ,;
		 	   	           0.00    ,;
	   	                   cCodInt ,;
						   cCodEmp ,;
				           cMatric ,;
						   cTipReg ,;     
						   cDigito ,;
			               0.00    ,;
			               0.00    })  
						                  
        Else 

		   Aadd(admedt , { "1TOP"   ,;
							cCPFUsr ,;
							cMtVidt ,;
							" "     ,;
							" "     ,; 
							" "     ,;
							cNomUsr ,;
							" "     ,; 
							" "     ,;
							" "     ,;                               
							0.00    ,;
							.T.     ,;
							0.00    ,;
	   	                   cCodInt  ,;
						   cCodEmp  ,;
				           cMatric  ,;
						   cTipReg  ,;     
						   cDigito  ,;
			 			    0.00    ,;
							0.00    })
		   		                          
   	        Aadd(admedt, { "3DTOP" ,;
   	                       cCPFUsr ,; 
   	                       cMtVidT ,;
		 	   	           iif(alltrim(cCPFDep) == '','00000000000' ,cCPFDep) ,; 
		 	   	           cMtVidD ,;
		 	   	           cDtNasc ,;
		 	   	           cNomDep ,;
		 	   	           "08"    ,;
		 	   	           " "     ,;
		 	   	           " "     ,;                           
		 	   	           nVlrDep ,;
		 	   	           " "     ,;
		 	   	           0.00    ,;
		 	   	           cCodInt ,;
						   cCodEmp ,;
				           cMatric ,;
						   cTipReg ,;     
						   cDigito ,;
					       0.00    ,;
					       0.00    }) 
		 	   	                         
        EndIf    	                      
           
  	    M260Reemb("4RDTOP",AllTrim(Str(mv_par01)),cCodInt,cCodEmp,cMatric,cTIPREG,cDIGITO,nProc,nRegua,cArqlog,cCPFUsr , cMtVidT ,cCPFDep ,cMtVidD , cDtNasc)
		   
        TTOP2->(dbSkip())	 
        cCPFUsr := TTOP2->BA1_CPFPRE
        cNomUsr := AllTrim(TTOP2->BA1_NOMPRE)
		nVlrUsr := 0.00
		cCodInt := TTOP2->BA1_CODINT
		cCodEmp := TTOP2->BA1_CODEMP
		cMatric := TTOP2->BA1_MATRIC
		cTipReg := TTOP2->BA1_TIPREG     
		cDigito := TTOP2->BA1_DIGITO  
		cMtVidT := TTOP2->BA1_MATVID                    
		cCPFDep := ""
		cDtNasc := TTOP2->BA1_DATNAS
		cNomDep := AllTrim(TTOP2->BA1_NOMUSR)
		nVlrDep := TTOP2->VALOR  
		cMtVidD := TTOP2->ba1_matvid                                                               	
     EndDo    								
        
Return .T.
//////////////////////////fim processa 2 /////////
                          
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
//Static Function M260Reemb(cRegistro,cAno,cCodInt,cCodEmp,cMatric,cTipReg,cDigito,cArqlog, cCPFUsr , cCPFDep , cDtNasc)     
Static Function M260Reemb(cRegistro,cAno,cCodInt,cCodEmp,cMatric,cTipReg,cDigito,nProc,nRegua,cArqlog, cCPFUsr , cMtVidT ,cCPFDep ,cMtVidD , cDtNasc)     

Local lNewReem := If(GetNewPar("MV_PLSREDM","1") == "1",.T.,.F.) // Utilizar nova rotina de reembolso ( PLSA001 ) para DMED ?
Local lConReg := .T. // o registro posicionado sera considerado para escrita do arquivo
Local aRetPto := {} // matriz para receber o retorno do ponto de entrada
Local cReeCPF := "" // CPF / CNPJ do prestador de servico
Local cReeNom := "" // Nome do prestador de servico
Local nReeVlr := 0 // Valor do reembolso  /

////// NOVA CONSULTA REEMBOLSO IGUAL AO RELATORIO 
cSql :=       " SELECT trim (B44_CPFEXE) CPFCGC, REM_TODOS_CARACTERS_ESPEC(trim (B44_NOMEXE)) NOME, " 	
cSql += CRLF+ "        sum(CASE WHEN SUBSTR (B45_DATPRO, 1,4) < '2021'  THEN  (B45_VLRPAG) ELSE 0 END) VALOR_2012, "
cSql += CRLF+ "        sum(CASE WHEN SUBSTR (B45_DATPRO, 1,4) = '2021'  THEN  (B45_VLRPAG) ELSE 0 END) VALOR_2013, "  
cSql += CRLF+ "        sum(b45_vlrapr) vlrapres , sum(b45_vlrglo)vlrglos , "
cSql += CRLF+ "        B44_OPEUSR , B44_CODEMP , B44_MATRIC , B44_TIPREG , B44_DIGITO "  
                                                                      
cSql += CRLF+ "   FROM " + RetSqlName("ZZQ") + " P,  "
cSql += CRLF+ " " + RetSqlName("B44") + " C,  "
cSql += CRLF+ " " + RetSqlName("B45") + " D,  "
cSql += CRLF+ " " + RetSqlName("SA1") + " SA1," 
cSql += CRLF+ " " + RetSqlName("SE1") + " SE1," 
cSql += CRLF+ " " + RetSqlName("BA1") + " U,  "
cSql += CRLF+ " " + RetSqlName("BA1") + " F,  "
cSql += CRLF+ " " + RetSqlName("BG9") + " BG9," 
cSql += CRLF+ " " + RetSqlName("BR8") + " BR8 "
cSql += CRLF+ "  WHERE ZZQ_FILIAL   = '  ' "
cSql += CRLF+ "    AND B44_FILIAL   = '  ' "
cSql += CRLF+ "    AND B45_FILIAL   = '  ' "
cSql += CRLF+ "    AND F.BA1_FILIAL = '  ' "
cSql += CRLF+ "    AND U.BA1_FILIAL = '  ' "
cSql += CRLF+ "    AND BG9_FILIAL   = '  ' "
cSql += CRLF+ "    AND BR8_FILIAL   = '  ' "
cSql += CRLF+ "    AND E1_FILIAL    = '01' "
cSql += CRLF+ "    AND A1_FILIAL    = '  ' "
cSql += CRLF+ "    AND ZZQ_SEQUEN = B44_YCDPTC "
cSql += CRLF+ "    AND ZZQ_STATUS = '3' "

cSql += CRLF+ "    AND B44_OPEUSR = '" + cCodInt + "'"
cSql += CRLF+ "    AND B44_CODEMP = '" + cCodEmp + "'"
cSql += CRLF+ "    AND B44_MATRIC = '" + cMatric + "'"
cSql += CRLF+ "    AND B44_TIPREG = '" + cTipReg + "'"
cSql += CRLF+ "    AND B44_DIGITO = '" + cDigito + "'"

cSql += CRLF+ "    AND d.B45_OPEMOV = c.B44_OPEMOV and D.B45_ANOAUT = C.B44_ANOAUT  and D.B45_MESAUT = C.B44_MESAUT and D.B45_NUMAUT = c.B44_NUMAUT  "
cSql += CRLF+ "    AND B44_PREFIX <> 'AXF' "

cSql += CRLF+ "    AND B45_VLRPAG > 0    "

//cSql += CRLF+ "    AND  b44_regexe <> ' '   "

cSql += CRLF+ "    AND B44_PREFIX = E1_PREFIXO  "
cSql += CRLF+ "    AND B44_NUM = E1_NUM "
cSql += CRLF+ "    AND A1_COD = E1_CLIENTE       "
cSql += CRLF+ "    AND U.BA1_CODINT=F.BA1_CODINT "
cSql += CRLF+ "    AND U.BA1_CODEMP=F.BA1_CODEMP "
cSql += CRLF+ "    AND U.BA1_MATRIC=F.BA1_MATRIC "
cSql += CRLF+ "    AND F.BA1_TIPUSU='T' "      
cSql += CRLF+ "    AND U.BA1_CODINT=B44_OPEUSR "
cSql += CRLF+ "    AND U.BA1_CODEMP=B44_CODEMP "
cSql += CRLF+ "    AND U.BA1_MATRIC=B44_MATRIC "
cSql += CRLF+ "    AND U.BA1_TIPREG=B44_TIPREG "
cSql += CRLF+ "    AND B44_OPEUSR=BG9_CODINT "
cSql += CRLF+ "    AND B44_CODEMP=BG9_CODIGO "
cSql += CRLF+ "    AND E1_BAIXA BETWEEN  '20210101'  AND '20211231'
//cSql += CRLF+ "    AND F.BA1_CODINT||F.BA1_CODEMP||F.BA1_MATRIC = '00010325001135'
cSql += CRLF+ "    AND B45_CODPAD = BR8_CODPAD "
cSql += CRLF+ "    AND B45_CODPRO = BR8_CODPSA "
cSql += CRLF+ "    AND P.D_E_L_E_T_   = ' ' "  
cSql += CRLF+ "    AND C.D_E_L_E_T_   = ' ' "  
cSql += CRLF+ "    AND D.D_E_L_E_T_   = ' ' "  
cSql += CRLF+ "    AND SA1.D_E_L_E_T_ = ' ' "
cSql += CRLF+ "    AND SE1.D_E_L_E_T_ = ' ' "
cSql += CRLF+ "    AND U.D_E_L_E_T_   = ' ' "  
cSql += CRLF+ "    AND F.D_E_L_E_T_   = ' ' "  
cSql += CRLF+ "    AND BG9.D_E_L_E_T_ = ' ' "
cSql += CRLF+ "    AND BR8.D_E_L_E_T_ = ' ' "
cSql += CRLF+ "    AND NOT EXISTS (SELECT NULL "
cSql += CRLF+ "                      FROM " + RetSqlName("B44") + " b441, "
cSql += CRLF+ "                           " + RetSqlName("B45") + " b451 "
cSql += CRLF+ "                     WHERE b441.d_E_L_E_T_ = ' ' and  b451.d_E_L_E_T_ = ' ' "
cSql += CRLF+ "                       AND b441.B44_FILIAL   = '  '"
cSql += CRLF+ "                       AND b451.B45_FILIAL   = '  '"
cSql += CRLF+ "                       and b451.B45_FILIAL = b441.B44_FILIAL "
cSql += CRLF+ "                       and b451.B45_OPEMOV = b441.B44_OPEMOV "
cSql += CRLF+ "                       and b451.B45_ANOAUT = b441.B44_ANOAUT "
cSql += CRLF+ "                       and b451.B45_MESAUT = b441.B44_MESAUT "
cSql += CRLF+ "                       and b451.B45_NUMAUT = b441.B44_NUMAUT "
cSql += CRLF+ "                       and B451.B45_CODPAD || b451.b45_codpro   IN "
cSql += CRLF+ " ('0603000206' , '0220101074' , '1520101074' , '1620101074' , '0150020021' , '0180760023' , '9880760023' , '0180940030' , "
cSql += CRLF+ "  '9880940030' , '0182000050' , '9882000050' , '0182000204' , '9882000204' , '0183000011' , '0183000020' , '9883000020' , "
cSql += CRLF+ "  '0183000062' , '9883000062' , '0183000089' , '0183000097' )  "

//cSql += CRLF+ "  '01970370010' ) " // incluido por orienta็ใo da raquel casemiro


cSql += CRLF+ "                       and b441.b44_ycdptc = c.b44_ycdptc ) "
cSql += CRLF+ "                     group by trim (B44_CPFEXE) , REM_TODOS_CARACTERS_ESPEC(trim (B44_NOMEXE)) ,"	
cSql += CRLF+ "                           B44_OPEUSR , B44_CODEMP , B44_MATRIC , B44_TIPREG , B44_DIGITO   "

////////

/* CONSULTA ANTIGA 

//cSql := " SELECT trim (BB0_CGC) CPFCGC, REM_TODOS_CARACTERS_ESPEC(trim (BB0_NOME)) NOME, 	" 
cSql := " SELECT trim (B44_CPFEXE) CPFCGC, REM_TODOS_CARACTERS_ESPEC(trim (B44_NOMEXE)) NOME, 	"
cSql += " sum(CASE WHEN SUBSTR (B45.B45_DATPRO, 1,4) < '2019'  THEN  (B45.B45_VLRPAG) ELSE 0 END) VALOR_2012, "
cSql += " sum(CASE WHEN SUBSTR (B45.B45_DATPRO, 1,4) = '2019'  THEN  (B45.B45_VLRPAG) ELSE 0 END) VALOR_2013, "  

cSql += " sum(b45_vlrapr) vlrapres , sum(b45_vlrglo)vlrglos , " 


cSql += " B44_OPEUSR , B44_CODEMP , B44_MATRIC , B44_TIPREG , B44_DIGITO "  
                                                                                                     
cSql += "   FROM " + RetSqlName("ZZQ") + " P ," 
cSql += " " + RetSqlName("B44") + " C ," 
cSql += " " + RetSqlName("B45") + " b45 ," 
cSql += " "+ RetSqlName("SE1") + " SE1 ," 
cSql += " "+ RetSqlName("BA1") + " U " 
//cSql += " "+ RetSqlName("bb0") + " BB0 "  

cSql += "  WHERE B44_FILIAL = '" + xFilial("B44") + "'"
cSql += "    AND ZZQ_FILIAL = '" + xFilial("ZZQ") + "'"
cSql += "    AND BA1_FILIAL = '" + xFilial("BA1") + "'"
cSql += "    AND E1_FILIAL  = '" + xFilial("SE1") + "'"  
cSql += "    AND B45_FILIAL = '" + xFilial("B45") + "'"
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
cSql += "    AND  b44_regexe <> ' '   "
//cSql += "    AND BB0_NUMCR  = b44_regexe   "
//cSql += "    AND BB0_CGC	 <>  ' '       "

cSql += "    AND B44_PREFIX = E1_PREFIXO   "
cSql += "    AND B44_NUM    = E1_NUM       "                   
cSql += "    AND B44_PARCEL = E1_PARCELA  "
cSql += "    AND B44_TIPO   = E1_TIPO "
cSql += "    AND E1_PREFIXO <> 'AXF' "

cSql += "    AND B45.B45_VLRPAG > 0    "
//cSql += "    AND ( ( length(trim(bb0_cgc)) <= 11 AND VAL_CPF(lpad(trim(bb0_cgc),11,'0')) = 1 ) OR   "
//cSql += "          ( length(trim(bb0_cgc)) IN (12,13,14) ) ) 									"

cSql += "    AND U.BA1_CODINT = B44_OPEUSR "
cSql += "    AND U.BA1_CODEMP = B44_CODEMP "
cSql += "    AND U.BA1_MATRIC = B44_MATRIC "
cSql += "    AND U.BA1_TIPREG = B44_TIPREG "
cSql += "    AND E1_BAIXA BETWEEN  '20190101'  AND '20191231' "
cSql += "    AND P.D_E_L_E_T_   = ' ' AND  C.D_E_L_E_T_ = ' ' "
//cSql += "    AND SE1.D_E_L_E_T_ = ' ' AND  U.D_E_L_E_T_ = ' ' AND  BB0.D_e_l_e_t_ = ' ' AND  B45.D_e_l_e_t_ = ' '"         
cSql += "    AND SE1.D_E_L_E_T_ = ' ' AND  U.D_E_L_E_T_ = ' '  AND  B45.D_e_l_e_t_ = ' '"        
///AKLI 
cSql += "    and b45.B45_FILIAL = C.B44_FILIAL and b45.B45_OPEMOV = C.B44_OPEMOV and b45.B45_ANOAUT = C.B44_ANOAUT "                       
cSql += "    and b45.B45_MESAUT = C.B44_MESAUT and b45.B45_NUMAUT = C.B44_NUMAUT " //and b45.b45_codpad = '01'"                       
//cSql += "    and b45.b45_codpro  not iN ('83000011','83000020','82000050', '03000206','82000204' ,'50020021','90990013','83000062')  alterado em 14/02/17

//cSql += "    and b45.b45_codpro  not IN ('83000011','83000020','82000050', '03000206','82000204','50020021','80940030', '83000062','03000206','80760023','83000097','20101074','83000089') "  

cSql += CRLF+ " and B45.B45_CODPAD || b45.b45_codpro not IN " 
cSql += CRLF+ " ('0603000206' , '0220101074' , '1520101074' , '1620101074' , '0150020021' , '0180760023' , '9880760023' , '0180940030' ," 
cSql += CRLF+ " '9880940030' , '0182000050' , '9882000050' , '0182000204' , '9882000204' , '0183000011' , '0183000020' , '9883000020' , " 
cSql += CRLF+ " '0183000062' , '9883000062' , '0183000089' , '0183000097' , '9883000097') "
                   
              
cSql += " GROUP BY  trim (B44_CPFEXE),REM_TODOS_CARACTERS_ESPEC(trim (B44_NOMEXE)) ,  B44_OPEUSR , B44_CODEMP , B44_MATRIC , B44_TIPREG , B44_DIGITO  "
//cSql += " ORDER BY  to_number (trim (B44_CPFEXE))   "
 */


cStm := cSql
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStm),"REEM",.F.,.T.)

While !REEM->(Eof())
    if len(AllTrim(REEM->NOME)) = 3
       cReeNom := AllTrim(REEM->NOME) + substr(AllTrim(REEM->NOME),3,1)
    else
       cReeNom := AllTrim(REEM->NOME) 
    endif
    
	IncProc(AllTrim(Str(nProc)) + "/" + AllTrim(Str(nRegua)) + "  -  Verificando reembolso")

	cReeCPF   :=REEM->CPFCGC
	nReeVlr12 := REEM->VALOR_2012 
	nReeVlr13 := REEM->VALOR_2013                              
    nReeVlapr := REEM->vlrapres  
	nReevlglo := REEM->vlrglos

    cCodInt   := REEM->B44_OPEUSR  
    cCodEmp   := REEM->B44_CODEMP
    cMatric   := REEM->B44_MATRIC
    cTipReg   := REEM->B44_TIPREG     
    cDigito   := REEM->B44_DIGITO
    
	lConReg   := .T.
 
        
	If (lConReg .AND. TRIM(cReeCPF)<>TRIM(cCPFUsr))  //TRATAMENTO PARA CPF DE PROF SAUDE QUE ESTAO IGUAL AO DE ASSISTIDOS  
        ////cReeNom:=consnome(cReeNom)   
        //  tipreg,CPFTIT ,cMtVidT, CPFDEP , cMtVidd ,DtNasc , NomUsr , RelDep , cpfreemb , nomereemb , Vlusr  
        iF cRegistro == "4RDTOP"
          	If (nAscan:=Ascan(admedt , {|e| e[1]+e[2]+e[3]+e[4]+e[5]+e[6]+e[9] == cRegistro + cCPFUsr +cMtVidT + cCPFDep + cMtVidD + cDtNasc + cReeCPF })) == 0    
 	            Aadd(admedt, {cRegistro ,;
 	   	                      cCPFUsr   ,;
 	   	                      cMtVidT   ,;
 	   	                      iif(alltrim(cCPFDep) == '','00000000000' ,cCPFDep) ,;
 	   	                      cMtVidD   ,;
 	   	                      cDtNasc   ,;
 	   	                      " "       ,;
 	   	                      " "       ,;
 	   	                      cReeCPF   ,;
 	   	                      cReeNom   ,;                           
 	   	                      nReeVlr12 ,;
 	   	                      " "       ,;
 	   	                      nReeVlr13 ,;
 	   	                      cCodInt   ,;  
                              cCodEmp   ,;
                              cMatric   ,;
                              cTipReg   ,;
                              cDigito   ,;
                              nReeVlapr ,;
							  nReevlglo })
 	        Else 
 	           admedt[nAscan,11]+= nReeVlr12 
 	           admedt[nAscan,13]+= nReeVlr13
 	        EndIf                     
 	   ElseIF cRegistro == "2RTOP"
           	 If (nAscan:=Ascan(admedt , {|e| e[1]+e[2]+e[3]+e[9] == cRegistro + cCPFUsr +cMtVidT + cReeCPF })) == 0    
 	             Aadd(admedt, {cRegistro ,;
 	   	                       cCPFUsr   ,;
 	   	                       cMtVidT   ,;
 	   	                       " "       ,;
 	   	                       " "       ,;
 	   	                       " "       ,;
 	   	                       " "       ,; 
 	   	                       " "       ,;
 	   	                      cReeCPF    ,;
 	   	                      cReeNom    ,;                           
 	   	                      nReeVlr12  ,;
 	   	                      " "        ,;
 	   	                      nReeVlr13  ,;
 	   	                      cCodInt   ,;  
                              cCodEmp   ,;
                              cMatric   ,;
                              cTipReg   ,;
                              cDigito   ,;
                              nReeVlapr ,;
							  nReevlglo })
 	        Else 
 	           admedt[nAscan,11]+= nReeVlapr 
 	           admedt[nAscan,13]+= nReeVlglo 
 	           admedt[nAscan,19]+= nReeVlr12 
 	           admedt[nAscan,20]+= nReeVlr13
 	           
 	        EndIf                     
 	    EndIf
 	        
      	nVlFam +=nReeVlr12 
      	nVlFam +=nReeVlr13  

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
ฑฑบUso       ณdmed                                                        บฑฑ
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
        if (substr(cReeNom ,x , 1)) $ ".|-|_|/|'|=|:"  
            a+=' '
        elseif (substr(cReeNom ,x , 1)) $ "0"  
            a+='O' 
        elseif (substr(cReeNom ,x , 2)) $ "  "  
            a+=' '    
        else 
            a+= substr(cReeNom ,x , 1) 
        endIf    
     x++
enddo
Return(a) 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSM260   บAutor  ณaltamiro	         บ Data ณ  31/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณremove carracteres invalidos do nomes                       บฑฑ
ฑฑบ          |                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณdmed                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION GravaTxt( )

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local nOrder := 0   
Local nSeq   := 0  
local Y      := 0

// Aadd(admedt, {cRegistro 1, cCPFUsr 2, cMtVidt 3, cCPFDep 4, cMtVidd 5, cDtNasc 6, cNomDep 7, cRelDep 8, cReeCPF 9, cReeNom 10, nReeVlr 11 })
If Len(admedt) > 1	   

      aSort( admedt,,,{|x,y| x[2]+x[4]+x[1]+x[6]+ StrZero(Val(cValtoChar(x[9])),14) < y[2]+y[4]+y[1]+y[6]+ StrZero(Val(cValtoChar(y[9])),14)} ) 

   For x := 1 To Len(admedt)

//	    If ((admedt[x,15] == '0325'  .and. admedt[x,16] == '001135').or. admedt[x,2]== '00052212777') 

//		   a:='b'
	
//		EndIf   

   Y:= IIf(Len(admedt)>(x+1),(x+1),Len(admedt))
                                  
   If admedt[x,1] == "1TOP" 
      lGrava:=admedt[x,12]
   endif  
                                            
   If lGrava
      If admedt[x,1] == "1TOP"  .and. admedt[x,11] == 0 .and. admedt[y,1] == "1TOP"  
         a:= 'B'
      ElseIf admedt[x,1] == "1TOP"    
         FWrite(nArqDmed,"TOP" + "|" +; // Identificador de registro
                AllTrim(admedt[x,2]) + "|" +; // CPF do titular
  	            admedt[x,7]  + "|" +; // Nome
                AllTrim(Replace(Transform(admedt[x,11],MOEDA),',','')) + "|" + CRLF) // Valor pago no ano com o titular     
                nSeq := 1 
                nOrder++
	            fGravaPcj( admedt[x,1] , admedt[x,2] , admedt[x,3] , admedt[x,4] , admedt[x,5] , admedt[x,6] , admedt[x,7] , admedt[x,8],  admedt[x,9] , admedt[x,10] , admedt[x,11] , admedt[x,13] , nOrder , nSeq , admedt[x,14] , admedt[x,15], admedt[x,16] , admedt[x,17] , admedt[x,18] , admedt[x,19] , admedt[x,20])
   //grava Dependente                                      
   //  ElseIf (admedt[x,1] == "3DTOP"  .and.  (admedt[x,11] > 0 .or. (admedt[Y,1]=="4RDTOP" .and. admedt[Y,5] ==admedt[x,5]) ))   
       ElseIf (admedt[x,1] == "3DTOP"  .and.  (admedt[x,11] > 0 .or. admedt[Y,1]=="4RDTOP"  ))  
   //     .and. len(admedt)< X .and. admedt[x+1,1] == "4RDTOP" .and. (admedt[x+1,13] > 0 .or. admedt[x+1,11])
         	FWrite(nArqDmed,"DTOP|"+; // Identificador de registro
                IIf(admedt[x,4]=='00000000000','' ,admedt[x,4]) + "|" +; // CPF do dependente
				admedt[x,6] + "|" +; // Data de nascimento
				admedt[x,7]+ "|" +; // Nome
				admedt[x,8] + "|" +; // Relacao de dependencia
				AllTrim(Replace(Transform(admedt[x,11],MOEDA),',','')) + "|" + CRLF) // Valor pago no ano com o dependente		
				nSeq ++ 
	            fGravaPcj( admedt[x,1] , admedt[x,2] , admedt[x,3] , admedt[x,4] , admedt[x,5] , admedt[x,6] , admedt[x,7] , admedt[x,8],  admedt[x,9] , admedt[x,10] , admedt[x,11] , admedt[x,13] , nOrder , nSeq , admedt[x,14] , admedt[x,15], admedt[x,16] , admedt[x,17] , admedt[x,18], admedt[x,19] , admedt[x,20])
   //grava reembolso                                             
      ElseIf (admedt[x,1] == "4RDTOP" .or. admedt[x,1] == "2RTOP")  .and. (admedt[x,11] > 0  .or. admedt[x,13] > 0)
        FWrite(nArqDmed,SUBSTR(admedt[x,1],2,LEN(admedt[x,1])) + "|" +; // Identificador de registro
	            alltrim(admedt[x,9]) + "|" +; // CPF / CNPJ do prestador de servico
		        admedt[x,10] + "|" +; // Nome / nome empresarial do prestador de servico
		        AllTrim(Replace(Transform(admedt[x,13],MOEDA),',','')) + "|" +; // Valor do reembolso do ano-calendario  
	            AllTrim(Replace(Transform(admedt[x,11],MOEDA),',','')) + "|" + CRLF) // Valor do reembolso de anos anteriores	 
	            nSeq ++
	            fGravaPcj( admedt[x,1] ,;
				           admedt[x,2] ,;
						   admedt[x,3] ,;
						   admedt[x,4] ,;
						   admedt[x,5] ,;
						   admedt[x,6] ,;
						   admedt[x,7] ,;
						   admedt[x,8] ,;
						   admedt[x,9] ,;
						   admedt[x,10],;
						   admedt[x,11],; 
						   admedt[x,13],;
						   nOrder      ,;
						   nSeq        ,;
						   admedt[x,14],;
						   admedt[x,15],;
						   admedt[x,16],;
						   admedt[x,17],;
						   admedt[x,18],;
						   admedt[x,19],;
						   admedt[x,20])
      EndIf	
   EndIf             
  Next
EndIf
Return( )
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
    cSql += " ir_benef_separ_fat ir "
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

cStm := cSql
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cStm),"TRAB",.F.,.T.)
nRet := TRAB->QTDE
TRAB->(dbCloseArea())

Return nRet
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
Local cRet := " "

dbSelectArea("BRP")
BRP->(dbSetOrder(1))

If BRP->(dbSeek(xFilial("BRP")+cGrpPau))
    IF !EMPTY (BRP->BRP_CODSIB)   
	   cRet := strzero(val(BRP->BRP_CODSIB), 2) 
	   
	ELSE      
	   cRet := '10'  
	EndIf   
Else
	Do Case
		Case cGrpPau == '02'
			cRet := '03'
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

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณvalcpf    บaltamiroณCaberj             บ Data ณ  21/12/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica se a duplicidade de CPF para matricula passada    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/  
Static Function Val_cpf( cFamilia  )  

Local l_Ret := .F.   

//3* VERSAO]
/*
cQuery := " SELECT B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC ||B1.BA1_tipreg  MATRIC  FROM  " + RetSqlName("BA1") + " B11 ,  " + RetSqlName("BA1") + " B1 " 
cQuery += " WHERE B11.BA1_FILIAL =' ' AND B11.D_E_L_E_T_=' '  AND B1.BA1_FILIAL= ' ' AND B1.D_E_L_E_T_= ' ' "
cQuery += " AND ((B11.BA1_DATNAS < '19940101') or (B11.BA1_DATNAS >= '19940101'  and b11.ba1_tipusu = 'T')) "   
cQuery += " AND ((B1.BA1_DATNAS < '19940101')  or (B1.BA1_DATNAS >= '19940101'   and b1.ba1_tipusu = 'T'))  "
cQuery += " and b11.BA1_MATVID <> b1.BA1_MATVID AND B11.BA1_CPFUSR = B1.BA1_CPFUSR  and b1.ba1_cpfusr <> ' '"
cQuery += " AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC||B1.BA1_tipreg <> B11.BA1_CODINT|| B11.BA1_CODEMP || B11.BA1_MATRIC ||B11.BA1_tipreg  "
cQuery += " AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC  = '" + cFamilia + "' "      
*/

cQuery := " SELECT B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC ||B1.BA1_tipreg  MATRIC  FROM  " + RetSqlName("BA1") + " B11 ,  " + RetSqlName("BA1") + " B1 " 
cQuery +=  CRLF + " WHERE B11.BA1_FILIAL =' ' AND B11.D_E_L_E_T_=' '  AND B1.BA1_FILIAL= ' ' AND B1.D_E_L_E_T_= ' ' "
cQuery +=  CRLF + " AND ((IDADE_S(TRIM(B11.BA1_DATNAS),'20211231') < 0 ) or (IDADE_S(TRIM(B11.BA1_DATNAS),'20211231') < 0 and b11.ba1_tipusu = 'T')) "   
cQuery +=  CRLF + " AND ((IDADE_S(TRIM(B1.BA1_DATNAS),'20211231')  < 0 ) or (IDADE_S(trim(B1.BA1_DATNAS),'20211231')  < 0 and b1.ba1_tipusu  = 'T')) "
cQuery +=  CRLF + " and b11.BA1_MATVID <> b1.BA1_MATVID AND B11.BA1_CPFUSR = B1.BA1_CPFUSR  and b1.ba1_cpfusr <> ' '"    
                   
cQuery +=  CRLF + " and b1.ba1_mae <> b11.ba1_mae "

cQuery +=  CRLF + " and (b1.ba1_datblo = ' ' or  b1.ba1_datblo > '20211231') and (b11.ba1_datblo = ' ' or  b11.ba1_datblo > '20211231')" 
cQuery +=  CRLF + " and b1.ba1_datinc < '20220101' and b11.ba1_datinc < '20220101' "
cQuery +=  CRLF + " AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC||B1.BA1_tipreg <> B11.BA1_CODINT|| B11.BA1_CODEMP || B11.BA1_MATRIC ||B11.BA1_tipreg  "
cQuery +=  CRLF + " AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC  = '" + cFamilia + "' "  

if  cEmpAnt == '01'  
    cQuery +=  CRLF + " AND B11.BA1_CODEMP NOT IN ('0004','0006','0010','0009')  AND B1.BA1_CODEMP NOT IN ('0004','0006','0010','0009') "
EndIf
If Select("TMP") > 0
	dbSelectArea("TMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "TMP" New     


TMP->( dbGoTop() )

If TMP->( EOF() )
      
	l_Ret := .T.

EndIf              

TMP->(dbCloseArea())         

Return l_Ret   

Static Function fGravaPcj( cTIPO , cCPFUSR , cMVIDAT , cCPFDEP , cMVIDAD , dDTNASD , cNOME , cRELDEP , cCPFREE , cNOMREE , nVLRANT , nVLRATU , nORDCTR , nSEQ , cCODINT , cCODEMP , cMATRIC , cTIPREG , cDIGITO , nReevlAp , nReevlGl)
   
	PCJ->(RecLock("PCJ",.T.))
	PCJ->PCJ_FILIAL := xFilial("PCJ") 
	
	PCJ->PCJ_TIPO   := cTIPO  
	PCJ->PCJ_CPFUSR := cCPFUSR
	PCJ->PCJ_MVIDAT := cMVIDAT
	PCJ->PCJ_CPFDEP := cCPFDEP
	PCJ->PCJ_MVIDAD := cMVIDAD
	PCJ->PCJ_DTNASD := stod(dDTNASD) 
	PCJ->PCJ_NOME   := cNOME
	PCJ->PCJ_RELDEP := cRELDEP 
	PCJ->PCJ_CPFREE := cCPFREE
	PCJ->PCJ_NOMREE := cNOMREE 
	IF cTIPO  $ ('4RDTOP|2RTOP')
       PCJ->PCJ_VLRANT := nVLRANT   
	   PCJ->PCJ_VLRATU := nVLRATU 
	ELSE 
       PCJ->PCJ_VLRANT := 0.00  
	   PCJ->PCJ_VLRATU := nVLRANT
	EndIf    	   
	PCJ->PCJ_ORDCTR := nORDCTR    
	PCJ->PCJ_SEQ    := nSEQ   
	PCJ->PCJ_CODINT := cCODINT  
	PCJ->PCJ_CODEMP := cCODEMP 
	PCJ->PCJ_MATRIC := cMATRIC    
	PCJ->PCJ_TIPREG := cTIPREG    
	PCJ->PCJ_DIGITO := cDIGITO 
    PCJ->PCJ_VLRAPR := nReevlAp 
    PCJ->PCJ_VLRGLO := nReevlGl
                                     
    PCJ->PCJ_ANOREF := 	AllTrim(Str(mv_par02))

	PCJ->(MsUnlock())
                         

RETURN()   
/*
fGravaPcj(        TIPO ,      CPFUSR ,      MVIDAT ,      CPFDEP ,      MVIDAD ,      DTNASD ,        NOME ,   RELDEP   ,       CPFREE ,      NOMREE  , VLRANT       ,       VLRATU , ORDCTR , PCJ_SEQ ,      CODINT  , CODEMP      , MATRIC       , TIPREG       , DIGITO) 
fGravaPcj( admedt[x,1] , admedt[x,2] , admedt[x,3] , admedt[x,4] , admedt[x,5] , admedt[x,6] , admedt[x,7] , admedt[x,8],  admedt[x,9] , admedt[x,10] , admedt[x,11] , admedt[x,13] , nOrder , nSeq    , admedt[x,14] , admedt[x,15], admedt[x,16] , admedt[x,17] , admedt[x,18])
*/
