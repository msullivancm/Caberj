#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA070   � Autor � Joany Peres        � Data �  04/06/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Historico de Ocorrencias do Prestador                      ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CABA070(cCODIGO)
                                                                                      	
Local aRotina := {}  

                                	
if !empty(M->BAU_CODIGO)    	
	DbSelectArea("PBP")   
	cChave := PBP->(IndexKey())
	cIndex := CriaTrab(nil,.f.)
	cFiltro := " PBP_CODIGO == '" + cCODIGO + "' "
	IndRegua("PBP",cIndex,cChave,,cFiltro,OemToAnsi( "Selecionando Registros..." ) ) // "Selecionando Registros..."	
	axCadastro("PBP", "Hist�rico de Ocorr�ncias","U_DelOk()", "U_COK()", , {|| M->PBP_CODIGO := cCODIGO }, , , , , , , , )
//	axCadastro(cAlias, cTitle, cDel, cOk, aRotAdic, bPre, bOK, bTTS, bNoTTS, aAuto, nOpcAuto, aButtons, aACS, cTela)
Else
	MsgAlert("Preencha o C�digo do RDA.")
Endif

Return()                         

User Function DelOk() 	
MsgAlert("A��o n�o autorizada") 
Return .F.

User Function COK() 	       
Local Ret := ""
if Inclui
	Ret := .T.
else
	MsgAlert("A��o n�o autorizada")
	Ret := .F.
endif	

Return Ret