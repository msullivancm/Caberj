//#INCLUDE "plsa940.ch"
#include "PLSMGER.CH"
#include "topconn.CH"
#include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL365BOT1 ºAutor  ³Desconhecido        º Data ³  03/19/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para inclusão de botões na tela de rede de º±±
±±º          ³atendimento.                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlteracoes³Leonardo Portella (10/05/11) - Alteracoes para adaptacao da º±±
±±º          ³rotina conforme o ponto de entrada apos o patch SCZWB4 que  º±±
±±º          ³permite que mais de um botao no enchoice.                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  

User Function PL365BOT1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Variaveis padroes do porto de entrada³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³PL365BOT1 - Inclusão de botões na tela rede de atendimento. ( [ nOpc ], [ cCodigo ], [ cCodLoc ], [ cCodEsp ] ) --> aButtons³
//³nOpc - Número da opção                                                                                                      ³
//³cCodigo - Código da rede de atendimento                                                                                     ³
//³cCodLoc - Código do local.                                                                                                  ³
//³cCodEsp - Código da especialidade.                                                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local aRet    	:= {}

Local nOpc    	:= paramixb[1]//paramixb[5]
Local cCodRda 	:= paramixb[2]
Local cCodLoc 	:= paramixb[3]
Local cCodEsp 	:= paramixb[4]

//1- Tipo do botão
//2- Bloco de codigo da Função a ser executada
//3- Descrição da botão
//4- Nome do Botão

aAdd(aRet,{"HISTORIC"	,{||Processa({||RDAxPlano(cCodRda)})	},"RDA x Plano","RDA x Pl."}) 
//aAdd(aRet,{"SDURECALL"	,{||alert('PL365BOT1')     				},"Vinculação RDA x Local x Itens divulgação x Grupo Especialidade","Vinculação"}) 

Return aRet
           
********************************************************************************************************************************

Static Function RDAxPlano(cCodRda)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aPlanos 	:= {}
Local aAreaBAU	:= BAU->(GetArea())
Local cCodOpe 	:= PLSINTPAD()

ProcRegua(0)

For nI := 1 to 5
    IncProc('Processando...')
Next                       

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ nOpc = "1" - Retorna a montagem do botao                            ³
//³ Array de Retorno: [1] - .T.                                         ³
//³                   [2] - Imagem do botao                             ³
//³                   [3] - Titulo do botao                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If nOpc == 1 //cOpe == "1"
	
    /*
	Aadd(aRet,.T.)
	Aadd(aRet,"HISTORIC") //Imagem
	Aadd(aRet,"RDA x Plano")   //Titulo

	Return(aRet)
    */
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ cOpe = "2" - Chama a funcao que monta a tela                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
//ElseIf nOpc == 2 //cOpe == "2"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Observacao importante:                                               |
	//³Conforme solicitado pelo setor de crecendicamento:                   |
	//³Maria Claudia, Leandro, Dr. Vitoria                                  |
	//³Esta pesquisa nao considera Local de Atendimento x Especialidade     |
	//³x Rede de Atendimento, mostranto assim os planos da RDA, no geral    |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cQuery := " SELECT BI3_CODIGO CODIGO, BI3_VERSAO VERSAO,BI3_NREDUZ PRODUTO,BI3_CODACO CODACO "
	cQuery += "  FROM "+RetSqlName("BI3")+" BI3 "
	cQuery += "  WHERE BI3_FILIAL = '"+xFilial("BI3")+"' "
	cQuery += "   AND BI3_CODINT = '"+cCodOpe+"' "
	cQuery += "   AND BI3_GRUPO = '001'"
	cQuery += "   AND BI3_STATUS = '1'"
	cQuery += "   AND BI3.D_E_L_E_T_ = ' ' "
	cQuery += "   ORDER BY BI3_CODIGO "
	
	cQuery := ChangeQuery(cQuery)
	
	TCQuery cQuery Alias "TRBPLA" New
	
	While !TRBPLA->(Eof())
		
		cQuery := " SELECT BA1.R_E_C_N_O_ RECUSR "
		cQuery += " FROM "+RetSqlName("BA1")+" BA1 "
		cQuery += " WHERE BA1.BA1_FILIAL = '"+xFilial("BA1")+"' "
		cQuery += " AND BA1.BA1_CODINT = '"+cCodOpe+"' "
		cQuery += " AND BA1.BA1_DATBLO = ' ' "
		cQuery += " AND BA1.BA1_CODPLA = '"+TRBPLA->CODIGO+"' "
		cQuery += " AND BA1.BA1_VERSAO = '"+TRBPLA->VERSAO+"' "
		cQuery += " AND BA1.D_E_L_E_T_ = ' ' "
		cQuery += " AND ROWNUM < 2 "
		
		cQuery := ChangeQuery(cQuery)
		
		TCQuery cQuery Alias "TRBUSR" New
		
		WHILE !TRBUSR->(EOF())
			//BA1->(DbSetorder(1))
			//BA1->(dbSeek(xFilial("BA1")+TRBUSR->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC+"00")))
			//Rotina padrao para validar RDA
			BA1->(DbGoto(TRBUSR->RECUSR))
			aRet:= PLSVLDRDA("1",nil,nil,nil,nil)
			If aRet[1]
				aAdd(aPlanos,{TRBPLA->CODIGO,;
				TRBPLA->VERSAO,;
				TRBPLA->PRODUTO,;
				TRBPLA->CODACO,;
				Posicione("BI4",1,xFilial("BI4")+TRBPLA->CODACO,"BI4_DESCRI")})
				
			EndIf
			TRBUSR->(DbSkip())
		EndDo
		
		TRBUSR->(dbCloseArea())
		
		TRBPLA->(DbSkip())
	EndDo
	TRBPLA->(DbCloseArea())
	
	Plscrigen(aPlanos,{{"Codigo ","@C","7"},;
	{"Versão ","@!","7"},;
	{"Plano","@!","20"},;
	{"Cod.Rede","@!","8"},;
	{"Descri. Rede","@!","30"}},;
	"Planos x RDA - "+cCodRda+"-"+M->BAU_NOME,.T.,"Planos atendidos por esta RDA")
	
//EndIf
/*
romulo//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ cOpe = "3" - Grava Dados                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf cOpe == "3"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ cOpe = "4" - cancela dados                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ElseIf cOpe == "4"
*/

BAU->(RestArea(aAreaBAU))

Return
