#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE _cEol  CHR(13)+CHR(10)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³caba119   ºAutor  ³Marcela Coimbra     º Data ³  09/18/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ROTINA PARA CRIAÇÃO DE CARENCIA NO USUÁRIO                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/          

User Function CABA119(cCodEmp , cContrato , cVCont , cSubCon , cVScon , cFamilia , cTpReg , dDtInc , dDtFim  ,   nCarencia , nFazCar1 )       

private nQtdaAssi := 0    
private nQtdaCar  := 0
private pvez      := .T. 
PRIVATE nFazCar   := nFazCar1           
                                                                            
	c_Qry:=" Select * "                      + _cEol
	c_Qry+="  from " + RetSqlName("BA1") +" BA1 " + _cEol            
    c_Qry+=" where BA1_FILIAL = '" + xFilial("BA1") + "' "+ _cEol   

    If !empty(trim(cCodEmp))
	   c_Qry+=" AND ba1_codemp = '"+cCodEmp+"' "  + _cEol 
	EndIf                                                            

	 If !empty(trim(cContrato))
	   c_Qry+=" AND ba1_conemp = '"+cContrato+"' "  + _cEol 
	EndIf   
	
	 If !empty(trim(cVCont))
	   c_Qry+=" AND ba1_vercon = '"+cVCont+"' "  + _cEol 
	EndIf   

	
	 If !empty(trim(cSubCon))
	   c_Qry+=" AND ba1_subcon = '"+cSubCon+"' "  + _cEol 
	EndIf   
	
    If !empty(trim(cVScon))
	   c_Qry+=" AND ba1_versub = '"+cVScon+"' "  + _cEol 
	EndIf   
	      
	If !empty(trim(cFamilia ))
       c_Qry+=" and BA1_MATRIC = '"+cFamilia +"' "  + _cEol
    EndIf                     
    
	If !empty(trim(cTpReg))
	   c_Qry+=" and BA1_TIPREG = '"+cTpReg+"' "  + _cEol  
 	EndIf                                         
 
	If !empty(trim(dDtinc)) 	                            
	   c_Qry+=" and BA1_DATINC >= '"+dDtinc+"' and BA1_DATINC <= '"+dDtFim +"' "   + _cEol                              
	/*   If nOprelac == 1 
          c_Qry+=" and BA1_DATINC > '"+dDtinc+"' "  + _cEol 
       ElseIf nOprelac == 3 
          c_Qry+=" and BA1_DATINC  = '"+dDtinc+"' "  + _cEol    
       ElseIf nOprelac == 2 
          c_Qry+=" and BA1_DATINC < '"+dDtinc+"' "  + _cEol               
       Else    
          c_Qry+=" and BA1_DATINC  = '"+dDtinc+"' "  + _cEol    
       EndIf   */
 	EndIf
	c_Qry+=" and d_e_l_e_t_ = ' '      "       + _cEol
    c_Qry+=" and ba1_datblo = ' '      "       + _cEol
    
	If Select("TMPBB1") <> 0  
       ("TMPBB1")->(DbCloseArea())
    EndIf
    
	TcQuery c_Qry ALIAS "TMPBB1" NEW 
	
	n_Cont := 0
	While !TMPBB1->( EOF() ) 
	    			
		GerCarUsr(TMPBB1->BA1_CONEMP , TMPBB1->BA1_VERCON , TMPBB1->BA1_SUBCON , TMPBB1->BA1_VERSUB , TMPBB1->BA1_CODINT, TMPBB1->BA1_CODEMP, TMPBB1->BA1_MATRIC, TMPBB1->BA1_TIPREG, TMPBB1->BA1_CODPLA, STOD( TMPBB1->BA1_DATINC ),  nCarencia) 
	             
	    n_Cont++ 
		TMPBB1->( dbSkip()) 
	
	EndDo    
	
	TMPBB1->( dbCloseArea() )     
	
	
	    MsgAlert("Foram Processados  "+ str(nQtdaAssi) +"   Assistidos ,"+ _cEol +" Atribuidos "+ str(nQtdaCar) +" classe de carencias para cada usuario ","Atencao!")

Return                  

Static Function GerCarUsr(c_ConEmp , c_vercon  , c_SubCon , c_versub ,c_CodInt, c_Codemp, c_Matric, c_TipReg, c_CodPro, d_DataCar, c_Carencia )

	Local c_Qry := "" 
	Local c_Codigo := "'"  
	Local l_Parc := .T.      
	Local cClaCar  := ' ' 
    Local c_Qtdcar := 0
    Local cUnicar  := ' '   
    local cAlias   :=' '   	
	 
    c_Qry += "	Select R_E_C_N_O_ Rec  " + _cEol     
   	c_Qry += "	 from " + RetSqlName("BFO") +" BFO" + _cEol           
    c_Qry += "	where BFO_FILIAL = '" + xFilial("BFO") + "' "+ _cEol
	c_Qry += "	AND bfo_codint = '0001' "      + _cEol
	c_Qry += "	and bfo_codemp = '" + c_Codemp + "' " + _cEol
	c_Qry += "	and bfo_matric = '" + c_Matric + "' " + _cEol
	c_Qry += "	and bfo_tipreg = '" + c_TipReg   + "' " + _cEol
	c_Qry += "	and d_e_l_e_t_ = ' ' " + _cEol                       
	
	 If Select(("TMPBFO")) <> 0              
    
       ("TMPBFO")->(DbCloseArea())  
        
    Endif                   
	
	TcQuery c_Qry ALIAS "TMPBFO" NEW   
     
    dbSelectArea("BFO")    
    
    If !TMPBFO->( EOF() ) .and. nFazCar  == 1 

   //    If ApMsgYesNo("Existe Lançamento De Carencia Para a Matricula  : "+ c_Codemp +" " + c_Matric +" " + c_TipReg +" !!!"+_cEol +" Deseja Altera a(s) Carencia já Parametrizadas?") 
   //    If ApMsgYesNo("Existe Programações  Ativas ou Suspensas para a Competencia : "+ c_Matric +" !!!"+_cEol +"Deseja Altera o(s) Status  para Cancelado ?") 
      	  While !TMPBFO->( EOF() )    
	                    
                BFO->(DbGoto(TMPBFO->Rec))
  	 		         
  	 		    RecLock("BFO",.F.)

                BFO->(dbdelete())
			 
		 	    BFO->(Msunlock())	
				     		
		        TMPBFO->( dbSkip() )                              
	
	      EndDo
	
//          TMPBFO->( dbCloseArea() )  
          
    ElseIf nFazCar  == 2                          
       
  //        TMPBFO->( dbCloseArea() )  
       
          Return()
        
    EndIf         
     // NIVEL FAMILIA     
    c_Qry := "	Select bfj_clacar cClaCar ,   "  + _cEol
    c_Qry += "         nvl(bfj_carenc, 0) ccarenc0 ,  "  + _cEol
   	c_Qry += "         nvl(bfj_caredu, 0) ccarenc1 , "  + _cEol
	c_Qry += "         bfj_unicar cUnicar  "    + _cEol
	c_Qry += "	from " + RetSqlName("BFJ") +" BFJ" + _cEol	
	c_Qry += "	 where BFJ_FILIAL = '" + xFilial("BFJ") + "' "+ _cEol
    c_Qry += "	   AND bfj_codint = '0001' "             + _cEol
	c_Qry += "     and bfj_codemp = '" + c_Codemp + "' " + _cEol
	c_Qry += "	   and bfj_matric = '" + c_Matric + "' " + _cEol
	c_Qry += "	   and d_e_l_e_t_ = ' ' "                + _cEol
    c_Qry += "	 ORDER BY 1 "                            + _cEol
    If Select(("TMPSUB")) <> 0              
    
       ("TMPSUB")->(DbCloseArea())  
        
    Endif                   
	     
    TcQuery c_Qry ALIAS "TMPSUB" NEW   
	                    
	dbgotop("TMPSUB")   
	
	cAlias   :='BFJ'
    
    If TMPSUB->( EOF() )      
     	("TMPSUB")->(DbCloseArea())      
     	
		c_Qry := "	SELECT "                        + _cEol
		c_Qry += "	BDL_CODIGO cClaCar , "          + _cEol
 		c_Qry += "	NVL(BA6_CARENC, 0) cCarenc0 , " + _cEol     
    	c_Qry += "	nvl(BA6_caredu, 0) ccarenc1 , " + _cEol    
		c_Qry += "	BA6_UNICAR cUnicar   "          + _cEol    		
 
		c_Qry += "	from " + RetSqlName("BDL") + " BDL left OUTER JOIN " + RetSqlName("BA6") + " BA6 "     + _cEol

		c_Qry += "	            ON   BA6_FILIAL = '" + xFilial("BA6") + "'  "          + _cEol
		c_Qry += "	            AND BDL_CODIGO = BA6_CLACAR "  + _cEol
		c_Qry += "	      WHERE BDL_FILIAL = '" + xFilial("BDL") + "' "+ _cEol
		c_Qry += "	        AND BA6_CODINT = '" + c_CodInt + "' " + _cEol 
		c_Qry += "	        AND BA6_CODIGO = '" + c_Codemp + "' " + _cEol                                                     
    	c_Qry += "	        AND BA6_NUMCON = '" + c_ConEmp + "' " + _cEol      
    	c_Qry += "	        AND BA6_VERCON = '" + c_vercon + "' " + _cEol    	
		c_Qry += "	        AND BA6_SUBCON = '" + c_SubCon + "' " + _cEol 
		c_Qry += "	        AND BA6_VERSUB = '" + c_versub + "' " + _cEol
		
		c_Qry += "	        AND BA6_CODPRO = '" + c_CodPro + "' " + _cEol
	 	c_Qry += "	        AND BA6.D_E_L_E_T_ = ' '    "  + _cEol
		c_Qry += "	        AND BDL.D_E_L_E_T_ = ' '    "  + _cEol 
		
        c_Qry += "	ORDER BY 1 "	                                 
        
	    If Select(("TMPSUB")) <> 0   
	    
	       ("TMPSUB")->(DbCloseArea())  
	         
        Endif                   
	     
     	TcQuery c_Qry ALIAS "TMPSUB" NEW   
     	
     	dbgotop("TMPSUB") 
     	
     	cAlias   :='BA6'     
     	
        If TMPSUB->( EOF() )  
         
            ("TMPSUB")->(DbCloseArea())  
 
			c_Qry := " SELECT  BAN_CLACAR cClaCar ,  "+ _cEol
			c_Qry += " 	       nVL(BAN_QTDCAR , 0) cCarenc0 , "+ _cEol 
	 	   	c_Qry += " 	       nvl(BAN_caredu , 0) ccarenc1 , "+ _cEol
			c_Qry += " 	       BAN_UNCAR  cUnicar    "+ _cEol

    		c_Qry += "	FROM " + RetSqlName("BAN") + " BAN "     + _cEol
			c_Qry += " 	WHERE BAN_FILIAL = '" + xFilial("BAN") + "'       "+ _cEol
			c_Qry += " 	  AND BAN_CODIGO = '"+c_CodInt+c_CodPro+"' "+ _cEol 
		    c_Qry += " 	  AND BAN.D_E_L_E_T_ = ' ' "+ _cEol
	  
			c_Qry += "	ORDER BY 1 "	+ _cEol

            If Select(("TMPSUB")) <> 0  

               ("TMPSUB")->(DbCloseArea())  

            Endif                   
	     
	        TcQuery c_Qry ALIAS "TMPSUB" NEW   
	        
            cAlias   := 'BAN'
            
		EndIf 
		
	EndIf	          
		    
		    While !TMPSUB->( EOF() )    
		
			RecLock("BFO", .T.)
			
				BFO->BFO_CODINT := '0001'
				BFO->BFO_CODEMP := c_Codemp
				BFO->BFO_MATRIC := c_Matric
				BFO->BFO_TIPREG := c_TipReg
				BFO->BFO_CLACAR := TMPSUB->cClaCar
				BFO->BFO_CARENC := iif(c_Carencia == 1, 0 , (IIf(c_Carencia == 2,TMPSUB->cCarenc0, (IIf (c_Carencia == 3 , TMPSUB->cCarenc1 , 0 ))))) 
				BFO->BFO_UNICAR := TMPSUB->cUnicar 
				BFO->BFO_DATCAR := d_DataCar 
				BFO->BFO_YRGIMP := "S" 
		        
		        if pvez                                                                                 
   		        
   		           nQtdaCar := nQtdaCar + 1
   		        
   		        EndIf 
   		           
			BFO->(MsUnLock())
		
			
			TMPSUB->( dbSkip() )     
		
		EndDo
// grava log 
/*		RecLock("ZRI", .T.)

            ZRI_FILIAL  := xFilial("ZRI")
            ZRI_USUAR   := SubStr(cUSUARIO,7,15)
            ZRI_DATA    := DATE()    
            ZRI_HORA    := Time()
             := mv_par01 //Codigo da Empresa    
             := mv_par02 //Contrato             
             := mv_par03 //Versao Contrato      
             := mv_par04 //Sub Contrato         
             := mv_par05 //Versao Sub Contrato  
             := mv_par06 //Familia(matricula)  
             := mv_par07 // Tip Reg  
             := mv_par08 // Data Inclusão 
             := mv_par09 // Relação Data 
             := mv_par10 // Carencia   
             := cAlias   // Arquivo origem da Carencia
          
				
	    ZRI->(MsUnLock())

*/
	      nQtdaAssi := nQtdaAssi + 1
	      pvez := .F.                                                                                       
	      TMPSUB->( dbCloseArea() )	 
         		
	      
Return
/*
*/ 