#INCLUDE "PROTHEUS.CH"
#include "ap5mail.ch"        
#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFA050DEL  บAutor  ณMarcela Coimbra     บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Ponto de entrada executado no momento do tํtulo de contas a ฑฑ
ฑฑบ          ณ receber.  Usado para gerar Log da exclusao de Lotes de     บฑฑ
ฑฑบ          ณ pagamento no PLS.                                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User function FA050Del  
Local aAreaB44
Local aAreaSZ9
Local lFechado := .F.
                                                                                           
Private _lret 		:= .T.
Private l_ExcInd 	:= .T.
Private c_DadosLote := ""  
                         
If FunName() <> "PLSA470" .or. Alltrim( GetNewPar("MV_XXFA50","C") ) <> "C" // Parametro para cancelamento da rotina
	//BIANCHINI - 26/06/2020 - Trava de exclusใo de Titulo a PAGAR com custo fechado
	//Se o Titulo a pagar for de reembolso, tenho que checar a compet๊ncia do reembolso e verificar 
	If ALLTRIM(SE2->E2_PREFIXO) $ "RLE|AXF"

		aAreaB44 := B44->(GetArea())
		DbSelectArea("B44")
		B44->(DbSetOrder(3))
		If B44->(DbSeek(xFilial("B44")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO)))
			If !Empty(B44->B44_YDTCON) 	
				aAreaSZ9 := SZ9->(GetArea())
				DbSelectArea("SZ9")
				SZ9->(DbSetOrder(1))
				If DbSeek(xFilial("SZ9")+SUBS(DTOS(B44->B44_YDTCON,'YYYYMMDD'),1,6))
					If SZ9->Z9_STATUS == "F"
						lFechado := .T.
					Endif
				Endif
				SZ9->(DbCloseArea())
				RestArea(aAreaSZ9)
			Endif
			
			If lFechado
				MsgAlert(" Aten็ใo! Este reembolso pertence a uma Compet๊ncia de Custo Fechada, "+c_ent+;
						 " Nใo serแ possivel realizar a exclusใo! "+c_ent+;
						 " Favor abrir chamado para a GETIN, detalhando o motivo da exclusใo. ")
				_lRet := .F.
			Endif
			B44->(DbCloseArea())
			RestArea(aAreaB44)
		Endif
	Endif 

	Return _lret

EndIf

dbSelectArea("BAF")
c_DadosLote :="*** LOTE: " + BAF->BAF_NUMLOT + ", ANO LOTE: " + BAF->BAF_ANOLOT + ", MES LOTE: " + BAF_MESLOT + "***"

IF Type("xx_c_DadosLote") == "U" .OR. procname(15) == "PLSA470EXC"

	Public xx_c_Primeira	:= .T. 
	Public xx_nRadioGrp1	:= 0               
	Public xx_nOpc     		:= 0
	Public xx_cMemo1    	:= ""       
	Public xx_c_DadosLote 	:= c_DadosLote                                                                              	

ElseIf c_DadosLote <> xx_c_DadosLote
    
	Public xx_c_Primeira	:= .T. 
	Public xx_nRadioGrp1	:= 0               
	Public xx_nOpc     		:= 0
	Public xx_cMemo1   	 	:= ""    
	Public xx_c_DadosLote 	:= c_DadosLote    
	
Else                          

	xx_c_Primeira:= .F.
	
EndIf   

If procname(15) <> "PLSA470EXC"

	l_ExcInd := .F.
    
EndIf
                                                                
// Verifica se o custo ja esta fechado para o periodo
dbSelectArea("SZ9")
dbSetOrder(1) 

//Leonardo Portella - 20/05/11 - Inicio                                        
//Adaptacao para a conferencia do campo status, o qual se estiver diferente de 'F' (fechado), significara que o bloqueio esta aberto.                                                             
	
//If dbSeek( xFilial("SZ9") + BAF->BAF_ANOLOT + BAF->BAF_MESLOT )
If dbSeek( xFilial("SZ9") + BAF->BAF_ANOLOT + BAF->BAF_MESLOT ) .and. SZ9->Z9_STATUS == 'F' 

//Leonardo Portella - 20/05/11 - Fim
	     
	A_FA050Del() // Chama rotina para montar a tela de pergunta se deseja realmente excluir o tํtulo. 
	
Else
	
	_lret:=.T.
	
endif       

Return _lret
    
// Fun็ใo responsavel por montar a tela para justificativa da exclusao
Static Function A_FA050Del()

Private oMemo1
Private oRadioGrp1
Private _oDlg				// Dialog Principal

Private VISUAL := .F.                        
Private INCLUI := .F.                        
Private ALTERA := .F.                        
Private DELETA := .F.                        

If xx_c_Primeira // Exibe a tela para o primeiro tํtulo no caso de exclusao de Lote

 	DEFINE MSDIALOG _oDlg TITLE "Custo Fechado" FROM 178,185 TO 422,715 PIXEL
	
		// Cria as Groups do Sistema
		@ 003,002 TO 027,258 LABEL "" PIXEL OF _oDlg
		@ 029,068 TO 090,257 LABEL "" PIXEL OF _oDlg
		@ 092,003 TO 120,257 LABEL "" PIXEL OF _oDlg
	
		// Cria Componentes Padroes do Sistema
		@ 012,007 Say "O custo para o perํodo informado ja estแ fechado. Deseja realmente excluir o titulo? " Size 244,012 COLOR CLR_BLACK PIXEL OF _oDlg
		@ 029,003 TO 092,066 LABEL "" PIXEL OF _oDlg
		@ 033,006 Radio oRadioGrp1 Var xx_nRadioGrp1 Items "Nใo","Sim" 3D Size 041,010 PIXEL OF _oDlg
		@ 036,073 Say "Justifique o motivo da exclusใo" Size 075,008 COLOR CLR_BLACK PIXEL OF _oDlg
		@ 048,073 GET oMemo1 Var xx_cMemo1 MEMO WHEN .T. Size 180,039 PIXEL OF _oDlg
		@ 101,170 Button "Cancela" Size 037,012 PIXEL OF _oDlg Action { xx_nOpc:= 2 , _oDlg:End()}
		@ 101,213 Button "Ok" Size 037,012 PIXEL OF _oDlg Action {|| xx_nOpc:= 1, Valida() }
	
	ACTIVATE MSDIALOG _oDlg CENTERED 

Endif	

If ( xx_nRadioGrp1 == 1 .AND. xx_nOpc == 1 ) .or. xx_nOpc == 2 .AND. xx_c_Primeira //nao quer excluir e confirmou           

	lmserroauto := .T.         
	_lret := .F.

ElseIf xx_nRadioGrp1 == 2 .AND. xx_nOpc == 1 .AND. xx_c_Primeira // quer excluir e confirmou           

	lmserroauto := .F.         
	_lret := .T.

	MontaEmail()             
	gravaJus()      
	
ElseIf !xx_c_Primeira .AND. !l_ExcInd

	gravaJus()

EndIf                


Return(.T.)

//Func็ใo responsแvel por grabar o Log da exclusao
Static Function gravaJus()      

cSeq := PLBX1NEW()    
dbSelectArea("SE2")
                     
BX1->(RecLock("BX1",.T.))

	BX1->BX1_FILIAL   	:= xFilial("BX1")
	BX1->BX1_SEQUEN   	:= cSeq
	BX1->BX1_ALIAS    	:= "SE2"
	BX1->BX1_RECNO    	:= strzero( SE2->( rECNO()) , 10)
	BX1->BX1_TIPO     	:= "E"
	BX1->BX1_USUARI   	:= USRFULLNAME( __cUserId )
	BX1->BX1_DATA     	:= Date()
	BX1->BX1_HORA     	:= Time()
	BX1->BX1_ESTTRB   	:= GetComputerName()
	BX1->BX1_ROTINA 	:= funname()
	BX1->BX1_XOBS 		:= c_DadosLote + "JUSTIFICATIVA USUมRIO: " + xx_cMemo1
	
	
BX1->(MsUnLock())       
      
dbSelectArea("BX1")

Return  
                                                  
// Func็ใo responsแvel por validar a tela
Static Function Valida()
           
If xx_nRadioGrp1 == 2 .AND. Empty( xx_cMemo1 )

	Alert("Se deseja excluir o tํtulo relacionado ao lote mesmo estando com o custo fechado, inclua uma justificativa.")       
      
Else

	_oDlg:End()                                                                                           
	
EndIf

Return    

Static Function MontaEmail()   

Local oMsg
Local _cError     := ""
Local _lResult    := .F.                   // resultado de uma conexใo ou envio
Local cArqTxt     := "\HTML\EXCRDA.HTML"   // Local do Modelo HTML (Protheus_Data\...)
Local nHdl        := fOpen(cArqTxt,68)
Local c_Body       := space(99999)
Private _cServer  := Trim(GetMV("MV_RELSERV")) // smtp.ig.com.br ou 200.181.100.51
Private _cUser    := Trim(GetMV("MV_RELACNT")) // fulano@ig.com.br
Private _cPass    := Trim(GetMV("MV_RELPSW"))  // 123abc
Private _cFrom    := "CABERJ"
Private _cTo      := GetMV("MV_XLOGMAI")
Private _cCC      := ""
Private _cSubject := "Exclusใo de Lote de Pagamento"
Private cMsg      := ""
Private cdata	  := DATE()
Private cNomFor
Private cNum          
Private nOrdSE2Esp  := GetNewPar("MV_PLSOSE2",11)

Private c_Itens:= ""

c_Itens := " <tr> "
c_Itens += "            <td style='width: 105px; color: rgb(0, 102, 0);'>c_Prefix</td>"
c_Itens += "            <td style='width: 123px; color: rgb(0, 102, 0);'>c_Num</td>"
c_Itens += "            <td style='width: 196px; color: rgb(0, 102, 0);'>c_Comple</td>"
c_Itens += "            <td style='width: 129px; color: rgb(0, 102, 0);'>c_Parcela</td>"
c_Itens += "            <td style='width: 111px; color: rgb(0, 102, 0);'>c_Fornece</td>"
c_Itens += "            <td style='width: 129px; color: rgb(0, 102, 0);'>c_Emissao</td>"
c_Itens += "            <td style='width: 294px; color: rgb(0, 102, 0);'>c_Valor</td>"
c_Itens += "          </tr>"                                                    
                              
If nHdl == -1
	//alert("O arquivo de nome "+cArqTxt+" nao pode ser aberto! Verifique os parametros.","Atencao!")
	Return
Endif
         
nBtLidos := fRead(nHdl,@c_Body,99999)
fClose(nHdl)

dbSelectArea("BAF")

c_Body := StrTran(c_Body,"c_Emp"   		, SM0->M0_NOME+"/"+SM0->M0_FILIAL)
c_Body := StrTran(c_Body,"c_Operadora"  , BAF->BAF_OPESIS )// mbsc
c_Body := StrTran(c_Body,"c_NomeOp"    	, BAF->BAF_NOMOPE )
c_Body := StrTran(c_Body,"c_Lote"    	, BAF->BAF_NUMLOT )
c_Body := StrTran(c_Body,"c_AnoLote"    , BAF->BAF_ANOLOT )
c_Body := StrTran(c_Body,"c_MesLote"    , BAF->BAF_MESLOT )
c_Body := StrTran(c_Body,"c_DataLancto" , dtoc(BAF->BAF_DTDIGI ))
c_Body := StrTran(c_Body,"c_Justifica"  , xx_cMemo1 )
c_Body := StrTran(c_Body,"c_DtExclu"  	, dtoc( dDataBase ) )
c_Body := StrTran(c_Body,"c_Usuario"  	, UsrFullName(__cUserId ) )

c_TitIt:= c_Itens
c_ItFim:= ""

If !l_ExcInd

	SE2->(DbSetOrder(nOrdSE2Esp))
	
	   If SE2->(MsSeek(xFilial("SE2")+BAF->(BAF_CODOPE+BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)))
	      
	      While SE2->(E2_FILIAL+E2_PLOPELT+E2_PLLOTE) ==  xFilial("SE2")+BAF->(BAF_CODOPE+BAF_ANOLOT+BAF_MESLOT+BAF_NUMLOT)
	        
	        c_TitIt:= c_Itens
	        
			c_TitIt := StrTran(c_TitIt, "c_Prefix"  , SE2->E2_PREFIXO)
			c_TitIt := StrTran(c_TitIt, "c_Num"		, SE2->E2_NUM)
			c_TitIt := StrTran(c_TitIt, "c_Comple"  , SE2->E2_COMPLEN + "&nbsp;")
			c_TitIt := StrTran(c_TitIt, "c_Parcela" , SE2->E2_PARCELA + "&nbsp;")     
			c_TitIt := StrTran(c_TitIt, "c_Fornece" , SE2->E2_FORNECE + SE2->E2_LOJA + POSICIONE("SA2", 1, XFILIAL("SE2") + SE2->E2_FORNECE + SE2->E2_LOJA, "A2_NREDUZ") )
			c_TitIt := StrTran(c_TitIt, "c_Emissao" , DTOC(SE2->E2_EMISSAO) )
			c_TitIt := StrTran(c_TitIt, "c_Valor"   , 	Transform(SE2->E2_VALOR ,"999,999.99" ))
			
			c_ItFim += c_TitIt       	  
	           
	      	SE2->( dbSkip() )
	      
	      EndDo
	      
	   Endif
	   
Else

	c_TitIt := StrTran(c_TitIt, "c_Prefix"  , SE2->E2_PREFIXO)
	c_TitIt := StrTran(c_TitIt, "c_Num"		, SE2->E2_NUM)
	c_TitIt := StrTran(c_TitIt, "c_Comple"  , SE2->E2_COMPLEN + "&nbsp;")
	c_TitIt := StrTran(c_TitIt, "c_Parcela" , SE2->E2_PARCELA + "&nbsp;")     
	c_TitIt := StrTran(c_TitIt, "c_Fornece" , SE2->E2_FORNECE + SE2->E2_LOJA + POSICIONE("SA2", 1, XFILIAL("SE2") + SE2->E2_FORNECE + SE2->E2_LOJA, "A2_NREDUZ") )
	c_TitIt := StrTran(c_TitIt, "c_Emissao" , DTOC(SE2->E2_EMISSAO) )
	c_TitIt := StrTran(c_TitIt, "c_Valor"   , 	Transform(SE2->E2_VALOR ,"999,999.99" ))
	c_ItFim := c_TitIt       	  
	
EndIf

c_Body  := StrTran(c_Body,"c_ItemTiti"    , c_ItFim)

c_Body  := StrTran(c_Body,CHR(13)+CHR(10) , "")


CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT _lResult


If !MailAuth(_cUser,_cPass)
	//MSGINFO("Falla de Atentificacion","Error")
	DISCONNECT SMTP SERVER RESULT lOk
	IF !lOk
		GET MAIL ERROR cErrorMsg
		//Alert("Error al tratar de enviar correo  Error")
	ENDIF

EndIf

SEND MAIL FROM _cUser TO _cTo SUBJECT _cSubject BODY c_Body  RESULT _lResult

If !_lResult
	GET MAIL ERROR _cError
	//alert("Erro ao conectar no servidor: " + _cError)
	Return
Endif

If !_lResult
	GET MAIL ERROR _cError
	//("Erro ao enviar e-mail: " + _cError)
	Return    

Endif


Return

User Function PLSE2EXC
lMsErroAuto := .F.
lMsHelpAuto := .F.

Return