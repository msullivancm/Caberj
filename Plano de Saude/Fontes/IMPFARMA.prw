#Include "rwmake.ch"
#Include "plsmger.ch"
#Include "plsmlib.ch"
#Include "colors.ch"
#Include "topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
���������������������������������������������	����������������������������ͻ��
���Programa  � IMPFARMA � Autor � Jean Schulz          � Data � 11/11/06  ���
�������������������������������������������������������������������������͹��
���Descricao � Rotina para importacao e lancamento de debitos para        ���
���          � usuarios, conforme arquivo retorno do convenio farmacia.   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function impfarma

Private oLeTxt
Private lAbortPrint :=.F.

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
PRIVATE cNomeProg   := "IMPFARMA"
PRIVATE cPerg       := "IMPFAR"
PRIVATE nQtdLin     := 68
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cAlias      := "BA1"
PRIVATE cTamanho    := "M"
PRIVATE cTitulo     := "Importa retorno Farm�cia"
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
PRIVATE cCabec1     := "Anal�tico / Importa��o arquivo retorno Farm�cia"
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0


@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Leitura de Arquivo Texto")
@ 02,10 TO 65,180
@ 10,018 Say " Este programa ira fazer a leitura do arquivo texto relativo ao"
@ 18,018 Say " retorno do conv�nio Farm�cia, gerando adicionais de d�bito    "
@ 26,018 Say " aos usu�rios relacionados no arquivo.                         "
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
PRIVATE cMesAdi		:= ""
PRIVATE cAnoAdi		:= ""
PRIVATE aErro		:= {}
PRIVATE aOk			:= {}

Pergunte(cPerg,.F.) 

cNomeArq	:= mv_par01
cMesAdi		:= mv_par02
cAnoAdi		:= mv_par03

If !File(cNomeArq) 
	MsgStop("Arquivo Inv�lido! Programa encerrado.")
	Close(oLeTxt)
	Return
End       

//���������������������������������������������������������������������Ŀ
//� Criacao do arquivo temporario...                                    �
//�����������������������������������������������������������������������
If Select("TRB") <> 0
	TRB->(dbCloseArea())
End

aStruc := {	{"CAMPO","C", 60,0}}
//mbc aStruc := {	{"CAMPO","C", 58,0}}
cTRB := CriaTrab(aStruc,.T.)
DbUseArea(.T.,,cTRB,"TRB",.T.)

DbSelectArea("TRB")
    
cCabec2 := "Arquivo: "+AllTrim(cNomeArq) 
WnRel   := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Return
Endif              

//��������������������������������������������������������������������������Ŀ
//� Seleciona tabelas...                                                     �
//����������������������������������������������������������������������������
BA1->(DbSetOrder(2))
BF4->(DbSetOrder(1))
BSQ->(DbSetOrder(6))

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
���Fun��o    � PROCESSA1� Autor � Jean Schulz        � Data �  11/11/06   ���
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

Local aStruc  := {}
Local nLinha  := 0
Local cTipReg := ""

Local aHeader   := {}
Local aTrailler := {}

Private cTrbPos

//Cria estrutura em area de trabalho para importar arquivo
aAdd(aStruc,{"CAMPO","C",60,0})
//mbc aAdd(aStruc,{"CAMPO","C",58,0})

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

nLin := 1

Begin Transaction

While !TRBPOS->(Eof())
	
	nLinha++    
	IncProc("Processando Linha ... " + strzero(nLinha,6))
	
	cTipReg := Substr(TRBPOS->(CAMPO),1,2)
	
	Do Case		
		Case cTipReg == "01"
		
			//���������������������������������������������������������������������Ŀ
			//� Criacao do arquivo temporario...                                    �
			//�����������������������������������������������������������������������		
			If Alltrim(Substr(TRBPOS->(CAMPO),5,34))<>"CABERJ"                     
				MsgStop("Empresa contida no registro HEADER incorreta! Opera��o abortada!")
				TRBPOS->(DBCLoseArea())
				Close(oLeTxt)
				lRet := .F.
				Return				
			Endif     			
			aHeader := LeHeader(TRBPOS->(CAMPO))
			
		Case cTipReg == "03"
			LeTrailler(TRBPOS->(CAMPO),@aTrailler)
			
		OtherWise
			LeDetalhe(TRBPOS->(CAMPO))
			
	EndCase
	
	TRBPOS->(DBSkip())
Enddo

End Transaction

Impr_Rel(aHeader,aTrailler)

Return 



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �Impr_Rel  � Autor � Jean Schulz        � Data �  24/10/05   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao para imprimir os dados analizados do relatorio.     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function Impr_Rel(aHeader,aTrailler)

Local nLin := 80
Local nImp := 1

//��������������������������������������������������������������������������Ŀ
//� Imprime cabecalho...                                                     �
//����������������������������������������������������������������������������
For nImp := 1 to Len(aHeader)

	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)  
		nLin := 9
	Endif 
	
	@ nLin, 000 PSay aHeader[nImp,1]+aHeader[nImp,2]
	nLin++
Next

@ nLin, 000 PSay replicate("-",132)
nLin++    
        
nLin := 80

//��������������������������������������������������������������������������Ŀ
//� Imprime titulos, com valores de mensalidade e coparticipacao.    		 �
//����������������������������������������������������������������������������
cCabec2     := "Cod. Usuario            Nome Usu�rio                   Vlr. Desconto"
For nImp := 1 to Len(aOk)

	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)  
		nLin := 9
	Endif 
	
	@ nLin, 000 PSay aOk[nImp,1]+Space(2)+aOk[nImp,2]+Space(2)+aOk[nImp,3]
	nLin++	

Next

@ nLin,   000 PSay replicate("-",132)
nLin := 80


//��������������������������������������������������������������������������Ŀ
//� Imprime relatorio de adicionais de debito criados pela imp. convenio...  �
//����������������������������������������������������������������������������
cCabec2     := "Totalizador / Trailler do Arquivo"
For nImp := 1 to Len(aTrailler)

	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)  
		nLin := 9
	Endif 
	
	@ nLin, 000 PSay aTrailler[nImp,1]+Space(2)+Iif(aTrailler[nImp,3],Transform(aTrailler[nImp,2],"@E 999,999,999.99"),"")
	nLin++
	
Next
nLin := 80

cCabec2     := "Erros encontrados na importa��o"
For nImp := 1 to Len(aErro)

	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,cControle)  
		nLin := 9
	Endif 
	
	@ nLin, 000 PSay aErro[nImp,1]
	nLin++
	
Next

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

PutSx1(cPerg,"01",OemToAnsi("Arquivo Retorno ")				,"","","mv_ch1","C",60,0,0,"G","U_fGetFile('Txt     (*.Txt)            | *.Txt | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Mes Lancto Adicionais") 		,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("Ano Lancto Adicionais") 		,"","","mv_ch3","C",04,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �LeDetalhe  �Autor  � Jean Schulz       � Data �  11/11/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Le registros do tipo Detalhe no arq. retorno Farmacia.     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LeDetalhe(cString)
Local cNumFarm	:= Substr(cString,009,008)
Local cNumAssoc	:= Substr(cString,017,011)
Local nVlDesc	:= Val(Substr(cString,030,012)) //mbc 28
Local cMatSiga	:= Substr(cString,042,017)//mbc 40
Local lFarma	:= .F.
Local lGravou	:= .F.
Local lRepete	:= .F.
Local aNivCob	:= {}
Local aDadosPar := {}
Local aDadosUsr := {}

If BA1->(MsSeek(xFilial("BA1")+cMatSiga))

	aNivCob := U_RetNivCob(cMatSiga)
	
	If Len(aNivCob) > 0
	
		aadd(aDadosPar,{cAnoAdi+cMesAdi,nVlDesc,cMesAdi+"/"+cAnoAdi,GetNewPar("MV_YLANFAR","998"),"","","LANCTO AUTOMATICO FARMACIA"})
		
		aadd(aDadosUsr,BA1->BA1_CODINT)
		aadd(aDadosUsr,BA1->BA1_CODEMP)
		aadd(aDadosUsr,BA1->BA1_MATRIC)
		aadd(aDadosUsr,BA1->BA1_CONEMP)
		aadd(aDadosUsr,BA1->BA1_VERCON)	
		aadd(aDadosUsr,BA1->BA1_SUBCON)	
		aadd(aDadosUsr,BA1->BA1_VERSUB)	
		aadd(aDadosUsr,aNivCob[1,1])
		aadd(aDadosUsr,BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO))	
		
		If BF4->(MsSeek(xFilial("BF4")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)))
		
			While !BF4->(Eof()) .And. (BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG)==BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))
				If BF4->BF4_CLAOPC == "N" //Farmacia...
					lFarma	:= .T.
					BF4->(RecLock("BF4",.F.))
					BF4->BF4_YMATRI = cNumFarm
					BF4->(MsUnlock())
					Exit
				Endif
				BF4->(DbSkip())
			Enddo
			
			If lFarma
			    
				//��������������������������������������������������������������������������Ŀ
				//� Valida se ja existe adicional para o usuario, do mesmo tipo para o mes...�
				//����������������������������������������������������������������������������		

				**'Marcela Coimbra - Defini��o de indice para consulta na BSQ 04/06/2013'**                        
//				If BSQ->(MsSeek(xFilial("BSQ")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON)+cAnoAdi+cMesAdi))
		
				dbSelectArea("BSQ")
  				dbSetOrder(2)//	BSQ_FILIAL + BSQ_USUARI + BSQ_CONEMP + BSQ_VERCON + BSQ_SUBCON + BSQ_VERSUB + BSQ_ANO + BSQ_MES + BSQ_CODLAN + BSQ_TIPO                                         		
				If BSQ->(MsSeek(xFilial("BSQ")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+cAnoAdi+cMesAdi))
				
					While !BSQ->(Eof()) .And. 	BSQ->(BSQ_USUARI + BSQ_CONEMP + BSQ_VERCON + BSQ_SUBCON + BSQ_VERSUB + BSQ_ANO + BSQ_MES)==;
												BA1->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO + BA1_CONEMP + BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+cAnoAdi+cMesAdi
//					While !BSQ->(Eof()) .And. BSQ->(BSQ_CODINT+BSQ_CODEMP+BSQ_CONEMP+BSQ_VERCON+BSQ_ANO+BSQ_MES)==BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON)+cAnoAdi+cMesAdi
						If BSQ->BSQ_MATRIC == BA1->BA1_MATRIC  .And. BSQ->BSQ_CODLAN == GetNewPar("MV_YLANFAR","998")
							lRepete := .T.
						Endif
						BSQ->(DbSkip())				
				    Enddo
				    
				Endif
				
				If !lRepete
				
					lGravou := U_GerAdNeg(aDadosPar,aDadosUsr,"")
					
					If !lGravou       
						aadd(aErro,{"N�o foi poss�vel gerar o adicional para o m�s solicitado! Usu�rio: "+cMatSiga})
					Else
						aadd(aOk,{BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO,Substr(BA1->BA1_NOMUSR,1,30),Transform(nVlDesc,"@E 999,999,999.99")})			
					Endif			
				Else
					aadd(aErro,{"J� existe adicional gravado nestes par�metros no m�s solicitado! Usu�rio: "+cMatSiga})	
				Endif
				
			Endif
	
		Endif
		
		If !lFarma
			aadd(aErro,{"Usu�rio n�o possui o opcional Farm�cia! "+cMatSiga})	
		Endif			
	Else
		aadd(aErro,{"N�o foi encontrado n�vel de cobran�a para o usu�rio "+cMatSiga})	
	Endif       

Else
	aadd(aErro,{"Matr�cula n�o encontrada! Imposs�vel gerar adicional de d�bito! "+cMatSiga})
Endif

Return Nil

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �LeHeader    � Autor � Jean Schulz      � Data �  11/11/06   ���
�������������������������������������������������������������������������͹��
���Descri��o � Le cabecalho do arquivo de retorno farmacia.               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function LeHeader(cString)

Local aHeader := {}
Local cEmpres := Substr(cString,005,030)
Local cMesAno := Substr(cString,035,006)
Local cDtGer  := Substr(cString,041,008)

cDtGer := Substr(cDtGer,1,2)+"/"+Substr(cDtGer,3,2)+"/"+Substr(cDtGer,5,4)

Aadd(aHeader,{"INFORMACOES DO CABECALHO",""})
Aadd(aHeader,{"------------------------",""})
Aadd(aHeader,{"Empresa:        ",cEmpres})
Aadd(aHeader,{"Mes/Ano:        ",cMesAno})
Aadd(aHeader,{"Data Ger. Arq.: ",cDtGer})

Return aHeader

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �LeTrailler  � Autor � Jean Schulz      � Data �  11/11/06   ���
�������������������������������������������������������������������������͹��
���Descri��o � Le final de arquivo.                                       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Static Function LeTrailler(cString,aResult)

Aadd(aResult,{"Qtd. total de registros: ",(Val(Substr(cString,03,05))),.T.})
Aadd(aResult,{"Vlr. total no arquivo  : ",(Val(Substr(cString,08,14))),.T.})

Return Nil



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
