#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

#DEFINE cEnt chr(10)+chr(13)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR246   บAutor  ณ Mateus Medeiros   บ Data ณ 20/10/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressใo de Exclusใo e Inclusใo Beneficiแrios MetLife     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AcademiaERP                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR246()
    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
    //ณDeclaracao de variaveis                   ณ
    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Private oReport  := Nil
	Private oSection := Nil
	Private cPerg 	 := PadR ("CABR246", Len (SX1->X1_GRUPO))
	Private  nRegs	 := 0
	Private oBreak
	Private	_cAlias	 := GetNextAlias()
	   
    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
    //ณCriacao e apresentacao das perguntas      ณ
    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PutSx1(cPerg,"01","Empresa?"      ,'','',"mv_ch1","C",TamSx3 ("BA1_CODEMP")[1] ,0,,"G","","CABBG9","","","mv_par01","","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"02","Contrato?"     ,'','',"mv_ch2","C",TamSx3 ("BA1_CONEMP")[1] ,0,,"G","","CAB101","","","mv_par02","","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"03","SubContrato De?"  ,'','',"mv_ch3","C",TamSx3 ("BA1_SUBCON")[1] ,0,,"G","","CB1012","","","mv_par03","","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"04","SubContrato Ate?"  ,'','',"mv_ch4","C",TamSx3 ("BA1_SUBCON")[1] ,0,,"G","","CB1012","","","mv_par04","","","","","","","","","","","","","","","","")
	
	PutSx1(cPerg,"05","Operacao?"     ,'','',"mv_ch5","N",1 ,0,1,"C","","","","","mv_par05","Inclusใo","Inclusใo","Inclusใo","Exclusใo","Exclusใo","Exclusใo","","","","","","","","","","")
	
	PutSx1(cPerg,"06","Perํodo De?"  ,'','',"mv_ch6","D",8 ,0,,"G","","","","","mv_par06","","","","","","","","","","","","","","","","")
	PutSx1(cPerg,"07","Perํodo Ate?"  ,'','',"mv_ch7","D",8 ,0,,"G","","","","","mv_par07","","","","","","","","","","","","","","","","")
	
//	PutSx1(cPerg,"08","Data de Digita็ใo?"  ,'','',"mv_ch8","D",8 ,0,,"G","","","","","mv_par08","","","","","","","","","","","","","","","","")
//	PutSx1(cPerg,"09","Data de Digita็ใo?"  ,'','',"mv_ch9","D",8 ,0,,"G","","","","","mv_par09","","","","","","","","","","","","","","","","")
    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
    //ณDefinicoes/preparacao para impressao      ณ
    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	ReportDef()
	oReport:PrintDialog()
    
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณ Vinํcius Moreira   บ Data ณ 12/11/2013  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Defini็ใo da estrutura do relat๓rio.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
    
     
	oReport := TReport():New("CABR246","Rela็ใo de Beneficiแrios",cPerg,{|oReport| PrintReport(oReport)},"Rela็ใo de Beneficiแrios.")
	oReport:SetLandscape(.T.)
    
	oSection := TRSection():New( oReport , "Rela็ใo de Beneficiแrios", {(_cAlias)} )
    
	TRCell():New(oSection ,'OPERACAO'					,(_cAlias),'OPERACAO'			 , /*Picture*/	,20		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'CONTRATO'					,(_cAlias),'CONTRATO'	 , /*Picture*/	,120		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'CNPJ_DA_FILIAL'				,(_cAlias),'CNPJ_DA_FILIAL'		 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'DESC_FILIAL'				,(_cAlias),'DESC_FILIAL' , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
				
	TRCell():New(oSection ,'MATRICULA'					,(_cAlias),'MATRICULA', /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'DATA_DE_ADMISSAO'			,(_cAlias),'DATA_DE_ADMISSAO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'CARGO_EMPRESA'				,(_cAlias),'CARGO_EMPRESA'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
	TRCell():New(oSection ,'DATA_DE_ADMISSAO'			,(_cAlias),'DATA_DE_ADMISSAO' , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'CENTRO_CUSTO'				,(_cAlias),'CENTRO_DE_CUSTO' , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'DESC_CC'					,(_cAlias),'DESCRICAO_CENTRO_DE_CUSTO' , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'PLANO'						,(_cAlias),'PLANO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
	TRCell():New(oSection ,'NOME_COMPLETO'				,(_cAlias),'NOME_COMPLETO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'TIPO'						,(_cAlias),'TIPO'	 		 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'DEPENDENCIA'				,(_cAlias),'DEPENDENCIA'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
	TRCell():New(oSection ,'NOME_DA_MAE'				,(_cAlias),'NOME_DA_MAE'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'NASCIMENTO'					,(_cAlias),'NASCIMENTO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'PIS'						,(_cAlias),'PIS'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'CPF'						,(_cAlias),'CPF'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'CNS'						,(_cAlias),'CNS'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'RG'							,(_cAlias),'RG'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'ORGAO_EMISSOR'				,(_cAlias),'ORGAO_EMISSOR'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'PAIS_EMISSOR'				,(_cAlias),'PAIS_EMISSOR'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

	TRCell():New(oSection ,'DATA_RG'					,(_cAlias),'DATA_DE_EMISSAO_DO_RG'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'EST_CIVIL'					,(_cAlias),'EST_CIVIL'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'SEXO'						,(_cAlias),'SEXO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'TIPO_LOGRADOURO'			,(_cAlias),'TIPO_LOGRADOURO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'ENDERECO_DA_RESIDENCIA'		,(_cAlias),'ENDERECO_DA_RESIDENCIA'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

	TRCell():New(oSection ,'NUMERO_DA_RESIDENCIA'		,(_cAlias),'NUMERO_DA_RESIDENCIA'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'COMPLEMENTO_RESIDENCIA'		,(_cAlias),'COMPLEMENTO_RESIDENCIA'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'BAIRRO'						,(_cAlias),'BAIRRO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'CODIGO_DO_MUNICIPIO'		,(_cAlias),'CODIGO_DO_MUNICIPIO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'UFS'						,(_cAlias),'UF'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	//TRCell():New(oSection ,'UF'							,(_cAlias),'UF'	 , /*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'CEP'						,(_cAlias),'CEP'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'DDD_RESIDENCIAL'			,(_cAlias),'DDD_RESIDENCIAL'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'TEL_RESIDENCIAL'			,(_cAlias),'TEL_RESIDENCIAL'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
	TRCell():New(oSection ,'DDD_COMERCIAL'				,(_cAlias),'DDD_COMERCIAL'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'TEL_COMERCIAL'				,(_cAlias),'TEL_COMERCIAL'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
	TRCell():New(oSection ,'CELULAR'					,(_cAlias),'CELULAR'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'EMAIL'						,(_cAlias),'EMAIL'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
	TRCell():New(oSection ,'NUMERO_BANCO'				,(_cAlias),'NUMERO_BANCO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'NUMERO_AGENCIA'				,(_cAlias),'NUMERO_AGENCIA'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oSection ,'NUMERO_CONTA'				,(_cAlias),'NUMERO_CONTA'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

	TRCell():New(oSection ,'DECL_NASC_VIVO'				,(_cAlias),'DECL_NASC_VIVO'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
//	TRCell():New(oSection ,'NUM_CARTAO_METLIFE'			,(_cAlias),'NUM_CARTAO_METLIFE'	 , /*Picture*/	,150		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRCOMR01   บAutor  ณ Mateus Medeiros   บ Data ณ 12/11/2013  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintReport(oReport)
    
	Local cQuery     := ""
	Local cNomEmp	 := ""
	Local cSubCon    := ""
	Local aSM0       := FwLoadSM0()
	Local nPosEmpD   := ascan(aSM0,{ |x| x[1]+x[2] == cEmpant+cFilant })
    
	cCnpj := aSM0[nPosEmpD][18]
    
	Pergunte(cPerg,.F.)
    // 1 - Inclusใo / 2 - Exclusใo
	cQuery := "SELECT '"+iif((mv_par05 == 1) ,'1','3')+"'                  OPERACAO,                    "+cEnt
	cQuery += "  BA1_CONEMP	                                               CONTRATO,					"+cEnt
	cQuery += "  BA1_CODINT	                                               CODINT,					"+cEnt
	
	cQuery += "BQC_CNPJ															CNPJ_DA_FILIAL,			"+cEnt
	//cQuery += " '"+cCnpj+"'   		                                       CNPJ_DA_FILIAL,				"+cEnt
	cQuery += "BQC_NREDUZ                                                      DESC_FILIAL,					"+cEnt
	//cQuery += "'SEDE'                                                      DESC_FILIAL,					"+cEnt
	//cQuery += "BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO  MATRICULA,		            "+cEnt
	
	cQuery += "CASE "+cEnt

	cQuery += "WHEN BA1_GRAUPA  = '01'      															"+cEnt    // titular
	cQuery += "		THEN '1'                 															 "+cEnt
	cQuery += "WHEN BA1_GRAUPA  IN ('02','04') 																"+cEnt // conjuge
	cQuery += "THEN '2'																						 "+cEnt
	cQuery += "WHEN BA1_GRAUPA  = '03'    																	 "+cEnt     // companheiro
	cQuery += "		THEN '11'																				 "+cEnt
	cQuery += "WHEN BA1_GRAUPA  IN ('06','13') 																 "+cEnt       // filha
	cQuery += "		THEN '4'																				 "+cEnt
	cQuery += "WHEN BA1_GRAUPA  IN ('05','12')   															 "+cEnt       // filho
	cQuery += "		THEN '3'																				 "+cEnt
	cQuery += "WHEN BA1_GRAUPA  = '08'  																	 "+cEnt     // mae
	cQuery += "		THEN '14'			  																	 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '07'    															         "+cEnt      // pai
	cQuery += "		THEN '17'																				 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '10'    																	 "+cEnt     // sogra
	cQuery += "		THEN '19'																				 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '9'   																	 "+cEnt     // sogro
	cQuery += "	 	THEN '19'																				 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '14' 																     "+cEnt     // IRMAO
	cQuery += "	 	THEN '9'																				 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '15' 																	 "+cEnt       // IRMA
	cQuery += "	 	THEN '10'																	             "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '17'    																	 "+cEnt       // NETO
	cQuery += "	 	THEN '15'			 																	 "+cEnt
	cQuery += "WHEN BA1_GRAUPA  = '18'      																 "+cEnt     // NETO
	cQuery += "	 	THEN '16'			   																	 "+cEnt
	cQuery += "WHEN BA1_GRAUPA  = '21'      																 "+cEnt     // CUNHADO
	cQuery += "	 	THEN '12'																				 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '22'          													         "+cEnt// CUNHADO
	cQuery += "	 	THEN '13'																				 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '23' AND  BA1_SEXO  = '1' 												 "+cEnt// TUTELADO
	cQuery += "	 	THEN '7'																				 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '23' AND  BA1_SEXO  = '2' 												 "+cEnt// TUTELADO
	cQuery += "	 	THEN '8'	 																	    	 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '24' AND  BA1_SEXO  = '1'												 "+cEnt// ENTEADO
	cQuery += "	 	THEN '5'	 																			 "+cEnt
	cQuery += "	WHEN BA1_GRAUPA  = '24' AND  BA1_SEXO  = '2' 												 "+cEnt// ENTEADA"+cEnt
	cQuery += "	 	THEN '6'																				 "+cEnt
	cQuery += "		WHEN BA1_GRAUPA  = '25' AND  BA1_SEXO  = '1'												 
	cQuery += "	    THEN '3'																				
	cQuery += "	  WHEN BA1_GRAUPA  = '25' AND  BA1_SEXO  = '2' 												  
	cQuery += "	    THEN '4'	
	cQuery += "	ELSE 																					     "+cEnt
	cQuery += "	 	BA1_GRAUPA 			   																	 "+cEnt
	cQuery += "END                                                       DEPENDENCIA,						 "+cEnt
	cQuery += "( 																							 "+cEnt
	cQuery += "SELECT  BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO  							 "+cEnt
	cQuery += "FROM "+RetSqlName("BA1")+" BA1 																 "+cEnt
	cQuery += "WHERE  																						 "+cEnt
	cQuery += "BA1_TIPUSU = 'T' 													 						 "+cEnt
	cQuery += "AND BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC = A.BA1_CODINT||A.BA1_CODEMP||A.BA1_MATRIC "+cEnt
	cQuery += "AND BA1.D_E_L_E_T_ = ' ' 																	 "+cEnt
	if mv_par05 = 1
		cQuery += "AND BA1_DATBLO = ' '	 																		 "+cEnt
	else
		cQuery += "AND BA1_DATBLO <> ' ' 																	"+cEnt
	endif
	cQuery += ") MATRICULA,		           																	 "+cEnt
	cQuery += "FORMATA_DATA_MS(BA1_DATINC)                                 DATA_DE_ADMISSAO,			"+cEnt
	cQuery += "' '                                                         CARGO_EMPRESA,			    "+cEnt
	cQuery += "' '                                                         CENTRO_CUSTO,				"+cEnt
	cQuery += "' '                                                         DESC_CC,	                    "+cEnt
	cQuery += "BA1_CODINT || BA1_CODPLA                                    PLANO,						"+cEnt
	cQuery += "BA1_NOMUSR                                                  NOME_COMPLETO,				"+cEnt
	cQuery += "DECODE(BA1_TIPUSU,'T','1','2')                              TIPO,						"+cEnt
//	cQuery += "DECODE(BA1_TIPUSU,'T','1','2')                              DEPENDENCIA,					"+cEnt
	cQuery += "TRIM(BA1_MAE)                                               NOME_DA_MAE,					"+cEnt
	cQuery += "FORMATA_DATA_MS(BA1_DATNAS)                                 NASCIMENTO,					"+cEnt
	cQuery += "BA1_PISPAS                                                  PIS,							"+cEnt
	cQuery += "BA1_CPFUSR                                                  CPF,							"+cEnt
	cQuery += "BTS_NRCRNA                                                  CNS,							"+cEnt
	cQuery += "NVL(BTS_DRGUSR,' ')                                          RG,							"+cEnt
	cQuery += "NVL(BTS_ORGEM,' ')                                           ORGAO_EMISSOR,				"+cEnt
	cQuery += "'BRASIL'                                                    PAIS_EMISSOR,				"+cEnt
	cQuery += "NULL                                                        DATA_RG,		"+cEnt
	cQuery += "DECODE(BA1_ESTCIV,'V','7','S','6','D','3','C','1','M','4')          EST_CIVIL,					"+cEnt
	cQuery += "BA1_SEXO                                                    SEXO,						"+cEnt
	cQuery += "'184'                                                       TIPO_LOGRADOURO,				"+cEnt
	cQuery += "BA1_ENDERE                                                  ENDERECO_DA_RESIDENCIA,		"+cEnt
	cQuery += "TRIM(BA1_NR_END)                                            NUMERO_DA_RESIDENCIA,		"+cEnt
	cQuery += "TRIM(BA1_COMEND)                                            COMPLEMENTO_RESIDENCIA,		"+cEnt
	cQuery += "BA1_BAIRRO                                                  BAIRRO,						"+cEnt
	cQuery += "BA1_CODMUN                                                  CODIGO_DO_MUNICIPIO,			"+cEnt
	cQuery += "BA1_ESTADO                                                  UF,							"+cEnt
	cQuery += "BA1_CEPUSR                                                  CEP,							"+cEnt
	cQuery += "BA1_DDD                                                     DDD_RESIDENCIAL,				"+cEnt
	cQuery += "BA1_TELEFO                                                  TEL_RESIDENCIAL,				"+cEnt
	cQuery += "BA1_DDD                                                     DDD_COMERCIAL,				"+cEnt
	cQuery += "BA1_TELEFO 		                                           TEL_COMERCIAL,				"+cEnt
	cQuery += "BA1_DDD                                                     DDD_CELULAR,					"+cEnt
	cQuery += "BA1_YCEL                                                    TEL_CELULAR,					"+cEnt
	cQuery += "TRIM(BA1_EMAIL)                                             EMAIL,						"+cEnt
	cQuery += "' '                                                         NUMERO_BANCO,				"+cEnt
	cQuery += "' '                                                         NUMERO_AGENCIA,				"+cEnt
	cQuery += "' '                                                         NUMERO_CONTA,				"+cEnt
	cQuery += "BTS_DENAVI                                                  DECL_NASC_VIVO,				"+cEnt
    //cQuery += "'1'      0                                                ENVIAR,						"+cEnt
	cQuery += "BA1_YMTODO                                                  NUM_CARTAO_METLIFE,			"+cEnt
	cQuery += "TO_DATE(BA1_DATINC,'YYYYMMDD')                              DATA_DE_INCLUSAO_CABERJ,		"+cEnt
	cQuery += "BA1_DATBLO                                                  DATA_DE_BLOQUEIO_CABERJ		"+cEnt
	cQuery += "FROM   "+RetSqlName("BA1")+" A , "+RetSqlName("BTS")+" B	, "+RetSqlName("BQC")+" C		"+cEnt
	cQuery += "WHERE  																					"+cEnt
	//cQuery += "    BA1_TIPUSU = 'T'																		"+cEnt
	cQuery += "   BA1_CODEMP = '"+mv_par01+"'															"+cEnt
	cQuery += "      AND BA1_CONEMP = '"+mv_par02+"' 													"+cEnt
	cQuery  += "      AND BA1_SUBCON between '"+mv_par03+"' AND	 '"+mv_par04+"'   					"+cEnt
	if mv_par05 = 1
		cQuery += " AND BA1_DATINC between '"+dtos(mv_par06)+"' AND  '"+dtos(mv_par07)+"'				"+cEnt
		cQuery += " AND BA1_DATBLO = ' '																"+cEnt
	elseif  mv_par05 = 2
		cQuery += " AND BA1_DATBLO between '"+dtos(mv_par06)+"' AND  '"+dtos(mv_par07)+"'				"+cEnt
	else
		cQuery += " BA1_DATBLO = ' ' 																	"+cEnt
	endif
	cQuery += " AND   BTS_MATVID = BA1_MATVID	AND A.D_E_L_E_T_ = ' ' AND B.D_E_L_E_T_ = ' '			"+cEnt
	cQuery += "	AND BQC_NUMCON = BA1_CONEMP AND BQC_CODINT = BA1_CODINT AND BQC_SUBCON = BA1_SUBCON    "+cEnt
	cQuery += "AND BQC_CODEMP = BA1_CODEMP AND C.D_E_L_E_T_ = ' '"+cEnt
	
	// 11/01/2017 - Inclusใo de Filtro data de digita็ใo - A pedido da Daniele Cadastro 
	// Chamado Id 45682
//	if !empty(mv_par08) .and. !empty(mv_par09)
//		cQuery += " AND BA1_YDTDIG	 between '"+dtos(mv_par08)+"' AND  '"+dtos(mv_par09)+"'				"+cEnt
//	endif 
	
//	cQuery += "AND ROWNUM < 7																			"+cEnt
	MemoWrite("c:\microsiga\cabr246.txt",cQuery)
	cQuery := ChangeQuery(cQuery)
    
	//TcQuery cQuery New Alias (_cAlias)
	PlsQuery(cQuery,_cAlias)
	
	(_cAlias)->(dbGoTop())
	(_cAlias)->(dbEval({||nRegs++},,{|| (_cAlias)->(!Eof())}))
	(_cAlias)->(dbGoTop())
    
	oReport:SetMeter(nRegs)
	
    // inicio a quarta se็ใo
	oSection:Init()
    //realiza a impressใo da se็ใo
	Do While (_cAlias)->(!Eof())
        // incrementa regua de processamento
		oReport:IncMeter()
  
		oSection:Cell("OPERACAO"):SetValue((_cAlias)->OPERACAO								)
		oSection:Cell("CONTRATO"):SetValue((_cAlias)->CONTRATO								)
		oSection:Cell("CNPJ_DA_FILIAL"):SetValue((_cAlias)->CNPJ_DA_FILIAL					)
		oSection:Cell("DESC_FILIAL"):SetValue( (_cAlias)->DESC_FILIAL						)
		oSection:Cell("MATRICULA"):SetValue( (_cAlias)->MATRICULA							)
		oSection:Cell("DATA_DE_ADMISSAO"):SetValue( (_cAlias)->DATA_DE_ADMISSAO				)
		oSection:Cell("CARGO_EMPRESA"):SetValue( (_cAlias)->CARGO_EMPRESA					)
		oSection:Cell("CENTRO_CUSTO"):SetValue( (_cAlias)->CENTRO_CUSTO						)
		oSection:Cell("DESC_CC"):SetValue( (_cAlias)->DESC_CC								)
		oSection:Cell("PLANO"):SetValue( Alltrim(GetAdvFVal("BI3","BI3_DESCRI",xFilial("BI3")+(_cAlias)->PLANO,5))									)
		oSection:Cell("NOME_COMPLETO"):SetValue( (_cAlias)->NOME_COMPLETO					)
		oSection:Cell("TIPO"):SetValue( (_cAlias)->TIPO										)
     	
		oSection:Cell("DEPENDENCIA"):SetValue( (_cAlias)->DEPENDENCIA						)
		oSection:Cell("NOME_DA_MAE"):SetValue( (_cAlias)->NOME_DA_MAE						)
		oSection:Cell("NASCIMENTO"):SetValue( (_cAlias)->NASCIMENTO							)
		oSection:Cell("PIS"):SetValue( (_cAlias)->PIS										)
		oSection:Cell("CPF"):SetValue( (_cAlias)->CPF										)
		oSection:Cell("CNS"):SetValue( (_cAlias)->CNS										)
		oSection:Cell("RG"):SetValue( (_cAlias)->RG											)
		oSection:Cell("ORGAO_EMISSOR"):SetValue( (_cAlias)->ORGAO_EMISSOR					)
		oSection:Cell("PAIS_EMISSOR"):SetValue( (_cAlias)->PAIS_EMISSOR						)
		oSection:Cell("DATA_RG"):SetValue( (_cAlias)->DATA_RG								)
		oSection:Cell("EST_CIVIL"):SetValue( (_cAlias)->EST_CIVIL							)
		oSection:Cell("SEXO"):SetValue( (_cAlias)->SEXO										)
		oSection:Cell("TIPO_LOGRADOURO"):SetValue( (_cAlias)->TIPO_LOGRADOURO				)
     	
		oSection:Cell("ENDERECO_DA_RESIDENCIA"):SetValue( (_cAlias)->ENDERECO_DA_RESIDENCIA	)
		oSection:Cell("NUMERO_DA_RESIDENCIA"):SetValue( (_cAlias)->NUMERO_DA_RESIDENCIA		)
		oSection:Cell("COMPLEMENTO_RESIDENCIA"):SetValue( (_cAlias)->COMPLEMENTO_RESIDENCIA	)
		oSection:Cell("BAIRRO"):SetValue( (_cAlias)->BAIRRO									)
     	
		oSection:Cell("CODIGO_DO_MUNICIPIO"):SetValue( (_cAlias)->CODIGO_DO_MUNICIPIO		)
		oSection:Cell("UFS"):SetValue( alltrim((_cAlias)->UF)								)
		oSection:Cell("CEP"):SetValue( (_cAlias)->CEP										)
		oSection:Cell("DDD_RESIDENCIAL"):SetValue( (_cAlias)->DDD_RESIDENCIAL				)
		oSection:Cell("TEL_RESIDENCIAL"):SetValue( (_cAlias)->TEL_RESIDENCIAL				)
     	
		oSection:Cell("NUMERO_BANCO"):SetValue( (_cAlias)->NUMERO_BANCO						)
		oSection:Cell("NUMERO_AGENCIA"):SetValue( (_cAlias)->NUMERO_AGENCIA					)
		oSection:Cell("NUMERO_CONTA"):SetValue( (_cAlias)->NUMERO_CONTA						)
		oSection:Cell("DECL_NASC_VIVO"):SetValue( (_cAlias)->DECL_NASC_VIVO					)
     	
	//	oSection:Cell("DATA_DE_ADMISSAO"):SetValue( (_cAlias)->DATA_DE_ADMISSAO				)
	//	oSection:Cell("NUM_CARTAO_METLIFE"):SetValue( (_cAlias)->NUM_CARTAO_METLIFE			)
		
		oSection:Cell("DDD_COMERCIAL"):SetValue( (_cAlias)->DDD_COMERCIAL			)
        oSection:Cell("TEL_COMERCIAL"):SetValue( (_cAlias)->TEL_COMERCIAL			)
        oSection:Cell("CELULAR"):SetValue( (_cAlias)->TEL_CELULAR			)
        oSection:Cell("EMAIL"):SetValue( (_cAlias)->EMAIL			)
        
        //imprime linha da se็ใo 1
		oSection:Printline()
        
		(_cAlias)->(dbskip())
	EndDo
	
    
	If Select(_cAlias) > 0
		Dbselectarea(_cAlias)
		(_cAlias)->(DbClosearea())
	EndIf
    
    //finalizo a segunda se็ใo para que seja reiniciada para o proximo registro
	oSection:Finish()
    
Return Nil