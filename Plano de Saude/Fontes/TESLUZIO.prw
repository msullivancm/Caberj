#Include "rwmake.ch"
#Include "plsmger.ch"
#Include "plsmlib.ch"
#Include "colors.ch"
#Include "topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � PREPCART � Autor � Jean Schulz          � Data � 11/11/06  ���
�������������������������������������������������������������������������͹��
���Descricao � Rotina para preparacao e manipulacao do arquivo de cartao  ���
���          � de identificacao, conforme necessidade do cliente.         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function TESLUZ()

Local cCodPla := Space(0)

Private oLeTxt
Private lAbortPrint :=.F.

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
PRIVATE cNomeProg   := "TESTE1"
PRIVATE cPerg       := "PREPCA"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cAlias      := "BA1"
PRIVATE cTamanho    := "M"
PRIVATE cTitulo     := "Prepara emissao do cartao"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "RELIMPFAR"
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
PRIVATE cCabec1     := "Beneficiarios exportados no arquivo"
PRIVATE cCabec2     := "C�digo do Benefici�rio  Nome                                       Validade Cart�o"
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0
PRIVATE nHdl
PRIVATE nTipo		:= GetMv("MV_COMP")


@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Leitura de Arquivo Texto")
@ 02,10 TO 65,180
@ 10,018 Say " Este programa ira preparar a exporta��o do arquivo de cartao  "
@ 18,018 Say " de identifica��o, a fim de inserir e ordenar o arquivo de     "
@ 26,018 Say " acordo com a necessidade da Caberj.                           "
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
Local nCont			:= 0     

PRIVATE cNomeArq	:= ""
PRIVATE nOrdem		:= 0

Pergunte(cPerg,.F.) 

cNomeArq	:= mv_par01 
nOrdem		:= mv_par02

If !File(cNomeArq) 
	MsgStop("Arquivo Inv�lido! Programa encerrado.")
	Close(oLeTxt)
	Return
End

WnRel   := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Return
Endif              

//��������������������������������������������������������������������������Ŀ
//� Seleciona tabelas...                                                     �
//����������������������������������������������������������������������������
BA1->(DbSetOrder(2))

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
���Fun��o    � PROCESSA1� Autor � Jean Schulz        � Data �  23/03/07   ���
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

Local aStruc 	:= {}
Local nLinha 	:= 0
Local cTipReg	:= ""
Local aImpCart	:= {}
Local nCont		:= 0
Local nCont2	:= 0
Local cLin		:= ""
Local cNomeArq2	:= GetNewPar("MV_YDEXCAR","\Interface\Exporta\Cartao\")
Local cArqTmp	:= ""
Local cEOL		:= CHR(13)+CHR(10)
Local nColuna	:= 0
Local nPos		:= 0
Local _cTexto := ""

Local aHeader   := {}
Local aTrailler := {}
Local aOrdena	:= {}
Local aImp		:= {}
Local lPrima	:= .T.

Private cTrbPos

cNomeArq := Alltrim(cNomeArq)
nCont := Len(cNomeArq)
While nCont <> 0

	If Substr(cNomeArq,nCont,1)	<> "\"
		cArqTmp := Substr(cNomeArq,nCont,1)+cArqTmp
	Else
		nCont := 0
		Exit
	Endif
	nCont--                                    
	
Enddo

cNomeArq2 += cArqTmp

//���������������������������������������������������������������������Ŀ
//� Criacao do arquivo temporario...                                    �
//�����������������������������������������������������������������������
aAdd(aStruc,{"CAMPO","C",500,0})

//nHdl := fOpen(cArquivo,68)
cTrbPos := CriaTrab(aStruc,.T.)

If Select("TrbPos") <> 0
	TrbPos->(dbCloseArea())
End

DbUseArea(.T.,,cTrbPos,"TrbPos",.T.)            

MsgRun("Atualizando Arquivo...",,{|| PLSAppTmp(),CLR_HBLUE})

TRBPOS->(DbGoTop())
If TRBPOS->(EOF())
	MsgStop("Arquivo Vazio!")
	TRBPOS->(DBCLoseArea())
	Close(oLeTxt)
	lRet := .F.
	Return
End

ProcRegua(TRBPOS->(LastRec()))
TRBPOS->(DbGoTop())

While !TRBPOS->(Eof())
	
	nLinha++    
	IncProc("Processando Linha ... " + strzero(nLinha,6))
	
	cString := StrTran(TRBPOS->CAMPO,'"',"")
	aadd(aImpCart,cString)
	TRBPOS->(DbSkip())     

Enddo

//nColuna	:= 0
For nCont := 1 to Len(aImpCart)
	Aadd(aOrdena,{})
	While .T.
		nPos := At(";",aImpCart[nCont])
		If nPos > 0
			Aadd(aOrdena[nCont],Substr(aImpCart[nCont],1,nPos-1))
			aImpCart[nCont] := Substr(aImpCart[nCont],nPos+1)
		Else
//			aOrdena[Len(aOrdena),20] := Alltrim(aImpCart[nCont])
//			aImpCart[nCont] := ""
			Exit
		Endif
	Enddo
	
Next			

//aOrdena := aclone(aImpCart)

aImpCart := {}

//��������������������������������������������������������������������������Ŀ
//� Ordenar array...                                                         �
//����������������������������������������������������������������������������
ProcRegua(Len(aOrdena))
If nOrdem == 1
	//��������������������������������������������������������������������������Ŀ
	//� Buscar de BA1 o campo YLOTAC para realizar a ordenacao Itau.             �
	//����������������������������������������������������������������������������
	BA1->(DbSetOrder(2))
	For nCont := 1 to Len(aOrdena)	    
	
		IncProc("Ajustando registro "+StrZero(nCont,6)+" de "+StrZero(Len(aOrdena),6))
	    
		cCodBA1 := StrTran(aOrdena[nCont,7],".","")
		cCodBA1	:= StrTran(cCodBA1,"-","")
		
		If BA1->(MsSeek(xFilial("BA1")+cCodBA1))
			aOrdena[nCont,6]  := AllTrim(BA1->BA1_NOMUSR)
		Else
			MsgAlert("N�o foi encontrado o usuario: "+aOrdena[nCont,7]+" no cadastro. Verifique!")
		Endif
	
	Next
	cCabec2     := "Lotacao           C�digo do Benefici�rio  Nome                                       Validade Cart�o"
Else
	MsgAlert("Ponto para ser escrita a l�gica da ordem nro 2 para a rotina de ajuste de cart�o!")
Endif

//��������������������������������������������������������������������������Ŀ
//� Buscar de BA1 o campo YLOTAC para realizar a ordenacao Itau.             �
//����������������������������������������������������������������������������
For nCont := 1 to Len(aOrdena)
	
	cString := "" // StrZero(nCont,11)+";"
	
	aadd(aImp,{aOrdena[nCont,7],aOrdena[nCont,6],aOrdena[nCont,4],""})
	
	For nCont2 := 1 To (Len(aOrdena[nCont]))
	    cString+=aOrdena[nCont,nCont2]+";"
	Next   
	aadd(aImpCart,cString)

Next

cLin := Space(1)+cEOL

If U_Cria_TXT(cNomeArq2)

	For nCont := 1 to Len(aImpCart)
	
		If !(U_GrLinha_TXT(aImpCart[nCont],cLin))
			MsgAlert("ATEN��O! N�O FOI POSS�VEL GRAVAR CORRETAMENTE O CONTE�DO! OPERA��O ABORTADA!")
			Return
		Endif
		
	Next
	
	U_Fecha_TXT()	

Endif

//�������������������������������������������Ŀ
//� Impressao do protocolo de exportacao.	  �  
//���������������������������������������������
For nCont := 1 To Len(aImp)

	If nLin > nQtdLin
		nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
	Endif
	
	If lPrima
		@ nLin,000 PSay "Arquivo a ser enviado: "+cNomeArq2
		nLin++					
		lPrima := .F.
	Endif
			
	If nOrdem == 1
		@ nLin,000 PSay aImp[nCont,4]+Space(3)+aImp[nCont,1]+Space(3)+aImp[nCont,2]+Space(40-Len(aImp[nCont,2]))+Space(3)+aImp[nCont,3]
	Else
		@ nLin,000 PSay aImp[nCont,1]+Space(3)+aImp[nCont,2]+Space(40-Len(aImp[nCont,2]))+Space(3)+aImp[nCont,3]
	EndIf
	nLin++

Next

TRBPOS->(DbCloseArea())

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �PLSAppend � Autor � Rafael             � Data �  29/10/04   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao de append no arquivo TXT para o arquivo de trabalho.���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function PLSAppTmp()


DbSelectArea("TRBPOS")
Append From &(cNomeArq) SDF

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � AjustaSX1�Autor  � Jean Schulz        � Data �  11/11/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ajusta os parametros                                       ���
���          �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AjustaSX1(cPerg)
Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Arquivo Padr�o ")				,"","","mv_ch1","C",60,0,0,"G","U_fGetFile('Txt     (*.Txt)            | *.Txt | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Ordem do arquivo:") 			,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Lota��o","","","","Ordem 2","","","","","","","","","","","",{},{},{})
Pergunte(cPerg,.T.) 

Return

