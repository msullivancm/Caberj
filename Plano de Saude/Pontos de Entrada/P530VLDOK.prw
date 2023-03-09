#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �P530VLDOK �Motta  �Caberj              � Data �  Jan/2011   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para validar se o usu�rio Operador do Sis- ���
���          �tema tem acesso permitido a digita��o do questinario        ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function P530VLDOK()

Local lRet 	:= .T.

If M->(BXA_PROQUE+BXA_CODQUE) $ "20003,20022" //PESQUISA DE SATISFACAO - AAG PESQUISA DE SATISFACAO - INTERNISTA
  lRet := Upper(Trim(CUserName)) $ Upper(GetNewPar("MV_YUSQES","vanessa,claudiac,paulaf,tania,hedilberto,admin,karla.regina,lucas.cortezia,cristina.souza,priscila.sieczko,isabela.araujo,motta,admin"))
  If !lRet
    Alert("Usuario sem acesso a este Questionario")
  Endif
Endif

//Leonardo Portella - 10/08/11 - Gravacao do log das entrevistas
If lRet
	GrvLogEnt()
EndIf  

//Renato Peixoto em 20/04/12 - Valida��o para preenchimento correto do campo data (BXA_DATA), pois a data deve ser a data real da entrevista e nao a data do dia da digitacao
If M->BXA_DATA > dDataBase
	Alert("Aten��o, a data n�o pode ser maior que a data atual. Por favor, informe uma data v�lida.")
	lRet := .F.
ElseIf M->BXA_DATA = dDataBase
	If !APMSGYESNO("Aten��o, a data informada deve ser a data real da entrevista. A entrevista ocorreu hoje?","Confirma a data informada?")
		lRet := .F.
	EndIf
Else
	lRet := .T.
EndIf


Return lRet

*****************************************************************************************************

Static Function GrvLogEnt 

Local aArea := GetArea()

dbSelectArea('PAV')
dbSetOrder(1)

If !PAV->(MsSeek(xFilial('PAV') + M->BXA_NUMERO + M->BXA_USUARI))

	PAV->(Reclock('PAV',.T.))
	
	PAV->PAV_FILIAL 	:= xFilial('PAV')
	PAV->PAV_NUMERO 	:= M->BXA_NUMERO
	PAV->PAV_USUARI 	:= M->BXA_USUARI
	PAV->PAV_LOGIN		:= RetCodUsr()
	PAV->PAV_NOME		:= UsrFullName(RetCodUsr())
	
	PAV->(MsUnlock())

EndIf

RestArea(aArea)

Return