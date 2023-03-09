#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA592   ºAutor  ³Motta               º Data ³  jun/2016   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela de cadastro de Indices por RDA Policlinicas            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA592()
axcadastro("ZRG","Indices por RDA Policl.",".T.",".T.")
Return()

User Function Vlc592RDA(cRDA) 

Local lRet := .T.   
Local cSQL := " "

cSQL := "SELECT SIGN(COUNT(R_E_C_N_O_)) QTD " 	+ CRLF
cSQL += "FROM  "+RETSQLNAME("BAU")+ " BAU"	+ CRLF
cSQL += "WHERE  D_E_L_E_T_ = ' ' " 	+ CRLF 
cSQL += "AND    BAU_FILIAL = '" + xFilial('BAU')+ "'" 	+ CRLF 
cSQL += "AND    BAU_CODIGO = '" + cRDA + "' " 	+ CRLF 
cSQL += "AND  ( BAU_TIPPRE = 'POL'  " 	+ CRLF 
cSQL += "       OR " 	+ CRLF 
cSQL += "       EXISTS (SELECT NULL" + CRLF
cSQL += "               FROM   "+RETSQLNAME("BAX")+ " BAX" 	+ CRLF 
cSQL += "               WHERE  BAX.D_E_L_E_T_ = ' '" 	+ CRLF 
cSQL += "               AND    BAX_FILIAL = '" + xFilial('BAX')+ "'" 	+ CRLF 
cSQL += "               AND    BAX_CODIGO = BAU_CODIGO "  	+ CRLF
cSQL += "               AND    BAX_CODESP = '097' " 	+ CRLF //POLICLINICA
cSQL += "               AND    BAX_DATBLO = '  ') ) " + CRLF  
                     
                     
cSQL := ChangeQuery(cSQL)
PLSQuery(cSQL,"BD592VL")  
DbSelectArea("BD592VL")
BD592VL->(DbGotop())
While ! BD592VL->( Eof() )  
  nQTD := BD592VL->QTD
  BD592VL->(DbSkip())
Enddo
BD592VL->(DbCloseArea())   
If nQTD == 0
  Alert("A RDA deve ser da Classe de Rede Polcilinica ou ter esta Especialidade !!") 
  lRet := .F. 
Else
  lRet := .T.  
Endif 

Return lRet