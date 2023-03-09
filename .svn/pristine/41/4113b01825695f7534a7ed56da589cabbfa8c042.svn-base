#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA310      บAutor  ณ Ana Clแudia        บ Data ณ  07/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออนฑฑ
ฑฑบDesc.     ณ Schedule para ser executado diariamente visando filtrar os    บฑฑ
ฑฑบ          ณ registros que tem origem no PLS e que tem mais X dias de      บฑฑ
ฑฑบ          ณ vencido (de acordo com parโmetro).                             ฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Projeto CABERJ                                                บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function I_CABA310()
Private _cOrigem := "MP8"
U_CABA310()
Return

User Function CABA310(cProc)//ANA MUDEI O NOME DA FUNวรO POIS TEM OUTRO PROGRAMA COM A MESMA FUNCAO
Local aSaveArea	:= GetArea()
Local nDiasTr := 0
Local cFilGeral := ""
Local lConfirma := .F.
If Type("_cOrigem") != "U"
	Prepare Environment Empresa "01" Filial "01"
Else
	If cFilAnt == GETMV("MV_XFILGER")
		MsgStop("A Rotina de Troca nใo pode ser executada na filial que recebe a transfer๊ncia dos tํtulos.","ATENวรO")
		Return
	EndIf	
	
	lConfirma := MsgYesNo("Confirma transfer๊ncia de tํtulos?")
EndIf

If lConfirma
	nDiasTr := GETMV("MV_DIASPLS")
	cFilGeral := GETMV("MV_XFILGER")
	
	If Type("_cOrigem") == "U"
		Processa({|| RunCont(nDiasTr,cFilGeral) },"Processando...")
	Else
		RunCont(nDiasTr,cFilGeral)
	EndIf		

	If Type("_cOrigem") != "U"
		RESET ENVIRONMENT
	EndIf
EndIf
Return

Static Function RunCont(nDiasTr,cFilGeral)

Local aCabec := {}
Local aDados := {} , nSucesso := 0
Local cXTipo := StrTran(GETMV("MV_XTPTROC"),'"',"'")

cQuery := " SELECT * "
cQuery += " FROM "+RetSqlName("SE2")+" SE2, "+RetSqlName("BAU")+" BAU "
cQuery += " WHERE E2_FILIAL = '"+xFilial("SE2")+"' "
cQuery += "   AND E2_ORIGEM = 'PLSMPAG' "
cQuery += "   AND E2_YLIBPLS = 'N' AND BAU.BAU_TIPPE = 'J'" // so transfere se nใo estiver liberado e se for pessoa juridica
cQuery += "   AND E2_SALDO = E2_VALOR AND E2_BAIXA = ' '"
cQuery += "   AND E2_TIPO NOT IN ('"+MVTAXA+"','"+MVISS+"','"+MVINSS+"') "
cQuery += "   AND E2_TIPO NOT IN ("+cXTipo+") "
cQuery += "   AND E2_VENCTO < '"+Dtos(DDATABASE-nDiasTr)+"'"  // dias
cQuery += "   AND SE2.D_E_L_E_T_ = ' ' AND BAU.D_E_L_E_T_ = ' ' "
cQuery += "   AND SE2.E2_CODRDA = BAU.BAU_CODIGO AND BAU.BAU_FILIAL = '"+XFILIAL("BAU")+"'"
cQuery += " ORDER BY E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA"
cQuery := ChangeQuery(cQuery)

If Select("SE2TST") > 0
	dbSelectArea("SE2TST")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"SE2TST",.T.,.T.)

If ! SE2TST->(Eof())
	nSucesso := 0
	aCabec := {"FILIAL","NUMERO","PREFIXO","TIPO","VALOR","VENCIMENTO","VENCIMENTO REAL","FILIAL DESTINO"}
	If Type("_cOrigem") == "U"
		ProcRegua(SE2TST->(RecCount()))
	Endif
	BEGIN TRANSACTION
	
	SE2TST->(DbGoTop())
	While ! SE2TST->(Eof()) 
		If Type("_cOrigem") == "U"
			IncProc()
		EndIf	
		
		aaDD(aDados,{SE2TST->E2_FILIAL,SE2TST->E2_NUM,SE2TST->E2_PREFIXO,SE2TST->E2_TIPO,SE2TST->E2_VALOR,SE2TST->E2_VENCTO,SE2TST->E2_VENCREA,cFilGeral})
			
		cQuery := " UPDATE "+RetSqlName("SE2")
		cQuery += " SET E2_FILORIG = '"+SE2TST->E2_FILIAL+"' , E2_FILIAL = '"+cFilGeral+"' "
		cQuery += " WHERE E2_FILIAL = '"+SE2TST->E2_FILIAL+"' "
		cQuery += "   AND E2_NUM = '"+SE2TST->E2_NUM +"' "
		cQuery += "   AND E2_PREFIXO = '"+SE2TST->E2_PREFIXO + "' "
		cQuery += "   AND E2_TIPO IN ('"+MVTAXA+"','"+MVISS+"','"+MVINSS+"') "
		cQuery += "   AND E2_VALOR IN ("+Trim(Str(SE2TST->E2_ISS))+","+Trim(Str(SE2TST->E2_IRRF))+","
		cQuery += Trim(Str(SE2TST->E2_COFINS))+","+Trim(Str(SE2TST->E2_PIS))+","+Trim(Str(SE2TST->E2_CSLL))+","+Trim(Str(SE2TST->E2_INSS))+")"
		cQuery += "   AND E2_ORIGEM = 'PLSMPAG' "
		cQuery += "   AND D_E_L_E_T_ = ' ' "
		
		nSucesso += TcSqlExec(cQuery)
		
		cQuery := " UPDATE "+RetSqlName("SE2")
		cQuery += " SET E2_FILORIG = '"+SE2TST->E2_FILIAL+"' , E2_FILIAL = '"+cFilGeral+"' "
		cQuery += " WHERE E2_FILIAL = '"+SE2TST->E2_FILIAL+"' "
		cQuery += "   AND R_E_C_N_O_ = "+Trim(Str(SE2TST->R_E_C_N_O_))
		cQuery += "   AND E2_ORIGEM = 'PLSMPAG' "
		cQuery += "   AND D_E_L_E_T_ = ' ' "
		
		nSucesso += TcSqlExec(cQuery)
		
		SE2TST->(DbSkip())
	End
	END TRANSACTION
	If Type("_cOrigem") == "U"
		If nSucesso == 0
			MsgStop("Transfer๊ncia efetuada com sucesso!")
		EndIf	
		DlgToExcel({{"ARRAY","Grava็๕es da Filial" ,aCabec,aDados}})
	Endif	

EndIf	

If Select("SE2TST") > 0
	dbSelectArea("SE2TST")
	dbCloseArea()
EndIf

Return	