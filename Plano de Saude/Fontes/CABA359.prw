#Include "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA359  º Autor ³ Frederico O. C. Jr º Data ³  16/11/21   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Matriz de Reembolso    							      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA359()

Local cAlias        := "PDC"
Local aCores        := {{"EMPTY(PDC->PDC_VIGFIN)",  "BR_VERDE"      },;
                        {"!EMPTY(PDC->PDC_VIGFIN)", "BR_VERMELHO"   }}

Private cCadastro   := "Matriz de Reembolso"
Private aRotina     := {{"Pesquisar",   "AxPesqui", 0, 1},;
                        {"Visualizar",  "AxVisual", 0, 2},;
                        {"Incluir",     "AxInclui", 0, 3},;
                        {"Alterar",     "AxAltera", 0, 4},;
                        {"Excluir",     "AxDeleta", 0, 5}}

dbSelectArea(cAlias)
dbSetOrder(1)
mBrowse(06, 01, 22, 75, cAlias,,,,,, aCores)

return


//--------------------------------------------------------------------------------------------------------------//
//						Inicializador do browse - regra grande demais para o SX3 ou SX7							//
//--------------------------------------------------------------------------------------------------------------//
User Function CABA359A(nTp)

Local cRet	:= ""

if nTp == 1			// Contrato (browse)
	cRet	:= POSICIONE("BT5",1,XFILIAL("BT5")+PLSINTPAD()+PDC->(PDC_CODEMP+PDC_NUMCON+PDC_VERCON),"BT5_YDESCR")
elseif nTp == 2		// Subcontrato (gatilho e inic. padrão)
	cRet	:= POSICIONE("BQC",1,XFILIAL("BT5")+PLSINTPAD()+PDC->(PDC_CODEMP+PDC_NUMCON+PDC_VERCON+PDC_SUBCON+PDC_VERSUB),"BQC_DESCRI")
else				// Subcontrato (browse)
	cRet	:= POSICIONE("BQC",1,XFILIAL("BT5")+PLSINTPAD()+PDC->(PDC_CODEMP+PDC_NUMCON+PDC_VERCON+PDC_SUBCON+PDC_VERSUB),"BQC_DESCRI")
endif

return cRet



//--------------------------------------------------------------------------------------------------------------//
//					                  	Validação do campo de Produto			                 				//
//--------------------------------------------------------------------------------------------------------------//
User Function CABA359B( cEmp, cCont, cVerCon, cSub, cVerSub, cProd, cVerPro )

Local lRet      := .F.
Local aProd     := {}
Local cAux      := ""
Local i         := 0

Default cVerPro := "001"

if empty(cProd)
    lRet    := .T.
else

    if empty(cEmp)

        cVerPro     := AllTrim(cVerPro)

        BI3->(DbSetOrder(1))    // BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
        if BI3->(DbSeek( xFilial("BI3") + PlsIntPad() + cProd + cVerPro ))
            lRet      := .T.
        else
            MsgInfo("Produto não localizado no sistema!")
        endif

    else

        // Caso não estiver preenchido - retirar espaços para não impactar na pesquisa
        cCont   := AllTrim(cCont)
        cVerCon := AllTrim(cVerCon)
        cSub    := AllTrim(cSub)
        cVerSub := AllTrim(cVerSub)

        BT6->(DbSetOrder(1))    // BT6_FILIAL+BT6_CODINT+BT6_CODIGO+BT6_NUMCON+BT6_VERCON+BT6_SUBCON+BT6_VERSUB+BT6_CODPRO+BT6_VERSAO
        if BT6->(DbSeek( xFilial("BT6") + PlsIntPad() + cEmp + cCont + cVerCon + cSub + cVerSub ))

            while BT6->(!EOF()) .and. (     (BT6->BT6_CODIGO == cEmp .and. empty(cCont + cVerCon + cSub + cVerSub))                             ;
                                       .or. (BT6->(BT6_CODIGO+BT6_NUMCON+BT6_VERCON) == cEmp + cCont + cVerCon .and. empty(cSub + cVerSub))     ;
                                       .or. (BT6->(BT6_CODIGO+BT6_NUMCON+BT6_VERCON+BT6_SUBCON+BT6_VERSUB) == cEmp+cCont+cVerCon+cSub+cVerSub)  )

                if aScan(aProd, {|x| AllTrim(x[1]+x[2]) == AllTrim(BT6->(BT6_CODPRO+BT6_VERSAO)) }) == 0

                    aAdd(aProd, {BT6->BT6_CODPRO                                                                                    ,;
                                 BT6->BT6_VERSAO                                                                                    ,;
                                 AllTrim(Posicione("BI3",1,xFilial("BI3")+BT6->(BT6_CODINT+BT6_CODPRO+BT6_VERSAO),"BI3_DESCRI"))    })
                
                endif

                BT6->(DbSkip())
            end

        endif

        // Após pegar todos os produtos vinculados à empresa/contrato/subcontrato - checar se o informado pertence
        if      (aScan(aProd, {|x| AllTrim(x[1]+x[2]) == alltrim(cProd+cVerPro) }) > 0)                    ;
           .or. (aScan(aProd, {|x| AllTrim(x[1])      == alltrim(cProd)         }) > 0 .and. empty(cVerPro))
            lRet    := .T.
        else

            for i := 1 to len(aProd)
                cAux    += "* " + aProd[i][1] + "-" + aProd[i][2] + " - " + aProd[i][3] + chr(13)+chr(10)
            next
            cAux    := AllTrim(cAux)

            MsgInfo("Produto não parametrizado para esta Empresa/Contrato/Subcontrato!"  + chr(13)+chr(10) + chr(13)+chr(10) +;
                    "PRODUTOS DISPONÍVEIS:"                                              + chr(13)+chr(10)                   +;
                    cAux                                                                                                      )
        
        endif

    endif

endif

return lRet
