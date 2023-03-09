#include "PLSMGER.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ RLCTOP  ³ Autor ³ Jean Schulz            ³ Data ³ 15.05.09 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio para contabilizacao do OPME                      ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
User Function RLCTOP()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variavaoeis...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nQtdLin 	:= 58
PRIVATE cNomeProg   := "RLCTOPE"
PRIVATE nCaracter   := 15
PRIVATE nLimite     := 132
PRIVATE cTamanho    := "M"
PRIVATE cTitulo     := "Analítico de fornecedores - NF."
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cCabec1     := "                                                                                                      "
PRIVATE cCabec2     := ""
PRIVATE cAlias      := "SF1"
PRIVATE cPerg       := "RLCTOP"
PRIVATE cRel        := "RLCTOPE"
PRIVATE nLi         := 01
PRIVATE m_pag       := 1
PRIVATE aReturn     := { "Zebrado", 1,"Administracao", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE aOrdens     := {}
PRIVATE lDicion     := .F.
PRIVATE lCompres    := .F.
PRIVATE lCrystal    := .F.
PRIVATE lFiltro     := .T.

/*
          10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Fornecedor                         NF              Emissao  Vencimento   Pagamento     Valor Bruto   Desconto     Valor Liquido 


*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama SetPrint                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1(cPerg)
cRel := SetPrint(cAlias,cRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi cancelada a operacao                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey  == 27
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe parametros                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

PutSx1(cPerg,"01",OemToAnsi("Operadora")				,"","","mv_ch1","C",04,0,0,"G","","B89","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Plano De")				,"","","mv_ch2","C",04,0,0,"G","","BG9","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Plano Ate")				,"","","mv_ch3","C",04,0,0,"G","","BG9","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Fornecedor De")			,"","","mv_ch4","C",15,0,0,"G","","BE3","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Fornecedor Ate")		,"","","mv_ch5","C",15,0,0,"G","","BE3","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Data Movto De")   		,"","","mv_ch6","D",08,0,0,"G","",	"","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Data Movto Ate")  		,"","","mv_ch7","D",08,0,0,"G","",	"","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Tipo de Relatório?")	,"","","mv_ch8","C",01,0,0,"C","",	"","","","mv_par08","Autorizado","","","","Pago","","","Ambos","","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Data Pgto De")   		,"","","mv_ch9","D",08,0,0,"G","",	"","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Data Pgto Ate")  		,"","","mv_ch10","D",08,0,0,"G","",	"","","","mv_par10","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("Data Venc De")   		,"","","mv_ch11","D",08,0,0,"G","",	"","","","mv_par11","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"12",OemToAnsi("Data Venc Ate")  		,"","","mv_ch12","D",08,0,0,"G","",	"","","","mv_par12","","","","","","","","","","","","","","","","",{},{},{})


cOpe     	:= mv_par01
cPlanoDe	:= mv_par02
cPlanoAte	:= mv_par03
cCodForDe 	:= mv_par04
cCodForAte	:= mv_par05
dDatDe		:= mv_par06
dDatAte	:= mv_par07
lPago		:= (mv_par08==2)
lAmbos     := (mv_par08==3)//acrescentado por Renato Peixoto em 07/12/10 para contemplar um relatório de conferência onde possa ser visto tudo que ocorreu em um determinado mês (tanto autorizado como pago no mesmo mês) 
dDtPgDe	:= mv_par09
dDtPgAte	:= mv_par10
dDtVencDe  := mv_par11
dDtVencAte := mv_par12



cCabec1 := "Plano "
cCabec2 := "Fornecedor                         NF              Emissao  Vencimento   Pagamento     Valor Bruto   Desconto     Valor Liquido "

cTitulo := AllTrim(cTitulo) + " - " + " Período: "+DtoC(dDatDe)+" até "+DtoC(dDatAte)+" Situação "+Iif(mv_par08=3,"AMBOS",Iif(mv_par08=2,"PAGO","AUTORIZADO")) //Iif(lPago,"PAGO","AUTORIZADO")  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura Impressora                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta RptStatus...                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| ImpRel(cPerg)},cTitulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina Principal...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±±
±±³Funcao    ³ ImpRel  ³ Autor ³ Jean Schulz            ³ Data ³ 15.05.09 ³±±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±±
±±³Descricao ³ Relatorio de OPME.                                         ³±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define nome da funcao                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ImpRel()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do IndRegua...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL i
LOCAL n
LOCAL _cEmpRel := Iif(Substr(cNumEmp,1,2)=="01",'C','I')

LOCAL pMoeda1	:= "@E 999,999.99"
LOCAL pMoeda2	:= "@E 999,999,999.99"
LOCAL nQtd		:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Expressao de filtro...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery := " SELECT DISTINCT F1_DOC, F1_SERIE, F1_FORNECE, A2_NOME, E2_EMISSAO, E2_VENCTO, "
cQuery += " ( "
cQuery += "		F1_DESCONT/(SELECT Count(R_E_C_N_O_) FROM SIGA."+RetSQLName("SE2")+" SE2I "
cQuery += " 	WHERE E2_FILIAL = F1_FILIAL "
cQuery += "		AND E2_PREFIXO = F1_SERIE "
cQuery += "		AND E2_NUM = F1_DOC "
cQuery += "		AND E2_FORNECE = F1_FORNECE "
cQuery += "		AND SE2I.D_E_L_E_T_ = ' ' ) "
cQuery += " ) DESCONTO, "
cQuery += " E2_VALOR VLRLIQUIDO, E2_SALDO VALORSALDO, "
cQuery += " E2_BAIXA, retorna_plano_usu_ms ( '"+_cEmpRel+"',BD6_OPEUSR,BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,'n') CODPLANO, BI3_DESCRI DESCRPLANO "

cQuery += " FROM "+RetSQLName("B19")+" B19, "+RetSQLName("SD1")+" SD1, "+RetSQLName("SF1")+" SF1, "
cQuery += RetSQLName("BD6")+" BD6 , "+RetSQLName("SA2")+" SA2, "+RetSQLName("SE2")+" SE2, "+RetSQLName("BI3")+" BI3 "

cQuery += " WHERE A2_COD = B19_FORNEC "
cQuery += " AND D1_DOC = F1_DOC "
cQuery += " AND B19_DOC = D1_DOC "
cQuery += " AND D1_ITEM = B19_ITEM "
cQuery += " AND BD6_FILIAL = '"+xFilial("BD6")+"' "
cQuery += " AND BD6_CODOPE = SubStr(B19_GUIA,01,04) "
cQuery += " AND BD6_CODLDP = SubStr(B19_GUIA,05,04) "
cQuery += " AND BD6_CODPEG = SubStr(B19_GUIA,09,08) "
cQuery += " AND BD6_NUMERO = SubStr(B19_GUIA,17,08) "
cQuery += " AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) "
cQuery += " AND BD6_SEQUEN = SubStr(B19_GUIA,26,03) "
cQuery += " AND F1_FORNECE BETWEEN '"+cCodForDe+"' AND '"+cCodForAte+"' "

//cQuery += " AND E2_EMISSAO BETWEEN '"+DtoS(dDatDe)+"' AND '"+DtoS(dDatAte)+"' "

// trata vencrea se2 -- altamiro

if !empty(dtos(dDtVencDe))
	cQuery += " AND E2_vencrea  >= '"+DtoS(dDtVencDe)+"' "
Endif

if !empty(dtos(dDtVencate))
	cQuery += " AND E2_vencrea  <= '"+DtoS(dDtVencate)+"' "
endif

if !empty(dtos(dDatDe)) 
    cQuery += " AND E2_EMISSAO >= '"+DtoS(dDatDe)+"' "
EndIf     	 	

if !empty(dtos(dDatAte))
	cQuery += " AND E2_EMISSAO <= '"+DtoS(dDatAte)+"' "
EndIf

/*
if !empty(dtos(dDatDe)) 
    cQuery += " AND BD6_DATPRO >= '"+DtoS(dDatDe)+"' "
EndIf     	 	

if !empty(dtos(dDatAte))
	cQuery += " AND BD6_DATPRO <= '"+DtoS(dDatAte)+"' "
EndIf	

*/

if !empty(dtos(dDtPgDe))
    cQuery += " AND E2_BAIXA >= '"+DtoS(dDtPgDe)+"' "
EndIf     	 	

if !empty(dtos(dDtPgAte))
	cQuery += " AND E2_BAIXA <= '"+DtoS(dDtPgAte)+"' "
EndIf	


/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Trecho incluído por Renato Peixoto em 07/12/10 a pedido      ³
//³do usuário Otaciano para pode visualizar tanto os autorizados³
//³como os pagos em um determinado mês.                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
If !lambos
	If lPago
		cQuery += " AND E2_BAIXA <> ' ' " 
	Else
		cQuery += " AND E2_BAIXA = ' ' "
	Endif
EndIf
//Fim alteração Renato Peixoto.
cQuery += " AND BI3_FILIAL = '"+xFilial("BI3")+"' "
cQuery += " AND BI3_CODINT = BD6_CODOPE "
cQuery += " AND BI3_CODIGO = retorna_plano_usu_ms ( '"+_cEmpRel+"',BD6_OPEUSR,BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,'N') "

cQuery += " AND BI3_CODIGO BETWEEN '"+cPlanoDe+"' AND '"+cPlanoAte+"' "

cQuery += " AND E2_FILIAL = '"+xFilial("SE2")+"' "
cQuery += " AND A2_FILIAL = '"+xFilial("SA2")+"' "
cQuery += " AND D1_FILIAL = '"+xFilial("SD1")+"' "
cQuery += " AND F1_FILIAL = '"+xFilial("SF1")+"' "
cQuery += " AND F1_FORNECE = D1_FORNECE "
cQuery += " AND F1_FORNECE = B19_FORNEC "

cQuery += " AND E2_FILIAL = F1_FILIAL "
cQuery += " AND E2_PREFIXO = F1_SERIE "
cQuery += " AND E2_NUM = F1_DOC "
cQuery += " AND E2_FORNECE = F1_FORNECE "
cQuery += " AND SE2.D_E_L_E_T_ = ' ' "
cQuery += " AND SA2.D_E_L_E_T_ = ' ' "
cQuery += " AND B19.D_E_L_E_T_ = ' ' "
cQuery += " AND SD1.D_E_L_E_T_ = ' ' "
cQuery += " AND SF1.D_E_L_E_T_ = ' ' "
cQuery += " AND BI3.D_E_L_E_T_ = ' ' "
cQuery += " AND BD6.D_E_L_E_T_ = ' ' "

cQuery += " ORDER BY CODPLANO, F1_FORNECE, F1_DOC, E2_VENCTO, E2_BAIXA

memowrite("C:\Microsiga\RLCTOP.TXT",cQuery)

PlsQuery(cQuery, "TRBOPM")

nQtd:=0
TRBOPM->(DBEval( { | | nQtd ++ }))
ProcRegua(nQtd)

TRBOPM->(DbGoTop())
nLi := 500
nTotBruto	:= 0 
nTotDesc		:= 0
nTotLiq		:= 0		

cPlaAnt		:= "ZZZZ"

nTotGBruto	:= 0
nTotGDesc  	:= 0
nTotGLiq   	:= 0

While ! TRBOPM->(Eof())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apresenta mensagem em tela...                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncProc( "Processando..."+TRBOPM->(F1_DOC+'/'+F1_SERIE) )
	
	If  nli > nQtdLin 	
		nLi := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nLi++		
	Endif
	
	If cPlaAnt <> Alltrim(TRBOPM->CODPLANO)
	
		If nTotBruto+nTotDesc+nTotLiq > 0
                                          
			@ nLi, 090 Psay Replicate('-',40)
			nLi++
			@ nLi, 001 Psay "Total: "
			@ nLi, 084 Psay Transform(nTotBruto,"@E 9,999,999.99")
			@ nLi, 100 Psay Transform(nTotDesc, "@E 99,999.99")
			@ nLi, 112 Psay Transform(nTotLiq,	"@E 9,999,999.99")			
			
			nTotGBruto += nTotBruto
			nTotGDesc  += nTotDesc
			nTotGLiq   += nTotLiq
			
			nTotBruto := 0
			nTotDesc  := 0
			nTotLiq   := 0
			
			nLi := nLi+2
			
		Endif
	
		@ nLi, 001 Psay Alltrim(TRBOPM->CODPLANO)+"-"+Alltrim(TRBOPM->DESCRPLANO)
		nLi++
		@ nLi, 001 Psay Replicate('-',35)
		nLi++
		cPlaAnt := Alltrim(TRBOPM->CODPLANO)
	Endif

	@ nLi, 001 Psay TRBOPM->F1_FORNECE+" "+Substr(TRBOPM->A2_NOME,1,20)
	@ nLi, 035 Psay TRBOPM->F1_DOC+"/"+TRBOPM->F1_SERIE
	@ nLi, 050 Psay DtoC(TRBOPM->E2_EMISSAO)
	@ nLi, 062 Psay DtoC(TRBOPM->E2_VENCTO)
	@ nLi, 074 Psay DtoC(TRBOPM->E2_BAIXA)
	//@ nLi, 089 Psay Transform(TRBOPM->(VLRLIQUIDO+DESCONTO),  "@E 999,999.99")
	@ nLi, 086 Psay Transform(TRBOPM->(VLRLIQUIDO+DESCONTO),  "@E 999,999.99")
	//@ nLi, 099 Psay Transform(TRBOPM->DESCONTO,  "@E 999,999.99")
	@ nLi, 099 Psay Transform(TRBOPM->DESCONTO,  "@E 999,999.99")
//	@ nLi, 120 Psay Transform(TRBOPM->(VLRLIQUIDO-VALORSALDO),"@E 99,999.99")   
	//@ nLi, 119 Psay Transform(TRBOPM->(VLRLIQUIDO),"@E 999,999.99")
	@ nLi, 114 Psay Transform(TRBOPM->(VLRLIQUIDO),"@E 999,999.99")
	
	nLi++

	nTotBruto	+= TRBOPM->(VLRLIQUIDO+DESCONTO)
	nTotDesc	+= TRBOPM->DESCONTO
	nTotLiq		+= TRBOPM->(VLRLIQUIDO)

	TRBOPM->(dbSkip())
	
Enddo           


@ nLi, 090 Psay Replicate('-',40)
nLi++
@ nLi, 001 Psay "Total: "
@ nLi, 084 Psay Transform(nTotBruto,"@E 9,999,999.99")
@ nLi, 097 Psay Transform(nTotDesc, "@E 9,999,999.99")
@ nLi, 112 Psay Transform(nTotLiq,	"@E 9,999,999.99")

nLi := nLi+2

nTotGBruto+= nTotBruto
nTotGDesc  += nTotDesc
nTotGLiq   += nTotLiq

@ nLi, 001 Psay "Total Geral: "
@ nLi, 080 Psay Transform(nTotGBruto,"@E 9,999,999,999.99")
@ nLi, 097 Psay Transform(nTotGDesc, "@E 9,999,999.99")
@ nLi, 110 Psay Transform(nTotGLiq,	"@E 9,999,999,999.99")

nTotBruto := 0
nTotDesc  := 0
nTotLiq   := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa impressao                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  nli > nQtdLin
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nli++
Endif

nLi++
@ nLi, 000 Psay Replicate('-', nLimite)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime rodape...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(0,Space(10))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha area de trabalho...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA3->(DbClearFilter())
BA3->(RetIndex("BA3"))

TRBOPM->( dbClosearea() )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If  aReturn[5] == 1
	Set Printer To
	Ourspool(crel)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da impressao do relatorio...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Angelo Sperandio     ³ Data ³ 03.02.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CriaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Operadora")				,"","","mv_ch1"	,"C",04,0,0,"G","","B89","",""	,"mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Plano De")				,"","","mv_ch2"	,"C",04,0,0,"G","","BI3","",""	,"mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Plano Ate")				,"","","mv_ch3"	,"C",04,0,0,"G","","BI3","",""	,"mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Fornecedor De")			,"","","mv_ch4"	,"C",06,0,0,"G","","BE3","",""	,"mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Fornecedor Ate")		   	,"","","mv_ch5"	,"C",06,0,0,"G","","BE3","",""	,"mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Data Movto De")   		,"","","mv_ch6"	,"D",08,0,0,"G","",	"","",""	,"mv_par06","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Data Movto Ate")  		,"","","mv_ch7"	,"D",08,0,0,"G","",	"","",""	,"mv_par07","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08",OemToAnsi("Tipo de Relatório?")	,"","","mv_ch8"	,"C",01,0,0,"C","",	"","",""	,"mv_par08","Autorizado","","","","Pago","","","Ambos","","","","","","","","",{},{},{})
PutSx1(cPerg,"09",OemToAnsi("Data Pgto De")   		,"","","mv_ch9"	,"D",08,0,0,"G","",	"","",""	,"mv_par09","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"10",OemToAnsi("Data Pgto Ate")  		,"","","mv_ch10"	,"D",08,0,0,"G","",	"","",""	,"mv_par10","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"11",OemToAnsi("Data Venc De")   		,"","","mv_ch11"	,"D",08,0,0,"G","",	"","",""	,"mv_par11","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"12",OemToAnsi("Data Venc Ate")  		,"","","mv_ch12"	,"D",08,0,0,"G","",	"","",""	,"mv_par12","","","","","","","","","","","","","","","","",{},{},{})

Return
