#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA355  บAutor  ณMateus Medeiros      บ Data ณ  18/12/18  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExportacao de usuarios com bloqueio definitivo com opcional บฑฑ
ฑฑบ          ณfarmacia para empresa conveniada.                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Impressao de boletos.                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABA355
	
	Local cNomeArq	:= ""
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Declaracao de Variaveis                                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PRIVATE cNomeProg   := "CABA355"
	PRIVATE nQtdLin     := 50
	PRIVATE nLimite     := 132
	PRIVATE cControle   := 15
	PRIVATE cTamanho    := "M"
	PRIVATE cTitulo     := "Exportacao Usr. Farmacia"
	PRIVATE cDesc1      := ""
	PRIVATE cDesc2      := ""
	PRIVATE cDesc3      := ""
	PRIVATE cAlias      := "BM1"
	PRIVATE cPerg       := "YFARMA"
	PRIVATE nRel        := "CABA355"
	PRIVATE nlin        := 100
	PRIVATE nOrdSel     := 1
	PRIVATE m_pag       := 1
	PRIVATE lCompres    := .F.
	PRIVATE lDicion     := .F.
	PRIVATE lFiltro     := .T.
	PRIVATE lCrystal    := .F.
	PRIVATE aOrdens     := {}
	PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
	PRIVATE lAbortPrint := .F.
	PRIVATE cCabec1     := "Protocolo de exporta็ใo de usuแrios para conv๊nio Farmแcia"
	PRIVATE cCabec2     := ""
	PRIVATE nColuna     := 00
	PRIVATE nOrdSel     := 0
	PRIVATE cString     := "BA1"
	PRIVATE nTipo		:=GetMv("MV_COMP")
	PRIVATE nHdl
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Variaveis de parametros do relatorio.                               ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PRIVATE cCodEmp		:= ""
	PRIVATE cNumSE1		:= ""
	PRIVATE cLayout		:= ""
	
	ParSX1()
	If !Pergunte(cPerg,.T.)
		MsgAlert("Exporta็ใo abortada!")
		Return
	Endif
	
	WnRel := SetPrint(cString,nrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)
	
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
		Return
	End
	
	Processa({|| ImpRel() }, "Buscando dados...", "", .T.)
	
	If  aReturn[5] == 1
		Set Printer To
		Ourspool(nRel)
	End
	MS_FLUSH()
	
Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpRel    บAutor  ณJean Schulz         บ Data ณ  23/11/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao chamada pela funcao processa para imprimir protocolo บฑฑ
ฑฑบ          ณe gerar texto para empresa.                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpRel
	
	Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local aFatExp	:= {}
	Local nLin		:= 100
	Local cSQL      := ""
	Local nReg		:= 0
	Local cDirExp	:= GETNEWPAR("MV_YFERMAC","\Exporta\FARMA\")
	Local cEOL		:= CHR(13)+CHR(10)
	Local cCpo		:= ""
	Local nTotCob   := 0
	Local cMatEmpr	:= ""
	Local cMatrAnt	:= ""
	
	Local nTotExp	:= 0
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Variaveis de utilizacao da rotina exp Farmacia...                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Local cDiaGer	:= ""
	Local cCPFTit	:= ""
	Local cMatTit	:= ""
	Local cNascTit  := ""
	Local cNomTit	:= ""
	Local cMatDep	:= ""
	Local cNomDep	:= ""
	Local cTipPla	:= "XX"
	Local cPlaUsu	:= ""
	Local nValLim	:= 0
	Local cStatus	:= ""
	Local nCont		:= 0
	Local cCPFUsr	:= ""
	Local aExp		:= {}
	Local aErro		:= {}
	Local cAlias1   := GetNextAlias()
	Private dDatBas	:= CTOD("  /  /  ")
	Private cEmpDe	:= ""
	Private cEmpAte	:= ""
	Private cConDe	:= ""
	Private cConAte	:= ""
	Private cSubDe	:= ""
	Private cSubAte	:= ""
	
	Private c_MotUsuFn 	:= GetMv("MV_XBQFUSU")
	Private c_MotFamFn 	:= GetMv("MV_XBQFFAM")
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza variaveis a partir dos parametros do pergunte.             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Atu_Var()
	If dDatBas < dDataBase
		MsgAlert("Data Base informada anterior a Data Corrente " + DToC(dDatBas))
		Return
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Define indices e tabelas para uso.                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BA1->(DbSetOrder(2))
	BA3->(DbSetOrder(1))
	
	For i := 1 to 2
		
		If i = 1
			cSQL := " SELECT COUNT(R_E_C_N_O_) AS TOTAL "
		Else
			cSQL := " SELECT BF4_CODPRO, BF4_VERSAO, BF4_DATBAS, BF4_MOTBLO, BF4_DATBLO, BF4_CLAOPC, BF4_CODINT, BF4_CODEMP, "
			cSQL += " BF4_MATRIC, BF4_TIPREG, "+RetSQLName("BF4")+".R_E_C_N_O_ AS NUMREG"
		Endif
		
		cSQL += " FROM " + RetSqlName("BF4") + " "
		cSQL += " WHERE BF4_FILIAL = '"+xFilial("BF4")+"' "
		cSQL += " AND BF4_CLAOPC = 'N' " //Farmacia...
		cSQL += " AND "+RetSQLName("BF4")+".D_E_L_E_T_ <> '*' "
		
		If i > 1
			cSQL += " ORDER BY BF4_CODINT, BF4_CODEMP, BF4_MATRIC, BF4_TIPREG "
		Endif
		
		PLSQuery(cSQL,"TRB")
		
		If i = 1
			nTotReg := TRB->TOTAL
			TRB->(DbCloseArea())
			
			If nTotReg <= 0
				Help("",1,"RECNO")
				Return
			Endif
			
		Endif
		
	Next
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Geracao do texto para convenio farmacia.  ณ
	//ณ Formato do nome: FARDDMMAA.TXT onde:  	  ณ
	//ณ FAR: Prefixo indicando arq. Farmacia   	  ณ
	//ณ DD: Dia de geracao do arquivo        	  ณ
	//ณ MM: Mes de geracao do arquivo        	  ณ
	//ณ AA: Ano de geracao do arquivo        	  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	ProcRegua(nTotReg)
	cDiaGer := Substr(DtoS(dDataBase),7,2)+Substr(DtoS(dDataBase),5,2)+Substr(DtoS(dDataBase),3,2)
	cNomeArq := cDirExp+"FARBLOQDEFIN"+cDiaGer+".TXT"
	
	If U_Cria_TXT(cNomeArq)
		
		While ! TRB->(EOF())
			
			nReg++
			
			IncProc("Registro: "+StrZero(nReg,6)+"/"+StrZero(nTotReg,6))
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Valida se usuario existe, e se esta ativo no sistema.               ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If BA1->(MsSeek(xFilial("BA1")+TRB->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG)))
				If Empty(BA1->BA1_DATBLO) .or. (!Empty(BA1->BA1_DATBLO) .And. BA1->BA1_DATBLO >= dDatBas)
					TRB->(DbSkip())
					Loop
				else 
					// Valida tipo de bloqueio - Somente serแ informado bloqueio temporแrio
					IF (BA1->BA1_MOTBLO ==  c_MotUsuFn)
						TRB->(DbSkip())
						Loop
					ENDIF
				Endif
			Else
				TRB->(DbSkip())
				Loop
			Endif
			
			
			if alltrim(BA1->BA1_TIPUSU) == "T" // titular
				cMatTit := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+Space(3)
				cNomTit := Substr(BA1->BA1_NOMUSR,1,40)
				cCPFTit := BA1->BA1_CPFUSR
				cNascTit := dtos(BA1->BA1_DATNAS)
			else // dependente
				
				BEGINSQL ALIAS cAlias1 
					SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRICULA,BA1_CPFUSR,BA1_NOMUSR,BA1_DATNAS 
					FROM %table:BA1%
					WHERE 
						BA1_CODINT = %exp:BA1->BA1_CODINT%
						AND BA1_CODEMP = %exp:BA1->BA1_CODEMP%
						AND BA1_MATRIC = %exp:BA1->BA1_MATRIC%
						AND BA1_TIPUSU = 'T'
						AND D_E_L_E_T_  = ' ' 
				ENDSQL
				
				if (cAlias1)->(!Eof())
					cMatTit := (cAlias1)->MATRICULA+Space(3)
					cNomTit := Substr((cAlias1)->BA1_NOMUSR,1,40)
					cCPFTit := (cAlias1)->BA1_CPFUSR
					cNascTit := cvaltochar((cAlias1)->BA1_DATNAS)
				endif 
				 
				 if select(cAlias1) > 0 
				 	dbselectarea(cAlias1)
				 	dbclosearea()
				 endif 
				 
				//cNomDep := BA1->BA1_NOMUSR
				
			endif
			cNomDep := substr(BA1->BA1_NOMUSR,1,40)
			cMatDep := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)+Space(3)
			cCPFUsr := Iif(Empty(BA1->BA1_CPFUSR),BA1->BA1_CPFPRE,BA1->BA1_CPFUSR)
			
			BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
			
			// VALIDA BLOQUEIO TEMPORมRIO DA FAMอLIA
			if !Empty(BA3->BA3_DATBLO) 
				if (c_MotFamFn == BA3->BA3_MOTBLO)
					TRB->(DbSkip())
					Loop
				endif 
			endif 
			cPlaUsu	:= Iif(Empty(BA1->BA1_CODPLA),BA3->BA3_CODPLA,BA1->BA1_CODPLA)
			nValLim	:= BA3->BA3_YVLFAR
			
			If nValLim <= 0 .AND. (Empty(BA1->BA1_DATBLO) .or. (!Empty(BA1->BA1_DATBLO) .And. BA1->BA1_DATBLO >= dDatBas))
				aadd(aErro,{"Familia com valor limite de farmacia zerado! "+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)})
				TRB->(DbSkip())
				Loop
			Endif
			
			If Empty(cPlaUsu)
				aadd(aErro,{"Plano de usuario nao encontrado! Usuario: "+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)})
				TRB->(DbSkip())
				Loop
			Endif
			
			//cTipPla	:= Iif(cPlaUsu $ GetNewPar("MV_YPLMATE","0001,0002,0003,0004,0005,0006,0007,0008,0018"),"DM","DA")
			cTipPla	:= Iif(cPlaUsu $ GetNewPar("MV_YPLMATE","0001,0002,0003,0004,0018"),"DM","DA") // Paulo Motta
			
			cStatus := Iif(Empty(TRB->BF4_DATBLO) .Or. dDatBas <= TRB->BF4_DATBLO,"00","01")
			
			cLin := Space(1)+cEOL
			
			//If BA1->BA1_TIPUSU == "T"
				//cCpo := cMatTit+cMatDep+Substr(BA1->BA1_NOMUSR,1,40)+cTipPla+StrZero(nValLim*100,8)+cStatus+cCPFUsr
			//	cCpo := cCPFTit+Padr(cNomTit,40)+cMatTit+StrZero(nValLim*100,8)+cNascTit+cMatDep+Substr(BA1->BA1_NOMUSR,1,40)+dtos(BA1->BA1_DATNAS)+BA1->BA1_CPFUSR
			//Else // Dependente nao tem informacao de limite
				cCpo := cCPFTit+Padr(cNomTit,40)+cMatTit+StrZero(nValLim*100,8)+cNascTit+cMatDep+Substr(BA1->BA1_NOMUSR,1,40)+dtos(BA1->BA1_DATNAS)+BA1->BA1_CPFUSR
				//cCpo := cMatTit+cMatDep+Substr(BA1->BA1_NOMUSR,1,40)+cTipPla+"        "+cStatus+cCPFUsr
//			Endif 
			
			nTotExp++
			
			If !(U_GrLinha_TXT(cCpo,cLin))
				MsgAlert("ATENวรO! NรO FOI POSSอVEL GRAVAR CORRETAMENTE A LINHA ATUAL! OPERAวรO ABORTADA!")
				Return
			Endif
			
			TRB->(DbSkip())
			
		EndDo
		
		TRB->(DbCloseArea())
		U_Fecha_TXT()
		
		If Len(aErro) > 0
			PLSCRIGEN(aErro,{ {"Descri็ใo","@C",230} },"Inconsist๊ncias na exporta็ใo...",.T.)
		Endif
		
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Impressao do protocolo de exportacao.	  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If nLin > nQtdLin
			nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
		Endif
		
		@ nLin,000 PSay Replicate("-",63)
		nLin++
		@ nLin,000 PSay "GERAวรO DO ARQUIVO DE EXPORTAวรO FARMมCIA / RESUMO"
		nLin++
		@ nLin,000 PSay Replicate("-",64)
		nLin++
		
		/*
		For nCont := 1 to Len(aExp)
			@ nLin,000 PSay aExp[nCont,1]+Space(2)+aExp[nCont,2]+Space(3)+aExp[nCont,3]
			nLin++
		Next
		*/
		
		@ nLin,000 PSay Replicate("-",64)
		nLin++
		//@ nLin,000 PSay "Total de usuแrios exportados..: "+StrZero(Len(aExp),8)
		@ nLin,000 PSay "Total de usuแrios exportados..: "+StrZero(nTotExp,8)
		nLin++
		@ nLin,000 PSay "Total de erros encontrados....: "+StrZero(Len(aErro),8)
		nLin++
		
	Endif
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ParSX1       บAutor  ณJean Schulz     บ Data ณ  10/11/05   บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros para exportacao.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ParSX1()
	
	PutSx1(cPerg,"01",OemToAnsi("Cod Tp Proc De")	,"","","mv_ch1","C",02,0,0,"G","","B41","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("Cod Proced De")	,"","","mv_ch2","C",16,0,0,"G","","YBR","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03",OemToAnsi("Cod Tp Proc Ate")	,"","","mv_ch3","C",02,0,0,"G","","B41","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04",OemToAnsi("Cod Proced Ate")	,"","","mv_ch4","C",16,0,0,"G","","YBR","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"05",OemToAnsi("Data Inicial")		,"","","mv_ch5","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"06",OemToAnsi("Data Final")		,"","","mv_ch6","D",08,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ Atu_Var      บAutor  ณJean Schulz     บ Data ณ  25/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza variaveis de parametros para uso no relatorio.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Atu_Var()
	
	dDatBas	:= mv_par01
	cEmpDe	:= mv_par02
	cEmpAte	:= mv_par03
	cConDe	:= mv_par04
	cConAte	:= mv_par05
	cSubDe	:= mv_par06
	cSubAte	:= mv_par07
	
Return
