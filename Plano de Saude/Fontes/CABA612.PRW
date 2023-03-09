#INCLUDE "plstiss.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "TBICONN.CH"
#include 'fileio.ch'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ CABA612 ³ Autor ³ Mateus Medeiros      ³ Data ³ 10.05.18    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Chama a tela para vincular um item qualquer com um elemento ³±±
±±³          ³da TISS ou exclui o vínculo com a TISS, de acordo com o      ³±±
±±³          ³parÂmetro cOpc                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABA612                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cTabPLS (caracter, obrigatório) - Recebera o código do alias³±±
±±³          ³de origem de onde esta sendo chamada a função de vinculo,    ³±±
±±³          ³ou seja, se a função esta sendo chamada de um ações          ³±±
±±³          ³relacionadas do browse da tabela padrão (BR8), devera ser    ³±±
±±³          ³passado o conteúdo "BR8" neste parâmetro, através do valor   ³±±
±±³          ³deste parâmetro será possível descobrir a terminologia       ³±±
±±³          ³vinculada a esta tabela posicionando na tabela               ³±±
±±³          ³"BTP (Cabeçalho de terminologias)", para o campo BTP_ALIAS   ³±±
±±³          ³igual ao valor do parâmetro cTabPLS.                         ³±±
±±³          ³                                                             ³±±
±±³          ³ cChvTab (caracter, opcional): Recebera o valor dos campos   ³±±
±±³          ³que compõem a chave do índice (SIX) principal da tabela,     ³±±
±±³          ³ex: BR8_FILIAL+BR8_CODPAD+BR8_CODSPA = 010110101012 onde     ³±±
±±³          ³01= filial, 01 = tabela e 10101012 = procedimento, essa chave³±±
±±³          ³é para localização do item da tabela em questão, não é       ³±±
±±³          ³necessário a composição inteira de um índice, apenas os      ³±±
±±³          ³campos para posicionamento no registro, tabelas mais simples,³±±
±±³          ³terão apenas filial+código, a tabela de procedimento se      ³±±
±±³          ³trata de uma das exceções existentes, porque o código do     ³±±
±±³          ³procedimento esta associado a tabela de procedimentos        ³±±
±±³          ³(BR8_CODPAD), dessa forma só com o código do procedimento não³±±
±±³          ³seria possível ter uma chave única do mesmo, pois o mesmo    ³±±
±±³          ³procedimento pode estar em uma ou mais tabelas .             ³±±
±±³          ³                                                             ³±±
±±³          ³ cCpoPri (caracter, obrigatório):  Valor do campo principal  ³±±
±±³          ³que faz o vinculo, no exemplo citado acima seria o valor do  ³±±
±±³          ³campo BR8_CODPSA.                                            ³±±
±±³          ³      				                                   	     ³±±
±±³          ³ cOpc: Indica qual ação o método deve tomar, se é de incluir ³±±
±±³          ³um vínculo(1) ou se é para excluir(0)                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA612(cTabPLS, cCpoPri, cOpc)
	
	Local cCodTab 		:= ""   //Código da TERMINOLOGIA
	Local lHasVinc 	:= .F. //indica se o item tem vinculo na tiss
	Local lAltVinc 	:= .F. //indica se o usuário deseja alterar o vinculo da tiss do item
	Local cCodTerm	 	:= ''  //código do termo que será vinculado
	Local cDescTerm 	:= '' //descrição do termo que ja está vinculado
	Local cTerminolo 	:= '' //descrição da Terminologia
	Local nIncluir	 	:= 1
	Local nExcluir 	:= 0
	Local cSQL      	:= ""
	Local nUBOB    	:= 	0
	Local nOpca      	:= 0
	Local nLin		 	:= 1
	Local bOK			:= { ||nLin := oBrowUsr:nAt, nOpca := 1,oDlgPes:End() }
	Local bCancel 		:= { || nOpca := 3,oDlgPes:End() }
	Local aBrowUsr 		:= {{"01","00"},{"23","23"},{"24","24"},{"98","98"}} // CodPad BR8 - Terminologia
	Local cTissVer  := PLSTISSVER()
	Local cChvTab := ""
	Local cCodTerm := BR8->BR8_CODPSA  //pega o procedimento posicionado para posteriormente a existência de BTU
	Local cDescTerm := BR8->BR8_DESCRI
			
	Private aHBOB   	:= {}
	Private aCBOB   	:= {}
	Private cChv445	:= ""

	If Empty(cTissVer) .OR. cTissVer < "3"
		MsgAlert(STR0417)
		Return
	EndIf
	
	// Valido se é tabela de pacote 
	if (nPos := ascan(aBrowUsr,{|x| x[1] == BR8->BR8_CODPAD }) ) == 0 // valida existencia da tabela padra
		MsgAlert("Não é permitido realizar vínculo de código próprio e pacotes para a tabela "+BR8->BR8_CODPAD+".")
		Return 
	else 
		cCodTab := 	aBrowUsr[nPos][2] // terminologia
	endif  
	
	DbSelectArea("BTP")
	BTP->(DbSetOrder(2))
	DbSelectArea("BVL")
	BVL->(DbSetOrder(2))

	If BTP->(MsSeek(xFilial("BTP")+cTabPLS))
		cChvTab := &(ALLTRIM(cTabPLS+"->("+cTabPLS+"_FILIAL+"+ALLTRIM(BTP->BTP_CHVTAB)+")"))
	Else
		If BVL->(MsSeek(xFilial("BVL")+cTabPLS))
			cChvTab := &(ALLTRIM(cTabPLS+"->("+cTabPLS+"_FILIAL+"+ALLTRIM(BVL->BVL_CHVTAB)+")"))
		Else
			MsgAlert("Não foi encontrada terminologia TISS vinculada a tabela: " + cTabPLS)
		EndIf
	EndIf

//Se achou alguma tabela de terminologia
	IF ( cCodTab # "" ) // diferente de branco
	//Seeka novamente a BTP para não se perder ao salvar registro na BTU
		DbSelectArea("BTP")
		BTP->(DbSetOrder(2))
		DbSelectArea("BVL")
		BVL->(DbSetOrder(2))

		If BTP->(MsSeek(xFilial("BTP")+cTabPLS+cCodTab))
			cChvTab := &(ALLTRIM(cTabPLS+"->("+cTabPLS+"_FILIAL+"+ALLTRIM(BTP->BTP_CHVTAB)+")"))
		Else
			If BVL->(MsSeek(xFilial("BVL")+cTabPLS+cCodTab))
				cChvTab := &(ALLTRIM(cTabPLS+"->("+cTabPLS+"_FILIAL+"+ALLTRIM(BVL->BVL_CHVTAB)+")"))
			EndIf
		EndIf
	//verifica se o item tem vinculo na tabela de depara
		dbSelectArea("BTU")
		dbSetOrder(2) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRSIS
		lHasVinc := MsSeek(xFilial("BTU")+cCodTab+cTabPLS+cChvTab)

	//se tem vinculo verifica se o usuário realmente quer alterar o vinculo
		if ( lHasVinc )
		
			//se for exclusão
			if (cOpc) == nExcluir
			//pergunta se o usuário deseja excluir o vínculo
				
				if (MsgYesNo("Deseja reamente excluir o vínculo com a TISS deste item? <br>Código: "+BTU->BTU_CDTERM+"<br>Descrição: " +cDescTerm)) //Deseja reamente excluir o vínculo com a TISS deste item? Código: XXXXX Descrição: XXXXX
					cCodTerm := BTU->BTU_CDTERM
					cCodTab := BTU->BTU_CODTAB
					BTU->(RecLock('BTU',.F.))
					BTU->(DbDelete())
					BTU->(DbSkip())
					BTU->( MsUnlock() )

				//CHAMA A FUNÇAO QUE ATUALIZA O CAMPO BTU_HASVIN
					PLSAHASVIN(cCodTab, cCodTerm, cTabPLS)

					MsgInfo("Vínculo excluido com sucesso.") //"Vínculo excluido com sucesso."
				EndIf
		//se não é inclusão
			Else
			
			//verifica se o usuário deseja alterar o vínculo
				lAltVinc := MsgYesNo("Item já tem Vinculo com a TISS, deseja alterar este vínculo?<br>Código: "+BTU->BTU_CDTERM+'<br>'+"Descrição:"+"cDescTerm") //Item já tem Vinculo com a TISS, deseja alterar este vínculo? Código: XXXXX Descrição: XXXXX
			EndIf
		ElseIf (cOpc) == nExcluir
			MsgInfo("Item não tem vínculo com a TISS.") //"Item não tem vínculo com a TISS."
		EndIf

	//se for inclusão e (não tem vinculo ou o usuário deseja alterar o vinculo)
		if ((cOpc) == nIncluir .And. ( !lHasVinc .Or. lAltVinc ) )
			
		//verifica se foi selecionado algum registro na pesquisa
			if ( cCodTerm # '' ) // diferente de branco
				If (lHasVinc)//se já tem vínculo, ALTERA o vínculo
				//realiza alteração somente se o item selecionado não for o mesmo do que o que esta selecionado
					MsgInfo("Procedimento já possui vínculo.")
					
				Else //caso contrário INCLUI o vínculo
					BTU->(RecLock('BTU',.T.))
						BTU->BTU_FILIAL := xFilial("BTU")
						BTU->BTU_CODTAB := cCodTab
						BTU->BTU_VLRSIS := cChvTab
						BTU->BTU_VLRBUS := cCpoPri
						BTU->BTU_CDTERM := cCodTerm
						BTU->BTU_ALIAS  := cTabPLS
					BTU->( MsUnlock() )

					MsgInfo("Vínculo incluído com sucesso.") //Vínculo incluido com sucesso.
				EndIf

			//CHAMA A FUNÇAO QUE ATUALIZA O CAMPO BTU_HASVIN
				PLSAHASVIN(cCodTab, cCodTerm, cTabPLS)
			EndIf
		EndIf
	ElseIf (nOpca == K_OK)
		MsgInfo("Tabela de Domínio não encontrada.") //Tabela de Domínio não encontrada.
	EndIf

Return (Nil)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLMENU612  º Autor ³ Angelo Henrique    º Data ³  11/05/18  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Chamada de tela que irá conter o menu das opções referente º±±
±±º          ³ ao processo do Vinculo de Pacotes.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PLMENU612
	
	Local _aArea 	:= GetArea()
	Local _nOpc 	:= 0
	
	Private _oDlg	:= Nil
	Private _oBtn	:= Nil
	Private _oGroup	:= Nil
	
	DEFINE MSDIALOG _oDlg FROM 0,0 TO 90,380 PIXEL TITLE 'Vinculo Pacotes Tiss.'
	
	_oGroup:= tGroup():New(02,02,40,190,'Selecione uma das opções',_oDlg,,,.T.)
	
	_oBtn := TButton():New( 15,020,"Inc. de Vínc. de Pacote"	,_oDlg,{||_oDlg:End(),_nOpc := 1	},070,012,,,,.T.,,"",,,,.F. )
	_oBtn := TButton():New( 15,100,"Exc. de Vínc. de Pacote"	,_oDlg,{||_oDlg:End(),_nOpc := 2	},070,012,,,,.T.,,"",,,,.F. )
	
	ACTIVATE MSDIALOG _oDlg CENTERED
	
	If _nOpc = 1
	
		//--------------------------------------
		//Chamada da função de Inclusão de Vínculo
		//--------------------------------------
		MsgRun('Aguarde... Incluindo vinculo Pacote Tiss',,{||U_CABA612('BR8',BR8->BR8_CODPSA, 1)})
		
	ElseIf _nOpc = 2
		
		//--------------------------------------
		//Chamada da função de Exclusão de Vínculo
		//--------------------------------------
		MsgRun('Aguarde... Excluindo vinculo Pacote Tiss',,{||U_CABA612('BR8',BR8->BR8_CODPSA, 0)})
		
	EndIf
	
	RestArea(_aArea)
	
Return




