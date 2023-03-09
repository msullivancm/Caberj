*****************************************************************************
*+-------------------------------------------------------------------------+*
*|Funcao      | F300FIL   | Autor | Edilson Leal  (Korus Consultoria)      |*
*+------------+------------------------------------------------------------+*
*|Data        | 11.01.2008                                                 |*
*+------------+------------------------------------------------------------+*
*|Descricao   | Ponto de Entrada no retorno do SISPAG.                     |*
*|            | Usado para cancelamento de baixa dos titulos com ocorrên-  |*
*|            | cia DV e Retirada do borderô.                              |*
*+------------+------------------------------------------------------------+*
*|Arquivos    | SE2                                                        |*
*+------------+------------------------------------------------------------+*
*|Alteracoes  | Eduardo Folly (Korus Consultoria)                          |*
*|            | Retomada dos parâmetros MV_PAR para valores iniciais infor-|*
*|            | mados através da pergunta AFI300.                          |*
*+-------------------------------------------------------------------------+*
*****************************************************************************

#Include "rwmake.ch"

***********************
User Function F300FIL()  
***********************

	Local lAchou		:= .T.
	Local cTrb			:= GetNextAlias()
	Local aAreaSEA		:= SEA->(GetArea())
	Private lMsErroAuto	:= .F. 
	Private aBaixa		:= {}

	Public  nRecTit     := SE2->(Recno())
	
	SE2->(DbSetOrder(11)) // Filial+IdCnab
 
	If !SE2->(DbSeek(xFilial("SE2")+SubStr(Paramixb[1],1,10)))

		//Se não achou utiliza chave antiga
		SE2->(DbSetOrder(1))

		If !SE2->(DbSeek(xFilial("SE2")+Pad(Paramixb[1],Paramixb[3])))

			lAchou := .F.
			Help("",1,"NOESPECIE",,Paramixb[1],5,1)

			//Localiza o primeiro titulo totalmente baixado para que o Fina300 pule a linha.
			cQry := "SELECT R_E_C_N_O_ REC FROM " + RetSqlName("SE2")
			cQry += " WHERE D_E_L_E_T_ = ' '"
			cQry += "   AND E2_FILIAL = '" + xFilial("SE2") + "'"
			cQry += "   AND E2_SALDO = 0"
			cQry += "   AND ROWNUM   = 1"

			If Select(cTrb) > 0; (cTrb)->(DbCloseArea()); EndIf
			dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQry), cTrb, .F., .T.)

			(cTrb)->(dbGoTop())

			If (cTrb)->(!Eof())
				SE2->(DbGoTo((cTrb)->REC))
			EndIf

			(cTrb)->(dbCloseArea())
		EndIf
	EndIf
 
	If lAchou
		If AllTrim(cRetorno) == "DV" .And. !Empty(SE2->E2_BAIXA)
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

			MsExecAuto({|x,y|FINA080(x,y)},aBaixa,5)

			Pergunte("AFI300", .F.)   

			If lMSErroAuto
				MostraErro()
				dDataBase := dDataOld
				Return .F.
			EndIf

			SEA->(DbSetOrder(1))
			If SEA->(DbSeek(xFilial("SEA")+SE2->(E2_NUMBOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)))
				RecLock("SEA", .F.)
				SEA->(DbDelete())
				SEA->(MsUnlock())

				SE2->(dbGoTo(nRecSE2))
				RecLock("SE2", .F.)
				SE2->E2_NUMBOR  := Space(Len(SE2->E2_NUMBOR))
				SE2->E2_PORTADO := Space(Len(SE2->E2_PORTADO))
				SE2->(MsUnlock())
			EndIf

			dDataBase := dDataOld

			End Transaction
		EndIf
	EndIf

	RestArea(aAreaSEA)
Return