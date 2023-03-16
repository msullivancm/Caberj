#INCLUDE "APWEBSRV.CH"
#INCLUDE "XMLXFUN.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "PLSMCCR.CH"


// Define de nome de arquivos

#define CRLF Chr(13) + Chr(10)

#define __aCdCri099 	{"063","Participacao de servico informada invalida."}
#define __aCdCri163 	{"091","Solicitacao nao encontrada para este usuario."}
#define __aCdCri180 	{"09G","Nao existe vigencia ativa para esta rede de atendimento para a operadora informada"}
#define __aCdCri198 	{"09Q","Habilita checagem DE/PARA TUSS!"}
#define __aCdCri014 	{"511","Rede de atendimento nao permitida para a operadora informada."}
#define __aCdCri016 	{"513","Rede de atendimento sem especialidade cadastrada"}
#define __aCdCri152 	{"560","Para a solicitacao referente a esta internacao ja consta data de alta"}
#define __aCdCri153 	{"561","Incompatibilidade de informacao entre tipo de faturamento e data de alta"}
#define __aCdCri175 	{"581","Participacao informada nao existe para este procedimento ou o procedimento nao possui nenhum participacao cadastrada."}
#define __aCdCri128 	{"554","Tipo de Atendimento Inválido" }//"Tipo de Atendimento Inválido"

#define __aXMLCri00 	{"X00","Nao foi possivel criar os diretorios padroes TISS"}
#define __aXMLCri01 	{"X01","Arquivo(s) de Schemas nao encontrado(s)"}
#define __aXMLCri02 	{"X02","Nao foi possivel encontrar o Cabecalho nos Schemas"}
#define __aXMLCri03 	{"X03","Mensagens da operadora nao encontrada nos Schemas"}
#define __aXMLCri04 	{"X04","Nao foi possivel encontrar as Mensagens do prestador no Schemas"}
#define __aXMLCri05 	{"X05","Nao foi possivel encontrar o Epilogo no Schemas"}
#define __aXMLCri06 	{"X06","Numero sequencial no nome do arquivo invalido"}
#define __aXMLCri07 	{"X07","Delimitador nao encontrado no nome do arquivo"}
#define __aXMLCri08 	{"X08","Tamanho do hash no nome do arquivo invalido"}
#define __aXMLCri09 	{"X09","NameSpace definido incorreto com base nos Schemas"}
#define __aXMLCri10 	{"X10","Especialidade nao encontrada no sistema, para este prestador, com base no CBOS informado no arquivo"}
#define __aXMLCri11 	{"X11","Estrutura da TAG CABECALHO nao definida, ou definida de maneira incorreta, no arquivo submetido"}
#define __aXMLCri12 	{"X12","Estrutura da TAG PRESTADORPARAOPERADORA nao definida, ou definida de maneira incorreta, no arquivo submetido"}
#define __aXMLCri13 	{"X13","Estrutura da TAG EPILOGO nao definida, ou definida de maneira incorreta, no arquivo submetido"}
#define __aXMLCri14 	{"X14","Versao do arquivo nao aceito pela operadora "}
#define __aXMLCri15 	{"X15","Hash invalido, diferenca entre informado e a validacao do conteudo"}
#define __aXMLCri16 	{"X16",'Tipo de guia enviada no arquivo nao permitida ou incorreta'}
#define __aXMLCri17 	{"X17","Conteudo que identifica o prestador na operadora esta invalido"}
#define __aXMLCri18 	{"X18","Tipo de transacao invalido para o tipo de guia "}
#define __aXMLCri19 	{"X19","Codigo do numero de registo na ANS enviado invalido"}
#define __aXMLCri20 	{"X20","Nao existe calendario de pagamento, cadastrado na operadora, para esta competencia"}
#define __aXMLCri21 	{"X21","Matricula do beneficiario nao reconhecida pela operadora na data informada"}
#define __aXMLCri22 	{"X22","CID informado invalido"}
#define __aXMLCri23 	{"X23","Numero da senha de autorizacao enviada invalida"}
#define __aXMLCri24 	{"X24","Codigo que identifica o contratado nao reconhecido pela operadora"}
#define __aXMLCri25 	{"X25","Especialidade nao encontrada no sistema com base no CBOS informado no arquivo"}
#define __aXMLCri26 	{"X26","Codigo que identifica o executante nao reconhecido pela operadora"}
#define __aXMLCri27 	{"X27","Codigo de evento enviado invalido ou bloqueado pela operadora"}
#define __aXMLCri28 	{"X28","Quantidade pre-autorizada menor do que a quantidade enviada"}
#define __aXMLCri29 	{"X29","Local de atendimento nao encontrado com base no endereco enviado"}
#define __aXMLCri30 	{"X30","Nao foi possivel localizar uma composicao para este evento"}
#define __aXMLCri31 	{"X31","Nao foi possivel localizar uma tabela de pagamento valida para este evento"}
#define __aXMLCri32 	{"X32","Problemas com o contrato do beneficiario na data informada"}
#define __aXMLCri33 	{"X33","Operadora localizada com base no registro da ans enviado, diferente da operadora padrao"}
#define __aXMLCri34 	{"X34","Executante nao informado na guia de consulta"}
#define __aXMLCri36 	{"X36","Numero da senha nao autorizada pela operadora"}
#define __aXMLCri37 	{"X37","Evento informado nao esta contido na guia de pre-autorizacao"}
#define __aXMLCri38 	{"X38","Codigo que identifica o profissional executante complementar nao reconhecido pela operadora"}
#define __aXMLCri39 	{"X39","Codigo que identifica o membro de equipe nao reconhecido pela operadora"}
#define __aXMLCri40 	{"X40","Codigo de procedimento enviado em Guia de Consulta, nao reconhecido como uma consulta pela operadora"}
#define __aXMLCri41 	{"X41","Tipo de Carater de Atendimento  Inválido" }
#define __aXMLCri42 	{"X42","Data do procedimento superior a data do sistema" }
#define __aXMLCri43 	{"X43","Regime de Internacao Invalido" }
#define __aXMLCri44 	{"X44","Evento enviado no arquivo nao foi autorizado na senha enviada" }
#define __aXMLCri45 	{"X45","Tempo Referido na Evolucao da Doenca esta Invalido" }
#define __aXMLCri46 	{"X46","Beneficiario Bloqueado." }
#define __aXMLCri47 	{"X47","O executante não pode atender usuários deste produto ." }
#define __aXMLCri48 	{"X48","A Rede de atendimento não pode atender usuários deste produto ." }
#define __aXMLCri50 	{"X50","Rede de atendimento selecionada diferente da rede de atendimento informada no arquivo"}
#define __aXMLCri51 	{"X51","Via de Acesso diferente da solicitada ." }
#define __aXMLCri55 	{"X55","Procedimento bloqueado na especialidade do Prestador."}
#define __aXMLCri59 	{"X59","Especialidade bloqueada no cadastro do Prestador." }
#define __aXMLCri60		{"X60","Prestador Bloqueado/Nao Credenciado na data informada."}
#define __aXMLCri61		{"X61","Profissional de Saúde Bloqueado"}
#define __aXMLCri62		{"X62","Local de atendimento invalido com base no CNES informado no arquivo"}

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ATENCAO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!! SEMPRE QUE FOR CRIADA UMA CRITICA NOVA AQUI ACIMA A MESMA !!!!!!!!!!
// !!!!!!!! DEVE SER INCLUIDA NO VETOR __XACRITICAS  ABAIXO !!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
STATIC __XACRITICAS := {__aCdCri099, __aCdCri163, __aCdCri180, __aCdCri198, __aCdCri014, __aCdCri016, __aCdCri152, __aCdCri153, __aCdCri175,;
						__aCdCri128, __aXMLCri00, __aXMLCri01, __aXMLCri02, __aXMLCri03, __aXMLCri04, __aXMLCri05, __aXMLCri06, __aXMLCri07,;
						__aXMLCri08, __aXMLCri09, __aXMLCri10, __aXMLCri11, __aXMLCri12, __aXMLCri13, __aXMLCri14, __aXMLCri15, __aXMLCri16,;
						__aXMLCri17, __aXMLCri18, __aXMLCri19, __aXMLCri20, __aXMLCri21, __aXMLCri22, __aXMLCri23, __aXMLCri24, __aXMLCri25,;
						__aXMLCri26, __aXMLCri27, __aXMLCri28, __aXMLCri29, __aXMLCri30, __aXMLCri31, __aXMLCri32, __aXMLCri33, __aXMLCri34,;
						__aXMLCri36, __aXMLCri37, __aXMLCri38, __aXMLCri39, __aXMLCri40, __aXMLCri41, __aXMLCri42, __aXMLCri43, __aXMLCri44,;
						__aXMLCri45, __aXMLCri46, __aXMLCri47, __aXMLCri48, __aXMLCri50, __aXMLCri51, __aCdCri175, __aXMLCri55, __aXMLCri59,;
						__aXMLCri60, __aXMLCri61, __aXMLCri62}

//Array que armazena as criticas customizadas
STATIC __aCriCust 		:= {}
//Indica que existem criticas customizadas
STATIC lLoadCli 		:= u_C973LDCLI()
//Define de pastas
STATIC cDirRaiz	   	:= PLSMUDSIS( GetNewPar("MV_TISSDIR","\TISS\") )
STATIC cDirCaiEn   	:= PLSMUDSIS( cDirRaiz+"CAIXAENTRADA\" )
STATIC cDirSchema  	:= PLSMUDSIS( cDirRaiz+"SCHEMAS\" )
STATIC cDirUpload  	:= PLSMUDSIS( cDirRaiz+"UPLOAD\")
STATIC cDirLog	   	:= PLSMUDSIS( cDirRaiz+"LOG\" )
//Matrizes do XML
STATIC aMatShema 	:= {}
STATIC aMatCab	  	:= {}
STATIC aMatPre	  	:= {}
STATIC aMatOpe	  	:= {}
STATIC aMatEpi	  	:= {}
STATIC aMatBWT	  	:= {}
STATIC aUnMed			:= {}
//Versao TISS
STATIC  TISVERS 	:= GetNewPar("MV_TISSVER","2.02.03")
STATIC lVerTISS   	:= Iif( AllTrim(Upper(TISVERS)) $ "2.02.02,2.02.03",.T.,.F. )



/*/{Protheus.doc} PLSA973L
Processamento xml
@type Function
@author PLS
@since 22/03/12
/*/
user function CABA973L(cFileXml,cCodRda,lOnline,l974,cTipGui,cLotGui,nTotEve,nTotGui,nValTot,cSeqBXX,cDirAlt, cTisVerBXX,_oProcess)
	LOCAL lOk		:= .T.
	LOCAL cPathRda	:= ""
	LOCAL cExtensao := "" 						 		//Variaveis a serem utilizadas no split
	LOCAL cDrive	:= ""
	LOCAL cDiretorio:= ""
	LOCAL cNome		:= ""
	LOCAL aRet		:= {.F.,"",{}}
	LOCAL nx			:=0
	DEFAULT cTipGui	:= "08"
	DEFAULT cLotGui	:= ""
	DEFAULT nTotEve := 0
	DEFAULT nTotGui := 0
	DEFAULT nValTot	:= 0
	DEFAULT lOnline := .F.
	DEFAULT l974	:= .f.
	DEFAULT cSeqBXX	:= ""
	DEFAULT cDirAlt	:= cDirUpload
	DEFAULT cTisVerBXX	:= ""	
	
	// Verifica diretorio
	If !lOnline
		If lOk
			If !p973cest()
				lOk 	:= .F.
				aRet[1] := .T.
				AaDd(aRet[3], "Nao foi possivel criar os diretorios padroes TISS.") //"Arquivo(s) de Schemas nao encontrado(s) ( "###" )"
			Endif
		EndIf
	EndIf
	// Valida
	If lOk
		aRet := u_CVldXML(cFileXml,@cCodRda,@cTipGui,@cLotGui,@nTotEve,@nTotGui,@nValTot,l974,cSeqBXX,cDirAlt,@cTisVerBXX,_oProcess,lOnline)
		If Type(aRet[2]) <> "U"
			If !Empty(aRet[2])
				cCodRda := aRet[2]
				aRet[2] := ""
			EndIf
		EndIf
		If ExistBlock("PLS973LIMP")
			lOk := ExecBlock("PLS973LIMP",.F.,.F.,{cCodRda})
		EndIf
	Endif

	cPathRda := cDirCaiEn + cCodRda + "\"
	If lOk .And. !ExistDir(cPathRda)
		If MakeDir( cPathRda ) <> 0
			aRet := {.T.,"", { "Diretorio " + cPathRda + " nao encontrado e nao foi possivel cria-lo." } }
			lOk	 := .F.
		Else
			// copiando o arquivo xml para caixa de entrada para a futura importação via remote
			For nx:=Len(cFileXml) to 0 step -1
				If Substr(cFileXml,nx,1) ='\'
					cNome:=Substr(cFileXml,nx+1,Len(cFileXml))
					exit
				Endif
			Next
			__CopyFile( cFileXml , cPathRda+cNome )
		EndIf
	Else
		// copiando o arquivo xml para caixa de entrada para a futura importação via remote
		For nx:=Len(cFileXml) to 0 step -1
			If Substr(cFileXml,nx,1) ='\'
				cNome:=Substr(cFileXml,nx+1,Len(cFileXml))
				exit
			Endif
		Next
		__CopyFile( cFileXml , cPathRda+cNome )
	EndIf

	If !aRet[1] .And. lOk

		SplitPath(cFileXml,@cDrive,@cDiretorio,@cNome,@cExtensao)
		// Verifica se o arquivo existe e deleta
		If File(PLSMUDSIS( cPathRda+cNome+cExtensao ) )
			Erase(cPathRda+cNome+cExtensao)
		EndIf
		// Se processamento online ok (acatado) coloca na caixa de entrada do prestador
		__CopyFile( cFileXml , cPathRda+cNome+cExtensao )
		Erase(cFileXml)
	EndIf

	// Fim da Rotina
Return aRet

/*/{Protheus.doc} u_CVldXML
Versao LIGHT de validacao do XML
@type Function
@author PLS
@since 22.03.2012
/*/
user function CVldXML(cFileXml,cCodRda,cTipGui,cLotGui,nTotEve,nTotGui,nValTot,l974,cSeqBXX,cDirAlt,cTisVerBXX,_oProcess,lOnline)
	LOCAL nFor			:= 0
	LOCAL nPos			:= 0
	LOCAL nPosPP		:= 0
	LOCAL nX			:= 0
	LOCAL nI			:= 0
	LOCAL nY			:= 0
	LOCAL nK			:= 1
	LOCAL nQtdFiles	:= 0
	LOCAL nPosXX		:= 1
	LOCAL nIniSeg	  	:= Seconds()
	LOCAL cErro		  	:= ""
	LOCAL cAviso	  	:= ""
	LOCAL cNumSolInt	:= ""
	LOCAL cConteudo	  	:= ""
	LOCAL cArqRet	  	:= ""
	LOCAL cMsg		  	:= ""
	LOCAL cDatHor	  	:= ""
	LOCAL cMsgCri	  	:= ""
	LOCAL cTpTran     	:= ""
	LOCAL cNumeSeq    	:= ""
	LOCAL cTipo     	:= ""
	LOCAL cMatric       := ""
	LOCAL cNumGui       := ""
	LOCAL cNomeUsu      := ""
	LOCAL cTagDiag		:= ""
	LOCAL cNumSen		:= ""
	LOCAL cCidPri		:= ""
	LOCAL cOrigGu 		:= ""
	LOCAL cNGuiOri		:= ""
	LOCAL cNumImp 		:= ""
	LOCAL cNumImpOp		:= ""
	LOCAL cNumEvo 		:= ""
	LOCAL cNomCont 		:= ""
	LOCAL cCodRP 	 	:= ""
	LOCAL cNumEvoOp		:= ""
	LOCAL cSlvTag		:= ""
	LOCAL cCodTab   	:= ""
	LOCAL cCodCri		:= ""
	LOCAL cAliasTab 	:= ""
	LOCAL cTpProc     	:= ""
	LOCAL cLocalExec	:= "5"
	LOCAL cTipoGrv		:= "1"
	LOCAL cVersao   	:= StrTran(TISVERS,"_",".")
	LOCAL dDatPro		:= cTod('')
	LOCAL aAux        	:= {}
	LOCAL aResGeral   	:= {}
	LOCAL aTpPRec		:= {}
	LOCAL aTpPIte		:= {}
	LOCAL aRet        	:= {.F.,'',{}}
	LOCAL aMatRet	  	:= {}
	LOCAL aMatXCab		:= {}
	LOCAL aMatXPre		:= {}
	LOCAL aMatXEpi		:= {}
	LOCAL aMatAux		:= {}
	LOCAL aMatNew 		:= {}
	LOCAL aMatCri		:= {}
	LOCAL aMatC   		:= {}
	LOCAL aMatM   		:= {}
	LOCAL aDados  		:= {}
	LOCAL aItens   		:= {}
	LOCAL aCriticas		:= {}
	LOCAL cOrigem 		:= ""
	LOCAL lInter		:= .F.
	LOCAL lPart		:= .F.
	LOCAL lErrMat		:= .F.
	LOCAL nP			:= 1
	LOCAL nJ			:= 1
	LOCAL cOpeMov		:= PlsIntPad()
	LOCAL cSlvOpe		:= cOpeMov
	LOCAL oXml			:= nil
	LOCAL bBlockXml		:= nil
	LOCAL lAchouVlr     := .F.
	LOCAL nIndUt		:= 0
	LOCAL nInd1			:= 0
	LOCAL dDataPrcRel	:= Msdate()
	LOCAL bRest1 := {|| 	nRecBau := BAU->(Recno()),;
	nOrdBAU := BAU->(IndexOrd()),;
	nRecBQ1 := BQ1->(Recno()),;
	nOrdBQ1 := BQ1->(IndexOrd()),;
	nRecBAQ := BAQ->(Recno()),;
	nOrdBAQ := BAQ->(IndexOrd())}

	LOCAL bRest2 := { ||   BAU->(DbSeTOrder(nOrdBAU)),;
	BQ1->(DbSeTOrder(nOrdBQ1)),;
	BAQ->(DbSeTOrder(nOrdBAQ)),;
	BAU->(DbGoTo(nRecBAU)),;
	BQ1->(DbGoTo(nRecBQ1)),;
	BAQ->(DbGoTo(nRecBAQ))}
	LOCAL cCodProArq		:= ""
	LOCAL cCnpjPres 		:=""
	Local cTissVer 		:= ""
	Local aExistX10		:= {}
	Local lExistX10	:=.F. // TRATAMENTO PARA NãO GERAR VARIAS CRITICAS X10
	// Array para guardar os valores atribuidos no cadastro de variaveis e retornar para as variaveis passadas por parametro
	// Segunda posição em branco quer dizer que espera uma variavel de mesmo nome do cadastro da BVP
	LOCAL cCodTpa		:= ""
	LOCAL aAreaAnt 		:= BA1->(GetArea())
	LOCAL nDiasBloq  	:= GetNewPar("MV_PLDIABL",0)
	LOCAL lUsrPMA     := GetNewPar("MV_PLPUMAB",.F.)
	Local lUsrXBl     :=.F.
	Local lUsrBEA     :=.F.
	LOCAL cCodPeg		:= ""
	LOCAL lLoteTissOnline	:= .F.
	LOCAL cEspPe		:= ""
	LOCAL aRetPe	:= {}
	LOCAL cExpVld		:= ""
	Private aVarsAux	:= {	{"cCodRda","cRdaOri"},;
	{"cTipGui","cTipGui"},;
	{"cLotGui","cLotGui"},;
	{"nValTot","nValTotG"}}
	Private nSeqGui		:= 0
	DEFAULT cCodRda		:= ""
	DEFAULT nTotEve		:= 0
	DEFAULT nTotGui		:= 0
	DEFAULT nValTot    	:= 0
	DEFAULT cTipGui    	:= "08"
	DEFAULT cLotGui		:= ""
	DEFAULT l974			:= .f.
	DEFAULT cSeqBXX		:= ""
	DEFAULT cDirAlt    	:= cDirUpload
	DEFAULT cTisVerBXX 	:= ""
	DEFAULT _oProcess	:= nil
	DEFAULT lOnline		:= .f.

	// Cria um objeto do arquivo XML
	oXml := XmlParserFile(cFileXml, "_", @cErro, @cAviso)

	If !Empty(cErro)
		aRet[1] := .T.
		AaDd(aRet[3], "*** ERRO [ CRIAÇAO OBJETO XML ] ***")
		AaDd(aRet[3], cErro)
	Endif
	If !Empty(cAviso)
		aRet[1] := .T.
		AaDd(aRet[3], "*** AVISO [ CRIAÇAO OBJETO XML ] ***")
		AaDd(aRet[3], cAviso)
	Endif

	If !aRet[1]

		If (PLSALIASEX("BVV")) .and. BVV->( Fieldpos("BVV_TISVER"))>0
			// Monta um array do arquivo XML com as tags seus caminhos e valores
			aDados := U_CXMLTOARR(classDataArr(oXml))
			// Apos montar o aDados pego a quantidade de guias
			If Type("nSeqGui") <> 'U'
				nTotGui := nSeqGui
			EndIf

			// Valida se está sendo subemetido um arquivo no padrão TISS Online
			// Neste caso será feito uma conversão para TISS padrão
			lLoteTissOnline := U_CXMLTISWS(@aDados)

			// Pega a versão do XML de acordo com as tags cadastradas na tabela BVP
			cTissVer := u_CXMLTISVER(aDados)
		Else
			//se não tiver a BVV realiza as validações que foram criadas antes da versão 3 da TISS
			cTissVer := "2.02.03"
		EndIf

		TISVERS:= cTissVer

		cTisVerBXX := cTissVer // Variavel de versao na BXX
		// Define diretorio dos arquivos
		_cTISTRAN:= "tissV"+StrTran(cTissVer,".","_")+".XSD"
		_cTISGUIA:= "tissGuiasV"+StrTran(cTissVer,".","_")+".XSD"
		_cTISCOMP:= "tissComplexTypesV"+StrTran(cTissVer,".","_")+".XSD"
		_cTISSIMP:= "tissSimpleTypesV"+StrTran(cTissVer,".","_")+".XSD"

		//Se não encontrou a versão da TISS no XML
		If (Empty(cTissVer))
			aRet[1] := .T.
			AaDd(aRet[3], "** ERRO **")
			AaDd(aRet[3], "Versão TISS não encontrada no XML")
		Else
			//Para validaçao de XMLs com versão acima da 3.00.00 deve ser utilizado a função u_CNewVldXML para realizar a validação
			If Val(StrTran(cTissVer,".","")) >= 30000
				//libera o objeto oXml da memória pois não será mais utilizado
				FreeObj(oXml)
				oXml := Nil
				DelClassInf()
				// Cria a variavel para recupera-la
				For nI := 1 to Len(aVarsAux)
					_SetOwnerPrvt(aVarsAux[nI,1] + "3X", IIf(Substr(Upper(aVarsAux[nI,1]),1,1) == "N",0,"")) // _SetOwnerPrvt(aVarsAux[nI,1] + "30100", "")
				Next nI
				// Criação das variáveis - BVP
				// Já crio a maioria das variaveis aqui para que as mesmas fiquem globais
				// (variaveis passadas pra ca e utilizadas nas expressões sao utilizadas
				// em varias partes do processo
				//Posiciona a tabela das variáveis
				BVP->(DbSelectArea("BVP"))
				BVP->(DbSetOrder(1)) //BVP_FILIAL+BVP_TISVER
				//Verifica se encontrou alguma variável para a versão TISS
				If(BVP->(MsSeek(xFilial("BVP")+cTissVer)))
					//Percorre a tabela para criar as variáveis
					While (!BVP->(Eof()) .And. BVP->(BVP_FILIAL+BVP_TISVER) == xFilial("BVP")+cTissVer)
						If Upper(Substr(	AllTrim(BVP->BVP_NOMVAR), 1,1)) == "C"
							_SetOwnerPrvt(AllTrim(BVP->BVP_NOMVAR), "")
						ElseIf Upper(Substr(	AllTrim(BVP->BVP_NOMVAR), 1,1)) == "N"
							_SetOwnerPrvt(AllTrim(BVP->BVP_NOMVAR), 0)
						ElseIf Upper(Substr(	AllTrim(BVP->BVP_NOMVAR), 1,1)) == "L"
							_SetOwnerPrvt(AllTrim(BVP->BVP_NOMVAR), .F.)
						ElseIf Upper(Substr(	AllTrim(BVP->BVP_NOMVAR), 1,1)) == "A"
							_SetOwnerPrvt(AllTrim(BVP->BVP_NOMVAR), {})
						ElseIf Upper(Substr(	AllTrim(BVP->BVP_NOMVAR), 1,1)) == "D"
							_SetOwnerPrvt(AllTrim(BVP->BVP_NOMVAR), CTOD(""))
						EndIf
						BVP->(DbSkip())
					EndDo
				EndIf

				aVarsUnic	:= {}
				aDadosUnic	:= U_CDADOUNIC(aDados) //variável que representa o aDados, porém sem repetir as tags

				//checa se está chamando da mudança em lote
				If IsInCallStack("PLSUBLOT") .or.  IsInCallStack("PLRRJOB")
					// FOI NECESSÁRIO MODIFICAR OS TRECHOS ABAIXO DEVIDO A ROTINA DE SUBMISSÃO EM LOTE NECESSITAR DA CRIAÇÃO DAS VARIÁBEIS "3X" NESTE MOMENTO
					//transforma as variáveis em PRIVATE para ficarem visíveis na Macro Substituição(&)
					_SetOwnerPrvt("aDados",aDados)
					_SetOwnerPrvt("cFileXml",cFileXml)
					aTabDup := u_CBBusTerDup(SuperGetMv("MV_TISSCAB",.F.,"87"))

					U_CBVARTISS(aDadosUnic, cTissVer, "" , , @aRet,nil,@aVarsUnic)
				Else
					U_CBVARTISS(aDadosUnic, cTissVer,'CGUIA',,@aRet,nil,@aVarsUnic)
				EndIf

				//Esse tratamento se da para que as guias ja vao com seu ctigui corretos e nao 08 como default assil calculando corretamente seus valores
				If(nPos:= aScan(aVarsUnic,{|x|ALLTRIM(x[1])=="CTPGUIAS"} ))>0
					nLines := MLCount( aVarsUnic[nPos,2])
					For nI := 1 to nLines
						if !(empty(memoLine(aVarsUnic[nPos,2],,nI)))
							cExpVld += alltrim(strTran(strTran(memoLine(aVarsUnic[nPos,2],,nI), chr(10), ""), chr(13),""))
						endIf
					next nI
					cTpGuias := &(cExpVld)
					cGuia	 := U_CBTPGUIA(cTpGuias, aDadosUnic)
					If(nPos1 := aScan(aVarsUnic,{|x|ALLTRIM(x[1])=="CTIPGUI"} ))>0
						cTipGui	:= &(aVarsUnic[nPos1,2])
					Endif
				Endif

				If IsInCallStack("PLSUBLOT")
					aRet := PLSA973FST(cFileXml, aDados, cTissVer,l974,cSeqBXX,cTipGui,@aRet,_oProcess)
				ElseIf   IsInCallStack("PLRRJOB")
					aRet := PLSA973FST(cFileXml, aDados, cTissVer,l974,cSeqBXX,cTipGui,@aRet)
				Else
					aRet := u_CNewVldXML(cFileXml, aDados, cTissVer,l974,cSeqBXX,cTipGui,lOnline)
				Endif

				// Tratamento da RDA do arquivo para CPF, CNPJ ou Codigo Prestador na operadora
				If Type(aRet[2]) <> "U"
					If !Empty(aRet[2])
						cRdaOri := aRet[2]
						cCodRda := aRet[2]
					EndIf
				EndIf
			Else
				// Verifica se os arquivos de Shema existem
				If !aRet[1] .and. !p973cest()
					PLSPOSGLO(cOpeMov,__aXMLCri00[1],__aXMLCri00[2],cLocalExec,"1",cTipoGrv)
					aRet[1] := .T.
					AaDd(aRet[3], "** ERRO ["+__aXMLCri00[1]+"] **")
					AaDd(aRet[3], PLSBCTDESC())
				Endif

				If !File(cDirSchema+_cTISTRAN)
					cMsg += _cTISTRAN+","
				EndIf
				If !File(cDirSchema+_cTISGUIA)
					cMsg += _cTISGUIA+","
				EndIf
				If !File(cDirSchema+_cTISCOMP)
					cMsg += _cTISCOMP+","
				EndIf
				If !File(cDirSchema+_cTISSIMP)
					cMsg += _cTISSIMP+","
				EndIf

				If !Empty(cMsg)
					PLSPOSGLO(cOpeMov,__aXMLCri01[1],__aXMLCri01[2],cLocalExec,"1",cTipoGrv)
					aRet[1] := .T.
					AaDd(aRet[3], "** ERRO ["+__aXMLCri01[1]+"] **")
					AaDd(aRet[3], PLSBCTDESC())
					AaDd(aRet[3], "Erro: "+alltrim(cMsg))
				EndIf
				// Monta Schemas
				If !aRet[1]
					If Len(aMatShema) == 0
						aMatShema := PLSMMATSXD(nil,cTissVer)
						If !Empty(aMatShema[1])
							aRet[1] := .T.
							AaDd(aRet[3], aMatShema[1])
						Else
							aMatShema  	:= aMatShema[2]
							aMatCab	   := {}
							aMatPre	   := {}
							aMatOpe	   := {}
							aMatEpi	   := {}
						EndIf
					EndIf
					// Monta matriz do cabecalho com base no schema
					If Len(aMatCab) == 0
						If ( nPos := aScan( aMatShema,{|x|Upper(x[1])=="CABECALHO"} ) ) > 0
							For nI:=1 To Len(aMatShema[nPos])
								If ValType(aMatShema[nPos,nI]) == "A"
									For nX:=1 To Len(aMatShema[nPos,nI])
										AaDd(aAux,aMatShema[nPos,nI,nX])
									Next
								Else
									AaDd(aAux,aMatShema[nPos,nI])
								EndIf
							Next
							aMatCab := aAux
						Else
							PLSPOSGLO(cOpeMov,__aXMLCri02[1],__aXMLCri02[2],cLocalExec,"1",cTipoGrv)
							aRet[1] := .T.
							AaDd(aRet[3], "** ERRO ["+__aXMLCri02[1]+"] **")
							AaDd(aRet[3],PLSBCTDESC())
						EndIf
					EndIf
					// Monta matriz do operadoraparaprestadro com base no schema
					If Len(aMatOpe) == 0
						If ( nPos := aScan( aMatShema,{|x|Upper(x[1]) == "OPERADORAPARAPRESTADOR_OP_CH"} ) ) > 0
							aMatShema[nPos,1] := SubStr(aMatShema[nPos,1],1,Len(aMatShema[nPos,1])-3)
							aMatOpe := aMatShema[nPos]
						Else
							PLSPOSGLO(cOpeMov,__aXMLCri03[1],__aXMLCri03[2],cLocalExec,"1",cTipoGrv)
							aRet[1] := .T.
							AaDd(aRet[3], "** ERRO ["+__aXMLCri03[1]+"] **")
							AaDd(aRet[3], PLSBCTDESC())
						EndIf
					EndIf
					// Monta matriz do prestadorparaoperadora com base no schema
					If Len(aMatPre) == 0
						If ( nPos := aScan( aMatShema,{|x|Upper(x[1])=="PRESTADORPARAOPERADORA_OP_CH"} ) ) > 0
							aMatShema[nPos,1] := SubStr(aMatShema[nPos,1],1,Len(aMatShema[nPos,1])-3)
							aMatPre := aMatShema[nPos]
						Else
							PLSPOSGLO(cOpeMov,__aXMLCri04[1],__aXMLCri04[2],cLocalExec,"1",cTipoGrv)
							aRet[1] := .T.
							AaDd(aRet[3], "** ERRO ["+__aXMLCri04[1]+"] **")
							AaDd(aRet[3], PLSBCTDESC())
						EndIf
					EndIf
					// Monta matriz de epilogo com base no schema
					If Len(aMatEpi) == 0
						If ( nPos := aScan( aMatShema,{|x|Upper(x[1])=="EPILOGO"} ) ) > 0
							aMatEpi := aMatShema[nPos]
						Else
							PLSPOSGLO(cOpeMov,__aXMLCri05[1],__aXMLCri05[2],cLocalExec,"1",cTipoGrv)
							aRet[1] := .T.
							AaDd(aRet[3], "** ERRO ["+__aXMLCri05[1]+"] **")
							AaDd(aRet[3], PLSBCTDESC())
						EndIf
					EndIf
				EndIf
				// Processando arquivos xml
				If !aRet[1]
					// Carrega Matriz
					If Len(aMatBWT) == 0
						BWT->( DbGoTop() )
						While !BWT->( Eof() )
							AaDd(aMatBWT,{ BWT->BWT_CODOPE,BWT->BWT_CODPAR,BWT->BWT_CODEDI } )
							BWT->( DbSkip()	)
						EndDo
						// Carrega Matriz
						aUnMed := PLSXBKC()
					EndIf
					// Nome do arquivo
					cFileXml := Lower( AllTrim(cFileXml) )
					// Verifica se a sequencia foi informada
					cFileSeq := SubStr(SubStr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,Len(cFileXml)),1,Rat("_",cFileXml)-Rat(PLSMUDSIS("\"),cFileXml)-1)
					If Val(cFileSeq) == 0 .or. Len(cFileSeq) > 20 .or. Len(cFileSeq) <= 0
						If PLSPOSGLO(cOpeMov,__aXMLCri06[1],__aXMLCri06[2],cLocalExec,"1",cTipoGrv)
							aRet[1] := .T.
							AaDd(aRet[3], "** ERRO ["+__aXMLCri06[1]+"] **")
							AaDd(aRet[3], PLSBCTDESC())
							AaDd(aRet[3], "Nome do arquivo: "+substr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,len(cFileXml))+"  ")
							AaDd(aRet[3], "Numero sequencial informado: "+cFileSeq)
						Endif
					EndIf
					// Verifica delimitador
					cFileDel  := SubStr(SubStr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,Len(cFileXml)),Rat("_",cFileXml)-Rat(PLSMUDSIS("\"),cFileXml),1)
					If cFileDel <> "_"
						If PLSPOSGLO(cOpeMov,__aXMLCri07[1],__aXMLCri07[2],cLocalExec,"1",cTipoGrv)
							aRet[1] := .T.
							AaDd(aRet[3], "** ERRO ["+__aXMLCri07[1]+"] **")
							AaDd(aRet[3], PLSBCTDESC())
							AaDd(aRet[3], "Nome do arquivo: "+substr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,len(cFileXml))+"  ")
							AaDd(aRet[3], "Nome do arquivo: "+cFileXml+"  ")
						Endif
					EndIf
					// Vefica hash contido no arquivo
					cFileHas  := AllTrim( SubStr(SubStr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,Len(cFileXml)),Rat("_",cFileXml)-Rat(PLSMUDSIS("\"),cFileXml)+1,Rat(".",cFileXml)-Rat("_",cFileXml)-1) )
					If Len(cFileHas) <> 32
						If PLSPOSGLO(cOpeMov,__aXMLCri08[1],__aXMLCri08[2],cLocalExec,"1",cTipoGrv)
							aRet[1] := .T.
							AaDd(aRet[3], "** ERRO ["+__aXMLCri08[1]+"] **")
							AaDd(aRet[3], PLSBCTDESC())
							AaDd(aRet[3], "Nome do arquivo: "+substr(cFileXml,Rat(PLSMUDSIS("\"),cFileXml)+1,len(cFileXml))+"  ")
							AaDd(aRet[3], "Hash informado: "+cFileHas+"  ")
						Endif
					EndIf
					// Processamento
					If !aRet[1]
						// Abre o arquivo
						oXml := XmlParserFile(cDirAlt+cFileSeq+cFileDel+cFileHas+".xml","_",@cErro,@cAviso)
						// Checa o retorno e pega o nome da transacao de solicitacao
						If ( Empty(cErro) .And. Empty(cAviso) .And. oXml <> Nil )

							cEncod := SubStr(MemoRead(cDirAlt+cFileSeq+cFileDel+cFileHas+".xml"),20,30)
							If ( nPos := At( 'utf',Lower(cEncod) ) ) > 0
								cEncod := Upper(SubStr(cEncod,nPos,5))
							ElseIf ( nPos := At( 'iso',Lower(cEncod) ) ) > 0
								cEncod := Upper(SubStr(cEncod,nPos,10))
							Else
								cEncod	:= "ISO-8859-1"
							EndIf

							aMatAux 	:= classDataArr(oXml)
							nPos 		:= ( At("_",SubStr( aMatAux[Len(aMatAux),1],2 ) )+1 )
							cNameSpace	:= Upper( SubStr( aMatAux[Len(aMatAux),1],1,nPos ) )
							cNameEleme	:= Upper( SubStr( aMatAux[Len(aMatAux),1],(nPos+1) ) )
							// Verifica namspace do arquivo
							PLSPOSGLO(cOpeMov,__aXMLCri09[1],__aXMLCri09[2],cLocalExec,"1",cTipoGrv)
							If Empty( PLSDELIM(cNameSpace) )
								aRet[1] := .T.
								AaDd(aRet[3], "** ERRO ["+__aXMLCri09[1]+"] **")
								AaDd(aRet[3], PLSBCTDESC())
							ElseIf Upper(PLSDELIM(cNameSpace)) <> "ANS"
								aRet[1] := .T.
								AaDd(aRet[3], "** ERRO ["+__aXMLCri09[1]+"] **")
								AaDd(aRet[3], PLSBCTDESC())
							ElseIf Empty( PLSDELIM(cNameEleme) )
								aRet[1] := .T.
								AaDd(aRet[3], "** ERRO ["+__aXMLCri09[1]+"] **")
								AaDd(aRet[3], PLSBCTDESC())
							Else
								// Estrutura bruta
								oObjXml := XmlChildEx(oXml,cNameSpace+cNameEleme)
								oXml	:= nil
								// Verifica cabecalho
								PLSPOSGLO(cOpeMov,__aXMLCri11[1],__aXMLCri11[2],cLocalExec,"1",cTipoGrv)
								If XmlNodeExist(oObjXml,cNameSpace+"CABECALHO")
									If ValType( &( "oObjXml:"+cNameSpace+"CABECALHO" ) ) == "O"
										aAux := PLSMONSTR( PLSAJMAT(cNameSpace, classDataArr( &( "oObjXml:"+cNameSpace+"CABECALHO" ) ) ) ,Len(cNameSpace) )
										AaDd( aMatXCab,"CABECALHO" )
										For nI:=1 To Len(aAux)
											AaDd(aMatXCab,aAux[nI])
										Next
										If Empty(aMatXCab)
											aRet[1] := .T.
											AaDd(aRet[3], "** ERRO ["+__aXMLCri11[1]+"] **")
											AaDd(aRet[3], PLSBCTDESC())
										EndIf
									Else
										aRet[1] := .T.
										AaDd(aRet[3], "** ERRO ["+__aXMLCri11[1]+"] **")
										AaDd(aRet[3], PLSBCTDESC())
									EndIf
								Else
									aRet[1] := .T.
									AaDd(aRet[3], "** ERRO ["+__aXMLCri11[1]+"] **")
									AaDd(aRet[3], PLSBCTDESC())
								EndIf
								// Verifica Mensagem
								PLSPOSGLO(cOpeMov,__aXMLCri12[1],__aXMLCri12[2],cLocalExec,"1",cTipoGrv)
								If XmlNodeExist(oObjXml,cNameSpace+"PRESTADORPARAOPERADORA")
									If ValType( &( "oObjXml:"+cNameSpace+"PRESTADORPARAOPERADORA" ) ) == "O"
										aMatXPre := { "PRESTADORPARAOPERADORA",PLSMONSTR( PLSAJMAT(cNameSpace, classDataArr( &( "oObjXml:"+cNameSpace+"PRESTADORPARAOPERADORA" ) ) ) ,Len(cNameSpace) )[1] }
										If Empty(aMatXPre)
											aRet[1] := .T.
											AaDd(aRet[3], "** ERRO ["+__aXMLCri12[1]+"] **")
											AaDd(aRet[3],PLSBCTDESC())
										EndIf
									Else
										aRet[1] := .T.
										AaDd(aRet[3], "** ERRO ["+__aXMLCri12[1]+"] **")
										AaDd(aRet[3], PLSBCTDESC())
									EndIf
								Else
									aRet[1] := .T.
									AaDd(aRet[3], "** ERRO ["+__aXMLCri12[1]+"] **")
									AaDd(aRet[3], PLSBCTDESC())
								EndIf
								// Verifica Epilogo
								PLSPOSGLO(cOpeMov,__aXMLCri13[1],__aXMLCri13[2],cLocalExec,"1",cTipoGrv)
								If XmlNodeExist(oObjXml,cNameSpace+"EPILOGO")
									If ValType( &( "oObjXml:"+cNameSpace+"EPILOGO" ) ) == "O"
										aMatXEpi := { "EPILOGO",PLSMONSTR( PLSAJMAT(cNameSpace, classDataArr( &( "oObjXml:"+cNameSpace+"EPILOGO" ) ) ) ,Len(cNameSpace) )[1] }
										If Empty(aMatXEpi)
											aRet[1] := .T.
											AaDd(aRet[3], "** ERRO ["+__aXMLCri13[1]+"] **")
											AaDd(aRet[3], PLSBCTDESC())
										EndIf
									Else
										aRet[1] := .T.
										AaDd(aRet[3], "** ERRO ["+__aXMLCri13[1]+"] **")
										AaDd(aRet[3],  PLSBCTDESC())
									EndIf
								Else
									aRet[1] := .T.
									AaDd(aRet[3], "** ERRO ["+__aXMLCri13[1]+"] **")
									AaDd(aRet[3],  PLSBCTDESC())
								EndIf
								oObjXml := nil
							Endif
							If !aRet[1]
								// Valida Cabecalho
								AaDd( aMatRet , PLSVLDXML(aMatCab,aMatXCab) )
								// Valida Corpo
								AaDd( aMatRet , PLSVLDXML(aMatPre,aMatXPre) )
								// Valida Epilogo
								AaDd( aMatRet , PLSVLDXML(aMatEpi,aMatXEpi) )
								// Carrega o conteudo do arquivo para validacao HASH
								For nI:=1 To 2
									For nY:=1 To Len(aMatRet[nI])
										If ValType(aMatRet[nI,nY,2]) <> 'A' .And. !Empty(aMatRet[nI,nY,2])
											cConteudo += aMatRet[nI,nY,2]
										EndIf
									Next
								Next

								// Verifica versao do arquivo recebido com a versao definida
								If PLSPOSGLO(cOpeMov,__aXMLCri14[1],__aXMLCri14[2],cLocalExec,"1",cTipoGrv)
									If AllTrim(Upper(PLSPEGCON("PADRAO",aMatRet[1]))) <> AllTrim(Upper(TISVERS))
										aRet[1] := .T.
										AaDd(aRet[3], "** ERRO ["+__aXMLCri14[1]+"] **")
										AaDd(aRet[3], PLSBCTDESC())
										AaDd(aRet[3], "Versao do arquivo ["+AllTrim(Upper(PLSPEGCON("PADRAO",aMatRet[1])))+"] ")
										AaDd(aRet[3], "Versao aceite pela Operadora ["+AllTrim(Upper(TISVERS))+"] ")
										AaDd(aRet[3], " ")
									EndIf
								Endif
								// Verifica campos do software gerador - verao >= 2_02_02
								If lVerTISS
									cNomApl := PLSPEGCON("NOMEAPLICATIVO",aMatRet[1])
									cVerApl := PLSPEGCON("VERSAOAPLICATIVO",aMatRet[1])
									cFabApl := PLSPEGCON("FABRICANTEAPLICATIVO",aMatRet[1])
								EndIf
								// Valida Hash	no nome do arquivo x informado no arquivo
								If Len(aMatRet) >= 3
									cHash := Upper(PLSPEGCON("HASH",aMatRet[3]))
									cContHash := Upper( MD5(cConteudo,2) )
									If PLSPOSGLO(cOpeMov,__aXMLCri15[1],__aXMLCri15[2],cLocalExec,"1",cTipoGrv)
										If !( cHash == Upper(cFileHas) )
											lHasAr	:= .T.
											aRet[1]	:= .T.
											AaDd(aRet[3], "** ERRO ["+__aXMLCri15[1]+"] **")
											AaDd(aRet[3], PLSBCTDESC())
											AaDd(aRet[3], "Hash informado no nome do arquivo: "+cFileHas)
											AaDd(aRet[3], "Hash informado dentro do arquivo: "+cHash)
											AaDd(aRet[3], "Hash do conteudo do arquivo: "+cContHash)
											AaDd(aRet[3], " ")
										EndIf
									Endif

									// Valida Hash
									cContHash := Upper( MD5(cConteudo,2) )
									If PLSPOSGLO(cOpeMov,__aXMLCri15[1],__aXMLCri15[2],cLocalExec,"1",cTipoGrv)
										If ! (Upper(cHash) == cContHash )
											lHasCo	:= .T.
											aRet[1]	:= .T.
											AaDd(aRet[3], "** ERRO ["+__aXMLCri15[1]+"] **")
											AaDd(aRet[3], PLSBCTDESC())
											AaDd(aRet[3], "Hash informado dentro do arquivo: "+cHash)
											AaDd(aRet[3], "Hash do conteudo do arquivo: "+cContHash)
											AaDd(aRet[3], " ")
										EndIf
									Endif
								EndIf

								// Ajusta cabecalho
								For nI:=1 To Len(aMatRet[1])
									If !Empty(aMatRet[1,nI,2])
										AaDd(aMatC,aMatRet[1,nI])
									EndIf
								Next
								// Tipos de Guias Prestador para Operadora
								cTpGuias :=	"GUIACONSULTA,"							//Lote Guias
								cTpGuias +=	"GUIASP_SADT,"							//Lote Guias
								cTpGuias +=	"GUIAHONORARIOINDIVIDUAL,"				//Lote Guias
								cTpGuias +=	"GUIARESUMOINTERNACAO,"					//Lote Guias
								cTpGuias +=	"GUIAODONTOLOGIA,"				   		//Lote Guias 					- Pendente
								cTpGuias +=	"GUIACONSULTAREAPRESENTACAO,"			//Lote Guias
								cTpGuias +=	"GUIASP_SADTREAPRESENTACAO,"			//Lote Guias
								cTpGuias +=	"GUIAHONORARIOINDIVIDUALREAPRESENTACAO,"//Lote Guias
								cTpGuias +=	"GUIARESUMOINTERNACAOREAPRESENTACAO,"	//Lote Guias
								cTpGuias +=	"GUIAODONTOLOGIAREAPRESENTACAO,"		//Lote Guias 					- Pendente
								// Procura o tipo de guia
								cGuia := PLSPCONGR(cTpGuias,"",aMatRet[2],"E",,.F.)

								If !Empty(cGuia)
									nPos	 	:= aScan(aMatRet[2],{|x|x[1] == cGuia } )
									nPosAux	:= nPos
									aMatAux  	:= {}
									cCodProArq	:= ""
									While nPosAux > 0
										For nI:=1 To (nPos-1)
											AaDd(aMatAux,aMatRet[2,nI])
										Next
										nPosNext := aScan(aMatRet[2],{|x|x[1] == cGuia },(nPosAux+1) )
										If nPosAux>nPos .And. nPosNext == 0
											nPosNext := Len(aMatRet[2])+1
										EndIf
										If nPosNext > 0
											For nI:=nPosAux To (nPosNext-1)
												AaDd(aMatAux,aMatRet[2,nI])
											Next
										ElseIf nPosAux == nPos
											aMatAux := aMatRet[2]
										EndIf
										nPosAux := nPosNext
										If Len(aMatAux) > nPos
											For nI:=1 To Len(aMatAux)
												If !Empty(aMatAux[nI,2])
													AaDd(aMatNew,aMatAux[nI])
												EndIf
												If alltrim(Upper(aMatAux[nI,1])) == "CODIGO"   // Verificando o Codigo do Procedimento no Arquivo
													cCodProArq := aMatAux[nI,2]
													If PLSPOSGLO(cOpeMov,__aXMLCri27[1],__aXMLCri27[2],cLocalExec,"1",cTipoGrv)
														If EMPTY(cCodProArq)
															cNomeUsu := PLSPCONGR("NOMEBENEFICIARIO",""+"\PRESTADORPARAOPERADORA\LOTEGUIAS\GUIAS\GUIAFATURAMENTO\GUIASP_SADT\DADOSBENEFICIARIO\",aMatAux,,,.F.)

															PExErr(aRet, "** ERRO ["+__aXMLCri27[1]+"] **")
															PExErr(aRet,PLSBCTDESC())
															PExErr(aRet,"Procedimento Nao Informado ")
															PExErr(aRet,"Beneficiario: "+cNomeUsu)
															PExErr(aRet,"")
														Endif
													Endif
												EndIf
											Next
											AaDd(aMatM,aMatNew)
										EndIf
										If nPosNext == Len(aMatRet[2])+1
											nPosAux := 0
										EndIf
										aMatAux := {}
										aMatNew := {}
									EndDo
								Else
									aRet[1] := .T.
									PLSPOSGLO(cOpeMov,__aXMLCri16[1],__aXMLCri16[2],cLocalExec,"1",cTipoGrv)
									AaDd(aRet[3], "** ERRO ["+__aXMLCri16[1]+"] **")
									AaDd(aRet[3], PLSBCTDESC())
									AaDd(aRet[3], " ")
								EndIf
								// Verifica se em consulta ou sp-sadt ou internacao
								// Tipo de guia 0=Consulta;1=SP_SADT;2=GRI;3=GHI;4=Odonto;5=Nao identificada
								If cGuia $ "GUIACONSULTA,GUIACONSULTAREAPRESENTACAO"
									cTipo 	:= "1"
									cOrigGu	:= "1" //Execucao
									cTipGui	:= "01"
								Endif
								If cGuia $ "GUIASP_SADT,GUIASP_SADTREAPRESENTACAO"
									cTipo 	:= "2"
									cOrigGu	:= "1" //Execucao
									cTipGui	:= "02"
								Endif
								If cGuia $ "GUIARESUMOINTERNACAO,GUIARESUMOINTERNACAOREAPRESENTACA"
									cOrigGu	:= "1" //Execucao
									cTipo 	:= "3"
									cTipGui	:= "05"
								Endif
								If cGuia $ "GUIAHONORARIOINDIVIDUAL,GUIAHONORARIOINDIVIDUALREAPRESENTACAO"
									cOrigGu	:= "1" //Execucao
									cTipo 	:= "3"
									cTipGui	:= "06"
								EndIf
								If cGuia $ "GUIAODONTOLOGIA,GUIAODONTOLOGIAREAPRESENTACAO"
									cOrigGu	:= "1" //Execucao
									cTipo 	:= "4"
									cTipGui	:= "07"
								Endif

								if l974
									cRdaOri := AllTrim( PLSPCONGR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA","CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatC) )
									cRdaOri := cRdaOri+Space( TamSX3("BAU_CPFCGC")[1]-Len(cRdaOri) )
									If Len(alltrim(cRdaOri)) > TamSX3("BAU_CODIGO")[1]//se eh maior significa que o prestador mandou o cnpj na TAG  de codigo
										nIdx 	 := 4
									Else
										cRdaOri := padr(cRdaOri,6)
										nIdx 	 := 1
									Endif
									if empty(cRdaOri)
										cRdaOri := AllTrim( PLSPCONGR("cnpjPagador","CABECALHO\ORIGEM",aMatC) )
										cRdaOri := cRdaOri+Space( TamSX3("BAU_CPFCGC")[1]-Len(cRdaOri) )
										if empty(cRdaOri)
											xRdaOri  := PLSPCONGR("CODIGOPRESTADORNAOPERADORA","CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatC)
											cRdaOri  := xRdaOri
											If Len(alltrim(xRdaOri)) > TamSX3("BAU_CODIGO")[1]//se eh maior significa que o prestador mandou o cnpj na TAG  de codigo
												nIdx 	 := 4
											Else
												cRdaOri := padr(cRdaOri,6)
												nIdx 	 := 1
											Endif
										endIf
									endIf

									If !Empty(cRdaOri)
										BAW->(DbSetOrder(3))
										cRdaAnt := cRdaOri+Space( TamSX3("BAW_CODANT")[1]-Len(cRdaOri) )
										If BAW->(MsSeek(xFilial("BAW")+cOpeMov+cRdaAnt))
											cRdaOri := BAW->BAW_CODIGO
											nIdx 	:= 1
										Endif
									Endif

									BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
									if !BAU->( MsSeek( xFilial("BAU")+cRdaOri ) )
										//para algumas criticas nao justifica o if plsposglo, e para estes casos eu tambem nao consigo
										//prosseguir o processamento
										PLSPOSGLO(cOpeMov,__aXMLCri17[1],__aXMLCri17[2],cLocalExec,"1",cTipoGrv)

										PExErr(aRet, "** ERRO ["+__aXMLCri17[1]+"] **")
										PExErr(aRet,PLSBCTDESC())
										PExErr(aRet,"Codigo enviado: "+cRdaOri)
										PExErr(aRet,"")
									else
										cRdaOri	  := BAU->BAU_CODIGO
										cNomOri	  := AllTrim(BAU->BAU_NOME)
										cNomRda   := AllTrim(BAU->BAU_NOME)
										cTpCab 	  := AllTrim(BAU->BAU_TIPPE)
										cCCCab	  := AllTrim(BAU->BAU_CPFCGC)

										cCodRda := cRdaOri
									endif
								endIf


								If !aRet[1]
									// Verifica tipo de transacao recebida e o retorno
									If Len(aMatRet[1]) > 0
										cTpTran  := PLSPEGCON("TIPOTRANSACAO",aMatRet[1])
										cNumeSeq := PLSPEGCON("SEQUENCIALTRANSACAO",aMatRet[1])
										// Dados para informacao do destino do retorno
										cTagOri	 := "registroANS"
										cOrigem  := PLSPCONGR(Upper(cTagOri),'\CABECALHO\ORIGEM\',aMatRet[1])
										If Empty(cOrigem)
											cTagOri	 := 'CPF'
											cOrigem  := AllTrim( PLSPCONGR(Upper(cTagOri),"CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatRet[1]) )
											If Empty(cOrigem)
												cTagOri	 := 'CNPJ'
												cOrigem  := AllTrim( PLSPCONGR(Upper(cTagOri),"CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatRet[1]) )
												If Empty(cOrigem)
													cTagOri	 := 'cnpjPagador'
													cOrigem  := AllTrim( PLSPCONGR(Upper(cTagOri),"CABECALHO\ORIGEM",aMatRet[1]) )
													If Empty(cOrigem)
														cTagOri	 := 'codigoPrestadorNaOperadora'
														cOrigem  := PLSPCONGR(Upper(cTagOri),"CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatRet[1])
													EndIf
												EndIf
											EndIf
										EndIf
									EndIf

									If At(cGuia,"GUIASOLICITACAOSADT,GUIASOLICINTERNACAO,GUIASOLICITACAOPRORROGACAO,GUIASOLICITACAOODONTOLOGIA") > 0 .And. alltrim(cTpTran)=="ENVIO_LOTE_GUIAS"
										PLSPOSGLO(cOpeMov,__aXMLCri18[1],__aXMLCri18[2],cLocalExec,"1",cTipoGrv)
										aRet[1] := .T.
										AaDd(aRet[3], "** ERRO ["+__aXMLCri18[1]+"] **")
										AaDd(aRet[3], PLSBCTDESC())
										AaDd(aRet[3], "Tipo de trasacao: "+cTpTran)
										AaDd(aRet[3], "Tipo de guia: "+cGuia)
										AaDd(aRet[3], " ")
									EndIf

									If	cTpTran $ "ENVIO_LOTE_GUIAS,RE_APRESENTACAO_GUIA"

										if !l974
											cRdaOri := AllTrim( PLSPCONGR("CPF,CNPJ","CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatC) )
											cRdaOri := cRdaOri+Space( TamSX3("BAU_CPFCGC")[1]-Len(cRdaOri) )
											nIdx 	 := 4
											If Empty(cRdaOri)
												cRdaOri := AllTrim( PLSPCONGR("cnpjPagador","CABECALHO\ORIGEM",aMatC) )
												cRdaOri := cRdaOri+Space( TamSX3("BAU_CPFCGC")[1]-Len(cRdaOri) )
												If Empty(cRdaOri)
													xRdaOri  := PLSPCONGR("CODIGOPRESTADORNAOPERADORA","CABECALHO\ORIGEM\CODIGOPRESTADORNAOPERADORA",aMatC)
													cRdaOri  := xRdaOri
													If Len(alltrim(xRdaOri)) > TamSX3("BAU_CODIGO")[1]
														nIdx 	 := 4
													Else
														cRdaOri := padr(cRdaOri,6)
														nIdx 	 := 1
													Endif
												EndIf
											EndIf

											If !Empty(cRdaOri)
												BAW->(DbSetOrder(3))
												cRdaAnt := cRdaOri+Space( TamSX3("BAW_CODANT")[1]-Len(cRdaOri) )
												If BAW->(MsSeek(xFilial("BAW")+cOpeMov+cRdaAnt))
													cRdaOri := BAW->BAW_CODIGO
													nIdx 	:= 1
												Endif
											Endif
											cNomOri := ""
											BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
											If !BAU->( MsSeek( xFilial("BAU")+cRdaOri ) )
												PLSPOSGLO(cOpeMov,__aXMLCri17[1],__aXMLCri17[2],cLocalExec,"1",cTipoGrv)
												aRet[1] := .T.
												PExErr(aRet, "** ERRO ["+__aXMLCri17[1]+"] **")
												PExErr(aRet,PLSBCTDESC())
												PExErr(aRet,"Codigo enviado: "+cRdaOri)

												PExErr(aRet,"")
											Else
												cRdaOri	  := BAU->BAU_CODIGO
												cNomRda   := AllTrim(BAU->BAU_NOME)
												cNomOri   := AllTrim(BAU->BAU_NOME)
												cTpCab 	  := AllTrim(BAU->BAU_TIPPE)
												cCCCab	  := AllTrim(BAU->BAU_CPFCGC)
											Endif

											If PLSPOSGLO(cOpeMov,__aXMLCri18[1],__aXMLCri18[2],cLocalExec,"1",cTipoGrv)
												If !aRet[1] .and. BAU->BAU_CODIGO <> cCodRDA

													PExErr(aRet, "** ERRO ["+__aXMLCri18[1]+"] **")
													PExErr(aRet,PLSBCTDESC())
													PExErr(aRet,"Prestador que esta autorizado a enviar o arquivo: " + AllTrim(BAU->BAU_NOME))
													PExErr(aRet,"Prestador que esta tentando a enviar o arquivo: "+Posicione("BAU",1,xFilial("BAU")+cCodRda,"BAU_NOME"))
													PExErr(aRet,"")
												Endif
											Endif
										endIf

										cRegAns   := PLSPCONGR("REGISTROANS","CABECALHO\DESTINO",aMatC)
										cCnpjPres := PLSPCONGR("CNPJPAGADOR","CABECALHO\DESTINO",aMatC)
										If PLSPOSGLO(cOpeMov,__aXMLCri19[1],__aXMLCri19[2],cLocalExec,"1",cTipoGrv)
											If !Empty(cRegAns)
												BA0->( DbSetOrder(5) ) //BA0_FILIAL+BA0_SUSEP
												If BA0->( MsSeek( xFilial("BA0")+cRegAns ) )
													cSlvOpe := BA0->(BA0_CODIDE+BA0_CODINT)
												Else

													PExErr(aRet, "** ERRO ["+__aXMLCri19[1]+"] **")
													PExErr(aRet,PLSBCTDESC())
													PExErr(aRet,"Registro da ANS: "+cRegAns)
													PExErr(aRet,"")
												EndIf
											Elseif !Empty(cCnpjPres)   /// pega pelo CNPJPAGADOR
												BA0->( DbSetOrder(4) ) //BA0_FILIAL+BA0_SUSEP
												If BA0->( MsSeek( xFilial("BA0")+cCnpjPres ) )
													cSlvOpe := BA0->(BA0_CODIDE+BA0_CODINT)
												Else

													PExErr(aRet, "** ERRO ["+__aXMLCri19[1]+"] **")
													PExErr(aRet,PLSBCTDESC())
													PExErr(aRet,"Registro da ANS: "+cCnpjPres)
													PExErr(aRet,"")
												EndIF
											Else

												PExErr(aRet, "** ERRO ["+__aXMLCri19[1]+"] **")
												PExErr(aRet,PLSBCTDESC())
												PExErr(aRet,"TAG Registro da ANS invalida ou nao encontrada")
												PExErr(aRet,"")
											Endif
										Endif

										If PLSPOSGLO(cOpeMov,__aXMLCri33[1],__aXMLCri33[2],cLocalExec,"1",cTipoGrv)
											If cSlvOpe <> cOpeMov

												PExErr(aRet, "** ERRO ["+__aXMLCri33[1]+"] **")
												PExErr(aRet,PLSBCTDESC())
												PExErr(aRet,"Registro da ANS: "+cRegAns)
												PExErr(aRet,"Operadora Padrao : "+BA0->(Posicione("BA0",1,xFilial("BA0")+cOpeMov,"BA0_NOMINT")))
												PExErr(aRet,"Operadora Enviada: "+BA0->(Posicione("BA0",1,xFilial("BA0")+cSlvOpe,"BA0_NOMINT")))
												PExErr(aRet,"")
											Endif

										Endif

										if lOnline
											if PLSPOSGLO(cOpeMov,__aXMLCri50[1],__aXMLCri50[2],cLocalExec,"1",cTipoGrv)

												if cCodRda <> cRdaOri
													PExErr(aRet, "** ERRO ["+__aXMLCri50[1]+"] **")
													PExErr(aRet,PLSBCTDESC())
													PExErr(aRet,cRdaOri + ' - ' + BAU->(Posicione("BAU",1,xFilial("BAU")+cRdaOri,"BAU_NOME")) )
													PExErr(aRet,"")
												endIf

											endIf
										endIf

										aRetAux := PLSXVLDCAL(dDataBase,cOpeMov,.F.)
										If !aRetAux[1]
											PLSPOSGLO(cOpeMov,__aXMLCri20[1],__aXMLCri20[2],cLocalExec,"1",cTipoGrv)
											aRet[1] := .T.
											PExErr(aRet, "** ERRO ["+__aXMLCri20[1]+"] **")
											PExErr(aRet,PLSBCTDESC())
											PExErr(aRet,"Data Base: "+dtoc(dDataBase))
											PExErr(aRet,"")
										Endif

										If !aRet[1]
											For nI:=1 to Len(aMatM)
												aMatMCp  	:= aClone(aMatM[nI])
												cData	 	:= ""
												cHora	 	:= ""
												aDados	 	:= {}
												aItens   	:= {}
												aCriticas	:= {}
												aTpPRec		:= {}
												aIteLib		:= {}
												aDadUsr		:= {}
												cCodProf 	:= ""
												cNomRda  	:= ""
												cCrmRda  	:= ""
												cSlgRda  	:= ""
												cEstRda  	:= ""
												cNumImp  	:= ""
												cNumSen		:= ""
												cTagDiag	:= ""
												dDatAlta	:= ctod('')
												cTipFat		:= ""
												cMatric		:= ""
												cCodPCPL	:= ""
												cSlvTag 	:= ""
												cSlvPad		:= ""
												cSlvPro		:= ""
												cIdenfic	:= ""
												cCodTab   	:= ""
												cAliasTab 	:= ""
												cTpProc     := ""
												cCodBAU		:= ""
												cConPrEx	:= ""
												cNomRdEx	:= ""
												cNomPre		:= ""
												lErrMat 	:= .F.
												lFoundAut	:= .F.
												nRecnoAut	:= 0
												aEvErros    := {}
												cTpAtend	:=""
												cTpCarate	:=""
												cTmpDoe	:=""
												If ExistBlock("PLSXMLDAT")
													aRetTag := ExecBlock( "PLSXMLDAT",.F.,.F.,{cGuia} )
													cData 	:= PLSPCONGR(aRetTag[1],cGuia+AllTrim(aRetTag[2]),aMatMCp,,.T.)
												EndIf
												If cTipo == "3"
													cTipFat := PLSPCONGR("TIPOFATURAMENTO",cGuia,aMatMCp,,,.F.)
												Endif

												cLotGui := AllTrim(PLSPCONGR("NUMEROLOTE","\LOTEGUIAS",aMatMCp))
												// Se entrou no ponto de entrada mais nao retornou nada
												If cTipo == "2" .And. Empty(cData)
													cDataHora := PLSPCONGR("DATAHORAATENDIMENTO",cGuia,aMatMCp,,.T.)
													If !Empty(cDataHora)
														cData := SubStr(cDataHora,1,8)
														cHora := SubStr(cDataHora,10,6)
													EndIf
												EndIf
												If cTipo $ "1,2" .Or. (cTipo == "3" .And. cOrigGu == "2") .Or. cTipGui $ "06"
													If Empty(cData)
														cData := PLSPCONGR("DATAEMISSAOGUIA",cGuia,aMatMCp)
														If Empty(cData)
															cData := PLSPCONGR("DATAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC,,,.F.)
														EndIf
													EndIf
													If Empty(cHora)
														cHora := PLSPCONGR("HORAREGISTROTRANSACAO","\CABECALHO\IDENTIFICACAOTRANSACAO",aMatC)
													EndIf
												Else
													cDataHora := PLSPCONGR("DATAHORAINTERNACAO",cGuia,aMatMCp)
													If !Empty(cDataHora)
														cData := SubStr(cDataHora,1,8)
														cHora := SubStr(cDataHora,10,6)
													EndIf
												EndIf
												// Data e Hora do Atendimento
												If Len(cHora)>8
													cHora := SubStr(cHora,1,8)
												EndIf
												// Mesmo pegando a data no tratamento acima nao deixo atribuir para a matriz³
												// pois a data correta e vai ser retirada da tag DADOSATENDIMENTO
												If cTipo <> "1"
													dDatPro := PLSAJUDAT(cData)
												Else
													dDatPro := PLSAJUDAT( PLSPCONGR("DATAATENDIMENTO",cGuia+"\DADOSATENDIMENTO",aMatMCp,,.T.))
												Endif
												// Dados do Beneficiario
												If cTipo == "1"
													cMatric  := PLSPCONGR("NUMEROCARTEIRA",cGuia+"\BENEFICIARIO",aMatMCp)
													cNomeUsu := PLSPCONGR("NOMEBENEFICIARIO",cGuia+"\BENEFICIARIO",aMatMCp,,,.F.)
												Else
													cMatric  := PLSPCONGR("NUMEROCARTEIRA",cGuia+"\DADOSBENEFICIARIO",aMatMCp)
													cNomeUsu := PLSPCONGR("NOMEBENEFICIARIO",cGuia+"\DADOSBENEFICIARIO",aMatMCp,,,.F.)
													cNumGui  := PLSPCONGR("NUMEROGUIAOPERADORA",cGuia,aMatMCp,,,.F.)
												EndIf

												If ExistBlock("PLSXMLMAT")
													cMatric := ExecBlock( "PLSXMLMAT",.F.,.F.,{cMatric,cNomeUsu} )
												EndIf

												// Ponto de entrada para matricula
												If Empty(dDatPro)
													dDatPro := dDataBase
												Endif

												If PLSPOSGLO(cOpeMov,__aXMLCri21[1],__aXMLCri21[2],cLocalExec,"1",cTipoGrv)
													If xTemChar(alltrim(cMatric))

														PExErr(aRet, "** ERRO ["+__aXMLCri21[1]+"] **",__aXMLCri21[1],nI,nil,nil,cSeqBXX,.t.)
														PExErr(aRet,PLSBCTDESC(),__aXMLCri21[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"Data Atendimento: "+dtoc(dDatPro),__aXMLCri21[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri21[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"",__aXMLCri21[1],nI,nil,nil,cSeqBXX)
														lErrMat := .T.
													Endif
												Endif

												If !lErrMat .and. PLSPOSGLO(cOpeMov,__aXMLCri21[1],__aXMLCri21[2],cLocalExec,"1",cTipoGrv)
													If !Empty(cMatric)
														aRetFun := PLSDADUSR(cMatric,"1",.F.,dDatPro)
														aDadUsr := PLSGETUSR()
														If ! aRetFun[1]
															aRetFun := PLSDADUSR(cMatric,"2",.F.,dDatPro)
															aDadUsr := PLSGETUSR()
															If ! aRetFun[1]

																PExErr(aRet, "** ERRO ["+__aXMLCri21[1]+"] **",__aXMLCri21[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri21[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Data Atendimento: "+dtoc(dDatPro),__aXMLCri21[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri21[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"",__aXMLCri21[1],nI,nil,nil,cSeqBXX)
															Endif
														Endif

														If ! aRetFun[1]
															If PLSPOSGLO(cOpeMov,__aXMLCri32[1],__aXMLCri32[2],cLocalExec,"1",cTipoGrv)
																aRetPP := PLSVLDCON(cMatric,dDatPro,nil,nil,'1',nil,nil,cCodRda,nil,.F.)
																If !aRetPP[1]
																	PExErr(aRet, "** ERRO ["+__aXMLCri32[1]+"] **",__aXMLCri32[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,__aXMLCri32[2],__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Data Atendimento: "+dtoc(dDatPro),__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																	For nJ:=1 to Len(aRetPP[2])

																		PExErr(aRet,aRetPP[2][nJ][2]+If(Empty(aRetPP[2][nJ][3]),""," ["+aRetPP[2][nJ][3]+"]"),__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																	Next
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																Endif
															Endif
														Endif

														If ! aRetFun[1]
															If PLSPOSGLO(cOpeMov,__aXMLCri32[1],__aXMLCri32[2],cLocalExec,"1",cTipoGrv)
																aRetPP :=   PLSVLDFIN(cMatric,dDatPro,nil,nil,nil,aDadUsr)

																If !aRetPP[1]
																	PExErr(aRet, "** ERRO ["+__aXMLCri32[1]+"] **",__aXMLCri32[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,__aXMLCri32[2],__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Data Atendimento: "+dtoc(dDatPro),__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																	For nJ:=1 to Len(aRetPP[2])

																		PExErr(aRet,aRetPP[2][nJ][2]+If(Empty(aRetPP[2][nJ][3]),""," ["+aRetPP[2][nJ][3]+"]"),__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																	Next
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri32[1],nI,nil,nil,cSeqBXX)
																Endif
															Endif
														Endif

													Else

														PExErr(aRet, "** ERRO ["+__aXMLCri21[1]+"] **",__aXMLCri21[1],nI,nil,nil,cSeqBXX,.t.)
														PExErr(aRet,PLSBCTDESC(),__aXMLCri21[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri21[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"",__aXMLCri21[1],nI,nil,nil,cSeqBXX)
													EndIf
												Endif

												If cTipo == "1"
													cTagDiag := "\HIPOTESEDIAGNOSTICA"
												Else
													If cVersao >= "2.01.03"
														cTagDiag := "\DIAGNOSTICOATENDIMENTO"
													Else
														cTagDiag := "\DIAGNOSTICOGUIA"
													EndIf
												EndIf

												If cTipo == "3"
													cCidPri := upper(strtran(PLSPCONGR("CODIGODIAGNOSTICO",cGuia+"\DIAGNOSTICOSSAIDAINTERNACAO\DIAGNOSTICOPRINCIPAL",aMatMCp,,,.F.),'.',''))
												Else
													cCidPri := upper(strtran(PLSPCONGR("CODIGODIAGNOSTICO",cGuia+cTagDiag+"\CID",aMatMCp,,,.F.),'.',''))
												Endif

												If PLSPOSGLO(cOpeMov,__aXMLCri22[1],__aXMLCri22[2],cLocalExec,"1",cTipoGrv)
													If !Empty(cCidPri)
														BA9->(DbSetOrder(1))
														If ! BA9->(MsSeek(xFilial("BA9")+AllTrim(cCidPri))) .And. ! BA9->(MsSeek(xFilial("BA9")+lower(AllTrim(cCidPri))))

															PExErr(aRet, "** ERRO ["+__aXMLCri22[1]+"] **",__aXMLCri22[1],nI,nil,nil,cSeqBXX,.t.)
															PExErr(aRet,PLSBCTDESC(),__aXMLCri22[1],nI,nil,nil,cSeqBXX)
															PExErr(aRet,"CID: "+cCidPri,__aXMLCri22[1],nI,nil,nil,cSeqBXX)
															PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri22[1],nI,nil,nil,cSeqBXX)
															PExErr(aRet,"",__aXMLCri22[1],nI,nil,nil,cSeqBXX)
														Endif
													Endif
												Endif

												cGuiPri 	:= PLSPCONGR("NUMEROGUIAPRINCIPAL",cGuia,aMatMCp)
												cNumImp		:= PLSPCONGR("NUMEROGUIAPRESTADOR",cGuia,aMatMCp)
												cNumImpOp	:= PLSPCONGR("NUMEROGUIAOPERADORA",cGuia,aMatMCp)

												If cTipo == "2"
													cSlvTag := "\DADOSAUTORIZACAO"
												Endif
												cNumSen := PLSPCONGR("SENHAAUTORIZACAO",cGuia+cSlvTag,aMatMCp)

												If cTipGui $ "02"
													If Empty(cNumSen) .and. !Empty(cNumImpOp)
														cNumSen := cNumImpOp
													Endif
												Endif

												If cTipGui $ "05"
													//este parametro indica se a operadora vai trabalhar com a senha ou com nro de autorizacao na internacao
													If GetNewPar("MV_PLSENIN",'1') == '1'
														cNumSen := PLSPCONGR("NUMEROGUIASOLICITACAO",cGuia,aMatMCp,,.T.)
														If Empty(cNumSen)
															cSlvTag := "\DADOSAUTORIZACAO"
															cNumSen := PLSPCONGR("SENHAAUTORIZACAO",cGuia+cSlvTag,aMatMCp)
															If Empty(cNumSen)
																cNumSen := PLSPCONGR("SENHAAUTORIZACAO",cGuia,aMatMCp)
															Endif
														Endif
													Else
														cSlvTag := "\DADOSAUTORIZACAO"
														cNumSen := PLSPCONGR("SENHAAUTORIZACAO",cGuia+cSlvTag,aMatMCp)
														If Empty(cNumSen)
															cNumSen := PLSPCONGR("SENHAAUTORIZACAO",cGuia,aMatMCp)
															If Empty(cNumSen)
																cNumSen := PLSPCONGR("NUMEROGUIASOLICITACAO",cGuia,aMatMCp,,.T.)
															Endif
														Endif

													Endif
												EndIf
												If cTipGui $ "06"
													If Empty(cNumSen)
														If !Empty(cGuiPri)
															cNumSen := cGuiPri
														Endif
													Endif
												Endif

												If ExistBlock("PLSTMLLIB")
													cNumAut := ExecBlock( "PLSTMLLIB",.F.,.F.,{ cNumSen,cOpeMov,cCodRP,cTipo,cMatric,cGuiPri,cTipGui$"06",.f.,cTipGui } )
												Else
													cNumAut := cNumSen
												EndIf

												aIteLib := _pRETAULI(cNumAut)

												If PLSPOSGLO(cOpeMov,__aXMLCri23[1],__aXMLCri23[2],cLocalExec,"1",cTipoGrv) .AND. !aIteLib[3]
													If cTipo == '2' .and. !empty(cNumAut)
														BEA->( DbSetOrder(1) )
														If !BEA->( MsSeek(xFilial("BEA")+padr(alltrim(cNumAut),18)) )
															BEA->( DbSetOrder(14) )
															If !BEA->( MsSeek(xFilial("BEA")+padr(alltrim(cNumAut),9)) )

																If BEA->(FieldPos("BEA_GUIPRE"))> 0
																	cNumImp		:= PLSPCONGR("NUMEROGUIAPRESTADOR",cGuia,aMatMCp)
																	cAliasTrb	:= GetNextAlias()
																	BeginSql Alias cAliasTrb
																	SELECT BEA.R_E_C_N_O_ FROM %table:BEA% BEA
																	WHERE BEA_FILIAL = %exp:xFilial("BEA")%
																	AND BEA_GUIPRE 	= %exp:cNumAut%
																	AND BEA.%NotDel%
																	Endsql

																	If (cAliasTrb)->(Eof())
																		PExErr(aRet, "** ERRO ["+__aXMLCri23[1]+"] **",__aXMLCri23[1],nI,nil,nil,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Numero da Guia Prestador Invalida: "+cNumAut,__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"",__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																		(cAliasTrb)->(DbCloseArea())
																	Else
																		BEA->(DbGoto((cAliasTrb)->R_E_C_N_O_))
																		(cAliasTrb)->(DbCloseArea())
																	Endif
																Else
																	PExErr(aRet, "** ERRO ["+__aXMLCri23[1]+"] **",__aXMLCri23[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																Endif
															Endif
														Endif
														lFoundAut := BEA->(Found())
														nRecnoAut := BEA->(Recno())
														aIteLib := _pRETAULI(cNumAut)

														//se achou uma liberacao e a liberacao foi negada
														If  PLSPOSGLO(cOpeMov,__aXMLCri36[1],__aXMLCri36[2],cLocalExec,"1",cTipoGrv) .and. ;
														lFoundAut .and. BEA->BEA_LIBERA == '1' .and. BEA->BEA_STATUS == '3' .and. cTipo == '2' .and.;
														!empty(cNumAut) .and. !aIteLib[1]


															PExErr(aRet, "** ERRO ["+__aXMLCri36[1]+"] **",__aXMLCri36[1],nI,nil,nil,cSeqBXX,.t.)
															PExErr(aRet,PLSBCTDESC(),__aXMLCri36[1],nI,nil,nil,cSeqBXX)
															PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri36[1],nI,nil,nil,cSeqBXX)
															PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri36[1],nI,nil,nil,cSeqBXX)
															PExErr(aRet,"",__aXMLCri36[1],nI,nil,nil,cSeqBXX)
														Endif
														BEA->(DbGoTo(nRecnoAut))
														If  PLSPOSGLO(cOpeMov,__aXMLCri46[1],__aXMLCri46[2],cLocalExec,"1",cTipoGrv) .and. lFoundAut
															If  AllTrim(BEA->(BEA_OPEMOV+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO)) <> AllTrim(cMatric) .And. ;
															AllTrim(BEA->BEA_MATANT) <> AllTrim(cMatric) .and. cTipo == '2' .and. !empty(cNumAut) .And. lUsrPMA

																aAreaAnt:= BA1->(GetArea())

																dBSelectArea ("BA1")
																dBSetOrder(2)

																If BA1->(dbSeek(xFilial("BA1")+BEA->(BEA_OPEMOV+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO))) .And. !Empty(BA1->BA1_DATBLO)

																	If dDatPro>BA1->BA1_DATBLO+nDiasBloq .And. BEA->BEA_VALSEN<dDatPro
																		lUsrBEA:=.T.

																		PExErr(aRet, "** ERRO ["+__aXMLCri46[1]+"] **",__aXMLCri46[1],nI,nil,nil,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aXMLCri46[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri46[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Beneficiario: "+cNomeUsu+"       Matricula Liberacao: "+BEA->(BEA_OPEMOV+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO)+"       Matricula Bloqueada: "+BEA->(BEA_OPEMOV+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO),__aXMLCri46[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Matricula XML: "+AllTrim(cMatric),__aXMLCri46[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"",__aXMLCri46[1],nI,nil,nil,cSeqBXX)
																	EndIf
																	RestArea(aAreaAnt)
																EndIf

																If BA1->(dbSeek(xFilial("BA1")+AllTrim(cMatric))) .And. !Empty(BA1->BA1_DATBLO) .and. !lUsrBEA

																	If dDatPro>BA1->BA1_DATBLO+nDiasBloq .And. BEA->BEA_VALSEN<dDatPro
																		lUsrXBl:=.T.

																		PExErr(aRet, "** ERRO ["+__aXMLCri46[1]+"] **",__aXMLCri46[1],nI,nil,nil,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aXMLCri46[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri46[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Beneficiario: "+cNomeUsu+"       Matricula Liberacao: "+BEA->(BEA_OPEMOV+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO)+"       Matricula Bloqueada: "+AllTrim(cMatric),__aXMLCri46[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Matricula XML: "+AllTrim(cMatric),__aXMLCri46[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"",__aXMLCri46[1],nI,nil,nil,cSeqBXX)

																	EndIf
																	RestArea(aAreaAnt)
																EndIf
															EndIf

														EndIf
														BEA->(DbGoTo(nRecnoAut))
														If  PLSPOSGLO(cOpeMov,__aCdCri163[1],__aCdCri163[2],cLocalExec,"1",cTipoGrv) .and. lFoundAut
															If  AllTrim(BEA->(BEA_OPEMOV+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO)) <> AllTrim(cMatric) .And. ;
															AllTrim(BEA->BEA_MATANT) <> AllTrim(cMatric) .and. cTipo == '2' .and. !empty(cNumAut).and. (IIf (lUsrPMA,(!lUsrBEA .And. !lUsrXBl),.T.))

																PExErr(aRet, "** ERRO ["+__aCdCri163[1]+"] **",__aCdCri163[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aCdCri163[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aCdCri163[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aCdCri163[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"",__aCdCri163[1],nI,nil,nil,cSeqBXX)
															Endif
														Endif
													Endif
												Endif

												If PLSPOSGLO(cOpeMov,__aXMLCri23[1],__aXMLCri23[2],cLocalExec,"1",cTipoGrv)
													If cTipGui $ "05#06"
														If !Empty(cNumAut)
															BE4->( DbSetOrder(2) )
															If !BE4->( MsSeek( xFilial("BE4")+padr(cNumAut,18) ) )
																BE4->( DbSetOrder(7) )
																If !BE4->( MsSeek( xFilial("BE4")+padr(cNumAut,9) ) )

																	PExErr(aRet, "** ERRO ["+__aXMLCri23[1]+"] **",__aXMLCri23[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																Endif
															Endif
															lFoundAut := BE4->(Found())
															nRecnoAut := BE4->(Recno())
															//se achou uma liberacao e a liberacao foi negada
															If  PLSPOSGLO(cOpeMov,__aXMLCri36[1],__aXMLCri36[2],cLocalExec,"1",cTipoGrv) .and. ;
															lFoundAut .and. BE4->BE4_STATUS == '3' .and. cTipGui $ "05#06" .and. !Empty(cNumAut)


																PExErr(aRet, "** ERRO ["+__aXMLCri36[1]+"] **",__aXMLCri36[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri36[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri36[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri36[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"",__aXMLCri36[1],nI,nil,nil,cSeqBXX)
															Endif
															//Regra para data da alta automatica
															lAltaut := .F.
															If BAU->(FieldPos("BAU_GRALAU")) > 0
																BAU->(dbSetOrder(1))
																//Nao tem alta automatica para a RDA, nao deixo importar com data de alta preenchida
																If BAU->(msSeek(xFilial("BAU")+ cRdaOri)) .And. BAU->BAU_GRALAU == "1"
																	lAltaut := .T.
																EndIf
															EndIF

															If PLSPOSGLO(cOpeMov,__aCdCri152[1],__aCdCri152[2],cLocalExec,"1",cTipoGrv) .and. lFoundAut .and. cTipGui $ "05" .and. !Empty(BE4->BE4_DTALTA) .AND. GetNewPar("MV_PLINTIP",.T.)

																PExErr(aRet, "** ERRO ["+__aCdCri152[1]+"] **",__aCdCri152[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aCdCri152[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aCdCri152[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aCdCri152[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"",__aCdCri152[1],nI,nil,nil,cSeqBXX)
															Endif
															If PLSPOSGLO(PLSINTPAD(),__aCdCri163[1],__aCdCri163[2],cLocalExec,"1",cTipoGrv) .and. lFoundAut
																If  AllTrim(BE4->(BE4_CODOPE+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO)) <> AllTrim(cMatric) .And. ;
																AllTrim(BE4->BE4_MATANT) <> AllTrim(cMatric)


																	PExErr(aRet, "** ERRO ["+__aCdCri163[1]+"] **",__aCdCri163[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aCdCri163[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aCdCri163[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aCdCri163[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aCdCri163[1],nI,nil,nil,cSeqBXX)
																Endif
															Endif
														Else
															If cTipGui $ "05" .And. Empty( cNumAut )

																PExErr(aRet, "** ERRO ["+__aXMLCri23[1]+"] **",__aXMLCri23[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri23[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"",__aXMLCri23[1],nI,nil,nil,cSeqBXX)
															EndIf

														EndIf
													EndIf
												Endif

												Do Case
													Case cTipo == "1"
													cNomCont := AllTrim( PLSPCONGR("NOMECONTRATADO",cGuia+"\DADOSCONTRATADO",aMatMCp,,.T.) )
													cCodRP 	 := AllTrim( PLSPCONGR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSCONTRATADO\IDENTIFICACAO",aMatMCp,,.T.) )
													cCodRP 	 := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
													nIdx 	 := 4
													If Empty(cCodRP)
														cCodRP := PLSPCONGR("CODIGOPRESTADORNAOPERADORA",cGuia+"\DADOSCONTRATADO\IDENTIFICACAO",aMatMCp,,.T.)
														nIdx 	:= 1
													EndIf
													If Len(alltrim(cCodRP)) > TamSX3("BAU_CODIGO")[1]
														nIdx 	 := 4
													Else
														cCodRP   := padr(cCodRP,6)
														nIdx 	 := 1
													Endif
													PLSIVRDA(cCodRP,nIdx,"E",aDados)
													PLSXPROF("R",cCodRP,"2",cNumImp,cOrigGu,nIdx,cData,cHora,"E",aDados,aMatC)
													lFlag := .t.
													If BAU->( Found() )
														cCodRP	  := BAU->BAU_CODIGO
														cNomRda   := BAU->BAU_NOME
														cNomPre	  := BAU->BAU_NOME
													Else
														//essa critica nao faz sentido desabilita-la pois se eu nao sei o contratado eu
														//nao consigo achar nem o prestador...
														PLSPOSGLO(cOpeMov,__aXMLCri24[1],__aXMLCri24[2],cLocalExec,"1",cTipoGrv)
														lFlag := .f.
														PExErr(aRet, "** ERRO ["+__aXMLCri24[1]+"] **")
														PExErr(aRet,PLSBCTDESC())
														PExErr(aRet,"Codigo enviado: "+cCodRP)
														PExErr(aRet,"Beneficiario: "+cNomeUsu)
														PExErr(aRet,"")
													Endif
													If lFlag
														cIdenfic := "DADOSCONTRATADO"
														cSigla 	:= PLSPCONGR("SIGLACONSELHO",cGuia+"\PROFISSIONALEXECUTANTE\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cCrm 	:= PLSPCONGR("NUMEROCONSELHO",cGuia+"\PROFISSIONALEXECUTANTE\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cUf 	:= PLSPCONGR("UFCONSELHO",cGuia+"\PROFISSIONALEXECUTANTE\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cNome   := PLSPCONGR("NOMEPROFISSIONAL",cGuia+"\PROFISSIONALEXECUTANTE",aMatMCp,,.T.)
														cCbos 	:= PLSPCONGR("CBOS",cGuia+"\PROFISSIONALEXECUTANTE",aMatMCp,,.T.,.F.)

														If ExistBlock("PLTISESP")
															aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
															If ValType(aRetPe) == "A"
																cCbos  := aRetPe[1]
																cEspPe := aRetPe[2]
															Endif
														EndIf

														nIdx	:= 4

														IF Empty(cSigla).or.Empty(cCrm) .or.Empty(cUf)
															If PLSPOSGLO(cOpeMov,__aXMLCri34[1],__aXMLCri34[2],cLocalExec,"1",cTipoGrv)

																PExErr(aRet, "** ERRO ["+__aXMLCri34[1]+"] **",__aXMLCri34[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri34[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Sigla do Conselho: "+cSigla,__aXMLCri34[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Numero do Conselho: "+cCrm,__aXMLCri34[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Uf do Conselho: "+cUf,__aXMLCri34[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri34[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"",__aXMLCri34[1],nI,nil,nil,cSeqBXX)
															Endif

														Endif

														PLSIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados,nil,cCbos)
														PLSXSCU("",cSigla,cCrm,cUf,"E",aDados,nil,nil,cNome,cCbos,cData,,cTissVer)
														If BB0->( Found() )
															cSlgRda := cSigla //Sigla
															cCrmRda := cCrm //Numero
															cEstRda := cUf //Estado
															cNomPre := cNome

															If  PlsAliasExi("BQ1") .and. !Empty(cCbos) //.and. PLSPOSGLO(cOpeMov,__aXMLCri10[1],__aXMLCri10[2],cLocalExec,"1",cTipoGrv)
																BQ1->(DbSetORder(1))
																BAQ->(DbSetOrder(4))
																BAU->(DbSetOrder(5))
																lAchou := .F.
																If BAQ->( MsSeek( xFilial("BAQ")+cOpeMov+cCbos ) ) //o CBOS pode estar relacionado a mais de uma especialidade
																	While BAQ->(!EOF()) .AND. ALLTRIM(BAQ->(BAQ_FILIAL+BAQ_CODINT+BAQ_CBOS)) == ALLTRIM(xFilial("BAQ")+cOpeMov+cCbos) .and. !lAchou
																		If BQ1->(MsSeek(xFilial('BQ1')+BB0->BB0_CODIGO+BAQ->BAQ_CODESP))
																			lAchou:=.T.
																			Exit
																		ElseIf (BAU->( MsSeek( xFilial("BB0")+BB0->BB0_CODIGO ) ) .and. pTemEspAtv(cOpeMov,cData)) // procuro NO BAX mas nao pode estar bloqueado
																			lAchou :=.T.
																			Exit
																		Endif
																		BAQ->(Dbskip())
																	Enddo
																Endif
																PLSPOSGLO(cOpeMov,__aXMLCri10[1],__aXMLCri10[2],cLocalExec,"1",cTipoGrv)
																If !lAchou .and. aScan(aExistX10,{|x| x == cNome}) == 0
																	aadd(aExistX10,cNome)
																	PExErr(aRet, "** ERRO ["+__aXMLCri10[1]+"] **")
																	PExErr(aRet,PLSBCTDESC())
																	PExErr(aRet,"Nao foi encontrada especialidade ativa para este profissional na data informada")
																	PExErr(aRet,"Data: "+dtoc(stod(cData)))
																	PExErr(aRet,"CBOS enviado: "+cCbos)
																	PExErr(aRet,"Membro de Equipe: "+cNome)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu)
																	PExErr(aRet,"")

																Endif

																Eval(bRest1)

																Eval(bRest2)


															Endif


														Else
															If PLSPOSGLO(cOpeMov,__aXMLCri34[1],__aXMLCri34[2],cLocalExec,"1",cTipoGrv)

																PExErr(aRet, "** ERRO ["+__aXMLCri34[1]+"] **",__aXMLCri34[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri34[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri34[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"",__aXMLCri34[1],nI,nil,nil,cSeqBXX)
															Endif
														Endif
														lFlag := .t.
														If PLSPOSGLO(cOpeMov,__aXMLCri25[1],__aXMLCri25[2],cLocalExec,"1",cTipoGrv)
															If !Empty(cCbos)
																BAQ->(DbSetORder(4))
																BAQ->(MsSeek(xFilial("BAQ")+cOpeMov+cCbos))
																If !U_CBTRCBOS(cCbos,.F.,dDatPro,cCodRda,cCrm,cUf,aDados,nil,nil,nil,cTissVer)[1]
																	lFlag := .f.
																	PExErr(aRet, "** ERRO ["+__aXMLCri25[1]+"] **",__aXMLCri25[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"CBOS enviado: "+cCbos,__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																EndIf
															EndIf
														Endif
														If PLSPOSGLO(cOpeMov,__aXMLCri10[1],__aXMLCri10[2],cLocalExec,"1",cTipoGrv)
															If lFlag .and. !Empty(cCbos)
																aEsp := CBOSRda(cCodRP,cOpeMov,BAQ->BAQ_CODESP,cData)
																If aEsp[1]
																	AaDd( aDados, {"CODESP" , aEsp[3] } )
																Else
																	If aScan(aExistX10,{|x| x == cNomRda }) == 0
																		aadd(aExistX10,cNomRda)

																		PExErr(aRet, "** ERRO ["+__aXMLCri10[1]+"] **",__aXMLCri10[1],nI,nil,nil,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"CBOS enviado: "+cCbos,__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																		If !Empty(cNomRda)
																			PExErr(aRet,"Prestador: "+cNomRda,__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																		Endif
																		PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"",__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																	EndIf
																EndIf
															EndIf
														Endif
													Endif

													//sadt
													Case cTipo == "2"

													cNomCont := AllTrim( PLSPCONGR("NOMECONTRATADO",cGuia+"\PRESTADOREXECUTANTE",aMatMCp,,.T.) )
													cCodRP   := AllTrim( PLSPCONGR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\PRESTADOREXECUTANTE\IDENTIFICACAO",aMatMCp,,.T.) )
													cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
													nIdx 	:= 4
													If Empty(cCodRP)
														cCodRP := PLSPCONGR("CODIGOPRESTADORNAOPERADORA",cGuia+"\PRESTADOREXECUTANTE\IDENTIFICACAO",aMatMCp,,.T.)
														nIdx := 1
													EndIf
													If Len(alltrim(cCodRP)) > TamSX3("BAU_CODIGO")[1]
														nIdx 	 := 4
													else
														cCodRP  := padr(cCodRP,6)
														nIdx 	 := 1
													endif
													//na guia sadt o contratado vem no campo do executante por isso procuro a rda
													PLSIVRDA(cCodRP,nIdx,,aDados)
													PLSXPROF("R",cCodRP,"5",cNumImp,cOrigGu,nIdx,cData,cHora,,aDados,aMatC)
													lFlag := .t.
													If BAU->( Found() )
														cConPrEx := BAU->BAU_CODIGO
														cNomRdEx := BAU->BAU_NOME
													Else
														cConPrEx := ""
														cNomRdEx := ""
														PLSPOSGLO(cOpeMov,__aXMLCri26[1],__aXMLCri26[2],cLocalExec,"1",cTipoGrv)

														PExErr(aRet, "** ERRO ["+__aXMLCri26[1]+"] **",__aXMLCri26[1],nI,nil,nil,cSeqBXX,.t.)
														PExErr(aRet,PLSBCTDESC(),__aXMLCri26[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"Codigo enviado: "+cCodRP,__aXMLCri26[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri26[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"",__aXMLCri26[1],nI,nil,nil,cSeqBXX)
														lFlag := .f.
													Endif

													cTpAtend := PLSPCONGR("TIPOATENDIMENTO",cGuia,aMatMCp,,.T.,.F.)
													if PLSPOSGLO(cOpeMov,__aCdCri128[1],__aCdCri128[2],cLocalExec,"1",cTipoGrv) .and. ;
													(!(cTpAtend $ ("01/02/03/04/05/06/07/08/09/10")) .OR. Empty(cTpAtend))

														PExErr(aRet, "** ERRO ["+__aCdCri128[1]+"] **",__aCdCri128[1],nI,nil,nil,cSeqBXX,.t.)
														PExErr(aRet,"Tipo de Atendimento Invalido :   "+cTpAtend,__aCdCri128[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"",__aCdCri128[1],nI,nil,nil,cSeqBXX)

													Endif

													cTpCarate := PLSPCONGR("CARATERATENDIMENTO",cGuia,aMatMCp,,.T.,.F.)
													if (!(cTpCarate $ ("E/U")) .OR. Empty(cTpCarate)) .and. PLSPOSGLO(cOpeMov,__aXMLCri41[1],__aXMLCri41[2],cLocalExec,"1",cTipoGrv)

														PExErr(aRet, "** ERRO ["+__aXMLCri41[1]+"] **",__aXMLCri41[1],nI,nil,nil,cSeqBXX,.t.)
														PExErr(aRet,"Carater de Atendimento invalido :   "+cTpCarate,__aXMLCri41[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"",__aXMLCri41[1],nI,nil,nil,cSeqBXX)

													Endif
													cTmpDoe := PLSPCONGR("VALOR",cGuia+"\DIAGNOSTICOATENDIMENTO"+"\TEMPOREFERIDOEVOLUCAODOENCA",aMatMCp,,.T.,.F.)
													if len(cTmpDoe) > TamSX3("BEA_TPODOE")[1] .AND. PLSPOSGLO(cOpeMov,__aXMLCri45[1],__aXMLCri45[2],cLocalExec,"1",cTipoGrv)

														PExErr(aRet, "** ERRO ["+__aXMLCri45[1]+"] **",__aXMLCri45[1],nI,nil,nil,cSeqBXX,.t.)
														PExErr(aRet,"Tempo da Evolucao da Doenca Invalido :   "+cTmpDoe,__aXMLCri45[1],,nI,nil,nil,cSeqBXX)
														PExErr(aRet,"",__aXMLCri45[1],nI,nil,nil,cSeqBXX)

													Endif
													If lFlag
														cIdenfic := "PRESTADOREXECUTANTE"
														cCodPCPL := ""
														cSigla 	:= PLSPCONGR("SIGLACONSELHO",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cCrm 	:= PLSPCONGR("NUMEROCONSELHO",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cUf 	:= PLSPCONGR("UFCONSELHO",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cNome	:= PLSPCONGR("NOMEEXECUTANTE",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL",aMatMCp,,.T.)
														cCbos 	:= PLSPCONGR("CODIGOCBOS",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL",aMatMCp,,.T.,.F.)

														If ExistBlock("PLTISESP")
															aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
															If ValType(aRetPe) == "A"
																cCbos  := aRetPe[1]
																cEspPe := aRetPe[2]
															Endif
														EndIf

														nIdx 	:= 4

														PLSIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados,nil,cCbos)
														PLSXSCU("",cSigla,cCrm,cUf,"E",aDados,nil,nil,cNome,cCbos,cData,,cTissVer)

														If BB0->( Found() )
															cCodPCPL := BB0->BB0_CODIGO
															cNomPre  := BB0->BB0_NOME
															If  PlsAliasExi("BQ1") .and. !Empty(cCbos) .and. ;
															PLSPOSGLO(cOpeMov,__aXMLCri10[1],__aXMLCri10[2],cLocalExec,"1",cTipoGrv)
																BQ1->(DbSetORder(1))
																BAQ->(DbSetOrder(4))
																BAU->(DbSetOrder(5))
																lAchou := .F.

																If BAQ->( MsSeek( xFilial("BAQ")+cOpeMov+cCbos ) ) //o CBOS pode estar relacionado a mais de uma especialidade
																	While BAQ->(!EOF()) .AND. ALLTRIM(BAQ->(BAQ_FILIAL+BAQ_CODINT+BAQ_CBOS)) ==  ALLTRIM(xFilial("BAQ")+cOpeMov+cCbos) .and. !lAchou
																		If BQ1->(MsSeek(xFilial('BQ1')+BB0->BB0_CODIGO+BAQ->BAQ_CODESP))
																			lAchou:=.T.
																			Exit
																		ElseIf (BAU->( MsSeek( xFilial("BB0")+BB0->BB0_CODIGO ) ) .and. pTemEspAtv(cOpeMov,cData)) // procuro NO BAX mas nao pode estar bloqueado
																			lAchou :=.T.
																			Exit
																		Endif
																		BAQ->(Dbskip())
																	Enddo
																Endif

																If !lAchou .and. aScan(aExistX10,{|x| x == BB0->BB0_NOME }) == 0
																	aadd(aExistX10,BB0->BB0_NOME)
																	PExErr(aRet, "** ERRO ["+__aXMLCri10[1]+"] **")
																	PExErr(aRet,PLSBCTDESC())
																	PExErr(aRet,"Nao foi encontrada especialidade ativa para este profissional na data informada")
																	PExErr(aRet,"Data: "+dtoc(stod(cData)))
																	PExErr(aRet,"CBOS enviado: "+cCbos)
																	PExErr(aRet,"Membro de Equipe: "+BB0->BB0_NOME)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu)
																	PExErr(aRet,"")

																Endif

																Eval(bRest1)

																Eval(bRest2)

															Endif
														Else
															cCodPCPL := ""
															cNomPre  := ""
														Endif

														If Empty(cCodPCPL)
															cCodRP 	:= AllTrim( PLSPCONGR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CODIGOPROFISSIONALCOMPL",aMatMCp,,.T.) )
															cCodRP 	:= cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
															nIdx 	:= 3
															If Empty(cCodRP)
																cCodRP 	:= PLSPCONGR("CODIGOPRESTADORNAOPERADORA",cGuia+"\PRESTADOREXECUTANTE\PROFISSIONALEXECUTANTECOMPL\CODIGOPROFISSIONALCOMPL",aMatMCp,,.T.)
																nIdx	:= 1

																//significa que o meu cliente me mandou o BAU_CODRDA no CODIGOPRESTADORNAOPERADORA
																If Len(alltrim(cCodRP)) == 6
																	nOrdBAU := BAU->(IndexOrd())
																	nRecBAU := BAU->(Recno())
																	BAU->(DbSetOrder(1))
																	If  BAU->(MsSeek(xFilial("BAU")+padr(cCodRP,6))) .and. !Empty(BAU->BAU_CODBB0)
																		cCodRP := BAU->BAU_CODBB0
																	Endif
																	BAU->(DbGoTo(nRecBAU))
																	BAU->(DbSetOrder(nOrdBAU))
																Endif
															EndIf
															PLSIVPRO(cCodRP,'','','',nIdx,"E",aDados,nil,cCbos)
															PLSXSCU(cCodRP,'','','',"E",aDados,nil,nil,cNome,cCbos,cData,,cTissVer)
															If BB0->( Found() )
																cCodPCPL := BB0->BB0_CODIGO
																cNomPre  := BB0->BB0_NOME


																If  PlsAliasExi("BQ1") .and. !Empty(cCbos) .and. ;
																PLSPOSGLO(cOpeMov,__aXMLCri10[1],__aXMLCri10[2],cLocalExec,"1",cTipoGrv)
																	BQ1->(DbSetORder(1))
																	BAQ->(DbSetOrder(4))
																	BAU->(DbSetOrder(5))
																	lAchou := .F.

																	If BAQ->( MsSeek( xFilial("BAQ")+cOpeMov+cCbos ) ) //o CBOS pode estar relacionado a mais de uma especialidade
																		While BAQ->(!EOF()) .AND. ALLTRIM(BAQ->(BAQ_FILIAL+BAQ_CODINT+BAQ_CBOS)) == ALLTRIM(xFilial("BAQ")+cOpeMov+cCbos) .and. !lAchou
																			If BQ1->(MsSeek(xFilial('BQ1')+BB0->BB0_CODIGO+BAQ->BAQ_CODESP))
																				lAchou:=.T.
																				Exit
																			ElseIf (BAU->( MsSeek( xFilial("BB0")+BB0->BB0_CODIGO ) ) .and. pTemEspAtv(cOpeMov,cData)) // procuro NO BAX mas nao pode estar bloqueado
																				lAchou :=.T.
																				Exit
																			Endif
																			BAQ->(Dbskip())
																		Enddo
																	Endif

																	If !lAchou .and. aScan(aExistX10,{|x| x == BB0->BB0_NOME}) == 0
																		aadd(aExistX10,BB0->BB0_NOME)
																		PExErr(aRet, "** ERRO ["+__aXMLCri10[1]+"] **")
																		PExErr(aRet,PLSBCTDESC())
																		PExErr(aRet,"Nao foi encontrada especialidade ativa para este profissional na data informada")
																		PExErr(aRet,"Data: "+dtoc(stod(cData)))
																		PExErr(aRet,"CBOS enviado: "+cCbos)
																		PExErr(aRet,"Membro de Equipe: "+BB0->BB0_NOME)
																		PExErr(aRet,"Beneficiario: "+cNomeUsu)
																		PExErr(aRet,"")

																	Endif
																	Eval(bRest1)

																	Eval(bRest2)

																Endif
															Else
																cCodPCPL := ""
																cNomPre  := ""
															Endif
														Endif

														If !Empty(cCodPCPL)
															cCodRP  := PLSRETDAD( aDados,"CODRDA","" )
															cNomRda := PLSRETDAD( aDados,"NOMRDA","" )
															cSlgRda := BB0->BB0_CODSIG
															cCrmRda := BB0->BB0_NUMCR
															cEstRda := BB0->BB0_ESTADO
															cNomPre := BB0->BB0_NOME

															//Aqui eu faco um tratamento para que leve la para o BD7 o codigo
															//da RDA (se o profissional for uma RDA) executante no campo BD7_CDPFPR
															cCodBAU := ""
															nRecBAU := BAU->(Recno())
															nOrdBAU := BAU->(IndexOrd())
															BAU->(DbSetOrder(5))
															If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
																cCodBAU := BAU->BAU_CODBB0
															Endif
															BAU->(DbGoTo(nRecBAU))
															BAU->(DbSetOrder(nOrdBAU))

															aSlvBWT := aClone(aMatBWT)
															lEntrou := .F.
															while ( nPos := aScan( aMatBWT,{ |x|x[3]=='12' } ) ) > 0
																AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU } )
																lEntrou := .T.

																nSize := Len(aMatBWT)
																aDel(aMatBWT,nPos)
																aSize(aMatBWT,nSize-1)
															Enddo
															If !lEntrou
																AaDd( aTpPRec,{ GetNewPar("MV_PLSNAPL","O"),If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU } )
															EndIf

															aMatBWT := aClone(aSlvBWT)
															AaDd( aDados, {"ATPARG" , aTpPRec } )
															aTpPRec := {}

															cNomRda := ""
															cCrmRda := ""
															cSlgRda := ""
															cEstRda := ""
														Else
															If PLSPOSGLO(cOpeMov,__aXMLCri38[1],__aXMLCri38[2],cLocalExec,"1",cTipoGrv)
																If 	!Empty(cSigla) .or. !Empty(cCrm) .or. !Empty(cUf) 	.or. !Empty(cNome) .or. !Empty(cCodRP)

																	PExErr(aRet, "** ERRO ["+__aXMLCri38[1]+"] **",__aXMLCri38[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aXMLCri38[1],nI,nil,nil,cSeqBXX)
																	If !Empty(cSigla)
																		PExErr(aRet,"Siga Conselho: "+cSigla,__aXMLCri38[1],nI,nil,nil,cSeqBXX)
																	Endif
																	If !Empty(cCrm)
																		PExErr(aRet,"Codigo Conselho: "+cCrm,__aXMLCri38[1],nI,nil,nil,cSeqBXX)
																	Endif
																	If !Empty(cUf)
																		PExErr(aRet,"Estado Conselho: "+cUf,__aXMLCri38[1],nI,nil,nil,cSeqBXX)
																	Endif
																	If !Empty(cNome)
																		PExErr(aRet,"Nome Profissional: "+cNome,__aXMLCri38[1],nI,nil,nil,cSeqBXX)
																	Endif
																	If !Empty(cCodRP)
																		PExErr(aRet,"Codigo Profissional na Operadora: "+cCodRP,__aXMLCri38[1],nI,nil,nil,cSeqBXX)
																	Endif
																	PExErr(aRet,"",__aXMLCri38[1],nI,nil,nil,cSeqBXX)
																Endif
															Endif
														Endif
														lFlag := .t.
														If PLSPOSGLO(cOpeMov,__aXMLCri25[1],__aXMLCri25[2],cLocalExec,"1",cTipoGrv)
															If !Empty(cCbos)
																BAQ->(DbSetORder(4))
																BAQ->(MsSeek(xFilial("BAQ")+cOpeMov+cCbos))
																If !U_CBTRCBOS(cCbos,.F.,dDatPro,cCodRda,cCrm,cUf,aDados,nil,nil,nil,cTissVer)[1]
																	lFlag := .f.
																	PExErr(aRet, "** ERRO ["+__aXMLCri25[1]+"] **",__aXMLCri25[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"CBOS enviado: "+cCbos,__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																EndIf
															EndIf
														Endif
														If PLSPOSGLO(cOpeMov,__aXMLCri10[1],__aXMLCri10[2],cLocalExec,"1",cTipoGrv)
															If lFlag .and. !Empty(cCbos)
																If !Empty(cRdaOri)
																	aEsp := CBOSRda(cRdaOri,cOpeMov,BAQ->BAQ_CODESP,cData)
																	If aEsp[1]
																		AaDd( aDados, {"CODESP" , aEsp[3] } )
																	Else
																		If aScan(aExistX10,{|x| x == cNomOri}) == 0
																			aadd(aExistX10,cNomOri) // para evitar repeticoes da critica x10
																			PExErr(aRet, "** ERRO ["+__aXMLCri10[1]+"] **",__aXMLCri10[1],nI,nil,nil,cSeqBXX,.t.)
																			PExErr(aRet,PLSBCTDESC(),__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																			PExErr(aRet,"CBOS enviado: "+cCbos,__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																			PExErr(aRet,"Prestador: "+cNomOri,__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																			PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																			PExErr(aRet,"",__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																		EndIf
																	EndIf
																EndIf
															EndIf
														Endif
														cSigla 	:= PLSPCONGR("SIGLACONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cCrm 	:= PLSPCONGR("NUMEROCONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cUf 	:= PLSPCONGR("UFCONSELHO",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cNome	:= PLSPCONGR("NOMEPROFISSIONAL",cGuia+"\DADOSSOLICITANTE\PROFISSIONAL",aMatMCp,,.T.)

														PLSIVPRO("",cSigla,cCrm,cUf,4,"S",aDados,(cOrigGu=="2"),cCbos)
														PLSXSCU("",cSigla,cCrm,cUf,"S",aDados,nil,(cOrigGu=="2"),cNome,cCbos,cData,,cTissVer)

													Endif
													//internacao
													Case cTipo == "3" .And. !(cTipGui$"06")

													cDataHora 	 := PLSDELIM( PLSPCONGR("DATAHORASAIDAINTERNACAO",cGuia,aMatMCp,,,.F.) )
													dDatAlta     := PLSAJUDAT(SubStr(cDataHora,1,8))

													If Empty(dDatAlta) .And. alltrim(cTipFat) == "T"  .and. PLSPOSGLO(cOpeMov,__aCdCri153[1],__aCdCri153[2],cLocalExec,"1",cTipoGrv)

														PExErr(aRet, "** ERRO ["+__aCdCri153[1]+"] **",__aCdCri153[1],nI,nil,nil,cSeqBXX,.t.)
														PExErr(aRet,PLSBCTDESC(),__aCdCri153[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"Tipo do Faturamento: Total",__aCdCri153[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"Data da Alta: VAZIO",__aCdCri153[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"",__aCdCri153[1],nI,nil,nil,cSeqBXX)

													Endif
													cNomCont := AllTrim( PLSPCONGR("NOMECONTRATADO",cGuia+"\IDENTIFICACAOEXECUTANTE",aMatMCp,,.T.) )
													cCodRP 	 := AllTrim( PLSPCONGR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\IDENTIFICACAOEXECUTANTE\IDENTIFICACAO",aMatMCp,,.T.) )
													cCodRP   := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
													nIdx     := 4

													If Empty(cCodRP)
														cCodRP := PLSPCONGR("CODIGOPRESTADORNAOPERADORA",cGuia+"\IDENTIFICACAOEXECUTANTE\IDENTIFICACAO",aMatMCp,,.T.)
														nIdx := 1
													EndIf
													If Len(alltrim(cCodRP)) > TamSX3("BAU_CODIGO")[1]
														nIdx 	 := 4
													else
														cCodRP := padr(cCodRP,6)
														nIdx 	 := 1
													endif
													PLSIVRDA(cCodRP,nIdx,,aDados)
													PLSXPROF("R",cCodRP,"5",cNumImp,cOrigGu,nIdx,cData,cHora,,aDados,aMatC)

													If BAU->( Found() )
														cConPrEx := BAU->BAU_CODIGO
														cNomRdEx := BAU->BAU_NOME
													Else
														cConPrEx := ""
														cNomRdEx := ""

														//essa critica nao faz sentido desabilita-la pois se eu nao sei o contratado eu
														//nao consigo achar nem o prestador...
														PLSPOSGLO(cOpeMov,__aXMLCri24[1],__aXMLCri24[2],cLocalExec,"1",cTipoGrv)

														PExErr(aRet, "** ERRO ["+__aXMLCri24[1]+"] **")
														PExErr(aRet,PLSBCTDESC())
														PExErr(aRet,"Codigo enviado: "+cCodRP)
														PExErr(aRet,"Beneficiario: "+cNomeUsu)
														PExErr(aRet,"")
													Endif

													cRegime := PLSPCONGR("REGIMEINTERNACAO",cGuia,aMatMCp,,.T.,.F.)
													if (!(cRegime $ ("1/2/3")) .OR. Empty(cRegime)) .and. PLSPOSGLO(cOpeMov,__aXMLCri43[1],__aXMLCri43[2],cLocalExec,"1",cTipoGrv)

														PExErr(aRet, "** ERRO ["+__aXMLCri43[1]+"] **",__aXMLCri43[1],nI,nil,nil,cSeqBXX,.t.)
														PExErr(aRet,"Regime de  Internacao  invalido :   "+cRegime,__aXMLCri43[1],nI,nil,nil,cSeqBXX)
														PExErr(aRet,"",__aXMLCri43[1],nI,nil,nil,cSeqBXX)

													Endif

													//honorario individual
													Case cTipo == "3" .And. (cTipGui $ "06")

													cDataHora 	:= PLSDELIM( PLSPCONGR("DATAHORASAIDAINTERNACAO",cGuia,aMatMCp,,,.F.) )
													dDatAlta     := PLSAJUDAT(SubStr(cDataHora,1,8))

													aTpPRec := {}
													cNomCont := AllTrim( PLSPCONGR("NOMECONTRATADO",cGuia+"\CONTRATADOEXECUTANTE",aMatMCp,,.T.) )
													cCodRP 	 := AllTrim( PLSPCONGR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAO",aMatMCp,,.T.) )
													cCodRP 	 := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
													nIdx 	 := 4
													If Empty(cCodRP)
														nIdx 	:= 1
														cCodRP := PLSPCONGR("CODIGOPRESTADORNAOPERADORA",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAO",aMatMCp,,.T.)
													EndIf
													If Len(alltrim(cCodRP)) > TamSX3("BAU_CODIGO")[1]
														nIdx 	 := 4
													else
														cCodRP	 := padr(cCodRP,6)
														nIdx 	 := 1
													endif
													PLSIVRDA(cCodRP,nIdx,,aDados)
													PLSXPROF("R",cCodRP,"6",cNumImp,cOrigGu,nIdx,cData,cHora,,aDados,aMatC)
													lFlag := .t.
													If BAU->( Found() )
														cCodRP	  := BAU->BAU_CODIGO
														cNomRda   := AllTrim(BAU->BAU_NOME)
														cNomPre	  := AllTrim(BAU->BAU_NOME)
													Else

														//essa critica nao faz sentido desabilita-la pois se eu nao sei o contratado eu
														//nao consigo achar nem o prestador...
														PLSPOSGLO(cOpeMov,__aXMLCri24[1],__aXMLCri24[2],cLocalExec,"1",cTipoGrv)
														lFlag := .f.
														PExErr(aRet, "** ERRO ["+__aXMLCri24[1]+"] **")
														PExErr(aRet,PLSBCTDESC())
														PExErr(aRet,"Codigo enviado: "+cCodRP)
														PExErr(aRet,"Beneficiario: "+cNomeUsu)
														PExErr(aRet,"")
													Endif

													If lFlag
														cIdenfic := "CONTRATADOEXECUTANTE"
														cSigla 	:= PLSPCONGR("SIGLACONSELHO",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cCrm 	:= PLSPCONGR("NUMEROCONSELHO",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cUf 	:= PLSPCONGR("UFCONSELHO",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,,.T.)
														cNome 	:= PLSPCONGR("NOMEEXECUTANTE",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL",aMatMCp,,.T.)
														cCbos 	:= PLSPCONGR("CODIGOCBOS",cGuia+"\CONTRATADOEXECUTANTE\IDENTIFICACAOPROFISSIONAL",aMatMCp,,.T.,.F.)

														If ExistBlock("PLTISESP")
															aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
															If ValType(aRetPe) == "A"
																cCbos  := aRetPe[1]
																cEspPe := aRetPe[2]
															Endif
														EndIf

														nIdx	:= 4

														PLSIVPRO("",cSigla,cCrm,cUf,nIdx,"E",aDados,nil,cCbos)
														PLSXSCU("",cSigla,cCrm,cUf,"E",aDados,nil,,cNome,cCbos,cData,,cTissVer)
														cCodBAU := ""

														If BB0->( Found() )
															cSlgRda := BB0->BB0_CODSIG
															cCrmRda := BB0->BB0_NUMCR
															cEstRda := BB0->BB0_ESTADO
															cNomPre := BB0->BB0_NOME
															//Aqui eu faco um tratamento para que leve la para o BD7 o codigo
															//da RDA (se o profissional for uma RDA) executante no campo BD7_CDPFPR
															nRecBAU := BAU->(Recno())
															nOrdBAU := BAU->(IndexOrd())
															BAU->(DbSetOrder(5))
															If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
																cCodBAU := BAU->BAU_CODBB0
															Endif
															BAU->(DbGoTo(nRecBAU))
															BAU->(DbSetOrder(nOrdBAU))
															If  PlsAliasExi("BQ1") .and. !Empty(cCbos) .and. ;
															PLSPOSGLO(cOpeMov,__aXMLCri10[1],__aXMLCri10[2],cLocalExec,"1",cTipoGrv)
																lFlag := .t.
																BQ1->(DbSetORder(1))
																BAQ->(DbSetOrder(4))
																BAU->(DbSetOrder(5))
																lAchou := .F.
																If BAQ->( MsSeek( xFilial("BAQ")+cOpeMov+cCbos ) ) //o CBOS pode estar relacionado a mais de uma especialidade
																	While BAQ->(!EOF()) .AND. ALLTRIM(BAQ->(BAQ_FILIAL+BAQ_CODINT+BAQ_CBOS)) == ALLTRIM(xFilial("BAQ")+cOpeMov+cCbos) .and. !lAchou
																		If BQ1->(MsSeek(xFilial('BQ1')+BB0->BB0_CODIGO+BAQ->BAQ_CODESP))
																			lAchou:=.T.
																			Exit
																		ElseIf (BAU->( MsSeek( xFilial("BB0")+BB0->BB0_CODIGO ) ) .and. pTemEspAtv(cOpeMov,cData)) // procuro NO BAX mas nao pode estar bloqueado
																			lAchou :=.T.
																			Exit
																		Endif
																		BAQ->(Dbskip())
																	Enddo
																Endif

																If !lAchou .and. aScan(aExistX10,{|x| x == BB0->BB0_NOME}) == 0
																	aadd(aExistX10,BB0->BB0_NOME)
																	PExErr(aRet, "** ERRO ["+__aXMLCri10[1]+"] **")
																	PExErr(aRet,PLSBCTDESC())
																	PExErr(aRet,"Nao foi encontrada especialidade ativa para este profissional na data informada")
																	PExErr(aRet,"Data: "+dtoc(stod(cData)))
																	PExErr(aRet,"CBOS enviado: "+cCbos)
																	PExErr(aRet,"Membro de Equipe: "+BB0->BB0_NOME)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu)
																	PExErr(aRet,"")

																Endif

																Eval(bRest1)

																Eval(bRest2)

															Endif
														EndIf

														If PLSPOSGLO(cOpeMov,__aXMLCri25[1],__aXMLCri25[2],cLocalExec,"1",cTipoGrv)
															If !Empty(cCbos)
																BAQ->(DbSetORder(4))
																BAQ->(MsSeek(xFilial("BAQ")+cOpeMov+cCbos))
																If !U_CBTRCBOS(cCbos,.F.,dDatPro,cCodRda,cCrm,cUf,aDados,nil,nil,nil,cTissVer)[1]

																	PExErr(aRet, "** ERRO ["+__aXMLCri25[1]+"] **",__aXMLCri25[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"CBOS enviado: "+cCbos,__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri25[1],nI,nil,nil,cSeqBXX)
																EndIf
															EndIf
														Endif
														If PLSPOSGLO(cOpeMov,__aXMLCri10[1],__aXMLCri10[2],cLocalExec,"1",cTipoGrv)
															If !Empty(cCbos)
																aEsp := CBOSRda(cCodRP,cOpeMov,BAQ->BAQ_CODESP,cData)
																If aEsp[1]
																	AaDd( aDados, {"CODESP" , aEsp[3] } )
																Else
																	If aScan(aExistX10,{|x| x == cNomPre}) == 0
																		aadd(aExistX10,cNomRda)
																		PExErr(aRet, "** ERRO ["+__aXMLCri10[1]+"] **",__aXMLCri10[1],nI,nil,nil,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"CBOS enviado: "+cCbos,__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																		If !Empty(cNomPre)
																			PExErr(aRet,"Prestador: "+cNomRda,__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																		Endif
																		PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"",__aXMLCri10[1],nI,nil,nil,cSeqBXX)
																	EndIf
																EndIf
															EndIf
														Endif
														cPosPro := PLSPCONGR("POSICAOPROFISSIONAL",cGuia+"\CONTRATADOEXECUTANTE",aMatMCp,,.T.,.F.)

														aSlvBWT := aClone(aMatBWT)
														lEntrou := .F.
														while ( nPos := aScan( aMatBWT,{ |x|x[3]==cPosPro } ) ) > 0
															AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU } )
															lEntrou := .T.

															nSize := Len(aMatBWT)
															aDel(aMatBWT,nPos)
															aSize(aMatBWT,nSize-1)
														Enddo
														If !lEntrou
															AaDd( aTpPRec,{ GetNewPar("MV_PLSNAPL","O"),If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU } )
														EndIf
														aMatBWT := aClone(aSlvBWT)

													Endif
												EndCase

												If cTipo =="1"
													aMatIte := {}
													AaDd( aMatIte, {"SEQMOV" , "001" } )
													cCodPad  := PLSPCONGR("CODIGOTABELA",cGuia+"\DADOSATENDIMENTO\PROCEDIMENTO",aMatMCp,,,.F.)
													cSlvPad  := cCodPad
													cCodPro  := PLSPCONGR("CODIGOPROCEDIMENTO",cGuia+"\DADOSATENDIMENTO\PROCEDIMENTO",aMatMCp)
													cDescric := PLSPCONGR("DESCRICAO",cGuia+"\DADOSATENDIMENTO\PROCEDIMENTO",aMatMCp,,,.F.)
													cSlvDes  := cDescric
													cCodPro  := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
													cSlvPro  := cCodPro
													cTpProc	 := ""
													dDatRea := PLSAJUDAT(Alltrim(PLSPCONGR("DATAATENDIMENTO",cGuia+"\DADOSATENDIMENTO\DATAATENDIMENTO",aMatM,nil,nil,nil,nil,cCodPeg)))

													If PLSPOSGLO(cOpeMov,__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
														aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
														If !Empty(aRetTuss[1])
															cCodPad := aRetTuss[1]
															cCodPro := aRetTuss[2]
															cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
														EndIf
													EndIf

													PLSXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)

													BR8->(DbSetOrder(1))
													If PLSPOSGLO(cOpeMov,__aXMLCri27[1],__aXMLCri27[2],cLocalExec,"1",cTipoGrv)
														If !BR8->(MsSeek(xFilial("BR8")+cCodPad+cCodPro))

															PExErr(aRet, "** ERRO ["+__aXMLCri27[1]+"] **",__aXMLCri27[1],nI,nil,nil,cSeqBXX,.t.)
															PExErr(aRet,PLSBCTDESC(),__aXMLCri27[1],nI,nil,nil,cSeqBXX)
															PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri27[1],nI,nil,nil,cSeqBXX)
															PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri27[1],nI,nil,nil,cSeqBXX)
															PExErr(aRet,"",__aXMLCri27[1],nI,nil,nil,cSeqBXX)
															aadd(aEvErros,cSlvPad+cSlvPro)
														Endif
														cTpProc := BR8->BR8_TPPROC
														If PLSPOSGLO(cOpeMov,__aXMLCri40[1],__aXMLCri40[2],cLocalExec,"1",cTipoGrv)
															If !PLSISCON(cCodPad,cCodPro)

																PExErr(aRet, "** ERRO ["+__aXMLCri40[1]+"] **",__aXMLCri40[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri40[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri40[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri40[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"",__aXMLCri40[1],nI,nil,nil,cSeqBXX)
															Endif
														Endif

													Endif


													AaDd( aMatIte, {"CODPAD" , cCodPad } )
													AaDd( aMatIte, {"CODPRO" , cCodPro} )
													AaDd( aMatIte, {"DESPRO" , cDescric} )
													AaDd( aMatIte, {"TPPROC" , cTpProc } )

													AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
													AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
													AaDd( aMatIte, {"SLVDES" , cSlvDes} )

													AaDd( aMatIte, {"QTD"	 , 1 } )
													AaDd( aMatIte, {"QTDAUT" , 1 } )
													AaDd( aMatIte, {"VLRAPR" , 0 } )
													AaDd(aItens,aMatIte)
												Else
													cSeq := "001"

													While !Empty( ( aMatPro := PLSPCONGR("CODIGO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.F.,,.T.) )[1] )
														lAchouVlr  := .F. //Reinicializa a variavel de valor apresentado
														nPosVlrApr := 0 //Reinicializa a posicao da tag CODIGO para verificar se foi informado o valor do procedimento

														cCodPro := aMatPro[1]
														cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
														cCodPad := PLSPCONGR("TIPOTABELA",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.,.F.)

														BR8->(DbSetOrder(1))
														If !BR8->(MsSeek(xFilial("BR8")+cCodPad+cCodPro)) .And. GetNewPar("MV_PLPSPXM","99999994")  <> "" .And. Posicione("BCT",1,xFilial("BCT")+cOpeMov+__aXMLCri27[1],"BCT_ATIVO") = "0"
															cSlvPro := GetNewPar("MV_PLPSPXM","99999994")
														Else
															cSlvPro := cCodPro//dennis
														Endif

														aMatIte := {}
														AaDd( aMatIte, {"SEQMOV" , cSeq } )
														cSeq 	:= soma1(cSeq)
														cTpProc := ""
														dDatRea := PLSAJUDAT(Alltrim(PLSPCONGR("DATAEXECUCAO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatM,nil,nil,nil,nil,cCodPeg)))

														//cCodPad := PLSPCONGR("TIPOTABELA",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.,.F.)
														cSlvPad := cCodPad

														cDescric := PLSPCONGR("DESCRICAO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.,.F.)
														cSlvDes  := cDescric

														If PLSPOSGLO(cOpeMov,__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
															aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
															If !Empty(aRetTuss[1])
																cCodPad := aRetTuss[1]
																cCodPro := aRetTuss[2]
																cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
															EndIf
														EndIf

														PLSXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)
														BR8->(DbSetOrder(1))
														If PLSPOSGLO(cOpeMov,__aXMLCri27[1],__aXMLCri27[2],cLocalExec,"1",cTipoGrv)
															If !BR8->(MsSeek(xFilial("BR8")+cCodPad+cCodPro))

																PExErr(aRet, "** ERRO ["+__aXMLCri27[1]+"] **",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																aadd(aEvErros,cSlvPad+cSlvPro)
															Endif
															cTpProc := BR8->BR8_TPPROC
														Endif
														AaDd( aMatIte, {"CODPAD" , cCodPad } )
														AaDd( aMatIte, {"CODPRO" , cCodPro } )
														AaDd( aMatIte, {"DESPRO" , cDescric} )
														AaDd( aMatIte, {"TPPROC" , cTpProc } )

														AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
														AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
														AaDd( aMatIte, {"SLVDES" , cSlvDes} )

														//eu carrego todas as composicoes possiveis ou seja, vou pegar o que tiver no bd4 - nao mexer aqui - consultar daher
														aSlvTprec := aClone(aTpPRec)
														If Len(aTpPRec) == 0
															For nPos:=1 to Len (aMatBWT)
																AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU } )
															Next
														Endif
														If Len(aTpPRec) > 0
															AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
														Endif
														aTpPRec := aClone(aSlvTprec)

														nQtd := Val( PLSPCONGR("QUANTIDADEREALIZADA",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.,.F.) )
														AaDd( aMatIte, {"QTD" , nQtd } )
														AaDd( aMatIte, {"QTDAUT" , nQtd } )

														nPosVlrApr := aScan (aMatMCp,{ |x|x[1] == "CODIGO" .and. alltrim(cCodPro) == alltrim(x[2]) .And. "\PROCEDIMENTOSREALIZADOS" $ x[3]})
														If nPosVlrApr <> 0
															nPosVlrApr ++
															While nPosVlrApr <= len(aMatMCp) .And. aMatMCp[nPosVlrApr][1] <> "CODIGO"
																If aMatMCp [nPosVlrApr][1] == "VALOR"
																	nVlrApr := Val( strtran( PLSPCONGR("VALOR",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.,.F.),',',"." ) )
																	AaDd( aMatIte, {"VLRAPR" , nVlrApr } )
																	If nQtd > 0
																		nValTot += nVlrApr*nQtd
																	Else
																		nValTot += nVlrApr
																	Endif
																	lAchouVlr := .T.
																	Exit
																EndIf
																nPosVlrApr ++
															EndDo
														EndIf

														If !lAchouVlr
															AaDd( aMatIte, {"VLRAPR" , 0 } )
														EndIf

														AaDd( aMatIte, {"HORINI" , SubStr(PLSPCONGR("HORAINICIO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.),1,5) } )
														AaDd( aMatIte, {"HORFIM" , SubStr(PLSPCONGR("HORAFIM",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.),1,5) } )

														dDataPrcRel := PLSAJUDAT( PLSPCONGR("DATA",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.) )

														AaDd( aMatIte, {"DATPRO" , dDataPrcRel } )

														If dDataPrcRel > MsDate()
															If PLSPOSGLO(cOpeMov,__aXMLCri42[1],__aXMLCri42[2],cLocalExec,"1",cTipoGrv)

																PExErr(aRet, "** ERRO ["+__aXMLCri42[1]+"] **",__aXMLCri42[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																PExErr(aRet,Alltrim(PLSBCTDESC())+" -  "+StrZero(Day(dDataPrcRel),2) + '/' + StrZero(Month(dDataPrcRel),2) + '/' + StrZero(Year(dDataPrcRel),4),__aXMLCri42[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"",__aXMLCri42[1],nI,cCodPad,cCodPro,cSeqBXX)
															Endif
														Endif
														aTpPRe2 := {}
														While !Empty( (aMatEqu := PLSPCONGR("POSICAOPROFISSIONAL",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE",aMatMCp,,,,.T.) )[1] ) .And. aMatEqu[2] < aMatPro[2]

															cSigla 	:= ""
															cCrm 	:= ""
															cUf 	:= ""
															cNome   := ""
															cCbos   := ""
															BB0->(MsSeek('##'))//limpo o found()

															aMatMCp[aMatEqu[2],1] := "*"+aMatMCp[aMatEqu[2],1]
															cCodRP := PLSPCONGR("CPF,CNPJ,CODIGOPRESTADORNAOPERADORA",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\CODIGOPROFISSIONAL",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
															cCodRP := cCodRP+Space( TamSX3("BAU_CPFCGC")[1]-Len(cCodRP) )
															cCbos 	:= PLSPCONGR("CODIGOCBOS",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
															cSigla 	:= PLSPCONGR("SIGLACONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
															cCrm 	:= PLSPCONGR("NUMEROCONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
															cUf 	:= PLSPCONGR("UFCONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
															nIdx 	:= 3

															If ExistBlock("PLTISESP")
																aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{cCbos} )
																If ValType(aRetPe) == "A"
																	cCbos  := aRetPe[1]
																	cEspPe := aRetPe[2]
																Endif
															EndIf

															PLSIVPRO(cCodRP,'','','',nIdx,,aDados,nil,cCbos)
															PLSXSCU(cCodRP,cSigla,cCrm,cUf,'',NIL,nil,nil,'',cCbos,cData,,cTissVer)

															If !BB0->(Found())
																cCodRP := PLSPCONGR("CODIGOPRESTADORNAOPERADORA",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\CODIGOPROFISSIONAL",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
																nIdx 	:= 1
																If !Empty(cCodRP)
																	//significa que o meu cliente me mandou o BAU_CODRDA no CODIGOPRESTADORNAOPERADORA
																	If Len(alltrim(cCodRP)) == 6
																		nOrdBAU := BAU->(IndexOrd())
																		nRecBAU := BAU->(Recno())
																		BAU->(DbSetOrder(1))
																		If  BAU->(MsSeek(xFilial("BAU")+padr(cCodRP,6))) .and. !Empty(BAU->BAU_CODBB0)
																			cCodRP := BAU->BAU_CODBB0
																		Endif
																		BAU->(DbGoTo(nRecBAU))
																		BAU->(DbSetOrder(nOrdBAU))
																	Endif
																	PLSIVPRO(cCodRP,'','','',nIdx,,aDados,nil,cCbos)
																	PLSXSCU(cCodRP,'','','','',NIL,nil,nil,'',cCbos,cData,,cTissVer)
																Endif
															Endif

															If !BB0->(Found())
																cSigla 	:= PLSPCONGR("SIGLACONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
																cCrm 	:= PLSPCONGR("NUMEROCONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
																cUf 	:= PLSPCONGR("UFCONSELHO",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE\IDENTIFICACAOPROFISSIONAL\CONSELHOPROFISSIONAL",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
																cNome	:= PLSPCONGR("NOMEEXECUTANTE",cGuia+"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOS\EQUIPE\MEMBROEQUIPE",aMatMCp,nil,.T.,.F.,nil,nil,aMatEqu[2])
																nIdx 	:= 4
																PLSIVPRO("",cSigla,cCrm,cUf,nIdx,,aDados,nil,cCbos)
																PLSXSCU("",cSigla,cCrm,cUf,"",NIL,nil,nil,cNome,cCbos,cData,,cTissVer)
															Endif

															cCodBAU := ""
															If BB0->( Found() )
																cSlgRda := BB0->BB0_CODSIG
																cCrmRda := BB0->BB0_NUMCR
																cEstRda := BB0->BB0_ESTADO
																cNomPre := BB0->BB0_NOME
																If  PlsAliasExi("BQ1") .and. !Empty(cCbos) .and. ;
																PLSPOSGLO(cOpeMov,__aXMLCri10[1],__aXMLCri34[2],cLocalExec,"1",cTipoGrv)
																	BQ1->(DbSetORder(1))
																	BAQ->(DbSetOrder(4))
																	BAU->(DbSetOrder(5))
																	lAchou :=.F.
																	If BAQ->( MsSeek( xFilial("BAQ")+cOpeMov+cCbos ) ) //o CBOS pode estar relacionado a mais de uma especialidade
																		While BAQ->(!EOF()) .AND. ALLTRIM(BAQ->(BAQ_FILIAL+BAQ_CODINT+BAQ_CBOS)) ==  ALLTRIM(xFilial("BAQ")+cOpeMov+cCbos) .and. !lAchou
																			If BQ1->(MsSeek(xFilial('BQ1')+BB0->BB0_CODIGO+BAQ->BAQ_CODESP))
																				lAchou:=.T.
																				Exit
																			ElseIf (BAU->( MsSeek( xFilial("BB0")+BB0->BB0_CODIGO ) ) .and. pTemEspAtv(cOpeMov,cData)) // procuro NO BAX mas nao pode estar bloqueado
																				lAchou :=.T.
																				Exit
																			Endif
																			BAQ->(Dbskip())
																		Enddo
																	Endif

																	If !lAchou .and. aScan(aExistX10,{|x| x == BB0->BB0_NOME} ) == 0
																		aadd(aExistX10,BB0->BB0_NOME)
																		PExErr(aRet, "** ERRO ["+__aXMLCri10[1]+"] **")
																		PExErr(aRet,PLSBCTDESC())
																		PExErr(aRet,"Nao foi encontrada especialidade ativa para este profissional na data informada")
																		PExErr(aRet,"Data: "+dtoc(dDataPrcRel))
																		PExErr(aRet,"CBOS enviado: "+cCbos)
																		PExErr(aRet,"Membro de Equipe: "+BB0->BB0_NOME)
																		PExErr(aRet,"Beneficiario: "+cNomeUsu)
																		PExErr(aRet,"")

																	Endif


																	Eval(bRest1)

																	Eval(bRest2)
																Endif
																//Aqui eu faco um tratamento para que leve la para o BD7 o codigo
																//da RDA (se o profissional for uma RDA) executante no campo BD7_CDPFPR
																nRecBAU := BAU->(Recno())
																nOrdBAU := BAU->(IndexOrd())
																BAU->(DbSetOrder(5))
																If BAU->(MsSeek(xFilial("BAU")+BB0->BB0_CODIGO))
																	cCodBAU := BAU->BAU_CODBB0
																Endif
																BAU->(DbGoTo(nRecBAU))
																BAU->(DbSetOrder(nOrdBAU))

																//manter legado... alteracao daher
																aSlvBWT := aClone(aMatBWT)
																lEntrou := .F.
																while ( nPos := aScan( aMatBWT,{ |x|x[3]==aMatEqu[1] } ) ) > 0
																	AaDd( aTpPRe2,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU } )
																	lEntrou := .T.

																	nSize := Len(aMatBWT)
																	aDel(aMatBWT,nPos)
																	aSize(aMatBWT,nSize-1)
																Enddo
																If !lEntrou
																	AaDd( aTpPRe2,{ GetNewPar("MV_PLSNAPL","O"),If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU } )
																EndIf
																aMatBWT := aClone(aSlvBWT)

															Else
																If PLSPOSGLO(cOpeMov,__aXMLCri39[1],__aXMLCri39[2],cLocalExec,"1",cTipoGrv)
																	If 	!Empty(cSigla) .or. !Empty(cCrm) .or. !Empty(cUf) 	.or. !Empty(cNome) .or. !Empty(cCodRP)

																		PExErr(aRet, "** ERRO ["+__aXMLCri39[1]+"] **",__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX)
																		If !Empty(cSigla)
																			PExErr(aRet,"Siga Conselho: "+cSigla,__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX)
																		Endif
																		If !Empty(cCrm)
																			PExErr(aRet,"Codigo Conselho: "+cCrm,__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX)
																		Endif
																		If !Empty(cUf)
																			PExErr(aRet,"Estado Conselho: "+cUf,__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX)
																		Endif
																		If !Empty(cNome)
																			PExErr(aRet,"Nome Membro da Equipe: "+cNome,__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX)
																		Endif
																		If !Empty(cCodRP)
																			PExErr(aRet,"Codigo do Membro da Equipe na Operadora: "+cCodRP,__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX)
																		Endif
																		PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"",__aXMLCri39[1],nI,cCodPad,cCodPro,cSeqBXX)
																	Endif
																Endif
															Endif
															cCodRP  := ""
															cNomRda := ""
															cCrmRda := ""
															cSlgRda := ""
															cEstRda := ""
															cNomPre := ""
														EndDo

														cCodPro := PLSPCONGR("CODIGO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.,,.T.)
														cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])

														//se o cara mandou a participacao por mebro da equipe o sistema esquece todas as participacoes e so grava as participacaoes da equipe
														If Len(aTpPRe2) > 0
															For nPosXX:=1 to Len(aMatIte)
																If alltrim(aMatIte[nPosXX][1]) == "ATPPAR"
																	nSize := Len(aMatIte)
																	aDel(aMatIte,nPosXX)
																	aSize(aMatIte,nSize-1)
																	exit
																Endif
															Next
															AaDd( aMatIte, {"ATPPAR" , aTpPRe2 } )
														Endif

														AaDd(aItens,aMatIte)
													EndDo


													If cTipGui $ "06"
														While !Empty( ( cCodPro := PLSPCONGR("CODIGO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.) ) )
															aMatIte := {}
															AaDd( aMatIte, {"SEQMOV" , cSeq } )
															cSeq := soma1(cSeq)
															cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
															cSlvPro := cCodPro
															cCodPad := PLSPCONGR("TIPOTABELA",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.,.F.)
															cSlvPad := cCodPad
															cDescric:= PLSPCONGR("DESCRICAO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.,.F.)
															cSlvDes := cDescric
															cTpProc := ""
															dDatRea := PLSAJUDAT(Alltrim(PLSPCONGR("DATAEXECUCAO",cGuia+"\PROCEDIMENTOREALIZADO",aMatM,nil,nil,nil,nil,cCodPeg)))

															If PLSPOSGLO(PLSINTPAD(),__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
																aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
																If !Empty(aRetTuss[1])
																	cCodPad := aRetTuss[1]
																	cCodPro := aRetTuss[2]
																	cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
																EndIf
															EndIf

															PLSXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)
															BR8->(DbSetOrder(1))
															If PLSPOSGLO(cOpeMov,__aXMLCri27[1],__aXMLCri27[2],cLocalExec,"1",cTipoGrv)
																If !BR8->(MsSeek(xFilial("BR8")+cCodPad+cCodPro))

																	PExErr(aRet, "** ERRO ["+__aXMLCri27[1]+"] **",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																	aadd(aEvErros,cSlvPad+cSlvPro)
																Endif
																cTpProc := BR8->BR8_TPPROC
															Endif

															AaDd( aMatIte, {"CODPAD" , cCodPad } )
															AaDd( aMatIte, {"CODPRO" , cCodPro } )
															AaDd( aMatIte, {"DESPRO" , cDescric} )
															AaDd( aMatIte, {"TPPROC" , cTpProc } )

															AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
															AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
															AaDd( aMatIte, {"SLVDES" , cSlvDes} )

															nQtd := Val( PLSPCONGR("QUANTIDADEREALIZADA",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.,.F.) )
															AaDd( aMatIte, {"QTD" , nQtd } )
															AaDd( aMatIte, {"QTDAUT" , nQtd } )


															If Len(aTpPRec) == 0
																For nPos:=1 to Len (aMatBWT)
																	AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU } )
																Next
															Endif
															//no honorario individual o cara manda a participacao la no cabecalho
															If Len(aTpPRec) > 0
																AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
																//Elseif Type('aTpPIte') == "A"
																//	AaDd( aMatIte, {"ATPPAR" , aTpPIte } )
															Endif


															// Verifica se foi informado valor ao procedimento processado
															nPosVlrApr := aScan (aMatMCp,{ |x|x[1] == "*CODIGO" .and. alltrim(cCodPro) == alltrim(x[2]) .And. cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO" $ x[3]})
															If nPosVlrApr <> 0
																nPosVlrApr ++
																While nPosVlrApr <= len(aMatMCp) .And. aMatMCp[nPosVlrApr][1] <> "CODIGO"
																	// Se achar a tag de valor, alimenta o array com o que foi apresentado nela
																	If aMatMCp [nPosVlrApr][1] == "VALOR"
																		nVlrApr := Val( strtran( PLSPCONGR("VALOR",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.,.F.),',',"." ) )
																		AaDd( aMatIte, {"VLRAPR" , nVlrApr } )
																		If nQtd > 0
																			nValTot += nVlrApr*nQtd
																		Else
																			nValTot += nVlrApr
																		Endif
																		lAchouVlr := .T.
																		Exit
																	EndIf
																	nPosVlrApr ++
																EndDo
															EndIf
															// Se nao achou a tag de valor alimenta o Array com o valor zerado
															If !lAchouVlr
																AaDd( aMatIte, {"VLRAPR" , 0 } )
															EndIf
															AaDd( aMatIte, {"HORINI" , SubStr(PLSPCONGR("HORAINICIO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.),1,5) } )
															AaDd( aMatIte, {"HORFIM" , SubStr(PLSPCONGR("HORAFIM",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.),1,5) } )
															AaDd( aMatIte, {"DATPRO" , PLSAJUDAT( PLSPCONGR("DATA",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.) ) } )
															dDataPrcRel:=PLSAJUDAT( PLSPCONGR("DATA",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCp,,.T.) )


															If dDataPrcRel > MsDate()
																If PLSPOSGLO(cOpeMov,__aXMLCri42[1],__aXMLCri42[2],cLocalExec,"1",cTipoGrv)

																	PExErr(aRet, "** ERRO ["+__aXMLCri42[1]+"] **",__aXMLCri42[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																	PExErr(aRet,Alltrim(PLSBCTDESC())+" - "+StrZero(Day(dDataPrcRel),2) + '/' + StrZero(Month(dDataPrcRel),2) + '/' + StrZero(Year(dDataPrcRel),4),__aXMLCri42[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri42[1],nI,cCodPad,cCodPro,cSeqBXX)
																Endif
															Endif
															// Participacao para os itens

															AaDd(aItens,aMatIte)
														EndDo
													endIf

													While !Empty( ( aMatPro := PLSPCONGR("CODIGO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS",aMatMCp,,.F.,,.T.) )[1] )

														cCodPro := aMatPro[1]
														cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
														cCodPad := PLSPCONGR("TIPOTABELA",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS",aMatMCp,,.T.,.F.)
														cDescric:= PLSPCONGR("DESCRICAO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS",aMatMCp,,.T.,.F.)
														cSlvPad := cCodPad
														cSlvPro := cCodPro
														cSlvDes := cDescric
														cTpProc := ""
														dDatRea := PLSAJUDAT(Alltrim(PLSPCONGR("DATA",cGuia+"\PROCEDIMENTOREALIZADO",aMatM,nil,nil,nil,nil,cCodPeg)))

														If PLSPOSGLO(cOpeMov,__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
															aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
															If !Empty(aRetTuss[1])
																cCodPad := aRetTuss[1]
																cCodPro := aRetTuss[2]
																cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
															EndIf
														EndIf

														PLSXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)
														BR8->(DbSetOrder(1))
														If PLSPOSGLO(cOpeMov,__aXMLCri27[1],__aXMLCri27[2],cLocalExec,"1",cTipoGrv)
															If !BR8->(MsSeek(xFilial("BR8")+cCodPad+cCodPro))

																PExErr(aRet, "** ERRO ["+__aXMLCri27[1]+"] **",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																aadd(aEvErros,cSlvPad+cSlvPro)
															Endif
															cTpProc := BR8->BR8_TPPROC
														Endif
														aMatIte := {}
														AaDd( aMatIte, {"SEQMOV" , cSeq } )
														AaDd( aMatIte, {"CODPAD" , cCodPad } )
														AaDd( aMatIte, {"CODPRO" , cCodPro} )
														AaDd( aMatIte, {"DESPRO" , cDescric} )
														AaDd( aMatIte, {"TPPROC" , cTpProc } )

														AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
														AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
														AaDd( aMatIte, {"SLVDES" , cSlvDes} )

														If Len(aTpPRec) > 0
															AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
														Endif

														AaDd(aItens,aMatIte)
														cSeq:= soma1(cSeq)

														// Verifica se foi informado valor ao procedimento processado
														nPosVlrApr := aScan (aMatMCp,{ |x|x[1] == "*CODIGO" .and. alltrim(cCodPro) == alltrim(x[2]) .And. cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO" $ x[3]})
														If nPosVlrApr <> 0
															nPosVlrApr ++
															While nPosVlrApr <= len(aMatMCp) .And. aMatMCp[nPosVlrApr][1] <> "CODIGO"
																// Se achar a tag de valor, alimenta o array com o que foi apresentado nela
																If aMatMCp[nPosVlrApr][1] == "VALOR"
																	nVlrApr := Val( strtran( PLSPCONGR("VALOR",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.,.F.),',',"." ) )
																	AaDd( aMatIte, {"VLRAPR" , nVlrApr } )

																	nQtdApr := Val( strtran( PLSPCONGR("QUANTIDADEREALIZADA",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS\PROCEDIMENTOREALIZADO",aMatMCp,,.T.,.F.),',',"." ) )

																	If nQtdApr > 0
																		nValTot += nVlrApr*nQtdApr
																	Else
																		nValTot += nVlrApr
																	Endif

																	lAchouVlr := .T.
																	Exit
																EndIf
																nPosVlrApr ++
															EndDo
														EndIf
														// Se nao achou a tag de valor alimenta o Array com o valor zerado
														If !lAchouVlr
															AaDd( aMatIte, {"VLRAPR" , 0 } )
														EndIf

														cCodPro := PLSPCONGR("CODIGO",cGuia+"\PROCEDIMENTOSEXAMESREALIZADOS",aMatMCp,,.T.)
														cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
													Enddo
													While !Empty( ( cCodPro := PLSPCONGR("CODIGO",cGuia+"\OUTRASDESPESAS",aMatMCp,,.F.) ) )

														lAchouVlr  := .F. //Reinicializa a variavel de valor apresentado
														nPosVlrApr := 0 //Reinicializa a posicao da tag CODIGO para verificar se foi informado o valor do procedimento
														cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
														cCodPad := PLSPCONGR("TIPOTABELA",cGuia+"\OUTRASDESPESAS",aMatMCp,,.T.,.F.)
														cDescric := PLSPCONGR("DESCRICAO",cGuia+"\OUTRASDESPESAS",aMatMCp,,.T.,.F.)
														cSlvDes := cDescric
														cSlvPad := cCodPad

														BR8->(DbSetOrder(1))
														If !BR8->(MsSeek(xFilial("BR8")+cCodPad+cCodPro)) .And. GetNewPar("MV_PLPSPXM","99999994") <> "" .And. Posicione("BCT",1,xFilial("BCT")+cOpeMov+__aXMLCri27[1],"BCT_ATIVO") = "0"
															cSlvPro := GetNewPar("MV_PLPSPXM","99999994")//cCodPro//dennis
															cSlvPad := GetNewPar("MV_PLCDPXM","01")
														Else
															cSlvPro := cCodPro
															cSlvPad := cCodPad
														Endif
														cTpProc := ""
														cCodPro:= cSlvPro
														If PLSPOSGLO(cOpeMov,__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
															aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
															If !Empty(aRetTuss[1])
																cCodPad := aRetTuss[1]
																cCodPro := aRetTuss[2]
																cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
															EndIf
														EndIf

														// Tipo de Despesa	dennis
														cTpProc := AllTrim(Str( Val( PLSPCONGR("TIPODESPESA",cGuia+"\OUTRASDESPESAS\DESPESA",aMatMCp,nil,.T.,.F.,nil,'') ) ))
														Do Case
															Case cTpProc == "1"
															cTpProc := "7" 	//Gases Medicinais
															Case cTpProc == "2"
															cTpProc := "2" 	//Medicamento
															Case cTpProc == "3"
															cTpProc := "1" 	//Material
															Case cTpProc == "4"
															cTpProc := "3" 	//Taxas
															Case cTpProc == "5"
															cTpProc := "4" 	//Diarias
															Case cTpProc == "6"
															cTpProc := "8" 	//Alugueis
														EndCase
														dDatRea := PLSAJUDAT( PLSPCONGR("DATAEXECUCAO",cGuia+"\OUTRASDESPESAS\DESPESA\SERVICOSEXECUTADOS",aMatM,nil,nil,nil,nil,cCodPeg) )

														PLSXPAD(@cCodPad,@cCodPro,@cDescric,@cTpProc,cTipGui,cVersao,dDatRea)
														BR8->(DbSetOrder(1))
														If PLSPOSGLO(cOpeMov,__aXMLCri27[1],__aXMLCri27[2],cLocalExec,"1",cTipoGrv)
															If !BR8->(MsSeek(xFilial("BR8")+cCodPad+cCodPro))

																PExErr(aRet, "** ERRO ["+__aXMLCri27[1]+"] **",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																aadd(aEvErros,cSlvPad+cSlvPro)
															Endif

														Endif
														aMatIte := {}
														AaDd( aMatIte, {"SEQMOV" , cSeq } )
														AaDd( aMatIte, {"CODPAD" , cCodPad } )
														AaDd( aMatIte, {"CODPRO" , cCodPro} )
														AaDd( aMatIte, {"DESPRO" , cDescric} )

														AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
														AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
														AaDd( aMatIte, {"SLVDES" , cSlvDes} )

														nQtdApr := Val( PLSPCONGR("QUANTIDADE",cGuia+"\OUTRASDESPESAS",aMatMCp,,.T.,.F.,nil) )
														AaDd( aMatIte, {"QTD" , nQtdApr } )
														AaDd( aMatIte, {"QTDAUT" , nQtdApr } )

														If Len(aTpPRec) > 0
															AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
														Endif

														//AaDd(aItens,aMatIte)
														cSeq:= soma1(cSeq)
														lAchouVlr := .F.
														// Verifica se foi informado valor da despesa processada
														nPosVlrApr := aScan (aMatMCp,{ |x|x[1] == "CODIGO" .and. alltrim(cCodPro) == alltrim(x[2]) .And. "\OUTRASDESPESAS" $ x[3]})
														If nPosVlrApr <> 0
															nPosVlrApr ++
															While nPosVlrApr <= len(aMatMCp) .And. aMatMCp[nPosVlrApr][1] <> "CODIGO"
																// Se achar a tag de valor, alimenta o array com o que foi apresentado nela
																If aMatMCp[nPosVlrApr][1] == "VALORUNITARIO"
																	nVlrApr := Val( strtran( PLSPCONGR("VALORUNITARIO",cGuia+"\OUTRASDESPESAS",aMatMCp,,.T.,.F.),',',"." ) )
																	AaDd( aMatIte, {"VLRAPR" , nVlrApr } )
																	If nQtdApr > 0
																		nValTot += nVlrApr*nQtdApr
																	Else
																		nValTot += nVlrApr
																	Endif
																	lAchouVlr := .T.
																	Exit
																EndIf
																nPosVlrApr ++
															EndDo
														EndIf
														// Se nao achou a tag de valorunitario alimenta o Array com o valor zerado
														If !lAchouVlr
															AaDd( aMatIte, {"VLRAPR" , 0 } )
														EndIf
														// Marca no Array aMatM a Despesa utilizada
														cCodPro := PLSPCONGR("CODIGO",cGuia+"\OUTRASDESPESAS",aMatMCp,,.T.)
														cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])

														AaDd( aMatIte, {"TPPROC" , cTpProc } )
														AaDd(aItens,aMatIte)

													EndDo

													While !Empty( ( cCodPro := PLSPCONGR("CODIGO",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatMCp,,.T.) ) )

														cCodPad := PLSPCONGR("TIPOTABELA",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatMCp,,.T.,.F.)
														cDescric := PLSPCONGR("DESCRICAO",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatMCp,,.T.,.F.)
														cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
														cSlvPad := cCodPad
														cSlvPro := cCodPro
														cSlvDes := cDescric
														cTpProc := ""
														dDatRea := PLSAJUDAT(Alltrim(PLSPCONGR("DATAEXECUCAO",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatM,nil,nil,nil,nil,cCodPeg)))

														If PLSPOSGLO(cOpeMov,__aCdCri198[1],__aCdCri198[2],cLocalExec,"1",cTipoGrv)
															aRetTuss := PLSDPTUSS('E',cCodPad,cCodPro)
															If !Empty(aRetTuss[1])
																cCodPad := aRetTuss[1]
																cCodPro := aRetTuss[2]
																cCodPro := padr(cCodPro,tamsx3("BR8_CODPSA")[1])
															EndIf
														EndIf

														PLSXPAD(@cCodPad,@cCodPro,@cDescric,,cTipGui,cVersao,dDatRea)
														BR8->(DbSetOrder(1))
														If PLSPOSGLO(cOpeMov,__aXMLCri27[1],__aXMLCri27[2],cLocalExec,"1",cTipoGrv)
															If !BR8->(MsSeek(xFilial("BR8")+cCodPad+cCodPro))

																PExErr(aRet, "** ERRO ["+__aXMLCri27[1]+"] **",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"",__aXMLCri27[1],nI,cCodPad,cCodPro,cSeqBXX)
																aadd(aEvErros,cSlvPad+cSlvPro)
															Endif
															cTpProc := BR8->BR8_TPPROC
														Endif

														aMatIte := {}
														AaDd( aMatIte, {"SEQMOV" , cSeq } )
														AaDd( aMatIte, {"CODPAD" , cCodPad } )
														AaDd( aMatIte, {"CODPRO" , cCodPro} )
														AaDd( aMatIte, {"DESPRO" , cDescric } )
														AaDd( aMatIte, {"TPPROC" , cTpProc } )

														nQtd := Val( PLSPCONGR("QUANTIDADE",cGuia+Iif(cTipo=="2","\OPMUTILIZADA","\OPMUTILIZADAS"),aMatMCp,,.T.,.F.,nil) )
														nVlrApr := Val( strtran( PLSPCONGR("VALORUNITARIO",cGuia+"\OPM",aMatMCp,,.T.,.F.),',',"." ) )

														nValTot += nVlrApr*nQtd


														AaDd( aMatIte, {"VLRAPR" , nVlrApr } )
														AaDd( aMatIte, {"QTD" , nQtd } )
														AaDd( aMatIte, {"QTDAUT" , nQtd } )

														AaDd( aMatIte, {"SLVPAD" , cSlvPad } )
														AaDd( aMatIte, {"SLVPRO" , cSlvPro} )
														AaDd( aMatIte, {"SLVDES" , cSlvDes} )
														//eu carrego todas as composicoes possiveis ou seja, vou pegar o que tiver no bd4 - nao mexer aqui - consultar daher
														aSlvTprec := aClone(aTpPRec)
														If Len(aTpPRec) == 0
															For nPos:=1 to Len (aMatBWT)
																AaDd( aTpPRec,{ aMatBWT[nPos,2],If(Empty(cConPrEx),cCodRP,cConPrEx),If(Empty(cNomRdEx),cNomRda,cNomRdEx),cCrmRda,cSlgRda,cEstRda,cNomPre,.T.,cCodBAU } )
															Next
														Endif
														If Len(aTpPRec) > 0
															AaDd( aMatIte, {"ATPPAR" , aTpPRec } )
														Endif
														aTpRec := aClone(aSlvTpRec)

														AaDd(aItens,aMatIte)
														cSeq:= soma1(cSeq)

													EndDo
												Endif

												If u_cbIsntPrd({__aXMLCri17[1]},aRet[3])
													// Posiciona na Rede de Atendimento X Operadora...
													BAW->(DbSetOrder(1))
													If !BAW->(MsSeek(xFilial("BAW")+cRdaOri+cOpeMov))
														If !BAW->(MsSeek(xFilial("BAW")+cRdaOri+PLSINTPAD()))
															If PLSPOSGLO(PLSINTPAD(),__aCdCri014[1],__aCdCri014[2],cLocalExec,"1",cTipoGrv)

																PExErr(aRet, "** ERRO ["+__aCdCri014[1]+"] **",__aCdCri014[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aCdCri014[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"",__aCdCri014[1],nI,nil,nil,cSeqBXX)
															Endif
														Endif
													ElseIf PLSPOSGLO(PLSINTPAD(),__aCdCri180[1],__aCdCri180[2],cLocalExec,"1",cTipoGrv)
														lCri := .T.
														If BAW->( FieldPos("BAW_VIGINI") ) > 0 .And. BAW->( FieldPos("BAW_VIGFIN") ) > 0

															If BAW->(MsSeek(xFilial("BAW")+cRdaOri+cOpeMov))
																While BAW->BAW_CODIGO ==  cRdaOri .And. BAW->BAW_CODINT == cOpeMov
																	If BAW->BAW_VIGINI <> CTOD(" / / ") .And. BAW->BAW_VIGINI <= dDataBase .And.;
																	(BAW->BAW_VIGFIN == CTOD(" / / ") .Or. BAW->BAW_VIGFIN >= dDataBase)
																		lCri := .F.
																	EndIf
																	BAW->(dbSkip())
																EndDo
																//Caso nao encontre vigencia ativa.
																If lCri

																	PExErr(aRet, "** ERRO ["+__aCdCri180[1]+"] **",__aCdCri180[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aCdCri180[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aCdCri180[1],nI,nil,nil,cSeqBXX)
																EndIf
															Endif
														Endif
													Endif
												Endif

												If u_cbIsntPrd({__aXMLCri17[1]},aRet[3]) .and. !Empty(cIdenfic)

													SIX->( DbSetOrder(1) )
													If SIX->( MsSeek("BB84") )
														cTpLograd	:= PLSPCONGR("TIPOLOGRADOURO",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatMCp,,.T.,.F.)
														cTpLograd   += Space( TamSX3("BB8_TIPLOG")[1]-Len( AllTrim(cTpLograd) ) )

														cLograd 	:= PLSPCONGR("LOGRADOURO",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatMCp,,.T.,.F.)
														cNumero 	:= PLSPCONGR("NUMERO",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatMCp,,.T.,.F.)
														cNumero   	+= Space( TamSX3("BB8_NR_END")[1]-Len( AllTrim(cNumero) ) )

														cCodUf 		:= PLSPCONGR("CODIGOUF",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatMCp,,.T.,.F.)
														cCodUf   	+= Space( TamSX3("BB8_EST")[1]-Len( AllTrim(cCodUf) ) )

														cCep 		:= strtran(strtran(PLSPCONGR("CEP",cGuia+"\"+cIdenfic+"\ENDERECOCONTRATADO",aMatMCp,,.T.,.F.),'-',''),'.','')
														cCep   		+= Space( TamSX3("BB8_CEP")[1]-Len( AllTrim(cCep) ) )

														If !Empty( AllTrim(cTpLograd+cCep+cNumero+cCodUf) )
															lEntrou := .F.
															If nInd1 == 0
																nIndUt := PLSBUIND("BB8","BB8_FILIAL + BB8_TIPLOG + BB8_CEP + BB8_NR_END + BB8_EST + BB8_CODIGO + BB8_CODINT") /// Busca da Ordem do indice pela descrição
																nInd1  := nIndUt
															Endif
															BB8->( DbSetOrder(nInd1) )//BB8_FILIAL + BB8_TIPLOG + BB8_CEP + BB8_NR_END + BB8_EST + BB8_CODIGO + BB8_CODINT                                          //sempre procuro um local na rda que eu vou gerar a guia
															If BB8->( MsSeek( xFilial("BB8")+cTpLograd+cCep+cNumero+cCodUf+cRdaOri+cOpeMov ) )

																while  !BB8->(Eof()) .and. BB8->(BB8_FILIAL+BB8_TIPLOG+BB8_CEP+BB8_NR_END+BB8_EST+BB8_CODIGO+BB8_CODINT) == ;
																xFilial("BB8")+cTpLograd+cCep+cNumero+cCodUf+cRdaOri+cOpeMov
																	If Empty(BB8->BB8_DATBLO)
																		AaDd( aDados, { "CODLOC", BB8->BB8_CODLOC } )
																		AaDd( aDados, { "LOCAL", BB8->BB8_LOCAL } )
																		lEntrou := .T.
																		exit
																	Endif
																	BB8->(DbSkip())
																enddo
																If !lEntrou
																	If PLSPOSGLO(cOpeMov,__aXMLCri29[1],__aXMLCri29[2],cLocalExec,"1",cTipoGrv)

																		PExErr(aRet, "** ERRO ["+__aXMLCri29[1]+"] **",__aXMLCri29[1],nI,nil,nil,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Tipo Logradouro: "+cTpLograd,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Cep: "+cCep,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Numero: "+cNumero,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Estado: "+cCodUf,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"",__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																	Endif
																Endif
															Else
																If PLSPOSGLO(cOpeMov,__aXMLCri29[1],__aXMLCri29[2],cLocalExec,"1",cTipoGrv)

																	PExErr(aRet, "** ERRO ["+__aXMLCri29[1]+"] **",__aXMLCri29[1],nI,nil,nil,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Tipo Logradouro: "+cTpLograd,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Cep: "+cCep,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Numero: "+cNumero,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"Estado: "+cCodUf,__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri29[1],nI,nil,nil,cSeqBXX)
																Endif
															Endif

														EndIf
													EndIf
													cIdenfic := ""
												EndIf

												If u_cbIsntPrd({__aXMLCri17[1]},aRet[3])
													cCodLoc 	 := PLSRETDAD(aDados,"CODLOC","")
													cLocal  	 := PLSRETDAD(aDados,"LOCAL" ,"")
													cCodEsp 	 := PLSRETDAD(aDados,"CODESP","" )

													If Empty(cCodEsp)
														cChavePes := xFilial("BAX")+cRdaOri+cOpeMov+cCodLoc
													Else
														cChavePes := xFilial("BAX")+cRdaOri+cOpeMov+cCodLoc+cCodEsp
													Endif

													BAX->(DbSetOrder(1)) //BAX_FILIAL + BAX_CODIGO + BAX_CODINT + BAX_CODLOC + BAX_CODESP + BAX_CODSUB
													If ! BAX->(MsSeek(cChavePes))
														If Empty(cCodEsp)
															cChavePes := xFilial("BAX")+cRdaOri+plsintpad()+cCodLoc
														Else
															cChavePes := xFilial("BAX")+cRdaOri+plsintpad()+cCodLoc+cCodEsp
														Endif
														If ! BAX->(MsSeek(cChavePes))
															cChavePes := xFilial("BAX")+cRdaOri+plsintpad()+cCodLoc
															If ! BAX->(MsSeek(cChavePes)) .and. PLSPOSGLO(cOpeMov,__aCdCri016[1],__aCdCri016[2],cLocalExec,"1",cTipoGrv)


																PExErr(aRet, "** ERRO ["+__aCdCri016[1]+"] **",__aCdCri016[1],nI,nil,nil,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aCdCri016[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Codigo do Prestador: "+cRdaOri,__aCdCri016[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Operadora do Prestador: "+cOpeMov,__aCdCri016[1],nI,nil,nil,cSeqBXX)
																PExErr(aRet,"Local de Atendimento: "+cCodLoc,__aCdCri016[1],nI,nil,nil,cSeqBXX)
																If !Empty(cCodEsp)
																	PExErr(aRet,"Codigo da Especialidade: "+cCodEsp,__aCdCri016[1],nI,nil,nil,cSeqBXX)
																Endif
																PExErr(aRet,"",__aCdCri016[1],nI,nil,nil,cSeqBXX)
															Endif
														Else
															If PLSPOSGLO(cOpeMov,__aCdCri083[1],__aCdCri083[2]) .And. !Empty(BAX->BAX_DATBLO) .And. dtos(dDataBase) >= dtos(BAX->BAX_DATBLO)

																lFlag := .T.

																If ! Empty(cCodEsp)
																	lFlag := .F.
																Else
																	lFlag 	:= .F.

																	BAX->(DbSkip())
																	While ! BAX->(Eof()) .And. BAX->(BAX_FILIAL+BAX_CODIGO+BAX_CODINT+BAX_CODLOC) == xFilial("BAX")+cRdaOri+PLSINTPAD()+cCodLoc

																		If BAX->(FieldPos("BAX_ESPPRI")) > 0 .and. ;
																		dtos(dDataBase) < dtos(BAX->BAX_DATBLO) .Or. Empty(BAX->BAX_DATBLO) .and. BAX->BAX_ESPPRI == '1'
																			lFlag 	:= .T.
																			Exit
																		Elseif dtos(dDataBase) < dtos(BAX->BAX_DATBLO) .Or. Empty(BAX->BAX_DATBLO) .and. !lFlag
																			lFlag 	:= .T.
																		Endif

																		BAX->(DbSkip())
																	Enddo
																Endif

																If !lFlag
																	cMV_PLSREGE := GetNewPar("MV_PLSREGE","1")
																	If cMV_PLSREGE == "0"

																		PExErr(aRet, "** ERRO ["+__aCdCri083[1]+"] **",__aCdCri083[1],nI,nil,nil,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aCdCri083[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Codigo do Prestador: "+cRdaOri,__aCdCri083[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Operadora do Prestador: "+cOpeMov,__aCdCri083[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Local de Atendimento: "+cCodLoc,__aCdCri083[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"Codigo da Especialidade: "+cCodEsp,__aCdCri083[1],nI,nil,nil,cSeqBXX)
																		PExErr(aRet,"",__aCdCri083[1],nI,nil,nil,cSeqBXX)
																	EndIf
																Endif
															Endif
														Endif
													Endif
												Endif

												//trato criticas prede.
												If u_cbIsntPrd({__aXMLCri17[1],__aXMLCri16[1],__aXMLCri29[1],__aXMLCri10[1]},aRet[3])
													For nP:=1 to len(aItens)
														cSlvPad 	 := PLSRETDAD(aItens[nP],"SLVPAD","")
														cSlvPro 	 := PLSRETDAD(aItens[nP],"SLVPRO","")

														//significa que o evento que estou trabalhando foi criticado la em cima, logo nao posso seguir nas checagens
														If aScan(aEvErros,{|x| x == cSlvPad+cSlvPro}) > 0
															loop
														Endif

														cCodPad 	 := PLSRETDAD(aItens[nP],"CODPAD","")
														cCodPro 	 := PLSRETDAD(aItens[nP],"CODPRO","")
														nQtdPro		 := PLSRETDAD(aItens[nP],"QTDAUT","")
														cDescric	 := PLSRETDAD(aItens[nP],"DESPRO","")
														cSlvDes 	 := PLSRETDAD(aItens[nP],"SLVDES","")
														cTpProc		 := PLSRETDAD(aItens[nP],"TPPROC","")
														cCodLoc 	 := PLSRETDAD(aDados,"CODLOC","")
														cLocal  	 := PLSRETDAD(aDados,"LOCAL" ,"")
														cCodEsp 	 := PLSRETDAD(aDados,"CODESP","" )
														cCodPla		 := If(Len(aDadUsr)>=11,aDadUsr[11],'')
														aTpPIte		 := PLSRETDAD(aItens[nP],"ATPPAR",{})
														aCodTab 	 := PLSRETTAB(cCodPad,cCodPro,dDatPro,;
														cOpeMov,cRdaOri,cCodEsp,'',cCodLoc+cLocal,;
														dDatPro,"1",cOpeMov,cCodPla,"2","1")

														If aCodTab[1]
															aCompo := PLSCOMEVE(aCodTab[3],cCodPad,cCodPro,cOpeMov,dDatPro)
															lPart  := .F.
															If Len(aCompo) == 0
																If PLSPOSGLO(cOpeMov,__aXMLCri30[1],__aXMLCri30[2],cLocalExec,"1",cTipoGrv)

																	PExErr(aRet, "** ERRO ["+__aXMLCri30[1]+"] **",__aXMLCri30[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																	PExErr(aRet,PLSBCTDESC(),__aXMLCri30[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri30[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"Data do Evento: "+dToc(dDatPro),__aXMLCri30[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri30[1],nI,cCodPad,cCodPro,cSeqBXX)
																	PExErr(aRet,"",__aXMLCri30[1],nI,cCodPad,cCodPro,cSeqBXX)
																Endif
															Else
																cCodTab   := aCompo[1][15]
																cCodCri	  := ""
																If cTipGui $ "06"
																	For nFor := 1 To Len(aTpPIte)
																		If Empty(aTpPIte[nFor,1]) .And. PLSPOSGLO(cOpeMov,__aCdCri099[1],__aCdCri099[2],cLocalExec,"1",cTipoGrv)
																			cCodCri := __aCdCri099[1]
																			lPart := .T.
																			exit
																		EndIf
																		If PLSPOSGLO(cOpeMov,__aCdCri175[1],__aCdCri175[2],cLocalExec,"1",cTipoGrv)
																			If !Empty(cCodTab) .and. PLSCHKGPA(cOpeMov,cCodTab,cCodPad,cCodPro,alltrim(aTpPIte[nFor][1]),cTissVer)
																				lPart := .T.
																				exit
																			Endif
																		Else
																			lPart := .T.
																		Endif
																	Next
																Else
																	If Len(aTpPIte) > 0
																		For nFor := 1 To Len(aTpPIte)
																			cCodTpa:=aTpPIte[nFor,1]
																			If Empty(aTpPIte[nFor,1]) .And. PLSPOSGLO(cOpeMov,__aCdCri099[1],__aCdCri099[2],cLocalExec,"1",cTipoGrv)
																				cCodCri := __aCdCri099[1]
																				lPart := .T.
																				exit
																			EndIf
																			If PLSPOSGLO(cOpeMov,__aCdCri175[1],__aCdCri175[2],cLocalExec,"1",cTipoGrv)
																				If !Empty(cCodTab) .and. PLSCHKGPA(cOpeMov,cCodTab,cCodPad,cCodPro,alltrim(aTpPIte[nFor][1]),cTissVer)
																					lPart := .T.
																					exit
																				Endif
																			Else
																				lPart := .T.
																			Endif
																		Next
																	Else
																		lPart := .T.
																	Endif
																Endif
																// Checa o codigo da posicao do profissional participante no evento medico informado no arquivo XML
																// é permitido para a composicao do procedimento na tabela da Unidade de Medida de Saude.
																If !lPart
																	If ExistBlock("PLCHKPAR")
																		lPart := ExecBlock("PLCHKPAR",.F.,.F.,{aCompo, cTipGui, cOpeMov, cCodTab, cCodPad, cCodPro, aTpPIte} )
																	EndIf
																EndIf
															Endif
															If !lPart
																PLSPOSGLO(cOpeMov,__aCdCri175[1],__aCdCri175[2],cLocalExec,"1",cTipoGrv)
																cCodCri := __aCdCri175[1]
																DbSelectArea("BWT")
																DbSetOrder(1)
																DbSeek(xFilial("BWT")+cOpeMov+cCodTpa)

																cSlvDes:=cSlvDes+ "--> "+cCodTpa+" - " +BWT->BWT_DESCRI
															Endif
															If !Empty(cCodCri)

																PExErr(aRet, "** ERRO ["+cCodCri+"] **",cCodCri,nI,cCodPad,cCodPro,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),cCodCri,nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),cCodCri,nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Data do Evento: "+dToc(dDatPro),cCodCri,nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,cCodCri,nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"",cCodCri,nI,cCodPad,cCodPro,cSeqBXX)
															EndIf
														Else
															If PLSPOSGLO(cOpeMov,__aXMLCri31[1],__aXMLCri31[2],cLocalExec,"1",cTipoGrv)

																PExErr(aRet, "** ERRO ["+__aXMLCri31[1]+"] **",__aXMLCri31[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																PExErr(aRet,PLSBCTDESC(),__aXMLCri31[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri31[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Data do Evento: "+dToc(dDatPro),__aXMLCri31[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri31[1],nI,cCodPad,cCodPro,cSeqBXX)
																PExErr(aRet,"",__aXMLCri31[1],nI,cCodPad,cCodPro,cSeqBXX)
															Endif
														Endif

														If lFoundAut
															If cTipGui == "02" .and. nRecnoAut > 0
																BEA->( dbGoTo(nRecnoAut) )
																cNumGuia := BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)
																nQtdPre	 := 0
																BE2->(DbSetOrder(6))//BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+BE2_CODPAD+BE2_CODPRO
																If BE2->(MsSeek(xFilial("BE2")+cNumGuia+Alltrim(cCodPad+cCodPro)))
																	nRecBE2 := 0
																	while !BE2->(Eof()) .and.  BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+alltrim(BE2_CODPAD+BE2_CODPRO)) == ;
																	xFilial("BE2")+cNumGuia+Alltrim(cCodPad+cCodPro)
																		nQtdPre += BE2->BE2_SALDO
																		nRecBE2 := BE2->(Recno())
																		BE2->(DbSkip())
																	Enddo

																	If nRecBE2 > 0
																		BE2->(DbGoTo(nRecBE2))
																	Endif
																	If nRecBE2 > 0 .and. PLSPOSGLO(cOpeMov,__aXMLCri44[1],__aXMLCri44[2],cLocalExec,"1",cTipoGrv) .and. BE2->BE2_STATUS <> '1'

																		PExErr(aRet, "** ERRO ["+__aXMLCri44[1]+"] **",__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"Para este procedimento foi solicitada a pre-autorizaca mas nao foi autorizado pela operadora.",__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"",__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																	Else
																		//| Esta critica em especifico eu crio ela INATIVA pois em autogestoes e medicinas de grupos           |
																		//| o prestador vai sempre mandar o xml e eles sempre vao pagar com base no xml, ja em unimeds         |
																		//| se o cara ja executou no portal ele nao pode mandar denovo no XML                                  |
																		If PLSPOSGLO(cOpeMov,__aXMLCri28[1],__aXMLCri28[2],cLocalExec,"0",cTipoGrv)
																			If nQtdPre < nQtdPro

																				PExErr(aRet, "** ERRO ["+__aXMLCri28[1]+"] **",__aXMLCri28[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																				PExErr(aRet,PLSBCTDESC(),__aXMLCri28[1],nI,cCodPad,cCodPro,cSeqBXX)
																				PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri28[1],nI,cCodPad,cCodPro,cSeqBXX)
																				PExErr(aRet,"Quantidade enviada: "+alltrim(str(nQtdPro)),__aXMLCri28[1],nI,cCodPad,cCodPro,cSeqBXX)
																				PExErr(aRet,"Quantidade pre-autorizada ainda nao executada: "+alltrim(str(nQtdPre)),__aXMLCri28[1],nI,cCodPad,cCodPro,cSeqBXX)
																				PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri28[1],nI,cCodPad,cCodPro,cSeqBXX)
																				PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri28[1],nI,cCodPad,cCodPro,cSeqBXX)
																				PExErr(aRet,"",__aXMLCri28[1],nI,cCodPad,cCodPro,cSeqBXX)
																			EndIf
																		Endif
																	Endif
																Else

																	/*
																	Exemplo:
																	Se a operadora quer barrar um evento que nao esteja na pre-autorizacao ela deve
																	criar o parametro MV_PLSOPMM, sem o codigo em questao.
																	Por exemplo, se somente as 'Orteses e Proteses' exigirem pre-autorizacao a operadora devera
																	criar o parametro MV_PLSOPMM com o conteudo "0,1,2,3,4,6,7,8,9" (sem o nro 5)

																	cTpProc := "0" 	//Procedimento
																	cTpProc := "1" 	//Material
																	cTpProc := "2" 	//Medicamento
																	cTpProc := "3" 	//Taxas
																	cTpProc := "4" 	//Diarias
																	cTpProc := "5" 	//Ortese/Protese
																	cTpProc := "6" 	//Pacote
																	cTpProc := "7" 	//Gases Medicinais
																	cTpProc := "8" 	//Alugueis
																	cTpProc := "9" 	//Outros
																	*/

																	If !Empty(cTpProc) .and. !(AllTrim(cTpProc) $ AllTrim( GetNewPar("MV_PLSOPMM","0,1,2,3,4,5,6,7,8,9")))
																		If PLSPOSGLO(cOpeMov,__aXMLCri37[1],__aXMLCri37[2],cLocalExec,"1",cTipoGrv)

																			PExErr(aRet, "** ERRO ["+__aXMLCri37[1]+"] **",__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																			PExErr(aRet,PLSBCTDESC(),__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																			PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																			PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																			PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																			PExErr(aRet,"",__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																		Endif
																	Endif
																Endif
															Elseif cTipGui $ "05#06" .and. nRecnoAut > 0
																BE4->( dbGoTo(nRecnoAut) )
																cNumGuia := BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
																nQtdPre	 := 0
																BEJ->(DbSetOrder(1))
																If BEJ->(MsSeek(xFilial("BEJ")+cNumGuia))
																	nRecBEJ := 0
																	while !BEJ->(Eof()) .and.  BEJ->(BEJ_FILIAL+BEJ_CODOPE+BEJ_ANOINT+BEJ_MESINT+BEJ_NUMINT) == ;
																	xFilial("BEJ")+cNumGuia

																		If alltrim(BEJ->(BEJ_CODPAD+BEJ_CODPRO)) == Alltrim(cCodPad+cCodPro)
																			nRecBEJ := BEJ->(Recno())
																		Endif
																		BEJ->(DbSkip())
																	Enddo

																	If nRecBEJ > 0
																		BEJ->(DbGoTo(nRecBEJ))
																	Endif

																	If nRecBEJ > 0 .and. PLSPOSGLO(cOpeMov,__aXMLCri44[1],__aXMLCri44[2],cLocalExec,"1",cTipoGrv) .and. BEJ->BEJ_STATUS <> '1'

																		PExErr(aRet, "** ERRO ["+__aXMLCri44[1]+"] **",__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																		PExErr(aRet,PLSBCTDESC(),__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"Para este procedimento foi solicitada a pre-autorizaca mas nao foi autorizado pela operadora.",__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)
																		PExErr(aRet,"",__aXMLCri44[1],nI,cCodPad,cCodPro,cSeqBXX)

																	Endif
																Else

																	/*
																	Exemplo:
																	Se a operadora quer barrar um evento que nao esteja na solicitacao de internacao ela deve
																	criar o parametro MV_PLSICRE, sem o codigo em questao.
																	Por exemplo, se somente as 'Orteses e Proteses' exigirem pre-autorizacao a operadora devera
																	criar o parametro MV_PLSICRE com o conteudo "0,1,2,3,4,6,7,8,9" (sem o nro 5)

																	cTpProc := "0" 	//Procedimento
																	cTpProc := "1" 	//Material
																	cTpProc := "2" 	//Medicamento
																	cTpProc := "3" 	//Taxas
																	cTpProc := "4" 	//Diarias
																	cTpProc := "5" 	//Ortese/Protese
																	cTpProc := "6" 	//Pacote
																	cTpProc := "7" 	//Gases Medicinais
																	cTpProc := "8" 	//Alugueis
																	cTpProc := "9" 	//Outros
																	*/

																	If !Empty(cTpProc) .and. !(AllTrim(cTpProc) $ AllTrim( GetNewPar("MV_PLSICRE","0,1,2,3,4,5,6,7,8,9")))
																		If PLSPOSGLO(cOpeMov,__aXMLCri37[1],__aXMLCri37[2],cLocalExec,"1",cTipoGrv)

																			PExErr(aRet, "** ERRO ["+__aXMLCri37[1]+"] **",__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX,.t.)
																			PExErr(aRet,PLSBCTDESC(),__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																			PExErr(aRet,"Tabela: "+cSlvPad+" - Codigo: "+cSlvPro+" - Descricao: "+Alltrim(cSlvDes),__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																			PExErr(aRet,"Numero da senha enviada: "+cNumAut,__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																			PExErr(aRet,"Beneficiario: "+cNomeUsu,__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																			PExErr(aRet,"",__aXMLCri37[1],nI,cCodPad,cCodPro,cSeqBXX)
																		Endif
																	Endif
																Endif
															Endif
														EndIf
													Next
												Endif

												// Totalizador de Quantidade de Guias
												If cTissver <> "2.02.03"
													nTotGui ++
												Endif
											Next
										Endif
									Endif
								EndIF
							Endif
						Else
							aRet[1] := .T.
							AaDd(aRet[3], "Erro na estrutura do arquivo XML. Verifique cada uma das TAGs do arquivo.")
							AaDd(aRet[3], "Nao foi possivel realizar o seu processamento.")
						Endif
						oXml := nil
						oObjXml := nil
						DelClassIntF()
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf

	// Recupera valor das variaveis dinamicas
	If Val(StrTran(cTissVer,".","")) >= 30000
		cTipGui := cTipGui3X
		cLotGui := cLotGui3X
		cCodRda := cCodRda3X
		nValTot := nValTot3X
	EndIf

	// Ponto de entrada para manipular o retorno do pre-processamento de xml
	If ExistBlock("PLPREPRO")
		aRet := ExecBlock("PLPREPRO",.F.,.F.,{aRet,aMatXCab,aMatXPre,aMatXEpi} )
	EndIf

	// Pega o total de evento e o valor total apresentado
	nTotEve := len(aItens)

Return aRet

/*/{Protheus.doc} U_CBTRCBOS
@type Function
@author PLS
@since 04/02/15
@version 1.0
@return Array, Retorna se a critica foi validada, o CBOS e Especialidade manipulada conforme De/Para. [1]-lRet/[2]-xcCBOS/[3]-cEspec
/*/
user function CBTRCBOS(xcCBOS,uPar02,dData,cCodRda,cCodCrm,cUfCrm,aDadCbo,cSigCrm,cDatLo,cCpf,cVerTiss)
	Local cCodBB0		:= ""
	Local cEspec 		:= ""
	Local cVincBkp	:= ""
	Local cEspAll 	:= GetNewPar("MV_PESPPLA","'094','055'") //Especialidades genericas a serem utilizadas quando a RDA nao possuir a especialidade enviada no XML.
	Local aRetEsp		:= {}
	Local aAreaBAQ	:= BAQ->(GetArea())
	Local aAreaBB0	:= BB0->(GetArea())
	Local aAreaBQ1	:= BQ1->(GetArea())
	Local aAreaBAX	:= BAX->(GetArea())
	Local nI			:= 0
	Local lRet	 		:= .F.

	Default cCodRda	:= ""
	Default cCodCrm 	:= ""
	Default cUfCrm 	:= ""
	Default xcCBOS	:= ""
	Default aDadCbo 	:= aClone(aDados)
	Default uPar02	:= NIL
	Default dData  	:= StoD("")
	Default cSigCrm	:= ""
	Default cDatLo 	:= ""
	Default cCpf		:= ""
	Default cVerTiss	:= '3.00.02'
	// Localizando a especialidade correspondente ao codigo enviado no XML.
	If !Empty(xcCBOS)
		BAQ->(DbSetORder(4))//BAQ_FILIAL+BAQ_CODINT+BAQ_CBOS
		If 	BAQ->(MsSeek(xFilial("BAQ") + PlsIntPad() + xcCBOS)) .Or.;
		BAQ->(MsSeek(xFilial("BAQ") + PlsIntPad() + SubStr(xcCBOS,1,4) + "." + SubStr(xcCBOS,5,2)))
			cEspec	:= AllTrim(BAQ->BAQ_CODESP)
		Endif
	Endif

	// Verificando se a especialidade e valida
	If Empty(cEspec)
		cSql := " SELECT BAX_CODESP, BAX_ESPPRI, R_E_C_N_O_ REC FROM "+RetSqlName("BAX")
		cSql += " WHERE BAX_FILIAL	= 	'" + xFilial("BAX") + "' "
		cSql += " AND BAX_CODINT 	= 	'" + PlsIntPad() +"' "
		cSql += " AND BAX_CODIGO   	= 	'" + cCodRda + "' "
		cSql += " AND BAX_CODESP 	IN 	(" + cEspAll + ") "
		cSql += " AND (BAX_DATBLO	= 	' ' OR (BAX_DATBLO <> ' ' and BAX_DATBLO > '" + Iif(ValType(dData) == "D",DtoC(dData),dData) + "'))"
		cSql += " AND D_E_L_E_T_   	= 	' ' "

		PlsQuery(cSql,"TrbBAX")
		// Verificando qual a principal especialidade dentre as informadas no parametro "MV_PESPPLA"
		If !TrbBAX->(Eof())
			While !TrbBAX->(Eof())
				aAdd(aRetEsp,{TrbBAX->BAX_CODESP,TrbBAX->BAX_ESPPRI})
				TrbBAX->(DbSkip())
			Enddo

			dbSelectArea("BAQ")
			BAQ->(dbSetOrder(1))//BAQ_FILIAL+BAQ_CODINT+BAQ_CODESP
			For nI := 1 to Len(aRetEsp)
				If BAQ->(MsSeek(xFilial("BAQ")+PlsIntPad()+aRetEsp[nI][1]))
					cEspec 	:= AllTrim(BAQ->BAQ_CODESP)
					lRet 	:= .T.
					If aRetEsp[nI][2] == "1"
						Exit
					Endif
				Else
					lRet := .F.
				EndIf
			Next nI
		Endif

		TrbBAX->(DbCloseArea())
	Else

		PLSIVPRO(cCpf,cSigCrm,cCodCrm,cUfCrm,3,nil,aDadCbo,nil,xcCBOS)
		PLSXSCU("",cSigCrm,cCodCrm,cUfCrm,"",NIL,nil,nil,nil,xcCBOS,cDatLo,,cVerTiss)
		//eu sempre tenho que considerar o profissional que as funcoes acima acharam,
		//inclusive essas funcoes criam a bq1 tambem
		If BB0->( found() )

			cCodBB0 := BB0->BB0_CODIGO
			// Buscando a especialidade no Profissional de Saude
			dbSelectArea("BQ1")
			BQ1->(dbSetOrder(1))//BQ1_FILIAL + BQ1_CODIGO + BQ1_CODESP
			If BQ1->(MsSeek(xFilial("BQ1")+cCodBB0+cEspec))
				lRet := .T.
			Else
				// Buscando a especialidade na Rede de Atendimento
				dbSelectArea("BAX")
				BAX->(dbSetOrder(3))//BAX_FILIAL+BAX_CODINT+BAX_CODESP+BAX_CODIGO
				If  BAX->(MsSeek(xFilial("BAX")+PlsIntPad()+cEspec+cCodRda)) .And.;
				(BAX->BAX_DATBLO == StoD("") .Or. (BAX->BAX_DATBLO <> StoD("") .And. BAX->BAX_DATBLO > Iif(ValType(dData) == "D",dData,StoD(dData))))
					lRet := .T.
				Endif
			Endif
		Endif
	Endif

	RestArea(aAreaBAQ)
	RestArea(aAreaBB0)
	RestArea(aAreaBQ1)
	RestArea(aAreaBAX)

	If ExistBlock("PLTISESP")
		aRetPe := ExecBlock( "PLTISESP",.F.,.F.,{xcCBOS} )
		If ValType(aRetPe) == "A"
			xcCBOS  	:= aRetPe[1]
			cEspec 	:= aRetPe[2]
			lRet		:= aRetPe[3]
		Endif
	EndIf

Return {lRet,xcCBOS,cEspec}

/*/{Protheus.doc} PExErr
@type Function
@author PLS
@since 22/03/12
/*/
Static Function PExErr(aArray,cCritica,cCri,nSeqGui,cCodPad,cCodPro,cSeqBXX,lGrCodGlo)
	DEFAULT cCri 	:= ""
	DEFAULT nSeqGui := 0
	DEFAULT cCodPad := ""
	DEFAULT cCodPro := ""
	DEFAULT cSeqBXX := ""
	DEFAULT lGrCodGlo := .f.

	If BCT->(FieldPos('BCT_ENVCOX')) == 0 .or. !PLsAliasExi("BXV") .or. (Empty(cCri) .and. !Empty(cCritica))
		aArray[1] := .T.
		AaDd(aArray[3],cCritica)
	Else
		If !Empty(cCri)
			BCT->(DbSetOrder(1))
			If BCT->( dbSeek(xFilial("BCT") + PlsIntPad() + cCri) ) .and. (BCT->BCT_ENVCOX == '0' .OR. Empty(BCT->BCT_ENVCOX))
				aArray[1] := .T.
				AaDd(aArray[3],cCritica)
			Else
				BXV->(Reclock('BXV',.T.))
				BXV->BXV_FILIAL := xFilial('BXV')
				BXV->BXV_ALIAS  := 'BXX'
				BXV->BXV_CHVALI := cSeqBXX
				BXV->BXV_CODOPE := PlsIntPad()
				If lGrCodGlo
					BXV->BXV_CODGLO := cCri
					BXV->BXV_DESGLO := BCT->BCT_DESCRI
				Else
					BXV->BXV_DESGLO := cCritica
				Endif
				If nSeqGui > 0
					BXV->BXV_SEQGUI := strzero(nSeqGui,3)
				Endif

				BXV->BXV_CODPAD := cCodPad
				BXV->BXV_CODPRO := cCodPro
				BXV->(MsUnlock())
			Endif
		Endif
	Endif
	// Fim da rotina
Return

/*/{Protheus.doc} PAddBXV
Adiciona as Criticas no arquivo BXV para conferencia posterior no Proc. de Contas (BCT_ENVCOX == "1")
@type Function
@author PLS
@since 28/05/2014
/*/
static function PAddBXV(cCri, cDesCri, nSeqGui, cCodPad, cCodPro, cSeqBXX)
	DEFAULT cCri    := ""
	DEFAULT cDesCri := ""
	DEFAULT nSeqGui := 0
	DEFAULT cCodPad := ""
	DEFAULT cCodPro := ""
	DEFAULT cSeqBXX := ""

	If !(BXV->(MsSeek(xFilial("BXV")+'BXX'+cSeqBXX+strzero(nSeqGui,3))))

		BXV->(Reclock('BXV',.T.))
		BXV->BXV_FILIAL := xFilial('BXV')
		BXV->BXV_ALIAS  := 'BXX'
		BXV->BXV_CHVALI := cSeqBXX
		BXV->BXV_CODOPE := PlsIntPad()
		If !EMPTY(cCri)
			BXV->BXV_CODGLO := cCri
			BXV->BXV_DESGLO := cDesCri
		Else
			BXV->BXV_DESGLO := cDesCri
		Endif
		If nSeqGui > 0
			BXV->BXV_SEQGUI := strzero(nSeqGui,3)
		Endif
		BXV->BXV_CODPAD := cCodPad
		BXV->BXV_CODPRO := cCodPro
		BXV->(MsUnlock())
	Endif

Return

/*/{Protheus.doc} u_CBINALUP
Grava ou altera a tabela de upload de arquivo xml
@type Function
@author PLS
/*/
user function CBINALUP(cUsrName,cCodRda,lOnline,lInc,cDirArqIn,aReturn)
	LOCAL nI			:= 1
	LOCAL cRet 			:= ""
	LOCAL cCodInt		:= PLSINTPAD()
	LOCAL cNomeArq		:= Space( TamSX3("BXX_ARQIN")[1] )
	LOCAL cTipo			:= ""
	LOCAL cUpldPath		:= getWebDir("UPLOADPATH")
	Local nH
	Local cTipGui		:= "08"
	DEFAULT cDirArqIn	:= ""
	DEFAULT aReturn		:= {}
	// Pega o nome do arquivo
	If !Empty(cDirArqIn)
		cNomeArq := Lower( AllTrim( SubStr( cDirArqIn, Rat(PLSMUDSIS('\'),cDirArqIn)+1) ) )
	EndIf
	// Index
	BXX->( DbSetOrder(1) ) //BXX_FILIAL + BXX_CODINT + BXX_CODRDA + BXX_ARQIN
	//Se e chamada para inclusao
	If lInc
		If Empty(cNomeArq)
			cRet := "Falha ao submeter (Verifique se o arquivo já foi submetido ou entre em contato com a operadora)"
			return cRet
		Endif
		If "ERROR" $ upper(alltrim(cUpldPath))

			QOut("----------INICIO: LOG DE ERRO NO UPLOAD PATH----------")
			QOut(GetEnvHost())
			QOut("UPLOADPATH")
			QOut(GetADV97())
			QOut(Upper( GetPvProfString( GetEnvHost(), "UPLOADPATH", "ERROR", GetADV97() ) ))
			QOut("----------FIM: LOG DE ERRO NO UPLOAD PATH----------")

			cRet := "Diretorio de upload nao informado no .INI do SERVER."
			return cRet
		else
			// verifica se o arquivo foi importado por outra rda
			BXX->( DbSetOrder(4) ) //BXX_FILIAL + BXX_CODINT + BXX_ARQIN
			if BXX->( MsSeek( xFilial("BXX") + lower(cCodInt + cNomeArq) ) ) .or. BXX->( MsSeek( xFilial("BXX") + upper(cCodInt + cNomeArq) ) )
				if BXX->BXX_CODRDA <> cCodRda .and. BXX->BXX_STATUS == '2'  //0=Em processamento;1=Acatado;2=Nao acatado;3=Processado
					Erase(PLSMUDSIS( cDirRaiz+"UPLOAD\BACKUP\") + cNomeArq )
				endIf
			endIf
			BXX->( DbSetOrder(1) ) //BXX_FILIAL + BXX_CODINT + BXX_CODRDA + BXX_ARQIN
		Endif

		If !BXX->( MsSeek( xFilial("BXX") + lower(cCodInt + cCodRda + cNomeArq) ) ) .and. !BXX->( MsSeek( xFilial("BXX") + upper(cCodInt + cCodRda + cNomeArq) ) )

			nH := ft_fUse(cDirUpload+cNomeArq)
			While !FT_FEOF() .and. nI < 100 .and. nH > 0
				xChave := alltrim( FT_FREADLN() )
				FT_FSKIP()
				nI++
				If upper("GuiaSADT") $ upper(xChave) .OR. upper("GuiaSP-SADT") $ upper(xChave) .OR. upper("SP_SADT") $ upper(xChave)
					cTipo 	:= '1'
					cTipGui := "02"
					exit
				Elseif upper("GuiaHonorarioIndividual") $ upper(xChave) .OR. upper("GuiaHonorarios") $ upper(xChave)
					cTipo 	:= '2'
					cTipGui := "06"
					exit
				Elseif upper("GuiaConsulta") $ upper(xChave)
					cTipo 	:= '0'
					cTipGui := "01"
					exit
				Elseif upper("GuiaResumo") $ upper(xChave)
					cTipo := '3'
					cTipGui := "05"
					exit
				Elseif upper("Odonto") $ upper(xChave)
					cTipo := '4'
					cTipGui := "07"
					exit
				Endif
			Enddo
			FT_FUse()
			If nH > 0
				fclose(nH)
			Endif

			cSeqBXX := BXX->(GetSx8num("BXX",'BXX_SEQUEN'))
			BXX->(ConfirmSX8())
			//ft_fuse(cDirUpload+cNomeArq)
			BXX->( RecLock("BXX",.T.) )
			BXX->BXX_FILIAL	:= xFilial("BXX")
			BXX->BXX_DATMOV	:= dDataBase
			BXX->BXX_CODINT	:= cCodInt
			BXX->BXX_CODUSR	:= cUsrName
			BXX->BXX_ARQIN 	:= cNomeArq
			BXX->BXX_CODRDA	:= cCodRda
			BXX->BXX_TPNFS	:= Iif( lOnline,'1','0')
			BXX->BXX_STATUS	:= Iif( Empty(cNomeArq),'3','0' )
			BXX->BXX_TPARQU	:= cTipo //a tendencia eh que este campo caia em desuso, ele so esta aqui pois ele nasceu primeiro que o TIPGUI, mas tem q ser assim por causa do legado
			BXX->BXX_TIPGUI	:= cTipGui
			BXX->BXX_SEQUEN	:= cSeqBXX
			If GetNewPar("MV_BLOQBAR","0") == "1"
				BXX->BXX_BLOQUE	:= Iif ( lOnline,'1','0')
			EndIf
			//0=Consulta;1=SpSadt;2=Hono.Ind.;3=Resmo Int.;4=Odonto
			BXX->( MsUnLock() )

			// Grava no Banco de Conhecimento
			PLSINCONH(cDirUpload+cNomeArq, "BXX", xFilial("BXX") + cSeqBXX, .T.)
			If lOnline
				cRet := "Upload terminado com SUCESSO"
			EndIf

			//Existe 0=Em processamento;1=Acatado;2=Nao acatado
		Else
			Do Case
				Case BXX->BXX_STATUS == '0'
				cRet := "Arquivo ja importado e nao foi processado"
				Case BXX->BXX_STATUS == '1'
				cRet := "Arquivo ja importado e foi acatado"
				Case BXX->BXX_STATUS == '2'
				cRet := "Arquivo ja importado e nao foi acatado"
				Case BXX->BXX_STATUS == '3'
				cRet := "Arquivo ja importado e ja foi processado"
			EndCase

			If !lOnline
				cRet += " [" + AllTrim(cNomeArq) + "]"
			EndIf
		EndIf
		//Processamento
	Else
		//Se existe 0=Nao Processado;1=Acatado;2=Nao acatado;3=Processado
		If BXX->( MsSeek( xFilial("BXX") + lower(cCodInt + cCodRda + cNomeArq) ) ) .or. BXX->( MsSeek( xFilial("BXX") + upper(cCodInt + cCodRda + cNomeArq) ) )

			// Nao tem erros
			If Len(aReturn) == 0 .Or. (Len(aReturn) > 0 .And. !aReturn[1]) .or. (Len(aReturn) > 0 .And. aReturn[1] .and. IsInCallStack("PLRRJOB") .and. Len(aReturn[3]) == 0 )
				// Online
				If lOnline
					cRet := "true|Arquivo "
				EndIf

				cRet += "acatado - Numero protocolo [ " + AllTrim(BXX->BXX_CODPEG) + "] "
				QOut(cRet)
				// Online
				If lOnline
					cRet += "|"
				EndIf
				// Monta informacoes q serao exibidas em tela
				If Len(aReturn[3]) > 0
					For nI:=1 to Len(aReturn[3])
						cRet += aReturn[3][nI] + Chr(13) + Chr(10)
					Next
				EndIf

				BXX->( RecLock("BXX",.F.) )
				BXX->BXX_STATUS := "1"
				BXX->( MsUnLock() )
			Else
				// Online
				If lOnline
					cRet := "true|"
				EndIf

				cRet += "Arquivo nao acatado devido a inconsistências detectadas."
				QOut(cRet)
				If lOnline
					cRet += "|"
				EndIf
				// Erros
				If Len(aReturn[3]) > 0
					For nI:=1 to Len(aReturn[3])
						cRet += aReturn[3][nI] + Chr(13) + Chr(10)
					Next
				EndIf
				// Grava o nome do arquivo para possivel download
				BXX->( RecLock("BXX",.F.) )
				BXX->BXX_STATUS := "2"
				BXX->( MsUnLock() )
			EndIf
		Else
			QOut('nao achou a bxx ['+cCodInt + cCodRda + cNomeArq+"]")
		Endif
	EndIf
	//Fim da funcao
Return(cRet)

/*/{Protheus.doc} u_CBXMLPRO
Atualiza o BXX_STATUS para 3 = xml processado
Com este status o link do relatorio de processamento estara disponivel no portal
@type Function
@author PLS
@since 16/04/12
/*/
user function CBXMLPRO(cCodRda,cArqIn,lOnline)
	LOCAL cArqLog	:= "XMLLOG"
	LOCAL cArqExt	:= ".TXT"
	DEFAULT lOnline := .T.
	// Procura registro do prestador/arquivo
	BXX->( DbSetOrder(1) ) //BXX_FILIAL + BXX_CODINT + BXX_CODRDA + BXX_ARQIN
	If BXX->(MsSeek(xFilial("BXX") + Lower(PLSINTPAD() + cCodRda + cArqIn) ) )
		// Processado
		BXX->( RecLock("BXX",.F.) )
		BXX->BXX_STATUS := "3"
		BXX->( MsUnLock() )
		// Renomeia o arquivo
		If FRename(cDirLog + cArqLog + cArqExt , cDirLog + cArqLog + BXX->(BXX_CODINT+BXX_CODPEG) + cArqExt ) == -1
			QOut("Impossivel renomear arquivo de LOG ( XMLLOG.TXT )")
		EndIf
	EndIf

Return Nil

/*/{Protheus.doc} xTemChar
@type Function
@author PLS
@since 16/04/12
/*/
static function xTemChar(cChave)
	LOCAL cChv2 := alltrim(cChave)
	LOCAL lRet  := IsDigit(cChv2)

	While lRet .and. !Empty(cChv2)
		cChv2 := right(cChv2,len(cChv2)-1)
		If !Empty(cChv2)
			lRet  := IsDigit(cChv2)
		Endif
	Enddo

Return !lRet

/*/{Protheus.doc} u_cbIsntPrd
@type Function
@author PLS
/*/
user function cbIsntPrd(aPred,aRet)
	LOCAL lRet  := .T.
	LOCAL nI	:=	1
	DEFAULT aPred := {}
	DEFAULT aRet  := {}

	For nI:=1 to Len(aPred)
		If aScan(aRet,{|x| aPred[nI] $ x }) > 0
			lRet := .F.
		Endif
	Next

return lRet

/*/{Protheus.doc} _pRETAULI
@type Function
@author Daher
@since 28/06/2013
/*/
static function _pRETAULI(cNumAut)
	LOCAL nI		 := 0
	LOCAL lFound   	 := .F.
	LOCAL cMacroIte  := ""
	LOCAL cBE2Valid  := "1"
	LOCAL cMacro     := "BEA->BEA_STATUS <> '5' .And. BEA->BEA_ORIGEM == '2'"
	LOCAL aItens   	 := {}

	// Se na web ou nao
	cMacroIte := "BE2->BE2_STATUS == '1'"
	nIndex := 1
	cChave := cNumAut

	// Verifica se o indice para pesquisa por matricula existe
	SIX->(DbSetOrder(1))
	If  SIX->(MsSeek("BEAA"))
		// Posiciona no cabecalho
		BEA->( DbSetOrder(nIndex) )
		If BEA->( MsSeek(xFilial("BEA")+cChave) ) .And. &cMacro
			// Ordem
			BAU->( DbSetOrder(1) )
			BB0->( DbSetOrder(1) )
			BR8->( DbSetOrder(1) )
			BE2->( DbSetOrder(1) )
			// Itens
			If BE2->( MsSeek(xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)) )
				While ! BE2->( Eof() ) .And. BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT) == ;
				xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)

					BR8->(MsSeek(xFilial("BR8")+BE2->(BE2_CODPAD+BE2_CODPRO)))

					// Validacao de itens
					If &cMacroIte
						// Adicao na aitens
						AaDd(aItens,{	If(BR8->BR8_TPPROC=="5","O","S"),;							//1  - Tipo de Servico (Servico ou OPM)
						BE2->BE2_SEQUEN,; 				   							//2  - Sequencia
						BE2->BE2_CODPAD,; 				   							//3  - Tabela
						AllTrim(BE2->BE2_CODPRO),;   	   							//4  - Procedimento
						AllTrim(BE2->BE2_DESPRO),; 									//5  - Descricao
						AllTrim(Str(Iif(BE2->BE2_QTDSOL==0,BE2->BE2_QTDPRO,BE2->BE2_QTDSOL))),;//6  - Qtd Solicitada
						AllTrim(Str(BE2->BE2_QTDPRO)),;							//7  - Qtd Autorizada
						If(BR8->(FieldPos("BR8_FABRIC"))>0,BR8->BR8_FABRIC,""),; 	//8  - Fabricante...
						BE2->BE2_VLRAPR,;											//9  - Vlr Unitario
						cBE2Valid,;                                                 //10 - podera ser exibido sim ou nao
						BE2->BE2_NUMINT,;											//11 - Se e item de uma internacao
						BE2->(Recno()),;											//12 - Recno
						BE2->BE2_SALDO,;											//13 - Saldo
						{},;													//14 - Matriz de tratamento do executante
						BE2->BE2_NIVAUT,;											//15 - Nivel da Autorizacao
						BE2->BE2_NIVCRI,;											//16 - Nivel da Critica
						BE2->BE2_CHVNIV,;                                        	//17 - Chave do Nivel
						AllTrim(BE2->BE2_DENREG)+'-'+AllTrim(BE2->BE2_DESREG),;   //18 - Dente - Descricao
						AllTrim(BE2->BE2_FADENT)+'-'+AllTrim(BE2->BE2_FACDES),;   //19 - Face - Descricao
						0,; 		                                       		//20 - Valor Us
						0,; 													//21 - Valor Contratado
						0,;                                        			//22 - Valor Participacao
						Iif(BE2->BE2_STATUS=='1','S','N'),; 						//23 - Autorizado sim ou nao
						AllTrim(BE2->BE2_DENREG),;    								//24 - Dente
						AllTrim(BE2->BE2_FADENT),;    								//25 - Face
						BE2->BE2_DATPRO,; 											//26 - Data do Evento
						"",;    													//27
						"",;    													//28
						"",;														//29 - Grau de Participacao
						"",;														//30 - Hora Inicio
						"",;                                           				//31 - Hora Fim
						"",;                                           				//32 - Via
						"",;                                           				//33 - Tec
						0,;                                           				//34 - Red Acre
						Iif( BE2->BE2_QTDSOL==0,BE2->BE2_QTDPRO,BE2->BE2_QTDSOL )*BE2->BE2_VLRAPR} )//35 - Valor apr total
					EndIf
					// Skip
					BE2->( DbSkip() )
				Enddo
			EndIf

		EndIf
	EndIf

	//Tratamento para que os procedimentos que não precisam de autorização não podem apresentar criticas de senhas³
	//Ha itens que o procedimento não precisam de autorização então a critica X23 não pode parar.
	lProcLib:=PlChkProc(cChave)
	lFound := Len(aItens) > 0

Return( {lFound,aItens ,lProcLib} )

/*/{Protheus.doc} u_CXMLTISVER
Retorna a versao do XML que foi montado o aDados
@type Function
@author Bruno Iserhardt
@since 23/07/2013
/*/
user function CXMLTISVER(aDados)
	Local cTissVer := ""
	DEFAULT aDados := {}

	//Percorre a tabela de versões TISS
	BVV->(DbSelectArea("BVV"))
	BVV->(DbSetOrder(1))
	If(BVV->(MsSeek(xFilial("BVV"))))
		//enquanto não encontrar a versão da tiss
		While (!BVV->(Eof()) .And. Empty(cTissVer))
			//procura a tag da versão no array de dados do XML
			cTissVer := u_CVLRTAGXML(aDados, Alltrim(BVV->BVV_CAMTAG)+Alltrim(BVV->BVV_TAG))
			//verifica se a versão encontrada no XML é igual a que está cadastrada na BVV
			//porque o caminho pode ser o mesmo para versões diferentes
			If (cTissVer == BVV->BVV_TISVER)
				EXIT
			Else
				BVV->(DbSkip())
			EndIF
		EndDo
	EndIf
Return cTissVer

/*/{Protheus.doc} u_C973MONEXP
Monta a expressão inserindo os dados das tags
O parametro nTagIdx indica qual a tag deve ser retornada valor caso a tag exista mais de uma vez no XML.
Ex.: Seleciona o codigo do segundo procedimento do XML. Então o nTagIdx deve ser 2
Isso sera util quando o array aDadosUnic representar o XML inteiro e nao apenas as tags unificadas.
Utilizado na funcao PLSTPTRAN
@type Function
@author Bruno Iserhardt
@since 23/07/2013
/*/
user function C973MONEXP(cExpressao, aDadosUnic, nTagIdx)
	Local cPathTag 	:= ""
	Local nBegin 		:= 0
	Local nEnd 		:= 0
	Local cTagValue	:= ""
	DEFAULT nTagIdx 	:= 1

	//percorre a expressão até não encontrar mais o separador de tags "[%"
	While (At("[%" ,cExpressao) > 0)
		//seleciona os indices do inicio e fim da tag
		nBegin := At("[%",cExpressao)
		nEnd := At("%]",cExpressao)
		//seleciona na expressão o caminho e a tag
		cPathTag := SubStr(cExpressao, nBegin+2, nEnd-nBegin-2)

		If (At(",", cPathTag) <= 0)
			//pega o valor da tag e insere aspas nas extremidades para passar o dado como string na expressão
			//cTagValue := "'" + u_CVLRTAGXML(aDadosUnic, cPathTag, nTagIdx) + "'"
			// enverti entre aspas simples e aspas duplas pq tem XML que vem com ' no nome ex: JOANA D'ARC, tbm pode aparecer ' em nome de medicamento, medico, etc. ai da error log
			cTagValue := '"' + u_CVLRTAGXML(aDadosUnic, cPathTag, nTagIdx) + '"'
			//substitui a tag pelo valor da tag na expressão
			cExpressao := StrTran(cExpressao, "[%" + cPathTag + "%]", cTagValue)
		Else
			//somente remove os caracteres "[%" e "%]"
			cExpressao := StrTran(cExpressao, "[%" + cPathTag + "%]", cPathTag)
		EndIf
	EndDo

Return cExpressao

/*/{Protheus.doc} u_CVLRTAGXML
Recebe um array do XML gerado pela funçao U_CXMLTOARR e retorna o valor da tag enviada por parâmetro

Ex.: \MENSAGEMTISS\CABECALHO\PADRAO
Também pode ser enviado só o final do caminho da tag

Ex.: DADOSBENEFICIÁRIO\NOMEBENEFICIARIO
Este parâmetro também pode ser passado separando os caminhos por virgula, assim a função retornará o valor da
primeira tag que encontrar.

Ex.: Seleciona o codigo do segundo procedimento do XML.
Então o nTagIdx deve ser 2
Isso sera util quando o array aDadosUnic representar o XML inteiro e nao apenas as tags unificadas.

Utilizado na funcao PLSTPTRAN

@type Function
@author Bruno Iserhardt
@since 06/08/2013
@param aDados, array, tag caminho da tag e o valor da tag
@param cCamTag, caracter, Caminho da tag e a tag a ser selecionado o valor.
@param nTagIdx, numerico, indica qual a tag deve ser retornada o valor caso a tag exista mais de uma vez no XML.
/*/
user function CVLRTAGXML(aDados, cCamTag, nTagIdx)
	Local cTagValue	:= ""
	Local cTagUn		:= ""
	Local nI			:= 0
	Local nC			:= 0
	Local nC2			:= 0
	Local aCamTag		:= StrTokArr(cCamTag, ",")
	Local aTagUn		:= {}
	Default aDados	:= {}
	Default nTagIdx	:= 1

	For nC:=1 To Len(aCamTag)

		//Utilizado para prevenir o erro em arquivos que possuam a TAG "SENHAPRESTADOR". Ao validar a TAG "SENHAPRESTADOR", o sistema estava se perdendo pois "SENHA" está contido em "SENHAPRESTADOR", gerando a crítica X23 incorretamente.
		aTagUn	:= StrTokArr(aCamTag[nC], "\")
		cTagUn	:= aTagUn[Len(aTagUn)]

		For nC2 := 1 To nTagIdx
			nI := aScan(aDados, {|x| UPPER(aCamTag[nC]) $ UPPER(StrTran(x[2], "\\", "\")+x[1]) .And. UPPER(cTagUn) == UPPER(x[1])}, IIF(nC2 == 1, 1, nI+1))
		Next
		//se não achou e passou mais de uma vez no for pesquisa de novo percorrendo todo o aDados novamente
		If (nI <= 0 .AND. nTagIdx > 1)
			nI := aScan(aDados, {|x| UPPER(aCamTag[nC]) $ UPPER(StrTran(x[2], "\\", "\")+x[1]) .And. UPPER(cTagUn) == UPPER(x[1])})
		EndIf

		If (nI > 0)
			cTagValue := aDados[nI,3]
			EXIT
		EndIf
	Next

Return cTagValue

/*/{Protheus.doc} u_CNewVldXML
Valida os XMLs da TISS a partir da versão 3.00.01
@type Function
@author Bruno Iserhardt
@since 30/06/2013
/*/
user function CNewVldXML(cFileXml,aDados,cTissVer,l974,cSeqBXX,cTipGui,__lOnline,aDadosGer)
	Local cErro		:= ""
	Local cAviso	  	:= ""
	Local cCdItem		:= ""
	Local cTag 		:= ""
	Local cTagValue 	:= ""
	Local cTpVld 		:= ""
	Local cAlias		:= ""
	Local nIndice		:= 0
	Local cCdTermi	:= ""
	Local cDadExp		:= ""
	Local cBlcPre		:= ""
	Local cBlcPos		:= ""
	Local cCodOpe		:= ""
	Local cPropri		:= ""
	Local cCodGlo		:= ""
	Local cLocalExec	:= '5'
	Local cTipoGrv	:= '1'
	Local cTagExc		:= "CBOS/CBO"
	Local cOpeMov		:= PLSINTPAD()
	Local lCriticOk	:= .T. //indica se a crítica está OK
	Local nI			:= 0
	Local nC			:= 0
	Local nC2			:= 0
	Local nC3			:= 0
	Local nindex		:= 0
	Local nRecGlo		:= 0
	Local aXSD		:= {}
	Local aRetExec	:= {}
	Local aMacros 	:= {}
	Local aCrit		:= {}
	Local lSeekBCT	:= .F.
	Local lVarOk		:= .T.
	Local lBenef		:= .f. //informa se ja passou pela tag beneficiarios
	Local lDebug		:= .F. //CRIAR UM MV_PAR LA NO PLSA974 PARA O CARA HABILITAR ESSAS MENSAGENS DE DEBUG - PENDENTE DAHER 20/05/14
	Local aTags		:= {}
	LOCAL aEvErros  	:= {}
	Local aVarsUnic	:= {} // Array que mantem(backup) a estrutura unica das variaveis para o sistema nao precisar ir sempre na BVP
	Local cPathTag	:= ""
	Local nMsgAux		:= 0
	Local cMsgAux		:= ""
	Local aMsgAux		:= {}
	Local nQtdX		:= 0
	Local nValX		:= 0
	Local nValTotX	:= 0
	Local nAcrX		:= 0
	Local lCalAcr		:= GetNewPar("MV_PLCLACR",.T.)
	//array com as criticas que não podem ir para conferência(BXV)
	Local aCritNConf	:= {"X17","X18","X19","X20","X24","X33"}
	Local nCt			:= 0
	Local nTp4			:= 0
	Local aTgsTp4		:= {}
	Local aBkpTp4		:= {}
	Local lVldTp4		:= .F.
	Local cTagVld4	:= ""
	Local cPathVld4	:= ""
	Local cGloVld4	:= ""
	Local nSeqTp4		:= ""
	Local nCompCri	:= 0
	PRIVATE aBkpDad 		:= aClone(aDados)
	PRIVATE aTabDup 		:= u_CBBusTerDup(SuperGetMv("MV_TISSCAB",.F.,"87"))
	PRIVATE aDadosCrm 	:= U_CBDADCRM(aDados)
	PRIVATE aDadosUnic	:= U_CDADOUNIC(aDados) //variável que representa o aDados, porém sem repetir as tags
	PRIVATE aTagsBVN		:= {} //array com todos os caminhos+tags e o recno da BVN
	PRIVATE aCrTp4			:= {}
	PRIVATE aDadosThd		:=  aClone(aDadosGer) // dados que vem da threads como vem particionado por Guia ao calcular o hash ira apresentar erro.
	PRIVATE aRet 			:= {.F., "", {}}
	PRIVATE _cPathTag		:= ""
	Default aDados 		:= {}
	Default l974			:= .f.
	Default __lOnline	:= .f.
	Default cTipGui		:= "08"	


	nSeqGui := 0

	lOnline := __lOnline

	DbSelectArea("BVV")
	BVV->(DbSetOrder(1)) //BVV_FILIAL+BVV_TISVER
	If BVV->(MSSeek(xFilial("BVV")+cTissVer ))
		aXSD := StrTokArr(BVV->BVV_XSD, '|') //array com todos os XSDs da versão.
	Endif

	//transforma as variáveis em PRIVATE para ficarem visíveis na Macro Substituição(&)
	// A DECLARAÇÃO ESTÁ TAMBÉM NA FUNÇÃO QUE CHAMA DE FORMA PROPOSITAL
	// A ROTINA DE GERAÇÃO DE MUCANÇA EM LOTES PRECISA DELA LÁ.
	_SetOwnerPrvt("aDados",aDados)
	_SetOwnerPrvt("cFileXml",cFileXml)

	If (Len(aXSD) <= 0)
		aRet[1] := .T.
		AaDd(aRet[3], "** ERRO [ Arquivos XSD ] **")
		AaDd(aRet[3], "Arquivos XSD não cadastrados na versao " + cTissVer + ".")
	Else

		// Realiza a validação da estrutura do XML com o XSD
		// O arquivo poderá estar no formato de Lote Guia ou TISS Online
		If (XmlFVldSch(cFileXml, cDirSchema+aXSD[1], @cErro,@cAviso) .or. XmlFVldSch(cFileXml, cDirSchema+aXSD[8], @cErro,@cAviso))
			// Criação das variáveis - BVP
			If U_CBVARTISS(aDadosUnic, cTissVer, "", , @aRet,nil,@aVarsUnic) .And. !aRet[1]

				//popula o array com os dados da BVN para ser utilizado na função u_CABGETCRIT
				u_CABBVNTAGS(cTissVer)

				// Validação dinâmica das críticas TISS - BVN
				//Percorre as TAGs do XML
				For nI:=1 To Len(aDados)

					//TAG
					cTag := aDados[nI,1]

					//CAMINHO DA TAG
					cPathTag 	:= StrTran(aDados[nI,2], "\\", "\")
					_cPathTag	:= cPathTag

					//VALOR DA TAG
					cTagValue := aDados[nI,3]

					//Se for o inicio de outra guia, pega a sequencia da guia
					if ("nSeqGui=" $ cTagValue)
						nSeqGui = Val(StrTokArr(cTagValue, "=")[2])

						//Atualiza as variaveis de codigo de procedimento e tabela para informar-las na tabela BXV (BCT_ENVCOX == '1')
						for nCt := nI to Len(aDados)
							if ("CODIGOPROCEDIMENTO" $ aDados[nCt,1])
								cCodPro := aDados[nCt,3]
								cCodPad := PADR(U_CBVARVINC('87', 'BR4', cSlvPad), 2)
								exit
							endif
						next nCt

					endif

					if nI == Len(aDados) .Or. ("nSeqGui=" $ cTagValue)
						//indica que deve validar a existencia da tag
						lVldTp4	:= .T.
						aTgsTp4	:= aClone(aBkpTp4)
						nSeqTp4	:= iif(nI == Len(aDados) .And. nSeqGui == 1,nSeqGui,nSeqGui - 1)
					endif

					//Validacao de existencia de tag
					aAdd(aBkpTp4,{AllTrim(cPathTag),AllTrim(cTag)})

					//ATENCAO, EVITAR UTILIZAR ***CHUMBAR*** AQUI NO PROGRAMA ESTE TIPO DE SITUACAO, SO USAR QUANDO FOR ESTRITAMENTE NECESSARIO
					If UPPER('nomeBeneficiario') $ UPPER(cTag)
						//esta variavel lBenef serve para dizer se eu vou ou nao imprimir o nome do beneficiario no log de erros
						//ela somente será preenchida apos a rotina passar pela TAG nomeBeneficiario para evitar de apreentar o nome
						//do beneficiario de maneira errada
						lBenef := .t.
						aEvErros := {}//se eu to na tag de beneficiario siginifica que eu ja estou em outra guia entao eu limpo os eventos
					Endif

					If UPPER('registroANS') $ UPPER(cTag)//limpo a variavel pois quando chega nessa tag significa que entrei em outra guia
						lBenef := .f.
					Endif

					//Procura a TAG no aDadosUnic
					If !(cTag $ cTagExc)
						//Tratamento criado no CHANGESET 254909
						//Problema ao validar a TAG de procedimento, quando alguns arquivos
						//tinham 2 procedimentos, o segundo procedimento nunca era tratado
						nIndex := aScan( aDadosUnic, {|x| x[1] 		== cTag})
					Else
						//Somente as TAGs definidas na variavel 'cTagExc' deve trazer mais de uma ocorrencia
						//sendo assim o caminho tambem deve ser validado (PADRAO)
						nIndex := aScan( aDadosUnic, {|x| x[2] + x[1] == cPathTag + cTag})
					EndIf

					//Verifica no aDadosUnic se esta indicado que a TAG existe mais de uma vez no aDados antes de atualizar
					If (nIndex > 0 .And. aDadosUnic[nIndex, 4])

						//Ajuste do aDadosUnic
						aDadosUnic[nIndex, 3] := cTagValue
						PAjustUnic(@aDadosUnic,cPathTag, cTag, cTagValue)

						//Variavel de controle para duplicidade de criticas e variaveis
						aSize(aMacros,0)
						aMacros := Nil
						aMacros := {}

						//Atualiza somente as VARIAVEIS DINAMICAS que utilizam a TAG em validacao.
						If !U_CBVARTISS(aDadosUnic, cTissVer, cPathTag+cTag, , @aRet,@aMacros,aVarsUnic)
							//Erro controlado: Caso encontre, sai do loop e exibe a mensagem informando o motivo.
							LOOP
						Else
							If Len(aMacros) > 0
								pExecMacro(@aMacros,@aRet,cPathTag+cTag)
							Endif
						Endif
					EndIf

					//seleciona todas as críticas da referente a tag agrupadas pelo BVN_GRPCND
					//Abaixo o comentário da Coluna e o seus indice no array aCrit
					//BVN_CDITEM=1 BVN_TAG=2 BVN_CAMTAG=3 BVN_TPVLD=4 BVN_ALIA=5 BVN_INDICE=6 BVN_DADEXP=7 BVN_CODTAB=8 BVN_BLCPRE=9 BVN_BLCPOS=10
					//BVN_GRPCND=11 BVN_CODOPE=12 BVN_PROPRI=13 BVN_CODGLO=14 BVN_TAGMSG=15 BVN_MSGAUX=16
					aCrit := u_CABGETCRIT(cTag, cPathTag)

					If (Len(aCrit) > 0)
						//Percorre todas as criticas da BVN
						For nC := 1 To Len(aCrit)

							//Reinicia o valor das variáveis
							lCriticOk	:= .T.
							cDescriGlo	:= ""

							//Dados BCT
							cCodOpe := aCrit[nC, 1, 12]
							cPropri := aCrit[nC, 1, 13]
							cCodGlo := aCrit[nC, 1, 14]

							//seleciona a descrição da crítica para guardar e caso necessário ser utilziada na chamada da função U_C973ADDER
							BCT->(DbSelectArea("BCT"))
							BCT->(DbSetOrder(1))
							lSeekBCT := BCT->(MSSeek(xFilial("BCT")+cCodOpe+cPropri+cCodGlo))
							If (lSeekBCT)
								cDescriGlo 	:= BCT->BCT_DESCRI
							EndIf

							//percorre o grupo de críticas, se epenas uma estiver OK então não deve exibir a crítica
							For nC2 := 1 To Len(aCrit[nC])

								If (nC2 > 1 .And. lCriticOk == .T.)
									EXIT //sai do loop pois é necessário apenas uma das validações do mesmo grupo(BVN_GRPCND) estar ok para não emitir a crítica
								EndIF

								//Código Item
								cCdItem := aCrit[nC, nC2, 1]
								//Tipo Validação
								cTpVld := aCrit[nC, nC2, 4]
								//Alias e Indice
								cAlias := aCrit[nC, nC2, 5]
								nIndice := aCrit[nC, nC2, 6]
								//Dado/Expressão
								cDadExp := aCrit[nC, nC2, 7]
								//Bloco de Pré Execução
								cBlcPre := aCrit[nC, nC2, 9]
								//Bloco de pós Execução
								cBlcPos := aCrit[nC, nC2, 10]

								//verifica se foi informado o bloco de código que deve ser executado no começo da validação
								If (!Empty(AllTrim(cBlcPre)))
									// Executa a expressão, só verifica se executou sem erro
									If (!U_CEXECEXP(cBlcPre, cCodGlo, cDescriGlo, cCdItem, aDadosUnic, @aRet)[1])
										//se ocorreu erro volta o loop
										LOOP
									EndIF
								EndIf

								//Busca Registro
								If (cTpVld == "1")

									//seleciona o alias e seu indice
									&(cAlias)->(DbSelectArea(cAlias))
									&(cAlias)->(DbSetOrder(nIndice))

									//se a expressão não foi informada
									If (Empty(AllTrim(cDadExp)))
										lCriticOk := &(cAlias)->(MsSeek(xFilial(cAlias)+cTagValue))
										//expressão informada, então apenas executa o seek, e se executou ok executa a expressão
									ElseIf (&(cAlias)->(MsSeek(xFilial(cAlias)+cTagValue)))
										// Executa a expressão
										aRetExec := U_CEXECEXP(cDadExp, cCodGlo, cDescriGlo, cCdItem, aDadosUnic, @aRet)

										//verifica se a expressão foi executada sem erro
										If (!aRetExec[1])
											//se ocorreu erro volta o loop
											LOOP
										EndIF

										//pega o retorno da crítica
										lCriticOk := aRetExec[2]
									Else
										//informa que ocorreu um erro
										lCriticOk := .F.
									EndIF

									//Valida Terminologia
								ElseIf (cTpVld == "2")

									//seta o código da terminologia
									cCdTermi := aCrit[nC, nC2, 8]

									BTQ->(DbSelectArea("BTQ"))
									BTQ->(DbSetOrder(1)) //BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM

									lCriticOk := BTQ->(MsSeek(xFilial("BTQ")+cCdTermi+AllTrim(cTagValue)))

									//se o seek acima foi bem sucedido então verifica se o item da terminologia tem alguma relação na tabela de De/Para(BTU)
									If lCriticOk  .and. BCT->(FieldPos('BCT_ENVCOX')) > 0 .and. BCT->BCT_ENVCOX <> "1"  // se tiver habilitado nao posso criticar na submissao do arquivo
										BTU->(DbSelectArea("BTU"))
										BTU->(DbSetOrder(3)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_CDTERM
										If !BTU->(MsSeek(xFilial("BTU")+cCdTermi+cAlias+cTagValue)) ///.And. cCdTermi <> "24"
											//Adiciona a crítica no array de erros					  // neste fonte nao deve existir este tipo de situacao
											aRet[1] := .T.											  // sempre que for necessario implementar isso, deve ser feito no load3
											If (lSeekBCT)
												aAdd(aRet[3], "** ERRO ["+cCodGlo+"] **")
											Else
												aAdd(aRet[3], "** ERRO **")
											EndIf
											aAdd(aRet[3],"Cadastro de-para invalido para o item")
											aAdd(aRet[3],"Terminologia : "+cCdTermi)
											If Empty(aCrit[nC, nC2, 15])
												aAdd(aRet[3],"Tag : "+cPathTag+cTag)
												aAdd(aRet[3],"Valor no XML : "+cTagValue)
											Else
												If ("," $ aCrit[nC, nC2-1, 15])
													aTags := StrTokArr ( aCrit[nC, nC2-1, 15], "," )
													For nC3 := 1 To Len(aTags)
														If (!EMPTY(u_CVLRTAGXML(aDadosUnic, AllTrim(aTags[nC3]))))
															aAdd(aRet[3],"Tag : "+aTags[nC3])
															aAdd(aRet[3],"Valor no XML : "+u_CVLRTAGXML(aDadosUnic, AllTrim(aTags[nC3])))
															EXIT
														EndIf
													Next
												Elseif aCrit[nC, nC2-1, 15] <> "*"
																								 
													aAdd(aRet[3],"Tag XML: "+aCrit[nC, nC2-1, 15])
													aAdd(aRet[3],"Valor no XML : "+u_CVLRTAGXML(aDadosUnic, AllTrim(aCrit[nC, nC2-1, 15])))
												EndIf
											EndIf
											aAdd(aRet[3],"Alias : "+cAlias)
											aAdd(aRet[3],"")
										EndIF
									EndIf

									//Expressão
								ElseIf (cTpVld == "3")

									//verifica se tem alias cadastrado para realizar um Seek antes da expressão
									If (!Empty(AllTrim(cAlias)) .And. nIndice > 0)
										&(cAlias)->(DbSelectArea(cAlias))
										&(cAlias)->(DbSetOrder(nIndice))

										//executa o Seek
										//caso o seek não seja realizado com sucesso, volta para o topo pois a expressão pode ser um seek também
										If !(&(cAlias)->(MsSeek(xFilial(cAlias)+cTagValue)))
											&(cAlias)->(DbGoTop())
										EndIf
									EndIf

									//Tratativa para manter o registro da Glosa salva, caso a expressao cadastrada da BVN execute uma funcao que perca o registro
									nRecGlo := BCT->(RecNo())

									// Executa a expressão
									aRetExec := U_CEXECEXP(cDadExp, cCodGlo, cDescriGlo, cCdItem, aDadosUnic, @aRet)

									//Retornando ao registro
									BCT->(dbGoTo(nRecGlo))

									//pega o retorno da crítica
									lCriticOk := aRetExec[2]

									//verifica se a expressão foi executada sem erro
									If (!aRetExec[1])
										//se ocorreu erro volta o loop
										LOOP
									EndIF

								EndIf

								//verifica se foi informado o bloco de código que deve ser executado no final da validação
								If (lCriticOk .And. !Empty(AllTrim(cBlcPos)))
									// Executa a expressão, só verifica se executou sem erro
									If (!U_CEXECEXP(cBlcPos, cCodGlo, cDescriGlo, cCdItem, aDadosUnic, @aRet)[1])
										//se ocorreu erro volta o loop
										LOOP
									EndIF
								EndIf
							Next

							//Se ocorreu algum erro
							If !lCriticOk

								If aScan(aEvErros,{|x| x == cSlvPad+cSlvPro}) > 0
									loop
								Endif

								If  !u_cbIsntPrd({__aXMLCri17[1],__aXMLCri16[1],__aXMLCri29[1],__aXMLCri10[1]},aRet[3]) .and. ;
								cCodGlo $__aXMLCri37[1]+__aXMLCri28[1]+__aXMLCri31[1]+__aXMLCri30[1]+__aCdCri175[1]+__aXMLCri44[1]
									loop
								Endif

								//se for a critica 15 e a critica x6 e x6 estiverem desabilitadas nao preciso criticar a 15 pois nao faz sentido
								If  cCodGlo $ __aXMLCri15[1] .and. !PLSPOSGLO(cOpeMov,__aXMLCri06[1],__aXMLCri06[2],cLocalExec,'1',cTipoGrv) ;
								.and. !PLSPOSGLO(cOpeMov,__aXMLCri08[1],__aXMLCri08[2],cLocalExec,'1',cTipoGrv)
									loop
								Endif

								//se a critica estiver no array aCritNConf ou BCT->BCT_ENVCOX == '0' então a crítica não pode ir para conferência
								//e o XML deve ser criticado
								If aScan(aCritNConf, {|x| x==BCT->(BCT_PROPRI+BCT_CODGLO)}) > 0 .OR. ;
								BCT->(FieldPos('BCT_ENVCOX')) == 0 .or. !PLsAliasExi("BXV") .or. (BCT->BCT_ENVCOX == '0' .OR. Empty(BCT->BCT_ENVCOX))
									aRet[1] := .T.
									aAdd(aRet[3], "** ERRO [" + cCodGlo + "] **")

									If cCodGlo $ __aXMLCri27[1]
										aadd(aEvErros,cSlvPad+cSlvPro)
									Endif

									If (lSeekBCT)
										aAdd(aRet[3],BCT->BCT_DESCRI)
									EndIf

									If !EMPTY(aCrit[nC, nC2-1, 16])
										//Desenvolvido para utilizar o caracter "#" como token de quebra
										//de linha para mensagem auxiliar
										If At("#",aCrit[nC, nC2-1, 16]) > 0
											aMsgAux:= StrTokArr(aCrit[nC, nC2-1, 16],"#")
											For nMsgAux := 1 to Len(aMsgAux)
												cMsgAux := &(aMsgAux[nMsgAux])
												Iif(!Empty(cMsgAux),aAdd(aRet[3],cMsgAux),NIL)
											Next
										Else
											aAdd(aRet[3],&(aCrit[nC, nC2-1, 16]))
										EndIf
									EndIf

									If Empty(aCrit[nC, nC2-1, 15])
										aAdd(aRet[3],"Tag XML: "+cPathTag+cTag)
										aAdd(aRet[3],"Valor no XML : "+cTagValue)
									Else
										If ("," $ aCrit[nC, nC2-1, 15])
											aTags := StrTokArr ( aCrit[nC, nC2-1, 15], "," )
											For nC3 := 1 To Len(aTags)
												If (!EMPTY(u_CVLRTAGXML(aDadosUnic, AllTrim(aTags[nC3]))))
													aAdd(aRet[3],"Tag : "+aTags[nC3])
													aAdd(aRet[3],"Valor no XML : "+u_CVLRTAGXML(aDadosUnic, AllTrim(aTags[nC3])))
													EXIT
												EndIf
											Next
										Elseif alltrim(aCrit[nC, nC2-1, 15]) <> "*"
											aAdd(aRet[3],"Tag XML: "+aCrit[nC, nC2-1, 15])
											aAdd(aRet[3],"Valor no XML : "+u_CVLRTAGXML(aDadosUnic, AllTrim(aCrit[nC, nC2-1, 15])))
										EndIf
									EndIf

									If !("PLVLDCHSH" $ cDadExp) .and. lBenef
										aAdd(aRet[3],"Beneficiario: "+ aDadosUnic[aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEBENEFICIARIO'  })][3])
										If aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NUMEROGUIAPRESTADOR'  }) > 0
											aAdd(aRet[3],"Numero da Guia do Prestador: "+ aDadosUnic[aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NUMEROGUIAPRESTADOR'  })][3])
										Endif

										If Type('CCOMPCRI')<> 'U'

											//Verifica se existe conteudo na variavel de complemento das criticas
											If !Empty(CCOMPCRI)
												nCompCri := 1
												While !Empty(MemoLine(CCOMPCRI,254,nCompCri))
													aAdd(aRet[3],AllTrim(MemoLine(CCOMPCRI,254,nCompCri)))
													nCompCri++
												EndDo
											ElseIf RAT(cPathTag,'EQUIPESADT\') > 0//Dentro de EQUIPESADT o nome da tag e NOMEPROF
												If aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEPROF' }) > 0
													aAdd(aRet[3],"Nome do Profissional: "+ aDadosUnic[aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEPROF' })][3])
												Endif
											Else//fora de EQUIPESADT o nome da tag e NOMEPROFISSIONAL
												If aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEPROFISSIONAL' }) > 0
													aAdd(aRet[3],"Nome do Profissional: "+ aDadosUnic[aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEPROFISSIONAL' })][3])
												Endif
											EndIf

											CCOMPCRI := ""

										else
											If RAT(cPathTag,'EQUIPESADT\') > 0//Dentro de EQUIPESADT o nome da tag e NOMEPROF
												If aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEPROF' }) > 0
													aAdd(aRet[3],"Nome do Profissional: "+ aDadosUnic[aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEPROF' })][3])
												Endif
											Else//fora de EQUIPESADT o nome da tag e NOMEPROFISSIONAL
												If aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEPROFISSIONAL' }) > 0
													aAdd(aRet[3],"Nome do Profissional: "+ aDadosUnic[aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEPROFISSIONAL' })][3])
												Endif
											EndIf
										Endif
									Else
										If Type('CCOMPCRI')<> 'U'

											//Verifica se existe conteudo na variavel de complemento das criticas
											If !Empty(CCOMPCRI)
												nCompCri := 1
												While !Empty(MemoLine(CCOMPCRI,254,nCompCri))
													aAdd(aRet[3],AllTrim(MemoLine(CCOMPCRI,254,nCompCri)))
													nCompCri++
												EndDo
											EndIf

											CCOMPCRI := ""

										EndIf
									Endif

									If (cTpVld $ "1,3")
										If l974 .and. lDebug
											If !Empty(cAlias)
												aAdd(aRet[3],"Alias: "+cAlias)
											Endif
											If nIndice > 0
												aAdd(aRet[3],"Indice: "+cValToChar(nIndice))
											Endif
											aAdd(aRet[3],"Dado/Expressao: "+cDadExp)
											aAdd(aRet[3],"Dado/Expressao Executado: "+u_C973MONEXP(cDadExp, aDadosUnic))
										Endif
										If "PLVLDCHSH" $ cDadExp // Necessário exibir o Hash correto do arquivo
											aAdd(aRet[3],"Hash do conteúdo: "+PLVLDCHSH())
										EndIf
									ElseIf (cTpVld == "2")
										If l974 .and. lDebug
											If !Empty(cAlias)
												aAdd(aRet[3],"Alias: "+cAlias)
											Endif
											aAdd(aRet[3],"Terminologia: "+cCdTermi)
										Endif
									EndIf


									If l974 .and. lDebug
										If (!EMPTY(cBlcPre))
											aAdd(aRet[3],"Bloco Pre: "+cBlcPre)
										EndIF
										If (!EMPTY(cBlcPos))
											aAdd(aRet[3],"Bloco Pós: "+cBlcPos)
										EndIF
									Endif
									aAdd(aRet[3],"")
								Else
									If (lSeekBCT)
										PAddBXV(cCodGlo, BCT->BCT_DESCRI, nSeqGui, cCodPad, cCodPro, cSeqBXX)
									Else
										PAddBXV(cCodGlo, "", nSeqGui, cCodPad, cCodPro, cSeqBXX)
									EndIf
									If !EMPTY(aCrit[nC, nC2-1, 16])
										//Desenvolvido para utilizar o caracter "#" como token de quebra
										//de linha para mensagem auxiliar
										If At("#",aCrit[nC, nC2-1, 16]) > 0
											aMsgAux:= StrTokArr(aCrit[nC, nC2-1, 16],"#")
											For nMsgAux := 1 to Len(aMsgAux)
												cMsgAux := &(aMsgAux[nMsgAux])
												Iif(!Empty(cMsgAux),PAddBXV("",cMsgAux, nSeqGui, cCodPad, cCodPro, cSeqBXX),NIL)
											Next
										Else
											PAddBXV("",&(aCrit[nC, nC2-1, 16]), nSeqGui, cCodPad, cCodPro, cSeqBXX)
										EndIf
									EndIf
									If EMPTY(aCrit[nC, nC2-1, 15])
										PAddBXV("", "Tag XML: "+cPathTag+cTag, nSeqGui, cCodPad, cCodPro, cSeqBXX)
										PAddBXV("", "Valor no XML : "+cTagValue, nSeqGui, cCodPad, cCodPro, cSeqBXX)
									ElseIf ("," $ aCrit[nC, nC2-1, 15])
										aTags := StrTokArr ( aCrit[nC, nC2-1, 15], "," )
										For nC3 := 1 To Len(aTags)
											If (!EMPTY(u_CVLRTAGXML(aDadosUnic, aTags[nC3])))
												aAdd(aRet[3],"Tag : "+aTags[nC3])
												aAdd(aRet[3],"Valor no XML : "+u_CVLRTAGXML(aDadosUnic, aTags[nC3]))
												EXIT
											EndIf
										Next
									Elseif aCrit[nC, nC2-1, 15] <> "*"
										PAddBXV("", "Tag XML: "+aCrit[nC, nC2-1, 15], nSeqGui, cCodPad, cCodPro, cSeqBXX)
										PAddBXV("", "Valor no XML : "+u_CVLRTAGXML(aDadosUnic, aCrit[nC, nC2-1, 15]), nSeqGui, cCodPad, cCodPro, cSeqBXX)
									EndIf
									If !("PLVLDCHSH" $ cDadExp ) .and. lBenef
										PAddBXV("", "Beneficiario: "+ aDadosUnic[aScan(aDadosUnic,{|x| alltrim(x[1]) == 'NOMEBENEFICIARIO'  })][3], nSeqGui, cCodPad, cCodPro, cSeqBXX)
									Endif

									PAddBXV("","", nSeqGui, cCodPad, cCodPro, cSeqBXX)
								EndIf
							EndIF
						Next
					EndIf

					//percorre as validacoes Existencia da TAG
					if lVldTp4

						//Zera para alimentar a referencia da proxima guia
						aSize(aBkpTp4,0)
						aBkpTp4 := Nil
						aBkpTp4 := {}

						lVldTp4	:= .F.

						for nTp4 := 1 to Len(aCrTp4)
							//Armazena caminho e TAG
							cTagVld4	:= StrTran(aCrTp4[nTp4][1],'-','_')
							cPathVld4	:= StrTran(aCrTp4[nTp4][2],'-','_')
							cGloVld4	:= aCrTp4[nTp4][4] + aCrTp4[nTp4][5]

							//Posiciona na critica
							BCT->(DbSelectArea("BCT"))
							BCT->(DbSetOrder(1))
							BCT->(MSSeek(xFilial("BCT") + PLSIntPad() + cGloVld4))

							//Se foi informado o caminho da TAG e o mesmo nao existe, pode ser que sejam criticas especificas para um tipo de guia.
							//Sendo assim, primeiro devo avaliar se o caminho existe. Para diferenciar os tipos de guia, o campo BVN_CAMTAG
							//deve conter alguma TAG que defina o tipo de guia (ex.: \LOTEGUIAS\GUIASTISS\GUIARESUMOINTERNACAO\).
							If !Empty(cPathVld4) .And. (aScan( aTgsTp4,{|x| cPathVld4 $ Upper(x[1])} ) > 0)
								If (aScan( aTgsTp4,{|x| Upper(cPathVld4 + cTagVld4) $ x[1] + x[2]} ) <= 0)
									If nSeqTp4	 == 0 .Or. (aScan(aCritNConf, {|x| x==BCT->(BCT_PROPRI+BCT_CODGLO)}) > 0 .Or. ;
									BCT->(FieldPos('BCT_ENVCOX')) == 0 .or. !PLsAliasExi("BXV") .or. (BCT->BCT_ENVCOX == '0' .Or. Empty(BCT->BCT_ENVCOX)))

										//Adiciona a critica no array de erros
										aRet[1] := .T.
										aAdd(aRet[3], "** ERRO [" + cGloVld4 + "] **")
										aAdd(aRet[3],"Tag nao encontrada no XML.")
										aAdd(aRet[3],"Arquivo: " + cFileXml)
										aAdd(aRet[3],"Caminho da Tag: " + cPathVld4)
										aAdd(aRet[3],"Tag XML: " + cTagVld4)
										aAdd(aRet[3],"")

										//Mensagem auxiliar
										If !EMPTY(aCrTp4[nTp4][8])
											//Desenvolvido para utilizar o caracter "#" como token de quebra
											//de linha para mensagem auxiliar
											If At("#",aCrTp4[nTp4][8]) > 0
												aMsgAux:= StrTokArr(aCrTp4[nTp4][8],"#")
												For nMsgAux := 1 to Len(aMsgAux)
													cMsgAux := &(aMsgAux[nMsgAux])
													Iif(!Empty(cMsgAux),aAdd(aRet[3],cMsgAux),NIL)
												Next
											Else
												aAdd(aRet[3],&(aCrTp4[nTp4][8]))
											EndIf
										EndIf
									Else
										PAddBXV(cGloVld4, BCT->BCT_DESCRI, nSeqTp4, , , cSeqBXX)
										PAddBXV("", "Tag nao encontrada no XML.", nSeqTp4, , , cSeqBXX)
										PAddBXV("", "Caminho da Tag: " + cPathVld4, nSeqTp4, , , cSeqBXX)
										PAddBXV("", "Arquivo: " + cFileXml, nSeqTp4, , , cSeqBXX)
										PAddBXV("", "Tag XML: " + cTagVld4, nSeqTp4, , , cSeqBXX)
										If !EMPTY(aCrTp4[nTp4][8])
											//Desenvolvido para utilizar o caracter "#" como token de quebra
											//de linha para mensagem auxiliar
											If At("#",aCrTp4[nTp4][8]) > 0
												aMsgAux:= StrTokArr(aCrTp4[nTp4][8],"#")
												For nMsgAux := 1 to Len(aMsgAux)
													cMsgAux := &(aMsgAux[nMsgAux])
													Iif(!Empty(cMsgAux),PAddBXV("",cMsgAux, nSeqTp4, , , cSeqBXX),NIL)
												Next
											Else
												PAddBXV("",&(aCrTp4[nTp4][8]), nSeqTp4, , , cSeqBXX)
											EndIf
										EndIf
									EndIf
								EndIf
								//Caso contratio, verifico a existencia da TAG de modo geral desprezando o caminho
							ElseIf Empty(cPathVld4) .And. (aScan( aTgsTp4,{|x| cTagVld4 $ Upper(x[2])} ) <= 0)
								If aScan(aCritNConf, {|x| x==BCT->(BCT_PROPRI+BCT_CODGLO)}) > 0 .OR. ;
								BCT->(FieldPos('BCT_ENVCOX')) == 0 .or. !PLsAliasExi("BXV") .or. (BCT->BCT_ENVCOX == '0' .OR. Empty(BCT->BCT_ENVCOX))

									//Adiciona a critica no array de erros
									aRet[1] := .T.
									aAdd(aRet[3], "** ERRO [" + cGloVld4 + "] **")
									aAdd(aRet[3],"Tag nao encontrada no XML.")
									aAdd(aRet[3],"Arquivo: " + cFileXml)
									aAdd(aRet[3],"Tag XML: " + cTagVld4)
									aAdd(aRet[3],"")

									//Mensagem auxiliar
									If !EMPTY(aCrTp4[nTp4][8])
										//Desenvolvido para utilizar o caracter "#" como token de quebra
										//de linha para mensagem auxiliar
										If At("#",aCrTp4[nTp4][8]) > 0
											aMsgAux:= StrTokArr(aCrTp4[nTp4][8],"#")
											For nMsgAux := 1 to Len(aMsgAux)
												cMsgAux := &(aMsgAux[nMsgAux])
												Iif(!Empty(cMsgAux),aAdd(aRet[3],cMsgAux),NIL)
											Next
										Else
											aAdd(aRet[3],&(aCrTp4[nTp4][8]))
										EndIf
									EndIf
								Else
									PAddBXV(cGloVld4, BCT->BCT_DESCRI, nSeqTp4, , , cSeqBXX)
									PAddBXV("", "Tag nao encontrada no XML.", nSeqTp4, , , cSeqBXX)
									PAddBXV("", "Arquivo: " + cFileXml, nSeqTp4, , , cSeqBXX)
									PAddBXV("", "Tag XML: " + cTagVld4, nSeqTp4, , , cSeqBXX)
									If !EMPTY(aCrTp4[nTp4][8])
										//Desenvolvido para utilizar o caracter "#" como token de quebra
										//de linha para mensagem auxiliar
										If At("#",aCrTp4[nTp4][8]) > 0
											aMsgAux:= StrTokArr(aCrTp4[nTp4][8],"#")
											For nMsgAux := 1 to Len(aMsgAux)
												cMsgAux := &(aMsgAux[nMsgAux])
												Iif(!Empty(cMsgAux),PAddBXV("",cMsgAux, nSeqTp4, , , cSeqBXX),NIL)
											Next
										Else
											PAddBXV("",&(aCrTp4[nTp4][8]), nSeqTp4, , , cSeqBXX)
										EndIf
									EndIf
								EndIf
							EndIf
						next

						//Zera para pegar a referencia da proxima guia
						aSize(aTgsTp4,0)
						aTgsTp4 := Nil
						aTgsTp4 := {}

					endif

				Next
			EndIf
		Else
			aRet[1] := .T.
			AaDd(aRet[3], "** ERRO [ Estrutura XML ] **")
			AaDd(aRet[3], cErro)
		EndIf
	EndIf

	//Percorrendo todo o XML em busca de valores para alimentar na BXX e BCI
	nValTotG  := 0
	If cTipgui == '01'
		//Tratamento especifico para guia de consulta. Nao existe a tag QUANTIDADEEXECUTADA, apenas a tag VALORPROCEDIMENTO
		While (nI := aScan(aDados,{|x| AllTrim(x[1]) == 'VALORPROCEDIMENTO'  })) > 0
			nValTotG += val(aDados[nI][3])
			//Removendo a chave para nao ficar em looop infinito
			aDados[nI][1] := ''
		Enddo
	Else
		While (nQtdX := aScan(aDados,{|x| alltrim(x[1]) == 'QUANTIDADEEXECUTADA' })) > 0 .And. (nValX := aScan(aDados,{|x| alltrim(x[1]) == 'VALORUNITARIO' })) > 0 .And. (nAcrX := aScan(aDados,{|x| alltrim(x[1]) == 'REDUCAOACRESCIMO' })) > 0  .And. (nValTotX := aScan(aDados,{|x| alltrim(x[1]) == 'VALORTOTAL' })) > 0
			//Aplica o acrescimo/redutor caso o parametro esteja ativado
			If val(aDados[nValX][3]) > 0
				Iif(lCalAcr,nValTotG += (val(aDados[nValX][3]) * val(aDados[nQtdX][3])) * iif(val(aDados[nAcrX][3])==0,1,val(aDados[nAcrX][3])),nValTotG += (val(aDados[nValX][3]) * val(aDados[nQtdX][3])))
			Else
				Iif(lCalAcr,nValTotG += val(aDados[nValTotX][3]) * val(aDados[nAcrX][3]),nValTotG += (val(aDados[nValTotX][3])))
			EndIf
			//Removendo a chave para nao ficar em looop infinito
			aDados[nValX][1] 		:= ''
			aDados[nQtdX][1] 		:= ''
			aDados[nAcrX][1] 		:= ''
			aDados[nValTotX][1] 	:= ''
		Enddo
	EndIf

	nValTot3X := nValTotG

	If IsInCallStack("PLSXMLBATCH")
		aRet[2] := BAU->BAU_CODIGO
	EndIf
Return aRet

/*/{Protheus.doc} u_CABBVNTAGS
Retorna um array com o recno e o Caminho+TAG de todas as críticas da BVN.
@type Function
@author Bruno Iserhardt
@since 03/09/13
/*/
user function CABBVNTAGS(cTissVer)
	LOCAL cLocalExec	:= '5'
	LOCAL cOpeMov 	:= PlsIntPad()
	LOCAL cTipoGrv	:= '1'
	LOCAL nI		 	:= 1

	BVN->(DbSelectArea("BVN"))
	BVN->(DbSetOrder(1)) //BVN_FILIAL+BVN_TISVER+BVN_TAG+BVN_CAMTAG

	If (BVN->(MsSeek(xFilial("BVN")+cTissVer)))

		While (!BVN->(Eof()) .And. BVN->(BVN_FILIAL+BVN_TISVER) == xFilial("BVN")+cTissVer)
			If (BVN->BVN_TPVLD != "4")
				If (nI:= aScan(__XACRITICAS,{|x| alltrim(x[1]) == alltrim(BVN->(BVN_PROPRI+BVN_CODGLO)) })) > 0
					//| Esta critica em especifico eu crio ela INATIVA pois em autogestoes e medicinas de grupos           |
					//| o prestador vai sempre mandar o xml e eles sempre vao pagar com base no xml, ja em unimeds         |
					//| se o cara ja executou no portal ele nao pode mandar denovo no XML                                  |
					If __XACRITICAS[nI][1] == __aXMLCri28[1]
						cTp := '0'
					Else
						cTp := '1'
					Endif
					//eu tenho que fazer o PLSPOSGLO para criar a critica caso ela nao exista e tb para tratar o caso
					//em que eu quero acatar o arquivo mais eu vou critica-lo depois na mudanca de fase
					If PLSPOSGLO(cOpeMov,__XACRITICAS[nI][1],__XACRITICAS[nI][2],cLocalExec,cTp,cTipoGrv)
						cCanTag := alltrim(strtran(strtran(alltrim(BVN->BVN_CAMTAG),chr(09),''),chr(11),''))//tiro o tab
						cTag    := alltrim(strtran(strtran(alltrim(BVN->BVN_TAG),chr(09),''),chr(11),''))//tiro o tab
						aAdd(aTagsBVN, {cCanTag+cTag, BVN->(Recno())})
					EndIf
				Endif
			Else
				If (nI:= aScan(__XACRITICAS,{|x| alltrim(x[1]) == alltrim(BVN->(BVN_PROPRI+BVN_CODGLO)) })) > 0
					cTag    := alltrim(strtran(strtran(alltrim(BVN->BVN_TAG),chr(09),''),chr(11),''))//tiro o tab
					cCanTag := alltrim(strtran(strtran(alltrim(BVN->BVN_CAMTAG),chr(09),''),chr(11),''))//tiro o tab

					aAdd(aCrTp4, {	cTag,;     			// [1]
					cCanTag,;  			// [2]
					BVN->BVN_DADEXP,; 	// [3]
					BVN->BVN_PROPRI,; 	// [4]
					BVN->BVN_CODGLO,; 	// [5]
					BVN->BVN_CODOPE,;	// [6]
					IIf(BVN->( FieldPos("BVN_MSGAUX") ) > 0, BVN->BVN_TAGMSG,""),;	// [7]
					IIf(BVN->( FieldPos("BVN_MSGAUX") ) > 0, BVN->BVN_MSGAUX,"")})// [8]
				Endif
			Endif
			BVN->(DbSkip())
		EndDo
	EndIF
Return aTagsBVN

/*/{Protheus.doc} u_CABGETCRIT
Retorna todas as críticas existentes para a mesma tag
@type Function
@author Bruno Iserhardt
@since 28/08/13
/*/
user function CABGETCRIT(cTag,cPathTag)
	Local nIGroup 	:= 0
	Local nI 		:= 1
	Local aCrit 	:= {}

	BVN->(DbSelectArea("BVN"))

	//aTagsBVN gerado pela função u_CABBVNTAGS
	For nI := 1 To Len(aTagsBVN)

		If (alltrim(aTagsBVN[nI,1]) $ cPathTag+cTag)

			//posiciona a BVN na crítica pelo RECNO
			BVN->(DbGoTo(aTagsBVN[nI, 2]))

			//veririfca se a crítica tem algum grupo
			nIGroup := 0
			If (!Empty(AllTrim(BVN->BVN_GRPCND)))
				//procura se o grupo ja está adicionado no array de críticas
				nIGroup := aScan(aCrit, {|x| x[1, 11] == BVN->BVN_GRPCND})
			EndIF

			If (nIGroup > 0)
				//adiociona a crítica no array do seu grupo correspondente
				cCanTag := alltrim(strtran(strtran(alltrim(BVN->BVN_CAMTAG),chr(09),''),chr(11),''))//tiro o tab
				cTag    := alltrim(strtran(strtran(alltrim(BVN->BVN_TAG),chr(09),''),chr(11),''))//tiro o tab
				aAdd(aCrit[nIGroup], {BVN->BVN_CDITEM,;  //1
				cTag,;     //2
				cCanTag,;  //3
				BVN->BVN_TPVLD,;   //4
				BVN->BVN_ALIAS,;   //5
				BVN->BVN_INDICE,;  //6
				BVN->BVN_DADEXP,;  //7
				BVN->BVN_CODTAB,;  //8
				BVN->BVN_BLCPRE,;  //9
				BVN->BVN_BLCPOS,;  //10
				BVN->BVN_GRPCND,;  //11
				BVN->BVN_CODOPE,;  //12
				BVN->BVN_PROPRI,;  //13
				BVN->BVN_CODGLO,;  //14
				IIf(BVN->( FieldPos("BVN_MSGAUX") ) > 0, BVN->BVN_TAGMSG,""),; //15 BVN->( FieldPos("BVN_VIGINI") ) > 0
				IIf(BVN->( FieldPos("BVN_MSGAUX") ) > 0, BVN->BVN_MSGAUX,"")}) //16
			Else
				//adiociona a crítica no array
				cCanTag := alltrim(strtran(strtran(alltrim(BVN->BVN_CAMTAG),chr(09),''),chr(11),''))//tiro o tab
				cTag    := alltrim(strtran(strtran(alltrim(BVN->BVN_TAG),chr(09),''),chr(11),''))//tiro o tab
				aAdd(aCrit, {{BVN->BVN_CDITEM,;  //1
				cTag,;     //2
				cCanTag,;  //3
				BVN->BVN_TPVLD,;   //4
				BVN->BVN_ALIAS,;   //5
				BVN->BVN_INDICE,;  //6
				BVN->BVN_DADEXP,;  //7
				BVN->BVN_CODTAB,;  //8
				BVN->BVN_BLCPRE,;  //9
				BVN->BVN_BLCPOS,;  //10
				BVN->BVN_GRPCND,;  //11
				BVN->BVN_CODOPE,;  //12
				BVN->BVN_PROPRI,;  //13
				BVN->BVN_CODGLO,;  //14
				IIf(BVN->( FieldPos("BVN_MSGAUX") ) > 0, BVN->BVN_TAGMSG,""),; //15 BVN->( FieldPos("BVN_VIGINI") ) > 0
				IIf(BVN->( FieldPos("BVN_MSGAUX") ) > 0, BVN->BVN_MSGAUX,"")}}) //16
			EndIf
		EndIf
	Next

Return aCrit

/*/{Protheus.doc} U_CBVARTISS
Cria as variáveis de acordo com o array unico criado pela função U_CDADOUNIC
@type Function
@author Bruno Iserhardt
@since 14/08/13
/*/
user function CBVARTISS(aDadosUnic,cTissVer,cCamTag,aVars,aRet,aMacros,aManBVP)
	Local lOk 			:= .T.
	Local cNomVar		:= ""
	Local cExpressao	:= ""
	Local cExpMontad	:= ""
	Local aVarsCri	:= {} //array de variáveis que foram criadas/alteradas
	Local nPos,nI		:= 0
	Local aBkpErr		:= {}
	PRIVATE aErrVarVin := {.F., "", "", ""}
	PRIVATE cCamTagGen := cCamTag // FOI NECESSARIA a criacao dessa variavel (SE NAO FOR PRIVATE A MACRO NAO ENXERGA) para que a estrutura dinamica fosse possivel validar corretamente nos niveis corretos do XML
	Default cCamTag 	:= ""
	Default aVars	:= {}
	Default aManBVP	:= {} // [1] Nome da Variavel, [2] Expressao [3] Dado Seek [4] Alias Seek [5] Indice Seek [6] tem dependencia .T. OU .F. [7] VALOR ANTERIOR - se tem dependencia qual Valor anterior para nao executar desnecessariamente

	// Criação das variáveis - BVP
	If aManBVP <> Nil .AND. Len(aManBVP) > 0// Se foi passado o array por parametro eh porque ja tem as configuracoes e nao precisa acessar a base

		For nI := 1 To Len(aManBVP) // Faco a mesma soh que fora do Alias BVP e com os controles do Array
			//se o cCamTag estiver vazio então deve fazer para todas as variáveis
			//caso contrário deve criar somente as variáveis que utilizam a tag enviada em suas expressões
			//ou também deve recriar a variável caso ela tenha sido enviada do array aVars
			If ((Empty(AllTrim(cCamTag)) .And. Len(aVars) <= 0) .OR. ;
			U_CTAGINEXP(cCamTag, aManBVP[nI][3]) .OR. ;
			U_CTAGINEXP(cCamTag, aManBVP[nI][2]) .OR. ;
			(Len(aVars) > 0 .And. aScan(aVars, {|x| x $ aManBVP[nI][3] .Or. x $ aManBVP[nI][2]}) > 0))

				cNomVar := AllTrim(aManBVP[nI][1])

				//se tem algum alias cadastrado realiza o Seek no mesmo
				If (!Empty(AllTrim(aManBVP[nI][4])))
					cAlias := aManBVP[nI][4]
					//seta o alias cadastrado
					&(cAlias)->(DbSelectArea(cAlias))
					//seta o indice cadastrado
					&(cAlias)->(DbSetOrder(aManBVP[nI][5]))

					//expressão informada
					cExpressao := AllTrim(aManBVP[nI][3])
					//chama a função u_C973MONEXP para substituir as tags necessárias caso haja alguma na expressão
					cExpMontad := u_C973MONEXP(aManBVP[nI][3], aDadosUnic)
					//realiza o seek
					&(cAlias)->(MsSeek(&(cExpMontad)))
				ElseIf (!Empty(AllTrim(aManBVP[nI][3])))
					//expressão informada
					cExpressao := AllTrim(aManBVP[nI][3])
					//chama a função u_C973MONEXP para substituir as tags necessárias caso haja alguma na expressão
					cExpMontad := u_C973MONEXP(aManBVP[nI][3], aDadosUnic)
					//executa a expressão
					&(cExpMontad)
				EndIf

				//expressão informada
				cExpressao := AllTrim(aManBVP[nI][2])
				//chama a função u_C973MONEXP para substituir as tags necessárias caso haja alguma na expressão
				cExpMontad := u_C973MONEXP(cExpressao, aDadosUnic)
				//realiza a criação da variável
				If aMacros <> nil
					aadd(aMacros,{cNomVar,cExpMontad})
				Else

					If Type(cNomVar) <> "U"
						&(cNomVar) :=  &(cExpMontad)
					Else
						_SetOwnerPrvt(cNomVar, &(cExpMontad))
					EndIf

					If Type("aVarsAux") <> "U"
						If (nPos := aScan(aVarsAux, {|x| Upper(x[2]) == Upper(cNomVar)} )) > 0
							&(aVarsAux[nPos,1] + "3X") := &(cNomVar)
						EndIf
					EndIf

					//verifica se ocorreu erro na função U_CBVARVINC aqui pois não foi possível passar o aRet para a mesma
					If (aErrVarVin[1])

						//reinicia o vetor que indica que deu erro na U_CBVARVINC
						aErrVarVin[1] := .F.

						//indica que ocorreu erro na criação das variáveis
						lOk := .F.

						//Adiciona a crítica no array de erros
						if plsvldex(aRet[3],"Dado enviado: "+AllTrim(aErrVarVin[3])) //.and. plsvldex(aRet[3],"Tabela Terminologia TISS: "+AllTrim(aErrVarVin[2]))
							aRet[1] := .T.
							aAdd(aRet[3],"** [ ERRO DE CONFIGURACAO ] **")
							aAdd(aRet[3],"Dado enviado no arquivo nao possui vinculo (De-Para)")
							aAdd(aRet[3],"Dado enviado: "+AllTrim(aErrVarVin[3]))
							aAdd(aRet[3],"Tabela Terminologia TISS: "+AllTrim(aErrVarVin[2]))
							If !Empty(AllTrim(aErrVarVin[4]))
								aAdd(aRet[3],"Tabela PLS : "+AllTrim(aErrVarVin[4]) + "-" + AllTrim(Posicione("SX2",1,AllTrim(aErrVarVin[4]),"SX2->X2_NOME")) )
							EndIf
							aAdd(aRet[3],"")
						endIf

					EndIf

				Endif
				//adiciona a variável que foi criada/alterada para poder recriar as variáveis que a utiliza na composição do seu valor
				//somente se não for pra criar todas as variávels (AQUI EU OLHO SE TEM DEPENDENCIA E SE O VALOR ANTERIOR NAO EH IGUAL AO NOVO)
				If ((!Empty(cCamTag) .Or. Len(aVars) > 0) .AND. lOk .AND. aManBVP[nI][6] .AND. (&(cNomVar) <> aManBVP[nI][7]))

					aManBVP[nI][7] := &(cNomVar) // ATUALIZO O VALOR ATUAL DA VARIAVEL

					aAdd(aVarsCri, cNomVar)

				EndIf
			EndIf
		Next nI
	Else // Caso nao tenha o Bckup ainda da BVP e passou o Array vazio ele sera alimentado para as proximas
		// Criação das variáveis - BVP
		//Posiciona a tabela das variáveis
		lCriaBVP := (aManBVP <> Nil .AND. Len(aManBVP) == 0) // retirado do While pois nao estava olhando todas as criticas

		DbSelectArea("BVP")
		BVP->(DbSetOrder(1)) //BVP_FILIAL+BVP_TISVER
		//Verifica se encontrou alguma variável para a versão TISS
		If(BVP->(MsSeek(xFilial("BVP")+cTissVer)))

			//Percorre a tabela para criar as variáveis
			While (!BVP->(Eof()) .And. BVP->(BVP_FILIAL+BVP_TISVER) == xFilial("BVP")+cTissVer)

				If lCriaBVP
					//[1] Nome da Variavel, [2] Expressao [3] Dado Seek [4] Alias Seek [5] Indice Seek [6] tem dependencia .T. OU .F. [7] VALOR ANTERIOR
					AADD(aManBVP, {BVP->BVP_NOMVAR,BVP->BVP_VLREXP,BVP->BVP_DADSEK,BVP->BVP_ALIAS,BVP->BVP_INDICE,.F.,Nil})
				EndIf
				//se o cCamTag estiver vazio então deve fazer para todas as variáveis
				//caso contrário deve criar somente as variáveis que utilizam a tag enviada em suas expressões
				//ou também deve recriar a variável caso ela tenha sido enviada do array aVars
				If ((Empty(AllTrim(cCamTag)) .And. Len(aVars) <= 0) .OR. ;
				U_CTAGINEXP(cCamTag, BVP->BVP_DADSEK) .OR. ;
				U_CTAGINEXP(cCamTag, BVP->BVP_VLREXP) .OR. ;
				(Len(aVars) > 0 .And. aScan(aVars, {|x| x $ BVP->BVP_DADSEK .Or. x $ BVP->BVP_VLREXP}) > 0))

					cNomVar := AllTrim(BVP->BVP_NOMVAR)

					//se tem algum alias cadastrado realiza o Seek no mesmo
					If (!Empty(AllTrim(BVP->BVP_ALIAS)))
						cAlias := BVP->BVP_ALIAS
						//seta o alias cadastrado
						&(cAlias)->(DbSelectArea(cAlias))
						//seta o indice cadastrado
						&(cAlias)->(DbSetOrder(BVP->BVP_INDICE))

						//expressão informada
						cExpressao := AllTrim(BVP->BVP_DADSEK)
						//chama a função u_C973MONEXP para substituir as tags necessárias caso haja alguma na expressão
						cExpMontad := u_C973MONEXP(BVP->BVP_DADSEK, aDadosUnic)
						//realiza o seek
						&(cAlias)->(MsSeek(&(cExpMontad)))
					ElseIf (!Empty(AllTrim(BVP->BVP_DADSEK)))
						//expressão informada
						cExpressao := AllTrim(BVP->BVP_DADSEK)
						//chama a função u_C973MONEXP para substituir as tags necessárias caso haja alguma na expressão
						cExpMontad := u_C973MONEXP(BVP->BVP_DADSEK, aDadosUnic)
						//executa a expressão
						&(cExpMontad)
					EndIf

					//expressão informada
					cExpressao := AllTrim(BVP->BVP_VLREXP)
					//chama a função u_C973MONEXP para substituir as tags necessárias caso haja alguma na expressão
					cExpMontad := u_C973MONEXP(cExpressao, aDadosUnic)
					//realiza a criação da variável
					If aMacros <> nil
						aadd(aMacros,{cNomVar,cExpMontad})
					Else
						If Type(cNomVar) <> "U"
							&(cNomVar) :=  &(cExpMontad)
						Else
							_SetOwnerPrvt(cNomVar, &(cExpMontad))
						EndIf

						If Type("aVarsAux") <> "U"
							If (nPos := aScan(aVarsAux, {|x| Upper(x[2]) == Upper(cNomVar)} )) > 0
								&(aVarsAux[nPos,1] + "3X") := &(cNomVar)
							EndIf
						EndIf

						//verifica se ocorreu erro na função U_CBVARVINC aqui pois não foi possível passar o aRet para a mesma
						If (aErrVarVin[1])
							//reinicia o vetor que indica que deu erro na U_CBVARVINC
							aErrVarVin[1] := .F.
							//indica que ocorreu erro na criação das variáveis
							lOk := .F.
							//Adiciona a crítica no array de erros
							if plsvldex(aRet[3],"Dado enviado: "+AllTrim(aErrVarVin[3])) //.and. plsvldex(aRet[3],"Tabela Terminologia TISS: "+AllTrim(aErrVarVin[2]))
								aRet[1] := .T.
								aAdd(aRet[3],"** [ ERRO DE CONFIGURACAO ] **")
								aAdd(aRet[3],"Dado enviado no arquivo nao possui vinculo (De-Para)")
								aAdd(aRet[3],"Dado enviado: "+AllTrim(aErrVarVin[3]))
								aAdd(aRet[3],"Tabela Terminologia TISS: "+AllTrim(aErrVarVin[2]))
								If !Empty(AllTrim(aErrVarVin[4]))
									aAdd(aRet[3],"Tabela PLS : "+AllTrim(aErrVarVin[4]) + "-" + AllTrim(Posicione("SX2",1,AllTrim(aErrVarVin[4]),"SX2->X2_NOME")) )
								EndIf
								aAdd(aRet[3],"")
							endIf
						EndIf

					Endif
					//adiciona a variável que foi criada/alterada para poder recriar as variáveis que a utiliza na composição do seu valor
					//somente se não for pra criar todas as variávels
					If ((!Empty(cCamTag) .Or. Len(aVars) > 0) .AND. lOk)
						aAdd(aVarsCri, cNomVar)
					EndIf
				EndIf
				//próximo registro
				BVP->(DbSkip())
			EndDo
		EndIf
	Endif
	//se estiver variáveis que foram alteradas
	If (Len(aVarsCri) > 0 .AND. lOk)
		//chama novamente a função para verificar se alguma outra variável utiliza o valor das variáveis alteradas para serem recriadas
		lOk := U_CBVARTISS(aDadosUnic, cTissVer, "", aVarsCri, @aRet,@aMacros,aManBVP)
	EndIf

Return lOk


/*/{Protheus.doc} plsvldex
Verifica se a critica esta repetida
@type Function
@author PLS
/*/
static function plsvldex(aRet,cConteudo)
	local lRet := ( aScan( aRet,{ |x| x = cConteudo } ) == 0 )

return lRet

/*/{Protheus.doc} pExecMacro
@type Function
@author PLS
/*/
static function pExecMacro(aMacros,aRet,cCamTag)
	LOCAL aArray 			:= {}
	LOCAL nI	 			:= 1
	LOCAL cNomVar			:= ""
	LOCAL cExpMontad		:= ""
	PRIVATE aErrVarVin 	:= {.F., "", "", ""}
	PRIVATE cCamTagGen 	:= cCamTag // FOI NECESSARIA a criacao dessa variavel (SE NAO FOR PRIVATE A MACRO NAO ENXERGA) para que a estrutura dinamica fosse possivel validar corretamente nos niveis corretos do XML

	For nI:=1 to Len(aMacros)
		if aScan(aArray,{|x| x[1] == aMacros[nI][1] .and. x[2] == aMacros[nI][2] }) == 0
			aadd(aArray,aMacros[nI])
		Endif
	Next

	For nI:=1 to Len(aArray)
		cNomVar 	:= aArray[nI][1]
		cExpMontad	:= aArray[nI][2]

		If Type(cNomVar) <> "U"
			&(cNomVar) :=  &(cExpMontad)
		Else
			_SetOwnerPrvt(cNomVar, &(cExpMontad))
		EndIf

		If Type("aVarsAux") <> "U"
			If (nPos := aScan(aVarsAux, {|x| Upper(x[2]) == Upper(cNomVar)} )) > 0
				&(aVarsAux[nPos,1] + "3X") := &(cNomVar)
			EndIf
		EndIf

		//verifica se ocorreu erro na função U_CBVARVINC aqui pois não foi possível passar o aRet para a mesma
		If (aErrVarVin[1])
			//reinicia o vetor que indica que deu erro na U_CBVARVINC
			aErrVarVin[1] := .F.

			//indica que ocorreu erro na criação das variáveis
			lOk := .F.

			//Adiciona a crítica no array de erros
			if plsvldex(aRet[3],"Dado enviado: "+AllTrim(aErrVarVin[3])) //.and. plsvldex(aRet[3],"Tabela Terminologia TISS: "+AllTrim(aErrVarVin[2]))
				// esse item foi retirado devido estar apresentando somente a primeira critica
				aRet[1] := .T.

				aAdd(aRet[3],"** [ ERRO DE CONFIGURACAO ] **")
				aAdd(aRet[3],"Dado enviado no arquivo nao possui vinculo (De-Para)")
				aAdd(aRet[3],"Dado enviado: "+AllTrim(aErrVarVin[3]))
				aAdd(aRet[3],"Tabela Terminologia TISS: "+AllTrim(aErrVarVin[2]))

				If !Empty(AllTrim(aErrVarVin[4]))
					aAdd(aRet[3],"Tabela PLS : "+AllTrim(aErrVarVin[4]) + "-" + AllTrim(Posicione("SX2",1,AllTrim(aErrVarVin[4]),"SX2->X2_NOME")) )
				EndIf

				aAdd(aRet[3],"")
			endIf

		EndIf
	Next

return

/*/{Protheus.doc} U_CBVARVINC
Retorna o valor do PLS para um item de uma terminologia.
Utilizada somente para a função U_CBVARTISS
@type Function
@author Bruno Iserhardt
@since 09/09/13
/*/
USER function CBVARVINC(cCodTab, cAlias, cCdTerm,cDireto, cTagCrit, aTabDup,cAtuTab)
	Local cVlrBus 		:= ""
	Local lCrit			:= .F.
	Local nCT 			:= 0
	Default cAlias 		:= ""
	Default cDireto 		:= "" // Variavel passada no cadastro de variaveis BVP para informar o conteudo do seek para buscar diretamente no alias caso nao encontre o de-para
	Default cTagCrit		:= "" // Variavel que informa a tag que a somente quando estiver validando a mesma o sistema ira criticar (para o caso de criticas de de-para com valores inconsistencias, o sistema estava criticando sem estar atualizado o valor da variavel correta)
	Default aTabDup 		:= {}

	If Type("aErrVarVin") == 'U'
		Private aErrVarVin := {.F., "", "", ""}
	EndIf

	BTU->(DbSelectArea("BTU"))

	If !Empty(cAlias)

		BTP->(DbSetOrder(1))
		BTP->(MsSeek(xFilial("BTP")+cCodTab))

		BTU->(DbSetOrder(3)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_CDTERM
		If (BTU->(MsSeek(xFilial("BTU")+cCodTab+cAlias+padr(cCdTerm, tamsx3("BTU_CDTERM")[1]))))
			cVlrBus 		:= BTU->BTU_VLRBUS
			aErrVarVin[1] := .F.
		Else
			If !Empty(aTabDup) // estrutura para que seja possivel verificar duas tabelas padroes vinculadas a uma unica terminologia

				For nCT := 1 to Len(aTabDup)

					If Alltrim(aTabDup[nCt,1]) == cCodTab

						//implementei a regra de busca direto aqui tambem - daher (under validation)

						If BTP->(FieldPos("BTP_BUSDIR")) > 0 .and. BTP->BTP_BUSDIR == '1'

							nIndUt := PLSBUIND(cAlias,(cAlias+"_FILIAL+")+alltrim(BTP->BTP_CHVTAB))

							If nIndUt > 0 .and. !Empty(cDireto)

								nSlvOrd := &(cAlias+"->(IndexOrd())")   //tenho que salvar o indice pois ele nao pode despoicionar uma tabela que esta la fora por exemplo

								&(cAlias+"->(DbSetOrder("+alltrim(str(nIndUt))+"))")

								If &(cAlias+"->(MsSeek('"+xFilial(cAlias)+Alltrim(aTabDup[nCT,2]+Substr(cDireto,3,Len(cDireto)))+"'))")

									cVlrBus 		:= cCdTerm
									cAtuTab 		:= aTabDup[nCT,2] //alimento o aTabDup encontrado para ser usado fora desta funcao, por exemplo
									aErrVarVin[1] := .F.

									&(cAlias+"->(DbSetOrder("+alltrim(str(nSlvOrd))+"))")

									Return cVlrBus
								Else
									lCrit := .T.
								Endif

								&(cAlias+"->(DbSetOrder("+alltrim(str(nSlvOrd))+"))")
							Else
								lCrit := .T.
							Endif

					Else
						BTU->(DbSetOrder(3)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_CDTERM

						If BTU->(MsSeek(xFilial("BTU") + Substr(cCodTab, 1, TamSX3("BTU_CODTAB")[1]) + cAlias + cCdTerm))
						    (cAlias)->(DbSetOrder(1))
						    If (cAlias)->( MsSeek( Rtrim(BTU->BTU_VLRSIS)) )
						       
						        cVlrBus  := BTU->BTU_VLRBUS
						        lCrit   := .F.
						
						        Return cVlrBus
						       
						    Endif
					    EndIf

						/*BTU->(DbSetOrder(2)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_VLRSIS

							If (BTU->(MsSeek(xFilial("BTU")+cCodTab+cAlias+padr(Alltrim(aTabDup[nCT,2]+Substr(cCdTerm,3,Len(cCdTerm))), tamsx3("BTU_CDTERM")[1]))))

								cVlrBus 	:= BTU->BTU_VLRBUS
								lCrit 		:= .F.

							Return cVlrBus
						EndIf*/

						Endif

					EndIf

					lCrit := .T. // Se nao achou nenhuma ai critica

				Next nCT

			ElseIf BTP->(FieldPos("BTP_BUSDIR")) > 0 .and. BTP->BTP_BUSDIR == '1'

				nIndUt := PLSBUIND(cAlias,(cAlias+"_FILIAL+")+alltrim(BTP->BTP_CHVTAB))

				If nIndUt > 0 .and. !Empty(cDireto)

					nSlvOrd := &(cAlias+"->(IndexOrd())")   //tenho que salvar o indice pois ele nao pode despoicionar uma tabela que esta la fora por exemplo

					&(cAlias+"->(DbSetOrder("+alltrim(str(nIndUt))+"))")

					If &(cAlias+"->(MsSeek('"+xFilial(cAlias)+cDireto+"'))")
						cVlrBus 		:= cCdTerm
						aErrVarVin[1] := .F.
					Else
						lCrit := .T.
					Endif

					&(cAlias+"->(DbSetOrder("+alltrim(str(nSlvOrd))+"))")

				Else
					lCrit := .T.
				Endif
			Else
				lCrit := .T.
			Endif

		EndIf
	Else
		BTU->(DbSetOrder(5)) //BTU_FILIAL, BTU_CODTAB, BTU_CDTERM, BTU_ALIAS

		If (BTU->(MsSeek(xFilial("BTU")+cCodTab+padr(cCdTerm, tamsx3("BTU_CDTERM")[1]))))
			cVlrBus 		:= BTU->BTU_VLRBUS
			aErrVarVin[1] := .F.
		Else
			lCrit := .T.
		EndIf

	Endif


	If lCrit .AND. !Empty(cTagCrit)
		If Type("cCamTagGen") <> 'U' //.AND. !Empty(cCamTagGen)// VERIFICACAO NECESSARIA PARA CONTINUAR DINAMICO A VALIDACAO EM NIVEIS DO XML, SE NAO FOR PRIVATE A MACRO NAO ENXERGA
			lCrit := ( Upper(Alltrim(cTagCrit)) $ Upper(cCamTagGen))
		EndIf
	EndIf

	If lCrit
		// Ponto de entrada para manipular a tabela de-para há cliente que importa e dentro do sistema analisa
		If ExistBlock("PLIMPTDO")
			aErrVarVin := ExecBlock("PLIMPTDO",.F.,.F.,{aErrVarVin,cCodTab, cAlias, cCdTerm} )
			If Empty (cVlrBus) .And. aErrVarVin[1] .And. Len(aErrVarVin[4])>=1
				cVlrBus    := aErrVarVin[4]
			Else
				cVlrBus    := cCdTerm
			EndIf

		Else
			aErrVarVin[1] := .T.
			aErrVarVin[2] := cCodTab
			aErrVarVin[3] := cCdTerm
			aErrVarVin[4] := cAlias
			cVlrBus 		:= cCdTerm
		Endif
	EndIf


	If ExistBlock("PLCODPAD")
		cVlrBus := ExecBlock("PLCODPAD",.F.,.F.,{cCodTab, cAlias, cCdTerm,cDireto, cTagCrit, aTabDup,cAtuTab,cVlrBus} )
	Endif

Return cVlrBus

/*/{Protheus.doc} CTAGINEXP
Verifica se a tag está sendo utilizada em uma expressão
@type Function
@author Bruno Iserhardt
@since 14/08/13
/*/
user function CTAGINEXP(cCamTag, cExpressao)
	Local lRet := .F.
	Local nI := 1
	Local nI2 := 1
	Local nIndex := 0
	Local nBegin := 0
	Local nEnd := 0
	Local cPathTag := ""
	Local aPathTag := {}

	//loop para varrer todas as tags da expressão
	For nI := 1 To Len(StrTokArr ( cExpressao, "[%" ))-1
		//seleciona os indices do inicio e fim da tag
		nBegin := At("[%",cExpressao)
		nEnd := At("%]",cExpressao)
		//seleciona na expressão o caminho e a tag
		cPathTag := SubStr(cExpressao, nBegin+2, nEnd-nBegin-2)
		//cria um array de todos os caminhos existentes na expressão
		aPathTag := StrTokarr(cPathTag, ",")

		//verifica se está contida pois na expressão pode estar somente uma parte do caminho da tag
		//Ex.: a tag no xml é \MENSAGEMTISS\PRESTADORPARAOPERADORA\LOTEGUIAS\GUIASTISS\GUIACONSULTA\CABECALHOCONSULTA\REGISTROANS
		//porém o cPathTag pode ter somente parte do caminho \CABECALHOCONSULTA\REGISTROANS
		If (aScan(aPathTag, {|x| x $ cCamTag} ) > 0)
			lRet := .T.
			EXIT
		EndIF
		//remove a tag da expressão
		cExpressao := StrTran(cExpressao, "[%" + cPathTag + "%]", "")
	Next
Return lRet

/*/{Protheus.doc} U_CEXECEXP
Executa a expressão enviada utilizando Macro Substituição.
@type Function
@author PLS
@since 13/08/13
/*/
user function CEXECEXP(cExpressao, cCodGlo, cDescriGlo, cCdItem, aDadosUnic, aRet)
	Local aReturn		:= {.T., .T.}
	Local cExpMontad	:= ""
	Local oError		:= ErrorBlock({|e| U_C973ADDER(cCodGlo, cDescriGlo, cExpressao, cExpMontad, cCdItem, e:Description, @aRet),aReturn[1] := .F. })
	//expressão da validação
	cExpressao := AllTrim(cExpressao)
	//monta a expressão substituindo os valores das tag do XMl
	cExpMontad := u_C973MONEXP(cExpressao, aDadosUnic)
	//Tratamento realizado para um possivel erro na expressão
	Begin Sequence
		//Se a expressão retornou false, inclui a crítica no array de erros
		aReturn[2] := &(cExpMontad)
	End Sequence
	ErrorBlock(oError)
Return aReturn

/*/{Protheus.doc} U_C973ADDER
Adiciona um erro ocorrido no array enviado
@type Function
@author PLS
@since 23/07/13
/*/
User function C973ADDER(cCodGlo, cDescriGlo, cExpressao, cExpMontad, cCdItem, cErrorDesc, aRet)
	aRet[1] := .T.
	aAdd(aRet[3], "** [ ERRO NA EXPRESSAO ] **")
	aAdd(aRet[3], "Falha na execucao da expressao da critica " + cCodGlo + "-" + cDescriGlo)
	aAdd(aRet[3], "Item: " + cCdItem)
	aAdd(aRet[3], "Expressao cadastrada: " + cExpressao)
	aAdd(aRet[3], "Expressao executada: " + cExpMontad)
	aAdd(aRet[3], "Erro: " + cErrorDesc)
	aAdd(aRet[3], "")
Return

/*/{Protheus.doc} CDADOUNIC
Monta o aDadosUnic com base no aDados

@type Function
@author Bruno Iserhardt
@since 14/08/2013
@version 1.0
@param aDados, Array, Array com todos os dados do XML em validação
@return aUnic, Array, Réplica do aDados sem a repetição de TAGS
/*/
User Function CDADOUNIC(aDados)
	Local aUnic 		:= {}
	Local nIndex		:= 0
	Local nI 			:= 1
	Local cTagExc		:= "CBOS/CBO/"
	Default aDados	:= {}

	For nI := 1 To Len(aDados)
		//Verifica se a TAG ja foi replicada para o aDadosUnic.
		If !(aDados[nI, 1] $ cTagExc)
			nIndex := aScan(aUnic, {|x|Upper(x[1]			) == aDados[nI, 1]})
		Else
			//Somente as TAGs definidas na variavel 'cTagExc' deve trazer mais de uma ocorrencia
			//sendo assim o caminho deve ser validado
			nIndex := aScan(aUnic, {|x|Upper(x[2] + x[1]	) == aDados[nI, 2] + aDados[nI,1]})
		EndIf

		//Caso nao encontre
		If (nIndex <= 0)
			//Adiciona a TAG e insere um posicao com um FLAG informando que existe apenas uma ocorrencia
			aAdd(aUnic,aClone(aDados[nI]))
			aAdd(aUnic[Len(aUnic)], .F.)
		Else
			//Caso entre nessa condicao, significa que a TAG foi espelhada no bloco acima,
			//e abaixo o FLAG muda o STATUS para indicar que encontrou uma nova ocorrencia.
			aUnic[nIndex, 4] := .T.
		EndIF
	Next
Return aUnic

/*/{Protheus.doc} U_CBDADCRM
Caso exista RDAs com o mesmo código Profissional saude
@type Function
@author PLS
@since 14/08/13
/*/
user function CBDADCRM(aDados)
	Local aCrm 	:= {}
	Local nIndex	:=  aScan(aDados,{|x| alltrim(x[1]) == "NUMEROCONSELHOPROFISSIONAL"  })
	Local nI 		:= 1
	Default aDados := {}

	If (nIndex > 0)
		nI := nIndex
		aAdd(aCrm, aClone(aDados[nI]))
	EndIF

	For nI := nI+1 To Len(aDados)
		nPos3 := aScan( aCrm,{|x|Upper(x[1])== aDados[nI, 1]} )
		If nPos3 > 0
			aAdd(aCrm, aClone(aDados[nI]))
		EndIf
	Next
Return aCrm

/*/{Protheus.doc} U_CBTPGUIA
Retorna o tipo de guia do XML entre os tipos enviados.
@type Function
@author Bruno Iserhardt
@since 19/08/13
/*/
user function CBTPGUIA(cTpGuias, aDadosUnic)
	Local cRet		:= ""
	Local nI		:= 0
	Local nIndex	:= 0
	Local aTpGuias	:= StrTokarr(strTran(cTpGuias,"'",''), ",")

	If (Len(aTpGuias) > 0)
		For nI := 1 To Len(aTpGuias)
			If (aScan(aDadosUnic,{|x| aTpGuias[nI] $ AllTrim(x[2]) }) > 0)
				cRet := aTpGuias[nI]
				EXIT
			EndIf
		Next
	EndIf
Return cRet

/*/{Protheus.doc} U_CQTDPRE
Função utilizada pela crítica X28
@type Function
@author Bruno Iserhardt
@since 13/09/13
/*/
User function CQTDPRE()
	Local cNumGuia	:= ""
	Local nQtdPre	:= 0
	LOCAL nRecBEA	:= BEA->(Recno())
	LOCAL nOrdBEA	:= BEA->(IndexOrd())

	//o prestador pode mandar no campo senha tanto o nro do prothus 0001.2015.04.xxxx quando o BEA_SENHA
	BEA->(dbSetOrder(14))
	If !BEA->( MsSeek(xFilial("BEA")+padr(alltrim(cNumSen),9)) )
		BEA->(dbSetOrder(1))
		If !BEA->( MsSeek(xFilial("BEA")+padr(alltrim(cNumSen),18)) )
			BEA->(DbSetORder(nOrdBEA))
			BEA->(DbGoto(nRecBEA))
			Return nQtdPre
		Endif
	Endif

	cNumGuia:= BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)
	nQtdPre	 := 0
	BE2->(DbSetOrder(6))//BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+BE2_CODPAD+BE2_CODPRO
	If BE2->(MsSeek(xFilial("BE2")+cNumGuia+Alltrim(cCodPad+cCodPro)))

		nRecBE2 := 0
		while !BE2->(Eof()) .and.  BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+alltrim(BE2_CODPAD+BE2_CODPRO)) == xFilial("BE2")+cNumGuia+Alltrim(cCodPad+cCodPro)
			nQtdPre += BE2->BE2_SALDO
			nRecBE2 := BE2->(Recno())
			BE2->(DbSkip())
		Enddo
	EndIF

	If nRecBE2 > 0
		BE2->(DbGoTo(nRecBE2))
	Endif

	BEA->(DbSetORder(nOrdBEA))
	BEA->(DbGoto(nRecBEA))

Return nQtdPre

/*/{Protheus.doc} U_cCHKVIGOPE
Função utilizada pela crítica 09G
@type Function
@author Bruno Iserhardt
@since 19/08/13
/*/
user function cCHKVIGOPE()
	Local lCri := .F.
	If BAW->( FieldPos("BAW_VIGINI") ) > 0 .And. BAW->( FieldPos("BAW_VIGFIN") ) > 0
		If BAW->(MsSeek(xFilial("BAW")+cRdaOri+cOpeMov))
			While BAW->BAW_CODIGO ==  cRdaOri .And. BAW->BAW_CODINT == cOpeMov
				If BAW->BAW_VIGINI <> CTOD(" / / ") .And. BAW->BAW_VIGINI <= dDataBase .And.;
				(BAW->BAW_VIGFIN == CTOD(" / / ") .Or. BAW->BAW_VIGFIN >= dDataBase)
					lCri := .T.
				EndIf
				BAW->(dbSkip())
			EndDo
		Endif
	Endif
Return lCri

/*/{Protheus.doc} U_cbEXECDAD
Retorna cnpj, cpf ou codigoNaOperadora do executante.
@type Function
@author Bruno Iserhardt
@since 19/08/13
/*/
user function cbEXECDAD()
	Local cRet := u_CVLRTAGXML(aDadosUnic, "\contratadoExecutante\cpfContratado,\contratadoExecutante\cnpjContratado,\contratadoExecutante\codigoPrestadorNaOperadora,\dadosContratadoExecutante\codigonaOperadora")

	If 	(Empty(AllTrim(cRet)))
		cRet := cRdaOri
	EndIf

	If (Len(Alltrim(cRet)) != 11 .AND. Len(Alltrim(cRet)) != 14)
		cRet := padr(cRet, 6)
	Else
		cRet := u_CRDARight(cRet)
	EndIf

Return cRet

/*/{Protheus.doc} cAJUSTRDA
Ajusta o conteúdo da variável cRdaOri.
@type Function
@author Bruno Iserhardt
@since 10/09/13
/*/
user function cAJUSTRDA(cRda)

	If (Len(Alltrim(cRda)) != 14 .AND. Len(Alltrim(cRda)) != 11)
		cRda := padR(cRda, 6)
	Else
		cRda := u_CRDARight(cRda)
	EndIf

Return cRda

/*/{Protheus.doc} cVLDCHSH
Retorna o Hash do arquivo XML que está sendo validado.
@type Function
@author PLS
@since 29/08/13
/*/
user function cVLDCHSH()
	Local cContHash  := ""

	//insere todo o conteúdo do xml na variável cContHash, exceto o conteúdo do próprio hash
	//aqui NÃO pode ser utilizado o aDadosUnic porque deve utilizar TODOS os valores de TODAS as tags do XML
	If  GetNewPar("MV_PLTHRE",.F.) .AND.  IsInCallStack("PLSXMLBATCH") // Roda processo de submissão em theard.
		aScan(aDadosThd, {|x| If (x[1] != "HASH" .AND. !("nSeqGui" $ x[3]),cContHash += x[3], Nil) })
	Else
		aScan(aDados   , {|x| If (x[1] != "HASH" .AND. !("nSeqGui" $ x[3]),cContHash += x[3], Nil) })
	Endif

	//calcula o hash dos dados do xml e retorna o mesmo
Return Upper( MD5(cContHash,2) )

/*/{Protheus.doc} PLVLDCHSH2
Valida o Hash do arquivo XML se esta correto
@type Function
@author PLS
@since 13/08/13
/*/
/*
user function cVLDCHSH2(cHasValid)

	Local 	cContHash	:= ""
	Local   lRet		:=.T.
	Default cHasValid	:= ""


	//insere todo o conteúdo do xml na variável cContHash, exceto o conteúdo do próprio hash
	//aqui NÃO pode ser utilizado o aDadosUnic porque deve utilizar TODOS os valores de TODAS as tags do XML
	If  GetNewPar("MV_PLTHRE",.F.) .AND.  IsInCallStack("PLSXMLBATCH") // Roda processo de submissão em theard.
		aScan(aDadosThd, {|x| If (x[1] != "HASH" .AND. !("nSeqGui" $ x[3]),cContHash += x[3], Nil) })
		If GetGlbValue("X15CONT") == "0"
			PutGlbValue("X15CONT","1")
			//calcula o hash dos dados do xml e retorna o mesmo
			lRet:= Upper(cHasValid) ==Upper( MD5(cContHash,2) )
		Else
			lRet:= .T.
		Endif

	Else
		If IsInCallStack("PLRRJOB")
			aScan(aDadosGer   , {|x| If (x[1] != "HASH" .AND. !("nSeqGui" $ x[3]),cContHash += x[3], Nil) })
		Else
			aScan(aDados   	, {|x| If (x[1] != "HASH" .AND. !("nSeqGui" $ x[3]),cContHash += x[3], Nil) })
		Endif

		//calcula o hash dos dados do xml e retorna o mesmo
		lRet:= Upper(cHasValid) ==Upper( MD5(cContHash,2) )

	Endif

Return lRet
*/

/*/{Protheus.doc} CXMLTOARR
Converte um xml em um array utilizando metodo de recursividade
@type Function
@author PLS
@since 23/07/13
/*/
user function CXMLTOARR(aXML, cPath, cTag, aDados)
	Local nI			:= 0
	Local nC			:= 0
	Local cNextPath
	Local cPref1		:= "_ANS_"
	Local cPref2		:= "_ANSTISS_"
	Local cPref3		:= "ANS:"
	Local cPref4		:= "ANSTISS:"
	Local cPref5		:= "_"
	Local cTpGuias		:= ""
	Local nForDin		:= 0
	Local aBkpXml		:= {}
	Local cVarAux		:= ""
	DEFAULT aDados	:= {}
	DEFAULT cPath		:= ""
	DEFAULT cTag		:= ""

	If Type("nSeqGui") == 'U'
		Private nSeqGui := 0
	EndIf

	//NAO RETIRAR ISSO DAQUI EM NENHUMA HIPOTESE - INICIO (estava ocorrendo sobrecarga de memoria com a recursividade usando o vetor)
	aBkpXml := aClone(aXML)
	aSize(aXml,0)
	aXml := Nil
	aXml := aClone(aBkpXml)
	aBkpXml := nil
	//NAO RETIRAR ISSO DAQUI EM NENHUMA HIPOTESE - FIM

	// Tipos de Guias Prestador para Operadora TISS
	cTpGuias :=	u_C973TpGui()

	If (Empty(AllTrim(cTag)))
		cNextPath := cPath
	ElseIf (Empty(AllTrim(cPath)))
		cNextPath := cTag
	Else
		cNextPath := cPath + "\" + cTag
	EndIF

	If (ValType(aXML) == "A")
		// Aqui eu separo as guias pois pode haver mais de uma de acordo com o seu tipo, esse controle agrupara cada guia para ser importada separada no PLSA973
		If Len(aXML) > 3 .AND. Len(aXML[2]) > 1 .AND. Valtype(aXml[2,2]) == "C"
			cVarAux := A973LTran(Upper(aXML[2,2]),Upper(aXML[2,1]),{cPref1,cPref2,cPref3,cPref4,cPref5},cTpGuias)
			If cVarAux $ cTpGuias
				//TRATAMENTO PARA QUE NÃO PASE POR ESSE PONTO QUANDO HOUVER NO XML A TAG ansTISSguias, pois se passar por esse TAG O ALTERA A QTD DE GUIAS, FICANDO ERRADO
				If aXml[2,2] <> "ansTISS:guias"
					nSeqGui++
					aAdd(aDados, {cVarAux, "\"+cPath+"\", "nSeqGui="+AllTrim(str(nSeqGui))})
				EndIf
			EndIf
		EndIf
		nForDin := IIf(Len(aXML) > 3, 4, 1)
		For nI := nForDin To Len(aXML)
			If (ValType(aXML[nI]) == "A")
				If (ValType(aXML[nI, 1]) == "C")  // aXML[nI, 1] = Nome da TAG
					If (ValType(aXML[nI, 2]) == "O")
						//ordena o array na terceira posição que é onde fica a ondem dos elementos após transformar o objeto em um array
						cVarAux := A973LTran(Upper(aXML[nI,1]),"",{cPref1,cPref2,cPref5},cTpGuias)
						aDados := U_CXMLTOARR(ASORT(classDataArr(aXML[nI, 2]),,,{|x,y| x[3]<y[3]}), cNextPath, cVarAux, aDados)
					ElseIf (ValType(aXML[nI, 2]) == "A")
						//cai aqui quando chega na parte dos dados da guia própriamente dita(prestadorParaOperadora)
						For nC := 1 To Len(aXML[nI, 2])
							If (ValType(aXML[nI, 2, nC]) == "O")
								//ordena o array na terceira posição que é onde fica a ondem dos elementos após transformar o objeto em um array
								cVarAux := A973LTran(Upper(aXML[nI,1]),"",{cPref1,cPref2,cPref5},cTpGuias)
								aDados := U_CXMLTOARR(ASORT(classDataArr(aXML[nI, 2, nC]),,,{|x,y| x[3]<y[3]}), cNextPath, cVarAux, aDados)
							EndIf
						Next nC
						//o valor sempre estara na terceira posição do array que tem a primeira posição com valor TEXT
					ElseIf (aXML[3, 1] == "TEXT" .AND. aXML[1, 1] == "TYPE" .AND. aXML[1, 2] == "NOD")
						//adiciona a tag
						//no path é inserido uma contra barra antes e depois do path
						aAdd(aDados, {cTag, "\"+cPath+"\", aXML[3, 2]})
						Return aDados
					EndIf
				EndIf
			EndIf
		Next nI
	EndIf
Return aDados

/*/{Protheus.doc} U_cGETTISVER
Retorna a versão da TISS utilizada pela operadora
@type Function
@author Bruno Iserhardt
@since 15/10/13
/*/
user function cGETTISVER()
	Local cTissVer := GetNewPar("MV_TISSVER","2.02.03")

	BA0->(DbSelectArea("BA0"))
	BA0->(DbSetOrder(1))
	If (BA0->(MsSeek(xFilial("BA0")+PLSINTPAD())))
		If (BA0->(FieldPos("BA0_TISVER")) > 0 .AND. BA0->BA0_TISVER >= "3")
			cTissVer := BA0->BA0_TISVER
		EndIf
	EndIf
Return cTissVer

/*/{Protheus.doc} u_CBTAGSEXP
Retorna todas as tags informadas em uma expressao
@type Function
@author Bruno Iserhardt
@since  16/10/13
/*/
user function CBTAGSEXP(cExp)
	Local aTags := {}
	Local nI := 1
	//loop para varrer todas as tags da expressão
	For nI := 1 To Len(StrTokArr ( cExpressao, "[%" ))-1
		//seleciona os indices do inicio e fim da tag
		nBegin := At("[%",cExpressao)
		nEnd := At("%]",cExpressao)
		//seleciona na expressão o caminho e a tag
		cPathTag := SubStr(cExpressao, nBegin+2, nEnd-nBegin-2)
		//adiciona a tag no array de retorno
		aAdd(aTags, cPathTag)
		//remove a tag da expressão
		cExpressao := StrTran(cExpressao, "[%" + cPathTag + "%]", "")
	Next
Return aTags

/*/{Protheus.doc} u_CCOUNTTAG
Recebe um array de tags e retorna a maior quantidade de vezes que uma das TAGS se encontra no XML.
@type Function
@author Bruno Iserhardt
@since 16/10/13
/*/
user function CCOUNTTAG(aTagsExp, aDados)
	Local nI	:= 1
	Local nI2	:= 1
	Local nCount := 0
	Local nCountAux := 0
	//percorre as tags enviadas
	For nI := 1 To Len(aTagsExp)
		//caucula quantas vezes a tag existe no XML
		For nI2 := 1 To Len(aDados)
			If (aTagsExp[nI] $ aDados[nI2, 2]+aDados[nI2, 1])
				nCountAux++
			EndIf
		Next
		If (nCountAux > nCount)
			nCount := nCountAux
		EndIf
	Next
Return nCount

/*/{Protheus.doc} PlChkProc
Tratamento para que os procedimentos que não precisam de autorização não podem apresentar criticas de senhas
@type Function
@author PLS
@since 11/13/13
/*/
Static function PlChkProc(cChave)
	Local lRet		:=.F.
	Local aMatMCpBk	:= {}
	Local aMatProBk := {}
	Local cCodProBk := {}
	Local cCodPadBk := {}

	If Type("aMatMCp") == "A"
		aMatMCpBk	:= aClone(aMatMCp)
		aMatProBk := PLSPCONGR("CODIGO",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCpBk,,.F.,,.T.)
		cCodProBk := aMatProBk[1]
		cCodPadBk := PLSPCONGR("TIPOTABELA",cGuia+"\PROCEDIMENTOSREALIZADOS",aMatMCpBk,,.T.,.F.)
	Else
		If Type("cCodPro") == "C"
			cCodProBk := cCodPro
			cCodPadBk := cCodPad
		EndIf
	EndIf

	BR8->( DbSetOrder(1) )
	BR8->(DbGoTop())

	If BR8->(DbSeek(xFilial("BR8")+cCodPadBk+cCodProBk))
		If BR8->BR8_AUTORI="0"
			lRet:=.T. // Dispensa autorizacao mesmo que a senha nao esteja presente.
		Else
			lRet:=.F. // Autorizacao e necessaria.
		Endif
	Endif

Return lRet

/*/{Protheus.doc} u_CRDARight
Tratamento para atribuir o valor do CodRda mesmo na funçao
de validação dinamica vir CPF OU CNPJ colocar o CODRDA
@type Function
@author Tabosa
@since 11/13/13
/*/
user function CRDARight(cCodRda, cOpeRda)
	Local aArea 	:= GetArea()
	Local cNewRDA	:= cCodRda
	Local cRdaAnt	:= ""


	DEFAULT cOpeRda := ""
	If Empty(cOpeRda)
		cOpeRda := PlsIntPad()
	EndIf

	If Len(alltrim(cNewRDA)) > TamSX3("BAU_CODIGO")[1]//se eh maior significa que o prestador mandou o cnpj na TAG  de codigo
		nIdx 	 := 4
	Else
		cNewRDA := padr(cNewRDA,6)
		nIdx 	 := 1
	Endif

	If !Empty(cNewRDA)
		BAW->(DbSetOrder(3))
		cRdaAnt := cNewRDA+Space( TamSX3("BAW_CODANT")[1]-Len(cNewRDA) )
		If BAW->(MsSeek(xFilial("BAW")+cOpeRda+cRdaAnt))
			cNewRDA := BAW->BAW_CODIGO
			nIdx 	:= 1
		Endif
	Endif


	BAU->( DbSetOrder( nIdx ) ) //BAU_FILIAL + BAU_CPFCGC ou  BAU_CODIGO ou BAU_CODBB0
	if !BAU->( MsSeek( xFilial("BAU")+cNewRDA ) )
		//cNewRDA := cCodRda // esse item foi comentando devido estar trazendo conteudo de outras RDA assim apresentando na criticas o nome de outra RDA
		cNewRDA := ""
	else
		cNewRDA	  := BAU->BAU_CODIGO
		nIdx 	  := 1
	endif

	RestArea(aArea)
Return(cNewRDA)

/*/{Protheus.doc} PAjustUnic
Ajusta o array unico para TAG iguais oom caminhos diferente
@type Function
@author Tabosa
@since 11/13/13
/*/
Static function PAjustUnic(aDUnic,cPthTag, cTag, cValue)
	Local nI 		:= 0
	Local nPos 	:= 0
	Local cTagExc	:= "\CBOS\CBO\"
	Local lTagExc	:= StrTran(cTag,"\","") $ cTagExc

	cTag := IIf(SubStr(Alltrim(cTag),1,1) == "\",Alltrim(cTag),"\" + Alltrim(cTag))

	nPos := aScan(aDUnic,{|x| Upper(StrTRan(cTag,"\\","\")) $ Upper(StrTran(x[2], "\\", "\") + x[1])})

	If nPos > 0
		For nI := nPos+1 To Len(aDUnic)
			If (StrTran(Iif(lTagExc,cPthTag,"") + Upper(cTag),"\\","\"))  $ UPPER(StrTran(aDUnic[nI,2], "\\", "\") + aDUnic[nI,1])
				aDUnic[nPos, 3] := cValue
			EndIf
		Next
	EndIf

Return

/*/{Protheus.doc} u_CBBusTerDup
Busca tabelas com DE_PARA para a mesma terminologia
@type Function
@author Tabosa
@since 11/13/13
/*/
user function CBBusTerDup(cTabDup)
	Local aArea := GetArea()
	Local aTabDup := {}
	Local cSql		:= ""

	cSql := "SELECT BTU_CDTERM FROM " +RetSqlName("BTU")+ " WHERE BTU_CODTAB = '"+ cTabDup + "' AND D_E_L_E_T_ = '' GROUP BY BTU_CDTERM HAVING COUNT(*) >= 1"
	PlsQuery(cSql,'trbBTU')
	If trbBTU->(!Eof())
		While !trbBTU->(Eof())
			BTU->(DbSelectArea("BTU"))
			BTU->(DbSetOrder(3)) //BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_CDTERM
			If (BTU->(MsSeek(xFilial("BTU")+cTabDup+"BR4"+trbBTU->BTU_CDTERM)))
				While !BTU->(Eof()) .and. Alltrim(BTU->(BTU_FILIAL+BTU_CODTAB+BTU_ALIAS+BTU_CDTERM)) == Alltrim(xFilial("BTU")+cTabDup+"BR4"+trbBTU->BTU_CDTERM)
					AaDd(aTabDup, {trbBTU->BTU_CDTERM,Alltrim(BTU->BTU_VLRBUS)}	)
					BTU->(DbSkip())
				Enddo
			EndIf
			trbBTU->(DbSkip())
		EndDo
	EndIf
	trbBTU->(DbCloseArea())
	RestArea(aArea)
Return aTabDup

/*/{Protheus.doc} u_CChkTabDup
Caso nao encontre o procedimento eu tento com a outra tabela
Criado para caso de mais de uma tabela vinculada Termi Ex.22
@type Function
@author Tabosa
@since 11/13/13
/*/
user function CChkTabDup(cCodPad,cCodPro,cPadOri,lWeb)
	Local cTerm 	:= ""
	Local nPosF	:= 0
	Local nI		:= 0
	Local lFound	:= .F.
	Local cOthPad	:= ""
	Default lWeb := .F.

	BR8->(DbSetOrder(1))
	If Type("aTabDup") <> 'U'
		If (nPosF := aScan( aTabDup,{|x|Upper(x[2])==cCodPad} ) ) > 0	// quer dizer que possuo mais de uma tabela vinculada a essa terminlogia
			cTerm := aTabDup[nPosF,1]
			For nI := 1 To Len(aTabDup)
				BR8->(DbGoTop())
				//If nI <> nPosF // Se nao for a posição do que ja foi testado não entro // comentado pq algo estava desposicionando e foi necessario seekar novamente
				cOthPad := aTabDup[nI,2]
				If (lFound := (BR8->(MSSEEK(XFILIAL('BR8')+cOthPad+CCODPRO) .And. Iif(lWeb,BR8->BR8_PROBLO == '0' .Or. Empty(BR8->BR8_PROBLO) ,BR8->BR8_BENUTL=='1') .and. Alltrim(cPadOri) == Alltrim(aTabDup[nI,1]) ))) // Se achou sai fora
					cCodPad := cOthPad // ATUALIZO SE FOR PASSADO POR PARAMETRO
					Exit
				EndIf
				//EndIf
			Next nI
		EndIf
	EndIf
Return(lFound)

/*/{Protheus.doc} u_C973VLD91
Validacao da critica 091
@type Function
@author PLS
/*/
user function C973VLD91()
	Local lRet				:= .T.
	Local cValor_senha	:= ""
	Local nPos				:= aScan(aDados, {|x| UPPER(x[3]) == UPPER('nSeqGui='+Alltrim(Str(nSeqGui)))})
	Local aAreaBEA 		:= BEA->(GetArea())
	Local nFor				:= nPos
	Local lFoundAut		:=.F.


	For nFor:=nPos To Len(aDados)
		If Upper(aDados[nfor,1])=="SENHA" .or.  Upper(aDados[nfor,1]) =='NUMEROGUIAOPERADORA'
			cValor_senha:=aDados[nfor,3]
			Exit
		Endif

		If 'nSeqGui=' $ aDados[nfor,3]
			If Val(Substr(aDados[nFor,3],(At("=",aDados[nFor,3])+1),10)) > nSeqGui
				Exit
			Endif
		Endif

	Next nI

	BEA->( DbSetOrder(14) )

	If !Empty(cValor_senha)
		lFoundAut:= BEA->( MsSeek(xFilial("BEA")+padr(alltrim(cValor_senha),9)) )
	Endif

	If lFoundAut
		If cTipo == '2'
			lRet:= 	!((Alltrim(BEA->(BEA_OPEMOV+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO)) <> Alltrim(cMatric) .and. Alltrim(BEA->BEA_MATANT) <> Alltrim(cMatric))  .AND. !Empty(cValor_senha))
		Endif
		If cTipo == '3'
			lRet:= 	!((AllTrim(BE4->(BE4_CODOPE+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO)) <> AllTrim(CMatric) .and. AllTrim(BE4->BE4_MATANT) <> AllTrim(CMatric))  .AND. !Empty(cValor_senha))
		Endif
	EndIf

	RestArea(aAreaBEA)

Return lRet

/*/{Protheus.doc} u_CBBCodSi
@type Function
@author PLS
/*/
user function CBBCodSi(xCodSigla)
	Local cRet := ""

	If xCodSigla $ '1/01'
		cRet := 'CRAS'
	Elseif xCodSigla $ '2/02'
		cRet := 'COREN'
	Elseif xCodSigla $ '3/03'
		cRet := 'CRF'
	ElseIf xCodSigla $ '4/04'
		cRet := 'CRFA'
	Elseif xCodSigla $ '5/05'
		cRet := 'CREFITO'
	ElseIf xCodSigla $ '6/06'
		cRet := 'CRM'
	ElseIf xCodSigla $ '7/07'
		cRet := 'CRN'
	ElseIf xCodSigla $ '8/08'
		cRet := 'CRO'
	ElseiF xCodSigla $ '9/09'
		cRet := 'CRP'
	Elseif xCodSigla $ '10'
		cRet := 'OUT'
	Endif

Return cRet

/*/{Protheus.doc} U_CXMLTISWS
Valida se o Lote Guia está na versão TISS Online
@type Function
@author PLS
@since 14/05/2015
/*/
user function CXMLTISWS(aDados)
	Local lLoteTissOnline := .F.
	Local nI 		:= 1
	Default aDados := {}

	For nI := 1 To Len(aDados)
		//se palavra na TAG do ARRAY não encontrou a tag no array
		If (At("LOTEGUIASWS", aDados[nI, 2]) > 0)
			//modifica o conteúdo alterando as TAGS que possuam LOTEGUIASWS para MENSAGEMTISS
			aDados[nI, 2] := strTran( Upper(aDados[nI, 2]), "LOTEGUIASWS", "MENSAGEMTISS")

			lLoteTissOnline := .T.
		EndIf

		//se palavra na TAG do ARRAY não encontrou a tag no array
		If (At("\MENSAGEMTISS\LOTEGUIAS\", aDados[nI, 2]) > 0)
			//modifica o conteúdo alterando as TAGS que possuam LOTEGUIASWS para MENSAGEMTISS
			aDados[nI, 2] := strTran( Upper(aDados[nI, 2]), "\MENSAGEMTISS\LOTEGUIAS\", "\MENSAGEMTISS\PRESTADORPARAOPERADORA\LOTEGUIAS\")
		EndIf

		//Na tiss ONLINE NÃO EXISTE epilogo
		If ( AllTrim(Upper(aDados[nI, 1])) == "HASH")
			//modifica o conteúdo alterando as TAGS que possuam LOTEGUIASWS para MENSAGEMTISS
			aDados[nI, 2] := "\MENSAGEMTISS\EPILOGO\"
		EndIf
	Next

Return lLoteTissOnline

/*/{Protheus.doc} u_CBVerVia
Validacao da critica X49
@type Function
@author PLS
/*/
user function CBVerVia(cViaAcesso,CCODPAD,CCODPRO)
	Local lRet		:= .T.
	Local aAreaBD5 	:= BD5->(GetArea())
	Local aAreaBD6 	:= BD5->(GetArea())
	Local aAreaBE4	:= BD5->(GetArea())

	If BR8->BR8_TIPEVE $ "2#3" // somente procedimento clinicos ou ambos
		If cTipGui $ "01#02#04"
			BD5->(DbSetOrder(7))
			BD6->(DbSetOrder(13))

			If BD5->(DbSeek(xFilial("BD5")+cNumSen))
				If BD6->(DbSeek(xFilial("BD6")+	BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG+BD5_DIGITO+BD5_ANOPAG+BD5_MESPAG+" "+cCodPad+cCodPro)))
					If BD6->BD6_VIA <>cViaAcesso
						lRet		:= .F.
					Endif
				Endif
			Endif

		Else
			BE4->(DbSetOrder(7))
			BD6->(DbSetOrder(13))
			If BE4->(DbSeek(xFilial("BE4")+cNumSen))
				If BD6->(DbSeek(xFilial("BD6")+	BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO+BE4_ANOPAG+BE4_MESPAG+" "+cCodPad+cCodPro)))
					If BD6->BD6_VIA <>cViaAcesso
						lRet		:= .F.
					Endif
				Endif
			Endif

		Endif
	Endif
	RestArea(aAreaBD5)
	RestArea(aAreaBD6)
	RestArea(aAreaBE4)
Return lRet

/*/{Protheus.doc} u_C973LGRAUPAR
Validacao da critica 581
@type Function
@author PLS
/*/
user function C973LGRAUPAR(aCompo, cTipGui, cOpeMov, cCodTab, cCodPad, cCodPro, cGrauPar)

	Local lRet:=.t.
	Default aCompo := PLSCOMEVE(aCodTab[3],cCodPad,cCodPro,cOpeMov,dDatPro)

	If ExistBlock("PLCHKPAR")
		lRet := ExecBlock("PLCHKPAR",.F.,.F.,{aCompo, cTipGui, cOpeMov, cCodTab, cCodPad, cCodPro, cGrauPar} )
	EndIf

	If Valtype(lRet)<> "L"
		lRet:=.t.
	Endif


Return lRet

/*/{Protheus.doc} u_CB973RETLOC
Retorna o local de atendimento do prestador com base no CNES
@type Function
@author PLS
/*/
user function CB973RETLOC(cRda_,cCodOpe_,cCnes_)
	Local cLocal_ := ""
	Local cSql	:= ""

	iF !Empty(cCnes_)
		cSql += " SELECT BB8_CODLOC FROM "+RetSqlName("BB8")+" BB8 "
		cSql += "    WHERE BB8_FILIAL = '"+xFilial("BB8")+"' "
		cSql += "      AND BB8_CODIGO = '"+cRda_+"' "
		cSql += "      AND BB8_CODINT = '"+cCodOpe_+"' "
		cSql += "      AND BB8_CNES   = '"+cCnes_+"' "
		cSql += "      AND BB8.D_E_L_E_T_ = ' ' "

		PLSQuery(cSQL,"TrbBB8")
		//Retorna o primeiro, pois se tiver mais de um local com o mesmo CNES considera o primeiro
		iF !TrbBB8->(Eof())
			cLocal_ := TrbBB8->BB8_CODLOC
		EndIf

		TrbBB8->(DbCloseArea())
	EndIf

	If Empty(cLocal_)		//Se nao achar pelo CNES retorna o primeiro local (mantendo legado)
		BB8->(DbSetOrder(1))
		BB8->(MsSeek(XFILIAL('BB8')+cRda_))
		cLocal_ := BB8->BB8_CODLOC
	EndIf


Return cLocal_

/*/{Protheus.doc} PLS973VRDA
Retorna o codigo da RDA da Tag IDENTIFICACAOPRESTADOR, do cabecalho do XML
@author Oscar Zanin
@since 21/05/2016
@version P12
/*/ 
user Function cb973VRDA(cIdenPre)

	Local cCodRDA := AllTrim(Strtran(Strtran(cIdenPre, ".", ""), ",", ""))
	Local lCpf		:= Len(cCodRDA) == 11
	Local lCNPJ	:= Len(cCodRDA) == 14
	Local lCod		:= IIF( lCNPJ .OR. lCpf, .F., .T.)
	Local cRet		:= ""
	Local aArea	:= BAU->(GetArea())

	Default cIdenPre := ""

	If lCpf .OR. lCNPJ
		BAU->(DbSetOrder(4))
		If BAU->(MsSeek(xFilial("BAU") + cCodRDA))
			cRet := BAU->BAU_CODIGO
		EndIf
	else
		cRet := StrZero(Val(cIdenPre),6)
	EndIf

	RestArea(aArea)

Return cRet
/*/{Protheus.doc} u_CBCarCBOVar
Inicializa as variaveis dinamicas referente às TAGs de CBOS
e especialidade dos profissionais da guia

@type Function
@author victor.silva
@since 31/03/2016
@version 1.0
@param cTpDad, caracter, 	Indica variavel esta sendo carregada
1 - CBOs do Solicitante
2 - CBOs do Executante
3 - Especialidade do Solicitante conforme De/Para
4 - Especialidade do Executante conforme De/Para
5 - Especialidade do Prestador contratado conforme regra definida
@param aDadXML, array, 	Recebe o endereco do ADADOSUNIC
@return cRet, caracter, String com o dado solicitado
/*/
user Function u_CBCarCBOVar(cTpDad,aDadXML,cTagBus)
	Local cRet		:= ""
	Default cTagBus	:= "CBOS"

	/*
	Variaveis dinamicas utilizadas
	- CGUIA		: Tipo de Guia
	- _CCBOSOL	: CBOs do Solicitante
	- _CCBOEXE	: CBOs do Executante
	- _CESPEXE	: Especialidade do Executante
	- _LPLSCTES	: Indica o status do parametro MV_PLSCTES (Ativado/Desativado)
	- DDATPRO		: Data de execucao do procedimento
	- CRDAORI		: Codigo do Prestador
	- COPEMOV		: Codigo da operadora
	- CCODLOC		: Codigo do Local de Atendimento do Prestador
	*/

	//Case para definir o tipo de Guia (utiliza a variavel dinamica CGUIA)
	Do Case
		Case CGUIA $ "GUIACONSULTA,GUIACONSULTAREAPRESENTACAO"
		cTipGui	:= "01"
		Case CGUIA $ "GUIASP_SADT,GUIASP_SADTREAPRESENTACAO"
		cTipGui	:= "02"
		Case CGUIA $ "GUIARESUMOINTERNACAO,GUIARESUMOINTERNACAOREAPRESENTACAO"
		cTipGui	:= "05"
		Case CGUIA $ "GUIAHONORARIOINDIVIDUAL,GUIAHONORARIOINDIVIDUALREAPRESENTACAO,GUIAHONORARIOS"
		cTipGui	:= "06"
	EndCase

	If cTagBus == "CBOS" .And. cTipGui	== "06"
		cTagBus := "CBO"
	EndIf

	//Case para retornar o dado conforme solicitado na variavel cTpDad
	Do Case
		//CBO do Solicitante
		Case cTpDad == "1"
		//A TAG referente ao CBO do solicitante so esta disponivel em guias SP_SADT
		If cTipGui <> "02"
			cRet:= ""
		Else
			cRet:= u_CVLRTAGXML(aDadXML,"\PROFISSIONALSOLICITANTE\" + cTagBus)
		EndIf

		//CBO do Executante
		Case cTpDad == "2"
		If cTipGui == "01"
			cRet:= u_CVLRTAGXML(aDadXML,"\PROFISSIONALEXECUTANTE\" + cTagBus)
		ElseIf cTipGui == "02"
			cRet:= u_CVLRTAGXML(aDadXML,"\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTOEXECUTADO\EQUIPESADT\" + cTagBus)
		ElseIf cTipGui == "05"
			cRet:= u_CVLRTAGXML(aDadXML,"\PROCEDIMENTOSEXECUTADOS\PROCEDIMENTOEXECUTADO\IDENTEQUIPE\IDENTIFICACAOEQUIPE\" + cTagBus)
		ElseIf cTipGui == "06"
			cRet:= u_CVLRTAGXML(aDadXML,"\PROCEDIMENTOSREALIZADOS\PROCEDIMENTOREALIZADO\PROFISSIONAIS\" + cTagBus)
		EndIf

		//Especialidade do Solicitante
		Case cTpDad == "3"
		cRet:= Iif(!Empty(_CCBOSOL),U_CBVARVINC("24","BAQ",_CCBOSOL),"")

		//Especialidade do Executante
		Case cTpDad == "4"
		cRet:= Iif(!Empty(_CCBOEXE),U_CBVARVINC("24","BAQ",_CCBOEXE),"")

		//Especialidade do Prestador Contratado
		Case cTpDad == "5"
		cRet := ""

	EndCase

Return cRet


/*/{Protheus.doc} u_CTrCBOSUB
Funcao generica para validacao de criticas referentes ao CBOs enviados no arquivo.
As variaveis dinamicas ja alimentadas sao carregadas via parametro e validadas conforme
regras da critica sendo avaliada no momento.

*	Parametros correspondentes as variaveis privadas criada na tabela BVP.
SAO INFORMADOS APENAS PARA ATUALIZACAO DO VALOR DE ACORDO COM O ADADUNIC AO MUDAR A TAG

@type Function
@author victor.silva
@since 31/03/2016
@version 1.0
@param cCodGlo, caracter, Codigo da glosa vinculada a expressao da BVN que esta sendo analisada
@param cCboExe*, caracter, Codigo do CBO do Executante
@param cCboSol*, caracter, Codigo do CBO do Solicitante
@param cCodEsp*, caracter, Codigo da Especialidade do Prestador
@param cEspExe*, caracter, Codigo da Especialidade do Executante
@param cEspSol*, caracter, Codigo da Especialidade do Solicitante
@param aDadUser*, array, Array com os dados do usuario
@param aDadPres*, array, Array com os dados do usuario
@param cCdTpPd*, caracter, Codigo do procedimento em validacao
@param cCodPsa*, caracter, Codigo do procedimento em validacao
@return boolean, Retorno com a validacao da critica
/*/
User Function CTrCBOSUB(cCodGlo,cCboExe,cCboSol,cCodEsp,cEspExe,cEspSol,aDadUser,aDadPres,cCdTpPd,cCodPsa)
	Local lRet 			:= .F.	//Retorno
	Local cCboX			:= ""	//CBO do profissional (Solicitante ou Executante)
	Local cEspX			:= ""	//Especialidade do profissional (Solicitante ou Executante)
	Local cCodBB0		:= ""	//Codigo do profissional (Solicitante ou Executante)
	Local cTipPro 		:= ""	//Tipo do profissional (S-Solicitante, E-Executante)
	Local aRetPe		:= {}	//Retorno do ponto de entrada PLTISESP
	Local aRetExe		:= {}	//Retorno da funcao PLSTRATEXE
	Local xEsp			:= {}	//Caracter ou Array com a(s) Especialidade(s) encontrada(as) no Prestador com base na do Profissional
	Local lExecPE		:= .F.	//Indica que deve executar o ponto de entrada PLTISESP para alterar o retorno de validacoes do padrao (007,047,X25)
	Local nI			:= 0	//Controle de estrutura de repeticao
	Local nPosExe		:= 0	//Controle de estrutura de repeticao para busca no array do retorno da funcao PLSTratExe
	Local cChvHash		:= ""	//Chave de busca do retorno da funcao PLSTratExe
	Local lGetHash		:= .F.	//Indica se encontrou o retorno da funcao PLSTratExe de acordo com a chave
	Local lGo			:= .T.	//Variavel de controle de erros
	Local cNomProf		:= ""	//Nome do profissional
	Local xRetExe		:= {}	//Array local com os retornos da funcao PLSTratExe

	Default aDadUser	:= {}
	Default aDadPres	:= {}
	Default cCodPsa		:= ""

	//Tipo de Prestador sendo validado
	If "SOLICITANTE" $ _cPathTag
		If cCodGlo $ "X55/X59/X60/X61"
			//Se for critica de bloqueio de especialidade ou procedimento, nao verifica para o solicitante
			Return .T.
		EndIf

		cCboX 	:= AllTrim(cCboSol)
		cEspX 	:= AllTrim(cEspSol)
		cTipPro	:= "S"
		cNomProf:= u_CBCarCBOVar("1",aDadosUnic,"NOMEPROFISSIONAL")
		cNomProf:= Iif(Empty(cNomProf),u_CBCarCBOVar("1",aDadosUnic,"NOMEPROF"),"")

	Else
		cCboX 	:= AllTrim(cCboExe)
		cEspX 	:= AllTrim(cEspExe)
		cTipPro	:= "E"
		cNomProf:= u_CBCarCBOVar("2",aDadosUnic,"NOMEPROFISSIONAL")
		cNomProf:= Iif(Empty(cNomProf),u_CBCarCBOVar("2",aDadosUnic,"NOMEPROF"),"")
	EndIf

	Do Case

		Case cCodGlo == "X25" //Especialidade nao encontrada no sistema com base no CBOS informado no arquivo.

		//Ativa o ponto de entrada para manipular o retorno
		lExecPE := .T.

		/*
		Variaveis dinamicas utilizadas:
		- DDATPRO		: Data de execucao do procedimento
		- CRDAORI		: Codigo do Prestador
		- COPEMOV		: Codigo da operadora
		- CCRM			: CRM do Executante/Solicitante
		- CCODUF		: UF do Executante/Solicitante
		- CSIGLA		: Sigla do conselho do Executante/Solicitante
		*/

		//Localiza o profissional
		PLSIVPRO("",CSIGLA,CCRM,CCODUF,4,NIL,NIL,NIL,cCboX)

		If BB0->( found() )

			cCodBB0 := BB0->BB0_CODIGO
			//999999 - CBOs desconhecido ou nao informado pelo Profissional
			/*
			O codigo eh previsto na tabela de terminologia 24, caso o prestador envie este numero
			O sistema deve considerar a primeira especialidade valida
			*/

			If Alltrim(cCboX) == '999999'
				lRet := .T.
				BQ1->(dbSetOrder(1))
				If BQ1->(MsSeek(xFilial("BQ1")+cCodBB0))
					cEspX	:= BQ1->BQ1_CODESP
					lRet := .T.
				Endif
			Else
				//Buscando a especialidade no Profissional de Saude
				dbSelectArea("BQ1")
				BQ1->(dbSetOrder(1))//BQ1_FILIAL + BQ1_CODIGO + BQ1_CODESP
				If BQ1->(MsSeek(xFilial("BQ1")+cCodBB0+cEspX))
					lRet := .T.
				Else
					//Buscando a especialidade no Prestador
					dbSelectArea("BAX")
					BAX->(dbSetOrder(3))//BAX_FILIAL+BAX_CODINT+BAX_CODESP+BAX_CODIGO
					If  BAX->(MsSeek(xFilial("BAX") + COPEMOV + cEspX + CRDAORI))
						lRet := .T.
					Endif
				Endif
			Endif
		Else
			//Buscando a especialidade na Rede de Atendimento
			dbSelectArea("BAX")
			BAX->(dbSetOrder(3))//BAX_FILIAL+BAX_CODINT+BAX_CODESP+BAX_CODIGO
			If  BAX->(MsSeek(xFilial("BAX") + COPEMOV + cEspX + CRDAORI))
				lRet := .T.
			Endif
		Endif

		//Informacoes adicionais no complemento da critica
		If !lRet
			If cTipPro == "S"
				If !Empty(cNomProf)
					CCOMPCRI := "Prestador Solicitante: " + cNomProf + CRLF
				EndIf
				CCOMPCRI += "Especialidade: " + cEspX + CRLF
				CCOMPCRI += "CBOS: " + cCboX + CRLF
			Else
				If !Empty(cNomProf)
					CCOMPCRI := "Prestador Executante: " + cNomProf + CRLF
				EndIf
				CCOMPCRI += "Especialidade: " + cEspX + CRLF
				CCOMPCRI += "CBOS: " + cCboX + CRLF
			EndIf
		EndIf

		Case cCodGlo == "X55" //Procedimento bloqueado na especialidade da Rede de atendimento.

		//Ativa o ponto de entrada para manipular o retorno
		lExecPE := .T.

		//Retorna o array STATIC com os resultados da func PLSTratExe
		xRetExe := P974RetHx(1)

		//Retorna todas as especialidades
		xEsp := PlRtEspPre(COPEMOV,CRDAORI,_CESPEXE,DDATPRO,CCODLOC,_LPLSCTES,.F.,Iif(_LPLSCTES,"A","C"),.F.)

		lGo := (!Empty(xEsp) .And. Len(aDadUser) > 0 .And. Len(aDadPres) > 0)

		//Caso nao encontrou nenhuma das informacoes acima, nao ha necessidade de validar a critica
		If !lGo
			Iif(Len(aDadUser) > 0,nil,QOut("Erro ao validar critica X55 - Inconsistência nos dados do Beneficiário - " + cArqXML))
			Iif(Len(aDadPres) > 0,nil,QOut("Erro ao validar critica X55 - Inconsistência nos dados do Prestador - " + cArqXML))
			lRet := .T.
		EndIf

		//Verifica se deve percorrer todas as especialidades e se deve continuar
		If !_LPLSCTES .And. lGo
			//Se a especialidade estiver bloqueada nao valido
			If PlPreEspBl(CRDAORI,COPEMOV,CCODLOC,xEsp,DDATPRO)
				lRet := .T.
				Return lRet
			Else
				//Salva a chave para as proximas consultas
				cChvHash := AllTrim(CCODPAD)
				cChvHash += AllTrim(CCODPRO)
				cChvHash += AllTrim(xEsp)
				cChvHash += AllTrim(CRDAORI)
				PlArrToS(aDadPres,@cChvHash)
				PlArrToS(aDadUser,@cChvHash)
				cChvHash += AllTrim(CCODLOC)
				cChvHash += DtoS(DDATPRO)

				//Criptografa a chave para economia de espaco no Array
				cChvHash := MD5(cChvHash,2)

				//Faz a busca
				lGetHash := PLSGetHash(cChvHash,@aRetExe,xRetExe)

				//Se nao achou, executa a rotina e salva o retorno
				If !lGetHash
					aRetExe := PLSTratExe(CCODPAD,CCODPRO,.T.,.T.,.F.,xEsp,CRDAORI,,aDadPres,aDadUser,,DDATPRO,xEsp,CCODLOC,,,,,xEsp,,.T.)
					lRet 		:= aRetExe[1]

					//Guarda o retorno
					PLSSetHash(cChvHash,aRetExe,@xRetExe)

				Else
					lRet := aRetExe[1]
					If !lRet
						CNVCRIXML 	:= u_CB973PATH(aRetExe[2])
					EndIf
				EndIf
			EndIf

		ElseIf lGo .And. Len(xEsp) > 0

			For nI := 1 to Len(xEsp)

				//Se a especialidade estiver bloqueada nao valido
				If xEsp[nI][4] == "1"
					lRet := .T.
					loop
				Else
					//Salva a chave para as proximas consultas
					cChvHash := AllTrim(CCODPAD)
					cChvHash += AllTrim(CCODPRO)
					cChvHash += AllTrim(xEsp[nI][1])
					cChvHash += AllTrim(CRDAORI)
					PlArrToS(aDadPres,@cChvHash)
					PlArrToS(aDadUser,@cChvHash)
					cChvHash += AllTrim(CCODLOC)
					cChvHash += DtoS(DDATPRO)

					//Criptografa a chave para economia de espaco no Array
					cChvHash := MD5(cChvHash,2)

					//Faz a busca
					lGetHash := PLSGetHash(cChvHash,@aRetExe,xRetExe)

					//Se nao achou, executa a rotina e salva o retorno
					If !lGetHash
						aRetExe := PLSTratExe(CCODPAD,CCODPRO,.T.,.T.,.F.,xEsp[nI][1],CRDAORI,,aDadPres,aDadUser,,DDATPRO,xEsp[nI][1],CCODLOC,,,,,xEsp[nI][1],,.T.)

						//Guarda o retorno
						PLSSetHash(cChvHash,aRetExe,@xRetExe)

						lRet := aRetExe[1]

						If lRet
							Exit
						EndIf
					Else
						lRet := aRetExe[1]
						If lRet
							Exit
						EndIf
					EndIf
				EndIf
			Next
		EndIf

		//Informacoes adicionais no complemento da critica
		If !lRet
			If !Empty(cNomProf)
				CCOMPCRI := "Prestador Executante: " + cNomProf + CRLF
			EndIf
			CCOMPCRI += "Especialidade do Executante: " + cEspX + CRLF
			CCOMPCRI += "CBOS: " + cCboX
			If !_LPLSCTES
				CCOMPCRI += CRLF
				CCOMPCRI += "Especialidade do Prestador com base no CBOS enviado: " + xEsp + CRLF
				CCOMPCRI += "Local de atendimento: " + CCODLOC + CRLF
				CCOMPCRI += CNVCRIXML
			Else
				CCOMPCRI += CRLF
				CCOMPCRI += "Nao foi possivel localizar permissao para execucao do procedimento em nenhuma especialidade do Prestador" + CRLF
			EndIf
		EndIf

		Case cCodGlo == "X59" //Especialidade bloqueada para esta RDA.

		//Ativa o ponto de entrada para manipular o retorno
		lExecPE := .T.

		//Verifica se a especialidade foi encontrada e limpa a especialidade para validacao da proxima guia.
		If !(Empty(_CESPEXE))
			//Retorna novamente a especialidade caso esteja vazia.
			xEsp := PlRtEspPre(COPEMOV,CRDAORI,_CESPEXE,DDATPRO,CCODLOC,_LPLSCTES,.F.,Iif(_LPLSCTES,"A","C"),.F.)

			//Se estiver vazia, nao e necessario validar o bloqueio
			If Empty(xEsp)
				lRet := .T.
			ElseIf !_LPLSCTES
				//Buscando a especialidade na Rede de Atendimento
				If !PlPreEspBl(CRDAORI,COPEMOV,CCODLOC,xEsp,DDATPRO)
					lRet := .T.
				Endif
			Else
				//Se encontrou uma especialidade ativa, retorna verdadeiro
				If aScan(xEsp,{|x|(x[4]) == "0"}) > 0
					lRet := .T.
				EndIf
			EndIf

		Else
			//Se a especialidade do executante estiver vazia, nao valido a critica
			lRet := .T.
		EndIf

		//Informacoes adicionais no complemento da critica
		If !lRet
			If !Empty(cNomProf)
				CCOMPCRI := "Prestador Executante: " + cNomProf + CRLF
			EndIf
			CCOMPCRI += "Especialidade do Executante: " + cEspX + CRLF
			CCOMPCRI += "CBOS: " + cCboX
			If !_LPLSCTES
				CCOMPCRI += CRLF
				CCOMPCRI += "Especialidade do Prestador com base no CBOS enviado: " + xEsp + CRLF
				CCOMPCRI += "Local de atendimento: " + CCODLOC
			Else
				CCOMPCRI += CRLF
				CCOMPCRI += "Nao foi possivel localizar nenhuma especialidade ativa no cadastro do Prestador" + CRLF
			EndIf
		EndIf

		//Ponto de Entrada para realizar o vinculo de mais de um CBOs a uma Especialidade
		Case ExistBlock("PLTISESP") .And. !Empty(cCboX) .And. !Empty(cCodGlo)

		//Primeira chamada para criticas customizadas
		aRetPe := ExecBlock("PLTISESP",.F.,.F.,{"1",cTipPro,cNomProf,cCboX,cEspX,cCodGlo,lRet})
		If ValType(aRetPe) == "A"
			lRet		:= aRetPe[3]
		Endif

	EndCase

	//Ponto de Entrada para realizar o vinculo de mais de um CBOs a uma Especialidade
	If ExistBlock("PLTISESP") .And. !Empty(cCboX) .And. lExecPE

		//Segunda chamada para customizacao das criticas padrao
		aRetPe := ExecBlock("PLTISESP",.F.,.F.,{"1",cTipPro,cNomProf,cCboX,cEspX,cCodGlo,lRet})
		If ValType(aRetPe) == "A"
			lRet		:= aRetPe[3]
		Endif

	EndIf

Return lRet

/*/{Protheus.doc} u_C973LDCLI
Adiciona no array padrao as criticas de cliente

@type function
@author victor.silva
@since 27/07/2016
@version 1.0
/*/
user function C973LDCLI()

	local cTipoGrv		:= "1"
	local cLocalExec	:= "5"
	local nI 				:= 0
	local aCriCust		:= {}
	local lRet				:= .F.
	local cOpeMov			:= PLSIntPad()

	if Len(__aCriCust) == 0
		//Ordena por tipo de glosa
		DbSelectArea("BVN")
		BVN->(DbSetOrder(2))//BVN_FILIAL+BVN_CODOPE+BVN_PROPRI+BVN_CODGLO

		//Faz a busca por validacoes de cliente
		if BVN->(MsSeek(xFilial("BVN") + cOpeMov + "7"))
			//Define o array de criticas
			while ( BVN->(!Eof()) .And. BVN->BVN_PROPRI == "7")
				aAdd(aCriCust,{BVN->(BVN_PROPRI + BVN_CODGLO)})
				BVN->(dbSkip())
			enddo
		endif

		for nI:= 1 to Len(aCriCust)
			//Adiciona a critica no array padrao
			if PLSPOSGLO(cOpeMov,aCriCust[nI][1],"",cLocalExec,"1",cTipoGrv)
				lRet := .T.
				aAdd(__aCriCust,{aCriCust[nI][1],BCT->BCT_DESCRI})
				aAdd(__XACRITICAS,__aCriCust[nI])
			endif
		next

		lRet := len(aCriCust) > 0
	endif

return lRet

/*/{Protheus.doc} u_CB973PATH
Formata o caminho da critica para exibir no log de criticas

@type function
@author victor.silva
@since 22/08/2016
@version 1.0
@param aCodCri, array , Array com as criticas do procedimento
@return cPath, caminho da critica
/*/
user function CB973PATH(aCodCri)
	local cPath 	:= ''
	local nLen		:= Len(aCodCri)

	cPath := "Nivel: " 		+ SubStr(AllTrim(StrTran(aCodCri[nLen][2],'"','')),8) + CRLF
	cPath += "Caminho: " 	+ SubStr(AllTrim(StrTran(aCodCri[nLen][3],'"','')),6)

	PLSDelTra(@cPath)

return cPath


/*/{Protheus.doc} 973LTran
Executa varios STRTRAN limpando o conteudo que vai para o aDados
@type function
@author timoteo.bega
@since 28/10/2016
@version 1.0
/*/
Static Function A973LTran(cTexto,cTipo,aPrefixo,cTpGuias)
	Local nFor			:= 0
	Local nMax			:= 0
	Default cTexto 		:= ""
	Default cTipo		:= ""
	Default aPrefixo	:= {"_ANS_","_ANSTISS_","ANS:","ANSTISS:","_"}
	Default cTpGuias	:= ""

	If Len(aPrefixo) >= 5 .And. cTipo == "REALNAME"
		nMax := Len(aPrefixo) - 1
	Else
		nMax := Len(aPrefixo)
	EndIf

	For nFor := 1 TO nMax
		cTexto := StrTran(cTexto,aPrefixo[nFor],"")
		If cTexto $ cTpGuias
			Exit
		EndIf
	Next nFor

Return cTexto

/*/{Protheus.doc} u_CXMLRetMatr
Retorna o numero da matricula do beneficiario de acordo com o conteudo da TAG [\NUMEROCARTEIRA] ou
a informacao do Ponto de entrada PLSXMLMAT
@type Function
@author victor.silva
@since 31/10/2016
@param cMatrPad, caracter, Matricula padrao dentro da TAG [\NUMEROCARTEIRA]
@return caracter, matricula do usuario
/*/
user function CXMLRetMat(cMatrPad,cNomUsr)
	local cRet := cMatrPad

	//Ponto de entrada para alterar a matricula
	if ExistBlock("PLSXMLMAT")
		cRetPe := ExecBlock("PLSXMLMAT",.F.,.F.,{cMatrPad,cNomUsr})

		if ValType(cRetPe) == "C"
			cRet := cRetPe
		else
			QOut("Erro no retorno do P.E. PLSXMLMAT. A matricula padrao foi assumida")
		endif

	endif

return cRet

/*/{Protheus.doc} u_C973TpGui
Retorna os possiveis tipos de arquivo XML TISS
@author victor.silva
@since 01/11/2016
@param cTissVer, caracter, Versao TISS
@return caracter, Tipos de arquivos XML
/*/
user function C973TpGui(cTissVer)
	local cRet := ""

	default cTissVer := ""

	//Consulta
	cRet := "GUIACONSULTA,"
	cRet +=	"GUIACONSULTAREAPRESENTACAO,"

	//SADT
	cRet +=	"GUIASP_SADT,GUIASP-SADT,GUIASPSADT,"
	cRet +=	"GUIASP_SADTREAPRESENTACAO,"
	cRet +=	"GUIASOLICITACAOSADT,GUIASOLICITACAOSP-SADT,"
	cRet +=	"GUIASOLICITACAOSP_SADT,SOLICITACAOSP_SADT,"
	cRet +=	"SOLICITACAOSP-SADT,SOLICITACAOSPSADT,"

	//Internacao/Prorrog. Intern
	cRet +=	"GUIASOLICINTERNACAO,SOLICITACAOINTERNACAO,"
	cRet +=	"GUIASOLICITACAOPRORROGACAO,"
	cRet +=	"SOLICITACAOPRORROGACAO,"

	//Resumo de Internacao
	cRet +=	"GUIARESUMOINTERNACAO,"
	cRet +=	"GUIARESUMOINTERNACAOREAPRESENTACAO,"

	//Honorarios
	cRet +=	"GUIAHONORARIOINDIVIDUAL,GUIAHONORARIOS,"
	cRet +=	"GUIAHONORARIOINDIVIDUALREAPRESENTACAO,"

	//Recurso de Glosas/Reemb.
	cRet += "RECURSOGUIA,SOLICITACAOSTATUSRECURSOGLOSA,"
	cRet += "RECURSOPROTOCOLO,"

	//Pagamento
	cRet += "DEMONSTRATIVOANALISE,"
	cRet += "DEMONSTRATIVOPAGAMENTO,"
	cRet += "DEMONSTRATIVOPAGAMENTOODONTO,"

	//Elegibilidade
	cRet +=	"SOLICITASTATUSAUTORIZACAO,"
	cRet +=	"VERIFICAELEGIBILIDADE,"
	cRet +=	"CANCELAGUIA,"

	//TODO Odontologia
	cRet +=	"GUIAODONTOLOGIA,GUIAODONTO,"
	cRet +=	"GUIAODONTOLOGIAREAPRESENTACAO,"
	cRet +=	"GUIASOLICITACAOODONTOLOGIA,"
	cRet +=	"SOLICITACAOODONTOLOGIA,"

return cRet

/*/{Protheus.doc} u_C973VldLoc
Realiza validacao do local de atendimento informado na senha de liberacao de acordo com o enviado no XML
@author victor.silva
@since 17/01/2017
@param cCnesXml, caracter, Codigo do CNES do Local de Atendimento
/*/
user function C973VldLoc(aDadXML)
local lRet 		:= .T.
local lFound	:= .F.
local lNoCnes	:= .F.
local cLocGui	:= ""
local cLocXML	:= ""
local cCnesGui	:= ""
local cCnesXml	:= ""
local dDatBlo	:= CtoD("")

//Posiciona na Guia de Solicitação de acordo com a Senha e retorna o local de atendimento e CNES de acordo com o tipo de guia e versao TISS
do case
	case CGUIA $ "GUIACONSULTA,GUIACONSULTAREAPRESENTACAO"
		
		//Retorna o numero da autorizacao da consulta
		cNumAut := AllTrim(u_CVLRTAGXML(aDadXML,"\NUMEROGUIAOPERADORA"))
		
		if !empty(cNumAut)
			//Busca pelo codigo do Protheus
			BEA->(DbSetOrder(1))//BEA_FILIAL+BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT
			if !BEA->(MsSeek(xFilial("BEA") + cNumAut))
				//Caso nao encontre busca pela senha
				BEA->(DbSetOrder(14))//BEA_FILIAL+BEA_SENHA
				if BEA->(MsSeek(xFilial("BEA") + cNumAut))
					cLocGui := BEA->BEA_CODLOC
				endif
			else
				cLocGui := BEA->BEA_CODLOC
			endif
		endif
		
		cCnesXml	:= u_CVLRTAGXML(aDadXML,"\CONTRATADOEXECUTANTE\CNES")

	//Se a variavel NRECNOAUT estiver maior que 0, significa que a tag <SENHA> esta presente no arquivo e a autorizacao foi localizada
	case CGUIA $ "GUIASP_SADT,GUIASP_SADTREAPRESENTACAO"
		BEA->(DbGoTo(NRECNOAUT))
		if NRECNOAUT > 0
			cLocGui	:= BEA->BEA_CODLOC
		endif
		cCnesXml := u_CVLRTAGXML(aDadXML,"\DADOSEXECUTANTE\CNES")
		
	case CGUIA $ "GUIARESUMOINTERNACAO,GUIARESUMOINTERNACAOREAPRESENTACAO"
		BE4->(DbGoTo(NRECNOAUT))
		if NRECNOAUT > 0
			cLocGui	:= BE4->BE4_CODLOC
		endif
		cCnesXml := u_CVLRTAGXML(aDadXML,"\DADOSEXECUTANTE\CNES")

	case CGUIA $ "GUIAHONORARIOINDIVIDUAL,GUIAHONORARIOINDIVIDUALREAPRESENTACAO,GUIAHONORARIOS"
		BE4->(DbGoTo(NRECNOAUT))
		if NRECNOAUT > 0
			cLocGui	:= BE4->BE4_CODLOC
		endif
		cCnesXml := u_CVLRTAGXML(aDadXML,"\LOCALCONTRATADO\CNES")
endcase

//Verifica se o CNES existe em algum local de atendimento do Prestador
BB8->(DbSetOrder(1))//BB8_FILIAL+BB8_CODIGO+BB8_CODINT+BB8_CODLOC+BB8_LOCAL
if BB8->(MsSeek(xFilial("BB8")+ CCODRP + COPEMOV))
	While !BB8->(Eof()) .And. AllTrim(BB8->(BB8_CODIGO + BB8_CODINT)) == CCODRP + COPEMOV  
		
		lFound	:= AllTrim(BB8->BB8_CNES) == AllTrim(cCnesXml) 
		lNoCnes	:= empty(BB8->BB8_CNES)
		cLocXML	:= AllTrim(BB8->BB8_CODLOC)
		dDatBlo	:= BB8->BB8_DATBLO
		
		BB8->(DbSkip())
		
		if lFound .Or. lNoCnes
			exit
		endif
	EndDo

	//Se encontrou algum local de atendimento vazio ou encontrou o informado, nao critica
	if (!lFound .And. !lNoCnes)
		lRet 		:= .F.
		CCOMPCRI 	+= "CNES não encontrado nos Locais de atendimento do Prestador" + CRLF
	endif
endif

if lRet .And. !empty(cLocGui)
	//Verifica se o local de atendimento da liberacao, nao possui CNES
	BB8->(DbSetOrder(1))//BB8_FILIAL+BB8_CODIGO+BB8_CODINT+BB8_CODLOC+BB8_LOCAL
	if BB8->(MsSeek(xFilial("BB8")+ CCODRP + COPEMOV + cLocGui))
		
		dDatBlo	 := BB8->BB8_DATBLO
		cCnesGui := AllTrim(BB8->BB8_CNES)
		
		if !empty(cCnesGui)
			//Verifica se o codigo informado na liberacao e diferente do enviado no XML
			if cCnesGui <> AllTrim(cCnesXml)
				lRet 		:= .F.
				CCOMPCRI 	+= "CNES do Local de atendimento informado na Solicitacao: " + cCnesGui + CRLF
			endif
			
			//Verifica se o local de atendimento esta bloqueado na data da execucao
			if lRet .And. !empty(dDatBlo) .And. DDATPRO >= dDatBlo .And. !lNoCnes
				lRet 		:= .F.
				CCOMPCRI 	+= "Local de atendimento bloqueado na data de execucao do atendimento" + CRLF
				CCOMPCRI 	+= "Data de execucao	: " + DtoC(DDATPRO) + CRLF
				CCOMPCRI 	+= "Data do bloqueio	: " + DtoC(dDatBlo) + CRLF
			endif
		endif
	endif
elseif lRet .And. empty(cLocGui)
	//Verifica somente o bloqueio
	if !empty(cCnesXml) .And. !empty(dDatBlo) .And. !lNoCnes
		if DDATPRO >= dDatBlo
			lRet 		:= .F.
			CCOMPCRI 	+= "Local de atendimento bloqueado na data de execucao do atendimento" + CRLF
			CCOMPCRI 	+= "Data de execucao	: " + DtoC(DDATPRO) + CRLF
			CCOMPCRI 	+= "Data do bloqueio	: " + DtoC(dDatBlo) + CRLF
		endif
	endif
endif

return lRet

/*/{Protheus.doc} u_CLIMPAVAR
Limpa a variavel static usada na funcao PLVALPRSE
@type function
@author TOTVS
@since 30/08/2016
@version 1.0
/*/
User Function CLIMPAVAR()
	_aDadProc := {}
Return
