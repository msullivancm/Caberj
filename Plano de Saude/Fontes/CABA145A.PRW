#Define CRLF Chr(13)+Chr(10)
#INCLUDE "PROTHEUS.ch"                                                                                                                                  
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"    
/*--------------------------------------------------------------------------
| Programa  | CABA145 | Autor | Altamiro	Affonso    | Data | 14/12/2018  |
|---------------------------------------------------------------------------|              
| Descricao | Controle de vidas ao ser enviadas a ans e                     |
|           | controle de processamento                                     |                                                       
|---------------------------------------------------------------------------|
| Uso       | gestao do SIB - cadastro                                      | 
 --------------------------------------------------------------------------*/

User Function CABA145A 

PRIVATE OK      := .T. 
Private cPerg	:= "CABA145A"     
private mvpar01 
private mvpar02
private mvpar03
private mvpar04 
private mvpar05 
private mvpar06
private mvpar07
private mvpar08
private mvpar09
                                     
While OK == .T. 


AjustaSX1()

Pergunte(cPerg,.T.)    

cPerg	:= "CABA145A" 

mvpar01:= mv_par01  
mvpar02:= mv_par02 
mvpar03:= mv_par03 
mvpar04:= mv_par04 
mvpar05:= mv_par05 
mvpar06:= mv_par06 
mvpar07:= mv_par07 
mvpar08:= mv_par08 
mvpar09:= mv_par09 


OK:=U_CABA145(mvpar01 , mvpar02 , mvpar03 , mvpar04 , mvpar05 , mvpar06 , mvpar07 , mvpar08 , mvpar09,'CABA145A')

EndDo                                                                                   
                                                                                                 
Return()    

/***********************************************************************************/


Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe a Competencia do Sib")
PutSX1(cPerg , "01" , "Compet do sib (AAAAMM)" ,"","","mv_ch1","C",6,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Tipo de Envio Sib")
PutSX1(cPerg,"02", "Tipo de Envio Sib"         ,"","","mv_ch2","N",1,0,1,"C","","","","","mv_par02","Sib Mensal"	,"","","","Sib Global","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Tipo de Acao do Sib ")
PutSX1(cPerg,"03", "Tipo de Acao do Sib"        ,"","","mv_ch3","N",1,0,1,"C","","","","","mv_par03","Inclusoes"	,"","","","Exclusões","","","Retificações","","","Reativação","","","Todos","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Sequencia do Sib ")
PutSX1(cPerg , "04" , "Sequencia"           ,"","","mv_ch4","C",2,0,0,"G","","","","","mv_par04"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
 
aAdd(aHelp, "Criticas ")
PutSX1(cPerg,"05", "Criticas ","","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Com Criticas "	,"","","","Sem Criticas ","","","Todos","","","","","","","","",aHelp,aHelp,aHelp) 

aAdd(aHelp, "Enviados ")
PutSX1(cPerg,"06", "Enviados","","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","Enviados "	,"","","","Não Enviados","","","Todos","","","","","","","","",aHelp,aHelp,aHelp)

aAdd(aHelp, "Cod CCo ")
PutSX1(cPerg,"07", "Cod CCo ?","","","mv_ch7","C",12,0,0,"G","","","","","mv_par07"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp) 

aAdd(aHelp, "Matricula ")
PutSX1(cPerg,"08", "Matricula  ?","","","mv_ch8","C",17,0,0,"G","","","","","mv_par08"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp) 

aAdd(aHelp, "Nome Usuario  ")
PutSX1(cPerg,"09", "Nome Usuario  ?","","","mv_ch9","C",40,0,0,"G","","","","","mv_par09"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)

/*
aAdd(aHelp, "Cod Fornecedor Final  ")
PutSX1(cPerg,"09", "Cod Fornecedor  Ate ?","","","mv_ch9","C",6,0,0,"G","","","","","mv_par09"," ","","",""," ","",""," ","","","","","","","","",aHelp,aHelp,aHelp)
*/
Return  

