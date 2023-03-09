#INCLUDE "rwmake.ch"
/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥LP5307     ∫ Autor ≥ AP6 IDE            ∫ Data ≥  24/08/05  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥ LESCAUT                                                    ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP6 IDE                                                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
// De / Para das Conta Cont·beis 19/09/07
User Function LP99X() 

	PRIVATE a:= 'B'  
	private cConta:= ' ' 

return()

User  Function LP9981V()   

	private cVlr9981 := IIF(ALLTRIM(_CCTPLANO)="0018",0,(_NCTAPROV+_NCTGLOSA))                                                                                                                                                  

return (cVlr9981)

////////////

User Function LP991D()
private cConta:= ' ' 

    //// Custo Sus 21/07/2022

	If  __C_ODRDA =='155614' //PAGAMENTO PARA O SUS - PERSUS 

	    If __O_DONT == '1'  
		   	  cconta := '4118210'
		Else	  
			  cconta := '4118110'
		EndIf 	  
       
        if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01'
               cconta += '31'
	    ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"
		       cconta += '41' 	  
		ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4"
			   cconta += '61'
        ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
		  	   cconta += '99'
		EndIf 

	ElseIf __C_CODEMP $ ('0004|0009') .AND. cEmpAnt == '01'
	
			cconta := '214119011'

		ElseIf __J_UDIC == 'S' .and. __E_XTRROL=='S'
			
			cconta := '441319041'

		ElseIf __J_UDIC != 'S' .and. __E_XTRROL=='S'  

			cconta :='44211901902'        
		
		ElseIF !EMPTY (_CCTPROJ)           
		
			cconta := "441519011"       

	ElseIf __T_PCONTA =='2' //PAGAMENTO POR CAPTATION''

		if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01'
			cconta := '411211031'
		Else
		  
		   If __O_DONT == '1'  
		   	  cconta := '4112210'
		   Else	  
			  cconta := '4112110'
		   EndIf 	  
		  
		   If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"
		     cconta += '41' 	  
		   ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4"
			 cconta += '61'
           ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
		  	 cconta += '99'
		   EndIf
		EndIf

	ElseIf __T_PCONTA =='3' //PAGAMENTO POR PACOTE'
		
		if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01' .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
			cconta := '411411037'

		Elseif AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01' .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'	
			
			cconta := '411411031'
		Else
			  
		   If __O_DONT == '1'  
		   	  cconta := '4114210'
		   Else	  
			  cconta := '4114110'
		   EndIf 	  
		
		    If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"     .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
				cconta += '47'
            
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'
			
				cconta += '41'

			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'

				cconta += '67'

            ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'

				cconta += '61'

            ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "" 
				
				cconta += '99'
			
			EndIf

		EndIf

	    ElseIF __T_PCONTA =='1' //'PAGAMENTO POR PROCEDIMENTO'

	    if AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'
		
			cconta := '411111037'

		elseif AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'	
			
			cconta := '411111031'
		
		Else
			  
		   If __O_DONT == '1'  
		   	  cconta := '4111210'
		   Else	  
			  cconta := '4111110'
		   EndIf 	  
		   
		   If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
				cconta += '47'
		    
		   ELSEIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'	
			
				cconta += '41'
			
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
				cconta += '67'
            
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'

				cconta += '61'

            ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
			
				cconta += '99'
			
			EndIf
		
		EndIf
	ElseIf __T_PCONTA =='4'//'PAGAMENTO POR REEMBOLSO'                   

		if AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'
		
			cconta := '411711037'
		
		Elseif AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'

			cconta := '411711031'
		
		Else
			  
		   If __O_DONT == '1'  
		   	  cconta := '4117210'
		   Else	  
			  cconta := '4117110'
		   EndIf 	  

			If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'

			    cconta += '47'

			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'
			
				cconta += '41'
			
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'

			    cconta += '67'

			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'
				
				cconta += '61'
            
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
			
				cconta += '99'
			
			EndIf

		EndIf
		
	EndIf 



Return (cconta)

/////////

User Function LP992C()
private cConta:= ' ' 

 //// Custo Sus 21/07/2022

	If __C_ODRDA =='155614' //PAGAMENTO PARA O SUS - PERSUS 

		If __O_DONT == '1'  
		   	  cconta := '211121024'
		Else	  
			  cconta := '211111024'
		EndIf 	  
       
	ElseIf __C_CODEMP $ ('0004|0009') .AND. cEmpAnt == '01'
		cconta := '214119011'
		ElseIf __J_UDIC == 'S'
			cconta := '211111031'
		ElseIf __E_XTRROL=='S'
			cconta := '211111034'       

	ElseIf __T_PCONTA $ '1|2|3' //PAGAMENTO POR CAPTATION''

		   If __O_DONT == '1'  
		   	  cconta := '211121031'
		   Else	  
			  cconta := '211111031'
		   EndIf 	  

	ElseIf __T_PCONTA =='4'//'PAGAMENTO POR REEMBOLSO'                   

		   If __O_DONT == '1'  
		   	  cconta := '211121034'
		   Else	  
			  cconta := '211111034'
		   EndIf 	  

    //   rede indireta rede nao identificada 
	ELSE
       
	    If  __O_DONT == '1'  
		 	cconta := '211121031'
        Else	  
			cconta := '211111031'
		EndIf 	  
    ///
		   		
	EndIf 
	
Return (cconta)

//////////

User Function LP993C()
private cConta:= ' ' 

    If __C_ODRDA =='155614' //PAGAMENTO PARA O SUS - PERSUS 

	    If __O_DONT == '1'  
		   	  cconta := '4118210'
		Else	  
			  cconta := '4118110'
		EndIf 	  
       
        if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01'
               cconta += '32'
	    ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"
		       cconta += '42' 	  
		ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4"
			   cconta += '62'
        ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
		  	   cconta += '99'
		EndIf 

	ElseIf __C_CODEMP $ ('0004|0009') .AND. cEmpAnt == '01'
	
		cconta := '214119011'

	ElseIf __J_UDIC == 'S' .and. __E_XTRROL=='S'
		
		cconta := '441319041'

	ElseIf __J_UDIC != 'S' .and. __E_XTRROL=='S'  

		cconta :='44211901902'        
	
	ElseIF !EMPTY (_CCTPROJ)           
	
		cconta := "441519011"       

///   rede indireta 
// TRATAMENTO SOLICITADO PELA ALINE / LUIZ CHAMADO 88155 - 23/06/2022
/*
	ELSEIF __C_ODRDA $ ("031046|043060|064963|023892|123587|037451|049212|135755|130559|114960|102814|090352|111295") .AND. cEmpAnt == '01'

        if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01'
			cconta := '411611032'
		Else
		  
		   If __O_DONT == '1'  
		   	  cconta := '4116210'
		   Else	  
			  cconta := '4116110'
		   EndIf 	  
		  
		   If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"
		     cconta += '42' 	  
		   ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4"
			 cconta += '62'
           ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
		  	 cconta += '99'
		   EndIf
		
		EndIf
*/
/////
	ElseIf __T_PCONTA =='2' //PAGAMENTO POR CAPTATION''

		if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01'
			cconta := '411211032'
		Else
		  
		   If __O_DONT == '1'  
		   	  cconta := '4112210'
		   Else	  
			  cconta := '4112110'
		   EndIf 	  
		  
		   If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"
		     cconta += '42' 	  
		   ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4"
			 cconta += '62'
           ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
		  	 cconta += '99'
		   EndIf
		EndIf

	ElseIf __T_PCONTA =='3' //PAGAMENTO POR PACOTE'
		
		if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01' .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
			cconta := '411411032'

		Elseif AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01' .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'	
			
			cconta := '411411032'
		Else
			  
		   If __O_DONT == '1'  
		   	  cconta := '4114210'
		   Else	  
			  cconta := '4114110'
		   EndIf 	  
		
		    If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"     .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
				cconta += '42'
            
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'
			
				cconta += '42'

			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'

				cconta += '62'

            ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'

				cconta += '62'

            ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "" 
				
				cconta += '99'
			
			EndIf

		EndIf

	    ElseIF __T_PCONTA =='1' //'PAGAMENTO POR PROCEDIMENTO'

	    if AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'
		
			cconta := '411111032'

		elseif AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'	
			
			cconta := '411111032'
		
		Else
			  
		   If __O_DONT == '1'  
		   	  cconta := '4111210'
		   Else	  
			  cconta := '4111110'
		   EndIf 	  
		   
		   If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
				cconta += '42'
		    
		   ELSEIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'	
			
				cconta += '42'
			
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
				cconta += '62'
            
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'

				cconta += '62'

            ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
			
				cconta += '99'
			
			EndIf
		
		EndIf
	ElseIf __T_PCONTA =='4'//'PAGAMENTO POR REEMBOLSO'                   

		if AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'
		
			cconta := '411711032'
		
		Elseif AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'

			cconta := '411711032'
		
		Else
			  
		   If __O_DONT == '1'  
		   	  cconta := '4117210'
		   Else	  
			  cconta := '4117110'
		   EndIf 	  

			If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'

			    cconta += '42'

			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'
			
				cconta += '42'
			
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'

			    cconta += '62'

			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'
				
				cconta += '62'
            
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
			
				cconta += '99'
			
			EndIf

		EndIf
		
	EndIf


Return (cconta)

User Function LP994C()
private cConta:= ' '  

    If __C_ODRDA =='155614' //PAGAMENTO PARA O SUS - PERSUS 

	    If __O_DONT == '1'  
		   	  cconta := '4118210'±
		Else	  
			  cconta := '4118110'
		EndIf 	  
       
        if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01'
               cconta += '33'
	    ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"
		       cconta += '43' 	  
		ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4"
			   cconta += '63'
        ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
		  	   cconta += '99'
		EndIf 

	ElseIf __C_CODEMP $ ('0004|0009') .AND. cEmpAnt == '01'
	
		cconta := '214119011'

	ElseIf __J_UDIC == 'S' .and. __E_XTRROL=='S'
		
		cconta := '441319041'

	ElseIf __J_UDIC != 'S' .and. __E_XTRROL=='S'  

		cconta :='44211901902'        
	
	ElseIF !EMPTY (_CCTPROJ)           
	
		cconta := "441519011"       

///   rede indireta 
// TRATAMENTO SOLICITADO PELA ALINE / LUIZ CHAMADO 88155 - 23/06/2022

/*
	ELSEIF __C_ODRDA $ ("031046|043060|064963|023892|123587|037451|049212|135755|130559|114960|102814|090352|111295") .AND. cEmpAnt == '01'

        if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01'
			cconta := '411611033'
		Else
		  
		   If __O_DONT == '1'  
		   	  cconta := '4116210'
		   Else	  
			  cconta := '4116110'
		   EndIf 	  
		  
		   If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"
		     cconta += '43' 	  
		   ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4"
			 cconta += '63'
           ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
		  	 cconta += '99'
		   EndIf
		
		EndIf
*/
/////

	ElseIf __T_PCONTA =='2' //PAGAMENTO POR CAPTATION''

		if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01'
			cconta := '411211033'
		Else
		  
		   If __O_DONT == '1'  
		   	  cconta := '4112210'
		   Else	  
			  cconta := '4112110'
		   EndIf 	  
		  
		   If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"
		     cconta += '43' 	  
		   ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4"
			 cconta += '63'
           ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
		  	 cconta += '99'
		   EndIf
		EndIf

	ElseIf __T_PCONTA =='3' //PAGAMENTO POR PACOTE'
		
		if AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01' .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
			cconta := '411411033'

		Elseif AllTrim(_CCTPLANO) == '0006'  .AND. cEmpAnt == '01' .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'	
			
			cconta := '411411033'
		Else
			  
		   If __O_DONT == '1'  
		   	  cconta := '4114210'
		   Else	  
			  cconta := '4114110'
		   EndIf 	  
		
		    If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3"     .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
				cconta += '43'
            
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'
			
				cconta += '43'

			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'

				cconta += '63'

            ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'

				cconta += '63'

            ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "" 
				
				cconta += '99'
			
			EndIf

		EndIf

	    ElseIF __T_PCONTA =='1' //'PAGAMENTO POR PROCEDIMENTO'

	    if AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'
		
			cconta := '411111033'

		elseif AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'	
			
			cconta := '411111033'
		
		Else
			  
		   If __O_DONT == '1'  
		   	  cconta := '4111210'
		   Else	  
			  cconta := '4111110'
		   EndIf 	  
		   
		   If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
				cconta += '43'
		    
		   ELSEIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'	
			
				cconta += '43'
			
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC == 'S' .and. __E_XTRROL !='S'
			
				cconta += '63'
            
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and. __J_UDIC != 'S' .and. __E_XTRROL !='S'

				cconta += '63'

            ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
			
				cconta += '99'
			
			EndIf
		
		EndIf
	ElseIf __T_PCONTA =='4'//'PAGAMENTO POR REEMBOLSO'                   

		if AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'
		
			cconta := '411711033'
		
		Elseif AllTrim(_CCTPLANO) == '0006' .AND. cEmpAnt == '01' .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'

			cconta := '411711033'
		
		Else
			  
		   If __O_DONT == '1'  
		   	  cconta := '4117210'
		   Else	  
			  cconta := '4117110'
		   EndIf 	  

			If ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'

			    cconta += '43'

			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "3" .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'
			
				cconta += '43'
			
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and.  __J_UDIC == 'S' .and. __E_XTRROL !='S'

			    cconta += '63'

			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == "4" .and.  __J_UDIC != 'S' .and. __E_XTRROL !='S'
				
				cconta += '63'
            
			ElseIf ALLTRIM(Posicione("BI3",5,xFilial("BI3")+"0001"+_CCTPLANO,"BI3_TIPCON")) == ""
			
				cconta += '99'
			
			EndIf

		EndIf
		
	EndIf

Return (cconta)

////////


