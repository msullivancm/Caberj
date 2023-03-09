#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://10.19.1.8:8099/WS007.apw?WSDL
Gerado em        10/29/18 10:30:09
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _XOZWYWJ ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSWS007
------------------------------------------------------------------------------- */

WSCLIENT WSWS007

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD WS007A
	WSMETHOD WS007B

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   c_CEMP                    AS string
	WSDATA   c_CFIL                    AS string
	WSDATA   c_CNES                    AS string
	WSDATA   c_CNPJ                    AS string
	WSDATA   oWSWS007ARESULT           AS WS007_STRRETCNES
	WSDATA   c_CPF                     AS string
	WSDATA   c_MAE                     AS string
	WSDATA   c_NOMECOMP                AS string
	WSDATA   oWSWS007BRESULT           AS WS007_STRRETCNS

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSWS007
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.121227P-20131106] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSWS007
	::oWSWS007ARESULT    := WS007_STRRETCNES():New()
	::oWSWS007BRESULT    := WS007_STRRETCNS():New()
Return

WSMETHOD RESET WSCLIENT WSWS007
	::c_CEMP             := NIL 
	::c_CFIL             := NIL 
	::c_CNES             := NIL 
	::c_CNPJ             := NIL 
	::oWSWS007ARESULT    := NIL 
	::c_CPF              := NIL 
	::c_MAE              := NIL 
	::c_NOMECOMP         := NIL 
	::oWSWS007BRESULT    := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSWS007
Local oClone := WSWS007():New()
	oClone:_URL          := ::_URL 
	oClone:c_CEMP        := ::c_CEMP
	oClone:c_CFIL        := ::c_CFIL
	oClone:c_CNES        := ::c_CNES
	oClone:c_CNPJ        := ::c_CNPJ
	oClone:oWSWS007ARESULT :=  IIF(::oWSWS007ARESULT = NIL , NIL ,::oWSWS007ARESULT:Clone() )
	oClone:c_CPF         := ::c_CPF
	oClone:c_MAE         := ::c_MAE
	oClone:c_NOMECOMP    := ::c_NOMECOMP
	oClone:oWSWS007BRESULT :=  IIF(::oWSWS007BRESULT = NIL , NIL ,::oWSWS007BRESULT:Clone() )
Return oClone

// WSDL Method WS007A of Service WSWS007

WSMETHOD WS007A WSSEND c_CEMP,c_CFIL,c_CNES,c_CNPJ WSRECEIVE oWSWS007ARESULT WSCLIENT WSWS007
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WS007A xmlns="WS007">'
cSoap += WSSoapValue("_CEMP", ::c_CEMP, c_CEMP , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("_CFIL", ::c_CFIL, c_CFIL , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("_CNES", ::c_CNES, c_CNES , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("_CNPJ", ::c_CNPJ, c_CNPJ , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</WS007A>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WS007/WS007A",; 
	"DOCUMENT","WS007",,"1.031217",; 
	"http://10.19.1.8:8099/WS007.apw")

::Init()
::oWSWS007ARESULT:SoapRecv( WSAdvValue( oXmlRet,"_WS007ARESPONSE:_WS007ARESULT","STRRETCNES",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method WS007B of Service WSWS007

WSMETHOD WS007B WSSEND c_CEMP,c_CFIL,c_CPF,c_MAE,c_NOMECOMP WSRECEIVE oWSWS007BRESULT WSCLIENT WSWS007
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WS007B xmlns="WS007">'
cSoap += WSSoapValue("_CEMP", ::c_CEMP, c_CEMP , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("_CFIL", ::c_CFIL, c_CFIL , "string", .T. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("_CPF", ::c_CPF, c_CPF , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("_MAE", ::c_MAE, c_MAE , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += WSSoapValue("_NOMECOMP", ::c_NOMECOMP, c_NOMECOMP , "string", .F. , .F., 0 , NIL, .F.) 
cSoap += "</WS007B>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WS007/WS007B",; 
	"DOCUMENT","WS007",,"1.031217",; 
	"http://10.19.1.8:8099/WS007.apw")

::Init()
::oWSWS007BRESULT:SoapRecv( WSAdvValue( oXmlRet,"_WS007BRESPONSE:_WS007BRESULT","STRRETCNS",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure STRRETCNES

WSSTRUCT WS007_STRRETCNES
	WSDATA   cBAIRRO                   AS string
	WSDATA   cCEP                      AS string
	WSDATA   cCNPJ                     AS string
	WSDATA   cCODIGOCNES               AS string
	WSDATA   cCODIGOMUNICIPIO          AS string
	WSDATA   cCODIGOUF                 AS string
	WSDATA   cCODIGOUNIDADE            AS string
	WSDATA   cCOMPLEMENTO              AS string
	WSDATA   cDIRETORCPF               AS string
	WSDATA   cDIRETORNOME              AS string
	WSDATA   cEMAIL                    AS string
	WSDATA   cLATITUDE                 AS string
	WSDATA   cLONGITUDE                AS string
	WSDATA   cNDTATUA                  AS string
	WSDATA   cNOMEEMPRESARIAL          AS string
	WSDATA   cNOMEFANTASIA             AS string
	WSDATA   cNOMELOGRADOURO           AS string
	WSDATA   cNOMEMUNICIPIO            AS string
	WSDATA   cNUMEROLOGRADOURO         AS string
	WSDATA   cSIGLAUF                  AS string
	WSDATA   lSUS                      AS boolean
	WSDATA   oWSTELEFONE               AS WS007_ARRAYOFTTELEFONE OPTIONAL
	WSDATA   cTIPOUNIDADECODIGO        AS string
	WSDATA   cTIPOUNIDADEDESCRICAO     AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS007_STRRETCNES
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS007_STRRETCNES
Return

WSMETHOD CLONE WSCLIENT WS007_STRRETCNES
	Local oClone := WS007_STRRETCNES():NEW()
	oClone:cBAIRRO              := ::cBAIRRO
	oClone:cCEP                 := ::cCEP
	oClone:cCNPJ                := ::cCNPJ
	oClone:cCODIGOCNES          := ::cCODIGOCNES
	oClone:cCODIGOMUNICIPIO     := ::cCODIGOMUNICIPIO
	oClone:cCODIGOUF            := ::cCODIGOUF
	oClone:cCODIGOUNIDADE       := ::cCODIGOUNIDADE
	oClone:cCOMPLEMENTO         := ::cCOMPLEMENTO
	oClone:cDIRETORCPF          := ::cDIRETORCPF
	oClone:cDIRETORNOME         := ::cDIRETORNOME
	oClone:cEMAIL               := ::cEMAIL
	oClone:cLATITUDE            := ::cLATITUDE
	oClone:cLONGITUDE           := ::cLONGITUDE
	oClone:cNDTATUA             := ::cNDTATUA
	oClone:cNOMEEMPRESARIAL     := ::cNOMEEMPRESARIAL
	oClone:cNOMEFANTASIA        := ::cNOMEFANTASIA
	oClone:cNOMELOGRADOURO      := ::cNOMELOGRADOURO
	oClone:cNOMEMUNICIPIO       := ::cNOMEMUNICIPIO
	oClone:cNUMEROLOGRADOURO    := ::cNUMEROLOGRADOURO
	oClone:cSIGLAUF             := ::cSIGLAUF
	oClone:lSUS                 := ::lSUS
	oClone:oWSTELEFONE          := IIF(::oWSTELEFONE = NIL , NIL , ::oWSTELEFONE:Clone() )
	oClone:cTIPOUNIDADECODIGO   := ::cTIPOUNIDADECODIGO
	oClone:cTIPOUNIDADEDESCRICAO := ::cTIPOUNIDADEDESCRICAO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS007_STRRETCNES
	Local oNode22
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cBAIRRO            :=  WSAdvValue( oResponse,"_BAIRRO","string",NIL,"Property cBAIRRO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCEP               :=  WSAdvValue( oResponse,"_CEP","string",NIL,"Property cCEP as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCNPJ              :=  WSAdvValue( oResponse,"_CNPJ","string",NIL,"Property cCNPJ as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCODIGOCNES        :=  WSAdvValue( oResponse,"_CODIGOCNES","string",NIL,"Property cCODIGOCNES as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCODIGOMUNICIPIO   :=  WSAdvValue( oResponse,"_CODIGOMUNICIPIO","string",NIL,"Property cCODIGOMUNICIPIO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCODIGOUF          :=  WSAdvValue( oResponse,"_CODIGOUF","string",NIL,"Property cCODIGOUF as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCODIGOUNIDADE     :=  WSAdvValue( oResponse,"_CODIGOUNIDADE","string",NIL,"Property cCODIGOUNIDADE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCOMPLEMENTO       :=  WSAdvValue( oResponse,"_COMPLEMENTO","string",NIL,"Property cCOMPLEMENTO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cDIRETORCPF        :=  WSAdvValue( oResponse,"_DIRETORCPF","string",NIL,"Property cDIRETORCPF as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cDIRETORNOME       :=  WSAdvValue( oResponse,"_DIRETORNOME","string",NIL,"Property cDIRETORNOME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cEMAIL             :=  WSAdvValue( oResponse,"_EMAIL","string",NIL,"Property cEMAIL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cLATITUDE          :=  WSAdvValue( oResponse,"_LATITUDE","string",NIL,"Property cLATITUDE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cLONGITUDE         :=  WSAdvValue( oResponse,"_LONGITUDE","string",NIL,"Property cLONGITUDE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNDTATUA           :=  WSAdvValue( oResponse,"_NDTATUA","string",NIL,"Property cNDTATUA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNOMEEMPRESARIAL   :=  WSAdvValue( oResponse,"_NOMEEMPRESARIAL","string",NIL,"Property cNOMEEMPRESARIAL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNOMEFANTASIA      :=  WSAdvValue( oResponse,"_NOMEFANTASIA","string",NIL,"Property cNOMEFANTASIA as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNOMELOGRADOURO    :=  WSAdvValue( oResponse,"_NOMELOGRADOURO","string",NIL,"Property cNOMELOGRADOURO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNOMEMUNICIPIO     :=  WSAdvValue( oResponse,"_NOMEMUNICIPIO","string",NIL,"Property cNOMEMUNICIPIO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNUMEROLOGRADOURO  :=  WSAdvValue( oResponse,"_NUMEROLOGRADOURO","string",NIL,"Property cNUMEROLOGRADOURO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cSIGLAUF           :=  WSAdvValue( oResponse,"_SIGLAUF","string",NIL,"Property cSIGLAUF as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::lSUS               :=  WSAdvValue( oResponse,"_SUS","boolean",NIL,"Property lSUS as s:boolean on SOAP Response not found.",NIL,"L",NIL,NIL) 
	oNode22 :=  WSAdvValue( oResponse,"_TELEFONE","ARRAYOFTTELEFONE",NIL,NIL,NIL,"O",NIL,NIL) 
	If oNode22 != NIL
		::oWSTELEFONE := WS007_ARRAYOFTTELEFONE():New()
		::oWSTELEFONE:SoapRecv(oNode22)
	EndIf
	::cTIPOUNIDADECODIGO :=  WSAdvValue( oResponse,"_TIPOUNIDADECODIGO","string",NIL,"Property cTIPOUNIDADECODIGO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cTIPOUNIDADEDESCRICAO :=  WSAdvValue( oResponse,"_TIPOUNIDADEDESCRICAO","string",NIL,"Property cTIPOUNIDADEDESCRICAO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure STRRETCNS

WSSTRUCT WS007_STRRETCNS
	WSDATA   cCNS                      AS string
	WSDATA   cCODMUN                   AS string
	WSDATA   cCODSEXO                  AS string
	WSDATA   cCODUF                    AS string
	WSDATA   cDESCPAIS                 AS string
	WSDATA   cDTNASC                   AS string
	WSDATA   cNMCOMPLE                 AS string
	WSDATA   cNOMEMAE                  AS string
	WSDATA   cNOMEMUN                  AS string
	WSDATA   cNOMEPAI                  AS string
	WSDATA   cNUMIDCRP                 AS string
	WSDATA   cPAIS                     AS string
	WSDATA   cPGRAUQLD                 AS string
	WSDATA   cSITUACAO                 AS string
	WSDATA   cUF                       AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS007_STRRETCNS
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS007_STRRETCNS
Return

WSMETHOD CLONE WSCLIENT WS007_STRRETCNS
	Local oClone := WS007_STRRETCNS():NEW()
	oClone:cCNS                 := ::cCNS
	oClone:cCODMUN              := ::cCODMUN
	oClone:cCODSEXO             := ::cCODSEXO
	oClone:cCODUF               := ::cCODUF
	oClone:cDESCPAIS            := ::cDESCPAIS
	oClone:cDTNASC              := ::cDTNASC
	oClone:cNMCOMPLE            := ::cNMCOMPLE
	oClone:cNOMEMAE             := ::cNOMEMAE
	oClone:cNOMEMUN             := ::cNOMEMUN
	oClone:cNOMEPAI             := ::cNOMEPAI
	oClone:cNUMIDCRP            := ::cNUMIDCRP
	oClone:cPAIS                := ::cPAIS
	oClone:cPGRAUQLD            := ::cPGRAUQLD
	oClone:cSITUACAO            := ::cSITUACAO
	oClone:cUF                  := ::cUF
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS007_STRRETCNS
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCNS               :=  WSAdvValue( oResponse,"_CNS","string",NIL,"Property cCNS as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCODMUN            :=  WSAdvValue( oResponse,"_CODMUN","string",NIL,"Property cCODMUN as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCODSEXO           :=  WSAdvValue( oResponse,"_CODSEXO","string",NIL,"Property cCODSEXO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCODUF             :=  WSAdvValue( oResponse,"_CODUF","string",NIL,"Property cCODUF as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cDESCPAIS          :=  WSAdvValue( oResponse,"_DESCPAIS","string",NIL,"Property cDESCPAIS as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cDTNASC            :=  WSAdvValue( oResponse,"_DTNASC","string",NIL,"Property cDTNASC as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNMCOMPLE          :=  WSAdvValue( oResponse,"_NMCOMPLE","string",NIL,"Property cNMCOMPLE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNOMEMAE           :=  WSAdvValue( oResponse,"_NOMEMAE","string",NIL,"Property cNOMEMAE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNOMEMUN           :=  WSAdvValue( oResponse,"_NOMEMUN","string",NIL,"Property cNOMEMUN as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNOMEPAI           :=  WSAdvValue( oResponse,"_NOMEPAI","string",NIL,"Property cNOMEPAI as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNUMIDCRP          :=  WSAdvValue( oResponse,"_NUMIDCRP","string",NIL,"Property cNUMIDCRP as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cPAIS              :=  WSAdvValue( oResponse,"_PAIS","string",NIL,"Property cPAIS as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cPGRAUQLD          :=  WSAdvValue( oResponse,"_PGRAUQLD","string",NIL,"Property cPGRAUQLD as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cSITUACAO          :=  WSAdvValue( oResponse,"_SITUACAO","string",NIL,"Property cSITUACAO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cUF                :=  WSAdvValue( oResponse,"_UF","string",NIL,"Property cUF as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure ARRAYOFTTELEFONE

WSSTRUCT WS007_ARRAYOFTTELEFONE
	WSDATA   oWSTTELEFONE              AS WS007_TTELEFONE OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS007_ARRAYOFTTELEFONE
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS007_ARRAYOFTTELEFONE
	::oWSTTELEFONE         := {} // Array Of  WS007_TTELEFONE():New()
Return

WSMETHOD CLONE WSCLIENT WS007_ARRAYOFTTELEFONE
	Local oClone := WS007_ARRAYOFTTELEFONE():NEW()
	oClone:oWSTTELEFONE := NIL
	If ::oWSTTELEFONE <> NIL 
		oClone:oWSTTELEFONE := {}
		aEval( ::oWSTTELEFONE , { |x| aadd( oClone:oWSTTELEFONE , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS007_ARRAYOFTTELEFONE
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_TTELEFONE","TTELEFONE",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSTTELEFONE , WS007_TTELEFONE():New() )
			::oWSTTELEFONE[len(::oWSTTELEFONE)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure TTELEFONE

WSSTRUCT WS007_TTELEFONE
	WSDATA   cDDD                      AS string
	WSDATA   cDESCRICAOTIPOTELEFONE    AS string
	WSDATA   cNUMEROTELEFONE           AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS007_TTELEFONE
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS007_TTELEFONE
Return

WSMETHOD CLONE WSCLIENT WS007_TTELEFONE
	Local oClone := WS007_TTELEFONE():NEW()
	oClone:cDDD                 := ::cDDD
	oClone:cDESCRICAOTIPOTELEFONE := ::cDESCRICAOTIPOTELEFONE
	oClone:cNUMEROTELEFONE      := ::cNUMEROTELEFONE
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS007_TTELEFONE
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cDDD               :=  WSAdvValue( oResponse,"_DDD","string",NIL,"Property cDDD as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cDESCRICAOTIPOTELEFONE :=  WSAdvValue( oResponse,"_DESCRICAOTIPOTELEFONE","string",NIL,"Property cDESCRICAOTIPOTELEFONE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNUMEROTELEFONE    :=  WSAdvValue( oResponse,"_NUMEROTELEFONE","string",NIL,"Property cNUMEROTELEFONE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return


