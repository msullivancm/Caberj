#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"   
#Include "AP5MAIL.CH"
#Include "UTILIDADES.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � CABR170  � Autor � Paulo Motta           � Data �  nov/2014���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Gera Extrato dos Centros Medicos                           ���
���          � (via chamada de Stored Procedure) GERAR_EXTRATO_CENTRO_MED ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � CABERJ                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABR170

Static cPath	:= "\\srvdbp\backup\utl\"
Private cPerg	:= "CABR170"  

//������������������������������������������������������������������������Ŀ
//� Ajusta o Grupo de Perguntas                                            �
//��������������������������������������������������������������������������  
If cEmpAnt != "01"
  Return
Endif

AjustaSX1()

If !Pergunte(cPerG,.T.)
	Return
EndIf	       

Processa({||ExtMed()},"Extrato Centro Medico")   

Return

Static Function ExtMed()
	
//������������������������������������������������������������������������Ŀ
//� CHAMADA DA SP                                                          �
//��������������������������������������������������������������������������                   

ProcRegua(0)

For i := 0 to 5
	IncProc('Processando Extrato CM ...')
Next

cNomeArq	:= 'ExtratoCMed_' + AllTrim(mv_par01) + "_" + AllTrim(mv_par02) + "_" + AllTrim(mv_par03) +  '.txt'  
cArq		:= cPath + cNomeArq        
//Bianchini - 07/07/2020 - P12-R27 - Adequa��o de URL�s para MV�s
//cArqExp		:= "\\10.19.1.8\Protheus_Data\interface\exporta\ExtCM\" + cNomeArq
cArqExp		:= "\\"+AllTrim(GetMv("MV_XSRVTOP"))+"\Protheus_Data\interface\exporta\ExtCM\" + cNomeArq

cQuery := "BEGIN "				
cQuery += "GERAR_EXTRATO_CENTRO_MED("    
cQuery += " '" + mv_par01 + "',"  
cQuery += " '" + mv_par02 + "',"  
cQuery += " '" + mv_par03 + "'" 
cQuery += ");"
cQuery += "END; "					

If TcSqlExec(cQuery) <> 0	
	cErro := " - Erro na execu��o da procedure " + CRLF + Space(3) + cQuery + CRLF + Space(3) + 'TcSqlError [ ' + TcSqlError() + ' ]'
	QOut(cErro) 
	lOk := .F.      
Else                 
    If !MoveFile(cArq,cArqExp,.F.)
	  Alert("Erro na copia do arquivo !! ")   
    Else
      Alert("Arquivo Criado em interface\exporta\ExtCM ")
	EndIf	
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
aAdd(aHelp, "Informe 0 Centro Medico - 1-Tijuca,2-Niteroi,3-Bangu")         
PutSX1(cPerg , "01" , "CM" 			,"","","mv_ch1","C",1,0,0,"G",""	,,"","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Mes de Referencia")         
PutSX1(cPerg , "02" , "Mes Ref." 		,"","","mv_ch2","C",2,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o Ano de Referencia")         
PutSX1(cPerg , "03" , "Ano Ref"    	,"","","mv_ch3","C",4,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)
   
RestArea(aArea2)

Return   
