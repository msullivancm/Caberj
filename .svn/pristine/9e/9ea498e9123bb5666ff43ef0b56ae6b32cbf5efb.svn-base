#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
#Define CRLF Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL627EXC  ºAutor  ³Microsiga           º Data ³  13/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para remover os titulos excluidos do siste-º±±
±±º          ³ma, na exclusao do lote de cobranca.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL627EXC()

	Local nCont := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

	Local lRet			:= .T. //Caso retorne .F., nao exclui o titulo...
	Local aAreaBSQ		:= BSQ->(GetArea())
	Local aAreaSE1		:= SE1->(GetArea())
	Local aAreaBDC		:= BDC->(GetArea())
	Local aDeletar		:= {}
	Local aGerSeq1		:= {}
	Local _cSQL 	  	:= ""
	Local nRecPDDAnt  	:= 0
	Local cAliQry		:= GetNextAlias()
	Local _cQuery		:= ""

	//------------------------------------------------------------------------------
	//Angelo Henrique - Data: 11/04/2022
	//------------------------------------------------------------------------------
	//Validação no momento de excluir o lote que possui nota transmitida
	//Chamado - 85975
	//------------------------------------------------------------------------------
	//Sendo assim, não poderá executar nenhuma das funções ja desenvolvidas que são
	//executadas durante o processo de exclusão
	//------------------------------------------------------------------------------
	_cQuery += " SELECT                                                     " + CRLF
	_cQuery += "     NVL(SF2.F2_DOC,' ') DOC,                               " + CRLF
	_cQuery += "     NVL(SF2.F2_SERIE,' ') SERIE,                           " + CRLF
	_cQuery += "     NVL(SF2.F2_CODNFE,' ') CODNFE                          " + CRLF
	_cQuery += " FROM                                                       " + CRLF
	_cQuery += "     " + RETSQLNAME("BDC") + " BDC                          " + CRLF
	_cQuery += "                                                            " + CRLF
	_cQuery += "     INNER JOIN                                             " + CRLF
	_cQuery += "         " + RETSQLNAME("SE1") + " SE1                      " + CRLF
	_cQuery += "     ON                                                     " + CRLF
	_cQuery += "         E1_FILIAL = '" + xFilial("SE1") + "'               " + CRLF
	_cQuery += "         AND E1_PLNUCOB = BDC.BDC_CODOPE||BDC.BDC_NUMERO	" + CRLF
	_cQuery += "         AND SE1.D_E_L_E_T_ = ' '                           " + CRLF
	_cQuery += "                                                            " + CRLF
	_cQuery += "     INNER JOIN                                             " + CRLF
	_cQuery += "         " + RETSQLNAME("SF2") + " SF2                      " + CRLF
	_cQuery += "     ON                                                     " + CRLF
	_cQuery += "         SF2.F2_FILIAL 		= SE1.E1_FILIAL                 " + CRLF
	_cQuery += "         AND SF2.F2_DOC 	= SE1.E1_XDOCNF                 " + CRLF
	_cQuery += "         AND SF2.F2_SERIE 	= SE1.E1_XSERNF                 " + CRLF
	_cQuery += "         AND SF2.F2_CLIENTE = SE1.E1_CLIENTE                " + CRLF
	_cQuery += "         AND SF2.F2_LOJA 	= SE1.E1_LOJA                   " + CRLF
	_cQuery += "         AND SF2.D_E_L_E_T_ = ' '                           " + CRLF
	_cQuery += "                                                            " + CRLF
	_cQuery += " WHERE                                                      " + CRLF
	_cQuery += "     BDC.BDC_FILIAL 	= '" + xFilial("BDC") + "'          " + CRLF
	_cQuery += "     AND BDC.BDC_CODOPE = '" + BDC->BDC_CODOPE + "'         " + CRLF
	_cQuery += "     AND BDC.BDC_NUMERO = '" + BDC->BDC_NUMERO + "'         " + CRLF
	_cQuery += "     AND BDC.D_E_L_E_T_ = ' '                               " + CRLF

	If Select(cAliQry)>0
		(cAliQry)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),cAliQry,.T.,.T.)

	DbSelectArea(cAliQry)

	If !((cAliQry)->(Eof()))

		If !Empty(AllTrim((cAliQry)->CODNFE))

			lRet := .F.

		EndIf

	EndIf

	If Select(cAliQry)>0
		(cAliQry)->(DbCloseArea())
	EndIf

	If lRet

		BSQ->(dbOrderNickName("BSQ_YNMLOT"))
		If BSQ->(MsSeek(xFilial("BSQ")+BDC->BDC_NUMERO))

			While !BSQ->(Eof()) .And. BSQ->BSQ_YNMLOT == BDC->BDC_NUMERO
				If !Empty(BSQ->BSQ_YNMLOT)
					aadd(aDeletar,BSQ->(RecNo()))
					BSQ->(DbSkip())
				Endif
			Enddo

		Endif

		For nCont := 1 to Len(aDeletar)
			BSQ->(DbGoTo(aDeletar[nCont]))
			BSQ->(RecLock("BSQ",.F.))
			BSQ->(DbDelete())
			BSQ->(MsUnlock())
		Next

		aDeletar := {}

		RestArea(aAreaBSQ)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nos casos de parcelamento, incluir titulos provisorios cfme solicitado...³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		_cSQL := " SELECT BSQ_PREORI, BSQ_NUMORI, BSQ_PARORI, BSQ_TIPORI, BSQ_VALOR, BSQ_ZNATUR, BSQ_ZCLIEN, BSQ_ZLOJA, BSQ_CONEMP, BSQ_VERCON, BSQ_MES, BSQ_ANO, "
		_cSQL += " BSQ_SUBCON, BSQ_VERSUB, BSQ_ZEMISS, BSQ_ZEMIS1, BSQ_ZHIST, BSQ_ZVENCT, BSQ_ZVENRE, BSQ_ZJUROS, BSQ_CODINT, BSQ_CODEMP, BSQ_MATRIC "
		_cSQL += " FROM "+RetSQLName("BSQ")+" BSQ "
		_cSQL += " WHERE BSQ_FILIAL = '"+xFilial("BSQ")+"' "
		_cSQL += " AND BSQ_NUMCOB = '"+BDC->(BDC_CODOPE+BDC_NUMERO)+"' "
		_cSQL += " AND BSQ_CODLAN = '991' " //Conforme informado pelo autor da rotina de parcelamento (chumbado no fonte).
		_cSQL += " AND BSQ_PREORI <> ' ' "
		_cSQL += " AND BSQ_NUMORI <> ' ' "
		_cSQL += " AND BSQ_PARORI <> ' ' "
		_cSQL += " AND BSQ_TIPORI <> ' ' "
		_cSQL += " AND BSQ.D_E_L_E_T_ = ' ' "

		PlsQuery(_cSQL,"TRB627EXC")

		While !TRB627EXC->(Eof())

			If ! SE1->(MsSeek(xFilial("SE1")+TRB627EXC->(BSQ_PREORI+BSQ_NUMORI+BSQ_PARORI+BSQ_TIPORI)))

				aGerSeq1 :={	{"E1_PREFIXO" ,TRB627EXC->BSQ_PREORI,Nil},;
					{"E1_NUM"     ,TRB627EXC->BSQ_NUMORI,Nil},;
					{"E1_PARCELA" ,TRB627EXC->BSQ_PARORI,Nil},;
					{"E1_TIPO"    ,TRB627EXC->BSQ_TIPORI,Nil},;
					{"E1_VALOR"   ,TRB627EXC->BSQ_VALOR ,Nil},;
					{"E1_CODINT"  ,TRB627EXC->BSQ_CODINT,Nil},;
					{"E1_CODEMP"  ,TRB627EXC->BSQ_CODEMP,Nil},;
					{"E1_CONEMP"  ,TRB627EXC->BSQ_CONEMP,Nil},;
					{"E1_VERCON"  ,TRB627EXC->BSQ_VERCON,Nil},;
					{"E1_SUBCON"  ,TRB627EXC->BSQ_SUBCON,Nil},;
					{"E1_VERSUB"  ,TRB627EXC->BSQ_VERSUB,Nil},;
					{"E1_MATRIC"  ,TRB627EXC->BSQ_MATRIC,Nil},;
					{"E1_NATUREZ" ,TRB627EXC->BSQ_ZNATUR,Nil},;
					{"E1_CLIENTE" ,TRB627EXC->BSQ_ZCLIEN,Nil},;
					{"E1_LOJA"    ,TRB627EXC->BSQ_ZLOJA ,Nil},;
					{"E1_EMISSAO" ,TRB627EXC->BSQ_ZEMISS,Nil},;
					{"E1_EMIS1"   ,TRB627EXC->BSQ_ZEMIS1,Nil},;
					{"E1_HIST"    ,TRB627EXC->BSQ_ZHIST ,Nil},;
					{"E1_VENCTO"  ,TRB627EXC->BSQ_ZVENCT,Nil},;
					{"E1_VENCREA" ,TRB627EXC->BSQ_ZVENRE,Nil},;
					{"E1_MESBASE" ,TRB627EXC->BSQ_MES   ,Nil},;
					{"E1_ANOBASE" ,TRB627EXC->BSQ_ANO   ,Nil},;
					{"E1_PORCJUR" ,TRB627EXC->BSQ_ZJUROS,Nil} 	}

				lMsErroAuto := .F.
				MsExecAuto({|x,y| Fina040(x,y)},aGerSeq1,3)
				If lMsErroAuto
					DisarmTransaction()
					MostraErro()
				Endif
			Endif

			TRB627EXC->(DbSkip())

		Enddo

		TRB627EXC->(DbCloseArea())

		RestArea( aAreaSE1 )
		RestArea( aAreaBDC )

		//BIANCHINI - 01/10/2019
		//Limpar Vinculo com PDN ao Excluir o Lote
		//Não entrar se chamada vier do Reembolso
		If AllTrim(FunName()) <> 'PLSA001'

			aAreaBSQ 	  := BSQ->(GetArea())

			_cSQL := " SELECT BSQ_FILIAL " + CRLF
			_cSQL += "  	, BSQ_CODSEQ " + CRLF
			_cSQL += "   	, BSQ_USUARI " + CRLF
			_cSQL += "   	, BSQ_CODINT " + CRLF
			_cSQL += "   	, BSQ_CODEMP " + CRLF
			_cSQL += "  	, BSQ_MATRIC " + CRLF
			_cSQL += "   	, BSQ_CONEMP " + CRLF
			_cSQL += "   	, BSQ_VERCON " + CRLF
			_cSQL += "   	, BSQ_SUBCON " + CRLF
			_cSQL += "   	, BSQ_VERSUB " + CRLF
			_cSQL += "   	, BSQ_ANO 	 " + CRLF
			_cSQL += "   	, BSQ_MES	 " + CRLF
			_cSQL += "   	, BSQ_CODLAN " + CRLF
			_cSQL += "   	, BSQ_VALOR  " + CRLF
			_cSQL += "		, BSQ_NUMCOB " + CRLF
			_cSQL += "   	, BSQ.R_E_C_N_O_ RECBSQ  " + CRLF
			_cSQL += "   	, PDN.PDN_MATRIC  " + CRLF
			_cSQL += "   	, PDN.PDN_COMPET  " + CRLF
			_cSQL += "   	, PDN.PDN_LANCRE  " + CRLF
			_cSQL += "  	, PDN.PDN_VLRCRE  " + CRLF
			_cSQL += "   	, PDN.PDN_BSQCRE  " + CRLF
			_cSQL += "   	, PDN.PDN_LANDEB  " + CRLF
			_cSQL += "   	, PDN.PDN_VLRDEB  " + CRLF
			_cSQL += "   	, PDN.PDN_BSQDEB  " + CRLF
			_cSQL += "   	, PDN.PDN_LANSLD  " + CRLF
			_cSQL += "   	, PDN.PDN_SALDO   " + CRLF
			_cSQL += "   	, PDN.PDN_BSQSLD  " + CRLF
			_cSQL += "   	, PDN.PDN_SEQUEN  " + CRLF
			_cSQL += "   	, PDN.PDN_LOTCOB  " + CRLF
			_cSQL += "   	, PDN.R_E_C_N_O_ RECPDN " + CRLF
			_cSQL += "   FROM "+RetSQLName("BSQ")+" BSQ "  + CRLF
			_cSQL += "      , "+RetSQLName("PDN")+" PDN "  + CRLF
			_cSQL += "  WHERE BSQ_FILIAL = '"+xFilial("BSQ")+"' " + CRLF
			_cSQL += "    AND PDN_FILIAL = '"+xFilial("PDN")+"' " + CRLF
			_cSQL += "    AND PDN_MATRIC = SUBSTR(BSQ_USUARI,1,16) " + CRLF
			_cSQL += "    AND ( 								   " + CRLF
			_cSQL += "          (PDN_LANCRE = BSQ_CODLAN		   " + CRLF
			_cSQL += "           AND PDN_VLRCRE = BSQ_VALOR)	   " + CRLF
			_cSQL += "           OR								   " + CRLF
			_cSQL += "          (PDN_LANDEB = BSQ_CODLAN		   " + CRLF
			_cSQL += "           AND PDN_VLRDEB = BSQ_VALOR)	   " + CRLF
			_cSQL += "           OR								   " + CRLF
			_cSQL += "          (PDN_LANSLD = BSQ_CODLAN		   " + CRLF
			_cSQL += "           AND PDN_VLRDEB = BSQ_VALOR)	   " + CRLF
			_cSQL += "        )									   " + CRLF
			_cSQL += "    AND PDN_LOTCOB = '"+BDC->(BDC_CODOPE+BDC_NUMERO)+"' " + CRLF
			_cSQL += "    AND PDN_LOTCOB = BSQ_NUMCOB 						  " + CRLF
			_cSQL += "    AND BSQ_CODLAN IN ('9A8','9A9','9AA') 			  " + CRLF
			_cSQL += "    AND BSQ_ANO||BSQ_MES <= '" + BDC->BDC_ANOFIM + BDC->BDC_MESFIM + "'" + CRLF
			_cSQL += "    AND BSQ.D_E_L_E_T_ = ' ' " + CRLF
			_cSQL += "    AND PDN.D_E_L_E_T_ = ' ' " + CRLF

			PlsQuery(_cSQL,"TRB627PDN")

			nRecPDDAnt := 0

			While !TRB627PDN->(Eof())
				If nRecPDDAnt <> TRB627PDN->RECPDN
					DbSelectArea("PDN")
					PDN->(DbGoTo(TRB627PDN->RECPDN))
					PDN->(RecLock("PDN",.F.))
					PDN->PDN_LOTCOB := ' '
					PDN->(MsUnlock())
					PDN->(DbCloseArea())
					nRecPDDAnt := TRB627PDN->RECPDN
				Endif
				TRB627PDN->(DbSkip())
			Enddo
			TRB627PDN->(DbCloseArea())

			RestArea(aAreaBSQ)
		Endif

	Else

		Aviso("Atenção","Lote não pode ser excluído pois possui nota transmitida.",{"OK"})

	EndIf


Return lRet
