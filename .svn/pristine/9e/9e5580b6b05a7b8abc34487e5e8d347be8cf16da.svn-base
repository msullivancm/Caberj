#INCLUDE 'PROTHEUS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |PLSMCORF3 ºAutor  ³Leonardo Portella   º Data ³  03/02/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Filtro para legenda do filtro de busca do usuario, mantendo º±±
±±º          ³consistencia com o PE PL260COR da legenda do Familia/Usuarioº±±
±±º          ³(Funcao Padrao PLSPESUSER)                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSMCORF3

Local cCor		:= "ENABLE" 
Local aAreaBA1 	:= BA1->(GetArea())
Local cMatrVal	:= paramixb[1]//Matricula sendo validada 
Local i 		:= 0
     
If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'    
If FunName() == "PLSA092" 

	u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSMCORF3 - 1")

EndIf
EndIf


cMatrVal := StrTran(cMatrVal,'.','')
cMatrVal := StrTran(cMatrVal,'-','') 

If ExistBlock('PL260COR')//Manter consistencia com o PE PL260COR da legenda do Contrato/Familia -> Familia/Usuario
    
	BA1->(DbSetOrder(2))//BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO                                                                                     
	
	If BA1->(MsSeek(xFilial('BA1') + cMatrVal))
		aCores := U_PL260COR()[1] 
		
		For i := 1 to len(aCores) 
		
			cMacro 	:= aCores[i][1]
			
			If &cMacro
				cCor := aCores[i][2]
				exit
			EndIf
		Next
		
	EndIf
	
EndIf  

BA1->(RestArea(aAreaBA1))
If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'                                        
If FunName() == "PLSA092" 

	u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "PLSMCORF3 - 2")

EndIf
EndIf

Return cCor