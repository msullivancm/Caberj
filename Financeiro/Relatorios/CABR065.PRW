#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR065   º Autor ³Altamiro              º Data ³ 01/10/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para importacao e Critica de NF carioca             º±±
±±º          ³ conforme arquivo importado do site da receita municipal    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR065
	
	Local cMsg			:= ""
	Private cDpj        := 'Não'
	private cImp        := 'Não'
	Private oLeTxt
	Private lAbortPrint :=.F.
	Private cPerg       := "CABR065"
	Private cTitulo     := "Importa e Critica NF Carioca "
	Private lpvez       :=.T.
	Private cTpCrit     :=" "
	Private lImporta    := .F.
	Private f_ok        := .F.
	Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado
	
	private cCritica1   := ' '
	Private cEmpresa    := iIf( cEmpAnt=='01', 'C', 'I')
	private nNt         := ' '
    Private _cGrupag    := ' '	

	Private ccodrda := ' ' // MMT 

	SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")
	
	cMsg += " Este programa ira fazer a leitura do arquivo CSV  relativo as   " + CRLF
	cMsg += " NF emitidas contra a Caberj/Integral. A origem dos dados é o    " + CRLF
	cMsg += " arquivo no formato CSV baixado do site da NOTA FISCAL CARIOCA  " + CRLF
	
	oDlg1      := MSDialog():New( 095,232,368,705,"Leitura de Arquivo CSV",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      := TGroup():New( 008,012,100,224,"Arquivo CSV",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 020,020,{||cMsg},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,196,076)
	oSBtn1     := SButton():New( 112,140,05,{||AjustaSX1(cPerg)}		,oDlg1,,"", )
	oSBtn2     := SButton():New( 112,168,01,{||OkLeTxt(),oDlg1:End()}	,oDlg1,,"", )
	oSBtn3     := SButton():New( 112,196,02,{||oDlg1:End()}			,oDlg1,,"", )
	
	oDlg1:Activate(,,,.T.)
	
Return

*****************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ OKLETXT  º Autor ³                    º Data ³  09/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao chamada pelo botao OK na tela inicial de processamenº±±
±±º          ³ to. Executa a leitura do arquivo texto.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function OkLeTxt
	
	//Local nCont			:= 0
	
	Private  cNomeArq	:= ""
	Private  cMesAdi	:= ""
	Private  cAnoAdi	:= ""
	Private  cCritica   := " "
	Private  cCritImp   := " "
	Private  aErro		:= {}
	Private  aOk		:= {}
	Private  aDados     := {}
	Private  aDados1    := {}
	Private  acabec1    :={"N.Nf","Status", "Dt.Emissao","CGC/CNPJ","Insc.Mun.","Razão Social" , "Aliquota","Vlr. Tot." , "Outras Retenções","Vlr Cofins","Vlr Csll" ,"Vlr Inss" ,"Vlr Ir"   ,"Vlr Pis","Vlr Iss"    ,"Reten Iss","Dt Canc", "Criticas","Saldo_Tit" , "Ident.Registro", "ident.Critica","Grp Pagt" }
	Private  nTotS      :=0.00
	Private  nTotIrS    :=0.00
	Private  nTotIssS   :=0.00
	Private  nTotCofS   :=0.00
	Private  nTotCslS   :=0.00
	Private  nTotPisS   :=0.00
	Private  nTotdecS   :=0.00
	Private  nTotC      :=0.00
	Private  nTotIrC    :=0.00
	Private  nTotIssC   :=0.00
	Private  nTotCofC   :=0.00
	Private  nTotCslC   :=0.00
	Private  nTotPisC   :=0.00
	Private  nTotdecC   :=0.00
	Private  cUsua      := SubStr(cUSUARIO,7,15)
	
	Pergunte(cPerg,.F.)
	
	cNomeArq	:= mv_par01
	dDtInic		:= dtos(mv_par02)
	dDtFim		:= dtos(mv_par03)
	cMesComp    := mv_par04
	cAnoComp	:= mv_par05
	cGExcel     := mv_par06
	cLancNf     := mv_par07
	nBaxado     := mv_par08
	
	If !File(cNomeArq)
		MsgStop("Arquivo Inválido! Programa encerrado.")
		Close(oLeTxt)
		Return
	End
	

	Processa({||Processa1()}, cTitulo, "", .T.)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Libera impressao                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if mv_par09 != 4
		GeraRel1()
	EndIf
	
	MsgInfo("Processo finalizado")
	
Return

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Processa1()
	
	Local aTotImp := {0,0,0}
	
	If !File(cNomeArq)
		MsgAlert("Arquivo texto: CLIENTE.TXT não localizado","Atencao!")
		Return
	Endif
	
	FT_FUSE(cNomeArq)
	FT_FGOTOP()
	
	ProcRegua(FT_FLASTREC())
	
	nCont := 0
	
	While !FT_FEOF()
		
		IncProc('Processando...')     
		
		cBuffer := FT_FREADLN()		//joga o conteudo da linha na variavel
		FT_FSKIP()
		aDados := separa(cBuffer,';',.T.)
		if len(adados) < 73
			loop
		EndIf
		if !(adados[01] $ "20|30") .OR. adados[03] = '2' .OR. trim(nNt)=='0'
			loop
		EndIf
		
		cTpCrit := " "
		cvlr := noround(val(strtran(strtran(adados[51],'.',''),',','.')),2)

        If cEmpresa = 'I' .and. ( Substr(adados[02],1,4) = '2020' .or.  Substr(adados[02],1,4) = '2022')
		   
		   nNt  := alltrim(str(Val(Substr(adados[02],5,11))))
        
		Else 
		
		   nNt  := adados[02]
   
		EndIf 		
		
		cQuery := " select zb_anomes , zb_codrda , zb_fornece, zb_prefixo , zb_obs ,zb_titulo , zb_tipo, zb_vinform , zb_vbruto , a2_cgc , a2_nome , "
		cQuery += "   e2_valor , e2_iss , e2_inss , e2_irrf , e2_vretcof, e2_vretcsl , e2_vretpis , e2_decresc , e2_sddecre , e2_fornece , "
		cQuery += " (e2_valor + e2_iss + e2_inss + e2_irrf + e2_vretcof + e2_vretcsl + e2_vretpis ) vlr_tot , e2_saldo , e2_movimen , e2_baixa , E2_VENCREA ,zb_nota, e2_Ylibpls ,"
		cQuery += " e2_pllote,e2_codrda , e2_fornece , e2_prefixo , e2_num , e2_tipo, E2_PARCELA, e2_loja
		cQuery += " from  " + RetSqlName("SA2") + " SA2 ," + RetSqlName("SE2") + " SE2, "  + RetSqlName("SZB") + " SZB "
		cQuery += "  where zb_FILIAL = '" + xFilial("SZB") +"' and szb.D_E_L_E_T_ =  ' ' and a2_filial = '" + xFilial("SA2") +"' and sa2.d_E_L_E_T_ = ' ' and e2_filial = '" + xFilial("SE2") +"' and se2.d_E_L_E_T_ = ' ' "
		cQuery += "  and sa2.a2_COD = zb_fornece "
		
		If nBaxado = 1
			cQuery += "and e2_saldo = 0 "
		elseIf nBaxado = 2
			cQuery += "and e2_saldo > 0 "
		EndIF
		
		cQuery += "  and zb_emissao =  '"+ dtos(ctod(substr(adados[05],01,10)))+"' "

		    cQuery += "  and  zb_nota = '"+nNt+"' "

		cQuery += "  and  substr(a2_cgc,1,8) = '"+ substr(adados[11],1,2)+substr(adados[11],4,3)+substr(adados[11],8,3)+"' " //+substr(adados[11],12,4)+substr(adados[11],17,2)+"' "
		cQuery += "  and zb_prefixo = e2_prefixo and zb_titulo = e2_num and zb_tipo =  e2_tipo and zb_fornece = e2_fornece "
		
		If Select(("TMP")) <> 0
			("TMP")->(DbCloseArea())
		Endif
		
		TCQuery cQuery Alias "TMP" New
	
		dbSelectArea("TMP")
		
		tmp->(dbGoTop())
		cCritica:= " "
		Ident:= " "
		nLocaliz    := 1

        if !empty(tmp->e2_CODRDA)
  		    a:=fTrazGrp(tmp->e2_CODRDA)
 		EndIf 

		if empty(tmp->vlr_tot) .OR. tmp->vlr_tot == 0.00
			
			nLocaliz    := 2
			cQuery := " select  a2_cgc , a2_nome ,   e2_valor , e2_iss , e2_inss , e2_irrf , e2_vretcof, e2_vretcsl , e2_vretpis , e2_decresc , e2_sddecre ,  "
			cQuery += " (e2_valor + e2_iss + e2_inss + e2_irrf + e2_vretcof + e2_vretcsl + e2_vretpis ) vlr_tot , e2_saldo , e2_movimen , e2_baixa ,E2_VENCREA ,"
			cQuery += "  e2_pllote,e2_codrda , e2_fornece , e2_prefixo , e2_num , e2_tipo, E2_PARCELA, e2_loja ,E2_YLIBPLS ,'Sem NF' zb_nota from  " + RetSqlName("SA2") + " SA2 ," + RetSqlName("SE2") + " SE2 "
			cQuery += "  where a2_filial = '" + xFilial("SA2") +"'   and sa2.d_E_L_E_T_ = ' ' and e2_filial = '" + xFilial("SE2") +"'  and se2.d_E_L_E_T_ = ' 'and sa2.a2_COD = e2_fornece "
			cQuery += "  and e2_emissao >=  '"+dDtInic+"' and e2_emissao <=  '"+dDtFim+"' "
			
			If nBaxado = 1
				cQuery += "and e2_saldo = 0 "
			ElseIf nBaxado = 2
				cQuery += "and e2_saldo > 0 "
			EndIF
			
			cQuery += "and  SUBSTR(a2_cgc,1,8) = '"+ substr(adados[11],1,2)+substr(adados[11],4,3)+substr(adados[11],8,3)+"' "
			cQuery += "and (e2_valor + e2_iss + e2_inss + e2_irrf + e2_vretcof + e2_vretcsl + e2_vretpis ) = "+ alltrim(strtran(transform(cvlr,"@E 999999999.99"),',','.'))
			cQuery +=" and e2_codrda <> ' ' and substr(e2_pllote,1,6) = '"+cAnoComp+cMesComp +"' "
			//and e2_saldo > 0"
			
			If Select("TMP") > 0
				("TMP")->(DbCloseArea())
			Endif
			
			//eecview(cQuery)

			TcQuery cQuery Alias "TMP" New
			
			dbSelectArea("TMP")
			tmp->(dbGoTop())
			
		EndIf
		
        a:=fTrazGrp(tmp->e2_CODRDA)
		cChave := GetAdvFVal("SA2","A2_COD",XfILIAL("SA2")+strtran(strtran(strtran(adados[11],".",""),"/",""),"-",""),3,"")

		//ver_dpj(GetAdvFVal("SA2","A2_COD",XfILIAL("SA2")+strtran(strtran(strtran(adados[11],".",""),"/",""),"-",""),3,"") ) // MMT
		ver_dpj(cChave ) // MMT

		//strtran(strtran(strtran(adados[11],".",""),"/",""),"-","")

		lImporta:= .F.
		if empty(tmp->vlr_tot) .OR. tmp->vlr_tot == 0.00
			nLocaliz    := 0
			cCritica := ' Registro Nao localizado'
			cCritica1:= 'Faturamento não identificado , entre em contato com seu analista de relacionamento '
			cTpCrit :=cTpCrit+'1'
			lImporta:= .F.
		ElseIf nLocaliz    = 1
			Ident:= tmp->(zb_codrda +' - '+ zb_fornece +' - '+ zb_prefixo +' - '+ zb_titulo +' - '+ zb_tipo +' - '+ a2_nome)
		elseIf nLocaliz    = 2
			if tmp->e2_codrda <> ' '
				Ident:= tmp->(e2_codrda +' - '+ e2_fornece +' - '+ e2_prefixo +' - '+ e2_num +' - '+ e2_tipo +' - '+ a2_nome)
				//inclusao Nf Automatica
				lImporta:= .T.
			else
				Ident:= tmp->(e2_fornece +' - '+ e2_prefixo +' - '+ e2_num +' - '+ e2_tipo +' - '+ a2_nome)
			EndIf
		EndIf
		
		if !empty(tmp->vlr_tot) .and. tmp->vlr_tot != 0.00
			
			cvlr := noround(val(strtran(strtran(adados[51],'.',''),',','.')),2)
			nTotS+=cvlr
			
			if cvlr != tmp->vlr_tot
				cCritica+= ' ! Vlr Total da Nf Divergente , N.Fiscal '+  str(cvlr)+ ' <>  Titulo ' + str(tmp->vlr_tot)
				cCritica1:= 'valor bruto da NF Divergente , favor conferir no link de NF no site'
				cTpCrit :=cTpCrit+'2'
				lImporta:= .F.
			endIf
			
			cvlr := noround(val(strtran(strtran(adados[58],'.',''),',','.')),2)
			nTotIrS+=cvlr
			
			if  tmp->e2_irrf > 9.99
				if cvlr != tmp->e2_irrf
					cCritica+= ' !  Vlr do Irrf Divergente , N.Fiscal'+  str(cvlr) + ' <> Titulo ' + str(tmp->e2_irrf)
					cCritica1:= 'Divergencia de Impostos , favor conferir o valor no link de NF no site'
					cTpCrit :=cTpCrit+'3'
					lImporta:= .F.
				endIf
			endIf
			
			if adados[63] = '1' // altamiro aki .and.  If cEmpresa = 'C'
				
				cvlr := noround(val(strtran(strtran(adados[61],'.',''),',','.')),2)
				nTotIssS+=cvlr
				
				if cvlr != tmp->e2_iss
					cCritica+= ' ! Vlr do Iss Divergente , N.Fiscal'+ str(cvlr) + '  <> Titulo ' + str(tmp->e2_iss)
					cCritica1:= 'Divergencia de Impostos , favor conferir o valor no link de NF no site'
					cTpCrit :=cTpCrit+'4'
					lImporta:= .F.
				endIf
				
			ElseIf tmp->e2_iss != 0.00
				cCritica+= ' ! Vlr do Iss Indevido ,Fornecedor isento e/ou Retem Iss -  Titulo = ' + str(tmp->e2_iss)
				cCritica1:= 'Divergencia de Impostos , favor conferir o valor no link de NF no site'
				cTpCrit :=cTpCrit+'5'
				lImporta:= .F.
			endIf
			
			cvlr := noround(val(strtran(strtran(adados[55],'.',''),',','.')),2)
			nTotCofS+=cvlr
			
			if cvlr != tmp->e2_vretcof
				cCritica+= ' ! Vlr do Cofins Divergente , N.Fiscal'+  str(cvlr)+ ' <> Titulo ' + str(tmp->e2_vretcof)
				cCritica1:= 'Divergencia de Impostos , favor conferir o valor no link de NF no site'
				cTpCrit :=cTpCrit+'6'
				lImporta:= .F.
			endIf
			
			cvlr := noround(val(strtran(strtran(adados[56],'.',''),',','.')),2)
			nTotCslS+=cvlr
			
			if cvlr != tmp->e2_vretcsl
				cCritica+= 'Vlr do Csll Divergente , N.Fiscal'+  str(cvlr) + ' <> Titulo ' + str(tmp->e2_vretcsl)
				cCritica1:= 'Divergencia de Impostos , favor conferir o valor no link de NF no site'
				cTpCrit :=cTpCrit+'7'
				lImporta:= .F.
			endIf
			
			cvlr := noround(val(strtran(strtran(adados[59],'.',''),',','.')),2)
			nTotPisS+=cvlr
			
			if cvlr != tmp->e2_vretpis
				cCritica+= ' - Vlr do pis Divergente , N.Fiscal'+  str(cvlr) + ' <> Titulo ' + str(tmp->e2_vretpis)
				cCritica1:= 'Divergencia de Impostos , favor conferir o valor no link de NF no site'
				cTpCrit :=cTpCrit+'8'
				lImporta:= .F.
			endIf
			if tmp->e2_Ylibpls != 'N'
				if tmp->zb_nota != nNt
					cCritica+= ' - Titulo com N.F. ' +tmp->zb_nota+ ' ja Digitada divergente da Nf.Importada ' + nNt
					cCritica1:= 'Titulo com nota fiscal ja digitada divergente da atual'
					cTpCrit :=cTpCrit+'14'
					lImporta:= .F.
				Elseif tmp->e2_Ylibpls = 'L'
					cCritica+= ' -Titulo Com Nota Fiscal  '+ nNt+' Já Digitada Mas NÃo Liberado para Pagamento'
					cCritica1:= 'Titulo com nota fiscal ja digitada , mas nao liberado para pagamento '
					cTpCrit :=cTpCrit+'15'
					lImporta:= .F.
				Else
					cCritica+= ' -Titulo Com Nota Fiscal  '+ nNt+' Já Digitada E Liberado para Pagamento'
					cCritica1:= 'Titulo com nota fiscal  digitada e liberado para pagamento '
					cTpCrit :=cTpCrit+'16'
					lImporta:= .F.
					if mv_par10 == 2 .and. tmp->e2_iss > 0
						//           nReg := tmp->RECNO()
						trocavenc(xFilial("SE2"),TMP->ZB_Prefixo,TMP->ZB_TITULO,mv_par11)
						//           DbSelectArea("SE2")
						//           dbgoto(nReg)
					EndIf
				EndIf
			endIf
			
			cvlr := noround(val(strtran(strtran(adados[60],'.',''),',','.')),2)
			nTotdecS+=cvlr
			
			if cvlr != tmp->e2_decresc
				lEVlrDes:=.T.
			endIf

			If nLocaliz <> 2
				IF  "NF DIGITADA COM SUCESSO" $ UPPER(TMP->ZB_OBS) .and. TMP->E2_SALDO = 0 
	    			 msgBox("Uma ou mais notas fiscais já digitadas e titulo baixado, não é permitida a inclusão","Saldo zerado:","INFO")		
				Endif
			Endif

			iF SUBSTR(tmp->a2_cgc,9,6) <> substr(adados[11],12,4)+substr(adados[11],17,2)
				cCritica+= ' Parte final do GCG  Invalida ou refere-se a filial '
				cTpCrit :=cTpCrit+'9'
			EndIf
			
		EndIf
		
		nTotC   +=tmp->vlr_tot
		nTotIrC +=tmp->e2_irrf
		nTotIssC+=tmp->e2_iss
		nTotCofC+=tmp->e2_vretcof
		nTotCslC+=tmp->e2_vretcsl
		nTotPisC+=tmp->e2_vretpis
		nTotdecC+=tmp->e2_decresc
		
		dDtEmis:=  substr(adados[05],1,10)
		
		cImp    :='Não'
		
		if !empty(cCritica) .and. lImporta == .F.
			
			Grv_Dados(lImporta , cTpCrit)
			
			Ident += cCritica
			critica:='SIM'
			if !empty (tmp->e2_fornece)
				ver_dpj(tmp->e2_fornece)
			EndIf

		else
			If lImporta == .T. .and. mv_par07 = 1
				
				Grv_Dados(lImporta , cTpCrit)
				
				cImp    :='Sim'
				lImporta := .F.
				ver_dpj(tmp->e2_fornece)

			elseif lImporta = .F. .and. mv_par07 = 1
				cCritica += ' - Nf Não Importada - Nf Já Digitado ou titulo financeiro '
				
				cTpCrit :=cTpCrit+'10'
				cImp    :='Sim'
				ver_dpj(tmp->zb_fornece)
			EndIf
			
			if !empty(cCritica) 
				Ident+= cCritica
				critica:='SIM'
			else
				critica:='NAO'
				Ident+= cCritImp
			endIf
			
		endIf
		
		// Totalizador de notas importadas - 17/07/2018
		if AllTrim(cImp) == 'Não'
			aTotImp[2] += 1
		else 	
			aTotImp[1] += 1
		endif 
		aTotImp[3] += val(strtran(adados[51],',','.'))
		//                { "N.Nf","Status"     , "Dt.Emissao","CGC/CNPJ","Insc.Mun.","Razão Social" , "Aliquota","Vlr. Tot." , "Outras Retenções","Vlr Cofins","Vlr Csll" ,"Vlr Inss" ,"Vlr Ir"   ,"Vlr Pis","Vlr Iss"    ,"Reten Iss","Dt Canc", "Criticas"    ,"Saldo_Tit" , "Ident.Registro", "ident.Critica"}
		aAdd(aDados1,   {nNt,;
		                 adados[03] ,;
		                 dDtEmis    ,;
						 adados[11] ,;
						 adados[12] ,;
						 adados[14] ,;
						 adados[50] ,;
						 adados[51] ,;
						 adados[60] ,;
						 adados[55] ,;
						 adados[56] ,;
						 adados[57] ,;
						 adados[58] ,;
						 adados[59] ,;
						 adados[61] ,;
						 adados[63] ,;
						 adados[64] ,;
						 critica    ,;
						 Transform(tmp->e2_saldo,"@E 99,999,999.99"),;
					     ident      ,;
						 cTpCrit    ,;
						 cDpj       ,;
						 cImp		,;
						 Iif (_cGruPag $ GETMV("MV_XGRPPLS"),'Interior','Grd Rio') ,;
						 cCodRda})
		
		cDpj:='Não'
		cCodRda := ""
		lImporta:= .F.
	EndDo
	
	
	aAdd(aDados1,   {"QUANTIDADE DE NOTAS - "+cValToChar(aTotImp[1]+aTotImp[2])+". Notas Importadas - "+cValToChar(aTotImp[1])+". Notas não importadas - "+cValToChar(aTotImp[2])+"."+" VALOR TOTAL DE NOTAS - "+cValToChar(Transform(aTotImp[3],'@E 999,999,999,999.99'))+".", "","","","","","","","","","","","","","","","","","","" })
	aAdd(aDados1,   {"____________________________", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"____________________________", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"    Codigos das Criticas    ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"____________________________", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {" 1 - Regsitro Nao localizado ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {" 2 - Vlr Total da Nf Divergente  ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {" 3 - Vlr do Irrf Divergente  ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {" 4 - Vlr do Iss Divergente ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {" 5 - Vlr do Iss Indevido", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {" 6 - Vlr do Cofins Divergente", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {" 7 - Vlr do Csll Divergente ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {" 8 - Vlr do pis Divergente ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {" 9 - Parte final do GCG  Invalida ou refere-se a filial", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"10 - Nf Não Importada ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"11 - Nf entregue fora do prazo ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"12 - Forncedor Com deposito Judicial ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"13 - Nota Fiscal Já Foi Usada em Outro Titulo ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"14 - Titulo Com Nota Fiscal Já Digitada Divergente da Atual ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"15 - Titulo Com Nota Fiscal Já Digitada Mas NÃo Liberado para Pagamento ", "","","","","","","","","","","","","","","","","","",""})
	aAdd(aDados1,   {"16 - Titulo Com Nota Fiscal Já Digitada E Liberado para Pagamento ", "","","","","","","","","","","","","","","","","","",""})
	
	DlgToExcel({{"ARRAY","Relação Conferencia NF " ,aCabec1,aDados1}})
	
	FT_FUSE()		//fecha arquivo!!!
	
Return

***************************************************************************************************

Static Function ver_dpj(cod_fornece)
	
	Local lRet  := .F.
	Local aArea := GetArea()

	cQuery := " SELECT A2_YDDPJ "
	cQuery += " FROM " + RetSqlName("SA2")
	cQuery += " WHERE D_E_L_E_T_ = ' ' "
	cQuery += " AND A2_FILIAL    =  ' '"
	cQuery += " AND A2_COD       =  '" +cod_fornece+ "'"
	
	// cQuery := ChangeQuery(cQuery)
	
	If Select("TMP1") <> 0
		DbSelectArea("TMP1")
		DbCloseArea()
	Endif
	
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery), 'TMP1', .F., .T.)
	dbselectarea("TMP1")
	cDpj := 'Não'
	If !Empty (TMP1->A2_YDDPJ)
		cCritImp	+= ("ATENÇÃO : Forncedor Com deposito Judicial !!!")
		cTpCrit  	:= cTpCrit+'12-'
		cDpj 		:= 'Sim'
		/*
		// lancamento automatico dpj
		If lImporta = .T. .and. mv_par07 = 1
			U_cabadpj(tmp->e2_prefixo+ tmp->e2_num+tmp->E2_PARCELA+tmp->e2_tipo+tmp->e2_fornece+tmp->e2_loja)
		endIf   */
	EndIf

	If !Empty(cDpj)
		lRet := .F.
	Endif

	RestArea(aArea)

Return(lRet)

*********************************************************************************

Static Function Grv_Dados(f1_ok , tpcrit)   // Gravar Dados Apos Critica
	local cLibera := iif(f1_ok , 'S', 'N')
	local f_ok := .T.
	//Local ccodrda := ' ' // MMT 
	dbselectarea("SZB")
	dbsetorder(3)
	cCodRda := AllTrim(Posicione('BAU',4,xFilial('BAU') +  substr(adados[11],1,2)+substr(adados[11],4,3)+substr(adados[11],8,3),'BAU_CODIGO'))
	//dbseek(xFilial("SZB")+Substr(tmp->e2_pllote,1,6)+trim(tmp->e2_CodRDA)+nNt)
	if  nLocaliz == 1
		if dbseek(xFilial("SZB")+Substr(tmp->e2_pllote,1,6)+trim(tmp->e2_CodRDA)+nNt)
			If Found()
				If zb_libera == 'S'
					ccritica+=("Nota Fiscal "+nNt+" Já Foi Usada em Outro Titulo.")
					cTpCrit :=cTpCrit+'13'
					f_ok  := .F.
					f1_ok := .F.
				EndIf
				If zb_libera == 'N' .AND. cLibera == 'S'
					f_ok  := .T.
					f1_ok := .T.
					cCodRda := tmp->e2_codrda
				EndiF
				f_ok  := .T.
				f1_ok := .F.
			EndiF
			f_ok  := .T.
			f1_ok := .F.
		EndIf
	ElseIf  nLocaliz== 0
		
		f_ok  := .T.
		f1_ok := .F.
	Endif
	
	If  f_ok .AND.ccodrda != ' '
		
		dbselectarea("SZB")
		
		RecLock("SZB",.T.)
		
		ZB_FILIAL  := xFILIAL("SZB")
		ZB_NOTA    := nNt
		ZB_EMISSAO := ctod(substr(adados[05],01,10))
		
		ZB_VTOTAL  := tmp->vlr_tot
		//   If  f1_ok
		//ZB_OBS     := "Incluido por processo automatico em : " + dtos(DATE()) + " - " + Time()
		//          ZB_OBS     := ccritica1
		//    Else
		ZB_OBS     := ccritica1
		//    EndIf
		ZB_ANOMES  := substr (tmp->e2_pllote ,1,6)
		//  ZB_CODRDA  := tmp->e2_codrda
		ZB_CODRDA  := cCodRda
		ZB_PREFIXO := tmp->e2_prefixo
		ZB_TITULO  := tmp->e2_NUM
		ZB_VINFORM := tmp->vlr_tot
		ZB_VBRUTO  := tmp->vlr_tot
		ZB_TIPO    := tmp->E2_TIPO
		ZB_PARCELA := tmp->E2_PARCELA
		ZB_FORNECE := tmp->E2_FORNECE
		ZB_LOJA    := tmp->E2_LOJA
		ZB_USUAR   := cUsua
		ZB_DTDIGIT := DATE()
		ZB_LIBERA  := cLibera
		Msunlock("SZB")
		
		If  f1_ok
			// Caso as NFs Informadas tenham +60Dias entre data de emissao e data de vencimento do Titulo do PLS nao liberar
			lLibNF := .F.
			
			dbselectarea("SE2")
			
			SE2->(DbSetOrder(1))
			
			dbSeek(xFilial("SE2")+tmp->e2_prefixo+tmp->e2_num+tmp->E2_PARCELA+tmp->e2_tipo+tmp->e2_fornece+tmp->e2_loja)
			
			If Found()


			// TRATAMENTO PARA GRUPO DO INTERIOR -- ALTAMIRO	09/06/21   
			//If _cGruPag $ GETMV("MV_XGRPPLS")  // Grupo do Interior
                If  fTrazGrp(se2->e2_codrda) $ GETMV("MV_XGRPPLS")
					
					If (SZB->ZB_EMISSAO - SE2->E2_VENCREA) > GETMV("MV_DIAPLSI").AND. SE2->E2_PREFIXO != 'COM'
						ccritica+=("Titulo Ficou Pendente de Liberação Manual ! , Diferença Superior a "+Str(GETMV("MV_DIASPLS"))+" Dias - Interior ")
						lLibNF := .T.
						cCritica1:= ' '
						cTpCrit :=cTpCrit+'11'
					Else
						cCritImp := "Titulo Liberarado Para Pagamento!  Entregue dentro do prazo de " + trim(Str(GETMV("MV_DIASPLS")))+" Dias - Interior "
						cCritica1:= 'NF Digitada com sucesso'
					EndIf

				Else

					If (SZB->ZB_EMISSAO - SE2->E2_VENCREA) > GETMV("MV_DIASPLS") .AND. SE2->E2_PREFIXO != 'COM'

						ccritica+=("Titulo Ficou Pendente de Liberação Manual ! , Diferença Superior a "+Str(GETMV("MV_DIASPLS"))+" Dias - Grande Rio ")
						lLibNF := .T.
						cCritica1:= ' '
						cTpCrit :=cTpCrit+'11'
					else
						cCritImp := "Titulo Liberarado Para Pagamento!  Entregue dentro do prazo de " + alltrim(Str(GETMV("MV_DIASPLS")))+" Dias - Grande Rio "
						cCritica1:= 'NF Digitada com sucesso'

					Endif

				EndIf
/*
//				If (dDataBase - stod(TMP->E2_VENCREA)) > GETMV("MV_DIASPLS")
				If (SZB->ZB_EMISSAO - SE2->E2_VENCREA) > GETMV("MV_DIASPLS")

					ccritica+=("Titulo Ficou Pendente de Liberação Manual ! , Diferença Superior a "+Str(GETMV("MV_DIASPLS"))+" Dias")
					lLibNF := .T.
					cCritica1:= ' '
					cTpCrit :=cTpCrit+'11'
				else
					cCritImp := "Titulo Liberarado Para Pagamento!  Entregue dentro do prazo de " + trim(Str(GETMV("MV_DIASPLS")))+" Dias"
					cCritica1:= 'NF Digitada com sucesso'
				EndIf

*/
				RecLock("SE2",.F.)
				SE2->E2_YLIBPLS := IIf(lLibNF,"L","S")
				SE2->E2_YDTDGNF := dDataBase
				SE2->E2_YHRDGNF := Time()
				SE2->E2_FLUXO   := IIf(lLibNF,"N","S")
				Msunlock("SE2")
				
				RecLock("SZB",.F.)
				ZB_USUAR := SubStr(cUSUARIO,7,15)  // Usuario Que Excluiu a NF
				ZB_OBS   := cCritica1
				ZB_LIBERA:= SE2->E2_YLIBPLS
				
				Msunlock("SZB")
				
				VerImpostos("1")
			else
				RecLock("SZB",.F.)
				ZB_USUAR := SubStr(cUSUARIO,7,15)  // Usuario Que Excluiu a NF
				dbdelete()
				Msunlock("SZB")
			Endif
		EndIf
	Endif
	
Return

***************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³VerImpostos ³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verificar se Tem Titulos de Impostos do PLS                ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ VerImpostos(cLibBlq)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static FuncTion VerImpostos(cLibBlq)
	
	LOCAL cPrefixo := tmp->e2_prefixo
	LOCAL cNum	   := tmp->e2_num
	LOCAL cParcPai
	
	DbSelectArea("SE2")
	
	nReg := RECNO()
	
	If SE2->E2_ISS > 0
		nValorPai := SE2->E2_ISS
		cParcPai  := SE2->E2_PARCISS
		cTipoPai  := MVISS
		AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
	Endif
	
	dbgoto(nReg)
	
	If SE2->E2_INSS > 0
		nValorPai := SE2->E2_INSS
		cParcPai  := SE2->E2_PARCINS
		cTipoPai  := MVINSS
		AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
	Endif
	
	dbgoto(nReg)
	
	If SE2->E2_SEST > 0
		nValorPai := SE2->E2_SEST
		cParcPai  := SE2->E2_PARCSES
		cTipoPai  := "SES"
		AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
	Endif
	
	dbgoto(nReg)
	
	If SE2->E2_VRETPIS > 0
		nValorPai := SE2->E2_PIS
		cParcPai  := SE2->E2_PARCPIS
		cTipoPai  := MVTAXA
		AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
	Endif
	
	dbgoto(nReg)
	
	If SE2->E2_VRETCOF > 0
		nValorPai := SE2->E2_COFINS
		cParcPai  := SE2->E2_PARCCOF
		cTipoPai  := MVTAXA
		AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
	Endif
	
	dbgoto(nReg)
	
	If SE2->E2_VRETCSL > 0
		nValorPai := SE2->E2_CSLL
		cParcPai  := SE2->E2_PARCSLL
		cTipoPai  := MVTAXA
		AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
	Endif
	
	dbgoto(nReg)
	
	If SE2->E2_IRRF > 0
		nValorPai := SE2->E2_IRRF
		cParcPai  := SE2->E2_PARCIR
		cTipoPai  := MVTAXA
		AchaImpostos(nValorPai,cParcPai,cTipoPai,cFilial,cPrefixo,cNum,cLibBlq)
	Endif
	
Return

******************************************************************************
/*/

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AchaImpostos³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Achar Titulos de Impostos do PLS                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function trocavenc(xFilial,xPrefixo,cNum,ctipo)
	
	dbSelectArea("SE2")
	
	If dbSeek(xFilial+xPrefixo+cNum)
		
		While !Eof() .and. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) == xFilial+xPrefixo+cNum
			if mv_par10 == 2 .and. mv_par11 == SE2->E2_TIPO
				
				RecLock("SE2",.F.)
				
				se2->e2_vencrea :=se2->e2_vencto:= mv_par12
				
				MSunlock()
				
			EndIf
			SE2->(DbSkip())
		Enddo
		
	EndIf
	
	//dbSelectArea("SE2")
	
	//dbgoto(nReg)
	
Return

*************************************************************************************************************
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AchaImpostos³ Autor ³ Jose Carlos Noronha ³ Data ³ 02/08/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Achar Titulos de Impostos do PLS                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Caberj                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AchaImpostos(nValorPai,cParcPai,cTipoPai,xFilial,xPrefixo,cNum,cLibBlq)
	
	dbSelectArea("SE2")
	
	If dbSeek(xFilial+xPrefixo+cNum)
		While !Eof() .and. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM) == xFilial+xPrefixo+cNum
			If cParcPai == SE2->E2_PARCELA .and. cTipoPai = SE2->E2_TIPO
				If nValorPai != 0
					RecLock("SE2",.F.)
					If cLibBlq = "1"
						SE2->E2_YLIBPLS := IIf(lLibNF,"L","S")
						SE2->E2_FLUXO   := IIf(lLibNF,"N","S")
					Else
						SE2->E2_YLIBPLS := "N"
						SE2->E2_FLUXO   := "N"
					Endif
					// Altera Data de Vencimento (+2 Dias Uteis apos a Data de Liberacao)
					// Retirado a pedido do Antonio
					//	   SE2->E2_VENCTO  := (DDATABASE+2)
					//	   SE2->E2_VENCREA := DataValida(SE2->E2_VENCTO,.T.)
					MSunlock()
					Exit
				EndIf
			EndIf
			DbSkip()
		Enddo
	EndIf
	
	dbSelectArea("SE2")
	
	dbgoto(nReg)
	
Return

*************************************************************************************************************
*************************************************************************************************************
*************************************************************************************************************

Static Function GeraRel1
	
	Local oReport
	Private cPerg		:= "CABR065"
	Private aOrdem 		:= {}//{'RDA','Ano/Mes'}
	
	oReport:= ReportDef()
	oReport:PrintDialog()
	
Return

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportDef()
	
	Local oReport
	Local oDPJ
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ajusta o Grupo de Perguntas                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	AjustaSX1()
	
	Pergunte(cPerg,.F.)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Criacao do componente de impressao                                      ³
	//³                                                                        ³
	//³TReport():New                                                           ³
	//³ExpC1 : Nome do relatorio                                               ³
	//³ExpC2 : Titulo                                                          ³
	//³ExpC3 : Pergunte                                                        ³
	//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
	//³ExpC5 : Descricao                                                       ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	oReport	:= TReport():New("CABR065","Importação e Critica de N. Fiscais Carioca ","CABR065", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de Importação e critica de NF Carioca")
	oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
	oReport:SetTotalText('Total Geral')
	
	*'-----------------------------------------------------------------------------------'*
	*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'*
	*'-----------------------------------------------------------------------------------'*
	
	oReport:SetColSpace(1) //Espacamento entre colunas.
	oReport:SetLandscape() //Impressao em paisagem.
	//oReport:SetPortrait() //Impressao em retrato.
	
	*'-----------------------------------------------------------------------------------'*
	
	oDPJ := TRSection():New(oReport,"Previa comprovante de DPJ",,aOrdem)
	
	TRCell():New(oDPJ ,'NUMNF'		 		,/*TABELA*/	,'N.Nf'					,/*Picture*/ 				,08				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'DATEMIS'			,/*TABELA*/	,'Dt.Emissao'			,/*Picture*/ 				,10				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'CNPJ'				,/*TABELA*/	,'CNPJ'	 				,/*Picture*/   				,55				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'VLRTOT'				,/*TABELA*/	,'Vlr. Tot.' 			,"@E 9,999,999.99"  		,12			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	TRCell():New(oDPJ ,'COFINS'				,/*TABELA*/	,'Vlr Cofins'			,"@E 999,999.99"		    ,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	TRCell():New(oDPJ ,'CSLL'				,/*TABELA*/	,'Vlr Csll'				,"@E 999,999.99"		    ,11				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	TRCell():New(oDPJ ,'INSS'				,/*TABELA*/	,'Vlr Inss'				,"@E 999,999.99"		    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	TRCell():New(oDPJ ,'IRPF'				,/*TABELA*/	,'Vlr Ir'				,"@E 999,999.99"		    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	TRCell():New(oDPJ ,'PIS'				,/*TABELA*/	,'Vlr Pis' 				,"@E 999,999.99"		    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	TRCell():New(oDPJ ,'ISS'				,/*TABELA*/	,'Vlr Iss'				,"@E 999,999.99"		    ,11			 	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT"		)
	TRCell():New(oDPJ ,'ID_TIT_OBS'			,/*TABELA*/	,'Ident.Titulo - Obs'	,/*Picture*/ 				,40			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'ID_CRITICA'			,/*TABELA*/	,'Critica'	            ,/*Picture*/ 				,07			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'ID_DPJ'			    ,/*TABELA*/	,'Dpj'	                ,/*Picture*/ 				,03			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'IMPORTADO'			,/*TABELA*/	,'Imp'	                ,/*Picture*/ 				,03			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	TRCell():New(oDPJ ,'GRPPGTO'			,/*TABELA*/	,'Grp. Pgto'            ,/*Picture*/ 				,03			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
	
	  
	//oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("STATUS"),"Subtotal por STATUS"	,.F.)
	
	//lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
	//lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
	
//	TRFunction():New(oDPJ:Cell("AMB_ODONT_HOSP")  		,NIL,"COUNT"			,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	//TRFunction():New(oDPJ:Cell("ZZP_QTINAM") 	 		,NIL,"SUM"			,oBreak01,,"@E 999,999,999,999"		,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	//TRFunction():New(oDPJ:Cell("ZZP_VLINAM")  			,NIL,"SUM"	   		,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	//TRFunction():New(oDPJ:Cell("ZZP_QTINHO")	  		,NIL,"SUM"	  		,oBreak01,,"@E 999,999,999,999"		,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	//TRFunction():New(oDPJ:Cell("ZZP_VLINHO") 	 		,NIL,"SUM"	 		,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	//TRFunction():New(oDPJ:Cell("ZZP_QTINOD")  			,NIL,"SUM"	 		,oBreak01,,"@E 999,999,999,999"		,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	//TRFunction():New(oDPJ:Cell("ZZP_VLINOD")  			,NIL,"SUM"	 		,oBreak01,,"@E 999,999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	//TRFunction():New(oDPJ:Cell("IMPORTADO")  			,NIL,"COUNT"		,oBreak01,,"@E 999,999,999,999.99"	,{|| IMPORTADO == "NÃO"}/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)
	
Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrint(oReport)
	
	//Local   cImp    :='Não'
	Local  aTotImp  := {0,0,0} // Pos 1 - Importada - Pos 2 - Não importada
	Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Private oDPJ 	:= oReport:Section(1)
	//Private cAliasCart 	:= GetNextAlias()
	//Private cQuery		:= ''
	Private nCont	:= 0
	
	//Executa query que alimenta o alias cAliasCart
	//Processa({||nCont := FilTRep()},AllTrim(SM0->M0_NOMECOM))
	
	nCont := Len(aDados1)
	
	//Se nao tiver esta linha, nao imprime os dados
	oDPJ:init()
	
	oReport:SetMeter(nCont)
	
	cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
	nCont 	:= 0
	
	For i := 1 To Len(aDados1)
		
		oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)
		oReport:IncMeter()
		
		If oReport:Cancel()
			
			oReport:FatLine()
			oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
			
			exit
			
		EndIf
		
		If empty (aDados1[i][4])
			i++
			loop
		EndIf
		
		if mv_par09 == 2
			If alltrim(aDados1[i][21]) == " " .or. alltrim(aDados1[i][21]) $ "9|11|12|16"
				loop
			EndIf
		elseif mv_par09 == 1
			If alltrim(aDados1[i][21]) $ "1|2|3|4|5|6|7|8|10|13"
				loop
			EndIf
		EndIf
		
		oDPJ:Cell('NUMNF' 	   		):SetValue(AllTrim(aDados1[i][1]))
		oDPJ:Cell('DATEMIS' 		):SetValue(AllTrim(aDados1[i][3]))
		oDPJ:Cell('CNPJ'	 		):SetValue(AllTrim(aDados1[i][4])+' - ' +substr(AllTrim(aDados1[i][6]),1,20))
		oDPJ:Cell('VLRTOT'	  		):SetValue(Val(StrTran(StrTran(aDados1[i][8] ,'.',''),',','.')))
		oDPJ:Cell('COFINS'			):SetValue(Val(StrTran(StrTran(aDados1[i][10],'.',''),',','.')))
		oDPJ:Cell('CSLL'  			):SetValue(Val(StrTran(StrTran(aDados1[i][11],'.',''),',','.')))
		oDPJ:Cell('INSS'  			):SetValue(Val(StrTran(StrTran(aDados1[i][12],'.',''),',','.')))
		oDPJ:Cell('IRPF'			):SetValue(Val(StrTran(StrTran(aDados1[i][13],'.',''),',','.')))
		oDPJ:Cell('PIS'				):SetValue(Val(StrTran(StrTran(aDados1[i][14],'.',''),',','.')))
		oDPJ:Cell('ISS'				):SetValue(Val(StrTran(StrTran(aDados1[i][15],'.',''),',','.')))
		oDPJ:Cell('ID_TIT_OBS'		):SetValue(substr(aDados1[i][20],1,30))
		oDPJ:Cell('ID_CRITICA'		):SetValue(AllTrim(aDados1[i][21]))
		oDPJ:Cell('ID_DPJ'		    ):SetValue(AllTrim(aDados1[i][22]))
		oDPJ:Cell('IMPORTADO'		):SetValue(AllTrim(aDados1[i][23]))
		oDPJ:Cell('GRPPGTO'  		):SetValue(AllTrim(aDados1[i][24]))
		// Totalizador de notas importadas - 17/07/2018
		if AllTrim(aDados1[i][23]) == 'Não'
			aTotImp[2] += 1
		else 	
			aTotImp[1] += 1
		endif 
		aTotImp[3] += Val(StrTran(StrTran(aDados1[i][8] ,'.',''),',','.'))
		
		oDPJ:PrintLine()
		
	Next i
	
		
	oReport:FatLine() 
	oReport:PrintText("QUANTIDADE DE NOTAS - "+cValToChar(aTotImp[1]+aTotImp[2])+". Notas Importadas - "+cValToChar(aTotImp[1])+". Notas não importadas - "+cValToChar(aTotImp[2])+"."+" VALOR TOTAL DE NOTAS - "+cValToChar(Transform(aTotImp[3],'@E 999,999,999,999.99'))+".",,,CLR_RED,,,.T.)
			
	oDPJ:Finish()
	
Return

********************************************************************************************************************************
/*
Static Function FilTRep
	
	ProcRegua(0)
	
	For i := 1 to 5
		IncProc('Selecionando registros a serem analisados...')
	Next
	
	cQuery := "SELECT DECODE(ZZP_TIPPRO,'0','Pgto Mensal','1','Recuperação','2','Bloqueio') TIPPRO,ZZP_STATUS,ZZP_DATDIG,ZZP_MESPAG,ZZP_ANOPAG,"	   			+ CRLF
	cQuery += "   ZZP_YLOCAL,ZZP_NUMLOT,ZZP_NUMREM,ZZP_CODRDA,ZZP_NOMRDA,ZZP_QTINAM,ZZP_VLINAM,ZZP_QTINHO,ZZP_VLINHO,ZZP_QTINOD,ZZP_VLINOD,"	   				+ CRLF
	cQuery += "   NVL(CTT_DESC01,'-') CTT_DESC01,(ZZP_VLINAM + ZZP_VLINHO + ZZP_VLINOD) AMB_ODONT_HOSP,"														+ CRLF
	cQuery += "   DECODE(ZZP_STATUS,'CPR','Comp. DPJ','PPR','Previa DPJ','CCA','Comp. Cancelado','PCA','Previa Cancelada','-') STATUS" 					+ CRLF
	cQuery += "FROM " + RetSqlName('ZZP') + " ZZP" 																												+ CRLF
	cQuery += "LEFT JOIN " + RetSqlName('CTT') + " CTT ON CTT.D_E_L_E_T_ = ' ' " 																				+ CRLF
	cQuery += "   AND CTT_FILIAL = '" + xFilial('CTT') + "'" 																									+ CRLF
	cQuery += "   AND CTT_CUSTO = ZZP_YLOCAL" 																													+ CRLF
	cQuery += "WHERE ZZP.D_E_L_E_T_ = ' '" 																														+ CRLF
	cQuery += "   AND ZZP_FILIAL = '" + xFilial('ZZP') + "'" 																									+ CRLF
	
	If !empty(mv_par02)
		cQuery += "   AND ZZP_DATDIG BETWEEN '" + DtoS(mv_par01) + "' AND '" +  DtoS(mv_par02) + "'" 															+ CRLF
	EndIF
	
	If !empty(mv_par05) .and. !empty(mv_par06)
		cQuery += "   AND ZZP_ANOPAG||ZZP_MESPAG BETWEEN '" + PadL(mv_par04,4,'0') + PadL(mv_par03,2,'0') + "' AND '" +  PadL(mv_par06,4,'0') + PadL(mv_par05,2,'0') + "'" + CRLF
	EndIf
	
	Do Case
		
	Case mv_par07 == 1//Pgto Mensal
		cQuery += "   AND ZZP_TIPPRO = '0'" 		+ CRLF
		
	Case mv_par07 == 2//Recuperacao
		cQuery += "   AND ZZP_TIPPRO = '1'" 		+ CRLF
		
	Case mv_par07 == 3//Recuperacao
		cQuery += "   AND ZZP_TIPPRO IN ('0','1')" 	+ CRLF
		
	EndCase
	
	Do Case
		
	Case mv_par08 == 1//Comp/Prev. Rem.
		cQuery += "   AND ZZP_STATUS IN ('CPR','PPR')" 	+ CRLF
		
	Case mv_par08 == 2//Comp/Prev. Canc
		cQuery += "   AND ZZP_STATUS IN ('CCA','PCA')"	+ CRLF
		
	EndCase
	
	cQuery += "ORDER BY DECODE(ZZP_TIPPRO,'0','Pgto Mensal','1','Recuperação','2','Bloqueio'),DECODE(ZZP_STATUS,'CPR','1','PPR','2','CCA','3','PCA','4','5')"
	
	Do Case
		
	Case oDPJ:nOrder == 1
		cQuery += ",ZZP_CODRDA"
		
	Case oDPJ:nOrder == 2
		cQuery += ",ZZP_ANOPAG,ZZP_MESPAG"
		
	EndCase
	
	TcQuery cQuery New Alias cAliasCart
	
	cAliasCart->(DbGoTop())
	
	nCont := 0
	
	COUNT TO nCont
	
	cAliasCart->(DbGoTop())
	
Return nCont
*/
******************************************************************************************

Static Function AjustaSX1(cPerg)
	
	Local aHelpPor := {}
	
	PutSx1(cPerg,"01",OemToAnsi("Arquivo Nf  ")			     	,"","","mv_ch1","C",060,0,0,"G","U_fGetFile('csv     (*.csv)            | *.csv | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"02",OemToAnsi("Data Inicio Emissao Nf ") 		,"","","mv_ch2","D",10,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"03",OemToAnsi("Data Fim Emissao Nf "   ) 		,"","","mv_ch3","D",10,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"04",OemToAnsi("Mes Competencia") 		        ,"","","mv_ch4","C",02,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"05",OemToAnsi("Ano Competencia") 		        ,"","","mv_ch5","C",04,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"06",OemToAnsi("Gerar Excel ") 	         	,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Sim","","","","Não","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"07",OemToAnsi("lançamento Automatico  ")     	,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"08",OemToAnsi("Só titulos Baixados    ")     	,"","","mv_ch8","N",01,0,0,"C","","","","","mv_par08","Sim","","","","Não","","","Ambos","","","","","","","","",{},{},{})
	PutSx1(cPerg,"09",OemToAnsi("Imprimir Nf  ")     	        ,"","","mv_ch9","N",01,0,0,"C","","","","","mv_par09","Importadas","","","","Criticadas","","","Ambos","","","Não Imprime","","","","","",{},{},{})
	PutSx1(cPerg,"10",OemToAnsi("Alterar Data de Vencimento ? "),"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Não","","","","Sim","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"11",OemToAnsi("Tipo a alterar   ? ")          ,"","","mv_ch11","C",03,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"12",OemToAnsi("Alterar Para a Data   ? ")   	,"","","mv_ch12","D",10,0,0,"G","","","","","mv_par012","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	
	
	Pergunte(cPerg,.T.)
	
Return

Static Function fTrazGrp(_cCodRDA)

if !EMPTY(_cCodRDA) 
	// Busca Grupo
	dbselectarea("BAU")
	dbsetorder(1)
	dbseek(xFilial("BAU")+_cCodRDA)
	
	If !Found()  // 31/08/07 - Noronha
	  
	   _cGruPag   := ' '

	Else   
	
	   _cGruPag   := BAU->BAU_GRPPAG
	
	Endif

Else 

  _cGruPag   := ' '

EndIf 
  
Return(_cGruPag)
