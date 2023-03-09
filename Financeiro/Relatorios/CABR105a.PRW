#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*-----------------------------------------------------------------------
| Funcao   | CABR105a | Autor | Otavio Pinto         | Data | 18/03/2013 |
|------------------------------------------------------------------------|
| Descricao| Relatorio de Despessas Medicas - Folha.                     |
|------------------------------------------------------------------------|
| 18/03/13 | OSP |Criada query especifica                                |
|          |     |                                                       |
 -----------------------------------------------------------------------*/
User Function CABR105A

/*-------------------------------------------------------------------------
| Declaracao de Variaveis                                                  |              
 -------------------------------------------------------------------------*/
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de Despesas Medicas dos colaboradores para Ir"
Local cDesc3         := " "
Local cPict          := " "
Local titulo         := "Demonstrativo Despesas Médicas para IR"
Local nLin           := 80 			

Local Cabec1         := "EMPRESA                       MATRIC DEP NOME                                            VALOR"
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//                       CABERJ - 42.182.170/0001-84  036921  01 EARA DE SOUZA LUZ OLIVEIRA                      222.23
Local Cabec2         := " "
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 80
Private tamanho      := "M"
Private nomeprog     := "CABR105a"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR105a"
Private cString      := "BM1"
Private cPerg        := "CABR105A  "  
private nMes         := 0   
private cEmpresa     := SM0->M0_CODIGO

private Vltot        := 0.00  
private VlMtricp     := 0.00
private dData        := Date()
private cmatric      := " "  
private cmatric1     := " "  
private ctipreg      := " "
private cEnter       := CHR(13)+CHR(10)


dbSelectArea("BM1")
dbSetOrder(1)

begin sequence
	ValidPerg(cPerg)
	If Pergunte(cPerg,.T.) = .F. ; break ; Endif

	private cAnoInc  := mv_par01 
	private cAnoFim  := mv_par02

	private cMesInc  := mv_par03 
	private cMesFim  := mv_par04
	private cLNãoSair:= mv_par05
	private cMatric  := mv_par06 
									 
	/*-------------------------------------------------------------------------
	| Monta a interface padrao com o usuario...                                |              
	 -------------------------------------------------------------------------*/
	wnrel := SetPrint(cString,NomeProg,"",@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

	If nLastKey == 27 ; break ; Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27 ; break ; Endif

	nTipo := If(aReturn[4]==1,15,18)

	/*-------------------------------------------------------------------------
	| Processamento. RPTSTATUS monta janela com a regua de processamento.      |              
	 -------------------------------------------------------------------------*/
	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

end sequence	
Return


/*-----------------------------------------------------------------------
| Funcao   | CABR105a | Autor | Otavio Pinto         | Data | 18/03/2013 |
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

/*-------------------------------------------------------------------------
| SETREGUA -> Indica quantos registros serao processados para a regua      |              
 -------------------------------------------------------------------------*/
begin sequence

	SetRegua(RecCount())   
	cQuery :=" SELECT 'INTEGRAL - 07.844.436/0001-06' EMPRESA " + cEnter
	cQuery +="      , BM1_CODEMP " + cEnter
 	cQuery +="      , BM1_MATRIC " + cEnter
	cQuery +="      , BM1_TIPREG " + cEnter
	cQuery +="      , BM1_NOMUSR " + cEnter
	cQuery +="      , Sum ( ( CASE WHEN BM1_CODPLA IN ('0063') AND BM1_CODTIP = '101' THEN " + cEnter
	cQuery +="                                                 NVL( ( BM1_VALOR - (SELECT ( CASE WHEN BM1_ANO||BM1_MES < BTN_ANOMES THEN BTN_VLRANT ELSE BTN_VALFAI END ) " + cEnter
	cQuery +="                                                                     FROM SIGA.BTN020 BTN " + cEnter
	cQuery +="                                                                     WHERE BTN.D_E_L_E_T_ = ' ' " + cEnter
	cQuery +="                                                                       AND BTN_FILIAL = '  ' " + cEnter
	cQuery +="                                                                       AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP " + cEnter
	cQuery +="                                                                       AND BTN_NUMCON = BM1_CONEMP " + cEnter
	cQuery +="                                                                       AND BTN_VERCON = BM1_VERCON " + cEnter
	cQuery +="                                                                       AND BTN_SUBCON = BM1_SUBCON " + cEnter
	cQuery +="                                                                       AND BTN_VERSUB = BM1_VERSUB " + cEnter
	cQuery +="                                                                       AND BTN_CODPRO IN ('0063') " + cEnter
	cQuery +="                                                                       AND BTN_VERPRO = BM1_VERPLA " + cEnter
	cQuery +="                                                                       AND BTN_CODFOR = BM1_CODTIP " + cEnter
	cQuery +="                                                                       AND BTN_CODQTD = '001' " + cEnter
	cQuery +="                                                                       AND BTN_IDAINI = BM1_IDAINI " + cEnter
	cQuery +="                                                                       AND BTN_IDAFIN = BM1_IDAFIN " + cEnter
	cQuery +="                                                                       AND BTN_CODFAI = BM1_CODFAI)) + 1 ,0 ) " + cEnter
	cQuery +="                     WHEN BM1_CODPLA IN ('0065')  AND BM1_CODTIP = '101' THEN " + cEnter
	cQuery +="                                                 NVL( ( BM1_VALOR - (SELECT ( CASE WHEN BM1_ANO||BM1_MES < BTN_ANOMES THEN BTN_VLRANT ELSE BTN_VALFAI END ) " + cEnter
	cQuery +="                                                                     FROM SIGA.BTN020 BTN " + cEnter
	cQuery +="                                                                     WHERE BTN.D_E_L_E_T_ = ' ' " + cEnter
	cQuery +="                                                                       AND BTN_FILIAL = '  ' " + cEnter
	cQuery +="                                                                       AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP " + cEnter
	cQuery +="                                                                       AND BTN_NUMCON = BM1_CONEMP " + cEnter
	cQuery +="                                                                       AND BTN_VERCON = BM1_VERCON " + cEnter
	cQuery +="                                                                       AND BTN_SUBCON = BM1_SUBCON " + cEnter
	cQuery +="                                                                       AND BTN_VERSUB = BM1_VERSUB " + cEnter
	cQuery +="                                                                       AND BTN_CODPRO IN ('0063') " + cEnter
	cQuery +="                                                                       AND BTN_VERPRO = BM1_VERPLA " + cEnter
	cQuery +="                                                                       AND BTN_CODFOR = BM1_CODTIP " + cEnter
	cQuery +="                                                                       AND BTN_CODQTD = '001' " + cEnter
	cQuery +="                                                                       AND BTN_IDAINI = BM1_IDAINI " + cEnter
	cQuery +="                                                                       AND BTN_IDAFIN = BM1_IDAFIN " + cEnter
	cQuery +="                                                                       AND BTN_CODFAI = BM1_CODFAI)) + 1 ,0 ) " + cEnter
	cQuery +="                     WHEN BM1_CODPLA = '0037' AND  BM1_TIPREG <> '00' THEN NVL ( BM1_VALOR, 0 ) " + cEnter
	cQuery +="                     WHEN BM1_CODTIP <> '101' THEN NVL ( BM1_VALOR, 0 ) " + cEnter
	cQuery +="                     END    )   ) VALOR " + cEnter
	cQuery +=" FROM  BM1020 BM1 " + cEnter
	cQuery +="    ,  BFQ020 BFQ " + cEnter
	cQuery +=" WHERE BM1_FILIAL = '  ' " + cEnter
	cQuery +="   AND BFQ_FILIAL = '  ' " + cEnter
	cQuery +="   AND BM1.d_E_L_E_T_ = ' ' " + cEnter
	cQuery +="   AND BFQ.d_E_L_E_T_ = ' ' " + cEnter
	cQuery +="   AND BM1_CODEMP     = '0109' " + cEnter
	cQuery +="   AND BM1_ANO||BM1_MES >= '"+cAnoInc+cMesInc+"' AND BM1_ANO||BM1_MES <= '"+cAnoFim+cMesFim+"'" + cEnter

	if !empty (cLNãoSair)
		cQuery +="   AND  BM1_CODTIP NOT IN ("+cLNãoSair+") " + cEnter
	EndIf

	cQuery +="   AND SubStr(BM1_CODTIP,1,1) = BFQ_PROPRI " + cEnter
	cQuery +="   AND SubStr(BM1_CODTIP,2,2) = BFQ_CODLAN " + cEnter

	if !empty (cMatric)
	   cQuery +="   AND BM1_MATRIC = '"+cMatric+"' "    + cEnter
	endif

	cQuery +=" GROUP BY BM1_CODEMP, BM1_MATRIC,BM1_TIPREG,BM1_NOMUSR " + cEnter

	cQuery +=" UNION ALL " + cEnter

	cQuery +=" SELECT 'CABERJ - 42.182.170/0001-84' EMPRESA ,BM1_CODEMP,  BM1_MATRIC, BM1_TIPREG, BM1_NOMUSR, sum (Decode (BFQ_DEBCRE , 1 ,BM1_VALOR,BM1_VALOR*-1)) VALOR " + cEnter
    cQuery +=" FROM   BM1010 BM1 ,  BFQ010 BFQ " + cEnter
	cQuery +=" WHERE BM1_FILIAL = '  ' AND BFQ_FILIAL = '  ' " + cEnter
	cQuery +="   AND bm1.d_E_L_E_T_ = ' ' AND bfq.d_E_L_E_T_ = ' ' AND BM1_CODEMP = '0003' " + cEnter
	cQuery +="   AND BM1_ANO||BM1_MES >= '"+cAnoInc+cMesInc+"' AND BM1_ANO||BM1_MES <= '"+cAnoFim+cMesFim+"'" + cEnter

	if !empty (cLNãoSair)
		cQuery +="   AND  BM1_CODTIP NOT IN ("+cLNãoSair+") " + cEnter
	EndIf

	cQuery +="   AND SubStr(BM1_CODTIP,1,1) = BFQ_PROPRI AND SubStr(BM1_CODTIP,2,2) = BFQ_CODLAN " + cEnter

	if !empty (cMatric)
	   cQuery +="   AND BM1_MATRIC = '"+cMatric+"' "    + cEnter
	endif

	cQuery +=" GROUP BY BM1_CODEMP, BM1_MATRIC,BM1_TIPREG,BM1_NOMUSR " + cEnter

	cQuery +=" UNION ALL " + cEnter

	cQuery +=" SELECT 'CABERJ - 42.182.170/0001-84' EMPRESA " + cEnter
	cQuery +="      , BA1_CODEMP " + cEnter
	cQuery +="      , BA1_MATRIC " + cEnter
	cQuery +="      , BA1_TIPREG " + cEnter
	cQuery +="      , BA1_NOMUSR " + cEnter
	cQuery +="      , 0.00 VALOR " + cEnter
	cQuery +=" FROM  BA1010 BA1 " + cEnter
	cQuery +=" WHERE BA1_FILIAL     = '  ' " + cEnter
	cQuery +="   AND BA1.d_E_L_E_T_ = ' ' " + cEnter

	cQuery +="   AND BA1_CODINT     = '0001' " + cEnter
	cQuery +="   AND BA1_CODEMP     = '0003' " + cEnter
	if !empty (cMatric)
	   cQuery +="   AND BA1_MATRIC = '"+cMatric+"' "    + cEnter
	endif
	cQuery +="   AND BA1_TIPREG     = '00' " + cEnter

	cQuery +=" GROUP BY BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_NOMUSR " + cEnter
	cQuery +=" ORDER BY BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, EMPRESA " + cEnter


	If Select("TMP") > 0 ; 	dbSelectArea("TMP") ; dbclosearea() ; Endif

	TCQuery cQuery Alias "TMP" New
	dbSelectArea("TMP")
	tmp->(dbGoTop())

	While tmp->(!EOF()) 
		If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
		   nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) 
		   cMatric := TMP->BM1_MATRIC                    
		   //ctipreg := tmp->BM1_TIPREG                     
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
		If tmp->BM1_MATRIC != cmatric       
			 nLin := nLin + 1  
		   @ nLin,001 PSAY "Total Do Demonstrativo ---> "  
		   @ nLin,081 PSAY Vltot     Picture "@E 99,999,999.99"   
		   @ nLin,000 PSay replicate("_",132)              
			 nLin  := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo) 
			 cMatric := TMP->BM1_MATRIC                    
			 Vltot :=0.00                   
		Endif  
	   
		*If tmp->(BM1_MATRIC+BM1_TIPREG) != cmatric1
        if  TMP->VALOR > 0
		   nLin++                                     
  		   @ nLin,000 PSAY  TMP->EMPRESA
		   @ nLin,030 PSAY  TMP->BM1_MATRIC           
		   @ nLin,038 PSAY  TMP->BM1_TIPREG                 
		   @ nLin,041 PSAY  TMP->BM1_NOMUSR       
		   @ nLin,081 PSAY  TMP->VALOR  Picture "@E 99,999,999.99" 		         
           nLin++
		   cmatric1 := tmp->(BM1_MATRIC+BM1_TIPREG) 		
		EndIf       
		Vltot     +=TMP->valor   
		VlMtricp  +=TMP->valor  
		
		tmp->(dbSkip())
	EndDo           
                        
    nLin := nLin + 1	
    @ nLin,001 PSAY "Total Do Demonstrativo ---> "  
    @ nLin,081 PSAY Vltot     Picture "@E 99,999,999.99"   
    nLin := nLin + 1 	 
    @ nLin,000 PSay replicate("_",132)              
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
aAdd(aRegs,{cPerg,"06","Matricula            ","","","mv_ch06","C",06,0,0,"G","","mv_par06",""        ,"","","","",""         ,"","","","","","","","","","","","","","","","","","","",""}) 
                
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

// Fim da rotina CABR105A.PRW