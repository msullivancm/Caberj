/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ BUSCAANA ³ Autor ³ Luzio Tavares         ³ Data ³ 20.02.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Gatilho do campo SZN_CODRDA                                ³±±                 
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function BUSCAANA(cCampo)

LOCAL cRet 	:= ''
LOCAL aArea := GetArea()
LOCAL cSQL  := ' '

//M->ZZP_NOMANA := Space( TamSX3("ZN_NOMANA")[1] )
//M->ZZP_CODANA := Space( TamSX3("ZN_CODANA")[1] )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta query...                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSQL := "SELECT * "

//Leonardo Portella - 07/10/16 - Início

//Atualmente este controle eh feito somente na Caberj mas eh valido para Integral tambem.
//cSql += " FROM " + RetSQLName("SZN") + " SZN "
cSql += " FROM SZN010 SZN "

//Leonardo Portella - 07/10/16 - Fim

cSQL += " WHERE ZN_FILIAL = '"+xFilial("SZN")+"' "
cSQL += " AND ZN_CODRDA = '" + M->ZZP_CODRDA + "' "
cSQL += " AND D_E_L_E_T_ = ' ' "
cSQL += " ORDER BY ZN_OPERDA, ZN_CODRDA, ZN_CODANA "
PLSQuery(cSQL,"Trb1")
TRB1->(dbGoTop())

If !TRB1->(eof()) 
	While !TRB1->(Eof()) .and. xFilial("SZN")+TRB1->ZN_CODRDA == M->ZZP_FILIAL+M->ZZP_CODRDA
		dVigDe := TRB1->ZN_VIGINI
		dVigAte:= TRB1->ZN_VIGFIM
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//| Indica se o eh intervalo valido
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty(TRB1->ZN_VIGFIM) .and. (TRB1->ZN_ATIVO == '0' .or. Empty(TRB1->ZN_ATIVO))
			cRet := TRB1->ZN_CODANA
			M->ZZP_NOMANA := USRRETNAME(TRB1->ZN_CODANA)   //TRB1->ZN_NOMANA 
		Endif
		TRB1->(DbSkip())
	Enddo
EndIf
TRB1->(DbCloseArea())

RestArea(aArea)          

If Empty(M->ZZP_NOMANA)
  
  //Leonardo Portella - 07/10/16 - Melhora na clareza da mensagem pois estava gerando questionamento do Contas Médicas.
  //MsgAlert("Nao foi localizado o Analista da RDA " + M->ZZP_CODRDA + " (gravado branco) verifique posteriormente o cadastro.")
  MsgAlert("Não foi localizado o analista responsável pelo RDA " + M->ZZP_CODRDA + ". Verifique posteriormente o cadastro.",AllTrim(SM0->M0_NOMECOM))
  	  
End if  

Return(cRet)