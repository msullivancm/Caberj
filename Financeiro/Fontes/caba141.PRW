#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'        
#include "rwmake.ch"       // incluido pelo assistente de conversao do AP6 IDE em 08/09/03
#include "tbicode.ch"
#include "tbiconn.ch"  
#include "topconn.ch"     

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �         � Autor �                       � Data �           ���
�������������������������������������������������������������������������Ĵ��
���Locacao   �                  �Contato �                                ���
�������������������������������������������������������������������������Ĵ��
���Descricao �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Aplicacao �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Analista Resp.�  Data  �                                               ���
�������������������������������������������������������������������������Ĵ��
���              �  /  /  �                                               ���
���              �  /  /  �                                               ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

User Function caba141()

/*������������������������������������������������������������������������ٱ�
�� Declara��o de cVariable dos componentes                                 ��
ٱ�������������������������������������������������������������������������*/
Private cRepIntnov := GetNewPar('MV_XREPINT','201402')//Repasse Integral. Periodo de corte 2014/01 informado pelo Alan  := .F.
Private cRepIntatu := GetNewPar('MV_XREPINT','201402')

/*������������������������������������������������������������������������ٱ�
�� Declara��o de Variaveis Private dos Objetos                             ��
ٱ�������������������������������������������������������������������������*/
SetPrvt("oDlg1","oGrp1","oSay1","oSay3","oGet1","oGet2","oPanel1","oBtn1","oBtn2")

/*������������������������������������������������������������������������ٱ�
�� Definicao do Dialog e todos os seus componentes.                        ��
ٱ�������������������������������������������������������������������������*/
oDlg1      := MSDialog():New( 203,574,430,952,"Competencia de Custo Integral Cobran�a",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,076,180,"Informar Compet�ncia de Custo para repasse ",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 020,008,{||"Atual Comptencoia (AAAAMM)"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,008)
oSay3      := TSay():New( 037,009,{||"Nova Comptencoia (AAAAMM)"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,008)
oGet1      := TGet():New( 020,088,{|u| If(PCount()>0,cRepIntatu:=u,cRepIntatu)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cRepIntatu",,)
oGet2      := TGet():New( 037,089,{|u| If(PCount()>0,cRepIntnov:=u,cRepIntnov)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cRepIntnov",,)
oPanel1    := TPanel():New( 080,000," ",oDlg1,,.F.,.F.,,,180,024,.T.,.F. )
oBtn1      := TButton():New( 004,004,"Confirma",oPanel1,{||fGrvparam(), oDlg1:End()},056,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 004,120,"Cancela",oPanel1,{||oDlg1:End()},053,012,,,,.T.,,"",,,,.F. )       


oDlg1:Activate(,,,.T.)

Return()


static Function fGrvparam()    
 
If  cRepIntnov == cRepIntatu    

	    MsgAlert("N�o houve Altera��o , o Parametro novo  "+cRepIntnov+" � igual ao atual "+cRepIntatu+".","Atencao!")     

    Return()
 
EndIF 
  
DbSelectArea("SX6")
DbSetOrder(1)

If DbSeek('  '+"MV_XREPINT")
   RecLock("SX6",.F.)
     SX6->X6_CONTEUD := cRepIntnov
   MsUnLock()
Endif

dbCloseArea("SX6")  

Return()
////////
 /*
#include "rwmake.ch"       // incluido pelo assistente de conversao do AP6 IDE em 08/09/03
#include "tbicode.ch"
#include "tbiconn.ch"
/*-----------------------------------------------------------------------------+/
/------------------------------------------------------------------------------+/
/| PROGRAMA  | caba106      | AUTOR | altamiro  | Data | 05/01/2011            |/
/+-----------------------------------------------------------------------------+/
/| DESCRICAO | Funcao utilizada para altera��o do conte�do dos par�metros      |/
/|           |  controlar quais o que sera enviados no sib global  			   |/
/+-----------------------------------------------------------------------------+/
/| MANUTENCAO DESDE SUA CRIACAO                                                |/
/+-----------------------------------------------------------------------------+/
/| DATA     | AUTOR                | DESCRICAO                                 |/
/+-----------------------------------------------------------------------------+/
/+-----------------------------------------------------------------------------*/


//User Function caba140() 

//Prepare Environment Empresa "99" Filial "01"

// A Rotina encontra-se no Modulo de financeiro - fontes  
  /*
Local cMensagem := ""
Local nCont     := 0
Local aMsg      := {} 

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private _cCont1,_cCont2,_cCont3,_cCont4,_cCont5
//Private aParam := {"MV_ULTDEPR","MV_DATAFIN","MV_DATAFIS","MV_DATAREC","MV_ULMES"} 
//Private aParam := {"MV_DATAFIN","MV_DATAFIS","MV_DATAREC","MV_ULMES"} 
Private aParam := {"MV_SIBINC","MV_SIBRET","MV_SIBEXC","MV_SIBREA","MV_SIBMUC"}
    

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

_cCont1 := GetMv("MV_SIBINC")
_cCont2 := GetMv("MV_SIBRET")
_cCont3 := GetMv("MV_SIBEXC")
_cCont4 := GetMv("MV_SIBREA")
_cCont5 := GetMv("MV_SIBMUC")
                               
@ 146,243 To 420,547 Dialog Dlg01 Title OemToAnsi("Envia SIB Global ")
@ 013,008 To 120,138 Title OemToAnsi("Informe o conteudo  1 - Sim  2 - N�o")
//@ 020,017 Say OemToAnsi("Ativo Fixo")  Size 068,008          
@ 020,017 Say OemToAnsi("Inclusao  ")  Size 068,008
@ 034,017 Say OemToAnsi("Retifica��ao")  Size 068,008
@ 048,017 Say OemToAnsi("Bloqueio ")      Size 068,008
@ 062,017 Say OemToAnsi("Reativa��o ")Size 068,008
@ 076,017 Say OemToAnsi("Mudan�a Contratual ") Size 068,008   
@ 020,089 Get _cCont1                  Size 038,010   
@ 034,089 Get _cCont2                  Size 038,010
@ 048,089 Get _cCont3                  Size 038,010
@ 062,089 Get _cCont4                  Size 038,010
@ 076,089 Get _cCont5                  Size 038,010
@ 095,30 Button OemToAnsi("_Confirma") Size 030,012 Action fChamaFunc()// Substituido pelo assistente de conversao do AP6 IDE em 08/09/03 ==>      @ 065,009 Button OemToAnsi("_Confirma") Size 036,016 Action Execute(fMudaParam)
@ 095,78 Button OemToAnsi("C_ancela")  Size 030,012 Action Close(Dlg01)   

Activate Dialog Dlg01 Centered

Return 

****************************           
Static Function fChamaFunc 
****************************

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//aData := {_cCont1,_cCont2,_cCont3,_cCont4,_cCont5} 
aData := {_cCont1,_cCont2,_cCont3,_cCont4,_cCont5}
For i := 1 To Len(aParam)    
 	FMudaParam(aData[i],aParam[i])                                          
Next                                                                       
Close(Dlg01)
Return

/*/  
/*
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
*/
/*/
*******************
Static Function fMudaParam(_Conteudo,Parametro)
*******************
//_cData      := Dtos(DataFun)
_cParametro := Parametro
DbSelectArea("SX6")
DbSetOrder(1)
If DbSeek(cFilAnt+_cParametro)
	If !Empty(_Conteudo)
		RecLock("SX6",.F.)
		SX6->X6_CONTEUD := str(_Conteudo)
 		MsUnLock()
	Else
		Alert("O parametro nao podera ficar com o conteudo vazio, a rotina sera finaliza sem sucesso !")
	Endif
ElseIf dbSeek("  "+_cParametro) 
	If !Empty(_Conteudo)
		RecLock("SX6",.F.)
		SX6->X6_CONTEUD := str(_Conteudo)
		MsUnLock()
	Else		
			Alert("O parametro nao podera ficar com o conteudo vazio, a rotina sera finaliza sem sucesso !")
	Endif
Else
	Alert("O parametro nao est� criado!")
EndIf	

Return
*/