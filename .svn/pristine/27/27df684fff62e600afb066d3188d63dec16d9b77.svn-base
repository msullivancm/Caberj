#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'


/*CHAMADO PELO GATILHO DA BAU_CGCCPF*/
User Function CABA338C

Local aArea		:= GetArea()
Local cQry		:= ""
Local c_Alias	:= GetNextAlias()
Local cCodNovo	:= ""
Local cCNPJ		:= M->BAU_CPFCGC               
Local cConsulta := "C"
Local cTabBAU	:= If(cEmpAnt == '01','BAU020','BAU010') //Caberj procura na Integral e Integral procura na Caberj
Local nCont		:= 0
Local lNovoSeq	:= .F.

If INCLUI                                         

	cQry := "SELECT BAU_CODIGO" 					+ CRLF
	cQry += "FROM " + cTabBAU 						+ CRLF
	cQry += "WHERE BAU_FILIAL = ' '" 				+ CRLF
	cQry += "  AND BAU_CPFCGC = '" + cCNPJ + "'" 	+ CRLF
	cQry += "  AND D_E_L_E_T_ = ' '" 				+ CRLF              
		
	TcQuery cQry New Alias c_Alias
	
	If c_Alias->(EOF())
		lNovoSeq := .T.
	EndIf
	
	While !c_Alias->(EOF())
	
		nCont++
		cCodNovo := c_Alias->BAU_CODIGO
		
		If ( nCont > 1 )
			MsgStop('Existe mais de 1 RDA com este CNPJ [ ' + AllTrim(cCNPJ) + ' ]',AllTrim(SM0->M0_NOMECOM))
			lNovoSeq := .T.
			Exit
		EndIf
		
		c_Alias->(DbSkip())
		
	EndDo
	
	c_Alias->(DbCloseArea())
	
	If lNovoSeq
	
		c_Alias	:= GetNextAlias()
		
	    cQry 	:= "SELECT PROXIMA_SEQUENCIA_RDA('"+cEmpAnt+"','"+cConsulta+"','"+cCNPJ+"') CODIGO FROM DUAL"	+ CRLF    
		
		TcQuery cQry New Alias c_Alias
	
		cCodNovo := c_Alias->CODIGO
		
		c_Alias->(DbCloseArea())
	
	EndIf                                            
	
Else 
    cCodNovo := M->BAU_CODIGO 

EndIf

RestArea(aArea)

Return cCodNovo             

/* SERA CHAMADA PELO PE PLSA360FIM */
User Function CABA338G            


Local cCNPJ		:= M->BAU_CPFCGC               
Local cGrava    := "G"   
Local cErro 	:= " "     
Local cQuery    := " " 

cQuery := "DECLARE " + CRLF	
cQuery += "  VS CHAR(6); " + CRLF
cQuery += "BEGIN " + CRLF   
cQuery += "  VS := PROXIMA_SEQUENCIA_RDA('"+cEmpAnt+"','"+cGrava+"','"+cCNPJ+"'); "  + CRLF
cQuery += "END; " + CRLF  
	
If TcSqlExec(cQuery) <> 0	
  cErro := " - Erro na execucao da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
  ConOut(cErro) 
EndIf  

Return