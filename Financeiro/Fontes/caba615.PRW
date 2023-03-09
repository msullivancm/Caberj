#include "PLSA090.ch" 
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "UTILIDADES.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO4     บAutor  ณMarcela Coimbra     บ Data ณ  13/08/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                      	

User Function CABA615()    

	Local c_Perg := "CABA615"  
	
	If FUNNAME() = "CABA091"

		u_bol_brades()     
		
		If MsgYesNo("Processo concluํdo, deseja gerar LOG?")
	
			u_GeraLogEmail(dtos(DATE()), mv_par01+mv_par02)                            
	
		EndIf

	Else

		CriaSX1( c_Perg )
		
		If Pergunte( c_Perg )
			
			u_bol_brades()     
			
			If MsgYesNo("Processo concluํdo, deseja gerar LOG?")
		
				u_GeraLogEmail(dtos(DATE()), mv_par01+mv_par02)                            
		
			EndIf
		
		EndIf  

	EndIf  


Return               

Static Function CriaSX1(cPerg)

PutSx1(cPerg,"01",OemToAnsi("Ano Titulo")			,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Mes Titulo")			,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Bordero De")			,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Bordero Ate")			,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})

Return
          
       
User Function GeraLogEmail() 

	Local a_vet 	:= {}      
	Local a_Cabec 	:= {}      

   	a_Cabec := {"Matricula", "E-mail", "Enviado", "Motivo", "Competencia" , "Titulo", "Saldo", "Vencimento" }
				
	c_Query := " Select * "
	c_Query += " from log_envio_boleto_email "
	c_Query += " where empresa = '" + iIf( cEmpAnt=='01', 'C', 'I') + "' "
	c_Query += " AND  DATA = '" + DTOS(date()) + "' "    

	If Select("QRYLOGBOL") <> 0     
	
		("QRYLOGBOL")->(DbCloseArea())  
		
	Endif     
	 
		DbUseArea(.T.,"TopConn",TcGenQry(,,c_Query),"QRYLOGBOL",.T.,.T.)
	
	While !QRYLOGBOL->( EOF() )
	     
	                         
		aadd(a_vet,{ 	"'"+QRYLOGBOL->MATRICULA, ;
						QRYLOGBOL->EMAIL, ;
						QRYLOGBOL->ENVIADO, ;
						QRYLOGBOL->MOTIVO, ;
						"'"+QRYLOGBOL->COMPETENCIA, ;
						"'"+QRYLOGBOL->TITULO, ;
						QRYLOGBOL->SALDO, ;
						QRYLOGBOL->VENCREA })
		
		QRYLOGBOL->( dbSkip() )
	
	EndDo 
	
		DlgToExcel({{"ARRAY","Grava็๕es da Filial" ,a_Cabec,a_vet}})

Return          
 
