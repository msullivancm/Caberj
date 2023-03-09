#INCLUDE "TOTVS.CH"

/*/{Protheus.doc} FA430FIL
    Retirado do PE F300FIL (Versão 33 - SISPAG descontinuado)
    Ponto de Entrada no retorno do MODELO 2 CNAB a PAGAR.
    Usado para cancelamento de baixa dos titulos com ocorrência 
    DV e Retirada do borderô. 
@type function
@version  1.0
@author rafael.resende
@since 3/8/2023
/*/
User Function FA430FIL( cParamBuffer )

	Local aAreaAnt  	:= GetArea()
	Local aAreaSEA		:= SEA->( GetArea())
	Local cTrb	    	:= GetNextAlias()
	Local cAuxFilE2     := XFilial( "SE2" )
	Local lAchou		:= .T.
	Local cAuxOcorrencia:= ""
	Local cAuxIdCNAB    := ""
	Local nTamIdCNAB    := 0
	Private lMsErroAuto	:= .F.
	Private aBaixa		:= {}
	Public nRecTit      := SE2->( RecNo() )

	nTamIdCNAB          := TamSX3( "E2_IDCNAB" )[01]
	cAuxIdCNAB          := PadR( SubStr( cParamBuffer, 074, 19 ), nTamIdCNAB )
	cAuxOcorrencia      := SubStr( cParamBuffer, 231, 02 )

	SE2->( DbSetOrder( 11 ) )  // Filial + IdCnab
	If !SE2->( DbSeek( cAuxFilE2 + cAuxIdCNAB  ) )

		lAchou := .T.
		//Se não achou utiliza chave antiga
		//SE2->(DbSetOrder(1))
		//If !SE2->(DbSeek( cAuxFilE2 + PadR( aParamValores[01] ) ) )

	Else
		lAchou := .F.
		Help("",1,"NOESPECIE",,aParamValores[1],5,1)

		//Localiza o primeiro titulo totalmente baixado para que o Fina300 pule a linha.
		cQry := "SELECT R_E_C_N_O_ REC "
		cQry += "  FROM " + RetSQLName( "SE2" )
		cQry += " WHERE D_E_L_E_T_ = ' ' "
		cQry += "   AND E2_FILIAL  = '" + XFilial( "SE2" ) + "' "
		cQry += "   AND E2_SALDO   = 0 "
		cQry += "   AND ROWNUM     = 1 "

		If Select(cTrb) > 0
			(cTrb)->(DbCloseArea())
		EndIf

		dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), cTrb, .F., .T.)
		(cTrb)->(dbGoTop())
		If (cTrb)->(!Eof())
			SE2->(DbGoTo((cTrb)->REC))
		EndIf
		(cTrb)->(dbCloseArea())

		//EndIf
	EndIf

	If lAchou

		If AllTrim( cAuxOcorrencia ) == "DV" .And. !Empty( SE2->E2_BAIXA )

			nRecSE2		:= SE2->(Recno())
			cAutMotbx	:="NORMAL"
			cHistBx		:= "Cancelamento de Baixa"
			aBaixa		:={}

			dDataOld  := dDataBase
			dDataBase := SE2->E2_BAIXA

			aAdd(aBaixa, {"E2_PREFIXO"	, SE2->E2_PREFIXO			, Nil})
			aAdd(aBaixa, {"E2_NUM"		, SE2->E2_NUM				, Nil})
			aAdd(aBaixa, {"E2_PARCELA"	, SE2->E2_PARCELA			, Nil})
			aAdd(aBaixa, {"E2_TIPO"		, SE2->E2_TIPO				, Nil})
			aAdd(aBaixa, {"E2_FORNECE"	, SE2->E2_FORNECE			, Nil})
			aAdd(aBaixa, {"E2_LOJA"		, SE2->E2_LOJA				, Nil})
			aAdd(aBaixa, {"AUTHIST"		, cHistBx					, Nil})
			aAdd(aBaixa, {"AUTVLRPG"	, SE2->(E2_VALOR-E2_SALDO)	, Nil})

			Begin Transaction

				lMSErroAuto := .F.
				MsExecAuto({|x,y|FINA080(x,y)},aBaixa,5)

				Pergunte("AFI300", .F.)
				If lMSErroAuto
					MostraErro()
					dDataBase := dDataOld
					Return .F.
				EndIf

				SEA->(DbSetOrder( 01 ) )
				If SEA->( DbSeek( cFilSEA + SE2->(E2_NUMBOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)))
					RecLock("SEA", .F.)
					SEA->(DbDelete())
					SEA->(MsUnlock())

					SE2->( DbGoTo( nRecSE2 ) )
					RecLock("SE2", .F.)
					SE2->E2_NUMBOR  := Space( Len( SE2->E2_NUMBOR  ) )
					SE2->E2_PORTADO := Space( Len( SE2->E2_PORTADO ) )
					SE2->(MsUnlock())
				EndIf

				dDataBase := dDataOld

			End Transaction

		EndIf

	EndIf

	RestArea( aAreaSEA )
	RestArea( aAreaAnt )

Return
