#INCLUDE "plsxmov.ch"
#include "PROTHEUS.CH"
#include "PLSMGER.CH"
#include "PLSMCCR.CH"
#INCLUDE 'APWEBEX.CH'

#define __cTextoAll "*** Todos ***"
#define __aCdCri065 {"534","Time out.Operadora fora do Ar."}//"Time out.Operadora fora do Ar."
#define __aCdCri092 {"058","Esta empresa nao pode emitir guias via POS."}//"Esta empresa nao pode emitir guias via POS."
#define __aCdCri096 {"060","Operadora do usuario bloqueada para atendimento em intercambio."}//
#define __aCdCri103 {"704","Operadora nao esta On-Line -> "}//
#define __aCdCri104 {"705","Rede de atendimento de Alto Custo"}//
#define __aCdCri105 {"706","Procedimento na cadastrado na tabela MAT/MED"}//"Procedimento na cadastrado na tabela MAT/MED"
#define __aCdCri106 {"907","Data de atendimento informada na transacao de internacao (On-Line)"}//"Data de atendimento informada na transacao de internacao (On-Line)"
#define __aCdCri108 {"708","Base de dados nao esta preparada para transacao On-Line"}//"Base de dados nao esta preparada para transacao On-Line"
#define __aCdCri116 {"550","Nao foi possivel localizar o nivel de cobranca."} //"Nao foi possivel localizar o nivel de cobranca."
#define __aCdCri141 {"079","Item da liberação não solicitado"}//"Item da liberação não solicitado"
#define __aCdCri142 {"080","Lote de Guia já importado"}//"Lote de Guia já importado"
#define __aCdCri143 {"081","Liberação não encontrada"}//"Liberação não encontrada"
#define __aCdCri144 {"082","Item da liberação já executado"}//"Item da liberação já executado"
#define __aCdCri145 {"083","Item com quantidade maior que a solicitada"}//"Item com quantidade maior que a solicitada"
#define __aCdCri147 {"555","Hash informado no nome do arquivo diferente do contido no arquivo"}//"Hash informado no nome do arquivo diferente do contido no arquivo"
#define __aCdCri148 {"556","Hash invalido na validação do arquivo"}//"Hash invalido na validação do arquivo"
#define __aCdCri152 {"560","Internação com data de alta"}//"Internação com data de alta"
#define __aCdCri153 {"561","Incompatibilidade de informação entre (Tipo de faturamento e data de alta)"}//"Incompatibilidade de informação entre (Tipo de faturamento e data de alta)"
#define __aCdCri154 {"562","Honorário prestador não importador"}//"Honorário prestador não importador"
#define __aCdCri155 {"563","Equipe informada no resumo de intrnação para guia com honorário prestador"}//"Equipe informada no resumo de intrnação para guia com honorário prestador"
#define __aCdCri158 {"087","Bloqueio de pagamento e cobrança, evento não Autorizado."}//"Bloqueio de pagamento e cobrança, evento não Autorizado."
#define __aCdCri171 {"566","Verificar informacao do Prestador,Operadora de Movimento e o Local"}//"Verificar informacao do Prestador,Operadora de Movimento e o Local"
#define __aCdCri172 {"098","Obrigatorio a informacao do prestador executante para este tipo de guia"}//"Obrigatorio a informacao do prestador executante para este tipo de guia"
#define __aCdCri173 {"099","Guia já processada com este de numero impresso"}//"Guia já processada com este de numero impresso"
#define __aCdCri197 {"09P","Habilita checagem de regra para procedimentos incompatíveis!"}//"Habilita checagem de regra para procedimentos incompatíveis!"
#define __aCdCri198 {"09Q","Habilita checagem DE/PARA TUSS!"}//"Habilita checagem DE/PARA TUSS!"
#define __aCdCri199 {"09R","Não foi possível criar usuário genérico!"}//"Não foi possível criar usuário genérico!"
#define __aCdCri091 {"057","Usuario importado invalido. Deve ser alterado o usuario para o correto ou glosada a nota."}//"Usuario importado invalido. Deve ser alterado o usuario para o correto ou glosada a nota."
#define __aCdCri159 {"088","Matricula não existe ou invalida, criado usuário genérico."}//"Matricula não existe ou invalida, criado usuário genérico."
#define __aXMLCri23 {"X23","Numero da senha de autorizacao enviada invalida"}//"Numero da senha de autorizacao enviada invalida"
#define __aCdCri099 {"063","Participacao de servico informada invalida"}//"Participacao de servico informada invalida"
#define __aCdCri200 {"580","Procedimento do tipo 'Pacote' em autorização PTU On-line"}//"Procedimento do tipo 'Pacote' em autorização PTU On-line"
#define __aCdCri202 {"578","Registro DS_OBSERVA informado, guia automaticamente enviada para Auditoria"}//"Registro DS_OBSERVA informado, guia automaticamente enviada para Auditoria"
#define __aCdCri203 {"579","Registro DS_OPME informado, serviço não existe na tabela de Intercâmbio Nacional"}//"Registro DS_OPME informado, serviço não existe na tabela de Intercâmbio Nacional"
#define __aCdCri107 {"703","Processo de autorizacao On-Line (Cancelado)"}//"Processo de autorizacao On-Line (Cancelado)"
#define __aCdCri210 {"906","Matrícula intercâmbio inválida, rever cadastro beneficiário"}//"Matrícula intercâmbio inválida, rever cadastro beneficiário"
#define __aCdCri585 {"585","Quantidade de diarias Solicitadas diferente do Configurado na Tabela Padrao"} //"Quantidade de diarias Solicitadas diferente do Configurado na Tabela Padrao"}
#define __aCdCri228 {"586","Erro na estrutura do arquivo PTU Online gerado."}//"Erro na estrutura do arquivo PTU Online gerado."

// Abrangencia - "AREAABR"
//     	1 = Nacional
//     	2 = Regional A - Grupo de Estados
//     	3 = Estadual
//     	4 = Regional B - Grupo de Municipios
//     	5 = Municipal
// Natureza Juridica da Contratacao - "NATJURI"
//     	2 = Fisica
//		3 = Empresarial
//     	4 = Adesao
//     	5 = Beneficente

STATIC nHoraBase
STATIC cHoraBase
STATIC lWLIO := ( GetNewPar("MV_PLCPXML",'0') == '1' ) .Or. ( GetNewPar("MV_PLCPWEB",'0') == '1' ) .Or. ( GetNewPar("MV_PLCPTON",'0') == '1' )
STATIC aLibera := {}

/*/{Protheus.doc} U_CABXDIGO
Gravar Execução a partir do Controller
@type function
@author Roberto Vanderlei
@since 31.05.16
@version 1.0
/*/
User Function CABXDIGO(aDados,aItens)
	Local objCtrlGuia
	Local aRetorno	:= {}
	Local aCriticas	:= {}
	Local oObjGui
	Local nPos		:= 0
	Local cTipo		:= ""
	Local nQtdPJbMF	:= GetNewPar("MV_JBPROFF",25)
	Local lNMultT		:= .F.
	Local nQtdP		:= 0
	
	objCtrlGuia := CO_Guia():New()
	oObjGui := objCtrlGuia:addGuia(aDados,aItens)

	aRetorno := PLSRETOFF(oObjGui:getCodOpe() + oObjGui:getAnoPag() + oObjGui:getMesPag() + oObjGui:getNumAut())

	freeObj(oObjGui)
	oObjGui := nil
	nPos := Ascan(aDados,{|x| x[1] == "TIPOCONFIRM"})
	cTipo := aDados[nPos,2]
	
	//Se quantidade de procedimentos da guia maior ou igual que o valor definido em parâmetro, é automático o uso de multithread
	//Se não, é verificado a configuração da RDA
	nQtdP := objCtrlGuia:cntProced(aRetorno[2], "1")
	
	If nQtdP >= nQtdPJbMF
		lNMultT := .F.
	Else
		lNMultT := PLSExbCrOff(BD5->(Recno()))/*val(::Recno))*/
	EndIf
	
	If (cTipo == "1" .And. lNMultT ) //Se não, trabalha com multithread
		aCriticas := PLSMDFSGDIG(BD5->(Recno()))
		If ValType(aCriticas) <> "A"
			aCriticas := {}
		EndIf
	Elseif (cTipo == "1" .And. !lNMultT)
		PLSMDFSGDIG (BD5->(Recno()),,"S")
	EndIf
	
	IF Len(aCriticas) > 0
		aRetorno[1] := .F.
	ENDIF
	
	
return ({aRetorno, aCriticas, lNMultT})

/*/
U_CABXAUTP Tulio Cesar           Data 15.09.03±±±
Tratamento para executar autorizacao via POS, Web, etc
/*/
/*/{Protheus.doc} U_CABXAUTP
(long_description)
@type function
@author Tulio Cesar
@since 15.09.03
@version 1.0
/*/
User Function CABXAUTP(aDados,aItens)
	LOCAL lImpXml   	:= U_CBRETDAD( aDados,"IMPXML",.f. )
	LOCAL lImpTxt   	:= U_CBRETDAD( aDados,"IMPTXT",.f. )
	LOCAL cTipoGrv		:= U_CBRETDAD( aDados,"TPGRV","1" )
	LOCAL cNil 			:= Eval( { || Iif( lWLIO, U_CABWLIO(aDados,aItens), NIL ) } )
	LOCAL cNil2			:= Eval( { || PLXMVPR(@aDados,@aItens,lImpXml,cTipoGrv,lImpTxt) } )
	LOCAL _nInd			:= 0
	LOCAL nFor3			:= 0
	LOCAL nPosRet		:= 0
	LOCAL nH			:= 0
	LOCAL nFor			:= 0
	LOCAL nFor2			:= 0
	LOCAL nPos			:= 0
	LOCAL nY			:= 0
	LOCAL nX			:= 0
	LOCAL nI			:= 0
	LOCAL nLimCH		:= 0
	LOCAL nRecBEALIB	:= 0
	LOCAL nQtdSol		:= 0
	LOCAL nOrdBA0		:= 0
	LOCAL nRecBA0		:= 0
	LOCAL nSize			:= 0
	LOCAL nVlrTPF		:= 0
	LOCAL nVlrApr 	  	:= 0
	LOCAL nVAprTot		:= 0
	LOCAL nQtdDiAut   	:= 0
	LOCAL nQtdDiNeg   	:= 0
	LOCAL nLastPos   	:= 0
	LOCAL nPerVia 		:= 0
	LOCAL nPosCodPad	:= 0
	LOCAL nPosCodPro	:= 0
	LOCAL nPosQtdPro	:= 0
	LOCAL nRecBAU		:= 0
	LOCAL nRecBE2		:= 0
	LOCAL nRecBeaIni  	:= BEA->( Recno() )
	LOCAL cEstCr		:= ""
	LOCAL cNumCr		:= ""
	LOCAL cDesOPM		:= ""
	LOCAL cSigla		:= ""
	LOCAL cMatUsa		:= ""
	LOCAL cAno			:= ""
	LOCAL cMes			:= ""
	LOCAL cSeqMov		:= ""
	LOCAL cCodPad		:= ""
	LOCAL cCodPro		:= ""
	LOCAL cHoraPro		:= ""
	LOCAL cAlias		:= "BEA"
	LOCAL cSQL			:= ""
	LOCAL cPROCCI 		:= "0"
	LOCAL cVia    		:= ""
	LOCAL cRegAte     	:= ""
	LOCAL cDente  		:= ""
	LOCAL cFace   		:= ""
	LOCAL cOpeOri     	:= PlsIntPad()
	LOCAL cNomUsrIE   	:= ""
	LOCAL cRetCriMv   	:= ""
	LOCAL cSomInt     	:= ""
	LOCAL cMsgClient  	:= ""
	LOCAL cSenhaOpe   	:= ""
	LOCAL cTpLibToAut	:= ""
	LOCAL cGuiaOri 		:= ""
	LOCAL cMsg			:= ""
	LOCAL cHorIni		:= ""
	LOCAL cHorFim		:= ""
	LOCAL cCodCri		:= ""
	LOCAL cDesLoc		:= ""
	LOCAL cDesLocPro	:= ""
	LOCAL cLocal		:= ""
	LOCAL cAutRet		:= ""
	LOCAL cNumGuiH		:= ""
	LOCAL cLocalExec  	:= "1"
	LOCAL cAuditoria  	:= "0"
	LOCAL cLibEsp     	:= "0"
	LOCAL cRetGui  	  	:= "0"
	LOCAL cOperad		:= PLSRtCdUsr()
	LOCAL dDPrAH		:= CtoD("")
	LOCAL cFilBCT     	:= xFilial("BCT")
	LOCAL cMVPLSRDAG 	:= GetNewPar("MV_PLSRDAG","999999")
	LOCAL cVersao 		:= "13/08/2013 - 035"
	LOCAL bBlockXml   	:= NIL
	LOCAL cSenBSN       := ""
	LOCAL lTrtExe		:= .F.
	LOCAL lTrtCCl		:= .F.
	LOCAL lConsulta		:= .F.
	LOCAL lOPMM			:= .F.
	LOCAL lLogTro		:= .T.
	LOCAL lTrtUsr     	:= .T.
	LOCAL lContinua   	:= .T.
	LOCAL lOnline  	  	:= .F.
	LOCAL lIncUso 	  	:= .F.
	LOCAL lAprovLib   	:= .F.
	LOCAL lFindRes		:= .F.
	LOCAL lUsuGer		:= .F.
	LOCAL lMatGer 		:= .F.
	LOCAL lCirurgico    := .T.
	LOCAL lOnTLine		:= .F.
	LOCAL lAto			:= .F.
	LOCAL lCriMatInv    := .F.
	LOCAL aTrb			:= {}
	LOCAL aRetFun		:= {}
	LOCAL aValor	  	:= {}
	LOCAL aRdas		  	:= {}
	LOCAL aCriticas   	:= {}
	LOCAL aRetorno    	:= {}
	LOCAL aRetHon		:= {}
	LOCAL aHeader     	:= {}
	LOCAL aCols       	:= {}
	LOCAL aVetTrab    	:= {}
	LOCAL aDadCAB     	:= {}
	LOCAL aDadBEA     	:= {}
	LOCAL aDadBE4     	:= {}
	LOCAL aArea		  	:= {}
	LOCAL aEventosAut 	:= {}
	LOCAL aEventosNeg 	:= {}
	LOCAL aRet		  	:= {}
	LOCAL aHeaderLib  	:= {}
	LOCAL aVetTrabLib 	:= {}
	LOCAL aColsLib	  	:= {}
	LOCAL aDadIte	  	:= {}
	LOCAL aDadCri     	:= {}
	LOCAL aCabCri     	:= {}
	LOCAL aTrbCri     	:= {}
	LOCAL aRetExe		:= {}
	LOCAL aMatOPMM		:= {}
	LOCAL aTpSlvte       := {}
	LOCAL aAutItens  	:= {}
	LOCAL aItensLOri 	:= {}
	LOCAL aDadUsr       := {}
	LOCAL aMatTroca		:= {}
	LOCAL aTpPIte		:= {}
	LOCAL aMatInf		:= {}
	LOCAL aRetLib		:= {}
	LOCAL aIndDelCols	:= {}
	LOCAL aCloneCols	:= {}
	LOCAL ACABDF 		:= {}
	LOCAL ADADDF 		:= {}
	LOCAL ATRBDF 		:= {}
	LOCAL aRetOpe		:= {}
	LOCAL aRetPerInt	:= {}
	LOCAL aRetPto       := {}
	LOCAL aDadRda		:= {}
	LOCAL aRdaProf		:= {}
	LOCAL aMatBd6		:= {}
	LOCAL aDaSenPro		:= {}
	LOCAL aRetTuss		:= {}
	LOCAL aRetAbr	  	:= {"",""}
	LOCAL aRetTrE	  	:= {.T.}
	LOCAL aRetTrS	  	:= {.T.}
	LOCAL aMatAlias   	:= {"BEA","BE2","BEG"}
	LOCAL aRetPECab     := {}
	LOCAL aHeadeB4B		:= {}
	LOCAL aColsB4B		:= {}
	LOCAL aDadTemp      := {}
	LOCAL aTpPart   	:= {}
	LOCAL aVetB4B       := {0}
	LOCAL aHeadeBQV		:= {}
	LOCAL cTipSai    := U_CBRETDAD( aDados,"TIPSAI","" )
	LOCAL cHoraSol   := U_CBRETDAD( aDados,"HORASOL","" )
	LOCAL cCarSol    := U_CBRETDAD( aDados,"CARSOL","" )
	LOCAL cNumLib    := U_CBRETDAD( aDados,"NUMLIB","" )
	LOCAL cNumSol    := IIF( EmpTy(U_CBRETDAD( aDados,"NUMSOL","" )), U_CBRETDAD( aDados,"NUMLIB","" ), U_CBRETDAD( aDados,"NUMSOL","" ))
	LOCAL cLotGui    := U_CBRETDAD( aDados,"LOTGUI","" )
	LOCAL cSeqTra    := U_CBRETDAD( aDados,"SEQTRA","" )
	LOCAL cPadCon	 := U_CBRETDAD( aDados,"PADCON","" )
	LOCAL cPadInt	 := U_CBRETDAD( aDados,"PADINT",GetNewPar("MV_PLPADIN","01") )
	LOCAL cMatric    := U_CBRETDAD( aDados,"USUARIO","" )
	LOCAL cOpeMov    := U_CBRETDAD( aDados,"OPEMOV","" )
	LOCAL cCidPri    := U_CBRETDAD( aDados,"CIDPRI","" )
	LOCAL cCodRda    := U_CBRETDAD( aDados,"CODRDA","" )
	LOCAL cRdaEdi    := U_CBRETDAD( aDados,"RDAEDI","" )
	LOCAL cNomEdi    := U_CBRETDAD( aDados,"NOMEDI","" )
	LOCAL cCodRdaPro := U_CBRETDAD( aDados,"RDAPRO",cCodRda )
	LOCAL cOpeSol    := U_CBRETDAD( aDados,"OPESOL","" )
	LOCAL cCDPFSO    := U_CBRETDAD( aDados,"CDPFSO","" )
	LOCAL cCodEsp    := U_CBRETDAD( aDados,"CODESP","" )
	LOCAL cNumImp    := U_CBRETDAD( aDados,"NUMIMP","" )
	LOCAL cCodLoc    := U_CBRETDAD( aDados,"CODLOC","" )
	LOCAL cCodLocPro := U_CBRETDAD( aDados,"LOCPRO","" )
	LOCAL cViaCartao := U_CBRETDAD( aDados,"VIACAR","" )
	LOCAL cTipoMat   := U_CBRETDAD( aDados,"TIPOMAT","" )
	LOCAL cCodPRFExe := U_CBRETDAD( aDados,"CDPFEX","" )
	LOCAL cCpfExe 	 := U_CBRETDAD( aDados,"CPFEXE","" )
	LOCAL cCnesExe 	 := U_CBRETDAD( aDados,"CNESEXE","" )
	LOCAL cOpeExe    := U_CBRETDAD( aDados,"CDOPEX","" )
	LOCAL cNomUsrCar := U_CBRETDAD( aDados,"NOMUSR","" )
	LOCAL cNrSeqTR   := U_CBRETDAD( aDados,"NRTRAN","" )
	LOCAL cTipPre    := U_CBRETDAD( aDados,"TPPRES","" )
	LOCAL cAreaAbr   := U_CBRETDAD( aDados,"AREAABR","" )
	LOCAL cNumAut    := U_CBRETDAD( aDados,"NUMAUT","" )
	LOCAL cNumPeg    := U_CBRETDAD( aDados,"NUMPEG","" )
	LOCAL cTipFat    := U_CBRETDAD( aDados,"TIPFAT","" )
	LOCAL cTipGui	 := U_CBRETDAD( aDados,"TIPGUI","" )
	LOCAL cTipInt    := U_CBRETDAD( aDados,"TIPINT",GetNewPar("MV_PLTPINT","01") )
	LOCAL cGrpInt 	 := U_CBRETDAD( aDados,"TPEVEN","1" )
	LOCAL cIndAci	 := U_CBRETDAD( aDados,"INDACI","" )
	LOCAL nQtNasV 	 := U_CBRETDAD( aDados,"QTNASV",0 )
	LOCAL nQtNasM	 := U_CBRETDAD( aDados,"QTNASM",0 )
	LOCAL nQtNasP	 := U_CBRETDAD( aDados,"QTNASP",0 )
	LOCAL nQtObtP	 := U_CBRETDAD( aDados,"QTOBTP",0 )
	LOCAL nQtObAR	 := U_CBRETDAD( aDados,"QTOBAR",0 )
	LOCAL cCidObt	 := U_CBRETDAD( aDados,"CIDOBT","" )
	LOCAL cNrdCob 	 := U_CBRETDAD( aDados,"NRDCOB","" )
	LOCAL cObtMul 	 := U_CBRETDAD( aDados,"OBTMUL","" )
	LOCAL cTipAlt 	 := U_CBRETDAD( aDados,"TIPALT","" )
	LOCAL cNrdCnv 	 := U_CBRETDAD( aDados,"NRDCNV","" )
	LOCAL cUndDoe    := U_CBRETDAD( aDados,"UNDDOE","" )
	LOCAL nTmpDoe    := U_CBRETDAD( aDados,"TMPDOE",0 )
	LOCAL cTipDoe    := U_CBRETDAD( aDados,"TIPDOE","" )
	LOCAL cTranOS    := U_CBRETDAD( aDados,"TRANORDSERV","" )
	LOCAL cOpeSolOS  := U_CBRETDAD( aDados,"OPESOLOS","" )
	LOCAL aUnMed     := U_CBRETDAD( aDados,"AUNMED",{} )
	LOCAL aTpParG    := U_CBRETDAD( aDados,"ATPARG",{} )
	LOCAL cTipo      := U_CBRETDAD( aDados,"TIPO","1" )
	LOCAL cCnpjSolT  := U_CBRETDAD( aDados,"CGCSOLT","" )
	LOCAL nValTot	 := U_CBRETDAD( aDados,"VALTOT",0 )
	LOCAL cIndCli    := U_CBRETDAD( aDados,"INDCLI","" )
	LOCAL cNumPre	 := U_CBRETDAD( aDados,"NUMPRE","" )
	LOCAL cArqImp	 := U_CBRETDAD( aDados,"ARQIMP","" )
	LOCAL cTipAdm  	:= U_CBRETDAD( aDados,"TIPADM",Iif(cCarSol=="U",SubStr( GetNewPar("MV_PLSCDIU","4,5") ,1,1),GetNewPar("MV_PLSTPAD","CARSOL") ) )
	LOCAL cRegint  	:= U_CBRETDAD( aDados,"REGINT","" )
	LOCAL cOpeInt   := U_CBRETDAD( aDados,"OPEINT","" )
	LOCAL cObsEvo   := U_CBRETDAD( aDados,"OBSEVO","" )
	LOCAL cNrOpe1100:= U_CBRETDAD( aDados,"NRAOPE1100","" )
// Logica
	LOCAL lRegras    := U_CBRETDAD( aDados,"CHKREG",.T. )
	LOCAL lRegPagAto := U_CBRETDAD( aDados,"LREGPAGATO",.T. )
	LOCAL lReanaliza := U_CBRETDAD( aDados,"LVALOR",.F. )
	LOCAL lRetVPF    := U_CBRETDAD( aDados,"LRETVPF",.F. )
	LOCAL lIncAutIE  := U_CBRETDAD( aDados,"INCAUTIE",.F. )
	LOCAL lVeioComu  := U_CBRETDAD( aDados,"LVEIOCOMU",.F. )
	LOCAL lAudEmp    := U_CBRETDAD( aDados,"AUDEMP",.F. )
	LOCAL lForcAud   := U_CBRETDAD( aDados,"FORCAUD",.F. )
	LOCAL lFAudMOP   := U_CBRETDAD( aDados,"FAUDMOP",.F. )
	LOCAL lFAudAte   := U_CBRETDAD( aDados,"FAUDATE",.F. )
	LOCAL lPacAudi   := U_CBRETDAD( aDados,"PACAUDI",.F.)
	LOCAL lInter     := U_CBRETDAD( aDados,"INTERN",.F. )
	LOCAL lPtuOnline := U_CBRETDAD( aDados,"PTUONLINE",.F.) //Recebendo uma Solicitacao PTU Online pelo PLSTRTPTUSCS2
	LOCAL lEvolu     := U_CBRETDAD( aDados,"EVOLU",.F. )
	LOCAL lEvoSADT   := U_CBRETDAD( aDados,"EVOSADT",.F. )
	LOCAL lHonor     := U_CBRETDAD( aDados,"HORIND",.F. )
	LOCAL lResInt    := U_CBRETDAD( aDados,"RESINT",.F. )
	LOCAL lAutoCus   := U_CBRETDAD( aDados,"ALTOCUS",.F. )
	LOCAL lGerSenha  := U_CBRETDAD( aDados,"GERSEN",.F. )
	LOCAL lWeb 		 := U_CBRETDAD( aDados,"RPC", ( U_CBRETDAD( aDados,"TPGRV","1" ) == "2" ) )
	LOCAL lNMudFase  := U_CBRETDAD( aDados,"LNMUDF", ( GetNewPar("MV_PLMFSG",'1') == '0' )  )
	LOCAL lUnimeds   := IiF( AllTrim( GETNEWPAR("MV_PLSUNI","1") )=="1", .T. , .F. )
	LOCAL lIncNeg	 := NIL
	LOCAL lLoadRda   := Iif( lImpXml .or. lImpTxt , IiF( AllTrim( GETNEWPAR("MV_PLSLDRD","0") )=="1",.T.,.F. ) , .F.)
	LOCAL lPtuA1100  := U_CBRETDAD( aDados,"PTUA1100",.F. )

	LOCAL dDatNasUsr := U_CBRETDAD( aDados,"DATNAS",CtoD("") )
	LOCAL dDataSol   := U_CBRETDAD( aDados,"DATASOL",CtoD("") )
	LOCAL dDtAlta    := U_CBRETDAD( aDados,"DTALTA",CtoD("") )
	LOCAL cHrAlta    := U_CBRETDAD( aDados,"HRALTA","" )
	LOCAL dDtIniFat  := U_CBRETDAD( aDados,"DTINIFAT",CtoD("") )
	LOCAL cHrIniFat  := U_CBRETDAD( aDados,"HRINIFAT","" )
	LOCAL dDtFimFat  := U_CBRETDAD( aDados,"DTFIMFAT",CtoD("") )
	LOCAL cHrFimFat  := U_CBRETDAD( aDados,"HRFIMFAT","" )
	LOCAL dDatPro    := U_CBRETDAD( aDados,"DATPRO", dDtIniFat)
	LOCAL cHora      := U_CBRETDAD( aDados,"HORAPRO","" )
	LOCAL cMsg01     := U_CBRETDAD( aDados,"MSG01","" )
	LOCAL cMsg02	 := U_CBRETDAD( aDados,"MSG02","" )
	LOCAL cMsg03	 := U_CBRETDAD( aDados,"MSG03","" )
	LOCAL cTipoAte   := Iif(!empty(U_CBRETDAD( aDados,"TIPATE","" )),StrZero( Val( U_CBRETDAD( aDados,"TIPATE","" ) ),2 ),U_CBRETDAD( aDados,"TIPATE","" ))
	LOCAL cOrigem    := U_CBRETDAD( aDados,"ORIGEM","1" )
	LOCAL cCodLDP   	:= U_CBRETDAD( aDados,"CODLDP",IIF(U_CBDigGuia(),GetNewPar("MV_PLSDIGP","9999"),IIF(PLSOBRPRDA(cCodRda),IIF(lImpTxt,U_CBRETLDP(3),U_CBRETLDP(9)),GetNewPar("MV_PLSPEGE","0000"))) )
	LOCAL cOriMov 	 := Iif( cTipo = "3", "2","1" )
	LOCAL lSolicit	 := (cOrigem == "2")	//indica se eh solicitacao, na solicitacao nao valoriza a guia
	LOCAL cCodEspPro := cCodEsp
	LOCAL lRdaProf	 := ( cCodRda <> cCodRdaPro )
	LOCAL lForBlo    := U_CBRETDAD( aDados,"FORBLO",.F. )
	LOCAL ctippac    := BEA->BEA_TIPPAC
	LOCAL aTipPart   := U_CBRETDAD( aDados,"TIPPAR",If(FindFunction('PlRConTPA'),PlRConTPA(),{}) )
	LOCAL aCodProcs  := {}
	LOCAL cEmgest 	 := U_CBRETDAD( aDados,"EMGEST","0" )
	LOCAL cAborto 	 := U_CBRETDAD( aDados,"ABORTO","0" )
	LOCAL cPrvQui 	 := U_CBRETDAD( aDados,"PRVQUI","" )
	LOCAL cPrvOpm 	 := U_CBRETDAD( aDados,"PRVOPM","" )
	LOCAL cTraGra 	 := U_CBRETDAD( aDados,"TRAGRA","0" )
	LOCAL cComurp 	 := U_CBRETDAD( aDados,"COMURP","0" )
	LOCAL cAtespa  	 := U_CBRETDAD( aDados,"ATESPA","0" )
	LOCAL cComnal 	 := U_CBRETDAD( aDados,"COMNAL","0" )
	LOCAL cBaipes 	 := U_CBRETDAD( aDados,"BAIPES","0" )
	LOCAL cPaareo 	 := U_CBRETDAD( aDados,"PAAREO","0" )
	LOCAL cPatnor 	 := U_CBRETDAD( aDados,"PATNOR","0" )
	LOCAL cEspSol 	 := U_CBRETDAD( aDados,"ESPSOL","" )
	LOCAL cTipCon 	 := U_CBRETDAD( aDados,"TIPCON","" )
	LOCAL dDatAcat	 := U_CBRETDAD( aDados,"DATACA",dDataBase )
	LOCAL cEspExe	 := U_CBRETDAD( aDados,"ESPEXE","" )
	LOCAL lGuiHoRe	 := lHonor .or. lResInt
	LOCAL cAteRN   	 := U_CBRETDAD( aDados,"ATENRN","0" )
	LOCAL cFase		 := U_CBRETDAD( aDados,"FASE","1" )
	LOCAL cSituac	 := U_CBRETDAD( aDados,"SITUAC",If(IsInCallStack("proconline"),If(GetNewPar("MV_PLBQGUI",.F.),'3','1'),'1') ) // Determina que na importação do arquivo Tiss atraves de webservice(TISS on Line) se as guias entrarão bloqueadas.
	LOCAL cGuiOri	 := U_CBRETDAD( aDados,"GUIORI","" )
	LOCAL cGuiPr	 := U_CBRETDAD( aDados,"GUIPR","" )
	LOCAL cCnes      := U_CBRETDAD( aDados,"CNES","" )
	LOCAL lPTUOnOS   := U_CBRETDAD( aDados,"PTUONOS",.F. )
	LOCAL cStProc	 := ""
	LOCAL dDatRet	 := stod('')
	LOCAL lOkVerPTU  := .T.
	LOCAL lCriAutPTU := .F.
	LOCAL cSituacPTU := ""
	LOCAL lCriTime   := .F.
	LOCAL lPTUOnSol  := .F. //Indica se e umA solicitacao do PTU Online no Portal do Prestador
	LOCAL cAutori    := ""
	LOCAL nIteLibPTU := 0
	LOCAL dDtRlz     := U_CBRETDAD( aDados,"DTRLZ",CtoD("") )
	LOCAL dDtRlz2    := U_CBRETDAD( aDados,"DTRLZ2",CtoD("") )
	LOCAL dDtRlz3    := U_CBRETDAD( aDados,"DTRLZ3",CtoD("") )
	LOCAL dDtRlz4    := U_CBRETDAD( aDados,"DTRLZ4",CtoD("") )
	LOCAL dDtRlz5    := U_CBRETDAD( aDados,"DTRLZ5",CtoD("") )
	LOCAL dDtRlz6    := U_CBRETDAD( aDados,"DTRLZ6",CtoD("") )
	LOCAL dDtRlz7    := U_CBRETDAD( aDados,"DTRLZ7",CtoD("") )
	LOCAL dDtRlz8    := U_CBRETDAD( aDados,"DTRLZ8",CtoD("") )
	LOCAL dDtRlz9    := U_CBRETDAD( aDados,"DTRLZ9",CtoD("") )
	LOCAL dDtRlz1    := U_CBRETDAD( aDados,"DTRLZ1",CtoD("") )
	LOCAL lFindNewUs := .F.
	LOCAL aRetUsrInt := {}
	LOCAL cNewAut    := U_CBRETDAD( aDados,"NEWAUT","" )
	LOCAL lnInfEquip := U_CBRETDAD( aDados,"NINFEQ",.F. ) //INDICA SE FOI INFORMADA EQUIPE PARA O PROCEDIMENTO
	Local lXmlOrigS	 := U_CBRETDAD( aDados,"XMLORIY",.F. ) //origem XML
	LOCAL nI1		 := 0
	LOCAL nI2		 := 0
	LOCAL aCampCust  := {}
	LOCAL cNomExec   := ""
	LOCAL cProtoc   	:= U_CBRETDAD( aDados,"PROTOC","" )
	LOCAL cGuiJur		:= U_CBRETDAD( aDados,"ID_LIMINAR","" )
	LOCAL aDadB4Q    	:= {}
	LOCAL aChaveGen		:= {}
	local cSexo 		:= ""
	local cTipGuiaOriginal := ""
	LOCAL aEspCbXML		:= U_CBRETDAD( aDados,"ESPXML",{})
	Local cGuiPri 		:= U_CBRETDAD( aDados,"GUIPRI","" )
	Local cNuLibera     := cNumLib
	Local nQtdDiSol 	:= U_CBRETDAD( aDados,"QDISOL",0)
	Local lPossuiProcDiaria := .F.
	LOCAL lProRadio 		:= .F.
	Local lNovaLib 			:= .F.
	Local 	lAudi :=.F.
	LOCAL nRecGer	:= 0
	PRIVATE Inclui	 := .T.

	If FindFunction('PGetTisVer') .and. PGetTisVer() >= '3' .And. !Empty(cCarSol)
		cTipAdm := cCarSol
	EndIf

	if cTipGui = '11'
		cTipGui := '03'
		cTipGuiaOriginal := '11'
		lNovaLib := .T.
	endif

// Tratamento para inclusão de procedimentos negados na guia
	lIncNeg := getNewPar("MV_PLSINEG", .T.)
	If ValType("lIncNeg") == "U"
		lIncNeg := Iif( lImpXml .or. lImpTxt , (PLSPOSGLO(PLSINTPAD(),__aCdCri158[1],__aCdCri158[2]) .And. PLSCHKCRI( {'BAU',cCodRda,__aCdCri158[1]} ) ) , .F. )
	Endif


// PE para gravacao de campos customizados nas guias do portal
	If lWeb .and. ExistBlock("PPLMGCB2")
		aCampCust := ExecBlock("PPLMGCB2",.F.,.F.,{cTipGui,aDados,aItens} )
	Endif

// Inicio
	nHoraBase := Seconds()
	cHoraBase := Time()
// Tratamento Importacao XML sempre vai entrar aqui
	If lImpXml .or. lImpTxt

	// Desabilita o log.
		lWLIO	 := .f.
		lAtuPeg := iIf(lImpXml,.f.,lImpTxt) //quando eh importacao xml nao atualizo os totais
	
	///caso não tem itens não importa a guia
		If Len(aItens) == 0
			AaDd(aMatInf, {'NAO HÁ PROCEDIMENTOS NA GUIA', 'NIL' } )
			AaDd(aMatInf, {'NUM. GUIA PRESTADOR ', cNumImp } )
		
			aRetorno := {.F.,;								//1
			cAutRet,; 							//2
			"",;								//3
			aCriticas,;                         //4
			aEventosAut,;                       //5
			aEventosNeg,;                       //6
			nVlrTPF,;                           //7
			cRetCriMv,;                         //8
			cMsgClient,;                        //9
			aMatInf,;                           //10
			lAto,;								//11
			dDPrAH,;                            //12
			AllTrim( Str(nQtdDiAut) ),;         //13
			Iif(lGerSenha,dDatRet,CtoD("")) }	//14
					
			Return(aRetorno)
		endif
	
		If cTipGui $ "01#02#06#04"
			cNumGuiH := U_CBICM(cOpeMov,cMatric,cTipoGrv,cLocalExec,cCDPFSO,cCodPRFExe,dDatPro,cHora,cNumImp,cCodRda,cCodLDP,; //11
			cTipo,cCodLoc,cCodEsp,cTipGui,cCidPri,nQtNasV,nQtNasM,nQtNasP,nQtObtP,nQtObAR,cTipFat,cCidObt,cNrdCob,; //24
			cObtMul,cTipAlt,cNrdCnv,cLotGui,aItens,cArqImp,cNumLib,aTipPart,"BD5",lHonor,'1',cNumSol,nil,lAtuPeg,; //38
			nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,cTipSai,cTipCon,cNomUsrCar,dDatAcat,cTipoAte,cGrpInt,; //56
			cTipInt,cIndAci,cUndDoe,nTmpDoe,cTipDoe,cMsg01,cMsg02,cEspSol,cEspExe,cTipAdm,cRegint,cCarSol,aItens,cAteRN,; //70
			lImpTxt,cFase,cSituac,cGuiOri,cCnes,aCriticas,,,,,lnInfEquip, lXmlOrigS, aEspCbXML, cGuiPri, lImpXml) //85
		Endif
	
		If cTipGui $ "03#05"
			cNumGuiH := U_CBICM(cOpeMov,cMatric,cTipoGrv,cLocalExec,cCDPFSO,cCodPRFExe,dDatPro,cHora,cNumImp,cCodRda,cCodLDP,;
				cTipo,cCodLoc,cCodEsp,cTipGui,cCidPri,nQtNasV,nQtNasM,nQtNasP,nQtObtP,nQtObAR,cTipFat,cCidObt,cNrdCob,;
				cObtMul,cTipAlt,cNrdCnv,cLotGui,aItens,cArqImp,cNumLib,aTipPart,"BE4",.F.,'2',cNumSol,nil,lAtuPeg,;
				cPadCon,dDtAlta,cHrAlta,cEmgest,cAborto,cTraGra,cComurp,cAtespa,cComnal,cBaipes,cPaareo,cPatnor,cTipSai,;
				cTipCon,cNomUsrCar,dDatAcat,cTipoAte,cGrpInt,cTipInt,cIndAci,cUndDoe,nTmpDoe,cTipDoe,cMsg01,cMsg02,cEspSol,;
				cEspExe,cTipAdm,cRegint,cCarSol,aItens,cAteRN,lImpTxt,cFase,cSituac,cGuiOri,cCnes,aCriticas,dDtIniFat,cHrIniFat,;
				dDtFimFat,cHrFimFat,lnInfEquip, lXmlOrigS, aEspCbXML, cGuiPri, lImpXml)
		Endif
	Else
		BA1->( DbSetOrder(2) ) //BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
		If  !BA1->( MsSeek( xFilial("BA1")+AllTrim(cMatric) ) )
			BA1->( DbSetOrder(5) )//BA1_FILIAL + BA1_MATANT + BA1_TIPANT
			If !BA1->( MsSeek( xFilial("BA1")+AllTrim(cMatric) ) )
			// Verifico se cadastro usuario de intercambio
				If lUnimeds .And. Substr(cMatric,1,4) <> PlsIntPad() .And. (lSolicit .Or. lPTUOnOS) .And. len(cMatric) == 17
				
					aRetUsrInt := PLSA235(.F./*lMsgNovaMat*/,cMatric,/*lInterGen*/,.T./*lIncAuto*/,cNomUsrCar,/*dDatNasUsr*/,.T./*lRPC*/,/*cSexo*/,.T./*lIncWeb*/,/*lChkCon*/,.T.)
				
					If aRetUsrInt[1]
						BA1->( DbSetOrder(2) )
						If BA1->(DbSeek(xFilial("BA1")+aRetUsrInt[2]))
							cMatric := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
							lFindNewUs := .T.
						EndIf
					EndIf
				EndIf
				If !lFindNewUs
					If PLSPOSGLO(PLSINTPAD(),__aCdCri159[1],__aCdCri159[2],cLocalExec,'1',cTipoGrv)
						PXMLUsrGe(cOpeMov)
					Else
						lContinua := .F.
						U_CBMONCRI(aItens,{},.F.,__aCdCri159[1],PLSBCTDESC(),,aCriticas,aEventosNeg)
					Endif
				EndIf
			EndIf
		EndIf
	
		If lContinua
			aRetFun := PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase)
			If aRetFun[1]
				cMatric := AllTrim(aRetFun[2])
			EndIf
			aDadUsr := PLSGETUSR()
		Endif
	
		If FindFunction("PLLimpCCri")
			PLLimpCCri(.T.)
		EndIf
	// Inicio da checagem
		If ! lIncAutIE .And. GetNewPar("MV_PLSIAIE","0") == "1"
			lIncAutIE := .T.
		Endif
	// Se for solicitacao
	
		If cOrigem == "2"
			dDataSol := dDatPro
			cHoraSol := cHora
		Endif
	// Se solicitacao de Ptu Online, inclui guia negada
		If lPtuOnline
			lIncNeg := .t.
		EndIf
	// Ordem do BR8
		BR8->( DbSetOrder(1) ) //BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN
	// Ajusta a descricao e tpproc dos itens
	
		For nFor := 1 To Len(aItens)
			cSeqMov := U_CBRETDAD(aItens[nFor],"SEQMOV")
			cCodPad := U_CBRETDAD(aItens[nFor],"CODPAD")
			cCodPro := U_CBRETDAD(aItens[nFor],"CODPRO")
			nVlrApr	:= U_CBRETDAD(aItens[nFor],"VLRAPR",0)
			nVAprTot+= nVlrApr
		// Br8
			BR8->(DbSetOrder(1))
			If BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) )
				If BR8->( FieldPos("BR8_DATINC") ) > 0
					U_CBPUTDAD(aItens[nFor],"DATINC",BR8->BR8_DATINC,.T.)
				EndIf
				U_CBPUTDAD(aItens[nFor],"NIVEL",BR8->BR8_NIVEL,.T.)
			
				If !Empty(U_CBRETDAD(aItens[nFor],"DESCOPME")) // Retorno de alteração PTU
					U_CBPUTDAD(aItens[nFor],"DESCRI",(U_CBRETDAD(aItens[nFor],"DESCOPME")),.T.)
				Else
					U_CBPUTDAD(aItens[nFor],"DESCRI",BR8->BR8_DESCRI,.T.)
				EndIf
				U_CBPUTDAD(aItens[nFor],"TPPROC",BR8->BR8_TPPROC,.T.)
				U_CBPUTDAD(aItens[nFor],"TIPEVE",BR8->BR8_TIPEVE,.T.)
			
				if BR8->BR8_TPPROC = "4"
					lPossuiProcDiaria := .T.
				endif
			Else
			//o sistema somente vai entar aqui quando for TISSONLINE de um codigo que nao
			//existe na tabela padrao vou pegar o codigo de procedimento generico
				U_CBPUTDAD(aItens[nFor],"DESCRI","PROCEDIMENTO INEXISTENTE",.T.)
				BR8->(DbSetOrder(3))
				If BR8->( MsSeek(xFilial("BR8")+alltrim(GetNewPar("MV_PLPSPXM","99999994"))) )
					If BR8->( FieldPos("BR8_DATINC") ) > 0
						U_CBPUTDAD(aItens[nFor],"DATINC",dDataBase,.T.)
					EndIf
					U_CBPUTDAD(aItens[nFor],"NIVEL",BR8->BR8_NIVEL,.T.)
					U_CBPUTDAD(aItens[nFor],"TPPROC",BR8->BR8_TPPROC,.T.)
					U_CBPUTDAD(aItens[nFor],"TIPEVE",BR8->BR8_TIPEVE,.T.)
				Endif
			Endif
		// Verifica se a tabela informada esta no parametro
			If cCodPad $ GetNewPar("MV_PLSTRCO","ZZ")
		
				cCodPro := U_CBRETDAD(aItens[nFor],"CODPRO")
				cDente  := U_CBRETDAD(aItens[nFor],"DENTE","")
				cFace   := U_CBRETDAD(aItens[nFor],"FACE","")
		
			// Troca as informacoes
				BR8->( DbSetOrder(5) ) //BR8_FILIAL + BR8_CODEDI
				If BR8->( MsSeek(xFilial("BR8")+cCodPro) )
					AaDd(aMatTroca,{cSeqMov,cCodPad,cCodPro,BR8->BR8_CODPSA,cDente,cFace} )
					U_CBPUTDAD(aItens[nFor],"CODPRO",BR8->BR8_CODPSA)
				EndIf
			
			EndIf
		Next
	// Monta os dados solicitados em uma matriz que nao sera alterada.
	// O objetivo e ter em uma unica matriz os procedimentos e suas respectivas
	// quantidades solicitadas e a partir disso trabalhar autorizacoes parciais
	// a partir de uma liberacao original.
		If lContinua .And. !lResInt
	
			For nFor := 1 To Len(aItens)
				cSeqMov := U_CBRETDAD(aItens[nFor],"SEQMOV")
				cCodPad := U_CBRETDAD(aItens[nFor],"CODPAD")
				cCodPro := U_CBRETDAD(aItens[nFor],"CODPRO")
				cDescri	:= U_CBRETDAD(aItens[nFor],"DESCRI","")
				nQtdSol := U_CBRETDAD(aItens[nFor],"QTD",0)
				nQtdAut := U_CBRETDAD(aItens[nFor],"QTDAUT",0)
				cTpProc	:= U_CBRETDAD(aItens[nFor],"TPPROC","")
				cDente  := U_CBRETDAD(aItens[nFor],"DENTE","")
				cFace   := U_CBRETDAD(aItens[nFor],"FACE","")
				cStProc := U_CBRETDAD(aItens[nFor],"STPROC","")
			
			// Itens
				AaDd( aAutItens,{cSeqMov,;	//[1]  cSeqMov  -> Sequencia do evento
				cCodPad,;	//[2]  cCodPad  -> Tipo Codigo Procedimento
				cCodPro,;	//[3]  cCodPro  -> Codigo do Procedimento
				nQtdSol,;	//[4]  nQtdSol  -> Quantidade do Procedimento
				0,;			//[5]  zero     -> Sera a diferenca entre qual quantidade tinha sido liberada (saldo) - a quantidade que foi solicitada na autorizacao corrente
				.T.,;		//[6]  Status(L)-> Valor logico se este item sera retirado da liberacao original ou nao
				0,;			//[7]  Recno    -> Recno do registro BE2 relacionado a liberacao original
				.F.,;		//[8]  lColsDel -> Indica se um item do aCols que foi solicitado nao podera ser autorizado ou nao
				nQtdAut,;	//[9]  nQtdAut	-> Quantidade Autorizada
				.F.,;		//[10] XXX 		-> Indica se um item ja foi executado anteriormente
				.F.,;		//[11] XXX 		-> Indica se um item existe na liberacao
				.F.,;		//[12] XXX 		-> Indica se o item pode ser executado pelo executante
				cTpProc,;	//[13] cTpProc	-> Tipo do procedimento
				cDescri,;  	//[14] cDescri	-> Descricao do procedimento
				cDente,;   	//[15] cDente	-> Dente
				cFace,;		//[16] cFace	-> Face
				cStProc} )	//[17] cStatus	-> Status
			
				If !lHonor .And. !lResInt .and. !Empty(cTpProc) .and. (AllTrim(cTpProc) $ AllTrim( GetNewPar("MV_PLSOPMM","0,1,2,3,4,5,6,7,8,9")))
					AaDd( aMatOPMM,{cSeqMov,cCodPad,cCodPro,nQtdSol,0,.T.,0,.T.,nQtdAut} )
					lOPMM := .T.
				Endif
			Next
		EndIf
	// Tratamento para o usuario
		If !lResInt
			If lContinua
				aRetFun := u_CBUSUATE(@cMatric,cLocalExec,cHora,cViaCartao,cTipoMat,cNomUsrCar,cTipoGrv,aItens,;
					aCriticas,aEventosNeg,aMatInf,dDatPro,dDatNasUsr,lResInt,lHonor,lIncAutIE,.f.)
								
				lContinua := aRetFun[1]
				lMatGer   := aRetFun[2]
				lUsuGer   := aRetFun[3]
				cMatUsa   := aRetFun[4]
				cOpeOri	  := aRetFun[5]
				cRetGui	  := aRetFun[6]
				cSomInt	  := aRetFun[7]
				aDadUsr	  := aRetFun[8]
				lCriMatInv:= aRetFun[9]
			
				If lCriMatInv .And. lPtuOnline
					PlsPtuPut("MSG01","Matricula informada: "+U_CBRETDAD( aDados,"CD_UNI","" )+U_CBRETDAD( aDados,"ID_BENEF","" ),aDados)
				Endif
			// Tratamento para rede de atendimento contratado e o profissional
				If lContinua
					aRetFun := u_CBREDATE(cOpeMov,cCodRda,cCodRdaPro,@cCodLoc,@cCodLocPro,@cCodEsp,@cCodEspPro,dDatPro,;
						aItens,aDadIte,aCriticas,aEventosNeg,aDadUsr,cLibEsp,cAuditoria,cOrigem,;
						cNumImp,lLoadRda,lRdaProf,lIncNeg)
									
					lContinua 	:= aRetFun[1]
					cLocal  	:= aRetFun[2]
					cDesLoc  	:= aRetFun[3]
					cDesLocPro 	:= aRetFun[4]
					nRecBAU	    := aRetFun[5]
					aDadRda 	:= aRetFun[6]
					aRdaProf  	:= aRetFun[7]
					lTrtExe		:= aRetFun[8]
					lTrtCCl		:= Iif( lSolicit,.F.,Iif(Len(aDadRDA)>0,Iif(aDadRDA[23]!='1',.F.,.T.),.F.) )
				EndIf
			EndIf
		// Identifica o primeiro item passado no aItens
			If lContinua
				If Len(aItens) > 0
					cSeqMov   := U_CBRETDAD(aItens[1],"SEQMOV")
					cCodPad   := U_CBRETDAD(aItens[1],"CODPAD")
					cCodPro   := U_CBRETDAD(aItens[1],"CODPRO")
					nQtdSol   := U_CBRETDAD(aItens[1],"QTD",0)
					nQtdAut   := U_CBRETDAD(aItens[1],"QTDAUT",0)
					cDente    := U_CBRETDAD(aItens[1],"DENTE","")
					cFace     := U_CBRETDAD(aItens[1],"FACE","")
					cStProc   := U_CBRETDAD(aItens[1],"STPROC","")
				
					lConsulta := PLSISCON(cCodPad,cCodPro) .And. Len(aItens) == 1
					If Empty(cTipGui)
						cTipGui   := If(!lConsulta,GetNewPar("MV_PLSTPGS","02"),GetNewPar("MV_PLSTPGC","01"))
					Endif
				Else
					lContinua := .F.
				EndIf
			// PTU Online carrega informacao pois precisa gerar a guia
			ElseIf lPtuOnline .And. Len(aItens) == 1
				lConsulta := PLSISCON(U_CBRETDAD(aItens[1],"CODPAD"),U_CBRETDAD(aItens[1],"CODPRO"))
			EndIf
		// PTU Online preciso forcar o TipGuia
			If lPtuOnline .And. Empty(cTipGui)
				cTipGui  := If(!lConsulta,GetNewPar("MV_PLSTPGS","02"),GetNewPar("MV_PLSTPGC","01"))
			EndIf
		// 1=Autorizacao SADT;2=Liberacao;4=Autorizacao Odontologica
			If lContinua .and. cOrigem <> "2" .and. !Empty(cNumLib) .and. Len(aDadUsr)>0 .and. !lEvolu .and. !lInter
			// Verficia se exite procedimento de liberacao
				aRetLib := PLSRETAULI(cMatric,cNumLib,Iif(cTipo=='2' .And. lWeb,'A','L'),cCodRdaPro,cCodLocPro,cCodEspPro,cCodPRFExe,cLocalExec,lWeb,aRdaProf,aDadUsr,cTipo,cEspSol,cEspExe)
			
			//se o parametro estiver igual a '0' significa que eu trato na execução de uma liberação somente se o profissional
			//executante complementar(se ele for uma rda) pode ou nao executar um procedimento.
			//se o parametro estiver igual a '1' significa que eu trato na execução de uma liberação alem do profissional executante tambem se
			//o contratado executante pode ou nao executar um procedimento
				aSlvRtLb := aClone(aRetLib)
			
				If GetNewPar('MV_PLTREXC','0') == '1' .and. !aRetLib[1]
					aRetLib := PLSRETAULI(cMatric,cNumLib,'L',cCodRda,cCodLoc,cCodEsp,cCodPRFExe,cLocalExec,lWeb,aDadRda,aDadUsr,cTipo,cEspSol,cEspExe)
					If !aRetLib[1]
						aRetLib := aClone(aSlvRtLb)
					Endif
				Endif
			
				BAU->( DbGoTo(nRecBAU) )
			
			// Retorna o conteudo original da rda contratada para a aDadRDA statica
				PLSCLORDA(aDadRda)
			
				If aRetLib[1]
				// Ajusta os niveis na matriz item
					For nFor := 1 To Len(aItens)
					
						cSeqMov := U_CBRETDAD(aItens[nFor],"SEQMOV")
						cCodPad := U_CBRETDAD(aItens[nFor],"CODPAD")
						cCodPro := U_CBRETDAD(aItens[nFor],"CODPRO")
						cDente  := U_CBRETDAD(aItens[nFor],"DENTE","")
						cFace   := U_CBRETDAD(aItens[nFor],"FACE","")
					
						If ( nPos := Ascan( aRetLib[4],{|x| x[2]+x[3]+x[4]+x[24]+x[25] == cSeqMov+cCodPad+cCodPro+cDente+cFace } ) ) > 0
							U_CBPUTDAD(aItens[nFor],"NIVAUT",aRetLib[4,nPos,15],.T.)
							U_CBPUTDAD(aItens[nFor],"NIVCRI",aRetLib[4,nPos,16],.T.)
							U_CBPUTDAD(aItens[nFor],"CHVNIV",aRetLib[4,nPos,17],.T.)
						EndIf
					Next
				
				// Se for liberacao
					For nFor := 1 To Len(aAutItens)
						cSeqMov   := aAutItens[nFor,1]
						cCodPad   := aAutItens[nFor,2]
						cCodPro   := aAutItens[nFor,3]
						nQtdSol   := aAutItens[nFor,4]
						nQtdAut   := aAutItens[nFor,9]
						cDente    := aAutItens[nFor,15]
						cFace     := aAutItens[nFor,16]
						cStProc   := aAutItens[nFor,17]
					// Verifica se o procedimento foi encontrado e se e permitido para o executante
					// So e possivel a verificacao da sequancia quando o array de itens nao foi
					// alterado no portal.
					// Caso seja necessario a verificacao da sequencia qdo o procedimento e excluido
					// sera necessario alteracao no java script que faz a exclusao no portal.
						If Len(aRetLib[4]) ==  Len(aAutItens) .and. Len(aAutItens) != 1
							nPos := Ascan( aRetLib[4],{|x| x[2]+x[3]+x[4]+x[24]+x[25] == cSeqMov+cCodPad+cCodPro+cDente+cFace } )
						Else
							nPos := Ascan( aRetLib[4],{|x| x[3]+x[4]+x[24]+x[25] == cCodPad+cCodPro+cDente+cFace } )
						EndIf
					
						If nPos > 0 .And. aRetLib[4,nPos,10] == "1"
						
						// Se for um procedimento de solicitacao de internacao
							If aRetLib[4,nPos,13] > 0 .And. Empty(aRetLib[4,nPos,11])
							
								AaDd(aItensLOri,{cSeqMov,cCodPad,cCodPro,0,cDente,cFace})
							
							// Comun a todos os casos
								nLastPos			:= Len(aItensLOri)
							
								aAutItens[nFor,7] 	:= aRetLib[4,nPos,12] //Recno
								aAutItens[nFor,8]	:= .T.	//Se a quantidade for maior que a solicitada
								lAprovLib         	:= .T.
								nRecBEALIB        	:= aRetLib[7]
								cGuiaOri          	:= aRetLib[8]
							
							// Verificando o saldo
								If nQtdSol > aRetLib[4,nPos,13]
									aAutItens[nFor,5] := 0
									aAutItens[nFor,6] := .T. 		//Item nao sera excluido da liberacao original
								
									If aRetLib[4,nPos,13] == 0
										aAutItens[nFor,10] := .T. 	//Para controlar se o item ja foi executado anteriormente
									EndIf
								Else
								// Quantidade e a mesma
									If nQtdSol == aRetLib[4,nPos,13]
										aAutItens[nFor,5] := 0 		//nao existe mais saldo na liberacao original
										aAutItens[nFor,6] := .T. 	//Item sera retirado da liberacao original
									
										aItensLOri[nLastPos,4] 	:= 0
									Else
										aAutItens[nFor,5] 		:= aRetLib[4,nPos,13] - nQtdSol 	//Saldo que ficou na liberacao original
										aAutItens[nFor,6] 		:= .F. 									//Item nao sera excluido da liberacao original
									
										aItensLOri[nLastPos,4] 	:= aRetLib[4,nPos,13] - nQtdSol 	//Saldo que ficou na liberacao original
									Endif
								EndIf
							Else
								lAprovLib			:= .T.
								aAutItens[nFor,10]	:= .T. 	//Para controlar se o item ja foi executado anteriormente
								nRecBEALIB          := aRetLib[7]
								cGuiaOri            := aRetLib[8]
							EndIf
						Else
							lAprovLib 	:= .T.
							nRecBEALIB	:= aRetLib[7]
							cGuiaOri  	:= aRetLib[8]
						
							If nPos <> 0 .And. Len(aRetLib[4,nPos,14]) >= 2
							
								For nI := 1 To Len(aRetLib[4,nPos,14,2])
									If !Empty(aRetLib[4,nPos,14,2,nI,1])
										AaDd(aRetExe,{aRetLib[4,nPos,14,2,nI,1],aRetLib[4,nPos,14,2,nI,2]+Iif(Len(aRetLib[4,nPos,14,2,nI])>=3 .And. !Empty(aRetLib[4,nPos,14,2,nI,3]),' ( '+aRetLib[4,nPos,14,2,nI,3]+' ) ',''),aRetLib[4,nPos,14,2,nI,6],aRetLib[4,nPos,14,2,nI,7] } )
									EndIf
								Next
								aAutItens[nFor,12]	:= .T. 	//Se o item pode ser executado pelo executante
							Else
								aAutItens[nFor,11]	:= .T. 	//Para controlar se o item existe na liberacao
							EndIf
						EndIf
					Next
				
				ElseIf Len(aRetLib[5])>0
					U_CBMONCRI(aItens,aRetLib[5],.T.,,,,aCriticas,aEventosNeg)
				EndIf
			EndIf
		
		EndIf
	// Monta calendario de pagamento
		If lContinua
			aRetAux := PLSXVLDCAL(dDatPro,cOpeMov,.F.,cCodPad,cCodPro)
			cAno 		:= aRetAux[4]
			cMes 		:= aRetAux[5]
			lContinua  	:= aRetAux[1]
			aTrb 	   	:= aRetAux[2]
			If ! lContinua
				U_CBMONCRI(aItens,aTrb,.T.,,,,aCriticas,aEventosNeg)
			Endif
		EndIf
	// Preenche o PADINT para solicitacao de internacao XML
		If lSolicit .And. lInter .And. (lImpXml .or. lImpTxt) .And. Len(aDadUsr) > 10 // Trata aDadUsr por criticas ou por variavel em branco
			BI3->(DbSetOrder(1))//BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO
			If BI3->(DbSeek(xFilial("BI3")+PlsIntPad()+aDadUsr[11]+aDadUsr[12]))
				cPadInt := BI3->BI3_CODACO
			EndIf
		EndIf
		lContinua := ( Len(aEventosNeg) <> Len(aItens) )
	
	//Roberto-Valida Itens para verificar se Vai criticar ou não (Diária)
	
		if (lContinua .and. cTipGui = '11' .or. cTipGui = '03') .and. Len(aItens) > 0 .and. BR8->(FieldPos("BR8_QTDDIA")) > 0
			aRetFun := u_CBDIAQTD(aItens,aCriticas,aEventosNeg, cOrigem, cLibEsp, cNumImp, dDatPro, aDadRda, aDadIte, nQtdDiSol)
		endif
	
		If lContinua .And. lHonor
			lContinua  := .F.
			lReanaliza := .F.
			lFindRes   := .T.
		// Alimenta a matriz para gravacao da guia de honorario
			If lHonor
			// Monta dados do executante no honorario pego somente o primeiro pq a informacao vem no cab
				For nFor2 := 1 To Len(aItens)
					U_CBDADITE(aDadIte,aItens[nFor2],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,,"B0E")
					If Len(aTpPIte) == 0
						aTpPIte	:= U_CBRETDAD(aItens[nFor2],"ATPPAR",{})
					Else
						aTpSlvte       := U_CBRETDAD(aItens[nFor2],"ATPPAR",{})
						If Len(aTpSlvte[1])> 0
							AADD(aTpPIte, aTpSlvte[1])
						EndIf
					EndIf
				Next
			
				aRetHon := u_CBGRVHOR(cNumLib,cAno,cMes,cTipGui,lNMudFase,aDados,aDadIte,aTpPIte,aMatBd6,aUnMed,aCriticas,aItens,aEventosAut,aEventosNeg)
			EndIf
		Endif
	// Preenche o PADINT para solicitacao de internacao
		If lSolicit .And. lInter .And. Len(aDadUsr) > 10 // Trata aDadUsr por criticas ou por variavel em branco
			BI3->(DbSetOrder(1))//BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO
			If BI3->(DbSeek(xFilial("BI3")+PlsIntPad()+aDadUsr[11]+aDadUsr[12]))
				cPadInt := BI3->BI3_CODACO
			EndIf
		EndIf
	// Tratamento do resumo de internacao
		If lContinua .And. lResInt
			lContinua  := .F.
			lReanaliza := .F.
			lFindRes   := .T.
		
			Begin Transaction
			
				u_CBGRVHORE( cNumPeg,cLocalExec,cTipoGrv,dDatPro,cHora,aItens,aUnMed,'2',;
					cOpeMov,cMatric,cCDPFSO,cCodPRFExe,cNumImp,cTipPre,cCodRda,cCodLDP,;
					cTipo,cCodLoc,cCodEsp,'03',cCidPri,nQtNasV,nQtNasM,nQtNasP,nQtObtP,nQtObAR,cTipFat,;
					cCidObt,cNrdCob,cObtMul,cTipAlt,cNrdCnv,cLotGui,cArqImp,'',cNumLib,aTipPart)
			
				BE4->( RecLock("BE4",.F.) )
				If Empty(BE4->BE4_PADCON)
					BE4->BE4_PADCON := cPadCon
				Endif
				BE4->BE4_DATPRO := dDatPro
				BE4->BE4_HORPRO := cHora
				If Len(aCriticas) == 0
					BE4->BE4_DTALTA := dDtAlta
					BE4->BE4_HRALTA := cHrAlta
					BE4->BE4_TIPFAT := cTipFat
				EndIf
			
				If BE4->( FieldPos("BE4_EMGEST") ) > 0 .And. BE4->( FieldPos("BE4_EMGEST") ) > 0 .And. ;
						BE4->( FieldPos("BE4_EMGEST") ) > 0 .And. BE4->( FieldPos("BE4_EMGEST") ) > 0
				
					BE4->BE4_DTINIF := dDtIniFat
					BE4->BE4_HRINIF := cHrIniFat
					BE4->BE4_DTFIMF := dDtFimFat
					BE4->BE4_HRFIMF := cHrFimFat
				EndIf
			
				If BE4->( FieldPos("BE4_EMGEST") ) > 0
					BE4->BE4_EMGEST := U_CBRETDAD( aDados,"EMGEST","0" )
				EndIf
				If BE4->( FieldPos("BE4_ABORTO") ) > 0
					BE4->BE4_ABORTO := U_CBRETDAD( aDados,"ABORTO","0" )
				EndIf
				If BE4->( FieldPos("BE4_TRAGRA") ) > 0
					BE4->BE4_TRAGRA := U_CBRETDAD( aDados,"TRAGRA","0" )
				EndIf
				If BE4->( FieldPos("BE4_COMURP") ) > 0
					BE4->BE4_COMURP := U_CBRETDAD( aDados,"COMURP","0" )
				EndIf
				If BE4->( FieldPos("BE4_ATESPA") ) > 0
					BE4->BE4_ATESPA := U_CBRETDAD( aDados,"ATESPA","0" )
				EndIf
				If BE4->( FieldPos("BE4_COMNAL") ) > 0
					BE4->BE4_COMNAL := U_CBRETDAD( aDados,"COMNAL","0" )
				EndIf
				If BE4->( FieldPos("BE4_BAIPES") ) > 0
					BE4->BE4_BAIPES  := U_CBRETDAD( aDados,"BAIPES","0" )
				EndIf
				If BE4->( FieldPos("BE4_PARCES") ) > 0
					BE4->BE4_PARCES  := U_CBRETDAD( aDados,"PAAREO","0" )
				EndIf
				If BE4->( FieldPos("BE4_PATNOR") ) > 0
					BE4->BE4_PATNOR := U_CBRETDAD( aDados,"PATNOR","0" )
				EndIf
				If BE4->( FieldPos("BE4_ARQIMP") ) > 0
					BE4->BE4_ARQIMP := cArqImp
				EndIf
				If BE4->( FieldPos("BE4_LOTGUI") ) > 0
					BE4->BE4_LOTGUI := cLotGui
				EndIf
				If BE4->( FieldPos("BE4_NRDCNV") ) > 0
					BE4->BE4_NRDCNV := cNrdCnv
				EndIf
				If BE4->( FieldPos("BE4_NASVIV") ) > 0
					BE4->BE4_NASVIV := nQtNasV
				EndIf
				If BE4->( FieldPos("BE4_NASMOR") ) > 0
					BE4->BE4_NASMOR := nQtNasM
				EndIf
				If BE4->( FieldPos("BE4_NASVPR") ) > 0
					BE4->BE4_NASVPR := nQtNasP
				EndIf
				If BE4->( FieldPos("BE4_OBTMUL") ) > 0
					BE4->BE4_OBTMUL := cObtMul
				EndIf
				If BE4->( FieldPos("BE4_TIPALT") ) > 0
					BE4->BE4_TIPALT := cTipAlt
				EndIf
				BE4->( MsUnLock() )
			
			End Transaction
		EndIf
	
	// Inclui procedimentos que nao estao na liberacao original conforme parametro MV_PLSOPMM
		If lContinua .And. lOPMM .And. !lSolicit .And. !lHonor .And. !lResInt
			For nFor := 1 To Len(aMatOPMM)
				If Ascan( aItensLOri,{|x| x[1] == aMatOPMM[nFor,1] } ) == 0
					nPos := Ascan( aAutItens,{|x| x[1] == aMatOPMM[nFor,1] } )
					If nPos > 0
						aAutItens[nPos,5] 	:= 0
						aAutItens[nPos,6] 	:= .F.
						aAutItens[nPos,8] 	:= .T.
						aAutItens[nPos,10] 	:= .F.
						aAutItens[nPos,11] 	:= .F.
						aAutItens[nPos,12] 	:= .F.
					EndIf
				EndIf
			Next
		EndIf
	
	// Caso seja Autorizacao a partir de liberacao verifica se sera total ou parcial
		If lContinua .And. lAprovLib
			cTpLibToAut := ""
		
			BEA->( DbGoTo(nRecBEALIB) )
		
			dDataSol := BEA->BEA_DATSOL
			cHoraSol := BEA->BEA_HORSOL
			cCidPri  := BEA->BEA_CID
			cCDPFSO  := BEA->BEA_CDPFSO
			cOpeSol  := BEA->BEA_OPESOL
		// Busca dados da liberacao PTU Online
			IF Substr(U_CBRETDAD( aDados,"USUARIO","" ),5,4) == GetNewPar("MV_PLSGEIN","0050") .And. ;
					U_CBRETDAD( aDados,"TP_CLIENTE","" ) == 'WEB' .And.  !Empty(U_CBRETDAD( aDados,"NUMLIB","" ))
				cSenhaOpe := BEA->BEA_NRAOPE
				cNrSeqTR  := BEA->BEA_NRTROL
			EndIf
		// Se gera log caixa preta
			If lWLIO
				PlsLogFil(Space(3)+"",__PLSFLOGX)
				PlsLogFil(Space(3)+"CONTEUDO ALTERADO PELA SOLICITACAO ORIGINAL",__PLSFLOGX)
				PlsLogFil(Space(3)+"",__PLSFLOGX)
				PlsLogFil(Space(3)+"DATA SOLICITACAO [" + DToC(dDataSol) + "]",__PLSFLOGX)
				PlsLogFil(Space(3)+"HORA SOLICITACAO [" + cHoraSol + "]",__PLSFLOGX)
				PlsLogFil(Space(3)+"PROF. SOLICIANTE [" + cCDPFSO + "]",__PLSFLOGX)
				PlsLogFil(Space(3)+"OPE. SOLICITANTE [" + cOpeSol + "]",__PLSFLOGX)
				PlsLogFil(Space(3)+"CID              [" + cCidPri + "]",__PLSFLOGX)
				PlsLogFil("",__PLSFLOGX)
			EndIf
		// Caso existe no be2 e nao existe na matriz e o salvo for maior que zero e parcial
			If BE2->(MsSeek(xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)))
				While ! BE2->(Eof()) .And. BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT) == ;
						xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)
				
					If Ascan(aItensLOri,{|x| AllTrim(x[1]+x[2]+x[3]+x[5]+x[6]) == BE2->(BE2_SEQUEN+BE2_CODPAD)+AllTrim( BE2->BE2_CODPRO )+AllTrim( BE2->BE2_DENREG )+AllTrim( BE2->BE2_FADENT ) } ) == 0 .And. BE2->BE2_SALDO > 0
						cTpLibToAut := "P"       //se tem algum item da pre-autorizacao(liberacao) que nao foi analisado e parcial
						Exit
					EndIf
				
					BE2->(DbSkip())
				EndDo
			EndIf
		// Verifico se existe algum item para ser executado em outro momento
			If Empty(cTpLibToAut)
				For nFor := 1 To Len(aAutItens)
					If !aAutItens[nFor,6]   		//pelo menos um NAO vai autorizar
						cTpLibToAut := "P"       	//Parcial
						Exit
					ElseIf aAutItens[nFor,6]     	//autorizou
						If aAutItens[nFor,5] > 0 	//pelo menos um ainda tem saldo portando e parcial
							cTpLibToAut := "P"
							Exit
						Else                      	//por enquanto todos autorizam e nao tem mais saldo
							cTpLibToAut := "T"
						Endif
					Endif
				Next
			Endif
		Endif
	
	// Continua
		If lContinua .Or. (lPtuOnline .And. !lCriMatInv)
			If Len(aDadUsr) == 0 .And. (lPtuOnline .And. !lContinua)
				aRetFun := u_CBUSUATE(@cMatric,cLocalExec,cHora,cViaCartao,cTipoMat,cNomUsrCar,cTipoGrv,aItens,;
					aCriticas,aEventosNeg,aMatInf,dDatPro,dDatNasUsr,lResInt,lHonor,lIncAutIE,lImpXml,.T.)
				aDadUsr	  := aRetFun[8]
			EndIf
		// PLSUSRINTE
			cRegAte := Iif( PLSUSRINTE(aDadUsr[2],dDatPro,cHora) ,"1","2")
		Endif
	
	// Valida cada evento se tem direito
		If lContinua .OR. lPtuOnline
		// Se Ptu Online e houveram criticas, carrega variaveis para criar a guia
			If lPtuOnline .And. !lContinua
				aRetFun := u_CBUSUATE(@cMatric,cLocalExec,cHora,cViaCartao,cTipoMat,cNomUsrCar,cTipoGrv,aItens,;
					aCriticas,aEventosNeg,aMatInf,dDatPro,dDatNasUsr,lResInt,lHonor,lIncAutIE,lImpXml,.T.)
				lMatGer   := aRetFun[2]
				lUsuGer   := aRetFun[3]
				cMatUsa   := aRetFun[4]
				cOpeOri	  := aRetFun[5]
				cRetGui	  := aRetFun[6]
				cSomInt	  := aRetFun[7]
				aDadUsr	  := aRetFun[8]
			
				aRetFun := u_CBREDATE(cOpeMov,cCodRda,cCodRdaPro,@cCodLoc,@cCodLocPro,@cCodEsp,@cCodEspPro,dDatPro,;
					aItens,aDadIte,aCriticas,aEventosNeg,aDadUsr,cLibEsp,cAuditoria,cOrigem,;
					cNumImp,lLoadRda,lRdaProf,lIncNeg)
				cLocal  	:= aRetFun[2]
				cDesLoc  	:= aRetFun[3]
				cDesLocPro 	:= aRetFun[4]
				nRecBAU	    := aRetFun[5]
				aDadRda 	:= aRetFun[6]
				aRdaProf  	:= aRetFun[7]
				lTrtExe		:= aRetFun[8]
			
				If Len(aDadRda) == 0
					aRetFun := PLSDADRDA(cOpeMov,cCodRda,"1",dDatPro,cCodLoc,cCodEsp)
					If aRetFun[1]
						aDadRDA := PLSGETRDA()
					Endif
				Endif
			
				aRetAux := PLSXVLDCAL(dDatPro,cOpeMov,.F.,cCodPad,cCodPro)
				cAno	:= aRetAux[4]
				cMes    := aRetAux[5]
				aTrb   	:= aRetAux[2]
			EndIf
		// Monta o Cabecalho
			Store Header "BE2" TO aHeader For .T.
		
			If cTipo=="4"
				B04->(dbsetorder(1))
				Store Header "BYS" TO aCabDF For .T.
			EndIf
		// Se e liberacao e vai virar autorizacao
			If lAprovLib
			// Posiciona na liberacao
				BEA->( DbGoTo(nRecBEALIB) )
			// Atualiza a liberacao
				aVetTrab := {}
				aCols    := {}
				PLSA090MDA(BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT),"",aHeader,aVetTrab,aCols)
			// Grava os valores para fazer a exclusao da liberacao
				aHeaderLib  := aClone(aHeader)
				aVetTrabLib := aClone(aVetTrab)
				aColsLib	:= aClone(aCols)
				aCols    	:= {}
				aVetTrab 	:= {}
			EndIf
		
		// Monta o aCols baseado no aHeader
		// REGRA DE UM USUARIO NORMAL
			If ( !lUnimeds ) .Or. ( (lUnimeds .And. cOpeOri == PLSINTPAD()) .Or. lCriMatInv )
			
			// Checar a regra do procedimento
				U_CBXMOVREG(	aItens,lAprovLib,lTrtUsr,lRegras,lConsulta,cOrigem,cAno,cMes,dDatPro,cHora,aDadUsr,aDadRDA,cCidPri,;
					cLOCALExec,cOpeSol,cCDPFSO,cPadInt,cPadCon,cRegAte,cCodPRFExe,cOpeExe,lRegPagAto,cTipoGrv,cAreaAbr,;
					cCodEsp,cCodLoc,cFilBCT,cTipoGrv,cLibEsp,cNumImp,cOpeMov,@nQtdDiAut,;
					aDadIte,aCriticas,aEventosNeg,aEventosAut,lAudEmp,lFAudMOP,lFAudAte,lForcAud,lAutoCus,aRdaProf,;
					cCodEspPro,cCodLocPro,lTrtExe,aDadBea,@lAto,lWeb,lInter,lSolicit,.f.,lPacAudi,lPtuOnline,cRdaEDI,lPtuA1100,nil,cTipGui,;
					cEspSol,cEspExe,cNumLib,cCarSol,@cSenBSN,cNuLibera, lNovaLib, cAteRN)
			// Usuario nao e da minha operadora (web,pos e xml)						 |
			Else
			// Abrir tabelas															 |
				aArea := GetArea()
				For nI := 1 To Len(aMatAlias)
					If Select(aMatAlias[nI]) == 0
						DbSelectArea(aMatAlias[nI])
					EndIf
				Next
				RestArea(aArea)
			// Checa se a operadora esta online										 |
				lOnLine  := BA0->(Posicione("BA0",1,xFilial("BA0")+cOpeOri,"BA0_ONLINE")) == "1"
				lOnTLine := lOnLine
			// Se importacao XML, nao realiza comunicacao  							 |
				If lImpXml
					lOnLine  := .F.
					lOnTLine := .F.
				EndIf
			// Verifica campos necessarios											     |
				If lOnline .And. BE2->( FieldPos("BE2_AUDITO") ) == 0 .Or. BE2->( FieldPos("BE2_STATUS") ) == 0 .Or.;
						BE2->( FieldPos("BE2_SEQUEN") ) == 0 .Or. BE2->( FieldPos("BE2_CODPRO") ) == 0 .Or.;
						BEG->( FieldPos("BEG_SEQUEN") ) == 0 .Or. BEG->( FieldPos("BEG_CODGLO") ) == 0 .Or.;
						BEG->( FieldPos("BEG_DESGLO") ) == 0 .Or. BEA->( FieldPos("BEA_NRAOPE") ) == 0 .Or.;
						BEA->( FieldPos("BEA_COMUNI") ) == 0 .Or. BEA->( FieldPos("BEA_NRTROL") ) == 0 .Or.;
						BEA->( FieldPos("BEA_AUDITO") ) == 0 .Or. BEA->( FieldPos("BEA_TRACON") ) == 0 .Or.;
						BEA->( FieldPos("BEA_CANCEL") ) == 0 .Or. BEA->( FieldPos("BEA_VIACAR") ) == 0
				// Critica	"Base de dados nao esta preparada para transacao On-Line"
					If PLSPOSGLO(PLSINTPAD(),__aCdCri108[1],__aCdCri108[2],cLocalExec,,cTipoGrv) .And. PLSCHKCRI( {'BAU',cCodRda,__aCdCri108[1]} )
						U_CBMONCRI(aItens,{},.F.,__aCdCri108[1],PLSBCTDESC(),,aCriticas,NIL)
					EndIf
					lOnline := .F.
				EndIf
			// Verifica se a operadora esta on-line
				If lOnline
					If GetNewPar("MV_PTUVEON","50") < "60" .And. !PlsPtuConn()
					// Critica	"Gerenciador de comunicacao OnLine nao esta ativo."
						If PLSPOSGLO(PLSINTPAD(),__aCdCri064[1],__aCdCri064[2],cLocalExec,,cTipoGrv) .And. PLSCHKCRI( {'BAU',cCodRda,__aCdCri064[1]} )
							U_CBMONCRI(aItens,{},.F.,__aCdCri064[1],PLSBCTDESC(),,aCriticas,NIL)
						EndIf
						lOnline := .F.
					EndIf
				EndIf
			// Regra para usuario de outra operadora
				If cOpeOri <> PLSINTPAD()
				// Indica solicitacao PTU Online
					lPTUOnSol := .T.
				// Forco a minha operadora como Origem se OPESOL vazio
					If Empty(cOpeSol)
						cOpeSol := PlsIntPad()
					EndIf
				// Antes de realizar a comunicacao, verifico periodicidade interna de
				// consulta
					If len(aItens) == 1 .And. lOnline .And. lConsulta .And. Alltrim(U_CBRETDAD(aItens[1],"CODPRO")) $ GetNewPar("MV_PTCELET","10101012")
						lOkVerPTU := VPerConPTU(aDados,aItens,aDadRDA,aDadUsr,aDadIte,aCriticas,aEventosNeg)
					EndIf
				// Verifica se e PTU Online pelo Portal com Matricula sem 17 caracteres
					If lOnline .And. len(Alltrim(aDadUsr[3])) <> 17 .And. PLSPOSGLO(PLSINTPAD(),__aCdCri210[1],__aCdCri210[2],cLOCALExec,"1","2",,.T.)
						lOkVerPTU := criMatPT17(aDados,aItens,aDadRDA,aDadUsr,aDadIte,aCriticas,aEventosNeg,cLOCALExec)
					EndIf
				// Ordem de Servico PTU Online 5.0
					If lPTUOnOS
					
						cOpeSol	 := cOpeSolOS
					
						If BEA->( FieldPos("BEA_NRTROS") ) > 0
							AaDd(aDadBEA,{"BEA_NRTROS",cTranOS})
						EndIf
					
						If lInter .And. BE4->( FieldPos("BE4_NRTROS") ) > 0
							AaDd(aDadBE4,{"BE4_NRTROS",cTranOS})
						EndIf
					// Parametro de comunicacao automatica da guia 00600 ativado
					// IMPORTANTE - Desabilitado temporariamente, necessario rever esta
					// transacao no futuro
						If .F. //GetNewPar("MV_PTOSAUT","0") == "1"
							lOnLine   := .T.
							lOkVerPTU := .T.
							PlsPtuLog("***********************************")
							PlsPtuLog("Montando dados para gerar Solicitacao 00600 da OS recebida. Transacao -> "+cTranOS)
							PlsPtuLog("***********************************")
						// Parametro de comunicacao automatica da guia 00600 desativado
						// (a comunicacao deve ser realizada posteriormente atraves do Auto.On.Line
						Else
							lOnLine := .F.
							AaDd(aDadBEA,{"BEA_TRACON","0"})
						
							lVeioComu := .F.
							PlsPtuLog("**********************************")
							PlsPtuLog("Gerando Guia referente a OS '"+cTranOS+"' para posterior solicitação manual.")
							PlsPtuLog("***********************************")
						
							If PLSALIASEX("BSN")
							
								lExitTran := .F.
								cNrSeqTR  := StrZero( Val( BSN->(GetSx8Num("BSN","BSN_SEQUEN") ) ),10)
								BSN->(ConfirmSX8())
							
								SIX->(DbSetOrder(1))
								If SIX->( MsSeek("BEAM") )
									BEA->(DbSetOrder(22))//BEA_FILIAL + BEA_NRTROL
									If BEA->(DbSeek(xFilial("BEA")+cNrSeqTR+Space( TamSX3("B0S_NUMSEQ")[1]-Len(cNrSeqTR))+PlsIntPad()))
									
										While !lExitTran
											cNrSeqTR := strZero(val(cNrSeqTR)+1,10)
										
											If !BEA->(DbSeek(xFilial("BEA")+cNrSeqTR))
												lExitTran := .T.
											EndIf
										EndDo
									
									EndIf
								EndIf
							
								BSN->(RecLock("BSN",.T.))
								BSN->BSN_FILIAL := xFilial("BSN")
								BSN->BSN_SEQUEN := cNrSeqTR
								BSN->(MsUnLock())
							
							EndIf
						EndIf
					EndIf
				// Verifica se ha procedimentos liberados, caso nao exista, nao comunica
					If lOkVerPTU .And. lOnLine
					
						For nFor :=1 to len(aItens)
							nIteLibPTU += U_CBRETDAD(aItens[nFor],"QTDAUT",0)
						Next
					
						If nIteLibPTU == 0
							lOkVerPTU   := .F.
							lCriAutPTU  := .T.
						EndIf
					
					EndIf
				// Ponto de entrada para definir se ira comunicar Online ou nao
					If ExistBlock("PTXMOVPTON")
						lOnLine := ExecBlock("PTXMOVPTON",.F.,.F.,{aDadUsr,aDadRDA,aDados,aItens} )
					EndIf
				// A funcao abaixo processa online com outra operadora solicitacao do
				// Portal/Xml ou POS
				// Se a operadora do usuario estiver online caso contrario segue regra de
				// intercambio normalmente
				// -----------------------------------------------
				// Se tiver online
				// Se nao encontra uma liberacao
					If lOnLine .And. !lAprovLib .And. lOkVerPTU
					
						aRetFun := U_CBXMOVONL(aItens,lAprovLib,lTrtUsr,lConsulta,cOrigem,cAno,cMes,dDatPro,cHora,aDadUsr,aDadRDA,cCidPri,;
							cLOCALExec,cOpeSol,cCDPFSO,cPadInt,cPadCon,cRegAte,cCodPRFExe,cOpeExe,lRegPagAto,cTipoGrv,cAreaAbr,;
							cCodEsp,cCodLoc,cFilBCT,cViaCartao,cOpeOri,cLibEsp,cCodRda,cNumImp,@nQtdDiAut,@nQtdDiNeg,;
							aDadIte,aCriticas,aEventosNeg,aEventosAut,aDadBEA,aDados,cOriMov,cCarSol,cIndCli,@lCriTime,;
							cTranOS,lInter,cIndAci,cAteRN,lEvolu)
					
					// Dados da transacao online
						lOnLine 	:= aRetFun[1]
						cNrSeqTR 	:= aRetFun[2]
						cSenhaOpe 	:= aRetFun[3]
						cMsg03 		:= aRetFun[4]
						lVeioComu   := aRetFun[5]
						cAutori     := aRetFun[6]
						cDatValAut  := aRetFun[8]
					EndIf
				// Processa regra de usuario de intercambio normalmente
				// (Solicitacao via ptu online de outra operadora ou caso a operadora
				//  nao esteja online)
				//  lCriAutPTU - todos itens estao criticados, preciso entrar aqui para
				//  gerar a guia negada
					If !lOnLine .Or. lAprovLib .Or. lCriAutPTU
					// Checar a regra do procedimento
						U_CBXMOVREG(	aItens,lAprovLib,lTrtUsr,lRegras,lConsulta,cOrigem,cAno,cMes,dDatPro,cHora,aDadUsr,aDadRDA,cCidPri,;
							cLOCALExec,cOpeSol,cCDPFSO,cPadInt,cPadCon,cRegAte,cCodPRFExe,cOpeExe,lRegPagAto,cTipoGrv,cAreaAbr,;
							cCodEsp,cCodLoc,cFilBCT,cTipoGrv,cLibEsp,cNumImp,cOpeMov,@nQtdDiAut,;
							aDadIte,aCriticas,aEventosNeg,aEventosAut,lAudEmp,NIL,NIL,NIL,NIL,aRdaProf,cCodEspPro,cCodLocPro,lTrtExe,;
							aDadBea,@lAto,lWeb,lInter,lSolicit,lImpXml,nil,nil,nil,nil,nil,cTipGui,cEspSol,cEspExe,cNumLib, lNovaLib)
					EndIf
				
				EndIf
			EndIf
		// Checagem se e para incluir mesmo se for negado
			If lVeioComu .And. Empty(aEventosAut)
				lIncUso 	:= .T.
				aEventosAut := aEventosNeg
				nQtdDiAut   := nQtdDiNeg
				cSenhaOpe	:= REPLICATE("0",10)
			EndIF
		// Grava demais campos
		// Quando for falso segue o processo normal
			If !lIncUso .And. !lInter
				If ( BAU->BAU_TIPPRE == GetNewPar("MV_PLSTPIN","OPE") )
					lGerSenha := .T.
				EndIf
			EndIf
		// Para PTU Online preciso gerar a senha de internacao na criacao da guia
			If lPtuOnline .And. !lIncUso .And. ( BAU->BAU_TIPPRE == GetNewPar("MV_PLSTPIN","OPE") )
				lGerSenha := .T.
			EndIf
		
			BB0->(DbSetOrder(1))
			If ! Empty(AllTrim(cCDPFSO))
				If BB0->(MsSeek(xFilial("BB0")+cCDPFSO))
					AaDd(aDadBEA,{"BEA_CDPFSO",cCDPFSO})
					AaDd(aDadBEA,{"BEA_ESTSOL",BB0->BB0_ESTADO})
					AaDd(aDadBEA,{"BEA_OPESOL",cOpeSol})
					AaDd(aDadBEA,{"BEA_REGSOL",BB0->BB0_NUMCR})
					AaDd(aDadBEA,{"BEA_NOMSOL",BB0->BB0_NOME})
					AaDd(aDadBEA,{"BEA_SIGLA",BB0->BB0_CODSIG})
				EndIf
			ElseIf !Empty(cOpeSol) .And. cOpeOri <> PLSINTPAD() //Para intercambio preciso gravar o OPESOL
				AaDd(aDadBEA,{"BEA_OPESOL",cOpeSol})
			EndIf
		
			If BEA->(FieldPos("BEA_SOLORI")) > 0
				AaDd(aDadBEA,{"BEA_SOLORI",U_CBRETDAD( aDados,"SOLORIG","" ) } )
			Endif
		
			BB0->(DbSetOrder(1))
			If ! Empty(AllTrim(cCodPRFExe))
				If BB0->(MsSeek(xFilial("BB0")+cCodPRFExe))
					AaDd(aDadBEA,{"BEA_ESTEXE",BB0->BB0_ESTADO})
					AaDd(aDadBEA,{"BEA_REGEXE",BB0->BB0_NUMCR})
					AaDd(aDadBEA,{"BEA_NOMEXE",BB0->BB0_NOME})
					AaDd(aDadBEA,{"BEA_SIGEXE",BB0->BB0_CODSIG})
					AaDd(aDadBEA,{"BEA_CDPFRE",cCodPRFExe})
					AaDd(aDadBEA,{"BEA_OPEEXE",cOpeExe})
				EndIf
			EndIf
		
			AaDd(aDadBEA,{"BEA_CANCEL","0"})
			AaDd(aDadBEA,{"BEA_TPGRV",cTipoGrv})
			AaDd(aDadBEA,{"BEA_HORSOL",cHoraSol})
			AaDd(aDadBEA,{"BEA_DATSOL",dDataSol})
		
			AaDd(aDadBEA,{"BEA_INDCLI",SubStr( cIndCli,1,250)  } )
			If BEA->(FieldPos("BEA_INDCL2")) > 0
				AaDd(aDadBEA,{"BEA_INDCL2",SubStr(cIndCli,251,500) } )
			EndIf
		
			If BEA->(FieldPos("BEA_ESPSOL")) > 0
				If !Empty(cNumLib)
					nOrdBEA := BEA->(IndexOrd())
					nRecBEA := BEA->(Recno())
					BEA->(DbSetOrder(1))
					If BEA->(MsSeek(xFilial('BEA')+cNumLib))
						AaDd(aDadBEA,{"BEA_ESPSOL",BEA->BEA_ESPSOL } )
					Endif
					BEA->(DbSetORder(nOrdBEA))
					BEA->(DbGoTo(nRecBEA))
				Else
					AaDd(aDadBEA,{"BEA_ESPSOL",cEspSol } )
				EndIf
			EndIf
		
			If BEA->(FieldPos("BEA_ESPEXE")) > 0
				AaDd(aDadBEA,{"BEA_ESPEXE",cEspExe } )
			EndIf
		
			If BEA->(FieldPos("BEA_GUIPRI")) > 0
				AaDd(aDadBEA,{"BEA_GUIPRI",U_CBRETDAD( aDados,"GUIPRI","" ) } )
			EndIf
		
			If BEA->(FieldPos("BEA_GUIPRE")) > 0
				AaDd(aDadBEA,{"BEA_GUIPRE",U_CBRETDAD( aDados,"GUIPRE","" ) } )
			EndIf
		
			If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_TRACON"})) == 0
				AaDd(aDadBEA,{"BEA_TRACON","0"})
			Else
				aDadBEA[nPos,2] := "0"
			EndIf
		
			If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_TIPATE"})) == 0
				AaDd(aDadBEA,{"BEA_TIPATE",cTipoAte})
			Else
				aDadBEA[nPos,2] := cTipoAte
			EndIf
		
			AaDd(aDadBEA,{"BEA_TIPDOE",cTipDoe } )
			AaDd(aDadBEA,{"BEA_TPODOE",nTmpDoe } )
			AaDd(aDadBEA,{"BEA_UTPDOE",cUndDoe } )
			AaDd(aDadBEA,{"BEA_INDACI",cIndAci } )
			If !lInter
				AaDd(aDadBEA,{"BEA_TIPCON",U_CBRETDAD( aDados,"TIPCON","1" )  } )
			EndIf
			AaDd(ADADBEA,{"BEA_TIPATO",U_CBRETDAD( aDados,"TIPATO","")})
			AaDd(ADADBEA,{"BEA_TIPFAT",U_CBRETDAD( aDados,"TIPFAT","")})
		
			If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_TIPSAI"})) == 0
				AaDd(aDadBEA,{"BEA_TIPSAI",cTipSai})
			Else
				aDadBEA[nPos,2] := cTipSai
			EndIf
		
			If lGerSenha
				If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_VALSEN"})) == 0
					If GetNewPar("MV_PLSUNI","1") == "1" .And. (aDadUsr[45] <> PlsIntPad() .Or. (Type(BAU->BAU_TIPPRE) <> 'U' .And. BAU->BAU_TIPPRE == GetNewPar("MV_PLSTPIN","OPE"))) .Or. lPtuOnline .Or. lPTUOnSol
						AaDd(aDadBEA,{"BEA_VALSEN",dDatabase+GetNewPar("MV_PLPRZPT",30)})
					Else
						AaDd(aDadBEA,{"BEA_VALSEN",dDatabase+GetNewPar("MV_PLPRZLB",30)})
					EndIf
				Else
					If GetNewPar("MV_PLSUNI","1") == "1" .And. (aDadUsr[45] <> PlsIntPad() .Or. (Type(BAU->BAU_TIPPRE) <> 'U' .And. BAU->BAU_TIPPRE == GetNewPar("MV_PLSTPIN","OPE"))) .Or. lPtuOnline .Or. lPTUOnSol
						aDadBEA[nPos,2] := dDatabase+GetNewPar("MV_PLPRZPT",30)
					Else
						aDadBEA[nPos,2] := dDatabase+GetNewPar("MV_PLPRZLB",30)
					EndIf
				EndIf
			EndIf
		
			If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_STALIB"})) == 0
				AaDd(aDadBEA,{"BEA_STALIB",If(Len(aEventosAut) > 0,"1","0")})
			Else
				aDadBEA[nPos,2] := If(Len(aEventosAut) > 0,"1","0")
			EndIf
		
			If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_TIPATE"})) == 0
				AaDd(aDadBEA,{"BEA_TIPATE",If(lConsulta,"",cTipoAte)})
			Else
				aDadBEA[nPos,2] := cTipoAte
			EndIf
		
			If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_PAGATO"})) == 0
				AaDd(aDadBEA,{"BEA_PAGATO","0"})
			EndIf
		
			If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_GUIACO"})) == 0
				AaDd(aDadBEA,{"BEA_GUIACO","0"})
			EndIf
		
		
			If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_QUACOB"})) == 0
				AaDd(aDadBEA,{"BEA_QUACOB","0"})
			EndIf
		
		
			If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_TIPPRE"})) == 0
				AaDd(aDadBEA,{"BEA_TIPPRE",aDadRda[27]})
			Else
				aDadBEA[nPos,2] := aDadRda[27]
			EndIf
		
			If BEA->(FieldPos("BEA_NRLBOR")) > 0
				If !Empty(cGuiaOri)
					AaDd(aDadBEA,{"BEA_NRLBOR",cGuiaOri})
				ElseIf cOrigem == '2' .And. !Empty(cGuiPr)//se for liberacao e o cara informou uma guia para vinculo
					AaDd(aDadBEA,{"BEA_NRLBOR",cGuiPr})
				EndIf
			EndIf
		
			If lIncUso
				AaDd(aDadBEA,{"BEA_STATUS","3"})
			Else
				AaDd(aDadBEA,{"BEA_STATUS","1"})
			EndIF
		// Continua alimentanto dadbea
			AaDd(aDadBEA,{"BEA_ORIMOV",cOriMov})
			AaDd(aDadBEA,{"BEA_TIPO",cTipo})
			AaDd(aDadBEA,{"BEA_NUMIMP",cNumImp})
			AaDd(aDadBEA,{"BEA_TIPPAC",Iif(!empty(ctippac),ctippac,GetNewPar("MV_PLSTPAA","1")) } )
			AaDd(aDadBEA,{"BEA_OPEMOV",cOpeMov})
			AaDd(aDadBEA,{"BEA_CID",cCidPri})
			AaDd(aDadBEA,{"BEA_CIDSEC",U_CBRETDAD( aDados,"CID2","" ) } )
			AaDd(aDadBEA,{"BEA_CID3",U_CBRETDAD( aDados,"CID3","" ) } )
			AaDd(aDadBEA,{"BEA_CID4",U_CBRETDAD( aDados,"CID4","" ) } )
			AaDd(aDadBEA,{"BEA_CID5",U_CBRETDAD( aDados,"CID5","" ) } )
		
			If ! Empty(cCidPri)
				AaDd(aDadBEA,{"BEA_DESCID",Posicione("BA9",1,xFilial("BA9")+cCidPri,"BA9_DOENCA")})
			Endif
		
			AaDd(aDadBEA,{"BEA_MATUSA",cMatUsa})
		
			If Type("BEA->BEA_MSG01") == "C" .And. Type("BEA->BEA_MSG02") == "C" .And. Type("BEA->BEA_MSG03") == "C"
				AaDd(aDadBEA,{"BEA_MSG01",cMsg01})
				AaDd(aDadBEA,{"BEA_MSG02",cMsg02})
				AaDd(aDadBEA,{"BEA_MSG03",cMsg03})
			EndIf
		
			If Type("BEA->BEA_NRTROL") == "C"
				AaDd(aDadBEA,{"BEA_NRTROL",cNrSeqTR})
			Endif
		
			If Type("BEA->BEA_COMUNI") == "C"
				AaDd(aDadBEA,{"BEA_COMUNI",Iif(lVeioComu .And. !lCriTime,"1","0")})
			Endif
		
			If Type("BEA->BEA_VIACAR") == "N"
				AaDd(aDadBEA,{"BEA_VIACAR",Val(cViaCartao)} )
			EndIf
		
			AaDd(aDadBEA,{"BEA_DTDIGI",date()})
			AaDd(aDadBEA,{"BEA_USUOPE", cOperad})
			AaDd(aDadBEA,{"BEA_DESOPE",If(Empty(PLRETOPE()),'ELETRONICA',cOperad)})
			AaDd(aDadBEA,{"BEA_LOCAL",cLocal})
			AaDd(aDadBEA,{"BEA_CODLOC",cCodLoc})
			AaDd(aDadBEA,{"BEA_DESLOC",aDadRda[19]})
			AaDd(aDadBEA,{"BEA_ENDLOC",aDadRda[20]})
		
			AaDd(aDadBEA,{"BEA_CODESP", aDadRda[15] })
			AaDd(aDadBEA,{"BEA_DESESP", aDadRda[17] })
		
			AaDd(aDadBEA,{"BEA_DATPRO",dDatPro})
		
			AaDd(aDadBEA,{"BEA_CODRDA",cCodRda})
			AaDd(aDadBEA,{"BEA_OPERDA",cOpeMov})
		
			AaDd(aDadBEA,{"BEA_RDAEDI",cRdaEdi})
			AaDd(aDadBEA,{"BEA_NOMEDI",cNomEdi})
		
			If Empty(cTipPre)
				cTipPre := BAU->BAU_TIPPRE
			Endif
		
			cSexo := BA1->BA1_SEXO
			AaDd(aDadBEA,{"BEA_TIPPRE",cTipPre})
			AaDd(aDadBEA,{"BEA_NOMRDA",aDadRDA[6]})
			AaDd(aDadBEA,{"BEA_MATANT",aDadUsr[3]})
			AaDd(aDadBEA,{"BEA_NOMUSR",aDadUsr[6]})
			AaDd(aDadBEA,{"BEA_ATERNA",cAteRN})
			AaDd(aDadBEA,{"BEA_TIPUSR",aDadUsr[43]})
			AaDd(aDadBEA,{"BEA_CPFUSR",BA1->BA1_CPFUSR})
			AaDd(aDadBEA,{"BEA_IDUSR",BA1->BA1_DRGUSR})
			AaDd(aDadBEA,{"BEA_DATNAS",BA1->BA1_DATNAS})
			AaDd(aDadBEA,{"BEA_CONEMP",aDadUsr[9]})
			AaDd(aDadBEA,{"BEA_VERCON",aDadUsr[39]})
			AaDd(aDadBEA,{"BEA_SUBCON",aDadUsr[41]})
			AaDd(aDadBEA,{"BEA_VERSUB",aDadUsr[42]})
			AaDd(aDadBEA,{"BEA_MATVID",aDadUsr[5]})
			AaDd(aDadBEA,{"BEA_PACOTE","0"})
			AaDd(aDadBEA,{"BEA_OPEUSR",Subs(aDadUsr[2],atCodOpe[1],atCodOpe[2])})
			AaDd(aDadBEA,{"BEA_CODEMP",Subs(aDadUsr[2],atCodEmp[1],atCodEmp[2])})
			AaDd(aDadBEA,{"BEA_MATRIC",Subs(aDadUsr[2],atMatric[1],atMatric[2])})
			AaDd(aDadBEA,{"BEA_TIPREG",Subs(aDadUsr[2],atTipReg[1],atTipReg[2])})
			AaDd(aDadBEA,{"BEA_DIGITO",Subs(aDadUsr[2],atDigito[1],atDigito[2])})
			AaDd(aDadBEA,{"BEA_HORPRO",cHora})
			AaDd(aDadBEA,{"BEA_HHDIGI",StrTran(Time(),":","")})
			AaDd(aDadBEA,{"BEA_OPEINT",cOpeInt } )
			AaDd(aDadBEA,{"BEA_NOMTIT",aDadUsr[6]})
			AaDd(aDadBEA,{"BEA_ATEAMB","1"})
			AaDd(aDadBEA,{"BEA_ANOPAG",cAno})
			AaDd(aDadBEA,{"BEA_MESPAG",cMes})
			AaDd(aDadBEA,{"BEA_TIPADM",cTipAdm } )
		
			If BEA->( FieldPos("BEA_ARQIMP") ) > 0
				AaDd(aDadBEA,{"BEA_ARQIMP",cArqImp } )
			EndIf
		
			If BEA->( FieldPos("BEA_LOTGUI") ) > 0
				AaDd(aDadBEA,{"BEA_LOTGUI",cLotGui} )
			EndIf
		// Vou priorizar o cSenhaOpe pois e o retorno da comunicacao online
			If BEA->( FieldPos("BEA_NRAOPE") ) > 0
				If !lWeb .And. !lIncUso
					cSenhaOpe:= cSenBSN
				EndIf
				If !Empty(cNrOpe1100)
					AaDd(aDadBEA,{"BEA_NRAOPE",cNrOpe1100})
				ElseIf Empty(cSenhaOpe) .Or. (Val(cSenhaOpe) == 0 .And. !lIncUso)
					AaDd(aDadBEA,{"BEA_NRAOPE",BEA->BEA_NRAOPE} )
				Else
					AaDd(aDadBEA,{"BEA_NRAOPE",cSenhaOpe})
				EndIf
			EndIf
		
			AaDd(aDadBEA,{"BEA_DTRLZ",dDtRlz})
			AaDd(aDadBEA,{"BEA_DTRLZ2",dDtRlz2})
			AaDd(aDadBEA,{"BEA_DTRLZ3",dDtRlz3})
			AaDd(aDadBEA,{"BEA_DTRLZ4",dDtRlz4})
			AaDd(aDadBEA,{"BEA_DTRLZ5",dDtRlz5})
			AaDd(aDadBEA,{"BEA_DTRLZ6",dDtRlz6})
			AaDd(aDadBEA,{"BEA_DTRLZ7",dDtRlz7})
			AaDd(aDadBEA,{"BEA_DTRLZ8",dDtRlz8})
			AaDd(aDadBEA,{"BEA_DTRLZ9",dDtRlz9})
			AaDd(aDadBEA,{"BEA_DTRLZ1",dDtRlz1})
			AaDd(aDadBEA,{"BEA_PROATE",cProtoc})
		// Alterações do PTU Online 6.0
			AaDd(aDadBEA,{"BEA_GUIJUR",Iif(cGuiJur == 'S', '1','0') } )
		
		// Se for internacao
			If lInter
			
				cMsgClient := U_CBRETDAD( aDados,"MSG01","" ) + U_CBRETDAD( aDados,"MSG02","" )
				dDPrAH 	   := U_CBRETDAD( aDados,"DATPRVINT",dDataBase )
			
				AaDd(aDadBE4,{"BE4_CGCRDA",cCnpjSolT})
				AaDd(aDadBE4,{"BE4_CID",cCidPri})
			
				If ! Empty(cCidPri) .and. BA9->(FieldPos('BA9_INTSIP')) > 0
					BA9->(DbSetOrder(1))
					If BA9->(MsSeek(xFilial("BA9")+cCidPri))
						AaDd(aDadBE4,{"BE4_INTSIP",BA9->BA9_INTSIP})
					Endif
				Endif
				If ! Empty(cCidPri)
					AaDd(aDadBE4,{"BE4_DESCID",Posicione("BA9",1,xFilial("BA9")+cCidPri,"BA9_DOENCA")})
				Endif
			
				AaDd(aDadBE4,{"BE4_DTDIGI",date()})
				AaDd(aDadBE4,{"BE4_PODRFS",'1'})
				AaDd(aDadBE4,{"BE4_BLOPAG",'0'})
				AaDd(aDadBE4,{"BE4_STAFAT",'1'})
			
				If GetNewPar("MV_PLSUNI","1") == "1" .And. (aDadUsr[45] <> PlsIntPad() .Or. (Type(BAU->BAU_TIPPRE) <> 'U' .And. BAU->BAU_TIPPRE == GetNewPar("MV_PLSTPIN","OPE"))) .Or. lPtuOnline
					AaDd(aDadBE4,{"BE4_DATVAL",dDataBase+GetNewPar("MV_PLPRZPT",30)})
				Else
					AaDd(aDadBE4,{"BE4_DATVAL",dDataBase+GetNewPar("MV_PLPRZLB",30)})
				EndIf
				AaDd(aDadBE4,{"BE4_FASE","1"})
				AaDd(aDadBE4,{"BE4_SITUAC","1"})
				AaDd(aDadBE4,{"BE4_PADCON",cPadCon})
				AaDd(aDadBE4,{"BE4_PADINT",cPadInt})
				AaDd(aDadBE4,{"BE4_DTALTA",dDtAlta})
				AaDd(aDadBE4,{"BE4_HRALTA",cHrAlta})
				AaDd(aDadBE4,{"BE4_REGINT",cRegint } )
			
				If (nPos := Ascan(aDadBE4,{|x| x[1] == "BE4_PAGATO"})) == 0
					AaDd(aDadBE4,{"BE4_PAGATO","0"})
				EndIf
			
				If BE4->( FieldPos("BE4_LOTGUI") ) > 0
					AaDd(aDadBE4,{"BE4_LOTGUI",cLotGui})
				EndIf
			
				If BE4->( FieldPos("BE4_PREOPE") ) > 0
					AaDd(aDadBE4,{"BE4_PREOPE",cPrvOpm})
				EndIf
			
				If BE4->( FieldPos("BE4_PREQUI") ) > 0
					AaDd(aDadBE4,{"BE4_PREQUI",cPrvQui})
				EndIf
			
				If BE4->( FieldPos("BE4_ATERNA") ) > 0
					AaDd(aDadBE4,{"BE4_ATERNA",cAteRN})
				EndIf
			
				If BE4->( FieldPos("BE4_ESPSOL") ) > 0
					AaDd(aDadBE4,{"BE4_ESPSOL",cEspSol})
				EndIf
			
				If BE4->( FieldPos("BE4_ESPEXE") ) > 0
					AaDd(aDadBE4,{"BE4_ESPEXE",cEspExe})
				EndIf
			
				If BE4->( FieldPos("BE4_EMGEST") ) > 0
					AaDd(aDadBE4,{"BE4_EMGEST",U_CBRETDAD( aDados,"EMGEST","0" ) } )
				EndIf
			
				If BE4->( FieldPos("BE4_ABORTO") ) > 0
					AaDd(aDadBE4,{"BE4_ABORTO",U_CBRETDAD( aDados,"ABORTO","0" ) } )
				EndIf
			
				If BE4->( FieldPos("BE4_TRAGRA") ) > 0
					AaDd(aDadBE4,{"BE4_TRAGRA",U_CBRETDAD( aDados,"TRAGRA","0" ) } )
				EndIf
			
				If BE4->( FieldPos("BE4_COMURP") ) > 0
					AaDd(aDadBE4,{"BE4_COMURP",U_CBRETDAD( aDados,"COMURP","0" ) } )
				EndIf
			
				If BE4->( FieldPos("BE4_ATESPA") ) > 0
					AaDd(aDadBE4,{"BE4_ATESPA",U_CBRETDAD( aDados,"ATESPA","0" ) } )
				EndIf
			
				If BE4->( FieldPos("BE4_COMNAL") ) > 0
					AaDd(aDadBE4,{"BE4_COMNAL",U_CBRETDAD( aDados,"COMNAL","0" ) } )
				EndIf
			
				If BE4->( FieldPos("BE4_BAIPES") ) > 0
					AaDd(aDadBE4,{"BE4_BAIPES",U_CBRETDAD( aDados,"BAIPES","0" ) } )
				EndIf
			
				If BE4->( FieldPos("BE4_PARCES") ) > 0
					AaDd(aDadBE4,{"BE4_PARCES",U_CBRETDAD( aDados,"PAAREO","0" ) } )
				EndIf
			
				If BE4->( FieldPos("BE4_PATNOR") ) > 0
					AaDd(aDadBE4,{"BE4_PATNOR",U_CBRETDAD( aDados,"PATNOR","0" ) } )
				EndIf
				AaDd(aDadBE4,{"BE4_NRDCNV",U_CBRETDAD( aDados,"NRDCNV","" ) } )
				AaDd(aDadBE4,{"BE4_NASVIV",nQtNasV } )
				AaDd(aDadBE4,{"BE4_NASMOR",nQtNasM } )
				AaDd(aDadBE4,{"BE4_NASVPR",nQtNasP } )
				AaDd(aDadBE4,{"BE4_OBTMUL",cObtMul } )
				AaDd(aDadBE4,{"BE4_OBTPRE",nQtObtP } )
				AaDd(aDadBE4,{"BE4_OBTTAR",nQtObAR } )
				AaDd(aDadBE4,{"BE4_TIPALT",cTipAlt } )
				AaDd(aDadBE4,{"BE4_CIDOBT",cCidObt } )
				AaDd(aDadBE4,{"BE4_NRDCOB",cNrdCob } )
				AaDd(aDadBE4,{"BE4_TIPFAT",cTipFat } )
			// Qtd diarias autorizadas / Solicitada
			
				if !lPossuiProcDiaria
					nQtdDiAut := U_CBRETDAD( aDados,"QDISOL",nQtdDiAut) // Se não possuir procedimento de diária, pega a quantidade autorizada do cabeçalho.
				endif
			
				If !lEvolu
					AaDd(aDadBE4,{"BE4_DIASSO",U_CBRETDAD( aDados,"QDISOL",nQtdDiAut)  } )
					AaDd(aDadBE4,{"BE4_DIASIN",nQtdDiAut })
				Else
					If BE4->(FieldPos("BE4_DIASPR")) > 0
						AaDd(aDadBE4,{"BE4_DIASPR",nQtdDiAut})
					EndIf
				EndIf
				AaDd(aDadBE4,{"BE4_QTDEVE",Len(aItens)})
				AaDd(aDadBE4,{"BE4_GUIIMP","0"})
				AaDd(aDadBE4,{"BE4_GRPINT",cGrpInt } )
				AaDd(aDadBE4,{"BE4_TIPINT",cTipInt } )
				AaDd(aDadBE4,{"BE4_PADINT",IIf(!Empty(cPadInt),cPadInt,GetNewPar("MV_PLPADIN","01"))})
				AaDd(aDadBE4,{"BE4_PRVINT",U_CBRETDAD( aDados,"DATPRVINT",dDataBase ) } )
				AaDd(aDadBE4,{"BE4_DATPRO",dDatPro})
				AaDd(aDadBE4,{"BE4_HORPRO",cHora})
				AaDd(aDadBE4,{"BE4_INDCLI",cIndCli } )
				AaDd(aDadBEA,{"BE4_PROATE",cProtoc})
			// Alterações do PTU Online 6.0
				AaDd(aDadBE4,{"BE4_GUIJUR",Iif(cGuiJur == 'S', '1','0') } )
			EndIf
		// PE para manipulacao dos dados que serao gravados no cabecalho da guia
			If ExistBlock("PLCABXMOV")
				aRetPECab := ExecBlock("PLCABXMOV",.F.,.F.,{aDadBEA,aDadBE4} )
				If len(aRetPECab) > 0
					aDadBEA := aRetPECab[1]
					aDadBE4 := aRetPECab[2]
				EndIf
			EndIf
		// Ajusta os Itens da matriz adadite para acos
			If Len(aCols) == 0
				aVetTrab := {}
				aTrbDF   := {}
				For nY := 1 To Len(aDadIte)
				// Verifica se o procedimento existe
					AaDd(aCols, Array(Len(aHeader)+1) )
				// Marca como nao deletado
					aCols[ Len(aCols),Len(aCols[Len(aCols)]) ] := .F.
				// Ajusta aCols
					For nX := 1 To Len(aDadIte[nY])
						nPos := PLRETPOS(aDadIte[nY,nX,1],aHeader,.F.)
						If nPos > 0
							aCols[Len(aCols),nPos] := aDadIte[nY,nX,2]
						EndIf
					Next
					AaDd(aVetTrab,0)
				
					If cTipo == "4"
						cSeq   := U_CBRETDAD(aDadIte[nY],"BE2_SEQUEN")
						cDente := U_CBRETDAD(aDadIte[nY],"BE2_DENREG")
						cFace  := U_CBRETDAD(aDadIte[nY],"BE2_FADENT")
						cCodPad:= U_CBRETDAD(aDadIte[nY],"BE2_CODPAD")
						cCodPro:= U_CBRETDAD(aDadIte[nY],"BE2_CODPRO")
						AaDd(aDadDF,Array( Len(aCabDF)+1))
					
						aDadDF[ Len(aDadDF),Len(aDadDF[Len(aDadDF)]) ] := .F.
					
						If ( nPosRet := PLRETPOS("BYS_SEQUEN",aCabDF,.F.) ) > 0
							aDadDF[ Len(aDadDF),nPosRet ] := cSeq
						EndIf
					
						If ( nPosRet := PLRETPOS("BYS_CODIGO",aCabDF,.F.) ) > 0
							aDadDF[ Len(aDadDF),nPosRet ] := cDente
						Endif
					
						If B04->(MsSeek(XFILIAL("B04")+cDente))
							If ( nPosRet := PLRETPOS("BYS_DESCRI",aCabDF,.F.) ) > 0
								aDadDF[ Len(aDadDF),nPosRet ] := B04->B04_DESCRI
							EndIf
							If ( nPosRet := PLRETPOS("BYS_TIPO",aCabDF,.F.) ) > 0
								aDadDF[ Len(aDadDF),nPosRet ]   := B04->B04_TIPO
							EndIf
							If ( nPosRet := PLRETPOS("BYS_SEGMEN",aCabDF,.F.) ) > 0
								aDadDF[ Len(aDadDF),nPosRet ] := B04->B04_SEGMEN
							EndIf
							If ( nPosRet := PLRETPOS("BYS_DESSEG",aCabDF,.F.) ) > 0
								aDadDF[ Len(aDadDF),nPosRet ] := B04->B04_DESSEG
							EndIf
							If ( nPosRet := PLRETPOS("BYS_M_ARCO",aCabDF,.F.) ) > 0
								aDadDF[ Len(aDadDF),nPosRet ] := B04->B04_M_ARCO
							EndIf
							If ( nPosRet := PLRETPOS("BYS_DESARC",aCabDF,.F.) ) > 0
								aDadDF[ Len(aDadDF),nPosRet ] := B04->B04_DESARC
							EndIf
						EndIf
					
						If ( nPosRet := PLRETPOS("BYS_FACES",aCabDF,.F.) ) > 0
							aDadDF[ Len(aDadDF),nPosRet ] := cFace
						EndIf
						If ( nPosRet := PLRETPOS("BYS_CODPAD",aCabDF,.F.) ) > 0
							aDadDF[ Len(aDadDF),nPosRet ] := cCodPad
						EndIf
						If ( nPosRet := PLRETPOS("BYS_CODPSA",aCabDF,.F.) ) > 0
							aDadDF[ Len(aDadDF),nPosRet ] := cCodPro
						EndIf
						AaDd(aTrbDF,0)
					EndIf
				Next
			EndIf
		// Se tem algum procedimento
			If Len(aCols) > 0
			// Criticas
				If Len(aCriticas) > 0
					If (cTipGuiaOriginal == '11') //guia nova de prorrogação
						u_CBDADCRI("BQZ",aCriticas,aCabCri,aDadCri,aTrbCri,"BQZ_SEQUEN","BQZ_CODGLO","BQZ_DESGLO","BQZ_INFGLO",IIF(lPtuOnline .And. BQZ->( FieldPos("BQZ_CODEDI") ) > 0,"BQZ_CODEDI",NIL))
					Else
						u_CBDADCRI("BEG",aCriticas,aCabCri,aDadCri,aTrbCri,"BEG_SEQUEN","BEG_CODGLO","BEG_DESGLO","BEG_INFGLO",IIF(lPtuOnline .And. BEG->( FieldPos("BEG_CODEDI") ) > 0,"BEG_CODEDI",NIL))
					EndIf
				EndIf
			// Transacao online
				If ! Empty(cNomUsrIE)
					BA1->(RecLock("BA1",.F.))
					BA1->BA1_NOMUSR := cNomUsrIE
					BA1->(MsUnLock())
				Endif
			// Inicia a Transacao
				Begin Transaction
									
					// Exclui guia e o contas
					If cTpLibToAut == "T"
						// Exclui guia
						aRet090 := PLSA090Grv( aColsLib,aHeaderLib,{},K_Excluir,aVetTrabLib,{},cMatric,dDatPro,cHora,"1",cAno,;
							cMes,cTipGui,.F.,/*aDadCri*/,/*aCabCri*/,/*aTrbCri*/,/*lAutori*/,/*cTipoRotEsp*/,;
											/*cCodLDP*/,/*lReanaliza*/,/*cFiltro*/,/*cKey*/,lforBlo,/*lVeioComu*/,lNMudFase,;
											/*cAliasIte*/,/*cAliasCri*/,/*lAjusta*/,/*lEvolu*/,/*aDadBE4*/,/*lGerSenha*/,lWeb,;
											/*aDadB43*/,/*aCabB43*/,/*aTrbB43*/,/*oBrwEven*/,.F.,/*oBrwB47*/,/*cAliasCab*/,;
											/*lReembolso*/,/*oBrwB46*/,/*oBrwB44*/,lIncNeg,/*cObsoleto*/,lSolicit,cTipoGrv,;
											aDadDF,aCabDF,aTrbDF,nil,nil,nil,nil,NIL,NIL,NIL,NIL,NIL,lEvoSADT,IIF(lPtuOnline,"3",nil),;
											/*lProtoc*/,/*aPartic*/)
						lProRadio := aRet090[12]
						lAudi:=aRet090[9]	  
					EndIf
				// Quando for Total a acols de gravacao tem que ser a mesma da lib
				If Len(aColsLib) > 0 .And. cTpLibToAut == "T"
					
					cCampos := PLSA090Fld(cTipo)
					nPosSeq := PLRETPOS("BE2_SEQUEN",aHeaderLib,.F.)
					nPosPad := PLRETPOS("BE2_CODPAD",aHeaderLib,.F.)
					nPosPro := PLRETPOS("BE2_CODPRO",aHeaderLib,.F.)
					nPosDen := PLRETPOS("BE2_DENREG",aHeaderLib,.F.)
					nPosFac := PLRETPOS("BE2_FADENT",aHeaderLib,.F.)
					
					If nPosSeq>0 .And. nPosPad>0 .And. nPosPro>0
						For nI:=1 To Len(aCols)
							If ( nPosRet := PLRETPOS("BE2_SEQUEN",aHeader,.F.) ) > 0
								cSeq := aCols[nI,nPosRet]
							EndIf
							If ( nPosRet := PLRETPOS("BE2_CODPAD",aHeader,.F.) ) > 0
								cCodPad	:= aCols[nI,nPosRet]
							EndIf
							If ( nPosRet := PLRETPOS("BE2_CODPRO",aHeader,.F.) ) > 0
								cCodPro	:= aCols[nI,nPosRet]
							EndIf
							If ( nPosRet := PLRETPOS("BE2_DENREG",aHeader,.F.) ) > 0
								cCodDen	:= aCols[nI,nPosRet]
							EndIf
							If ( nPosRet := PLRETPOS("BE2_FADENT",aHeader,.F.) ) > 0
								cCodFac	:= aCols[nI,nPosRet]
							EndIf
							
							If Len(aRetLib[4]) ==  Len(aAutItens)
								nPosCol := Ascan(aColsLib,{|x| AllTrim(x[nPosSeq]+x[nPosPad]+x[nPosPro]) == AllTrim(cSeq+cCodPad+cCodPro) })
							Else
								nPosCol := Ascan(aColsLib,{|x| Alltrim(x[nPosPad])+Alltrim(x[nPosPro])+Alltrim(x[nPosDen])+Alltrim(x[nPosFac]) == AllTrim(cCodPad)+Alltrim(cCodPro)+Alltrim(cCodDen)+Alltrim(cCodFac) })
							EndIf
							If nPosCol>0
								For nY:=1 To Len(aHeader)
									If !( AllTrim(aHeader[nY,2]) $ cCampos)
										Loop
									EndIf
									
									nPos := PLRETPOS(AllTrim(aHeader[nY,2]),aHeaderLib,.F.)
								
								If nPos > 0 .and. AllTrim(aHeader[nY,2]) <> "BE2_QTDPRO" .and. AllTrim(aHeader[nY,2]) <> "BE2_VLRAPR" .and.;
								   AllTrim(aHeader[nY,2]) <> "BE2_VIA" .and. AllTrim(aHeader[nY,2]) <> "BE2_QTDSOL" 
									
										aCols[nI,nY] := aColsLib[nPosCol,nPos]
									EndIf
									
								Next
							Endif
							//na execucao de uma sadt o saldo tem q ser zero, so tem q atualizar o saldo da liberacao
							If PLRETPOS("BE2_SALDO",aHeader,.F.) > 0 .And. PLRETPOS("BE2_QTDSOL",aHeader,.F.)> 0 .And. PLRETPOS("BE2_QTDPRO",aHeader,.F.) > 0
								aCols[nI,PLRETPOS("BE2_SALDO",aHeader,.F.)] := If(!Empty(cNumLib) .and. (lInter .or. lEvolu .or. lHonor),Acols[nI,PLRETPOS("BE2_QTDSOL",aHeader,.F.)]-Acols[nI,PLRETPOS("BE2_QTDPRO",aHeader,.F.)],0)
							EndIf
							
							//na execução, caso tenha sido incluída a via de acesso, a porcentagem do valor da
							//via também deve ser atualizada de acordo com o cadastro (Tab. BGR)
							If PLRETPOS("BE2_VIA",aHeader,.F.) > 0 .And. PLRETPOS("BE2_PERVIA",aHeader,.F.) > 0 .And. !Empty(aCols[nI,PLRETPOS("BE2_VIA",aHeader,.F.)])
								aCols[nI,PLRETPOS("BE2_PERVIA",aHeader,.F.)] := 0
								BGR->( DbSetOrder(1) )//BGR_FILIAL + BGR_CODINT + BGR_CODVIA
								If BGR->(MsSeek(xFilial("BGR")+PlsIntPad()+aCols[nI,PLRETPOS("BE2_VIA",aHeader,.F.)]))
									aCols[nI,PLRETPOS("BE2_PERVIA",aHeader,.F.)] := BGR->BGR_PERC
								EndIf
							EndIf
						Next
					Else
						// Se gera log caixa preta
						If lWLIO
							PlsLogFil(Space(03)+"CAMPOS NAO ENCONTRADOS PLRETPOS - BE2_SEQUEN,BE2_CODPAD,BE2_CODPRO" ,__PLSFLOGX)
						EndIf
					EndIf
				EndIf
				// Fim da Transacao
			End Transaction
			// Altera SITUAC para guia de PTU
			If !lOkVerPTU
				cSituacPTU := "3"
			EndIf
			
			If lOnLine .And. Empty(cSituacPTU) .And. !Empty(cAutori)
				If cAutori == "1" .Or. cAutori == "2"
					cSituacPTU := "1"
				Else
					cSituacPTU := "3"
				EndIf
			EndIf
			
			If cTipo == '2'
				
				For nFor2 := 1 To Len(aItens)
					aTpPar  := U_CBRETDAD(aItens[nFor2],"ATPPAR",{})
					
					If LEN(aTpPar) > 0
						
						AADD(aTpPart, aTpPar)
					EndIf
				Next
				
				Store Header "B4B" TO aHeadeB4B For .T.
				
				aDadTemp := Array(11)
				
				For nI1 := 1 To LEN(aTpPart)
					
					For nI2 := 1 To Len(aTpPart[nI1])
						
						aDadTemp := Array(11)
						
						aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_SEQUEN"})] := aTpPart[nI1][nI2][10]
						aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_OPEMOV"})] := cOpeMov
						aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_GRAUPA"})] := aTpPart[nI1][nI2][1]
						aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_SICONS"})] := aTpPart[nI1][nI2][5]
						aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_NUCONS"})] := aTpPart[nI1][nI2][4]
						aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_UFCONS"})] := aTpPart[nI1][nI2][6]
						
						cNomExec := Posicione("BB0",1,xFilial("BB0")+aTpPart[nI1][nI2][7],"BB0_NOME")
						aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_NOMPRF"})] := cNomExec
						aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_CGC"})]    := aTpPart[nI1][nI2][2]
						aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_CDPFPR"})] := aTpPart[nI1][nI2][7]
						
						If LEN(aTpPart[nI1][nI2][11]) > 6
							
							aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_CODESP"})] := SubStr(aTpPart[nI1][nI2][11],4)
						Else
							aDadTemp[Ascan(aHeadeB4B,{|x| AllTrim(x[2]) == "B4B_CODESP"})] := aTpPart[nI1][nI2][11]
						EndIf
						
						aDadTemp[11] := .F.
						
						aadd(aColsB4B, aDadTemp)
						aDadTemp := {}
					Next
				Next
				
				aVetB4B := {0}
			EndIf
			
			// Gravacao
			
			if !lEvolu .or. (lEvolu .and. cTipGuiaOriginal <> '11')
				
				aRet090 := PLSA090Grv(aClone(aCols),aClone(aHeader),aDadBEA,K_Incluir,aClone(aVetTrab),{},aDadUsr[2],dDatPro,cHora,"1",cAno,;
									cMes,cTipGui,lInter,aDadCri,aCabCri,aTrbCri,/*lAutori*/,cOrigem,cCodLDP,;
									iIf(len(aEventosNeg)>0 .And. lIncNeg,.T.,lReanaliza),/*cFiltro*/,/*cKey*/,lForBlo,lVeioComu,lNMudFase,;
									/*cAliasIte*/,/*cAliasCri*/,.T.,lEvolu,aDadBE4,lGerSenha,lWeb,/*aDadB43*/,/*aCabB43*/,/*aTrbB43*/,;
									/*oBrwEven*/,/*lExcluiAte*/,/*oBrwB47*/,/*cAliasCab*/,/*lReembolso*/,/*oBrwB46*/,/*oBrwB44*/,;
									lIncNeg,/*cObsoleto*/,lSolicit,cTipoGrv,aDadDF,aCabDF,aTrbDF,aDaSenPro,lGuiHoRe,/*aMatBd6*/,/*aMatCom*/,;
									/*lResInt*/,/*cAliasCmp*/,iIf(cTipo=="4",.T.,nil),cNuLibera,cArqImp,lEvoSadt,IIF(!Empty(cSituacPTU),cSituacPTU,nil),/*lProtoc*/,;
									/*aPartic*/,aColsB4B,aHeadeB4B,aVetB4B,/*cNumLibOd*/,/*lRecGlo*/,lPTUOnSol,/*cObsEvo*/,/*nNrSeqTR*/,/*cSenhaOpe*/,;
									cOpeSol, cNewAut,lPtuOnline,aCampCust)
									
				// Grava o Recno gerado
				nRecGer := BEA->(RecNo())
				
			    If lAprovLib 
			    
			    	// Posiciona na liberacao original
					BEA->( DbGoTo( nRecBEALIB ) )
					
					// Se for total atualiza o cabecalho da liberacao tb
					If cTpLibToAut == "T"
						PLSATUCS()
					EndIf
					
					// Posiciona na liberacao
					aIndDelCols:= {}
					nPosSeqMov := PLRETPOS("BE2_SEQUEN",aHeader,.F.)
					nPosCodPad := PLRETPOS("BE2_CODPAD",aHeader,.F.)
					nPosCodPro := PLRETPOS("BE2_CODPRO",aHeader,.F.)
					nPosQtdPro := PLRETPOS("BE2_QTDPRO",aHeader,.F.)
					nPosDenPro := PLRETPOS("BE2_DENREG",aHeader,.F.)
					nPosFacPro := PLRETPOS("BE2_FADENT",aHeader,.F.)

					If nPosCodPad > 0 .And. nPosCodPro > 0

						For nFor := 1 To Len(aCols) 
						// So e possivel a verificacao da sequancia quando o array de itens nao foi al-
						// rado no portal.
						// Caso seja necessario a verificacao da sequencia qdo o procedimento e exclui-
						// sera necessario alteracao no java script que faz a exclusao no portal.
							If Len(aRetLib[4]) ==  Len(aAutItens)
								nPos := Ascan(aAutItens,{|x| AllTrim(x[1])+AllTrim(x[2])+AllTrim(x[3])+AllTrim(x[15])+AllTrim(x[16]) == AllTrim(aCols[nFor,nPosSeqMov])+AllTrim(aCols[nFor,nPosCodPad])+AllTrim(aCols[nFor,nPosCodPro])+AllTrim(aCols[nFor,nPosDenPro])+AllTrim(aCols[nFor,nPosFacPro])})
							Else
								nPos := Ascan(aAutItens,{|x| AllTrim(x[2])+AllTrim(x[3])+AllTrim(x[15])+AllTrim(x[16]) == AllTrim(aCols[nFor,nPosCodPad])+AllTrim(aCols[nFor,nPosCodPro])+AllTrim(aCols[nFor,nPosDenPro])+AllTrim(aCols[nFor,nPosFacPro])})
							EndIf

							If nPos > 0
								If aAutItens[nPos,8] .And. aAutItens[nPos,7] > 0

									BE2->( DbGoTo(aAutItens[nPos,7]) )
									nRecBE2 := aAutItens[nPos,7]

									nSaldo  := aAutItens[nPos,5]
									cStaLib := Iif(nSaldo==0,"2","1")

									PLSATUSS( BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI+BEA_ORIMOV)+BE2->(BE2_SEQUEN+BE2_CODPAD+BE2_CODPRO),.T.,.T.,nSaldo,cStaLib,,,,,nRecBE2,,,,)

								EndIf
								If !aAutItens[nPos,8]
									AaDd(aIndDelCols,nFor)
								EndIf
							EndIf
						Next 
						
						// Deleta cols
						If Len(aIndDelCols) > 0
							aCloneCols := aClone(aCols)
							For nFor := 1 To Len(aCloneCols)
								If Ascan(aIndDelCols,nFor) > 0
									nSize := Len(aCols)
									If Len(aCols) >= nFor
										aDel(aCols,nFor)
									Endif
									If Len(aCols)+1 >= (nSize-1)
										aSize(aCols,nSize-1)
									Endif
									nSize := Len(aVetTrab)
									If Len(aVetTrab) >= nFor
										aDel(aVetTrab,nFor)
									Endif
									If Len(aVetTrab)+1 >= (nSize-1)
										aSize(aVetTrab,nSize-1)
									Endif
								Endif
							Next
						Endif
					Else
						Conout("PLSXMOV -> Erro controlado PLSXMOV - Campos BE2_CODPAD e BE2_CODPRO. Campos devem estar em uso no SX3.")
					Endif
					
					//Ajusta o status do cabecalho, se não ajustou lá em cima
					If cTpLibToAut <> "T" .AND. BEA->BEA_TIPGUI == "02" .AND. !PLSSALDO("",BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT))								
						cTpLibToAut := "T"
						PLSATUCS()
					EndIf	
				EndIf	
					
				lProRadio := aRet090[12]
				lAudi:=aRet090[9]
								
				//Retorna ao RECNO gerado no 090GRV
				if nRecGer > 0
					BEA->(DbGoTo(nRecGer))
				endif
				
			else
				
				aRetAux := PLSXVLDCAL(dDataBase,PLSINTPAD(),.T.,"","")
				
				aadd(aDadB4Q,{"B4Q_MATANT",BA1->BA1_MATANT })
				aadd(aDadB4Q,{"B4Q_OPEUSR",BA1->BA1_CODINT })
				aadd(aDadB4Q,{"B4Q_CODEMP",BA1->BA1_CODEMP })
				aadd(aDadB4Q,{"B4Q_CONEMP",BA1->BA1_CONEMP })
				aadd(aDadB4Q,{"B4Q_SUBCON",BA1->BA1_SUBCON })
				aadd(aDadB4Q,{"B4Q_VERCON",BA1->BA1_VERCON })
				aadd(aDadB4Q,{"B4Q_VERSUB",BA1->BA1_VERSUB })
				aadd(aDadB4Q,{"B4Q_MATRIC",BA1->BA1_MATRIC })
				aadd(aDadB4Q,{"B4Q_TIPREG",BA1->BA1_TIPREG })
				aadd(aDadB4Q,{"B4Q_DIGITO",BA1->BA1_DIGITO })
				aadd(aDadB4Q,{"B4Q_NOMUSR",BA1->BA1_NOMUSR })
				aadd(aDadB4Q,{"B4Q_CANCEL",'0' })
				aadd(aDadB4Q,{"B4Q_ANOPAG",aRetAux[4] })
				aadd(aDadB4Q,{"B4Q_MESPAG",aRetAux[5] })
				
				PRIVATE aAutForAnx 	:= {}
				PRIVATE aCodCriHis 	:= {}
				
				
				aHeadeBQV := aClone(aHeader)
				
				
				nCpf	:= PLRETPOS("BEA_CDPFSO",aDadBEA,.F.)
				nEst   := PLRETPOS("BEA_ESTSOL",aDadBEA,.F.)
				nOpe   := PLRETPOS("BEA_OPESOL",aDadBEA,.F.)
				nReg   := PLRETPOS("BEA_REGSOL",aDadBEA,.F.)
				nNom   := PLRETPOS("BEA_NOMSOL",aDadBEA,.F.)
				nSigla := PLRETPOS("BEA_SIGLA",aDadBEA,.F.)
				
				
				for nFor2 := 1 to len(aHeadeBQV)
					aHeadeBQV[nFor2][2] := "BQV_" + substr(aHeadeBQV[nFor2][2], 5)
				next
				
				for nFor2 := 1 to len(aDadBEA)
					if aDadBEA[nFor2][1] = "BEA_ESTSOL"
						M->B4Q_ESTSOL := aDadBEA[nFor2][2]
					else
						if aDadBEA[nFor2][1] = "BEA_REGSOL"
							M->B4Q_REGSOL := aDadBEA[nFor2][2]
						else
							if aDadBEA[nFor2][1] = "BEA_NOMSOL"
								M->B4Q_NOMSOL := aDadBEA[nFor2][2]
							else
								if aDadBEA[nFor2][1] = "BEA_SIGLA"
									M->B4Q_SIGLA  := aDadBEA[nFor2][2]
								else
									if aDadBEA[nFor2][1] = "BEA_DATPRO"
										M->B4Q_DATPRO  := aDadBEA[nFor2][2]
									else
										if aDadBEA[nFor2][1] = "BEA_CODRDA"
											M->B4Q_CODRDA  := aDadBEA[nFor2][2]
										else
											if aDadBEA[nFor2][1] = "BEA_NOMRDA"
												M->B4Q_NOMRDA  := aDadBEA[nFor2][2]
											else
												if aDadBEA[nFor2][1] = "BEA_DATNAS"
													M->B4Q_IDADE	:= Calc_Idade(dDataBase,aDadBEA[nFor2][2])
												endif
											endif
										endif
									endif
								endif
							endif
						endif
					endif
				next
				
				M->B4Q_GUIREF := cNuLibera
				
				M->B4Q_SEXO   := cSexo
				M->B4Q_OPESOL := cOpeSol
				M->B4Q_CDPFSO := cCDPFSO
				
				M->B4Q_DATSOL := Date()
				M->B4Q_INDCLI := cIndCli
				M->B4Q_TIPACO := cPadInt
				
				aRet090 := PLSA09PGRV(K_Incluir,cOpeSol,'BQV'/*'BE2'*/,'B4Q','BQZ',aDadB4Q,aHeadeBQV/*aClone(aHeader)*//*aHeadIten*/,aClone(aCols)/*aColsIten*/,aClone(aVetTrab),aCabCri,aDadCri,aTrbCri,;
					                  "11",dDataBase,aRetAux[4],aRetAux[5],aChaveGen,nQtdDiSol)
				lAudi := Iif( Len(aRet090) >= 9,aRet090[9],.F.)
			endif
			// Fecha Semaforo
			DbCommitAll()
			
			//Conclui um protocolo
			If !Empty(cProtoc)
				If lInter
					gerRegB00(cProtoc,,'BE4',,,BEA->(BEA_OPEMOV + BEA_CODEMP + BEA_MATRIC + BEA_TIPREG + BEA_DIGITO),,,,,,,,,,,,,,.T.) // Gera registro na B00
					P773AutCon('BE4',cProtoc,BEA->(BEA_OpeMov+BEA_AnoAut+BEA_MesAut+BEA_NumAut)) //Atualiza a guia com o número do protocolo
				Else
					gerRegB00(cProtoc,,'BEA',,,BEA->(BEA_OPEMOV + BEA_CODEMP + BEA_MATRIC + BEA_TIPREG + BEA_DIGITO),,,,,,,,,,,,,,.T.) // Gera registro na B00
					P773AutCon('BEA',cProtoc,BEA->(BEA_OpeMov+BEA_AnoAut+BEA_MesAut+BEA_NumAut)) //Atualiza a guia com o número do protocolo
				EndIf
			EndIf
			// Alimenta participacao para o hm quando na execucao do importacao xml
			// Somente quando for raio-x o indicado para este tipo de evente vir em uma guia separada
			If Len(aTpParG) > 0 .And. cTipo == '2'
				
				cNumPeg := BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI)
				
				BD6->( DbSetOrder(6) )//BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_CODPAD + BD6_CODPRO
				For nFor2 := 1 To Len(aItens)
					cCodPad := U_CBRETDAD(aItens[nFor2],"CODPAD")
					cCodPro := U_CBRETDAD(aItens[nFor2],"CODPRO")
					
					// Posiciona no bd6
					BD6->( MsSeek(xFilial("BD6")+cNumPeg+"1"+cCodPad+cCodPro) )
					
					// Define participacao no bd7
					PLSPARBD7(cNumPeg+BD6->(BD6_ORIMOV+BD6_SEQUEN),aUnMed,aTpParG,cLocalExec,cTipoGrv)
				Next
			EndIf
			
			// Alimenta participacao para o hm quando na execucao do importacao xml
			// Somente quando for raio-x o indicado para este tipo de evente vir em uma guia separada
			If cTipo == '2'
				
				cNumPeg := BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI)
				
				BD6->( DbSetOrder(6) )//BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_CODPAD + BD6_CODPRO
				For nFor2 := 1 To Len(aItens)
					cCodPad := U_CBRETDAD(aItens[nFor2],"CODPAD")
					cCodPro := U_CBRETDAD(aItens[nFor2],"CODPRO")
					aTpPar  := U_CBRETDAD(aItens[nFor2],"ATPPAR",{})
					
					If len(aTpPar) > 0
						
						// Posiciona no bd6
						BD6->( MsSeek(xFilial("BD6")+cNumPeg+"1"+cCodPad+cCodPro) )
						
						// Define participacao no bd7
						PLSPARBD7(cNumPeg+BD6->(BD6_ORIMOV+BD6_SEQUEN),aUnMed,aTpPar,cLocalExec,cTipoGrv)
					EndIf
				Next
			EndIf
			
		Else
			// Se gera log caixa preta
			If lWLIO
				PlsLogFil(Space(03)+"NENHUM PROCEDIMENTO ENCONTRADO NA MATRIZ ACOLS" ,__PLSFLOGX)
				PlsLogFil("",__PLSFLOGX)
			EndIf
		EndIf
	Endif
	
	// Transacoes online
	If lIncUso
		aEventosAut := {}
	EndIF
	
	// Reanaliza
	If lRetVPF .And. lReanaliza .And. Len(aEventosAut) > 0
		BD6->( DbSetOrder(1) )//BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO
		If BD6->(MsSeek(xFilial("BD6")+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI+BEA_ORIMOV)))
			While ! BD6->(Eof()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == ;
					xFilial("BD6")+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI+BEA_ORIMOV)
				
				If BD6->BD6_VLRTPF > 0 .And. BD6->BD6_BLOCPA <> "1"
				
					nPos := Ascan(aEventosAut,{|x| x[1] == BD6->BD6_SEQUEN })
					If nPos > 0
						nVlrTPF += BD6->BD6_VLRTPF
					EndIf
					
				EndIf
				
				nPos := Ascan(aItens,{|x| alltrim(U_CBRETDAD(x,"CODPAD")) == alltrim(BD6->BD6_CODPAD) .AND. alltrim(U_CBRETDAD(x,"CODPRO")) == alltrim(BD6->BD6_CODPRO) })
				
				If nPos > 0
				
					cSlvPad := U_CBRETDAD(aItens[nPos],"SLVPAD",'')
					cSlvPro := U_CBRETDAD(aItens[nPos],"SLVPRO",'')
				
					If !Empty(cSlvPad)
						BD6->(Reclock("BD6",.F.))
						BD6->BD6_SLVPAD := cSlvPad
						BD6->BD6_SLVPRO := cSlvPro
						
						If cTipo == '2' .AND. !EMPTY(U_CBRETDAD(aItens[nPos],"DATPRO")) //INI 29-03
							BD6->BD6_DATPRO := U_CBRETDAD(aItens[nPos],"DATPRO")
							
							BD7->(DbSetOrder(1))
							If BD7->(MsSeek(xFilial('BD6')+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
								BD7->(Reclock("BD7",.F.))
								BD7->BD7_DATPRO := U_CBRETDAD(aItens[nPos],"DATPRO") //FIM 29-03
								BD7->(MsUnlock())
							EndIf
						EndIf//FIM 29-03
						
						BD6->(MsUnlock())
					Endif
				Endif
				BD6->(DbSkip())
			EndDo
			
			If nVlrTPF > 0
				// Se gera log caixa preta
				If lWLIO
					PlsLogFil(Space(03)+ "",__PLSFLOGX)
					PlsLogFil(Space(03)+ "VALOR APRESENTADO DOS ITENS AUTORIZADOS, AJUSTADO COM BASE NO BD6_VLRTPF!",__PLSFLOGX)
				EndIf
			EndIf
		EndIf
	EndIf
	// Na evolucao existe a necessidade da senha por procedimento
	If lEvolu
		For nI:=1 To Len(aDaSenPro)
			If ( nPos := Ascan(aEventosAut,{|x| x[1]+x[2]+x[3] == aDaSenPro[nI,1] }) ) > 0
				aEventosAut[nPos,9] := aDaSenPro[nI,2]
			EndIf
		Next
	EndIf
	// Gravacao das criticas em um arquivo de controle
	If !Len(aEventosAut) > 0 .And. GetNewPar("MV_PLSGRVC","1") == "1"
		cRetCriMv := U_CBGRVAUN(.F.,"",cMatric,dDatPro,cHora,cOpeMov,cCidPri,cCodRda,cOpeSol,cCdPFSO,cCodEsp,aItens,aCriticas,cLocalExec,cTipoGrv)
	Endif
	// Monta retorno da funcao quando for servico tb deve ser exibida
	If cRetGui == "1" .And. cSomInt <> "1"
		cMsgClient := STR0027 //"Guia valida com autorizacao da empresa anexa"
	Endif
	// Coloca no procedimento original os procedimentos originais
	If Len(aMatTroca) > 0
		For nFor:=1 To Len(aMatTroca)
			If Len(aCriticas) > 0
				If ( nPos := Ascan(aCriticas,{|x| AllTrim(x[1]+x[4]+x[5]+x[6]+x[7]) == AllTrim(aMatTroca[nFor,1]+aMatTroca[nFor,2]+aMatTroca[nFor,4]+aMatTroca[nFor,5]+aMatTroca[nFor,6]) } ) ) > 0
					aCriticas[nPos,5] := aMatTroca[nFor,3]
				EndIf
			EndIf
			If Len(aEventosAut) > 0
				If ( nPos := Ascan(aEventosAut,{|x| AllTrim(x[1]+x[2]+x[3]+x[7]+x[8]) == AllTrim(aMatTroca[nFor,1]+aMatTroca[nFor,2]+aMatTroca[nFor,4]+aMatTroca[nFor,5]+aMatTroca[nFor,6]) } ) ) > 0
					aEventosAut[nPos,3] := aMatTroca[nFor,3]
				EndIf
			EndIf
			If Len(aEventosNeg) > 0
				If ( nPos := Ascan(aEventosNeg,{|x| AllTrim(x[1]+x[2]+x[3]+x[7]+x[8]) == AllTrim(aMatTroca[nFor,1]+aMatTroca[nFor,2]+aMatTroca[nFor,4]+aMatTroca[nFor,5]+aMatTroca[nFor,6]) } ) ) > 0
					aEventosNeg[nPos,3] := aMatTroca[nFor,3]
				EndIf
			EndIf
			// Se gera log caixa preta
			If lWLIO
				If lLogTro
					lLogTro := .F.
					PlsLogFil(Space(03)+"RETORNADO O CODIGO ORIGINAL ( MV_PLSTRCO REFERENTE AO BR8_CODEDI )" ,__PLSFLOGX)
					PlsLogFil(Space(03),__PLSFLOGX)
				EndIf
				PlsLogFil(Space(03)+"TROCA - "+aMatTroca[nFor,4]+" ORIGINAL - "+aMatTroca[nFor,3],__PLSFLOGX)
			EndIf
		Next
	EndIf
EndIf

// Numero de autorizacao de retorno
If (lImpXml .or. lImpTxt) .and. cTipGui $ "01#02#05#06#04"
	cAutRet := 	cNumGuiH
	// Eventos Autorizados
	AaDd(aEventosAut,{'001','00','000000',0,'',0,'','',""})
	// Informacoes para importacao de HONORARIO
	cDesc := ""
	BCL->(DbSetORder(1))
	If BCL->(MsSeek(xFilial('BCL')+cOpeMov+cTipGui))
		cDesc := BCL->BCL_DESCRI
	Endif
	
	AaDd(aMatInf,{"TIPO DE GUIA",cDesc})
	aaDd(aMatInf, {'ORIGEM' , Iif(cOrigem=='1','EXECUCAO','SOLICITACAO') } )
	
	AaDd(aMatInf, {Replicate('-',60) , "NIL" } )
	AaDd(aMatInf, {'CONTRATADO' , "NIL" } )
	AaDd(aMatInf, {'OPE. RDA' , cOpeMov } )
	AaDd(aMatInf, {'COD. RDA' , cCodRda } )
	
	AaDd(aMatInf, {'LOCAL ATENDIMENTO', cDesLocPro } )
	AaDd(aMatInf, {'LOCAL DIGITACAO', BD5->BD5_CODLDP } )
	AaDd(aMatInf, {'PROTOCOLO', BD5->BD5_CODPEG } )
	AaDd(aMatInf, {'GUIA', BD5->BD5_NUMERO } )
	AaDd(aMatInf, {'NUM. GUIA PRESTADOR ', cNumImp } )
	AaDd(aMatInf, {'NUM. SOLICITACAO ', cNumSol } )
	
	AaDd(aMatInf, {Replicate('-',60) , "NIL" } )
	
	AaDd(aMatInf, {'MATRICULA' , cMatric } )
	AaDd(aMatInf, {'NOME USU.' , Upper(cNomUsrCar) } )
	AaDd(aMatInf, {'VIA CARTÃO' , cViaCartao } )
	
	AaDd(aMatInf, {'CID' , cCidPri } )
	If !Empty(cCidPri)
		AaDd(aMatInf, {Replicate('-',60) , "NIL" } )
	EndIf
	
	nVAprTot := 0
	For nFor := 1 To Len(aItens)
		nVlrApr	:= U_CBRETDAD(aItens[nFor],"VLRAPR",0)
		nVAprTot+= nVlrApr
	Next
	AaDd(aMatInf, {'VALOR TOTAL APR', AllTrim( Str(nVAprTot) ) } )
	
	// Ponto de entrada para implementacao de mais informacoes para o log do xml
	If  ExistBlock("PLSXMINF")
		aMatInf := ExecBlock("PLSXMINF",.F.,.F.,{aDados,aItens,aMatInf} )
	EndIf
	
ElseIf lHonor
	If Len(aRetHon)>0
		cAutRet := 	aRetHon[2]+aRetHon[3]+aRetHon[4]+aRetHon[5]
	EndIf
ElseIf nRecBeaIni <> BEA->(Recno()) .And. lInter
	cAutRet := BEA->(BEA_OPEMOV+BEA_ANOINT+BEA_MESINT+BEA_NUMINT)
ElseIf lEvolu
	if cTipGuiaOriginal = '11'
		cAutRet := B4Q->(B4Q_OPEMOV+B4Q_ANOAUT+B4Q_MESAUT+B4Q_NUMAUT)
	else
		cAutRet := BEA->(BEA_OPEMOV+BEA_ANOINT+BEA_MESINT+BEA_NUMINT)
	endif
ElseIf lFindRes
	cAutRet := BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
ElseIf nRecBeaIni <> BEA->(Recno())
	cAutRet := BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)
EndIf
// Se Ptu Online verifica informacacoes adicionais
If lPtuOnline
	// Tipo de acomodacao que o beneficiario tem direito
	AaDd(aMatInf,Space(1)+"C")//Padrao nao se aplica
	If len(aDadUsr) > 0
		BI3->(DbSetOrder(1))//BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO
		If BI3->(DbSeek(xFilial("BI3")+PlsIntPad()+aDadUsr[11]+aDadUsr[12]))
			BI4->(DbSetOrder(1))//BI4_FILIAL + BI4_CODACO
			If BI4->(DbSeek(xFilial("BI4")+BI3->BI3_CODACO))
				If BI4->( FieldPos("BI4_CODEDI") ) > 0
					aMatInf[1] := IIF(BI4->BI4_CODEDI == "2",Space(1)+"A",Space(1)+"B")
				EndIf
			EndIf
		EndIf
	EndIf
	// Informa Data de Internacao
	If lInter .And. len(aEventosAut) > 0
		aArea := GetArea()
		PLSA92DtIn(.F.,Date(),Left(Time(),5),.T.)
		lGerSenha := .T.
		RestArea(aArea)
	EndIf
EndIf

If lGerSenha .And. len(aDadUsr) > 44 .And. GetNewPar("MV_PLSUNI","1") == "1" .And. (aDadUsr[45] <> PlsIntPad() .Or. BEA->BEA_TIPPRE == GetNewPar("MV_PLSTPIN","OPE"))
	dDatRet := dDatabase+GetNewPar("MV_PLPRZPT",30)
	If lInter .And. BE4->( FieldPos("BE4_DATVAL") ) > 0  .and. !Empty(BE4->BE4_DATVAL)
		dDatRet := BE4->BE4_DATVAL
	elseIf BEA->( FieldPos("BEA_VALSEN") ) > 0  .and. !Empty(BEA->BEA_VALSEN)
		dDatRet := BEA->BEA_VALSEN
	Endif
Else
	dDatRet := dDatabase+GetNewPar("MV_PLPRZLB",30)
EndIf

// Retorno
aRetorno := {Len(aEventosAut)>0,;																//1
			cAutRet,; 																			//2
			Iif((nRecBeaIni<>BEA->(Recno()) .Or. lFindRes .Or. lEvolu) .And. !lHonor, IIF((lPTUONLINE),BEA->BEA_NRAOPE,BEA->BEA_SENHA),""),;//3
			aCriticas,;                                                                 		//4
			aEventosAut,;                                                               		//5
			aEventosNeg,;                                                               		//6
			nVlrTPF,;                                                                   		//7
			cRetCriMv,;                                                                 		//8
			cMsgClient,;                                                                		//9
			aMatInf,;                                                                     		//10
			lAto,;																				//11
			dDPrAH,;                                                                    		//12
			AllTrim( Str(nQtdDiAut) ),;                                                   		//13
			Iif(lGerSenha,dDatRet,CtoD("")) ,;													//14
			"",;																				//15 - essa posição na versão 11 é utilizada.. na 12 está disponível
			lProRadio,;																			//16
			lAudi }																			//16				  									
// Se gera log caixa preta
If lWLIO
	PlsLogFil(Space(03)+Replicate("-",60),__PLSFLOGX)
	PlsLogFil(Space(03)+"VERSAO"+Space(35-Len("VERSAO"))+"["+cVersao+"]" ,__PLSFLOGX) //"-> Inicio da Transacao                   -> Data : "###" Hora : "
	
	If Len(aEventosAut)>0
		If lResInt
			cMsg := " ORIGINAL"
		EndIf
		PlsLogFil(Space(03)+"AUTORIZACAO/LIBERACAO"+cMsg+Space(35-Len("AUTORIZACAO/LIBERACAO"+cMsg))+"["+aRetorno[2]+"]",__PLSFLOGX)
		PlsLogFil(Space(03)+"CHAVE 1 C. MEDICAS"+Space(35-Len("CHAVE 1 C. MEDICAS"))+"["+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI+BEA_ORIMOV)+"]",__PLSFLOGX)
		
		PlsLogFil(Space(03)+"SENHA"+cMsg+Space(35-Len("SENHA"+cMsg))+"["+AllTrim(aRetorno[3])+"]",__PLSFLOGX)
	EndIf
	
	PlsLogFil(Space(03)+"TRANSACAO"+Space(35-Len("TRANSACAO"))+"["+Iif( cOrigem=='1','EXECUCAO','SOLICITACAO')+"]",__PLSFLOGX)
	PLSLOGFIL(space(3)+"TIPO DE GUIA"+space(35-len("TIPO DE GUIA"))+"["+iif(LEVOLU,"PRORROGACAO",iif(LHONOR,"HONORARIO INDIVIDUAL",iif(LRESINT,"RESUMO DE INTERNACAO",iif(LINTER,"INTERNACAO",iif(LCONSULTA,"CONSULTA",iif(CTIPO=="4","ODONTOLOGICO","SADT"))))))+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"OPERACAO"+Space(35-Len("OPERACAO"))+"["+Iif( cTipoGrv=='1','REMOTE',Iif(cTipoGrv=='2','WEB',Iif(cTipoGrv=='3','POS','IMPORTACAO' ) ) )+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"INCLUIR NEG"+Space(35-Len("INCLUIR NEG"))+"["+Iif( lIncNeg,'SIM','NAO')+"] (SOMENTE PARA ALGUMAS CRITICAS DE ITEM)",__PLSFLOGX)
	PlsLogFil(Space(03)+"LOAD DADRDA"+Space(35-Len("LOAD DADRDA"))+"["+Iif( lLoadRda,'SIM','NAO')+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"cTpLibToAut"+Space(35-Len("cTpLibToAut"))+"["+cTpLibToAut+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"cGuiaOri"+Space(35-Len("cGuiaOri"))+"["+cGuiaOri+"]",__PLSFLOGX)
	PlsLogFil(space(03)+"TipGui"+Space(35-len("TipGui"))+"["+cTipGui+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lMatGer"+Space(35-Len("lMatGer"))+"["+if(lMatGer,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lUsuGer"+Space(35-Len("lUsuGer"))+"["+if(lUsuGer,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"cMatUsa"+Space(35-Len("cMatUsa"))+"["+cMatUsa+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"cOpeOri"+Space(35-Len("cOpeOri"))+"["+cOpeOri+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"cRetGui"+Space(35-Len("cRetGui"))+"["+cRetGui+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"cSomInt"+Space(35-Len("cSomInt"))+"["+cSomInt+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"cLocal RDA"+Space(35-Len("cLocal RDA"))+"["+cLocal+"."+cCodLoc+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"nVlrTPF"+Space(35-Len("nVlrTPF"))+"["+AllTrim(Str(nVlrTPF))+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"cCodEsp"+Space(35-Len("cCodEsp"))+"["+cCodEsp+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"cOriMov"+Space(35-Len("cOriMov"))+"["+cOriMov+"]",__PLSFLOGX)
	
	If !Empty(cDesLocPro)
		PlsLogFil(Space(03)+"cLocal PROF"+Space(35-Len("cLocal PROF"))+"["+Left(cDesLocPro,7)+"]",__PLSFLOGX)
		PlsLogFil(Space(03)+"cCodEspPro"+Space(35-Len("cCodEspPro"))+"["+cCodEspPro+"]",__PLSFLOGX)
	EndIf
	
	If !lResInt
		PlsLogFil(Space(03)+"lAprovLib"+Space(35-Len("lAprovLib"))+"["+if(lAprovLib,"SIM","NAO")+"]",__PLSFLOGX)
	EndIf
	
	PlsLogFil(Space(03)+"lRdaProf"+Space(35-Len("lRdaProf"))+"["+IiF(lRdaProf,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lTrtExe"+Space(35-Len("lTrtExe"))+"["+IiF(lTrtExe,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lTrtCCl"+Space(35-Len("lTrtCCl"))+"["+IiF(lTrtCCl,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lOpe"+Space(35-Len("lOpe"))+"["+IiF(lUnimeds,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lOPMM"+Space(35-Len("lOPMM"))+"["+IiF(lOPMM,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lInter"+Space(35-Len("lInter"))+"["+IiF(lInter,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lResInt"+Space(35-Len("lResInt"))+"["+IiF(lResInt,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lEvolu"+Space(35-Len("lEvolu"))+"["+IiF(lEvolu,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lHonor"+Space(35-Len("lHonor"))+"["+IiF(lHonor,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lConsulta"+Space(35-Len("lConsulta"))+"["+IiF(lConsulta,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lOdonto"+Space(35-len("lOdonto"))+"["+Iif(cOriMov=="4","SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lRetVPF"+Space(35-Len("lRetVPF"))+"["+IiF(lRetVPF,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lReanaliza"+Space(35-Len("lReanaliza"))+"["+IiF(lReanaliza,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lFindRes"+Space(35-Len("lFindRes"))+"["+IiF(lFindRes,"SIM","NAO")+"]",__PLSFLOGX)
	PlsLogFil(Space(03)+"lOnLine"+Space(35-Len("lOnLine"))+"["+IiF(lOnLine,"SIM","NAO")+"]",__PLSFLOGX)
	// Log da transacao online
	If cOpeOri <> PLSINTPAD() .And. !Empty(cOpeOri)
		PlsLogFil(Space(03)+Replicate("-",60),__PLSFLOGX)
		PlsLogFil(Space(03)+"TRANSACAO DE INTERCAMBIO ENTRE OPERADORAS" ,__PLSFLOGX)
		PlsLogFil(Space(03)+"ON-LINE"+Space(35-Len("ON-LINE"))+"["+Iif( lOnTLine,'SIM','NAO')+"] " ,__PLSFLOGX)
		PlsLogFil(Space(03)+"SUCESSO TRAN."+Space(35-Len("SUCESSO TRAN."))+"["+Iif( lOnLine,'SIM','NAO')+"]" ,__PLSFLOGX)
		PlsLogFil(Space(03)+"VEIO COMUNI"+Space(35-Len("VEIO COMUNI"))+"["+Iif( lVeioComu,'SIM','NAO')+"]" ,__PLSFLOGX)
		PlsLogFil(Space(03)+"TRAN ORIGEM"+Space(35-Len("TRAN ORIGEM"))+"["+cNrSeqTR+"]" ,__PLSFLOGX)
		PlsLogFil(Space(03)+"TRAN RETORNO"+Space(35-Len("TRAN RETORNO"))+"["+cSenhaOpe+"]" ,__PLSFLOGX)
		PlsLogFil(Space(03)+"MENSAGEM"+Space(35-Len("MENSAGEM"))+"["+cMsg03+"]" ,__PLSFLOGX)
		PlsLogFil(Space(03)+Replicate("-",60),__PLSFLOGX)
		PlsLogFil(Space(03)+"VALOR TOTAL PARTICIPACAO FINANCEIRA ["+AllTrim(Str(aRetorno[7],17,2))+"]",__PLSFLOGX)
		PlsLogFil(Space(03)+"NUMERO DE CONTROLE NO ARQUIVO DE CRITICAS (BXE/BXF) ["+cRetCriMv+"]",__PLSFLOGX)
		PlsLogFil(Space(03)+"MENSAGEM CLIENTE (OPCIONAL) ["+cMsgClient+"]",__PLSFLOGX)
		PlsLogFil("",__PLSFLOGX)
	EndIf
	// Log
	If Len(aCols)>0
		PlsLogFil("",__PLSFLOGX)
		PlsLogFil(Space(03)+"ITENS NA MATRIZ ACOLS",__PLSFLOGX)
		For nI:=1 To Len(aCols)
			cSeqMov 	:= aCols[nI,Ascan(aHeader,{|x| AllTrim(x[2]) == "BE2_SEQUEN"})]
			cCodPad 	:= aCols[nI,Ascan(aHeader,{|x| AllTrim(x[2]) == "BE2_CODPAD"})]
			cCodPro 	:= aCols[nI,Ascan(aHeader,{|x| AllTrim(x[2]) == "BE2_CODPRO"})]
			cHoraPro	:= aCols[nI,Ascan(aHeader,{|x| AllTrim(x[2]) == "BE2_HORPRO"})]
			cDente 		:= aCols[nI,ascan(aHeader,{|X| ALLTRIM(x[2]) == "BE2_DENREG"})]
			cFace 		:= aCols[nI,ascan(aHeader,{|X| ALLTRIM(x[2]) == "BE2_FADENT"})]
			
			PlsLogFil( Space(03) + "SEQMOV ["+cSeqMov+"] CODPAD ["+cCodPad+"] CODPRO ["+cCodPro+"] HORPRO ["+cHoraPro+"] HORA ["+cHora+"] "+iif(cTipo=="4"," DENTE ["+cDente+"] FACE ["+cFace+"] ",""),__PLSFLOGX)
		Next
		PlsLogFil("",__PLSFLOGX)
	EndIf
	// Log	eventos na acolslib
	If Len(aColsLib)>0
		PlsLogFil(Space(03)+"ITENS NA MATRIZ ACOLSLIB",__PLSFLOGX)
		For nI := 1 To Len(aColsLib)
			cSeqMov 	:= aColsLib[nI,Ascan(aHeaderLib,{|x| AllTrim(x[2]) == "BE2_SEQUEN"})]
			cCodPad 	:= aColsLib[nI,Ascan(aHeaderLib,{|x| AllTrim(x[2]) == "BE2_CODPAD"})]
			cCodPro 	:= aColsLib[nI,Ascan(aHeaderLib,{|x| AllTrim(x[2]) == "BE2_CODPRO"})]
			cDente 		:= aColsLib[nI,ascan(aHeaderLib,{|X| AllTrim(x[2]) == "BE2_DENREG"})]
			cFace 		:= aColsLib[nI,ascan(aHeaderLib,{|X| AllTrim(x[2]) == "BE2_FADENT"})]
			
			PLSLOGFIL( space(3)+"SEQMOV ["+CSEQMOV+"] CODPAD ["+CCODPAD+"] CODPRO ["+ AllTrim(CCODPRO)+"] "+iif(CTIPO=="4"," DENTE ["+ AllTrim(CDENTE)+"] FACE ["+ AllTrim(CFACE)+"] ",""),__PLSFLOGX)
		Next
		PlsLogFil("",__PLSFLOGX)
	EndIf
	// Log	eventos autorizados
	If Len(aEventosAut) > 0
		If lResInt
			PlsLogFil(Space(03)+"EVENTOS ATUALIZADOS",__PLSFLOGX)
		Else
			PlsLogFil(Space(03)+"EVENTOS AUTORIZADOS",__PLSFLOGX)
		EndIf
		PlsLogFil(Space(03)+"SEQ  CODPAD  CODPRO    DESCRICAO                                               NQTDSOL",__PLSFLOGX)
		For nFor := 1 To Len(aEventosAut)
			PlsLogFil(	Space(03)+aEventosAut[nFor,1]+Space(02)+;
				aEventosAut[nFor,2]+Space(06)+;
				aEventosAut[nFor,3]+Space(02)+;
				PadR(aEventosAut[nFor,5],54)+Space(02)+;
				Alltrim(Str(aEventosAut[nFor,4],7,2)),__PLSFLOGX)
		Next
		PlsLogFil("",__PLSFLOGX)
	EndIf
	// Log	Eventos negados
	If Len(aEventosNeg) > 0
		PlsLogFil("",__PLSFLOGX)
		If lResInt
			PlsLogFil(Space(03)+"EVENTOS NAO ATUALIZADOS",__PLSFLOGX)
		Else
			PlsLogFil(Space(03)+"EVENTOS NEGADOS",__PLSFLOGX)
		EndIf
		PlsLogFil(Space(03)+"SEQ  CODPAD  CODPRO    DESCRICAO                                               NQTDSOL",__PLSFLOGX)
		For nFor := 1 To Len(aEventosNeg)
			PlsLogFil(	Space(03)+aEventosNeg[nFor,1]+Space(02)+;
				aEventosNeg[nFor,2]+Space(06)+;
				aEventosNeg[nFor,3]+Space(02)+;
				PadR(aEventosNeg[nFor,5],54)+Space(02)+;
				Alltrim(Str(aEventosNeg[nFor,4],7,2)),__PLSFLOGX)
		Next
		PlsLogFil("",__PLSFLOGX)
	EndIf
	// Log de criticas
	If Len(aCriticas) > 0
		PlsLogFil(Space(03)+"CRITICAS",__PLSFLOGX)
		PlsLogFil(Space(03)+"SEQ  PROCEDIMENTO  CODIGO  CRITICA",__PLSFLOGX)
		For nFor := 1 To Len(aCriticas)
			If ! Empty(aCriticas[nFor,2])
				PlsLogFil(Space(03)+aCriticas[nFor,1]+Space(02)+;
					aCriticas[nFor,5]+Space(06)+;
					aCriticas[nFor,2]+Space(05)+;
					aCriticas[nFor,3]+Space(02),__PLSFLOGX)
			Else
				PlsLogFil(Space(30)+aCriticas[nFor,3]+Space(02),__PLSFLOGX)
			Endif
		Next
		PlsLogFil("",__PLSFLOGX)
	ElseIf Len(aEventosNeg) > 0 .And. Len(aCriticas) == 0
		PlsLogFil(Space(03)+"CRITICADO MAIS NAO FOI ENCONTRADO CRITICA(S)",__PLSFLOGX)
		PlsLogFil("",__PLSFLOGX)
	EndIf
	// Log
	If Len(aAutItens) > 0
		PlsLogFil(Space(03)+"aAutItens",__PLSFLOGX)
		PlsLogFil(Space(03)+"SEQ  CODPAD  CODPRO    NQTDSOL  (DIF. LIB - AUT)  RECNO  STATUS  LCOLSDEL  ITEJAEXECANT  ITEEXILIB  EXEC-PROF",__PLSFLOGX)
		For nFor := 1 To Len(aAutItens)
			PlsLogFil(Space(03) + aAutItens[nFor,1] 			+ Space(02) +;
				aAutItens[nFor,2] 						+ Space(06) +;
				aAutItens[nFor,3] 						+ Space(02) +;
				AllTrim( Str(aAutItens[nFor,4]) )		+ Space(08) +;
				AllTrim( Str(aAutItens[nFor,5],7,2) )	+ Space(14) +;
				AllTrim( Str(aAutItens[nFor,7],10) ) 	+ Space(06) +;
				IiF( aAutItens[nFor,6],"SIM","NAO" )	+ Space(05) +;
				IiF( aAutItens[nFor,8],"SIM","NAO" )	+ Space(07) +;
				IiF( aAutItens[nFor,10],"SIM","NAO" )	+ Space(11) +;
				IiF( aAutItens[nFor,11],"SIM","NAO" ) 	+ Space(08) +;
				IiF( aAutItens[nFor,12],"SIM","NAO" ) ,__PLSFLOGX )
		Next
		PlsLogFil("",__PLSFLOGX)
	EndIf
	// Log
	If Len(aMatOPMM) > 0
		PlsLogFil("",__PLSFLOGX)
		PlsLogFil(Space(03)+"ATENCAO INCLUSAO DE PROCEDIMENTOS SEM AUTORIZACAO",__PLSFLOGX)
		PlsLogFil(Space(03)+"aMatOPMM - PARAMETRO MV_PLSOPMM",__PLSFLOGX)
		PlsLogFil(Space(03)+"SEQ  CODPAD  CODPRO    NQTDSOL  (DIF. LIB - AUT)  RECNO  STATUS  LCOLSDEL",__PLSFLOGX)
		For nFor := 1 To Len(aMatOPMM)
			PlsLogFil(space(03)+aMatOPMM[nFor,1]			+Space(02)+;
				aMatOPMM[nFor,2]			   			+Space(06)+;
				aMatOPMM[nFor,3]						+Space(02)+;
				AllTrim( Str(aMatOPMM[nFor,4]) )		+Space(08)+;
				AllTrim( Str(aMatOPMM[nFor,5],7,2) )	+Space(14)+;
				AllTrim( Str(aMatOPMM[nFor,7],10) )	+Space(06)+;
				IiF(aMatOPMM[nFor,6],"SIM","NAO")		+Space(05)+;
				IiF(aMatOPMM[nFor,8],"SIM","NAO"),__PLSFLOGX)
		Next
		PlsLogFil("",__PLSFLOGX)
	EndIf
	PlsLogFil("",__PLSFLOGX)
	PlsLogFil(Space(3)+"FIM DA TRANSAÇÃO. ( INICIO ["+DtoC(Date())+"-"+cHoraBase+"] DURAÇÃO ["+AllTrim(Str(Seconds()-nHoraBase,12,3))+"] SEGUNDOS )",__PLSFLOGX)
	PlsLogFil("",__PLSFLOGX)
EndIf
Return(aRetorno)

/*/{Protheus.doc} U_CBMONCRI
Alimenta criticas
@type function
@author Alexander
@since 06.12.07
@version 1.0
/*/
							User Function CBMONCRI(aItens,aTrb,lTp,cCodCri,cCritic,cDescAux,aCriticas,aEventosNeg)
						LOCAL nFor,nFor2
						LOCAL cSeqMov := ""
						LOCAL cCodPad := ""
						LOCAL cCodPro := ""
						LOCAL cDescri := ""
						LOCAL nQtdSol := 0
						LOCAL nVlrApr := 0
// For
						For nFor2 := 1 To Len(aItens)
							cSeqMov := U_CBRETDAD(aItens[nFor2],"SEQMOV")
							cCodPad := U_CBRETDAD(aItens[nFor2],"CODPAD")
							cCodPro := U_CBRETDAD(aItens[nFor2],"CODPRO")
							cDescri	:= U_CBRETDAD(aItens[nFor2],"DESCRI","")
							nQtdSol := U_CBRETDAD(aItens[nFor2],"QTD",0)
							nQtdAut := U_CBRETDAD(aItens[nFor2],"QTDAUT",0)
							cDente 	:= U_CBRETDAD(aItens[nFor2],"DENTE","")
							cFace  	:= U_CBRETDAD(aItens[nFor2],"FACE","")
							cSlvPad := U_CBRETDAD(aItens[nFor2],"SLVPAD","")
							cSlvPro := U_CBRETDAD(aItens[nFor2],"SLVPRO","")
	// Critica
							If lTp
								If Len(aTrb)>0
									For nFor := 1 To Len(aTrb)
										AaDd( aCriticas,{cSeqMov,aTrb[nFor,1],aTrb[nFor,2]+Iif(Len(aTrb[nFor])>=3 .And. !Empty(aTrb[nFor,3]),' ( '+aTrb[nFor,3]+' ) ',''),cCodPad,cCodPro,cDente,cFace} )
									Next
								EndIf
							Else
								If !Empty(cDescAux)
									AaDd( aCriticas,{cSeqMov,cCodCri,cDescAux,cCodPad,cCodPro,cDente,cFace} )
								Else
									AaDd( aCriticas,{cSeqMov,cCodCri,cCritic,cCodPad,cCodPro,cDente,cFace} )
								Endif
							EndIf
	// Eventos
							If ValType(aEventosNeg) == 'A'
								If Ascan(aEventosNeg,{|x| AllTrim(x[1]+x[2]+x[3]+x[7]+x[8]) == AllTrim(cSeqMov+cCodPad+cCodPro+cDente+cFace) } ) == 0
									AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
								EndIf
							EndIf
						Next
						Return

/*/{Protheus.doc} U_CABXEXCA
Exclui uma autorizacao a partir de seu numero
@type function
@author Tulio Cesar
@since 06.02.04
@version 1.0
/*/
					User Function CABXEXCA(cNumeroAut)
						LOCAL nH       := 0
						LOCAL nI       := 0
						LOCAL aCols    := {}
						LOCAL aHeader  := PLSA090Hea()
						LOCAL aVetTrab := {}
						LOCAL aCabCri  := {}
						LOCAL aDadCri  := {}
						LOCAL aTrbCri  := {}
						LOCAL aRet     := {.F.,"","","","",.F.,"","",.F.}
						LOCAL aMatExe  := {}
						LOCAL cNumAut  := ""
						PRIVATE inclui := .F.

						If At(',',cNumeroAut) > 0
							While (nPos := At(',',cNumeroAut)) > 0
								cNumAut    := AllTrim(SubStr(cNumeroAut,1,nPos-1))
								cNumeroAut := AllTrim(SubStr(cNumeroAut,nPos+1,Len(cNumeroAut)))
								AaDd(aMatExe,cNumAut)
							EndDo
						EndIf
// Pega o ultimo ou o unico
						AaDd(aMatExe,AllTrim(cNumeroAut))
// Processa
						BEA->(DbSetOrder(1))

						For nI := 1 To Len(aMatExe)
	
							cNumeroAut := aMatExe[nI]
	
							If BEA->(MsSeek(xFilial("BEA")+cNumeroAut))
		
								Store Header "BEG" TO aCabCri For .T.
		
								BEG->(DbSetOrder(1))
								If ! BEG->(MsSeek(xFilial("BEG")+cNumeroAut))
									Store COLS Blank "BEG" TO aDadCri FROM aCabCri
								Else
									Store COLS "BEG" TO aDadCri FROM aCabCri VETTRAB aTrbCri While ;
										xFilial("BEG")+cNumeroAut == BEG->(BEG_FILIAL+BEG_OPEMOV+BEG_ANOAUT+BEG_MESAUT+BEG_NUMAUT)
								Endif
		// Abre Semaforo
		// Alimenta matriz
								PLSA090MDa(BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT),"1",aHeader,aVetTrab,aCols)
		// Gravacao
								aRet := PLSA090Grv(	aClone(aCols),aClone(aHeader),{},K_Excluir,aClone(aVetTrab),{},"",ctod(""),"","","","",BEA->BEA_TIPGUI,.F.,;
									aDadCri,aCabCri,aTrbCri,nil,BEA->BEA_ORIGEM,BEA->BEA_CODLDP,/*lReanaliza*/,;
			/*cFiltro*/,/*cKey*/,/*lForBloq*/,/*lVeioComu*/,/*lNMudFase*/,/*cAliasIte*/,/*cAliasCri*/,/*lAjusta*/,/*lEvolu*/,/*aDadBE4*/,;
			/*lGerSenha*/,/*lWeb*/,/*aDadB43*/,/*aCabB43*/,/*aTrbB43*/,/*oBrwEven*/,/*lExcluiAte*/,/*oBrwB47*/,/*cAliasCab*/,;
			/*lReembolso*/,/*oBrwB46*/,/*oBrwB44*/,/*lIncNeg*/,/*cObsoleto*/,/*lSolicit*/,/*cTpGrv*/,/*aColsDF*/,/*aHeaderDF*/,;
			/*aVetDF*/,/*aDaSenPro*/,/*lGuiHoRe*/,/*aMatBd6*/,/*aMatCom*/,/*lResInt*/,/*cAliasCmp*/,/*lOdontoWeb*/,/*cNumLib*/,;
			/*cArqImp*/,/*lEvoSadt*/,/*cSituac*/,/*lProtoc*/,/*aPartic*/)
		lProRadio := aRet[12]
		lAudi:=aRet090[9]
		// Fecha semaforo
	Endif
Next

Return aRet[1]

/*/{Protheus.doc} U_CBLISEST
Devolve todos os estados a partir de uma operadora
@type function
@author Tulio Cesar
@since 02.07.04
@version 1.0
/*/
									User Function CBLISEST(cCodOpe)
								LOCAL aRetorno 	:= {}
								LOCAL lUnimeds	:= If( AllTrim(GETNEWPAR("MV_PLSUNI","1") )=="1",.T.,.F.)

								If lUnimeds
									BA0->(DbSetOrder(1))
									If BA0->(MsSeek(xFilial("BA0")+cCodOpe))
										AaDd(aRetorno,BA0->BA0_EST)
									Endif
								Else
									SX5->(DbSetOrder(1))
									If SX5->(MsSeek(xFilial("SX5")+"12"))
										While ! SX5->(Eof()) .And. SX5->(X5_FILIAL+X5_TABELA) == xFilial("SX5")+"12"
											AaDd(aRetorno,SX5->X5_CHAVE)
											SX5->(DbSkip())
										Enddo
									Endif
								Endif

								If Len(aRetorno) == 0
									aRetorno := {""}
								Endif

								Return(aRetorno)

/*/{Protheus.doc} U_CABLESP
Devolve todas as especialidades a partir de uma operadora
@type function
@author Tulio Cesar
@since 02.07.04
@version 1.0
/*/
							User Function CABLESP(cCodOpe,cEstado)
								LOCAL aRetorno := {}
								LOCAL cSQL := ""

								cSQL += "SELECT DISTINCT BAQ.BAQ_CODESP, BAQ.BAQ_DESCRI "
								cSQL += "FROM "+RetSQLName("BAQ")+" BAQ "

								cSQL += "INNER JOIN "+RetSQLName("BAX")+" BAX "
								cSQL += "ON BAQ_CODINT = BAX_CODINT "
								cSQL += "AND BAQ_CODESP = BAX_CODESP "

								cSQL += "WHERE BAQ_FILIAL = '"+xFilial("BAQ")+"' AND "
								cSQL += "BAX_FILIAL = '"+xFilial("BAX")+"' AND "
								cSQL += "BAX_CODINT = '"+cCodOpe+"' AND "
								cSQL += "BAX.D_E_L_E_T_ = ' ' "

								If ExistBLock("PLORDESP")
									cSQL += ExecBlock("PLORDESP",.F.,.F.)
								Else
									cSQL += "ORDER BY BAQ.BAQ_CODESP "
								EndIf

								PLSQuery(cSQL,"TrbPls")

								AaDd(aRetorno,__cTextoAll)

								While ! TrbPls->(Eof())
									AaDd(aRetorno,TrbPls->BAQ_CODESP+"-"+TrbPls->BAQ_DESCRI)
									TrbPls->(DbSkip())
								Enddo
								TrbPls->(DbCloseArea())

								If Len(aRetorno) == 1
									aRetorno := {""}
								Endif

								Return(aRetorno)

/*/{Protheus.doc} U_CBLISMUN
Devolve todos os municipios a partir de uma espec. + estado
@type function
@author Tulio Cesar
@since 02.07.04
@version 1.0
/*/
							User Function CBLISMUN(cCodOpe,cCodEsp,cEstado,cCodMun,lInverte)
								LOCAL aRetorno   := {}
								LOCAL cSQL		 := ""
								LOCAL cMVPLSRDAG := GetNewPar("MV_PLSRDAG","999999")
								LOCAL lFlag      := .F.
								DEFAULT cCodMun  := ""
								DEFAULT lInverte := .F.

								If Empty(cCodMun)
									cSQL := "SELECT DISTINCT BB8_CODMUN FROM "+RetSQLName("BAX")+", "+RetSQLName("BB8")+" WHERE "
								Else
									cSQL := "SELECT DISTINCT BB8_BAIRRO FROM "+RetSQLName("BAX")+", "+RetSQLName("BB8")+" WHERE "
								Endif
								cSQL += "BB8_FILIAL = '"+xFilial("BB8")+"' AND "
								cSQL += "BB8_CODINT = '"+cCodOpe+"' AND "
								cSQL += "BAX_FILIAL = '"+xFilial("BAX")+"' AND "
								cSQL += "BAX_CODINT = '"+cCodOpe+"' AND "
								If subs(cCodEsp,1,3) <> Subs(__cTextoAll,1,3)
									cSQL += "BAX_CODESP = '"+subs(cCodEsp,1,3)+"' AND "
								Endif
								cSQL += "BB8_EST    = '"+cEstado+"' AND "

								If ! Empty(cCodMun)
									If subs(cCodMun,1,7) <> Subs(__cTextoAll,1,7)
										cSQL += "BB8_CODMUN = '"+cCodMun+"' AND "
									Endif
								Endif

								cSQL += "BB8_DATBLO = '"+Space(8)+"' AND "

								cSQL += "BB8_CODIGO = BAX_CODIGO AND "
								cSQL += "BB8_CODINT = BAX_CODINT AND "
								cSQL += "BB8_CODIGO <> '"+cMVPLSRDAG+"' AND "
								cSQL += RetSQLName("BB8")+".D_E_L_E_T_ = ' ' AND "
								cSQL += RetSQLName("BAX")+".D_E_L_E_T_ = ' '"

								PLSQuery(cSQL,"TrbPls")

								AaDd(aRetorno,__cTextoAll)

								While ! TrbPls->(Eof())
	
									lFlag := .T.
	
									If Empty(cCodMun)
										BID->(DbSetOrder(1))
										If BID->(MsSeek(xFilial("BID")+TrbPls->BB8_CODMUN))
											if lInverte
												AaDd(aRetorno,alltrim(BID->BID_DESCRI)+"-"+BID->BID_CODMUN)
											else
												AaDd(aRetorno,BID->BID_CODMUN+"-"+alltrim(BID->BID_DESCRI))
											endIf
										Endif
									Else
										AaDd(aRetorno,TrbPls->BB8_BAIRRO)
									Endif
	
									TrbPls->(DbSkip())
								Enddo
								TrbPls->(DbCloseArea())

								If ! lFlag
									aRetorno := {""}
								Endif

								if lInverte
									aSort(aRetorno)
								endIf

								Return(aRetorno)

/*/{Protheus.doc} U_CBLISRDA
Devolve todas as RDAS
@type function
@author Tulio Cesar
@since 02.07.04
@version 1.0
/*/
							User Function CBLISRDA(cCodOpe,cCodEsp,cEstado,cCodMun,cBairro,cProduto,cVersao,lFiltRDA)
								LOCAL aRetorno   := {}
								LOCAL cSQL
								LOCAL lFlag      := .F.
								LOCAL cMVPLSRDAG := GetNewPar("MV_PLSRDAG","999999")
								LOCAL nPos
								Local lGrava
								DEFAULT cCodMun  := ""
								DEFAULT cProduto := ""
								DEFAULT cVersao  := ""
								DEFAULT lFiltRDA := .F.

								cSQL := "SELECT BB8_CODIGO, BB8_CODLOC, BAX_CODESP FROM "+RetSQLName("BAX")+", "+RetSQLName("BB8")+", "
								cSql += RetSqlName("BAU") +" WHERE  "
								cSQL += "BB8_FILIAL = '"+xFilial("BB8")+"' AND "
								cSQL += "BB8_CODINT = '"+cCodOpe+"' AND "
								cSQL += "BAX_FILIAL = '"+xFilial("BAX")+"' AND "
								cSQL += "BAX_CODINT = '"+cCodOpe+"' AND "
								If subs(cCodEsp,1,3) <> Subs(__cTextoAll,1,3)
									cSQL += "BAX_CODESP = '"+subs(cCodEsp,1,3)+"' AND "
								Endif
								cSQL += "BB8_EST    = '"+cEstado+"' AND "
								If subs(cCodMun,1,7) <> Subs(__cTextoAll,1,7)
									cSQL += "BB8_CODMUN = '"+cCodMun+"' AND "
								Endif
								If AllTrim(cBairro) <> __cTextoAll
									cSQL += "BB8_BAIRRO = '"+cBairro+"' AND "
								Endif

								cSQL += "BB8_DATBLO = '" +Space(8)+ "' AND "
								cSQL += "BB8_CODIGO = BAX_CODIGO AND "
								cSQL += "BB8_CODINT = BAX_CODINT AND "
								cSQL += "BB8_CODLOC= BAX_CODLOC AND "
								cSQL += "BB8_GUIMED = '1' AND "
								cSQL += "BAX_GUIMED = '1' AND "
								cSQL += "BAU_FILIAL='"+xFilial("BAU")+"' AND "
								cSQL += "BAU_CODIGO = BB8_CODIGO AND "
								cSQL += "BAU_GUIMED <> '0' AND "
								cSQL += "(BAU_CODOPE='"+cCodOpe+"' OR BAU_CODOPE='"+Space(Len(BAU->BAU_CODOPE))+"') AND "
								cSQL += RetSQLName("BB8")+".D_E_L_E_T_ = ' ' AND "
								cSQL += RetSQLName("BAX")+".D_E_L_E_T_ = ' ' AND "
								cSQL += RetSQLName("BAU")+".D_E_L_E_T_ = ' '  "
								PLSQuery(cSQL,"TrbPls")

								While ! TrbPls->(Eof())
	
									If cMVPLSRDAG == TrbPls->BB8_CODIGO
										TrbPls->(DbSkip())
										Loop
									Endif
	
									BAU->(DbSetOrder(1))
									If BAU->(MsSeek(xFilial("BAU")+TrbPls->BB8_CODIGO)) .And. Empty(BAU->BAU_CODBLO)
										lGrava := .T.
										If lFiltRDA
											BBI->(DbSetOrder(1))
			
											If BBI->(FieldPos("BBI_VERSAO")) == 0
												lCond := BBI->(MsSeek(xFilial("BBI")+BAU->BAU_CODIGO+cCodOpe+TrbPLS->BB8_CODLOC+TrbPLS->BAX_CODESP+cProduto))
											Else
												lCond := BBI->(MsSeek(xFilial("BBI")+BAU->BAU_CODIGO+cCodOpe+TrbPLS->BB8_CODLOC+TrbPLS->BAX_CODESP+cProduto+cVersao))
											EndIf
			
											If BBI->(FieldPos("BBI_ATIVO")) > 0 .And. lCond
												If BBI->BBI_ATIVO == "0"
													lGrava := .F.
												EndIf
											EndIf
										EndIf
		
										If lGrava
											nPos := Ascan(aRetorno,{ |x| x[1] == BAU->BAU_CODIGO .and. x[3] == TrbPls->BB8_CODLOC .and. x[4] == TrbPls->BAX_CODESP})
											If  nPos == 0
												AaDd(aRetorno,{BAU->BAU_CODIGO,BAU->BAU_NOME,TrbPls->BB8_CODLOC,TrbPls->BAX_CODESP})
											Endif
										EndIf
									Endif
	
									TrbPls->(DbSkip())
								Enddo
								TrbPls->(DbCloseArea())

								If Len(aRetorno) == 0
									aRetorno := {}
								Endif

								Return(aRetorno)

/*/{Protheus.doc} U_CBLISBAI
Devolve todos os bairros
@type function
@author Tulio Cesar
@since 02.07.04
@version 1.0
/*/
							User Function CBLISBAI(cCodOpe,cCodEsp,cEstado,cMunicipio)
								LOCAL aRetorno := {}

								aRetorno := U_CBLISMUN(cCodOpe,cCodEsp,cEstado,cMunicipio)

								If Len(aRetorno) == 0
									aRetorno := {""}
								Endif

								Return(aRetorno)

/*/{Protheus.doc} U_CBGETERDA
Valida a senha da rede de atendimento
@type function
@author Tulio Cesar
@since 06.07.04
@version 1.0
/*/
							User Function CBGETERDA(cOpeRda,cCodRda,cAno,cMes,cFase)
								LOCAL cSQL
								LOCAL aRet   := {}
								LOCAL nFor
								LOCAL aStruc := {}
								LOCAL cAux

								LOCAL aHeaMv := {}
								LOCAL aMovto := {}

								LOCAL aHeaDCF := {}
								LOCAL aDCFixo := {}

								LOCAL aHeaDCV := {}
								LOCAL aDCVar  := {}

								LOCAL aHeaAP  := {}
								LOCAL aAP     := {}
								DEFAULT cFase := "3"
// Movimentos - BD7    ***     Movimentos - BD7    ***     Movimentos - BD7
								cAux   := ""
								aStruc := BD7->(DbStruct())
								For nFor := 1 To Len(aStruc)
									AaDd(aHeaMv,aStruc[nFor,1])
									cAux += aStruc[nFor,1]+","
								Next
								cAux := Subs(cAux,1,Len(cAux)-1)
								cSQL := "SELECT "
								cSQL += cAux
								cSQL += " FROM "+RetSQLName("BD7")+" WHERE "
								cSQL += "BD7_FILIAL = '"+xFilial("BD7")+"' AND "
								cSQL += "BD7_CODOPE = '"+cOpeRda+"' AND "
								cSQL += "BD7_ANOPAG = '"+cAno+"' AND "
								cSQL += "BD7_MESPAG = '"+cMes+"' AND "
								cSQL += "BD7_SITUAC = '1' AND "
								cSQL += "BD7_FASE   = '"+cFase+"' AND "
								cSQL += "BD7_CODRDA = '"+cCodRda+"' AND "
								cSQL += "D_E_L_E_T_ = ' '"
								cSQL += "ORDER BY BD7_FILIAL,BD7_CODOPE,BD7_CODLDP,BD7_CODPEG,BD7_NUMERO,BD7_ORIMOV"

								PLSQuery(cSQL,"PlsTrb")

								While ! PlsTrb->(Eof())
	
									AaDd(aMovto,{})
									For nFor := 1 To Len(aHeaMv)
										AaDd(aMovto[Len(aMovto)],&("PlsTrb->"+aHeaMv[nFor]))
									Next
	
									PlsTrb->(DbSkip())
								Enddo

								PlsTrb->(DbCloseArea())
// Debitos Creditos Mensais Fixos - BBC *** Debitos Creditos Mensais Fixos - BBC
								aStruc := BBC->(DbStruct())
								For nFor := 1 To Len(aStruc)
									AaDd(aHeaDCF,aStruc[nFor,1])
								Next

								BBC->(DbSetOrder(2))
								If BBC->(MsSeek(xFilial("BBC")+cCodRda+"11"))
									While ! BBC->(Eof()) .And. BBC->(BBC_FILIAL+BBC_CODIGO+BBC_STATUS+BBC_PROMED) == ;
											xFilial("BBC")+cCodRda+"11"
		
										If ! ( cAno + cMes + "01" >= DtoS(BBC->BBC_VLDINI) .And. ;
												(DtoS(LastDay(CtoD("01/"+cMes+"/"+cAno))) <= DtoS(BBC->BBC_VLDFIM) .Or. Empty(BBC->BBC_VLDFIM)) )
											BBC->(DbSkip())
											Loop
										EndIf
		
										AaDd(aDCFixo,{})
										For nFor := 1 To Len(aHeaDCF)
											AaDd(aDCFixo[Len(aDCFixo)],&("BBC->"+aHeaDCF[nFor]))
										Next
										BBC->(DbSkip())
									Enddo
								Endif
// Debitos Creditos Mensais Variaveis - BGQ ***
								aStruc := BGQ->(DbStruct())
								For nFor := 1 To Len(aStruc)
									AaDd(aHeaDCV,aStruc[nFor,1])
								Next

								BGQ->(DbSetOrder(2))
								If BGQ->(MsSeek(xFilial("BGQ")+cCodRda+cAno+cMes+cOpeRda))
									While ! BGQ->(Eof()) .And. BGQ->(BGQ_FILIAL+BGQ_CODIGO+BGQ_ANO+BGQ_MES+BGQ_CODOPE) == ;
											xFilial("BGQ")+cCodRda+cAno+cMes+cOpeRda
		
										If ( cFase == "3" .And. ! Empty(BGQ->BGQ_NUMCOB) ) .Or. ;
												( cFase == "4" .And. Empty(BGQ->BGQ_NUMCOB) )
											BGQ->(DbSkip())
											Loop
										Endif
		
										AaDd(aDCVar,{})
										For nFor := 1 To Len(aHeaDCV)
											AaDd(aDCVar[Len(aDCVar)],&("BGQ->"+aHeaDCV[nFor]))
										Next
										BGQ->(DbSkip())
									Enddo
								Endif
// Apontamentos producao medica - BCE ***
								aStruc := BCE->(DbStruct())
								For nFor := 1 To Len(aStruc)
									AaDd(aHeaAP,aStruc[nFor,1])
								Next

								BCE->(DbSetOrder(2))
								If BCE->(MsSeek(xFilial("BCE")+cCodRda+cOpeRda+cAno+cMes))
									While ! BCE->(Eof()) .And. BCE->(BCE_FILIAL+BCE_CODIGO+BCE_CODINT+BCE_ANOPAG+BCE_MESPAG) == ;
											xFilial("BCE")+cCodRda+cOpeRda+cAno+cMes
		
										If ( cFase == "3" .And. ! Empty(BCE->BCE_NUMLOT) ) .Or. ;
												( cFase == "4" .And. Empty(BCE->BCE_NUMLOT) )
											BCE->(DbSkip())
											Loop
										Endif
		
										AaDd(aAP,{})
										For nFor := 1 To Len(aHeaAP)
											AaDd(aAP[Len(aAP)],&("BCE->"+aHeaAP[nFor]))
										Next
										BCE->(DbSkip())
									Enddo
								Endif
// Posiciona na RDA
								BAU->(DbSetOrder(1))
								BAU->(MsSeek(xFilial("BAU")+cCodRda))
// Monta retorno da funcao
								aRet := { {aMovto,aHeaMv} , {aDCFixo,aHeaDCF} , {aDCVar,aHeaDCV}, {aAP,aHeaAP} }
// Fim da funcao
								Return(aRet)

/*/{Protheus.doc} U_CBVLDSUSR
Valida a senha do beneficiario.
@type function
@author Tulio Cesar
@since 15.07.04
@version 1.0
/*/
							User Function CBVLDSUSR(cMatricUsr,cSenhaPLS)
								LOCAL lRet := .F.

								BA1->(DbSetOrder(2))
								If BA1->(MsSeek(xFilial("BA1")+cMatricUsr)) .And. Empty(BA1->BA1_MOTBLO)
									BA3->(DbSetOrder(1))
									If BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC))) .And. Empty(BA3->BA3_MOTBLO)
										lRet := .T.
									Endif
								Endif

								Return(lRet)

/*/{Protheus.doc} U_CBGETMOV
Retorna os movimentos do usuario com base em parametros
@type function
@author Tulio Cesar
@since 20.07.04
@version 1.0
/*/
							User Function CBGETMOV(cMatric,nPeriodo,aCampos,nLimite)
								LOCAL cSQL
								LOCAL aRet  := {}
								LOCAL nCont := 0
								LOCAL nFor
// Define conteudos padroes dos campos
								DEFAULT nPeriodo := 0
								DEFAULT aCampos  := {}
								DEFAULT nLimite  := {}
// Se nao passou nenhum campo devolve vazio
								If Len(aCampos) == 0
									Return(aRet)
								Endif
// Busca os eventos na base de dados
								cSQL := "SELECT * FROM "+RetSQLName("BD6")+" WHERE "
								cSQL += "BD6_FILIAL = '"+xFilial("BD6")+"' AND "
								cSQL += "BD6_OPEUSR = '"+Subs(cMatric,atCodOpe[1],atCodOpe[2])+"' AND "
								cSQL += "BD6_CODEMP = '"+Subs(cMatric,atCodEmp[1],atCodEmp[2])+"' AND "
								cSQL += "BD6_MATRIC = '"+Subs(cMatric,atMatric[1],atMatric[2])+"' AND "
								cSQL += "BD6_TIPREG = '"+Subs(cMatric,atTipReg[1],atTipReg[2])+"' AND "
// Se foi passado o periodo busca no periodo dos eventos
								If nPeriodo > 0
									cSQL += "BD6_DATPRO >= '"+dtos((dDataBase-nPeriodo))+"' AND "
								Endif

								cSQL += "( BD6_FASE = '3' OR BD6_FASE = '4' ) AND "
								cSQL += "BD6_SITUAC = '1' AND "
								cSQL += "D_E_L_E_T_ = '' "
								cSQL += "ORDER BY BD6_FILIAL, BD6_DATPRO"

								PLSQuery(cSQL,"U_CBGETMOV")

								While ! U_CBGETMOV->(Eof())
									nCont ++
	
									AaDd(aRet,{})
									For nFor := 1 To Len(aCampos)
										AaDd(aRet[Len(aRet)],&("BD6->"+aCampos[nFor]))
									Next
	
									If nLimite > 0 .And. nCont > nLimite
										Exit
									Endif
	
									U_CBGETMOV->(DbSkip())
								Enddo
								U_CBGETMOV->(DbCloseArea())
								Return(aRet)

/*/{Protheus.doc} U_CBRtLimCH
@type function
@author Tulio Cesar
@since 26.05.07
@version 1.0
/*/
							User Function CBRtLimCH(cOpeOri,dDatPro)
								LOCAL cGruOpe   := ""
								LOCAL cCodTab   := ""
								LOCAL nOrdBA0   := BA0->(IndexOrd())
								LOCAL nRecBA0   := BA0->(Recno())
								LOCAL nLimCH    := GetNewPar("MV_PLSLMCH",300)
								LOCAL cTipLim   := GetNewPar("MV_PLSTPLM","1")
								LOCAL cNivelVld := ""
								LOCAL lContinua := .T.
								DEFAULT dDatPro := dDataBase

								BA0->(DbSetOrder(1))
								BA0->(MsSeek(xFilial("BA0")+cOpeOri))
								cGruOpe := BA0->BA0_GRUOPE
								cCodTab := BA0->BA0_CODTAB

								If BA0->(FieldPos("BA0_LIMCH")) > 0 .And. BA0->(FieldPos("BA0_NIVVAL")) > 0
									If ( BA0->BA0_LIMCH > 0 ) .Or. ( BA0->BA0_LIMCH == 0 .And. BA0->BA0_NIVVAL == "1" )
										nLimCH    := BA0->BA0_LIMCH
										cNivelVld := BA0->BA0_NIVVAL
										lContinua := .F.
		
										If BA0->(FieldPos("BA0_TIPLIM")) > 0 .And. ! Empty(BA0->BA0_TIPLIM)
											cTipLim := BA0->BA0_TIPLIM
										Endif
									Endif
								Endif

								BA0->(DbSetOrder(nOrdBA0))
								BA0->(DbGoTo(nRecBA0))

								If lContinua
									BGH->(DbSetOrder(1))
									If BGH->(MsSeek(xFilial("BGH")+cGruOpe))
										While ! BGH->(Eof()) .And. BGH->(BGH_FILIAL+BGH_GRUOPE) == xFilial("BGH")+cGruOpe
			
											If ( dtos(dDatPro) >= dtos(BGH->BGH_DATINI) ) .And. ;
													( dtos(dDatPro) <= dtos(BGH->BGH_DATFIN) .Or. Empty(BGH->BGH_DATFIN) )
												If BGH->(FieldPos("BGH_LIMCH")) > 0 .And. BGH->BGH_LIMCH > 0
													nLimCH := BGH->BGH_LIMCH
					
													If BGH->(FieldPos("BGH_TIPLIM")) > 0 .And. ! Empty(BGH->BGH_TIPLIM)
														cTipLim := BGH->BGH_TIPLIM
													Endif
												Endif
											Endif
			
											BGH->(DbSkip())
										Enddo
									Endif
								Endif
								Return({nLimCH,cCodTab,cNivelVld,cTipLim})

/*/{Protheus.doc} U_CBRtQtdCH
(long_description)
@type function
@author Tulio Cesar
@since 26.05.07
@version 1.0
/*/
							User Function CBRtQtdCH(cCodTab,cCodPad,cCodPro,cOpeMov,dData,cProRel,nPrPrRl,lRetCoC,cAno,cMes)
								LOCAL aCompo
								LOCAL nQtdCH    := 0
								LOCAL nQtdVlr   := 0
								LOCAL nFor2
								LOCAL nUSMensal := 0
								LOCAL nOrdBFM   := BFM->(IndexOrd())
								LOCAL nRecBFM   := BFM->(Recno())
								LOCAL nOrdBW4   := BW4->(IndexOrd())
								LOCAL nRecBW4   := BW4->(Recno())
								LOCAL nVlrPad	:= 0
								LOCAL bRest     := { || BFM->(DbGoTo(nRecBFM)), BFM->(DbSetOrder(nOrdBFM)), BW4->(DbGoTo(nRecBW4)), BW4->(DbSetOrder(nOrdBW4)) }
								DEFAULT cCodTab := ""
								DEFAULT lRetCoC := .F.
								DEFAULT cProRel := ""
								DEFAULT nPrPrRl := 0
								DEFAULT cAno    := subs(dtos(dData),1,4)
								DEFAULT cMes    := subs(dtos(dData),5,2)

								If Type("dDatAnalise") == "U"
									dDatAnalise := dData
								EndIf

								BFM->(DbSetOrder(1))
								If BFM->(DbSeek(xFilial("BFM")+cOpeMov+cAno+cMes))
									nUSMensal := BFM->BFM_VALRDA
								Else
									Conout(STR0032+cOpeMov+STR0033+cAno+STR0034+cMes+STR0035) //"SIGAPLS - U.S mensal para a Operadora "###" Ano "###" Mes "###" nao encontrado."
								Endif

								If Empty(cProRel)
									aCompo := PLSCOMEVE(cCodTab,cCodPad,cCodPro,PLSINTPAD(),dData,nil,lRetCoC)
								Else
									aCompo := PLSCOMEVE(cCodTab,cCodPad,cProRel,PLSINTPAD(),dData,nil,lRetCoC)
								Endif

								For nFor2 := 1 To Len(aCompo)
									If     AllTrim(aCompo[nFor2,6]) $ "PLSRETCH"
		
										If Empty(aCompo[nFor2,12]) // Nao e em porte medico (CBHPM)
											If nPrPrRl == 0
												nQtdCH  += aCompo[nFor2,3]
												nQtdVlr += Round(aCompo[nFor2,3]*nUSMensal,2)
											Else
												nQtdCH  += Round((Round(aCompo[nFor2,3]*nPrPrRl,2))/100,2)
												nQtdVlr += Round(((Round(aCompo[nFor2,3]*nUSMensal,2))*nPrPrRl)/100,2)
											Endif
										Else
											If Empty(cCodTab)
												If Len(aCompo[nFor2]) >= 15
													cCodTab := aCompo[nFor2,15]
												Else
													cCodTab := ""
													Conout("SIGAPLS - Solicitar atualizacao do fonte PLSVLRPRO.PRW")
												Endif
											Endif
			
											BW4->(DbSetOrder(1))
											If BW4->(DbSeek(xFilial("BW4")+cOpeMov+cCodTab+aCompo[nFor2,12]))
				
												While BW4->BW4_CODOPE == cOpeMov .And. BW4->BW4_CODTAB == cCodTab .And. BW4->BW4_PORTE == aCompo[nFor2,12]
					
													If ( ( dtos(dDatAnalise) >= dtos(BW4->BW4_VIGINI) ) .And. ;
															( dtos(dDatAnalise) <= dtos(BW4->BW4_VIGFIN) .Or. Empty(BW4->BW4_VIGFIN) ) ) .Or. ;
															( !Empty(BW4->BW4_VIGINI) .And. !Empty(BW4->BW4_VIGFIN) )
						
														If PLSINTVAL("BW4",'BW4_VIGINI','BW4_VIGFIN',dDatAnalise)
							
															If nPrPrRl == 0
																nQtdCH  += Round(BW4->BW4_VLRREA/nUSMensal,2)
																nQtdVlr += BW4->BW4_VLRREA
															Else
																nQtdCH  += Round(((Round(BW4->BW4_VLRREA/nUSMensal,2))*nPrPrRl)/100,2)
																nQtdVlr += Round((Round(BW4->BW4_VLRREA*nPrPrRl,2))/100,2)
															Endif
							
														Endif
													ElseIf  BW4->BW4_VIGINI == CTOD(" / / ") .And. BW4->BW4_VIGFIN == CTOD(" / / ") .And. nVlrPad == 0
														nVlrPad := BW4->BW4_VLRREA
													Endif
													BW4->(dbSkip())
												EndDo
											Endif
										Endif
									ElseIf AllTrim(aCompo[nFor2,6]) $ "PLSRETREA,PLSCALRCC"
										If nPrPrRl == 0
											nQtdCH  += Round(aCompo[nFor2,3]/nUSMensal,2)
											nQtdVlr += aCompo[nFor2,3]
										Else
											nQtdCH  += Round(((Round(aCompo[nFor2,3]/nUSMensal,2))*nPrPrRl)/100,2)
											nQtdVlr += Round(((aCompo[nFor2,3])*nPrPrRl)/100,2)
										Endif
									ElseIf AllTrim(aCompo[nFor2,6]) $ "PLSRETCRR,PLSCALDP,PLSRETIN,PLSRETTCR,PLSRETUCO,PLSRETM2,PLSRETPA,PLSRETAUX"
		// Nao foi elaborado ainda uma forma de achar a quantidade de CH a partir dessas unidades
									Endif
								Next

								Eval(bRest)
								Return({nQtdCH,nQtdVlr})

/*/{Protheus.doc} U_CABWLIO
Log Caixa Preta
@type function
@author Tulio Cesar
@since 26.05.07
@version 1.0
/*/
							User Function CABWLIO(aDad,aIte)
								LOCAL nI := 0
// Log
								PlsLogFil(Space(03)+Replicate("*",90),__PLSFLOGX)
								PlsLogFil(Space(03)+"CABEÇALHO",__PLSFLOGX)
								PlsLogFil(Space(03)+Replicate("*",90),__PLSFLOGX)
								For nI:=1 To Len(aDad)
									If ValType(aDad[nI,2]) <> 'A'
										cCampo 	  := aDad[nI,1]
										cConteudo := aDad[nI,2]
										Do Case
										Case ValType(cConteudo) == 'D'
											cConteudo := dtoc(cConteudo)
										Case ValType(cConteudo) == 'L'
											cConteudo :=  Iif(cConteudo,STR0004,STR0005) //"SIM"###"NAO"
										Case ValType(cConteudo) == 'N'
											cConteudo :=  AllTrim( Str(cConteudo) )
										OtherWise
											cConteudo :=  AllTrim( cConteudo )
										EndCase
		
										If Empty( AllTrim( StrTran( cConteudo,"/","" ) ) )
											cConteudo := ""
										EndIf
		
										If !Empty(AllTrim(cConteudo))
											PlsLogFil(Space(03)+cCampo+Space(15-Len(cCampo))+"["+cConteudo+"]",__PLSFLOGX)
										EndIf
									EndIf
								Next
// Itens
								PlsLogFil("",__PLSFLOGX)
								PlsLogFil(Space(03)+Replicate("*",80),__PLSFLOGX)
								PlsLogFil(Space(03)+"ITENS DA GUIA (EVENTOS)",__PLSFLOGX)
								PlsLogFil(Space(03)+Replicate("*",80),__PLSFLOGX)
								For nI := 1 To Len(aIte)
									cSeqMov 	:= U_CBRETDAD(aIte[nI],"SEQMOV")
									cCodPad 	:= U_CBRETDAD(aIte[nI],"CODPAD")
									cCodPro 	:= U_CBRETDAD(aIte[nI],"CODPRO")
									nQtdSol 	:= U_CBRETDAD(aIte[nI],"QTD",0)
									nVlrApr		:= U_CBRETDAD(aIte[nI],"VLRAPR",0)
									cTpProc  	:= U_CBRETDAD(aIte[nI],"TPPROC","")
									dDtProIte	:= U_CBRETDAD(aIte[nI],"DATPRO", U_CBRETDAD( aDad,"DATPRO",CtoD("") ) )
									cDente 		:= U_CBRETDAD(aIte[nI],"DENTE","")
									cFace 		:= U_CBRETDAD(aIte[nI],"FACE","")
	
									PlsLogFil(Space(03)+"SEQMOV ["+cSeqMov+"] CODPAD ["+cCodPad+"] CODPRO ["+cCodPro+"] QTDSOL ["+AllTrim(Str(nQtdSol,7,2))+"] TPPROC ["+cTpProc+"] DTPROC ["+DToS(dDtProIte)+"] NVLRAPR ["+AllTrim(Str(nVlrApr))+"]"+iif(U_CBRETDAD(ADAD,"TIPO","1")=="4"," DENTE ["+CDENTE+"] FACE ["+CFACE+"] ",""),__PLSFLOGX)
								Next
								PlsLogFil("",__PLSFLOGX)
								Return

/*/{Protheus.doc} U_CBGRVAUN
(long_description)
@type function
@author Tulio Cesar
@since 26.05.07
@version 1.0
/*/
							User Function CBGRVAUN(lBaseadoAtend,cNumGuia,cMatric,dDatPro,cHora,cOpeMov,cCidPri,cCodRda,cOpeSol,cCdPFSO,cCodEsp,aItens,aCriticas,cLocalExec,cTipoGrv)
								LOCAL nFor		  := 0
								LOCAL cCodPad	  := ""
								LOCAL cCodPro	  := ""
								LOCAL nQtdSol	  := 0
								LOCAL cSeqMov	  := ""
								LOCAL cRet        := ""
								DEFAULT aItens    := {}
								DEFAULT aCriticas := {}
								DEFAULT cNumGuia  := ""
								DEFAULT cTipoGrv  := ""

								If lBaseadoAtend
									BEA->(DbSetOrder(1))
									If BEA->(MsSeek(xFilial("BEA")+cNumGuia))
										cMatric := BEA->(BEA_OPEUSR+BEA_CODEMP+BEA_MATRIC+BEA_TIPREG+BEA_DIGITO)
										dDatPro := BEA->BEA_DATPRO
										cHora   := BEA->BEA_HORPRO
										cOpeMov := BEA->BEA_OPEMOV
										cCidPri := BEA->BEA_CID
										cCodRda := BEA->BEA_CODRDA
										cOpeSol := BEA->BEA_OPESOL
										cCdPFSO := BEA->BEA_CDPFSO
										cCodEsp := BEA->BEA_CODESP
		
										aCriticas := {}
										BEG->(DbSetOrder(1))
										BE2->(DbSetOrder(1))
										If BE2->(MsSeek(xFilial("BE2")+BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)))
											While ! BE2->(Eof()) .And. BEA->(BEA_FILIAL+BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT) == ;
													xFilial("BE2")+BE2->(BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)
				
												AaDd(aItens, { {"SEQMOV",BE2->BE2_SEQUEN},{"CODPAD",BE2->BE2_CODPAD},{"CODPRO",BE2->BE2_CODPRO},{"QTD",BE2->BE2_QTDSOL},{"QTDAUT",BE2->BE2_QTDPRO} }  )
				
												If BEG->(DbSeek(xFilial("BEG")+BE2->(BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+BE2_SEQUEN)))
													While ! BEG->(Eof()) .And. BE2->(BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+BE2_SEQUEN) == ;
															xFilial("BEG")+BEG->(BEG_OPEMOV+BEG_ANOAUT+BEG_MESAUT+BEG_NUMAUT+BEG_SEQUEN)
						
														AaDd(aCriticas,{BE2->BE2_SEQUEN,BEG->BEG_CODGLO,BEG->BEG_DESGLO,BEG->BEG_INFGLO})
														BEG->(DbSkip())
						
													Enddo
												Endif
				
												BE2->(DbSkip())
											Enddo
										Endif
									Else
										Conout('Falha na identificacao da guia na funcao U_CBGRVAUN')
										Return
									Endif
								Endif
								cHora := StrTran(cHora,":","")
								cHora := SubStr(cHora,1,2)+SubStr(cHora,3,2)
								BXE->(RecLock("BXE",.T.))
								BXE->BXE_FILIAL := xFilial("BXE")
								BXE->BXE_CODSEQ := GetSX8Num("BXE","BXE_CODSEQ")
								BXE->BXE_MATRIC := cMatric
								BXE->BXE_DATPRO := dDatPro
								BXE->BXE_HORAPR := cHora
								BXE->BXE_OPEMOV := cOpeMov
								BXE->BXE_CIDPRI := cCidPri
								BXE->BXE_CODRDA := cCodRda
								BXE->BXE_OPESOL := cOpeSol
								BXE->BXE_CDPFSO := cCdPFSO
								BXE->BXE_CODESP := cCodEsp

								If BXE->(FieldPos("BXE_TPGRV")) > 0
									BXE->BXE_TPGRV := cTipoGrv
								EndIf

								If BXE->(FieldPos("BXE_ORITRA")) > 0
									BXE->BXE_ORITRA := cTipoGrv
								EndIf

								If BXE->(FieldPos("BXE_NUMGUI")) > 0
									BXE->BXE_NUMGUI := cNumGuia
								Endif

								BXE->(MsUnLock())
								cRet := BXE->BXE_CODSEQ
								ConfirmSX8()

								For nFor := 1 To Len(aItens)
									cSeqMov := U_CBRETDAD(aItens[nFor],"SEQMOV")
									cCodPad := U_CBRETDAD(aItens[nFor],"CODPAD")
									cCodPro := U_CBRETDAD(aItens[nFor],"CODPRO")
									nQtdSol := U_CBRETDAD(aItens[nFor],"QTD",0)
									nQtdAut := U_CBRETDAD(aItens[nFor],"QTDAUT",0)
	
									BXF->(RecLock("BXF",.T.))
									BXF->BXF_FILIAL := xFilial("BXF")
									BXF->BXF_CODSEQ := BXE->BXE_CODSEQ
									BXF->BXF_SEQMOV := cSeqMov
									BXF->BXF_CODPAD := cCodPad
									BXF->BXF_CODPRO := cCodPro
									BXF->BXF_QTD    := nQtdSol
									BXF->(MsUnLock())
								Next

								For nFor := 1 To Len(aCriticas)
									BXG->(RecLock("BXG",.T.))
									BXG->BXG_FILIAL := xFilial("BXG")
									BXG->BXG_CODSEQ := BXE->BXE_CODSEQ
									BXG->BXG_SEQMOV := aCriticas[nFor,1]
									BXG->BXG_CODCRI := aCriticas[nFor,2]
									BXG->BXG_DESCRI := aCriticas[nFor,3]
									BXG->BXG_INFO   := aCriticas[nFor,4]
									BXG->(MsUnLock())
								Next
								Return(cRet)

/*/{Protheus.doc} U_CBEXCAUN(cNumGuia,cCodSeq)
(long_description)
@type function
@author Tulio Cesar
@since 26.05.07
@version 1.0
/*/
							User Function CBEXCAUN(cNumGuia,cCodSeq)
								LOCAL lRet := .F.
								LOCAL cMsg
								LOCAL cChave  := ""
								LOCAL nOrdem
								DEFAULT cCodSeq := ""

								If ! Empty(cNumGuia)
									nOrdem := 4
									cChave := cNumGuia
								Else
									nOrdem := 1
									cChave := cCodSeq
								Endif

								If ! Empty(cChave)
									SIX->(DbSetOrder(1))
									If ! SIX->( MsSeek("BXE"+Str(nOrdem,1) ) )
										cMsg := STR0036+Str(nOrdem,1)+STR0037 //"Indice "###" no arquivo BXE"
									Else
										BXE->(DbSetOrder(nOrdem))
										If BXE->(MsSeek(xFilial("BXE")+cChave))
											BXF->(DbSetOrder(1))
											While BXF->(MsSeek(xFilial("BXF")+BXE->BXE_CODSEQ))
												BXF->(RecLock("BXF",.F.))
												BXF->(DbDelete())
												BXF->(MsUnLock())
											Enddo
			
											BXG->(DbSetOrder(1))
											While BXG->(MsSeek(xFilial("BXG")+BXE->BXE_CODSEQ))
												BXG->(RecLock("BXG",.F.))
												BXG->(DbDelete())
												BXG->(MsUnLock())
											Enddo
											BXE->(RecLock("BXE",.F.))
											BXE->(DbDelete())
											BXE->(MsUnLock())
											lRet := .T.
										Else
											cMsg := STR0038 //"Guia/Critica nao encontrada no arquivo de autorizacoes negadas"
										Endif
									Endif
								Endif
								Return( {lRet,cMsg} )

/*/{Protheus.doc} U_CBRETDAD
Descri‡„o Retorna conteudo da matriz
@type function
@author Alexander Santos
@since 26.05.07
@version 1.0
/*/
							User Function CBRETDAD(aMat,cCampo,cDefault,lId)
								LOCAL nPos  	 := 0
								LOCAL cRet  	 := ""
								DEFAULT cDefault := ""
								DEFAULT lId		 := .f.
// Pega o conteudo
								nPos := Ascan(aMat,{ |x| AllTrim( x[1] ) == AllTrim( cCampo ) } )
// Se achou
								if nPos > 0
									if lId
										cRet := aMat[nPos,3]
									else
										cRet := aMat[nPos,2]
									endIf
	// Compatibiliza com o valor logico enviado pela importacao xml tiss
									if valType(cRet) == 'C' .and. cRet $ 'true,false'
										cRet := iIf(cRet=='true',"1","0")
									endIf
	
									if valType(cRet) <> 'L' .and. empty(cRet)
										cRet := cDefault
									endIf
								else
									cRet := cDefault
								endIf
								return iIf(valType(cRet)=="C",AllTrim(cRet),cRet)

/*/{Protheus.doc} U_CBPUTDAD
Coloca conteudo na matriz
@type function
@author Alexander Santos
@since 26.05.07
@version 1.0
/*/
							User Function CBPUTDAD(aMat,cCampo,cConteudo,lnew,lEmpty,cId)
								LOCAL nPos 		:= 0
								DEFAULT lnew 	:= .f.
								DEFAULT lEmpty 	:= .t.
								DEFAULT cId		:= ""
// Pega o conteudo
								nPos := Ascan(aMat,{ |x| AllTrim( x[1] ) == AllTrim( cCampo ) } )
// Se achou
								if nPos > 0
									if lEmpty
										aMat[nPos,2] := cConteudo
									else
										if !empty(cConteudo)
											aMat[nPos,2] := cConteudo
										endIf
									endIf
								elseIf lnew
									if lEmpty
										aadd( aMat, {cCampo , cConteudo, upper(cId) } )
									elseIf !empty(cConteudo)
										aadd( aMat, {cCampo , cConteudo, upper(cId) } )
									endIf
								endIf
								Return

/*/{Protheus.doc} U_CBDADITE
Monta matriz dadite
@type function
@author Alexander Santos
@since 26.05.07
@version 1.0
/*/
							User Function CBDADITE(aDadIte,aItens,cOrigem,cLibEsp,cAuditoria,cNumImp,cStatus,dDatPro,aDadRda,cAlias)
								LOCAL nI		:= 1
								LOCAL cCdpDrc 	:= "01"
								LOCAL cBloPag 	:= "0"
								LOCAL cSolRev 	:= "0"
								LOCAL cHora		:= StrTran(Time(),":","")
								LOCAL cTipPe  	:= BAU->BAU_TIPPE
								LOCAL nQtdSol   := U_CBRETDAD(aItens,"QTD",0)
								LOCAL cTipEve	:= U_CBRETDAD(aItens,"TIPEVE","")
								LOCAL cPROCCI 	:= Iif(cTipEve$"2,3","1","0")
								LOCAL cVia    	:= U_CBRETDAD(aItens,'VIAAC',"")
								LOCAL nPerVia 	:= Iif(cPROCCI=="1",100,0)
								LOCAL cDente 	:= AllTrim( U_CBRETDAD(aItens,"DENTE","") )
								LOCAL cFace 	:= U_CBRETDAD(aItens,"FACE","")
								LOCAL cCodPad 	:= AllTrim( U_CBRETDAD(aItens,"CODPAD") )
								LOCAL cCodPro 	:= AllTrim( U_CBRETDAD(aItens,"CODPRO") )
								LOCAL aMatCam	:= {}
								DEFAULT cAlias	:= "BE2"
								DEFAULT cStatus := iif( Empty( U_CBRETDAD(aItens,"STATUS") ),"0",U_CBRETDAD(aItens,"STATUS") )
								DEFAULT aDadRda	:= {}
// se existe a sequencia nao inclui novamente
								if ascan( aDadIte,{|x| x[1,2] == U_CBRETDAD(aItens,"SEQMOV") } ) > 0
									return(nil)
								endIf
// Via de acesso
								cVia := Iif( !Empty(cVia),cVia,Iif(cPROCCI=="1",GetNewPar("MV_PLSVAPR","0"),"") )
// Define campos de tratamento e conteudo
// 3 posicao do aMatCam definine se nao vai .T.ou vai .F. fazer fieldpos
								aMatCam :={ {cAlias+"_SEQUEN",U_CBRETDAD(aItens,"SEQMOV"),.T.},;
									{cAlias+"_CODPAD",U_CBRETDAD(aItens,"CODPAD"),.T.},;
									{cAlias+"_CODPRO",U_CBRETDAD(aItens,"CODPRO"),.T.},;
									{cAlias+"_DESPRO",U_CBRETDAD(aItens,"DESCRI",""),.T.},;
									{cAlias+"_QTDSOL","Eval({|| nQtdSol })",.F.},;
									{cAlias+"_QTDPRO","Eval({|| U_CBRETDAD(aItens,'QTDAUT',nQtdSol) })",.T.},;
									{cAlias+"_SALDO","Eval({|| Iif(cOrigem=='1',0,nQtdSol) })",.F.},;
									{cAlias+"_CHVNIV",U_CBRETDAD(aItens,"CHVNIV",""),.F.},;
									{cAlias+"_NIVAUT",U_CBRETDAD(aItens,"NIVAUT",""),.F.},;
									{cAlias+"_NIVCRI",U_CBRETDAD(aItens,"NIVCRI",""),.F.},;
									{cAlias+"_NIVEL",U_CBRETDAD(aItens,"NIVEL",""),.F.},;
									{cAlias+"_TPPROC",U_CBRETDAD(aItens,"TPPROC",""),.F.},;
									{cAlias+"_VLRAPR","Eval({|| U_CBRETDAD(aItens,'VLRAPR',0) })",.F.},;
									{cAlias+"_VALOR","Eval({|| U_CBRETDAD(aItens,'VLRAPR',0) })",.F.},;
									{cAlias+"_VALTOT","Eval({|| U_CBRETDAD(aItens,'QTDAUT',nQtdSol)*U_CBRETDAD(aItens,'VLRAPR',0) })",.F.},;
									{cAlias+"_DATPRO","Eval({|| U_CBRETDAD(aItens,'DATPRO',dDatPro) })",.T.},;
									{cAlias+"_HORPRO",U_CBRETDAD(aItens,"HORINI",cHora),.F.},;
									{cAlias+"_HORINI",U_CBRETDAD(aItens,"HORINI",cHora),.F.},;
									{cAlias+"_HORFIM",U_CBRETDAD(aItens,"HORFIM",cHora),.T.},;
									{cAlias+"_STATUS",cStatus,.T.},;
									{cAlias+"_TIPRDA",cTipPe,.F.},;
									{cAlias+"_LIBESP",cLibEsp,.F.},;
									{cAlias+"_AUDITO",cAuditoria,.F.},;
									{cAlias+"_PROCCI",cPROCCI,.F.},;
									{cAlias+"_CDPDRC",cCdpDrc,.F.},;
									{cAlias+"_BLOPAG",cBloPag,.F.},;
									{cAlias+"_SOLREV",cSolRev,.F.},;
									{cAlias+"_NUMIMP",cNumImp,.F.},;
									{cAlias+Iif(cAlias == "BE2","_VIA","_VIACES"),cVia,.T.},;
									{cAlias+"_PERVIA",'Eval({|| nPerVia })',.F.},;
									{cAlias+"_DENREG",cDente,.F.},;
									{cAlias+"_DESREG",u_CBDESDF(cCodPad + cCodPro+Space(TamSx3("BE2_CODPRO")[1]-Len(cCodPro) ) + cDente + Space( TamSx3("B05_CODIGO")[1]-Len(cDente) ),0),.F.},;
									{cAlias+"_FADENT",cFace,.F.},;
									{cAlias+"_FACDES",u_CBDESDF(cFace,1),.F.},;
									{cAlias+"_PRFATD",Iif(Len(aDadRDA)>0,aDadRDA[5],""),.F.},;
									{cAlias+"_RESAUT",U_CBRETDAD(aItens,"RESAUT",""),.F.},;
									{cAlias+"_MEMO1" ,U_CBRETDAD(aItens,"INDCLIEVO",""),.T.},;
									{cAlias+"_TECUTI",U_CBRETDAD(aItens,"TECUT",""),.F.},;
									{cAlias+"_PRPRRL","Eval({|| U_CBRETDAD(aItens,'REDAC',0) })",.F.},;
									{cAlias+"_REDACR","Eval({|| U_CBRETDAD(aItens,'REDAC',0) })",.F.},;
									{cAlias+"_VLCOMP","Eval({|| U_CBRETDAD(aItens,'VLCOMP',0) })",.F.},;
									{cAlias+"_NRTROL","Eval({|| U_CBRETDAD(aItens,'TRAITEPTU','') })",.T.},;
									{cAlias+"_NRAOPE","Eval({|| U_CBRETDAD(aItens,'NRAOPE','') })",.T.},;
									{cAlias+"_PACOTE","Eval({|| U_CBRETDAD(aItens,'PACOTE','') })",.T.},;
									{cAlias+"_DIAGNO",U_CBRETDAD(aItens,"DIAGNO","NAO INFORMADO"),.F.},;
									{cAlias+"_SEQPTU",U_CBRETDAD(aItens,"SQ_ITEM"),.T.},;
									{cAlias+"_REGANV",U_CBRETDAD(aItens,"CD_ANVISA"),.T.},;
									{cAlias+"_GUIJUR",U_CBRETDAD(aItens,"ID_LIMINAR"),.T.}}
// Monta matriz adadite
								bMat := " {|| AaDd(aDadIte,{ "

								For nI:=1 To Len(aMatCam)
									If aMatCam[nI,3] .Or. &( cAlias+"->( FieldPos('"+aMatCam[nI,1]+"') )" ) > 0
		
										If At('EVAL',Upper(aMatCam[nI,2])) == 0
											bMat += "{'"+aMatCam[nI,1]+"','"+aMatCam[nI,2]+"'},"
										Else
											bMat += "{'"+aMatCam[nI,1]+"'," + aMatCam[nI,2] + " },"
										EndIf
									EndIf
								Next

								bMat := Left(bMat,Len(bMat)-1) + " } ) } "

								Eval(&bMat)
								return(nil)

/*/{Protheus.doc} U_CBVLDMATAN
Valida Matricula
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function CBVLDMATAN(cMatric)
								LOCAL lRet := .T.

								BA1->( DbSetOrder(2) ) //BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
								lRet := !BA1->( MsSeek( xFilial("BA1")+cMatric ) )
// Verifica matricula antiga
								BA1->( DbSetOrder(5) ) //BA1_FILIAL + BA1_MATANT + BA1_TIPANT
								If lRet
									lRet := !BA1->( MsSeek( xFilial("BA1")+cMatric ) )
								EndIf
								If lRet
									lRet := !BA1->( MsSeek( xFilial("BA1")+Right(cMatric,16) ) )
								EndIf
// Posiciona na familia
								BA3->(DbSetOrder(1))
								BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))

								Return lRet

/*/{Protheus.doc} U_CBVLDPRO
Verificaçao do procedimento
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function CBVLDPRO(aItens,cLocalExec,cTipoGrv,cCidPri,cOrigem,nTp,aEventosNeg,aCriticas)
								LOCAL nY,nX	  := 0
								LOCAL nQtdSol := 0
								LOCAL cSeqMov := ""
								LOCAL cCodPad := ""
								LOCAL cCodPro := ""
								LOCAL lRet    := .T.
								LOCAL lFatal  := .F.
								LOCAL aRetFun := {}
								LOCAL aTrb	  := {}
								LOCAL aOldCri := {}
								DEFAULT nTp   := 1
// Salvo a matriz aCodCri Statica
								aOldCri := PLLimpCCri(.F.)
// Verifica todos os itens
								For nY := 1 To Len(aItens)
									cSeqMov	:= U_CBRETDAD(aItens[nY],"SEQMOV")
									cCodPad	:= U_CBRETDAD(aItens[nY],"CODPAD")
									cCodPro	:= U_CBRETDAD(aItens[nY],"CODPRO")
									cDescri	:= U_CBRETDAD(aItens[nY],"DESCRI","")
									nQtdSol := U_CBRETDAD(aItens[nY],"QTD",0)
									nQtdAut := U_CBRETDAD(aItens[nY],"QTDAUT",0)
									cDente  := U_CBRETDAD(aItens[nY],"DENTE","")
									cFace   := U_CBRETDAD(aItens[nY],"FACE","")
									cSlvPad := U_CBRETDAD(aItens[nY],"SLVPAD","")
									cSlvPro := U_CBRETDAD(aItens[nY],"SLVPRO","")
									aTrb	:= {}
	// Limpar outras criticas
									PLLimpCCri(.T.)
	// Verifica se o procedimento informado existente na tabela padrao
									aRetFun := PLSVLDPTP(cCodPad,cCodPro,cLocalExec,cTipoGrv)
									If !aRetFun[1]
										lRet	:= .F.
										lFatal 	:= !BR8->( Found() )
										aTrb   	:= aRetFun[2]
									Endif
	// Verifica se o procedimento informado e obrigatorio informar o Cid
									If nTp == 1
										If aRetFun[1]
			// Verifica se o procedimento/Cid
											aRetFun := PLSVLDOCD(cCodPad,cCodPro,cLocalExec,cCidPri,nQtdSol,IiF( cOrigem=="2",.T.,.F. ),IiF( cOrigem=="2",.F.,.T. ),cTipoGrv,NIL)
											If !aRetFun[1]
												lRet := .F.
												aTrb := aRetFun[2]
											Endif
										EndIf
									EndIf
	// Inclui a critica e o evento negado
									If !aRetFun[1]
										AaDd( aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro} )
		// Alimenta a critica
										For nX := 1 To Len(aTrb)
											AaDd( aCriticas,{cSeqMov,aTrb[nX,1],aTrb[nX,2]+Iif(Len(aTrb[nX])>=3 .And. !Empty(aTrb[nX,3]),' ( '+aTrb[nX,3]+' ) ',''),cCodPad,cCodPro,cDente,cFace} )
										Next
									EndIf
								Next
// Retorna com o conteudo original
								PLLimpCCri(.F.,.T.,aOldCri)
								Return( { lRet , lFatal } )

/*/{Protheus.doc} U_CBXMOVREG
Validacoes regras de usuario local e de intercambio
Para intercambio somente se a operadora nao estiver online
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function CBXMOVREG(aItens,lAprovLib,lTrtUsr,lRegras,lConsulta,cOrigem,cAno,cMes,dDatPro,cHora,aDadUsr,aDadRDA,cCidPri,;
									cLocalExec,cOpeSol,cCDPFSO,cPadInt,cPadCon,cRegAte,cCodPRFExe,cOpeExe,lRegPagAto,cTipoGrv,cAreaAbr,;
									cCodEsp,cCodLoc,cFilBCT,cTipoGrv,cLibEsp,cNumImp,cOpeMov,nQtdDiAut,aDadIte,aCriticas,;
									aEventosNeg,aEventosAut,lAudEmp,lFAudMOP,lFAudAte,lForcAud,lAutoCus,aRdaProf,cCodEspPro,cCodLocPro,lTrtExe,;
									aDadBea,lAto,lWeb,lInter,lSolicit,lXMLLote,lPacAudi,lPtuOnline,cRdaEDI,lPtuA1100,lConPtuOn,cTipGui,;
									cEspSol,cEspExe,cNumLib,cCarSol,cSenBSN,cNuLibera, lNovaLiberacao, cAteRn)
								LOCAL nFor2,nFor	:= 0
								LOCAL nRecBD6		:= 0
								LOCAL nQtdSol 		:= 0
								LOCAL nQtdAut 		:= 0
								LOCAL cSeqMov 		:= ""
								LOCAL cCodPad 		:= ""
								LOCAL cCodPro 		:= ""
								LOCAL cTpProc 		:= ""
								LOCAL cDente 		:= ""
								LOCAL cFace 		:= ""
								LOCAL cAuditoria	:= "0"
								LOCAL cIdRespWsd    := ""
								LOCAL cCrRespWsd    := ""
								LOCAL cDescGlo      := ""
								LOCAL lContinua 	:= .T.
								LOCAL lLogEx		:= .T.
								LOCAL lExc := .F.
								LOCAL lAudTodos     := .F.
								LOCAL lCriCab       := .F.
								LOCAL lNegAllIte    := .F.
								LOCAL aTrb 			:= {}
								LOCAL aRetFun		:= {}
								LOCAL aCliente		:= {}
								LOCAL aOldCri		:= {}
								LOCAL aRet          := {}
								LOCAL nH            := 0
								LOCAL nPoa			:= 0
								LOCAL aQtdBrow		:= {}
								LOCAL __cSeqMov 	:= ""
								LOCAL __cCodPad 	:= ""
								LOCAL __cCodPro 	:= ""
								LOCAL __cDescri		:= ""
								LOCAL __nQtdSol 	:= ""
								LOCAL __nQtdAut 	:= ""
								LOCAL __cTpProc		:= ""
								LOCAL __cDente  	:= ""
								LOCAL __cFace   	:= ""
								LOCAL __cStProc 	:= ""
								LOCAL aVldGen 		:= {}
								LOCAL lTratExLib  := if(allTrim(getNewPar("MV_PLEXLB","0"))=="1",.T.,.F.)
								LOCAL aRetAudPTU    := {}
								LOCAL lVerAllAud    := GetNewPar("MV_PLAUDTO","0") == "1"
								LOCAL cCriNegAll    := GetNewPar("MV_PTCRINE","")
								LOCAL aAreaBR8      := {}
								LOCAL lPermAudBR    := .F.
								LOCAL nCrit      := 0
								LOCAL aBCTArea      := {}
								LOCAL aRegCriDel    := {}
								LOCAL nSizeTrb      := 0
								LOCAL lDelCriArr    := .F.
								LOCAL lPtuOnUr      := .F.
								LOCAL lTmpAudTod    := .F.
								LOCAL aPreValid     := {}
								LOCAL lBaixoRisc    := .F.
								LOCAL lImpedeAud	:= .F. // Se ocorreu critica que não deve gerar demanda desnecessária na auditoria
								LOCAL nTraiTePTU    := 0
								LOCAL cStatItem     := ""

								DEFAULT lFAudMOP	:= .F.
								DEFAULT lFAudAte	:= .F.
								DEFAULT lForcAud	:= .F.
								DEFAULT lAutoCus	:= .F.
								DEFAULT lAto		:= .F.
								DEFAULT lXMLLote	:= .F.
								DEFAULT lPacAudi    := .F.
								DEFAULT lPtuOnline  := .F.
								DEFAULT lConPtuOn   := .F.
								DEFAULT cTipGui		:= ""
								DEFAULT cEspSol    := ""
								DEFAULT cEspExe    := ""
								DEFAULT cNumLib		:= ""
								DEFAULT cCarSol     := ""
								DEFAULT cSenBSN     := ""
								DEFAULT cNuLibera   := ""
								DEFAULT lNovaLiberacao := .F.
								DEFAULT cAteRn       := '0'
//grava informações que seram utilizadas para definir quais
//validações seram feitas na confirmação das guias de atendimento no portal
								aLibera := {}
								AADD(aLibera, {lWeb,lAprovLib})

// Salvo a matriz aCodCri Statica
								If !lXMLLote
									aOldCri := PLLimpCCri(.F.)
								EndIf
// Se recebimento de Ptu Online com itens carregados pula verificacao
								If Len(aDadIte) > 0 .And. lPtuOnline
									Return({})
								EndIf
// Verifica se ha criticas de cabecalho
								If Len(aCriticas) > 0 .And. lPtuOnline
									lCriCab := .T.
								EndIf
// Atualiza variavel para verificacao de Abrangencia
								If Empty(cAreaAbr)  .And. len(aDadUsr)>=65
									cAreaAbr := aDadUsr[65]
								EndIf
// Se PTU Online e Emergencia, nao verifica Abrangecia
								If lPtuOnline .And. cCarSol == "U"
									aVldGen := {nil,nil,nil,nil,nil,nil,.T.,nil,nil,nil,nil}
									lPtuOnUr  := .T.
								EndIf
// Trato o aCriticas quando ha criticas de cabeçalho
								If lPtuOnUr .And. lPtuOnline .And. Len(aCriticas) > 0
									aRegCriDel := {}
									nSizeTrb   := 0
	
									For nCrit := 1 to len(aCriticas)
		
										If !Empty(aCriticas[nCrit][2])
											If Alltrim(aCriticas[nCrit][2]) $ "011/032/038/050"
												lDelCriArr := .T.
												PlsPtuLog("Removendo crítica de abrangÊncia "+aCriticas[nCrit][2]+". Atendimento de UrgÊncia/EmergÊncia.")
											Else
												lDelCriArr := .F.
											EndIf
										EndIf
		// Marca Posicoes do Array que serao deletadas
										If lDelCriArr
											Aadd(aRegCriDel,nCrit)
										EndIf
									Next
	// Deleta posicoes marcadas do array
									If len(aRegCriDel) >0
										For nCrit := 1 to len(aRegCriDel)
											aDel(aCriticas,aRegCriDel[(len(aRegCriDel)+1)-nCrit])//Deleto a partir das ultimas posicoes para nao perder o ponteiro
											nSizeTrb ++
										Next
		
										aSize(aCriticas,len(aCriticas)-nSizeTrb)
									EndIf
	// Se nao restou criticas, autorizo o evento
									If len(aCriticas) == 0
										lContinua   := .T.
										lCriCab     := .F.
										aEventosNeg := {}
									EndIf
	
								EndIf

// MV_PLAUDTO - Ao processar uma solicitacao Ptu Online ha a opcao de enviar
// todos os itens para auditoria quando um deles for marcado para auditar
//
// MV_PTCRINE - Indica criticas que se apresentadas, irao suplantar todas que
// estiverem parametrizadas para envio a auditoria
								If lPtuOnline .And. (lVerAllAud .Or. !Empty(cCriNegAll)) .And. !lPtuA1100
									For nFor := 1 To Len(aItens)
										lContinua 	:= .T.
										cLibEsp 	:= "0"
										cAuditoria 	:= "0"
										aRetAudPTU     := {}
										aVldGen     := {}
		// Alimenta variaveis
										cSeqMov 	:= U_CBRETDAD(aItens[nFor],"SEQMOV")
										cCodPad 	:= U_CBRETDAD(aItens[nFor],"CODPAD")+Space(TamSx3("BD6_CODPAD")[1] - Len(U_CBRETDAD(aItens[nFor],"CODPAD")))
										cCodPro 	:= U_CBRETDAD(aItens[nFor],"CODPRO")+Space(TamSx3("BD6_CODPRO")[1] - Len(U_CBRETDAD(aItens[nFor],"CODPRO")))
										cDescri		:= U_CBRETDAD(aItens[nFor],"DESCRI","")
										nQtdSol 	:= U_CBRETDAD(aItens[nFor],"QTD",0)
										nQtdAut 	:= U_CBRETDAD(aItens[nFor],"QTDAUT",0)
										cTpProc		:= U_CBRETDAD(aItens[nFor],"TPPROC","")
										cDente  	:= U_CBRETDAD(aItens[nFor],"DENTE","")+Space(TamSx3("BD6_DENREG")[1] - Len(U_CBRETDAD(aItens[nFor],"DENTE","")))
										cFace   	:= U_CBRETDAD(aItens[nFor],"FACE","")
										cStProc   	:= U_CBRETDAD(aItens[nFor],"STPROC","")
										cDiagno	    := U_CBRETDAD(aItens[nFor],"DIAGNO","")
										cDsEvento	:= U_CBRETDAD(aItens[nFor],"DSEVENTO","0")
		// Ordem no BD6
										BD6->( DbSetOrder(1) )
										nRecBD6 := 0
		// Se PTU Online e Emergencia, nao verifica Abrangecia
										If lPtuOnline .And. cCarSol == "U"
											aVldGen  := {nil,nil,nil,nil,nil,nil,.T.,nil,nil,nil,nil}
											lPtuOnUr := .T.
										EndIf
		// Se tem uma liberacao
										If lAprovLib .And. BD6->( MsSeek(xFilial("BD6")+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI+BEA_ORIMOV) ) )
			// ja foi liberada pela auditoria/esta autorizada e ainda nao virou uma autorizacao
											If BEA->BEA_STATUS == "1" .and. BD6->BD6_SITUAC == "3"
												lTrtUsr := .F.
											Endif
			// Para nao pegar a liberacao no tratamento de periodicidade e outros
											nRecBD6 := BD6->( Recno() )
										Endif
		// Se PTU Online e Emergencia, nao verifica Abrangecia
										If cCarSol == "U"
											aVldGen := {nil,nil,nil,nil,nil,nil,.T.,nil,nil,nil,nil}
										EndIf
		// Item de Baixo Risco nao vou realizar as criticas de auditoria
										If BR8->( FieldPos("BR8_RISCO") ) > 0
											lBaixoRisc	:= VBaixRisco(aItens)
										EndIf
		
										If lBaixoRisc
											If len(aVldGen) > 0
												aVldGen[8]  := .F.
												aVldGen[10] := .F.
											Else
												aVldGen := {nil,nil,nil,nil,nil,nil,nil,.F.,nil,.F.,nil}
											EndIf
										EndIf
		// Vai checar regra para todos os casos menos quando existir uma liberacao
		// O lRegras somente sera false no caso de um processo do Ptu OnLine (Meu usuario em outra operadora)
		// Isso esta no fonte plstrtptu_scs2
		// Sempre tem que entrar aqui caso nao exista uma liberacao
										If !lAprovLib .And. lRegras .Or. ( cOrigem == "2" .And. nQtdAut == 0 )
			
											aQtdBrow := {}	// Reinicia array.
											For nH := 1 To Len(aItens)
												__cSeqMov 	:= U_CBRETDAD(aItens[nH],"SEQMOV")
												__cCodPad 	:= U_CBRETDAD(aItens[nH],"CODPAD")+Space(TamSx3("BD6_CODPAD")[1] - Len(U_CBRETDAD(aItens[nH],"CODPAD")))
												__cCodPro 	:= U_CBRETDAD(aItens[nH],"CODPRO")+Space(TamSx3("BD6_CODPRO")[1] - Len(U_CBRETDAD(aItens[nH],"CODPRO")))
												__cDescri	:= U_CBRETDAD(aItens[nH],"DESCRI","")
												__nQtdSol 	:= U_CBRETDAD(aItens[nH],"QTD",0)
												__nQtdAut 	:= U_CBRETDAD(aItens[nH],"QTDAUT",0)
												__lAutoriz	:= U_CBRETDAD(aItens[nH],"STPROC")=="S"
												__cTpProc	:= U_CBRETDAD(aItens[nH],"TPPROC","")
												__cDente  	:= U_CBRETDAD(aItens[nH],"DENTE","")+Space(TamSx3("BD6_DENREG")[1] - Len(U_CBRETDAD(aItens[nH],"DENTE")))
												__cFace   	:= U_CBRETDAD(aItens[nH],"FACE","")
												__cSequen	:= U_CBRETDAD(aItens[nH],"SEQMOV","")
												__cStProc	:= U_CBRETDAD(aItens[nH],"STPROC","")
				
												If (__cCodPad + __cCodPro == cCodPad + cCodPro .and. __cDente + __cFace == cDente + cFace )	// Retira o registro atual da matriz que sera enviada ao PLSAUTP()
													Loop
					
												Elseif !__lAutoriz 	//	Se o registro atual não estiver autorizado não entra na matriz.
													Loop
					
												Endif
												AaDd(aQtdBrow,{	;
													__cCodPad,;
													__cCodPro,;
													__nQtdSol,;
													dDatPro,;
													cHora,;
													__cDente,;
													__cFace,;
													__cSequen})
											Next
			
			// PLSAUTP
											aRetFun := PLSAUTP( dDatPro,;
												cHora,;
												cCodPad,;
												cCodPro,;
												If(nQtdSol==0,1,nQtdSol),;
												aDadUsr,;
												nRecBD6,;
												Iif(lTrtExe,aRdaProf,aDadRDA),;
												"1",;
												Iif(GetNewPar("MV_PLSMODA","1")=="0",.F.,.T.),;
												cCidPri,;
												lTrtUsr,;
												cLOCALExec,;
												lSolicit,;
												cOpeSol,;
												cCDPFSO,;
												cAno,;
												cMes,;
												cPadInt,;
												cPadCon,;
												cRegAte,;
												.T.,;
												cCodPRFExe,;
												nil,;
												nil,;
												cOpeExe,;
												nil,nil,nil,nil,;
												cSeqMov,;
												cNumLib,;
												lRegPagAto,;
												cTipoGrv,;
												nil,nil,nil,nil,nil,nil,;
												iif(!Empty(cRdaEDI),cRdaEDI,nil),;
												nil,;
												cAreaAbr,;
												nil,nil,;
												cDente,;
												nil,;
												.F.,;
												Iif(lTratExLib, lTratExLib, (!lSolicit .Or. !empty(cCodPRFExe))),;
												.t.,;
												cTpProc,;
												cCodEspPro,;
												aQtdBrow,;
												aVldGen,;
												Iif(!Empty(cCodLocPro),cCodLocPro,cCodLoc),;
												nil,;
												nil,;
												cTpProc,;
												lWeb,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												cEspSol,;
												cEspExe,;
												nil,;
												nil,;
												nil,;
												cStProc,;
												nil,;
												nil,;
												nil,;
												lPtuOnline,;
												lInter,;
												@aRetAudPTU )
			
			// Retorno
											lContinua := aRetFun[1]
			
											If LEN(aRetFun) > 1
												aTrb := aRetFun[2]
											EndIf
			
											Aadd(aPreValid,aClone(aRetFun))
			// Deleta criticas de abrangencia quando atendimento de Urg/Emerg. PTU Online
											If lPtuOnUr .and. lPtuOnLine .and. !lContinua
												aRegCriDel := {}
												nSizeTrb   := 0
				
												For nCrit := 1 to len(aTrb)
					// BCT_ATIVBR - Verifica se exibo ou nao as criticas apresentadas no Baixo Risco
													If !Empty(aTrb[nCrit][1])
														If Alltrim(aTrb[nCrit][1]) $ "011/032/038/050"
															lDelCriArr := .T.
															PlsPtuLog(cCodPad+"-"+Alltrim(cCodPro)+" -> Removendo crítica de abrangÊncia "+aTrb[nCrit][1]+". Atendimento de UrgÊncia/EmergÊncia.")
														Else
															lDelCriArr := .F.
														EndIf
													EndIf
					// Marca Posicoes do Array que serao deletadas
													If lDelCriArr
														Aadd(aRegCriDel,nCrit)
													EndIf
												Next
				// Deleta posicoes marcadas do array
												If len(aRegCriDel) >0
													For nCrit := 1 to len(aRegCriDel)
														aDel(aTrb,aRegCriDel[(len(aRegCriDel)+1)-nCrit])//Deleto a partir das ultimas posicoes para nao perder o ponteiro
														nSizeTrb ++
													Next
					
													aSize(aTrb,len(aTrb)-nSizeTrb)
												EndIf
				// Se nao restou criticas, autorizo o evento
												If len(aTrb) == 0
													lContinua := .T.
												EndIf
				
											EndIf
			
			// Verifica se o evento e de Baixo Risco, caso positivo, o mesmo nao pode ser
			// enviado para estudo.
											If lPtuOnline .And. lBaixoRisc .And. BCT->( FieldPos("BCT_ATIVBR") ) > 0
				
												lPermAudBR := .F.
				// Verifica criticas que permitem Auditoria no Baixo Risco:
				// 022 - Para este procedimento necessita Guia da Empresa.
												If !lContinua .And. len(aTrb) > 0
													For nFor2 := 1 To Len(aTrb)
														If aTrb[nFor2][1] == __aCdCri052[1]
															lPermAudBR := .T.
														EndIf
													Next
												EndIf
				// Verifica se o evento e de Baixo Risco
												If lBaixoRisc .And. !lPermAudBR .And. !lContinua
					
													aRegCriDel := {}
													nSizeTrb   := 0
					
													For nCrit := 1 to len(aTrb)
						// BCT_ATIVBR - Verifica se exibo ou nao as criticas apresentadas no Baixo Risco
														If !Empty(aTrb[nCrit][1])
							
															aBCTArea := BCT->(GetArea())
															BCT->(DbSetOrder(1))//BCT_FILIAL + BCT_CODOPE + BCT_PROPRI + BCT_CODGLO
															If BCT->(DbSeek(xFilial("BCT")+PlsIntPad()+aTrb[nCrit][1])) .And. BCT->BCT_ATIVBR == "0"
																lDelCriArr := .T.
															Else
																lDelCriArr := .F.
															EndIf
															RestArea(aBCTArea)
														EndIf
						// Marca Posicoes do Array que serao deletadas
														If lDelCriArr
															Aadd(aRegCriDel,nCrit)
														EndIf
													Next
					// Deleta posicoes marcadas do array
													If len(aRegCriDel) >0
														For nCrit := 1 to len(aRegCriDel)
															aDel(aTrb,aRegCriDel[(len(aRegCriDel)+1)-nCrit])//Deleto a partir das ultimas posicoes para nao perder o ponteiro
															nSizeTrb ++
														Next
						
														aSize(aTrb,len(aTrb)-nSizeTrb)
													EndIf
					// Se restou criticas, aciona o Baixo Risco
													If len(aTrb) == 0
														lContinua := .T.
													EndIf
					
												EndIf
											EndIf
										Endif
		
										If !lContinua
											For nFor2 := 1 To Len(aTrb)
				// Coloca na auditoria
												If aTrb[nFor2,1] == __aCdCri051[1]
													cAuditoria := "1"
												EndIf
				// Quando for critica de guia da empresa tb vai para auditoria ptu-online
												If lAudEmp
													If aTrb[nFor2,1] == __aCdCri052[1]
														cAuditoria := "1"
													EndIf
												EndIf
				// Se a critica coloca na auditoria
												If cAuditoria <> "1"
					// Ponto de entrada para indicar se o procedimento vai para auditoria PTU On
													If  lPtuOnline .And. ExistBlock("PLAUPTON")
														cAuditoria := ExecBlock("PLAUPTON",.F.,.F.,{aDadUsr,aTrb,cOpeSol,aRetAudPTU} )
														aRetAudPTU := {.T.,cAuditoria}
													Else
						// Verifico se a critica dele colocar o procedimento em auditoria
														If BCT->( FieldPos("BCT_AUDITO") ) > 0 //.And. !lConsulta -> Removido pois no Baixo Risco, a parametrizacao que define se vai ou nao para auditoria
															BCT->( DbSetOrder(1) ) //BCT_FILIAL + BCT_CODOPE + BCT_PROPRI + BCT_CODGLO
															If BCT->( MsSeek( xFilial("BCT")+PlsIntPad()+aTrb[nFor2,1] ) )
																cAuditoria := Iif(BCT->BCT_AUDITO == "1","1","0")
															EndIf
														EndIf
						// aRetAudPTU indica se o item pode ser enviado ou nao para auditoria     	 |
						// Implementado para a regra de item com valor inferior a 6 consultas       |
														If len(aRetAudPTU) > 1
															cAuditoria := aRetAudPTU[2]
														EndIf
													EndIf
												EndIf
				// lNegAllIte - Indica se determinada critica for apresentada, ela deve  	       |
				// negar todos os itens do PTU msm que existe itens parametrizados para auditoria |
												If aTrb[nFor2,1] $ cCriNegAll
													lNegAllIte := .T.
												EndIf
				
											Next
			// Indica que um dos itens caiu para estudo e nao e baixo risco
											If cAuditoria == "1" .And. !lBaixoRisc
												lTmpAudTod := .T.
											Endif
										EndIf
		
		// Ha um item com descricao, precisa enviar para auditoria
										If cDsEvento == "1" .And. !lBaixoRisc
											lTmpAudTod := .T.
										EndIf
									Next
	// Se algum item cai para auditoria, aborta verificacao
									If (lTmpAudTod .Or. lFAudMOP .Or. lFAudAte .Or. lForcAud .Or. lAutoCus .Or. lPacAudi ) .And. lVerAllAud
										lAudTodos := .T.
									EndIf
								EndIf
// Tratamento dos Itens
								For nFor := 1 To Len(aItens)
									lContinua 	:= .T.
									cLibEsp 	:= "0"
									cAuditoria 	:= "0"
									lImpedeAud	:= .F.
									aRetAudPTU     := {}
									aVldGen     := {}
	// Alimenta variaveis
									cSeqMov 	:= U_CBRETDAD(aItens[nFor],"SEQMOV")
									cCodPad 	:= U_CBRETDAD(aItens[nFor],"CODPAD")+Space(TamSx3("BD6_CODPAD")[1] - Len(U_CBRETDAD(aItens[nFor],"CODPAD")))
									cCodPro 	:= U_CBRETDAD(aItens[nFor],"CODPRO")+Space(TamSx3("BD6_CODPRO")[1] - Len(U_CBRETDAD(aItens[nFor],"CODPRO")))
									cDescri		:= U_CBRETDAD(aItens[nFor],"DESCRI","")
									nQtdSol 	:= U_CBRETDAD(aItens[nFor],"QTD",0)
									nQtdAut 	:= U_CBRETDAD(aItens[nFor],"QTDAUT",0)
									cTpProc		:= U_CBRETDAD(aItens[nFor],"TPPROC","")
									cDente  	:= U_CBRETDAD(aItens[nFor],"DENTE","")+Space(TamSx3("BD6_DENREG")[1] - Len(U_CBRETDAD(aItens[nFor],"DENTE","")))
									cFace   	:= U_CBRETDAD(aItens[nFor],"FACE","")
									cSlvPad     := U_CBRETDAD(aItens[nFor],"SLVPAD","")
									cSlvPro		:= U_CBRETDAD(aItens[nFor],"SLVPRO","")
									cStProc   	:= U_CBRETDAD(aItens[nFor],"STPROC","")
									cDiagno	:= U_CBRETDAD(aItens[nFor],"DIAGNO","")
									cDsEvento	:= U_CBRETDAD(aItens[nFor],"DSEVENTO","0")
	
									If lPtuA1100
										cIdRespWsd := U_CBRETDAD(aItens[nFor],"ID_RESPWSD","")
										cCrRespWsd := U_CBRETDAD(aItens[nFor],"CD_MENS_ER","")
									EndIf
	// Ordem no BD6
									BD6->( DbSetOrder(1) )
									nRecBD6 := 0
	// Se tem uma liberacao
									If lAprovLib .And. BD6->( MsSeek(xFilial("BD6")+BEA->(BEA_OPEMOV+BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI+BEA_ORIMOV) ) )
		// ja foi liberada pela auditoria/esta autorizada e ainda nao virou uma autorizacao
										If BEA->BEA_STATUS == "1" .and. BD6->BD6_SITUAC == "3"
											lTrtUsr := .F.
										Endif
		// Para nao pegar a liberacao no tratamento de periodicidade e outros
										nRecBD6 := BD6->( Recno() )
									EndIf
	
	// Se PTU Online e Emergencia, nao verifica Abrangecia
									If lPtuOnline .And. cCarSol == "U"
										aVldGen  := {nil,nil,nil,nil,nil,nil,.T.,nil,nil,nil,nil}
										lPtuOnUr := .T.
									EndIf
	// Item de Baixo Risco nao vou realizar as criticas de auditoria
									If !lBaixoRisc .And. BR8->( FieldPos("BR8_RISCO") ) > 0
										lBaixoRisc	:= VBaixRisco(aItens)
									EndIf
	// Item de Baixo Risco nao vou realizar as criticas de auditoria
									If lBaixoRisc .And. lPtuOnline
										If len(aVldGen) > 0
											aVldGen[8]  := .F.
											aVldGen[10] := .F.
										Else
											aVldGen := {nil,nil,nil,nil,nil,nil,nil,.F.,nil,.F.,nil}
										EndIf
									EndIf
	// Vai checar regra para todos os casos menos quando existir uma liberacao
	// O lRegras somente sera false no caso de um processo do Ptu OnLine (Meu usuario em outra operadora)
	// Isso esta no fonte plstrtptu_scs2
	// Sempre tem que entrar aqui caso nao exista uma liberacao
									if (lRegras .or. ( cOrigem == "2" .and. nQtdAut == 0 ) ) .and. cDsEvento == '0'
		
										aQtdBrow := {}	// Reinicia array.
		
										For nH := 1 To Len(aItens)
			
											__cSeqMov 	:= U_CBRETDAD(aItens[nH],"SEQMOV")
											__cCodPad 	:= U_CBRETDAD(aItens[nH],"CODPAD")+Space(TamSx3("BD6_CODPAD")[1] - Len(U_CBRETDAD(aItens[nH],"CODPAD")))
											__cCodPro 	:= U_CBRETDAD(aItens[nH],"CODPRO")+Space(TamSx3("BD6_CODPRO")[1] - Len(U_CBRETDAD(aItens[nH],"CODPRO")))
											__cDescri	:= U_CBRETDAD(aItens[nH],"DESCRI","")
											__nQtdSol 	:= U_CBRETDAD(aItens[nH],"QTD",0)
											__nQtdAut 	:= U_CBRETDAD(aItens[nH],"QTDAUT",0)
											__lAutoriz	:= U_CBRETDAD(aItens[nH],"STPROC")=="S"
											__cTpProc	:= U_CBRETDAD(aItens[nH],"TPPROC","")
											__cDente  	:= U_CBRETDAD(aItens[nH],"DENTE","")+Space(TamSx3("BD6_DENREG")[1] - Len(U_CBRETDAD(aItens[nH],"DENTE")))
											__cFace   	:= U_CBRETDAD(aItens[nH],"FACE","")
											__cSequen	:= U_CBRETDAD(aItens[nH],"SEQMOV","")
											__cStProc	:= U_CBRETDAD(aItens[nH],"STPROC","")
			
											If (__cCodPad + __cCodPro == cCodPad + cCodPro .and. __cDente + __cFace == cDente + cFace )	// Retira o registro atual da matriz que sera enviada ao PLSAUTP()
												Loop
				
											Elseif !__lAutoriz //	Se o registro atual não estiver autorizado não entra na matriz.
												Loop
				
											Endif
			
											AaDd(aQtdBrow,{	__cCodPad,__cCodPro,__nQtdSol,dDatPro,cHora,__cDente,__cFace,__cSequen})
										Next
		//se eh guia de honorario individual nao checa qtd e periodicidade
										If cTipGui == '06'
			//so checo a carencia,Idade,sexo
											aVldGen := {.f.,.f.,.t.,.f.,.t.,.t.,.f.,.f.,.f.,.f.,.f.}
										Endif
		// Se ja fez pre validacao, nao precisa rodar novamente a PLSAUTP
										If nFor <= len(aPreValid)
											aRetFun := aPreValid[nFor]
										Else
				
											If cOrigem == "1" .AND. !EMPTY(cNumLib)
							
												BE2->(dbSetOrder(6))
												If BE2->(MsSeek(xFilial("BE2") + cNumLib + cCodPad + cCodPro))
													If BE2->BE2_STATUS == "1"
														cStatItem := "1"
													Else
														cStatItem := "0"
													EndIf
												Else
													cStatItem := "0"
												EndIf
											EndIf
			
			// PLSAUTP
											aRetFun := PLSAUTP( dDatPro,;
												cHora,;
												cCodPad,;
												cCodPro,;
												If(nQtdSol==0,1,nQtdSol),;
												aDadUsr,;
												nRecBD6,;
												Iif(lTrtExe,aRdaProf,aDadRDA),;
												"1",;
												Iif(GetNewPar("MV_PLSMODA","1")=="0",.F.,.T.),;
												cCidPri,;
												lTrtUsr,;
												cLOCALExec,;
												lSolicit,;
												cOpeSol,;
												cCDPFSO,;
												cAno,;
												cMes,;
												cPadInt,;
												cPadCon,;
												cRegAte,;
												.T.,;
												cCodPRFExe,;
												nil,;
												nil,;
												cOpeExe,;
												nil,;
												cAteRN,;
												nil,nil,nil,nil,;
												lRegPagAto,;
												cTipoGrv,;
												nil,nil,nil,nil,nil,nil,;
												iif(!Empty(cRdaEDI),cRdaEDI,nil),;
												cNuLibera,;
												cAreaAbr,;
												nil,;
												nil,;
												cDente,;
												nil,;
												.f.,;
												Iif(lTratExLib, lTratExLib, (!lSolicit .Or. !empty(cCodPRFExe))),;
												.t.,;
												cTpProc,;
												cCodEspPro,;
												aQtdBrow,;
												aVldGen,;
												Iif(!Empty(cCodLocPro),cCodLocPro,cCodLoc),;
												nil,;
												nil,;
												cTpProc,;
												lWeb,;
												"BE1",;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												nil,;
												cEspSol,;
												cEspExe,;
												nil,;
												nil,;
												cTipGui,;
												cStProc,;
												nil,;
												nil,;
												nil,;
												lPtuOnline,;
												lInter,;
												@aRetAudPTU,;
												nil,;
												ALLTRIM(STR(U_CBRETDAD(aItens[1],"VLRAPR",0))),,lNovaLiberacao,;
												nil,;
												cStatItem)
										EndIf
		// Retorno
										lContinua	:= aRetFun[1]
		
										If LEN(aRetFun) > 1
											aTrb := aRetFun[2]
										EndIf
		
										If ValType(aTrb) <> "C"
											cAuditoria := iif(Ascan( aTrb,{|x| x[1] == __aCdCri051[1] } ) > 0, "1", "0")
										EndIf
		// Verifica se procedimento em auditoria se enquandra na exceção cadastrada
		// Caso esteja na exceção retira o procedimento da auditoria.
										if !empty(cAuditoria) .and. cAuditoria == "1"
			
											cTpaten:=PLSRetAut()[1]
			//B1O_CODPRO+B1O_TPGUIA+B1O_IDADE+B1O_QTDPRO
											if PLSVLDEX(Left( cCodPro + Space( TamSX3("B1O_CODPRO")[1] ), TamSX3("B1O_CODPRO")[1] )+cTpaten,aDadUsr[26],nQtdSol)
				
												If LEN(aRetFun[2]) == 2
													cAuditoria := "0"
													lImpedeAud := .T.
													lExc := .T.
													aTrb := {}
													lContinua := .T.
													aRetFun[1] := .T.
													aRetFun[2] := {}
					
												Else
													aRetFun[2][Ascan( aTrb,{|x| x[1] == "025"} )][1] := ""
												EndIf
											endif
										endif
		// Deleta criticas de abrangencia quando atendimento de Urg/Emerg. PTU Online
										if lPtuOnUr .And. lPtuOnLine .and. !lContinua
											aRegCriDel := {}
											nSizeTrb   := 0
			
											For nCrit := 1 to len(aTrb)
				// Removo as criticas de Abrangencia que nao podem ser exibidas
												If !Empty(aTrb[nCrit][1])
													If Alltrim(aTrb[nCrit][1]) $ "011/032/038/050"
														lDelCriArr := .T.
														PlsPtuLog(cCodPad+"-"+cCodPro+" -> Removendo crítica de abrangência "+aTrb[nCrit][1]+". Atendimento de Urgência/Emergência.")
													Else
														lDelCriArr := .F.
													EndIf
												EndIf
				// Marca Posicoes do Array que serao deletadas
												If lDelCriArr
													Aadd(aRegCriDel,nCrit)
												EndIf
											Next
			// Deleta posicoes marcadas do array
											If len(aRegCriDel) >0
												For nCrit := 1 to len(aRegCriDel)
													aDel(aTrb,aRegCriDel[(len(aRegCriDel)+1)-nCrit])//Deleto a partir das ultimas posicoes para nao perder o ponteiro
													nSizeTrb ++
												Next
				
												aSize(aTrb,len(aTrb)-nSizeTrb)
											EndIf
			// Se nao restou criticas, autorizo o evento
											If len(aTrb) == 0
												lContinua := .T.
											EndIf
			
										endIf
		// Verifica se o evento e de Baixo Risco, caso positivo, o mesmo nao pode ser
		// enviado para estudo.
										If lPtuOnline .and. lBaixoRisc .and. BCT->( FieldPos("BCT_ATIVBR") ) > 0
			
											lPermAudBR := .F.
			// Verifica criticas que permitem Auditoria no Baixo Risco:
			// 022 - Para este procedimento necessita Guia da Empresa.
											If !lContinua .And. len(aTrb) > 0
												For nFor2 := 1 To Len(aTrb)
													If aTrb[nFor2][1] == __aCdCri052[1]
														lPermAudBR := .T.
													EndIf
												Next
											EndIf
			
			
											If !lPermAudBR .And. !lContinua
				
												aRegCriDel := {}
												nSizeTrb   := 0
				
												For nCrit := 1 to len(aTrb)
					// BCT_ATIVBR - Verifica se exibo ou nao as criticas apresentadas no Baixo Risco
													If !Empty(aTrb[nCrit][1])
						
														aBCTArea := BCT->(GetArea())
														BCT->(DbSetOrder(1))//BCT_FILIAL + BCT_CODOPE + BCT_PROPRI + BCT_CODGLO
														If BCT->(DbSeek(xFilial("BCT")+PlsIntPad()+aTrb[nCrit][1])) .And. BCT->BCT_ATIVBR == "0"
															lDelCriArr := .T.
															PlsPtuLog(cCodPad+"-"+Alltrim(cCodPro)+" -> Crítica "+aTrb[nCrit][1]+" não será apresentada devido ao campo BCT_ATIVBR.")
														Else
															lDelCriArr := .F.
														EndIf
														RestArea(aBCTArea)
													EndIf
					// Marca Posicoes do Array que serao deletadas
													If lDelCriArr
														Aadd(aRegCriDel,nCrit)
													EndIf
												Next
				// Deleta posicoes marcadas do array
												If len(aRegCriDel) >0
													For nCrit := 1 to len(aRegCriDel)
														aDel(aTrb,aRegCriDel[(len(aRegCriDel)+1)-nCrit])//Deleto a partir das ultimas posicoes para nao perder o ponteiro
														nSizeTrb ++
													Next
					
													aSize(aTrb,len(aTrb)-nSizeTrb)
												EndIf
				// Se restou criticas, aciona o Baixo Risco
												If len(aTrb) > 0
													aRetAudPTU := {.T.,"0"}
												Else
													lContinua := .T.
												EndIf
											EndIf
			
										EndIf
		// Se for solicitacao de consulta PTU Online realizo a gravacao posteriormente
										If !lConPtuOn
			// Utiliza as criticas de cabecalho se existirem
											If lCriCab
												lContinua := .F.
												aTrb      := {}
				// Remove criticas de Baixo Risco se houver
												If lPtuOnline .And. lBaixoRisc .And. BCT->( FieldPos("BCT_ATIVBR") ) > 0
													lPermAudBR := .F.
					
													BR8->(DbSetOrder(1))//BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN
					// Verifica criticas que permitem Auditoria no Baixo Risco:
					// 022 - Para este procedimento necessita Guia da Empresa.
													If len(aCriticas) > 0
														For nFor2 := 1 To Len(aCriticas)
															If aCriticas[nFor2][1] == __aCdCri052[1]
																lPermAudBR := .T.
															EndIf
														Next
													EndIf
					// Verifica se o evento e de Baixo Risco
													If !lPermAudBR
						
														aRegCriDel := {}
														nSizeTrb   := 0
						
														For nCrit := 1 to len(aCriticas)
							// BCT_ATIVBR - Verifica se exibo ou nao as criticas apresentadas no Baixo Risco
															If !Empty(aCriticas[nCrit][2])
								
																aBCTArea := BCT->(GetArea())
																BCT->(DbSetOrder(1))//BCT_FILIAL + BCT_CODOPE + BCT_PROPRI + BCT_CODGLO
																If BCT->(DbSeek(xFilial("BCT")+PlsIntPad()+aCriticas[nCrit][2])) .And. BCT->BCT_ATIVBR == "0"
																	lDelCriArr := .T.
																	PlsPtuLog(cCodPad+"-"+cCodPro+" -> Crítica "+aCriticas[nCrit][2]+" não será apresentada devido ao campo BCT_ATIVBR.")
																Else
																	lDelCriArr := .F.
																EndIf
																RestArea(aBCTArea)
															EndIf
							// Marca Posicoes do Array que serao deletadas
															If lDelCriArr
																Aadd(aRegCriDel,nCrit)
															EndIf
														Next
						// Deleta posicoes marcadas do array
														If len(aRegCriDel) >0
															For nCrit := 1 to len(aRegCriDel)
																aDel(aCriticas,aRegCriDel[(len(aRegCriDel)+1)-nCrit])//Deleto a partir das ultimas posicoes para nao perder o ponteiro
																nSizeTrb ++
															Next
							
															aSize(aCriticas,len(aCriticas)-nSizeTrb)
														EndIf
						// Se restou criticas, aciona o Baixo Risco
														If len(aRetAudPTU) == 0
															If len(aCriticas) > 0
																aRetAudPTU := {.T.,"0"}
															Else
																lContinua := .T.
															EndIf
														EndIf
													EndIf
					
												EndIf
				
				// Se baixo risco nao posso auditar com criticas de cabecalho
												If len(aRetAudPTU) > 1 .And. aRetAudPTU[1]
													cAuditoria := "0"
													For nPoa :=1 To Len(aCriticas)
														If len(aCriticas[nPoa]) == 7
															Aadd(aCriticas[nPoa],{.T.,cAuditoria})
														EndIf
													Next
												Else //If !lConsulta -> Removido pois no Baixo Risco, a parametrizacao que define se vai ou nao para auditoria
													BCT->( DbSetOrder(1) )
													For nPoa :=1 To Len(aCriticas)
														If !Empty(aCriticas[nPoa,2])
															If BCT->( MsSeek( xFilial("BCT")+PlsIntPad()+aCriticas[nPoa,2] ) )
																cAuditoria := Iif(BCT->BCT_AUDITO == "1","1","0")
																If cAuditoria == '1'
																	exit
																Endif
															EndIf
														Endif
													NExt
												EndIf
											EndIf
			
											If LEN(aRetFun) > 1
												If lContinua .And. !lAudTodos
													U_CBPUTDAD(aItens[nFor],"NIVAUT",aRetFun[3],.T.)
													U_CBPUTDAD(aItens[nFor],"CHVNIV",aRetFun[4],.T.)
													U_CBPUTDAD(aItens[nFor],"NIVCRI","",.T.)
												Else
													U_CBPUTDAD(aItens[nFor],"NIVAUT","",.T.)
													U_CBPUTDAD(aItens[nFor],"CHVNIV",aRetFun[4],.T.)
													U_CBPUTDAD(aItens[nFor],"NIVCRI",aRetFun[3],.T.)
												Endif
											EndIf
										EndIf
		//Eu tenho que limpar as criticas pois caso isso nao seja feita o sistema
		//pode pegar a critica de um procedimento e colocar no outro
										PLLimpCCri(.T.)
									Else
		
		// Limpar outras criticas
										PLLimpCCri(.T.)
		// Valida procedimento
										aRetFun  	:= PLSVLDPTP(cCodPad,cCodPro,cLocalExec,cTipoGrv)
										lContinua	:= aRetFun[1]
										If !lContinua
											aTrb := aRetFun[2]
										EndIf
									EndIf
	// Verifica se e uma importacao A1100
									If lPtuA1100
										If cIdRespWsd == "2" //Autorizado
											AaDd(aEventosAut,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
											U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,"0",cNumImp,"1",dDatPro,aDadRda)
										Else
											BCT->(DbSetOrder(4))//BCT_FILIAL+BCT_CODOPE+BCT_CODED2
											If BCT->(DbSeek(xFilial("BCT")+PlsIntPad()+cCrRespWsd))
												cCrRespWsd := BCT->(BCT_PROPRI+BCT_CODGLO)
												cDescGlo   := BCT->BCT_DESCRI
												PLSPOSGLO(PLSINTPAD(),cCrRespWsd,BCT->BCT_DESCRI)
											Else
												cCrRespWsd := "999"
												cDescGlo   := cCrRespWsd +" - CRITICA PTU ONLINE NAO ENCONTRADA"
											EndIf
											U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,"0",cNumImp,,dDatPro,aDadRda)
											AaDd( aCriticas,{cSeqMov,cCrRespWsd,cDescGlo,"01"/*01*/,cCodPro,"",""} )
										EndIf
		// Se autorizou ou criticou
									ElseIf !lContinua
		
		//Se for solicitacao de consulta PTU Online realizo a gravacao posteriormente
										If !lConPtuOn
											BCT->( DbSetOrder(1) ) //BCT_FILIAL + BCT_CODOPE + BCT_PROPRI + BCT_CODGLO
											For nFor2 := 1 To Len(aTrb)
				
				//somente verifica no codigo da critica e nao no detalhamento.
												if !empty(aTrb[nFor2,1])
					
					//Se vai para liberacao especial
													cLibEsp := u_CBLIBESP(cFilBCT+cOpeMov+aTrb[nFor2,1],cLibEsp,cOrigem,cCodPad,cCodPro)
					
					//Se a critica coloca na auditoria
													if cAuditoria <> "1"
						
						//Ponto de entrada para indicar se o procedimento vai para auditoria PTU On
														if  lPtuOnline .And. ExistBlock("PLAUPTON")
															cAuditoria := ExecBlock("PLAUPTON",.F.,.F.,{aDadUsr,aTrb,cOpeSol,aRetAudPTU} )
															aRetAudPTU := {.T.,cAuditoria}
														else
							//Verifico se a critica dele colocar o procedimento em auditoria
															if BCT->( FieldPos("BCT_AUDITO") ) > 0
																if BCT->( MsSeek( xFilial("BCT")+PlsIntPad()+aTrb[nFor2,1] ) )
																	cAuditoria := Iif(BCT->BCT_AUDITO == "1","1","0")
																endIf
															endIf
							
							//aRetAudPTU indica se o item pode ser enviado ou nao para auditoria
							//Implementado para a regra de item com valor inferior a 6 consultas
															if len(aRetAudPTU) > 1
																cAuditoria := aRetAudPTU[2]
																lAudTodos  := .F. //Se baixo risco, nao posso enviar registros para auditoria
															endIf
							
							//Nao posso enviar o item para estudo, devo forcar a negacao
															if lNegAllIte
																if cAuditoria == "1"
																	PlsPtuLog("Utilizado o parâmetro MV_PTCRINE para nao permitir o envio de eventos para Auditoria.")
																endIf
								
																if len(aRetAudPTU) > 1
																	aRetAudPTU[2] := "0"
																else
																	cAuditoria := "0"
																	aRetAudPTU := {.T.,cAuditoria}
																endIf
															else
								//Coloca na auditoria
																if aTrb[nFor2,1] == __aCdCri051[1] .And. len(aRetAudPTU) < 2
																	cAuditoria := "1"
																endIf
								//Quando for critica de guia da empresa tb vai para auditoria ptu-online
																if lAudEmp
																	if aTrb[nFor2,1] == __aCdCri052[1] .And. len(aRetAudPTU) < 2
																		cAuditoria := "1"
																	endIf
																endIf
															endif
														endIf
													endIf
												endIf
				//Aqui eu evito de gerar demanda desnecessária na auditoria caso ocorra alguma critica absurda no portal (parametrizado no cadastro da critica), exemplo Sexo incompativel não precisa ir pra auditoria, caso o procedimento também esteja configurado pra auditar
												If BCT->(FieldPos("BCT_NAOAUD")) > 0
													If BCT->BCT_NAOAUD == "1"
														cAuditoria := "0"
														lImpedeAud := .T.
													EndIf
												EndIf
												AaDd( aCriticas,{cSeqMov,aTrb[nFor2,1],AllTrim(aTrb[nFor2,2])+Iif(Len(aTrb[nFor2])>=3 .And. !Empty(aTrb[nFor2,3]),' ( '+aTrb[nFor2,3]+' ) ',''),aTrb[nFor2,6],aTrb[nFor2,7],"","",Iif(len(aRetAudPTU) > 1,{.T.,cAuditoria},{.F.,""})} )
											Next
			// Ajusta baixo risco quando houver critica de cabecalho
											If len(aTrb) == 0 .And. lCriCab .And. len(aRetAudPTU) > 1
												cAuditoria := aRetAudPTU[2]
												lAudTodos  := .F. //Se baixo risco, nao posso enviar registros para auditoria
											EndIf
			//Aqui eu evito de gerar demanda desnecessária na auditoria caso ocorra alguma critica absurda no portal (parametrizado no cadastro da critica), exemplo Sexo incompativel não precisa ir pra auditoria, caso o procedimento também esteja configurado pra auditar
											If lImpedeAud
												cAuditoria := "0"
											EndIf
			// Matriz
											If cAuditoria == "0" .And. Len(aCriticas) > 0
												nPosNRAOPE := Ascan(aItens[nFor],{|x| x[1] == "NRAOPE"})
												If nPosNRAOPE > 0
													aItens[nFor][nPosNRAOPE] := REPLICATE ("0",10)
												Else
													Aadd(aItens[nFor],{"NRAOPE",REPLICATE ("0",10)})
												Endif
											EndIf
											U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,IIf(lAudTodos,"1",cAuditoria),cNumImp,,dDatPro,aDadRda)
			
											AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
										Else
			// Retorno para solicitacao de consulta PTU Online
											aRet := {.F.}
										EndIf
		// Se for solicitacao online com descricao de mat/met que nao esta na tabela
									ElseIf lFAudMOP .or. cDsEvento == '1'
										U_CBPUTDAD(aItens[nFor],"NIVAUT","",.T.)
										U_CBPUTDAD(aItens[nFor],"CHVNIV","",.T.)
										U_CBPUTDAD(aItens[nFor],"NIVCRI","OLN",.T.)
		
										cAuditoria := "1"
		// Verifica Critica
										PLSPOSGLO(PLSINTPAD(),__aCdCri203[1],__aCdCri203[2])
		// Critica
										nPosNRAOPE := Ascan(aItens[nFor],{|x| x[1] == "NRAOPE"})
		
										If Empty(cSenBSN)
											cSenBSN:= PLSNRAOPE()
										EndIf
										If nPosNRAOPE > 0
											aItens[nFor][nPosNRAOPE] := cSenBSN
										Else
											Aadd(aItens[nFor],{"NRAOPE",cSenBSN})
										Endif
		
										U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
		
										AaDd(aCriticas,{cSeqMov,__aCdCri203[1],PLSBCTDESC(),cCodPad,cCodPro,cDente,cFace})
										AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
		// Se for solicitacao online com data de atendimento vai pra auditoria
									ElseIf lFAudAte
										U_CBPUTDAD(aItens[nFor],"NIVAUT","",.T.)
										U_CBPUTDAD(aItens[nFor],"CHVNIV","",.T.)
										U_CBPUTDAD(aItens[nFor],"NIVCRI","OLN",.T.)
		
										cAuditoria := "1"
		// Verifica Critica
										PLSPOSGLO(PLSINTPAD(),__aCdCri106[1],__aCdCri106[2])
		// Critica
										nPosNRAOPE := Ascan(aItens[nFor],{|x| x[1] == "NRAOPE"})
		
										If Empty(cSenBSN)
											cSenBSN:= PLSNRAOPE()
										EndIf
										If nPosNRAOPE > 0
											aItens[nFor][nPosNRAOPE] := cSenBSN
										Else
											Aadd(aItens[nFor],{"NRAOPE",cSenBSN})
										Endif
										U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
		
										AaDd(aCriticas,{cSeqMov,__aCdCri106[1],PLSBCTDESC(),cCodPad,cCodPro,cDente,cFace})
										AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
		// Se for solicitacao online com msg de observacao deve ir para auditoria
									ElseIf lForcAud
										U_CBPUTDAD(aItens[nFor],"NIVAUT","",.T.)
										U_CBPUTDAD(aItens[nFor],"CHVNIV","",.T.)
										U_CBPUTDAD(aItens[nFor],"NIVCRI","OLN",.T.)
		
										cAuditoria := "1"
		// Verifica Critica
										PLSPOSGLO(PLSINTPAD(),__aCdCri202[1],__aCdCri202[2])
		// Critica
										nPosNRAOPE := Ascan(aItens[nFor],{|x| x[1] == "NRAOPE"})
		
										If Empty(cSenBSN)
											cSenBSN:= PLSNRAOPE()
										EndIf
										If nPosNRAOPE > 0
											aItens[nFor][nPosNRAOPE] := cSenBSN
										Else
											Aadd(aItens[nFor],{"NRAOPE",cSenBSN})
										Endif
		
										U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
		
										AaDd(aCriticas,{cSeqMov,__aCdCri202[1],PLSBCTDESC(),cCodPad,cCodPro,cDente,cFace})
										AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
		// Se for solicitacao online com alto custo deve ir para auditoria
									ElseIf lAutoCus
										U_CBPUTDAD(aItens[nFor],"NIVAUT","",.T.)
										U_CBPUTDAD(aItens[nFor],"CHVNIV","",.T.)
										U_CBPUTDAD(aItens[nFor],"NIVCRI","OLN",.T.)
		
										cAuditoria := "1"
		// Verifica Critica
										PLSPOSGLO(PLSINTPAD(),__aCdCri104[1],__aCdCri104[2])
		// Critica
										nPosNRAOPE := Ascan(aItens[nFor],{|x| x[1] == "NRAOPE"})
		
										If Empty(cSenBSN)
											cSenBSN:= PLSNRAOPE()
										EndIf
										If nPosNRAOPE > 0
											aItens[nFor][nPosNRAOPE] := cSenBSN
										Else
											Aadd(aItens[nFor],{"NRAOPE",cSenBSN})
										Endif
										U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
		
										AaDd(aCriticas,{cSeqMov,__aCdCri104[1],PLSBCTDESC(),cCodPad,cCodPro,cDente,cFace})
										AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
		// Se solicitacao com pacote, envia para auditoria
									ElseIf lPacAudi
										U_CBPUTDAD(aItens[nFor],"NIVAUT","",.T.)
										U_CBPUTDAD(aItens[nFor],"CHVNIV","",.T.)
										U_CBPUTDAD(aItens[nFor],"NIVCRI","OLN",.T.)
		
										cAuditoria := "1"
		// Verifica Critica
										PLSPOSGLO(PLSINTPAD(),__aCdCri200[1],__aCdCri200[2])
		// Critica
										nPosNRAOPE := Ascan(aItens[nFor],{|x| x[1] == "NRAOPE"})
		
										If Empty(cSenBSN)
											cSenBSN:= PLSNRAOPE()
										EndIf
										If nPosNRAOPE > 0
											aItens[nFor][nPosNRAOPE] := cSenBSN
										Else
											Aadd(aItens[nFor],{"NRAOPE",cSenBSN})
										Endif
										U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
		
										AaDd(aCriticas,{cSeqMov,__aCdCri200[1],PLSBCTDESC(),cCodPad,cCodPro,cDente,cFace})
										AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
		// Envia todos itens a auditoria quando um unico for marcado para auditar
									ElseIf lAudTodos
										U_CBPUTDAD(aItens[nFor],"NIVAUT","",.T.)
										U_CBPUTDAD(aItens[nFor],"CHVNIV","",.T.)
										U_CBPUTDAD(aItens[nFor],"NIVCRI","OLN",.T.)
		
										cAuditoria := "1"
		// Verifica Critica
										PLSPOSGLO(PLSINTPAD(),__aCdCri107[1],__aCdCri107[2])
		// Critica
										nPosNRAOPE := Ascan(aItens[nFor],{|x| x[1] == "NRAOPE"})
		
										If Empty(cSenBSN)
											cSenBSN:= PLSNRAOPE()
										EndIf
										If nPosNRAOPE > 0
											aItens[nFor][nPosNRAOPE] := cSenBSN
										Else
											Aadd(aItens[nFor],{"NRAOPE",cSenBSN})
										Endif
										U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
		
										AaDd(aCriticas,{cSeqMov,__aCdCri107[1],PLSBCTDESC(),cCodPad,cCodPro,cDente,cFace})
										AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
									Else
		// Se for solicitacao de consulta PTU Online realizo a gravacao posteriormente
										If !lConPtuOn
			
											If Ascan(aEventosNeg,{|x| AllTrim(x[1]+x[2]+x[3]+x[7]+x[8]) == AllTrim(cSeqMov+cCodPad+cCodPro+cDente+cFace) } ) > 0
												Loop
											EndIf
			
											If ( nPos := Ascan(aCriticas,{|x| x[2]+AllTrim(x[1]+x[4]+x[5]+x[6]+x[7]) == __aCdCri064[1]+AllTrim(cSeqMov+cCodPad+cCodPro+cDente+cFace) } )  ) > 0
				// Se gera log caixa preta
												If lWLIO
													If lLogEx
														PlsLogFil(Space(03)+"ATENÇÃO",__PLSFLOGX)
														lLogEx := .F.
													EndIf
													PlsLogFil(Space(03)+aCriticas[nPos,1]+Space(02)+aCriticas[nPos,5]+Space(06)+aCriticas[nPos,2]+Space(05)+aCriticas[nPos,3]+Space(02),__PLSFLOGX)
												EndIf
				
												nSize := Len(aCriticas)
												aDel(aCriticas,nPos)
												aSize(aCriticas,nSize-1)
											EndIf
			
											If  Len(aRetFun) > 5 .And. aRetFun[5]
												aValor := aRetFun[6]
												If aValor[1] .And. aValor[16] == "1" .And. If( Len(aValor)>=27, !aValor[27], .T. )
					
													If  Len(aCliente)==0
														If BA3->BA3_TIPOUS=="1"
															aCliente := PLBUSCACLIEN("1","1",aDadUsr)
														Else
															aCliente := PLBUSCACLIEN("2","1",aDadUsr)
														EndIf
													EndIf
					
													If (!aCliente[1]) .Or. (aValor[12]==0 .And. BR8->BR8_PODDIG<>"1")
						
														PLSPOSGLO(PLSINTPAD(),__aCdCri116[1],__aCdCri116[2])
						
														U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
						
														AaDd(aCriticas,{cSeqMov,__aCdCri116[1],PLSBCTDESC(),cCodPad,cCodPro,cDente,cFace})
														AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
														Loop
													Else
														If aScan(aDadBea,{|X| X[1] == "BEA_PAGATO"})==0
															AaDd(aDadBea,{"BEA_PAGATO","1"})
															AaDd(aDadBea,{"BEA_GUIACO","1"})
															AaDd(aDadBea,{"BEA_QUACOB","1"})
															AaDd(aDadBea,{"BEA_CODCLI",aCliente[3]})
															AaDd(aDadBea,{"BEA_LOJA",aCliente[4]})
														EndIf
						
														nPos := aScan(aDadBea,{|X| X[1] == "BEA_VALOR"})
														If nPos==0
															AaDd(aDadBea,{"BEA_VALOR",aValor[12]})
														Else
															aDadBea[nPos,2] += aValor[12]
														EndIf
														U_CBPUTDAD(aItens[nFor],"VLCOMP",aValor[12], .T. )
														lAto :=  .T.
													EndIf
												EndIf
											EndIf
			// Critica
											If GetNewPar("MV_PTUVEON","50") >= "60" .Or. PlsPtuConn()
												If lAprovLib .And. lWeb .And. !Empty(BEA->BEA_NRTROL)
													nTraiTePTU := Ascan(aItens[nFor],{|x| x[1] == "TRAITEPTU"})
													If nTraiTePTU > 0
														aItens[nFor][nTraiTePTU]:= BEA->BEA_NRTROL
													Else
														Aadd(aItens[nFor],{"TRAITEPTU",BEA->BEA_NRTROL})
													EndIf
												EndIf
				
												nPosNRAOPE := Ascan(aItens[nFor],{|x| x[1] == "NRAOPE"})
												If Empty(cSenBSN)
													cSenBSN:= PLSNRAOPE()
												EndIf
												If nPosNRAOPE > 0
													aItens[nFor][nPosNRAOPE] := cSenBSN
												Else
													Aadd(aItens[nFor],{"NRAOPE",cSenBSN})
												Endif
											EndIf
											U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,IIf(lAudTodos,"1",cAuditoria),cNumImp,'1',dDatPro,aDadRda)
			
											AaDd(aEventosAut,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
											Iif(cTpProc=='4',(nQtdDiAut += nQtdSol),Nil)
										Else
			// Retorno para solicitacao de consulta PTU Online
											aRet := {.T.}
										EndIf
									EndIf
								Next
// Retorna com o conteudo original
								If !lXMLLote
									PLLimpCCri(.F.,.T.,aOldCri)
								EndIf
								Return(aRet)

/*/{Protheus.doc} U_CBXMOVONL
Validacoes regras de usuario de intercambio para operadora online
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function CBXMOVONL(aItens,lAprovLib,lTrtUsr,lConsulta,cOrigem,cAno,cMes,dDatPro,cHora,aDadUsr,aDadRDA,cCidPri,;
									cLOCALExec,cOpeSol,cCDPFSO,cPadInt,cPadCon,cRegAte,cCodPRFExe,cOpeExe,lRegPagAto,cTipoGrv,cAreaAbr,;
									cCodEsp,cCodLoc,cFilBCT,cViaCartao,cOpeOri,cLibEsp,cCodRda,cNumImp,nQtdDiAut,nQtdDiNeg,aDadIte,;
									aCriticas,aEventosNeg,aEventosAut,aDadBEA,aDados,cOriMov,cCarSol,cIndCli,lCriTime,cTranOS,lInter,cIndAci,cAteRN,lEvolu)
								LOCAL cNrSeqTR  	:= ""
								LOCAL nPos 			:= 0
								LOCAL nI,nY			:= 0
								LOCAL nFor2,nFor	:= 0
								LOCAL nQtdSol 		:= 0
								LOCAL nQtdAut 		:= 0
								LOCAL nPerVia 		:= 0
								LOCAL cSeqMov 		:= ""
								LOCAL cCodPad 		:= ""
								LOCAL cCodPro 		:= ""
								LOCAL cTpProc 		:= ""
								LOCAL cPROCCI 		:= ""
								LOCAL cVia    		:= ""
								LOCAL cSigla  		:= ""
								LOCAL cEstCr 		:= ""
								LOCAL cNumCr 		:= ""
								LOCAL cTpTab		:= ""
								LOCAL cAuditoria	:= "0"
								LOCAL cDesOPM 		:= ""
								LOCAL cTipGui		:= ""
								LOCAL cCodCri		:= ""
								LOCAL cDesCri		:= ""
								LOCAL cTpAut		:= ""
								LOCAL cSenhaOpe 	:= ""
								LOCAL cMsg03 	  	:= ""
								LOCAL cAutori       := ""
								LOCAL aProcAux    	:= {}
								LOCAL aValor		:= {}
								LOCAL aRdas			:= {}
								LOCAL lCirurgico	:= .F.
								LOCAL lOnLine		:= .T.
								LOCAL lVeioComu		:= .F.
								LOCAL cTipUrg       := ""
								LOCAL cVerPtuOn     := GetNewPar("MV_PTUVEON","40")
								LOCAL cDecItem      := ""
								LOCAL cQtdItem      := ""
								LOCAL cDatValid     := ""
								LOCAL lTVBA0BAU		:= getNewPar("MV_PTUTIVE",.f.)
								LOCAL cTVerPTU      := PlsTissVer()
								LOCAL lPTUOn60      := GetNewPar("MV_PTUVEON","50") == "60"
								LOCAL cRegAnv		:= ""
								DEFAULT cCarSol     := ""
								DEFAULT cIndCli     := ""
								DEFAULT lCriTime    := .F.
								DEFAULT cTranOS     := Replicate("0",10)
								DEFAULT lInter      := .F.
								DEFAULT cIndAci     := "9"
								DEFAULT cAteRN      := "0"
								DEFAULT lEvolu      := .F.
// Executante
								BB0->( DbSetOrder(1) )
								If ! Empty(AllTrim(cCodPRFExe))
									If BB0->(MsSeek(xFilial("BB0")+cCodPRFExe))
										cEstCr := BB0->BB0_ESTADO
										cNumCr := BB0->BB0_NUMCR
									Endif
								Endif
// Monta a matriz de procedimentos
								For nFor := 1 To Len(aItens)
									cSeqMov := U_CBRETDAD(aItens[nFor],"SEQMOV")
									cCodPad := U_CBRETDAD(aItens[nFor],"CODPAD")
									cCodPro := U_CBRETDAD(aItens[nFor],"CODPRO")
									cDescri	:= U_CBRETDAD(aItens[nFor],"DESCRI","")
									nQtdSol := U_CBRETDAD(aItens[nFor],"QTD",0)
									nQtdAut := U_CBRETDAD(aItens[nFor],"QTDAUT",0)
									cTpProc	:= U_CBRETDAD(aItens[nFor],"TPPROC","")
									cTipEve	:= U_CBRETDAD(aItens[nFor],"TIPEVE","")
									dDatInc	:= U_CBRETDAD(aItens[nFor],"DATINC",CtoD(""))
									cDente 	:= U_CBRETDAD(aItens[nFor],"DENTE","")
									cFace  	:= U_CBRETDAD(aItens[nFor],"FACE","")
									cRegAnv	:= U_CBRETDAD(aItens[nFor],"CD_ANVISA","")
									cGuiJur	:= U_CBRETDAD(aItens[nFor],"ID_LIMINAR","")
	// Se quantidade autorizada for igual a zero pulo pois nao posso envia-lo
									If nQtdAut == 0
										Loop
									EndIf
									If lEvolu .And. cOrimov =="2" .And. Empty(cIndCli)
		
										cIndCli :=Alltrim(U_CBRETDAD(aItens[nFor],"INDCLIEVO"))
		
									EndIf
	//0=Procedimento							(0=AMB)						 		 |
	//1=Material	    						(2=Material)				 		 |
	//2=Medicamento							(3=Medicamento)				 		 |
	//3=Taxas									(1=Hospitalar)				 		 |
	//4=Diarias								(1=Hospitalar)				 		 |
	//5=Ortese/Protese							(1=Hospitalar)				 		 |
	//6=Pacote 								(1=Hospitalar)				 		 |
									cTpTab := Iif(cTpProc=='0' .Or. Empty(cTpProc),'0',Iif(cTpProc=='1','2',Iif(cTpProc=='2','3',Iif(cTpProc=='6','4','1') ) ) )
	// Vai na tde para verificar se o procedimento ja foi informado para unimed brasil	  |
	// Somente se for ortese/protese ou material								 		  |
									If cTpProc $ '5,1,2,6' .And. Empty(dDatInc )
		// Descricao do procedimento nao enviar para pacote						 |
										cDesOPM := Left(cDescri,80)
										cSigla  := GETNEWPAR("MV_PLSIGLA","CRM")
		// Se uma consulta ou exame											 	 |
										If lConsulta
											cTipGui := "01"
										Else
											cTipGui := "02"
										EndIf
		// Monta matriz rdas														 |
										aRdas := PLS720IBD7("0",0,cCodPad,cCodPro,"",cOpeSol,cCodRda,cNumCr,cSigla,cEstCr,cCodPRFExe,;
											cCodEsp,cCodLoc,"3",cSeqMov,cOriMov,cTipGui)
		// Se e cirurgico ou nao 1=Clinico;2=Cirurgico;3=Ambos						 |
										cPROCCI 	:= Iif(cTipEve$"2,3","1","0")
										lCirurgico  := (cPROCCI == "1")
										cVia    	:= Iif(cPROCCI=="1",GetNewPar("MV_PLSVAPR","0"),"")
										nPerVia 	:= Iif(cPROCCI=="1",100,0)
		// Calcula o valor do procedimento										     |
										aValor := PLSCALCEVE(cCodPad,cCodPro,cMes,cAno,PlsIntPad(),cCodRda,cCodEsp,Iif(Len(aDadRDA)>0,aDadRda[21],""),cCodLoc,nQtdSol,;
											dDatPro,aDadUsr[48],cPadInt,cRegAte,0,aDadUsr,cPadCon,;
											{},Nil,Nil,Nil,Nil,cHora,aRdas,Nil,Nil,Nil,{},Nil,dDatPro,cHora,{},cTipGui,.F.,0,{},Nil,;
											lCirurgico,nPerVia,"","",nQtdSol,0)
		// Verifica se consegue pegar o valor do procedimento					     |
										For nI := 1 To Len(aValor[1])
											If !Empty(aValor[1][nI][4])
												AaDd(aCriticas,{cSeqMov,aValor[1][nI][4],AllTrim(cCodPro)+"-> ( " + AllTrim(aValor[1][nI][4]) + " )","",""})
												lOnLine := .F.
											Endif
										Next
									EndIf
	// Monta matriz															 |
									AaDd( aProcAux,{} )
	
									PlsPtuPut("TP_TABELA"	,cTpTab	,aProcAux[Len(aProcAux)])			   	//Identifica o Tipo de Tabela utilizado no Servico Medico.
									PlsPtuPut("CD_SERVICO"	,cCodPro,aProcAux[Len(aProcAux)])	   	 		//Codigo do Servico.
	
									If cVerPtuOn >= "60"
										PlsPtuPut("QT_SERVICO"	,cValToChar(nQtdSol),aProcAux[Len(aProcAux)])	//Quantidade de um procedimento mÚdico solicitado.
									ElseIf cVerPtuOn >= "50"
										cDecItem := cValToChar(nQtdSol - Int(nQtdSol))
										cDecItem := Padr(Substr(cDecItem,3,len(cDecItem)),4,"0")
										cQtdItem := Strzero(int(nQtdSol),4)+cDecItem
										PlsPtuPut("QT_SERVICO"	,cQtdItem,aProcAux[Len(aProcAux)])	//Quantidade de um procedimento mÚdico solicitado.
									Else
										PlsPtuPut("QT_SERVICO"	,StrZero(nQtdSol,8),aProcAux[Len(aProcAux)])	//Quantidade de um procedimento mÚdico solicitado.
									EndIf
	
									PlsPtuPut("CODPAD"	    ,cCodPad,aProcAux[Len(aProcAux)])	   	 		//CodPad para ponto de entrada PLPTUITE
	// Campos PTU Online versao 5.0											 |
									If cVerPtuOn >= "50"
										PlsPtuPut("TP_ANEXO","9",aProcAux[Len(aProcAux)])//Anexo nao habilitado ainda para o Portal do Prestador
										PlsPtuPut("QT_FREQUEN","00",aProcAux[Len(aProcAux)])
									EndIf
	// Informar que o procedimento ainda nao foi cadastrado na unimed brasil  	 |
									If !Empty(cDesOPM)
		// Alimenta a matriz obs. descricao somente para diferente de pacote		 |
										If cTpTab <> '4'
											PlsPtuPut("DS_OPME",cDesOPM,aProcAux[Len(aProcAux)])	    						   				//Descricao do procedimento de ortese/protese e material
										EndIf
										PlsPtuPut("VL_SERVICO" ,StrTran(StrZero(noRound(aValor[2],2),15,2),".",""),aProcAux[Len(aProcAux)])	//Valor do procedimento
									EndIf
									If lEvolu .And. cVerPtuOn >= "50" .And. cOrimov =="2"
										PlsPtuPut("DS_IND_CLI"	,cIndCli,aProcAux[Len(aProcAux)])	   	 		//Indicacao clinica da prorrogacao
									EndIf
									PlsPtuPut("SQ_ITEM", StrZero(nFor,2), aProcAux[Len(aProcAux)])
									PlsPtuPut("CD_ANVISA", cRegAnv, aProcAux[Len(aProcAux)])
									PlsPtuPut("ID_PACOTE","N",aProcAux[Len(aProcAux)])
								Next
// Mesmo padrao plsxmov desta forma o pos e web poderao usar				 |
								PlsPtuPut("VIACAR",StrZero(Val(cViaCartao),2),aDados)
// Altera para trasancao Ptu Online                        				 |
								nPos := Ascan(aDados,{|x| x[1] == "TP_CLIENTE"})
								If nPos > 0
									aDados[nPos][2] := "UNIMED"
								EndIf

// Consulta ou Exame														 |
								If lConsulta
									PlsPtuPut("TP_ATENDIM","0",aDados)  //Nao se aplica
								Else
									PlsPtuPut("TP_ATENDIM","1",aDados)  //Atendimento Ambulatorial
								EndIf

								If cGuiJur == 'N'
									PlsPtuPut("ID_LIMINAR","0",aDados)
								Else
									PlsPtuPut("ID_LIMINAR","1",aDados)
								EndIf

// Indicador de Urgencia/Emergencia - S=Sim/N=Nao						     |
								If FindFunction('PGetTisVer') .and. PGetTisVer() >= '3'
									cTipUrg := alltrim(PLSVARVINC("23","BDR",GetNewPar("MV_PLURGTS","2") ) )
									IIF(Alltrim(cCarSol) == cTipUrg,PlsPtuPut("ID_URG_EME","S",aDados),PlsPtuPut("ID_URG_EME","N",aDados))	//Indicador de Urgencia
								Else
									IIF(Alltrim(cCarSol) == "U",PlsPtuPut("ID_URG_EME","S",aDados),PlsPtuPut("ID_URG_EME","N",aDados))	//Indicador de Urgencia
								EndIf
// Remove quebra de linha da indicacao clinica    						     |
								cIndCli := StrTran(cIndCli,Chr(13)+Chr(10),Space(1))
								cIndCli := StrTran(cIndCli,Chr(10),Space(1))
// Genericos																 |
								PlsPtuPut("CTIPREQ","0",aDados)
								PlsPtuPut("OPEMOV",PlsIntPad(),aDados)
								PlsPtuPut("USUARIO",Subs(aDadUsr[3],Iif(Len(aDadUsr[3])=16,4,5)),aDados)
								PlsPtuPut("CIDPRI",cCidPri,aDados)
								PlsPtuPut("CODESP",cCodEsp,aDados)
								PlsPtuPut("DS_IND_CLI",cIndCli,aDados)
// Usadas na transacao diretamente											 |
								PlsPtuPut("CD_UNI_DES",cOpeOri,aDados)										//Codigo da Unimed Destino da transacao.
								PlsPtuPut("CUNIDOM",cOpeOri,aDados)							 			    //Para qual operadora enviar
								PlsPtuPut("CD_UNI",cOpeOri,aDados)										    //Codigo da Unimed
								If Len(aDadRDA) > 0
									PlsPtuPut("ID_ALTO_CU",IiF(aDadRda[30]=="1","1","3"),aDados)			//Identifica se prestador da transacao de Alto Custo
									PlsPtuPut("NM_PRESTAD",Pad(aDadRda[6],25),aDados)						//Nome do prestador de Alto Custo.
									PlsPtuPut("CD_UNI_PRE",PlsIntPad(),aDados)                             //Codigo da Unimed do Prestador do Servico.
									PlsPtuPut("CD_PREST",Padl(aDadRda[2],8,"0"),aDados)                    //Codigo do Prestador
								EndIf
								If !lEvolu
									PlsPtuPut("CD_TRANS","00600",aDados)			    //Codigo da Transacao
								Else
									PlsPtuPut("CD_TRANS","00605",aDados)							//Envio de Complemento
									PlsPtuPut("NR_TRANS_R",BEA->BEA_NRTROL,aDados)            //Transacao original
								EndIf
// Campos da versao 50 do PTU Online
								If cVerPtuOn >= "50"
	
									PlsPtuPut("ID_RN",IIF(cAteRN=="1","S","N"),aDados)                                                   //21 ID_RN Indica se o beneficiário é recém-nato
	
									If cIndAci == "0"
										PlsPtuPut("ID_ACIDENT","1",aDados)                                              //23 Indicador de Acidente
									ElseIf cIndAci == "1"
										PlsPtuPut("ID_ACIDENT","2",aDados)                                              //23 Indicador de Acidente
									ElseIf cIndAci == "2"
										PlsPtuPut("ID_ACIDENT","3",aDados)                                              //23 Indicador de Acidente
									Else
										PlsPtuPut("ID_ACIDENT","9",aDados)                                              //23 Indicador de Acidente
									EndIf
									PlsPtuPut("CD_UNI_ATE",PlsIntPad(),aDados) 										//27 CD_UNI_ATEND - Código da Unimed na qual o Beneficiário será atendido
									PlsPtuPut("ID_ANEXO","N",aDados)                                                //28 ID_ANEXO - Indica a existência de um anexo na transação
									PlsPtuPut("TP_SEXO",IIF(aDadUsr[25]=="2","3","1"),aDados) 						//29 TP_SEXO - Sexo do Beneficiário
									PlsPtuPut("NR_IDADE",Strzero(aDadusr[27],3),aDados) 							//30 NR_IDADE - Idade do Beneficiário
	
									if lTVBA0BAU
										BA0->(dbSetOrder(1))
										if BA0->(FieldPos("BA0_TISVER")) > 0 .and. BA0->( dbSeek(xFilial("BA0")+PLSIntPad() ) )
											if !empty(BA0->BA0_TISVER)
												cTVerPTU := allTrim(BA0->BA0_TISVER)
											endIf
										endIf
									endIf
	
									PlsPtuPut("NR_VER_TIS",cTVerPTU,aDados)		 //34 NR_VER_TISS  - Número de versão da TISS que o prestador enviou a transação
	
									If lInter
										PlsPtuPut("DT_SUG_INT",DtoS(dDataBase),aDados)
										Do Case
										Case cGrpInt == "1" //1 = Internação Clínica
											PlsPtuPut("TP_INTERNA","1",aDados)
										Case cGrpInt  == "2" //2 = Internação Cirúrgica
											PlsPtuPut("TP_INTERNA","2",aDados)
										Case cGrpInt == "3" //3 = Internação Obstétrica
											PlsPtuPut("TP_INTERNA","3",aDados)
										Case cGrpInt == "4" //6 = Internação Pediátrica
											PlsPtuPut("TP_INTERNA","6",aDados)
										Case cGrpInt == "5" //7 = Internação Psiquiátrica
											PlsPtuPut("TP_INTERNA","7",aDados)
										EndCase
									EndIf
	
									If !Empty(cTranOS)
										PlsPtuPut("ID_ORDEM_S","S",aDados)										    //32 ID_ORDEM_SERVICO - Indica se o pedido de autorização foi gerado através de uma comunicação de Ordem de Serviço
										PlsPtuPut("NR_IDE_OS",cTranOS,aDados)								     	//33 NR_IDENT_OS - Número da Transação da Ordem de Serviço
									Else
										PlsPtuPut("ID_ORDEM_S","N",aDados)											//32 ID_ORDEM_SERVICO - Indica se o pedido de autorização foi gerado através de uma comunicação de Ordem de Serviço
										PlsPtuPut("NR_IDE_OS",Replicate("0",10),aDados)								//33 NR_IDENT_OS - Número da Transação da Ordem de Serviço
									EndIf
								EndIf

								If lPTUOn60
									BAU->(dbSetOrder(1))
									BAU->(dbSeek(xFilial('BAU') + cCodRda ))
	
									PlsPtuPut("TIPO_REDE_MIN", BAU->BAU_TIPRED, aDados)
									PlsPtuPut("CD_IBGE", BAU->BAU_MUN, aDados)
									PlsPtuPut("ID_LIMINAR", "N", aDados)
								Endif

// Tratamento para retorno da solicitacao
								aRet := PLSANAINT(aDados,aProcAux,IIF(lEvolu,"BE4",))
// Retorna o TP_CLIENTE para o padrao WEB                                   |
								nPos := Ascan(aDados,{|x| x[1] == "TP_CLIENTE"})
								If nPos > 0
									aDados[nPos][2] := "WEB"
								EndIf
// Checa o retorno
								If ValType( aRet[1,2] ) == 'A'
	// Retorno																     |
									cAutori   := aRet[1,1]
									cNrSeqTR  := aRet[1,4]
									cSenhaOpe := aRet[1,5]
									cMsg03 	  := aRet[1,6]
									cDatValid := aRet[1,8]
									lVeioComu := .T.
	// For dos procedimentos													 |
									For nFor2 := 1 To Len(aItens)
										cSeqMov 	:= U_CBRETDAD(aItens[nFor2],"SEQMOV")
										cCodPad 	:= U_CBRETDAD(aItens[nFor2],"CODPAD")
										cCodPro 	:= U_CBRETDAD(aItens[nFor2],"CODPRO")
										cDescri		:= U_CBRETDAD(aItens[nFor2],"DESCRI","")
										nQtdSol 	:= U_CBRETDAD(aItens[nFor2],"QTD",0)
										nQtdAut 	:= U_CBRETDAD(aItens[nFor2],"QTDAUT",0)
										cTpProc		:= U_CBRETDAD(aItens[nFor2],"TPPROC","")
										cDente  	:= U_CBRETDAD(aItens[nFor2],"DENTE","")
										cFace   	:= U_CBRETDAD(aItens[nFor2],"FACE","")
										cSlvPad 	:= U_CBRETDAD(aItens[nFor2],"SLVPAD","")
										cSlvPro 	:= U_CBRETDAD(aItens[nFor2],"SLVPRO","")
										If lEvolu
											PlsPtuPut("TRAITEPTU",cNrSeqTR,aItens[nFor2])
											PlsPtuPut("NRAOPE",cSenhaOpe,aItens[nFor2])
										EndIf
		// Se quantidade autorizada for igual a zero pulo pois nao posso envia-lo
										If nQtdAut == 0
											Loop
										EndIf
		// Pega a posicao do acos de procedimentos	( 11 e comunicado e auditoria)   |
										For nI := 1 To Len(aRet[1,2])
											nPos := Ascan( aRet[1,2,nI] , { |x| AllTrim(x[2]) == AllTrim(cCodPro) } )
											If nPos > 0 .And. AllTrim(aRet[1,2,nI,nPos,2]) == AllTrim(cCodPro)
												nPos := nI
												Exit
											EndIf
										Next
		// Se nao encontrar o procedimento erro no retorno						     |
										If nPos <> 0
											cAuditoria := "0"
			// Atualizado																 |
											cTpAut := PlsPtuGet("ID_AUTORIZ",aRet[1,2,nPos])
			// Atualiza o procedimento												     |
											If cTpAut == "2"
				// Um autorizado finaliza a tranzacao
												If (nPos := Ascan(aDadBEA,{|x| x[1] == "BEA_TRACON"})) == 0
													AaDd(aDadBEA,{"BEA_TRACON","1"})
												Else
													aDadBEA[nPos,2] := "1"
												Endif
												If !lEvolu
													PlsPtuPut("TRAITEPTU",cNrSeqTR,aItens[nFor2])
													PlsPtuPut("NRAOPE",cSenhaOpe,aItens[nFor2])
												EndIf
				
												U_CBDADITE(aDadIte,aItens[nFor2],cOrigem,cLibEsp,cAuditoria,cNumImp,"1",dDatPro,aDadRda)
				
												AaDd(aEventosAut,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
				
												Iif(cTpProc=='4',nQtdDiAut++,Nil)
											Else
				// Pega a posicao do acols de criticas									     |
												For nY := 1 To 5
													cCodCri := ""
					// Caso exista criticas											  	     |
													If Val(PlsPtuGet("CD_MENS_E"+AllTrim(Str(nY)),aRet[1,2,nPos]) ) > 0
						// Posiciona Time-Out    											  	     |
														PLSPOSGLO(PLSINTPAD(),__aCdCri065[1],__aCdCri065[2])
						// Verifica se e critica de time-out								  	     |
														If Alltrim(PlsPtuGet("CD_MENS_E"+AllTrim(Str(nY)),aRet[1,2,nY])) == __aCdCri065[1]
															cCodCri  := __aCdCri065[1]
															cDesCri  := PLSBCTDESC()
															lCriTime := .T.
														ElseIf Alltrim(PlsPtuGet("CD_MENS_E"+AllTrim(Str(nY)),aRet[1,2,nY])) == __aCdCri228[1]
															PLSPOSGLO(PLSINTPAD(),__aCdCri228[1],__aCdCri228[2])
															cCodCri := __aCdCri228[1]
															cDesCri := PLSBCTDESC()
															lCriTime  := .T.
														Else
							// Pega o codigo da critica 												 |
															cCodCri := PlsRtcdCed(PlsIntPad(),PlsPtuGet("CD_MENS_E"+AllTrim(Str(nY)),aRet[1,2,nPos]),4)
															If Empty(cCodCri)
																If PLSPOSGLO(PLSINTPAD(),__aCdCri102[1],__aCdCri102[2],cLocalExec,,cTipoGrv)
																	cCodCri := __aCdCri102[1]
																	cDesCri := PLSBCTDESC()
																EndIf
															Else
																cDesCri := PlsRtcdCed(PlsIntPad(),PlsPtuGet("CD_MENS_E"+AllTrim(Str(nY)),aRet[1,2,nPos]),3)
															EndIf
														EndIf
													Else
														If cTpAut == "3"
															If PLSPOSGLO(PLSINTPAD(),__aCdCri052[1],__aCdCri052[2],cLocalExec,,cTipoGrv)
																cCodCri := __aCdCri052[1]
																cDesCri := PLSBCTDESC()
															EndIf
														ElseIf cTpAut == "4"
															If PLSPOSGLO(PLSINTPAD(),__aCdCri051[1],__aCdCri051[2],cLocalExec,,cTipoGrv)
																cCodCri := __aCdCri051[1]
																cDesCri := PLSBCTDESC()
															EndIf
														EndIf
						// Marca como auditoria													 |
														If cTpAut $ "3,4"
															cAuditoria := "1"
														EndIf
														Exit
													EndIf
					// Atualiza																 |
													AaDd(aCriticas,{cSeqMov,cCodCri,cDesCri,"",""})
												Next
												PlsPtuPut("TRAITEPTU",cNrSeqTR,aItens[nFor2])
												PlsPtuPut("NRAOPE",REPLICATE("0",10),aItens[nFor2])
				
												U_CBDADITE(aDadIte,aItens[nFor2],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
				
												AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
				
												Iif(cTpProc=='4',(nQtdDiNeg += nQtdSol),Nil)
				
											EndIf
										Else
											AaDd(aCriticas,{cSeqMov,"000","Procedimento nao encontrado no retorno -> "+cCodPro,"",""})
										EndIf
									Next
								Else
	
									lOnLine := .F.
	
									If Type("aRet[1][3][1][1]") == "C" .And. ! Empty(aRet[1][3][1][1])
		
										For nFor2 := 1 To Len(aItens)
			
											cSeqMov 	:= U_CBRETDAD(aItens[nFor2],"SEQMOV")
											cCodPad 	:= U_CBRETDAD(aItens[nFor2],"CODPAD")
											cCodPro 	:= U_CBRETDAD(aItens[nFor2],"CODPRO")
											cDescri		:= U_CBRETDAD(aItens[nFor2],"DESCRI","")
											nQtdSol 	:= U_CBRETDAD(aItens[nFor2],"QTD",0)
											nQtdAut 	:= U_CBRETDAD(aItens[nFor2],"QTDAUT",0)
											cTpProc		:= U_CBRETDAD(aItens[nFor2],"TPPROC","")
											cDente  	:= U_CBRETDAD(aItens[nFor2],"DENTE","")
											cFace   	:= U_CBRETDAD(aItens[nFor2],"FACE","")
											cSlvPad 	:= U_CBRETDAD(aItens[nFor2],"SLVPAD","")
											cSlvPro	 	:= U_CBRETDAD(aItens[nFor2],"SLVPRO","")
											AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,cDente,cFace,"",cSlvPad,cSlvPro})
			// Se foi um time-out, gravo a guia para posterior consulta e reenvio
											If aRet[1][3][1][1] == __aCdCri065[1] .And. len(aRet[1]) > 6
												cNrSeqTR  := aRet[1,7]
												U_CBDADITE(aDadIte,aItens[nFor2],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
											EndIf
										Next nFor2
		
										AaDd(aCriticas,{cSeqMov,aRet[1][3][1][1],aRet[1][3][1][2],"","","",""})
		
									EndIf
	
								EndIf

								Return( { lOnLine,cNrSeqTR,cSenhaOpe,cMsg03,lVeioComu,cAutori,aRet,cDatValid } )

/*/{Protheus.doc} u_CBLIBESP
Se vai para liberacao especial
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function CBLIBESP(cChave,cLibEsp,cOrigem,cCodPad,cCodPro)
								DEFAULT cCodPad := ''
								DEFAULT cCodPro := ''

								BCT->( DbSetOrder(1) )
								BCT->( MsSeek(cChave) )
// Verifica procedimento
								If !Empty(AllTrim(cCodPad+cCodPro))
									BR8->( DbSetOrder(1) ) //BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN
									BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) )
								EndIf
// Verifica critia e se o procedimento envia para libera especial
								If cOrigem == "2" .And. cLibEsp <> "1" .And. BCT->( Found() ) .And. BR8->BR8_LIBESP == "1" .And. BCT->BCT_LIBESP == "1"
									cLibEsp := "1"
								Endif
								Return(cLibEsp)

/*/{Protheus.doc} u_CBFINDESP
// - Acha a especialidade e o local
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function CBFINDESP(cOpeMov,cCodRda,cCodLoc,cCodEsp,dDatPro,aDadUsr,cCodPad,cCodPro,lLoadRda,lProf,lRdaProf,lSolicit)
								LOCAL aRetFun 	:= {.T.,{}}
								LOCAL cLocal  	:= ""
								LOCAL cEspAux	:= ""
								LOCAL cDesLoc	:= ""
								LOCAL lTrtPro	:= .F.
								LOCAL lFirst	:= .T.
								LOCAL lFiltPRF  := GetNewPar("MV_PLSPRFS",.T.)
								DEFAULT lProf	:= .F.
								DEFAULT lRdaProf:= .F.
// Tratamento
								BB8->( DbSetOrder(1) )
								If Empty(cCodLoc)
									If BB8->( MsSeek(xFilial("BB8")+cCodRda+cOpeMov) )
										While !BB8->( Eof() ) .And. BB8->(BB8_FILIAL+BB8_CODIGO+BB8_CODINT) == xFilial("BB8")+cCodRda+cOpeMov
			
											cLocal   := BB8->BB8_LOCAL
											cCodLoc  := BB8->BB8_CODLOC
											cDesLoc  := BB8->BB8_DESLOC
			// "1" Checar executante "0" Nao checar executante e sim na especialidade da RDA da guia
			// lProf = .T. Estou tratando a rda do profissional
											If !lProf
				// Igual porque na solicitacao sempre tenho que checar o solicitante
												lTrtPro := (lSolicit .And. lRdaProf)
				// Nao verifico o executante na solicitacao
												If !lSolicit
													lTrtPro := Iif(BB8->BB8_TRTEXE=='1',.T.,.F.)
												EndIf
				// Se contratado diferente de executante e a especialidade for do executante e nao existir
				// no contratado e for para considerar o executante zera a especialidade
												If lFirst
													If !Empty(cCodEsp) .And. lTrtPro .And. lRdaProf
														cEspAux := cCodEsp
														u_CBCHKER(cOpeMov+cCodEsp+cCodRda,@cCodEsp)
														If lWLIO .And. Empty(cCodEsp)
															PlsLogFil(Space(03)+"ESPECIALIDADE NAO ENCONTRADA NO CONTRATADO ["+cEspAux+"]" ,__PLSFLOGX)
															PlsLogFil("",__PLSFLOGX)
														EndIf
													EndIf
													lFirst := .F.
												EndIf
											EndIf
			// Valida a Rda
											aRetFun := PLSDADRDA(cOpeMov,cCodRda,"1",dDatPro,cCodLoc,cCodEsp,cCodPad,cCodPro,,(lTrtPro .Or. lLoadRda))
			
											If aRetFun[1]
				// Se gera log caixa preta
												If lWLIO
													PlsLogFil(Space(03)+"LOCAL ENCONTRADO ["+cLocal+"."+cCodLoc+"] - ( "+Iif(lProf,"PROFISSIONAL","RDA")+" )",__PLSFLOGX)
												EndIf
												Exit
											EndIf
											BB8->( DbSkip() )
										EndDo
		// Verifica se vai mostrar as criticas ou nao
										If lTrtPro .And. lRdaProf
											aRetFun := {.T.,{}}
										EndIf
									EndIf
								Else
									BB8->( MsSeek(xFilial("BB8")+cCodRda+cOpeMov+cCodLoc) )
									cLocal  := BB8->BB8_LOCAL
									cDesLoc := BB8->BB8_DESLOC
	// "1" Checar executante "0" Nao checar executante e sim na especialidade da RDA da guia
	// lProf = .T. Estou tratando a rda do profissional
									If !lProf
		// Igualo porque na solicitacao sempre tenho que checar o solicitante
										If  lFiltPRF
											lTrtPro := (lSolicit .And. lRdaProf)
										Endif
		// Nao verifico o executante na solicitacao
										If !lSolicit
											lTrtPro  := Iif(BB8->BB8_TRTEXE=='1',.T.,.F.)
										EndIf
		// Se contratado diferente de executante e a especialidade for do executante e nao existir
		// no contratado e for para considerar o executante zera a especialidade
										If !Empty(cCodEsp) .And. lTrtPro .And. lRdaProf
											cEspAux := cCodEsp
											u_CBCHKER(cOpeMov+cCodEsp+cCodRda,@cCodEsp)
											If Empty(cCodEsp) .And. lWLIO
												PlsLogFil(Space(03)+"ESPECIALIDADE NAO ENCONTRADA NO CONTRATADO ["+cEspAux+"]" ,__PLSFLOGX)
												PlsLogFil("",__PLSFLOGX)
											EndIf
										EndIf
									EndIf
	// Valida a Rda
									aRetFun := PLSDADRDA(cOpeMov,cCodRda,"1",dDatPro,cCodLoc,cCodEsp,cCodPad,cCodPro,,(lTrtPro .Or. lLoadRda))
	
									If aRetFun[1] .And. lWLIO
										PlsLogFil(Space(03)+"LOCAL UTILIZADO ["+cLocal+"."+cCodLoc+"] - ( "+Iif(lProf,"PROFISSIONAL","RDA")+" ) ",__PLSFLOGX)
										PlsLogFil("",__PLSFLOGX)
									ElseIf ( lTrtPro .And. lRdaProf )
										aRetFun := {.T.,{}}
									EndIf
								EndIf
// Conforme a especialidade valida parametrizacao do tipo de rede de atendimento e produto.
								if aRetFun[1]
									aRetFun := PLSVLDRDA()
								endIf
								Return( { cCodEsp,cLocal,cCodLoc,cDesLoc,lTrtPro,aRetFun} )

/*/{Protheus.doc} u_CBDIAQTD
Validacao da rede de atendimento
@type function
@author Roberto Arruda
@since 17.09.16
@version 1.0
/*/
							User Function CBDIAQTD(aItens, aCriticas,aEventosNeg, cOrigem, cLibEsp, cNumImp, dDatPro, aDadRda, aDadIte, nQtdDiSol)
								Local lContinua := .T.
								Local aCodCri   := {}
								Local aTrb 	    := {}
								Local cCodPad		:= ""// := U_CBRETDAD(aItens[1],"CODPAD")
								Local cCodPro		:= ""// := U_CBRETDAD(aItens[1],"CODPRO")
								Local nFor			:= 0

								Local nMaiorQtdDiaria := 0
								Local cCodPadMaior	:= ""
								Local cCodProMaior	:= ""
								Local lCrit585		:= .F.
								Local nSS				:= 1
								Local aRetFun := {}
								Default nQtdDiSol := 0
								Default aItens := {}

//Procurando item com maior diária configurada na BR8
								For nFor := 1 To Len(aItens)
									cCodPad := U_CBRETDAD(aItens[nFor],"CODPAD")
									cCodPro := U_CBRETDAD(aItens[nFor],"CODPRO")
	
									BR8->(DbSetOrder(1))
									If BR8->( MsSeek( xFilial("BR8")+cCodPad+cCodPro))
										If !Empty(BR8->BR8_QTDDIA)
											lCrit585 := .T.
											if Val(BR8->BR8_QTDDIA) > nMaiorQtdDiaria
												cCodPadMaior := cCodPad
												cCodProMaior := cCodPro
												nMaiorQtdDiaria := Val(BR8->BR8_QTDDIA)
				
											endif
										EndIf
									endif
								Next

								if nQtdDiSol > nMaiorQtdDiaria .And. lCrit585
									if PLSPOSGLO(PLSINTPAD(),__aCdCri585[1],__aCdCri585[2])
										aadd(aCodCri,{__aCdCri585[1],PLSBCTDESC(),""/*Subs(cCodInt,1,ntCodOpe)*/,BCT->BCT_NIVEL,BCT->BCT_TIPO,cCodPad,cCodPro})
										aRetFun := {.F.,aCodCri}
									endif
	
	// Verifica resultado da checagem
									If Len(aRetFun) > 0
		
										lContinua  := aRetFun[1]
										aTrb 	   := aRetFun[2]
		
										If !lContinua
											for nSS := 1 To Len(aItens)
												U_CBDADITE(aDadIte,aItens[nSS],cOrigem,cLibEsp,"1",cNumImp,,dDatPro,aDadRda)
											next
											U_CBMONCRI(aItens,aTrb,.T.,,,,@aCriticas,@aEventosNeg)
			
			//PLSPOSGLO(PLSINTPAD(),__aCdCri171[1],__aCdCri171[2])
			//U_CBMONCRI(aItens,{},.F.,__aCdCri171[1],PLSBCTDESC(),,aCriticas,aEventosNeg)
										EndIf
									EndIf
								endif

								Return(lContinua)

/*/{Protheus.doc} u_CBREDATE
Validacao da rede de atendimento
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function CBREDATE(cOpeMov,cCodRda,cCodRdaPro,cCodLoc,cCodLocPro,cCodEsp,cCodEspPro,dDatPro,;
									aItens,aDadIte,aCriticas,aEventosNeg,aDadUsr,;
									cLibEsp,cAuditoria,cOrigem,cNumImp,lLoadRda,lRdaProf,lIncNeg)
								LOCAL lContinua := .T.
								LOCAL nRecBAU	:= 0
								LOCAL nFor		:= 0
								LOCAL cLocal  	:= ""
								LOCAL cDesLoc 	:= ""
								LOCAL cDesLocPro:= ""
								LOCAL aTrb		:= {}
								LOCAL aDadRDA	:= {}
								LOCAL aRdaProf	:= {}
								LOCAL aRetFun 	:= {}
								LOCAL lTrtPro	:= .F.
								LOCAL lSolicit	:= (cOrigem == "2")
// Caso seja solicitacao e a Rda do Solicitante eh diferente do contratado
								If lRdaProf .And. lWLIO
									PlsLogFil("",__PLSFLOGX)
									PlsLogFil(Space(03)+"RDA DO CONTRATADO ["+cCodRda+"] RDA DO PROFISSIONAL ["+cCodRdaPro+"]" ,__PLSFLOGX)
									PlsLogFil("",__PLSFLOGX)
								EndIf
// Local de Atendimento (Contratado) x Especialidade do Profissional
								aRetFun 	:= u_CBFINDESP(cOpeMov,cCodRda,cCodLoc,cCodEsp,dDatPro,aDadUsr,"","",lLoadRda,.F.,lRdaProf,lSolicit)
								cCodEsp		:= aRetFun[1]
								cLocal  	:= aRetFun[2]
								cCodLoc 	:= aRetFun[3]
								cDesLoc 	:= aRetFun[4]
								lTrtPro		:= aRetFun[5]
								aRetFun 	:= aClone(aRetFun[6])
// Verifica resultado da checagem
								If Len(aRetFun) > 0
									lContinua  := aRetFun[1]
									aTrb 	   := aRetFun[2]
									If !lContinua
										U_CBMONCRI(aItens,aTrb,.T.,,,,aCriticas,aEventosNeg)
									Else
										nRecBAU	:= BAU->( Recno() )
									EndIf
								Else
									lContinua  := .F.
								EndIf
// lIncNeg, lLoadRda, e nao validou a rda
								If lIncNeg .And. lLoadRda .And. !lContinua
									lContinua := .T.
									For nFor := 1 To Len(aItens)
										U_CBDADITE(aDadIte,aItens[nFor],cOrigem,cLibEsp,cAuditoria,cNumImp,,dDatPro,aDadRda)
									Next
								EndIf
// Dados da rda, especialidade
								If lContinua
									aDadRDA  := PLSGETRDA()
									If Len(aDadRDA) == 0
		// Se gera log caixa preta
										If lWLIO
											PlsLogFil(Space(03)+"aDadRDA esta vazia" ,__PLSFLOGX)
											PlsLogFil(Space(03)+"Operadora"+Space(15-Len("Operadora"))+"["+cOpeMov+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"Rda"+Space(15-Len("Rda"))+"["+cCodRDA+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"DatPro"+Space(15-Len("DatPro"))+"["+DToS(dDatPro)+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"Matricula"+Space(15-Len("Matricula"))+"["+aDadUsr[2]+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"Local"+Space(15-Len("Local"))+"["+cLocal+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"CodLoc"+Space(15-Len("CodLoc"))+"["+cCodLoc+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"CodEsp"+Space(15-Len("CodEsp"))+"["+cCodEsp+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"CodEspPro"+Space(15-Len("CodEspPro"))+"["+cCodEspPro+"]",__PLSFLOGX)
										EndIf
										lContinua := .F.
									EndIf
	// Se ok com a Rda
									If lContinua .And. Len(aDadRDA) > 0
		// Buscou a especilidade sugerida no aDadRda
										If Empty(cCodEsp)
											cCodEsp		:= aDadRda[15]
											cCodEspPro  := Iif(lRdaProf,cCodEspPro,cCodEsp)
										Else
											PLSPUTRDA(15,cCodEsp)
											BAQ->( DbSetOrder(1) )
											If BAQ->(MsSeek( xFilial("BAQ")+cOpeMov+cCodEsp) )
												PLSPUTRDA(17,BAQ->BAQ_DESCRI)
											EndIf
										EndIf
		// Carrega dados da rda do profissional
										If lRdaProf .And. lTrtPro
			// Local de Atendimento x Especialidade do Profissional
											aRetFun    := u_CBFINDESP(cOpeMov,cCodRdaPro,cCodLocPro,cCodEspPro,dDatPro,aDadUsr,"","",lLoadRda,.T.,.F.,lSolicit)
											cCodEspPro := aRetFun[1]
											cCodLocPro := aRetFun[3]
											cDesLocPro := aRetFun[2]+"."+aRetFun[3]+" - "+aRetFun[4]
											aRetFun	   := aClone(aRetFun[6])
			// Verifica se tudo ok com a rda do profissional
											If Len(aRetFun) > 0
												lContinua  := aRetFun[1]
												aTrb 	   := aRetFun[2]
												If !lContinua
													U_CBMONCRI(aItens,aTrb,.T.,,,,aCriticas,aEventosNeg)
												Else
													aRdaProf := PLSGETRDA()
													If Empty(cCodEspPro)
														cCodEspPro := aRdaProf[15]
													EndIf
												EndIf
											Else
												lContinua  := .F.
											EndIf
			// Retorna para o BAU do contratado
											BAU->( DbGoTo(nRecBAU) )
			// Retorna o conteudo original da rda contratada para a aDadRDA statica
											PLSCLORDA(aDadRda)
										Else
											aRdaProf := aDadRda
										EndIf
									Else
		// Buscou a especilidade sugerida na aDadRda
										PLSPOSGLO(PLSINTPAD(),__aCdCri171[1],__aCdCri171[2])
										U_CBMONCRI(aItens,{},.F.,__aCdCri171[1],PLSBCTDESC(),,aCriticas,aEventosNeg)
									EndIf
								EndIf
								Return( { lContinua,cLocal,cDesLoc,cDesLocPro,nRecBAU,aDadRDA,aRdaProf,lTrtPro } )

/*/{Protheus.doc} u_CBUSUATE
Validacao do usuario
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function CBUSUATE(cMatric,cLocalExec,cHora,cViaCartao,cTipoMat,cNomUsrCar,cTipoGrv,aItens,;
									aCriticas,aEventosNeg,aMatInf,dDatPro,dDatNasUsr,lResInt,lHonor,lIncAutIE,lImpXml,lPtuOnline)
								LOCAL lContinua	 := .T.
								LOCAL lUsuGer	 := .T.
								LOCAL lMatGer	 := .F.
								LOCAL lCriMatInv := .F.
								LOCAL nFor		 := 0
								LOCAL cDesCri159 := ""
								LOCAL cMatUsa	 := ""
								LOCAL cOpeOri 	 := ""
								LOCAL cRetGui  	 := ""
								LOCAL cSomInt  	 := ""
								LOCAL cGuiPOS 	 := ""
								LOCAL cCrGuiPOS  := ""
								LOCAL cMatOri    := cMatric
								LOCAL aRetFun	 := {}
								LOCAL aDadUsr	 := {}
								DEFAULT lPtuOnline := .F.
// Verifica se vai usar usuario generico
								If PLSPOSGLO(PLSINTPAD(),__aCdCri159[1],__aCdCri159[2],cLocalExec,,cTipoGrv)
									cDesCri159 := PLSBCTDESC()
	// Verifica matricula antiga
									lMatGer := U_CBVLDMATAN(cMatric)
								EndIf
// Carrego o aDadUsr sem fazer algumas validacoes
								aRetFun := Iif(lMatGer,{.F.,{}},PLSA090USR(cMatric,dDatPro,cHora,"BE1",.F.,.T.,nil,nil,nil,nil,cViaCartao,cTipoMat,lIncAutIE,cNomUsrCar,dDatNasUsr,,.t.) )
// Verifica se houve critica de beneficiario invalido
								For nFor := 1 to len(aRetFun[2])
									If aRetFun[2][nFor][1] == "508"
										lCriMatInv := .T.
										Exit
									EndIf
								Next

								If aRetFun[1] .Or. (lPtuOnline .And. !lCriMatInv)
	// Monta a dadusr
									aDadUsr := PLSGETUSR()
	// Pega dados da dadusr e verifica regra do pos
									cMatUsa := aRetFun[4]
									cOpeOri := aDadUsr[45]
	// Ajusta para matricula siga
									If	AllTrim(cMatric) <> AllTrim(aDadUsr[2])
		// Se gera log caixa preta
										If lWLIO
											PlsLogFil("",__PLSFLOGX)
											PlsLogFil(Space(03)+' Matricula Recebida ( '+cMatric+' ) - Matricula Usada ( '+AllTrim(aDadUsr[2])+' )' ,__PLSFLOGX)
											PlsLogFil("",__PLSFLOGX)
										EndIf
		
										cMatric := AllTrim(aDadUsr[2])
									Endif
	
									If Len(aDadUsr) >= 67
										cRetGui  := aDadUsr[67]
									Endif
									If Len(aDadUsr) >= 68
										cSomInt  := aDadUsr[68]
									Endif
									If Len(aDadUsr) >= 69
										cGuiPOS := aDadUsr[69]
										If Len(aDadUsr) >= 70
											cCrGuiPOS :=aDadUsr[70]
										Endif
		// POS
										If cGuiPOS == "0" .And. cTipoGrv == "3"
											lContinua  := .F.
											PLSPOSGLO(PLSINTPAD(),__aCdCri092[1],__aCdCri092[2])
											U_CBMONCRI(aItens,{},.F.,__aCdCri092[1],PLSBCTDESC(),cCrGuiPOS,aCriticas,aEventosNeg)
										Endif
									Endif
								Else
									lContinua := .F.
	// Somente na importacao xml
									If lPtuOnline
		// Criacao usuario generico caso nao exista ou invalido
										lUsuGer := PLSUsrGen( PLSINTPAD() )
		
										If lUsuGer
											lContinua := .T.
			// Se gera log caixa preta
											If lWLIO
												PlsLogFil(Space(03)+' Matricula ( '+cMatric+' ) - '+__aCdCri159[1]+' - '+cDesCri159 ,__PLSFLOGX)
												PlsLogFil("",__PLSFLOGX)
											EndIf
			
											aRetFun := PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1"	,.F.,dDataBase)
											If aRetFun[1]
				// Se gera log caixa preta
												If lWLIO
													PlsLogFil(Space(03)+' Sendo utilizada a matricula do usuário genérico',__PLSFLOGX)
												EndIf
				
												cMatOri := cMatric
												cMatric := AllTrim(aRetFun[2])
												aDadUsr := PLSGETUSR()
				
												If Len(aDadUsr) >= 67
													cRetGui := aDadUsr[67]
												Endif
												If Len(aDadUsr) >= 68
													cSomInt := aDadUsr[68]
												Endif
				
												If !lPtuOnline
													AaDd(aMatInf, { __aCdCri159[1]+' - '+cDesCri159 , "NIL" } )
													AaDd(aMatInf, { 'MATRICULA INVALIDA - NAO UTILIZADA NA IMPORTACAO ( '+cMatOri+' )' , "NIL"} )
													AaDd(aMatInf, { 'MATRICULA GENERICA - USADA NA IMPORTACAO         ( '+cMatric+' )' , "NIL"} )
					
													AaDd(aMatInf, { Replicate('-',60) , "NIL"} )
												EndIf
											Else
												lContinua := .F.
												If !lPtuOnline
													AaDd(aMatInf, { 'CRITICAS DO USUARIO GENERICO' , "NIL"} )
												EndIf
				// Se gera log caixa preta
												If lWLIO
													PlsLogFil(Space(03)+'CRITICAS DE USUARIO GENERICO',__PLSFLOGX)
													PlsLogFil("",__PLSFLOGX)
												EndIf
				
												For nFor := 1 To Len(aRetFun[2])
													If !lPtuOnline
														AaDd(aMatInf, { Upper(aRetFun[2,nFor,1]+' - '+aRetFun[2,nFor,2]) , "NIL"} )
													EndIf
													PlsLogFil(Space(03)+aRetFun[2,nFor,1]+' - '+aRetFun[2,nFor,2],__PLSFLOGX)
												Next
												If !lPtuOnline
													AaDd(aMatInf, { Replicate('-',60) , "NIL"} )
												EndIf
				// Se gera log caixa preta
												If lWLIO
													PlsLogFil("",__PLSFLOGX)
												EndIf
											Endif
										Else
											If !lPtuOnline
												AaDd(aMatInf, { 'NAO FOI POSSIVEL CRIAR USUARIO GENERICO' , "NIL"} )
											EndIf
			// Se gera log caixa preta
											If lWLIO
												PlsLogFil(Space(03)+'NAO FOI POSSIVEL CRIAR USUARIO GENERICO',__PLSFLOGX)
												PlsLogFil("",__PLSFLOGX)
											EndIf
										EndIf
									EndIf
	// Exibe as criticas
									If !lContinua
										If lWLIO .And. Len(aDadUsr)==0
											PlsLogFil("",__PLSFLOGX)
											PlsLogFil(Space(03)+"<< aDadUsr esta vazia, parametros informados na PLSA090USR >>" ,__PLSFLOGX)
											PlsLogFil(Space(03)+"Matricula"+Space(15-Len("Matricula"))+"["+cMatric+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"Dat. Proc"+Space(15-Len("Dat. Proc"))+"["+DtoS(dDatPro)+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"Hor. Proc"+Space(15-Len("Hor. Proc"))+"["+cHora+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"Via Car."+Space(15-Len("Via Car."))+"["+cViaCartao+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"Tip Mat."+Space(15-Len("Tip Mat."))+"["+cTipoMat+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"lIncAutIE"+Space(15-Len("lIncAutIE"))+"["+Iif(lIncAutIE,"Sim","Nao")+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"Nom Usr"+Space(15-Len("Nom Usr"))+"["+cNomUsrCar+"]",__PLSFLOGX)
											PlsLogFil(Space(03)+"Dt. Nasc"+Space(15-Len("Dt. Nasc"))+"["+DtoS(dDatNasUsr)+"]",__PLSFLOGX)
											PlsLogFil("",__PLSFLOGX)
										EndIf
		// Itens
										If !aRetFun[1] .Or. lCriMatInv
											U_CBMONCRI(aItens,aRetFun[2],.T.,,,,aCriticas,aEventosNeg)
										EndIf
									EndIf
								EndIf
								Return( { lContinua,lMatGer,lUsuGer,cMatUsa,cOpeOri,cRetGui,cSomInt,aDadUsr,lCriMatInv } )

/*/{Protheus.doc} u_CBCHKER
Se a especialidade existe para rda
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function CBCHKER(cChave,cCodEsp)
	
								BAX->( DbSetOrder(3) )//BAX_FILIAL + BAX_CODINT + BAX_CODESP + BAX_CODIGO
								If !BAX->( MsSeek(xFilial("BAX")+cChave) )
									cCodEsp := ""
								EndIf
	
								Return

/*/{Protheus.doc} u_CBDESDF
Retorna a descricao de um dente ou face
@type function
@author Alexander Santos
@since 17.07.08
@version 1.0
/*/
							User Function u_CBDESDF(cCont,cTp)
								LOCAL cRet := ""

								If !Empty(cCont)
									If cTp == 0
										B05->( DbSetOrder(1) )
										If B05->( MsSeek(xFilial("B05")+cCont) )
											cRet := B05->B05_DESCRI
										EndIf
									Else
										B09->( DbSetOrder(1) )
										If B09->( MsSeek(xFilial("B09")+cCont) )
											cRet := B09->B09_FACDES
										EndIf
									EndIf
								EndIf
								Return cRet

/*/{Protheus.doc} u_CBGRVHOR
Monta dados para gravacao da guia de honorario
@type function
@author Alexander Santos
@since 16.03.10
@version 1.0
/*/
							User Function CBGRVHOR(cNumLib,cAno,cMes,cTipGui,lNMudFase,aDados,aDadIte,aTpPIte,aMatBd6,aUnMed,;
									aCriticas,aItens,aEventosAut,aEventosNeg)
								LOCAL nY		:= 0
								LOCAL nX		:= 0
								LOCAL nPos		:= 0
								LOCAL nFor 		:= 1
								LOCAL _nInd 	:=  1
								LOCAL aDadInt 	:= PLSDADINT(cNumLib,.T.)[3]
								LOCAL aDadCAB	:= {}
								LOCAL aHeader	:= {}
								LOCAL aCols	 	:= {}
								LOCAL aVetTrab 	:= {}
								LOCAL aTrbDF   	:= {}
								LOCAL aRetorno  := {}
								LOCAL aDadCri	:= {}
								LOCAL aCabCri	:= {}
								LOCAL aTrbCri	:= {}
								LOCAL aPartic	:= {}
								LOCAL cGraPar	:= aTpPIte[1,1]
								LOCAL cCodPro	:= ''
								LOCAL cCodPad	:= ''
								LOCAL cSequen	:= ''
								LOCAL cCRMExe	:= ''
								LOCAL cNumExe	:= ''
								LOCAL cEstExe	:= ''
								LOCAL nVlrApr	:= 0

								LOCAL aCabDFB4B := {}
								LOCAL aDadDFB4B := {}
								LOCAL aTrbDFB4B := {}
								LOCAL aAuxProc := {}

								LOCAL cNewAut	:= U_CBRETDAD( aDados,"NEWAUT","" )

								DEFAULT aItens	:= {}
// Store do Iten
								B0E->( DbSetOrder(1) )
								Store Header "B0E" TO aHeader For .T.
// Matriz Cab

								BE4->( DbSetOrder(2) )
								BE4->( MsSeek(xFilial("BE4")+cNumLib))

/*
ATENCAO ATENCAO SEMPRE EU TENHO QUE REFAZER TODAS AS VALIDACOES QUE FORAM FEITAS NA TELA.
PROCEDIMENTO A PROCEDIMENTO, POIS A PESSOA PODE MEXER NO GRAU DE PARTICIPACAO OU NO NUMRO DA INTERNACAO
DEPOIS CLICA EM CONFIRMAR
*/

								aRetTmp := PLVLDRESHO(BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO),"1","2",;
									BE4->BE4_DTALTA,BE4->BE4_TIPFAT,.T.,;
									BE4->(BE4_CODOPE+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO),"2",;
									"","","",CToD(""),aItens,aMatBD6,{},{},aCriticas,nil,nil,nil,BE4->BE4_CODRDA)

								AaDd(aDadCAB,{"B0D_VIACAR"	,BE4->BE4_VIACAR})
								AaDd(aDadCAB,{"B0D_CID"		,BE4->BE4_CID})
								AaDd(aDadCAB,{"B0D_TIPPRE"	,BE4->BE4_TIPPRE})
								AaDd(aDadCAB,{"B0D_NRLBOR"	,cNumLib})
								AaDd(aDadCAB,{"B0D_FILIAL"	,xFilial("B0D")})


								AaDd(aDadCAB,{"B0D_REGANS"	,aDadInt[2]})
								AaDd(aDadCAB,{"B0D_CNES"	,aDadInt[5]})
								AaDd(aDadCAB,{"B0D_DATGUI"	,aDadInt[16]})
								AaDd(aDadCAB,{"B0D_NOME"	,aDadInt[40]})
								AaDd(aDadCAB,{"B0D_TIPACO"	,aDadInt[60]})
								AaDd(aDadCAB,{"B0D_PLANO"	,aDadInt[75]})
								AaDd(aDadCAB,{"B0D_DATCAR"	,aDadInt[76]})
								AaDd(aDadCAB,{"B0D_CODOPE"	,aDadInt[78]})
								AaDd(aDadCAB,{"B0D_NUMCAR"	,aDadInt[81]})
								AaDd(aDadCAB,{"B0D_NUMSOL"	,cNumLib})

								AaDd(aDadCAB,{"B0D_NUMINT"	,BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)})

								AaDd(aDadCAB,{"B0D_CNESEX"	,U_CBRETDAD( aDados,"CNESEXE","" ) })

								AaDd(aDadCAB,{"B0D_RDACON"	,BE4->BE4_CODRDA})//campo 10
								AaDd(aDadCAB,{"B0D_CODRDA"	,BE4->BE4_CODRDA})//campo 10
								AaDd(aDadCAB,{"B0D_NOMCON"	,BE4->BE4_NOMRDA})//campo 11

								BAU->(DbSetOrder(1))
								BAU->(MsSeek(xFilial('BAU')+U_CBRETDAD( aDados,"CDPFEX","" ) ))
								AaDd(aDadCAB,{"B0D_RDAEXE"	,BAU->BAU_CODIGO}) //campo 13
								AaDd(aDadCAB,{"B0D_NRDAEX"	,BAU->BAU_NOME})   //campo 14

								BB0->(DbSetOrder(1))
								BB0->(MsSeek(xFilial('BB0')+aTpPIte[1,7]))
								AaDd(aDadCAB,{"B0D_CODEXE"	,BB0->BB0_CODIGO }) //campo 18
								AaDd(aDadCAB,{"B0D_NOMEXE"	,BB0->BB0_NOME })	//campo 18
								AaDd(aDadCAB,{"B0D_CPFEXE"	,BB0->BB0_CGC }) 	//campo 22

								AaDd(aDadCAB,{"B0D_SICONS"	,BB0->BB0_CODSIG }) //campo 19
								cCRMExe := BB0->BB0_CODSIG
								AaDd(aDadCAB,{"B0D_NUCONS"	,BB0->BB0_NUMCR }) 	//campo 20
								cNumExe := BB0->BB0_NUMCR
								AaDd(aDadCAB,{"B0D_UFCONS"	,BB0->BB0_ESTADO }) //campo 21
								cEstExe := BB0->BB0_ESTADO

								AaDd(aDadCAB,{"B0D_OBSERV"	,U_CBRETDAD( aDados,"MSG01","" )+U_CBRETDAD( aDados,"MSG02","" )})
								AaDd(aDadCAB,{"B0D_VALTOT"	,U_CBRETDAD( aDados,"VALTOT",0 )})
								AaDd(aDadCAB,{"B0D_GRAPAR"	,aTpPIte[1,1]})
								AaDd(aDadCAB,{"B0D_GUIORI"	,aDadInt[44]})
								AaDd(aDadCAB,{"B0D_OPEUSR"	,substr(aDadInt[81],atCodOpe[1],atCodOpe[2])})
								AaDd(aDadCAB,{"B0D_CODEMP"	,substr(aDadInt[81],atCodEmp[1],atCodEmp[2])})
								AaDd(aDadCAB,{"B0D_MATRIC"	,substr(aDadInt[81],atMatric[1],atMatric[2])})
								AaDd(aDadCAB,{"B0D_TIPREG"	,substr(aDadInt[81],atTipReg[1],atTipReg[2])})
								AaDd(aDadCAB,{"B0D_DIGITO"	,substr(aDadInt[81],atDigito[1],atDigito[2])})
								AaDd(aDadCAB,{"B0D_DATPRO"	,Date()})
								AaDd(aDadCAB,{"B0D_HORPRO"	,Subs(StrTran(Time(),":",""),1,4)})

// Montando aCols
								For nY := 1 To Len(aDadIte)
	// Verifica se o procedimento existe
									AaDd(aCols, Array(Len(aHeader)+1) )
	// Marca como nao deletado
									aCols[ Len(aCols),Len(aCols[Len(aCols)]) ] := .F.
									AaDd(aEventosAut,{''     ,''     ,''     ,0      ,''     ,0      ,'','',"",'',''})
	// Ajusta aCols
									For nX := 1 To Len(aDadIte[nY])
										nPos := PLRETPOS(aDadIte[nY,nX,1],aHeader,.F.)
										If nPos > 0
											If aDadIte[nY,nX,1] == "B0E_STATUS"
												aCols[Len(aCols),nPos] := '1'
				
											Elseif aDadIte[nY,nX,1] == "B0E_SEQUEN"
												aEventosAut[Len(aEventosAut)][1] := aDadIte[nY,nX,2]
												aCols[Len(aCols),nPos] := aDadIte[nY,nX,2]
												cSequen	:= aDadIte[nY,nX,2]
				
											Elseif aDadIte[nY,nX,1] == "B0E_CODPAD"
												aEventosAut[Len(aEventosAut)][2] := aDadIte[nY,nX,2]
												aCols[Len(aCols),nPos] := aDadIte[nY,nX,2]
												cCodPad := aDadIte[nY,nX,2]
				
											Elseif aDadIte[nY,nX,1] == "B0E_CODPRO"
												aEventosAut[Len(aEventosAut)][3] := aDadIte[nY,nX,2]
												aCols[Len(aCols),nPos] := aDadIte[nY,nX,2]
												cCodPro := aDadIte[nY,nX,2]
				
											Elseif aDadIte[nY,nX,1] == "B0E_DESPRO"
												aEventosAut[Len(aEventosAut)][5] := aDadIte[nY,nX,2]
												aCols[Len(aCols),nPos] := aDadIte[nY,nX,2]
				
											Elseif aDadIte[nY,nX,1] == "B0E_VALOR"
												aCols[Len(aCols),nPos] := aDadIte[nY,nX,2]
												nVlrApr	:= aDadIte[nY,nX,2]
				
											Elseif aDadIte[nY,nX,1] == "B0E_QTDPRO"
												aEventosAut[Len(aEventosAut)][4] := aDadIte[nY,nX,2]
												aEventosAut[Len(aEventosAut)][6] := aDadIte[nY,nX,2]
												aCols[Len(aCols),nPos] := aDadIte[nY,nX,2]
				
											Elseif aDadIte[nY,nX,1] == "B0E_VIACES"
				
												cSql := " select R_E_C_N_O_ rec from "+RetSqlName("BGR")
												cSql += " where BGR_FILIAL = '"+xFilial('BGR')+"' "
												cSql += " and BGR_CODINT = '"+aDadInt[78]+"' "
												cSql += " and BGR_VIATIS = '"+aDadIte[nY,nX,2]+"' "
												cSql += " and D_E_L_E_T_ = ' ' "
												PlsQuery(cSql,'trbBGR')
												If trbBGR->(!Eof()) .and. trbBGR->Rec > 0
													BGR->(DbGoTo(trbBGR->Rec))
													aCols[Len(aCols),nPos] := BGR->BGR_CODVIA
												Else
													aCols[Len(aCols),nPos] := ''
												Endif
												trbBGR->(DbCloseArea())
											Else
												aCols[Len(aCols),nPos] := aDadIte[nY,nX,2]
											Endif
										EndIf
									Next
									AaDd(aVetTrab,0)
	
									AaDd(aAuxProc, { cSequen, cCodPad+cCodPro, nVlrApr })
	
								Next

								If FindFunction('PGetTisVer') .and. PGetTisVer() >= '3' .and. PLSALIASEXI("B4B")
	//Carrega dados executante
	
									Store Header "B4B" TO aCabDFB4B For .T.
									Store COLS Blank "B4B" TO aDadDFB4B FROM aCabDFB4B //VETTRAB aTrbDFB4B
									aDadDFB4B:={}
									nLen := Len(aTpPIte)
									For nX := 1 to nLen
										AaDd(aDadDFB4B,Array( Len(aCabDFB4B)+1))
										aDadDFB4B[ Len(aDadDFB4B),Len(aDadDFB4B[Len(aDadDFB4B)]) ] := .F.
		
										If ( nPosRet := PLRETPOS("B4B_FILIAL",aCabDFB4B,.F.) ) > 0
											aDadDFB4B[ Len(aDadDFB4B),nPosRet ] := xFilial("B4B")
										EndIf
		
										If ( nPosRet := PLRETPOS("B4B_SEQUEN",aCabDFB4B,.F.) ) > 0
											aDadDFB4B[ Len(aDadDFB4B),nPosRet ] := aTpPIte[nX,10]
											cSequen := aTpPIte[nX,10]
										Endif
		
										If ( nPosRet := PLRETPOS("B4B_GRAUPA",aCabDFB4B,.F.) ) > 0
											aDadDFB4B[ Len(aDadDFB4B),nPosRet ] := aTpPIte[nX,1]
											cGraPar := aTpPIte[nX,1]
										Endif
		
										If ( nPosRet := PLRETPOS("B4B_SICONS",aCabDFB4B,.F.) ) > 0
											aDadDFB4B[ Len(aDadDFB4B),nPosRet ] := aTpPIte[nX,5]
											cCRMExe := aTpPIte[nX,5]
										Endif
		
										If ( nPosRet := PLRETPOS("B4B_NUCONS",aCabDFB4B,.F.) ) > 0
											aDadDFB4B[ Len(aDadDFB4B),nPosRet ] := aTpPIte[nX,4]
											cNumExe := aTpPIte[nX,4]
										Endif
		
										If ( nPosRet := PLRETPOS("B4B_UFCONS",aCabDFB4B,.F.) ) > 0
											aDadDFB4B[ Len(aDadDFB4B),nPosRet ] := aTpPIte[nX,6]
											cEstExe := aTpPIte[nX,6]
										Endif
		
										If ( nPosRet := PLRETPOS("B4B_CODESP",aCabDFB4B,.F.) ) > 0
											aDadDFB4B[ Len(aDadDFB4B),nPosRet ] := aTpPIte[nX,11] /*CBOS*/
										Endif
		
										If ( nPosRet := PLRETPOS("B4B_CDPFPR",aCabDFB4B,.F.) ) > 0
											aDadDFB4B[ Len(aDadDFB4B),nPosRet ] := aTpPIte[nX,2]
										Endif
		
										If ( nPosRet := PLRETPOS("B4B_NOMPRF",aCabDFB4B,.F.) ) > 0
											aDadDFB4B[ Len(aDadDFB4B),nPosRet ] := aTpPIte[nX,3]
										Endif
		
										nPos := aScan(aAuxProc, {|x| x[1] == cSequen})
			
										if nPos > 0
											AaDd(aPartic, {	cGraPar, cSequen, aAuxProc[nPos][2], aAuxProc[nPos][3],cCRMExe,cNumExe,cEstExe,0 } )
										endIf
		
										AaDd(aTrbDFB4B,0)
									Next nX
								Endif
// Criticas
								If Len(aCriticas) > 0
	// Inicia Matriz
									aTrbCri := Array( Len(aCriticas) )
	// Store header e cols
									Store Header "B2D" TO aCabCri For alltrim(SX3->X3_CAMPO) $ "B2D_SEQUEN,B2D_CODGLO,B2D_DESGLO,B2D_INFGLO"
									Store COLS Blank "B2D"	TO aDadCri FROM aCabCri
	// Monta criticas
									For nFor := 1 To Len(aCriticas)
		
										nPos 			:= PLRETPOS('B2D_SEQUEN',aCabCri,.F.)
										aTrbCri[nFor] 	:= 0
		
										If nPos > 0
											If nFor > Len(aDadCri)
												AaDd(aDadCri,{})
												For _nInd :=  1 To Len(aCabCri)+1
					
													AaDd(aDadCri[Len(aDadCri)],_nInd)
													If _nInd <= Len(aCabCri)
														aDadCri[Len(aDadCri),_nInd] := CriaVar(aCabCri[_nInd,2],.T.)
													Else
														aDadCri[Len(aDadCri),_nInd] := .F.
													EndIf
					
												Next
											EndIf
			
											aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,1]
			
											nPos := PLRETPOS('B2D_CODGLO',aCabCri,.F.)
											If nPos > 0
												aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,1]
											EndIf
			
											nPos := PLRETPOS('B2D_CODGLO',aCabCri,.F.)
											If nPos > 0
												aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,2]
											EndIf
			
											nPos := PLRETPOS('B2D_DESGLO',aCabCri,.F.)
											If nPos > 0
												aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,3]
											EndIf
			
											nPos := PLRETPOS('B2D_INFGLO',aCabCri,.F.)
											If nPos > 0
												aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,4]
											EndIf
										EndIf
									Next
	
								EndIf

//marco aqui os itens que nao foram autorizados
								nPos  := PLRETPOS('B2D_SEQUEN',aCabCri,.F.)
								nPoI  := PLRETPOS('B0E_SEQUEN',aHeader,.F.)
								nPoII := PLRETPOS('B0E_STATUS',aHeader,.F.)
								If nPoI > 0 .and. nPos > 0 .and. nPoII > 0
									For nFor := 1 To Len(aDadCri)
										If (nI:= aScan(aCols,{|x| aDadCri[nFor][nPos] == x[nPoI] })) > 0
											aCols[nI][nPoII] := '0'
										Endif
		
										If (nI:=aScan(aEventosAut,{|x| x[1] == aDadCri[nFor][nPos]})) > 0
											aadd(aEventosNeg,aClone(aEventosAut[nI]))
											nSize := Len(aEventosAut)
											aDel(aEventosAut,nI)
											aSize(aEventosAut,nSize-1)
										Endif
									Next
								Endif
// Grava Guia
								aRetorno :=  PLSA090Grv(aClone(aCols),aClone(aHeader),aDadCAB,K_Incluir,aClone(aVetTrab),{},;
									BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG),BE4->BE4_DATPRO,;
									BE4->BE4_HORPRO,BE4->BE4_MATUSA,cAno,cMes,cTipGui,;
									.F.,aDadCri,aCabCri,aTrbCri,/*lAutori*/,U_CBRETDAD(aDados,"ORIGEM","1"),;
									U_CBRETDAD(aDados,"CODLDP"),/*lReanaliza*/,/*cFiltro*/,/*cKey*/,/*lForBloq*/,U_CBRETDAD(aDados,"LVEIOCOMU",.F.),;
									lNMudFase,"B0E","B2D",.F.,.F.,/*aDadBE4*/,.F.,U_CBRETDAD(aDados,"RPC",(U_CBRETDAD(aDados,"TPGRV","1")=="2" .or. U_CBRETDAD(aDados,"TPGRV","1")== "4")),;
	/*aDadB43*/,/*aCabB43*/,/*aTrbB43*/,/*oBrwEven*/,/*lExcluiAte*/,/*oBrwB47*/,"B0D",.F.,;
	/*oBrwB46*/,/*oBrwB44*/,/*lIncNeg*/,/*cObsoleto*/,/*lSolicit*/,U_CBRETDAD(aDados,"TPGRV","1"),/*aColsDF*/,;
	/*aHeaderDF*/,/*aVetDF*/,/*aDaSenPro*/,.T.,aMatBd6,aUnMed,/*lResInt*/,/*cAliasCmp*/,/*lOdontoWeb*/,;
	cNumLib,NIL,NIL,NIL,NIL,aPartic,aDadDFB4B,aCabDFB4B,aTrbDFB4B,/*cNumLibOd*/,/*lRecGlo*/,/*lPTUOnSol*/,/*cObsEvo*/,;
	/*nNrSeqTR*/,/*cSenhaOpe*/,/*cOpeSolPTU*/,cNewAut )

// Fim da Funcao
Return(aRetorno)

/*/{Protheus.doc} u_CBDADCRI
Monta a dadcri
@type function
@author Alexander Santos
@since 16.03.10
@version 1.0
/*/
									User Function CBDADCRI(cAlias,aCriticas,aCabCri,aDadCri,aTrbCri,cSequen,cCodGlo,cDesGlo,cInfGlo,cCodEDI)
								LOCAL nFor	:= 0
								LOCAL _nInd := 0
								DEFAULT cCodEDI := ""
								DEFAULT cInfGlo := ""
// Inicia Matriz
								aTrbCri := Array( Len(aCriticas) )
// Store header e cols
								Store Header cAlias TO aCabCri For .T.
								Store COLS Blank cAlias	TO aDadCri FROM aCabCri
// Monta criticas
								For nFor := 1 To Len(aCriticas)
	
									nPos 			:= PLRETPOS(cSequen,aCabCri,.F.)
									aTrbCri[nFor] 	:= 0
	
									If nPos > 0
										If nFor > Len(aDadCri)
											AaDd(aDadCri,{})
											For _nInd :=  1 To Len(aCabCri)+1
				
												AaDd(aDadCri[Len(aDadCri)],_nInd)
												If _nInd <= Len(aCabCri)
													aDadCri[Len(aDadCri),_nInd] := CriaVar(aCabCri[_nInd,2],.T.)
												Else
													aDadCri[Len(aDadCri),_nInd] := .F.
												EndIf
				
											Next
										EndIf
		
										aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,1]
		
										nPos := PLRETPOS(cAlias+'_SEQCRI',aCabCri,.F.)
										If nPos > 0
											aDadCri[Len(aDadCri),nPos] := StrZero(nFor, 3)
										Endif
		
										nPos := PLRETPOS(cCodGlo,aCabCri,.F.)
										If nPos > 0
											aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,1]
										EndIf
		
										nPos := PLRETPOS(cCodGlo,aCabCri,.F.)
										If nPos > 0
											aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,2]
										EndIf
		
										nPos := PLRETPOS(cDesGlo,aCabCri,.F.)
										If nPos > 0
											aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,3]
										EndIf
		
										nPos := PLRETPOS(cInfGlo,aCabCri,.F.)
										If nPos > 0
											aDadCri[Len(aDadCri),nPos] := aCriticas[nFor,4]
										EndIf
		
										If !Empty(cCodEDI) .And. (nPos := PLRETPOS(cCodEDI,aCabCri,.F.) )  > 0 .And. !Empty(aCriticas[nFor,2])
											BCT->(DbSetOrder(1))//BCT_FILIAL+BCT_CODOPE+BCT_PROPRI+BCT_CODGLO
											If BCT->(DbSeek(xFilial("BCT")+PlsIntPad()+aCriticas[nFor,2]))	 .And. !Empty(BCT->BCT_CODED2)
												aDadCri[Len(aDadCri),nPos] := BCT->BCT_CODED2
											EndIf
										EndIf
									EndIf
								Next
// Fim da Funcao
								Return

/*/{Protheus.doc} PLXMVPR
Log original executado no rdmake
@type function
@author Alexander Santos
@since 16.03.10
@version 1.0
/*/
							Static Function PLXMVPR(aDados,aItens,lImpXml,cTipoGrv,lImpTxt)
// Se tem ponto de entrada executa e lista os dados originais no log
								If ExistBlock("PLSXMVPR")
									aRetPto := ExecBlock( "PLSXMVPR",.F.,.F.,{aDados,aItens,lImpXml,cTipoGrv,lImpTxt} )
									aDados  := aRetPto[1]
									aItens  := aRetPto[2]
	// Se permiti log
									If lWLIO
										PlsLogFil("LOG",__PLSFLOGX)
										U_CABWLIO(aDados,aItens)
									EndIf
								EndIf
// Fim da Funcao
								Return

/*/{Protheus.doc} CBLGPLS
Log
@type function
@author Tulio Cesar
@since 26.05.07
@version 1.0
/*/
							User Function CBLGPLS()
								STATIC lCBLGPLS := NIL

								If lCBLGPLS == NIL
									lCBLGPLS := (GetNewPar("MV_PLSXMOV","0")=="1")
								EndIf
								Return lCBLGPLS

/*/{Protheus.doc} CBICM
Inclui conta medica
@type function
@author Tulio Cesar
@since 24.04.12
@version 1.0
/*/
							User Function CBICM(cOpeMov,cMatric,cTipoGrv,cLocalExec,cCodPSol,cCodPExe,dDatPro,cHora,cNumImp,cCodRda,; //10
								cCodLDP,cTipo,cCodLoc,cCodEsp,cTipGui,cCid,nQtNasV,nQtNasM,nQtNasP,nQtObtP,nQtObAR,cTipFat,; //22
								cCidObt,cNrdCob,cObtMul,cTipAlt,cNrdCnv,cLotGui,aItens,cArqImp,cNumLib,aTipPart,; //32
								cAlias,lHonor,cOrimov,cNumSol,lObsoleto,lAtuPeg,cPadCon,dDtAlta,cHrAlta,cEmgest,cAborto,; //43
								cTraGra,cComurp,cAtespa,cComnal,cBaipes,cPaareo,cPatnor,cTipSai,cTipCon,cNomUsr,dDatAcat,cTipoAte,; //55
								cGrpInt,cTipInt,cIndAci,cUndDoe,nTmpDoe,cTipDoe,cMsg01,cMsg02,cEspSol,cEspExe,cTipAdm,cRegint,cCarSol,; //68
								aItens,cAteRN,lImpTxt,cFase,cSituac,cGuiOri,cCnes,aCriticas,dDtIniFat,cHrIniFat,dDtFimFat,cHrFimFat,lnInfEquip,;
									lXmlOrigS, aEspCbXML, cGuiPri, lImpXml) //85
								LOCAL nI			:= 0
								LOCAL nPos			:= 0
								LOCAL cNumGui		:= ""
								LOCAL cMesBCI 		:= Iif( !Empty(dDatAcat),StrZero(Month(dDatAcat),2), StrZero(Month(dDataBase),2) )
								LOCAL cAnoBCI		:= Iif( !Empty(dDatAcat),Str(Year(dDatAcat),4), Str(Year(dDataBase),4) )
								LOCAL cMes 			:= StrZero(Month(dDatPro),2)
								LOCAL cAno 			:= Str(Year(dDatPro),4)
								LOCAL nQtdTotEve	:= 0
								LOCAL nVlrTotGui	:= 0
								LOCAL nRecExe 		:= 0
								LOCAL nRecSol 		:= 0
								LOCAL nInd1			:= 0
								LOCAL lFoundUsr 		:= .T.
								LOCAL lCriaPEG		:= .F.
								LOCAL aRetFun  		:= {}
								LOCAL aDadRDA			:= {}
								LOCAL aDatPag 		:= {}
								LOCAL cCodEmp 		:= GetNewPar("MV_PLSGEIN","0001")
								LOCAL cModulo   		:= Modulo11(cOpeMov+cCodEmp+"99999999")
								LOCAL cMatrAntGen	   	:= cOpeMov+cCodEmp+"99999999"+cModulo
								LOCAL nIndUt			:=	0
								LOCAL cMatricXml		:= ""
								LOCAL nTamMat 		:= Len(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
								LOCAL nTamAnt 		:= Len(BA1->BA1_MATANT)
								LOCAL cSpaceUsuAtu	:= Iif(Len(AllTrim(cMatric)) == 16,"",Space(nTamMat - Len(AllTrim(cMatric))))
								LOCAL cSpaceMatAnt	:= Space(nTamAnt - Len(AllTrim(cMatric)))
								LOCAL lFoundID		:= .F.
	
								DEFAULT cFase			:= '1'
								DEFAULT cSituac		:= '1'
								DEFAULT aTipPart		:= {}
								DEFAULT cAlias		:= "BD5"
								DEFAULT lHonor		:= .F.
								DEFAULT cOrimov		:= '1'
								DEFAULT cNumSol		:= ""
								DEFAULT lObsoleto 	:= .F.
								DEFAULT lAtuPeg		:= .T.
								DEFAULT lImpTxt		:= .F.
								DEFAULT cPadCon 		:= ''
								DEFAULT dDtAlta 		:= ''
								DEFAULT cHrAlta 		:= ''
								DEFAULT cEmgest 		:= ''
								DEFAULT cAborto 		:= ''
								DEFAULT cTraGra 		:= ''
								DEFAULT cComurp 		:= ''
								DEFAULT cAtespa 		:= ''
								DEFAULT cComnal 		:= ''
								DEFAULT cBaipes 		:= ''
								DEFAULT cPaareo 		:= ''
								DEFAULT cPatnor 		:= ''
								DEFAULT cTipSai 		:= ''
								DEFAULT cTipCon 		:= ''
								DEFAULT cNomUsr 		:= ''
								DEFAULT dDatAcat		:= dDataBase
								DEFAULT cTipoAte		:= ''
								DEFAULT cGrpInt 		:= ''
								DEFAULT cTipInt 		:= ''
								DEFAULT cIndAci 		:= ''
								DEFAULT cUndDoe 		:= ''
								DEFAULT nTmpDoe 		:= 0
								DEFAULT cTipDoe 		:= ''
								DEFAULT cMsg01  		:= ''
								DEFAULT cMsg02  		:= ''
								DEFAULT cEspSol		:= ''
								DEFAULT cEspExe 		:= ''
								DEFAULT cTipAdm		:= ''
								DEFAULT cRegint		:= ''
								DEFAULT cCarSol 		:= ''
								DEFAULT cAteRN		:= "0"
								DEFAULT cCnes			:= ''
								DEFAULT aCriticas		:= []
								DEFAULT dDtIniFat 	:= CtoD("")
								DEFAULT cHrIniFat 	:= ""
								DEFAULT dDtFimFat  	:= CtoD("")
								DEFAULT cHrFimFat  	:= ""
								DEFAULT lnInfEquip  	:= .F.
								DEFAULT lXmlOrigS		:= .F.
								DEFAULT aEspCbXML		:= {}
								Default cGuiPri		:= ""
								Default lImpXml		:= .F. .OR. IsInCallstack("PLSA974")

// Validacao do usuario
								BA1->( DbSetOrder(2) ) //BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
								BA1->( DbGotop() )


								If  !BA1->( MsSeek( xFilial("BA1")+AllTrim(cMatric)+cSpaceUsuAtu))
	
	
									BA1->( DbSetOrder(5) )//BA1_FILIAL + BA1_MATANT + BA1_TIPANT
									BA1->( DbGotop() )
	
	
									If !BA1->( MsSeek( xFilial("BA1")+AllTrim(cMatric)+cSpaceMatAnt ) )
										cMatricXML:= cMatric
										PXMLUsrGe(cOpeMov)
										aRetFun := PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase)
										If !aRetFun[1]
											For nI:=1 To Len(aRetFun[2])
												If !Empty(aRetFun[2,nI,1])
													PLSICRI(@aCriticas,aRetFun[2,nI,1],aRetFun[2,nI,2])
												EndIf
											Next
										Endif
									EndIf
								EndIf

// Posiciona na familia
								BA3->( DbSetOrder(1) )//BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
								BA3->( MsSeek( xFilial("BA3") + BA1->( BA1_CODINT+BA1_CODEMP+BA1_MATRIC ) ) )

								aDadUsr := PLSDADUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),'1',.F.,dDatPro,nil,nil,nil,nil,nil,.f.)

// Verifica se o proficional de saude solicitante existe se nao cria
								If !Empty(cCodPExe)
									nRecExe := U_CBIPRF(cOpeMov,cCodPExe)
								Endif

								If !Empty(cCodPSol)
									nRecSol := U_CBIPRF(cOpeMov,cCodPSol)
								Endif

// Verifica a RDA
								aRetFun := PLSDADRDA(cOpeMov,cCodRda,"1",dDatPro,cCodLoc,cCodEsp,nil,nil,nil,nil,nil,nil,.T.)

								If aRetFun[1]
									aDadRDA := PLSGETRDA()
								Else
									For nI:=1 To Len(aRetFun[2])
										If !Empty(aRetFun[2,nI,1])
											PLSICRI(@aCriticas,aRetFun[2,nI,1],aRetFun[2,nI,2])
										EndIf
									Next
								EndIf

//Para importacao de txt by mile
								if lImpTxt
									if len(aCriticas)>0
										return('')
									endIf
								else
									aDadRDA := PLSGETRDA()
								endIf

// Criar PEG
								cChaveBCI := UPPER(cOpeMov + cCodLDP + cTipGui + cCodRda + cArqImp)
								cChaveB2  := LOWER(cOpeMov + cCodLDP + cTipGui + cCodRda + cArqImp)
// Verifica se o PEG existe
								If nInd1 == 0
									nIndUt := PLSBUIND("BCI","BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_TIPGUI + BCI_CODRDA + BCI_ARQUIV") /// Busca da Ordem do indice pela descrição
									nInd1  := nIndUt
								Endif
	
//Primeiro buscamos pelo IDXML, caso seja importação e exista essa informação
								if lImpXml .and. !lImpTxt .and. SIX->(MsSeek("BCIG")) .and. !Empty(BXX->BXX_IDXML)
									BCI->(DbSetOrdeR(16))
									lFoundID := BCI->(MsSeek(xfilial("BCI") + cOpeMov + U_CBRETLDP(2) + cTipGui + cCodRDA + AllTrim(BXX->BXX_IDXML)))
								endif
	
//Caso não seja encontrado (ou não seja buscado) pelo IDXML, segue a busca pelo arquivo
								if !lFoundID
									BCI->( DbSetOrder(nInd1) )//BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_TIPGUI + BCI_CODRDA + BCI_ARQUIV
									if !BCI->( MsSeek( xFilial("BCI")+cChaveBCI ) ) .AND. !BCI->( MsSeek( xFilial("BCI")+cChaveB2 ) )
										lCriaPEG := .t.
									endIf
								endif
	
// Total do valor apresentado
								For nI := 1 to Len(aItens)
									nPos       := Ascan(aItens[nI],{ |x| AllTrim( x[1] ) == "VLRAPR" } )
									nPos2 	   := Ascan(aItens[nI],{ |x| AllTrim( x[1] ) == "QTDAUT" } )
									If nPos > 0
										nVlrTotGui += aItens[nI,nPos,2]
									Endif
									If nPos2 > 0
										nQtdTotEve += aItens[nI,nPos2,2]
									Endif
								Next

// Verifica se cria peg

								If lCriaPEG
		// Data de pagamento
									If GetNewPar("MV_PLSDTPG",.F.)
										aDatPag := PLSXVLDCAL(dDataBase,cOpeMov,.T.,"","",NIL,cCodRda,.F.)
									EndIf
		// Cria peg
									BCI->(dbSetOrder(11))//BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_TIPGUI + BCI_CODRDA + BCI_ARQUIV
									If !BCI->(msSeek(xFilial("BCI")+cOpeMov+cCodLDP+cTipGui+cCodRda+Upper(cArqImp))) .AND. !BCI->(msSeek(xFilial("BCI")+cOpeMov+cCodLDP+cTipGui+cCodRda+cArqImp))
										U_CBIPP(cOpeMov,cCodLDP,cOpeMov,cCodRda,cMesBCI,cAnoBCI,dDataBase,cTipGui,cLotGui,aDatPag,cFase,cArqImp,nQtdTotEve,1,nVlrTotGui,,cSituac, Iif( !empty(dDatAcat),dDatAcat, dDataBase))
									EndIf
								Else
		// Atualiza totais
									If lAtuPeg
										U_CBATUPP(nQtdTotEve,nVlrTotGui)
									Endif
									If !lAtuPeg //procuro a Peg existente para que eu possa preencher o campo BCI_LOTGUI
		//Importação de XML, garantimos que a PEG encontrada será a criada anteriormente na submissão do XML
										if lImpXml .and. !lImpTxt .and. SIX->(MsSeek("BCIG")) .and. !Empty(BXX->BXX_IDXML)
											BCI->(DbSetOrdeR(16))
											If BCI->(MsSeek(xfilial("BCI") + cOpeMov + U_CBRETLDP(2) + cTipGui + cCodRDA + AllTrim(BXX->BXX_IDXML)))
												BCI->( recLock("BCI",.f.) )
												BCI->BCI_LOTGUI	:= cLotGui
												BCI->( msUnLock() )
											Endif
										else
											BCI->( DbSetOrder(nInd1) )//BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_TIPGUI + BCI_CODRDA + BCI_ARQUIV
											If BCI->( MsSeek( xFilial("BCI")+cChaveBCI ) ) .OR. BCI->( MsSeek( xFilial("BCI")+cChaveB2 ) )
												BCI->( recLock("BCI",.f.) )
												BCI->BCI_LOTGUI	:= cLotGui
												BCI->( msUnLock() )
			// Esse tratamento se da para cliente que importam a Tiss com datas antigas	
											Else
												BCI->( DbSetOrder(4) )
												If BCI->(msSeek(xFilial("BCI")+cOpeMov+cCodRda+StrZero(Year(ddatabase),4)+Strzero(Month(ddatabase),2)+"2"+cFase+cSituac+cTipGui+cCodLDP+Upper(cArqImp)))
													BCI->( recLock("BCI",.f.) )
													BCI->BCI_LOTGUI	:= cLotGui
													BCI->( msUnLock() )
												Endif
											EndIf
										endif
									Endif
								EndIf


    //buscanso os números fora da transação
								If cTipGui $ "01#02#06#04"
									cNumero  := PLSA500NUM("BD5",cOpeMov,cCodLdp,BCI->BCI_CODPEG)
									cNumInt  := ""
								Else
									cNumero  := PLSA500NUM("BE4",cOpeMov,cCodLdp,BCI->BCI_CODPEG)
									cNumInt  := PLNUMINT(cOpeMov,cAno,cMes)
								Endif

								begin transaction
	
	// Gravar o cabecalho da guia
									cNumGui := U_CBICAB(	cTipGui,cOpeMov,cCodLDP,BCI->BCI_CODPEG,BCI->BCI_FASE,BCI->BCI_SITUAC,dDatPro,; //7
									cHora,cMes,cAno,cNumImp,cCid,nQtNasV,nQtNasM,nQtNasP,nQtObtP,nQtObAR,cTipFat,cCidObt,cNrdCob,; //20
									cObtMul,cTipAlt,cNrdCnv,aDadRDA,aCriticas,cLotGui,cNumLib,lHonor,cNumSol,cPadCon,dDtAlta,; //31
									cHrAlta,cEmgest,cAborto,cTraGra,cComurp,cAtespa,cComnal,cBaipes,cPaareo,cPatnor,cArqImp,aItens,; //43
									cTipSai,cTipCon,cNomUsr,cMatrAntGen,nRecExe,nRecSol,cTipoAte,cGrpInt,cTipInt,cIndAci,cUndDoe,; //54
									nTmpDoe,cTipDoe,cMsg01,cMsg02,cEspSol,cEspExe,cTipAdm,cRegInt,BCI->BCI_MES,BCI->BCI_ANO,cCarSol,; //65
									aItens,cAteRN,lImpTxt,cGuiOri,cCnes,cMatricXml,dDtIniFat,cHrIniFat,dDtFimFat,cHrFimFat, aEspCbXML, cGuiPri, lImpXml,cNumero,cNumInt) //78
	
	// Grava itens da guia
									U_CBIITE(cLocalExec,cTipoGrv,aItens,aCriticas,cNumLib,aTipPart,cAlias,lHonor,dDatPro,cHora,cOrimov,cMatrAntGen,dDatAcat,lImpTxt,aDadUsr,lnInfEquip, lXmlOrigS, lImpXml)
	
								end transaction

								return(cNumGui)

/*/{Protheus.doc} U_CBIPP
Criacao do PEG
@type function
@author Tulio Cesar
@since 22/03/12
@version 1.0
/*/
							User Function CBIPP(cOpeMov,cCodLDP,cOpeRda,cCodRda,cMesBCI,cAnoBCI,dDTRec,cTipGui,cLotGui,aDatPag,cFase,cArqImp,nQtdTotEve,nQtdGui,nVlrTotGui,cOrigem,cSituac,dDatPeg,cDigOff,cIDXML)
								LOCAL nHP 			:= 0
								LOCAL cNewPEG 		:= ""
								LOCAL cCodIn		:= PLSINTPAD()
								LOCAL cStaTiss 		:= "1"
								DEFAULT cSituac		:= '1'
								DEFAULT nQtdTotEve 	:= 0
								DEFAULT nQtdGui		:= 0
								DEFAULT nVlrTotGui	:= 0
								DEFAULT cOrigem	    := "0"
								DEFAULT cOpeMov		:= PLSINTPAD()
								DEFAULT cCodLDP		:= "9999"
								DEFAULT dDatPeg 	:= dDataBase
								DEFAULT cDigOff 	:= ""
								DEFAULT cIDXML := ""
								BCL->(DbSetOrder(1))
								BCL->(MsSeek(xFilial("BCL")+cOpeMov+cTipGui))
// Abre Semaforo
								nHP := PLSAbreSem("PLSPEG.SMF")
// cria PEG
								cNewPEG  := PLSA175Cod(cOpeMov,cCodLDP)

//pego mês, parametrização do calendário.
								aDatPag  := PLSXVLDCAL(dDatPeg,cCodIn)
								cStaTiss := PLRETSTISS(cFase,cSituac)

								BCI->( RecLock("BCI",.T.) )
								BCI->BCI_FILIAL := xFilial("BCI")
								BCI->BCI_CODOPE := cOpeMov

// Arquivo de importacao
								BCI->BCI_ARQUIV := StrTran(cArqImp,".XML","")

// Grava restante do BCI
								BCI->BCI_CODLDP := cCodLDP
								BCI->BCI_CODPEG := cNewPEG
								BCI->BCI_OPERDA := cOpeRda

								BCI->BCI_CODRDA := cCodRda

								if BCI->( FieldPos("BCI_CGCRDA") ) > 0
									BCI->BCI_CGCRDA := Posicione("BAU",1,xFilial("BAU")+cCodRda,"BAU_CPFCGC")
								endIf

								BCI->BCI_NOMRDA := BAU->( Posicione("BAU",1,xFilial("BAU")+cCodRda,"BAU_NOME") )

								if BCI->(FieldPos("BCI_TIPPRE")) > 0
									BCI->BCI_TIPPRE := BAU->BAU_TIPPRE
								endIf

								BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
								BCI->BCI_TIPGUI := cTipGui

								If IsInCallStack("PLSA974") .And. !empty(BXX->BXX_DATMOV)
									BCI->BCI_DTDIGI := BXX->BXX_DATMOV
								Else
									BCI->BCI_DTDIGI := date()
								EndIf

// Data de recebimento do PEG
								if BCI->( FieldPos("BCI_DATREC") ) > 0
									BCI->BCI_DATREC := dDTRec
								endIf

								if BCI->( FieldPos("BCI_ORIGEM") ) > 0
									BCI->BCI_ORIGEM := cOrigem
								endIf

								BCI->BCI_CODCOR := BCL->BCL_CODCOR

								BCI->BCI_FASE   := cFase
								if BCI->( FieldPos("BCI_STTISS") ) > 0
									BCI->BCI_STTISS := IF(cStaTiss < "2", "2", cStaTiss) //Em análise
								endIf
								BCI->BCI_MES    := aDatPag[5]
								BCI->BCI_ANO    := aDatPag[4]
								BCI->BCI_SITUAC	:= cSituac
								BCI->BCI_STATUS := "1"
								BCI->BCI_TIPO   := "2"

								if BCI->(FieldPos("BCI_CODDAT")) > 0
									if Len(aDatPag) > 6
										BCI->BCI_CODDAT := aDatPag[6]
										If cCodRda != BAU->BAU_CODIGO //1
											BAU->(dbSetOrder(1))
											If BAU->(MsSeek(xfilial("BAU")+cCodRDA))
												BCI->BCI_DATPAG := PLSCHKNCAL(BCI->BCI_MES)//aDatPag[7]
											else
												BCI->BCI_DATPAG := aDatPag[7]
											EndIF
										else
											BCI->BCI_DATPAG := PLSCHKNCAL(BCI->BCI_MES)//aDatPag[7]
										EndIf
									endIf
								endIf

								if BCI->(FieldPos("BCI_LOTGUI")) > 0
									BCI->BCI_LOTGUI := cLotGui
								endIf

								if BCI->(FieldPos("BCI_GUIPAP")) > 0
									BCI->BCI_GUIPAP := IiF( PLSRETPAP( cOpeRda,cCodRda,cTipGui),"1","0" )
								endIf
// Vlr.Tt.Guias/Nr Guias Dig/Qt.Evt.Dig./Qtd Eventos
								BCI->BCI_QTDEVE := nQtdTotEve
								BCI->BCI_QTDDIG := nQtdGui
								BCI->BCI_VLRGUI := nVlrTotGui
								if (BCI->(FieldPos("BCI_VLRAPR")) > 0 )
									BCI->BCI_VLRAPR := nVlrTotGui
								endIf
//Informa se é gravação da digitação off-line
								IF (cDigOff == '1')
									BCI->BCI_DIGOFF := '1' //Se trata da digitação off-line
								ELSE
									BCI->BCI_DIGOFF := '0'
								ENDIF
	
								If BCI->(FieldPos("BCI_IDXML")) > 0
									BCI->BCI_IDXML := cIDXML
								EndIf
	
								BCI->( MsUnLock() )
// DbCommit
								BCI->( DbCommit() )

								If ExistBlock("PLDTDIGT")
									ExecBlock("PLDTDIGT",.F.,.F.,BCI->(Recno()))
								EndIf

// Fecha semaforo
								PLSFechaSem(nHP,"PLSPEG.SMF")
								return()

/*/{Protheus.doc} U_CBATUPP
Atualiza peg
@type function
@author Tulio Cesar
@since 22/03/12
@version 1.0
/*/
							User Function CBATUPP(nQtdTotEve,nVlrTotGui,nQtdGui,lBusQtd,cCodOpe,cCodLdp,cCodPeg,cChaveOri,lVlrApr)
								LOCAL nHp				:= 0
								LOCAL aAreaBD6 		:= BD6->(getArea())
								LOCAL aAreaBCI		:= BCI->(getArea())
								LOCAL cSql			:= ""
								LOCAL nVlrAprTot		:= 0
								DEFAULT nQtdTotEve 	:= 0
								DEFAULT nVlrTotGui 	:= 0
								DEFAULT nQtdGui 	:= 1
								DEFAULT lBusQtd		:= .f.
								DEFAULT cCodOpe		:= ""
								DEFAULT cCodLdp		:= ""
								DEFAULT cCodPeg		:= ""
								DEFAULT cChaveOri	:= ""
								DEFAULT lVlrApr		:= .F.


								if !empty(cCodOpe + cCodLdp + cCodPeg)
	// Busca totais
									if lBusQtd
		// Query totais
										cSql := " SELECT COUNT(BD6_CODPRO) AS QTDITET,SUM(BD6_VLRPAG) AS VLRAPRT "
										if lVlrApr
											cSql += ", SUM(BD6_VLRAPR * BD6_QTDPRO) AS VLRAPRI  "
										endIf
										cSql += "   FROM " + retSQLName("BD6")
										cSql += "  WHERE BD6_FILIAL = '" + xFilial("BD6") + "' "
										cSql += "    AND BD6_CODOPE = '" + cCodOpe + "' "
										cSql += "    AND BD6_CODLDP = '" + cCodLdp + "' "
										cSql += "    AND BD6_CODPEG = '" + cCodPeg + "' "
										cSql += "    AND BD6_CODRDA = '" + BD6->BD6_CODRDA + "' "
										cSql += "    AND D_E_L_E_T_ = ' ' "
		//abre a area
										OPEN QUERY cSql ALIAS "U_CBATUPP"
		// atualiza dados do peg
										if !U_CBATUPP->(eof())
											nQtdTotEve := U_CBATUPP->QTDITET
											nVlrTotGui := U_CBATUPP->VLRAPRT
			
											if lVlrApr
												nVlrAprTot := U_CBATUPP->VLRAPRI
											endIf
			
										endIf
		
										CLOSE QUERY "U_CBATUPP"
									endIf
								endIf
// Posiciona na peg destino
								BCI->( dbGoTop() )
								BCI->( dbSetOrder(1) ) //BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
								if !empty(cCodOpe + cCodLdp + cCodPeg) .And. BCI->( msSeek(xFilial("BCI") + cCodOpe + cCodLdp + cCodPeg) )
	
									BCI->( recLock("BCI",.f.) )
	
									if !lBusQtd
										BCI->BCI_QTDEVE	:= BCI->BCI_QTDEVE + nQtdTotEve
										BCI->BCI_QTDDIG	:= BCI->BCI_QTDDIG + nQtdGui
										BCI->BCI_VLRGUI	:= BCI->BCI_VLRGUI + nVlrTotGui
										if lVlrApr
											BCI->BCI_VLRAPR := BCI->BCI_VLRAPR + nVlrAprTot
										endIf
									else
										BCI->BCI_QTDEVE	:= nQtdTotEve
										BCI->BCI_QTDDIG	:= nQtdGui
										BCI->BCI_VLRGUI	:= nVlrTotGui
										if lVlrApr
											BCI->BCI_VLRAPR := BCI->BCI_VLRAPR + nVlrAprTot
										endIf
									endIf
	
									BCI->( msUnLock() )
									BCI->( dbCommit() )
								endIf
// atualiza a peg origem
								if !empty(cChaveOri)
	
									BCI->( dbGoTop() )
									BCI->( dbSetOrder(1) ) //BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
									if BCI->( msSeek(xFilial("BCI") + cChaveOri) )
		
										BCI->( recLock("BCI",.F.) )
										if !lBusQtd
											BCI->BCI_QTDEVE	:= BCI->BCI_QTDEVE + nQtdTotEve
											BCI->BCI_QTDDIG	:= BCI->BCI_QTDDIG + nQtdGui
											BCI->BCI_VLRGUI	:= BCI->BCI_VLRGUI + nVlrTotGui
											if lVlrApr
												BCI->BCI_VLRAPR := BCI->BCI_VLRAPR + nVlrAprTot
											endIf
										Else
			
											nQtdTotEve 	:= iIf(BCI->BCI_QTDEVE < nQtdTotEve	, 0, BCI->BCI_QTDEVE - nQtdTotEve)
											nQtdGui 	:= iIf(BCI->BCI_QTDDIG < nQtdGui	, 0, BCI->BCI_QTDDIG - nQtdGui)
											nVlrTotGui 	:= iIf(BCI->BCI_VLRGUI < nVlrTotGui	, 0, BCI->BCI_VLRGUI - nVlrTotGui)
			
											BCI->BCI_QTDEVE	:= nQtdTotEve
											BCI->BCI_QTDDIG	:= nQtdGui
											BCI->BCI_VLRGUI	:= nVlrTotGui
											if lVlrApr
												BCI->BCI_VLRAPR := BCI->BCI_VLRAPR + nVlrAprTot
											endIf
										EndIf
		
		
										BCI->( msUnLock() )
										BCI->( DbCommit() )
		
									endIf
								endif

								restArea(aAreaBD6)
								restArea(aAreaBCI)
								return(nil)

/*{Protheus.doc} U_CBICAB
Inclui cabecalho da guia
@type function
@author Tulio Cesar
@since 24.04.12
@version 1.0
*/
							User Function CBICAB(cTipGui,cCodOpe,cCodLdp,cCodPeg,cFase,cSituac,dDatPro,cHora,cMes,cAno,cNumImp,; //11
								cCid,nQtNasV,nQtNasM,nQtNasP,nQtObtP,nQtObAR,cTipFat,cCidObt,cNrdCob,cObtMul,; //21
								cTipAlt,cNrdCnv,aDadRDA,aCriticas,cLotGui,cNumLib,lHonor,cNumSol,cPadCon,; //30
								dDtAlta,cHrAlta,cEmgest,cAborto,cTraGra,cComurp,cAtespa,cComnal,cBaipes,cPaareo,; //40
								cPatnor,cArqImp,aItens,cTipSai,cTipCon,cNomUsr,cMatrAntGen,nRecExe,nRecSol,cTipoAte,; //50
								cGrpInt,cTipInt,cIndAci,cUndDoe,nTmpDoe,cTipDoe,cMsg01,cMsg02,cEspSol,cEspExe,cTipAdm,; //61
								cRegInt,cMesPag,cAnoPag,cCarSol,aItens,cAteRN,lImpTxt,cGuiOri,cCnes,cMatricXml, ; //71
								dDtIniFat,cHrIniFat,dDtFimFat,cHrFimFat, aEspCbXML, cGuiPri, lImpXml,cNumero,cNumInt) //78
	
								LOCAL 	cOpeSol := ""
								LOCAL 	cEstSol := ""
								LOCAL 	cSigSol := ""
								LOCAL 	cRegSol := ""
								LOCAL 	cNomSol := ""
								LOCAL 	cCdPfSo := ""
								LOCAL 	lInterc := .f.
								LOCAL   cGrpEmpInt:= GetNewPar("MV_PLSGEIN","0050")
								LOCAL 	lUnimeds:= IiF( AllTrim( GETNEWPAR("MV_PLSUNI","1") )=="1", .T. , .F. )
								LOCAL	nOrdBEA := 0
								LOCAL	nRecBEA := 0
								LOCAL   lTratGuiPre:= GetNewPar("MV_PLTRPRE",.F.)   // TRATA A GUIA DO PRESTADOR NA IMPORTAÇÃO DA TISS, HÁ CLIENTES QUE NAO TEM ESSA INFORMAÇÃO NO SISTEMA ()
								LOCAL 	lDigGuia := .F.

								DEFAULT lHonor  := .F.
								DEFAULT lImpTxt := .F.
								DEFAULT cNumSol := ""
								DEFAULT cPadCon := ""
								DEFAULT dDtAlta := ""
								DEFAULT cHrAlta := ""
								DEFAULT cEmgest := ""
								DEFAULT cAborto := ""
								DEFAULT cTraGra := ""
								DEFAULT cComurp := ""
								DEFAULT cAtespa := ""
								DEFAULT cComnal := ""
								DEFAULT cBaipes := ""
								DEFAULT cPaareo := ""
								DEFAULT cPatnor := ""
								DEFAULT cArqImp := ""
								DEFAULT aItens  := {}
								DEFAULT cTipSai := ""
								DEFAULT cTipCon := ""
								DEFAULT cNomUsr := ""
								DEFAULT cMatrAntGen := ""
								DEFAULT nRecExe := 0
								DEFAULT nRecSol := 0
								DEFAULT cTipoAte:= ''
								DEFAULT cGrpInt := ''
								DEFAULT cTipInt := ''
								DEFAULT cIndAci := ''
								DEFAULT cUndDoe := ''
								DEFAULT nTmpDoe := 0
								DEFAULT cTipDoe := ''
								DEFAULT cMsg01  := ''
								DEFAULT cMsg02  := ''
								DEFAULT cEspSol := ''
								DEFAULT cEspExe	:= ''
								DEFAULT cTipAdm	:= ''
								DEFAULT cRegInt	:= ""
								DEFAULT cMesPag	:=	""
								DEFAULT cAnoPag	:=	""
								DEFAULT cAteRN	:= "0"
								DEFAULT cGuiOri	:= ''
								DEFAULT cCnes	:= ''
								DEFAULT cMatricXml	:= ' '
								DEFAULT dDtIniFat  	:= CtoD("")
								DEFAULT cHrIniFat  	:= ""
								DEFAULT dDtFimFat  	:= CtoD("")
								DEFAULT cHrFimFat  	:= ""
								DEFAULT aEspCbXML	:= {}
								DEFAULT cGuiPri		:= ""
								DEFAULT lImpXml		:= .F.
								DEFAULT cNumero := ""
								DEFAULT cNumInt := ""

// Verifica o tipo de guia
								If cTipGui $ "01#02#06#04"

	// Inclui cabecalho da guia
									If Empty(cNumero)
										cNumero  := PLSA500NUM("BD5",cCodOpe,cCodLdp,cCodPeg)
										PLSLOGFIL("Atenção: chamada U_CBICAB invalida. Contate o suporte. Código 'U_CBICAB'","PLSISCAB.LOG")
										CONOUT("Atenção: chamada U_CBICAB invalida. Contate o suporte. Código 'U_CBICAB'")
									Endif
	
									BA3->( DbSetOrder(1) )
									BA3->( MsSeek( xFilial("BA3") + BA1->( BA1_CODINT+BA1_CODEMP+BA1_MATRIC ) ) )
	
									BI3->( DbSetOrder(1) )//BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO
									BI3->(MsSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO) ) )
	
									BD5->( RecLock("BD5",.T.) )
	
									BD5->BD5_FILIAL := xFilial("BD5")
	
	// Chave da guia
									BD5->BD5_CODOPE := cCodOpe
									BD5->BD5_CODLDP := cCodLdp
									BD5->BD5_CODPEG := cCodPeg
									BD5->BD5_NUMERO := cNumero
	
	// Profissional solicitante
									If nRecSol > 0
										BB0->(DbGoTo(nRecSol))
										BD5->BD5_OPESOL := cCodOpe
										BD5->BD5_ESTSOL := BB0->BB0_ESTADO
										BD5->BD5_SIGLA  := BB0->BB0_CODSIG
										BD5->BD5_REGSOL := BB0->BB0_NUMCR
										BD5->BD5_NOMSOL := BB0->BB0_NOME
										BD5->BD5_CDPFSO := BB0->BB0_CODIGO
									Endif
	
	// Profissional executante
									If nRecExe > 0
										BB0->(DbGoTo(nRecExe))
										BD5->BD5_OPEEXE := cCodOpe
										BD5->BD5_ESTEXE := BB0->BB0_ESTADO
										BD5->BD5_SIGEXE := BB0->BB0_CODSIG
										BD5->BD5_REGEXE := BB0->BB0_NUMCR
										BD5->BD5_CDPFRE := BB0->BB0_CODIGO
									Endif
	
	// Rede de Atendimento
									BD5->BD5_OPERDA := cCodOpe
	
									If Len(aDadRDA) > 0
										BD5->BD5_CODRDA := aDadRDA[2]
										BD5->BD5_NOMRDA := aDadRDA[6]
										BD5->BD5_TIPRDA := aDadRDA[8]
										BD5->BD5_CODLOC := aDadRDA[12]
										BD5->BD5_LOCAL  := aDadRDA[13]
		
										If ExistBlock("PLTISESP") .And. lImpXml
											// ajuste Mateus - Para gravação da especialidade correta. 
											BD5->BD5_CODESP := PLSRETDAD(aItens[1],"ESPPE","")
										Else
			
											BD5->BD5_CODESP := aDadRDA[15]
										Endif
		
										BD5->BD5_CPFRDA := aDadRDA[16]
										BD5->BD5_DESLOC := aDadRDA[19]
										BD5->BD5_ENDLOC := aDadRDA[20]
										BD5->BD5_TIPPRE := aDadRDA[27]
									EndIf
	
									// Usuario
									BD5->BD5_OPEUSR := BA1->BA1_CODINT
									BD5->BD5_MATANT := BA1->BA1_MATANT
	
									If alltrim(BA1->BA1_MATANT) == alltrim(cMatrAntGen)
										BD5->BD5_NOMUSR := cNomUsr
									Else
										BD5->BD5_NOMUSR := BA1->BA1_NOMUSR
									Endif
	
/*									If !Empty(cMatricXml)
										BD5->BD5_MATXML := cMatricXml
									Endif*/
	
									If BA1->BA1_CODEMP == cGrpEmpInt
										lInterc := .t.
									Endif
	
									BD5->BD5_CODEMP := BA1->BA1_CODEMP
	
									BD5->BD5_MATRIC := BA1->BA1_MATRIC
									BD5->BD5_TIPREG := BA1->BA1_TIPREG
									BD5->BD5_CPFUSR := BA1->BA1_CPFUSR
									BD5->BD5_IDUSR  := BA1->BA1_DRGUSR
									BD5->BD5_DATNAS := BA1->BA1_DATNAS
									BD5->BD5_DIGITO := BA1->BA1_DIGITO
									BD5->BD5_CONEMP := BA1->BA1_CONEMP
									BD5->BD5_VERCON := BA1->BA1_VERCON
									BD5->BD5_SUBCON := BA1->BA1_SUBCON
									BD5->BD5_VERSUB := BA1->BA1_VERSUB
									BD5->BD5_MATVID := BA1->BA1_MATVID
	
	// Dados complementares
									BD5->BD5_FASE	:= cFase
									BD5->BD5_SITUAC	:= cSituac
									BD5->BD5_DATPRO	:= dDatPro
									BD5->BD5_HORPRO	:= cHora
									BD5->BD5_NUMIMP	:= cNumImp //Numero do impresso no PLS e sempre o Nro. da guia do prestador
	
									If lUnimeds
	
										nOrdBEA := BEA->(IndexOrd())
										nRecBEA := BEA->(Recno())
		
										BEA->(DbSetOrder(14))
										If  BEA->(MsSeek(xFilial("BEA")+cNumLib)) .And. !Empty(BEA->BEA_NRAOPE)
											BD5->BD5_NRAOPE := BEA->BEA_NRAOPE
										Else
											BD5->BD5_NRAOPE	:= cNumLib
										Endif
		
										BEA->(DbGoTo(nRecBEA))
										BEA->(DbSetOrder(nOrdBEA))
		
									Else
										BD5->BD5_NRAOPE	:= cNumLib
									Endif
	
									BD5->BD5_LOTGUI	:= cLotGui
									BD5->BD5_TIPGUI := cTipGui
									BD5->BD5_GUIORI	:= cGuiOri
									If IsInCallStack("CABA974") .And. !Empty(BXX->BXX_DATMOV)
										BD5->BD5_DTDIGI 	:= BXX->BXX_DATMOV
									Else
										BD5->BD5_DTDIGI 	:= date()
									EndIf
									BD5->BD5_MESPAG := cMesPag
									BD5->BD5_ANOPAG := cAnoPag
									BD5->BD5_TIPPAC := '1'
									BD5->BD5_MATUSA := "1"
									BD5->BD5_ATERNA := cAteRN
									BD5->BD5_PACOTE := "0"
									BD5->BD5_ORIMOV := "1"
									BD5->BD5_GUIACO := "0"
									BD5->BD5_LIBERA := "0"
									BD5->BD5_RGIMP  := "1"
									BD5->BD5_TPGRV  := "4"
									BD5->BD5_TIPATE := cTipoAte
									BD5->BD5_CID	:= cCid
									BD5->BD5_TIPFAT := cTipFat
	
									If !Empty(cPadCon)
										BD5->BD5_PADCON := cPadCon
									Else
										BD5->BD5_PADCON := PLSACOMUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG),'2')
									EndIf
	
									BD5->BD5_PADINT := BI3->BI3_CODACO
									BD5->BD5_QTDEVE := Len(aItens)
									BD5->BD5_TIPSAI := cTipSai
									BD5->BD5_TIPCON := cTipCon
									BD5->BD5_INDACI := cIndAci
									BD5->BD5_SENHA  := cNumLib
	
									BD5->BD5_GUIPRI := IIF( ValType(cGuiPri) <> "C", "", cGuiPri)
	
									If cTipAdm $ "E,1"
										BD5->BD5_TIPADM	:=  GetNewPar("MV_PLSCDEL","0")
									Else
										BD5->BD5_TIPADM	:=  GetNewPar("MV_PLSCDUR","0")
									Endif
									
										B0X->(dbsetorder(1))
										if B0X->(dbseek(xFilial("B0X")+cEspSol))
											cEspSol := B0X->B0X_XCDESP
										endif 
									//BD5->BD5_OBSGUI := cMsg01 + cMsg02 - Rever
									BD5->BD5_ESPSOL := cEspSol
									
									If !Empty(cEspEXe)
										
										B0X->(dbsetorder(1))
										if B0X->(dbseek(xFilial("B0X")+cEspEXe))
											cEspEXe := B0X->B0X_XCDESP
										endif 
										
										BD5->BD5_ESPEXE := cEspEXe
									Else
									
									B0X->(dbsetorder(1))
										if B0X->(dbseek(xFilial("B0X")+U_CBRETDAD(aItens[1],"ESPEXE","")))
											cEspEXe := B0X->B0X_XCDESP
										endif 
										BD5->BD5_ESPEXE :=	cEspEXe
										//BD5->BD5_ESPEXE := U_CBRETDAD(aItens[1],"ESPPRO","")
									Endif
	
									BD5->BD5_UTPDOE    := cUndDoe
									BD5->BD5_TPODOE    := nTmpDoe
									BD5->BD5_TIPDOE    := cTipDoe
//	BD5->BD5_CNES    := cCnes //- Rever
	
									If lHonor
										BD5->BD5_REGFOR := '1'
		
										BE4->(DbSetORder(2))
										If BE4->(MsSeek(xFilial("BE4")+padr(cNumSol,18)))
		
											BD5->BD5_GUIINT := BE4->BE4_CODOPE+BE4->BE4_CODLDP+BE4->BE4_CODPEG+BE4->BE4_NUMERO
			
			//ESTE CAMPO AQUI EH O NRO DO GUIA PRINCIPAL, SERVE PARA FAZER A LIGACAO ENTRE GUIAS, NA PRATICA DEVE TER O NRO DA LIBERACAO
											BD5->BD5_GUIPRI := BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
			
											If lInterc
												BD5->BD5_NRAOPE := BE4->BE4_NRAOPE
											Endif
			
											BD5->BD5_SENHA  := BE4->BE4_SENHA
			
										Else
		
											BE4->( DbSetOrder(7) )
											If BE4->(MsSeek(xFilial("BE4")+padr(cNumSol,9)))
			
												BD5->BD5_GUIINT := BE4->BE4_CODOPE+BE4->BE4_CODLDP+BE4->BE4_CODPEG+BE4->BE4_NUMERO
				
				//ESTE CAMPO AQUI EH O NRO DO GUIA PRINCIPAL, SERVE PARA FAZER A LIGACAO ENTRE GUIAS, NA PRATICA DEVE TER O NRO DA LIBERACAO
												BD5->BD5_GUIPRI := BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
				
												If lInterc
													BD5->BD5_NRAOPE := BE4->BE4_NRAOPE
												Endif
				
												BD5->BD5_SENHA  := BE4->BE4_SENHA
				
											Else
												If !Empty(cNumSol)
													PLSICRI(@aCriticas,__aXMLCri23[1],__aXMLCri23[2])
												Endif
											Endif
										Endif
		
									Else
	
										BEA->( DbSetOrder(1) )
										If BEA->( MsSeek(xFilial("BEA")+padr(alltrim(cNumLib),18)) )
		
			//se esta eh uma liberacao
											If BEA->BEA_LIBERA == '1'
			
												BD5->BD5_NRLBOR	:= BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)

				//ESTE CAMPO AQUI EH O NRO DO GUIA PRINCIPAL, SERVE PARA FAZER A LIGACAO ENTRE GUIAS, NA PRATICA DEVE TER O NRO DA LIBERACAO
												BD5->BD5_GUIPRI := BD5->BD5_NRLBOR
			
												If lInterc
													BD5->BD5_NRAOPE := BEA->BEA_NRAOPE
												Endif
				
												BD5->BD5_SENHA  := BEA->BEA_SENHA
			
			//mas por engano o prestador pode ter enviado o nro da autorizacao ao invez do nro da liberacao
											Else
			
												BD5->BD5_NRLBOR	:= IIF( EmpTy(BEA->BEA_NRLBOR), BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT), BEA->BEA_NRLBOR)
				
				//ESTE CAMPO AQUI EH O NRO DO GUIA PRINCIPAL, SERVE PARA FAZER A LIGACAO ENTRE GUIAS, NA PRATICA DEVE TER O NRO DA LIBERACAO
												BD5->BD5_GUIPRI := BD5->BD5_NRLBOR
			
												If lInterc
													BD5->BD5_NRAOPE := BEA->BEA_NRAOPE
												Endif
				
												BD5->BD5_SENHA  := BEA->BEA_SENHA
				
											Endif
			
										Else
			
											BEA->( DbSetOrder(14) )
											If BEA->( MsSeek(xFilial("BEA")+padr(alltrim(cNumLib),9)) )
				//se esta eh uma liberacao
												If BEA->BEA_LIBERA == '1'
				
													BD5->BD5_NRLBOR	:= BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)
					
					//ESTE CAMPO AQUI EH O NRO DO GUIA PRINCIPAL, SERVE PARA FAZER A LIGACAO ENTRE GUIAS, NA PRATICA DEVE TER O NRO DA LIBERACAO
													BD5->BD5_GUIPRI := BD5->BD5_NRLBOR
				
													If lInterc
														BD5->BD5_NRAOPE := BEA->BEA_NRAOPE
													Endif
					
													BD5->BD5_SENHA  := BEA->BEA_SENHA
				
				//mas por engano o prestador pode ter enviado o nro da autorizacao ao invez do nro da liberacao
												Else
				
													BD5->BD5_NRLBOR	:= IIF( EmpTy(BEA->BEA_NRLBOR), BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT), BEA->BEA_NRLBOR)

					//ESTE CAMPO AQUI EH O NRO DO GUIA PRINCIPAL, SERVE PARA FAZER A LIGACAO ENTRE GUIAS, NA PRATICA DEVE TER O NRO DA LIBERACAO
													BD5->BD5_GUIPRI := BD5->BD5_NRLBOR

													If lInterc
														BD5->BD5_NRAOPE := BEA->BEA_NRAOPE
													Endif
					
													BD5->BD5_SENHA  := BEA->BEA_SENHA
					
												Endif
											Else
			
												If lTratGuiPre
				
													If BEA->(FieldPos("BEA_GUIPRE"))> 0
						
														cAliasTrb := GetNextAlias()
						
														BeginSql Alias cAliasTrb
															SELECT BEA.R_E_C_N_O_ FROM %table:BEA% BEA
															WHERE BEA_FILIAL = %exp:xFilial("BEA")%
															AND BEA_GUIPRE 	= %exp:cNumLib%
															AND BEA.%NotDel%
														Endsql
						
														If (cAliasTrb)->(Eof())
							
															If !Empty(cNumLib)
																PLSICRI(@aCriticas,__aXMLCri23[1],__aXMLCri23[2])
															Endif
														Else
						
															BEA->(DbGoto((cAliasTrb)->R_E_C_N_O_))
						
															(cAliasTrb)->(DbCloseArea())
							
							//se esta eh uma liberacao
															If BEA->BEA_LIBERA == '1'
						
																BD5->BD5_NRLBOR	:= BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)

								//ESTE CAMPO AQUI EH O NRO DO GUIA PRINCIPAL, SERVE PARA FAZER A LIGACAO ENTRE GUIAS, NA PRATICA DEVE TER O NRO DA LIBERACAO
																BD5->BD5_GUIPRI := BD5->BD5_NRLBOR

																If lInterc
																	BD5->BD5_NRAOPE := BEA->BEA_NRAOPE
																Endif

																BD5->BD5_SENHA  := BEA->BEA_SENHA
							//mas por engano o prestador pode ter enviado o nro da autorizacao ao invez do nro da liberacao	
															Else
							
																BD5->BD5_NRLBOR	:= IIF( EmpTy(BEA->BEA_NRLBOR), BEA->(BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT), BEA->BEA_NRLBOR)
								
								//ESTE CAMPO AQUI EH O NRO DO GUIA PRINCIPAL, SERVE PARA FAZER A LIGACAO ENTRE GUIAS, NA PRATICA DEVE TER O NRO DA LIBERACAO
																BD5->BD5_GUIPRI := BD5->BD5_NRLBOR
							
																If lInterc
																	BD5->BD5_NRAOPE := BEA->BEA_NRAOPE
																Endif
							
																BD5->BD5_SENHA  := BEA->BEA_SENHA
								
															Endif
							
														Endif
						
													Else
						
														If !Empty(cNumLib)
															PLSICRI(@aCriticas,__aXMLCri23[1],__aXMLCri23[2])
														Endif
						
													Endif
												Endif
											Endif
										Endif
									Endif
	
	//Ajuste nos dados de especialidade
									If Len(aEspCbXML) > 0
										U_CBGrvEspXML("BD5",aEspCbXML)
									EndIf
	
									BD5->( MsUnLock() )
	
									cRet := BD5->(BD5_CODOPE+" - "+BD5_CODLDP+" - "+BD5_CODPEG+" - "+BD5_NUMERO)
	
								ElseIf cTipGui $ '03#05' //internacao
	
									aAreaBEA := BEA->(GetArea())
	
									BEA->( DbSetOrder(14) )     //Ha Cliente que tem que comparar a senha com a matricula para saber se é o mesmo usuario
									If BEA->( MsSeek(xFilial("BEA")+padr(alltrim(cNumLib),18)) )
	
										If BEA->BEA_LIBERA == '1'
		
											If BA1->(BA1_MATRIC) <> BEA->(BEA_MATRIC)
			
												PLSICRI(@aCriticas,__aXMLCri23[1],__aXMLCri23[2])
											Endif
			
										Endif
		
									Endif
									RestArea(aAreaBEA)
	
									If Empty(cNumero)
										cNumero  := PLSA500NUM("BE4",cCodOpe,cCodLdp,cCodPeg)
										PLSLOGFIL("Atenção: chamada U_CBICAB invalida. Contate o suporte. Código 'U_CBICAB'","PLSISCAB.LOG")
										CONOUT("Atenção: chamada U_CBICAB invalida. Contate o suporte. Código 'U_CBICAB'")
									Endif
	
									cCC      := PLSUSRCC(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))
	
									If Empty(cNumInt)
										cNumInt  := PLNUMINT(cCodOpe,cAno,cMes)
										PLSLOGFIL("Atenção: chamada U_CBICAB invalida. Contate o suporte. Código 'U_CBICAB'","PLSISCAB.LOG")
									Endif
	
									BA3->( DbSetOrder(1) )
									BA3->( MsSeek( xFilial("BA3") + BA1->( BA1_CODINT+BA1_CODEMP+BA1_MATRIC ) ) )
	
									BI3->( DbSetOrder(1) )//BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO
									BI3->(MsSeek(xFilial("BI3")+BA3->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO) ) )
	
									BE4->(RecLock("BE4",.T.))
	
									BE4->BE4_FILIAL := xFilial("BE4")
									BE4->BE4_CODOPE := cCodOpe
									BE4->BE4_CODLDP := cCodLdp
									BE4->BE4_CODPEG := cCodPeg
									BE4->BE4_NUMERO := cNumero
									BE4->BE4_NUMIMP := cNumImp//o numero do impresso no pls eh sempre o nro da guia no prestador
									BE4->BE4_GUIORI := cGuiOri
									BE4->BE4_GUIIMP := "1"
									BE4->BE4_DATPRO := BE4->BE4_DATPRO := Iif(cTipGui=="05",dDtIniFat,dDatPro)
									cNumSol 	   	:= PLSSenAut(Iif(cTipGui=="05",dDtIniFat,dDatPro))
									BE4->BE4_PRVINT := dDatPro
									BE4->BE4_DATVAL := BE4->BE4_DATPRO+GetNewPar("MV_PLPRZAI",30)
									BE4->BE4_TIPUSR := BA3->BA3_TIPOUS
									BE4->BE4_HORPRO := cHora
									BE4->BE4_OPEUSR := BA1->BA1_CODINT
									BE4->BE4_MATANT := BA1->BA1_MATANT
									BE4->BE4_ATERNA := cAteRN
	
									If alltrim(BA1->BA1_MATANT) == alltrim(cMatrAntGen)
										BE4->BE4_NOMUSR := cNomUsr
									Else
										BE4->BE4_NOMUSR := BA1->BA1_NOMUSR
									Endif
	
									If !Empty(cMatricXml)
										BE4->BE4_MATXML := cMatricXml
									Endif
	
									BE4->BE4_OPERDA := cCodOpe
	
									If Len(aDadRDA) > 0
										BE4->BE4_CODRDA := aDadRDA[2]
										BE4->BE4_NOMRDA := aDadRDA[6]
										BE4->BE4_CODESP := aDadRda[15]
										BE4->BE4_LOCAL  := aDadRda[13]
										BE4->BE4_CODLOC := aDadRda[12]
										BE4->BE4_TIPPRE := aDadRda[27]
									Endif
	
									BE4->BE4_INDACI    := cIndAci
									BE4->BE4_UTPDOE    := cUndDoe
									BE4->BE4_TPODOE    := nTmpDoe
									BE4->BE4_TIPDOE    := cTipDoe
	
									If Empty(cCid)
										BE4->BE4_CID := xRetCidGe()
										BE4->BE4_DESCID := BA9->(Posicione("BA9",1,xFilial("BA9")+BE4->BE4_CID,"BA9_DOENCA"))
									Else
										BE4->BE4_CID := cCid
										BE4->BE4_DESCID := BA9->(Posicione("BA9",1,xFilial("BA9")+BE4->BE4_CID,"BA9_DOENCA"))
									Endif
	
									If !Empty(BE4->BE4_CID)
										BE4->BE4_INTSIP := BA9->(Posicione("BA9",1,xFilial("BA9")+BE4->BE4_CID,"BA9_INTSIP"))
									Endif
	
									BE4->BE4_OPESOL := cCodOpe
									BE4->BE4_TIPGUI := BCI->BCI_TIPGUI
									BE4->BE4_CODEMP := BA1->BA1_CODEMP
									BE4->BE4_MATRIC := BA1->BA1_MATRIC
	
									If BA1->BA1_CODEMP == cGrpEmpInt
										lInterc := .t.
									Endif
	
									BE4->BE4_TIPREG := BA1->BA1_TIPREG
									BE4->BE4_CPFUSR := BA1->BA1_CPFUSR
									BE4->BE4_IDUSR  := BA1->BA1_DRGUSR
									BE4->BE4_DATNAS := BA1->BA1_DATNAS
									BE4->BE4_FASE   := BCI->BCI_FASE
									BE4->BE4_SITUAC := BCI->BCI_SITUAC
									BE4->BE4_DIGITO := BA1->BA1_DIGITO
									BE4->BE4_CONEMP := BA1->BA1_CONEMP
									BE4->BE4_VERCON := BA1->BA1_VERCON
									BE4->BE4_SUBCON := BA1->BA1_SUBCON
									BE4->BE4_VERSUB := BA1->BA1_VERSUB
	
									BE4->BE4_MATVID := BA1->BA1_MATVID
	
									If IsInCallStack("PLSA974") .And. !Empty(BXX->BXX_DATMOV)
										BE4->BE4_DTDIGI 	:= BXX->BXX_DATMOV
									Else
										BE4->BE4_DTDIGI 	:= date()
									EndIf
	
									BE4->BE4_ANOINT := cAno
									BE4->BE4_MESINT := cMes
									BE4->BE4_NUMINT := cNumInt
									BE4->BE4_MATUSA := "1"
									BE4->BE4_PACOTE := "0"
									BE4->BE4_SENHA  := cNumSol
									//BE4->BE4_TPGRV  := "4"
									BE4->BE4_ORIMOV := "2"
									BE4->BE4_MESPAG := cMesPag
									BE4->BE4_ANOPAG := cAnoPag
									BE4->BE4_CC     := cCC
	
									If cTipAdm $ "E,1"
										BE4->BE4_TIPADM	:=  getNewPar("MV_PLSCDEL","0")
									Else
										BE4->BE4_TIPADM	:=  getNewPar("MV_PLSCDUR","0")
									Endif
	
									BE4->BE4_PADINT := BI3->BI3_CODACO
									BE4->BE4_RGIMP  := "1"
	
									If nRecSol > 0
										BB0->(DbGoTo(nRecSol))
										BE4->BE4_OPESOL := cCodOpe
										BE4->BE4_ESTSOL := BB0->BB0_ESTADO
										BE4->BE4_SIGLA  := BB0->BB0_CODSIG
										BE4->BE4_REGSOL := BB0->BB0_NUMCR
										BE4->BE4_NOMSOL := BB0->BB0_NOME
										BE4->BE4_CDPFSO := BB0->BB0_CODIGO
									Endif
	
									If nRecExe > 0
										BB0->(DbGoTo(nRecExe))
										BE4->BE4_OPEEXE := cCodOpe
										BE4->BE4_ESTEXE := BB0->BB0_ESTADO
										BE4->BE4_SIGLA  := BB0->BB0_CODSIG
										BE4->BE4_REGEXE := BB0->BB0_NUMCR
										BE4->BE4_NOMEXE := BB0->BB0_NOME
										BE4->BE4_CDPFRE := BB0->BB0_CODIGO
									Endif
	
									BE4->BE4_STATUS := '1'
	
									If !Empty(cPadCon)
										BE4->BE4_PADCON := cPadCon
									Else
										BE4->BE4_PADCON := PLSACOMUSR(BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG),'2')
									EndIf
	
									BE4->BE4_DTALTA := dDtAlta
									BE4->BE4_HRALTA := cHrAlta
									BE4->BE4_DTINIF := dDtIniFat
									BE4->BE4_HRINIF := cHrIniFat
									BE4->BE4_DTFIMF := dDtFimFat
									BE4->BE4_HRFIMF := cHrFimFat
									BE4->BE4_TIPFAT := cTipFat
									BE4->BE4_QTDEVE := Len(aItens)
									BE4->BE4_EMGEST := cEmgest
									BE4->BE4_ABORTO := cAborto
									BE4->BE4_TRAGRA := cTragra
									BE4->BE4_COMURP := cComurp
									BE4->BE4_ATESPA := cAtespa
									BE4->BE4_COMNAL := cComnal
									BE4->BE4_BAIPES  := cBaipes
									BE4->BE4_PARCES  := cPaareo
									BE4->BE4_PATNOR := cPatNor
									BE4->BE4_ARQIMP := cArqImp
									BE4->BE4_LOTGUI := cLotGui
									BE4->BE4_NRDCNV := cNrdCnv
									BE4->BE4_NASVIV := nQtNasV
									BE4->BE4_NASMOR := nQtNasM
									BE4->BE4_NASVPR := nQtNasP
									BE4->BE4_OBTMUL := cObtMul
									BE4->BE4_MSG01 	:= cMsg01
									BE4->BE4_MSG02 	:= cMsg02
									BE4->BE4_ESPSOL := cEspSol
									BE4->BE4_ESPEXE := cEspExe
									//BE4->BE4_CNES   := cCnes
									BE4->BE4_GRPINT := cGrpInt
									BE4->BE4_TIPINT := cTipInt
									BE4->BE4_TIPALT := cTipAlt
									BE4->BE4_REGINT := cRegInt
	
	//Ajuste nos dados de especialidade
									If Len(aEspCbXML) > 0
										U_CBGrvEspXML("BE4",aEspCbXML)
									EndIf
	
									BE4->(MsUnLock())
									nRecBE4 := BE4->(Recno())
	
									BE4->(DbSetORder(2))
									If BE4->(MsSeek(xFilial("BE4")+padr(cNumSol,18)))
	
										cChave 	:= BE4->BE4_CODOPE+BE4->BE4_CODLDP+BE4->BE4_CODPEG+BE4->BE4_NUMERO
										cTipAl1 := Posicione('BIY',1,xFilial('BIY')+cCodOpe+cTipAlt,'BIY_MOTSAI')
		
		//se o tipo de faturamento eh total eu tenho que fechar a guia de solicitacao
										If cTipFat $ "T,4" .and. alltrim(cTipAl1) <> '31' //se o tipo de alta nao eh por transferencia
											BE4->(RecLock("BE4",.F.))
			
											BE4->BE4_DTALTA := dDtAlta
											BE4->BE4_HRALTA := cHrAlta
											BE4->BE4_TIPFAT := cTipFat
											BE4->BE4_TIPALT := cTipAlt
		
											If Empty(BE4->BE4_DATPRO)
												BE4->BE4_DATPRO := dDatPro
											Endif
		
											If Empty(BE4->BE4_PRVINT)
												BE4->BE4_PRVINT := dDatPro
											Endif
		
											If Empty(BE4->BE4_DATVAL)
												BE4->BE4_DATVAL := BE4->BE4_DATPRO+GetNewPar("MV_PLPRZAI",30)
											Endif
		
											If Empty(BE4->BE4_HORPRO)
												BE4->BE4_HORPRO := cHora
											Endif
											BE4->(MsUnLock())
			
										Else
		
											BE4->(RecLock("BE4",.F.))
											If Empty(BE4->BE4_DATPRO)
												BE4->BE4_DATPRO := dDatPro
											Endif
											If Empty(BE4->BE4_PRVINT)
												BE4->BE4_PRVINT := dDatPro
											Endif
											If Empty(BE4->BE4_DATVAL)
												BE4->BE4_DATVAL := BE4->BE4_DATPRO+GetNewPar("MV_PLPRZAI",30)
											Endif
											If Empty(BE4->BE4_HORPRO)
												BE4->BE4_HORPRO := cHora
											Endif
			
											BE4->(MsUnLock())
		
										Endif
		
										cOpeSol := BE4->BE4_OPESOL
										cEstSol := BE4->BE4_ESTSOL
										cSigSol := BE4->BE4_SIGLA
										cRegSol := BE4->BE4_REGSOL
										cNomSol := BE4->BE4_NOMSOL
										cCdPfSo := BE4->BE4_CDPFSO
										cNraOpe := BE4->BE4_NRAOPE
		
										BE4->(DbGoTo(nRecBE4))
		
		//gravo na guia de resumo o nro da solicitacao
										BE4->(RecLock("BE4",.F.))
		
										BE4->BE4_GUIINT := cChave
		
		//se o solicitante nao foi informado eu pego o solicitante da solicitacao inicial
										If Empty(BE4->BE4_OPESOL) .or. Empty(BE4->BE4_SIGLA) .or. Empty(BE4->BE4_ESTSOL)
											BE4->BE4_OPESOL  := cOpeSol
											BE4->BE4_ESTSOL  := cEstSol
											BE4->BE4_SIGLA   := cSigSol
											BE4->BE4_REGSOL  := cRegSol
											BE4->BE4_NOMSOL  := cNomSol
											BE4->BE4_CDPFSO  := cCdPfSo
										Endif
		
										If !Empty(cNraOpe) .and. lInterc
											BE4->BE4_NRAOPE := cNraOpe
										Endif
		
										BE4->(MsUnLock())
		
									Else
		
										BE4->( DbSetOrder(7) )
										If !(EmpTy(cNumSol)) .and. BE4->(MsSeek(xFilial("BE4")+padr(cNumSol,9)))
		
											cTipAl1 := Posicione('BIY',1,xFilial('BIY')+cCodOpe+cTipAlt,'BIY_MOTSAI')
			
											cChave := BE4->BE4_CODOPE+BE4->BE4_CODLDP+BE4->BE4_CODPEG+BE4->BE4_NUMERO
			
			//se o tipo de faturamento eh total eu tenho que fechar a guia de solicitacao
			//se o tipo de alta nao eh por transferencia
											If cTipFat $ "T,4" .and. alltrim(cTipAl1) <> '31'
			
												BE4->(RecLock("BE4",.F.))
												BE4->BE4_DTALTA := dDtAlta
												BE4->BE4_HRALTA := cHrAlta
												BE4->BE4_TIPFAT := cTipFat
												BE4->BE4_TIPALT := cTipAlt
			
												If Empty(BE4->BE4_DATPRO)
													BE4->BE4_DATPRO := dDatPro
												Endif
			
												If Empty(BE4->BE4_PRVINT)
													BE4->BE4_PRVINT := dDatPro
												Endif
			
												If Empty(BE4->BE4_DATVAL)
													BE4->BE4_DATVAL := BE4->BE4_DATPRO+GetNewPar("MV_PLPRZAI",30)
												Endif
			
												If Empty(BE4->BE4_HORPRO)
													BE4->BE4_HORPRO := cHora
												Endif
												BE4->(MsUnLock())
				
											Endif
			
											cOpeSol := BE4->BE4_OPESOL
											cEstSol := BE4->BE4_ESTSOL
											cSigSol := BE4->BE4_SIGLA
											cRegSol := BE4->BE4_REGSOL
											cNomSol := BE4->BE4_NOMSOL
											cCdPfSo := BE4->BE4_CDPFSO
											cNraOpe := BE4->BE4_NRAOPE
			
											BE4->(DbGoTo(nRecBE4))
			
			//gravo na guia de resumo o nro da solicitacao
											BE4->(RecLock("BE4",.F.))
			
											BE4->BE4_GUIINT := cChave
			
			//se o solicitante nao foi informado eu pego o solicitante da solicitacao inicial
											If Empty(BE4->BE4_OPESOL) .or. Empty(BE4->BE4_SIGLA) .or. Empty(BE4->BE4_ESTSOL)
												BE4->BE4_OPESOL  := cOpeSol
												BE4->BE4_ESTSOL  := cEstSol
												BE4->BE4_SIGLA   := cSigSol
												BE4->BE4_REGSOL  := cRegSol
												BE4->BE4_NOMSOL  := cNomSol
												BE4->BE4_CDPFSO  := cCdPfSo
											Endif
			
											If !Empty(cNraOpe) .and. lInterc
												BE4->BE4_NRAOPE := cNraOpe
											Endif
			
											BE4->(MsUnLock())
			
										Else
		
											If !Empty(cNumSol)
												PLSICRI(@aCriticas,__aXMLCri23[1],__aXMLCri23[2])
											Endif
			
										Endif
		
									Endif
	
									BE4->(DbGoTo(nRecBE4))
	
									cRet := BE4->(BE4_CODOPE+" - "+BE4_CODLDP+" - "+BE4_CODPEG+" - "+BE4_NUMERO)
	
	
	
								Endif

								If Existblock('PLSICAB1')
									ExecBlock( 'PLSICAB1',.F.,.F.,{cTipGui,cCodOpe,cCodLdp,cCodPeg,cFase,cSituac,dDatPro,cHora,cMes,cAno,cNumImp,;
										cCid,nQtNasV,nQtNasM,nQtNasP,nQtObtP,nQtObAR,cTipFat,cCidObt,cNrdCob,cObtMul,;
										cTipAlt,cNrdCnv,aDadRDA,aCriticas,cLotGui,cNumLib,lHonor,cNumSol,cPadCon,;
										dDtAlta,cHrAlta,cEmgest,cAborto,cTraGra,cComurp,cAtespa,cComnal,cBaipes,cPaareo,;
										cPatnor,cArqImp} )
								Endif

								return cRet

/*/{Protheus.doc} U_CBIITE
Inclui item da guia
@type function
@author PLSTEAM
@since 24.04.12
@version 1.0
/*/
							User Function CBIITE(cLocalExec,cTipoGrv,aItens,aCriticas,cNumLib,aTipPart,cAlias,lHonor,dDatPro,cHora,cOrimov,cMatrAntGen,dDatAcat,lImpTxt,aDadUsr,lnInfEquip, lXmlOrigS, lImpXml)
								LOCAL nI	  	:= 0
								LOCAL nJk		:= 1
								LOCAL nFor	  	:= 0
								LOCAL nForY	  	:= 0
								LOCAL nForCpo 	:= 0
								LOCAL cSeqMov 	:= ""
								LOCAL cCodPad 	:= ""
								LOCAL cCodPro 	:= ""
								LOCAL cDente 	:= ""
								LOCAL cFace 	:= ""
								LOCAL nQtd	  	:= 0
								LOCAL nVlrApr	:= 0
								LOCAL nVlrDif 	:= 0
								LOCAL nPerVia 	:= 0
								LOCAL nVlrGlo 	:= 0
								LOCAL nVlrPag 	:= 0
								LOCAL nVlrTpf 	:= 0
								LOCAL cCodVia 	:= ""
								LOCAL cMacro  	:= ""
								LOCAL cCampoOri	:= ""
								LOCAL cCodGlo 	:= ""
								LOCAL cDesGlo 	:= ""
								LOCAL cSlvPad 	:= ""
								LOCAL cSlvPro 	:= ""
								LOCAL cSlvDes 	:= ""
								LOCAL cSequen	:= ""
								LOCAL cLibCer	:= ""
								LOCAL cEspPro	:= ""
								LOCAL aRetTuss	:= {}
								LOCAL aCodTab	:= {}
								LOCAL aCpoNiv 	:= {}
								LOCAL aCposPad	:= {}
								LOCAL aPartic	:= {}
								LOCAL aTpPar	:= {}
								LOCAL aUnds		:= {}
								LOCAL aUndBd7  	:= {}
								LOCAL aBD7		:= {}
								LOCAL aEspLoc	:= {}
								LOCAL lImpXml	:= FunName() == "PLSA974"
								LOCAL lWeb		:= .F.
								LOCAL lFirst 	:= .T.
								LOCAL cGrpEmpInt:= GetNewPar("MV_PLSGEIN","0050")
								LOCAL nPac		:= 0

								DEFAULT lHonor  	:= .F.
								DEFAULT lImpTxt		:= .F.
								DEFAULT dDatPro 	:= ctod('')
								DEFAULT cHora   	:= ''
								DEFAULT cOrimov 	:= '1'
								DEFAULT cAlias 	 	:= "BD5"
								DEFAULT cMatrAntGen := ""
								DEFAULT dDatAcat    := dDataBase
								DEFAULT aDadUsr 	:= {}
								DEFAULT lnInfEquip 	:= .F.
								DEFAULT lXmlOrigS  	:= .F.
								Default lImpXml		:= .F.
// Indice
								BR8->( DbSetOrder(1) ) //BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN

// Ajusta a descricao e tpproc dos itens
								For nFor := 1 To Len(aItens)
									aPartic   	:= {}
									lAtuSaldo 	:= .F.
	
									lWeb		:= U_CBRETDAD(aItens[nFor],"RPC",(U_CBRETDAD(aItens[nFor],"TPGRV","1") == "2" ))
	
									cSeqMov 	:= U_CBRETDAD(aItens[nFor],"SEQMOV")
									cCodPad 	:= U_CBRETDAD(aItens[nFor],"CODPAD")
									cCodPro 	:= U_CBRETDAD(aItens[nFor],"CODPRO")
									cDesPro 	:= U_CBRETDAD(aItens[nFor],"DESPRO")
	
									nVlrGlo 	:= U_CBRETDAD(aItens[nFor],"VALGLO",0)
									nVlrPag 	:= U_CBRETDAD(aItens[nFor],"VALPAG",0)
									nVlrTpf 	:= U_CBRETDAD(aItens[nFor],"VALTPF",0)

									nVlrApr		:= U_CBRETDAD(aItens[nFor],"VALOR",0)
									nVlrApr		:= U_CBRETDAD(aItens[nFor],"VLRAPR",nVlrApr)
									nVlrDif		:= U_CBRETDAD(aItens[nFor],"VLRDIF",nVlrDif)
	
									nQtd		:= U_CBRETDAD(aItens[nFor],"QTD",0)
									aTpPar	 	:= U_CBRETDAD(aItens[nFor],"ATPPAR",{})
									cHorIni 	:= U_CBRETDAD(aItens[nFor],"HORINI",cHora)
									cHorFim 	:= U_CBRETDAD(aItens[nFor],"HORFIM",cHora)
									dDtPro		:= U_CBRETDAD(aItens[nFor],"DATPRO",dDatPro)
									cSlvPad 	:= U_CBRETDAD(aItens[nFor],"SLVPAD",'')
									cSlvPro 	:= U_CBRETDAD(aItens[nFor],"SLVPRO",'')
									cSlvDes 	:= U_CBRETDAD(aItens[nFor],"SLVDES",'')
									nPerVia 	:= U_CBRETDAD(aItens[nFor],"PERVIA",0)
									cCodVia 	:= U_CBRETDAD(aItens[nFor],"VIAACE",'')
									cDente  	:= U_CBRETDAD(aItens[nFor],"DENTE","")
									cFace   	:= U_CBRETDAD(aItens[nFor],"FACE","")
									cEspPro 	:= U_CBRETDAD(aItens[nFor],"ESPPRO","")
									cEspPe		:= U_CBRETDAD(aItens[nFor],"ESPPE","")
									aBD7		:= U_CBRETDAD(aItens[nFor],"REGBD7",{})
									aEspItXML	:= U_CBRETDAD(aItens[nFor],"ESPXML",{})
									aPacPro		:= U_CBRETDAD(aItens[nFor],"PACPRO",{})
	
									For nJk := 1 To Len(aTpPar)
		
										aadd(aPartic, {	aTpPar[nJk,1],; 					//[1]
										cSeqMov,;							//[2]
										cCodPad + cCodPro,;					//[3]
										nVlrApr,;							//[4]
										aTpPar[nJk,5],;						//[5]
										aTpPar[nJk,4],;						//[6]
										aTpPar[nJk,6],;						//[7]
										0,;									//[8]
										Iif(Len(aTpPar[nJk]) >=9,aTpPar[nJk,9],''),;//[9] BD7_CDPFPR
										aTpPar[nJk,2],;						//[10] BD7_CODRDA
										aTpPar[nJk,3],;						//[11]
										Iif(Len(aTpPar[nJk]) >=10,aTpPar[nJk,10],''),;//[12] BD7_ESPEXE
										Iif(Len(aTpPar[nJk]) >=11,aTpPar[nJk,11],{})} )//unidade que posso incluir, se vazio posso todas
									Next
	
									BR8->( DbSetOrder(1) )
									BR8->( MsSeek(xFilial("BR8")+cCodPad+cCodPro) )
	
									BT5->(DbSetOrder(1))
									BT5->(MsSeek(xFilial("BT5")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP)))
	
	// Composicao do Nivel
									aCpoNiv := PLSUpCpoNv(cCodPad,cCodPro,"BD6")
	
	// Grava itens
									BD6->( RecLock("BD6",.T.) )
	
	// Nivel
									For nForY := 1 To Len(aCpoNiv)
										&(aCpoNiv[nForY,1]) := (aCpoNiv[nForY,2])
									Next
	
	// Detalhe
									BD6->BD6_FILIAL := xFilial("BD6")
	
	// Evento
									BD6->BD6_SEQUEN := cSeqMov
									BD6->BD6_CODPAD := cCodPad
	
									If ExistBlock("PLTISESP") .And. !Empty(cEspPe)
										BD6->BD6_CODESP := cEspPe
									Else
										BD6->BD6_CODESP := &(cAlias + "->" + cAlias + "_CODESP")
									Endif
	
									BD6->BD6_ESPEXE	:= BD6->BD6_CODESP
									BD6->BD6_ESPSOL	:= BD6->BD6_CODESP
	
									BD6->BD6_SLVPAD := cSlvPad
									BD6->BD6_CODPRO := cCodPro
									BD6->BD6_SLVPRO := cSlvPro
	
									If !Empty(cDesPro) .and. alltrim(cCodPro) == alltrim(GetNewPar("MV_PLPSPXM","99999994"))
										BD6->BD6_DESPRO := UPPER(cDesPro)
										BD6->BD6_SLVDES := cSlvDes
									Else
										BD6->BD6_DESPRO := BR8->BR8_DESCRI
										BD6->BD6_SLVDES := cSlvDes
									Endif
	
	// Dente e face quando e procedimento de consulta no odontologico
									if !Empty(cDente)
										B04->( DbSetOrder(1) )//B04_FILIAL+B04_CODIGO+B04_TIPO
										if B04->(MsSeek(XFILIAL("B04")+cDente))
											BD6->BD6_DENREG := cDente
											BD6->BD6_DESREG := B04->B04_DESCRI
										endIf
		
									endIf
	
									if !Empty(cFace)
										B09->( DbSetOrder(1) )//B09_FILIAL+B09_FADENT
										if B09->( msSeek(xFilial("B09")+cFace) )
											BD6->BD6_FADENT := cFace
											BD6->BD6_FACDES := B09->B09_FACDES
										endIf
									endIf
	
									BD6->BD6_DTDIGI := dDatAcat
	
									BD6->BD6_NIVEL  := BR8->BR8_NIVEL
									BD6->BD6_QTDPRO := nQtd
									BD6->BD6_VLRAPR := nVlrApr
	
									BD6->BD6_VLRGLO := nVlrGlo
									BD6->BD6_VLRPAG := nVlrPag
									BD6->BD6_VLRTPF := nVlrTpf

									If nVlrDif > 0
										BD6->BD6_VLRDEC := nVlrDif
									Endif
	
									If nVlrDif < 0
										BD6->BD6_VLRDEC := -(nVlrDif)
									Endif
	
									BD6->BD6_PERVIA := nPerVia
									BD6->BD6_VIA 	:= cCodVia
									BD6->BD6_PROCCI := If(BR8->BR8_TIPEVE$"2,3","1","0") //Mesma regra do gatilho do campo BD6_CODPRO no proc contas
	
									If !Empty(BD6->BD6_VIA) .and. BD6->BD6_VIA >= "1"
										BD6->BD6_PROCCI := "1"
									Endif
									If !Empty(dDtPro)
										BD6->BD6_DATPRO := dDtPro
									Endif
									If !Empty(cHorIni)
										BD6->BD6_HORPRO := cHorIni
									Endif
									If !Empty(cHorFim)
										BD6->BD6_HORFIM := cHorFim
									EndIf
	// usuario
									BD6->BD6_OPEORI := BA1->BA1_OPEORI
									BD6->BD6_MATANT := BA1->BA1_MATANT
									BD6->BD6_CODPLA := BA3->BA3_CODPLA
									BD6->BD6_MODCOB := BA3->BA3_MODPAG
									BD6->BD6_TIPUSR := BA3->BA3_TIPOUS
	
	// Complemento
									BD6->BD6_INCAUT := '1'
									BD6->BD6_STATUS := "1"
									BD6->BD6_CHVNIV := ""
									BD6->BD6_NIVAUT := ""
									BD6->BD6_INTERC := '0'
									BD6->BD6_NRAOPE := cNumLib
	// Monta strutura de dados do bd5 para espelhar no bd6
									aCposPad := (cAlias)->( DbStruct() )
	
									For nForCpo := 1 To Len(aCposPad)
										cMacro := ( "BD6->BD6_" + Subs( aCposPad[nForCpo,1],5,10 ) )
		
										If Type(cMacro) <> "U" .And. !(AllTrim("BD6_" + Subs(aCposPad[nForCpo,1],5,10) ) $ "BD6_DATPRO,BD6_HORPRO,BD6_CNPJED,BD6_VLRAPR,BD6_VLRTPF,BD6_VLRPAG,BD6_VLRGLO,BD6_TPRDAE,BD6_QTDAPR,BD6_QTDPRO,BD6_TIPUSR,BD6_RDAEDI,BD6_NOMEDI,BD6_TRDAED,BD6_RPEDI,BD6_ESPEDI,BD6_VLRMAN,BD6_VLRBPR,BD6_CODESP")
			
											cCampoOri := (cAlias)->&( cAlias + "_" + Subs( aCposPad[nForCpo,1],5,10) )
											&(cMacro) := cCampoOri
										EndIf
									Next
	
	// Retorna tabela
									aCodTab := PLSRETTAB(BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_DATPRO,;
										BD6->BD6_CODOPE,BD6->BD6_CODRDA,BD6->BD6_CODESP,BD6->BD6_SUBESP,BD6->(BD6_CODLOC+BD6_LOCAL),;
										BD6->BD6_DATPRO,"1",BD6->BD6_OPEORI,BD6->BD6_CODPLA,"2","1")
	
									If aCodTab[1]
										BD6->BD6_CODTAB := aCodTab[3]
										BD6->BD6_ALIATB := aCodTab[4]
									EndIf
	
	// Verifica se envia para conferencia
									cCodGlo := ""
	
									If Ascan( aCriticas,{|x| x[3]+x[4]+x[5] == BD6->(BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO) } ) > 0
										cCodGlo := aCriticas[nI,1]
										cDesGlo := aCriticas[nI,2]
									Else
										For nI:=1 To Len(aCriticas)
											If Empty(aCriticas[nI,3])
												cCodGlo := aCriticas[nI,1]
												cDesGlo := aCriticas[nI,2]
												Exit
											EndIf
										Next
									EndIf
	// Envia para conferencia
									If !Empty(cCodGlo)
										BD6->BD6_ENVCON := "1"
										BD6->BD6_BLOPAG := "1"
										BD6->BD6_MOTBPG := cCodGlo
										BD6->BD6_DESBPG := cDesGlo
									Else
										BD6->BD6_ENVCON := "0"
										BD6->BD6_BLOPAG := "0"
										BD6->BD6_MOTBPG := ""
										BD6->BD6_DESBPG := ""
									EndIf
	
									If !lImpXml .and. !lWeb .and. !lImpTxt
										BD6->BD6_CONMUS := '0'//desconsidero a guia para tratamento de qtd x periodicidade
									Endif
	
									BD6->BD6_INTERC := If(BA3->BA3_CODEMP==cGrpEmpInt,"1","0")
									BD6->BD6_TIPINT := If(BA3->BA3_CODEMP==cGrpEmpInt,BT5->BT5_TIPOIN,"0")
	
									BD6->( MsUnLock() )
	
									cTipGui := &(cAlias+'->'+cAlias+"_TIPGUI")
	
									If cTipGui $ "01#02#04#06"
										cLibCer := &(cAlias+'->'+cAlias+"_NRLBOR")
									ElseIf cTipGui $ "03#05"
										cLibCer := &(cAlias+'->'+cAlias+"_GUIINT")
									Endif
	
	// Crio novas unidades
									PLSCriaUnd()
	
	//Cria a B43 caso for pacote
									If Len(aPacPro) > 0
										aChvPac := {	BD6->BD6_SEQUEN,;
											BD6->BD6_CODOPE,;
											BD6->BD6_CODLDP,;
											BD6->BD6_CODPEG,;
											BD6->BD6_NUMERO,;
											BD6->BD6_ORIMOV}
		
										For nPac := 1 to Len(aPacPro)
											B43->(Reclock("B43",.T.))
											B43->B43_SEQUEN := aChvPac[1]
											B43->B43_CODOPE := aChvPac[2]
											B43->B43_CODLDP := aChvPac[3]
											B43->B43_CODPEG := aChvPac[4]
											B43->B43_NUMERO := aChvPac[5]
											B43->B43_ORIMOV := aChvPac[6]
											B43->B43_DESPRO := Posicione("BR8",1,xFilial("BR8") + aPacPro[nPac][1] + aPacPro[nPac][2], "BR8_DESCRI")
											B43->B43_CODPAD := aPacPro[nPac][1]
											B43->B43_CODPRO := aPacPro[nPac][2]
											B43->B43_TIPO   := aPacPro[nPac][3]
											B43->B43_VALCH  := aPacPro[nPac][4]
											B43->B43_VALFIX := aPacPro[nPac][5]
											B43->B43_PRINCI := aPacPro[nPac][6]
											B43->B43_NIVPAC := aPacPro[nPac][10]
											B43->( MsUnLock() )
										Next
									EndIf
	
	
	// crio novas unidades
									PLSCriaUnd()
	
	// Complemento do evento
									if lImpTxt
										PLSICOP(cTipGui,aBD7)
									else
										PLS720IBD7('',BD6->BD6_VLPGMA,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODTAB,BD6->BD6_CODOPE,BD6->BD6_CODRDA,;
											BD6->BD6_REGEXE,BD6->BD6_SIGEXE,BD6->BD6_ESTEXE,BD6->BD6_CDPFRE,BD6->BD6_CODESP,BD6->(BD6_CODLOC+BD6_LOCAL),"1",BD6->BD6_SEQUEN,;
											cOrimov,cTipGui,BD6->BD6_DATPRO,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,aPartic,aTipPart,lHonor,dDatAcat,,,,,lnInfEquip, lXmlOrigS,,aEspItXml)
		
		//Cria "UNL" (UNIDADE NAO LOCALIZADA) caso a mesma nao tenha sido criada acima
										BD7->(DbSetOrder(1))
										If !BD7->(MsSeek(xFilial('BD6')+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
			
			//BD7
											PCrB7Gen("UNL")
			
			//BD6
											BD6->(Reclock("BD6",.f.))
											BD6->BD6_ENVCON := "1"
											BD6->BD6_BLOPAG := "1"
											BD6->BD6_MOTBPG := '063'
											BD6->BD6_DESBPG := 'Bloqueio administrativo. Nao foi possivel compor as unidades deste evento'
											BD6->( MsUnLock() )
			
			//Carrega a composição do Evento
											aCompo := PLSCOMEVE(BD6->BD6_CODTAB,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODOPE,BD6->BD6_DATPRO)
			
			//Ajusta as especialidades caso for importacao XML
											If Len(aEspItXML) > 0
												U_CBGrvEspXML("BD7",aEspItXML,aCompo)
											EndIf
			
											aAdd(aUndBd7,"UNL")
										Else
			
			//Carrega a composição do Evento
											aCompo := PLSCOMEVE(BD6->BD6_CODTAB,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODOPE,BD6->BD6_DATPRO)
			
											nRecBD7 := BD7->(Recno())
			//Ajusta as especialidades caso for importacao XML
											If (Len(aEspItXML) > 0 .Or. Len(aUndBD7) == 0)
												U_CBGrvEspXML("BD7",aEspItXML,aCompo,,,aUndBD7)
											EndIf
											BD7->(DbGoTo(nRecBD7))
			
											If PLSPOSGLO(BD6->BD6_CODOPE,__aCdCri099[1],__aCdCri099[2],cLOCALExec)
												aUnds := {}
												While !BD7->(Eof()) .and. xFilial('BD6')+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN) == ;
														BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)
					
					
													nRecBD7 := BD7->(Recno())
													nRecBD6	:= BD6->(Recno())
					
					//Retorna a consulta de duplicidade de pagamento
													cAli063 := GetNextAlias() 								//Nome do Alias
													PlRt063Qry(cAli063,cTipGui,nRecBD6,nRecBD7)	//Executa a consulta
					
													If !(cAli063)->(Eof())
														BD6->(DbGoTo((cAli063)->RECBD6))
														aadd(aUnds,BD7->BD7_CODUNM)
						
														BD7->(RecLock("BD7",.F.))
														BD7->BD7_BLOPAG := "1"
														BD7->BD7_MOTBLO := '063'
														BD7->BD7_DESBLO := 'Bloqueio administrativo. Composicao ja foi informada no protocolo: ' + BD6->BD6_CODPEG + ' na guia: ' + BD6->BD6_NUMERO
														BD7->(MsUnLock())
						
														BD6->(DbGoTo(nRecBD6))
													Endif
					
					//Finaliza a consulta
													IF Select(cAli063) > 0
														(cAli063)->(DbCloseArea())
													Endif
					
													BD7->(DbSkip())
					
												EndDo
				
												If Len(aUnds) > 0
													BD6->( Reclock("BD6",.F.) )
													BD6->BD6_ENVCON := "1"
													BD6->BD6_BLOPAG := "1"
													BD6->BD6_MOTBPG := '063'
													BD6->BD6_DESBPG := 'Bloqueio administrativo. Composicoes ja pagas em outras guias'
													BD6->( MsUnLock() )
												Endif
				
											EndIf
			
										Endif
		
										If alltrim(BD6->BD6_MATANT) == alltrim(cMatrAntGen) //E usuario generico, vou glosar manualmente p ir para conferencia...
											PLSPOSGLO(PLSINTPAD(),__aCdCri091[1],__aCdCri091[2],cLocalExec,'1',cTipoGrv)
											BD6->(RecLock("BD6",.F.))
											BD6->BD6_ENVCON := "1"
											BD6->BD6_BLOPAG := "1"
											BD6->BD6_MOTBPG := __aCdCri091[1]
											BD6->BD6_DESBPG := PLSBCTDESC()
											BD6->(MsUnLock())
											If BD7->(DbSeek(xFilial('BD6')+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
												While !BD7->(Eof()) .and. xFilial('BD6')+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN) == ;
														BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)
					
													BD7->(RecLock("BD7",.F.))
													BD7->BD7_BLOPAG := BD6->BD6_BLOPAG
													BD7->BD7_MOTBLO := BD6->BD6_MOTBPG
													BD7->BD7_DESBLO := BD6->BD6_DESBPG
													BD7->(MsUnLock())
													BD7->(DbSkip())
												Enddo
											Endif
										Endif
		// Atualizo saldo de uma liberacao
		// Aqui tem a seguinte regra se um evento tem HM e neste BD6 que eu acabei
		// de criar nao existe o HM, eu nao atualizo o saldo.. o saldo sempre eh abatido
		// quando se faz o honorario medico, pois podem ter 3 bd6 referentes a um mesmo
		// evento e eu so tenho que abater o saldo 1 vez senao fica com saldo negativo
										aCompo := PLSCOMEVE(BD6->BD6_CODTAB,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODOPE,BD6->BD6_DATPRO)
		
										If Len(aUndBd7) > 0
			
											cUndHM := "HM,HMR,PPM,RCC,CIR"
											If Existblock('PLSUNHMS')
												cUndHM := ExecBlock( 'PLSUNHMS',.F.,.F.,{cUndHM} )
											Endif
			
											If aScan(aCompo,{|x| alltrim(x[1]) $ cUndHM }) > 0//verifica se tem honorario no evento
												For nForY := 1 to Len(aUndBd7)
													If alltrim(aUndBd7[nForY]) $ cUndHM // no evento que eu acabei de criar tem o honorario
														lAtuSaldo := .T.
														exit
													Endif
												Next
											Else
												lAtuSaldo := .T.
											Endif
			
											If !lAtuSaldo
												BD6->( Reclock("BD6",.F.) )
												BD6->BD6_CONMUS := '0'//se nao vou atualizar o saldo significa que essa guia nao conta para quantidade/periodicidade
												BD6->( MsUnLock() )
											Endif
			
											If lAtuSaldo .and. !empty(cLibCer)
												PLSAtuLib(cLibCer,'',BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_QTDPRO,aPartic,cTipGui$"05",cTipGui$"06")
											Endif
										Endif
									endIf
	
									If Existblock('PLSIITE1')
										ExecBlock( 'PLSIITE1',.F.,.F.,{cSeqMov,cCodPad,cCodPro,cDesPro,nVlrApr,nQtd,aTpPar,cHorIni,cHorFim,dDtPro,cSlvPad,cSlvPro,cSlvDes} )
									Endif
	
								Next
								Return

/*/{Protheus.doc} PLSICOP
Composicao da guia BD7
@type function
@author Tulio Cesar
@since 24.04.12
@version 1.0
/*/
							static function PLSICOP(cTipoGuia,aCompo)
								local nInd			:= 0
								local cNoSeApli 	:= getNewPar("MV_PLSNAPL","O")
								local lBD7_DTDIGI   := BD7->(fieldPos("BD7_DTDIGI")) > 0

								default aCompo := {}

								BR8->(dbSetOrder(1))
								BR8->(msSeek(xFilial("BR8")+BD6->(BD6_CODPAD+BD6_CODPRO)))

								BD7->(dbSetOrder(1)) //BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN+BD7_CODUNM+BD7_NLANC

								for nInd := 1 to len(aCompo)
	
									if BD7->( msSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)+aCompo[nInd,2]+aCompo[nInd,3]) )
										loop
									endif
	
									BD7->(recLock("BD7",.t.))
									BD7->BD7_FILIAL 	:= xFilial("BD7")
									BD7->BD7_CODOPE 	:= BD6->BD6_CODOPE
									BD7->BD7_CODLDP 	:= BD6->BD6_CODLDP
									BD7->BD7_CODPEG 	:= BD6->BD6_CODPEG
									BD7->BD7_NUMERO 	:= BD6->BD6_NUMERO
									BD7->BD7_SEQUEN 	:= BD6->BD6_SEQUEN
									BD7->BD7_CODPRO 	:= BD6->BD6_CODPRO
									BD7->BD7_CODPAD 	:= BD6->BD6_CODPAD
									BD7->BD7_LIBERA 	:= BD6->BD6_LIBERA
									BD7->BD7_CC     	:= BD6->BD6_CC
									BD7->BD7_NUMIMP 	:= BD6->BD6_NUMIMP
									BD7->BD7_TIPUSR 	:= BD6->BD6_TIPUSR
									BD7->BD7_PERHES 	:= BD6->BD6_PERHES
									BD7->BD7_LOTGUI 	:= BD6->BD6_LOTGUI
									BD7->BD7_NOMUSR 	:= BD6->BD6_NOMUSR
									BD7->BD7_INTERC 	:= BD6->BD6_INTERC
									BD7->BD7_SEQIMP 	:= BD6->BD6_SEQIMP
									BD7->BD7_ESPSOL 	:= BD6->BD6_ESPSOL
									BD7->BD7_TIPGUI 	:= BD6->BD6_TIPGUI
									BD7->BD7_CID		:= BD6->BD6_CID
									BD7->BD7_OPEUSR 	:= BD6->BD6_OPEUSR
									BD7->BD7_TIPREG 	:= BD6->BD6_TIPREG
									BD7->BD7_MATRIC 	:= BD6->BD6_MATRIC
									BD7->BD7_CODEMP 	:= BD6->BD6_CODEMP
									BD7->BD7_CONEMP 	:= BD6->BD6_CONEMP
									BD7->BD7_SUBCON 	:= BD6->BD6_SUBCON
									BD7->BD7_VERSUB 	:= BD6->BD6_VERSUB
									BD7->BD7_VERCON 	:= BD6->BD6_VERCON
									BD7->BD7_BLOPAG 	:= BD6->BD6_BLOPAG
									BD7->BD7_MOTBLO 	:= BD6->BD6_MOTBPG
									BD7->BD7_DESBLO 	:= BD6->BD6_DESBPG
									BD7->BD7_TPGRV  	:= BD6->BD6_TPGRV
									BD7->BD7_CODPLA 	:= BD6->BD6_CODPLA
									BD7->BD7_ANOPAG 	:= BD6->BD6_ANOPAG
									BD7->BD7_MESPAG 	:= BD6->BD6_MESPAG
									BD7->BD7_DATPRO 	:= BD6->BD6_DATPRO
									BD7->BD7_ORIMOV 	:= BD6->BD6_ORIMOV
									BD7->BD7_CODESP 	:= BD6->BD6_CODESP
									BD7->BD7_DESESP 	:= BAQ->(posicione("BAQ",1,xFilial("BAQ")+BD6->(BD6_OPERDA+BD6_CODESP),"BAQ_DESCRI"))
									BD7->BD7_MODCOB 	:= BA3->BA3_MODPAG
									BD7->BD7_CONMFT 	:= BR8->BR8_CONMFT
	
									if lBD7_DTDIGI
										BD7->BD7_DTDIGI 	:= BD6->BD6_DTDIGI
									endIf
	
									BD7->BD7_LOCATE 	:= BD6->(BD6_CODLOC+BD6_LOCAL)
									BD7->BD7_LOCAL  	:= BD6->BD6_LOCAL
									BD7->BD7_CODLOC 	:= BD6->BD6_CODLOC
									BD7->BD7_FASE		:= BD6->BD6_FASE
									BD7->BD7_SITUAC 	:= BD6->BD6_SITUAC
									BD7->BD7_DESLOC 	:= BD1->(Posicione("BD1",1,xFilial("BD1")+BD6->(BD6_CODOPE+BD6_CODLOC),"BD1_DESLOC"))
									BD7->BD7_PROCCI 	:= if(BR8->BR8_TIPEVE $ "2,3","1","0")
									BD7->BD7_PROBD7 	:= "1"
	
	//Considera o BD6 posicionado!!!
									if findFunction("PLSCLAINS")
										BD7->BD7_CLAINS := PLSCLAINS()
									endif
	
									BD7->BD7_CODTPA := aCompo[nInd,1]
									BD7->BD7_CODUNM := aCompo[nInd,2]
									BD7->BD7_NLANC  := iIf(alltrim(BD7->BD7_CODUNM) $ getNewPar("MV_PLSCAUX","AUX"),strZero(val(aCompo[nInd,3]),2),"")
									BD7->BD7_REFTDE := aCompo[nInd,4]
									BD7->BD7_UNITDE := aCompo[nInd,5]
									BD7->BD7_SIGLA	:= aCompo[nInd,7]
									BD7->BD7_REGPRE	:= aCompo[nInd,8]
									BD7->BD7_ESTPRE	:= aCompo[nInd,9]
									BD7->BD7_NOMPRE	:= BB0->( Posicione("BB0",4,xFilial("BB0")+BD7->(BD7_ESTPRE+BD7_REGPRE+BD7_SIGLA),"BB0_NOME") )
									BD7->BD7_CDPFPR := aCompo[nInd,10]
									BD7->BD7_CODRDA := aCompo[nInd,11]
									BD7->BD7_NOMRDA := aCompo[nInd,12]
									BD7->BD7_ESPEXE := aCompo[nInd,13]
									BD7->BD7_VLRGLO	:= aCompo[nInd,14]
									BD7->BD7_VLRPAG	:= aCompo[nInd,15]
									BD7->BD7_VLRTPF	:= aCompo[nInd,16]
									BD7->BD7_VLRAPR	:= aCompo[nInd,17]
	
									if allTrim(BD7->BD7_CODTPA) <> cNoSeApli .and. (cTipoGuia $ '03,05' .or. BD6->BD6_LIBERA == '1')
										BD7->BD7_SALDO := BD6->BD6_QTDPRO
									endif
	
									BD7->(msUnLock())
								next

								return()

/*/{Protheus.doc} PLSICRI
Inclusao de critica
@type function
@author Tulio Cesar
@since 24.04.12
@version 1.0
/*/
							Static Function PLSICRI(aCriticas,cCodCri,cDescri,cSequen,cCodPad,cCodPro)

								LOCAL aArea 	:= BCT->(getArea())
								LOCAL lAtivo	:= .T.
								LOCAL lUpdLoad	:= .T.
								DEFAULT cSequen	:= ""
								DEFAULT cCodPad := ""
								DEFAULT cCodPro := ""
	
								If BCT->(MSSeek(xFilial("BCT")+PlsIntPad()+cCodCri))
									If BCT->( Fieldpos("BCT_ATIVO"))>0
										If BCT->BCT_ATIVO == "0"
											lAtivo:=.F. //Critica n/ao esta ativa
										Endif
									Endif
		
									If BCT->( Fieldpos("BCT_ENVCOX"))>0
										If BCT->BCT_ENVCOX <> "1"
											lUpdLoad:=.F. // Critica n/ao esta ativa UPLOAD
										Endif
									Endif
		
									If !lAtivo  .and.  !lUpdLoad
										Return // Critica n/ao esta ativa
									Endif
		
								EndIf
	
								RestArea(aArea)
	
	// Se nao existe inclui
								If Ascan( aCriticas,{|x| x[1]+x[3]+x[4]+x[5] == cCodCri+cSequen+cCodPad+cCodPro } ) == 0
									AaDd( aCriticas,{cCodCri,cDescri,cSequen,cCodPad,cCodPro} )
								EndIf

								Return

/*/{Protheus.doc} U_CBIPRF
// Verifica se o profissional existe e cria
@type function
@author Tulio Cesar
@since 24.04.12
@version 1.0
/*/
							User Function CBIPRF(cOpeMov,cCodPSol)
								local cEst	:= BA0->( Posicione("BA0",1, xFilial("BA0") + cOpeMov,"BA0_EST") )
								local nRecBB0	:= 0
// Verifica se existe o profissional
								if !empty( allTrim(cCodPSol) ) .and. len(cCodPSol)<=6
									BB0->( DbSetOrder(1) )//BB0_FILIAL+BB0_CODIGO
								elseIf !empty( allTrim(cCodPSol) ) .and. len(cCodPSol)>=6
									BB0->(dbSetOrder(4))//BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
								endIf
// Cria profissional de saude
								if !BB0->(msSeek( xFilial("BB0")+cCodPSol ) )
	
	//Se não deu Seek na BB0 Verifica se não da Seek no profissional padrão da operadora.
									BB0->(dbSetOrder(7))//BB0_FILIAL+BB0_NUMCR
									if !BB0->(msSeek( xFilial("BB0")+"OPE" + cOpeMov ) )
										BB0->( RecLock("BB0",.T.) )
										BB0->BB0_FILIAL := xFilial("BB0")
										BB0->BB0_VINC   := "1"
										BB0->BB0_CODIGO := BB0->(GetSx8Num("BB0","BB0_CODIGO"))
										BB0->( ConfirmSx8() )
										BB0->BB0_NOME   := "PROFISSIONAL PAD. OPER. " + cOpeMov
										BB0->BB0_CODSIG := GETMV("MV_PLSIGLA")
										BB0->BB0_NUMCR  := "OPE" + cOpeMov
										BB0->BB0_ESTADO := cEst
										BB0->BB0_UF     := cEst
										BB0->BB0_CODOPE := cOpeMov
										BB0->BB0_CODORI := cOpeMov
										BB0->BB0_CGC    := ""
										BB0->( MsUnLock() )
									endif
								EndIf
								nRecBB0 := BB0->(Recno())
// Fim da Funcao
								Return nRecBB0

/*/{Protheus.doc} U_CBRETLDP
Retorna o local de digitacao
@type function
@author Tulio Cesar
@since 17.07.08
@version 1.0
/*/
							User Function CBRETLDP(nLoc)
								LOCAL cCodLdp := "0000"

								do case
	// inclusao manual. nao esta sendo mais utilizado  "MV_PLSLDPAD"
								case nLoc == 1
									cCodLdp := GETNewPar("MV_PLSLDPAD","0001")
	// importacao xml tiss. nao esta sendo mais utilizado  "MV_PLSXMLP"
								case nLoc == 2
									cCodLdp := GetNewPar("MV_PLSXMLP","0002")
	// importacao txt - movimentacao
								case nLoc == 3
									cCodLdp := GetNewPar("MV_PLSTXTP","0003")
	// Digitação Offline
								case nLoc == 4
									cCodLdp := GetNewPar("MV_PLSDIGP","")
	// Local Generico
								case nLoc == 9
									cCodLdp := "9999"
								endCase

								return(cCodLdp)

/*/{Protheus.doc} U_CBDELMOV
Delete registro de movimento de um peg contas e atendimento
@type function
@author Tulio Cesar
@since 17.07.08
@version 1.0
/*/

// comentado devido a não ser chamado em nenhum fonte
/*
							User Function CBDELMOV(cChave,cFase,lTudoOk,cTpGuEx)
								LOCAL lRet  := .f.
								LOCAL lEntrou := .f.
								LOCAL aArea := getArea()
								Local cGuiInt := ''
								Local cTpFat := ''
								Local aUndBd7 := {}
								Local nForY := 1
								Default cTpGuEx   := ""
								Default lTudoOk   :=	.T.
//deleta bea,be2 e beg
								BCI->(dbSetOrder(1))//BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
								if BCI->(msSeek(xFilial("BCI")+cChave)) .and. empty(BCI->BCI_PROCES)
	//atualiza status do peg
									PLSM190Pro(,,,,,,,,,,,.f.,.t.,BCI->(Recno()))
	//verifica se esta em digitacao
									if BCI->BCI_FASE == cFase
										lRet := .t.
		//begin transaction
										begin transaction
			
											BEA->(dbSetOrder(12))//BEA_FILIAL + BEA_OPEMOV + BEA_CODLDP + BEA_CODPEG + BEA_NUMGUI + BEA_ORIMOV
											if BEA->(msSeek(xFilial("BEA")+cChave))
												while BEA->(msSeek(xFilial("BEA")+cChave))
					//deleta be2
													BE2->(dbSetOrder(1))//BE2_FILIAL + BE2_OPEMOV + BE2_ANOAUT + BE2_MESAUT + BE2_NUMAUT + BE2_SEQUEN
													if BE2->(msSeek(xFilial("BE2")+BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT)))
														while BE2->(msSeek(xFilial("BE2")+BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT)))
							//deleta beg
															BEG->(dbSetOrder(1))//BEG_FILIAL + BEG_OPEMOV + BEG_ANOAUT + BEG_MESAUT + BEG_NUMAUT + BEG_SEQUEN
															if BEG->(msSeek(xFilial("BEG")+BE2->(BE2_OPEMOV + BE2_ANOAUT + BE2_MESAUT + BE2_NUMAUT)))
																while BEG->(msSeek(xFilial("BEG")+BE2->(BE2_OPEMOV + BE2_ANOAUT + BE2_MESAUT + BE2_NUMAUT)))
																	BEG->( recLock("BEG",.f.) )
																	BEG->(dbDelete())
																	BEG->( msUnLock() )
																endDo
															endIf
							//deleta be2
															BE2->( recLock("BE2",.f.) )
															BE2->(dbDelete())
															BE2->( msUnLock() )
														endDo
													endIf
					//deleta bea
													BEA->( recLock("BEA",.f.) )
													BEA->(dbDelete())
													BEA->( msUnLock() )
												endDo
											endIf
			//deleta be4,bej e bel
											BE4->(dbSetOrder(1))//BE4_FILIAL + BE4_CODOPE + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO + BE4_SITUAC + BE4_FASE
											if BE4->(msSeek(xFilial("BE4")+cChave))
												cGuiInt := BE4->BE4_GUIINT
												while BE4->(msSeek(xFilial("BE4")+cChave))
					//deleta bej
													BEJ->(dbSetOrder(1))//BEJ_FILIAL + BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT + BEJ_SEQUEN
													if BEJ->(msSeek(xFilial("BEJ")+BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT)))
														while BEJ->(msSeek(xFilial("BEJ")+BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT)))
							//deleta bel
															BEL->(dbSetOrder(1))//BEL_FILIAL + BEL_CODOPE + BEL_ANOINT + BEL_MESINT + BEL_NUMINT + BEL_SEQUEN
															if BEL->(msSeek(xFilial("BEL")+BEJ->(BEJ_FILIAL + BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT)))
																while BEL->(msSeek(xFilial("BEL")+BEJ->(BEJ_FILIAL + BEJ_CODOPE + BEJ_ANOINT + BEJ_MESINT + BEJ_NUMINT)))
																	BEL->( recLock("BEL",.f.) )
																	BEL->(dbDelete())
																	BEL->( msUnLock() )
																endDo
															endIf
							//deleta bej
															BEJ->( recLock("BEJ",.f.) )
															BEJ->(dbDelete())
															BEJ->( msUnLock() )
														endDo
													endIf
					//deleta bqv, bqz
													BQV->(dbSetOrder(1))//BQV_FILIAL + BQV_CODOPE + BQV_ANOINT + BQV_MESINT + BQV_NUMINT + BQV_SEQUEN
													if BQV->(msSeek(xFilial("BQV")+BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT)))
														while BQV->(msSeek(xFilial("BQV")+BE4->(BE4_CODOPE + BE4_ANOINT + BE4_MESINT + BE4_NUMINT)))
							//deleta bqz
															BQZ->(dbSetOrder(1))//BQZ_FILIAL + BQZ_CODOPE + BQZ_ANOINT + BQZ_MESINT + BQZ_NUMINT + BQZ_SEQUEN
															if BQZ->(msSeek(xFilial("BQZ")+BQV->(BQV_CODOPE + BQV_ANOINT + BQV_MESINT + BQV_NUMINT + BQV_SEQUEN)))
																while BQZ->(msSeek(xFilial("BQZ")+BQV->(BQV_CODOPE + BQV_ANOINT + BQV_MESINT + BQV_NUMINT + BQV_SEQUEN)))
																	BQZ->( recLock("BQZ",.f.) )
																	BQZ->(dbDelete())
																	BQZ->( msUnLock() )
																endDo
															endIf
							//deleta bqv
															BQV->( recLock("BQV",.f.) )
															BQV->(dbDelete())
															BQV->( msUnLock() )
														endDo
													endIf
					//deleta be4
													cTpFat := BE4->BE4_TIPFAT
					
													BE4->( recLock("BE4",.f.) )
													BE4->(dbDelete())
													BE4->( msUnLock() )
												endDo
				//limpa as informacoes de alta na solicitacao da internacao
												lExiste := .F.
												cSql := "SELECT * FROM "+RetSqlName("BE4")
												cSql += " WHERE BE4_FILIAL = '"+xFilial("BE4")+"' "
												cSql += " AND BE4_GUIINT = '"+cGuiInt+"' "
												cSql += " AND D_E_L_E_T_ <> '*' "
												PlsQuery(cSql,'TrbS1')
												If !TrbS1->(Eof())
													lExiste := .T.
												Endif
												TrbS1->(DbCloseArea())
												BE4->(dbSetOrder(1))//BE4_FILIAL + BE4_CODOPE + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO + BE4_SITUAC + BE4_FASE
												if !EMPTY(cGuiInt) .AND. BE4->(msSeek(xFilial("BE4")+cGuiInt))
													BE4->(RecLock("BE4",.F.))
													BE4->BE4_DTALTA := ctod('')
													BE4->BE4_HRALTA := ""
													BE4->BE4_TIPFAT := ""
					
													If cTpFat == "T" .or. !lExiste//se estou excluindo uma guia de resumo cujo faturamento eh do tipo total eu limpo a data de internacao
						//ou se nao existe mais nenhuma guia de resumo para esta solicitacao
														BE4->BE4_DATPRO := CTOD('')
														BE4->BE4_HORPRO := ''
													Endif
													BE4->(MsUnLock())
												endIf
											endIf
			//deleta bd7
											BD7->(dbSetOrder(1))//BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_SEQUEN + BD7_CODUNM + BD7_NLANC
											if BD7->(msSeek(xFilial("BD7")+cChave))
												while BD7->(msSeek(xFilial("BD7")+cChave))
					
													If (nO:=aScan(aUndBd7,{|x| alltrim(x[1]) == alltrim(BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO))  })) > 0
														aadd(aUndBd7[nO][2],BD7->BD7_CODUNM)
													Else
														aadd(aUndBd7,{BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO),{BD7->BD7_CODUNM}})
													Endif
													BD7->( recLock("BD7",.f.) )
													BD7->(dbDelete())
													BD7->( msUnLock() )
												endDo
											endIf
			//deleta bd5
											aRecBE2 := {}
											BD5->(dbSetOrder(1))//BD5_FILIAL + BD5_CODOPE + BD5_CODLDP + BD5_CODPEG + BD5_NUMERO + BD5_SITUAC + BD5_FASE + dtos(BD5_DATPRO) + BD5_OPERDA + BD5_CODRDA
											if BD5->(msSeek(xFilial("BD5")+cChave))
												while BD5->(msSeek(xFilial("BD5")+cChave))
													nRecBD5 := BD5->(Recno())
													nOrdBD5	:= BD5->(IndexOrd())
													If !Empty(BD5->BD5_NRLBOR) .and. BD5->BD5_TIPGUI $ "02"//ainda nao trato saldo para honorario individual, so SPSDAT - daher 23/04/2013
						// Se e uma excluao de autorizacao baseada em uma liberacao refaz saldo
														BD6->(DbSetORder(1))
														if BD6->(msSeek(xFilial("BD6")+cChave+BD5->BD5_NUMERO))
															while !BD6->(Eof()) .and. xFilial("BD6")+cChave+BD5->BD5_NUMERO == BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)
								// Atualizo saldo de uma liberacao
								// Aqui tem a seguinte regra se um evento tem HM e neste BD6 que eu acabei
								// de criar nao existe o HM, eu nao atualizo o saldo.. o saldo sempre eh abatido
								// quando se faz o honorario medico, pois podem ter 3 bd6 referentes a um mesmo
								// evento e eu so tenho que abater o saldo 1 vez senao fica com saldo negativo
																lAtuSaldo := .F.
																aCompo := PLSCOMEVE(BD6->BD6_CODTAB,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODOPE,BD6->BD6_DATPRO)
																If Len(aUndBd7) > 0
									
																	nO := aScan(aUndBd7,{|x| alltrim(x[1]) == alltrim(BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO))  })
									
																	cUndHM := "HM,HMR,PPM,RCC,CIR"
																	If Existblock('PLSUNHMS')
																		cUndHM := ExecBlock( 'PLSUNHMS',.F.,.F.,{cUndHM} )
																	Endif
									
																	If aScan(aCompo,{|x| alltrim(x[1]) $ cUndHM }) > 0 .and. nO > 0//verifica se tem honorario no evento
																		For nForY := 1 to Len(aUndBd7[nO][2])
																			If alltrim(aUndBd7[nO][2][nForY]) $ cUndHM // no evento que eu acabei de criar tem o honorario
																				lAtuSaldo := .T.
																				exit
																			Endif
																		Next
																	Else
																		lAtuSaldo := .T.
																	Endif
									
																	If !lAtuSaldo
																		BD6->(DbSkip())
																		loop
																	Endif
																Endif
								
								// Seleciona todos os registros da execucao que esta sendo deletada
																cSQL := "SELECT BE2_SEQUEN, BE2_CODPAD, BE2_CODPRO, BE2_QTDPRO, BE2_SALDO, R_E_C_N_O_ FROM " + BE2->( RetSQLName("BE2") )
																cSQL += " WHERE BE2_FILIAL = '" + xFilial('BE2')				+"' "
																cSQL += " 	AND BE2_OPEMOV = '" + Subs(BD5->BD5_NRLBOR,1,4)		+"' "
																cSQL += " 	AND BE2_ANOAUT = '" + Subs(BD5->BD5_NRLBOR,5,4)		+"' "
																cSQL += " 	AND BE2_MESAUT = '" + Subs(BD5->BD5_NRLBOR,9,2)		+"' "
																cSQL += " 	AND BE2_NUMAUT = '" + Subs(BD5->BD5_NRLBOR,11,8)	+"' "
																cSQL += " 	AND BE2_CODPAD = '" + BD6->BD6_CODPAD				+"' "
																cSQL += " 	AND BE2_CODPRO = '" + BD6->BD6_CODPRO				+"' "
																cSQL += " 	AND BE2_STATUS = '1' AND BE2_LIBERA = '1' "
																cSQL += " 	AND D_E_L_E_T_ = ' '"
								// Cria area de trabalho
																cSQL := ChangeQuery(cSQL)
																dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbBE2",.F.,.T.)
								// While nos itens da execucao
																While !TrbBE2->( Eof() )
									//aqui eu garanto que um mesmo be2 nunca vai ser reprocessado
									//aqui eu garanto que se ele ainda tem saldo para abeter
																	If aScan(aRecBE2,{|x| x == TrbBE2->R_E_C_N_O_}) <> 0 .and. TrbBE2->BE2_SALDO == 0
																		TrbBE2->(DbSkip())
																		loop
																	Endif
									
																	aadd(aRecBE2,TrbBE2->R_E_C_N_O_)
									// Quantidade do procedimento na execucao
																	nQtdPro := BD6->BD6_QTDPRO
																	cSequen := TrbBE2->BE2_SEQUEN
																	PLSATUSS( nil ,.F.,nil,nil,"1",.F.,BD5->BD5_NRLBOR + cSequen,6,nil,nil,1,nQtdPro )
																	lEntrou := .T.
									
																	TrbBE2->( DbSkip() )
																EndDo
																TrbBE2->( DbCloseArea() )
								// CloseArea
																BD6->(DbSkip())
															Enddo
														Endif
														If PLSSALDO(BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV),BD5->BD5_NRLBOR)
															BEA->(dbSetOrder(1))
															If BEA->(msSeek(xFilial("BEA")+BD5->BD5_NRLBOR))
																PLSATUCS('1')
															Endif
														EndIf
													EndIf
													BD5->(DbGoTo(nRecBD5))
													BD5->(DbSetORder(nOrdBD5))
					
													BD5->( recLock("BD5",.f.) )
													BD5->(dbDelete())
													BD5->( msUnLock() )
												endDo
											endIf
			
			//deleta bd6
											BD6->(dbSetOrder(1))//BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV + BD6_SEQUEN + BD6_CODPAD + BD6_CODPRO
											if BD6->(msSeek(xFilial("BD6")+cChave))
												while BD6->(msSeek(xFilial("BD6")+cChave))
													BD6->( recLock("BD6",.f.) )
													BD6->(dbDelete())
													BD6->( msUnLock() )
												endDo
											endIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
			//³deleta B43
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
											B43->(dbSetOrder(1))//B43_FILIAL+B43_CODOPE+B43_CODLDP+B43_CODPEG+B43_NUMERO+B43_ORIMOV+B43_SEQUEN
											if B43->(msSeek(xFilial("B43")+cChave))
												while B43->(msSeek(xFilial("B43")+cChave))
													B43->( recLock("B43",.f.) )
													B43->(dbDelete())
													B43->( msUnLock() )
												endDo
											endif
			
											If lTudoOk
												BCI->( recLock("BCI",.f.) )
												BCI->(dbDelete())
												BCI->( msUnLock() )
											EndIf
			
											If	!lTudoOk .And. PLSALIASEX("B0Y")
												If cTpGuEx $ "03"
													cCampo := "BE4_NUMERO"
												Else
													cCampo := "BD5_NUMERO"
												Endif
				
												DBSelectArea("B0Y")
												B0Y->( DbSetOrder(1) )  //B0Y_FILIAL + B0Y_CAMPO + B0Y_CHAVE
												If B0Y->( MsSeek( xFilial("B0Y")+cCampo+cChave ) )
													B0Y->( recLock("B0Y",.F.) )
													B0Y->(dbDelete())
													B0Y->( msUnLock() )
												EndIf
											EndIf
			
			//end transaction
										end transaction
									endIf
								endIf

								restArea(aArea)
								return(lret)
*/

/*/{Protheus.doc} U_CBATUPEG
Atualiza status do PEG
@type function
@author Tulio Cesar
@since 17.07.08
@version 1.0
/*/
							User Function CBATUPEG(cOpeOri,cLdpOri,cPegOri,cGuiOri,cOpeDes,cLdpDes,cPegDes,cAliCab)
								LOCAL aArea 	:= getArea()
								LOCAL nI		:= 0
								LOCAL cSql		:= ""
								LOCAL cNumGuia	:= ""
								LOCAL lErro		:= .f.
								LOCAL lMudComp	:= .t.
								LOCAL aAlias	:= {}
								LOCAL aIndices  := {}
								LOCAL nInd      := 0
								DEFAULT cAliCab := ""
//alias tratados
								aadd(aAlias,"BD5") ; aadd(aIndices,1)
								aadd(aAlias,"BD7") ; aadd(aIndices,1)
								aadd(aAlias,"BD6") ; aadd(aIndices,1)
								aadd(aAlias,"BDX") ; aadd(aIndices,1)
								aadd(aAlias,"BE2") ; aadd(aIndices,13)
								aadd(aAlias,"BEA") ; aadd(aIndices,12)
								aadd(aAlias,"BE4") ; aadd(aIndices,13)


								If !Empty(cAliCab)
									cNumGuia := PLSA500NUM(cAliCab,cOpeDes,cLdpDes,cPegDes)
								Endif

								cAno:= BCI->BCI_ANO
								cMes:= BCI->BCI_MES
//monta update da bd7
								for nI:=1 to len(aAlias)
	//alias
									cAlias 	:= aAlias[nI]
									nInd    := aIndices[nI]
									lErro 	:= .f.
	//verifica se o alias não esta disponivel (exemplo nova funcionalidade que não esta no ambiente do cliente)
									If ! PLSALIASEX(cAlias)
										Loop
									Endif
	// Se nao tem registro para a chave ignora
									DbSelectArea(cAlias)
									DbSetorder(nInd)
									If ! DbSeek(xFilial(cAlias)+cOpeOri+cLdpOri+cPegOri)
										Loop
									Endif
	//select
									cSql := " SELECT R_E_C_N_O_ REC "
									cSql += "   FROM "+retSQLName(cAlias)
									cSql += "  WHERE "+cAlias+"_FILIAL = '"+xFilial(cAlias)+"' "
	//verifica se e codope ou opemov
									if (cAlias)->( fieldPos(cAlias+"_CODOPE") ) > 0
										cSql += "    AND "+cAlias+"_CODOPE = '"+cOpeOri+"' "
									elseIf (cAlias)->( fieldPos(cAlias+"_OPEMOV") ) > 0
										cSql += "    AND "+cAlias+"_OPEMOV = '"+cOpeOri+"' "
									else
										lErro := .t.
									endIf
	
									if (cAlias)->( fieldPos(cAlias+"_CODLDP") ) > 0
										cSql += "    AND "+cAlias+"_CODLDP = '"+cLdpOri+"' "
									Endif
	
									if (cAlias)->( fieldPos(cAlias+"_CODPEG") ) > 0
										cSql += "    AND "+cAlias+"_CODPEG = '"+cPegOri+"' "
									Endif
	//verifica se e numero ou numgui
									if (cAlias)->( fieldPos(cAlias+"_NUMERO") ) > 0
										cSql += "    AND "+cAlias+"_NUMERO = '"+cGuiOri+"' "
									elseIf (cAlias)->( fieldPos(cAlias+"_NUMGUI") ) > 0
										cSql += "    AND "+cAlias+"_NUMGUI = '"+cGuiOri+"' "
									else
										lErro := .t.
									endIf
	
									cSql += "    AND D_E_L_E_T_ = ' ' "
	
	//se nao tem erro
									if !lErro
		//abre a area
										PlsQuery(cSql,"U_CBATUPEG")
										while !U_CBATUPEG->(eof())
			//posiciona no registro
											(cAlias)->(dbGoTo(U_CBATUPEG->REC))
			
											if !(cAlias)->(eof())
				
												(cAlias)->(recLock(cAlias,.f.))
				
												(cAlias)->&(cAlias+"_CODOPE") := cOpeDes
												(cAlias)->&(cAlias+"_CODLDP") := cLdpDes
												(cAlias)->&(cAlias+"_CODPEG") := cPegDes
												If ExistBLock("PLMDCPTR")
													lMudComp := ExecBlock("PLMDCPTR",.F.,.F.)
												Endif
				
												If lMudComp
													(cAlias)->&(cAlias+"_MESPAG") := cMes
													(cAlias)->&(cAlias+"_ANOPAG") := cAno
												Endif
				
												If !empty(cNumGuia)
													if (cAlias)->( fieldPos(cAlias+"_NUMERO") ) > 0
														(cAlias)->&(cAlias+"_NUMERO") := cNumGuia
													elseIf (cAlias)->( fieldPos(cAlias+"_NUMGUI") ) > 0
														(cAlias)->&(cAlias+"_NUMGUI") := cNumGuia
													endIf
												endif
												(cAlias)->(msUnLock())
				
											endIf
											U_CBATUPEG->(DbSkip())
										enddo
										U_CBATUPEG->(DbCloseArea())
									endIf
								next

								restArea(aArea)
								return(nil)

/*/{Protheus.doc} PCrB7Gen
Cria um BD7 para casos onde a unidade de medida nao foi localizada de acordo com
a participacao enviada no arquivo
@type function
@author TOTVS
@since 28.01.13
@version 1.0
/*/
							static function PCrB7Gen(cCodUnm)
								LOCAL cProBD7Ori := ""
								LOCAL cCodEsp	 := ""
								LOCAL cCodInt	 := PLSINTPAD()
								BR8->(DbSetOrder(1))
								BR8->(MsSeek(xFilial("BR8")+BD6->(BD6_CODPAD+BD6_CODPRO)))
								BAU->(DbSetOrder(1))
								BAU->(MsSeek(xFilial("BAU")+BD6->BD6_CODRDA))

								BD7->(RecLock("BD7",.T.))
								BD7->BD7_FILIAL := xFilial("BD7")
								BD7->BD7_CODOPE := BD6->BD6_CODOPE
								BD7->BD7_CODLDP := BD6->BD6_CODLDP
								BD7->BD7_CODPEG := BD6->BD6_CODPEG
								BD7->BD7_NUMERO := BD6->BD6_NUMERO
								BD7->BD7_SEQUEN := BD6->BD6_SEQUEN
								BD7->BD7_CODUNM := cCodUnm
								BD7->BD7_CODPRO := BD6->BD6_CODPRO
								BD7->BD7_CODPAD := BD6->BD6_CODPAD
								BD7->BD7_LIBERA := BD6->BD6_LIBERA
								BD7->BD7_CC     := BD6->BD6_CC
								BD7->BD7_NUMIMP := BD6->BD6_NUMIMP
								BD7->BD7_NLANC  := ""
								BD7->BD7_ORIMOV := BD6->BD6_ORIMOV
								BD7->BD7_FASE   := BD6->BD6_FASE
								BD7->BD7_SITUAC := BD6->BD6_SITUAC
								BD7->BD7_MODCOB := BD6->BD6_MODCOB
								BD7->BD7_TIPUSR := BD6->BD6_TIPUSR

								BD7->BD7_LOTGUI := BD6->BD6_LOTGUI
								BD7->BD7_CLAINS := PLSCLAINS() //Considera o BD6 posicionado!!!
								BD7->BD7_NOMUSR := BD6->BD6_NOMUSR
								BD7->BD7_INTERC := BD6->BD6_INTERC
								BD7->BD7_SEQIMP := BD6->BD6_SEQIMP
								If Empty(BD7->BD7_PROBD7)
									cProBD7Ori      := "0"
									BD7->BD7_PROBD7 := "1"
								Else
									cProBD7Ori := BD7->BD7_PROBD7
								Endif
								BD7->BD7_TIPGUI := BD6->BD6_TIPGUI
								BD7->BD7_CID    := BD6->BD6_CID
								BD7->BD7_OPEUSR := BD6->BD6_OPEUSR
								BD7->BD7_CODESP := BD6->BD6_CODESP
								BD7->BD7_DESESP := BAQ->(Posicione("BAQ",1,xFilial("BAQ")+BD6->(BD6_OPERDA+BD6_CODESP),"BAQ_DESCRI"))
								BD7->BD7_TIPREG := BD6->BD6_TIPREG
								BD7->BD7_MATRIC := BD6->BD6_MATRIC
								BD7->BD7_CODEMP := BD6->BD6_CODEMP
								BD7->BD7_CONMFT := BR8->BR8_CONMFT
								BD7->BD7_PROCCI := If(BR8->BR8_TIPEVE$"2,3","1","0")
								BD7->BD7_CONEMP := BD6->BD6_CONEMP
								BD7->BD7_SUBCON := BD6->BD6_SUBCON
								BD7->BD7_VERSUB := BD6->BD6_VERSUB
								BD7->BD7_VERCON := BD6->BD6_VERCON
								BD7->BD7_FASE   := BD6->BD6_FASE
								BD7->BD7_SITUAC := BD6->BD6_SITUAC
								BD7->BD7_TPGRV  := BD6->BD6_TPGRV
								BD7->BD7_CODPLA := BD6->BD6_CODPLA
								BD7->BD7_ANOPAG := BD6->BD6_ANOPAG
								BD7->BD7_MESPAG := BD6->BD6_MESPAG
								BD7->BD7_DATPRO := BD6->BD6_DATPRO
								BD7->BD7_INTERC := BD6->BD6_INTERC
								BD7->BD7_MODCOB := BD6->BD6_MODCOB
								BD7->BD7_CONMFT := BR8->BR8_CONMFT

								BD7->BD7_CODRDA := BAU->BAU_CODIGO
								BD7->BD7_LOCATE := BD6->(BD6_CODLOC+BD6_LOCAL)
								BD7->BD7_CODLOC := BD6->BD6_CODLOC
								BD7->BD7_LOCAL  := BD6->BD6_LOCAL
								BD7->BD7_DATPRO := BD6->BD6_DATPRO
								BD7->BD7_DESLOC := BD1->(Posicione("BD1",1,xFilial("BD1")+BD6->(BD6_CODOPE+BD6_CODLOC+BD6_LOCAL),"BD1_DESLOC"))

								If cProBD7Ori <> "1"
									BD7->BD7_NOMRDA := BAU->BAU_NOME
								Endif

								If !Empty(BD6->BD6_CDPFRE)
									BD7->BD7_REGPRE := BD6->BD6_REGEXE
									BD7->BD7_SIGLA  := BD6->BD6_SIGEXE
									BD7->BD7_ESTPRE := BD6->BD6_ESTEXE
									BD7->BD7_NOMPRE := BR8->( Posicione("BB0",1,xFilial("BB0")+BD6->BD6_CDPFRE,"BB0_NOME") )
								EndIf
								BD7->BD7_CDPFPR := BD6->BD6_CDPFRE

								aRetEspec := PLSGTESPP(BD7->BD7_CODRDA)

								If Empty(BD6->BD6_CODESP)
									cCodEsp := aRetEspec[1]
								Else
									cCodEsp := BD6->BD6_CODESP
								EndIf

								BD7->BD7_CODESP := cCodEsp
								BD7->BD7_DESESP := BAQ->(Posicione("BAQ",1,xFilial("BAQ")+cCodInt+cCodEsp,"BAQ_DESCRI"))

								BD7->(MsUnLock())

								Return

/*/{Protheus.doc} PlRetCidGe
Retorna um codigo de cid Generico
@type function
@author Daher
@since 03.07.05
@version 1.0
/*/
							static function xRetCidGe()
								LOCAL cCodCid := GetNewPar("MV_PLCDGEN","00000000")
								BA9->(DbSetOrder(1))
								If !BA9->(MsSeek(xFilial("BA9")+cCodCid))
									BA9->(RecLock("BA9",.T.))
									BA9->BA9_CODDOE := cCodCid
									BA9->BA9_DOENCA := "CID GENERICO PARA USO NO XML IMPORTACAO"
									BA9->BA9_ABREVI := "CID GENERICO"
									BA9->(MsUnlock())
								endif
								return cCodCid

/*/{Protheus.doc} PLBLD6D7
Bloqueio do BD6 e BD7
@type function
@author TOTVS
@since 17.07.08
@version 1.0
/*/
							User Function U_CPLBLD6D7(cChave,cCodCri,cDesCri)
								LOCAL lBloq := .T.

								If BD7->( IndexOrd() ) <> 1
									BD7->( DbSetOrder(1) ) //BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_SEQUEN + BD7_CODUNM + BD7_NLANC
								EndIf

								If BD7->( MsSeek( xFilial("BD7")+cChave ) )
	
									While !BD7->( Eof() ) .And. xFilial("BD7")+cChave == BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)
		
										If AllTrim(BD7->BD7_CODTPA) <> ''
											lBloq := .F.
											Exit
										EndIf
		
										If lBloq
											BD7->( RecLock("BD7",.F.) )
											BD7->BD7_BLOPAG := "1"
											BD7->BD7_MOTBLO := cCodCri
											BD7->BD7_DESBLO := cDesCri
											BD7->( MsUnLock() )
										EndIf
		
										BD7->( DbSkip() )
									EndDo
	
								EndIf
// Bloqueio de pagamento e cobranca para itens nao encontrados
								If lBloq
									BD6->( RecLock("BD6",.F.) )
									BD6->BD6_ENVCON := "1"
	
									BD6->BD6_BLOPAG := "1"
									BD6->BD6_MOTBPG := cCodCri
									BD6->BD6_DESBPG := cDesCri
	
									BD6->BD6_BLOCPA := "1"
									BD6->BD6_MOTBPF := cCodCri
									BD6->BD6_DESBPF := cDesCri
									BD6->( MsUnLock() )
								EndIf
// Log do procedimento bloqueado
								PlsLogFil(Space(03)+"PROCEDIMENTO [ "+BD6->BD6_CODPAD+" - "+AllTrim(BD6->BD6_CODPRO)+" ] BLOQUEADO NA CONTA MEDICA" ,__PLSFLOGX)
								Return

/*/{Protheus.doc} U_CXMOVTISS
Atualiza os dados dos vetores de aDados e aItens do XMOV
com os valores das terminologias TISS
@type function
@author Rogerio Tabosa
@since 20.01.14
@version 1.0
/*/
							User Function CXMOVTISS(aDados, aItens, aCpoTermo)
								Local nI 			:= 0 // Variavel de contador
								Local nJ 			:= 0 // Variavel de contador
								Local nP 			:= 0 // Variavel de posição do array
								Local cVarVinc	:= "" // Guardo valor retornado do vinculo
								Local cSlvPad		:= "" // Guardo valor retornado do vinculo
//Array com os campos do XMOV e a tabela correspondente
								Default aCpoTermo := {		{ "TIPSAI", "39", "BEA"},; //Tipo de Saida
								{ "TIPATE", "50", ""   },; //Tipo de atendimento
								{ "TIPFAT", "55", ""   },; //Tipo de faturamento
								{ "INDACI", "36", "BEA"},; //Indicador de acidente
								{ "CARSOL", "23", "BDR"   },; //Carater da solicitaçao//
								{ "TIPCON", "52", ""   },; //Tipo de consulta
								{ "AUNMED", "60", ""   },; //Unidade de medida
								{ "CODPAD", "87", "BR4"},; //Tabela padrao
								{ "CODPRO", "",   "BR8"},; //procedimento
								{ "TECUT" , "48", ""   },; //Tecnica utilizada
								{ "CODESP", "24", "BAQ"}}  //Tecnica utilizada
								PRIVATE aErrVarVin := {.F., "", "", ""}

//U_CBRETDAD( aDados,"IMPXML",.F. ) //U_CBRETDAD(aItens[nFor],"SEQMOV") //cCodPad := PLSVARVINC('87', 'BR4', cCodPad)
// BUSCO OS CAMPOS NO ADADOS E ATUALIZO ELES COM PLSVARVINC
								If Len(aCpoTermo) > 0
									For nI := 1 to Len(aCpoTermo)
										If (nP:= Ascan( aDados,{|x| x[1] == aCpoTermo[nI,1] } )) > 0 // Busco no aDados
											cVarVinc := PLSVARVINC(aCpoTermo[nI,2], IIf(!Empty(aCpoTermo[nI,3]),aCpoTermo[nI,3],"") , aDados[nP,2])
											If !Empty(cVarVinc)
												aDados[nP,2] := cVarVinc
											EndIf
										EndIf
									Next nI
								EndIf
								For nJ := 1 To Len(aItens)
									If Len(aCpoTermo) > 0
										For nI := 1 to Len(aCpoTermo)
											If (nP:= Ascan( aItens[nJ],{|x| x[1] == aCpoTermo[nI,1] } )) > 0 // Busco no aDados
												If aItens[nJ,nP,1] == "CODPAD"
													cSlvPad := U_CBRETDAD( aItens[nJ],"CODPAD",.F. )
												Endif
												If aItens[nJ,nP,1] == "CODPRO"
													If Empty(cSlvPad)
														cSlvPad := U_CBRETDAD( aItens[nJ],"CODPAD",.F. )
													EndIf
													cVarVinc := PLSVARVINC(cSlvPad, IIf(!Empty(aCpoTermo[nI,3]),aCpoTermo[nI,3],"") , aItens[nJ,nP,2])
													If !Empty(cVarVinc)
														aItens[nJ,nP,2] := cVarVinc
													EndIf
												Else
													cVarVinc := PLSVARVINC(aCpoTermo[nI,2], IIf(!Empty(aCpoTermo[nI,3]),aCpoTermo[nI,3],"") , aItens[nJ,nP,2])
													If !Empty(cVarVinc)
														aItens[nJ,nP,2] := cVarVinc
													EndIf
												EndIf
											EndIf
										Next nI
									EndIf
								Next nJ


								Return()

/*/{Protheus.doc} VPerConPTU
Verifica periodicidade para atendimento de intercambio Portal
@type function
@author TOTVS
@since 12.03.14
@version 1.0
/*/
							Static Function VPerConPTU(aDados,aItens,aDadRDA,aDadUsr,aDadIte,aCriticas,aEventosNeg)
								Local nFor      := 0
								Local aRetFun   := {}
								Local aTrb      := {}
								Local cLibEsp   := "0"
								Local cAuditoria:= "0"
								Local lContinua := .F.
								Local cMatrUsr  := U_CBRETDAD(aDados,"USUARIO")
								Local dData     := U_CBRETDAD(aDados,"DATPRO")
								Local cHora     := U_CBRETDAD(aDados,"HORAPRO")
								Local cCid      := U_CBRETDAD(aDados,"CIDPRI","")
								Local cCodPad	:= U_CBRETDAD(aItens[1],"CODPAD")
								Local cCodPro   := U_CBRETDAD(aItens[1],"CODPRO")
								Local cSeqMov   := U_CBRETDAD(aItens[1],"SEQMOV")
								Local nQtdSol   := U_CBRETDAD(aItens[1],"QTD",0)
								Local cOrigem   := U_CBRETDAD( aDados,"ORIGEM","1" )
								Local cNumImp   := U_CBRETDAD( aDados,"NUMIMP","" )
								Local nQtdAut   := U_CBRETDAD(aItens[1],"QTDAUT",0)
								Local cDescri	:= U_CBRETDAD(aItens[1],"DESCRI","")
								Local cSlvPad	:= U_CBRETDAD(aItens[1],"SLVPAD","")
								Local cSlvPro	:= U_CBRETDAD(aItens[1],"SLVPRO","")

								aRetFun := PLSTratPer(cMatrUsr,dData,cHora,cCodPad,cCodPro,nQtdSol,nil, nil,"1",aDadRDA,nil,;
									cCid,.T.,"1"/*cNivel*/,aDadUsr,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,cSeqMov ,nil)

								lContinua := aRetFun[1]
								aTrb 	  := aRetFun[2]

								If !lContinua
									For nFor := 1 to len(aTrb)
										AaDd( aCriticas,{cSeqMov,aTrb[nFor,1],AllTrim(aTrb[nFor,2])+Iif(Len(aTrb[nFor])>=3 .And. !Empty(aTrb[nFor,3]),' ( '+aTrb[nFor,3]+' ) ',''),aTrb[nFor,6],aTrb[nFor,7],"",""} )
									Next
	// Matriz
									U_CBDADITE(aDadIte,aItens[1],cOrigem,cLibEsp,cAuditoria,cNumImp,,dData,aDadRda)
									AaDd(aEventosNeg,{cSeqMov,cCodPad,cCodPro,nQtdSol,cDescri,nQtdAut,"","","",cSlvPad,cSlvPro})
								EndIf

								Return(lContinua)

/*/{Protheus.doc} criMatPT17
Critica itens da solicitacao pois a matricula do usuario de
intercambio nao tem 17 caracteres
@type function
@author TOTVS
@since 28.05.14
@version 1.0
/*/
							Static Function criMatPT17(aDados,aItens,aDadRDA,aDadUsr,aDadIte,aCriticas,aEventosNeg,cLOCALExec)
								LOCAL nFor := 0
								LOCAL nX   := 0
								LOCAL bRetErrPTU  := { |cNivCri,cChaveAut| {.F.,aCodCri,cNivCri,cChaveAut} }
								LOCAL dData
								LOCAL cHora
								LOCAL cCid
								LOCAL cCdTbPd
								LOCAL cCodPro
								LOCAL cSeqMov
								LOCAL nQtdSolaCodCri
								LOCAL cOrigem
								LOCAL cNumImp
								LOCAL nQtdAut
								LOCAL cDescri
								LOCAL aCodCri := {}
								LOCAL aTrb    := {}
								LOCAL cLibEsp   := "0"
								LOCAL cAuditoria:= "0"

								For nX := 1 to len(aItens)
									aCodCri   := {}
									dData     := U_CBRETDAD(aDados,"DATPRO")
									cHora     := U_CBRETDAD(aDados,"HORAPRO")
									cCid      := U_CBRETDAD(aDados,"CIDPRI","")
									cCdTbPd   := U_CBRETDAD(aItens[nX],"CODPAD")
									cCodPro   := U_CBRETDAD(aItens[nX],"CODPRO")
									cSeqMov   := U_CBRETDAD(aItens[nX],"SEQMOV")
									nQtdSol   := U_CBRETDAD(aItens[nX],"QTD",0)
									cOrigem   := U_CBRETDAD(aDados,"ORIGEM","1" )
									cNumImp   := U_CBRETDAD(aDados,"NUMIMP","" )
									nQtdAut   := U_CBRETDAD(aItens[nX],"QTDAUT",0)
									cDescri   := U_CBRETDAD(aItens[nX],"DESCRI","")
									cSlvPad   := U_CBRETDAD(aItens[nX],"SLVPAD","")
									cSlvPro   := U_CBRETDAD(aItens[nX],"SLVPRO","")
									AaDd(aCodCri,{__aCdCri210[1],PLSBCTDESC(),"",BCT->BCT_NIVEL,BCT->BCT_TIPO,cCdTbPd,cCodPro})
	// Alias e caminho da critica
									PLSCOMPCRI(aCodCri,"BA1")
	
									aTrb := {}
									aTrb := (eval(bRetErrPTU,"BA1",cCdTbPd + cCodPro))
									aTrb := aTrb[2]
	
									For nFor := 1 to len(aTrb)
										AaDd( aCriticas,{cSeqMov,aTrb[nFor,1],AllTrim(aTrb[nFor,2])+Iif(Len(aTrb[nFor])>=3 .And. !Empty(aTrb[nFor,3]),' ( '+aTrb[nFor,3]+' ) ',''),aTrb[nFor,6],aTrb[nFor,7],"",""} )
									Next
	// Matriz
									U_CBDADITE(aDadIte,aItens[nX],cOrigem,cLibEsp,cAuditoria,cNumImp,,dData,aDadRda)
									AaDd(aEventosNeg,{cSeqMov,cCdTbPd,cCodPro,nQtdSol,cDescri,nQtdAut,"","","",cSlvPad,cSlvPro})
	
								Next

								Return(.F.)

/*/{Protheus.doc} VBaixRisco
Verifica se todos os eventos da guia sao de baixo risco
@type function
@author TOTVS
@since 19.08.15
@version 1.0
/*/
							Static Function VBaixRisco(aItens)
								Local lRet     := .T.
								Local nFor     := 0
								Local aAreaBR8 := BR8->(GetArea())
								Local cCodPad  := ""
								Local cCodPro  := ""

								BR8->(DbSetOrder(1))//BR8_FILIAL + BR8_CODPAD + BR8_CODPSA + BR8_ANASIN
// Verifica se todos os itens sao de baixo risco
								For nFor:=1 to len(aItens)
	
									cCodPad  := U_CBRETDAD(aItens[nFor],"CODPAD")+Space(TamSx3("BD6_CODPAD")[1] - Len(U_CBRETDAD(aItens[nFor],"CODPAD")))
									cCodPro  := U_CBRETDAD(aItens[nFor],"CODPRO")+Space(TamSx3("BD6_CODPRO")[1] - Len(U_CBRETDAD(aItens[nFor],"CODPRO")))
	
									If !(BR8->(DbSeek(xFilial("BR8")+cCodPad+cCodPro)) .And. BR8->BR8_RISCO == "1")
										lRet := .F.
										Exit
									EndIf
								Next
// Se itens de baixo risco, gero o log no console PTU Online
								If lRet
									For nFor:=1 to len(aItens)
										cCodPad  := U_CBRETDAD(aItens[nFor],"CODPAD")+Space(TamSx3("BD6_CODPAD")[1] - Len(U_CBRETDAD(aItens[nFor],"CODPAD")))
										cCodPro  := U_CBRETDAD(aItens[nFor],"CODPRO")+Space(TamSx3("BD6_CODPRO")[1] - Len(U_CBRETDAD(aItens[nFor],"CODPRO")))
										PlsPtuLog(cCodPad+"-"+Alltrim(cCodPro)+" -> Evento de Baixo Risco.")
									Next
								EndIf

								RestArea(aAreaBR8)

								Return lRet


//-------------------------------------------------------------------
/*/{Protheus.doc} U_CBDigGuia

Retorna variável lógica informando se a guia foi digitada posteriormente através do portal do prestador.
Essa verificação é feita através da variável PRIVATE lDigiGuia, que é alimentada com a propriedade "DigitacaoGuia" do webservice WSPLSXMOV.
A propriedade do webservice é carregada com o valor HttpGet->cTipoOrigem enviado pela tela quando a guia é digitada posteriormente.

@author Rodrigo Morgon
@since 24/11/2015
@version P12
/*/
//-------------------------------------------------------------------
							User Function CBDigGuia()
								return (Type("lDigiGuia") <> "U" .And. lDigiGuia)


//-------------------------------------------------------------------
/*/{Protheus.doc} U_CBBACKGUI

Muda fase da guia finalizada para digitação.

@author Rodrigo Morgon
@since 26/11/2015
@version P12
/*/
//-------------------------------------------------------------------
							User Function CBBACKGUI(cRecnos, nTipoGuias)
								local aArea := GetArea()
								local lRet := .T.
								local aGuias := {}
								local nI := 1
								aGuias	:= Separa(cRecnos, "|" , .F.)

								if len(aGuias) > 0
									for nI := 1 to len(aGuias)
										if (nTipoGuias == 3)
			//Se guia de internação
											DbSelectArea("BE4")
											BE4->(DbGoTo(Val(aGuias[nI])))
			
			//Posiciona na PEG relacionada à guia.
											DbSelectArea("BCI")
											BCI->(DbSetOrder(14))//BCI_FILIAL + BCI_CODPEG
			
			//Verifica se existe PEG na BCI e, caso positivo, realiza o retorno da fase da guia.
											lRet := BCI->(MsSeek(xFilial("BCI")+AllTrim(BE4->BE4_CODPEG))) .and. PLSA500RFS("BE4",aGuias[nI],6,,.F.,.T.)
										else
			//Se guia dos demais tipos
											DbSelectArea("BD5")
											BD5->(DbGoTo(Val(aGuias[nI])))
			
			//Posiciona na PEG relacionada à guia.
											DbSelectArea("BCI")
											BCI->(DbSetOrder(14))//BCI_FILIAL + BCI_CODPEG
			
			//Verifica se existe PEG na BCI e, caso positivo, realiza o retorno da fase da guia.
											lRet := BCI->(MsSeek(xFilial("BCI")+AllTrim(BD5->BD5_CODPEG))) .and. PLSA500RFS("BD5",aGuias[nI],6,,.F.,.T.)
										endIf
									next
								endif

								RestArea(aArea)
								Return lRet

/*/{Protheus.doc} U_CBRETVAR
Retorna variável lógica informando se a execução deriva de uma liberação, para que faça a verificação
apenas de algumas criticas.

@author Thiago Ribas
@since 08/16
/*/
							User Function CBRETVAR()
								Return aLibera

/*/{Protheus.doc} U_CBGrvEspXML
Gravacao das especialidades de arquivos XML

@type Function
@author victor.silva
@since 12/04/2016
@version 1.0
/*/
							User Function CBGrvEspXML(cAlias,aEspXML,aCompo,_cEspExe,_cCodEsp,aUndBD7)
								Local nI 			:= 1
								Local nBkpPri 	:= 0
								Local nBkpRec 	:= 0
								Local nPos			:= 0
								Local nPosEsp 	:= 0
								Local aPriori		:= {}
								Local aEspUnic	:= {}

								Default aCompo	:= {}
								Default _cEspExe	:= ""
								Default _cCodEsp	:= ""
								Default aUndBD7		:= NIL

/*
Estrutura do aEspXML definido no PLSA973
[1] - Especialidade do Executante (Utilizada para estabelecer a prioridade)
[2] - CBO do Executante
[3] - Especialidade do Prestador (Utilizada para ajuste do campo BD6_CODESP)
[4] - Codigo da unidade de medida (Posicionar na especialidade referente a unidade em edicao)

*/

								Do Case
								Case cAlias $ "BE4/BD5"
	
	//Para o cabecalho, eh utilizada a especialidade com maior ocorrencia na guia.
									For nI:= 1 to Len(aEspXML)
										nPos := aScan(aEspUnic,{|x| AllTrim(x[2]) == aEspXML[nI][1][3]})
										If nPos  == 0
											aAdd(aEspUnic,{1,aEspXML[nI][1][3]})
											If nBkpRec == 0
												nBkpRec := aEspUnic[Len(aEspUnic)][1]
												_cCodEsp:= aEspUnic[Len(aEspUnic)][2]
											ElseIf nBkpRec < aEspUnic[Len(aEspUnic)][1]
												nBkpRec := aEspUnic[Len(aEspUnic)][1]
												_cCodEsp:= aEspUnic[Len(aEspUnic)][2]
											EndIf
										Else
											aEspUnic[nPos][1]++
											If nBkpRec < aEspUnic[nPos][1]
												nBkpRec := aEspUnic[nPos][1]
												_cCodEsp:= aEspUnic[nPos][2]
											EndIf
										EndIf
									Next
	
									(cAlias)->&(cAlias+"_CODESP") := _cCodEsp
	
									Return

								Case cAlias == "BD6"
	
									BD6->(RecLock("BD6",.F.))
									BD6->BD6_ESPEXE := _cEspExe
									BD6->BD6_CODESP := _cCodEsp
									BD6->(MsUnLock())
	
									Return

								Case cAlias == "BD7"
	/*
	Estrutura do aPriori
	[1] - Unidade do procedimento
	[2] - Prioridade da Unidade segundo cadastro da tabela BD3
	*/
									For nI := 1 to Len(aCompo)
										aAdd(aPriori,{Val(aCompo[nI][2]),aCompo[nI][1]})
									Next
	
	//Estabelecendo a prioridade da especialidade que vai para o campo BD6_ESPEXE com base na composicao do item.
									While !BD7->(Eof()) .And. 	xFilial('BD6')+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN) == ;
											BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)
		
		//Se o array com a especialidade dos membros esta vazio,
		//devo apenas salvar as composicoes para atualizar o controle de saldo
										If Len(aEspXML) == 0 .And. aUndBd7 <> NIL
											aAdd(aUndBd7,BD7->BD7_CODUNM)
											BD7->(DbSkip())
											Loop
										EndIf
		
		//Localiza a especialidade da Composicao em edicao
										nPosEsp	:= aScan(aEspXML,{|x| Len(x) >= 4 .And. AllTrim(x[4]) == AllTrim(BD7->BD7_CODTPA)})
		
		//Atualiza a especialidade do Prestador
										If nPosEsp > 0
											BD7->(RecLock("BD7",.F.))
											BD7->BD7_ESPEXE := aEspXML[nPosEsp][1]
											BD7->BD7_CODESP := aEspXML[nPosEsp][3]
											BD7->(MsUnLock())
										ElseIf Len(aEspXML) >= 0
											BD7->(RecLock("BD7",.F.))
											BD7->BD7_ESPEXE := aEspXML[Len(aEspXML)][1]
											BD7->BD7_CODESP := aEspXML[Len(aEspXML)][3]
											BD7->(MsUnLock())
										EndIf
		
		//Se for UNL nao precisa buscar a prioridade
										If AllTrim(BD7->BD7_CODUNM) == "UNL"
											_cEspExe := aEspXML[1][1]
											_cCodEsp := aEspXML[1][3]
										Else
			//Verifica qual a posicao da Unidade atual no array de prioridades
											nPosPri := aScan(aPriori,{|x| AllTrim(x[2]) == AllTrim(BD7->BD7_CODUNM)})
			
											If nPosPri > 0 .And. nPosEsp > 0
				
				//Se estiver vazia, armazena a primeira
												If Empty(_cCodEsp)
													_cEspExe 	:= aEspXML[nPosEsp][1]
													_cCodEsp 	:= aEspXML[nPosEsp][3]
													nBkpPri 	:= aPriori[nPosPri][1]
					//Se ja estiver preenchida, verifica se a prioridade anterior eh menor do que a atual
												ElseIf nBkpPri > aPriori[nPosPri][1]
													_cEspExe 	:= aEspXML[nPosEsp][1]
													_cCodEsp 	:= aEspXML[nPosEsp][3]
													nBkpPri 	:= aPriori[nPosPri][1]
												EndIf
											EndIf
										EndIf
		
										If aUndBd7 <> NIL
											aAdd(aUndBd7,BD7->BD7_CODUNM)
										EndIf
										BD7->(DbSkip())
		
									EndDo
	
	//Chamada recursiva para atualizacao das especialidades da BD6
									If Len(aEspXML) > 0
										U_CBGrvEspXML("BD6",aEspXML,aCompo,_cEspExe,_cCodEsp)
									EndIf
	
									Return

								EndCase

								Return

/*/{Protheus.doc} U_CBDELMOVZ
Delete registro de movimento de um peg contas e ajusta eventuais efeitos no atendimento
função feita com base na U_CBDELMOV, mas para uso na importação XML
@type function
@author Oscar Zanin
@since 19/04/2017
@version 1.0
/*/
							User Function CBDELMOVZ(cChave,cFase,lTudoOk,cTpGuEx)
								LOCAL lRet  := .f.
								LOCAL lEntrou := .f.
								LOCAL aArea := getArea()
								Local cGuiInt := ''
								Local cTpFat := ''
								Local aUndBd7 := {}
								Local nForY := 1
								Local cSqlUPDBE4 := ""
								Local cSqlUPDB43 := ""
								Local cSqlUPDBD6 := ""
								Local cSqlUPDBD5 := ""
								Local cSqlUPDBD7 := ""
								Local aDadBE4		:= {}
								Local nI	:= 1
	
								Default cTpGuEx   := ""
								Default lTudoOk   :=	.T.

								BCI->(dbSetOrder(1))//BCI_FILIAL + BCI_CODOPE + BCI_CODLDP + BCI_CODPEG + BCI_FASE + BCI_SITUAC
								if BCI->(msSeek(xFilial("BCI")+cChave)) .and. empty(BCI->BCI_PROCES)
	//atualiza status do peg
									PLSM190Pro(,,,,,,,,,,,.f.,.t.,BCI->(Recno()))
	//verifica se esta em digitacao
									if BCI->BCI_FASE == cFase
										lRet := .t.

										BD7->(dbSetOrder(1))//BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO + BD7_ORIMOV + BD7_SEQUEN + BD7_CODUNM + BD7_NLANC
										if BD7->(msSeek(xFilial("BD7")+cChave))
											while !(BD7->(EoF())) .AND. BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG) == xFilial("BD7")+cChave//BD7->(msSeek(xFilial("BD7")+cChave))

												If (nO:=aScan(aUndBd7,{|x| alltrim(x[1]) == alltrim(BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO))  })) > 0
													aadd(aUndBd7[nO][2],BD7->BD7_CODUNM)
												Else
													aadd(aUndBd7,{BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO),{BD7->BD7_CODUNM}})
												Endif
					
												BD7->(DbSkip())
											endDo
										endIf

										BE4->(dbSetOrder(1))//BE4_FILIAL + BE4_CODOPE + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO + BE4_SITUAC + BE4_FASE
										if BE4->(msSeek(xFilial("BE4")+cChave))
				//cGuiInt := BE4->BE4_GUIINT
											while !(BE4->(Eof())) .AND. BE4->(BE4_FILIAL + BE4_CODOPE + BE4_CODLDP + BE4_CODPEG) == xFilial("BE4")+cChave//BE4->(msSeek(xFilial("BE4")+cChave))
												cGuiInt := BE4->BE4_GUIINT
												cTpFat := BE4->BE4_TIPFAT
												Aadd(aDadBE4, {cGuiInt, cTpFat})

												BE4->(DbSkip())
											EndDo
				//BE4
											cSqlUPDBE4 := " UPDATE " + RetSqlName("BE4") + " SET "
											cSqlUPDBE4 += " D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ "
											cSqlUPDBE4 += " Where "
											cSqlUPDBE4 += " BE4_FILIAL = '" + xFilial("BE4") + "' AND "
											cSqlUPDBE4 += " BE4_CODOPE = '" + SubStr(cChave, 1, 4) + "' AND "
											cSqlUPDBE4 += " BE4_CODLDP = '" + SubStr(cChave, 5, 4) + "' AND "
											cSqlUPDBE4 += " BE4_CODPEG = '" + SubStr(cChave, 9, 8) + "' AND "
											cSqlUPDBE4 += " D_E_L_E_T_ = ' '  "
										endIf

			//B43
										cSqlUPDB43 := " UPDATE " + RetSqlName("B43") + " SET "
										cSqlUPDB43 += " D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ "
										cSqlUPDB43 += " Where "
										cSqlUPDB43 += " B43_FILIAL = '" + xfilial("B43") + "' AND "
										cSqlUPDB43 += " B43_CODOPE = '" + SubStr(cChave, 1, 4) + "' AND "
										cSqlUPDB43 += " B43_CODLDP = '" + SubStr(cChave, 5, 4) + "' AND "
										cSqlUPDB43 += " B43_CODPEG = '" + SubStr(cChave, 9, 8) + "' AND "
										cSqlUPDB43 += " D_E_L_E_T_ = ' '  "
			
			//BD7
										cSqlUPDBD7 := " UPDATE " + RetSqlName("BD7") + " SET "
										cSqlUPDBD7 += " D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ "
										cSqlUPDBD7 += " Where "
										cSqlUPDBD7 += " BD7_FILIAL = '" + xFilial("BD7") + "' AND "
										cSqlUPDBD7 += " BD7_CODOPE = '" + SubStr(cChave, 1, 4) + "' AND "
										cSqlUPDBD7 += " BD7_CODLDP = '" + SubStr(cChave, 5, 4) + "' AND "
										cSqlUPDBD7 += " BD7_CODPEG = '" + SubStr(cChave, 9, 8) + "' AND "
										cSqlUPDBD7 += " D_E_L_E_T_ = ' '  "
			
			//BD6
										cSqlUPDBD6 := " UPDATE " + RetSqlName("BD6") + " SET "
										cSqlUPDBD6 += " D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ "
										cSqlUPDBD6 += " Where "
										cSqlUPDBD6 += " BD6_FILIAL = '" + xFilial("BD6") + "' AND "
										cSqlUPDBD6 += " BD6_CODOPE = '" + SubStr(cChave, 1, 4) + "' AND "
										cSqlUPDBD6 += " BD6_CODLDP = '" + SubStr(cChave, 5, 4) + "' AND "
										cSqlUPDBD6 += " BD6_CODPEG = '" + SubStr(cChave, 9, 8) + "' AND "
										cSqlUPDBD6 += " D_E_L_E_T_ = ' '  "
		
										begin transaction

											For nI := 1 To Len(aDadBE4)
				//limpa as informacoes de alta na solicitacao da internacao
												lExiste := .F.
												cSql := "SELECT * FROM "+RetSqlName("BE4")
												cSql += " WHERE BE4_FILIAL = '"+xFilial("BE4")+"' "
												cSql += " AND BE4_GUIINT = '"+aDadBE4[nI][1]+"' "
												cSql += " AND D_E_L_E_T_ <> '*' "
												PlsQuery(cSql,'TrbS1')
												If !TrbS1->(Eof())
													lExiste := .T.
												Endif
												TrbS1->(DbCloseArea())

												if !EMPTY(cGuiInt) .AND. BE4->(msSeek(xFilial("BE4")+aDadBE4[nI][1]))
													BE4->(RecLock("BE4",.F.))
													BE4->BE4_DTALTA := ctod('')
													BE4->BE4_HRALTA := ""
													BE4->BE4_TIPFAT := ""
	
													If aDadBE4[nI][2] == "T" .or. !lExiste//se estou excluindo uma guia de resumo cujo faturamento eh do tipo total eu limpo a data de internacao
											//ou se nao existe mais nenhuma guia de resumo para esta solicitacao
														BE4->BE4_DATPRO := CTOD('')
														BE4->BE4_HORPRO := ''
													Endif
													BE4->(MsUnLock())
												endIf
											Next

		//deleta bd5
											aRecBE2 := {}
											BD5->(dbSetOrder(1))//BD5_FILIAL + BD5_CODOPE + BD5_CODLDP + BD5_CODPEG + BD5_NUMERO + BD5_SITUAC + BD5_FASE + dtos(BD5_DATPRO) + BD5_OPERDA + BD5_CODRDA
											if BD5->(msSeek(xFilial("BD5")+cChave))
												while BD5->(msSeek(xFilial("BD5")+cChave))
													nRecBD5 := BD5->(Recno())
													nOrdBD5	:= BD5->(IndexOrd())
													If !Empty(BD5->BD5_NRLBOR) .and. BD5->BD5_TIPGUI $ "02"//ainda nao trato saldo para honorario individual, so SPSDAT - daher 23/04/2013
					// Se e uma excluao de autorizacao baseada em uma liberacao refaz saldo
														BD6->(DbSetORder(1))
														if BD6->(msSeek(xFilial("BD6")+cChave+BD5->BD5_NUMERO))
															while !BD6->(Eof()) .and. xFilial("BD6")+cChave+BD5->BD5_NUMERO == BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)
							// Atualizo saldo de uma liberacao
							// Aqui tem a seguinte regra se um evento tem HM e neste BD6 que eu acabei
							// de criar nao existe o HM, eu nao atualizo o saldo.. o saldo sempre eh abatido
							// quando se faz o honorario medico, pois podem ter 3 bd6 referentes a um mesmo
							// evento e eu so tenho que abater o saldo 1 vez senao fica com saldo negativo
																lAtuSaldo := .F.
																aCompo := PLSCOMEVE(BD6->BD6_CODTAB,BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_CODOPE,BD6->BD6_DATPRO)
																If Len(aUndBd7) > 0

																	nO := aScan(aUndBd7,{|x| alltrim(x[1]) == alltrim(BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO))  })

																	cUndHM := "HM,HMR,PPM,RCC,CIR"
																	If Existblock('PLSUNHMS')
																		cUndHM := ExecBlock( 'PLSUNHMS',.F.,.F.,{cUndHM} )
																	Endif

																	If aScan(aCompo,{|x| alltrim(x[1]) $ cUndHM }) > 0 .and. nO > 0//verifica se tem honorario na composição do evento
																		For nForY := 1 to Len(aUndBd7[nO][2])
																			If alltrim(aUndBd7[nO][2][nForY]) $ cUndHM // no evento que eu estou excluindo, tem nonorário?
																				lAtuSaldo := .T.
																				exit
																			Endif
																		Next
																	Else
																		lAtuSaldo := .T.
																	Endif

																	If !lAtuSaldo
																		BD6->(DbSkip())
																		loop
																	Endif
																Endif

							// Seleciona todos os registros da execucao que esta sendo deletada
																cSQL := "SELECT BE2_SEQUEN, BE2_CODPAD, BE2_CODPRO, BE2_QTDPRO, BE2_SALDO, R_E_C_N_O_ FROM " + BE2->( RetSQLName("BE2") )
																cSQL += " WHERE BE2_FILIAL = '" + xFilial('BE2')				+"' "
																cSQL += " 	AND BE2_OPEMOV = '" + Subs(BD5->BD5_NRLBOR,1,4)		+"' "
																cSQL += " 	AND BE2_ANOAUT = '" + Subs(BD5->BD5_NRLBOR,5,4)		+"' "
																cSQL += " 	AND BE2_MESAUT = '" + Subs(BD5->BD5_NRLBOR,9,2)		+"' "
																cSQL += " 	AND BE2_NUMAUT = '" + Subs(BD5->BD5_NRLBOR,11,8)	+"' "
																cSQL += " 	AND BE2_CODPAD = '" + BD6->BD6_CODPAD				+"' "
																cSQL += " 	AND BE2_CODPRO = '" + BD6->BD6_CODPRO				+"' "
																cSQL += " 	AND BE2_STATUS = '1' AND BE2_LIBERA = '1' "
																cSQL += " 	AND D_E_L_E_T_ = ' '"
							// Cria area de trabalho
																cSQL := ChangeQuery(cSQL)
																dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),"TrbBE2",.F.,.T.)
							// While nos itens da execucao
																While !TrbBE2->( Eof() )
								//aqui eu garanto que um mesmo be2 nunca vai ser reprocessado
																						   //aqui eu garanto que se ele ainda tem saldo para abeter
																	If aScan(aRecBE2,{|x| x == TrbBE2->R_E_C_N_O_}) <> 0 .and. TrbBE2->BE2_SALDO == 0
																		TrbBE2->(DbSkip())
																		loop
																	Endif

																	aadd(aRecBE2,TrbBE2->R_E_C_N_O_)
								// Quantidade do procedimento na execucao
																	nQtdPro := BD6->BD6_QTDPRO
																	cSequen := TrbBE2->BE2_SEQUEN
																	PLSATUSS( nil ,.F.,nil,nil,"1",.F.,BD5->BD5_NRLBOR + cSequen,6,nil,nil,1,nQtdPro )
																	lEntrou := .T.

																	TrbBE2->( DbSkip() )
																EndDo
																TrbBE2->( DbCloseArea() )

																BD6->(DbSkip())
															Enddo
														Endif
														If PLSSALDO(BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV),BD5->BD5_NRLBOR)
															BEA->(dbSetOrder(1))
															If BEA->(msSeek(xFilial("BEA")+BD5->BD5_NRLBOR))
																PLSATUCS('1')
															Endif
														EndIf
													EndIf
													BD5->(DbGoTo(nRecBD5))
													BD5->(DbSetORder(nOrdBD5))

													BD5->( recLock("BD5",.f.) )
													BD5->(dbDelete())
													BD5->( msUnLock() )
												endDo
											endIf
				
											TcSqlExec(cSqlUPDBD6)
				
											TcSqlExec(cSqlUPDBD7)

											TcSqlExec(cSqlUPDB43)
				
											TcSqlExec(cSqlUPDBE4)
				
											If lTudoOk
												BCI->( recLock("BCI",.f.) )
												BCI->(dbDelete())
												BCI->( msUnLock() )
											else
												If cTpGuEx $ "03"
													cCampo := "BE4_NUMERO"
												Else
													cCampo := "BD5_NUMERO"
												Endif

												DBSelectArea("B0Y")
												B0Y->( DbSetOrder(1) )  //B0Y_FILIAL + B0Y_CAMPO + B0Y_CHAVE
												If B0Y->( MsSeek( xFilial("B0Y")+cCampo+cChave ) )
													B0Y->( recLock("B0Y",.F.) )
													B0Y->(dbDelete())
													B0Y->( msUnLock() )
												EndIf
											EndIf

										end transaction
									endIf
								endIf

								restArea(aArea)
								return(lret)
