#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO6     º Autor ³ Marcela Coimbra    º Data ³  21/10/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório de conferência de baixas da Previ                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR120()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private oDlg
Private a_Vet 	:= { }
Private a_VetTit:= { "PREFIXO" , "NUMERO" , 'TIPO', 'E1_EMISSAO', 'BAIXA' ,  'MOTIVO' , 'HISTORICO', 'MATRICULA', 'VALOR TITULO', 'STATUS' , 'LOTE DE COBRANCA'}
Private c_Perg 	:= "CABR120B"


Define FONT oFont1 	NAME "Arial" SIZE 0,20 //OF oDlg Bold
Define FONT oFont2 	NAME "Arial" SIZE 0,15 //OF oDlg Bold


ValidPerg()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DEFINE MSDIALOG oDlg TITLE "Leitura de Arquivo Texto" FROM 200,1 TO 380,380 PIXEL
//@ 02,010 TO 080,190
@ 25,010 Say " Este programa ira ler o conteudo do arquivo de Previ, e relacionar "      Size 200,012 FONT oFont2  PIXEL OF oDlg 
@ 35,010 Say " eventuais problemas de baixa."   Size 200,012 FONT oFont2  PIXEL OF oDlg

@ 70,098 BMPBUTTON TYPE 05 ACTION Pergunte( c_Perg )
@ 70,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close( oDlg )

ACTIVATE MSDIALOG oDlg CENTERED


Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ OKLETXT  º Autor ³ AP6 IDE            º Data ³  21/10/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao chamada pelo botao OK na tela inicial de processamenº±±
±±º          ³ to. Executa a leitura do arquivo texto.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function OkLeTxt

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abertura do arquivo texto                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cArqTxt := MV_PAR01
Private nHdl    := fOpen(cArqTxt,68)      
Private d_DataBx := MV_PAR02

Private cEOL    := "CHR(13)+CHR(10)"                

Pergunte( c_Perg , .F.)

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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a regua de processamento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Processa({|| RunCont() },"Processando...")
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ RUNCONT  º Autor ³ AP5 IDE            º Data ³  21/10/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunCont

Local nTamFile, nTamLin, cBuffer, nBtLidos

Private c_Baixa := " "  
Private c_Motivo:= " "
Private c_Hist  := " "

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º Lay-Out do arquivo Texto gerado:                                º
//ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
//ºCampo           ³ Inicio ³ Tamanho                               º
//ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
//º ??_FILIAL     ³ 01     ³ 02                                    º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

nTamFile := fSeek(nHdl,0,2)

fSeek(nHdl,0,0)

nTamLin  := 150+Len(cEOL)
cBuffer  := Space(nTamLin) // Variavel para criacao da linha do registro para leitura

nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da primeira linha do arquivo texto

ProcRegua(nTamFile) // Numero de registros a processar
n_Tot := 0
n_TotaRQ := 0
	c_Ano 	 := '20' + MV_PAR03
	c_Mes	 := MV_PAR04


While nBtLidos >= nTamLin

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Incrementa a regua                                                  ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    IncProc()
	
	c_CodInt := Substr(cBuffer,135,004)
	c_CodEmp := Substr(cBuffer,139,004)
	c_Matric := Substr(cBuffer,143,006)  
	c_Tipo 	 := Substr(cBuffer,106,001)  
	n_Val 	 := val(Substr(cBuffer,075,010)  )  * 0.01
	
	If  c_CodInt + c_CodEmp + c_Matric ==  '00010002043560' 
	
	cSTop := .t.
	
	EndIf
	
	If c_Tipo =='0'
	n_TotaRQ += n_Val
		dbSelectArea("SE1")
		dbSetOrder(14)		
		If dbSeek(xFilial("SE1") + c_CodInt + c_CodEmp + c_Matric + c_Ano + c_Mes)       

			c_Baixa := " "  
			c_Motivo:= " "
			c_Hist  := " "

			u_VerDtBaixa( SE1->E1_PREFIXO, SE1->E1_NUM , STR( n_Val, TamSX3("E5_VALOR ")[1], TamSX3("E5_VALOR ")[2] ), @c_Baixa, @c_Motivo, @c_Hist )
			                        
			If SE1->E1_TIPO = 'DP'
			
				If SE1->E1_SALDO ==  SE1->E1_VALOR 
						    
				    	aadd( a_Vet , { SE1->E1_PREFIXO , "'" + SE1->E1_NUM , SE1->E1_TIPO, SE1->E1_EMISSAO, SE1->E1_BAIXA  , c_Motivo , c_Hist, "'" + SE1->( E1_CODINT + E1_CODEMP + E1_MATRIC ) , n_Val, 'NÃO BAIXADO',  "'" + SE1->E1_PLNUCOB } )
		        
				ElseIf !Empty( c_Baixa ) .and. stod( c_Baixa ) != d_DataBx  
							
					aAreaSe1 := GetArea("SE1")  
					l_E := .T.

					While xFilial("SE1") + c_CodInt + c_CodEmp + c_Matric + c_Ano + c_Mes == se1->( E1_FILIAL + E1_CODINT + E1_CODEMP + E1_MATRIC + E1_ANOBASE + E1_MESBASE )
					
					    If SE1->E1_BAIXA == d_DataBx
	
						 	l_E := .F.	
						
						EndIf
	
						se1->( dbskip() ) 
						
				    EndDo    
				    
				    	If l_E
				    	aadd( a_Vet , { SE1->E1_PREFIXO , "'" + SE1->E1_NUM , SE1->E1_TIPO, SE1->E1_EMISSAO, stod( c_Baixa ),  c_Motivo , c_Hist,"'" + SE1->( E1_CODINT + E1_CODEMP + E1_MATRIC ) , n_Val,  'OUTRA DATA',  "'" + SE1->E1_PLNUCOB } )
				    	EndIf
				
			    EndIf
			    
			EndIf
					    
		EndIf

	EndIf
	
    nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da proxima linha do arquivo texto
    
EndDo   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ O arquivo texto deve ser fechado, bem como o dialogo criado na fun- ³
//³ cao anterior.                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DlgToExcel({{"ARRAY","Relação de Diferença de baixas da Previ" ,a_VetTit , a_Vet}})
//DlgToExcel({{"CABECALHO","Relação de Diferença de baixas da Previ" ,a_VetTit , a_Vet}, ;
//{"ARRAY","Relação de Diferença de baixas da Previ" ,a_VetTit , a_Vet}})
		
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

aHelp := {}
aAdd(aHelp, "Ano Competencia")         
PutSX1(c_Perg , "03" , "Ano Competencia" 		,"","","mv_ch3","C",02							,0,0,"G",""	,""			,"","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Mes Competencia")         
PutSX1(c_Perg , "04" , "Mes Competencia" 		,"","","mv_ch4","C",02							,0,0,"G",""	,""			,"","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)


Return


User Function VerDtBaixa( c_Prefixo, c_Num , c_Valor, c_Baixa, c_Motivo, c_Hist)

Local c_Query := " "   

c_Query += " SELECT E5_DTDISPO, E5_HISTOR, E5_MOTBX "
c_Query += " FROM " + RETSQLNAME("SE5") + " "
c_Query += " WHERE E5_FILIAL = '" + xFilial("SE5")  + "' "
c_Query += "       AND E5_PREFIXO = '"  + c_Prefixo + "' "
c_Query += "       AND E5_NUMERO  = '"  + c_Num     + "' "
c_Query += "       AND E5_VALOR   =  "  + c_Valor   + "  "
c_Query += " ORDER BY E5_SEQ DESC "     

TcQuery c_Query New Alias "QRYSE5"

If !QRYSE5->( QRYSE5->( EOF() ) )
     
	QRYSE5->( dbGoTop() )        
	
	c_Baixa 	:= QRYSE5->E5_DTDISPO                                
	c_Motivo	:= QRYSE5->E5_MOTBX
	c_Hist		:= QRYSE5->E5_HISTOR
	
Else

	QRYSE5->( dbCloseArea() ) 
	
	c_Query := " SELECT E5_DTDISPO, E5_HISTOR, E5_MOTBX "
	c_Query += " FROM " + RETSQLNAME("SE5") + " "
	c_Query += " WHERE E5_FILIAL = '" + xFilial("SE5")  + "' "
	c_Query += "       AND E5_PREFIXO = '"  + c_Prefixo + "' "
	c_Query += "       AND E5_NUMERO  = '"  + c_Num     + "' "
	c_Query += " ORDER BY E5_SEQ DESC "     
	
	TcQuery c_Query New Alias "QRYSE5"    
	
	
	If !QRYSE5->( QRYSE5->( EOF() ) )
	     
		QRYSE5->( dbGoTop() )        
		
		c_Baixa 	:= QRYSE5->E5_DTDISPO                                
		c_Motivo	:= QRYSE5->E5_MOTBX
		c_Hist		:= QRYSE5->E5_HISTOR  
	
	EndIf
		
EndIf

QRYSE5->( dbCloseArea() ) 

Return c_Baixa
