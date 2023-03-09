#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "TOPCONN.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ CABA609 ณ Autor ณAngelo Henrique        ณ Data ณ28/02/2018 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณLocacao   ณCABERJ            ณContato ณCABERJ                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณRotina utilizada para a gera็ใo das tabelas pertinentes a   ณฑฑ
ฑฑณ          ณXML para envio.                                             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function CABA609()
	
	Local _aArea 	:= GetArea()
	
	Private _oDlg	:= Nil
	Private _oBtn	:= Nil
	Private _oGroup	:= Nil
	
	DEFINE MSDIALOG _oDlg FROM 0,0 TO 90,380 PIXEL TITLE 'Processo XML '
	
	_oGroup:= tGroup():New(02,05,40,175,'Selecione uma das op็๕es',_oDlg,,,.T.)
	
	_oBtn := TButton():New( 15,020,"Antecipa/Fatura"	,_oDlg,{||_oDlg:End(),_nOpc := 1	},060,012,,,,.T.,,"",,,,.F. )
	_oBtn := TButton():New( 15,100,"Marca/Desmarca XML"	,_oDlg,{||_oDlg:End(),_nOpc := 2	},060,012,,,,.T.,,"",,,,.F. )
	
	ACTIVATE MSDIALOG _oDlg CENTERED
	
	If _nOpc = 1
		
		//--------------------------------------
		//Chamada da fun็ใo de Antecipa/Fatura
		//--------------------------------------
		u_CABA609A()
		
	ElseIf _nOpc = 2
		
		//--------------------------------------
		//Chamada da fun็ใo Marca/Desmarca
		//--------------------------------------
		u_CABA609D()
		
	EndIf
	
	
	
	RestArea(_aArea)
	
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ CABA609Aณ Autor ณAngelo Henrique        ณ Data ณ28/02/2018 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณLocacao   ณCABERJ            ณContato ณCABERJ                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณRotina utilizada para validar os parametros digitados na    ณฑฑ
ฑฑณ          ณtela e assim executar a rotina.                             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function CABA609A()
	
	Local _aArea 		:= GetArea()
	Local _aArBA0		:= BA0->(GetArea())
	Local _lAchou		:= .T.
	Local _cMsg			:= ""
	
	Private _cQuery		:= ""
	Private _cEmpOri	:= ""
	Private _cEmpDes	:= ""
	Private _cCNPJOri	:= ""
	Private _cCNPJDes	:= ""
	Private _cPerg		:= "CABA609"
	
	//-------------------------------------------------------------------------------------------------
	//Cria grupo de perguntas
	//-------------------------------------------------------------------------------------------------
	CABA609B(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//----------------------------------------------------
		//Pegando aqui as informa็๕es dos parametros
		//----------------------------------------------------
		If !Empty(MV_PAR01) .And. !Empty(MV_PAR02) .And. !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
			
			DbSelectArea("BA0")
			DbSetOrder(1)
			If DbSeek(xFilial("BA0") + MV_PAR01 )
				
				If BA0->(BA0_CODIDE+BA0_CODINT) = "0001"
					
					_cEmpOri := "CABERJ" //Chumbado porque no registro esta com o nome completo da CABERJ
					
				ElseIf BA0->(BA0_CODIDE+BA0_CODINT) = "1031"
					
					_cEmpOri := "INTEGRAL" //Chumbado porque no registro esta com o nome completo da INTEGRAL
					
				Else
					
					_cEmpOri := AllTrim(BA0->BA0_NOMINT	)
					
				EndIf
				
				_cCNPJOri	:= AllTrim(BA0->BA0_CGC		)
				
			Else
				
				_lAchou := .F.
				
				Aviso("Aten็ใo","Operadora origem digitada nใo foi encontrada no cadastro de operadoras.",{"OK"})
				
			EndIf
			
			//------------------------------------------------------------------
			//S๓ consulta a empresa destino se a origem estiver correta
			//------------------------------------------------------------------
			If _lAchou
				
				DbSelectArea("BA0")
				DbSetOrder(1)
				If DbSeek(xFilial("BA0") + MV_PAR02 )
					
					If BA0->(BA0_CODIDE+BA0_CODINT) = "0001"
						
						_cEmpDes := "CABERJ" //Chumbado porque no registro esta com o nome completo da CABERJ
						
					ElseIf BA0->(BA0_CODIDE+BA0_CODINT) = "1031"
						
						_cEmpDes := "INTEGRAL" //Chumbado porque no registro esta com o nome completo da INTEGRAL
						
					Else
						
						_cEmpDes := AllTrim(BA0->BA0_NOMINT	)
						
					EndIf
					
					_cCNPJDes	:= AllTrim(BA0->BA0_CGC		)
					
				Else
					
					_lAchou := .F.
					
					Aviso("Aten็ใo","Operadora destino digitada nใo foi encontrado no cadastro de operadoras.",{"OK"})
					
				EndIf
				
			EndIf
			
			//-------------------------------------------------------------
			//Se passar por todas as valida็๕es executa a procedure
			//-------------------------------------------------------------
			If _lAchou
				
				//-----------------------------------------------------------------------------------------------
				//Montando uma regua somente para informar ao usuแrio q esta sendo executado
				//-----------------------------------------------------------------------------------------------
				Processa({||CABA609C()},'Processando...')
				
			EndIf
			
		Else
			
			_cMsg := "Necessแrio preencher os seguintes parโmetros para prosseguir: " + CRLF
			_cMsg += "Operadora Origem, operadora destino, m๊s e ano de pagamento." + CRLF
			
			Aviso("Aten็ใo",_cMsg,{"OK"})
			
		EndIf
		
	EndIf
	
	RestArea(_aArBA0)
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA609B  บAutor  ณAngelo Henrique     บ Data ณ  28/02/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas do programa   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABA609B(cGrpPerg)
	
	Local aHelpPor 	:= {} //help da pergunta
	Local _nOper	:= TamSx3("BA0_CODIDE")[1] + TamSx3("BA0_CODINT")[1]
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Operadora de Origem	")
	
	PutSx1(cGrpPerg,"01","Oper. Orig.: ?"			,"a","a","MV_CH1"	,"C",_nOper						,0,0,"G","","BA0XML","","","MV_PAR01",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Operadora de Destino	")
	
	PutSx1(cGrpPerg,"02","Oper. Dest.: ?"			,"a","a","MV_CH2"	,"C",_nOper						,0,0,"G","","BA0XML","","","MV_PAR02",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o m๊s de pagamento		")
	
	PutSx1(cGrpPerg,"03","Mes ? "					,"a","a","MV_CH2"	,"C",TamSX3("PCS_MESPAG")[1]	,0,0,"G","",""		,"","","MV_PAR03",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o ano de pagamento		")
	
	PutSx1(cGrpPerg,"04","Ano ?"					,"a","a","MV_CH3"	,"C",TamSX3("PCS_ANOPAG")[1]	,0,0,"G","",""		,"","","MV_PAR04",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o tipo		")
	
	PutSx1(cGrpPerg,"05","Tipo ?"					,"a","a","MV_CH5"	,"N",01							,0,0,"C","",""		,"","","MV_PAR05","Antecipa็ใo"		,"","","","Faturamento"				,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Lote		")
	
	PutSx1(cGrpPerg,"06","Lote De: ?"				,"a","a","MV_CH6"	,"C",TamSX3("BDH_NUMFAT")[1]	,0,0,"G","",""		,"","","MV_PAR06",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"07","Lote Ate: ?"				,"a","a","MV_CH7"	,"C",TamSX3("BDH_NUMFAT")[1]	,0,0,"G","",""		,"","","MV_PAR07",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA609C  บAutor  ณAngelo Henrique     บ Data ณ  28/02/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela execu็ใo da procedure, chamado aqui บฑฑ
ฑฑบ          ณpois na rotina principal foi colocado uma r้gua meramente   บฑฑ
ฑฑบ          ณilustrativa, para que o usuแrio nใo pense que a rotina      บฑฑ
ฑฑบ          ณtravou.                                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABA609C
	
	Local _cHoraIn 	:= ""
	Local _cHoraFim := ""
	Local _cAlias 	:= GetNextAlias()
	Local cNomeArq	:= "C:\TEMP\LOTE_XML_ANT_" + DTOS(DATE()) + "_" + STRTRAN(TIME(),":","_") + ".TXT"
	Local cArqFat	:= "C:\TEMP\LOTE_XML_FAT_" + DTOS(DATE()) + "_" + STRTRAN(TIME(),":","_") + ".TXT"
	Local _lArq 	:= .T.
	Local c_Lin     := Space(1)+CHR(13)+CHR(10)
	Local _cTit		:= "Geracao XML"
	Local _aTex		:= {}
	Local _aBot		:= {}
	Local _cQuery	:= ""
	Local _nIni 	:= 0
	Local _cLote	:= ""
	
	PRIVATE nHdl	:= Nil
	
	AADD(_aBot, {1, .T., {||FechaBatch()}})
	
	If MV_PAR05 = 1 //Antecipa็ใo
		
		IncProc("Analisando Antecipa็ใo: " + AllTrim(Transform("1000","@E 9999999")))
		
		//-----------------------------------------------------------------------------------------------
		//Validando qual a empresa, pois sใo procedures distintas para a CABESP e para a INTEGRAL
		//-----------------------------------------------------------------------------------------------
		If  MV_PAR02 == "1008" //CABESP
			
			_cHoraIn := TIME()
			
			_cQuery := " BEGIN " + CRLF
			_cQuery += " SIGA.CARGA_TABS_RECIP_ANT_ALTAM('" + _cEmpOri + "','" + _cEmpDes + "','" + _cCNPJOri + "','" + _cCNPJDes + "','" + MV_PAR02 + "','" + MV_PAR03 + "','" + MV_PAR04 + "'); " + CRLF
			_cQuery += " COMMIT; " + CRLF
			_cQuery += " END; " + CRLF
			
			If TCSQLExec( _cQuery ) < 0
				
				Aviso("Aten็ใo","Nใo foi possํvel realizar o processamento.",{"OK"})
				
			Else
				
				_cHoraFim := TIME()
				
				Aviso("Aten็ใo","Processamento finalizado.",{"OK"})
				
				//------------------------------------------------------------------
				//Gerar arquivo para exibir os lotes gerados pela rotina XML
				//------------------------------------------------------------------
				
				_cQuery := " SELECT														" + CRLF
				_cQuery += " 	RCPLOTE.EMPRESA,										" + CRLF
				_cQuery += " 	RCPLOTE.IDLOTE,											" + CRLF
				_cQuery += " 	RCPLOTE.OPERADORA_DESTINO,								" + CRLF
				_cQuery += " 	RCPLOTE.OPERADORA_ORIGEM								" + CRLF
				_cQuery += " FROM														" + CRLF
				_cQuery += " 	RECIPR_LOTE RCPLOTE										" + CRLF
				_cQuery += " WHERE														" + CRLF
				_cQuery += " 	RCPLOTE.DATAREGISTROTRANSACAO = '" + DTOS(DATE()) + "'	" + CRLF
				_cQuery += " 	AND RCPLOTE.OPERADORA_ORIGEM  = '" + _cEmpOri + "'		" + CRLF
				_cQuery += " 	AND RCPLOTE.OPERADORA_DESTINO = '" + _cEmpDes + "'		" + CRLF
				_cQuery += " 	AND RCPLOTE.CNPJ_ORIGEM  = '" + _cCNPJOri + "'			" + CRLF
				_cQuery += " 	AND RCPLOTE.CNPJ_DESTINO = '" + _cCNPJDes + "'			" + CRLF
				_cQuery += " 	AND RCPLOTE.HORAREGISTROTRANSACAO BETWEEN '" + _cHoraIn + "' AND '" + _cHoraFim + "' " + CRLF
				
				TCQuery _cQuery new Alias (_cAlias)
				
				If (_cAlias)->(!Eof())
					
					If !u_CRIA_TXT(cNomeArq)
						
						_lArq := .F.
						
						AADD(_aTex, "Aten็ใo.")
						AADD(_aTex, "Nใo foi possํvel a gera็ใo do arquivo com os lotes gerados.")
						AADD(_aTex, "Anote os lotes abaixo para executar a rotina de Marca็ใo de XML.")
						
					Else
						
						AADD(_aTex, "Lote XML Gerado, empresa origem: " + _cEmpOri + ", empresa destino: " + _cEmpDes )
						u_GRLINHA_TXT("Lote XML Gerado, empresa origem: " + _cEmpOri + ", empresa destino: " + _cEmpDes ,c_Lin)
						
						AADD(_aTex, cNomeArq)
						u_GRLINHA_TXT(cNomeArq,c_Lin)
						
					EndIf
					
					_nIni := 0
					
					While (_cAlias)->(!Eof())
						
						_cLote := cValToChar((_cAlias)->IDLOTE)
						
						If _nIni = 0
							
							AADD(_aTex, "Lote Inicial: " + _cLote )
							
							_nIni ++
							
						EndIf
						
						//-----------------------------------------------------
						//Grava็ใo de todos os lotes no arquivo .TXT
						//-----------------------------------------------------
						If _lArq
							
							u_GRLINHA_TXT("Lote: " + _cLote ,c_Lin)
							
						EndIf
						
						(_cAlias)->(DbSkip())
						
						//----------------------------------------------------------------------------
						//Validando se ้ o ultimo registro para acrescentar na tela exibida no
						//final da gera็ใo do processo.
						//----------------------------------------------------------------------------
						If (_cAlias)->(Eof())
							
							AADD(_aTex, "Lote Final: " + _cLote )
							
						EndIf
						
					EndDo
					
					If _lArq
						
						U_Fecha_TXT()
						
					EndIf
					
					(_cAlias)->(DbCloseArea())
					
					//--------------------------------------------------------------------------------
					//Gerado ou nใo o arquivo ao final serแ exibido uma tela contendo os lotes.
					//--------------------------------------------------------------------------------
					FORMBATCH(_cTit, _aTex, _aBot)
					
				Endif
				
			EndIf
			
		EndIf
		
	Else //Faturamento
		
		If  MV_PAR02 == "1008" //CABESP
		
			_cHoraIn := TIME()
			
			_cQuery := " BEGIN " + CRLF
			_cQuery += " SIGA.CARGA_TABS_RECIP_FIN_ALTAM('" + _cEmpOri + "','" + _cEmpDes + "','" + _cCNPJOri + "','" + _cCNPJDes + "','" + AllTrim(MV_PAR06) + "','" + AllTrim(MV_PAR07) + "','" + MV_PAR02 + "'); " + CRLF
			_cQuery += " COMMIT; " + CRLF
			_cQuery += " END; " + CRLF
			
			If TCSQLExec( _cQuery ) < 0
				
				Aviso("Aten็ใo","Nใo foi possํvel realizar o processamento.",{"OK"})
				
			Else
				
				_cHoraFim := TIME()
				
				Aviso("Aten็ใo","Processamento finalizado.",{"OK"})
				
				//------------------------------------------------------------------
				//Gerar arquivo para exibir os lotes gerados pela rotina XML
				//------------------------------------------------------------------
				
				_cQuery := " SELECT														" + CRLF
				_cQuery += " 	RCPLOTE.EMPRESA,										" + CRLF
				_cQuery += " 	RCPLOTE.IDLOTE,											" + CRLF
				_cQuery += " 	RCPLOTE.OPERADORA_DESTINO,								" + CRLF
				_cQuery += " 	RCPLOTE.OPERADORA_ORIGEM								" + CRLF
				_cQuery += " FROM														" + CRLF
				_cQuery += " 	RECIPR_LOTE RCPLOTE										" + CRLF
				_cQuery += " WHERE														" + CRLF
				_cQuery += " 	RCPLOTE.DATAREGISTROTRANSACAO = '" + DTOS(DATE()) + "'	" + CRLF
				_cQuery += " 	AND RCPLOTE.OPERADORA_ORIGEM  = '" + _cEmpOri + "'		" + CRLF
				_cQuery += " 	AND RCPLOTE.OPERADORA_DESTINO = '" + _cEmpDes + "'		" + CRLF
				_cQuery += " 	AND RCPLOTE.CNPJ_ORIGEM  = '" + _cCNPJOri + "'			" + CRLF
				_cQuery += " 	AND RCPLOTE.CNPJ_DESTINO = '" + _cCNPJDes + "'			" + CRLF
				_cQuery += " 	AND RCPLOTE.HORAREGISTROTRANSACAO BETWEEN '" + _cHoraIn + "' AND '" + _cHoraFim + "' " + CRLF
				
				TCQuery _cQuery new Alias (_cAlias)
				
				If (_cAlias)->(!Eof())
					
					If !u_CRIA_TXT(cArqFat)
						
						_lArq := .F.
						
						AADD(_aTex, "Aten็ใo.")
						AADD(_aTex, "Nใo foi possํvel a gera็ใo do arquivo com os lotes gerados.")
						AADD(_aTex, "Anote os lotes abaixo para executar a rotina de Marca็ใo de XML.")
						
					Else
						
						AADD(_aTex, "Lote XML Gerado, empresa origem: " + _cEmpOri + ", empresa destino: " + _cEmpDes )
						u_GRLINHA_TXT("Lote XML Gerado, empresa origem: " + _cEmpOri + ", empresa destino: " + _cEmpDes ,c_Lin)
						
						AADD(_aTex, cArqFat)
						u_GRLINHA_TXT(cArqFat,c_Lin)
						
					EndIf
					
					_nIni := 0
					
					While (_cAlias)->(!Eof())
						
						_cLote := cValToChar((_cAlias)->IDLOTE)
						
						If _nIni = 0
							
							AADD(_aTex, "Lote Inicial: " + _cLote )
							
							_nIni ++
							
						EndIf
						
						//-----------------------------------------------------
						//Grava็ใo de todos os lotes no arquivo .TXT
						//-----------------------------------------------------
						If _lArq
							
							u_GRLINHA_TXT("Lote: " + _cLote ,c_Lin)
							
						EndIf
						
						(_cAlias)->(DbSkip())
						
						//----------------------------------------------------------------------------
						//Validando se ้ o ultimo registro para acrescentar na tela exibida no
						//final da gera็ใo do processo.
						//----------------------------------------------------------------------------
						If (_cAlias)->(Eof())
							
							AADD(_aTex, "Lote Final: " + _cLote )
							
						EndIf
						
					EndDo
					
					If _lArq
						
						U_Fecha_TXT()
						
					EndIf
					
					(_cAlias)->(DbCloseArea())
					
					//--------------------------------------------------------------------------------
					//Gerado ou nใo o arquivo ao final serแ exibido uma tela contendo os lotes.
					//--------------------------------------------------------------------------------
					FORMBATCH(_cTit, _aTex, _aBot)
					
				EndIf
				
			Endif
			
			
		ElseIf MV_PAR02 == "1031" //INTEGRAL
			
			
			_cQuery := " BEGIN " + CRLF
			_cQuery += " SIGA.CARGA_TABS_RECIPROCIDADE('" + _cEmpOri + "','" + _cEmpDes + "','" + _cCNPJOri + "','" + _cCNPJDes + "','00106891','00106891'); " + CRLF
			_cQuery += " COMMIT; " + CRLF
			_cQuery += " END; " + CRLF
			
			If TCSQLExec( _cQuery ) < 0
				
				Aviso("Aten็ใo","Nใo foi possํvel realizar o processamento.",{"OK"})
				
			Else
				
				Aviso("Aten็ใo","Processamento finalizado.",{"OK"})
				
			Endif
			
			
		EndIf
		
	EndIf
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA609D  บAutor  ณAngelo Henrique     บ Data ณ  05/03/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela execu็ใo da marca็ใo dos lotes que  บฑฑ
ฑฑบ          ณforam gerados.                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA609D
	
	Local _aArea		:= GetArea()
	Local _cAlias 		:= GetNextAlias()
	Local _cQuery 		:= ""
	Local _lAchou		:= .T.
	
	Private _cEmpOri	:= ""
	Private _cEmpDes	:= ""
	Private _cCNPJOri	:= ""
	Private _cCNPJDes	:= ""
	Private _cPerg		:= "CABA609D"
	
	//-------------------------------------------------------------------------------------------------
	//Cria grupo de perguntas
	//-------------------------------------------------------------------------------------------------
	CABA609E(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		If MV_PAR01 != "0001"
			
			Aviso("Aten็ใo","Empresa de Origem deve ser obrigatoriamente a CABERJ.",{"OK"})
			
			_lAchou := .F.
			
		Else
			
			DbSelectArea("BA0")
			DbSetOrder(1)
			If DbSeek(xFilial("BA0") + MV_PAR01 )
				
				If BA0->(BA0_CODIDE+BA0_CODINT) = "0001"
					
					_cEmpOri := "CABERJ" //Chumbado porque no registro esta com o nome completo da CABERJ
					
				ElseIf BA0->(BA0_CODIDE+BA0_CODINT) = "1031"
					
					_cEmpOri := "INTEGRAL" //Chumbado porque no registro esta com o nome completo da INTEGRAL
					
				Else
					
					_cEmpOri := AllTrim(BA0->BA0_NOMINT	)
					
				EndIf
				
				_cCNPJOri	:= AllTrim(BA0->BA0_CGC		)
				
			Else
				
				_lAchou := .F.
				
				Aviso("Aten็ใo","Operadora origem digitada nใo foi encontrada no cadastro de operadoras.",{"OK"})
				
			EndIf
			
		EndIf
		
		//------------------------------------------------------------------
		//S๓ consulta a empresa destino se a origem estiver correta
		//------------------------------------------------------------------
		If _lAchou
			
			DbSelectArea("BA0")
			DbSetOrder(1)
			If DbSeek(xFilial("BA0") + MV_PAR02 )
				
				If BA0->(BA0_CODIDE+BA0_CODINT) = "0001"
					
					_cEmpDes := "CABERJ" //Chumbado porque no registro esta com o nome completo da CABERJ
					
				ElseIf BA0->(BA0_CODIDE+BA0_CODINT) = "1031"
					
					_cEmpDes := "INTEGRAL" //Chumbado porque no registro esta com o nome completo da INTEGRAL
					
				Else
					
					_cEmpDes := AllTrim(BA0->BA0_NOMINT	)
					
				EndIf
				
				_cCNPJDes	:= AllTrim(BA0->BA0_CGC		)
				
			Else
				
				_lAchou := .F.
				
				Aviso("Aten็ใo","Operadora destino digitada nใo foi encontrado no cadastro de operadoras.",{"OK"})
				
			EndIf
			
		EndIf
		
		//--------------------------------------------------------------------------------------------------
		//Ap๓s passar por todas as valida็๕es, se estiver OK irแ prosseguir com o processamento
		//--------------------------------------------------------------------------------------------------
		If _lAchou
			
			_cQuery := " UPDATE  																	" + CRLF
			_cQuery += " 	RECIPR_LOTE RCPLOTE   													" + CRLF
			
			If MV_PAR05 = 1 //MARCAR
				
				_cQuery += " 	SET RCPLOTE.XML_GERADO = 'S'  										" + CRLF
				
			Else //DESMARCAR
				
				_cQuery += " 	SET RCPLOTE.XML_GERADO = 'N'  										" + CRLF
				
			EndIf
			
			_cQuery += " WHERE  																	" + CRLF
			_cQuery += " 	RCPLOTE.OPERADORA_ORIGEM  		= '" + _cEmpOri  + "'   				" + CRLF
			_cQuery += " 	AND RCPLOTE.OPERADORA_DESTINO 	= '" + _cEmpDes  + "' 					" + CRLF
			_cQuery += " 	AND RCPLOTE.CNPJ_ORIGEM  		= '" + _cCNPJOri + "'  					" + CRLF
			_cQuery += " 	AND RCPLOTE.CNPJ_DESTINO 		= '" + _cCNPJDes + "'  					" + CRLF
			
			If MV_PAR05 = 1 //MARCAR
				
				_cQuery += " 	AND RCPLOTE.XML_GERADO = 'N'  										" + CRLF
				
			Else //DESMARCAR
				
				_cQuery += " 	AND RCPLOTE.XML_GERADO = 'S'  										" + CRLF
				
			EndIf
			
			_cQuery += " 	AND RCPLOTE.IDLOTE BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'  	" + CRLF
			
			If TCSQLExec( _cQuery ) < 0
				
				Aviso("Aten็ใo","Nใo foi possํvel realizar o processamento.",{"OK"})
				
			Else
				
				Aviso("Aten็ใo","Processo de marca็ใo de XML finalizado.",{"OK"})
				
			Endif
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA609D  บAutor  ณAngelo Henrique     บ Data ณ  05/03/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas da marca็ใo   บฑฑ
ฑฑบ          ณdos XML.                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABA609E(cGrpPerg)
	
	Local aHelpPor 	:= {} //help da pergunta
	Local _nOper	:= TamSx3("BA0_CODIDE")[1] + TamSx3("BA0_CODINT")[1]
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Operadora de Origem	")
	
	PutSx1(cGrpPerg,"01","Oper. Orig.: ?"			,"a","a","MV_CH1"	,"C",_nOper						,0,0,"G","","BA0XML","","","MV_PAR01",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Operadora de Destino	")
	
	PutSx1(cGrpPerg,"02","Oper. Dest.: ?"			,"a","a","MV_CH2"	,"C",_nOper						,0,0,"G","","BA0XML","","","MV_PAR02",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o Lote					")
	
	PutSx1(cGrpPerg,"03","Lote De: ?"				,"a","a","MV_CH3"	,"C",TamSX3("BDH_NUMFAT")[1]	,0,0,"G","",""		,"","","MV_PAR03",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"04","Lote Ate: ?"				,"a","a","MV_CH4"	,"C",TamSX3("BDH_NUMFAT")[1]	,0,0,"G","",""		,"","","MV_PAR04",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Marcar ou desmarcar Lote.		")
	
	PutSx1(cGrpPerg,"05","Tipo ?"					,"a","a","MV_CH5"	,"N",01							,0,0,"C","",""		,"","","MV_PAR05","Marcar"			,"","","","Desmarcar"				,"","","","","","","","","","","",aHelpPor,{},{},"")
	
Return