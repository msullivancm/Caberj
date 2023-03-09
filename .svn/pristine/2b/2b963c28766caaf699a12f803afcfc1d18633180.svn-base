#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR302
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 12/04/2022
@return variant, return_description
/*/
USER FUNCTION CABR302()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR302"

AjustaSX1_2(cPerg)

IF !Pergunte(cPerg, .T.)
	Return
Endif

oReport:= ReportH()
oReport:PrintDialog()

RestArea(aArea)

RETURN

Static Function ReportH()
                                      
Local oSection1
Local oReport
Local aAreaSM0  := SM0->(GetArea())   
Local cTit := "Relatório de Carência de Empresas"

cDesCRel := cTit

//??????????????????????????????????????
//?Criacao do componente de impressao                                     ?
//?oReport():New                                                          ?
//?ExpC1 : Nome do relatorio                                              ?
//?ExpC2 : Titulo                                                         ?
//?ExpC3 : Pergunte                                                       ?
//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
//?ExpC5 : Descricao                                                      ?
//??????????????????????????????????????
cDesl:= ""
oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cDescRel)
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.T.)


Pergunte(oReport:uParam,.F.)

		 
		oSection1 := TRSection():New(oReport,"Relatório de Carência de Empresas") 

		// Colunas do relatorio   
		TRCell():New(oSection1,"" ,,"CODEMP"  			, ""	,8	   ,.F.,{|| (cAliasBOL)->CODEMP}  			,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"NOME"  				, ""	,30	   ,.F.,{|| (cAliasBOL)->NOME}  			  ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"MATRICULA"  	  , ""	,30	   ,.F.,{|| (cAliasBOL)->MATRICULA}  		,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"PLANO"  				, ""	,25	   ,.F.,{|| (cAliasBOL)->PLANO}				  ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"EMPRESA"  			, ""	,10	   ,.F.,{|| (cAliasBOL)->EMPRESA}  			,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"CONTRATO" 			, ""	,10	   ,.F.,{|| (cAliasBOL)->NUMCON}  			,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"SUB-CONTRATO"	, ""	,20	   ,.F.,{|| (cAliasBOL)->SUBCON}  			,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection1,"" ,,"NSUBCON"  			, ""	,20	   ,.F.,{|| (cAliasBOL)->NSUBCON}  			,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection1,"" ,,"GRUPO"         , ""	,20	   ,.F.,{|| (cAliasBOL)->DESCRI_GRUPO}  ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"INCLUSAO"  		, ""	,20	   ,.F.,{|| (cAliasBOL)->INCLUSAO}  		,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"PERIODO"       , ""	,25	   ,.F.,{|| (cAliasBOL)->PERIODO}       ,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection1,"" ,,"CARENCIA ATE"  , ""	,25	   ,.F.,{|| (cAliasBOL)->CARENCIA_ATE}  ,"LEFT"  ,.T. ,"LEFT" )

RestArea( aAreaSM0 )

Return(oReport)

Static Function ReportPrt(oReport)
Local oSection1 

Private cAliasBOL  := GetnextAlias()

oSection1 := oReport:Section(1)

// Query para buscar os dados no banco

/**************************************/
  IF SUBSTR(cEmpAnt,2,1) = '1'
    cCarencia := "V_CARENCIA_CABERJ_NV"
    cLetra := "C"
    ELSE 
    cCarencia := "V_CARENCIA_INTEGRAL_NV"
    cLetra := "I"
  ENDIF

  cQry:=" SELECT 																															                        " + CRLF
  cQry+="   BA1_CODEMP CODEMP,   																											                " + CRLF
  cQry+="	  TRIM(BA1_NOMUSR) NOME,    																									              " + CRLF
  cQry+="   CONCAT(BA1_CODINT,CONCAT('.',CONCAT(BA1_CODEMP,CONCAT('.',CONCAT(BA1_MATRIC,CONCAT('.',CONCAT(BA1_TIPREG,CONCAT('-',BA1_DIGITO)))))))) MATRICULA,    " + CRLF
  cQry+="   BI3_DESCRI PLANO,    																											                " + CRLF
  cQry+="   BG9_NREDUZ EMPRESA,    																										                " + CRLF
  cQry+="   BA1.BA1_CONEMP NUMCON, 																										                " + CRLF
  cQry+="   BA1.BA1_SUBCON SUBCON, 																										                " + CRLF
  cQry+="   RETORNA_DESC_SUBCONTRATO('"+cLetra+"',BA1_CODEMP,BA1.BA1_CONEMP,BA1.BA1_SUBCON) NSUBCON,  " + CRLF
/*cQry+="   TO_CHAR(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),'DD-MM-YYYY') NASCIMENTO,    							  " + CRLF
  cQry+="   IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD')) IDADE,    																	  " + CRLF
  cQry+="   DECODE(BA1_SEXO,'1','M','2','F',' ') SEXO, 																					      " + CRLF   */
  cQry+="   TO_CHAR(TO_DATE(TRIM(BA1_DATINC),'YYYYMMDD'),'DD-MM-YYYY') INCLUSAO,    									" + CRLF
/*cQry+="   (CASE WHEN BA1_DATBLO <> ' ' THEN TO_CHAR(TO_DATE(BA1_DATBLO,'YYYYMMDD'),'DD-MM-YYYY') ELSE  '          '  END) BLOQUEIO,  	" + CRLF   
  cQry+="   (CASE WHEN BA1_DATBLO <> ' ' THEN    																							        " + CRLF
  cQry+="   	RETORNA_MOTIVO_BLOQ(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DATBLO,'C')     		" + CRLF
  cQry+="   	ELSE ' ' END) MOT_BLOQ,    																									            " + CRLF
  cQry+="   '(' || TRIM(BA1_DDD) || ') ' || TRIM(BA1_TELEFO) || ' ' || TRIM(BA1_YTEL2) || ' ' || TRIM(BA1_YCEL) FONES,    				" + CRLF
  cQry+="    LOWER(BA1_EMAIL) MAIL,    																									              " + CRLF
  cQry+="         BA1_TIPUSU TIPUSU  ,                                                                " + CRLF */
  cQry+="          (CASE WHEN CODGRUPO IN ('009','010','011','012','013','014','015','016','017') THEN 'PROCEDIMENTOS DE ODONTOLOGIA'
  cQry+="          ELSE NOMEGRUPO
  cQry+="         END  ) DESCRI_GRUPO,
  cQry+="         QTDCAR||(decode(uncar,'1',' HORAS','2',' DIAS','3',' MESES')) PERIODO , 
  cQry+="          decode(sign((DECODE(UNCAR,'1', TO_DATE(TRIM(DATCAR),'YYYYMMDD')+1
  cQry+="                        ,'2', TO_DATE(TRIM(DATCAR),'YYYYMMDD')+QTDCAR))-sysdate),-1,'CUMPRIDA','ATE '||
  cQry+="                 DECODE(UNCAR,'1', TO_CHAR(TO_DATE(TRIM(DATCAR),'YYYYMMDD')+1,'dd/mm/yyyy')
  cQry+="                                ,'2', TO_CHAR(TO_DATE(TRIM(DATCAR),'YYYYMMDD')+QTDCAR,'dd/mm/yyyy'))) CARENCIA_ATE
/*cQry+="          DECODE(UNCAR,'1', TO_DATE(TRIM(DATCAR),'YYYYMMDD')+1
  cQry+="                         ,'2', TO_DATE(TRIM(DATCAR),'YYYYMMDD')+QTDCAR) DATAORDEM  */
  cQry+="   FROM   " + RetSqlName('BA1') +" BA1 , " + RetSqlName('BA3') +" BA3 , " + RetSqlName('BI3') +" BI3 , " + RetSqlName('BG9') +" BG9  , "+cCarencia+"  V1   										" + CRLF
  cQry+="   WHERE  ( (BA1_DATBLO = ' ' OR BA1_DATBLO > TO_CHAR(SYSDATE,'YYYYMMDD'))    								" + CRLF
  cQry+="            OR    																												                    " + CRLF
  cQry+="            (RETORNA_MOTIVO_BLOQ(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DATBLO,'"+cLetra+"') LIKE '%TEMP%') )                    " + CRLF
  cQry+="   AND    BA1_CODEMP = "+MV_PAR01+"																								          " + CRLF

  IF !EMPTY(MV_PAR02)
    cQry+="   AND BA1_CONEMP = '"+MV_PAR02+"'                                                  " + CRLF
  ENDIF

  IF !EMPTY(MV_PAR03)
    cQry+="   AND BA1_SUBCON = '"+MV_PAR03+"' 															              " + CRLF
  ENDIF
  IF MV_PAR04 = 1
    cQry+="   AND BA1_DATBLO = ' ' 															                                        " + CRLF
  ELSEIF MV_PAR04 = 2
    cQry+="   AND BA1_DATBLO <> ' '														                                          " + CRLF
  ENDIF
  IF MV_PAR05 = 1
    cQry+=" AND (sign(DECODE(UNCAR,'1', TO_DATE(TRIM(DATCAR),'YYYYMMDD')+1,                           " + CRLF
    cQry+="                        '2', TO_DATE(TRIM(DATCAR),'YYYYMMDD')+QTDCAR)-SYSDATE)) <> -1      " + CRLF
  ENDIF
  IF !EMPTY(MV_PAR06)
    cQry+="   AND    BA1_DATINC >= '"+DTOS(MV_PAR06)+"'                                               " + CRLF
  ENDIF
  IF !EMPTY(MV_PAR07)
    cQry+="   AND    BA1_DATINC <= '"+DTOS(MV_PAR07)+"'                                               " + CRLF
  ENDIF
  cQry+="   AND    BA3_FILIAL = BA1_FILIAL																								            " + CRLF
  cQry+="   AND    BA3_CODINT = BA1_CODINT    																							          " + CRLF
  cQry+="   AND    BA3_CODEMP = BA1_CODEMP    																							          " + CRLF
  cQry+="   AND    BA3_MATRIC = BA1_MATRIC    																							          " + CRLF
  cQry+="   AND    (CASE WHEN BA1_CODPLA = ' ' THEN BA3_CODPLA ELSE BA1_CODPLA END) = BI3.BI3_CODIGO  " + CRLF
  cQry+="   AND    BA3_FILIAL = BG9_FILIAL    																							          " + CRLF
  cQry+="   AND    BA3_CODINT = BG9_CODINT    																							          " + CRLF
  cQry+="   AND    BA3_CODEMP = BG9_CODIGO                      																			" + CRLF
  cQry+="   AND    OPER    = BA1_CODINT																									              " + CRLF
  cQry+="   AND    EMPRESA = BA1_CODEMP  																									            " + CRLF
  cQry+="   AND    MATRIC  = BA1_MATRIC   																								            " + CRLF
  cQry+="   AND    TIPREG  = BA1_TIPREG																									              " + CRLF
  cQry+="   AND    NIVEL = (SELECT MAX(NIVEL)																								          " + CRLF
  cQry+="                   FROM "+cCarencia+" V2																					            " + CRLF
  cQry+="                   WHERE v2.OPER  = V1.OPER																						      " + CRLF
  cQry+="                   AND v2.EMPRESA = V1.EMPRESA																					      " + CRLF
  cQry+="                   AND v2.MATRIC  = V1.MATRIC																					      " + CRLF
  cQry+="                   AND v2.TIPREG  = V1.TIPREG																					      " + CRLF
  cQry+="                   AND V2.CODGRUPO= V1.CODGRUPO)																					    " + CRLF
  cQry+="   AND    BA1.D_E_L_E_T_ = ' '    																								            " + CRLF
  cQry+="   AND    BA3.D_E_L_E_T_ = ' '    																								            " + CRLF
  cQry+="   AND    BI3.D_E_L_E_T_ = ' '    																								            " + CRLF
  cQry+="   AND    BG9.D_E_L_E_T_ = ' '      																								          " + CRLF

/***************************************************************************************************************/

//cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Nao foram encontrados dados!")
Else

	oSection1:Init()

	While  !(cAliasBOL)->(Eof())       
		
		oReport:IncMeter()
		oSection1:PrintLine()
		
		(cAliasBOL)->(DbSkip())

	Enddo   
		
	oReport:FatLine()
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 

aHelpPor := {}
AADD(aHelpPor,"Informe ")

 u_CABASX1(cPerg , "01" , "Empresa"  	   		    ,"","","MV_CH1","C",TamSx3('BA1_CODEMP')[1]	,0,0,"G",""	,"" ,"","","MV_PAR01",""          ,""           ,""           ,"",""              ,""               ,""               ,""         ,""         ,""         ,"","","","","","",aHelpPor,aHelpPor,aHelpPor)
 u_CABASX1(cPerg , "02" , "Contrato" 			      ,"","","MV_CH2","C",TamSx3('BA1_CONEMP')[1] ,0,0,"G","" ,""	,"","","MV_PAR02",""          ,""           ,""           ,"",""              ,""               ,""               ,""         ,""         ,""         ,"","","","","","",aHelpPor,aHelpPor,aHelpPor)
 u_CABASX1(cPerg , "03" , "Sub-Contrato" 		    ,"","","MV_CH3","C",TamSx3('BA1_SUBCON')[1] ,0,0,"G","" ,""	,"","","MV_PAR03",""          ,""           ,""           ,"",""              ,""               ,""               ,""         ,""         ,""         ,"","","","","","",aHelpPor,aHelpPor,aHelpPor)
 u_CABASX1(cPerg , "04" , "Status"				      ,"","","MV_CH4","N",1                       ,0,0,"C","" ,""	,"","","MV_PAR04","1 - Ativos","1 - Ativos" ,"1 - Ativos" ,"","2 - Bloqueados","2 - Bloqueados" ,"2 - Bloqueados" ,"3 - Todos","3 - Todos","3 - Todos","","","","","","",aHelpPor,{}      ,{},"")
 u_CABASX1(cPerg , "05" , "Somente Carência?"	  ,"","","MV_CH5","N",1                       ,0,0,"C","" ,""	,"","","MV_PAR05","1 - Sim"   ,"1 - Sim"    ,"1 - Sim"    ,"","2 - Não"       ,"2 - Não"        ,"2 - Não"        ,""         ,""         ,""         ,"","","","","","",aHelpPor,{}      ,{},"")
 u_CABASX1(cPerg , "06" , "Dt. Inclusao de"	    ,"","","MV_CH6","D",8                       ,0,0,"G","" ,""	,"","","MV_PAR06",""          ,""           ,""           ,"",""              ,""               ,""               ,""         ,""         ,""         ,"","","","","","",aHelpPor,{}      ,{},"")
 u_CABASX1(cPerg , "07" , "Dt. Inclusao até"	  ,"","","MV_CH7","D",8                       ,0,0,"G","" ,""	,"","","MV_PAR07",""          ,""           ,""           ,"",""              ,""               ,""               ,""         ,""         ,""         ,"","","","","","",aHelpPor,{}      ,{},"")
Return()

/******************************************************************************************************************************/
