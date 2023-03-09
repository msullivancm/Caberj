#INCLUDE "RWMAKE.CH"
#INCLUDE "TOTVS.CH"                                                                                                                       
#Include "TopConn.ch"
#Include "TbiConn.ch"
#include "PLSMGER.CH"

#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ CTB_PLS  ∫Autor  ≥ Vitor Sbano        ∫ Data ≥  22/02/2013 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ Contabilizacao CABERJ - Custo                              π±±
±±∫          ≥                                                            π±±                                                                 
±±∫          ≥                                                            π±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Protheus 10 - Contabilidade - Miscelanea - Ctb. Folha View π±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
//
//	Importante:	veja a User Function SIGACTB.prw  (no final rotina) para Declaracao de Variaveis nos LanÁamentos Padronizados desenvolvidos
//					LP 998 e LP997
//
//
//
//
//
*/
// AtualizaÁıes:	10/05/13	- Vitor Sbano	- Adicao de Cod. Cliente (BT5) e Tipo Plano (BI3) 
//					05/09/13	- Vitor Sbano	- Alteracao de Rotina de Contabilizacao de Receita - SE1 - Origem PLS  
//					11/09/13	- Vitor Sbano	- Gravacao de Identificador de Provisao Efetuada - SE1->E1_LAPRO ( Campo Logico - T / F)
//					17/09/13	- Vitor Sbano	- Alteracao de Rotina para Processamento de Cancelamento de Lote Pagamento ( CTBCAB3 )
//					30/09/13	- Vitor Sbano	- Correcao de exclusoa de Temporario (cAliasQry) - Linha 967			
//					08/10/13	- Vitor Sbano	- Inclusao de Variaveis - Integracao de Baixa Financeiro/PLS
//													-> (_cCTADEB,_cCTACRE,_cITEMDEB,_cITEMCRE,_nVLMOV1,_nVLMOV2) 
//												- Alteracao de gravacao de Campo de Provisao (E1_LAPRO)  - contabilizacao Receita
//												- Alteracao de Contabilizacao de Receita para nao efetuar provisao de movimentacao com cancelamento
//													e n„o apropriar cancelamento de receita para titulos n„o provisionados  
//					10/10/13	- Altamiro		- Declaracao da variavel Global    - _cDESCTIP (Descricao da Composicao Titulo)  
//                  11/10/13    - Altamiro      - Declaracao das variaveis Globais - _cCLVLDEB (Classe valor Contabil Baixa - Debito)
//                                                                                   _cCLVLCRE (Classe valor Contabil Baixa - Credito)
//					29/11/13	- Vitor SBANO	- Alteracao de DataBase da ContabilizaÁ„o (considerar a data de registro contabil 
//													como data do parametro de DATA FINAL - solicitacao Bira
//
//					29/07/14 	- Vitor Sbano 	- Alteracao de Processo de Contabilizacao Receita ( CTBCAB2() ) para processamento de Movimento por
//													data de emiss„o (SE1->E1_EMIS1) e geraÁ„o do Lote contabil por Data Emissao
//													-> Ser· adicionado ao arquivo Temporario a Data de Emissao Ctb Tit Receber (SE1->E1_EMIS1)
//														e agbrupamento cont·bil por Data Emissao		   
//      	        06/08/15 	- Altamiro   	- Implementado tratamento para plano odotologico d prefeitura , quando o codtip for 102 e o codigo do evento 
//													for 0103 ou 0105 esse sera tratado como plano na versao 001	  - anida nao implementado 						
//			                                                                                                                                    
//      	        06/10/17 	- Altamiro   	- Implementado tratamento para Codigo da empresa do usario para alimentar a classe de valor 
//													NOVA incluÁ„o n„o existia na implantaÁ„o passa a vigir em xx/xx/xxxx - variavel publica __C_CODEMP	 
//
//      	        23/01/18 	- Altamiro   	- Implementado tratamento para PPCNG - criterio usado se data da emissao >= mes_comp , ano_comp n„o e PPCNG 
//													caso contrario e PPCNG - variavel publica __P_PCNG	
//
//      	        24/01/18 	- Altamiro   	- Implementado tratamento para planos odontologicos / assistencias  
//                                              - criterio utilizados na Ccaberj  , cod. plano igual 0131 , 0133 , 0134 
//                                              - criterio utilizados na Integral , cod. plano igual 0090 , 0091, 0092 , 0088 
//                                                a variavel global __O_DONT sera igual 1 para odontologico e igual a 2 para assitencia
//                                                                                                                                         
//      	        26/01/18 	- Altamiro   	- Implementado tratamento para custo judicial   
//                                                a variavel global __J_UDIC  sera igual 'N'√O judicial , 'S'IM para judicial    
//
//      	        07/02/18 	- Altamiro   	- Implementado tratamento para REVERSAO dos lanÁamento da PPCNG   
//                                                a variavel global __R_EVERS  sera igual 'N'√O REVERT  , 'S'IM REVER         
//      	        28/03/18 	- Altamiro   	- Implementado tratamento para reemcolso extra_roll   
//                                                a variavel global __E_XTRROL  sera igual 'N'√O ROLL  , 'S'IM para EXTRA_ROLL          
//
//     	            22/04/19 	- Altamiro   	- Implementado tratamento para Identificar tipo de administradora 
//                                                a variavel global __T_POPERA  sera igual 'N'√O … ADMINSTRADORA  , 'S'IM … ADMINSTRADORA   
//					
//     	            22/04/19 	- Altamiro   	- Implementado tratamento para Identificar tipo de Conta(capte, pacot , reemb e proce) 
//                                                a variavel global __T_PCONTA que assumira os seguintes valores (capte, pacot , reemb e proce)
//					
//     	            22/04/19 	- Altamiro   	- Implementado tratamento para Identificar tipo de CUSTO (APRES, GLOSA , APROV) 
//                                                a variavel global __T_PCUSTO que assumira os seguintes valores (APRES, GLOSA , APROV)
//
//                  07/05/19 	- Altamiro   	- Implementado do provisionamento da comissao  
//                                                Criada as variavel global PUBLIC  __D_VENDE, DiscriÁ„o do vendedor, __D_EMPRES ,DiscriÁ„o da Empresa que assumira os seguintes valores (APRES, GLOSA , APROV)
//
// *****************************************************************************************************************************
User Function CABA323()

Private l_sai       := .T.
Private _ddatabase  := DDATABASE
Private _nTotal     := 0
Private _cChave     := ""
Private _cNumLote   := ""
Private l_mostra    := .T.
Private lAglutina	:= .F.
Private _dDataAnt	:= dDataBase
Private _cFilOri	:= cFilAnt
Private _cQtdlin	:= 0
Private   nContx    := 0
Private aItens      := {}
Private aCab        := {}
Private	cLote    	:= "009910"
Private cPadrao  	:= "998"
Private cPerg		:= "CABA323X"     
private cEmpresa    := Iif(cEmpAnt == '01','C','I') 

//
Public _nVALOR
Public _cCTADEB
Public _cCTACRE
//
Public 	_CCTPLANO	&& :=	(cArqTMP)->PLANO	      	&& Codigo Plano (BI3_CONTA)
Public 	_NCTGLOSA	&& :=	(cArqTMP)->VLGLOSA			&& Valor Glosa
Public 	_NCTAPROV	&& :=	(cArqTMP)->VL_APROV			&& Valor Aprovado
Public 	_NCTPARTIC	&& :=	(cArqTMP)->VLPARTIC			&& Valor Co-Participacao
Public 	_CCTGRPPL	&& :=	(cArqTMP)->GRPPLANO			&& Grupo Plano
Public 	_CCTNOMPL	&& :=	(cArqTMP)->NOMPLAN			&& NOme Plano
Public 	_CCTPCUST	&& :=	(cArqTMP)->TPCUST			&& Tipo Custo - ZZT_TPCUST
Public 	_CCTPROJ	&& :=	(cArqTMP)->PROJ				&& Proj
Public 	_CTIPCONTR	&& :=	(cArqTMP)->TIPCONTR			&& Tipo Contratacao (BI3_TIPCON  = BII_CODIGO)	
Public 	_cProcDoc	&& := alltrim(_CCTPLANO)+" "+alltrim(_CCTNOMPL)
Public 	_CTIPPLANO	&& :=	(cArqTMP)->TIPPLANO			&& Tipo Plano o (BI3_TIPPLA)
Public 	_CORIGEM	&& :=	(cArqTMP)->ORIGEM			&& Origem
Public 	_CCODCLI	&&:=	(cArqTMP)->CODCLI			&& Codigo Cliente (BT5_CODCLI + BT5_LOJA) - composto

Public 	__C_CODEMP 	&& :=	(cArqTMP)->CODEMP 			&& Codigo da Empresa do beneficiario // altamiro em 06/10/2017       

Public  __P_PCNG    && :=	(cArqTMP)->CODEMP 			&& Codigo que identifica lanc PPCNG ou n„o - 1 nao PPCNG , 2 PPCNG // altamiro em 23/01/2018

Public  __O_DONT    && :=	(cArqTMP)->CODPLA           && Seguindo a regra por empresa 

Public  __J_UDIC   	&& :=	(cArqTMP)->JURID			&& 'N' N„o judicial  , 'S judicial   // altamiro em 26/01/2018  

Public  __E_XTRROL  &&:=    (cArqTMP)->EXTRAROL         && 'N'√O ROLL  , 'S'IM para EXTRA_ROLL                                        

PUBLIC  __T_POPERA  &&:=    IF (cArqTMP)->CODEMP $(CODEMP) sera igual 'N'√O … OPERADORA   , 'S'IM … OPERADORA                                

PUBLIC  __T_PCONTA  &&:=    a variavel global __T_PCONTA que assumira os seguintes valores (capte, pacot , reemb e proc)    

PUBLIC  __T_PCUSTO  &&:=    que assumira os seguintes valores (APRES, GLOSA , APROV)

PUBLIC  __D_VENDE   &&:=    DiscriÁ„o do vendedor

PUBLIC  __D_EMPRES  &&:=    DiscriÁ„o da Empresa

PUBLIC  __N_TITULO  &&:=    Numero do Titulo 

PUBLIC  __C_COMPTE  &&:=    Numero do Titulo - usada na contabilizacao da comissao 

PUBLIC  __D_FORNECE   &&:=    DiscriÁ„o do FORNECEDOR 

PUBLIC  __VL_TITSE2   &&:=    Valor do titulos a pagar ao fornecedor  

PUBLIC  __IR_TITSE2   &&:=    Valor do titulos a pagar ao IR   

PUBLIC  __IS_TITSE2   &&:=    Valor do titulos a pagar ao ISS

PUBLIC  __C_ODRDA     &&:=    CODIGO DO RDA
//Public  __R_EVER    &&      quando  Caberj codtip   = ('920','942','946','904')  'S'IM , caso contrario sera 'N'√O     
//                    &&      quando  Integral codtip = ('901','905','910')        'S'IM , caso contrario sera 'N'√O    
//                    &&      NAO UTILIZADO POS RESSOLVIDO NO LAN«AMENTO PADRAO , REVER LOGICA A FUTURO 

//
cHrIni	:=	time()
//
ALERT("Integracao PLS - Protheus- V. 29/Jul/2014  ")
//
//
//PutSx1( cPerg,"01","Contabilizar (Cust/Rec.)"  ,"","","mv_ch1","N",01,0,0,"C","",""   	,"","","mv_par01" ,"1 Custo     ","1 Custo"     ,"1 Custo"     ,"","2 Receita"  ,"2 Receita" ,"2 Receita",   "","3 Cancel Receita"  ,"3 Cancel Receita" ,"3 Cancel Receita" )

PutSx1(cPerg,"01","Contabilizar ?           "  ,"","","mv_ch01","N",01,0,0,"C","","","","","mv_par01","1 Custo","","","","2 Receita ","","","3 Cancel Receita(Lote Pgto)","","","","","","","","",{},{},{})

//CHAMA OS PARAMETROS
If !Pergunte( cPerg , .T. )
	Return
Endif
//
cLote    := "009910"
cPadrao  := "998"
lPadrao  := VerPadrao(cPadrao)
//
//
// Identifica Processos Contabilizacao a Efetuar (Parametro MV_PAR07)
//
If MV_PAR01 == 1		&& Contabilizacao Custo
	//
	alert("Contabilizacao Custo")
	Processa ({||CTBCAB1()})			&& Contabilizacao Custo
	//
ElseIf MV_PAR01 == 2      && Contabilizacao Receita
	//
	alert("Contabilizacao Receita - Titulos PLS")
	Processa ({||CTBCAB2()})
	//

ElseIf MV_PAR01 == 4      && Contabilizacao Comissao  - Provisionamento
	//
	alert("Contabilizacao Comissao  - Provisionamento")
	Processa ({||CTBCAB4()})
	//

ElseIf MV_PAR01 == 3	  && Contabilziacao Cancelamento Receita (Cancelamento Lote Pagamento)

	alert("Contabilizacao Cancelamento Receita - (Cancelamento Lote Pagamento - PLS)")
	Processa ({||CTBCAB3()})
	//	
Endif	
//
dDatabase	:=	_ddatabase
//
Return()
//
// ******************************************************************************************************************
// ******************************************************************************************************************
// ******************************************************************************************************************
//
/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ CTBCAB1  ∫ Autor ≥ Vitor Sbano        ∫ Data ≥  25/02/13   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Contablizacao de pls - Custo                               ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ SIGAFIN -                                                   ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
static  Function CTBCAB1
//
Local 	cQueryVW	:= ""
Local 	cArqTMP		:= GetNextAlias()
Private cPerg2		:= "CABA323B"
//
PutSx1( cPerg2,"01","Mostra Lancamentos?"       ,"","","mv_ch1","N",01,0,0,"C","",""   	,"","","mv_par01" ,"Sim"         ,"Sim"         ,"Sim"         ,"","N„o"        ,"N„o"       ,"N„o" )
PutSx1( cPerg2,"02","Aglutina Lancto ?"         ,"","","mv_ch2","N",01,0,0,"C","",""   	,"","","mv_par02" ,"Sim"         ,"Sim"         ,"Sim"         ,"","Nao"        ,"Nao"       ,"Nao" )
PutSx1( cPerg2,"03","Tipo de Lancamento?"       ,"","","mv_ch3","N",01,0,0,"C","",""   	,"","","mv_par03" ,"1 Do Mes"    ,"1 Do Mes"    ,"1 Do Mes"    ,"","2 Fora Mes" ,"2 Fora Mes" ,"2 Fora Mes"," 3 Ambos"," 3 Ambos"," 3 Ambos" )
PutSx1( cPerg2,"04","Ano/Mes (AAAAMM)?"         ,"","","mv_ch4","C",06,0,0,"C","",""   	,"","","mv_par04" ,"            ",""            ,""            ,"",""           ,""          ,""         ,""         ,""         ,""      ) 
PutSx1( cPerg2,"05","Do Plano? (somente Custo)" ,"","","mv_ch5","C",04,0,0,"C","",""   	,"","","mv_par05" ,"            ",""            ,""            ,"",""           ,""          ,""         ,""         ,""         ,""      )
PutSx1( cPerg2,"06","Ate o Plano"               ,"","","mv_ch6","C",04,0,0,"C","",""   	,"","","mv_par06" ,"            ",""            ,""            ,"",""           ,""          ,""         ,""         ,""         ,""      )
//
//CHAMA OS PARAMETROS
If !Pergunte( cPerg2 , .T. )
	Return
Endif
//
cMesAno		:=	MV_PAR04
cTipoMov	:= alltrim(str(MV_PAR03))
dMesProc	:=	lastday(stod(mv_par04+"01"))
cPadrao     := "998"
//cPadrao     := "X98"
lPadrao     := VerPadrao(cPadrao)
dDatabase	:=	lastday(stod(mv_par04+"01"))
//dDatabase	:=	stod('20211101')
cLote       := "009910"
//
//MOSTRA LAN«AMENTO
IIF(MV_PAR01=1,l_Mostra := .T.,l_Mostra := .F.)

//AGLUTINA LAN«AMENTO
IIF(MV_PAR02=1,lAglutina := .T.,lAglutina := .F.)     

///cQueryVW1 := " (select max(bd7_numlot) from bd7010 bd7 where bd7_filial = ' ' and d_E_L_E_T_ = ' ' and bd7.bd7_numlot like '"+MV_PAR04+"'||'%')"

// PLANO, GRPPLANO, NOMPLAN, TPCUST, PROJ, TIPCONTR, SUM(VL_APROV) VL_APROV, SUM(VLGLOSA) VLGLOSA,SUM(VLPARTIC) VLPARTIC 
//
cQueryVW := ""
cQueryVW += "SELECT DISTINCT PLANO, CODRDA , GRPPLANO, NOMPLAN, TPCUST, PROJ, TIPCONTR, CODEMP , SUM(VL_APROV) VL_APROV, SUM(VLGLOSA) VLGLOSA,SUM(VLPARTIC) VLPARTIC, TIPPLANO, ORIGEM, CODCLI, SUM(VLRTAD) VLRTAD , JURID ,  EXTRAROL , CONTAB_NOVA FROM ( "+CRLF
//
//	INICIO SECAO 1
//
cQueryVW += " -- Inicio Secao 1   "+CRLF
cQueryVW += "SELECT   "+CRLF
cQueryVW += "  	BD7_CODPLA     PLANO, bd6_codrda codrda,  "+CRLF
cQueryVW += "  	BD6_YNEVEN     Cod_Evento,"+CRLF
cQueryVW += "  	ZZT_EVENTO     NOMEVENT, "+CRLF
cQueryVW += "	QTDE, "+CRLF 

cQueryVW += "	BD6_CODEMP CODEMP , "+CRLF

cQueryVW += "	Sum(BD6F.BD6_QTDPRO) OCORR, "+CRLF
cQueryVW += "   Sum(BD6F.BD6_VLRGLO) VLGLOSA, "+CRLF
cQueryVW += "   Sum(BD7F.VLRPAG)     Vl_Aprov, "+CRLF
cQueryVW += "   sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) VLPARTIC, "+CRLF
cQueryVW += "       DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRPPLANO, "+CRLF
cQueryVW += "       Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOMPLAN, "+CRLF	
cQueryVW += "             ZZT_TPCUST TPCUST, "+CRLF
cQueryVW += "             BD6_YPROJ   PROJ, "+CRLF
cQueryVW += "             'CONTA'     TIPO, "+CRLF
cQueryVW += "             BR8_YINBEN BENEF, "+CRLF
cQueryVW += "             BI3_TIPCON TIPCONTR, "+CRLF    
cQueryVW += "             BI3_TIPPLA TIPPLANO, "+CRLF    
cQueryVW += "             'REDE'     ORIGEM, "+CRLF    
cQueryVW += "             DECODE(BD6_CODEMP,'0004',BT5_CODCLI||BT5_LOJA,  '0009',BT5_CODCLI||BT5_LOJA, '00000000') CODCLI, "+CRLF
cQueryVW += "   Sum(BD6F.BD6_VLRTAD) VLRTAD , decode(trim(bd6_yproju),NULL, 'N' ,'S') jurid , "+CRLF     

cQueryVW += "   'N' EXTRAROL , "+CRLF       

//cQueryVW += "   decode(trim(br8_codrol),Null,'S','N') EXTRAROL ,"+CRLF

cQueryVW += "    RETORNA_DESC_SX5 ( '"+cEmpresa+"','89',RETORNA_NOVA_CONTAB ('"+cEmpresa+"' ,BD6_CODLDP, BD6_CODPAD,BD6_CODPRO, bd6_codrda )) CONTAB_NOVA "+CRLF             

cQueryVW += " FROM "+CRLF
cQueryVW += "      (SELECT BD7.BD7_FILIAL,BD7_CODPLA , "+CRLF
cQueryVW += "              BD7.BD7_OPELOT,"+CRLF
cQueryVW += "              BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO,"+CRLF
cQueryVW += "              BD7.BD7_SEQUEN,  Sum(BD7.BD7_VLRPAG) AS VLRPAG,"+CRLF
cQueryVW += "              COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE "+CRLF

If cempant =='01'
   cQueryVW += "      FROM BD7010 BD7 " +CRLF
Else 
   cQueryVW += "      FROM BD7020 BD7 " +CRLF
EndIf 

cQueryVW += "      WHERE BD7.BD7_FILIAL=' ' "+CRLF

//TRATAMENTO DA RIWA E SERJUS  -  N√O … CONVENIO - ALTAMIRO	04-12-2021
if cempant == '01'
  
  cQueryVW += "      and (BD7_CODEMP not IN ('0013','0017') "
  cQueryVW += "      or   (BD7_CODEMP IN ('0013','0017') AND BD7_DATPRO < '20210801'))"

EndIf  
//

cQueryVW += "      AND BD7.BD7_CODOPE = '0001' "+CRLF
cQueryVW += "      AND BD7.BD7_SITUAC = '1' "+CRLF
cQueryVW += "      AND BD7.BD7_FASE = '4' "+CRLF					&& --TODAS AS GUIAS PAGAS
cQueryVW += "      AND BD7.BD7_CODPLA BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'"+CRLF
cQueryVW += "      and bd7.bd7_blopag <> '1' "+CRLF  

cQueryVW += "      and bd7.bd7_numlot like '"+MV_PAR04+"'||'%'"+CRLF      && Aqui AnoMes 
 
cQueryVW += "      AND BD7.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "      GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7_CODPRO, "+CRLF
cQueryVW += "               BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN) BD7F, "+CRLF


If cempant == '01'
cQueryVW += " BD6010 BD6F ,BI3010 BI3 ,ZZT010  ZZT, "+CRLF
cQueryVW += " BR8010 BR8  ,BT5010 BT5 "+CRLF
Else 
cQueryVW += " BD6020 BD6F ,BI3020 BI3 ,ZZT020  ZZT, "+CRLF
cQueryVW += " BR8020 BR8  ,BT5020  BT5 "+CRLF
EndIf 

cQueryVW += "     WHERE ZZT_FILIAL=' ' "+CRLF
cQueryVW += "       and BI3_FILIAL=' ' "+CRLF
cQueryVW += "       and BR8_FILIAL=' ' "+CRLF
cQueryVW += "       and BT5_FILIAL=' ' "+CRLF

cQueryVW += "       and BD6F.BD6_CODPAD=BR8_CODPAD "+CRLF
cQueryVW += "       and BD6F.BD6_CODPRO=BR8_CODPSA "+CRLF
cQueryVW += "       AND BR8.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "       AND BD6F.BD6_CODPLA BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'"+CRLF
cQueryVW += "       AND BD6F.BD6_FILIAL=' ' "+CRLF
cQueryVW += "       AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL "+CRLF
cQueryVW += "       AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE "+CRLF
cQueryVW += "       AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP "+CRLF
cQueryVW += "       AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG "+CRLF
cQueryVW += "       AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO "+CRLF
cQueryVW += "       AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV "+CRLF
cQueryVW += "       and BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "+CRLF
cQueryVW += "       AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO "+CRLF   
cQueryVW += "       AND BT5.BT5_CODINT = BD6F.BD6_OPEUSR "+CRLF
cQueryVW += "       AND BT5.BT5_CODIGO = BD6F.BD6_CODEMP "+CRLF
cQueryVW += "       AND BT5.BT5_NUMCON = BD6F.BD6_CONEMP "+CRLF	 
cQueryVW += "       AND BI3_FILIAL =BD7_FILIAL "+CRLF
cQueryVW += "       AND BI3_CODINT=BD7_CODOPE "+CRLF
cQueryVW += "       AND BI3_CODIGO=BD7_CODPLA "+CRLF
cQueryVW += "       AND BD6_YNEVEN=ZZT_CODEV "+CRLF
cQueryVW += "       AND BD6F.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "       AND BI3.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "       AND ZZT.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "       AND BT5.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    GROUP BY  BD7_CODPLA,  bd6_codrda , "+CRLF
cQueryVW += "    TRIM(BI3_YGRPLA),Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), "+CRLF
cQueryVW += "    BD6_YNEVEN,"+CRLF
cQueryVW += "    ZZT_EVENTO,QTDE ,ZZT_TPCUST , "+CRLF
cQueryVW += "    BD6_YPROJ, "+CRLF
cQueryVW += "    BR8_YINBEN, "+CRLF
cQueryVW += "    BI3_TIPCON, "+CRLF    
cQueryVW += "    BI3_TIPPLA, "+CRLF     
cQueryVW += "    BD6_CODEMP, "+CRLF    
cQueryVW += "    decode(trim(bd6_yproju),NULL , 'N' ,'S') , "+CRLF

cQueryVW += "    decode(trim(br8_codrol),Null,'S','N') , "+CRLF

cQueryVW += "    'REDE', DECODE(BD6_CODEMP,'0004',BT5_CODCLI||BT5_LOJA,  '0009',BT5_CODCLI||BT5_LOJA,'00000000') , "+CRLF            
cQueryVW += "    RETORNA_DESC_SX5 ( '"+cEmpresa+"','89',RETORNA_NOVA_CONTAB ('"+cEmpresa+"' ,BD6_CODLDP, BD6_CODPAD,BD6_CODPRO , bd6_codrda))  "+CRLF             
cQueryVW += "  UNION ALL "+CRLF                                                                                             

cQueryVW += "  SELECT NVL( RETORNA_PLANO_USU_MS ('"+cEmpresa+"' ,BGQ_CODOPE,BGQ_CODEMP,BGQ_MATRIC,'00','N'),BBB_YCODPL) PLANO, ' ' codrda , "+CRLF
cQueryVW += "         BGQ_YNEVEN CODEVENT, "+CRLF
cQueryVW += "         ZZT_EVENTO NOMEVENT, "+CRLF
cQueryVW += "         Count(DISTINCT BGQ_CODSEQ)QTDE, "+CRLF 

cQueryVW += "         BGQ_CODEMP CODEMP , "+CRLF

cQueryVW += "         Count(BGQ_CODSEQ) OCORR, "+CRLF
cQueryVW += "         0 VLGLOSA, "+CRLF
cQueryVW += "         Sum(Decode(BBB_TIPSER,1,-1*BGQ_VALOR,BGQ_VALOR)) Vl_Aprov, "+CRLF
cQueryVW += "         0 VLPARTIC, "+CRLF
cQueryVW += "         DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRPPLANO, "+CRLF
cQueryVW += "         BI3_NREDUZ NOMPLAN, "+CRLF
cQueryVW += "         ZZT_TPCUST TPCUST , "+CRLF
cQueryVW += "         BGQ_YPROJ PROJ, "+CRLF
cQueryVW += "         'Lancamentos Deb/Cred' Tipo,"+CRLF
cQueryVW += "         '1' BENEF, "+CRLF
cQueryVW += "         BI3_TIPCON	TIPCONTR, "+CRLF  
cQueryVW += "         BI3_TIPPLA	TIPPLANO, "+CRLF  
cQueryVW += "         'REDE'        ORIGEM, "+CRLF    
cQueryVW += "         '00000000'    CODCLI, "+CRLF 
cQueryVW += "         0 VLRTAD , 'N' JURID , 'N' EXTRAROL ,  "+CRLF
cQueryVW += "         RETORNA_DESC_SX5 ( '"+cEmpresa+"','89','PP') CONTAB_NOVA "+CRLF  

If cempant == '01'
   cQueryVW += "       FROM BGQ010 BGQ,  BBB010 BBB, BI3010 BI3  ,ZZT010 ZZT "+CRLF
Else    
   cQueryVW += "       FROM BGQ020 BGQ,  BBB020 BBB, BI3020 BI3  ,ZZT020 ZZT "+CRLF
EndIf    

cQueryVW += "       WHERE BGQ.BGQ_FILIAL = ' ' "+CRLF
cQueryVW += "         AND BGQ.BGQ_CODLAN <> '050' "+CRLF
cQueryVW += "         AND BBB.BBB_FILIAL = ' ' "+CRLF
cQueryVW += "         AND BBB.BBB_CODSER = BGQ.BGQ_CODLAN "+CRLF
cQueryVW += "         AND ZZT_FILIAL = '  ' "+CRLF
cQueryVW += "         AND BGQ.BGQ_YNEVEN=ZZT_CODEV "+CRLF
cQueryVW += "         AND BI3.BI3_FILIAL = '  ' "+CRLF
cQueryVW += "         and BI3.bi3_codigo=nvl( retorna_plano_usu_ms ('"+cEmpresa+"',bgq_codope,bgq_codemp,bgq_matric,'00','N'),bbb_ycodpl) "+CRLF

cQueryVW += "         and BGQ.bgq_numlot like '"+MV_PAR04+"'||'%' "+CRLF 

cQueryVW += "         AND BI3.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "         AND ZZT.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "         AND BGQ.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "         AND BBB.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    GROUP BY NVL( RETORNA_PLANO_USU_MS ('"+cEmpresa+"',BGQ.BGQ_CODOPE,BGQ.BGQ_CODEMP,BGQ.BGQ_MATRIC,'00','N'),BBB.BBB_YCODPL)  , "+CRLF
cQueryVW += "          BGQ.BGQ_YNEVEN ,  ZZT_EVENTO, ZZT_TPCUST, "+CRLF
cQueryVW += "          decode(nvl(trim(BGQ.BGQ_CODEMP),RETORNA_GRUPO_EMP(BI3.BI3_CODIGO)),'0004',2,'0009',2,0), "+CRLF
cQueryVW += "          DECODE(TRIM(BI3.BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO'),BI3_NREDUZ , "+CRLF
cQueryVW += "          BGQ.BGQ_YPROJ, BI3_TIPCON, BI3_TIPPLA , BGQ_CODEMP ,"+CRLF         
cQueryVW += "          RETORNA_DESC_SX5 ( '"+cEmpresa+"','89','PP')  "+CRLF 
cQueryVW += "  -- Fim Secao 1 "+CRLF
cQueryVW += "  -- Inicio Secao 2"+CRLF
//
//	FIM SECAO 1
//
 
cQueryVW += " UNION ALL "+CRLF
&&-- MATERIAL MICROSIGA
cQueryVW += "  -- Inicio Secao 2"+CRLF
cQueryVW += "      SELECT PLANO , codrda ,"+CRLF
cQueryVW += "             CODEVENTO, "+CRLF
cQueryVW += "             NOMEVENT, "+CRLF
cQueryVW += "             SUM(QTDE), "+CRLF
cQueryVW += "             CODEMP, "+CRLF
cQueryVW += "             SUM(OCORR), "+CRLF
cQueryVW += "             SUM(VLGLOSA), "+CRLF
cQueryVW += "             SUM(VL_APROV)  VL_APROV, "+CRLF
cQueryVW += "             SUM(VLPARTIC) VLPARTIC, "+CRLF
cQueryVW += "             GRPPLANO, "+CRLF
cQueryVW += "             NOMPLAN, "+CRLF
cQueryVW += "             TPCUST, "+CRLF
cQueryVW += "             PROJ, "+CRLF
cQueryVW += "             'Material' Tipo, "+CRLF
cQueryVW += "             BENEF, "+CRLF  
cQueryVW += "             TIPCONTR, "+CRLF  
cQueryVW += "             TIPPLANO, "+CRLF  
cQueryVW += "             'REDE'     ORIGEM, "+CRLF    
cQueryVW += "             CODCLI, "+CRLF    
cQueryVW += "   Sum(VLRTAD) VLRTAD  , JURID , EXTRAROL , CONTAB_NOVA "+CRLF
cQueryVW += "FROM( "+CRLF
cQueryVW += "      SELECT BD6_CODPLA PLANO , bd6_codrda codrda , "+CRLF
cQueryVW += "             BD6_YNEVEN CodEvento, "+CRLF
cQueryVW += "             ZZT_EVENTO NOMEVENT,"+CRLF
cQueryVW += "             COUNT(DISTINCT BD6_CODEMP||BD6_MATRIC||BD6_TIPREG) QTDE, "+CRLF     
cQueryVW += "             BD6_CODEMP  CODEMP  , "+CRLF
cQueryVW += "             Sum(D1_QUANT) OCORR, "+CRLF
cQueryVW += "             Sum(BD6_VLRGLO) VLGLOSA, "+CRLF
cQueryVW += "             Sum(D1_TOTAL)-Sum(D1_VALDESC)  Vl_Aprov, "+CRLF
cQueryVW += "             RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'"+cEmpresa+"') VLPARTIC, "+CRLF
cQueryVW += "             0 Vl_Informado,"+CRLF
cQueryVW += "             DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRPPLANO,"+CRLF
cQueryVW += "             Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOMPLAN, "+CRLF
cQueryVW += "             0 Val_adiant , B19_DOC, "+CRLF
cQueryVW += "             ZZT_TPCUST TPCUST,"+CRLF
cQueryVW += "             BD6_YPROJ PROJ, "+CRLF
cQueryVW += "             BR8_YINBEN BENEF, "+CRLF
cQueryVW += "             BI3_TIPCON TIPCONTR, "+CRLF  
cQueryVW += "             BI3_TIPPLA TIPPLANO, "+CRLF  
cQueryVW += "             DECODE(BD6_CODEMP,'0004',BT5_CODCLI||BT5_LOJA, '00000000') CODCLI, "+CRLF
cQueryVW += "             Sum(BD6.BD6_VLRTAD) VLRTAD ,"+CRLF 
cQueryVW += "             decode(TRIM(bd6_yproju),NULL , 'N' ,'S') jurid , "+CRLF   

cQueryVW += "   'N' EXTRAROL , "+CRLF       

//cQueryVW += "             decode(trim(br8_codrol),Null,'S','N') EXTRAROL ,"+CRLF       

cQueryVW += "             RETORNA_DESC_SX5 ( '"+cEmpresa+"','89',RETORNA_NOVA_CONTAB ('"+cEmpresa+"' ,BD6_CODLDP, BD6_CODPAD,BD6_CODPRO , bd6_codrda)) CONTAB_NOVA "+CRLF 

If cempant == '01'
   cQueryVW += "   from B19010 B19, SD1010 SD1 , SF1010 SF1, BD6010 BD6 , "+CRLF
   cQueryVW += "        SA2010 SA2, ZZT010 ZZT , BI3010 BI3, "+CRLF
   cQueryVW += "        BR8010  BR8 ,BT5010 BT5 " +CRLF
else    
   cQueryVW += "   from B19020 B19, SD1020 SD1 , SF1020 SF1, BD6020 BD6 , "+CRLF
   cQueryVW += "        SA2020 SA2, ZZT020 ZZT , BI3020 BI3, "+CRLF
   cQueryVW += "        BR8020 BR8 ,BT5020 BT5 " +CRLF
EndIf

cQueryVW += "  WHERE BI3.BI3_FILIAL=' ' "+CRLF
cQueryVW += "    and SA2.a2_filial=' ' "+CRLF
cQueryVW += "    and BT5.BT5_filial=' ' "+CRLF     

cQueryVW += "    AND F1_YDTCON LIKE '"+MV_PAR04+"'||'%' "+CRLF
   
cQueryVW += "    AND SA2.A2_COD = B19.B19_FORNEC "+CRLF
cQueryVW += "    AND SD1.D1_FORNECE= SA2.A2_COD "+CRLF
cQueryVW += "    AND SF1.f1_FORNECE= SA2.A2_COD "+CRLF
cQueryVW += "    AND SD1.D1_DOC = SF1.F1_DOC "+CRLF
cQueryVW += "    AND B19.B19_DOC = SD1.D1_DOC "+CRLF
cQueryVW += "    AND SD1.D1_ITEM = B19.B19_ITEM "+CRLF
cQueryVW += "    and BD6.BD6_FILIAL = ' ' "+CRLF
cQueryVW += "    AND BD6.BD6_CODPLA BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'"+CRLF

cQueryVW += "    AND ZZT.ZZT_FILIAL=' ' "+CRLF
cQueryVW += "    and BR8.BR8_FILIAL=' ' "+CRLF

cQueryVW += "    and BD6.BD6_CODPAD= BR8.BR8_CODPAD "+CRLF
cQueryVW += "    and BD6.BD6_CODPRO= BR8.BR8_CODPSA "+CRLF
cQueryVW += "    AND BD6_CODPLA=BI3_CODIGO "+CRLF
cQueryVW += "    AND BD6_CODOPE = SubStr(B19_GUIA,01,04) "+CRLF
cQueryVW += "    AND BD6_CODLDP = SubStr(B19_GUIA,05,04) "+CRLF
cQueryVW += "    AND BD6_CODPEG = SubStr(B19_GUIA,09,08) "+CRLF
cQueryVW += "    AND BD6_NUMERO = SubStr(B19_GUIA,17,08) "+CRLF
cQueryVW += "    AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) "+CRLF
cQueryVW += "    AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) "+CRLF
cQueryVW += "    AND BT5.BT5_CODINT = BD6.BD6_OPEUSR "+CRLF   
cQueryVW += "    AND BT5.BT5_CODIGO = BD6.BD6_CODEMP "+CRLF	   
cQueryVW += "    AND BT5.BT5_NUMCON = BD6.BD6_CONEMP "+CRLF	 
cQueryVW += "    and bd6_fase in (3,4) "+CRLF
cQueryVW += "    AND BD6_CODLDP='0013' "+CRLF
cQueryVW += "    AND BD6_SITUAC = 1 "+CRLF
cQueryVW += "    AND BD6_YNEVEN=ZZT_CODEV "+CRLF
cQueryVW += "    AND SA2.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    AND B19.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    AND SD1.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    AND SF1.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    AND BD6.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    AND ZZT.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    AND BI3.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    AND BR8.D_E_L_E_T_=' ' "+CRLF 
cQueryVW += "    AND BT5.D_E_L_E_T_=' ' "+CRLF 
cQueryVW += "    GROUP by BD6_CODEMP , BD6_codrda ,"+CRLF
cQueryVW += "          BD6_CODPLA, "+CRLF
cQueryVW += "          TRIM(BI3_YGRPLA),Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ),  "+CRLF
cQueryVW += "          BD6_YNEVEN, B19_DOC, "+CRLF
cQueryVW += "          ZZT_EVENTO,ZZT_TPCUST, "+CRLF
cQueryVW += "          BD6_YPROJ, "+CRLF
cQueryVW += "          RETORNA_VL_COPART_OPME (BD6_CODOPE,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO,'"+cEmpresa+"'), "+CRLF
cQueryVW += "          BR8_YINBEN, BI3_TIPCON, BI3_TIPPLA, DECODE(BD6_CODEMP,'0004',BT5_CODCLI||BT5_LOJA, '00000000') , "+CRLF 
cQueryVW += "          decode(TRIM(bd6_yproju),NULL , 'N' ,'S')  ,"+CRLF

cQueryVW += "          decode(trim(br8_codrol),Null,'S','N') ,"+CRLF       

cQueryVW += "          RETORNA_DESC_SX5 ( '"+cEmpresa+"','89',RETORNA_NOVA_CONTAB ('"+cEmpresa+"' ,BD6_CODLDP, BD6_CODPAD,BD6_CODPRO , bd6_codrda )))  "+CRLF 
  
cQueryVW += "  GROUP BY PLANO , codrda , NOMEVENT, "+CRLF
cQueryVW += "           CODEVENTO, "+CRLF
cQueryVW += "           GRPPLANO, "+CRLF
cQueryVW += "           NOMPLAN, "+CRLF    
cQueryVW += "           CODEMP "+CRLF
cQueryVW += "           ,TPCUST,PROJ,BENEF, TIPCONTR, TIPPLANO, CODCLI , JURID , EXTRAROL , CONTAB_NOVA"+CRLF
cQueryVW += "  -- Fim Secao 2 - Material Microsiga "+CRLF
// Fim Secao 2
//
 
cQueryVW += " UNION ALL "+CRLF
&&--REEMBOLSO MICROSIGA
cQueryVW += "  -- Inicio Secao 3 - Reembolso Microsiga "+CRLF
cQueryVW += "     SELECT Nvl(Trim(BA1_CODPLA),BA3_CODPLA)  Plano , bd6_codrda codrda , "+CRLF
cQueryVW += "            BD6_YNEVEN CODEVENT, "+CRLF 
cQueryVW += "            ZZT_EVENTO NOMEVENT, "+CRLF
cQueryVW += "            COUNT(DISTINCT B44_OPEUSR||B44_CODEMP||B44_MATRIC||B44_TIPREG) Qtde, "+CRLF  
cQueryVW += "            BD6_CODEMP CODEMP ,  "+CRLF
cQueryVW += "            Sum(B45_QTDPRO) OCORR, "+CRLF
cQueryVW += "            Sum(B45_VLRGLO) VLGLOSA, "+CRLF
cQueryVW += "            Sum(B45_VLRPAG) Val_Aprov, "+CRLF
cQueryVW += "            0 VLPARTIC, "+CRLF
cQueryVW += "            --Sum(B45_VLRMAN) Vl_informado, "+CRLF
cQueryVW += "            DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRPPLANO, "+CRLF
cQueryVW += "            Decode(B44_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOMPLAN, "+CRLF
cQueryVW += "            ZZT_TPCUST TPCUST, "+CRLF
cQueryVW += "            BD6_YPROJ PROJ, "+CRLF
cQueryVW += "            'Reembolso' Tipo, "+CRLF
cQueryVW += "            (case when (B45_ZZZCOD not in('04','11','21','29','37','45','53','75','83','91','99','9H','9O','9S','9V','00','9Z','AA','AI', "+CRLF
cQueryVW += "                        'AQ','AY','B6','BE','BM','BU','C4','C8','CB','CG','CN','CU','D1','DD','DW','E5','ED') "+CRLF
cQueryVW += "            AND ZZQ_TIPPRO<>'1'  ) "+CRLF
cQueryVW += " then '2'  "+CRLF
cQueryVW += " else '1' "+CRLF
cQueryVW += " end "+CRLF
cQueryVW += ") BENEF, "+CRLF
cQueryVW += "  BI3_TIPCON TIPCONTR, "+CRLF  
cQueryVW += "  BI3_TIPPLA TIPPLANO, "+CRLF  
cQueryVW += " 'REEM' ORIGEM, "+CRLF
 
cQueryVW += "  DECODE(BD6_CODEMP,'0004',BT5_CODCLI||BT5_LOJA, '00000000') CODCLI, "+CRLF     
cQueryVW += "  0 VLRTAD , decode(TRIM(b44_yproju),NULL , 'N' ,'S') jurid , "+CRLF       

cQueryVW += "  DECODE(ZZQ_TPSOL,2,'S','N')EXTRAROL , "+CRLF 

cQueryVW += "  RETORNA_DESC_SX5 ( '"+cEmpresa+"','89',RETORNA_NOVA_CONTAB ('"+cEmpresa+"' ,BD6_CODLDP, BD6_CODPAD,BD6_CODPRO , bd6_codrda)) CONTAB_NOVA "+CRLF 
 
If cempant == '01'
   cQueryVW += "        from B44010 C, B45010 D ,SE1010 T ,BA1010 U,"+CRLF
   cQueryVW += "             BA3010 F ,BI3010 BI3 ,BG9010 BG9 , BT5010 BT5, "+CRLF
   cQueryVW += "             ZZT010 ZZT, BD6010 BD6, BR8010 BR8, ZZQ010 ZZQ "+CRLF
Else   
   cQueryVW += "        from B44020 C, B45020 D ,SE1020 T ,BA1020 U,"+CRLF
   cQueryVW += "             BA3020 F ,BI3020 BI3 ,BG9020 BG9 , BT5020 BT5, "+CRLF
   cQueryVW += "             ZZT020 ZZT, BD6020 BD6, BR8020 BR8, ZZQ020 ZZQ "+CRLF
EndIf    
 
cQueryVW += "       WHERE B45_FILIAL=' ' "+CRLF
cQueryVW += "         AND B44_FILIAL=' ' "+CRLF
cQueryVW += "         AND BI3_FILIAL=' ' "+CRLF
cQueryVW += "         AND BA3_FILIAL=' ' "+CRLF
cQueryVW += "         AND BA1_FILIAL=' ' "+CRLF
cQueryVW += "         AND BG9_FILIAL=' ' "+CRLF
cQueryVW += "         AND ZZT_FILIAL=' ' "+CRLF
cQueryVW += "         and BD6_FILIAL=' ' "+CRLF
cQueryVW += "         AND ZZQ_FILIAL=' ' "+CRLF
cQueryVW += "         and BR8_FILIAL=' ' "+CRLF

cQueryVW += "         AND E1_FILIAL='01' "+CRLF
cQueryVW += "         AND E1_PREFIXO='RLE' "+CRLF
cQueryVW += "         AND B44_CODLDP=B45_CODLDP "+CRLF
cQueryVW += "         AND B44_CODPEG=B45_CODPEG "+CRLF
cQueryVW += "         AND B44_NUMAUT=B45_NUMAUT "+CRLF
cQueryVW += "         AND B44_PREFIX =E1_PREFIXO "+CRLF
cQueryVW += "         AND B44_NUM=E1_NUM "+CRLF
cQueryVW += "         AND BA1_CODINT=BA3_CODINT "+CRLF
cQueryVW += "         AND BA1_CODEMP=BA3_CODEMP "+CRLF
cQueryVW += "         AND BA1_MATRIC=BA3_MATRIC "+CRLF
cQueryVW += "         AND BA1_CODINT=B44_OPEUSR "+CRLF
cQueryVW += "         AND BA1_CODEMP=B44_CODEMP "+CRLF
cQueryVW += "         AND BA1_MATRIC=B44_MATRIC "+CRLF
cQueryVW += "         AND BA1_TIPREG=B44_TIPREG "+CRLF
cQueryVW += "         AND BI3_CODINT=BA1_CODINT "+CRLF
cQueryVW += "         AND B44_OPEUSR=BG9_CODINT "+CRLF
cQueryVW += "         AND B44_CODEMP=BG9_CODIGO "+CRLF
cQueryVW += "         and BD6_CODPAD=BR8_CODPAD "+CRLF
cQueryVW += "         and BD6_CODPRO=BR8_CODPSA "+CRLF
cQueryVW += "         AND BD6.BD6_CODPLA BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'"+CRLF
cQueryVW += "         and ( "+CRLF

cQueryVW += "        (("+cTipoMov+"=2) and (1=2))  or "+CRLF
cQueryVW += "         (("+cTipoMov+"<>2) and (1=1)))  "+CRLF

cQueryVW += "         AND BI3_CODIGO=Nvl(Trim(BA1_CODPLA),BA3_CODPLA) "+CRLF

cQueryVW += "    AND B44_YDTCON LIKE '"+MV_PAR04+"'||'%' "+CRLF                                                                                                 
      
cQueryVW += "    AND BD6_CODOPE='0001' "+CRLF
cQueryVW += "    AND B45_CODLDP=BD6_CODLDP "+CRLF
cQueryVW += "    AND B45_CODPEG=BD6_CODPEG "+CRLF
cQueryVW += "    AND B45_NUMERO=BD6_NUMERO "+CRLF
cQueryVW += "    AND B45_SEQUEN=BD6_SEQUEN "+CRLF
cQueryVW += "    AND B45_CODPAD=BD6_CODPAD "+CRLF
cQueryVW += "    AND B45_CODPRO=BD6_CODPRO "+CRLF
cQueryVW += "    and BD6_YNEVEN=ZZT_CODEV "+CRLF
cQueryVW += "    AND BT5.BT5_CODINT = BD6.BD6_OPEUSR "+CRLF   
cQueryVW += "  	 AND BT5.BT5_CODIGO = BD6.BD6_CODEMP "+CRLF	   
cQueryVW += "    AND BT5.BT5_NUMCON = BD6.BD6_CONEMP "+CRLF	 
cQueryVW += "    AND ZZQ_SEQUEN = B44_YCDPTC  "+CRLF
cQueryVW += "    AND C.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "    AND D.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "    AND T.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "    AND U.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "    AND F.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "    AND BI3.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    AND BG9.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "    AND ZZT.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "    AND ZZQ.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "    AND BD6.D_E_L_E_T_=' ' "+CRLF  
cQueryVW += "    AND BR8.D_E_L_E_T_=' ' "+CRLF
cQueryVW += "    AND BT5.D_E_L_E_T_=' ' "+CRLF  
cQueryVW += "  GROUP BY "+CRLF
cQueryVW += "        Nvl(Trim(BA1_CODPLA),BA3_CODPLA) , bd6_codrda , "+CRLF
cQueryVW += "        DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') , "+CRLF
cQueryVW += "        Decode(B44_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), "+CRLF
cQueryVW += "        B44_ANOAUT,B44_MESAUT, "+CRLF
cQueryVW += "        ZZT_EVENTO,ZZT_TPCUST  , "+CRLF
cQueryVW += "        BD6_YNEVEN, BD6_CODEMP , "+CRLF
cQueryVW += "        BD6_YPROJ, "+CRLF    
cQueryVW += "        (case when (B45_ZZZCOD not in('04','11','21','29','37','45','53','75','83','91','99','9H','9O','9S','9V','00','9Z','AA','AI', "+CRLF
cQueryVW += "                    'AQ','AY','B6','BE','BM','BU','C4','C8','CB','CG','CN','CU','D1','DD','DW','E5','ED') "+CRLF
cQueryVW += "        AND ZZQ_TIPPRO<>'1'  ) "+CRLF
cQueryVW += "        then '2'  else '1' end), "+CRLF
cQueryVW += "        BI3_TIPCON, BI3_TIPPLA,  DECODE(BD6_CODEMP,'0004',BT5_CODCLI||BT5_LOJA, '00000000') ,"+CRLF
cQueryVW += "        decode(TRIM(b44_yproju),NULL , 'N' ,'S') ,  DECODE(ZZQ_TPSOL,2,'S','N') ,"+CRLF
cQueryVW += "        RETORNA_DESC_SX5 ( '"+cEmpresa+"','89',RETORNA_NOVA_CONTAB ('"+cEmpresa+"' ,BD6_CODLDP, BD6_CODPAD,BD6_CODPRO, bd6_codrda )) "+CRLF 
                           
cQueryVW += "  -- Fim Secao 3 - Reembolso Microsiga "+CRLF    

//
//
//cQueryVW += " )  where CODEMP In ('0013','0017') GROUP BY  PLANO, GRPPLANO, NOMPLAN, TPCUST, PROJ, TIPCONTR, TIPPLANO, ORIGEM, CODCLI, CODEMP , JURID , EXTRAROL , CONTAB_NOVA "+CRLF
cQueryVW += " ) GROUP BY  PLANO,  codrda , GRPPLANO, NOMPLAN, TPCUST, PROJ, TIPCONTR, TIPPLANO, ORIGEM, CODCLI, CODEMP , JURID , EXTRAROL , CONTAB_NOVA "+CRLF
cQueryVW += "   ORDER BY  PLANO, GRPPLANO, NOMPLAN, TPCUST, PROJ, TIPCONTR, TIPPLANO,ORIGEM, CODCLI , CODEMP  "+CRLF
//
If Select(cArqTMP) > 0
	dbSelectArea(cArqTMP)
	dbCloseArea()
EndIf
MemoWrite("C:\Temp1\CTB_PLS.txt",cQueryVW)
//DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQueryVW), cArqTMP, .F., .T.) 
TcQuery cQueryVW New Alias (cArqTMP) New  
//
dbSelectArea(cArqTMP)
dbGoTop()
//
cArquivo := ""
nHdlPrv  := HeadProva(cLote,"PLS",Substr(cUsuario,7,6),@cArquivo)
_aArea	:=	GetArea()
//
nTotReg	:=	0                                                                              
nValLan	:= 0
nSeq	:= 0
_cANOMES	:=	MV_PAR04
//
Do While (cArqTMP)->(!Eof())
 	
	_CCTPLANO	:=	(cArqTMP)->PLANO	        && Codigo Plano (BI3_CONTA)
	_NCTGLOSA	:=	(cArqTMP)->VLGLOSA			&& Valor Glosa
	_NCTAPROV	:=	(cArqTMP)->VL_APROV			&& Valor Aprovado
	_NCTPARTIC	:=	(cArqTMP)->VLPARTIC			&& Valor Co-Participacao
	_CCTGRPPL	:=	(cArqTMP)->GRPPLANO			&& Grupo Plano
	_CCTNOMPL	:=	(cArqTMP)->NOMPLAN			&& NOme Plano
	_CCTPCUST	:=	(cArqTMP)->TPCUST			&& Tipo Custo - ZZT_TPCUST
	_CCTPROJ	:=	(cArqTMP)->PROJ				&& Proj
	_CTIPCONTR	:=	(cArqTMP)->TIPCONTR			&& Tipo Contratacao (BI3_TIPCON  = BII_CODIGO)	
	_cProcDoc	:= alltrim(_CCTPLANO)+" "+alltrim(_CCTNOMPL)
	_CTIPPLANO	:=	(cArqTMP)->TIPPLANO			&& Tipo Plano o (BI3_TIPPLA)
	_CORIGEM	:=	(cArqTMP)->ORIGEM			&& Origem
	_CCODCLI	:=	(cArqTMP)->CODCLI			&& Codigo Cliente (BT5_CODCLI + BT5_LOJA) - composto 
	_NCTVLTAD	:=	(cArqTMP)->VLRTAD			&& Valor Taxa de Administracao	                   
	
	__C_CODEMP  :=  (cArqTMP)->CODEMP 			&& Cod da empresa do usuario                    
	
	__J_UDIC   	:=	(cArqTMP)->JURID			&& 'N' N„o judicial  , 'S judicial   // altamiro em 26/01/2018  
	
    __E_XTRROL  :=  trim((cArqTMP)->EXTRAROL)         && 'N'√O ROLL  , 'S'IM para EXTRA_ROLL  

	__C_ODRDA  :=  trim((cArqTMP)->CODRDA)         && 'N'√O ROLL  , 'S'IM para EXTRA_ROLL  
    
    
   If cEmpresa == 'C' 
	 		   
	  If TRIM((cArqTMP)->PLANO) $"0098|0099|0131|0133|0134"
          __O_DONT := '1'	
      Else     		    
          __O_DONT := '2'
      EndIf    	  
            
   Else 
            
      If TRIM((cArqTMP)->PLANO) $"0088|0090|0091|0092|0180|0181|0182|0183"
          __O_DONT := '1'	
      Else     		    
          __O_DONT := '2'
      EndIf    	                        
            
   EndIf      

// - incluido empresa 0352 - chamado 67645
    If cEmpAnt == '02' .and. (cArqTMP)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282'
       __T_POPERA := 'S'
    Else                
       __T_POPERA := 'N'
    EndIf  
    
    If trim((cArqTMP)->CONTAB_NOVA)     =='PAGAMENTO POR PROCEDIMENTO'     
	   __T_PCONTA := '1' 
    ElseIf trim((cArqTMP)->CONTAB_NOVA) =='PAGAMENTO POR CAPTATION'     
	   __T_PCONTA := '2'
    ElseIf trim((cArqTMP)->CONTAB_NOVA) =='PAGAMENTO POR PACOTE'     
	   __T_PCONTA := '3'
    ElseIf trim((cArqTMP)->CONTAB_NOVA) =='PAGAMENTO POR REEMBOLSO'    
	   __T_PCONTA := '4'
    Else     
	   __T_PCONTA := '5'    	    	    	    
	EndIf     
	    
	
	dbSelectArea(cArqTMP)
 	nTotReg	++
 	//
 	IncProc(" Processando ..." + _cProcDoc )
 	//
 	_nVALOR		:=	0
 	//
 	_nTotal    += DetProva(nHdlPrv,cPadrao,"PLS",cLote)
 	nSeq ++
 	//
 	(cArqTMP)->(DbSkip())
 	//
 Enddo
//
RodaProva(nHdlPrv,_nTotal)
cA100Incl(cArquivo,nHdlPrv,3,cLote,l_Mostra,lAglutina)
nSeq := 0
//
If Select(cArqTMP) > 0
	dbSelectArea(cArqTMP)
	dbCloseArea()
EndIf
//
return 
//
//
// ******************************************************************************************************************
// ******************************************************************************************************************
//
//   ********************            FIM PROCESSAMENTO - CONTABILIZACAO CUSTO      *************************
//
// ******************************************************************************************************************
// ******************************************************************************************************************
//   
//
/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ SIGACTB  ∫ Autor ≥ Vitor Sbano        ∫ Data ≥  22/02/13   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Declaracao de Variaveis Publicas utilizadas                ∫±±
±±∫          ≥ na rotina de Contabilizacao Custo / Lancto Padr„o          ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ SIGACTB                                                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/

static Function SIGACTB

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Declaracao de Variaveis                                             ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ     
//
//	Contabilizacao Custo - Rotina CTB_PLS		- Declaracao de Variaveis
//
//     Habilitar / declaracao de Vari·veis  
Public	_CCTPLANO	:=	SPACE(1)		&& Plano
Public	_CCTEVENTO	:=	SPACE(1)        && Evento
Public	_CCTNOMEV	:=	SPACE(1)	    && NOME Evento
Public	_CCTQTDE	:=	0	
Public	_CCTOCORR	:=	SPACE(1)	
Public	_NCTGLOSA	:=	0				&& Valor Glosa
Public	_NCTAPROV	:=	0	            && Valor Aprovado
Public	_NCTPARTIC	:=	0				&& Valor Co-participacao
Public	_NCTEXPOS	:=	0				
Public	_CCTGRPPL	:=	SPACE(1)
Public	_CCTNOMPL	:=	SPACE(1)	
Public	_CCTPCUST	:=	SPACE(1)
Public	_CCTPROJ	:=	SPACE(1)		&&  Projeto
Public	_CCTTIPO	:=	SPACE(1)	
Public	_CCTBENEF	:=	SPACE(1)
Public	_cCONTA		:=	SPACE(1)		&& Debito
Public	_cCGLOSA	:=	SPACE(1)		&& Glosa
Public	_cCCOCRD	:=	SPACE(1)		&& Conta Credito Co-Participacao		
Public	_cCCODEB	:=	SPACE(1)		&& Conta Debito Co-Participacao  
Public  _cANOMES	:=	space(1)		&& Ano/Mes processamento
Public 	_CTIPCONTR	:=	SPACE(1)	&& :=	(cArqTMP)->TIPCONTR			&& Tipo Contratacao (BI3_TIPCON  = BII_CODIGO)	
Public 	_cProcDoc	:=	SPACE(1)	&& := alltrim(_CCTPLANO)+" "+alltrim(_CCTNOMPL)
Public 	_CTIPPLANO	:=	SPACE(1)	&& :=	(cArqTMP)->TIPPLANO			&& Tipo Plano o (BI3_TIPPLA)
Public 	_CORIGEM	:=	SPACE(1)	&& :=	(cArqTMP)->ORIGEM			&& Origem
Public 	_CCODCLI	:=	SPACE(1)	&&:=	(cArqTMP)->CODCLI			&& Codigo Cliente (BT5_CODCLI + BT5_LOJA) - composto 
//
Public _NCTVLTAD	:= 	0				&& Taxa Administrativa???? 
//		                                
//	Contabilizacao Receita - Rotina CTB_PLS		- Declaracao de Variaveis
//
Public	_cPLANO		:=  space(1) 	&&	Codigo Plano
Public	_cDESCPLAN  :=	space(1)    &&	Descricao Plano
Public	_cEVENTO    :=  space(1)	&& 	Codigo Evento
Public	_nVLMENS    :=  0			&&	Valor Mensalidade
Public	_nVLOPCI    :=  0			&& 	Valor Opcionais
Public	_nVLADES    :=  0			&&	Valor Taxa Adesao
Public	_nVLDEBI    :=  0			&&	Valor Debitos
Public	_nVLCRED    :=  0			&&	Valor Creditos
Public	_nVLPART    :=  0			&&	Valor Participacao (co-participacao)
Public	_nVLTARI    :=  0			&&	Valor Tarifas
Public	_nVLFARM    :=  0			&&	Valor Farmacia
Public	_nVLGUIA    :=  0			&&	Valor Guia MÈdico
Public	_nVLCART    :=  0			&&	Valor Cartao
Public  _nVLTOTAL   :=  0			&&	Valor TOTAL
//
// Contabilizacao de Integracao de Baixa - PLS
Public	_cCTADEB	:=  space(1) 	&&	Conta Contabil de Baixa - Debito
Public	_cCTACRE	:=	space(1)    &&	Conta Contabil de Baixa - Credito
Public	_cITEMDEB   :=  space(1)	&& 	Item Contaabil Baixa - Debito
Public	_cITEMCRE   :=  space(1)	&&	Item Contaabil Baixa - Credito   
Public	_cCLVLDEB   :=  space(1)	&& 	Classe valor Contabil Baixa - Debito
Public	_cCLVLCRE   :=  space(1)	&&	Classe valor Contabil Baixa - Credito
Public	_nVLMOV1 	:=  space(1)	&&	Valor Movimentacao Bx - 1
Public	_nVLMOV2 	:=  space(1)	&&	Valor Movimentacao Bx - 2
Public	_cDESCTIP 	:=  space(1)	&&	decriÁ„o da compossiÁ„o do titulos 

//                                                                          

Return

//
// *********************************************************************************************************************
//
//
//


/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ CTBCAB2  ∫ Autor ≥ Vitor Sbano        ∫ Data ≥  03/09/13   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Contablizacao de pls - Receita                             ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ SIGACTB -                                                  ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
static Function CTBCAB2
//                    
Local 	cQuery		:= ""
Local 	cAliasQry	:= GetNextAlias()   
Local 	cAliasQry1	:= GetNextAlias()
Local 	cAliasQ2	:= GetNextAlias()
Private cPerg2		:= "CABA323E"
//
PutSx1( cPerg2,"01","Mostra LanÁamentos?"      ,"","","mv_ch1","N", 1   ,0,0,"C","",""      ,"","","MV_PAR01","Sim",,,,"Nao")
PutSx1( cPerg2,"02","Aglutina LanÁamentos?"    ,"","","mv_ch2","N", 1   ,0,0,"C","",""      ,"","","MV_PAR02","Sim",,,,"Nao")
PutSx1( cPerg2,"03","Da Data Emissao ?"        ,"","","mv_ch3","D",08   ,0,0,"G","",""	 	,"","","MV_PAR03")
PutSx1( cPerg2,"04","Ate Data Emissao?"        ,"","","mv_ch4","D",08   ,0,0,"G","",""		,"","","MV_PAR04")
PutSx1( cPerg2,"05","Da Filial ?"    		   ,"","","mv_ch5","C",02   ,0,0,"G","","XM0"   ,"","","MV_PAR05")
PutSx1( cPerg2,"06","Ate a Filial?"			   ,"","","mv_ch6","C",02   ,0,0,"G","","XM0"   ,"","","MV_PAR06")
PutSx1( cPerg2,"07","Do Prefixo ?"    		   ,"","","mv_ch7","C",03   ,0,0,"G","",""      ,"","","MV_PAR07")
PutSx1( cPerg2,"08","Ate o Prefixo?"		   ,"","","mv_ch8","C",03   ,0,0,"G","",""      ,"","","MV_PAR08")
PutSx1( cPerg2,"09","Atual Ident Prov Ctb?"    ,"","","mv_ch9","N", 1   ,0,0,"C","",""      ,"","","MV_PAR09","1 Sim",,,,"2 Nao")      

PutSx1( cPerg2,"10","Da Empresa "    		   ,"","","mv_ch10","C",04   ,0,0,"G","",""      ,"","","MV_PAR10")
PutSx1( cPerg2,"11","Ate a Empresa "		   ,"","","mv_ch11","C",04   ,0,0,"G","",""      ,"","","MV_PAR11")    

PutSx1( cPerg2,"12","Empresa n„o Sair "		   ,"","","mv_ch12","C",80   ,0,0,"G","",""      ,"","","MV_PAR12")
//                   
MsgInfo(" CABA323 - 29/07/14 - Em ValidaÁ„o - ContabilizaÁ„o por Data Emissao (E1_EMIS1)","CABER - Contabilizacao Receita")
//CHAMA OS PARAMETROS
If !Pergunte( cPerg2 , .T. )
	Return
Endif
//
/*                  
If MV_PAR09 = 2		&&  Nao Atual Ident Prov Ctb
	//
	MsgInfo("Atencao - Rotina ajustada para Registrar Processamento Prov. Receita (E1_LAPRO)","CABERJ - Contabilizacao Receita")
	//
	MV_PAR09	:= 1
	//
Endif
*/
//
//dDatabase	:=	(lastday(mv_par03))+1		&& 29/11/13 - Vitor Sbano
dDatabase	:=	mv_par04
//
cPadrao  := "990"
lPadrao  := VerPadrao(cPadrao)
cLote    := "009950"
cArquivo := ""
nHdlPrv  := HeadProva(cLote,"PLS",Substr(cUsuario,7,6),@cArquivo)
_aArea	:=	GetArea()
//
nTotReg		:= 0
nCountnx	:= 0
nValLan		:= 0
nSeq		:= 0
_nTotVlr	:= 0
//
//MOSTRA LAN«AMENTO
IIF(MV_PAR01=1,l_Mostra := .T.,l_Mostra := .F.)

//AGLUTINA LAN«AMENTO
IIF(MV_PAR02=1,lAglutina := .T.,lAglutina := .F.)
//
//
cQuery := " "
   cQuery += "SELECT CASE  WHEN substr(e1_emissao, 1,6) >= e1_anobase || e1_mesbase  THEN '1' ELSE '2'END  PPCNG , (e1_anobase || e1_mesbase ||'01') DtPPCNG , "+CRLF

cQuery += " SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, SE1.E1_NATUREZ, SE1.E1_EMIS1, "+CRLF 
cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR, SE1.E1_EMIS1, SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_NREDUZ, SE1.E1_HIST, SE1.E1_CODEMP CODEMP, SE1.R_E_C_N_O_ "+CRLF
cQuery += " FROM "+RetSqlname("SE1")+" SE1, "+RetSqlname("SA1")+" SA1 "+CRLF
cQuery += " WHERE SE1.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SA1.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF
cQuery += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
cQuery += " AND SE1.E1_FILIAL BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery += " AND SE1.E1_EMIS1 BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF   
cQuery += " AND SE1.E1_PREFIXO BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF     
//filtro por empresa 
cQuery += " AND SE1.E1_CODEMP BETWEEN '"+MV_PAR10+"' AND '"+MV_PAR11+"' "+CRLF  
cQuery += " AND SE1.E1_CODEMP not in "+FormatIn(MV_PAR12, ",") + " "+CRLF 
//   altamiro 13/12/2017
cQuery += " AND SE1.E1_ORIGEM = 'PLSA510' "+CRLF

cQuery += " AND SE1.E1_PREFIXO <>'FAT'" +CRLF    
// ativar quando na produÁ„o 
//cQuery += " AND SE1.E1_LAPRO <> 'T' "+CRLF 				&& Campo Identifica Contabilizacao Provisao Realizada = T = True (sim)  / F = Falso (Nao) desefazer altamiro 30/04/19
//
cQuery += "  AND NOT EXISTS ( SELECT SE5.E5_FILIAL||SE5.E5_PREFIXO||SE5.E5_NUMERO||SE5.E5_PARCELA||SE5.E5_TIPO||SE5.E5_CLIFOR||SE5.E5_LOJA  "+CRLF
cQuery += "  FROM "+RetSqlname("SE5")+ " SE5  "+CRLF
cQuery += "  WHERE SE5.D_E_L_E_T_=' '  "+CRLF
cQuery += "  AND SE5.D_E_L_E_T_=' '  "+CRLF
//cQuery += "  AND SA1.A1_COD = SE1.E1_CLIENTE  "+CRLF 
//cQuery += "  AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
cQuery += "  AND SE5.E5_FILORIG = SE1.E1_FILIAL  "+CRLF 
cQuery += "  AND SE5.E5_PREFIXO = SE1.E1_PREFIXO "+CRLF
cQuery += "  AND SE5.E5_NUMERO = SE1.E1_NUM "+CRLF
cQuery += "  AND SE5.E5_PARCELA = SE1.E1_PARCELA  "+CRLF
cQuery += "  AND SE5.E5_TIPO = SE1.E1_TIPO  "+CRLF
cQuery += "  AND SE5.E5_CLIFOR = SE1.E1_CLIENTE "+CRLF
cQuery += "  AND SE5.E5_LOJA = SE1.E1_LOJA "+CRLF
cQuery += "  AND SE5.E5_FILORIG BETWEEN  '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF 
cQuery += "  AND SE5.E5_DATA BETWEEN  '"+dtos(MV_PAR03-90)+"' AND '"+dtos(MV_PAR04+90)+"' "+CRLF
cQuery += "  AND SE5.E5_FILIAL BETWEEN  '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF 
cQuery += "  AND SE5.E5_TIPODOC = 'BA' "+CRLF
cQuery += "  AND SE5.E5_MOTBX = 'CAN' "+CRLF
cQuery += "  AND SE5.E5_HISTOR  LIKE '%Titulo cancelado pelo Plano de Saude%' )"+CRLF
//
cQuery += " ORDER BY SE1.E1_FILIAL, SE1.E1_EMIS1,(e1_anobase || e1_mesbase ||'01') , SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA"+CRLF
//
MemoWrite("C:\Temp1\CABA323_SE1.txt",cQuery)
//
If Select(cAliasQry) > 0
	dbSelectArea(cAliasQry)
	dbCloseArea()
EndIf
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.) 

/////////////////////////////PPCNG///////////////////////////////////////
cQuery := " "

cQuery += "SELECT CASE  WHEN substr(e1_emissao, 1,6) >= e1_anobase || e1_mesbase  THEN '1' ELSE '2'END  PPCNG , (e1_anobase || e1_mesbase ||'01') DtPPCNG , "+CRLF

cQuery += " SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, SE1.E1_NATUREZ, SE1.E1_EMIS1, "+CRLF 
cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR, SE1.E1_EMIS1, SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_NREDUZ, SE1.E1_HIST, SE1.E1_CODEMP CODEMP,  SE1.R_E_C_N_O_ "+CRLF
cQuery += " FROM "+RetSqlname("SE1")+" SE1, "+RetSqlname("SA1")+" SA1 "+CRLF
cQuery += " WHERE SE1.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SA1.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF
cQuery += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
cQuery += " AND SE1.E1_FILIAL BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery += " AND SE1.E1_EMIS1 BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF   
cQuery += " AND SE1.E1_PREFIXO BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF     
//filtro por empresa 
cQuery += " AND SE1.E1_CODEMP BETWEEN '"+MV_PAR10+"' AND '"+MV_PAR11+"' "+CRLF  
cQuery += " AND SE1.E1_CODEMP not in "+FormatIn(MV_PAR12, ",") + " "+CRLF 
// altamiro	05/01/22 volta ao padrao
cQuery += " AND substr(e1_emissao, 1,6) < e1_anobase || e1_mesbase "
//   altamiro 13/12/2017                                                        

cQuery += " AND SE1.E1_ORIGEM = 'PLSA510' "+CRLF 

cQuery += " AND SE1.E1_PREFIXO <>'FAT'" +CRLF       
// ativar quando na produÁ„o 
//cQuery += " AND SE1.E1_LAPRO <> 'T' "+CRLF 				&& Campo Identifica Contabilizacao Provisao Realizada = T = True (sim)  / F = Falso (Nao) desefazer altamiro 30/04/19
//
cQuery += "  AND NOT EXISTS ( SELECT SE5.E5_FILIAL||SE5.E5_PREFIXO||SE5.E5_NUMERO||SE5.E5_PARCELA||SE5.E5_TIPO||SE5.E5_CLIFOR||SE5.E5_LOJA  "+CRLF
cQuery += "  FROM "+RetSqlname("SE5")+ " SE5  "+CRLF
cQuery += "  WHERE SE5.D_E_L_E_T_=' '  "+CRLF
cQuery += "  AND SE5.D_E_L_E_T_=' '  "+CRLF
//cQuery += "  AND SA1.A1_COD = SE1.E1_CLIENTE  "+CRLF 
//cQuery += "  AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
cQuery += "  AND SE5.E5_FILORIG = SE1.E1_FILIAL  "+CRLF 
cQuery += "  AND SE5.E5_PREFIXO = SE1.E1_PREFIXO "+CRLF
cQuery += "  AND SE5.E5_NUMERO = SE1.E1_NUM "+CRLF
cQuery += "  AND SE5.E5_PARCELA = SE1.E1_PARCELA  "+CRLF
cQuery += "  AND SE5.E5_TIPO = SE1.E1_TIPO  "+CRLF
cQuery += "  AND SE5.E5_CLIFOR = SE1.E1_CLIENTE "+CRLF
cQuery += "  AND SE5.E5_LOJA = SE1.E1_LOJA "+CRLF
cQuery += "  AND SE5.E5_FILORIG BETWEEN  '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF 
cQuery += "  AND SE5.E5_DATA BETWEEN  '"+dtos(MV_PAR03-90)+"' AND '"+dtos(MV_PAR04+90)+"' "+CRLF
cQuery += "  AND SE5.E5_FILIAL BETWEEN  '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF 
cQuery += "  AND SE5.E5_TIPODOC = 'BA' "+CRLF
cQuery += "  AND SE5.E5_MOTBX = 'CAN' "+CRLF
cQuery += "  AND SE5.E5_HISTOR  LIKE '%Titulo cancelado pelo Plano de Saude%' )"+CRLF
//
cQuery += " ORDER BY SE1.E1_FILIAL, (e1_anobase || e1_mesbase ||'01'), SE1.E1_EMIS1 , SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA"+CRLF
//
MemoWrite("C:\Temp1\CABA323_SE1_PPCNG.txt",cQuery)
//
If Select(cAliasQry1) > 0
	dbSelectArea(cAliasQry1)
	dbCloseArea()
EndIf
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry1,.T.,.T.)
/////////////////////////////////////////////////////////////////////////
//
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Contagem dos arquivos para o "Processa"≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
While (cAliasQry)->(!Eof())
	nCountnx ++
	(cAliasQry)->(DbSkip())
EndDo
(cAliasQry)->(DbGoTop())
// LAN«A NORMAL 

Do While (cAliasQry)->(!Eof()) 
   //
   // identifica tp de adm - incluido empresa 0352 - chamado 67645
   
    If cEmpAnt == '02' .and. (cAliasQry)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282|0352'
       __T_POPERA := 'S'
    Else                
       __T_POPERA := 'N'
    EndIf   

 	//    
 	//DataValida
 	
	_cFILIAL	:=	(cAliasQry)->E1_FILIAL	
	_cEMIS1		:=	(cAliasQry)->E1_EMIS1    

  	dDatabase	:=	stod((cAliasQry)->E1_EMIS1)
      
	Do While (cAliasQry)->(!Eof()) .and. (cAliasQry)->E1_FILIAL == _cFILIAL .and. (cAliasQry)->E1_EMIS1 == _cEMIS1
	 	//
	 	cPadrao  := "990"
	 	//
		dbSelectArea(cAliasQry)   
		_cProcDoc	:= 	(cAliasQry)->E1_PREFIXO+" "+(cAliasQry)->E1_NUM+" "+(cAliasQry)->E1_PARCELA+" "+(cAliasQry)->E1_TIPO+" "+(cAliasQry)->E1_CLIENTE
		_nRECNO		:=	(cAliasQry)->R_E_C_N_O_
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
		_cNATUREZ	:=	(cAliasQry)->E1_NATUREZ
		
		__C_CODEMP  :=	(cAliasQry)->CODEMP
           
        __P_PCNG    := (cAliasQry)->PPCNG
        
        //
        // identifica tp de adm - incluido empresa 0352 - chamado 67645
   
        If cEmpAnt == '02' .and. (cAliasQry)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282|0352'
           __T_POPERA := 'S'
        Else                
           __T_POPERA := 'N'
        EndIf   
        
		_nTotVlr	+= 	_nVALOR
	
	 	nTotReg	++
		//
	 	IncProc(" Processando ..." + _cProcDoc )
	 	//
	 	DbSelectArea("SE1")    
	 	DbGoto(_nRECNO)
	 	//
	 	DbSelectArea("SA1")
	 	DbSetOrder(1)
			DbSeek(xFilial("SA1")+_cCLIENTE+_cLOJA)
	 	//
	 	DbSelectArea("SED")
	 	DbSetOrder(1)
	 	DbSeek(xFilial("SED")+_cNATUREZ) 
	 	//	
	 	_nTotal    += DetProva(nHdlPrv,cPadrao,"PLS",cLote)
		//

// CASE  WHEN substr(e1_emissao, 1,6) >= e1_anobase || e1_mesbase  THEN '1' ELSE '2'END  PPCNG , 

		cQuery2	:= ""	
	
		cQuery2 += "SELECT CASE  WHEN substr(e1_emissao, 1,6) >= e1_anobase || e1_mesbase  THEN '1' ELSE '2'END  PPCNG , (e1_anobase || e1_mesbase ||'01') DtPPCNG ,  "+CRLF
		cQuery2 += "       BM1.BM1_CODINT, BM1.BM1_CODTIP , BM1.BM1_DESTIP, BM1.BM1_CODPLA , BM1.BM1_DESPLA , BM1.BM1_TIPO, BI3.BI3_TIPCON, "+CRLF
		cQuery2 += " BM1.BM1_VALOR,BM1.BM1_VERPLA, BM1.BM1_CODEMP CODEMP, BM1.R_E_C_N_O_ "+CRLF
		cQuery2 += " FROM "+RetSqlName("BM1")+" BM1, "+RetSqlname("SE1")+" SE1 ,"+RetSqlName("BI3")+" BI3 "+CRLF
		cQuery2 += " where BM1.D_E_L_E_T_= ' ' "+CRLF 
		cQuery2 += " and SE1.D_E_L_E_T_=' ' "+CRLF
		cQuery2 += " and BI3.D_E_L_E_T_=' ' "+CRLF
		cQuery2 += " and BM1.BM1_PREFIX = SE1.E1_PREFIXO "+CRLF
		cQuery2 += " and BM1.BM1_NUMTIT = SE1.E1_NUM "+CRLF
		cQuery2 += " and BM1.BM1_PARCEL = SE1.E1_PARCELA "+CRLF
		cQuery2 += " and BM1.BM1_TIPTIT = SE1.E1_TIPO  "+CRLF			
		cQuery2 += " and BI3.BI3_CODINT = BM1.BM1_CODINT "+CRLF       
		
		cQuery2 += " and BI3.BI3_CODIGO = BM1.BM1_CODPLA "+CRLF
		
		cQuery2 += " AND SE1.E1_PREFIXO = '"+_cPREFIXO+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_NUM = '"+_cNUM+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_PARCELA = '"+_cPARCELA+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_TIPO = '"+_cTIPO+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_CLIENTE = '"+_cCLIENTE+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_LOJA = '"+_cLOJA+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_FILIAL = '"+_cFILIAL+"' "+CRLF
		cQuery2 += "ORDER BY  BI3.BI3_TIPCON, BM1.BM1_CODPLA, BM1.BM1_DESPLA,BM1.BM1_CODTIP , BM1.BM1_DESTIP "+CRLF		
		MemoWrite("C:\Temp1\CABA323_BM1.txt",cQuery2)
		//
		If Select(cAliasQ2) > 0	
			dbSelectArea(cAliasQ2)
			dbCloseArea()
		EndIf
		cQuery := ChangeQuery(cQuery2)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),cAliasQ2,.T.,.T.)
		//
		Do while !(cAliasQ2)->(eof()) 
			//
			_nBM1REC	:= (cAliasQ2)->R_E_C_N_O_
		 	cPadrao  := "992"                 
		 			 	
			//       
		 	DbSelectArea("BM1")    
	 		DbGoto(_nBM1REC) 
	 		//
	 		DbSelectArea("BFQ") 		&& Tabela de Itens de Faturamento 
	 		DbSetOrder(1)
	 		DbSeek(xFilial("BFQ")+(cAliasQ2)->BM1_CODINT+(cAliasQ2)->BM1_CODTIP)
	 		//
	 		DbSelectArea("BI3")  		&& Tabela de Planos
	 		DbSetOrder(1)
	 		DbSeek(xFilial("BI3")+(cAliasQ2)->BM1_CODINT+(cAliasQ2)->BM1_CODPLA+(cAliasQ2)->BM1_VERPLA)             
	 		
	 		If cEmpresa == 'C' 
	 		   
	 		   If TRIM((cAliasQ2)->BM1_CODPLA) $"0098|0099|0131|0133|0134|0136"
                  __O_DONT := '1'	
               Else     		    
                  __O_DONT := '2'
               EndIf    	  
            
            Else 
            
            If TRIM((cAliasQ2)->BM1_CODPLA) $"0088|0090|0091|0092"
                  __O_DONT := '1'	
               Else     		    
                  __O_DONT := '2'
               EndIf    	                        
            
            EndIf    
            //
            // identifica tp de adm - incluido empresa 0352 - chamado 67645
   
            If cEmpAnt == '02' .and. (cAliasQ2)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282|0352'
               __T_POPERA := 'S'
            Else                
               __T_POPERA := 'N'
            EndIf   
            
	 		//
		 	_nTotal    += DetProva(nHdlPrv,cPadrao,"PLS",cLote)
			//
		 	(cAliasQ2)->(DbSkip())
	        //    
	    Enddo
	 	//
	 	nSeq ++
	 	//
	 	If MV_PAR09 == 1  && 1 Sim 		2 Nao
	 		//
		 	DbSelectArea("SE1")    
		 	DbGoto(_nRECNO)
		 	RecLock("SE1",.F.)
		 	SE1->E1_LAPRO := .T.
		 	MsUnlock()
		 	//
		Endif
		//	
	 	DbSelectArea(cAliasQry)
	 	(cAliasQry)->(DbSkip())
	 	//
	 Enddo
	//
	RodaProva(nHdlPrv,_nTotal)
	cA100Incl(cArquivo,nHdlPrv,3,cLote,l_Mostra,lAglutina)
	nSeq := 0
	//
Enddo    

// FIM LAN«A NORMAL                

// LAN«A PPCNG MES/ANO COMPETENCIA 
///////////////////////////////////////////////////////////////////////

(cAliasQry1)->(DbGoTop())                      

cLote    := "009940"
_nTotal  := 0
_nTotVlr := 0 

Do While (cAliasQry1)->(!Eof())
   
   If 	dDatabase	!=	stod((cAliasQry1)->DtPPCNG )
     	dDatabase	:=	stod((cAliasQry1)->DtPPCNG )
   EndIf 

//   Do While (cAliasQry)->(!Eof()) .and. dDatabase	==	stod((cAliasQry)->DtPPCNG )  
  
   If  (cAliasQry1)->PPCNG == '2' //.or. (cAliasQry1)->PPCNG == '1'
 	//    
 	//DataValida
	_cFILIAL	:=	(cAliasQry1)->E1_FILIAL	
	_cEMIS1		:=	(cAliasQry1)->E1_EMIS1    
	/*
	If 	Substr((cAliasQry1)->E1_EMIS1,1,6)  > substr((cAliasQry1)->DtPPCNG,1,6)
     	dDatabase	:=	stod((cAliasQry1)->E1_EMIS1 )
	Else
    	dDatabase	:=	stod((cAliasQry1)->DtPPCNG )	 
    EndIf  
*/

//	Do While (cAliasQry1)->(!Eof()) .and. (cAliasQry1)->E1_FILIAL == _cFILIAL .and.(Substr((cAliasQry1)->E1_EMIS1,1,6)  > substr((cAliasQry1)->DtPPCNG,1,6) .and. dDatabase == stod((cAliasQry1)->E1_EMIS1 ) .or.  Substr((cAliasQry1)->E1_EMIS1,1,6)  <=  substr((cAliasQry1)->DtPPCNG,1,6) .and. dDatabase == stod((cAliasQry1)->DtPPCNG ) )
    Do While (cAliasQry1)->(!Eof()) .and. (cAliasQry1)->E1_FILIAL == _cFILIAL .and. dDatabase	==	stod((cAliasQry1)->DtPPCNG )

	 	//
	 	cPadrao  := "990"
	 	//
		dbSelectArea(cAliasQry1)   
		_cProcDoc	:= 	(cAliasQry1)->E1_PREFIXO+" "+(cAliasQry1)->E1_NUM+" "+(cAliasQry1)->E1_PARCELA+" "+(cAliasQry1)->E1_TIPO+" "+(cAliasQry1)->E1_CLIENTE
		_nRECNO		:=	(cAliasQry1)->R_E_C_N_O_
		_cPREFIXO	:=	(cAliasQry1)->E1_PREFIXO
		_cNUM		:=	(cAliasQry1)->E1_NUM
		_cPARCELA	:=	(cAliasQry1)->E1_PARCELA
		_cTIPO		:=	(cAliasQry1)->E1_TIPO
		_cCLIENTE	:=	(cAliasQry1)->E1_CLIENTE
		_cLOJA		:=	(cAliasQry1)->E1_LOJA
		_cNOMCLI	:=	(cAliasQry1)->E1_NOMCLI
		_cEMISSAO	:=	(cAliasQry1)->E1_EMISSAO
		_cVENCREA	:=	(cAliasQry1)->E1_VENCREA
		_cORIGEM	:=	(cAliasQry1)->E1_ORIGEM
		_nVALOR		:=	(cAliasQry1)->E1_VALOR
		_cNATUREZ	:=	(cAliasQry1)->E1_NATUREZ
		
		__C_CODEMP  :=	(cAliasQry1)->CODEMP
           
        __P_PCNG    := (cAliasQry1)->PPCNG
        
        //
        // identifica tp de adm - incluido empresa 0352 - chamado 67645
           
        If cEmpAnt == '02' .and. (cAliasQry1)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282|0352'
           __T_POPERA := 'S'
        Else                
           __T_POPERA := 'N'
        EndIf   
        
		_nTotVlr	+= 	_nVALOR
	
	 	nTotReg	++
		//
	 	IncProc(" Processando PPCNG ..." + _cProcDoc )
	 	//
	 	DbSelectArea("SE1")    
	 	DbGoto(_nRECNO)
	 	//
	 	DbSelectArea("SA1")
	 	DbSetOrder(1)
	 	DbSeek(xFilial("SA1")+_cCLIENTE+_cLOJA)
	 	//
	 	DbSelectArea("SED")
	 	DbSetOrder(1)
	 	DbSeek(xFilial("SED")+_cNATUREZ) 
	 	//	
	 	_nTotal    += DetProva(nHdlPrv,cPadrao,"PLS",cLote)
		//

// CASE  WHEN substr(e1_emissao, 1,6) >= e1_anobase || e1_mesbase  THEN '1' ELSE '2'END  PPCNG , 

		cQuery2	:= ""	
		cQuery2 += "SELECT CASE  WHEN substr(e1_emissao, 1,6) >= e1_anobase || e1_mesbase  THEN '1' ELSE '2'END  PPCNG , (e1_anobase || e1_mesbase ||'01') DtPPCNG ,  "+CRLF
		cQuery2 += "       BM1.BM1_CODINT, BM1.BM1_CODTIP , BM1.BM1_DESTIP, BM1.BM1_CODPLA, BM1.BM1_DESPLA, BM1.BM1_TIPO, BI3.BI3_TIPCON, "+CRLF
		cQuery2 += " BM1.BM1_VALOR,BM1.BM1_VERPLA, BM1.BM1_CODEMP CODEMP, BM1.R_E_C_N_O_ "+CRLF
		cQuery2 += " FROM "+RetSqlName("BM1")+" BM1, "+RetSqlname("SE1")+" SE1 ,"+RetSqlName("BI3")+" BI3 "+CRLF
		cQuery2 += " where BM1.D_E_L_E_T_= ' ' "+CRLF 
		cQuery2 += " and SE1.D_E_L_E_T_=' ' "+CRLF
		cQuery2 += " and BI3.D_E_L_E_T_=' ' "+CRLF
		cQuery2 += " and BM1.BM1_PREFIX = SE1.E1_PREFIXO "+CRLF
		cQuery2 += " and BM1.BM1_NUMTIT = SE1.E1_NUM "+CRLF
		cQuery2 += " and BM1.BM1_PARCEL = SE1.E1_PARCELA "+CRLF
		cQuery2 += " and BM1.BM1_TIPTIT = SE1.E1_TIPO  "+CRLF			
		cQuery2 += " and BI3.BI3_CODINT = BM1.BM1_CODINT "+CRLF       
		
		cQuery2 += " and BI3.BI3_CODIGO = BM1.BM1_CODPLA "+CRLF
		
		cQuery2 += " AND SE1.E1_PREFIXO = '"+_cPREFIXO+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_NUM = '"+_cNUM+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_PARCELA = '"+_cPARCELA+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_TIPO = '"+_cTIPO+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_CLIENTE = '"+_cCLIENTE+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_LOJA = '"+_cLOJA+" ' "+CRLF 
		cQuery2 += " AND SE1.E1_FILIAL = '"+_cFILIAL+"' "+CRLF
		cQuery2 += "ORDER BY  (e1_anobase || e1_mesbase ||'01') , BI3.BI3_TIPCON, BM1.BM1_CODPLA, BM1.BM1_DESPLA,BM1.BM1_CODTIP , BM1.BM1_DESTIP "+CRLF		
		MemoWrite("C:\Temp1\CABA323_BM1.txt",cQuery2)
		//
		If Select(cAliasQ2) > 0	
			dbSelectArea(cAliasQ2)
			dbCloseArea()
		EndIf
		cQuery := ChangeQuery(cQuery2)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),cAliasQ2,.T.,.T.)
		//
		Do while !(cAliasQ2)->(eof()) 
			//
			_nBM1REC	:= (cAliasQ2)->R_E_C_N_O_
		 	cPadrao  := "994"                 
		 			 	
			//       
		 	DbSelectArea("BM1")    
	 		DbGoto(_nBM1REC) 
	 		//
	 		DbSelectArea("BFQ") 		&& Tabela de Itens de Faturamento (
	 		DbSetOrder(1)
	 		DbSeek(xFilial("BFQ")+(cAliasQ2)->BM1_CODINT+(cAliasQ2)->BM1_CODTIP)
	 		//
	 		DbSelectArea("BI3")  		&& Tabela de Planos
	 		DbSetOrder(1)
	 		DbSeek(xFilial("BI3")+(cAliasQ2)->BM1_CODINT+(cAliasQ2)->BM1_CODPLA+(cAliasQ2)->BM1_VERPLA)
	 		//                           
	 		If cEmpresa == 'C' 
	 		   
	 		   If TRIM((cAliasQ2)->BM1_CODPLA) $"0098|0099|0131|0133|0134"
               
                  __O_DONT := '1'	
               
               Else     		    
               
                  __O_DONT := '2'
               
               EndIf    	  
            
            Else 
            
               If TRIM((cAliasQ2)->BM1_CODPLA) $"0088|0090|0091|0092"
                  
                  __O_DONT := '1'	
               
               Else     		    
                  
                  __O_DONT := '2'   
                  
               EndIf    	                        
            
            EndIf    
            //
            // identifica tp de adm - incluido empresa 0352 - chamado 67645
            If cEmpAnt == '02' .and. (cAliasQ2)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282|0352'
               __T_POPERA := 'S'
            Else                
               __T_POPERA := 'N'
            EndIf   
            
	 		//
		 	_nTotal    += DetProva(nHdlPrv,cPadrao,"PLS",cLote)
			//
		 	(cAliasQ2)->(DbSkip())
	        //    
	    Enddo
	 	//
	 	nSeq ++
	 	//
	 	If MV_PAR09 == 1  && 1 Sim 		2 Nao
	 		//
		 	DbSelectArea("SE1")    
		 	DbGoto(_nRECNO)
		 	RecLock("SE1",.F.)
		 	SE1->E1_LAPRO := .T.
		 	MsUnlock()
		 	//
		Endif
		//	
	 	DbSelectArea(cAliasQry1)
	 	(cAliasQry1)->(DbSkip())
	 	//
	 Enddo
	//
	RodaProva(nHdlPrv,_nTotal)
	cA100Incl(cArquivo,nHdlPrv,3,cLote,l_Mostra,lAglutina)
	nSeq := 0
	//
  EndIf
  If  (cAliasQry1)->PPCNG != '2'
   	
      (cAliasQry1)->(DbSkip())

  EndIf 
   
Enddo
///////////////////////////////////////////////////////////////////////
///   FIM LAN«AMENTO PPCNG

///////////////////////////////////////////////////////////////////////
//	
If nCountnx  > 0
	If Select(cAliasQry) > 0
		dbSelectArea(cAliasQry)
		dbCloseArea()
	EndIf
Endif
//
return 
//
//
// ******************************************************************************************************************
// ******************************************************************************************************************
// ******************************************************************************************************************
// ******************************************************************************************************************
//
//   ********************            FIM PROCESSAMENTO - CONTABILIZACAO RECEITA         *************************
//
// ******************************************************************************************************************
// ******************************************************************************************************************
// ******************************************************************************************************************
// ******************************************************************************************************************
//
/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ CTBCAB3  ∫ Autor ≥ Vitor Sbano        ∫ Data ≥  03/09/13   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Contablizacao da Receita - Cancelamento Lote Pagamento     ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ SIGACTB -                                                  ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
static Function CTBCAB3
//                    
Local 	cQuery
Local 	cAliasQry	:= GetNextAlias()
Local 	cAliasQ2	:= GetNextAlias()
Private cPerg2		:= "CABA323G"
//
PutSx1( cPerg2,"01","Mostra LanÁamentos?"      ,"","","mv_ch1","N", 1   ,0,0,"C","",""      ,"","","MV_PAR01","Sim",,,,"Nao")
PutSx1( cPerg2,"02","Aglutina LanÁamentos?"    ,"","","mv_ch2","N", 1   ,0,0,"C","",""      ,"","","MV_PAR02","Sim",,,,"Nao")
PutSx1( cPerg2,"03","Da Data Cancelamento ?"   ,"","","mv_ch3","D",08   ,0,0,"G","",""	 	,"","","MV_PAR03")
PutSx1( cPerg2,"04","Ate Data Cancelamento?"   ,"","","mv_ch4","D",08   ,0,0,"G","",""		,"","","MV_PAR04")
PutSx1( cPerg2,"05","Da Filial ?"    		   ,"","","mv_ch5","C",02   ,0,0,"G","","XM0"   ,"","","MV_PAR05")
PutSx1( cPerg2,"06","Ate a Filial?"			   ,"","","mv_ch6","C",02   ,0,0,"G","","XM0"   ,"","","MV_PAR06")
//PutSx1( cPerg2,"07","Do Prefixo ?"    	   ,"","","mv_ch7","C",03   ,0,0,"G","",""      ,"","","MV_PAR07")
//PutSx1( cPerg2,"08","Ate o Prefixo?"		   ,"","","mv_ch8","C",03   ,0,0,"G","",""      ,"","","MV_PAR08")
//
//CHAMA OS PARAMETROS
If !Pergunte( cPerg2 , .T. )
	Return
Endif
//
MsgInfo("Atencao - Somente ser„o Contabilizados os Cancelamento de Titulos Provisionados (E1_LAPRO)","CABERJ - Contabilizacao Cancel. Receita")
//
//dDatabase	:=	(lastday(mv_par03))+1			&&   29/11/13 - Vitor Sbano
dDatabase	:=	mv_par04
//
cPadrao  := "991"
lPadrao  := VerPadrao(cPadrao)
cLote    := "009930"
cArquivo := ""
nHdlPrv  := HeadProva(cLote,"PLS",Substr(cUsuario,7,6),@cArquivo)
_aArea	:=	GetArea()
//
nTotReg		:=	0
nCountnx	:= 0
nValLan		:= 0
nSeq		:= 0
_nTotVlr	:= 0
//
//MOSTRA LAN«AMENTO
IIF(MV_PAR01=1,l_Mostra := .T.,l_Mostra := .F.)

//AGLUTINA LAN«AMENTO
IIF(MV_PAR02=1,lAglutina := .T.,lAglutina := .F.)
//
//
/*
cQuery := " "
cQuery += "SELECT CASE  WHEN substr(SE5.E5_DATA, 1,6) >= e1_anobase || e1_mesbase  THEN '1' ELSE '2'END  PPCNG , (e1_anobase || e1_mesbase ||'01') DtPPCNG ,  "+CRLF
cQuery += " SE5.E5_FILIAL, SE5.E5_DATA, SE5.E5_VALOR, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA, SE5.E5_TIPO, SE5.E5_CLIFOR, SE5.E5_LOJA,"+CRLF
cQuery += " SE5.E5_HISTOR,SE5.E5_TIPODOC, SE5.E5_MOTBX, SE5.R_E_C_N_O_ SE5RECN,"+CRLF
cQuery += " SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, SE1.E1_NATUREZ,"+CRLF 
cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR, SE1.E1_EMIS1, SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SE1.E1_CODEMP CODEMP, "+CRLF 
cQuery += " SA1.A1_NREDUZ, SE1.E1_HIST, SE1.R_E_C_N_O_ SE1RECN "+CRLF
cQuery += " FROM "+RetSqlname("SE5")+" SE5, "+RetSqlname("SE1")+" SE1, "+RetSqlname("SA1")+" SA1 "+CRLF
cQuery += " WHERE SE5.D_E_L_E_T_=' '"+CRLF 
cQuery += " AND SE1.D_E_L_E_T_=' '"+CRLF 
cQuery += " AND SA1.D_E_L_E_T_=' ' "+CRLF
cQuery += " AND SE5.E5_FILORIG BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery += " AND SE5.E5_DATA BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF   
cQuery += " AND SE1.E1_FILIAL = SE5.E5_FILORIG"+CRLF
cQuery += " AND SE1.E1_PREFIXO = SE5.E5_PREFIXO "+CRLF
cQuery += " AND SE1.E1_NUM = SE5.E5_NUMERO "+CRLF
cQuery += " AND SE1.E1_PARCELA = SE5.E5_PARCELA "+CRLF
cQuery += " AND SE1.E1_TIPO = SE5.E5_TIPO "+CRLF
cQuery += " AND SE1.E1_CLIENTE = SE5.E5_CLIFOR "+CRLF
cQuery += " AND SE1.E1_LOJA = SE5.E5_LOJA "+CRLF
cQuery += " AND SE1.E1_LAPRO = 'T' "+CRLF 				&& Campo Identifica Contabilizacao Provisao Realizada = T = True (sim)  / F = Falso (Nao) desmarcar altamiro 30/04/19
cQuery += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF 
cQuery += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
cQuery += " AND SE1.E1_FILIAL BETWEEN '  ' AND 'zz' "+CRLF 
cQuery += " AND SE5.E5_TIPODOC = 'BA' "+CRLF
cQuery += " AND SE5.E5_MOTBX = 'CAN' "+CRLF
cQuery += " AND SE5.E5_HISTOR  LIKE '%Titulo cancelado pelo Plano de Saude%' "+CRLF
cQuery += " ORDER BY SE5.E5_FILIAL, SE5.E5_VALOR, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA, SE5.E5_TIPO, SE5.E5_CLIFOR, SE5.E5_LOJA "+CRLF
 */
 
cQuery := " "
/*
cQuery += "SELECT CASE  WHEN substr(SE5.E5_DATA, 1,6) >= e1_anobase || e1_mesbase  THEN '1' ELSE '2'END  PPCNG , (e1_anobase || e1_mesbase ||'01') DtPPCNG ,  "+CRLF
cQuery += " nvl(SE5.E5_FILIAL, SE5.E5_DATA, SE5.E5_VALOR, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA, SE5.E5_TIPO, SE5.E5_CLIFOR, SE5.E5_LOJA,"+CRLF
cQuery += " SE5.E5_HISTOR,SE5.E5_TIPODOC, SE5.E5_MOTBX, SE5.R_E_C_N_O_ SE5RECN,"+CRLF
cQuery += " SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, SE1.E1_NATUREZ,"+CRLF 
cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR, SE1.E1_EMIS1, SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SE1.E1_CODEMP CODEMP, "+CRLF 
cQuery += " SA1.A1_NREDUZ, SE1.E1_HIST, SE1.R_E_C_N_O_ SE1RECN "+CRLF
*/
cQuery += " SELECT CASE  WHEN substr(SE5.E5_DATA, 1,6) >= e1_anobase || e1_mesbase  THEN '1' ELSE '2'END  PPCNG , (e1_anobase || e1_mesbase ||'01') DtPPCNG ,  
cQuery += "        nvl(SE5.E5_FILIAL,SE1.E1_FILIAL) E5_FILIAL, "+CRLF
cQuery += "        nvl(SE5.E5_DATA, SE1.E1_emissao) E5_DATA , "+CRLF
cQuery += "        nvl(SE5.E5_VALOR ,SE1.E1_VALOR) E5_VALOR , "+CRLF
cQuery += "         nvl(SE5.E5_PREFIXO,SE1.E1_PREFIXO) E5_PREFIXO , "+CRLF
cQuery += "         nvl(SE5.E5_NUMERO, SE1.E1_NUM) E5_NUMERO ,  "+CRLF
cQuery += "         nvl(SE5.E5_PARCELA,SE1.E1_PARCELA) E5_PARCELA , "+CRLF
cQuery += "         nvl(SE5.E5_TIPO,SE1.E1_TIPO) E5_TIPO , "+CRLF
cQuery += "         nvl(SE5.E5_CLIFOR,SE1.E1_CLIente) E5_CLIFOR , "+CRLF 
cQuery += "         nvl(SE5.E5_LOJA,SE1.E1_LOJA) E5_LOJA , "+CRLF
cQuery += "         nvl(SE5.E5_HISTOR,'Titulo cancelado pelo Plano de Saude') E5_HISTOR , "+CRLF
cQuery += "         nvl(SE5.E5_TIPODOC,'BA')E5_TIPODOC ,  "+CRLF
cQuery += "         nvl(SE5.E5_MOTBX,'CAN')E5_MOTBX ,  "+CRLF
cQuery += "         nvl(SE5.R_E_C_N_O_,0) SE5RECN ,"+CRLF
cQuery += " SE1.E1_FILIAL, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO, SE1.E1_CLIENTE, SE1.E1_LOJA, SE1.E1_EMISSAO, SE1.E1_NATUREZ,"+CRLF 
cQuery += " SE1.E1_VENCREA, SE1.E1_VALOR, SE1.E1_EMIS1, SE1.E1_ORIGEM, SE1.E1_NOMCLI, SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SE1.E1_CODEMP CODEMP, "+CRLF 
cQuery += " SA1.A1_NREDUZ, SE1.E1_HIST, SE1.R_E_C_N_O_ SE1RECN "+CRLF


cQuery += " FROM "+RetSqlname("SE5")+" SE5, "+RetSqlname("SE1")+" SE1, "+RetSqlname("SA1")+" SA1 "+CRLF
cQuery += " WHERE SE5.D_E_L_E_T_(+)=' '"+CRLF 
cQuery += " AND SE1.D_E_L_E_T_='*'"+CRLF 
cQuery += " AND SA1.D_E_L_E_T_=' ' "+CRLF
//cQuery += " AND SE5.E5_FILORIG(+) BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
//cQuery += " AND SE5.E5_DATA(+) BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF
cQuery += " AND SE1.E1_emissao BETWEEN '"+dtos(MV_PAR03)+"' AND '"+dtos(MV_PAR04)+"' "+CRLF   
cQuery += " AND SE1.E1_FILIAL BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery += " AND SE1.E1_PREFIXO = SE5.E5_PREFIXO(+) "+CRLF
cQuery += " AND SE1.E1_NUM = SE5.E5_NUMERO(+) "+CRLF
cQuery += " AND SE1.E1_PARCELA = SE5.E5_PARCELA(+) "+CRLF
cQuery += " AND SE1.E1_TIPO = SE5.E5_TIPO(+) "+CRLF
cQuery += " AND SE1.E1_CLIENTE = SE5.E5_CLIFOR(+) "+CRLF
cQuery += " AND SE1.E1_LOJA = SE5.E5_LOJA(+) "+CRLF
cQuery += " AND SE1.E1_LAPRO = 'T' "+CRLF 				&& Campo Identifica Contabilizacao Provisao Realizada = T = True (sim)  / F = Falso (Nao) desmarcar altamiro 30/04/19
cQuery += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF 
cQuery += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
cQuery += " AND SE1.E1_FILIAL BETWEEN '  ' AND 'zz' "+CRLF 
cQuery += " AND SE5.E5_TIPODOC(+) = 'BA' "+CRLF
cQuery += " AND SE5.E5_MOTBX(+) = 'CAN' "+CRLF
cQuery += " AND SE5.E5_HISTOR(+)  LIKE '%Titulo cancelado pelo Plano de Saude%' "+CRLF
cQuery += " ORDER BY SE5.E5_FILIAL, SE5.E5_VALOR, SE5.E5_PREFIXO, SE5.E5_NUMERO, SE5.E5_PARCELA, SE5.E5_TIPO, SE5.E5_CLIFOR, SE5.E5_LOJA "+CRLF
 
//
MemoWrite("C:\Temp1\CABA323_SE5.txt",cQuery)
//
If Select(cAliasQry) > 0
	dbSelectArea(cAliasQry)
	dbCloseArea()
EndIf
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
//
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Contagem dos arquivos para o "Processa"≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
While (cAliasQry)->(!Eof())
	nCountnx ++
	(cAliasQry)->(DbSkip())
EndDo
(cAliasQry)->(DbGoTop())
//
Do While (cAliasQry)->(!Eof())
 	//
 	cPadrao  := "991"
	dbSelectArea(cAliasQry)   
	_cProcDoc	:= 	(cAliasQry)->E5_PREFIXO+" "+(cAliasQry)->E5_NUMERO+" "+(cAliasQry)->E5_PARCELA+" "+(cAliasQry)->E5_TIPO+" "+(cAliasQry)->E5_CLIFOR
	_nSE5REC	:=	(cAliasQry)->SE5RECN
	_nSE1REC	:=	(cAliasQry)->SE1RECN
	_cFILIAL	:=	(cAliasQry)->E5_FILIAL
	_cPREFIXO	:=	(cAliasQry)->E5_PREFIXO
	_cNUM		:=	(cAliasQry)->E5_NUMERO
	_cPARCELA	:=	(cAliasQry)->E5_PARCELA
	_cTIPO		:=	(cAliasQry)->E5_TIPO
	_cCLIENTE	:=	(cAliasQry)->E5_CLIFOR 
	_dDATA		:=	(cAliasQry)->E5_DATA
	_cLOJA		:=	(cAliasQry)->E5_LOJA
	_nVALOR		:=	(cAliasQry)->E5_VALOR       
	
	__C_CODEMP  :=  (cAliasQry)->CODEMP 
	
    __P_PCNG    := (cAliasQry)->PPCNG
    
   //
   // identifica tp de adm - incluido empresa 0352 - chamado 67645
  
    If cEmpAnt == '02' .and. (cAliasQry)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282'
       __T_POPERA := 'S' 
    Else                
       __T_POPERA := 'N'
    EndIf   
	
	_nTotVlr	+= 	_nVALOR
    //
 	nTotReg	++
	//
 	IncProc(" Proc. Canc. Receita: " + _cProcDoc )
 	//
 	DbSelectArea("SE5")    
 	DbGoto(_nSE5REC)
 	//
 	DbSelectArea("SE1")    
 	DbGoto(_nSE1REC)
	_cNATUREZ	:=	SE1->E1_NATUREZ
	_cLAPRO		:=	SE1->E1_LAPRO
 	//
 	DbSelectArea("SA1")
 	DbSetOrder(1)
 	DbSeek(xFilial("SA1")+_cCLIENTE+_cLOJA)      
 	//
 	DbSelectArea("SED")
 	DbSetOrder(1)
 	DbSeek(xFilial("SED")+_cNATUREZ) 
 	//	
 	_nTotal    += DetProva(nHdlPrv,cPadrao,"PLS",cLote)  
	//
	cQuery2	:= ""	
/*/	
	cQuery2 += "SELECT BMN.BMN_CODINT, BMN.BMN_CODTIP , BMN.BMN_DESTIP, BMN.BMN_CODPLA, BMN.BMN_DESPLA, BMN.BMN_TIPO, BI3.BI3_TIPCON, "+CRLF
	cQuery2 += " BMN.BMN_VALOR,BMN.BMN_VERPLA, BMN.BMN_CODEMP CODEMP, BMN.R_E_C_N_O_ "+CRLF
	cQuery2 += "FROM "+RetSqlName("BMN")+" BMN, "+RetSqlname("SE5")+" SE5 ,"+RetSqlName("BI3")+" BI3 "+CRLF
	cQuery2 += "where BMN.D_E_L_E_T_= ' ' "+CRLF 
	cQuery2 += "and SE5.D_E_L_E_T_=' ' "+CRLF
	cQuery2 += "and BI3.D_E_L_E_T_=' ' "+CRLF
	cQuery2 += "and BMN.BMN_PREFIX = SE5.E5_PREFIXO "+CRLF
	cQuery2 += "and BMN.BMN_NUMTIT = SE5.E5_NUMERO "+CRLF
	cQuery2 += "and BMN.BMN_PARCEL = SE5.E5_PARCELA "+CRLF
	cQuery2 += "and BMN.BMN_TIPTIT = SE5.E5_TIPO  "+CRLF			
	cQuery2 += "and BI3.BI3_CODINT = BMN.BMN_CODINT "+CRLF
	cQuery2 += "and BI3.BI3_CODIGO = BMN.BMN_CODPLA "+CRLF
	cQuery2 += " AND SE5.E5_PREFIXO = '"+_cPREFIXO+" ' "+CRLF 
	cQuery2 += " AND SE5.E5_NUMERO = '"+_cNUM+" ' "+CRLF 
	cQuery2 += " AND SE5.E5_PARCELA = '"+_cPARCELA+" ' "+CRLF 
	cQuery2 += " AND SE5.E5_TIPO = '"+_cTIPO+" ' "+CRLF 
	cQuery2 += " AND SE5.E5_CLIFOR = '"+_cCLIENTE+" ' "+CRLF 
	cQuery2 += " AND SE5.E5_LOJA = '"+_cLOJA+" ' "+CRLF 
	cQuery2 += " AND SE5.E5_FILORIG = '"+_cFILIAL+"' "+CRLF
	cQuery2 += " AND SE5.E5_DATA = '"+_dDATA+"' "+CRLF	
	cQuery2 += "ORDER BY  BI3.BI3_TIPCON, BMN.BMN_CODPLA, BMN.BMN_DESPLA,BMN.BMN_CODTIP , BMN.BMN_DESTIP "+CRLF		
*/

    cQuery2 += "SELECT  BM1.BM1_CODINT BMN_CODINT , "+CRLF
 	cQuery2 += "        BM1.BM1_CODTIP BMN_CODTIP , "+CRLF
	cQuery2 += "        BM1.BM1_DESTIP BMN_DESTIP , "+CRLF
	cQuery2 += "        BM1.BM1_CODPLA BMN_CODPLA , "+CRLF
	cQuery2 += "        BM1.BM1_DESPLA BMN_DESPLA , "+CRLF
	cQuery2 += "        BM1.BM1_TIPO   BMN_TIPO   , "+CRLF
	cQuery2 += "    NVL(BI3.BI3_TIPCON,'0000') BI3_TIPCON  ,  "+CRLF
	cQuery2 += "        BM1.BM1_VALOR  BMN_VALOR , "+CRLF
	cQuery2 += "        BM1.BM1_VERPLA BMN_VERPLA , "+CRLF
	cQuery2 += "        BM1.BM1_CODEMP CODEMP , "+CRLF
	cQuery2 += "        BM1.R_E_C_N_O_  "+CRLF
	cQuery2 += " FROM "+RetSqlName("BM1")+" BM1, "+RetSqlName("BI3")+" BI3 "+CRLF
	cQuery2 += "where BM1.D_E_L_E_T_    = '*' "+CRLF 
	cQuery2 += "  and BM1_FILIAL        = '"+xFilial('BA1')+ "' "+CRLF
	cQuery2 += "  and BI3.D_E_L_E_T_  = ' ' "+CRLF
	cQuery2 += "  and BI3_FILIAL      = '"+xFilial('BA1')+ "' "+CRLF
	cQuery2 += "  and BM1.BM1_PREFIX    = '"+_cPREFIXO+"' "+CRLF
	cQuery2 += "  and BM1.BM1_NUMTIT    = '"+_cNUM+"' "+CRLF 
	cQuery2 += "  and BM1.BM1_PARCEL    = '"+_cPARCELA+"' "+CRLF
	cQuery2 += "  and BM1.BM1_TIPTIT    = '"+_cTIPO+"' "+CRLF 			
	cQuery2 += "  and BI3.BI3_CODINT  = BM1_CODINT "+CRLF
	cQuery2 += "  and BI3.BI3_CODIGO  = BM1_CODPLA "+CRLF
	cQuery2 += "ORDER BY  BI3.BI3_TIPCON, BM1_CODPLA, BM1_DESPLA,BM1_CODTIP , BM1_DESTIP "+CRLF		


	MemoWrite("C:\Temp1\CABA323_BMN.txt",cQuery2)
	//
	If Select(cAliasQ2) > 0	  
		dbSelectArea(cAliasQ2)
		dbCloseArea()
	EndIf
	cQuery := ChangeQuery(cQuery2)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),cAliasQ2,.T.,.T.)
	//
	Do while (cAliasQ2)->(!eof()) 
		//
		_nBMNREC	:= (cAliasQ2)->R_E_C_N_O_
	 	cPadrao  := "993"
		//       
	 	DbSelectArea("BM1")    
 		DbGoto(_nBMNREC) 
 		//
 		DbSelectArea("BFQ") 		&& Tabela de Itens de Faturamento (
 		DbSetOrder(1)
 		DbSeek(xFilial("BFQ")+(cAliasQ2)->BMN_CODINT+(cAliasQ2)->BMN_CODTIP)
 		//
 		DbSelectArea("BI3")  		&& Tabela de Planos
 		DbSetOrder(1)
 		DbSeek(xFilial("BI3")+(cAliasQ2)->BMN_CODINT+(cAliasQ2)->BMN_CODPLA+(cAliasQ2)->BMN_VERPLA)
 		//
 	    //
        // identifica tp de adm 
        // incluido a empresa 0352 - chamado 67645
        If cEmpAnt == '02' .and. (cAliasQ2)->CODEMP $ '0296|0260|0270|0274|0010|0262|0182|0282' 
           __T_POPERA := 'S'
        Else                
           __T_POPERA := 'N'
        EndIf   
 		
	 	_nTotal    += DetProva(nHdlPrv,cPadrao,"PLS",cLote)
		//
	 	(cAliasQ2)->(DbSkip())
        //    
    Enddo
 	//
 	nSeq ++
 	//
 	(cAliasQry)->(DbSkip())
 	//
 Enddo
//
RodaProva(nHdlPrv,_nTotal)
cA100Incl(cArquivo,nHdlPrv,3,cLote,l_Mostra,lAglutina)
nSeq := 0
//              

/*
If Select(cArqTMP) > 0
	dbSelectArea(cArqTMP)
	dbCloseArea()
EndIf     
*/
If Select(cAliasQry) > 0
	dbSelectArea(cAliasQry)
	dbCloseArea()
EndIf        
//
return 
//
//
// ******************************************************************************************************************
// ******************************************************************************************************************
//
//   ********************            FIM PROCESSAMENTO - CONTABILIZACAO RECEITA         *************************
//
// ******************************************************************************************************************
// ******************************************************************************************************************
// ******************************************************************************************************************
// ******************************************************************************************************************
//

//"+FormatIn(cTN„oSair, ",")

                

  
// ******************************************************************************************************************
// ******************************************************************************************************************
//
// ********************     INICIO DO PROCESSAMENTO - CONTABILIZACAO COMISSAO PROVISIONAMENTO   *********************
//
// ******************************************************************************************************************
// ******************************************************************************************************************
//   
//
/*/
// ******************************************************************************************************************
// ******************************************************************************************************************
// ******************************************************************************************************************
//
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ CTBCAB4  ∫ Autor ≥ Altamiro        ∫ Data ≥  28/04/2020    ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ Contablizacao de Comissoes - provisionamento               ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ SIGAFIN -                                                   ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
static Function CTBCAB4()
//
Local 	cQueryVW	:= ""
Local 	cArqTMP		:= GetNextAlias()

Private cPerg2		:= "CABA323B"
//
PutSx1( cPerg2,"01","Mostra Lancamentos?"       ,"","","mv_ch1","N",01,0,0,"C","",""   	,"","","mv_par01" ,"Sim"         ,"Sim"         ,"Sim"         ,"","N„o"        ,"N„o"       ,"N„o" )
PutSx1( cPerg2,"02","Aglutina Lancto ?"         ,"","","mv_ch2","N",01,0,0,"C","",""   	,"","","mv_par02" ,"Sim"         ,"Sim"         ,"Sim"         ,"","Nao"        ,"Nao"       ,"Nao" )
PutSx1( cPerg2,"03","Tipo de Lancamento?"       ,"","","mv_ch3","N",01,0,0,"C","",""   	,"","","mv_par03" ,"1 Do Mes"    ,"1 Do Mes"    ,"1 Do Mes"    ,"","2 Fora Mes" ,"2 Fora Mes" ,"2 Fora Mes"," 3 Ambos"," 3 Ambos"," 3 Ambos" )
PutSx1( cPerg2,"04","Ano/Mes (AAAAMM)?"         ,"","","mv_ch4","C",06,0,0,"C","",""   	,"","","mv_par04" ,"            ",""            ,""            ,"",""           ,""          ,""         ,""         ,""         ,""      ) 
PutSx1( cPerg2,"05","Do Plano? (somente Custo)" ,"","","mv_ch5","C",04,0,0,"C","",""   	,"","","mv_par05" ,"            ",""            ,""            ,"",""           ,""          ,""         ,""         ,""         ,""      )
PutSx1( cPerg2,"06","Ate o Plano"               ,"","","mv_ch6","C",04,0,0,"C","",""   	,"","","mv_par06" ,"            ",""            ,""            ,"",""           ,""          ,""         ,""         ,""         ,""      )
//
//CHAMA OS PARAMETROS
If !Pergunte( cPerg2 , .T. )
	Return
Endif
//
cMesAno		:=	MV_PAR04
cTipoMov	:= alltrim(str(MV_PAR03))
dMesProc	:=	lastday(stod(mv_par04+"01"))
cPadrao     := "996"
lPadrao     := VerPadrao(cPadrao)
//dDatabase	:=	lastday(stod(mv_par04+"01"))
dDatabase	:=	stod(mv_par04+"01")

cLote       := "009960"
//
//MOSTRA LAN«AMENTO
IIF(MV_PAR01 == 1,l_Mostra := .T.,l_Mostra := .F.)  

//AGLUTINA LAN«AMENTO
IIF(MV_PAR02 == 1,lAglutina := .T.,lAglutina := .F.)     

///cQueryVW1 := " (select max(bd7_numlot) from bd7010 bd7 where bd7_filial = ' ' and d_E_L_E_T_ = ' ' and bd7.bd7_numlot like '"+MV_PAR04+"'||'%')"

// PLANO, GRPPLANO, NOMPLAN, TPCUST, PROJ, TIPCONTR, SUM(VL_APROV) VL_APROV, SUM(VLGLOSA) VLGLOSA,SUM(VLPARTIC) VLPARTIC 
//
/*
cQueryVW := " Select A3_Cod Codvend , "+CRLF
cQueryVW += "        Substr(A3_Nome,1,20) Nomvend , "+CRLF
cQueryVW += "        Ba1_Codemp Codemp , "+CRLF
cQueryVW += "        Substr(Bg9_Descri,1,20) NomEmp , "+CRLF 
cQueryVW += "        Ba1_Codpla Plano , "+CRLF

cQueryVW += "        BXQ_E2PREF PTit , "+CRLF
cQueryVW += "        BXQ_E2NUM NTit  , "+CRLF

cQueryVW += "        Sum(Bxq_Vlrcom) Valor

cQueryVW += "   from "+RetSQLName('BXQ')+" BXQ, " +RetSQLName('SA3')+" SA3, " +RetSQLName('BG9')+" BG9, " +RetSQLName('BA1')+" BA1 "+CRLF  

cQueryVW += "  WHERE BXQ_FILIAL='"+xfilial("BXQ")+"' "+CRLF
cQueryVW += "    and BA1_FILIAL='"+xfilial("BA1")+"' "+CRLF
cQueryVW += "    and BG9_FILIAL='"+xfilial("BG9")+"' "+CRLF
cQueryVW += "    and BA1_FILIAL='"+xfilial("SA3")+"' "+CRLF

cQueryVW += "    And BA1.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    And SA3.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    And BXq.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    And BG9.D_E_L_E_T_ = ' ' "+CRLF

cQueryVW += "    And Bxq_Refere = Bxq_Pagcom "+CRLF
cQueryVW += "    And Ba1_Codemp = Bxq_Codemp "+CRLF
cQueryVW += "    And Ba1_Matric = Bxq_Matric "+CRLF
cQueryVW += "    And Ba1_Tipreg = Bxq_Tipreg "+CRLF
cQueryVW += "    And Ba1_Codint = Bg9_Codint "+CRLF
cQueryVW += "    And Bxq_Codemp = Bg9_Codigo "+CRLF
cQueryVW += "    And A3_Cod = Bxq_Codven "+CRLF

cQueryVW += "    AND BA1_CODPLA BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'"+CRLF
cQueryVW += "    and bxq_ano || bxq_mes like '"+MV_PAR04+"'||'%'"+CRLF      

cQueryVW += "  Group By A3_Cod , "+CRLF
cQueryVW += "        Substr(A3_Nome,1,20) , "+CRLF
cQueryVW += "        Ba1_Codemp , "+CRLF
cQueryVW += "        Substr(Bg9_Descri,1,20) , "+CRLF
cQueryVW += "        Ba1_Codpla , "+CRLF
cQueryVW += "        bxq.BXQ_E2PREF , "+CRLF
cQueryVW += "        BXQ_E2NUM "+CRLF

cQueryVW += "  Order By A3_Cod , "+CRLF
cQueryVW += "        Substr(A3_Nome,1,20) , "+CRLF
cQueryVW += "        Ba1_Codemp , "+CRLF
cQueryVW += "        Substr(Bg9_Descri,1,20) , "+CRLF
cQueryVW += "        Ba1_Codpla "+CRLF
*/ 
 ////

cQueryVW := " Select A3_Cod Codvend , " +CRLF
cQueryVW += "        Substr(A3_Nome,1,20) Nomvend , "+CRLF

cQueryVW += "        SE2.E2_FORNECE CODFOR , "+CRLF
cQueryVW += "        SE2.E2_NOMFOR NOMFOR ,  "+CRLF
cQueryVW += "        BXQ_ANO CMPANO , "+CRLF
cQueryVW += "        BXQ_MES CMPMES , "+CRLF

cQueryVW += "        Ba1_Codemp Codemp , "+CRLF
cQueryVW += "        Substr(Bg9_Descri,1,20) NomEmp , "+CRLF 
cQueryVW += "        Ba1_Codpla Plano , "+CRLF  

cQueryVW += "        BXQ_E2PREF PTit , "+CRLF
cQueryVW += "        BXQ_E2NUM NTit  , "+CRLF

cQueryVW += "        Sum(Bxq_Vlrcom) Valor , "+CRLF

cQueryVW += "        E2_VALOR E2VLR, E2_IRRF E2IRRF, E2_ISS E2ISS  "+CRLF

cQueryVW += "   from "+RetSQLName('BXQ')+" BXQ, " +RetSQLName('SA3')+" SA3, " +RetSQLName('BG9')+" BG9, " +RetSQLName('BA1')+" BA1 ," +RetSQLName('SE2')+" SE2 "+CRLF  

cQueryVW += "  WHERE BXQ_FILIAL='"+xfilial("BXQ")+"' "+CRLF
cQueryVW += "    and BA1_FILIAL='"+xfilial("BA1")+"' "+CRLF
cQueryVW += "    and BG9_FILIAL='"+xfilial("BG9")+"' "+CRLF
cQueryVW += "    and  A3_FILIAL='"+xfilial("SA3")+"' "+CRLF
cQueryVW += "    and  E2_FILIAL='"+xfilial("SE2")+"' "+CRLF

cQueryVW += "    And BA1.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    And SA3.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    And BXq.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    And BG9.D_E_L_E_T_ = ' ' "+CRLF
cQueryVW += "    And SE2.D_E_L_E_T_ = ' ' "+CRLF

cQueryVW += "    And Bxq_Refere = Bxq_Pagcom "+CRLF
cQueryVW += "    And Ba1_Codemp = Bxq_Codemp "+CRLF
cQueryVW += "    And Ba1_Matric = Bxq_Matric "+CRLF
cQueryVW += "    And Ba1_Tipreg = Bxq_Tipreg "+CRLF
cQueryVW += "    And Ba1_Codint = Bg9_Codint "+CRLF
cQueryVW += "    And Bxq_Codemp = Bg9_Codigo "+CRLF
cQueryVW += "    And A3_Cod = Bxq_Codven     "+CRLF

cQueryVW += "    AND BA1_CODPLA BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'"+CRLF
cQueryVW += "    and E2_BAIXA LIKE  '"+MV_PAR04+"%'" +CRLF

cQueryVW += "    AND E2_PREFIXO = 'COM'      "+CRLF
cQueryVW += "    AND E2_PREFIXO = BXQ_E2PREF "+CRLF
cQueryVW += "    AND E2_NUM     = BXQ_E2NUM  "+CRLF
cQueryVW += "    AND E2_TIPO    = BXQ_E2TIPO "+CRLF
cQueryVW += "    AND E2_FORNECE = BXQ_E2FORN "+CRLF

cQueryVW += "  Group By A3_Cod , "+CRLF
cQueryVW += "        Substr(A3_Nome,1,20) , "+CRLF
cQueryVW += "        Ba1_Codemp , "+CRLF
cQueryVW += "        Substr(Bg9_Descri,1,20) , "+CRLF
cQueryVW += "        Ba1_Codpla      , "+CRLF
cQueryVW += "        bxq.BXQ_E2PREF  , "+CRLF
cQueryVW += "        BXQ_E2NUM       , "+CRLF
cQueryVW += "        SE2.E2_FORNECE  , "+CRLF
cQueryVW += "        SE2.E2_NOMFOR   , "+CRLF
cQueryVW += "        BXQ_ANO         , "+CRLF
cQueryVW += "        BXQ_MES         ,  "+CRLF

cQueryVW += "        E2_VALOR , E2_IRRF , E2_ISS   "+CRLF 

cQueryVW += "  Order By A3_Cod               , "+CRLF
cQueryVW += "        Substr(A3_Nome,1,20)    , "+CRLF
cQueryVW += "        Ba1_Codemp              , "+CRLF
cQueryVW += "        Substr(Bg9_Descri,1,20) , "+CRLF
cQueryVW += "        Ba1_Codpla                "+CRLF 

//
If Select(cArqTMP) > 0
	dbSelectArea(cArqTMP)
	dbCloseArea()
EndIf
MemoWrite("C:\Temp1\CTB_COM.txt",cQueryVW)
//DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQueryVW), cArqTMP, .F., .T.) 
TcQuery cQueryVW New Alias (cArqTMP) New  
//
dbSelectArea(cArqTMP)
dbGoTop()
//
cArquivo := ""
nHdlPrv  := HeadProva(cLote,"COM",Substr(cUsuario,7,6),@cArquivo)
_aArea	:=	GetArea()
//
nTotReg	:=	0                                                                              
nValLan	:= 0
nSeq	:= 0
_cANOMES	:=	MV_PAR04
//
Do While (cArqTMP)->(!Eof())
 	//
	// // PLANO, GRPPLANO, NOMPLAN, TPCUST, PROJ, TIPCONTR, SUM(VL_APROV) VL_APROV, SUM(VLGLOSA) VLGLOSA,SUM(VLPARTIC) VLPARTIC 
//			
//		_CCTPLANO	:=			
//		_CCTEVENTO	:=
//		_CCTNOMEV	:=
//		_CCTQTDE	:=
//		_CCTOCORR	:=
//		_NCTGLOSA	:=
//		_NCTAPROV	:=
//		_NCTPARTIC	:=
//		_NCTEXPOS	:=
//		_CCTGRPPL	:=
//		_CCTNOMPL	:=
//		_CCTPCUST	:=
//		_CCTPROJ	:=
//		_CCTTIPO	:=
//		_CCTBENEF	:=
//		
// 	
	_CCTPLANO	:=	(cArqTMP)->PLANO	        
	_NCTAPROV	:=	(cArqTMP)->VALOR			
		
	__C_CODEMP  :=  (cArqTMP)->CODEMP 			                     
	
	__D_VENDE   :=  trim((cArqTMP)->Nomvend)    && DiscriÁ„o do vendedor

    __D_FORNECE := trim((cArqTMP)->NOMFOR)    && DiscriÁ„o do FORNECEDOR 

    __D_EMPRES  :=  (cArqTMP)->CODEMP + '-' +trim((cArqTMP)->NomEmp)
    __N_TITULO  :=  (cArqTMP)->PTit + (cArqTMP)->NTit

    _cProcDoc	:= 	__C_CODEMP +" " +__N_TITULO

    __C_COMPTE  := (cArqTMP)->CMPANO+(cArqTMP)->CMPMES

/*
    IF __C_CODEMP  !=  (cArqTMP)->CODEMP

       __VL_TITSE2  := (cArqTMP)->E2VLR   //Valor do titulos a pagar ao fornecedor  

       __IR_TITSE2  := (cArqTMP)->E2IRRF  // Valor do titulos a pagar ao IR   

       __IS_TITSE2  := (cArqTMP)->E2ISS   // Valor do titulos a pagar ao ISS 

       __C_CODEMP  :=  (cArqTMP)->CODEMP 			                     

    EndIf
*/

	dbSelectArea(cArqTMP)
 	nTotReg	++
 	//  
 	IncProc(" Processando ..." + _cProcDoc )
 	//
 	_nVALOR		:=	0  
 	//
 	_nTotal    += DetProva(nHdlPrv,cPadrao,"COM",cLote)  
 	nSeq ++
 	//  
 	(cArqTMP)->(DbSkip())
 	//
 Enddo
//
RodaProva(nHdlPrv,_nTotal)
cA100Incl(cArquivo,nHdlPrv,3,cLote,l_Mostra,lAglutina)
nSeq := 0
//
If Select(cArqTMP) > 0
	dbSelectArea(cArqTMP)
	dbCloseArea()
EndIf
//
return 
//
//
// ******************************************************************************************************************
// ******************************************************************************************************************
//
//   ********************            FIM PROCESSAMENTO - CONTABILIZACAO COMISSAO      *************************
//
// ******************************************************************************************************************
// ******************************************************************************************************************
//   
//
/*/             
