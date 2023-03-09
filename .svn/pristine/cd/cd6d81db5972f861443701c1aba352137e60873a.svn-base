#INCLUDE "PROTHEUS.CH"   
#INCLUDE "TOPCONN.CH"     
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)
/*
+===========================================================================+
+---------------------------------------------------------------------------+
|Programa   | CABR028	|Autor  | Luiz Otavio Campos  | Data |  03/03/21    |
+---------------------------------------------------------------------------+
|Descricao  | Relat?io de Log de Auditoria de Impressao de boletos.		 	|
|           | 																|
+---------------------------------------------------------------------------+
|Uso        | ESTOQUE									    |
+---------------------------------------------------------------------------+
+===========================================================================+
*/ 
User Function CABR028()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABRX28"

AjustaSx1(cPerg)

IF !Pergunte(cPerg, .T.)
	Return
Endif

oReport:= ReportDef()
oReport:PrintDialog()

RestArea(aArea)

Return
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function ReportDef()
                                      
Local oSection2
Local oSection1
Local oReport
//Local aOrdem    := {}
Local aAreaSM0  := SM0->(GetArea())   
Local cTit := "Relatório de Auditoria de Impessão de Boletos"
Private contador := 1

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
cDesl:= "Este relatorio tem como objetivo imprimir o log de impressao de boleto."
oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrint(oReport)},cDescRel)
oReport:SetLandScape()
oReport:SetTotalInLine(.T.) 
//oReport:lDisableOrientation := .F.
//oReport:oPage:nPapersize := 9  
//oreport:cfontbody := "Arial"

Pergunte(oReport:uParam,.F.)

IF MV_PAR10= 2

	oSection1 := TRSection():New(oReport, "Beneciciário", {}, , ,)

	TRCell():New(oSection1,"CODINT"	 	,,"Matricula"		, ""	,18	   ,  ,{|| (cAliasBOL)->(CODINT+CODEMP+MATRIC+TIPREG+DIGITO)  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection1,"NOMUSR"		,,"Beneficiário"	, ""	,30	   ,  ,{|| (cAliasBOL)->NOMUSR  }  		,"LEFTR"  , ,"LEFT" )//Dt. vencimento 

	oSection2 := TRSection():New(oSection1," ",{}, , ,) //"Documento"
	oSection2:SetHeaderPage(.T.)
	oSection2:SetHeaderBreak(.T.)
	oSection2:SetTotalInLine(.F.)  


	//oSection2:SetTotalInLine(.T.)
	// Colunas do relatório
	TRCell():New(oSection2,"EMPRESA"			,,"Empresa"			, ""	,7	   ,  ,{|| (cAliasBOL)->EMPRESA  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"USU_IMPRESSAO"		,,"Operador"		, ""	,20	   ,  ,{|| (cAliasBOL)->USU_IMPRESSAO }  ,"LEFT"  , ,"LEFT" )//Operador
	TRCell():New(oSection2,"DATA_IMPRESSAO"		,,"Dt. Impressão"   , ""	,10	   ,  ,{|| (cAliasBOL)->DATA_IMPRESSAO } ,"LEFT"  , ,"LEFT" )//DT. Impressao
	TRCell():New(oSection2,"HORA_IMPRESSAO"		,,"Hr. Impressão" 	, ""	,8	   ,  ,{|| (cAliasBOL)->HORA_IMPRESSAO } ,"LEFT"  , ,"LEFT" )//Hr. Impressao
	TRCell():New(oSection2,"FILIAL_TIT" 		,,"Filial "    		, "" 	,04	   ,  ,{|| (cAliasBOL)->FILIAL_TIT     } ,"LEFT"  , ,"LEFT" )//Filial Titulo
	TRCell():New(oSection2,"PREFIXO_TIT" 		,,"Prefixo"      	, ""	,3	   ,  ,{|| (cAliasBOL)->PREFIXO_TIT    } ,"LEFT"  , ,"LEFT" )//Parcela
	TRCell():New(oSection2,"NUM_TIT  " 		    ,,"Num Tit."	    , ""	,9	   ,  ,{|| (cAliasBOL)->NUM_TIT        } ,"LEFT"  , ,"LEFT" )//Tipo
	TRCell():New(oSection2,"PARCELA_TIT"		,,"Parcela"     	, ""	,2	   ,  ,{|| (cAliasBOL)->PARCELA_TIT    } ,"LEFT"  , ,"LEFT" )//Natureza 
	TRCell():New(oSection2,"TIPO_TIT"		    ,,"Tipo"			, ""	,2	   ,  ,{|| (cAliasBOL)->TIPO_TIT       } ,"LEFT"  , ,"LEFT" )//Natureza
	TRCell():New(oSection2,"EMISSAO"			,,"Emissao"  		, ""  	,15	   ,  ,{|| (cAliasBOL)->EMISSAO 	   } ,"LEFT"  , ,"LEFT" )//Dt. emissao
	TRCell():New(oSection2,"VENCIMENTO"			,,"Vencimento"  	, ""  	,15	   ,  ,{|| (cAliasBOL)->VENCIMENTO	   } ,"LEFT"  , ,"LEFT" )//Dt. emissao
	TRCell():New(oSection2,"ANOBASE"			,,"Ano Base"    	, ""	,4	   ,  ,{|| (cAliasBOL)->ANOBASE		   } ,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"MESBASE"			,,"Mes Base"		, ""	,2	   ,  ,{|| (cAliasBOL)->MESBASE		   } ,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"VALOR_TIT"			,,"Valor Titulo"	, ""    ,15    ,  ,{|| Transform( "@R 999.999.999,99" , (cAliasBOL)->VALOR_TIT)}   ,"LEFT"  , ,"LEFT" )//Vlr baixa
	TRCell():New(oSection2,"EMAIL"				,,"Email"			, ""	,30	   ,  ,{|| (cAliasBOL)->EMAIL   }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"IMPRESSO"			,,"Impresso?"		, ""	,3	   ,  ,{|| (cAliasBOL)->IMPRESSO }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"SALDO_TIT"			,,"Saldo Tit"		, ""	,15	   ,  ,{|| Transform( "@R 999.999.999,99" ,  (cAliasBOL)->SALDO_TIT) }  	)//Dt. vencimento 
	oCcontador := TRCell():New(oSection2,"CONTADOR"	,,"CONTADOR"	, ""	,3	   ,  ,{|| (cAliasBOL)->CONTADOR   }  	) 
	oCcontador:hide()
	oCcontador:hide()

	TRFunction():New(oSection2:Cell("USU_IMPRESSAO"),/*"oTotal"*/ ,"COUNT", /*oBreak */,"Total de Registros",/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)	

	//Definção da collection
	oCol1:= TRCollection():New(, "COUNT", /*oBreak*/,"Total Por Operador", "@E 999,999,999.99" , /*uFormula*/ oSection2:Cell("USU_IMPRESSAO"), /*.lEndSection.*/ .F.,;
	/*.lEndReport.*/ .T., /*oParent*/ oSection2, /*bCondition*/  ,  /*uContent*/ oSection2:Cell("USU_IMPRESSAO") )
	

elseif MV_PAR10 = 1

	oSection2 := TRSection():New(oReport,"Movimentos",{}, , ,) //"Documento"
	// Colunas do relatório
	TRCell():New(oSection2,"EMPRESA"			,,"Empresa"			, ""	,7	   ,  ,{|| (cAliasBOL)->EMPRESA  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"USU_IMPRESSAO"		,,"Operador"		, ""	,20	   ,  ,{|| (cAliasBOL)->USU_IMPRESSAO }  ,"LEFT"  , ,"LEFT" )//Operador
	TRCell():New(oSection2,"DATA_IMPRESSAO"		,,"Dt.Imp"   , ""	,10	   ,  ,{|| (cAliasBOL)->DATA_IMPRESSAO } ,"LEFT"  , ,"LEFT" )//Prefixo
	TRCell():New(oSection2,"HORA_IMPRESSAO"		,,"Hr.Imp" 	, ""	,5	   ,  ,{|| (cAliasBOL)->HORA_IMPRESSAO } ,"LEFT"  , ,"LEFT" )//Numero t?ulo a pagar
	TRCell():New(oSection2,"CODINT"	 	        ,,"Matricula"		, ""	,18	   ,  ,{|| (cAliasBOL)->(CODINT+CODEMP+MATRIC+TIPREG+DIGITO)  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"NOMUSR"				,,"Beneficiário"	, ""	,30	   ,  ,{|| (cAliasBOL)->NOMUSR  }  		,"LEFTR"  , ,"LEFT" )//Dt. vencimento  	
	TRCell():New(oSection2,"FILIAL_TIT" 		,,"Fil"     		, "" 	,02	   ,  ,{|| (cAliasBOL)->FILIAL_TIT     } ,"LEFT"  , ,"LEFT" )//N?ero do t?ulo a receber
	TRCell():New(oSection2,"PREFIXO_TIT" 		,,"Prefixo"      	, ""	,3	   ,  ,{|| (cAliasBOL)->PREFIXO_TIT    } ,"LEFT"  , ,"LEFT" )//Parcela
	TRCell():New(oSection2,"NUM_TIT  " 		    ,,"Num Tit."	    , ""	,9	   ,  ,{|| (cAliasBOL)->NUM_TIT        } ,"LEFT"  , ,"LEFT" )//Tipo
	TRCell():New(oSection2,"PARCELA_TIT"		,,"Parcela"     	, ""	,2	   ,  ,{|| (cAliasBOL)->PARCELA_TIT    } ,"LEFT"  , ,"LEFT" )//Natureza 
	TRCell():New(oSection2,"TIPO_TIT"		    ,,"Tipo"			, ""	,2	   ,  ,{|| (cAliasBOL)->TIPO_TIT       } ,"LEFT"  , ,"LEFT" )//Natureza
	TRCell():New(oSection2,"EMISSAO"			,,"Emissao"  		, ""  	,15	   ,  ,{|| (cAliasBOL)->EMISSAO 	   } ,"LEFT"  , ,"LEFT" )//Dt. emissao
	TRCell():New(oSection2,"VENCIMENTO"			,,"Vencimento"  	, ""  	,15	   ,  ,{|| (cAliasBOL)->VENCIMENTO	   } ,"LEFT"  , ,"LEFT" )//Dt. emissao
	TRCell():New(oSection2,"ANOBASE"			,,"Ano " 		   	, ""	,4	   ,  ,{|| (cAliasBOL)->ANOBASE		   } ,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"MESBASE"			,,"Mes"				, ""	,2	   ,  ,{|| (cAliasBOL)->MESBASE		   } ,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"VALOR_TIT"			,,"Valor Titulo"	, ""    ,15    ,  ,{|| Transform( "@R 999.999.999,99" , (cAliasBOL)->VALOR_TIT)}   ,"LEFT"  , ,"LEFT" )//Vlr baixa
	//TRCell():New(oSection2,"CODINT"				,,"Cod. Int"		, ""	,4	   ,  ,{|| (cAliasBOL)->CODINT  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	//TRCell():New(oSection2,"CODEMP"				,,"Cod. Emp"		, ""	,4	   ,  ,{|| (cAliasBOL)->CODEMP  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	//TRCell():New(oSection2,"MATRIC"				,,"Matricula"		, ""	,6	   ,  ,{|| (cAliasBOL)->MATRIC  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	//TRCell():New(oSection2,"TIPREG"				,,"Tp.Reg"		    , ""	,2	   ,  ,{|| (cAliasBOL)->TIPREG  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	//TRCell():New(oSection2,"DIGITO"				,,"Digito"			, ""	,2	   ,  ,{|| (cAliasBOL)->DIGITO  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"NOMUSR"				,,"Nome Usuário"	, ""	,30	   ,  ,{|| (cAliasBOL)->NOMUSR  }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"EMAIL"				,,"Email"			, ""	,30	   ,  ,{|| (cAliasBOL)->EMAIL   }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"IMPRESSO"			,,"Impresso?"		, ""	,3	   ,  ,{|| (cAliasBOL)->IMPRESSO }  		,"LEFT"  , ,"LEFT" )//Dt. vencimento 
	TRCell():New(oSection2,"SALDO_TIT"			,,"Saldo Tit"		, ""	,15	   ,  ,{|| Transform( "@R 999.999.999,99" ,  (cAliasBOL)->SALDO_TIT) }  	)//Dt. vencimento 

	TRFunction():New(oSection2:Cell("USU_IMPRESSAO"),/*"oTotal"*/ ,"COUNT", /*oBreak */,"Total de Registros",/*[ cPicture ]*/,/*[ uFormula ]*/,,.F.)	


Endif


RestArea( aAreaSM0 )

Return(oReport)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Static Function ReportPrint(oReport)
Local oSection1 
Local oSection2 
Local aUser 
Local cMvpar03 
Local cMvpar04

Private cAliasBOL  := "TRB"
Private dDatabase    
Private dData
Private aArea1  := {} 


//Faz o tratamento para passar corretamente o nome do usuário
If val(MV_PAR03)>0
	PswOrder(1)
	If PswSeek(MV_PAR03, .T.)
		aUser := PswRet(1)
		cMvpar03 :=  UPPER(AllTrim(aUser[1,2])) //+ " - " + AllTrim(aUser[1,4])
	Else
		Alert("Codigo de usuário informado é inválido")
	Endif

else
	cMvpar03 := UPPER(MV_PAR03)
endif

//Faz o tratamento para passar corretamente o nome do usuário
If val(MV_PAR04)>0
	PswOrder(1)
	If PswSeek(MV_PAR04, .T.)
		aUser := PswRet(1)
		cMvpar04 :=  UPPER(AllTrim(aUser[1,2])) 
	Else
		Alert("Codigo de usuário informado é inválido")
	Endif

else
	cMvpar04 := UPPER(MV_PAR04)
endif

If MV_PAR10 = 1
	oSection2 := oReport:Section(1)
Else
	oSection1 := oReport:Section(1)
	oSection2 := oReport:Section(1):Section(1)

	oSection1:SetHeaderSection(.T.)
	oSection1:SetHeaderBreak() 
EndIf

// Query para buscar os dados no banco
cQry:="  SELECT " 
cQry+="         1 CONTADOR, LOG_BOLETO_AUDITORIA.* " 
cQry+=" FROM  "
cQry+="         LOG_BOLETO_AUDITORIA " 
cQry+=" WHERE "
cQry+="         CODINT||CODEMP||MATRIC||TIPREG||DIGITO >= '"+MV_PAR01+" ' and  CODINT||CODEMP||MATRIC||TIPREG||DIGITO <= '"+MV_PAR02+"' "
cQry+="         and  UPPER(USU_IMPRESSAO) > =  '"+cMvpar03+"' and UPPER(USU_IMPRESSAO) < = '"+cMvpar04+"' "
cQry+="         and   DATA_IMPRESSAO >= '"+Dtoc(MV_PAR05)+"' AND DATA_IMPRESSAO <= '"+Dtoc(MV_PAR06)+"' "
cQry+="         and   VENCIMENTO >= '"+Dtoc(MV_PAR07)+"' AND VENCIMENTO <= '"+Dtoc(MV_PAR08)+"' "

If MV_PAR11 = 1
	cQry+="    AND IMPRESSO = 'S' "
elseif MV_PAR11 = 2
	cQry+=" AND IMPRESSO = 'N'"
EndIf

If MV_PAR09 = 1
	cQry+="	AND   EMPRESA = 'CABERJ'"
elseif MV_PAR09 = 2
	cQry+="	AND   EMPRESA = 'INTEGRAL'"
Endif	

cQry+=" ORDER BY  EMPRESA, CODINT||CODEMP||MATRIC||TIPREG||DIGITO, DATA_IMPRESSAO, HORA_IMPRESSAO "

cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Não foram encontrados dados!")
Else
	IF MV_PAR10 = 1 //Se opção for analitica, imprime relatorio sem quebras por beneciario

		oSection2:Init()

		While  !(cAliasBOL)->(Eof())       
			
			oReport:IncMeter()
			oSection2:PrintLine()
			
			(cAliasBOL)->(DbSkip())
		Enddo   
		
		oReport:FatLine()
		oReport:Section(1):Finish()

		(cAliasBOL)->(DbCloseArea())


	ElseIf MV_PAR10 = 2 // Se SINTETICA, realiza quebra por beneficiario e totaliza por operador
		nx:= 1
		oSection1:Init()	

		While (cAliasBOL)->(!Eof())

			If oReport:Cancel() // Se usuário cancelar o processamento
				Exit
			EndIf

			If nx >1 // imprime cabeçallho da primeira secao
				oSection1:PrintHeader()
			EndIf

			oReport:IncMeter()	
			oSection1:PrintLine()
			oSection2:Init()

			cmat    := (cAliasBOL)->(CODINT+CODEMP+MATRIC+TIPREG+DIGITO)
			
			While  !(cAliasBOL)->(Eof()) .and. (cAliasBOL)->(CODINT+CODEMP+MATRIC+TIPREG+DIGITO) = cmat
				
				oSection2:PrintLine()
				
				(cAliasBOL)->(DbSkip())
			Enddo   

			oSection2:Finish()
			
			oReport:Skipline()
			
		//	oReport:FatLine()
		//	oReport:ThinLine()
		//	oReport:Skipline()
			oReport:Skipline()

			nx++
		Enddo   

		oSection1:Finish()

		//oReport:EndPage()
		oReport:PrintGraphic()
		//oReport:Print()

		//oReport:PrintDialog()

		(cAliasBOL)->(DbCloseArea())
	Endif
		
EndIf

Return

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function AjustaSX1(cPerg)

Local aHelpPor	:= {} 

nTamMat := TamSX3("BA1_CODINT")[1]+TamSX3("BA1_CODEMP")[1]+TamSX3("BA1_MATRIC")[1]+TamSX3("BA1_TIPREG")[1]+TamSX3("BA1_DIGITO")[1] 

aHelpPor := {}
AADD(aHelpPor,"Informe a Matricula:			")
	
 u_CABASX1(cPerg,"01","Matricula De: "	,"Matricula:","a","MV_CH1"	,"C",nTamMat ,0,0,"G","","CABC03","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"02","Matricula Ate: "	,"Matricula:","a","MV_CH2"	,"C",nTamMat ,0,0,"G","","CABC03","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"03","Usuário De: "	,"Matricula:","a","MV_CH3"	,"C",6 ,0,0,"G","","USR","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"04","Usuário Ate: "	,"Matricula:","a","MV_CH4"	,"C",6 ,0,0,"G","","USR","","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"05","Dt Impres De: "	,"Matricula:","a","MV_CH5"	,"D",8       ,0,0,"G","","","","","MV_PAR05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"06","Dt. Impres Ate:"	,"Matricula:","a","MV_CH6"	,"D",8       ,0,0,"G","","","","","MV_PAR06","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"07","Dt Venc De: "	,"Matricula:","a","MV_CH7"	,"D",8       ,0,0,"G","","","","","MV_PAR07","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"08","Dt Venc Ate:"	,"Matricula:","a","MV_CH8"	,"D",8       ,0,0,"G","","","","","MV_PAR08","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"09","Empresa:"		,"Matricula:","a","MV_CH9"	,"C",1       ,0,0,"C","","","","","MV_PAR09","1-CABERJ","1-CABERJ","1-CABERJ","","2-INTEGRAL","2-INTEGRAL","2-INTEGRAL","3-AMBOS","3-AMBOS","3-AMBOS","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"10","Modelo?"		   ,"Matricula:","a","MV_CHA"	,"C",1       ,0,0,"C","","","","","MV_PAR10","1-ANALITICO","1-ANALITICO","1-ANALITICO","","2-SINTETICO","2-SINTETICO","2-SINTETICO","","","","","","","","","",aHelpPor,{},{},"")	
 u_CABASX1(cPerg,"11","Impressao?"	   ,"Impressao?","a","MV_CHB"	,"C",1       ,0,0,"C","","","","","MV_PAR11","1-SIM","1-SIM","1-SIM","","2-NAO","2-NAO","2-NAO","3-AMBOS","3-AMBOS","3-AMBOS","","","","","","",aHelpPor,{},{},"")
	
Return()
