#include "Protheus.ch"

user function PlanoX (cPlano,dtIni, DtFim)
Local aRet     := {}
Default cPlano := "C"
Default dtIni  := ctod("01/01/2010")
Default DtFim  := ctod("31/01/2010")
	cPlano         := alltrim(cPlano)

   // cQuery += " DECODE(TRIM(BI3_YGRPLA),'1','ADMINISTRATIVO','2','AFINIDADE','3','EMPRESARIAL','4','MATER') PLANO_DESC, "


  cQuery := ""
  cQuery += " SELECT MES_ANO_REF, EMP, "
  cQuery += " TRIM(BI3_YGRPLA) || ' - ' || trim(BI3_NREDUZ) PLANO, SUM(QTD) QTD "
  if cPlano == "C"
    cQuery += " FROM SIGA.TOTAL_CARTEIRA_ASSISTIDOS  T, BI3010  C  ,SIGA.FAIXA_ETARIA F "
  else
    cQuery += " FROM SIGA.TOTAL_CARTEIRA_ASSISTIDOS  T, BI3020  C  ,SIGA.FAIXA_ETARIA F "
  endif
  cQuery += " WHERE MES_ANO_REF BETWEEN To_Date('" + dtIni + "','dd/mm/yyyy') AND to_Date('" + dtFim + "','dd/mm/yyyy') "
  cQuery += " AND IDADE BETWEEN IDADE_INICIAL AND IDADE_FINAL "
  cQuery += " AND EMP ='" + cPlano + "' "
  cQuery += " AND T.COD_PLANO=C.BI3_CODIGO "
  cQuery += " AND C.D_E_L_E_T_=' ' "
  cQuery += " AND F.TIPO_FAIXA = 3 "
  cQuery += " AND D_E_L_E_T_ = ' ' "
  cQuery += " GROUP BY MES_ANO_REF,EMP, TRIM(BI3_YGRPLA) || ' - ' || trim(BI3_NREDUZ)"
  cQuery += " ORDER BY 1,2,3,4 "

	If ( Select ( "cTemp" ) <> 0 )
		dbSelectArea ( "cTemp" )
		dbCloseArea ()
	Endif

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cTemp",.T.,.F.)

	
do While cTemp->(!eof())
	aadd(aRet,{cTemp->PLANO,cTemp->QTD})
	DbSkip()
Enddo
DbSelectArea("cTemp")
DbCloseArea("cTemp")
  		
Return aRet
