#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

#DEFINE cEnt chr(10)+chr(13)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RCOMR01   ºAutor  ³ Vinícius Moreira   º Data ³20/09/2017  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão de cadastro de produtos em TReport simples.      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AcademiaERP                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR1001()
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³Declaracao de variaveis                   ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    Private oReport  := Nil
    Private oSection := Nil
    Private oSection1 := Nil
    Private oSection2 := Nil
    Private oSection3 := Nil
    Private cPerg 	 := PadR ("CABR1001", Len (SX1->X1_GRUPO))
    Private  nRegs	 := 0
    Private oBreak
    
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³Criacao e apresentacao das perguntas      ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    PutSx1(cPerg,"01","Empresa?"  ,'','',"mv_ch1","C",TamSx3 ("BA1_CODEMP")[1] ,0,,"G","","CABBG9","","","mv_par01","","","","","","","","","","","","","","","","")
    PutSx1(cPerg,"02","Contrato?"  ,'','',"mv_ch2","C",TamSx3 ("BA1_CONEMP")[1] ,0,,"G","","CAB101","","","mv_par02","","","","","","","","","","","","","","","","")
    PutSx1(cPerg,"03","SubContrato?"  ,'','',"mv_ch3","C",TamSx3 ("BA1_SUBCON")[1] ,0,,"G","","CB1012","","","mv_par03","","","","","","","","","","","","","","","","")
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³Definicoes/preparacao para impressao      ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    ReportDef()
    oReport:PrintDialog()
    
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³ Vinícius Moreira   º Data ³ 22/09/2017  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definição da estrutura do relatório.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
    
    
    oReport := TReport():New("CABR1001","Questionário de Doenças Pré Existentes",cPerg,{|oReport| PrintReport(oReport)},"Impressão de Questionário de Doenças Pré Existentes .")
    oReport:SetLandscape(.T.)
    
    oSection1 := TRSection():New( oReport , "Empresa",)
    
    TRCell():New(oSection1,'EMPRESA' ,'',"Empresa" , ,100,,{|| MV_PAR01		})
    
    oSection2 := TRSection():New( oReport , "Total de Beneficiários",)
    
    TRCell():New(oSection2,'TOTVIDAS','',"Total de Beneficiários " , ,100,,{|| /*cvaltochar(QRY->TOTVIDAS)*/	})
    
    oSection3 := TRSection():New( oReport , "Total de beneficiários que não responderam o questionário",)
    
    TRCell():New(oSection3,'QTDVIDAS','', "Total de beneficiários que não responderam o questionário", ,100,,{|| /*cvaltochar(nRegs)	*/		})
    
    
    oSection := TRSection():New( oReport , "Titulares e Dependentes", {"QRY"} )
    
    TRCell():New(oSection ,'MATRICULA'	,"QRY",'MATRICULA'				, /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'BA1_NOMUSR'	,"QRY",'NOME'					,/*Picture*/	,200	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'BA1_TELEFO'	,"QRY",'TELEFONE'	    		,PesqPict("BA1", "BA1_TELEFO" )/*Picture*/	,100	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    //TRCell():New(oSection ,'BA1_YTEL2'	,"QRY",'TELEFONE 2'				,/*Picture*/	,100	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'BA1_YCEL'	,"QRY",'CELULAR'				,PesqPict("BA1", "BA1_YCEL" )/*Picture*/	,130		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    TRCell():New(oSection ,'BA1_DATINC' ,"QRY",'DATA DE INCLUSÃO'		,/*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    //TRCell():New(oSection ,'CODCONTRATO' 	,"QRY",'VIDA EMPRESA'		,/*Picture*/	,10		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
    //oSection:Cell("CODCONTRATO"):Hide()
    
    //	oBreak := TRBreak():New(oSection,oSection:Cell("CODCONTRATO"),"Quantidade de Beneficiários")
    //	TRFunction():New(oSection:Cell("CODCONTRATO"),NIL,"COUNT",oBreak)
    
    
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RCOMR01   ºAutor  ³ Mateus Medeiros   º Data ³ 12/11/2013  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
    
    Local cQuery     := ""
    Local cNomEmp	 := ""
    Local _cAlias	 := GetNextAlias()
    Local cSubCon    := ""
    
    
    Pergunte(cPerg,.F.)
    
    /*
    cQuery := "SELECT MATRICULA,BA1_NOMUSR ,BA1_TELEFO,BA1_YCEL,BA1_DATINC,TOTVIDAS 													" + cEnt
    cQuery += "FROM  																													" + cEnt
    cQuery += "	(																														" + cEnt
    cQuery += "	SELECT BA1_CODINT|| BA1_CODEMP|| BA1_MATRIC|| BA1_TIPREG|| BA1_DIGITO MATRICULA, BA1_NOMUSR, A.BA1_TELEFO, 				" + cEnt
    cQuery += "	       (SELECT COUNT(*) FROM "+RetSqlName("BA1")+" WHERE BA1_CODEMP = '"+mv_par01+"'  AND D_E_L_E_T_ = ' ' 			 	" + cEnt
    cQuery += "	AND BA1_DATBLO = ' ' ) TOTVIDAS,  A.BA1_YCEL,A.BA1_YTEL2,																" + cEnt
    cQuery += "	  TO_DATE(BA1_DATINC,'YYYYMMDD') BA1_DATINC 																			" + cEnt
    cQuery += " FROM "+RetSqlName("BA1")+" A																							" + cEnt
    cQuery += "	WHERE 																													" + cEnt
    cQuery += "	A.BA1_CODEMP = '"+mv_par01+"' AND BA1_DATBLO = ' ' AND A.D_E_L_E_T_ = ' ' AND 											" + cEnt
    cQuery += "	NOT EXISTS (SELECT A.*																									" + cEnt
    cQuery += "         FROM "+RetSqlName("BXA")+" B																					" + cEnt
    cQuery += "          WHERE (B.BXA_USUARI = BA1_CODINT|| BA1_CODEMP|| BA1_MATRIC|| BA1_TIPREG|| BA1_DIGITO) 							" + cEnt
    cQuery += " AND B.D_E_L_E_T_ = A.D_E_L_E_T_ AND BXA_CODQUE = '0023')  )A	ORDER BY MATRICULA  															" + cEnt
    */
    
    
    cQuery += "SELECT MATRICULA,CODCONTRATO,EMPCONTRA,DESCCONTRATO,TOTVIDAS,TOTVIDASSUBCONT,QTDRESPONDIDA ,BA1_NOMUSR ,             " + cEnt
    cQuery += "BA1_TELEFO,BA1_YCEL,BA1_DATINC,EMPRESA                                                                           " + cEnt
    cQuery += "FROM                                                                                                                 " + cEnt
    cQuery += "    (                                                                                                                " + cEnt
    cQuery += "    SELECT BA1_CODINT|| BA1_CODEMP|| BA1_MATRIC|| BA1_TIPREG|| BA1_DIGITO MATRICULA,                     " + cEnt
    cQuery += "  BA1_NOMUSR,'('||BA1_DDD ||')'||A.BA1_TELEFO BA1_TELEFO, BA1_CONEMP EMPCONTRA,BA1_CODEMP EMPRESA,                                                 " + cEnt
    //       -- QUANTIDADE DE VIDAS EMPRESA
    cQuery += "         (SELECT COUNT(*) FROM "+RetSqlName("BA1")+"  WHERE BA1_CODEMP = A.BA1_CODEMP  AND D_E_L_E_T_ = ' '          " + cEnt
    cQuery += "    AND BA1_DATBLO = ' ' ) TOTVIDAS,                                                                                 " + cEnt
    // -- QTD SUBCONTRATO
    cQuery += "(SELECT COUNT(*) FROM "+RetSqlName("BA1")+" WHERE BA1_CODEMP = A.BA1_CODEMP  AND D_E_L_E_T_ = ' '                    " + cEnt
    cQuery += "    AND BA1_DATBLO = ' ' AND BA1_CONEMP = A.BA1_CONEMP AND BA1_SUBCON = A.BA1_SUBCON    ) TOTVIDASSUBCONT,           " + cEnt
    // -- QTD RESPONDIDA
    cQuery += "   (SELECT COUNT(*) FROM "+RetSqlName("BA1")+"  C                                                                    " + cEnt
    cQuery += " WHERE C.BA1_CODEMP = A.BA1_CODEMP AND C.BA1_DATBLO = ' ' AND C.D_E_L_E_T_ = ' '                                     " + cEnt
    cQuery += " AND C.BA1_CONEMP =A.BA1_CONEMP AND BA1_SUBCON =  A.BA1_SUBCON                                                       " + cEnt
    cQuery += " AND    EXISTS (SELECT B.*                                                                                           " + cEnt
    cQuery += "         FROM "+RetSqlName("BXA")+"  B                                                                               " + cEnt
    cQuery += "         WHERE B.BXA_USUARI = C.BA1_CODINT|| C.BA1_CODEMP|| C.BA1_MATRIC|| C.BA1_TIPREG|| C.BA1_DIGITO               " + cEnt
    cQuery += "  AND B.D_E_L_E_T_ = ' ' AND BXA_CODQUE = '0023') ) QTDRESPONDIDA,                                                   " + cEnt
    cQuery += "  A.BA1_YCEL,A.BA1_YTEL2,                                                                                            " + cEnt
    cQuery += "      TO_DATE(BA1_DATINC,'YYYYMMDD') BA1_DATINC,                                                                     " + cEnt
    cQuery += "    C.BQC_DESCRI DESCCONTRATO,  C.BQC_SUBCON CODCONTRATO                                                             " + cEnt
    cQuery += " FROM "+RetSqlName("BA1")+"  A                                                                                       " + cEnt
    cQuery += " INNER JOIN "+RetSqlName("BQC")+" C ON BQC_NUMCON = A.BA1_CONEMP                                                     " + cEnt
    cQuery += "    AND BQC_SUBCON = A.BA1_SUBCON AND C.BQC_CODEMP = A.BA1_CODEMP                                                    " + cEnt
    cQuery += "    AND C.D_E_L_E_T_ = ' '                                                                                           " + cEnt
    cQuery += "    WHERE                                                                                                            " + cEnt
    cQuery += "    A.BA1_CODEMP = '"+mv_par01+"' AND BA1_DATBLO = ' ' AND A.D_E_L_E_T_ = ' '                                        " + cEnt
    if !Empty(mv_par02)
        cQuery += "    AND A.BA1_CONEMP = '"+mv_par02+"'                                                                                " + cEnt
    endif
    if !Empty(mv_par03)
        cQuery += "    AND BA1_SUBCON = '"+mv_par03+"'                                                                                  " + cEnt
    endif
    cQuery += "    AND NOT EXISTS (SELECT B.*                                                                                       " + cEnt
    cQuery += "         FROM "+RetSqlName("BXA")+" B                                                                                " + cEnt
    cQuery += "          WHERE                                                                                                      " + cEnt
    cQuery += "          (B.BXA_USUARI = A.BA1_CODINT|| A.BA1_CODEMP|| A.BA1_MATRIC|| A.BA1_TIPREG|| A.BA1_DIGITO) AND              " + cEnt
    cQuery += "  B.D_E_L_E_T_ =' ' AND BXA_CODQUE = '0023')  )A                                                                     " + cEnt
    cQuery += " ORDER BY 2,1                                                                                                        " + cEnt
    
    
    cQuery := ChangeQuery(cQuery)
    
    TcQuery cQuery New Alias "QRY"
    QRY->(dbGoTop())
    QRY->(dbEval({||nRegs++},,{|| QRY->(!Eof())}))
    QRY->(dbGoTop())
    
    oReport:SetMeter(nRegs)
    
    BeginSql alias _cAlias
        
        SELECT BG9_DESCRI FROM %TABLE:BG9%
        WHERE BG9_CODIGO = %EXP:MV_PAR01%
        AND D_E_L_E_T_ = ' '
        
    EndSql
    
    if (_cAlias)->(!Eof())
        cNomEmp := (_cAlias)->BG9_DESCRI
    endif
    
    if select(_cAlias) > 0
        dbselectarea(_cAlias)
        dbclosearea()
    endif
    
    //inicializo a primeira seção
    oSection1:Init()
    oSection1:Cell("EMPRESA"):SetValue(MV_PAR01 +" - "+ alltrim(cNomEmp)	)
    oSection1:Printline()
    oSection1:Finish()
    oReport:ThinLine()
            
    //inicializo a primeira seção
  /*  oSection2:Init()
    oSection2:Cell("TOTVIDAS"):SetValue(cvaltochar(QRY->TOTVIDAS))
    oSection2:Printline()
    oSection2:Finish()
    //inicializo a terceira seção
    oSection3:Init()
    oSection3:Cell("QTDVIDAS"):SetValue(cValToChar(nRegs))
    oSection3:Printline()
    oSection3:Finish()
    oReport:ThinLine()*/
    
    // inicio a quarta seção
    oSection:Init()
    //realiza a impressão da seção
    Do While QRY->(!Eof())
        // incrementa para de processamento
        oReport:IncMeter()
        
        if alltrim(cSubCon) # alltrim(QRY->CODCONTRATO)
            
            if !empty(cSubCon)
                // finaliza página a cada subcontrato diferente
                oReport:EndPage()
            endif
            cSubCon := QRY->CODCONTRATO
            //inicializo a primeira seção
            //inicializo a primeira seção
            oReport:SkipLine( )
            oReport:SkipLine( )
            
            //inicializo a primeira seção
            oSection1:Init()
            oSection1:Cell("EMPRESA"):SetValue(alltrim(QRY->CODCONTRATO) +" - "+ alltrim(QRY->DESCCONTRATO)    )
            oSection1:Printline()
            oSection1:Finish()
            //inicializo a primeira seção
            oSection2:Init()
            oSection2:Cell("TOTVIDAS"):SetValue(cvaltochar(QRY->TOTVIDASSUBCONT))
            oSection2:Printline()
            oSection2:Finish()
            //inicializo a terceira seção
            oSection3:Init()
            oSection3:Cell("QTDVIDAS"):SetValue(cValToChar(QRY->TOTVIDASSUBCONT - QRY->QTDRESPONDIDA))
            oSection3:Printline()
            oSection3:Finish()
            
          
        Endif
        
        //imprime linha da seção 1
        oSection:Printline()
        
        QRY->(dbskip())
    EndDo
    
    
    If Select("QRY") > 0
        Dbselectarea("QRY")
        QRY->(DbClosearea())
    EndIf
    
    //oSection:BeginQuery()
    //oSection:EndQuery({{"QRY"},cQuery})
    //oSection:Print()
    
    //finalizo a segunda seção para que seja reiniciada para o proximo registro
    oSection:Finish()
    //imprimo uma linha para separar as seções
    oReport:ThinLine()
    //finalizo a primeira seção
    oSection1:Finish()
    
Return Nil