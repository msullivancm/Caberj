#INCLUDE "TOTVS.CH"
#include 'parmtype.ch'

/*
INCLUSÃO DE NOVAS ROTINAS
Após a criação do aRotina, para adicionar novas rotinas ao programa.
Para adicionar mais rotinas, adicionar mais subarrays ao array. No advanced este número é limitado.
Deve se retornar um array onde cada subarray é uma linha a ser adicionada ao aRotina padrão.
*/
User Function MA030ROT()

	Local aRetorno := {}

	AAdd( aRetorno, { "Conta Reembolso", "u_ListCta(SA1->A1_COD,SA1->A1_LOJA)", 2, 0 } )

Return( aRetorno )

User Function ListCta(cCod,cCodLoja)

	Local aArea     := GetArea()
	Local aIndex 	:= {}
	LOCAL cFiltro   := "PCT_CLIENT = '"+cvaltochar(cCod)+"' "
	Local cAlias 	:= "PCT"
	LOCAL aCores 	:= {}
	//Bianchini - Fazendo Backup deste Array do Padrão, porque preciso destrui-lo pra poder alterar e depois voltá-lo após o restArea
	Local aMemosBKP := aMemos
	PRIVATE cCadastro := "Contas Bancárias Reembolso"
	PRIVATE aRotina   := { }

	Private bFiltraBrw := { || FilBrowse( cAlias , @aIndex , @cFiltro ) } 

	Default cCod 	:= ""
	Default cCodLoja := ""

	AADD(aCores,{"(EMPTY(PCT->PCT_STATUS) .OR. PCT->PCT_STATUS == '1') .AND. (EMPTY(PCT->PCT_DATBLO) .OR. PCT->PCT_DATBLO > DATE())", "VERDE" }) //CONTA ATIVA
	AADD(aCores,{"PCT->PCT_STATUS == '2' .AND. (!EMPTY(PCT->PCT_DATBLO) .OR. PCT->PCT_DATBLO <= DATE())", "VERMELHO" }) //CONTA INATIVA
	
	AADD(aRotina, { "Pesquisar" , "AxPesqui"	, 0, 1 })
	AADD(aRotina, { "Visualizar", "AxVisual"  	, 0, 2 })
	AADD(aRotina, { "Incluir"   , "AxInclui"    , 0, 3 })
	AADD(aRotina, { "Alterar"   , "AxAltera" 	, 0, 4 })
	AADD(aRotina, { "Excluir"   , "AxDeleta" 	, 0, 5 })
	AADD(aRotina, { "Legenda"   , "u_LegM30Rot" , 0, 3 })

	If Len(aMemos) > 0
		aMemos := Nil
	Endif

	DbSelectArea(cAlias)
	DbSetOrder(1)

	if !empty(cCod)
		Eval( bFiltraBrw ) //Efetiva o Filtro antes da Chamada a mBrowse
	endif 
	
	mBrowse(6,1,22,75,cAlias,,,,,,aCores,,,,,,,,/*cFiltro*/) 

	if !empty(cCod)
		EndFilBrw( cAlias , @aIndex ) //Finaliza o Filtro 
	Endif 

	RestArea(aArea)
	
	aMemos := aMemosBKP
Return Nil

User Function LegM30Rot()
	Local aLegenda := {}

	//Monta as cores
	AADD(aLegenda,{"BR_VERDE",		"Conta Ativa"  })
	AADD(aLegenda,{"BR_VERMELHO",	"Conta Inativa"})
	
	BrwLegenda(cCadastro, "Legenda", aLegenda)
Return Nil
