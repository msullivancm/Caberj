#include "PROTHEUS.CH"
#include "TOPCONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS090GR  �Autor  �Renato Peixoto      � Data �  06/02/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Programa para envio de e-mail de aviso aos gestores no     ���
���          � caso de uma inclus�o ou confirma��o de interna��o.         ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function PLS090GR()
	
	Local _aArea	:= GetArea()
	Local _aArBEA	:= BEA->(GetArea())
	Local _aArBE2	:= BE2->(GetArea())
	Local _aArBR8	:= BR8->(GetArea())
	Local _aArBD5	:= BD5->(GetArea())
	Local _aArBE4	:= BE4->(GetArea())
	Local nOpc 		:= paramixb[1]
	Local cSenhaOld := ""
	
	/*  Comentado aguardando aprova��o para entrar em produ��o
	Local cQuery    := ""
	Local cArqQry   := GetNextAlias()
	Local c_Htm 	:= "HTML\INTERNACAO.html"
	Local c_To 		:= GetMv("MV_GESTINT")//e-mail dos gestores que receber�o aviso quando houver uma inclus�o de interna��o.
	Local c_CC 	    := " "
	Local c_Assunto := "Aviso de inclus�o/autoriza��o de interna��o. "
	Local a_Msg     := {}
	Local c_Projeto := GetMv("MV_PROMAIL")  //Pega o tipo de projeto que deve ser verificado no caso de inclus�o/autoriza��o de interna��o.
	Local lEnvMail  := .F.  //Define se ir� ou n�o enviar o e-mail.
	Local cMatricula:= M->BE4_USUARI
	Local cNome     := M->BE4_NOMUSR
	Local cTelefone := ""
	Local cIdade    := ""
	Local cProjeto  := M->BE4_YDSPRO
	Local cHospital := M->BE4_DESLOC
	Local cTel_Hosp := ""
	Local cSenhaInt := ""//cSenha
	Local cHora     := Time()
	Local cExecut   := M->BE4_NOMEXE
	Local cIntern   := ""
	Local cAcomod   := M->BE4_DESPAD
	Local cIndCli   := M->BE4_INDCLI
	*/
	
	//Teste para preenchimento autom�tico da data e hora da alta no caso do regime de interna��o ser hospital-dia
	/*If AllTrim(FUNNAME()) = "PLSA092" //<> "PLSA094B"  //Rotina de libera��o
	If M->BE4_REGINT = '2'
		RecLock("BE4",.F.)
		BE4->BE4_DTALTA := DDATABASE
		BE4->BE4_HRALTA := "2359"
		BE4->(MsUnlock())
	EndIf
EndIf */

/*  Comentado para aguardar aprova��o para subir Produ��o.
//Se o conte�do do par�metro que define se ser� enviado e-mail na inclus�o de interna��o estiver diferente de "S", a rotina de envio de e-mail n�o ser� executada.
If AllTrim(GetMv("MV_MAILINT")) <> "S" .OR. !INCLUI
Return
EndIf

If AllTrim(M->BE4_GRPINT) = "1"
	cIntern := "Internacao Clinica"
Elseif AllTrim(M->BE4_GRPINT) = "2"
	cIntern := "Internacao Cirurgica"
Elseif AllTrim(M->BE4_GRPINT) = "3"
	cIntern := "Internacao Obstetrica"
Elseif AllTrim(M->BE4_GRPINT) = "4"
	cIntern := "Internacao Pediatrica"
Else
	cIntern := "Internacao Psiquiatrica"
EndIf

//Busca o telefone e idade do usu�rio
DbSelectArea("BA1")
DbSetOrder(1)
If DbSeek(XFILIAL("BA1")+SUBSTR(M->BE4_USUARI,1,14))
	cTelefone := BA1_TELEFO
	cIdade    := STR(CALC_IDADE(ddatabase,BA1->BA1_DATNAS))
EndIf

//Busca o telefone da RDA
DbSelectArea("BAU")
DbSetOrder(1)
If DbSeek(XFILIAL("BAU")+M->BE4_CODRDA)
	cTel_Hosp := BAU->BAU_TEL
EndIf
//alert("Entrou no P.E PLS090GR")
//Alert("Ainda est� no P.E PLS090GR")
//Alert(M->BE4_USUARI)
//Alert(Len(M->BE4_USUARI))

cQuery := "SELECT * "
cQuery += "FROM "+RetSqlName("BF4")+" BF4 "
cQuery += "WHERE  BF4_FILIAL = ' ' "
cQuery += "AND BF4_CODINT || BF4_CODEMP ||  BF4_MATRIC || BF4_TIPREG= '"+SUBSTR(M->BE4_USUARI,1,16)+"' "  //0001000103487101
cQuery += "AND d_e_l_e_t_ <> '*' "

**'-- Preenchimento do vetor a_Msg para Envio de e-mail ------------------'**

If Select(cArqQry) <> 0
	(cArqQry)->(DbCloseArea())
Endif

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQry,.T.,.T.)

If (cArqQry)->(Eof())
	
Return

Else
	
	While !((cArqQry)->(Eof()))
		If AllTrim((cArqQry)->BF4_CODPRO) = AllTrim(c_Projeto)
			lEnvMail := .T.
		EndIf
		(cArqQry)->(DbSKip())
	EndDo
	
EndIf

If !lEnvMail
	
Return

Else
	//Carrega o vetor com os campos que ser�o substitu�dos no html
	aadd( a_Msg, { "matricula"		, cMatricula			    })
	aadd( a_Msg, { "nome"	        , cNome 					})
	aadd( a_Msg, { "telefone"	    , cTelefone					})
	aadd( a_Msg, { "idade"      	, cIdade                 	})
	aadd( a_Msg, { "projetos"		, cProjeto 					})
	aadd( a_Msg, { "hospital"   	, cHospital     			})
	aadd( a_Msg, { "telhosp"     	, cTel_Hosp     			})
	aadd( a_Msg, { "senha"	        , cSenhaInt        			})
	aadd( a_Msg, { "hora"	        , cHora         			})
	aadd( a_Msg, { "executante"   	, cExecut        			})
	aadd( a_Msg, { "tp_internacao"	, cIntern       			})
	aadd( a_Msg, { "acomodacao"  	, cAcomod       			})
	aadd( a_Msg, { "ind_clinica"	, cIndCli        			})
	
	// Fun��o gen�rica encontrada no arquico FUNCSGENERICAS.prw para envio de e-mail.
	u_GEnvMail(c_Htm, c_To, c_CC, c_Assunto, a_Msg )
	
EndIf
*/

/******************************************************************************************/
/*** FABIO BIANCHINI - 02/01/2020 														***/
/*** AJUSTE DO REGIME DE INTERNA��O E DA SENHA EM BD5 DE ACORDO COM A SENHA SELECIONADA ***/
/*** NO REEMBOLSO.																		***/
/******************************************************************************************/
If UPPER(AllTrim(FUNNAME())) == "PLSA001"
	IF nOpc == 3 //Inclus�o
		cSenhaOld := B44->B44_SENHA 
		
		IF cSenhaOld <> B44->B44_YSENHA .AND. !EMPTY(B44->B44_YSENHA) 
			RECLOCK("B44",.F.)
			B44->B44_SENHA := B44->B44_YSENHA
			MSUNLOCK()
			
			RECLOCK("BD5",.F.)
			BD5->BD5_SENHA  := B44->B44_YSENHA
			BD5->BD5_YSENIN := B44->B44_YSENHA
			BD5->BD5_REGATE := "1"  //1=Interna��o; 2=Ambulatorial
			BD5->BD5_ATEAMB := "0"  //1=Sim;0=Nao
			MSUNLOCK()
		ELSE
			RECLOCK("B44",.F.)
			B44->B44_SENHA := " "
			MSUNLOCK()		
			
			RECLOCK("BD5",.F.)
			BD5->BD5_SENHA  := " "
			BD5->BD5_YSENIN := " "
			BD5->BD5_REGATE := "2"  //1=Interna��o; 2=Ambulatorial
			BD5->BD5_ATEAMB := "1"  //1=Sim;0=Nao
			MSUNLOCK()
		ENDIF
	Endif	
Endif

If UPPER(AllTrim(FUNNAME())) == "PLSA094B"
	
	//------------------------------------------------------------
	//Conforme solicitado pela ANS quando ocorre interna��o
	//� necess�rio que um protocolo de atendimento seja
	//criado
	//------------------------------------------------------------
	If VAL(BEA->BEA_ANOAUT) >= 2017
		
		//Rotina respons�vel por criar o protocolo de atendimento
		U_PLSM3C("2")
		
		//FABIO BIANCHINI - 08/04/2021 - CHAMADO ID.: 69993
		//Trecho retirado por causa da desativa��o da rotina CABA604, chamada 
		//pelo PE PLS090M1, por solicita��o da Dra. Evelyn

		//Processo piloto de calendariza��o.
		//Depois ser� criado um campo na BAU para validar
	/*	If BEA->BEA_CODRDA $ "043966|142271|142263|134210|140040|140139|140066|140147|123811"
			
			DbSelectArea("BE2")
			DbSetOrder(1) //BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+BE2_SEQUEN
			If DbSeek(xFilial("BE2") + BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT))
				
				While !BE2->(EOF()) .And. BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT) == BE2->(BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)
					
					DbSelectArea("BR8")
					DbSetOrder(1) //BR8_FILIAL+BR8_CODPAD+BR8_CODPSA+BR8_ANASIN
					If DbSeek(xFilial("BR8") + BE2->(BE2_CODPAD + BE2_CODPRO))
						
						If BR8->BR8_XPAUT = "1"
							
							Reclock("BEA", .F.)
							
							BEA->BEA_XDTPR	:= DAYSUM(DATE(),15)
							BEA->BEA_XDTLIB := CTOD(" / / ")
							
							BEA->(MsUnlock())
							
						Else
							
							Reclock("BEA", .F.)
							
							BEA->BEA_XDTPR	:= DAYSUM(DATE(),15)
							BEA->BEA_XDTLIB := DATE()
							
							BEA->(MsUnlock())
							
						EndIf
						
					EndIf
					
					BE2->(DbSkip())
					
				EndDo
				
				Aviso("Aten��o","A previs�o de autoriza��o desta solicita��o �: " + DTOC(BEA->BEA_XDTPR),{"OK"})
				
			EndIf
			
		Else
			
			Reclock("BEA", .F.)
			
			BEA->BEA_XDTPR	:= DATE()
			BEA->BEA_XDTLIB := DATE()
			
			BEA->(MsUnlock())
			
		EndIf
		*/
		//-------------------------------------------------
		//Angelo Henrique - Data:11/02/2021
		//-------------------------------------------------
		//RDM 404 
		//Inclu�do processo de auditoria da Farm�cia
		//Parametro MV_XPFRMC para o RDA farm�cia
		//-------------------------------------------------
		If BEA->BEA_CODRDA $ GETNEWPAR("MV_XPFRMC","127173")

			DbSelectArea("BE2")
			DbSetOrder(1) //BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+BE2_SEQUEN
			If DbSeek(xFilial("BE2") + BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT))

				While !BE2->(EOF()) .And. BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT) == BE2->(BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)

					If BE2->BE2_CODPAD $ ("023,020")

						If MSGYESNO( "Deseja enviar este item para auditoria?", "Auditoria Fam�cia." )

							//--------------------------------------------------------------------------------
							//ROTINA QUE IR� CRIAR TODA A MOVIMENTA��O PARA QUE ESTE ITEM ENTRE EM AUDITORIA
							//--------------------------------------------------------------------------------
							u_CABA095(BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT))
							
						EndIf

						Exit

					EndIf
					
					BE2->(DbSkip())
						
				EndDo

			EndIf
			
		EndIf

	EndIf
	
	//SERGIO CUNHA - 28/10/2019 INICIO - GRAVANDO NOME USU�RIO EM BRANCO.
	Reclock("BEA", .F.)
	BEA->BEA_NOMUSR	:= ALLTRIM(BA1->BA1_NOMUSR)			
	BEA->(MsUnlock())
	//SERGIO CUNHA - 28/10/2019 FIM
	
EndIf

RestArea(_aArBR8)
RestArea(_aArBE2)
RestArea(_aArBEA)
RestArea(_aArea	)
RestArea(_aArBD5)
RestArea(_aArBE4)

Return
