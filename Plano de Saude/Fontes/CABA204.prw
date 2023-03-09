#INCLUDE "PLSTISS.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE 'FILEIO.CH'
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "RPTDEF.CH"

#DEFINE	cPicCNES PesqPict("BB8","BB8_CNES")
#DEFINE c_ent CHR(13) + CHR(10)

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA204
description Rotina para gerar PDF das guias selecionadas
@author  Angelo Henrique
@since   date 13/12/2021
@version version
/*/
//-------------------------------------------------------------------
User Function CABA204

    Local aGuias	:= {}
    local nCont    	:= 0
    Local aDados    := {}
    Local aArea 	:= GetArea()
    Local aAreaBA0 	:= BA0->(GetArea())
    Local aAreaBCL 	:= BCL->(GetArea())
    Local aAreaBA1 	:= BA1->(GetArea())
    Local aAreaBTS 	:= BTS->(GetArea())
    Local aAreaBAU 	:= BAU->(GetArea())
    Local aAreaBID 	:= BID->(GetArea())
    Local aAreaBD6 	:= BD6->(GetArea())
    Local aAreaBR8 	:= BR8->(GetArea())
    Local aAreaBB0 	:= BB0->(GetArea())
    Local aAreaBD7 	:= BD7->(GetArea())
    Local aAreaBWT 	:= BWT->(GetArea())
    Local cQuery	:= ""
    Local cAlias1   := GetNextAlias()
    Local c_Alias   := ""
    Local _aVet     := {}
    Local _ni       := 0
    //Local _cPerg    := "CABA204"

    //-----------------------------------------
    //Função para validação das perguntas
    //-----------------------------------------
    //CABA204A(_cPerg)

    //If Pergunte(_cPerg,.T.)

    //---------------------------------------------------------------
    //Função que armazena em vetor as guias colocadas
    //---------------------------------------------------------------
    _aVet := CABA204B()

    For _ni := 1 To Len(_aVet)

        cQuery := " SELECT											                " +c_ent
        cQuery += "     DISTINCT    	                                            " +c_ent
        cQuery += "     BD6.BD6_CODOPE,	                                            " +c_ent
        cQuery += "     BD6.BD6_CODLDP,	                                            " +c_ent
        cQuery += "     BD6.BD6_CODPEG,	                                            " +c_ent
        cQuery += "     BD6.BD6_NUMERO,	                                            " +c_ent
        cQuery += "     BCI.BCI_CODOPE, 	                                        " +c_ent
        cQuery += "     BCI.BCI_CODLDP, 	                                        " +c_ent
        cQuery += "     BCI.BCI_CODPEG, 	                                        " +c_ent
        cQuery += "     BCI.BCI_OPERDA, 	                                        " +c_ent
        cQuery += "     BCI.BCI_CODRDA,	                                            " +c_ent
        cQuery += "     BCI.BCI_TIPSER, 	                                        " +c_ent
        cQuery += "     BCI.BCI_TIPGUI, 	                                        " +c_ent
        cQuery += "     BCI.BCI_DATREC, 	                                        " +c_ent
        cQuery += "     BCI.BCI_DTDIGI,	                                            " +c_ent
        cQuery += "     BCI.BCI_STATUS, 	                                        " +c_ent
        cQuery += "     BCI.BCI_FASE, 	                                            " +c_ent
        cQuery += "     BCI.BCI_SITUAC, 	                                        " +c_ent
        cQuery += "     BCI.BCI_MES, 	                                            " +c_ent
        cQuery += "     BCI.BCI_ANO, 	                                            " +c_ent
        cQuery += "     BCI.BCI_TIPO,	                                            " +c_ent
        cQuery += "     BCI.BCI_TIPPRE, 	                                        " +c_ent
        cQuery += "     BCI.R_E_C_N_O_ ,	                                        " +c_ent
        cQuery += "     BCL.BCL_ALIAS,	                                            " +c_ent
        cQuery += "     BD6.BD6_CODEMP,	                                            " +c_ent
        cQuery += "     BD6.BD6_MATRIC,	                                            " +c_ent
        cQuery += "     BD6.BD6_TIPREG,	                                            " +c_ent
        cQuery += "     BD6.BD6_DIGITO	                                            " +c_ent
        cQuery += " FROM	                                                        " +c_ent
        cQuery += "     BD6020 BD6	                                                " +c_ent
        cQuery += "     	                                                        " +c_ent
        cQuery += "     INNER JOIN 	                                                " +c_ent
        cQuery += "         BCI020 BCI	                                            " +c_ent
        cQuery += "     ON	                                                        " +c_ent
        cQuery += "         BCI.BCI_FILIAL      = BD6.BD6_FILIAL	                " +c_ent
        cQuery += "         AND BCI.BCI_CODOPE  = BD6.BD6_CODOPE	                " +c_ent
        cQuery += "         AND BCI.BCI_CODLDP  = BD6.BD6_CODLDP	                " +c_ent
        cQuery += "         AND BCI.BCI_CODPEG  = BD6.BD6_CODPEG	                " +c_ent
        cQuery += "         AND BCI.D_E_L_E_T_  = BD6.D_E_L_E_T_	                " +c_ent
        cQuery += "                                                                 " +c_ent
        cQuery += "     INNER JOIN                                                  " +c_ent
        cQuery += "         BCL020 BCL                                              " +c_ent
        cQuery += "     ON                                                          " +c_ent
        cQuery += "         BCL.BCL_FILIAL      = ' '                               " +c_ent
        cQuery += "         AND BCL.BCL_CODOPE  = BCI.BCI_CODOPE                    " +c_ent
        cQuery += "         AND BCL.BCL_TIPGUI  = BCI.BCI_TIPGUI                    " +c_ent
        cQuery += "         AND BCL.BCL_ALIAS   IN ('BD5','BE4')                    " +c_ent
        cQuery += "         AND BCL.D_E_L_E_T_  = BCI.D_E_L_E_T_                    " +c_ent
        cQuery += "                                                                 " +c_ent
        cQuery += " WHERE                                                           " +c_ent
        cQuery += "     BD6.BD6_FILIAL      = ' '                                   " +c_ent
        cQuery += "     AND BD6.BD6_CODLDP  = '" + SUBSTR(_aVet[_ni][1],1 ,4) + "'  " +c_ent
        cQuery += "     AND BD6.BD6_CODPEG  = '" + SUBSTR(_aVet[_ni][1],5 ,8) + "'  " +c_ent
        cQuery += "     AND BD6.BD6_NUMERO  = '" + SUBSTR(_aVet[_ni][1],13,8) + "'  " +c_ent
        cQuery += "     AND BD6.D_E_L_E_T_  = ' '                                   " +c_ent

        If Select(cAlias1) > 0
            (cAlias1)->(DbCloseArea())
        EndIf

        DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias1,.T.,.T.)

        (cAlias1)->(DbGoTop())

        Do While !(cAlias1)->(Eof())

            aGuias	:= {}
            aDados  := {}

            nCont++
            BCL->(DbSetOrder(1))
            BCL->(DbSeek(xFilial('BCL') + (cAlias1)->(BCI_CODOPE + BCI_TIPGUI)))

            If BCL->(EOF()) .or. !( BCL->BCL_ALIAS $ 'BD5|BE4' )
                MsgStop('Alias nao implementado!',AllTrim(SM0->M0_NOMECOM))
                Return
            Else
                c_Alias := BCL->BCL_ALIAS
            EndIf

            BA0->(DbSetOrder(1))
            BA0->(DbSeek(xFilial('BA0') + (cAlias1)->BD6_CODOPE))

            BA1->(DbSetOrder(2))
            BA1->(DbSeek(xFilial('BA1') + (cAlias1)->(BD6_CODOPE + BD6_CODEMP + BD6_MATRIC +BD6_TIPREG + BD6_DIGITO)))

            BTS->(DbSetOrder(1))
            BTS->(DbSeek(xFilial('BTS') + BA1->BA1_MATVID ))

            BAU->(DbSetOrder(1))
            BAU->(DbSeek(xFilial('BAU') + (cAlias1)->BCI_CODRDA))

            BD6->(DbSetOrder(1))
            BD6->(DbSeek(xFilial('BD6') + (cAlias1)->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)))

            Do Case

                Case (cAlias1)->BCI_TIPGUI == '01' //Consulta

                    BD5->(DbSetOrder(1))
                    BD5->(DbSeek(xFilial('BD5') + (cAlias1)->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)))

                    aDados 	:= Array(40)

                    aDados[1]  := BA0->BA0_SUSEP //Registro ANS
                    aDados[2]  := Left(BD5->BD5_NUMIMP,20) //Num guia
                    aDados[3]  := BD5->BD5_DATPRO //Emissao guia (Solicitado Srgio)
                    aDados[4]  := BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) //Carteira
                    aDados[5]  := Left(Posicione('BI3',1,xFilial('BI3') + BA1->(BA1_CODINT + BA1_CODPLA),'BI3_NREDUZ'),40)//Plano
                    aDados[6]  := BA1->BA1_DTVLCR //Validade carteira
                    aDados[7]  := Left(BA1->BA1_NOMUSR,70) //Nome
                    aDados[8]  := BTS->BTS_NRCRNA //CNS
                    aDados[9]  := BAU->BAU_CPFCGC //CNPJ na Operadora
                    aDados[10] := Left(BAU->BAU_NOME,70) //Nome contratado
                    aDados[11] := BAU->BAU_CNES //CNES
                    aDados[12] := BAU->BAU_TIPLOG //Tipo de logradouro
                    aDados[13] := Left(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),40) //Logr. - Endereo - Compl
                    aDados[14] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),41,5) //Logr. - Endereo - Compl
                    aDados[15] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),46,15) //Logr. - Endereo - Compl
                    aDados[16] := Left(Posicione('BID',1,xFilial('BID') + BAU->BAU_MUN,'BID_DESCRI'),40) //Municipio
                    aDados[17] := BAU->BAU_EST //UF
                    aDados[18] := BAU->BAU_MUN //Codigo IBGE
                    aDados[19] := BAU->BAU_CEP //CEP
                    aDados[20] := Posicione("BB0",4,xFilial("BB0") + BD5->(BD5_ESTEXE + BD5_REGEXE + BD5_SIGEXE),"BB0_NOME") //Nome executante
                    aDados[21] := BD5->BD5_SIGEXE //Conselho executante
                    aDados[22] := BD5->BD5_REGEXE
                    aDados[23] := BD5->BD5_ESTEXE //UF Executante
                    aDados[24] := BD5->BD5_CBOS //CBOS
                    aDados[25] := BD5->BD5_TIPDOE //Tipo de doeN?a
                    aDados[26] := { BD5->BD5_TPODOE,BD5->BD5_UTPDOE } //Tempo de doeN?a
                    aDados[27] := If(BD5->BD5_INDACI $ '0|1|2', BD5->BD5_INDACI, '2') //Indicao acidente
                    aDados[28] := BD5->BD5_CID //CID
                    aDados[29] := BD5->BD5_CIDSEC //CID2
                    aDados[30] := BD5->BD5_CID3 //CID3
                    aDados[31] := BD5->BD5_CID4 //CID4
                    aDados[32] := BD5->BD5_DATPRO //Data do atendimento
                    aDados[33] := BD6->BD6_CODPAD //C?digo tabela
                    aDados[34] := BD6->BD6_CODPRO //C?digo procedimento
                    aDados[35] := BD5->BD5_TIPCON //Tipo de consulta
                    aDados[36] := BD5->BD5_TIPSAI //Tipo de Sa?da
                    aDados[37] := 'Guia: ' + BD5->(BD5_CODLDP + '.' + BD5_CODPEG + '.' + BD5_NUMERO) + ' - Impresso em: ' + DtoC(Date()) + ' [ ' + Time() + ' ]'//Observao
                    aDados[38] := BD5->BD5_DATPRO //Data profissional
                    aDados[39] := BD5->BD5_DATPRO //Data Benefici?rio
                    aDados[40] := BD5->(BD5_CODLDP + BD5_CODPEG + BD5_NUMERO)

                    aAdd(aGuias, aDados)

                    R234CON(aGuias, .T., 2)

                Case (cAlias1)->BCI_TIPGUI == '02' //SADT

                    BD5->(DbSetOrder(1))
                    BD5->(DbSeek(xFilial('BD5') + (cAlias1)->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)))

                    aDados 	:= Array(90)

                    aDados[1]  := BA0->BA0_SUSEP //Registro ANS
                    aDados[2]  := Left(BD5->BD5_NUMIMP,20) //Numero
                    aDados[3]  := Left(BD5->BD5_NUMIMP,20) //"12345678901234567892" //Num guia principal
                    aDados[4]  := BD5->BD5_DATPRO //CtoD("01/01/07"),;//Data da autorizacao
                    aDados[5]  := If(!empty(BD5->BD5_VALSEN),BD5->BD5_SENHA,'') //"12345678901234567892",;//Senha
                    aDados[6]  := BD5->BD5_VALSEN //CtoD("01/01/07"),;//Data validade da senha
                    aDados[7]  := BD5->BD5_DATPRO //Data emissao guia (Solicitado Srgio)
                    aDados[8]  := BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) //"12345678901234567892",;//Numero da carteira
                    aDados[9]  := Left(Posicione('BI3',1,xFilial('BI3') + BA1->(BA1_CODINT + BA1_CODPLA),'BI3_NREDUZ'),20) //Replicate("M",20),;//Plano
                    aDados[10] := BA1->BA1_DTVLCR //Validade da carteira
                    aDados[11] := Left(BA1->BA1_NOMUSR,70) //Replicate("M",70),;//Nome
                    aDados[12] := BTS->BTS_NRCRNA //"123456789102345",;//Numero CNS
                    aDados[13] := BAU->BAU_CPFCGC //"14.141.114/00001-35",;//CNPJ na Operadora
                    aDados[14] := Left(BAU->BAU_NOME,70) //Replicate("M",70),;//Nome contratado
                    aDados[15] := BAU->BAU_CNES //"1234567",;//CNES
                    aDados[16] := Left(BD5->BD5_NOMSOL,70) //Replicate("M",70),;//Nome profissional solicitante
                    aDados[17] := BD5->BD5_SIGLA //"1234567",;//Conselho solicitante
                    aDados[18] := BD5->BD5_REGSOL //"123456789102345",;//Numero solicitante
                    aDados[19] := BD5->BD5_ESTSOL //"ES",;//UF solicitante
                    aDados[20] := BD5->BD5_CBOS //"12345",;//CBOS Solicitante
                    aDados[21] := { BD5->BD5_DATPRO, BD5->BD5_HORPRO } //Data hora solicitacao
                    aDados[22] := If(BD5->BD5_TIPATO == '4','U','E') //"E",;//Carater solicitacao
                    aDados[23] := BD5->BD5_CID //"12345",;//CID 10
                    aDados[24] := Left(BD5->BD5_INDCLI,70) //Replicate("M",70),;//Indicacao clinica

                    cChvGuia   := BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)

                    aDados[25] := {} //Tabela
                    aDados[26] := {} //Procedimento
                    aDados[27] := {} //Descricao
                    aDados[28] := {} //Qtd solicitada
                    aDados[29] := {} //Qtd autorizada

                    //Realizados
                    aDados[51] := {} //Data
                    aDados[52] := {} // Hora inicial
                    aDados[53] := {} //Hora final
                    aDados[54] := {} //Tabela
                    aDados[55] := {} //Codigo procedimento
                    aDados[56] := {} //Descri??o
                    aDados[57] := {} //Quantidade
                    aDados[58] := {} //Via
                    aDados[59] := {} //Tecnica
                    aDados[60] := {} //%Red acrescimo
                    aDados[61] := {} //Valor unitrio
                    aDados[62] := {} //Valor total

                    aDados[63] := {} //Data procedimentos em srie

                    //OPME Solicitados
                    aDados[72] := {} //Tabela
                    aDados[73] := {} //Cod do OPM
                    aDados[74] := {} //Descr. OPM
                    aDados[75] := {} //Qtde
                    aDados[76] := {} //Fabricante
                    aDados[77] := {} //Valor unitrio

                    //OPME utilizados
                    aDados[78] := {} //Tabela
                    aDados[79] := {} //Cod do OPM
                    aDados[80] := {} //Descr. OPM
                    aDados[81] := {} //Qtde
                    aDados[82] := {} //Fabricante
                    aDados[83] := {} //Valor unitrio
                    aDados[84] := {} //Valor total

                    nTotOPME 		:= 0
                    nProcedimento 	:= 0 //1
                    nMaterial 		:= 0 //2
                    nMedicamento 	:= 0 //3
                    nTaxas 			:= 0 //4
                    nDiarias 		:= 0 //6
                    nPacote 		:= 0 //7
                    nGasesMed 		:= 0 //8
                    nAlugueis 		:= 0 //9

                    While !BD6->(EOF()) .and. ( cChvGuia == BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) )

                        cTpProc := Posicione('BR8',1,xFilial('BR8') + BD6->(BD6_CODPAD + BD6_CODPRO),'BR8_TPPROC')

                        If ( BD6->BD6_CODLDP == '0013' ) .or. ( cTpProc == '5' ) //5 - Ortese/Protese

                            //OPME Solicitados
                            aAdd(aDados[72], BD6->BD6_CODPAD) //Tabela
                            aAdd(aDados[73], BD6->BD6_CODPRO) //Cod do OPM
                            aAdd(aDados[74], BD6->BD6_DESPRO) //Descr. OPM
                            //aAdd(aDados[75], BD6->BD6_QTDAPR) //Qtde
                            aAdd(aDados[75], BD6->BD6_QTDPRO) //Qtde
                            aAdd(aDados[76], "") //Fabricante
                            aAdd(aDados[77], Round(BD6->BD6_VLRAPR / BD6->BD6_QTDPRO,2)) //Valor unitrio

                            //OPME utilizados
                            aAdd(aDados[78], BD6->BD6_CODPAD) //Tabela
                            aAdd(aDados[79], BD6->BD6_CODPRO) //Cod do OPM
                            aAdd(aDados[80], BD6->BD6_DESPRO) //Descr. OPM
                            //aAdd(aDados[81], BD6->BD6_QTDAPR) //Qtde
                            aAdd(aDados[81], BD6->BD6_QTDPRO) //Qtde
                            aAdd(aDados[82], "") //Fabricante
                            aAdd(aDados[83], Round(BD6->BD6_VLRAPR / BD6->BD6_QTDPRO,2)) //Valor unitrio
                            aAdd(aDados[84], BD6->BD6_VLRAPR) //Valor total

                            nTotOPME += BD6->BD6_VLRAPR

                        Else

                            aAdd(aDados[25], BD6->BD6_CODPAD)
                            aAdd(aDados[26], BD6->BD6_CODPRO)
                            aAdd(aDados[27], BD6->BD6_DESPRO)
                            //aAdd(aDados[28], BD6->BD6_QTDAPR)  //DESCONTINUADO P12
                            aAdd(aDados[28], BD6->BD6_QTDPRO)    //ACRESCENTADO REPETIDO PARA NAO ARRISCAR DAR ERRO DE ARRAY
                            aAdd(aDados[29], BD6->BD6_QTDPRO)

                            aAdd(aDados[51], BD6->BD6_DATPRO) //Data
                            aAdd(aDados[52], BD6->BD6_HORPRO) //Hora inicial
                            aAdd(aDados[53], BD6->BD6_HORPRO) //Hora final
                            aAdd(aDados[54], BD6->BD6_CODPAD) //Tabela
                            aAdd(aDados[55], BD6->BD6_CODPRO) //Codigo procedimento
                            aAdd(aDados[56], Left(BD6->BD6_DESPRO, 60)) //Descri??o
                            aAdd(aDados[57], BD6->BD6_QTDPRO) //Quantidade
                            aAdd(aDados[58], BD6->BD6_VIA) //Via
                            aAdd(aDados[59], "") //Tecnica
                            aAdd(aDados[60], BD6->BD6_PERVIA) //%Red acrescimo
                            aAdd(aDados[61], Round(BD6->BD6_VLRAPR / BD6->BD6_QTDPRO,2)) //Valor unitrio
                            aAdd(aDados[62], BD6->BD6_VLRAPR) //Valor total

                            aAdd(aDados[63], CtoD("//")) //Data procedimentos em srie

                            Do Case

                                Case cTpProc $ '1|7'
                                    nProcedimento 	+= BD6->BD6_VLRAPR

                                Case cTpProc == '2'
                                    nMaterial 		+= BD6->BD6_VLRAPR

                                Case cTpProc == '3'
                                    nMedicamento 	+= BD6->BD6_VLRAPR

                                Case cTpProc == '4'
                                    nTaxas 			+= BD6->BD6_VLRAPR

                                Case cTpProc == '6'
                                    nDiarias 		+= BD6->BD6_VLRAPR

                                Case cTpProc == '8'
                                    nGasesMed 		+= BD6->BD6_VLRAPR

                                Case cTpProc == '9'
                                    nAlugueis 		+= BD6->BD6_VLRAPR

                                Otherwise
                                    nProcedimento 	+= BD6->BD6_VLRAPR

                            EndCase

                        EndIf

                        BD6->(DbSkip())

                    EndDo

                    //Totais da guia
                    aDados[65] := {nProcedimento}
                    aDados[66] := {nTaxas + nAlugueis}
                    aDados[67] := {nMaterial}
                    aDados[68] := {nMedicamento}
                    aDados[69] := {nDiarias}
                    aDados[70] := {nGasesMed}
                    aDados[71] := {nProcedimento + nTaxas + nAlugueis + nMaterial + nMedicamento + nDiarias + nGasesMed}

                    aDados[85] := {nTotOPME} //Total OPME

                    aDados[30] := BAU->BAU_CPFCGC //"14.141.114/00001-35",;//CNPJ na operadora
                    aDados[31] := Left(BAU->BAU_NOME,70) //Nome contratado
                    aDados[32] := BAU->BAU_TIPLOG //Tipo de logradouro
                    aDados[33] := Left(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),40) //Logr. - Endereo - Compl
                    aDados[34] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),41,5) //Logr. - Endereo - Compl
                    aDados[35] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),46,15) //Logr. - Endereo - Compl
                    aDados[36] := Left(Posicione('BID',1,xFilial('BID') + BAU->BAU_MUN,'BID_DESCRI'),40) //Municipio
                    aDados[37] := BAU->BAU_EST //UF
                    aDados[38] := BAU->BAU_MUN //Codigo IBGE
                    aDados[39] := BAU->BAU_CEP //CEP
                    aDados[40] := { "", "" } //Exec complementar
                    aDados[41] := "" //Replicate("M",70),; //Nome Exec complementar
                    aDados[42] := "" //"1234567",; //Conselho Exec complementar
                    aDados[43] := "" //"123456789102345",;//Numero Exec complementar
                    aDados[44] := "" //"MM",;//UF Exec complementar
                    aDados[45] := { "", "" }//CBOS e grau part Exec complementar
                    aDados[46] := BD5->BD5_TIPATE //"01",;//Tipo atendimento
                    aDados[47] := BD5->BD5_INDACI //"1",;//Tipo de acidente
                    aDados[48] := BD5->BD5_TIPSAI //Tipo de Sa?da
                    aDados[49] := BD5->BD5_TIPDOE //Tipo de doeN?a
                    aDados[50] := { BD5->BD5_TPODOE,BD5->BD5_UTPDOE } //Tempo de doeN?a

                    aDados[64] := 'Guia: ' + BD5->(BD5_CODLDP + '.' + BD5_CODPEG + '.' + BD5_NUMERO) + ' - Impresso em: ' + DtoC(Date()) + ' [ ' + Time() + ' ]'//Observao

                    aDados[86] := BD5->BD5_DATPRO //Data assinatura solicitante
                    aDados[87] := BD5->BD5_DATPRO //Data assinatura resp aut
                    aDados[88] := BD5->BD5_DATPRO //Data assinatura benef
                    aDados[89] := BD5->BD5_DATPRO //Data assinatura prestador exec
                    aDados[90] := BD5->(BD5_CODLDP + BD5_CODPEG + BD5_NUMERO)

                    aAdd(aGuias, aDados)

                    R234SADT(aGuias, .T., 2)

                Case (cAlias1)->BCI_TIPGUI == '05' //GRI

                    BE4->(DbSetOrder(1)) //BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_SITUAC+BE4_FASE
                    BE4->(DbSeek(xFilial('BE4') + (cAlias1)->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)))

                    aDados 	:= Array(84)

                    aDados[1]  := BA0->BA0_SUSEP //Registro ANS//"123456"
                    aDados[2]  := Left(BE4->BE4_NUMIMP,20) //Numero//"12345678901234567892"
                    aDados[3]  := Left(BE4->BE4_NUMIMP,20) //"12345678901234567892" //Num guia solicitacao//"12345678901234567892"
                    aDados[4]  := BE4->BE4_DATPRO //CtoD("01/01/07"),;//Data da autorizacao
                    aDados[5]  := BE4->BE4_SENHA //"12345678901234567892",;//Senha
                    aDados[6]  := BE4->BE4_DATVAL //CtoD("01/01/07"),;//Data validade da senha
                    aDados[7]  := BE4->BE4_DATPRO //Data emissao guia (Solicitado Srgio)
                    aDados[8]  := BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) //"12345678901234567892",;//Numero da carteira
                    aDados[9]  := Left(Posicione('BI3',1,xFilial('BI3') + BA1->(BA1_CODINT + BA1_CODPLA),'BI3_NREDUZ'),40) //Replicate("M",40),;//Plano
                    aDados[10] := BA1->BA1_DTVLCR //Validade da carteira
                    aDados[11] := Left(BA1->BA1_NOMUSR,70) //Replicate("M",70),;//Nome
                    aDados[12] := BTS->BTS_NRCRNA //"123456789102345",;//Numero CNS
                    aDados[13] := BAU->BAU_CPFCGC //"14.141.114/00001-35",;//CNPJ na Operadora
                    aDados[14] := Left(BAU->BAU_NOME,70) //Replicate("M",70),;//Nome contratado
                    aDados[15] := BAU->BAU_CNES //"1234567",;//CNES
                    aDados[16] := BAU->BAU_TIPLOG //Tipo de logradouro
                    aDados[17] := Left(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),40) //Logr. - Endereo - Compl
                    aDados[18] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),41,5) //Logr. - Endereo - Compl
                    aDados[19] := Substr(AllTrim(BAU->BAU_END) + AllTrim(BAU->BAU_YCPEND) + AllTrim(BAU->BAU_BAIRRO),46,15) //Logr. - Endereo - Compl
                    aDados[20] := Left(Posicione('BID',1,xFilial('BID') + BAU->BAU_MUN,'BID_DESCRI'),40) //Municipio
                    aDados[21] := BAU->BAU_EST //UF
                    aDados[22] := BAU->BAU_MUN //Codigo IBGE
                    aDados[23] := BAU->BAU_CEP //CEP
                    aDados[24] := If(BE4->BE4_TIPCON $ '2|6','U','E')//"E"--1=Normal;2=Emergencia;3=Reconsulta;4=Pre-Natal;5=Referencia;6=Urgencia
                    aDados[25] := { 'Acomoda??o ',If(BE4->BE4_PADINT == '1',' Individual',' Coletivo')} //Tipo acomodacao
                    aDados[26] := {BE4->BE4_DATPRO,BE4->BE4_HORPRO } //Data hora internacao
                    aDados[27] := {BE4->BE4_DTALTA,BE4->BE4_HRALTA } //Data hora saida internacao
                    aDados[28] := BE4->BE4_GRPINT//Tipo internacao--1=Internacao Clinica;2=Internacao Cirurgica;3=Internacao Obstetrica;4=Internacao Pediatrica;5=Internacao Psiquiatrica
                    aDados[29] := BE4->BE4_REGINT//Regime internacao--1=Hospitalar;2=Hospital-Dia;3=Domiciliar

                    aDados[30] := {;
                        If(BE4->BE4_EMGEST == '1','X',''),;//Em gestacao
                        If(BE4->BE4_ABORTO == '1',"X",''),;//Aborto
                        If(BE4->BE4_TRAGRA == '1',"X",''),;//Transtorno materno na gravidez
                        If(BE4->BE4_COMURP == '1',"X",''),;//Complicacao no puerperio
                        If(BE4->BE4_ATESPA == '1',"X",''),;//Atendimento recem nascido na sala do parto
                        If(BE4->BE4_COMNAL == '1',"X",''),;//Complicacao pre-natal
                        If(BE4->BE4_BAIPES == '1',"X",''),;//Baixo peso < 2.5 kg
                        If(BE4->BE4_PARCES == '1',"X",''),;//Parto cesareo
                        If(BE4->BE4_PATNOR == '1',"X",'') ;//Parto normal
                        }

                    aDados[31] := BE4->BE4_OBTMUL//Obito mulher - 1=Gravida;2=ate 42 dias apos termino gestacao;3=de 43 dias a 12 meses apos gestacao

                    aDados[32] := {;
                        BE4->BE4_OBTPRE,;//Obito neonatal precoce
                        BE4->BE4_OBTTAR ;//Obito neonatal tardio
                        }

                    aDados[33] := BE4->BE4_NRDCNV//Declarao nascido vivo
                    aDados[34] := BE4->BE4_NASVIV//Qtd nascido vivo
                    aDados[35] := BE4->BE4_NASMOR//Qtd nascido morto
                    aDados[36] := BE4->BE4_NASVPR//Qtd nascido prematuro
                    aDados[37] := BE4->BE4_CID//CID
                    aDados[38] := BE4->BE4_CIDSEC//CID2
                    aDados[39] := BE4->BE4_CID3//CID3
                    aDados[40] := BE4->BE4_CID4//CID4
                    aDados[41] := If(BE4->BE4_INDACI == '9','2',BE4->BE4_INDACI)//Indicao acidente - 0=Relacionado ao trabalho;1=Acidente de Transito;2=Outros Acidente;9=Nao Acidente
                    aDados[42] := Posicione('BIY',1,xFilial('BIY') + BE4->(BE4_CODOPE + BE4_TIPALT),'BIY_DESCRI')//Tipo saida
                    aDados[43] := BE4->BE4_CIDOBT//CID Obito
                    aDados[44] := BE4->BE4_NRDCOB//Numero declaracao obito

                    cChvGuia   := BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)

                    aDados[45] := {}
                    aDados[46] := {}
                    aDados[47] := {}
                    aDados[48] := {}
                    aDados[49] := {}
                    aDados[50] := {}
                    aDados[51] := {}
                    aDados[52] := {}
                    aDados[53] := {}
                    aDados[54] := {}
                    aDados[55] := {}
                    aDados[56] := {}

                    //OPME
                    aDados[65] := {}
                    aDados[66] := {}
                    aDados[67] := {}
                    aDados[68] := {}
                    aDados[69] := {}
                    aDados[70] := {}
                    aDados[71] := {}
                    aDados[72] := 0

                    nTotOPME 		:= 0
                    nProcedimento 	:= 0 //1
                    nMaterial 		:= 0 //2
                    nMedicamento 	:= 0 //3
                    nTaxas 			:= 0 //4
                    nDiarias 		:= 0 //6
                    nPacote 		:= 0 //7
                    nGasesMed 		:= 0 //8
                    nAlugueis 		:= 0 //9

                    While !BD6->(EOF()) .and. ( cChvGuia == BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) )

                        cTpProc := Posicione('BR8',1,xFilial('BR8') + BD6->(BD6_CODPAD + BD6_CODPRO),'BR8_TPPROC')

                        If ( BD6->BD6_CODLDP == '0013' ) .or. ( cTpProc == '5' ) //5 - Ortese/Protese

                            //OPME utilizados
                            aAdd(aDados[65], BD6->BD6_CODPAD) //Tabela
                            aAdd(aDados[66], BD6->BD6_CODPRO) //Cod do OPM
                            aAdd(aDados[67], BD6->BD6_DESPRO) //Descr. OPM
                            //aAdd(aDados[68], BD6->BD6_QTDAPR) //Qtde
                            aAdd(aDados[68], BD6->BD6_QTDPRO) //Qtde
                            aAdd(aDados[69], "") //Codigo barras
                            aAdd(aDados[70], Round(BD6->BD6_VLRAPR ,2)) //Valor unitrio
                            aAdd(aDados[71], Round(BD6->BD6_VLRAPR * BD6->BD6_QTDPRO,2) ) //Valor total

                            nTotOPME += BD6->BD6_VLRAPR

                        Else

                            aAdd(aDados[45], BD6->BD6_DATPRO) //Data
                            aAdd(aDados[46], BD6->BD6_HORPRO) //Hora inicial
                            aAdd(aDados[47], BD6->BD6_HORPRO) //Hora final
                            aAdd(aDados[48], BD6->BD6_CODPAD) //Tabela
                            aAdd(aDados[49], BD6->BD6_CODPRO) //Codigo procedimento
                            aAdd(aDados[50], Left(BD6->BD6_DESPRO, 60)) //Descri??o
                            aAdd(aDados[51], BD6->BD6_QTDPRO) //Quantidade
                            aAdd(aDados[52], BD6->BD6_VIA) //Via
                            aAdd(aDados[53], "") //Tecnica
                            aAdd(aDados[54], BD6->BD6_PERVIA) //%Red acrescimo
                            aAdd(aDados[55], Round(BD6->BD6_VLRAPR ,2)) //Valor unitrio
                            aAdd(aDados[56], Round(BD6->BD6_VLRAPR * BD6->BD6_QTDPRO,2) /* BD6->BD6_VLRAPR*/) //Valor total

                            Do Case

                                Case cTpProc $ '1|7'
                                    nProcedimento 	+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

                                Case cTpProc == '2'
                                    nMaterial 		+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

                                Case cTpProc == '3'
                                    nMedicamento 	+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

                                Case cTpProc == '4'
                                    nTaxas 			+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

                                Case cTpProc == '6'
                                    nDiarias 		+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

                                Case cTpProc == '8'
                                    nGasesMed 		+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

                                Case cTpProc == '9'
                                    nAlugueis 		+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

                                Otherwise
                                    nProcedimento 	+= BD6->BD6_VLRAPR * BD6->BD6_QTDPRO

                            EndCase

                        EndIf

                        BD6->(DbSkip())

                    EndDo

                    //Equipe
                    aDados[57] := { Posicione('BD7',1,xFilial('BD7') + BE4->(BE4_CODOPE + BE4_CODLDP + BE4_CODPEG + BE4_NUMERO + BE4_ORIMOV),'BD7_SEQUEN') }//Seq ref
                    aDados[58] := { If(empty(BE4->BE4_CDPFRE),' ',Posicione('BWT',1,xFilial('BWT') + BD7->(BD7_CODOPE + BD7_CODTPA),'BWT_CODEDI')) }//Grau participacao
                    aDados[59] := { BE4->BE4_CDPFRE }//Codigo na operadora/CPF
                    aDados[60] := { BE4->BE4_NOMEXE }//Nome profissional
                    aDados[61] := { Posicione('BB0',1,xFilial('BB0') + BE4->BE4_CDPFRE,'BB0_CODSIG') }//Conselho profissional
                    aDados[62] := { BE4->BE4_REGEXE }//Numero conselho
                    aDados[63] := { BE4->BE4_ESTEXE }//UF
                    aDados[64] := { Posicione('BB0',1,xFilial('BB0') + BE4->BE4_CDPFRE,'BB0_CGC') }//CPF

                    aDados[72] := nTotOPME

                    aDados[73] := { ;
                        If(BE4->BE4_TIPFAT = 'T',"X",' '),; //Total
                        If(BE4->BE4_TIPFAT = 'P',"X",' ') ; //Parcial
                        }//Tipo faturamento

                    aDados[74] := nProcedimento//Total procedimentos
                    aDados[75] := nDiarias//Total diarias
                    aDados[76] := nTaxas + nAlugueis//Total taxas + alugueis
                    aDados[77] := nMaterial//Total materiais
                    aDados[78] := nMedicamento//Total medicamentos
                    aDados[79] := nGasesMed//Total gases medicinais
                    aDados[80] := nProcedimento + nDiarias + nTaxas + nAlugueis + nMaterial + nMedicamento + nGasesMed//Total geral

                    aDados[81] := 'Guia: ' + BE4->(BE4_CODLDP + '.' + BE4_CODPEG + '.' + BE4_NUMERO) + ' - Impresso em: ' + DtoC(Date()) + ' [ ' + Time() + ' ]'//Observao

                    aDados[82] := BE4->BE4_DATPRO//Data assinatura contratado
                    aDados[83] := BE4->BE4_DATPRO//Data assinatura auditores operadora
                    aDados[84] := BE4->(BE4_CODLDP + BE4_CODPEG + BE4_NUMERO)

                    aAdd(aGuias, aDados)

                    R234RINT(aGuias, .T., 2)

                Case (cAlias1)->BCI_TIPGUI == '06' //Honorarios individual

                    BD5->(DbSetOrder(1))
                    BD5->(DbSeek(xFilial('BD5') + (cAlias1)->(BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)))

                    aDados := {}

                    // Cabecalho
                    aAdd(aDados, BA0->BA0_SUSEP) //1 Registro ANS
                    aAdd(aDados, Left(BD5->BD5_NUMIMP,20) ) //2 - Numero
                    aAdd(aDados, BD5->BD5_GUIINT ) //3 Nr Guia Solicitacao
                    aAdd(aDados, If(!empty(BD5->BD5_VALSEN),BD5->BD5_SENHA,'') )  //4 Senha
                    aAdd(aDados, BD5->BD5_CODOPE+BD5->BD5_CODLDP+BD5->BD5_CODPEG+BD5->BD5_NUMERO  )  //5

                    // Dados do Beneficiario
                    aAdd(aDados, BA1->( BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO ) )//"12345678901234567892",;//Numero da carteira) //6
                    aAdd(aDados, Left(BA1->BA1_NOMUSR,70)	)//7  Nome Benefici?rio
                    aAdd(aDados, 'N'						) //8 - Atendimento a RN

                    //**********************************************
                    //    Posiciona Rede de Atendimento            *
                    //**********************************************
                    BAU->(dbSetOrder(1))
                    BAU->(dbSeek(xFilial("BAU")+BD5->BD5_CODRDA))

                    // Dados do Contratado (onde foi executado o procedimento)
                    aAdd(aDados, BD5->BD5_CODRDA	   ) //9  - C?digo da Operadora
                    aAdd(aDados, Left(BAU->BAU_NOME,70)) //10 - Nome do Hospital
                    aAdd(aDados, Transform(BTS->BTS_NRCRNA, cPicCNES) 	   ) //11 - C?digo CNES

                    // Dados do Contratado Executante
                    aAdd(aDados, IIf(Len(AllTrim(BAU->BAU_CPFCGC)) == 11, Transform(BAU->BAU_CPFCGC, "@R 999.999.999-99"), Transform(BAU->BAU_CPFCGC, "@R 99.999.999/9999-99"))) // 12 - C?digo na operadora CPF/CNPJ
                    aAdd(aDados, Left(BAU->BAU_NOME,70)) //13 - Nome do Hospital
                    aAdd(aDados, Transform(BTS->BTS_NRCRNA, cPicCNES)	   ) //14 - C?digo CNES

                    // Dados da Interna??o
                    aAdd(aDados, BD5->BD5_DATPRO		) //15 - Data In?cio do Faturamento
                    aAdd(aDados, BD5->BD5_DATPRO	    ) //16 - Data do Fim do Faturamento

                    // Dados do Procedimento
                    aCpo17 := {}
                    aCpo18 := {}
                    aCpo19 := {}
                    aCpo20 := {}
                    aCpo21 := {}
                    aCpo22 := {}
                    aCpo23 := {}
                    aCpo24 := {}
                    aCpo25 := {}
                    aCpo26 := {}
                    aCpo27 := {}
                    aCpo28 := {}
                    aCpo29 := {}
                    aCpo30 := {}
                    aCpo31 := {}
                    aCpo32 := {}
                    aCpo33 := {}
                    aCpo34 := {}
                    aCpo35 := {}
                    aCpo36 := {}

                    nVrTot := 0

                    BD6->(dbSetOrder(8))//B0E_FILIAL + B0E_OPEMOV + B0E_ANOAUT + B0E_MESAUT + B0E_NUMAUT
                    cChave   := BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO)
                    BD6->(dbSeek(cChave))

                    While !BD6->(EOF()) .and. ( cChave == BD6->(BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO) )

                        IF BD6->BD6_SITUAC == '1' .and. BD6->BD6_STATUS == '1'

                            cTpProc := Posicione('BR8',1,xFilial('BR8') + BD6->(BD6_FILIAL+ BD6_CODPRO),'BR8_TPPROC')

                            aAdd(aCpo17, BD6->BD6_DATPRO) 		// Data
                            aAdd(aCpo18, BD6->BD6_HORPRO)		// Hora Inicial
                            aAdd(aCpo19, BD6->BD6_HORPRO)		// Hora
                            aAdd(aCpo20, BD6->BD6_CODPAD)		// Tabela
                            aAdd(aCpo21, BD6->BD6_CODPRO)		// C?digo de Procedimento
                            aAdd(aCpo22, BD6->BD6_DESPRO)		//Descri??o
                            aAdd(aCpo23, val(cvaltochar(BD6->BD6_QTDPRO ) ) )		//Quantidade
                            aAdd(aCpo24, val(cvaltochar(BD6->BD6_VIA)))		// Via
                            aAdd(aCpo25, ""				)		// Tecnica
                            aAdd(aCpo26, BD6->BD6_PERVIA)		// Red Acrescimo
                            aAdd(aCpo27, Round(BD6->BD6_VLRAPR / BD6->BD6_QTDPRO,2)) // Valor Unit?rio
                            aAdd(aCpo28, Round(BD6->BD6_VLRAPR, 2)) // Valor Total

                            nVrTot += BD6->BD6_VLRAPR

                        Endif

                        BD6->(DbSkip())

                    EndDo

                    aAdd(aDados, aCpo17)
                    aAdd(aDados, aCpo18)
                    aAdd(aDados, aCpo19)
                    aAdd(aDados, aCpo20)
                    aAdd(aDados, aCpo21)
                    aAdd(aDados, aCpo22)
                    aAdd(aDados, aCpo23)
                    aAdd(aDados, aCpo24)
                    aAdd(aDados, aCpo25)
                    aAdd(aDados, aCpo26)
                    aAdd(aDados, aCpo27)
                    aAdd(aDados, aCpo28)

                    // Identifica??o do(s) profissional (is) Executantes

                    BD7->(dbSetOrder(6))//B0E_FILIAL + B0E_OPEMOV + B0E_ANOAUT + B0E_MESAUT + B0E_NUMAUT
                    BD7->(dbSeek(cChave))

                    While !BD7->(EOF()) .and. ( cChave == BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO) )

                        IF BD7->BD7_SITUAC == '1'// .and. BD7->BD7_STATUS == '1'

                            cTpProc := Posicione('BR8',1,xFilial('BR8') + BD7->(BD7_FILIAL+ BD7_CODPRO),'BR8_TPPROC')

                            aAdd(aCpo29, BD7->BD7_SEQUEN ) // Seq Ref
                            aAdd(aCpo30, If(empty(BE4->BE4_CDPFRE),' ',Posicione('BWT',1,xFilial('BWT') + BD7->(BD7_CODOPE + BD7_CODTPA),'BWT_CODEDI')))	//Grau participacao
                            aAdd(aCpo31, BE4->BE4_CDPFRE )//Codigo na operadora/CPF
                            aAdd(aCpo32, BE4->BE4_NOMEXE)		// Nome do profissional
                            aAdd(aCpo33, GetAdvFVal('BB0','BB0_CODSIG',xFilial('BB0') + BE4->BE4_CDPFRE,1) )//Conselho profissional
                            aAdd(aCpo34, BE4->BE4_REGEXE )		//Numero do Conselho
                            aAdd(aCpo35, BE4->BE4_ESTEXE)		//UF
                            aAdd(aCpo36, GetAdvFVal('BD5','BD5_CBOS',BD7->(BD7_FILIAL+BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_FASE+BD7_SITUAC),2))		// CBOS

                        Endif

                        BD7->(DbSkip())

                    EndDo

                    aAdd(aDados, aCpo29)
                    aAdd(aDados, aCpo30)
                    aAdd(aDados, aCpo31)
                    aAdd(aDados, aCpo32)
                    aAdd(aDados, aCpo33)
                    aAdd(aDados, aCpo34)
                    aAdd(aDados, aCpo35)
                    aAdd(aDados, aCpo36)
                    // Identifica??o do(s) profissional (is) Executantes

                    aAdd(aDados, B0D->B0D_OBSERV)
                    aAdd(aDados, cvaltochar(nVrTot)) // Valor final do Honorario Medico considerando o somatorio do campo valor total
                    aAdd(aDados, dDataBase)
                    aAdd(aDados, ''			)

                    aAdd(aDados,  BD5->(BD5_CODLDP + BD5_CODPEG + BD5_NUMERO))

                    aAdd(aGuias, aDados)

                    R234HON(aGuias, .T., 2)

                Otherwise

                    //       MsgStop('- CABR234:' + CRLF + ' Tipo de guia [ ' + (cAlias1)->BCI_TIPGUI + ' - ' + AllTrim(BCL->BCL_DESCRI) + ' ] Alias [ ' + BCL->BCL_ALIAS + ' ] N?o implementado.', AllTrim(SM0->M0_NOMECOM))

            End Case

            (cAlias1)->( dbSkip() )

        EndDo

        (cAlias1)->(DbCloseArea())

        //EndIf

    Next _ni

    Alert("Foram gerada(s) "+str(nCont)+ " Guia(s)...")

    BA0->(RestArea(aAreaBA0))
    BCL->(RestArea(aAreaBCL))
    BA1->(RestArea(aAreaBA1))
    BTS->(RestArea(aAreaBTS))
    BAU->(RestArea(aAreaBAU))
    BID->(RestArea(aAreaBID))
    BD6->(RestArea(aAreaBD6))
    BR8->(RestArea(aAreaBR8))
    BR8->(RestArea(aAreaBB0))
    BD7->(RestArea(aAreaBD7))
    BWT->(RestArea(aAreaBWT))

    RestArea(aArea)

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} function R234CON
description Rotina baseada na função padrão PLSTISS1
@author  author
@since   date
@version version
@Parametros
    lGerTXT - Define se imprime direto sem passar pela tela
              de configuracao/preview do relatorio
    nLayout - Define o formato de papl para impressao:
        1 - Formato Ofcio II (216x330mm)
        2 - Formato A4 (210x297mm)
        3 - Formato Carta (216x279mm)
/*/
//-------------------------------------------------------------------
Static Function R234CON(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

    Local nLinMax
    Local nColMax
    Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
    Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
    Local nColA4    :=  0      // Para implementar layout A4
    Local nLinA4    :=  0      // Para implementar layout A4
    Local cFileLogo
    Local nLin
    Local nX
    Local oFont01
    Local oFont02n
    Local oFont03n
    Local oFont04
    Local oPrint    := Nil
    LOCAL cFileName	:= ""
    LOCAL cRel      := "GUIA_CONSULTA_" + aDados[01][40]
    LOCAL nAL		:= 0.25
    LOCAL nAC		:= 0.24
    PRIVATE cPathSrvJ := GetNewPar( "MV_MAXPDF" , "C:\EXPORTA_GUIAS_LOTE\" )
    DEFAULT lGerTXT 	:= .F.
    DEFAULT nLayout 	:= 2
    DEFAULT cLogoGH 	:= ""
    DEFAULT lWeb		:= .T.
    DEFAULT cPathRelW 	:= ""
    Default aDados  := {}

    If Len(aDados) > 0

        oFont01		:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal

        //Nao permite acionar a impressao quando for na web.
        If lWeb

            //cFileName := UPPER(cRel)+UPPER(CriaTrab(NIL,.F.))+".pdf"
            cFileName := UPPER(cRel)+".pdf"

        Else

            cFileName := cRel+CriaTrab(NIL,.F.)

        EndIf

        cPathSrvJ := AjuBarPath(cPathSrvJ)

        If !lWeb
            oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)
        Else
            oPrint := 	FwMsPrinter():New(cFileName, IMP_PDF, .F., cPathSrvJ, .T.)
        EndIf

        //------------------------------------------------------------------------------------------
        //Tratamento para impressao via job
        //------------------------------------------------------------------------------------------
        oPrint:lServer := lWeb

        //------------------------------------------------------------------------------------------
        // Caminho do arquivo
        //------------------------------------------------------------------------------------------
        oPrint:cPathPDF := cPathSrvJ

        //------------------------------------------------------------------------------------------
        //Modo retrato
        //------------------------------------------------------------------------------------------
        oPrint:SetPortrait()

        If nLayout ==2
            //------------------------------------------------------------------------------------------
            //Papl A4
            //------------------------------------------------------------------------------------------
            oPrint:SetPaperSize(9)
        ElseIf nLayout ==3
            //------------------------------------------------------------------------------------------
            //Papl Carta
            //------------------------------------------------------------------------------------------
            oPrint:SetPaperSize(1)
        Else
            //------------------------------------------------------------------------------------------
            //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
            //------------------------------------------------------------------------------------------
            oPrint:SetPaperSize(14)
        Endif

        //------------------------------------------------------------------------------------------
        //Device
        //------------------------------------------------------------------------------------------
        If lWeb
            oPrint:setDevice(IMP_PDF)
            //oPrint:lPDFAsPNG := .T.
        EndIf
        //------------------------------------------------------------------------------------------
        //Verifica se existe alguma impressora configurada para Impressao Grafica
        //------------------------------------------------------------------------------------------
        If  !lWeb
            oPrint:Setup()
            If !(oPrint:nModalResult == 1)
                Return
            Endif
        EndIf

        If oPrint:nPaperSize  == 9 // Papl A4
            nLinMax	:= 1754
            nColMax	:= 2335
            nLayout 	:= 2
            oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
            oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
        Elseif oPrint:nPaperSize == 1 // Papel Carta
            nLinMax	:= 1545
            nColMax	:= 2400
            nLayout 	:= 3
            oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
            oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
        Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
            nLinMax	:= 1764
            nColMax	:= 2400
            nLayout 	:= 1
            oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
            oFont04	:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
        Endif

        For nX := 1 To Len(aDados)

            If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
                Loop
            EndIf

            If lWeb //oPrint:Cprinter == "PDF" .OR. lWeb
                nLinIni	:= 150
            Else
                nLinIni := 000
            Endif
            nColIni := 000
            nLinA4  := 000
            nColA4  := 000

            oPrint:StartPage()		// Inicia uma nova pagina
            //??
            //Box Principal
            //
            oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

            //??
            //Carrega e Imprime Logotipo da Empresa
            //
            fLogoEmp(@cFileLogo,, cLogoGH)

            If File(cFilelogo)
                oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) // Tem que estar abaixo do RootPath
            EndIf

            if nLayout == 2 // Papl A4
                nColA4:= -0065
                nLinA4:= 0
            Endif

            oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1000 + nColA4)*nAC, STR0001, oFont02n,,,, 2) //"GUIA DE CONSULTA"
            oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1700 + nColA4)*nAC, "2 - "+OemToAnsi(STR0002), oFont01) //"N?"
            oPrint:Say((nLinIni + 0090)*nAL, (nColIni + 1801 + nColA4)*nAC, aDados[nX, 02], oFont03n)

            oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0010)*nAC, (nLinIni + 0249)*nAL + nLinA4, (nColIni + 0415)*nAC)
            oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0020)*nAC, "1 - "+STR0003, oFont01) //"Registro ANS"
            oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0030)*nAC, aDados[nX, 01], oFont04)
            oPrint:Box((nLinIni + 0155)*nAL, (nColIni + 0420)*nAC, (nLinIni + 0249)*nAL + nLinA4, (nColIni + 0830)*nAC)
            oPrint:Say((nLinIni + 0180)*nAL, (nColIni + 0430)*nAC, "3 - "+OemToAnsi(STR0004), oFont01) //"Data de Emiss?o da Guia"
            oPrint:Say((nLinIni + 0220)*nAL, (nColIni + 0440)*nAC, DtoC(aDados[nX, 03]), oFont04)

            oPrint:Say((nLinIni + 0274 + nLinA4)*nAL, (nColIni + 0010)*nAC, OemToAnsi(STR0005), oFont01) //"Dados do Benefici?rio"
            oPrint:Box((nLinIni + 0280)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0378)*nAL + (2*nLinA4), (nColIni + 0585)*nAC)
            oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0020)*nAC, "4 - "+OemToAnsi(STR0006), oFont01) //"N?mero da Carteira"
            oPrint:Say((nLinIni + 0349 + nLinA4)*nAL, (nColIni + 0030)*nAC, aDados[nX, 04], oFont04)
            oPrint:Box((nLinIni + 0284)*nAL + nLinA4, (nColIni + 0590)*nAC, (nLinIni + 0378)*nAL + (2*nLinA4), (nColIni + 2112 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0600)*nAC, "5 - "+STR0007, oFont01) //"Plano"
            oPrint:Say((nLinIni + 0349 + nLinA4)*nAL, (nColIni + 0610)*nAC, aDados[nX, 05], oFont04)
            oPrint:Box((nLinIni + 0284)*nAL + nLinA4, (nColIni + 2117)*nAC + nColA4, (nLinIni + 0378)*nAL + (2*nLinA4), (nColIni + 2390 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 2127 + nColA4)*nAC, "6 - "+STR0008, oFont01) //"Validade da Carteira"
            oPrint:Say((nLinIni + 0349 + nLinA4)*nAL, (nColIni + 2137 + nColA4)*nAC, DtoC(aDados[nX, 06]), oFont04)

            oPrint:Box((nLinIni + 0383)*nAL + (2*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0477)*nAL + (3*nLinA4), (nColIni + 1965 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0408 + (2*nLinA4))*nAL, (nColIni + 0020)*nAC, "7 - "+STR0009, oFont01) //"Nome"
            oPrint:Say((nLinIni + 0448 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 07], oFont04)
            oPrint:Box((nLinIni + 0383)*nAL + (2*nLinA4), (nColIni + 1970 + nColA4)*nAC, (nLinIni + 0477)*nAL + (3*nLinA4), (nColIni + 2390 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0408 + (2*nLinA4))*nAL, (nColIni + 1980 + nColA4)*nAC, "8 - "+STR0010, oFont01) //"N?mero do Cart?o Nacional de Sa?de"
            oPrint:Say((nLinIni + 0448 + (2*nLinA4))*nAL, (nColIni + 1990 + nColA4)*nAC, aDados[nX, 08], oFont04)

            oPrint:Say((nLinIni + 0502 + (3*nLinA4))*nAL, (nColIni + 0010)*nAC, STR0011, oFont01) //"Dados do Contratado"
            oPrint:Box((nLinIni + 0512)*nAL + (3*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0606)*nAL + (4*nLinA4), (nColIni + 0426)*nAC)
            oPrint:Say((nLinIni + 0537 + (3*nLinA4))*nAL, (nColIni + 0020)*nAC, "9 - "+STR0012, oFont01) //"C?digo na Operadora / CNPJ / CPF"
            oPrint:Say((nLinIni + 0577 + (3*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 09], oFont04)
            oPrint:Box((nLinIni + 0512)*nAL + (3*nLinA4), (nColIni + 0431)*nAC, (nLinIni + 0606)*nAL + (4*nLinA4), (nColIni + 2165 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0537 + (3*nLinA4))*nAL, (nColIni + 0441)*nAC, "10 - "+STR0013, oFont01) //"Nome do Contratado"
            oPrint:Say((nLinIni + 0577 + (3*nLinA4))*nAL, (nColIni + 0451)*nAC, SubStr(aDados[nX, 10], 1, 65), oFont04)
            oPrint:Box((nLinIni + 0512)*nAL + (3*nLinA4), (nColIni + 2170 + nColA4)*nAC, (nLinIni + 0606)*nAL + (4*nLinA4), (nColIni + 2390 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0537 + (3*nLinA4))*nAL, (nColIni + 2180 + nColA4)*nAC, "11 - "+STR0014, oFont01) //"C?digo CNES"
            oPrint:Say((nLinIni + 0577 + (3*nLinA4))*nAL, (nColIni + 2190 + nColA4)*nAC, aDados[nX, 11], oFont04)

            oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 0132)*nAC)
            oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 0020)*nAC, "12 - "+STR0015, oFont01) //"T.L."
            oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 12], oFont04)
            oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 0137)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 1050 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 0147)*nAC, "13-14-15 - "+STR0016, oFont01) //"Logradouro - N?mero - Complemento"
            oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 0157)*nAC, SubStr(AllTrim(aDados[nX, 13]) + IIf(!Empty(aDados[nX, 14]), ", ","") + AllTrim(aDados[nX, 14]) + IIf(!Empty(aDados[nX, 15]), " - ","") + AllTrim(aDados[nX, 15]), 1, 34), oFont04)
            oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 1055 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 1830 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 1065 + nColA4)*nAC, "16 - "+STR0017, oFont01) //"Munic?pio"
            oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 1075 + nColA4)*nAC, SubStr(aDados[nX, 16], 1, 29), oFont04)
            oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 1835 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 1940 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 1845 + nColA4)*nAC, "17 - "+STR0018, oFont01) //"UF"
            oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 1860 + nColA4)*nAC, aDados[nX, 17], oFont04)
            oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 1945 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 2165 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 1955 + nColA4)*nAC, "18 - "+STR0019, oFont01) //"C?digo IBGE"
            oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 1965 + nColA4)*nAC, aDados[nX, 18], oFont04)
            oPrint:Box((nLinIni + 0611)*nAL + (4*nLinA4), (nColIni + 2170 + nColA4)*nAC, (nLinIni + 0705)*nAL + (5*nLinA4), (nColIni + 2390 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0636 + (4*nLinA4))*nAL, (nColIni + 2180 + nColA4)*nAC, "19 - "+STR0020, oFont01) //"CEP"
            oPrint:Say((nLinIni + 0676 + (4*nLinA4))*nAL, (nColIni + 2190 + nColA4)*nAC, aDados[nX, 19], oFont04)

            oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 1455 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 0020)*nAC, "20 - "+STR0021, oFont01) //"Nome do Profissional Executante"
            oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 0030)*nAC, SubStr(aDados[nX, 20], 1, 54), oFont04)
            oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 1460 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 1735 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 1470 + nColA4)*nAC, "21 - "+STR0022, oFont01) //"Conselho Profissional"
            oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 1480 + nColA4)*nAC, aDados[nX, 21], oFont04)
            oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 1740 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 2065 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 1750 + nColA4)*nAC, "22 - "+STR0023, oFont01) //"N?mero no Conselho"
            oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 1760 + nColA4)*nAC, aDados[nX, 22], oFont04)
            oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 2070 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 2165 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 2080 + nColA4)*nAC, "23 - "+STR0018, oFont01) //"UF"
            oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 2090 + nColA4)*nAC, aDados[nX, 23], oFont04)
            oPrint:Box((nLinIni + 0710)*nAL + (5*nLinA4), (nColIni + 2170 + nColA4)*nAC, (nLinIni + 0804)*nAL + (6*nLinA4), (nColIni + 2390 + nColA4)*nAC)
            oPrint:Say((nLinIni + 0735 + (5*nLinA4))*nAL, (nColIni + 2180 + nColA4)*nAC, "24 - "+STR0024, oFont01) //"C?digo CBO S"
            oPrint:Say((nLinIni + 0775 + (5*nLinA4))*nAL, (nColIni + 2190 + nColA4)*nAC, aDados[nX, 24], oFont04)

            oPrint:Say((nLinIni  + 0829 + (6*nLinA4))*nAL, (nColIni + 0010)*nAC, STR0025, oFont01) //"Hipteses DiagN?sticas"
            oPrint:Box((nLinIni  + 0839)*nAL + (6*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 0933)*nAL + (7*nLinA4), (nColIni + 0315)*nAC)
            oPrint:Say((nLinIni  + 0864 + (6*nLinA4))*nAL, (nColIni + 0020)*nAC, "25 - "+STR0026, oFont01) //"Tipo de DoeN?a"
            oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0030)*nAC)
            oPrint:Line((nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0077)*nAC)
            oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0077)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0077)*nAC)
            oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0043)*nAC, aDados[nX, 25], oFont04)
            oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0090)*nAC, STR0027+"    "+STR0028, oFont01)  //"A-Aguda"###"C-Crnica"
            oPrint:Box((nLinIni  + 0839)*nAL + (6*nLinA4), (nColIni + 0320)*nAC, (nLinIni + 0933)*nAL + (7*nLinA4), (nColIni + 0765)*nAC)
            oPrint:Say((nLinIni  + 0864 + (6*nLinA4))*nAL, (nColIni + 0330)*nAC, "26 - "+STR0029, oFont01) //"Tempo de DoeN?a"
            oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0340)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0340)*nAC)
            oPrint:Line((nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0340)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0426)*nAC)
            oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0426)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0426)*nAC)
            oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0353)*nAC, IIF((StrZero(aDados[nX, 26,1], 2, 0))=="00","",(StrZero(aDados[nX, 26,1], 2, 0))), oFont04)
            oPrint:Say((nLinIni  + 0899 + (6*nLinA4))*nAL, (nColIni + 0434)*nAC, "-", oFont01)
            oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0447)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0447)*nAC)
            oPrint:Line((nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0447)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0494)*nAC)
            oPrint:Line((nLinIni + 0874)*nAL + (6*nLinA4), (nColIni + 0494)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0494)*nAC)
            oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0457)*nAC, aDados[nX, 26,2], oFont04)
            oPrint:Say((nLinIni  + 0904 + (6*nLinA4))*nAL, (nColIni + 0510)*nAC, STR0030+"  "+STR0031+"  "+STR0032, oFont01) //"A-Anos"###"M-Meses"###"D-Dias"
            oPrint:Box((nLinIni + 0839)*nAL  + (6*nLinA4), (nColIni + 0770)*nAC, (nLinIni + 0933)*nAL + (7*nLinA4), (nColIni + 1807)*nAC)
            oPrint:Say((nLinIni + 0864  + (6*nLinA4))*nAL, (nColIni + 0780)*nAC, "27 - "+STR0033, oFont01) //"Indicao de Acidente"
            oPrint:Line((nLinIni+ 0869)*nAL  + (6*nLinA4), (nColIni + 0790)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0790)*nAC)
            oPrint:Line((nLinIni+ 0921)*nAL  + (7*nLinA4), (nColIni + 0790)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0832)*nAC)
            oPrint:Line((nLinIni+ 0869)*nAL  + (6*nLinA4), (nColIni + 0832)*nAC, (nLinIni + 0921)*nAL + (7*nLinA4), (nColIni + 0832)*nAC)
            oPrint:Say((nLinIni + 0904  + (6*nLinA4))*nAL, (nColIni + 0803)*nAC, aDados[nX, 27], oFont04)
            oPrint:Say((nLinIni + 0904  + (6*nLinA4))*nAL, (nColIni + 0850)*nAC, "0 - "+STR0034+"     "+"1 - "+STR0035+"     "+"2 - "+STR0036, oFont01) //"Acidente ou doeN?a relacionado ao trabalho"###"Trnsito"###"Outros"

            oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 0285)*nAC)
            oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0020)*nAC, "28 - "+STR0037, oFont01) //"CID Principal"
            oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0030)*nAC, aDados[nX, 28], oFont04)
            oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0290)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 0565)*nAC)
            oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0300)*nAC, "29 - "+STR0038, oFont01) //"CID (2)"
            oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0310)*nAC, aDados[nX, 29], oFont04)
            oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0570)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 0845)*nAC)
            oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0580)*nAC, "30 - "+STR0039, oFont01) //"CID (3)"
            oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0590)*nAC, aDados[nX, 30], oFont04)
            oPrint:Box((nLinIni + 0938)*nAL + (7*nLinA4), (nColIni + 0850)*nAC, (nLinIni + 1032)*nAL + (8*nLinA4), (nColIni + 1115)*nAC)
            oPrint:Say((nLinIni + 0963 + (7*nLinA4))*nAL, (nColIni + 0860)*nAC, "31 - "+STR0040, oFont01) //"CID (4)"
            oPrint:Say((nLinIni + 1003 + (7*nLinA4))*nAL, (nColIni + 0870)*nAC, aDados[nX, 31], oFont04)

            oPrint:Say((nLinIni + 1057 + (8*nLinA4))*nAL, (nColIni + 0010)*nAC, STR0041+" / "+STR0042, oFont01) //"Dados do Atendimento"###"Procedimento Realizado"
            oPrint:Box((nLinIni + 1067)*nAL + (8*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1161)*nAL + (9*nLinA4), (nColIni + 0305)*nAC)
            oPrint:Say((nLinIni + 1092 + (8*nLinA4))*nAL, (nColIni + 0020)*nAC, "32 - "+STR0043, oFont01) //"Data do Atendimento"
            oPrint:Say((nLinIni + 1132 + (8*nLinA4))*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 32]), oFont04)
            oPrint:Box((nLinIni + 1067)*nAL + (8*nLinA4), (nColIni + 0310)*nAC, (nLinIni + 1161)*nAL + (9*nLinA4), (nColIni + 0565)*nAC)
            oPrint:Say((nLinIni + 1092 + (8*nLinA4))*nAL, (nColIni + 0320)*nAC, "33 - "+STR0044, oFont01) //"C?digo Tabela"
            oPrint:Say((nLinIni + 1132 + (8*nLinA4))*nAL, (nColIni + 0330)*nAC, aDados[nX, 33], oFont04)
            oPrint:Box((nLinIni + 1067)*nAL + (8*nLinA4), (nColIni + 0570)*nAC, (nLinIni + 1161)*nAL + (9*nLinA4), (nColIni + 0900)*nAC)
            oPrint:Say((nLinIni + 1092 + (8*nLinA4))*nAL, (nColIni + 0580)*nAC, "34 - "+STR0045, oFont01) //"C?digo Procedimento"
            oPrint:Say((nLinIni + 1132 + (8*nLinA4))*nAL, (nColIni + 0590)*nAC, aDados[nX, 34], oFont04)

            oPrint:Box((nLinIni + 1166)*nAL  + (9*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1260)*nAL + (10*nLinA4), (nColIni + 0505)*nAC)
            oPrint:Say((nLinIni + 1191  + (9*nLinA4))*nAL, (nColIni + 0020)*nAC, "35 - "+STR0046, oFont01) //"Tipo de Consulta"
            oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0030)*nAC)
            oPrint:Line((nLinIni + 1253)*nAL +(10*nLinA4), (nColIni + 0030)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0077)*nAC)
            oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0077)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0077)*nAC)
            oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0043)*nAC, aDados[nX, 35], oFont04)
            oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0090)*nAC, "1-"+STR0047+"   "+"2-"+STR0048+"   "+"3-"+STR0049, oFont01) //"Primeira"###"Seguimento"###"Pr-Natal"
            oPrint:Box((nLinIni + 1166)*nAL  + (9*nLinA4), (nColIni + 0510)*nAC, (nLinIni + 1260)*nAL + (10*nLinA4), (nColIni + 1250)*nAC)
            oPrint:Say((nLinIni + 1191  + (9*nLinA4))*nAL, (nColIni + 0520)*nAC, "36 - "+STR0050, oFont01) //"Tipo de Sa?da"
            oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0530)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0530)*nAC)
            oPrint:Line((nLinIni + 1253)*nAL +(10*nLinA4), (nColIni + 0530)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0577)*nAC)
            oPrint:Line((nLinIni + 1206)*nAL + (9*nLinA4), (nColIni + 0577)*nAC, (nLinIni + 1253)*nAL + (10*nLinA4), (nColIni + 0577)*nAC)
            oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0543)*nAC, aDados[nX, 36], oFont04)
            oPrint:Say((nLinIni + 1231  + (9*nLinA4))*nAL, (nColIni + 0590)*nAC, "1-"+STR0051+"   "+"2-"+STR0052+"   "+"3-"+STR0053+"   "+"4-"+STR0054+"   "+"5-"+STR0055, oFont01) //"Retorno"###"Retorno SADT"###"Referncia"###"Interna??o"###"Alta"

            oPrint:Box((nLinIni + 1265)*nAL + (10*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 1557)*nAL + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)), (nColIni + 2390 + nColA4)*nAC)
            oPrint:Say((nLinIni + 1290 + (10*nLinA4))*nAL, (nColIni + 0020)*nAC, "37 - "+STR0056, oFont01) //"Observacao"
            nLin := 1335

            oPrint:Box((nLinIni + 1562)*nAL + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)), (nColIni + 0010)*nAC, (nLinIni + 1734)*nAL + IIf(nLayout ==2,(14*nLinA4),(22*nLinA4)), (nColIni + 1185 + nColA4)*nAC)
            oPrint:Say((nLinIni + 1587 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 0020)*nAC, "38 - "+STR0057, oFont01) //"Data e Assinatura do Profissional"
            oPrint:Say((nLinIni + 1627 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 38]), oFont04)
            oPrint:Box((nLinIni + 1562)*nAL + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)), (nColIni + 1190 + nColA4)*nAC, (nLinIni + 1734)*nAL + IIf(nLayout ==2,(14*nLinA4),(22*nLinA4)), (nColIni + 2390 + nColA4)*nAC)
            oPrint:Say((nLinIni + 1587 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 1200 + nColA4)*nAC, "39 - "+STR0058, oFont01) //"Data e Assinatura do Benefici?rio ou Responsvel"
            oPrint:Say((nLinIni + 1627 + IIf(nLayout ==2,(13*nLinA4),(20*nLinA4)))*nAL, (nColIni + 1210 + nColA4)*nAC, DtoC(aDados[nX, 39]), oFont04)

            oPrint:EndPage()	// Finaliza a pagina

        Next nX

        If lGerTXT .And. !lWeb

            //Imprime Relatorio
            oPrint:Print()

        Else

            //Visualiza impressao grafica antes de imprimir
            oPrint:lViewPDF := .F.
            oPrint:Print()
            PLSCHKRP(cPathSrvJ, cFileName)
            FreeObj(oPrint)

            //Alert("Arquivo gerado Em: "+cPathSrvJ+"\"+cFileName)

        EndIf

    EndIf

Return (cFileName)

//-------------------------------------------------------------------
/*/{Protheus.doc} function R234SADT
description Rotina baseada na função padr?o PLSTISS2
@author  author
@since   date
@version version
@parametros
    aDados - Array com as informa??es do relat?rio
    lGerTXT - Define se imprime direto sem passar pela tela
              de configuracao/preview do relatorio
    nLayout - Define o formato de papl para impressao:
        1 - Formato Ofcio II (216x330mm)
        2 - Formato A4 (210x297mm)
        3 - Formato Carta (216x279mm)
/*/
//-------------------------------------------------------------------
Static Function R234SADT(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

    Local nLinMax
    Local nColMax
    Local nLinIni	:= 0 // Linha Lateral (inicial) Esquerda
    Local nColIni	:= 0 // Coluna Lateral (inicial) Esquerda
    Local nLimFim	:= 0
    Local nColA4    := 0
    Local nColSoma  := 0
    Local nColSoma2 := 0
    Local nLinA4	:= 0
    Local cFileLogo
    Local nLin
    Local nOldLinIni
    Local nOldColIni
    Local nI, nJ, nX, nN
    Local nV, nV1, nV2, nV3, nV4
    Local cObs
    Local oFont01
    Local oFont02n
    Local oFont03n
    Local oFont04
    Local oPrint    := Nil
    Local lImpnovo  :=.T.
    Local nVolta    := 0
    Local nP        := 0
    Local nP1       := 0
    Local nP2       := 0
    Local nP3       := 0
    Local nP4       := 0
    Local nT        := 0
    Local nT1       := 0
    Local nT2       := 0
    Local nT3       := 0
    Local nT4       := 0
    Local nTotOPM   := 0
    Local nProx     := 0
    LOCAL cFileName	:= ""
    LOCAL cRel      := "GUIA_SADT_" + aDados[01][90]
    LOCAL nAL		:= 0.25
    LOCAL nAC		:= 0.24
    Local lImpPrc   := .T.
    PRIVATE cPathSrvJ := GetNewPar( "MV_MAXPDF" , "C:\EXPORTA_GUIAS_LOTE\" )

    DEFAULT lGerTXT 	:= .F.
    DEFAULT nLayout 	:= 2
    DEFAULT cLogoGH 	:= ""
    DEFAULT lWeb		:= .T.
    DEFAULT cPathRelW 	:= ""
    DEFAULT aDados 	:= {}

    If Len(aDados) > 0

        oFont01	:= TFont():New("Arial",  5,  5, , .F., , , , .T., .F.) // Normal

        //------------------------------------------------------------------------------------------
        // Nao permite acionar a impressao quando for na web.
        //------------------------------------------------------------------------------------------
        If lWeb

            //cFileName := UPPER(cRel)+UPPER(CriaTrab(NIL,.F.))+".pdf"
            cFileName := UPPER(cRel)+".pdf"
        Else
            cFileName := cRel+CriaTrab(NIL,.F.)
        EndIf

        cPathSrvJ := AjuBarPath(cPathSrvJ)

        if !lWeb

            oPrint := FWMSPrinter():New ( cFileName			,			,	.F.				,cPathSrvJ	 	,	.T.				,			 ,				,			  ,			  ,	.F.			, 		, 				)

        else

            oPrint := 	FwMsPrinter():New(cFileName, IMP_PDF, .F., cPathSrvJ, .T.)

        Endif

        //------------------------------------------------------------------------------------------
        //Tratamento para impressao via job
        //------------------------------------------------------------------------------------------
        oPrint:lServer := lWeb

        //------------------------------------------------------------------------------------------
        // Caminho do arquivo
        //------------------------------------------------------------------------------------------
        oPrint:cPathPDF := cPathSrvJ

        //------------------------------------------------------------------------------------------
        //Modo paisagem
        //------------------------------------------------------------------------------------------
        oPrint:SetLandscape()

        if nLayout ==2
            //------------------------------------------------------------------------------------------
            //Papl A4
            //------------------------------------------------------------------------------------------
            oPrint:SetPaperSize(9)
        Elseif nLayout ==3
            //------------------------------------------------------------------------------------------
            //Papl Carta
            //------------------------------------------------------------------------------------------
            oPrint:SetPaperSize(1)
        Else
            //------------------------------------------------------------------------------------------
            //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
            //------------------------------------------------------------------------------------------
            oPrint:SetPaperSize(14)
        Endif
        //------------------------------------------------------------------------------------------
        //Device
        //------------------------------------------------------------------------------------------
        If lWeb
            oPrint:setDevice(IMP_PDF)
        EndIf

        //------------------------------------------------------------------------------------------
        //Verifica se existe alguma impressora configurada para Impressao Grafica
        //------------------------------------------------------------------------------------------
        If  !lWeb
            oPrint:Setup()
            lImpnovo:=(oPrint:nModalResult == 1)
        EndIf

        If oPrint:nPaperSize  == 9 // Papl A4
            nLinMax	:=	2000
            nColMax	:=	3365 //3508 //3380 //3365
            nLayout 	:= 2
            oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
            oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
        Elseif oPrint:nPaperSize == 1 // Papel Carta
            nLinMax	:=	2000
            nColMax	:=	3175
            nLayout 	:= 3
            oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
            oFont04		:= TFont():New("Arial", 07, 07, , .F., , , , .T., .F.) // Normal
        Else // Papel Oficio2 216 x 330mm / 8 1/2 x 13in
            nLinMax	:=	2435
            nColMax	:=	3765
            nLayout 	:= 1
            oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
            oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
        Endif

        While lImpnovo

            lImpnovo:=.F.
            nVolta  += 1
            nT      += 5
            nT1     += 5
            nT2     +=10
            nT3     += 9
            nT4     += 9
            nProx   += 1

            For nX := 1 To Len(aDados)

                If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
                    Loop
                EndIf

                For nI := 25 To 29
                    If Len(aDados[nX, nI]) < nT
                        For nJ := Len(aDados[nX, nI]) + 1 To nT
                            If AllTrim(Str(nI)) $ "28,29"
                                aAdd(aDados[nX, nI], 0)
                            Else
                                aAdd(aDados[nX, nI], "")
                            EndIf
                        Next nJ
                    EndIf
                Next nI

                For nI := 51 To 62
                    If Len(aDados[nX, nI]) < nT1
                        For nJ := Len(aDados[nX, nI]) + 1 To nT1
                            If AllTrim(Str(nI)) $ "51"
                                aAdd(aDados[nX, nI], StoD(""))
                            ElseIf AllTrim(Str(nI)) $ "57,60,61,62"
                                aAdd(aDados[nX, nI], 0)
                            Else
                                aAdd(aDados[nX, nI], "")
                            EndIf
                        Next nJ
                    EndIf
                Next nI

                For nI := 63 To 63
                    If Len(aDados[nX, nI]) < nT2
                        For nJ := Len(aDados[nX, nI]) + 1 To nT2
                            aAdd(aDados[nX, nI], StoD(""))
                        Next nJ
                    EndIf
                Next nI

                For nI := 65 To 71
                    If Len(aDados[nX, nI]) < nVolta
                        For nJ := Len(aDados[nX, nI]) + 1 To nVolta
                            If AllTrim(Str(nI)) $ "65,66,67,68,69,70,71"
                                aAdd(aDados[nX, nI], 0)
                            EndIf
                        Next nJ
                    EndIf
                Next nI

                For nI := 72 To 77
                    If Len(aDados[nX, nI]) < nT3
                        For nJ := Len(aDados[nX, nI]) + 1 To nT3
                            If AllTrim(Str(nI)) $ "75,77"
                                aAdd(aDados[nX, nI], 0)
                            Else
                                aAdd(aDados[nX, nI], "")
                            EndIf
                        Next nJ
                    EndIf
                Next nI

                For nI := 78 To 84
                    If Len(aDados[nX, nI]) < nT4
                        For nJ := Len(aDados[nX, nI]) + 1 To nT4
                            If AllTrim(Str(nI)) $ "81,83,84"
                                aAdd(aDados[nX, nI], 0)
                            Else
                                aAdd(aDados[nX, nI], "")
                            EndIf
                        Next nJ
                    EndIf
                Next nI

                For nI := 85 To 85
                    If Len(aDados[nX, nI]) < nVolta
                        For nJ := Len(aDados[nX, nI]) + 1 To nVolta
                            aAdd(aDados[nX, nI], 0)
                        Next nJ
                    EndIf
                Next nI
                If oPrint:Cprinter == "PDF" .OR. lWeb
                    nLinIni	:= 150
                    nLimFim	:= 400
                Else
                    nLinIni	:= 000
                    nLimFim	:= 230
                Endif


                nColIni		:= 000
                nColA4		:= 000
                nLinA4		:= 000
                nColSoma	:= 000
                nColSoma2	:= 000

                //
                //Inicia uma nova pagina
                //
                oPrint:StartPage()
                //??
                //Box Principal
                //
                oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLimFim + nLinMax)*nAL, (nColIni + nColMax)*nAC)
                //??
                //Carrega e Imprime Logotipo da Empresa
                //
                fLogoEmp(@cFileLogo,, cLogoGH)

                If File(cFilelogo)
                    oPrint:SayBitmap((nLinIni + 0050)*nAL, (nColIni + 0020)*nAC, cFileLogo, (400)*nAL, (090)*nAC) 	// Tem que estar abaixo do RootPath
                EndIf

                If nLayout == 2 // Papl A4
                    nColA4    := -0395
                    nLinA4    := -0010
                    nColSoma  := -0300
                    nColSoma2 := -0190
                Elseif nLayout == 3// Carta
                    nColA4    := -0590
                    nLinA4    := -0010
                    nColSoma  := -0300
                    nColSoma2 := -0190
                Endif

                oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 1702)*nAC + (nColA4/2), STR0060, oFont02n,,,, 2) //"GUIA DE HONORARIO INDIVIDUAL"
                oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 2930 + IIf (nLayout == 3,(nColA4/2+(nColSoma/3)),(nColA4/2)))*nAC, "2 - "+STR0002, oFont01) //"N?"
                oPrint:Say((nLinIni + 0050)*nAL, (nColIni + 3026 + IIf (nLayout == 3,(nColA4/2+(nColSoma/3)),(nColA4/2)))*nAC, aDados[nX, 02], oFont03n)

                oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 0315)*nAC)
                oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "1 - "+STR0003, oFont01) //"Registro ANS"
                oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 01], oFont04)
                oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 0320			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1035)*nAC)
                oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 0330			)*nAC, "3 - "+STR0061, oFont01) //"N? Guia Principal"
                oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 0340			)*nAC, aDados[nX, 03], oFont04)
                oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1040			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1345)*nAC)
                oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1050			)*nAC, "4 - "+STR0062, oFont01) //"Data da Autoriza??o"
                oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1060			)*nAC, DtoC(aDados[nX, 04]), oFont04)
                oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1350			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 1755)*nAC)
                oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1360			)*nAC, "5 - "+STR0063, oFont01) //"Senha"
                oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1370			)*nAC, aDados[nX, 05], oFont04)
                oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 1760			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 2165)*nAC)
                oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 1770			)*nAC, "6 - "+STR0064, oFont01) //"Data Validade da Senha"
                oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 1780			)*nAC, DtoC(aDados[nX, 06]), oFont04)
                oPrint:Box((nLinIni + 0175)*nAL + nLinA4, (nColIni + 2170			)*nAC, (nLinIni + 0269)*nAL + nLinA4, (nColIni + 2465)*nAC)
                oPrint:Say((nLinIni + 0180 + nLinA4)*nAL, (nColIni + 2180			)*nAC, "7 - "+STR0004, oFont01) //"Data de Emiss?o da Guia"
                oPrint:Say((nLinIni + 0210 + nLinA4)*nAL, (nColIni + 2190			)*nAC, DtoC(aDados[nX, 07]), oFont04)

                oPrint:Say((nLinIni + 0274 + nLinA4)*nAL, (nColIni + 0010			)*nAC, STR0005, oFont01) //"Dados do Benefici?rio"
                oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 0425)*nAC)
                oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "8 - "+STR0006, oFont01) //"N?mero da Carteira"
                oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 08], oFont04)
                oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 0430			)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 1572 + nColA4)*nAC)
                oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 0440			)*nAC, "9 - "+STR0007, oFont01) //"Plano"
                oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 0450			)*nAC, aDados[nX, 09], oFont04)
                oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 1577 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 1835 + nColA4)*nAC)
                oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 1587 + nColA4	)*nAC, "10 - "+STR0008, oFont01) //"Validade da Carteira"
                oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 1597 + nColA4	)*nAC, DtoC(aDados[nX, 10]), oFont04)
                oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 1840 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 3290 + nColA4)*nAC)
                oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 1850 + nColA4	)*nAC, "11 - "+STR0009, oFont01) //"Nome"
                oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 1860 + nColA4	)*nAC, SubStr(aDados[nX, 11], 1, 52), oFont04)
                oPrint:Box((nLinIni + 0304)*nAL + nLinA4, (nColIni + 3295 + nColA4	)*nAC, (nLinIni + 0398)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 0309 + nLinA4)*nAL, (nColIni + 3305 + nColA4	)*nAC, "12 - "+STR0010, oFont01) //"N?mero do Cart?o Nacional de Sa?de"
                oPrint:Say((nLinIni + 0339 + nLinA4)*nAL, (nColIni + 3315 + nColA4	)*nAC, aDados[nX, 12], oFont04)

                oPrint:Say((nLinIni + 0403 + nLinA4)*nAL, (nColIni + 0010			)*nAC, STR0065, oFont01) //"Dados do Contratado Solicitante"
                oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 0426)*nAC)
                oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "13 - "+STR0012, oFont01) //"C?digo na Operadora / CNPJ / CPF"
                oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 13], oFont04)
                oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 0431			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 2245)*nAC)
                oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 0441			)*nAC, "14 - "+STR0013, oFont01) //"Nome do Contratado"
                oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 0451			)*nAC, SubStr(aDados[nX, 14], 1, 65), oFont04)
                oPrint:Box((nLinIni + 0433)*nAL + nLinA4, (nColIni + 2250			)*nAC, (nLinIni + 0527)*nAL + nLinA4, (nColIni + 2480)*nAC)
                oPrint:Say((nLinIni + 0438 + nLinA4)*nAL, (nColIni + 2260			)*nAC, "15 - "+STR0014, oFont01) //"C?digo CNES"
                oPrint:Say((nLinIni + 0468 + nLinA4)*nAL, (nColIni + 2270			)*nAC, aDados[nX, 15], oFont04)

                oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 1824)*nAC)
                oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "16 - "+STR0066, oFont01) //"Nome do Profissional Solicitante"
                oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 0030			)*nAC, SubStr(aDados[nX, 16], 1, 66), oFont04)
                oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 1829			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2122)*nAC)
                oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 1839			)*nAC, "17 - "+STR0022, oFont01) //"Conselho Profissional"
                oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 1849			)*nAC, aDados[nX, 17], oFont04)
                oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2127			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2480)*nAC)
                oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2137			)*nAC, "18 - "+STR0023, oFont01) //"N?mero no Conselho"
                oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2147			)*nAC, aDados[nX, 18], oFont04)
                oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2485			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2575)*nAC)
                oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2495			)*nAC, "19 - "+STR0018, oFont01) //"UF"
                oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2505			)*nAC, aDados[nX, 19], oFont04)
                oPrint:Box((nLinIni + 0532)*nAL + nLinA4, (nColIni + 2580			)*nAC, (nLinIni + 0626)*nAL + nLinA4, (nColIni + 2790)*nAC)
                oPrint:Say((nLinIni + 0537 + nLinA4)*nAL, (nColIni + 2590			)*nAC, "20 - "+STR0024, oFont01) //"C?digo CBO S"
                oPrint:Say((nLinIni + 0567 + nLinA4)*nAL, (nColIni + 2600			)*nAC, aDados[nX, 20], oFont04)

                oPrint:Say((nLinIni + 0631 + nLinA4)*nAL, (nColIni + 0010)*nAC, STR0067, oFont01) //"Dados da Solicita??o / Procedimentos e Exames Solicitados"
                oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0315)*nAC)
                oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0020)*nAC, "21 - "+STR0068, oFont01) //"Data/Hora da Solicita??o"
                oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0030)*nAC, DtoC(aDados[nX, 21,1]) + " " + Transform(aDados[nX, 21,2], "@R 99:99"), oFont04)
                oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0320)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0735)*nAC)
                oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0330)*nAC, "22 - "+STR0069, oFont01) //"Carter da Solicita??o"
                oPrint:Line((nLinIni + 0691)*nAL+ nLinA4, 		(nColIni + 0340)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0340)*nAC)
                oPrint:Line((nLinIni + 0728)*nAL+ (nLinA4/2), 	(nColIni + 0340)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0387)*nAC)
                oPrint:Line((nLinIni + 0691)*nAL+ nLinA4, 		(nColIni + 0387)*nAC, (nLinIni + 0728)*nAL + (nLinA4/2), (nColIni + 0387)*nAC)
                oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0353)*nAC, aDados[nX, 22], oFont04)
                oPrint:Say((nLinIni + 0706 + nLinA4)*nAL, (nColIni + 0400)*nAC, STR0070+"  "+STR0071, oFont01) //"E-Eletiva"###"U-Urg?ncia/Emergncia"
                oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0740)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 0905)*nAC)
                oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0750)*nAC, "23 - "+STR0072, oFont01) //"CID 10"
                oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0760)*nAC, aDados[nX, 23], oFont04)
                oPrint:Box((nLinIni + 0661)*nAL + nLinA4, (nColIni + 0910)*nAC, (nLinIni + 0755)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 0660 + nLinA4)*nAL, (nColIni + 0920)*nAC, "24 - "+STR0073, oFont01) //"Indicao Cl?nica (obrigatrio se pequena cirurgia, terapia, consulta referenciada e alto custo)"
                oPrint:Say((nLinIni + 0696 + nLinA4)*nAL, (nColIni + 0930)*nAC, aDados[nX, 24], oFont04)

                oPrint:Box((nLinIni + 0760)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 1005)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "25 - "+STR0074, oFont01) //"Tabela"
                oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0150			)*nAC, "26 - "+STR0075, oFont01) //"C?digo do Procedimento"
                oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 0450			)*nAC, "27 - "+STR0076, oFont01) //"Descri??o"
                oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 3400 + nColA4	)*nAC, "28 - "+STR0077, oFont01,,,,1) //"Qt.Solic."
                oPrint:Say((nLinIni + 0765 + nLinA4)*nAL, (nColIni + 3610 + nColA4	)*nAC, "29 - "+STR0078, oFont01,,,,1) //"Qt.Autoriz."

                nOldLinIni := nLinIni

                if nVolta = 1
                    nV:=1
                Endif

                For nP := nV To nT
                    if nVolta <> 1
                        nN:=nP-((5*nVolta)-5)
                        oPrint:Say((nLinIni + 0805 + nLinA4)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
                    else
                        oPrint:Say((nLinIni + 0805 + nLinA4)*nAL, (nColIni + 0025)*nAC, AllTrim(Str(nP)) + " - ", oFont01)
                    endif
                    oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 25, nP], oFont04)
                    oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0150)*nAC			, aDados[nX, 26, nP], oFont04)
                    oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 0450)*nAC			, aDados[nX, 27, nP], oFont04)
                    oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 3425 + nColA4)*nAC, IIf(Empty(aDados[nX, 28, nP]), "", Transform(aDados[nX, 28, nP], "@E 9999.99")), oFont04,,,,1)
                    oPrint:Say((nLinIni + 0800 + nLinA4)*nAL, (nColIni + 3635 + nColA4)*nAC, IIf(Empty(aDados[nX, 29, nP]), "", Transform(aDados[nX, 29, nP], "@E 9999.99")), oFont04,,,,1)
                    nLinIni += 40
                Next nP

                if nT < Len(aDados[nX, 26]).or. lImpnovo
                    nV:=nP
                    lImpnovo:=.T.
                Endif

                nLinIni := nOldLinIni

                oPrint:Say((nLinIni + 1000 + nLinA4)*nAL, (nColIni + 0010			)*nAC, STR0079, oFont01) //"Dados do Contratado Executante"
                oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 0010			)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 0416)*nAC)
                oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 0020			)*nAC, "30 - "+STR0012, oFont01) //"C?digo na Operadora / CNPJ / CPF"
                oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 0030			)*nAC, aDados[nX, 30], oFont04)
                oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 0421			)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 1316 + nColSoma)*nAC)
                oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 0431			)*nAC, "31 - "+STR0013, oFont01) //"Nome do Contratado"
                oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 0441			)*nAC, SubStr(aDados[nX, 31], 1, 32), oFont04)
                oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 1321 + nColSoma)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 1433 + nColSoma)*nAC)
                oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 1331 + nColSoma)*nAC, "32 - "+STR0015, oFont01) //"T.L."
                oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 1341 + nColSoma)*nAC, aDados[nX, 32], oFont04)
                oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 1438 + nColSoma)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 2413 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 1448 + nColSoma)*nAC, "33-34-35 - "+STR0016, oFont01) //"Logradouro - N?mero - Complemento"
                oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 1458 + nColSoma)*nAC, SubStr(AllTrim(aDados[nX, 33]) + IIf(!Empty(aDados[nX, 34]), ", ","") + AllTrim(aDados[nX, 34]) + IIf(!Empty(aDados[nX, 35]), " - ","") + AllTrim(aDados[nX, 35]), 1, 35), oFont04)
                oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 2418 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3023 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 2428 + nColA4	)*nAC, "36 - "+STR0017, oFont01) //"Munic?pio"
                oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 2438 + nColA4	)*nAC, SubStr(aDados[nX, 36], 1, 21), oFont04)
                oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3028 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3130 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3038 + nColA4	)*nAC, "37 - "+STR0018, oFont01) //"UF"
                oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3048 + nColA4	)*nAC, aDados[nX, 37], oFont04)
                oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3135 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3320 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3145 + nColA4	)*nAC, "38 - "+STR0080, oFont01) //"C?d.IBGE"
                oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3155 + nColA4	)*nAC, aDados[nX, 38], oFont04)
                oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3325 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3510 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3335 + nColA4	)*nAC, "39 - "+STR0020, oFont01) //"CEP"
                oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3345 + nColA4	)*nAC, aDados[nX, 39], oFont04)
                oPrint:Box((nLinIni + 1040)*nAL + nLinA4, (nColIni + 3515 + nColA4	)*nAC, (nLinIni + 1134)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1045 + nLinA4)*nAL, (nColIni + 3525 + nColA4	)*nAC, "40 - "+STR0014, oFont01) //"C?digo CNES"
                oPrint:Say((nLinIni + 1075 + nLinA4)*nAL, (nColIni + 3535 + nColA4	)*nAC, aDados[nX, 40, 1], oFont04)

                oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 0590)*nAC)
                oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 0020)*nAC, "40a - "+STR0081, oFont01) //"C?digo na Operadora / CPF do exec. complementar"
                oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 0030)*nAC, SubStr(aDados[nX, 40, 2], 1, 68), oFont04)
                oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 0595)*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 2436 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
                oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 0605)*nAC, "41 - "+STR0082, oFont01) //"Nome do Profissional Executante/Complementar"
                oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 0615)*nAC, SubStr(aDados[nX, 41], 1, 68), oFont04)
                oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 2441 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 2715 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
                oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 2451 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "42 - "+STR0022, oFont01) //"Conselho Profissional"
                oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 2461 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 42], oFont04)
                oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 2720 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3055 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
                oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 2730 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "43 - "+STR0023, oFont01) //"N?mero no Conselho"
                oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 2740 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 43], oFont04)
                oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3060 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3160 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
                oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3070 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "44 - "+STR0018, oFont01) //"UF"
                oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3080 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 44], oFont04)
                oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3165 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3372 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC)
                oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3175 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "45 - "+STR0024, oFont01) //"C?digo CBO S"
                oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3185 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 45, 1], oFont04)
                oPrint:Box((nLinIni + 1139)*nAL + nLinA4, (nColIni + 3377 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, (nLinIni + 1233)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1144 + nLinA4)*nAL, (nColIni + 3387 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, "45a - "+STR0083, oFont01) //"Grau de Participao"
                oPrint:Say((nLinIni + 1174 + nLinA4)*nAL, (nColIni + 3397 + IIf(nLayout == 2,nColA4,nColSoma+nColSoma2))*nAC, aDados[nX, 45, 2], oFont04)

                oPrint:Say((nLinIni + 1236 + nLinA4)*nAL, (nColIni + 0010)*nAC, STR0041, oFont01) //"Dados do Atendimento"
                oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 1185)*nAC)
                oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 0020)*nAC, "46 - "+STR0084, oFont01) //"Tipo Atendimento"
                oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0030)*nAC)
                oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0087)*nAC)
                oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 0087)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 0087)*nAC)
                oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 0043)*nAC, aDados[nX, 46], oFont04)
                oPrint:Say((nLinIni + 1298 + nLinA4)*nAL, (nColIni + 0100)*nAC, "01 - "+STR0085+"    "+"02 - "+STR0086+"    "+"03 - "+STR0087+"    "+"04 - "+STR0088+"    "+"05 - "+STR0089+"    "+"06 - "+STR0090, oFont01) //"Remoo"###"Pequena Cirurgia"###"Terapias"###"Consulta"###"Exame"###"Atendimento Domiciliar"
                oPrint:Say((nLinIni + 1328 + nLinA4)*nAL, (nColIni + 0100)*nAC, "07 - "+STR0091+"    "+"08 - "+STR0092+"    "+"09 - "+STR0093+"    "+"10 - "+STR0094, oFont01) //"SADT Internado"###"Quimioterapia"###"Radioterapia"###"TRS-Terapia Renal Substitutiva"
                oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 1190)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 2450 + nColA4/2)*nAC)
                oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 1200)*nAC, "47 - "+STR0033, oFont01) //"Indicao de Acidente"
                oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 1210)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1210)*nAC)
                oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 1210)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1257)*nAC)
                oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 1257)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 1257)*nAC)
                oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 1223)*nAC, aDados[nX, 47], oFont04)
                oPrint:Say((nLinIni + 1313 + nLinA4)*nAL, (nColIni + 1270)*nAC, "0 - "+STR0034+"   "+"1 - "+STR0035+"   "+"2 - "+STR0036, oFont01) //"Acidente ou doeN?a relacionado ao trabalho"###"Trnsito"###"Outros"
                oPrint:Box((nLinIni + 1268)*nAL + nLinA4, (nColIni + 2455 + nColA4/2)*nAC, (nLinIni + 1362)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1273 + nLinA4)*nAL, (nColIni + 2465 + nColA4/2)*nAC, "48 - "+STR0050, oFont01) //"Tipo de Sa?da"
                oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 2475 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2475 + nColA4/2)*nAC)
                oPrint:Line((nLinIni + 1348)*nAL+ nLinA4, (nColIni + 2475 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2522 + nColA4/2)*nAC)
                oPrint:Line((nLinIni + 1298)*nAL+ nLinA4, (nColIni + 2522 + nColA4/2)*nAC, (nLinIni + 1348)*nAL + nLinA4, (nColIni + 2522 + nColA4/2)*nAC)
                oPrint:Say((nLinIni + 1303 + nLinA4)*nAL, (nColIni + 2488 + nColA4/2)*nAC, aDados[nX, 48], oFont04)
                oPrint:Say((nLinIni + 1313 + nLinA4)*nAL, (nColIni + 2535 + nColA4/2)*nAC, "1 - "+STR0051+"    "+"2 - "+STR0052+"    "+"3 - "+STR0053+"    "+"4 - "+STR0054+"    "+"5 - "+STR0055+"    "+"6 - "+STR0095, oFont01) //"Retorno"###"Retorno SADT"###"Referncia"###"Interna??o"###"Alta"###"?bito"

                oPrint:Say((nLinIni + 1367 + nLinA4)*nAL , (nColIni + 0010)*nAC, STR0096, oFont01) //"Consulta Referncia"
                oPrint:Box((nLinIni + 1397)*nAL + nLinA4 , (nColIni + 0010)*nAC, (nLinIni + 1491)*nAL + nLinA4, (nColIni + 0315)*nAC)
                oPrint:Say((nLinIni + 1402 + nLinA4)*nAL , (nColIni + 0020)*nAC, "49 - "+STR0026, oFont01) //"Tipo de DoeN?a"
                oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0030)*nAC)
                oPrint:Line((nLinIni + 1477)*nAL + nLinA4, (nColIni + 0030)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0077)*nAC)
                oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0077)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0077)*nAC)
                oPrint:Say((nLinIni + 1432  + nLinA4)*nAL, (nColIni + 0043)*nAC, aDados[nX, 49], oFont04)
                oPrint:Say((nLinIni + 1442  + nLinA4)*nAL, (nColIni + 0090)*nAC, STR0027+"    "+STR0028, oFont01) //"A-Aguda"###"C-Crnica"
                oPrint:Box((nLinIni + 1397)*nAL  + nLinA4, (nColIni + 0320)*nAC, (nLinIni + 1491)*nAL + nLinA4, (nColIni + 0770)*nAC)
                oPrint:Say((nLinIni + 1402  + nLinA4)*nAL, (nColIni + 0330)*nAC, "50 - "+STR0029, oFont01) //"Tempo de DoeN?a"
                oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0340)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0340)*nAC)
                oPrint:Line((nLinIni + 1477)*nAL + nLinA4, (nColIni + 0340)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0426)*nAC)
                oPrint:Line((nLinIni + 1427)*nAL + nLinA4, (nColIni + 0426)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0426)*nAC)
                If aDados[nX,50,1] > 0
                    oPrint:Say((nLinIni + 1432 + nLinA4)*nAL, (nColIni + 0353)*nAC, IIF((StrZero(aDados[nX, 50,1], 2, 0))=="00","",(StrZero(aDados[nX, 50,1], 2, 0))), oFont04)
                Endif
                oPrint:Say((nLinIni + 1442 + nLinA4)*nAL, (nColIni + 0434)*nAC, "-", oFont01)
                oPrint:Line((nLinIni+ 1427)*nAL + nLinA4, (nColIni + 0447)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0447)*nAC)
                oPrint:Line((nLinIni+ 1477)*nAL + nLinA4, (nColIni + 0447)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0494)*nAC)
                oPrint:Line((nLinIni+ 1427)*nAL + nLinA4, (nColIni + 0494)*nAC, (nLinIni + 1477)*nAL + nLinA4, (nColIni + 0494)*nAC)
                oPrint:Say((nLinIni + 1432 + nLinA4)*nAL, (nColIni + 0457)*nAC, aDados[nX, 50,2], oFont04)
                oPrint:Say((nLinIni + 1442 + nLinA4)*nAL, (nColIni + 0510)*nAC, STR0030+"  "+STR0031+"  "+STR0032, oFont01) //"A-Anos"###"M-Meses"###"D-Dias"

                oPrint:Say((nLinIni + 1478 + nLinA4)*nAL, (nColIni + 0010)*nAC, STR0097, oFont01) //"Procedimentos e Exames realizados"
                oPrint:Box((nLinIni + 1526)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1766)*nAL + nLinA4, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0020)*nAC, "51 - "+STR0098, oFont01) //"Data"
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0210)*nAC, "52 - "+STR0099, oFont01) //"Hora Inicial"
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0380)*nAC, "53 - "+STR0100, oFont01) //"Hora Final"
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0540)*nAC, "54 - "+STR0074, oFont01) //"Tabela"
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0660)*nAC, "55 - "+STR0075, oFont01) //"C?digo do Procedimento"
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 0940)*nAC, "56 - "+STR0076, oFont01) //"Descri??o"
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 3675)*nAC + nColA4, "57 - "+STR0101, oFont01,,,,1) //"Qtde."
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 3795)*nAC + nColA4, "58 - "+STR0102, oFont01) //"Via"
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4040)*nAC + nColA4, "59 - "+STR0103, oFont01) //"Tec."
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4260)*nAC + nColA4, "60 - "+STR0104, oFont01,,,,1) //"% Red./Acresc."
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4500)*nAC + nColA4, "61 - "+STR0105, oFont01,,,,1) //"Valor Unitrio - R$"
                oPrint:Say((nLinIni + 1531 + nLinA4)*nAL, (nColIni + 4745)*nAC + nColA4, "62 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

                nOldLinIni := nLinIni

                if nVolta=1
                    nV1:=1
                Endif

                If ExistBlock("PLSGTISS")
                    lImpPrc := ExecBlock("PLSGTISS",.F.,.F.,{"02",lImpPrc})
                EndIf

                If lImpPrc

                    For nP1 := nV1 To nT1
                        if nVolta <> 1
                            nN:=nP1-((5*nVolta)-5)
                            oPrint:Say((nLinIni + 1566 + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
                        else
                            oPrint:Say((nLinIni + 1566 + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP1)) + " - ", oFont01)
                        endif
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0065)*nAC, IIf(Empty(aDados[nX, 51, nP1]), "", DtoC(aDados[nX, 51, nP1])), oFont04)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0210)*nAC, IIf(Empty(aDados[nX, 52, nP1]), "", Transform(aDados[nX, 52, nP1], "@R 99:99")), oFont04)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0380)*nAC, IIf(Empty(aDados[nX, 53, nP1]), "", Transform(aDados[nX, 53, nP1], "@R 99:99")), oFont04)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0540)*nAC, aDados[nX, 54, nP1], oFont04)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0660)*nAC, aDados[nX, 55, nP1], oFont04)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 0940)*nAC, SUBSTR(aDados[nX, 56, nP1],1,51), oFont04)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2445 + nColA4)*nAC, IIf(Empty(aDados[nX, 57, nP1]), "", Transform(aDados[nX, 57, nP1], "@E 9999.99")), oFont04,,,,1)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2560 + nColA4)*nAC, aDados[nX, 58, nP1], oFont04)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 2840 + nColA4)*nAC, aDados[nX, 59, nP1], oFont04)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3050 + nColA4)*nAC, IIf(Empty(aDados[nX, 60, nP1]), "", Transform(aDados[nX, 60, nP1], "@E 9999.99")), oFont04,,,,1)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3240 + nColA4)*nAC, IIf(Empty(aDados[nX, 61, nP1]), "", Transform(aDados[nX, 61, nP1], "@E 99,999,999.99")), oFont04,,,,1)
                        oPrint:Say((nLinIni + 1561 + nLinA4)*nAL, (nColIni + 3510 + nColA4)*nAC, IIf(Empty(aDados[nX, 62, nP1]), "", Transform(aDados[nX, 62, nP1], "@E 99,999,999.99")), oFont04,,,,1)
                        nLinIni += 40
                    Next nP1

                EndIf

                if nT1 < Len(aDados[nX, 55]).or. lImpnovo
                    nV1:=nP1
                    lImpnovo:=.T.
                Endif

                nLinIni := nOldLinIni

                oPrint:Box((nLinIni + 1771)*nAL + nLinA4, (nColIni + 0010)*nAC, (nLinIni + 1971)*nAL + (2*nLinA4), (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1766 + nLinA4)*nAL, (nColIni + 0020)*nAC, "63 - "+STR0107, oFont01) //"Data e Assinatura de Procedimentos em Srie"

                nOldColIni := nColIni

                if nVolta=1
                    nV2:=1
                Endif

                For nP2 := nV2 To nT2 Step 2
                    if nVolta <> 1
                        nN:=nP2-((10*nVolta)-10)
                        oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
                    Else
                        oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nP2)) + " - ", oFont01)
                    Endif
                    oPrint:Say((nLinIni + 1816 + nLinA4)*nAL, (nColIni + 0070)*nAC, DtoC(aDados[nX, 63, nP2]), oFont04)
                    oPrint:Line((nLinIni + 1861)*nAL + nLinA4,(nColIni + 0230)*nAC, (nLinIni + 1861)*nAL + nLinA4, (nColIni + 0757 + nColSoma2)*nAC)
                    if nLayout ==1
                        nColIni += 727
                    Elseif nLayout ==2
                        nColIni += 670
                    Else
                        nColIni += 630
                    Endif
                Next nP2

                nColIni := nOldColIni

                nOldColIni := nColIni

                if nVolta=1
                    nV2:=1
                Endif

                For nP2 := nV2+1 To nT2+1 Step 2
                    if nVolta <> 1
                        nN:=nP2-((10*nVolta)-10)
                        oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
                    Else
                        oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, AllTrim(Str(nP2)) + " - ", oFont01)
                    Endif
                    oPrint:Say((nLinIni + 1890 + (2*nLinA4))*nAL, (nColIni + 0070)*nAC, DtoC(aDados[nX, 63, nP2]), oFont04)
                    oPrint:Line((nLinIni + 1945)*nAL + (2*nLinA4),(nColIni + 0230)*nAC, (nLinIni + 1945)*nAL + (2*nLinA4), (nColIni + 0757 + nColSoma2)*nAC)
                    if nLayout ==1
                        nColIni += 727
                    Elseif nLayout ==2
                        nColIni += 670
                    Else
                        nColIni += 630
                    Endif
                Next nP2

                nColIni := nOldColIni

                if nT2 < Len(aDados[nX, 63]).or. lImpnovo
                    nV2:=nP2-1
                    lImpnovo:=.T.
                Endif

                oPrint:Box((nLinIni + 1976)*nAL + (2*nLinA4), (nColIni + 0010)*nAC, (nLinIni + 2136)*nAL + (3*nLinA4), (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1950 + (2*nLinA4))*nAL, (nColIni + 0020)*nAC, "64 - "+STR0056, oFont01) //"Observao"

                If nModulo == 51    //Gesto Hospitalar
                    if nVolta=1
                        nV1:=1
                    Endif

                    nLin := 1988
                    For nP1 := nV1 To nT1
                        if nVolta <> 1
                            nN:=nP1-((5*nVolta)-5)
                            oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
                        else
                            oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP1)) + " - ", oFont01)
                        endif
                        oPrint:Say((nLinIni + nLin + nLinA4)*nAL, (nColIni + 0065)*nAC, aDados[nX, 64, nP1], oFont04)

                        nLin += 35
                    Next nP1

                    if nT1 < Len(aDados[nX, 64]).or. lImpnovo
                        nV1:=nP1
                        lImpnovo:=.T.
                    Endif
                Else
                    nLin := 1991

                    For nI := 1 To MlCount(aDados[nX, 64], 130)
                        cObs := MemoLine(aDados[nX, 64], 130, nI)
                        oPrint:Say((nLinIni + nLin + (2*nLinA4))*nAL, (nColIni + 0030)*nAC, cObs, oFont04)
                        nLin += 35
                    Next nI

                Endif

                oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 0010)*nAC			 		, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 0591 + (nColA4/7) )*nAC)
                oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 0020)*nAC				 	, "65 - "+STR0108, oFont01) //"Total Procedimentos R$"
                oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 0220 + (nColA4/6))*nAC 	, Transform(aDados[nX, 65,nProx], "@E 999,999,999.99"), oFont04,,,,1)
                oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 0596 + (nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 1117 + 2*(nColA4/7))*nAC)
                oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 0606 + (nColA4/7))*nAC	, "66 - "+STR0109, oFont01) //"Total Taxas e Aluguis R$"
                oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 0806 + 2*(nColA4/6))*nAC	, Transform(aDados[nX, 66,nProx], "@E 999,999,999.99"), oFont04,,,,1)
                oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 1122 + 2*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 1643  + 3*(nColA4/7))*nAC)
                oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 1132 + 2*(nColA4/7))*nAC	, "67 - "+STR0110, oFont01) //"Total Materiais R$"
                oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 1332 + 3*(nColA4/6))*nAC	, Transform(aDados[nX, 67,nProx], "@E 999,999,999.99"), oFont04,,,,1)
                oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 1648 + 3*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 2169 + 4*(nColA4/7) )*nAC)
                oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 1658 + 3*(nColA4/7))*nAC	, "68 - "+STR0111, oFont01) //"Total Medicamentos R$"
                oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 1858 + 4*(nColA4/6))*nAC	, Transform(aDados[nX, 68,nProx], "@E 999,999,999.99"), oFont04,,,,1)
                oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 2174 + 4*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 2695 + 5*(nColA4/7) )*nAC)
                oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 2184 + 4*(nColA4/7))*nAC	, "69 - "+STR0112, oFont01) //"Total Dirias R$"
                oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 2384 + 5*(nColA4/6))*nAC	, Transform(aDados[nX, 69,nProx], "@E 999,999,999.99"), oFont04,,,,1)
                oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 2700 + 5*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 3221 + 6*(nColA4/7) )*nAC)
                oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 2710 + 5*(nColA4/7))*nAC	, "70 - "+STR0113, oFont01) //"Total Gases Medicinais R$"
                oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 2910 + 6*(nColA4/6))*nAC	, Transform(aDados[nX, 70,nProx], "@E 999,999,999.99"), oFont04,,,,1)
                oPrint:Box((nLinIni + 2141)*nAL + (3*nLinA4), (nColIni + 3226 + 6*(nColA4/7))*nAC	, (nLinIni + 2235)*nAL + (3*nLinA4), (nColIni + 3755  + 7*(nColA4/7))*nAC)
                oPrint:Say((nLinIni + 2159)*nAL + (3*nLinA4), (nColIni + 3236 + 6*(nColA4/7))*nAC	, "71 - "+STR0114, oFont01) //"Total Geral da Guia R$"
                oPrint:Say((nLinIni + 2210)*nAL + (3*nLinA4), (nColIni + 3436 + 7*(nColA4/6))*nAC	, Transform(aDados[nX, 71,nProx], "@E 999,999,999.99"), oFont04,,,,1)


                oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 0010)*nAC					, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 0986 + (nColA4/4) )*nAC)
                oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 0020)*nAC 				, "86 - "+STR0115, oFont01) //"Data e Assinatura do Solicitante"
                oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 0030)*nAC 				, DtoC(aDados[nX, 86]), oFont04)
                oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 0991  +(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 1907 + 2*(nColA4/4) )*nAC)
                oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 1001  +(nColA4/4))*nAC	, "87 - "+STR0116, oFont01) //"Data e Assinatura do Responsvel pela Autoriza??o"
                oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 1011  +(nColA4/4))*nAC	, DtoC(aDados[nX, 87]), oFont04)
                oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 1912  +2*(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 2828 + 3*(nColA4/4) )*nAC)
                oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 1922  +2*(nColA4/4))*nAC	, "88 - "+STR0058, oFont01) //"Data e Assinatura do Benefici?rio ou Responsvel"
                oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 1932  +2*(nColA4/4))*nAC	, DtoC(aDados[nX, 88]), oFont04)
                oPrint:Box((nLinIni + 2240)*nAL + (3*nLinA4), (nColIni + 2833  +3*(nColA4/4))*nAC	, (nLinIni + 2385)*nAL + (4*nLinA4), (nColIni + 3750 + 4*(nColA4/4) )*nAC)
                oPrint:Say((nLinIni + 2185 + (4*nLinA4))*nAL, (nColIni + 2843  +3*(nColA4/4))*nAC	, "89 - "+STR0117, oFont01) //"Data e Assinatura do Prestador Executante"
                oPrint:Say((nLinIni + 2225 + (4*nLinA4))*nAL, (nColIni + 2853  +3*(nColA4/4))*nAC	, DtoC(aDados[nX, 89]), oFont04)

                //
                //Finaliza a pagina
                //
                oPrint:EndPage()
                //
                //Verso da Guia - Inicia uma nova pagina
                //
                oPrint:StartPage()
                //??
                //Box Principal
                //
                oPrint:Box((nLinIni + 0000)*nAL, (nColIni + 0000)*nAC, (nLinIni + nLinMax)*nAL, (nColIni + nColMax)*nAC)

                oPrint:Box((nLinIni + 0010)*nAL, (nColIni + 0010)*nAC			, (nLinIni + 0490)*nAL, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 0030)*nAL, (nColIni + 0020)*nAC			, STR0118, oFont01) //"OPM Solicitados"
                oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0020)*nAC			, "72 - "+STR0074, oFont01) //"Tabela"
                oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0160)*nAC			, "73 - "+STR0119, oFont01) //"C?digo do OPM"
                oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 0410)*nAC		 	, "74 - "+STR0120, oFont01) //"Descri??o OPM"
                oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 2400 + nColA4)*nAC	, "75 - "+STR0101, oFont01,,,,1) //"Qtde."
                oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 2550 + nColA4)*nAC	, "76 - "+STR0121, oFont01) //"Fabricante"
                oPrint:Say((nLinIni + 0065)*nAL, (nColIni + 3530 + nColA4)*nAC	, "77 - "+STR0105, oFont01,,,,1) //"Valor Unitrio - R$"

                nOldLinIni := nLinIni

                if nVolta=1
                    nV3:=1
                Endif

                For nP3 := nV3 To nT3
                    if nVolta <> 1
                        nN:=nP3-((9*nVolta)-9)
                        oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
                    Else
                        oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP3)) + " - ", oFont01)
                    Endif
                    oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 72, nP3], oFont04)
                    oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0160)*nAC			, aDados[nX, 73, nP3], oFont04)
                    oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 0410)*nAC			, aDados[nX, 74, nP3], oFont04)
                    oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 2400 + nColA4)*nAC	, IIf(Empty(aDados[nX, 75, nP3]), "", Transform(aDados[nX, 75, nP3], "@E 9999.99")), oFont04,,,,1)
                    oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 2550 + nColA4)*nAC	, aDados[nX, 76, nP3], oFont04)
                    oPrint:Say((nLinIni + 0100)*nAL, (nColIni + 3550 + nColA4)*nAC	, IIf(Empty(aDados[nX, 77, nP3]), "", Transform(aDados[nX, 77, nP3], "@E 999,999,999.99")), oFont04,,,,1)
                    nLinIni += 40
                Next nP3

                nLinIni := nOldLinIni

                if nT3 < Len(aDados[nX, 73]).or. lImpnovo
                    nV3:=nP3
                    lImpnovo:=.T.
                Endif

                oPrint:Box((nLinIni + 0495)*nAL, (nColIni + 0010)*nAC			, (nLinIni + 0990)*nAL, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 0515)*nAL, (nColIni + 0020)*nAC			, STR0122, oFont01) //"OPM Utilizados"
                oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0020)*nAC			, "78 - "+STR0074, oFont01) //"Tabela"
                oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0160)*nAC			, "79 - "+STR0119, oFont01) //"C?digo do OPM"
                oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 0410)*nAC			, "80 - "+STR0120, oFont01) //"Descri??o OPM"
                oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 2400 + nColA4)*nAC	, "81 - "+STR0101, oFont01,,,,1) //"Qtde."
                oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 2550 + nColA4)*nAC	, "82 - "+STR0123, oFont01) //"C?digo de Barras"
                oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 3250 + nColA4)*nAC	, "83 - "+STR0105, oFont01,,,,1) //"Valor Unitrio - R$"
                oPrint:Say((nLinIni + 0550)*nAL, (nColIni + 3560 + nColA4)*nAC	, "84 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

                nOldLinIni := nLinIni

                if nVolta=1
                    nV4:=1
                Endif

                For nP4 := nV4 To nT4
                    if nVolta <> 1
                        nN:=nP4-((9*nVolta)-9)
                        oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nN)) + " - ", oFont01)
                    Else
                        oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0020)*nAC, AllTrim(Str(nP4)) + " - ", oFont01)
                    Endif
                    oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0065)*nAC			, aDados[nX, 78, nP4], oFont04)
                    oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0160)*nAC			, aDados[nX, 79, nP4], oFont04)
                    oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 0410)*nAC			, aDados[nX, 80, nP4], oFont04)
                    oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 2400 + nColA4)*nAC	, IIf(Empty(aDados[nX, 81, nP4]), "", Transform(aDados[nX, 81, nP4], "@E 9999.99")), oFont04,,,,1)
                    oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 2550 + nColA4)*nAC	, aDados[nX, 82, nP4], oFont04)
                    oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 3260 + nColA4)*nAC	, IIf(Empty(aDados[nX, 83, nP4]), "", Transform(aDados[nX, 83, nP4], "@E 999,999,999.99")), oFont04,,,,1)
                    oPrint:Say((nLinIni + 0585)*nAL, (nColIni + 3540 + nColA4)*nAC	, IIf(Empty(aDados[nX, 84, nP4]), "", Transform(aDados[nX, 84, nP4], "@E 999,999,999.99")), oFont04,,,,1)
                    nLinIni += 40
                Next nP4

                nLinIni := nOldLinIni

                nTotOPM:=nV4

                if nT4 < Len(aDados[nX, 79]).or. lImpnovo
                    nV4:=nP4
                    lImpnovo:=.T.
                Endif

                oPrint:Box((nLinIni + 1005)*nAL, (nColIni + 3395 + nColA4)*nAC, (nLinIni + 1089)*nAL, (nColIni + 3755 + nColA4)*nAC)
                oPrint:Say((nLinIni + 1025)*nAL, (nColIni + 3405 + nColA4)*nAC, "85 - "+STR0124, oFont01) //"Total OPM R$"
                oPrint:Say((nLinIni + 1055)*nAL, (nColIni + 3555 + nColA4)*nAC, Transform(aDados[nX, 85,nProx], "@E 999,999,999.99"), oFont04,,,,1)
                //
                //Finaliza a pagina
                //
                oPrint:EndPage()

            Next nX
        EndDo

        If lGerTXT .And. !lWeb
            //
            //Imprime Relatorio
            //
            oPrint:Print()
        Else
            //
            //Visualiza impressao grafica antes de imprimir
            //
            oPrint:lViewPDF := .F.
            oPrint:Print()
            PLSCHKRP(cPathSrvJ, cFileName)
            FreeObj(oPrint)
            //Alert("Arquivo gerado Em: "+cPathSrvJ+"\"+cFileName)
        EndIf

    EndIf

Return(cFileName)

//-------------------------------------------------------------------
/*/{Protheus.doc} function R234RINT
description Rotina baseada na função padrão PLSTISS4
@author  author
@since   date
@version version
@parametros
    aDados - Array com as informa??es do relat?rio
    lGerTXT - Define se imprime direto sem passar pela tela
              de configuracao/preview do relatorio
    nLayout - Define o formato de papl para impressao:
        1 - Formato Ofcio II (216x330mm)
        2 - Formato A4 (210x297mm)
        3 - Formato Carta (216x279mm)
/*/
//-------------------------------------------------------------------

Static Function R234RINT(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW)

    Local nLinMax
    Local nColMax
    Local nLinIni := 0		// Linha Lateral (inicial) Esquerda
    Local nColIni := 0		// Coluna Lateral (inicial) Esquerda
    Local nColA4  := 0
    Local nCol2A4 := 0
    Local cFileLogo
    Local nLin
    Local nOldLinIni
    Local nI, nJ, nX, nN
    Local cObs
    Local oFont01
    Local oFont02n
    Local oFont03n
    Local oFont04
    Local lImpnovo:=.T.
    Local nVolta  := 0
    Local nP   	  := 0
    Local nP1     := 0
    Local nP2     := 0
    Local nP3     := 0
    Local nP4     := 0
    Local nP5     := 0
    Local nT      := 0
    Local nT1     := 0
    Local nT2     := 0
    Local nT3     := 0
    Local nT4     := 0
    Local nAte    :=15
    Local nAte1   :=20
    Local nAte2   := 5
    LOCAL cRel    := "GUIA_INTERNACAO_" + adados[01][84]
    PRIVATE cPathSrvJ := GetNewPar( "MV_MAXPDF" , "C:\EXPORTA_GUIAS_LOTE\" )

    DEFAULT lWeb		:= .T.
    DEFAULT cPathRelW 	:= ""
    Default lGerTXT := .F.
    Default nLayout := 2
    Default cLogoGH := ''
    Default aDados := {}

    If Len(aDados) > 0

        oFont01		:= TFont():New("Arial",  6,  6, , .F., , , , .T., .F.) // Normal

        //cFileName := UPPER(cRel)+UPPER(CriaTrab(NIL,.F.))+".pdf"
        cFileName := UPPER(cRel)+".pdf"
        cPathSrvJ := AjuBarPath(cPathSrvJ)

        if nLayout == 1 // Oficio 2
            oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
            oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
        Else  // Papl A4 ou Carta
            oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
            oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
        Endif

        oPrint := 	FwMsPrinter():New(cFileName, IMP_PDF, .T., cPathSrvJ, .T.)
        oPrint:setDevice(IMP_PDF)
        oPrint:SetResolution(72)
        oPrint:SetLandscape()

        oPrint:cPathPDF := cPathSrvJ


        //oPrint:Setup()

        if nLayout == 2
            nLinMax	:=	2375
            nColMax	:=	3370 //3365
            oPrint:SetPaperSize(9)// Papl A4
        Elseif nLayout == 3
            nLinMax	:=	2435
            nColMax	:=	3175
            oPrint:SetPaperSize(1)// Papl Carta
        Else
            nLinMax := 2435
            nColMax := 3705	//3765
            oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
        Endif

        While lImpnovo

            lImpnovo:=.F.
            nVolta  += 1
            nAte    += nP
            nAte1   += nP1
            nAte2   += nP4


            For nX := 1 To Len(aDados)

                If ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
                    Loop
                EndIf

                For nI := 45 To 56
                    If Len(aDados[nX, nI]) < nAte
                        For nJ := Len(aDados[nX, nI]) + 1 To nAte
                            If AllTrim(Str(nI)) $ "45"
                                aAdd(aDados[nX, nI], StoD(""))
                            ElseIf AllTrim(Str(nI)) $ "51,54,55,56"
                                aAdd(aDados[nX, nI], 0)
                            Else
                                aAdd(aDados[nX, nI], "")
                            EndIf
                        Next nJ
                    EndIf
                Next nI

                For nI := 57 To 64
                    If Len(aDados[nX, nI]) < nAte1
                        For nJ := Len(aDados[nX, nI]) + 1 To nAte1
                            aAdd(aDados[nX, nI], "")
                        Next nJ
                    EndIf
                Next nI

                For nI := 65 To 71
                    If Len(aDados[nX, nI]) < nAte2
                        For nJ := Len(aDados[nX, nI]) + 1 To nAte2
                            If AllTrim(Str(nI)) $ "68,70,71"
                                aAdd(aDados[nX, nI], 0)
                            Else
                                aAdd(aDados[nX, nI], "")
                            EndIf
                        Next nJ
                    EndIf
                Next nI

                nLinIni := 000
                nColIni := 000
                nColA4  := 000
                nCol2A4 := 000

                oPrint:StartPage()		// Inicia uma nova pagina
                //??
                //Box Principal
                //
                oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

                //??
                //Carrega e Imprime Logotipo da Empresa
                //
                //next nx /*
                fLogoEmp(@cFileLogo,, cLogoGH)

                If File(cFilelogo)
                    oPrint:SayBitmap(nLinIni + 0050, nColIni + 0020, cFileLogo, 400, 090) 		// Tem que estar abaixo do RootPath
                EndIf

                If nLayout == 2 // Papl A4
                    nColA4    := -0335
                    nCol2A4   := -0180
                Elseif nLayout == 3// Carta
                    nColA4    := -0530
                    nCol2A4   := -0180
                Endif

                oPrint:Say(nLinIni + 0080, nColIni + 1852 + IIf(nLayout == 2 .Or. nLayout == 3,nColA4+230,nColA4), STR0169, oFont02n,,,, 2) //"GUIA DE RESUMO DE Interna??o"
                oPrint:Say(nLinIni + 0090, nColIni + 3000 + nColA4, "2 - "+STR0002, oFont01) //"N?"
                oPrint:Say(nLinIni + 0070, nColIni + 3096 + nColA4, aDados[nX, 02], oFont03n)

                //nLinIni += 60
                oPrint:Box(nLinIni + 0175, nColIni + 0010, nLinIni + 0269, nColIni + 0315)
                oPrint:Say(nLinIni + 0180, nColIni + 0020, "1 - "+STR0003, oFont01) //"Registro ANS"
                oPrint:Say(nLinIni + 0210, nColIni + 0030, aDados[nX, 01], oFont04)
                oPrint:Box(nLinIni + 0175, nColIni + 0320, nLinIni + 0269, nColIni + 1035)
                oPrint:Say(nLinIni + 0180, nColIni + 0330, "3 - "+STR0170, oFont01) //"N? Guia de Solicita??o"
                oPrint:Say(nLinIni + 0210, nColIni + 0340, aDados[nX, 03], oFont04)
                oPrint:Box(nLinIni + 0175, nColIni + 1040, nLinIni + 0269, nColIni + 1345)
                oPrint:Say(nLinIni + 0180, nColIni + 1050, "4 - "+STR0062, oFont01) //"Data da Autoriza??o"
                oPrint:Say(nLinIni + 0210, nColIni + 1060, DtoC(aDados[nX, 04]), oFont04)
                oPrint:Box(nLinIni + 0175, nColIni + 1350, nLinIni + 0269, nColIni + 1755)
                oPrint:Say(nLinIni + 0180, nColIni + 1360, "5 - "+STR0063, oFont01) //"Senha"
                oPrint:Say(nLinIni + 0210, nColIni + 1370, aDados[nX, 05], oFont04)
                oPrint:Box(nLinIni + 0175, nColIni + 1760, nLinIni + 0269, nColIni + 2165)
                oPrint:Say(nLinIni + 0180, nColIni + 1770, "6 - "+STR0064, oFont01) //"Data Validade da Senha"
                oPrint:Say(nLinIni + 0210, nColIni + 1780, DtoC(aDados[nX, 06]), oFont04)
                oPrint:Box(nLinIni + 0175, nColIni + 2170, nLinIni + 0269, nColIni + 2465)
                oPrint:Say(nLinIni + 0180, nColIni + 2180, "7 - "+STR0004, oFont01) //"Data de Emiss?o da Guia"
                oPrint:Say(nLinIni + 0210, nColIni + 2190, DtoC(aDados[nX, 07]), oFont04)

                //nLinIni += 20
                oPrint:Say(nLinIni + 0274, nColIni + 0010, STR0005, oFont01) //"Dados do Benefici?rio"
                oPrint:Box(nLinIni + 0304, nColIni + 0010, nLinIni + 0398, nColIni + 0425)
                oPrint:Say(nLinIni + 0309, nColIni + 0020, "8 - "+STR0006, oFont01) //"N?mero da Carteira"
                oPrint:Say(nLinIni + 0339, nColIni + 0030, aDados[nX, 08], oFont04)
                oPrint:Box(nLinIni + 0304, nColIni + 0430, nLinIni + 0398, nColIni + 1572)
                oPrint:Say(nLinIni + 0309, nColIni + 0440, "9 - "+STR0007, oFont01) //"Plano"
                oPrint:Say(nLinIni + 0339, nColIni + 0450, aDados[nX, 09], oFont04)
                oPrint:Box(nLinIni + 0304, nColIni + 1577, nLinIni + 0398, nColIni + 1835)
                oPrint:Say(nLinIni + 0309, nColIni + 1587, "10 - "+STR0008, oFont01) //"Validade da Carteira"
                oPrint:Say(nLinIni + 0339, nColIni + 1597, DtoC(aDados[nX, 10]), oFont04)

                oPrint:Box(nLinIni + 0403, nColIni + 0010, nLinIni + 0497, nColIni + 3090 + nColA4)
                oPrint:Say(nLinIni + 0408, nColIni + 0020, "11 - "+STR0009, oFont01) //"Nome"
                oPrint:Say(nLinIni + 0438, nColIni + 0030, aDados[nX, 11], oFont04)
                oPrint:Box(nLinIni + 0403, nColIni + 3095 + nColA4, nLinIni + 0497, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 0408, nColIni + 3105 + nColA4, "12 - "+STR0010, oFont01) //"N?mero do Cart?o Nacional de Sa?de"
                oPrint:Say(nLinIni + 0438, nColIni + 3115 + nColA4, aDados[nX, 12], oFont04)

                //nLinIni += 20
                oPrint:Say(nLinIni + 0502, nColIni + 0010, STR0079, oFont01) //"Dados do Contratado Executante"
                oPrint:Box(nLinIni + 0532, nColIni + 0010, nLinIni + 0626, nColIni + 0426)
                oPrint:Say(nLinIni + 0537, nColIni + 0020, "13 - "+STR0129, oFont01) //"C?digo na Operadora / CNPJ"
                oPrint:Say(nLinIni + 0567, nColIni + 0030, aDados[nX, 13], oFont04)
                oPrint:Box(nLinIni + 0532, nColIni + 0431, nLinIni + 0626, nColIni + 2245)
                oPrint:Say(nLinIni + 0537, nColIni + 0441, "14 - "+STR0013, oFont01) //"Nome do Contratado"
                oPrint:Say(nLinIni + 0567, nColIni + 0451, SubStr(aDados[nX, 14], 1, 65), oFont04)
                oPrint:Box(nLinIni + 0532, nColIni + 2250, nLinIni + 0626, nColIni + 2460)
                oPrint:Say(nLinIni + 0537, nColIni + 2260, "15 - "+STR0014, oFont01) //"C?digo CNES"
                oPrint:Say(nLinIni + 0567, nColIni + 2270, aDados[nX, 15], oFont04)

                oPrint:Box(nLinIni + 0631, nColIni + 0010, nLinIni + 0725, nColIni + 0132)
                oPrint:Say(nLinIni + 0636, nColIni + 0020, "16 - "+STR0015, oFont01) //"T.L."
                oPrint:Say(nLinIni + 0666, nColIni + 0030, aDados[nX, 16], oFont04)
                oPrint:Box(nLinIni + 0631, nColIni + 0137, nLinIni + 0725, nColIni + 2032 + nColA4)
                oPrint:Say(nLinIni + 0636, nColIni + 0147, "17-18-19 - "+STR0016, oFont01) //"Logradouro - N?mero - Complemento"
                oPrint:Say(nLinIni + 0666, nColIni + 0157, SubStr(AllTrim(aDados[nX, 17]) + IIf(!Empty(aDados[nX, 18]), ", ","") + AllTrim(aDados[nX, 18]) + IIf(!Empty(aDados[nX, 19]), " - ","") + AllTrim(aDados[nX, 19]), 1, 76), oFont04)
                oPrint:Box(nLinIni + 0631, nColIni + 2037 + nColA4, nLinIni + 0725, nColIni + 3165 + nColA4)
                oPrint:Say(nLinIni + 0636, nColIni + 2047 + nColA4, "20 - "+STR0017, oFont01) //"Munic?pio"
                oPrint:Say(nLinIni + 0666, nColIni + 2057 + nColA4, SubStr(aDados[nX, 20], 1, 39), oFont04)
                oPrint:Box(nLinIni + 0631, nColIni + 3170 + nColA4, nLinIni + 0725, nColIni + 3269 + nColA4)
                oPrint:Say(nLinIni + 0636, nColIni + 3180 + nColA4, "21 - "+STR0018, oFont01) //"UF"
                oPrint:Say(nLinIni + 0666, nColIni + 3190 + nColA4, aDados[nX, 21], oFont04)
                oPrint:Box(nLinIni + 0631, nColIni + 3274 + nColA4, nLinIni + 0725, nColIni + 3502 + nColA4)
                oPrint:Say(nLinIni + 0636, nColIni + 3284 + nColA4, "22 - "+STR0171, oFont01) //"C?d. IBGE"
                oPrint:Say(nLinIni + 0666, nColIni + 3294 + nColA4, aDados[nX, 22], oFont04)
                oPrint:Box(nLinIni + 0631, nColIni + 3507 + nColA4, nLinIni + 0725, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 0636, nColIni + 3517 + nColA4, "23 - "+STR0020, oFont01) //"CEP"
                oPrint:Say(nLinIni + 0666, nColIni + 3527 + nColA4, aDados[nX, 23], oFont04)

                nLinIni += 20
                oPrint:Say(nLinIni + 0730, nColIni + 0010, STR0172, oFont01) //"Dados da Interna??o"
                oPrint:Box(nLinIni + 0760, nColIni + 0010, nLinIni + 0854, nColIni + 0465)
                oPrint:Say(nLinIni + 0765, nColIni + 0020, "24 - "+STR0131, oFont01) //"Carter da Interna??o"
                oPrint:Line(nLinIni + 0790, nColIni + 0030 + nColA4, nLinIni + 0837, nColIni + 0030 + nColA4)
                oPrint:Line(nLinIni + 0837, nColIni + 0030 + nColA4, nLinIni + 0837, nColIni + 0077 + nColA4)
                oPrint:Line(nLinIni + 0790, nColIni + 0077 + nColA4, nLinIni + 0837, nColIni + 0077 + nColA4)
                oPrint:Say(nLinIni + 0795, nColIni + 0043, aDados[nX, 24], oFont04)
                oPrint:Say(nLinIni + 0805, nColIni + 0090, STR0132+"  "+STR0133, oFont01) //"E - Eletiva"###"U - Urg?ncia/Emergncia"
                oPrint:Line(nLinIni + 0792, nColIni + 0030, nLinIni + 0837, nColIni + 0030)
                oPrint:Line(nLinIni + 0837, nColIni + 0030, nLinIni + 0837, nColIni + 0077)
                oPrint:Line(nLinIni + 0792, nColIni + 0077, nLinIni + 0837, nColIni + 0077)
                oPrint:Box(nLinIni + 0760, nColIni + 0470, nLinIni + 0854, nColIni + 1445 + nColA4)
                oPrint:Say(nLinIni + 0765, nColIni + 0480, "25 - "+STR0173, oFont01) //"Tipo Acomodao Autorizada"
                oPrint:Say(nLinIni + 0795, nColIni + 0490, aDados[nX, 25, 1] + "-" + aDados[nX, 25, 2], oFont04)
                oPrint:Box(nLinIni + 0760, nColIni + 1450 + nColA4, nLinIni + 0854, nColIni + 1865 + nColA4)
                oPrint:Say(nLinIni + 0765, nColIni + 1460 + nColA4, "26 - "+STR0174, oFont01) //"Data/Hora da Interna??o"
                oPrint:Say(nLinIni + 0795, nColIni + 1470 + nColA4, DtoC(aDados[nX, 26,1]) + " " + Transform(aDados[nX, 26,2], "@R 99:99"), oFont04)
                oPrint:Box(nLinIni + 0760, nColIni + 1870 + nColA4, nLinIni + 0854, nColIni + 2285 + nColA4)
                oPrint:Say(nLinIni + 0765, nColIni + 1880 + nColA4, "27 - "+STR0175, oFont01) //"Data/Hora da Sa?da Interna??o"
                oPrint:Say(nLinIni + 0795, nColIni + 1890 + nColA4, DtoC(aDados[nX, 27,1]) + " " + Transform(aDados[nX, 27,2], "@R 99:99"), oFont04)
                oPrint:Box(nLinIni + 0760, nColIni + 2290 + nColA4, nLinIni + 0854, nColIni + 3055 + nColA4)
                oPrint:Say(nLinIni + 0765, nColIni + 2300 + nColA4, "28 - "+STR0176, oFont01) //"Tipo Interna??o"
                oPrint:Line(nLinIni + 0790, nColIni + 2310 + nColA4, nLinIni + 0837, nColIni + 2310 + nColA4)
                oPrint:Line(nLinIni + 0837, nColIni + 2310 + nColA4, nLinIni + 0837, nColIni + 2357 + nColA4)
                oPrint:Line(nLinIni + 0790, nColIni + 2357 + nColA4, nLinIni + 0837, nColIni + 2357 + nColA4)
                oPrint:Say(nLinIni + 0795, nColIni + 2323 + nColA4, aDados[nX, 28], oFont04)
                oPrint:Say(nLinIni + 0805, nColIni + 2370 + nColA4, "1 - "+STR0135+"  "+"2 - "+STR0136+"  "+"3 - "+STR0137+"  "+"4 - "+STR0138+"  "+"5 - "+STR0139, oFont01) //"Cl?nica"###"Cir?rgica"###"Obst?trica"###"Pedi?trica"###"Psiqui?trica"
                oPrint:Box(nLinIni + 0760, nColIni + 3060 + nColA4, nLinIni + 0854, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 0765, nColIni + 3070 + nColA4, "29 - "+STR0140, oFont01) //"Regime de Interna??o"
                oPrint:Line(nLinIni + 0790, nColIni + 3080 + nColA4, nLinIni + 0837, nColIni + 3080 + nColA4)
                oPrint:Line(nLinIni + 0837, nColIni + 3080 + nColA4, nLinIni + 0837, nColIni + 3127 + nColA4)
                oPrint:Line(nLinIni + 0790, nColIni + 3127 + nColA4, nLinIni + 0837, nColIni + 3127 + nColA4)
                oPrint:Say(nLinIni + 0795, nColIni + 3093 + nColA4, aDados[nX, 29], oFont04)
                oPrint:Say(nLinIni + 0805, nColIni + 3140 + nColA4, "1 - "+STR0141+"  "+"2 - "+STR0142+"  "+"3- "+STR0143, oFont01) //"Hospitalar"###"Hospital-dia"###"Domiciliar"

                oPrint:Box(nLinIni + 0859, nColIni + 0010, nLinIni + 0948, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 0864, nColIni + 0020, '30 - '+STR0177, oFont01) //'Interna??o Obst?trica - (selecione mais de um se necess?rio com "X")'
                oPrint:Line(nLinIni + 0889, nColIni + 0030, nLinIni + 0936, nColIni + 0030)
                oPrint:Line(nLinIni + 0936, nColIni + 0030, nLinIni + 0936, nColIni + 0077)
                oPrint:Line(nLinIni + 0889, nColIni + 0077, nLinIni + 0936, nColIni + 0077)
                oPrint:Say(nLinIni + 0894, nColIni + 0043, aDados[nX, 30,1], oFont04)
                oPrint:Say(nLinIni + 0904, nColIni + 0090, "- "+STR0178, oFont01) //"Em gesta??o"
                oPrint:Line(nLinIni + 0889, nColIni + 0240, nLinIni + 0936, nColIni + 0240)
                oPrint:Line(nLinIni + 0936, nColIni + 0240, nLinIni + 0936, nColIni + 0287)
                oPrint:Line(nLinIni + 0889, nColIni + 0287, nLinIni + 0936, nColIni + 0287)
                oPrint:Say(nLinIni + 0894, nColIni + 0253, aDados[nX, 30,2], oFont04)
                oPrint:Say(nLinIni + 0904, nColIni + 0300, "- "+STR0179, oFont01) //"Aborto"
                oPrint:Line(nLinIni + 0889, nColIni + 0390, nLinIni + 0936, nColIni + 0390)
                oPrint:Line(nLinIni + 0936, nColIni + 0390, nLinIni + 0936, nColIni + 0437)
                oPrint:Line(nLinIni + 0889, nColIni + 0437, nLinIni + 0936, nColIni + 0437)
                oPrint:Say(nLinIni + 0894, nColIni + 0403, aDados[nX, 30,3], oFont04)
                oPrint:Say(nLinIni + 0904, nColIni + 0450, "- "+STR0180, oFont01) //"Transtorno materno relacionado a gravidez"
                oPrint:Line(nLinIni + 0889, nColIni + 0880, nLinIni + 0936, nColIni + 0880)
                oPrint:Line(nLinIni + 0936, nColIni + 0880, nLinIni + 0936, nColIni + 0927)
                oPrint:Line(nLinIni + 0889, nColIni + 0927, nLinIni + 0936, nColIni + 0927)
                oPrint:Say(nLinIni + 0894, nColIni + 0893, aDados[nX, 30,4], oFont04)
                oPrint:Say(nLinIni + 0904, nColIni + 0940, "- "+STR0181, oFont01) //""Complic. Puerp?rio""
                oPrint:Line(nLinIni + 0889, nColIni + 1160, nLinIni + 0936, nColIni + 1160)
                oPrint:Line(nLinIni + 0936, nColIni + 1160, nLinIni + 0936, nColIni + 1207)
                oPrint:Line(nLinIni + 0889, nColIni + 1207, nLinIni + 0936, nColIni + 1207)
                oPrint:Say(nLinIni + 0894, nColIni + 1173, aDados[nX, 30,5], oFont04)
                oPrint:Say(nLinIni + 0904, nColIni + 1220, "- "+STR0182, oFont01) //"Atend. ao RN na sala de parto"
                oPrint:Line(nLinIni + 0889, nColIni + 1540, nLinIni + 0936, nColIni + 1540)
                oPrint:Line(nLinIni + 0936, nColIni + 1540, nLinIni + 0936, nColIni + 1587)
                oPrint:Line(nLinIni + 0889, nColIni + 1587, nLinIni + 0936, nColIni + 1587)
                oPrint:Say(nLinIni + 0894, nColIni + 1553, aDados[nX, 30,6], oFont04)
                oPrint:Say(nLinIni + 0904, nColIni + 1600, "- "+STR0183, oFont01) //"Complicac?o Neonatal"
                oPrint:Line(nLinIni + 0889, nColIni + 1850, nLinIni + 0936, nColIni + 1850)
                oPrint:Line(nLinIni + 0936, nColIni + 1850, nLinIni + 0936, nColIni + 1897)
                oPrint:Line(nLinIni + 0889, nColIni + 1897, nLinIni + 0936, nColIni + 1897)
                oPrint:Say(nLinIni + 0894, nColIni + 1863, aDados[nX, 30,7], oFont04)
                oPrint:Say(nLinIni + 0904, nColIni + 1910, "- "+STR0184, oFont01) //"Bx. Peso < 2,5 Kg"
                oPrint:Line(nLinIni + 0889, nColIni + 2130, nLinIni + 0936, nColIni + 2130)
                oPrint:Line(nLinIni + 0936, nColIni + 2130, nLinIni + 0936, nColIni + 2177)
                oPrint:Line(nLinIni + 0889, nColIni + 2177, nLinIni + 0936, nColIni + 2177)
                oPrint:Say(nLinIni + 0894, nColIni + 2143, aDados[nX, 30,8], oFont04)
                oPrint:Say(nLinIni + 0904, nColIni + 2190, "- "+STR0185, oFont01) //"Parto Ces?reo"
                oPrint:Line(nLinIni + 0889, nColIni + 2380, nLinIni + 0936, nColIni + 2380)
                oPrint:Line(nLinIni + 0936, nColIni + 2380, nLinIni + 0936, nColIni + 2427)
                oPrint:Line(nLinIni + 0889, nColIni + 2427, nLinIni + 0936, nColIni + 2427)
                oPrint:Say(nLinIni + 0894, nColIni + 2393, aDados[nX, 30,9], oFont04)
                oPrint:Say(nLinIni + 0904, nColIni + 2440, "- "+STR0186, oFont01) //"Parto Normal"

                oPrint:Box(nLinIni + 0953, nColIni + 0010, nLinIni + 1047, nColIni + 1060)
                oPrint:Say(nLinIni + 0958, nColIni + 0020, "31 - "+STR0187, oFont01) //"Se ?bito em mulher"
                oPrint:Line(nLinIni + 0983, nColIni + 0030, nLinIni + 1030, nColIni + 0030)
                oPrint:Line(nLinIni + 1030, nColIni + 0030, nLinIni + 1030, nColIni + 0077)
                oPrint:Line(nLinIni + 0983, nColIni + 0077, nLinIni + 1030, nColIni + 0077)
                oPrint:Say(nLinIni + 0988, nColIni + 0043, aDados[nX, 31], oFont04)
                oPrint:Say(nLinIni + 0998, nColIni + 0090, "1 - "+STR0188+"  "+"2 - "+STR0189+"  "+"3 - "+STR0190, oFont01) //"Gr?vida"###"at? 42 dias ap?s t?rmino gesta??o"###"de 43 dias a 12 meses ap?s t?rmino gesta??o"
                oPrint:Box(nLinIni + 0953, nColIni + 1065, nLinIni + 1047, nColIni + 1800)
                oPrint:Say(nLinIni + 0958, nColIni + 1075, "32 - "+STR0191, oFont01) //"Se ?bito neonatal"
                oPrint:Line(nLinIni + 0983, nColIni + 1085, nLinIni + 1030, nColIni + 1085)
                oPrint:Line(nLinIni + 1030, nColIni + 1085, nLinIni + 1030, nColIni + 1132)
                oPrint:Line(nLinIni + 0983, nColIni + 1132, nLinIni + 1030, nColIni + 1132)
                oPrint:Say(nLinIni + 0988, nColIni + 1125, Transform(aDados[nX, 32,1], "@E 99"), oFont04,,,,1)
                oPrint:Say(nLinIni + 0998, nColIni + 1145, "- "+STR0192, oFont01) //"Qtde. ?bito neonatal precoce"
                oPrint:Line(nLinIni + 0983, nColIni + 1455, nLinIni + 1030, nColIni + 1455)
                oPrint:Line(nLinIni + 1030, nColIni + 1455, nLinIni + 1030, nColIni + 1502)
                oPrint:Line(nLinIni + 0983, nColIni + 1502, nLinIni + 1030, nColIni + 1502)
                oPrint:Say(nLinIni + 0988, nColIni + 1495, Transform(aDados[nX, 32,2], "@E 99"), oFont04,,,,1)
                oPrint:Say(nLinIni + 0998, nColIni + 1515, "- "+STR0193, oFont01) //"Qtde. ?bito neonatal tardio"
                oPrint:Box(nLinIni + 0953, nColIni + 1805, nLinIni + 1047, nColIni + 2125 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0))
                oPrint:Say(nLinIni + 0958, nColIni + 1815, "33 - "+STR0194, oFont01) //"N?o Decl.Nasc.Vivos"
                oPrint:Say(nLinIni + 0988, nColIni + 1825 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+80,0), aDados[nX, 33], oFont04)
                oPrint:Box(nLinIni + 0953, nColIni + 2130 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0), nLinIni + 1047, nColIni + 2530 + nCol2A4/2)
                oPrint:Say(nLinIni + 0958, nColIni + 2140 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0), "34 - "+STR0195, oFont01) //"Qtde.Nasc.Vivos a Termo"
                oPrint:Say(nLinIni + 0988, nColIni + 2350 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4/2+30,0), Transform(aDados[nX, 34], "@E 9999.99"), oFont04,,,,1)
                oPrint:Box(nLinIni + 0953, nColIni + 2535 + nCol2A4/2, nLinIni + 1047, nColIni + 2935 + nCol2A4/2)
                oPrint:Say(nLinIni + 0958, nColIni + 2545 + nCol2A4/2, "35 - "+STR0196, oFont01) //"Qtde.Nasc.Mortos"
                oPrint:Say(nLinIni + 0988, nColIni + 2755 + nCol2A4/2, Transform(aDados[nX, 35], "@E 9999.99"), oFont04,,,,1)
                oPrint:Box(nLinIni + 0953, nColIni + 2940 + nCol2A4/2, nLinIni + 1047, nColIni + 3340 + IIf(nLayout == 2 .Or. nLayout ==3,nCol2A4+5,0))
                oPrint:Say(nLinIni + 0958, nColIni + 2950 + nCol2A4/2, "36 - "+STR0197, oFont01) //"Qtde.Nasc.Vivos Prematuro"
                oPrint:Say(nLinIni + 0988, nColIni + 3160 + nCol2A4/2, Transform(aDados[nX, 36], "@E 9999.99"), oFont04,,,,1)

                nLinIni += 20
                oPrint:Say(nLinIni + 1052, nColIni + 0010, STR0198, oFont01) //"Dados da Sa?da da Intern??o"
                oPrint:Box(nLinIni + 1082, nColIni + 0010, nLinIni + 1176, nColIni + 0285)
                oPrint:Say(nLinIni + 1087, nColIni + 0020, "37 - "+STR0149, oFont01) //"CID 10 Principal"
                oPrint:Say(nLinIni + 1117, nColIni + 0030, aDados[nX, 37], oFont04)
                oPrint:Box(nLinIni + 1082, nColIni + 0290, nLinIni + 1176, nColIni + 0565)
                oPrint:Say(nLinIni + 1087, nColIni + 0300, "38 - "+STR0150, oFont01) //"CID 10 (2)"
                oPrint:Say(nLinIni + 1117, nColIni + 0310, aDados[nX, 38], oFont04)
                oPrint:Box(nLinIni + 1082, nColIni + 0570, nLinIni + 1176, nColIni + 0845)
                oPrint:Say(nLinIni + 1087, nColIni + 0580, "39 - "+STR0151, oFont01) //"CID 10 (3)"
                oPrint:Say(nLinIni + 1117, nColIni + 0590, aDados[nX, 39], oFont04)
                oPrint:Box(nLinIni + 1082, nColIni + 0850, nLinIni + 1176, nColIni + 1115)
                oPrint:Say(nLinIni + 1087, nColIni + 0860, "40 - "+STR0152, oFont01) //"CID 10 (4)"
                oPrint:Say(nLinIni + 1117, nColIni + 0870, aDados[nX, 40], oFont04)
                oPrint:Box(nLinIni + 1082, nColIni + 1120, nLinIni + 1176, nColIni + 1900)
                oPrint:Say(nLinIni + 1087, nColIni + 1130, "41 - "+STR0199, oFont01) //"Indicador de Acidente"
                oPrint:Line(nLinIni + 1112, nColIni + 1140, nLinIni + 1159, nColIni + 1140)
                oPrint:Line(nLinIni + 1159, nColIni + 1140, nLinIni + 1159, nColIni + 1182)
                oPrint:Line(nLinIni + 1112, nColIni + 1182, nLinIni + 1159, nColIni + 1182)
                oPrint:Say(nLinIni + 1117, nColIni + 1153, aDados[nX, 41], oFont04)
                oPrint:Say(nLinIni + 1127, nColIni + 1200, "0 - "+STR0034+"   "+"1 - "+STR0035+"   "+"2 - "+STR0036, oFont01) //"Acidente ou doen?a relacionado ao trabalho"###"Tr?nsito"###"Outros"
                oPrint:Box(nLinIni + 1082, nColIni + 1905, nLinIni + 1176, nColIni + 2205)
                oPrint:Say(nLinIni + 1087, nColIni + 1915, "42 - "+STR0200, oFont01) //"Motivo Sa?da"
                oPrint:Say(nLinIni + 1117, nColIni + 1925, aDados[nX, 42], oFont04)
                oPrint:Box(nLinIni + 1082, nColIni + 2210, nLinIni + 1176, nColIni + 2510)
                oPrint:Say(nLinIni + 1087, nColIni + 2220, "43 - "+STR0201, oFont01) //"CID 10 ?bito"
                oPrint:Say(nLinIni + 1117, nColIni + 2230, aDados[nX, 43], oFont04)
                oPrint:Box(nLinIni + 1082, nColIni + 2515, nLinIni + 1176, nColIni + 3000)
                oPrint:Say(nLinIni + 1087, nColIni + 2525, "44 - "+STR0202, oFont01) //"N?o Declara??o do ?bito"
                oPrint:Say(nLinIni + 1117, nColIni + 2535, aDados[nX, 44], oFont04)

                nLinIni += 20
                oPrint:Say(nLinIni + 1181, nColIni + 0010, STR0097, oFont01) //"Procedimentos e Exames Realizados"
                oPrint:Box(nLinIni + 1211, nColIni + 0010, nLinIni + 1501, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 1216, nColIni + 0020, "45 - "+STR0098, oFont01) //"Data"
                oPrint:Say(nLinIni + 1216, nColIni + 0205, "46 - "+STR0099, oFont01) //"Hora Inicial"
                oPrint:Say(nLinIni + 1216, nColIni + 0380, "47 - "+STR0100, oFont01) //"Hora Final"
                oPrint:Say(nLinIni + 1216, nColIni + 0540, "48 - "+STR0074, oFont01) //"Tabela"
                oPrint:Say(nLinIni + 1216, nColIni + 0660, "49 - "+STR0075, oFont01) //"C?digo do Procedimento"
                oPrint:Say(nLinIni + 1216, nColIni + 0940, "50 - "+STR0076, oFont01) //"Descri??o"
                oPrint:Say(nLinIni + 1216, nColIni + 2825 + nColA4, "51 - "+STR0101, oFont01,,,,1) //"Qtde."
                oPrint:Say(nLinIni + 1216, nColIni + 2855 + nColA4, "52 - "+STR0102, oFont01) //"Via"
                oPrint:Say(nLinIni + 1216, nColIni + 2945 + nColA4, "53 - "+STR0103, oFont01) //"Tec."
                oPrint:Say(nLinIni + 1216, nColIni + 3235 + nColA4, "54 - "+STR0104, oFont01,,,,1) //"% Red./Acresc."
                oPrint:Say(nLinIni + 1216, nColIni + 3465 + nColA4, "55 - "+STR0105, oFont01,,,,1) //"Valor Unitrio - R$"
                oPrint:Say(nLinIni + 1216, nColIni + 3675 + nColA4, "56 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

                nOldLinIni := nLinIni
                if nVolta=1
                    nP:=1
                Endif
                nT:=nP+4
                For nI := nP To nT
                    if nVolta <> 1
                        nN:=nI-(15*nVolta-15)
                        oPrint:Say(nLinIni + 1271, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
                    else
                        oPrint:Say(nLinIni + 1271, nColIni + 0020, AllTrim(Str(nI)) + " - ", oFont01)
                    Endif
                    oPrint:Say(nLinIni + 1266, nColIni + 0065, IIf(Empty(aDados[nX, 45, nI]), "", DtoC(aDados[nX, 45, nI])), oFont04)
                    oPrint:Say(nLinIni + 1266, nColIni + 0205, IIf(Empty(aDados[nX, 46, nI]), "", Transform(aDados[nX, 46, nI], "@R 99:99")), oFont04)
                    oPrint:Say(nLinIni + 1266, nColIni + 0380, IIf(Empty(aDados[nX, 47, nI]), "", Transform(aDados[nX, 47, nI], "@R 99:99")), oFont04)
                    oPrint:Say(nLinIni + 1266, nColIni + 0540, aDados[nX, 48, nI], oFont04)
                    oPrint:Say(nLinIni + 1266, nColIni + 0660, aDados[nX, 49, nI], oFont04)
                    oPrint:Say(nLinIni + 1266, nColIni + 0940, aDados[nX, 50, nI], oFont04)
                    oPrint:Say(nLinIni + 1266, nColIni + 2825 + nColA4, IIf((aDados[nX, 51, nI])=0, "", Transform(aDados[nX, 51, nI], "@E 9999.99")), oFont04,,,,1)
                    oPrint:Say(nLinIni + 1266, nColIni + 2855 + nColA4, aDados[nX, 52, nI], oFont04)
                    oPrint:Say(nLinIni + 1266, nColIni + 2945 + nColA4, aDados[nX, 53, nI], oFont04)
                    oPrint:Say(nLinIni + 1266, nColIni + 3235 + nColA4, IIf((aDados[nX, 54, nI])=0, "", Transform(aDados[nX, 54, nI], "@E 999.99")), oFont04,,,,1)
                    oPrint:Say(nLinIni + 1266, nColIni + 3465 + nColA4, IIf((aDados[nX, 55, nI])=0, "", Transform(aDados[nX, 55, nI], "@E 99,999,999.99")), oFont04,,,,1)
                    oPrint:Say(nLinIni + 1266, nColIni + 3675 + nColA4, IIf((aDados[nX, 56, nI])=0, "", Transform(aDados[nX, 56, nI], "@E 99,999,999.99")), oFont04,,,,1)
                    nLinIni += 40
                Next nI

                nLinIni := nOldLinIni
                nP:=nI

                nLinIni += 20
                oPrint:Say(nLinIni + 1506, nColIni + 0010, STR0203, oFont01) //"Identificao da Equipe"
                oPrint:Box(nLinIni + 1536, nColIni + 0010, nLinIni + 1866, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 1541, nColIni + 0020, "57 - "+STR0204, oFont01) //"Seq.Ref"
                oPrint:Say(nLinIni + 1541, nColIni + 0180, "58 - "+STR0205, oFont01) //"Gr.Part."
                oPrint:Say(nLinIni + 1541, nColIni + 0320, "59 - "+STR0206, oFont01) //"C?digo na Operadora/CPF"
                oPrint:Say(nLinIni + 1541, nColIni + 0670, "60 - "+STR0207, oFont01) //"Nome do Profissional"
                oPrint:Say(nLinIni + 1541, nColIni + 2640 + nColA4, "61 - "+STR0208, oFont01) //"Conselho Prof."
                oPrint:Say(nLinIni + 1541, nColIni + 2990 + nColA4, "62 - "+STR0209, oFont01) //"N?mero Conselho"
                oPrint:Say(nLinIni + 1541, nColIni + 3340 + nColA4, "63 - "+STR0018, oFont01) //"UF"
                oPrint:Say(nLinIni + 1541, nColIni + 3440 + nColA4, "64 - "+STR0210, oFont01) //"CPF"

                nOldLinIni := nLinIni
                if nVolta=1
                    nP1:=1
                Endif
                nT1:=nP1+5
                For nI := nP1 To nT1
                    oPrint:Say(nLinIni + 1591, nColIni + 0020, aDados[nX, 57, nI], oFont04)
                    oPrint:Say(nLinIni + 1591, nColIni + 0180, aDados[nX, 58, nI], oFont04)
                    oPrint:Say(nLinIni + 1591, nColIni + 0320, aDados[nX, 59, nI], oFont04)
                    oPrint:Say(nLinIni + 1591, nColIni + 0670, aDados[nX, 60, nI], oFont04)
                    oPrint:Say(nLinIni + 1591, nColIni + 2640 + nColA4, aDados[nX, 61, nI], oFont04)
                    oPrint:Say(nLinIni + 1591, nColIni + 2990 + nColA4, aDados[nX, 62, nI], oFont04)
                    oPrint:Say(nLinIni + 1591, nColIni + 3340 + nColA4, aDados[nX, 63, nI], oFont04)
                    oPrint:Say(nLinIni + 1591, nColIni + 3440 + nColA4, IIf(Empty(aDados[nX, 64, nI]), "", Transform(aDados[nX, 64, nI], "@R 999.999.999-99")), oFont04)
                    nLinIni += 40
                Next nI

                nP1:=nI
                nLinIni := nOldLinIni

                oPrint:Box(nLinIni + 1871, nColIni + 0010, nLinIni + 1965, nColIni + 0350)
                oPrint:Say(nLinIni + 1876, nColIni + 0020, "73 - "+STR0211, oFont01) //"Tipo Faturamento R$"
                oPrint:Line(nLinIni + 1901, nColIni + 0030, nLinIni + 1948, nColIni + 0030)
                oPrint:Line(nLinIni + 1948, nColIni + 0030, nLinIni + 1948, nColIni + 0077)
                oPrint:Line(nLinIni + 1901, nColIni + 0077, nLinIni + 1948, nColIni + 0077)
                oPrint:Say(nLinIni + 1906, nColIni + 0043, aDados[nX, 73,1], oFont04)
                oPrint:Say(nLinIni + 1916, nColIni + 0090, "- "+STR0212, oFont01) //"Total"
                oPrint:Line(nLinIni + 1901, nColIni + 0180, nLinIni + 1948, nColIni + 0180)
                oPrint:Line(nLinIni + 1948, nColIni + 0180, nLinIni + 1948, nColIni + 0227)
                oPrint:Line(nLinIni + 1901, nColIni + 0227, nLinIni + 1948, nColIni + 0227)
                oPrint:Say(nLinIni + 1906, nColIni + 0193, aDados[nX, 73,2], oFont04)
                oPrint:Say(nLinIni + 1916, nColIni + 0240, "- "+STR0213, oFont01) //"Parcial"

                oPrint:Box(nLinIni + 1871, nColIni + 0355, nLinIni + 1965, nColIni + 0827 + nColA4/3)
                oPrint:Say(nLinIni + 1876, nColIni + 0365, "74 - "+STR0108, oFont01) //"Total Procedimentos R$"
                oPrint:Say(nLinIni + 1906, nColIni + 0807 + nColA4/3, Transform(aDados[nX, 74], "@E 999,999.99"), oFont04,,,,1)
                oPrint:Box(nLinIni + 1871, nColIni + 0832 + nColA4/3, nLinIni + 1965, nColIni + 1304 + nColA4/2)
                oPrint:Say(nLinIni + 1876, nColIni + 0842 + nColA4/3, "75 - "+STR0112, oFont01) //"Total Dirias R$"
                oPrint:Say(nLinIni + 1906, nColIni + 1284 + nColA4/2, Transform(aDados[nX, 75], "@E 999,999.99"), oFont04,,,,1)
                oPrint:Box(nLinIni + 1871, nColIni + 1309 + nColA4/2, nLinIni + 1965, nColIni + 1781 + nColA4/2)
                oPrint:Say(nLinIni + 1876, nColIni + 1319 + nColA4/2, "76 - "+STR0109, oFont01) //"Total Taxas e Aluguis R$"
                oPrint:Say(nLinIni + 1906, nColIni + 1761 + nColA4/2, Transform(aDados[nX, 76], "@E 999,999.99"), oFont04,,,,1)
                oPrint:Box(nLinIni + 1871, nColIni + 1786 + nColA4/2, nLinIni + 1965, nColIni + 2258 + nColA4/2)
                oPrint:Say(nLinIni + 1876, nColIni + 1796 + nColA4/2, "77 - "+STR0110, oFont01) //"Total Materiais R$"
                oPrint:Say(nLinIni + 1906, nColIni + 2238 + nColA4/2, Transform(aDados[nX, 77], "@E 999,999.99"), oFont04,,,,1)
                oPrint:Box(nLinIni + 1871, nColIni + 2263 + nColA4/2, nLinIni + 1965, nColIni + 2735 + nColA4/2)
                oPrint:Say(nLinIni + 1876, nColIni + 2273 + nColA4/2, "78 - "+STR0111, oFont01) //"Total Medicamentos R$"
                oPrint:Say(nLinIni + 1906, nColIni + 2715 + nColA4/2, Transform(aDados[nX, 78], "@E 999,999.99"), oFont04,,,,1)
                oPrint:Box(nLinIni + 1871, nColIni + 2740 + nColA4/2, nLinIni + 1965, nColIni + 3212 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2))
                oPrint:Say(nLinIni + 1876, nColIni + 2750 + nColA4/2, "79 - "+STR0113, oFont01) //"Total Gases Medicinais R$"
                oPrint:Say(nLinIni + 1906, nColIni + 3192 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2), Transform(aDados[nX, 79], "@E 999,999.99"), oFont04,,,,1)
                oPrint:Box(nLinIni + 1871, nColIni + 3217 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2), nLinIni + 1965, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 1876, nColIni + 3227 + IIF(nLayout == 2,(nCol2A4*2)+70,nCol2A4*2), "80 - "+STR0214, oFont01) //"Total Geral R$"
                oPrint:Say(nLinIni + 1906, nColIni + 3675 + nColA4, Transform(aDados[nX, 80], "@E 999,999.99"), oFont04,,,,1)

                oPrint:Box(nLinIni + 1970, nColIni + 0010, nLinIni + 2158, nColIni + 1340)
                oPrint:Say(nLinIni + 1975, nColIni + 0020, "82 - "+STR0215, oFont01) //"Data e Assinatura do Contratado"
                oPrint:Say(nLinIni + 2005, nColIni + 0030, DtoC(aDados[nX, 82]), oFont04)
                oPrint:Box(nLinIni + 1970, nColIni + 1345, nLinIni + 2158, nColIni + 2695)
                oPrint:Say(nLinIni + 1975, nColIni + 1355, "83 - "+STR0216, oFont01) //"Data e Assinatura do(s) Auditor(es) da Operadora"
                oPrint:Say(nLinIni + 2005, nColIni + 1365, DtoC(aDados[nX, 83]), oFont04)

                oPrint:EndPage()	// Finaliza a pagina

                //  Verso da Guia
                oPrint:StartPage()	// Inicia uma nova pagina

                nLinIni := 0
                //??
                //Box Principal
                //
                oPrint:Box(nLinIni + 0000, nColIni + 0000, nLinIni + nLinMax, nColIni + nColMax)

                nLinIni += 20
                oPrint:Say(nLinIni + 0010, nColIni + 0010, STR0217, oFont01) //"Procedimentos e Exames Realizados (Continuao)"
                oPrint:Box(nLinIni + 0040, nColIni + 0010, nLinIni + 0530, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 0045, nColIni + 0020, "45 - "+STR0098, oFont01) //"Data"
                oPrint:Say(nLinIni + 0045, nColIni + 0205, "46 - "+STR0099, oFont01) //"Hora Inicial"
                oPrint:Say(nLinIni + 0045, nColIni + 0380, "47 - "+STR0100, oFont01) //"Hora Final"
                oPrint:Say(nLinIni + 0045, nColIni + 0540, "48 - "+STR0074, oFont01) //"Tabela"
                oPrint:Say(nLinIni + 0045, nColIni + 0660, "49 - "+STR0075, oFont01) //"C?digo do Procedimento"
                oPrint:Say(nLinIni + 0045, nColIni + 0940, "50 - "+STR0076, oFont01) //"Descri??o"
                oPrint:Say(nLinIni + 0045, nColIni + 2855 + nColA4, "51 - "+STR0101, oFont01,,,,1) //"Qtde."
                oPrint:Say(nLinIni + 0045, nColIni + 2885 + nColA4, "52 - "+STR0102, oFont01) //"Via"
                oPrint:Say(nLinIni + 0045, nColIni + 2975 + nColA4, "53 - "+STR0103, oFont01) //"Tec."
                oPrint:Say(nLinIni + 0045, nColIni + 3245 + nColA4, "54 - "+STR0104, oFont01,,,,1) //"% Red./Acresc."
                oPrint:Say(nLinIni + 0045, nColIni + 3465 + nColA4, "55 - "+STR0105, oFont01,,,,1) //"Valor Unitrio - R$"
                oPrint:Say(nLinIni + 0045, nColIni + 3675 + nColA4, "56 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

                nOldLinIni := nLinIni

                if nVolta =1
                    nP:=6
                Endif
                nT2:=nP+9

                For nI := nP To nT2
                    if nVolta<>1
                        nN:=nI-((15*nVolta)-15)
                        oPrint:Say(nLinIni + 0100, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
                    Else
                        oPrint:Say(nLinIni + 0100, nColIni + 0020, AllTrim(Str(nI)) + " - ", oFont01)
                    Endif
                    oPrint:Say(nLinIni + 0095, nColIni + 0065, if (Empty(aDados[nX, 45, nI]),"",DtoC(aDados[nX, 45, nI])), oFont04)
                    oPrint:Say(nLinIni + 0095, nColIni + 0205, if (Empty(aDados[nX, 46, nI]),"",Transform(aDados[nX, 46, nI], "@R 99:99")), oFont04)
                    oPrint:Say(nLinIni + 0095, nColIni + 0380, if (Empty(aDados[nX, 47, nI]),"",Transform(aDados[nX, 47, nI], "@R 99:99")), oFont04)
                    oPrint:Say(nLinIni + 0095, nColIni + 0540, aDados[nX, 48, nI], oFont04)
                    oPrint:Say(nLinIni + 0095, nColIni + 0660, aDados[nX, 49, nI], oFont04)
                    oPrint:Say(nLinIni + 0095, nColIni + 0940, aDados[nX, 50, nI], oFont04)
                    oPrint:Say(nLinIni + 0095, nColIni + 2855 + nColA4, IIf((aDados[nX, 51, nI])=0, "", Transform(aDados[nX, 51, nI], "@E 9999.99")), oFont04,,,,1)
                    oPrint:Say(nLinIni + 0095, nColIni + 2885 + nColA4, aDados[nX, 52, nI], oFont04)
                    oPrint:Say(nLinIni + 0095, nColIni + 2975 + nColA4, aDados[nX, 53, nI], oFont04)
                    oPrint:Say(nLinIni + 0095, nColIni + 3245 + nColA4, IIf((aDados[nX, 54, nI])=0, "", Transform(aDados[nX, 54, nI], "@E 999.99")), oFont04,,,,1)
                    oPrint:Say(nLinIni + 0095, nColIni + 3465 + nColA4, IIf((aDados[nX, 55, nI])=0, "", Transform(aDados[nX, 55, nI], "@E 99,999,999.99")), oFont04,,,,1)
                    oPrint:Say(nLinIni + 0095, nColIni + 3675 + nColA4, IIf((aDados[nX, 56, nI])=0, "", Transform(aDados[nX, 56, nI], "@E 99,999,999.99")), oFont04,,,,1)
                    nLinIni += 40
                Next nI

                nP:=nI

                if nVolta=1
                    nP3:=len(aDados[nX,49])
                Endif

                if nP3 >nI-1
                    lImpnovo:=.T.
                Endif

                nLinIni := nOldLinIni

                nLinIni += 20
                oPrint:Say(nLinIni + 0535, nColIni + 0010, STR0218, oFont01) //"Identificao da Equipe (Continuao)"
                oPrint:Box(nLinIni + 0565, nColIni + 0010, nLinIni + 1215, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 0570, nColIni + 0020, "57 - "+STR0204, oFont01) //"Seq.Ref"
                oPrint:Say(nLinIni + 0570, nColIni + 0180, "58 - "+STR0205, oFont01) //"Gr.Part."
                oPrint:Say(nLinIni + 0570, nColIni + 0320, "59 - "+STR0206, oFont01) //"C?digo na Operadora/CPF"
                oPrint:Say(nLinIni + 0570, nColIni + 0670, "60 - "+STR0207, oFont01) //"Nome do Profissional"
                oPrint:Say(nLinIni + 0570, nColIni + 2640 + nColA4, "61 - "+STR0208, oFont01) //"Conselho Prof."
                oPrint:Say(nLinIni + 0570, nColIni + 2990 + nColA4, "62 - "+STR0209, oFont01) //"N?mero Conselho"
                oPrint:Say(nLinIni + 0570, nColIni + 3340 + nColA4, "63 - "+STR0018, oFont01) //"UF"
                oPrint:Say(nLinIni + 0570, nColIni + 3440 + nColA4, "64 - "+STR0210, oFont01) //"CPF"

                nOldLinIni := nLinIni
                if nVolta =1
                    nP1:=7
                Endif
                nT3:=nP1+13

                For nI := nP1 To nT3
                    oPrint:Say(nLinIni + 0620, nColIni + 0020, aDados[nX, 57, nI], oFont04)
                    oPrint:Say(nLinIni + 0620, nColIni + 0180, aDados[nX, 58, nI], oFont04)
                    oPrint:Say(nLinIni + 0620, nColIni + 0320, aDados[nX, 59, nI], oFont04)
                    oPrint:Say(nLinIni + 0620, nColIni + 0670, aDados[nX, 60, nI], oFont04)
                    oPrint:Say(nLinIni + 0620, nColIni + 2640 + nColA4, aDados[nX, 61, nI], oFont04)
                    oPrint:Say(nLinIni + 0620, nColIni + 2990 + nColA4, aDados[nX, 62, nI], oFont04)
                    oPrint:Say(nLinIni + 0620, nColIni + 3340 + nColA4, aDados[nX, 63, nI], oFont04)
                    oPrint:Say(nLinIni + 0620, nColIni + 3440 + nColA4, IIf(Empty(aDados[nX, 57, nI]), "", Transform(aDados[nX, 64, nI], "@R 999.999.999-99")), oFont04)
                    nLinIni += 40
                Next nI

                nP1:=nI

                if nVolta=1
                    nP2:=len(aDados[nX,57])
                Endif

                if nP2 >nI-1
                    lImpnovo:=.T.
                Endif

                nLinIni := nOldLinIni

                nLinIni += 20
                oPrint:Say(nLinIni + 1220, nColIni + 0020, STR0122, oFont01) //"OPM Utilizados"
                oPrint:Box(nLinIni + 1250, nColIni + 0010, nLinIni + 1540, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 1255, nColIni + 0020, "65 - "+STR0074, oFont01) //"Tabela"
                oPrint:Say(nLinIni + 1255, nColIni + 0160, "66 - "+STR0119, oFont01) //"C?digo do OPM"
                oPrint:Say(nLinIni + 1255, nColIni + 0410, "67 - "+STR0120, oFont01) //"Descri??o OPM"
                oPrint:Say(nLinIni + 1255, nColIni + 2465 + nColA4, "68 - "+STR0101, oFont01,,,,1) //"Qtde."
                oPrint:Say(nLinIni + 1255, nColIni + 2505 + nColA4, "69 - "+STR0123, oFont01) //"C?digo de Barras"
                oPrint:Say(nLinIni + 1255, nColIni + 3390 + nColA4, "70 - "+STR0105, oFont01,,,,1) //"Valor Unitrio - R$"
                oPrint:Say(nLinIni + 1255, nColIni + 3665 + nColA4, "71 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

                nOldLinIni := nLinIni

                if nVolta=1
                    nP4:=1
                Endif
                nT4:=nP4+4

                For nI := nP4 To nT4
                    if nVolta <> 1
                        nN:=nI-((nVolta*5)-5)
                        oPrint:Say(nLinIni + 1305, nColIni + 0020, AllTrim(Str(nN)) + " - ", oFont01)
                    else
                        oPrint:Say(nLinIni + 1305, nColIni + 0020, AllTrim(Str(nI)) + " - ", oFont01)
                    Endif
                    oPrint:Say(nLinIni + 1300, nColIni + 0065, aDados[nX, 65, nI], oFont04)
                    oPrint:Say(nLinIni + 1300, nColIni + 0160, aDados[nX, 66, nI], oFont04)
                    oPrint:Say(nLinIni + 1300, nColIni + 0410, aDados[nX, 67, nI], oFont04)
                    oPrint:Say(nLinIni + 1300, nColIni + 2465 + nColA4, IIf(Empty(aDados[nX, 68, nI]), "", Transform(aDados[nX, 68, nI], "@E 9999.99")), oFont04,,,,1)
                    oPrint:Say(nLinIni + 1300, nColIni + 2505 + nColA4, aDados[nX, 69, nI], oFont04)
                    oPrint:Say(nLinIni + 1300, nColIni + 3390 + nColA4, IIf(Empty(aDados[nX, 70, nI]), "", Transform(aDados[nX, 70, nI], "@E 999,999,999.99")), oFont04,,,,1)
                    oPrint:Say(nLinIni + 1300, nColIni + 3665 + nColA4, IIf(Empty(aDados[nX, 71, nI]), "", Transform(aDados[nX, 71, nI], "@E 999,999,999.99")), oFont04,,,,1)
                    nLinIni += 40
                Next nI

                nP4:=nI

                if nVolta=1
                    nP5:=len(aDados[nX,66])
                Endif

                if nP5 >nI-1
                    lImpnovo:=.T.
                Endif

                nLinIni := nOldLinIni

                oPrint:Box(nLinIni + 1545, nColIni + 3295 + nColA4, nLinIni + 1639, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 1550, nColIni + 3305 + nColA4, "72 - "+STR0214, oFont01) //"Total Geral R$"
                oPrint:Say(nLinIni + 1580, nColIni + 3675 + nColA4, Transform(aDados[nX, 72], "@E 999,999,999.99"), oFont04,,,,1)

                oPrint:Box(nLinIni + 1644, nColIni + 0010, nLinIni + 1864, nColIni + 3695 + nColA4)
                oPrint:Say(nLinIni + 1649, nColIni + 0020, "81 - "+STR0056, oFont01) //"Observao"

                nLin := 1684

                For nI := 1 To MlCount(aDados[nX, 81], 130)
                    cObs := MemoLine(aDados[nX, 81], 130, nI)
                    oPrint:Say(nLinIni + nLin, nColIni + 0030, cObs, oFont04)
                    nLin += 35
                Next nI

                oPrint:EndPage()	// Finaliza a pagina

            Next nX

            //oPrint:EndPage()	// Finaliza a pagina
        Enddo

        oPrint:lViewPDF := .F.
        oPrint:Print()
        PLSCHKRP(cPathSrvJ, cFileName)
        FreeObj(oPrint)
        //Alert("Arquivo gerado Em: "+cPathSrvJ+"\"+cFileName)

    EndIf

Return

*************************************************************************************************
/***************************************************************************
*Autor: Mateus Medeiros  |    Data:08/08/2017                              *
*GUIA DE HONORARIO - R234HON - Baseado na fun??o padr?o PLSTISS5           *
****************************************************************************
*Descri??o: Estrutura Relatorio TISS ( Guia Hon Individual)                *
****************************************************************************
*Parametros aDados - Array com as informa??es do relat?rio                 *
* 			 lGerTXT - Define se imprime direto sem passar pela tela       *
* 			 de configuracao/preview do relatorio 	                       *
*            nLayout - Define o formato de papel para impressao:           *
*       		1 - Formato Of?cio II (216x330mm)                          *
*               2 - Formato A4 (210x297mm)                                 *
*               3 - Formato Carta (216x279mm)     			       		   *
/***************************************************************************/



Static Function R234HON(aDados, lGerTXT, nLayout, cLogoGH, lWeb, cPathRelW, lUnicaImp)

    Local nLinMax
    Local nColMax
    Local nLinIni	:=	0		// Linha Lateral (inicial) Esquerda
    Local nColIni	:=	0		// Coluna Lateral (inicial) Esquerda
    Local nColA4    :=  0
    Local nCol2A4   :=  0
    Local cFileLogo
    Local lPrinter
    Local nOldLinIni
    Local nI, nJ, nX
    Local oFont01
    Local oFont02n
    Local oFont03n
    Local oFont04
    Local nAte		:= 10
    Local lImpNovo	:= .T.
    Local nIni		:= 1
    Local cRel      := "GUIA_HONORARIO_" + aDados[01][Len(aDados[01])]
    Local oPrint	:= nil
    Local nTweb		:= 1
    Local nLweb		:= 0
    Local nLwebC	:= 0
    Local oBrush
    PRIVATE cPathSrvJ := GetNewPar( "MV_MAXPDF" , "C:\EXPORTA_GUIAS_LOTE\" )

    Default lUnicaImp := .F.
    Default lGerTXT := .F.
    Default nLayout := 2
    Default cLogoGH := ''
    Default lWeb    := .T.
    Default cPathRelW := ''
    Default aDados := {}

    If Len(aDados) > 0

        If nLayout  == 1 // Oficio 2
            nLinMax := 2435
            nColMax := 3705
        Elseif nLayout == 2   // Papel A4
            nLinMax	:=	2300//2375
            nColMax	:=	3370 //3365
        Else //Carta
            nLinMax	:=	2260
            nColMax	:=	3175
        Endif

        oFont01		:= TFont():New("Arial",  8,  8, , .F., , , , .T., .F.) // Normal

        if nLayout == 1 // Oficio 2
            oFont02n	:= TFont():New("Arial", 12, 12, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 14, 14, , .T., , , , .T., .F.) // Negrito
            oFont04		:= TFont():New("Arial", 09, 09, , .F., , , , .T., .F.) // Normal
        Else  // Papel A4 ou Carta
            oFont02n	:= TFont():New("Arial", 11, 11, , .T., , , , .T., .F.) // Negrito
            oFont03n	:= TFont():New("Arial", 13, 13, , .T., , , , .T., .F.) // Negrito
            oFont04		:= TFont():New("Arial", 08, 08, , .F., , , , .T., .F.) // Normal
        Endif

        //*********************************************************
        //Nao permite acionar a impressao quando for na web.
        //*********************************************************
        If lWeb
            //cFileName := UPPER(cRel)+UPPER(CriaTrab(NIL,.F.))+".pdf"
            cFileName := UPPER(cRel)+".pdf"
        Else
            cFileName := cRel+CriaTrab(NIL,.F.)
        EndIf

        if !lWeb
            //"GUIA DE HONORARIO INDIVIDUAL"
            oPrint := FWMSPrinter():New ( cFileName /*STR0219*/)

        else
            //oPrint := FWMSPrinter():New ( cFileName	,,.F.,cPathSrvJ	 ,.T.,	,@oPrint,			  ,			  ,	.F.			,.f.)
            oPrint := 	FwMsPrinter():New(cFileName, IMP_PDF, .F., cPathSrvJ, .T.)
            oPrint:cPathPDF := cPathSrvJ
            /*	LOCAL nAL		:= 0.25
            LOCAL nAC		:= 0.24*/
            nTweb		:= 3.9
            nLweb		:= 0.25//10
            nLwebC		:= 0.24//-3
            oPrint:lServer := lWeb
        Endif

        oPrint:SetLandscape()		// Modo paisagem

        if nLayout == 2
            oPrint:SetPaperSize(9)// Papel A4
        Elseif nLayout == 3
            oPrint:SetPaperSize(1)// Papel Carta
        Else
            oPrint:SetPaperSize(14) //Papel Oficio2 216 x 330mm / 8 1/2 x 13in
        Endif


        //*******************************
        //Device
        //*******************************
        If lWeb
            oPrint:setDevice(IMP_PDF)
        Else
            // Verifica se existe alguma impressora configurada para Impressao Grafica
            lPrinter := oPrint:IsPrinterActive()

            If ! lPrinter
                oPrint:Setup()
            EndIf
        Endif

        For nX := 1 To Len(aDados)

            nAte 	:= 10
            nI		:= 0
            nIni	:= 1

            //Esta condigo do codigo faz com que
            //imprima mais de uma guia.
            If lUnicaImp
                If nX <= Len(aDados)
                    lImpNovo := .T.
                EndIf
            EndIf

            While lImpNovo

                lImpNovo 	:= .F.

                If  ValType(aDados[nX]) == 'U' .OR. Len(aDados[nX]) == 0
                    Loop
                EndIf

                For nI := 17 To 28
                    If Len(aDados[nX, nI]) < 10
                        For nJ := Len(aDados[nX, nI]) + 1 To 10
                            If AllTrim(Str(nI)) $ "17"
                                aAdd(aDados[nX, nI], dtoc(StoD("")))
                            ElseIf AllTrim(Str(nI)) $ "23,26,27,28"
                                aAdd(aDados[nX, nI], "0")
                            Else
                                aAdd(aDados[nX, nI], "")
                            EndIf
                        Next nJ
                    EndIf
                Next nI

                nLinIni := 000
                nColIni := 000
                nColA4  := 000
                nCol2A4 := 000

                If lweb//oPrint:Cprinter == "PDF" .OR. lWeb
                    nLinIni	:= 150
                    nColMax := 3035
                Else
                    nLinIni := 000
                Endif
                /*	If lWeb
			nColMax := 3175
			Endif
                */
                oPrint:StartPage()		// Inicia uma nova pagina
                oBrush := TBrush():New("",10) //- CINZA
                //**************************
                //Box Principal
                //**************************
                oPrint:Box((nLinIni + 0000)/nTweb, (nColIni + 0000)/nTweb, (nLinIni + nLinMax)/nTweb, (nColIni + nColMax)/nTweb)

                //*****************************************
                //Carrega e Imprime Logotipo da Empresa
                //*****************************************
                fLogoEmp(@cFileLogo,, cLogoGH)

                If File(cFilelogo)
                    oPrint:SayBitmap((nLinIni + 0050)/nTweb, (nColIni + 0020)/nTweb, cFileLogo, (400)/nTweb, (090)/nTweb) 		// Tem que estar abaixo do RootPath
                EndIf

                If nLayout == 2 // Papel A4
                    nColA4    := -0335
                Elseif nLayout == 3// Carta
                    nColA4    := -0530
                    nCol2A4   := -0400
                Endif

                If lWeb
                    nColA4 := -550
                Endif

                oPrint:Say(3*nLweb+(nLinIni + 0080)/nTweb, (nColIni + 1852 + IIf(nLayout == 2,nColA4,nCol2A4))/nTweb, OemToAnsi("GUIA DE HONOR?RIOS"), oFont02n,,,, 2) //"GUIA DE HONORARIO INDIVIDUAL"
                oPrint:Say(3*nLweb+(nLinIni + 0090)/nTweb, (nColIni + 3000 + nColA4)/nTweb, "2 - "+OemToAnsi("N? "), oFont01) //"N?
                oPrint:Say(3*nLweb+(nLinIni + 0090)/nTweb, (nColIni + 3096 + nColA4)/nTweb, aDados[nX, 02], oFont03n)
                // Linha 1
                nLinIni += 25
                oPrint:Box((nLinIni + 0165)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0259)/nTweb, (nColIni + 0315)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0190)/nTweb, (nColIni + 0020)/nTweb, "1 - "+STR0003, oFont01) //"Registro ANS"
                oPrint:Say(nLweb+(nLinIni + 0220)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 01], oFont04)
                oPrint:Box((nLinIni + 0165)/nTweb, (nColIni + 0320)/nTweb, (nLinIni + 0259)/nTweb, (nColIni + 1035)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0190)/nTweb, (nColIni + 0330)/nTweb, "3- N? Guia de Solicita??o de Interna??o", oFont01) //"N? Guia de Solicita??o de Interna??o"
                oPrint:Say(nLweb+(nLinIni + 0220)/nTweb, (nColIni + 0340)/nTweb, aDados[nX, 03], oFont04)
                oPrint:Box((nLinIni + 0165)/nTweb, (nColIni + 1038)/nTweb, (nLinIni + 0259)/nTweb, (nColIni + 1990)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0190)/nTweb, (nColIni + 1050)/nTweb, "4 - "+OemtoAnsi("Senha"), oFont01) //"Senha"
                oPrint:Say(nLweb+(nLinIni + 0220)/nTweb, (nColIni + 1060)/nTweb, Iif(valtype(aDados[nX, 04])=="C",aDados[nX, 04],DtoC(aDados[nX, 04])), oFont04)
                oPrint:Box((nLinIni + 0165)/nTweb, (nColIni + 1995)/nTweb, (nLinIni + 0259)/nTweb, (nColIni + 3025)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0190)/nTweb, (nColIni + 2015)/nTweb, OemtoAnsi("5 - N?mero da Guia Atribu?do pela Operadora"), oFont01) //"N?mero da Guia Atribu?do pela Operadora"
                oPrint:Say(nLweb+(nLinIni + 0210)/nTweb, (nColIni + 2010)/nTweb, Iif(valtype(aDados[nX, 05])=="C",aDados[nX, 04],DtoC(aDados[nX, 04])), oFont04)
                // Linha 2
                nLinIni += 19
                //Vetor de coordenadas {nTop,nLeft,nBottom,nRight}
                //oPrint:FillRect({(nLinIni + 0259)/nTweb,100,750,2300},oBrush)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0270)/nTweb, (nColIni + 0010)/nTweb, OemToAnsi("Dados do Benefici?rio"), oFont01) //"Dados do Beneficiario"
                oPrint:Box((nLinIni + 0280)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0398)/nTweb, (nColIni + 495)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0309)/nTweb, (nColIni + 0020)/nTweb, "6 - N?mero da Carteira", oFont01) //"N?mero da Carteira"
                oPrint:Say(nLweb+(nLinIni + 0339)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 06], oFont04)
                oPrint:Box((nLinIni + 0280)/nTweb, (nColIni + 500)/nTweb, (nLinIni + 0398)/nTweb, (nColIni + 3115 + nColA4)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0309)/nTweb, (nColIni + 0510)/nTweb, "7 - Nome", oFont01) //"Nome"
                oPrint:Say(nLweb+(nLinIni + 0339)/nTweb, (nColIni + 0510)/nTweb, aDados[nX, 07], oFont04)
                oPrint:Box((nLinIni + 280)/nTweb, (nColIni + 3120 + nColA4)/nTweb, (nLinIni + 0398)/nTweb, (nColIni + 3027)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0309)/nTweb, (nColIni + 2800)/nTweb, "8 - Atendimento a RN", oFont01) //"Atendimento a RN"
                oPrint:Say(nLweb+(nLinIni + 0339)/nTweb, (nColIni + 2880)/nTweb, aDados[nX, 08], oFont04)
                // Linha 3

                nLinIni += 25
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0403)/nTweb, (nColIni + 0010)/nTweb, STR0223, oFont01) //"Dados do Contratado (onde foi executado o procedimento)"
                oPrint:Box((nLinIni + 0410)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0528)/nTweb, (nColIni + 0426)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 435)/nTweb, (nColIni + 0020)/nTweb, "9 - C?digo na Operadora", oFont01) //"Codigo na Operadora / CNPJ / CPF"
                oPrint:Say(nLweb+(nLinIni + 0480)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 09], oFont04)

                oPrint:Box((nLinIni + 0410)/nTweb, (nColIni + 0431)/nTweb, (nLinIni + 0528)/nTweb, (nColIni + 2765)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 435)/nTweb, (nColIni + 0455)/nTweb,"10 - Nome do Hospital/Local", oFont01) //"Nome do Contratado"
                oPrint:Say(nLweb+(nLinIni + 0480)/nTweb, (nColIni + 0455)/nTweb, aDados[nX, 10], oFont04)

                oPrint:Box((nLinIni + 0410)/nTweb, (nColIni + 3105 + nColA4)/nTweb, (nLinIni + 0528)/nTweb,  (nColIni + 3025)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0435)/nTweb, (nColIni + 2780)/nTweb, "11-C?digo CNES", oFont01) //"Codigo CNES"
                oPrint:Say(nLweb+(nLinIni + 0480)/nTweb, (nColIni + 2780)/nTweb, aDados[nX, 11], oFont04)

                // Linha 4
                nLinIni += 19
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0533)/nTweb, (nColIni + 0010)/nTweb, "Dados do Contratado Executante", oFont01) //"Dados do Contratado Executante"

                oPrint:Box((nLinIni + 0540)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 675)/nTweb, (nColIni + 0426)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0565)/nTweb, (nColIni + 0020)/nTweb, "12 - "+"C?digo na Operadora / CNPJ / CPF", oFont01) //"Codigo na Operadora / CNPJ / CPF"
                oPrint:Say(nLweb+(nLinIni + 0610)/nTweb, (nColIni + 0030)/nTweb, aDados[nX, 12], oFont04)

                oPrint:Box((nLinIni + 0540)/nTweb, (nColIni + 0431)/nTweb, (nLinIni + 0675)/nTweb, (nColIni + 2765)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0565)/nTweb, (nColIni + 0441)/nTweb, "13 - "+"Nome do Contratado", oFont01) //"Nome do Contratado Executante"
                oPrint:Say(nLweb+(nLinIni + 0610)/nTweb, (nColIni + 0451)/nTweb, aDados[nX, 13], oFont04)
                oPrint:Box((nLinIni + 0540)/nTweb, (nColIni + 3105 + nColA4)/nTweb, (nLinIni + 0675)/nTweb, (nColIni + 3025)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0565)/nTweb, (nColIni + 2780)/nTweb, "14 - "+"C?digo CNES", oFont01) //"Codigo CNES"
                oPrint:Say(nLweb+(nLinIni + 0610)/nTweb, (nColIni + 2780)/nTweb, aDados[nX, 14], oFont04)

                // Linha 5
                nLinIni += 19
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0680)/nTweb, (nColIni + 0010)/nTweb, "Dados da Interna??o", oFont01) //"Dados do Contratado Executante"

                oPrint:Box((nLinIni + 0685)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 0820)/nTweb, (nColIni + 0426)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0705)/nTweb, (nColIni + 0020)/nTweb, "15 - Data do In?cio do Faturamento", oFont01) //"Nome do Contratado Executante"
                oPrint:Say(nLweb+(nLinIni + 0755)/nTweb, (nColIni + 0020)/nTweb, dtoc(aDados[nX, 15]), oFont04)

                oPrint:Box((nLinIni + 0685)/nTweb, (nColIni + 0433)/nTweb, (nLinIni + 0820)/nTweb, (nColIni + 0723)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0705)/nTweb, (nColIni + 0441)/nTweb, "16 - Data do Fim do Faturamento", oFont01) //"Grau Part."
                oPrint:Say(nLweb+(nLinIni + 0755)/nTweb, (nColIni + 0471)/nTweb, dtoc(aDados[nX, 16]), oFont04)

                // Linha 6
                nLinIni += 19
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0825)/nTweb, (nColIni + 0010)/nTweb, STR0227, oFont01) //"Procedimentos Realizados"
                oPrint:Box(nLweb+nLwebC+(nLinIni + 0845)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 1420)/nTweb, (nColIni + 3025)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0150)/nTweb, "17 - "+STR0098, oFont01) //"Data"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0380)/nTweb, "18 - "+STR0099, oFont01) //"Hora Inicial"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0540)/nTweb, "19 - "+STR0100, oFont01) //"Hora Final"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0660)/nTweb, "20 - "+"Tabela", oFont01) //"Tabela"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 0820)/nTweb, "21 - "+"C?digo de Procedimento", oFont01) //"Codigo do Procedimento"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 1040)/nTweb,"22 - "+"Descri??o", oFont01) //"Descricao"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 1950 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "23 - "+STR0101, oFont01,,,,1) //"Qtde."
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2050 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "24 - "+STR0102, oFont01) //"Via"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2150 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "25 - "+STR0103, oFont01) //"Tec."
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2350 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "26 - "+STR0104, oFont01,,,,1) //"% Red./Acresc."
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 2650 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "27 - "+"Valor Unit?rio - R$", oFont01,,,,1) //"Valor Unitario - R$"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 0896)/nTweb, (nColIni + 3000 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "28 - "+STR0106, oFont01,,,,1) //"Valor Total - R$"

                nOldLinIni := nLinIni
                For nI := nIni To nAte

                    If Len(aDados[nX, 17]) >= nI
                        oPrint:Say(nLweb+(nLinIni + 0961)/nTweb, (nColIni + 0020)/nTweb, AllTrim(Str(nI)) + " - ", oFont01)
                        oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0155)/nTweb, IIf(Empty(substr(cvaltochar(aDados[nX, 17, nI]),1,2)), "", Iif(valtype(aDados[nX, 17, nI])=="C",aDados[nX, 17, nI],DtoC(aDados[nX, 17, nI]) )) , oFont04)
                        oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0450)/nTweb, IIf(Empty(aDados[nX, 18, nI]), "", Transform(aDados[nX, 18, nI], "@R 99:99")), oFont04)
                        oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0540)/nTweb, IIf(Empty(aDados[nX, 19, nI]), "", Transform(aDados[nX, 19, nI], "@R 99:99")), oFont04)
                        oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0670)/nTweb, aDados[nX, 20, nI], oFont04)
                        oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 0840)/nTweb, aDados[nX, 21, nI], oFont04)
                        oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 1040)/nTweb, aDados[nX, 22, nI], oFont04)
                        If valtype(aDados[nX, 23, nI]) == "C"
                            if(aDados[nX, 23, nI] == "0")
                            cCont23 := ""
                        else
                            cCont23 := Transform(aDados[nX, 23, nI],"@E 999,99")
                        endif
                    else
                        if(aDados[nX, 23, nI] == 0)


                        cCont23 := ""
                    else
                        cCont23 := Transform(aDados[nX, 23, nI],"@E 999,99")
                    endif
                endif

                oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 1950 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb,cCont23 , oFont04,,,,1)

                If valtype(aDados[nX, 24, nI]) == "C"
                    if(aDados[nX, 24, nI] == "0")
                    cCont24 := ""
                else
                    cCont24 := Transform(aDados[nX, 24, nI],"@E 99999")
                endif
                else
                if(aDados[nX, 24, nI] == 0)


                cCont24 := ""
                else
                cCont24 := Transform(aDados[nX, 24, nI],"@E 99999")
                endif
                endif
                oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2060 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, cCont24 /*IIf( aDados[nX, 24, nI] = 0,"",Transform(aDados[nX, 24, nI],"@E 99999") )*/ , oFont04)
                oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2150 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, aDados[nX, 25, nI], oFont04)

                If valtype(aDados[nX, 26, nI]) == "C"
                    if(aDados[nX, 26, nI] == "0")
                    cCont26 := ""
                else
                    cCont26 := Transform(aDados[nX, 26, nI],"@E 999.99")
                endif
                else
                if(aDados[nX, 26, nI] == 0)
                cCont26 := ""
                else
                cCont26 := Transform(aDados[nX, 26, nI],"@E 999.99")
                endif
                endif

                If valtype(aDados[nX, 27, nI]) == "C"
                    if(aDados[nX, 27, nI] == "0")
                    cCont27 := ""
                else
                    cCont27 := Transform(aDados[nX, 27, nI],"@E 99,999,999.99")
                endif
                else
                if(aDados[nX, 27, nI] == 0)
                cCont27 := ""
                else
                cCont27 := Transform(aDados[nX, 27, nI],"@E 99,999,999.99")
                endif
                endif

                If valtype(aDados[nX, 28, nI]) == "C"
                    if(aDados[nX, 28, nI] == "0")
                    cCont28 := ""
                else
                    cCont28 := Transform(aDados[nX, 28, nI],"@E 99,999,999.99")
                endif
                else
                if(aDados[nX, 28, nI] == 0)
                cCont28 := ""
                else
                cCont28 := Transform(aDados[nX, 28, nI],"@E 99,999,999.99")
                endif
                endif


                oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2360 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, cCont26 /*IIf( aDados[nX, 26, nI] = 0 , "", Transform(aDados[nX, 26, nI], "@E 999.99"))*/, oFont04,,,,1)
                oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 2650 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, cCont27 /*IIf(aDados[nX, 27, nI] = 0, "", Transform(aDados[nX, 27, nI], "@E 99,999,999.99"))*/, oFont04,,,,1)
                oPrint:Say(nLweb+(nLinIni + 0956)/nTweb, (nColIni + 3000 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, cCont28 /*IIf(aDados[nX, 28, nI] = 0 , "", Transform(aDados[nX, 28, nI], "@E 99,999,999.99"))*/, oFont04,,,,1)
                nLinIni += 45
                Endif
                Next nI

                nLinIni := nOldLinIni

                If nAte < Len(aDados[nX][27])
                    lImpNovo 	:= .T.
                    nIni		:= nAte + 1
                    nAte		+= 10
                EndIf

                // Linha 7
                nLinIni += 45

                oPrint:Say(nLweb+nLwebC+(nLinIni + 1395)/nTweb, (nColIni + 0010)/nTweb, "Identifica??o do(s) Profissional(is) Executante(s)", oFont01) //"Procedimentos Realizados"
                oPrint:Box(nLweb+nLwebC+(nLinIni + 1410)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 1780)/nTweb, (nColIni + 3025)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 0020)/nTweb, "29-Seq.Ref" , oFont01) //"Data"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 0150)/nTweb, "30-Grau Part.  ", oFont01) //"Hora Inicial"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 0440)/nTweb, "31-C?digo na Operadora/CPF", oFont01) //"Hora Final"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 0820)/nTweb, "32-Nome do Profissional", oFont01) //"Tabela"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 1090)/nTweb, "33-Conselho Profissional" , oFont01) //"Codigo do Procedimento"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 1400)/nTweb, "34-N?mero no Conselho", oFont01) //"Descricao"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 2010 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "35-UF"      , oFont01,,,,1) //"Qtde."
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1430)/nTweb, (nColIni + 2400 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, "36-C?digo CBO", oFont01) //"Codigo CBO"

                nOldLinIni := nLinIni

                For nI := nIni To 7

                    If Len(aDados[nX, 29]) >= nI

                        oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 0020)/nTweb, IIf(Empty(aDados[nX, 29, nI]), "", Iif(valtype(aDados[nX, 29, nI])=="C",aDados[nX, 29, nI],DtoC(aDados[nX, 29, nI]) )) , oFont04)
                        oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 0150)/nTweb, IIf(Empty(aDados[nX, 30, nI]), "", aDados[nX, 30, nI]), oFont04)
                        oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 0440)/nTweb, IIf(Empty(aDados[nX, 31, nI]), "", aDados[nX, 31, nI]), oFont04)
                        oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 0820)/nTweb, aDados[nX, 32, nI], oFont04)
                        oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 1090)/nTweb, aDados[nX, 33, nI], oFont04)
                        oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 1400)/nTweb, aDados[nX, 34, nI], oFont04)
                        oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 2010 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, IIf(Empty(aDados[nX, 35, nI]), "",aDados[nX, 35, nI]) , oFont04,,,,1)
                        oPrint:Say(nLweb+(nLinIni + 1490)/nTweb, (nColIni + 2400 + IIF (nLayout == 2 ,nColA4+0,nCol2A4))/nTweb, aDados[nX, 36, nI], oFont04)
                        nLinIni += 45

                    Endif
                Next nI

                nLinIni := nOldLinIni
                nLinIni += 20
                //(nLinIni + 1500)/nTweb
                oPrint:Box(nLweb+nLwebC+(nLinIni + 1785)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 1985)/nTweb, (nColIni + 2970 + nColA4)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1820)/nTweb, (nColIni + 0020)/nTweb,  "37 - Observa??o / Justificativa", oFont01) //"Observacao"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1860)/nTweb, (nColIni + 0020 + nColA4)/nTweb, 	cvaltochar(aDados[nX,37]), oFont04,,,,1)
                oPrint:Box(nLweb+nLwebC+(nLinIni + 1785)/nTweb, (nColIni + 2990 + nColA4)/nTweb, (nLinIni + 1900)/nTweb,  (nColIni + 3025)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1820)/nTweb, (nColIni + 2999 + nColA4)/nTweb, "38 - "+"Total Geral Honor?rios R$", oFont01) //"Total Geral Honorarios R$"
                oPrint:Say(nLweb+nLwebC+(nLinIni + 1860)/nTweb, (nColIni + 3000 + nColA4)/nTweb, Transform(aDados[nX, 35], "@E 999,999,999.99"), oFont04,,,,1)

                nLinIni := nOldLinIni

                oPrint:Box((nLinIni + 2005)/nTweb, (nColIni + 0010)/nTweb, (nLinIni + 2100)/nTweb, (nColIni + 1340)/nTweb)
                oPrint:Say(nLweb+nLwebC+(nLinIni + 2025)/nTweb, (nColIni + 0020)/nTweb, OemToAnsi("39 - Data de Emis?o"), oFont01) //"Data e Assinatura do Prestador"
                oPrint:Say(nLweb+(nLinIni + 2045)/nTweb, (nColIni + 0030)/nTweb, Transform(aDados[nX, 39], "@E 999,999,999.99")			, oFont04)
                oPrint:Box((nLinIni + 2005)/nTweb, (nColIni + 1350)/nTweb, (nLinIni + 2100)/nTweb, ((nColIni + 2972 + nColA4)/nTweb))
                oPrint:Say(nLweb+nLwebC+(nLinIni + 2025)/nTweb, (nColIni + 1355)/nTweb, OemToAnsi("40 - Assinatura do Profissional Executante"), oFont01) //"Data/Hora e Assinatura do Beneficicio ou Responsavel"
                oPrint:Say(nLweb+(nLinIni + 2045)/nTweb, (nColIni + 1365)/nTweb, "  "  , oFont04)

                oPrint:EndPage()	// Finaliza a pagina

            End

        Next nX

        oPrint:lViewPDF := .F.
        oPrint:Print()
        PLSCHKRP(cPathSrvJ, cFileName)
        FreeObj(oPrint)

        //Alert("Arquivo gerado Em: "+cPathSrvJ+"\"+cFileName)

    EndIf

Return cFileName


//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA204A
description
@author  author
@since   date
@version version
/*/
//-------------------------------------------------------------------
/*
Static Function CABA204A(_cPerg)

    Local aHelpPor := {} //help da pergunta

    aHelpPor := {}
    AADD(aHelpPor,"Informe a Serie:			")

    u_CABASX1(_cPerg,"01","Serie da Nota "	,"a","a","MV_CH1"	,"C",TamSX3("F2_SERIE")[1]		,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

    aHelpPor := {}
    AADD(aHelpPor,"Informe a Data Emissão:	")

    u_CABASX1(_cPerg,"02","RPS De: "			,"a","a","MV_CH2"	,"C",TamSX3("F2_DOC")[1]		,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
    u_CABASX1(_cPerg,"03","RPS Ate:"			,"a","a","MV_CH3"	,"C",TamSX3("F2_DOC")[1]		,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")


Return
*/

//-------------------------------------------------------------------
/*/{Protheus.doc} function CABA204B
description Rotina que contem o vetor das guias para a geração em PDF
@author  author Angelo Henrique
@since   date 13/12/2021
@version version
/*/
//-------------------------------------------------------------------
Static Function CABA204B()

    Local _aRet := {}

    AADD(_aRet,{'00190019310700000044'})
    AADD(_aRet,{'00190019310700000046'})
    AADD(_aRet,{'00190019310700000048'})
    AADD(_aRet,{'00190019310900000004'})
    AADD(_aRet,{'00190019310900000009'})
    AADD(_aRet,{'00190019310900000014'})
    AADD(_aRet,{'00190019310900000023'})
    AADD(_aRet,{'00190019310900000027'})
    AADD(_aRet,{'00190019311100000003'})
    AADD(_aRet,{'00190019311100000008'})
    AADD(_aRet,{'00190019311100000009'})
    AADD(_aRet,{'00190019311100000010'})
    AADD(_aRet,{'00190019311100000019'})
    AADD(_aRet,{'00190019311100000022'})
    AADD(_aRet,{'00190019311100000029'})
    AADD(_aRet,{'00190019311300000008'})
    AADD(_aRet,{'00190019311300000011'})
    AADD(_aRet,{'00190019311300000012'})
    AADD(_aRet,{'00190019311300000017'})
    AADD(_aRet,{'00190019311300000019'})
    AADD(_aRet,{'00190019311300000022'})
    AADD(_aRet,{'00190019311300000028'}) 
    AADD(_aRet,{'00190019311300000030'})
    AADD(_aRet,{'00190019311300000031'})
    AADD(_aRet,{'00190019311300000032'})
    AADD(_aRet,{'00190019311300000038'})
    AADD(_aRet,{'00190019311300000039'})
    AADD(_aRet,{'00190019311300000043'})
    AADD(_aRet,{'00190019346700000002'})
    AADD(_aRet,{'00190019346700000013'})
    AADD(_aRet,{'00190019346700000014'})
    AADD(_aRet,{'00190019346700000019'})
    AADD(_aRet,{'00190019346700000023'})
    AADD(_aRet,{'00190019346700000027'})
    AADD(_aRet,{'00190019346700000033'})
    AADD(_aRet,{'00190019346700000038'})
    AADD(_aRet,{'00190019346700000042'})
    AADD(_aRet,{'00190019346700000052'})
    AADD(_aRet,{'00190019346700000054'})
    AADD(_aRet,{'00190019346700000056'})
    AADD(_aRet,{'00190019346800000002'})
    AADD(_aRet,{'00190019346800000008'})
    AADD(_aRet,{'00190019346800000011'})
    AADD(_aRet,{'00190019346800000013'})
    AADD(_aRet,{'00190019346800000024'})
    AADD(_aRet,{'00190019346800000028'})
    AADD(_aRet,{'00190019346800000033'})
    AADD(_aRet,{'00190019346800000034'})
    AADD(_aRet,{'00190019346800000037'})
    AADD(_aRet,{'00190019346800000041'})
    AADD(_aRet,{'00190019346800000044'})
    AADD(_aRet,{'00190019346800000045'})
    AADD(_aRet,{'90000018848300000021'})
    AADD(_aRet,{'00130019019300000033'})
    AADD(_aRet,{'00130020674100000047'})
    AADD(_aRet,{'00020018719300000025'})
    AADD(_aRet,{'00020018719500000013'})
    AADD(_aRet,{'00020018719600000002'})
    AADD(_aRet,{'00020018719600000005'})
    AADD(_aRet,{'00020018719600000010'})
    AADD(_aRet,{'00020018720500000008'})
    AADD(_aRet,{'00020018720500000013'})
    AADD(_aRet,{'00020018720500000016'})
    AADD(_aRet,{'00020018720700000003'})
    AADD(_aRet,{'00020018720700000020'})
    AADD(_aRet,{'00020018721000000011'})
    AADD(_aRet,{'00020018721000000030'})
    AADD(_aRet,{'00020018923200000009'})
    AADD(_aRet,{'00020018923400000009'})
    AADD(_aRet,{'00020018923400000019'})
    AADD(_aRet,{'00020018923400000035'})
    AADD(_aRet,{'00020019152900000005'})
    AADD(_aRet,{'00020019703700000013'})
    AADD(_aRet,{'00020020789200000023'})
    AADD(_aRet,{'00190016978700000004'})
    AADD(_aRet,{'00130020674100000042'})
    AADD(_aRet,{'00020018993100000007'})
    AADD(_aRet,{'00190019194700000006'})
    AADD(_aRet,{'00190019194700000007'})
    AADD(_aRet,{'00190019977000000442'})
    AADD(_aRet,{'00190019977000000504'})
    AADD(_aRet,{'00190020426000000092'})
    AADD(_aRet,{'00020018983500000036'})
    AADD(_aRet,{'90000018660300000008'})
    AADD(_aRet,{'90000019022600000055'})
    AADD(_aRet,{'00020018800800000064'})
    AADD(_aRet,{'00020018996100000027'})
    AADD(_aRet,{'00100016570000000007'})
    AADD(_aRet,{'00190019571200000019'})
    AADD(_aRet,{'00190020425500000481'})
    AADD(_aRet,{'00190020425600000572'})
    AADD(_aRet,{'00190020425800000309'})
    AADD(_aRet,{'00190020425800000312'})
    AADD(_aRet,{'00020018740400000015'})
    AADD(_aRet,{'00020018924900000002'})
    AADD(_aRet,{'00020018924900000005'})
    AADD(_aRet,{'00100018651900000010'})
    AADD(_aRet,{'00100018651900000012'})
    AADD(_aRet,{'00100018651900000021'})
    AADD(_aRet,{'00100018651900000030'})
    AADD(_aRet,{'00100018652100000008'})
    AADD(_aRet,{'00100018652100000011'})
    AADD(_aRet,{'00100018652100000017'})
    AADD(_aRet,{'00100018652100000034'})
    AADD(_aRet,{'00100018652100000045'})
    AADD(_aRet,{'00100018652500000010'})
    AADD(_aRet,{'00100018652500000016'})
    AADD(_aRet,{'00100018652800000012'})
    AADD(_aRet,{'00100018652800000027'})
    AADD(_aRet,{'00100018652800000028'})
    AADD(_aRet,{'00100018653100000001'})
    AADD(_aRet,{'00100018653100000010'})
    AADD(_aRet,{'00100018653100000015'})
    AADD(_aRet,{'00100018653600000022'})
    AADD(_aRet,{'00100018653600000025'})
    AADD(_aRet,{'00100018653600000026'})
    AADD(_aRet,{'00100018841700000003'})
    AADD(_aRet,{'00100018841700000009'})
    AADD(_aRet,{'00100018842300000002'})
    AADD(_aRet,{'00100018842300000029'})
    AADD(_aRet,{'00100018842300000030'})
    AADD(_aRet,{'00100018842300000033'})
    AADD(_aRet,{'00100018842300000044'})
    AADD(_aRet,{'00100018842300000051'})
    AADD(_aRet,{'00100018842300000075'})
    AADD(_aRet,{'00100018842900000007'})
    AADD(_aRet,{'00190019176800000007'})
    AADD(_aRet,{'00190019176800000011'})
    AADD(_aRet,{'00190019176800000031'})
    AADD(_aRet,{'00190019176800000034'})
    AADD(_aRet,{'00190019176800000046'})
    AADD(_aRet,{'00190019176800000049'})
    AADD(_aRet,{'00190019176800000095'})
    AADD(_aRet,{'00190019176800000098'})
    AADD(_aRet,{'00190019177000000018'})
    AADD(_aRet,{'00190019177000000029'})
    AADD(_aRet,{'00190019177000000030'})
    AADD(_aRet,{'00190019177000000031'})
    AADD(_aRet,{'00190019177000000036'})
    AADD(_aRet,{'00190019177000000042'})
    AADD(_aRet,{'00190019177000000044'})
    AADD(_aRet,{'00190019177400000010'})
    AADD(_aRet,{'00190019177400000016'})
    AADD(_aRet,{'00190019177400000017'})
    AADD(_aRet,{'00190019177400000025'})
    AADD(_aRet,{'00190019177400000032'})
    AADD(_aRet,{'00190019177400000037'})
    AADD(_aRet,{'00190019177400000045'})
    AADD(_aRet,{'00190019177400000047'})
    AADD(_aRet,{'00190019177400000049'})
    AADD(_aRet,{'00190019177400000050'})
    AADD(_aRet,{'00190019177600000004'})
    AADD(_aRet,{'00190019177600000020'})
    AADD(_aRet,{'00190019177600000024'})
    AADD(_aRet,{'00190019177600000026'})
    AADD(_aRet,{'00190019177600000034'})
    AADD(_aRet,{'00190019177600000039'})
    AADD(_aRet,{'00190019177600000053'})
    AADD(_aRet,{'00190019178300000002'})
    AADD(_aRet,{'00190019178300000019'})
    AADD(_aRet,{'00190019178300000024'})
    AADD(_aRet,{'00190019178300000025'})
    AADD(_aRet,{'00190019178300000036'})
    AADD(_aRet,{'00190019178300000038'})
    AADD(_aRet,{'00190019178300000046'})
    AADD(_aRet,{'00190019178300000055'})
    AADD(_aRet,{'00190019178300000072'})
    AADD(_aRet,{'00190019178400000004'})
    AADD(_aRet,{'00190019178400000007'})
    AADD(_aRet,{'00190019178400000011'})
    AADD(_aRet,{'00190019178400000015'})
    AADD(_aRet,{'00190019178400000027'})
    AADD(_aRet,{'00190019178400000042'})
    AADD(_aRet,{'00190019178400000058'})
    AADD(_aRet,{'00190019178400000065'})
    AADD(_aRet,{'00190019178400000066'})
    AADD(_aRet,{'00190019178500000012'})
    AADD(_aRet,{'00190019178500000029'})
    AADD(_aRet,{'00190019179100000010'})
    AADD(_aRet,{'00190019179100000011'})
    AADD(_aRet,{'00190019179100000018'})
    AADD(_aRet,{'00190019179100000023'})
    AADD(_aRet,{'00190019179100000029'})
    AADD(_aRet,{'00190019179100000040'})
    AADD(_aRet,{'00190019182600000002'})
    AADD(_aRet,{'00190019182600000004'})
    AADD(_aRet,{'00190019182600000009'})
    AADD(_aRet,{'00190019185300000009'})
    AADD(_aRet,{'00190019185300000013'})
    AADD(_aRet,{'00190019185300000015'})
    AADD(_aRet,{'00190019185300000017'})
    AADD(_aRet,{'00190019185300000060'})
    AADD(_aRet,{'00190019306900000001'})
    AADD(_aRet,{'00190019306900000005'})
    AADD(_aRet,{'00190019306900000013'})
    AADD(_aRet,{'00190019306900000032'})
    AADD(_aRet,{'00190019307000000001'})
    AADD(_aRet,{'00190019307000000007'})
    AADD(_aRet,{'00190019307000000014'})
    AADD(_aRet,{'00190019307000000038'})
    AADD(_aRet,{'00190019307000000045'})
    AADD(_aRet,{'00190019307000000055'})
    AADD(_aRet,{'00190019307000000057'})
    AADD(_aRet,{'00190019307800000017'})
    AADD(_aRet,{'00190019307800000020'})
    AADD(_aRet,{'00190019307800000023'})
    AADD(_aRet,{'00190019307800000030'})
    AADD(_aRet,{'00190019307800000037'})
    AADD(_aRet,{'00190019307900000012'})
    AADD(_aRet,{'00190019308200000010'})
    AADD(_aRet,{'00190019308500000001'})
    AADD(_aRet,{'00190019308600000026'})
    AADD(_aRet,{'00190019308800000007'})
    AADD(_aRet,{'00190019308800000012'})
    AADD(_aRet,{'00190019309100000018'})
    AADD(_aRet,{'00190019309100000023'})
    AADD(_aRet,{'00190019309100000026'})
    AADD(_aRet,{'00190019309100000030'})
    AADD(_aRet,{'00190019309100000040'})
    AADD(_aRet,{'00190019309100000058'})
    AADD(_aRet,{'00190019309100000062'})
    AADD(_aRet,{'00190019309100000064'})
    AADD(_aRet,{'00190019309100000080'})
    AADD(_aRet,{'00190019309300000003'})
    AADD(_aRet,{'00190019309500000025'})
    AADD(_aRet,{'00190019309500000027'})
    AADD(_aRet,{'00190019309500000039'})
    AADD(_aRet,{'00190019309600000007'})
    AADD(_aRet,{'00190019309800000011'})
    AADD(_aRet,{'00190019309800000014'})
    AADD(_aRet,{'00190019309900000010'})
    AADD(_aRet,{'00190019309900000013'})
    AADD(_aRet,{'00190019309900000023'})
    AADD(_aRet,{'00190019310100000007'})
    AADD(_aRet,{'00190019310100000017'})
    AADD(_aRet,{'00190019310100000040'})
    AADD(_aRet,{'00190019310600000010'})
    AADD(_aRet,{'00190019310800000014'})
    AADD(_aRet,{'00190019310800000026'})
    AADD(_aRet,{'00190019310800000030'})
    AADD(_aRet,{'00190019310800000050'})
    AADD(_aRet,{'00190019311200000003'})
    AADD(_aRet,{'00190019311200000024'})
    AADD(_aRet,{'00190019311200000035'})
    AADD(_aRet,{'00190019311200000036'})
    AADD(_aRet,{'00190019311200000046'})
    AADD(_aRet,{'00190019311200000054'})
    AADD(_aRet,{'00190019311400000004'})
    AADD(_aRet,{'00190019311400000005'})
    AADD(_aRet,{'00190019311600000005'})
    AADD(_aRet,{'00190019311600000007'})
    AADD(_aRet,{'00190019311600000008'})
    AADD(_aRet,{'00190019311600000014'})
    AADD(_aRet,{'00190019311600000020'})
    AADD(_aRet,{'00190019311700000007'})
    AADD(_aRet,{'00190019311700000015'})
    AADD(_aRet,{'00190019311800000005'})
    AADD(_aRet,{'00190019311800000028'})
    AADD(_aRet,{'00190019311800000039'})
    AADD(_aRet,{'00190019311800000043'})
    AADD(_aRet,{'00190019311800000044'})
    AADD(_aRet,{'00190019311800000048'})
    AADD(_aRet,{'00190019311800000052'})
    AADD(_aRet,{'00190019311800000056'})
    AADD(_aRet,{'00190019311900000010'})
    AADD(_aRet,{'00190019311900000023'})
    AADD(_aRet,{'00190019311900000035'})
    AADD(_aRet,{'00190019346500000001'})
    AADD(_aRet,{'00190019346500000009'})
    AADD(_aRet,{'00190019346500000012'})
    AADD(_aRet,{'00190019346500000013'})
    AADD(_aRet,{'00190019346500000014'})
    AADD(_aRet,{'00190019346500000017'})
    AADD(_aRet,{'00190019346500000020'})
    AADD(_aRet,{'00190019346500000023'})
    AADD(_aRet,{'00190019346500000026'})
    AADD(_aRet,{'00190019346500000027'})
    AADD(_aRet,{'00020018800800000003'})
    AADD(_aRet,{'00020018801100000071'})
    AADD(_aRet,{'00020018801600000023'})
    AADD(_aRet,{'00020018802300000020'})
    AADD(_aRet,{'00020018996800000008'})
    AADD(_aRet,{'00100020639600000303'})
    AADD(_aRet,{'00020019103800000001'})
    AADD(_aRet,{'00190020426100000252'})
    AADD(_aRet,{'00190019977000000035'})
    AADD(_aRet,{'00020018671400000029'})
    AADD(_aRet,{'00020018800400000083'})
    AADD(_aRet,{'00020018801800000012'})
    AADD(_aRet,{'00020018671100000037'})
    AADD(_aRet,{'00100018242000000308'})
    AADD(_aRet,{'00100018242000000311'})
    AADD(_aRet,{'00020018727100000005'})
    AADD(_aRet,{'00020018727200000001'})
    AADD(_aRet,{'00020018718900000015'})
    AADD(_aRet,{'00100016570000000014'})
    AADD(_aRet,{'00100016570000000018'})
    AADD(_aRet,{'00100018653200000006'})
    AADD(_aRet,{'00190019978000000307'})
    AADD(_aRet,{'00020018996000000062'})
    AADD(_aRet,{'00020018996400000035'})
    AADD(_aRet,{'90000018660300000100'})
    AADD(_aRet,{'90000018848300000057'})
    AADD(_aRet,{'00020018765300000001'})
    AADD(_aRet,{'00020018781200000002'})
    AADD(_aRet,{'00020018781200000016'})
    AADD(_aRet,{'00020018962600000010'})
    AADD(_aRet,{'00020018811300000034'})
    AADD(_aRet,{'00020019265100000007'})
    AADD(_aRet,{'00190017436400000013'})
    AADD(_aRet,{'00020018948800000001'})
    AADD(_aRet,{'00010019132200000018'})
    AADD(_aRet,{'00010019132200000019'})
    AADD(_aRet,{'00010019132200000032'})
    AADD(_aRet,{'00010019132300000015'})
    AADD(_aRet,{'00010019132300000019'})
    AADD(_aRet,{'00010019132300000034'})
    AADD(_aRet,{'00020018734300000001'})
    AADD(_aRet,{'00020018734300000005'})
    AADD(_aRet,{'00020018734400000036'})
    AADD(_aRet,{'00020018745400000019'})
    AADD(_aRet,{'00020018745400000070'})
    AADD(_aRet,{'00020018745500000011'})
    AADD(_aRet,{'00020018745500000019'})
    AADD(_aRet,{'00020018745500000021'})
    AADD(_aRet,{'00020018753300000004'})
    AADD(_aRet,{'00020018753300000009'})
    AADD(_aRet,{'00020018753300000010'})
    AADD(_aRet,{'00020018753300000022'})
    AADD(_aRet,{'00020018910200000065'})
    AADD(_aRet,{'00020018977700000006'})
    AADD(_aRet,{'00020018977700000013'})
    AADD(_aRet,{'00020018977700000034'})
    AADD(_aRet,{'00020018977700000040'})
    AADD(_aRet,{'00020018977900000001'})
    AADD(_aRet,{'00020018977900000029'})
    AADD(_aRet,{'00020018979400000003'})
    AADD(_aRet,{'00020018979400000006'})
    AADD(_aRet,{'00020018954700000002'})
    AADD(_aRet,{'00010018741600000003'})
    AADD(_aRet,{'00020018962600000004'})
    AADD(_aRet,{'00020018671100000016'})
    AADD(_aRet,{'00020018800500000016'})
    AADD(_aRet,{'00020018801000000002'})
    AADD(_aRet,{'00020018801800000080'})
    AADD(_aRet,{'00020018802200000001'})
    AADD(_aRet,{'00020019316800000077'})
    AADD(_aRet,{'00100019575700000054'})
    AADD(_aRet,{'00100019575700000144'})
    AADD(_aRet,{'00020018788700000040'})
    AADD(_aRet,{'00020018791900000020'})
    AADD(_aRet,{'00020019006200000014'})
    AADD(_aRet,{'00020019056200000003'})
    AADD(_aRet,{'00190020425900000124'})
    AADD(_aRet,{'00020018959000000003'})
    AADD(_aRet,{'00100018843300000013'})
    AADD(_aRet,{'00020018793000000033'})
    AADD(_aRet,{'00190020425800000298'})
    AADD(_aRet,{'00020018994400000016'})
    AADD(_aRet,{'00100017199600000034'})
    AADD(_aRet,{'00020018664500000007'})
    AADD(_aRet,{'00020018664500000010'})
    AADD(_aRet,{'00020018963600000014'})
    AADD(_aRet,{'00020018764600000012'})
    AADD(_aRet,{'00020018730300000004'})
    AADD(_aRet,{'00020018745900000014'})
    AADD(_aRet,{'00020018746100000026'})
    AADD(_aRet,{'00020018746100000030'})
    AADD(_aRet,{'00020018746800000006'})
    AADD(_aRet,{'00020018746800000009'})
    AADD(_aRet,{'00020019167600000005'})
    AADD(_aRet,{'00020018801100000077'})
    AADD(_aRet,{'00020018802300000067'})
    AADD(_aRet,{'00020018996100000054'})
    AADD(_aRet,{'00020019502100000072'})
    AADD(_aRet,{'00020020809000000008'})
    AADD(_aRet,{'00020020378200000017'})
    AADD(_aRet,{'00100018243500000023'})
    AADD(_aRet,{'00020018801200000070'})
    AADD(_aRet,{'00100020639600000296'})
    AADD(_aRet,{'00190019977000000096'})
    AADD(_aRet,{'00020018807600000010'})
    AADD(_aRet,{'00100018245600000001'})
    AADD(_aRet,{'00020018996000000064'})
    AADD(_aRet,{'00100018837600000050'})
    AADD(_aRet,{'00100019575700000145'})
    AADD(_aRet,{'00190016275600000035'})
    AADD(_aRet,{'90000018468800000392'})
    AADD(_aRet,{'90000018660300000115'})
    AADD(_aRet,{'90000018848300000022'})
    AADD(_aRet,{'00020018792200000002'})
    AADD(_aRet,{'00130018607600000014'})
    AADD(_aRet,{'00100017199200000054'})
    AADD(_aRet,{'00100018837600000186'})
    AADD(_aRet,{'00100018839000000044'})
    AADD(_aRet,{'00010018732800000003'})
    AADD(_aRet,{'00020018663700000001'})
    AADD(_aRet,{'00020018669600000001'})
    AADD(_aRet,{'00020018741100000012'})
    AADD(_aRet,{'00020018742200000021'})
    AADD(_aRet,{'00020018742200000022'})
    AADD(_aRet,{'00020018742200000047'})
    AADD(_aRet,{'00020018921500000029'})
    AADD(_aRet,{'00100014821100000036'})
    AADD(_aRet,{'00100018242300000039'})
    AADD(_aRet,{'00190018472700000004'})
    AADD(_aRet,{'00190018716200000001'})
    AADD(_aRet,{'00010019244100000001'})
    AADD(_aRet,{'00020018670700000001'})
    AADD(_aRet,{'00020018670700000047'})
    AADD(_aRet,{'00020018670700000057'})
    AADD(_aRet,{'00020018670700000058'})
    AADD(_aRet,{'00020018670700000064'})
    AADD(_aRet,{'00020018670700000065'})
    AADD(_aRet,{'00020018670700000074'})
    AADD(_aRet,{'00020018670700000075'})
    AADD(_aRet,{'00020018671700000003'})
    AADD(_aRet,{'00020018671700000004'})
    AADD(_aRet,{'00020018671700000016'})
    AADD(_aRet,{'00020018671700000017'})
    AADD(_aRet,{'00020018671700000022'})
    AADD(_aRet,{'00020018861200000012'})
    AADD(_aRet,{'00020020234700000018'})
    AADD(_aRet,{'00100016354300000013'})
    AADD(_aRet,{'00100016354300000043'})
    AADD(_aRet,{'00100017199600000036'})
    AADD(_aRet,{'00020018772600000003'})
    AADD(_aRet,{'00190019185300000005'})
    AADD(_aRet,{'00190019185300000006'})
    AADD(_aRet,{'00020018773300000009'})
    AADD(_aRet,{'00020018810700000003'})
    AADD(_aRet,{'00020018955600000001'})
    AADD(_aRet,{'00100018244100000002'})
    AADD(_aRet,{'00020018800400000026'})
    AADD(_aRet,{'00020018800500000015'})
    AADD(_aRet,{'00020018801000000071'})
    AADD(_aRet,{'00020018801100000046'})
    AADD(_aRet,{'00020018801200000046'})
    AADD(_aRet,{'00020018801200000060'})
    AADD(_aRet,{'00020018801300000012'})
    AADD(_aRet,{'00020018801700000013'})
    AADD(_aRet,{'00020018954700000003'})
    AADD(_aRet,{'00020018996100000026'})
    AADD(_aRet,{'00020018996100000046'})
    AADD(_aRet,{'00020018996400000017'})
    AADD(_aRet,{'00020018996400000064'})
    AADD(_aRet,{'00100018837500000005'})
    AADD(_aRet,{'00100019575700000005'})
    AADD(_aRet,{'00100017199600000035'})
    AADD(_aRet,{'00020018779900000006'})
    AADD(_aRet,{'00020018786700000003'})
    AADD(_aRet,{'00020018795000000016'})
    AADD(_aRet,{'00020018973700000001'})
    AADD(_aRet,{'00010018815600000006'})
    AADD(_aRet,{'00010018815600000011'})
    AADD(_aRet,{'00020020030100000013'})
    AADD(_aRet,{'00020020236100000036'})
    AADD(_aRet,{'00020020486300000002'})
    AADD(_aRet,{'00020020501900000023'})
    AADD(_aRet,{'00020020501900000033'})
    AADD(_aRet,{'00020020964000000019'})
    AADD(_aRet,{'00020019454400000004'})
    AADD(_aRet,{'00020018744600000005'})
    AADD(_aRet,{'00020018832000000025'})
    AADD(_aRet,{'00020018919300000022'})
    AADD(_aRet,{'00020020297800000006'})
    AADD(_aRet,{'00020018739500000034'})
    AADD(_aRet,{'00020018779200000045'})
    AADD(_aRet,{'00190018473300000013'})
    AADD(_aRet,{'00020018846400000003'})
    AADD(_aRet,{'00020018781200000001'})
    AADD(_aRet,{'00020018962600000016'})
    AADD(_aRet,{'00010018676700000002'})
    AADD(_aRet,{'00010018677700000001'})
    AADD(_aRet,{'00010018677700000005'})
    AADD(_aRet,{'00010018702200000005'})
    AADD(_aRet,{'00010018704100000003'})
    AADD(_aRet,{'00010018704800000004'})
    AADD(_aRet,{'00010018704800000005'})
    AADD(_aRet,{'00010018704800000006'})
    AADD(_aRet,{'00010018704800000007'})
    AADD(_aRet,{'00010018705400000001'})
    AADD(_aRet,{'00010018705500000002'})
    AADD(_aRet,{'00010018705500000005'})
    AADD(_aRet,{'00010018705500000007'})
    AADD(_aRet,{'00010018711800000001'})
    AADD(_aRet,{'00010018712400000011'})
    AADD(_aRet,{'00010018712700000003'})
    AADD(_aRet,{'00010018714200000003'})
    AADD(_aRet,{'00010018715800000004'})
    AADD(_aRet,{'00010018715800000007'})
    AADD(_aRet,{'00010018715800000009'})
    AADD(_aRet,{'00010018715800000016'})
    AADD(_aRet,{'00010018715900000003'})
    AADD(_aRet,{'00010018724800000005'})
    AADD(_aRet,{'00010018730800000006'})
    AADD(_aRet,{'00010018732500000001'})
    AADD(_aRet,{'00010018732700000002'})
    AADD(_aRet,{'00010018733500000005'})
    AADD(_aRet,{'00010018741300000001'})
    AADD(_aRet,{'00010018750500000003'})
    AADD(_aRet,{'00010018753200000007'})
    AADD(_aRet,{'00010018819000000002'})
    AADD(_aRet,{'00010018819300000005'})
    AADD(_aRet,{'00010018819300000009'})
    AADD(_aRet,{'00010018826600000001'})
    AADD(_aRet,{'00010018826600000002'})
    AADD(_aRet,{'00010018850400000002'})
    AADD(_aRet,{'00010018852300000002'})
    AADD(_aRet,{'00010018855700000001'})
    AADD(_aRet,{'00010018873900000004'})
    AADD(_aRet,{'00010018874500000002'})
    AADD(_aRet,{'00010018895400000002'})
    AADD(_aRet,{'00010018898400000001'})
    AADD(_aRet,{'00010018898400000002'})
    AADD(_aRet,{'00010018898400000003'})
    AADD(_aRet,{'00010018900400000004'})
    AADD(_aRet,{'00010018901900000002'})
    AADD(_aRet,{'00010019000100000004'})
    AADD(_aRet,{'00010019020800000002'})
    AADD(_aRet,{'00010019039400000009'})
    AADD(_aRet,{'00010019242900000001'})
    AADD(_aRet,{'00010019389300000002'})
    AADD(_aRet,{'00020018487400000001'})
    AADD(_aRet,{'00020018487400000003'})
    AADD(_aRet,{'00020018487400000025'})
    AADD(_aRet,{'00020018662900000004'})
    AADD(_aRet,{'00020018663600000004'})
    AADD(_aRet,{'00020018664400000009'})
    AADD(_aRet,{'00020018664400000011'})
    AADD(_aRet,{'00020018664400000012'})
    AADD(_aRet,{'00020018664400000021'})
    AADD(_aRet,{'00020018664400000028'})
    AADD(_aRet,{'00020018666200000001'})
    AADD(_aRet,{'00020018666400000006'})
    AADD(_aRet,{'00020018667000000003'})
    AADD(_aRet,{'00020018667000000006'})
    AADD(_aRet,{'00020018667400000002'})
    AADD(_aRet,{'00020018667400000007'})
    AADD(_aRet,{'00020018667400000008'})
    AADD(_aRet,{'00020018667400000010'})
    AADD(_aRet,{'00020018668500000004'})
    AADD(_aRet,{'00020018669100000001'})
    AADD(_aRet,{'00020018669500000003'})
    AADD(_aRet,{'00020018669800000006'})
    AADD(_aRet,{'00020018672600000002'})
    AADD(_aRet,{'00020018682300000008'})
    AADD(_aRet,{'00020018682700000008'})
    AADD(_aRet,{'00020018684200000004'})
    AADD(_aRet,{'00020018684200000010'})
    AADD(_aRet,{'00020018684200000018'})
    AADD(_aRet,{'00020018684200000020'})
    AADD(_aRet,{'00020018684500000004'})
    AADD(_aRet,{'00020018685000000002'})
    AADD(_aRet,{'00020018685000000010'})
    AADD(_aRet,{'00020018685700000013'})
    AADD(_aRet,{'00020018686000000001'})
    AADD(_aRet,{'00020018686000000011'})
    AADD(_aRet,{'00020018687200000002'})
    AADD(_aRet,{'00020018687200000005'})
    AADD(_aRet,{'00020018687800000004'})
    AADD(_aRet,{'00020018688400000001'})
    AADD(_aRet,{'00020018689200000001'})
    AADD(_aRet,{'00020018689200000004'})
    AADD(_aRet,{'00020018693400000001'})
    AADD(_aRet,{'00020018695300000007'})
    AADD(_aRet,{'00020018697200000001'})
    AADD(_aRet,{'00020018697200000002'})
    AADD(_aRet,{'00020018697200000006'})
    AADD(_aRet,{'00020018697700000001'})
    AADD(_aRet,{'00020018697900000016'})
    AADD(_aRet,{'00020018698400000002'})
    AADD(_aRet,{'00020018698800000017'})
    AADD(_aRet,{'00020018699200000002'})
    AADD(_aRet,{'00020018699200000006'})
    AADD(_aRet,{'00020018699900000007'})
    AADD(_aRet,{'00020018699900000008'})
    AADD(_aRet,{'00020018700800000003'})
    AADD(_aRet,{'00020018701100000001'})
    AADD(_aRet,{'00020018707700000009'})
    AADD(_aRet,{'00020018709300000007'})
    AADD(_aRet,{'00020018709400000007'})
    AADD(_aRet,{'00020018709900000012'})
    AADD(_aRet,{'00020018710400000002'})
    AADD(_aRet,{'00020018761500000012'})
    AADD(_aRet,{'00020018762800000003'})
    AADD(_aRet,{'00020018782200000004'})
    AADD(_aRet,{'00020018786200000013'})
    AADD(_aRet,{'00020018790900000002'})
    AADD(_aRet,{'00020018825000000003'})
    AADD(_aRet,{'00020018853400000004'})
    AADD(_aRet,{'00020018853500000003'})
    AADD(_aRet,{'00020018856400000002'})
    AADD(_aRet,{'00020018856400000010'})
    AADD(_aRet,{'00020018857500000002'})
    AADD(_aRet,{'00020018857500000004'})
    AADD(_aRet,{'00020018857900000001'})
    AADD(_aRet,{'00020018870400000004'})
    AADD(_aRet,{'00020018873100000003'})
    AADD(_aRet,{'00020018876900000006'})
    AADD(_aRet,{'00020018882400000001'})
    AADD(_aRet,{'00020018882800000004'})
    AADD(_aRet,{'00020018889000000007'})
    AADD(_aRet,{'00020018889000000009'})
    AADD(_aRet,{'00020018889300000001'})
    AADD(_aRet,{'00020018889300000003'})
    AADD(_aRet,{'00020018889300000008'})
    AADD(_aRet,{'00020018889300000010'})
    AADD(_aRet,{'00020018891800000002'})
    AADD(_aRet,{'00020018915000000004'})
    AADD(_aRet,{'00020018955300000001'})
    AADD(_aRet,{'00020019056000000007'})
    AADD(_aRet,{'00020019077500000003'})
    AADD(_aRet,{'00020019126800000005'})
    AADD(_aRet,{'00020019209900000023'})
    AADD(_aRet,{'00020019209900000025'})
    AADD(_aRet,{'00020019651800000010'})
    AADD(_aRet,{'90000018660300000059'})
    AADD(_aRet,{'00020018889000000002'})
    AADD(_aRet,{'00020018697900000001'})
    AADD(_aRet,{'00020018697900000017'})
    AADD(_aRet,{'00020018686300000005'})
    AADD(_aRet,{'00020018814600000004'})
    AADD(_aRet,{'00020018982800000013'})
    AADD(_aRet,{'00020018761500000010'})
    AADD(_aRet,{'00010018649600000006'})
    AADD(_aRet,{'00010019795900000008'})
    AADD(_aRet,{'00020018508500000001'})
    AADD(_aRet,{'00020018662700000003'})
    AADD(_aRet,{'00020018666900000001'})
    AADD(_aRet,{'00020018668600000006'})
    AADD(_aRet,{'00020018683700000007'})
    AADD(_aRet,{'00020018686800000005'})
    AADD(_aRet,{'00020018686800000008'})
    AADD(_aRet,{'00020018688500000024'})
    AADD(_aRet,{'00020018690400000002'})
    AADD(_aRet,{'00020018708600000005'})
    AADD(_aRet,{'00020018709900000008'})
    AADD(_aRet,{'00020018710300000003'})
    AADD(_aRet,{'00020018710300000004'})
    AADD(_aRet,{'00020018726200000033'})
    AADD(_aRet,{'00020018729000000001'})
    AADD(_aRet,{'00020018729000000003'})
    AADD(_aRet,{'00020018788800000054'})
    AADD(_aRet,{'00020018791900000007'})
    AADD(_aRet,{'00020018810400000005'})
    AADD(_aRet,{'00020018881400000004'})
    AADD(_aRet,{'00020018885300000002'})
    AADD(_aRet,{'00020018886800000002'})
    AADD(_aRet,{'00020018914300000001'})
    AADD(_aRet,{'00020018916300000004'})
    AADD(_aRet,{'00020018916300000009'})
    AADD(_aRet,{'00020019119900000010'})
    AADD(_aRet,{'90000018660300000197'})
    AADD(_aRet,{'00020018664500000006'})
    AADD(_aRet,{'00020018828200000003'})
    AADD(_aRet,{'00020018948500000008'})
    AADD(_aRet,{'00020018687000000002'})
    AADD(_aRet,{'00100018467000000005'})
    AADD(_aRet,{'00020018846400000001'})
    AADD(_aRet,{'00100018843300000014'})
    AADD(_aRet,{'00020018670200000002'})
    AADD(_aRet,{'00020018670200000005'})
    AADD(_aRet,{'00020018682800000003'})
    AADD(_aRet,{'00020018696400000012'})
    AADD(_aRet,{'00020018760700000002'})
    AADD(_aRet,{'00020018760700000004'})
    AADD(_aRet,{'00020018761400000005'})
    AADD(_aRet,{'00020018887800000002'})
    AADD(_aRet,{'00020018887800000004'})
    AADD(_aRet,{'00020018887800000008'})
    AADD(_aRet,{'00020018887800000009'})
    AADD(_aRet,{'00020018887800000011'})
    AADD(_aRet,{'00020018887800000012'})
    AADD(_aRet,{'00020018887800000027'})
    AADD(_aRet,{'00020018933200000001'})
    AADD(_aRet,{'00020018983300000008'})
    AADD(_aRet,{'00020018983300000014'})
    AADD(_aRet,{'00020019116900000012'})
    AADD(_aRet,{'00190016276100000015'})
    AADD(_aRet,{'00190016978700000036'})
    AADD(_aRet,{'00190017436400000002'})
    AADD(_aRet,{'00190017910000000012'})
    AADD(_aRet,{'00020019413600000003'})
    AADD(_aRet,{'00020018984900000001'})
    AADD(_aRet,{'00020019006100000002'})
    AADD(_aRet,{'00020018996100000083'})
    AADD(_aRet,{'00020018727200000002'})
    AADD(_aRet,{'00020018783100000009'})
    AADD(_aRet,{'00020018783100000015'})
    AADD(_aRet,{'00020020281600000007'})
    AADD(_aRet,{'00020020282100000022'})
    AADD(_aRet,{'00020018962600000012'})
    AADD(_aRet,{'00020018727000000001'})
    AADD(_aRet,{'00020018560700000002'})
    AADD(_aRet,{'00020018560700000008'})
    AADD(_aRet,{'00020018708300000005'})
    AADD(_aRet,{'00020018734000000026'})
    AADD(_aRet,{'00020018734000000030'})
    AADD(_aRet,{'00020018735500000023'})
    AADD(_aRet,{'00020018757700000022'})
    AADD(_aRet,{'00020018757700000024'})
    AADD(_aRet,{'00020018757700000028'})
    AADD(_aRet,{'00020018758100000017'})
    AADD(_aRet,{'00020018758100000020'})
    AADD(_aRet,{'00020018760300000024'})
    AADD(_aRet,{'00020018760300000032'})
    AADD(_aRet,{'00020018760300000046'})
    AADD(_aRet,{'00020018760500000007'})
    AADD(_aRet,{'00020018760900000005'})
    AADD(_aRet,{'00020018769100000008'})
    AADD(_aRet,{'00020018771800000005'})
    AADD(_aRet,{'00020018775400000003'})
    AADD(_aRet,{'00020018775900000003'})
    AADD(_aRet,{'00020018775900000004'})
    AADD(_aRet,{'00020018778100000007'})
    AADD(_aRet,{'00020018778100000009'})
    AADD(_aRet,{'00020018780500000003'})
    AADD(_aRet,{'00020018780500000005'})
    AADD(_aRet,{'00020018780500000012'})
    AADD(_aRet,{'00020018782400000005'})
    AADD(_aRet,{'00020018782400000025'})
    AADD(_aRet,{'00020018782800000010'})
    AADD(_aRet,{'00020018785600000002'})
    AADD(_aRet,{'00020018787300000002'})
    AADD(_aRet,{'00020018787300000003'})
    AADD(_aRet,{'00020018789800000026'})
    AADD(_aRet,{'00020018789800000029'})
    AADD(_aRet,{'00020018809600000017'})
    AADD(_aRet,{'00020018810000000003'})
    AADD(_aRet,{'00020018812400000005'})
    AADD(_aRet,{'00020018812400000009'})
    AADD(_aRet,{'00020018812600000002'})
    AADD(_aRet,{'00020018812800000005'})
    AADD(_aRet,{'00020018812800000008'})
    AADD(_aRet,{'00020018813300000005'})
    AADD(_aRet,{'00020018813300000022'})
    AADD(_aRet,{'00020018813500000002'})
    AADD(_aRet,{'00020018813500000004'})
    AADD(_aRet,{'00020018813500000012'})
    AADD(_aRet,{'00020018847100000001'})
    AADD(_aRet,{'00020018928900000019'})
    AADD(_aRet,{'00020018928900000020'})
    AADD(_aRet,{'00020018942300000002'})
    AADD(_aRet,{'00020018942800000001'})
    AADD(_aRet,{'00020018945700000009'})
    AADD(_aRet,{'00020018952700000007'})
    AADD(_aRet,{'00020018961300000001'})
    AADD(_aRet,{'00020018961300000002'})
    AADD(_aRet,{'00020018966900000003'})
    AADD(_aRet,{'00020018968500000001'})
    AADD(_aRet,{'00020018969900000002'})
    AADD(_aRet,{'00020018985100000001'})
    AADD(_aRet,{'00020018987700000015'})
    AADD(_aRet,{'00020018987700000028'})
    AADD(_aRet,{'00020019161100000028'})
    AADD(_aRet,{'00020019454300000021'})
    AADD(_aRet,{'00020019744700000007'})
    AADD(_aRet,{'90000019022600000111'})
    AADD(_aRet,{'00190016275500000025'})
    AADD(_aRet,{'00100018242300000030'})
    AADD(_aRet,{'00020018812900000009'})
    AADD(_aRet,{'00020018725300000001'})
    AADD(_aRet,{'00020018758000000007'})
    AADD(_aRet,{'00020018951400000001'})
    AADD(_aRet,{'00010018976800000006'})
    AADD(_aRet,{'00020018721500000003'})
    AADD(_aRet,{'00020018759600000003'})
    AADD(_aRet,{'00020018759600000006'})
    AADD(_aRet,{'00020018759600000009'})
    AADD(_aRet,{'00020018759600000010'})
    AADD(_aRet,{'00020018768100000001'})
    AADD(_aRet,{'00020018768800000004'})
    AADD(_aRet,{'00020018777600000001'})
    AADD(_aRet,{'00020018784200000001'})
    AADD(_aRet,{'00020018785800000004'})
    AADD(_aRet,{'00020018814000000011'})
    AADD(_aRet,{'00020018814100000014'})
    AADD(_aRet,{'00020018814100000015'})
    AADD(_aRet,{'00020018814100000090'})
    AADD(_aRet,{'00020018828100000002'})
    AADD(_aRet,{'00020018936600000001'})
    AADD(_aRet,{'00020018951000000001'})
    AADD(_aRet,{'00020018993200000001'})
    AADD(_aRet,{'00100017198600000063'})
    AADD(_aRet,{'00100017198600000064'})
    AADD(_aRet,{'00100017199500000048'})
    AADD(_aRet,{'00100017199500000055'})
    AADD(_aRet,{'00100018657400000004'})
    AADD(_aRet,{'00100018838600000020'})
    AADD(_aRet,{'00100018838600000021'})
    AADD(_aRet,{'00100018838600000027'})
    AADD(_aRet,{'00100018838700000040'})
    AADD(_aRet,{'00100018838700000054'})
    AADD(_aRet,{'00100018838800000039'})
    AADD(_aRet,{'00100018838800000040'})
    AADD(_aRet,{'00100018838900000007'})
    AADD(_aRet,{'00100018839000000007'})
    AADD(_aRet,{'00100018839300000016'})
    AADD(_aRet,{'00100018839300000017'})
    AADD(_aRet,{'00100015277100000146'})
    AADD(_aRet,{'00020018962300000008'})
    AADD(_aRet,{'00020018792400000004'})
    AADD(_aRet,{'00020018792400000019'})
    AADD(_aRet,{'00100018657400000016'})
    AADD(_aRet,{'00100018242600000564'})
    AADD(_aRet,{'00100018242600000644'})
    AADD(_aRet,{'00020018996000000030'})
    AADD(_aRet,{'00020018718900000023'})
    AADD(_aRet,{'00020018963600000008'})
    AADD(_aRet,{'00020018747500000026'})
    AADD(_aRet,{'00020018747500000033'})
    AADD(_aRet,{'00020018758300000003'})
    AADD(_aRet,{'00020018758300000009'})
    AADD(_aRet,{'00020018760000000010'})
    AADD(_aRet,{'00020018762700000003'})
    AADD(_aRet,{'00020018770700000004'})
    AADD(_aRet,{'00020018770700000008'})
    AADD(_aRet,{'00020018955100000001'})
    AADD(_aRet,{'00100018838800000009'})
    AADD(_aRet,{'00100018242600000628'})
    AADD(_aRet,{'00020018798600000001'})
    AADD(_aRet,{'00020018798600000003'})
    AADD(_aRet,{'00020018798600000006'})
    AADD(_aRet,{'00020018798600000007'})
    AADD(_aRet,{'00020018798600000008'})
    AADD(_aRet,{'00020018798600000009'})
    AADD(_aRet,{'00020018798600000015'})
    AADD(_aRet,{'00020018962100000008'})
    AADD(_aRet,{'00100018050800000007'})
    AADD(_aRet,{'00100018050800000044'})
    AADD(_aRet,{'00100018050800000097'})
    AADD(_aRet,{'00100018050800000112'})
    AADD(_aRet,{'00100018050800000115'})
    AADD(_aRet,{'00100018050800000117'})
    AADD(_aRet,{'00100018050900000045'})
    AADD(_aRet,{'00100018050900000046'})
    AADD(_aRet,{'00100018050900000050'})
    AADD(_aRet,{'00100018050900000073'})
    AADD(_aRet,{'00020018781200000009'})
    AADD(_aRet,{'00010018824300000013'})
    AADD(_aRet,{'00020018794600000003'})
    AADD(_aRet,{'00020018970200000003'})
    AADD(_aRet,{'00020018751900000008'})
    AADD(_aRet,{'00020018751900000025'})
    AADD(_aRet,{'00020018751900000060'})
    AADD(_aRet,{'00020018751900000065'})
    AADD(_aRet,{'00020018751900000067'})
    AADD(_aRet,{'00020018753800000001'})
    AADD(_aRet,{'00020018753800000013'})
    AADD(_aRet,{'00020018759800000017'})
    AADD(_aRet,{'00020018926700000001'})
    AADD(_aRet,{'00020018944800000001'})
    AADD(_aRet,{'00020018944800000009'})
    AADD(_aRet,{'00020018978400000002'})
    AADD(_aRet,{'00020018662500000003'})
    AADD(_aRet,{'00020018662500000043'})
    AADD(_aRet,{'00020018662600000059'})
    AADD(_aRet,{'00020018754300000018'})
    AADD(_aRet,{'00020018754700000008'})
    AADD(_aRet,{'00020018754700000027'})
    AADD(_aRet,{'00020018754800000032'})
    AADD(_aRet,{'00020018919600000048'})
    AADD(_aRet,{'00020018919800000043'})
    AADD(_aRet,{'00020018943500000003'})
    AADD(_aRet,{'00020018735100000009'})
    AADD(_aRet,{'00020018742100000012'})
    AADD(_aRet,{'00190018473200000011'})
    AADD(_aRet,{'00100018242000000230'})
    AADD(_aRet,{'00100018837600000052'})
    AADD(_aRet,{'00100018242600000191'})
    AADD(_aRet,{'00020018996100000065'})
    AADD(_aRet,{'00020018812000000052'})
    AADD(_aRet,{'00020018812000000055'})
    AADD(_aRet,{'00100018242000000056'})
    AADD(_aRet,{'00100018242600000335'})
    AADD(_aRet,{'00100018242600000514'})
    AADD(_aRet,{'00010018680300000001'})
    AADD(_aRet,{'00010018680300000005'})
    AADD(_aRet,{'00010018680300000006'})
    AADD(_aRet,{'00010019280000000014'})
    AADD(_aRet,{'00010019605200000005'})
    AADD(_aRet,{'00010019605200000011'})
    AADD(_aRet,{'00010020006600000003'})
    AADD(_aRet,{'00010020006600000008'})
    AADD(_aRet,{'00010020008000000003'})
    AADD(_aRet,{'00010020008000000008'})
    AADD(_aRet,{'00010020465700000004'})
    AADD(_aRet,{'00010020465700000010'})
    AADD(_aRet,{'00010020466200000005'})
    AADD(_aRet,{'00010021002600000004'})
    AADD(_aRet,{'00010021002600000010'})
    AADD(_aRet,{'00020018695900000002'})
    AADD(_aRet,{'00020018770500000002'})
    AADD(_aRet,{'00020018773400000016'})
    AADD(_aRet,{'00020018781500000003'})
    AADD(_aRet,{'00020018789000000002'})
    AADD(_aRet,{'00020018789000000029'})
    AADD(_aRet,{'00020018789000000033'})
    AADD(_aRet,{'00020018789000000039'})
    AADD(_aRet,{'00020018789000000081'})
    AADD(_aRet,{'00020018790300000061'})
    AADD(_aRet,{'00020018803200000002'})
    AADD(_aRet,{'00020018803200000006'})
    AADD(_aRet,{'00020018803600000009'})
    AADD(_aRet,{'00020018803600000010'})
    AADD(_aRet,{'00020018803600000011'})
    AADD(_aRet,{'00020018803600000012'})
    AADD(_aRet,{'00020018803600000014'})
    AADD(_aRet,{'00020018803600000018'})
    AADD(_aRet,{'00020018810200000011'})
    AADD(_aRet,{'00020018959900000001'})
    AADD(_aRet,{'00020018959900000017'})
    AADD(_aRet,{'00020018959900000020'})
    AADD(_aRet,{'00020018963800000047'})
    AADD(_aRet,{'00020018963800000050'})
    AADD(_aRet,{'00020018985000000003'})
    AADD(_aRet,{'00020018989200000011'})
    AADD(_aRet,{'00020019504100000071'})
    AADD(_aRet,{'00020019510600000004'})
    AADD(_aRet,{'00020019692500000091'})
    AADD(_aRet,{'00020019925100000009'})
    AADD(_aRet,{'00020020374500000004'})
    AADD(_aRet,{'00020020602100000045'})
    AADD(_aRet,{'00020020611900000012'})
    AADD(_aRet,{'00020020819900000013'})
    AADD(_aRet,{'00010018676200000001'})
    AADD(_aRet,{'00010018676200000002'})
    AADD(_aRet,{'00010018676200000003'})
    AADD(_aRet,{'00010018676200000008'})
    AADD(_aRet,{'00010018676200000009'})
    AADD(_aRet,{'00010018676200000013'})
    AADD(_aRet,{'00010018906600000002'})
    AADD(_aRet,{'00100018475100000001'})
    AADD(_aRet,{'00100018475100000003'})
    AADD(_aRet,{'00100018475100000009'})
    AADD(_aRet,{'00020018956600000002'})
    AADD(_aRet,{'00190020425500000528'})
    AADD(_aRet,{'00020018767200000036'})
    AADD(_aRet,{'00190018472200000022'})
    AADD(_aRet,{'00020018787900000036'})
    AADD(_aRet,{'00020018807500000012'})
    AADD(_aRet,{'00020018807500000025'})
    AADD(_aRet,{'00020018807700000006'})
    AADD(_aRet,{'00020018807700000007'})
    AADD(_aRet,{'00020018807700000011'})
    AADD(_aRet,{'00020018807700000012'})
    AADD(_aRet,{'00020018807700000019'})
    AADD(_aRet,{'00020018807700000026'})
    AADD(_aRet,{'00020018984400000015'})
    AADD(_aRet,{'00020018911200000016'})
    AADD(_aRet,{'00100018244600000026'})
    AADD(_aRet,{'00020018787700000003'})
    AADD(_aRet,{'00020018812900000005'})
    AADD(_aRet,{'00020018759900000004'})
    AADD(_aRet,{'00020018810300000024'})
    AADD(_aRet,{'00020018969100000002'})
    AADD(_aRet,{'00020020991600000054'})
    AADD(_aRet,{'00100020694500000059'})
    AADD(_aRet,{'00020018962600000046'})
    AADD(_aRet,{'00020018791900000008'})
    AADD(_aRet,{'00020018802300000031'})
    AADD(_aRet,{'00020018949700000001'})
    AADD(_aRet,{'00020018950000000022'})
    AADD(_aRet,{'00020018950000000027'})
    AADD(_aRet,{'00020018955500000003'})
    AADD(_aRet,{'00020018996000000031'})
    AADD(_aRet,{'00020018996400000072'})
    AADD(_aRet,{'00020018996800000014'})
    AADD(_aRet,{'00100018242000000255'})
    AADD(_aRet,{'00100018242600000336'})
    AADD(_aRet,{'00100018242600000337'})
    AADD(_aRet,{'00100018242600000437'})
    AADD(_aRet,{'00100018242600000439'})
    AADD(_aRet,{'00100018242600000440'})
    AADD(_aRet,{'00100018242600000562'})
    AADD(_aRet,{'00100018242600000563'})
    AADD(_aRet,{'00100018242600000645'})
    AADD(_aRet,{'00100018242600001026'})
    AADD(_aRet,{'00100018244600000024'})
    AADD(_aRet,{'00100018837700000177'})
    AADD(_aRet,{'00100019575700000106'})
    AADD(_aRet,{'00100020153000000008'})
    AADD(_aRet,{'00190020425700000463'})
    AADD(_aRet,{'00020020102700000045'})
    AADD(_aRet,{'00020018786300000005'})
    AADD(_aRet,{'00190019307600000005'})
    AADD(_aRet,{'00020018984600000012'})
    AADD(_aRet,{'00020019265000000028'})
    AADD(_aRet,{'00100018242000000229'})
    AADD(_aRet,{'00010018677900000003'})
    AADD(_aRet,{'00010018712100000002'})
    AADD(_aRet,{'00010018712100000005'})
    AADD(_aRet,{'00010018817700000001'})
    AADD(_aRet,{'00010018819500000004'})
    AADD(_aRet,{'00010018838500000006'})
    AADD(_aRet,{'00010018855000000007'})
    AADD(_aRet,{'00010018855800000005'})
    AADD(_aRet,{'00010018895900000003'})
    AADD(_aRet,{'00010018999900000003'})
    AADD(_aRet,{'00010018999900000008'})
    AADD(_aRet,{'00010019004900000001'})
    AADD(_aRet,{'00010019008800000014'})
    AADD(_aRet,{'00010019041400000002'})
    AADD(_aRet,{'00010019041400000003'})
    AADD(_aRet,{'00020018486300000010'})
    AADD(_aRet,{'00020018663100000001'})
    AADD(_aRet,{'00020018663100000003'})
    AADD(_aRet,{'00020018663100000005'})
    AADD(_aRet,{'00020018663100000007'})
    AADD(_aRet,{'00020018663100000009'})
    AADD(_aRet,{'00020018663100000011'})
    AADD(_aRet,{'00020018665300000004'})
    AADD(_aRet,{'00020018665300000005'})
    AADD(_aRet,{'00020018665300000018'})
    AADD(_aRet,{'00020018665300000019'})
    AADD(_aRet,{'00020018665300000030'})
    AADD(_aRet,{'00020018665300000031'})
    AADD(_aRet,{'00020018665300000042'})
    AADD(_aRet,{'00020018665300000043'})
    AADD(_aRet,{'00020018665300000054'})
    AADD(_aRet,{'00020018665300000055'})
    AADD(_aRet,{'00020018665300000066'})
    AADD(_aRet,{'00020018665300000067'})
    AADD(_aRet,{'00020018665300000078'})
    AADD(_aRet,{'00020018665300000079'})
    AADD(_aRet,{'00020018665300000090'})
    AADD(_aRet,{'00020018665300000091'})
    AADD(_aRet,{'00020018665400000002'})
    AADD(_aRet,{'00020018665400000003'})
    AADD(_aRet,{'00020018668400000001'})
    AADD(_aRet,{'00020018682600000001'})
    AADD(_aRet,{'00020018682600000004'})
    AADD(_aRet,{'00020018682600000007'})
    AADD(_aRet,{'00020018709700000002'})
    AADD(_aRet,{'00020018709700000009'})
    AADD(_aRet,{'00020018709700000021'})
    AADD(_aRet,{'00020018709700000026'})
    AADD(_aRet,{'00020018709700000036'})
    AADD(_aRet,{'00020018709700000044'})
    AADD(_aRet,{'00020018709700000052'})
    AADD(_aRet,{'00020018709700000063'})
    AADD(_aRet,{'00020018709700000070'})
    AADD(_aRet,{'00020018709700000075'})
    AADD(_aRet,{'00020018789700000001'})
    AADD(_aRet,{'00020018789700000002'})
    AADD(_aRet,{'00020018789700000003'})
    AADD(_aRet,{'00020018879900000004'})
    AADD(_aRet,{'00020018879900000007'})
    AADD(_aRet,{'00020018879900000008'})
    AADD(_aRet,{'00020018881600000004'})
    AADD(_aRet,{'00020018881600000005'})
    AADD(_aRet,{'00020018881600000016'})
    AADD(_aRet,{'00020018881600000017'})
    AADD(_aRet,{'00020020602100000069'})
    AADD(_aRet,{'00020020807700000003'})
    AADD(_aRet,{'00020020807700000023'})
    AADD(_aRet,{'00020020807700000036'})
    AADD(_aRet,{'00020020807700000052'})
    AADD(_aRet,{'00020020807700000072'})
    AADD(_aRet,{'00020021087700000003'})
    AADD(_aRet,{'00020021087700000018'})
    AADD(_aRet,{'00020021087700000042'})
    AADD(_aRet,{'00010018644500000004'})
    AADD(_aRet,{'00010018675500000007'})
    AADD(_aRet,{'00010018675500000008'})
    AADD(_aRet,{'00010018676100000009'})
    AADD(_aRet,{'00010018713600000001'})
    AADD(_aRet,{'00010018713600000004'})
    AADD(_aRet,{'00010018817400000002'})
    AADD(_aRet,{'00010018817400000003'})
    AADD(_aRet,{'00010018823800000010'})
    AADD(_aRet,{'00010018823800000011'})
    AADD(_aRet,{'00010018850800000005'})
    AADD(_aRet,{'00010018850800000007'})
    AADD(_aRet,{'00020018664000000001'})
    AADD(_aRet,{'00020018664000000020'})
    AADD(_aRet,{'00020018664000000036'})
    AADD(_aRet,{'00020018682500000012'})
    AADD(_aRet,{'00020018682500000015'})
    AADD(_aRet,{'00020018682500000017'})
    AADD(_aRet,{'00020018682500000023'})
    AADD(_aRet,{'00020018682500000031'})
    AADD(_aRet,{'00020018682500000034'})
    AADD(_aRet,{'00020018682500000038'})
    AADD(_aRet,{'00020018682500000039'})
    AADD(_aRet,{'00020018682500000041'})
    AADD(_aRet,{'00020018682500000048'})
    AADD(_aRet,{'00020018688900000005'})
    AADD(_aRet,{'00020018688900000014'})
    AADD(_aRet,{'00020018688900000023'})
    AADD(_aRet,{'00020018688900000034'})
    AADD(_aRet,{'00020018790200000010'})
    AADD(_aRet,{'00020018790200000029'})
    AADD(_aRet,{'00020018790200000048'})
    AADD(_aRet,{'00020018790200000060'})
    AADD(_aRet,{'00020018790200000077'})
    AADD(_aRet,{'00020018790200000078'})
    AADD(_aRet,{'00020018790200000085'})
    AADD(_aRet,{'00020018963400000001'})
    AADD(_aRet,{'00020018963400000002'})
    AADD(_aRet,{'00020018966100000017'})
    AADD(_aRet,{'00020018799500000041'})
    AADD(_aRet,{'00020018797100000007'})
    AADD(_aRet,{'00020018911200000008'})
    AADD(_aRet,{'00100018242600000561'})
    AADD(_aRet,{'00020019464500000012'})
    AADD(_aRet,{'00190019308300000003'})
    AADD(_aRet,{'00020018802500000012'})
    AADD(_aRet,{'00020018799500000006'})
    AADD(_aRet,{'00010019289200000001'})
    AADD(_aRet,{'00010019289200000005'})
    AADD(_aRet,{'00010019289200000010'})
    AADD(_aRet,{'00020018963200000001'})
    AADD(_aRet,{'00020018963200000002'})
    AADD(_aRet,{'00020018963200000004'})
    AADD(_aRet,{'00020018963200000005'})
    AADD(_aRet,{'00020018963200000006'})
    AADD(_aRet,{'00020018963200000016'})
    AADD(_aRet,{'00020018963200000018'})
    AADD(_aRet,{'00020018963200000022'})
    AADD(_aRet,{'00020018962300000012'})
    AADD(_aRet,{'00100018242000000310'})
    AADD(_aRet,{'00010018706100000003'})
    AADD(_aRet,{'00010018706100000004'})
    AADD(_aRet,{'00010018706100000017'})
    AADD(_aRet,{'00010018706100000018'})
    AADD(_aRet,{'00010018706100000019'})
    AADD(_aRet,{'00010018706100000020'})
    AADD(_aRet,{'00010018875400000003'})
    AADD(_aRet,{'00010018875500000002'})
    AADD(_aRet,{'00020018681600000001'})
    AADD(_aRet,{'00020018681600000006'})
    AADD(_aRet,{'00020018681600000010'})
    AADD(_aRet,{'00020018681600000012'})
    AADD(_aRet,{'00020018681600000020'})
    AADD(_aRet,{'00020018681600000022'})
    AADD(_aRet,{'00020018681600000027'})
    AADD(_aRet,{'00020018681600000031'})
    AADD(_aRet,{'00020018691800000012'})
    AADD(_aRet,{'00020018691800000019'})
    AADD(_aRet,{'00020018691800000031'})
    AADD(_aRet,{'00020018785200000001'})
    AADD(_aRet,{'00020018785200000007'})
    AADD(_aRet,{'00020018785200000011'})
    AADD(_aRet,{'00020018785200000019'})
    AADD(_aRet,{'00020018785200000024'})
    AADD(_aRet,{'00020018799500000052'})
    AADD(_aRet,{'00020018799900000052'})
    AADD(_aRet,{'00020019161300000007'})
    AADD(_aRet,{'00100018050900000030'})
    AADD(_aRet,{'00100018050900000031'})
    AADD(_aRet,{'00010018754100000001'})
    AADD(_aRet,{'00010018851300000001'})
    AADD(_aRet,{'00020018598100000005'})
    AADD(_aRet,{'00020018598100000011'})
    AADD(_aRet,{'00020018598100000022'})
    AADD(_aRet,{'00020018698900000003'})
    AADD(_aRet,{'00020018698900000009'})
    AADD(_aRet,{'00020018698900000011'})
    AADD(_aRet,{'00020018698900000013'})
    AADD(_aRet,{'00020018778000000002'})
    AADD(_aRet,{'00020018778000000006'})
    AADD(_aRet,{'00020018809900000003'})
    AADD(_aRet,{'00020018809900000012'})
    AADD(_aRet,{'00020018809900000020'})
    AADD(_aRet,{'00020018758800000002'})
    AADD(_aRet,{'00020018758800000004'})
    AADD(_aRet,{'00020018915300000002'})
    AADD(_aRet,{'00020019164900000001'})
    AADD(_aRet,{'00020018791900000017'})
    AADD(_aRet,{'00190020426000000069'})
    AADD(_aRet,{'00190020426000000267'})
    AADD(_aRet,{'00020019496900000010'})
    AADD(_aRet,{'00100018244600000028'})
    AADD(_aRet,{'00100018467200000005'})
    AADD(_aRet,{'00100018842200000001'})
    AADD(_aRet,{'00020018710200000009'})
    AADD(_aRet,{'00020018710200000012'})
    AADD(_aRet,{'00020018694100000040'})
    AADD(_aRet,{'00020018799900000013'})
    AADD(_aRet,{'00100018838600000015'})
    AADD(_aRet,{'00020018821300000008'})
    AADD(_aRet,{'00100017199400000052'})
    AADD(_aRet,{'00190019360500000014'})
    AADD(_aRet,{'00020018740500000049'})
    AADD(_aRet,{'00020018740500000050'})
    AADD(_aRet,{'00020018799600000056'})
    AADD(_aRet,{'00020018799700000090'})
    AADD(_aRet,{'00020018799900000030'})
    AADD(_aRet,{'00020018800000000005'})
    AADD(_aRet,{'00020018800000000090'})
    AADD(_aRet,{'00020019106900000012'})
    AADD(_aRet,{'00020019860800000004'})
    AADD(_aRet,{'00020020564300000006'})
    AADD(_aRet,{'00020020782700000084'})
    AADD(_aRet,{'00020018718200000002'})
    AADD(_aRet,{'00020018718200000006'})
    AADD(_aRet,{'00020018767200000035'})
    AADD(_aRet,{'00100018242600000190'})
    AADD(_aRet,{'00100018242600001042'})
    AADD(_aRet,{'00100020056200000077'})
    AADD(_aRet,{'00100020694500000050'})
    AADD(_aRet,{'00100020694500000051'})
    AADD(_aRet,{'00100017198600000010'})
    AADD(_aRet,{'00020018718900000001'})
    AADD(_aRet,{'00020018718900000009'})
    AADD(_aRet,{'00020018773100000003'})
    AADD(_aRet,{'00020018776200000005'})
    AADD(_aRet,{'00020018812700000004'})
    AADD(_aRet,{'00020018943900000001'})
    AADD(_aRet,{'00020018952200000003'})
    AADD(_aRet,{'00020019514800000001'})
    AADD(_aRet,{'00020019514800000014'})
    AADD(_aRet,{'00020019514800000034'})
    AADD(_aRet,{'00020020017000000002'})
    AADD(_aRet,{'00020020017000000007'})
    AADD(_aRet,{'00020020017000000011'})
    AADD(_aRet,{'00020020017000000016'})
    AADD(_aRet,{'00020020017000000020'})
    AADD(_aRet,{'00020020374100000002'})
    AADD(_aRet,{'00020020374100000013'})
    AADD(_aRet,{'00020020374100000025'})
    AADD(_aRet,{'00020020846900000007'})
    AADD(_aRet,{'00020020847000000072'})
    AADD(_aRet,{'00020020847000000073'})
    AADD(_aRet,{'00020021123200000015'})
    AADD(_aRet,{'00020021123200000016'})
    AADD(_aRet,{'00020021123200000092'})
    AADD(_aRet,{'00020021123200000093'})
    AADD(_aRet,{'00100018838600000008'})
    AADD(_aRet,{'00100018838700000006'})
    AADD(_aRet,{'00100018838900000017'})
    AADD(_aRet,{'00020018517600000002'})
    AADD(_aRet,{'00100018838600000009'})
    AADD(_aRet,{'00100020056200000004'})
    AADD(_aRet,{'00100020056200000011'})
    AADD(_aRet,{'00100020056200000059'})
    AADD(_aRet,{'00100020694500000054'})
    AADD(_aRet,{'00100020694500000108'})
    AADD(_aRet,{'00100020694500000208'})
    AADD(_aRet,{'00100020694500000209'})
    AADD(_aRet,{'00010018818500000002'})
    AADD(_aRet,{'00010018818500000004'})
    AADD(_aRet,{'00010018818500000005'})
    AADD(_aRet,{'00010020951900000006'})
    AADD(_aRet,{'00100017199000000043'})
    AADD(_aRet,{'00190016978600000053'})
    AADD(_aRet,{'00100018242600000105'})
    AADD(_aRet,{'00020018784300000001'})
    AADD(_aRet,{'00190016358900000027'})
    AADD(_aRet,{'00100018242600000050'})
    AADD(_aRet,{'00100018242600000051'})
    AADD(_aRet,{'00100018242600000052'})
    AADD(_aRet,{'00100020694500000210'})
    AADD(_aRet,{'00100015948500000016'})
    AADD(_aRet,{'00100015948500000001'})
    AADD(_aRet,{'00100017198600000009'})
    AADD(_aRet,{'00020018764600000041'})
    AADD(_aRet,{'00100018242000000254'})
    AADD(_aRet,{'00100018242600000635'})
    AADD(_aRet,{'00100018242600000854'})
    AADD(_aRet,{'00100018242600001049'})
    AADD(_aRet,{'00100018244600000030'})
    AADD(_aRet,{'00020018740500000051'})
    AADD(_aRet,{'00010018822200000020'})
    AADD(_aRet,{'00010018823200000022'})
    AADD(_aRet,{'00010018823200000023'})
    AADD(_aRet,{'00010018823200000024'})
    AADD(_aRet,{'00020018801800000022'})
    AADD(_aRet,{'00020018802300000032'})
    AADD(_aRet,{'00020019006200000013'})
    AADD(_aRet,{'00100018242600000189'})
    AADD(_aRet,{'00100018244400000028'})
    AADD(_aRet,{'00020018487500000001'})
    AADD(_aRet,{'00020018487500000003'})
    AADD(_aRet,{'00020018487500000015'})
    AADD(_aRet,{'00020018686900000001'})
    AADD(_aRet,{'00020018698000000001'})
    AADD(_aRet,{'00020018698000000005'})
    AADD(_aRet,{'00020018698000000006'})
    AADD(_aRet,{'00020018802300000017'})
    AADD(_aRet,{'00020018812000000011'})
    AADD(_aRet,{'00020018812000000020'})
    AADD(_aRet,{'00020018812000000036'})
    AADD(_aRet,{'00020018826200000024'})
    AADD(_aRet,{'00020018948100000052'})
    AADD(_aRet,{'00020018967400000008'})
    AADD(_aRet,{'00020018986000000001'})
    AADD(_aRet,{'00020019006100000032'})
    AADD(_aRet,{'00020020061600000002'})
    AADD(_aRet,{'00100018242000000374'})
    AADD(_aRet,{'00100018242600000471'})
    AADD(_aRet,{'00100018242600000497'})
    AADD(_aRet,{'00100018242600000560'})
    AADD(_aRet,{'00100018242600000980'})
    AADD(_aRet,{'00100018242600000987'})
    AADD(_aRet,{'00100018242600001025'})
    AADD(_aRet,{'00100018242600001052'})
    AADD(_aRet,{'00100019575700000069'})
    AADD(_aRet,{'00020018764600000040'})
    AADD(_aRet,{'00100018242600000334'})
    AADD(_aRet,{'00100018242600000391'})
    AADD(_aRet,{'00100018242600000546'})
    AADD(_aRet,{'00100018242600000639'})
    AADD(_aRet,{'00100018242600001040'})
    AADD(_aRet,{'00100018242600001050'})
    AADD(_aRet,{'00100017199200000019'})
    AADD(_aRet,{'00020018787000000016'})
    AADD(_aRet,{'00020018787000000035'})
    AADD(_aRet,{'00020018787000000089'})
    AADD(_aRet,{'00020018787400000033'})
    AADD(_aRet,{'00020018787400000043'})
    AADD(_aRet,{'00100018838800000003'})
    AADD(_aRet,{'00100018242600000979'})
    AADD(_aRet,{'00020018757800000004'})
    AADD(_aRet,{'00020018779200000033'})
    AADD(_aRet,{'00020018964000000001'})
    AADD(_aRet,{'00100018242600000259'})
    AADD(_aRet,{'00190019978000000330'})
    AADD(_aRet,{'00020018799500000077'})
    AADD(_aRet,{'00020018799900000048'})
    AADD(_aRet,{'00020018800000000062'})
    AADD(_aRet,{'00020018800100000031'})
    AADD(_aRet,{'00020018800100000037'})
    AADD(_aRet,{'00020018966000000012'})
    AADD(_aRet,{'00020020782700000085'})
    AADD(_aRet,{'00020020235900000024'})
    AADD(_aRet,{'00100018242000000223'})
    AADD(_aRet,{'00100018244600000027'})
    AADD(_aRet,{'00020018674500000017'})
    AADD(_aRet,{'00020018674500000037'})
    AADD(_aRet,{'00020018857600000001'})
    AADD(_aRet,{'00020018684800000004'})
    AADD(_aRet,{'00010018727800000002'})
    AADD(_aRet,{'00020019454900000003'})
    AADD(_aRet,{'00020018798300000007'})
    AADD(_aRet,{'00100018242000000265'})
    AADD(_aRet,{'00100018242000000375'})
    AADD(_aRet,{'00020018721600000003'})
    AADD(_aRet,{'00020018799500000049'})
    AADD(_aRet,{'00020018799500000051'})
    AADD(_aRet,{'00020018799900000012'})
    AADD(_aRet,{'00020018799900000051'})
    AADD(_aRet,{'00020018800000000004'})
    AADD(_aRet,{'00020018800300000042'})
    AADD(_aRet,{'00020018800300000044'})
    AADD(_aRet,{'00020018971000000039'})
    AADD(_aRet,{'00020020782700000083'})
    AADD(_aRet,{'00020021094400000016'})
    AADD(_aRet,{'00100018050800000014'})
    AADD(_aRet,{'00020018776200000004'})
    AADD(_aRet,{'00020018802300000016'})
    AADD(_aRet,{'00020018802300000019'})
    AADD(_aRet,{'00020018996000000066'})
    AADD(_aRet,{'00100018242000000309'})
    AADD(_aRet,{'00100018242600000637'})
    AADD(_aRet,{'00100018242600000643'})
    AADD(_aRet,{'00100017199200000065'})
    AADD(_aRet,{'00100018838900000021'})
    AADD(_aRet,{'00100018242600000991'})
    AADD(_aRet,{'00020018993100000006'})
    AADD(_aRet,{'00190020425600000001'})
    AADD(_aRet,{'00020018799500000050'})
    AADD(_aRet,{'00020018971000000038'})
    AADD(_aRet,{'00020018800400000038'})
    AADD(_aRet,{'00020018800600000089'})
    AADD(_aRet,{'00020018996100000035'})
    AADD(_aRet,{'00100018837700000163'})
    AADD(_aRet,{'00100018244600000029'})
    AADD(_aRet,{'00020018718900000016'})
    AADD(_aRet,{'00020018752200000002'})
    AADD(_aRet,{'00020018759900000003'})
    AADD(_aRet,{'00020018799900000053'})
    AADD(_aRet,{'00020018948100000057'})
    AADD(_aRet,{'00020018966000000007'})
    AADD(_aRet,{'00100018242000000057'})
    AADD(_aRet,{'00100018242000000222'})
    AADD(_aRet,{'00100018242000000226'})
    AADD(_aRet,{'00100018242000000228'})
    AADD(_aRet,{'00100018242000000264'})
    AADD(_aRet,{'00100018242600000338'})
    AADD(_aRet,{'00100018242600000498'})
    AADD(_aRet,{'00100018242600000636'})
    AADD(_aRet,{'00100018242600000852'})
    AADD(_aRet,{'00100018242600000912'})
    AADD(_aRet,{'00100018242600000981'})
    AADD(_aRet,{'00100018242600001027'})
    AADD(_aRet,{'00100018242600001043'})
    AADD(_aRet,{'00100018244600000031'})
    AADD(_aRet,{'00020018810600000003'})
    AADD(_aRet,{'00020018764600000056'})
    AADD(_aRet,{'00020018799900000029'})
    AADD(_aRet,{'00020018800300000043'})
    AADD(_aRet,{'00020019860800000003'})
    AADD(_aRet,{'00100018062700000010'})
    AADD(_aRet,{'00100018467100000005'})
    AADD(_aRet,{'00100018242600000438'})
    AADD(_aRet,{'00020018788800000049'})
    AADD(_aRet,{'00020018789500000025'})
    AADD(_aRet,{'00020018801600000001'})
    AADD(_aRet,{'00020018801800000023'})
    AADD(_aRet,{'00020018801800000027'})
    AADD(_aRet,{'00100018244600000025'})
    AADD(_aRet,{'00100018837600000019'})
    AADD(_aRet,{'00100019575700000064'})
    AADD(_aRet,{'00010018976900000022'})
    AADD(_aRet,{'00190019977000000284'})
    AADD(_aRet,{'00020018761000000008'})
    AADD(_aRet,{'00020018784400000015'})
    AADD(_aRet,{'00190019978000000343'})
    AADD(_aRet,{'00020018688700000001'})
    AADD(_aRet,{'00020018915800000001'})
    AADD(_aRet,{'00100018242600000642'})
    AADD(_aRet,{'00020018794800000061'})
    AADD(_aRet,{'00020018794800000062'})
    AADD(_aRet,{'00020018794800000063'})
    AADD(_aRet,{'00020018794800000064'})
    AADD(_aRet,{'00020018794800000065'})
    AADD(_aRet,{'00020018794800000066'})
    AADD(_aRet,{'00020018794800000067'})
    AADD(_aRet,{'00020018794800000068'})
    AADD(_aRet,{'00020018961800000001'})
    AADD(_aRet,{'00020018961800000002'})
    AADD(_aRet,{'00020018961800000003'})
    AADD(_aRet,{'00020018961800000004'})
    AADD(_aRet,{'00020018799500000079'})
    AADD(_aRet,{'00020018799600000055'})
    AADD(_aRet,{'00020018799700000091'})
    AADD(_aRet,{'00020018799900000034'})
    AADD(_aRet,{'00020018799900000049'})
    AADD(_aRet,{'00020018799900000050'})
    AADD(_aRet,{'00020018799900000054'})
    AADD(_aRet,{'00020018800000000006'})
    AADD(_aRet,{'00020018800000000064'})
    AADD(_aRet,{'00020018800000000089'})
    AADD(_aRet,{'00020018800100000034'})
    AADD(_aRet,{'00020018800100000039'})
    AADD(_aRet,{'00020018966000000010'})
    AADD(_aRet,{'00020019106900000015'})
    AADD(_aRet,{'00020020564300000005'})
    AADD(_aRet,{'00100018050800000093'})
    AADD(_aRet,{'00020018793300000001'})
    AADD(_aRet,{'00020018793300000044'})
    AADD(_aRet,{'00020019925400000039'})
    AADD(_aRet,{'00100018242600000830'})
    AADD(_aRet,{'00100018244600000022'})
    AADD(_aRet,{'00020018797500000007'})
    AADD(_aRet,{'00020018798300000006'})
    AADD(_aRet,{'00020019514800000002'})
    AADD(_aRet,{'00020019514800000008'})
    AADD(_aRet,{'00020019514800000010'})
    AADD(_aRet,{'00020019514800000012'})
    AADD(_aRet,{'00020019514800000013'})
    AADD(_aRet,{'00020019514800000015'})
    AADD(_aRet,{'00020019514800000018'})
    AADD(_aRet,{'00020019514800000021'})
    AADD(_aRet,{'00020019514800000023'})
    AADD(_aRet,{'00020019514800000024'})
    AADD(_aRet,{'00020018773500000004'})
    AADD(_aRet,{'00020018800100000030'})
    AADD(_aRet,{'00020018800100000036'})
    AADD(_aRet,{'00020018966000000011'})
    AADD(_aRet,{'00020018801100000014'})
    AADD(_aRet,{'00100018242000000055'})
    AADD(_aRet,{'00100018242000000225'})
    AADD(_aRet,{'00100018242000000373'})
    AADD(_aRet,{'00100018242600000187'})
    AADD(_aRet,{'00100018242600000436'})
    AADD(_aRet,{'00100018242600000512'})
    AADD(_aRet,{'00100018242600000640'})
    AADD(_aRet,{'00100018242600000641'})
    AADD(_aRet,{'00100018242600000829'})
    AADD(_aRet,{'00100018242600000853'})
    AADD(_aRet,{'00100018242600000986'})
    AADD(_aRet,{'00100018242600000992'})
    AADD(_aRet,{'00100018244600000032'})
    AADD(_aRet,{'00100019575700000006'})
    AADD(_aRet,{'00190019571200000018'})
    AADD(_aRet,{'00020018966000000008'})
    AADD(_aRet,{'00010018823200000017'})
    AADD(_aRet,{'00020018802300000083'})
    AADD(_aRet,{'00100018837600000006'})
    AADD(_aRet,{'00020018968000000001'})
    AADD(_aRet,{'00020018672700000001'})
    AADD(_aRet,{'00020018672700000002'})
    AADD(_aRet,{'00100018242000000108'})
    AADD(_aRet,{'00100018242600000800'})
    AADD(_aRet,{'00100018242600001024'})
    AADD(_aRet,{'00100018242600001051'})
    AADD(_aRet,{'00020019464500000013'})
    AADD(_aRet,{'00020019629400000004'})
    AADD(_aRet,{'00100018837500000086'})
    AADD(_aRet,{'00100020639600000192'})
    AADD(_aRet,{'00020018788900000063'})
    AADD(_aRet,{'00020018793300000018'})
    AADD(_aRet,{'00020018797600000033'})
    AADD(_aRet,{'00020018973200000021'})
    AADD(_aRet,{'00020018973200000026'})
    AADD(_aRet,{'00020018800100000040'})
    AADD(_aRet,{'00100018467200000012'})
    AADD(_aRet,{'00020018800400000076'})
    AADD(_aRet,{'00020018801700000040'})
    AADD(_aRet,{'00020018996000000086'})
    AADD(_aRet,{'00190019978000000309'})
    AADD(_aRet,{'00020018886800000003'})
    AADD(_aRet,{'00020018666600000011'})
    AADD(_aRet,{'00020018795500000019'})
    AADD(_aRet,{'00020018799600000028'})
    AADD(_aRet,{'00020018800100000032'})
    AADD(_aRet,{'00020018800100000035'})
    AADD(_aRet,{'00020018800100000038'})
    AADD(_aRet,{'00020018800300000051'})
    AADD(_aRet,{'00020018800400000065'})
    AADD(_aRet,{'00020018802200000005'})
    AADD(_aRet,{'00020018810100000005'})
    AADD(_aRet,{'00020018812100000008'})
    AADD(_aRet,{'00020018812100000019'})
    AADD(_aRet,{'00020018966000000006'})
    AADD(_aRet,{'00020018971000000036'})
    AADD(_aRet,{'00020018996400000006'})
    AADD(_aRet,{'00020019106900000009'})
    AADD(_aRet,{'00100018242600000053'})
    AADD(_aRet,{'00100018242600000647'})
    AADD(_aRet,{'00020018761000000001'})
    AADD(_aRet,{'00020019328800000053'})
    AADD(_aRet,{'00020018799700000027'})
    AADD(_aRet,{'00020018800100000027'})
    AADD(_aRet,{'00020018800300000041'})
    AADD(_aRet,{'00020018787000000015'})
    AADD(_aRet,{'00020018787000000022'})
    AADD(_aRet,{'00020018787000000027'})
    AADD(_aRet,{'00020018787000000043'})
    AADD(_aRet,{'00020018787000000061'})
    AADD(_aRet,{'00020018787000000077'})
    AADD(_aRet,{'00020018787000000099'})
    AADD(_aRet,{'00020018787400000010'})
    AADD(_aRet,{'00020018787400000021'})
    AADD(_aRet,{'00020018787400000037'})
    AADD(_aRet,{'00190015805200000002'})
    AADD(_aRet,{'00190019977000000295'})
    AADD(_aRet,{'00190020426000000005'})
    AADD(_aRet,{'00020018958200000003'})
    AADD(_aRet,{'00020019106900000016'})
    AADD(_aRet,{'00020018856900000001'})
    AADD(_aRet,{'00020019161300000006'})
    AADD(_aRet,{'00020018799500000078'})
    AADD(_aRet,{'00020018800000000063'})
    AADD(_aRet,{'00020018764600000009'})
    AADD(_aRet,{'00020018766600000023'})
    AADD(_aRet,{'00020018800400000045'})
    AADD(_aRet,{'00020018801200000047'})
    AADD(_aRet,{'00020018801800000064'})
    AADD(_aRet,{'00100018242000000224'})
    AADD(_aRet,{'00100018242000000367'})
    AADD(_aRet,{'00100018242600000638'})
    AADD(_aRet,{'00100018837600000016'})
    AADD(_aRet,{'00010018732600000001'})
    AADD(_aRet,{'00020018771000000001'})
    AADD(_aRet,{'00020018771100000049'})
    AADD(_aRet,{'00020018771100000056'})
    AADD(_aRet,{'00020018771100000067'})
    AADD(_aRet,{'00020018771100000074'})
    AADD(_aRet,{'00020018771100000082'})
    AADD(_aRet,{'00020018771100000088'})
    AADD(_aRet,{'00020018771100000092'})
    AADD(_aRet,{'00020018771100000098'})
    AADD(_aRet,{'00020020361900000011'})
    AADD(_aRet,{'00100018242000000251'})
    AADD(_aRet,{'00100018242000000262'})
    AADD(_aRet,{'00100018242600000496'})
    AADD(_aRet,{'00100018242600001041'})
    AADD(_aRet,{'00100020639600000235'})
    AADD(_aRet,{'00190019978000000332'})
    AADD(_aRet,{'00020020017000000001'})
    AADD(_aRet,{'00020020017000000006'})
    AADD(_aRet,{'00020020017000000012'})
    AADD(_aRet,{'00020020017000000018'})
    AADD(_aRet,{'00020020017000000022'})
    AADD(_aRet,{'00020020017000000026'})
    AADD(_aRet,{'00020020017000000031'})
    AADD(_aRet,{'00020020017000000038'})
    AADD(_aRet,{'00020020017000000040'})
    AADD(_aRet,{'00020020017000000045'})
    AADD(_aRet,{'00020020017000000054'})
    AADD(_aRet,{'00020020017000000056'})
    AADD(_aRet,{'00020020017000000060'})
    AADD(_aRet,{'00020020847000000074'})
    AADD(_aRet,{'00020021123200000007'})
    AADD(_aRet,{'00020021123200000013'})
    AADD(_aRet,{'00020021123200000025'})
    AADD(_aRet,{'00020021123200000032'})
    AADD(_aRet,{'00020021123200000046'})
    AADD(_aRet,{'00020021123200000057'})
    AADD(_aRet,{'00020021123200000065'})
    AADD(_aRet,{'00020021123200000075'})
    AADD(_aRet,{'00020021123200000095'})
    AADD(_aRet,{'00100018242000000126'})
    AADD(_aRet,{'00020018966000000005'})
    AADD(_aRet,{'00190020425500000592'})
    AADD(_aRet,{'00020018996400000034'})
    AADD(_aRet,{'00020018955500000001'})
    AADD(_aRet,{'00190020426000000006'})
    AADD(_aRet,{'00020018791000000003'})
    AADD(_aRet,{'00020018517600000001'})
    AADD(_aRet,{'00020018517600000003'})
    AADD(_aRet,{'00020018517600000004'})
    AADD(_aRet,{'00020018517600000005'})
    AADD(_aRet,{'00020018517600000007'})
    AADD(_aRet,{'00020018517600000009'})
    AADD(_aRet,{'00020018517600000014'})
    AADD(_aRet,{'00020018517600000016'})
    AADD(_aRet,{'00020018517600000020'})
    AADD(_aRet,{'00020018517600000024'})
    AADD(_aRet,{'00020018517600000028'})
    AADD(_aRet,{'00020018517600000033'})
    AADD(_aRet,{'00020018785300000004'})
    AADD(_aRet,{'00020018785300000009'})
    AADD(_aRet,{'00020018789100000042'})
    AADD(_aRet,{'00190020425700000271'})
    AADD(_aRet,{'00020018973200000001'})
    AADD(_aRet,{'00100018242000000253'})
    AADD(_aRet,{'00100018242000000263'})
    AADD(_aRet,{'00100018242600000910'})
    AADD(_aRet,{'00100018242600001022'})
    AADD(_aRet,{'00190020425500000038'})
    AADD(_aRet,{'00020018809500000018'})
    AADD(_aRet,{'00020018803300000017'})
    AADD(_aRet,{'00020018996100000023'})
    AADD(_aRet,{'00020019006200000012'})
    AADD(_aRet,{'00020019907600000003'})
    AADD(_aRet,{'00100018242000000021'})
    AADD(_aRet,{'00100018242000000127'})
    AADD(_aRet,{'00100018242600000106'})
    AADD(_aRet,{'00100018242600000333'})
    AADD(_aRet,{'00100018242600000441'})
    AADD(_aRet,{'00100018242600000911'})
    AADD(_aRet,{'00100018242600001048'})
    AADD(_aRet,{'00020018667100000001'})
    AADD(_aRet,{'00020018971000000058'})
    AADD(_aRet,{'00190020426000000085'})
    AADD(_aRet,{'00020018800300000039'})
    AADD(_aRet,{'00020018800300000046'})
    AADD(_aRet,{'00020018800300000050'})
    AADD(_aRet,{'00020018846200000002'})
    AADD(_aRet,{'00020018966000000009'})
    AADD(_aRet,{'00020019106900000013'})
    AADD(_aRet,{'00020020564300000004'})
    AADD(_aRet,{'00020020564300000007'})
    AADD(_aRet,{'00100018050800000071'})
    AADD(_aRet,{'00020018761600000004'})
    AADD(_aRet,{'00020018761800000016'})
    AADD(_aRet,{'00020018769400000008'})
    AADD(_aRet,{'00190019978000000340'})
    AADD(_aRet,{'00020018950000000026'})
    AADD(_aRet,{'00100018243400000025'})
    AADD(_aRet,{'00190020425500000611'})
    AADD(_aRet,{'00190019977000000223'})
    AADD(_aRet,{'00190020425800000018'})
    AADD(_aRet,{'00190020425600000034'})
    AADD(_aRet,{'00100018242000000227'})
    AADD(_aRet,{'00100018242000000252'})
    AADD(_aRet,{'00100018242600000988'})
    AADD(_aRet,{'00100018242600001023'})
    AADD(_aRet,{'00100018244600000023'})
    AADD(_aRet,{'00100018837600000199'})
    AADD(_aRet,{'00190020426000000120'})
    AADD(_aRet,{'00190020426000000122'})
    AADD(_aRet,{'00190020426000000244'})
    AADD(_aRet,{'00190020426000000257'})
    AADD(_aRet,{'00190020426000000264'})
    AADD(_aRet,{'00190020426000000265'})
    AADD(_aRet,{'00190020426000000268'})
    AADD(_aRet,{'00100020639600000019'})
    AADD(_aRet,{'00100020639600000086'})
    AADD(_aRet,{'00100020639600000208'})
    AADD(_aRet,{'00100020639600000229'})
    AADD(_aRet,{'00190020425700000213'})
    AADD(_aRet,{'00100018838800000006'})
    AADD(_aRet,{'00020018767200000012'})
    AADD(_aRet,{'00020018767200000013'})
    AADD(_aRet,{'00020018950000000004'})
    AADD(_aRet,{'00020018950000000028'})
    AADD(_aRet,{'00100018242600000054'})
    AADD(_aRet,{'00100018242600000515'})
    AADD(_aRet,{'00100018242600000565'})
    AADD(_aRet,{'00190020425700000083'})
    AADD(_aRet,{'00190020425700000304'})
    AADD(_aRet,{'00190020425700000431'})
    AADD(_aRet,{'00190020425700000442'})
    AADD(_aRet,{'00190020425800000140'})
    AADD(_aRet,{'00190020425800000346'})
    AADD(_aRet,{'00190020425900000180'})
    AADD(_aRet,{'00190020425900000531'})
    AADD(_aRet,{'00190020425900000575'})
    AADD(_aRet,{'00020018799500000080'})
    AADD(_aRet,{'00020018800000000065'})
    AADD(_aRet,{'00020018800100000041'})
    AADD(_aRet,{'00020018800300000052'})
    AADD(_aRet,{'00020019106900000008'})
    AADD(_aRet,{'00020019106900000014'})
    AADD(_aRet,{'00190020426000000193'})
    AADD(_aRet,{'00170019352800000354'})
    AADD(_aRet,{'00170019545200000313'})
    AADD(_aRet,{'00170019732800000320'})
    AADD(_aRet,{'00190019977000000499'})
    AADD(_aRet,{'00190020425500000141'})
    AADD(_aRet,{'00190019978000000297'})
    AADD(_aRet,{'00190019978000000298'})
    AADD(_aRet,{'00190019978000000299'})
    AADD(_aRet,{'00190019978000000300'})
    AADD(_aRet,{'00190019978000000301'})
    AADD(_aRet,{'00190019978000000302'})
    AADD(_aRet,{'00190019978000000303'})
    AADD(_aRet,{'00190019978000000304'})
    AADD(_aRet,{'00190019978000000308'})
    AADD(_aRet,{'00190019978000000310'})
    AADD(_aRet,{'00190019978000000313'})
    AADD(_aRet,{'00190019978000000316'})
    AADD(_aRet,{'00190019978000000322'})
    AADD(_aRet,{'00190019978000000323'})
    AADD(_aRet,{'00190019978000000324'})
    AADD(_aRet,{'00190019978000000327'})
    AADD(_aRet,{'00190019978000000329'})
    AADD(_aRet,{'00190019978000000333'})
    AADD(_aRet,{'00190019978000000334'})
    AADD(_aRet,{'00190019978000000335'})
    AADD(_aRet,{'00190019978000000336'})
    AADD(_aRet,{'00190019978000000339'})
    AADD(_aRet,{'00190019978000000341'})
    AADD(_aRet,{'00190019978000000345'})
    AADD(_aRet,{'00190019978000000346'})
    AADD(_aRet,{'00190020425700000036'})
    AADD(_aRet,{'00190020425800000377'})
    AADD(_aRet,{'00190020426000000236'})
    AADD(_aRet,{'00190020426000000272'})
    AADD(_aRet,{'00190019977000000309'})
    AADD(_aRet,{'00190020425700000440'})
    AADD(_aRet,{'00170019174200000372'})
    AADD(_aRet,{'00020018791900000024'})
    AADD(_aRet,{'00190020425500000485'})
    AADD(_aRet,{'00190020426000000130'})
    AADD(_aRet,{'00100015277100000024'})
    AADD(_aRet,{'00020018800100000033'})
    AADD(_aRet,{'00190020426100000109'})
    AADD(_aRet,{'00190020425900000438'})
    AADD(_aRet,{'00020019434600000003'})
    AADD(_aRet,{'00010019000000000001'})
    AADD(_aRet,{'00010019044600000001'})
    AADD(_aRet,{'00020018685600000001'})
    AADD(_aRet,{'00020019027100000001'})
    AADD(_aRet,{'00100018242600000188'})
    AADD(_aRet,{'00100018242600000513'})
    AADD(_aRet,{'00100018242600000547'})
    AADD(_aRet,{'00100018243400000024'})
    AADD(_aRet,{'00020019266200000001'})
    AADD(_aRet,{'00010018898600000001'})
    AADD(_aRet,{'00010019201600000001'})
    AADD(_aRet,{'00010019386800000001'})
    AADD(_aRet,{'00190019977000000142'})
    AADD(_aRet,{'00190019978000000318'})
    AADD(_aRet,{'00190020425900000479'})
    AADD(_aRet,{'00190020426000000073'})
    AADD(_aRet,{'00190020426000000074'})
    AADD(_aRet,{'00190019977000000480'})
    AADD(_aRet,{'00190020426000000062'})
    AADD(_aRet,{'00190020426100000105'})
    AADD(_aRet,{'00020018800000000091'})
    AADD(_aRet,{'00020018971000000037'})
    AADD(_aRet,{'00020020564300000009'})
    AADD(_aRet,{'00190020425700000261'})
    AADD(_aRet,{'00190020425700000267'})
    AADD(_aRet,{'00190020425700000029'})
    AADD(_aRet,{'00190020425700000030'})
    AADD(_aRet,{'00190020425700000328'})
    AADD(_aRet,{'00190020425800000027'})
    AADD(_aRet,{'00190020425800000033'})
    AADD(_aRet,{'00190020425800000036'})
    AADD(_aRet,{'00190020425800000370'})
    AADD(_aRet,{'00190020425900000032'})
    AADD(_aRet,{'00190019191200000007'})
    AADD(_aRet,{'00190020425800000216'})
    AADD(_aRet,{'00190020425900000205'})
    AADD(_aRet,{'00190020426000000107'})
    AADD(_aRet,{'00190020426000000139'})
    AADD(_aRet,{'00190019977000000020'})
    AADD(_aRet,{'00190019977000000037'})
    AADD(_aRet,{'00190019977000000056'})
    AADD(_aRet,{'00190019977000000085'})
    AADD(_aRet,{'00190019977000000137'})
    AADD(_aRet,{'00190019977000000152'})
    AADD(_aRet,{'00190019977000000155'})
    AADD(_aRet,{'00190019977000000281'})
    AADD(_aRet,{'00190019977000000384'})
    AADD(_aRet,{'00190019977000000496'})
    AADD(_aRet,{'00190019978000000305'})
    AADD(_aRet,{'00190019978000000317'})
    AADD(_aRet,{'00190019978000000325'})
    AADD(_aRet,{'00190019978000000326'})
    AADD(_aRet,{'00190020425800000072'})
    AADD(_aRet,{'00190020425800000300'})
    AADD(_aRet,{'00190020425800000313'})
    AADD(_aRet,{'00190020425900000143'})
    AADD(_aRet,{'00190020425700000061'})
    AADD(_aRet,{'00190020425700000175'})
    AADD(_aRet,{'00190020425900000020'})
    AADD(_aRet,{'00190019977000000388'})
    AADD(_aRet,{'00190019978000000315'})
    AADD(_aRet,{'00190019978000000342'})
    AADD(_aRet,{'00190019977000000122'})
    AADD(_aRet,{'00190019977000000387'})
    AADD(_aRet,{'00190019977000000476'})
    AADD(_aRet,{'00190019978000000306'})
    AADD(_aRet,{'00190019978000000319'})
    AADD(_aRet,{'00190020425700000439'})
    AADD(_aRet,{'00190020425800000059'})
    AADD(_aRet,{'00190020425800000123'})
    AADD(_aRet,{'00190020425900000187'})
    AADD(_aRet,{'00190020426000000251'})
    AADD(_aRet,{'00190020426100000131'})
    AADD(_aRet,{'00190020425700000365'})
    AADD(_aRet,{'00190020425800000074'})
    AADD(_aRet,{'00190020425900000097'})
    AADD(_aRet,{'00190020425900000121'})
    AADD(_aRet,{'00190020425900000135'})
    AADD(_aRet,{'00190019977000000089'})
    AADD(_aRet,{'00190019977000000164'})
    AADD(_aRet,{'00190019977000000302'})
    AADD(_aRet,{'00190019977000000483'})
    AADD(_aRet,{'00190019978000000328'})
    AADD(_aRet,{'00190019978000000344'})
    AADD(_aRet,{'00190020425800000098'})
    AADD(_aRet,{'00190020425800000423'})
    AADD(_aRet,{'00190020425900000105'})
    AADD(_aRet,{'00190020425900000563'})
    AADD(_aRet,{'00190020426100000096'})
    AADD(_aRet,{'00190019978000000312'})
    AADD(_aRet,{'00190019978000000311'})
    AADD(_aRet,{'00190019978000000314'})
    AADD(_aRet,{'00190019977000000105'})
    AADD(_aRet,{'00190019977000000526'})
    AADD(_aRet,{'00190019978000000321'})
    AADD(_aRet,{'00190019978000000338'})
    AADD(_aRet,{'00190019978000000347'})
    AADD(_aRet,{'00190020426100000705'})
    AADD(_aRet,{'00190019978000000331'})
    AADD(_aRet,{'00190020425500000041'})
    AADD(_aRet,{'00190020425600000469'})
    AADD(_aRet,{'00190020425700000119'})
    AADD(_aRet,{'00190020425800000394'})
    AADD(_aRet,{'00100020639600000178'})
    AADD(_aRet,{'00100020639600000182'})
    AADD(_aRet,{'00190020426000000263'})
    AADD(_aRet,{'00020021025300000020'})
    AADD(_aRet,{'00020018719700000008'})
    AADD(_aRet,{'00020018720500000002'})
    AADD(_aRet,{'00020018720900000001'})
    AADD(_aRet,{'00020018729200000004'})
    AADD(_aRet,{'00020018740300000008'})
    AADD(_aRet,{'00020018740300000066'})
    AADD(_aRet,{'00020018740300000068'})
    AADD(_aRet,{'00020018740400000016'})
    AADD(_aRet,{'00020018741400000007'})
    AADD(_aRet,{'00020018742200000008'})
    AADD(_aRet,{'00020018742800000002'})
    AADD(_aRet,{'00020018742800000029'})
    AADD(_aRet,{'00020018742800000040'})
    AADD(_aRet,{'00020018745400000014'})
    AADD(_aRet,{'00020018745400000050'})
    AADD(_aRet,{'00020018745500000020'})
    AADD(_aRet,{'00020018917600000002'})
    AADD(_aRet,{'00020018921500000003'})
    AADD(_aRet,{'00020018921500000015'})
    AADD(_aRet,{'00020018921500000016'})
    AADD(_aRet,{'00020018921900000003'})
    AADD(_aRet,{'00020018921900000032'})
    AADD(_aRet,{'00020018922900000010'})
    AADD(_aRet,{'00020018923200000003'})
    AADD(_aRet,{'00020018923500000015'})
    AADD(_aRet,{'00020018924900000003'})
    AADD(_aRet,{'00020018983500000001'})
    AADD(_aRet,{'00020018983500000003'})
    AADD(_aRet,{'00020018983500000005'})
    AADD(_aRet,{'00020018983500000007'})
    AADD(_aRet,{'00020018983500000008'})
    AADD(_aRet,{'00020018983500000010'})
    AADD(_aRet,{'00020018983500000012'})
    AADD(_aRet,{'00020018983500000015'})
    AADD(_aRet,{'00020018983500000016'})
    AADD(_aRet,{'00020018983500000017'})
    AADD(_aRet,{'00020018983500000020'})
    AADD(_aRet,{'00020018983500000021'})
    AADD(_aRet,{'00020018983500000022'})
    AADD(_aRet,{'00020018983500000025'})
    AADD(_aRet,{'00020018983500000027'})
    AADD(_aRet,{'00020018983500000029'})
    AADD(_aRet,{'00020018983500000037'})
    AADD(_aRet,{'00020019094800000001'})
    AADD(_aRet,{'00020019152800000009'})
    AADD(_aRet,{'00020019154700000052'})
    AADD(_aRet,{'00020019432400000064'})
    AADD(_aRet,{'00020019434600000001'})
    AADD(_aRet,{'00020019434600000004'})
    AADD(_aRet,{'00020019441600000002'})
    AADD(_aRet,{'00020019685400000010'})
    AADD(_aRet,{'00020019703700000029'})
    AADD(_aRet,{'00010018896500000007'})
    AADD(_aRet,{'00010018898100000001'})
    AADD(_aRet,{'00010018900100000002'})
    AADD(_aRet,{'00010018976600000001'})
    AADD(_aRet,{'00010018998500000006'})
    AADD(_aRet,{'00010019000100000005'})
    AADD(_aRet,{'00010019000500000001'})
    AADD(_aRet,{'00010019035300000003'})
    AADD(_aRet,{'00010019048400000001'})
    AADD(_aRet,{'00020018666600000009'})
    AADD(_aRet,{'00020018668400000006'})
    AADD(_aRet,{'00020018668400000009'})
    AADD(_aRet,{'00020018685600000002'})
    AADD(_aRet,{'00020018717900000001'})
    AADD(_aRet,{'00020018718200000004'})
    AADD(_aRet,{'00020018718200000011'})
    AADD(_aRet,{'00020018718200000019'})
    AADD(_aRet,{'00020018718200000021'})
    AADD(_aRet,{'00020018718200000024'})
    AADD(_aRet,{'00020018718200000034'})
    AADD(_aRet,{'00020018718200000036'})
    AADD(_aRet,{'00020018718200000038'})
    AADD(_aRet,{'00020018718200000045'})
    AADD(_aRet,{'00020018718200000049'})
    AADD(_aRet,{'00020018718200000056'})
    AADD(_aRet,{'00020018718200000057'})
    AADD(_aRet,{'00020018718200000060'})
    AADD(_aRet,{'00020018718200000061'})
    AADD(_aRet,{'00020018718200000067'})
    AADD(_aRet,{'00020018718200000070'})
    AADD(_aRet,{'00020018718200000071'})
    AADD(_aRet,{'00020018718200000078'})
    AADD(_aRet,{'00020018718200000081'})
    AADD(_aRet,{'00020018718200000088'})
    AADD(_aRet,{'00020018718200000089'})
    AADD(_aRet,{'00020018718200000096'})
    AADD(_aRet,{'00020018723400000004'})
    AADD(_aRet,{'00020018727000000005'})
    AADD(_aRet,{'00020018728400000004'})
    AADD(_aRet,{'00020018747500000029'})
    AADD(_aRet,{'00020018749300000016'})
    AADD(_aRet,{'00020018751100000002'})
    AADD(_aRet,{'00020018766600000050'})
    AADD(_aRet,{'00020018766600000063'})
    AADD(_aRet,{'00020018766600000064'})
    AADD(_aRet,{'00020018766600000065'})
    AADD(_aRet,{'00020018766600000066'})
    AADD(_aRet,{'00020018766600000067'})
    AADD(_aRet,{'00020018766600000088'})
    AADD(_aRet,{'00020018775900000002'})
    AADD(_aRet,{'00020018778100000004'})
    AADD(_aRet,{'00020018779200000093'})
    AADD(_aRet,{'00020018794300000008'})
    AADD(_aRet,{'00020018797300000001'})
    AADD(_aRet,{'00020018797600000003'})
    AADD(_aRet,{'00020018800600000009'})
    AADD(_aRet,{'00020018801600000032'})
    AADD(_aRet,{'00020018801800000047'})
    AADD(_aRet,{'00020018802200000038'})
    AADD(_aRet,{'00020018802300000071'})
    AADD(_aRet,{'00020018803800000012'})
    AADD(_aRet,{'00020018803800000015'})
    AADD(_aRet,{'00020018810300000019'})
    AADD(_aRet,{'00020018826400000003'})
    AADD(_aRet,{'00020018870000000013'})
    AADD(_aRet,{'00020018891600000002'})
    AADD(_aRet,{'00020018891800000006'})
    AADD(_aRet,{'00020018927400000008'})
    AADD(_aRet,{'00020018936600000008'})
    AADD(_aRet,{'00020018942300000011'})
    AADD(_aRet,{'00020018942300000012'})
    AADD(_aRet,{'00020018946900000001'})
    AADD(_aRet,{'00020018950000000001'})
    AADD(_aRet,{'00020018958400000009'})
    AADD(_aRet,{'00020018961700000009'})
    AADD(_aRet,{'00020018961800000005'})
    AADD(_aRet,{'00020018961800000006'})
    AADD(_aRet,{'00020018961800000007'})
    AADD(_aRet,{'00020018962100000020'})
    AADD(_aRet,{'00020018962600000018'})
    AADD(_aRet,{'00020018962600000043'})
    AADD(_aRet,{'00020018967200000040'})
    AADD(_aRet,{'00020018979600000043'})
    AADD(_aRet,{'00020018979600000055'})
    AADD(_aRet,{'00020018984600000013'})
    AADD(_aRet,{'00020018994000000001'})
    AADD(_aRet,{'00020018996900000026'})
    AADD(_aRet,{'00020018996900000064'})
    AADD(_aRet,{'00020018997300000070'})
    AADD(_aRet,{'00020019005200000001'})
    AADD(_aRet,{'00020019006300000030'})
    AADD(_aRet,{'00020019006300000031'})
    AADD(_aRet,{'00020019089800000009'})
    AADD(_aRet,{'00020019091900000003'})
    AADD(_aRet,{'00020019119400000001'})
    AADD(_aRet,{'00020019135900000008'})
    AADD(_aRet,{'00020019136700000013'})
    AADD(_aRet,{'00020019139100000036'})
    AADD(_aRet,{'00020019150700000070'})
    AADD(_aRet,{'00020019157100000003'})
    AADD(_aRet,{'00020019162500000002'})
    AADD(_aRet,{'00020019224900000006'})
    AADD(_aRet,{'00020019296900000007'})
    AADD(_aRet,{'00020019296900000008'})
    AADD(_aRet,{'00020019296900000009'})
    AADD(_aRet,{'00020019450900000009'})
    AADD(_aRet,{'00020019454300000026'})
    AADD(_aRet,{'00020019464300000007'})
    AADD(_aRet,{'00020019464300000008'})
    AADD(_aRet,{'00020019513100000015'})
    AADD(_aRet,{'00020019513300000011'})
    AADD(_aRet,{'00020019675200000009'})
    AADD(_aRet,{'00020019681500000003'})
    AADD(_aRet,{'00020019940800000002'})
    AADD(_aRet,{'00020021123200000040'})
    AADD(_aRet,{'00020021123200000042'})
    AADD(_aRet,{'00020018795100000006'})
    AADD(_aRet,{'00020018795100000007'})
    AADD(_aRet,{'00020018795100000008'})
    AADD(_aRet,{'00020018831500000001'})
    AADD(_aRet,{'00020018831500000012'})
    AADD(_aRet,{'00020018831500000018'})
    AADD(_aRet,{'00020018831500000020'})
    AADD(_aRet,{'00020018831500000021'})
    AADD(_aRet,{'00020018831500000022'})
    AADD(_aRet,{'00020018831500000023'})
    AADD(_aRet,{'00020018831500000031'})
    AADD(_aRet,{'00020018831500000037'})
    AADD(_aRet,{'00020018831500000041'})
    AADD(_aRet,{'00020018831500000043'})
    AADD(_aRet,{'00020018831500000047'})
    AADD(_aRet,{'00020018831500000048'})
    AADD(_aRet,{'00020018831500000050'})
    AADD(_aRet,{'00020018831500000051'})
    AADD(_aRet,{'00020018963400000003'})
    AADD(_aRet,{'00020018966100000009'})



Return _aRet