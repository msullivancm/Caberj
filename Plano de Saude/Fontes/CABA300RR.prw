#include "PLSMGER.CH"
#include "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRRA300A³ Autor ³ Luzio Tavares        ³ Data ³ 05.05.2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica em qual operadora o usuario esta cadastrado       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CRRA300A(cCodPac)
Local aArea    := GetArea()
Local cSQL     := Space(0)
Local cAlias   := "BA1"
LOCAL nOrdBA0
LOCAL nRecBA0
LOCAL lTemAED := .F.
//Local cOpeOri <> PLSINTPAD()
LOCAL cProjeto := Space(0)  



cCodInt := SubStr(AllTrim(cCodPac),1,4)
cCodEmp := SubStr(AllTrim(cCodPac),5,4)
cMatric := SubStr(AllTrim(cCodPac),9,6)
cTipReg := SubStr(AllTrim(cCodPac),15,2)
cDigito := SubStr(AllTrim(cCodPac),17,1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vwerifica se o usuario estiver ativo em projetos, exibe mensagem...      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If BF4->(MsSeek(xFilial("BF4")+cCodInt+cCodEmp+cMatric+cTipReg))
	While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == cCodInt+cCodEmp+cMatric+cTipReg .And. !BF4->(Eof())
		If ( (BF4->BF4_CODPRO $ GetNewPar("MV_YPLAED","0024,0038,0041")) .OR.;  
		     (BF4->BF4_CODPRO == GetNewPar("MV_XCODMT","0083")) )  //MATURIDADE 06/14
			
			If Empty(BF4->BF4_DATBLO) .Or. (!Empty(BF4->BF4_DATBLO) .And. (BF4->BF4_DATBLO > dDataBase))
				If BI3->(MsSeek(xFilial("BI3")+BF4->BF4_CODINT+BF4->BF4_CODPRO))
					cProjeto := AllTrim(BI3->BI3_NREDUZ)+", "
				EndIf
				
				lTemAED := .T.
			Endif
		Endif
		BF4->(DbSkip())
	Enddo
Endif

If lTemAED                                    
    Aviso( "Usuario Cadastrado em Projeto","A T E N C A O! Este usuario e participante do projeto "+cProjeto+"!!!",{ "Ok" }, 2 ) 
Endif

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRRA300B³ Autor ³ Luzio Tavares        ³ Data ³ 05.05.2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica qual o local de atendimento do operador           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CRRA300B(cCodLoc)
Local aArea    := GetArea()
Local cAlias   := "BA1"
LOCAL nOrdBA0
LOCAL nRecBA0
LOCAL lRet := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vwerifica se o usuario estiver ativo em projetos, exibe mensagem...      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                         		
BX4->(DbSetOrder(2))  
If BX4->(MsSeek(xFilial("BX4")+__CUSERID+"1"))    
	While BX4->(BX4_FILIAL+BX4_CODOPE+BX4_PADRAO) == xFilial("BX4")+__CUSERID+"1" .And. !BX4->(Eof())  
		lRet := BX4->BX4_YCDLOC == cCodLoc .OR. Upper(Alltrim(cusername)) $ Upper(GetNewPar("MV_YGAAAG","ADMIN")) .or. (BX4->BX4_YCDLOC == "999")
		BX4->(DbSkip())
	Enddo
Endif

If !lRet
	//Aviso( "Local de Atendimento","A T E N C A O! Seu cadastro nao permite acessar este local!!! Vou permitir por enquanto",{ "Ok" }, 2 )
	Aviso( "Local de Atendimento","A T E N C A O! Seu cadastro nao permite acessar este local (Nupre) !!! ",{ "Ok" }, 2 )
    //lRet := .T.
Endif

Return(lRet)         


/*
±±³Programa  ³ CRRA300C
*/
User Function CRRA300C

BTS->(DbSetOrder(1))  
If BTS->(MsSeek(xFilial("BTS")+M->BTH_MATVID))    
  While BTS->BTS_MATVID == M->BTH_MATVID .And. !BTS->(Eof())  
    Reclock("BTS",.F.)
    BTS->BTS_YGRINC := M->BTH_YGRINS
    BTS->(MsUnlock())
    BTS->(DbSkip())
  Enddo  
Endif

Return()             

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRRA300D³ Autor ³ Motta                ³ Data ³ julho/14   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica numero de consultas para o paciente no mes        ³±±    
±±³          ³ ChAmado pelo Valid do Campo BBO_CODPAC                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CRRA300D(cCodPac,dData,cCodLoc)
Local aArea    := GetArea()
Local cSQL     := Space(0)
Local nQtd 	   := 0       

//VERIFICA SE O PACIENTE TEM 2 CONSULTAS AGENDADAS PARA O MES         
cSQL := "SELECT COUNT(R_E_C_N_O_) QTD  " 
cSQL += "FROM   " +RetSQLName("BBD")+" BBD " 
cSQL += "WHERE  BBD_FILIAL = ' '    "   
cSQL += "AND    BBD_CODPAC = '" + cCodPac + "' " 
//cSQL += "AND    BBD_LOCAL IN ('053','057')    "   // ANTIGO NUPRE E CENTRO MEDICO 
cSQL += "AND    BBD_CODIGO = '125970' "
cSQL += "AND    SUBSTR(BBD_DATA,1,6) = " + Substr(DtoS(dData),1,6) + " "   	
cSQL += "AND    BBD_STATUS = '1'    "   
cSQL += "AND    BBD.D_E_L_E_T_ = ' ' "  
cSQL := ChangeQuery(cSQL)
PLSQuery(cSQL,"BDBBD")  
DbSelectArea("BDBBD")
BDBBD->(DbGotop())
While ! BDBBD->( Eof() )  
	nQTD := BDBBD->QTD
 	BDBBD->(DbSkip())
Enddo
BDBBD->(DbCloseArea())     
//FIM VERIFICA      
///If cCodLoc == "057"
	///If nQtd >= 2 //limite de consultas mes vide hd 12214 
	If nQtd >= 3 //limite de consultas mes vide hd 12214
	  //Chamado 12714 , permitir para a senha do sr Vinicius Frota liberação de consultas acima do limite
	  /*If __cUserID == "000494"          
	  	If !(MsgYesNo("A T E N C A O! Este usuario ja tem  "+str(nQtd) +" consultas para o corrente mes !!! Libera assim mesmo ?")) 
	  	  Return(.F.)  
	  	Endif
	  Else*/
	    Aviso( "Usuario Com Consultas","A T E N C A O! Este usuario ja tem  "+str(nQtd) +" consultas para o corrente mes !!!",{ "Ok" }, 2 )      
	    Return(.F.)  
	  //Endif  
	Endif     
///Endif        

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |ValPreArt ºMotta  ³Caberj              º Data ³  01/07/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Validação do campo de Pressao Arterial                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ValPreArt(cPreArt)                                                                                                                   

Local lRet := .T. 
Local nCnt   
Local nPas
Local nPad   
Local oError := ErrorBlock()  

lRet := !Empty(Substr(cPreArt,1,2)) .AND. !Empty(Substr(cPreArt,3,2))

For nCnt := 0 To 100 Step 2
  If lRet
    lRet := (IsDigit(Substr(cPreArt,nCnt,1)) .OR. Empty(Trim(Substr(cPreArt,nCnt,1))))
  Endif
Next    

Begin Sequence
  If lRet
    nPas := Val(Trim(Substr(cPreArt,1,2)))
    nPad := Val(Trim(Substr(cPreArt,3,2))) 
    lRet := (nPas > nPad)
  Endif
  If lRet
    lRet := (nPas <= 30)
  Endif 
  If lRet
    lRet := (nPad >= 3)
  Endif
End Sequence

Return(lRet) 


/*
GATIlHO DO CAMPO BTI_YNORMAL                                            
*/                                                 

User Function Cab300GNM() 

If M->BTI_YNORMA == "0"
  MsgStop("Aviso - A Marcacao deste campo como NAO podera acarretar na mudanca do Protocolo do Paciente !!!" + TCSQLError(),AllTrim(SM0->M0_NOMECOM))
Endif

Return .T.