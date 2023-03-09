#include 'protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBPLS06  ºAutor  ³Roger Cangianeli    º Data ³  05/04/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o tipo de faturamento para definir se o lancamento  º±±
±±º          ³padronizado deve ou nao ser executado para este registro    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlteracoes³31.08.06 - Incluido controle para contabilizar titulos que  º±±
±±º          ³ja foram excluidos do sistema, verificando se encontra os   º±±
±±º          ³registros no arquivo BMN. RC.                               º±±
±±º          ³ 															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Unimeds                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CTBPLS06(lLogUsu, cTipLct)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa Parametros:                                            ³
//³MV_YCTPL13 --> Conta para contabilizar Tx.Adm. em conta unica     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cCtpl13	:= GetNewPar('MV_YCTPL13','3311810100001')
Local cRet, aArea, aAreaBA1, aAreaBA3, cString

Private cCodPla := Space(4)

Default lLogUsu	:= .F.		// Habilita ou desabilita gravacao do Log para usuarios nao encontrados
Default cTipLct	:= 'I'		// Tipo do Lançamento: I-Inclusão / C-Cancelamento / B-Baixa / P-Provisão (para títulos excluídos antes de contabilizar)

aArea	:= GetArea()
aAreaBA1:= BA1->(GetArea())
aAreaBA3:= BA3->(GetArea())
aAreaSE1:= SE1->(GetArea())
aAreaBM1:= BM1->(GetArea())
aAreaBMN:= BMN->(GetArea())		// RC - 31/08/06

// Define qual arquivo irá tratar
If cTipLct $ 'I/B'
	cAlias	:= 'BM1'
Else
	cAlias	:= 'BMN'
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inserida verificacao de posicionamento devido alteracao no padrao.³
//³Roger Cangianeli - 02/08/06                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO) # &(cAlias+'->('+cAlias+'_PREFIX+'+cAlias+'_NUMTIT+'+cAlias+'_PARCEL+'+cAlias+'_TIPTIT)')
	
	&(cAlias+'->(dbSetOrder(4))')
	//		SE1->(dbSetOrder(1))
	If ! &( cAlias+'->(dbSeek(xFilial("'+cAlias+'")+SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO),.F.))')
		If lLogUsu
			cProc	:= 'Lt.Cobr:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_PLNUCO'),5,8))+'|Seq:'+AllTrim(&(cAlias+'->'+cAlias+'_SEQ'))+'|Tit:'+AllTrim(&(cAlias+'->'+cAlias+'_NUMTIT'))
			cProc	+= '|Matr:'+AllTrim(&(cAlias+'->('+cAlias+'_CODINT+'+cAlias+'_CODEMP+'+cAlias+'_MATRIC+'+cAlias+'_TIPREG+'+cAlias+'_DIGITO)') )+'|Nome:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_NOMUSR'),1,20))
			cProc	+= '|Prod: N/Enc. |Grp.Emp:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEMP'))
			cProc	+= '|Contr:'+AllTrim(BA1->BA1_CONEMP)+'/'+AllTrim(BA1->BA1_VERCON)+'|Sub:'+AllTrim(BA1->BA1_SUBCON)+'/'+AllTrim(BA1->BA1_VERSUB)
			cProc	+= '|Tp.Fat:'+AllTrim(&(cAlias+'->'+cAlias+'_CODTIP'))+'|Evto:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEVE'))
			cProc	+= '|Vl.Evto:|'+StrZero(&(cAlias+'->'+cAlias+'_VALOR'),9,2)+'|Vl.Tit.:|'+'0'
			cProc	+= '|Titulo nao Encontrado|CTBPLS06/'+CT5->(CT5_LANPAD+'-'+CT5_SEQUEN)+'/'+cAlias
			U_Gravalog(cProc,'FAT')
			cRet	:=  'X'
		EndIf
	EndIf
	
	// Inserida condicao em 05/08/06 para retornar somente em erro, pois retornava em desposicionamento. By RC.
	If cRet == 'X'
		BMN->(RestArea(aAreaBMN))
		BM1->(RestArea(aAreaBM1))
		SE1->(RestArea(aAreaSE1))
		BA3->(RestArea(aAreaBA3))
		BA1->(RestArea(aAreaBA1))
		RestArea(aArea)
		Return(cRet)
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inserida validacao do posicionamento do usuario e tentativa de localizacao³
//³pelo codigo antigo deste.                                                 ³
//³Roger Cangianeli - 24/05/06                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Verifica se o programa nao achou o usuario ou se parou em usuario diferente, para procurar pelo codigo antigo.
If BA1->(Eof()) .or. BA3->(Eof())
	lAchouBA1 := .F.
	dbSelectArea('BA1')
	BA1->(dbSetOrder(2))
	If BA1->(dbSeek(xFilial('BA1')+AllTrim(&(cAlias+'->('+cAlias+'_CODINT+'+cAlias+'_CODEMP+'+cAlias+'_MATRIC+'+cAlias+'_TIPREG+'+cAlias+'_DIGITO)') ),.F.))
		lAchouBA1:= .T.
	Else
		If BA1->(dbSeek(xFilial('BA1')+&(cAlias+'->'+cAlias+'_MATUSU'), .F.))
			lAchouBA1:= .T.
		Else
			dbSelectArea('BA1')
			BA1->(dbSetOrder(5))
			If dbSeek(xFilial('BA1')+&(cAlias+'->'+cAlias+'_MATUSU'), .F.)
				lAchouBA1:= .T.
			EndIf
		EndIf
	EndIf
	
	If lAchouBA1
		dbSelectArea('BA3')
		BA3->(dbSetOrder(1))
		BA3->(dbSeek(xFilial('BA3')+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),.F.))
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Grava em memoria a composicao da cobranca.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cProc	:= 'Lt.Cobr:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_PLNUCO'),5,8))+'|Seq:'+AllTrim(&(cAlias+'->'+cAlias+'_SEQ'))+'|Tit:'+AllTrim(&(cAlias+'->'+cAlias+'_NUMTIT'))
		cProc	+= '|Matr:'+AllTrim(&(cAlias+'->('+cAlias+'_CODINT+'+cAlias+'_CODEMP+'+cAlias+'_MATRIC+'+cAlias+'_TIPREG+'+cAlias+'_DIGITO)') )+'|Nome:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_NOMUSR'),1,20))
		cProc	+= '|Prod: N/Enc. |Grp.Emp:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEMP'))
		cProc	+= '|Contr:'+AllTrim(BA1->BA1_CONEMP)+'/'+AllTrim(BA1->BA1_VERCON)+'|Sub:'+AllTrim(BA1->BA1_SUBCON)+'/'+AllTrim(BA1->BA1_VERSUB)
		cProc	+= '|Tp.Fat:'+AllTrim(&(cAlias+'->'+cAlias+'_CODTIP'))+'|Evto:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEVE'))
		cProc	+= '|Vl.Evto:|'+StrZero(&(cAlias+'->'+cAlias+'_VALOR'),9,2)+'|Vl.Tit.:|'+'0'
		cProc	+= '|Usuario nao encontrado|CTBPLS06'
		cRet	:= 'X'
		
		// Grava log de registro com problema quando for primeira sequencia e ativado na chamada do CT5
		If lLogUsu .and. CT5->CT5_LANPAD == 'P01' //.and. AllTrim(BM1->BM1_SEQ) == '001' - Desabilitado em 04/08/06 By RC.
			//	alterado em 02/08/06		If lLogUsu .and. AllTrim(BM1->BM1_SEQ) == '001'
			U_Gravalog(cProc,'FAT')
		EndIf
		
		BA3->(RestArea(aAreaBA3))
		BA1->(RestArea(aAreaBA1))
		RestArea(aArea)
		Return(cRet)
		
	EndIf
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³POSICIONAR PRODUTO - BUSCAR BI3               	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Identifica se o plano esta no usuario ou na familia
If Empty(BA1->BA1_CODPLA)
	cPlano	:= BA3->BA3_CODPLA+BA3->BA3_VERSAO
	cCodPla := BA3->BA3_CODPLA
Else
	cPlano	:= BA1->BA1_CODPLA+BA1->BA1_VERSAO
	cCodPla := BA1->BA1_CODPLA
EndIf

cBi3ModPag		:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_MODPAG")
//cBi3XModPg		:= Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_YMODPG")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³RETORNO: TIPO DO LANCAMENTO                                       ³
//³1 - Demais modalidades (Custo Operacional)		                 ³
//³2 - Mensalidade PP                                                ³
//³3 - Mensalidade CO                                                ³
//³4 - Custo Operacional (CO em PP)                                  ³
//³5 - Co-Participação				                                 ³
//³6 - Debitos / Creditos                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// revisado RN136 - 31/10/07 - RC



Do Case
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '104,127,134,137,138,139,140,141,142,143,144,145,156,157,158,159,160,161,162,163,164,165,166,167'
		// Lancamentos de Custo Operacional -> retorna 1-Demais modalidades
		// 104	Custo Operac. Servicos Medicos
		// 127- Custo Operacional Serv.Acessorios
		// 134- Custo Operacional outros servicos
		// 137-	Producao de coop / PF
		// 138-	Producao de coop / PJ
		// 139- Servico coop PF outras operadoras
		// 140-	Servico coop PJ outras operadoras
		// 141-	SERV.AUXILI.DE DIAGN. E TER
		// 142-	SERV.AUXILIARES OUTRAS UNIM
		// 143-	Prod nao cooperados
		// 144- Prod nao coop outras operadoras
		// 145- Custos em servicos proprios
		// 156- Taxa custo oper serv medicos
		// 157- Taxa adm serv acessorios
		// 158- Taxa outros servicos
		// 159- Taxa prod coop / PF
		// 160- Taxa prod coop / PJ
		// 161- Taxa serv coop PF / outras operadoras
		// 162- Taxa serv coop PJ / outras operadoras
		// 163- Taxa SADT
		// 164- Taxa SADT / outras operadoras
		// 165- Taxa prod nao coop
		// 166- Taxa prod nao coop / outras operadoras
		// 167- Taxa custo serv proprios
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³MODALIDADE DE COBRANCA                                      ³
		//³Verifica se a modalidade eh Pre Pagamento, senao classifica ³
		//³como compra de Custo Operacional.			       		   ³
		//³Variavel cBi3Modpag:                                        ³
		//³1 - Pre-Pagamento                                           ³
		//³2 - Demais modalidades									   ³
		//³Retorno do programa:                                        ³
		//³1 - Demais Modalidades (C.O.)                               ³
		//³4 - Compra de procedimentos (C.O.) em pré-pagamento		   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//	cRet	:= IIf( AllTrim(cBi3ModPag) $ '1', '4', '1' )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Modificado em 05/03/08 pois gerava duplicidade em casos de   ³
		//³compra de procedimento em C.O., onde contabilizava no lancto ³
		//³P01-002 e posteriormente no lancto P07-nnn.                  ³
		//³Força retorno 4 (compra em CO) para ser contabilizado somente³
		//³no momento da abertura da guia (P07). Roger C.               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cRet	:= '4'
		
		// revisado RN136 - 30/10/07 - RC
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '101,102,103,107,110,118,133,146'
		// Lancamentos de Mensalidades PP ou CO, retorna 2-Mensalidade PP ou 3-Mensalidade CO
		// 101- Mensalidade
		// 102- Opcional
		// 103- Taxa de Inscricao
		// 107- Cartao de Identificacao
		// 110- Valor do Agravo
		// 118- Mensalidade Retroativa
		// 133- Taxa de Adesao do Opcional
		// 146- Opcional Retroativo
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³MODALIDADE DE COBRANCA                                      ³
		//³Verifica se a modalidade eh Pre Pagamento, senao classifica ³
		//³como mensalidade sobre Custo Operacional.			       ³
		//³Variavel cBi3Modpag:                                        ³
		//³1 - Pre-Pagamento                                           ³
		//³2 - Demais modalidades									   ³
		//³Retorno do programa:                                        ³
		//³2 - Mensalidade PP                                          ³
		//³3 - Mensalidade C.O.										   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cRet	:= IIf( AllTrim(cBi3ModPag) $ '1', '2', '3' )
		
		
		// revisado RN136 - 31/10/07 - RC
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '120,123'
		// Lancamentos de Custo operacional em pre-pagamento (CO em PP)
		// 120- Custo operacional compras pagamento no ato
		// 123- Custo operacional compras pagamento a faturar
		cRet	:= '4'
		
		
		// Taxas administrativas
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '117,122,125'
		// Analisa se tem conta fixa para lancamentos de Taxa Adm. Se houver, retorna 2-Mensalidade PP somente
		// para entrar no programa CTBPLS05 e se não houver retorna "4-Custo Oper em PP" para não entrar nesse
		// programa, pois será contabilizado no CTBPLS11.
		// 117- Taxa Administrativa
		// 122- Taxa Administrativa compras pagamento no ato
		// 125- Taxa Administrativa compras pagamento a faturar
		cRet	:= Iif(!Empty(cCtpl13), '2', '4')
		
		
		// revisado RN136 - 31/10/07 - RC
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '116,121,124,147,148,149,150,151,152,153,154,155,168,169,170,171,172,173,174,175,176,177'
		// Lancamentos exclusivos de Co-Participacao
		// 116	Ft Moderador/Co-Participacao
		// 121- co-part compras pagto ato
		// 124- co-part compra a faturar
		// 147	PAR-SERV.MEDICOS COOPERADOS PF
		// 148	PAR-SERV.MEDICOS COOPERADOS-PJ
		// 149	PAR-SERV.COOP.PF-OUTRAS operadoras
		// 150	PAR-SERV. COOP. PJ OUTRAS operadoras
		// 151	PAR-SERV.AUXILI.OUTRAS operadoras
		// 152	PAR-SERV.AUX.SADT OUTRAS operadoras
		// 153	PAR-SERV.MEDICOS NAO COOPERADO
		// 154- prod nao coop / outras operadoras
		// 155- co-part serv proprios
		// 168- taxa ft / co-participacao
		// 169- taxa prod coop / PF
		// 170- taxa prod coop / PJ
		// 171- taxa serv coop / PF
		// 172- taxa serv coop / PJ
		// 173- taxa serv SADT
		// 174- taxa serv SADT / outras operadoras
		// 175- taxa prod nao coop
		// 176- taxa prod nao coop / outras operadoras
		// 177- taxa custos serv proprios
		cRet	:= '5'
		
		// revisado RN136 - 31/10/07 - RC ==> NECESSITA ALTERACAO, AGUARDANDO REGRA UVS
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '108'
		// 108- Reembolso de livre escolha -- arquivos BKD / BKE
		cRet	:= 'X'
		
		// revisado RN136 - 31/10/07 - RC ==> NECESSITA ALTERACAO, VALIDAR REGRA COM UVS
	Case AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '109'
		// 109- Via de boleto -- arquivo BEE
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³MODALIDADE DE COBRANCA                                      ³
		//³Verifica se a modalidade eh Pre Pagamento, senao classifica ³
		//³como mensalidade sobre Custo Operacional.			       ³
		//³Variavel cBi3Modpag:                                        ³
		//³1 - Pre-Pagamento                                           ³
		//³2 - Demais modalidades									   ³
		//³Retorno do programa:                                        ³
		//³2 - Mensalidade PP                                          ³
		//³3 - Mensalidade C.O.										   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cRet	:= IIf( AllTrim(cBi3ModPag) $ '1', '2', '3' )
		
		// revisado RN136 - 31/10/07 - RC
	Case Subs(&(cAlias+'->'+cAlias+'_CODTIP'),1,1) = '9' .or. AllTrim(&(cAlias+'->'+cAlias+'_CODTIP')) $ '111,113,128,129,130,131,132,135,136,180'
		// Trata lançamentos de faturamento de propriedade do cliente OU
		// Debitos e Creditos diversos - retorna 6 e busca conta na tabela BSQ ou BSP
		// 111- Juros do Mes Anterior
		// 113- Debitos servicos medicos
		// 128- Debito servicos acessorios
		// 129- Credito servicos medicos
		// 130- Credito servicos acessorios
		// 131- Credito odontologico
		// 132- Debito odontologico
		// 135- Debito outros servicos
		// 136- Credito outros servicos
		// 180- Debito servicos medicos
		cRet	:= '6'
		
	Otherwise
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Grava em memoria a composicao da cobranca.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		// Grava log de registro com problema quando for primeira sequencia e ativado na chamada do CT5
		If lLogUsu .and. CT5->CT5_LANPAD == 'P09' //.and. AllTrim(BM1->BM1_SEQ) == '001' - Desabilitado em 04/08/06 By RC.
			cProc	:= 'Lt.Cobr:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_PLNUCO'),5,8))+'|Seq:'+AllTrim(&(cAlias+'->'+cAlias+'_SEQ'))+'|Tit:'+AllTrim(SE1->E1_NUM)
			cProc	+= '|Matr:'+AllTrim(&(cAlias+'->('+cAlias+'_CODINT+'+cAlias+'_CODEMP+'+cAlias+'_MATRIC+'+cAlias+'_TIPREG+'+cAlias+'_DIGITO)') )+'|Nome:'+AllTrim(Subs(&(cAlias+'->'+cAlias+'_NOMUSR'),1,20))
			cProc	+= '|Prod: N/Enc. |Grp.Emp:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEMP'))
			cProc	+= '|Contr:'+AllTrim(BA1->BA1_CONEMP)+'/'+AllTrim(BA1->BA1_VERCON)+'|Sub:'+AllTrim(BA1->BA1_SUBCON)+'/'+AllTrim(BA1->BA1_VERSUB)
			cProc	+= '|Tp.Fat:'+AllTrim(&(cAlias+'->'+cAlias+'_CODTIP'))+'|Evto:'+AllTrim(&(cAlias+'->'+cAlias+'_CODEVE'))
			cProc	+= '|Vl.Total:|'+StrZero(SE1->E1_VALOR,10,2)+'|Vl.Tit.:|'+StrZero(SE1->E1_VALOR,10,2)
			cProc	+= '|Titulo nao contabilizado|CTBPLS06'+IIf(&(cAlias+'->(Eof())'),cAlias,'')
			U_Gravalog(cProc,'FAT')
		EndIf
		cRet	:=  'X'
		
EndCase

BA3->(RestArea(aAreaBA3))
BA1->(RestArea(aAreaBA1))
RestArea(aArea)
Return(cRet)
