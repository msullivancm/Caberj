#INCLUDE "TOTVS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA628  �Autor  �Marcos 7Consulting  � Data �  07/11/22    ���
�������������������������������������������������������������������������͹��
���Desc.     � Acerto de Border� que n�o est� sendo integrado na          ���
���          � Contabilidade                                              ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
*/

USER FUNCTION CABA628()

Local aArea	:= GetArea()
Private cPerg  := "CABA628"
Private lIntegra := .F.

AjustaSX1_2(cPerg)

IF !Pergunte(cPerg, .T.)
	Return
Endif

SE5->(DbSetOrder(10))
IF SE5->(Dbseek(xFilial("SE5")+MV_PAR01))

    While !SE5->(EOF()) .AND. ALLTRIM(SE5->(E5_FILIAL+E5_DOCUMEN)) == ALLTRIM(xFilial("SE5")+MV_PAR01)
        IF SE5->E5_DATA == MV_PAR02
            SE5->(Reclock('SE5',.F.))
                SE5->E5_LA := 'N'
            SE5->(MsUnlock())

            lIntegra := .T.
        ENDIF

        SE5->(Dbskip())
    End

ENDIF

IF lIntegra
    MsgInfo("Border� Integrado com �xito!", "Sucesso")
ELSE
    MsgAlert("Border� n�o localizado", "Erro")
ENDIF

RestArea(aArea)

RETURN

Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 


aHelpPor := {}
AADD(aHelpPor,"Informe o Bordero nao integrado:			")

 u_CABASX1(cPerg,"01","Bordero:","","",	"MV_CH1" ,"C",9,0,0,"G","","",	"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
 u_CABASX1(cPerg,"02","Data:"   ,"","",	"MV_CH2" ,"D",8,0,0,"G","","",	"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
Return()
