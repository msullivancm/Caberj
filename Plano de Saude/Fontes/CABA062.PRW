#include "PROTHEUS.CH"
#include "TOPCONN.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �CABA062  � Autor � Renato Peixoto       � Data � 04/05/2012 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Rotina que faz o acerto da tabela ZZP (protoc. de remessa) |��
���          � para que os valores que j� constam na tabela sejam         ���
���          � para o novo layout do protocolo de remessa.                ���    
�������������������������������������������������������������������������Ĵ��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������Ĵ��
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CABA062()



Processa({|| AcertaZZP() }, "Rotina de acerto da tabela ZZP", "", .T.)


Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AcertaZZP �Autor  �Renato Peixoto      � Data �  02/05/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina que ir� realizar o acerto na tabela ZZP, de acordo  ���
���          � com o novo layout do protocolo de entrega de remessa.      ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function AcertaZZP()

Local nTotRegZZP := 0
Local nCont      := 0
Local cQuery     := ""
//Local cQuery2    := ""
Local cAlias1    := ""
//Local cAlias2    := ""
Local nTotAmb    := 0
Local nTotInt    := 0
Local nTotGer    := 0
Local nRegsProc  := 0

Private cPerg    := "CABA062"  
Private cMes     := ""
Private cAno     := ""

AjustaSX1()

Pergunte(cPerg,.T.)

cMes := MV_PAR02
cAno := MV_PAR01

cQuery := "SELECT Count(*) TOT_REG_ZZP "
cQuery += "FROM "+RetSqlName("ZZP010")+" ZZP "
cQuery += "WHERE D_E_L_E_T_ = ' ' "
cQuery += "AND zzp_filial = '  ' " 
//cQuery += "AND ZZP_MESPAG = '01' AND ZZP_ANOPAG = '2012' "

TcQuery cQuery New Alias cAlias1

nTotRegZZP := cAlias1->TOT_REG_ZZP

If nTotRegZZP = 0
	APMSGALERT("N�o existem registros a serem processados.","Tabela ZZP vazia")
	Return
Else
	ProcRegua(nTotRegZZP)
EndIf

/*
cQuery2 := "SELECT * "
cQuery2 += "FROM "+RetSqlName("ZZP010")+" ZZP "
cQuery2 += "WHERE D_E_L_E_T_ = ' ' "
cQuery2 += "AND zzp_filial = '  ' " 
cQuery2 += "AND ZZP_MESPAG = '01' AND ZZP_ANOPAG = '2012' "

TcQuery cQuery2 New Alias cAlias2

cAlias2->(DbGoTop())
*/
DbSelectArea("ZZP")
ZZP->(DbGoTop())

While !(ZZP->(Eof()))
	//DbSelectArea("ZZP")
	//DbSetOrder(1)
	//If DbSeek(XFILIAL("ZZP")+cAlias2->ZZP_CODRDA+cAlias2->ZZP_MESPAG+cAlias2->ZZP_ANOPAG)
	If ZZP->ZZP_MESPAG = cMes .AND. ZZP->ZZP_ANOPAG = cAno
		If ZZP->ZZP_QTOTGU = 0 .AND. ZZP->ZZP_VLTGUI = 0
			IncProc("Processando mes "+cMes+" do ano "+cAno+"...")
			nCont++
			nRegsProc++
			RecLock("ZZP",.F.)
			//Faz a troca de conteudo dos campos ref. a outros atendimentos ambulatoriais, que hoje estao invertidos com o novo layout
			If (ZZP->ZZP_QTDODS <> 0  .AND. ZZP->ZZP_VLRODS <> 0) .AND. (ZZP->ZZP_QTDAMB = 0 .AND. ZZP->ZZP_VLRAMB = 0)
				ZZP->ZZP_QTDAMB := ZZP->ZZP_QTDODS
				ZZP->ZZP_VLRAMB := ZZP->ZZP_VLRODS
				ZZP->ZZP_QTDODS := 0
				ZZP->ZZP_VLRODS := 0
			EndIf
			//Atualiza totais ambulatoriais
			ZZP->ZZP_QTDTOT := ZZP->ZZP_QTDCON+ZZP->ZZP_QTDSAD+ZZP->ZZP_QTDAMB
			ZZP->ZZP_VLRTOT := ZZP->ZZP_VLRCON+ZZP->ZZP_VLRSAD+ZZP->ZZP_VLRAMB
			//Atualiza totais interna��o
			ZZP->ZZP_QTOTIN := ZZP->ZZP_QTDINT+ZZP->ZZP_SADINT+ZZP->ZZP_QTDHON+ZZP->ZZP_QTDODS
			ZZP->ZZP_VLTOTI := ZZP->ZZP_VLRINT+ZZP->ZZP_VLSDTI+ZZP->ZZP_VLRHON+ZZP->ZZP_VLRODS
			//Atualiza total geral do protocolo
			ZZP->ZZP_QTOTGU := ZZP->ZZP_QTDTOT+ZZP->ZZP_QTOTIN+ZZP->ZZP_QTDODN
			ZZP->ZZP_VLTGUI := ZZP->ZZP_VLRTOT+ZZP->ZZP_VLTOTI+ZZP->ZZP_VLRODN
			ZZP->(MsUnlock())
		    
			ZZP->(DbSkip())
		
    	Else
    		IncProc()
    		nCont++
    		ZZP->(DbSkip())
    	
    	EndIf
    
    Else
    	IncProc()
    	nCont++
    	ZZP->(DbSkip())
    
    EndIf
    /*
    If nCont = 2
    	Alert("Chegou ao fim do teste.")
    	Return
    EndIf
    */
    
EndDo

APMSGINFO("Foram processados "+Alltrim(STR(nRegsProc))+" de um total de "+AllTrim(STR(nCont))+" registros.","Quantidade de registros processados.")

Return 



********************************************************************************************************************************

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � AjustaSX1� Autor � Renato Peixoto                          ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ajusta as perguntas do SX1                                 ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe o ano")
PutSX1(cPerg , "01" , "Ano" 	,"","","mv_ch1","C",4,0,0,"G",""	,"","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o m�s")
PutSX1(cPerg , "02" , "Mes" 	,"","","mv_ch2","C",2,0,0,"G",""	,"","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

Return
