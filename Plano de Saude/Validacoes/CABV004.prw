#include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV004   ºAutor  ³Leonardo Portella   º Data ³  16/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validacao dos campos BE1_USUARI e BE4_USUARI na liberacao daº±±
±±º          ³internacao de modo a nao permitir que seja selecionado um   º±±
±±º          ³usuario de reciprocidade eventual.                          º±±
±±º          ³                                                            º±±
±±º          ³ Alterado por Motta para avisar se houver internacao em     º±±
±±º          ³ aberto para o Usuario                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV004(cCpoUsr, cCampoData) 
//cCpoUsr -> BE1_USUARI | BE4_USUARI
//cCampoData -> BE1_DATPRO | BE4_PRVINT

Local lRet 	:= .T.
Local aArea	:= GetArea()
Local aAreaBE4	:= BE4->(GetArea())
Local cXSenha := " "         

If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'

	If FunName() == "PLSA092" 
	
		u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "CABV004 - 1")
	
	EndIf
	
EndIf

If INCLUI .and. !empty(M->&cCpoUsr)

	dbSelectArea('BA3')
    dbSetOrder(1)//BA3_FILIAL + BA3_CODINT + BA3_CODEMP + BA3_MATRIC + BA3_CONEMP + BA3_VERCON + BA3_SUBCON + BA3_VERSUB

    cOperadora 	:= left(M->&cCpoUsr,4)
    cGrpEmp		:= substr(M->&cCpoUsr,5,4)
    cMatricula	:= substr(M->&cCpoUsr,9,6)
    cMatUsr     := substr(M->&cCpoUsr,1,16) 
    cDataEvento := dtos(M->&cCampoData)
    
    //Parametros de BLoqueio de REciprocidade

    cGrpEmpRec	:= SuperGetMv('MV_XBLREGR') //BLoqueio de REciprocidade GRupo
    cContraRec	:= SuperGetMv('MV_XBLRECO') //BLoqueio de REciprocidade COntrato
    cVersConRec	:= SuperGetMv('MV_XBLREVC') //BLoqueio de REciprocidade Versao Contrato
    cSubConRec	:= SuperGetMv('MV_XBLRESC') //BLoqueio de REciprocidade SubContrato
    cVersSubRec	:= SuperGetMv('MV_XBLREVS') //BLoqueio de REciprocidade Versao Subcontrato

    If MsSeek(xFilial('BA3') + cOperadora + cGrpEmp + cMatricula)

		If 	BA3->BA3_CODEMP == cGrpEmpRec .and. 	;
			BA3->BA3_CONEMP == cContraRec .and. 	;
			BA3->BA3_VERCON == cVersConRec .and. 	;
			BA3->BA3_SUBCON == cSubConRec .and. 	;
			BA3->BA3_VERSUB == cVersSubRec

			Aviso('ATENÇÃO','O usuário selecionado é de reciprocidade eventual (agenda - NUPRE) e o mesmo NÃO poderá ser selecionado!',{'Ok'})

			lRet := .F.

		EndIf

	EndIf

	//Leonardo Portella 21/09/11 - Inicio
	//Considerar o campo BA1_XTPBEN, preenchido na inclusao de reciprocidade da agenda medica

	If lRet .and. INCLUI
        // Mateus Medeiros - Inicio - 16/08/2018
        dbselectarea("BA1")
		dbSetOrder(1)//BA1_FILIAL,BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPUSU,BA1_TIPREG,BA1_DIGITO
		if dbseek(xFilial("BA1")+M->&cCpoUsr) 
		// incluido o dbseek para ponterar corretamente na BA1
		
			If BA1->BA1_XTPBEN == 'RECIPR'
	
				Aviso('ATENÇÃO','O usuário selecionado é de reciprocidade eventual (agenda) e o mesmo NÃO poderá ser selecionado!',{'Ok'})
	
				lRet := .F.
	
			EndIf
		Endif // INCLUIDO - 16/08-2018 - MATEUS MEDEIROS 
	EndIf

	//Leonardo Portella 21/09/11 - Fim   
	
	//Fabio Bianchini - Valida Opcional do usuario - Inicio - 26/03/2012
	if cDataEvento <> " "     

		cSQL := " SELECT BF4_CODINT||BF4_CODEMP||BF4_MATRIC||BF4_TIPREG MATRICULA, BA1_MATVID, BF4_CODPRO " 
		cSQL += "      , SUBSTR(PLS_LISTA_PROJ_ATIVO_NUP (' ',BF4_CODINT,BF4_CODEMP,BF4_MATRIC,BF4_TIPREG,BA1_MATVID,BF4_CODPRO,TO_DATE('" + cDataEvento + "','YYYYMMDD')),1,100) PROGRAMA "
		cSQL += " FROM " + RetSQLName("BF4")+" BF4 " 
		cSQL += "    ,"  + RetSQLName("BA1")+" BA1 " 
		cSQL += " WHERE BF4_FILIAL = '" + xFilial("BF4")+ "'"
	    cSQL += " AND BA1_FILIAL = '" + xFilial("BA1")+ "'"	    
		cSQL += " AND BF4_CODINT||BF4_CODEMP||BF4_MATRIC||BF4_TIPREG = '" + Substr(cMatUsr,1,16) + "'" 
		cSQL += " AND BF4_CODPRO IN ('0024','0038','0041') "    //(" + SuperGetMv("MV_YPLAED") + ") "
		cSQL += " AND BA1_CODINT = BF4_CODINT "
		cSQL += " AND BA1_CODEMP = BF4_CODEMP "
		cSQL += " AND BA1_MATRIC = BF4_MATRIC "
		cSQL += " AND BA1_TIPREG = BF4_TIPREG "
		cSQL += " AND BF4_DATBLO = ' ' "
		cSQL += " AND BF4.D_E_L_E_T_ = ' ' " 
		cSQL += " AND BA1.D_E_L_E_T_ = ' ' "
	    
		//memowrite("C:\CABV004.SQL",cSQL)
	
		PlsQuery(cSQL,"TRB1")
	
		While !(TRB1->(eof())) 
		   //ALERT("Usuario incluido no Projeto: " + Posicione("BI3", 1, xFilial("BI3") + TRB->BF4_CODINT + TRB->BF4_CODPRO, "BI3_CODIGO + '-' + BI3_NREDUZ")) 
		   ALERT("Usuario pertence ao Projeto: " + TRB1->PROGRAMA) 
		   Exit 
	       TRB1->(dbskip())
		EndDo
	
		TRB1->(DbCloseArea())        
	
	Endif
	//Fabio Bianchini - Valida Opcional do usuario - Fim - 26/03/2012

	if lRet .and. FunName() <> "PLSA092"
		// Validar matricula odontologica - Liberação/Autorização SADT
		lRet	:= U_CABV067(  &("M->"+cCpoUsr), .F., "BE1_USUARI")
	endif

//Leonardo Portella - 01/09/14 - Inicio - Nao permitir matricula vazia pois ao deletar e dar enter, o sistema pega a primeira que ele encontra de acordo com o 
//indice ponteirado na BA1

ElseIf empty(M->&cCpoUsr)

	MsgStop('Campo ' + cCpoUsr + ' deve ser preenchido!',AllTrim(SM0->M0_NOMECOM))

//Leonardo Portella - 01/09/14 - Fim

EndIf

RestArea(aArea) 

If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'

	If FunName() == "PLSA092" 
	
		u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "CABV004 - 2")
	
	EndIf
	
EndIf         

//verifica internação

If lRet
	BE4->(DbSetOrder(4))
    BE4->(MsSeek(xFilial("BE4")+substr(M->&cCpoUsr,1,16)))
    If BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG) ==  substr(M->&cCpoUsr,1,16)
  		If (BE4->BE4_SITUAC == "1" .AND. BE4->BE4_REGINT != "2" .AND. Empty(BE4->BE4_DTALTA) .AND. Empty(BE4->BE4_HRALTA))
    		cXSenha := BE4->BE4_SENHA
   		Endif
	Endif
	If cXSenha != " "
  		If MsgYesNo("Existe senha em aberto (" + Trim(cXSenha) + ") para este usuario, prossegue ?")
    		lRet := .T.
  		Else
    		lRet := .F.
  		Endif
	Endif
	RestArea(aAreaBE4)
Endif          

If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'

	If FunName() == "PLSA092" 
	
		u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "CABV004 - 3")
	
	EndIf
	
EndIf

Return lRet
