#Include "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � PrepRea  � Autor � Thiago Machado Correa � Data � 21/06/08 ���
�������������������������������������������������������������������������͹��
���Descricao � Prepara base de dados para tratar reajuste parcelado.      ���
�������������������������������������������������������������������������͹��
���Uso       � Caberj		                                              ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function PrepRea()

Local cPerg := "PLSY98"

Private oLeTxt
Private lAbortPrint :=.F.
                            
AjustaX1(cPerg)

@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Prepara Reajuste")
@ 02,10 TO 65,180
@ 10,018 Say " Esta rotina tem por objetivo preparar a base de dados "
@ 18,018 Say " para tratamento do reajuste parcelado.                "
@ 28,018 Say "                                                       "
@ 70,098 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)
@ 70,128 BMPBUTTON TYPE 01 ACTION Ajusta(cPerg)
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � Ajusta   � Autor � Thiago Machado Correa � Data � 21/06/08 ���
�������������������������������������������������������������������������͹��
���Descri��o � Processa a rotina de ajuste 						          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Ajusta(cPerg)

Local cMes := ""
Local cAno := ""

Pergunte(cPerg,.F.)

cMes := mv_par01
cAno := mv_par02

// Inserido por Luzio em 23/06/08 para testar se os paraemtnros estao vazios.
If Empty(cMes) .or. Empty(cAno)
	MsgStop("Parametro do mes e/ou ano vazio!Corrija!")
	Return
EndIf
Processa({|| AjustaRea(cMes,cAno)},"Pesquisando...")

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � AjustaRea� Autor � Thiago Machado Correa � Data � 21/06/08 ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao Principal                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function AjustaRea(cMes,cAno)

Local cSQL := ""  
Local cStr := ""
Local nTmp := 0
Local nPar := GetNewPar("MV_YNRPARE",1)
Local aLog := {}

BA3->(DbSetOrder(1))

cStr := RetMesRea(cMes,cAno,nPar)

//Corrige familias conforme intervalo de meses calculado
cSQL := " SELECT BA3_CODINT, BA3_CODEMP, BA3_MATRIC FROM " + RetSqlName("BA3")
cSQL += " WHERE BA3_FILIAL = '" + xFilial("BA3") + "'"
cSQL += " AND BA3_YREAPC = '1' "
cSQL += " AND BA3_YMESRE IN ("+RetStrSql(cStr)+") "
cSQL += " AND BA3_MESREA <> '"+cMes+"' "
cSQL += " AND D_E_L_E_T_ <> '*' "                

PLSQuery(cSQL,"BA3TMP") 	

While ! BA3TMP->(Eof())
	nTmp++
	BA3TMP->(DbSkip())
EndDo

BA3TMP->(DbGoTop())

ProcRegua(nTmp)

While ! BA3TMP->(Eof())

	IncProc("Processo 1/2 - Fam�lia: "+BA3TMP->BA3_CODINT+"."+BA3TMP->BA3_CODEMP+"."+BA3TMP->BA3_MATRIC)
                   
	If BA3->(MsSeek(xFilial("BA3")+BA3TMP->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))
	
		BA3->(Reclock("BA3",.F.))
		BA3->BA3_MESREA := cMes
		BA3->(MsUnlock())
		
    Endif
    
	BA3TMP->(DbSkip())
EndDo        

BA3TMP->(DbCloseArea())

//Corrige familias fora do intervalo de meses calculado
nTmp := 0

cSQL := " SELECT BA3_CODINT, BA3_CODEMP, BA3_MATRIC FROM " + RetSqlName("BA3")
cSQL += " WHERE BA3_FILIAL = '" + xFilial("BA3") + "'"
cSQL += " AND BA3_YREAPC = '1' "
cSQL += " AND BA3_YMESRE NOT IN ("+RetStrSql(cStr)+") "
cSQL += " AND BA3_MESREA <> BA3_YMESRE "
cSQL += " AND D_E_L_E_T_ <> '*' "                

PLSQuery(cSQL,"BA3TMP") 	

While ! BA3TMP->(Eof())
	nTmp++
	BA3TMP->(DbSkip())
EndDo

BA3TMP->(DbGoTop())

ProcRegua(nTmp)

While ! BA3TMP->(Eof())

	IncProc("Processo 2/2 - Fam�lia: "+BA3TMP->BA3_CODINT+"."+BA3TMP->BA3_CODEMP+"."+BA3TMP->BA3_MATRIC)
                   
	If BA3->(MsSeek(xFilial("BA3")+BA3TMP->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)))
	
		BA3->(Reclock("BA3",.F.))
		BA3->BA3_MESREA := BA3->BA3_YMESRE
		BA3->(MsUnlock())
		
    Endif
    
	BA3TMP->(DbSkip())
EndDo        

BA3TMP->(DbCloseArea())

MsgInfo("Processo Conclu�do!")

Return
      
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � RetMesRea  �Autor �Thiago Machado Correa � Data � 21/06/08 ���
�������������������������������������������������������������������������͹��
���Descricao � Retorna Meses de Reajuste								  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RetMesRea(cMes,cAno,nPar)

Local cRet := ""
Local nFor := 1
Local dTmp := StoD(cAno+cMes+"15")

For nFor := 1 to nPar
	cRet += substr(DtoS(dTmp),5,2)
	dTmp -= 30                    
	If nFor <> nPar
		cRet += ","
	EndIf
Next

Return cRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � RetStrSql  �Autor �Thiago Machado Correa � Data � 21/06/08 ���
�������������������������������������������������������������������������͹��
���Descricao � Retorna String para utilizar na clausula IN do SQL		  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RetStrSql(cVar)

Local cRet := "'"
Local nTmp := 0                   
Local cStr := Alltrim(cVar)

For nTmp := 1 to len(cStr)
	If substr(cStr,nTmp,1) == ","
		cRet += "','"
	Else
		cRet += substr(cStr,nTmp,1)
	Endif
Next

cRet += "'"

Return cRet

/*
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������ͻ��
���Programa  � AjustaX1 �Autor  �Thiago Machado Correa� Data �  21/06/08   ���
��������������������������������������������������������������������������͹��
���Desc.     � Ajusta as perguntas da rotina.               		       ���
��������������������������������������������������������������������������ͼ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
*/
Static Function AjustaX1(cPerg)

Local aRegs	:=	{}

aadd(aRegs,{cPerg,"01","Mes Reajuste","","","mv_ch1","C",2,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aadd(aRegs,{cPerg,"02","Ano Reajuste","","","mv_ch2","C",4,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
  
PlsVldPerg( aRegs )

Return