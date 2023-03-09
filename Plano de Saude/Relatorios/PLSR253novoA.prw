#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSR253   º Autor ³ Jean Schulz        º Data ³  14/01/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Imprime declaracao de Imposto de Renda para Usuario Caberj.º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function UPLR253A()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local aOrd 			:= {}
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := ""
	Local cPict          := ""
	Local titulo       	 := "Declaracao de Imposto de Renda para Usuario"
	Local nLin         	 := 80
	Local Cabec1       	 := ""
	Local Cabec2       	 := ""
	
	Private cString  	 := "SE1"
	Private CbTxt        := ""
	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private limite       := 80
	Private tamanho      := "P"
	Private nomeprog     := "UPLR253A"
	Private nTipo        := 18
	Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
	Private nLastKey     := 0
	//Private cbtxt 			:= Space(10)
	Private cbcont     	 := 00
	Private CONTFL     	 := 01
	Private m_pag      	 := 01
	
	Private wnrel      	 := "UPLR253A"
	Private cPerg      	 := "UPLR253"
	private dNasc        := "  /  /   "
	Private cCodInt		 := ""
	Private cEmpIni		 := ""
	Private cEmpFin		 := ""
	Private cMatIni		 := ""
	Private cMatFin		 := ""
	Private cAberto      := ""
	Private lSoBlq       := .F. 
	private cCpf         := ' ' 
	
	dbSelectArea("SE1")
	dbSetOrder(1)
	
	CriaSX1(cPerg)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta a interface padrao com o usuario...                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)
	
	If nLastKey == 27
		Return
	Endif
	
	If Pergunte(cPerg,.F.)
		Return
	Endif
	
	
	cAno	:= mv_par01
	nQtd	:= mv_par02
	cEmp	:= Alltrim(mv_par03)
	cLoc	:= Alltrim(mv_par04)
	cCodInt	:= mv_par05
	cEmpIni	:= mv_par06
	cEmpFin	:= mv_par07
	cMatIni	:= mv_par08
	cMatFin	:= mv_par09
	cAberto := mv_par10
	lSoBlq  := Iif(mv_par11 == "S",.T.,.F.)
	lsofat  := Iif(mv_par12 == "S",.T.,.F.)         
	cCpf    := mv_par13
	
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
		Return
	Endif
	
	nTipo := IIf(aReturn[4]==1,15,18)
	
	Processa({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP5 IDE            º Data ³  21/03/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA. A funcao PROCESSA   º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	
	Local nCont := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	//Local nOrdem
	Local nValor := 0
	Local aValCob
	Local cMesIni
	Local cMesFim
	Local nSE1REC
	Local nSE1ORD
	Local J := 0
	Local cSQL := ""
	Local cSQL2 := ""
	Local cSQLUsr := ""
	
	Private cMask102	:= "@E 999,999.99"
	Private _nLinGr		:= 0
	Private cPath		:= GetSrvProfString("Startpath","")
	Private cLogoCli	:= ""
	Private cLogoANS	:= ""
	Private nCont		:= 0
	Private bLin		:= { | nLinha,nMult | nLinha+=((12*25/9)*nMult),_nLinGr := nLinha }
	Private nPasso		:= 130
	private cfamilia    := " "
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria objeto de impressao grafica...                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oPrn 	:= tAvPrinter():New( "Protheus" )
	oPrn	:Setup()
	oPrn	:StartPage()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define ljogos a serem utilizadas...                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cPath := AjuBarPath(cPath)
	If (SubStr(cNumEmp,1,2) == "01")
		cLogoCli := cPath+"lgrl01.bmp"
	Else
		cLogoCli := cPath+"lgrl02.bmp"
	EndIf
	cLogoANS := cPath+"LogoANS.bmp"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define fontes a serem utilizadas...                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oFont1:= TFont():New( "Times New Roman"	,,12,,.t.,,,,,.f. )
	oFont2:= TFont():New( "Courier New"		,,11,,.t.,,,,,.f. )
	oFont3:= TFont():New( "Courier New"		,,07,,.t.,,,,,.f. )
	oFont4:= TFont():New( "Courier New"		,,09,,.t.,,,,,.f. )
	oFont5:= TFont():New( "Courier New"		,,12,,.t.,,,,,.f. )
	
	For nCont := 1 to 2
		If nCont == 1
			cSQL := " SELECT COUNT(*) AS TOTREG "
		Else
			cSQL := " SELECT CODINT, CODEMP, MATRIC, SUM(VALOR) TOTFAM "
		Endif
		If (SubStr(cNumEmp,1,2) == "01")
			if lsofat
				cSQL += " FROM IR_BENEF_SEPAR_fat "
			else
				if cAno >= '2008'
					cSQL += " FROM IR_BENEF_SEPAR_fat "
				else
					cSQL += " FROM IR_BENEF "
				EndIf
			EndIf
		Else
			cSQL += " FROM IR_BENEF_SEPAR_INT "
		EndIf
		If !empty(cCpf)
           cSQL += " WHERE Cpf = '"+cCpf+"' "		
		Else
   		   cSQL += " WHERE CODINT = '"+cCodInt+"' "
		   cSQL += " AND CODEMP >= '"+cEmpIni+"' "
		   cSQL += " AND CODEMP <= '"+cEmpFin+"' "
		   cSQL += " AND MATRIC >= '"+cMatIni+"' "
	       cSQL += " AND MATRIC <= '"+cMatFin+"' "
	    EndIf    
		cSQL += " AND ANOBASEIR = "+cAno+" "
		cSQL += " GROUP BY CODINT, CODEMP, MATRIC "
		
		If nCont == 1
			PlsQuery(cSQL,"TRBUSR")
			nTotReg := TRBUSR->TOTREG
			TRBUSR->(DbCloseArea())
		Else
			PlsQuery(cSQL,"TRBUSR")
		Endif
	Next
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca da tabela temporaria os valores por usuario.						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While !TRBUSR->(Eof())
		Imprime_Carta(TRBUSR->CODINT,TRBUSR->CODEMP,TRBUSR->MATRIC,TRBUSR->TOTFAM)
		TRBUSR->(DbSkip())
	Enddo
	
	If Select("TRBUSR") > 0
		dbSelectArea("TRBUSR")
		dbCloseArea()
		//TRBUSR->(DbCloseArea())
	EndIf
	
	oPrn:Preview()
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSR253NOVOºAutor ³Microsiga           º Data ³  11/01/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Imprime_Carta(cCodInt,cCodEmp,cMatric,nVlrFam)
	
	Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	
	Local cSQL := ""
	
	cSQL := " SELECT * "
	
    	If (SubStr(cNumEmp,1,2) == "01")
	        
	        if cAno >= '2008'
			   cSQL += " FROM IR_BENEF_SEPAR_fat "
			else
			   cSQL += " FROM IR_BENEF "
			EndIf
			
		Else
			cSQL += " FROM IR_BENEF_SEPAR_INT "
		EndIf
	
	
	If !empty(cCpf)
        cSQL += " WHERE Cpf = '"+cCpf+"' "		
	Else
  	    cSQL += " WHERE CODINT = '"+cCodInt+"' "
	    cSQL += " AND CODEMP = '"+cCodEmp+"' "
    	cSQL += " AND MATRIC = '"+cMatric+"'
    EndIf 	
	cSQL += " AND ANOBASEIR = "+cAno+" "
	
	PlsQuery(cSQL,"TRB")
	
	//Busca primeiro e ultimo mes, para imprimir o cabecalho...
	TRB->(DbGoBottom())
	cMesFim := TRB->MESBASE
	
	TRB->(DbGoTop())
	cMesIni := TRB->MESBASE
	
	BA3->(DbSetOrder(1))
	BA1->(DbSetOrder(2))
	SA1->(DbSetOrder(1))
	BA0->(DbSetOrder(1))
	
	BA0->(MsSeek(xFilial("BA0")+PLSINTPAD()))
	
	For j := 1 to nQtd
		
		oPrn:StartPage()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Logo da operadora...                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		_nLinGr := 48
		oPrn:SayBitmap( 048, nPasso,cLogoCli,275,208 )
		
		oPrn:Say (Eval(bLin,_nLinGr,2), nPasso+300, BA0->BA0_NOMINT,oFont4,100)
		oPrn:Say (Eval(bLin,_nLinGr,1), nPasso+300, "CNPJ: "+BA0->BA0_CGC,oFont4,100)
		oPrn:Say (Eval(bLin,_nLinGr,1), nPasso+300, "Registro ANS: "+BA0->BA0_SUSEP,oFont4,100)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Dados do cliente...                                                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If BA3->(MsSeek(xFilial("BA3")+cCodInt+cCodEmp+cMatric))
			cCodCli := BA3->BA3_CODCLI
			cLojCli	:= BA3->BA3_LOJA
		Else
			cCodCli := " "
			cLojCli := " "
		Endif
		If ( (!Empty(cCodCli)) .AND. ((!lSoBlq) .OR. (lSoBlq .AND. !Empty(BA3->BA3_DATBLO)))) // 09/03/09
			
			SA1->(MsSeek(xFilial("SA1")+cCodCli+cLojCli))
			BA1->(MsSeek(xFilial("BA1")+cCodInt+cCodEmp+cMatric+"00"))
			
			_nLinGr := 445
			oPrn:Say (Eval(bLin,_nLinGr,2), nPasso*3.5, Alltrim(BA1->BA1_NOMUSR) ,oFont5,100) //NOME USUARIO
			oPrn:Say (Eval(bLin,_nLinGr,1), nPasso*3.5, SA1->A1_END ,oFont5,100) //LOGRADOURO+NRO+COMPLEMENTO
			oPrn:Say (Eval(bLin,_nLinGr,1), nPasso*3.5, SA1->A1_BAIRRO+" "+SA1->A1_MUN+" - "+SA1->A1_EST ,oFont5,100) //BAIRRO+CIDADE+ESTADO
			oPrn:Say (Eval(bLin,_nLinGr,1), nPasso*3.5, SA1->A1_CEP ,oFont5,100) //CEP
			
			//-- TRATAR MENORES DE 18 ANOS EM 31/12/2011 CPF EM DUPLICIDADE
			cfamilia := cCodInt+cCodEmp+cMatric
			sql_cpf := " SELECT distinct B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC Matricula1, b1.ba1_cpfusr CPF , b1.BA1_DATNAS    FROM  " + RetSqlName("BA1") + " B11 ,  " + RetSqlName("BA1") + " B1 "
			if  cEmpAnt == '02'
				
				sql_cpf += " ,  " + RetSqlName("BA3") + " B3 "
				
			EndIf
			
			sql_cpf += " WHERE B11.BA1_FILIAL =' ' AND B11.D_E_L_E_T_=' '  AND B1.BA1_FILIAL= ' ' AND B1.D_E_L_E_T_= ' ' "
			sql_cpf += " AND (IDADE_S(TRIM(B11.BA1_DATNAS),'20181231') >= 0 )  "
			sql_cpf += " AND (IDADE_S(TRIM(B1.BA1_DATNAS),'20181231')  >= 0 ) "
			sql_cpf += " and b11.BA1_MATVID <> b1.BA1_MATVID AND B11.BA1_CPFUSR = B1.BA1_CPFUSR  and b1.ba1_cpfusr <> ' '"
			sql_cpf += " and (b1.ba1_datblo = ' ' or  b1.ba1_datblo > '20171231') and (b11.ba1_datblo = ' ' or  b11.ba1_datblo > '20171231')"
			sql_cpf += " AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC||B1.BA1_tipreg <> B11.BA1_CODINT|| B11.BA1_CODEMP || B11.BA1_MATRIC ||B11.BA1_tipreg  "
			If !empty(cCpf)
		       sql_cpf += " AND b1.ba1_cpfusr = '"+cCpf+"' "
			Else 
			   sql_cpf += " AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC  = '" + cFamilia + "' "
			EndIf    
			if  cEmpAnt == '01'
				sql_cpf += " AND B11.BA1_CODEMP NOT IN ('0004','0006','0010','0009')  AND B1.BA1_CODEMP NOT IN ('0004','0006','0010','0009') "
				
				//**'Marcela Coimbra'**
			Else
				
				
				sql_cpf += "  AND BA3_FILIAL = ' ' "
				sql_cpf += "  AND BA3_CODINT = B11.BA1_CODINT "
				sql_cpf += "  AND BA3_CODEMP = B11.BA1_CODEMP "
				sql_cpf += "  AND BA3_MATRIC = B11.BA1_MATRIC "
				sql_cpf += "  AND BA3_COBNIV = '1'            "
				sql_cpf += "  AND b3.d_e_l_e_t_ = ' '     "
				//**'Fim Marcela Coimbra'**
			EndIf
			
			/*        sql_cpf:=" select b1.ba1_codint|| b1.ba1_codemp|| b1.ba1_matric  Matricula1 , b1.ba1_cpfusr CPF , b1.BA1_DATNAS "
			sql_cpf+=" from  ba1010 b1  ,bts010  b2   , ba3010 b3 , sa1010 sa1 "
			sql_cpf+=" where b1.ba1_filial=' ' AND b3.ba3_FILIAL = ' ' AND bts_filial=' ' and A1_FILIAL = ' ' "
			sql_cpf+=" and b1.d_e_l_e_t_=' ' AND b2.d_e_l_e_t_=' ' AND b3.d_e_l_e_t_=' ' AND sa1.d_e_l_e_t_= ' ' and IDADE_S(TRIM(b1.BA1_DATNAS),'20121231') >= 18 "
			// and b1.BA1_DATNAS < '19940101' "
			
			sql_cpf+=" and b1.ba1_codint|| b1.ba1_codemp|| b1.ba1_matric = '" +cfamilia +"' "
			
			sql_cpf+=" AND ba1_matvid=bts_matvid and (b1.ba1_datblo=' ' or b1.ba1_datblo> to_char (sysdate,'yyyymmdd')) "
			sql_cpf+=" AND b1.ba1_codint = b3.ba3_codint AND b1.ba1_codemp = b3.ba3_codemp AND b1.ba1_matric = b3.ba3_matric and ba3_codcli = a1_cod "
			sql_cpf+=" and b1.ba1_cpfusr IN (select ba1_cpfusr from  ba1010 b11 where b11.ba1_filial=' ' and b11.d_e_l_e_t_=' ' AND b1.ba1_matvid <> b11.ba1_matvid"
			sql_cpf+=" and (b11.ba1_datblo=' ' or b11.ba1_datblo > to_char (sysdate,'yyyymmdd')) and b11.ba1_cpfusr<>' ' and IDADE_S(TRIM(b11.BA1_DATNAS),'20121231') >= 18 "
			//and b1.BA1_DATNAS < '19940101' "
			sql_cpf+=" and b11.ba1_codemp not in('0004','0006','0010','0009') GROUP by B11.ba1_cpfusr HAVING Count(*)>1 ) "
			sql_cpf+=" and b1.ba1_cpfusr<>' ' and b1.ba1_codemp not in('0004','0006','0010','0009')  ORDER BY  2,1	"
			*/
			
			//aki altamiro 15/03/2013
			/* cQuery := " SELECT B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC ||B1.BA1_tipreg  MATRIC  FROM  " + RetSqlName("BA1") + " B11 ,  " + RetSqlName("BA1") + " B1 "
			cQuery += " WHERE B11.BA1_FILIAL =' ' AND B11.D_E_L_E_T_=' '  AND B1.BA1_FILIAL= ' ' AND B1.D_E_L_E_T_= ' ' "
			cQuery += " AND ((IDADE_S(TRIM(B11.BA1_DATNAS),'20121231') >= 18 ) or (IDADE_S(TRIM(B11.BA1_DATNAS),'20121231') < 18 and b11.ba1_tipusu = 'T')) "
			cQuery += " AND ((IDADE_S(TRIM(B1.BA1_DATNAS),'20121231')  >= 18 ) or (IDADE_S(trim(B1.BA1_DATNAS),'20121231')  < 18 and b1.ba1_tipusu  = 'T')) "
			cQuery += " and b11.BA1_MATVID <> b1.BA1_MATVID AND B11.BA1_CPFUSR = B1.BA1_CPFUSR  and b1.ba1_cpfusr <> ' '"
			cQuery += " AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC||B1.BA1_tipreg <> B11.BA1_CODINT|| B11.BA1_CODEMP || B11.BA1_MATRIC ||B11.BA1_tipreg  "
			cQuery += " AND B1.BA1_CODINT|| B1.BA1_CODEMP || B1.BA1_MATRIC  = '" + cFamilia + "' "
			
			//if  cEmpAnt == '01'
			cQuery += " AND B11.BA1_CODEMP NOT IN ('0004','0006','0010','0009')  AND B1.BA1_CODEMP NOT IN ('0004','0006','0010','0009') "
			*/
			//ate altamiro 15/032013
			
			
			If Select(("TMP")) <> 0
				("TMP")->(DbCloseArea())
			Endif
			TCQuery sql_cpf Alias "TMP" New
			dbSelectArea("TMP")
			tmp->(dbGoTop())
			//FIM DA ALTERAÇÃO
			
			//------------------------------------------------------------------------
			//Angelo Henrique - Data: 11/04/2016
			//------------------------------------------------------------------------
			//Em alguns casos estava mostrando duplicidade onde não existia
			//Criada função com a query que pesquisa o mesmo CPF, caso ela retorne
			//mais de um resultado entra no informativo de duplicidade
			//------------------------------------------------------------------------
			IF u_ValDpl(tmp->cpf)  //tmp->Matricula1 == cfamilia
				oPrn:Line(Eval(bLin,_nLinGr,6), nPasso, _nLinGr, 2400)
				oPrn:Say (Eval(bLin,_nLinGr,5), nPasso, "Prezado Associado, identificamos duplicidade no cadastro de seu CPF em nosso sistema, ",oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "impedindo a geração do Informe para fins de declaração do IR. Entre urgente em contato" ,oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "com nossa central de Atendimento e regularize seu cadastro. Tel 3233-8855. " ,oFont5,100)
				
				sql_cpf:=" select b1.ba1_codint, b1.ba1_codemp, b1.ba1_matric, b1.ba1_tipreg, b1.BA1_DIGITO , b1.ba1_cpfusr , b1.BA1_DATNAS , b1.BA1_NOMUSR ,b1.ba1_ddd,b1.ba1_telefo, b1.ba1_ycel"
				sql_cpf+=" from  ba1010 b1  ,bts010  b2   , ba3010 b3 , sa1010 sa1 "
				sql_cpf+=" where b1.ba1_filial=' ' AND b3.ba3_FILIAL = ' ' AND bts_filial=' ' and A1_FILIAL = ' ' "
				sql_cpf+=" and b1.d_e_l_e_t_=' ' AND b2.d_e_l_e_t_=' ' AND b3.d_e_l_e_t_=' ' AND sa1.d_e_l_e_t_= ' ' "// and IDADE_S(TRIM(b1.BA1_DATNAS),'20121231') >= 18 "
				
				// 		      b1.BA1_DATNAS < '19940101' "
				
				sql_cpf+=" and b1.ba1_cpfusr = '"+tmp->cpf +"'"
				
				sql_cpf+=" AND ba1_matvid=bts_matvid and (b1.ba1_datblo=' ' or b1.ba1_datblo> to_char (sysdate,'yyyymmdd')) "
				sql_cpf+=" AND b1.ba1_codint = b3.ba3_codint AND b1.ba1_codemp = b3.ba3_codemp AND b1.ba1_matric = b3.ba3_matric and ba3_codcli = a1_cod "
				sql_cpf+=" and b1.ba1_cpfusr IN (select ba1_cpfusr from  ba1010 b1 where b1.ba1_filial=' ' and b1.d_e_l_e_t_=' ' "
				sql_cpf+=" and (b1.ba1_datblo=' ' or b1.ba1_datblo > to_char (sysdate,'yyyymmdd')) and b1.ba1_cpfusr <> ' ' "//and IDADE_S(TRIM(b1.BA1_DATNAS),'20121231') >= 18 "
				sql_cpf+=" and b1.ba1_codemp not in('0004','0006','0010','0009') GROUP by ba1_cpfusr HAVING Count(*)>1 ) "
				sql_cpf+=" and b1.ba1_cpfusr<>' ' and b1.ba1_codemp not in('0004','0006','0010','0009')  ORDER BY  2,1	"
				If Select(("TMP1")) <> 0
					("TMP1")->(DbCloseArea())
				Endif
				TCQuery sql_cpf Alias "TMP1" New
				dbSelectArea("TMP1")
				tmp1->(dbGoTop())
				oPrn:Say (Eval(bLin,_nLinGr,5), nPasso, space(2)+ space(2) ,oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "MATRICULA              NOME                            CPF          Telefone                           Nascimento " ,oFont4,100)
				oPrn:Line(Eval(bLin,_nLinGr,2), nPasso, _nLinGr, 2400)
				While !tmp1->(Eof())
					dNasc:=(substr(tmp1->BA1_DATNAS,7,2)+"/"+substr(tmp1->BA1_DATNAS,5,2)+"/"+substr(tmp1->BA1_DATNAS,3,2))
					oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, tmp1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(tmp1->BA1_NOMUSR,1,30)+space(2) + tmp1->BA1_CPFUSR + space(2)+"("+tmp1->ba1_ddd+")"+ tmp1->ba1_telefo+"/"+tmp1->ba1_ycel+space(1)+ dNasc,oFont4,100)
					tmp1->(DbSkip())
				Enddo
				
				//FIM DA ALTERAÇÃO
				
			ElseIf u_ValRetif(BA1->BA1_CODINT, BA1->BA1_CODEMP, BA1->BA1_MATRIC, BA1->BA1_TIPREG, BA1->BA1_DIGITO ) .And. cAno == "2015"
				
				//------------------------------------------------------------------------
				//Angelo Henrique - Data: 17/03/2016
				//------------------------------------------------------------------------
				//Rotina de validação para saber se deve ser enviado ao beneficiário
				//a carta de retificação do informativo com os valores corretos
				//------------------------------------------------------------------------
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Inicio da impressao do texto da carta...                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrn:Line(Eval(bLin,_nLinGr,6), nPasso, _nLinGr, 2400)
				oPrn:Say (Eval(bLin,_nLinGr,5), nPasso, "IMPOSTO DE RENDA 2018 - RETIFICAÇÃO DO INFORMATIVO "							,oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, " " 																					,oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "Prezado(a) associado(a), " 														,oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, " " 																					,oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "        Para efeito de sua declaração de imposto de renda pessoa física " 	,oFont5,200)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "2018,  informamos  os  valores  abaixo  retificados,  incluindo o valor "	,oFont5,200)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "descontado   em  contracheque  no  mês  de  dezembro/2015,  competência " 	,oFont5,200)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "janeiro/2016,    referente    à     assistência     médica    repassada " 	,oFont5,200)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "financeiramente    pela    PREVI/SEPLAG   à   CABERJ    em  05/01/2016. "	,oFont5,200)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, " " 																					,oFont5,200)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "        Desta  forma,  solicitamos  desconsiderar  a informação enviada " 	,oFont5,200)
				oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "anteriormente, substituindo-a pelos valores abaixo: " 						,oFont5,200)
				
				If mv_par10 == "T"
					
					if BA1->BA1_tipusu = "T" .and. empty (trim(BA1->BA1_CPFUSR)) .and. dtos(BA1->BA1_DATNAS) > '19970101'
						oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "MATRICULA              NOME                                                    VALOR  " ,oFont5,100)
					Else
						oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "MATRICULA              NOME                                 CPF                VALOR  " ,oFont5,100)
					EndIf
					
					oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+BA1->BA1_CPFUSR+space(3)+Transform(nVlrFam,"@E 999,999.99") ,oFont5,100)
					
				Else
					
					cSql2 := "SELECT CODINT, CODEMP, MATRIC, TIPREG, DIGITO ,SUM(VALOR) TOTUSR "
					If (SubStr(cNumEmp,1,2) == "01")
						if lsofat
							cSQL2 += " FROM IR_BENEF_SEPAR_fat "
						else
							cSQL2 += " FROM IR_BENEF_SEPAR_fat "
						EndIf
					Else
						cSql2 += "FROM IR_BENEF_SEPAR_INT "
					EndIf
					If !empty(cCpf)
                       cSql2 += " WHERE Cpf = '"+cCpf+"' "		
		            Else
					   cSql2 += "WHERE CODINT = '"+cCodInt+"' "
					   cSql2 += "AND CODEMP = '"+cCodEmp+"' "
					   cSql2 += "AND MATRIC = '"+cMatric+"' "
					EndIf    
					cSql2 += "AND ANOBASEIR = "+cAno+" "
					cSql2 += " GROUP BY CODINT, CODEMP, MATRIC, TIPREG, DIGITO "
					
					PlsQuery(cSQL2,"TRBUSR2")
					
					if BA1->BA1_tipusu = "T" .and. dtos(BA1->BA1_DATNAS) > '20100101' .and. empty (trim(BA1->BA1_CPFUSR))
						oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "MATRICULA              NOME                                                    VALOR  " ,oFont5,100)
					else
						oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "MATRICULA              NOME                                 CPF                VALOR  " ,oFont5,100)
					EndIF
					While !TRBUSR2->(Eof())
						BA1->(MsSeek(xFilial("BA1")+TRBUSR2->CodInt+TRBUSR2->CodEmp+TRBUSR2->Matric+TRBUSR2->TIPREG))
						//           BA1->(MsSeek(xFilial("BA1")+cCodInt+cCodEmp+cMatric+TRBUSR2->TIPREG))
						if BA1->BA1_tipusu = "T" .and. empty (trim(BA1->BA1_CPFUSR)) .and. dtos(BA1->BA1_DATNAS) > '20100101'
							oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+space(14)+Transform(TRBUSR2->TOTUSR,"@E 999,999.99") ,oFont5,100)
							
						ElseIf dtos(BA1->BA1_DATNAS) < '20100101' .and. empty (trim(BA1->BA1_CPFUSR))  .AND. BA1->BA1_tipusu = "T"
							oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+"Titular Maior idade sem CPF" ,oFont5,100)
						ElseIf dtos(BA1->BA1_DATNAS) < '20100101' .and. empty (trim(BA1->BA1_CPFUSR))  .AND. BA1->BA1_tipusu = "D"
							oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+"Dep. Maior idade sem CPF" ,oFont5,100)
						else
							If  dtos(BA1->BA1_DATNAS) < '20100101'  .Or. BA1->BA1_tipusu = "T"
								Ccpf :=BA1->BA1_CPFUSR
							else                       
   							    Ccpf :=BA1->BA1_CPFUSR
			//					Ccpf := '           '
							EndIf
							//         Ccpf :=BA1->BA1_CPFUSR
							oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+Ccpf+space(3)+Transform(TRBUSR2->TOTUSR,"@E 999,999.99") ,oFont5,100)
							//		    	                                     Substr(BA1->BA1_NOMUSR,1,35)+space(2)+BA1->BA1_CPFUSR+space(3)+Transform(TRBUSR2->TOTUSR,"@E 999,999.99") ,oFont5,100)
						EndIf
						if BA1->BA1_tipusu = "T" .and. empty (trim(BA1->BA1_CPFUSR))
							oPrn:Say (Eval(bLin,_nLinGr,5), nPasso, "CABE RESSALTAR QUE, EMBORA SEJA TITULAR DO PLANO, SEU CPF NÃO CONSTA EM NOSSO CADASTRO, CONSEQUENTEMENTE  ",oFont5,100)
							oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "NÃO TEMOS COMO INFORMAR Á SECRETARIA DA RECEITA FEDERAL OS VALORES PAGOS NO EXERCÍCIO DE "+cAno+" NA " ,oFont5,100)
							oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "DECLARAÇÃO DE DESPESAS MÉDICAS E SAÚDE - DMED." ,oFont5,100)
						EndIF
						TRBUSR2->(DbSkip())
						
					Enddo
					
					TRBUSR2->(DbCloseArea())
					
				EndIf
				
			ElseIf mv_par10 == "T"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Inicio da impressao do texto da carta...                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrn:Line(Eval(bLin,_nLinGr,6), nPasso, _nLinGr, 2400)
				oPrn:Say (Eval(bLin,_nLinGr,5), nPasso, "IMPOSTO DE RENDA - INFORMATIVO - DECLARAÇÃO PF ",oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "PARA EFEITO DE SUA DECLARAÇÃO DE IMPOSTO DE RENDA PESSOA FÍSICA, INFORMAMOS " ,oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "ABAIXO O VALOR PAGO DURANTE O ANO BASE "+cAno+", REFERENTE A ASSISTÊNCIA MÉDICA." ,oFont5,100)
				If !Empty(BA3->BA3_DATBLO) //09/03/09
					oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "DE SUA MATRÍCULA INATIVA." ,oFont5,100)
				EndIf
				if BA1->BA1_tipusu = "T" .and. empty (trim(BA1->BA1_CPFUSR)) .and. dtos(BA1->BA1_DATNAS) > '19970101'
					oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "MATRICULA              NOME                                                    VALOR  " ,oFont5,100)
				Else
					oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "MATRICULA              NOME                                 CPF                VALOR  " ,oFont5,100)
				EndIf
				oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+BA1->BA1_CPFUSR+space(3)+Transform(nVlrFam,"@E 999,999.99") ,oFont5,100)
			Else
				cSql2 := "SELECT CODINT, CODEMP, MATRIC, TIPREG, DIGITO ,SUM(VALOR) TOTUSR "
				If (SubStr(cNumEmp,1,2) == "01")
					if lsofat
						cSQL2 += " FROM IR_BENEF_SEPAR_fat "
					else
						cSQL2 += " FROM IR_BENEF_SEPAR_fat "
					EndIf
				Else
					cSql2 += "FROM IR_BENEF_SEPAR_INT "
				EndIf                                  
				If !empty(cCpf)
                   cSql2 += " WHERE Cpf = '"+cCpf+"' "		
		        Else
				   cSql2 += "WHERE CODINT = '"+cCodInt+"' "
				   cSql2 += "AND CODEMP = '"+cCodEmp+"' "
		    	   cSql2 += "AND MATRIC = '"+cMatric+"' "
		    	EndIf    
				cSql2 += "AND ANOBASEIR = "+cAno+" "
				cSql2 += " GROUP BY CODINT, CODEMP, MATRIC, TIPREG, DIGITO "
				//cSql2 += "GROUP BY CODINT, CODEMP, MATRIC, TIPREG, DIGITO  "
				PlsQuery(cSQL2,"TRBUSR2")
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Inicio da impressao do texto da carta...                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrn:Line(Eval(bLin,_nLinGr,6), nPasso, _nLinGr, 2400)
				//   	      oPrn:Say (Eval(bLin,_nLinGr,5), nPasso, "IMPOSTO DE RENDA - INFORMATIVO - DECLARAÇÃO PF ",oFont5,100)
				//		  oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "PARA EFEITO DE SUA DECLARAÇÃO DE IMPOSTO DE RENDA PESSOA FÍSICA, INFORMAMOS " ,oFont5,100)
				//		  oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "ABAIXO O VALOR PAGO DURANTE O ANO BASE "+cAno+", REFERENTE A ASSISTÊNCIA MÉDICA." ,oFont5,100)
				
				if BA1->BA1_tipusu = "T" .and. empty (trim(BA1->BA1_CPFUSR))
					oPrn:Say (Eval(bLin,_nLinGr,5), nPasso, "RELATÓRIO DE PAGAMENTOS REALIZADOS NO EXERCÍCIO DE "+cAno+" ",oFont5,100)
					oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "PREZADO(A) ASSOCIADO(A), INFORMAMOS ABAIXO O VALOR PAGO DURANTE O ANO BASE "+cAno+", REFERENTE A ASSISSTENCIA MÉDICA:" ,oFont5,100)
					
				else
					oPrn:Say (Eval(bLin,_nLinGr,5), nPasso, "IMPOSTO DE RENDA - INFORMATIVO - DECLARAÇÃO PF ",oFont5,100)
					oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "PARA EFEITO DE SUA DECLARAÇÃO DE IMPOSTO DE RENDA PESSOA FÍSICA, INFORMAMOS " ,oFont5,100)
					oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "ABAIXO O VALOR PAGO DURANTE O ANO BASE "+cAno+", REFERENTE A ASSISTÊNCIA MÉDICA " ,oFont5,100)
				EndIf
				
				If !Empty(BA3->BA3_DATBLO) //09/03/09
					oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "DE SUA MATRÍCULA INATIVA." ,oFont5,100)
				Endif
				if BA1->BA1_tipusu = "T" .and. dtos(BA1->BA1_DATNAS) > '20100101' .and. empty (trim(BA1->BA1_CPFUSR))
					oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "MATRICULA              NOME                                                    VALOR  " ,oFont5,100)
				else
					oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "MATRICULA              NOME                                 CPF                VALOR  " ,oFont5,100)
				EndIF
				While !TRBUSR2->(Eof())
					BA1->(MsSeek(xFilial("BA1")+TRBUSR2->CodInt+TRBUSR2->CodEmp+TRBUSR2->Matric+TRBUSR2->TIPREG))
					//           BA1->(MsSeek(xFilial("BA1")+cCodInt+cCodEmp+cMatric+TRBUSR2->TIPREG))
					if BA1->BA1_tipusu = "T" .and. empty (trim(BA1->BA1_CPFUSR)) .and. dtos(BA1->BA1_DATNAS) > '2010101'
						oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+space(14)+Transform(TRBUSR2->TOTUSR,"@E 999,999.99") ,oFont5,100)
						
					ElseIf dtos(BA1->BA1_DATNAS) < '20100101' .and. empty (trim(BA1->BA1_CPFUSR))  .AND. BA1->BA1_tipusu = "T"
						oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+"Titular Maior idade sem CPF" ,oFont5,100)
					ElseIf dtos(BA1->BA1_DATNAS) < '20100101' .and. empty (trim(BA1->BA1_CPFUSR))  .AND. BA1->BA1_tipusu = "D"
						oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+"Dep. Maior idade sem CPF" ,oFont5,100)
					else
						If dtos(BA1->BA1_DATNAS) <'20100101'  .Or. BA1->BA1_tipusu = "T"
							Ccpf :=BA1->BA1_CPFUSR
						else
							Ccpf := '           '
						EndIf
						//         Ccpf :=BA1->BA1_CPFUSR
						oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, BA1->(BA1_CODINT+"."+BA1_CODEMP+"."+BA1_MATRIC+"."+BA1_TIPREG+"-"+BA1_DIGITO)+space(2) + Substr(BA1->BA1_NOMUSR,1,35)+space(2)+Ccpf+space(3)+Transform(TRBUSR2->TOTUSR,"@E 999,999.99") ,oFont5,100)
						//		    	                                     Substr(BA1->BA1_NOMUSR,1,35)+space(2)+BA1->BA1_CPFUSR+space(3)+Transform(TRBUSR2->TOTUSR,"@E 999,999.99") ,oFont5,100)
					EndIf
					if BA1->BA1_tipusu = "T" .and. empty (trim(BA1->BA1_CPFUSR))
						oPrn:Say (Eval(bLin,_nLinGr,5), nPasso, "CABE RESSALTAR QUE, EMBORA SEJA TITULAR DO PLANO, SEU CPF NÃO CONSTA EM NOSSO CADASTRO, CONSEQUENTEMENTE  ",oFont5,100)
						oPrn:Say (Eval(bLin,_nLinGr,2), nPasso, "NÃO TEMOS COMO INFORMAR Á SECRETARIA DA RECEITA FEDERAL OS VALORES PAGOS NO EXERCÍCIO DE "+cAno+" NA " ,oFont5,100)
						oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "DECLARAÇÃO DE DESPESAS MÉDICAS E SAÚDE - DMED." ,oFont5,100)
					EndIF
					TRBUSR2->(DbSkip())
					
				Enddo
				TRBUSR2->(DbCloseArea())
			endif
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime rodape da carta...                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrn:Say (Eval(bLin,_nLinGr,50), nPasso, "Rua do Ouvidor, 91 - 2o ao 5o andar - Centro - Rio de Janeiro",oFont5,100)
			//oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "Fax: (21) 2505-6439",oFont5,100)
			If (SubStr(cNumEmp,1,2) == "01")
				oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "E-MAIL: faleconosco@caberj.com.br",oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "Home-page: http://www.caberj.com.br",oFont5,100)
			else
				oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "E-MAIL: faleconosco@integralsaude.com.br",oFont5,100)
				oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "Home-page: http://www.integralsaude.com.br",oFont5,100)
			EndIf
			oPrn:Say (Eval(bLin,_nLinGr,1), nPasso, "Telefone: (0xx21) 3233-8855 - Tele-Atendimento",oFont5,100)
			
			oPrn:EndPage()
			
		Endif
		
		
		/*
		nLin := 15
		@nLin,30 PSAY " D  E  C  L  A  R  A  C  A  O "
		nLin := nLin +3
		@nLin,03 PSAY " Declaramos  para  os  devidos  fins  ter  recebido  do(a)  Sr(a). "
		nLin ++
		@nLin,03 PSAY Alltrim(Posicione("BA1",2,xFilial("BA1")+cCodInt+cCodEmp+cMatric+"00","BA1_NOMUSR")) + " a quantia de R$ "+Transform(nVlrFam,"@E 999,999.99")+" (" + Substr(Extenso(nVlrFam),1,22)
		nLin ++
		@nLin,03 PSAY Substr(Extenso(nVlrFam),23)+")"
		nLin ++
		@nLin,03 PSAY "referente ao pagamento das parcelas do mes de "+MesExtenso(Val(cMesIni))+" a "+MesExtenso(Val(cMesFim))+" de "+cAno+","
		nLin ++
		@nLin,03 PSAY "do plano "+cEmp+"."
		nLin := nLin + 4
		@nLin,05 PSAY "Matricula: "+cCodInt+"."+cCodEmp+"."+cMatric
		nLin ++
		
		BA1->(dbSetOrder(2))
		IF BA1->(dbSeek(xFilial("BA1")+cCodInt+cCodEmp+cMatric))
			@nLin,05 PSAY "Dependentes: "
			nLin ++
			While BA1->(! Eof() .AND. BA1_CODINT+BA1_CODEMP+BA1_MATRIC == cCodInt+cCodEmp+cMatric )
				If BA1->BA1_TIPREG <> "00"
					@nLin,20 PSAY BA1->BA1_NOMUSR
					nLin ++
				Else
					cCPF := BA1->BA1_CPFUSR
				EndIf
				BA1->(DbSkip())
			EndDo
		ENDIF
		
		@nLin,05 PSAY "CPF: "+cCPF
		nLin := nLin + 2
		
		@nLin,20 PSAY "MES"
		@nLin,45 PSAY "VALOR"
		nLin ++
		
		While !TRB->(Eof())
			
			@nLin,20 PSAY MesExtenso(TRB->MESBASE)
			@nLin,40 PSAY Transform(TRB->VALOR,"@E 999,999.99")
			nLin ++
			
			TRB->(DBSkip())
			
		EndDo
		
		@nLin,20 PSAY "TOTAL: "
		@nLin,40 PSAY Transform(nVlrFam,"@E 999,999.99")
		nLin += 4
		@nLin,05 PSAY cLoc + ","+Substr(dtoc(dDataBase),1,2)+" de "+MesExtenso(Month(dDataBase))+" de 20"+ Substr(dtoc(dDataBase),7,4)
		nLin++
		@ nLin, 000 Psay ""
		nLin++
		*/
		
	Next J
	
	//Set Device TO Screen
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se impressao em disco, chama o gerenciador de impressao...          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	/*
	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif
	
	MS_FLUSH()
	*/
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apresenta o resultado...                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRB->(DbCloseArea())
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaSX1   ºAutor  ³ Jean Schulz        º Data ³  10/10/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria / atualiza parametros solicitados na geracao do boleto.º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Caberj.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaSX1(cPerg)
	
	PutSx1(cPerg,"01",OemToAnsi("Ano da declaração: ")		,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"02",OemToAnsi("Qtd Copias: ")				,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"03",OemToAnsi("Nome Instituição: ")		,"","","mv_ch3","C",30,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"04",OemToAnsi("Local da declaração: ")	,"","","mv_ch4","C",30,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"05",OemToAnsi("Codigo operadora: ")		,"","","mv_ch5","C",04,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"06",OemToAnsi("Empresa inicial: ") 		,"","","mv_ch6","C",04,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"07",OemToAnsi("Empresa final: ") 			,"","","mv_ch7","C",04,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"08",OemToAnsi("Matrícula inicial: ")		,"","","mv_ch8","C",06,0,0,"G","","BA1NUS","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"09",OemToAnsi("Matrícula final: ")		,"","","mv_ch9","C",06,0,0,"G","","BA1NUS","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"10",OemToAnsi("Aberto ?: ")	          	,"","","mv_ch10","C",01,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"11",OemToAnsi("Somente Bloqueados ?: ")	,"","","mv_ch11","C",01,0,0,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"12",OemToAnsi("Com Fatura (S/N)   ?: ")	,"","","mv_ch12","C",01,0,0,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",{},{},{})
	PutSx1(cPerg,"13",OemToAnsi("Cpf Usuario : ") 			,"","","mv_ch13","C",11,0,0,"G","","","","","mv_par13","","","","","","","","","","","","","","","","",{},{},{})
	
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValRetif  ºAutor  ³ Angelo Henrique    º Data ³  17/03/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para validar se o beneficiário em questão  º±±
±±º          ³necessita que seja enviada carta retificadora               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ValRetif(_cCodInt, _cCodEmp, _cMatric, _cTipReg, _cDigit )
	
	Local _aArea 		:= GetArea()
	Local _cAlias1	:= GetNextAlias()
	Local _cQuery		:= ""
	Local _lRet		:= .F.
	
	Default _cCodInt	:= ""
	Default _cCodEmp	:= ""
	Default _cMatric	:= ""
	Default _cTipReg	:= ""
	Default _cDigit	:= ""
	
	_cQuery := " SELECT CODINT, CODEMP, MATRIC, TIPREG, DIGITO "
	_cQuery += " FROM ASSOC_PREVI_IR "
	_cQuery += " WHERE "
	_cQuery += " CODINT = '" + _cCodInt	+ "' AND "
	_cQuery += " CODEMP = '" + _cCodEmp	+ "' AND "
	_cQuery += " MATRIC = '" + _cMatric	+ "' AND "
	_cQuery += " TIPREG = '" + _cTipReg	+ "' AND "
	_cQuery += " DIGITO = '" + _cDigit		+ "' "
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	PLSQuery(_cQuery,_cAlias1)
	
	If !(_cAlias1)->(EOF())
		
		_lRet := .T.
		
	EndIf
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	RestArea(_aArea)
	
Return _lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValDpl	   ºAutor  ³ Angelo Henrique    º Data ³  11/04/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para validar se o beneficiário em questão  º±±
±±º          ³esta com CPF duplicado na base.                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ValDpl(_cCPF)
	
	Local _cQuery := ""
	Local _lRet 	:= .F.
	Local _aArCar	:= GetNextAlias()
	
	_cQuery := " SELECT B1.BA1_CODINT, B1.BA1_CODEMP, B1.BA1_MATRIC, B1.BA1_TIPREG, B1.BA1_DIGITO , B1.BA1_CPFUSR , "
	_cQuery += " B1.BA1_DATNAS , B1.BA1_NOMUSR ,B1.BA1_DDD,B1.BA1_TELEFO, B1.BA1_YCEL "
	_cQuery += " FROM BA1010 B1, BTS010 B2, BA3010 B3, SA1010 SA1 "
	_cQuery += " WHERE B1.BA1_FILIAL=' ' AND B3.BA3_FILIAL = ' ' AND BTS_FILIAL=' ' AND A1_FILIAL = ' ' "
	_cQuery += " AND B1.D_E_L_E_T_=' ' AND B2.D_E_L_E_T_=' ' AND B3.D_E_L_E_T_=' ' AND SA1.D_E_L_E_T_= ' ' "
	_cQuery += " AND B1.BA1_CPFUSR = '" + _cCPF+ "' "
	_cQuery += " AND BA1_MATVID=BTS_MATVID AND (B1.BA1_DATBLO=' ' OR B1.BA1_DATBLO >= '20180101'" /// TO_CHAR (SYSDATE,'YYYYMMDD')) 
	_cQuery += " AND B1.BA1_CODINT = B3.BA3_CODINT AND B1.BA1_CODEMP = B3.BA3_CODEMP AND B1.BA1_MATRIC = B3.BA3_MATRIC AND BA3_CODCLI = A1_COD "
	_cQuery += " AND B1.BA1_CPFUSR IN (SELECT BA1_CPFUSR FROM  BA1010 BA1 WHERE BA1.BA1_FILIAL=' ' AND BA1.D_E_L_E_T_=' ' "
	_cQuery += " AND (BA1.BA1_DATBLO=' ' OR BA1.BA1_DATBLO >= '20180101' AND BA1.BA1_CPFUSR <> ' ' "                      
	_cQuery += " and bA1.BA1_MATVID <> b1.BA1_MATVID "
	_cQuery += " AND BA1.BA1_CODEMP NOT IN('0004','0006','0010','0009') GROUP BY BA1_CPFUSR HAVING COUNT(*)>1 ) "
	_cQuery += " AND B1.BA1_CPFUSR <> ' ' AND B1.BA1_CODEMP NOT IN('0004','0006','0010','0009')  ORDER BY  2,1	"
	
	If Select(_aArCar) > 0
		dbSelectArea(_aArCar)
		dbCloseArea()
	EndIf
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_aArCar,.T.,.T.)
			
	If (_aArCar)->(!Eof())
		
		_lRet := .T.
				
	EndIf
	
	If Select(_aArCar) > 0
		dbSelectArea(_aArCar)
		dbCloseArea()
	EndIf
	
Return _lRet