#include "rwmake.ch"
#include "TopConn.ch"

********************************
User  Function ImpNTrib()
********************************

Private cPerg := "ImpTrb"
Private aSx1  := {}

Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3","DEF01","DEF02"     ,"DEF03" ,"DEF04"  ,"DEF05"})
Aadd(aSx1,{cPerg  ,"01"   ,"Data de Baixa De......?","mv_ch1" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par01",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"02"   ,"Data de Baixa Ate.....?","mv_ch2" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par02",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"03"   ,"Tipo Fornecedor........?","mv_ch3" ,"C"   ,01       ,0        ,"C"  ,""     ,"mv_par03",""  ,"Fisico"  ,"Juridico","" ,""       ,""     })

fCriaSX1(cPerg,aSX1)

If !Pergunte(cPerg,.T.)
	Return
Endif 

fProcessa()

Return
         
*********************************
Static Function fProcessa()
*********************************
Local cQuery 	 := ""
Local cAbatim 	 := MV_CRNEG+"|"+MV_CPNEG+"|"+MVIRABT+"|"+MVCSABT+"|"+MVCFABT+"|"+MVPIABT+"|"+MVABATIM
Local cImpostos := MVISS+"|"+MVTAXA+"|"+MVTXA+"|"+MVINSS+"|"+"SES"
Local cNotIn	 := ""
Local cAliasTrb := GetNextAlias()
Local cTipoFj
Local aStru := SE2->(DbStruct())
Local lFa401Cmp := ExistBlock("FA401CMP") // Complemento de gravacao do SR4
Local nX, nY
Local bWhile 	 	 := { || .T. }
Local bFor   	 	 := { || .T. }
Local cFornUniao 	 := GetMv("MV_UNIAO")
Local aRendimentos := {}
Local nRendAnual	 := 0
Local cChaveAnt	 := ""
Local nAscan
Local lQuery := .F.
Local cCondicao := "" 
Local cMVIRNAT := SuperGetMv("MV_IRF",.T.,"IRF")
Local cFilAtu := cFilAnt
Local aRecno := {}

#IFDEF TOP
	If TcSrvType() != "AS/400"
		cNotIn := FormatIn(cAbatim+"|"+cImpostos+"|"+MVPROVIS+"|"+MVPAGANT,"|")
		lQuery := .T.
		
		cQuery := "SELECT A.E2_VALOR, A.E2_CODRET, A.E2_BAIXA, A.E2_FORNECE, A.E2_LOJA, A.E2_IRRF, A.E2_PREFIXO, A.E2_NUM, A.E2_PARCIR, A.E2_TIPO, A.E2_PIS, A.E2_PARCPIS, A.R_E_C_N_O_, SA2.R_E_C_N_O_ RECNOSA2, A.E2_ISS FROM " + RetSqlName("SE2") + " A "
		cQuery += " JOIN " + RetSqlName("SA2") + " SA2 ON "
		cQuery += " SA2.A2_FILIAL = '" + xFilial("SA2") + "' AND "
		cQuery += " A.E2_FORNECE = SA2.A2_COD AND "
		cQuery += " A.E2_LOJA = SA2.A2_LOJA AND "
		cQuery += " SA2.D_E_L_E_T_ = ' ' "
		cQuery += "WHERE 	"
		cQuery += " A.E2_FILIAL = '" + xFilial("SE2") + "' AND "
		cQuery += " A.E2_BAIXA >= '" + Dtos(Mv_par01) + "' AND "
		cQuery += " A.E2_BAIXA <= '" + Dtos(Mv_par02) + "' AND "
		cQuery += " A.E2_TIPO NOT IN " + cNotIn + " AND "
		cQuery += " A.E2_DIRF = '3' AND "
		cQuery += "NOT EXISTS ( SELECT	B.E2_NUM FROM " + RetSqlName("SE2") + " B "
		cQuery += "			        WHERE  B.E2_FILIAL = '"+xFilial("SE2") + "' AND "
		cQuery += "           				B.E2_PREFIXO = A.E2_PREFIXO AND "
		cQuery += "				B.E2_NUM = A.E2_NUM AND "
		cQuery += "				(B.E2_PARCELA = A.E2_PARCIR OR B.E2_PARCELA = A.E2_PARCPIS OR B.E2_PARCELA = A.E2_PARCCOF OR B.E2_PARCELA = A.E2_PARCSLL) AND "
		cQuery += "	  			B.E2_TIPO = '"+MVTAXA +"' AND "
		cQuery += "				B.E2_FORNECE = '"+cFornUniao+"' AND "
		cQuery += "				B.E2_LOJA = '00' AND 
		cQuery += " 			B.D_E_L_E_T_ = ' ') AND "
		cQuery += " A.D_E_L_E_T_ = ' ' "
		
		cQuery := ChangeQuery(cQuery)
		
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasTrb, .F., .T.)
   
		For nX := 1 to Len(aStru)
			If aStru[nX,2] != 'C' .And. FieldPos(aStru[nX,1]) > 0 // Se existir o campo na Query
				TCSetField(cAliasTrb, aStru[nX,1], aStru[nX,2],aStru[nX,3],aStru[nX,4])
			Endif
		Next
	Else
		cCondicao := " SE2->E2_DIRF == '3' "

		cAliasTrb := "SE2"

		NEWSE2->(DbSetOrder(1))
		SE2->(DbSetOrder(7))
		SE2->(MsSeek(xFilial("SE2")+DTOS(MV_PAR01),.T.))
		bWhile := { || SE2->E2_FILIAL == xFilial("SE2") .And. SE2->E2_BAIXA <= MV_PAR02 }
		bFor   := { || ! SE2->E2_TIPO $ cAbatim+"|"+cImpostos+"|"+MVPROVIS+"|"+MVPAGANT .And.;
							&cCondicao .And.;					
							NEWSE2->(!MsSeek(xFilial("SE2")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCIR+MVTAXA+cFornUniao+"00")))  .And.;
							NEWSE2->(!MsSeek(xFilial("SE2")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCPIS+MVTAXA+cFornUniao+"00"))) .And.;
							NEWSE2->(!MsSeek(xFilial("SE2")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCCOF+MVTAXA+cFornUniao+"00"))) .And.;
							NEWSE2->(!MsSeek(xFilial("SE2")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCSLL+MVTAXA+cFornUniao+"00")))	}
	Endif	
#ELSE

	cCondicao := " SE2->E2_DIRF == '3' 

	NEWSE2->(DbSetOrder(1))
	cAliasTrb := "SE2"
	SE2->(DbSetOrder(7))
	SE2->(MsSeek(xFilial("SE2")+DTOS(MV_PAR01),.T.))
	bWhile := { || SE2->E2_FILIAL == xFilial("SE2") .And. SE2->E2_BAIXA <= MV_PAR02 }
	bFor   := { || ! SE2->E2_TIPO $ cAbatim+"|"+cImpostos+"|"+MVPROVIS+"|"+MVPAGANT .And.;
						&cCondicao .And.;
						NEWSE2->(!MsSeek(xFilial("SE2")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCIR+MVTAXA+cFornUniao+"00")))  .And.;
						NEWSE2->(!MsSeek(xFilial("SE2")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCPIS+MVTAXA+cFornUniao+"00"))) .And.;
						NEWSE2->(!MsSeek(xFilial("SE2")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCCOF+MVTAXA+cFornUniao+"00"))) .And.;
						NEWSE2->(!MsSeek(xFilial("SE2")+SE2->(E2_PREFIXO+E2_NUM+E2_PARCSLL+MVTAXA+cFornUniao+"00"))) }
#ENDIF

While (cAliasTrb)->(!Eof()) .And. Eval(bWhile)

	If Eval(bFor)
		// Posiciona no SA2
		If lQuery
			SA2->(MsGoto((cAliasTrb)->RECNOSA2))
		Else
			SA2->(MsSeek(xFilial("SA2")+(cAliasTrb)->(E2_FORNECE+E2_LOJA)))
		Endif	
		
		//Verifico o tipo da pessoa do Fornecedor (Fisico ou Juridico.
		//Em branco ou X - Outros, serao verificados pelo CGC
		If Empty(SA2->A2_TIPO) .or. !(SA2->A2_TIPO $ "F/J")
			cTipoFj := Iif(Len(AllTrim(SA2->A2_CGC	)) > 11,"2","1")		
		Else			
			cTipoFj := IIf(SA2->A2_TIPO="F","1","2")
		Endif
		
		// Se for um fornecedor definido no parametro
		If Val(cTipoFj) == mv_par03 

			// Gera novo numero de matricula, caso ainda nao exista no cabecalho (SRL)
			If !SRL->(MsSeek(xFilial("SRL")+SM0->M0_CGC+(cAliasTrb)->E2_CODRET+cTipoFj+SA2->A2_CGC))
				If (nAscan:=Ascan(aRendimentos, {|e| e[5]+e[2]+e[3] == (cAliasTrb)->E2_CODRET+cTipoFj+SA2->A2_CGC })) == 0
					cRaMat := GetSxENum("SRL", "RL_MAT")
					cRaMat := If(Val(SRA->RA_MAT) < 900000 .And. Val(cRaMat) < 900000, "900000",cRaMat)			
					ConfirmSx8()
				Else
					cRaMat := aRendimentos[nAscan,12]
				Endif	
			Else	
				cRaMat := SRL->RL_MAT
			Endif	
			// Se existir o ano na chave do SR4
			If SR4->(FieldPos("R4_ANO")) > 0 .And. "R4_ANO" $ SR4->(IndexKey()) 
		  		// R4_FILIAL+R4_MAT+R4_CPFCGC+R4_CODRET+R4_ANO+R4_MES+R4_TIPOREN
		  		cChaveSr4 := xFilial("SR4")+cRaMat+SA2->A2_CGC+(cAliasTrb)->E2_CODRET+STRZERO(YEAR((cAliasTrb)->E2_BAIXA),4)+STRZERO(MONTH((cAliasTrb)->E2_BAIXA),2)
		  	Else
		  		// R4_FILIAL+R4_MAT+R4_CPFCGC+R4_CODRET+R4_MES+R4_TIPOREN
				cChaveSr4 := xFilial("SR4")+cRaMat+SA2->A2_CGC+(cAliasTrb)->E2_CODRET+STRZERO(MONTH((cAliasTrb)->E2_BAIXA),2)
			Endif
			
				
			
			// Gera valor do Rendimento do IR
			If (nAscan:=Ascan(aRendimentos, {|e| e[1] == cChaveSr4+"A"})) == 0
				Aadd(aRendimentos, {	cChaveSr4+"A",;                                  //[01] Chave
											cTipoFj,;                                        //[02] Pessoa Juridica
											SA2->A2_CGC,;                                    //[03] CGC
											STRZERO(MONTH((cAliasTrb)->E2_BAIXA),2),;        //[04] Mês da Baixa
											(cAliasTrb)->E2_CODRET,;                         //[05] Codigo de Retensao
											STRZERO(YEAR((cAliasTrb)->E2_BAIXA),4),;         //[06] Ano da Baixa
											(cAliasTrb)->E2_VALOR + (cAliasTrb)->E2_ISS,;    //[07] Valor
											SA2->A2_NOME,;                                   //[08] Nome Fornecedor
											Alltrim(SA2->A2_END) + Alltrim(SA2->A2_NR_END),; //[09] Endereco
											SA2->A2_EST,;                                    //[10] Estado
											SA2->A2_BAIRRO,;                                 //[11] Bairro
											cRaMat })                                        //[12] Matricula

			Else
				aRendimentos[nAscan,7] += (cAliasTrb)->E2_VALOR + (cAliasTrb)->E2_ISS
			Endif
			#IFDEF TOP
				If TcSrvType() != "AS/400"                                 
						Aadd(aRecno, (cAliasTrb)->R_E_C_N_O_)										
				Else	
			#ENDIF
					Reclock("SE2")
					If !lDtDirf
						// Se nao existir a data de processamento da DIRF, desmarca o flag
						SE2->E2_DIRF := If(SE2->E2_DIRF == "1", "2", "N") // Desmarca registro para nao gera-lo no proximo processamento
					Else
						// Senao, grava a data de processamento da DIRF
						SE2->E2_DTDIRF := dDataBase
					Endif	
					MsUnlock()
			#IFDEF TOP
				Endif
			#ENDIF
		Endif
		
	Endif	
	
	(cAliasTrb)->(DbSkip())

Enddo

nRendAnual	:= 0
cChaveAnt	:= ""
nLen        := Len(aRendimentos)

// Ordena por Fornecedor + Codigo de retencao
aSort(aRendimentos,,,{ |x,y| x[3]+x[5] <  y[3]+y[5] } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ So grava para quem teve rendimento superior a 6.000 no ano,  ³
//³ conforme artigo 1o. da IN. SRF No. 511/2005.		     		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 To nLen
	
	// Soma os rendimentos do ano do mesmo fornecedor
	If Empty(nRendAnual) .Or. cChaveAnt != aRendimentos[nX,3]
	   nRendAnual := 0
	   cChaveAnt  := (aRendimentos[nX,3] + aRendimentos[nX,5])
	   For nY := nX To nLen
	   	// Mudou de fornecedor ou codigo de retencao
	   	If cChaveAnt != (aRendimentos[nY,3] + aRendimentos[nY,5])
	   		Exit
	   	Endif
	   	nRendAnual += aRendimentos[nY,7]
	   Next	
	Endif	   
	
	// Grava SR4 apenas para fornecedores com rendimento anual maior que 6.000,00
	If nRendAnual > 6000 
	//.And. aRendimentos[nX,12]
		If !SR4->(MsSeek(aRendimentos[nX,1]))
			// Pesquisa cabecalho da DIRF
		//	If !SRL->(MsSeek(xFilial("SRL")+SM0->M0_CGC+aRendimentos[nX,5]+aRendimentos[nX,2]+aRendimentos[nX,3])) 
			If !SRL->(MsSeek(xFilial("SRL")+aRendimentos[nX,12]+aRendimentos[nX,2]+aRendimentos[nX,3]+aRendimentos[nX,5]))
				Reclock("SRL", .T.)
				
				If Empty(aRendimentos[nX,3])
				   Loop
				Endif
			  
				SRL->RL_FILIAL  := xFilial("SRL")
				SRL->RL_MAT     := aRendimentos[nX,12]
				SRL->RL_CODRET  := aRendimentos[nX,5]
				SRL->RL_TIPOFJ  := aRendimentos[nX,2]
				SRL->RL_CPFCGC  := aRendimentos[nX,3]
				SRL->RL_BENEFIC := aRendimentos[nX,8]
				SRL->RL_ENDBENE := aRendimentos[nX,9]
				SRL->RL_UFBENEF := aRendimentos[nX,10]
				SRL->RL_COMPLEM := aRendimentos[nX,11]
				SRL->RL_CGCFONT := SM0->M0_CGC
				SRL->RL_NOMFONT := SM0->M0_NOMECOM	
				If SRL->(FieldPos("RL_ORIGEM")) > 0
				    SRL->RL_ORIGEM := "2"
				Endif
				MsUnlock()
				ConfirmSx8()
			Endif
			Reclock("SR4", .T.)
			SR4->R4_FILIAL  := xFilial("SR4")
			SR4->R4_MAT     := aRendimentos[nX,12]
			SR4->R4_CPFCGC  := aRendimentos[nX,3]
			SR4->R4_MES     := aRendimentos[nX,4]
			SR4->R4_TIPOREN := "A"
			SR4->R4_CODRET  := aRendimentos[nX,5]
			If SR4->(FieldPos("R4_ANO")) > 0
	   		SR4->R4_ANO  := aRendimentos[nX,6]
	   	    Endif
			If SR4->(FieldPos("R4_ORIGEM")) > 0
			SR4->R4_ORIGEM := "2"
			Endif
			
			If lFa401Cmp
				// Utilizado para gravar campos complementares do SR4
				ExecBlock("FA401CMP", .F.,.F.)
			Endif
		Else
			Reclock("SR4", .F.)
		Endif
		SR4->R4_VALOR   += aRendimentos[nX,7]
		MsUnlock()
	Endif	
	cChaveAnt	:= (aRendimentos[nX,3] + aRendimentos[nX,5])
Next

Return Nil

**************************
Static Function fCriaSx1()
**************************

Local Z 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local X1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

SX1->(DbSetOrder(1))

If !SX1->(DbSeek(cPerg+aSx1[Len(aSx1),2]))
	SX1->(DbSeek(cPerg))
	While SX1->(!Eof()) .And. Alltrim(SX1->X1_GRUPO) == cPerg
		SX1->(Reclock("SX1",.F.,.F.))
		SX1->(DbDelete())
		SX1->(MsunLock())
		SX1->(DbSkip())
	End
	For X1:=2 To Len(aSX1)
		SX1->(RecLock("SX1",.T.))
		For Z:=1 To Len(aSX1[1])
			cCampo := "X1_"+aSX1[1,Z]
			SX1->(FieldPut(FieldPos(cCampo),aSx1[X1,Z] ))
		Next
		SX1->(MsunLock())
	Next
Endif

Return

