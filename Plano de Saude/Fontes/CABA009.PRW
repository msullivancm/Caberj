#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'
#INCLUDE "Protheus.ch"
#INCLUDE "Sigawin.ch"
#INCLUDE "Tbiconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA009   �Autor  �Luzio Tavares       � Data �  31/03/08   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cadastro de relacionamento de Analistas do Contas Medicas  ���
���          � com os respectivos Credenciados.                           ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA009()
//���������������������������������������������������������������������Ŀ
//� Monta matriz com as opcoes do browse...                             �
//�����������������������������������������������������������������������
PRIVATE aRotina   	:=	{	{ "Pesquisar"	 , 'AxPesqui'	 , 0 , K_Pesquisar  },;
									{ "Visualizar"	 , 'AxVisual'	 , 0 , K_Visualizar },;
									{ "Incluir"	    , 'AxInclui'   , 0 , K_Incluir    },;
									{ "Alterar"	    , 'AxAltera'   , 0 , K_Alterar    },;
									{ "Excluir"  	 , 'AxExcluir'  , 0 , K_Excluir    },;
									{ "Legenda"     , "U_CB009LEG" , 0 , K_Incluir    } }

//���������������������������������������������������������������������Ŀ
//� Titulo e variavies para indicar o status do arquivo                 �
//�����������������������������������������������������������������������
PRIVATE cCadastro := "Cadastro de Analistas X Credenciados"
PRIVATE aCdCores  := { 	{ 'BR_AZUL'     , 'Ativo'      },;
								{ 'BR_VERMELHO' , 'Bloqueado'  },;
								{ 'BR_AMARELO'  , 'Finalizado' } }
PRIVATE aCores    := { { 'ZN_ATIVO = "0" .or. !Empty(ZN_ATIVO)',aCdCores[1,1] },;
							  { 'ZN_ATIVO = "1"',aCdCores[2,1] },;
							  { '!Empty(ZN_VIGFIM) .and. ZN_ATIVO = "0"',aCdCores[3,1] } }
PRIVATE cPath  := ""
PRIVATE aErro_	:= {}
PRIVATE aHeader   := {}
PRIVATE aTrailler := {}
PRIVATE aOk			:= {}
PRIVATE cAlias		:= "SZN"
PRIVATE cFixos		:= {}
PRIVATE cCpo   	:= "ZN_ATIVO"


PRIVATE _aArea	:= GetArea()

dbSelectARea("SZN")

//axCadastro("SZN",_cMsg,"ExecBlock('EXCLSZC')","ExecBlock('ALTSZC')")
//���������������������������������������������������������������������Ŀ
//� Starta mBrowse...                                                   �
//�����������������������������������������������������������������������
SZN->(DBSetOrder(1))
SZN->(mBrowse(,,,,cAlias , , , , , Nil, aCores, , , ,nil, .T.))
SZN->(DbClearFilter())

RestArea(_aArea)

Return

/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ���
���Funcao    � CB009LEG � Autor � Luzio Tavares         � Data � 16.03.09 ����
�������������������������������������������������������������������������Ĵ���
���Descricao � Exibe a legenda...                                         ����
��������������������������������������������������������������������������ٱ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
User Function CB009LEG()
Local aLegenda

aLegenda := { 	{ aCdCores[1,1],aCdCores[1,2] },;
	{ aCdCores[2,1],aCdCores[2,2] },;
	{ aCdCores[3,1],aCdCores[3,2] } }

BrwLegenda(cCadastro,"Status" ,aLegenda)

Return
