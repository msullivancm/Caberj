#Include "rwmake.ch"
#Include "plsmger.ch"
#Include "plsmlib.ch"
#Include "colors.ch"
#Include "topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � BLQAUDEF � Autor � Jean Schulz          � Data � 28/03/07  ���
�������������������������������������������������������������������������͹��
���Descricao � Rotina para desbloquear os usuarios ja bloqueados automati-���
���          � camente por inadimplencia q nao envia para ANS e rebloquear���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function BLQAUDEF

Private oLeTxt
Private lAbortPrint :=.F.

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
PRIVATE cNomeProg   := "BLQAUDEF"
PRIVATE cPerg       := "BLQDEF"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cAlias      := "BA1"
PRIVATE cTamanho    := "M"
PRIVATE cTitulo     := "Bloqueio autom�tico inadimpl�ncia (120d)"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "RELBLQDEF"
PRIVATE nlin        := 100
PRIVATE nOrdSel     := 1
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrdens     := {} 
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Beneficiarios bloqueados automaticamente / 120 dias inadimpl�ncia"
PRIVATE cCabec2     := "C�digo do Benefici�rio  Nome                                       "
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0
PRIVATE nHdl
PRIVATE nTipo		:= GetMv("MV_COMP")


/*
@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Blq. autom. inadimp. 120 dias")
@ 02,10 TO 65,180
@ 10,018 Say " Este programa ira bloquear os benefici�rios que j� possu�rem  "
@ 18,018 Say " data de bloqueio de fam�lia ou usu�rio, e que foram bloquea-  "
@ 26,018 Say " dos atrav�s da rotina de blq autm�tico por inadimpl�ncia, que "
@ 34,018 Say " n�o notifica a ANS do bloqueio realizado (arquivo SIB). Esta  "
@ 42,018 Say " rotina foi desenvolvida especificamente a pedido da Caberj.   "
@ 70,098 BMPBUTTON TYPE 05 ACTION AjustaSX1(cPerg)
@ 70,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)
*/
// Paulo Motta   
@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Blq. autom. inadimp. 120 dias")
@ 02,10 TO 65,180
@ 10,018 Say " Este programa ira bloquear os benefici�rios que j� possuem  "
@ 18,018 Say " data de bloqueio de fam�lia ou usu�rio.                     "
@ 34,018 Say " Esta rotina foi desenvolvida especificamente a pedido da    "
@ 42,018 Say " Caberj.   "
@ 70,098 BMPBUTTON TYPE 05 ACTION AjustaSX1(cPerg)
@ 70,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered                      

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � OKLETXT  � Autor �                    � Data �  09/04/03   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao chamada pelo botao OK na tela inicial de processamen���
���          � to. Executa a leitura do arquivo texto.                    ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function OkLeTxt
Private cCodOpe	:= ""
Private cEmpDe	:= ""
Private cEmpAte	:= ""
Private cMatDe	:= ""
Private cMatAte	:= ""
Private nAcao	:= 0
Private dDatBas	:= CtoD("")
Private cMotBlo	:= ""

Pergunte(cPerg,.F.) 

cCodOpe	:= mv_par01
cEmpDe	:= mv_par02
cEmpAte	:= mv_par03
cMatDe	:= mv_par04
cMatAte	:= mv_par05
nAcao	:= mv_par06
dDatBas	:= mv_par07
cMotBlo	:= GetNewPar("MV_YBLQDEF","003") // Paulo Motta 10/10/07

WnRel   := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Return
Endif              

//��������������������������������������������������������������������������Ŀ
//� Seleciona tabelas...                                                     �
//����������������������������������������������������������������������������
BA1->(DbSetOrder(2))
BA3->(DbSetOrder(1))
BCA->(DbSetOrder(1))



//Manda imprimir...
SetDefault(aReturn,"BA1")

MsAguarde({|| Processa1() }, cTitulo, "", .T.)

//��������������������������������������������������������������������������Ŀ
//� Libera impressao                                                         �
//����������������������������������������������������������������������������
If  aReturn[5] == 1
	Set Printer To
	Ourspool(nRel)
End

MS_FLUSH()

Return                 


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � PROCESSA1� Autor � Jean Schulz        � Data �  28/03/07   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Processa1()

Local cBlqFin	:= GetNewPar("MV_YBLQFPR","024") // Paulo Motta
Local nTotRec	:= 0
Local nCont		:= 0
Local aUsrBlo	:= {}
Local aDadUsr	:= {}
Local aRet		:= {} 

Private lAmbos  := .t.

nTotRec := BuscaRegs()

ProcRegua(nTotRec)
TRB->(DbGoTop())

Begin Transaction

While !TRB->(Eof())
	
	nCont++
	IncProc("Processando Registro " + strzero(nCont,8)+" / "+StrZero(nTotRec,8))
	
	BA1->(MsSeek(xFilial("BA1")+TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)))
			
	If !Empty(TRB->BA1_DATBLO) .And. (TRB->BA1_MOTBLO == cBlqFin) .And. (TRB->BA1_DATBLO+60 <= dDatBas) 
	
		//���������������������������������������������������������������������Ŀ
		//� Monta matriz padrao com os dados do usuario...                      �
		//�����������������������������������������������������������������������		
		aRet := PLSDADUSR(TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase,nil,nil,nil)
		If aRet[1]
			aDadUsr := PLSGETUSR()
		Else
			Loop
		Endif
		
		//���������������������������������������������������������������������Ŀ
		//� Avalia a posicao financeira da familia usando funcao generica.      �
		//� Somar mais 60 dias para dt.base (atraso) = 120 dias.                �		
		//�����������������������������������������������������������������������		
		aPosFin := PLSVLDFIN(TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),dDatBas+60,'','','',aDadUsr)
         
		If !aPosFin[1]
		
			If BA3->(MSSeek(xFilial("BA3")+TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
			
				If !Empty(BA3->BA3_DATBLO) .And. (BA3->BA3_MOTBLO == cBlqFin) .And. (BA3->BA3_DATBLO+60 <= dDatBas)
					If nAcao == 2
						PL260BLOCO("BA3",BA3->(RecNo()),4,.T.,GetNewPar("MV_YDSBLDF","002"),dDatBas,"0")
						PL260BLOCO("BA3",BA3->(RecNo()),4,.T.,cMotBlo,dDatBas,"1")
					Endif
					aadd(aUsrBlo,{TRB->BA1_CODINT+"."+TRB->BA1_CODEMP+"."+TRB->BA1_MATRIC+"."+TRB->BA1_TIPREG+"."+TRB->BA1_DIGITO,TRB->BA1_NOMUSR})
				//Utilizar somente boqueios de familia para este tipo de inadimplencia.
				/*
				Else
					If nAcao == 2					
						If BCA->(MsSeek(xFilial("BCA")+TRB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+DtoS(BA1_DATBLO))))
							PL260BLOUS("BA1",TRB->(Recno()),4,.T.,GetNewPar("MV_YDSBLDF","002"),dDatBas,"0")
							PL260BLOUS("BA1",TRB->(Recno()),4,.T.,cMotBlo,dDatBlo,"1")
						Endif
					Endif
				*/
				Endif				
				
			Endif					
			
		Endif
	Endif
	
	TRB->(DbSkip())

Enddo

//�������������������������������������������Ŀ
//� Impressao do protocolo de exportacao.	  �  
//���������������������������������������������
//cCabec1     += " Data base: "+DtoC(dDatBas)
cCabec1     += " Data blq 120 dias : "+DtoC(dDatBas)
For nCont := 1 To Len(aUsrBlo)

	If nLin > nQtdLin
		nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
		nLin+=2
	Endif
			
	@ nLin,000 PSay aUsrBlo[nCont,1]+Space(3)+aUsrBlo[nCont,2]
	nLin++

Next

End Transaction

TRB->(DbCloseArea())
Close(oLeTxt)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BuscaRegs �Autor  �Microsiga           � Data �  03/28/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function BuscaRegs()
Local nQtdReg := 0
Local cSQL := ""  
Local nCont := 0

For nCont := 1 to 2
	If nCont == 1
		cSQL := " SELECT COUNT(R_E_C_N_O_) AS TOTAL FROM "+RetSQLName("BA1")
	Else
		cSQL := " SELECT * FROM "+RetSQLName("BA1")
	Endif
		
	cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSQL += " AND BA1_CODINT = '"+cCodOpe+"' " 
	cSQL += " AND BA1_CODEMP BETWEEN '"+cEmpDe+"' AND '"+cEmpAte+"' "
	cSQL += " AND BA1_MATRIC BETWEEN '"+cMatDe+"' AND '"+cMatAte+"' "
	cSQL += " AND BA1_DATBLO <> ' '"
	cSQL += " AND D_E_L_E_T_ = ' '" 
	
	If nCont == 1
		PLSQuery(cSQL,"TRB")
		nQtdReg := TRB->(TOTAL)
		TRB->(DbCloseArea())
	Else
		PLSQuery(cSQL,"TRB")
	Endif
Next

Return nQtdReg

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AjustaSX1 �Autor  � Jean Schulz        � Data �  28/03/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ajusta os parametros                                       ���
���          �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AjustaSX1(cPerg)
Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Operadora")			,"","","mv_ch1","C",04,0,0,"G","","B89","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Empresa De")			,"","","mv_ch2","C",04,0,0,"G","","BG9","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Empresa Ate")			,"","","mv_ch3","C",04,0,0,"G","","BG9","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Matr�cula De")			,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Matr�cula Ate")		,"","","mv_ch5","C",06,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("A��o")					,"","","mv_ch6","C",01,0,1,"C","","","","","mv_par06","Analisar","","","","Anl./Bloqueia","","","","","","","","","","","",{},{},{})
// Paulo Motta
//PutSx1(cPerg,"07",OemToAnsi("Data Base")			,"","","mv_ch7","D",08,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Data Blq 120 dias")   ,"","","mv_ch7","D",08,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1(cPerg,"08",OemToAnsi("Tipo Bloqueio")		,"","","mv_ch8","C",03,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})

Pergunte(cPerg,.T.) 

Return