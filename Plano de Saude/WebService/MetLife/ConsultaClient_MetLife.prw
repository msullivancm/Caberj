#include 'protheus.ch'
#include 'parmtype.ch'

/* ----------------------------------------------------------------------------------
Funcao		Conspf(nCRM,cUF)
Autor		Mateus Medeiros
Data		08/09/2017
Descrição 	Realiza a chamada do Servico de consumo do serviço metlife


---------------------------------------------------------------------------------- */
user function ConWsMet(cState,cCity,cplano,cBairro,cLimit,cOffset,cName,cEspec)
	
	Local a_Area	:= GetArea()
	Local oWsdl    	:= Nil
	Local lRet	   	:= .f.
	Local oRetorno 	:= Nil
	Local cErro 	:= ""
	Local _cAlias	:= GetNextAlias()
	Local lMsYes	:= .T. 
	
	//Default clatitude 	:= "23.60799"
	Default cCity		:= "APARECIDA"	
	Default cplano		:= "gold"
	Default cState		:= "SP"
	
	Default cBairro		:= "CENTRO"
	Default cOffset  	:= "0"	
	Default cLimit		:= ""

	// ----------------------------------------------
	// inicia objeto client
	//-----------------------------------------------
	oWsdl := WSWS009():New()
	
	// -------------------------------------------------------
	// Alimenta os parametros de consumo do webservice,
	// -------------------------------------------------------
	oWsdl:c_cEmp 			:= cEmpAnt
	oWsdl:c_cFil 			:= cFilAnt
	oWsdl:cState         	:= cState
	oWsdl:cBairro       	:= cBairro
	oWsdl:cPLANO            := cplano
	oWsdl:cCidade           := cCity
	oWsdl:cLIMIT            := cLimit
	oWsdl:cOFFSET    		:= cOffset
	oWsdl:cproviderName    	:= cName
	oWsdl:cspeciality    	:= cEspec
		
	// ----------------------------------------------
	// Executa o método Consultar CRM
	//-----------------------------------------------
	QOut("Entrada Consulta: "+time())
	if !oWsdl:WS009A()
		oRetorno := nil			
	else
		// -------------------------------------------------------------
		// Variavel oRetorno recebe os dados retornados pelo serviço
		// caso não ocorra erro
		// -------------------------------------------------------------
		oRetorno := oWSdl:oWSWS009ARESULT
		
	endif
	
	RestArea(a_Area)
	
Return oRetorno
