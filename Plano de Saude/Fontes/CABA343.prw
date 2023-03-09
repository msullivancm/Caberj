#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA343   �Autor  �Motta               � Data �  out/15     ���
�������������������������������������������������������������������������͹��
���Desc.     � Fonte que sera responsavel pelo pagamento da Audimed  .    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function C343ZRV()   

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "ZRV"

dbSelectArea("ZRV")
dbSetOrder(1)

AxCadastro(cString,"Vl. Base Remunuracao Audit. Med.",cVldExc,cVldAlt)

Return  

User Function C343ZRX()   

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "ZRX"

dbSelectArea("ZRX")
dbSetOrder(1)

AxCadastro(cString,"Vl. Pagamento  Audit. Med.",cVldExc,cVldAlt)

Return       

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � C343SP   � Autor � Paulo Motta           � Data �  nov/2015���
�������������������������������������������������������������������������Ĵ��
���Descri��o � EXECUTA SP PARA CALCULO DO PAGAMENTO AUDITORIA MEDICA      ���
���          � (chamada de Stored Procedure) CALCULA_REMUNERACAO_AUDITMED ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � CABERJ                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function C343SP

Static cPath	:= "\\srvdbp\backup\utl\"
Private cPerg	:= "C343SP"  

//������������������������������������������������������������������������Ŀ
//� Ajusta o Grupo de Perguntas                                            �
//��������������������������������������������������������������������������  

AjustaSX1()

If !Pergunte(cPerG,.T.)
	Return
EndIf	       

Processa({||ExtMed()},"Calcula Remuneracao Auditmed")   

Return

Static Function ExtMed()          

Private cCRPar      := "1;0;1;Relat�rio Audimed" 
Private cParam1     := " " 
Private cCrystal    := "DEMAUD"     

Private cEmpRel       := " "
	
//������������������������������������������������������������������������Ŀ
//� CHAMADA DA SP                                                          �
//��������������������������������������������������������������������������                   

ProcRegua(0)

For i := 0 to 5
	IncProc('Processando Calulo Audimed ...')
Next

cQuery := "BEGIN "				
cQuery += "CALCULA_REMUNERACAO_AUDITMED("    
cQuery += " '" + cEmpAnt  + "',"  
cQuery += " '" + mv_par01 + "',"  
cQuery += " '" + mv_par02 + "',"  
cQuery += " '" + mv_par03 + "',"  
cQuery += " '" + mv_par04 + "'" 
cQuery += ");"
cQuery += "END; "		 

cEmpRel := Substr(cEmpAnt,2,1)			


If TcSqlExec(cQuery) <> 0	
	cErro := " - Erro na execu��o da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
	Alert(cErro)    
Else
    If MsgYesNo("Rotina Executada com sucesso , Emite Relatorio ? ")      
   	  cParam1 :=  cEmpRel+";"+Dtoc(SToD(mv_par04+mv_par03+'01'))+";"+mv_par01+";"+iif(Empty(mv_par02),'T',mv_par02)
      CallCrys(cCrystal,cParam1,cCRPar)   
   	Endif               
EndIf       

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � AjustaSX1� Autor � Paulo Motta                             ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ajusta as perguntas do SX1                                 ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()  

aHelp := {}
aAdd(aHelp, "Informe a rda")         
PutSX1(cPerg , "01" , "RDA" 			,"","","mv_ch1","C",6,0,0,"G",""	,"BAUPLS","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}   
If cEmpAnt = "01" 
  aAdd(aHelp, "Informe Grupo De Empresa (1-Mater/Afin;2-Pref;3-Estaleiros;4-Demais), BRANCO para todos ")         
Else        
  aAdd(aHelp, "Informe Grupo De Empresa, BRANCO para todos ")   
Endif
PutSX1(cPerg , "02" , "Grupo Emp." 		,"","","mv_ch2","C",1,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Mes de Referencia")         
PutSX1(cPerg , "03" , "Mes Ref." 		,"","","mv_ch3","C",2,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Ano de Referencia")         
PutSX1(cPerg , "04" , "Ano Ref"    	,"","","mv_ch4","C",4,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
   
RestArea(aArea2)

Return 