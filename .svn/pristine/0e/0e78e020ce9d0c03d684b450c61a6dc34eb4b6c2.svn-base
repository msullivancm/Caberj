#Include 'Protheus.ch'

User Function MSCVOPC()
LOCAL cRet := ""
LOCAL nRecBA1 := BA1->( Recno() )
LOCAL aArea := GetArea()
LOCAL cCodPla := ""
LOCAL cVerPla := ""

If BA1->( FieldPos("BA1_YMTODO") ) > 0
	BA1->( dbSetorder(02) )
	If BA1->( dbSeek(xFilial("BA1")+Alltrim(BA1->BA1_YMTODO)) )
		cRet := BA1->BA1_YDPLAP		
	Endif	
Endif

BA1->( dbGoto(nRecBA1) )
RestArea(aArea)

Return(cRet)

