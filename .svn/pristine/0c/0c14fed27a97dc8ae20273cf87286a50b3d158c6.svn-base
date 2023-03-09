#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'

/*/

Autor	  : MMT (RGR Consultoria)
-----------------------------------------------------------------------------
Data	  : 19/08/2022
-----------------------------------------------------------------------------
Descricao : Atualização SE5 Apos finalização borderô
-----------------------------------------------------------------------------

/*/

User Function F300SE5

Local aArea    := GETAREA()
Local cModPgto := ""
Local cChave   := ""
Local lAglut   := IIF(mv_par02 == 1,.T.,.F.)

IF type("_HistAgl") = 'U'
    Public _HistAgl := ""
Endif    
	
// Chamado 80431, Tratamento para historico sem o numero do bordero
    
If !SE2->E2_NUMBOR $ _HistAgl .AND. lAglut
        
    _HistAgl += SE2->E2_NUMBOR + "-"
        
Endif    

// Chamado 89116
//Busca modalidade de pagamento no bordero
cChave := XFilial("SEA")+SE2->(E2_NUMBOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)
cModPgto := GetAdvFVal("SEA","EA_TIPOPAG",cChave,1,"")     

//Atualiza o Cadastro de Fornecedores com modalidade PIX
IF cModPgto $ '45_46'
    dbSelectArea("SA2")
    If  dbSeek(xFilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA)
	    If RecLock("SA2")
    		SA2->A2_FORMPAG := '45'
	        MsUnlock( )
	    Endif
    Endif
Endif

RestArea(aArea)

Return(Nil)  

User Function FINM030

	Local aParam    := PARAMIXB
	Local lRet      := .T.
	Local oSubFK5   := " "
	Local cIdPonto  := " "
	Local cIdModel  := " "

    // Chamado 80431, Tratamento para historico sem o numero do bordero

	If aParam <> NIL

		oSubFK5  := aParam[1] //Objeto do formulário ou do modelo, conforme o caso
		cIdPonto := aParam[2] //ID do local de execução do ponto de entrada
		cIdModel := aParam[3] //ID do formulário

		If cIdPonto == "FORMCOMMITTTSPRE" .AND. IsInCallStack("FINA300")
			If cIdModel == "FK5DETAIL" .AND. ALLTRIM(SE5->E5_NATUREZ) == "NATMOVP"   
                If Type("_HistAgl") == "C"
                    IF RECLOCK("SE5",.F.)
                        SE5->E5_HISTOR :=  "BxSispagLt:" + _HistAgl 
                        MsUnlock()
                    Endif
                Endif
				oSubFK5:SetValue( "FK5_HISTOR", "BxSispagLt:"+_HistAgl )
			EndIf
		EndIf

	EndIf

Return lRet
