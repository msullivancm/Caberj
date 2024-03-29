#Include "rwmake.ch"
#Include "plsmger.ch"
#Include "plsmlib.ch"
#Include "colors.ch"
#Include "topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � RELCART     � Autor � Jean Schulz       � Data � 25/04/08  ���
�������������������������������������������������������������������������͹��
���Descricao � Relatorio para analise de cartao de identificacao.         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function RELCART

Private oLeTxt
Private lAbortPrint :=.F.

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
PRIVATE cNomeProg   := "RELCART"
PRIVATE cPerg       := "RLCART"
PRIVATE nQtdLin     := 55
PRIVATE nLimite     := 210
PRIVATE cControle   := 15
PRIVATE cAlias      := "BED"
PRIVATE cTamanho    := "P"
PRIVATE cTitulo     := "Confer�ncia de emiss�o do cart�o"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE nRel        := "RELCART"
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
PRIVATE cCabecP     := "Confer�ncia de emiss�o do cart�o"
PRIVATE cCabec1     := ""
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0


@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Relat�rio de cart�es emitidos")
@ 02,10 TO 65,180
@ 10,018 Say " Este relat�rio � destinado a exibir as informa��es sobre a     "
@ 18,018 Say " emiss�o de cartoes de identifica��o, separando por lotes.      "
@ 24,018 Say " Ser�o apenas demonstrados os cart�es com lotes entregues.      "
@ 70,098 BMPBUTTON TYPE 05 ACTION AjustaSX1(cPerg)
@ 70,128 BMPBUTTON TYPE 01 ACTION OkRelat()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered                      

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � OkRelat  � Autor �                    � Data �  09/04/03   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao chamada pelo botao OK na tela inicial de processamen���
���          � to. Executa a rotina de relatorio...                       ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function OkRelat
Local nCont := 0     

PRIVATE cProIni		:= ""
PRIVATE cProFim		:= ""
PRIVATE dDatEntIni	:= ""
PRIVATE dDatEntFim	:= ""
PRIVATE cEmpRDe		:= ""
PRIVATE cEmpRAte	:= ""

Pergunte(cPerg,.F.) 

cProIni		:= mv_par01
cProFim		:= mv_par02
dDatEntIni	:= mv_par03
dDatEntFim	:= mv_par04  
cEmpRDe		:= mv_par05
cEmpRAte	:= mv_par06

cCabec1	:= " Relat�rio de an�lise de cart�es entregues por per�odo" 
nRel   := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Return
Endif              

//Manda imprimir...
SetDefault(aReturn,"BED")

Processa({|| Processa1() }, cTitulo, "", .T.)

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
���Fun��o    � PROCESSA1� Autor � Jean Schulz        � Data �  30/10/05   ���
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
Local cSQL		:= ""
Local nCont		:= 0
Local nTotReg	:= 0
Local nLin		:= 0
Local nTotTit	:= 0
Local lPrima	:= .T.
Local nVlrDes	:= 0

Local nTotPla := 0
Local nTotLot := 0
Local nTotOpe := 0
Local nTotGer := 0

Local aTotErr	:= {}

For nCont := 1 to 2        

	cSQL := " SELECT BA1_OPEORI, BED_CDIDEN, BED_MOTIVO, BPX_DESCRI, BDE_EMPRES, Decode(BA1_CODPLA,'    ',BA3_CODPLA||BA3_VERSAO, BA1_CODPLA||BA1_VERSAO) 
	cSQL += " AS PLANOVERSAO, Count(BED.R_E_C_N_O_) AS TOTREG "
	cSQL += " FROM "+RetSQLName("BED")+" BED, "+RetSQLName("BDE")+" BDE, "+RetSQLName("BPX")+" BPX, "+RetSQLName("BA1")+" BA1, "+RetSQLName("BA3")+" BA3 "
	cSQL += " WHERE BED_FILIAL = '"+xFilial("BED")+"' "
	cSQL += " AND BED_CODINT = '"+PLSINTPAD()+"' "
	cSQL += " AND BED_CODINT = BDE_CODINT "
	cSQL += " AND BED_CDIDEN = BDE_CODIGO "
	cSQL += " AND BDE_DATENT BETWEEN '"+DtoS(dDatEntIni)+"' AND '"+DtoS(dDatEntFim)+"' "
	cSQL += " AND BDE_EMPRES BETWEEN '"+cEmpRDe+"' AND '"+cEmpRAte+"' "
	cSQL += " AND BPX_FILIAL = '"+xFilial("BPX")+"' "
	cSQL += " AND BPX_CODINT = BED_CODINT "
	cSQL += " AND BPX_MOTIVO = BED_MOTIVO "
	
	cSQL += " AND BA3_FILIAL = '"+xFilial("BA3")+"' "
	cSQL += " AND BA3_CODINT = BED_CODINT "
	cSQL += " AND BA3_CODEMP = BED_CODEMP "
	cSQL += " AND BA3_MATRIC = BED_MATRIC "
	cSQL += " AND BA1_FILIAL = '"+xFilial("BA1")+"'  "
	cSQL += " AND BA1_CODINT = BED_CODINT "
	cSQL += " AND BA1_CODEMP = BED_CODEMP "
	cSQL += " AND BA1_MATRIC = BED_MATRIC "
	cSQL += " AND BA1_TIPREG = BED_TIPREG "
	cSQL += " AND BA1_DIGITO = BED_DIGITO "
	
	cSQL += " AND BED.D_E_L_E_T_ = ' ' "
	cSQL += " AND BDE.D_E_L_E_T_ = ' ' "
	cSQL += " AND BPX.D_E_L_E_T_ = ' ' "
	cSQL += " AND BA1.D_E_L_E_T_ = ' ' "
	cSQL += " AND BA3.D_E_L_E_T_ = ' ' "
	
	cSQL += " GROUP BY BA1_OPEORI, BED_CDIDEN, BED_MOTIVO, BPX_DESCRI, BDE_EMPRES, Decode(BA1_CODPLA,'    ',BA3_CODPLA||BA3_VERSAO, BA1_CODPLA||BA1_VERSAO) "
	cSQL += " ORDER BY PLANOVERSAO, BA1_OPEORI, BDE_EMPRES, BED_CDIDEN "

Next
	
PLSQuery(cSQL,"TRB")

nTotReg := 0
While !TRB->(Eof())
	nTotReg++
	TRB->(DbSkip())
Enddo

ProcRegua(nTotReg)

TRB->(DbGotop())

Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)
nLin := 9  

BI3->(DbSetOrder(1)) //BI3_FILIAL + BI3_CODINT + BI3_CODIGO + BI3_VERSAO
cPlanoVerAnt := "XXXXXXXX"
cOpeOriAnt	:= "XXXX"
cCodLotAnt	:= "XXXXXXXXXXX"

lPrima := .T.


nCont := 0
While !TRB->(Eof())

	nCont++
	IncProc("Imprimindo linha "+StrZero(nCont,6)+" / "+StrZero(nTotReg,6))

	If nLin+2 > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)  
		nLin := 9
	Endif 	 
	
	If Substr(TRB->PLANOVERSAO,1,4) >= cProIni .And. Substr(TRB->PLANOVERSAO,1,4) <= cProFim

		//Imprimir totais
		If cCodLotAnt <> TRB->BED_CDIDEN			
			If !lPrima
				cString := "| TOTAL DO LOTE "+Alltrim(cCodLotAnt)+": "
				cString := cString+Space(62-Len(cString))+Transform(nTotLot,"@E 99,999")
				@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
				nLin++										
				cString := "|"+Space(34)+"---"
				@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
				nLin++				
			Endif
			
		Endif	
		If cOpeOriAnt <> TRB->BA1_OPEORI
			If !lPrima
				cString := "| TOTAL DA OPERADORA "+Alltrim(BA0->BA0_NOMINT)+": "
				cString := cString+Space(62-Len(cString))+Transform(nTotOpe,"@E 99,999")
				
				@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
				nLin++				
				@ nLin, 005 PSay Replicate("-",72)				
				nLin++
			Endif
						
		Endif
		If cPlanoVerAnt <> TRB->PLANOVERSAO			
			If !lPrima
				cString := "| TOTAL DO PLANO "+Alltrim(BI3->BI3_DESCRI)+": "
				cString := cString+Space(62-Len(cString))+Transform(nTotPla,"@E 99,999")
				@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
				nLin++				
				@ nLin, 005 PSay Replicate("-",72)				
				nLin += 2				
			Endif
			
		Endif				

		//Imprimir proximos subtitulos...
		If cPlanoVerAnt <> TRB->PLANOVERSAO			
			BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+TRB->PLANOVERSAO))			
			cPlanoVerAnt := TRB->PLANOVERSAO
			nTotPla := 0 
			@ nLin, 005 PSay Replicate("-",72)				
			nLin++
			cString := "| PLANO: "+Alltrim(BI3->BI3_DESCRI)
			@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
			nLin++			
		Endif								
		If cOpeOriAnt <> TRB->BA1_OPEORI
			BA0->(MsSeek(xFilial("BA0")+TRB->BA1_OPEORI))
			cOpeOriAnt := TRB->BA1_OPEORI
			nTotOpe := 0			
			cString := "| OPERADORA: "+Alltrim(BA0->BA0_NOMINT)
			@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
			nLin++						
		Endif		
		If cCodLotAnt <> TRB->BED_CDIDEN
			cString := "| LOTE NUMERO: "+Alltrim(TRB->BED_CDIDEN)+Iif(!Empty(TRB->BDE_EMPRES)," Empresa: "+Alltrim(TRB->BDE_EMPRES),"")
			@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
			cCodLotAnt := TRB->BED_CDIDEN
			nTotLot := 0
			nLin++			
		Endif	
		
		
		lPrima := .F.		
		
		//���������������������������������������������������������������������Ŀ
		//� Imprime linha detalhe do relatorio...                               �
		//�����������������������������������������������������������������������				
		cString := "| "+TRB->BED_MOTIVO+ " "+Alltrim(TRB->BPX_DESCRI)+" "
		cString := cString+Space(62-Len(cString))+Transform(TRB->TOTREG,"99,999")
		@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
		nTotPla += TRB->TOTREG
		nTotLot += TRB->TOTREG
		ntotOpe += TRB->TOTREG
		nTotGer	+= TRB->TOTREG
		nLin++    
		
	Endif
	
	TRB->(DbSkip()) 
	
Enddo


//���������������������������������������������������������������������Ŀ
//� Imprime totalizador da composicao do ultimo titulo...               �
//�����������������������������������������������������������������������			
TRB->(DbSkip(-1))
cString := "| TOTAL DO LOTE "+Alltrim(TRB->BED_CDIDEN)+": "
cString := cString+Space(62-Len(cString))+Transform(nTotLot,"@E 99,999")
@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
nLin++
cString := "|"+Space(34)+"---"
@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
nLin++
cString := "| TOTAL DA OPERADORA "+Alltrim(BA0->BA0_NOMINT)+": "
cString := cString+Space(62-Len(cString))+Transform(nTotOpe,"@E 99,999")
@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
nLin++        
@ nLin, 005 PSay Replicate("-",72)
nLin++
cString := "| TOTAL DO PLANO "+Alltrim(BI3->BI3_DESCRI)+": "
cString := cString+Space(62-Len(cString))+Transform(nTotPla,"@E 99,999")
@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
nLin++
@ nLin, 005 PSay Replicate("-",72)
nLin++
cString := "| TOTAL GERAL : "
cString := cString+Space(62-Len(cString))+Transform(nTotGer,"@E 99,999")
@ nLin, 005 PSay cString+Space(70-Len(cString))+" | "
nLin++                                                      
@ nLin, 005 PSay Replicate("-",72)
nLin++


TRB->(DbCloseArea())

nTotPla := 0
nTotLot := 0
ntotOpe := 0
nTotGer := 0

Return Nil


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � AjustaSX1�Autor  � Jean Schulz        � Data �  24/10/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ajusta os parametros                                       ���
���          �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AjustaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Produto De:")			,"","","mv_ch1","C",04,0,0,"G","","BI3PLS","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Produto Ate:")			,"","","mv_ch2","C",04,0,0,"G","","BI3PLS","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Data Entrega De:")		,"","","mv_ch3","D",08,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Data Entrega Ate:")	,"","","mv_ch4","D",08,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Empresa Impr. De:")	,"","","mv_ch5","C",06,0,0,"G","","ZY","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Empresa Impr. Ate:")	,"","","mv_ch6","C",06,0,0,"G","","ZY","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})

Pergunte(cPerg,.T.)

Return
