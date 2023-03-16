#Include 'Protheus.ch'

//--------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} UpdateUser
Função utilizada para atualizar as credenciais do usuários do protheus com AD
@type function
@ author Autor
@ version versao
@ since 12/07/2018
@ return Nil

/*/
//--------------------------------------------------------------------------------------------------------
User Function UpdateUser()
	
	Processa( {|| AtuUser() }, "Aguarde...", "Atualizando credenciais dos usuários...",.F.)
	
	alert("Atualização finalizada!")
	
Return Nil


Return

Static 	Function AtuUser()

Local lRet := .T.
Local cPswFile	:= "sigapss.spf"
Local cPswId	:= ""
Local cPswName 	:= ""
Local cPswPwd	:= ""
Local cPswDet 	:= ""
Local cError 	:= ""
Local cWarning	:= ""

Local cOldPsw
Local cNewPsw

Local lEncrypt	:= .F.

Local nPswRec

Local cUsuAut := ""
Local cSenAut := ""
Local oOb
//Obtenho o usuario Base
Local cUsrId	:= ""
Local _aEmp := {}
Local lCadUsu	:= .T.
Local cMsgErr	:= ""
Local aUser		:= {}
Local nPosUser	:= 0

RpcSetType(3)

If RpcSetEnv("01","0101")
	_aEmp			:= FWLoadSM0()
Else
	SetSoapFault(ProcName(),'Não foi possivel a abertura da empresa Default 9901.')
Return .F.
EndIf

InitPublic()
SetsDefault()
SetModulo( "SIGACFG" , "CFG" )


aUser := AllUsers() // retorna todos os usuários do sistema

ntot := len(aUser)

ProcRegua(ntot)

cFunName := "APCFG30"
SetFunName(cFunName)

//Abro a Tabela de Senhas
spf_CanOpen(cPswFile)
// FAZER UM FOR

For nX := 1 to len(aUser)
	
	IncProc("Usuários "+cvaltochar(nX)+" de "+cvaltochar(nTot))
	
	if aUser[nX][1][1] # '000000'
		//Procuro pelo usuario Base
		nPswRec := spf_Seek( cPswFile , "3U"+aUser[nX][1][1] , 1 )
		if nPswRec > 0
			//Obtenho as Informacoes do usuario Base ( retornadas por referencia na variavel cPswDet)
			spf_GetFields( @cPswFile , @nPswRec , @cPswId , @cPswName , @cPswPwd , @cPswDet )
			
			oOb 	:= XmlParser( cPswDet, "_", @cError, @cWarning )
			
			//		If ('</struct></DATASSIGNON>' $ cPswDet)
			//
			//			oOb:_FWUSERACCOUNTDATA:_DATAUSER:_DATASSIGNON:_STRUCT:_USR_SO_DOMINIO:TEXT	  	:= "CABERJ"
			//			oOb:_FWUSERACCOUNTDATA:_DATAUSER:_DATASSIGNON:_STRUCT:_USR_SO_USERLOGIN:TEXT  	:= aUser[nX][1][2]
			//			cPswDet := XMLSaveStr(oOb)
			//		else
			QOut(nX)
			/*if at('</USR_SO_USERLOGIN></struct><items><item',cPswDet) > 0 
				oOb:_FWUSERACCOUNTDATA:_DATAUSER:_DATASSIGNON:_ITEMS:_ITEM:_USR_SO_DOMINIO:TEXT	  	:= "CABERJ"
				oOb:_FWUSERACCOUNTDATA:_DATAUSER:_DATASSIGNON:_ITEMS:_ITEM:_USR_SO_USERLOGIN:TEXT  	:= aUser[nX][1][2]
			endif
			cPswDet := XMLSaveStr(oOb)*/
			// strtran usado para corrigir a estrutura do xml gerada, para transforma-la em itens ao invés de estrutura.
			//cPswDet := strtran(cPswDet,'<DATASSIGNON optional="1" modeltype="GRID"><struct>','<DATASSIGNON optional="1" modeltype="GRID"><items><item>')
			//cPswDet := strtran(cPswDet,"</struct></DATASSIGNON>","</item></items></DATASSIGNON>")
			nLen    := len(cPswDet)
			cBkpPsw := cPswDet
			if at('</struct></DATASSIGNON>',cPswDet)  > 0 
				nPosStr := at('</struct>',cPswDet)
				cPswDet := substr(cBkpPsw,1,nPosStr+8)
				cPswDet += '<items><item USR_SO_DOMINIO="CABERJ" USR_SO_USERLOGIN="'+aUser[nX][1][2]+'" deleted="0" id="1"></item></items>'
				cPswDet += substr(cBkpPsw,nPosStr+9,nLen)
			elseif at('</struct><items><item',cPswDet) == 0
				nPosStr := at('</struct>',cPswDet)
				cPswDet := substr(cBkpPsw,1,nPosStr+8)
				cPswDet += '<items><item USR_SO_DOMINIO="CABERJ" USR_SO_USERLOGIN="'+aUser[nX][1][2]+'" deleted="0" id="1"></item></items>'
				cPswDet += substr(cBkpPsw,nPosStr+9,nLen)
			elseif at('</USR_SO_USERLOGIN></struct><items></items>',cPswDet) > 0
				nPosStr := at('</USR_SO_USERLOGIN></struct><items></items>',cPswDet)
				cPswDet := substr(cBkpPsw,1,nPosStr+27)
				cPswDet += '<items><item USR_SO_DOMINIO="CABERJ" USR_SO_USERLOGIN="'+aUser[nX][1][2]+'" deleted="0" id="1"></item></items>'
				cPswDet += substr(cBkpPsw,nPosStr+43,nLen)
			endif
			//PswEncript( alltrim('123') , 1 )
			//FreeObj(oOb)
			//Realiza Bloqueio SPF
			PswLock(.T.)
			
			//spf_insert( cPswFile, "3U"+cUsrIdNew , "3U"+cPswName , "3U"+cPswPwd , cPswDet )
			//If !spf_insert( cPswFile, "3U"+cUsrIdNew , "3U"+cPswName , "3U"+cNewPsw , cPswDet )
			spf_Update( cPswFile, @nPswRec,  cPswId , cPswName , cPswPwd , cPswDet )
			
			//Libera a SPF
			PswLock(.F.)
			
		endif
	EndIf
Next nX
//Fecha o arquivo SPF
SPF_Close(cPswFile)

Return lRet
