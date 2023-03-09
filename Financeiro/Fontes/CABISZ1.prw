#INCLUDE "rwmake.ch"

User Function CABISZ1


Private cCadastro := "Cadastro de Planos M�dicos"


//���������������������������������������������������������������������Ŀ
//� aRotina padrao. Utilizando a declaracao a seguir, a execucao da     �
//� MBROWSE sera identica a da AXCADASTRO:                              �
//�                                                                     �
//� cDelFunc  := ".T."                                                  �
//� aRotina   := { { "Pesquisar"    ,"AxPesqui" , 0, 1},;               �
//�                { "Visualizar"   ,"AxVisual" , 0, 2},;               �
//�                { "Incluir"      ,"AxInclui" , 0, 3},;               �
//�                { "Alterar"      ,"AxAltera" , 0, 4},;               �
//�                { "Excluir"      ,"AxDeleta" , 0, 5} }               �
//�                                                                     �
//�����������������������������������������������������������������������


//���������������������������������������������������������������������Ŀ
//� Monta um aRotina proprio                                            �
//�����������������������������������������������������������������������

Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
                     {"Visualizar","AxVisual",0,2},;
                     { "Incluir"  ,"AxInclui" , 0, 3}}

Private cDelFunc := ".F." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := "SZ1"

dbSelectArea(cString)
dbSetOrder(1)
dbGoTop()

mBrowse( 6,1,22,75,cString)

Return
