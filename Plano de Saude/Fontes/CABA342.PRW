#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO5     ºAutor  ³Marcela Coimbra     º Data ³  09/18/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rOTINA PARA CRIAÇÃO DE CARENCIA NO USUÁRIO                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/          

User Function CABA342()
    
      
	dbSelectArea("BA1")
	DbOrderNickName("BA1EMCOSUB")
	dbSeek( xFilial("BA1") + "0024000000000001001000000001001" )  
	/*
	c_Qry:=" Select * "
	c_Qry+=" from ba1010 "
	c_Qry+=" where ba1_codemp = '0024' "
	c_Qry+=" and ba1_subcon = '000000001' "
	c_Qry+=" and d_e_l_e_t_ = ' '         "
	c_Qry+=" and NOT exists ( select * from bfo010 where bfo_codemp = ba1_codemp and bfo_matric = ba1_matric and bfo_tipreg = ba1_tipreg and d_e_L_E_T_ = ' '   ) "
	c_Qry+=" and NOT exists ( select * from bfj010 where bfj_codemp = ba1_codemp and bfj_matric = ba1_matric  and d_e_L_E_T_ = ' ' ) "
	c_Qry+=" order by ba1_matric "
	
	*/  
	
	c_Qry:=" 	Select * "
	c_Qry+=" from ba1010 "
	c_Qry+=" where ba1_codemp = '0024' "
	c_Qry+=" and d_e_l_e_t_ = ' '      "
	//c_Qry+=" and ba1_datblo = ' '      "
	c_Qry+=" and ba1_subcon = '000000001' "
	c_Qry+=" and not exists (select * from bfo010 where and bfo_codint = ba1_codint and bfo_codemp = ba1_codemp and bfo_matric = ba1_matric and bfo_tipreg = ba1_tipreg and d_e_L_e_t_ = ' ') "
	c_Qry+=" and BA1_MATRIC = '016641' "

		      
	TcQuery c_Qry ALIAS "TMPBB1" NEW 
	
	n_Cont := 0
	While !TMPBB1->( EOF() ) //.AND. TMPBB1->( BA1_CODEMP + BA1_CONEMP + BA1_VERCON + BA1_SUBCON + BA1_VERSUB )  == "0024000000000001001000000001001" 	                                                      
	    			
		u_GerCarUsr(TMPBB1->BA1_SUBCON, TMPBB1->BA1_CODINT, TMPBB1->BA1_CODEMP, TMPBB1->BA1_MATRIC, TMPBB1->BA1_TIPREG, TMPBB1->BA1_CODPLA, STOD( TMPBB1->BA1_DATINC ), 'N')
	             
	    n_Cont++ 
		TMPBB1->( dbSkip()) 
	
	EndDo    
	
	TMPBB1->( dbCloseArea() )

Return                  

User Function GerCarUsr(c_SubCon, c_CodInt, c_Codemp, c_Matric, c_TipReg, c_CodPro, d_DataCar, c_Carencia)

	Local c_Qry := "" 
	Local c_Codigo := "'"  
	Local l_Parc := .T.
	
	c_Qry += "	Select BFO_CLACAR "
	c_Qry += "	from bfo010 "
	c_Qry += "	where bfo_codint = '0001' "
	c_Qry += "	and bfo_codemp = '" + c_Codemp + "' "
	c_Qry += "	and bfo_matric = '" + c_Matric + "' "
	c_Qry += "	and bfo_tipreg = '" + c_TipReg   + "' "
	c_Qry += "	and d_e_l_e_t_ = ' ' "
	c_Qry += "	ORDER BY 1 "

	TcQuery c_Qry ALIAS "TMPBFO" NEW   
    
	c_Codigo := "'"
	
	While !TMPBFO->( EOF() )    
		
		c_Codigo += TMPBFO->BFO_CLACAR + "','"	
			
		TMPBFO->( dbSkip() )                              
	
	EndDo
	
	c_Codigo:= substr(c_Codigo, 1, len(c_Codigo) - 2)     		

	
	TMPBFO->( dbCloseArea() )  
	 
	If l_Parc
		c_Qry := "	SELECT "
		c_Qry += "	BDL_CODIGO , "
		c_Qry += "	NVL(BA6_CARENC, 0) BA6_CARENC, "
		c_Qry += "	DECODE(BDL_CODIGO, '001', '1', '2') BA6_UNICAR "
		c_Qry += "	from BDL010 BDL left OUTER JOIN BA6010 BA6 "
		c_Qry += "	            ON BDL_FILIAL = ' ' "
		c_Qry += "	            AND BDL_CODIGO = BA6_CLACAR "
		c_Qry += "	            AND BA6_FILIAL = ' ' "
		c_Qry += "	            AND BA6_CODINT = '" + c_CodInt + "' "
		c_Qry += "	            AND BA6_CODIGO = '" + c_Codemp + "' "
		c_Qry += "	            AND BA6_SUBCON = '" + c_SubCon + "' "
		c_Qry += "	            AND BA6_CODPRO = '" + c_CodPro + "' " 
	 	c_Qry += "	            AND BA6.D_E_L_E_T_ = ' '    "
		c_Qry += "	            AND BDL.D_E_L_E_T_ = ' '    "
	
	     
		c_Qry += " UNION "
	
		c_Qry += " SELECT  "
		c_Qry += " 	    BAN_CLACAR CODIGO, "
		c_Qry += " 	    BAN_QTDCAR CARENC, "
		c_Qry += " 	    BAN_UNCAR UNCAR    "
		c_Qry += " 	FROM BF4010 INNER JOIN BAN010 ON  "
		c_Qry += " 	            BAN_FILIAL = ' '      "
		c_Qry += " 	            AND BAN_CODIGO = BF4_CODINT || BF4_CODPRO "
		            
		c_Qry += " 	WHERE 	   BF4_CODEMP  = '" + c_Codemp + "' "
		c_Qry += " 			AND BF4_MATRIC = '" + c_Matric + "' "
		c_Qry += " 			AND BF4_TIPREG = '" + c_TipReg + "' "
		c_Qry += " 			AND BAN_CLACAR = ' ' "
	  
		c_Qry += "	ORDER BY 1 "	
		                            
		TcQuery c_Qry ALIAS "TMPSUB" NEW   
		
		While !TMPSUB->( EOF() )    
		
		If !( TMPSUB->BDL_CODIGO  $ c_Codigo )
			RecLock("BFO", .T.)
			
				BFO->BFO_CODINT := '0001'
				BFO->BFO_CODEMP := c_Codemp
				BFO->BFO_MATRIC := c_Matric
				BFO->BFO_TIPREG := c_TipReg
				BFO->BFO_CLACAR := TMPSUB->BDL_CODIGO
				BFO->BFO_CARENC := iif(c_Carencia == 'S',TMPSUB->BA6_CARENC, 0 )
				BFO->BFO_UNICAR := TMPSUB->BA6_UNICAR
				BFO->BFO_DATCAR := d_DataCar 
				BFO->BFO_YRGIMP := "S" 
		
			BFO->(MsUnLock())
		
		EndIf
			
			TMPSUB->( dbSkip() )     
		
		EndDo
	          
	      TMPSUB->( dbCloseArea() )

	EndIf
		
Return


User Function P__LS260BUT()

	Local a_Ret := {}     
	Local a_AreaBA1 := GetArea("BA1") 
	Local a_AreaBA3 := GetArea("BA3") 

    	aadd(a_Ret,{ "Carga Carencia",{ || u_BUT260CAR() },OemtoAnsi("111"),OemtoAnsi('Carrega Carencia') } )// "Posicao Financeira"  
	
	RestArea( a_AreaBA1 )
	RestArea( a_AreaBA3 )

Return a_Ret       

User Function B__UT260CAR()     

//aDadBFO

	If MsgYesNo("Deseja atualizar tabela de carencia da família de acordo com o subcontrato?")    
	
		dbSelectArea("BFO")
		dbSetOrder(1)//BFO_FILIAL+BFO_CODINT+BFO_CODEMP+BFO_MATRIC+BFO_TIPREG+BFO_CLACAR                                                                                               
		If DBsEEK(XFILIAL("BFO") + BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC )
		     
			While !BFO->( eof() ) .and. BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC == BFO_CODINT+BFO_CODEMP+BFO_MATRIC
			
				 RecLock("BFO",.F.)

					dbdelete()

				Msunlock("BFO")	
				     
				BFO->(dbSkip())    
				DBsEEK(XFILIAL("BFO") + BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC )
			
			EndDo
		
		EndIf
		
	                                                    
	    dbSelectArea("BA1")
	    dbSetOrder(1)
	    If dbSeek(xFilial("BA1") + BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC )
		
			While !BA1->( EOF() ) .AND. BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_MATIRC == BA3->BA3_CODINT + BA3->BA3_CODEMP + BA3->BA3_MATRIC 
		
				u_GerCarUsr(BA1->BA1_SUBCON, BA1->BA1_CODINT, BA1->BA1_CODEMP, BA1->BA1_MATRIC, BA1->BA1_TIPREG, BA1->BA1_CODPLA, BA1->BA1_DATBLO, iif(BA1->BA1_XCAREN == '1', 'S', 'N') )		
				
				BA1->( dbSkip () )
	        
	        EndDo
	    	
	    EndIf
	    
    EndIf       
	
Return       
