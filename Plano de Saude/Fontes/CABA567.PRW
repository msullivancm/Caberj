#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATU_EQUIPEบAutor  ณRaquel              บ Data ณ  02/16/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Atualiza as Equipes/ Vendedores nas famํlias e nos        บฑฑ
ฑฑบ          ณ  usuแrios qdo estes sใo alterados no subcontrato           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/



User Function CABA567()
	If ! Pergunte("CABA567", .T.)
		Return
	Endif
	
	If  ! msgyesno("Este programa ira atualizar O numero da parcela em BM1 para evitar o pagamento de agenciamanto de matriculas transferidas")
		Return()
	Endif
	
	MsAguarde({||AjusTrans()}, "", "Atualizacao Matricula transferidas , Aguarde ..... ", .T.)
	
	
Return



Static Function AjusTrans()
	
	LOCAL cOpe
	LOCAL cEmp
	LOCAL cCont
	LOCAL cEquipe
	LOCAL cVend1  :=""
	LOCAL cVend2  :=""
	Local cSQL    := ""
	Private cPerg := "CABR162"
	Private cAliastmp := GetNextAlias()
	
	Pergunte(cPerg,.F.)
	
	dDatInc  	:= substr(mv_par01,7,2)+substr(mv_par01,5,2)+substr(mv_par01,1,4)
	cEmpAtu  	:= mv_par02
	cEmpAnt  	:= mv_par03
	nGeraExcel 	:= mv_par04
	/*---------------------
	SELECT BA1_DATBLO, BA1_TRADES, BA1_TRAORI , BA1.*
	FROM BA1020 BA1 WHERE BA1_FILIAL = ' ' AND D_e_l_e_t_ = ' ' AND BA1_CODEMP = '0182'
	--AND BA1_datblo = '20140930'
	and BA1_datinc = '20141001'
	and substr (ba1_traori,5,4) =  '0159'
	ORDER BY 1*/
	
	
	cQuery :=CRLF+" SELECT BA1_DATBLO, BA1_TRADES, BA1_TRAORI ,   "
	cQuery +=CRLF+  " FROM " + RetSqlName("BA1") +" BA1 "
	cQuery +=CRLF+ " WHERE BA1_FILIAL = '"+(xFilial("BA1"))+"' AND BA1.D_e_l_e_t_ = ' ' "
	
	cQuery +=CRLF+   " AND BA1_CODEMP =  '"+cEmpAtu+"' "
	
	cQuery +=CRLF+   " and substr(ba1_traori,5,4) = '"+cEmpAnt+"' "
	
	cQuery +=CRLF+   " and BA1_datinc = = '"+dDatInc+"' "
	
	cQuery +=CRLF+   " order by 4,8 "
	
	
	If Select(cAliastmp) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif
	
	TCQuery cQuery New Alias (cAliastmp)
	
	dbSelectArea(cAliastmp)
	
	(cAliastmp)->(dbGoTop())
	
	while ( (cAliastmp)->(!Eof()) )
		
		dbselectarea("BM1")
		BM1->(DbSetOrder(5))
		//     BM1_FILIAL+BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG+BM1_DIGITO+BM1_NUMPAR
		if 	!( BM1->(DbSeek(xFilial("BM1")+(cAliastmp)->BA1_TRAORI+'001')))
			MsgStop("Subcontrato Incorreto!")
			Return
		Else
			While BQC->(BQC_FILIAL + BQC_CODIGO  ) == (xFilial("BQC")+PLSINTPAD()+mv_par01)
				If !empty(mv_par02) .and. !empty(mv_par03)
					if BQC->(BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB ) != (xFilial("BQC")+PLSINTPAD()+mv_par01+mv_par02+mv_par03)
						BQC->(dbSkip())
						loop
					EndIf
				ElseIf !empty(mv_par02)
					if BQC->(BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON  ) != (xFilial("BQC")+PLSINTPAD()+mv_par01+mv_par02)
						BQC->(dbSkip())
						loop
					EndIf
				EndIf
				//   While BQC->(BQC_FILIAL + BQC_CODIGO + BQC_NUMCON + BQC_VERCON + BQC_SUBCON + BQC_VERSUB ) == (xFilial("BQC")+PLSINTPAD()+mv_par01+mv_par02+mv_par03)
				
				reclock("BQC",.F.)
				BQC->BQC_EQUIPE := cEquipe
				BQC->BQC_CODVEN := cVend1
				BQC->BQC_CODVE2 := cVend2
				BQC->(MsUnlock())
				BQC->(dbSkip())
			EndDo
		endIf
		dbselectarea("BA1")
		
		Ba1->(DbSetOrder(1))
		
		if Ba1->(DbSeek(xFilial("BA1")+'0001'+mv_par01))
			
			While BA1->(BA1_FILIAL + BA1_CODINT+BA1_CODEMP) == (xFilial("BA1")+PLSINTPAD()+mv_par01)
				If !empty(mv_par02) .and. !empty(mv_par03)
					if ba1->BA1_CONEMP != Substr(cCont, 1, 12) .or. ba1->BA1_VERCON != Substr(cCont, 13, 3) .or. ba1->BA1_SUBCON != Substr(cSubCont, 1, 9) .or. ba1->BA1_VERSUB != Substr(cSubCont, 10, 3)
						BA1->(dbSkip())
						loop
					EndIf
				elseif !empty(mv_par02)
					if ba1->BA1_CONEMP != Substr(cCont, 1, 12) .or. ba1->BA1_VERCON != Substr(cCont, 13, 3)
						BA1->(dbSkip())
						loop
					EndIf
				EndIf
				reclock("BA1",.F.)
				BA1->BA1_EQUIPE := cEquipe
				BA1->BA1_CODVEN := cVend1
				BA1->BA1_CODVE2 := cVend2
				BA1->(MsUnlock())
				BA1->(dbSkip())
			EndDo
		EndIf
		dbselectarea("BA3")
		
		Ba3->(DbSetOrder(1))
		
		if Ba3->(DbSeek(xFilial("BA1")+'0001'+mv_par01))
			
			While BA3->(BA3_FILIAL + BA3_CODINT+BA3_CODEMP) == (xFilial("BA3")+PLSINTPAD()+mv_par01)
				If !empty(mv_par02) .and. !empty(mv_par03)
					If ba3->BA3_CONEMP != Substr(cCont, 1, 12) .or. ba3->BA3_VERCON != Substr(cCont, 13, 3) .or. ba3->BA3_SUBCON != Substr(cSubCont, 1, 9) .OR. ba3->BA3_VERSUB != Substr(cSubCont, 10, 3)
						BA3->(dbSkip())
						loop
					EndIf
				elseIf !empty(mv_par02)
					If ba3->BA3_CONEMP != Substr(cCont, 1, 12) .or. ba3->BA3_VERCON != Substr(cCont, 13, 3)
						BA3->(dbSkip())
						loop
					EndIf
				EndIf
				
				reclock("BA3",.F.)
				BA3->BA3_EQUIPE := cEquipe
				BA3->BA3_CODVEN := cVend1
				BA3->BA3_CODVE2 := cVend2
				BA3->(MsUnlock())
				BA3->(dbSkip())
			EndDo
		EndIF
		
		(cAliastmp)->(dbskip())
	EndDo 	
		
		//BQC->(DbSetOrder(1))
		
		/*
		cSQL := " UPDATE "+RetSQLName("BQC")+" SET BQC_EQUIPE = '"+cEquipe+"', "
		cSQL += " BQC_CODVEN = '"+cVend1+"', "
		cSQL += " BQC_CODVE2 = '"+cVend2+"' "
		cSQL += " WHERE BQC_CODIGO = '"+PLSINTPAD()+cEmp+"' "
		cSQL += " AND BQC_NUMCON = '"+Substr(cCont, 1, 12)+"' "
		cSQL += " AND BQC_VERCON = '"+Substr(cCont, 13, 3)+"' "
		cSQL += " AND BQC_SUBCON = '"+Substr(cSubCont, 1, 9)+"' "
		cSQL += " AND BQC_VERSUB = '"+Substr(cSubCont, 10, 3)+"' "
		cSQL += " AND D_E_L_E_T_ = ' ' "
		TCSQLEXEC(cSQL)
		
		If Select(("TMP")) <> 0
			("TMP")->(DbCloseArea())
		Endif
		TCQuery cSQL Alias "TMP" New
		dbSelectArea("TMP")
		tmp->(dbGoTop())
		
		tmp->(dbGoTop())
		While !TMP->(EOF())
			
			BA3->(DbSetOrder(1))
			BQC->(DbSetOrder(1))
			
			BA3->(DbSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
			BQC->(DbSeek(xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))
			
			dbselectarea("SE2")
			dbSeek(xFilial("SE2")+_cPref+_cTitulo+_cParc+_cTipo+_cFornec+_cLoja)
			If Found()
				reclock("BXQ",.T.)
				
				BXQ->(MsUnlock())
				tmp->(dbSkip())
				
				
				
				
				
				
				
				cSQL := " UPDATE "+RetSQLName("BA3")+" SET BA3_EQUIPE = '"+cEquipe+"', "
				cSQL += " BA3_CODVEN = '"+cVend1+"', "
				cSQL += " BA3_CODVE2 = '"+cVend2+"' "
				cSQL += " WHERE BA3_CODINT = '"+PLSINTPAD()+"' "
				cSQL += " AND BA3_CODEMP = '"+cEmp+"' "
				cSQL += " AND BA3_CONEMP = '"+Substr(cCont, 1, 12)+"' "
				cSQL += " AND BA3_VERCON = '"+Substr(cCont, 13, 3)+"' "
				cSQL += " AND BA3_SUBCON = '"+Substr(cSubCont, 1, 9)+"' "
				cSQL += " AND BA3_VERSUB = '"+Substr(cSubCont, 10, 3)+"' "
				cSQL += " AND D_E_L_E_T_ = ' ' "
				//  TCSQLEXEC(cSQL)
				
				cSQL := " UPDATE "+RetSQLName("BA1")+" SET BA1_EQUIPE = '"+cEquipe+"', "
				cSQL += " BA1_CODVEN = '"+cVend1+"', "
				cSQL += " BA1_CODVE2 = '"+cVend2+"' "
				cSQL += " WHERE BA1_CODINT = '"+PLSINTPAD()+"' "
				cSQL += " AND BA1_CODEMP = '"+cEmp+"' "
				cSQL += " AND BA1_CONEMP = '"+Substr(cCont, 1, 12)+"' "
				cSQL += " AND BA1_VERCON = '"+Substr(cCont, 13, 3)+"' "
				cSQL += " AND BA1_SUBCON = '"+Substr(cSubCont, 1, 9)+"' "
				cSQL += " AND BA1_VERSUB = '"+Substr(cSubCont, 10, 3)+"' "
				cSQL += " AND D_E_L_E_T_ = ' ' "
				// TCSQLEXEC(cSQL)            */
				
				MsgStop("Dados atualizados!")
				
				//ENDIF
				
				Return Nil
				
				******************************************************************************************
				
			Static Function AjustaSX1(cPerg)
				
				Local aHelpPor := {}
				
				PutSx1(cPerg,"01",OemToAnsi("Data Inclussao,(Transferencia)") ,"","","mv_ch1","D",10,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
				PutSx1(cPerg,"02",OemToAnsi("Cod.Empresa Atual ") 		       ,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
				PutSx1(cPerg,"03",OemToAnsi("Cod.Empresa Anterior ") 		   ,"","","mv_ch3","C",04,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
				PutSx1(cPerg,"04",OemToAnsi("Gerar Excel ") 	         	   ,"","","mv_ch4","N",01,0,0,"C","","","","","mv_par04","Sim","","","","Nใo","","","","","","","","","","","",{},{},{})
				
				Pergunte(cPerg,.T.)
				
				Return
				
				
				