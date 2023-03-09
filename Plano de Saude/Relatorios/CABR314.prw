#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"

#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR314
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 06/09/2022
/*/
USER FUNCTION CABR314()

Local oReport
Local aArea     := GetArea()
Private cPerg   := "CABR314"

AjustaSX1_2(cPerg)

IF !Pergunte(cPerg, .T.)
    Return
Endif

oReport := ReportH()
oReport:PrintDialog()

RestArea(aArea)

RETURN



Static Function ReportH()
                                                            
Local oSection2
Local oReport
Local aAreaSM0      := SM0->(GetArea())   
Local cTit          := "Relatório de Conferencia do SIB"

oReport := TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)}, cTit)
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.T.)

Pergunte(oReport:uParam,.F.)
                                
oSection2 := TRSection():New(oReport,"Relatório de Conferencia do SIB",)

TRCell():New(oSection2,""    	,,"Codigo Empresa"              , ""	,10	   ,.F.,{|| (cAliasBOL)->BA1_CODEMP }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Descricao"  	                , ""	,20	   ,.F.,{|| (cAliasBOL)->BG9_DESCRI }  	,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Contrato"  	                , ""	,10	   ,.F.,{|| (cAliasBOL)->BA1_CONEMP }  	,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"SubContrato" 	            , ""	,10	   ,.F.,{|| (cAliasBOL)->BA1_SUBCON }  	,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Desc. SubContrato" 	        , ""	,10	   ,.F.,{|| (cAliasBOL)->BQC_DESCRI }  	,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Matricula"  	                , ""	,15	   ,.F.,{|| (cAliasBOL)->MATRIC     }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Nome"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_NOMUSR }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"CPF"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CPFUSR }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"RG"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->BTS_DRGUSR }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Cod. Plano"                  , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CODPLA }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Desc. Plano"                 , ""	,30    ,.F.,{|| (cAliasBOL)->BI3_DESCRI }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Dt. Nasc."                   , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_DATNAS }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Tipo de Benef."              , ""	,30    ,.F.,{|| (cAliasBOL)->BIH_DESCRI }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Grau Parentesco"             , ""	,30    ,.F.,{|| (cAliasBOL)->BRP_DESCRI }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Sexo"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_SEXO   }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Estado Civil"                , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_ESTCIV }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Nr Cartao Nacional Saude"    , ""	,30    ,.F.,{|| (cAliasBOL)->BTS_NRCRNA }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Cod. CCO"  	                , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CODCCO }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Dt. Inclusao"  	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_DATINC }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Data Bloq."  	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_DATBLO }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Motivo Bloq."  	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_MOTBLO }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Desc. Bloq."  	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_DESBLO }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Bloq. ANS"     	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_BLQANS }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Consid. Ans"  	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_INFANS }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Atualiza SIB"  	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_ATUSIB }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Consid. SIB"  	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_INFSIB }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Contrato - Inf. ANS"         , ""	,03    ,.F.,{|| (cAliasBOL)->BT5_INFANS }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Subcontr. - Inf. ANS"        , ""	,03    ,.F.,{|| (cAliasBOL)->BQC_INFANS }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Produto - Inf. ANS"          , ""	,03    ,.F.,{|| (cAliasBOL)->BI3_INFANS }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Status ANS"  	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_LOCSIB }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Tipo de Endereco"            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_TIPEND }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Reside no Exterior?"  	    , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_RESEXT }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Estado"  	                , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_ESTADO }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"CEP"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CEPUSR }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Codigo Municipio	"           , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CODMUN }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Municipio"  	                , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_MUNICI }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Bairro"  	                , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_BAIRRO }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Endereco"  	                , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_ENDERE }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Numero"  	                , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_NR_END }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Complemento"  	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_COMEND }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Mae"           	            , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_MAE    }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"CPF Mae	"  	                , ""	,30    ,.F.,{|| (cAliasBOL)->BA1_CPFMAE }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Data de retorno do SIB"  	, ""	,30    ,.F.,{|| (cAliasBOL)->BA1_DTRSIB }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Data de inscricao na ANS"  	, ""	,30    ,.F.,{|| (cAliasBOL)->BA1_INCANS }   ,"LEFT"  ,.T. ,"LEFT" )
TRCell():New(oSection2,""    	,,"Data de exclusao na ANS"  	, ""	,30    ,.F.,{|| (cAliasBOL)->BA1_EXCANS }   ,"LEFT"  ,.T. ,"LEFT" )

RestArea( aAreaSM0 )

Return(oReport)



Static Function ReportPrt(oReport)

Local oSection2 
Private cAliasBOL   := GetNextAlias()

oSection2 := oReport:Section(1)

cQry:=" SELECT                                                                                                                                          " + CRLF
cQry+="     BA1_CODEMP, TRIM(BG9_DESCRI) AS BG9_DESCRI, BA1_CONEMP, BA1_SUBCON, TRIM(BQC_DESCRI) AS BQC_DESCRI,                                         " + CRLF
cQry+="     BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO as MATRIC, TRIM(BA1_NOMUSR) AS BA1_NOMUSR,                                       " + CRLF
cQry+="     BA1_CPFUSR, BTS_DRGUSR, BA1_CODPLA, TRIM(BI3_DESCRI) AS BI3_DESCRI, TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD') AS BA1_DATNAS,                     " + CRLF
cQry+="     TRIM(BIH_DESCRI) AS BIH_DESCRI, BA1_GRAUPA || '-' || TRIM(BRP_DESCRI) AS BRP_DESCRI,                                                        " + CRLF
cQry+="     DECODE(BA1_SEXO,'1','MASCULINO','2','FEMININO') AS BA1_SEXO, BA1_ESTCIV || '-' || TRIM(UPPER(X5_DESCRI)) AS BA1_ESTCIV,                     " + CRLF
cQry+="     BTS_NRCRNA, BA1_CODCCO, TO_DATE(TRIM(BA1_DATINC),'YYYYMMDD') AS BA1_DATINC, TO_DATE(TRIM(BA1_DATBLO),'YYYYMMDD') AS BA1_DATBLO,             " + CRLF
cQry+="     BA1_MOTBLO, TRIM(UPPER( CASE WHEN BA1_CONSID = 'U' THEN BG3_DESBLO ELSE                                                                     " + CRLF
cQry+="                             CASE WHEN BA1_CONSID = 'F' THEN BG1_DESBLO ELSE                                                                     " + CRLF
cQry+="                             CASE WHEN BA1_CONSID = 'S' THEN BQU_DESBLO ELSE ' ' END END END)) AS BA1_DESBLO,                                    " + CRLF
cQry+="     TRIM( CASE WHEN BA1_CONSID = 'U' THEN BG3_BLQANS ELSE                                                                                       " + CRLF
cQry+="             CASE WHEN BA1_CONSID = 'F' THEN BG1_BLQANS ELSE                                                                                     " + CRLF
cQry+="             CASE WHEN BA1_CONSID = 'S' THEN BQU_BLQANS ELSE ' ' END END END) AS BA1_BLQANS,                                                     " + CRLF
cQry+="     DECODE(BA1_INFANS,'1','SIM','0','NAO') AS BA1_INFANS, DECODE(BA1_ATUSIB,'1','SIM','0','NAO') AS BA1_ATUSIB,                                 " + CRLF
cQry+="     DECODE(BA1_INFSIB,'1','SIM','0','NAO') AS BA1_INFSIB, DECODE(BT5_INFANS,'1','SIM','0','NAO') AS BT5_INFANS,                                 " + CRLF
cQry+="     DECODE(BQC_INFANS,'1','SIM','0','NAO') AS BQC_INFANS, DECODE(BI3_INFANS,'1','SIM','0','NAO') AS BI3_INFANS,                                 " + CRLF
cQry+="     DECODE(BA1_LOCSIB,'0','NAO ENVIADO','1','ATIVO','2','EXCLUIDO','3','ENVIADO INCLUSAO','4','ENVIADO ALTERACAO','5','ENVIADO EXCLUSAO',       " + CRLF
cQry+="                       '6','CRITICADO INCLUSAO','7','CRITICADO ALTERACAO','8','CRITICADO EXCLUSAO','9','ENVIADO MUDANCA CONTRATUAL',             " + CRLF
cQry+="                       'A','ENVIADO REATIVACAO','B','CRITICADO MUDANCA CONTRATUAL','C','CRITICADO REATIVACAO') AS BA1_LOCSIB,                    " + CRLF
cQry+="     DECODE(BA1_TIPEND,'1','PROFISSIONAL','2','RESIDENCIAL') AS BA1_TIPEND,                                                                      " + CRLF
cQry+="     DECODE(BA1_RESEXT,'0','NAO RESIDE EXTERIOR','1','RESIDE EXTERIOR') AS BA1_RESEXT,                                                           " + CRLF
cQry+="     BA1_ESTADO, BA1_CEPUSR, BA1_CODMUN, TRIM(BA1_MUNICI) AS BA1_MUNICI, TRIM(BA1_BAIRRO) AS BA1_BAIRRO,                                         " + CRLF
cQry+="     TRIM(UPPER(BA1_ENDERE)) AS BA1_ENDERE, TRIM(BA1_NR_END) AS BA1_NR_END, TRIM(UPPER(BA1_COMEND)) AS BA1_COMEND, TRIM(BA1_MAE) AS BA1_MAE,     " + CRLF
cQry+="     BA1_CPFMAE, TO_DATE(TRIM(BA1_DTRSIB),'YYYYMMDD') AS BA1_DTRSIB, TO_DATE(TRIM(BA1_INCANS),'YYYYMMDD') AS BA1_INCANS,                         " + CRLF
cQry+="     TO_DATE(TRIM(BA1_EXCANS),'YYYYMMDD') AS BA1_EXCANS                                                                                          " + CRLF
cQry+=" FROM                                                                                                                                            " + CRLF
cQry+="     "+RETSQLNAME("BA1")+" BA1                                                                                                                   " + CRLF
cQry+="     INNER JOIN "+RETSQLNAME("BG9")+" BG9 ON (BG9_FILIAL = BA1_FILIAL AND BG9_CODINT = BA1_CODINT AND BG9_CODIGO = BA1_CODEMP)                   " + CRLF
cQry+="     INNER JOIN "+RetSqlName("BT5")+" BT5 ON (BT5_FILIAL = BA1_FILIAL AND BT5_CODINT = BA1_CODINT AND BT5_CODIGO = BA1_CODEMP                    " + CRLF
cQry+="                                                AND BT5_NUMCON = BA1_CONEMP AND BT5_VERSAO = BA1_VERCON)                                         " + CRLF
cQry+="     INNER JOIN "+RETSQLNAME("BQC")+" BQC ON (BQC_FILIAL = BA1_FILIAL AND BQC_CODIGO = BA1_CODINT||BA1_CODEMP AND BQC_NUMCON = BA1_CONEMP        " + CRLF
cQry+="                                                AND BQC_VERCON = BA1_VERCON AND BQC_SUBCON = BA1_SUBCON AND BQC_VERSUB = BA1_VERSUB)             " + CRLF
cQry+="     INNER JOIN "+RETSQLNAME("BI3")+" BI3 ON (BI3_FILIAL = BA1_FILIAL AND BI3_CODINT = BA1_CODINT AND BI3_CODIGO = BA1_CODPLA                    " + CRLF
cQry+="                                              AND BI3_VERSAO = BA1_VERSAO)                                                                       " + CRLF
cQry+="     INNER JOIN "+RETSQLNAME("BIH")+" BIH ON (BIH_FILIAL = BA1_FILIAL AND BIH_CODTIP = BA1_TIPUSU)                                               " + CRLF
cQry+="     INNER JOIN "+RETSQLNAME("BRP")+" BRP ON (BRP_FILIAL = BA1_FILIAL AND BRP_CODIGO = BA1_GRAUPA)                                               " + CRLF
cQry+="     INNER JOIN "+RETSQLNAME("BTS")+" BTS ON (BTS_FILIAL = BA1_FILIAL AND BTS_MATVID = BA1_MATVID)                                               " + CRLF
cQry+="     LEFT JOIN "+RETSQLNAME("SX5")+" SX5 ON (SX5.D_E_L_E_T_ = ' ' AND X5_FILIAL = '  ' AND X5_TABELA = '33' AND TRIM(X5_CHAVE) = BA1_ESTCIV)     " + CRLF
cQry+="     LEFT JOIN "+RETSQLNAME("BG3")+" BG3 ON (BG3.D_E_L_E_T_ = ' ' AND BG3_FILIAL = BA1_FILIAL AND BG3_CODBLO = BA1_MOTBLO AND BA1_CONSID = 'U')  " + CRLF
cQry+="     LEFT JOIN "+RETSQLNAME("BG1")+" BG1 ON (BG1.D_E_L_E_T_ = ' ' AND BG1_FILIAL = BA1_FILIAL AND BG1_CODBLO = BA1_MOTBLO AND BA1_CONSID = 'F')  " + CRLF
cQry+="     LEFT JOIN "+RETSQLNAME("BQU")+" BQU ON (BQU.D_E_L_E_T_ = ' ' AND BQU_FILIAL = BA1_FILIAL AND BQU_CODBLO = BA1_MOTBLO AND BA1_CONSID = 'S')  " + CRLF
cQry+=" WHERE                                                                                                                                           " + CRLF
cQry+="     BA1.D_E_L_E_T_ = ' ' AND BG9.D_E_L_E_T_ = ' ' AND BQC.D_E_L_E_T_ = ' ' AND BI3.D_E_L_E_T_ = ' '                                             " + CRLF
cQry+="     AND BIH.D_E_L_E_T_ = ' ' AND BRP.D_E_L_E_T_ = ' ' AND BTS.D_E_L_E_T_ = ' '                                                                  " + CRLF
cQry+="     AND BA1_FILIAL = '  '                                                                                                                       " + CRLF
cQry+="     AND BA1_CODINT = '"+PLSINTPAD()+"'                                                                                                          " + CRLF
cQry+="     AND BA1_CODEMP BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'                                                                                    " + CRLF
cQry+="     AND (   (                                                                                                                                   " + CRLF
IF !EMPTY(MV_PAR03) .AND. !EMPTY(MV_PAR04)                      
    cQry+="      BA1_DATINC BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"'                                                                       " + CRLF
ELSEIF !EMPTY(MV_PAR03) .AND. EMPTY(MV_PAR04)                                           
    cQry+="      BA1_DATINC >= '"+DTOS(MV_PAR03)+"'                                                                                                     " + CRLF
ELSEIF EMPTY(MV_PAR03) .AND. !EMPTY(MV_PAR04)                                           
    cQry+="      BA1_DATINC <= '"+DTOS(MV_PAR04)+"'                                                                                                     " + CRLF
ELSE
    cQry+="     1 = 1                                                                                                                   " + CRLF
ENDIF                   
cQry+="     )   OR (                                                                                                                                    " + CRLF
IF !EMPTY(MV_PAR05) .AND. !EMPTY(MV_PAR06)                      
    cQry+="      BA1_DATBLO BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"'                                                                       " + CRLF
ELSEIF !EMPTY(MV_PAR05) .AND. EMPTY(MV_PAR06)                                           
    cQry+="      BA1_DATBLO >= '"+DTOS(MV_PAR05)+"'                                                                                                     " + CRLF
ELSEIF EMPTY(MV_PAR05) .AND. !EMPTY(MV_PAR06)                                           
    cQry+="      BA1_DATBLO <= '"+DTOS(MV_PAR06)+"'                                                                                                     " + CRLF
ELSE
    cQry+="     1 = 1                                                                                                                   " + CRLF
ENDIF        
cQry+="     )   )                                                                                                                                       " + CRLF
IF !EMPTY(MV_PAR07)
    cQry+="     AND BA1_LOCSIB IN ('"+AllTrim(StrTran(MV_PAR07, ",", "','")) + "')                                                                      " + CRLF
ENDIF

if MV_PAR08 == 1
    cQry += " AND BA1_INFANS <> '0' AND BA1_ATUSIB <> '0' AND BA1_INFSIB <> '0'"
    cQry += " AND BT5_INFANS <> '0' AND BQC_INFANS <> '0' AND BI3_INFANS <> '0'"
endif

cQry+="     ORDER BY BA1_FILIAL, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG                                                                         " + CRLF

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

User Function CABR314A()

Local cTitulo := "Status da ANS"
Local oOk  := LoadBitmap( GetResources(), "LBOK" )  //carrega bitmap quadrado com X
Local oNo  := LoadBitmap( GetResources(), "LBNO" )  //carrega bitmap soh o quadrado
// Local oChk  := Nil
// Local cAlias := GetNextAlias()
Local cStatus 

Private lChk := .F.
Private oLbx := Nil
Private aVetor := {}
Private oDlg

aAdd( aVetor, { .F., '0', 'NAO ENVIADO'                })
aAdd( aVetor, { .F., '1','ATIVO'                       })
aAdd( aVetor, { .F., '2','EXCLUIDO'                    })
aAdd( aVetor, { .F., '3','ENVIADO INCLUSAO'            })
aAdd( aVetor, { .F., '4','ENVIADO ALTERACAO'           })
aAdd( aVetor, { .F., '5','ENVIADO EXCLUSAO'            })
aAdd( aVetor, { .F., '6','CRITICADO INCLUSAO'          })
aAdd( aVetor, { .F., '7','CRITICADO ALTERACAO'         })
aAdd( aVetor, { .F., '8','CRITICADO EXCLUSAO'          })
aAdd( aVetor, { .F., '9','ENVIADO MUDANCA CONTRATUAL'  })
aAdd( aVetor, { .F., 'A','ENVIADO REATIVACAO'          })
aAdd( aVetor, { .F., 'B','CRITICADO MUDANCA CONTRATUAL'})
aAdd( aVetor, { .F., 'C','CRITICADO REATIVACAO'        })



DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se houver duplo clique, recebe ele mesmo negando, depois da um refresh³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 10,10 LISTBOX oLbx VAR cVar FIELDS HEADER " ", "Codigo","Descriçao";
SIZE 230,095 OF oDlg PIXEL ON dblClick(aVetor[oLbx:nAt,1] := !aVetor[oLbx:nAt,1], oLbx:Refresh())
oLbx:SetArray( aVetor )
oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo), aVetor[oLbx:nAt,2], aVetor[oLbx:nAt,3] }}

DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION (cStatus := U_CABR314B()) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTER

MV_PAR07 := cStatus

Return(.T.)

User Function CABR314B()

Local _i  := 0
Local cRet  := ""

for _i := 1 to len(aVetor)
    if aVetor[_i, 1]
        cRet += aVetor[_i, 2] + ","
    endif
next

cRet := iif(SubStr(cRet,len(cRet),1) == ",", SubStr(cRet,1,len(cRet)-1), cRet)
cRet := AllTrim(cRet) + Space(30-len(cRet))

oDlg:End()

return cRet


Static Function AjustaSX1_2(cPerg)

u_CABASX1(cPerg,"01","Empresa de"		    ,"","","MV_CH1" ,"C", 4,0,0,"G","","BG9PLS" , "","","MV_PAR01",""     ,"","","",""     ,"","","","","","","","","","","",{},{},{})
u_CABASX1(cPerg,"02","Empresa ate"  	    ,"","","MV_CH2" ,"C", 4,0,0,"G","","BG9PLS" , "","","MV_PAR02",""     ,"","","",""     ,"","","","","","","","","","","",{},{},{})
u_CABASX1(cPerg,"03","Data de Inclusao de" 	,"","","MV_CH3" ,"D", 8,0,0,"G","",""       , "","","MV_PAR03",""     ,"","","",""     ,"","","","","","","","","","","",{},{},{})
u_CABASX1(cPerg,"04","Data de Inclusao ate" ,"","","MV_CH4" ,"D", 8,0,0,"G","",""       , "","","MV_PAR04",""     ,"","","",""     ,"","","","","","","","","","","",{},{},{})
u_CABASX1(cPerg,"05","Data de Bloqueio de" 	,"","","MV_CH5" ,"D", 8,0,0,"G","",""       , "","","MV_PAR05",""     ,"","","",""     ,"","","","","","","","","","","",{},{},{})
u_CABASX1(cPerg,"06","Data de Bloqueio ate" ,"","","MV_CH6" ,"D", 8,0,0,"G","",""       , "","","MV_PAR06",""     ,"","","",""     ,"","","","","","","","","","","",{},{},{})
u_CABASX1(cPerg,"07","Status ANS:  "        ,"","","MV_CH7" ,"C",30,0,0,"G","","CBR314" , "","","MV_PAR07",""     ,"","","",""     ,"","","","","","","","","","","",{},{},{})
u_CABASX1(cPerg,"08","Considerar:"          ,"","","MV_CH8" ,"N", 1,0,0,"C","",""       , "","","MV_PAR08","Aptos","","","","Todos","","","","","","","","","","","",{},{},{})

Return
