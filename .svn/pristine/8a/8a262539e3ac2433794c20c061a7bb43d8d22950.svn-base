#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO6     บ Autor ณ Marcela Coimbra     บ Data ณ  29/02/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rela็ใo de baixas por CNAB                                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABR122()


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Private oDlg
Private a_Vet := {}
Private a_VetTit := {}
Private c_Perg := 'CABR122A' 

Define FONT oFont1 	NAME "Arial" SIZE 0,20 //OF oDlg Bold
Define FONT oFont2 	NAME "Arial" SIZE 0,15 //OF oDlg Bold



//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Montagem da tela de processamento.                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKLETXT  บ Autor ณ AP6 IDE            บ Data ณ  21/10/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a leitura do arquivo texto.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function OkLeTxt

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Abertura do arquivo texto                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

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

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Inicializa a regua de processamento                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Processa({|| RunCont() },"Processando...")
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ RUNCONT  บ Autor ณ AP5 IDE            บ Data ณ  21/10/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunCont

Local nTamFile, nTamLin, cBuffer, nBtLidos

//ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
//บ Lay-Out do arquivo Texto gerado:                                บ
//ฬออออออออออออออออัออออออออัอออออออออออออออออออออออออออออออออออออออน
//บCampo           ณ Inicio ณ Tamanho                               บ
//วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
//บ ??_FILIAL     ณ 01     ณ 02                                    บ
//ศออออออออออออออออฯออออออออฯอออออออออออออออออออออออออออออออออออออออผ

nTamFile := fSeek(nHdl,0,2)
fSeek(nHdl,0,0)
nTamLin  := 400+Len(cEOL)
cBuffer  := Space(nTamLin) // Variavel para criacao da linha do registro para leitura

nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da primeira linha do arquivo texto

ProcRegua(nTamFile) // Numero de registros a processar

While nBtLidos >= nTamLin

    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
    //ณ Incrementa a regua                                                  ณ
    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

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

		     aadd( a_Vet , { c_PreFix , c_NumTit , 'TอTULO NรO ENCONTRADO NO SISTEMA' } )
		
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

		     aadd( a_Vet , { ' ' , c_NumCob , 'NUMERO DE COBRANวA NรO ENCONTRADO NO SISTEMA',,,,n_ValTit } )
		
		EndIf
		
	
	EndIf

    nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da proxima linha do arquivo texto
    
EndDo   

a_VetTit := { "PREFIXO" , "NUMERO" , 'TIPO', 'EMISSAO', 'BAIXA' , 'MOTIVO', 'HISTORICO', 'VALOR TITULO', 'VALOR BANCO', 'ESTA NO PLS ? ' , 'COBRANCA'} 
//a_VetTit:= { "PREFIXO" , "NUMERO" , 'TIPO', 'E1_EMISSAO', 'BAIXA' ,  'MOTIVO' , 'HISTORICO', 'MATRICULA', 'VALOR TITULO', 'STATUS' , 'LOTE DE COBRANCA'}
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ O arquivo texto deve ser fechado, bem como o dialogo criado na fun- ณ
//ณ cao anterior.                                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

DlgToExcel({{"ARRAY","Lista movimenta็ใo de CNAB do dia " + dtoc(MV_PAR02) + "." ,a_VetTit , a_Vet}})
		
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
