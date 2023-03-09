#INCLUDE "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FA050FIN º Autor ³ Jose Carlos Noronhaº Data ³  06/08/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Ponto de Entrada na Rotina de Inclusao do Contas a Pagar   º±±
±±º          ³ para Alterar o Status dos Titulos Gerados Pelo PLS.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FA050FIN

Local aArea := GetArea()  
local _fluxo:=" "  

If Funname() == "PLSA470" .Or. LEFT(SE2->E2_ORIGEM,3)="PLS" //Somente para Titulos do PLS.
   
	dbSelectArea("SA2")
	dbSetOrder(1)
	
	Dbselectarea("SE2")
	_cPref := SE2->E2_PREFIXO
	_cNum  := SE2->E2_NUM    

	DbSetOrder(1)
	DbSelectArea("SE2")
	dbSeek(xFilial("SE2")+_cPref+_cNum)  
	
   if SA2->(dbSeek(xFilial("SA2")+SE2->(E2_FORNECE+E2_LOJA)))  
      If sa2->a2_yblqpls == 'S' .and. sa2->a2_tipo == 'J'
	     _fluxo := "N" 
	  ElseIf se2->e2_prefixo $ "AUX"
            _fluxo := "N"	                 
	      ELSE 
  	        _fluxo := "S"
	  EndIf                                        
   EndIf	  
	Do While E2_FILIAL+E2_PREFIXO+E2_NUM = xFilial("SE2")+_cPref+_cNum .And. !Eof()
		RecLock("SE2",.F.)
		SE2->E2_YLIBPLS := "N"     // Bloqueia Titulo do PLS no Momento da Geracao do Titulo  
		se2->e2_fluxo := _fluxo
		MSunlock()
		DbSkip()
	Enddo
Endif


RestArea(aArea)

Return

