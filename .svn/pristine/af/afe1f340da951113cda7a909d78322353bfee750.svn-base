
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS498MN  ºAutor  ³Microsiga           º Data ³  09/05/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS498MN

Local aRetorno     
Local aArea   		:= GetArea()

//Leonardo Portella - 27/11/13 - Virada P11 - Lentidao no sistema
/*
Local nPosMudFas	:= aScan(aRotina,{|x|x[2] == 'PLSA175FAS'})

If nPosMudFas > 0
	aRotina[nPosMudFas,2] := 'U_lMudFase'
EndIf
*/

aRetorno := {"Totalizar PEG",'U_PEGTOTAL'  , 0 , 0   }
Aadd(aRotina, {"Desfazer Liberação",'U_PEGCANCE'  , 0 , 0   })

RestArea(aArea)

Return(aRetorno)

*********************************************************************************************

User Function lMudFase 
             
Local lOk	:= .T.

If lOk 
//	'PLSA175FAS'
EndIf

Return 'PLSA175FAS'

*********************************************************************************************

User Function PEGTOTAL                                          

If MsgYesNo("Confirma a totalizacao da PEG? ","")
   MsAguarde({|| Processo() }, "", "Processando...", .T.)
Endif

Return                          


Static Function Processo()
LOCAL nVlrPag  := 0
LOCAL nVlrGlo  := 0
LOCAL nVlrTx   := 0
LOCAL nQtd     := 0                    
LOCAL nQtdEve  := 0
LOCAL aGuias   := {}            
LOCAL nPos

//Navegar por todos os registros desta PEG
BD6->(DbSetOrder(1))
If BD6->(MsSeek(xFilial("BD6")+BCI->(BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)))
   While ! BD6->(Eof()) .And. BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG) == ;
                               xFilial("BD6")+BCI->(BCI_CODOPE+BCI_CODLDP+BCI_CODPEG)

         MsProcTXT("Processando "+AllTrim(Str(nQtd++)))
         ProcessMessage()
                                  
         //guias prontas ou faturadas
         If BD6->BD6_SITUAC == "1" .And. BD6->BD6_FASE $ "3,4"
            //nVlrPag  += BD6->BD6_VLRPAG
         
			 BD7->(DbSetOrder(1))
			 If BD7->(MsSeek(xFilial("BD7")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)))
			    While ! BD7->(Eof()) .And. BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN) == ;
			                               xFilial("BD6")+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN)                               

               If (BD7->BD7_BLOPAG <> "1") .AND. (BD7->BD7_VLRPAG >= 0) .AND. (BD7->BD7_LOTBLO = " ") .AND. ( BD7->BD7_CONPAG = '1' .OR. BD7->BD7_CONPAG = " " )
                        nVlrGlo	+= BD7->BD7_VLRGLO
                        nVlrPag  += BD7->BD7_VLRPAG
                        nVlrTx   += BD7->BD7_VLTXPG
               Endif

               //nVlrGlo	 += BD7->BD7_VLRGLO

               BD7->(DbSkip())                            
			    Enddo
			 Endif             
         
            //nVlrGlo	 += BD6->BD6_VLRGLO
         Endif   
        
         nPos := ascan(aGuias,BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV))
         If nPos == 0
            nQtdEve ++
            aadd(aGuias,BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV))
         Endif
      
   BD6->(DbSkip())
   Enddo
   
   BCI->(RecLock("BCI",.F.))
   BCI->BCI_VTOGUI := nVlrPag
   BCI->BCI_VTOPRO := nVlrGlo
   BCI->BCI_VLRGLO := nVlrGlo
   BCI->BCI_QTDEVD := nQtdEve
   BCI->BCI_VLRAPR := nVlrPag - nVlrTx + nVlrGlo  //Fabio Bianchini - Data: 14/06/2019
   BCI->BCI_VALORI := nVlrPag - nVlrTx + nVlrGlo  //Fabio Bianchini - Data: 14/06/2019
   BCI->BCI_VLRGUI := nVlrPag - nVlrTx + nVlrGlo  //Angelo Henrique - Data: 17/11/2015   
   BCI->(MsUnLock())
Endif

If nVlrPag > 0
   cCadastro := "Visualizar Dados da PEG"
   BCI->(AxVisual("BCI",BCI->(Recno()),2))
Else
   MsgStop("Nao existem valores a serem totalizados")
Endif

Return

USER FUNCTION PEGCANCE

PRIVATE cCancelLib    := GetNewPar("MV_XCANPEG","001805") 

IF ( __cUserID $ AllTrim(cCancelLib) )   

   
   If MsgYesNo("Confirma o cancelamento da liberação de pagamento da PEG?","")
      MsAguarde({|| Processo1() }, "", "Processando...", .T.)
   Endif
ELSE 
      MsgAlert("Você não tem permissão para cancelar a liberação de pagamento da PEG", "Permissão Negada!")
ENDIF

RETURN

STATIC FUNCTION Processo1()

   IF BCI->BCI_STTISS = '6'
      MsgAlert("Não é possível cancelar a liberação de pagamento de uma PEG já faturada!", "PEG já faturada")
   ELSEIF BCI->BCI_STTISS != '3' .AND. BCI->BCI_STTISS != '4'
      MsgAlert("Somente é possível cancelar uma PEG que já foi liberada para pagamento", "PEG não liberada")
   ELSE
      BCI->(RecLock("BCI", .F.))
         BCI->BCI_STTISS := '2'
         BCI->BCI_USRLIB	:= ""
	      BCI->BCI_DTHRLB	:= ""
      BCI->(MsUnlock())

      MsgInfo("A solicitação de cancelamento da liberação de pagamento da PEG foi concluída com êxito.","Cancelado com Sucesso")
   ENDIF
RETURN


