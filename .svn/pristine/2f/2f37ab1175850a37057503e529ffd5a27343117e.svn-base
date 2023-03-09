#define  K_NovaVersao	6
#define  K_SubCon		6
#define  K_BlqSubCon	7
#define  K_HisBlqSub	8

#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "COLORS.CH"

STATIC cMenu := 6 //Variavel estatica para controlar o MenuDef e o aRotina.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Programa ³ CABA233  º Autor ³ Frederico O. C. Jr º Data ³ 13/09/22   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Chamar rotina padrão de cadastro de empresa com filtro    º±±
±±º          ³ 	para a AllCare					                          º±±
±±º          ³ 									                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA233

Local aRotAdic
Local nNx

// Tratamento da regra da ALL CARE
// Local aRegra	:= StrTokArr2( SuperGetMv("MV_XUSXEMP",,"000000|001727-01+0001|0002|0003"), "-")
// Local cUsuarios	:= AllTrim(aRegra[1])								// Usuarios a restringir
// Local aOpeEmp	:= StrTokArr2( aRegra[2], "+")
// Local cEmpresa	:= AllTrim(aOpeEmp[1])								// Caberj / Integral
Local cGrpEmp	:= ""			// Grupos/Empresas a apresentar
// Local cGrpEmp	:= AllTrim(StrTran(aOpeEmp[2],"|","','"))			// Grupos/Empresas a apresentar
Local cFiltro	:= ""
LOCAL cCodUsr 	:= PLSRtCdUsr()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define opcoes da rotina...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aRotina := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o cabecalho da tela de atualizacoes                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cAlias    	:= "BG9"
PRIVATE cCadastro 	:= PLSRetTit(cAlias)
PRIVATE nOk			:= 0
PRIVATE aCdCores  	:= { 	{ 'BR_VERDE'    ,OemtoAnsi("Empresa OK") }									,;
							{ 'BR_AZUL'     ,OemtoAnsi("Sub-Contrato(s) Bloqueado(s) Parcial(s)") }		,;
							{ 'BR_AMARELO'  ,OemtoAnsi("Familia(s) Bloqueada(s) Parcial(s)") }			,;
							{ 'BR_VERMELHO' ,OemtoAnsi("Sub-Contrato(s) Bloqueado(s)") }				,;
							{ 'BR_PRETO' 	,OemtoAnsi("Familia(s) Bloqueada(s)") } 					}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define aCols e a aHeader...                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aCols        := {}
PRIVATE aHeader      := {}   
PRIVATE n            := 1        
PRIVATE nHC
PRIVATE nHG
PRIVATE nHS                         

cMenu   := 0
aRotina := MenuDef()

// Ponto de Entrada para inserir novos botões no menu do Grupo/Empresa
If ExistBlock("PL660MGE") 
	aRotAdic := ExecBlock("PL660MGE",.F.,.F.,{})

	If ValType(aRotAdic) == "A"
		For nNx := 1 To Len(aRotAdic)
			AAdd(aRotina,aRotAdic[nNx])
		Next
	EndIf
EndIf


BX4->(DbSetOrder(1))
If BX4->(DBSeek(xFilial("BX4")+cCodUsr+PlsIntPad())) // BX4_FILIAL+BX4_CODOPE+BX4_CODINT

	IF !EMPTY(BX4->BX4_XEMP)
		cGrpEmp := Alltrim(StrTran(BX4->BX4_XEMP,",","','"))
	ENDIF

Endif


IF !EMPTY(cGrpEmp)
// if RetCodUsr() $ cUsuarios

	if cEmpAnt == "02"
		cFiltro += iif(!empty(cFiltro), " AND", "@") + " BG9_CODIGO IN ('" + cGrpEmp + "')"
	else
		cFiltro += iif(!empty(cFiltro), " AND", "@") + " BG9_CODIGO = 'ZZ'"
	endif

endif

DbSelectArea('BG9')
BG9->(DbSetOrder(1))
BG9->(DbClearFilter())

SET FILTER TO &cFiltro

BG9->(MsSeek(xFilial("BG9")))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza HELP's			                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PL660CarCr()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chama mBrowse padrao...                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BQC->(DbSetOrder(1))
BT5->(DbSetOrder(1))
BG9->(mBrowse(06,01,22,75,"BG9",,,,,,,,,,,.F.,.F. ))
BG9->(DbClearFilter())
BT5->(DbClearFilter())
BQC->(DbClearFilter())                

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina Principal...                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MenuDef   ³ Autor ³ Darcio R. Sporl       ³ Data ³30/01/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Utilizacao de menu Funcional                               ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Array com opcoes da rotina.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Parametros do array a Rotina:                               ³±±
±±³          ³1. Nome a aparecer no cabecalho                             ³±±
±±³          ³2. Nome da Rotina associada                                 ³±±
±±³          ³3. Reservado                                                ³±±
±±³          ³4. Tipo de Transa‡„o a ser efetuada:                        ³±±
±±³          ³	  1 - Pesquisa e Posiciona em um Banco de Dados           ³±±
±±³          ³    2 - Simplesmente Mostra os Campos                       ³±±
±±³          ³    3 - Inclui registros no Bancos de Dados                 ³±±
±±³          ³    4 - Altera o registro corrente                          ³±±
±±³          ³    5 - Remove o registro corrente do Banco de Dados        ³±±
±±³          ³5. Nivel de acesso                                          ³±±
±±³          ³6. Habilita Menu Funcional                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MenuDef()

Private aRotina := {}

If cMenu == 0

	aRotina := {	{ "Pesquisar"			, 'AxPesqui'   , 0 , K_Pesquisar  	, 0, .F.},;
					{ "Visualizar"			, 'PLSA660Mov' , 0 , K_Visualizar 	, 0, Nil},;
					{ "Incluir"				, 'U_CABA233A' , 0 , K_Incluir    	, 0, Nil},;
					{ "Alterar"				, 'U_CABA233A' , 0 , K_Alterar    	, 0, Nil},;
					{ "Excluir"				, 'U_CABA233A' , 0 , K_Excluir    	, 0, Nil},;
					{ "Contratos"			, 'PLS660FilC' , 0 , K_Visualizar	, 0, Nil},;
					{ "Valor Cobranca"		, 'U_CABA233A'  , 0 , K_Alterar		, 0, Nil},;
					{ "Par.Reajustes" 		, 'U_CABA233A' , 0 , 0 				, 0, Nil} }

ElseIf cMenu == 1

	aRotina := {	{ "Pesquisar"			, 'AxPesqui'   , 0 , K_Pesquisar  	},;
					{ "Visualizar"			, 'PLSA660Con' , 0 , K_Visualizar 	},;
					{ "Incluir"				, 'PLSA660Con' , 0 , K_Incluir    	},;
					{ "Alterar"				, 'U_CABA233A' , 0 , K_Alterar    	},;
					{ "Excluir"				, 'PLSA660Con' , 0 , K_Excluir    	},;
					{ "Sub-Contrato"		, 'PLSA660Con' , 0 , K_Visualizar 	},;
					{ "Legenda"				, "PLSA660LEG" , 0 , K_Incluir 		},;
					{ "Valor Cobranca"		, 'PLS660Cob'  , 0 , K_Alterar 		},;
					{ "Par.Reajustes"		, 'Plsa660REC' , 0 , K_Alterar 		}}

ElseIf cMenu == 2

	aRotina := {	{ "Pesquisar"			, 'AxPesqui'   , 0 , K_Pesquisar 	},;
					{ "Visualizar"			, 'PLS660Var'  , 0 , K_Visualizar	},;
					{ "Incluir"				, 'PLS660Var'  , 0 , K_Incluir   	},;
					{ "Alterar"				, 'PLS660Var'  , 0 , K_Alterar   	},;
					{ "Excluir"				, 'PLS660Var'  , 0 , K_Excluir   	},;
					{ "Nova Versao"			, 'PLS660Var'  , 0 , K_NovaVersao	},;
					{ "(Des)bloq.sub-Ct."	, 'PLS660BLQ'  , 0 , K_BlqSubCon 	},;
					{ "Hist.Bloqueio"		, 'PLS660HIS'  , 0 , K_HisBlqSub 	},;
					{ "Valor Cobranca"		, 'PLS660Cob'  , 0 , K_Alterar   	},;
					{ "Param.Reajustes"		, 'Plsa660RES' , 0 , K_Alterar   	},;
					{ "Copia"				, 'Plsa660C'   , 0 , K_Alterar   	}}

ElseIf cMenu == 3

	aRotina := { 	{ "Pesquisar"			, 'AxPesqui'   , 0 , K_Pesquisar 	},;
					{ "Visualizar"			, 'AxVisual'   , 0 , K_Visualizar	},;
					{ "Incluir"				, 'Plsa660Inc' , 0 , K_Incluir   	},;
					{ "Alterar"				, 'Plsa660Alt' , 0 , K_Alterar   	},;
					{ "Excluir"				, 'AxDeleta'   , 0 , K_Excluir   	}}

ElseIf cMenu == 4

	aRotina := { 	{ "Pesquisar"			, 'AxPesqui'   , 0 , K_Pesquisar 	},;
					{ "Visualizar" 			, 'AxVisual'   , 0 , K_Visualizar	},;
					{ "Incluir"  			, 'Plsa660Inc' , 0 , K_Incluir   	},;
					{ "Alterar"  			, 'Plsa660Alt' , 0 , K_Alterar   	},;
					{ "Excluir"	 			, 'AxDeleta'   , 0 , K_Excluir   	}}

ElseIf cMenu == 5

	aRotina := {	{ "Pesquisar"  			, 'AxPesqui'   , 0 , K_Pesquisar 	},;
					{ "Visualizar" 			, 'AxVisual'   , 0 , K_Visualizar	},;
					{ "Incluir"  			, 'Plsa660Inc' , 0 , K_Incluir   	},;
					{ "Alterar"  			, 'Plsa660Alt' , 0 , K_Alterar   	},;
					{ "Excluir"				, 'AxDeleta'   , 0 , K_Excluir   	}}

Else

	aRotina := {	{ "Pesquisar"			, 'AxPesqui'   , 0 , K_Pesquisar  	, 0, .F.},;
					{ "Visualizar"			, 'PLSA660Mov' , 0 , K_Visualizar 	, 0, Nil},;
					{ "Incluir"				, 'PLSA660Mov' , 0 , K_Incluir    	, 0, Nil},;
					{ "Alterar"				, 'PLSA660Mov' , 0 , K_Alterar    	, 0, Nil},;
					{ "Excluir"				, 'PLSA660Mov' , 0 , K_Excluir    	, 0, Nil},;
					{ "Contratos"			, 'PLS660FilC' , 0 , K_Visualizar	, 0, Nil},;
					{ "Valor Cobranca"		, 'PLS660Cob'  , 0 , K_Alterar		, 0, Nil},;
					{ "Par.Reajustes" 		, 'PLSA660REA' , 0 , 0 				, 0, Nil},;
					{ "Pesquisar"			, 'AxPesqui'   , 0 , K_Pesquisar            },;
					{ "Visualizar"			, 'PLSA660Con' , 0 , K_Visualizar           },;
					{ "Incluir"				, 'PLSA660Con' , 0 , K_Incluir              },;
					{ "Alterar"				, 'PLSA660Con' , 0 , K_Alterar              },;
					{ "Excluir"				, 'PLSA660Con' , 0 , K_Excluir              },;
					{ "Sub-Contrato"		, 'PLSA660Con' , 0 , K_Visualizar           },;
					{ "Legenda"				, "PLSA660LEG" , 0 , K_Incluir 	            },;
					{ "Valor Cobranca"		, 'PLS660Cob'  , 0 , K_Alterar 	            },;
					{ "Par.Reajustes"		, 'Plsa660REC' , 0 , K_Alterar 	            },;
					{ "Pesquisar"			, 'AxPesqui'   , 0 , K_Pesquisar            },;
					{ "Visualizar"			, 'PLS660Var'  , 0 , K_Visualizar           },;
					{ "Incluir"				, 'PLS660Var'  , 0 , K_Incluir              },;
					{ "Alterar"				, 'PLS660Var'  , 0 , K_Alterar              },;
					{ "Excluir"				, 'PLS660Var'  , 0 , K_Excluir              },;
					{ "Nova Versao"			, 'PLS660Var'  , 0 , K_NovaVersao           },;
					{ "(Des)bloq.sub-Ct."	, 'PLS660BLQ'  , 0 , K_BlqSubCon            },;
					{ "Hist.Bloqueio"		, 'PLS660HIS'  , 0 , K_HisBlqSub            },;
					{ "Valor Cobranca"		, 'PLS660Cob'  , 0 , K_Alterar              },;
					{ "Par.Reajustes"		, 'Plsa660RES' , 0 , K_Alterar              },;
					{ "Copia"				, 'Plsa660C'   , 0 , K_Alterar              },;
					{ "Pesquisar"			, 'AxPesqui'   , 0 , K_Pesquisar            },;
					{ "Visualizar"			, 'AxVisual'   , 0 , K_Visualizar           },;
					{ "Incluir"				, 'Plsa660Inc' , 0 , K_Incluir              },;
					{ "Alterar"				, 'Plsa660Alt' , 0 , K_Alterar              },;
					{ "Excluir"				, 'AxDeleta'   , 0 , K_Excluir              },;
					{ "Pesquisar"  			, 'AxPesqui'   , 0 , K_Pesquisar            },;
					{ "Visualizar" 			, 'AxVisual'   , 0 , K_Visualizar           },;
					{ "Incluir"  			, 'Plsa660Inc' , 0 , K_Incluir              },;
					{ "Alterar"  			, 'Plsa660Alt' , 0 , K_Alterar              },;
					{ "Excluir"	 			, 'AxDeleta'   , 0 , K_Excluir              },;
					{ "Pesquisar"  			, 'AxPesqui'   , 0 , K_Pesquisar            },;
					{ "Visualizar" 			, 'AxVisual'   , 0 , K_Visualizar           },;
					{ "Incluir"  			, 'Plsa660Inc' , 0 , K_Incluir              },;
					{ "Alterar"  			, 'Plsa660Alt' , 0 , K_Alterar              },;
					{ "Excluir"	 			, 'AxDeleta'   , 0 , K_Excluir              }}

EndIf

Return(aRotina)


USER FUNCTION CABA233A()
  MsgStop("Este usuário não tem permissão para acessar essa rotina.", "Acesso Negado")
Return 
