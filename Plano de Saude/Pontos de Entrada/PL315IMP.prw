
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PL315IMP  �Motta  �Microsiga           � Data �  29/06/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �  PE CHAMADO ANTES DA EXECUCAO DA ROTINA DE IMPRESSAO DOS   ���
���          �  ATESTADOS MEDICOS/DECLARA��O DE COMPARECIMENTO            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/ 

User Function PL315IMP

Private cCRPar      := "1;0;1;" 
Private cParam1     := "" 
Private cCrystal    := ""   

/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde 
  x = v�deo(1) ou impressora(3) 
  y = Atualiza(0) ou n�o(1) os dados
  z = N�mero de c�pias 
  w = T�tulo do relatorio.
*/
    
cParam1 := BBD->BBD_NUMATE    

If MV_PAR07 == "Atendimento" 
  cCRPar      :="1;0;1;Atestado M�dico" 
  cCrystal    := "atestm"   
Else
  If MV_PAR07 == "Comparecimento" 
    cCRPar      :="1;0;1;Declara��o de Comparecimento" 
    cCrystal    := "decomp"   
  Endif
Endif  
  
If cCrystal <> ""
  CallCrys(cCrystal,cParam1,cCRPar) 
Endif

Return