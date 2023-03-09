#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'UTILIDADES.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA045   ºAutor  ³Leonardo Portella   º Data ³  25/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cadastro de Atividades (PA2).                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/   

User Function CABA045

Local lAcesso := .F.

Private aButtons := {}

DbSelectArea('PA1')
DbSetOrder(1)      
DbGoTop()

//Vejo se tem acesso a todas as gerencias 
If MsSeek(xFilial('PA1') + 'T' + RetCodUsr() + 'S')
	lAcesso := PA1->PA1_TIPADM $ 'D|A'//Delega ou ambos	
EndIf
         
//Vejo se tem acesso a alguma gerencia
If !lAcesso
	DbGoTop()
	If MsSeek(xFilial('PA1') + 'E' + RetCodUsr() + 'S')
		lAcesso := PA1->PA1_TIPADM $ 'D|A'//Delega ou ambos		
	EndIf
EndIf 

aAdd(aButtons,{ "S4SB014N", {||u_CalendAtiv()}, "Calendário da Atividade", "Cal. Ativ" })

If lAcesso           
	AxCadastro("PA2","Cadastro de atividades","U_DelCB045()","U_OkCB045()",,,,,,,,@aButtons)  
Else
	Aviso('ATENÇÃO','Para acessar esta rotina você deve ter acesso a pelo menos uma gerência ativa e ter direito a delegar tarefas.',{'Ok'})
EndIf

Return

****************************************************************************************************************

User Function DelCB045
          
Aviso('ATENÇÃO','Para fins de consistência, não exclua a atividade, mas sim altere-a e coloque-a como Inativa.',{'Ok'})

Return .F.

****************************************************************************************************************

User Function OkCB045

Local lOk 		:= .T. 

DbSelectArea('PA4')
PA4->(DbSetOrder(1))
PA4->(DbGoTop())

If !PA4->(MsSeek(xFilial('PA4') + PA2_CODIGO))
	u_CalendAtiv(.T.)
	            
	PA4->(DbGoTop())
	
	If !PA4->(MsSeek(xFilial('PA4') + PA2_CODIGO))
		Aviso('ATENÇÃO','Informe pelo menos um prazo para a atividade.',{'Ok'})
		lOk := .F.	
	EndIf
EndIf

Return lOk

****************************************************************************************************************
                   
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PA2NextCodºAutor  ³Leonardo Portella   º Data ³  25/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o proximo codigo da tabela PA2. Inicializador padraoº±±
±±º          ³do campo PA2_CODIGO.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/   

User Function PA2NextCod 

Return NextCodTab('PA2','PA2_CODIGO',.T.)
      
****************************************************************************************************************

User Function DESGER
          
Local cDesGer 

If INCLUI 
	cDesGer := POSICIONE('SZM',1,XFILIAL('SZM')+M->PA2_GEREN,'ZM_DESCRI')
Else
	cDesGer := POSICIONE('SZM',1,XFILIAL('SZM')+PA2->PA2_GEREN,'ZM_DESCRI')
EndIf 

Return cDesGer

****************************************************************************************************************

User Function CalendAtiv(lConfirma)

Local nOpc 		:= If(INCLUI .or. ALTERA,GD_INSERT+GD_DELETE+GD_UPDATE,0)
Local bOk		:= {|| AtuPA4(),oDlg1:End()}
Local bCancel	:= {|| oDlg1:End()} 
Local cTitulo	:= "Calendário de atividades - " + M->PA2_CODIGO + ': ' + allTrim(M->PA2_DESCRI) + ' - ' + If(INCLUI,'Incluir',If(ALTERA,'Alterar','Visualizar'))
Local cMsgLabel := ""

Default lConfirma := .F.

Private aAltera	:= {}
Private aCoBrw1 := {}
Private aHoBrw1 := {}
Private aPrazos	:= {}

SetPrvt("oDlg1","oGrp1","oSay1","oBrw1")

cMsgLabel += "Esta rotina permite alterar os prazos da atividade selecionada, incluir e excluir prazos." 	+ CRLF
cMsgLabel += "Insira ou delete manualmente uma data ou apenas clique na data desejada no calendário abaixo"

//Na inclusao, esta rotina sera chamada pelo TudoOk da PA2, de modo que somente sera incluido um PA2 se ja tiver cadastrado um PA4 e o 
//PA4 tera um PA2 pois a inclusao da PA2 sera o Ok da inclusao da PA4.
If lConfirma .or. !INCLUI

	Define MsDialog oDlg1 From 095,001 To 640,1121 Pixel Title cTitulo

		oDlg1:bInit := {||EnchoiceBar(oDlg1,bOk,bCancel,,)}
	
		oGrp1      	:= TGroup():New( 020,012,052,548,"Calendário de atividades",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
		oSay1      	:= TSay():New( 031,016,{||cMsgLabel},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
	    
		MHoBrw1()
		MCoBrw1()  
		oBrw1      	:= MsNewGetDados():New(060,012,145,548,nOpc,'AllwaysTrue()','AllwaysTrue()','',aAltera,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw1,aCoBrw1 )
		oBrw1:bChange := {||AtuMes()}
	    
		oCalend 	:= MsCalend():New(160,012,oDlg1,.T.)
		
		oCalend:ColorDay(1,CLR_RED)
		oCalend:ColorDay(7,CLR_RED)
		
		oCalend:dDiaAtu := Date()
		
		AtuMes()
		
		oCalend:CanMultSel := .F.
		
		nPosPrz := 0
		
		oCalend:bChange 	:= {||If(INCLUI .or. ALTERA,AtuCalen(),.T.),AtuMes()} 
		oCalend:bChangeMes 	:= {||AtuMes()}
		        
		cMsgLabel 	:= 'Esta opção permite incluir prazos periódicos para a atividade, informando a periodicidade e o prazo final.'
		oGrp2      	:= TGroup():New( 155,165,270,550,"Atividade periódica",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
		oSay2      	:= TSay():New( 165,185,{||cMsgLabel},oGrp2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
		
		oFld1      	:= TFolder():New( 170,185,,{},oDlg1,,,,.T.,.F.,350,080,) 
		
		aPeriod := {'Diária','Semanal','Quinzenal','Mensal','Bimestral','Trimestral','Semestral','Anual'} 
		cPeriod := aPeriod[1]
		oSay3  	:= TSay():New( 185,190,{||'Repetição'},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
		oCBox1  := TComboBox():New( 185,220,{|u| If(PCount()>0,cPeriod:=u,cPeriod)},aPeriod,052,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,cPeriod )
		
		oSay4  	:= TSay():New( 200,190,{||'Data início'},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
		dPerIni := Date()
		oGet1   := TGet():New( 200,220,{|u| If(PCount()>0,dPerIni:=u,dPerIni)},oDlg1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dPerIni",,)

		oSay5  	:= TSay():New( 200,270,{||'Data final'},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,528,020)
		dPerFim := Date()
		oGet2   := TGet():New( 200,300,{|u| If(PCount()>0,dPerFim:=u,dPerFim)},oDlg1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dPerFim",,)
         
        lSabados := .F.
        
        oCheck1 := TCheckBox():New(215,190,'Selec. sábados',{||lSabados},oDlg1,80,010,,,,,,,,.T.,,,) 
   		oCheck1:bLClicked := {||lSabados := !lSabados}   
                                              
   		lDomingos := .F.
   		
		oCheck2 := TCheckBox():New(215,245,'Selec. domingos',{||lDomingos},oDlg1,80,010,,,,,,,,.T.,,,) 
   		oCheck2:bLClicked := {||lDomingos := !lDomingos}   
        
   		oBtn1   := TButton():New( 235,190,"Inclui atividade no período",oDlg1,{||IncAtivPer(dPerIni,dPerFim,cPeriod)}	,070,012,,,,.T.,,"",,,,.F. )
		
	Activate MsDialog oDlg1 Centered

ElseIf !lConfirma .and. INCLUI
	Aviso('ATENÇÃO','Rotina disponível somente na alteração ou visualização.',{'Ok'})
EndIf

Return

****************************************************************************************************************

Static Function MHoBrw1()

DbSelectArea("SX3")
DbSetOrder(1)
MsSeek("PA4")

While !Eof() .and. SX3->X3_ARQUIVO == "PA4"

    If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL

		aAdd(aHoBrw1,{Trim(X3Titulo())	,;
			SX3->X3_CAMPO				,;
			SX3->X3_PICTURE				,;
			SX3->X3_TAMANHO				,;
			SX3->X3_DECIMAL				,;
			""							,;
			""							,;
			SX3->X3_TIPO				,;
			""							,;
			"" 							})    
           
		If !(SX3->X3_CAMPO $ 'PA4_FILIAL|PA4_ATIVID')
			aAdd(aAltera,SX3->X3_CAMPO)	
		EndIf
      
   EndIf

   DbSkip()

End     

aAdd(aHoBrw1,{'R_E_C_N_O_'	,;
			'R_E_C_N_O_'	,;
			""				,;
			10				,;
			0				,;
			""				,;
			""				,;
			'N'				,;
			""				,;
			"" 				})

Return

****************************************************************************************************************

Static Function MCoBrw1()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cAlias 	:= GetNextAlias()
Local cQuery 	:= ""
Local cSelect 	:= ""

For i := 1 to len(aHoBrw1)
	cSelect += aHoBrw1[i][2] + ','
Next                              

cSelect := left(cSelect,len(cSelect)-1)

cQuery := "SELECT " + cSelect 								+ CRLF
cQuery += "FROM " + RetSqlName('PA4')						+ CRLF
cQuery += "WHERE D_E_L_E_T_ = ' '" 							+ CRLF
cQuery += "	AND PA4_FILIAL = '" + xFilial('PA4') + "'" 		+ CRLF
cQuery += "	AND PA4_ATIVID = '" + M->PA2_CODIGO + "'" 		+ CRLF
cQuery += "ORDER BY PA4_LIMITE"						 		+ CRLF

TcQuery cQuery New Alias cAlias

cAlias->(DbGoTop())

While !cAlias->(EOF())
     
	aBuffer := {}
	
	For i := 1 to len(aHoBrw1)
		cCpo 	:= aHoBrw1[i][2]	
		
		If aHoBrw1[i][8] == 'D'
			aAdd(aBuffer,StoD(cAlias->&cCpo))	
		Else
			aAdd(aBuffer,cAlias->&cCpo)		 	
		EndIf
	Next
	
	aAdd(aBuffer,.F.)
	
	aAdd(aCoBrw1,aBuffer)

	cAlias->(DbSkip())

EndDo

cAlias->(DbCloseArea())

Return

****************************************************************************************************************

Static Function AtuPA4

Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

DbSelectArea('PA4')
DbSetOrder(1) 
DbGoTop()

For i := 1 to len(oBrw1:aCols)

	If empty(oBrw1:aCols[i][2])
		loop	
	EndIf

	nRecnoOri := oBrw1:aCols[i][len(oBrw1:aCols[i])-1]
	
	//Deletou
	If oBrw1:aCols[i][len(oBrw1:aCols[i])] == .T. .and. nRecnoOri != 0
		nRecnoOri := oBrw1:aCols[i][len(oBrw1:aCols)-1]
		PA4->(DbGoTo(nRecnoOri))
		
		PA4->(Reclock('PA4',.F.))
		PA4->(DbDelete())
		PA4->(Msunlock())
		
	//Incluiu novo limite da atividade
	ElseIf oBrw1:aCols[i][len(oBrw1:aCols[i])] == .F. .and. nRecnoOri == 0
		
		PA4->(Reclock('PA4',.T.))
		
		For j := 1 to len(aHoBrw1)
			cCpo := aHoBrw1[j][2]	
			
			If cCpo != 'R_E_C_N_O_'
				PA4->&cCpo := oBrw1:aCols[i][j]
			EndIf

		Next
		
		PA4_FILIAL := xFilial('PA4')
			
		PA4->(MsUnlock())    
	
	//Alterou	
	Else
		PA4->(DbGoTo(nRecnoOri))
		
		PA4->(Reclock('PA4',.F.))
		
		For j := 1 to len(aHoBrw1)

			cCpo := aHoBrw1[j][2]	

			If cCpo != 'R_E_C_N_O_'
				PA4->&cCpo := oBrw1:aCols[i][j]
			EndIf

		Next
		
		PA4->(MsUnlock())    	
	EndIf
		
Next

Return

****************************************************************************************************************

Static Function AtuCalen

Local nPosPrz := aScan(oBrw1:aCols,{|x|x[2] == oCalend:dDiaAtu})

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

If nPosPrz > 0
	oBrw1:aCols[nPosPrz][len(oBrw1:aCols[nPosPrz])] := !oBrw1:aCols[nPosPrz][len(oBrw1:aCols[nPosPrz])]
Else
	//O MsNewGetDados insere uma linha em branco para digitar quando o aCols esta vazio. Ao incluir direto no aCols, fico com uma linha extra. 
	//Removo esta linha ao incluir uma nova pelo Calendario
	For i := 1 to len(oBrw1:aCols)
		If empty(oBrw1:aCols[i][2])
			aDel(oBrw1:aCols,i)
			aSize(oBrw1:aCols,len(oBrw1:aCols)-1)		
		EndIf
	Next
	
	aAdd(oBrw1:aCols,{M->PA2_CODIGO, oCalend:dDiaAtu, 0, .F.})
EndIf                                 

aSort(oBrw1:aCols,,,{|x,y|x[2] < y[2]})

oBrw1:Refresh()

Return

****************************************************************************************************************

Static Function IncAtivPer(dDiaIni,dDiaFim,cPeriod)

Local nPosPrz := 0

Local i 		:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local dDiaInc 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Do Case 

	Case cPeriod == 'Diária'
		nPeriodicidade := 1 

	Case cPeriod == 'Semanal'
		nPeriodicidade := 7

	Case cPeriod == 'Quinzenal'
		nPeriodicidade := 15

	Case cPeriod == 'Mensal'
		nPeriodicidade := 30

	Case cPeriod == 'Bimestral'
		nPeriodicidade := 60

	Case cPeriod == 'Trimestral'
		nPeriodicidade := 90

	Case cPeriod == 'Semestral'
		nPeriodicidade := 180

	Case cPeriod == 'Anual'
		nPeriodicidade := 365

EndCase

For dDiaInc := dDiaIni to dDiaFim Step nPeriodicidade

	nPosPrz := aScan(oBrw1:aCols,{|x|x[2] == dDiaInc})

	//Se nao permitir sabados, jogo para o domingo
	If !lSabados .and. DoW(dDiaInc) == 7
		++dDiaInc	
		nPosPrz := aScan(oBrw1:aCols,{|x|x[2] == dDiaInc})
	EndIf

    //Se nao permitir domingos, jogo para a segunda
    If !lDomingos .and. DoW(dDiaInc) == 1
		++dDiaInc	
		nPosPrz := aScan(oBrw1:aCols,{|x|x[2] == dDiaInc})
	EndIf

	If nPosPrz <= 0
		//O MsNewGetDados insere uma linha em branco para digitar quando o aCols esta vazio. Ao incluir direto no aCols, fico com uma linha extra. 
		//Removo esta linha ao incluir uma nova pelo Calendario
		For i := 1 to len(oBrw1:aCols)
			If empty(oBrw1:aCols[i][2])
				aDel(oBrw1:aCols,i)
				aSize(oBrw1:aCols,len(oBrw1:aCols)-1)		
			EndIf
		Next

		aAdd(oBrw1:aCols,{M->PA2_CODIGO, dDiaInc, 0, .F.})
	EndIf

Next 

aSort(oBrw1:aCols,,,{|x,y|x[2] < y[2]})

oBrw1:Refresh()

AtuMes()

Return

****************************************************************************************************************

Static Function AtuMes

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

oCalend:DelAllRestri()

For i := 1 to len(oBrw1:aCols)
	If Month(oCalend:dDiaAtu) == Month(oBrw1:aCols[i][2]) .and. Year(oCalend:dDiaAtu) == Year(oBrw1:aCols[i][2]) .and. !oBrw1:aCols[i][len(oBrw1:aCols[i])]
		oCalend:AddRestri(Day(oBrw1:aCols[i][2]), CLR_GREEN, CLR_GREEN)
	EndIf
Next

Return


