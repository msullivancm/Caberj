
#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch" 
                                              
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR245   º Autor ³Altamiro              º Data ³ 24/10/17  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Acompanhamento do Sib - extrato               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                                                      

User Function FazPerg( )

Local cMsg			:= " "

Private lAbortPrint := .F.
Private cPerg       := "CABA183A"
Private cTitulo     := "APROVAÇÃO DE PAGAMETO COMISSAO "        

***************************************************************************    

private  Descric := ' '

cMsg += " Este programa ira fazer a geração das perguntas para o PROGRAMA CABA183A " + CRLF
cMsg += "  " + CRLF
                                                                                                         

  AjustaSX1()

  Pergunte(cPerg,.T.)  
   

MsgInfo("Processo finalizado")

Return                 

*********************************************************************************

Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}

aAdd(aHelp, "Informe o Mes da Liberação ")
U_CABASX1(cPerg , "01" , "Mes da Liberação " ,"","","mv_ch1","C",2,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe o Ano da Liberação ")
U_CABASX1(cPerg , "02" , "Ano da Liberação " ,"","","mv_ch2","C",4,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

/*
aAdd(aHelp, "Empresa ")
U_CABASX1(cPerg , "01" , "Caberj/Integral?  " ,"","","mv_ch1","N",1,0,0,"C","","","","","mv_par01","Caberj","","","","Integral","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe a Compte De Pagto ")
U_CABASX1(cPerg , "02" , "Compte Pagto (AAAAMM)" ,"","","mv_ch2","C",6,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)


aAdd(aHelp, "Data de processamento , inicial ")
U_CABASX1(cPerg , "02" , "Data Inc. De " ,"","","mv_ch02","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de processamento , Final ")
U_CABASX1(cPerg , "03" , "Data Inc. Ate " ,"","","mv_ch03","D",08,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, " Quanto ao saldo ")
U_CABASX1(cPerg,"04", "Saldo ? ","","","mv_ch4","N",1,0,1,"C","","","","","mv_par04"," Saldo = 0 "	,"","","","Saldo > 0","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe a Compte Inicial")
U_CABASX1(cPerg , "02" , "Compte Inicial(AAAAMM)" ,"","","mv_ch2","C",6,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe a Compte Final")
U_CABASX1(cPerg , "03" , "Compte Final(AAAAMM)" ,"","","mv_ch3","C",6,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe Empresa Inicial")
U_CABASX1(cPerg , "04" , "Empresa Inicial" ,"","","mv_ch4","C",4,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Informe Empresa Final")
U_CABASX1(cPerg , "05" , "Empresa Final" ,"","","mv_ch5","C",4,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de processamento , seleção da janela")
U_CABASX1(cPerg , "06" , "Dt do Processamento De " ,"","","mv_ch06","D",08,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Data de processamento , seleção da janela")
U_CABASX1(cPerg , "07" , "Dt do Processamento Ate" ,"","","mv_ch07","D",08,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Contrato Inicial ")
U_CABASX1(cPerg,"08", "Contrato Inicial " ,"","","mv_ch8","C",12,0,1,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Contrato Final  ")
U_CABASX1(cPerg,"09", "Contrato Final   " ,"","","mv_ch9","C",12,0,1,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Sub_Contrato Inicial ")
U_CABASX1(cPerg,"10", "Contrato Inicial " ,"","","mv_cha","C",09,0,1,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "sub Contrato Final  ")
U_CABASX1(cPerg,"11", "Sub_Contrato Final   " ,"","","mv_chb","C",09,0,1,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
*/
Return  

