
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'        
#include "rwmake.ch"       // incluido pelo assistente de conversao do AP6 IDE em 08/09/03
#include "tbicode.ch"
#include "tbiconn.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³         ³ Autor ³                       ³ Data ³           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³                  ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Aplicacao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³                                               ³±±
±±³              ³  /  /  ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function caba140()

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
Private lSibBlo    := .F.
Private lSibInc    := .F.
Private lSibMuC    := .F.
Private lSibRea    := .F.
Private lSibRet    := .F. 
Private lSibFim    := .F.

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlg1","oGrp1","oCBox1","oCBox2","oCBox3","oCBox4","oCBox5","oCBox6","oPanel1","oBtn1","oBtn2")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
lSibInc := IIf(GetMv("MV_SIBINC")== 1 ,.T.,.F.)
lSibRet := IIf(GetMv("MV_SIBRET")== 1 ,.T.,.F.)
lSibBlo := IIf(GetMv("MV_SIBEXC")== 1 ,.T.,.F.)
lSibRea := IIf(GetMv("MV_SIBREA")== 1 ,.T.,.F.)
lSibMuc := IIf(GetMv("MV_SIBMUC")== 1 ,.T.,.F.)      
//lSibFim := IIf(GetMv("MV_SIBFIM")== 1 ,.T.,.F.)         
//lSibFim := GetMv("MV_SIBFIM")

oDlg1      := MSDialog():New( 203,574,465,845,"Controle Tipo de Envio Sib",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,092,116,"Controle Tipo de Envio Sib",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oCBox1     := TCheckBox():New( 012,004,"Envia Inclusão ",{|u| If(PCount()>0,lSibInc:=u,lSibInc)},oGrp1,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox2     := TCheckBox():New( 025,004,"Envia Retificação ",{|u| If(PCount()>0,lSibRet:=u,lSibRet)},oGrp1,063,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox3     := TCheckBox():New( 038,004,"Envia Bloqueio ",{|u| If(PCount()>0,lSibBlo:=u,lSibBlo)},oGrp1,063,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox4     := TCheckBox():New( 051,004,"Envia Reativação ",{|u| If(PCount()>0,lSibRea:=u,lSibRea)},oGrp1,063,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox5     := TCheckBox():New( 064,004,"Envia Mudaça Contratual ",{|u| If(PCount()>0,lSibMuc:=u,lSibMuc)},oGrp1,085,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
//oCBox6     := TCheckBox():New( 076,004,"Consid. Criticas Sib Nao",{|u| If(PCount()>0,lSibFim:=u,lSibFim)},oGrp1,096,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oPanel1    := TPanel():New( 096,000," ",oDlg1,,.F.,.F.,,,116,024,.T.,.F. )    
oBtn1      := TButton():New( 004,004,"Confirma",oPanel1,{||fGrvparam(), oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 004,072,"Cancela",oPanel1,{||oDlg1:End()},037,012,,,,.T.,,"",,,,.F. ) 


/*
oDlg1      := MSDialog():New( 203,574,430,820,"Controle Envio Sib Global",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 000,000,076,116,"Seleção Envio Sib Global",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oCBox1     := TCheckBox():New( 012,004,"Envia Inclusão "         ,{|u| If(PCount()>0,lSibInc:=u,lSibInc)},oGrp1,048,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox2     := TCheckBox():New( 025,004,"Envia Retificação "      ,{|u| If(PCount()>0,lSibRet:=u,lSibRet)},oGrp1,063,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox3     := TCheckBox():New( 038,004,"Envia Bloqueio "         ,{|u| If(PCount()>0,lSibBlo:=u,lSibBlo)},oGrp1,063,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox4     := TCheckBox():New( 051,004,"Envia Reativação "       ,{|u| If(PCount()>0,lSibRea:=u,lSibRea)},oGrp1,063,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oCBox5     := TCheckBox():New( 064,004,"Envia Mudaça Contratual ",{|u| If(PCount()>0,lSibMuC:=u,lSibMuC)},oGrp1,085,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, ) 
oCBox6     := TCheckBox():New( 077,004,"Consid. Criticas Sib Nao",{|u| If(PCount()>0,lSibMuC:=u,lSibMuC)},oGrp1,085,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
oPanel1    := TPanel():New( 080,000," ",oDlg1,,.F.,.F.,,,116,024,.T.,.F. )
oBtn1      := TButton():New( 004,004,"Confirma",oPanel1,{||fGrvparam(), oDlg1:End()},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 004,072,"Cancela",oPanel1,{||oDlg1:End()},037,012,,,,.T.,,"",,,,.F. ) 
*/                                                                                                           
oDlg1:Activate(,,,.T.)




static Function fGrvparam()    
 

DbSelectArea("SX6")
DbSetOrder(1)
If DbSeek('  '+"MV_SIBINC")
   RecLock("SX6",.F.)
     SX6->X6_CONTEUD :=  iif(lSibInc,'1','2')
   MsUnLock()
Endif

If DbSeek('  '+"MV_SIBRET")
   RecLock("SX6",.F.)
  	 SX6->X6_CONTEUD :=  iif(lSibRet,'1','2')
   MsUnLock()
Endif 

If DbSeek('  '+"MV_SIBEXC")
   RecLock("SX6",.F.)
  	 SX6->X6_CONTEUD :=  iif(lSibBlo,'1','2')
   MsUnLock()
Endif
     
If DbSeek('  '+"MV_SIBREA")
   RecLock("SX6",.F.)
  	 SX6->X6_CONTEUD :=  iif(lSibRea,'1','2')
   MsUnLock()
Endif 

If DbSeek('  '+"MV_SIBMUC")
   RecLock("SX6",.F.)
  	 SX6->X6_CONTEUD :=  iif(lSibMuc,'1','2')
   MsUnLock()
Endif 
/*
If DbSeek('  '+"MV_SIBFIM")
   RecLock("SX6",.F.)
  	 SX6->X6_CONTEUD :=  iif(lSibFim,'1','2')
   MsUnLock()
Endif
*/
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
/| DESCRICAO | Funcao utilizada para alteração do conteúdo dos parâmetros      |/
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
		Aadd(aMsg,{"O Parametro "+aParam[i]+" não existe"+CHR(13)+CHR(10)})
	EndIf

Next
If !nCont = Len(aParam) 
	For i := 1 To Len(aMsg)
		cMensagem += (aMsg[i][1])
	Next
   	Aviso("Aviso",cMensagem,{"Ok"},1,"Parâmetro Inexistente")
   //	Alert(cMensagem)
	Return
EndIf	                                                              

_cCont1 := GetMv("MV_SIBINC")
_cCont2 := GetMv("MV_SIBRET")
_cCont3 := GetMv("MV_SIBEXC")
_cCont4 := GetMv("MV_SIBREA")
_cCont5 := GetMv("MV_SIBMUC")
                               
@ 146,243 To 420,547 Dialog Dlg01 Title OemToAnsi("Envia SIB Global ")
@ 013,008 To 120,138 Title OemToAnsi("Informe o conteudo  1 - Sim  2 - Não")
//@ 020,017 Say OemToAnsi("Ativo Fixo")  Size 068,008          
@ 020,017 Say OemToAnsi("Inclusao  ")  Size 068,008
@ 034,017 Say OemToAnsi("Retificaççao")  Size 068,008
@ 048,017 Say OemToAnsi("Bloqueio ")      Size 068,008
@ 062,017 Say OemToAnsi("Reativação ")Size 068,008
@ 076,017 Say OemToAnsi("Mudança Contratual ") Size 068,008   
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
||ºPrograma: fMudaParam      Autor: Erisson Diniz          Data: 17/11/06  ||
||=========================================================================||
||ºDescricao: Função Utilizada alterar as datas dos parametros existentes  ||
||               No Vetor aParam                                           ||
||=========================================================================||
||ºUso       ³ MMXALTDATA                                                  ||
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
	Alert("O parametro nao está criado!")
EndIf	

Return
*/