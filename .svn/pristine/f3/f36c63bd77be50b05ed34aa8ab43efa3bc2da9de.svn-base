#Include 'Protheus.ch'
#include "TOPCONN.CH"

/*
PONTO DE ENTRADA USADO PELO APLICATIVO MOBILE 
PARA MONTAR A MENSAGEM DE CARENCIAS
USA A VIEW SIGA.V_CARENCIA_CABERJ 
*/

User Function MSCVCARE()
	LOCAL cSql := ""
	LOCAL aCarencias := {}
/*
cSql := "SELECT NOMEGRUPO DESCRICAO , " + CRLF 
cSql += "       TO_CHAR((TO_DATE(TRIM(DATCAR),'YYYYMMDD') + DECODE(UNCAR,'1',QTDCAR/24,QTDCAR)),'YYYYMMDD') CARENCIA_ATE " + CRLF 
if cEmpAnt = "01"
  cSql += "FROM   V_CARENCIA_CABERJ_NV " + CRLF 
Else  
  cSql += "FROM   V_CARENCIA_INTEGRAL_NV " + CRLF 
Endif  
cSql += "WHERE  OPER    = '" + BA1->BA1_CODINT + "'  " + CRLF 
cSql += "AND    EMPRESA = '" + BA1->BA1_CODEMP + "'  " + CRLF 
cSql += "AND    MATRIC  = '" + BA1->BA1_MATRIC + "'  " + CRLF 
cSql += "AND    TIPREG  = '" + BA1->BA1_TIPREG + "'  " + CRLF  
cSql += "AND    (TO_DATE(TRIM(DATCAR),'YYYYMMDD') + DECODE(UNCAR,'1',QTDCAR/24,QTDCAR)) > SYSDATE " + CRLF 
cSql += "AND    ROWNUM <= 3 "  + CRLF//<<ALTERADA 
*/
	cSql :="select * from ( " + CRLF
	cSql += "SELECT NOMEGRUPO DESCRICAO , " + CRLF
	cSql += "TO_CHAR((TO_DATE(TRIM(DATCAR),'YYYYMMDD') + DECODE(UNCAR,'1',QTDCAR/24,QTDCAR)),'YYYYMMDD') CARENCIA_ATE " + CRLF
	if cEmpAnt = "01"
		cSql += "FROM   V_CARENCIA_CABERJ_NV v1 " + CRLF
	Else
		cSql += "FROM   V_CARENCIA_INTEGRAL_NV v1 " + CRLF
	Endif
	cSql += "WHERE  OPER    = '" + BA1->BA1_CODINT + "'  " + CRLF
	cSql += "AND    EMPRESA = '" + BA1->BA1_CODEMP + "'  " + CRLF
	cSql += "AND    MATRIC  = '" + BA1->BA1_MATRIC + "'  " + CRLF
	cSql += "AND    TIPREG  = '" + BA1->BA1_TIPREG + "'  " + CRLF
	cSql += "AND (TO_DATE(TRIM(DATCAR),'YYYYMMDD') + DECODE(UNCAR,'1',QTDCAR/24,QTDCAR)) > SYSDATE " + CRLF
	cSql += "AND NIVEL = (SELECT MAX(NIVEL)  " + CRLF
	cSql += "FROM V_CARENCIA_INTEGRAL_NV V2  " + CRLF
	cSql += "WHERE V2.EMPRESA = V1.EMPRESA  " + CRLF
	cSql += "AND V2.MATRIC = V1.MATRIC  " + CRLF
	cSql += "AND V2.TIPREG = V1.TIPREG  " + CRLF
	cSql += "AND V2.CODGRUPO = V1.CODGRUPO) " + CRLF
	cSql += "order by 2 desc,1  " + CRLF
	cSql += ")  " + CRLF
	cSql += "where ROWNUM <= 3  " + CRLF
	
	cSql := ChangeQuery(cSql)
	Tcquery cSql Alias "TRB1" New

	While !TRB1->( Eof() )
		Aadd(aCarencias, {TRB1->DESCRICAO,TRB1->CARENCIA_ATE})
	
		TRB1->( dbSkip() )
	Enddo

	TRB1->( dbCloseArea() )

Return(aCarencias)