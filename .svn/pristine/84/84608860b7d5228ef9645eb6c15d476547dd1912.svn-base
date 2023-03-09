#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV026   ºAutor  ³Angelo Henrique     º Data ³  10/10/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina de validação do CPF, utilizada no campo BA1_CPFUSR  º±±
±±º          ³para validar se existe CPF duplicado na base e ativo.       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function CABV026()
	
	Local _aArea 	:= GetArea()
	Local _aArBA1 := BA1->(GetArea())
	Local _aArBA3 := BA3->(GetArea())
	Local _aArBI3 := BI3->(GetArea())
	Local _lRet	:= .T.
	Local cAlias1 := GetNextAlias() //Utilizado para a query da BA3	
	Local cQuery	:= ""
	Local _cMsg	:= ""
	
	cQuery	:= " SELECT " 				+ c_ent
	cQuery	+= " 	BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA, " + c_ent
	cQuery	+= " 	BA1.BA1_CODPLA, " 	+ c_ent
	cQuery	+= " 	( " 					+ c_ent
	cQuery	+= " 		SELECT " 			+ c_ent
	cQuery	+= " 			BI3.BI3_DESCRI " 		+ c_ent
	cQuery	+= " 		FROM " 					+ c_ent
	cQuery	+= " 		" + RetSqlName("BI3") 	+ " BI3 " 			+ c_ent
	cQuery	+= " 		WHERE " 										+ c_ent
	cQuery	+= " 			BI3.D_E_L_E_T_ = ' ' " 					+ c_ent
	cQuery	+= " 			AND BI3.BI3_CODIGO = BA1.BA1_CODPLA " 	+ c_ent
	cQuery	+= " 	) DESC_PLANO " 	+ c_ent
	cQuery	+= " FROM	" 				+ c_ent
	cQuery	+= " 		" + RetSqlName("BA1") + " BA1 " 		+ c_ent
	cQuery	+= " WHERE " 											+ c_ent	
	cQuery	+= " 	BA1.D_E_L_E_T_ = ' ' " 		+ c_ent
	cQuery	+= " 	AND BA1.BA1_DATBLO = ' ' "	+ c_ent
	cQuery	+= " 	AND BA1.BA1_CPFUSR LIKE '%" + M->BA1_CPFUSR + "%' " + c_ent
		
	DbUseArea(.T.,"TOPCONN", TCGENQRY(,,cQuery),cAlias1, .F., .T.)
	
	If (cAlias1)->(!Eof())
	
		_cMsg := "CPF já cadastrado:" + c_ent		
		_cMsg += "Matricula: " + (cAlias1)->MATRICULA + "." + c_ent
		_cMsg += "Plano: " + (cAlias1)->BA1_CODPLA + " - " + (cAlias1)->DESC_PLANO + "." + c_ent
		_cMsg += "Favor analisar antes de realizar a inclusão deste beneficiário."
		
		Aviso("Atenção", _cMsg, {"OK"})
					
	EndIf
	
	RestArea(_aArBI3)
	RestArea(_aArBA3)
	RestArea(_aArBA1)
	RestArea(_aArea)
	
Return _lRet
