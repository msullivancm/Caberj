#Include 'Protheus.ch'

User Function F022ATUNF()
	
/*	Local aArea		 := GetArea()
	Local aAreaSF2	 := SF2->(GetArea())
	Local cProtocolo := PARAMIXB[3]
	Local cAlias053  := getNextAlias()
	Local cIdEnt     := GetIdEnt()
	Local cCodMun	 := SM0->M0_CODMUN
	Local aDatHR     := {} 
	// Atualiza SF2
	If !Empty(cProtocolo)
		
		BeginSql Alias cAlias053
			SELECT R_E_C_N_O_
			FROM TSSPROD.SPED053
			WHERE CODMUN = %exp:cCodMun%
			AND ID_ENT = %exp:cIdEnt%
			AND RECIBO = %exp:cProtocolo%
			ORDER BY LOTE
			
		ENDSQL
		
		if (cAlias053)->(!Eof())
			//criar query para buscar informações na tabela sped053 para gravar
			//data e hora de emissao
		
			
			
			FisRetDataHora( oXml, cMod004 )
			
			
			RECLOCK( "SF2", .F. )
			SF2->F2_CODNFE := cProtocolo
			SF2->(MSUNLOCK()) // Destrava o registro
			
		Endif
		
		if select(cAlias053) > 0
			dbselectarea(cAlias053)
			(cAlias053)->(dbclosearea())
		endif
		
	EndIf
	
	RestArea(aAreaSF2)
	RestArea(aArea)*/
	
Return Nil



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GetIdEnt  ³ Autor ³Eduardo Riera          ³ Data ³18.06.2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Obtem o codigo da entidade apos enviar o post para o Totvs  ³±±
±±³          ³Service                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpC1: Codigo da entidade no Totvs Services                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetIdEnt(cError)
	
	Local cIdEnt 	  := ""
	Local lUsaColab := .F.
	Default cError  := ""
	
	IF lUsaColab
		if !( ColCheckUpd() )
			Aviso("SPED","UPDATE do TOTVS Colaboração 2.0 não aplicado. Desativado o uso do TOTVS Colaboração 3.0",{"Ok"},3)
		else
			cIdEnt := "000000"
		endif
	Else
		//if isCBConnTSS(@cError) // Verifica a conexão do TSS antes de iniciar o processo de validação da entidade
		//	cIdEnt := getCfgEntidade(@cError)
		//endif
		cIdEnt := getCfgEntidade(@cError)
		If !Empty(cError)
			Aviso("NFS-e",cError,{"Ok"},3)
		EndIf
	EndIF
	
Return(cIdEnt)


//-----------------------------------------------------------------------
/*/{Protheus.doc} FisRetDataHora
Funcao que retorna Data e Hora do XML

@author Sergio S. Fuzinaka
@since 20.12.2012
@version 1.0
/*/
//-----------------------------------------------------------------------
Static Function FisRetDataHora( oXml, cMod004 )
	
	Local aRetorno		:= {}
	Local aDados		:= {}
	local aRet			:= {}
	Local cCodMun		:= if( type( "oSigamatX" ) == "U",SM0->M0_CODMUN,oSigamatX:M0_CODMUN )
	
	Local cRecXml		:= ""
	Local cRethora		:= ""
	Local cRetdata		:= ""
	Local dDataConv		:= CTOD( "" )
	Local cCID			:= ""
	
	Private oWS			:= NIL
	
	If Type( "oXml" ) <> "U"
		oWS := oXml
	Endif
	
	If Type( "oWS:cID" ) <> "U" .And. !Empty( Alltrim( oWS:cID ) )
		
		cCID := Alltrim( oWS:cID )
		
		If ( IsTSSModeloUnico() .And. Type( "oWS:XMLRETTSS" ) <> "U" .And. !Empty( oWS:XMLRETTSS ) )
			
			AADD( aDados, RetornaMonitor( cCID, oWS:XMLRETTSS ) )
			
		Else
			
			cRetdata	:= ""
			cRethora	:= ""
			dDataconv 	:= CTOD( "" )
			
			
			if ( ( cCodMun == "3550308" .Or. cCodMun == "2611606" .Or. cCodMun == "4202404" .Or. cCodMun == "4209102") .And. ( cEntSai == "1" ) )  //SAO PAULO, RECIFE, BLUMENAU E JOINVILLE.
				if Type( "oWS:OWSNFE:CXMLERP" ) <> "U" .And. !Empty( oWS:OWSNFE:CXMLERP )
					cRecxml		:= oWS:OWSNFE:CXMLERP
				endif
			elseif cCodMun $ "3304557-3200607-3200300-3305000-3303302" .And. ( Type("oWS:OWSNFE:CXMLPROT") <> "U" .And. !Empty( oWS:OWSNFE:CXMLPROT ) )
				cRecxml := oWS:OWSNFE:CXMLPROT
			else
				If Type( "oWS:OWSNFE:CXML" ) <> "U" .And. !Empty( oWS:OWSNFE:CXML )
					cRecxml		:= oWS:OWSNFE:CXML
				endif
			endif
			
			aRet := retDataXMLNfse(cRecxml,cCodMun)
			
			if ( ( ( cCodMun == "3550308" .or. cCodMun == "4202404" ) .And. ( cEntSai == "1" ) ) .or.  GetMunSiaf(cCodMun)[1][2] $ "004-006-009"  )  //SAO PAULO E RECIFE E BLUMENAU
				aRet[2] := "00:00:00"
			Elseif GetMunSiaf(cCodMun)[1][2] $ "011" .Or. cCodMun $ "4308201-3524006-4313300-3505906"
				aRet[1] := ddatabase
				aRet[2] := "00:00:00"
			endif
			
			AADD( aDados, { cCID, aRet[1], aRet[2], "" } )
			
		EndIf
		
	Endif
	
	aRetorno 	:= {}
	
	If Len( aDados ) > 0
		
		AADD( aRetorno, aDados[ 1, 2 ] )
		AADD( aRetorno, aDados[ 1, 3 ] )
		
	Endif
	
Return( aRetorno )


//-------------------------------------------------------------------
/*/{Protheus.doc} getCfgEntidade
Retorno o codigo da Entidade no TSS.

@param cError	- Mensagem de Retorno em caso de falha na requisição

@return	Entidade	-	Codigo da Entidade

@author  Renato Nagib
@since   17/08/2015
@version 12

/*/
//--------------------------------------------------------------------
Static function getCfgEntidade(cError)
	
	local aArea 		:= {}
	local cIdEnt	 	:= ""
	local cURL			:= ""
	local lUsaGesEmp	:= .F.
	local lEnvCodEmp	:= .F.
	local oWS			:= nil
	
	default cError		 := ""
	
	//	varSetUID(UID, .T.)
	
	cUrl := alltrim( if( FunName() == "LOJA701" .and. !Empty( getNewPar("MV_NFCEURL","")), PadR(GetNewPar("MV_NFCEURL","http://"),250),padR(getNewPar("MV_SPEDURL","http://"),250 )) )
	
	//if(  !varGetXD(UID, alltrim(SM0->M0_CGC) + alltrim(SM0->M0_INSC) + alltrim(SM0->M0_ESTENT) + alltrim(SM0->M0_CODIGO) + alltrim(SM0->M0_CODFIL) + cUrl, @cIdEnt ) )
	
	aArea 	:= getArea()
	lEnvCodEmp	:= getNewPar("MV_ENVCDGE",.F.)
	lUsaGesEmp	:= iif(findFunction("FWFilialName") .And. findFunction("FWSizeFilial") .And. FWSizeFilial() > 2,.T.,.F.)
	
	oWS := WsSPedAdm():New()
	
	oWS:cUSERTOKEN				:= "TOTVS"
	oWS:oWSEMPRESA:cCNPJ		:= iiF(SM0->M0_TPINSC==2 .Or. empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cCPF			:= iiF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cIE			:= AllTrim(SM0->M0_INSC)
	oWS:oWSEMPRESA:cIM			:= AllTrim(SM0->M0_INSCM)
	oWS:oWSEMPRESA:cNOME			:= AllTrim(SM0->M0_NOMECOM)
	oWS:oWSEMPRESA:cFANTASIA	:= iif(lUsaGesEmp,FWFilialName(),Alltrim(SM0->M0_NOME))
	oWS:oWSEMPRESA:cENDERECO		:= AllTrim(FisGetEnd(SM0->M0_ENDENT)[1])
	oWS:oWSEMPRESA:cNUM			:= AllTrim(FisGetEnd(SM0->M0_ENDENT)[3])
	oWS:oWSEMPRESA:cCOMPL		:= AllTrim(FisGetEnd(SM0->M0_ENDENT)[4])
	oWS:oWSEMPRESA:cUF			:= AllTrim(SM0->M0_ESTENT)
	oWS:oWSEMPRESA:cCEP			:= AllTrim(SM0->M0_CEPENT)
	oWS:oWSEMPRESA:cCOD_MUN		:= AllTrim(SM0->M0_CODMUN)
	oWS:oWSEMPRESA:cCOD_PAIS	:= "1058"
	oWS:oWSEMPRESA:cBAIRRO		:= AllTrim(SM0->M0_BAIRENT)
	oWS:oWSEMPRESA:cMUN			:= AllTrim(SM0->M0_CIDENT)
	oWS:oWSEMPRESA:cCEP_CP		:= nil
	oWS:oWSEMPRESA:cCP			:= nil
	oWS:oWSEMPRESA:cDDD			:= str(FisGetTel(SM0->M0_TEL)[2],3)
	oWS:oWSEMPRESA:cFONE		:= AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
	oWS:oWSEMPRESA:cFAX			:= AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
	oWS:oWSEMPRESA:cEMAIL		:= UsrRetMail(RetCodUsr())
	oWS:oWSEMPRESA:cNIRE			:= AllTrim(SM0->M0_NIRE)
	oWS:oWSEMPRESA:dDTRE		:= SM0->M0_DTRE
	oWS:oWSEMPRESA:cNIT			:= iif(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cINDSITESP	:= ""
	oWS:oWSEMPRESA:cID_MATRIZ	:= ""
	
	if(lUsaGesEmp .And. lEnvCodEmp )
		oWS:oWSEMPRESA:CIDEMPRESA:= FwGrpCompany()+FwCodFil()
		
	endif
	
	oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
	oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
	
	if( oWs:ADMEMPRESAS() )
		cIdEnt  := oWs:cADMEMPRESASRESULT
		
		//	varSetXD(UID, alltrim(SM0->M0_CGC) + alltrim(SM0->M0_INSC) + alltrim(SM0->M0_ESTENT) + alltrim(SM0->M0_CODIGO) + alltrim(SM0->M0_CODFIL) + cUrl, cIdEnt )
	else
		cError := iif( empty(GetWscError(3)), getWscError(1), getWscError(3) )
		
	endif
	
	oWs := nil
	
	restArea(aArea)
	aSize(aArea,0)
	aArea := nil
	
	//endif
	
Return cIdEnt