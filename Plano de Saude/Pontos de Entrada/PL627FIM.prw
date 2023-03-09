#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

#Define CRLF Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL627FIM  ºAutor  ³Microsiga           º Data ³  13/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para alterar a forma de cobranca apos a    º±±
±±º          ³geracao de titulos, conforme regra da operadora...          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºDesc.     ³Angelo  Henrique - Data: 11/01/2023    					  º±±
±±º          ³Removido processo de vacinas, o processo foi levado para a  º±±
±±º          ³consolidação PLSA180AC, acelerando assim a cobrança		  º±±
±±º          ³Para consulta favor pegar no SVN a versão anterior    	  º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PL627FIM()

	Local aArea			:= GetArea()
	Local aAreaBDF		:= BDF->(GetArea())
	Local aAreaSE1		:= SE1->(GetArea())
	Local aAreaBM1		:= BM1->(GetArea())
	Local aAreaBSQ		:= BSQ->(GetArea())
	Local lRet			:= .T.

	Private cCodEmpCMB	:= GetNewPar("MV_XCOBRCC",'0325')
	Private lCMB		:= .F.

	BDF->(DbSetOrder(1))
	SE1->(DbSetOrder(1))
	BM1->(DbSetOrder(3))

	lCMB := BM1->BM1_CODEMP == cCodEmpCMB

	If lCMB
		MsgRun("Atualizando Conta Corrente(PDN)...",, {|| AjusCCPDN(),CLR_HBLUE})
	Endif

	//--------------------------------------------------------------------------------------//
	//Angelo Henrique - Data:02/12/2020														//
	//--------------------------------------------------------------------------------------//
	//Rotina de correção dos novos lançamentos que não preenchem os campos na BSQ			//
	//--------------------------------------------------------------------------------------//
	AtuLanc()

	RestArea(aArea)
	RestArea(aAreaSE1)
	RestArea(aAreaBDF)
	RestArea(aAreaBM1)
	RestArea(aAreaBSQ)

Return lRet

/**************************************************************************************************/
/************************ ADEQUAÇÕES PARA FATURAMENTO CASA DA MOEDA (0325) - INICIO ***************/
/**************************************************************************************************/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjusCCPDN ºAutor  ³Microsiga           º Data ³  27/09/19   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para atualizar a Conta corrente de Saldos de Copart  º±±
±±º          ³Modelo implementado para CMB - Casa da Moeda				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjusCCPDN()

	Local _cSQL			:= ""
	Local lRet			:= .T.
	Local aAreaBSQ		:= BSQ->(GetArea())
	Local nRecPDDAnt	:= 0

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
	_cSQL += "    AND PDN_LOTCOB = ' '	   				   " + CRLF
	_cSQL += "    AND BSQ_NUMCOB = '"+M->(BDC_CODOPE+BDC_NUMERO)+"' " + CRLF
	_cSQL += "    AND BSQ_CODLAN IN ('9A8','9A9','9AA') " + CRLF
	_cSQL += "    AND BSQ_ANO||BSQ_MES <= '" + M->BDC_ANOFIM + M->BDC_MESFIM + "'" + CRLF
	_cSQL += "    AND BSQ.D_E_L_E_T_ = ' ' " + CRLF
	_cSQL += "    AND PDN.D_E_L_E_T_ = ' ' " + CRLF

	PlsQuery(_cSQL,"TRB627PDN")

	nRecPDDAnt := 0

	While !TRB627PDN->(Eof())

		If nRecPDDAnt <> TRB627PDN->RECPDN

			DbSelectArea("PDN")
			PDN->(DbGoTo(TRB627PDN->RECPDN))

			PDN->(RecLock("PDN",.F.))
			PDN->PDN_LOTCOB := M->(BDC_CODOPE+BDC_NUMERO)
			PDN->(MsUnlock())

			PDN->(DbCloseArea())
			nRecPDDAnt := TRB627PDN->RECPDN
		Endif
		TRB627PDN->(DbSkip())
	Enddo
	TRB627PDN->(DbCloseArea())

	RestArea(aAreaBSQ)

Return lRet


//-------------------------------------------------------------------
/*/{Protheus.doc} function AtuLanc()
Rotina para forçar a atualização correta dos novos lançamentos criados
após a virada para a R27
@author  Angelo Henrique
@since   02/12/2020
@version 1.0
@type function
/*/
//-------------------------------------------------------------------
Static Function AtuLanc()

	Local _aArea	:= GetArea()
	Local _aArBSQ	:= BSQ->(GetArea())
	Local _cAlias	:= GetNextAlias()
	Local _cAlias1	:= GetNextAlias()
	Local _cSQL		:= ""

	_cSQL := " SELECT 														" + CRLF
	_cSQL += " 	BSQ.R_E_C_N_O_ AS BSQREC,									" + CRLF
	_cSQL += " 	BM1.BM1_PREFIX, 											" + CRLF
	_cSQL += " 	BM1.BM1_NUMTIT, 											" + CRLF
	_cSQL += " 	BM1.BM1_PARCEL, 											" + CRLF
	_cSQL += " 	BM1.BM1_TIPTIT												" + CRLF
	_cSQL += " FROM 														" + CRLF
	_cSQL += " 	" + RetSqlName("BSQ") + " BSQ								" + CRLF
	_cSQL += " 		INNER JOIN 												" + CRLF
	_cSQL += "		" + RetSqlName("BM1") + " BM1							" + CRLF
	_cSQL += " 		ON 														" + CRLF
	_cSQL += " 		(    													" + CRLF
	_cSQL += " 			BM1.BM1_FILIAL 		= BSQ.BSQ_FILIAL				" + CRLF
	_cSQL += " 			AND BM1.BM1_MATUSU 	= BSQ.BSQ_USUARI				" + CRLF
	_cSQL += " 			AND BM1.BM1_PLNUCO 	= BSQ.BSQ_NUMCOB				" + CRLF
	_cSQL += " 			AND BM1.BM1_ALIAS  	= 'BSQ'							" + CRLF
	_cSQL += " 			AND BM1.BM1_ORIGEM 	= BSQ.BSQ_CODSEQ				" + CRLF
	_cSQL += " 		)														" + CRLF
	_cSQL += " WHERE 														" + CRLF
	_cSQL += " 	BSQ.D_E_L_E_T_ = ' ' 										" + CRLF
	_cSQL += " 	AND BM1.D_E_L_E_T_ = ' '									" + CRLF
	_cSQL += " 	AND BSQ.BSQ_FILIAL = '" + xFilial("BSQ") + "'				" + CRLF
	_cSQL += " 	AND BSQ.BSQ_NUMCOB = '" + M->(BDC_CODOPE+BDC_NUMERO) + "'	" + CRLF
	_cSQL += " 	AND (   													" + CRLF
	_cSQL += " 			BSQ.BSQ_PREFIX <> BM1_PREFIX						" + CRLF
	_cSQL += " 			OR BSQ.BSQ_NUMTIT <> BM1_NUMTIT						" + CRLF
	_cSQL += " 			OR BSQ.BSQ_PARCEL <> BM1_PARCEL						" + CRLF
	_cSQL += " 			OR BSQ.BSQ_TIPTIT <> BM1_TIPTIT						" + CRLF
	_cSQL += " 		)														" + CRLF

	If Select(_cAlias) > 0
		dbSelectArea(_cAlias)
		dbclosearea()
	Endif

	PlsQuery(_cSQL,_cAlias)

	While (_cAlias)->(!Eof())

		BSQ->(DbGoTo( (_cAlias)->BSQREC ))

		BSQ->(RecLock("BSQ",.F.))
		BSQ->BSQ_PREFIX  := (_cAlias)->BM1_PREFIX
		BSQ->BSQ_NUMTIT  := (_cAlias)->BM1_NUMTIT
		BSQ->BSQ_PARCEL  := (_cAlias)->BM1_PARCEL
		BSQ->BSQ_TIPTIT  := (_cAlias)->BM1_TIPTIT
		BSQ->(MsUnlock())

		(_cAlias)->(DbSkip())
	End
	(_cAlias)->(DbCloseArea())

	//------------------------------------------------------------------------------------------
	//Angelo Hewnrique - Data: 03/03/2023
	//------------------------------------------------------------------------------------------
	//Após ter feito a atualização acima remover todos os lançamentos de débito e crédito
	//que ficaram preso no lote porém não foram para o título, uma vez que não estão
	//parametrizados corretamente para mensalidade ou coparticipação
	//------------------------------------------------------------------------------------------
	_cSQL := " SELECT														" + CRLF
	_cSQL += " 	BSQ.BSQ_CODSEQ,												" + CRLF
	_cSQL += " 	BSQ.R_E_C_N_O_ RECNO										" + CRLF
	_cSQL += " FROM															" + CRLF
	_cSQL += " 	" + RetSqlName("BSQ") + " BSQ 								" + CRLF
	_cSQL += " WHERE														" + CRLF
	_cSQL += " 	BSQ.BSQ_FILIAL      = '" + xFilial("BSQ") + "'				" + CRLF
	_cSQL += " 	AND BSQ.BSQ_CODINT  = '" + M->BDC_CODOPE  + "'				" + CRLF
	_cSQL += " 	AND BSQ.BSQ_NUMCOB  = '" + M->(BDC_CODOPE+BDC_NUMERO) + "'	" + CRLF
	_cSQL += " 	AND BSQ.BSQ_NUMTIT  = ' '									" + CRLF
	_cSQL += " 	AND BSQ.D_E_L_E_T_  = ' '									" + CRLF

	If Select(_cAlias1) > 0
		dbSelectArea(_cAlias1)
		dbclosearea()
	Endif

	PlsQuery(_cSQL,_cAlias1)

	While (_cAlias1)->(!Eof())

		BSQ->(DbGoTo( (_cAlias1)->RECNO ))

		//----------------------------------------------------------------------
		//Confirmando se o numero do titulo esta de fato em branco, caso o 
		//processo esteja dentro de uma transação (Begin Transaction)
		//----------------------------------------------------------------------
		If Empty(AllTrim(BSQ->BSQ_NUMTIT))

			BSQ->(RecLock("BSQ",.F.))

			BSQ->BSQ_NUMCOB := "" //Removendo o lote de cobrança pois o lançamento não foi atrelado e contabilizado a um titulo

			BSQ->(MsUnlock())

		EndIf

		(_cAlias1)->(DbSkip())
	
	EndDo

	(_cAlias1)->(DbCloseArea())

	RestArea(_aArBSQ)
	RestArea(_aArea )

Return
