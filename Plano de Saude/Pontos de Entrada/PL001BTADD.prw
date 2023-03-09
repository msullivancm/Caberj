#include "protheus.ch"
#include "rwmake.ch"
#include "topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � PL001BTADD �Autor  � Fred O. C. Jr    � Data �  21/07/22   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Inlcuir chamada de rotina no reembolso                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PL001BTADD

Local aArea    := GetArea()
Local aRet     := {}
Local cSuperv  := SuperGetMv("MV_XSUPEEM", .F., "001727")

// supervisores n�o tem filtro aplicado direto no browse
if (RetCodUsr() $ AllTrim(cSuperv))

   aRet  := { {"Alterar Data Pgto", 'U_PL01ADTP', 0, 0 } }

endif

RestArea(aArea)

return aRet


User Function PL01ADTP

Local oDlg1
Private dData  := date()

//1=Aguardando finalizacao atendimento;2=Aprovado para pagamento;3=Nao Autorizada;4=Aprovado Parcialmente;5=Aguardando Liq. Titulo a Pagar;6=Em analise pela auditoria
if B44->B44_STATUS $ '1|6'

   oDlg1 := TDialog():New(180,180,450,500,'Alteracao da Data de Pagamento',,,,,CLR_BLACK,CLR_WHITE,,,.T.)
   oFont := TFont():New('Courier new',,-15,.T.)
   oSay1:= TSay():New(10,5,{||'Selecione nova Data de Pagamento:'},oDlg1,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)
   oMsCalend := MsCalend():New(35,10,oDlg1,.F.)
   oMsCalend:dDiaAtu := dData
   oMsCalend:bChange := {|| dData := oMsCalend:dDiaAtu }
   oButton1    := TButton():New(110, 100, "Salvar",    oDlg1,{|| RetornoData(), oDlg1:End() }, 40,15,,,.F.,.T.,.F.,,.F.,,,.F. ) 
   oDlg1:Activate(,,,.T.) 

else
   MsgInfo("Protocolo de reembolso n�o permite mais a altera��o da data de pagamento!")
endif

return



Static Function RetornoData()

if dData >= ddatabase

   RecLock( "B44", .F. )
	   B44->B44_DATPAG := dData
   B44->( MsUnlock() )

   MsgInfo("Data alterada com sucesso!")

else
   Alert("N�o permitido alterar a data de pagamento para uma anterior � data atual!")
endif
  
Return
