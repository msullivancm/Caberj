#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://10.19.1.8:8099/WS009.apw?WSDL
Gerado em        10/16/17 14:23:54
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _KPTXLWM ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSWS009
------------------------------------------------------------------------------- */

WSCLIENT WSWS009

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD WS009A
	WSMETHOD WS009B

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   c_CEMP                    AS string
	WSDATA   c_CFIL                    AS string
	WSDATA   cSTATE                    AS string
	WSDATA   cBAIRRO                   AS string
	WSDATA   cCIDADE                   AS string
	WSDATA   cPLANO                    AS string
	WSDATA   cLIMIT                    AS string
	WSDATA   cOFFSET                   AS string
	WSDATA   cPROVIDERNAME             AS string
	WSDATA   cSPECIALITY               AS string
	WSDATA   oWSWS009ARESULT           AS WS009_TSTRRDA
	WSDATA   oWSWS009BRESULT           AS WS009_TSTRRDA

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSWS009
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20170221] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSWS009
	::oWSWS009ARESULT    := WS009_TSTRRDA():New()
	::oWSWS009BRESULT    := WS009_TSTRRDA():New()
Return

WSMETHOD RESET WSCLIENT WSWS009
	::c_CEMP             := NIL 
	::c_CFIL             := NIL 
	::cSTATE             := NIL 
	::cBAIRRO            := NIL 
	::cCIDADE            := NIL 
	::cPLANO             := NIL 
	::cLIMIT             := NIL 
	::cOFFSET            := NIL 
	::cPROVIDERNAME      := NIL 
	::cSPECIALITY        := NIL 
	::oWSWS009ARESULT    := NIL 
	::oWSWS009BRESULT    := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSWS009
Local oClone := WSWS009():New()
	oClone:_URL          := ::_URL 
	oClone:c_CEMP        := ::c_CEMP
	oClone:c_CFIL        := ::c_CFIL
	oClone:cSTATE        := ::cSTATE
	oClone:cBAIRRO       := ::cBAIRRO
	oClone:cCIDADE       := ::cCIDADE
	oClone:cPLANO        := ::cPLANO
	oClone:cLIMIT        := ::cLIMIT
	oClone:cOFFSET       := ::cOFFSET
	oClone:cPROVIDERNAME := ::cPROVIDERNAME
	oClone:cSPECIALITY   := ::cSPECIALITY
	oClone:oWSWS009ARESULT :=  IIF(::oWSWS009ARESULT = NIL , NIL ,::oWSWS009ARESULT:Clone() )
	oClone:oWSWS009BRESULT :=  IIF(::oWSWS009BRESULT = NIL , NIL ,::oWSWS009BRESULT:Clone() )
Return oClone

// WSDL Method WS009A of Service WSWS009

WSMETHOD WS009A WSSEND c_CEMP,c_CFIL,cSTATE,cBAIRRO,cCIDADE,cPLANO,cLIMIT,cOFFSET,cPROVIDERNAME,cSPECIALITY WSRECEIVE oWSWS009ARESULT WSCLIENT WSWS009
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WS009A xmlns="WS009">'
cSoap += WSSoapValue("_CEMP", ::c_CEMP, c_CEMP , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_CFIL", ::c_CFIL, c_CFIL , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("STATE", ::cSTATE, cSTATE , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("BAIRRO", ::cBAIRRO, cBAIRRO , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("CIDADE", ::cCIDADE, cCIDADE , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("PLANO", ::cPLANO, cPLANO , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("LIMIT", ::cLIMIT, cLIMIT , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("OFFSET", ::cOFFSET, cOFFSET , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("PROVIDERNAME", ::cPROVIDERNAME, cPROVIDERNAME , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("SPECIALITY", ::cSPECIALITY, cSPECIALITY , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</WS009A>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WS009/WS009A",; 
	"DOCUMENT","WS009",,"1.031217",; 					
	"https://www.caberj.com.br/wspp0201/WS009.apw") //só funcionou assim, para a caberj mudar para wspp0101 ou integral mudar para wspp0201
	 	

::Init()
::oWSWS009ARESULT:SoapRecv( WSAdvValue( oXmlRet,"_WS009ARESPONSE:_WS009ARESULT","TSTRRDA",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method WS009B of Service WSWS009

WSMETHOD WS009B WSSEND c_CEMP,c_CFIL,cSTATE,cBAIRRO,cCIDADE,cPLANO,cLIMIT,cOFFSET,cPROVIDERNAME,cSPECIALITY WSRECEIVE oWSWS009BRESULT WSCLIENT WSWS009
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<WS009B xmlns="WS009">'
cSoap += WSSoapValue("_CEMP", ::c_CEMP, c_CEMP , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("_CFIL", ::c_CFIL, c_CFIL , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("STATE", ::cSTATE, cSTATE , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("BAIRRO", ::cBAIRRO, cBAIRRO , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("CIDADE", ::cCIDADE, cCIDADE , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("PLANO", ::cPLANO, cPLANO , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("LIMIT", ::cLIMIT, cLIMIT , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("OFFSET", ::cOFFSET, cOFFSET , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("PROVIDERNAME", ::cPROVIDERNAME, cPROVIDERNAME , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("SPECIALITY", ::cSPECIALITY, cSPECIALITY , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</WS009B>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"WS009/WS009B",; 
	"DOCUMENT","WS009",,"1.031217",;
	"https://www.caberj.com.br/wspp0101/WS009.apw") //só funcionou assim, para a caberj mudar para wspp0101 ou integral mudar para wspp0101
	

::Init()
::oWSWS009BRESULT:SoapRecv( WSAdvValue( oXmlRet,"_WS009BRESPONSE:_WS009BRESULT","TSTRRDA",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure TSTRRDA

WSSTRUCT WS009_TSTRRDA
	WSDATA   cLIMIT                    AS string
	WSDATA   cOFFSET                   AS string
	WSDATA   oWSSTRRDA                 AS WS009_ARRAYOFTRDA
	WSDATA   cTOTALCOUNT               AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_TSTRRDA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_TSTRRDA
Return

WSMETHOD CLONE WSCLIENT WS009_TSTRRDA
	Local oClone := WS009_TSTRRDA():NEW()
	oClone:cLIMIT               := ::cLIMIT
	oClone:cOFFSET              := ::cOFFSET
	oClone:oWSSTRRDA            := IIF(::oWSSTRRDA = NIL , NIL , ::oWSSTRRDA:Clone() )
	oClone:cTOTALCOUNT          := ::cTOTALCOUNT
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_TSTRRDA
	Local oNode3
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cLIMIT             :=  WSAdvValue( oResponse,"_LIMIT","string",NIL,"Property cLIMIT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cOFFSET            :=  WSAdvValue( oResponse,"_OFFSET","string",NIL,"Property cOFFSET as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	oNode3 :=  WSAdvValue( oResponse,"_STRRDA","ARRAYOFTRDA",NIL,"Property oWSSTRRDA as s0:ARRAYOFTRDA on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode3 != NIL
		::oWSSTRRDA := WS009_ARRAYOFTRDA():New()
		::oWSSTRRDA:SoapRecv(oNode3)
	EndIf
	::cTOTALCOUNT        :=  WSAdvValue( oResponse,"_TOTALCOUNT","string",NIL,"Property cTOTALCOUNT as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure ARRAYOFTRDA

WSSTRUCT WS009_ARRAYOFTRDA
	WSDATA   oWSTRDA                   AS WS009_TRDA OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_ARRAYOFTRDA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_ARRAYOFTRDA
	::oWSTRDA              := {} // Array Of  WS009_TRDA():New()
Return

WSMETHOD CLONE WSCLIENT WS009_ARRAYOFTRDA
	Local oClone := WS009_ARRAYOFTRDA():NEW()
	oClone:oWSTRDA := NIL
	If ::oWSTRDA <> NIL 
		oClone:oWSTRDA := {}
		aEval( ::oWSTRDA , { |x| aadd( oClone:oWSTRDA , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_ARRAYOFTRDA
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_TRDA","TRDA",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSTRDA , WS009_TRDA():New() )
			::oWSTRDA[len(::oWSTRDA)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure TRDA

WSSTRUCT WS009_TRDA
	WSDATA   oWSADDRESSES              AS WS009_ARRAYOFTENDERECO OPTIONAL
	WSDATA   cCPF_CNPJNUMBER           AS string
	WSDATA   cCRONUMBER                AS string
	WSDATA   cEMAIL                    AS string
	WSDATA   oWSNETWORK                AS WS009_ARRAYOFTREDE OPTIONAL
	WSDATA   oWSPHONENUMBERS           AS WS009_ARRAYOFTTELEF OPTIONAL
	WSDATA   cPROVIDERNAME             AS string
	WSDATA   cPROVIDERRATING           AS string
	WSDATA   cPROVIDERTYPECODE         AS string
	WSDATA   oWSSPECIALTIES            AS WS009_ARRAYOFTESPECIALIDADES OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_TRDA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_TRDA
Return

WSMETHOD CLONE WSCLIENT WS009_TRDA
	Local oClone := WS009_TRDA():NEW()
	oClone:oWSADDRESSES         := IIF(::oWSADDRESSES = NIL , NIL , ::oWSADDRESSES:Clone() )
	oClone:cCPF_CNPJNUMBER      := ::cCPF_CNPJNUMBER
	oClone:cCRONUMBER           := ::cCRONUMBER
	oClone:cEMAIL               := ::cEMAIL
	oClone:oWSNETWORK           := IIF(::oWSNETWORK = NIL , NIL , ::oWSNETWORK:Clone() )
	oClone:oWSPHONENUMBERS      := IIF(::oWSPHONENUMBERS = NIL , NIL , ::oWSPHONENUMBERS:Clone() )
	oClone:cPROVIDERNAME        := ::cPROVIDERNAME
	oClone:cPROVIDERRATING      := ::cPROVIDERRATING
	oClone:cPROVIDERTYPECODE    := ::cPROVIDERTYPECODE
	oClone:oWSSPECIALTIES       := IIF(::oWSSPECIALTIES = NIL , NIL , ::oWSSPECIALTIES:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_TRDA
	Local oNode1
	Local oNode5
	Local oNode6
	Local oNode10
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_ADDRESSES","ARRAYOFTENDERECO",NIL,NIL,NIL,"O",NIL,NIL) 
	If oNode1 != NIL
		::oWSADDRESSES := WS009_ARRAYOFTENDERECO():New()
		::oWSADDRESSES:SoapRecv(oNode1)
	EndIf
	::cCPF_CNPJNUMBER    :=  WSAdvValue( oResponse,"_CPF_CNPJNUMBER","string",NIL,"Property cCPF_CNPJNUMBER as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCRONUMBER         :=  WSAdvValue( oResponse,"_CRONUMBER","string",NIL,"Property cCRONUMBER as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cEMAIL             :=  WSAdvValue( oResponse,"_EMAIL","string",NIL,"Property cEMAIL as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	oNode5 :=  WSAdvValue( oResponse,"_NETWORK","ARRAYOFTREDE",NIL,NIL,NIL,"O",NIL,NIL) 
	If oNode5 != NIL
		::oWSNETWORK := WS009_ARRAYOFTREDE():New()
		::oWSNETWORK:SoapRecv(oNode5)
	EndIf
	oNode6 :=  WSAdvValue( oResponse,"_PHONENUMBERS","ARRAYOFTTELEF",NIL,NIL,NIL,"O",NIL,NIL) 
	If oNode6 != NIL
		::oWSPHONENUMBERS := WS009_ARRAYOFTTELEF():New()
		::oWSPHONENUMBERS:SoapRecv(oNode6)
	EndIf
	::cPROVIDERNAME      :=  WSAdvValue( oResponse,"_PROVIDERNAME","string",NIL,"Property cPROVIDERNAME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cPROVIDERRATING    :=  WSAdvValue( oResponse,"_PROVIDERRATING","string",NIL,"Property cPROVIDERRATING as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cPROVIDERTYPECODE  :=  WSAdvValue( oResponse,"_PROVIDERTYPECODE","string",NIL,"Property cPROVIDERTYPECODE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	oNode10 :=  WSAdvValue( oResponse,"_SPECIALTIES","ARRAYOFTESPECIALIDADES",NIL,NIL,NIL,"O",NIL,NIL) 
	If oNode10 != NIL
		::oWSSPECIALTIES := WS009_ARRAYOFTESPECIALIDADES():New()
		::oWSSPECIALTIES:SoapRecv(oNode10)
	EndIf
Return

// WSDL Data Structure ARRAYOFTENDERECO

WSSTRUCT WS009_ARRAYOFTENDERECO
	WSDATA   oWSTENDERECO              AS WS009_TENDERECO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_ARRAYOFTENDERECO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_ARRAYOFTENDERECO
	::oWSTENDERECO         := {} // Array Of  WS009_TENDERECO():New()
Return

WSMETHOD CLONE WSCLIENT WS009_ARRAYOFTENDERECO
	Local oClone := WS009_ARRAYOFTENDERECO():NEW()
	oClone:oWSTENDERECO := NIL
	If ::oWSTENDERECO <> NIL 
		oClone:oWSTENDERECO := {}
		aEval( ::oWSTENDERECO , { |x| aadd( oClone:oWSTENDERECO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_ARRAYOFTENDERECO
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_TENDERECO","TENDERECO",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSTENDERECO , WS009_TENDERECO():New() )
			::oWSTENDERECO[len(::oWSTENDERECO)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ARRAYOFTREDE

WSSTRUCT WS009_ARRAYOFTREDE
	WSDATA   oWSTREDE                  AS WS009_TREDE OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_ARRAYOFTREDE
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_ARRAYOFTREDE
	::oWSTREDE             := {} // Array Of  WS009_TREDE():New()
Return

WSMETHOD CLONE WSCLIENT WS009_ARRAYOFTREDE
	Local oClone := WS009_ARRAYOFTREDE():NEW()
	oClone:oWSTREDE := NIL
	If ::oWSTREDE <> NIL 
		oClone:oWSTREDE := {}
		aEval( ::oWSTREDE , { |x| aadd( oClone:oWSTREDE , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_ARRAYOFTREDE
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_TREDE","TREDE",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSTREDE , WS009_TREDE():New() )
			::oWSTREDE[len(::oWSTREDE)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ARRAYOFTTELEF

WSSTRUCT WS009_ARRAYOFTTELEF
	WSDATA   oWSTTELEF                 AS WS009_TTELEF OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_ARRAYOFTTELEF
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_ARRAYOFTTELEF
	::oWSTTELEF            := {} // Array Of  WS009_TTELEF():New()
Return

WSMETHOD CLONE WSCLIENT WS009_ARRAYOFTTELEF
	Local oClone := WS009_ARRAYOFTTELEF():NEW()
	oClone:oWSTTELEF := NIL
	If ::oWSTTELEF <> NIL 
		oClone:oWSTTELEF := {}
		aEval( ::oWSTTELEF , { |x| aadd( oClone:oWSTTELEF , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_ARRAYOFTTELEF
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_TTELEF","TTELEF",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSTTELEF , WS009_TTELEF():New() )
			::oWSTTELEF[len(::oWSTTELEF)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ARRAYOFTESPECIALIDADES

WSSTRUCT WS009_ARRAYOFTESPECIALIDADES
	WSDATA   oWSTESPECIALIDADES        AS WS009_TESPECIALIDADES OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_ARRAYOFTESPECIALIDADES
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_ARRAYOFTESPECIALIDADES
	::oWSTESPECIALIDADES   := {} // Array Of  WS009_TESPECIALIDADES():New()
Return

WSMETHOD CLONE WSCLIENT WS009_ARRAYOFTESPECIALIDADES
	Local oClone := WS009_ARRAYOFTESPECIALIDADES():NEW()
	oClone:oWSTESPECIALIDADES := NIL
	If ::oWSTESPECIALIDADES <> NIL 
		oClone:oWSTESPECIALIDADES := {}
		aEval( ::oWSTESPECIALIDADES , { |x| aadd( oClone:oWSTESPECIALIDADES , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_ARRAYOFTESPECIALIDADES
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_TESPECIALIDADES","TESPECIALIDADES",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSTESPECIALIDADES , WS009_TESPECIALIDADES():New() )
			::oWSTESPECIALIDADES[len(::oWSTESPECIALIDADES)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure TENDERECO

WSSTRUCT WS009_TENDERECO
	WSDATA   cADRESSLINE1              AS string
	WSDATA   cADRESSLINE2              AS string
	WSDATA   cCITY                     AS string
	WSDATA   cCOUNTRY                  AS string
	WSDATA   cLATITUDE                 AS string
	WSDATA   cLONGITUDE                AS string
	WSDATA   cNEIGHBORHOOD             AS string
	WSDATA   cNUMERO                   AS string
	WSDATA   cSTATE                    AS string
	WSDATA   cZIPCODE                  AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_TENDERECO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_TENDERECO
Return

WSMETHOD CLONE WSCLIENT WS009_TENDERECO
	Local oClone := WS009_TENDERECO():NEW()
	oClone:cADRESSLINE1         := ::cADRESSLINE1
	oClone:cADRESSLINE2         := ::cADRESSLINE2
	oClone:cCITY                := ::cCITY
	oClone:cCOUNTRY             := ::cCOUNTRY
	oClone:cLATITUDE            := ::cLATITUDE
	oClone:cLONGITUDE           := ::cLONGITUDE
	oClone:cNEIGHBORHOOD        := ::cNEIGHBORHOOD
	oClone:cNUMERO              := ::cNUMERO
	oClone:cSTATE               := ::cSTATE
	oClone:cZIPCODE             := ::cZIPCODE
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_TENDERECO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cADRESSLINE1       :=  WSAdvValue( oResponse,"_ADRESSLINE1","string",NIL,"Property cADRESSLINE1 as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cADRESSLINE2       :=  WSAdvValue( oResponse,"_ADRESSLINE2","string",NIL,"Property cADRESSLINE2 as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCITY              :=  WSAdvValue( oResponse,"_CITY","string",NIL,"Property cCITY as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cCOUNTRY           :=  WSAdvValue( oResponse,"_COUNTRY","string",NIL,"Property cCOUNTRY as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cLATITUDE          :=  WSAdvValue( oResponse,"_LATITUDE","string",NIL,"Property cLATITUDE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cLONGITUDE         :=  WSAdvValue( oResponse,"_LONGITUDE","string",NIL,"Property cLONGITUDE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNEIGHBORHOOD      :=  WSAdvValue( oResponse,"_NEIGHBORHOOD","string",NIL,"Property cNEIGHBORHOOD as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNUMERO            :=  WSAdvValue( oResponse,"_NUMERO","string",NIL,"Property cNUMERO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cSTATE             :=  WSAdvValue( oResponse,"_STATE","string",NIL,"Property cSTATE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cZIPCODE           :=  WSAdvValue( oResponse,"_ZIPCODE","string",NIL,"Property cZIPCODE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure TREDE

WSSTRUCT WS009_TREDE
	WSDATA   cNAME                     AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_TREDE
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_TREDE
Return

WSMETHOD CLONE WSCLIENT WS009_TREDE
	Local oClone := WS009_TREDE():NEW()
	oClone:cNAME                := ::cNAME
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_TREDE
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cNAME              :=  WSAdvValue( oResponse,"_NAME","string",NIL,"Property cNAME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure TTELEF

WSSTRUCT WS009_TTELEF
	WSDATA   cAREACODE                 AS string
	WSDATA   cNUMBER                   AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_TTELEF
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_TTELEF
Return

WSMETHOD CLONE WSCLIENT WS009_TTELEF
	Local oClone := WS009_TTELEF():NEW()
	oClone:cAREACODE            := ::cAREACODE
	oClone:cNUMBER              := ::cNUMBER
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_TTELEF
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cAREACODE          :=  WSAdvValue( oResponse,"_AREACODE","string",NIL,"Property cAREACODE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::cNUMBER            :=  WSAdvValue( oResponse,"_NUMBER","string",NIL,"Property cNUMBER as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure TESPECIALIDADES

WSSTRUCT WS009_TESPECIALIDADES
	WSDATA   cNAME                     AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WS009_TESPECIALIDADES
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WS009_TESPECIALIDADES
Return

WSMETHOD CLONE WSCLIENT WS009_TESPECIALIDADES
	Local oClone := WS009_TESPECIALIDADES():NEW()
	oClone:cNAME                := ::cNAME
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT WS009_TESPECIALIDADES
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cNAME              :=  WSAdvValue( oResponse,"_NAME","string",NIL,"Property cNAME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return


