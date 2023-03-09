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
±±ºPrograma  ³CABC006   ºAutor  ³Angelo Henrique     º Data ³  25/03/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Consulta Padrão para a listar os tipos de títulos          º±±
±±º          ³de pagamento			                                      º±±
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
	Private _cArqTip	:= GetNextAlias()
	
	SetPrvt("oFont1","oDlg1","oGrp1","oGrp2","oSay1","oBrw1","oBtn1","oBtn2","oBtn3","oBtn4")
	
	Public _cCodTip		:= ""
	
	//-------------------------------------------------------------------------------------------------
	//Montando aqui a Estrutura para receber as informações
	//-------------------------------------------------------------------------------------------------
	AADD(_aStru,{"OK"     		,"C"	,2						,0		})
	AADD(_aStru,{"CODIGO"		,"C"	,TAMSX3("X5_CHAVE" )[1]	,0		})
	AADD(_aStru,{"DESCRICAO" 	,"C"	,TAMSX3("X5_DESCRI")[1]	,0		})
	
	_cArqStru := Criatrab( _aStru , .T.)
	
	//-------------------------------------------------------------------------------------------------
	//Alimenta o arquivo de apoio com os registros da tabela para serem selecionados
	//-------------------------------------------------------------------------------------------------
	
	If Select(_cArqTip) > 0
		
		_cArqTip->(DbCloseArea())
		
	Endif
	
	DBUSEAREA(.T.,,_cArqStru,_cArqTip)
	
	_cQuery := " SELECT 						    " + CRLF
	_cQuery += "     SX5.X5_CHAVE CODIGO,			" + CRLF
	_cQuery += "     TRIM(SX5.X5_DESCRI) DESCRICAO	" + CRLF
	_cQuery += " FROM	                            " + CRLF
	_cQuery += " 	 " + RetSqlName("SX5") + " SX5  " + CRLF
	_cQuery += " WHERE	                            " + CRLF
	_cQuery += "     SX5.X5_TABELA       = '05'	    " + CRLF
	_cQuery += "     AND SX5.D_E_L_E_T_  = ' '	    " + CRLF
	_cQuery += " ORDER BY 	                        " + CRLF
	_cQuery += "     SX5.X5_CHAVE	                " + CRLF
	
	TcQuery _cQuery New Alias (_cAlias)
	
	While !(_cAlias)->(EOF())
		
		DbSelectArea(_cArqTip)
		
		RecLock((_cArqTip),.T.)
		
		(_cArqTip)->CODIGO		:= (_cAlias)->CODIGO
		(_cArqTip)->DESCRICAO	:= (_cAlias)->DESCRICAO
		
		(_cArqTip)->(MsunLock())
		
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
	
	oDlg1      := MSDialog():New( 092,229,563,801,"Seleção de Tipos de Título",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      := TGroup():New( 004,004,224,276,"     Tabela de Tipos de Titulos     ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oGrp2      := TGroup():New( 016,012,036,268,"",oGrp1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	
	oSay1      := TSay():New( 020,016,{||"Favor selecionar os tipos de titulos que serão utilizados no filtro do relatório"},oGrp2,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,236,008)
	
	DbSelectArea(_cArqTip)
	(_cArqTip)->(DbGotop())
	
	oBrw1      := MsSelect():New( _cArqTip,"OK","",aCpoBro,@lInverte,@cMark,{044,012,196,268},,, oGrp1 )
	
	oBrw1:bMark := {| | Disp()}
	
	oBtn1      := TButton():New( 204,012,"OK"				,oGrp1,{||oDlg1:End(),RetTipo()	},036,012,,,,.T.,,"OK"		,,,,.F. )
	oBtn2      := TButton():New( 204,060,"CANCELAR"			,oGrp1,{||oDlg1:End()			},037,012,,,,.T.,,"CANCELAR",,,,.F. )
	oBtn3      := TButton():New( 204,108,"MARCA TODOS"		,oGrp1,{||MarcaTudo()			},049,012,,,,.T.,,"MARCA"	,,,,.F. )
	oBtn4      := TButton():New( 204,168,"DESMARCA TODOS"	,oGrp1,{||DesMcTudo()			},056,012,,,,.T.,,"DESMARCA",,,,.F. )
	
	oDlg1:Activate(,,,.T.)
	
	//-------------------------------------------------------------------------------------------------
	//Fecha a Area e elimina os arquivos de apoio criados em disco.
	//-------------------------------------------------------------------------------------------------
	If Select(_cArqTip) > 0
		
		DbSelectArea(_cArqTip)
		
		DbCloseArea()
		
		Ferase(_cArqStru + OrdBagExt())
		
	Endif
	
	RestArea(_aArTip)
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
	
	RecLock((_cArqTip),.F.)
	
	If Marked("OK")
		
		(_cArqTip)->OK := cMark
		
	Else
		
		(_cArqTip)->OK := ""
		
	Endif
	
	(_cArqTip)->(MsUnlock())
	
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
	
	DbSelectArea(_cArqTip)
	(_cArqTip)->(DbGoTop())
	
	While !(_cArqTip)->(EOF())
		
		RecLock((_cArqTip),.F.)
		
		(_cArqTip)->OK := cMark
		
		(_cArqTip)->(MsUnlock())
		
		(_cArqTip)->(DbSkip())
		
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
	
	DbSelectArea(_cArqTip)
	(_cArqTip)->(DbGoTop())
	
	While !(_cArqTip)->(EOF())
		
		RecLock((_cArqTip),.F.)
		
		(_cArqTip)->OK := ""
		
		(_cArqTip)->(MsUnlock())
		
		(_cArqTip)->(DbSkip())
		
	EndDo
	
	oBrw1:oBrowse:Refresh()
	
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RetTipo   ºAutor  ³Angelo Henrique     º Data ³  08/01/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsavel por tratar os tipos selecionados e       º±±
±±º          ³colocar corretamente no parametro                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RetTipo()
	
	
	Local _aArea	:= GetArea()
	
	DbSelectArea(_cArqTip)
	(_cArqTip)->(DbGoTop())
	
	While !(_cArqTip)->(EOF())
		
		If !(Empty((_cArqTip)->OK))
		
			_cCodTip += AllTrim((_cArqTip)->CODIGO) + ";"
		
		EndIf
		
		(_cArqTip)->(DbSkip())
		
	EndDo
	
	oBrw1:oBrowse:Refresh()
	
	RestArea(_aArea)
	
Return


