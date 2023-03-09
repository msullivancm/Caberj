#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/                                                                                      
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR189   º Autor ³Altamiro              º Data ³ 01/10/12  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina para CONFERENCIA da PRIMAVIDA contra a CABERJ       º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR189

	Local cMsg			:= ""
	Private cDpj        := 'Não'   
	private cImp        := 'Não'
	Private oLeTxt
	Private lAbortPrint :=.F.
	Private cPerg       := "CABR189"
	Private cTitulo     := "Importa e Critica NF Carioca "
	Private lpvez       :=.T.   
	Private cTpCrit     :=" "  
	Private lImporta    := .F.  
	Private f_ok        := .F.
	Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado         

	private cpgto       := ' '    

	private cTitCSald   := ' '   
	PRIVATE nVlrTitPri  := 0.00
	PRIVATE nVlrTitcmp  := 0.00   
	private cNomeArq1   := ' ' 

	SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

	cMsg += " Este programa ira fazer a leitura do arquivo CSV  relativo as   " + CRLF
	cMsg += " MATRICULAS odontologicas cobradas pela PRIMAVIDA e cruza-las    " + CRLF
	cMsg += " com o cadastro da CABERJ                                        " + CRLF
	oDlg1      := MSDialog():New( 095,232,368,705,"Leitura de Arquivo CVS",,,.F.,,,,,,.T.,,,.T. )
	oGrp1      := TGroup():New( 008,012,100,224,"Arquivo CVS",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
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

	Local nCont			:= 0     
	Private  cNomeArq	:= ""
	Private  cMesAdi	:= ""
	Private  cAnoAdi	:= "" 
	Private  cCritica   := " " 
	Private  cCritImp   := " " 
	Private  aErro		:= {}
	Private  aOk		:= {} 
	Private  aDados     := {}    

	Private  aDadospri  := {}     
	Private  aDadoscab  := {}  
	Private  aDadosEx   := {}
	private  aDadExcmp  := {}   
	Private  aDadosPCon := {}     
	Private  aDadosPDiv := {}  
	Private  aDadosVlrD := {}     
	Private  aDadosNExP := {}   
	private  aDadosNExC := {}  
	private  aDadNExCmp := {} 

	Private  aDadosBloq := {}  
	Private  aDadosFVig := {} 
	private  aDadosDtCon:= {}  
	private  aDadosDtDif:= {}

	Private  aRespri  := {}     
	Private  aRescab  := {}  
	Private  aResEx   := {}     
	Private  aResPCon := {}     
	Private  aResPDiv := {}  
	Private  aResVlrD := {}     
	Private  aResNExP := {}     
	Private  aResNExC := {} 
	Private  aResConv := {}
	Private  aResDive := {}  
	private  aDadosVal:= {} 
	private  aDadInVal:= {} 


	private aDadosCmp := {} 

	private aDadNExCmp:= {} 
	private aDadVDCmp := {}  
	private aDadCSCmp := {}


	private i         := 0 
	private x         := 0 
	private z         := 0
	private nPos      := 0    
	private lfaz      :=.F.

	Private  cUsua    := SubStr(cUSUARIO,7,15)     

	private  aCabeCab  := {"Matric.Compl","CodInt" , "CodEmp" , "Matric" , "Tipreg", "Digito","Nome Usuar", "Tp Usuar"  ,"cod. plano " , "desc. Plano " ,"Status" , "Vlr cont", "Dt. Inc"}  
	private  aCabePri  := {"Codigo	","Numero Funcional","Nome","CPF","Descrição","Categoria","Data de adesao","Plano","Valor"}                                                                                                                           
	private  aCabeCmp  := {"Matric.Compl","Ano Comp ","Mes Comp","Parcela","Valor Cobrado ","Prefixo Tit","Num. Tit","Tip Tit ","Venc Real","baixa", "Vlr Tot. Tit","saldo Tit", "T/D", "Recno", "Vlr Primavida", "usuario", "CodPlaCaberj", "Desc. Plano", "Caberj"}  
	private  aCabeEx   := {"Titulos da planilha" , "Matric.Compl",  "Nome Usuar" ,"CPF", "TIT/DEP"  , "Data de adesao" , "Plano-Pri", "Valor-pri", "Valor Cab", "Dt.Inc-cab"}           
	private  aCabePCon := {"Titulos da planilha" , "Matric.Compl",  "Nome"       ,"CPF", "Categoria",  "Data de adesao" , "Plano-Pri"    , "Valor-pri"    , "cod. plano - cab" , "Valor Cab" , "Status-cab", "Dt.Inc-cab"} 
	private  aCabePDiv := {"Titulos da planilha" , "Matric.Compl",  "Nome"       ,"CPF", "Categoria",  "Data de adesao" , "Plano-Pri"    , "Valor-pri"    , "cod. plano - cab" , "Valor Cab" , "Status-cab", "Dt.Inc-cab","Mat.Odonto" , "Dt Bloq", "Mot Bloq"} 
	private  aCabeVlrD := {"Titulos da planilha" , "Matric.Compl",  "Nome"       ,"CPF", "Descrição", "Categoria"      , "cod. plano - cab" , "Data de adesao" , "Plano-Pri", "Valor Cab", "Status-cab", "Dt.Inc-cab","Mat.Odonto" , "Dt Bloq", "Mot Bloq"}     
	private  aCabeNExP := {"Titulos da planilha" , "Matric.Compl"}
	private  aCabeExC  := {"Titulos da planilha" , "Codigo"	   ,"Nome"         ,"CPF"          , "Categoria"   ,"Data de adesao"  ,"Plano"    ,"Valor"}           
	private  aCabebloq := {"Titulos da planilha" , "Matric.Compl",  "Nome"       ,"CPF", "Categoria",  "Data de adesao" , "Plano-Pri"    , "Valor-pri"    , "cod. plano - cab" , "Valor Cab" , "Status-cab", "Dt.Inc-cab","Mat.Odonto" , "Dt Bloq", "Mot Bloq"} 

	private  aCabeConv := {"PLANO","Observações","T/D","	Vlr Primavida","QTDA"}

	private  aCabeFvig := {"Titulos da planilha" , "Matric.Compl",  "Nome"       ,"CPF", "Categoria",  "Data de adesao" , "Plano-Pri"    , "Valor-pri"    , "cod. plano - cab" , "Valor Cab" , "Status-cab", "Dt.Inc-cab","Mat.Odonto" , "Dt Bloq", "Mot Bloq" , "data Inclu"} 

	private  aCabeval  := {"Descrição",	"Codigo","Nome","CPF","Categoria","Data de adesao","Plano","Valor primavida","Dt baixa",	"Saldo tit","T/D","Vlr Pgto Pri",	"Vlr Cobrando",	"Plano cabrj",	"Observaçõies" }

	private  aCabeExcmp:= {                       "Descrição","Codigo","Nome","CPF","Categoria","Data de adesao","Plano","Valor" ,"Matric.Compl",  "Valor Cobrado" , "baixa","saldo Tit" , "T/D","	Vlr pagto primavida" }


	private  aCabmXEP:= {"Descrição","Matricula","Vlr Cobrado","Baixa","Saldo Tit","T/D","	VlrPgto Primavida","cod Plano Cabrj","Desc Plano Cabrj" } 

	private  aCabeVDCmp:= {"Descrição","Codigo","Nome","CPF","Categoria","Data de adesao","Plano","Valor","Matric.Compl","Valor Cobrado" , "baixa","saldo Tit" , "T/D" , "Vlr Pgto Primavida" } 
	private  aCabeCSCmp:= {"Descrição","Codigo","Nome","CPF","Categoria","Data de adesao","Plano","Valor","Matric.Compl","Valor Cobrado" , "baixa","saldo Tit" , "T/D" , "Vlr pgto Primavida","Vlr calc. Primavida "}

	private  aCabeVCmp := {"Descrição","Codigo","Nome","CPF","Categoria","Data de adesao","Plano","Valor","Matric.Compl","Valor Cobrado" , "baixa","saldo Tit" }
	private  aCabemat  := {"Descr","Matricula","Vlr Cobrado"}
	cNomeArq	:= mv_par01
	dDtInic		:= dtos(mv_par02)   
	dDtBloq     := dtos(mv_par03) 
	cCompMes    := SUBSTR(mv_par04,1,2) 
	cCompAno    := SUBSTR(mv_par04,4,4)    
	nConsid     := mv_par05   
	cMatric     := mv_par06
	nproces     := mv_par07 
	nMarcar     := mv_par08 
	nReproc     := mv_par09

	If !File(cNomeArq)  .and. nReproc != 1
		MsgStop("Arquivo Inválido! Programa encerrado.")
		Close(oLeTxt)
		Return
	End       

	Processa({||Processa1()}, cTitulo, "", .T.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Libera impressao                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


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

	cQuery := " SELECT count(*) qtd
	cQuery += CRLF +"  FROM " + RetSqlName("BM1") + " BM1" 
	cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "
	cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes +"' "
	cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"          

	/*  cQuery += CRLF +"    AND BM1_codemp    = '0024'"          
	cQuery += CRLF +"    AND BM1_matric    In ('024353' , '024417')"
	*/            
	cQuery += CRLF +"    AND BM1_codemp    = '0024'"               
	cQuery += CRLF +"    AND BM1_YVLPRI  > 0 "           

	If Select(("TMP1")) <> 0 
		("TMP1")->(DbCloseArea()) 
	Endif

	TCQuery cQuery Alias "TMP1" New 

	dbSelectArea("TMP1")

	tmp1->(dbGoTop())  

	If ( tmp1->qtd > 0 .and.  nReproc == 1 )   
		If nMarcar == 1 
			FFazRep()  
		EndIf   
		FGrvPRep() 
		FGrvPlan('adadoscmpR')
		return() 
	ElseIf ( ( tmp1->qtd >  0 .and.  nReproc != 1 );
	.or.( tmp1->qtd == 0 .and.  nReproc == 1 ) )

		If tmp1->qtd > 0 .and. nReproc != 1    
			MsgAlert("Arquivo Ja Processado, só pode ser Reprocessado ","Atencao!")  
		Else 
			MsgAlert("Arquivo NÃO processado, Não pode ser Reprocessado ","Atencao!")      
		EndIf    

		Return()

	EndIf     


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

		aAdd(aDadospri,  { adados[01],  adados[02],adados[03] , adados[04], adados[05],adados[06], adados[07] , adados[08], adados[09] })         

		If (nPos := Ascan(aRespri, {|e| e[1]+e[2] == adados[08]+adados[06] }))== 0     

			aAdd(aRespri,{adados[08],adados[06], val(adados[09]), 1 } )

		Else 

			aRespri[nPos,3] := aRespri[nPos,3] + val(adados[09])  

			aRespri[nPos,4] := aRespri[nPos,4] + 1

		EndIf  

	EndDo  
	////           
	If nConsid == 2
		cQuery := " SELECT Bm1.bm1_codint ||'.'|| Bm1.bm1_codemp ||'.'|| Bm1.bm1_matric ||'-'|| Bm1.bm1_tipreg ||'.'|| Bm1.bm1_digito  matrbm1 , "
		cQuery += CRLF +"  Ba1.ba1_codint ||'.'|| Ba1.ba1_codemp ||'.'|| Ba1.ba1_matric ||'-'|| Ba1.ba1_tipreg ||'.'|| Ba1.ba1_digito  matrba1 , "   
		cQuery += CRLF +"  Ba10.ba1_codint ||'.'|| Ba10.ba1_codemp ||'.'|| Ba10.ba1_matric ||'-'|| Ba10.ba1_tipreg ||'.'|| Ba10.ba1_digito  matrba10 , "  

		cQuery += CRLF +" bm1.bm1_nomusr nome,   BM1_ANO , BM1_MES , BM1_NUMPAR , BM1_VALOR ,"
		cQuery += CRLF +"  E1_PREFIXO , E1_NUM , E1_TIPO , E1_VENCREA , E1_BAIXA , E1_VALOR , E1_SALDO  , bm1_deseve  ,  decode(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') TIPUSU , BM1.R_e_c_n_o_ BM1REC , bm1_Yvlpri vlpri  , "
		cQuery += CRLF +"  nvl(BI3_CODIGO,' ' ) codpla , DECODE ( nvl(BI3_CODIGO,' ' ), '0098', 'DENTAL - E' , '0099', 'DENTAL - M' ,' ' ) despla  , " 

		cQuery += CRLF +"  BM1_YVLPRI VLRCALC , BM1_DTCPR DTCALC , BM1_YVLPR1 VLRRCALC , BM1_DTCPR1 DTRCALC "            

		cQuery += CRLF +"  FROM " + RetSqlName("BM1") + " BM1 , " + RetSqlName("SE1") + " SE1  , " + RetSqlName("BA1") + " BA1 " 
		cQuery += CRLF +" , " + RetSqlName("BA1") + " BA10 , " + RetSqlName("BI3") + " BI3  " 
		cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "
		cQuery += CRLF +"    AND E1_FILIAL  = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  " 
		cQuery += CRLF +"    AND BA1.BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  " 
		cQuery += CRLF +"    AND BA10.BA1_FILIAL = '" + xFilial("BA1") +"' AND BA10.D_E_L_E_T_ = ' '  "
		cQuery += CRLF +"    AND BI3_FILIAL(+)= '" + xFilial("BI3") +"' and bI3.D_E_L_E_T_(+)  =  ' ' "
		cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes +"' "
		cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"                    
		If !EMPTY(cMatric)
			cQuery += CRLF +"    AND BM1_CODINT || BM1_CODEMP||bm1_matric||BM1_TIPREG ||PBM1_DIGITO  = '"+cMatric+"' "
		EndIf                                                        
		If nReproc == 1
			cQuery += CRLF +"    AND E1_SALDO    =  0  AND  BM1_YVLPR1 = 0 "
			cQuery += CRLF +"    AND ((BM1_valor =  9  AND  BM1_YVLPRI = 0) " 
			cQuery += CRLF +"     OR  (BM1_valor =  26.95  AND  BM1_YVLPRI = 8.5)  " 
			cQuery += CRLF +"     OR  (BM1_valor =  26.95  AND  BM1_YVLPRI = 0)) "
		EndIf                  

		cQuery += CRLF +"    AND BM1_codemp    = '0024'"          
		cQuery += CRLF +"    AND BM1_matric    In ('024353' , '024417')"

		cQuery += CRLF +"    AND BM1_CODEMP in ( '0024' , '0025','0027','0028') " 
		cQuery += CRLF +"    AND BM1_CODTIP = '102' AND BM1_CODEVE  IN ('0103','0105')"
		cQuery += CRLF +"    AND E1_PREFIXO =  BM1_PREFIX     "
		cQuery += CRLF +"    AND E1_NUM     =  BM1_NUMTIT     "
		cQuery += CRLF +"    AND E1_TIPO    =  BM1_TIPTIT     "                                      
		cQuery += CRLF +"    AND  BM1_CODINT = ba1.BA1_CODINT "
		cQuery += CRLF +"    AND  BM1_CODEMP = ba1.BA1_CODEMP "
		cQuery += CRLF +"    AND  BM1_MATRIC = ba1.BA1_MATRIC "
		cQuery += CRLF +"    AND  BM1_TIPREG = ba1.BA1_TIPREG "
		cQuery += CRLF +"    AND  BM1_DIGITO = ba1.BA1_DIGITO "      

		cQuery += CRLF +" and ba10.BA1_CODINT(+) = substr(BA1.BA1_YMTODO,1,4)   "
		cQuery += CRLF +" and ba10.BA1_CODEMP(+) = substr(BA1.BA1_YMTODO,5,4)   "
		cQuery += CRLF +" and ba10.BA1_MATRIC(+) = substr(BA1.BA1_YMTODO,9,6)   "
		cQuery += CRLF +" and ba10.BA1_TIPREG(+) = substr(BA1.BA1_YMTODO,15,2)  "
		cQuery += CRLF +" and ba10.BA1_DIGITO(+) = substr(BA1.BA1_YMTODO,17,1)  "

		cQuery += CRLF +"  and BI3_VERSAO(+) = nvl(BA10.BA1_VERSAO,' ') "
		cQuery += CRLF +"  and BI3_CODIGO(+) = nvl(BA10.BA1_CODPLA,' ') " 
		cQuery += CRLF +"  ORDER BY BM1_CODINT , BM1_CODEMP , BM1_MATRIC , BM1_TIPREG , BM1_DIGITO "    

		If Select(("TMP")) <> 0 
			("TMP")->(DbCloseArea()) 
		Endif

		TCQuery cQuery Alias "TMP" New 

		dbSelectArea("TMP")

		tmp->(dbGoTop())                    
		x:=0
		While !(TMP->(Eof()))                                                                                                                                                                                                   

			aAdd(aDadosCmp, {tmp->matrbm1 , tmp->BM1_ANO , tmp->BM1_MES , tmp->BM1_NUMPAR , tmp->BM1_VALOR ,tmp->E1_PREFIXO , tmp->E1_NUM , tmp->E1_TIPO , tmp->E1_VENCREA , tmp->E1_BAIXA , tmp->E1_VALOR , tmp->E1_SALDO, TMP->TIPUSU , TMP->BM1REC , tmp->vlpri , tmp->nome ,tmp->codpla,tmp->despla ,tmp->VLRCALC , tmp->VLRRCALC}) 
			/*                              1            2              3                  4               5                 6              7               8               8                 10             11             12            13           14               15            16       17           18       19              20
			*/
			tmp->(DbSkip())

		EndDo 
	EndIf     

	i:=1        
	x:=1             
	z:=1

	If nConsid == 2    
		DBSELECTAREA('BM1') 
		Fconfcob()     
		fExcel(nConsid)
	EndIf

Return()               

Static Function Fconfcob()   
	while len(adadospri) >= i .or. len(adadoscmp) >= z      

		f_ok := .T. 
		lfaz := .F.
		cTitCSald :=  ' '   

		if len(adadoscmp) >= z 
			If adadoscmp[z,05] == 9 

				adadoscmp[z,18] := 'DENTAL - E'                             

			Else 

				adadoscmp[z,18] := 'DENTAL - M' 

			EndIf
		EndIf                   

		if  nproces == 1     

			If ((adadoscmp[z,05] == 26.95 .and. adadoscmp[z,15]== 23.95 ) .or.     ;
			(adadoscmp[z,05] ==  9.00 .and. adadoscmp[z,15]==  8.50 ))            
				lfaz:=.T.
			else
				u_fAjustaidx()       
				loop                 
			EndIf 
		ElseIf nproces == 2 
			If adadoscmp[z,15] == 0 
				lfaz:=.T.    
			EndIf                       
		Elseif nproces == 3    
			If ((adadoscmp[z,05] == 26.95 .and. adadoscmp[z,15]== 23.95 ) .or.     ;
			(adadoscmp[z,05] ==  9.00 .and. adadoscmp[z,15]==  8.50 ) .or. adadoscmp[z,12] != 0)      

				u_fAjustaidx()         
				loop
			else       
				lfaz:=.T.
			EndIf 
		Elseif nproces == 4                   
			lfaz:=.T.
		EndIf                                 

		If len(adadospri) >= i .and. len(adadoscmp) >= z

			If  trim(adadospri[i,1]) == trim(adadoscmp[z,1])

				aAdd(aDadExcmp,{"Matricula existe na base primavida X  Cobranca (bm1) " , adadospri[i,01], adadospri[i,03] , adadospri[i,04],adadospri[i,06], adadospri[i,07] , adadospri[i,08], adadospri[i,09], adadoscmp[z,01] , adadoscmp[z,05] , adadoscmp[z,10] , adadoscmp[z,12] , adadoscmp[z,13] , adadoscmp[z,15] })                                                                       

				If ((val(adadospri[i,09])== 0 ) .or. (val(adadospri[i,09])== 8.5 .and. adadoscmp[z,05] != 9 ) .or.(VAL(adadospri[i,09])==  23.95  .and. adadoscmp[z,05] != 26.95)) .AND. lfaz

					aAdd(aDadVDCmp,{"Valor Divergente Cobranca (bm1)" , adadospri[i,01], adadospri[i,03] , adadospri[i,04],adadospri[i,06], adadospri[i,07] , adadospri[i,08], adadospri[i,09], adadoscmp[z,01] , adadoscmp[z,05] , adadoscmp[z,10] , adadoscmp[z,12] , adadoscmp[z,13] , adadoscmp[z,15]} )    
					If adadoscmp[z,05] == 9 

						nVlrTitPri :=  8.50        

						nVlrTitcmp :=  9.00   

					Else 

						nVlrTitPri :=  23.95 

						nVlrTitcmp :=  26.95                                        

					EndIf               

					cTitCSald  := 'Tit.com Diverg. de Valor "                

					f_ok := .T.

				EndIf 

				If  adadoscmp[z,12] != 0 .and. f_ok == .T.  .AND. lfaz                                                                 

					If trim(adadoscmp[z,13]) == 'Titular'  

						nVlrTitPri := 8.50 

						nVlrTitcmp := 9.00                                       

						cTitCSald  := cTitCSald + 'Tit.C/saldo "                        

						f_ok:= .T.

					Else                                                        

						nVlrTitPri := 8.50 

						nVlrTitcmp := 9.00 

						cTitCSald  := cTitCSald + 'Tit.C/saldo - dependete _não sera pago  "                                   

						f_ok := .F. 

						aAdd(aDadInVal,{"Dados InValidados   " , adadospri[i,01], adadospri[i,03] , adadospri[i,04],adadospri[i,06], adadospri[i,07] , adadospri[i,08], 0.00 , adadoscmp[z,10] , adadoscmp[z,12], adadoscmp[z,13] ,adadoscmp[z,15]  ,adadoscmp[z,5] ,adadoscmp[z,18] ,cTitCSald  })                   

					EndIf   

					aAdd(aDadCSCmp,{"Tit com saldo (SE1)" , adadospri[i,01], adadospri[i,03] , adadospri[i,04],adadospri[i,06], adadospri[i,07] , adadospri[i,08], adadospri[i,09], adadoscmp[z,01] , adadoscmp[z,05] , adadoscmp[z,10] , adadoscmp[z,12], adadoscmp[z,13] ,adadoscmp[z,15] , nVlrTitPri  } )    

				EndIf 

				If f_ok .and. cTitCSald ==  ' ' .AND. lfaz     

					If adadoscmp[z,05] == 9 

						nVlrTitPri :=  8.50        

						nVlrTitcmp :=  9.00   

					Else 

						nVlrTitPri :=  23.95 

						nVlrTitcmp :=  26.95                                        

					EndIf               

					//                       nVlrTitPri := val(adadospri[i,09])          

					//                       nVlrTitcmp := adadoscmp[z,5]

					cTitCSald  := 'Tit.Ok "                

				EndIf 

				If f_ok .AND. lfaz     

					aAdd(aDadosVal,{"Dados Validados   " , adadospri[i,01], adadospri[i,03] , adadospri[i,04],adadospri[i,06], adadospri[i,07] , adadospri[i,08], nVlrTitPri , adadoscmp[z,10] , adadoscmp[z,12], adadoscmp[z,13] ,adadoscmp[z,15]  ,adadoscmp[z,5] ,adadoscmp[z,18] ,cTitCSald  })                   

					If (nPos := Ascan(aResConv, {|e| e[1]+e[2]+e[3] == adadoscmp[z,18] +  cTitCSald + adadoscmp[z,13] }))== 0     

						aAdd(aResConv,{adadoscmp[z,18], cTitCSald, adadoscmp[z,13], nVlrTitPri , 1 } )
					Else 

						aResConv[nPos,4] := aResConv[nPos,4] + nVlrTitPri   

						aResConv[nPos,5] := aResConv[nPos,5] + 1
					EndIf 

					If nMarcar == 1 .and. f_ok  

						(dbGoTo( adadoscmp[z,14]))  

						RecLock("BM1",.F.)     

						if nReproc == 2
							BM1->BM1_YVLPRI:= nVlrTitPri 
							BM1->BM1_DTCPR := DATE()   
						ElseIf nReproc == 1                       
							BM1->BM1_YVLPR1:=  nVlrTitPri - BM1->BM1_YVLPRI 
							BM1->BM1_DTCPR1 := DATE()   
						EndIf     
						Msunlock("BM1") 

					EndIf 
				EndIf  

				i++       
				z++     

			Else     
				If adadospri[i,1] > adadoscmp[z,1]          

					aAdd(aDadosNExP,{"Matricula nao existe na base da Primavida -> BM1" , adadoscmp[z,01] ,adadoscmp[z,05], adadosCmp[z,10], adadosCmp[z,12], adadosCmp[z,13], adadosCmp[z,15], adadosCmp[z,17], adadosCmp[z,18]})

					If  adadoscmp[z,12] != 0        
						If trim(adadoscmp[z,13]) == 'Titular'  

							nVlrTitPri := 8.50 

							nVlrTitcmp := 9.00                                       

							cTitCSald  := 'Tit.C/saldo - Não Consta  Primavida "                        

							f_ok:= .T. 
						else          

							nVlrTitPri := 8.50 

							nVlrTitcmp := 9.00                                       

							cTitCSald  := 'Tit.C/saldo - Não Consta  Primavida - dependete _não sera pago  "                                                        

							f_ok:= .F. 
							aAdd(aDadInVal,{"Dados InValidados   " , adadospri[i,01], adadospri[i,03] , adadospri[i,04],adadospri[i,06], adadospri[i,07] , adadospri[i,08], nVlrTitPri , adadoscmp[z,10] , adadoscmp[z,12], adadoscmp[z,13] ,adadoscmp[z,15]  ,adadoscmp[z,5] ,adadoscmp[z,18] ,cTitCSald  })                   

						EndIf    

					Else       
						if adadoscmp[z,5] == 9.00

							nVlrTitPri := 8.50

						Else

							nVlrTitPri := 23.95 //- adadoscmp[z,19]  

						EndIf            

						nVlrTitcmp := adadoscmp[z,5]

						cTitCSald  := 'Tit.Ok - Não Consta  Primavida"               

						f_ok:= .T.

					EndIf   

					If f_ok

						fgrvbom()  

					EndIf       

					If len(adadoscmp) > z
						z++            
					EndIf 

				EndIf 

				If len(adadoscmp) >= z .or. len(adadospri) >= i          
					If adadoscmp[z,1]  > adadospri[i,1]    
						aAdd(aDadNExCmp,{"Matricula nao existe na BM1 -> primavida  " , adadospri[i,01],adadospri[i,09],adadospri[i,06],adadospri[i,08],})   
					EndIf 
				EndIf      
				If len(adadospri) >= i  
					I++
				EndIf      
			EndIf

		Else
			if len(adadospri) < i

				If  adadoscmp[z,12] != 0        

					If trim(adadoscmp[z,13]) == 'Titular'  

						nVlrTitPri := 8.50 

						nVlrTitcmp := 9.00                                       

						cTitCSald  := 'Tit.C/saldo - Não Consta  Primavida "                        

						f_ok:= .T.
					Else          

						nVlrTitPri := 8.50 

						nVlrTitcmp := 9.00                                       

						cTitCSald  := 'Tit.C/saldo - Não Consta  Primavida - dependete _não sera pago  "                                                           

						f_ok:= .F.  
						if len(adadospri) > i
							aAdd(aDadInVal,{"Dados InValidados   " , adadospri[i,01], adadospri[i,03] , adadospri[i,04],adadospri[i,06], adadospri[i,07] , adadospri[i,08], nVlrTitPri , adadoscmp[z,10] , adadoscmp[z,12], adadoscmp[z,13] ,adadoscmp[z,15]  ,adadoscmp[z,5] ,adadoscmp[z,18] ,cTitCSald  })                   
						EndIf 
					EndIf    

				Else       
					if adadoscmp[z,5] == 9.00

						nVlrTitPri := 8.50

					Else

						nVlrTitPri :=23.95 

					EndIf            

					nVlrTitcmp := adadoscmp[z,5]

					cTitCSald  := 'Tit.Ok - Não Consta  Primavida"               

					f_ok:= .T.

				EndIf     
				aAdd(aDadosNExP,{"Matricula nao existe na base da Primavida -> BM1" , adadoscmp[z,01] ,adadoscmp[z,05], adadosCmp[z,10], adadosCmp[z,12], adadosCmp[z,13], adadosCmp[z,15], adadosCmp[z,17], adadosCmp[z,18]})

				If f_ok

					fgrvbom()  

				EndIf 


				If len(adadoscmp) >= z

					z++

				EndIf

			ElseIf len(adadoscmp) < z 

				aAdd(aDadNExcmp,{"Matricula nao existe na base da BM1 X primavida " ,adadospri[i,01],adadospri[i,09],adadospri[i,06],adadospri[i,08] }) //, aDadosCmp[z,02] , aDadosCmp[z,05], aDadosCmp[z,10] , aDadosCmp[z,12] })           

				If len(adadospri) >= i  

					I++

				EndIf

			EndIf 
		EndIf 

	EndDo    

Return()     


Static Function AjustaSX1(cPerg)

	Local aHelpPor := {}

	PutSx1(cPerg,"01",OemToAnsi("Arquivo Primavida  ")	    ,"","","mv_ch1","C",060,0,0,"G","U_fGetFile('csv     (*.csv)            | *.csv | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"02",OemToAnsi("Data Iniclussão ate") 		,"","","mv_ch2","D",10,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"03",OemToAnsi("Data bloqueio Maior") 		,"","","mv_ch3","D",10,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
	PutSx1(cPerg,"04",OemToAnsi("Mes/Ano Comissao?  ") 		,"","","mv_ch4","C",07,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","99/9999",aHelpPor,{},{})
	PutSx1(cPerg,"05",OemToAnsi("Considerar         ")     	,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Cadastro","","","","Cobrança","","","Ambos","","","","","","","","",{},{},{})   

	PutSx1(cPerg,"06",OemToAnsi("Matr. Completa     ") 		,"","","mv_ch6","C",17,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,{},{})

	PutSx1(cPerg,"07",OemToAnsi("Processar          ")     	,"","","mv_ch7","N",01,0,0,"C","","","","","mv_par07","Marcados ","","","","Não marcados","","","Reprocessar","","","Todos","","","","","",{},{},{})    
	PutSx1(cPerg,"08",OemToAnsi("Marcar             ")     	,"","","mv_ch8","N",01,0,0,"C","","","","","mv_par08","Sim ","","","","Não ","",""," ","","","","","","","","",{},{},{})   
	PutSx1(cPerg,"09",OemToAnsi("Reprocessar        ")     	,"","","mv_ch9","N",01,0,0,"C","","","","","mv_par09","Sim ","","","","Não ","",""," ","","","","","","","","",{},{},{})   

	Pergunte(cPerg,.T.)

Return 

Static Function fExcel(nConsid)    
	if nReproc == 1
		FGrvPRep() 
		FGrvPlan('adadoscmpR')
	elseif nConsid == 2  
		//aDadosVal - Dados Validados  Primavida X  Cobranca (bm1)    
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - Dados Validados  Primavida X  Cobranca (bm1) " ,aCabeVcmp,aDadosVal}})   
		//aDadosinVal - Dados invalidos Validados  Primavida X  Cobranca (bm1)    
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - Dados InValidados  Primavida X  Cobranca (bm1) " ,aCabeVcmp,aDadinVal}})   
		//aResConv - resumo cocnferencia   
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - Resumo " ,aCabeConv,aResConv}})                            
		//adadospri - dados primavida
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - tabela de dados premavida " ,aCabePri,aDadosPri}})  

		FGrvPlan('adadospri')      

		//adadoscmp - dados compossiçãpo                                                                            
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - tabela de dados COBRANCA " ,aCabecmp,adadoscmp}})  

		FGrvPlan('adadoscmp') 

		//aDadExcmp - Matricula existe na base primavida X  Cobranca (bm1) 
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - Matricula existe na base primavida X  Cobranca (bm1) " ,aCabeExcmp,aDadExcmp}})
		//aDadVDCmp - Valor Divergente Cobranca (bm1)                                                           
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - Valor Divergente Cobranca (bm1) " ,aCabeVDCmp,aDadVDCmp}})  

		FGrvPlan('adadvdcmp')      

		//aDadCSCmp - Tit com saldo (SE1)                                                                                                
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - Tit com saldo (SE1) " ,aCabeCSCmp,aDadCSCmp}})       
		//aDadosNExP - Matricula nao existe na base da Primavida -> cadastro
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - tabela Nao Existe na primavida " ,aCabmXEP,aDadosNExP}})        

		FGrvPlan('adadosnexp') 

		//aDadNExCmp- Matricula nao existe na BM1 -> primavida  
		DlgToExcel({{"ARRAY","Relação Conferencia Primavida - tabela Nao Existe na caberj " ,aCabemat,aDadNExCmp }})       

		FGrvPlan('aDadnexcmp') 

		MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq1)
	EndIf                                                      
RETURN()    

User Function fAjustaidx()          

	If  trim(adadospri[i,1]) == trim(adadoscmp[z,1])
		i++
		z++
	ElseIf  trim(adadospri[i,1]) > trim(adadoscmp[z,1])  
		If len(adadoscmp) >= z   
			z++
		EndIf   
	Else
		If len(adadospri) >= i   
			i++
		EndIf    
	EndIf        
RETURN()    

Static Function fgrvbom()   

	If f_ok .AND. lfaz     


		aAdd(aDadosVal,{"Dados Validados - sem primavida  " , aDadosCmp[z,01], aDadosCmp[z,16] , 'CPF' ,adadoscmp[z,13],(adadoscmp[z,2]+'/'+ adadoscmp[z,3]+'99') , adadoscmp[z,17], nVlrTitPri , adadoscmp[z,10] , adadoscmp[z,12], adadoscmp[z,13] ,adadoscmp[z,15] ,adadoscmp[z,5] ,adadoscmp[z,18] ,cTitCSald  })                   
		If (nPos := Ascan(aResConv, {|e| e[1]+e[2]+e[3] == adadoscmp[z,18]+ cTitCSald + adadoscmp[z,13]  }))== 0     

			aAdd(aResConv,{adadoscmp[z,18], cTitCSald, adadoscmp[z,13] , nVlrTitPri  , 1 } )      

		Else 

			aResConv[nPos,4] := aResConv[nPos,4] +  nVlrTitPri 

			aResConv[nPos,5] := aResConv[nPos,5] + 1

		EndIf
		If nMarcar == 1 .and. f_ok  

			(dbGoTo( adadoscmp[z,14]))  

			RecLock("BM1",.F.)     

			If nReproc == 2
				BM1->BM1_YVLPRI:= nVlrTitPri 
				BM1->BM1_DTCPR := DATE()  
			ElseIf nReproc == 1                       
				BM1->BM1_YVLPR1 := nVlrTitPri -  BM1->BM1_YVLPRI 
				BM1->BM1_DTCPR1 := DATE()     
			EndIf     

			Msunlock("BM1")

		EndIf                  
	EndIf  

RETURN()   

Static Function FGrvPlan(cPlan)     

	if cplan == 'adadvdcmp'      

		cNomDadCab:=  '5 - VALOR DIVERGENTE ENTRE CABERJ E PRIMAVIDA'
		cComp     :=  cCompMes+'/'+cCompAno
		cNomPla   := 'BASE DE DADOS CABERJ'                   

		cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
		nHandle := FCREATE(cNomeArq)
		cMontaTxt := cNomDadCab
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)        		 
		cMontaTxt := 'Competencia : '+cComp
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)		 
		cMontaTxt := 'Planilha : '+cNomPla  
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)		

		cMontaTxt := "Matric.Compl ;"
		cMontaTxt += "Nome         ;" 
		cMontaTxt += "Cpf          ;"    
		cMontaTxt += "Categoria Primavida ;" 
		cMontaTxt += "Dt. Adesão   ;" 
		cMontaTxt += "Plano        ;" 
		cMontaTxt += "Vlr Primavida;"  
		cMontaTxt += "Vlr Caberj   ;"  
		cMontaTxt += "Dt. Baixa    ;"    
		cMontaTxt += "Saldo Titulo ;"  
		cMontaTxt += "Categoria Primavida ;" 

		cMontaTxt += CRLF // Salto de linha para .csv (excel)

		FWrite(nHandle,cMontaTxt)

		For nCount:=1 to len(aDadVDCmp)

			cMontaTxt := trim(aDadVDCmp[nCount][2]) + ";"  
			cMontaTxt += trim(aDadVDCmp[nCount][3]) + ";"  
			cMontaTxt += trim(aDadVDCmp[nCount][4]) + ";"  
			cMontaTxt += trim(aDadVDCmp[nCount][5]) + ";"    
			cMontaTxt += substr(aDadVDCmp[nCount][6],7,2)+'/'+substr(aDadVDCmp[nCount][6],5,2)+'/'+ substr(aDadVDCmp[nCount][6],1,4) + ";"
			cMontaTxt += trim(aDadVDCmp[nCount][7]) + ";"    
			cMontaTxt += Replace(aDadVDCmp[nCount][08],'.',',') + ";"    
			cMontaTxt += Transform(aDadVDCmp[nCount][10],'@E  999,999,999.99')+ ";" 
			cMontaTxt += substr(aDadVDCmp[nCount][11],7,2)+'/'+substr(aDadVDCmp[nCount][11],5,2)+'/'+ substr(aDadVDCmp[nCount][11],1,4) + ";"  
			cMontaTxt += Transform(aDadVDCmp[nCount][12],'@E  999,999,999.99')+ ";"    
			cMontaTxt += trim(aDadVDCmp[nCount][13]) + ";"  

			cMontaTxt += CRLF // Salto de linha para .csv (excel)      

			FWrite(nHandle,cMontaTxt)

		Next 

		If nHandle > 0

			// encerra gravação no arquivo
			FClose(nHandle)
			cNomeArq1+= cNomeArq + CRLF
			//	MsgAlert("Relatorio salvo em: "+cNomeArq)

		EndIf              
	elseif cplan == 'aDadnexcmp'    

		cNomDadCab:=  '4 - DADOS PRIMAVIDA NÃO EXISTENTES NA CABERJ '
		cComp     :=  cCompMes+'/'+cCompAno
		cNomPla   := 'BASE DE DADOS CABERJ'                   

		cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
		cMontaTxt := cNomDadCab
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)       		 
		cMontaTxt := 'Competencia : '+cComp
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)		 
		cMontaTxt := 'Planilha : '+cNomPla  
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)	 

		cMontaTxt := "Matric.Compl ;"
		cMontaTxt += "Vlr. Cobrado ;"   
		cMontaTxt += "Categoria    ;"  
		cMontaTxt += "Plano        ;"  

		cMontaTxt += CRLF // Salto de linha para .csv (excel)

		FWrite(nHandle,cMontaTxt)

		For nCount:=1 to len(aDadNExCmp)

			cMontaTxt := trim(aDadNExCmp[nCount][1]) + ";"  
			cMontaTxt += Transform(aDadNExCmp[nCount][2],'@E  999,999,999.99')+ ";"   
			cMontaTxt += trim(aDadNExCmp[nCount][3]) + ";"
			cMontaTxt += trim(aDadNExCmp[nCount][4]) + ";"

			cMontaTxt += CRLF // Salto de linha para .csv (excel)      

			FWrite(nHandle,cMontaTxt)

		Next 

		If nHandle > 0

			// encerra gravação no arquivo
			FClose(nHandle)
			cNomeArq1+= cNomeArq + CRLF
			//	MsgAlert("Relatorio salvo em: "+cNomeArq)

		EndIf           

	elseif cplan == 'adadosnexp'      

		cNomDadCab:=  '3 - DADOS CABERJ NÃO EXISTENTES NA PRIMAVIDA'
		cComp     :=  cCompMes+'/'+cCompAno
		cNomPla   := 'BASE DE DADOS CABERJ'                   

		cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
		cMontaTxt := cNomDadCab
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)       		 
		cMontaTxt := 'Competencia : '+cComp
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)		 
		cMontaTxt := 'Planilha : '+cNomPla  
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)		

		cMontaTxt := "Matric.Compl ;"
		cMontaTxt += "Vlr. Cobrado ;"   
		cMontaTxt += "Dt. Baixa    ;" 
		cMontaTxt += "Saldo Titulo ;"   
		cMontaTxt += "Categoria    ;"  
		cMontaTxt += "Plano        ;"  

		cMontaTxt += CRLF // Salto de linha para .csv (excel)

		FWrite(nHandle,cMontaTxt)

		For nCount:=1 to len(aDadosNExP)

			cMontaTxt := trim(aDadosNExP[nCount][2]) + ";"  
			cMontaTxt += Transform(aDadosNExP[nCount][3],'@E  999,999,999.99')+ ";"   
			cMontaTxt += substr(aDadosNExP[nCount][4],7,2)+'/'+substr(aDadosNExP[nCount][4],5,2)+'/'+ substr(aDadosNExP[nCount][4],1,4) + ";"
			cMontaTxt += Transform(aDadosNExP[nCount][5],'@E  999,999,999.99')+ ";"   
			cMontaTxt += trim(aDadosNExP[nCount][6]) + ";"
			cMontaTxt += trim(aDadosNExP[nCount][8]) + ' - ' + trim(aDadosNExP[nCount][9]) + ";"

			cMontaTxt += CRLF // Salto de linha para .csv (excel)      

			FWrite(nHandle,cMontaTxt)

		Next 

		If nHandle > 0

			// encerra gravação no arquivo
			FClose(nHandle)
			cNomeArq1+= cNomeArq + CRLF
			//	MsgAlert("Relatorio salvo em: "+cNomeArq)

		EndIf           
	ElseIf (cplan == 'adadoscmp' .or. cplan == 'adadoscmpR' )     

		cComp     :=  cCompMes+'/'+cCompAno
		If cplan == 'adadoscmpR'                              
			cNomPla   := 'BASE DE DADOS CABERJ - Reprocessamento'                   
			cNomDadCab:=  '1 - DADOS CABERJ - Reprocessamento'
		Else   
			cNomPla   := 'BASE DE DADOS CABERJ'                   
			cNomDadCab:=  '1 - DADOS CABERJ'
		EndIf 
		cNomeArq := "C:\TEMP\primavida\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"


		nHandle := FCREATE(cNomeArq)

		cMontaTxt := cNomDadCab
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)

		cMontaTxt := 'Competencia : '+cComp
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)		 

		cMontaTxt := 'Planilha : '+cNomPla  
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)		

		cMontaTxt := "Matric.Compl ;"
		cMontaTxt += "Ano Comp.    ;"
		cMontaTxt += "Mes Comp.    ;"
		cMontaTxt += "Parcela      ;"
		cMontaTxt += "Vlr Cobrado ;"
		cMontaTxt += "Prefixo Tit  ;"
		cMontaTxt += "Numero  Tit  ;"
		cMontaTxt += "Tipo    Tit  ;"
		cMontaTxt += "Venc.   Real ;"
		cMontaTxt += "Dt. Baixa    ;"  
		cMontaTxt += "Vlr total tit;"
		cMontaTxt += "Saldo Titulo ;"  
		cMontaTxt += "Categoria    ;"
		cMontaTxt += "Plano        ;"  

		if nReproc == 1                           
			cMontaTxt += "Vlr Rep     ;"  
			cMontaTxt += "Dt  Rep     ;" 
		EndIf   

		cMontaTxt += CRLF // Salto de linha para .csv (excel)

		FWrite(nHandle,cMontaTxt)

		For nCount:=1 to len(adadoscmp)

			cMontaTxt := trim(aDadosCmp[nCount][1]) + ";"
			cMontaTxt += trim(aDadosCmp[nCount][2]) + ";"
			cMontaTxt += trim(aDadosCmp[nCount][3]) + ";"
			cMontaTxt += trim(aDadosCmp[nCount][4]) + ";"
			cMontaTxt += Transform(aDadosCmp[nCount][5],'@E  999,999,999.99')+ ";"
			cMontaTxt += trim(aDadosCmp[nCount][6]) + ";"
			cMontaTxt += trim(aDadosCmp[nCount][7]) + ";"
			cMontaTxt += trim(aDadosCmp[nCount][8]) + ";"
			cMontaTxt += substr(aDadosCmp[nCount][9],7,2)+'/'+substr(aDadosCmp[nCount][9],5,2)+'/'+ substr(aDadosCmp[nCount][9],1,4) + ";"
			cMontaTxt += substr(aDadosCmp[nCount][10],7,2)+'/'+substr(aDadosCmp[nCount][10],5,2)+'/'+ substr(aDadosCmp[nCount][10],1,4) + ";"
			cMontaTxt += Transform(aDadosCmp[nCount][11],'@E  999,999,999.99')+ ";" 
			cMontaTxt += Transform(aDadosCmp[nCount][12],'@E  999,999,999.99')+ ";"  
			cMontaTxt += trim(aDadosCmp[nCount][13]) + ";"
			cMontaTxt += trim(aDadosCmp[nCount][17]) + ' - ' + trim(aDadosCmp[nCount][18]) + ";"    

			If nReproc == 1                                                         
				cMontaTxt += Transform(aDadosCmp[nCount][19],'@E  999,999,999.99')+ ";"                                                          
				cMontaTxt += substr(aDadosCmp[nCount][20],7,2)+'/'+substr(aDadosCmp[nCount][20],5,2)+'/'+ substr(aDadosCmp[nCount][20],1,4) + ";"
			EndIf   

			cMontaTxt += CRLF // Salto de linha para .csv (excel)      

			FWrite(nHandle,cMontaTxt)

		Next 

		If nHandle > 0

			// encerra gravação no arquivo
			FClose(nHandle)
			cNomeArq1+= cNomeArq + CRLF
			//	MsgAlert("Relatorio salvo em: "+cNomeArq)

		EndIf

	elseif cplan == 'adadospri'        

		cNomDadCab:=  '2 - DADOS PRIMAVIDA'
		cComp     :=  cCompMes+'/'+cCompAno
		cNomPla   := 'BASE DE DADOS PRIMAVIDA'                   

		cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)

		cMontaTxt := cNomDadCab
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)

		cMontaTxt := 'Competencia : '+cComp
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)		 

		cMontaTxt := 'Planilha : '+cNomPla  
		cMontaTxt += CRLF
		FWrite(nHandle,cMontaTxt)		

		cMontaTxt := "Matric.Compl   ;"    
		//	cMontaTxt += "Func. Primavida;"    
		cMontaTxt += "Nome           ;"    
		cMontaTxt += "Cpf            ;"    
		cMontaTxt += "Categoria      ;"    
		cMontaTxt += "Dt Adesão      ;"    
		cMontaTxt += "Plano          ;"    
		cMontaTxt += "Valor          ;"     		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)

		FWrite(nHandle,cMontaTxt)

		For nCount:=1 to len(aDadosPri)

			cMontaTxt := trim(aDadosPri[nCount][1]) + ";"
			// cMontaTxt += trim(aDadosPri[nCount][2]) + ";"
			cMontaTxt += trim(aDadosPri[nCount][3]) + ";"
			cMontaTxt += trim(aDadosPri[nCount][4]) + ";"
			cMontaTxt += trim(aDadosPri[nCount][6]) + ";"
			cMontaTxt += trim(aDadosPri[nCount][7]) + ";"
			cMontaTxt += trim(aDadosPri[nCount][8]) + ";"
			//		  cMontaTxt += Transform(Replace(aDadosPri[nCount][09],'.',','),'@E  999,999,999.99')+ ";"     
			cMontaTxt += Replace(aDadosPri[nCount][09],'.',',') + ";"      


			cMontaTxt += CRLF // Salto de linha para .csv (excel)      

			FWrite(nHandle,cMontaTxt)

		Next 

		If nHandle > 0

			// encerra gravação no arquivo
			FClose(nHandle)
			cNomeArq1+= cNomeArq + CRLF
			//	MsgAlert("Relatorio salvo em: "+cNomeArq)

		EndIf

	EndIf  

Return (.T.)
/*
Static Function FGrvPlanR()     


cNomDadCab:=  ' 7 - RESUMO "MÊS ANO DO CÁLCULO'
cComp     :=  cCompMes+'/'+cCompAno
cNomPla   := 'BASE DE DADOS CABERJ'                   

cNomeArq := "C:\TEMP\"+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
nHandle := FCREATE(cNomeArq)
cMontaTxt := cNomDadCab
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)        		 
cMontaTxt := 'Competencia : '+cComp
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)		 
cMontaTxt := 'Planilha : '+cNomPla  
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)		  
cMontaTxt := 'Data : '+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)
cMontaTxt += CRLF
FWrite(nHandle,cMontaTxt)		          

cMontaTxt := 'BASE CABERJ '  
cMontaTxt += CRLF           
FWrite(nHandle,cMontaTxt)		  

cMontaTxt := "CATEGORIA CABERJ;"    
cMontaTxt += "PLANO           ;"    
cMontaTxt += "QTDE VIDAS      ;"    
cMontaTxt += "VALOR           ;"    
cMontaTxt += "VALOR FATURADO  ;"    
cMontaTxt += "VALOR Total     ;"    

cMontaTxt += CRLF // Salto de linha para .csv (excel)

FWrite(nHandle,cMontaTxt)


*/      
Static Function FFazRep() 

	local nVlrPri:= 0.00


	cQuery := " SELECT Bm1.bm1_codint ||'.'|| Bm1.bm1_codemp ||'.'|| Bm1.bm1_matric ||'-'|| Bm1.bm1_tipreg ||'.'|| Bm1.bm1_digito  matrbm1 , "
	cQuery += CRLF +"  Ba1.ba1_codint ||'.'|| Ba1.ba1_codemp ||'.'|| Ba1.ba1_matric ||'-'|| Ba1.ba1_tipreg ||'.'|| Ba1.ba1_digito  matrba1 , "   
	cQuery += CRLF +"  Ba10.ba1_codint ||'.'|| Ba10.ba1_codemp ||'.'|| Ba10.ba1_matric ||'-'|| Ba10.ba1_tipreg ||'.'|| Ba10.ba1_digito  matrba10 , "  

	cQuery += CRLF +" bm1.bm1_nomusr nome,   BM1_ANO , BM1_MES , BM1_NUMPAR , BM1_VALOR ,"
	cQuery += CRLF +"  E1_PREFIXO , E1_NUM , E1_TIPO , E1_VENCREA , E1_BAIXA , E1_VALOR , E1_SALDO  , bm1_deseve  ,  decode(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') TIPUSU , BM1.R_e_c_n_o_ BM1REC , bm1_Yvlpri vlpri  , "
	cQuery += CRLF +"  nvl(BI3_CODIGO,' ' ) codpla , DECODE ( nvl(BI3_CODIGO,' ' ), '0098', 'DENTAL - E' , '0099', 'DENTAL - M' ,' ' ) despla  , " 

	cQuery += CRLF +"  BM1_YVLPRI VLRCALC , BM1_DTCPR DTCALC , BM1_YVLPR1 VLRRCALC , BM1_DTCPR1 DTRCALC "            

	cQuery += CRLF +"  FROM " + RetSqlName("BM1") + " BM1 , " + RetSqlName("SE1") + " SE1  , " + RetSqlName("BA1") + " BA1 " 
	cQuery += CRLF +" , " + RetSqlName("BA1") + " BA10 , " + RetSqlName("BI3") + " BI3  " 
	cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "
	cQuery += CRLF +"    AND E1_FILIAL  = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  " 
	cQuery += CRLF +"    AND BA1.BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  " 
	cQuery += CRLF +"    AND BA10.BA1_FILIAL = '" + xFilial("BA1") +"' AND BA10.D_E_L_E_T_ = ' '  "
	cQuery += CRLF +"    AND BI3_FILIAL(+)= '" + xFilial("BI3") +"' and bI3.D_E_L_E_T_(+)  =  ' ' "
	cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes +"' "
	cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"                    
	If !EMPTY(cMatric)
		cQuery += CRLF +"    AND BM1_CODINT || BM1_CODEMP||bm1_matric||BM1_TIPREG ||PBM1_DIGITO  = '"+cMatric+"' "
	EndIf                                                        

	cQuery += CRLF +"    AND E1_SALDO    =  0  AND  BM1_YVLPR1 = 0 "
	cQuery += CRLF +"    AND ((BM1_valor =  9  AND  BM1_YVLPRI = 0) " 
	cQuery += CRLF +"     OR  (BM1_valor =  26.95  AND  BM1_YVLPRI = 8.5)  " 
	cQuery += CRLF +"     OR  (BM1_valor =  26.95  AND  BM1_YVLPRI = 0)) "
	cQuery += CRLF +"    AND BM1_CODEMP in ( '0024' , '0025','0027','0028') " 
	cQuery += CRLF +"    AND BM1_CODTIP = '102' AND BM1_CODEVE IN ('0103','0105')"
	cQuery += CRLF +"    AND E1_PREFIXO =  BM1_PREFIX     "
	cQuery += CRLF +"    AND E1_NUM     =  BM1_NUMTIT     "
	cQuery += CRLF +"    AND E1_TIPO    =  BM1_TIPTIT     "                                      
	cQuery += CRLF +"    AND  BM1_CODINT = ba1.BA1_CODINT "
	cQuery += CRLF +"    AND  BM1_CODEMP = ba1.BA1_CODEMP "
	cQuery += CRLF +"    AND  BM1_MATRIC = ba1.BA1_MATRIC "
	cQuery += CRLF +"    AND  BM1_TIPREG = ba1.BA1_TIPREG "
	cQuery += CRLF +"    AND  BM1_DIGITO = ba1.BA1_DIGITO "      

	cQuery += CRLF +" and ba10.BA1_CODINT(+) = substr(BA1.BA1_YMTODO,1,4)   "
	cQuery += CRLF +" and ba10.BA1_CODEMP(+) = substr(BA1.BA1_YMTODO,5,4)   "
	cQuery += CRLF +" and ba10.BA1_MATRIC(+) = substr(BA1.BA1_YMTODO,9,6)   "
	cQuery += CRLF +" and ba10.BA1_TIPREG(+) = substr(BA1.BA1_YMTODO,15,2)  "
	cQuery += CRLF +" and ba10.BA1_DIGITO(+) = substr(BA1.BA1_YMTODO,17,1)  "

	cQuery += CRLF +"  and BI3_VERSAO(+) = nvl(BA10.BA1_VERSAO,' ') "
	cQuery += CRLF +"  and BI3_CODIGO(+) = nvl(BA10.BA1_CODPLA,' ') " 
	cQuery += CRLF +"  ORDER BY BM1_CODINT , BM1_CODEMP , BM1_MATRIC , BM1_TIPREG , BM1_DIGITO "    

	If Select(("TMP")) <> 0 
		("TMP")->(DbCloseArea()) 
	Endif

	TCQuery cQuery Alias "TMP" New 

	dbSelectArea("BM1")   


	tmp->(dbGoTop())                    
	While !(TMP->(Eof()))                                                                                                                                                                                                   

		If tmp->BM1_VALOR == 26.95
			nVlrPri:= 23.95 
		Else          
			nVlrPri:= 8.50
		EndIf 

		dbGoTo( tmp->BM1REC )  

		RecLock("BM1",.F.)     

		BM1->BM1_YVLPR1 :=  nVlrPri -  BM1->BM1_YVLPRI 
		BM1->BM1_DTCPR1 := DATE()     

		Msunlock("BM1")


		tmp->(DbSkip())

	EndDo 


return ()                        
Static Function FGrvPRep() 

	aDadosCmp := {}   

	cQuery := " SELECT Bm1.bm1_codint ||'.'|| Bm1.bm1_codemp ||'.'|| Bm1.bm1_matric ||'-'|| Bm1.bm1_tipreg ||'.'|| Bm1.bm1_digito  matrbm1 ,bm1.bm1_nomusr nome,   BM1_ANO , BM1_MES , BM1_NUMPAR , BM1_VALOR ,"
	cQuery += CRLF +"Ba1.ba1_codint ||'.'|| Ba1.ba1_codemp ||'.'|| Ba1.ba1_matric ||'-'|| Ba1.ba1_tipreg ||'.'|| Ba1.ba1_digito  matrba1 , "
	cQuery += CRLF +"Ba10.ba1_codint ||'.'|| Ba10.ba1_codemp ||'.'|| Ba10.ba1_matric ||'-'|| Ba10.ba1_tipreg ||'.'|| Ba10.ba1_digito  matrba1 ,"

	cQuery += CRLF +"  E1_PREFIXO , E1_NUM , E1_TIPO , E1_VENCREA , E1_BAIXA , E1_VALOR , E1_SALDO  , bm1_deseve  ,  decode(ba1.BA1_TIPUSU,'T', 'Titular','Dependente') TIPUSU , BM1.R_e_c_n_o_ BM1REC , bm1_Yvlpri vlpri  , "
	cQuery += CRLF +"  nvl(BI3_CODIGO,' ' ) codpla , DECODE ( nvl(BI3_CODIGO,' ' ), '0098', 'DENTAL - E' , '0099', 'DENTAL - M' ,' ' ) despla  , " 

	cQuery += CRLF +"  BM1_YVLPRI VLRCALC , BM1_DTCPR DTCALC , BM1_YVLPR1 VLRRCALC , BM1_DTCPR1 DTRCALC "            

	cQuery += CRLF +"  FROM " + RetSqlName("BM1") + " BM1 , " + RetSqlName("SE1") + " SE1  , " + RetSqlName("BA1") + " BA1 " 
	cQuery += CRLF +" , " + RetSqlName("BA1") + " BA10 , " + RetSqlName("BI3") + " BI3  " 
	cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "
	cQuery += CRLF +"    AND E1_FILIAL  = '" + xFilial("SE1") +"' AND SE1.D_E_L_E_T_ = ' '  " 
	cQuery += CRLF +"    AND BA1.BA1_FILIAL = '" + xFilial("BA1") +"' AND BA1.D_E_L_E_T_ = ' '  " 
	cQuery += CRLF +"    AND BA10.BA1_FILIAL = '" + xFilial("BA1") +"' AND BA10.D_E_L_E_T_ = ' '  "
	cQuery += CRLF +"    AND BI3_FILIAL(+)= '" + xFilial("BI3") +"' and bI3.D_E_L_E_T_(+)  =  ' ' "
	cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes +"' "
	cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"                    
	If !EMPTY(cMatric)
		cQuery += CRLF +"    AND BM1_CODINT || BM1_CODEMP||bm1_matric||BM1_TIPREG ||PBM1_DIGITO  = '"+cMatric+"' "
	EndIf                                                        
	cQuery += CRLF +"    AND (E1_SALDO   <>   0   or BM1_YVLPR1 > 0 ) "
	cQuery += CRLF +"    AND BM1_CODEMP in ( '0024' , '0025','0027','0028') " 
	cQuery += CRLF +"    AND BM1_CODTIP = '102' and BM1_CODEVE IN  ('0103','0105')"
	cQuery += CRLF +"    AND E1_PREFIXO =  BM1_PREFIX     "
	cQuery += CRLF +"    AND E1_NUM     =  BM1_NUMTIT     "
	cQuery += CRLF +"    AND E1_TIPO    =  BM1_TIPTIT     "                                      
	cQuery += CRLF +"    AND  BM1_CODINT = ba1.BA1_CODINT "
	cQuery += CRLF +"    AND  BM1_CODEMP = ba1.BA1_CODEMP "
	cQuery += CRLF +"    AND  BM1_MATRIC = ba1.BA1_MATRIC "
	cQuery += CRLF +"    AND  BM1_TIPREG = ba1.BA1_TIPREG "
	cQuery += CRLF +"    AND  BM1_DIGITO = ba1.BA1_DIGITO "   

	cQuery += CRLF +" and ba10.BA1_CODINT(+) = substr(BA1.BA1_YMTODO,1,4)   "
	cQuery += CRLF +" and ba10.BA1_CODEMP(+) = substr(BA1.BA1_YMTODO,5,4)   "
	cQuery += CRLF +" and ba10.BA1_MATRIC(+) = substr(BA1.BA1_YMTODO,9,6)   "
	cQuery += CRLF +" and ba10.BA1_TIPREG(+) = substr(BA1.BA1_YMTODO,15,2)  "
	cQuery += CRLF +" and ba10.BA1_DIGITO(+) = substr(BA1.BA1_YMTODO,17,1)  "

	cQuery += CRLF +"  and BI3_VERSAO(+) = nvl(BA10.BA1_VERSAO,' ') "
	cQuery += CRLF +"  and BI3_CODIGO(+) = nvl(BA10.BA1_CODPLA,' ') " 
	cQuery += CRLF +"  ORDER BY BM1_CODINT , BM1_CODEMP , BM1_MATRIC , BM1_TIPREG , BM1_DIGITO "    

	If Select(("TMP")) <> 0 
		("TMP")->(DbCloseArea()) 
	Endif

	TCQuery cQuery Alias "TMP" New 

	dbSelectArea("TMP")

	tmp->(dbGoTop())                    
	While !(TMP->(Eof()))                                                                                                                                                                                                   

		aAdd(aDadosCmp, {tmp->matrbm1 , tmp->BM1_ANO , tmp->BM1_MES , tmp->BM1_NUMPAR , tmp->BM1_VALOR ,tmp->E1_PREFIXO , tmp->E1_NUM , tmp->E1_TIPO , tmp->E1_VENCREA , tmp->E1_BAIXA , tmp->E1_VALOR , tmp->E1_SALDO, TMP->TIPUSU , TMP->BM1REC , tmp->vlpri , tmp->nome ,tmp->codpla,tmp->despla , tmp->VLRRCALC, tmp->DTRCALC}) 
		//                              1            2                3               4              5                    6              7         8                9               10             11               12              13              14           15              16          17         18          19           20          
		tmp->(DbSkip())

	EndDo          

	// FGrvPlan('adadoscmpR')                    

Return () 
