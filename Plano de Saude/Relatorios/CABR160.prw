#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR159  ³ Autor ³ Paulo Motta           ³ Data ³  nov/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera Extrato da Integral (via chamada de Stored Procedure) ³±±
±±³          ³ GERAR_EXTRATO_INTEGRAL                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR160

Static cPath	:= "\\srvdbp\backup\utl\"
Private cPerg	:= "CABR160"  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
If cEmpAnt != "02"
  Return
Endif

AjustaSX1()

If !Pergunte(cPerG,.T.)
	Return
EndIf	
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ CHAMADA DA SP                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                   

cNomeArq	:= 'extrato_integral_' + mv_par01 + '_' + Substr(DtoS(mv_par09),1,6) + '_' + mv_par06 + mv_par07 + mv_par08 + '.txt'  
cArq		:= cPath + cNomeArq        
//Bianchini - 07/07/2020 - P12-R27 - Adequação de URL´s para MV´s
//cArqExp		:= "\\10.19.1.8\Protheus_Data\interface\exporta\ExtIntegral\" + cNomeArq
cArqExp		:= "\\"+AllTrim(GetMv("MV_XSRVTOP"))+"\Protheus_Data\interface\exporta\ExtIntegral\" + cNomeArq

QOut(' - Iniciando carga')   
          
cQuery := "BEGIN "				
cQuery += "GERAR_EXTRATO_INTEGRAL("    
cQuery += " '" + mv_par01 + "',"  
cQuery += " '" + mv_par02 + "',"  
cQuery += " '" + mv_par03 + "',"  
cQuery += " '" + mv_par04 + "',"  
cQuery += " '" + mv_par05 + "',"  
cQuery += " '" + mv_par06 + "',"  
cQuery += " '" + mv_par07 + "',"  
cQuery += " '" + mv_par08 + "',"    
cQuery += " TO_DATE('" + dToS(mv_par09) + "','YYYYMMDD')" 
cQuery += " );"
cQuery += "END; "					

QOut(' - Executando procedure...') 

If TcSqlExec(cQuery) <> 0	
	cErro := " - Erro na execução da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
	QOut(cErro) 
	lOk := .F.      
Else                 
    If !MoveFile(cArq,cArqExp,.F.)
	  Alert("Erro na copia do arquivo !! ")   
    Else
      Alert("Arquivo Criado em interface\exporta\ExtIntegral ")
	EndIf	
EndIf

QOut(' - Fim procedure...')

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Paulo Motta                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta as perguntas do SX1                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()  

aHelp := {}
aAdd(aHelp, "Informe a Empresa")         
PutSX1(cPerg , "01" , "Empresa" 			,"","","mv_ch1","C",TamSx3("BG9_CODIGO")[1],0,0,"G",""	,,"","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Contrato Inicial")         
PutSX1(cPerg , "02" , "Contrato De" 		,"","","mv_ch2","C",TamSx3("BT5_NUMCON")[1],0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Contrato Final")         
PutSX1(cPerg , "03" , "Contrato Ate"    	,"","","mv_ch3","C",TamSx3("BT5_NUMCON")[1],0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
       
aHelp := {}
aAdd(aHelp, "Informe o SubContrato Inicial")         
PutSX1(cPerg , "04" , "Subcontrato De" 		,"","","mv_ch4","C",TamSx3("BQC_SUBCON")[1],0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o SubContrato Final")         
PutSX1(cPerg , "05" , "Subcontrato Ate" 	,"","","mv_ch5","C",TamSx3("BQC_SUBCON")[1],0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Gera sem Copart (S/N)?")  
aAdd(aHelp, "S - Gera registros por procedimento mesmo se a copart for zero")
PutSX1(cPerg,"06","Gera s Copart"	      	,"","","mv_ch6","C",01,0,0,"G","",""			,"","","mv_par06",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Gera Incondicional? (S/N)?")  
aAdd(aHelp, "S - Gera registros por assitido de forma incondicional")
PutSX1(cPerg,"07","Incondicional?"	      	,"","","mv_ch7","C",01,0,0,"G","",""			,"","","mv_par07",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Envia Valor Aprovado? (S/N)?")  
aAdd(aHelp, "N - Nao envia o Valor Aprovado no arquivo, envia 0(zero) no lugar")
PutSX1(cPerg,"08","Envia Vl Aprov?"	      	,"","","mv_ch8","C",01,0,0,"G","",""			,"","","mv_par08",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)
   
aHelp := {}
aAdd(aHelp, "Mes/Ano de Referencia de Cobranca")  
PutSX1(cPerg,"09","Mes/Ano Ref."	      	,"","","mv_ch9","D",08,0,0,"G","",""			,"","","mv_par09",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)


RestArea(aArea2)

Return   

******************************************************************************************************************************

