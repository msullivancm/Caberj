#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA070   º Autor ³ Joany Peres        º Data ³  04/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Historico de Ocorrencias do Prestador                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA070(cCODIGO)
                                                                                      	
Local aRotina := {}  

                                	
if !empty(M->BAU_CODIGO)    	
	DbSelectArea("PBP")   
	cChave := PBP->(IndexKey())
	cIndex := CriaTrab(nil,.f.)
	cFiltro := " PBP_CODIGO == '" + cCODIGO + "' "
	IndRegua("PBP",cIndex,cChave,,cFiltro,OemToAnsi( "Selecionando Registros..." ) ) // "Selecionando Registros..."	
	axCadastro("PBP", "Histórico de Ocorrências","U_DelOk()", "U_COK()", , {|| M->PBP_CODIGO := cCODIGO }, , , , , , , , )
//	axCadastro(cAlias, cTitle, cDel, cOk, aRotAdic, bPre, bOK, bTTS, bNoTTS, aAuto, nOpcAuto, aButtons, aACS, cTela)
Else
	MsgAlert("Preencha o Código do RDA.")
Endif

Return()                         

User Function DelOk() 	
MsgAlert("Ação não autorizada") 
Return .F.

User Function COK() 	       
Local Ret := ""
if Inclui
	Ret := .T.
else
	MsgAlert("Ação não autorizada")
	Ret := .F.
endif	

Return Ret