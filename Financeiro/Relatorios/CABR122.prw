#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO6     � Autor � Marcela Coimbra     � Data �  29/02/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Rela��o de baixas por CNAB                                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CABR122()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Private oDlg
Private a_Vet := {}
Private a_VetTit := {}
Private c_Perg := 'CABR122A' 

Define FONT oFont1 	NAME "Arial" SIZE 0,20 //OF oDlg Bold
Define FONT oFont2 	NAME "Arial" SIZE 0,15 //OF oDlg Bold



//���������������������������������������������������������������������Ŀ
//� Montagem da tela de processamento.                                  �
//�����������������������������������������������������������������������

ValidPerg()   
/*
DEFINE MSDIALOG oDlg TITLE "Leitura de Arquivo Texto" FROM 000,000 TO 150,320 PIXEL
//@ 010,009 Say "Tabela" Size 059,008 COLOR CLR_BLACK PIXEL OF oDlg   //007
//@ 018,009 ComboBox cComboBx1 Items aComboBx1 Size 121,010 PIXEL OF oDlg  //015
@ 018,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg  //015
@ 033,009 Say   "Diretorio"       Size 045,008 PIXEL OF oDlg   //030   008
@ 041,009 MSGET c_dirimp          Size 120,010 WHEN .F. PIXEL OF oDlg  //038

*-----------------------------------------------------------------------------------------------------------------*
*Buscar o arquivo no diretorio desejado.                                                                          *
*Comando para selecionar um arquivo.                                                                              *
*Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                       *
*           GETF_LOCALHARD   - Inclui o Harddisk local.                                                           *
*-----------------------------------------------------------------------------------------------------------------*
@ 041,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("*.csv|*.csv","Importacao de Dados",0, ,.T.,GETF_LOCALHARD))

*-----------------------------------------------------------------------------------------------------------------*
@ 60,009 Button "OK"       Size 037,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 60,060 Button "Cancelar" Size 037,012 PIXEL OF oDlg Action oDlg:end()

ACTIVATE MSDIALOG oDlg CENTERED

*/

DEFINE MSDIALOG oDlg TITLE "Leitura de Arquivo Texto" FROM 200,1 TO 380,380 PIXEL
//@ 02,010 TO 080,190
@ 25,010 Say " Este programa ira ler o conteudo do arquivo de CNAB, e relacionar "      Size 200,012 FONT oFont2  PIXEL OF oDlg 
@ 35,010 Say " eventuais problemas de baixa."   Size 200,012 FONT oFont2  PIXEL OF oDlg

@ 70,098 BMPBUTTON TYPE 05 ACTION Pergunte( c_Perg )
@ 70,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close( oDlg )

ACTIVATE MSDIALOG oDlg CENTERED


Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � OKLETXT  � Autor � AP6 IDE            � Data �  21/10/11   ���
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

//���������������������������������������������������������������������Ŀ
//� Abertura do arquivo texto                                           �
//�����������������������������������������������������������������������

Private cArqTxt := MV_PAR01
Private nHdl    := fOpen(cArqTxt,68)      
Private d_DataBx := MV_PAR02

Private cEOL    := "CHR(13)+CHR(10)"
If Empty(cEOL)
    cEOL := CHR(13)+CHR(10)
Else
    cEOL := Trim(cEOL)
    cEOL := &cEOL
Endif

If nHdl == -1
    MsgAlert("O arquivo de nome "+cArqTxt+" nao pode ser aberto! Verifique os parametros.","Atencao!")
    Return
Endif

//���������������������������������������������������������������������Ŀ
//� Inicializa a regua de processamento                                 �
//�����������������������������������������������������������������������

Processa({|| RunCont() },"Processando...")
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � RUNCONT  � Autor � AP5 IDE            � Data �  21/10/11   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunCont

Local nTamFile, nTamLin, cBuffer, nBtLidos

//�����������������������������������������������������������������ͻ
//� Lay-Out do arquivo Texto gerado:                                �
//�����������������������������������������������������������������͹
//�Campo           � Inicio � Tamanho                               �
//�����������������������������������������������������������������Ķ
//� ??_FILIAL     � 01     � 02                                    �
//�����������������������������������������������������������������ͼ

nTamFile := fSeek(nHdl,0,2)
fSeek(nHdl,0,0)
nTamLin  := 400+Len(cEOL)
cBuffer  := Space(nTamLin) // Variavel para criacao da linha do registro para leitura

nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da primeira linha do arquivo texto

ProcRegua(nTamFile) // Numero de registros a processar

While nBtLidos >= nTamLin

    //���������������������������������������������������������������������Ŀ
    //� Incrementa a regua                                                  �
    //�����������������������������������������������������������������������

    IncProc()
	
	c_PreFix := Substr(cBuffer,038,003)
	c_NumTit := Substr(cBuffer,041,009)
	c_NumCob := Substr(cBuffer,063,008)
	c_TipOpe := Substr(cBuffer,110,001)

	c_ValTit := Substr(cBuffer,153,013)
	n_ValTit := val( c_ValTit ) * 0.01  
	
	If c_TipOpe <> '6'
	     
		nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da proxima linha do arquivo texto
		
		Loop	
	
	EndIf
	
	If !Empty( c_PreFix )
	     
		dbSelectArea("SE1")
		dbSetOrder(1)
		
		If dbSeek(xFilial("SE1") + c_PreFix + c_NumTit )       
		
			c_Baixa := " "  
			c_Motivo:= " "
			c_Hist  := " "

			u_VerDtBaixa( SE1->E1_PREFIXO, SE1->E1_NUM , STR( n_ValTit, TamSX3("E5_VALOR ")[1], TamSX3("E5_VALOR ")[2] ), @c_Baixa, @c_Motivo, @c_Hist )

		
			dbSelectArea("BM1")
			dbSetOrder(4)            
			//BM1_FILIAL + BM1_PREFIX + BM1_NUMTIT + BM1_PARCEL + BM1_TIPTIT + BM1_CODINT + BM1_CODEMP + BM1_MATRIC + BM1_TIPREG + BM1_CODTIP                                 
			If dbSeek( xFilial("BM1") +  SE1->E1_PREFIXO + SE1->E1_NUM )
		    
		    	aadd( a_Vet , { SE1->E1_PREFIXO , "'" + SE1->E1_NUM , SE1->E1_TIPO, SE1->E1_EMISSAO,  stod( c_Baixa ), c_Motivo, c_Hist, SE1->E1_VALOR, n_ValTit, 'SIM', SE1->E1_PLNUCOB } )
		     
		    Else 

		    	aadd( a_Vet , { SE1->E1_PREFIXO , "'" + SE1->E1_NUM , SE1->E1_TIPO, SE1->E1_EMISSAO,  stod( c_Baixa ), c_Motivo, c_Hist , SE1->E1_VALOR, n_ValTit, 'NAO', SE1->E1_PLNUCOB } )
		    
		    EndIf
		
		Else

		     aadd( a_Vet , { c_PreFix , c_NumTit , 'T�TULO N�O ENCONTRADO NO SISTEMA' } )
		
		EndIf
	
	Else
	
		dbSelectArea("SE1")
		dbSetOrder(20)
		
		If dbSeek(xFilial("SE1") + c_NumCob )    

			c_Baixa := " "  
			c_Motivo:= " "
			c_Hist  := " "

			u_VerDtBaixa( SE1->E1_PREFIXO, SE1->E1_NUM , STR( n_ValTit, TamSX3("E5_VALOR ")[1], TamSX3("E5_VALOR ")[2] ), @c_Baixa, @c_Motivo, @c_Hist )

			dbSelectArea("BM1")
			dbSetOrder(4)            
			//BM1_FILIAL + BM1_PREFIX + BM1_NUMTIT + BM1_PARCEL + BM1_TIPTIT + BM1_CODINT + BM1_CODEMP + BM1_MATRIC + BM1_TIPREG + BM1_CODTIP                                 
			If dbSeek( xFilial("BM1") +  SE1->E1_PREFIXO + SE1->E1_NUM )
		    
		    	aadd( a_Vet , { SE1->E1_PREFIXO , "'" + SE1->E1_NUM , SE1->E1_TIPO, SE1->E1_EMISSAO, stod( c_Baixa ), c_Motivo, c_Hist, SE1->E1_VALOR, n_ValTit, 'SIM', SE1->E1_PLNUCOB } )
		     
		    Else 

		    	aadd( a_Vet , { SE1->E1_PREFIXO , "'" + SE1->E1_NUM , SE1->E1_TIPO, SE1->E1_EMISSAO, stod( c_Baixa ), c_Motivo, c_Hist, SE1->E1_VALOR, n_ValTit, 'NAO', SE1->E1_PLNUCOB } )
		    
		    EndIf		
		Else

		     aadd( a_Vet , { ' ' , c_NumCob , 'NUMERO DE COBRAN�A N�O ENCONTRADO NO SISTEMA',,,,n_ValTit } )
		
		EndIf
		
	
	EndIf

    nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da proxima linha do arquivo texto
    
EndDo   

a_VetTit := { "PREFIXO" , "NUMERO" , 'TIPO', 'EMISSAO', 'BAIXA' , 'MOTIVO', 'HISTORICO', 'VALOR TITULO', 'VALOR BANCO', 'ESTA NO PLS ? ' , 'COBRANCA'} 
//a_VetTit:= { "PREFIXO" , "NUMERO" , 'TIPO', 'E1_EMISSAO', 'BAIXA' ,  'MOTIVO' , 'HISTORICO', 'MATRICULA', 'VALOR TITULO', 'STATUS' , 'LOTE DE COBRANCA'}
//���������������������������������������������������������������������Ŀ
//� O arquivo texto deve ser fechado, bem como o dialogo criado na fun- �
//� cao anterior.                                                       �
//�����������������������������������������������������������������������

DlgToExcel({{"ARRAY","Lista movimenta��o de CNAB do dia " + dtoc(MV_PAR02) + "." ,a_VetTit , a_Vet}})
		
fClose(nHdl)
Close(oDlg)

Return

Static Function ValidPerg()                                                                           
      
aHelp := {}
aAdd(aHelp, "Informe o caminho do arquivo")         
PutSX1(c_Perg , "01" , "Caminho do arquivo: " 	,"","","mv_ch1","C",80							,0,0,"G",""	,"DIR"			,"","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Data da disponibilizacao.")         
PutSX1(c_Perg , "02" , "Data Dispo." 		    ,"","","mv_ch2","D",08							,0,0,"G",""	,""			,"","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

Return
