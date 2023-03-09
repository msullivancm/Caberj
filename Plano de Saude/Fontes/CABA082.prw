#INCLUDE  "RWMAKE.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � CABA082  � Autor � Jose Carlos Noronha   � Data � 31/08/07 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Rotina Para Liberar / Bloquear Titulos do PLS              ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Caberj                                                     ���
��������������������������������������������������������������������������ٱ�
��� Altera��es � Edilson Leal 04/01/08 - Uso de novos filtros             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function CABA082(cLibBlq)                

 Private aArea    := GetArea()
 Private aAreaSE2 := GetArea("SE2")

 FProcLibBloq(cLibBlq)

 RestArea(aAreaSE2) 
 RestArea(aArea)
 
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �FProcLibBloq� Autor � Jose Carlos Noronha � Data � 02/08/07 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Rotina Para Liberar / Bloquear Titulos do PLS              ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � FProcLibBloq(cLibBlq)                                      ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Caberj                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function FProcLibBloq(cLibBlq)

nmarcados := 1

If cLibBlq = "1"
	If SE2->E2_YLIBPLS = "S" .or. SE2->E2_YLIBPLS = "M"
       msgBox("Titulo J� Foi Liberado...","Libera��o de Titulos","INFO") 
	    Return
   ElseIf SE2->E2_SALDO = 0
       msgBox("Titulo Baixado N�o Pode Ser Liberado (Sem Saldo)...","Libera��o de Titulos","INFO") 
	    Return
	Endif    
	cMensgBx := "Confirma a Liberacao "+iif(nmarcados=1,"Deste Titulo ?","Destes Titulos ?")
Else
	If SE2->E2_YLIBPLS = "N" .or. SE2->E2_YLIBPLS = "L"
       msgBox("Titulo J� Foi Bloqueado...","Bloqueio de Titulos","INFO") 
	    Return
   ElseIf SE2->E2_SALDO = 0
       msgBox("Titulo Baixado N�o Pode Ser Bloqueado (Sem Saldo)...","Bloqueio de Titulos","INFO") 
	    Return
	Endif    
	cMensgBx := "Confirma o Bloqueio "+iif(nmarcados=1,"Deste Titulo ?","Destes Titulos ?")
Endif

If MSGYESNO(cMensgBx)
   RecLock("SE2",.F.)
	SE2->E2_YLIBPLS := Iif(cLibBlq="1","M","N")

	If cLibBlq = "1" .Or. cLibBlq = "2"
		SE2->E2_USUALIB := UPPER(SZA->ZA_NOME)                    // Usuario que Liberou/Bloqueou o Titulo
	   SE2->E2_YDTLBPG := dDataBase
	Endif	

	MSunlock()
	VerImpostos(cLibBlq)
	
	dbSelectArea("SE2")
	If MV_PAR01 = 1
		cFilPLS := 'LEFT(E2_ORIGEM,3)="PLS"'    // Todos
	ElseIf MV_PAR01 = 2
		cFilPLS := 'LEFT(E2_ORIGEM,3)="PLS" .and. E2_YLIBPLS $ "N|L" .And.(Date()-E2_VENCREA)<=GETMV("MV_DIASPLS")'     // Bloqueados
	ElseIf MV_PAR01 = 3
		cFilPLS := 'LEFT(E2_ORIGEM,3)="PLS" .and. E2_YLIBPLS $ "N|L" .and. (Date()-E2_VENCREA)>GETMV("MV_DIASPLS")'    // Bloqueados +60 Dias
	ElseIf MV_PAR01 = 4
		cFilPLS := 'LEFT(E2_ORIGEM,3)="PLS" .and. E2_YLIBPLS $ "S|M"'    // Liberados
	Endif
	cFilPLS += ' .And. (E2_EMISSAO >= mv_par02 .And. E2_EMISSAO <= mv_par03) .And. (E2_VENCREA >= mv_par04 .And. E2_VENCREA <= mv_par05) '
	cFilImp := cFilPLS+'.and. (!E2_TIPO $ GETMV("MV_TIPOPLS")) .And. E2_SALDO > 0'
	Set Filter To &cFilImp
	dbgotop()
Endif
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �VerImpostos � Autor � Jose Carlos Noronha � Data � 02/08/07 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Verificar se Tem Titulos de Impostos do PLS                ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � VerImpostos(cLibBlq)                                       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Caberj                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static FuncTion VerImpostos(cLibBlq)

LOCAL cPrefixo := SE2->E2_PREFIXO    
LOCAL cNum	   := SE2->E2_NUM        
LOCAL cParcPai

DbSelectArea("SE2")
nReg := RECNO()
If SE2->E2_ISS > 0
	nValorPai := SE2->E2_ISS
	cParcPai  := SE2->E2_PARCISS
	cTipoPai  := MVISS
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_INSS > 0
	nValorPai := SE2->E2_INSS
	cParcPai  := SE2->E2_PARCINS
	cTipoPai  := MVINSS
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_SEST > 0
	nValorPai := SE2->E2_SEST
	cParcPai  := SE2->E2_PARCSES
	cTipoPai  := "SES"
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_PIS > 0
	nValorPai := SE2->E2_PIS
	cParcPai  := SE2->E2_PARCPIS
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_COFINS > 0
	nValorPai := SE2->E2_COFINS
	cParcPai  := SE2->E2_PARCCOF
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_CSLL > 0
	nValorPai := SE2->E2_CSLL
	cParcPai  := SE2->E2_PARCSLL
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
dbgoto(nReg)
If SE2->E2_IRRF > 0
	nValorPai := SE2->E2_IRRF
	cParcPai  := SE2->E2_PARCIR
	cTipoPai  := MVTAXA
	AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
Endif
Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �AchaImpostos� Autor � Jose Carlos Noronha � Data � 02/08/07 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Achar Titulos de Impostos do PLS                           ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Caberj                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function AchaImpostos(nValorPai,cParcPai,cTipoPai,xFilial,xPrefixo,cNum,cLibBlq)
dbSelectArea("SE2")
dbClearFilter()
If dbSeek(xFilial+xPrefixo+cNum)
	While !Eof() .and. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) == xFilial+xPrefixo+cNum
		If cParcPai == SE2->E2_PARCELA .and. cTipoPai = SE2->E2_TIPO
			If nValorPai != 0
				RecLock("SE2",.F.)
				SE2->E2_YLIBPLS := Iif(cLibBlq="1","M","N")
				SE2->E2_USUALIB := UPPER(SZA->ZA_NOME)                    // Usuario que Liberou/Bloqueou o Titulo
				MSunlock()
				Exit
			EndIf
		EndIf
		DbSkip()
	Enddo
EndIf
dbSelectArea("SE2")
dbgoto(nReg)
Return
