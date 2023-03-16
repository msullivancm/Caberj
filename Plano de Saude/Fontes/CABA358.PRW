#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

 
/*
**********************************************************************************************************************************************************
********ºPrograma   ³CABA358    ºAutor   ³Motta                º Data  ³  jun/19      
**********************************************************************************************************************************************************
********ºDesc.     Â³   gera arquivo csv para calculo bonus maturidade           ÂºÂ±Â±
********º          Â³  (PROCEDURE ORACLE SIGA.GERA_BONUS03_MAT)                  ÂºÂ±Â±
**********************************************************************************************************************************************************
********ºUso       Â³ AP                                                         ÂºÂ±Â±
**********************************************************************************************************************************************************
********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±Â±Â±
*** junho 22 incluir a integral , SP alterada
**********************************************************************************************************************************************************
*/                          

******************************************************************************************************

Static cPath	:= "\\srvdbp\backup\utl\" //Onde a Procedure le o arquivo de carga   

******************************************************************************************************

User Function CABA358()

Local lSchedule := .F.   
Private cPerg       := "CABA358"

// 12 AjustaSX1(cPerg)

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
Local cArq      := ' '
Local cArqDe   := ' '
Local cArqExp   := ' '
Static cPath	:= "\\srvdbp\backup\utl\"  

If cEmpAnt = "01" 
  cArq := "bonus_mat_caso3_caberj_"+Substr(DtOS(MV_PAR03),1,6)+"_"+Substr(DtOS(MV_PAR04),1,6)+".csv" 
Else
  cArq := "bonus_mat_caso3_integral_"+Substr(DtOS(MV_PAR03),1,6)+"_"+Substr(DtOS(MV_PAR04),1,6)+".csv" 
Endif

cArqDe   := cPath+cArq
cArqExp  := "C:\TEMP\"+cArq


//chamada da stored procedure	        
If MsgYesNo("Confirma a Execucao Desta Carga ?")
	cQuery := "BEGIN " + CRLF	
	cQuery += "GERA_BONUS03_MAT_NOVO('"+cEmpAnt+"'," + CRLF
	cQuery += "                      '"+mv_par01+"'," + CRLF			
	cQuery += "                      '"+mv_par02+"'," + CRLF		
	cQuery += "TO_DATE('"+DtoS(mv_par03)+"','YYYYMMDD')," + CRLF	
	cQuery += "TO_DATE('"+DtoS(mv_par04)+"','YYYYMMDD'));" + CRLF	
	cQuery += "END;" + CRLF	
	
	If TcSqlExec(cQuery) <> 0	
		cErro := " - Erro na execucao da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
		QOut(cErro) 
		lOk := .F.      
	Else                 
	    If !MoveFile(cArqDe,cArqExp,.F.)
	 	  Alert("Erro na copia do arquivo de Log !! ")   
	    Else
	      Alert("Arquivo Criado em " + cArqExp + " ! ")
	 	EndIf	
	EndIf  
EndIf


Return   
***********************************************************************************************************************
Static Function AjustaSX1(cPerg)

Local aHelpPor := {} 
                          
PutSx1(cPerg,"01",OemToAnsi("RDA Excl ")			  	,"","","mv_ch1","C",099,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("RDA Vinc ")			 	,"","","mv_ch2","C",099,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("Ref De ")			     	,"","","mv_ch3","D",008,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"04",OemToAnsi("Ref Ate ")			     	,"","","mv_ch4","D",008,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return
*********************************************************************************************************************** 
