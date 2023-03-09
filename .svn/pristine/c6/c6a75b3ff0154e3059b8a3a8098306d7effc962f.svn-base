#include "Protheus.ch"

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  CABR074    ∫Autor  ≥Luis Felipe Mattos  ∫ Data ≥  10/11/2012 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥ DIOPS Demonstrativo Periodo - Resultado                    ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                         ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
//
//	Alteracoes:		14/05/13	- Vitor Sbano	- ajuste de Perguntas / pasta de origem arquivo
//
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
//
//  Alteracoes:		15/10/13	- Rafael Fernandes
//	Inclus„o de TAG <ans:coberturaAssistencial> do XML do DIOPS
//
*/
User Function CABR074()

Local oReport
Local aArea := GetArea()

Private _cPerg	  := "CABR074A"
Private _cfile    := ""
Private _cerror   := ""
Private _cwarning := ""
Private _oxml 	  := NIL

alert("CABERJ - Impressao DIOPS - Versao 22/Out/2013")

If TRepInUse()

//	PutSx1( _cPerg, "01","XML Diopsftr  ?" ,"","","mv_ch1","C",30,0,0,"G","","DIR","","","mv_par01")//
//
//	If !Pergunte(_cPerg,.T.)
//		Return
//	EndIf
//
	PutSx1( _cPerg, "01","XML Diopsftr  ? " ,"","","mv_ch1","C",60,0,0,"G","","DIR","","","mv_par01")  
	PutSx1( _cPerg, "02","Nome Arquivo XML " ,"","","mv_ch2","C",15,0,0,"G","","","","","mv_par02")  
	//
	If !Pergunte(_cPerg,.T.)
		Return
	EndIf
	// Copia arquivos do remote local para o servidor, compactando antes de transmitir
	//  CpyT2S( "C:\TEMP\MANUAL.DOC", "\BKP" )
	// Copia arquivos do remote local para o servidor, sem compactar antes de transmitir
	//  CpyT2S( "C:\TEMP\MANUAL.DOC", "\BKP", .F. )
    //                                         
    MakeDir("\DIOPS") // Incluido por Rafael Fernandes  - 15/10/13
    CpyT2S( MV_PAR01, "\DIOPS", .F. )   	&& Efetua a copia para a pasta \Protheus_data\DIOPS
	MV_PAR01	:=	"\DIOPS\"+MV_PAR02
	//
	oReport := ReportDef()
	oReport:PrintDialog()

EndIf

RestArea(aArea)

Return

*-------------------------------------------------------
Static Function ReportDef()
*-------------------------------------------------------
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local oSection4
Local oSection5
Local oSection6
Local oSection7
Local oSection8
Local oSection9
Local oSectionA 
Local oSectionB 
Local oSectionC
Local oSectionD

oReport := TReport():New("CABR074","DIOPS Demonstrativo Periodo",_cPerg,{|oReport| Report(oReport)},"DIOPS Demonstrativo Periodo")

oReport:SetLandscape()    // Define a orientacao de pagina do relatorio como paisagem.
oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
oReport:nFontBody	:= 06 // Define o tamanho da fonte.
oReport:nLineHeight	:= 50 // Define a altura da linha.

oSection1 := TRSection():New(oReport,"OPERADORA",{""})
	
TRCell():New(oSection1,"",/*Tabela*/,"Registro na ANS",,,/*lPixel*/	,{|| _Ans})  
TRCell():New(oSection1,"",/*Tabela*/,"CNPJ",,,/*lPixel*/			,{|| _CNPJ})
TRCell():New(oSection1,"",/*Tabela*/,"Raz„o Social",,50,.F.			,{|| ALLTRIM(_RSocial)})
TRCell():New(oSection1,"",/*Tabela*/,"Periodo",,50,.F.				,{|| _Periodo})
TRCell():New(oSection1,"",/*Tabela*/,"TransaÁ„o",,,/*lPixel*/		,{|| _Transac})

oSection2 := TRSection():New(oReport,"ATIVOS VINCULADOS (INVESTIMENTO)",{""})
	
TRCell():New(oSection2,"",/*Tabela*/,"Tipo Ativo"	   	,,20,/*lPixel*/								,{|| _Codigo},,,,,,.F.)
TRCell():New(oSection2,"",/*Tabela*/,"CustÛdia"			,,20,/*lPixel*/	   							,{|| _Custodia},,,,,,.F.)
TRCell():New(oSection2,"",/*Tabela*/,"Data Emiss„o"		,,15,/*lPixel*/			   					,{|| _DataEmissao},,,,,,.F.)
TRCell():New(oSection2,"",/*Tabela*/,"Data Vencto"		,,15,/*lPixel*/			   					,{|| _DataVencimento},,,,,,.F.)
TRCell():New(oSection2,"",/*Tabela*/,"Tipo Outros"		,,15,/*lPixel*/								,{|| _TipoOutros},,,,,,.F.)
TRCell():New(oSection2,"",/*Tabela*/,"Tipo do Bem"		,,70,/*lPixel*/								,{|| _TipoBem},,,,,,.F.)
TRCell():New(oSection2,"",/*Tabela*/,"Quantidade"		,PesqPict("SD1","D1_QUANT"),20,/*lPixel*/	,{|| Val(_Quantidade)},,,,,,.F.)
TRCell():New(oSection2,"",/*Tabela*/,"PreÁo Unit·rio"	,PesqPict("CT2","CT2_VALOR"),20,/*lPixel*/	,{|| Val(_Precounitario)},,,,,,.F.)
TRCell():New(oSection2,"",/*Tabela*/,"Valor Cont·bil"	,PesqPict("CT2","CT2_VALOR"),35,/*lPixel*/	,{|| Val(_ValorContabil)},,,,,,.F.)

oSection3 := TRSection():New(oReport,"FLUXO DE CAIXA",{""})
	
TRCell():New(oSection3,"",/*Tabela*/,"DescriÁ„o"		,,175,/*lPixel*/	   						,{|| _Conta3},,,,,,.F.)
TRCell():New(oSection3,"",/*Tabela*/,"Valor"			,PesqPict("CT2","CT2_VALOR"),40,/*lPixel*/	,{|| Val(_Valor3)},,,,,,.F.)

oSection4 := TRSection():New(oReport,"LUCRO OU PREJUIZO",{""})
	
TRCell():New(oSection4,"",/*Tabela*/,"DescriÁ„o"		,,175,/*lPixel*/	   						,{|| _Conta4},,,,,,.F.)
TRCell():New(oSection4,"",/*Tabela*/,"Valor"			,PesqPict("CT2","CT2_VALOR"),40,/*lPixel*/	,{|| Val(_Valor4)},,,,,,.F.)

oSection5 := TRSection():New(oReport,"INFORMA«’ES COMPLEMENTARES PARA MARGEM DE SOLV NCIA",{""})
	
TRCell():New(oSection5,"",/*Tabela*/,"DescriÁ„o"		,,175,/*lPixel*/	   						,{|| _Conta5},,,,,,.F.)
TRCell():New(oSection5,"",/*Tabela*/,"Valor"			,PesqPict("CT2","CT2_VALOR"),40,/*lPixel*/	,{|| Val(_Valor5)},,,,,,.F.)

oSection6 := TRSection():New(oReport,"BALANCETE",{""})
	
TRCell():New(oSection6,"",/*Tabela*/,"Conta"	   		,,40,.F.							  		,{|| _Conta},,,,,,.F.)
TRCell():New(oSection6,"",/*Tabela*/,"DescriÁ„o"		,,55,/*lPixel*/	   					  		,{|| _Descricao},,,,,,.F.)
TRCell():New(oSection6,"",/*Tabela*/,"Saldo Anterior"	,"@e 999,999,999,999.99",35,/*lPixel*/		,{|| Val(_SaldoAnterior)},,,,,,.F.)
TRCell():New(oSection6,"",/*Tabela*/,"DÈbito"			,"@e 999,999,999,999.99",35,/*lPixel*/		,{|| Val(_Debitos)},,,,,,.F.)
TRCell():New(oSection6,"",/*Tabela*/,"CrÈdito"			,"@e 999,999,999,999.99",35,/*lPixel*/		,{|| Val(_Creditos)},,,,,,.F.)
TRCell():New(oSection6,"",/*Tabela*/,"Saldo Final"		,"@e 999,999,999,999.99",35,/*lPixel*/		,{|| Val(_SaldoFinal)},,,,,,.F.)

//TRCell():New(oSection2,'D4_COD'	 	,'SD4',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/)

oSection7 := TRSection():New(oReport,"IDADE SALDO ATIVO",{""})
	
TRCell():New(oSection7,"",/*Tabela*/,"Coletivo Pos"		,"@e 999,999,999,999,999.99",,.F.			,{|| Val(_COLETIVOPOS)},,,,,,.T.)
TRCell():New(oSection7,"",/*Tabela*/,"Coletivo Pre"		,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_COLETIVOPRE)},,,,,,.T.)
TRCell():New(oSection7,"",/*Tabela*/,"Conv Receber"		,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_CONVRECEBER)},,,,,,.T.)
TRCell():New(oSection7,"",/*Tabela*/,"Cred Oper"		,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_CREDOPER)},,,,,,.T.)
TRCell():New(oSection7,"",/*Tabela*/,"Individual Pos"	,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_INDIVIDUALPOS)},,,,,,.T.)
TRCell():New(oSection7,"",/*Tabela*/,"Individual Pre"	,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_INDIVIDUALPRE)},,,,,,.T.)
TRCell():New(oSection7,"",/*Tabela*/,"Outros Cred Plano","@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_OUTROSCREDCOMPLANO)},,,,,,.T.)
TRCell():New(oSection7,"",/*Tabela*/,"Parte Benefes"	,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_PARTBENEFES)},,,,,,.T.)
TRCell():New(oSection7,"",/*Tabela*/,"Taxa ADM"      	,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_TAXAADM)},,,,,,.T.)
TRCell():New(oSection7,"",/*Tabela*/,"Dias"          	,"@e 9999"					,,/*lPixel*/	,{|| _DIAS},,,,,,.T.)

oSection8 := TRSection():New(oReport,"IDADE SALDO PASSIVO",{""})
	
TRCell():New(oSection8,"",/*Tabela*/,"Comercial"   		 ,"@e 999,999,999,999,999.99",,.F.			,{|| Val(_COMERCIAL)},,,,,,.T.)
TRCell():New(oSection8,"",/*Tabela*/,"Deb Oper"    		 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_DEBOPER)},,,,,,.T.)
TRCell():New(oSection8,"",/*Tabela*/,"Dep Aquis Carre"   ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_DEPAQUISCARRE)},,,,,,.T.)
TRCell():New(oSection8,"",/*Tabela*/,"Dep Benc Consegrec","@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_DEPBENCONSEGREC)},,,,,,.T.)
TRCell():New(oSection8,"",/*Tabela*/,"Eventos"       	 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_EVENTOS)},,,,,,.T.)
TRCell():New(oSection8,"",/*Tabela*/,"Outros Deb Oper" 	 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_OUTROSDEBOPER)},,,,,,.T.)
TRCell():New(oSection8,"",/*Tabela*/,"Outros Deb Pagar"  ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_OUTROSDEBPAGAR)},,,,,,.T.)
TRCell():New(oSection8,"",/*Tabela*/,"Prest Ser Vas"	 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| Val(_PRESTSERVAS)},,,,,,.T.)
TRCell():New(oSection8,"",/*Tabela*/,"Dias"          	 ,"@e 9999"                  ,,/*lPixel*/	,{|| _DIAS},,,,,,.T.)

oSection9 := TRSection():New(oReport,"INTERCAMBIO",{""})
	
TRCell():New(oSection9,"",/*Tabela*/,"Registradora"		 ,							 ,50,.F.			,{|| _REGISTROOPERADORA},,,,,,.F.)
TRCell():New(oSection9,"",/*Tabela*/,"Saldo"    		 ,"@e 999,999,999,999,999.99",30,/*lPixel*/	,{|| Val(_SALDOINTERCAMBIO)},,,,,,.F.)

oSectionA:= TRSection():New(oReport,"REGISTRADORAS",{""})
	
TRCell():New(oSectionA,"",/*Tabela*/,"Registradora Assumida",							,50,.F.		,{|| _REGISTROOPERADORA_ASSUMIDA},,,,,,.F.)
TRCell():New(oSectionA,"",/*Tabela*/,"Saldo"    		 ,"@e 999,999,999,999,999.99"	,30,/*lPixel*/,{|| Val(_LANCCORRESPONSABILIDADEASSUMIDA)},,,,,,.F.)
TRCell():New(oSectionA,"",/*Tabela*/,"Registradora Transferida",						,50,.F.		,{|| _REGISTROOPERADORA_TRANSFERIDA},,,,,,.F.)
TRCell():New(oSectionA,"",/*Tabela*/,"Saldo"    		 ,"@e 999,999,999,999,999.99"	,30,/*lPixel*/,{|| Val(_SALDOINTERCAMBIO_TRANSFERIDA)},,,,,,.F.)

oSectionB:= TRSection():New(oReport,"EVENTOS SINISTROS",{""})
	
TRCell():New(oSectionB,"",/*Tabela*/,"Sinistros Ate"	 ,"@e 999,999,999,999,999.99"	,50,.F.		,{|| Val(_EVENTOSINISTROSATE)},,,,,,.F.)
TRCell():New(oSectionB,"",/*Tabela*/,"Sinistros Pos"	 ,"@e 999,999,999,999,999.99"	,50,/*lPixel*/,{|| Val(_EVENTOSINISTROSPOS)},,,,,,.F.)
        

//Incluido por Rafael Fernandes  - INICIO
// Inclus„o de TAG <ans:coberturaAssistencial> do XML do DIOPS

oSectionC := TRSection():New(oReport,"COBERTURA ASSISTENCIAL",{""})
	
TRCell():New(oSectionC,"",/*Tabela*/,"Tipo"				 ,							 ,010,/*lPixel*/	,{|| _TIPO},,,,,,.F.)
TRCell():New(oSectionC,"",/*Tabela*/,"Cobertura"		 ,							 ,010,/*lPixel*/	,{|| _COBERTURA},,,,,,.F.)
TRCell():New(oSectionC,"",/*Tabela*/,"Plano"			 ,							 ,100,/*lPixel*/	,{|| _PLANO},,,,,,.F.)

oSectionD := TRSection():New(oReport,"COBERTURA ASSISTENCIAL",{""})

TRCell():New(oSectionD,"",/*Tabela*/,"DescriÁ„o"					 ,							 ,30,/*lPixel*/	,{|| _DESC},,,,,,.F.)
TRCell():New(oSectionD,"",/*Tabela*/,"Consulta MÈdica"	 ,"@e 999,999,999,999,999.99",,.F.			,{|| _MEDICAS},,,,,,.F.)
TRCell():New(oSectionD,"",/*Tabela*/,"Exames"    		 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| _EXAMES},,,,,,.F.)
TRCell():New(oSectionD,"",/*Tabela*/,"Terapias"			 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| _TERAPIAS},,,,,,.F.)
TRCell():New(oSectionD,"",/*Tabela*/,"InternaÁıes"		 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| _INTERNACOES},,,,,,.F.)
TRCell():New(oSectionD,"",/*Tabela*/,"Outros Atend."	 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| _OUTATENDIMENTOS},,,,,,.F.)
TRCell():New(oSectionD,"",/*Tabela*/,"Demais Desp." 	 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| _DEMDESP},,,,,,.F.)
TRCell():New(oSectionD,"",/*Tabela*/,"TOTAL"			 ,"@e 999,999,999,999,999.99",,/*lPixel*/	,{|| _COBERTTOTAL},,,,,,.F.)

// Inclus„o de TAG <ans:coberturaAssistencial> do XML do DIOPS
//Incluido por Rafael Fernandes  - FIM

//TRCell():New(oSection8,"",/*Tabela*/,"Deb Oper"    		 ,"@e 999,999,999,999,999.99",	 ,/*lPixel*/	,{|| Val(_DEBOPER)},,,,,,.T.)
//TRCell():New(oSection8,"",/*Tabela*/,"Dep Aquis Carre"   ,"@e 999,999,999,999,999.99",	 ,/*lPixel*/	,{|| Val(_DEPAQUISCARRE)},,,,,,.T.)
//TRCell():New(oSection8,"",/*Tabela*/,"Dep Benc Consegrec","@e 999,999,999,999,999.99",	 ,/*lPixel*/	,{|| Val(_DEPBENCONSEGREC)},,,,,,.T.)
//TRCell():New(oSection8,"",/*Tabela*/,"Eventos"       	 ,"@e 999,999,999,999,999.99",	 ,/*lPixel*/	,{|| Val(_EVENTOS)},,,,,,.T.)
//TRCell():New(oSection8,"",/*Tabela*/,"Outros Deb Oper" 	 ,"@e 999,999,999,999,999.99",	 ,/*lPixel*/	,{|| Val(_OUTROSDEBOPER)},,,,,,.T.)
//TRCell():New(oSection8,"",/*Tabela*/,"Outros Deb Pagar"  ,"@e 999,999,999,999,999.99",	 ,/*lPixel*/	,{|| Val(_OUTROSDEBPAGAR)},,,,,,.T.)
//TRCell():New(oSection8,"",/*Tabela*/,"Prest Ser Vas"	 ,"@e 999,999,999,999,999.99",	 ,/*lPixel*/	,{|| Val(_PRESTSERVAS)},,,,,,.T.)
//TRCell():New(oSection8,"",/*Tabela*/,"Dias"          	 ,"@e 9999"                  ,	 ,/*lPixel*/	,{|| _DIAS},,,,,,.T.)

 
Return oReport

*-------------------------------------------------------------------
Static Function Report(oReport)
*-------------------------------------------------------------------
Local oSection1 := oReport:Section(1) // Operadora
Local oSection2 := oReport:Section(2) // Ativo Vinculado    
Local oSection3 := oReport:Section(3) // Fluxo de Caixa     
Local oSection4 := oReport:Section(4) // Lucro ou Prejuizo  
Local oSection5 := oReport:Section(5) // InformaÁıes Complementares
Local oSection6 := oReport:Section(6) // Balancete 		 
Local oSection7 := oReport:Section(7) // Idade Saldo Ativo
Local oSection8 := oReport:Section(8) // Idade Saldo Passivo
Local oSection9 := oReport:Section(9) // Intercambio
Local oSectionA := oReport:Section(10) // Corresponsabilidade
Local oSectionB := oReport:Section(11) // Seguros Proventos Sinistros - Assumidos e Transferidos
Local oSectionC := oReport:Section(12) // Cobertura Assistencial
Local oSectionD := oReport:Section(13) // Cobertura Assistencial - valores

Local a 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nT 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nT2 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local x		:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private _Ans     		:= ""
Private _CNPJ    		:= ""
Private _RSocial 		:= ""
Private _Periodo 		:= ""
Private _Transac 		:= ""

Private _Codigo  		:= ""   
Private _Custodia 		:= ""
Private _DataEmissao  	:= "" 
Private _DataVencimento	:= ""
Private _Quantidade		:= ""
Private _TipoBem   		:= ""
Private _TipoOutros		:= ""
Private _Precounitario	:= ""
Private _ValorContabil	:= ""

Private _Conta3        	:= "" 
Private _Valor3        	:= "" 
Private _Valor31		:= ""
Private _Valor32		:= ""
Private _Valor33		:= ""

Private _Conta4        	:= "" 
Private _Valor4        	:= "" 
Private _Valor4t        := ""

Private _Conta5        	:= "" 
Private _Valor5        	:= "" 
// Private _CNPJ          	:= "" 
Private _Nome           := ""
Private _Valor51       	:= "" 

Private _Conta   		:= ""   
Private _Descricao		:= ""
Private _SaldoAnterior	:= "" 
Private _Debitos 		:= "" 
Private _Creditos	 	:= "" 
Private _SaldoFinal		:= "" 
                             
Private _COLETIVOPOS	:= ""
Private _COLETIVOPRE	:= ""
Private _CONVRECEBER	:= ""
Private _CREDOPER		:= ""
Private _INDIVIDUALPOS	:= ""
Private _INDIVIDUALPRE	:= ""
Private _OUTROSCREDCOMPLANO:= ""
Private _PARTBENEFES	:= ""
Private _TAXAADM		:= ""
Private _DIAS			:= ""
                              
Private _COMERCIAL		:= ""
Private _DEBOPER		:= ""
Private _DEPAQUISCARRE	:= ""
Private _DEPBENCONSEGREC:= ""
Private _EVENTOS		:= ""
Private _OUTROSDEBOPER	:= ""
Private _OUTROSDEBPAGAR	:= ""
Private _PRESTSERVAS	:= ""
// Private _DIAS			:= ""

Private	_REGISTROOPERADORA := ""
Private	_SALDOINTERCAMBIO  := ""

Private _REGISTROOPERADORA_ASSUMIDA 	:= 	""
Private _LANCCORRESPONSABILIDADEASSUMIDA:= 	""
Private	_REGISTROOPERADORA_TRANSFERIDA	:=	""
Private	_SALDOINTERCAMBIO_TRANSFERIDA 	:=	""

Private	_EVENTOSINISTROSATE := ""
Private	_EVENTOSINISTROSPOS := ""

Private cMascara:= Alltrim(GetMv("MV_MASCARA")) 
Private nMascara:= 0

Private cStartPath  := GetSrvProfString("StartPath","")

For a:= 1 to Len(cMascara) 
	nMascara += Val(SubStr(cMascara,a,1))
Next

_oxml := xmlParserFile(MV_PAR01, "_", @_cerror, @_cwarning)

_Ans     := IIF(TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_REGISTROANS:TEXT")<>"U", _oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_REGISTROANS:TEXT, "")
_CNPJ    := IIF(TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_CNPJ:TEXT")<>"U"		, _oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_CNPJ:TEXT, "")
_RSocial := IIF(TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_RAZAOSOCIAL:TEXT")<>"U", _oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_RAZAOSOCIAL:TEXT, "")
_Periodo := IIF(TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_PERIODO:TEXT")<>"U"	, _oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_PERIODO:TEXT, "")
_Transac := IIF(TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_TRANSACAO:TEXT")<>"U"	, _oxml:_ANS_DIOPSFINANC:_ANS_IDENTIFICADOR:_ANS_TRANSACAO:TEXT, "")

oReport:SetMeter(500)

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("OPERADORA",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSection1:Init()
oSection1:PrintLine()
oSection1:Finish()

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("ATIVO VINCULADO (INVESTIMENTO)",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSection2:Init()

DbSelectArea("SX5")
DbSetOrder(1)
If TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC)                            
	   	If TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST") = "A" 
			For nT2 := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST)                            		
		        _Codigo 		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST[nT2]:_ANS_CODIGO:TEXT
		        _Custodia		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST[nT2]:_ANS_Custodia:TEXT
		        _DataEmissao	:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST[nT2]:_ANS_DataEmissao:TEXT
		        _DataVencimento	:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST[nT2]:_ANS_DataVencimento:TEXT
		        _Quantidade		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST[nT2]:_ANS_Quantidade:TEXT
		        _TipoBem		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST[nT2]:_ANS_TipoBem:TEXT
		        _TipoOutros		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST[nT2]:_ANS_TipoOutros:TEXT
		        _Precounitario 	:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_PRECOUNITARIO[nT2]:TEXT  
		        _ValorContabil 	:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_VALORCONTABIL[nT2]:TEXT  
		        DbSeek(xFilial("SX5")+"GF"+Alltrim(_TipoBem))
		        _TipoBem := _TipoBem +" "+ SX5->X5_DESCRI
				oSection2:PrintLine()
				oReport:IncMeter()
		    Next                  
		Else
		    If	TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[1]:_ANS_ATIVOINVEST:_ANS_CODIGO:TEXT") = "C"       
		        _Codigo 		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST:_ANS_CODIGO:TEXT
		        _Custodia		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST:_ANS_Custodia:TEXT
		        _DataEmissao	:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST:_ANS_DataEmissao:TEXT
		        _DataVencimento	:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST:_ANS_DataVencimento:TEXT
		        _Quantidade		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST:_ANS_Quantidade:TEXT
		        _TipoBem		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST:_ANS_TipoBem:TEXT
		        _TipoOutros		:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_ATIVOINVEST:_ANS_TipoOutros:TEXT
		        _Precounitario 	:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_PRECOUNITARIO:TEXT  
		        _ValorContabil 	:= _oxml:_ANS_DIOPSFINANC:_ANS_ATIVOVINCULADO:_ANS_ATIVOVINC[nT]:_ANS_VALORCONTABIL:TEXT  
		        DbSeek(xFilial("SX5")+"GF"+Alltrim(_TipoBem))
		        _TipoBem := _TipoBem +" "+ SX5->X5_DESCRI
				oSection2:PrintLine()
				oReport:IncMeter()
		    EndIf
		EndIf
	Next nT   
EndIf
oSection2:Finish()

oReport:EndPage()

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("FLUXO DE CAIXA",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSection3:Init()

//Aadd(aFluxo,{"0101","ATIVIDADES OPERACIONAIS",0})
//Aadd(aFluxo,{"0201","ATIVIDADES DE INVESTIMENTO",0})
//Aadd(aFluxo,{"0301","ATIVIDADES DE FINANCIAMENTO",0})
//Aadd(aFluxo,{"0499","CAIXA LIQUIDO",0})
If TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_FLUXOCAIXA:_ANS_LANCFLUXOCAIXA") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_FLUXOCAIXA:_ANS_LANCFLUXOCAIXA)
		_Conta3 := _oxml:_ANS_DIOPSFINANC:_ANS_FLUXOCAIXA:_ANS_LANCFLUXOCAIXA[nT]:_ANS_CONTA:TEXT
		_Valor3 := _oxml:_ANS_DIOPSFINANC:_ANS_FLUXOCAIXA:_ANS_LANCFLUXOCAIXA[nT]:_ANS_VALOR:TEXT
		oSection3:PrintLine()
		oReport:IncMeter()
/*		cSeq := SubStr(_Conta3,1,2)
		cDes := SubStr(_Conta3,3,100)
		Aadd(aFluxo,{cSeq+Str(nT,2),cDes,_Valor3})
		If cSeq == "01"
			_Valor31 += Val(_Valor3)
		ElseIf cSeq == "02"
			_Valor32 += Val(_Valor3)
		ElseIf cSeq == "03"
			_Valor33 += Val(_Valor3)
		EndIf */
	Next nT
EndIf

/*
nPos :=	Ascan(aFluxo,{ |x| x[1] = "0101"} )
aFluxo[nPos][3] := _Valor31
nPos :=	Ascan(aFluxo,{ |x| x[1] = "0201"} )
aFluxo[nPos][3] := _Valor32
nPos :=	Ascan(aFluxo,{ |x| x[1] = "0301"} )
aFluxo[nPos][3] := _Valor33
nPos :=	Ascan(aFluxo,{ |x| x[1] = "0499"} )
aFluxo[nPos][3] := _Valor33-(_Valor31+_Valor32)

aSort(aFluxo,,,{|x,y| x[1]<y[1]})

For a:=1 to Len(aFluxo)
	_Conta3	 	:= aFluxo[a,2]
	_Valor3		:= aFluxo[a,3]
	oSection3:PrintLine()
	oReport:IncMeter()
Next  
*/
oSection3:Finish()

oReport:EndPage()
        
oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("LUCRO OU PREJUÕZO",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSection4:Init()

If TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_LUCROSPREJUIZOS:_ANS_LUCROPREJUIZO") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_LUCROSPREJUIZOS:_ANS_LUCROPREJUIZO)
		_Conta4 := _oxml:_ANS_DIOPSFINANC:_ANS_LUCROSPREJUIZOS:_ANS_LUCROPREJUIZO[nT]:_ANS_CONTA:TEXT
		_Valor4 := _oxml:_ANS_DIOPSFINANC:_ANS_LUCROSPREJUIZOS:_ANS_LUCROPREJUIZO[nT]:_ANS_VALOR:TEXT
		_Valor4t:= _Valor4t + _Valor4
		oSection4:PrintLine()
		oReport:IncMeter()
	Next nT
EndIf  

_Conta4 := "TOTAL"
_Valor4 := _Valor4t
oSection4:PrintLine()

oSection4:Finish()

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("INFORMACOES COMPLEMENTARES PARA MARGEM DE SOLV NCIA",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine(2)
oReport:PrintText("PatrimÙnio a ser comparado com a margem de solvÍncia",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSection5:Init()

If TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_INFORMACOESSOLVENCIA:_ANS_INFORMACOESSOLVENCIAOPER:_ANS_LANCINFORMACOESSOLVENCIAOPER") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_INFORMACOESSOLVENCIA:_ANS_INFORMACOESSOLVENCIAOPER:_ANS_LANCINFORMACOESSOLVENCIAOPER)
		cInf := Alltrim(_oxml:_ANS_DIOPSFINANC:_ANS_INFORMACOESSOLVENCIA:_ANS_INFORMACOESSOLVENCIAOPER:_ANS_LANCINFORMACOESSOLVENCIAOPER[nT]:_ANS_CONTA:TEXT)
        If cInf == "LNR_OPER"
			_Conta5	:= "Lucros n„o realizados da carteira de aÁıes"
        ElseIf cInf == "RAN_OPER"
			_Conta5	:= "Receitas antecipadas"
        ElseIf cInf == "AEE_OPER"
			_Conta5	:= "Ajustes por efeitos econÙmicos (art. 28, I, da RN 160/2007)"
        ElseIf cInf == "CPL_PRE_OPER"
			_Conta5	:= "ContraprestaÁıes LÌquidas: PreÁo PrÈ-Estabelecido = soma dos ˙ltimos 12 meses"
        ElseIf cInf == "CPL_POS_OPER"
			_Conta5	:= "ContraprestaÁıes LÌquidas: PreÁo PÛs-Estabelecido = soma dos ˙ltimos 12 meses"
        ElseIf cInf == "EIL_PRE_OPER"
			_Conta5	:= "Eventos Indeniz·veis LÌquidos: PreÁo PrÈ-Estabelecido = soma dos ˙ltimos 36 meses"
        ElseIf cInf == "EIL_POS_OPER"
			_Conta5	:= "Eventos Indeniz·veis LÌquidos: PreÁo PÛs-Estabelecido = soma dos ˙ltimos 36 meses"
        EndIf
		_Valor5 := _oxml:_ANS_DIOPSFINANC:_ANS_INFORMACOESSOLVENCIA:_ANS_INFORMACOESSOLVENCIAOPER:_ANS_LANCINFORMACOESSOLVENCIAOPER[nT]:_ANS_VALOR:TEXT
		oSection5:PrintLine()
		oReport:IncMeter()
	Next nT
EndIf

_CNPJ	:= _oxml:_ANS_DIOPSFINANC:_ANS_INFORMACOESSOLVENCIA:_ANS_INFORMACOESSOLVENCIAOPER:_ANS_PARTICIPACAOCONGENERE:_ANS_CNPJ:TEXT
If File(cStartPath+"SIGAMAT.EMP")
	DbUseArea(.T.,,cStartPath+"SIGAMAT.EMP","EMP",.T.,.F.)
	cArqEMP  := CriaTrab(NIL,.F.)
	IndRegua("EMP",cArqEMP,"M0_CGC",,,)
	DbSelectArea("EMP")
	DbSeek(_CNPJ)
	_Nome := EMP->M0_NOMECOM
	EMP->(DbCloseArea())
Endif
_Valor51:= _oxml:_ANS_DIOPSFINANC:_ANS_INFORMACOESSOLVENCIA:_ANS_INFORMACOESSOLVENCIAOPER:_ANS_PARTICIPACAOCONGENERE:_ANS_VALOR:TEXT
_Valor51:= Transform(Val(_Valor51),"@e 999,999,999,999,999.99")

oReport:SkipLine()
oReport:PrintText("PARTICIPACOES DIRETAS OU INDIRETAS EM OUTRAS OPS, ATUALIZADAS PELA EQUIVAL NCIA PATRIMONIAL",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oReport:PrintText("CNPJ: "+_CNPJ,oReport:Row()+10,0,,,,.T.)
oReport:SkipLine()
oReport:PrintText("Nome: "+_Nome,oReport:Row()+20,0,,,,.T.)
oReport:SkipLine()
oReport:PrintText("Valor: "+_Valor51,oReport:Row()+30,0,,,,.T.)

oSection5:Finish()

oReport:EndPage()

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("BALANCETE",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSection6:Init()

DbSelectArea("CT1")
DbSetOrder(1)

aLinha := {}
If TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_ATIVO:_ANS_LANCAMENTO") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_ATIVO:_ANS_LANCAMENTO)                            
	    DbSeek(xFilial("CT1")+_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_ATIVO:_ANS_LANCAMENTO[nT]:_ANS_CONTA:TEXT)
		_Conta	 		:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_ATIVO:_ANS_LANCAMENTO[nT]:_ANS_CONTA:TEXT
		_Descricao		:= CT1->CT1_DESC01
		_SaldoAnterior	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_ATIVO:_ANS_LANCAMENTO[nT]:_ANS_SALDOANTERIOR:TEXT
		_Debitos	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_ATIVO:_ANS_LANCAMENTO[nT]:_ANS_DEBITOS:TEXT
		_Creditos	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_ATIVO:_ANS_LANCAMENTO[nT]:_ANS_CREDITOS:TEXT
		_SaldoFinal	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_ATIVO:_ANS_LANCAMENTO[nT]:_ANS_SALDOFINAL:TEXT
		_Conta := GrvPict(_Conta)
		Aadd(aLinha,{_Conta,_Descricao,_SaldoAnterior,_Debitos,_Creditos,_SaldoFinal})
	Next nT   
EndIf

If TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_PASSIVO:_ANS_LANCAMENTO") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_PASSIVO:_ANS_LANCAMENTO)
	    DbSeek(xFilial("CT1")+_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_PASSIVO:_ANS_LANCAMENTO[nT]:_ANS_CONTA:TEXT)
		_Conta	 		:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_PASSIVO:_ANS_LANCAMENTO[nT]:_ANS_CONTA:TEXT
		_Descricao		:= CT1->CT1_DESC01
		_SaldoAnterior	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_PASSIVO:_ANS_LANCAMENTO[nT]:_ANS_SALDOANTERIOR:TEXT
		_Debitos	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_PASSIVO:_ANS_LANCAMENTO[nT]:_ANS_DEBITOS:TEXT
		_Creditos	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_PASSIVO:_ANS_LANCAMENTO[nT]:_ANS_CREDITOS:TEXT
		_SaldoFinal	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_PASSIVO:_ANS_LANCAMENTO[nT]:_ANS_SALDOFINAL:TEXT
		_Conta := GrvPict(_Conta)
		Aadd(aLinha,{_Conta,_Descricao,_SaldoAnterior,_Debitos,_Creditos,_SaldoFinal})
	Next nT
EndIf

If TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_RECEITA:_ANS_LANCAMENTO") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_RECEITA:_ANS_LANCAMENTO)
	    DbSeek(xFilial("CT1")+_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_RECEITA:_ANS_LANCAMENTO[nT]:_ANS_CONTA:TEXT)
		_Conta	 		:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_RECEITA:_ANS_LANCAMENTO[nT]:_ANS_CONTA:TEXT
		_Descricao		:= CT1->CT1_DESC01
		_SaldoAnterior	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_RECEITA:_ANS_LANCAMENTO[nT]:_ANS_SALDOANTERIOR:TEXT
		_Debitos	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_RECEITA:_ANS_LANCAMENTO[nT]:_ANS_DEBITOS:TEXT
		_Creditos	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_RECEITA:_ANS_LANCAMENTO[nT]:_ANS_CREDITOS:TEXT
		_SaldoFinal	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_RECEITA:_ANS_LANCAMENTO[nT]:_ANS_SALDOFINAL:TEXT
		_Conta := GrvPict(_Conta)
		Aadd(aLinha,{_Conta,_Descricao,_SaldoAnterior,_Debitos,_Creditos,_SaldoFinal})
	Next nT
EndIf

If TYPE("_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_DESPESA:_ANS_LANCAMENTO") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_DESPESA:_ANS_LANCAMENTO)
	    DbSeek(xFilial("CT1")+_oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_DESPESA:_ANS_LANCAMENTO[nT]:_ANS_CONTA:TEXT)
		_Conta	 		:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_DESPESA:_ANS_LANCAMENTO[nT]:_ANS_CONTA:TEXT
		_Descricao		:= CT1->CT1_DESC01
		_SaldoAnterior	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_DESPESA:_ANS_LANCAMENTO[nT]:_ANS_SALDOANTERIOR:TEXT
		_Debitos	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_DESPESA:_ANS_LANCAMENTO[nT]:_ANS_DEBITOS:TEXT
		_Creditos	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_DESPESA:_ANS_LANCAMENTO[nT]:_ANS_CREDITOS:TEXT
		_SaldoFinal	 	:= _oxml:_ANS_DIOPSFINANC:_ANS_BALANCETE:_ANS_DESPESA:_ANS_LANCAMENTO[nT]:_ANS_SALDOFINAL:TEXT
		_Conta := GrvPict(_Conta)
		Aadd(aLinha,{_Conta,_Descricao,_SaldoAnterior,_Debitos,_Creditos,_SaldoFinal})
	Next nT
EndIf

aSort(aLinha,,,{|x,y| x[1]<y[1]})

For a:=1 to Len(aLinha)
	_Conta	 		:= aLinha[a,1]
	_Descricao		:= aLinha[a,2]
	_SaldoAnterior	:= aLinha[a,3]
	_Debitos	 	:= aLinha[a,4]
	_Creditos	 	:= aLinha[a,5]
	_SaldoFinal	 	:= aLinha[a,6]
	oSection6:PrintLine()
/*
	oSection6:Say ( oReport:Row(),  01 , _Conta , oFont , , , ) 
	oSection6:Say ( oReport:Row(),  25 , _Descricao , oFont , , , ) 
	oSection6:Say ( oReport:Row(),  80 , _SaldoAnterior , oFont , , , ) 
	oSection6:Say ( oReport:Row(), 110 , _Debitos , oFont , , , ) 
	oSection6:Say ( oReport:Row(), 140 , _Creditos , oFont , , , ) 
	oSection6:Say ( oReport:Row(), 170 , _SaldoFinal , oFont , , , ) 
*/	oReport:IncMeter()
Next  
//oSection6:SetPageBreak(.T.)
oSection6:Finish()

oReport:EndPage()

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("IDADE SALDO ATIVO",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSection7:Init()

If Type("_oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO)
		_COLETIVOPOS		:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_ATIVO:_ANS_COLETIVOPOS:TEXT
		_COLETIVOPRE		:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_ATIVO:_ANS_COLETIVOPRE:TEXT
		_CONVRECEBER		:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_ATIVO:_ANS_CONVRECEBER:TEXT
		_CREDOPER			:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_ATIVO:_ANS_CREDOPER:TEXT
		_INDIVIDUALPOS		:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_ATIVO:_ANS_INDIVIDUALPOS:TEXT
		_INDIVIDUALPRE		:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_ATIVO:_ANS_INDIVIDUALPRE:TEXT
		_OUTROSCREDCOMPLANO := _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_ATIVO:_ANS_OUTROSCREDCOMPLANO:TEXT
		_PARTBENEFES		:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_ATIVO:_ANS_PARTBENEFES:TEXT
		_TAXAADM			:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_ATIVO:_ANS_TAXAADM:TEXT
		_DIAS				:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEATIVO[nT]:_ANS_DIAS:TEXT
		oSection7:PrintLine()
		oReport:IncMeter()
	Next nT
EndIf      

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("IDADE SALDO PASSIVO",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSection8:Init()

If Type("_oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO") = "A"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO)
		_COMERCIAL		:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO[nT]:_ANS_PASSIVO:_ANS_COMERCIAL:TEXT
		_DEBOPER		:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO[nT]:_ANS_PASSIVO:_ANS_DEBOPER:TEXT
		_DEPAQUISCARRE	:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO[nT]:_ANS_PASSIVO:_ANS_DEPAQUISCARRE:TEXT
		_DEPBENCONSEGREC:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO[nT]:_ANS_PASSIVO:_ANS_DEPBENCONSEGREC:TEXT
		_EVENTOS		:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO[nT]:_ANS_PASSIVO:_ANS_EVENTOS:TEXT
		_OUTROSDEBOPER	:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO[nT]:_ANS_PASSIVO:_ANS_OUTROSDEBOPER:TEXT
		_OUTROSDEBPAGAR	:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO[nT]:_ANS_PASSIVO:_ANS_OUTROSDEBPAGAR:TEXT
		_PRESTSERVAS	:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO[nT]:_ANS_PASSIVO:_ANS_PRESTSERVAS:TEXT
		_DIAS			:= _oxml:_ANS_DIOPSFINANC:_ANS_IDADESALDO:_ANS_IDADEPASSIVO[nT]:_ANS_DIAS:TEXT
		oSection8:PrintLine()
		oReport:IncMeter()
	Next nT
EndIf      

oSection8:Finish()

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("INTERCAMBIO",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSection9:Init()

If Type("_oxml:_ANS_DIOPSFINANC:_ANS_INTERCAMBIO:_ANS_INTERCAMBIOAPAGAR") <> "U"
	_REGISTROOPERADORA := _oxml:_ANS_DIOPSFINANC:_ANS_INTERCAMBIO:_ANS_INTERCAMBIOAPAGAR:_ANS_LANCINTERCAMBIOPAGAR:_ANS_REGISTROOPERADORA:TEXT	
	_SALDOINTERCAMBIO  := _oxml:_ANS_DIOPSFINANC:_ANS_INTERCAMBIO:_ANS_INTERCAMBIOAPAGAR:_ANS_LANCINTERCAMBIOPAGAR:_ANS_SALDOINTERCAMBIO:TEXT
	oSection9:PrintLine()
	oReport:IncMeter()
Endif

oSection9:Finish()

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("CORRESPONSABILIDADE ASSUMIDA E TRANSFERIDA",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSectionA:Init()

If Type("_oxml:_ANS_DIOPSFINANC:_ANS_CORRESPONSABILIDADE:_ANS_CORRESPONSABILIDADEASSUMIDA:_ANS_LANCCORRESPONSABILIDADEASSUMIDA") <> "U"
	_REGISTROOPERADORA_ASSUMIDA 	:= 	_oxml:_ANS_DIOPSFINANC:_ANS_CORRESPONSABILIDADE:_ANS_CORRESPONSABILIDADEASSUMIDA:_ANS_LANCCORRESPONSABILIDADEASSUMIDA:_ANS_REGISTROOPERADORA:TEXT
	_LANCCORRESPONSABILIDADEASSUMIDA:= 	_oxml:_ANS_DIOPSFINANC:_ANS_CORRESPONSABILIDADE:_ANS_CORRESPONSABILIDADEASSUMIDA:_ANS_LANCCORRESPONSABILIDADEASSUMIDA:TEXT
	_REGISTROOPERADORA_TRANSFERIDA	:=	_oxml:_ANS_DIOPSFINANC:_ANS_CORRESPONSABILIDADE:_ANS_CORRESPONSABILIDADETRANSFERIDA:_ANS_LANCCORRESPONSABILIDADETRANSFERIDA:_ANS_REGISTROOPERADORA:TEXT
	_SALDOINTERCAMBIO_TRANSFERIDA 	:=	_oxml:_ANS_DIOPSFINANC:_ANS_CORRESPONSABILIDADE:_ANS_CORRESPONSABILIDADETRANSFERIDA:_ANS_LANCCORRESPONSABILIDADETRANSFERIDA:_ANS_SALDOINTERCAMBIO:TEXT
	oSectionA:PrintLine()
	oReport:IncMeter()
Endif

oSectionB:Finish()

oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("SEGURO PROVENTOS SINISTROS",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSectionB:Init()

If Type("_oxml:_ANS_DIOPSFINANC:_ANS_SEGPROVEVENTOSSINISTROSLIQ:_ANS_PROVEVENTOSSINISTROSLIQ30") <> "U"
	_EVENTOSINISTROSATE		:= _oxml:_ANS_DIOPSFINANC:_ANS_SEGPROVEVENTOSSINISTROSLIQ:_ANS_PROVEVENTOSSINISTROSLIQ30:_ANS_EVENTOSINISTROSATE:TEXT
	_EVENTOSINISTROSPOS 	:= _oxml:_ANS_DIOPSFINANC:_ANS_SEGPROVEVENTOSSINISTROSLIQ:_ANS_PROVEVENTOSSINISTROSLIQ30:_ANS_EVENTOSINISTROSPOS:TEXT
	oSectionB:PrintLine()
	oReport:IncMeter()
Endif       

//IncluÌdo por Rafael Fernandes - INICIO
// Inclus„o de TAG <ans:coberturaAssistencial> do XML do DIOPS

oSectionB:Finish()
 
oReport:FatLine()
oReport:SkipLine()
oReport:PrintText("COBERTURA ASSISTENCIAL",oReport:Row()+1,0,,,,.T.)
oReport:SkipLine()
oSectionC:Init()   

If Type("_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL") <> "U"
	For nT := 1 to Len(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL)
		oSectionC:Init() 
		_TIPO		:= _oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_TIPO:TEXT
		_COBERTURA	:= _oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_COBERTURA:TEXT
		_PLANO		:= _oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_PLANO:TEXT
	    
	    cLei := ""
		Do Case 
			Case Alltrim(_PLANO)=="IFAL"
				_PLANO += " - Carteira de Planos Individuais/Familiares antes da Lei"
			Case Alltrim(_PLANO)=="IFPL"
				_PLANO += " - Carteira de Planos Individuais/Familiares pÛs Lei"
			Case Alltrim(_PLANO)=="PLAL"
				_PLANO += " - Planos Coletivos por Ades„o antes da Lei"
			Case Alltrim(_PLANO)=="PLAP"
				_PLANO += " - Planos Coletivos por Ades„o PÛs Lei"
			Case Alltrim(_PLANO)=="PCEA"
				_PLANO += " - Planos Coletivos Empresariais antes da Lei"
			Case Alltrim(_PLANO)=="PCEL"
				_PLANO += " - Planos Coletivos Empresariais pÛs Lei"
		End Case

	
		oSectionC:PrintLine()
		oReport:IncMeter()  
		oSectionC:Finish()
		If Type("_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORCONSULTARP") <> "U"
			oSectionD:Init()
			nTotConsul:=nTotExames:=nTotTerapi:=nTotIntern:=nTotOutAte:=nTotDemDes:=nTot:=nTotGeral:=0 //Totais
			For x:=1 to 5
				cDesc := ""
				nConsul:=nExames:=nTerapi:=nIntern:=nOutAte:=nDemDes:=0 //Valores
				
				If x==1
					cDesc  := "Rede PrÛpria"
					nConsul:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORCONSULTARP:TEXT)
					nExames:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALOREXAMERP:TEXT)
					nTerapi:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORTERAPIARP:TEXT)
					nIntern:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORINTERNRP:TEXT)
					nOutAte:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORATENDIMENTORP:TEXT)
					nDemDes:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORDESPESASRP:TEXT)
				    nTot   := nConsul+nExames+nTerapi+nIntern+nOutAte+nDemDes
			    	nTotConsul+=nConsul
			    	nTotExames+=nExames
			    	nTotTerapi+=nTerapi
			    	nTotIntern+=nIntern
			    	nTotOutAte+=nOutAte
			    	nTotDemDes+=nDemDes
			    	nTotGeral +=nTot
				ElseIf x==2
					cDesc  := "Rede Contratada"
					nConsul:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORCONSULTARC:TEXT)
					nExames:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALOREXAMERC:TEXT)
					nTerapi:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORTERAPIARC:TEXT)
					nIntern:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORINTERNRC:TEXT)
					nOutAte:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORATENDIMENTORC:TEXT)
					nDemDes:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORDESPESASRC:TEXT)
				    nTot   := nConsul+nExames+nTerapi+nIntern+nOutAte+nDemDes
			    	nTotConsul+=nConsul
			    	nTotExames+=nExames
			    	nTotTerapi+=nTerapi
			    	nTotIntern+=nIntern
			    	nTotOutAte+=nOutAte
			    	nTotDemDes+=nDemDes
			    	nTotGeral +=nTot
				ElseIf x==3
					cDesc  := "Reembolso"
			   		nConsul:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORCONSULTARE:TEXT)
					nExames:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALOREXAMERE:TEXT)
					nTerapi:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORTERAPIARE:TEXT)
					nIntern:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORINTERNRE:TEXT)
					nOutAte:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORATENDIMENTORE:TEXT)
					nDemDes:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORDESPESASRE:TEXT)
				    nTot   := nConsul+nExames+nTerapi+nIntern+nOutAte+nDemDes
				    nTotConsul+=nConsul
			    	nTotExames+=nExames
			    	nTotTerapi+=nTerapi
			    	nTotIntern+=nIntern
			    	nTotOutAte+=nOutAte
			    	nTotDemDes+=nDemDes
			    	nTotGeral +=nTot
				ElseIf x==4
					cDesc  := "Interc‚mbio Eventual"
					nConsul:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORCONSULTAIE:TEXT)
					nExames:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALOREXAMEIE:TEXT)
					nTerapi:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORTERAPIAIE:TEXT)
					nIntern:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORINTERNIE:TEXT)
					nOutAte:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORATENDIMENTOIE:TEXT)
					nDemDes:=Val(_oxml:_ANS_DIOPSFINANC:_ANS_COBERTURAASSISTENCIAL:_ANS_LANCCOBERTURAASSISTENCIAL[nt]:_ANS_VALORDESPESASIE:TEXT)
				    nTot   := nConsul+nExames+nTerapi+nIntern+nOutAte+nDemDes
				    nTotConsul+=nConsul
			    	nTotExames+=nExames
			    	nTotTerapi+=nTerapi
			    	nTotIntern+=nIntern
			    	nTotOutAte+=nOutAte
			    	nTotDemDes+=nDemDes
			    	nTotGeral +=nTot
				ElseIf x==5
					cDesc  := "TOTAL"
					nConsul:=nTotConsul
					nExames:=nTotExames
					nTerapi:=nTotTerapi
					nIntern:=nTotIntern
					nOutAte:=nTotOutAte
					nDemDes:=nTotDemDes
				    nTot   := nConsul+nExames+nTerapi+nIntern+nOutAte+nDemDes
				EndIf
				
				_DESC				:= cDesc
				_MEDICAS            := nConsul
				_EXAMES             := nExames
				_TERAPIAS           := nTerapi
				_INTERNACOES        := nIntern
				_OUTATENDIMENTOS    := nOutAte
				_DEMDESP            := nDemDes
				_COBERTTOTAL        := nTot
				
				oSectionD:PrintLine()
				
			Next
		Endif
		
	Next nT 
	oSectionD:Finish()
Endif
// Inclus„o de TAG <ans:coberturaAssistencial> do XML do DIOPS
// IncluÌdo por Rafael Fernandes - FIM

Return

*******************************
Static Function GrvPict(cConta)
*******************************

Local __cConta  := ""
Local _b		:= 0

Local a := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

If Len(cConta) <= nMascara 
	For a:= 1 to Len(cConta) 
		_b := _b + 1
	 	__cConta := __cConta + SubStr(cConta,a,Val(SubStr(cMascara,_b,1)))+"."    
	 	a := a + Val(SubStr(cMascara,_b,1)) - 1 
	Next                                                                                                                                                                                                                                                                                                                  	
Else
	Aviso("Alerta", "Existe divergÍncia entre o n˙mero de caracteres da conta importada "+cConta+", no caso "+Alltrim(Str(Len(cConta)))+" digitos e M·scara da Conta "+cMascara+" que È de "+Alltrim(Str(nMascara))+" posiÁıes. Ainda assim, a conta ser· importada, porÈm, sem mascara na impress„o. Favor analisar possÌvel ajuste da M·scara no par‚metro (MV_MASCARA)." ,{"Continuar"})
EndIf

__cConta := If(Len(cConta)>1 .and. Len(cConta) <= nMascara,SubStr(__cConta,1,Len(__cConta)-1),cConta)

Return(__cConta)
