#Include 'RWMAKE.CH'                               

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA067   º Autor ³ Joany Peres        º Data ³  26/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Cadastro para possibilitar a inclusao de itens utilizados  º±±
±±º          ³ em domicilio por assistidos do AED que dao entrada em pe-  º±±
±±º          ³ dido de reembolso posteriormente.                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA067()                                           

//Local aRotAdic := {}  
//Local bPre := {||MsgAlert('Chamada antes da função')}
//Local bOK  := {||MsgAlert('Chamada ao clicar em OK'), .T.}
//Local bTTS  := {||MsgAlert('Chamada durante transacao')}
//Local bNoTTS  := {||MsgAlert('Chamada após transacao')}
Local aButtons := {}                     
aAdd(aButtons,{"PRODUTO", {|| U_Equipamentos(iif(inclui,M->PBI_CODBEN,PBI->PBI_CODBEN))}, "Equipamentos do Beneficiário", "Equips" } )

//axCadastro("PBI", "Controle de Reembolso de Prevenção", ".T.", ".T.", aRotAdic, bPre, bOK, bTTS, bNoTTS, , , aButtons, , )
DbSelectArea("PBI")
axCadastro("PBI", "Controle de Reembolso de Prevenção", ".T.", ".T.", , , , , , , , aButtons, , )
Return()

User Function Equipamentos(cCODBEN)     

if !empty(M->PBI_CODBEN)
	DbSelectArea("PBJ")   
	cChave := PBJ->(IndexKey())
	cIndex := CriaTrab(nil,.f.)
	//cFiltro := " PBJ_CODBEN == '" + M->PBI_CODBEN + "' "
	cFiltro := " PBJ_CODBEN == '" + cCODBEN + "' "
	IndRegua("PBJ",cIndex,cChave,,cFiltro,OemToAnsi( "Selecionando Registros..." ) ) // "Selecionando Registros..."	
	//axCadastro("PBJ", "Equipamentos de Beneficiário", ".T.", ".T.", , {|| M->PBJ_CODBEN := M->PBI_CODBEN})
	axCadastro("PBJ", "Equipamentos de Beneficiário", ".T.", ".T.", , {|| M->PBJ_CODBEN := cCODBEN})
Else
	MsgAlert("Preencha a Matrícula do Beneficiário.")
Endif

Return()