#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL627BOK  ºAutor  ³Marcela Coimbra     º Data ³  22/12/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para validar se a competencia contabil per-º±±
±±º          ³mite a confirmacao de um lote de cobranca.                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PL627BOK()
 
	Local l_Ret 	:= paramixb[1]
	Local n_Opcao	:= paramixb[2]
	Local c_Ambiente:= ""      
	Local n_CtIt	:= 0  
  	Local a_Itens 	:= {}
	local a_Filtro 	:= M->BDC_EXPFIF      
	Local c_Filtro 	:= "'"         
	
	Public xx_lFatPref := .F.
	Public xx_c_Qry    := .F.    
	/*
	If n_Opcao == 3
	
		a_Itens 	:= oBrwBDW:aCols                            
		
		If a_Itens[1][1] == '0024' .and. UPPER( GetEnvServer() ) == 'PROD'  
	         
	    	Alert("Faturamento da prefeitura temporariamente nao podera ser gerado em produção, favor contactar a TI")  
	    	
	    	Return .F.
	    
	    EndIf
		
	EndIf
	*/
	
/*	
	
	If Len( a_Itens ) > 0  
	
		For n_CtIt := 1 to Len( a_Itens )  
		
			c_AgEmp 	+= a_Itens[n_CtIt][1] + "',"
			c_AgCon 	+= a_Itens[n_CtIt][2] + "',"
			c_AgSub 	+= a_Itens[n_CtIt][4] + "',"
	
		Next
		
		c_AgEmp 	+= substr(c_AgEmp, 1, Len(c_AgEmp) -1 )
		c_AgCon 	+= substr(c_AgCon, 1, Len(c_AgCon) -1 )
		c_AgSub 	+= substr(c_AgSub, 1, Len(c_AgSub) -1 )
	
	EndIf
	
	dbSelectArea("BA3")      
*/
	**'Marcela Coimbra - INI - 23/10/2015 Acertar nivel de cobrança prefeitura'**  
	/* retirado pois nao esta em produção
	If n_Opcao == 3
	a_Itens 	:= oBrwBDW:aCols  
	EndIf
	
	If n_Opcao == 3  .AND. Len( a_Itens ) > 0  .AND. a_Itens[1][1] == '0024'  
		
	 	If l_Ret .and. ( 'FASS' $ M->BDC_EXPFIF .OR. 'BOLE' $ M->BDC_EXPFIF )
	    
		   If MsgYesNo("Confirma faturamento prefeitura (empresa 0024) lote " + iif( 'BOLE' $ M->BDC_EXPFIF , 'BOLETO', 'FASS') +  "?") 
		   
			   xx_lFatPref := .T.
		   		
		   Else
		   
		   		l_Ret:= .F.
		   
		   EndIf         
	    
		EndIf   
		
		If ('FASS' $ M->BDC_EXPFIF .AND. 'BOLE' $ M->BDC_EXPFIF )
	    
		  Alert( "Foi informado no filtro grupo de BOLETO e cobrança FASS, só será permitido gerar cobrança de apenas um grupo por vez. Refaça o filtro" )   
		  
		  l_Ret:= .F.
	
		EndIf   
		 	
		c_Filtro := replace( M->BDC_EXPFIF , '"', "'" )   
		c_Filtro := replace( c_Filtro , '==', "=" ) 
		c_Filtro := replace( c_Filtro , '.', " " ) 
		c_Nivel  := iif( 'BOLE' $ M->BDC_EXPFIF , '1', '0')
		
		If xx_lFatPref    
		     
		 	c_Qry := " UPDATE "+ RETSQLNAME ("BA3") + " "		
		 	c_Qry += " SET BA3_COBNIV = '" + c_Nivel + "' "	
		 	c_Qry += " WHERE BA3_FILIAL = ' ' "	
		 	c_Qry += " AND BA3_CODINT = '0001' "	
		 	c_Qry += " AND BA3_CODEMP = '0024' "	
		 	c_Qry += " AND BA3_SUBCON = '000000001' "	
		 	c_Qry += " AND " + c_Filtro	        
		 	
			If TcSqlExec(c_Qry) < 0
				ALERT("Não foi possivel adequar o nivel de cobrança. Favor contactar a TI.") 
				l_Ret:= .F.
			Endif
		 	
	//	 	TCQUERY c_Qry ALIAS "TMPBA3" NEW
		
		EndIf 
		
		 	xx_c_Qry := " UPDATE "+ RETSQLNAME ("BA3") + " "		
		 	xx_c_Qry += " SET BA3_COBNIV = '1' "	
		 	xx_c_Qry += " WHERE BA3_FILIAL = ' ' "	
		 	xx_c_Qry += " AND BA3_CODINT = '0001' "	
		 	xx_c_Qry += " AND BA3_CODEMP = '0024' "	
		 	xx_c_Qry += " AND BA3_SUBCON = '000000001' "	
		 	xx_c_Qry += " AND " + c_Filtro	        
		
		**'Marcela Coimbra - FIM - 23/10/2015 Acertar nivel de cobrança prefeitura'**
	EndIf
	*/		
Return l_Ret                                           
