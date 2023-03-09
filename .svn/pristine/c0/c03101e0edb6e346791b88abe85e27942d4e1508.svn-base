#INCLUDE "Protheus.ch"   
#INCLUDE "RWMake.ch"   
#include "TBICONN.CH"


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³KTRAFSCP   º Autor ³ SERGIO CUNHA		   º Data ³ 18/04/2016º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ TELA SELEÇÃO KIT PROTOCOLO DE ENTREGA CONTLIVRO   		  º±±
±±º          ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³  IDE                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºAlteração ³         ºAutor  ³                   º Data ³    /  /       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
                          
user Function tsttela()
  //	Prepare Environment Empresa "01" Filial "01"
alert(U_uchmarca()  )
 //	RESET ENVIRONMENT
return                                                         	

User Function uchmarca()  

Local cRet			:= ''

Private lCheck1 	:= .F.
Private lCheck2 	:= .F.
Private lCheck3 	:= .F.
Private lCheck4 	:= .F.
Private lCheck5 	:= .F. 
Private lConfirmou 	:= .F.
SetPrvt("oDlg1","oGrp1","oGrp2")

DEFINE DIALOG oDlg TITLE "KIT" FROM 180,180 TO 390,470 PIXEL
 
   lCheck := .T.    // Usando New           
   
   oGrp1      := TGroup():New(02,002,70,140,"COMPOSIÇÃO KIT",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )		
   oCheck1 := TCheckBox():New(11,03,'CARTA BERÇO',{|u|if(PCount()>0,lCheck1:=u,lCheck1)} ,oDlg,100,210,,,,,,,,.T.,,,)    
   oCheck2 := TCheckBox():New(21,03,"CARTEIRA",{|u|if(PCount()>0,lCheck2:=u,lCheck2)} ,oDlg,100,210,,,,,,,,.T.,,,)
   oCheck3 := TCheckBox():New(31,03,'REGULAMENTO',{|u|if(PCount()>0,lCheck3:=u,lCheck3)} ,oDlg,100,210,,,,,,,,.T.,,,)
   oCheck4 := TCheckBox():New(41,03,'ORIENTADOR',{|u|if(PCount()>0,lCheck4:=u,lCheck4)} ,oDlg,100,210,,,,,,,,.T.,,,)
   oCheck5 := TCheckBox():New(51,03,'IMÃ',{|u|if(PCount()>0,lCheck5:=u,lCheck5)} ,oDlg,100,210,,,,,,,,.T.,,,) 
   
   oGrp2      := TGroup():New( 85, 85,30,140,"OPERAÇÃO",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )	
   oTButton1 := TButton():New( 80, 005, "MARCAR",oDlg,{ || MarcTod()}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )    
   oTButton2 := TButton():New( 80, 055, "DESMARCAR ",oDlg,{ || Desmarc()}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )       
   oTButton3 := TButton():New( 80, 105, "CONFIRMAR ",oDlg,{ || lConfirmou := .T., oDlg:End()}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )

ACTIVATE DIALOG oDlg CENTERED 

If lConfirmou
  
   //	Alert('Confirmou')  
	
	If lCheck1
	   	cRet += 'CARTA BERCO, '

	EndIf

	If lCheck2
	    cRet += 'CARTEIRA, '
	
	EndIf

	If lCheck3
	   	cRet += 'REGULAMENTO, '

	EndIf
		
	If lCheck4
	   	cRet += 'ORIENTADOR, '

	EndIf
		
	If lCheck5
	   	cRet += 'IMA, '

	EndIf   
	
	If Empty(cRet)
	  	Alert("Nenhuma opção selecionada.")  
	  	Return u_uchmarca()
	  	
	EndIf 
	
Else
   
	Alert("Nenhuma opção selecionada.")   
	Return u_uchmarca()
	
EndIf   

cRet := SUBSTR(cRet, 1, LEN(cRet) - 2 )
 
Return cRet

***************************************

Static Function Desmarc()

lCheck1 := .F.
lCheck2 := .F.
lCheck3 := .F.
lCheck4 := .F.
lCheck5 := .F.

oDlg:Refresh()

Return

***************************************

Static Function MarcTod()

lCheck1 := .T.
lCheck2 := .T.
lCheck3 := .T.
lCheck4 := .T.
lCheck5 := .T.

oDlg:Refresh()

Return

***************************************

// ----------------------------------------------------
// Funcao refente ao botao : AcaoBt()
// ---------------------------------------------------

Static Function AcaoBt()

Alert("Acao do Botão")

Return
			 
Return