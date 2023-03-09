#Include 'RWMAKE.CH'                               
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'


//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³CABA151ºAutor  ³Raquel                 º Data ³  02/16/07   º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDesc.     ³  Desviculador regras de comissao x vendedor x programaçãp  º±±
//±±º          ³  usuários qdo estes são alterados no subcontrato           º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ AP                                                         º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß


User Function CABA151()     
private  nRet := 0

MsAguarde({|| PlsAtuEqu()}, "Atenção", "Desvinculando .........", .T.)

Return()

Static Function PlsAtuEqu()

LOCAL cEmp 
LOCAL cVend1 := ""             

Pergunte("CABA151",.T.)

cEmp 	   := mv_par01 
cVend1     := mv_par02
cMatric    := mv_par03
nDesv       := Mv_Par04

If  nDesv  == 1 .or. nDesv  == 3

    If  Empty(cVend1)   
    
        MsgAlert("Codigo do vendedor  esta em Branco !!","Atencao!")

        return()            

    EndIf

    If  Empty(cEmp)   
    
        MsgAlert("Codigo da Empresa esta em Branco !!","Atencao!")

    return()  

    EndIf

    If  Empty(TRIM(Posicione("SA3",1,xFilial("SA3")+cVend1,"A3_NOME")))  
                                                                                                     
        MsgAlert("Codigo do vendedor  "+cVend1+" nao Existe ! Use a lupa !!","Atencao!")
    
        return()                   

    EndIF     

    If  !msgyesno("Este programa ira DESVINCULAR o Calculo da progamação  da empresa "+cEmp+" do vendedor "+cVend1+" da matricula "+cMatric+", possibilitando gerar nova programação para um novo vendedor ")
	
       Return()
    
    Endif
 
    cSQL := " UPDATE "+RetSQLName("BXO")+" SET bxo_codemp = '9'||substr(bxo_codemp,2,3)   "   
    cSQL += " WHERE BXO_CODEMP  = '"+cEmp +"' " 
    cSQL += "   AND   BXO_CODVEN = '"+cVend1+"' " 
  
    If !empty(cMatric)
   
       cSQL += "   AND   BXO_MATRIC = '"+cMatric+"' " 
  
    EndIf 


    cSQL += " AND   D_E_L_E_T_ = ' ' "
 
    nRet :=TCSQLEXEC(cSQL)     

	If  nRet >= 0 .AND. SubStr(Alltrim(Upper(TCGetDb())),1,6) == "ORACLE" 

		nRet := TCSQLEXEC("COMMIT") 

    Endif

    MsgAlert(" Empresa Desvinculada do Vendedor !! ","Atencao!")


EndIf 

////////

If  (nDesv  == 2 .or. nDesv  == 3) .and. empty(cMatric) 

    If  Empty(cVend1)   
    
        MsgAlert("Codigo do vendedor  esta em Branco !!","Atencao!")

        return()                   

    EndIf 

    If  Empty(cEmp)   
    
        MsgAlert("Codigo da Empresa esta em Branco !!","Atencao!")

        return()                   
    
    EndIf 

    If  Empty(TRIM(Posicione("SA3",1,xFilial("SA3")+cVend1,"A3_NOME")))  
                                                                                                        
        MsgAlert("Codigo do vendedor  "+cVend1+" nao Existe ! Use a lupa !!","Atencao!")
        
        return()                   

    EndIF     

    If  !msgyesno("Este programa ira DESVINCULAR a Regra do vendedor da empresa "+cEmp+" do vendedor "+cVend1+" ,possibilitando gerar nova Regra de vendedor")
    
        Return()
    
    Endif
    
    cSQL := " UPDATE "+RetSQLName("BXJ")+" SET bxJ_codemp = '9'||substr(bxJ_codemp,2,3)   "   
    //cSQL := " UPDATE "+RetSQLName("BXJ")+" SET bxJ_codequ = '9'||substr(bxJ_codemp,2,2)   "   
    cSQL += " WHERE BXJ_CODEMP  = '"+cEmp +"' " 
    cSQL += "   AND BXJ_CODVEN = '"+cVend1+"' " 
    
    cSQL += " AND   D_E_L_E_T_ = ' ' "
    
    nRet :=TCSQLEXEC(cSQL)     

    If  nRet >= 0 .AND. SubStr(Alltrim(Upper(TCGetDb())),1,6) == "ORACLE" 
    
        nRet := TCSQLEXEC("COMMIT") 
    
    Endif

    ////// TRATAMENTO PARA EQUIPE DE VENDA - ALTAMIRO 06/08/2022

    cSQL := " UPDATE "+RetSQLName("BXJ")+" SET bxJ_codequ = '9'||substr(bxJ_codemp,2,2)   "   
    cSQL += "  WHERE BXJ_CODEMP  = '"+cEmp +"' " 
    cSQL += "    AND BXJ_CODVEN = '"+cVend1+"' "
    cSQL += "    AND BXJ_CODEQU <>  '  ' " 
    cSQL += "    AND D_E_L_E_T_ = ' ' "
    
    nRet :=TCSQLEXEC(cSQL)     

    If  nRet >= 0 .AND. SubStr(Alltrim(Upper(TCGetDb())),1,6) == "ORACLE" 
    
        nRet := TCSQLEXEC("COMMIT") 
    
    Endif

    ////
    
    MsgAlert(" Regra de Vendedor / equipe de vendas  desvinculada , é possivel gerar nova regras para este vendedor !! ","Atencao!")    

EndIf 

Return Nil
