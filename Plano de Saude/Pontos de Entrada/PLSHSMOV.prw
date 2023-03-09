#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLSHSMOV  �Autor  �Jean Schulz         � Data �  23/11/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para inserir filtro no botao de historico  ���
���          �do sistema, buscando auxiliar a consulta do contas medicas. ���
�������������������������������������������������������������������������͹��
���Uso       � MP8                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PLSHSMOV()

Local _nCont := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local _aCabMov	:= paramixb[1]
Local _cFilBD6	:= paramixb[2]
Local _aDadMov 	:= paramixb[3]  
Local _aVetTrab	:= paramixb[4]  

Local _cPerg	:= "YHSMOV"
Local cTpProDe	:= ""
Local cProcDe	:= ""
Local dDMovDe	:= ""
Local cTpProAt	:= ""
Local cProcAt	:= ""
Local dDMovAt	:= ""
Local aElemDel	:= {}
Local nContDel	:= 0

ParSX1(_cPerg)
If Pergunte(_cPerg,.T.)

	cTpProDe:= mv_par01
	cProcDe := mv_par02
	dDMovDe := mv_par05	
	cTpProAt:= mv_par03
	cProcAt := mv_par04
	dDMovAt := mv_par06

	//��������������������������������������������������������������Ŀ
	//� Filtra os casos e elimina os registros fora do intervalo...  �
	//����������������������������������������������������������������
	nContDel := 0 
	
	For _nCont := 1 to Len(_aDadMov)	
		
		//���������������������������������������������������������������Ŀ
		//�Leonardo Portella - 26/11/13 - Virada P11 - Inicio             �
		//�Na virada a BD6 foi dropada. Provavelmente ao recria-la, houve �
		//�alteracao na ordem dos seus campos, o que reflete neste ponto  �
		//�pois os vetores sao alimentados por store cols to no padrao.   �
		//�Manutencao para pegar a posicao dinamicamente ao inves de      �
		//�pegar chumbado.                                                �
		//�����������������������������������������������������������������
		
		nPosTpPro 	:= aScan(_aCabMov,{|x|AllTrim(x[2]) == 'BD6_CODPAD'})
		nPosProc	:= aScan(_aCabMov,{|x|AllTrim(x[2]) == 'BD6_CODPRO'})
		nPosDMov	:= aScan(_aCabMov,{|x|AllTrim(x[2]) == 'BD6_DATPRO'})
		
		If !((_aDadMov[_nCont,nPosTpPro] >= cTpProDe .And. _aDadMov[_nCont,nPosTpPro] <= cTpProAt) .And. ;
		   (_aDadMov[_nCont,nPosProc] >= cProcDe .And. _aDadMov[_nCont,nPosProc] <= cProcAt) .And. ;
		   (_aDadMov[_nCont,nPosDMov] >= dDMovDe .And. _aDadMov[_nCont,nPosDMov] <= dDMovAt))
		
		/*
		If !((_aDadMov[_nCont,5] >= cTpProDe .And. _aDadMov[_nCont,5] <= cTpProAt) .And. ;
		   (_aDadMov[_nCont,6] >= cProcDe .And. _aDadMov[_nCont,6] <= cProcAt) .And. ;
		   (_aDadMov[_nCont,17] >= dDMovDe .And. _aDadMov[_nCont,17] <= dDMovAt))
		*/ 
		
		//Leonardo Portella - 26/11/13 - Virada P11 - Fim
		
			aadd(aElemDel,_nCont)
			nContDel++

	    Endif 
	    
	Next

	_nCont := Len(aElemDel)
	
	While _nCont > 0
		aDel(_aDadMov,aElemDel[_nCont])
		_nCont--
	Enddo

	aSize(_aDadMov,Len(_aDadMov)-nContDel)	
	
	aElemDel := {}
		
Endif	

Return {_aDadMov,_aVetTrab}


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � ParSX1       �Autor  �Jean Schulz     � Data �  10/11/05   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria parametros para exportacao.                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ParSX1(cPerg)

Local _nCont := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

PutSx1(cPerg,"01",OemToAnsi("Cod Tp Proc De")   	 ,"","","mv_che","C",02,0,0,"G","","B41PLS","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Cod Proced De")   	     ,"","","mv_chf","C",16,0,0,"G","","YBR","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Cod Tp Proc Ate")  	 ,"","","mv_chg","C",02,0,0,"G","","B41PLS","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Cod Proced Ate")   	 ,"","","mv_chh","C",16,0,0,"G","","YBR","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Data Movto De")   		 ,"","","mv_chc","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("Data Movto Ate")  		 ,"","","mv_chd","D",08,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})


Return