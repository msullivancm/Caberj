#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA088  บ Autor ณ Rafael Lima        บ Data ณ  21/07/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Conversao de codigos contabeis.                            บฑฑ
ฑฑบ          ณ Rotina para troca do plano de contas por uma nova codifi-  บฑฑ
ฑฑบ          ณ cacao adiconando itens contabeis nas tabelas relacionadas. บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABA088cc()

Local ocbBFQ
Local ocbBI3
Local ocbCT2
Local ocbCT3
Local ocbCT5
Local ocbCTK
Local ocbCTS
Local ocbCV3
Local ocbOUT
Local ocbSA1
Local ocbSA2
Local ocbSB1
Local ocbSBM
Local ocbSC1
Local ocbSC7
Local ocbSCP
Local ocbSCQ
Local ocbSRZ
Local ocbSD1
Local ocbSD3
Local ocbSE1
Local ocbSE2
Local ocbSED
Local ocbSET
Local ocbSEU
Local ocbSN3
Local ocbSN4
Local ocbSN5
Local ocbSN6
Local ocbSNG
Local osbSA6
// Local osbSZQ 

// Local osbZUI

Private lcbBFQ	 := .F.
Private lcbSZQ	 := .F.
Private lcbBI3	 := .F.
Private lcbCT2	 := .F.
Private lcbCT5	 := .F.
Private lcbCT3	 := .F.
Private lcbCTK	 := .F.
Private lcbCTS	 := .F.
Private lcbCV3	 := .F.
Private lcbOUT	 := .F.
Private lcbSA1	 := .F.
Private lcbSA2	 := .F.
Private lcbSB1	 := .F.
Private lcbSBM	 := .F.
Private lcbSC1	 := .F.
Private lcbSC7	 := .F.
Private lcbSCP	 := .F.
Private lcbSCQ	 := .F.
Private lcbSRZ	 := .F.
Private lcbSD1	 := .F.
Private lcbSD3	 := .F.
Private lcbSE1	 := .F.
Private lcbSE2	 := .F.
Private lcbSED	 := .F.
Private lcbSET	 := .F.
Private lcbSEU	 := .F.
Private lcbSN3	 := .F.
Private lcbSN4	 := .F.
Private lcbSN5	 := .F.
Private lcbSN6	 := .F.
Private lcbSNG	 := .F.
Private lcbSA6	 := .F. 

Private lcbZUI	 := .F.

Private aDePara  := {}
Private oProcess := Nil
Private cPerg    := "CAB088    "

Private _oDlg
Private VISUAL := .F.
Private INCLUI := .F.
Private LALTERA := .F.
Private DELETA := .F.

ValidPerg()

If !Pergunte(cPerg,.T.)
	Return
Endif

//OpenCT2_Producao()

DEFINE MSDIALOG _oDlg TITLE "Troca de Contas Contabeis" FROM C(178),C(181) TO C(535),C(866) PIXEL

// Cria Componentes Padroes do Sistema
@ C(006),C(011) Say "Selecione as Tabelas:" Size C(054),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(020),C(010) CheckBox ocbSED Var lcbSED Prompt "SED - Cadastro de Naturezas" Size C(095),C(008) PIXEL OF _oDlg
@ C(020),C(125) CheckBox ocbSE1 Var lcbSE1 Prompt "SE1 - Contas a Receber" Size C(095),C(008) PIXEL OF _oDlg
@ C(020),C(240) CheckBox ocbSEU Var lcbSEU Prompt "SEU - Movimento do Caixinha" Size C(095),C(008) PIXEL OF _oDlg
@ C(030),C(010) CheckBox ocbSNG Var lcbSNG Prompt "SNG - Cadastro de Grupo de Bens" Size C(095),C(008) PIXEL OF _oDlg
@ C(030),C(125) CheckBox ocbSE2 Var lcbSE2 Prompt "SE2 - Contas a Pagar" Size C(095),C(008) PIXEL OF _oDlg
@ C(030),C(240) CheckBox ocbSN3 Var lcbSN3 Prompt "SN3 - Cadastro de Saldos e Valores" Size C(095),C(008) PIXEL OF _oDlg
@ C(040),C(010) CheckBox ocbSB1 Var lcbSB1 Prompt "SB1 - Cadastro de Produtos" Size C(095),C(008) PIXEL OF _oDlg
@ C(040),C(125) CheckBox ocbSD1 Var lcbSD1 Prompt "SD1 - Itens NF Entrada" Size C(095),C(008) PIXEL OF _oDlg
@ C(040),C(240) CheckBox ocbSN4 Var lcbSN4 Prompt "SN4 - Movimenta็๔es do Ativo Fixo" Size C(095),C(008) PIXEL OF _oDlg
@ C(050),C(010) CheckBox ocbSBM Var lcbSBM Prompt "SBM - Grupo de Produtos" Size C(095),C(008) PIXEL OF _oDlg
@ C(050),C(125) CheckBox ocbSD3 Var lcbSD3 Prompt "SD3 - Movimento Interno" Size C(095),C(008) PIXEL OF _oDlg
@ C(050),C(240) CheckBox ocbSN5 Var lcbSN5 Prompt "SN5 - Arquivos de Saldos" Size C(095),C(008) PIXEL OF _oDlg
@ C(060),C(010) CheckBox ocbSA1 Var lcbSA1 Prompt "SA1 - Cadastro de Clientes" Size C(095),C(008) PIXEL OF _oDlg
@ C(060),C(125) CheckBox ocbSC1 Var lcbSC1 Prompt "SC1 - Solicita็โo de Compra" Size C(095),C(008) PIXEL OF _oDlg
@ C(060),C(240) CheckBox ocbSN6 Var lcbSN6 Prompt "SN6 - Saldos Por Conta e item" Size C(095),C(008) PIXEL OF _oDlg
@ C(070),C(010) CheckBox ocbSA2 Var lcbSA2 Prompt "SA2 - Cadastro de Fornecedores" Size C(095),C(008) PIXEL OF _oDlg
@ C(070),C(125) CheckBox ocbSC7 Var lcbSC7 Prompt "SC7 - Pedidos de Compra" Size C(095),C(008) PIXEL OF _oDlg
@ C(070),C(240) CheckBox ocbCV3 Var lcbCV3 Prompt "CV3 - Rastreamento Lan็amento" Size C(095),C(008) PIXEL OF _oDlg
@ C(080),C(010) CheckBox osbSA6 Var lcbSA6 Prompt "SA6 - Cadastro de Bancos" Size C(095),C(008) PIXEL OF _oDlg
@ C(080),C(125) CheckBox ocbSRZ Var lcbSRZ Prompt "SRZ - Folha de pagamento " Size C(095),C(008) PIXEL OF _oDlg
@ C(080),C(240) CheckBox ocbCT2 Var lcbCT2 Prompt "CT2 - Movimento Contabil" Size C(095),C(008) PIXEL OF _oDlg   

@ C(090),C(010) CheckBox ocbBFQ Var lcbBFQ Prompt "BFQ - Lan็. do Faturamento" Size C(095),C(008) PIXEL OF _oDlg
@ C(090),C(125) CheckBox ocbSCP Var lcbSCP Prompt "SCP - Solicita็๕es ao Armazem" Size C(095),C(008) PIXEL OF _oDlg
@ C(090),C(240) CheckBox ocbCT3 Var lcbCT3 Prompt "CT3 - Saldo C.Custo" Size C(095),C(008) PIXEL OF _oDlg
@ C(090),C(240) CheckBox ocbCT5 Var lcbCT5 Prompt "CT5 - Lancamentos Padronizados" Size C(095),C(008) PIXEL OF _oDlg  

@ C(100),C(010) CheckBox ocbBI3 Var lcbBI3 Prompt "BI3 - Produto Saude" Size C(095),C(008) PIXEL OF _oDlg
@ C(100),C(125) CheckBox ocbSCQ Var lcbSCQ Prompt "SCQ - Pr้-Requisi็๕es" Size C(095),C(008) PIXEL OF _oDlg
@ C(100),C(240) CheckBox ocbCTK Var lcbCTK Prompt "CTK - Arq. Contra Prova" Size C(095),C(008) PIXEL OF _oDlg      

@ C(110),C(010) CheckBox ocbCTS Var lcbCTS Prompt "CTS - Visoes Gerenciais" Size C(095),C(008) PIXEL OF _oDlg
@ C(110),C(125) CheckBox ocbSET Var lcbSET Prompt "SET - Cadastro de Caixinhas" Size C(095),C(008) PIXEL OF _oDlg
@ C(110),C(240) CheckBox ocbOUT Var lcbOUT Prompt "Outras Tabelas" Size C(095),C(008) PIXEL OF _oDlg   

@ C(120),C(010) CheckBox ocbZUI Var lcbZUI Prompt "ZUI - Combina็aos Contabeis?" Size C(095),C(008) PIXEL OF _oDlg 

@ C(125),C(008) Button "Divergencias"  Size C(037),C(012) Action Diverg() PIXEL OF _oDlg
@ C(140),C(008) Button "Processar"     Size C(037),C(012) Action ProcItem() PIXEL OF _oDlg
@ C(125),C(123) Button "Marca Tudo  "  Size C(037),C(012) Action MarcaTud(.T.) PIXEL OF _oDlg
@ C(140),C(123) Button "Desmarca Tudo" Size C(037),C(012) Action MarcaTud(.F.) PIXEL OF _oDlg
@ C(155),C(123) Button "Cancelar"      Size C(037),C(012) Action Close(_oDlg) PIXEL OF _oDlg

ACTIVATE MSDIALOG _oDlg CENTERED

Return

Static Function MarcaTud(lMarca)
lcbBFQ := IIf(lMarca,.T.,.F.)
lcbSZQ := IIf(lMarca,.T.,.F.)
lcbBI3 := IIf(lMarca,.T.,.F.)
lcbCT2 := IIf(lMarca,.T.,.F.)
lcbCT5 := IIf(lMarca,.T.,.F.)
lcbCTK := IIf(lMarca,.T.,.F.)
lcbCTS := IIf(lMarca,.T.,.F.)
lcbCV3 := IIf(lMarca,.T.,.F.)
lcbOUT := IIf(lMarca,.T.,.F.)
lcbSA1 := IIf(lMarca,.T.,.F.)
lcbSA2 := IIf(lMarca,.T.,.F.)
lcbSB1 := IIf(lMarca,.T.,.F.)
lcbSBM := IIf(lMarca,.T.,.F.)
lcbSC1 := IIf(lMarca,.T.,.F.)
lcbSC7 := IIf(lMarca,.T.,.F.)
lcbSCP := IIf(lMarca,.T.,.F.)
lcbSCQ := IIf(lMarca,.T.,.F.)
lcbSRZ := IIf(lMarca,.T.,.F.)
lcbSD1 := IIf(lMarca,.T.,.F.)
lcbSD3 := IIf(lMarca,.T.,.F.)
lcbSE1 := IIf(lMarca,.T.,.F.)
lcbSE2 := IIf(lMarca,.T.,.F.)
lcbSED := IIf(lMarca,.T.,.F.)
lcbSET := IIf(lMarca,.T.,.F.)
lcbSEU := IIf(lMarca,.T.,.F.)
lcbSN3 := IIf(lMarca,.T.,.F.)
lcbSN4 := IIf(lMarca,.T.,.F.)
lcbSN5 := IIf(lMarca,.T.,.F.)
lcbSN6 := IIf(lMarca,.T.,.F.)
lcbSNG := IIf(lMarca,.T.,.F.)
lcbSA6 := IIf(lMarca,.T.,.F.) 

lcbZUI := IIf(lMarca,.T.,.F.)

Return

Static Function Diverg()
Local lEnd := .F.
Local oProcess
oProcess := MsNewProcess():New({|lEnd| Diver(lEnd,oProcess)},"Gerando diverg๊ncias","Lendo...",.T.)
oProcess:Activate()
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบFuncao    ณ ProcItem   บ Autor ณ Rafael Lima        บ Data ณ  21/07/09 บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Prepara Carga das Tabelas Para De/Para                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ProcItem()

//aadd(aDePara,{"SA2",{"A2_P3COD","A2_P3LOJA"},"A2_FILIAL","A2_COD+A2_LOJA = D1_FORNECE+D1_LOJA","SD1",{"D1_FORNECE","D1_LOJA"},"D1_TIPO NOT IN ('D','B')"}

/* <--   Alterdo para nao contemplar iten contabil no de - para de 29/05/2010 em 20/05/2010   - por altamiro 

MsgInfo("Inicio da atualiza็ใo do Item Contแbil","Aten็ใo")

If lcbSE1
	// "Contas a Receber"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = E1_DEBITO" 		,"SE1"	,"E1_ITEMD"			," E1_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = E1_CREDIT" 		,"SE1"	,"E1_ITEMC"			," E1_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSEU
	// "Movimento do Caixinha"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = EU_CONTA" 		,"SEU"	,"EU_ITEM"			," EU_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = EU_CONTAD" 		,"SEU"	,"EU_ITEMD"			," EU_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = EU_CONTAC" 		,"SEU"	,"EU_ITEMC"			," EU_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSE2
	// "Contas a Pagar"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = E2_DEBITO" 		,"SE2"	,"E2_ITEMD"			," E2_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = E2_CREDIT" 		,"SE2"	,"E2_ITEMC"			," E2_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSD1
	// "Itens NF Entrada"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = D1_CONTA" 		,"SD1"	,"D1_ITEMCTA"			," D1_DTDIGIT BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSN4
	// "Movimentacoes do Ativo Fixo"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = N4_CONTA" 		,"SN4"	,"N4_SUBCTA"			," N4_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSD3
	// "Movimento Interno"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = D3_CONTA" 		,"SD3"	,"D3_ITEMCTA"			," D3_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSC1
	// "Solicitacao de Compra"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = C1_CONTA" 		,"SC1"	,"C1_ITEMCTA"			," C1_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSN6
	// "Saldos Por Conta e item"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = N6_CONTA" 		,"SN6"	,"N6_SUBCTA"			," N6_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSC7
	// "Pedidos de Compra"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = C7_CONTA" 		,"SC7"	,"C7_ITEMCTA"			," C7_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbCV3
	// "Rastreamento Lancamento"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = CV3_CREDIT" 		,"CV3"	,"CV3_ITEMC"			," CV3_DTSEQ BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = CV3_DEBITO" 		,"CV3"	,"CV3_ITEMD"			," CV3_DTSEQ BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSCY
	// "Historico Pedidos de Compra"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = CY_CONTA" 		,"SCY"	,"CY_ITEMCTA"			," CY_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbCT2
	// "Movimento Contabil"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = CT2_CREDIT" 		,"CT2"	,"CT2_ITEMC"			," CT2_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = CT2_DEBITO" 		,"CT2"	,"CT2_ITEMD"			," CT2_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSCP
	// "SOLICITACOES AO ARMAZEM"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = CP_CONTA" 		,"SCP"	,"CP_ITEMCTA"			," CP_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSCQ
	// "PRE-REQUISICOES"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = CQ_CONTA" 		,"SCQ"	,"CQ_ITEMCTA"			," CQ_DATPRF BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbOUT
	
	// "Movimento Bancario"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = E5_DEBITO" 		,"SE5"	,"E5_ITEMD"			," E5_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = E5_CREDITO" 		,"SE5"	,"E5_ITEMC"			," E5_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Orcamentos"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = E7_DEBITO" 		,"SE7"	,"E7_ITEMD"			," " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = E7_CREDIT" 		,"SE7"	,"E7_ITEMC"			," " })
	
	// "Titulos Enviados ao Banco"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = EA_DEBITO" 		,"SEA"	,"EA_ITEMD"			," EA_DATABOR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = EA_CREDIT" 		,"SEA"	,"EA_ITEMC"			," EA_DATABOR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Cadastro de Cheques"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = EF_DEBITO" 		,"SEF"	,"EF_ITEMD"			," EF_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = EF_CREDIT" 		,"SEF"	,"EF_ITEMC"			," EF_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Controle de Aplicacao/Emprestimo"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = EH_DEBITO" 		,"SEH"	,"EH_ITEMD"			," EH_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = EH_CREDIT" 		,"SEH"	,"EH_ITEMC"			," EH_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Itens NF Saida"
	aadd(aDePara,{"PB1","PB1_ITEMCT","PB1_FILIAL","PB1_CTVELH = D2_CONTA" 		,"SD2"	,"D2_ITEMCC"			," D2_DTDIGIT BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

oProcess := MsNewProcess():New({|lEnd| FazDePara(lEnd,oProcess)},"Processando","Lendo...",.T.)
oProcess:Activate()

MsgInfo("Fim da atualiza็ใo do Item Contแbil","Aten็ใo")
*/
//Processar altera็๕es nas contas contแbeis
ProcConta()
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบFuncao    ณ ProcConta บ Autor ณ Rafael Lima        บ Data ณ  21/07/09 บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Prepara Carga das Tabelas Para De/Para                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ProcConta()
//aadd(aDePara,{"SA2",{"A2_P3COD","A2_P3LOJA"},"A2_FILIAL","A2_COD+A2_LOJA = D1_FORNECE+D1_LOJA","SD1",{"D1_FORNECE","D1_LOJA"},"D1_TIPO NOT IN ('D','B')"})

aDePara  := {}
MsgInfo("Inicio da atualiza็ใo da Conta Contแbil","Aten็ใo")
If lcbSED
	// "Cadastro de Naturezas"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ED_CCC" 		,"SED"	,"ED_CCC"			," "})
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ED_CCD" 		,"SED"	,"ED_CCD"			," "})
	
Endif

If lcbSE1
	// "Contas a Receber"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E1_CCD" 		,"SE1"	,"E1_CCD"			," E1_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E1_CCC" 		,"SE1"	,"E1_CCC"			," E1_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSEU
	// "Movimento do Caixinha"
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EU_CONTA" 		,"SEU"	,"EU_CONTA"			," EU_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " }) ALTAMIRO 25/03/21
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EU_CCD" 		,"SEU"	,"EU_CCD"			," EU_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EU_CCC" 		,"SEU"	,"EU_CCC"			," EU_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSNG
	// "Cadastro de Grupo de Bens"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = NG_CUSTBEM" 		,"SNG"	,"NG_CUSTBEM"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = NG_CCDESP" 		    ,"SNG"	,"NG_CCDESP"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = NG_CCCDEP" 		    ,"SNG"	,"NG_CCCDEP"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = NG_CCCDES" 		    ,"SNG"	,"NG_CCCDES"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = NG_CCCORR" 	    	,"SNG"	,"NG_CCCORR"			," " })
Endif

If lcbSE2
	// "Contas a Pagar"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E2_CCD" 		,"SE2"	,"E2_CCD"			," E2_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E2_CCC" 		,"SE2"	,"E2_CCC"			," E2_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E2_CREDIT" 		,"SE2"	,"E2_CREDIT"			," E2_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })  ALTAMIRO	25/03/21
Endif

If lcbSN3
	// "Cadastro de Saldos e Valores"
/*	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CCONTAB" 		,"SN3"	,"N3_CCONTAB"		," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CDEPREC" 		,"SN3"	,"N3_CDEPREC"		," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CCDEPR" 		    ,"SN3"	,"N3_CCDEPR"		," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CDESP" 		    ,"SN3"	,"N3_CDESP"			," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CCORREC" 		,"SN3"	,"N3_CCORREC"		," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
*/
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CUSTBEM" 		,"SN3"	,"N3_CUSTBEM"		," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CCUSTO" 		    ,"SN3"	,"N3_CCUSTO"		," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CCDESP" 		    ,"SN3"	,"N3_CCDESP"	    	," " })
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CDESP" 		    ,"SN3"	,"N3_CDESP"			," " }) ALTAMIRO 25/03/21
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N3_CCORREC" 		,"SN3"	,"N3_CCORREC"		," " }) ALTAMIRO 25/03/21


Endif

If lcbSB1
	// "Cadastro de Produtos"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = B1_CC" 		,"SB1"	,"B1_CC"			," " })
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = B1_CONTAE" 		,"SB1"	,"B1_CONTAE"		," " })  ALTAMIRO 25/03/21
Endif

If lcbSD1
	// "Itens NF Entrada"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = D1_CC" 		,"SD1"	,"D1_CC"			," D1_DTDIGIT BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSN4
	// "Movimentacoes do Ativo Fixo"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N4_CONTA" 		,"SN4"	,"N4_CONTA"			," N4_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSBM
	// "Grupo de Produtos"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = BM_CC" 		,"SBM"	,"BM_CC"			," " })
Endif

If lcbSD3
	// "Movimento Interno"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = D3_CC" 		,"SD3"	,"D3_CC"			," D3_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSN5
	// "Arquivos de Saldos"
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N5_CONTA" 		,"SN5"	,"N5_CONTA"			," N5_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " }) 

Endif

If lcbSA1
	// "Cadastro de Clientes"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = DBL_CC" 		,"DBL"	,"DBL_CC"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CNB_CC" 		,"CNB"	,"CNB_CC"			," " })
Endif

// ALTAMIRO	20210329
aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = BGQ_CC" 		,"BGQ"	,"BGQ_CC"			," " })
//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = RT_CC" 		    ,"SRT"	,"RT_CC"			," RT_DATACAL BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' "  })
//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EZ_CCUSTO" 		,"SEZ"	,"EZ_CCUSTO"     	," " })

If lcbSC1
	// "Solicitacao de Compra"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = C1_CC" 		,"SC1"	,"C1_CC"			," C1_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSN6
	// "Saldos Por Conta e item"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = N6_CCUSTO" 		,"SN6"	,"N6_CCUSTO"			," N6_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSA2
	// "Cadastro de Fornecedores"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = A2_CONTA" 		,"SA2"	,"A2_CONTA"			," " })
Endif

If lcbSC7
	// "Pedidos de Compra"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = C7_CC" 		,"SC7"	,"C7_CC"			," C7_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbCV3
	// "Rastreamento Lancamento"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CV3_CCD" 		,"CV3"	,"CV3_CCD"			," CV3_DTSEQ BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CV3_CCC" 		,"CV3"	,"CV3_CCC"			," CV3_DTSEQ BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSA6
	// "CARDASTRO DE FUNCIONARIOS"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = RA_CC" 		,"SRA"	,"RA_CC"			," " })
	
Endif

If lcbCT3
	// "SALDO CENTRO DE CUSTO "
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = A6_CONTA" 		,"SA6"	,"A6_CONTA"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = A6_CONTABI" 		,"SA6"	,"A6_CONTABI"			," " })
Endif

If lcbSRZ
	// "Historico Pedidos de Compra"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = RZ_CC" 		,"SRZ"	,"RZ_CC"			,"  " })
Endif

If lcbCT2
	// "Movimento Contabil"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CT2_CCC" 		,"CT2"	,"CT2_CCC"	         		," CT2_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CT2_CCD" 		,"CT2"	,"CT2_CCD"		   	        ," CT2_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbBFQ
	// "Lan็. do Faturamento"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = BFQ_CONTA" 		,"BFQ"	,"BFQ_CONTA"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = BFQ_YCONT2" 		,"BFQ"	,"BFQ_YCONT2"			," " })
Endif

If lcbSCP
	// "SOLICITACOES AO ARMAZEM"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CP_CC" 		,"SCP"	,"CP_CC"			,"CP_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

// Discutir possibilidade de fazer manualmente
If lcbCT5
// "Lancamentos Padronizados"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CT5_CCD" 		,"CT5"	,"CT5_CCD"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CT5_CCC" 		,"CT5"	,"CT5_CCC"			," " })
Endif


If lcbBI3
	// "Produto Saude"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = BI3_CC" 		,"BI3"	,"BI3_CC"			," " })
Endif

If lcbSCQ
	// "PRE-REQUISICOES"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CQ_CC" 		,"SCQ"	,"CQ_CC"			,"CQ_DATPRF BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbCTK
	// "Arq. Contra Prova"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CTK_CCC" 		,"CTK"	,"CTK_CCC"			,"CTK_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CTK_CCD" 		,"CTK"	,"CTK_CCD"			,"CTK_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbCTS
	// "Visoes Gerenciais"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CTS_CTTFIM" 		,"CTS"	,"CTS_CTTFIM"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CTS_CTTINI" 		,"CTS"	,"CTS_CTTINI"			," " })
Endif

If lcbSET
	// "Cadastro de Caixinhas"
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ET_CONTA" 		,"SET"	,"ET_CONTA"			,"ET_DTCRIA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " }) ALTAMIRO 25/03/21
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ET_CCD" 		,"SET"	,"ET_CCD"			,"ET_DTCRIA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ET_CCC" 		,"SET"	,"ET_CCC"			,"ET_DTCRIA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbOUT
	
	
	// "SZT - CTB PLS - FATURAMENTO"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZT_CTADEB1" 		,"SZT"	,"ZT_CTADEB1"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZT_CANDEB1" 		,"SZT"	,"ZT_CANDEB1"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZT_CTADEB2" 		,"SZT"	,"ZT_CTADEB2"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZT_CANDEB2" 		,"SZT"	,"ZT_CANDEB2"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZT_CTACRD1" 		,"SZT"	,"ZT_CTACRD1"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZT_CANCRD1" 		,"SZT"	,"ZT_CANCRD1"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZT_CTACRD2" 		,"SZT"	,"ZT_CTACRD2"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZT_CANCRD2" 		,"SZT"	,"ZT_CANCRD2"			," " })
	
	// "SEZ - COMB DEBITOS/CREDITOS"
 //	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZV_CONTA" 		,"SZV"	,"ZV_CONTA"			," " })
 //	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZV_CONTA2" 		,"SZV"	,"ZV_CONTA2"			," " })
	
	//	PAREI AQUI--- FAZER RELATORIO DE INCONSISTENCIA DAS CONTAS COM A TABELA PB1. UTILIZAR MESMO VETOR PARA ISSO. CRIAR BOTAO PARA GERAR INCONSISTENCIA
	
	// "SZO - CTB PLS - CRD CUSTOS"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZO_CONTA" 		,"SZO"	,"ZO_CONTA"			," " })
	
	// "SZP - CTB PLS - LANCTOS DEB / CRD"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZP_CCRED" 		,"SZP"	,"ZP_CCRED"			," " })
	
	// "CTB PLS - DEB CUSTOS - CONTA"
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZQ_CONTA" 		,"SZQ"	,"ZQ_CONTA"			," " })//ALTAMIRO 25/03/21
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZQ_CCGLOSA" 		,"SZQ"	,"ZQ_CCGLOSA"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZQ_CCCOPAR" 		,"SZQ"	,"ZQ_CCCOPAR"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZQ_CCCOPDE" 		,"SZQ"	,"ZQ_CCCOPDE"			," " })


	// "Comissao Vendedores"
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E3_DEBITO" 		,"SE3"	,"E3_DEBITO"			,"E3_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E3_CREDIT" 		,"SE3"	,"E3_CREDIT"			,"E3_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Movimento Bancario"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E5_DEBITO" 		,"SE5"	,"E5_DEBITO"			,"E5_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E5_CREDITO" 		,"SE5"	,"E5_CREDITO"			,"E5_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Servicos"
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = BBB_CONTA" 		,"BBB"	,"BBB_CONTA"			," " })
	
	// "Orcamentos"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E7_DEBITO" 		,"SE7"	,"E7_DEBITO"			," " })
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = E7_CREDIT" 		,"SE7"	,"E7_CREDIT"			," " })
	
	// "Titulos Enviados ao Banco"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EA_CCD" 		,"SEA"	,"EA_CCD"			,"EA_DATABOR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EA_CCC" 		,"SEA"	,"EA_CCC"			,"EA_DATABOR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Cadastro de Cheques"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EF_CCC" 		,"SEF"	,"EH_CCC"			,"EF_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EF_CCD" 		,"SEF"	,"EF_CCD"			,"EF_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Controle de Aplicacao/Emprestimo"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EH_CCD" 		,"SEH"	,"EH_CCD"			,"EH_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = EH_CCC" 		,"SEH"	,"EH_CCC"			,"EH_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Itens NF Saida"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = D2_CONTA" 		,"SD2"	,"D2_CONTA"			,"D2_DTDIGIT BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Livros Fiscais"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = F3_CONTA" 		,"SF3"	,"F3_CONTA"			,"F3_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Livro Fiscal P/Item NF"
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = FT_CONTA" 		,"SFT"	,"FT_CONTA"			,"FT_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "SALDOS POR CTA, ITEM E CL VLR"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = NA_CONTA" 		,"SNA"	,"NA_CONTA"			,"NA_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "SALDOS POR CONTA E C. CUSTO"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = NC_CCUSTO" 		,"SNC"	,"NC_CCUSTO"			,"NC_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Saldo Item Contabil"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CT4_CONTA" 		,"CT4"	,"CT4_CONTA"			,"CT4_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Deb/Cre p/ Cobran็a"
	//aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = BSP_CONTA" 		,"BSP"	,"BSP_CONTA"			," " })
	
	// "Grp/Empresa x Contr. x Prod."
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = BT6_CC" 		,"BT6"	,"BT6_CC"			," " })
	
	// "Rateio On Line"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CT9_CCD" 		,"CT9"	,"CT9_CCD"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CT9_CCC" 		,"CT9"	,"CT9_CCC"			," " })
	
	// "Rateio Off Line"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CTQ_CCCPAR" 		,"CTQ"	,"CTQ_CCCPAR"			," " })
	
	// "Criterios de Rateio"
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CTJ_CCD" 		,"CTJ"	,"CTJ_CCD"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = CTJ_CCC" 		,"CTJ"	,"CTJ_CCC"			," " })

	
Endif

If lcbZUI
	// "Combina็๕es Contabeis Custo / Receita "
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_CTACLI" 		,"ZUI"	,"ZUI_CTACLI"			," " })
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_CTAREC" 		,"ZUI"	,"ZUI_CTAREC"			," " })   
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_RECCAN" 		,"ZUI"	,"ZUI_RECCAN"			," " })
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_CTADEB" 		,"ZUI"	,"ZUI_CTADEB"			," " })
//	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_CTACRE" 		,"ZUI"	,"ZUI_CTACRE"			," " })   
	
Endif


oProcess := MsNewProcess():New({|lEnd| FazDePara(lEnd,oProcess)},"Processando","Lendo...",.T.)
oProcess:Activate()

MsgInfo("Fim da atualiza็ใo da Conta Contแbil","Aten็ใo")

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบFuncao    ณ FazDePara  บ Autor ณ Rafael Lima        บ Data ณ  21/07/09 บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Processar a Troca das Contas Contabeis                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function FazDePara(lEnd,oObj)

Local I := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

// Primeira Regua - Contas Contabeis
oObj:SetRegua1(Len(aDePara))

For I:=1 TO LEN(aDePara)
	
	
	oObj:IncRegua1("Atualizando Tabela: "+aDePara[I,5])
	
	
	cxAlias := aDePara[I,5]
	If Substr(cxAlias,1,1) = "S"
		cxAlias := Substr(cxAlias,2,2)
	Endif
	
	//Rodar select para verificar se existe registros relacinados.
	If aDePara[I,5] == "SET"
		cQuery :=" SELECT DISTINCT PB1.*"
		cQuery +=" FROM " + RetSQLName(aDePara[I,1]) + " " + aDePara[I,1] + " , " + RetSQLName(aDePara[I,5]) + " SEZ"
		cQuery += " WHERE " + aDePara[I,1] + ".D_E_L_E_T_ = ' ' AND " + "SEZ.D_E_L_E_T_ = ' ' "
	Else
		cQuery :=" SELECT DISTINCT PB1.*"
		cQuery +=" FROM " + RetSQLName(aDePara[I,1]) + " " + aDePara[I,1] + " , " + RetSQLName(aDePara[I,5]) + " " + aDePara[I,5]
		cQuery += " WHERE " + aDePara[I,1] + ".D_E_L_E_T_ = ' ' AND " + aDePara[I,5] + ".D_E_L_E_T_ = ' ' "	
	EndIf	
	
	cQuery += " AND " + aDePara[I,3] + " = '" + xFilial(aDePara[I,1]) + "' "
	cQuery += " AND " + cxAlias + "_FILIAL = '" + xFilial(aDePara[I,5]) + "' "
	cQuery += " AND " + aDePara[I,4]
	cQuery += " AND " +aDePara[I,2] + " <> ' ' "	
	If !Empty(aDePara[I,7])
		cQuery += " AND " + aDePara[I,7]
	Endif
	
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), "TRBIT", .F., .T.)
	
	TRBIT->(DbGotop())
	
	Do While TRBIT->(!EOF())

		cAtlzCpo := " UPDATE " + RetSQLName(aDePara[I,5])
		cAtlzCpo += " SET " + aDePara[I,6] + " = '"+ AllTrim(&("TRBIT->"+aDePara[I,2]))+"' "
		cAtlzCpo += " WHERE "+ cxAlias + "_FILIAL = '" + xFilial(aDePara[I,5]) + "' "
		cAtlzCpo += " AND D_E_L_E_T_ = ' ' "
		cAtlzCpo += " AND "+ Substr(aDePara[I,4],13) +" = '" + AllTrim(TRBIT->PB1_CTVELH) +"' "
	

		If !Empty(aDePara[I,7])
			cAtlzCpo += " AND " + aDePara[I,7]
		Endif
		If TCSQLExec(cAtlzCpo) < 0
			Alert("Falha na conversใo dos c๓digos da tabela " + aDePara[I,5] + Chr(10)+Chr(13) + TCSQLError())
		Endif
		
		TRBIT->(DbSkip())
	EndDo
	TRBIT->(DbCloseArea())
Next
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบFuncao    ณRetiraPontosบ Autor ณ Rafael Lima        บ Data ณ  21/07/09 บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Remover Pontuacao das Contas do Arquivo De/Para Caso haja  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Retorna a Conta Sem a Pontuacao da Picture                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function RetiraPontos(_cConta)

fAtu    := .T.
_cCpo   := ""

Do While fAtu
	_nPos := AT(".", _cConta)
	If _nPos > 0
		_cConta := Stuff(_cConta,_nPos,1,_cCpo)
	Else
		fAtu := .F.
	Endif
Enddo
Return(_cConta)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณValidPerg บ Autor ณ Rafael Lima        บ Data ณ  21/07/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Parametros da Rotina                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

Aadd(aRegs,{cPerg,"01","Data de:        ","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Data at้:       ","","","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next
                      

RestArea( aAreaAtu )

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณ   C()   ณ Autores ณ Norbert/Ernani/Mansano ณ Data ณ10/05/2005ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณ Funcao responsavel por manter o Layout independente da       ณฑฑ
ฑฑณ           ณ resolucao horizontal do Monitor do Usuario.                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function C(nTam)
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor
If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)
	nTam *= 0.8
ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600
	nTam *= 1
Else	// Resolucao 1024x768 e acima
	nTam *= 1.28
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTratamento para tema "Flat"ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If "MP8" $ oApp:cVersion
	If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()
		nTam *= 0.90
	EndIf
EndIf
Return Int(nTam)

Static Function Diver(lEnd,oObj)

Local v := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS 

Local aDiverg  := {}
Local cArqtmp	:= GetNextAlias()
Local cQuery
Local aDados	:= {}
Local aCabec	:= {"Mensagem","Conta","Campo na Tabela"}

If lcbSED
	// "Cadastro de Naturezas"
//	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ED_CONTAB" 		,"SED"	,"ED_CONTAB"			," "}) ALTAMIRO 25/03/21
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ED_CCC" 		,"SED"	,"ED_CCC"			," "})
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ED_CCD" 		,"SED"	,"ED_CCD"			," "})
Endif

If lcbSE1
	
	// "Contas a Receber"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E1_CCD" 		,"SE1"	,"E1_CCD"			," E1_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E1_CCC" 		,"SE1"	,"E1_CCC"			," E1_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif
If lcbSEU
	// "Movimento do Caixinha"
//	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = EU_CONTA" 		,"SEU"	,"EU_CONTA"			," EU_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " }) ALTAMIRO 25/03/21
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = EU_CCD" 		,"SEU"	,"EU_CCD"			," EU_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = EU_CCC" 		,"SEU"	,"EU_CCC"			," EU_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSNG
	// "Cadastro de Grupo de Bens"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = NG_CUSTBEM" 		,"SNG"	,"NG_CUSTBEM"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = NG_CCDESP" 		,"SNG"	,"NG_CCDESP"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = NG_CCCDEP" 		,"SNG"	,"NG_CCCDEP"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = NG_CCCDES" 		,"SNG"	,"NG_CCCDES"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = NG_CCCORR" 		,"SNG"	,"NG_CCCORR"			," " })
Endif


If lcbSE2
	// "Contas a Pagar"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E2_CONTAD" 		,"SE2"	,"E2_CONTAD"			," E2_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E2_DEBITO" 		,"SE2"	,"E2_DEBITO"			," E2_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E2_CREDIT" 		,"SE2"	,"E2_CREDIT"			," E2_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSN3
	// "Cadastro de Saldos e Valores"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = N3_CUSTBEM" 		,"SN3"	,"N3_CUSTBEM"			," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = N3_CCUSTO"   		,"SN3"	,"N3_CCUSTO"			," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = N3_CCDESP" 	    	,"SN3"	,"N3_CCDESP"			," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
//	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = N3_CDESP" 	    	,"SN3"	,"N3_CDESP"			," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " }) ALTAMIRO 25/03/21
//	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = N3_CCORREC" 		,"SN3"	,"N3_CCORREC"			," N3_DINDEPR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " }) ALTAMIRO 25/03/21
Endif

If lcbSB1
	// "Cadastro de Produtos"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = B1_CC" 		,"SB1"	,"B1_CC"			," " })
//	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = B1_CONTAE" 		,"SB1"	,"B1_CONTAE"			," " }) ALTAMIRO 25/03/21
Endif

If lcbSD1
	// "Itens NF Entrada"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = D1_CC" 		,"SD1"	,"D1_CC"			," D1_DTDIGIT BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSN4
	// "Movimentacoes do Ativo Fixo"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = N4_CCUSTO" 		,"SN4"	,"N4_CCUSTO"			," N4_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = N4_CCUSTOT" 	,"SN4"	,"N4_CCUSTOT"			," N4_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })   //ALTAMIRO 25/03/21

Endif

If lcbSBM   
	// "Grupo de Produtos"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = BM_CC" 		,"SBM"	,"BM_CC"			," " })
Endif

If lcbSD3
	// "Movimento Interno"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = D3_CC" 		,"SD3"	,"D3_CC"			," D3_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSN5
	// "Arquivos de Saldos"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = N5_CONTA" 		,"SN5"	,"N5_CONTA"			," N5_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSA1
	// "Cadastro de Clientes"
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = A1_CONTA" 		,"SA1"	,"A1_CONTA"			," " })
Endif

If lcbSC1
	// "Solicitacao de Compra"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = C1_CC" 		,"SC1"	,"C1_CC"			," C1_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSN6
	// "Saldos Por Conta e item"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = N6_CCUSTO" 		,"SN6"	,"N6_CCUSTO"			," N6_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSA2
	// "Cadastro de Fornecedores"
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = A2_CONTA" 		,"SA2"	,"A2_CONTA"			," " })
Endif

If lcbSC7
	// "Pedidos de Compra"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = C7_CC" 		,"SC7"	,"C7_CC"			," C7_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbCV3
	// "Rastreamento Lancamento"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CV3_CCD" 		,"CV3"	,"CV3_CCD"			," CV3_DTSEQ BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CV3_CCC" 		,"CV3"	,"CV3_CCC"			," CV3_DTSEQ BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbSA6_Alta326092
	// "CADASTRO  DE FUNCIONARIOS "
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = RA_CC" 		,"SRA"	,"RA_CC"			," " })
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = A6_CONTABI" 		,"SA6"	,"A6_CONTABI"			," " })
Endif

//If lcbSRZ
	// "Historico Pedidos de Compra"
//	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CY_CONTA" 		,"SCY"	,"CY_CONTA"			," CY_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
aadd(aDiverg,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = RZ_CC" 		,"SRZ"	,"RZ_CC"			,"  " })
//Endif

If lcbCT2   
	// "Movimento Contabil"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CT2_CCC" 		,"CT2"	,"CT2_CCC"			," CT2_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CT2_CCD" 		,"CT2"	,"CT2_CCD"			," CT2_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbBFQ
	// "Lan็. do Faturamento"
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = BFQ_CONTA" 		,"BFQ"	,"BFQ_CONTA"			," " })
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = BFQ_YCONT2" 		,"BFQ"	,"BFQ_YCONT2"			," " })
Endif

If lcbSCP
	// "SOLICITACOES AO ARMAZEM"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CP_CC" 		,"SCP"	,"CP_CC"			,"CP_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

// Discutir possibilidade de fazer manualmente
If lcbCT5
// "Lancamentos Padronizados"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CT5_CCD" 		,"CT5"	,"CT5_CCD"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CT5_CCC" 		,"CT5"	,"CT5_CCD"			," " })
Endif

If lcbBI3
	// "Produto Saude"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = BI3_CC" 		,"BI3"	,"BI3_CC"			," " })
Endif

If lcbSCQ
	// "PRE-REQUISICOES"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CQ_CC" 		,"SCQ"	,"CQ_CC"			,"CQ_DATPRF BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbCTK
	// "Arq. Contra Prova"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CTK_CCC" 		    ,"CTK"	,"CTK_CCC"			,"CTK_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CTK_CCD" 		    ,"CTK"	,"CTK_CCD"			,"CTK_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif

If lcbCTS
	// "Visoes Gerenciais"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CTS_CTTFIM" 		,"CTS"	,"CTS_CTTFIM"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CTS_CTTINI" 		,"CTS"	,"CTS_CTTINI"			," " })
Endif

If lcbSET
	// "Cadastro de Caixinhas"
//	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ET_CONTA" 		,"SET"	,"ET_CONTA"		    	,"ET_DTCRIA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " }) ALTAMIRO	25/03/21
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ET_CCD" 		,"SET"	,"ET_CCD"			,"ET_DTCRIA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ET_CCC" 		,"SET"	,"ET_CCC"			,"ET_DTCRIA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
Endif         

If lcbOUT
	
	
	// "SZT - CTB PLS - FATURAMENTO"
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZT_CTADEB1" 		,"SZT"	,"ZT_CTADEB1"			," " })
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZT_CANDEB1" 		,"SZT"	,"ZT_CANDEB1"			," " })
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZT_CTADEB2" 		,"SZT"	,"ZT_CTADEB2"			," " })
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZT_CANDEB2" 		,"SZT"	,"ZT_CANDEB2"			," " })
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZT_CTACRD1" 		,"SZT"	,"ZT_CTACRD1"			," " })
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZT_CANCRD1" 		,"SZT"	,"ZT_CANCRD1"			," " })
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZT_CTACRD2" 		,"SZT"	,"ZT_CTACRD2"			," " })
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZT_CANCRD2" 		,"SZT"	,"ZT_CANCRD2"			," " })
	
	// "SZV - COMB DEBITOS/CREDITOS"
    //	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZV_CONTA" 		,"SZV"	,"ZV_CONTA"			," " })
    //	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZV_CONTA2" 		,"SZV"	,"ZV_CONTA2"			," " })
	
	//	PAREI AQUI--- FAZER RELATORIO DE INCONSISTENCIA DAS CONTAS COM A TABELA PB1. UTILIZAR MESMO VETOR PARA ISSO. CRIAR BOTAO PARA GERAR INCONSISTENCIA
	
	// "SZO - CTB PLS - CRD CUSTOS"
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZO_CONTA" 		,"SZO"	,"ZO_CONTA"			," " })
	
	// "SZP - CTB PLS - LANCTOS DEB / CRD"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZP_CCRED" 		,"SZP"	,"ZP_CCRED"			," " })
	
	// "CTB PLS - DEB CUSTOS - CONTA"
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZQ_CONTA" 		,"SZQ"	,"ZQ_CONTA"			," " })
    //	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZQ_CCGLOSA" 		,"SZQ"	,"ZQ_CCGLOSA"			," " })
    //	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZQ_CCCOPAR" 		,"SZQ"	,"ZQ_CCCOPAR"			," " })
	//  aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = ZQ_CCCOPDE" 		,"SZQ"	,"ZQ_CCCOPDE"			," " })
	
	// "Comissao Vendedores"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E3_DEBITO" 		,"SE3"	,"E3_DEBITO"			,"E3_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E3_CREDIT" 		,"SE3"	,"E3_CREDIT"			,"E3_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Movimento Bancario"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E5_DEBITO" 		,"SE5"	,"E5_DEBITO"			,"E5_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E5_CREDITO" 		,"SE5"	,"E5_CREDITO"			,"E5_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Servicos"
	//aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = BBB_CONTA" 		,"BBB"	,"BBB_CONTA"			," " })
	
	// "Orcamentos"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E7_DEBITO" 		,"SE7"	,"E7_DEBITO"			,"E7_ANO = '"+Substr(DtoS(mv_par01),1,4)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = E7_CREDIT" 		,"SE7"	,"E7_CREDIT"			,"E7_ANO = '"+Substr(DtoS(mv_par01),1,4)+"' " })
	
	// "Titulos Enviados ao Banco"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = EA_DEBITO" 		,"SEA"	,"EA_DEBITO"			,"EA_DATABOR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = EA_CREDIT" 		,"SEA"	,"EA_CREDIT"			,"EA_DATABOR BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Cadastro de Cheques"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = EF_DEBITO" 		,"SEF"	,"EF_DEBITO"			,"EF_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = EF_CREDIT" 		,"SEF"	,"EF_CREDIT"			,"EF_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Controle de Aplicacao/Emprestimo"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = EH_DEBITO" 		,"SEH"	,"EH_DEBITO"			,"EH_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = EH_CREDIT" 		,"SEH"	,"EH_CREDIT"			,"EH_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Itens NF Saida"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = D2_CONTA" 		,"SD2"	,"D2_CONTA"			,"D2_DTDIGIT BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Livros Fiscais"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = F3_CONTA" 		,"SF3"	,"F3_CONTA"			,"F3_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Livro Fiscal P/Item NF"
//	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = FT_CONTA" 		,"SFT"	,"FT_CONTA"			,"FT_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "SALDOS POR CTA, ITEM E CL VLR"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = NA_CONTA" 		,"SNA"	,"NA_CONTA"			,"NA_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "SALDOS POR CONTA E C. CUSTO"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = NC_CONTA" 		,"SNC"	,"NC_CONTA"			,"NC_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Saldo Item Contabil"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CT4_CONTA" 		,"CT4"	,"CT4_CONTA"			,"CT4_DATA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' " })
	
	// "Deb/Cre p/ Cobran็a"
//	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = BSP_CONTA" 		,"BSP"	,"BSP_CONTA"			," " })
	
	// "Grp/Empresa x Contr. x Prod."
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = BT6_CONTA" 		,"BT6"	,"BT6_CONTA"			," " })
	
	// "Rateio On Line"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CT9_CCD" 		,"CT9"	,"CT9_CCD"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CT9_CCC" 		,"CT9"	,"CT9_CCC"			," " })
	
	// "Rateio Off Line"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CTQ_CTORI" 		,"CTQ"	,"CTQ_CTORI"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CTQ_CTPAR" 		,"CTQ"	,"CTQ_CTPAR"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CTQ_CTCPAR" 	,"CTQ"	,"CTQ_CTCPAR"			," " })
	
	// "Criterios de Rateio"
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CTJ_CCD" 	,"CTJ"	,"CTJ_CCD"			," " })
	aadd(aDiverg,{"PB1","PB1_CTVELH","PB1_FILIAL","PB1_CTVELH = CTJ_CCC" 	,"CTJ"	,"CTJ_CCC"			," " })
	
Endif

If lcbZUI
	// "Combina็๕es Contabeis Custo / Receita "
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_CTACLI" 	,"ZUI"	,"ZUI_CTACLI"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_CTAREC" 	,"ZUI"	,"ZUI_CTAREC"			," " })   
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_RECCAN" 	,"ZUI"	,"ZUI_RECCAN"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_CTADEB" 	,"ZUI"	,"ZUI_CTADEB"			," " })
	aadd(aDePara,{"PB1","PB1_CTNOVA","PB1_FILIAL","PB1_CTVELH = ZUI_CTACRE" 	,"ZUI"	,"ZUI_CTACRE"			," " })   
	
Endif

For v:=1 To Len(aDiverg)
	
	cxAlias := aDiverg[v,5]
	If Substr(cxAlias,1,1) = "S"
		cxAlias := Substr(cxAlias,2,2)
	Endif
	
	cQuery := " SELECT 'TABELA "+aDiverg[v,5]+"' MENSAGEM, "+aDiverg[v,6]+" CONTA,'"+aDiverg[v,6]+"' CAMPO "
	cQuery += " FROM "+ RetSqlName(aDiverg[v,5])+" "+ Iif(aDiverg[v,5]=='SET','ET',aDiverg[v,5])
	cQuery += " WHERE "+Iif(aDiverg[v,5]=='SET','ET',aDiverg[v,5])+"."+aDiverg[v,6]+" NOT IN (SELECT PB1_CTVELH FROM "+RetSqlName(aDiverg[v,1])+" "+ aDiverg[v,1]
	cQuery += " WHERE "+aDiverg[v,3]+" = '"+xFilial(aDiverg[v,1])+"' AND "+ aDiverg[v,1]+".D_E_L_E_T_ = ' ' ) "
	cQuery += " AND "+Iif(aDiverg[v,5]=='SET','ET',aDiverg[v,5])+".D_E_L_E_T_ = ' ' "
	cQuery += " AND "+cxAlias+"_FILIAL = '"+xFilial(aDiverg[v,5])+"' "
	cQuery += " AND "+aDiverg[v,6]+" <> ' ' "
	If ! Empty(aDiverg[v,7])
		cQuery += " AND "+aDiverg[v,7]
	EndIf	
	cQuery += " GROUP BY "+aDiverg[v,6]
	
	*--------------------------------------*
	* Verifica se o alias esta em uso
	*--------------------------------------*
	If Select(cArqtmp) > 0
		dbSelectArea( cArqtmp )
		dbCloseArea()
	EndIf
	
	*--------------------------------------------*
	* Cria o alias executando a query
	*--------------------------------------------*
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqtmp , .F., .T.)
	oObj:SetRegua1((cArqTmp)->(RecCount()))

	Do While (cArqtmp)->(!EOF())
		SX2->(DbSetOrder(1))
		SX2->(DbSeek(aDiverg[v,5]))

		oObj:IncRegua1("Gravando conta: "+(cArqTmp)->CONTA)
//		If Ascan(aDados,{|x|Alltrim(x[2])==Alltrim((cArqtmp)->CONTA)}) == 0
		Aadd(aDados,{StrTran((cArqtmp)->MENSAGEM,aDiverg[v,5],aDiverg[v,5]+"-"+TRIM(SX2->X2_NOME)),(cArqtmp)->CONTA,(cArqtmp)->CAMPO})
//		EndIf	
		(cArqtmp)->(DbSkip())
	EndDo
Next

DlgToExcel({{"ARRAY","Inconsist๊ncias" ,aCabec,aDados}})
If Select(cArqTmp) > 0
	dbSelectArea(cArqtmp)
	dbCloseArea()
endIf	
Return
