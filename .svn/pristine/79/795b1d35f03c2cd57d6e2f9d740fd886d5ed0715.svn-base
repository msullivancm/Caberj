#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV002   ºAutor  ³Renato Peixoto      º Data ³  01/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Validação no campo BDX_ACAO para não permitir que seja     º±±
±±º          ³ reconsiderada uma glosa originada de procedimento incompa- º±±
±±º          ³ tível com o tipo de guia.                                  º±±       
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function CABV002

Local lRet     := .T.             
Local cCodOpe  := BDX->BDX_CODOPE                     
Local cCodLDP  := BDX->BDX_CODLDP
Local cCodPeg  := BDX->BDX_CODPEG
Local cNumero  := BDX->BDX_NUMERO
Local cOrimov  := BDX->BDX_ORIMOV
Local cCodPad  := BDX->BDX_CODPAD
Local cCodPro  := BDX->BDX_CODPRO
Local cCodGlo  := GetMV("MV_XCODGLO")

DbSelectArea("BDX")
DbSetOrder(1)//BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO
If DbSeek(XFILIAL("BDX")+cCodOpe+cCodLDP+cCodPeg+cNumero+cOrimov+cCodPad+cCodPro)
	//While !(BDX->(Eof())) .AND. BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO = cCodOpe+cCodLDP+cCodPeg+cNumero
		If BDX->BDX_CODGLO = cCodGlo
			If M->BDX_ACAO = "2"
				APMSGSTOP("Atenção, esta glosa não poderá ser reconsiderada, pois trata-se de um procedimento incompatível com o tipo da guia. Favor cadastrar apenas procedimentos que sejam compatíveis com o tipo de guia.","Procedimento incompatível com o tipo de guia!")
				lRet := .F. 
			//	Exit
			EndIf
		EndIf
		//BDX->(DbSkip())
	//EndDo
EndIf

BDX->(DbGoTop())
DbSeek(XFILIAL("BDX")+cCodOpe+cCodLDP+cCodPeg+cNumero+cOrimov+cCodPad+cCodPro)//posociono novamento no primeiro registro da BDX, para que ao testar na próxima vez o sistema possa fazer os testes da mesma forma que da primeira...

Return lRet