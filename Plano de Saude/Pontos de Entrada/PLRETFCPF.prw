#Include "Topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLRETFCPF �Autor  �Microsiga           � Data �  04/30/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Trata parametrizacao de tipo de faturamento (folha x financ)���
���          �quando a familia esta bloqueada.                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User function PLRETFCPF()   
Local aRet := {paramixb[10,1],paramixb[10,2]}
Local aAreaSRA := SRA->(GetArea("SRA"))  
**'Marcela Coimbra'**

Local cCodInt := paramixb[1] //C�digo Operadora da Fam�lia
Local cCodEmp := paramixb[2] //C�digo do Grupo empresa da Fam�lia
Local cNumCon := paramixb[3] //C�digo do Contrato da Fam�lia sendo a mesma PJ
Local cVerCon := paramixb[4] //C�digo da Vers�o do Contrato da Fam�lia sendo a mesma PJ
Local cSubCon := paramixb[5] //C�digo do SubContrato da Fam�lia sendo a mesma PJ
Local cVerSub := paramixb[6] //C�digo da Vers�o do SubCOntrato da Fam�lia sendo a mesma PJ
Local cCodPla := paramixb[7] //C�digo do Plano da Fam�lia
Local cVerPla := paramixb[8] //Vers�o do Plano da Fam�lia
Local cTipoUs := paramixb[9] //Tipo do Usu�rio 1=PF ou 2=PJ
 

If Type( "xx_aRecBBt" ) == "U"
     
	Public xx_aRecBBt := {} 

EndIf                 

**'Fim Marcela Coimbra'**


//��������������������������������������������������������������������Ŀ
//� Caso seja folha e corresponda as regras, gerar titulo financeiro...�
//����������������������������������������������������������������������
If paramixb[10,2] == "3" 

	//���������������������������������������������������������������������Ŀ
	//� Regra: caso bloqueado no PLS ou afastado / demitido, nao gera folha.�
	//� Importante: regra do perc. desconto no fonte CALCDCAB.PRW.          �	    
   //� Verificar tamb�m caso Afastado  se a situa��o de afstamento � para  |
   //| gerar boleto ou n�o                                                 �	
	//�����������������������������������������������������������������������	
	SRA->(DbSetOrder(1)) //RA_FILIAL+RA_MAT
	If Posicione("SRA",1,xFilial("SRA")+BA3->BA3_AGMTFU,"RA_SITFOLH") $ GetNewPar("MV_YFLHFI","A,D")
	  If SRA->RA_SITFOLH $ GetNewPar("MV_YFLHF2","A")
	    If SRA->RA_AFASFGT $ GetNewPar("MV_YFLHF3","O,P,1")
	      	aRet[2] := "2"
	    Endif  	
	  Else
		aRet[2] := "2"
	  Endif			
	Else
		If !Empty(BA3->BA3_DATBLO) .And. Alltrim(Funname())=="PLSA627"
			If M->(BDC_ANOINI+BDC_MESINI) > Substr(DtoS(BA3->BA3_DATBLO),1,6)     
			  If BA3->BA3_DATBLO != CTOD("31/12/2011") //tratar quest�o do bloquio para a Integral
				   aRet[2] := "2" 
			  Endif					   			
			Endif
		Endif
	Endif
	
	RestArea(aAreaSRA)
	
Endif   
   

**'Marcela Coimbra '**
aRet[1] := "2"   // Para n�o voltar um mes no lote de custo operacional
	
Return aRet