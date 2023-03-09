
#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.CH"

//--------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} NomProgram
DescrFunc
@type function
@ author Autor 
@ version versao
@ since 07/06/2018
@ return Nil
@ obs 
@ sample
..........
Sintaxe: Processa - Di�logo na execu��o de processo monitorado ( bAction [
cTitle ] [ cMsg ] [ lAbort ] ) --> Nil 
Processa( {|| bAction }, cTitle, cMsg,lAbort)
Nome Tipo Descri��o 
bAction Bloco de c�digo Bloco de c�digo contendo a a��o a ser executada
Obrigat�rio 
cTitle Caracter T�tulo do di�logo 
cMsg Caracter Mensagem do dialog 
lAbort L�gico Indica se o processo pode ou n�o ser abortado, o valor padr�o
assumido � .F. 
..........
/*/
//--------------------------------------------------------------------------------------------------------
User Function CargaBR8()
	Local aCampos:={}

	Processa( {|| U_certproc() }, "Aguarde...", "Carregando BTU para BR8...",.F.)

Return Nil
		

User Function certproc()
	
	Local _aArea 	:= GetArea()
	Local cAlias1	:= GetNextAlias()
	Local cAnaSin 	:= '1'
	Local cNivel		:= '4'//"3" TEMPORARIO - Nova mascara da tabela 18,19 e 20
	Local cClasse	:= "000009"
	Local _cTpProc	:= ""
	Local nTot      := 0 	
	Local cCodigo	:= "RE1"
	
	// Query para buscar procedimentos que est�o na BTU e BTQ e n�o est�o em BD4 e BR8
	BeginSql Alias cAlias1
		
		select DISTINCT BTQ_CODTAB,BTQ_CDTERM,BTQ_DESTER,BTQ_VIGDE,BTQ_DATFIM from BTQ010 BTQ
		INNER JOIN BR8010 BR8 ON BR8_CODPSA <> BTQ_CDTERM
		WHERE
		BTQ_CODTAB IN ('18')
		AND BR8.D_E_L_E_T_ = ' ' 
		AND BTQ.D_E_L_E_T_ = ' ' 
		
		/*select DISTINCT BTQ_CODTAB,BTQ_CDTERM,BTQ_DESTER,BTQ_VIGDE,BTQ_DATFIM from BTQ010 BTQ
		INNER JOIN BD4010 BD4 ON BD4_CODPRO <> BTQ_CDTERM
		WHERE
		BTQ_CODTAB IN ('18')
		AND BD4.D_E_L_E_T_ = ' ' 
		AND BTQ.D_E_L_E_T_ = ' ' */
		
	EndSQl
	
	if ( (cAlias1)->(!Eof()) )
		
		dbeval({|| nTot++  },,{||(cAlias1)->(!Eof())})
		
		ProcRegua(nTot)
		
		(cAlias1)->(dbgotop())
		n:= 0 
		do while ( (cAlias1)->(!Eof()) )
			
			n+= 1 
			IncProc("Aguarda a�!! "+cvaltochar(n) +" de "+ cvaltochar(nTot)) 
		
			cCdPaDp := (cAlias1)->BTQ_CODTAB
			cCodPro := (cAlias1)->BTQ_CDTERM
		
			if cCdPaDp == "18" //Material
				_cTpProc:= '3'
			elseif cCdPaDp == "19" //Medicamento
				_cTpProc:= '1'
			else		 //Solucoes...
				_cTpProc:= '2'
			endif
			
			/*BR4->(DbSetOrder(1))
			
			If BR4->(DbSeek(xFilial('BR4') + (cAlias1)->BTQ_CODTAB))
				BF8->(DbSetOrder(2))//BF8_FILIAL, BF8_CODPAD, BF8_CODINT, BF8_CODIGO
				If BF8->(DbSeek(xFilial('BF8') + cCdPaDp + "0001"))
					cCodTab	:= BF8->(BF8_CODINT + BF8_CODIGO)
				Else
					c_MsgLog := 'Tabela [ ' + cCdPaDp + ' ] n�o localizada na tabela de honorarios (BF8)'
					
					//Se n�o encontrar na tabela de honorarios (BF8) n�o inclui
					(cAlias1)-> (DBSKIP())
					Loop
				EndIf
			
			EndIf
			
				BD4->(RecLock("BD4",.T.))
				BD4->BD4_FILIAL := xFilial("BD4")
				BD4->BD4_CODPRO := cCodPro
				BD4->BD4_CODTAB := cCodTab
				BD4->BD4_CDPADP := cCdPaDp
				BD4->BD4_CODIGO := "RE1"
				BD4->BD4_VALREF := 0
				BD4->BD4_PORMED := ""
				BD4->BD4_VLMED  := 0
				BD4->BD4_PERACI := 0
				BD4->BD4_VIGINI := stod((cAlias1)->BTQ_VIGDE)
				BD4->BD4_VIGFIM := stod((cAlias1)->BTQ_DATFIM)
				
				//BD4->BD4_YDTIMP := dDtDigit
				//BD4->BD4_YPERIM := nPercent
				//BD4->BD4_YUSUR  := cUsuario
				//BD4->BD4_YEDICA := Alltrim(TRB->EDBRAS)
				BD4->BD4_YTBIMP := ' '
				
				BD4->(msUnLock())
				
				lBD4		:= .T.*/
		//	Endif
			// GRAVA BR8
			BR8->(DbSetOrder(1))
			If !BR8->(DbSeek(xFilial("BR8") + (cAlias1)->BTQ_CODTAB + (cAlias1)->BTQ_CDTERM ))
				
				RecLock("BR8",.t.)
				//Temporario. So vou importar primeiros arquivos para incluir Brasindice das outras tabelas (18 e 20)
				BR8->BR8_FILIAL := xFilial("BR8")
				BR8->BR8_CODPAD := (cAlias1)->BTQ_CODTAB
				BR8->BR8_CODPSA := (cAlias1)->BTQ_CDTERM
				BR8->BR8_DESCRI := UPPER( Alltrim((cAlias1)->BTQ_DESTER)+Space(1)+Alltrim((cAlias1)->BTQ_DESTER) )
				BR8->BR8_ANASIN := cAnaSin
				BR8->BR8_NIVEL  := cNivel
				BR8->BR8_CLASSE := cClasse
				BR8->BR8_BENUTL := "1"
				BR8->BR8_TPPROC := _cTpProc
				BR8->BR8_AUTORI := "1"
				
				BR8->BR8_LEMBRE	:= ''
				
				BR8->(MSUnLock())
			Endif 	
			
			
			(cAlias1)->(dbSkip())
		EndDo
		
	else
		Aviso("N�o h� registros para serem importados", "N�o h� registros para serem importados",{"OK"})
	endif
	
	
	Aviso( "Terminou BR8 ","",{"ACABOU?"})
	
	RestArea(_aArea)
	
Return