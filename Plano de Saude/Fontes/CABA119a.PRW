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
±±ºDesc.     ³ ROTINA PARA TRANSFERENCIA DA CARENCIA NO USUÁRIO            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/          

User Function CABA119a( cMatAnt , cMatAtu  )       

private nQtdaAssi := 0    
private nQtdaCar  := 0
private pvez      := .T. 
//PRIVATE nFazCar   := nFazCar1           
                                  
   	c_Qry:=" SELECT ba11.BA1_CODEMP CODEMP1, ba11.BA1_MATRIC MATRIC1, ba11.BA1_TIPREG TIPREG1, ba11.BA1_NOMUSR NOMUSR1, ba11.BA1_CPFUSR CPFUSR1 , ba11.BA1_MATVID MATVID1 , "+ _cEol
    c_Qry+="        ba12.BA1_CODEMP CODEMP2, ba12.BA1_MATRIC MATRIC2, ba12.BA1_TIPREG TIPREG2, ba12.BA1_NOMUSR NOMUSR2, ba12.BA1_CPFUSR CPFUSR2 , ba12.BA1_MATVID MATVID2   "+ _cEol
    c_Qry+="   FROM " + RetSqlName("BA1") +" ba11 , " + RetSqlName("BA1") +" BA12 " + _cEol
    c_Qry+="  WHERE ba11.BA1_FILIAL ='" + xFilial("BA1") + "' AND ba11.D_e_l_e_t_ = ' ' " + _cEol
    c_Qry+="    and ba12.BA1_FILIAL ='" + xFilial("BA1") + "' AND ba12.D_e_l_e_t_ = ' ' " + _cEol    
     
//    c_Qry+=" B11.BA1_CODINT || B11.BA1_CODEMP || ba11.BA1_MATRIC || ba11.BA1_TIPREG = '"+ cMatAtu +"'"   
//    c_Qry+=" B12.BA1_CODINT || B12.BA1_CODEMP || ba12.BA1_MATRIC || ba12.BA1_TIPREG = '"+ cMatANt +"'"      
    
    c_Qry+=" and BA11.BA1_CODEMP = '0182'   and ba11.ba1_datinc >= '20171201'   " + _cEol
//    c_Qry+=" and ((ba12.ba1_codpla = '0054' and ba11.ba1_codpla = '0078')       " + _cEol
//    c_Qry+="  OR (ba12.ba1_codpla = '0056'  and ba11.ba1_codpla = '0072') )     " + _cEol
    c_Qry+=" and BA12.BA1_CODEMP = '0254'   and ba12.ba1_datBLO = '20171130'    " + _cEol
    
//    c_Qry+="    AND ba11.BA1_IMAGE = 'ENABLE' "+ _cEol        
//    c_Qry+="    AND ba11.BA1_IMAGE = 'DISABLE' "+ _cEol
    c_Qry+="    AND ba12.BA1_IMAGE = 'DISABLE' "+ _cEol
    c_Qry+="    AND ba11.ba1_matvid =  ba12.ba1_matvid"+ _cEol
    c_Qry+=" ORDER BY 2,3 "+ _cEol

	If Select("TMPBB1") <> 0  
       ("TMPBB1")->(DbCloseArea())
    EndIf
    
	TcQuery c_Qry ALIAS "TMPBB1" NEW 
	
	n_Cont := 0 
	
	While !TMPBB1->( EOF() ) 
	    			
		GerCarUsr( TMPBB1->CODEMP1, TMPBB1->MATRIC1, TMPBB1->TIPREG1, TMPBB1->CODEMP2, TMPBB1->MATRIC2, TMPBB1->TIPREG2) 
	             
	    n_Cont++ 
		TMPBB1->( dbSkip()) 
	
	EndDo    
	
	TMPBB1->( dbCloseArea() )        
	
	MsgAlert("Foram Processados  "+ str(nQtdaAssi) +"   Assistidos ,"+ _cEol +" Atribuidos "+ str(nQtdaCar) +" classe de carencias para cada usuario ","Atencao!")
	
Return                  

Static Function GerCarUsr( c_Codemp1, c_Matric1, c_TipReg1 , c_Codemp2, c_Matric2, c_TipReg2 )

	Local c_Qry := "" 
	Local c_Codigo := "'"  
	Local l_Parc := .T.      
	Local cClaCar  := ' ' 
    Local c_Qtdcar := 0
    Local cUnicar  := ' '   
    local cAlias   :=' '   	                
    local seq      :=' '
	 
    c_Qry := "	Select R_E_C_N_O_ Rec  " + _cEol     
   	c_Qry += "	 from " + RetSqlName("BFO") +" BFO" + _cEol           
    c_Qry += "	where BFO_FILIAL = '" + xFilial("BFO") + "' "+ _cEol
	c_Qry += "	AND bfo_codint = '0001' "      + _cEol
	c_Qry += "	and bfo_codemp = '" + c_Codemp1 + "' " + _cEol
	c_Qry += "	and bfo_matric = '" + c_Matric1 + "' " + _cEol
	c_Qry += "	and bfo_tipreg = '" + c_TipReg1   + "' " + _cEol
	c_Qry += "	and d_e_l_e_t_ = ' ' " + _cEol                       
	
	 If Select(("TMPBFO")) <> 0              
    
       ("TMPBFO")->(DbCloseArea())  
        
    Endif                   
	
	TcQuery c_Qry ALIAS "TMPBFO" NEW   
     
    dbSelectArea("BFO")    
    
     	  While !TMPBFO->( EOF() )    
	                    
                DbGoto(TMPBFO->Rec)
  	 		         
  	 		    RecLock("BFO",.F.)

                dbdelete()
			 
	 	 	    Msunlock("BFO")	
				     		
		        TMPBFO->( dbSkip() )                              
	
	      EndDo
	      
	      	 
    c_Qry := "	Select *  " + _cEol     
   	c_Qry += "	 from " + RetSqlName("BFO") +" BFO" + _cEol           
    c_Qry += "	where BFO_FILIAL = '" + xFilial("BFO") + "' "+ _cEol
	c_Qry += "	AND bfo_codint = '0001' "      + _cEol
	c_Qry += "	and bfo_codemp = '" + c_Codemp2 + "' " + _cEol
	c_Qry += "	and bfo_matric = '" + c_Matric2 + "' " + _cEol
	c_Qry += "	and bfo_tipreg = '" + c_TipReg2   + "' " + _cEol
	c_Qry += "	and d_e_l_e_t_ = ' ' " + _cEol                       
	c_Qry += "	order by bfo_matric , bfo_tipreg , bfo_clacar " + _cEol                       

	                                     
	
	TcQuery c_Qry ALIAS "TMPSUB" NEW 
	 If Select(("TMPSUB")) <> 0              
    
       ("TMPSUB")->(DbCloseArea())  
        
    Endif                   
	
	TcQuery c_Qry ALIAS "TMPSUB" NEW   
         
    While !TMPSUB->( EOF() )    

        If seq <> TMPSUB->bfo_clacar
           seq := TMPSUB->bfo_clacar           		
	   		RecLock("BFO", .T.)
			
				BFO->BFO_CODINT := TMPSUB->BFO_CODINT
				BFO->BFO_CODEMP := TMPSUB->BFO_CODEMP
				BFO->BFO_MATRIC := c_Matric1
				BFO->BFO_TIPREG := c_TipReg1
				BFO->BFO_CLACAR := TMPSUB->BFO_CLACAR
				BFO->BFO_CARENC := TMPSUB->BFO_CARENC
				BFO->BFO_UNICAR := TMPSUB->BFO_UNICAR 
				BFO->BFO_DATCAR := STOD(TMPSUB->BFO_DATCAR) 
				BFO->BFO_YRGIMP := TMPSUB->BFO_YRGIMP 
		        
   		       
   		        BFO->(MsUnLock())
   		        
   		        if pvez                                                                                 
   		        
   		           nQtdaCar := nQtdaCar + 1
   		        
   		        EndIf 
   		        
   		            
            EndIf    
		
			
			TMPSUB->( dbSkip() )     
		
		EndDo
		
	      nQtdaAssi := nQtdaAssi + 1
	      pvez := .F.                                                                                       
	      TMPSUB->( dbCloseArea() )	 
         		
	      
Return
