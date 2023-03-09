#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} CABA097
description Rotina responsável por gerar um novo protocolo e enviar
SMS para o beneficiário no processo de INTERNAÇÃO
@author  Angelo Henrique
@since   date 13/09/2021
@version version
//-------------------------------------------------------------------
@Parametros
    _cParam = BE4_FILIAL+BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT
    _cStat  = Status da internação
    _cDsNeg = Descrição da Negativa
/*/
//-------------------------------------------------------------------
User Function CABA097(_cParam,_cStat,_cDsNeg)

    Local _aArea    := GetArea()
    Local _aArBE4   := BE4->(GetArea())
    Local _lRet     := .F.
    Local _cProt    := " "
    Local _lSms     := .F.
    Local _lMail    := .F.

    Default _cDsNeg := ""

    DbSelectArea("BE4")
    DbSetOrder(2)
    If DbSeek(_cParam)

        //-----------------------------------------------------
        //Somente Internação Eletiva
        //-----------------------------------------------------
        If BE4->BE4_TIPADM = "6"

            //-------------------------------------------------------------------
            //Validações para que o processo seja disparado
            //-------------------------------------------------------------------
            If BE4->BE4_YSOPME = "A" .and. BE4->BE4_YOPME == "1"

                _lRet  := .T.

            ElseIf BE4->BE4_YSOPME = "B" .and. BE4->BE4_YOPME == "0"

                _lRet  := .T.

            ElseIf BE4->BE4_YSOPME = "C"

                _lRet  := .T.

            EndIf

            If _lRet

                If !Empty(BE4->BE4_YNMSMS) .OR. !Empty(BE4->BE4_YMAIL)

                    //------------------------------------------------------------
                    //Gerar um novo protocolo que será enviado no SMS
                    //------------------------------------------------------------
                    _cProt := CABA097A()

                    If Empty(_cProt)

                        Aviso("Atenção","Problema na geração do novo protocolo de atendimento para envio do SMS, favor entrar em contato com TI.",{"OK"})

                    Else

                        //------------------------------------------------------------
                        //Envio do SMS
                        //------------------------------------------------------------
                        If !Empty(BE4->BE4_YNMSMS)

                            _lSms := CABA097B(_cProt,_cStat,_cDsNeg)

                            If !_lSms

                                Aviso("Atenção","Problema no envio de SMS para o beneficiário, favor entrar em contato com TI.",{"OK"})

                            EndIf

                        EndIf

                        //------------------------------------------------------------
                        //Envio do email
                        //------------------------------------------------------------
                        If !Empty(BE4->BE4_YMAIL)

                            _lMail := CABA097C(BE4->BE4_YMAIL,_cStat,_cProt,_lSms,_cDsNeg)

                            If !_lMail

                                Aviso("Atenção","Problema no envio de Email para o beneficiário, favor entrar em contato com TI.",{"OK"})

                            EndIf

                        EndIf

                        If _lSms .And. _lMail

                            Aviso("Atenção","Enviado para o beneficiário um e-mail para: " + BE4->BE4_YMAIL + " e um SMS. Nº: " + BE4->BE4_YNMSMS + ", contendo o protocolo: " + _cProt + " e informações sobre o status da internação.",{"OK"})

                        ElseIf _lSms .And. !_lMail

                            Aviso("Atenção","Enviado para o beneficiário um SMS. Nº: " + BE4->BE4_YNMSMS + ", contendo o protocolo: " + _cProt + " e informações sobre o status da internação.",{"OK"})

                        ElseIf !_lSms .And. _lMail

                            Aviso("Atenção","Enviado para o beneficiário um e-mail para: " + BE4->BE4_YMAIL + ", contendo o protocolo: " + _cProt + " e informações sobre o status da internação.",{"OK"})

                        EndIf

                    EndIf

                Else

                    Aviso("Atenção","Não será disparado SMS e nem E-mail para o beneficiário pois os campos não estão preenchidos.",{"OK"})

                EndIf

            EndIf

        EndIf

    EndIf

    RestArea(_aArBE4)
    RestArea(_aArea )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA097A
description Rotina utilizada para gerar o protocolo de atendimento
@author  author Angelo Henrique
@since   date 13/09/2021
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA097A()

    Local _nSla 	:= 0
    Local _cSeq		:= "" //Irá retornar o protocolo gerado
    Local _cCdAre	:= ""
    Local _cDsAre	:= ""
    Local _aArea 	:= GetArea()
    Local _aArZX 	:= SZX->(GetArea())
    Local _aArZY 	:= SZY->(GetArea())
    Local _aArB1 	:= BA1->(GetArea())
    Local _aArBI 	:= BI3->(GetArea())
    Local _aArCG 	:= PCG->(GetArea())
    Local _aArBL 	:= PBL->(GetArea())
    Local _cTpSv	:= IIF(BE4->BE4_TIPADM $ '4|5',"1016","1036") //BE4_TIPADM = 4 ou 5 (emergência ou urgência)
    Local _cHst 	:= "000015" //Entrada de Pedido
    Local _cTpDm	:= "T" //Solicitação (SX5) Tipo da Demanda
    Local _cChvBenf	:= BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG+BE4_DIGITO)
    Local _cCanal	:= ""

    _cSeq := U_GERNUMPA()

    DbSelectArea("SZX")
    DBSetOrder(1)
    _lAchou := DbSeek(xFilial("SZX") + AllTrim(_cSeq))

    RecLock("SZX",!_lAchou)

    SZX->ZX_FILIAL 	:= xFilial("SZX")
    SZX->ZX_SEQ 	:= _cSeq
    SZX->ZX_DATDE 	:= dDataBase
    SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")
    SZX->ZX_TPINTEL	:= "2" 		 //Status Encerrado
    SZX->ZX_USDIGIT	:= "SISTEMA" //Usuário Digitador
    SZX->ZX_PESQUIS := "4"       //Não Avaliado

    SZX->(MsUnLock())

    DbSelectArea("BA1")
    DbSetOrder(2)
    If DbSeek(xFilial("BA1") + _cChvBenf)

        //---------------------------------------------------------------------------
        //Validação do Canal a ser utilizado
        //Pois conforme informado pela Márcia deve ser seguido a regra abaixo
        //---------------------------------------------------------------------------
        If cEmpAnt == "01" //CABERJ

            /*
			||--------------------------------||
			||CODIGO| DESCRICAO				  ||
			||--------------------------------||
			||0001	| MATER PLENO             ||
			||0002	| MATER EXECUTIVO		  ||
			||0003	| MATER MAXIMUS           ||
			||0004	| MATER BASICO            ||
			||0006	| AFINIDADE I             ||
			||0007	| AFINIDADE PLENO         ||
			||0008	| AFINIDADE BASICO        ||
			||0063	| MATER EXECUTIVO I       ||
			||0064	| MATER BASICO I          ||
			||0065	| MATER PLENO I           ||
			||0070	| AFINIDADE EXECUTIVO     ||
			||--------------------------------||
            */
            If BA1->BA1_CODPLA $ "0001|0002|0003|0004|0006|0007|0008|0063|0064|0065|0070"

                _cCanal := "000004" //ura mater afinidade

            Else

                _cCanal := "000021" //ura integral multipatrocínio

            EndIf

        Else

            _cCanal := "000021" //ura integral multipatrocínio

        EndIf

        //------------------------------------------
        //Pegando a quantidade de SLA
        //------------------------------------------
        DbSelectArea("PCG")
        DbSetOrder(1)
        If DbSeek(xFilial("PCG") + PADR(AllTrim(_cTpDm),TAMSX3("PCG_CDDEMA")[1]) + "000006" + _cCanal + PADR(AllTrim(_cTpSv),TAMSX3("PCG_CDSERV")[1]) )

            _nSla := PCG->PCG_QTDSLA

        Else

            _nSla := 0

        EndIf

        //----------------------------------------------
        //Ponterar na Tabela de PBL (Tipo de Serviço)
        //Pegando assim a Area
        //----------------------------------------------
        DbSelectArea("PBL")
        DbSetOrder(1)
        If DbSeek(xFilial("PBL") + PADR(AllTrim(_cTpSv),TAMSX3("PBL_YCDSRV")[1]))

            _cCdAre := PBL->PBL_AREA
            _cDsAre := PBL->PBL_YDEPTO

        EndIf

        DbSelectArea("SZX")
        DbSetOrder(1)
        If DbSeek(xFilial("SZX") + _cSeq)

            If UPPER(Alltrim(SZX->ZX_USDIGIT)) == "SISTEMA"

                RecLock("SZX",.F.)

                SZX->ZX_FILIAL 	:= xFilial("SZX")
                SZX->ZX_DATDE 	:= dDataBase
                SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")
                SZX->ZX_DATATE 	:= dDataBase
                SZX->ZX_HORATE 	:= STRTRAN(TIME(),":","")
                SZX->ZX_NOMUSR 	:= BA1->BA1_NOMUSR
                SZX->ZX_CODINT 	:= BA1->BA1_CODINT
                SZX->ZX_CODEMP 	:= BA1->BA1_CODEMP
                SZX->ZX_MATRIC 	:= BA1->BA1_MATRIC
                SZX->ZX_TIPREG 	:= BA1->BA1_TIPREG
                SZX->ZX_DIGITO 	:= BA1->BA1_DIGITO
                SZX->ZX_TPINTEL	:= "2" 		//Status Encerrado
                SZX->ZX_YDTNASC	:= BA1->BA1_DATNAS
                SZX->ZX_EMAIL 	:= BA1->BA1_EMAIL
                SZX->ZX_CONTATO	:= ""
                SZX->ZX_YPLANO 	:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
                SZX->ZX_TPDEM	:= _cTpDm 	//Tipo de Demanda
                SZX->ZX_CANAL	:= _cCanal
                SZX->ZX_SLA  	:= _nSla	//SLA
                SZX->ZX_PTENT 	:= "000006" //Porta de Entrada = Telefone
                SZX->ZX_CODAREA := _cCdAre	//Codigo da Area
                SZX->ZX_YAGENC  := _cDsAre	//Descrição da Area
                SZX->ZX_VATEND	:= "3"    	//Seguindo o protocolo anterior (Novo PA não utiliza este campo)
                SZX->ZX_TPATEND := "1" 		//At. CABERJ
                SZX->ZX_USDIGIT	:= CUSERNAME//Usuário Digitador
                SZX->ZX_CPFUSR	:= BA1->BA1_CPFUSR
                SZX->ZX_PESQUIS := "4" //Não Avaliado
                SZX->ZX_YDTINC	:= dDataBase

                SZX->(MsUnLock())

                //-----------------------------------
                //Itens
                //-----------------------------------
                DbSelectArea("SZY")
                dbSetorder(1)
                _lAchou := DbSeek(xFilial("SZY") + AllTrim(_cSeq))

                RecLock("SZY",!_lAchou)

                SZY->ZY_FILIAL 	:= xFilial("SZY")
                SZY->ZY_SEQBA	:= _cSeq
                SZY->ZY_SEQSERV	:= "000001"
                SZY->ZY_DTSERV	:= dDataBase
                SZY->ZY_HORASV	:= STRTRAN(TIME(),":","")
                SZY->ZY_TIPOSV	:= _cTpSv
                SZY->ZY_RESPOST := "Protocolo gerado de forma automatica pelo sistema."
                SZY->ZY_HISTPAD	:= _cHst
                SZY->ZY_USDIGIT	:= CUSERNAME //Usuário Digitador
                SZY->ZY_PESQUIS := "4" //Não Avaliado

                SZY->(MsUnLock())

            EndIf

        EndIf

    EndIf

    RestArea(_aArBL)
    RestArea(_aArCG)
    RestArea(_aArZX)
    RestArea(_aArZY)
    RestArea(_aArB1)
    RestArea(_aArBI)
    RestArea(_aArea)

Return _cSeq

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA097B
description Rotina que irá disparar o SMS para o beneficiário
@author  author Angelo Henrique
@since   date 13/09/2021
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA097B(_cProt,_cStat,_cDsNeg)

    Local cQuery    := ""
    Local _lRet     := .T.
    Local _cTexto   := ""

    If cEmpAnt == "01"
        _cTexto := "CABERJ INFORMA, "
    Else
        _cTexto := "INTEGRAL INFORMA, "
    EndIf

    _cTexto += "N DE INTERNACAO " + BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)

    //-------------------------------------------------
    //Se for negado deve se pegar o motivo
    //-------------------------------------------------
    If _cStat = "C"

        _cTexto += " NEGADO, MOTIVO DA NEGATIVA: " + _cDsNeg

    Else
        _cTexto += " AUTORIZADA, VALIDADE " + DTOC(BE4->BE4_DATVAL)
    EndIf

    _cTexto += ", PROTOCOLO " + _cProt

    cQuery := "DECLARE  " + CRLF
    cQuery += "VS_RET VARCHAR2 (255);" + CRLF
    cQuery += "BEGIN " + CRLF
    cQuery += "SMS_ENVIO('" + BE4->BE4_YNMSMS + "', '" + _cTexto + "', VS_RET ); " + CRLF
    cQuery += "END;" + CRLF

    If TcSqlExec(cQuery) <> 0

        _lRet     := .F.
        Aviso("Atenção","Erro na execuçao do envio de extrato.",{"OK"})

    EndIf

Return _lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA097C()
description Rotina utilizada para enviar e-mail para o beneficiário
@author  author Angelo Henrique
@since   date 13/09/2021
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA097C(_cEmail,_cStat,_cProt,_lSms,_cDsNeg)

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
    Local c_CC		:= "protocolodeatendimento@caberj.com.br"
    Local c_Assunto := "Status do Pedido de Internação"
    Local a_Msg		:= {}
    Local _cCanDp	:= ""
    Local _lRet     := .F.
    Local _cObs     := ""
    Local _cText    := ""
    Local _cChvBE4  := BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)
    Local _cNfant   := ""

    If !Empty(_cProt)

        //Abrindo o protocolo de atendimento
        DbSelectArea("SZX")
        DbSetOrder(1)
        If DbSeek(xFilial("SZX") + _cProt)

            If cEmpAnt == "01"

                a_Htm := "\HTML\INTERNACABERJ.HTML"

            Else

                a_Htm := "\HTML\INTERNAINTEGRAL.HTML"

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


                If _cStat <> "C"

                    _cText := "Status Autorizado, Validade: " + DTOC(BE4->BE4_DATVAL)

                Else

                    _cText := "Status Negado, Motivo do indeferimento: " + _cDsNeg

                EndIf

                _cNfant := POSICIONE("BAU",1,XFILIAL("BAU")+BE4->BE4_CODRDA,"BAU_NFANTA")

                aAdd( a_Msg, { "_cBenef"	, SZX->ZX_NOMUSR		}) //Nome do Beneficiário
                aAdd( a_Msg, { "_cDtDe"		, DTOC(SZX->ZX_DATDE)   }) //Data de Abertura do Protocolo
                aAdd( a_Msg, { "_cHora"		, _cHora				}) //Hora de Abertura do Protocolo                                
                aAdd( a_Msg, { "_cProtoc"	, SZX->ZX_SEQ 			}) //Número do Protocolo
                aAdd( a_Msg, { "_cPlan"		, _cDscPln 				}) //Descrição do Plano do Beneficiário
                aAdd( a_Msg, { "_cMat"		, _cMat					}) //Matricula do Beneficiário
                aAdd( a_Msg, { "_cSolic"	, BE4->BE4_NOMSOL		}) //Medico solicitante
                aAdd( a_Msg, { "_cHosp"		, _cNfant       		}) //Hospital
                aAdd( a_Msg, { "_cChvBE4"	, _cChvBE4				}) //Chave da Internação
                aAdd( a_Msg, { "_cText"		, _cText			    }) //Motivo da negativa ou validade da autorização
                aAdd( a_Msg, { "_cSeq"		, SZX->ZX_SEQ		    }) //Protocolo
                aAdd( a_Msg, { "_cTpServ"	, _cTpSrv			    }) //Descrição do tipo de serviço

                //-----------------------------------------------------
                //Função para envio de e-mail
                //-----------------------------------------------------
                If Env_1(a_Htm, c_To, c_CC, c_Assunto, a_Msg, SZX->ZX_SEQ, SZX->(ZX_CODINT+ZX_CODEMP+ZX_MATRIC+ZX_TIPREG+ZX_DIGITO), SZX->ZX_RDA )

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

                            _cTpSv 	:= SZY->ZY_TIPOSV
                            _cHst	:= SZY->ZY_HISTPAD

                            SZY->(DbSkip())

                        EndDo

                        If !_lSms

                            _cObs := "E-mail enviado para: " + c_To

                        Else

                            _cObs := "E-mail enviado para: " + c_To + " e SMS para: " + BE4->BE4_YNMSMS

                        EndIf

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
        c_Body      := StrTran(c_Body,CHR(13)+CHR(10) , "")

        l_Result    := U_CabEmail(AllTrim(c_To), "", "", c_Assunto, c_Body, {}, _cUser,, .F.,,,,{"03",cProtoc,cBenef,cRDA})[1]

        /*
        // Contecta o servidor de e-mail
        CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result

        If !l_Result

            GET MAIL ERROR _cError

            DISCONNECT SMTP SERVER RESULT lOk

        Else

            SEND MAIL FROM _cUser TO c_To SUBJECT c_Assunto BODY c_Body  RESULT l_Result

            If !l_Result

                GET MAIL ERROR _cError

            Endif

        EndIf
        */

    Endif

Return l_Result
