#include "protheus.ch"
#include "topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AXCADSZS  �Autor  �Roger Cangianeli    � Data �  13/07/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Log dos registros corretos da contabilizacao do PLS.       ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������͹��
���Alteracoes� 13/07/06 -Incl.filtros para expressoes na exportacao.RC    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function AXCADSZS()

LOCAL _aArea	:= GetArea()

dbSelectARea("SZS")
dbSetOrder(1)

aRotina   := {	{"Pesquisar" ,"AxPesqui",0,1} ,;
{"Visualizar","AxVisual",0,2} ,;
{"Exportar"  ,"U_EXPSZS",0,5} }

cCadastro := OemToAnsi("Log Contabiliza��o Correta do PLS")

mBrowse(06,01,22,75,'SZS',,)

RestArea(_aArea)

Return




User Function EXPSZS()
Local cFile
If Aviso('Exporta��o de Log','Confirma exporta��o de log para arquivo?',{"Prosseguir","Cancelar"},1,"Escolha") == 2
	Return
EndIf

cFile := cGetFile("Arquivos Texto|*.TXT",OemToAnsi("Salvar Arquivo Como..."))

If !Empty(cFile)
	MsAguarde({|| fRunExp(cFile) }, "Exportando arquivo...", "", .T.)
EndIf

Return



Static Function fRunExp(cFile)
Local aDatas	:= {}
LOCAL _lErroArq	:= .F.

aDatas	:= fPergData()
If aDatas[1] == Ctod('01/01/1980') .and. aDatas[2]== Ctod('01/01/1980') .and. aDatas[5] == 'RETURN'
	Aviso('Aviso','Rotina cancelada pelo usu�rio.',{"Ok"},2,"")
	Return
EndIf

If !File(cFile)
	nHand	:= fCreate(cFile, 1)
Else
	nHand	:= fOpen(cFile, 2)
EndIf

// Posiciona no final do arquivo para fazer a gravacao
fSeek(nHand, 0, 2)



// Executa query para filtrar dados a exportar
cQuery	:= "SELECT ZS_DATA, ZS_HORA, ZS_LOG, ZS_LOG1 FROM "+RetSqlName("SZS")+" "
cQuery	+= "WHERE ZS_FILIAL = '"+xFilial('SZS')+"' AND D_E_L_E_T_ = '' "
cQuery	+= "AND ZS_DATA >= '"+DtoS(aDatas[1])+"' AND ZS_DATA <= '"+DtoS(aDatas[2])+"' "
cQuery	+= "AND ZS_HORA >= '"+Subs(aDatas[3],1,2)+":"+Subs(aDatas[3],3,2)+":"+Subs(aDatas[3],5,2)+"' "
cQuery	+= "AND ZS_HORA <= '"+Subs(aDatas[4],1,2)+":"+Subs(aDatas[4],3,2)+":"+Subs(aDatas[4],5,2)+"' "
If !Empty(aDatas[5])
	cQuery	+= "AND ZS_LOG||ZS_LOG1 LIKE '%"+  AllTrim(aDatas[5]) +"%' "
EndIf
cQuery	+= "ORDER BY ZS_FILIAL, ZS_DATA, ZS_HORA "
cQuery	:= ChangeQuery(cQuery)
PlsQuery(cQuery,'TRB')


dbSelectArea('TRB')
ProcRegua(RecCount())
dbGoTop()
If Eof()
	_lErroArq	:= .T.	
Else
While !Eof()
	IncProc()
	// Efetua gravacao do arquivo
	fWrite(nHand, CHR(10)+Dtoc(TRB->ZS_DATA)+'|'+TRB->ZS_HORA+'|'+TRB->ZS_LOG+TRB->ZS_LOG1)
	dbSkip()
End
EndIf

dbCloseArea()

// Fecha arquivo
If !fClose(nHand)
	Aviso('Aten��o','Erro ao fechar o arquivo.',{"Ok"},2,"")
Else
	If !_lErroArq	
	Aviso('Fim de processamento','Arquivo gerado com sucesso.'+CHR(13)+cFile,{"Ok"},2,"")
	Else
	Aviso('Aten��o','N�o foram encontrados dados para gera��o do arquivo.'+CHR(13)+cFile,{"Ok"},2,"")
	EndIf
EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fPergData �Autor  �Roger/Clarice       � Data �  09/06/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


Static Function fPergData()
Local _dDataDe  := Date()
Local _dDataAte := Date()
Local _cHoraDe  := "000000"
Local _cHoraAte := "235959"
Local _cExp		:= Space(20)
Local bCanc    	:= {|| _oDlg:End(), _dDataDe:=CtoD('01/01/1980'), _dDataAte:=CtoD('01/01/1980'), _cHoraDe:="000000", _cHoraAte:="235959",_cExp:='RETURN'}

DEFINE MSDIALOG _oDlg TITLE OemtoAnsi("Exporta��o de Log") FROM C(100),C(100) TO C(300),C(300) PIXEL


// Cria Componentes Padroes do Sistema
@ C(006),C(012) Say "Digite o per�odo que deseja exportar" Size C(133),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(015),C(012) Say "Data de:" Size C(022),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(015),C(040) MsGet oEdit1 Var _dDataDe 	Size C(032),C(009) COLOR CLR_BLACK PIXEL OF _oDlg Picture "@D" Valid .T.
@ C(028),C(012) Say "Data At�:" Size C(022),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(028),C(040) MsGet oEdit2 Var _dDataAte	Size C(032),C(009) COLOR CLR_BLACK PIXEL OF _oDlg Picture "@D" Valid .T.
@ C(041),C(012) Say "Hora de:" Size C(022),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(041),C(040) MsGet oEdit1 Var _cHoraDe 	Size C(032),C(009) COLOR CLR_BLACK PIXEL OF _oDlg Picture "@R 99:99:99" Valid .T.
@ C(054),C(012) Say "Hora At�:" Size C(022),C(008) COLOR CLR_BLACK PIXEL OF _oDlg                             
@ C(054),C(040) MsGet oEdit2 Var _cHoraAte	Size C(032),C(009) COLOR CLR_BLACK PIXEL OF _oDlg Picture "@R 99:99:99" Valid .T.
@ C(067),C(012) Say "Expressao:" Size C(022),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(067),C(040) MsGet oEdit2 Var _cExp	Size C(042),C(009) COLOR CLR_BLACK PIXEL OF _oDlg Valid .T.

DEFINE SBUTTON FROM C(084),C(053) TYPE 1 ENABLE OF _oDlg ACTION (_oDlg:End())
DEFINE SBUTTON FROM C(084),C(075) TYPE 2 ENABLE OF _oDlg ACTION ( Eval(bCanc) )

ACTIVATE MSDIALOG _oDlg CENTERED

Return({_dDataDe,_dDataAte,_cHoraDe,_cHoraAte,AllTrim(_cExp)})


/*
������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Programa   �   C()      � Autor � Norbert Waage Junior  � Data �10/05/2005���
����������������������������������������������������������������������������Ĵ��
���Descricao  � Funcao responsavel por manter o Layout independente da       ���
���           � resolu��o horizontal do Monitor do Usuario.                  ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
������������������������������������������������������������������������������
*/
Static Function C(nTam)
Local nHRes	:=	oMainWnd:nClientWidth	//Resolucao horizontal do monitor
Do Case
	Case nHRes == 640	//Resolucao 640x480
		nTam *= 0.8
	Case nHRes == 800	//Resolucao 800x600
		nTam *= 1
	OtherWise			//Resolucao 1024x768 e acima
		nTam *= 1.28
EndCase
If "MP8" $ oApp:cVersion
	//���������������������������Ŀ
	//�Tratamento para tema "Flat"�
	//�����������������������������
	If (Alltrim(GetTheme()) == "FLAT").Or. SetMdiChild()
		nTam *= 0.90
	EndIf
EndIf
Return Int(nTam)
