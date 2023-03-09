#include 'protheus.ch'
#include 'parmtype.ch'

#Define cEnt chr(10)+chr(13)

/*
Autor: Mateus Medeiros
Data: 29/08/2017
Descrição: Ponto de Entrada para realizar a validação da transferência.

*/
User Function PLSA169OK()

	Local _aArea := GetArea()
	Local _aAreaBSQ:= BSQ->(GetArea())
	Local _aAreaBA1:= BA1->(GetArea())
	Local lRet:= .T.// Desenvolvimento do usuário
	Local _cAlias1 := GetNextAlias()
	Local cQuery := ""

	cQuery := " SELECT BBQ.* "
	cQuery += "FROM "+RetSqlName("BSQ")+" BBQ " + cEnt
	cQuery += "WHERE BSQ_FILIAL = ' ' "+ cEnt
	cQuery += "      AND BSQ_USUARI = '"+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+ "'"+ cEnt
	cQuery += "AND BSQ_CODLAN = '991' "+ cEnt
	cQuery += "     AND BBQ.D_E_L_E_T_ = ' ' "+ cEnt
	cQuery += "      AND BSQ_NUMTIT = ' ' "+ cEnt

	PLSQuery(cQuery,_cAlias1)

	If (_cAlias1)->(!eof())

		if !MsgYesNo("Existe parcelamento em aberto para a matrícula que será bloqueada, deseja continuar com a Transferência?")
			lRet := .F.
		endif

	endif

	RestArea(_aAreaBA1)
	RestArea(_aAreaBSQ)
	RestArea(_aArea)

Return lRet