#INCLUDE "PROTHEUS.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"
#Include "Ap5Mail.Ch"
#Include 'Tbiconn.ch'   
#Include "PRTOPDEF.CH"
#Include "rwmake.ch"   
#Include "RPTDEF.CH"     
#include "PLSA090.ch"
#include "PROTHEUS.CH"
#include "PLSMGER2.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "UTILIDADES.CH"

#Define CRLF Chr(13)+Chr(10)
/*--------------------------------------------------------------------------
| Programa  | CABA131  | Autor | Altamiro	Affonso    | Data | 24/10/2017  |
|---------------------------------------------------------------------------|
| Descricao | analise da carteira em relação a posição do sib               |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Ajustes / visualização das varias do  sib - browser de seleção|
--------------------------------------------------------------------------*/

User Function CABA158

local cRda        := ' '
local cNivel      := ' '
local nI := 0
                        

Private cPerg	  := "CABA158"

//private cAliasBA1  := GetNextAlias()
private cAliasPEG := GetNextAlias()
private cAliasCT  := GetNextAlias()
private cAliasEX  := GetNextAlias()

private cCompte   := mv_par01
Private cSequen   := Mv_par03
private cTpSib    := Iif(mv_par02 == 1 , 'Sib Mensal', 'Sib Global')

private lFaz      := Iif (SubStr(cUSUARIO,7,8)=='Altamiro',.T.,.F.)    

AjustaSX1(cPerg)
                                   
Pergunte(cPerg,.T.)    

cCompte   := mv_par01
cSequen   := Mv_par03
cTpSib    := Iif(mv_par02 == 1 , 'Sib Mensal', 'Sib Global')    

Processa({|| ProcSib()},'Processando...','Processando...',.T.)


MsgInfo("Processo finalizado")

//	MsgAlert(Left(cBuffer,len(cBuffer)-1))


Return



************************************************************************************


Static Function ProcSib
Local cquery	:= ""
//Local cAliasPEG	:= GetNextAlias()
local i

local c_Script  :=' '
local c_Script1 :=' '

if !lFaz     

    MsgAlert("Usuario "+SubStr(cUSUARIO,7,8)+" NÃO Esta Autorizado a Usar Esta Funcionalidade ")

Else 
   c_Script1 := "DELETE " + RetSqlName("PD4") +" " 
   c_Script1 += " WHERE PD4_FILIAL ='"+ Xfilial("PD4")+ "' AND d_e_l_e_t_ = ' ' " 
   c_Script1 += "   AND PD4_TIPENV = '"+cTpSib+"' "           
   c_Script1 += "   AND PD4_COMPTE = '"+cCompte+"' " 
   c_Script1 += "   AND PD4_SEQUEN = '"+cSequen+"' "  
   c_Script1 += "   AND ( SELECT NVL(COUNT(*),0)
   c_Script1 += "           FROM " + RetSqlName("PD5") +" " 
   c_Script1 += "          WHERE PD5_FILIAL  = '"+ Xfilial("PD5")+ "' AND d_e_l_e_t_ = ' ' " 
   c_Script1 += "            AND PD5_TPENVI  = '"+cTpSib+"' "           
   c_Script1 += "            AND PD5_COMPTE  = '"+cCompte+"' " 
   c_Script1 += "            AND PD5_SEQUEN  = '"+cSequen+"' "  
   c_Script1 += "            AND PD5_ENVIAD  = 'T' )= 0 "
    
   If TcSqlExec(c_Script1) < 0 
	  LogErros("Falha ao DELETAR  tabela "+RetSqlName("PD4") + CRLF;
	         + "Verifique se ja foram Enviados "            + CRLF;
		  	 + "Script executado: " + c_Script1 + CRLF;
			 + "Erro: " + TcSQLError();
				 ," ",.T.)	

      l_Erro	:= .T.
      Return (.F.)
   Else	
     c_Script := "DELETE " + RetSqlName("PD5") +" " 
      c_Script += " WHERE PD5_FILIAL ='"+ Xfilial("PD5")+ "' AND d_e_l_e_t_ = ' ' " 
      c_Script += "   AND PD5_TPENVI  = '"+cTpSib+"' "           
      c_Script += "   AND PD5_COMPTE  = '"+cCompte+"' " 
      c_Script += "   AND PD5_SEQUEN  = '"+cSequen+"' "  
      c_Script += "   AND ( SELECT NVL(COUNT(*),0)
      c_Script += "           FROM " + RetSqlName("PD5") +" " 
      c_Script += "          WHERE PD5_FILIAL ='"+ Xfilial("PD5")+ "' AND d_e_l_e_t_ = ' ' " 
      c_Script += "            AND PD5_TPENVI  = '"+cTpSib+"' "           
      c_Script += "            AND PD5_COMPTE  = '"+cCompte+"' " 
      c_Script += "            AND PD5_SEQUEN  = '"+cSequen+"' "  
      c_Script += "            AND PD5_ENVIAD  = 'T' )= 0 "
    
   	  If TcSqlExec(c_Script) < 0 
		 LogErros("Falha ao DELETAR  tabela "+RetSqlName("PD5") + CRLF;
		        + "Verifique se ja foram Enviados "            + CRLF;
				+ "Script executado: " + c_Script + CRLF;
				+ "Erro: " + TcSQLError();
		  		, " ",.T.)	
		 l_Erro	:= .T.
        
         Return (.F.)
      
      Else	
            
          Return (.T.) 
	
      EndIf
    
   EndIf

EndIf    

Return ()

/********************************************/
/********************************************/


/********************************************/

**********************************************************************************
Static Function marca() // cRef == 1 peg , 2 , proc

local nI

For nI := 1 to len(aBrwPEG)
	
	
	aBrwPEG[nI,1]:= .T.
	

Next

RETURN()


static Function desmarca1()

local nI


For nI := 1 to len(aBrwPEG)
	
	aBrwPEG[nI,1]:= .F.
	
Next


RETURN()


***************************************************************************************/
Static Function VerifMarc( )

local nI


For nI := 1 to len(aBrwPEG)

//	If  (Trim(aBrwPEG[nI,4])!= 'AJUSTAR BASE' .AND. Trim(aBrwPEG[nI,4])!= 'ENVIAR BLOQUEIO') .or. aBrwPEG[nI,5] == 0 

/*	If  (substr(aBrwPEG[nI,3],1,5) $ '0.1 -|0.2 -|1.1 -|2.1 -|2.2 -') .and. aBrwPEG[nI,5] > 0 
	
        A:= 'B'
    Else    		
		aBrwPEG[nI,1]:= .F.
		
	EndIf
*/	
Next



Return()
*********************************************************************************

Static Function AjustaSX1(cPerg)

//Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Competencia : ","","","mv_ch1","C",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "999999", "" })
aadd(aRegs,{cPerg,"02","Tipo Sib    : ","","","mv_ch2","N", 1,0,0,"C","","mv_par02","Sib Mensal","","","","","Sib Global","","","","","","","","","","","","","","","","","" , "" ,"" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Sequencia   : ","","","mv_ch3","C",02,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" })

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

RestArea( aAreaAtu )

Return(.T.)





