#Include 'RWMAKE.CH'                               
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATU_EQUIPEºAutor  ³Raquel              º Data ³  02/16/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Atualiza as Equipes/ Vendedores nas famílias e nos        º±±
±±º          ³  usuários qdo estes são alterados no subcontrato           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ATUEQUIPE()     
If ! Pergunte("ATUEQUI", .T.)
	Return
Endif

If  ! msgyesno("Este programa ira atualizar as Equipes/Vendedores no subcontrato e nas Familias/Usuarios")
	Return()
Endif

MsAguarde({|| PlsAtuEqu()}, "", "Atualizacao Subcontratos e Familia/Usuarios", .T.)


Return()
					


Static Function PlsAtuEqu()
LOCAL cOpe
LOCAL cEmp 
LOCAL cCont   
LOCAL cEquipe     
LOCAL cVend1:=""  
LOCAL cVend2:=""
Local cSQL := ""            

Pergunte("ATUEQUI",.F.)

cEmp 	 := mv_par01 
cCont	 := mv_par02
cSubCont := mv_par03
cEquipe  := mv_par04
cVend1   := mv_par05
cVend2   := mv_par06         

If empty(trim(iif(Empty(cVend1),"vazio",Posicione("SA3",1,xFilial("SA3")+cVend1,"A3_NOME"))))  

   MsgAlert("Codigo do vendedor  "+cVend1+" nao Existe ! Use a lupa !!","Atencao!")

   return()                   
   
ElseIf empty(trim(iif(Empty(cVend2),"vazio",Posicione("SA3",1,xFilial("SA3")+cVend2,"A3_NOME"))))  
                                                                                                     
   MsgAlert("Codigo do vendedor  "+cVend2+" nao Existe ! Use a lupa !!","Atencao!")
    
   return()                   

EndIF     

dbselectarea("BQC")
BQC->(DbSetOrder(1))

if 	!(BQC->(DbSeek(xFilial("BQC")+'0001'+mv_par01))  )  
  MsgStop("Subcontrato Incorreto!")         
  Return()
Else                                                                                    
  While BQC->(BQC_FILIAL + BQC_CODIGO  ) == (xFilial("BQC")+'0001'+mv_par01)    
     If !empty(mv_par02) .and. !empty(mv_par03)                                                                                                              
        if BQC->(BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB ) != (xFilial("BQC")+'0001'+mv_par01+mv_par02+mv_par03)
           BQC->(dbSkip())            
           loop
        EndIf          
     ElseIf !empty(mv_par02)                                                                                                                            
         if BQC->(BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON  ) != (xFilial("BQC")+'0001'+mv_par01+mv_par02)           
            BQC->(dbSkip()) 
            loop
        EndIf   
     EndIf                                                                                                                                        
//   While BQC->(BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB ) == (xFilial("BQC")+PLSINTPAD()+mv_par01+mv_par02+mv_par03)   
          
        reclock("BQC",.F.)  
           BQC->BQC_EQUIPE := IIF(trim(BQC->BQC_YSTSCO)=='' ,cEquipe ,' ')    
           BQC->BQC_CODVEN := IIF(trim(BQC->BQC_YSTSCO)=='' ,cVend1  ,' ')    
           BQC->BQC_CODVE2 := IIF(trim(BQC->BQC_YSTSCO)=='' ,cVend2  ,' ') 
        BQC->(MsUnlock())	
        BQC->(dbSkip())    
  EndDo    
endIf 
dbselectarea("BA1")   

Ba1->(DbSetOrder(1))

if Ba1->(DbSeek(xFilial("BA1")+'0001'+mv_par01))  

   While BA1->(BA1_FILIAL + BA1_CODINT+BA1_CODEMP) == (xFilial("BA1")+'0001'+mv_par01)   
         If !empty(mv_par02) .and. !empty(mv_par03)       
            if ba1->BA1_CONEMP != Substr(cCont, 1, 12) .or. ba1->BA1_VERCON != Substr(cCont, 13, 3) .or. ba1->BA1_SUBCON != Substr(cSubCont, 1, 9) .or. ba1->BA1_VERSUB != Substr(cSubCont, 10, 3)  
               BA1->(dbSkip()) 
               loop  
            EndIf  
         elseif !empty(mv_par02)
             if ba1->BA1_CONEMP != Substr(cCont, 1, 12) .or. ba1->BA1_VERCON != Substr(cCont, 13, 3) 
                BA1->(dbSkip()) 
                loop
             EndIf   
         EndIf                    

        BQC->(DbSeek(xFilial("BQC")+'0001'+ba1->ba1_codemp + ba1->ba1_conemp +ba1->bA1_VERcon + ba1->ba1_subcon + ba1->bA1_VERsub))  
        
         reclock("BA1",.F.)  
            BA1->BA1_EQUIPE := IIF(trim(BQC->BQC_YSTSCO)=='' ,cEquipe ,' ')    
            BA1->BA1_CODVEN := IIF(trim(BQC->BQC_YSTSCO)=='' ,cVend1  ,' ')   
            BA1->BA1_CODVE2 := IIF(trim(BQC->BQC_YSTSCO)=='' ,cVend2  ,' ')
         BA1->(MsUnlock())		
         BA1->(dbSkip())    
   EndDo                                                                                  
EndIf  
dbselectarea("BA3")

Ba3->(DbSetOrder(1))

if Ba3->(DbSeek(xFilial("BA1")+'0001'+mv_par01))  

   While BA3->(BA3_FILIAL + BA3_CODINT+BA3_CODEMP) == (xFilial("BA3")+'0001'+mv_par01)   
         If !empty(mv_par02) .and. !empty(mv_par03)       
            If ba3->BA3_CONEMP != Substr(cCont, 1, 12) .or. ba3->BA3_VERCON != Substr(cCont, 13, 3) .or. ba3->BA3_SUBCON != Substr(cSubCont, 1, 9) .OR. ba3->BA3_VERSUB != Substr(cSubCont, 10, 3)  
               BA3->(dbSkip()) 
               loop  
            EndIf   
         elseIf !empty(mv_par02)
            If ba3->BA3_CONEMP != Substr(cCont, 1, 12) .or. ba3->BA3_VERCON != Substr(cCont, 13, 3)
               BA3->(dbSkip()) 
               loop
             EndIf   
         EndIf            
        BQC->(DbSeek(xFilial("BQC")+'0001'+ba3->ba3_codemp + ba3->ba3_conemp +ba3->bA3_VERcon + ba3->ba3_subcon + ba3->bA3_VERsub))  

         reclock("BA3",.F.)                                           
            BA3->BA3_EQUIPE := IIF(trim(BQC->BQC_YSTSCO)=='' ,cEquipe ,' ')    
            BA3->BA3_CODVEN := IIF(trim(BQC->BQC_YSTSCO)=='' ,cVend1  ,' ')   
            BA3->BA3_CODVE2 := IIF(trim(BQC->BQC_YSTSCO)=='' ,cVend2  ,' ')
         BA3->(MsUnlock())	
         BA3->(dbSkip())    
   EndDo      
EndIF  


//BQC->(DbSetOrder(1))
     
/* 
  cSQL := " UPDATE "+RetSQLName("BQC")+" SET BQC_EQUIPE = '"+cEquipe+"', "   
  cSQL += " BQC_CODVEN = '"+cVend1+"', "   
  cSQL += " BQC_CODVE2 = '"+cVend2+"' "
  cSQL += " WHERE BQC_CODIGO = '"+PLSINTPAD()+cEmp+"' "  
  cSQL += " AND BQC_NUMCON = '"+Substr(cCont, 1, 12)+"' "
  cSQL += " AND BQC_VERCON = '"+Substr(cCont, 13, 3)+"' "  
  cSQL += " AND BQC_SUBCON = '"+Substr(cSubCont, 1, 9)+"' "
  cSQL += " AND BQC_VERSUB = '"+Substr(cSubCont, 10, 3)+"' "  
  cSQL += " AND D_E_L_E_T_ = ' ' "
  TCSQLEXEC(cSQL)     

 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea())  
 Endif
    TCQuery cSQL Alias "TMP" New 
    dbSelectArea("TMP")
    tmp->(dbGoTop())   
                  
 tmp->(dbGoTop())                                                         
       While !TMP->(EOF())        
       
       BA3->(DbSetOrder(1))
       BQC->(DbSetOrder(1))

BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
BQC->(DbSeek(xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))

      	 dbselectarea("SE2")
		 dbSeek(xFilial("SE2")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
		 If Found()      
       	  reclock("BXQ",.T.)      
       	  
          BXQ->(MsUnlock())		
          tmp->(dbSkip())     






  
  cSQL := " UPDATE "+RetSQLName("BA3")+" SET BA3_EQUIPE = '"+cEquipe+"', "   
  cSQL += " BA3_CODVEN = '"+cVend1+"', "   
  cSQL += " BA3_CODVE2 = '"+cVend2+"' "
  cSQL += " WHERE BA3_CODINT = '"+PLSINTPAD()+"' "  
  cSQL += " AND BA3_CODEMP = '"+cEmp+"' "  
  cSQL += " AND BA3_CONEMP = '"+Substr(cCont, 1, 12)+"' "
  cSQL += " AND BA3_VERCON = '"+Substr(cCont, 13, 3)+"' "  
  cSQL += " AND BA3_SUBCON = '"+Substr(cSubCont, 1, 9)+"' "
  cSQL += " AND BA3_VERSUB = '"+Substr(cSubCont, 10, 3)+"' "  
  cSQL += " AND D_E_L_E_T_ = ' ' "
//  TCSQLEXEC(cSQL)    
  
  cSQL := " UPDATE "+RetSQLName("BA1")+" SET BA1_EQUIPE = '"+cEquipe+"', "   
  cSQL += " BA1_CODVEN = '"+cVend1+"', "   
  cSQL += " BA1_CODVE2 = '"+cVend2+"' "
  cSQL += " WHERE BA1_CODINT = '"+PLSINTPAD()+"' "  
  cSQL += " AND BA1_CODEMP = '"+cEmp+"' "  
  cSQL += " AND BA1_CONEMP = '"+Substr(cCont, 1, 12)+"' "
  cSQL += " AND BA1_VERCON = '"+Substr(cCont, 13, 3)+"' "  
  cSQL += " AND BA1_SUBCON = '"+Substr(cSubCont, 1, 9)+"' "
  cSQL += " AND BA1_VERSUB = '"+Substr(cSubCont, 10, 3)+"' "  
  cSQL += " AND D_E_L_E_T_ = ' ' "
// TCSQLEXEC(cSQL)            */
  
  MsgStop("Dados atualizados!")

//ENDIF

Return Nil
