#INCLUDE "PROTHEUS.CH"
#include "ap5mail.ch"        
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณCABV001บ  Autora  ณMarcela Coimbra     บ Data ณ  20/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo dos campos B44_REGSOL e B44_REGEXE               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ RDM 004                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function CABV001( c_Alias )
Local l_Ret := .F.

dbSelectArea("BB0")
dbSetOrder(7)
If !dbSeek( xFilial("BB0") + &("M->" + c_Alias) )     
    
    Alert("Profissional Inexistente.") 

Else
    
	While !BB0->(EOF()) .and. (AllTrim(BB0->BB0_NUMCR) == &("M->" + c_Alias)) 

		If Empty( BB0->BB0_DATBLO )
	
	    	l_Ret := .T.
	    	
	    	Exit                  
	    
	    EndIf    
	    
	BB0->( dbSkip() )
	        
    EndDo

	If !l_Ret
	
		Alert("Profissional Bloqueado.")   
	
	EndIf
	    
EndIf
                 
Return l_Ret  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVAGMTFU   บMotta  ณCaberj              บ Data ณ  30/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Validacao do campo BA3_AGMTFU                              บฑฑ
ฑฑบ          ณ Plano de Saude X Gestao de Pessoal                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function VAGMTFU
Local l_Ret := .F.

l_Ret = ((Empty(M->BA3_AGMTFU) .AND. M->BA3_CODEMP != GetNewPar("MV_YEMPFU","0003")) .OR. (!Empty(M->BA3_AGMTFU) .AND. M->BA3_CODEMP == GetNewPar("MV_YEMPFU","0003")))
 
                 
Return l_Ret                   



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ          บMotta  ณCaberj           บ Data ณ  16/08/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/  


User Function VALESPUSO(cCodEsp)

Local l_Ret := .F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Posiciono na especialidade...                                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !(Empty(cCodEsp))
	BAQ->(DbSetOrder(01))
	If BAQ->(DbSeek(xFilial("BAQ")+cCodEsp)) //codint+codesp 
  		If BAQ->BAQ_YUSO == "1" //Em Uso
    		l_Ret := .T.
  		Endif   
	Endif          
Else
	l_Ret := .T.	
Endif	    
                       
Return l_Ret    

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fun็ใo chamada no questionario BXA para avisar do uso de ques-     ณ
//| quinario para matrํcula cancela.
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 

User Function VALBENQUES(cUsuari)

Local l_Ret := .T.

BA1->(DbSetOrder(2))
BA1->(dbSeek(xFilial("BA1")+cUsuari))
While BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO) == cUsuari .and. !BA1->(Eof())
  If !Empty(BA1->BA1_DATBLO)
    If !MsgYesNo("Matricula Bloqueada, prossegue ?")
      l_Ret := .F.
    Endif	 
  Endif
  BA1->(DbSkip())
EndDo
                       
Return l_Ret 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVLNMUSU   บAutor  ณaltamiro/Motta      บ Data ณ  set/2011   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVALIDA NOME DE USUARIO                                      บฑฑ
ฑฑบ          |                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณdmed                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User FUNCTION VLNMUSU(cReeNom)
PRIVATE lverde := .T.
PRIVATE nnumro := 0
PRIVATE x  := 1          
PRIVATE cNmAnt := ""

cNmAnt := cReeNom
x:= 1
ret_nome:=''
while x <= len(cReeNom)
        if (substr(cReeNom ,x , 1)) $ ".|-|_|/|'|=|:"
            ret_nome+=' '
        elseif (substr(cReeNom ,x , 1)) $ "0"
            ret_nome+='O'
        else
            ret_nome+= substr(cReeNom ,x , 1)
        endIf

     x++
enddo  
lverde := (Trim(cNmAnt) == Trim(ret_nome))     
If !lverde
  MsgAlert("Nome com caracteres invalidos !")
End if      

If lverde
  If Len(Trim(cNmAnt)) < 3 
    lverde := .F.
    MsgAlert("Nome com menos de 3 caracteres !")
  End if
End if

Return(lverde)               

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |CABV009   บAutor  ณMotta               บ Data ณ  abril/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Valida existencia de CGC na tabela de Profissiona de      บฑฑ
ฑฑบ          ณ  Saude                                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
       
User Function CABVA09(cCPF)

Private lRet := .F.      

lRet := cgc(cCPF) 
If !lRet 
  MsgAlert("CPF/CGC invalido !!")
Endif    

If lRet
	BB0->(DbSetOrder(3))
	if !BB0->(dbSeek(xFilial("BB0")+cCPF))
//	lRet := (trim(BB0->BB0_CGC) == trim(cCPF) .and. !BB0->(Eof())
//	If !lRet 
      lRet := .F.
	  MsgAlert("Nao foi localizado Profissional de Saude para este CPF/CGC")
	EndIf
Endif
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |CABV012   บAutor  ณFabio Bianchini     บ Data ณ  marco/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Valida existencia do assitido no cadastro dos reembolsos  บฑฑ
ฑฑบ          ณ  de prevencao. Caso exista, emitir aviso.                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
       
User Function CABV012(cMATRIC)

PBI->(dbSetOrder(2))                 
If PBI->(DbSeek(xFilial("PBI")+cMATRIC))
   MsgAlert("Associado Possui Regras de Projeto de Preven็ใo. Favor Visualizar as Regras!!!")
Endif

return .T.   
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |CABV013   บAutor  ณPaulo Motta         บ Data ณ  junho/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Valida campos questionแrio conforme regra de cada perguntaบฑฑ
ฑฑบ          ณ   (ex. peso / altura imc etc)                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/   

User Function CABV013(cPROQUE,cCODQUE,cCODPER,cDESCOM)

Private lRet := .T.  
                                                                                   
If cPROQUE = "2" .and. cCODQUE = "0002" //aag     
  If cCODPER = "0003"      
    If Type(Trim(Replace(cDESCOM,',','x'))) == "N" //replace pois a conversใo aceita virgula   
      lRet := (Val(Trim(cDESCOM)) == 0 .OR. (Val(Trim(cDESCOM)) > 2 .AND. Val(Trim(cDESCOM))<250))
      If !lRet
        Alert("Valor fora de uma faixa permitida !!")  
      End if
    Else
      lRet := .F.
      Alert("Campo num้rico, informe PONTO para decimais !!")       
    End if
  End if     
  If cCODPER = "0004"      
    If Type(Trim(Replace(cDESCOM,',','x'))) == "N" //replace pois a conversใo aceita virgula   
      lRet := ((Val(Trim(cDESCOM)) == 0) .OR. (Val(Trim(cDESCOM)) > .30 .AND. Val(Trim(cDESCOM)) <= 2.5))
      If !lRet
        Alert("Valor fora de uma faixa permitida !!")  
      End if
    Else
      lRet := .F.
      Alert("Campo num้rico, informe PONTO para decimais !!")       
    End if
  End if
  If cCODPER = "0005"      
    If Type(Trim(Replace(cDESCOM,',','x'))) == "N" //replace pois a conversใo aceita virgula   
      lRet := ((Val(Trim(cDESCOM)) == 0) .OR. (Val(Trim(cDESCOM)) > 10 .AND. Val(Trim(cDESCOM)) <= 100))
      If !lRet
        Alert("Valor fora de uma faixa permitida !!")  
      End if
    Else
      lRet := .F.
      Alert("Campo num้rico, informe PONTO para decimais !!")       
    End if
  End if
End if

return lRet   



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVALIDACOESบAutor  ณMarcela Coimbra     บ Data ณ  07/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo de operadora de origem                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/           
// BA1_OPEORI
User Function CABV020(c_Tipo, c_CodInt, c_CodEmp, c_Conemp, c_SubCon, c_Cont)
	
	Local c_Campo := c_Cont
	Local l_Ret   := .T.   
	Local c_RetOD := '0001' 
	Local c_RetOR := '0001'   
	Local a_Area := GetArea("BT5")
	     
	
	If cEmpAnt  == '01'
	
		If c_CodEmp == '0004' 
		
			dbSelectArea("BT5")
			dbSetOrder(1)
			If dbSeek(xFilial("BT5") + c_CodInt + c_CodEmp + c_Conemp )//BT5_FILIAL+BT5_CODINT+BT5_CODIGO+BT5_NUMCON+BT5_VERSAO
			                   
			     c_Campo := BT5->BT5_OPEINT
			     
			     If Empty( c_Campo )
			          
			     	Alert("Operadora nใo informada no cadastro do contrato (aba intercโmbio).")
			     
			     EndIf 		 
			     
			EndIf   
			
		 	c_RetOD := '0001' 
			c_RetOR := c_Campo 
				
		
		ElseIf c_CodEmp == '0009'
             //Corre็ใo de codigo de operadora da integral para matriculas de repasse - Chamado - ID: 37947 - 26/04/2017 Sergio Cunha
			 c_Campo := '1031'     
	     	 c_RetOR := '1031' 		
			 //c_Campo := '131'     
			 //c_RetOR := '131'    
			 c_RetOD := ' '

			 
		Else
		
			c_Campo:= '0001'   
			c_RetOD:= '0001'
			c_RetOR:= '0001'
		     
		EndIf     
		    
		    
		// Se for valida็ใo k
		If c_Tipo == 'V'       
		
			If alltrim(c_Campo ) <> alltrim( c_Cont )
			     
				Alert("Operadora invแlida!")     
				l_Ret   := .F.
				
			Else   
			
				l_Ret   := .T.
		
			EndIf                           
		
		// Valida็ใo Operadora de destino
		ElseIf c_Tipo == 'VOD'
		      
		   If  c_Cont <> c_RetOD  .and. !Empty( c_RetOD )  .and. c_RetOD <> '0001'
		        
				Alert("Operadora invแlida!")     
				l_Ret   := .F.
		   
		   EndIf
        
        // Valida็ใo operadora de repasse
		ElseIf c_Tipo == 'VOR'
		      
		   If  c_Cont <> c_RetOR  .and. c_RetOR <> '0001'  
		        
				Alert("Operadora invแlida!")     
				l_Ret   := .F.
		   
		   EndIf
			               
		// Gatilho operadora de destino
		ElseIf c_Tipo == 'GO'   
		
			l_Ret := c_RetOR
			               
		// Gatilho operadora de destino
		ElseIf c_Tipo == 'GD'
		
			l_Ret := c_RetOD
		
		// Gatilho operadora de repasse
		ElseIf c_Tipo == 'GR' 
		
			l_Ret := c_RetOR	
		
		EndIf
	
	EndIf
	
	RestArea( a_Area )

Return l_Ret
               
**'Marcela Coimbra'**
**'Fun็ใo recursiva para melhorar a inclusใo/manuten็ใo da rotina da prefeitura'**
User Function CABV024( c_CodPla )
      
                  
m->ba3_codpla := c_CodPla

Return c_CodPla