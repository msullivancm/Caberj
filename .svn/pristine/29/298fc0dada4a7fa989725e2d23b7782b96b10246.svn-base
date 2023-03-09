#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://10.19.1.8:8099/rest/WS008.apw?WSDL
Gerado em        03/02/18 17:21:30
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _RNMKUNL ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSWS008
------------------------------------------------------------------------------- */

WSCLIENT WSWS008

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD WS008A
	WSMETHOD WS008B

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   c_CEMP                    AS string
	WSDATA   c_CFIL                    AS string
	WSDATA   n_CRM                     AS integer
	WSDATA   c_UF                      AS string
	WSDATA   c_Sig                     AS string
	WSDATA   oWSWS008ARESULT           AS WS008_TCRM
	WSDATA   oWSWS008BRESULT           AS WS008_TCRM

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSWS008
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20170221] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSWS008
	::oWSWS008ARESULT    := WS008_TCRM():New()
	::oWSWS008BRESULT    := WS008_TCRM():New()
Return

WSMETHOD RESET WSCLIENT WSWS008
	::c_CEMP             := NIL 
	::c_CFIL             := NIL 
	::n_CRM              := NIL 
	::c_UF               := NIL
	::c_Sig              := NIL 
	::oWSWS008ARESULT    := NIL 
	::oWSWS008BRESULT    := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSWS008
Local oClone := WSWS008():New()
	oClone:_URL          := ::_URL 
	oClone:c_CEMP        := ::c_CEMP
	oClone:c_CFIL        := ::c_CFIL
	oClone:n_CRM         := ::n_CRM
	oClone:c_UF          := ::c_UF
	oClone:c_Sig         := ::c_Sig
	oClone:oWSWS008ARESULT :=  IIF(::oWSWS008ARESULT = NIL , NIL ,::oWSWS008ARESULT:Clone() )
	oClone:oWSWS008BRESULT :=  IIF(::oWSWS008BRESULT = NIL , NIL ,::oWSWS008BRESULT:Clone() )
Return oClone

// WSDL Method WS008A of Service WSWS008

WSMETHOD WS008A WSSEND c_CEMP,c_CFIL,n_CRM,c_UF, c_Sig WSRECEIVE oWSWS008ARESULT WSCLIENT WSWS008
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WS008A xmlns="WS008">'
cSoap += WSSoapValue("_CEMP", ::c_CEMP, c_CEMP , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_CFIL", ::c_CFIL, c_CFIL , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_CRM", ::n_CRM, n_CRM , "integer", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_UF", ::c_UF, c_UF , "string", .F. , .F., 0 , NIL, .F.,.F.)
cSoap += WSSoapValue("_SIG", ::c_Sig, c_Sig , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</WS008A>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WS008/WS008A",; 
	"DOCUMENT","WS008",,"1.031217",;		
	"https://www.caberj.com.br/wspp0101/WS008.apw") 	//CABERJ
	//"https://www.integralsaude.com.br/ws/WS008.apw") 	//INTEGRAL E CMB
	
	//"http://10.19.1.8:8099/rest/WS008.apw")
	

::Init()
::oWSWS008ARESULT:SoapRecv( WSAdvValue( oXmlRet,"_WS008ARESPONSE:_WS008ARESULT","TCRM",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method WS008B of Service WSWS008

WSMETHOD WS008B WSSEND c_CEMP,c_CFIL,n_CRM,c_UF,c_Sig WSRECEIVE oWSWS008BRESULT WSCLIENT WSWS008
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WS008B xmlns="WS008">'
cSoap += WSSoapValue("_CEMP", ::c_CEMP, c_CEMP , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_CFIL", ::c_CFIL, c_CFIL , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_CRM", ::n_CRM, n_CRM , "integer", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_UF", ::c_UF, c_UF , "string", .F. , .F., 0 , NIL, .F.,.F.)  
cSoap += WSSoapValue("_SIG", ::c_Sig, c_Sig , "string", .F. , .F., 0 , NIL, .F.,.F.)   
cSoap += "</WS008B>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WS008/WS008B",; 
	"DOCUMENT","WS008",,"1.031217",;		
	"https://www.caberj.com.br/wspp0101/WS008.apw") 	//CABERJ
	//"https://www.integralsaude.com.br/ws/WS008.apw") 	//INTEGRAL E CMB
	 	
//	"http://10.19.1.8:8099/rest/WS008.apw")

::Init()
::oWSWS008BRESULT:SoapRecv( WSAdvValue( oXmlRet,"_WS008BRESPONSE:_WS008BRESULT","TCRM",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure TCRM

WSSTRUCT WS008_TCRM
	WSDATA   cCPF                      AS string
	WSDATA   cCRM                      AS string
	WSDATA   cESPECIALIDADE            AS string
	WSDATA   cNOME                     AS string
	WSDATA   cSITUACAO                 AS string
	WSDATA   cUF                       AS string
	WSDATA   CSIG                      AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS008_TCRM
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS008_TCRM
Return

WSMETHOD CLONE WSCLIENT WS008_TCRM
	Local oClone := WS008_TCRM():NEW()
	oClone:cCPF                 := ::cCPF
	oClone:cCRM                 := ::cCRM
	oClone:cESPECIALIDADE       := ::cESPECIALIDADE
	oClone:cNOME                := ::cNOME
	oClone:cSITUACAO            := ::cSITUACAO
	oClone:cUF                  := ::cUF
	oClone:cSIG                 := ::cSIG
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS008_TCRM
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCPF               :=  WSAdvValue( oResponse,"_CPF","string",NIL,"Property cCPF as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCRM               :=  WSAdvValue( oResponse,"_CRM","string",NIL,"Property cCRM as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cESPECIALIDADE     :=  WSAdvValue( oResponse,"_ESPECIALIDADE","string",NIL,"Property cESPECIALIDADE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNOME              :=  WSAdvValue( oResponse,"_NOME","string",NIL,"Property cNOME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cSITUACAO          :=  WSAdvValue( oResponse,"_SITUACAO","string",NIL,"Property cSITUACAO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cUF                :=  WSAdvValue( oResponse,"_UF","string",NIL,"Property cUF as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::CSIG               :=  WSAdvValue( oResponse,"_SIG","string",NIL,"Property cSig as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
Return