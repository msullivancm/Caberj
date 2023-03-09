#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

#DEFINE cEnt chr(10)+chr(13)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR157   บAutor  ณ Mateus Medeiros   บ Data ณ 20/10/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressใo de Exclusใo e Inclusใo Beneficiแrios MetLife     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AcademiaERP                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR157()

Private oReport		:= Nil
Private oSection	:= Nil
Private cPerg		:= PadR ("CABR157", Len (SX1->X1_GRUPO))
Private  nRegs		:= 0
Private oBreak
Private	_cAlias		:= GetNextAlias()

// Criacao e apresentacao das perguntas
PutSx1(cPerg,"01","Operacao?"			,'','',"mv_ch1","N",1,0,1,"C","","","","","mv_par01","Inclusใo","Inclusใo","Inclusใo","Exclusใo","Exclusใo","Exclusใo","","","","","","","","","","")
PutSx1(cPerg,"02","Perํodo De?"			,'','',"mv_ch2","D",8,0, ,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"03","Perํodo Ate?"		,'','',"mv_ch3","D",8,0, ,"G","","","","","mv_par03","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"04","Data de Digita็ใo?"  ,'','',"mv_ch4","D",8 ,0,,"G","","","","","mv_par04","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"05","Data de Digita็ใo?"  ,'','',"mv_ch5","D",8 ,0,,"G","","","","","mv_par05","","","","","","","","","","","","","","","","")

// Definicoes/preparacao para impressao
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

oReport := TReport():New("CABR157","Rela็ใo de Beneficiแrios",cPerg,{|oReport| PrintReport(oReport)},"Rela็ใo de Beneficiแrios.")
oReport:SetLandscape(.T.)

oSection := TRSection():New( oReport , "Rela็ใo de Beneficiแrios", {(_cAlias)} )

TRCell():New(oSection ,'OPERACAO'				,(_cAlias),'OPERACAO'			 		, /*Picture*/	,20		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'CONTRATO'				,(_cAlias),'CONTRATO'	 				, /*Picture*/	,120	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'CNPJ_DA_FILIAL'			,(_cAlias),'CNPJ_DA_FILIAL'		 		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'DESC_FILIAL'			,(_cAlias),'DESC_FILIAL' 				, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'MATRICULA'				,(_cAlias),'MATRICULA'					, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'DATA_DE_ADMISSAO'		,(_cAlias),'DATA_DE_ADMISSAO'	 		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'CARGO_EMPRESA'			,(_cAlias),'CARGO_EMPRESA'	 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'DATA_DE_ADMISSAO'		,(_cAlias),'DATA_DE_ADMISSAO' 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'CENTRO_CUSTO'			,(_cAlias),'CENTRO_DE_CUSTO' 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'DESC_CC'				,(_cAlias),'DESCRICAO_CENTRO_DE_CUSTO' , /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'PLANO'					,(_cAlias),'PLANO'	 					, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'NOME_COMPLETO'			,(_cAlias),'NOME_COMPLETO'	 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'TIPO'					,(_cAlias),'TIPO'	 		 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'DEPENDENCIA'			,(_cAlias),'DEPENDENCIA'				, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'NOME_DA_MAE'			,(_cAlias),'NOME_DA_MAE'	 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'NASCIMENTO'				,(_cAlias),'NASCIMENTO'	 				, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'PIS'					,(_cAlias),'PIS'	 					, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'CPF'					,(_cAlias),'CPF'	 					, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'CNS'					,(_cAlias),'CNS'	 					, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'RG'						,(_cAlias),'RG'	 						, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'ORGAO_EMISSOR'			,(_cAlias),'ORGAO_EMISSOR'	 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'PAIS_EMISSOR'			,(_cAlias),'PAIS_EMISSOR'	 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'DATA_RG'				,(_cAlias),'DATA_DE_EMISSAO_DO_RG'		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'EST_CIVIL'				,(_cAlias),'EST_CIVIL'	 				, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'SEXO'					,(_cAlias),'SEXO'	 					, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'TIPO_LOGRADOURO'		,(_cAlias),'TIPO_LOGRADOURO'	 		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'ENDERECO_DA_RESIDENCIA'	,(_cAlias),'ENDERECO_DA_RESIDENCIA'		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'NUMERO_DA_RESIDENCIA'	,(_cAlias),'NUMERO_DA_RESIDENCIA'		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'COMPLEMENTO_RESIDENCIA'	,(_cAlias),'COMPLEMENTO_RESIDENCIA'		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'BAIRRO'					,(_cAlias),'BAIRRO'	 					, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'CODIGO_DO_MUNICIPIO'	,(_cAlias),'CODIGO_DO_MUNICIPIO'		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'UFS'					,(_cAlias),'UF'	 						, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
//TRCell():New(oSection ,'UF'					,(_cAlias),'UF'	 						, /*Picture*/	,50		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'CEP'					,(_cAlias),'CEP'	 					, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'DDD_RESIDENCIAL'		,(_cAlias),'DDD_RESIDENCIAL'	 		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'TEL_RESIDENCIAL'		,(_cAlias),'TEL_RESIDENCIAL'	 		, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'DDD_COMERCIAL'			,(_cAlias),'DDD_COMERCIAL'	 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'TEL_COMERCIAL'			,(_cAlias),'TEL_COMERCIAL'				, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'CELULAR'				,(_cAlias),'CELULAR'	 				, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'EMAIL'					,(_cAlias),'EMAIL'	 					, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'NUMERO_BANCO'			,(_cAlias),'NUMERO_BANCO'				, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'NUMERO_AGENCIA'			,(_cAlias),'NUMERO_AGENCIA'				, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'NUMERO_CONTA'			,(_cAlias),'NUMERO_CONTA'	 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

TRCell():New(oSection ,'DECL_NASC_VIVO'			,(_cAlias),'DECL_NASC_VIVO'	 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)
TRCell():New(oSection ,'DATBLO'					,(_cAlias),'DATBLO'	 		 			, /*Picture*/	,150	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"	)

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

Local cQuery		:= ""
Local aSM0			:= FwLoadSM0()
Local nPosEmpD		:= ascan(aSM0,{ |x| x[1]+x[2] == cEmpant+cFilant })

cCnpj	:= aSM0[nPosEmpD][18]

Pergunte(cPerg,.F.)

// 1 - Inclusใo / 2 - Exclusใo
cQuery := " SELECT '" + iif((mv_par01 == 1), '1', '3') + "' OPERACAO,"						+ cEnt
cQuery +=	" TRIM(SIGA.FORMATA_DATA_MS(BA1_DATBLO)) DATBLO,"								+ cEnt
cQuery +=	" BG9_XMETL CONTRATO,"															+ cEnt
cQuery +=	" BA1_CODINT CODINT,"															+ cEnt
cQuery +=	" BG9_XCNPJ CNPJ_DA_FILIAL,"													+ cEnt
cQuery +=	" BQC_NREDUZ DESC_FILIAL,"														+ cEnt
cQuery +=	" CASE WHEN BA1_GRAUPA = '01' THEN '1'"											+ cEnt // titular
cQuery +=		" WHEN BA1_GRAUPA IN ('02','04') THEN '2'"									+ cEnt // conjuge
cQuery +=		" WHEN BA1_GRAUPA = '03' THEN '11'"											+ cEnt // companheiro
cQuery +=		" WHEN BA1_GRAUPA IN ('06','13') THEN '4'"									+ cEnt // filha
cQuery +=		" WHEN BA1_GRAUPA IN ('05','12') THEN '3'"									+ cEnt // filho
cQuery +=		" WHEN BA1_GRAUPA = '08' THEN '14'"											+ cEnt // mae
cQuery +=		" WHEN BA1_GRAUPA = '07' THEN '17'"											+ cEnt // pai
cQuery +=		" WHEN BA1_GRAUPA = '10' THEN '19'"											+ cEnt // sogra
cQuery +=		" WHEN BA1_GRAUPA = '9' THEN '19'"											+ cEnt // sogro
cQuery +=		" WHEN BA1_GRAUPA = '14' THEN '9'"											+ cEnt // IRMAO
cQuery +=		" WHEN BA1_GRAUPA = '15' THEN '10'"											+ cEnt // IRMA
cQuery +=		" WHEN BA1_GRAUPA = '17' THEN '15'"											+ cEnt // NETO
cQuery +=		" WHEN BA1_GRAUPA = '18' THEN '16'"											+ cEnt // NETO
cQuery +=		" WHEN BA1_GRAUPA = '21' THEN '12'"											+ cEnt // CUNHADO
cQuery +=		" WHEN BA1_GRAUPA = '22' THEN '13'"											+ cEnt // CUNHADO
cQuery +=		" WHEN BA1_GRAUPA = '23' AND BA1_SEXO = '1' THEN '7'"						+ cEnt // TUTELADO
cQuery +=		" WHEN BA1_GRAUPA = '23' AND BA1_SEXO = '2' THEN '8'"						+ cEnt // TUTELADA
cQuery +=		" WHEN BA1_GRAUPA = '24' AND BA1_SEXO = '1' THEN '5'"						+ cEnt // ENTEADO
cQuery +=		" WHEN BA1_GRAUPA = '24' AND BA1_SEXO = '2' THEN '6'"						+ cEnt // ENTEADA
cQuery +=		" WHEN BA1_GRAUPA = '25' AND BA1_SEXO = '1' THEN '3'"						+ cEnt
cQuery +=		" WHEN BA1_GRAUPA = '25' AND BA1_SEXO = '2' THEN '4'"						+ cEnt
cQuery +=			" ELSE BA1_GRAUPA END DEPENDENCIA,"										+ cEnt
cQuery +=	" (SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO"			+ cEnt
cQuery +=	 " FROM " + RetSqlName("BA1") + " BA2"											+ cEnt
cQuery +=	 " WHERE BA2.D_E_L_E_T_ = ' '"													+ cEnt
cQuery +=		" AND BA2.BA1_TIPUSU = 'T'"													+ cEnt
cQuery +=		" AND BA2.BA1_CODINT||BA2.BA1_CODEMP||BA2.BA1_MATRIC ="
cQuery +=			" BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC) MATRICULA,"			+ cEnt
cQuery +=	" FORMATA_DATA_MS(BA1_DATINC) DATA_DE_ADMISSAO,"								+ cEnt
cQuery +=	" ' ' CARGO_EMPRESA,"															+ cEnt
cQuery +=	" ' ' CENTRO_CUSTO,"															+ cEnt
cQuery +=	" ' ' DESC_CC,"																	+ cEnt
cQuery +=	" BA1_CODINT||BA1_CODPLA PLANO,"												+ cEnt
cQuery +=	" BA1_NOMUSR NOME_COMPLETO,"													+ cEnt
cQuery +=	" DECODE(BA1_TIPUSU,'T','1','2') TIPO,"											+ cEnt
cQuery +=	" TRIM(BA1_MAE) NOME_DA_MAE,"													+ cEnt
cQuery +=	" FORMATA_DATA_MS(BA1_DATNAS) NASCIMENTO,"										+ cEnt
cQuery +=	" BA1_PISPAS PIS,"																+ cEnt
cQuery +=	" BA1_CPFUSR CPF,"																+ cEnt
cQuery +=	" BTS_NRCRNA CNS,"																+ cEnt
cQuery +=	" NVL(BTS_DRGUSR,' ') RG,"														+ cEnt
cQuery +=	" NVL(BTS_ORGEM,' ') ORGAO_EMISSOR,"											+ cEnt
cQuery +=	" 'BRASIL' PAIS_EMISSOR,"														+ cEnt
cQuery +=	" NULL DATA_RG,"																+ cEnt
cQuery +=	" DECODE(BA1_ESTCIV,'V','7','S','6','D','3','C','1','M','4') EST_CIVIL,"		+ cEnt
cQuery +=	" BA1_SEXO SEXO,"																+ cEnt
cQuery +=	" '184' TIPO_LOGRADOURO,"														+ cEnt
cQuery +=	" BA1_ENDERE ENDERECO_DA_RESIDENCIA,"											+ cEnt
cQuery +=	" TRIM(BA1_NR_END) NUMERO_DA_RESIDENCIA,"										+ cEnt
cQuery +=	" TRIM(BA1_COMEND) COMPLEMENTO_RESIDENCIA,"										+ cEnt
cQuery +=	" BA1_BAIRRO BAIRRO,"															+ cEnt
cQuery +=	" BA1_CODMUN CODIGO_DO_MUNICIPIO,"												+ cEnt
cQuery +=	" BA1_ESTADO UF,"																+ cEnt
cQuery +=	" BA1_CEPUSR CEP,"																+ cEnt
cQuery +=	" BA1_DDD DDD_RESIDENCIAL,"														+ cEnt
cQuery +=	" BA1_TELEFO TEL_RESIDENCIAL,"													+ cEnt
cQuery +=	" BA1_DDD DDD_COMERCIAL,"														+ cEnt
cQuery +=	" BA1_TELEFO TEL_COMERCIAL,"													+ cEnt
cQuery +=	" BA1_DDD DDD_CELULAR,"															+ cEnt
cQuery +=	" BA1_YCEL TEL_CELULAR,"														+ cEnt
cQuery +=	" TRIM(BA1_EMAIL) EMAIL,"														+ cEnt
cQuery +=	" ' ' NUMERO_BANCO,"															+ cEnt
cQuery +=	" ' ' NUMERO_AGENCIA,"															+ cEnt
cQuery +=	" ' ' NUMERO_CONTA,"															+ cEnt
cQuery +=	" BTS_DENAVI DECL_NASC_VIVO,"													+ cEnt
cQuery +=	" BA1_YMTODO NUM_CARTAO_METLIFE,"												+ cEnt
cQuery +=	" TO_DATE(BA1_DATINC,'YYYYMMDD') DATA_DE_INCLUSAO_CABERJ,"						+ cEnt
cQuery +=	" BA1_DATBLO DATA_DE_BLOQUEIO_CABERJ"											+ cEnt
cQuery += " FROM " + RetSqlName("BA1") + " BA1"												+ cEnt
cQuery +=	" INNER JOIN " + RetSqlName("BTS") + " BTS"										+ cEnt
cQuery +=		" ON (    BTS_FILIAL = BA1_FILIAL"											+ cEnt
cQuery +=			" AND BTS_MATVID = BA1_MATVID)"											+ cEnt
cQuery +=	" INNER JOIN " + RetSqlName("BQC") + " BQC"										+ cEnt
cQuery +=		" ON (    BQC_FILIAL = BA1_FILIAL"											+ cEnt
cQuery +=			" AND BQC_CODIGO = BA1_CODINT||BA1_CODEMP"								+ cEnt
cQuery +=			" AND BQC_NUMCON = BA1_CONEMP"											+ cEnt
cQuery +=			" AND BQC_VERCON = BA1_VERCON"											+ cEnt
cQuery +=			" AND BQC_SUBCON = BA1_SUBCON"											+ cEnt
cQuery +=			" AND BQC_VERSUB = BA1_VERSUB)"											+ cEnt
cQuery +=	" INNER JOIN " + RetSqlName("BI3") + " BI3"										+ cEnt
cQuery +=		" ON (    BI3_FILIAL = BA1_FILIAL"											+ cEnt
cQuery +=			" AND BI3_CODINT = BA1_CODINT"											+ cEnt
cQuery +=			" AND BI3_CODIGO = BA1_CODPLA"											+ cEnt
cQuery +=			" AND BI3_VERSAO = BA1_VERSAO)"											+ cEnt
cQuery +=	" INNER JOIN " + RetSqlName("BG9") + " BG9"										+ cEnt
cQuery +=		" ON (    BG9_FILIAL = BA1_FILIAL"											+ cEnt
cQuery +=			" AND BG9_CODINT = BA1_CODINT"											+ cEnt
cQuery +=			" AND BG9_CODIGO = BA1_CODEMP)"											+ cEnt
cQuery += " WHERE BA1.D_E_L_E_T_ = ' ' AND BTS.D_E_L_E_T_ = ' ' AND BQC.D_E_L_E_T_ = ' '"	+ cEnt
cQuery +=	" AND BI3.D_E_L_E_T_ = ' ' AND BG9.D_E_L_E_T_ = ' '"							+ cEnt
cQuery +=	" AND BI3_CODSEG = '004'"														+ cEnt

if mv_par01 = 1
	cQuery += " AND BA1_DATINC between '" + DtoS(mv_par02) + "' AND '" + DtoS(mv_par03) + "'"	+ cEnt
	cQuery += " AND BA1_DATBLO = ' '"															+ cEnt
elseif mv_par01 = 2
	cQuery += " AND BA1_DATBLO between '" + DtoS(mv_par02) + "' AND '" + DtoS(mv_par03) + "'"	+ cEnt
else
	cQuery += " AND BA1_DATBLO = ' '"															+ cEnt
endif

// Chamado Id 45682		-	11/01/2017 - Inclusใo de Filtro data de digita็ใo - A pedido da Daniele Cadastro
if !empty(mv_par05) .and. !empty(mv_par06)
	cQuery += " AND BA1_YDTDIG between '" + DtoS(mv_par05) + "' AND '" + DtoS(mv_par06) + "'"	+ cEnt
endif

if cEmpAnt == '02'
	cQuery += " AND BA1_CODEMP <> '0392'"														+ cEnt	//PREFEITURA DENTAL
endif

MemoWrite("c:\microsiga\CABR157.txt",cQuery)

cQuery := ChangeQuery(cQuery)

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

	oSection:Cell("OPERACAO"):SetValue((_cAlias)->OPERACAO														)
	oSection:Cell("CONTRATO"):SetValue((_cAlias)->CONTRATO														)
	oSection:Cell("CNPJ_DA_FILIAL"):SetValue((_cAlias)->CNPJ_DA_FILIAL											)
	oSection:Cell("DESC_FILIAL"):SetValue( (_cAlias)->DESC_FILIAL												)
	oSection:Cell("MATRICULA"):SetValue( (_cAlias)->MATRICULA													)
	oSection:Cell("DATA_DE_ADMISSAO"):SetValue( (_cAlias)->DATA_DE_ADMISSAO										)
	oSection:Cell("CARGO_EMPRESA"):SetValue( (_cAlias)->CARGO_EMPRESA											)
	oSection:Cell("CENTRO_CUSTO"):SetValue( (_cAlias)->CENTRO_CUSTO												)
	oSection:Cell("DESC_CC"):SetValue( (_cAlias)->DESC_CC														)
	oSection:Cell("PLANO"):SetValue( Alltrim(GetAdvFVal("BI3","BI3_DESCRI",xFilial("BI3")+(_cAlias)->PLANO,5))	)
	oSection:Cell("NOME_COMPLETO"):SetValue( (_cAlias)->NOME_COMPLETO											)
	oSection:Cell("TIPO"):SetValue( (_cAlias)->TIPO																)
	oSection:Cell("DEPENDENCIA"):SetValue( (_cAlias)->DEPENDENCIA												)
	oSection:Cell("NOME_DA_MAE"):SetValue( (_cAlias)->NOME_DA_MAE												)
	oSection:Cell("NASCIMENTO"):SetValue( (_cAlias)->NASCIMENTO													)
	oSection:Cell("PIS"):SetValue( (_cAlias)->PIS																)
	oSection:Cell("CPF"):SetValue( (_cAlias)->CPF																)
	oSection:Cell("CNS"):SetValue( (_cAlias)->CNS																)
	oSection:Cell("RG"):SetValue( (_cAlias)->RG																	)
	oSection:Cell("ORGAO_EMISSOR"):SetValue( (_cAlias)->ORGAO_EMISSOR											)
	oSection:Cell("PAIS_EMISSOR"):SetValue( (_cAlias)->PAIS_EMISSOR												)
	oSection:Cell("DATA_RG"):SetValue( (_cAlias)->DATA_RG														)
	oSection:Cell("EST_CIVIL"):SetValue( (_cAlias)->EST_CIVIL													)
	oSection:Cell("SEXO"):SetValue( (_cAlias)->SEXO																)
	oSection:Cell("TIPO_LOGRADOURO"):SetValue( (_cAlias)->TIPO_LOGRADOURO										)
	oSection:Cell("ENDERECO_DA_RESIDENCIA"):SetValue( (_cAlias)->ENDERECO_DA_RESIDENCIA							)
	oSection:Cell("NUMERO_DA_RESIDENCIA"):SetValue( (_cAlias)->NUMERO_DA_RESIDENCIA								)
	oSection:Cell("COMPLEMENTO_RESIDENCIA"):SetValue( (_cAlias)->COMPLEMENTO_RESIDENCIA							)
	oSection:Cell("BAIRRO"):SetValue( (_cAlias)->BAIRRO															)
	oSection:Cell("CODIGO_DO_MUNICIPIO"):SetValue( (_cAlias)->CODIGO_DO_MUNICIPIO								)
	oSection:Cell("UFS"):SetValue( alltrim((_cAlias)->UF)														)
	oSection:Cell("CEP"):SetValue( (_cAlias)->CEP																)
	oSection:Cell("DDD_RESIDENCIAL"):SetValue( (_cAlias)->DDD_RESIDENCIAL										)
	oSection:Cell("TEL_RESIDENCIAL"):SetValue( (_cAlias)->TEL_RESIDENCIAL										)
	oSection:Cell("NUMERO_BANCO"):SetValue( (_cAlias)->NUMERO_BANCO												)
	oSection:Cell("NUMERO_AGENCIA"):SetValue( (_cAlias)->NUMERO_AGENCIA											)
	oSection:Cell("NUMERO_CONTA"):SetValue( (_cAlias)->NUMERO_CONTA												)
	oSection:Cell("DECL_NASC_VIVO"):SetValue( (_cAlias)->DECL_NASC_VIVO											)
	//oSection:Cell("DATA_DE_ADMISSAO"):SetValue( (_cAlias)->DATA_DE_ADMISSAO									)
	//oSection:Cell("NUM_CARTAO_METLIFE"):SetValue( (_cAlias)->NUM_CARTAO_METLIFE								)
	oSection:Cell("DDD_COMERCIAL"):SetValue( (_cAlias)->DDD_COMERCIAL											)
	oSection:Cell("TEL_COMERCIAL"):SetValue( (_cAlias)->TEL_COMERCIAL											)
	oSection:Cell("CELULAR"):SetValue( (_cAlias)->TEL_CELULAR													)
	oSection:Cell("EMAIL"):SetValue( (_cAlias)->EMAIL															)

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
