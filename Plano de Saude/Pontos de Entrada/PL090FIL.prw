#Include "RwMake.ch"
#Include "Protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � PL090FIL �Autor  � Fred O. C. Jr     � Data �  08/06/22    ���
�������������������������������������������������������������������������͹��
���Desc.     �  Filtro AllCare - Libera��o SADT/Consulta                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PL090FIL()

Local cFiltro	:= ParamIxb[1]
// Local aRegra	:= StrTokArr2( SuperGetMv("MV_XUSXEMP",,"000000|001727-01+0001|0002|0003"), "-")
// Local cUsuarios	:= AllTrim(aRegra[1])								// Usuarios a restringir
// Local aOpeEmp	:= StrTokArr2( aRegra[2], "+")
// Local cEmpresa	:= AllTrim(aOpeEmp[1])								// Caberj / Integral
// Local cGrpEmp	:= AllTrim(StrTran(aOpeEmp[2],"|","','"))			// Grupos/Empresas a apresentar
LOCAL cCodUsr 	:= PLSRtCdUsr()
Local cGrpEmp  := ""      

BX4->(DbSetOrder(1))
If BX4->(MsSeek(xFilial("BX4")+cCodUsr+PlsIntPad())) // BX4_FILIAL+BX4_CODOPE+BX4_CODINT

	IF !EMPTY(BX4->BX4_XEMP)
		cGrpEmp := Alltrim(StrTran(BX4->BX4_XEMP,",","','"))
	ENDIF

Endif

IF !EMPTY(cGrpEmp)
// if RetCodUsr() $ cUsuarios

	if cEmpAnt == "02"
		cFiltro += iif(!empty(cFiltro), " AND", "@") + " BEA_CODEMP IN ('" + cGrpEmp + "')"
	else
		cFiltro += iif(!empty(cFiltro), " AND", "@") + " BEA_FILIAL = 'ZZ'"
	endif

endif

return cFiltro
