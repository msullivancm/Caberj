//臼浜様様様様用様様様様様僕様様様冤様様様様様様様様様曜様様様冤様様様様様様傘�
//臼�Programa  �MT100GE2  �Autor  �  Erika Schmitz     � Data �  09/05/05   艮�
//臼麺様様様様謡様様様様様瞥様様様詫様様様様様様様様様擁様様様詫様様様様様様恒�
//臼�Desc.     � Grava o campo D1_CC no campo E2_CCD                        艮�
//臼�          � do contas a pagar                                          艮�
//臼麺様様様様謡様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様恒�
//臼�Uso       � AP8                                                        艮�
//臼藩様様様様溶様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様識�
//臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼�
//烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝�  
//
//	Alteracao:	31/01/13	- Vitor Sbano - Gravacao de Campo - SE2->E2_DATALIB para registros de Titulos a Pagar gerados por MATA103 (compras)
//
//


User Function MT100GE2()

Local nOpc 	 := PARAMIXB[2]
Local aHeadSE2	 := PARAMIXB[3]
Local aParcelas := ParamIXB[5]
Local nX 		 := ParamIXB[4]

Local nPosBar := Ascan(aHeadSE2,{|x| Alltrim(x[2]) == 'E2_CODBAR'})
Local cCodBar := aParcelas[nX][nPosBar]

Local nPosDig := Ascan(aHeadSE2,{|x| Alltrim(x[2]) == 'E2_LINDIG'})
Local cLinDig := aParcelas[nX][nPosDig]

Private V_Alias,V_Recno

If nOpc == 1 // .. inclusao
     SE2->E2_CODBAR := cCodBar
     SE2->E2_LINDIG := cLinDig
Endif

V_Alias := Alias()
V_Recno := Recno()

Dbselectarea("SE2")

Reclock("SE2",.F.)
   SE2->E2_CCD     := "998"
   SE2->E2_YDTSYST := DATE()
   //
   SE2->E2_DATALIB	:=	dDATABASE			&& Inclusao 31/01/13 - Vitor Sbano - Implementacao de Bloqueio - Financeiro (fase 3 1/2)
   //
  // IF SE2->E2_ORIGEM == 'PLSMPAG'
  //    SE2->E2_APRUSR:=fBSCAPRO(SE2->E2_CODRDA, SE2->E2_PLLOTE)
  // ELSE 
  // IF SE2->E2_ORIGEM == 'MATA100'

  // ELSE 
  //    SE2->E2_APRUSR:= ' ' 
  // ENDIF

Msunlock()

DbSelectArea(V_Alias)
DbGoto(V_Recno)
 
Return (.T.)


/*
fBSCAPRO(E2CODRDA, E2PLLOTE)
 
 local cCodApr:= ' '
 local cCodRda:= E2CODRDA
 local cPllote:= E2PLLOTE
 local cSql   := ' ' 

If nOpc == 1 .and. se2->e2_origem == 'PLSMPAG'

   cSql += " SELECT BD7_YLIBN1 , BD7_YLIBN2 , BD7_YLIBN3 , BD7_YLIBN4 "+ CRLF
   cSql += "   FROM " + siga."+RetSqlName('BD7') + " BD7 "+ CRLF
   cSql += "  WHERE BD7_FILIAL = '"+xFilial("BD7")+"' "+ CRLF
   cSql += "    AND BD7.D_e_l_e_t_ = ' ' "+ CRLF
   cSql += "    AND BD7_YLIBFA = 'T' "+ CRLF
   cSql += "    AND BD7_CODRDA = '+SE2->E2_CODRDA+' AND BD7_NUMLOTE = '+SE2->E2_PLLOTE +' "+ CRLF

   If Select(("TRB")) <> 0
					
      ("TRB")->(DbCloseArea())
					
   EndIf
					                                                                                           
   TcQuery cSql New Alias ("TRB")
   
   ("TRB")->(dbGoTop())

   If  !("TRB")->(EOF())

      If TRB->YLIBN4 <> ' '   
         cCodApr := TRB->YLIBN4
      ElseIf TRB->YLIBN3 <> ' '   
         cCodApr:= TRB->YLIBN4
      ElseIf TRB->YLIBN2 <> ' '   
         cCodApr:= TRB->YLIBN2
      ElseIf TRB->YLIBN1 <> ' '   
         cCodApr:= TRB->YLIBN1
      EndIf  
   
   EndIf

EndIf

Return(cCodApr)

#INCLUDE "TOTVS.CH"
#include 'parmtype.ch'

User Function MT100GE2()
Local aTitAtual := PARAMIXB[1]
Local nOpc := PARAMIXB[2]
Local aHeadSE2:= PARAMIXB[3]
Local aParcelas := ParamIXB[5]
Local nX := ParamIXB[4]
//.....Exemplo de customiza艫o
If nOpc == 1 //.. inclusao
     SE2->E2_HIST:="Exemplo de utiliza艫o do P.E. MT100GE2 "
Endif

Return(Nil)
*/
