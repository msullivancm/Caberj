#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

 
/*
**********************************************************************************************************************************************************
********ºPrograma   ³CABA263    ºAutor   ³Motta                º Data  ³  jul/19      
**********************************************************************************************************************************************************
********ºDesc.     Â³        Gera base utilização benef baseado arq cvs usuario
********º          Â³        chama sp Oracle GERA_PLAN_GEPLAN_ID_USUARIOS (teste)
**********************************************************************************************************************************************************
********ºUso       Â³ AP                                                         ÂºÂ±Â±
**********************************************************************************************************************************************************
********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±********±Â±Â±
**********************************************************************************************************************************************************
*/                          

******************************************************************************************************

Static cPath	:= "\\srvdbp\backup\utl\" //Onde a Procedure le o arquivo de carga   

******************************************************************************************************

User Function CABA263()

Local lSchedule := .F.   
Private cPerg       := "CAB263"

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
		Incproc(DtoC(Date()) + ' ' + Time() + ' - Processando CargaSASBenef...')
	Next
	
	exCarDental()
EndIf

***********************************************************************************************************************

Static Function exCarDental()
	
Local cEmp := " "
Local cArqDe := ""
Local cArqEmp := ""
Local cErro 	:= ''
Local lOk		:= .T.
Local cQuery 	:= " "  
Local cSufix    := " "
Local cArqEnt   := " "
Local cOpcTab   := 0
Local cPathDe	:= "C:\TEMP\"  
Local cPathAte  := "\\srvdbp\backup\utl\" 
Local cMmsg     := ""

cArqDe  := AllTrim(mv_par01)
cOpcTab := AllTrim(mv_par02)

If cOpcTab = 'A' 
  cMmsg := " (acrescimo a base) "
Else  
  cMmsg := " (refaez a base) "
Endif  
  

If !MoveFile(cPathDe+cArqDe,cPathAte+cArqDe,.F.)
  Alert("Erro na copia do arquivo informado !! "+cArqDe) 
EndIf	


//chamada da stored procedure	        
If MsgYesNo("Confirma a Execucao Desta Carga "+cMmsg+" ?")
	cQuery := "BEGIN " + CRLF	
	cQuery += "GERA_PLAN_GEPLAN_ID_USUARIOS('"+cArqDe+"'," + CRLF	
	cQuery += "                             '"+cOpcTab+"');" + CRLF	
	cQuery += "END;" + CRLF	

	//memowrite("C:\TEMP\sql263.sql",cQuery)      
	
		
	If TcSqlExec(cQuery) <> 0	
		cErro := " - Erro na execucao da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
		QOut(cErro) 
		lOk := .F.      
	Else
	  Alert("Tabela  GEPLAN.SAS_IDENTIF_BENEFICIARIOS atualizada ! ")
	EndIf
EndIf


Return   
***********************************************************************************************************************
Static Function AjustaSX1(cPerg)

Local aH2631 := {}
Local aH2632 := {} 
//Monta Help
Aadd(aH2631, 'Informe nome do arquivo csv em c/temp ,por exemplo xpto.csv  ' ) 
Aadd(aH2632, 'A- ACRESCENTA A BASE //  N-REFAZ A BASE' )


u_CABASX1(cPerg,"01","Nome Arq   "  ,"","","mv_ch01","C",99,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",aH2631,{},{})
u_CABASX1(cPerg,"02","Opcao      "  ,"","","mv_ch02","C",01,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",aH2632,{},{})
PutSX1Help("P."+cPerg+"01.",aH2631,{},{})
PutSX1Help("P."+cPerg+"02.",aH2632,{},{})


Return
*********************************************************************************************************************** 
User Function FiDlg263()
local tmp := getTempPath()
local targetDir:= tFileDialog( "All files (*.*) | All Text files (*.txt) ",;
        'Selecao de Arquivos',, tmp, .F., GETF_MULTISELECT )
 
    msgAlert(targetDir)
return
*********************************************************************************************************************** 
