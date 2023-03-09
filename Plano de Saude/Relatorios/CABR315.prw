#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR315
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 06/09/2022
/*/

USER FUNCTION CABR315()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR315"

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
Local cTit := "Relatório de Conferencia de Retorno do SIB"


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
                                
oSection2 := TRSection():New(oReport,"Relatório de Conferencia de Retorno do SIB",) 

    // Colunas do relatorio
    TRCell():New(oSection2,""    	,,"Cod. CCO"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_CODCCO }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Situacao"                        , ""	,10	   ,.F.,{|| (cAliasBOL)->SIB_SITUAC }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Data de Atualizacao"             , ""	,20	   ,.F.,{|| (cAliasBOL)->SIB_DT_ATU }  	        ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Nome"  	                        , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_NOMUSR }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"CPF"  	                        , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_CPFUSR }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"PIS/PASEP"                       , ""	,10	   ,.F.,{|| (cAliasBOL)->SIB_PISPAS }  	        ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Sexo"  	                        , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_SEXO   }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Dt. Nasc."                       , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_DATNAS }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Mae"           	                , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_MAE    }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Endereco"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_ENDERE }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Numero"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_NR_END }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Bairro"  	                    , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_BAIRRO }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Codigo Municipio	"               , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_CODMUN }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"CEP"  	                        , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_CEPUSR }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Reside no Exterior?"  	        , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_RESEXT }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Matricula"  	                    , ""	,15	   ,.F.,{|| (cAliasBOL)->SIB_MATRIC }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Grau Parentesco"                 , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_GRAUPA }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Data de Contratacao" 	        , ""	,10	   ,.F.,{|| (cAliasBOL)->SIB_DATCON }  	        ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Nro Plano ANS" 	                , ""	,10	   ,.F.,{|| (cAliasBOL)->SIB_NUMPLA }  	        ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Cobertura Parcial Temporaria"  	, ""	,30    ,.F.,{|| (cAliasBOL)->SIB_COBPAR }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Itens Excluido Cobertura"        , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_ITEXCO }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Cnpj da Empresa Contratante"     , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_CGCEMP }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"CNS"                             , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_CNS }              ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"Data de Cancelamento"            , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_DATCAN }           ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"CCO Titular"  	                , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_CCO_TITULAR }      ,"LEFT"  ,.T. ,"LEFT" )
    TRCell():New(oSection2,""    	,,"CNPJ Contratante"                , ""	,30    ,.F.,{|| (cAliasBOL)->SIB_CNPJ_CONTRATANTE } ,"LEFT"  ,.T. ,"LEFT" )


RestArea( aAreaSM0 )

Return(oReport)

Static Function ReportPrt(oReport)

Local oSection2 
Private cAliasBOL  := GetnextAlias()

oSection2 := oReport:Section(1)

    cQry:=" SELECT                                                                                                                          " + CRLF
    cQry+="     SIB_CODCCO, DECODE(SIB_SITUAC,'1','ATIVO','3','EXCLUIDO') AS SIB_SITUAC,                                                    " + CRLF
    cQry+="     TO_DATE(TRIM(SIB_DT_ATU),'YYYYMMDD') SIB_DT_ATU, SIB_NOMUSR, SIB_CPFUSR, SIB_PISPAS,                                        " + CRLF
    cQry+="     DECODE(SIB_SEXO,'1','MASCULINO','3','FEMININO') AS SIB_SEXO,                                                                " + CRLF
    cQry+="     TO_DATE(TRIM(SIB_DATNAS),'YYYYMMDD') SIB_DATNAS, SIB_MAE, SIB_ENDERE, SIB_NR_END, SIB_BAIRRO, SIB_CODMUN,                   " + CRLF
    cQry+="       SIB_CEPUSR, DECODE(SIB_RESEXT,'0','NAO RESIDE EXTERIOR','1','RESIDE EXTERIOR') AS SIB_RESEXT, SIB_MATRIC,                 " + CRLF
    cQry+="     DECODE(TRIM(SIB_GRAUPA),'1','BENEFICIARIO TITULAR','3','CONJUGE/COMPANHEIRO','4','FILHO/FILHA',                             " + CRLF
    cQry+="             '6', 'ENTEADO/ENTEADA', '8', 'PAI/MAE', '10', 'AGREGADO/OUTROS') SIB_GRAUPA,                                        " + CRLF
    cQry+="     TO_DATE(TRIM(SIB_DATCON),'YYYYMMDD') SIB_DATCON, SIB_NUMPLA,                                                                " + CRLF
    cQry+="     DECODE(SIB_COBPAR,'0','NAO POSSUI', '1','POSSUI') SIB_COBPAR, DECODE(SIB_ITEXCO,'0','NAO POSSUI', '1','POSSUI') SIB_ITEXCO, " + CRLF
    cQry+="     SIB_CGCEMP, SIB_CNS, TO_DATE(TRIM(SIB_DATCAN),'YYYYMMDD') SIB_DATCAN, SIB_CCO_TITULAR, SIB_CNPJ_CONTRATANTE                 " + CRLF
    cQry+=" FROM                                                                                                                            " + CRLF
    If cempant =='01'                       
        cQry+="    CONFSIB_CAB SIB                                                                                                          " + CRLF
    Else                        
        cQry+="    CONFSIB_INT SIB                                                                                                          " + CRLF
    EndIf                       
    cQry+=" WHERE                                                                                                                           " + CRLF
    IF MV_PAR05 = 1 //ATIVO                     
        cQry+="     SIB_SITUAC = '1'                                                                                                        " + CRLF
    ELSEIF MV_PAR05 = 2 // EXCLUIDO                     
        cQry+="     SIB_SITUAC = '3'                                                                                                        " + CRLF
    ELSEIF MV_PAR05 = 3 // TODOS                        
        cQry+="     1 = 1                                                                                                                   " + CRLF
    ENDIF        
    cQry+="     AND (   (                                                                                                                   " + CRLF
    IF !EMPTY(MV_PAR01) .AND. !EMPTY(MV_PAR02)                      
        cQry+="      SIB_DATCON BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'                                                       " + CRLF
    ELSEIF !EMPTY(MV_PAR01) .AND. EMPTY(MV_PAR02)                           
        cQry+="      SIB_DATCON >= '"+DTOS(MV_PAR01)+"'                                                                                     " + CRLF
    ELSEIF EMPTY(MV_PAR01) .AND. !EMPTY(MV_PAR02)                           
        cQry+="      SIB_DATCON <= '"+DTOS(MV_PAR02)+"'                                                                                     " + CRLF
    ELSE
        cQry+="     1 = 1                                                                                                                   " + CRLF
    ENDIF                       
    cQry+="     )   OR (                                                                                                                    " + CRLF
    IF !EMPTY(MV_PAR03) .AND. !EMPTY(MV_PAR04)                      
        cQry+="      SIB_DATCAN BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"'                                                       " + CRLF
    ELSEIF !EMPTY(MV_PAR03) .AND. EMPTY(MV_PAR04)                           
        cQry+="      SIB_DATCAN >= '"+DTOS(MV_PAR03)+"'                                                                                     " + CRLF
    ELSEIF EMPTY(MV_PAR03) .AND. !EMPTY(MV_PAR04)                           
        cQry+="      SIB_DATCAN <= '"+DTOS(MV_PAR04)+"'                                                                                     " + CRLF
    ELSE
        cQry+="     1 = 1                                                                                                                   " + CRLF
    ENDIF       
    cQry+="     )   )                                                                                                                       " + CRLF

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

Local aHelpPor	:= {} 


aHelpPor := {}
AADD(aHelpPor,"Informe:			")

    u_CABASX1(cPerg,"01","Data de Inclusao de" 	,"","","MV_CH1" ,"D", 8,0,0,"G","",""       , "","","MV_PAR01","","","","","","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"02","Data de Inclusao ate" ,"","","MV_CH2" ,"D", 8,0,0,"G","",""       , "","","MV_PAR02","","","","","","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"03","Data de Bloqueio de" 	,"","","MV_CH3" ,"D", 8,0,0,"G","",""       , "","","MV_PAR03","","","","","","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"04","Data de Bloqueio ate" ,"","","MV_CH4" ,"D", 8,0,0,"G","",""       , "","","MV_PAR04","","","","","","","","","","","","","","","","",{},{},{})
    u_CABASX1(cPerg,"05","Status ANS"			,"","","MV_CH5" ,"N", 1,0,0,"C","" ,""	    , "","","MV_PAR05","1 - ATIVO","1 - ATIVO" ,"1 - ATIVO" ,"","2 - EXCLUIDO","2 - EXCLUIDO" ,"2 - EXCLUIDO" ,"3 - TODOS","3 - TODOS","3 - TODOS","","","","","","",aHelpPor,{}      ,{},"")
Return()
