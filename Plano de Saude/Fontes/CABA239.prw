*-----------------------------------*
/*/{Protheus.doc} CABA239

@project Novas Empresas
@description Rotina responsável pela manutenção dos Anexos de Sub-Contratos
@author Rafael Rezende
@since 08/12/2022
@version 1.0		

@return

@see www.rgrsolucoes.com.br/
/*/               

#Include "Protheus.ch"
#Include "TopConn.ch"

User Function CABA239S()

	RPCSetType( 03 )
	RPCSetEnv( "01", "01" )

		ChKFile( "BQC", .T.)
		DbSelectArea( "BQC" )
		BQC->( DbGoTop() ) 
		BQC->( DbSkip() )
		U_CABA239( BQC->( RecNo() ) )

	RPCClearEnv()

Return

*-----------------------------------*
User Function CABA239( nParamRecBQC )
*-----------------------------------*
Private cGetFilial		 	:= ""
Private cGetFilNom 			:= ""
Private cGetCodigo			:= ""
Private cGetNumero   		:= ""
Private cGetVersao 			:= ""
Private cGetSubContrato		:= ""
Private cGetVerSub			:= ""

Private bLinesDocumentos	:= {}
Private aListDocumentos 	:= {}
Private oListDocumentos 	:= {}
Private aTitListDocumentos	:= {}
Private aSizeListDocumentos := {}

Private nPosAnCodigo		:= 01
Private nPosAnTipo 			:= 02 
Private nPosAnDescricao		:= 03 
Private nPosAnUsuario		:= 04 
Private nPosAnNome			:= 05 
Private nPosAnData			:= 06 
Private nPosAnArquivo		:= 07 
Private nPosAnRecNo			:= 08

Private cPathOrigem 		:= AllTrim( GetNewPar( "MV_XANEXOS", "\RGRANEXOS\" ) ) + AllTrim( cEmpAnt ) + AllTrim( cFilAnt ) + "\"
Private cPathDestino 		:= AllTrim( GetNewPar( "MV_XTMPANE", "C:\TEMP\"    ) ) 

SetPrvt( "oDlgAnexo","oGrpTitulo","oSayFilial","oSayNumero","oSayCodigo","oSayFilNome","oSaySubCon","oSayVerSub" ) 
SetPrvt( "oGetFilial","oGetNumero","oGetCodigo","oGetFilNome","oGetSubCon","oGetVerSub","oGrpDoctos" )
SetPrvt( "oBtnIncluir","oBtnExcluir","oBtnVisualizar","oBtnFechar" )

DbSelectArea( "BQC" )
BQC->( DbGoTo( nParamRecBQC ) )
cGetFilial		 	:= BQC->BQC_FILIAL
cGetFilNom 			:= ""
cGetCodigo			:= BQC->BQC_CODIGO
cGetNumero   		:= BQC->BQC_NUMCON
cGetVersao 			:= BQC->BQC_VERCON
cGetSubContrato		:= BQC->BQC_SUBCON
cGetVerSub			:= BQC->BQC_VERSUB
cGetFilNome 		:= FWFilialName( cEmpAnt, cGetFilial, 2 )
                                
//Inicializa a Grid com uma Linha em Branco 
aListDocumentos 	:= {}
aAdd( aListDocumentos, { "" , ; // 1-Codigo
	  					 "" , ; // 2-Tipo
	  					 "" , ; // 3-Descrição
	  					 "" , ; // 4-Usuário
	  					 "" , ; // 5-Nome Usuário
	  					 CToD( "  /  /    " ) , ; // 6-Data
	  					 "" , ; // 7-Arquivo
	  					0	} ) // 8-Recno do Registro

MsgRun( "Carregando anexos, aguarde...", "Carregando anexos, aguarde...", { || FCarregaAnexos( .F. ) } )
                                
// Monta os Títulos da Grid
aTitListDocumentos  := {}
aSizeListDocumentos := {}       
aAdd( aTitListDocumentos , "CODIGO"			)
aAdd( aSizeListDocumentos, GetTextWidth( 0, "BBBBB" ) )
aAdd( aTitListDocumentos , "TIPO"			)
aAdd( aSizeListDocumentos, GetTextWidth( 0, "BBBBBB" ) )
aAdd( aTitListDocumentos , "DESCRIÇÃO" 			)
aAdd( aSizeListDocumentos, GetTextWidth( 0, "BBBBBBBBBBBBBBBB" ) )
aAdd( aTitListDocumentos , "USUÁRIO" 			)
aAdd( aSizeListDocumentos, GetTextWidth( 0, "BBBBBB" ) )
aAdd( aTitListDocumentos , "NOME USUÁRIO" 			)
aAdd( aSizeListDocumentos, GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBB" ) )
aAdd( aTitListDocumentos , "DATA INCLUSÃO" 			)
aAdd( aSizeListDocumentos, GetTextWidth( 0, "BBBBBB" ) )
aAdd( aTitListDocumentos , "ARQUIVO" 			)
aAdd( aSizeListDocumentos, GetTextWidth( 0, "BBBBBBBBBB" ) )

// 						   MsDialog():New( [ nTop ], [ nLeft ], [ nBottom ], [ nRight ], [ cCaption ], [ uParam6 ], [ uParam7 ], [ uParam8 ], [ uParam9 ], [ nClrText ], [ nClrBack ], [ uParam12 ], [ oWnd ], [ lPixel ], [ uParam15 ], [ uParam16 ], [ uParam17 ], [ lTransparent ] )
oDlgAnexo  					:= MSDialog():New( 138,254,493+22,902,"Manutenção de Anexos Sub-Contrato",,,.F.,,,,,,.T.,,,.F. )

						// TGroup():New( [ nTop ], [ nLeft ], [ nBottom ], [ nRight ], [ cCaption ], [ oWnd ], [ nClrText ], [ nClrPane ], [ lPixel ], [ uParam10 ] )
//oGrpSubCon   				:= TGroup():New( 002,008,060+22,255," Informações do Sub-Contrato ",oDlgAnexo,CLR_HBLUE,CLR_WHITE,.T.,.F. )
oGrpSubCon   				:= TGroup():New( 002,008,060,255," Informações do Sub-Contrato ",oDlgAnexo,CLR_HBLUE,CLR_WHITE,.T.,.F. )

oSayFilial					:= TSay():New( 012,016,{||"Filial:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oGetFilial 					:= TGet():New( 020,016,,oGrpSubCon,020,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetFilial",,)
oGetFilial:bSetGet 			:= {|u| If(PCount()>0,cGetFilial:=u,cGetFilial)}
oGetFilial:bWhen 			:= { || .F. }

oSayFilNome 				:= TSay():New( 012,040,{||"Nome Filial:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,035,008)
oGetFilNome 				:= TGet():New( 020,040,,oGrpSubCon,090,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetFilNome",,)
oGetFilNome:bSetGet 		:= {|u| If(PCount()>0,cGetFilNome:=u,cGetFilNome)}
oGetFilNome:bWhen 			:= { || .F. }

oSayCodigo 					:= TSay():New( 012,140,{||"Codigo:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,030,008)
oGetCodigo  				:= TGet():New( 020,140,,oGrpSubCon,030,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetCodigo",,)
oGetCodigo:bSetGet 			:= {|u| If(PCount()>0,cGetCodigo:=u,cGetCodigo)}
oGetCodigo:bWhen 			:= { || .F. }

oSayNumero  				:= TSay():New( 012,170+8,{||"Num. Contrato:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oGetNumero   				:= TGet():New( 020,170+8,,oGrpSubCon,050,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetNumero",,)
oGetNumero:bSetGet			:= {|u| If(PCount()>0,cGetNumero:=u,cGetNumero)}
oGetNumero:bWhen 			:= { || .F. }

oSayVersao 					:= TSay():New( 012,213+8+10,{||"Versão:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,030,008)
oGetVersao  					:= TGet():New( 020,213+8+10,,oGrpSubCon,015,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetVersao",,)
oGetVersao:bSetGet 			:= {|u| If(PCount()>0,cGetVersao:=u,cGetVersao)}
oGetVersao:bWhen 				:= { || .F. }

oSaySubCon					:= TSay():New( 034,016,{||"Sub-Contrato:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
oGetSubCon 					:= TGet():New( 042,016,,oGrpSubCon,060,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetSubContrato",,)
oGetSubCon:bSetGet 			:= {|u| If(PCount()>0,cGetSubContrato:=u,cGetSubContrato)}
oGetSubCon:bWhen 			:= { || .F. }

oSayVerSub   				:= TSay():New( 034,082,{||"Versão Sub."},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oGetVerSub   				:= TGet():New( 042,082,,oGrpSubCon,030,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetVerSub",,)
oGetVerSub:bSetGet 			:= {|u| If(PCount()>0,cGetVerSub:=u,cGetVerSub)}
oGetVerSub:bWhen 			:= { || .F. }

//oSayVencReal 				:= TSay():New( 056,185,{||"Vencto Real:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
//oGetVencReal   				:= TGet():New( 064,185,,oGrpSubCon,045,008,'@D',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dGetVencReal",,)

//TGroup():New( [ nTop ], [ nLeft ], [ nBottom ], [ nRight ], [ cCaption ], [ oWnd ], [ nClrText ], [ nClrPane ], [ lPixel ], [ uParam10 ] )
//oGrpDoctos 					:= TGroup():New( 068+22,008,163+22,294," Documentos Anexados ",oDlgAnexo,CLR_HBLUE,CLR_WHITE,.T.,.F. )
oGrpDoctos 					:= TGroup():New( 068,008,163+22,294," Documentos Anexados ",oDlgAnexo,CLR_HBLUE,CLR_WHITE,.T.,.F. )

// TWBrowse(): New ( [ nRow], [ nCol], [ nWidth], [ nHeight], [ bLine], [ aHeaders], [ aColSizes], [ oDlg], [ cField], [ uValue1], [ uValue2], [ bChange], [ bLDblClick], [ bRClick], [ oFont], [ oCursor], [ nClrFore], [ nClrBack], [ cMsg], [ uParam20], [ cAlias], [ lPixel], [ bWhen], [ uParam24], [ bValid], [ lHScroll], [ lVScroll] ) --> oObjeto
//oListDocumentos	 			:= TwBrowse():New( 079, 016, 270, 076,, aTitListDocumentos, aSizeListDocumentos, oGrpDoctos,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
oListDocumentos	 			:= TwBrowse():New( 079, 016, 270, 076+22,, aTitListDocumentos, aSizeListDocumentos, oGrpDoctos,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
oListDocumentos:SetArray( aListDocumentos ) 
bLinesDocumentos 			:= { || {			 aListDocumentos[oListDocumentos:nAt][nPosAnCodigo]   		, ; // 01- Código
										AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnTipo] ) 		, ; // 02- Tipo
										AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnDescricao] ) 	, ; // 03- Descrição
										AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnUsuario] ) 		, ; // 04- Usuário
										AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnNome] ) 		, ; // 05- Nome
										   DToC( aListDocumentos[oListDocumentos:nAt][nPosAnData] ) 		, ; // 06- Data
									   	AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnArquivo]   ) 	} } // 07- Arquivo
oListDocumentos:bLine 		:= bLinesDocumentos
oListDocumentos:bLDblClick 	:= { || MsAguarde( { || FVisualizar( 01) }, "Preparando anexo, aguarde" ) } 
oListDocumentos:Refresh() 


//oBtnInclui 	 				:= TBtnBmp2():New( 150, 610, 018, 015, "UNSELECTALL",,,, { || FIncluiDocumentos() }, oDlgAnexo, "Anexar documentos"  , { || .T. } )
oBtnInclui 	 				:= TBtnBmp2():New( 150, 610, 018, 015, "ADDCONTAINER",,,, { || FIncluiDocumentos() }, oDlgAnexo, "Anexar documentos"  , { || .T. } )
oBtnExclui	 				:= TBtnBmp2():New( 180, 610, 018, 015, "BMPDEL"	  ,,,, { || FExcluir() }, oDlgAnexo, "Exclui documento Anexado"  , { || .T.  } )
oBtnVisual	 				:= TBtnBmp2():New( 210, 610, 018, 015, "ANALITICO"	  ,,,, { || MsAguarde( { || FVisualizar( 02 ) }, "Preparando anexo, aguarde" ) }, oDlgAnexo, "Visualizar documento em Anexo"  , { || .T.  } )
oBtnFechar 					:= TButton():New( 004,261,"Fechar",oDlgAnexo,,052,012,,,,.T.,,"",,,,.F. )
oBtnFechar:bAction 			:= { || oDlgAnexo:End() }

oDlgAnexo:Activate(,,,.T.)

Return

*----------------------------------------*
Static Function FVisualizar( nParamOpcao )
*----------------------------------------*
Default nParamOpcao := 02

If nParamOpcao == 01

	If AllTrim( cGetPath ) != "" 
		
		FShowFile( 0, cGetPath, nParamOpcao )

	Else

		//Aviso( "Atenção", "Selecione um arquivo primeiro!", { "Voltar" } )
		U_RGRAviso( "Atenção", "Selecione um arquivo primeiro!", { "Voltar" } )

	EndIf

Else

	If oListDocumentos:nAt > 0
		
		If oListDocumentos:nAt == 01 
			
			If aListDocumentos[oListDocumentos:nAt][nPosAnRecNo] > 0
				FShowFile( aListDocumentos[oListDocumentos:nAt][nPosAnRecNo], "", nParamOpcao )
			Else
				//Aviso( "Atenção", "Selecione um documento anexo primeiro.", { "Voltar" } ) 
				U_RGRAviso( "Atenção", "Selecione um documento anexo primeiro.", { "Voltar" } ) 
			EndIf
			
		Else
			
			FShowFile( aListDocumentos[oListDocumentos:nAt][nPosAnRecNo], "", nParamOpcao )
		
		EndIf 	
	
	Else
	
		//Aviso( "Atenção", "Selecione um documento anexo primeiro.", { "Voltar" } ) 
		U_RGRAviso( "Atenção", "Selecione um documento anexo primeiro.", { "Voltar" } ) 
	
	EndIf 
/*	
Else

	If aListDocumentos[oListDocumentos:nAt][nPosRecNo] > 0 
		
		If File( cGetPath ) 
			FShowFile( aListDocumentos[oListDocumentos:nAt][nPosRecNo], nParamOpcao )
		Else
			Aviso( "Atenção", "O Arquivo selecionado não foi encontrado.", { "Voltar" } ) 
		EndIf
	
	Else
	
		Aviso( "Atenção", "Selecione um anexo primeiro.", { "Voltar" } ) 
	
	EndIf 
*/
EndIf

Return 

*------------------------------------------------------------------*
Static Function FShowFile( nParamRecNo, cParamArquivo, nParamOpcao )
*------------------------------------------------------------------*
Local cPathDestino  := "c:\temp\"
Local cAuxDrive 		:= ""                             
Local cAuxDiretorio 	:= ""                                 
Local cAuxNome			:= ""                                   
Local cAuxExtensao		:= ""
Default cParamArquivo   := ""            
Default nParamOpcao 	:= 02                         

If nParamOpcao == 01 // Arquivo na Inclusão 

	SplitPath( cParamArquivo, @cAuxDrive, @cAuxDiretorio, @cAuxNome, @cAuxExtensao )
	ShellExecute( "Open", cParamArquivo, " ", cAuxDiretorio, 03 )
	Return

Else

	If nParamRecNo > 0 

		DbSelectArea( "Z03" )
		Z03->( DbGoTo( nParamRecNo ) )
		cAuxArquivo := AllTrim( Z03->Z03_ARQUIV )
		If File( cPathDestino + cAuxArquivo ) 
		
			//If Aviso( "Atenção", "O arquivos que deseja visualizar já existe localmente em seu computador. Deseja prosseguir e sobreescrever esse arquivo?" + CRLF + cPathDestino + cAuxArquivo, { "Sim", "Não" } ) == 01 
			If U_RGRAviso( "Atenção", "O arquivos que deseja visualizar já existe localmente em seu computador. Deseja prosseguir e sobreescrever esse arquivo?<br>" + cPathDestino + cAuxArquivo, { "Sim", "Não" } ) == 01 
				
				FErase( cPathDestino + cAuxArquivo )
				If File( cPathDestino + cAuxArquivo ) 
					//Aviso( "Atenção", "O arquivo local " + cPathDestino + cAuxArquivo + " não pode ser excluído. O mesmo poder estar em uso por outra aplicação. Sendo assim, não será possível a visualização do documento.", { "Voltar" } )
					U_RGRAviso( "Atenção", "O arquivo local " + cPathDestino + cAuxArquivo + " não pode ser excluído. O mesmo poder estar em uso por outra aplicação. Sendo assim, não será possível a visualização do documento.", { "Voltar" } )
					Return
				EndIf
				cAuxDecode64 := DeCode64( Z03->Z03_FILE64, cPathDestino + cAuxArquivo, .F. )
				If File( cPathDestino + cAuxArquivo ) 
					ShellExecute( "Open", cPathDestino + cAuxArquivo, " ", cPathDestino, 03 )
				EndIf
				Return				
				
			Else                 
				
				If U_RGRAviso( "Atenção", "Deseja visualizar o arquivo existente no seu computador?<br>" + cPathDestino + cAuxArquivo, { "Sim", "Não" } ) == 01 
					ShellExecute( "Open", cPathDestino + cAuxArquivo, " ", cPathDestino, 03 )
				EndIf
				Return
		
			EndIf
		
		Else

			cAuxDecode64 := DeCode64( Z03->Z03_FILE64, cPathDestino + cAuxArquivo, .F. )
			If File( cPathDestino + cAuxArquivo ) 
				ShellExecute( "Open", cPathDestino + cAuxArquivo, " ", cPathDestino, 03 )
			EndIf
			Return

		EndIf
	
	EndIf	
	
//Else 
    
	//cAuxDrive := ""                                                      
	//cAuxDir 	:= ""
	//SplitPath( cParamArquivo, @cAuxDrive, @cAuxDir ) 
	//ShellExecute( "Open", cParamArquivo, " ", cAuxDir + cAuxDrive, 03 )

EndIf	

Return


*------------------------*
Static Function FExcluir()
*------------------------*

If AllTrim( BQC->BQC_XAPROV ) == "1" .Or. AllTrim( BQC->BQC_XAPROV ) == "2"
	U_RGRAviso( "Exclusão Não Permitida", "O subcontrato já foi aprovado por pelo menos 1 das 2 áreas de aprovação.", { "Voltar" } )
	Return
EndIf

If oListDocumentos:nAt > 0
	
	If oListDocumentos:nAt == 01 
		
		If AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnCodigo] ) != ""

			If AllTrim( __cUserId ) == AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnUsuario] )
		
				//If Aviso( "Atenção", "Você confirma a exclusão do  Arquivo abaixo: " + CRLF + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnCodigo] ) + " - " + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnDescricao] ) + CRLF + "Arquivo: " + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnArquivo] ), { "Sim", "Não" } ) == 01 
				If U_RGRAviso( "Atenção", "Você confirma a exclusão do  Arquivo abaixo: <br>" + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnCodigo] ) + " - " + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnDescricao] ) + "<br>" + "Arquivo: " + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnArquivo] ), { "Sim", "Não" } ) == 01 
			
					DbSelectArea( "Z03" )
					Z03->( DbGoTo( aListDocumentos[oListDocumentos:nAt][nPosAnRecNo] ) )
					RecLock( "Z03", .F. )
						Z03->Z03_USREXC := __cUserId
						Z03->Z03_DTEXCL := Date()
						//Z03->Z03_HREXCL := Time()
						Z03->( DbDelete() )
					Z03->( MsUnLock() )

				EndIf

			Else 
		
				U_RGRAviso( "Atenção", "Apenas o usuário abaixo poderá excluir este anexo: <br>" + aListDocumentos[oListDocumentos:nAt][nPosAnNome] , { "Voltar" } ) 
			
			EndIF
		
		Else
		
			//Aviso( "Atenção", "Selecione um documento anexo primeiro.", { "Voltar" } ) 
			U_RGRAviso( "Atenção", "Selecione um documento anexo primeiro.", { "Voltar" } ) 
		
		EndIf
		
	Else
	
		If AllTrim( __cUserId ) == AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnUsuario] )

			//If Aviso( "Atenção", "Você confirma a exclusão do Arquivo abaixo: " + CRLF + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnCodigo] ) + " - " + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnDescricao] ) + CRLF + "Arquivo: " + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnArquivo] ), { "Sim", "Não" } ) == 01 
			If U_RGRAviso( "Atenção", "Você confirma a exclusão do Arquivo abaixo: <br>" + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnCodigo] ) + " - " + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnDescricao] ) + "<br>" + "Arquivo: " + AllTrim( aListDocumentos[oListDocumentos:nAt][nPosAnArquivo] ), { "Sim", "Não" } ) == 01 
				
				DbSelectArea( "Z03" )
				Z03->( DbGoTo( aListDocumentos[oListDocumentos:nAt][nPosAnRecNo] ) )
				RecLock( "Z03", .F. )
					Z03->Z03_USREXC := __cUserId
					Z03->Z03_DTEXCL := Date()
					Z03->( DbDelete() )
				Z03->( MsUnLock() )

			EndIf 
		
		Else

			U_RGRAviso( "Atenção", "Apenas o usuário abaixo poderá excluir este anexo: <br>" + aListDocumentos[oListDocumentos:nAt][nPosAnNome] , { "Voltar" } ) 
			
		EndIF

	EndIf 	                                                                                         
	
	MsgRun( "Carregando anexos, aguarde...", "Carregando anexos, aguarde...", { || FCarregaAnexos( .T. ) } )

Else

	//Aviso( "Atenção", "Selecione um documento anexo primeiro.", { "Voltar" } ) 
	U_RGRAviso( "Atenção", "Selecione um documento anexo primeiro.", { "Voltar" } ) 

EndIf 

Return			


*---------------------------------------------*
Static Function FCarregaOAnexos( lParamRefresh )
*---------------------------------------------*
Local aAreaAntes 		:= GetArea()
Local cAliasQry 		:= GetNextAlias()
Local cAuxTabZ04        := RetSQLName( "Z04" )
Local cAuxFilZ04        := XFilial( "Z04" )
Local cQuery 			:= ""
Local nRecNoAnexo  		:= 0
Local lAuxLegenda  		:= .F.
Local lAuxAcao     		:= .F.
Default lParamRefresh  	:= .F.           

aListObrigatorios 		:= {}

cQuery := "		SELECT * " + CRLF
cQuery += "	   	  FROM " + cAuxTabZ04 + CRLF
cQuery += "	     WHERE D_E_L_E_T_ = ' ' " + CRLF
cQuery += "		   AND Z04_FILIAL = '" + cAuxFilZ04 + "' " + CRLF
cQuery += "		   AND Z04_TIPO   = 'O' " + CRLF
cQuery += "	  ORDER BY Z04_CODIGO " + CRLF
If Select( cAliasQry ) > 0 
	( cAliasQry )->( DbCloseArea() )
EndIf
TcQuery cQuery Alias ( cAliasQry ) New 
( cAliasQry )->( DbGoTop() )
Do While !( cAliasQry )->( Eof() )

	nRecNoAnexo  := FRetPossuiAnexo( ( cAliasQry )->Z04_CODIGO ) 
	lAuxLegenda  := ( nRecNoAnexo != 0 )
	lAuxAcao     := ( nRecNoAnexo == 0 )

	aAdd( aListObrigatorios, {  lAuxLegenda						, ; // 01- Legenda
								( cAliasQry )->Z04_CODIGO		, ; // 02- Código
								( cAliasQry )->Z04_TITULO		, ; // 03- Título
								( cAliasQry )->Z04_DESCRICAO 	, ; // 04- Descrição
								lAuxAcao						, ; // 05- Ação
	  						 	( cAliasQry )->Z04_TIPO			, ; // 06- Tipo
							 	( cAliasQry )->R_E_C_N_O_		, ; // 07- RecNo Z04
								nRecnoAnexo 					} ) // 08- RecNo Z03

	DbSelectArea( cAliasQry ) 
	( cAliasQry )->( DbSkip() )
EndDo		    
( cAliasQry )->( DbCloseArea() )

If Len( aListDocumentos ) == 0 

	aAdd( aListObrigatorios, {  .F.		, ; // 01- Legenda
								""		, ; // 02- Código
								""		, ; // 03- Título
								"" 		, ; // 04- Descrição
								.F.		, ; // 05- Ação
	  						 	""		, ; // 06- Tipo
							 	0		, ; // 07- RecNo Z04
							 	0		} ) // 08- RecNo Z03


EndIf                           

If lParamRefresh 

	oListObrigatorios:SetArray( aListObrigatorios ) 
	oListObrigatorios:bLine 	 := bLinesObrigatorios
	oListObrigatorios:Refresh() 
	
EndIf

RestArea( aAreaAntes ) 

Return



*---------------------------------------------*
Static Function FCarregaAAnexos( lParamRefresh )
*---------------------------------------------*
Local aAreaAntes 		:= GetArea()
Local cAliasQry 		:= GetNextAlias()
Local cAuxTabZ04        := RetSQLName( "Z04" )
Local cAuxFilZ04        := XFilial( "Z04" )
Local cQuery 			:= ""
Local nRecNoAnexo  		:= 0
Local lAuxLegenda  		:= .F.
Local lAuxAcao     		:= .F.
Default lParamRefresh  	:= .F.           

aListAplicaveis 		:= {}

cQuery := "		SELECT * " + CRLF
cQuery += "	   	  FROM " + cAuxTabZ04 + CRLF
cQuery += "	     WHERE D_E_L_E_T_ = ' ' " + CRLF
cQuery += "		   AND Z04_FILIAL = '" + cAuxFilZ04 + "' " + CRLF
cQuery += "		   AND Z04_TIPO   = 'A' " + CRLF
cQuery += "	  ORDER BY Z04_CODIGO " + CRLF
If Select( cAliasQry ) > 0 
	( cAliasQry )->( DbCloseArea() )
EndIf
TcQuery cQuery Alias ( cAliasQry ) New 
( cAliasQry )->( DbGoTop() )
Do While !( cAliasQry )->( Eof() )

	nRecNoAnexo  := FRetPossuiAnexo( ( cAliasQry )->Z04_CODIGO )
	lAuxLegenda  := ( nRecNoAnexo != 0 )
	lAuxAcao     := ( nRecNoAnexo == 0 )
	aAdd( aListAplicaveis  , {  lAuxLegenda						, ; // 01- Legenda
								( cAliasQry )->Z04_CODIGO		, ; // 02- Código
								( cAliasQry )->Z04_TITULO		, ; // 03- Título
								( cAliasQry )->Z04_DESCRICAO 	, ; // 04- Descrição
								lAuxAcao						, ; // 05- Ação
	  						 	( cAliasQry )->Z04_TIPO			, ; // 06- Tipo
							 	( cAliasQry )->R_E_C_N_O_		, ; // 07- RecNo Z04
								nRecnoAnexo 					} ) // 08- RecNo Z03

	DbSelectArea( cAliasQry ) 
	( cAliasQry )->( DbSkip() )
EndDo		    
( cAliasQry )->( DbCloseArea() )

If Len( aListAplicaveis ) == 0 

	aAdd( aListAplicaveis  , {  .F.		, ; // 01- Legenda
								""		, ; // 02- Código
								""		, ; // 03- Título
								"" 		, ; // 04- Descrição
								.F.		, ; // 05- Ação
	  						 	""		, ; // 06- Tipo
							 	0		, ; // 07- RecNo Z04
							 	0		} ) // 08- RecNo Z03


EndIf                           

If lParamRefresh 

	oListAplicaveis:SetArray( aListAplicaveis ) 
	oListAplicaveis:bLine 	 := bLinesAplicaveis
	oListAplicaveis:Refresh() 
	
EndIf

RestArea( aAreaAntes ) 

Return


*---------------------------------------------------*
Static Function FRetPossuiAnexo( cParamCodDocumento )
*---------------------------------------------------*
Local aAreaZ03 		:= GetArea()
Local cQuery 		:= ""
Local cAliasZ03 	:= GetNextAlias()
Local cAuxTabZ03 	:= RetSQLName( "Z03" )
Local cAuxFilZ03 	:= XFilial( "Z03" ) 
Local nRetRecNo 	:= 0 

cQuery := "		SELECT R_E_C_N_O_ AS NUMRECZ03 " + CRLF
cQuery += "	   	  FROM " + cAuxTabZ03 + CRLF
cQuery += "		 WHERE D_E_L_E_T_ = ' ' " + CRLF
cQuery += "		   AND Z03_FILIAL	= '" + cAuxFilZ03 				+ "' " + CRLF
cQuery += "		   AND Z03_SUBFIL		= '" + cGetFilial			+ "' " + CRLF
cQuery += "		   AND Z03_SUBCOD		= '" + cGetCodigo			+ "' " + CRLF
cQuery += "		   AND Z03_SUBCON		= '" + cGetNumero 			+ "' " + CRLF
cQuery += "		   AND Z03_SUBVER		= '" + cGetVersao			+ "' " + CRLF
cQuery += "		   AND Z03_SUBSUB		= '" + cGetSubContrato		+ "' " + CRLF
cQuery += "		   AND Z03_SUBVSU		= '" + cGetVerSub			+ "' " + CRLF
cQuery += "		   AND Z03_CODDOC		= '" + cParamCodDocumento   + "' " + CRLF
cQuery += "        AND Z03_TIPO			= 'SU' " 
If Select( cAliasZ03 ) > 0 
	( cAliasZ03 )->( DbCloseArea() )
EndIf
TcQuery cQuery Alias ( cAliasZ03 ) New 
( cAliasZ03 )->( DbGoTop() )
If !( cAliasZ03 )->( Eof() )

	nRetRecNo 	:= ( cAliasZ03 )->NUMRECZ03

EndIf		    
( cAliasZ03 )->( DbCloseArea() )

RestArea( aAreaZ03 )

Return nRetRecNo


*---------------------------------*
Static Function FIncluiDocumentos()
*---------------------------------*
Private aListObrigatorios 		:= {}
Private bLinesObrigatorios		:= {}
Private aTitListObrigatorios	:= {}
Private aSizeListObrigatorios 	:= {}
Private aListAplicaveis 		:= {}
Private bLinesAplicaveis		:= {}
Private aTitListAplicaveis		:= {}
Private aSizeListAplicaveis 	:= {}

Private nPosObLegenda			:= 01
Private nPosObCodigo			:= 02
Private nPosObTitulo			:= 03 
Private nPosObDescricao			:= 04 
Private nPosObAcao				:= 05
Private nPosObTipo				:= 06
Private nPosObRecNo				:= 07 
Private nPosObRecZ03			:= 08 

Private nPosApLegenda			:= 01
Private nPosApCodigo			:= 02
Private nPosApTitulo			:= 03 
Private nPosApDescricao			:= 04 
Private nPosApAcao				:= 05
Private nPosApTipo				:= 06
Private nPosApRecNo				:= 07 
Private nPosApRecZ03			:= 08 

//Private oImgInclui				:= LoadBitmap( GetResources() , "ADDCONTAINER" ) // Visualizar
//Private oImgVisual 				:= LoadBitmap( GetResources() , "ANALITICO"    ) // Incluir 
//Private oImgInclui				:= LoadBitmap( GetResources() , "IMAGE_LUPA"   ) // Visualizar
//Private oImgVisual 				:= LoadBitmap( GetResources() , "MAIS"   ) // Incluir 
Private oImgInclui				:= LoadBitmap( GetResources() , "FOLDER6"   ) // Visualizar
Private oImgVisual 				:= LoadBitmap( GetResources() , "BRW_FIND"   ) // Incluir 
Private oVerde  	   			:= LoadBitmap( GetResources() , "CHECKOK"    ) // Verde
Private oVermelho 				:= LoadBitmap( GetResources() , "BR_CANCEL"  ) // Vermelho
//Private oVerde  	   			:= LoadBitmap( GetResources() , "BR_VERDE"     ) // Verde
//Private oVermelho 				:= LoadBitmap( GetResources() , "BR_VERMELHO"  ) // Vermelho

/*
//IMAGE_LUPA

CHECKED
NOCHECKED_CHILD_15

UNSELECTALL - List

S4WB020N - Incluir 
S4WB059N - Visualizar
S4WB058N - Pasta 

PCOIMG32



OK
LBTIK
LBNO

MAIS
*/


SetPrvt("oDlgAnexSub","oGrpSubContrato","oSayFilial","oSayNome","oSayContrato","oSayVerCon","oSaySubCon","oSayVerSub")
SetPrvt("oGetNome","oGetContrato","oGetVerCon","oGetSubCon","oGetVerSub","oGrpObrigatorio","oListObrigatorios")
SetPrvt("oListAplicavel","oBtnSair","oSayCodigo","oGetCodigo")

aAdd( aListObrigatorios, { 	""	,; // 01- Legenda
							""	,; // 02- Código
							""	,; // 03- Título
							""	,; // 04- Descrição
							0	,; // 06- RecNo Z03
							0	}) // 07- RecNo Z04
aAdd( aListAplicaveis  , { 	""	,; // 01- Legenda
							""	,; // 02- Código
							""	,; // 03- Título
							""	,; // 04- Descrição
							0	,; // 06- RecNo Z03
							0	}) // 07- RecNo Z04

// Monta os Títulos da Grid
aTitListObrigatorios  := {}
aSizeListObrigatorios := {}       
aAdd( aTitListObrigatorios , " "			)
aAdd( aSizeListObrigatorios, GetTextWidth( 0, "BB" ) )
aAdd( aTitListObrigatorios , "CODIGO"			)
aAdd( aSizeListObrigatorios, GetTextWidth( 0, "BBBB" ) )
aAdd( aTitListObrigatorios , "TÍTULO"			)
aAdd( aSizeListObrigatorios, GetTextWidth( 0, "BBBBBBB" ) )
aAdd( aTitListObrigatorios , "DESCRIÇÃO"			)
aAdd( aSizeListObrigatorios, GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" ) )
aAdd( aTitListObrigatorios , "AÇÃO"			)
aAdd( aSizeListObrigatorios, GetTextWidth( 0, "BBBBB" ) )

aTitListAplicaveis  := {}
aSizeListAplicaveis := {}       
aAdd( aTitListAplicaveis , " "			)
aAdd( aSizeListAplicaveis, GetTextWidth( 0, "BB" ) )
aAdd( aTitListAplicaveis , "CODIGO"			)
aAdd( aSizeListAplicaveis, GetTextWidth( 0, "BBBB" ) )
aAdd( aTitListAplicaveis , "TÍTULO"			)
aAdd( aSizeListAplicaveis, GetTextWidth( 0, "BBBBBBB" ) )
aAdd( aTitListAplicaveis , "DESCRIÇÃO"			)
aAdd( aSizeListAplicaveis, GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" ) )
aAdd( aTitListAplicaveis , "AÇÃO"			)
aAdd( aSizeListAplicaveis, GetTextWidth( 0, "BBBBB" ) )

MsgRun( "Carregando anexos, aguarde...", "Carregando anexos, aguarde...", { || FCarregaOAnexos( .F. ) } )
MsgRun( "Carregando anexos, aguarde...", "Carregando anexos, aguarde...", { || FCarregaAAnexos( .F. ) } )

oDlgAnexSub 			:= MsDialog():New( 295,258,844,1278,"Mantenção de Anexos Sub-Contrato",,,.F.,,,,,,.T.,,,.F. )

oGrpSubContrato			:= TGroup():New( 000,008,062,431," Informações Sub-Contrato",oDlgAnexSub,CLR_HBLUE,CLR_WHITE,.T.,.F. )
oSayFilial      		:= TSay():New( 012,016,{||"Filial:"},oGrpSubContrato,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,019,008)
oGetFilial 				:= TGet():New( 020,016,,oGrpSubContrato,017,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetFilial",,)
oGetFilial:bSetGet 		:= {|u| If(PCount()>0,cGetFilial:=u,cGetFilial)}
oGetFilial:bWhen	 	:= { || .F. }

oSayNome   				:= TSay():New( 012,044,{||"Nome Filial:"},oGrpSubContrato,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,053,008)
oGetNome   				:= TGet():New( 020,044,,oGrpSubContrato,200,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetFilNom",,)
oGetNome:bSetGet 		:= {|u| If(PCount()>0,cGetFilNom:=u,cGetFilNom)}
oGetNome:bWhen 			:= { || .F. }

oSayCodigo 				:= TSay():New( 012,252,{||"Código:"},oGrpSubContrato,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oGetCodigo 				:= TGet():New( 020,252,,oGrpSubContrato,047,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetCodigo",,)
oGetCodigo:bSetGet 		:= {|u| If(PCount()>0,cGetCodigo:=u,cGetCodigo)}
oGetCodigo:bWhen 		:= { || .F. }

oSayContrato			:= TSay():New( 012,308,{||"Contrato:"},oGrpSubContrato,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oGetContrato 			:= TGet():New( 020,308,,oGrpSubContrato,069,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetNumero",,)
oGetContrato:bSetGet 	:= {|u| If(PCount()>0,cGetNumero:=u,cGetNumero)}
oGetContrato:bWhen 		:= { || .F. }

oSayVerCon	 			:= TSay():New( 012,386,{||"Versão Contr."},oGrpSubContrato,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,037,008)
oGetVerCon 				:= TGet():New( 020,386,,oGrpSubContrato,036,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetVersao",,)
oGetVerCon:bSetGet 		:= {|u| If(PCount()>0,cGetVersao:=u,cGetVersao)}
oGetVerCon:bWhen 		:= { || .F. }

oSaySubCon 				:= TSay():New( 036,016,{||"Sub-Contrato:"},oGrpSubContrato,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oGetSubCon 				:= TGet():New( 044,016,,oGrpSubContrato,080,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetSubContrato",,)
oGetSubCon:bSetGet 		:= {|u| If(PCount()>0,cGetSubContrato:=u,cGetSubContrato)}
oGetSubCon:bWhen 		:= { || .F. }

oSayVerSub	 			:= TSay():New( 036,105,{||"Versão Sub."},oGrpSubContrato,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,045,008)
oGetVerSub 				:= TGet():New( 044,105,,oGrpSubContrato,036,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetVerSub",,)
oGetVerSub:bSetGet	 	:= {|u| If(PCount()>0,cGetVerSub:=u,cGetVerSub)}
oGetVerSub:bWhen 		:= { || .F. }

oGrpObrigatorios		:= TGroup():New( 068,008,178,497," Documentação Obrigatória ",oDlgAnexSub,CLR_HBLUE,CLR_WHITE,.T.,.F. )
//oListObrigatorios		:= TListBox():New( 078,016,,,473,092,,oGrpObrigatorio,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
oListObrigatorios	 	:= TwBrowse():New( 078, 016, 473, 092,, aTitListObrigatorios, aSizeListObrigatorios, oGrpObrigatorios,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
oListObrigatorios:SetArray( aListObrigatorios ) 

bLinesObrigatorios 				:= { || {		 If( aListObrigatorios[oListObrigatorios:nAt][nPosObLegenda], oVerde, oVermelho )  	, ; // 01- Legenda
											AllTrim( aListObrigatorios[oListObrigatorios:nAt][nPosObCodigo] ) 						, ; // 02- Código
											AllTrim( aListObrigatorios[oListObrigatorios:nAt][nPosObTitulo] ) 						, ; // 03- Título
											AllTrim( aListObrigatorios[oListObrigatorios:nAt][nPosObDescricao] ) 					, ; // 04- Descrição
												 If( aListObrigatorios[oListObrigatorios:nAt][nPosObAcao], oImgIncluir, oImgVisual )} } // 06- Ação
oListObrigatorios:bLine 		:= bLinesObrigatorios
oListObrigatorios:bLDblClick 	:= { || FMarkAnexDoc( oListObrigatorios, aListObrigatorios, nPosObCodigo, nPosObLegenda, nPosObAcao, nPosObRecZ03, nPosObTitulo, 1 ) }
oListObrigatorios:Refresh() 

oGrpAplicaveis 					:= TGroup():New( 184,008,260,497," Documentação Aplicável",oDlgAnexSub,CLR_HBLUE,CLR_WHITE,.T.,.F. )
//oListAplicaveis				:= TListBox():New( 194,016,,,473,059,,oGrpAplicaveis,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
oListAplicaveis	 				:= TwBrowse():New( 194, 016, 473,059,, aTitListAplicaveis, aSizeListAplicaveis, oGrpAplicaveis,,,,,,,,,,,, .F.,, .T.,, .F.,,, )
oListAplicaveis:SetArray( aListAplicaveis ) 
bLinesAplicaveis 				:= { || {			 If( aListAplicaveis[oListAplicaveis:nAt][nPosApLegenda], oVerde, oVermelho )  	, ; // 01- Legenda
												AllTrim( aListAplicaveis[oListAplicaveis:nAt][nPosApCodigo] ) 						, ; // 02- Código
												AllTrim( aListAplicaveis[oListAplicaveis:nAt][nPosApTitulo] ) 						, ; // 03- Título
												AllTrim( aListAplicaveis[oListAplicaveis:nAt][nPosApDescricao] ) 					, ; // 04- Descrição
													 If( aListAplicaveis[oListAplicaveis:nAt][nPosApAcao], oImgIncluir, oImgVisual ) 	} } // 05- Ação
oListAplicaveis:bLine 			:= bLinesAplicaveis
oListAplicaveis:bLDblClick 		:= { || FMarkAnexDoc( oListAplicaveis, aListAplicaveis, nPosApCodigo, nPosApLegenda, nPosApAcao, nPosApRecZ03, nPosApTitulo, 2 ) }
oListAplicaveis:Refresh() 

oBtnSair   						:= TButton():New( 004,437,"Sair",oDlgAnexSub,,060,012,,,,.T.,,"",,,,.F. )
oBtnSair:bAction 				:= { || oDlgAnexSub:End() }

oDlgAnexSub:Activate(,,,.T.)

MsgRun( "Carregando anexos, aguarde...", "Carregando anexos, aguarde...", { || FCarregaAnexos( .T. ) } )

Return

*------------------------------------------------------------------------------------------------------------------------------------------------------------*
Static Function FMarkAnexDoc( oParamObject, aParamList, nParamPosCodigo, nParamPosLegenda, nParamPosAcao, nParamPosRecNo, nParamPosTitulo, nParamTipoLegenda )
*------------------------------------------------------------------------------------------------------------------------------------------------------------*
Local nLinhaGrid 			:= oParamObject:nAt                           
Local lTemLegenda           := 0
Local lTemAcao		        := 0
Default nParamPosLegenda 	:= 0
Default nParamPosAcao 		:= 0 
lTemLegenda         		:= ( nParamPosLegenda > 0 ) 
lTemAcao 					:= ( nParamPosAcao    > 0 ) 

// Linha precisa ser maior que zero
If nLinhaGrid == 0 
	Return 
EndIf 

If Len( aParamList ) == 00 
	Return 
EndIf                     

If ( oParamObject:nColPos == nParamPosLegenda .And. lTemLegenda )
	
	FLegenda( nParamTipoLegenda )	

Else

	If aParamList[nLinhaGrid][nParamPosAcao]
		FIncluir( oParamObject, aParamList, aParamList[nLinhaGrid][nParamPosCodigo], aParamList[nLinhaGrid][nParamPosTitulo] )
	Else
		FVisuGrid( aParamList[nLinhaGrid][nParamPosRecNo] )
	EndIf

EndIf

Return

*-------------------------------------------*
Static Function FLegenda( nParamTipoLegenda )
*-------------------------------------------*
Local cTituloLegenda 	:= Iif( nParamTipoLegenda == 01, "Documentação Obrigatória", "Documentação Aplicável" )
Local aLegenda			:= { { "CHECKOK" 		, "Documento Anexado"  } ,;
					 		 { "BR_CANCEL"	, "Documento Pendente" }  }

BrwLegenda( cTituloLegenda, "Legenda", aLegenda )

Return

*------------------------------------------------------------------------------------*
Static Function FIncluir( oParamObject, aParamList, cParamCodDocumento, cParamTitulo )
*------------------------------------------------------------------------------------*          
Local nAcao				:= 0 
Private cGetCodSeq 		:= GetSXENum( "Z03", "Z03_CODIGO" )
Private cGetDescDoc 	:= cParamTitulo
Private cGetPath	   	:= ""

If AllTrim( BQC->BQC_XAPROV ) == "1" .Or. AllTrim( BQC->BQC_XAPROV ) == "2" .Or. AllTrim( BQC->BQC_XAPROV ) == "3" .Or. AllTrim( BQC->BQC_XAPROV ) == "4"
	U_RGRAviso( "Inclusão Não Permitida", "O subcontrato já foi aprovado por pelo menos 1 das 2 áreas de aprovação.", { "Voltar" } )
	Return 
EndIf

SetPrvt("oDlgIncAnexo","oGrpSubCon",)
SetPrvt("oGrpInfoDoc","oSayCodSeq","oSayDescDoc","oSayPath","oGetCodSeq","oGetDescDoc","oGetPath","oBtnArquivo","oBtnIFechar")
ConfirmSX8()

// 						   	   MsDialog():New( [ nTop ], [ nLeft ], [ nBottom ], [ nRight ], [ cCaption ], [ uParam6 ], [ uParam7 ], [ uParam8 ], [ uParam9 ], [ nClrText ], [ nClrBack ], [ uParam12 ], [ oWnd ], [ lPixel ], [ uParam15 ], [ uParam16 ], [ uParam17 ], [ lTransparent ] )
oDlgIncAnexo  				:= MSDialog():New( 138,254,493-40-22-20,925-35,"Inclusão de Anexo Sub-Contrato",,,.F.,,,,,,.T.,,,.F. )

//oGrpSubCon 					:= TGroup():New( 002,008,060+22,255,"Informações do Título",oDlgIncAnexo,CLR_HBLUE,CLR_WHITE,.T.,.F. )
oGrpSubCon 					:= TGroup():New( 002,008,060,255," Informações do Sub-Contrato ",oDlgIncAnexo,CLR_HBLUE,CLR_WHITE,.T.,.F. )

oSayFilial					:= TSay():New( 012,016,{||"Filial:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,015,008)
oGetFilial 					:= TGet():New( 020,016,,oGrpSubCon,020,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetFilial",,)
oGetFilial:bSetGet 			:= {|u| If(PCount()>0,cGetFilial:=u,cGetFilial)}
oGetFilial:bWhen 			:= { || .F. }

oSayFilNome 				:= TSay():New( 012,040,{||"Nome Filial:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,015,008)
oGetFilNome 				:= TGet():New( 020,040,,oGrpSubCon,090,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetFilNome",,)
oGetFilNome:bSetGet 		:= {|u| If(PCount()>0,cGetFilNome:=u,cGetFilNome)}
oGetFilNome:bWhen 			:= { || .F. }

//#rgr
oSayCodigo 					:= TSay():New( 012,140,{||"Codigo:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,035,008)
oGetCodigo  				:= TGet():New( 020,140,,oGrpSubCon,030,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetCodigo",,)
oGetCodigo:bSetGet 			:= {|u| If(PCount()>0,cGetCodigo:=u,cGetCodigo)}
oGetCodigo:bWhen 			:= { || .F. }

oSayNumero  				:= TSay():New( 012,170+8,{||"Núm. Contrato:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,050,008)
oGetNumero   				:= TGet():New( 020,170+8,,oGrpSubCon,050,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetNumero",,)
oGetNumero:bSetGet			:= {|u| If(PCount()>0,cGetNumero:=u,cGetNumero)}
oGetNumero:bWhen 			:= { || .F. }

oSayVersao 					:= TSay():New( 012,213+8+10,{||"Versão:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,030,008)
oGetVersao					:= TGet():New( 020,213+8+10,,oGrpSubCon,015,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetVersao",,)
oGetVersao:bSetGet 			:= {|u| If(PCount()>0,cGetVersao:=u,cGetVersao)}
oGetVersao:bWhen 			:= { || .F. }

oSaySubCon					:= TSay():New( 034,016,{||"Sub-Contrato:"},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
oGetSubCon 					:= TGet():New( 042,016,,oGrpSubCon,060,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2","cGetSubContrato",,)
oGetSubCon:bSetGet 			:= {|u| If(PCount()>0,cGetSubContrato:=u,cGetSubContrato)}
oGetSubCon:bWhen 			:= { || .F. }

oSayVerSub   				:= TSay():New( 034,072+15,{||"Versão Sub."},oGrpSubCon,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,040,008)
oGetVerSub   				:= TGet():New( 042,072+15,,oGrpSubCon,030,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetVerSub",,)
oGetVerSub:bSetGet 			:= {|u| If(PCount()>0,cGetVerSub:=u,cGetVerSub)}
oGetVerSub:bWhen 			:= { || .F. }

oGrpInfoDo 					:= TGroup():New( 068,008,125,311," Informações do Anexo ",oDlgIncAnexo,CLR_HBLUE,CLR_WHITE,.T.,.F. )

oSayCodSeq    				:= TSay():New( 078,016,{||"Código:"},oGrpInfoDoc,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
oSayDescDoc   				:= TSay():New( 078,061,{||"Descrição do Documento:"},oGrpInfoDoc,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,114,008)
oSayPath      				:= TSay():New( 100,016,{||"Caminho completo para o Arquivo:"},oGrpInfoDoc,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,093,008)
oGetCodSeq 					:= TGet():New( 086,016,,oGrpInfoDoc,036,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetCodSeq",,)
oGetCodSeq:bSetGet 			:= {|u| If(PCount()>0,cGetCodSeq:=u,cGetCodSeq)}
oGetCodSeq:bWhen 			:= { || .F. }

oGetDescDoc 				:= TGet():New( 086,061,,oGrpInfoDoc,242,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetDescDoc",,)
oGetDescDoc:bSetGet 		:= {|u| If(PCount()>0,cGetDescDoc:=u,cGetDescDoc)}
oGetDescDoc:bWhen 			:= { || .F. }

oGetPath  		 			:= TGet():New( 108,016,,oGrpInfoDoc,225,008,'@!',,CLR_RED,CLR_LIGHTGRAY,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGetPath",,)
oGetPath:bSetGet 			:= {|u| If(PCount()>0,cGetPath:=u,cGetPath)}
oGetPath:bWhen 				:= { || .F. }

oBtnArquivo 				:= TButton():New( 108,244,"Selecionar",oGrpInfoDoc,,042,011,,,,.T.,,"",,,,.F. )
oBtnArquivo:bAction 		:= { || FGetFile( "cGetPath", "Todos os Arquivos| *.*", "Selecione o arquivo a Anexar", "C:\", .T. ), oGetPath:Refresh() }
oBtnVisAnexo	 			:= TBtnBmp2():New( 220, 580, 018, 015, "ANALITICO"	  ,,,, { || MsAguarde( { || FVisualizar( 01 ) }, "Preparando documento, aguarde" ) }, oGrpInfoDoc, "Visualizar documento"  , { || .T.  } )
//oBtnVisAnexo	 			:= TBtnBmp2():New( 220+20, 580, 018, 015, "ANALITICO"	  ,,,, { || MsAguarde( { || FVisualizar( 01 ) }, "Preparando documento, aguarde" ) }, oGrpInfoDoc, "Visualizar documento"  , { || .T.  } )

oBtnIConfirmar 				:= TButton():New( 004,259,"Confirmar",oDlgIncAnexo,,052,012,,,,.T.,,"",,,,.F. )
oBtnIConfirmar:bAction 		:= { || nAcao := 01, If( FVldTela(), oDlgIncAnexo:End(), nAcao := 00 ) }

oBtnIFechar 				:= TButton():New( 020,259,"Fechar",oDlgIncAnexo,,052,012,,,,.T.,,"",,,,.F. )
oBtnIFechar:bAction 		:= { || nAcao := 00, oDlgIncAnexo:End() }

FGetFile( "cGetPath", "Todos os Arquivos| *.*", "Selecione o arquivo a Anexar", "C:\", .T. ) 
oGetPath:Refresh()

oDlgIncAnexo:Activate(,,,.T.)            
    
If nAcao == 01 // Gravar                       

	MsAguarde( { || FGrvAnexo( cParamCodDocumento ) }, "Realizando Upload do anexo, aguarde" )
	MsgRun( "Carregando anexos, aguarde...", "Carregando anexos, aguarde...", { || FCarregaOAnexos( .T. ) } )
	MsgRun( "Carregando anexos, aguarde...", "Carregando anexos, aguarde...", { || FCarregaAAnexos( .T. ) } )

EndIf

Return

*---------------------------------------------*
Static Function FGrvAnexo( cParamCodDocumento )
*---------------------------------------------*
Local cAuxDrive 		:= ""                             
Local cAuxDiretorio 	:= ""                                 
Local cAuxNome			:= ""                                   
Local cAuxExtensao		:= ""

SplitPath( cGetPath, @cAuxDrive, @cAuxDiretorio, @cAuxNome, @cAuxExtensao )
cNomeArquivo 			:= cGetCodigo + cAuxExtensao
cAuxEncode64 			:= Encode64(,cGetPath,.F.,.F.)

/*
FWMakeDir( cPathDestino, .T. ) 
If File( cPathDestino + cNomeArquivo )
	FErase( cPathDestino + cNomeArquivo )
EndIf                  

If __CopyFile( cGetPath, cPathDestino + cNomeArquivo )
            
	//Realiza a Gravação e o UpLoad do Documento
	FwMakeDir( cPathOrigem, .T. ) 
	If !CpyT2S( cPathDestino + cNomeArquivo, cPathOrigem )
	
		Aviso( "Atenção", "Não foi possível realizar o UpLoad do arquivo selecionado para o Servidor Protheus." + CRLF + "Contate o Administrador do Sistema.", { "Voltar" } )
		Return 
	
	Else
*/
		//Após Upload do Arquivo, realiza a gravação do Registro 
		

		DbSelectArea( "Z03" ) 
		RecLock( "Z03", .T. ) 
			                               
			Z03->Z03_FILIAL  := XFilial( "Z03" ) 
			Z03->Z03_TIPO	 := "SU"
			Z03->Z03_SUBFIL	 := cGetFilial
			Z03->Z03_SUBCOD  := cGetCodigo
			Z03->Z03_SUBCON	 := cGetNumero
			Z03->Z03_SUBVER  := cGetVersao
			Z03->Z03_SUBSUB  := cGetSubContrato
			Z03->Z03_SUBVSU  := cGetVerSub
			Z03->Z03_CODIGO  := cGetCodSeq
			Z03->Z03_DESCRI  := cGetDescDoc
		    Z03->Z03_ARQUIV  := cNomeArquivo
		    Z03->Z03_USRINC	 := __cUserId
		    Z03->Z03_DTINCL	 := Date()
		    Z03->Z03_USREXC	 := ""
		    Z03->Z03_DTEXCL	 := CToD( "" ) 
			Z03->Z03_FILE64  := cAuxEncode64
			Z03->Z03_CODDOC  := cParamCodDocumento
		
		Z03->( MsUnLock() )	
		//Aviso( "Atenção", "O Documento foi anexado com sucesso!" ) 
		U_RGRAviso( "Atenção", "O Documento foi anexado com sucesso!<br><font color='blue'>" + AllTrim( cGetCodigo ) + " - " + AllTrim( cGetDescDoc ) + "</font>", { "Ok" } ) 

	//EndIf

//EndIf
	
Return                             

*------------------------*
Static Function FVldTela()
*------------------------*
Local lRetA := .T.

If AllTrim( cGetDescDoc ) == ""
	//Aviso( "Atenção", "O campo [ Descrição do Documento ] é obrigatório.", { "Voltar" } ) 
	U_RGRAviso( "Atenção", "O campo [ Descrição do Documento ] é obrigatório.", { "Voltar" } ) 
	lRetA := .F.
EndIf

If lRetA .And. AllTrim( cGetPath ) == ""
	//Aviso( "Atenção", "O campo [ Caminho completo para o Arquivo ] é obrigatório." + CRLF + "Selecione um arquivo primeiro, para prosseguir.", { "Voltar" } ) 
	U_RGRAviso( "Atenção", "O campo [ Caminho completo para o Arquivo ] é obrigatório. <br>" + "Selecione um arquivo primeiro, para prosseguir.", { "Voltar" } ) 
	lRetA := .F.
EndIf
 
If lRetA .And. !File( cGetPath )
	//Aviso( "Atenção", "O Arquivo informado não foi encontrado ou não pode ser acessado." + CRLF + AllTrim( cGetPath ), { "Voltar" } ) 
	U_RGRAviso( "Atenção", "O Arquivo informado não foi encontrado ou não pode ser acessado. <br>" + AllTrim( cGetPath ), { "Voltar" } ) 
	lRetA := .F.
EndIf       

Return lRetA


//  Preencher na Tabela SX1 - >X1_VALID : 
//          IF(ExistBlock("VLSELARQ"),U_VLSELARQ("MV_PAR01","Arquivo Retorno| *.RET","Retorno Extrato Bco","R:\",.F.),.T.)                         
*------------------------------------------------------------------------------*
Static Function FGetFile( _cVariavel, _cFiltro, _cTitulo, _cDirIni, _lEhSalvar )
*------------------------------------------------------------------------------*

/***
 * _________________________________________________________
 * cGetFile(<ExpC1>,<ExpC2>,<ExpN1>,<ExpC3>,<ExpL1>,<ExpN2>)
 * ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 * <ExpC1> - Expressao de filtro
 * <ExpC2> - Titulo da janela
 * <ExpN1> - Numero de mascara default 1 para *.Exe
 * <ExpC3> - Diretório inicial se necessário
 * <ExpL1> - .F. botão salvar - .T. botão abrir
 * <ExpN2> - Mascara de bits para escolher as opções de visualização do objeto (prconst.ch)
 */

/*
Configurações para a Função cGetFile, encontradas no Arquivo PrConst.Ch

#DEFINE GETF_ONLYSERVER                   0
#DEFINE GETF_OVERWRITEPROMPT              1
#DEFINE GETF_MULTISELECT                  2
#DEFINE GETF_NOCHANGEDIR                  4
#DEFINE GETF_LOCALFLOPPY                  8
#DEFINE GETF_LOCALHARD                   16
#DEFINE GETF_NETWORKDRIVE                32
#DEFINE GETF_SHAREAWARE                  64
#DEFINE GETF_RETDIRECTORY               128
*/	

Default _cFiltro   := "Planilha Excel| *.csv"
Default _cTitulo   := "Selecione o Arquivo"
Default _lEhSalvar := .F.
Default _cDirIni   := ""

&( _cVariavel ) := AllTrim( cGetFile( _cFiltro, _cTitulo, , _cDirIni, !_lEhSalvar,, .F. ) )

Return .T.


*--------------------------------------*
Static Function FVisuGrid( nParamRecNo )
*--------------------------------------*

If nParamRecNo > 0
	FShowFile( nParamRecNo, "", 02 )
EndIf

Return 

*---------------------------------------------*
Static Function FCarregaAnexos( lParamRefresh )
*---------------------------------------------*
Local aAreaAntes 		:= GetArea()
Local cAliasQry 		:= GetNextAlias()
Local cAuxTabZ03 		:= RetSQLName( "Z03" ) 
Local cAuxFilZ03		:= XFilial( "Z03" )
Local cQuery 			:= ""
Local cAuxTipo 			:= ""
Local cAuxNome			:= ""
Default lParamRefresh  	:= .F.           

aListDocumentos := {}

cQuery := "		SELECT * "
cQuery += "	   	  FROM " + cAuxTabZ03
cQuery += "		 WHERE D_E_L_E_T_ 		= ' ' "
cQuery += "		   AND Z03_FILIAL		= '" + cAuxFilZ03			+ "' " + CRLF
cQuery += "		   AND Z03_SUBFIL		= '" + cGetFilial			+ "' " + CRLF
cQuery += "		   AND Z03_SUBCOD		= '" + cGetCodigo			+ "' " + CRLF
cQuery += "		   AND Z03_SUBCON		= '" + cGetNumero 			+ "' " + CRLF
cQuery += "		   AND Z03_SUBVER		= '" + cGetVersao			+ "' " + CRLF
cQuery += "		   AND Z03_SUBSUB		= '" + cGetSubContrato		+ "' " + CRLF
cQuery += "		   AND Z03_SUBVSU		= '" + cGetVerSub			+ "' " + CRLF
cQuery += "        AND Z03_TIPO			= 'SU' " 
If Select( cAliasQry ) > 0 
	( cAliasQry )->( DbCloseArea() )
EndIf

TcQuery cQuery Alias ( cAliasQry ) New 
( cAliasQry )->( DbGoTop() )
Do While !( cAliasQry )->( Eof() )

	cAuxTipo := ""
	cAuxNome := UsrFullName( ( cAliasQry )->Z03_USRINC )
	Do Case
		Case AllTrim( ( cAliasQry )->Z03_TIPO ) == "PC"
			cAuxTipo := "Pedido de Compras"
		Case AllTrim( ( cAliasQry )->Z03_TIPO ) == "SU"
			cAuxTipo := "Sub-Contrato"
		Case AllTrim( ( cAliasQry )->Z03_TIPO ) == "FI"
			cAuxTipo := "Financeiro"
		Case AllTrim( ( cAliasQry )->Z03_TIPO ) == "NF"
			cAuxTipo := "Nota Fiscal"
	EndCase			

	aAdd( aListDocumentos, { ( cAliasQry )->Z03_CODIGO 		, ; // 01- Codigo
							 cAuxTipo						, ; // 02- Tipo
	  						 ( cAliasQry )->Z03_DESCRI		, ; // 03- Descrição do Documento
							 ( cAliasQry )->Z03_USRINC		, ; // 04- Usuário
							 cAuxNome						, ; // 05- Nome do Usuário
					   SToD( ( cAliasQry )->Z03_DTINCL )	, ; // 06- Data de Inclusão do Documento
	  						 ( cAliasQry )->Z03_ARQUIV		, ; // 07- Nome do Arquivo
	  						 ( cAliasQry )->R_E_C_N_O_  	} ) // 08- RecNo do Anexo
	
	DbSelectArea( cAliasQry ) 
	( cAliasQry )->( DbSkip() )
EndDo		    
( cAliasQry )->( DbCloseArea() )

If Len( aListDocumentos ) == 0 

	aAdd( aListDocumentos, { "" , ; // 1-Codigo
							"" , ; // 2-Tipo
							"" , ; // 3-Descrição
							"" , ; // 4-Usuário
							"" , ; // 5-Nome Usuário
							CToD( "  /  /    " ) , ; // 6-Data
							"" , ; // 7-Arquivo
							0	} ) // 8-Recno do Registro

EndIf                           

If lParamRefresh 

	oListDocumentos:SetArray( aListDocumentos ) 
	oListDocumentos:bLine 	 := bLinesDocumentos
	oListDocumentos:Refresh() 
	
EndIf

RestArea( aAreaAntes ) 

Return
