#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "TBICONN.CH"
#include "topconn.ch"
#INCLUDE "TOTVS.CH"

#DEFINE cEnt Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ WS004    บAutor  ณAngelo Henrique     บ Data ณ  27/05/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  WebService criado para ser utilizado no processo de       บฑฑ
ฑฑบDesc.     ณ		REEMBOLSO.                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Fabrica de Software                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WS004()
return


WSSTRUCT tStrProfi
	WSDATA crm					AS String
	WSDATA especialidade		AS String
	WSDATA nome					AS String
	WSDATA situacao 	 		AS String
	WSDATA UF 			 		AS String
ENDWSSTRUCT

// Estrutura de retorno utilizada para profissional de saude
WSSTRUCT StrPrf
	WSDATA _cCDG				AS String				// Codigo Protheus
	WSDATA _cNME				AS String				// Nome do Profissional
	WSDATA _cCSG				AS String				// CodSig do Profissional
	WSDATA _cNCR				AS String				// NumCR do Profissional
	WSDATA _cEST				AS String				// Estado do Profissional
	WSDATA _cCGC				AS String				// CGC do Profissional
	WSDATA _cInscr				AS String				// Inscri็ใo Estadual
	WSDATA _cInscrM				AS String				// Inscri็ใo Municipal
ENDWSSTRUCT

WSSTRUCT StrConhecimento
	WSDATA _cMatricula			AS String
	WSDATA _cReembolso			AS String
	WSDATA _cPath				AS String
	WSDATA _cProtocolo			AS String
ENDWSSTRUCT

// Estrutura de retorno utilizada para detalhe de protocolo
WSSTRUCT StrDtRb
	WSDATA _cReemb				AS String				// Numero do Protocolo
	WSDATA _cTpProt				AS String				// Tipo de protocolo (1,2,3,4)
	WSDATA _dDtDig				AS String				// Data de Digita็ใo
	WSDATA _dDtPre				AS String				// Data de Previa de Pagamento
	WSDATA _nValor				AS Float				// Valor do reembolso
	WSDATA _cStats				AS String				// Status
	WSDATA _cTipPg				AS String				// Tipo de Pagamento (1,2) Cred CC / Cheque
	WSDATA _cCgcPrf				AS String				// CGC Profisssional de Saude
	WSDATA _cNumCr				AS String				// CRM Profisssional de Saude
	WSDATA _cCodSg				AS String				// Sigla Profisssional de Saude
	WSDATA _cEstd				AS String				// Estado Profisssional de Saude
	WSDATA _cNomPrf				AS String				// Nome Profisssional de Saude
ENDWSSTRUCT

//Estrutura para realizar o processo de inclusใo
WSSTRUCT StrReemb
	WSDATA _cTpProt				AS String				// Tipo de Solicita็ใo
	WSDATA _cMatUsu				AS String				// Matricula do beneficiแrio
	WSDATA _nValor				AS Float				// Valor
	WSDATA _cTipPg				AS String				// Tipo de Pagamento - Credit CC / Cheque
	WSDATA _cCGCExc				AS String				// CGC do Profissional de Sa๚de
	WSDATA _cCodSg				AS String				// Sigla do Profissional de Sa๚de
	WSDATA _cCRMExc				AS String				// CGC do Profissional de Sa๚de
	WSDATA _cNomeExc			AS String				// Nome do Profissional de Sa๚de
	WSDATA _cEstExc				AS String				// Estado do local onde foi executado
	WSDATA _cBanco				AS String				// Banco
	WSDATA _cAgenc				AS String				// Agencia
	WSDATA _cDvAgencia			AS String				// DV da Agencia
	WSDATA _cConta				AS String				// Conta
	WSDATA _cdGConta			AS String				// Digito Conta
	WSDATA _cTipoProt			AS String				// Tipo de Protocolo
	WSDATA _nNumRec				AS Integer				// Quantidade de Recibos
	WSDATA _cNota				AS String optional		// Nota Fiscal
	WSDATA _cTelefone			AS String optional		// Telefone
	WSDATA _cMail				AS String optional		// Mail
	WSDATA _cDtEvent			AS String				// Data do evento
	WSDATA _cMatFav				AS String				// Matricula do Favorecido
	WSDATA _cComPAG				AS String				// Descri็ใo da Condi็ใo de Pagamento
	WSDATA _cZap				AS String optional		// ษ do Zap ou nใo
ENDWSSTRUCT

// Dados Beneficiแrios
WsStruct StrBenef1
	WSDATA CPF					AS String
	WSDATA Nome					AS String
	WSDATA Telefone				AS String
	WSDATA EMAIL				AS String
	WSDATA MATRICULA			AS String
EndWSSTRUCT

// Dados Bancarios
WSSTRUCT StrDadBanco
	WSDATA _cBanco				AS String				// Codigo do Banco
	WSDATA _cNomBank			AS String				// Nome do Banco
	WSDATA _cConta				AS String				// Conta
	WSDATA _cDvConta			AS String				// Digito Verificador Conta
	WSDATA _cAgencia			AS String				// Ag๊ncia
	WSDATA _cDvAgencia			AS String				// Digito Verificador Ag๊ncia
ENDWSSTRUCT

// Encapsula Dados Bancarios
WSSTRUCT StrBanco
	WSDATA Banco				AS Array of StrDadBanco
ENDWSSTRUCT

// Encapsula Profissionais
WSSTRUCT StrProfissionais
	WSDATA Profissionais		AS Array of StrPrf
ENDWSSTRUCT


WSSERVICE WS004 DESCRIPTION "<b> Protocolo de Reembolso </b>" NAMESPACE "WS004"

	// Lista das estruturas de recebimento do webservice
	WSDATA tInc					AS StrReemb				// Inclusใo de Protocolo
	WSDATA _cEmpInc				AS String				// Empresa para realizar login (CABERJ/INTEGRAL) - Utilizado na Inclusใo de Protocolos

	// Lista das estruturas de recebimento do webservice
	WSDATA _tDocs				AS StrConhecimento

	// Lista das estruturas de retorno do webservice
	WSDATA tDtl					AS StrDtRb				// Detalhe Protocolo
	WSDATA tPrf					AS StrProfissionais		// Profissional de Saude
	WSDATA tStrBanco			AS StrBanco				// Estrutura do banco
	WSDATA tGetProfi			AS tStrProfi

	// Lista dos parametros de recebimento
	WSDATA _cSeqProt			AS String				// Protocolo Utilizado no Detalhes Protocolos
	WSDATA _cEmpLog				AS String				// Empresa para realizar login (CABERJ/INTEGRAL) - Utilizado no Lista Protocolos
	WSDATA _cCGC				AS String				// CRM do profissional de saude
	WSDATA _cNome				AS String				// Nome do profissional de saude
	WSDATA _cMunic				AS String				// Municipio do profissional de saude
	WSDATA _cEst				AS String				// Estado do profissional de saude
	WSDATA _cNmReq				AS String
	WSDATA _cMatReq				AS String
	WSDATA _cMatBen				AS String
	WSDATA _cCRM				AS String
	WSDATA _cUF					AS String
	WSDATA _cCPF				AS String
	WSDATA _cRda				AS String
	WSDATA _cMatric				AS String
	WSDATA _cRetorno			AS String
	WSDATA _cDtEven				AS String

	// Lista dos parametros de retorno
	WSDATA _cRetProt			AS STRING				// Retorno do protocolo gerado na inclusใo
	WSDATA sBeneficiario		AS StrBenef1

	// Declara็ใo dos M้todos
	WSMETHOD WS004INC			DESCRIPTION "M้todo - Inclusใo do protocolo de reembolso."
	WSMETHOD WS004DET			DESCRIPTION "M้todo - Detalhes do Protocolo de reembolso."
	WSMETHOD WS004PF			DESCRIPTION "M้todo - Detalhes da rede nใo referenciada."
	WSMETHOD WS004BANCO			DESCRIPTION "M้todo - Detalhes de dados bancแrios."
	WSMETHOD WS004DOC			DESCRIPTION "M้todo - Grava o banco de conhecimento."
	WSMETHOD WS004VLPF			DESCRIPTION "M้todo - Valida profissional e retorna dados."
	WSMETHOD WS004BENEF			DESCRIPTION "M้todo - Detalhes de dados do beneficiแrio."
	WSMETHOD WS004VALID			DESCRIPTION "M้todo - Valida reembolso aberto."
	WSMETHOD WS004ALTER			DESCRIPTION "M้todo - Cancela o protocolo caso ocorra erro na grava็ใo do anexo."

ENDWSSERVICE



/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para detalhes do protocolo de atendimento.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS004INC WSRECEIVE tInc, _cEmpInc, _cNmReq, _cMatReq  WSSEND _cRetProt WSSERVICE WS004

Local lRet				:= .T.

Local _cEmpInc			:= ::_cEmpInc						// Codigo da empresa
Local _cNomeRequ		:= AllTrim(self:_cNmReq)			// Nome do Requisitante
Local _cMatReque		:= AllTrim(self:_cMatReq)			// Matricula Requisitante

Local _cMatUsu			:= tInc:_cMatUsu					// Matricula do beneficiแrio
Local _cCGCExc			:= tInc:_cCGCExc					// CGC do Profissional de Sa๚de
Local _dDtReemb			:= StoD(::tInc:_CDTEVENT)			// Data do reembolso
Local _cBanco			:= AllTrim(tInc:_cBanco)			// Banco
Local _cAgenc			:= AllTrim(tInc:_cAgenc)			// Agencia
Local _cDvAgencia		:= AllTrim(tInc:_cDVAgencia)		// Digito Agencia
Local _cConta			:= AllTrim(tInc:_cConta)			// Conta
Local _cDgConta			:= AllTrim(tInc:_cDgConta)			// Digito Conta
Local _cMatFav			:= CValToChar(tInc:_cMatFav)		// Matricula do Favorecido
Local _cCodSg			:= tInc:_cCodSg						// Sigla do Profissional de Sa๚de
Local _cZap				:= AllTrim(tInc:_cZap)				// Veio do Zap ou nใo
Local _cNomeExc			:= AllTrim(Upper(tInc:_cNomeExc))	// Nome do Profissional de Sa๚de
Local _cTpProt			:= tInc:_cTpProt					// Tipo de Solicita็ใo
Local _nValor			:= tInc:_nValor						// Valor
Local _cTipPg			:= tInc:_cTipPg						// Tipo de Pagamento - Credit CC / Cheque
Local _cTipoProt		:= tInc:_cTipoProt					// Tipo de Protocolo
Local _cComPAG			:= AllTrim(tInc:_cComPAG)			// Descri็ใo da condi็ใo de pagamento
Local _nNumRec			:= tInc:_nNumRec					// Qtd de Recibos

Local _cCodRDA			:= ""
Local cCodCli			:= ""
Local cCodigo			:= ""
Local aCodPrS			:= {"",""}
Local _cReemb			:= ""								// Codigo do reembolso
Local _lAchou			:= .T.
Local cNumCROK			:= ""
Local cAux				:= ""
Local i					:= 0

Private _cNomUsr		:= ""
Private _cCodInt		:= ""
Private _cCodEmp		:= ""
Private _cMatric		:= ""
Private _cTipReg		:= ""
Private _cDigito		:= ""
Private _dDtNasc		:= StoD("")
Private _cEmail			:= cValToChar(::tInc:_cMail)
Private _cTel			:= tInc:_cTelefone
Private _cMatTit		:= ""
Private cMatBen			:= ""
Private _cPlano			:= ""
Private _cMail			:= ""
Private _cCpf			:= ""
Private _cEstd			:= tInc:_cEstExc
Private _cCRMExc		:= AllTrim(tInc:_cCRMExc)
Private _cPtEnt			:= ""
Private _cNumPA			:= ""

Private _cTelefone		:= cValToChar(::tInc:_cTelefone)
Private _cNota			:= cValToChar(::tInc:_cNota)
Private _cHst			:= "000015"
Private _cTipAt			:= "2"								// Status Protocolo
Private _cRDA			:= ""
Private _TpDm			:= ""
Private _cCanal			:= "000025"							// Fale Conosco
Private _nSla			:= 0
Private _cCdAre			:= ""
Private _cTpSv			:= "1019"							// Reembolso
Private _cObs			:= ""
Private _cTpDm			:= "T"								// Solicita็ใo

QOut("Inclusใo Reembolso " + time())

if Empty(AllTrim(_cEmpInc)) .or. ( AllTrim(_cEmpInc) <> "01" .and. AllTrim(_cEmpInc) <> "02")
	SetSoapFault( "", "Nใo foi possivel realizar login no sistema de reembolso." )
	lRet := .F.
elseif Empty(AllTrim(_cMatUsu))
	SetSoapFault( "", "Matricula em branco, favor preencher e reenviar a solicita็ใo." )
	lRet := .F.
elseif Empty(AllTrim(cvaltochar(_cCGCExc)))
	SetSoapFault( "", "CPF/CNPJ do executante nใo preenchido, favor preecher." )
	lRet := .F.
elseif Empty(_cEstd) .or. Empty(_cCodSg) .or. Empty(_cCRMExc)
	SetSoapFault( "", "Dados do conselho de classe do executante nใo preenchido, favor preecher." )
	lRet := .F.
else

	// PREPARA AMBIENTE
	If FindFunction("WfPrepEnv")
		WfPrepEnv(_cEmpInc,"01")
	Else
		PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
	EndIf

	// Ponterando no beneficiแrio
	BA1->(DbSetOrder(2))	// BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
	if BA1->(DbSeek(xFilial("BA1") + _cMatUsu))

		_cCodRDA	:= GETMV("MV_YRDAREE")

		BAU->(DbSetOrder(1))	// BAU_FILIAL+BAU_CODIGO
		if BAU->(DbSeek(xFilial("BAU") + _cCodRDA)) .and. !empty(_cCodRDA)

			if ValidEven(_dDtReemb, BA1->BA1_DATBLO, BA1->BA1_DATINC)

				BA3->(DbSetOrder(1))	// BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
				if BA3->(DbSeek(xFilial("BA3") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))

					// Valida se os dados de banco, agencia, conta e digito da conta constam no cadastro de hist๓rico de contas
					if !Empty(_cBanco) .and. !Empty(_cAgenc) .and.  !Empty(_cConta) .and. !Empty(_cDgConta)

						// Buscar cliente financeiro (se retorno for vazio - criar cliente no momento da grava็ใo)
						cCodCli		:= BusCliente(_cMatFav, BA3->(BA3_CODCLI + BA3_LOJA), BA1->BA1_CPFUSR)

						if !empty(cCodCli)		// se nใo identificou o cliente - obviamente nใo tem banco vinculado (criar no momento da grava็ใo)
							// Buscar codigo do banco do cliente para reembolso
							cCodigo	:= BusConta(cCodCli, _cBanco, _cAgenc, _cDvAgencia, _cConta, _cDgConta)
						endif

						// Tratamento para retirar todos os caracteres nใo numericos enviados
						cAux	:= ""
						for i := 1 to len(_cCRMExc)
							if IsDigit( SubStr(_cCRMExc, i, 1) )
								cAux += SubStr(_cCRMExc, i, 1)
							endif
						next
						cNumCROK	:= AllTrim(str(val(cAux)))

						if val(cNumCROK) > 0
							_cCRMExc	:= cNumCROK
						endif

						// Buscar profissional de sa๚de (se retorno for vazio - criar no momento da grava็ใo)
						aCodPrS		:= BusPrfSau(_cCGCExc, _cEstd, _cCodSg, _cCRMExc, SubStr(_cNomeExc, 1, at(" ", _cNomeExc)-1 ) )

						SetFunName("CDPROTREE")
						_cNomUsr	:= BA1->BA1_NOMUSR
						_cCodInt	:= BA1->BA1_CODINT
						_cCodEmp	:= BA1->BA1_CODEMP
						_cMatric	:= BA1->BA1_MATRIC
						_cTipReg	:= BA1->BA1_TIPREG
						_cDigito	:= BA1->BA1_DIGITO
						_dDtNasc	:= BA1->BA1_DATNAS
						_cEmail		:= iif(!Empty(_cEmail), _cEmail, BA1->BA1_EMAIL)
						_cTel		:= BA1->BA1_TELEFO
						_cMatTit	:= BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
						cMatBen		:= BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
						_cPlano		:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
						_cMail		:= BA1->BA1_EMAIL
						_cCpf		:= BA1->BA1_CPFUSR

						if Empty(_cZap)
							_cPtEnt		:= "000012"		// WEB
						elseif _cZap = '1'
							_cPtEnt		:= "000013"		// ZAP
						else
							_cPtEnt		:= "000002"		// EMAIL
						endif

						//--------------------------------------------------------------------------------------//
						//					INICIO DA GRAVAวรO DO PROTOCOLO DE REEMBOLSO						//
						//--------------------------------------------------------------------------------------//

						Begin Transaction

							// Pegar codigo do protocolo customizado que seguirแ existindo para nใo precisar compatibilidade de relat๓rios e vis๕es
							_cReemb		:= GETSX8NUM("ZZQ","ZZQ_SEQUEN")
							CONFIRMSX8()

							// Garantir a nใo duplicidade
							while _lAchou
								ZZQ->(DbSetORder(1))
								if !(ZZQ->(DbSeek(xFilial("ZZQ") + _cReemb )))
									_lAchou := .F.
								else
									_cReemb := GETSX8NUM("ZZQ","ZZQ_SEQUEN")
									CONFIRMSX8()
								endif
							end

							_cObs	:= OemToAnsi("Protocolo WEB referente a solicita็ใo de reembolso n๚mero:") + _cReemb

							if empty(cCodCli)
								cCodCli	:= CriaCli(BA1->BA1_CODINT, BA1->BA1_CODEMP, BA1->BA1_MATRIC)
							endif

							SA1->(DbSetOrder(1))		// A1_FILIAL+A1_COD+A1_LOJA
							SA1->(DbSeek(xFilial("SA1") + cCodCli ))

							if empty(cCodigo)

								DbSelectArea("PCT")
								cCodigo := GetSxeNum("PCT","PCT_CODIGO")

								RecLock("PCT",.T.)
									PCT->PCT_FILIAL			:= xFilial("PCT")
									PCT->PCT_CODIGO			:= cCodigo
									PCT->PCT_CLIENT			:= SA1->A1_COD
									PCT->PCT_LOJA			:= SA1->A1_LOJA
									PCT->PCT_NMCLIE			:= SA1->A1_NOME
									PCT->PCT_BANCO			:= _cBanco
									PCT->PCT_NUMAGE			:= _cAgenc
									If !Empty(_cDvAgencia)
										PCT->PCT_DVAGE		:= _cDvAgencia
									Endif
									PCT->PCT_NCONTA			:= _cConta
									PCT->PCT_DVCONT			:= _cDgConta
									PCT->PCT_DESCBC			:= cValtoChar(RestDBanco(_cBanco))
									PCT->PCT_STATUS			:= '1'
								PCT->(MsUnLock())

								PCT->(ConfirmSx8())

							endif

							if empty(aCodPrS[1])	// Sem rede nใo referenciada

								aCodPrS[1]		:=  GetSxeNum("BK6","BK6_CODIGO")
								BK6->(ConfirmSx8())

								RecLock("BK6",.T.)
									BK6->BK6_FILIAL	:= xFilial("BK6")
									BK6->BK6_CODIGO	:= aCodPrS[1]
									BK6->BK6_NOME	:= _cNomeExc
									BK6->BK6_SIGLA	:= _cCodSg
									BK6->BK6_CONREG	:= _cCRMExc
									BK6->BK6_CGC	:= _cCGCExc
									BK6->BK6_CPF	:= iif(len(AllTrim(_cCGCExc)) == 11, _cCGCExc, "")
									BK6->BK6_ESTCR	:= _cEstd
								BK6->(MsUnlock())
							
							else
								
								BK6->(DbSetOrder(3))	// BK6_FILIAL+BK6_CODIGO
								BK6->(DbSeek( xFilial("BK6") + aCodPrS[1] ))

								_cCRMExc := BK6->BK6_CONREG

							endif

							// Primeiro processo: gerar a PA e pegar o codigo do protocolo do atendimento
							_cNumPA		:= U_GerNumPA()						// Gera็ใo de n๚mero da PA

							CriaPA(_cNumPA)		// Realiza a inclusใo de Protocolo de Atendimento

							// Criar novo protocolo de reembolso (padrใo)
							RecLock("BOW",.T.)
								BOW->BOW_FILIAL	:= xFilial("ZZQ")
								BOW->BOW_YCDPTC	:= _cReemb
								BOW->BOW_PROTOC	:= _cNumPa
								BOW->BOW_TIPPAC	:= GetNewPar("MV_PLSTPAA","1")
								BOW->BOW_STATUS	:= "1"
								BOW->BOW_USUARI	:= BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO)
								BOW->BOW_NOMUSR	:= BA1->BA1_NOMUSR
								BOW->BOW_CODCLI	:= cCodCli
								BOW->BOW_LOJA	:= '01'
								BOW->BOW_NOMCLI	:= Posicione("SA1", 1, xFilial("SA1") + cCodCli + "01", "A1_NOME" )
								BOW->BOW_MATANT	:= BA1->BA1_MATANT
								BOW->BOW_TIPUSR	:= "01"							// 01=Eventual; 02=Repasse; 99=Usuario Local
								BOW->BOW_VIACAR	:= BA1->BA1_VIACAR
								BOW->BOW_CODEMP	:= BA1->BA1_CODEMP
								BOW->BOW_MATRIC	:= BA1->BA1_MATRIC
								BOW->BOW_TIPREG	:= BA1->BA1_TIPREG
								BOW->BOW_DIGITO	:= BA1->BA1_DIGITO
								BOW->BOW_MATUSA	:= "1"							// 1=Matricula Principal;2=Matricula Antiga
								BOW->BOW_XCDPLA	:= BA1->BA1_CODPLA
								BOW->BOW_PADINT	:= U_CabRetAc( BA1->(RECNO()) )
								BOW->BOW_DTDIGI	:= date()
								BOW->BOW_OPERDA	:= PLSINTPAD()
								BOW->BOW_CODRDA	:= _cCodRDA
								BOW->BOW_NOMRDA	:= Posicione("BAU", 1, xFilial("BAU") + _cCodRDA, "BAU_NOME"  )
								BOW->BOW_TIPPRE	:= Posicione("BAU", 1, xFilial("BAU") + _cCodRDA, "BAU_TIPPRE")
								BOW->BOW_NUMGUI	:= ""
								BOW->BOW_CONEMP	:= BA1->BA1_CONEMP
								BOW->BOW_VERCON	:= BA1->BA1_VERCON
								BOW->BOW_SUBCON	:= BA1->BA1_SUBCON
								BOW->BOW_VERSUB	:= BA1->BA1_VERSUB
								BOW->BOW_UFATE	:= BA1->BA1_ESTADO
								BOW->BOW_MUNATE	:= BA1->BA1_CODMUN
								BOW->BOW_DESMUN	:= BA1->BA1_MUNICI
								BOW->BOW_LOCATE	:= Posicione("BB8", 1, xFilial("BB8") + _cCodRDA, "BB8_CODLOC+BB8_LOCAL")
								BOW->BOW_ENDLOC	:= Posicione("BB8", 1, xFilial("BB8") + _cCodRDA, "BB8_END" )
								BOW->BOW_SENHA	:= PLSSenAut(Date())
								BOW->BOW_CODESP	:= Posicione("BAX", 1, xFilial("BAX") + _cCodRDA + PLSINTPAD() + SUBS(BOW->BOW_LOCATE,1,3), "BAX_CODESP")
								BOW->BOW_DESESP	:= Posicione("BAQ", 1, xFilial("BAQ") + PLSINTPAD() + BOW->BOW_DESESP, "BAQ_DESCRI")

								// Rede nใo referencaida
								BOW->BOW_CODREF	:= BK6->BK6_CGC
								BOW->BOW_NOMREF	:= BK6->BK6_NOME

								// Prof. Solicitante (nใo preeenchido)
								/*
								BOW->BOW_OPESOL	:= ""		// Solicitante:  BB0_CODOPE
								BOW->BOW_ESTSOL	:= ""		// Solicitante:  BB0_ESTADO
								BOW->BOW_REGSOL	:= ""		// Solicitante:  BB0_NUMCR
								BOW->BOW_CONREG	:= ""		// Solicitante:  BB0_CODSIG
								BOW->BOW_NOMSOL	:= ""		// Solicitante:  BB0_NOME
								BOW->BOW_CDPFSO	:= ""		// Solicitante:  BB0_CODIGO
								*/

								// Prof. Executante
								if !empty(aCodPrS[2])	// se tiver prof. saude - usar dados para o cadastro da rede nใo ref.

									BB0->(DbSetOrder(1))	// BB0_FILIAL+BB0_CODIGO
									BB0->(DbSeek(xFilial("BB0") + aCodPrS[2] ))

									BOW->BOW_OPEEXE	:= BB0->BB0_CODOPE
									BOW->BOW_ESTEXE	:= BB0->BB0_ESTADO
									BOW->BOW_REGEXE	:= BB0->BB0_NUMCR
									BOW->BOW_SIGLA	:= BB0->BB0_CODSIG
									BOW->BOW_NOMEXE	:= BB0->BB0_NOME
									BOW->BOW_CDPFRE	:= BB0->BB0_CODIGO

								endif

								BOW->BOW_XDTEVE	:= _dDtReemb
								BOW->BOW_DATPAG	:= DataValida(date() + 30, .F.)
								BOW->BOW_XTPPAG	:= _cTipPg

								BOW->BOW_OPEMOV	:= PLSINTPAD()
								BOW->BOW_MESAUT	:= ""		// SubStr(DtoS(dDatabase),5,2)
								BOW->BOW_ANOAUT	:= ""		// SubStr(DtoS(dDatabase),1,4)
								BOW->BOW_OPEUSR	:= BA1->BA1_CODINT
								BOW->BOW_EMPMOV	:= cEmpAnt + cFilAnt
								BOW->BOW_CODLDP	:= ""
								BOW->BOW_CODPEG	:= ""
								BOW->BOW_NUMAUT	:= ""
								BOW->BOW_ORIMOV	:= ""
								BOW->BOW_GUIIMP	:= ""
								BOW->BOW_PREFIX	:= ""
								BOW->BOW_NUM	:= ""
								BOW->BOW_PARCEL	:= ""
								BOW->BOW_TIPO	:= ""
								BOW->BOW_CDOPER	:= "000000"		// Administrador -> WEB
								BOW->BOW_NOMOPE	:= "WEB"
								BOW->BOW_VLRAPR	:= _nValor
								BOW->BOW_XVLAPR	:= _nValor
								BOW->BOW_NROBCO	:= Posicione("PCT", 1, xFilial("PCT")+cCodigo+cCodCli, "PCT_BANCO" )
								BOW->BOW_DESBCO	:= Posicione("PCT", 1, xFilial("PCT")+cCodigo+cCodCli, "PCT_DESCBC" )
								BOW->BOW_NROAGE	:= Posicione("PCT", 1, xFilial("PCT")+cCodigo+cCodCli, "PCT_NUMAGE")
								BOW->BOW_NROCTA	:= Posicione("PCT", 1, xFilial("PCT")+cCodigo+cCodCli, "PCT_NCONTA")
								BOW->BOW_XDGCON	:= Posicione("PCT", 1, xFilial("PCT")+cCodigo+cCodCli, "PCT_DVCONT")
								BOW->BOW_NF		:= ""
								BOW->BOW_NPROCE	:= ""
								BOW->BOW_TIPINT	:= ""
								BOW->BOW_DESTIP	:= ""
								BOW->BOW_VLRREE	:= 0
								BOW->BOW_MOTIND	:= ""
								BOW->BOW_NUMEMP	:= ""
								BOW->BOW_FORNEC	:= ""
								BOW->BOW_TELCON	:= iif(!empty(_cTelefone),_cTelefone,_cTel)
								BOW->BOW_USRRES	:= ""
								BOW->BOW_MOTPAD	:= ""
								BOW->BOW_PARCE	:= ""
								BOW->BOW_PGMTO	:= ""
								BOW->BOW_DTCANC	:= StoD("")
								BOW->BOW_TIPCAN	:= ""
								BOW->BOW_TITCAN	:= ""
								BOW->BOW_GRPINT	:= ""
								BOW->BOW_PRXCAN	:= ""
								BOW->BOW_PROCLO	:= ""
								BOW->BOW_PROORI	:= ""
								BOW->BOW_REGINT	:= ""
								BOW->BOW_PADCON	:= ""
								BOW->BOW_CODTAB	:= ""
								BOW->BOW_ORIGEM	:= "00"				// IIF(nModulo == 33,"02",IIF(nModulo == 13,"03","00"))
								BOW->BOW_OBS	:= ""
								BOW->BOW_XTPEVE	:= iif(_cTpProt == '1' .and. _cTipoProt == '9', '2', '1' )	// 1=TDE de HM/Evento;2=TDE de Porte Anestesico
							BOW->(MsUnLock())

							// Criar protocolo de reembolso customizado
							RecLock("ZZQ",.T.)
								ZZQ->ZZQ_FILIAL	:= xFilial("ZZQ")
								ZZQ->ZZQ_SEQUEN	:= _cReemb
								ZZQ->ZZQ_TIPPRO	:= _cTipoProt
								ZZQ->ZZQ_CODBEN	:= BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO)
								ZZQ->ZZQ_CODINT	:= BA1->BA1_CODINT
								ZZQ->ZZQ_CODEMP	:= BA1->BA1_CODEMP
								ZZQ->ZZQ_MATRIC	:= BA1->BA1_MATRIC
								ZZQ->ZZQ_TIPREG	:= BA1->BA1_TIPREG
								ZZQ->ZZQ_DIGITO	:= BA1->BA1_DIGITO
								ZZQ->ZZQ_DATDIG := date()						// data de inclusใo
								ZZQ->ZZQ_USRDIG	:= "WEB"						// UsrRetFullName(__cUserId)
								ZZQ->ZZQ_NOMUSR	:= BA1->BA1_NOMUSR
								ZZQ->ZZQ_DATPRE	:= DataValida(date() + 30, .F.)
								ZZQ->ZZQ_VLRTOT	:= _nValor
								ZZQ->ZZQ_STATUS	:= "1"
								ZZQ->ZZQ_CODCLI	:= cCodCli
								ZZQ->ZZQ_LOJCLI	:= '01'
								ZZQ->ZZQ_XTPRGT	:= _cTipPg
								ZZQ->ZZQ_CPFEXE	:= _cCGCExc
								ZZQ->ZZQ_REGEXE	:= _cCRMExc
								ZZQ->ZZQ_SIGEXE	:= _cCodSg
								ZZQ->ZZQ_ESTEXE	:= _cEstd
								ZZQ->ZZQ_NOMEXE	:= _cNomeExc
								ZZQ->ZZQ_SMS	:= iif(!empty(_cTelefone),_cTelefone,_cTel)
								ZZQ->ZZQ_XNUMPA	:= _cNumPa
								ZZQ->ZZQ_DTEVEN	:= _dDtReemb
								ZZQ->ZZQ_CANAL	:= _cCanal
								ZZQ->ZZQ_XWEB	:= "000012"
								ZZQ->ZZQ_TPSOL	:= _cTpProt						//1 - Solicita็ใo de Reembolso / 2 - Solicita็ใo Especial
								ZZQ->ZZQ_TIPDES	:= GetAdvFVal('PCR','PCR_DESCRI',xFilial('PCR') + _cTipoProt, 1)
								ZZQ->ZZQ_COMPAG	:= _cComPAG						// iif(_cTipoProt == "9", "PORTE ANESTESICO", "")
								ZZQ->ZZQ_DBANCA	:= cCodigo
								ZZQ->ZZQ_XSOLWE	:= _cMatReque					// Matricula do solicitante
								ZZQ->ZZQ_NMSLWE	:= _cNomeRequ					// Nome do solicitante
								ZZQ->ZZQ_QTDREC	:= _nNumRec						// Quantidade de Recibos
								ZZQ->ZZQ_XNOTA	:= _cNota
								ZZQ->ZZQ_EMAIL	:= _cEmail
								ZZQ->ZZQ_XBANCO	:= Posicione("PCT", 1, xFilial("PCT")+cCodigo+cCodCli, "PCT_BANCO" )
								ZZQ->ZZQ_XAGENC	:= Posicione("PCT", 1, xFilial("PCT")+cCodigo+cCodCli, "PCT_NUMAGE")
								ZZQ->ZZQ_XCONTA	:= Posicione("PCT", 1, xFilial("PCT")+cCodigo+cCodCli, "PCT_NCONTA")
								ZZQ->ZZQ_XDGCON	:= Posicione("PCT", 1, xFilial("PCT")+cCodigo+cCodCli, "PCT_DVCONT")
								ZZQ->ZZQ_HRINC	:= StrTran(TIME(),':','')		// hora de inclusใo
								ZZQ->ZZQ_EXECUT	:=  BK6->BK6_CODIGO
							ZZQ->(MsUnLock())
						
						End Transaction
					
						::_cRetProt := _cNumPa + ";" + _cReemb

					else

						SetSoapFault( "", "Nใo foi informado os dados bancแrios." )
						lRet := .F.
					
					endif
				
				else

					// Nใo foi possivel encontrar a famํlia cadastrada do beneficiario.
					SetSoapFault( "", "Nใo foi possivel realizar login no sistema de reembolso." )
					lRet := .F.
				
				endif
			
			else

				// SetSoapFault vindo da valida็ใo do evento
				lRet := .F.
			
			endif		

		else

			//Nใo identificado a rede de atendimento de reembolso para o lan็amento.
			SetSoapFault( "", "Nใo foi possivel realizar login no sistema de reembolso." )
			lRet := .F.
		
		endif

	else

		SetSoapFault( "", "Matricula do beneficiแrio nใo localizada no sistema." )
		lRet := .F.
	
	endIf

endif

QOut("Saํda Reembolso: " + Time())

Return lRet



/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para detalhes do protocolo de atendimento.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS004DET WSRECEIVE _cEmpLog, _cSeqProt WSSEND tDtl WSSERVICE WS004

Local lRet			:= .T.
Local _lAchou		:= .F.
Local _cTpProt		:= ""
Local _cStatus		:= ""
Local _cTpPg		:= ""

if Empty(AllTrim(_cEmpLog)) .or. ( AllTrim(_cEmpLog) <> "01" .and. AllTrim(_cEmpLog) <> "02")

	SetSoapFault( "", "Nใo foi possivel realizar login no sistema de protocolos." )
	lRet := .F.

elseif empty(_cSeqProt)

	SetSoapFault( "", "Por favor informar o protocolo de reembolso." )
	lRet := .F.

else

	// PREPARA AMBIENTE
	if FindFunction("WfPrepEnv")
		WfPrepEnv(_cEmpLog,"01")
	else
		PREPARE ENVIRONMENT EMPRESA _cEmpLog FILIAL "01"
	endif

	ZZQ->(DbSetOrder((1)))	// ZZQ_FILIAL+ZZQ_SEQUEN
	if ZZQ->(DbSeek(xFilial("ZZQ") + AllTrim(_cSeqProt) ))

		if AllTrim(ZZQ->ZZQ_SEQUEN) == AllTrim(_cSeqProt)

			_lAchou := .T.

			// Valida็ใo para o tipo de protocolo
			if ZZQ->ZZQ_TIPPRO == "1"
				_cTpProt := "Anestesia e Honorarios Medicos"
			elseif ZZQ->ZZQ_TIPPRO == "2"
				_cTpProt := "Consultas, Exames e Procedimentos"
			elseif ZZQ->ZZQ_TIPPRO == "3"
				_cTpProt := "Projetos Especiais/Atend. Domiciliar"
			elseif ZZQ->ZZQ_TIPPRO == "4"
				_cTpProt := "Auxilio Funeral"
			endif

			// Valida็ใo para encaminhar o status conforme protheus
			if ZZQ->ZZQ_STATUS == "1"
				_cStatus := "Ativo"
			elseif ZZQ->ZZQ_STATUS == "2"
				_cStatus := "Cancelado"
			elseif ZZQ->ZZQ_STATUS == "3"
				_cStatus := "Vinculado"
			endif

			// Valida็ใo do tipo de Pagamento
			if ZZQ->ZZQ_XTPRGT == "1"
				_cTpPg := "Credito CC"
			elseif ZZQ->ZZQ_XTPRGT == "1"
				_cTpPg := "Cheque"
			endif

			::tDtl:_cReemb		:= AllTrim(ZZQ->ZZQ_SEQUEN)					// Numero do Protocolo
			::tDtl:_cTpProt		:= _cTpProt									// Tipo de protocolo (1,2,3,4)
			::tDtl:_dDtDig		:= AllTrim(DtoC(ZZQ->ZZQ_DATDIG))			// Data de Digita็ใo
			::tDtl:_dDtPre		:= AllTrim(DTOC(ZZQ->ZZQ_DATPRE))			// Data de Previa de Pagamento
			::tDtl:_nValor		:= ZZQ->ZZQ_VLRTOT							// Valor do reembolso
			::tDtl:_cStats		:= _cStatus									// Status
			::tDtl:_cTipPg		:= _cTpPg									// Tipo de Pagamento (1,2) Cred CC / Cheque
			::tDtl:_cCgcPrf		:= AllTrim(ZZQ->ZZQ_CPFEXE)					// CGC Profisssional de Saude
			::tDtl:_cNumCr		:= AllTrim(ZZQ->ZZQ_REGEXE)					// CRM Profisssional de Saude
			::tDtl:_cCodSg		:= AllTrim(ZZQ->ZZQ_SIGEXE)					// Sigla Profisssional de Saude
			::tDtl:_cEstd		:= AllTrim(ZZQ->ZZQ_ESTEXE)					// Estado Profisssional de Saude
			::tDtl:_cNomPrf		:= AllTrim(ZZQ->ZZQ_NOMEXE)					// Nome Profisssional de Saude

		endif

	endif
	
	if !_lAchou
		SetSoapFault( "", "Nใo foi encontrado nenhum protocolo registrado no sistema." )
		lRet := .F.
	EndIf

endif

return lRet



/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para consulta do profissional de saude.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS004PF WSRECEIVE _cEmpLog, _cCGC,_cNome,_cMunic,_cEst WSSEND tPrf WSSERVICE WS004

Local lRet			:= .F.
Local _cQuery		:= ""
Local _cAliasPS		:= ""
Local oTemp			:= Nil

::tPrf:Profissionais := {}

if Empty(AllTrim(_cEmpLog)) .or. ( AllTrim(_cEmpLog) <> "01" .and. AllTrim(_cEmpLog) <> "02")

	SetSoapFault( "", "Nใo foi possivel realizar login no sistema de protocolos." )
	lRet := .F.

elseif empty(_cCGC) .and. empty(_cNome)

	SetSoapFault( "", "Necessแrio informar o CPF ou o nome para realizar a busca." )
	lRet := .F.

else

	// PREPARA AMBIENTE
	if FindFunction("WfPrepEnv")
		WfPrepEnv(_cEmpLog,"01")
	else
		PREPARE ENVIRONMENT EMPRESA _cEmpLog FILIAL "01"
	endif

	_cAliasPS	:= GetNextAlias()

	// Lista os dados do profissional de saude
	_cQuery := " select BK6_CODIGO, BK6_NOME, BK6_CGC, BK6_ESTCR, BK6_SIGLA, BK6_CONREG"
	_cQuery += " FROM " + RetSqlName("BK6") + " BK6"
	_cQuery += " WHERE BK6.D_E_L_E_T_ = ' '"
	_cQuery +=	 " AND BK6_FILIAL = '" + xFilial("BK6") + "'"
	
	if !empty(_cCGC)
		_cQuery += " AND BK6_CGC = '" + AllTrim(_cCGC) + "'"
	endif

	if !empty(_cNome)
		_cQuery += " AND BK6_NOME LIKE '%" + AllTrim(_cNome) + "%'"
	endif

	if !Empty(_cEst)
		_cQuery += " AND BK6_ESTCR = '" + AllTrim(_cEst) + "'"
	endif

	_cQuery += " ORDER BY BK6_NOME"

	if Select(_cAliasPS) > 0
		(_cAliasPS)->(DbCloseArea())
	endif

	PLSQuery(_cQuery,_cAliasPS)

	while !(_cAliasPS)->(EOF())

		lRet	:= .T.

		oTemp := WsclassNew("StrPrf")

		oTemp:_cCDG			:= Alltrim((_cAliasPS)->BK6_CODIGO)		// Codigo Protheus
		oTemp:_cNME			:= Alltrim((_cAliasPS)->BK6_NOME  )		// Nome do Profissional
		oTemp:_cCGC			:= Alltrim((_cAliasPS)->BK6_CGC   )		// CGC do Profissional
		oTemp:_cEST			:= Alltrim((_cAliasPS)->BK6_ESTCR )		// Estado do Profissional
		oTemp:_cCSG			:= Alltrim((_cAliasPS)->BK6_SIGLA )		// CodSig do Profissional
		oTemp:_cNCR			:= Alltrim((_cAliasPS)->BK6_CONREG)		// NumCR do Profissional
		oTemp:_cInscr		:= ''									// Inscri็ใo Estadual
		oTemp:_cInscrM		:= ''									// Inscri็ใo Municipal

		aAdd( ::tPrf:Profissionais , oTemp)

		(_cAliasPS)->(DbSkip())
	end
	(_cAliasPS)->(DbCloseArea())

	if !lRet
		SetSoapFault( "", "Nใo foi encontrada nenhuma rede nใo refeenciada registrada no sistema." )
		lRet := .F.
	endif

endif

return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ M้todo para rela็ใo dos profissionais do CFM.			  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS004VLPF WSRECEIVE _cEmpInc, _cCRM, _cUF   WSSEND tGetProfi WSSERVICE WS004

Local lRet		:= .T.
Local oTemp		:= Nil
Local _cEmpInc	:= AllTrim(::_cEmpInc)			// Codigo da empresa
Local _nCRM		:= Val(cValToChar(::_cCRM))		// CRM
Local _cUF		:= AllTrim(::_cUF)				// UF
Local aRet		:= {}
Local i			:= 0

::tGetProfi := {}

if Empty(AllTrim(_cEmpInc)) .or. ( AllTrim(_cEmpInc) <> "01" .and. AllTrim(_cEmpInc) <> "02")

	SetSoapFault( "", "Nใo foi possivel realizar login no sistema de protocolos." )
	lRet := .F.

elseif _nCRM <= 0 .or. empty(_cUF)

	SetSoapFault( "", "CRM e/ou estado nใo informado/invแlido, favor preencher e reenviar a solicita็ใo." )
	lRet := .F.

else

	if RpcSetEnv(_cEmpInc,"01")

		aRet := U_ConsPF(_nCRM,_cUF)

		if len(aRet) > 0

			for i := 1 to len(aRet)

				if empty(aRet[1][1])

					oTemp	:=  WsClasseNew("tStrProfi")

					oTemp:crm				:=  aRet[1][2]
					oTemp:especialidade		:=  aRet[1][5]
					oTemp:nome				:=  aRet[1][7]
					oTemp:situacao			:=  aRet[1][9]
					oTemp:UF				:=  aRet[1][11]

					aAdd( ::tGetProfi, oTemp )

				endif

			next
		
		else
		
			SetSoapFault( "", "Nใo foi possivel encontrar o profissionais do CFM com os dados fornecidos." )
			lRet := .F.

		endif

	else

		SetSoapFault( "", "Nใo foi possivel acessar a empresa." )
		lRet := .F.

	endif

endif

return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ M้todo para rela็ใo dos hist๓rico de contas dos cliente.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS004BANCO WSRECEIVE _cEmpInc, _cMatBen  WSSEND tStrBanco WSSERVICE WS004

Local lRet			:= .T.
Local oTemp			:= Nil
Local _cEmpInc		:= ::_cEmpInc				// Codigo da empresa
Local _cMatUsu		:= alltrim(::_cMatBen)
Local lOK			:= .F.
Local cCodCli		:= ""

::tStrBanco:Banco	:= {}

if Empty(AllTrim(_cEmpInc)) .or. ( AllTrim(_cEmpInc) <> "01" .and. AllTrim(_cEmpInc) <> "02")

	SetSoapFault( "", "Nใo foi possivel realizar login no sistema de protocolos." )
	lRet := .F.

elseif Empty(AllTrim(_cMatUsu))

	SetSoapFault( "", "Matricula em branco, favor preencher e reenviar a solicita็ใo." )
	lRet := .F.

else

	// PREPARA AMBIENTE
	if FindFunction("WfPrepEnv")
		WfPrepEnv(_cEmpInc,"01")
	else
		PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
	endif

	// Ponterando no beneficiแrio
	BA1->(DbSetOrder(2))
	if BA1->(DbSeek(xFilial("BA1") + _cMatUsu))

		// Ponterando na familia para pegar os codigos do cliente
		BA3->(DbSetOrder(1))	// BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
		if BA3->(DbSeek(xFilial("BA3") + BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC)))

			cCodCli := BusCliente("", BA3->(BA3_CODCLI + BA3_LOJA), BA1->BA1_CPFUSR)

			PCT->(DbSetOrder(2))	// PCT_FILIAL+PCT_CLIENT+PCT_CODIGO
			if PCT->(DbSeek(xFilial("PCT") + SubStr(cCodCli,1,6) ))

				while PCT->(!EOF()) .and. PCT->PCT_CLIENT == SubStr(cCodCli,1,6)

					if PCT->PCT_STATUS == ' ' .or. PCT->PCT_STATUS == '1'

						lOK		:= .T.

						oTemp := WsClassNew("StrDadBanco")

						oTemp:_cBanco		:= PCT->PCT_BANCO
						oTemp:_cNomBank		:= RestDBanco(PCT->PCT_BANCO)
						oTemp:_cConta		:= PCT->PCT_NCONTA
						oTemp:_cDvConta		:= PCT->PCT_DVCONT
						oTemp:_cAgencia		:= PCT->PCT_NUMAGE
						oTemp:_cDvAgencia	:= PCT->PCT_DVAGE

						aAdd(::tStrBanco:Banco,oTemp)

					endif

					PCT->(DbSkip())
				end

			endif

			if !lOK

				oTemp := WsClassNew("StrDadBanco")

				oTemp:_cBanco		:= ""
				oTemp:_cNomBank		:= ""
				oTemp:_cConta		:= ""
				oTemp:_cDvConta		:= ""
				oTemp:_cAgencia		:= ""
				oTemp:_cDvAgencia	:= ""

				aAdd(::tStrBanco:Banco,oTemp)
			
			endif
		
		else

			SetSoapFault( "", "Nใo foi possivel realizar login no sistema de protocolos." )
			lRet := .F.

		endif

	else
	
		SetSoapFault( "", "Nใo foi possivel encontrar o beneficiแrio com os dados fornecidos." )
		lRet := .F.
	
	endif

endif

return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Metodo para grava็ใo do Banco de Conhecimento              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS004DOC WSRECEIVE _cEmpLog, _tDocs WSSEND _cRetProt WSSERVICE WS004

Local lRet			:= .T.
Local _cEmpLog		:= ::_cEmpLog				// Codigo da empresa
Local _cMat			:= ::_tDocs:_cMatricula
Local _cCodReem		:= ::_tDocs:_cReembolso
Local _cCodProt		:= ::_tDocs:_cProtocolo
Local cFiltro		:= CValToChar(self:_tDocs:_cPath)
Local _cPath		:= ''
Local aFiles		:= {}						// O array receberแ os nomes dos arquivos e do diret๓rio
Local aSizes		:= {}						// O array receberแ os tamanhos dos arquivos e do diretorio
Local nCount		:= 0
Local nX			:= 0
Local _cNumAnx		:= ""						// Angelo Henrique - Data:04/04/2018
Local _lAchou		:= .T.

QOut("Entrada Grava็ใo de documentos: " + time())

if Empty(AllTrim(_cEmpLog)) .or. ( AllTrim(_cEmpLog) <> "01" .and. AllTrim(_cEmpLog) <> "02")

	SetSoapFault( "", "Nใo foi possivel realizar login no sistema de protocolos." )
	lRet := .F.

else

	// PREPARA AMBIENTE
	if FindFunction("WfPrepEnv")
		WfPrepEnv(_cEmpLog,"01")
	else
		PREPARE ENVIRONMENT EMPRESA _cEmpLog FILIAL "01"
	endif

	if !empty(_cCodReem)

		ZZQ->(DbSetOrder(1))	// ZZQ_FILIAL+ZZQ_SEQUEN
		if ZZQ->(DbSeek( xFilial("ZZQ") + AllTrim(_cCodReem) ))

			if !empty(_cMat)

				if ZZQ->ZZQ_CODBEN == _cMat

					if !empty(_cCodProt)

						if ZZQ->ZZQ_XNUMPA == _cCodProt

							_cPath		:= GetNewPar("MV_XDIRWEB", "\ArqWeb")
							_cPath		:= _cPath + "\" + StrTran(cFiltro,'/','\')

							aDir(_cPath + "*.*", aFiles, aSizes)

							nCount := Len( aFiles )

							DbSelectArea("AC9")
							DbSelectArea("ACB")

							for nX := 1 to nCount

								_cNumAnx := GetSx8Num("ACB", "ACB_CODOBJ")
								ConfirmSX8()

								// Garantir a nใo duplicidade
								while _lAchou
									ACB->(DbSetOrder(1))	// ACB_FILIAL+ACB_CODOBJ
									if !(ACB->(DbSeek(xFilial("ACB") + _cNumAnx )))
										_lAchou := .F.
									else
										_cNumAnx := GetSx8Num("ACB", "ACB_CODOBJ")
										ConfirmSX8()
									endif
								end

								Begin Transaction
								
									RecLock("ACB",.T.)
										ACB->ACB_FILIAL	:= xFilial("ACB")
										ACB->ACB_CODOBJ	:= _cNumAnx
										ACB->ACB_OBJETO	:= aFiles[nX]
										ACB->ACB_DESCRI	:= _cMat + "_" + _cCodProt + "_" + _cCodReem + "_" + cvaltochar(nX)
									ACB->(MsUnLock())

									RecLock("AC9",.T.)
										AC9->AC9_FILIAL	:= xFilial("AC9")
										AC9->AC9_FILENT	:= xFilial("ZZQ")
										AC9->AC9_ENTIDA	:= "ZZQ"
										AC9->AC9_CODENT	:= xFilial("ZZQ") + _cCodReem + _cMat
										AC9->AC9_CODOBJ	:= _cNumAnx								// Angelo Henrique - Data:04/04/2018
										AC9->AC9_XUSU	:= 'WEB'
										AC9->AC9_XDTINC	:= date()
										AC9->AC9_HRINC	:= strtran(time(),':','')
									AC9->(MsUnLock())

									AC9->(Reclock("AC9",.T.))
										AC9->AC9_FILIAL	:= xFilial("AC9")
										AC9->AC9_FILENT	:= xFilial("BOW")
										AC9->AC9_ENTIDA	:= "BOW"
										AC9->AC9_CODENT	:= xFilial("BOW") + _cCodProt
										AC9->AC9_CODOBJ	:= _cNumAnx
										AC9->AC9_XUSU	:= 'WEB'
										AC9->AC9_XDTINC	:= date()
										AC9->AC9_HRINC	:= StrTran(Time(),":","")
									AC9->(MsUnlock())

								End Transaction

								__CopyFile( _cPath + '\' + aFiles[nX], "\dirdoc\co" + _cEmpLog + "\shared\" + aFiles[nX])

							next nX

							::_cRetProt := "OK"
						
						else

							SetSoapFault( "", "N๚mero de protocolo nใo pertence ao reembolso informado." )
							lRet := .F.

						endif

					else

						SetSoapFault( "", "N๚mero de protocolo nใo informado." )
						lRet := .F.
					
					endif
				
				else

					SetSoapFault( "", "Matricula do beneficiแrio informado nใo pertence ao protocolo de reembolso." )
					lRet := .F.

				endif

			else

				SetSoapFault( "", "Matricula do beneficiแrio nใo informada." )
				lRet := .F.
			
			endif
		
		else
		
			SetSoapFault( "", "Numero do protocolo de reembolso nใo localizado no sistema." )
			lRet := .F.

		endif

	else
		
		SetSoapFault( "", "Numero do protocolo de reembolso nใo informado." )
		lRet := .F.

	endif
	
endif

QOut("Saํda Grava็ใo de documentos: " + time())

return lRet


/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ		RETORNAR DADOS DO BENEFICIมRIO       			      บฑฑ
ฑฑบ          ณ   	FILTRO CPF 						                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS004BENEF WSRECEIVE _cEmpLog, _cCPF WSSEND sBeneficiario WSSERVICE WS004

Local lRet		:= .T.
Local oTemp		:= Nil
Local _cEmpInc	:= CValToChar(self:_cEmpLog)
Local cCpf		:= AllTrim(CValToChar(self:_cCPF))
Local lAchou	:= .F.

if AllTrim(_cEmpInc) <> '01'	// Tratamento antigo previa busca somente para as empresas mater e afinidade (mantido)

	SetSoapFault( "", "Nใo foi possivel realizar login no sistema de reembolso." )
	lRet := .F.

else

	// PREPARA AMBIENTE
	if FindFunction("WfPrepEnv")
		WfPrepEnv(_cEmpInc,"01")
	else
		PREPARE ENVIRONMENT EMPRESA _cEmpLog FILIAL "01"
	endif

	BA1->(DbSetOrder(4))	// BA1_FILIAL+BA1_CPFUSR
	if BA1->(DbSeek(xFilial("BA1") + cCpf )) .and. !empty(cCpf)

		while BA1->(!EOF()) .and. AllTrim(BA1->BA1_CPFUSR) == AllTrim(cCpf)

			if empty(BA1->BA1_MOTBLO) .and. BA1->BA1_CODEMP $ '0001|0002|0005'

				lAchou	:= .T.

				oTemp := WsClassNew("StrBenef1")

				oTemp:CPF			:= BA1->BA1_CPFUSR
				oTemp:Nome			:= AllTrim(BA1->BA1_NOMUSR)
				oTemp:Telefone		:= AllTrim(BA1->BA1_DDD) + ' ' + AllTrim(BA1->BA1_TELEFO)
				oTemp:EMAIL			:= AllTrim(BA1->BA1_EMAIL)
				oTemp:MATRICULA		:= BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)

				self:sBeneficiario	:= oTemp

				exit

			endif

			BA1->(DbSkip())
		end

	endif

	if !lAchou

		SetSoapFault("", "Nใo hแ beneficiแrios MATER/AFINIDADE com CPF informado.")
		lRet := .F.

	endif

endif

return lRet



/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ VALIDAR SE BENEFICIมRIO POSSUI REEMBOLSO ABERTO PARA       บฑฑ
ฑฑบ          ณ    O MESMO RDA                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
WSMETHOD WS004VALID WSRECEIVE _cEmpLog,_cMatric, _cRda,_cDtEven WSSEND _cRetorno WSSERVICE WS004

Local lRet			:= .T.
Local cMatric		:= cvaltochar(self:_cMatric)
Local cRda			:= cvaltochar(self:_cRda)
Local _cEmpInc		:= cvaltochar(self:_cEmpLog)
Local cDtEnv		:= cvaltochar(self:_cDtEven)
Local cAlias		:= GetNextAlias()

if Empty(AllTrim(_cEmpInc)) .or. ( AllTrim(_cEmpInc) <> "01" .and. AllTrim(_cEmpInc) <> "02")

	SetSoapFault( "", "Nใo foi possivel realizar login no sistema de protocolos." )
	lRet := .F.

elseif empty(cMatric)

	SetSoapFault( "", "Matricula do beneficiแrio nใo informada." )
	lRet := .F.

elseif empty(cRda)

	SetSoapFault( "", "Identificador da rede nใo informada." )
	lRet := .F.

elseif empty(cDtEnv)

	SetSoapFault( "", "Data de realiza็ใo nใo informada." )
	lRet := .F.

else

	// PREPARA AMBIENTE
	if FindFunction("WfPrepEnv")
		WfPrepEnv(_cEmpInc,"01")
	else
		PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
	endif

	BeginSql Alias cAlias

		%noparser%

		SELECT count(ZZQ_MATRIC) CONT
		FROM %Table:ZZQ% ZZQ
		WHERE ZZQ.%NotDel%
			AND ZZQ_FILIAL = %xFilial:ZZQ%
			AND ZZQ_STATUS = '1'				// pendente
			AND ZZQ_CODBEN = %exp:cMatric%
			AND ZZQ_CPFEXE = %exp:cRda%
			AND ZZQ_DTEVEN = %exp:cDtEnv%
	
	EndSql

	if (cAlias)->CONT == 0
	
		::_cRetorno := "OK"
	
	else

		SetSoapFault("", "Jแ existe um reembolso aberto para este beneficiแrio no executante escolhido nesta data.")
		lRet := .F.
	
	endif

	If select(cAlias) > 0
		dbselectarea(cAlias)
		dbclosearea()
	Endif

EndIf

Return lRet



//-------------------------------------------------------------------
// Metodo para alterar status do protocolo de atendimento
// Author:  Matheus Andrade
// Since:   05/11/21
//-------------------------------------------------------------------
WSMETHOD WS004ALTER WSRECEIVE _cEmpLog, _cSeqProt WSSEND _cRetorno WSSERVICE WS004

Local _cEmpInc		:= cvaltochar(self:_cEmpLog)
Local _cSeqProt		:= cvaltochar(self:_cSeqProt)
Local lRet			:= .T.
Local cObs			:= ""
Local cMotCan		:= "001"
Local cObsCan		:= "Problema em anexar arquivo via site, solicitado que seja gerado um novo pedido"
Local cAlias		:= GetNextAlias()
Local cSomaSrv		:= ""
Local _cHst			:= SuperGetMv("MV_XHISTRE",.F.,'000072')
Local _cTpSv		:= SuperGetMv("MV_XTPSVRE",.F.,'1056')

if Empty(AllTrim(_cEmpInc)) .or. ( AllTrim(_cEmpInc) <> "01" .and. AllTrim(_cEmpInc) <> "02")

	SetSoapFault( "", "Nใo foi possivel realizar login no sistema de protocolos." )
	lRet := .F.

elseif empty(_cSeqProt)

	SetSoapFault( "", "N๚mero do protocolo nใo informado." )
	lRet := .F.

else

	// PREPARA AMBIENTE
	If FindFunction("WfPrepEnv")
		WfPrepEnv(_cEmpInc,"01")
	Else
		PREPARE ENVIRONMENT EMPRESA _cEmpInc FILIAL "01"
	EndIf

	ZZQ->(DbSetORder(1))
	if ZZQ->(DbSeek(xFilial("ZZQ") + _cSeqProt ))

		Begin Transaction

			RecLock("ZZQ", .F.)
				ZZQ->ZZQ_STATUS	:= "2" 
				ZZQ->ZZQ_MOTCAN	:= cMotCan
				ZZQ->ZZQ_OBSCAN	:= cObsCan
				//ZZQ->ZZQ_CANOB1	:= cObsCan
				ZZQ->ZZQ_YUSRCA	:= "WEB"
				ZZQ->ZZQ_DTCAN	:= date()
				ZZQ->ZZQ_HRCAN	:= StrTran(Time(),':','')
			MsUnLock()

			BOW->(DbSetOrder(1))	// BOW_FILIAL+BOW_PROTOC
			if BOW->(DbSeek( xFilial("BOW") + ZZQ->ZZQ_XNUMPA ))

				cObs	:= AllTrim(BOW->BOW_OBS)
				cObs	+= chr(10)+chr(13) + chr(10)+chr(13)
				cObs	+= "-----------------------------------------------------------------"										+ chr(10)+chr(13)
				cObs	+= "-- PROTOCOLO CANCELADO --"																				+ chr(10)+chr(13)
				cObs	+= " * Motivo: "		+ cMotCan + " - " + Posicione("SX5",1,xFilial("SX5")+"ZQ"+cMotCan, "X5_DESCRI" )	+ chr(10)+chr(13)
				cObs	+= " * Observa็ใo: "	+ cObsCan																			+ chr(10)+chr(13)
				cObs	+= " * Usuแrio: "		+ "WEB"																				+ chr(10)+chr(13)
				cObs	+= " * Data: "			+ DtoC(date())																		+ chr(10)+chr(13)
				cObs	+= " * Hora: "			+ Time()																			+ chr(10)+chr(13)
				cObs	+= "-----------------------------------------------------------------"
				
				BOW->(Reclock("BOW", .F.))
					BOW->BOW_STATUS	:= "8"		// Glosado
					BOW->BOW_DTCANC	:= date()
					BOW->BOW_OBS	:= cObs
				BOW->(MsUnlock())

				// GRAVAวรO SZY
				BeginSQL Alias cAlias
				
					SELECT MAX(ZY_SEQSERV) MAXSERV
					FROM %TABLE:SZY%
					WHERE ZY_SEQBA = %EXP:ZZQ->ZZQ_XNUMPA%
				
				EndSql

				if (cAlias)->(!EOF())
					cSomaSrv := soma1((cAlias)->MAXSERV)
				endif
				(cAlias)->(dbclosearea())

				SZX->(DbSetOrder(1))
				if SZX->(DbSeek(xFilial("SZX") + ZZQ->ZZQ_XNUMPA))

					RecLock("SZY",.T.)
						SZY->ZY_FILIAL	:= xFilial("SZY")
						SZY->ZY_DTSERV	:= date()
						SZY->ZY_HORASV	:= StrTran(Time(),":","")
						SZY->ZY_TIPOSV	:= _cTpSv
						SZY->ZY_HISTPAD	:= _cHst
						SZY->ZY_USDIGIT	:= "WEB"
						SZY->ZY_SEQBA	:= ZZQ->ZZQ_XNUMPA
						SZY->ZY_SEQSERV	:= cSomaSrv
						SZY->ZY_OBS		:= cObsCan
					SZY->(MsUnLock())
				
				endif

			endif
		
		End Transaction

		::_cRetorno := "OK"

	else

		SetSoapFault( "", "Nใo foi encontrado nenhum protocolo registrado no sistema." )
		lRet := .F.
	
	endif

endif

return lRet



/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ        Gerar Protocolo de Atendimento				      บฑฑ
ฑฑบ          ณ   						                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ - WebService                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaPA(_cSeq, cTipo)

Private _xTpEnv := cTipo

// Pegando a quantidade de SLA
PCG->(DbSetOrder(1))
If PCG->(DbSeek(xFilial("PCG") + PADR(AllTrim(_cTpDm),TAMSX3("PCG_CDDEMA")[1]) + PADR(AllTrim(_cPtEnt),TAMSX3("PCG_CDPORT")[1]) + PADR(AllTrim(_cCanal),TAMSX3("PCG_CDCANA")[1]) + PADR(AllTrim(_cTpSv),TAMSX3("PCG_CDSERV")[1]) ))
	_nSla := PCG->PCG_QTDSLA
Else
	_nSla := 0
EndIf

// Ponterar na Tabela de PBL (Tipo de Servi็o) - Pegando assim a Area
PBL->(DbSetOrder(1))
If PBL->(DbSeek(xFilial("PBL") + PADR(AllTrim(_cTpSv),TAMSX3("PBL_YCDSRV")[1])))
	_cCdAre := PBL->PBL_AREA
EndIf

SZX->(DbSetOrder(1))
SZX->(DbSeek(xFilial("SZX") + AllTrim(_cSeq) ))

RecLock("SZX",.F.)
	SZX->ZX_FILIAL	:= xFilial("SZX")
	SZX->ZX_SEQ		:= _cSeq
	SZX->ZX_DATDE	:= dDataBase
	SZX->ZX_HORADE	:= STRTRAN(TIME(),":","")
	SZX->ZX_DATATE	:= dDataBase
	SZX->ZX_HORATE	:= STRTRAN(TIME(),":","")
	SZX->ZX_NOMUSR	:= _cNomUsr
	SZX->ZX_CODINT	:= _cCodInt
	SZX->ZX_CODEMP	:= _cCodEmp
	SZX->ZX_MATRIC	:= _cMatric
	SZX->ZX_TIPREG	:= _cTipReg
	SZX->ZX_DIGITO	:= _cDigito
	SZX->ZX_TPINTEL	:= _cTipAt						// Status aberto/Fechado -- Se for Interna็ใo WEB serแ criado fechado
	SZX->ZX_YDTNASC	:= _dDtNasc
	SZX->ZX_EMAIL	:= _cEmail
	SZX->ZX_RDA		:= _cRDA
	SZX->ZX_CONTATO	:= _cTel
	SZX->ZX_YPLANO	:= _cPlano
	SZX->ZX_TPDEM	:= _cTpDm						// Tipo de Demanda
	SZX->ZX_CANAL	:= _cCanal						// "000005" - Fale Conosco
	SZX->ZX_SLA		:= _nSla						// SLA
	SZX->ZX_PTENT	:= _cPtEnt						// "000002" - Porta de Entrada
	SZX->ZX_CODAREA	:= _cCdAre						// Codigo da Area
	SZX->ZX_VATEND	:= "3"							// Seguindo o protocolo anterior (Novo PA nใo utiliza este campo)
	SZX->ZX_TPATEND	:= "1"
	SZX->ZX_YDTINC	:= dDataBase
	SZX->ZX_CPFUSR	:= _cCpf
	SZX->ZX_PESQUIS	:= "4"							// NรO AVALIADO
SZX->(MsUnLock())

// Itens
DbSelectArea("SZY")

RecLock("SZY",.T.)
	SZY->ZY_FILIAL	:= xFilial("SZY")
	SZY->ZY_SEQBA	:= _cSeq
	SZY->ZY_SEQSERV	:= "000001"
	SZY->ZY_DTSERV	:= dDataBase
	SZY->ZY_HORASV	:= STRTRAN(TIME(),":","")
	SZY->ZY_TIPOSV	:= _cTpSv
	SZY->ZY_OBS		:= _cObs
	SZY->ZY_HISTPAD	:= _cHst
	SZY->ZY_PESQUIS	:= "4"							// NรO AVALIADO
SZY->(MsUnLock())

Return


/*
****************************************************************************
****************************************************************************
****************************************************************************
**Programa  *CriaCli *Autor  *Mateus Medeiros     * Data *  28/08/14   ***
****************************************************************************
**Desc.     * Inclui Cliente por EXECAUTO. Esta funcao                   ***
**          * retornarแ o Codigo de cliente ou um logico dependendo do   ***
**          * nTipo passado pelo parametro.							     ***
****************************************************************************
****************************************************************************
*/
Static Function CriaCli(cInt, cEmp, cMat)

Local cCodcli		:= " "
Local nRecBa1		:= BA1->(RECNO())

if BA1->BA1_TIPUSU <> "T"

	BA1->(DbSetOrder(1))	// BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPUSU+BA1_TIPREG+BA1_DIGITO
	if !(BA1->(DbSeek(xFilial("BA1") + cInt + cEmp + cMat + 'T')))		// procurar o titular da famํlia

		BA1->(DBGoTo(nRecBa1))	// Se nใo ้ o titular e tamb้m nใo o encontrou - retorno pro proprio beneficiแrio (crio cliente para ele)
	
	endif

endif

cCodCli		:= GetSx8Num("SA1","A1_COD")

RecLock("SA1",.T.)
	SA1->A1_FILIAL	:= xFilial("SA1")
	SA1->A1_COD		:= cCodCli
	SA1->A1_LOJA	:= "01"
	SA1->A1_NOME	:= Upper(BA1->BA1_NOMUSR)
	SA1->A1_PESSOA	:= "F"
	SA1->A1_NREDUZ	:= Upper(SubStr(BA1->BA1_NREDUZ,1,20))
	SA1->A1_CGC		:= BA1->BA1_CPFUSR
	SA1->A1_TIPO	:= "F"
	SA1->A1_END		:= Upper( AllTrim(BA1->BA1_ENDERE) + " " + AllTrim(BA1->BA1_NR_END) + " " + AllTrim(BA1->BA1_COMEND) )
	SA1->A1_MUN		:= Upper(BA1->BA1_MUNICI)
	SA1->A1_EST		:= Upper(BA1->BA1_ESTADO)
	SA1->A1_BAIRRO	:= Upper(BA1->BA1_BAIRRO)
	SA1->A1_CEP		:= BA1->BA1_CEPUSR
	SA1->A1_DDD		:= Upper(BA1->BA1_DDD)
	SA1->A1_TEL		:= Upper(BA1->BA1_TELEFO)
	SA1->A1_ENDCOB	:= Upper( AllTrim(BA1->BA1_ENDERE) + " " + AllTrim(BA1->BA1_NR_END) + " " + AllTrim(BA1->BA1_COMEND) )
	SA1->A1_BAIRROC	:= Upper(BA1->BA1_BAIRRO)
	SA1->A1_CEPC	:= BA1->BA1_CEPUSR
	SA1->A1_MUNC	:= Upper(BA1->BA1_MUNICI)
	SA1->A1_ESTC	:= Upper(BA1->BA1_ESTADO)
SA1->(MsUnLock())

ConfirmSX8()

BA1->(DBGoTo(nRecBa1))

return cCodCli



/* Valida data do evento */
Static Function ValidEven(dDatEve, dDatBloq, dDatInc)

Local lRet			:= .T.

Default dDatEve		:= Stod("")
Default dDatBloq	:= Stod("")
Default dDatInc		:= Stod("")

// Mateus Medeiros - 17/01/2018 
// Valida็ใo para configura็ใo do perํodo determinado de reembolso. 
// Somente serแ permitido pedir reembolso de eventos realizados em at้ 1 ano.
// Para Beneficiแrios bloqueados, s๓ serใo reembolsados de eventos executados antes da data de bloqueio.

if !Empty(dDatBloq)		// Beneficiแrio bloqueado.

	if dDatBloq >= dDatEve

		nTotDias := ddatabase - dDatEve

		if nTotDias > 365
			lRet := .F.
			SetSoapFault("ERRO!", "Solicita็ใo de reembolso superior a 12 meses, a partir da data de execu็ใo do evento.")
		endif
	
	else
		lRet := .F.
		SetSoapFault("ERRO!","Data do evento superior a data de bloqueio do beneficiแrio. Data de bloqueio do beneficiแrio "+cvaltochar(dDatBloq))
	endif

elseif dDatEve <= dDatInc

	lRet := .F.
	SetSoapFault("ERRO!", "Solicita็ใo de reembolso anterior a data de inclusใo no plano.")

else	// Beneficiario Ativo

	nTotDias := ddatabase - dDatEve

	if  dDatEve > ddatabase

		lRet := .F.
		cData := substr(dtos(ddatabase),7,2)+"/"+substr(dtos(ddatabase),5,2)+"/"+substr(dtos(ddatabase),1,4)
		SetSoapFault("ERRO!", "Solicita็ใo de reembolso deve possuir a data do evento menor que " + cData + ".")

	elseif nTotDias > 365

		lRet := .F.
		SetSoapFault("ERRO!", "Solicita็ใo de reembolso superior a 12 meses, a partir da data de execu็ใo do evento.")

	endif

endif

Return lRet



//------------------------------------------------------------------------------------------//
// Fun็ใo para buscar o cliente financeiro													//
// Author:  Fred Junior																		//
// Since:   12/08/22																		//
//------------------------------------------------------------------------------------------//
Static Function BusCliente(_cMatFav, cCdCliLj, _cCpf)

Local cRet		:= ""
Local nRecBA1	:= BA1->(RECNO())
Local nRecBA3	:= BA3->(RECNO())

if empty(_cMatFav)		// Nใo tem um favorecido diferente do beneficiแrio

	SA1->(DbSetOrder(1))	// A1_FILIAL+A1_COD+A1_LOJA
	if SA1->(DbSeek(xFilial("SA1") + cCdCliLj )) .and. !empty(cCdCliLj)

		if cEmpAnt == "01"
			cRet := SA1->A1_COD
		elseif cEmpAnt == "02" .and. AllTrim(_cCpf) == AllTrim(SA1->A1_CGC)		// Integral precisa coincidir o CPF
			cRet := SA1->A1_COD
		endif
	
	else

		SA1->(DbSetOrder(3))	// A1_FILIAL+A1_CGC
		if SA1->(DbSeek(xFilial("BA1") + BA1->BA1_CPFUSR))

			if cEmpAnt == "01"
				cRet := SA1->A1_COD
			elseif cEmpAnt == "02" .and. AllTrim(_cCpf) == AllTrim(SA1->A1_CGC)		// Integral precisa coincidir o CPF
				cRet := SA1->A1_COD
			endif

		endif
	
	endif

else

	BA1->(DbSetOrder(2))	// BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO
	if BA1->(DbSeek(xFilial("BA1") + _cMatFav))

		BA3->(DbSetOrder(1))	// BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_MATRIC+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB
		if BA3->(DbSeek(xFilial("BA3") + BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))

			SA1->(DbSetOrder(1))	// A1_FILIAL+A1_COD+A1_LOJA
			if SA1->(DbSeek(xFilial("SA1") + BA3->(BA3_CODCLI + BA3_LOJA) )) .and. !empty(BA3->BA3_CODCLI)

				if cEmpAnt == "01"
					cRet := SA1->A1_COD
				elseif cEmpAnt == "02" .and. AllTrim(_cCpf) == AllTrim(SA1->A1_CGC)		// Integral precisa coincidir o CPF
					cRet := SA1->A1_COD
				endif

			else
			
				SA1->(DbSetOrder(3))	// A1_FILIAL+A1_CGC
				if SA1->(DbSeek(xFilial("BA1") + BA1->BA1_CPFUSR))

					if cEmpAnt == "01"
						cRet := SA1->A1_COD
					elseif cEmpAnt == "02" .and. AllTrim(_cCpf) == AllTrim(SA1->A1_CGC)		// Integral precisa coincidir o CPF
						cRet := SA1->A1_COD
					endif

				endif
			
			endif

		endif
	
	endif

endif

BA1->(DbGoTo(nRecBA1))
BA3->(DbGoTo(nRecBA3))

return cRet



//------------------------------------------------------------------------------------------//
// Fun็ใo para buscar conta de pagamento do beneficiแrio									//
// Author:  Fred Junior																		//
// Since:   12/08/22																		//
//------------------------------------------------------------------------------------------//
Static Function BusConta(cCodCli, cBanco, cAgenc, cDvAgencia, cConta, cDgConta)

Local cRet		:= ""
Local cQuery	:= ""
Local _cAliBC	:= GetNextAlias()

cQuery := " SELECT PCT_CODIGO"
cQuery += " FROM " + RetSqlName("PCT") + " PCT"
cQuery += " WHERE PCT.D_E_L_E_T_ = ' '"
cQuery +=	" AND PCT_FILIAL = '" + xFilial("PCT") + "'"
cQuery +=	" AND PCT_CLIENT = '" +     cCodCli    + "'"
cQuery +=	" AND PCT_LOJA   = '01'"
cQuery +=	" AND PCT_BANCO  = '" +     cBanco     + "'"
cQuery +=	" AND PCT_NUMAGE = '" +     cAgenc     + "'"
if !Empty(cDvAgencia)
	cQuery += " AND PCT_DVAGE = '"+   cDvAgencia   + "'"
endif
cQuery +=	" AND PCT_NCONTA = '" +      cConta    + "'"
cQuery +=	" AND PCT_DVCONT = '" +    cDgConta    + "'"
cQuery +=	" AND PCT_STATUS IN (' ','1')"

PLSQuery(cQuery, _cAliBC)

if (_cAliBC)->(!Eof())
	cRet	:= (_cAliBC)->PCT_CODIGO
endif
(_cAliBC)->(DbCloseArea())

return cRet



//------------------------------------------------------------------------------------------//
// Fun็ใo para buscar rede nใo referenciada (e profissional de sa๚de - executante)			//
// Author:  Fred Junior																		//
// Since:   12/08/22																		//
//------------------------------------------------------------------------------------------//
Static Function BusPrfSau(_cCGCExc, _cEstd, _cCodSg, _cCRMExc, cPriName)

Local aRet		:= {"",""}
Local cNumCRM	:= PadR(AllTrim(_cCRMExc), TamSx3("BK6_CONREG")[1])
Local cSigla	:= PadR(AllTrim(_cCodSg ), TamSx3("BK6_SIGLA" )[1])
Local cEst		:= PadR(AllTrim(_cEstd  ), TamSx3("BK6_ESTCR" )[1])
Local cBkpCRM	:= cNumCRM

// primeiro vou buscar na rede nใo referenciada (entidade que passarแ a ser usada)
BK6->(DbSetOrder(4))	// BK6_FILIAL+BK6_CGC
if BK6->(DbSeek(xFilial("BK6") + AllTrim(_cCGCExc))) .and. !empty(_cCGCExc)
	aRet[1] := BK6->BK6_CODIGO
else

	BK6->(DbSetOrder(2))	// BK6_FILIAL+BK6_CONREG+BK6_SIGLA
	if BK6->(DbSeek(xFilial("BK6") + cNumCRM + cSigla )) .and. !empty(cNumCRM) .and. !empty(cSigla) .and. !empty(cEst)

		while BK6->(!EOF()) .and. BK6->(BK6_CONREG+BK6_SIGLA) == cNumCRM + cSigla

			if BK6->BK6_ESTCR == cEst .and. empty(BK6->BK6_CGC)		// somente pego com CGC em branco por que se estiver preenchido entraria no primeiro seek

				if AllTrim(BK6->BK6_SIGLA) <> 'CRM' .or. ( AllTrim(BK6->BK6_SIGLA) == 'CRM' .and. len(AllTrim(_cCGCExc)) == 11 )

					RecLock("BK6", .F.)
						BK6->BK6_CGC	:= _cCGCExc		// preencho o CGC da rede nใo referenciada encontrada
						BK6->BK6_CPF	:= iif(len(AllTrim(_cCGCExc)) == 11, _cCGCExc, "")
					MsUnLock()

					aRet[1] := BK6->BK6_CODIGO
					exit
				
				endif
			
			endif

			BK6->(DbSkip())
		end

	endif

	if empty(aRet[1])	// nใo localizou

		cNumCRM := AllTrim(cNumCRM)
		if SubStr(cNumCRM,1,2) == '52'

			cNumCRM	:= SubStr(cNumCRM, 3, len(cNumCRM)-2 )
			cNumCRM	:= AllTrim(str(val(cNumCRM)))

			if val(cNumCRM) > 0

				cNumCRM	:= PadR(AllTrim(cNumCRM), TamSx3("BK6_CONREG")[1])

				BK6->(DbSetOrder(2))	// BK6_FILIAL+BK6_CONREG+BK6_SIGLA
				if BK6->(DbSeek(xFilial("BK6") + cNumCRM + cSigla )) .and. !empty(cNumCRM) .and. !empty(cSigla) .and. !empty(cEst)

					while BK6->(!EOF()) .and. BK6->(BK6_CONREG+BK6_SIGLA) == cNumCRM + cSigla

						if BK6->BK6_ESTCR == cEst .and. empty(BK6->BK6_CGC)		// somente pego com CGC em branco por que se estiver preenchido entraria no primeiro seek

							if cPriName == SubStr(BK6->BK6_NOME,1,len(cPriName))

								if AllTrim(BK6->BK6_SIGLA) <> 'CRM' .or. ( AllTrim(BK6->BK6_SIGLA) == 'CRM' .and. len(AllTrim(_cCGCExc)) == 11 )

									RecLock("BK6", .F.)
										BK6->BK6_CGC	:= _cCGCExc		// preencho o CGC da rede nใo referenciada encontrada
										BK6->BK6_CPF	:= iif(len(AllTrim(_cCGCExc)) == 11, _cCGCExc, "")
									MsUnLock()

									aRet[1] := BK6->BK6_CODIGO
									exit
								
								endif
							
							endif
						
						endif

						BK6->(DbSkip())
					end

				endif

			endif
		
		endif

	endif

endif

if empty(aRet[1])
	cNumCRM	:= cBkpCRM
endif

// Buscar no profissional de sa๚de
NumCRM	:= PadR(AllTrim(_cCRMExc), TamSx3("BB0_NUMCR" )[1])
cSigla	:= PadR(AllTrim(_cCodSg ), TamSx3("BB0_CODSIG")[1])
cEst	:= PadR(AllTrim(_cEstd  ), TamSx3("BB0_ESTADO")[1])

BB0->(DbSetOrder(3))	// BB0_FILIAL+BB0_CGC
if BB0->(DbSeek(xFilial("BB0") + _cCGCExc )) .and. !empty(_cCGCExc)
	aRet[2]		:= BB0->BB0_CODIGO
else

	BB0->(DbSetOrder(4))	// BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
	if BB0->(DbSeek(xFilial("BB0") + cEst + cNumCRM + cSigla )) .and. !empty(cEst) .and. !empty(cNumCRM) .and. !empty(cSigla)
		aRet[2]		:= BB0->BB0_CODIGO
	else

		if SubStr(cNumCRM,1,2) == '52'

			cNumCRM	:= SubStr(cNumCRM, 3, len(cNumCRM)-2 )
			cNumCRM	:= AllTrim(str(val(cNumCRM)))

			if val(cNumCRM) > 0

				cNumCRM	:= PadR(AllTrim(cNumCRM), TamSx3("BB0_NUMCR")[1])

				BB0->(DbSetOrder(4))	// BB0_FILIAL+BB0_ESTADO+BB0_NUMCR+BB0_CODSIG+BB0_CODOPE
				if BB0->(DbSeek(xFilial("BB0") + cEst + cNumCRM + cSigla )) .and. !empty(cEst) .and. !empty(cNumCRM) .and. !empty(cSigla)

					if cPriName == SubStr(BB0->BB0_NOME,1,len(cPriName))
						aRet[2]		:= BB0->BB0_CODIGO
					endif
				
				endif

			endif
		
		endif
	
	endif

endif

return aRet



// Buscar descri็ใo do banco
Static Function RestDBanco(cCodBco)

Local cDescBanco	:= ""
Local aBancos		:= {{'100','Planner Corretora de Valores S.A.                                               '},;
						{'101','Renascen็a Distribuidora de Tํtulos e Valores Mobiliแrios Ltda.                 '},;
						{'102','XP Investimentos Corretora de Cโmbio Tํtulos e Valores Mobiliแrios S.A.         '},;
						{'104','Caixa Econ๔mica Federal                                                         '},;
						{'105','Lecca Cr้dito; Financiamento e Investimento S/A                                 '},;
						{'107','Banco BBM S.A.                                                                  '},;
						{'108','PortoCred S.A. Cr้dito; Financiamento e Investimento                            '},;
						{'111','Oliveira Trust Distribuidora de Tํtulos e Valores Mobiliแrios S.A.              '},;
						{'113','Magliano S.A. Corretora de Cambio e Valores Mobiliarios                         '},;
						{'114','Central das Cooperativas de Economia e Cr้dito M๚tuo do Estado do Espํrito Santo'},;
						{'117','Advanced Corretora de Cโmbio Ltda.                                              '},;
						{'118','Standard Chartered Bank (Brasil) S.A. Banco de Investimento                     '},;
						{'119','Banco Western Union do Brasil S.A.                                              '},;
						{'120','Banco Rodobens SA                                                               '},;
						{'121','Banco Agiplan S.A.                                                              '},;
						{'122','Banco Bradesco BERJ S.A.                                                        '},;
						{'124','Banco Woori Bank do Brasil S.A.                                                 '},;
						{'125','Brasil Plural S.A. Banco M๚ltiplo                                               '},;
						{'126','BR Partners Banco de Investimento S.A.                                          '},;
						{'127','Codepe Corretora de Valores e Cโmbio S.A.                                       '},;
						{'128','MS Bank S.A. Banco de Cโmbio                                                    '},;
						{'129','UBS Brasil Banco de Investimento S.A.                                           '},;
						{'130','Caruana S.A. Sociedade de Cr้dito; Financiamento e Investimento                 '},;
						{'131','Tullett Prebon Brasil Corretora de Valores e Cโmbio Ltda.                       '},;
						{'132','ICBC do Brasil Banco M๚ltiplo S.A.                                              '},;
						{'133','Confedera็ใo Nacional Coop. Centrais Cr้d. Econ. Familiar Solidแria – CONFESOL  '},;
						{'134','BGC Liquidez Distribuidora de Tํtulos e Valores Mobiliแrios Ltda.               '},;
						{'135','Gradual Corretora de Cโmbio; Tํtulos e Valores Mobiliแrios S.A.                 '},;
						{'136','Confedera็ใo Nacional das Cooperativas Centrais Unicred Ltda – Unicred do Brasil'},;
						{'137','Multimoney Corretora de Cโmbio Ltda                                             '},;
						{'138','Get Money Corretora de Cโmbio S.A.                                              '},;
						{'139','Intesa Sanpaolo Brasil S.A. - Banco M๚ltiplo                                    '},;
						{'140','Easynvest - Tํtulo Corretora de Valores SA                                      '},;
						{'142','Broker Brasil Corretora de Cโmbio Ltda.                                         '},;
						{'143','Treviso Corretora de Cโmbio S.A.                                                '},;
						{'144','Bexs Banco de Cโmbio S.A.                                                       '},;
						{'145','Levycam - Corretora de Cโmbio e Valores Ltda.                                   '},;
						{'146','Guitta Corretora de Cโmbio Ltda.                                                '},;
						{'147','Rico Corretora de Tํtulos e Valores Mobiliแrios S.A.                            '},;
						{'149','Facta Financeira S.A. - Cr้dito Financiamento e Investimento                    '},;
						{'157','ICAP do Brasil Corretora de Tํtulos e Valores Mobiliแrios Ltda.                 '},;
						{'163','Commerzbank Brasil S.A. - Banco M๚ltiplo                                        '},;
						{'167','S. Hayata Corretora de Cโmbio S.A.                                              '},;
						{'169','Banco Ol้ Bonsucesso Consignado S.A.                                            '},;
						{'173','BRL Trust Distribuidora de Tํtulos e Valores Mobiliแrios S.A.                   '},;
						{'177','Guide Investimentos S.A. Corretora de Valores                                   '},;
						{'180','CM Capital Markets Corretora de Cโmbio; Tํtulos e Valores Mobiliแrios Ltda.     '},;
						{'182','Dacasa Financeira S/A - Sociedade de Cr้dito; Financiamento e Investimento      '},;
						{'183','Socred S.A. - Sociedade de Cr้dito ao Microempreendedor                         '},;
						{'184','Banco Ita๚ BBA S.A.                                                             '},;
						{'188','Ativa Investimentos S.A. Corretora de Tํtulos Cโmbio e Valores                  '},;
						{'189','HS Financeira S/A Cr้dito; Financiamento e Investimentos                        '},;
						{'191','Nova Futura Corretora de Tํtulos e Valores Mobiliแrios Ltda.                    '},;
						{'204','Banco Bradesco Cart๕es S.A.                                                     '},;
						{'208','Banco BTG Pactual S.A.                                                          '},;
						{'212','Banco Original S.A.                                                             '},;
						{'213','Banco Arbi S.A.                                                                 '},;
						{'217','Banco John Deere S.A.                                                           '},;
						{'218','Banco Bonsucesso S.A.                                                           '},;
						{'222','Banco Credit Agrํcole Brasil S.A.                                               '},;
						{'224','Banco Fibra S.A.                                                                '},;
						{'233','Banco Cifra S.A.                                                                '},;
						{'237','Banco Bradesco S.A.                                                             '},;
						{'241','Banco Clแssico S.A.                                                             '},;
						{'243','Banco Mแxima S.A.                                                               '},;
						{'246','Banco ABC Brasil S.A.                                                           '},;
						{'248','Banco Boavista Interatlโntico S.A.                                              '},;
						{'249','Banco Investcred Unibanco S.A.                                                  '},;
						{'250','BCV - Banco de Cr้dito e Varejo S/A                                             '},;
						{'253','Bexs Corretora de Cโmbio S/A                                                    '},;
						{'254','Parana Banco S. A.                                                              '},;
						{'263','Banco Cacique S. A.                                                             '},;
						{'265','Banco Fator S.A.                                                                '},;
						{'266','Banco C้dula S.A.                                                               '},;
						{'300','Banco de la Nacion Argentina                                                    '},;
						{'318','Banco BMG S.A.                                                                  '},;
						{'320','China Construction Bank (Brasil) Banco M๚ltiplo S/A                             '},;
						{'341','Ita๚ Unibanco  S.A.                                                             '},;
						{'366','Banco Soci้t้ G้n้rale Brasil S.A.                                              '},;
						{'370','Banco Mizuho do Brasil S.A.                                                     '},;
						{'376','Banco J. P. Morgan S. A.                                                        '},;
						{'389','Banco Mercantil do Brasil S.A.                                                  '},;
						{'394','Banco Bradesco Financiamentos S.A.                                              '},;
						{'399','Kirton Bank S.A. - Banco M๚ltiplo                                               '},;
						{'412','Banco Capital S. A.                                                             '},;
						{'422','Banco Safra S.A.                                                                '},;
						{'456','Banco de Tokyo-Mitsubishi UFJ Brasil S.A.                                       '},;
						{'464','Banco Sumitomo Mitsui Brasileiro S.A.                                           '},;
						{'473','Banco Caixa Geral - Brasil S.A.                                                 '},;
						{'477','Citibank N.A.                                                                   '},;
						{'479','Banco ItauBank S.A.                                                             '},;
						{'487','Deutsche Bank S.A. - Banco Alemใo                                               '},;
						{'488','JPMorgan Chase Bank; National Association                                       '},;
						{'492','ING Bank N.V.                                                                   '},;
						{'494','Banco de La Republica Oriental del Uruguay                                      '},;
						{'495','Banco de La Provincia de Buenos Aires                                           '},;
						{'505','Banco Credit Suisse (Brasil) S.A.                                               '},;
						{'545','Senso Corretora de Cโmbio e Valores Mobiliแrios S.A.                            '},;
						{'600','Banco Luso Brasileiro S.A.                                                      '},;
						{'604','Banco Industrial do Brasil S.A.                                                 '},;
						{'610','Banco VR S.A.                                                                   '},;
						{'611','Banco Paulista S.A.                                                             '},;
						{'612','Banco Guanabara S.A.                                                            '},;
						{'613','Banco Pec๚nia S. A.                                                             '},;
						{'623','Banco Pan S.A.                                                                  '},;
						{'626','Banco Ficsa S. A.                                                               '},;
						{'630','Banco Intercap S.A.                                                             '},;
						{'633','Banco Rendimento S.A.                                                           '},;
						{'634','Banco Triโngulo S.A.                                                            '},;
						{'637','Banco Sofisa S. A.                                                              '},;
						{'641','Banco Alvorada S.A.                                                             '},;
						{'643','Banco Pine S.A.                                                                 '},;
						{'652','Ita๚ Unibanco Holding S.A.                                                      '},;
						{'653','Banco Indusval S. A.                                                            '},;
						{'654','Banco A. J. Renner S.A.                                                         '},;
						{'655','Banco Votorantim S.A.                                                           '},;
						{'707','Banco Daycoval S.A.                                                             '},;
						{'712','Banco Ourinvest S.A.                                                            '},;
						{'719','Banif - Bco Internacional do Funchal (Brasil) S.A.                              '},;
						{'735','Banco Neon S.A.                                                                 '},;
						{'739','Banco Cetelem S.A.                                                              '},;
						{'741','Banco Ribeirใo Preto S.A.                                                       '},;
						{'743','Banco Semear S.A.                                                               '},;
						{'745','Banco Citibank S.A.                                                             '},;
						{'746','Banco Modal S.A.                                                                '},;
						{'747','Banco Rabobank International Brasil S.A.                                        '},;
						{'748','Banco Cooperativo Sicredi S. A.                                                 '},;
						{'751','Scotiabank Brasil S.A. Banco M๚ltiplo                                           '},;
						{'752','Banco BNP Paribas Brasil S.A.                                                   '},;
						{'753','Novo Banco Continental S.A. - Banco M๚ltiplo                                    '},;
						{'754','Banco Sistema S.A.                                                              '},;
						{'755','Bank of America Merrill Lynch Banco M๚ltiplo S.A.                               '},;
						{'756','Banco Cooperativo do Brasil S/A - Bancoob                                       '},;
						{'757','Banco Keb Hana do Brasil S. A.                                                  '},;
						{'001','Banco do Brasil S.A.                                                            '},;
						{'003','Banco da Amaz๔nia S.A.                                                          '},;
						{'004','Banco do Nordeste do Brasil S.A.                                                '},;
						{'007','Banco Nacional de Desenvolvimento Econ๔mico e Social BNDES                      '},;
						{'010','Credicoamo Cr้dito Rural Cooperativa                                            '},;
						{'011','Credit Suisse Hedging-Griffo Corretora de Valores S.A.                          '},;
						{'012','Banco Inbursa de Investimentos S.A.                                             '},;
						{'014','Natixis Brasil S.A. Banco M๚ltiplo                                              '},;
						{'015','UBS Brasil Corretora de Cโmbio; Tํtulos e Valores Mobiliแrios S.A.              '},;
						{'016','Coop de Cr้d. M๚tuo dos Despachantes de Trโnsito de SC e Rio Grande do Sul      '},;
						{'017','BNY Mellon Banco S.A.                                                           '},;
						{'018','Banco Tricury S.A.                                                              '},;
						{'021','Banestes S.A. Banco do Estado do Espํrito Santo                                 '},;
						{'024','Banco Bandepe S.A.                                                              '},;
						{'025','Banco Alfa S.A.                                                                 '},;
						{'029','Banco Ita๚ Consignado S.A.                                                      '},;
						{'033','Banco Santander (Brasil) S. A.                                                  '},;
						{'036','Banco Bradesco BBI S.A.                                                         '},;
						{'037','Banco do Estado do Parแ S.A.                                                    '},;
						{'040','Banco Cargill S.A.                                                              '},;
						{'041','Banco do Estado do Rio Grande do Sul S.A.                                       '},;
						{'047','Banco do Estado de Sergipe S.A.                                                 '},;
						{'060','Confidence Corretora de Cโmbio S.A.                                             '},;
						{'062','Hipercard Banco M๚ltiplo S.A.                                                   '},;
						{'063','Banco Bradescard S.A.                                                           '},;
						{'064','Goldman Sachs do Brasil  Banco M๚ltiplo S. A.                                   '},;
						{'065','Banco AndBank (Brasil) S.A.                                                     '},;
						{'066','Banco Morgan Stanley S. A.                                                      '},;
						{'069','Banco Crefisa S.A.                                                              '},;
						{'070','Banco de Brasํlia S.A.                                                          '},;
						{'074','Banco J. Safra S.A.                                                             '},;
						{'075','Banco ABN Amro S.A.                                                             '},;
						{'076','Banco KDB do Brasil S.A.                                                        '},;
						{'077','Banco Inter S.A.                                                                '},;
						{'078','Haitong Banco de Investimento do Brasil S.A.                                    '},;
						{'079','Banco Original do Agroneg๓cio S.A.                                              '},;
						{'080','BT Corretora de Cโmbio Ltda.                                                    '},;
						{'081','BBN Banco Brasileiro de Negocios S.A.                                           '},;
						{'082','Banco Topazio S.A.                                                              '},;
						{'083','Banco da China Brasil S.A.                                                      '},;
						{'084','Uniprime Norte do Paranแ - Coop. de Econ e Cr้dito M๚tuo dos Medicos;...        '},;
						{'085','Cooperativa Central de Cr้dito Urbano - Cecred                                  '},;
						{'089','Cooperativa de Cr้dito Rural da Regiใo da Mogiana                               '},;
						{'090','Cooperativa Central de Economia e Cr้dito M๚tuo - Sicoob Unimais                '},;
						{'091','Central de Cooperativas de Economia e Cr้dito M๚tuo do Est RS - Unicred         '},;
						{'092','Brickell S.A. Cr้dito; Financiamento e Investimento                             '},;
						{'093','P๓locred Sociedade de Cr้dito ao Microempreendedor e เ Empresa de Pequeno Porte '},;
						{'094','Banco Finaxis S.A.                                                              '},;
						{'095','Banco Confidence de Cโmbio S.A.                                                 '},;
						{'097','Cooperativa Central de Cr้dito Noroeste Brasileiro Ltda - CentralCredi          '},;
						{'098','Credialian็a Cooperativa de Cr้dito Rural                                       '},;
						{'099','Uniprime Central – Central Interestadual de Cooperativas de Cr้dito Ltda.       '}}

nPos := ascan(aBancos,{|x| x[1] == alltrim(cCodBco) })
if nPos > 0
	cDescBanco	:= aBancos[nPos][2]
else
	cDescBanco	:= ""
endif

Return cDescBanco
