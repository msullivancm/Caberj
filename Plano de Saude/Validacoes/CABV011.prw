#include 'PROTHEUS.CH'
#include 'TOPCONN.CH'  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV011   ºAutor  ³Leonardo Portella   º Data ³  27/08/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validacao dos campos de (des)bloqueio da familia e usuario  º±±
±±º          ³para nao permitir incluir com data anterior a data de inclu-º±±
±±º          ³sao. Chamado ID 3267                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV011
          
Local lOk 		:= .T. 
Local cVar		:= ReadVar() 
Local aAreaBA1	:= BA1->(GetArea()) 
Local dMinInc	:= CtoD('//')
Local cNomUsr	:= ""
Local cMatrUsr	:= ""

Do Case

	Case cVar == 'M->BCA_DATA'
	
		If M->BCA_DATA < BA1->BA1_DATINC
			cMsg := 'Data de ' + X3Combo('BCA_TIPO',M->BCA_TIPO) + ' [ ' + DtoC(M->BCA_DATA) + ' ] anterior a data de inclusao [ ' + DtoC(BA1->BA1_DATINC) + ' ]' + CRLF
			cMsg += ' - Beneficiario [ ' +  AllTrim(Capital(BA1->BA1_NOMUSR)) + ' ]' + CRLF
			cMsg += ' - Matricula [ ' + BA1->(BA1_CODINT+'.'+BA1_CODEMP+'.'+BA1_MATRIC+'.'+BA1_TIPREG+'-'+BA1_DIGITO) + ' ]' + CRLF
			
			MsgStop(cMsg,SM0->M0_NOMECOM)
		EndIf
		
	Case cVar == 'M->BC3_DATA'
	    
	    BA1->(DbSetOrder(2))
	    BA1->(MsSeek(xFilial('BA1') + BA3->(BA3_CODINT + BA3_CODEMP + BA3_MATRIC)))
	    
	    While !BA1->(EOF()) .and. ( BA3->(BA3_CODINT + BA3_CODEMP + BA3_MATRIC) == BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC) )
	                      
	    	If empty(dMinInc) .or. ( dMinInc > BA1->BA1_DATINC) 
	    		dMinInc 	:= BA1->BA1_DATINC	 
	    		cNomUsr		:= AllTrim(Capital(BA1->BA1_NOMUSR))
				cMatrUsr	:= BA1->(BA1_CODINT+'.'+BA1_CODEMP+'.'+BA1_MATRIC+'.'+BA1_TIPREG+'-'+BA1_DIGITO)
	    	EndIf
	    
	    	BA1->(DbSkip())
	    EndDo
		
		If M->BC3_DATA < dMinInc
			cMsg := 'Data de ' + X3Combo('BC3_TIPO',M->BC3_TIPO) + ' [ ' + DtoC(M->BC3_DATA) + ' ] anterior a data de inclusao [ ' + DtoC(dMinInc) + ' ]' + CRLF
			cMsg += ' - Beneficiario [ ' +  cNomUsr + ' ]' + CRLF
			cMsg += ' - Matricula [ ' + cMatrUsr + ' ]' + CRLF
			
			MsgStop(cMsg,SM0->M0_NOMECOM)
			lOk := .F.
		EndIf
		
EndCase   

RestArea(aAreaBA1)

Return lOk