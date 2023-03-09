#include "protheus.ch"
#include "rwmake.ch"
#include "topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � PLBOWBTADD �Autor � Fred O. C. Jr     � Data �  08/06/22   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Manipular data de pagamento                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PL001ADTV

Local aArea       := GetArea()
Local aRet        := {}
Local aAreaB44    := B44->(GetArea())
Local aMarkTela   := PLRETMARK()    // pegar registros marcados na tela
Local i           := 0

for i := 1 to len(aMarkTela)

   B44->(DbGoTo( aMarkTela[i][1] ))

   if aScan(aRet,{ |x| x == B44->B44_DATPAG }) == 0
      aAdd(aRet, B44->B44_DATPAG)
   endif

next

if len(aRet) > 1
   MsgInfo("Foi selecionado mais de um protocolo de reembolso e estes apresentam datas distintas de pagamento. Se seguir a aprova��o destes de forma aglutinada, o pagamento ser� tamb�m aglutinado em: " + DtoC(aRet[1]) )
elseif len(aRet) == 0
   MsgInfo("Nenhum protocolo foi selecionado para aprova��o!")
   aAdd(aRet, dDataBase)
endif

RestArea(aAreaB44)
RestArea(aArea)

return aRet[1]

