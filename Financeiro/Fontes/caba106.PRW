
#include "rwmake.ch"       // incluido pelo assistente de conversao do AP6 IDE em 08/09/03
#include "tbicode.ch"
#include "tbiconn.ch"
/*-----------------------------------------------------------------------------+/
/------------------------------------------------------------------------------+/
/| PROGRAMA  | caba106      | AUTOR | altamiro  | Data | 05/01/2011            |/
/+-----------------------------------------------------------------------------+/
/| DESCRICAO | Funcao utilizada para altera��o do conte�do dos par�metros      |/
/|           | 		indicados no Vetor aParam								   |/
/+-----------------------------------------------------------------------------+/
/| MANUTENCAO DESDE SUA CRIACAO                                                |/
/+-----------------------------------------------------------------------------+/
/| DATA     | AUTOR                | DESCRICAO                                 |/
/+-----------------------------------------------------------------------------+/
/+-----------------------------------------------------------------------------*/


User Function caba106() 

//Prepare Environment Empresa "99" Filial "01"

// A Rotina encontra-se no Modulo de financeiro - fontes  

Local cMensagem := ""
Local nCont     := 0
Local aMsg      := {} 

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private _dData1,_dData2,_dData3,_dData4,_dData5
//Private aParam := {"MV_ULTDEPR","MV_DATAFIN","MV_DATAFIS","MV_DATAREC","MV_ULMES"} 
Private aParam := {"MV_FOLMES","MV_DATAFIN","MV_DATAFIS","MV_DATAREC","MV_ULMES"}


For i := 1 To Len(aParam) 
	DbSelectArea("SX6")
	DbSetOrder(1)
	If DbSeek(cFilAnt+aParam[i])
		nCont++
	ElseIf DbSeek("  "+aParam[i])
   		nCont++
	Else
		Aadd(aMsg,{"O Parametro "+aParam[i]+" n�o existe"+CHR(13)+CHR(10)})
	EndIf

Next
If !nCont = Len(aParam) 
	For i := 1 To Len(aMsg)
		cMensagem += (aMsg[i][1])
	Next
   	Aviso("Aviso",cMensagem,{"Ok"},1,"Par�metro Inexistente")
   //	Alert(cMensagem)
	Return
EndIf	                                                              

_dData1 := GetMv("MV_FOLMES")
_dData2 := GetMv("MV_DATAFIN")
_dData3 := GetMv("MV_DATAFIS")
_dData4 := GetMv("MV_DATAREC")
_dData5 := GetMv("MV_ULMES")
                               
@ 146,243 To 420,547 Dialog Dlg01 Title OemToAnsi("Mudanca de Parametro")
@ 013,008 To 120,138 Title OemToAnsi("Informe o conteudo ")
//@ 020,017 Say OemToAnsi("Ativo Fixo")  Size 068,008          
@ 020,017 Say OemToAnsi("Folha Integral")  Size 068,008
@ 034,017 Say OemToAnsi("Financeiro")  Size 068,008
@ 048,017 Say OemToAnsi("Fiscal")      Size 068,008
@ 062,017 Say OemToAnsi("Rec.Bancaria")Size 068,008
@ 076,017 Say OemToAnsi("Estoque/Fat") Size 068,008   
@ 020,089 Get _dData1                  Size 038,010   
@ 034,089 Get _dData2                  Size 038,010
@ 048,089 Get _dData3                  Size 038,010
@ 062,089 Get _dData4                  Size 038,010
@ 076,089 Get _dData5                  Size 038,010
@ 095,30 Button OemToAnsi("_Confirma") Size 030,012 Action fChamaFunc()// Substituido pelo assistente de conversao do AP6 IDE em 08/09/03 ==>      @ 065,009 Button OemToAnsi("_Confirma") Size 036,016 Action Execute(fMudaParam)
@ 095,78 Button OemToAnsi("C_ancela")  Size 030,012 Action Close(Dlg01)   

Activate Dialog Dlg01 Centered

Return 

****************************           
Static Function fChamaFunc 
****************************

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

aData := {_dData1,_dData2,_dData3,_dData4,_dData5} 
//aData := {_dData2,_dData3,_dData4,_dData5}
For i := 1 To Len(aParam)    
 	FMudaParam(aData[i],aParam[i])                                          
Next                                                                       
Close(Dlg01)
Return

/*/
||-------------------------------------------------------------------------||
||=========================================================================||
||�Programa: fMudaParam      Autor: Erisson Diniz          Data: 17/11/06  ||
||=========================================================================||
||�Descricao: Fun��o Utilizada alterar as datas dos parametros existentes  ||
||               No Vetor aParam                                           ||
||=========================================================================||
||�Uso       � MMXALTDATA                                                  ||
||=========================================================================||
||=========================================================================||
---------------------------------------------------------------------------||
/*/
*******************
Static Function fMudaParam(DataFun,Parametro)
*******************  
if valtype(DataFun) =='D'       
   _cData      := Dtos(DataFun)
Else 
   _cData      := DataFun  
EndIf    
_cParametro := Parametro
DbSelectArea("SX6")
DbSetOrder(1)
If DbSeek(cFilAnt+_cParametro)
	If !Empty(_cData)
		RecLock("SX6",.F.)      
		If valtype(DataFun) !='D'                
           SX6->X6_CONTEUD  := _cData 
        Else		
    		SX6->X6_CONTEUD := Substr(_cData,1,4)+ ;
                               Substr(_cData,5,2)+ ;
                               Substr(_cData,7,2)
        EndIf                    
 		MsUnLock()
	Else
		Alert("O parametro nao podera ficar com o conteudo vazio, a rotina sera finaliza sem sucesso !")
	Endif
ElseIf dbSeek("  "+_cParametro) 
	If !Empty(_cData)
		RecLock("SX6",.F.)
		If valtype(DataFun) !='D'                
		   SX6->X6_CONTEUD := _cData 
        Else	
		   SX6->X6_CONTEUD := Substr(_cData,1,4)+ ;
                              Substr(_cData,5,2)+ ;
                              Substr(_cData,7,2)
        EndIf                             
		MsUnLock()
	Else		
			Alert("O parametro nao podera ficar com o conteudo vazio, a rotina sera finaliza sem sucesso !")
	Endif
Else
	Alert("O parametro nao est� criado!")
EndIf	

Return
