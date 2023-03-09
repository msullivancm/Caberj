#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA598   บAutor  ณMotta               บ Data ณ  JUL/17     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  ENVIAR EMAIL DE AVISO DA 112                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                          

User Function CABA598()


Local lSchedule := .F.   
Private cPerg       := "CABA598"

AjustaSX1(cPerg)

If !Pergunte(cPerg,.T.)
	Return
EndIf

Processa({||execMail(lSchedule)},'Processando...')

Return               


*************************************************************************************************************************

Static Function execMail(lSchedule)

Local i := 0
   
If !lSchedule
	ProcRegua(0)
	
	For i:= 1 to 5                                 
		Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando EnvioEmail...')
	Next
	
	exEnvMail()
EndIf

***********************************************************************************************************************

Static Function exEnvMail()
	
Local cErro 	:= ''
Local lOk		:= .T.
Local cQuery 	:= ''   
Local cDirLog   := 'c:\' 
Local cArqLog   := ' ' 
Local cArqExp   := ' '
Static cPath	:= "\\srvdbp\backup\utl\"  
                                                                          

cDirLog  := Substr(mv_par01,1,Rat("\",mv_par01))
cArqLog  := cPath+"log_envio_email_boleto_"+DtoS(DDatabase)+".txt"
cArqExp  := cDirLog+"log_envio_email_boleto_"+DtoS(DDatabase)+".txt"


//chamada da stored procedure	        
If MsgYesNo("Confirma a Execu็ใo Deste envio ?")
	cQuery := "BEGIN " + CRLF	
	cQuery += "  ENVIA_EMAIL_HTML_BOLETO('"+Trim(mv_par01)+"','"+Trim(mv_par02)+"','"+Trim(mv_par03)+"');" + CRLF	
	cQuery += "END;" + CRLF	
	
	If TcSqlExec(cQuery) <> 0	
		cErro := " - Erro na execucao da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
		ConOut(cErro) 
		lOk := .F.      
	Else                 
	    If !MoveFile(cArqLog,cArqExp,.F.)
	 	  Alert("Erro no envio de email !! ")   
	    Else
	      Alert("Arquivo Log Criado em " + cArqExp + " ! ")
	 	EndIf	
	EndIf  
EndIf


Return   
***********************************************************************************************************************
Static Function AjustaSX1(cPerg)

Local aHelpPor := {} 
                          
aHelpPor := {} 
aAdd(aHelpPor, "Exemplo Agosto/20xx - vencimento 10/xx/xx ")
PutSx1(cPerg,"01",OemToAnsi("Refer   ")			     	,"","","mv_ch1","C",099,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
aHelpPor := {} 
aAdd(aHelpPor, "Exemplo dd/mm/yyyy ")
PutSx1(cPerg,"02",OemToAnsi("Emissao ")			     	,"","","mv_ch2","C",099,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
aHelpPor := {} 
aAdd(aHelpPor, "S Teste/Valid/N Envio definitivo ")
PutSx1(cPerg,"03",OemToAnsi("Teste   ")			     	,"","","mv_ch3","C",001,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return
*********************************************************************************************************************** 