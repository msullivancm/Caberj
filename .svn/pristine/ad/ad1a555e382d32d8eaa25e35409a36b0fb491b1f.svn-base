#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA569   ºAutor  ³Motta               º Data ³  fev/15     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela de cadastro da tabela de vInculo RDA x Usuario do      º±±
±±º          ³Projeto Maturidade                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA569()       

Private cCodUNATI   := "86000748"    

//Motta 12/1/17 (hd 32135)  
//Desabilitando as críticas temporariamente
// sera revisto com a Sra Andrea 
//axcadastro("ZRF","maturidade-Vinculo RDA X Beneficiario","U_DelCB569()","U_OkCB569()")    
axcadastro("ZRF","maturidade-Vinculo RDA X Beneficiario",".T.",".T.")  
//Fim Motta 12/1/17  
  
Return()

User Function ValRDAMat(cRDA)  

Local lRet := .T.        

dbselectarea("BAU")
dbsetorder(1)
If dbseek(xFilial("BAU")+cRDA)
	If BAU->BAU_TIPPRE $ "MAT/VER" /*ch 80177*/
	  lRet := .T. 
	Else    
	  	Alert("RDA não e do Projeto Maturidade/Verticalizado.")
      	lRet := .F. 
	Endif  
Else	
	Alert("RDA nao localizada.")
	lRet := .F. 
Endif   

Return lRet                    

****************************************************************************************************************

User Function DelCB569   

Local cQry    := " "   
Local lRet    := .T.   

//verifica se existem lancamentos bd6 para esta matricula , caso existam nao permite exclusao
cQry := " SELECT  COUNT(*) QTD " + CRLF
cQry += " FROM "+RetSQLName("BD6")+" BD6 " + CRLF
cQry += " WHERE  BD6.D_E_L_E_T_ = ' '  " + CRLF    
cQry += " AND    BD6_FILIAL = '  '  " + CRLF  
cQry += " AND    BD6_NUMLOT >= '201601'  " + CRLF /*PONTE DE CORTE*/  
cQry += " AND    BD6_CODPRO = '" + cCodUNATI + "' " + CRLF 
cQry += " AND    BD6_OPEUSR = '" + SUBSTR(ZRF->ZRF_MATRIC,1,4) + "' " + CRLF    
cQry += " AND    BD6_CODEMP = '" + SUBSTR(ZRF->ZRF_MATRIC,5,4) + "' " + CRLF
cQry += " AND    BD6_MATRIC = '" + SUBSTR(ZRF->ZRF_MATRIC,9,6) + "' " + CRLF  
cQry += " AND    BD6_TIPREG = '" + SUBSTR(ZRF->ZRF_MATRIC,15,2) + "' " + CRLF

PLSQuery(cQry,"T569")    
dbselectarea("T569")
If !Eof()
	lRet := (T569->QTD = 0)
EndIf
T569->( dbCloseArea() )   

If !lRet 
  MsgAlert("Existem pagamentos de maturidade para esta matricula , exclusao nao permitida !")
Endif

Return lRet

****************************************************************************************************************

User Function OkCB569     

Local cMaxRef := " "   
Local lRet    := .T.

cMaxRef := MaxRefRDA()  

// Inclusao 
If Inclui  
  //, verificar se a ref ja foi paga
  If Substr(DToS(M->ZRF_DATINI),1,6) <= cMaxRef
    MsgAlert("Existem pagamentos de maturidade para esta referencia , inclusao nao permitida nesta data !") 
    lRet    := .F.
  End if        
  // testar tambem se o inicio é sempre 1 dia do mes e 
  If Substr(DToS(M->ZRF_DATINI),7,2) <> "01"     
    lRet := ApMsgYesNo("A inclusao nao e o primeiro dia do mes , confirma a inclusao nesta data ?")
  End if                                                            
Else
  If Altera       
    IF !Empty(ZRF->ZRF_DATFIN) .AND. Empty(M->ZRF_DATFIN)   
      If Substr(DToS(ZRF->ZRF_DATFIN),1,6) <= cMaxRef
      	MsgAlert("Nao e permitido desbloquear , abra outra vigencia !") 
      	lRet    := .F.    
      End if	
    End if
    // Se bloqueou            
    IF Empty(ZRF->ZRF_DATFIN) .AND. !Empty(M->ZRF_DATFIN) 
        If (dDataBase - M->ZRF_DATFIN)  > 60    
          MsgAlert("Exclusao para menos de 60 dias da data corrente !") 
		  lRet    := .F.
        End if  
        If (M->ZRF_DATFIN - dDataBase)  > 60    
          MsgAlert("Exclusao para mais de 60 dias da data corrente !") 
		  lRet    := .F.
        End if          
        If Substr(DToS(M->ZRF_DATFIN),7,2) <> Substr(DToS(LastDay(M->ZRF_DATFIN)),7,2)    
      		lRet := ApMsgYesNo("O bloquieo nao e o ultimo dia do mes , confirma o bloqueio nesta data ?")
  		End if
  		If Substr(DToS(M->ZRF_DATFIN),1,6) < cMaxRef
		    MsgAlert("Existem pagamentos de maturidade para esta referencia , bloqueio nao permitido nesta data !") 
		    lRet    := .F.
		End if     
    End if
    //ALTERAR A RDA
    If ZRF->ZRF_CODRDA <> M->ZRF_CODRDA
      MsgAlert("Nao e permitido alterar a RDA , exclua ou bloqueie o registro !") 
      lRet    := .F.
    End if  
    //ALTERAR O TIPO
    If ZRF->ZRF_TPRDA <> M->ZRF_TPRDA
      MsgAlert("Nao e permitido alterar a Tipo RDA , exclua ou bloqueie o registro !") 
      lRet    := .F.
    End if    
  End if  
End if

Return lRet          

****************************************************************************************************************    

Static Function MaxRefRDA

Local cRefRet := " "   
Local cQry    := " "     

cQry := " SELECT  MAX(SUBSTR(BD6_NUMLOT,1,6)) MAXREF " + CRLF
cQry += " FROM "+RetSQLName("BD6")+" BD6 " + CRLF
cQry += " WHERE  BD6.D_E_L_E_T_ = ' '  "    
cQry += " AND    BD6_FILIAL = '  '  "   
cQry += " AND    BD6_NUMLOT >= '201601'  " /*PONTE DE CORTE*/   
cQry += " AND    BD6_CODPRO = '" + cCodUNATI + "' "   

PLSQuery(cQry,"T569")    
dbselectarea("T569")
If !Eof()
	cRefRet :=  T569->MAXREF
EndIf
T569->( dbCloseArea() )

Return cRefRet

**************************************************************************************************************** 
