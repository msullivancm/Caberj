#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABC008   �Autor  �Fabio Bianchini     � Data �  06/07/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Consulta Padr�o para a listar os Status de Recursos        ���
���          � de Glosa       					                          ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CABC008()

	Local _aArea 		:= GetArea()
	Local _aArSX5		:= SX5->(GetArea())
	Local lRet 			:= .T.
	Local _aStru		:= {}
	Local aCpoBro 		:= {}
	Local _cQuery		:= ""
	Local _cAlias		:= GetNextAlias()

	//-------------------------------------------------------------------------------------------------
	// Declara��o de Variaveis Private dos Objetos
	//-------------------------------------------------------------------------------------------------
	Private lInverte	:= .F.
	Private cMark   	:= GetMark()
	Private oBrw1		:= Nil //Cria um arquivo de Apoio
	Private oDlg1		:= Nil
	Private cArquivoTMP	:= "\system\cabc008tmp_" + retcodusr() + ".dtc" //Gera o nome do arquivo 
	Private cIndiceTMP  := "\system\cabc008tmp_" + retcodusr() //indice do arquivo
	Private cRet		:= ""

	SetPrvt("oFont1","oDlg1","oGrp1","oGrp2","oSay1","oBrw1","oBtn1","oBtn2","oBtn3","oBtn4")

	Public _cCodBlq		:= ""

	//--------------------------------------------
	//Caso arquivo tempor�rio exista, excluo antes
	//--------------------------------------------

	if File(cArquivoTMP)
		Ferase(cArquivoTMP)
	Endif
	//-------------------------------------------------------------------------------------------------
	//Montando aqui a Estrutura para receber as informa��es
	//-------------------------------------------------------------------------------------------------
	aAdd(_aStru,{"OK"    		,"C",  02,0})  
	aAdd(_aStru,{"CODIGO"       ,"C",  03,0})  
	aAdd(_aStru,{"DESCRICAO"    ,"C",  20,0})   

	If SELECT("TMP") > 0
		TMP->(dbCloseArea())
	Endif

	//Criar o arquivo Ctree
	dbCreate(cArquivoTMP,_aStru,"CTREECDX")
	dbUseArea(.T.,"CTREECDX",cArquivoTMP,"TMP",.F.,.F.)
	IndRegua( "TMP", cIndiceTMP, "CODIGO",,,"CODIGO" )
	dbClearIndex()
	dbSetIndex(cIndiceTMP + OrdBagExt() )

	//-------------------------------------------------------------------------------------------------
	//Alimenta o arquivo de apoio com os registros da tabela para serem selecionados
	//-------------------------------------------------------------------------------------------------

    //Verifico se o alias est� aberto e fecho
     If ( SELECT("TMP") ) > 0
         dbSelectArea("TMP")
         TMP->(dbCloseArea())
     EndIf

     //abro a tabela Ctree
     dbUseArea( .T.,"CTREECDX", cArquivoTMP,"TMP", .T., .F. )
     dbSelectArea("TMP")
     IndRegua( "TMP", cIndiceTMP, "CODIGO",,,"CODIGO" )
     dbClearIndex()
     dbSetIndex(cIndiceTMP + OrdBagExt() )

     dbSelectArea("TMP")
     TMP->(dbSetOrder(1))
     TMP->(dbGoTop())

	_cQuery := " SELECT 																" + c_ent
	_cQuery += "     SX5.X5_CHAVE CODIGO, 											" + c_ent
	_cQuery += "     SX5.X5_DESCRI DESCRICAO                                         " + c_ent
	_cQuery += " FROM                                                                 " + c_ent
	_cQuery += "     " + RetSqlName("SX5") + " SX5                                    " + c_ent
	_cQuery += " WHERE                                                                " + c_ent
	_cQuery += "         SX5.D_E_L_E_T_ = ' '                                         " + c_ent
	_cQuery += "     AND SX5.X5_TABELA = 'ZL'                                         " + c_ent

	TcQuery _cQuery New Alias (_cAlias)

	While !(_cAlias)->(EOF())

		DbSelectArea("TMP")
		RecLock(("TMP"),.T.)
		TMP->CODIGO		:= (_cAlias)->CODIGO
		TMP->DESCRICAO	:= (_cAlias)->DESCRICAO
		TMP->(MsunLock())
		(_cAlias)->(DbSkip())

	EndDo

	(_cAlias)->(DbCloseArea())

	//-------------------------------------------------------------------------------------------------
	//Definindo aqui as colunas que ser�o exibidas na tela
	//-------------------------------------------------------------------------------------------------
	aCpoBro	:= {{ "OK"	,, "X"          ,"@!"},;
				{ "CODIGO"		,, "CODIGO"     ,"@!"},;
				{ "DESCRICAO"	,, "DESCRICAO"	,"@!"}}

	oFont1     := TFont():New( "MS Sans Serif",0,-13,,.F.,0,,400,.F.,.F.,,,,,, )

	oDlg1      := MSDialog():New( 092,229,563,801,"oDlg1",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      := TGroup():New( 004,004,224,276,"     Status de Recursos de Glosas     ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oGrp2      := TGroup():New( 016,012,036,268,"",oGrp1,CLR_HBLUE,CLR_WHITE,.T.,.F. )

	oSay1      := TSay():New( 020,016,{||"Favor selecionar os status para filtragem"},oGrp2,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,236,008)

	DbSelectArea("TMP")
	TMP->(DbGotop())

	oBrw1      := MsSelect():New( "TMP","OK","",aCpoBro,@lInverte,@cMark,{044,012,196,268},,, oGrp1 )

	oBrw1:bMark := {| | Disp()}

	oBtn1      := TButton():New( 204,012,"OK"				,oGrp1,{||LeMark()		},036,012,,,,.T.,,"OK"		,,,,.F. )
	oBtn2      := TButton():New( 204,060,"CANCELAR"			,oGrp1,{||oDlg1:End()	},037,012,,,,.T.,,"CANCELAR",,,,.F. )	
	oBtn3      := TButton():New( 204,108,"MARCA TODOS"		,oGrp1,{||MarcaTudo()	},049,012,,,,.T.,,"MARCA"	,,,,.F. )
	oBtn4      := TButton():New( 204,168,"DESMARCA TODOS"	,oGrp1,{||DesMcTudo()	},056,012,,,,.T.,,"DESMARCA",,,,.F. )

	oDlg1:Activate(,,,.T.)

	RestArea(_aArSX5)
	RestArea(_aArea)

	SysRefresh(.T.)

Return lRet


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � DISP    � Autor �Fabio Bianchini        � Data �04/01/2018 ���
�������������������������������������������������������������������������Ĵ��
���Locacao   �CABERJ            �Contato �CABERJ                          ���
�������������������������������������������������������������������������Ĵ��
���Descricao �Rotina utilizada para realizar as marca��es na rotina       ���
���          �Marca / Desmarca um registro.                               ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function Disp()
	/*
	RecLock((_aArSX5),.F.)

	If Marked("OK")

	(_aArSX5)->OK := cMark

	Else

	(_aArSX5)->OK := ""

	Endif

	(_aArSX5)->(MsUnlock())
	*/
	RecLock(("TMP"),.F.)

	If Marked("OK")
		TMP->OK := cMark
	Else
		TMP->OK := ""
	Endif

	TMP->(MsUnlock())
	oBrw1:oBrowse:Refresh()

Return()


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MarcaTudo �Autor  �Fabio Bianchini     � Data �  08/01/18   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel pela marca��o de todos os registros na   ���
���          �tela.                                                       ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MarcaTudo()

	Local _aArea	:= GetArea()

	DbSelectArea("TMP")
	TMP->(DbGoTop())

	While !TMP->(EOF())

		RecLock(("TMP"),.F.)
		TMP->OK := cMark
		TMP->(MsUnlock())
		TMP->(DbSkip())

	EndDo

	oBrw1:oBrowse:Refresh()

	RestArea(_aArea)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DesMcTudo �Autor  �Fabio Bianchini     � Data �  08/01/18   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel pela desmarca��o de todos os registros   ���
���          �na tela.                                                    ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function DesMcTudo()

	Local _aArea	:= GetArea()

	DbSelectArea("TMP")
	TMP->(DbGoTop())

	While !TMP->(EOF())

		RecLock(("TMP"),.F.)
		TMP->OK := ""
		TMP->(MsUnlock())
		TMP->(DbSkip())

	EndDo

	oBrw1:oBrowse:Refresh()

	RestArea(_aArea)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �LeMark    �Autor  �Fabio Bianchini     � Data �  08/01/18   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina responsavel por ler a marca��o de todos os           ���
���          �registros na tela.                                                       ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LeMark()

	Local _aArea	:= GetArea()

	DbSelectArea("TMP")
	TMP->(DbGoTop())

	While !TMP->(EOF())

		If !EMPTY(TMP->OK) 
			If Empty(cRet)
				cRet := AllTrim(TMP->CODIGO)
			Else
				cRet += "," + AllTrim(TMP->CODIGO) 
			Endif 
		Endif

		TMP->(DbSkip())

	EndDo
	
	oBrw1:oBrowse:Refresh()
	
	RestArea(_aArea)

	MV_PAR01 := cRet

	oDlg1:End()
	
	SysRefresh(.T.)
	
Return()

