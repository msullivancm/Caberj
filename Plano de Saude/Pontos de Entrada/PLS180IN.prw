#Define CRLF Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS180F  ºAutor  ³Microsiga           º Data ³  30/12/20    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para gravar LOG de Consolidação            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 
User Function PLS180IN 

Local lRet := .T.
Local cCodOpe    := ParamIxb[1]
Local cCodEmpDe  := ParamIxb[2]
Local cCodEmpAte := ParamIxb[3]
Local cAnoRef    := ParamIxb[4]
Local cMesRef    := ParamIxb[5]
Local cLocDe     := ParamIxb[6]
Local cLocAte    := ParamIxb[7]
Local cTipPre    := ParamIxb[8]
Local dDatAte    := ParamIxb[9]
Local cMatDe     := ParamIxb[10]
Local cMatAte    := ParamIxb[11]
Local nVlrMax    := ParamIxb[12]
Local cContrDe   := ParamIxb[13]
Local cContrAte  := ParamIxb[14]
Local cSubconDe  := ParamIxb[15]
Local cSubconAte := ParamIxb[16]
Local cRetro150  := ParamIxb[17]
Local cSql       := ""
Local cSeq       := "00000000000000000000"

    //Criando tabela a Quente na 1ªVez, e Abrindo para fazer RecLock
    DbSelectArea("PE3")

    cSql +=  " SELECT MAX(PE3_CODSEQ) CODSEQ FROM "+RetSqlName("PE3")+" PE3 "   + CRLF
    cSql +=  "  WHERE PE3_FILIAL = '"+ xFilial("PE3") +"'" + CRLF
    //cSql +=  "    AND D_E_L_E_T_ = ' ' " + CRLF
    
    PlsQuery(cSQL,"TRB180IN")

    If TRB180IN->(EOF()) .or. Empty(TRB180IN->CODSEQ)
        cSeq := StrZero(Val(cSeq)+1,20)
    Else
        cSeq := StrZero(Val(TRB180IN->CODSEQ)+1,20)
    endif

    Reclock("PE3",.T.)
        PE3_FILIAL  :=  xFilial("PE3")
        PE3_CODSEQ  :=  cSeq
        PE3_CODOPE  :=  cCodOpe
        PE3_EMPDE   :=  cCodEmpDe
        PE3_EMPATE  :=  cCodEmpAte
        PE3_ANOREF  :=  cAnoRef
        PE3_MESREF  :=  cMesRef
        PE3_LOCDE   :=  cLocDe
        PE3_LOCATE  :=  cLocAte
        PE3_TIPPRE  :=  cTipPre
        PE3_DATATE  :=  dDatAte
        PE3_MATDE   :=  cMatDe
        PE3_MATATE  :=  cMatAte
        PE3_VLRMAX  :=  nVlrMax
        PE3_CONDE   :=  cContrDe
        PE3_CONATE  :=  cContrAte
        PE3_SUBDE   :=  cSubconDe
        PE3_SUBATE  :=  cSubconAte
        PE3_RET150  :=  cValToChar(cRetro150)
        PE3_USUARI  :=  UsrRetName(RetCodUsr())
        PE3_DATLOG  :=  Date()
        PE3_HORLOG  :=  SUBSTR(TIME(),1,5)
    MsUnlock()

Return lRet 