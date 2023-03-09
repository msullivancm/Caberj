#INCLUDE "rwmake.ch"   
#include "PROTHEUS.CH"


/* ----------------------------------------------------------------------------------
Funcao		Conspf(nCRM,cUF)
Autor		Mateus Medeiros
Data		08/09/2017
Descrição 	Realiza a chamada do Servico do datasus cnes ,
já alimentando as variavéis e retornando um string

---------------------------------------------------------------------------------- */
user function Conswsdl(cCnes,cCnpj,cCampo)
	
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
	
	Default cCnes 	:= ""
	Default cCnpj 	:= ""

	// ----------------------------------------------
	// inicia objeto client
	//-----------------------------------------------
	oWsdl := WSWS007():New()
			
	// -------------------------------------------------------
	// Alimenta as variáveis com os dados da chave de acesso,
	// UF e CRM
	// -------------------------------------------------------
	oWsdl:c_cEmp 	:= cEmpAnt
	oWsdl:c_cFil 	:= cFilAnt
	oWsdl:c_CNES    := ALLTRIM(cValTochar(cCnes))
	oWsdl:c_CNPJ    := ALLTRIM(cValToChar(cCnpj))
	
	// ----------------------------------------------
	// Executa o método Consultar CRM
	//-----------------------------------------------
	conout("Entrada Consulta: "+time())
	if !oWsdl:WS007A()
		
		if alltrim(cCampo) == "BB8_CNES"
			cRet := M->BB8_CNES
			Aviso(OemToansi("Atenção"),"Não foi encontrado dados no serviço CNES/DATASUS para CNES informado.",{"OK"})
		else
			cRet := M->BB8_CPFCGC
			Aviso(OemToansi("Atenção"),"Não foi encontrado dados no serviço CNES/DATASUS o CPF/CNPJ informado.",{"OK"})
		endif
			
	else
		// -------------------------------------------------------------
		// Variavel oRetorno recebe os dados retornados pelo serviço
		// caso não ocorra erro
		// -------------------------------------------------------------
		conout("Retorno Consulta: "+time())
		oRetorno := oWSdl:oWSWS007ARESULT
		
		if alltrim(cCampo) = "BB8_CNES"
			cRet := oRetorno:cCODIGOCNES
				
		else
			cRet := oRetorno:cCNPJ
		endif
		
		if empty(cvaltochar(oRetorno:cCODIGOCNES))
			M->BB8_CNES := M->BB8_CNES 
		else 
			M->BB8_CNES := cvaltochar(oRetorno:cCODIGOCNES)
		endif 
		
		if empty(cvaltochar(oRetorno:cCNPJ))
			M->BB8_CPFCGC := M->BB8_CPFCGC
		else 	
			M->BB8_CPFCGC := cvaltochar(oRetorno:cCNPJ)
		endif 
		
		M->BB8_CEP    := oRetorno:cCEP
		//M->BB8_CPFCGC := oRetorno:cCNPJ
		
		M->BB8_CODMUN := oRetorno:cCODIGOMUNICIPIO
		M->BB8_MUN	  := oRetorno:cNOMEMUNICIPIO
		M->BB8_EST	  := oRetorno:cCODIGOUF
		M->BB8_BAIRRO := oRetorno:cBAIRRO
		M->BB8_END	  := oRetorno:cNOMELOGRADOURO
		M->BB8_NR_END := oRetorno:cNUMEROLOGRADOURO
		M->BB8_COMEND := oRetorno:cCOMPLEMENTO
		
		if !Empty(M->BB8_EMAIL) .or.  !Empty(M->BB8_TEL)
			lMsYes := MsgYesNo(OemToAnsi("Campos Telefone ou E-mail estão preenchidos, deseja substituí-los pelos dados que constam no Cadastro Nacional de Estabelecimentos de Saúde(CNES)"))
		endif 
		
		if lMsYes
			M->BB8_EMAIL  := oRetorno:cEMAIL  
			for nX := 1 to Len(oRetorno:oWSTELEFONE:oWSTTELEFONE)
				cDDD := ALLTRIM(UPPER(oRetorno:oWSTELEFONE:oWSTTELEFONE[nX]:cddd))
				if ALLTRIM(UPPER(oRetorno:oWSTELEFONE:oWSTTELEFONE[nX]:cDescricaoTipoTelefone)) == "FAX"
					cFax +=  alltrim(oRetorno:oWSTELEFONE:oWSTTELEFONE[nX]:cNumeroTelefone) +"/ "
				else
					cTel += alltrim(oRetorno:oWSTELEFONE:oWSTTELEFONE[nX]:cNumeroTelefone) +"/ "
				endif
			next nX
			
			M->BB8_TEL := transform(Substr(cTel,1,len(cTel)-2),pesqpict("BB8","BB8_TEL"))
			M->BB8_FAX := transform(Substr(cFax,1,len(cFax)-2),pesqpict("BB8","BB8_FAX"))
			
			M->BB8_DDD := cValToChar(cDDD)
		endif 
		
		M->BB8_NR_LAT := cValToChar(oRetorno:cLatitude)
		M->BB8_NR_LON := cValToChar(oRetorno:cLongitude)
		
	endif
	
	RestArea(a_Area)
	
Return cRet