#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABG009   ºAutor  ³Mateus Medeiros     º Data ³  23/02/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gatilho retornará o CPF do titular 						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABG009(_cParam1)

	Local _aArea		:= GetArea()
	Local _aArZZQ		:= ZZQ->(GetArea())
	Local cAlias1       := GetNextAlias()
	Local cCodInt		:= Substr(_cParam1,1,4)
	Local cCodEmp		:= Substr(_cParam1,5,4)
	Local cMatric		:= Substr(_cParam1,9,6)
	Local _cRet         := ""

	Default _cParam1	:= "" //Matricula do beneficiário

	BEGINSQL ALIAS cAlias1
		SELECT BA1_CPFUSR
			FROM %table:BA1%
				WHERE BA1_CODINT = %exp:cCodInt%
					AND BA1_CODEMP = %exp:cCodEmp%
					AND BA1_MATRIC = %exp:cMatric%
					AND BA1_TIPUSU = 'T'
					AND D_E_L_E_T_ <> '*'

	EndSql


	if (cAlias1)->(!Eof())

		_cRet := (cAlias1)->BA1_CPFUSR

	Endif

	if select(cAlias1) > 0
		dbselectarea(cAlias1)
		dbclosearea()
	endif

	RestArea(_aArZZQ)
	RestArea(_aArea )

Return _cRet