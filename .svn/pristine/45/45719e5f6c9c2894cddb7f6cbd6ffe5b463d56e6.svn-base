#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP655_01     º Autor ³ Marcos Cantalice º Data ³  12/08/22  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ LESCAUT                                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/     

USER FUNCTION LP655_01()//EXCLUSÃO DE COMPRAS - ESTOQUE 
    LOCAL nRET := 0

    // FÓRMULA ANTERIOR CADASTRADA EM CT5_VLR01
    // IIF(AllTrim(SA2->A2_NATUREZ)=='OPME',0,IIF(SF4->F4_ATUATF=="S" .and. SF4->F4_CODIGO="201",0,SD1->D1_TOTAL+SD1->D1_VALIPI+SD1->D1_ICMSRET+SD1->D1_ICMSCOM+SF1->F1_FRETE-SD1->D1_VALDESC))                

    IF SD1->D1_RATEIO = '1'
        nRET := 0
    ELSEIF AllTrim(SA2->A2_NATUREZ)=='OPME'
        nRET := 0
    ELSEIF SF4->F4_ATUATF=="S" .and. SF4->F4_CODIGO="201"
            nRET := 0
    ELSE
        nRET := SD1->D1_TOTAL+SD1->D1_VALIPI+SD1->D1_ICMSRET+SD1->D1_ICMSCOM+SF1->F1_FRETE-SD1->D1_VALDESC
    ENDIF

RETURN nRET


