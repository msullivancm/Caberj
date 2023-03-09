#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR316
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 16/09/2022
/*/

USER FUNCTION CABR316()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR316"

AjustaSX1_2(cPerg)

IF !Pergunte(cPerg, .T.)
    Return
Endif

oReport:= ReportH()
oReport:PrintDialog()

RestArea(aArea)

RETURN

Static Function ReportH()
                                                            
Local oSection2
Local oReport
Local aAreaSM0  := SM0->(GetArea())   
Local cTit := "Relatório de Confronto de Dados do SIB x Protheus"


//??????????????????????????????????????
//?Criacao do componente de impressao                                     ?
//?oReport():New                                                          ?
//?ExpC1 : Nome do relatorio                                              ?
//?ExpC2 : Titulo                                                         ?
//?ExpC3 : Pergunte                                                       ?
//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
//?ExpC5 : Descricao                                                      ?
//??????????????????????????????????????

oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cTit)
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.T.)

Pergunte(oReport:uParam,.F.)
                                
oSection2 := TRSection():New(oReport,"Relatório de Confronto de Dados do SIB x Protheus",) 

    // Colunas do relatorio
    TRCell():New(oSection2,""    	,,"Cod. Empresa"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CODEMP      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Descricao"                           , ""	,10	   ,.F.,{|| (cAliasBOL)->BG9_DESCRI      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Contr. Empr."                        , ""	,20	   ,.F.,{|| (cAliasBOL)->BA1_CONEMP      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Sub-Contrato"                        , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_SUBCON      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Descricao"  	                        , ""	,30    ,.F.,{|| (cAliasBOL)->BQC_DESCRI      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Matricula"                           , ""	,10	   ,.F.,{|| (cAliasBOL)->MATRIC          }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Nome"  	                            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_NOMUSR      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"CPF"                                 , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CPFUSR      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Cod.Plano"          	                , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CODPLA      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Descricao"  	                        , ""	,30    ,.F.,{|| (cAliasBOL)->BI3_DESCRI      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Nro CRNA"  	                        , ""	,30    ,.F.,{|| (cAliasBOL)->BTS_NRCRNA      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Cod. CCO"      	                    , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CODCCO      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Dt. Inclusao"                        , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_DATINC      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Data Bloq." 	                        , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_DATBLO      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Motivo Bloq."              	        , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_MOTBLO      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Descricao do bloqueio"               , ""	,15	   ,.F.,{|| (cAliasBOL)->BA1_DESBLO      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Cod. Bloq. ANS"                      , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_BLQANS      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Consid. Ans"              	        , ""	,10	   ,.F.,{|| (cAliasBOL)->BA1_INFANS      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Atualiza SIB" 	                    , ""	,10	   ,.F.,{|| (cAliasBOL)->BA1_ATUSIB      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Consid. SIB"                       	, ""	,30    ,.F.,{|| (cAliasBOL)->BA1_INFSIB      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Status ANS"                          , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_LOCSIB      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Data de retorno do SIB"              , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_DTRSIB      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Inscr. ANS"                          , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_INCANS      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Exclusao ANS"                        , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_EXCANS      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Situacao ANS"                        , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_ENVIADO     }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Status ANS"                          , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_STATUS      }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Conferencia Status ANS"              , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_CONF_STATUS }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Conferencia ANS CCO"                 , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_CONF_CCO    }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"ANS CCO"                             , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_CCO         }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Conferencia Plano ANS"               , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_CONF_PLANO  }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Nro Plano ANS"                       , ""	,30    ,.F.,{|| (cAliasBOL)->NUM_ANS_PLANO   }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Plano ANS"                           , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_PLANO       }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Conferencia Nome ANS"                , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_CONF_NOME   }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Nome ANS"                            , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_NOME        }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Conferencia CPF ANS"                 , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_CONF_CPF    }   ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"CPF ANS"                             , ""	,30    ,.F.,{|| (cAliasBOL)->ANS_CPF         }   ,"LEFT"  ,.T. ,"LEFT" )


RestArea( aAreaSM0 )

Return(oReport)

Static Function ReportPrt(oReport)

Local oSection2 
Private cAliasBOL  := GetnextAlias()

oSection2 := oReport:Section(1)

    cQry:=" SELECT                                                                                                                              " + CRLF
    cQry+="     BA1_CODEMP, TRIM(BG9_DESCRI) AS BG9_DESCRI, BA1_CONEMP, BA1_SUBCON, TRIM(BQC_DESCRI) AS BQC_DESCRI,                             " + CRLF
    cQry+="     BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO as MATRIC, TRIM(BA1_NOMUSR) AS BA1_NOMUSR, BA1_CPFUSR,               " + CRLF
    cQry+="     BA1_CODPLA, TRIM(BI3.BI3_DESCRI) AS BI3_DESCRI, BTS_NRCRNA, BA1_CODCCO, TO_DATE(TRIM(BA1_DATINC),'YYYYMMDD') AS BA1_DATINC,     " + CRLF
    cQry+="     TO_DATE(TRIM(BA1_DATBLO),'YYYYMMDD') AS BA1_DATBLO, BA1_MOTBLO, TRIM(UPPER( CASE WHEN BA1_CONSID = 'U' THEN BG3_DESBLO ELSE     " + CRLF
    cQry+="     CASE WHEN BA1_CONSID = 'F' THEN BG1_DESBLO ELSE                                                                                 " + CRLF
    cQry+="     CASE WHEN BA1_CONSID = 'S' THEN BQU_DESBLO ELSE ' ' END END END)) AS BA1_DESBLO,                                                " + CRLF
    cQry+="     TRIM( CASE WHEN BA1_CONSID = 'U' THEN BG3_BLQANS ELSE                                                                           " + CRLF
    cQry+="     CASE WHEN BA1_CONSID = 'F' THEN BG1_BLQANS ELSE                                                                                 " + CRLF
    cQry+="     CASE WHEN BA1_CONSID = 'S' THEN BQU_BLQANS ELSE ' ' END END END) AS BA1_BLQANS,                                                 " + CRLF
    cQry+="     DECODE(BA1_INFANS,'1','SIM','0','NAO') AS BA1_INFANS,                                                                           " + CRLF
    cQry+="     DECODE(BA1_ATUSIB,'1','SIM','0','NAO') AS BA1_ATUSIB,                                                                           " + CRLF
    cQry+="     DECODE(BA1_INFSIB,'1','SIM','0','NAO') AS BA1_INFSIB,                                                                           " + CRLF
    cQry+="     DECODE(BA1_LOCSIB,'0','NAO ENVIADO','1','ATIVO','2','EXCLUIDO','3','ENVIADO INCLUSAO','4','ENVIADO ALTERACAO',                  " + CRLF
    cQry+="         '5','ENVIADO EXCLUSAO','6','CRITICADO INCLUSAO','7','CRITICADO ALTERACAO','8','CRITICADO EXCLUSAO',                         " + CRLF
    cQry+="         '9','ENVIADO MUDANCA CONTRATUAL', 'A','ENVIADO REATIVACAO','B','CRITICADO MUDANCA CONTRATUAL',                              " + CRLF
    cQry+="         'C','CRITICADO REATIVACAO') AS BA1_LOCSIB,                                                                                  " + CRLF
    cQry+="     TO_DATE(TRIM(BA1_DTRSIB),'YYYYMMDD') AS BA1_DTRSIB, TO_DATE(TRIM(BA1_INCANS),'YYYYMMDD') AS BA1_INCANS,                         " + CRLF
    cQry+="     TO_DATE(TRIM(BA1_EXCANS),'YYYYMMDD') AS BA1_EXCANS,                                                                             " + CRLF
    cQry+="     CASE WHEN SIB_MATRIC <> ' ' THEN 'JA EXISTE' ELSE 'NAO EXISTE' END AS ANS_ENVIADO,                                              " + CRLF
    cQry+="     DECODE(SIB_SITUAC,'1','ATIVO','3','EXCLUIDO') AS ANS_STATUS,                                                                    " + CRLF
    cQry+="     CASE WHEN SIB_SITUAC = '1' AND BA1_DATBLO <= TO_CHAR(SYSDATE,'YYYYMMDD')    THEN 'PENDENTE BLOQUEIO NA ANS'                     " + CRLF
    cQry+="         WHEN SIB_SITUAC = '3' AND (BA1_MOTBLO = ' ' OR BA1_DATBLO >  TO_CHAR(SYSDATE,'YYYYMMDD')) THEN 'BLOQUEIO INDEVIDO NA ANS'   " + CRLF
    cQry+="         ELSE ' ' END AS ANS_CONF_STATUS,                                                                                            " + CRLF
    cQry+="     CASE WHEN SIB_CODCCO = BA1_CODCCO THEN 'CCO CORRETO'   WHEN SIB_MATRIC <> ' ' THEN 'CCO INCONSISTENTE'                          " + CRLF
    cQry+="         ELSE ' ' END AS ANS_CONF_CCO,                                                                                               " + CRLF
    cQry+="     CASE WHEN SIB_CODCCO = BA1_CODCCO THEN ' '             WHEN SIB_MATRIC <> ' ' THEN SIB_CODCCO                                   " + CRLF
    cQry+="         ELSE ' ' END AS ANS_CCO,                                                                                                    " + CRLF
    cQry+="     CASE WHEN SIB_NUMPLA = BI3.BI3_SUSEP  THEN 'PLANO CORRETO' WHEN SIB_MATRIC <> ' ' THEN 'PLANO INCONSISTENTE'                    " + CRLF
    cQry+="         ELSE ' ' END AS ANS_CONF_PLANO, SIB_NUMPLA AS NUM_ANS_PLANO,                                                                " + CRLF
    cQry+="     CASE WHEN SIB_NUMPLA = BI3.BI3_SUSEP OR SIB_NUMPLA = ' ' THEN ' ' WHEN SIB_MATRIC <> ' ' THEN TO_CHAR(BIY.PLANOS_SUSEP)         " + CRLF
    cQry+="         ELSE ' ' END AS ANS_PLANO,                                                                                                  " + CRLF
    cQry+="     CASE WHEN SIB_NOMUSR = BA1_NOMUSR THEN 'NOME CORRETO'   WHEN SIB_MATRIC <> ' ' THEN 'NOME INCONSISTENTE'                        " + CRLF
    cQry+="         ELSE ' ' END AS ANS_CONF_NOME,                                                                                              " + CRLF
    cQry+="     CASE WHEN SIB_NOMUSR = BA1_NOMUSR THEN ' '             WHEN SIB_MATRIC <> ' ' THEN SIB_NOMUSR                                   " + CRLF
    cQry+="         ELSE ' ' END AS ANS_NOME,                                                                                                   " + CRLF
    cQry+="     CASE WHEN SIB_CPFUSR = BA1_CPFUSR THEN 'CPF CORRETO'   WHEN SIB_MATRIC <> ' ' THEN 'CPF INCONSISTENTE'                          " + CRLF
    cQry+="         ELSE ' ' END AS ANS_CONF_CPF,                                                                                               " + CRLF
    cQry+="     CASE WHEN SIB_CPFUSR = BA1_CPFUSR THEN ' '             WHEN SIB_MATRIC <> ' ' THEN SIB_CPFUSR                                   " + CRLF
    cQry+="         ELSE ' ' END AS ANS_CPF                                                                                                     " + CRLF
    cQry+=" FROM "+ RETSQLNAME("BA1")+" BA1                                                                                                     " + CRLF
    cQry+="     INNER JOIN "+ RETSQLNAME("BG9")+" BG9 ON ( BG9_FILIAL = BA1_FILIAL AND BG9_CODINT = BA1_CODINT AND BG9_CODIGO = BA1_CODEMP)     " + CRLF
    cQry+="     INNER JOIN "+ RETSQLNAME("BQC")+" BQC ON ( BQC_FILIAL = BA1_FILIAL AND BQC_CODIGO = BA1_CODINT||BA1_CODEMP                      " + CRLF
    cQry+="         AND BQC_NUMCON = BA1_CONEMP AND BQC_VERCON = BA1_VERCON AND BQC_SUBCON = BA1_SUBCON AND BQC_VERSUB = BA1_VERSUB)            " + CRLF
    cQry+="     INNER JOIN "+ RETSQLNAME("BI3")+" BI3 ON ( BI3.BI3_FILIAL = BA1_FILIAL AND BI3.BI3_CODINT = BA1_CODINT                          " + CRLF
    cQry+="         AND BI3.BI3_CODIGO = BA1_CODPLA AND BI3.BI3_VERSAO = BA1_VERSAO)                                                            " + CRLF
    cQry+="     INNER JOIN "+ RETSQLNAME("BTS")+" BTS ON ( BTS_FILIAL = BA1_FILIAL AND BTS_MATVID = BA1_MATVID)                                 " + CRLF
    cQry+="     LEFT JOIN "+  RETSQLNAME("BG3")+" BG3 ON ( BG3.D_E_L_E_T_ = ' ' AND BG3_FILIAL = BA1_FILIAL                                     " + CRLF
    cQry+="         AND BG3_CODBLO = BA1_MOTBLO AND BA1_CONSID = 'U')                                                                           " + CRLF
    cQry+="     LEFT JOIN "+  RETSQLNAME("BG1")+" BG1 ON ( BG1.D_E_L_E_T_ = ' ' AND BG1_FILIAL = BA1_FILIAL                                     " + CRLF
    cQry+="         AND BG1_CODBLO = BA1_MOTBLO AND BA1_CONSID = 'F')                                                                           " + CRLF
    cQry+="     LEFT JOIN "+  RETSQLNAME("BQU")+" BQU ON ( BQU.D_E_L_E_T_ = ' ' AND BQU_FILIAL = BA1_FILIAL                                     " + CRLF
    cQry+="         AND BQU_CODBLO = BA1_MOTBLO AND BA1_CONSID = 'S')                                                                           " + CRLF
    cQry+="     LEFT JOIN CONFSIB_CAB SIB ON (SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO)                          " + CRLF
    cQry+="     LEFT JOIN (                                                                                                                     " + CRLF
    cQry+="        SELECT                                                                                                                       " + CRLF
    cQry+="             BIX.BI3_SUSEP, WM_CONCAT(BIX.BI3_CODIGO || '-' || TRIM(BIX.BI3_DESCRI)) AS PLANOS_SUSEP                                 " + CRLF
    cQry+="        FROM "+   RETSQLNAME("BI3")+" BIX                                                                                            " + CRLF
    cQry+="        WHERE BIX.D_E_L_E_T_ = ' '                                                                                                   " + CRLF
    cQry+="            AND BIX.BI3_FILIAL = '  '                                                                                                " + CRLF
    cQry+="            AND BIX.BI3_SUSEP <> ' '                                                                                                 " + CRLF
    cQry+="        GROUP BY BIX.BI3_SUSEP) BIY ON (BIY.BI3_SUSEP = SIB_NUMPLA)                                                                  " + CRLF
    cQry+=" WHERE                                                                                                                               " + CRLF
    cQry+="     BA1.D_E_L_E_T_ = ' ' AND BG9.D_E_L_E_T_ = ' ' AND BQC.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' '  AND BTS.D_E_L_E_T_ = ' '       " + CRLF
    cQry+="     AND BA1_FILIAL = '  '                                                                                                           " + CRLF
    cQry+="     AND BA1_CODINT = '"+PLSINTPAD()+"'                                                                                              " + CRLF
    IF EMPTY(MV_PAR01)
        MV_PAR01 := ' '
    ENDIF
    IF EMPTY(MV_PAR02)
        MV_PAR02 := 'ZZZZ'
    ENDIF
    cQry+="     AND BA1_CODEMP BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'                                                                        " + CRLF
    cQry+="     AND (   (                                                                                                                       " + CRLF
    
    IF !EMPTY(MV_PAR03) .AND. !EMPTY(MV_PAR04)                      
        cQry+="      BA1_DATINC BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"'                                                           " + CRLF
    ELSEIF !EMPTY(MV_PAR03) .AND. EMPTY(MV_PAR04)                           
        cQry+="      BA1_DATINC >= '"+DTOS(MV_PAR03)+"'                                                                                         " + CRLF
    ELSEIF EMPTY(MV_PAR03) .AND. !EMPTY(MV_PAR04)                           
        cQry+="      BA1_DATINC <= '"+DTOS(MV_PAR04)+"'                                                                                         " + CRLF
    ELSE
        cQry+="     1 = 1                                                                                                                       " + CRLF
    ENDIF 
    cQry+="       )  OR (                                                                                                                       " + CRLF
    IF !EMPTY(MV_PAR05) .AND. !EMPTY(MV_PAR06)                      
        cQry+="      BA1_DATBLO BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"'                                                           " + CRLF
    ELSEIF !EMPTY(MV_PAR05) .AND. EMPTY(MV_PAR06)                           
        cQry+="      BA1_DATBLO >= '"+DTOS(MV_PAR05)+"'                                                                                         " + CRLF
    ELSEIF EMPTY(MV_PAR05) .AND. !EMPTY(MV_PAR06)                           
        cQry+="      BA1_DATBLO <= '"+DTOS(MV_PAR06)+"'                                                                                         " + CRLF
    ELSE
        cQry+="     1 = 1                                                                                                                       " + CRLF
    ENDIF       
    cQry+="    ) )                                                                                                                              " + CRLF
    IF !EMPTY(MV_PAR07)
        cQry+="     AND BA1_LOCSIB IN ('"+AllTrim(StrTran(MV_PAR07, ",", "','")) + "')                                                                      " + CRLF
    ENDIF
    cQry+=" ORDER BY BA1_FILIAL, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG                                                                 " + CRLF

    cQry    := ChangeQuery(cQry)

    dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

    dbSelectArea(cAliasBOL)
    (cAliasBOL)->(dbgotop())	

    oReport:SetMeter((cAliasBOL)->(LastRec()))	  

    //Imprime os dados do relatorio
    If (cAliasBOL)->(Eof())
        Alert("Nao foram encontrados dados!")
    Else

        oSection2:Init()

        While  !(cAliasBOL)->(Eof())       
                
            oReport:IncMeter()
            oSection2:PrintLine()
                
            (cAliasBOL)->(DbSkip())
        Enddo   
                                
        oReport:FatLine()
        oReport:Section(1):Finish()

        (cAliasBOL)->(DbCloseArea())

    EndIf

Return

Static Function AjustaSX1_2(cPerg)

Local aHelpPor := {} 


aHelpPor := {}
AADD(aHelpPor,"Informe:			")

    u_CABASX1(cPerg,"01","Empresa de"		    ,"","","MV_CH1" ,"C", 4,0,0,"G","","BG9PLS" , "","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
    u_CABASX1(cPerg,"02","Empresa ate"  	    ,"","","MV_CH2" ,"C", 4,0,0,"G","","BG9PLS" , "","","MV_PAR02","","","","","","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"03","Data de Inclusao de" 	,"","","MV_CH3" ,"D", 8,0,0,"G","",""       , "","","MV_PAR03","","","","","","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"04","Data de Inclusao ate" ,"","","MV_CH4" ,"D", 8,0,0,"G","",""       , "","","MV_PAR04","","","","","","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"05","Data de Bloqueio de" 	,"","","MV_CH5" ,"D", 8,0,0,"G","",""       , "","","MV_PAR05","","","","","","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"06","Data de Bloqueio ate" ,"","","MV_CH6" ,"D", 8,0,0,"G","",""       , "","","MV_PAR06","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(cPerg,"07","Status ANS:  "        ,"","","MV_CH7" ,"C",30,0,0,"G","","CBR314" , "","","MV_PAR07","","","","","","","","","","","","","","","","",{},{},{})
Return()
