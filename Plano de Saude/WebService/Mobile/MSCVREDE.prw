#Include 'Protheus.ch'

User Function MSCVREDE()
LOCAL cCodPla := PARAMIXB[1]
LOCAL cVerPla := PARAMIXB[2]
LOCAL cSql 	:= ""
LOCAL aRet := {"",""}

cSql := "Select * from "+RetSqlName("BB6")+" BB6, "+RetSqlName("BI5")+" BI5 WHERE BB6_FILIAL = '"+xFilial("BB6")+"' "
cSql += "AND BB6_CODIGO = '"+PlsIntPad()+cCodPla+"' "
cSql += "AND BB6_VERSAO = '"+cVerPla+"' "
cSql += "AND BB6_CODRED = BI5.BI5_CODRED "
cSql += "AND BB6.D_E_L_E_T_ = ' ' "
cSql += "AND BI5.D_E_L_E_T_ = ' ' "
PlsQuery(cSql, "TRB1")

If !TRB1->( Eof() )
	aRet := {TRB1->BI5_CODRED, TRB1->BI5_DESCRI}
Endif

TRB1->( dbCloseArea() )

Return(aRet)

