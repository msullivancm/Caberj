#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

Static cEOL := chr(13) + chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA093    บ Autor ณ Angelo Henrique    บ Data ณ  02/05/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para consultar vแrios RPS simultโneamente, com base บฑฑ
ฑฑบ          ณna rotina FISA022(FIS022CRPS).                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABA093()
	
	Local _nOpc			:= 0
	
	Private _cSerie		:= SPACE(TAMSX3("F2_SERIE"	)[1])
	Private _cRPSDe		:= SPACE(TAMSX3("F2_DOC" 	)[1])
	Private _cRPSAte	:= SPACE(TAMSX3("F2_DOC" 	)[1])
	
	Private oFont1		:= Nil
	Private oDlg1		:= Nil
	Private oGrp1		:= Nil
	Private oSay1		:= Nil
	Private oSay2		:= Nil
	Private oSay3		:= Nil
	Private oSay4		:= Nil
	Private oGet1		:= Nil
	Private oGet2		:= Nil
	Private oGet3		:= Nil
	Private oBtn1		:= Nil
	Private oBtn2		:= Nil
	
	Private	aBrowse		:= {}
	
	oFont1     := TFont():New( "MS Sans Serif",0,-13,,.T.,0,,700,.F.,.F.,,,,,, )
	
	oDlg1      := MSDialog():New( 092,232,332,635,"Consulta Multi RPS",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      := TGroup():New( 000,001,116,200,"   Consulta Multi RPS   ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )		
	
	oSay1      := TSay():New( 012,037,{||"Preencha os parametros para prosseguir"},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,148,012)
	oSay2      := TSay():New( 036,021,{||"SERIE"	},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,032,008)
	oSay3      := TSay():New( 057,021,{||"RPS DE"	},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,036,008)
	oSay4      := TSay():New( 077,021,{||"RPS ATE"	},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,036,008)
	
	oGet1      := TGet():New( 036,061,{|u| If(PCount()==0,_cSerie	,_cSerie :=u)},oGrp1,032,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet2      := TGet():New( 056,061,{|u| If(PCount()==0,_cRPSDe	,_cRPSDe :=u)},oGrp1,088,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	oGet3      := TGet():New( 076,061,{|u| If(PCount()==0,_cRPSAte	,_cRPSAte:=u)},oGrp1,088,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
	
	oBtn1      := TButton():New( 096,061,"Pesquisar",oGrp1,{||oDlg1:End(), _nOpc := 1	},037,012,,,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 096,113,"Cancelar"	,oGrp1,{||oDlg1:End()				},037,012,,,,.T.,,"",,,,.F. )
	
	oDlg1:Activate(,,,.T.)
	
	
	If _nOpc = 1
		
		Processa({|| u_CABA093A() }, "Aguarde", "Consultando notas ...", .T.)
		
	EndIf
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA093A   บ Autor ณ Angelo Henrique    บ Data ณ  09/05/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para consultar vแrios RPS simultโneamente, com base บฑฑ
ฑฑบ          ณna rotina FISA022(FIS022CRPS).                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABA093A
	
	Local _cQuery		:= ""
	Local _cAlias		:= GetNextAlias()
	Local cURL			:= PadR(GetNewPar("MV_SPEDURL","http://"),250)
	Local cCodMun		:= SM0->M0_CODMUN
	Local cMsgRet		:= ""
	Local cStatusCon	:= ""
	Local aParam		:= {Space(Len(SF2->F2_SERIE)),Space(Len(SF2->F2_DOC)),Space(Len(SF2->F2_DOC)),Space(14),Space(14)}
	Local aMonitor		:= {}
	
	Private oWS		:= Nil
	
	Private _cCodAut	:= "" 
	Private _cNumNota	:= ""
	Private _cSerNota	:= ""
	Private cStatusCon	:= ""
	
	//-------------------------------------------------------------------
	//Query para pegar aqui as notas que deseja consultar
	//-------------------------------------------------------------------
	_cQuery	:= " SELECT																" + cEOL
	_cQuery	+= " 	SF2.F2_SERIE,													" + cEOL
	_cQuery	+= " 	SF2.F2_DOC														" + cEOL
	_cQuery	+= " FROM																" + cEOL
	_cQuery	+= " " + RetSqlName('SF2') + " SF2 										" + cEOL
	_cQuery	+= " WHERE 																" + cEOL
	_cQuery	+= " 	SF2.F2_SERIE = '" + _cSerie + "' 								" + cEOL
	_cQuery	+= " 	AND SF2.F2_DOC BETWEEN '" + _cRPSDe+ "' AND '" + _cRPSAte + "'	" + cEOL
	_cQuery	+= " 	AND SF2.D_E_L_E_T_ = ' '										" + cEOL
	
	If Select("_cAlias")>0
		_cAlias->(DbCloseArea())
	EndIf
	
	TcQuery _cQuery New Alias _cAlias
	
	ProcRegua(_cAlias->(RecCount()))
	
	While !_cAlias->(EOF())
		
		IncProc()
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Chamada do WebService da NFS-e                       ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		oWS := WsNFSE001():New()
		
		oWS:cUSERTOKEN	:= "TOTVS"
		oWS:cID_ENT		:= cIdEnt
		oWS:_URL		:= AllTrim(cURL)+"/NFSE001.apw"
		oWS:cCODMUN		:= cCodMun
		oWS:cTSSID		:= _cAlias->(F2_SERIE + F2_DOC)
		oWS:cNUMERORPS	:= allTrim( str( val( _cAlias->F2_DOC ) ) )
		oWS:cSERIERPS	:= _cAlias->F2_SERIE
		
		lOk := ExecWSRet(oWS,"TSSConsRPSNFSE")
		If (lOk)
			aParam[1] 	:= _cAlias->F2_SERIE
			aParam[2] 	:= _cAlias->F2_DOC
			aParam[3]	:= _cAlias->F2_DOC
			
			aMonitor	:= WsNFSeMnt( cIdEnt, aParam )
			
			If !Empty(oWS:OWSTSSCONSRPSNFSERESULT:CCODIGOAUTH)
								
				_cCodAut := AllTrim(oWS:OWSTSSCONSRPSNFSERESULT:CCODIGOAUTH)
				
			EndIf
			
			If !Empty(oWS:OWSTSSCONSRPSNFSERESULT:CNOTA)
								
				_cNumNota := AllTrim(oWS:OWSTSSCONSRPSNFSERESULT:CNOTA)
				
			EndIf
			
			If !Empty(oWS:OWSTSSCONSRPSNFSERESULT:CSERIERPS)
								
				_cSerNota := AllTrim(oWS:OWSTSSCONSRPSNFSERESULT:CSERIERPS)
				
			EndIf
			
			If !Empty(oWS:OWSTSSCONSRPSNFSERESULT:CSTATUSNFSE)
				
				If AllTrim(oWS:OWSTSSCONSRPSNFSERESULT:CSTATUSNFSE) == 'A'
					
					cStatusCon := "Autorizado"
					
				ElseIf 	AllTrim(oWS:OWSTSSCONSRPSNFSERESULT:CSTATUSNFSE) == 'N'
					
					cStatusCon := "Normal"
					
				ElseIf 	AllTrim(oWS:OWSTSSCONSRPSNFSERESULT:CSTATUSNFSE) == 'C'
					
					cStatusCon := "Cancelado"
					
				ElseIf 	AllTrim(oWS:OWSTSSCONSRPSNFSERESULT:CSTATUSNFSE) == 'S'
					
					cStatusCon := "Substituido"
					
				ElseIf 	AllTrim(oWS:OWSTSSCONSRPSNFSERESULT:CSTATUSNFSE) == 'I'
					
					cStatusCon := "Inexistente"
					
				Else
					
					cStatusCon := "Outros"
					
				EndIf								
				
			EndIf						
			
			IncProc("RPS: " + _cAlias->(F2_SERIE + F2_DOC) )
			
			//----------------------------------------------------------
			// Vetor com elementos do Browse
			//----------------------------------------------------------
			aAdd(aBrowse,{_cCodAut, _cNumNota, _cSerNota, cStatusCon })
			
		Else						
			
			aAdd(aBrowse,{"Sem Autoriza็ใo", "RPS: " + _cAlias->F2_DOC, _cAlias->F2_SERIE, "Municํpio nใo possui consulta por RPS." })
			
		EndIf
		
		_cAlias->(DbSkip())
		
	EndDo
	
	If Len(aBrowse) > 0
	
		U_CABA093B()
				
		Aviso("Aten็ใo","Processo de Consulta RPS finalizado.",{"OK"})
		
	Else
		
		Aviso("Aten็ใo","Processo de Consulta RPS finalizado, nใo foram consultadas nenhuma nota com ols parโmetros informados.",{"OK"})
		
	EndIf
	
	If Select("_cAlias")>0
		_cAlias->(DbCloseArea())
	EndIf
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA093B   บ Autor ณ Angelo Henrique    บ Data ณ  02/05/19 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para consultar vแrios RPS simultโneamente, com base บฑฑ
ฑฑบ          ณna rotina FISA022(FIS022CRPS).                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABA093B
	
	Local aList 		:= {}
	
	DEFINE DIALOG oDlg TITLE "Consulta de RPS Transmitidos" FROM 180,180 TO 550,700 PIXEL
	
	//----------------------------------------------------------------------------------
	// Cria Browse
	//----------------------------------------------------------------------------------
	oBrowse := TCBrowse():New( 01 , 01, 260, 156,, {'Cod. Autoriza็ใo','Num. da Nota Prefeitura','Serie','Status'},{50,50,20,50}, oDlg,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )
	
	//----------------------------------------------------------------------------------
	// Seta vetor para a browse
	//----------------------------------------------------------------------------------
	oBrowse:SetArray(aBrowse)
	
	//----------------------------------------------------------------------------------
	// Monta a linha a ser exibina no Browse
	//----------------------------------------------------------------------------------
	oBrowse:bLine := {||{ aBrowse[oBrowse:nAt,01], aBrowse[oBrowse:nAt,02], aBrowse[oBrowse:nAt,03],aBrowse[oBrowse:nAT,04] } }
	
	//----------------------------------------------------------------------------------
	// Cria Botoes com metodos bแsicos
	//----------------------------------------------------------------------------------
	TButton():New( 160, 002, " Fechar ", oDlg,{||oDlg:End()},40,010,,,.F.,.T.,.F.,,.F.,,,.F. )	
	
	ACTIVATE DIALOG oDlg CENTERED
	
Return