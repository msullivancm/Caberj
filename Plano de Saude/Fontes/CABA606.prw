#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'APWEBSRV.CH'
#INCLUDE 'AP5MAIL.CH'

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CABA606 ³ Autor ³Angelo Henrique        ³ Data ³03/01/2018 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³CABERJ            ³Contato ³CABERJ                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rotina utilizada para o processo de internação da           ³±±
±±³          ³calendarização na rotina de INTERNAÇÃO (PLS)                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function CABA606()
	
	//-------------------------------------------------------------------------------------------------
	// Declaração de Variaveis Locais
	//-------------------------------------------------------------------------------------------------
	Local _aStru		:= {}
	Local aCpoBro 		:= {}
	Local _nTamSlc		:= 0
	Local _nTamMat		:= 0
	Local _nTamNom		:= 0
	Local _nTamCRa		:= 0
	Local _nTamNRa		:= 0
	Local _cArqStru		:= Nil	
	Local _aCores 		:= {}
	Local _cMsgDt 		:= "Data de Autorizacao: " + DTOC(dDatabase)
	Local _cQuery		:= ""
	Local _cAlias		:= GetNextAlias()
	Local _aArea		:= GetArea()
	Local _aArBE1		:= BE1->(GetArea())
	Local _aArBEA		:= BEA->(GetArea())
	Local _aArB53		:= B53->(GetArea())
	Local _lGrava 		:= .F.	
	Local _nTamOp 		:= TamSX3("BE4_CODOPE")[1] 				//Contador do BE4_CODOPE
	Local _nTamAn 		:= _nTamOp + 1							//Contador do BE4_ANOINT
	Local _nTamMa 		:= _nTamAn + TamSX3("BE4_ANOINT")[1]  	//Contador do BE4_MESINT
	Local _nTamNa 		:= _nTamMa + TamSX3("BE4_MESINT")[1] 	//Contador do BE4_NUMINT
	
	
	//-------------------------------------------------------------------------------------------------
	// Declaração de Variaveis Private dos Objetos
	//-------------------------------------------------------------------------------------------------
	Private lInverte	:= .F.
	Private cMark   	:= GetMark()
	Private oMark		:= Nil //Cria um arquivo de Apoio
	Private _cPerg		:= "CABA606"
	Private _cArqBE4	:= GetNextAlias()
	
	SetPrvt("oFont1","oFont2","oDlg1","oPanel1","oGrp1","oSay1","oSay2","oBrw1","oBtn1","oBtn2","oBtn3","oBtn4","oBtn5","oBtn6")
	
	//-------------------------------------------------------------------------------------------------
	//Cria grupo de perguntas
	//-------------------------------------------------------------------------------------------------
	CABA606A(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		//-------------------------------------------------------------------------------------------------
		//Tamanho do numero da liberação
		//-------------------------------------------------------------------------------------------------
		_nTamSlc += TAMSX3("BE4_CODOPE")[1] 
		_nTamSlc += TAMSX3("BE4_ANOINT")[1]
		_nTamSlc += TAMSX3("BE4_MESINT")[1]
		_nTamSlc += TAMSX3("BE4_NUMINT")[1]
		
		//-------------------------------------------------------------------------------------------------
		//Tamanho do numero da matricula
		//-------------------------------------------------------------------------------------------------
		_nTamMat += TAMSX3("BA1_CODINT")[1]
		_nTamMat += TAMSX3("BA1_CODEMP")[1]
		_nTamMat += TAMSX3("BA1_MATRIC")[1]
		_nTamMat += TAMSX3("BA1_TIPREG")[1]
		_nTamMat += TAMSX3("BA1_DIGITO")[1]
		
		//-------------------------------------------------------------------------------------------------
		//Tamanho do nome do Beneficiário
		//-------------------------------------------------------------------------------------------------
		_nTamNom += TAMSX3("BA1_NOMUSR")[1]
		
		//-------------------------------------------------------------------------------------------------
		//Tamanho do Codigo do Prestador
		//-------------------------------------------------------------------------------------------------
		_nTamCRa += TAMSX3("BE4_CODRDA")[1] + 10
		
		//-------------------------------------------------------------------------------------------------
		//Tamanho do Nome do Prestador
		//-------------------------------------------------------------------------------------------------
		_nTamNRa += TAMSX3("BE4_NOMRDA")[1]
		
		//-------------------------------------------------------------------------------------------------
		//Montando aqui a Estrutura para receber as informações
		//-------------------------------------------------------------------------------------------------
		AADD(_aStru,{"OK"     	,"C"	,2			,0		})
		AADD(_aStru,{"NUM_INT"	,"C"	,_nTamSlc	,0		})
		AADD(_aStru,{"DT_SOLIC" ,"D"	,20			,0		})
		AADD(_aStru,{"DT_PREV"	,"D"	,20			,0		})
		AADD(_aStru,{"MATRIC"	,"C"	,_nTamMat	,0		})
		AADD(_aStru,{"BENEF"	,"C"	,_nTamNom	,0		})
		AADD(_aStru,{"CD_PREST"	,"C"	,_nTamCRa	,0		})
		AADD(_aStru,{"NM_PREST"	,"C"	,_nTamNRa	,0		})
		AADD(_aStru,{"STATUS"	,"C"	,10			,0		}) //Utilizado para a legenda/Cores
		
		_cArqStru := Criatrab( _aStru , .T.)
		
		//-------------------------------------------------------------------------------------------------
		//Alimenta o arquivo de apoio com os registros da tabela para serem selecionados
		//-------------------------------------------------------------------------------------------------
		
		If Select(_cArqBE4) > 0
			
			_cArqBE4->(DbCloseArea())
			
		Endif
		
		DBUSEAREA(.T.,,_cArqStru,_cArqBE4)
		////BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
		_cQuery := " SELECT  																						" + CRLF
		_cQuery += "	BE4.BE4_CODOPE||BE4.BE4_ANOINT||BE4.BE4_MESINT||BE4.BE4_NUMINT INTERNACAO, 					" + CRLF
		_cQuery += "	BE4.BE4_YDTSOL DT_SOLIC, 																	" + CRLF
		_cQuery += "	BE4.BE4_XDTPR DT_PREV, 																		" + CRLF
		_cQuery += "	BE4.BE4_OPEUSR||BE4.BE4_CODEMP||BE4.BE4_MATRIC||BE4.BE4_TIPREG||BE4.BE4_DIGITO MATRICULA, 	" + CRLF
		_cQuery += "	TRIM(BE4.BE4_NOMUSR) BENEF, 																" + CRLF
		_cQuery += "	BE4.BE4_CODRDA CD_PREST, 																	" + CRLF
		_cQuery += "	BE4.BE4_NOMRDA NOME_RDA, 																	" + CRLF
		_cQuery += "	BE4.BE4_XDTLIB DT_LIB   																	" + CRLF
		_cQuery += " FROM 																							" + CRLF
		_cQuery += "	" + RetSqlName('BE4') + " BE4	  															" + CRLF
		_cQuery += "	INNER JOIN 																					" + CRLF
		_cQuery += "		" + RetSqlName('BAU') + " BAU															" + CRLF
		_cQuery += "	ON		 																					" + CRLF
		_cQuery += "		BAU.D_E_L_E_T_ = ' '																	" + CRLF
		_cQuery += "		AND BAU.BAU_FILIAL = '" + xFilial("BAU") + 	"'											" + CRLF
		_cQuery += "		AND BAU.BAU_CODIGO = BE4.BE4_CODRDA														" + CRLF
		_cQuery += "		AND BAU.BAU_TIPPRE NOT IN ('OPE','REC')													" + CRLF 
		_cQuery += " WHERE   																						" + CRLF
		_cQuery += "	BE4.D_E_L_E_T_ = ' '																		" + CRLF
		_cQuery += "	AND BE4.BE4_FILIAL = '" + xFilial("BE4") + 	"' 												" + CRLF		
		_cQuery += "	AND BE4.BE4_CANCEL <> '1'																	" + CRLF // CANCELADO
		_cQuery += "	AND BE4.BE4_AUDITO <> '1'																	" + CRLF // AUDITORIA		
		_cQuery += "	AND BE4.BE4_ANOINT >= '2017'																" + CRLF
		_cQuery += "	AND BE4.BE4_GRPINT <> '5'																	" + CRLF // PSIQUIATRICA
		_cQuery += "	AND BE4.BE4_REGINT <> '3'																	" + CRLF // DOMICILIAR
		_cQuery += "	AND BE4.BE4_SITUAC NOT IN ('2','3')															" + CRLF // SITUAÇÃO DA GUIA
		_cQuery += "	AND BE4.BE4_STATUS <> '3'																	" + CRLF // NÃO AUTORIZADA
		_cQuery += "	AND BE4.BE4_YSOPME IN ('9','B')																" + CRLF // AGUARDANDO LIBERAÇÃO/FORNECIMENTO OPME
				
		//-------------------------------------------------------------------------------------------------
		//Acrescentando aqui os filtros caso sejam selecionados.
		//-------------------------------------------------------------------------------------------------
		If !Empty(AllTrim(MV_PAR01))
			
			_cQuery += "	AND BE4.BE4_CODOPE = '" + SUBSTR(MV_PAR01,1			,TamSX3("BE4_CODOPE")[1]) + "'		" + CRLF
			
			_cQuery += "	AND BE4.BE4_ANOINT = '" + SUBSTR(MV_PAR01,_nTamAn	,TamSX3("BEA_ANOINT")[1]) + "'		" + CRLF
			
			_cQuery += "	AND BE4.BE4_MESINT = '" + SUBSTR(MV_PAR01,_nTamMa	,TamSX3("BEA_MESINT")[1]) + "'		" + CRLF
			
			_cQuery += "	AND BE4.BE4_NUMINT = '" + SUBSTR(MV_PAR01,_nTamNa	,TamSX3("BEA_NUMINT")[1]) + "'		" + CRLF
			
		EndIf
		
		If !Empty(MV_PAR02) .And. !Empty(MV_PAR03)
			
			_cQuery += "	AND BE4.BE4_XDTPR BETWEEN '" + DTOS(MV_PAR02) + "' AND '" + DTOS(MV_PAR03) + "'			" + CRLF
			
		EndIf
		
		If MV_PAR04 = 1
			
			_cQuery += "	AND BE4.BE4_XDTLIB <> ' '																" + CRLF
			
		ElseIf MV_PAR04 = 2
			
			_cQuery += "	AND BE4.BE4_XDTLIB = ' '																" + CRLF
			
		EndIf
		
		TcQuery _cQuery New Alias (_cAlias)
		
		While !(_cAlias)->(EOF())
			
			DbSelectArea("B53")
			DbSetOrder(1) //B53_FILIAL + B53_NUMGUI + B53_ORIMOV
			If DbSeek(xFilial("B53") + (_cAlias)->INTERNACAO + "BE4")
				
				If B53->B53_STATUS = "1"
					
					_lGrava := .T.
					
				EndIf
				
			Else
				
				_lGrava := .T.
				
			EndIf
			
			If _lGrava
				
				DbSelectArea(_cArqBE4)
				
				RecLock((_cArqBE4),.T.)
				
				(_cArqBE4)->NUM_INT		:= (_cAlias)->INTERNACAO
				(_cArqBE4)->DT_SOLIC	:= STOD((_cAlias)->DT_SOLIC)
				(_cArqBE4)->DT_PREV		:= STOD((_cAlias)->DT_PREV)
				(_cArqBE4)->MATRIC		:= (_cAlias)->MATRICULA
				(_cArqBE4)->BENEF		:= (_cAlias)->BENEF
				(_cArqBE4)->CD_PREST	:= (_cAlias)->CD_PREST
				(_cArqBE4)->NM_PREST	:= (_cAlias)->NOME_RDA
				(_cArqBE4)->STATUS  	:= IIF((_cAlias)->DT_LIB = ' ',"0","1" )
				
				(_cArqBE4)->(MsunLock())
				
			EndIf
			
			//-------------------------------------------------------------------------------------------------
			//Restaurando a variável
			//-------------------------------------------------------------------------------------------------
			_lGrava := .F.
			
			(_cAlias)->(DbSkip())
			
		EndDo
		
		(_cAlias)->(DbCloseArea())
		
		//-------------------------------------------------------------------------------------------------
		//Define as cores dos itens de legenda.
		//-------------------------------------------------------------------------------------------------
		_aCores := {}
		
		aAdd(_aCores,{"AllTrim((_cArqBE4)->STATUS) == '0'","BR_VERDE"	})
		aAdd(_aCores,{"AllTrim((_cArqBE4)->STATUS) == '1'","BR_AMARELO"	})
		
		//-------------------------------------------------------------------------------------------------
		//Definindo aqui as colunas que serão exibidas na tela
		//-------------------------------------------------------------------------------------------------
		aCpoBro	:= {{ "OK"	,, "X"           			,"@!"},;
			{ "NUM_INT"		,, "Numero INTERNACAO"      ,"@!"},;
			{ "DT_SOLIC"	,, "Data de Solicitacao"    ,PesqPict("BE4","BE4_YDTSOL")},;
			{ "DT_PREV"		,, "Data Prevista"          ,PesqPict("BE4","BE4_XDTPR ")},;
			{ "MATRIC"		,, "Matricula"   			,PesqPict("BE4","BE4_USUARI")},;
			{ "BENEF"		,, "Beneficiario"   		,PesqPict("BE4","BE4_NOMUSR")},;
			{ "CD_PREST"	,, "Cod. Prestador"   		,PesqPict("BE4","BE4_CODRDA")},;
			{ "NM_PREST"	,, "Nome do Prestador"      ,PesqPict("BE4","BE4_NOMRDA")}}
		
		//-------------------------------------------------------------------------------------------------
		//Definicao do Dialog e todos os seus componentes.
		//-------------------------------------------------------------------------------------------------
		oFont1     	:= TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )
		oFont2     	:= TFont():New( "MS Sans Serif",0,-20,,.T.,0,,700,.F.,.F.,,,,,, )
		
		oDlg1      	:= MSDialog():New( 092,232,581,1365,"Tela de Calendarizacao Internacao",,,.F.,,,,,,.T.,,,.T. )
		
		oPanel1    	:= TPanel():New( 000,000,"",oDlg1,,.F.,.F.,,,560,236,.T.,.F. )
		
		oGrp1      	:= TGroup():New( 004,004,056,556,"   Tela de Internação (Calendarização)   ",oPanel1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
		
		oSay1      	:= TSay():New( 016,140,{||"Selecione os itens e escolha a opção desejada"	},oGrp1,,oFont2,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,264,016)
		oSay2      	:= TSay():New( 036,016,{||_cMsgDt											},oGrp1,,oFont2,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,328,012)
		
		//-------------------------------------------------------------------------------------------------
		//Montando aqui o GRID para selecionar as guias da BEA
		//-------------------------------------------------------------------------------------------------
		DbSelectArea(_cArqBE4)
		(_cArqBE4)->(DbGotop())
		
		oMark 		:= MsSelect():New(_cArqBE4,"OK","",aCpoBro,@lInverte,@cMark,{060,004,208,556},,,oPanel1,,_aCores)
		oMark:bMark := {| | Disp()}
		
		//-------------------------------------------------------------------------------------------------
		//Criação dos botões
		//-------------------------------------------------------------------------------------------------
		oBtn1      := TButton():New( 216,472,"Liberar"				,oPanel1,{||Libera()	}			,037,012,,,,.T.,,"Liberar"		,,,,.F. )
		oBtn2      := TButton():New( 216,516,"Fechar"				,oPanel1,{||oDlg1:End()	}			,037,012,,,,.T.,,"Fechar"		,,,,.F. )
		oBtn3      := TButton():New( 216,364,"Marcar Todos"			,oPanel1,{||MarcaTudo()	}			,041,012,,,,.T.,,"Marcar"		,,,,.F. )
		oBtn4      := TButton():New( 216,300,"Desmarcar Todos"		,oPanel1,{||DesMcTudo()	}			,057,012,,,,.T.,,"Desmarcar"	,,,,.F. )
		oBtn5      := TButton():New( 216,412,"Remover Liberacao"	,oPanel1,{||Remove()	}			,052,012,,,,.T.,,"Remover"		,,,,.F. )
		oBtn6      := TButton():New( 216,252,"Visualizar Guia"		,oPanel1,{||Visual()	}			,041,012,,,,.T.,,"Visualizar"	,,,,.F. )
		
		
		oDlg1:Activate(,,,.T.)
		
		//-------------------------------------------------------------------------------------------------
		//Fecha a Area e elimina os arquivos de apoio criados em disco.
		//-------------------------------------------------------------------------------------------------
		If Select(_cArqBE4) > 0
			
			DbSelectArea(_cArqBE4)
			
			DbCloseArea()
			
			Ferase(_cArqStru + OrdBagExt())
			
		Endif
		
	EndIf
	
	RestArea(_aArB53)
	RestArea(_aArBEA)
	RestArea(_aArBE1)
	RestArea(_aArea	)
	
Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ DISP    ³ Autor ³Angelo Henrique        ³ Data ³04/01/2018 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³CABERJ            ³Contato ³CABERJ                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rotina utilizada para realizar as marcações na rotina       ³±±
±±³          ³Marca / Desmarca um registro.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Disp()
	
	RecLock((_cArqBE4),.F.)
	
	If Marked("OK")
		
		(_cArqBE4)->OK := cMark
		
	Else
		
		(_cArqBE4)->OK := ""
		
	Endif
	
	(_cArqBE4)->(MsUnlock())
	
	oMark:oBrowse:Refresh()
	
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA606A  ºAutor  ³Angelo Henrique     º Data ³  04/01/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela geração das perguntas do programa   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CABA606A(cGrpPerg)
	
	Local aHelpPor 	:= {} //help da pergunta
	Local _nTamSlc	:= 0
	
	//-------------------------------------------------------------------------------------------------
	//Tamanho do numero da liberação
	//-------------------------------------------------------------------------------------------------
	_nTamSlc += TAMSX3("BE4_CODOPE")[1]
	_nTamSlc += TAMSX3("BE4_ANOINT")[1]
	_nTamSlc += TAMSX3("BE4_MESINT")[1]
	_nTamSlc += TAMSX3("BE4_NUMINT")[1]
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o numero da guia	")
	
	PutSx1(cGrpPerg,"01","Guia: ?"			,"a","a","MV_CH1"	,"C",_nTamSlc					,0,0,"G","","","","","MV_PAR01",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe as Datas para pesquisa	")
	AADD(aHelpPor,"De/Ate a ser utilizado.			")
	
	PutSx1(cGrpPerg,"02","Data De ? "		,"a","a","MV_CH2"	,"D",TamSX3("BE4_DTDIGI")[1]	,0,0,"G","","","","","MV_PAR02",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"03","Data Ate ?"		,"a","a","MV_CH3"	,"D",TamSX3("BE4_DTDIGI")[1]	,0,0,"G","","","","","MV_PAR03",""				,"","","",""						,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe o STATUS					")
	
	PutSx1(cGrpPerg,"04","STATUS ?"			,"a","a","MV_CH4"	,"N",1							,0,0,"C","","","","","MV_PAR04","Autorizado"	,"","","","Aguardando Liberacao"	,"","","","","","","","","","","",aHelpPor,{},{},"")
	
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MarcaTudo ºAutor  ³Angelo Henrique     º Data ³  08/01/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela marcação de todos os registros na   º±±
±±º          ³tela.                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MarcaTudo()
	
	Local _aArea	:= GetArea()
	
	DbSelectArea(_cArqBE4)
	(_cArqBE4)->(DbGoTop())
	
	While !(_cArqBE4)->(EOF())
		
		RecLock((_cArqBE4),.F.)
		
		(_cArqBE4)->OK := cMark
		
		(_cArqBE4)->(MsUnlock())
		
		(_cArqBE4)->(DbSkip())
		
	EndDo
	
	oMark:oBrowse:Refresh()
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DesMcTudo ºAutor  ³Angelo Henrique     º Data ³  08/01/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela desmarcação de todos os registros   º±±
±±º          ³na tela.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DesMcTudo()
	
	Local _aArea	:= GetArea()
	
	DbSelectArea(_cArqBE4)
	(_cArqBE4)->(DbGoTop())
	
	While !(_cArqBE4)->(EOF())
		
		RecLock((_cArqBE4),.F.)
		
		(_cArqBE4)->OK := ""
		
		(_cArqBE4)->(MsUnlock())
		
		(_cArqBE4)->(DbSkip())
		
	EndDo
	
	oMark:oBrowse:Refresh()
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Visual    ºAutor  ³Angelo Henrique     º Data ³  08/01/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela visualização do registro selecionadoº±±
±±º          ³na tela.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Visual()
	
	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())	
	Local _aRrAqB	:= (_cArqBE4)->(GetArea())
	
	DbSelectArea("BE4")
	DbSetOrder(2) //BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
	If DbSeek(xFilial("BE4") + (_cArqBE4)->NUM_INT )
		
		PLSA092Mov("BE4",BE4->(Recno()),2)
		
	EndIf
	
	RestArea(_aRrAqB)	
	RestArea(_aArBE4)
	RestArea(_aArea	)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Libera    ºAutor  ³Angelo Henrique     º Data ³  08/01/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela liberação do item selecionado.      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Libera()
	
	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())	
	Local _aRrAqB	:= (_cArqBE4)->(GetArea())
	
	If MsgYesNo("Todos os itens selecionados serão liberados.Deseja continuar?)","Atenção")
		
		DbSelectArea(_cArqBE4)
		(_cArqBE4)->(DbGoTop())
		
		While !(_cArqBE4)->(EOF())
			
			If !(Empty((_cArqBE4)->OK))
				
				DbSelectArea("BE4")
				DbSetOrder(2) //BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
				If DbSeek(xFilial("BE4") + (_cArqBE4)->NUM_INT )
					
					RecLock("BE4", .F.)
					
					BE4->BE4_YSOPME 	:= "A"
					BE4->BE4_XDTLIB 	:= dDataBase
					
					BE4->(MsUnLock())
					
					//Após gravar na tabela atualizo o STATUS
					RecLock((_cArqBE4),.F.)
					
					(_cArqBE4)->STATUS 	:= "1"
					
					(_cArqBE4)->(MsUnlock())

					//---------------------------------------------------------------------------------
					//Angelo Henrique - Data:13/09/2021
					//---------------------------------------------------------------------------------
					//Rotina que irá gerar um novo protocolo e disparar SMS para o beneficiário
					//---------------------------------------------------------------------------------
					u_CABA097(BE4->(BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT), "A")  
					
				EndIf
				
			EndIf
			
			(_cArqBE4)->(DbSkip())
			
		EndDo
		
		Aviso("Atenção","Itens liberados.", {"OK"})
		
	EndIf
	
	oMark:oBrowse:Refresh()
	
	RestArea(_aRrAqB)	
	RestArea(_aArBE4)
	RestArea(_aArea	)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Remove    ºAutor  ³Angelo Henrique     º Data ³  08/01/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel pela remoção da data no item selecionado º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Remove()
	
	Local _aArea	:= GetArea()
	Local _aArBE4	:= BE4->(GetArea())	
	Local _aRrAqB	:= (_cArqBE4)->(GetArea())
	
	If MsgYesNo("Todos os itens selecionados serão colocados em Aguardando Liberação. Deseja continuar?)","Atenção")
		
		DbSelectArea(_cArqBE4)
		(_cArqBE4)->(DbGoTop())
		
		While !(_cArqBE4)->(EOF())
			
			If !(Empty((_cArqBE4)->OK))
				
				DbSelectArea("BE4")
				DbSetOrder(2) //BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
				If DbSeek(xFilial("BE4") + (_cArqBE4)->NUM_INT )
					
					RecLock("BE4", .F.)
					
					BE4->BE4_YSOPME := "9"
					BE4->BE4_XDTLIB := CTOD(" / / ")
					
					BEA->(MsUnLock())
										
					//Após gravar na tabela atualizo o STATUS
					RecLock((_cArqBE4),.F.)
					
					(_cArqBE4)->STATUS 	:= "0"
					
					(_cArqBE4)->(MsUnlock())
					
				EndIf
				
			EndIf
			
			(_cArqBE4)->(DbSkip())
			
		EndDo
		
		Aviso("Atenção","Itens liberados.", {"OK"})
		
	EndIf
	
	oMark:oBrowse:Refresh()
	
	RestArea(_aRrAqB)	
	RestArea(_aArBE4)
	RestArea(_aArea	)
	
Return
