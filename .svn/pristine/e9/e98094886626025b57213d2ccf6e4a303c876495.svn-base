#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} CABA099
description Rotina responsável enviar e-mail para o prestador
quando for internação de urgência/emergência
@author  Angelo Henrique
@since   date 22/09/2021
@version version
//-------------------------------------------------------------------
@Parametros
    _cParam = BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
/*/
//-------------------------------------------------------------------
User Function CABA099(_cParam)

    Local _aArea    := GetArea()
    Local _aArBE4   := BE4->(GetArea())
    Local _nOpc     := 0
    Local _cMail    := SPACE(TAMSX3("BE4_YMAIL")[1])

    SetPrvt("oDlg1","oGrp1","oSay1","oGet1","oBtn1","oBtn2")

    DbSelectArea("BE4")
    DbSetOrder(2)
    If DbSeek(_cParam)

        /*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
		±± Definicao do Dialog e todos os seus componentes.                        ±±
        Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
        oDlg1      	:= MSDialog():New( 092,232,267,725,"Envio de de Email para o Prestador",,,.F.,,,,,,.T.,,,.T. )
        oGrp1      	:= TGroup():New( 004,004,076,236,"  Envio de Email para Prestador  ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
        oSay1      	:= TSay():New( 016,012,{||"Deseja enviar para qual e-mail?"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,216,012)
        oGet1  		:= TGet():New( 032,012,{|u| If( PCount() == 0, _cMail, _cMail := u )},oGrp1,216,010,'',{|| u_cabv037(_cMail) .or. Empty(_cMail)  },CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)

        oBtn1      	:= TButton():New( 056,144,"Enviar",oGrp1,{||iif(u_cabv037(_cMail),oDlg1:End(),.F.),_nOpc := 1},037,012,,,,.T.,,"Enviar",,,,.F. )
        oBtn2      	:= TButton():New( 056,188,"Fechar",oGrp1,{||oDlg1:End(),_nOpc := 2},037,012,,,,.T.,,"Fechar",,,,.F. )

        oDlg1:Activate(,,,.T.)

        If _nOpc = 1

            CABA097A(_cMail, BE4->BE4_XPROTC)

        EndIf

    EndIf

    RestArea(_aArBE4)
    RestArea(_aArea )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA097A()
description Rotina utilizada para enviar e-mail para o beneficiário
@author  author Angelo Henrique
@since   date 22/09/2021
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA097A(_cEmail,_cProt)

    Local _aArea 	:= GetArea()
    Local _aArBa1	:= BA1->(GetArea())
    Local _aArSZX	:= SZX->(GetArea())
    Local _aArSZY	:= SZY->(GetArea())
    Local _aArBI3	:= BI3->(GetArea())
    Local a_Htm		:= "" //Variavel que irá receber o template do HTML a ser utilizado.
    Local _cTpSrv	:= "" //Primeiro tipo de serviço criado no protocolo
    Local _nCntZy 	:= 0  //Contador utilizado para pegar o próximo número sequencial do protocolo
    Local _cTpSv 	:= "" //Tipo de Serviço gravado no protocolo
    Local _cHst		:= "" //Histórico Padrão gravado no protocolo
    Local _cDscPln	:= "" //Descrição do plano do beneficiário
    Local _cMat 	:= "" //Matricula do beneficiário que abriu o protocolo
    Local c_To		:= _cEmail //Pegando o e-mail digitado na tela
    Local c_CC		:= "centraltecnica@caberj.com.br"
    Local c_Assunto := "Status do Pedido de Internação"
    Local a_Msg		:= {}
    Local _cCanDp	:= ""
    Local _lRet     := .F.
    Local _cObs     := ""
    Local _cNfant   := ""
    Local _cStatus  := ""    

    If !Empty(_cProt)

        //Abrindo o protocolo de atendimento
        DbSelectArea("SZX")
        DbSetOrder(1)
        If DbSeek(xFilial("SZX") + _cProt)

            If cEmpAnt == "01"

                a_Htm := "\HTML\INTERNACABERJPRESTADOR.HTML"

            Else

                a_Htm := "\HTML\INTERNAINTEGRALPRESTADOR.HTML"

            EndIf

            //----------------------------------------------------------------
            //Caso o protocolo seja para um beneficiário registrado
            //irá pegar informações pertinentes ao plano,
            //caso contrário não irá preenche-lo
            //----------------------------------------------------------------
            DbSelectArea("BA1")
            DbSetOrder(2)
            If DbSeek(xFilial("SZX") + SZX->ZX_CODINT + SZX->ZX_CODEMP + SZX->ZX_MATRIC + SZX->ZX_TIPREG + SZX->ZX_DIGITO)

                _cMat := SZX->ZX_CODINT + "." + SZX->ZX_CODEMP + "." + SZX->ZX_MATRIC + "-" + SZX->ZX_TIPREG + "." + SZX->ZX_DIGITO

                DbSelectArea("BI3")
                DbSetOrder(1) //BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
                If DbSeek(xFilial("BI3") + BA1->BA1_CODINT + BA1->BA1_CODPLA)

                    _cDscPln := AllTrim(BI3->BI3_DESCRI)

                Else

                    _cDscPln := ""

                EndIf

                //Pegando o primeiro registro do tipo de serviço
                //para poder encaminhar no e-mail
                DbSelectArea("SZY")
                DbSetOrder(1)
                If DbSeek(xFilial("SZY") + SZX->ZX_SEQ)

                    DbSelectArea("PBL")
                    DbSetOrder(1)
                    If DBSeek(xFilial("PBL") + SZY->ZY_TIPOSV)

                        _cTpSrv := PBL->PBL_YDSSRV

                    EndIf

                EndIf

                _cHora := SUBSTR(SZX->ZX_HORADE,1,2) + ":" + SUBSTR(SZX->ZX_HORADE,3,2)

                _cCanDp := GetAdvFVal("PCA","PCA_DESCRI",xFilial("PCA")+SZX->ZX_PTENT,1)

                _cNfant := POSICIONE("BAU",1,XFILIAL("BAU")+BE4->BE4_CODRDA,"BAU_NFANTA")

                If BE4->BE4_STATUS $ "1|2|6"
                    _cStatus := "Autorizada"                
                ElseIf BE4->BE4_STATUS == "3"
                    _cStatus := "Nao Autorizada"
                ElseIf BE4->BE4_STATUS == "4"
                    _cStatus := "Aguardando finalizacao do atendimento"
                EndIf 

                aAdd( a_Msg, { "_cHosp"		, _cNfant       		}) //Hospital
                aAdd( a_Msg, { "_cBenef"	, SZX->ZX_NOMUSR		}) //Nome do Beneficiário
                aAdd( a_Msg, { "_cMat"		, _cMat					}) //Matricula do Beneficiário
                aAdd( a_Msg, { "_cPlan"		, _cDscPln 				}) //Descrição do Plano do Beneficiário
                aAdd( a_Msg, { "_cSolic"	, BE4->BE4_NOMSOL		}) //Medico solicitante
                aAdd( a_Msg, { "_cSenha"	, BE4->BE4_SENHA		}) //Senha
                aAdd( a_Msg, { "_cStatus"	, _cStatus      		}) //Status
                aAdd( a_Msg, { "_cSeq"		, SZX->ZX_SEQ		    }) //Protocolo
                aAdd( a_Msg, { "_cTpServ"	, _cTpSrv			    }) //Descrição do tipo de serviço
                aAdd( a_Msg, { "_cDtDe"		, DTOC(SZX->ZX_DATDE)   }) //Data de Abertura do Protocolo
                aAdd( a_Msg, { "_cHora"		, _cHora				}) //Hora de Abertura do Protocolo

                //-----------------------------------------------------
                //Função para envio de e-mail
                //-----------------------------------------------------
                If Env_1(a_Htm, c_To, c_CC, c_Assunto, a_Msg, SZX->ZX_SEQ, _cMat, SZX->ZX_RDA )

                    _lRet := .T.

                    //-----------------------------------------------------------------
                    //Gravando mais uma linha na SZY de histórico do envio de e-mail.
                    //-----------------------------------------------------------------
                    DbSelectArea("SZY")
                    DbSetOrder(1)
                    If DbSeek(xFilial("SZY") + SZX->ZX_SEQ)

                        _nCntZy := 1

                        While !Eof() .And. SZX->ZX_SEQ == SZY->ZY_SEQBA

                            _nCntZy ++

                            If !Empty(SZY->ZY_TIPOSV)

                                _cTpSv 	:= SZY->ZY_TIPOSV
                                _cHst	:= SZY->ZY_HISTPAD

                            EndIf

                            SZY->(DbSkip())

                        EndDo

                        _cObs := "E-mail enviado para: " + c_To
                       
                        RecLock("SZY", .T.)

                        SZY->ZY_SEQBA 	:= SZX->ZX_SEQ
                        SZY->ZY_SEQSERV	:= STRZERO(_nCntZy,TAMSX3("ZY_SEQSERV")[1])
                        SZY->ZY_DTSERV	:= dDatabase
                        SZY->ZY_HORASV	:= SUBSTR(TIME(),1,2) + SUBSTR(TIME(),4,2)
                        SZY->ZY_TIPOSV	:= _cTpSv
                        SZY->ZY_OBS		:= _cObs
                        SZY->ZY_HISTPAD	:= 	_cHst
                        SZY->ZY_PESQUIS	:= "4" //NÃO AVALIADO

                        SZY->(MsUnLock())

                    EndIf

                Endif

            EndIf

        EndIf

    EndIf

    RestArea(_aArBI3)
    RestArea(_aArSZY)
    RestArea(_aArSZX)
    RestArea(_aArBa1)
    RestArea(_aArea	)

Return _lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function Env_1
description Rotina que irá disparar o e-mail da internação
@author  author Angelo Henrique
@since   date 15/09/2021
@version version
/*/
//-------------------------------------------------------------------
Static Function Env_1(c_ArqTxt, c_To, c_CC, c_Assunto, a_Msg, cProtoc, cBenef, cRDA )

    Local n_It 			:= 0
    Local l_Result    	:= .F.                   		// resultado de uma conexão ou envio
    Local nHdl        	:= fOpen(c_ArqTxt,68)
    Local c_Body      	:= space(99999)

    Private _cServer  	:= Trim(GetMV("MV_RELSERV")) 	// smtp.ig.com.br ou 200.181.100.51
    Private _cUser    	:= GetNewPar("MV_XMAILPA", "protocolodeatendimento@caberj.com.br")
    Private _cPass    	:= GetNewPar("MV_XPSWPA" , "Caberj2017@!")
    Private _cFrom    	:= "GRUPO CABERJ PROTHEUS"
    Private cMsg      	:= ""

    If !(nHdl == -1)

        nBtLidos := fRead(nHdl,@c_Body,99999)
        fClose(nHdl)

        For n_It:= 1 to Len( a_Msg )

            c_Body  := StrTran(c_Body, a_Msg[n_It][1] , a_Msg[n_It][2])

        Next

        // Tira quebras de linha para nao dar problema no WebMail da Caberj
        c_Body  := StrTran(c_Body,CHR(13)+CHR(10) , "")

        l_Result    := U_CabEmail(AllTrim(c_To), "", c_CC, c_Assunto, c_Body, {}, _cUser,, .F.,,,,{"03",cProtoc,cBenef,cRDA})[1]

        /*
        // Contecta o servidor de e-mail
        CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result

        If !l_Result

            GET MAIL ERROR _cError

            DISCONNECT SMTP SERVER RESULT lOk

        Else

            SEND MAIL FROM _cUser TO c_To BCC c_CC SUBJECT c_Assunto BODY c_Body  RESULT l_Result

            If !l_Result

                GET MAIL ERROR _cError

            Endif

        EndIf
        */

    Endif

Return l_Result
