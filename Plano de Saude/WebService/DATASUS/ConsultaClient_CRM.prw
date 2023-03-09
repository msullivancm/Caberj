#INCLUDE "rwmake.ch"
#include "PROTHEUS.CH"


/* ----------------------------------------------------------------------------------
Funcao		Conspf(nCRM,cUF)
Autor		Mateus Medeiros
Data		08/09/2017
Descri��o 	Realiza a chamada do Servico do datasus cnes ,
j� alimentando as variav�is e retornando um string

---------------------------------------------------------------------------------- */
user function CRMWSDL(nCRM,cUF,cSig)
	
	Local a_Area	:= GetArea()
	Local oWsdl    	:= Nil
	Local lRet	   	:= .f.
	Local oRetorno 	:= Nil
	Local cErro 	:= ""
	Local _cAlias	:= GetNextAlias()
	Local lMsYes	:= .T.
	
	Default nCRM	:= 0
	Default cUF  	:= ""
	Default cSig	:= ""
	
	//RpcSetEnv("01")
	// ----------------------------------------------
	// inicia objeto client
	//-----------------------------------------------
	oWsdl := WSWS008():New()
	
	// -------------------------------------------------------
	// Alimenta as vari�veis com os dados da chave de acesso,
	// UF e CRM
	// -------------------------------------------------------
	oWsdl:c_cEmp 		:= cEmpAnt
	oWsdl:c_cFil 		:= cFilAnt
	oWsdl:N_CRM    		:= nCRM
	oWsdl:c_UF    		:= ALLTRIM(cValToChar(cUF))
	oWsdl:c_Sig    		:= cSig //Angelo henrique - Data 26/08/2019
	
	// ----------------------------------------------
	// Executa o m�todo Consultar CRM
	//-----------------------------------------------
	conout("Entrada Consulta: "+time())
	oWsdl:WS008A()
	
	// -------------------------------------------------------------
	// Variavel oRetorno recebe os dados retornados pelo servi�o
	// caso n�o ocorra erro
	// -------------------------------------------------------------
	conout("Retorno Consulta: "+time())
	oRetorno := oWSdl:oWSWS008ARESULT
	
	RestArea(a_Area)
	
Return oRetorno