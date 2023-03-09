#include "PROTHEUS.CH"
#include "TOPCONN.CH"

//-------------------------------------------------------------------------------------------
/*/{Protheus.doc} function CABA095
description
Rotina que irá gerar todo o processo de auditoria para a farmacia.
@author  Angelo Henrique
@since   11/02/2021
@version version 1.0
@Parametros
    _cParam - Chave da BEA (BEA_OPEMOV+BEA_ANOAUT+BEA_MESAUT+BEA_NUMAUT)
/*/
//-------------------------------------------------------------------------------------------
User function CABA095(_cParam)

    Local _aArBEA   := BEA->(GetArea())
    Local _aArBE2   := BE2->(GetArea())
    Local _aArBEG   := BEG->(GetArea())
    Local _aArB53   := B53->(GetArea())
    Local _aArBAU   := BAU->(GetArea())
    Local _ni       := 0

    Default _cParam := " "

    DBSelectArea("BEA")
    DBSetOrder(1)
    If DBSeek(xFilial("BEA") + _cParam)

        //----------------------------------
        //Atualizando Cabeçalho
        //----------------------------------
        Reclock("BEA", .F.)

        BEA->BEA_AUDITO := "1"
        BEA->BEA_STATUS := "6"
        BEA->BEA_SENHA  := " "        

        BEA->(MsUnLock())

        //----------------------------------
        //Atualizando Itens
        //----------------------------------
        DbSelectArea("BE2")
        DbSetOrder(1) //BE2_FILIAL+BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT+BE2_SEQUEN
        If DbSeek(xFilial("BE2") + BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT))

            While !BE2->(EOF()) .And. BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT) == BE2->(BE2_OPEMOV+BE2_ANOAUT+BE2_MESAUT+BE2_NUMAUT)

                Reclock("BE2", .F.)

                BE2->BE2_AUDITO := "1"
                BE2->BE2_STATUS := "0"

                BEA->(MsUnLock())

                //---------------------------------------------------------
                //Inicio da geração das tabelas de auditoria
                //---------------------------------------------------------
                For _ni := 1 To 2

                    Reclock("BEG", .T.)

                    BEG->BEG_FILIAL := xFilial("BEG")
                    BEG->BEG_OPEMOV := BE2->BE2_OPEMOV
                    BEG->BEG_ANOAUT := BE2->BE2_ANOAUT
                    BEG->BEG_MESAUT := BE2->BE2_MESAUT
                    BEG->BEG_NUMAUT := BE2->BE2_NUMAUT
                    BEG->BEG_SEQUEN := BE2->BE2_SEQUEN

                    If _ni = 1

                        BEG->BEG_CODGLO := "025"
                        BEG->BEG_DESGLO := "Para este procedimento necessita pericia medica."
                        BEG->BEG_INFGLO := ""

                        BEG->BEG_SEQCRI := "002"

                    Else

                        BEG->BEG_CODGLO := " "
                        BEG->BEG_DESGLO := "025 - Nivel: BRV - Planos e Grupos de Cobertura"
                        BEG->BEG_INFGLO := "02 - Atualizacoes / Produto Saude / Produto Saude --> Folder Cobertura/Carencias / Grupos Determinados"

                        BEG->BEG_SEQCRI := "004"

                    EndIf

                    BEG->BEG_TIPO   := "1"

                    BEG->(MsUnLock())

                Next _ni

                BE2->(DbSkip())

            EndDo

            RecLock("B53", .T.)

            B53->B53_FILIAL := xFilial("B53")
            B53->B53_DATMOV := dDataBase
            B53->B53_MATUSU := BEA->(BEA_OPEMOV + BEA_CODEMP + BEA_MATRIC + BEA_TIPREG + BEA_DIGITO)
            B53->B53_NOMUSR := BEA->BEA_NOMUSR
            B53->B53_CODRDA := BEA->BEA_CODRDA
            B53->B53_PERAUD := "1;"//No padrão é incluído desta forma
            B53->B53_PRIORI := "0" //No padrão é incluído desta forma
            B53->B53_NUMGUI := BEA->(BEA_OPEMOV + BEA_ANOAUT + BEA_MESAUT + BEA_NUMAUT)
            B53->B53_ORIMOV := BEA->BEA_ORIMOV
            B53->B53_CODOPE := BEA->BEA_OPEMOV
            B53->B53_CODLDP := BEA->BEA_CODLDP
            B53->B53_CODPEG := BEA->BEA_CODPEG
            B53->B53_NUMERO := BEA->BEA_NUMGUI
            B53->B53_ALIMOV := "BEA"
            B53->B53_RECMOV := cValToChar(BEA->(RECNO()))
            B53->B53_STATUS := "3" //NÃO AUTORIZADA
            B53->B53_SITUAC := "0" //NÃO            
            B53->B53_DEMAND := "0" //NÃO
            B53->B53_PARTIC := "0" //NÃO
            B53->B53_AGEPAR := "0" //NÃO
            B53->B53_ENCAMI := "0" //NÃO
            B53->B53_BANCON := "0" //NÃO
            B53->B53_TIPO 	:= "2" //AMBULATORIAL
            B53->B53_PROINT := "0"
            B53->B53_HORMOV := BEA->BEA_HHDIGI
            B53->B53_CARINT := IIF(BEA->BEA_TIPADM $ "4|5", "U","E")
            B53->B53_REGINT := "0"
            B53->B53_CODMUN := POSICIONE("BAU",1,xFilial("BAU")+BEA->BEA_CODRDA,"BAU_MUN")

            B53->(MsUnlock())

        EndIf

    EndIf

    RestArea(_aArBAU)
    RestArea(_aArBEG)
    RestArea(_aArB53)
    RestArea(_aArBE2)
    RestArea(_aArBEA)

Return