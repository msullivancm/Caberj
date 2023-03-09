#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE _cEol  CHR(13)+CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR200   ºAutor  ³Angelo Henrique     º Data ³  28/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório solicitado pelo MAX, pendência Altamiro           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR200()
	
	Local _aArea 	:= GetArea()
	Local oReport	:= Nil
	
	Private _cPerg  := "CABR200"
	private cCodusu := SubStr(cUSUARIO,7,15)
	private nPos    := 0
	private aGerenc := {}
	private adados  := {}  
	PRIVATE ANOMES  := ' '    
	private MV_PAR08 := 1
	
	//Cria grupo de perguntas
	CABR200A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		oReport := CABR200B()
		oReport:PrintDialog()
		
	EndIf
	
	RestArea(_aArea)
	
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR200A    ºAutor  ³Angelo Henrique   º Data ³  14/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório Sintético de movimento de repassados.             º±±
±±º          ³ -----  Perguntas do Relatório -------------------          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABR200A(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
//	Local aHelp
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o Cod RDA  	 		")
	AADD(aHelpPor,"De/Ate a ser utilizado.		")
	
	PutSx1(cGrpPerg,"01","RDA De ? "		,"a","a","MV_CH1"	,"C",TamSX3("ZZP_CODRDA")[1]	,0,0,"G","","BAUPLS"	,"","","MV_PAR01",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","RDA Ate ?"		,"a","a","MV_CH2"	,"C",TamSX3("ZZP_CODRDA")[1]	,0,0,"G","","BAUPLS"	,"","","MV_PAR02",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o Ano/Mes, 			")
	AADD(aHelpPor,"De/Ate a ser utilizado.		")
	AADD(aHelpPor,"Digitar ANOMES: 201501.		")
	
	PutSx1(cGrpPerg,"03","ANO/MES De?  "	,"a","a","MV_CH3"	,"C",6							,0,0,"G","",""		,"","","MV_PAR03",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","ANO/MES Ate ?"	,"a","a","MV_CH4"	,"C",6							,0,0,"G","",""		,"","","MV_PAR04",""			,"","","" ,""				,"","","","","","","","","","","",aHelpPor,{},{},"")
	
  //	aAdd(aHelpPor, "Informe o analista , não Informe para todos ")
  //  PutSX1(cGrpPerg, "05" , "Analista de       "    ,"","","mv_ch5","C",6,0,0,"G","","LOGINU","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	  
    aHelpPor := {}
	AADD(aHelpPor,"Pagto Normal - 0 , Recurso 1 , 2 bloqueio  ")
	PutSx1(cGrpPerg,"05","Selecione  : "	,"a","a","MV_CH5"	,"N",01							,0,0,"C","",""		,"","","MV_PAR05","Nornal/Reapt"	,"","","1","Recurso "	,"","","Bloqueado ","","","Todos ","","","","","",aHelpPor,{},{},"")
    
  	aHelpPor := {}
	AADD(aHelpPor,"Ordernar por   ")
	PutSx1(cGrpPerg,"06","Ordernar por : "	,"a","a","MV_CH6"	,"N",01							,0,0,"C","",""		,"","","MV_PAR06","Vlr Ambulatoria ","","","1","Vlr hospitalar"	,"","","Vlr Total","","","Analista ","","","","","",aHelpPor,{},{},"")
  
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR200A    ºAutor  ³Angelo Henrique   º Data ³  14/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório Sintético de movimento de repassados.             º±±
±±º          ³ -----  Gerando as colunas para o relatório -------------   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABR200B
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Local oSection2 	:= Nil
	Local oSection3 	:= Nil
	
	oReport := TReport():New("CABR200","Conferência Entrega Faturamento",_cPerg,{|oReport| CABR200C(oReport)},"Conferência Entrega Faturamento")
	
	//Impressão formato paisagem
	oReport:SetLandScape()
	
////////////////////////////////////////////////
	If MV_PAR08 == 1
		oSection1 := TRSection():New(oReport,"Debitos / Creditos por Rda e/ou periodo","ZZP")

		TRCell():New(oSection1 ,'ZZPCODRDA'	,   ,'Ident. RDA'	 ,/*Picture*/ 				,40				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
		//SERGIO CUNHA INICIO - Chamado - ID: 31280 
		TRCell():New(oSection1 ,'GRPPGT'	,   ,'GrupoPgto'	 ,/*Picture*/ 				,5				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
		//SERGIO CUNHA FIM - Chamado - ID: 31280 
	   	TRCell():New(oSection1 ,'ZZPMESPAG'	,   ,'Mes Comp.'   ,/*Picture*/ 				,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
		TRCell():New(oSection1 ,'ZZPANOPAG'	,	,'Ano Comp.' 	 ,/*Picture*/ 				,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
		TRCell():New(oSection1 ,'ZZPVLRHOSP',   ,'Vlr Prev. Hosp'	,"@E 999999,999.99" 		,13          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
		TRCell():New(oSection1 ,'ZZPVLRAMB'	,   ,'Vlr Prev. Amb '  ,"@E 999999,999.99"   	,13          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
		TRCell():New(oSection1 ,'ZZPVLROD'	,   ,'Vlr Prev. Odont' ,"@E 999999,999.99"     ,13          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

		TRCell():New(oSection1 ,'ZZPVLRTOT'	,   ,'Vlr Prev. Total' ,"@E 999999,999.99"     ,13          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
		TRCell():New(oSection1 ,'BD7VLRAPR'	,   ,'Vlr Custo Apres' ,"@E 999999,999.99"     ,13          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
		TRCell():New(oSection1 ,'BD7VLRGLO'	,   ,'Vlr Custo Glos ' ,"@E 999999,999.99"     ,13          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
		TRCell():New(oSection1 ,'BD7VLRPAG'	,   ,'Vlr Custo Pgto ' ,"@E 999999,999.99"     ,13          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
		TRCell():New(oSection1 ,'ZZPNOMANA'	,   ,'Analista Resp '		    ,/*Picture*/ 		,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
	   	TRCell():New(oSection1 ,'ZZPTPREM'	,   ,'Tipo Remessa  '		    ,/*Picture*/ 		,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)   
	   	TRCell():New(oSection1 ,'TPESSOA'	,   ,'Tipo Pessoa  '		    ,/*Picture*/ 		,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
   		TRCell():New(oSection1 ,'CLSRED'	,   ,'Classe de Rede  '	        ,/*Picture*/ 	    ,05				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
		TRCell():New(oSection1 ,'XMEDLI'	,   ,'Operativa '	            ,/*Picture*/ 	    ,15				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

// ----[ chamado 88787 - ini ]----------------------------------
		TRCell():New(oSection1 ,'XHAT'	    ,   ,'Hat '                     ,/*Picture*/ 	    ,15				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
// ----[ chamado 88787 - fim ]----------------------------------

/////////////////////////////////////////////////    
	Else
		oSection3 := TRSection():New(oReport,"Total custo por competencia ","ZZP")


		TRCell():New(oSection3 ,'ZZPMESPAG' ,     ,'Mes Comp.'   ,/*Picture*/ 				,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
		TRCell():New(oSection3 ,'ZZPANOPAG'	,	  ,'Ano Comp.' 	 ,/*Picture*/ 				,07				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

		TRCell():New(oSection3 ,'ZZPVLRHOSP',     ,'      Vlr Prev. Hosp'	,"@E 999999,999.99"    ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection3 ,'ZZPVLRAMB'	,     ,'      Vlr Prev. Amb '  ,"@E 999999,999.99"     ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection3 ,'ZZPVLROD'	,     ,'      Vlr Prev. Odont' ,"@E 999999,999.99"     ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection3 ,'ZZPVLRTOT'	,     ,'      Vlr Prev. Total' ,"@E 999999,999.99"     ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)

		TRCell():New(oSection3 ,'BD7VLRAPR'	,     ,'      Vlr Custo Apres' ,"@E 999999,999.99"     ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection3 ,'BD7VLRGLO'	,     ,'      Vlr Custo Glos ' ,"@E 999999,999.99"     ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection3 ,'BD7VLRPAG'	,     ,'      Vlr Custo Pgto ' ,"@E 999999,999.99"     ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
   		TRCell():New(oSection3 ,'ZZPTPREM'	,     ,'      Tipo Remessa  '		,/*Picture*/ 	   ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
   		TRCell():New(oSection1 ,'TPESSOA'	,     ,'      Tipo Pessoa  '	    ,/*Picture*/ 	   ,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)   
   		TRCell():New(oSection1 ,'CLSRED'	,     ,'      Classe de Rede  '	    ,/*Picture*/ 	   ,05				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)   		
		TRCell():New(oSection1 ,'XMEDLI'	,     ,'      Operativa '	        ,/*Picture*/ 	   ,15				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)   		

// ----[ chamado 88787 - ini ]----------------------------------
		TRCell():New(oSection1 ,'XHAT'	    ,     ,'      Hat '                 ,/*Picture*/ 	    ,15				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
// ----[ chamado 88787 - fim ]----------------------------------

	EndIf
///////////////////////////////////////////////	
	
	/*
	
	oSection1 := TRSection():New(oReport,"Conferência Entrega Faturamento","ZZP")
	
	TRCell():New(oSection1,"ZZPCODRDA" 	,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ZZPCODRDA"):SetAutoSize(.F.)
	oSection1:Cell("ZZPCODRDA"):SetSize(10)
	
	TRCell():New(oSection1,"ZZPMESPAG" 	,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ZZPMESPAG"):SetAutoSize(.F.)
	oSection1:Cell("ZZPMESPAG"):SetSize(10)
	
	TRCell():New(oSection1,"ZZPANOPAG" 	,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ZZPANOPAG"):SetAutoSize(.F.)
	oSection1:Cell("ZZPANOPAG"):SetSize(10)
	
	TRCell():New(oSection1,"ZZPVLRHOSP" 	,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ZZPVLRHOSP"):SetAutoSize(.F.)
	oSection1:Cell("ZZPVLRHOSP"):SetSize(17)
	oSection1:Cell("ZZPVLRHOSP"):SetPicture("@E 999,999,999.99")
	
	TRCell():New(oSection1,"ZZPVLRAMB"		,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ZZPVLRAMB"):SetAutoSize(.F.)
	oSection1:Cell("ZZPVLRAMB"):SetSize(17)
	oSection1:Cell("ZZPVLRAMB"):SetPicture("@E 999,999,999.99")
	
	TRCell():New(oSection1,"ZZPVLROD"		,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ZZPVLROD"):SetAutoSize(.F.)
	oSection1:Cell("ZZPVLROD"):SetSize(17)
	oSection1:Cell("ZZPVLROD"):SetPicture("@E 999,999,999.99")
	
	TRCell():New(oSection1,"ZZPVLRTOT"		,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ZZPVLRTOT"):SetAutoSize(.F.)
	oSection1:Cell("ZZPVLRTOT"):SetSize(17)
	oSection1:Cell("ZZPVLRTOT"):SetPicture("@E 999,999,999.99")
	/*
	TRCell():New(oSection1,"BD7CODRDA"		,"BD7",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BD7CODRDA"):SetAutoSize(.F.)
	oSection1:Cell("BD7CODRDA"):SetSize(15)
	
	TRCell():New(oSection1,"BD7MESPAG"		,"BD7",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BD7MESPAG"):SetAutoSize(.F.)
	oSection1:Cell("BD7MESPAG"):SetSize(10)
	
	TRCell():New(oSection1,"BD7ANOPAG"		,"BD7",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BD7ANOPAG"):SetAutoSize(.F.)
	oSection1:Cell("BD7ANOPAG"):SetSize(10)
	
	TRCell():New(oSection1,"BD7VLRAPR"		,"BD7",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BD7VLRAPR"):SetAutoSize(.F.)
	oSection1:Cell("BD7VLRAPR"):SetSize(17)
	oSection1:Cell("BD7VLRAPR"):SetPicture("@E 999,999,999.99")
	
	TRCell():New(oSection1,"BD7VLRGLO"		,"BD7",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BD7VLRGLO"):SetAutoSize(.F.)
	oSection1:Cell("BD7VLRGLO"):SetSize(17)
	oSection1:Cell("BD7VLRGLO"):SetPicture("@E 999,999,999.99")
	
	TRCell():New(oSection1,"BD7VLRPAG"		,"BD7",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("BD7VLRPAG"):SetAutoSize(.F.)
	oSection1:Cell("BD7VLRPAG"):SetSize(17)
	oSection1:Cell("BD7VLRPAG"):SetPicture("@E 999,999,999.99")
	
	TRCell():New(oSection1,"ZZPNOMANA"		,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection1:Cell("ZZPNOMANA"):SetAutoSize(.F.)
	oSection1:Cell("ZZPNOMANA"):SetSize(40)
	*/
	//--------------------------------
	//Segunda linha do relatório
	//--------------------------------      
	If MV_PAR08 == 1
		oSection2 := TRSection():New(oSection1,"","SZN,BD7,ZZP")
	else
		oSection2 := TRSection():New(oSection3,"","SZN,BD7,ZZP")
	EndIf

/*
	TRCell():New(oSection2,"TT_REG" 		,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("TT_REG"):SetAutoSize(.F.)
	oSection2:Cell("TT_REG"):SetSize(17)
	oSection2:Cell("TT_REG"):nAlign := 1
	
	TRCell():New(oSection2,"TT_ZZPHOSP" 	,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("TT_ZZPHOSP"):SetAutoSize(.F.)
	oSection2:Cell("TT_ZZPHOSP"):SetSize(17)
	oSection2:Cell("TT_ZZPHOSP"):SetPicture("@E 999,999,999.99")
	oSection2:Cell("TT_ZZPHOSP"):nAlign := 1
	
	TRCell():New(oSection2,"TT_ZZPAMB" 	,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("TT_ZZPAMB"):SetAutoSize(.F.)
	oSection2:Cell("TT_ZZPAMB"):SetSize(17)
	oSection2:Cell("TT_ZZPAMB"):SetPicture("@E 999,999,999.99")
	oSection2:Cell("TT_ZZPAMB"):nAlign := 1
	
	TRCell():New(oSection2,"TT_ZZPROD" 	,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("TT_ZZPROD"):SetAutoSize(.F.)
	oSection2:Cell("TT_ZZPROD"):SetSize(17)
	oSection2:Cell("TT_ZZPROD"):SetPicture("@E 999,999,999.99")
	oSection2:Cell("TT_ZZPROD"):nAlign := 1
	
	TRCell():New(oSection2,"TT_ZZPTOT"		,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("TT_ZZPTOT"):SetAutoSize(.F.)
	oSection2:Cell("TT_ZZPTOT"):SetSize(17)
	oSection2:Cell("TT_ZZPTOT"):SetPicture("@E 999,999,999.99")
	oSection2:Cell("TT_ZZPTOT"):nAlign := 1
	
	TRCell():New(oSection2,"TT_BD7APR"		,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("TT_BD7APR"):SetAutoSize(.F.)
	oSection2:Cell("TT_BD7APR"):SetSize(17)
	oSection2:Cell("TT_BD7APR"):SetPicture("@E 999,999,999.99")
	oSection2:Cell("TT_BD7APR"):nAlign := 1
	
	TRCell():New(oSection2,"TT_BD7GLO"		,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("TT_BD7GLO"):SetAutoSize(.F.)
	oSection2:Cell("TT_BD7GLO"):SetSize(17)
	oSection2:Cell("TT_BD7GLO"):SetPicture("@E 999,999,999.99")
	oSection2:Cell("TT_BD7GLO"):nAlign := 1
	
	TRCell():New(oSection2,"TT_BD7PAG"		,"ZZP",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("TT_BD7PAG"):SetAutoSize(.F.)
	oSection2:Cell("TT_BD7PAG"):SetSize(17)
	oSection2:Cell("TT_BD7PAG"):SetPicture("@E 999,999,999.99")
	oSection2:Cell("TT_BD7PAG"):nAlign := 1
*/	
		TRCell():New(oSection2 ,'TT_REG'    ,     ,'Tot Reg '        ,"@E 999,999" 		    ,14          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection2 ,'TT_ZZPHOSP',     ,'Tot Prev. Hosp'	 ,"@E 999999,999.99" 	,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection2 ,'TT_ZZPAMB'	,     ,'Tot Prev. Amb '  ,"@E 999999,999.99"   	,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection2 ,'TT_ZZPROD'	,     ,'Tot Prev. Odont' ,"@E 999999,999.99"    ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection2 ,'TT_ZZPTOT'	,     ,'Tot Prev. Total' ,"@E 999999,999.99"    ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)

		TRCell():New(oSection2 ,'TT_BD7APR'	,     ,'Vlr Custo Apres' ,"@E 999999,999.99"    ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection2 ,'TT_BD7GLO'	,     ,'Tot Custo Glos ' ,"@E 999999,999.99"    ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
		TRCell():New(oSection2 ,'TT_BD7PAG'	,     ,'Tot Custo Pgto ' ,"@E 999999,999.99"    ,20          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR200A  ºAutor  ³Angelo Henrique     º Data ³  14/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatório Sintético de movimento de repassados.             º±±
±±º          ³ -----  Gerando as informações para o relatório ---------   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR200C(oReport)
	
	Local _aArea 		:= GetArea()
	Local oSection1 	:= oReport:Section(1)
	Local oSection3 	:= oReport:Section(1)
	Local oSection2 	:= oReport:Section(1):Section(1)
   
	Local _cQuery		:= ""
	Local (cAlias1)	:= GetNextAlias()
	Local _nTotGr 	:= 0
	Local _nTotHsp	:= 0
	Local _nTotAmb 	:= 0
	Local _nTotRod 	:= 0
	Local _nTotTt 	:= 0
	Local _nTotApr 	:= 0
	Local _nTotGlo 	:= 0
	Local _nTotPag 	:= 0  
	
	//Alterando o tamanho da página para caber todos os campos
	oReport:oPage:setPaperSize(29)            
	
// nova sql 
_cQuery := " SELECT NVL(BD7.CODRDA  , ' '  ) BD7CODRDA  , " + _cEol	
_cQuery += "        NVL(BD7.NOMRDA  , ' '  ) BD7NOMRDA  , " + _cEol
_cQuery += "        NVL(ZZP.CODRDA  , ' '  ) ZZPCODRDA  , " + _cEol	
_cQuery += "        NVL(ZZP.NOMRDA  , ' '  ) ZZPNOMRDA  , " + _cEol
_cQuery += "        NVL(ZZP.MESPAG  , ' '  ) ZZPMESPAG  , " + _cEol	
_cQuery += "        NVL(ZZP.ANOPAG  , ' '  ) ZZPANOPAG  , " + _cEol 	
_cQuery += "        NVL(BD7.ANOPAG  , ' '  ) BD7ANOPAG  , " + _cEol	
_cQuery += "        NVL(BD7.MESPAG  , ' '  ) BD7MESPAG  , " + _cEol
_cQuery += "        NVL(ZZP.VLRHOSP , 0.00 ) ZZPVLRHOSP , " + _cEol 
_cQuery += "        NVL(ZZP.VLRAMB  , 0.00 ) ZZPVLRAMB  , " + _cEol 	
_cQuery += "        NVL(ZZP.VLROD   , 0.00 ) ZZPVLROD   , " + _cEol 	
_cQuery += "        NVL(ZZP.VLRTOT  , 0.00 ) ZZPVLRTOT  , " + _cEol	
_cQuery += "        NVL(BD7.VLRAPR  , 0.00 ) BD7VLRAPR  , " + _cEol 	
_cQuery += "        NVL(BD7.VLRGLO  , 0.00 ) BD7VLRGLO  , " + _cEol	
_cQuery += "        NVL(BD7.VLRPAG  , 0.00 ) BD7VLRPAG  , " + _cEol
_cQuery += "        NVL(ZZP.TPREM   , ' '  ) ZZPTPREM   , " + _cEol
_cQuery += "        NVL(ZZP.NOMANA  , ' '  ) ZZPNOMANA  , " + _cEol 
_cQuery += "        NVL(BD7.TIPE , ZZP.TIPE) Tpessoa    , " + _cEol 
_cQuery += "        NVL(BD7.CLSRED , ZZP.CLSRED) ClsRede,     " + _cEol
_cQuery += "        NVL(BD7.XMEDLI , ZZP.XMEDLI) XMEDLI       " + _cEol

// ----[ chamado 88787 - ini ]----------------------------------
_cQuery += ",       NVL(BD7.XHAT   , ZZP.XHAT  ) XHAT " + _cEol
// ----[ chamado 88787 - fim ]----------------------------------

_cQuery += " FROM ( SELECT bau_CODIGO CODRDA , nvl(trim(bau_nfanta), bau_nome) NOMRDA , BD7_MESPAG MESPAG , BD7_ANOPAG ANOPAG , " + _cEol
//_cQuery += "               SUM(BD7_VLRMAN) VLRAPR , SUM(BD7_VLRGLO) VLRGLO , SUM(BD7_VLRPAG) VLRPAG  ,"  + _cEol 
_cQuery += "               SUM(BD7_VALORI) VLRAPR , SUM(BD7_VLRGLO) VLRGLO , SUM(BD7_VLRPAG) VLRPAG  ,"  + _cEol //Chamado - ID 61310  - Sergio cunha 
_cQuery += "               decode(bau.bau_tippe,'F', 'Fisica' , 'Juridica') tipe  , bau.bau_tippre CLSRED, "  + _cEol 
_cQuery += "               CASE WHEN BAU_XMEDLI = 'S' THEN 'IMPLANTADO'     "  + _cEol 
_cQuery += "               		WHEN BAU_XMEDLI = 'N' THEN 'NAO IMPLANTADO' "  + _cEol 
_cQuery += "                 	WHEN BAU_XMEDLI = 'I' THEN 'EM IMPLANTACAO' "  + _cEol 
_cQuery += "                   	WHEN BAU_XMEDLI = 'D' THEN 'DESCONTINUADO'  "  + _cEol 
_cQuery += "                   	WHEN BAU_XMEDLI = 'R' THEN 'RESISTENTE'     "  + _cEol 
_cQuery += "                   	ELSE ' '								    "  + _cEol 
_cQuery += "               END XMEDLI 										"  + _cEol 

// ----[ chamado 88787 - ini ]----------------------------------
_cQuery += ",              CASE WHEN BAU_XHAT = '0' THEN 'NAO' "       + _cEol
_cQuery += "               		WHEN BAU_XHAT = '1' THEN 'ENVIA XML' " + _cEol
_cQuery += "                 	WHEN BAU_XHAT = '2' THEN 'CRIA LOTE' " + _cEol
_cQuery += "                   	ELSE ' ' "                             + _cEol
_cQuery += "               END XHAT "                                  + _cEol
// ----[ chamado 88787 - fim ]----------------------------------

_cQuery += "          FROM " + RetSqlName("BD7") + " BD7 ," + RetSqlName("BAU") + " BAU " + _cEol 
_cQuery += "         WHERE BD7_FILIAL = '" + xFilial("BD7") + "' AND BD7.D_e_l_e_t_ = ' ' " + _cEol
_cQuery += "           AND BAU_FILIAL ='" + xFilial("BAU") + "' AND  BAU.D_e_l_e_t_ = ' ' and bau.R_E_C_D_E_L_ = 0 " + _cEol

If !Empty(MV_PAR02)
    _cQuery += " AND BD7_CODRDA BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'  " + _cEol				
EndIf    

If !Empty(MV_PAR04)
	_cQuery += " AND BD7_ANOPAG||BD7_MESPAG >= '" + MV_PAR03 + "' " + _cEol
	_cQuery += " AND BD7_ANOPAG||BD7_MESPAG <= '" + MV_PAR04 + "' " + _cEol		
EndIf

_cQuery += "           AND BD7_CODRDA = BAU_CODIGO " + _cEol
_cQuery += "           AND BD7_SITUAC = '1' " + _cEol
_cQuery += "           AND BD7_FASE   = '4' " + _cEol
_cQuery += "           AND BD7_BLOPAG <> '1' " + _cEol
_cQuery += "           AND BD7_CONPAG <> '1' " + _cEol
_cQuery += "           AND BD7_NUMLOT <> ' ' " + _cEol
_cQuery += "      GROUP BY BAU_CODIGO , BAU_NOME , BD7_MESPAG , BD7_ANOPAG  , nvl(trim(bau_nfanta), bau_nome ), decode(bau.bau_tippe,'F', 'Fisica' , 'Juridica') , bau.bau_tippre, " + _cEol
_cQuery += "  			CASE    WHEN BAU_XMEDLI = 'S' THEN 'IMPLANTADO'	 	 " + _cEol
_cQuery += "          			WHEN BAU_XMEDLI = 'N' THEN 'NAO IMPLANTADO'	 " + _cEol
_cQuery += "          			WHEN BAU_XMEDLI = 'I' THEN 'EM IMPLANTACAO'	 " + _cEol
_cQuery += "          			WHEN BAU_XMEDLI = 'D' THEN 'DESCONTINUADO'	 " + _cEol
_cQuery += "          			WHEN BAU_XMEDLI = 'R' THEN 'RESISTENTE'	 	 " + _cEol
_cQuery += "                   	ELSE ' '								    "  + _cEol 

// ----[ chamado 88787 - ini ]----------------------------------
_cQuery += "               END "                                       + _cEol
_cQuery += ",              CASE WHEN BAU_XHAT = '0' THEN 'NAO' "       + _cEol
_cQuery += "               		WHEN BAU_XHAT = '1' THEN 'ENVIA XML' " + _cEol
_cQuery += "                 	WHEN BAU_XHAT = '2' THEN 'CRIA LOTE' " + _cEol
_cQuery += "                   	ELSE ' ' "                             + _cEol
// ----[ chamado 88787 - fim ]----------------------------------

_cQuery += "  			END    ) BD7 " + _cEol
      
_cQuery += "       FULL OUTER JOIN " + _cEol                                      

_cQuery += "      ( SELECT bau_CODIGO CODRDA, nvl(trim(bau_nfanta), bau_nome) NOMRDA , ZZP_MESPAG MESPAG , ZZP_ANOPAG ANOPAG , " + _cEol   
_cQuery += "               SUM(ZZP_VLINHO) VLRHOSP , SUM(ZZP_VLINAM) VLRAMB , SUM(ZZP_VLINOD) VLROD , " + _cEol
_cQuery += "              (SUM(ZZP_VLINHO) + SUM(ZZP_VLINAM)+ SUM(ZZP_VLINOD)) VLRTOT  , decode(bau.bau_tippe,'F', 'Fisica' , 'Juridica') tipe ,  bau.bau_tippre CLSRED ," + _cEol
_cQuery += "               DECODE(BAU_TIPPRE,'OPE','CONVENIO'  ,  DECODE(ZZP_TIPREM,'1', 'CABERJ', '2' , 'Empresarial' , '3' , 'Prefeitura' ,'outros') )TPREM , ZZP_NOMANA NOMANA,   " + _cEol
_cQuery += "               CASE WHEN BAU_XMEDLI = 'S' THEN 'IMPLANTADO'     "  + _cEol 
_cQuery += "               		WHEN BAU_XMEDLI = 'N' THEN 'NAO IMPLANTADO' "  + _cEol 
_cQuery += "                 	WHEN BAU_XMEDLI = 'I' THEN 'EM IMPLANTACAO' "  + _cEol 
_cQuery += "                   	WHEN BAU_XMEDLI = 'D' THEN 'DESCONTINUADO'  "  + _cEol 
_cQuery += "                   	WHEN BAU_XMEDLI = 'R' THEN 'RESISTENTE'     "  + _cEol 
_cQuery += "                   	ELSE ' '								    "  + _cEol 
_cQuery += "               END XMEDLI 										"  + _cEol 

// ----[ chamado 88787 - ini ]----------------------------------
_cQuery += ",              CASE WHEN BAU_XHAT = '0' THEN 'NAO' "       + _cEol
_cQuery += "               		WHEN BAU_XHAT = '1' THEN 'ENVIA XML' " + _cEol
_cQuery += "                 	WHEN BAU_XHAT = '2' THEN 'CRIA LOTE' " + _cEol
_cQuery += "                   	ELSE ' ' "                             + _cEol
_cQuery += "               END XHAT "                                  + _cEol
// ----[ chamado 88787 - fim ]----------------------------------

_cQuery += "          FROM " + RetSqlName("ZZP") + " ZZP ," + RetSqlName("BAU") + " BAU " + _cEol
_cQuery += "         WHERE ZZP_FILIAL = '" + xFilial("ZZP") + "' AND  ZZP.D_e_l_e_t_ = ' ' " + _cEol
_cQuery += "           AND BAU_FILIAL = '" + xFilial("BAU") + "' AND  BAU.D_e_l_e_t_ = ' ' and bau.R_E_C_D_E_L_ = 0 " + _cEol

If !Empty(MV_PAR02)
    _cQuery += " AND ZZP_CODRDA BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'  " + _cEol				
EndIf    

If !Empty(MV_PAR04)
	_cQuery += " AND ZZP_ANOPAG||ZZP_MESPAG >= '" + MV_PAR03 + "' " + _cEol
	_cQuery += " AND ZZP_ANOPAG||ZZP_MESPAG <= '" + MV_PAR04 + "' " + _cEol		
EndIf             
/*
If !Empty(MV_PAR05) 
	_cQuery += " AND ZZP_codana = '" + MV_PAR05 +"' " + _cEol		
EndIf
*/
If MV_PAR05 = 1
   	_cQuery += " AND ZZP_TIPPRO in ('0','3') " + _cEol
Elseif MV_PAR05 = 2                                           
   	_cQuery += " AND ZZP_TIPPRO = '1' " + _cEol
Elseif MV_PAR05 = 3
   	_cQuery += " AND ZZP_TIPPRO = '2' " + _cEol
/*Elseif MV_PAR05 = 4
   	_cQuery += " AND ZZP_TIPPRO = '3' " + _cEol*/
EndIf   	  
_cQuery += "           AND ZZP_CODRDA = BAU_CODIGO " + _cEol
_cQuery += "           AND ZZP_STATUS NOT IN ('PCA','CCA','PPR') " + _cEol 
_cQuery += "           GROUP BY bau_CODIGO , BAU_NOME  , ZZP_MESPAG , ZZP_ANOPAG  , decode(bau.bau_tippe,'F', 'Fisica' , 'Juridica')  , bau.bau_tippre , " + _cEol 
_cQuery += "           DECODE(BAU_TIPPRE,'OPE','CONVENIO' , DECODE(ZZP_TIPREM, '1' , 'CABERJ', '2' , 'Empresarial' , '3' , 'Prefeitura' ,'outros')) , ZZP_NOMANA , nvl(trim(bau_nfanta), bau_nome),  " + _cEol         
_cQuery += "  			CASE    WHEN BAU_XMEDLI = 'S' THEN 'IMPLANTADO'	 	 " + _cEol
_cQuery += "          			WHEN BAU_XMEDLI = 'N' THEN 'NAO IMPLANTADO'	 " + _cEol
_cQuery += "          			WHEN BAU_XMEDLI = 'I' THEN 'EM IMPLANTACAO'	 " + _cEol
_cQuery += "          			WHEN BAU_XMEDLI = 'D' THEN 'DESCONTINUADO'	 " + _cEol
_cQuery += "          			WHEN BAU_XMEDLI = 'R' THEN 'RESISTENTE'	 	 " + _cEol
_cQuery += "                   	ELSE ' '								    "  + _cEol 

// ----[ chamado 88787 - ini ]----------------------------------
_cQuery += "               END "                                       + _cEol
_cQuery += ",              CASE WHEN BAU_XHAT = '0' THEN 'NAO' "       + _cEol
_cQuery += "               		WHEN BAU_XHAT = '1' THEN 'ENVIA XML' " + _cEol
_cQuery += "                 	WHEN BAU_XHAT = '2' THEN 'CRIA LOTE' " + _cEol
_cQuery += "                   	ELSE ' ' "                             + _cEol
// ----[ chamado 88787 - fim ]----------------------------------

_cQuery += "  			END   )ZZP " + _cEol

_cQuery += " ON " + _cEol

_cQuery += " BD7.CODRDA = ZZP.CODRDA " + _cEol
_cQuery += " AND BD7.ANOPAG = ZZP.ANOPAG " + _cEol
_cQuery += " AND BD7.MESPAG = ZZP.MESPAG " + _cEol

If Mv_par06 ==1
	_cQuery += " ORDER BY  ZZP.ANOPAG , ZZP.MESPAG , NVL(ZZP.VLRAMB, 0.00 ) desc " + _cEol
ElseIf Mv_par06 ==2
	_cQuery += " ORDER BY  ZZP.ANOPAG , ZZP.MESPAG , NVL(ZZP.VLRHOSP,0.00 ) desc " + _cEol
ElseIf Mv_par06 ==3
	_cQuery += " ORDER BY  ZZP.ANOPAG , ZZP.MESPAG , NVL(ZZP.VLRTOT, 0.00 ) desc " + _cEol
ElseIf Mv_par06 ==4
	_cQuery += " ORDER BY  ZZP.ANOPAG , ZZP.MESPAG , NVL(ZZP.NOMANA, ' '  )  " + _cEol
EndIf                                                                

/* 	
	If MV_PAR08 == 2
/*		_cQuery := " SELECT NVL(ZZP.MESPAG, ' '  ) ZZPMESPAG, " + _cEol
		_cQuery += "        NVL(ZZP.ANOPAG, ' '  ) ZZPANOPAG, " + _cEol
		_cQuery += "        SUM(NVL(ZZP.VLRHOSP,0.00 )) ZZPVLRHOSP, " + _cEol
		_cQuery += "        SUM(NVL(ZZP.VLRAMB, 0.00 )) ZZPVLRAMB, 	" + _cEol
		_cQuery += "        SUM(NVL(ZZP.VLROD,  0.00 )) ZZPVLROD, " + _cEol
   //		_cQuery += "        SUM(NVL(ZZP.VLRTOT, 0.00 )) ZZPVLRTOT, " + _cEol
		_cQuery += "        SUM(NVL(BD7.VLRAPR, 0.00 )) BD7VLRAPR, " + _cEol
		_cQuery += "        SUM(NVL(BD7.VLRGLO, 0.00 )) BD7VLRGLO, " + _cEol
		_cQuery += "        SUM(NVL(BD7.VLRPAG, 0.00 )) BD7VLRPAG " + _cEol
  //		_cQuery += "        NVL(ZZP.TPREM , ' '  ) ZZPTPREM        " + _cEol	
	Else
		_cQuery := " SELECT " + _cEol
		_cQuery += " NVL(ZZP.CODRDA, ' '  ) ZZPCODRDA, 	" + _cEol
		_cQuery += " NVL(ZZP.NOMRDA, ' '  ) ZZPNOMRDA, 	" + _cEol
		_cQuery += " NVL(bd7.MESPAG, ' '  ) ZZPMESPAG, 	" + _cEol
		_cQuery += " NVL(bd7.ANOPAG, ' '  ) ZZPANOPAG, 	" + _cEol
		_cQuery += " NVL(ZZP.VLRHOSP,0.00 ) ZZPVLRHOSP, " + _cEol
		_cQuery += " NVL(ZZP.VLRAMB, 0.00 ) ZZPVLRAMB, 	" + _cEol
		_cQuery += " NVL(ZZP.VLROD,  0.00 ) ZZPVLROD, 	" + _cEol
	//	_cQuery += " NVL(ZZP.VLRTOT, 0.00 ) ZZPVLRTOT, 	" + _cEol
		_cQuery += " NVL(BD7.VLRAPR, 0.00 ) BD7VLRAPR, 	" + _cEol
		_cQuery += " NVL(BD7.VLRGLO, 0.00 ) BD7VLRGLO, 	" + _cEol
		_cQuery += " NVL(BD7.VLRPAG, 0.00 ) BD7VLRPAG 	" + _cEol
		_cQuery += " NVL(ZZP.NOMANA, ' '  ) ZZPNOMANA 	" + _cEol
		_cQuery += " NVL(ZZP.TPREM , ' '  ) ZZPTPREM   	" + _cEol 
 		 
	EndIf
	_cQuery += " FROM " + _cEol
	_cQuery += " ( " + _cEol
	_cQuery += " SELECT BD7_CODRDA CODRDA, BD7_MESPAG MESPAG, BD7_ANOPAG ANOPAG, " + _cEol
	_cQuery += " SUM(BD7_VLRMAN) VLRAPR, " + _cEol
	_cQuery += " SUM(BD7_VLRGLO) VLRGLO, " + _cEol
	_cQuery += " SUM(BD7_VLRPAG) VLRPAG  " + _cEol
	_cQuery += " FROM " + RetSqlName("BD7") + " BD7 " + _cEol
	_cQuery += " WHERE BD7_FILIAL = '" + xFilial("BD7") + "' AND BD7.D_e_l_e_t_ = ' ' " + _cEol
	
	If !Empty(MV_PAR02)
		
		_cQuery += " AND BD7_CODRDA >= '" + MV_PAR01 + "' " + _cEol
		_cQuery += " AND BD7_CODRDA <= '" + MV_PAR02 + "' " + _cEol
		
	EndIf
	
	If !Empty(MV_PAR04)
		
		_cQuery += " AND BD7_ANOPAG||BD7_MESPAG >= '" + MV_PAR03 + "' " + _cEol
		_cQuery += " AND BD7_ANOPAG||BD7_MESPAG <= '" + MV_PAR04 + "' " + _cEol
		
	EndIf
	
	_cQuery += " AND BD7_SITUAC = '1' " + _cEol
	_cQuery += " AND BD7_FASE = '4' " + _cEol
	_cQuery += " AND BD7_BLOPAG <> '1' " + _cEol
	_cQuery += " AND BD7_CONPAG <> '1' " + _cEol
	_cQuery += " AND BD7_NUMLOT <> ' ' " + _cEol
	_cQuery += " GROUP BY BD7_CODRDA , BD7_MESPAG , BD7_ANOPAG " + _cEol
	_cQuery += " ) BD7 , " + _cEol
	
	_cQuery += " ( " + _cEol
	_cQuery += " SELECT ZZP_CODRDA CODRDA, ZZP_NOMRDA NOMRDA , ZZP_MESPAG MESPAG , ZZP_ANOPAG ANOPAG ,   " + _cEol //, ZZP_NOMANA NOMANA, " + _cEol
//  	_cQuery += "        DECODE(BAU_TIPPRE,'OPE','CONVENIO'  ,  DECODE(ZZP_TIPREM,1, 'CABERJ', 2 , 'Empresarial' , 3 , 'Prefeitura' ,'outros') )TPREM  ," + _cEol
	_cQuery += " SUM(ZZP_VLINHO) VLRHOSP , " + _cEol
	_cQuery += " SUM(ZZP_VLINAM) VLRAMB  , " + _cEol
	_cQuery += " SUM(ZZP_VLINOD) VLROD    " + _cEol
//	_cQuery += " (ZZP_VLINHO+ZZP_VLINAM+ZZP_VLINOD) VLRTOT " + _cEol
	_cQuery += " FROM " + RetSqlName("ZZP") + " ZZP , " + RetSqlName("BAU") + " BAU " + _cEol
	_cQuery += " WHERE ZZP_FILIAL = '" + xFilial("ZZP") + "' AND  ZZP.D_e_l_e_t_ = ' ' " + _cEol
	_cQuery += "   AND BAU_FILIAL = '" + xFilial("BAU") + "' AND  BAU.D_e_l_e_t_ = ' ' and bau.R_E_C_D_E_L_ = 0 " + _cEol
	
	If !Empty(MV_PAR02) 
		
		_cQuery += " AND ZZP_CODRDA >= '" + MV_PAR01 + "' " + _cEol
		_cQuery += " AND ZZP_CODRDA <= '" + MV_PAR02 + "' " + _cEol
		
	EndIf                
	
	If !Empty(MV_PAR06) 
		
		_cQuery += " AND ZZP_NOMANA Like ('" + trim(MV_PAR06)+ "') " + _cEol
		
	EndIf
	 
	If MV_PAR10 = 1
    	_cQuery += " AND ZZP_TIPPRO = '0' " + _cEol
	Elseif MV_PAR10 = 2
    	_cQuery += " AND ZZP_TIPPRO = '1' " + _cEol
	Elseif MV_PAR10 = 3
    	_cQuery += " AND ZZP_TIPPRO = '2' " + _cEol
	EndIf   	  

	If !Empty(MV_PAR04)
		
		_cQuery += " AND ZZP_ANOPAG||ZZP_MESPAG >= '" + MV_PAR03 + "' " + _cEol
		_cQuery += " AND ZZP_ANOPAG||ZZP_MESPAG <= '" + MV_PAR04 + "' " + _cEol
		
	EndIf
	_cQuery += " AND ZZP_CODRDA = BAU_CODIGO " + _cEol
	_cQuery += " AND ZZP_STATUS NOT IN ('PCA','CCA') " + _cEol
	_cQuery += " GROUP BY ZZP_CODRDA ,  ZZP_NOMRDA   , ZZP_MESPAG , ZZP_ANOPAG  " + _cEol //, ZZP_NOMANA , " + _cEol 
//	_cQuery += "   DECODE(BAU_TIPPRE,'OPE','CONVENIO'  ,  DECODE(ZZP_TIPREM,1, 'CABERJ', 2 , 'Empresarial' , 3 , 'Prefeitura' ,'outros') ), " + _cEol
  //	_cQuery += " (ZZP_VLINHO+ZZP_VLINAM+ZZP_VLINOD) 
 	_cQuery += " ) ZZP" + _cEol

	If MV_PAR08 == 1
		If MV_PAR05 == 1 //Prévia
			_cQuery += " WHERE BD7.CODRDA(+) = ZZP.CODRDA " + _cEol
			_cQuery += " AND BD7.ANOPAG(+) = ZZP.ANOPAG " + _cEol
			_cQuery += " AND BD7.MESPAG(+) = ZZP.MESPAG " + _cEol
			If Mv_par09 ==1
				_cQuery += " ORDER BY  ZZP.ANOPAG , ZZP.MESPAG , NVL(ZZP.VLRAMB, 0.00 ) desc " + _cEol
			ElseIf Mv_par09 ==2
				_cQuery += " ORDER BY  ZZP.ANOPAG , ZZP.MESPAG , NVL(ZZP.VLRHOSP,0.00 ) desc " + _cEol
   			ElseIf Mv_par09 ==3
				_cQuery += " ORDER BY  ZZP.ANOPAG , ZZP.MESPAG , NVL(ZZP.VLRTOT, 0.00 ) desc " + _cEol
			ElseIf Mv_par09 ==4
				_cQuery += " ORDER BY  ZZP.ANOPAG , ZZP.MESPAG , NVL(ZZP.NOMANA, ' '  ) desc " + _cEol
			EndIf
		Else //Pagamento
		
			_cQuery += " WHERE BD7.CODRDA = ZZP.CODRDA(+) " + _cEol
			_cQuery += " AND BD7.ANOPAG = ZZP.ANOPAG(+) " + _cEol
			_cQuery += " AND BD7.MESPAG = ZZP.MESPAG(+) " + _cEol
			_cQuery += " ORDER BY  BD7.ANOPAG , BD7.MESPAG , BD7.CODRDA " + _cEol
		EndIf
	Else
		_cQuery += " WHERE BD7.ANOPAG(+) = ZZP.ANOPAG " + _cEol
		_cQuery += "  AND BD7.MESPAG(+) = ZZP.MESPAG  " + _cEol
		_cQuery += "  AND bd7.codrda(+) = ZZP.CODRDA  " + _cEol
		_cQuery += " group by ZZP.ANOPAG , ZZP.MESPAG " + _cEol //, ZZP.tprem " + _cEol
		_cQuery += " ORDER BY ZZP.ANOPAG , ZZP.MESPAG " + _cEol //, ZZP.tprem " + _cEol
		                                  
	EndIf
*/	
	If Select ((cAlias1)) > 0
		dbSelectArea( (cAlias1) )
		dbCloseArea()
	EndIf
	
	memowrite('c:\temp\cabr200.sql',_cQuery)

	dbUseArea(.T., "TOPCONN",  TCGenQry(,,_cQuery), (cAlias1), .F., .T.)
	
	If MV_PAR08 == 1
		oSection1:Init()
		oSection1:SetHeaderSection(.T.)
	else
		oSection3:Init()
		oSection3:SetHeaderSection(.T.)
	EndIf
	                        
	While !((cAlias1))->(eof()) 
	
		If MV_PAR08 == 1
			AADD(aDados,{(cAlias1)->ZZPCODRDA,(cAlias1)->ZZPMESPAG,(cAlias1)->ZZPANOPAG,(cAlias1)->ZZPVLRHOSP,(cAlias1)->ZZPVLRAMB,(cAlias1)->ZZPVLROD,;//,(cAlias1)->ZZPVLRTOT,;
			(cAlias1)->BD7VLRAPR,(cAlias1)->BD7VLRGLO,(cAlias1)->BD7VLRPAG, (cAlias1)->TPessoa , (cAlias1)->ClsRede, (cAlias1)->XMEDLI})//,(cAlias1)->ZZPNOMANA ,(cAlias1)->ZZPTPREM})
		Else
			AADD(aDados,{(cAlias1)->ZZPMESPAG,(cAlias1)->ZZPANOPAG,(cAlias1)->ZZPVLRHOSP,(cAlias1)->ZZPVLRAMB,(cAlias1)->ZZPVLROD,;//,(cAlias1)->ZZPVLRTOT,;
			(cAlias1)->BD7VLRAPR,(cAlias1)->BD7VLRGLO,(cAlias1)->TPessoa , (cAlias1)->ClsRede, (cAlias1)->XMEDLI})//,(cAlias1)->BD7VLRPAG ,(cAlias1)->ZZPTPREM})
		EndIf
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
		If MV_PAR08 == 1     
			DbSelectArea ("BAU")
			DbSetOrder (1) //BAU_FILIAL+BAU_CODIGO   
		    If !empty((cAlias1)->ZZPCODRDA)
    			oSection1:Cell("ZZPCODRDA"	):SetValue(trim("'"+(cAlias1)->ZZPCODRDA)+' - '+trim(((cAlias1))->ZZPNOMRDA))
	    		//SERGIO CUNHA INICIO - Chamado - ID: 31280 
	    		If DbSeek(xfilial("BAU")+(cAlias1)->ZZPCODRDA) 
			    	oSection1:Cell("GRPPGT"	):SetValue(BAU_GRPPAG)  
			    EndIf 
			   	//SERGIO CUNHA FIM - Chamado - ID: 31280 
	    		oSection1:Cell("ZZPMESPAG"	):SetValue((cAlias1)->ZZPMESPAG	    )
		    	oSection1:Cell("ZZPANOPAG"	):SetValue((cAlias1)->ZZPANOPAG	    )    
		 	Else 	                                                             
		        oSection1:Cell("ZZPCODRDA"	):SetValue(trim("'"+(cAlias1)->BD7CODRDA)+' - '+trim(((cAlias1))->BD7NOMRDA))
    			//SERGIO CUNHA INICIO - Chamado - ID: 31280 
	    		If DbSeek(xfilial("BAU")+(cAlias1)->BD7NOMRDA)
			   		oSection1:Cell("GRPPGT"	):SetValue(BAU_GRPPAG)
			   	EndIf
				//SERGIO CUNHA FIM - Chamado - ID: 31280 
	    		oSection1:Cell("ZZPMESPAG"	):SetValue((cAlias1)->BD7MESPAG	    )
		    	oSection1:Cell("ZZPANOPAG"	):SetValue((cAlias1)->BD7ANOPAG	    )    
		    EndIf 	
			oSection1:Cell("ZZPVLRHOSP"	):SetValue((cAlias1)->ZZPVLRHOSP    ) 
            oSection1:Cell("ZZPVLRAMB"	):SetValue((cAlias1)->ZZPVLRAMB     ) 
			oSection1:Cell("ZZPVLROD"	):SetValue((cAlias1)->ZZPVLROD      ) 
			oSection1:Cell("ZZPVLRTOT"	):SetValue((cAlias1)->ZZPVLRTOT     )
			oSection1:Cell("BD7VLRAPR"	):SetValue((cAlias1)->BD7VLRAPR     ) 
			oSection1:Cell("BD7VLRGLO"	):SetValue((cAlias1)->BD7VLRGLO     ) 
			oSection1:Cell("BD7VLRPAG"	):SetValue((cAlias1)->BD7VLRPAG     )
		   	oSection1:Cell("ZZPNOMANA"	):SetValue((cAlias1)->ZZPNOMANA  	)
            oSection1:Cell("ZZPTPREM"	):SetValue((cAlias1)->ZZPTPREM	    )   
            oSection1:Cell("TPESSOA"	):SetValue((cAlias1)->TPESSOA 	    ) 
            oSection1:Cell("CLSRED"	    ):SetValue((cAlias1)->ClsRede       )            
            oSection1:Cell("XMEDLI"	    ):SetValue((cAlias1)->XMEDLI        )            

// ---------[ chamado 88787 - ini ]-----------------------------
            oSection1:Cell('XHAT'       ):SetValue((cAlias1)->XHAT )
// ---------[ chamado 88787 - fim ]-----------------------------
			
			oSection1:PrintLine()
	
		ELSE    
/*		   If ANOMES ==  ' '  
	  	      If !empty((cAlias1)->ZZPCODRDA)
	    	      ANOMES:= (cAlias1)->ZZPANOPAG+(cAlias1)->ZZPMESPAG	    
		      Else 	                                                             
                  ANOMES:= (cAlias1)->BD7ANOPAG+(cAlias1)->BD7PMESPAG	    		    
              EndIf 	
     
		      ANOMES ==  
  */		
			oSection3:Cell("ZZPMESPAG"	):SetValue((cAlias1)->ZZPMESPAG	 )
			oSection3:Cell("ZZPANOPAG"	):SetValue((cAlias1)->ZZPANOPAG	 )                             
			oSection3:Cell("ZZPVLRHOSP"	):SetValue((cAlias1)->ZZPVLRHOSP ) 
			oSection3:Cell("ZZPVLRAMB"	):SetValue((cAlias1)->ZZPVLRAMB  ) 
			oSection3:Cell("ZZPVLROD"	):SetValue((cAlias1)->ZZPVLROD   ) 
			oSection3:Cell("ZZPVLRTOT"	):SetValue((cAlias1)->ZZPVLRTOT  )
			oSection3:Cell("BD7VLRAPR"	):SetValue((cAlias1)->BD7VLRAPR  ) 
			oSection3:Cell("BD7VLRGLO"	):SetValue((cAlias1)->BD7VLRGLO  ) 
			oSection3:Cell("BD7VLRPAG"	):SetValue((cAlias1)->BD7VLRPAG  )
		  	oSection3:Cell("ZZPTPREM"	):SetValue((cAlias1)->ZZPTPREM   ) 
     	    oSection1:Cell("TPESSOA"	):SetValue((cAlias1)->TPESSOA    )
    	    oSection1:Cell("CLSRED"	    ):SetValue((cAlias1)->ClsRede    ) 
            oSection1:Cell("XMEDLI"	    ):SetValue((cAlias1)->XMEDLI     )            

// ---------[ chamado 88787 - ini ]-----------------------------
            oSection1:Cell('XHAT'       ):SetValue((cAlias1)->XHAT )
// ---------[ chamado 88787 - fim ]-----------------------------

			oSection3:PrintLine()
		EndIf
			//-----------------------------------
			//Alimentando totalizadores
			//-----------------------------------    
			
		_nTotGr 	++
		_nTotHsp 	+= (cAlias1)->ZZPVLRHOSP
		_nTotAmb 	+= (cAlias1)->ZZPVLRAMB
		_nTotRod 	+= (cAlias1)->ZZPVLROD
	 	_nTotTt 	+= (cAlias1)->ZZPVLRTOT
		_nTotApr 	+= (cAlias1)->BD7VLRAPR
		_nTotGlo 	+= (cAlias1)->BD7VLRGLO
		_nTotPag 	+= (cAlias1)->BD7VLRPAG
		
		
			
		((cAlias1))->(DbSkip())
		
	EndDo
	If MV_PAR08 == 2                                             
		oSection3:Finish()
	Else
		oSection1:Finish()
	EndIf
	oSection2:Init()
	oSection2:SetHeaderSection(.T.)
		
	oSection2:Cell("TT_REG"		):SetValue( _nTotGr	 )
	oSection2:Cell("TT_ZZPHOSP"	):SetValue( _nTotHsp )
	oSection2:Cell("TT_ZZPAMB"	):SetValue( _nTotAmb )
	oSection2:Cell("TT_ZZPROD"	):SetValue( _nTotRod )
 	oSection2:Cell("TT_ZZPTOT"	):SetValue( _nTotTt	 )
	oSection2:Cell("TT_BD7APR"	):SetValue( _nTotApr )
	oSection2:Cell("TT_BD7GLO"	):SetValue( _nTotGlo )
	oSection2:Cell("TT_BD7PAG"	):SetValue( _nTotPag )
		
	oSection2:PrintLine()
	oSection2:Finish()
//EndIf
If Select ((cAlias1)) > 0
	dbSelectArea( (cAlias1) )
	dbCloseArea()
EndIf
	
RestArea(_aArea)   

//SERGIO CUNHA    
/*
If MsgYesNo("Gerar Planilha?") 
   
		If MV_PAR08 == 1  
			aCabec :=  {"Ident. RDA","Mes Comp. ","Ano Comp","Vlr Prev. Hosp","Vlr Prev. Amb","Vlr Prev. Odont","Vlr Prev. Total","Vlr Custo Apres","Vlr Custo Glos",;
						"Vlr Custo Pgto","Analista Resp ","Tipo Remessa "}
		Else 
			aCabec :=  {"Mes Comp.","Ano Comp.","Vlr Prev. Hosp","Vlr Prev. Amb ","Vlr Prev. Odont","Vlr Prev. Total","Vlr Prev. Total","Vlr Custo Glos",;
						"Vlr Custo Pgto","Tipo Remessa"}
		EndIf


  //		If !ApOleClient("MSExcel") 
  	cNomeArq := "C:\TEMP\Relatorio_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
	
	// criar arquivo texto vazio a partir do root path no servidor
 
		nHandle := FCREATE(cNomeArq)
  			
  			If MV_PAR08 == 1          
			
					cMontaTxt := "Ident. RDA;"
					cMontaTxt += "Mes Comp. ;"
					cMontaTxt += "Ano Comp.;"
					cMontaTxt += "Vlr Prev. Hosp;"
					cMontaTxt += "Vlr Prev. Amb ;"
					cMontaTxt += "Vlr Prev. Odont ;"
			   //		cMontaTxt += "Vlr Prev. Total;"
					cMontaTxt += "Vlr Custo Apres;"
					cMontaTxt += "Vlr Custo Glos ;"
					cMontaTxt += "Vlr Custo Pgto;"  
	  //				cMontaTxt += "Analista Resp ;"
//					cMontaTxt += "Tipo Remessa ;"
			
					cMontaTxt += CRLF // Salto de linha para .csv (excel)
		           
			Else
		            
		            cMontaTxt := "Mes Comp. ;"
					cMontaTxt += "Ano Comp.;"
					cMontaTxt += "Vlr Prev. Hosp;"
					cMontaTxt += "Vlr Prev. Amb ;"
					cMontaTxt += "Vlr Prev. Odont ;"
  //					cMontaTxt += "Vlr Prev. Total;"
					cMontaTxt += "Vlr Custo Apres;"
					cMontaTxt += "Vlr Custo Glos ;"
					cMontaTxt += "Vlr Custo Pgto;"  
	//				cMontaTxt += "Tipo Remessa ;"
			
					cMontaTxt += CRLF // Salto de linha para .csv (excel)
		        
			EndIf
					FWrite(nHandle,cMontaTxt)
		
//		EndIf
For nCount:=1 to len(aDados)
	
	If MV_PAR08 == 1
		
		cMontaTxt := "'"+aDados[nCount][1] + ";"
		cMontaTxt += aDados[nCount][2] + ";"
		cMontaTxt += aDados[nCount][3] + ";"
		
		cMontaTxt += Transform(aDados[nCount][04],"@E 999,999,999.99") + ";"
		cMontaTxt += Transform(aDados[nCount][05],"@E 999,999,999.99") + ";"
		cMontaTxt += Transform(aDados[nCount][06],"@E 999,999,999.99") + ";" 
   //		cMontaTxt += Transform(aDados[nCount][07],"@E 999,999,999.99") + ";"
		cMontaTxt += Transform(aDados[nCount][08],"@E 999,999,999.99") + ";"
		cMontaTxt += Transform(aDados[nCount][09],"@E 999,999,999.99") + ";"		
		cMontaTxt += Transform(aDados[nCount][10],"@E 999,999,999.99") + ";"				
//		cMontaTxt += aDados[nCount][11] + ";"
//		cMontaTxt += aDados[nCount][12] + ";"                
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
	Else
		
		cMontaTxt := aDados[nCount][1] + ";"
		cMontaTxt += aDados[nCount][2] + ";"
		cMontaTxt += Transform(aDados[nCount][03],"@E 999,999,999.99") + ";"
		cMontaTxt += Transform(aDados[nCount][04],"@E 999,999,999.99") + ";"
		cMontaTxt += Transform(aDados[nCount][05],"@E 999,999,999.99") + ";" 
  //		cMontaTxt += Transform(aDados[nCount][06],"@E 999,999,999.99") + ";"
		cMontaTxt += Transform(aDados[nCount][07],"@E 999,999,999.99") + ";"
		cMontaTxt += Transform(aDados[nCount][08],"@E 999,999,999.99") + ";"		
		cMontaTxt += Transform(aDados[nCount][09],"@E 999,999,999.99") + ";"				
  //		cMontaTxt += aDados[nCount][10] + ";"
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
	EndIf                                    
		FWrite(nHandle,cMontaTxt)
	
Next 

_cTit := "Relatório Sintético de movimento de repassados de " + SUBSTR(mv_par03,5,2)+'/'+SUBSTR(mv_par03,1,4) + " até " + SUBSTR(mv_par04,5,2)+'/'+SUBSTR(mv_par04,1,4) + " as " + TIME()		     

//Abre excel
If ApOleClient("MSExcel")
	
	DlgToExcel({{"ARRAY",_cTit,aCabec,aDados}})
		
	
EndIf
If !ApOleClient("MSExcel")
	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf
	
EndIf


EndIf
 */	
Return (.T.)
