#include 'protheus.ch'
#include 'parmtype.ch'

#DEFINE cEnt chr(10)+chr(13)
//*******************************************************************************
//Nome: Mateus Medeiros
//Data:16/08/2017
//Descrição: Geração do número do Protocoloco de Atendimento
//
//*******************************************************************************
user function GerNumPA()
	
	Local _cRet 	:= "" //Irá retornar o protocolo gerado
	Local _cDia	 	:= GetMV("MV_XDIAPA" ) //Possui a data atual da PA
	Local _cCntPA	:= " " //GetMV("MV_XCNTPA" ) //Possui o contador atual da PA
	Local _cRegAns 	:= GetMV("MV_XREGANS") //Possui o número do registro na ANS		
	Local nSeqPA	:= 0
			
	If cValToChar(Day(date())) <> _cDia	
		
		PUTMV("MV_XDIAPA",cValToChar(Day(date())))				
		
		BEGIN TRANSACTION

			//Abrindo a Tabela de Sequencia de PA
			DBSELECTAREA("PE7")
			PE7->(DbSetOrder(1))
			PE7->(DbGoTop())

			//Como a tabela só terá 1 linha SEMPRE não faço While
			If !(PE7->(EOF()))
				Reclock("PE7",.F.)
				PE7->(DbDelete())
				PE7->(MsUnlock())
			EndIf

			PE7->(DbCloseArea())

		END TRANSACTION

		//---------------------------------------------------------------------
		//Alterando para sempre limpar a tabela SZX as numerações criadas
		//onde o usuário estava burlando as validações e não clicando no
		//botão fechar, saindo com a tecla ESC e assim não eliminando
		//o registro no banco
		//---------------------------------------------------------------------
		TCSQLEXEC("DELETE FROM " + RetSqlName("SZX") + " WHERE ZX_DATDE   = ' ' AND  D_E_L_E_T_ = ' '")
		
		//-------------------------------------------------------------------------------------------
		//Deletando as PA's criadas pelo processo de Internação e que não foram concluídas
		//-------------------------------------------------------------------------------------------
		_cCntQry := " AND D_E_L_E_T_ = ' ' AND ZX_USDIGIT = 'SISTEMA' AND ZX_TPINTEL = '2' "
		TCSQLEXEC("DELETE FROM " + RetSqlName("SZX") + " WHERE ZX_DATDE < '" + DTOS(date()) + "' " + _cCntQry)
		
	EndIf

	BEGIN TRANSACTION

		//Abrindo a Tabela de Sequencia de PA
		DBSELECTAREA("PE7")
		PE7->(DbSetOrder(1))
		PE7->(DbGoTop())

		If PE7->(EOF())  
			nSeqPA	:= 1
			Reclock("PE7",.T.)
			PE7->PE7_FILIAL := xFilial("PE7")
			PE7->PE7_CODSEQ := nSeqPA
			PE7->PE7_DATA   := date()
			PE7->(MsUnlock())
		Else
			nSeqPA	:= PE7->PE7_CODSEQ	
			Reclock("PE7",.F.)
			PE7->PE7_CODSEQ := nSeqPA + 1
			PE7->(MsUnlock())
		Endif

		_cCntPA := DTOS(date()) + STRZERO(PE7->PE7_CODSEQ,6)

		PE7->(DbCloseArea())

	END TRANSACTION
	
	_cRet := _cRegAns + alltrim(_cCntPA)
		
	SZX->(DbSetOrder(1))
	//SZY->(DbSetOrder(1))
	
	_lAchou := SZX->(DbSeek( xFilial("SZX") + _cRet)) //.OR. SZY->(DbSeek( xFilial("SZY") + _cRet))
	
	While _lAchou		

		BEGIN TRANSACTION

			//Abrindo a Tabela de Sequencia de PA
			DBSELECTAREA("PE7")
			PE7->(DbSetOrder(1))
			PE7->(DbGoTop())

			If PE7->(EOF())  
				nSeqPA	:= 1
				Reclock("PE7",.T.)
				PE7->PE7_FILIAL := xFilial("PE7")
				PE7->PE7_CODSEQ := nSeqPA
				PE7->PE7_DATA   := date()
				PE7->(MsUnlock())
			Else
				nSeqPA	:= PE7->PE7_CODSEQ	
				Reclock("PE7",.F.)
				PE7->PE7_CODSEQ := nSeqPA + 1
				PE7->(MsUnlock())
			Endif
			
			_cCntPA := DTOS(date()) + STRZERO(PE7->PE7_CODSEQ,6)

			PE7->(DbCloseArea())

		END TRANSACTION	

		_cRet := _cRegAns + alltrim(_cCntPA) /*+ DTOS(dDatabase)*/
		
		//-----------------------------------
		//Cabeçalho
		//-----------------------------------
		SZX->(dbgotop())
		SZX->(DbSetOrder(1))
		
		_lAchou := SZX->(DbSeek( xFilial("SZX") + _cRet))
		/*
		if !_lAchou
			SZY->(dbgotop())
			SZY->(DbSetOrder(1))
			_lAchou := SZX->(DbSeek( xFilial("SZX") + _cRet))
		endif
		*/
	EndDo
	
	IF !_lAchou
		
		//-----------------------------------------------------------------------------
		//Devido ao acontecimento de duplicação de protocolo de atendimento
		//foi necessário criar mais uma validação no momento em que a
		//numeração é gerada, logo crio o registro e caso ele não seja
		//utilizado no cancelar eu deleto ele.
		//-----------------------------------------------------------------------------
		RecLock("SZX", .T.)
		
		SZX->ZX_SEQ := _cRet
		SZX->ZX_TPINTEL	:= '1'
		SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")
		
		SZX->(MsUnLock())
		
		/*
		RecLock("SZY", .T.)
		
		SZY->ZY_SEQBA := _cRet
		
		SZY->(MsUnLock())
		*/
		
	Endif
	
return _cRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvSx1    ºAutor  ³Microsiga           º Data ³  02/28/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina copiada do padrão para alterar/criar as perguntas   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABASX1(cGrupo,cOrdem,cPergunt,cPerSpa,cPerEng,cVar,;
		cTipo ,nTamanho,nDecimal,nPresel,cGSC,cValid,;
		cF3, cGrpSxg,cPyme,;
		cVar01,cDef01,cDefSpa1,cDefEng1,cCnt01,;
		cDef02,cDefSpa2,cDefEng2,;
		cDef03,cDefSpa3,cDefEng3,;
		cDef04,cDefSpa4,cDefEng4,;
		cDef05,cDefSpa5,cDefEng5,;
		aHelpPor,aHelpEng,aHelpSpa,cHelp)
	
	LOCAL aArea := GetArea()
	Local cKey
	Local lPort := .f.
	Local lSpa  := .f.
	Local lIngl := .f.
	
	
	cKey  := "P." + AllTrim( cGrupo ) + AllTrim( cOrdem ) + "."
	
	cPyme    := Iif( cPyme 		== Nil, " ", cPyme		)
	cF3      := Iif( cF3 		== NIl, " ", cF3		)
	cGrpSxg  := Iif( cGrpSxg	== Nil, " ", cGrpSxg	)
	cCnt01   := Iif( cCnt01		== Nil, "" , cCnt01 	)
	cHelp	 := Iif( cHelp		== Nil, "" , cHelp		)
	
	dbSelectArea( "SX1" )
	dbSetOrder( 1 )
	
	// Ajusta o tamanho do grupo. Ajuste emergencial para validação dos fontes.
	// RFC - 15/03/2007
	cGrupo := PadR( cGrupo , Len( SX1->X1_GRUPO ) , " " )
	
	If !( DbSeek( cGrupo + cOrdem ))
		
		cPergunt:= If(! "?" $ cPergunt .And. ! Empty(cPergunt),Alltrim(cPergunt)+" ?",cPergunt)
		cPerSpa	:= If(! "?" $ cPerSpa  .And. ! Empty(cPerSpa) ,Alltrim(cPerSpa) +" ?",cPerSpa)
		cPerEng	:= If(! "?" $ cPerEng  .And. ! Empty(cPerEng) ,Alltrim(cPerEng) +" ?",cPerEng)
		
		Reclock( "SX1" , .T. )
		
		Replace X1_GRUPO   With cGrupo
		Replace X1_ORDEM   With cOrdem
		Replace X1_PERGUNT With cPergunt
		Replace X1_PERSPA  With cPerSpa
		Replace X1_PERENG  With cPerEng
		Replace X1_VARIAVL With cVar
		Replace X1_TIPO    With cTipo
		Replace X1_TAMANHO With nTamanho
		Replace X1_DECIMAL With nDecimal
		Replace X1_PRESEL  With nPresel
		Replace X1_GSC     With cGSC
		Replace X1_VALID   With cValid
		
		Replace X1_VAR01   With cVar01
		
		Replace X1_F3      With cF3
		Replace X1_GRPSXG  With cGrpSxg
		
		If Fieldpos("X1_PYME") > 0
			If cPyme != Nil
				Replace X1_PYME With cPyme
			Endif
		Endif
		
		Replace X1_CNT01   With cCnt01
		If cGSC == "C"			// Mult Escolha
			Replace X1_DEF01   With cDef01
			Replace X1_DEFSPA1 With cDefSpa1
			Replace X1_DEFENG1 With cDefEng1
			
			Replace X1_DEF02   With cDef02
			Replace X1_DEFSPA2 With cDefSpa2
			Replace X1_DEFENG2 With cDefEng2
			
			Replace X1_DEF03   With cDef03
			Replace X1_DEFSPA3 With cDefSpa3
			Replace X1_DEFENG3 With cDefEng3
			
			Replace X1_DEF04   With cDef04
			Replace X1_DEFSPA4 With cDefSpa4
			Replace X1_DEFENG4 With cDefEng4
			
			Replace X1_DEF05   With cDef05
			Replace X1_DEFSPA5 With cDefSpa5
			Replace X1_DEFENG5 With cDefEng5
		Endif
		
		Replace X1_HELP  With cHelp
		
		PutSX1Help(cKey,aHelpPor,aHelpEng,aHelpSpa)
		
		MsUnlock()
	Else
		
		lPort := ! "?" $ X1_PERGUNT .And. ! Empty(SX1->X1_PERGUNT)
		lSpa  := ! "?" $ X1_PERSPA  .And. ! Empty(SX1->X1_PERSPA)
		lIngl := ! "?" $ X1_PERENG  .And. ! Empty(SX1->X1_PERENG)
		
		If lPort .Or. lSpa .Or. lIngl
			RecLock("SX1",.F.)
			If lPort
				SX1->X1_PERGUNT:= Alltrim(SX1->X1_PERGUNT)+" ?"
			EndIf
			If lSpa
				SX1->X1_PERSPA := Alltrim(SX1->X1_PERSPA) +" ?"
			EndIf
			If lIngl
				SX1->X1_PERENG := Alltrim(SX1->X1_PERENG) +" ?"
			EndIf
			SX1->(MsUnLock())
		EndIf
	Endif
	
	RestArea( aArea )
	
Return()
