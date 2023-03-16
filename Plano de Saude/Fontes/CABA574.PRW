#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA574   ºAutor  ³Motta               º Data ³  nov/15     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  IMPORTADOR DE REDE DENTAL PRIMAVIDA                       º±±
±±º          ³  (PROCEDURE ORACLE SIGA.IMPORTA_REDE_PRIMAVIDA)            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                          

******************************************************************************************************

Static cPath	:= "\\srvdbp\backup\utl\" //Onde a Procedure le o arquivo de carga   

******************************************************************************************************

User Function CABA574()



Local lSchedule := .F.   
Private cPerg       := "CABA574"

AjustaSX1(cPerg)

If !Pergunte(cPerg,.T.)
	Return
EndIf

Processa({||execCarga(lSchedule)},'Processando...')

Return               


*************************************************************************************************************************

Static Function execCarga(lSchedule)

Local i := 0
   
If !lSchedule
	ProcRegua(0)
	
	For i:= 1 to 5                                 
		Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando CargaRedeDental...')
	Next
	
	exCarDental()
EndIf

***********************************************************************************************************************

Static Function exCarDental()
	
Local cErro 	:= ''
Local lOk		:= .T.
Local cQuery 	:= ''   
Local cDirLog   := ' ' 
Local cArq1     := ' '
Local cArq2     := ' '
Local cArq3     := ' ' 
Local cArqLog   := ' ' 
Local cArqExp   := ' '
Static cPath	:= "\\srvdbp\backup\utl\"  

//obter o nome do aqruivo sem o diretorio
cArq1 := Substr(mv_par01,(Rat("\",mv_par01)+1),Length(mv_par01) - (Rat("/",mv_par01)-2))
cArq2 := Substr(mv_par02,(Rat("\",mv_par02)+1),Length(mv_par02) - (Rat("/",mv_par02)-2))
cArq3 := Substr(mv_par03,(Rat("\",mv_par03)+1),Length(mv_par03) - (Rat("/",mv_par03)-2)) 
//monta nome padrao arquivo de log , sera copiado para a mesma pasta raiz do mv_par01  
cDirLog  := Substr(mv_par01,1,Rat("\",mv_par01))
cArqLog  := "\\srvdbp\backup\utl\"+"log_import_primavida_"+DtoS(DDatabase)+".txt"  
cArqExp  := cDirLog+"log_import_primavida_"+DtoS(DDatabase)+".txt"

//Testa existencia dos arquivos e copia
If !File(mv_par01)
    MsgStop("Arquivo [ " + mv_par01 + " ] não localizado",AllTrim(SM0->M0_NOMECOM))   
Else
    If !MoveFile(mv_par01,cPath+cArq1,.F.)
  	  Alert("Erro na copia do arquivo " + mv_par01 + "  !! ")   
    EndIf    
EndIf
If !File(mv_par02)
    MsgStop("Arquivo [ " + mv_par02 + " ] não localizado",AllTrim(SM0->M0_NOMECOM))  
Else
    If !MoveFile(mv_par02,cPath+cArq2,.F.)
  	  Alert("Erro na copia do arquivo " + mv_par02 + "  !! ")  
    EndIf      
EndIf
If !File(mv_par03)
    MsgStop("Arquivo [ " + mv_par03 + " ] não localizado",AllTrim(SM0->M0_NOMECOM))   
Else
    If !MoveFile(mv_par03,cPath+cArq3,.F.)
  	  Alert("Erro na copia do arquivo " + mv_par03 + "  !! ")    
    EndIf      
EndIf

//chamada da stored procedure	        
If MsgYesNo("Confirma a Execução Desta Carga ?")
	cQuery := "BEGIN " + CRLF	
	cQuery += "IMPORTA_REDE_PRIMAVIDA('"+Trim(cArq1)+"','"+Trim(cArq2)+"','"+Trim(cArq3)+"');" + CRLF	
	cQuery += "END;" + CRLF	
	
	If TcSqlExec(cQuery) <> 0	
		cErro := " - Erro na execucao da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
		QOut(cErro) 
		lOk := .F.      
	Else                 
	    If !MoveFile(cArqLog,cArqExp,.F.)
	 	  Alert("Erro na copia do arquivo de Log !! ")   
	    Else
	      Alert("Arquivo Log Criado em " + cDirLog + " ! ")
	 	EndIf	
	EndIf  
EndIf


Return   
***********************************************************************************************************************
Static Function AjustaSX1(cPerg)

Local aHelpPor := {} 
                          
PutSx1(cPerg,"01",OemToAnsi("Arquivo 1 ")			     	,"","","mv_ch1","C",099,0,0,"G","U_fGetFile('txt     (*.txt)            | *.txt | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Arquivo 2 ")			     	,"","","mv_ch2","C",099,0,0,"G","U_fGetFile('txt     (*.txt)            | *.txt | ')","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("Arquivo 3 ")			     	,"","","mv_ch3","C",099,0,0,"G","U_fGetFile('txt     (*.txt)            | *.txt | ')","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return
*********************************************************************************************************************** 
