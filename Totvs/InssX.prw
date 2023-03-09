#include "Protheus.ch" 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �INSSX     �Autor  �Haroldo Vilela      � Data �  07/29/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que pega o resultado da tabela PAA (Plano X Valores) ���
���          �por M�s e Ano. Esses valores ser�o integrados ao Excel      ���
�������������������������������������������������������������������������͹��
���Uso       � Contabilidade Gerencial                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User function InssX(Mes,Ano,Emp)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aRet     	:= {}
Local _cQry		:= "" 
Local _Valor	:= ""
Local _Plano	:= ""
Default Mes		:= "01"
Default Ano		:= "2009"
Default Emp		:= "I"

If Alltrim( Emp ) == "C" .or. Alltrim( Emp ) == "c"//Caberj
	Emp := "PAA010"
ElseIf Alltrim( Emp ) == "I" .or. Alltrim( Emp ) == "i"//Integral
	Emp := "PAA020"
Else
	Return
Endif


  _cQry := ""
  _cQry += " SELECT * " + CRLF
  _cQry += " FROM " + Emp + CRLF
  _cQry += " WHERE PAA_ANO='" + ANO + "'" + CRLF
  _cQry += " AND PAA_MES='" + MES + "'" + CRLF
  _cQry += " ORDER BY PAA_PLANO"
  
  If ( Select ( "cTemp" ) <> 0 )
	dbSelectArea ( "cTemp" )
	dbCloseArea ()
  Endif

  dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQry),"cTemp",.T.,.F.)

If cTemp->(!eof())
	do While cTemp->(!eof())
		_Valor := Alltrim(StrTran(cTemp->PAA_VALOR,"'",""))
		_Plano := Alltrim(StrTran(cTemp->PAA_PLANO,"'",""))
		aAdd(aRet,{_Plano,_Valor})
		DbSkip()
	Enddo
	DbSelectArea("cTemp")
	DbCloseArea("cTemp")
Else
	_Valor := ""
	_Plano := ""
    aAdd(aRet,{"N�o Existe Valores de INSS gerado para esse periodo","� preciso rodar a rotina de calculo de INSS!!!"})
    For nI := 1 To 40
	aAdd(aRet,{_Plano,_Valor})    
	Next
Endif 

  		
Return aRet