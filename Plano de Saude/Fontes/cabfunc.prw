#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BuscaProd �Autor  �Jean Schulz         � Data �  11/08/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Busca produto do usuario/familia, conforme parametrizado.  ���
���          �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function BuscaProd(cMatricula,lCodigo)

Local cRetorno 	:= "" 
Local aRet      := {}

//�����������������������������������������������������������������������Ŀ
//� Marcar areas atualmente em uso...                                     �
//�������������������������������������������������������������������������
Local aAreaBA1 := BA1->(GetArea())
Local aAreaBA3 := BA3->(GetArea())
Local aAreaBI3 := BI3->(GetArea())

BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))
BI3->(DbSetOrder(1))

If !Empty(cMatricula)
	If BA1->(MsSeek(xFilial("BA1")+cMatricula))
		If !Empty(BA1->BA1_CODPLA)       
			BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+BA1->(BA1_CODPLA+BA1_VERSAO)))
			aadd(aRet,{BA1->BA1_CODPLA+BA1->BA1_VERSAO, BI3->BI3_DESCRI})
		Else
			If BA3->(MsSeek(xFilial("BA3")+Substr(cMatricula,1,14)))
				BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+BA3->(BA3_CODPLA+BA3_VERSAO)))
				aadd(aRet,{BA3->BA3_CODPLA+BA3->BA3_VERSAO, BI3->BI3_DESCRI})
			Else
				MsgAlert("Atencao!","Produto no usu�rio/fam�lia n�o informado/inv�lido. Verifique!")
			Endif
		Endif 
	Else
		aadd(aRet,{"0000000", "PLANO NAO ENCONTRADO"})
	Endif
Endif

//�����������������������������������������������������������������������Ŀ
//� Retornar para areas em uso...                                         �
//�������������������������������������������������������������������������
RestArea(aAreaBA1)
RestArea(aAreaBA3)
RestArea(aAreaBI3)
If Empty(aRet)
	aadd(aRet,{"0000000", "PLANO NAO ENCONTRADO"})
Endif

cRetorno := aRet[1,1]
   
//�����������������������������������������������������������������������Ŀ
//� Retornar descricao ao inves de codigo...                              �
//�������������������������������������������������������������������������
If !lCodigo
	cRetorno := aRet[1,2]
Endif

Return cRetorno  



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldCtOPME �Autor  �Microsiga           � Data �  11/02/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida se existem codigos de OPME na guia. Caso existam,    ���
���          �devera exibir mensagem                                      ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VldCtOPME(cTabOPM)
Local lRet := .T.
Local cSQL := ""

cSQL := " SELECT COUNT(R_E_C_N_O_) AS NROOPME "
cSQL += " FROM "+RetSQLName("BD6")+" BD6 "
cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
cSQL += " AND BD6_CODOPE = '"+BE4->BE4_CODOPE+"' "
cSQL += " AND BD6_CODLDP = '"+BE4->BE4_CODLDP+"' "
cSQL += " AND BD6_CODPEG = '"+BE4->BE4_CODPEG+"' "
cSQL += " AND BD6_NUMERO = '"+BE4->BE4_NUMERO+"' "
cSQL += " AND BD6_ORIMOV = '2' "
cSQL += " AND BD6_CODPAD = '"+cTabOPM+"' " 
cSQL += " AND BD6.D_E_L_E_T_ = ' ' "       


If BCL->BCL_TIPGUI == "03"
	PLSQuery(cSQL,"TRBOPM")
	
	If TRBOPM->(NROOPME)	> 0 .And. !(Upper(Alltrim(cUsername)) $ GetNewPar("MV_YUSOPME","ABCDEF"))
		MsgAlert("Aten��o!!! Guia possui OPME!!!")
	Endif
	
	TRBOPM->(DbCloseArea())
	
Endif

Return lRet