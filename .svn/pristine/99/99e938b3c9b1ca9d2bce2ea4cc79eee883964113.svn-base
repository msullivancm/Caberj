#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'APWEBSRV.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'AP5MAIL.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

#DEFINE c_ent CHR(13) + CHR(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV061 ºAutor  ³Anderson Rangel  	 º Data ³  31/08/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida a empresa RIWA e SERJUS para abrir Liberação e       º±±
±±º          ³internação para a operadora INTEGRAL						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³INTEGRAL                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//VALIDAÇÃO INTERNAÇÃO
User Function CABV061I()

	Local _ChaveZX := M->BE4_USUARI
	local lRet := .t.
	
	If cEmpAnt == "02"
		
		If SUBSTR(_ChaveZX,5,4 ) = "0397" .or. SUBSTR(_ChaveZX,5,4 ) = "0398"

			Alert("Favor criar Senhas de Internação para as empresas RIWA ou SERJUS na operadora CABERJ.","Atencao")
			lRet := .f.

		EndIf

	EndIf

return lret

//VALIDAÇÃO LIBERAÇÃO
User Function CABV061L()

	Local _ChaveZX := M->BE1_USUARI
	local lRet := .t.
	
	If cEmpAnt == "02"
		
		If SUBSTR(_ChaveZX,5,4 ) = "0397" .or. SUBSTR(_ChaveZX,5,4 ) = "0398"

			Alert("Favor criar Senhas de Liberação para as empresas RIWA ou SERJUS na operadora CABERJ.","Atencao")
			lRet := .f.

		EndIf

	EndIf

return lret

//----------------------------------------------------------------------------------------------------------------------------
// Autor: Anderson Rangel   Data: Julho/2021
// Criação de funcionalidade que não permita a abertura de protocolos para beneficiário da Integral Saúde Repassados para Caberj
// GLPI 77320
//----------------------------------------------------------------------------------------------------------------------------
User Function CABV061PA()

    Local _ChaveZX 	:= M->ZX_USUARIO
	Local cNomeBenf := ""
	Local cOperOri	:= ""
	local lRet 		:= .t.
	Local aArea		:= GetArea()
	
	If cEmpAnt == "01"
		
		If SUBSTR(_ChaveZX,5,4 ) = "0009"

			Alert("Nao e permitida a abertura de protocolos de atendimento para beneficiario da Integral Saude, repassados da empresa Caberj. (Integral Convenio)","Atencao")
			lRet := .f.

		EndIf

		//----------------------------------------------------------------------------------------------------------------------------
		// Autor: Anderson Rangel   Data: Setembro/2021
		// Criação de funcionalidade de Pop Up na tela do protocolo de atendimento para sinalizar que o beneficiário 
		// é de outra operadora repassado para Caberj ( cod empresa 0004).
		// GLPI 77314
		//----------------------------------------------------------------------------------------------------------------------------
		If SUBSTR(_ChaveZX,5,4 ) = "0004"
			
			dBSelectArea("BA1")
			dbSetOrder(2)
			
			IF BA1->(DbSeek(xFilial("BA1") + _ChaveZX)) 
				
				cNomeBenf := alltrim(BA1->BA1_NOMUSR)
				dBSelectArea("BT5")
				dbSetOrder(1) // BT5_FILIAL, BT5_CODINT, BT5_CODIGO, BT5_NUMCON, BT5_VERSAO, R_E_C_N_O_, D_E_L_E_T_

				If BT5->(DbSeek(xFilial("BT5") + (BA1->BA1_CODINT + BA1->BA1_CODEMP + BA1->BA1_CONEMP + BA1->BA1_VERCON)))	

					cOperOri := alltrim(BT5->BT5_NOME)
					
					If BA1->BA1_SEXO == '1'
					
						MsgInfo("O Beneficiário "+cNomeBenf+" é repassado da empresa "+cOperOri+" a Caberj. (Convênio Reciprocidade)","Atençâo")
					
					else
					
						MsgInfo("A Beneficiária "+cNomeBenf+" é repassada da empresa "+cOperOri+" a Caberj. (Convênio Reciprocidade)","Atençâo")	
					
					endIf
					
					lRet := .t.

				EndIf
			
			EndIf

		EndIf

	else
		//VALIDAÇÃO EMPRESA SERJUS E RIWA NA INTEGRAL
		If SUBSTR(_ChaveZX,5,4 ) = "0397" .or. SUBSTR(_ChaveZX,5,4 ) = "0398"

			Alert("Favor criar Protocolos de Atendimento para as empresas RIWA ou SERJUS na operadora CABERJ.","Atencao")
			lRet := .f.

		EndIf

	EndIf

	if lRet

		lRet	:= U_CABV067(_ChaveZX, .T., "ZX_USUARIO")

	endif

	RestArea(aArea)

Return lRet
