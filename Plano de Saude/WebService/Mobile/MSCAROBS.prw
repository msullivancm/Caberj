#Include 'Protheus.ch'

// Retorna se o usuário tem o opcional de remoção
User Function MSCAROBS()
LOCAL cCodPla := PARAMIXB[1]
LOCAL cVerPla := PARAMIXB[2]

LOCAL cCodOpc := GetNewPar("MV_MSOPCRM", "0023")
LOCAL cMsg := ""
LOCAL cSql := ""

If BA1->BA1_CODEMP == "0024"
	cMsg := "Urgência / Emergência - 0300 1172 888"
Else
	cMsg := "EMERGÊNCIA DOMICILIAR - 0300 1172 888"
Endif
	
cSql := "  SELECT COUNT(*) QTD "
cSql += "FROM "+RetSqlName("BF4")+" BF4 "
cSql += "   WHERE BF4_FILIAL = '"+xFilial("BF4")+"' "
cSql += "       AND BF4_CODINT = '"+BA1->BA1_CODINT+"' "
cSql += "       AND BF4_CODEMP = '"+BA1->BA1_CODEMP+"' "
cSql += "       AND BF4_MATRIC = '"+BA1->BA1_MATRIC+"' "
cSql += "       AND BF4_TIPREG = '"+BA1->BA1_TIPREG+"' "
cSql += "       AND BF4_CODPRO = '"+cCodOpc+"' " 
cSql += "       AND BF4_DATBLO = ' ' "
cSql += "       AND BF4.D_E_L_E_T_ = ' '"  
PLSQUERY(cSql, "TRB1")

If TRB1->QTD > 0
	TRB1->( dbCloseArea() )
	Return(cMsg)
Endif
TRB1->( dbCloseArea() )

// BF1
cSql := "  SELECT COUNT(*) QTD "
cSql += "FROM "+RetSqlName("BF1")+" BF1 "
cSql += "   WHERE BF1_FILIAL = '"+xFilial("BF1")+"' "
cSql += "       AND BF1_CODINT = '"+BA1->BA1_CODINT+"' "
cSql += "       AND BF1_CODEMP = '"+BA1->BA1_CODEMP+"' "
cSql += "       AND BF1_MATRIC = '"+BA1->BA1_MATRIC+"' "
cSql += "       AND BF1_CODPRO = '"+cCodOpc+"' " 
cSql += "       AND BF1_DATBLO = ' ' "
cSql += "		  and BF1_TIPVIN = '1' "
cSql += "       AND BF1.D_E_L_E_T_ = ' '"  
PLSQUERY(cSql, "TRB1")

If TRB1->QTD > 0
	TRB1->( dbCloseArea() )
	Return(cMsg)
Endif
TRB1->( dbCloseArea() )

// BHS
cSql := "  SELECT COUNT(*) QTD "
cSql += "FROM "+RetSqlName("BHS")+" BHS "
cSql += "   WHERE BHS_FILIAL = '"+xFilial("BHS")+"' "
cSql += "       AND BHS_CODINT = '"+BA1->BA1_CODINT+"' "
cSql += "       AND BHS_CODIGO = '"+BA1->BA1_CODEMP+"' "
cSql += "       AND BHS_NUMCON = '"+BA1->BA1_CONEMP+"' "
cSql += "       AND BHS_VERCON = '001' " 
 cSql += "       AND BHS_SUBCON = '"+BA1->BA1_SUBCON+"' "
 cSql += "       AND BHS_VERSUB = '001' "
 cSql += "       AND BHS_CODPRO = '"+cCodOpc+"' "
 cSql += "       AND BHS_VERPRO = '001' "
 cSql += "       AND BHS_TIPVIN = '1' " 
cSql += "       AND BHS.D_E_L_E_T_ = ' '"
PLSQUERY(cSql, "TRB1")

If TRB1->QTD > 0
	TRB1->( dbCloseArea() )
	Return(cMsg)
Endif
TRB1->( dbCloseArea() )

cSql := "SELECT COUNT(*) QTD " 
cSql += "            FROM "+RetSqlName("BT3")+" BT3 " 
cSql += " WHERE BT3_FILIAL = '"+xFilial("BT3")+"' "
If AllTrim(TcGetDB()) == "ORACLE"
	cSql += "              AND SUBSTR(BT3_CODIGO,1,4) = '"+BA1->BA1_CODINT+"' "
	cSql += "              AND SUBSTR(BT3_CODIGO,5,4) = '"+cCodpla+"' "
Else
	cSql += "              AND SUBSTRING(BT3_CODIGO,1,4) = '"+BA1->BA1_CODINT+"' "
	cSql += "              AND SUBSTRING(BT3_CODIGO,5,4) = '"+cCodpla+"' "

Endif

cSql += "              AND BT3_VERSAO = '001' "
cSql += "              AND BT3_CODPLA = '"+cCodOpc+"' "
cSql += "              AND BT3_VERPLA = '001' "
cSql += "              AND BT3_TIPVIN = '1' "
cSql += "              AND BT3.D_E_L_E_T_ = ' ' "
PLSQUERY(cSql, "TRB1")

If TRB1->QTD > 0
	TRB1->( dbCloseArea() )
	Return(cMsg)
Endif
TRB1->( dbCloseArea() )

Return("")             
