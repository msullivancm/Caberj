#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

 
/*
**********************************************************************************************************************************************************
********ºPrograma   ³CABR269    ºAutor   ³Motta                º Data  ³  jul/19      
**********************************************************************************************************************************************************
********ºDesc.     Â³   gera arquivo csv para uso de regiao/rda                  ÂºÂ±Â±
********º          Â³  (PROCEDURE ORACLE SIGA.GERA_PLAN_REGIAO_GEREM)            ÂºÂ±Â±
**********************************************************************************************************************************************************
********ºUso       Â³ AP                                                         ÂºÂ±Â±
**********************************************************************************************************************************************************
********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±Â±Â±
**********************************************************************************************************************************************************
*/                          

******************************************************************************************************

Static cPath	:= "\\srvdbp\backup\utl\" //Onde a Procedure le o arquivo de carga   

******************************************************************************************************

User Function CABR269()

Local lSchedule := .F.   
Private cPerg       := "CAB269"

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
	
Local cEmp := " "
Local cArqEmp := ""
Local cArqpln := " "
Local cArqprx := " "
Local cErro 	:= ''
Local lOk		:= .T.
Local cQuery 	:= " "  
Local cSufix      := " "
Local cArqDe    := " "
Local cArqExp   := " "
Local cPath	    := "\\srvdbp\backup\utl\" 
Local cPathp	:= "C:\TEMP\"  

if cEmpAnt = "01" 
  cEmp := "C"
  cArqprx := "caberj_planilha_regiao_gerem_"
else
  cEmp := "I"  
  cArqprx := "integral_planilha_regiao_gerem_"
Endif 

If !Empty(mv_par02)
  cArqEmp := "_emp_"+Alltrim(mv_par02)
Endif

If !Empty(mv_par03)
  cArqpln := "_plano_"+Alltrim(mv_par03)
Endif

If !Empty(mv_par02) .AND. !Empty(mv_par03) 
  cSufix := cArqprx+Substr(DtOS(MV_PAR04),1,6)+"_"+Substr(DtOS(MV_PAR05),1,6)+".csv" 
else
  If !Empty(mv_par02)  
    cSufix := cArqprx+Substr(DtOS(MV_PAR04),1,6)+"_"+Substr(DtOS(MV_PAR05),1,6)+cArqEmp+".csv" 
  elseIf !Empty(mv_par03)  
     cSufix := cArqprx+Substr(DtOS(MV_PAR04),1,6)+"_"+Substr(DtOS(MV_PAR05),1,6)+cArqpln+".csv" 
  else
    cSufix := cArqprx+Substr(DtOS(MV_PAR04),1,6)+"_"+Substr(DtOS(MV_PAR05),1,6)+".csv" 
  end if 
end if

cArqDe   := cPath+cSufix
cArqExp  := cPathp+cSufix

//chamada da stored procedure	        
If MsgYesNo("Confirma a Execucao Desta Carga ?")
	cQuery := "BEGIN " + CRLF	
	cQuery += "GERA_PLAN_REGIAO_GEREM('"+cEmp+"'," + CRLF		
	cQuery += "                       '"+mv_par02+"'," + CRLF	
	cQuery += "                       '"+mv_par03+"'," + CRLF		
	cQuery += "TO_DATE('"+Substr(DtOS(MV_PAR04),1,6)+"','YYYYMM')," + CRLF	
	cQuery += "TO_DATE('"+Substr(DtOS(MV_PAR05),1,6)+"','YYYYMM'));" + CRLF	
	cQuery += "END;" + CRLF	
	
		
	If TcSqlExec(cQuery) <> 0	
		cErro := " - Erro na execucao da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
		QOut(cErro) 
		lOk := .F.      
	Else                 
	    If !MoveFile(cArqDe,cArqExp,.F.)
	 	  Alert("Erro na copia do arquivo gerado !! "+cArqDe+" "+cArqExp)   
	    Else
	      Alert("Arquivo Criado em " + cArqExp + " ! ")
	 	EndIf	
	EndIf  
EndIf


Return   
***********************************************************************************************************************
Static Function AjustaSX1(cPerg)

Local aHelpPor := {} 
                          
/*
rda
emp
refde
refate
*/

Pergunte(cPerg,.T.)

Return
*********************************************************************************************************************** 
