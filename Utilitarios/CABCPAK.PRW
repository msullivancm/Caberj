#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO3     � Autor � AP6 IDE            � Data �  13/04/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CABCPAK

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "PAK"

dbSelectArea("PAK")
dbSetOrder(1)

AxCadastro(cString,"Ajuste de Reembolso", cVldExc, cVldAlt )

Return   

User Function VldProt( c_Protocolo )

	Local l_Ret := .T.
	
	dbSelectArea("B44")
	dbSetorder(5)   
	If !dbSeek( xFilial( "B44" ) + c_Protocolo)
	    
		MsgInfo( "Numero de protocolo n�o cadastrado." )
		l_Ret := .F.
	
	EndIf
	
Return l_Ret      

User Function fVldSigla( c_Sigla )

	Local l_Ret := .T.

	dbSelectArea("BAH")                             
	dbSetOrder(1)
	If !dbSeek( xFilial("BAH") + c_Sigla )  
	
		MsgInfo( "Sigla inv�lida." )
	
		l_Ret := .F.
	
	EndIf
	
Return l_Ret

