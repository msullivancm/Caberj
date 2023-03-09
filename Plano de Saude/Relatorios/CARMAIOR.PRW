#INCLUDE 'PROTHEUS.CH'
#INCLUDE "TOTVS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*/{Protheus.doc} CARMAIOR_NOVO

Rotina Utilizada para gerar o carta para Mater maior que 24 Anos

@description Esta rotina chama o Crystal para exibir o relat๓rio
@description Arquivo Crystal: CARMAIOR
@description Procedure do Oracle: CR_PLS_CARTA_MAIOR24

@type function
@author anderson.rangel
@since 16/06/2021
@version 1.0
/*/

User Function CARMAIOR()
			
	Private cParIpr	 := "1;0;1;Carta Maior de 24 Anos"
	Private _cPerg	 := "CARMAIOR"
    Private vCodemp  := ""
	Private vFamilia := ""
	Private _cAlias	:= GetNextAlias()

	//-----------------------------------------------------
	//Cria grupo de perguntas
	//-----------------------------------------------------
	CARMAIORA(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		vCodemp := Substr(MV_PAR01,5,4)
		vFamilia := Substr(MV_PAR01,1,14)

		BA1->(DbSetOrder(2)) //Define indices e tabelas para uso.

		IF BA1->(MsSeek(xFilial("BA1")+MV_PAR01))
			
			If vCodemp == "0001"
				
				//Validando se existe familia com dependente entre 23 e 24 anos.
				cQuery := "SELECT DISTINCT" + c_ent
				cQuery += "'TEM DEPENDENTE' STATUS" + c_ent
				cQuery += "FROM " + RetSqlName("BA1") + " BA1" + c_ent
				cQuery += "WHERE BA1.D_E_L_E_T_ = ' ' " + c_ent
				cQuery += "AND (BA1_DATBLO = ' ' OR BA1_DATBLO >= TO_CHAR(SYSDATE, 'YYYYMMDD'))" + c_ent
				cQuery += "AND SIGA.IDADE(TO_DATE(BA1_DATNAS,'YYYYMMDD')) BETWEEN 23 AND 24" + c_ent
				cQuery += "AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC = '"+ vFamilia +"'" + c_ent

				If Select(_cAlias) > 0
					(_cAlias)->(DbCloseArea())
				EndIf
				
				DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),_cAlias,.T.,.T.)
				
				If !(_cAlias)->(EOF())

					CallCrys("CARMAIOR",MV_PAR01,cParIpr)
				
				else
				
					MsgInfo("Nใo existe dependente na familia informada com 24 anos a completar!","Aten็ใo")
				
				EndIf
			
			Else
				
				MsgInfo("Matricula nใo pertencente ao GRUPO CABERJ ASSOCIADO!","Aten็ใo")
			
			endIf
		else
			
			MsgInfo("Matricula nใo existente!","Aten็ใo")

		EndIf
		
	EndIf			
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  CARMAIORA  บAutor  Anderson Rangel      บ Data ณ  16/06/21   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CARMAIORA(cGrpPerg)
	
	Local aHelpPor 	:= {} //help da pergunta
	Local _nTamMat	:= 0
	
	_nTamMat	+= TamSX3("BA1_CODINT")[1]
	_nTamMat	+= TamSX3("BA1_CODEMP")[1]
	_nTamMat	+= TamSX3("BA1_MATRIC")[1]
	_nTamMat	+= TamSX3("BA1_TIPREG")[1]
	_nTamMat	+= TamSX3("BA1_DIGITO")[1]
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a Matricula 			")
	AADD(aHelpPor,"do beneficiแrio.				")
	
	PutSx1(cGrpPerg,"01","Matricula: ?"			,"a","a","MV_CH1"	,"C",_nTamMat					,0,0,"G","","CAB595","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	
Return
