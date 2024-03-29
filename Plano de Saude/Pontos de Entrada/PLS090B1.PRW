
#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PLS090B1  �Autor  � Jean Schulz        � Data �  13/09/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �Inserir botao para chamada da rotina de Mural, criada para  ���
���          �a Caberj.                                                   ���
�������������������������������������������������������������������������͹��
���Uso       � Caberj.                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PLS090B1
	Local bBotao01 := {|| U_TELAMURAL("PLS090B1") }
	
	Local aRet := {"RELATORIO","Mural Assistido",bBotao01}
	
Return aRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TELAMURAL �Autor  � Jean Schulz        � Data �  13/09/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Tela de log de exportacao / importacao de arquivos para a  ���
���          � Rio Previdencia.                                           ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function TELAMURAL(cPrg)
	
	//Local cMatric := Iif(cPrg=="PLS090B1",M->BE1_USUARI,M->BE4_USUARI) -- Angelo Henrique Data: 18/05/2018
	Local cMatric := ""
	Local cMatVid := ""
	Local aAreaBA1 := BA1->(GetArea())
	//���������������������������������������������������������������������Ŀ
	//� Monta matriz com as opcoes do browse...                             �
	//�����������������������������������������������������������������������
	PRIVATE aRotina   	:=	{	{ "Pesquisar"	    , 'AxPesqui'	  , 0 , K_Pesquisar  },;
		{ "&Visualizar"	, 'AxVisual'	  , 0 , K_Visualizar } }
		
	//-------------------------------------------------------------------------
	//Angelo Henrique - Data: 18/05/2018
	//-------------------------------------------------------------------------
	//Valida��o para saber qual a rotina esta realizando a chamada da tela
	//-------------------------------------------------------------------------			
	If cPrg == "CABA069"
		
		cMatric := M->ZX_USUARIO
		
	ElseIf cPrg == "PLS090B1"
		
		cMatric := M->BE1_USUARI
	
	ElseIf cPrg == "PLS09AB1" //Angelo Henrique - Data: 30/08/2021
		
		cMatric := M->B4Q_USUARI
		
	Else
		
		cMatric := M->BE4_USUARI
		
	EndIf
	
	
	//���������������������������������������������������������������������Ŀ
	//� Titulo e variavies para indicar o status do arquivo                 �
	//�����������������������������������������������������������������������
	PRIVATE cCadastro 	:= "Mural do assistido"
	PRIVATE cPath  := ""
	PRIVATE cAlias := "ZZ6"
	PRIVATE cFil := ""
	
	BA1->(DbSetOrder(2))
	cMatVid := Posicione("BA1",2,xFilial("BA1")+Alltrim(cMatric),"BA1_MATVID")
	
	//Filtra conforme matricula da vida localizada pela rotina de liberacao / autoriza internacao.
	cFil := "@ZZ6_FILIAL = '"+xFilial("ZZ6")+"'"
	cFil += " AND ZZ6_MATVID = '"+cMatVid+"' "
	cFil += " AND D_E_L_E_T_ = ' '"
	
	//���������������������������������������������������������������������Ŀ
	//� Starta mBrowse...                                                   �
	//�����������������������������������������������������������������������
	ZZ6->(DBSetOrder(1))
	DbSelectArea("ZZ6")
	SET FILTER TO &cFil
	
	RestArea(aAreaBA1)
	
	//ZZ6->(mBrowse(006,001,022,075,"ZZ6" , , , , , Nil    , aCores, , , ,nil, .T.))
	ZZ6->(mBrowse(006,001,022,075,"ZZ6" , , , , , Nil    , , , , ,nil, .T.))
	ZZ6->(DbClearFilter())
	
Return

