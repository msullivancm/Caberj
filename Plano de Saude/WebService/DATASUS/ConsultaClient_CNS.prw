#INCLUDE "rwmake.ch"   
#include "PROTHEUS.CH"


/* ----------------------------------------------------------------------------------
Funcao		Conspf(nCRM,cUF)
Autor		Mateus Medeiros
Data		08/09/2017
Descrição 	Realiza a chamada do Servico do datasus cnes ,
já alimentando as variavéis e retornando um string

---------------------------------------------------------------------------------- */
user function CNSWSDL(cCpf,cNome,cMae,cCampo)
	
	Local a_Area	:= GetArea()
	Local oWsdl    	:= Nil
	Local lRet	   	:= .f.
	Local oRetorno 	:= Nil
	Local cErro 	:= ""
	Local cTel		:= ""
	Local cDDI		:= ""
	Local cRet		:= ""
	Local cDDD		:= ""
	Local cFax		:= ""
	Local _cAlias	:= GetNextAlias()
	Local lMsYes	:= .T. 
	Local aRet		:= {} 
	
	Default cCpf	:= ""
	Default cNome  	:= ""
	Default cMae 	:= ""
	
	// ----------------------------------------------
	// inicia objeto client
	//-----------------------------------------------
	oWsdl := WSWS007():New()
		
	// -------------------------------------------------------
	// Alimenta as variáveis com os dados da chave de acesso,
	// UF e CRM
	// -------------------------------------------------------
	oWsdl:c_cEmp 		:= cEmpAnt
	oWsdl:c_cFil 		:= cFilAnt
	oWsdl:c_CPF    		:= ALLTRIM(cValTochar(cCpf))
	oWsdl:c_MAE    		:= ALLTRIM(cValToChar(cMae))
	oWsdl:c_NOMECOMP    := ALLTRIM(cValToChar(cNome))
	
	// ----------------------------------------------
	// Executa o método Consultar CRM
	//-----------------------------------------------
	QOut("Entrada Consulta: "+time())
	if !oWsdl:WS007B()
		
		if alltrim(cCampo) == "BTS_CPFUSR"
			cRet := M->BTS_CPFUSR
			Aviso(OemToansi("Atenção"),"Não foi encontrado dados no serviço CNES/DATASUS para CNES informado.",{"OK"})
		endif 
			
	else
		// -------------------------------------------------------------
		// Variavel oRetorno recebe os dados retornados pelo serviço
		// caso não ocorra erro
		// -------------------------------------------------------------
		
		
/*	WSDATA   cCNS                      AS string
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
*/
		
		QOut("Retorno Consulta: "+time())
		oRetorno := oWSdl:oWSWS007BRESULT
		
		aRet := ClassDataArr( oWSdl:oWSWS007BRESULT )
		
		//cRet := oRetorno:cCNS
		
	endif
	
	RestArea(a_Area)
	
Return aRet
