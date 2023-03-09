#include "PROTHEUS.CH"
#include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR059  ³ Autor ³ Renato Peixoto       ³ Data ³ 19/04/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de valor de mensalidade cobrado versus valor     |±±
±±³          ³ que consta na faixa do plano, p/ verificar inconsistencias.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR059           

Local   oReport 
Private cPerg	:= "CABR059" 
Private cCompet := ""  
Private aRel    := {}
Private aDuplic := {} //Vetor que vai armazenar os usuarios ou familias com duplicidade de registros para a mesma faixa

oReport:= ReportDef()
oReport:PrintDialog()

Return

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Renato Peixoto                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef()

Local oReport 
Local oUsr     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport	:= TReport():New("CABR053","Inconsistencias Valor Cobrado X Valor Parametrizado","CABR059", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de valor de mensalidade cobrado VS valor faixa beneficiario")

*'-----------------------------------------------------------------------------------'*
*'SoluÃ§Ã£o para impressÃ£o em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //EspaÃ§amento entre colunas. 
oReport:SetLandscape() //ImpressÃ£o em paisagem.  
//oReport:SetPortrait() //ImpressÃ£o em retrato.  

*'-----------------------------------------------------------------------------------'*

oUsr := TRSection():New(oReport,"Inconsistencias Valores Cobrados Mensalidade")
oUsr:SetTotalInLine(.F.)   
 
nTamMatric 	:= TamSx3('BA1_CODINT')[1] + TamSx3('BA1_CODEMP')[1] + TamSx3('BA1_MATRIC')[1] + TamSx3('BA1_TIPREG')[1] + TamSx3('BA1_DIGITO')[1] + 4
cPicture 	:= '@E 999,999,999,999.99'

TRCell():New(oUsr ,'MATRIC'		,		,'Matricula'		 					,/*Picture*/	,nTamMatric		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BM1_CODEMP'	,'BM1'	,'Empresa'								,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'CONTRATO'	,		,'Contrato'     						,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'SUBCONTRATO',		,'Subcontrato'							,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'COD_PLANO'	,		,'Codigo Plano'	   						,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'IDADE_INICIAL',		,'Idade Inicial'   						,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'IDADE_FINAL'  ,		,'Idade Final'							,/*Picture*/	,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'IDADE_ATUAL'  ,		,'Idade Atual'							,/*Picture*/	,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'VALOR_COBRADO',		,'Valor Cobrado'						,cPicture   	,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'VALOR_TABELA' ,		,'Valor Tabela' 						,cPicture   	,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'NUM_COBR_BM1' ,		,'Num. Cobr. BM1'						,   	        ,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'VALOR_ANTERIOR_REAJ',,'Valor Anterior Reaj.'				,cPicture   	,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'DATA_REAJUSTE',		,'Data Reajuste'                       	,/*Picture*/	,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'ORIGEM',		    ,'Origem Valor (Cobrança/Faixa)'       	,/*Picture*/	,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

aAdd ( aRel,    {"MATRICULA","EMPRESA","CONTRATO","SUBCONTRATO","PLANO","IDADE INICIAL","IDADE FINAL","IDADE ATUAL","VALOR COBRADO","VALOR TABELA","NUM. COBRANÇA NA TABELA DE COBRANÇA (BM1)","VALOR ANTERIOR AO REAJUSTE","DATA DE REAJUSTE", "ORIGEM VALOR" } )
aAdd ( aDuplic, {"MATRICULA","EMPRESA","CONTRATO","SUBCONTRATO","PLANO","IDADE INICIAL","IDADE FINAL","IDADE ATUAL","VALOR COBRADO","VALOR TABELA","NUM. COBRANÇA NA TABELA DE COBRANÇA (BM1)","VALOR ANTERIOR AO REAJUSTE","DATA DE REAJUSTE", "ORIGEM VALOR" } )
//oUsr:SetTotalText("Total geral")

//TRFunction():New(oUsr:Cell("BA1_NOMUSR")  		,NIL,"COUNT"	,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)
//TRFunction():New(oUsr:Cell("VLR_ANTES")  		,NIL,"SUM"  	,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)
//TRFunction():New(oUsr:Cell("VLR_APOS")  		,NIL,"SUM" 		,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)

Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Renato Peixoto                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrint(oReport)

Local oBreak01                             
Local i             := 0

Private oUsr   		:= oReport:Section(1)
Private cAlias1 	:= GetNextAlias()
Private cQuery		:= ''
Private nCont 		:= 0
//Private aReajuste	:= {}
//Private aReajAnt	:= {} 	
Private SEMAFORO 	:= '' 
Private lContinua	:= .F.

Private aFaiUsu    := {}
Private aFaiFam    := {}
Private aVetGeral  := {}


If MV_PAR04 = 1
	Processa({||nCont := BscIncon()},"Grupo Caberj")
Else
	Processa({||nCont := BscIncoFai()},"Grupo Caberj")
EndIf


If MV_PAR04 = 1
	//Se nao tiver esta linha, nÃ£o imprime os dados
	oUsr:init()
	
	oReport:SetMeter(nCont) 
	
	//cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
	nCont 	:= 0       
	nCritic	:= 0

	While !( cAlias1->(Eof()) )
    
		If oReport:Cancel()  
	    
		    oReport:FatLine()     
		    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
		    exit
	    
		EndIf
                                                    
		oReport:SetMsgPrint("Analisando dados das mensalidades...")
		oReport:IncMeter()

		//nome das celulas
		//'MATRIC'	
		//'BM1_CODEMP'
		//'CONTRATO'
		//'SUBCONTRATO'
		//'COD_PLANO'
		//'IDADE_INICIAL'
		//'IDADE_FINAL'
		//'IDADE_ATUAL' 
		//'VALOR_COBRADO'
		//'VALOR_TABELA'
		//'NUM_COBR_BM1'
		//'VALOR_ANTERIOR_REAJ'
		//'DATA_REAJUSTE'
		If MV_PAR03 = 1 //mostra somente possiveis erros
			If cAlias1->(VALORCOBRADO) <> cAlias1->(VALORTABELA)
				If cAlias1->(VALORCOBRADO) <> cAlias1->(VALOR_ANTERIOR) //.AND. SUBSTR(cAlias1->(DATA_REAJUSTE),1,4) = cAno
					oUsr:Cell('MATRIC'		):SetValue(cAlias1->(BM1_MATUSU))
					oUsr:Cell('BM1_CODEMP'	):SetValue(cAlias1->(BM1_CODEMP))
					oUsr:Cell('CONTRATO'	):SetValue(cAlias1->(BM1_CONEMP))
					oUsr:Cell('SUBCONTRATO'	):SetValue(cAlias1->(BM1_SUBCON))
					oUsr:Cell('COD_PLANO'	):SetValue(cAlias1->(BM1_CODPLA))
					oUsr:Cell('IDADE_INICIAL'):SetValue(cAlias1->(BTN_IDAINI))
					oUsr:Cell('IDADE_FINAL'	):SetValue(cAlias1->(BTN_IDAFIN))
					oUsr:Cell('IDADE_ATUAL'	):SetValue(cAlias1->(BM1_CARGO))
					oUsr:Cell('VALOR_COBRADO'):SetValue(cAlias1->(VALORCOBRADO))
					oUsr:Cell('VALOR_TABELA'):SetValue(cAlias1->(VALORTABELA))
					oUsr:Cell('NUM_COBR_BM1'):SetValue(cAlias1->(NUM_COBR_BM1))
					oUsr:Cell('VALOR_ANTERIOR_REAJ'	):SetValue(cAlias1->(VALOR_ANTERIOR))
					oUsr:Cell('DATA_REAJUSTE'):SetValue(DTOC(STOD((cAlias1->(DATA_REAJUSTE)))))
					oUsr:Cell('ORIGEM'):SetValue("COBRANÇA")
				
					aAdd(aRel, {cAlias1->(BM1_MATUSU), cAlias1->(BM1_CODEMP), cAlias1->(BM1_CONEMP), cAlias1->(BM1_SUBCON), cAlias1->(BM1_CODPLA), cAlias1->(BTN_IDAINI),;
								cAlias1->(BTN_IDAFIN), cAlias1->(BM1_CARGO), cAlias1->(VALORCOBRADO),cAlias1->(VALORTABELA), cAlias1->(NUM_COBR_BM1), cAlias1->(VALOR_ANTERIOR), cAlias1->(DATA_REAJUSTE), "COBRANÇA" })
				
					oUsr:PrintLine()
				
				EndIf
		
			EndIf
	
		Else
		
			oUsr:Cell('MATRIC'		):SetValue(cAlias1->(BM1_MATUSU))
			oUsr:Cell('BM1_CODEMP'	):SetValue(cAlias1->(BM1_CODEMP))
			oUsr:Cell('CONTRATO'	):SetValue(cAlias1->(BM1_CONEMP))
			oUsr:Cell('SUBCONTRATO'	):SetValue(cAlias1->(BM1_SUBCON))
			oUsr:Cell('COD_PLANO'	):SetValue(cAlias1->(BM1_CODPLA))
			oUsr:Cell('IDADE_INICIAL'):SetValue(cAlias1->(BTN_IDAINI))
			oUsr:Cell('IDADE_FINAL'	):SetValue(cAlias1->(BTN_IDAFIN))
			oUsr:Cell('IDADE_ATUAL'	):SetValue(cAlias1->(BM1_CARGO))
			oUsr:Cell('VALOR_COBRADO'):SetValue(cAlias1->(VALORCOBRADO))
			oUsr:Cell('VALOR_TABELA'):SetValue(cAlias1->(VALORTABELA))
			oUsr:Cell('NUM_COBR_BM1'):SetValue(cAlias1->(NUM_COBR_BM1))
			oUsr:Cell('VALOR_ANTERIOR_REAJ'	):SetValue(cAlias1->(VALOR_ANTERIOR))
			oUsr:Cell('DATA_REAJUSTE'):SetValue(DTOC(STOD((cAlias1->(DATA_REAJUSTE)))))
		    oUsr:Cell('ORIGEM'):SetValue("COBRANÇA")
				
			aAdd(aRel, {cAlias1->(BM1_MATUSU), cAlias1->(BM1_CODEMP), cAlias1->(BM1_CONEMP), cAlias1->(BM1_SUBCON), cAlias1->(BM1_CODPLA), cAlias1->(BTN_IDAINI),;
						cAlias1->(BTN_IDAFIN), cAlias1->(BM1_CARGO), cAlias1->(VALORCOBRADO),cAlias1->(VALORTABELA), cAlias1->(NUM_COBR_BM1), cAlias1->(VALOR_ANTERIOR), cAlias1->(DATA_REAJUSTE), "COBRANÇA" })
			
			oUsr:PrintLine()
							
		EndIf
	
	
	
	    cAlias1->(dbSkip())
	        
	EndDo

	oUsr:Finish()

	cAlias1->(dbCloseArea()) 

	If Len(aRel) >0
		If APMSGYESNO("Deseja gerar uma listagem em excel com os resultados gerados?","Listar em Excel?")
			DlgToExcel({{"ARRAY","Listagem de inconsistências de valor cobrado nas mensalidades.","",aRel }} )
		EndIf
	EndIf

Else

	//Se nao tiver esta linha, nÃ£o imprime os dados
	oUsr:init()
	
	oReport:SetMeter(nCont) 
	
	//cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
	nCont 	:= 0       
	nCritic	:= 0

	//While !( cAlias1->(Eof()) )
    For i := 1 To Len(aVetGeral) 
		If oReport:Cancel()  
	    
		    oReport:FatLine()     
		    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
		    exit
	    
		EndIf
                                                    
		oReport:SetMsgPrint("Analisando dados das mensalidades...")
		oReport:IncMeter()

		//nome das celulas
		//'MATRIC'	
		//'BM1_CODEMP'
		//'CONTRATO'
		//'SUBCONTRATO'
		//'COD_PLANO'
		//'IDADE_INICIAL'
		//'IDADE_FINAL'
		//'IDADE_ATUAL' 
		//'VALOR_COBRADO'
		//'VALOR_TABELA'
		//'NUM_COBR_BM1'
		//'VALOR_ANTERIOR_REAJ'
		//'DATA_REAJUSTE'
		//Origem da Faixa (Familia ou Usuario)
		If MV_PAR03 = 1 //mostra somente possiveis erros
			If aVetGeral[i][9] <> aVetGeral[i][10] //valor cobrado <> valor tabela
				If aVetGeral[i][9] <> aVetGeral[i][12] //(VALORCOBRADO) <> cAlias1->(VALOR_ANTERIOR) 
					oUsr:Cell('MATRIC'		):SetValue(aVetGeral[i][1])
					oUsr:Cell('BM1_CODEMP'	):SetValue(aVetGeral[i][2])
					oUsr:Cell('CONTRATO'	):SetValue(aVetGeral[i][3])
					oUsr:Cell('SUBCONTRATO'	):SetValue(aVetGeral[i][4])
					oUsr:Cell('COD_PLANO'	):SetValue(aVetGeral[i][5])
					oUsr:Cell('IDADE_INICIAL'):SetValue(aVetGeral[i][6])
					oUsr:Cell('IDADE_FINAL'	):SetValue(aVetGeral[i][7])
					oUsr:Cell('IDADE_ATUAL'	):SetValue(aVetGeral[i][8])
					oUsr:Cell('VALOR_COBRADO'):SetValue(aVetGeral[i][9])
					oUsr:Cell('VALOR_TABELA'):SetValue(aVetGeral[i][10])
					oUsr:Cell('NUM_COBR_BM1'):SetValue(aVetGeral[i][11])
					oUsr:Cell('VALOR_ANTERIOR_REAJ'	):SetValue(aVetGeral[i][12])
					oUsr:Cell('DATA_REAJUSTE'):SetValue(DTOC(STOD((aVetGeral[i][13]))))
					oUsr:Cell('ORIGEM'):SetValue(aVetGeral[i][14])

					aAdd(aRel, {aVetGeral[i][1], aVetGeral[i][2], aVetGeral[i][3], aVetGeral[i][4], aVetGeral[i][5], aVetGeral[i][6], aVetGeral[i][7],;
								aVetGeral[i][8], aVetGeral[i][9], aVetGeral[i][10],aVetGeral[i][11], aVetGeral[i][12], aVetGeral[i][13], aVetGeral[i][14] })
				
					oUsr:PrintLine()
				
				EndIf
		
			EndIf
	
		Else
		
			oUsr:Cell('MATRIC'		):SetValue(aVetGeral[i][1])
			oUsr:Cell('BM1_CODEMP'	):SetValue(aVetGeral[i][2])
			oUsr:Cell('CONTRATO'	):SetValue(aVetGeral[i][3])
			oUsr:Cell('SUBCONTRATO'	):SetValue(aVetGeral[i][4])
			oUsr:Cell('COD_PLANO'	):SetValue(aVetGeral[i][5])
			oUsr:Cell('IDADE_INICIAL'):SetValue(aVetGeral[i][6])
			oUsr:Cell('IDADE_FINAL'	):SetValue(aVetGeral[i][7])
			oUsr:Cell('IDADE_ATUAL'	):SetValue(aVetGeral[i][8])
			oUsr:Cell('VALOR_COBRADO'):SetValue(aVetGeral[i][9])
			oUsr:Cell('VALOR_TABELA'):SetValue(aVetGeral[i][10])
			oUsr:Cell('NUM_COBR_BM1'):SetValue(aVetGeral[i][11])
			oUsr:Cell('VALOR_ANTERIOR_REAJ'	):SetValue(aVetGeral[i][12])
			oUsr:Cell('DATA_REAJUSTE'):SetValue(DTOC(STOD((aVetGeral[i][13]))))
			oUsr:Cell('ORIGEM'):SetValue(aVetGeral[i][14])

			aAdd(aRel, {aVetGeral[i][1], aVetGeral[i][2], aVetGeral[i][3], aVetGeral[i][4], aVetGeral[i][5], aVetGeral[i][6], aVetGeral[i][7],;
						aVetGeral[i][8], aVetGeral[i][9], aVetGeral[i][10],aVetGeral[i][11], aVetGeral[i][12], aVetGeral[i][13], aVetGeral[i][14] })
				
			oUsr:PrintLine()
							
		EndIf
	
	
	
	    //cAlias1->(dbSkip())
	        
	//EndDo
    Next i
	
	oUsr:Finish()

	//cAlias1->(dbCloseArea()) 

	If Len(aRel) >0
		If APMSGYESNO("Deseja gerar uma listagem em excel com os resultados gerados?","Listar em Excel?")
			DlgToExcel({{"ARRAY","Listagem de inconsistências de valor cobrado nas mensalidades.","",aRel }} )
		EndIf
	EndIf
	
	If Len(aDuplic) > 0
		If APMSGYESNO("Deseja gerar uma listagem em excel com as matrículas que possuem parametrização de valor de faixa duplicada?","Listar duplicidades em Excel?")
			DlgToExcel({{"ARRAY","Listagem de matrículas que possuem parametrização de valor de faixa duplicada.","",aDuplic }} )
		EndIf
	EndIf
	
EndIf

Return   


********************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BscIncon  ºAutor  ³Renato Peixoto      º Data ³  04/19/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função que contém a query que vai buscar os registros que   º±±
±±º          ³possivelmente possuem inconsistencia no valor mensalidade.  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function BscIncon

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

cAno    := MV_PAR01
cMes    := MV_PAR02
cCompet := cAno+cMes   

ProcRegua(0)

For i := 0 to 5
	IncProc('Selecionando registros...')
Next
// compara faturado X tabela de preço
cQuery := "SELECT BM1_MATUSU,  BM1_CODEMP, BM1_CONEMP, BM1_SUBCON, BM1_CODPLA, BTN_IDAINI, BTN_IDAFIN, BM1_CARGO , BM1_VALOR valorcobrado, BTN_valfai valortabela, bm1_plnuco Num_Cobr_BM1, btn_vlrant valor_anterior, btn_perrej data_reajuste "
cQuery += "FROM "+RetSqlName("BM1")+" BM1, "+RetSqlName("BTN")+" BTN "
cQuery += "WHERE BM1_FILIAL = '"+XFILIAL("BM1")+"' "
cQuery += "AND BM1_CODEMP IN ( '0006', '0010') "
cQuery += "AND ( ( BM1_CODEMP = '0006' AND BM1_CONEMP = '000000000001'  ) "
cQuery += "       or BM1_CODEMP = '0010' OR ( BM1_CODEMP = '0006' AND BM1_CONEMP =  '000000000003' AND BM1_SUBCON IN ('000000001', '000000002') ) "
cQuery += "            ) "
cQuery += "AND BM1_ANO||BM1_MES = '"+cCompet+"' "
cQuery += "AND BM1.D_E_L_E_T_ = ' ' "
cQuery += "AND BTN_FILIAL = '"+XFILIAL("BTN")+"' "
cQuery += "AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP "
cQuery += "AND BTN_NUMCON = BM1_CONEMP "
cQuery += "AND BTN_SUBCON = BM1_SUBCON "
cQuery += "AND BTN.D_E_L_E_T_ = ' ' "
cQuery += "AND BTN_CODPRO = BM1_CODPLA "
cQuery += "AND BTN_IDAINI <= To_Number (Nvl (trim (BM1_CARGO),'0')) "
cQuery += "AND BTN_IDAFIN >= TO_NUMBER (NVL (TRIM (BM1_CARGO),'0')) "
cQuery += "AND BM1_VALOR <> BTN_valfai "
cQuery += "and bm1_codtip = '101' "
cQuery += "ORDER BY BM1_ANO, BM1_MES, BM1_CODEMP, BM1_MATRIC, BM1_CONEMP, BM1_SUBCON, BM1_CODPLA, BM1_VALOR "


TcQuery cQuery New Alias cAlias1

cAlias1->(dbGoTop())

nCont := 0

cAlias1->(dbEval({||++nCont}))

cAlias1->(dbGoTop())

Return nCont

********************************************************************************************************************************


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BscIncoFaiºAutor  ³Renato Peixoto      º Data ³  02/05/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Busca as inconsistencias tendo como base o valor que esta  º±±
±±º          ³ parametrizado na faixa (usu/fam) e nao na cobranca (BM1).  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function BscIncoFai()

Local cQuery2    := ""
Local cQuery3    := ""
Local cUsuValFai := "" //Usuarios que possuem parametrizacao de valor mensalidade na faixa do usuario
Local i          := 0

cAno    := MV_PAR01
cMes    := MV_PAR02
cCompet := cAno+cMes   

ProcRegua(0)

For i := 0 to 5
	IncProc('Selecionando registros...')
Next

//query adaptada para nova visao relatorio alan (linkando com a BDK (usuario)
cQuery2 := "SELECT BM1_MATUSU,  BM1_CODEMP, BM1_CONEMP, BM1_SUBCON, BM1_CODPLA, BTN_IDAINI, BTN_IDAFIN, BM1_CARGO , bdk_valor, BTN_valfai valortabela, "
cQuery2 += "bm1_plnuco Num_Cobr_BM1, btn_vlrant valor_anterior, btn_perrej data_reajuste "
cQuery2 += "FROM "+RetSqlName("BM1")+" BM1, "+RetSqlName("BTN")+" BTN, "+RetSqlName("BDK")+" BDK "
cQuery2 += "WHERE BM1_FILIAL = '"+XFILIAL("BM1")+"' AND BTN_FILIAL = '"+XFILIAL("BTN")+"' AND bdk_filial = '"+XFILIAL("BDK")+"' "
cQuery2 += "AND BM1.D_E_L_E_T_ = ' ' AND BTN.D_E_L_E_T_ = ' ' AND bdk.D_E_L_E_T_ = ' ' "
cQuery2 += "AND BM1_CODEMP IN ( '0006', '0010') "
cQuery2 += "AND ( ( BM1_CODEMP = '0006' AND BM1_CONEMP = '000000000001'  ) "
cQuery2 += "      or BM1_CODEMP = '0010' OR ( BM1_CODEMP = '0006' AND BM1_CONEMP =  '000000000003' AND BM1_SUBCON IN ('000000001', '000000002') )             ) "
cQuery2 += "AND BM1_ANO||BM1_MES = '"+cCompet+"' "
cQuery2 += "AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP AND BTN_NUMCON = BM1_CONEMP AND BTN_SUBCON = BM1_SUBCON "
cQuery2 += "AND BTN_CODPRO = BM1_CODPLA AND BTN_IDAINI <= To_Number (Nvl (trim (BM1_CARGO),'0')) AND BTN_IDAFIN >= TO_NUMBER (NVL (TRIM (BM1_CARGO),'0'))
cQuery2 += "AND BM1_VALOR <> BTN_valfai and bm1_codtip = '101'

cQuery2 += "AND SubStr(bm1_matusu,1,4) = bdk_codint AND SubStr(bm1_matusu,5,4) = bdk_codemp "
cQuery2 += "AND SubStr(bm1_matusu,9,6) = bdk_matric AND SubStr(bm1_matusu,15,2) = bdk_tipreg "
cQuery2 += "AND bm1_cargo BETWEEN bdk_idaini AND bdk_idafin "
cQuery2 += "ORDER BY BM1_ANO, BM1_MES, BM1_CODEMP, BM1_MATRIC, BM1_CONEMP, BM1_SUBCON, BM1_CODPLA, BM1_VALOR "
      
TcQuery cQuery2 New Alias cAlias2

If !cAlias2->(Eof())
	While !cAlias2->(Eof())
		If aScan( aFaiUsu , { |x| x[1] == cAlias2->BM1_MATUSU } ) > 0
			aAdd ( aDuplic, {cAlias2->BM1_MATUSU, cAlias2->BM1_CODEMP, cAlias2->BM1_CONEMP, cAlias2->BM1_SUBCON, cAlias2->BM1_CODPLA, cAlias2->BTN_IDAINI,;
				  cAlias2->BTN_IDAFIN, cAlias2->BM1_CARGO, cAlias2->BDK_VALOR, cAlias2->valortabela, cAlias2->Num_Cobr_BM1, cAlias2->valor_anterior, cAlias2->data_reajuste, "FAIXA_USUARIO" } )
		EndIf
		
		aAdd (aFaiUsu, {cAlias2->BM1_MATUSU, cAlias2->BM1_CODEMP, cAlias2->BM1_CONEMP, cAlias2->BM1_SUBCON, cAlias2->BM1_CODPLA, cAlias2->BTN_IDAINI,;
			  cAlias2->BTN_IDAFIN, cAlias2->BM1_CARGO, cAlias2->BDK_VALOR, cAlias2->valortabela, cAlias2->Num_Cobr_BM1, cAlias2->valor_anterior, cAlias2->data_reajuste, "FAIXA_USUARIO" } )		
        
		cAlias2->(DbSkip())
	EndDo
	
	For i := 1 To Len(aFaiUsu)
		
		If i = 1
			
			cUsuValFai += "'"+aFaiUsu[i][1]+"'"
			
		Else
			
			cUsuValFai += ",'"+aFaiUsu[i][1]+"'"
			
		EndIf
		
	Next i
EndIf

//linkando com a BBU (familia)
	cQuery3 := "SELECT BM1_MATUSU,  BM1_CODEMP, BM1_CONEMP, BM1_SUBCON, BM1_CODPLA, BTN_IDAINI, BTN_IDAFIN, BM1_CARGO , bbu_valfai, BTN_valfai valortabela, "
	cQuery3 += "bm1_plnuco Num_Cobr_BM1, btn_vlrant valor_anterior, btn_perrej data_reajuste "
	cQuery3 += "FROM "+RetSqlName("BM1")+" BM1, "+RetSqlName("BTN")+" BTN, "+RetSqlName("BBU")+" BBU "
	cQuery3 += "WHERE BM1_FILIAL = '"+XFILIAL("BM1")+"' AND BTN_FILIAL = '"+XFILIAL("BTN")+"' AND bbu_filial = '"+XFILIAL("BBU")+"' "
	cQuery3 += "AND BM1.D_E_L_E_T_ = ' ' AND BTN.D_E_L_E_T_ = ' ' AND bbu.D_E_L_E_T_ = ' ' "
	cQuery3 += "AND BM1_CODEMP IN ( '0006', '0010') "
	cQuery3 += "AND ( ( BM1_CODEMP = '0006' AND BM1_CONEMP = '000000000001'  ) "
	cQuery3 += "      or BM1_CODEMP = '0010' OR ( BM1_CODEMP = '0006' AND BM1_CONEMP =  '000000000003' AND BM1_SUBCON IN ('000000001', '000000002') )             ) "
	cQuery3 += "AND BM1_ANO||BM1_MES = '"+cCompet+"' "
	cQuery3 += "AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP AND BTN_NUMCON = BM1_CONEMP AND BTN_SUBCON = BM1_SUBCON "
	cQuery3 += "AND BTN_CODPRO = BM1_CODPLA AND BTN_IDAINI <= To_Number (Nvl (trim (BM1_CARGO),'0')) AND BTN_IDAFIN >= TO_NUMBER (NVL (TRIM (BM1_CARGO),'0')) "
	cQuery3 += "AND BM1_VALOR <> BTN_valfai and bm1_codtip = '101' "
	      
	cQuery3 += "AND SubStr(bm1_matusu,1,4) = bbu_codope AND SubStr(bm1_matusu,5,4) = bbu_codemp "
	cQuery3 += "AND SubStr(bm1_matusu,9,6) = bbu_matric "
	cQuery3 += "AND bm1_cargo BETWEEN bbu_idaini AND bbu_idafin "                                                 
If !Empty(cUsuValFai) //so vai fazer esse trecho se a query anterior trouxer ao menos 1 resultado. Renato Peixoto em 15/05/12
	cQuery3 += "AND BM1_MATUSU NOT IN ("+cUsuValFai+") "  //nao precisa pegar daqueles beneficiarios que ja foram encontrados com parametrizacao no nivel de usuario, pois esse nivel se sobrepoe a familia...
EndIf
cQuery3 += "ORDER BY BM1_ANO, BM1_MES, BM1_CODEMP, BM1_MATRIC, BM1_CONEMP, BM1_SUBCON, BM1_CODPLA, BM1_VALOR "

i := 0

TcQuery cQuery3 New Alias cAlias3

If !cAlias3->(Eof())
	While !cAlias3->(Eof())
		If aScan( aFaiFam , { |x| x[1] == cAlias3->BM1_MATUSU } ) > 0
			aAdd ( aDuplic, {cAlias3->BM1_MATUSU, cAlias3->BM1_CODEMP, cAlias3->BM1_CONEMP, cAlias3->BM1_SUBCON, cAlias3->BM1_CODPLA, cAlias3->BTN_IDAINI,;
				  cAlias3->BTN_IDAFIN, cAlias3->BM1_CARGO, cAlias3->BBU_VALFAI, cAlias3->valortabela, cAlias3->Num_Cobr_BM1, cAlias3->valor_anterior, cAlias3->data_reajuste, "FAIXA_FAMILIA" } )
		EndIf
		
		aAdd ( aFaiFam, {cAlias3->BM1_MATUSU, cAlias3->BM1_CODEMP, cAlias3->BM1_CONEMP, cAlias3->BM1_SUBCON, cAlias3->BM1_CODPLA, cAlias3->BTN_IDAINI,;
				  cAlias3->BTN_IDAFIN, cAlias3->BM1_CARGO, cAlias3->BBU_VALFAI, cAlias3->valortabela, cAlias3->Num_Cobr_BM1, cAlias3->valor_anterior, cAlias3->data_reajuste, "FAIXA_FAMILIA" } )
        
		cAlias3->(DbSkip())
	EndDo
	
EndIf

nCont := 0
cAlias2->(DbCloseArea())
cAlias3->(DbCloseArea())

aVetGeral := AClone(aFaiFam)

For i := 1 To Len(aFaiUsu)
	aAdd ( aVetGeral, { aFaiUsu[i][1], aFaiUsu[i][2], aFaiUsu[i][3], aFaiUsu[i][4], aFaiUsu[i][5], aFaiUsu[i][6], aFaiUsu[i][7], aFaiUsu[i][8], aFaiUsu[i][9],;
	       aFaiUsu[i][10], aFaiUsu[i][11], aFaiUsu[i][12], aFaiUsu[i][13], aFaiUsu[i][14] } )
Next i

//Ordena o vetor geral com a mesma ordem especificada na query
ASort(aVetGeral , , , {|x,y|x[1]+x[3]+x[4]+x[5] < y[1]+y[3]+y[4]+y[5]})
  
nCont := Len(aVetGeral)


Return nCont

********************************************************************************************************************************
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Renato Peixoto                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta as perguntas do SX1                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}


aHelp := {}
aAdd(aHelp, "Informe o ano")
PutSX1(cPerg , "01" , "Ano" 	,"","","mv_ch1","C",4,0,0,"G",""	,"","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o mes")
PutSX1(cPerg , "02" , "Mes" 	,"","","mv_ch2","C",2,0,0,"G",""	,"","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Escolha o nivel de detalhamento")
PutSX1(cPerg,"03", "Detalhamento","","","mv_ch3","N",01	,0,1,"C","","","","","mv_par03","Possiveis erros"	,"","","","Lista tudo","","",""	,"","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Escolha a visçao do relatório")
PutSX1(cPerg,"04", "Visão","","","mv_ch4","N"       ,01 	,0,1,"C","","","","","mv_par04","Valor Cobrado"	,"","","","Valor Faixa Usu./Fam.","","",""	,"","","","","","","","",aHelp,aHelp,aHelp)

Return
