#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABG009   �Autor  �Mateus Medeiros     � Data �  23/02/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Gatilho retornar� o CPF do titular 						  ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABG009(_cParam1)

	Local _aArea		:= GetArea()
	Local _aArZZQ		:= ZZQ->(GetArea())
	Local cAlias1       := GetNextAlias()
	Local cCodInt		:= Substr(_cParam1,1,4)
	Local cCodEmp		:= Substr(_cParam1,5,4)
	Local cMatric		:= Substr(_cParam1,9,6)
	Local _cRet         := ""

	Default _cParam1	:= "" //Matricula do benefici�rio

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