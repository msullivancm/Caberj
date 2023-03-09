
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL315IMP  ºMotta  ³Microsiga           º Data ³  29/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  PE CHAMADO ANTES DA EXECUCAO DA ROTINA DE IMPRESSAO DOS   º±±
±±º          ³  ATESTADOS MEDICOS/DECLARAÇÃO DE COMPARECIMENTO            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 

User Function PL315IMP

Private cCRPar      := "1;0;1;" 
Private cParam1     := "" 
Private cCrystal    := ""   

/*Conjunto de opções para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde 
  x = vídeo(1) ou impressora(3) 
  y = Atualiza(0) ou não(1) os dados
  z = Número de cópias 
  w = Título do relatorio.
*/
    
cParam1 := BBD->BBD_NUMATE    

If MV_PAR07 == "Atendimento" 
  cCRPar      :="1;0;1;Atestado Médico" 
  cCrystal    := "atestm"   
Else
  If MV_PAR07 == "Comparecimento" 
    cCRPar      :="1;0;1;Declaração de Comparecimento" 
    cCrystal    := "decomp"   
  Endif
Endif  
  
If cCrystal <> ""
  CallCrys(cCrystal,cParam1,cCRPar) 
Endif

Return