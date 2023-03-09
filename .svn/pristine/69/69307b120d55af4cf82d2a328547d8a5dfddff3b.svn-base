#INCLUDE 'PROTHEUS.CH'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL169GRV  ºAutor  ³Leonardo Portella   º Data ³  19/10/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gravacao do usuario que fez a transferencia.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PL169GRV()
	
Local aArea			:= GetArea()
Local aAreaBA1		:= BA1->(GetArea())
Local aAreBA3		:= BA3->(GetArea())

Local cOldMat		:= PARAMIXB[1]		// Matricula Familia de Origem
Local cNewMat		:= PARAMIXB[2]		// Matricula Familia de Destino
Local cOldUsr		:= PARAMIXB[3]		// Matricula Usuario Antiga
Local cNewUsr		:= PARAMIXB[4]		// Matricula Usuario Nova Gerada

Local cUPD			:= " "
Local _cMatOdt		:= ""				// Angelo Henrique - Data: 11/01/2016 - Utilizado para matricula Odontologica
Local _cPref		:= GetNewPar("MV_XPRFTF","0024|0025|0027|0028")		// Angelo Henrique - Data: 11/01/2016
Local aMatCare		:= {}
Local i				:= 0
Local lLote			:= empty(AllTrim(BQQ->BQQ_FAMORI))
Local lAux			:= .F.

if Type( "xx_pB_PL169" ) == "U"
	Public xx_Pb_CHBD7 := .T.
endif

if M->BQQ_CARENC == '1'		// Manter carencia = SIM

	// TIcket 14545509 aberto na TOTVS para gerar no padrão (quando passar a funcionar, carência já vai existir e PE deixa de ser necessário)
	BFO->(DbSetOrder(1))		// BFO_FILIAL+BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG+BFO_CLACAR
	if !BFO->(DbSeek(xFilial("BFO") + SubStr(cNewUsr,1,16)))

		// Verificar se beneficiário antigo tinha classe de carência para ter o que migrar
		BFO->(DbSetOrder(1))		// BFO_FILIAL+BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG+BFO_CLACAR
		if BFO->(DbSeek(xFilial("BFO") + SubStr(cOldUsr,1,16)))

			// Buscar nome do beneficiário para pergunta
			BA1->(DbSetOrder(2))		// BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
			if BA1->(DbSeek(xFilial("BA1") + cNewUsr ))

				if lLote
					lAux	:= .T.
				else
					if MsgYesNo("Deseja carregar as classes de carências do beneficiário: " + AllTrim(BA1->BA1_NOMUSR) + " para a nova matricula?","Atenção")
						lAux	:= .T.
					endif
				endif

				if lAux

					while BFO->(!EOF()) .and. BFO->(BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG) == SubStr(cOldUsr,1,16)

						aAdd(aMatCare, {BFO->BFO_CLACAR,;
										BFO->BFO_CARENC,;
										BFO->BFO_UNICAR,;
										BFO->BFO_DATCAR,;
										BFO->BFO_YRGIMP})

						BFO->(DbSkip())
					end

					for i := 1 to len(aMatCare)

						BFO->(Reclock('BFO',.T.))
							BFO->BFO_FILIAL	:= xFilial("BFO")
							BFO->BFO_CODINT	:= SubStr(cNewUsr, 1,4)
							BFO->BFO_CODEMP	:= SubStr(cNewUsr, 5,4)
							BFO->BFO_MATRIC	:= SubStr(cNewUsr, 9,6)
							BFO->BFO_TIPREG	:= SubStr(cNewUsr,15,2)
							BFO->BFO_CLACAR	:= aMatCare[i][1]
							BFO->BFO_CARENC	:= aMatCare[i][2]
							BFO->BFO_UNICAR	:= aMatCare[i][3]
							BFO->BFO_DATCAR	:= aMatCare[i][4]
							BFO->BFO_YRGIMP	:= aMatCare[i][5]
						BFO->(MsUnlock())

					next
				
				endif
			
			endif
		
		endif
	
	endif

endif

BA1->(DbSetOrder(2))
if BA1->(MsSeek(xFilial('BA1') + cOldUsr))

	// Angelo Henrique - Data:11/01/2016 - Pegando a Matricula Odontologica para adicionar na nova matricula
	_cMatOdt := BA1->BA1_YMTODO

	// Leonardo Portella - 26/10/15 - Chamado - ID: 21269 - Inicio
	BA1->(Reclock('BA1',.F.))
	
		if !empty(BA1->BA1_CODCCO)
			if !BA1->BA1_LOCSIB $ '2|8'		// Excluido
				BA1->BA1_LOCSIB := '8'		// Forcar bloqueio da matricula antiga no SIB se tiver CCO e nao estiver como excluida
			endif
		else								// Se nao tiver CCO marco para nao enviar pois sera enviada a nova matricula gerada na transferencia
			BA1->BA1_LOCSIB := '0'
			BA1->BA1_INFANS := '0'
			BA1->BA1_INFSIB := '0'
		endif
	
	BA1->(MsUnlock())
	// Leonardo Portella - 26/10/15 - Chamado - ID: 21269 - Fim

	// Mateus Medeiros - Data: 29/08/2017 - Chamado: 40594 - INICIO
	// Grava o tipo de cobrança Boleto na matricula anterior na BA3
	BA3->(DbSetOrder(1))	// BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
	if BA3->(DbSeek(xFilial("BA3") + BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_CONEMP + BA1_VERCON + BA1_SUBCON + BA1_VERSUB)))

		RecLock("BA3",.F.)
			BA3->BA3_TIPPAG	:= '04'			// Boleto
			BA3->BA3_GRPCOB	:= iif(BA3->BA3_CODEMP == '0001', '0002', '0003')
			BA3->BA3_VENCTO	:= 10
		BA3->(MsUnLock())
	
	endif
	RestArea(aAreBA3)
	// FIM - Mateus Medeiros - Data: 29/08/2017

	// INICIO - Angelo Henrique - Data: 29/12/2015
	// Pegando todos os opcionais da matricula anterior, pois nas transferências referente a prefeitura e até em
	// algumas outras muitas das vezes o opcional não vai
	if cEmpAnt == "01"		// CABERJ

		// Marcela Coimbra - Desabilitado pois não temos mais opcionais de odontologico para carregar
		if AllTrim(M->BQQ_EMPORI) $ AllTrim(_cPref) .and. .F.

			if MSGYESNO("Deseja carregar os opcionais da matricula: " + cOldUsr + " para a nova matricula?","Atenção")
				// Static Function para realizar as gravações dos opcionais passando como parâmetro a matricula antiga e a nova
				GrvOpc(cOldUsr, cNewUsr)
			endif

			// Validação para não aparecer a mensagem de atualziação da familia criado um campo para validar se já houve
			// atualização na familia no processo de transferência prefeitura, nova matricula
			BA1->(DbSetOrder(2))
			if BA1->(MsSeek(xFilial('BA1') + cNewUsr))

				BA3->(DbSetOrder(2))	// BA3_FILIAL+BA3_CODPLA+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
				if BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODPLA+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))

					if Empty(BA3->BA3_XPRFTR)

						if MSGYESNO("Deseja atualizar os opcionais da familia?","Atenção")
							// Static Function para realizar as gravações dos opcionais passando como parâmetro a familia nova
							GrvFam(cNewUsr)
						endif
					
					endif
				
				endif
			
			endif
		
		endif
	
	endif
	// FIM - Angelo Henrique - Data: 29/12/2015

	BA1->(DbSetOrder(2))
	if BA1->(MsSeek(xFilial('BA1') + cNewUsr))

		BA1->(Reclock('BA1',.F.))

			// Leonardo Portella - 26/10/15 - Chamado - ID: 21269 - Inicio
			BA1->BA1_LOCSIB	:= '0'		// Marcar como nao enviado para envio normal no SIB
			BA1->BA1_CODCCO	:= ' '		// Limpo o CCO pois sera enviada nova inclusao para a nova matricula
			// Leonardo Portella - 26/10/15 - Chamado - ID: 21269 - Fim

			// Campos a serem incluidos conforme chamado 3124 - em 17.10.2012 OSP
			BA1->BA1_YTEL2  := TRB169->BA1_YTEL2
			BA1->BA1_YCEL   := TRB169->BA1_YCEL
			BA1->BA1_DATREP := TRB169->BA1_DATREP
			BA1->BA1_YMTREP := TRB169->BA1_YMTREP
			BA1->BA1_YDTDIG := TRB169->BA1_YDTDIG
			BA1->BA1_YDEPEN := TRB169->BA1_YDEPEN
			BA1->BA1_YJORPA := TRB169->BA1_YJORPA
			BA1->BA1_YDTLIM := TRB169->BA1_YDTLIM

			// Angelo Henrique - Data: 29/12/15
			// Acrescentando informações no processo de transferência, alterações essas efetuadas quando a trasnferência é da prefeitura
			BA1->BA1_IMPORT := ""			// Removendo a informação de importado, pois a rotina é de transferência e não de importação
			//BA1->BA1_YMTODO := _cMatOdt	// Levando Matricula Odontologica -- Novos planos não precisam deste tipo de vinculo
			
			BA1->BA1_YCPLAP := ConvPlano(BA1->BA1_CODPLA,1)
			BA1->BA1_YDPLAP := ConvPlano(BA1->BA1_CODPLA,2)
		
		BA1->(MsUnlock())
	
	endif

endif

Reclock('BQQ',.F.)
	BQQ->BQQ_XLOGIN	:= RetCodUsr()
	BQQ->BQQ_XNOME	:= UsrFullName(RetCodUsr())
BQQ->(MsUnlock())

// Marcelo Giglio - 29/11/2012 - Chamado 4399
// Busca a família no destino e se o Opcional eh Farmacia a classe do opcional deve colocada como 'N'

cUPD := " UPDATE " + RetSQLName("BF4") + " SET BF4_CLAOPC = " + "'N'"
cUPD += " WHERE BF4_FILIAL = '" +    xFilial("BF4")    + "'"
cUPD +=	  " AND BF4_CODINT = '" + SubStr(cNewMat,1,4)  +"'"
cUPD +=   " AND BF4_CODEMP = '" + SubStr(cNewMat,6,4)  +"'"
cUPD +=   " AND BF4_MATRIC = '" + SubStr(cNewMat,11,6) +"'"
cUPD +=   " AND BF4_CODPRO = '0031'"
TcSqlExec(cUPD)

// Marcela Coimbra - Carregar dados do produto novo no momento da transferência
fCaraTabela( cNewUsr, cOldUsr, _cPref )

// Static Function para realizar as gravações dos opcionais passando como parâmetro a matricula antiga e a nova
GrvOpc(cOldUsr, cNewUsr)

// Angelo Henrique - Data:25/03/202
// Processo para corrigir informaçoes pertinentes a geração de carteira
AtuCrt()

RestArea(aAreBA3)
RestArea(aAreaBA1)
RestArea(aArea)

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvOpc    ºAutor  ³Angelo Henrique     º Data ³  08/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gravacao dos opcionais do usuário quando a transferência é  º±±
±±º          ³da Prefeitura.                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GrvOpc(cOldUsr, cNewUsr)
	
	Local _aAreBF4 	:= BF4->(GetArea())
	Local _aAreBZX 	:= BZX->(GetArea())
	Local _aAreBYX 	:= BYX->(GetArea())
	Local _aAreBA1	:= BA1->(GetArea())
	Local _aAreBBU	:= BA1->(GetArea())
	Local _aAreBFY	:= BA1->(GetArea())
	Local _ni			:= 0
	Local _lRetorno 	:= .F. //Validacao da dialog criada oDlg
	Local _nOpca 		:= 0 //Opcao da confirmacao
	Local bOk 			:= {|| _nOpca:=1,_lRetorno:=.T.,oDlg:End() } //botao de ok
	Local bCancel 	:= {|| _nOpca:=0,oDlg:End() } //botao de cancelamento
	Local _cArqEmp 	:= "" //Arquivo temporario com as empresas a serem escolhidas
	Local _aStruTrb 	:= {} //estrutura do temporario
	Local _aBrowse 	:= {}
	Local _aEmpMigr 	:= {}
	Local _cAlias 	:= GetNextAlias()
	Local _cAliTmp	:= GetNextAlias()
	Local _nt 			:= 0
	Local lInverte 	:= .F. //Variaveis para o MsSelect
	Local cMarca 		:= GetMark() //Variaveis para o MsSelect
	Local oBrwTrb 	:= Nil //objeto do msselect
	Local oDlg 		:= Nil //objeto do msselect
	Local _aEmpBYX	:= {} //Vetor que armazena as informações da BYX
	Local _aEmpBZX	:= {} //Vetor que armazena as informações da BZX
	Local _aEmpBFY	:= {} //Vetor que armazena as informações da BFY
	Local _nt 			:= 0
	Local _nk 			:= 0
	Local _nw			:= 0
	Local _lBBU		:= .T.
	Local _lBFY		:= .T.
	
	**'Marcela Coimbra - RDM 238 - Perguntar somente se tiver opcional'**
	
	Local l_TemOpc := .T.
	
	**'Marcela Coimbra - Fim - RDM 238 - Perguntar somente se tiver opcional'**
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define campos do TRB ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aadd(_aStruTrb,{"OK" 		,"C",02,0})
	
	aadd(_aStruTrb,{"MATRICULA" ,"C",TAMSX3("BF4_MATRIC")[1],0})
	
	aadd(_aStruTrb,{"CODIGO"		,"C",TAMSX3("BF4_CODPRO")[1],0})
	
	aadd(_aStruTrb,{"VERSAO"		,"C",TAMSX3("BF4_VERSAO")[1],0})
	
	aadd(_aStruTrb,{"DESCRICAO"	,"C",TAMSX3("BF4_DESPRO")[1],0})
	
	aadd(_aStruTrb,{"TIPO" 		,"C",TAMSX3("BF4_TIPREG")[1],0})
	
	aadd(_aStruTrb,{"DTBASE"	 	,"D",TAMSX3("BF4_DATBAS")[1],0})
	
	aadd(_aStruTrb,{"TIPVIN"		,"C",TAMSX3("BF4_TIPVIN")[1],0})
	
	aadd(_aStruTrb,{"YNUPRE"		,"C",TAMSX3("BF4_YNUPRE")[1],0})
	aadd(_aStruTrb,{"CODRDA"		,"C",TAMSX3("BF4_CODRDA")[1],0})
	aadd(_aStruTrb,{"YCODLC "		,"C",TAMSX3("BF4_YCODLC")[1],0})
	aadd(_aStruTrb,{"YCOMPL"		,"C",TAMSX3("BF4_YCOMPL")[1],0})
	aadd(_aStruTrb,{"YBLFRM"		,"C",TAMSX3("BF4_YBLFRM")[1],0})
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define campos do MsSelect ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aadd(_aBrowse,{"OK" 			,,"" 				})
	
	aadd(_aBrowse,{"MATRICULA"	,,"Matricula" 	})
	
	aadd(_aBrowse,{"CODIGO"		,,"Cd. Opcional" 	})
	
	aadd(_aBrowse,{"VERSAO"		,,"Versao" 		})
	
	aadd(_aBrowse,{"DESCRICAO"	,,"Ds. Opcional" 	})
	
	aadd(_aBrowse,{"TIPO"		,,"Tp. Registro"	})
	
	aadd(_aBrowse,{"DTBASE"		,,"Data Base" 	})
	
	aadd(_aBrowse,{"TIPVIN"		,,"Tipo Vinculo" 	})
	
	If Select(_cAliTmp) > 0
		
		_cAliTmp->(DbCloseArea())
		
	Endif
	
	_cArqEmp := CriaTrab(_aStruTrb)
	
	dbUseArea(.T.,__LocalDriver,_cArqEmp,_cAliTmp)
	
	DbSelectArea("BF4")
	DbSetOrder(1)
	If DbSeek(xFilial("BF4") + cOldUsr)
		
		While !EOF() .And. BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == cOldUsr
			
			If Empty(BF4->BF4_DATBLO)
				
				//----------------------------------------------------------------------
				//Angelo Henrique - Data:22/07/2016
				//----------------------------------------------------------------------
				//Tirando os planos dentais, pois nos novos planos não precisa
				//0103 e 0105 são os Dentais (Essencial e Multi)
				//----------------------------------------------------------------------
				If !(BF4->BF4_CODPRO $ "0103|0105")
					
					
					**'Marcela Coimbra - RDM 238 - Perguntar somente se tiver opcional'**
					
					l_TemOpc := .F.
					
					**'Marcela Coimbra - Fim - RDM 238 - Perguntar somente se tiver opcional'**
					
					
					RecLock(_cAliTmp,.T.)
					
					(_cAliTmp)->OK 			:= SPACE(2)
					
					(_cAliTmp)->MATRICULA 	:= BF4->BF4_MATRIC
					
					(_cAliTmp)->CODIGO 		:= BF4->BF4_CODPRO
					
					(_cAliTmp)->VERSAO 		:= BF4->BF4_VERSAO
					
					(_cAliTmp)->DESCRICAO 	:= POSICIONE("BI3",1,xFilial("BI3")+BF4->BF4_CODINT+BF4->BF4_CODPRO, "BI3_DESCRI")
					
					(_cAliTmp)->TIPO 		:= BF4->BF4_TIPREG
					
					(_cAliTmp)->DTBASE 		:= BF4->BF4_DATBAS
					
					(_cAliTmp)->TIPVIN 		:= BF4->BF4_TIPVIN
					
					(_cAliTmp)->YNUPRE 		:= BF4->BF4_YNUPRE
					(_cAliTmp)->CODRDA 		:= BF4->BF4_CODRDA
					(_cAliTmp)->YCODLC  	:= BF4->BF4_YCODLC
					(_cAliTmp)->YCOMPL  	:= BF4->BF4_YCOMPL
					(_cAliTmp)->YBLFRM		:= BF4->BF4_YBLFRM
					
					MsUnlock()
					
				EndIf
				
			EndIf
			
			BF4->(DbSkip())
			
		EndDo
		
	EndIf
	
	**'Marcela Coimbra - RDM 238 - Perguntar somente se tiver opcional'**
	
	If l_TemOpc
		
		Return
		
	EndIf
	
	**'Marcela Coimbra - Fim - RDM 238 - Perguntar somente se tiver opcional'**
	
	
	//---------------------------------------------
	//Montando a tela para visualizar os Opcionais
	//---------------------------------------------
	@ 001,001 TO 400,700 DIALOG oDlg TITLE OemToAnsi("Opcionais do Beneficiário")
	
	@ 015,005 SAY OemToAnsi("Selecione os opcionais que serão levados para a nova matricula: ")
	
	oBrwTrb := MsSelect():New(_cAliTmp,"OK","",_aBrowse,@lInverte,@cMarca,{025,001,170,350})
	
	oBrwTrb:oBrowse:lCanAllmark := .T.
	
	Eval(oBrwTrb:oBrowse:bGoTop)
	
	oBrwTrb:oBrowse:Refresh()
	
	Activate MsDialog oDlg On Init (EnchoiceBar(oDlg,bOk,bCancel,,)) Centered VALID _lRetorno
	
	(_cAliTmp)->(DbGotop())
	
	If _nOpca == 1
		
		Do While (_cAliTmp)->(!Eof())
			
			If !Empty((_cAliTmp)->OK)//se usuario marcou o registro
				
				//----------------------------------
				//Posições do Array
				//----------------------------------
				// 1 - BF4_CODPRO
				// 2 - BF4_VERSAO
				// 3 - BF4_DTBASE
				// 4 - BF4_TIPVIN
				//----------------------------------
				
				aAdd(_aEmpMigr,{(_cAliTmp)->CODIGO, (_cAliTmp)->VERSAO, (_cAliTmp)->DTBASE, (_cAliTmp)->TIPVIN,(_cAliTmp)->YNUPRE,(_cAliTmp)->CODRDA,(_cAliTmp)->YCODLC ,(_cAliTmp)->YCOMPL , (_cAliTmp)->YBLFRM})
				
				//-------------------------------------------------------------------
				//Varrendo as demais estrutras que estão relacionadas a Opcionais
				//-------------------------------------------------------------------
				
				//------------------------------
				//Usuários x Cobrança Opcionais
				//------------------------------
				DbSelectArea("BYX")
				DbSetOrder(1) //BYX_FILIAL+BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG+BYX_CODOPC+BYX_VEROPC+BYX_CODFOR
				If DbSeek(xFilial("BYX") + cOldUsr + (_cAliTmp)->CODIGO + (_cAliTmp)->VERSAO)
					
					While !EOF() .And. (cOldUsr + (_cAliTmp)->CODIGO + (_cAliTmp)->VERSAO) == BYX->(BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG+BYX_CODOPC+BYX_VEROPC)
						
						//----------------------------------------------------------------------
						//Angelo Henrique - Data:22/07/2016
						//----------------------------------------------------------------------
						//Tirando os planos dentais, pois nos novos planos não precisa
						//0103 e 0105 são os Dentais (Essencial e Multi)
						//----------------------------------------------------------------------
						If !(BYX->BYX_CODOPC $ "0103|0105") .And. !(Empty(BYX->BYX_CODOPC ))
							
							aAdd(_aEmpBYX,{;
								BYX->BYX_CODOPC,; //Posição 1
							BYX->BYX_VEROPC,; //Posição 2
							BYX->BYX_CODFOR,; //Posição 3
							BYX->BYX_TIPREG,; //Posição 4
							BYX->BYX_RGIMP }) //Posição 5
							
						EndIf
						
						BYX->(DbSkip())
						
					EndDo
					
				EndIf
				
				//-----------------------------
				//Cobrança Usuário x Opcional
				//-----------------------------
				DbSelectArea("BZX")
				DbSetOrder(1) //BZX_FILIAL+BZX_CODOPE+BZX_CODEMP+BZX_MATRIC+BZX_TIPREG+BZX_CODOPC+BZX_VEROPC+BZX_CODFOR+BZX_CODFAI
				If DbSeek(xFilial("BZX") + cOldUsr + (_cAliTmp)->CODIGO + (_cAliTmp)->VERSAO )
					
					While !EOF() .And. (cOldUsr + (_cAliTmp)->CODIGO + (_cAliTmp)->VERSAO) == BZX->(BZX_CODOPE+BZX_CODEMP+BZX_MATRIC+BZX_TIPREG+BZX_CODOPC+BZX_VEROPC)
						
						//----------------------------------------------------------------------
						//Angelo Henrique - Data:22/07/2016
						//----------------------------------------------------------------------
						//Tirando os planos dentais, pois nos novos planos não precisa
						//0103 e 0105 são os Dentais (Essencial e Multi)
						//----------------------------------------------------------------------
						If !(BZX->BZX_CODOPC $ "0103|0105") .And. !(Empty(BZX->BZX_CODOPC))
							
							aAdd(_aEmpBZX,{;
								BZX->BZX_CODOPC	,; //Posição 1
							BZX->BZX_VEROPC	,; //Posição 2
							BZX->BZX_CODFOR	,; //Posição 3
							BZX->BZX_VALFAI	,; //Posição 4
							BZX->BZX_IDAINI	,; //Posição 5
							BZX->BZX_IDAFIN	,; //Posição 6
							BZX->BZX_RGIMP	,; //Posição 7
							BZX->BZX_ANOMES	,; //Posição 8
							BZX->BZX_VLRANT	,; //Posição 9
							BZX->BZX_CODFAI	}) //Posição 10
							
						EndIf
						
						BZX->(DbSkip())
						
					EndDo
					
				EndIf
				
			EndIf
			
			(_cAliTmp)->(DbSkip())
			
		EndDo
		
		//-------------------------------------------------------
		//fecha area de trabalho e arquivo temporário criados
		//-------------------------------------------------------
		
		If Select(_cAliTmp) > 0
			
			DbSelectArea(_cAliTmp)
			
			DbCloseArea()
			
			Ferase(_cArqEmp+OrdBagExt())
			
		Endif
		
	EndIf
	
	//----------------------------------------------
	// Inicio - Se marcou os opcionais na tela
	//----------------------------------------------
	If Len(_aEmpMigr) > 0
		
		DbSelectArea("BA1")
		DbSetOrder(2)
		If BA1->(MsSeek(xFilial('BA1') + cNewUsr))
			
			For _ni := 1 To Len(_aEmpMigr)
				
				DbSelectArea("BF4")
				DbSetOrder(1)//BF4_FILIAL+BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG+BF4_CODPRO
				If !(DbSeek(xFilial("BF4") + cNewUsr + _aEmpMigr[_ni][1]))
					
					RecLock("BF4", .T.)
					
					BF4->BF4_FILIAL := xFilial("BF4")
					BF4->BF4_CODINT := BA1->BA1_CODINT
					BF4->BF4_CODEMP := BA1->BA1_CODEMP
					BF4->BF4_MATRIC := BA1->BA1_MATRIC
					BF4->BF4_CODPRO := _aEmpMigr[_ni][1]
					BF4->BF4_VERSAO := _aEmpMigr[_ni][2]
					BF4->BF4_TIPREG := BA1->BA1_TIPREG
					// BF4->BF4_DATBAS := _aEmpMigr[_ni][3]
					BF4->BF4_DATBAS := BA1->BA1_DATINC
					BF4->BF4_YNUPRE := _aEmpMigr[_ni][5]
					BF4->BF4_CODRDA := _aEmpMigr[_ni][6]
					BF4->BF4_YCODLC := _aEmpMigr[_ni][7]
					BF4->BF4_YCOMPL := _aEmpMigr[_ni][8]
					BF4->BF4_YBLFRM := _aEmpMigr[_ni][9]
					BF4->(MsUnLock())
					
				EndIf
				
			Next _ni
			
			If Len(_aEmpBYX) > 0
				
				For _nt := 1 to Len(_aEmpBYX)
					
					//--------------------------------
					//Usuários x Cobrança Opcionais
					//--------------------------------
					DbSelectArea("BYX")
					DbSetOrder(1) //BYX_FILIAL+BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG+BYX_CODOPC+BYX_VEROPC+BYX_CODFOR
					If !(DbSeek(xFilial("BYX") + cNewUsr + _aEmpBYX[_nt][1]))
						
						BYX->( RecLock("BYX", .T.) )
						
						BYX->BYX_FILIAL := xFilial("BYX")
						BYX->BYX_CODOPE := BA1->BA1_CODINT
						BYX->BYX_CODEMP := BA1->BA1_CODEMP
						BYX->BYX_MATRIC := BA1->BA1_MATRIC
						BYX->BYX_CODOPC := _aEmpBYX[_nt][1]
						BYX->BYX_VEROPC := _aEmpBYX[_nt][2]
						BYX->BYX_CODFOR := _aEmpBYX[_nt][3]
						BYX->BYX_TIPREG := _aEmpBYX[_nt][4]
						BYX->BYX_RGIMP  := _aEmpBYX[_nt][5]
						
						BYX->( MsUnlock() )
						
					EndIf
					
				Next _nt
				
			EndIf
			
			If Len(_aEmpBZX) > 0
				
				For _nk := 1 to Len(_aEmpBZX)
					
					//--------------------------------
					//Cobrança Usuário x Opcional
					//--------------------------------
					DbSelectArea("BZX")
					DbSetOrder(1) //BZX_FILIAL+BZX_CODOPE+BZX_CODEMP+BZX_MATRIC+BZX_TIPREG+BZX_CODOPC+BZX_VEROPC+BZX_CODFOR+BZX_CODFAI
					If !(DbSeek(xFilial("BZX") + cNewUsr + _aEmpBZX[_nk][1]))
						
						BZX->( RecLock("BZX", .T.) )
						
						BZX->BZX_FILIAL	:= xFilial("BZX")
						BZX->BZX_CODOPE 	:= BA1->BA1_CODINT
						BZX->BZX_CODEMP 	:= BA1->BA1_CODEMP
						BZX->BZX_MATRIC 	:= BA1->BA1_MATRIC
						BZX->BZX_TIPREG 	:= BA1->BA1_TIPREG
						BZX->BZX_CODOPC 	:= _aEmpBZX[_nk][1]
						BZX->BZX_VEROPC 	:= _aEmpBZX[_nk][2]
						BZX->BZX_CODFOR 	:= _aEmpBZX[_nk][3]
						BZX->BZX_VALFAI 	:= _aEmpBZX[_nk][4]
						BZX->BZX_IDAINI 	:= _aEmpBZX[_nk][5]
						BZX->BZX_IDAFIN 	:= _aEmpBZX[_nk][6]
						BZX->BZX_RGIMP 		:= _aEmpBZX[_nk][7]
						BZX->BZX_ANOMES 	:= _aEmpBZX[_nk][8]
						BZX->BZX_VLRANT 	:= _aEmpBZX[_nk][9]
						BZX->BZX_CODFAI 	:= _aEmpBZX[_nk][10]
						
						BZX->( MsUnlock() )
						
					EndIf
					
				Next _nk
				
			EndIf
			
		EndIf
		
	EndIf
	
	**'Retirado por marcela coimbra'**
	/*
	BA1->(DbGoTop())
	DbSelectArea("BA1")
	DbSetOrder(2)
	If BA1->(MsSeek(xFilial('BA1') + cNewUsr))
		
		//Inclui as Faixas de Cobranca
		DbSelectArea("BTN")
		DbSetOrder(1)
		If DbSeek(xFilial("BTN")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)+BA3->BA3_FORPAG)
			While ! BTN->(EOF()) .and. BTN->(BTN_FILIAL+BTN_CODIGO+BTN_NUMCON+BTN_VERCON+BTN_SUBCON+BTN_VERSUB+BTN_CODPRO+BTN_VERPRO+BTN_CODFOR) == BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)+BA3->BA3_FORPAG
				
				DbSelectArea("BDK")
				DbSetOrder(2)//BDK_FILIAL+BDK_CODINT+BDK_CODEMP+BDK_MATRIC+BDK_TIPREG
				BDK->(RecLock("BDK",!BDK->(DbSeek(xFilial("BDK")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC+BA1->BA1_TIPREG+BTN->BTN_CODFAI))))
				
				BDK->BDK_FILIAL 	:= xFilial("BDK")
				BDK->BDK_CODFAI 	:= BTN->BTN_CODFAI
				BDK->BDK_IDAINI 	:= BTN->BTN_IDAINI
				BDK->BDK_IDAFIN 	:= BTN->BTN_IDAFIN
				BDK->BDK_VALOR 	:= BTN->BTN_VALFAI
				BDK->BDK_CODINT 	:= BA3->BA3_CODINT
				BDK->BDK_CODEMP 	:= BA3->BA3_CODEMP
				BDK->BDK_MATRIC 	:= BA3->BA3_MATRIC
				BDK->BDK_TIPREG	:= BA1->BA1_TIPREG
				BDK->BDK_ANOMES 	:= BTN->BTN_ANOMES
				BDK->BDK_VLRANT 	:= BTN->BTN_VLRANT
				BDK->BDK_RGIMP 	:= "1" //IMPORTADO 1=SIM E 2=NAO
				BDK->BDK_TABVLD 	:= BTN->BTN_TABVLD
				
				BDK->(MsUnlock())
				
				BTN->(DbSkip())
				
			Enddo
			
		EndIf
		
		//-----------------------------------------------------------------
		//Se carregar cobrança no nível da familia, deve ser excluido
		//para não cobrar de forma indevida
		//-----------------------------------------------------------------
		DbSelectArea("BBU")
		DbSetOrder(1) //BBU_FILIAL+BBU_CODOPE+BBU_CODEMP+BBU_MATRIC+BBU_CODFOR+BBU_CODFAI
		If DbSeek(xFilial("BBU") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC))
			
			While !EOF() .And. BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC) == BBU->(BBU_CODOPE+BBU_CODEMP+BBU_MATRIC)
				
				BBU->(RecLock("BBU", .F.))
				
				BBU->(DbDelete())
				
				BBU->(MsUnlock())
				
				BBU->(DbSkip())
				
			EndDo
			
		EndIf
		
	EndIf
	*/
	RestArea(_aAreBFY)
	RestArea(_aAreBBU)
	RestArea(_aAreBA1)
	RestArea(_aAreBYX)
	RestArea(_aAreBZX)
	RestArea(_aAreBF4)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvFam    ºAutor  ³Angelo Henrique     º Data ³  12/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gravacao dos opcionais da familia quando a transferência é  º±±
±±º          ³da Prefeitura, irá exibir todos os opcionais já gravados    º±±
±±º          ³e os que forem marcados permanecerão, os demais serão       º±±
±±º          ³excluidos do registro, pois o que a rotina faz é levar      º±±
±±º          ³todos os opcionais da familia em vez de levar somente os    º±±
±±º          ³pertinentes ao novo plano.                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GrvFam(cNewUsr)
	
	Local _aAreBF1 	:= BF1->(GetArea())
	Local _aAreBA1 	:= BA1->(GetArea())
	Local _aAreBBY 	:= BBY->(GetArea())
	Local _ni			:= 0
	Local _lRetorno 	:= .F. //Validacao da dialog criada oDlg
	Local _nOpca 		:= 0 //Opcao da confirmacao
	Local bOk 			:= {|| _nOpca:=1,_lRetorno:=.T.,oDlg:End() } //botao de ok
	Local bCancel 	:= {|| _nOpca:=0,oDlg:End() } //botao de cancelamento
	Local _cArqEmp 	:= "" //Arquivo temporario com as empresas a serem escolhidas
	Local _aStruTrb 	:= {} //estrutura do temporario
	Local _aBrowse 	:= {}
	Local _aEmpMigr 	:= {}
	Local _cAlias 	:= GetNextAlias()
	Local _cAliTmp	:= GetNextAlias()
	Local _nt 			:= 0
	Local lInverte 	:= .F. //Variaveis para o MsSelect
	Local cMarca 		:= GetMark() //Variaveis para o MsSelect
	Local oBrwTrb 	:= Nil //objeto do msselect
	Local oDlg 		:= Nil //objeto do msselect
	Local _aEmpBF1	:= {} //Vetor que armazena as informações da BYX
	Local _nTam		:= 0 //Variavel utilizada para armazenar o tamanho da chave da BF1
	Local _lDel 		:= .F.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define campos do TRB ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aadd(_aStruTrb,{"OK" 		,"C",02,0})
	
	aadd(_aStruTrb,{"MATRICULA" ,"C",TAMSX3("BF1_MATRIC")[1],0})
	
	aadd(_aStruTrb,{"CODIGO"		,"C",TAMSX3("BF1_CODPRO")[1],0})
	
	aadd(_aStruTrb,{"VERSAO"		,"C",TAMSX3("BF1_VERSAO")[1],0})
	
	aadd(_aStruTrb,{"DESCRICAO"	,"C",TAMSX3("BF1_DESPRO")[1],0})
	
	aadd(_aStruTrb,{"DTBASE"	 	,"D",TAMSX3("BF4_DATBAS")[1],0})
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define campos do MsSelect ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	aadd(_aBrowse,{"OK" 			,,"" 				})
	
	aadd(_aBrowse,{"MATRICULA"	,,"Matricula" 	})
	
	aadd(_aBrowse,{"CODIGO"		,,"Cd. Opcional" 	})
	
	aadd(_aBrowse,{"VERSAO"		,,"Versao" 		})
	
	aadd(_aBrowse,{"DESCRICAO"	,,"Ds. Opcional" 	})
	
	aadd(_aBrowse,{"DTBASE"		,,"Data Base" 	})
	
	If Select(_cAliTmp) > 0
		
		_cAliTmp->(DbCloseArea())
		
	Endif
	
	_cArqEmp := CriaTrab(_aStruTrb)
	
	_nTam := TAMSX3("BF1_CODINT")[1]
	_nTam += TAMSX3("BF1_CODEMP")[1]
	_nTam += TAMSX3("BF1_MATRIC")[1]
	
	dbUseArea(.T.,__LocalDriver,_cArqEmp,_cAliTmp)
	
	DbSelectArea("BF1")
	DbSetOrder(1)//BF1_FILIAL+BF1_CODINT+BF1_CODEMP+BF1_MATRIC+BF1_CODPRO
	If DbSeek(xFilial("BF1") + SUBSTR(cNewUsr,1,_nTam))
		
		While !EOF() .And. BF1->(BF1_CODINT+BF1_CODEMP+BF1_MATRIC) == SUBSTR(cNewUsr,1,_nTam)
			
			RecLock(_cAliTmp,.T.)
			
			(_cAliTmp)->OK 			:= SPACE(2)
			
			(_cAliTmp)->MATRICULA 	:= BF1->BF1_MATRIC
			
			(_cAliTmp)->CODIGO 		:= BF1->BF1_CODPRO
			
			(_cAliTmp)->VERSAO 		:= BF1->BF1_VERSAO
			
			(_cAliTmp)->DESCRICAO 	:= POSICIONE("BI3",1,xFilial("BI3")+BF1->BF1_CODINT+BF1->BF1_CODPRO, "BI3_DESCRI")
			
			(_cAliTmp)->DTBASE 		:= BF1->BF1_DATBAS
			
			MsUnlock()
			
			BF1->(DbSkip())
			
		EndDo
		
	EndIf
	
	//---------------------------------------------
	//Montando a tela para visualizar os Opcionais
	//---------------------------------------------
	@ 001,001 TO 400,700 DIALOG oDlg TITLE OemToAnsi("Opcionais da Familia")
	
	@ 015,005 SAY OemToAnsi("Selecione os opcionais que irão permanecer na nova familia: ")
	
	oBrwTrb := MsSelect():New(_cAliTmp,"OK","",_aBrowse,@lInverte,@cMarca,{025,001,170,350})
	
	//oBrwTrb:oBrowse:lCanAllmark := .T.
	
	Eval(oBrwTrb:oBrowse:bGoTop)
	
	oBrwTrb:oBrowse:Refresh()
	
	Activate MsDialog oDlg On Init (EnchoiceBar(oDlg,bOk,bCancel,,)) Centered VALID _lRetorno
	
	(_cAliTmp)->(DbGotop())
	
	If _nOpca == 1
		
		Do While (_cAliTmp)->(!Eof())
			
			If Empty((_cAliTmp)->OK)//se usuario não marcou o registro, o mesmo será deletado.
				
				_lDel := .T.
				
				//--------------------------------------------
				//Deletando os  registros não selecionados
				//--------------------------------------------
				DbSelectArea("BF1")
				DbSetOrder(1) //BF1_FILIAL+BF1_CODINT+BF1_CODEMP+BF1_MATRIC+BF1_CODPRO
				If DbSeek(xFilial("BF1") + SUBSTR(cNewUsr,1,_nTam) + (_cAliTmp)->CODIGO)
					
					BF1->(RecLock("BF1", .F.))
					
					BF1->(DbDelete())
					
					BF1->(MsUnlock())
					
					DbSelectArea("BBY")
					DbSetOrder(1) //BBY_FILIAL+BBY_CODOPE+BBY_CODEMP+BBY_MATRIC+BBY_CODOPC+BBY_VEROPC+BBY_CODFOR+BBY_CODFAI
					If DbSeek(xFilial("BBY") + BF1->(BF1_CODINT+BF1_CODEMP+BF1_MATRIC+BF1_CODPRO) )
						
						BBY->(RecLock("BBY", .F.))
						
						BBY->(DbDelete())
						
						BBY->(MsUnlock())
						
					EndIf
					
					
					//----------------------------
					//Formas Opcionais Familia
					//----------------------------
					DbSelectArea("BK0")
					DbSetOrder(1) //BK0_FILIAL+BK0_CODOPE+BK0_CODEMP+BK0_MATRIC+BK0_CODOPC+BK0_VEROPC
					If DbSeek(xFilial("BK0") + BF1->(BF1_CODINT+BF1_CODEMP+BF1_MATRIC+BF1_CODPRO) )
						
						BK0->(RecLock("BK0", .F.))
						
						BK0->(DbDelete())
						
						BBY->(MsUnlock())
						
					EndIf
					
				EndIf
				
				
			EndIf
			
			(_cAliTmp)->(DbSkip())
			
		EndDo
		
		//-------------------------------------------------------
		//Atualiza Familia, informando que houve transferência
		//-------------------------------------------------------
		If _lDel
			
			BA1->(DbGoTop())
			BA1->(DbSetOrder(2))
			If BA1->(MsSeek(xFilial('BA1') + cNewUsr))
				
				DbSelectArea("BA3")
				DbSetOrder(2) //BA3_FILIAL+BA3_CODPLA+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
				If DbSeek(xFilial("BA3")+BA1->(BA1_CODPLA+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB))
					
					RecLock("BA3", .F.)
					
					BA3->BA3_XPRFTR := "S"
					
					BA3->(MsUnLock())
					
				EndIf
				
			EndIf
			
		EndIf
		
		//-------------------------------------------------------
		//fecha area de trabalho e arquivo temporário criados
		//-------------------------------------------------------
		
		If Select(_cAliTmp) > 0
			
			DbSelectArea(_cAliTmp)
			
			DbCloseArea()
			
			Ferase(_cArqEmp+OrdBagExt())
			
		Endif
		
	EndIf
	
	RestArea(_aAreBBY)
	RestArea(_aAreBA1)
	RestArea(_aAreBF1)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ConvPlano ºAutor  ³Angelo Henrique     º Data ³  11/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Converte planos da CABERJ para os da Prefeitura.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ConvPlano(cPadrao,_nOpc)
	
	Local cSql	:= " "
	Local cRet	:= " "
	
	cSQL := "SELECT " 												+ CRLF
	cSQL += "	PLANO_PREF CD_PREVIRIO, DS_PREVIRIO, "				+ CRLF
	cSQL += "	PLANO_MEDICO CODPLA, TIP_USU, DS_MEDICO"			+ CRLF
	cSQL += "FROM " 													+ CRLF
	cSQL += "	PLANO_PREF_CAB_NV "									+ CRLF
	cSQL += "WHERE "													+ CRLF
	cSQL += "	TRIM(PLANO_MEDICO) = '" + AllTrim(cPadrao) + "'"	+ CRLF
	
	TcQuery cSQL ALIAS "TMPPLA" NEW
	
	dbSelectArea( "TMPPLA" )
	
	If !TMPPLA->(EOF())
		
		If _nOpc = 1
			
			cRet := Trim(TMPPLA->CD_PREVIRIO)
			
		ElseIf _nOpc = 2
			
			cRet := Trim(TMPPLA->DS_MEDICO)
			
		EndIf
		
	EndIf
	
	TMPPLA->(DbCloseArea())
	
Return cRet


Static Function fCaraTabela(cNewUsr, cOldUsr, c_Pref)
	
	Local n_QtdNew := 0
	Local n_QtdOld := 0
	Local n_QtdBtn := 0
	Local n_QtdPla := 0
	
	
	// Verifico quantos planos existem em uma família
	c_Qry := " SELECT DISTINCT BA1_CODPLA "
	c_Qry += " FROM " + retsqlname("BA1") + " "
	c_Qry += " WHERE BA1_FILIAL = ' ' "
	c_Qry += "       AND BA1_CODINT = '" + substr(cOldUsr, 01, 04) + "' "
	c_Qry += "       AND BA1_CODEMP = '" + substr(cOldUsr, 05, 04) + "' "
	c_Qry += "       AND BA1_MATRIC = '" + substr(cOldUsr, 09, 06) + "' " //c_Qry += "       AND AND BA1_DATBLO = ' ' "
	c_Qry += "       AND D_E_L_E_T_ = ' ' "
	
	If Select("TMPQTDPLA") > 0
		
		TMPQTDPLA->(DbCloseArea())
		
	Endif
	
	TcQuery c_Qry ALIAS "TMPQTDPLA" NEW
	
	While TMPQTDPLA->( EOF() )
		
		n_QtdPla++
		
		TMPQTDPLA->( dbSkip() )
		
	EndDo
	
	c_Qry := " SELECT PESQ_RETORNA_QTD_FAIXA(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'2015') QTD_FAIXA "
	c_Qry += " FROM " + retsqlname("BA1") + " "
	c_Qry += " WHERE BA1_FILIAL = ' ' "
	c_Qry += "       AND BA1_CODINT = '" + substr(cOldUsr, 01, 04) + "' "
	c_Qry += "       AND BA1_CODEMP = '" + substr(cOldUsr, 05, 04) + "' "
	c_Qry += "       AND BA1_MATRIC = '" + substr(cOldUsr, 09, 06) + "' "
	c_Qry += "       AND BA1_TIPREG = '" + substr(cOldUsr, 15, 02) + "' "
	c_Qry += "       AND D_E_L_E_T_ = ' ' "
	
	If Select("TMPOLD") > 0
		
		TMPOLD->(DbCloseArea())
		
	Endif
	
	TcQuery c_Qry ALIAS "TMPOLD" NEW
	
	If !TMPOLD->( EOF() )
		
		n_QtdOld := TMPOLD->QTD_FAIXA
		
	EndIf
	
	c_Qry := " SELECT PESQ_RETORNA_QTD_FAIXA(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,'2015') QTD_FAIXA "
	c_Qry += " FROM " + retsqlname("BA1") + " "
	c_Qry += " WHERE BA1_FILIAL = ' ' "
	c_Qry += "       AND BA1_CODINT = '" + substr(cNewUsr, 01, 04) + "' "
	c_Qry += "       AND BA1_CODEMP = '" + substr(cNewUsr, 05, 04) + "' "
	c_Qry += "       AND BA1_MATRIC = '" + substr(cNewUsr, 09, 06) + "' "
	c_Qry += "       AND BA1_TIPREG = '" + substr(cNewUsr, 15, 02) + "' "
	c_Qry += "       AND D_E_L_E_T_ = ' ' "
	
	If Select("TMPNEW") > 0
		
		TMPNEW->(DbCloseArea())
		
	Endif
	
	TcQuery c_Qry ALIAS "TMPNEW" NEW
	
	If !TMPNEW->( EOF() )
		
		n_QtdNew := TMPNEW->QTD_FAIXA
		
	EndIf
	
	BA1->(DbGoTop())
	DbSelectArea("BA1")
	DbSetOrder(2)
	If BA1->(MsSeek(xFilial('BA1') + cNewUsr))
		
		If BA1->BA1_CODEMP $ c_Pref .AND. BA1->BA1_CODPLA $('0112||0113') .AND. BA1->BA1_TIPUSU <> 'T'
			
			
			BA1->(Reclock('BA1',.F.))
			
			BA1->BA1_CODPLA := IIF( BA1->BA1_CODPLA== '0112', '0114', '0115' )
			
			BA1->(MsUnlock())
			
		EndIf
		
		c_Qry := " SELECT BTN_CODFAI, BTN_IDAINI, BTN_IDAFIN, BTN_VALFAI, BTN_ANOMES, BTN_VLRANT, BTN_TABVLD "
		c_Qry += " FROM " + RETSQLNAME("BTN") + " BTN "
		c_Qry += " WHERE BTN_FILIAL = ' ' "
		c_Qry += "       AND BTN_CODIGO = '"+ BA1->BA1_CODINT + BA1->BA1_CODEMP + "' "
		c_Qry += "       AND BTN_NUMCON = '" + BA1->BA1_CONEMP + "' "
		c_Qry += "       AND BTN_SUBCON = '" + BA1->BA1_SUBCON + "' "
		c_Qry += "       AND BTN_CODPRO = '" + BA1->BA1_CODPLA + "' "
		c_Qry += "       AND BTN_TABVLD = ' ' "
		c_Qry += "       AND BTN.D_E_L_E_T_ = ' ' "
		
		c_Qry += " ORDER BY BTN_IDAINI "
		
		If Select("TMPBTN") > 0
			
			TMPBTN->( DbCloseArea() )
			
		Endif
		
		TcQuery c_Qry ALIAS "TMPBTN" NEW
		
		Count to n_QtdBtn
		
		TMPBTN->( dbGoTop() )
		
		//Inclui as Faixas de Cobranca
		c_CodFDK := '000'
		c_CodFBU := '000'
		
		l_Primbbu 	:= .T.
		l_Primbdk 	:= .T.
		l_Bdk 		:= .F.
		
		While !TMPBTN->( EOF() )
			// verificar se precisa dessa regra
			If n_QtdNew > 0 .OR. BA1->BA1_CODEMP $ c_Pref   .or. BA1->BA1_CODEMP $ ('0001||0002||0005')  .or. .T.
				
				c_CodFDK := soma1( c_CodFDK )
				
				iF  l_Primbdk
					
					l_Primbdk := .F.
					
					dbSelectArea("BDK")
					dbSetOrder(1)
					dbSeek(xfilial("BDK") +  ba1->ba1_codint+ ba1->ba1_codemp + ba1->ba1_matric + ba1->ba1_tipreg )
					
					While !BDK->( EOF() ) .AND. BDK->( BDK_CODINT+BDK_CODEMP+BDK_MATRIC+BDK_TIPREG) == ba1->ba1_codint+ ba1->ba1_codemp + ba1->ba1_matric + ba1->ba1_tipreg
						dbSelectArea("BDK")
						dbSetOrder(1)
						dbSeek(xfilial("BDK") +  ba1->ba1_codint+ ba1->ba1_codemp + ba1->ba1_matric + ba1->ba1_tipreg )
						l_Bdk := .T.
						BDK->(dbDelete( ))
						
						BDK->( dbSkip() )
						
					EndDo
					
				EndIf
				
				If !( BA1->BA1_CODEMP $ ('0001||0002||0005'))  .and. l_Bdk
					
					DbSelectArea("BDK")
					DbSetOrder(2)//BDK_FILIAL+BDK_CODINT+BDK_CODEMP+BDK_MATRIC+BDK_TIPREG
					BDK->(RecLock("BDK",.T.))
					
					BDK->BDK_FILIAL 	:= xFilial("BDK")
					BDK->BDK_CODFAI 	:= c_CodFDK
					BDK->BDK_IDAINI 	:= TMPBTN->BTN_IDAINI
					BDK->BDK_IDAFIN 	:= TMPBTN->BTN_IDAFIN
					BDK->BDK_VALOR 		:= TMPBTN->BTN_VALFAI
					BDK->BDK_CODINT 	:= BA1->BA1_CODINT
					BDK->BDK_CODEMP 	:= BA1->BA1_CODEMP
					BDK->BDK_MATRIC 	:= BA1->BA1_MATRIC
					BDK->BDK_TIPREG		:= BA1->BA1_TIPREG
					BDK->BDK_ANOMES 	:= TMPBTN->BTN_ANOMES
					BDK->BDK_VLRANT 	:= TMPBTN->BTN_VLRANT
					BDK->BDK_RGIMP 		:= "1" //IMPORTADO 1=SIM E 2=NAO
					//	BDK->BDK_TABVLD 	:= stod(TMPBTN->BTN_TABVLD)
					
					BDK->(MsUnlock())
					
				EndIf
				
			EndIf
			
			If BA1->BA1_TIPREG == '00'
				
				c_CodFBU := soma1( c_CodFBU )
				
				iF BBU->(DbSeek(xFilial("BBU")+BA1->BA1_CODINT+BA1->BA1_CODEMP+BA1->BA1_MATRIC)) .AND. l_Primbbu
					
					l_Primbbu := .F.
					
					While !BBU->( EOF() ) .AND. BBU->( BBU_CODOPE+BBU_CODEMP+BBU_MATRIC) == ba1->ba1_codint+ ba1->ba1_codemp + ba1->ba1_matric
						
						Reclock( "BBU" , .F. , .T.)
						BBU->(dbDelete( ))
						MsUnlock()
						
						BBU->( dbSkip() )
						
					EndDo
					
				EndIf
				
				DbSelectArea("BBU")
				DbSetOrder(2)//BDK_FILIAL+BDK_CODINT+BDK_CODEMP+BDK_MATRIC+BDK_TIPREG
				BBU->(RecLock("BBU",.T.))
				
				BBU->BBU_FILIAL 	:= xFilial("BDK")
				BBU->BBU_CODFAI 	:= c_CodFBU
				BBU->BBU_IDAINI 	:= TMPBTN->BTN_IDAINI
				BBU->BBU_IDAFIN 	:= TMPBTN->BTN_IDAFIN
				BBU->BBU_VALFAI		:= TMPBTN->BTN_VALFAI
				BBU->BBU_CODOPE 	:= BA1->BA1_CODINT
				BBU->BBU_CODEMP 	:= BA1->BA1_CODEMP
				BBU->BBU_MATRIC 	:= BA1->BA1_MATRIC
				BBU->BBU_ANOMES 	:= TMPBTN->BTN_ANOMES
				BBU->BBU_VLRANT 	:= TMPBTN->BTN_VLRANT
				BBU->BBU_CODFOR     := '101'
				//BBU->BBU_TABVLD 	:= TMPBTN->BTN_TABVLD
				
				BBU->(MsUnlock())
				
			EndIf
			
			TMPBTN->(DbSkip())
			
		Enddo
		
		If n_QtdNew <> n_QtdBtn .AND. BA1->BA1_MUDFAI == "0"
			
			Alert("Quantidade de faixas do usuário " + BA1->BA1_NOMUSR + " está diferente no destino e o mesmo possuia faixa presa na família anterior. Favor verificar o cadastro")
			
			BA1->(Reclock('BA1',.F.))
			
			BA1->BA1_MUDFAI := "1"
			
			BA1->(MsUnlock())
			
		EndIf
		
	EndIf
	
Return



/*/{Protheus.doc} AtuCrt
Rotina responsável pela correção da via de carteiras do beneficiário
Em alguns momentos após a virada para a versão 12 o protheus começou a
se perder e a não gerar a carteira do beneficiário
@type function
@author angelo.cassago
@since 25/03/2020
@version 1.0
@return ${return}, ${return_description}
@example
(examples)
@see (links_or_references)
/*/

Static Function AtuCrt()
	
	Local cOldMat 	:= PARAMIXB[1]
	Local cNewMat 	:= PARAMIXB[2]
	Local cOldUsr 	:= PARAMIXB[3]
	Local cNewUsr 	:= PARAMIXB[4]
	
	Local _aArBA1	:= BA1->(GetArea())
	Local _aArBED	:= BED->(GetArea()) //Cabeçalho do Lote de Cobrancas
	Local _aArBDE	:= BDE->(GetArea()) //Itens do lote de Cobrança
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³cOldMat		Matricula Familia de Origem	 ³
	//³cNewMat		Matricula Familia de Destino ³
	//³cOldUsr		Matricula Usuario Antiga	 ³
	//³cNewUsr		Matricula Usuario Nova Gerada³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//---------------------------------------------------------------------------------------
	//Varrer matricula antiga e apagar seu histórico de Carteiras
	//Liberando assim as validaçoes incorretas que o sistema utiliza na nova matricula.
	//Pois o sistema não varre pela nova matricula, pesquisa CPF entre outras coisas.
	//---------------------------------------------------------------------------------------
	DbSelectArea("BED")
	DbSetOrder(1) //BED_FILIAL+BED_CODINT+BED_CODEMP+BED_MATRIC+BED_TIPREG+BED_DIGITO+BED_FATUR+BED_CONEMP+BED_VERCON+BED_SUBCON+BED_VERSUB+BED_CDIDEN+BED_STATUS
	If DbSeek(xFilial("BED") +  Replace(cOldMat,".",""))
		
		While !(Eof()) .And.  Replace(cOldMat,".","") = BED->(BED_CODINT+BED_CODEMP+BED_MATRIC)
			
			BED->(RecLock("BED", .F.))
			
			BED->(DbDelete())
			
			BED->(MsUnlock())
			
			BED->(DbSkip())
			
		EndDo
		
	EndIf
	
	//-------------------------------------------------------------------------------------------------
	//Atuando na nova matricula para remover qualquer resquicio de carteria da matricula anterior
	//-------------------------------------------------------------------------------------------------
	DbSelectArea("BA1")
	DbSetOrder(2) //BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
	If DbSeek(xFilial("BA1") + Replace(cNewMat,".",""))
		
		While !(EOF()) .And. Replace(cNewMat,".","") == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)
			
			BA1->(RecLock("BA1", .F.))
			
			BA1->BA1_CDIDEN := " "
			BA1->BA1_IMAGE	:= "ENABLE"
			BA1->BA1_VIACAR	:= 0	
			BA1->BA1_DTVLCR := CTOD(" / / ")
			
			BA1->(MsUnlock())
			
			BA1->(DbSkip())
			
		EndDo
		
	EndIf
	
	RestArea(_aArBDE)
	RestArea(_aArBED)
	RestArea(_aArBA1)
	
Return
