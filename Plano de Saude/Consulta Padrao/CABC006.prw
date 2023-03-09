#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABC006   ºAutor  ³Angelo Henrique     º Data ³  06/07/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Consulta Padrão para a listar de forma sequencial os tipos º±±
±±º          ³de pagamento. Tabela BQL                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABC006()
	
	Local _aArea 		:= GetArea()
	Local lRet 			:= .T.
	
	Local _aStru		:= {}
	Local aCpoBro 		:= {}
	Local _cArqStru		:= Nil
	Local _cQuery		:= ""
	Local _cAlias		:= GetNextAlias()
	
	//-------------------------------------------------------------------------------------------------
	// Declaração de Variaveis Private dos Objetos
	//-------------------------------------------------------------------------------------------------
	Private lInverte	:= .F.
	Private cMark   	:= GetMark()
	Private oBrw1		:= Nil //Cria um arquivo de Apoio
	Private _cArqBQL	:= GetNextAlias()
	
	SetPrvt("oFont1","oDlg1","oGrp1","oGrp2","oSay1","oBrw1","oBtn1","oBtn2","oBtn3","oBtn4")
	
	Public _cCodBlq		:= ""
	
	//-------------------------------------------------------------------------------------------------
	//Montando aqui a Estrutura para receber as informações
	//-------------------------------------------------------------------------------------------------
	AADD(_aStru,{"OK"     		,"C"	,2							,0		})
	AADD(_aStru,{"CODIGO"		,"C"	,TAMSX3("BQL_CODIGO")[1]	,0		})
	AADD(_aStru,{"DESCRICAO" 	,"C"	,TAMSX3("BQL_DESCRI")[1]	,0		})
	
	_cArqStru := Criatrab( _aStru , .T.)
	
	//-------------------------------------------------------------------------------------------------
	//Alimenta o arquivo de apoio com os registros da tabela para serem selecionados
	//-------------------------------------------------------------------------------------------------
	
	If Select(_cArqBQL) > 0
		
		_cArqBQL->(DbCloseArea())
		
	Endif
	
	DBUSEAREA(.T.,,_cArqStru,_cArqBQL)
	
	_cQuery := " SELECT 						                    " + CRLF
	_cQuery += " 	BQL.BQL_CODIGO CODIGO,                          " + CRLF
	_cQuery += " 	BQL.BQL_DESCRI DESCRICAO                    	" + CRLF
	_cQuery += " 	FROM                                            " + CRLF
	_cQuery += " 	    " + RetSqlName("BQL") + " BQL               " + CRLF
	_cQuery += " 	WHERE                                           " + CRLF
	_cQuery += " 	    BQL.BQL_FILIAL = '" + xFilial("BQL") + "'	" + CRLF
	_cQuery += " 	    AND BQL.D_E_L_E_T_ = ' '                    " + CRLF
	_cQuery += " 	ORDER BY                                        " + CRLF
	_cQuery += " 	    BQL.BQL_CODIGO                              " + CRLF
	
	TcQuery _cQuery New Alias (_cAlias)
	
	While !(_cAlias)->(EOF())
		
		DbSelectArea(_cArqBQL)
		
		RecLock((_cArqBQL),.T.)
		
		(_cArqBQL)->CODIGO		:= (_cAlias)->CODIGO
		(_cArqBQL)->DESCRICAO	:= (_cAlias)->DESCRICAO
		
		(_cArqBQL)->(MsunLock())
				
		(_cAlias)->(DbSkip())
		
	EndDo
	
	(_cAlias)->(DbCloseArea())
	
	//-------------------------------------------------------------------------------------------------
	//Definindo aqui as colunas que serão exibidas na tela
	//-------------------------------------------------------------------------------------------------
	aCpoBro	:= {{ "OK"	,, "X"          ,"@!"},;
		{ "CODIGO"		,, "CODIGO"     ,"@!"},;
		{ "DESCRICAO"	,, "DESCRICAO"	,"@!"}}
		
	oFont1     := TFont():New( "MS Sans Serif",0,-13,,.F.,0,,400,.F.,.F.,,,,,, )
	
	oDlg1      := MSDialog():New( 092,229,563,801,"oDlg1",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      := TGroup():New( 004,004,224,276,"     Tabela de Tipos de Cobrança     ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oGrp2      := TGroup():New( 016,012,036,268,"",oGrp1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	
	oSay1      := TSay():New( 020,016,{||"Favor selecionar os tipos de cobrança que serão utilizados no filtro do relatório"},oGrp2,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,236,008)
	
	DbSelectArea(_cArqBQL)
	(_cArqBQL)->(DbGotop())
	
	oBrw1      := MsSelect():New( _cArqBQL,"OK","",aCpoBro,@lInverte,@cMark,{044,012,196,268},,, oGrp1 )
	
	oBrw1:bMark := {| | Disp()}
	
	oBtn1      := TButton():New( 204,012,"OK"				,oGrp1,{||oDlg1:End()	},036,012,,,,.T.,,"OK"		,,,,.F. )
	oBtn2      := TButton():New( 204,060,"CANCELAR"			,oGrp1,{||oDlg1:End()	},037,012,,,,.T.,,"CANCELAR",,,,.F. )	
	oBtn3      := TButton():New( 204,108,"MARCA TODOS"		,oGrp1,{||MarcaTudo()	},049,012,,,,.T.,,"MARCA"	,,,,.F. )
	oBtn4      := TButton():New( 204,168,"DESMARCA TODOS"	,oGrp1,{||DesMcTudo()	},056,012,,,,.T.,,"DESMARCA",,,,.F. )
	
	oDlg1:Activate(,,,.T.)
	
	//-------------------------------------------------------------------------------------------------
	//Fecha a Area e elimina os arquivos de apoio criados em disco.
	//-------------------------------------------------------------------------------------------------
	If Select(_cArqBQL) > 0
		
		DbSelectArea(_cArqBQL)
		
		DbCloseArea()
		
		Ferase(_cArqStru + OrdBagExt())
		
	Endif
	
RestArea(_aArBQL)
RestArea(_aArea)

Return lRet


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
	
	RecLock((_aArBQL),.F.)
	
	If Marked("OK")
		
		(_aArBQL)->OK := cMark
		
	Else
		
		(_aArBQL)->OK := ""
		
	Endif
	
	(_aArBQL)->(MsUnlock())
	
	oBrw1:oBrowse:Refresh()
	
Return()


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
	
	DbSelectArea(_cArqBQL)
	(_cArqBQL)->(DbGoTop())
	
	While !(_cArqBQL)->(EOF())
		
		RecLock((_cArqBQL),.F.)
		
		(_cArqBQL)->OK := cMark
		
		(_cArqBQL)->(MsUnlock())
		
		(_cArqBQL)->(DbSkip())
		
	EndDo
	
	oBrw1:oBrowse:Refresh()
	
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
	
	DbSelectArea(_cArqBQL)
	(_cArqBQL)->(DbGoTop())
	
	While !(_cArqBQL)->(EOF())
		
		RecLock((_cArqBQL),.F.)
		
		(_cArqBQL)->OK := ""
		
		(_cArqBQL)->(MsUnlock())
		
		(_cArqBQL)->(DbSkip())
		
	EndDo
	
	oBrw1:oBrowse:Refresh()
	
	RestArea(_aArea)
	
Return


