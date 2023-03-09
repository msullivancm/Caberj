#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*-----------------------------------------------------------------------
| Funcao   | CABR105  | Autor | Altamiro Affonso     | Data | 05/10/2010 |
|------------------------------------------------------------------------|
| Descricao| Relatorio De despessas medicas Colaborado - customizado.    |
|------------------------------------------------------------------------|
| 15/03/13 | OSP |Criada query especifica para Integral - Empresa 02     |
|          |     |                                                       |
 -----------------------------------------------------------------------*/
User Function CABR105

/*-------------------------------------------------------------------------
| Declaracao de Variaveis                                                  |              
 -------------------------------------------------------------------------*/
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de despesas medicas dos colaboradores para Ir"
Local cDesc3         := " "
Local cPict          := " "
Local titulo         := "Despesas Médicas dos Colaboradores e seus Dependentes"
Local nLin           := 80 			

Local Cabec1         := "Matric.  Dep  Nome                                   "
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
                      
Local Cabec2         := " Mes/ano         Valor                                       "
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 80
Private tamanho      := "P"
Private nomeprog     := "CABR105"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR105"
Private cString      := "BM1"
Private cPerg        := "CABR105   "  
private nMes         := 0   
private cCNPJ        := ""   
private cEmpresa     := SM0->M0_CODIGO

private Vltot        := 0.00  
private VlMtricp     := 0.00
private dData        := Date()
private cmatric      := " "  
private cmatric1     := " "  
private ctipreg      := " "

dbSelectArea("BM1")
dbSetOrder(1)

begin sequence
	ValidPerg(cPerg)
	If Pergunte(cPerg,.T.) = .F.
		break
	Endif

	private cAnoInc  := mv_par01 
	private cAnoFim  := mv_par02

	private cMesInc  := mv_par03 
	private cMesFim  := mv_par04
	private cLNãoSair:= mv_par05
	private cTipoList:= mv_par06
	private cMatric  := mv_par07 
									 
	/*
	  '42.182.170/0001-84' - CAIXA DE ASSISTENCIA A SAUDE - CABERJ - 0003 - EMPRESA = '01'                     
	  '07.844.436/0001-06' - CABERJ INTEGRAL SAUDE S.A.            - 0109 - EMPRESA = '02'                     
	*/
											
	cCNPJ := if ( cEmpresa == '02','07.844.436/0001-06','42.182.170/0001-84')

	/*-------------------------------------------------------------------------
	| Monta a interface padrao com o usuario...                                |              
	 -------------------------------------------------------------------------*/
	Cabec2 += cCNPJ

	wnrel := SetPrint(cString,NomeProg,"",@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

	If nLastKey == 27
		break
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		break
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	/*-------------------------------------------------------------------------
	| Processamento. RPTSTATUS monta janela com a regua de processamento.      |              
	 -------------------------------------------------------------------------*/
	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

end sequence	
Return


/*-----------------------------------------------------------------------
| Funcao   |RUNREPORT | Autor | AP6 IDE              | Data | 31/08/2007 |
|------------------------------------------------------------------------|
| Descricao| Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS  |
|          | monta a janela com a regua de processamento.                |
|------------------------------------------------------------------------|
|   /  /   |     | Programa principal                                    |
|          |     |                                                       |
 -----------------------------------------------------------------------*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cQuery := ' '
dbSelectArea(cString)
dbSetOrder(1)

lModelo := .F.

/*-------------------------------------------------------------------------
| SETREGUA -> Indica quantos registros serao processados para a regua      |              
 -------------------------------------------------------------------------*/
begin sequence

	SetRegua(RecCount())   
	do case
	// Nova query implementada em 01.03.2013 por Otavio Salvador
	case cEmpresa == '02'
		cQuery :=" SELECT BM1_CODEMP "
		cQuery +="      , BM1_MATRIC "
		cQuery +="      , BM1_TIPREG "
		cQuery +="      , BM1_NOMUSR "
		cQuery +="      , BM1_MES "
		cQuery +="      , BM1_ANO "
		cQuery +="      , Sum ( ( CASE WHEN BM1_CODPLA IN ('0063') AND BM1_CODTIP = '101' THEN "
		cQuery +="                                                 NVL( ( BM1_VALOR - (SELECT ( CASE WHEN BM1_ANO||BM1_MES < BTN_ANOMES THEN BTN_VLRANT ELSE BTN_VALFAI END ) "
		cQuery +="                                                                     FROM SIGA.BTN020 BTN "
		cQuery +="                                                                     WHERE BTN.D_E_L_E_T_ = ' ' "
		cQuery +="                                                                       AND BTN_FILIAL = '  ' "
		cQuery +="                                                                       AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP "
		cQuery +="                                                                       AND BTN_NUMCON = BM1_CONEMP "
		cQuery +="                                                                       AND BTN_VERCON = BM1_VERCON "
		cQuery +="                                                                       AND BTN_SUBCON = BM1_SUBCON "
		cQuery +="                                                                       AND BTN_VERSUB = BM1_VERSUB "
		cQuery +="                                                                       AND BTN_CODPRO IN ('0063') "
		cQuery +="                                                                       AND BTN_VERPRO = BM1_VERPLA "
		cQuery +="                                                                       AND BTN_CODFOR = BM1_CODTIP "
		cQuery +="                                                                       AND BTN_CODQTD = '001' "
		cQuery +="                                                                       AND BTN_IDAINI = BM1_IDAINI "
		cQuery +="                                                                       AND BTN_IDAFIN = BM1_IDAFIN "
		cQuery +="                                                                       AND BTN_CODFAI = BM1_CODFAI)) + 1 ,0 ) "
		cQuery +="                     WHEN BM1_CODPLA IN ('0065')  AND BM1_CODTIP = '101' THEN  "
		cQuery +="                                                 NVL( ( BM1_VALOR - (SELECT ( CASE WHEN BM1_ANO||BM1_MES < BTN_ANOMES THEN BTN_VLRANT ELSE BTN_VALFAI END ) "
		cQuery +="                                                                     FROM SIGA.BTN020 BTN "
		cQuery +="                                                                     WHERE BTN.D_E_L_E_T_ = ' ' "
		cQuery +="                                                                       AND BTN_FILIAL = '  ' "
		cQuery +="                                                                       AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP "
		cQuery +="                                                                       AND BTN_NUMCON = BM1_CONEMP "
		cQuery +="                                                                       AND BTN_VERCON = BM1_VERCON "
		cQuery +="                                                                       AND BTN_SUBCON = BM1_SUBCON "
		cQuery +="                                                                       AND BTN_VERSUB = BM1_VERSUB "
		cQuery +="                                                                       AND BTN_CODPRO IN ('0063') "
		cQuery +="                                                                       AND BTN_VERPRO = BM1_VERPLA "
		cQuery +="                                                                       AND BTN_CODFOR = BM1_CODTIP "
		cQuery +="                                                                       AND BTN_CODQTD = '001' "
		cQuery +="                                                                       AND BTN_IDAINI = BM1_IDAINI "
		cQuery +="                                                                       AND BTN_IDAFIN = BM1_IDAFIN "
		cQuery +="                                                                       AND BTN_CODFAI = BM1_CODFAI)) + 1 ,0 ) "
		cQuery +="                     WHEN BM1_CODPLA = '0037' AND  BM1_TIPREG <> '00' THEN NVL ( BM1_VALOR, 0 ) "
		cQuery +="                     WHEN BM1_CODTIP <> '101' THEN NVL ( BM1_VALOR, 0 ) "
		cQuery +="                     END    )   ) VALOR "
		cQuery +=" FROM  BM1020 BM1 "
		cQuery +="    ,  BFQ020 BFQ "
		cQuery +=" WHERE BM1_FILIAL = '  ' "
		cQuery +="   AND BFQ_FILIAL = '  ' "
		cQuery +="   AND BM1.d_E_L_E_T_ = ' ' "
		cQuery +="   AND BFQ.d_E_L_E_T_ = ' ' "
		cQuery +="   AND BM1_CODEMP     = '0109' "
		cQuery +="   AND BM1_ANO||BM1_MES >= '"+cAnoInc+cMesInc+"' AND BM1_ANO||BM1_MES <= '"+cAnoFim+cMesFim+"' "
		if !empty (cLNãoSair)
			cQuery +="   AND  BM1_CODTIP NOT IN ("+cLNãoSair+") "
		EndIf
		cQuery +="   AND SubStr(BM1_CODTIP,1,1) = BFQ_PROPRI "
		cQuery +="   AND SubStr(BM1_CODTIP,2,2) = BFQ_CODLAN "
		if !empty (cMatric)
		   cQuery +="   AND BM1_MATRIC = '"+cMatric+"' "   
		endif
		cQuery +=" GROUP BY  BM1_CODEMP, BM1_MATRIC,BM1_TIPREG,BM1_NOMUSR,BM1_MES,BM1_ANO, BM1_CODTIP, BM1_CODPLA "
		cQuery +=" ORDER BY BM1_MATRIC , BM1_TIPREG, BM1_ANO, BM1_MES "


	case cEmpresa == '01'

		/* Rotina original, substituida pela query acima: em 01.03.2013 - OSP */

		cQuery :=" SELECT BM1_CODEMP,  BM1_MATRIC, BM1_TIPREG, BM1_NOMUSR, BM1_MES, BM1_ANO, sum (Decode (BFQ_DEBCRE , 1 ,BM1_VALOR,BM1_VALOR*-1)) VALOR"
		cQuery +=" FROM   "+RetSqlName("BM1")+" BM1 ,  "+RetSqlName("BFQ")+" BFQ"
		cQuery +=" WHERE BM1_FILIAL = '"+xFilial("BM1")+"'AND BFQ_FILIAL = '"+xFilial("BFQ")+"'"
		cQuery +=" AND bm1.d_E_L_E_T_ = ' ' AND bfq.d_E_L_E_T_ = ' ' AND BM1_CODEMP = '0003' "
		cQuery +=" AND BM1_ANO||BM1_MES >= '"+cAnoInc+cMesInc+"' AND BM1_ANO||BM1_MES <= '"+cAnoFim+cMesFim+"'"
		if !empty (cLNãoSair)
			cQuery +=" AND  BM1_CODTIP NOT IN ("+cLNãoSair+")"
		EndIf
		cQuery +=" AND SubStr(BM1_CODTIP,1,1) = BFQ_PROPRI AND SubStr(BM1_CODTIP,2,2) = BFQ_CODLAN "   
		if !empty (cMatric)
		   cQuery +=" AND BM1_MATRIC = '"+cMatric+"'"   
		EndIf
		cQuery +=" GROUP BY  BM1_CODEMP, BM1_MATRIC,BM1_TIPREG,BM1_NOMUSR,BM1_MES,BM1_ANO"
		cQuery +=" ORDER BY BM1_MATRIC , BM1_TIPREG, BM1_ANO, BM1_MES"

	endcase

	If Select("TMP") > 0
		dbSelectArea("TMP")
		dbclosearea()
	Endif

	TCQuery cQuery Alias "TMP" New
	dbSelectArea("TMP")
	tmp->(dbGoTop())

	While tmp->(!EOF()) 
		If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
		   nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) 
		   cMatric := TMP->BM1_MATRIC                    
		   ctipreg := tmp->BM1_TIPREG                     
		Endif                                           
		
		/*-------------------------------------------------------------------------
		| Verifica o cancelamento pelo usuario...                                  |              
		 -------------------------------------------------------------------------*/
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		/*-------------------------------------------------------------------------
		| Impressao do cabecalho do relatorio. . .                                 |              
		 -------------------------------------------------------------------------*/
		If tmp->BM1_MATRIC != cmatric .or. ctipreg != tmp->BM1_TIPREG 
				nLin = nLin + 1 	      
			  @ nLin,000 PSay replicate("_",080)
				nLin = nLin + 1 	      
			  if ctipreg != '00'                     
				 @ nLin,001 PSAY "Sub-Total Dependente ---> "  
			  Else                        
				 @ nLin,001 PSAY "Sub-Total Titular ----> " 
			  EndIf   
			  @ nLin,030 PSAY VlMtricp     Picture "@E 99,999,999.99"   
				nLin = nLin + 1 	                             
			  @ nLin,000 PSay replicate("_",080)              
				nLin := nLin + 1  
				ctipreg := tmp->BM1_TIPREG 
				VlMtricp :=0.00   
		Endif  
													 
		If tmp->BM1_MATRIC != cmatric       
			 nLin := nLin + 1  
		   @ nLin,001 PSAY "Total Do Demonstrativo ---> "  
		   @ nLin,030 PSAY Vltot     Picture "@E 99,999,999.99"   
		   @ nLin,000 PSay replicate("_",080)              
			 nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) 
			 cMatric := TMP->BM1_MATRIC                    
			 ctipreg := tmp->BM1_TIPREG  
			 Vltot :=0.00                   
		Endif  
																	  
	   
		If tmp->(BM1_MATRIC+tmp->BM1_TIPREG) != cmatric1
		   nLin++
		   @ nLin,000 PSAY  TMP->BM1_MATRIC           
		   @ nLin,010 PSAY  TMP->BM1_TIPREG                 
		   @ nLin,015 PSAY  TMP->BM1_NOMUSR             
			 nLin++
			 cmatric1 := tmp->(BM1_MATRIC+tmp->BM1_TIPREG) 
			
		EndIf       
		if cTipoList = 2
			 nLin++       
			 nMes := VAL(TMP->BM1_MES)   
		   If TMP->BM1_MES = '02'             
			  @ nLin,001 PSAY  '01'+'/' + TMP->BM1_ANO
		   ElseIf TMP->BM1_MES = '03'             
			  @ nLin,001 PSAY  '02'+'/' + TMP->BM1_ANO
		   ElseIf TMP->BM1_MES = '04'             
			  @ nLin,001 PSAY  '03'+'/' + TMP->BM1_ANO   
		   ElseIf TMP->BM1_MES = '05'             
			  @ nLin,001 PSAY  '04'+'/' + TMP->BM1_ANO
		   ElseIf TMP->BM1_MES = '06'             
			  @ nLin,001 PSAY  '05'+'/' + TMP->BM1_ANO   
		   ElseIf TMP->BM1_MES = '07'             
			  @ nLin,001 PSAY  '06'+'/' + TMP->BM1_ANO
		   ElseIf TMP->BM1_MES = '08'             
			  @ nLin,001 PSAY  '07'+'/' + TMP->BM1_ANO   
		   ElseIf TMP->BM1_MES = '09'             
			  @ nLin,001 PSAY  '08'+'/' + TMP->BM1_ANO
		   ElseIf TMP->BM1_MES = '10'             
			  @ nLin,001 PSAY  '09'+'/' + TMP->BM1_ANO
		   ElseIf TMP->BM1_MES = '11'             
			  @ nLin,001 PSAY  '10'+'/' + TMP->BM1_ANO   
		   ElseIf TMP->BM1_MES = '12'             
			  @ nLin,001 PSAY  '11'+'/' + TMP->BM1_ANO
		   ElseIf TMP->BM1_MES = '01'       
			  @ nLin,001 PSAY  '12'+'/' +if (TMP->BM1_ANO > mv_par01, mv_par01,TMP->BM1_ANO )    //-- ALLTRIM(STR(VAL(TMP->BM1_ANO)-1,0))
		   EndIf   
		   @ nLin,020 PSAY  TMP->VALOR  Picture "@E 9,999,999.99" 
		EndIf                  
		Vltot     +=TMP->valor   
		VlMtricp  +=TMP->valor  
		
		tmp->(dbSkip())
	EndDo           
                        
    nLin := nLin + 1	
    @ nLin,000 PSay replicate("_",080)              
    nLin := nLin + 1        
    if ctipreg != '00' 
       @ nLin,001 PSAY "Sub-Total Dependente  ---> "  
    Else                                               
       @ nLin,001 PSAY "Sub-Total Titular    ----> "  
    EndIf   
    @ nLin,030 PSAY VlMtricp     Picture "@E 99,999,999.99"       
     nLin := nLin + 1 
    @ nLin,000 PSay replicate("_",080)              
     nLin := nLin + 1  
      
    @ nLin,001 PSAY "Total Do Demonstrativo ---> "  
    @ nLin,030 PSAY Vltot     Picture "@E 99,999,999.99"   
     nLin := nLin + 1 	 
    @ nLin,000 PSay replicate("_",080)              
      nLin := nLin + 1        

/*-------------------------------------------------------------------------
| Finaliza a execucao do relatorio...                                      |              
 -------------------------------------------------------------------------*/
end sequence

SET DEVICE TO SCREEN

/*-------------------------------------------------------------------------
| Se impressao em disco, chama o gerenciador de impressao...               |              
 -------------------------------------------------------------------------*/
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()


Return

/*-----------------------------------------------------------------------
| Funcao   |ValidPerg | Autor | Jose Carlos Noronha  | Data | 01/08/2007 |
|------------------------------------------------------------------------|
| Descricao| Parametros para selecao dos titulos do PLS                  |
|          |                                                             |
|------------------------------------------------------------------------|
|   /  /   |     |                                                       |
|          |     |                                                       |
 -----------------------------------------------------------------------*/
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
           
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Ano Inc Demonst.     ","","","mv_ch01","C",04,0,0,"G","","mv_par01",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","","" }) 
aAdd(aRegs,{cPerg,"02","Ano Fim Demonst.     ","","","mv_ch02","C",04,0,0,"G","","mv_par02",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","","" })
aAdd(aRegs,{cPerg,"03","Mes Inicial          ","","","mv_ch03","C",02,0,0,"G","","mv_par03",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","","" })
aAdd(aRegs,{cPerg,"04","Mes Final            ","","","mv_ch04","c",02,0,0,"G","","mv_par04",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Lanc. há  Não Sair   ","","","mv_ch05","C",20,0,0,"G","","mv_par05",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Listar               ","","","mv_ch06","N",01,0,0,"c","","mv_par06","Sintetico","","","","","Analitico","","","","","Decomposto","","","","","","","","","","","","","","",""})  
aAdd(aRegs,{cPerg,"07","Matricula            ","","","mv_ch07","C",06,0,0,"G","","mv_par07",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""}) 
                
For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

RestArea( aAreaAtu )
  
Return(.T.)

// Fim da rotina CABR105.PRW