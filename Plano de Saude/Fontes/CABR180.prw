#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"
                     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR180   ºAutor  ³Microsiga           º Data ³  04/28/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de baixas previ                                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR180()

	Local c_Ano := '2015'
	Local c_Mes := '08'
	Local c_DataBx := '20150625'

//	Processa({|| RodaRel(c_Ano, c_Mes) },"Processando...")
RodaRel(c_Ano, c_Mes, c_DataBx)

Return       

Static Function RodaRel(c_Ano, c_Mes, c_DataBx)

	Local c_Qry 	:= ""     
	Local a_Imp 	:= {}  

	Local n_VlrGer  := 0
	Local n_VlrBxd  := 0 
	Local n_VlrStVl := 0
	Local n_VlrStSd := 0      
	
	/*
	a_Imp
	
	1 = matemp  
	2 = anomes       
	3 = valor se1
	4 = saldo se1
	3 = valor recebido da previ
	4 = valor baixado no dia da previ
	5 = valor baixado dia diferente previ

	
	*/             
	
	c_Qry += " SELECT MATRICULA, SUM(VALOR) VALOR"
	c_Qry += " FROM AN_PREVI "
	c_Qry += " WHERE ANOMES =  '" + c_Ano + c_Mes + "' "  
   //	c_Qry += " and MATRICULA = '01208123' "  
	c_Qry += " GROUP BY MATRICULA "
	
	TCQUERY c_Qry ALIAS "TMP_AN" NEW
	
	While !TMP_AN->( EOF()   ) 
	

	
		c_Qry := "		select SUM(E1_VALOR) E1_VALOR, SUM(E1_SALDO) E1_SALDO "
		c_Qry += "			FROM  "
		c_Qry += "			( "
		c_Qry += "			SELECT distinct e1_num, E1_VALOR, E1_SALDO "
				
		c_Qry += "			from BA3010 INNER JOIN SE1010 "
		c_Qry += "			            ON E1_FILIAL = '01' "
		c_Qry += "			            AND E1_CLIENTE = BA3_CODCLI "
		c_Qry += "			            AND E1_CODEMP = BA3_CODEMP "
		c_Qry += "			            AND E1_MATRIC = BA3_MATRIC "
				            
		c_Qry += "			            INNER JOIN BM1010 "
		c_Qry += "			            ON BM1_FILIAL = ' ' "
		c_Qry += "			            AND BM1_PLNUCO = E1_PLNUCOB "
		c_Qry += "			            AND BM1_NUMTIT = E1_NUM "
				            
		c_Qry += "			WHERE TRIM(BA3_MATEMP) = '"+TMP_AN->MATRICULA+"'  "
		c_Qry += "			      AND E1_ANOBASE = '" + c_Ano  + "'  "
		c_Qry += "			      AND E1_MESBASE = '" + c_Mes + "'  "
		c_Qry += "			      AND SE1010.D_E_L_E_T_ = ' ' "
		c_Qry += "			      AND BA3010.D_E_L_E_T_ = ' ' "
		c_Qry += "			      AND BM1010.D_E_L_E_T_ = ' ' ) " 
		
			tcquery c_Qry ALIAS "TMP_ST" NEW  
		
			
		If !TMP_ST->(EOF()) 
		
			n_VlrStVl := TMP_ST->E1_VALOR
			n_VlrStSd := TMP_ST->E1_SALDO     
			
			
		     
		EndIf         
		
		TMP_ST->( dbCloseArea() )  
			
		//valor gerado
			
		c_Qry := " SELECT SUM(E5_VALOR) VALOR "
		c_Qry += " FROM ( "
		c_Qry += "   SELECT DISTINCT MATRICULA, BA1_CODINT||BA1_CODEMP||BA1_MATRIC, "
		c_Qry += "           E1_NUM, E1_VALOR, E1_SALDO, E5_DATA, E5_VALOR, E5_HISTOR, E5_TIPODOC"
	
		c_Qry += "   FROM AN_PREVI INNER JOIN BA3010 "
		c_Qry += "                 ON TRIM(BA3_MATEMP) = MATRICULA "
	  
		c_Qry += "                 INNER JOIN BA1010 "
		c_Qry += "                 ON BA1_FILIAL = ' ' "
		c_Qry += "                 AND BA1_CODINT = '0001' "
		c_Qry += "                 AND BA1_CODEMP = BA3_CODEMP "
		c_Qry += "                 AND BA1_MATRIC = BA3_MATRIC "
	            
		c_Qry += "                 INNER JOIN BM1010 "
		c_Qry += "                 ON BM1_FILIAL = ' ' "
		c_Qry += "                 AND BM1_CODINT = '0001' "
		c_Qry += "                 AND BM1_CODEMP = BA1_CODEMP "
		c_Qry += "                 AND BM1_MATRIC = BA1_MATRIC "
		c_Qry += "                 AND BM1_TIPREG = BA1_TIPREG "
	              
		c_Qry += "                 INNER JOIN SE1010 "
		c_Qry += "                 ON E1_FILIAL = '01' "
		c_Qry += "                 AND E1_PREFIXO = 'PLS' "
		c_Qry += "                 AND E1_NUM = BM1_NUMTIT "
	              
		c_Qry += "               INNER JOIN SE5010 "
		c_Qry += "               ON E5_FILIAL = '01' "
		c_Qry += "               AND E5_PREFIXO = 'PLS' "
		c_Qry += "               AND E5_NUMERO = E1_NUM "
		c_Qry += "   
		c_Qry += "   WHERE 	BM1_ANO = '" + c_Ano  + "' "
		c_Qry += "   		AND BM1_MES = '" + c_Mes + "' "
		c_Qry += "     		AND E5_DATA = '" + c_DataBx + "' "
		c_Qry += "   		AND MATRICULA = '" + TMP_AN->MATRICULA + "' "
	
		c_Qry += "   		AND ANOMES = '" + c_Ano + c_Mes + "' "
		c_Qry += "   		AND E5_SITUACA <> 'C' "
		c_Qry += "   		AND E5_RECPAG = 'R'  "
		c_Qry += "   		AND E5_TIPODOC <> 'ES' "
		c_Qry += "  	 	AND NOT EXISTS( SELECT * " 
		c_Qry += "   					    FROM SE5010 E51  "
		c_Qry += "           				WHERE E51.E5_PREFIXO =  SE5010.E5_PREFIXO  "
		c_Qry += "            				AND E51.E5_NUMERO  =  SE5010.E5_NUMERO  "
		c_Qry += "            				AND E51.E5_FILIAL = '01'  "
		c_Qry += "            				AND E51.E5_CLIFOR  =  SE5010.E5_CLIFOR  "
		c_Qry += "             				AND E51.E5_LOJA    =  SE5010.E5_LOJA  "
		c_Qry += "             				AND E51.E5_SEQ     =  SE5010.E5_SEQ  "
		c_Qry += "             				AND E51.E5_RECPAG  = 'P'  "
		c_Qry += "             				AND E51.E5_TIPODOC = 'ES' "
		c_Qry += "             				AND E51.d_e_l_e_t_ = ' ')   "
	   
		c_Qry += "   		AND SE5010.D_E_L_E_T_ = ' ' "
		c_Qry += "   		AND SE1010.D_E_L_E_T_ = ' ' "
		c_Qry += "   		AND BM1010.D_E_L_E_T_ = ' ' "
		c_Qry += "   		AND BA1010.D_E_L_E_T_ = ' ' "
		c_Qry += "   		AND BA3010.D_E_L_E_T_ = ' ' "
		c_Qry += "  ) "
		     
		tcquery c_Qry ALIAS "TMP_GER" NEW   
		
		If !TMP_GER->(EOF()) 
		
			n_VlrBxDt := TMP_GER->VALOR  
			
						
		     
		EndIf         
		
		TMP_GER->( dbCloseArea() )  
		
		//valor gerado
			
		c_Qry := " SELECT SUM(E5_VALOR) VALOR "
		c_Qry += " FROM ( "
		c_Qry += "   SELECT DISTINCT MATRICULA, BA1_CODINT||BA1_CODEMP||BA1_MATRIC, "
		c_Qry += "           E1_NUM, E1_VALOR, E1_SALDO, E5_DATA, E5_VALOR, E5_HISTOR, E5_TIPODOC"
	
		c_Qry += "   FROM AN_PREVI INNER JOIN BA3010 "
		c_Qry += "                 ON TRIM(BA3_MATEMP) = MATRICULA "
	  
		c_Qry += "                 INNER JOIN BA1010 "
		c_Qry += "                 ON BA1_FILIAL = ' ' "
		c_Qry += "                 AND BA1_CODINT = '0001' "
		c_Qry += "                 AND BA1_CODEMP = BA3_CODEMP "
		c_Qry += "                 AND BA1_MATRIC = BA3_MATRIC "
	            
		c_Qry += "                 INNER JOIN BM1010 "
		c_Qry += "                 ON BM1_FILIAL = ' ' "
		c_Qry += "                 AND BM1_CODINT = '0001' "
		c_Qry += "                 AND BM1_CODEMP = BA1_CODEMP "
		c_Qry += "                 AND BM1_MATRIC = BA1_MATRIC "
		c_Qry += "                 AND BM1_TIPREG = BA1_TIPREG "
	              
		c_Qry += "                 INNER JOIN SE1010 "
		c_Qry += "                 ON E1_FILIAL = '01' "
		c_Qry += "                 AND E1_PREFIXO = 'PLS' "
		c_Qry += "                 AND E1_NUM = BM1_NUMTIT "
	              
		c_Qry += "               INNER JOIN SE5010 "
		c_Qry += "               ON E5_FILIAL = '01' "
		c_Qry += "               AND E5_PREFIXO = 'PLS' "
		c_Qry += "               AND E5_NUMERO = E1_NUM "
		c_Qry += "   
		c_Qry += "   WHERE 	BM1_ANO = '" + c_Ano  + "' "
		c_Qry += "   		AND BM1_MES = '" + c_Mes + "' "
		c_Qry += "     		AND E5_DATA <> '" + c_DataBx + "' "
		c_Qry += "   		AND MATRICULA = '" + TMP_AN->MATRICULA + "' "
	
		c_Qry += "   		AND ANOMES = '" + c_Ano + c_Mes + "' "
		c_Qry += "   		AND E5_SITUACA <> 'C' "
		c_Qry += "   		AND E5_RECPAG = 'R'  "
		c_Qry += "   		AND E5_TIPODOC <> 'ES' "
		c_Qry += "  	 	AND NOT EXISTS( SELECT * " 
		c_Qry += "   					    FROM SE5010 E51  "
		c_Qry += "           				WHERE E51.E5_PREFIXO =  SE5010.E5_PREFIXO  "
		c_Qry += "            				AND E51.E5_NUMERO  =  SE5010.E5_NUMERO  "
		c_Qry += "            				AND E51.E5_FILIAL = '01'  "
		c_Qry += "            				AND E51.E5_CLIFOR  =  SE5010.E5_CLIFOR  "
		c_Qry += "             				AND E51.E5_LOJA    =  SE5010.E5_LOJA  "
		c_Qry += "             				AND E51.E5_SEQ     =  SE5010.E5_SEQ  "
		c_Qry += "             				AND E51.E5_RECPAG  = 'P'  "
		c_Qry += "             				AND E51.E5_TIPODOC = 'ES' "
		c_Qry += "             				AND E51.d_e_l_e_t_ = ' ')   "
	   
		c_Qry += "   		AND SE5010.D_E_L_E_T_ = ' ' "
		c_Qry += "   		AND SE1010.D_E_L_E_T_ = ' ' "
		c_Qry += "   		AND BM1010.D_E_L_E_T_ = ' ' "
		c_Qry += "   		AND BA1010.D_E_L_E_T_ = ' ' "
		c_Qry += "   		AND BA3010.D_E_L_E_T_ = ' ' "
		c_Qry += "  ) "
		     
		tcquery c_Qry ALIAS "TMP_BXD" NEW        
		
		If !TMP_BXD->(EOF()) 
		
			n_VlrBxd := TMP_BXD->VALOR
		     
		EndIf         
		                                       
		TMP_BXD->( dbCloseArea() )
		
		aadd(a_Imp, {'A', TMP_AN->MATRICULA,c_Ano + c_Mes, n_VlrStVl, n_VlrStSd , TMP_AN->VALOR, n_VlrBxDt, n_VlrBxd})  
		
		c_Qry := "			SELECT distinct e1_num, E1_VALOR, E1_ANOBASE, E1_MESBASE, E1_SALDO , E1_YTPEDSC "
				
		c_Qry += "			from BA3010 INNER JOIN SE1010 "
		c_Qry += "			            ON E1_FILIAL = '01' "
		c_Qry += "			            AND E1_CLIENTE = BA3_CODCLI "
		c_Qry += "			            AND E1_CODEMP = BA3_CODEMP "
		c_Qry += "			            AND E1_MATRIC = BA3_MATRIC "
				            
		c_Qry += "			            INNER JOIN BM1010 "
		c_Qry += "			            ON BM1_FILIAL = ' ' "
		c_Qry += "			            AND BM1_PLNUCO = E1_PLNUCOB "
		c_Qry += "			            AND BM1_NUMTIT = E1_NUM "
				            
		c_Qry += "			WHERE TRIM(BA3_MATEMP) = '"+TMP_AN->MATRICULA+"'  "
		c_Qry += "			      AND E1_ANOBASE = '" + c_Ano  + "'  "
		c_Qry += "			      AND E1_MESBASE = '" + c_Mes + "'  "
		c_Qry += "			      AND SE1010.D_E_L_E_T_ = ' ' "
		c_Qry += "			      AND BA3010.D_E_L_E_T_ = ' ' "
		c_Qry += "			      AND BM1010.D_E_L_E_T_ = ' ' " 
		
			tcquery c_Qry ALIAS "TMP_E1" NEW  
		
			
		While !TMP_E1->(EOF()) 
			
	   		aadd(a_Imp, {'D', 'PLS' + TMP_E1->E1_NUM, TMP_E1->E1_ANOBASE + TMP_E1->E1_MESBASE, TMP_E1->E1_VALOR, TMP_E1->E1_SALDO ,TMP_E1->E1_YTPEDSC, 0, 0})  		
		
			TMP_E1->( dbSkip() )
		
		EndDo
	
		TMP_E1->( dbCloseArea() )
						     
		TMP_AN->( dbSkip() )
		
		n_VlrGer  := 0
		n_VlrBxd  := 0   
		n_VlrStVl := 0
		n_VlrStSd := 0
	
	EndDo  
	
	TMP_AN->( dbCloseArea() )
	                                            
	
	a_cab:= {" ", "Matricula", "Ano/Mes", "Valor Gerado", "Saldo Total", "Valor enviado", "Baixado na data", "Fora da data"}
	
	DlgToExcel({{"ARRAY","Gravações da Filial" ,a_cab,a_Imp}})
	

	//ProcRegua(SE2TST->(RecCount()))
	
Return	


User Function DescPref()
      
c_Qry := " SELECT  * "
c_Qry += " FROM BBU010        "
c_Qry += " WHERE BBU_CODEMP = '0024' "
c_Qry += " AND NOT EXISTS ( SELECT * "
c_Qry += "                   FROM BFY010 "
c_Qry += "                   WHERE BFY_CODEMP = '0024' "
c_Qry += "                   AND BBU_CODEMP = BFY_CODEMP " 
c_Qry += "                   AND BBU_MATRIC = BFY_MATRIC "
c_Qry += "                   AND BBU_CODFAI = BFY_CODFAI "
c_Qry += "                   AND BBU_TIPUSr = BFY_TIPUSr "
c_Qry += "                   AND D_E_L_e_T_ = ' ') "
c_Qry += " AND D_E_L_e_T_ = ' ' "
      
tcquery c_Qry ALIAS "TMP_DESC" NEW   

While !TMP_DESC->( EOF() )
       
    	RecLock("BFY", .t.)
		BFY->BFY_FILIAL := xFilial("BFY")
		BFY->BFY_CODOPE := '0001'
		BFY->BFY_CODEMP := '0024'
		BFY->BFY_MATRIC := TMP_DESC->BBU_MATRIC
		BFY->BFY_CODFOR := '101'
		BFY->BFY_CODFAI := TMP_DESC->BBU_CODFAI
		BFY->BFY_TIPUSR := TMP_DESC->BBU_TIPUSR
		BFY->BFY_GRAUPA := ' '
		BFY->BFY_QTDDE  := 0
		BFY->BFY_QTDATE := 999
	    BFY->BFY_VALOR  := 9.00
		BFY->BFY_AUTOMA := "1" 
		BFY->BFY_TIPO   := "1"
	
		BFY->(MsUnlock())

	TMP_DESC->( dbSkip() )    
	
EndDo


Return


User Function AcOpcBYX()

Local n_Count := 0
Local c_Qry := ""
	
c_Qry += " select BYX_CODOPE, BYX_codemp, BYX_matric, BYX_tipreg, count(*) qtd "
c_Qry += " from BYX010    "
c_Qry += " where BYX_codemp = '0024'  "
c_Qry += " and d_e_l_e_t_ = ' '"
c_Qry += " group by BYX_CODOPE, BYX_codemp, BYX_matric, BYX_tipreg  "
c_Qry += " having count(*) > 1"

c_Qry += " order by 1,2,3, 4 "

TCQUERY c_Qry ALIAS "TMPBYX" NEW	

While !TMPBYX->( EOF() )

	dbSelectArea("BYX")  
	dbSetOrder(1)//BYX_FILIAL+BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG+BYX_CODOPC+BYX_VEROPC+BYX_CODFOR+BYX_CODFAI                                                              
	If dbSeek(xFilial("BYX") + TMPBYX->( BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG ) )
	
	
		For n_Count := 1 to (TMPBYX->qtd) - 1 
		       
		       If TMPBYX->(BYX_MATRIC+BYX_TIPREG)  == BYX->(BYX_MATRIC+BYX_TIPREG)
				  RecLock("BYX",.F.)
					 //	BYX->BYX_ANOMES := '201506'  // Usuario Que Excluiu a NF
						dbdelete()
				   Msunlock("BYX")
		       EndIf
		       
			BYX->( dbSkip() )
		
		Next
	
	EndIf
	
			
	TMPBYX->( dbSkip() )

EndDo
	
Return      


User Function AcOpcBZX()

Local n_Count := 0
Local c_Qry := ""
	
c_Qry += " select BZX_CODOPE, BZX_codemp, BZX_matric, BZX_tipreg, count(*) qtd "
c_Qry += " from BZX010    "
c_Qry += " where BZX_codemp = '0024'  "
c_Qry += " and d_e_l_e_t_ = ' '"
c_Qry += " group by BZX_CODOPE, BZX_codemp, BZX_matric, BZX_tipreg  "
c_Qry += " having count(*) > 1"

c_Qry += " order by 1,2,3, 4 "

TCQUERY c_Qry ALIAS "TMPBZX" NEW	

While !TMPBZX->( EOF() )

	dbSelectArea("BZX")  
	dbSetOrder(1)//BZX_FILIAL+BZX_CODOPE+BZX_CODEMP+BZX_MATRIC+BZX_TIPREG+BZX_CODOPC+BZX_VEROPC+BZX_CODFOR+BZX_CODFAI                                                              
	If dbSeek(xFilial("BZX") + TMPBZX->( BZX_CODOPE+BZX_CODEMP+BZX_MATRIC+BZX_TIPREG ) )
	
	
		For n_Count := 1 to (TMPBZX->qtd) - 1 
		       
		       If TMPBZX->(BZX_MATRIC+BZX_TIPREG)  == BZX->(BZX_MATRIC+BZX_TIPREG)
				  RecLock("BZX",.F.)
					 //	BZX->BZX_ANOMES := '201506'  // Usuario Que Excluiu a NF
						dbdelete()
				   Msunlock("BZX")
		       EndIf
		       
			BZX->( dbSkip() )
		
		Next
	
	EndIf
	
			
	TMPBZX->( dbSkip() )

EndDo
	
Return      

User Function AcOpcBYsss()

Local n_Count := 0
Local c_Qry := ""
	
c_Qry += " select BYX_CODOPE, BYX_codemp, BYX_matric, BYX_tipreg, count(*) qtd "
c_Qry += " from BYX010    "
c_Qry += " where BYX_codemp = '0024'  "
c_Qry += " and d_e_l_e_t_ = ' '"
c_Qry += " group by BYX_CODOPE, BYX_codemp, BYX_matric, BYX_tipreg  "
c_Qry += " having count(*) > 1"

c_Qry += " order by 1,2,3, 4 "

TCQUERY c_Qry ALIAS "TMPBYX" NEW	

While !TMPBYX->( EOF() )

	dbSelectArea("BYX")  
	dbSetOrder(1)//BYX_FILIAL+BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG+BYX_CODOPC+BYX_VEROPC+BYX_CODFOR+BYX_CODFAI                                                              
	If dbSeek(xFilial("BYX") + TMPBYX->( BYX_CODOPE+BYX_CODEMP+BYX_MATRIC+BYX_TIPREG ) )
	
	
		For n_Count := 1 to (TMPBYX->qtd) - 1 
		       
		       If TMPBYX->(BYX_MATRIC+BYX_TIPREG)  == BYX->(BYX_MATRIC+BYX_TIPREG)
				  RecLock("BYX",.F.)
					 //	BYX->BYX_ANOMES := '201506'  // Usuario Que Excluiu a NF
						dbdelete()
				   Msunlock("BYX")
		       EndIf
		       
			BYX->( dbSkip() )
		
		Next
	
	EndIf
	
			
	TMPBYX->( dbSkip() )

EndDo
	
Return      

User Function AcOpcBF4()

Local n_Count := 0
Local c_Qry := ""
	
c_Qry += " select BF4_CODINT, BF4_codemp, BF4_matric, BF4_tipreg, count(*) qtd "
c_Qry += " from BF4010    "
c_Qry += " where BF4_codemp = '0024'  "
c_Qry += " and d_e_l_e_t_ = ' '"
c_Qry += " group by BF4_CODINT, BF4_codemp, BF4_matric, BF4_tipreg  "
c_Qry += " having count(*) > 1"

c_Qry += " order by 1,2,3, 4 "

TCQUERY c_Qry ALIAS "TMPBF4" NEW	

While !TMPBF4->( EOF() )

	dbSelectArea("BF4")  
	dbSetOrder(1)//BF4_FILIAL+BF4_CODOPE+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG+BF4_CODOPC+BF4_VEROPC+BF4_CODFOR+BF4_CODFAI                                                              
	If dbSeek(xFilial("BF4") + TMPBF4->( BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG ) )
	
	
		For n_Count := 1 to (TMPBF4->qtd) - 1 
		       
		       If TMPBF4->(BF4_MATRIC+BF4_TIPREG)  == BF4->(BF4_MATRIC+BF4_TIPREG)
				  RecLock("BF4",.F.)
					 //	BF4->BF4_ANOMES := '201506'  // Usuario Que Excluiu a NF
						dbdelete()
				   Msunlock("BF4")
		       EndIf
		       
			BF4->( dbSkip() )
		
		Next
	
	EndIf
	
			
	TMPBF4->( dbSkip() )

EndDo
	
Return      