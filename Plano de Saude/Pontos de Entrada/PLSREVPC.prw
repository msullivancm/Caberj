#include "RWMAKE.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PLSREVPC º Autor ³ Angelo Sperandio      º Data ³ 18/12/06 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Ponto de entrada apos valorizacao do pagamento/cobranca.   º±±
±±º          ³ Ultimo ponto							                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PLSREVPC

	Local nInd := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local cTipGui		:= ParamIxb[1]
	Local lValorPagto 	:= ParamIxb[3]
	Local lValorCobr	:= ParamIxb[4]
	Local dDatPro		:= StoD("")
	Local aAreaBAU		:= BAU->(GetArea())
	Local aAreaBD6		:= BD6->(GetArea())
	Local aAreaBD7		:= BD7->(GetArea())
	Local aAreaBD4		:= BD4->(GetArea())
	Local aAreaBLD		:= BLD->(GetArea())

	Local nPerPac		:= 0
	Local nVlrAnt		:= 0
	Local nVlrNovo		:= 0
	Local aRdas			:= {}
	Local aDadUsr		:= PLSGETUSR()
	Local lCompRea		:= .F.
	Local aAux			:= {}
	Local cChave		:= ""
	Local cPadCon		:= Iif(BD6->BD6_ORIMOV=="2",BE4->BE4_PADCON,"")
	Local cCodPad		:= ""
	Local cCodPro		:= ""
	Local cHorPro		:= ""
	Local cPadInt		:= ""
	Local cRegAte		:= ""
	Local aCri			:= {}
	Local aArBD6
	Local aSeqPac		:= {}
	Local lCodPac		:= .F.
	Local nVlrPgBD7		:= 0

	Local cChaveGui		:= ""
	Local _cChvBD6		:= BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) //Angelo Henrique - Data: 14/08/2017

	Local nDifData		:= 0
	Local cCodBlo		:= ""
	Local cDesBlo		:= ""
	
	If cTipGui == "03"
		cChaveGui := PLSINTPAD()+BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)
	Else
		cChaveGui := PLSINTPAD()+BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)
	Endif

	//--------------------------------------------------------------------------------------
	//Inicio - Angelo Henrique - Data: 31/07/2018											|
	//--------------------------------------------------------------------------------------
	// RDM 302 / 2018
	//--------------------------------------------------------------------------------------
	// Projeto - Valoração do Brasíndice – Acrescimento/Desconto.							|
	//--------------------------------------------------------------------------------------
	// A Rotina Abaixo irá atualizar campos na BD6 e na BD7:								|
	// DESCONTO:						| ACRESCIMO 										|
	// BD6_PERDES						| BD6_MAJORA										|
	// BD6_VLRDES						|													|
	// BD6_TABDES						|													|
	//--------------------------------------------------------------------------------------
	// Campos BD7:																			|
	// DESCONTO:						| ACRESCIMO 										|
	// BD7_DSCCLI						| BD7_MAJORA 										|										|
	//--------------------------------------------------------------------------------------

	BD6->(DbGoTop())
	DbSelectArea("BD6")
	DbSetOrder(1) //BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO (Utilizando até o campo BD6_ORIMOV)
	If DbSeek(_cChvBD6)

		U_CABA005()

	EndIf
	
	//--------------------------------------------------------------------------------------
	//Fim - Angelo Henrique - Data: 31/07/2018												|
	//--------------------------------------------------------------------------------------		

	//--------------------------------------------------------------------------------------
	//Inicio - Fabio Bianchini - Data: 10/12/2019											|
	//--------------------------------------------------------------------------------------
	// DECISÃO DE FORUM EM 14/10/2019 - A PARTIR DE 01/11/2019 COBRAR COPART REFERENTE A    |
	// 12 MESES ENTRE ADATA DE PROCESSAMENTO E A DATA DO EVENTO. SOMENTE MATER E  			|
	// AFINIDADE(CABERJ)																	|
	//--------------------------------------------------------------------------------------
	
	u_Bloq12M(_cChvBD6)

	//--------------------------------------------------------------------------------------
	//Fim - Fabio Bianchini - Data: 10/12/2019												|
	//--------------------------------------------------------------------------------------		

	//--------------------------------------------------------------------------------------
	//Inicio - Fabio Bianchini - Data: 17/03/2020											|
	//--------------------------------------------------------------------------------------
	// Checar se BD6 é SEM copart e se possui consolidação sem cobrança					    |
	//--------------------------------------------------------------------------------------	
	u_ChkCopBDH(_cChvBD6)
	//--------------------------------------------------------------------------------------
	//Fim - Fabio Bianchini - Data: 17/03/2020												|
	//--------------------------------------------------------------------------------------	

	RestArea(aAreaBAU)
	RestArea(aAreaBD6)
	RestArea(aAreaBD7)
	RestArea(aAreaBD4)
	RestArea(aAreaBLD)

Return Nil
