
#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
#include "TBICONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ'ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSRETCP  บAutor  ณMicrosiga           บ Data ณ  06/03/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณModifica co-participacao padrao calculada pelo sistema.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                     

User Function GERAAR() 

Local c_Int    := '0001'
Local c_CodEmp := '0005'
Local c_Matric := '014930'
Local c_TipReg := '00'
Local c_NumTit := '001076028'       
Private c_Memo 	:= ""  
Private n_Total := 0
Private c_EOL   := CHR(13)+CHR(10)
Private c_EOL   := &("CHR(13)+CHR(10)")

Prepare Environment Empresa "01" Filial "01"

c_Qry :=" SELECT BM1_CODINT,  BM1_CODEMP , BM1_MATRIC , BM1_TIPREG, BM1_PREFIX, BM1_NUMTIT "
c_Qry +=" FROM BM1010 "
c_Qry +=" WHERE bm1_filial = ' ' "
c_Qry +=" AND bm1_PLNUCO = '000100012455' " // SISDEB
// c_Qry +=" AND bm1_matric = '040110' " // SISDEB
// c_Qry +=" AND bm1_prefix = 'PLS' " // SISDEB
// c_Qry +=" AND bm1_numtit = '001072728' " // SISDEB
// c_Qry +=" AND bm1_PLNUCO = '000100011641' " // SISDEB
// c_Qry +=" AND BM1_CODINT = '0001' AND BM1_CODEMP = '0005' AND BM1_MATRIC = '014930' "
c_Qry +=" AND D_E_L_E_T_ <> '*'      "
c_Qry +=" GROUP BY BM1_CODINT,  BM1_CODEMP , BM1_MATRIC , BM1_TIPREG, BM1_PREFIX, BM1_NUMTIT "                                         
c_Qry +=" ORDER BY BM1_CODINT,  BM1_CODEMP , BM1_MATRIC , BM1_TIPREG, BM1_PREFIX, BM1_NUMTIT "                                         

TCQUERY c_Qry ALIAS "QRYBM1" NEW     

NcoNT:= 0

While !QRYBM1->( EOF() )
    NCONT++

    MemoWrit("C:\coNT.TXT",STr(NCONT) + QRYBM1->BM1_CODINT+  QRYBM1->BM1_CODEMP + QRYBM1->BM1_MATRIC + QRYBM1->BM1_TIPREG+ QRYBM1->BM1_PREFIX+ QRYBM1->BM1_NUMTIT )

	c_Qry :=" SELECT  BD6_CODOPE, "
	c_Qry +="        R_E_C_N_O_ AS NUMREC,  "
	c_Qry +="        BD6_CODEMP,  "
	c_Qry +="        BD6_MATRIC,  "
	c_Qry +="        BD6_TIPREG,  "
	c_Qry +="        BD6_CODPLA,  "
	c_Qry +="        BD6_CODOPE,  "
	c_Qry +="        BD6_DATPRO,  "
	c_Qry +="        BD6_QTDPRO,  "
	c_Qry +="        BD6_CODPAD,  "
	c_Qry +="        BD6_CODPRO,  "
	c_Qry +="        BD6_CODLDP,  "
	c_Qry +="        BD6_CODRDA,  "
	c_Qry +="        BD6_TIPATE,  "
	c_Qry +="        BD6_CODPEG,  "
	c_Qry +="		 BD6_NUMERO,  "
	c_Qry +="		 BD6_ANOPAG,  "
	c_Qry +="		 BD6_MESPAG,  "
	c_Qry +="		 BD6_HORPRO,  "
	c_Qry +="		 BD6_PERCOP,   "
	c_Qry +="		 BD6_NUMIMP,   "
	c_Qry +="		 bd6_NUMTIT,   "
	c_Qry +="		 bd6_PREFIX,   "
	c_Qry +="		 BD6_VLRTPF,   "
	c_Qry +="		 BD6_CDPFSO   "
	c_Qry +=" FROM bd6010 b "
	c_Qry +=" WHERE bd6_filial = ' ' "
	c_Qry +=" AND  BD6_CODOPE = '" + QRYBM1->BM1_CODINT + "' "
	c_Qry +=" AND  Bd6_CODEMP = '" + QRYBM1->BM1_CODEMP + "' "
	c_Qry +=" AND  bd6_matric = '" + QRYBM1->BM1_MATRIC + "' "
	c_Qry +=" AND  Bd6_TIPREG = '" + QRYBM1->BM1_TIPREG + "' "
	c_Qry +=" AND  bd6_PREFIX = '" + QRYBM1->BM1_PREFIX + "' "
	c_Qry +=" AND  bd6_NUMTIT = '" + QRYBM1->BM1_NUMTIT + "' "
	
	TCQUERY c_Qry ALIAS "QRYBD6" NEW
	
	While !QRYBD6->( EOF() ) 
	
		u_ACERCOP()    
		
		QRYBD6->( dbSkip() )
	     
	EndDo          
	
	QRYBD6->( dbCloseArea() )

	QRYBM1->( dbSkip() )
	
EndDo

c_Memo += c_EOL
c_Memo += c_EOL
c_Memo += str( n_Total ) 

ALERT("fIM")

RESET ENVIRONMENT

Return

User Function ACERCOP()

Local nX := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//dados que serao retornados ao PLS
LOCAL nPerCop  := QRYBD6->BD6_PERCOP // paramixb[1]  //Percentual (ou e percentual ou e o valor (abaixo), nunca os dois)
LOCAL nValCop  := QRYBD6->BD6_VLRTPF // paramixb[2]  //Percentual (ou e valor ou e o percentual (acima), nunca os dois)
LOCAL nTaxa    := 0 //paramixb[3]  //Taxa administrativa
LOCAL nValUs   := 0 //paramixb[4]  //Valor da U.S especifica (se for o caso)
LOCAL cAlias   := " " //paramixb[5]  //Alias de onde vou encontrado o nivel
LOCAL lExistia := .t. // paramixb[6]  //Tera Co-Participacao ? .T. ou .F.
LOCAL cPgNoAto := "0" // paramixb[7]  //Devera ser pago no ato da emissao da guia (0 ou 1)
LOCAL cPgDrRDA := "0" //paramixb[8]  //Devera ser pago diretamente a RDA (0 ou 1)
LOCAL nLimFra  := 1 //paramixb[9]  //Limite de Franquia

//dados para ajudar o analista a implementar suas regras especificas
LOCAL cCodInt	:= QRYBD6->BD6_CODOPE //Codigo de sua operadora padrao
LOCAL cCodEmp	:= QRYBD6->BD6_CODEMP //Empresa do usuario
LOCAL cMatric	:= QRYBD6->BD6_MATRIC //Matricula do usuario
LOCAL cTipReg	:= QRYBD6->BD6_TIPREG //Tipo de registro (00,01,02, etc)
LOCAL cCodPla	:= QRYBD6->BD6_CODPLA //Codigo do plano
LOCAL cVerPla	:= '001' // QRYBD6->BD6_VERPLA //Versao do plano
LOCAL cOpeOri	:= QRYBD6->BD6_CODOPE //Operadora origem do usuario (dif de cCodInt quando for atendimento de intercambio eventual)
LOCAL dDatPro	:= QRYBD6->BD6_DATPRO //Data do Evento
LOCAL nQtd		:= QRYBD6->BD6_QTDPRO //Quantidade solicitada

LOCAL cCodPad	:= QRYBD6->BD6_CODPAD //Codigo tipo do procedimento (01,02)  ๘
LOCAL cCodPro	:= QRYBD6->BD6_CODPRO //Codigo do procedimento
LOCAL cCodLoc	:= QRYBD6->BD6_CODLDP //Codigo do local de atendimento
LOCAL cCodRda	:= QRYBD6->BD6_CODRDA //Codigo da Rda
LOCAL lCompra	:= .F. //Se e uma tentativa de comprar ou nao
LOCAL cRegAte	:= QRYBD6->BD6_TIPATE // paramixb[24] //Regime de atendimento
LOCAL cCodTabCop:= " " // paramixb[25]  //Codigo da tabela de cobranca especifica (tde)
LOCAL bRetorno  := { || {nPerCop,nValCop,nTaxa,nValUs,cAlias,lExistia,cPgNoAto,cPgDrRDA,nLimFra,lCompra,cRegAte,cCodTabCop} }
LOCAL cVal     := 0

//Local nDiasBloq  := GetNewPar("MV_PLDIABL",0)

//Variaveis Caberj...
Local cDigito  := Modulo11(cOpeOri+cCodEmp+cMatric+cTipReg)
Local nQtdUti  := 0
Local nCont	   := 0
Local aQtd	   := {}
Local aUtiliza := {}
Local lAlterou := .F.
Local cLDPAtu  := QRYBD6->BD6_CODLDP
Local cPEGAtu  := QRYBD6->BD6_CODPEG
Local cNumAtu  := QRYBD6->BD6_NUMERO
Local cAnoAtu  := QRYBD6->BD6_ANOPAG
Local cMesAtu  := QRYBD6->BD6_MESPAG
Local cHorAtu  := QRYBD6->BD6_HORPRO
Local cCodSol  := QRYBD6->BD6_CDPFSO
Local cNumGuia := alltrim(str(val(QRYBD6->BD6_NUMIMP)))
Local nPos	   := 0
Local cProBus  := cCodPro
Local cNivel   := 3
Local nI	   := 1
Local lSolAED  := .F.
Local lGuiVERDE := .F.
Local lTemCoPF := .T.
Local lTemAED := .F.
Local cPlaAnt	:= "9999"
Local cVerAnt	:= "999"
Local nTamSub	:= 16
Local nNivel	:= 3
Local lPFPadrao := .T.
Local lAltPrc := .F.
Local aVetCri := {}
Local aVetTmp := {}
Local nTmpFor := 0
Local nTmpCri := 0
Local cCriPrc := GetNewPar("MV_YALTPPF","002,037,035,505,506")
Local cNovCod := space(0)
Local cSQL 		:= ""
Local caliasPF := space(0)
Local nPerNov := 0
Local nValNov := 0
LOCAL bCond1    := { || AnaDataCOP(dDatPro,caliasPF) }
LOCAL dDatAnalise
LOCAL cPLSREGANVE  := GetNewPar("MV_PLSRADP","1")
Local nVlrMaPF := 0
Local lPagDif := .F.

//BI3->(DbSetOrder(1))
//BB2->(DbSetOrder(1))
//BHD->(DbSetOrder(1))
//BD6->(DbSetOrder(7))
//BE4->(DbSetOrder(2))


//Verifica se a guia esta dentro da numeracao das guias cadastradas como utilizadas no programa AED/AAG.
lGuiVERDE := fValGuia(cNumGuia)

//Verifica se o solicitante eh pertencente ao programa AED/AAG.
ZZ1->(DbSetOrder(1))
If ZZF->(MsSeek(xFilial("ZZF")+cCodSol))

	lSolAED := .T.
	
Endif

cPlaAnt := cCodPla
cVerAnt := cVerPla

// So ira tratar se o usuario possui algum opcional AAG/AED cadastrado e se o solicitante for do AED e/ou a Guia for Verde
// So entra neste IF se o solicitante for do AED e/ou a Guia for VERDE, independente do do ususario possuir ou nao o opcional do AED.
// Verifica se o usuario possui algum opcional AAG/AED cadastrado, caso o solicitante nao for do AED e/ou Formulario nao for VERDE
//Se o usuario nao pertencer ao AED, ma s aGeuia eh VERDE ou o SOLICITANTE for participante do AED nao entra neste IF.
If BF4->(MsSeek(xFilial("BF4")+cCodInt+cCodEmp+cMatric+cTipReg)) .and. (lSolAED .or. lGuiVERDE)
	
	While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == cCodInt+cCodEmp+cMatric+cTipReg .And. !BF4->(Eof())
		
		//Zerar co-participacao (regra AED). Caso cobrar co-part, devera ser analisado conforme regras
		//parametrizadas no produto opcional.
		If BF4->BF4_CODPRO $ GetNewPar("MV_YPLAED","0023,0024")
			
			If Empty(BF4->BF4_DATBLO) //F.Or. (!Empty(BF4->BF4_DATBLO) .And. (dDatPro < BF4->BF4_DATBLO))
				
				cCodPla := BF4->BF4_CODPRO
				cVerPla := BF4->BF4_VERSAO
				lTemCoPF := .T.
				lTemAED := .T.
				lPFPadrao := .F.
				
				Exit
				
			Endif
		ElseIf (lSolAED .and. lGuiVERDE)
			lTemCoPF := .F.
			lPFPadrao := .F.
		Endif
		
		BF4->(DbSkip())
		
	Enddo
ElseIf (lSolAED .and. lGuiVERDE) // Caso o solicitante perten็a ao AED e a guia for Verde.
	// Para os casos do AAG.
	// Ira Entrar neste IF se o solciitante for participanete do AED e se Guia for VERDE.
	// Caso o solcitante nao for do AED e a Guia nao for Verde nao entra neste IF.
	// Se o usuario nao pertencer ao AED, mas a Guia eh VERDE e o SOLICITANTE for participante do AED entra neste IF.
	// Isto servira para os casos dos NUPRES e dos atendimentos AAG.
	// Nao ira cobrar co-participacao
	lTemCoPF := .F.
	lPFPadrao := .F.
Endif
// Se o usuario nao for participante do AED e o solicitante nao for do AED e a Guia nao for VERDE, tera coparticipacao.
// Se o usuario nao for participante do AED e o solcitante for do AED ou a guia nao for VERDE, tera coparticipacao


//Localiza parametrizacoes de produto x proc x qtd...
If BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+cCodPla+cVerPla)) .and. lTemCoPF .and. !lTemAED .and. !lPFPadrao
	
	//Localiza parametrizacoes tanto para procedimentos agrupados, como para atribuicoes diretas...
	
	nCont := 1
	nTamSub := 16
	While nCont <= 3
		
		If cCodPad == "01" //Somente para CIEFAS/AMB...
			If nCont == 1
				cProBus := cCodPro
				nNivel := 3
				nTamSub := 16
				
			ElseIf nCont == 2
				cProBus := Substr(cProBus,1,4)+Replicate("0",3)
				nNivel := 2
				nTamSub := 4
				
			ElseIf nCont == 3
				cProBus := Substr(cProBus,1,2)+Replicate("0",5)
				nNivel := 1
				nTamSub := 2
				
			Endif
		Endif
		
		If BB2->(MsSeek(xFilial("BB2")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus))
			cProBus := BB2->BB2_CODPSA
			
			If BHD->(MsSeek(xFilial("BHD")+PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus))
				
				aQtd := {}
				
				// Comentado por Luzio em 25/09/08, para que considere apenas os procedimenos relamente identicos e no mesmo nivel, pois da forma
				// como estava, o array era alimentado com todos os procedimentos caso o parametrizado fosse niveis 1 e 2,
				// e com procedimentos fora de veigencia. Dessa forma se nao encontrar um procedimento de nivel 3, ira considerar
				// pesquisar pelo sub-grupo ou grupo e alimentara a array somente com o procedimento grupo.
				//					While !BHD->(Eof()) .And. BHD->(BHD_CODIGO+BHD_VERSAO+BHD_CODPAD)+Substr(BHD->BHD_CODPSA,1,nTamSub)==PLSINTPAD()+cCodPla+cVerPla+cCodPad+Substr(cProBus,1,nTamSub)
				While !BHD->(Eof()) .And. BHD->(BHD_CODIGO+BHD_VERSAO+BHD_CODPAD)+BHD->BHD_CODPSA == PLSINTPAD()+cCodPla+cVerPla+cCodPad+cProBus
					If Empty(BHD->BHD_VIGATE) .or. (DtoS(dDatPro) <= DtoS(BHD->BHD_VIGATE) .and. DtoS(dDatPro) >= DtoS(BHD->BHD_VIGDE))
						aadd(aQtd,{BHD->BHD_TIPO,BHD->BHD_QTD,BHD->BHD_PERCOP,BHD->BHD_VLRCOP,BHD->BHD_VALUS, BHD->BHD_TXADM,BHD->BHD_LIMFRA,BHD->BHD_SOMCOM,Iif(nI==2,"0","1"),BHD->BHD_CODIGO, BHD->BHD_VERSAO, BHD->BHD_CODPAD, BHD->BHD_CODPSA})
					EndIf
					BHD->(DbSkip())
					nCont := 3
				Enddo
				
			Endif
		Endif
		
		nCont++
		
	Enddo
Endif

//Retorna parametros da funcao a condicao normal...
cCodPla := cPlaAnt
cVerPla := cVerAnt
cPlaAnt := ""
cVerAnt := ""

If nNivel == 3
	cProBus := cCodPro
ElseIf nNivel == 2
	cProBus := Substr(cProBus,1,4)
ElseIf nNivel == 1
	cProBus := Substr(cProBus,1,2)
Endif

//Levantamento da quantidade utilizada...
//Obter tanto atendimentos ambulatoriais como nao ambulatoriais...
If Len(aQtd) > 0 .and. !lTemAED    //.and. lTemCoPF
	
	/*
	//Apura o tipo de ano a ser considerado na apuracao da quantidade de utilizacao.
	If GetNewPar("MV_PLSRQTD","1") == "1" //por ano civil
	cSQL += "SUBSTR(BD6_DATPRO,1,4) = '" + Str(Year(dData), 4) + "' AND "
	Else //Por ano contratual
	dDatAnaIni := ctod(subs(dtos(dDatInc),7,2)+"/"+subs(dtos(dDatInc),5,2)+"/"+Str(Year(dData)-1, 4))
	//dia que usr entrou   +     mes que usr entrou     +           ano anterior do evento
	cSQL += "BD6_DATPRO >= '"+dtos(dDatAnaIni)+"' AND BD6_DATPRO <= '"+dtos(dDatAnaIni+365)+"' AND "
	Endif
	*/
	
	For nCont := 0 to 1
		
		BD6->(MsSeek(xFilial("BD6")+cOpeOri+cCodEmp+cMatric+cTipReg+cDigito+StrZero(nCont,1)+cProBus))
		
		While BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+BD6_ATEAMB)+Substr(BD6->BD6_CODPRO,1,nTamSub) == cOpeOri+cCodEmp+cMatric+cTipReg+cDigito+StrZero(nCont,1)+Substr(cProBus,1,nTamSub)
			
			//Consistencia do LDP 0003 devido ao historico ser posterior as guias digitadas. Demais deve observar a logica padrao do sistema.
			If BD6->BD6_SITUAC == "1" .And. BD6->BD6_FASE $ "3,4" .And. (BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) < cCodInt+cLDPAtu+cPEGAtu+cNumAtu .Or. BD6->BD6_CODLDP == "0003" )
				
				nQtdUti += BD6->BD6_QTDPRO
				
				If BE4->(MsSeek(xFilial("BE4")+PLSINTPAD()+BD6->(BD6_ANOPAG+BD6_MESPAG)))
					
					//Verificar se o procedimento esta em internacao...
					While !BE4->(Eof()) .And. BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT) == PLSINTPAD()+BD6->(BD6_ANOPAG+BD6_MESPAG)
						If BE4->BE4_SITUAC == "1" .And. BE4->BE4_FASE $ "3,4"
							If BD6->BD6_DATPRO >= BE4->BE4_DATPRO .And. BD6->BD6_DATPRO <= BE4->BE4_DTALTA
								nQtdUti := Iif(cRegAte=="1",nQtdUti,nQtdUti-BD6->BD6_QTDPRO)   //Regime de atendimento INTERNACAO
							Endif
						Endif
						BE4->(DbSkip())
					Enddo
					
				Endif
				
			Endif
			
			BD6->(DbSkip())
		Enddo
	Next
ElseIf !lTemCoPF .or. lTemAED // Incluido por Luzio
	aQtd := {}
	cAlias	:= "BF4"
	nPerCop	:= 0
	nValCop	:= 0
	nValUs	:= 0
	nTaxa   	:= 0
	nLimFra	:= 0
	lExistia := .F.
Endif

//Obtem a regra por quantidade... mais especifica...
//Ordem da matriz aQtd: Regime de atendimento + quantidade...
aSort(aQtd,,, { |x,y| x[9]+x[1]+StrZero(x[2],3) < y[9]+y[1]+StrZero(y[2],3) })

// Se existe procedimento parametrizado no produto AED/AAG e o solicitante pertence ao projeto AED e/ou a Guia eh do AED/AAG
If Len(aQtd) > 0 .and. (lsolAED .or. lGuiVERDE)
	For nCont := 1 to Len(aQtd)
		
		If aQtd[nCont,1] == cRegAte .Or. aQtd[nCont,1] == "3" //Ou igual ao parametrizado, ou Ambos...
			
			If nCont == 1
				
				If nQtdUti < aQtd[nCont,2] //.And. !lAlterou
					
					cAlias	:= "BHD"
					nPerCop	:= aQtd[nCont,3]
					nValCop	:= aQtd[nCont,4]
					nValUs	:= aQtd[nCont,5]
					nTaxa	   := aQtd[nCont,6]
					nLimFra	:= aQtd[nCont,7]
					
					// Trecho de codigo inserido por Luzio em 01/07/08 para que nao devolva como falso a cobranca da coparticipacao,
					//caso o percentual encontrado seja zero, pois retornando apenas o percentual zero, a rotina mantinha a
					//cobranca do valor calculado na origem.
					If nPerCop = 0
						lExistia := .F.
					EndIf
					
				Endif
				
				
			Else
				
				If aQtd[nCont-1,2] < nQtdUti .And. nQtdUti < aQtd[nCont,2] //.And. !lAlterou
					
					cAlias	:= "BHD"
					nPerCop	:= aQtd[nCont,3]
					nValCop	:= aQtd[nCont,4]
					nValUs	:= aQtd[nCont,5]
					nTaxa	:= aQtd[nCont,6]
					nLimFra	:= aQtd[nCont,7]
					// Trecho de codigo inserido por Luzio em 01/07/08 para que nao devolva como falso a cobranca da coparticipacao,
					//caso o percentual encontrado seja zero, pois retornando apenas o percentual zero, a rotina mantinha a
					//cobranca do valor calculado na origem.
					If nPerCop = 0
						lExistia := .F.
					EndIf
				Endif
			Endif
		Endif
		
	Next
EndIf

//Caso tenha alterado antes, nao alterar mais...
If lAlterou
	If lExistia //Existia uma co-participacao que o PLS padrao achou... as variaveis abaixo contem o que o PLS achou, que vc pode mudar...
		
		//nPerCop    deseja mudar de acordo com sua necessidade ???
		//nValCop    deseja mudar de acordo com sua necessidade ???
		//nTaxa      deseja mudar de acordo com sua necessidade ???
		//nValUs     deseja mudar de acordo com sua necessidade ???
		//cAlias     deseja mudar de acordo com sua necessidade ???
		//cPgNoAto   deseja mudar de acordo com sua necessidade ???
		//cPgDrRDA   deseja mudar de acordo com sua necessidade ???
		//nLimFra    deseja mudar de acordo com sua necessidade ???
		//lCompra    deseja mudar de acordo com sua necessidade ???
		//cRegAte    deseja mudar de acordo com sua necessidade ???
		//cCodTabCop deseja mudar de acordo com sua necessidade ???
	Else //O PLS padrao nao achou uma co-participacao... vc pode cobrar, de acordo com sua regra especifica...
		//sua regra
		//sua regra
		//sua regra
		//agora, coloque nas variaveis abaixo os dados da co-participacao...
		//nPerCop    coloque sua regra especifica
		//nValCop    coloque sua regra especifica
		//nTaxa      coloque sua regra especifica
		//nValUs     coloque sua regra especifica
		//cAlias     coloque sua regra especifica
		//lExistia   coloque sua regra especifica
		//cPgNoAto   coloque sua regra especifica
		//cPgDrRDA   coloque sua regra especifica
		//nLimFrad   coloque sua regra especifica
		//lCompra    coloque sua regra especifica
		//cRegAte    coloque sua regra especifica
		//cCodTabCop coloque sua regra especifica
	Endif
Endif

//Cobranca de co-participacao diferenciada para determinados codigos de criticas (carencia, bloqueio, etc.)
If .f. //Len(paramixb) >= 32
	
	aVetCri := aClone(paramixb[32])
	
	For nTmpFor := 1 to Len(aVetCri)
		
		aVetTmp := aClone(aVetCri[nTmpFor])
		
		For nTmpCri := 1 to Len(aVetTmp)
			
			If ! Empty(aVetTmp[nTmpCri][1]) .and. aVetTmp[nTmpCri][6]==BD6->BD6_CODPAD .and. aVetTmp[nTmpCri][7]==BD6->BD6_CODPRO
				If aVetTmp[nTmpCri][1] $ cCriPrc
					lAltPrc := .T.
				Endif
			Endif
			
		Next
		
	Next
	
	If !lAltPrc
		// Se nao encontrou a critica no vetor acima e for oriundo da funcao de ANALISE DE GLOSA e a variavel
		// lCompra ja estiver setada como verdadeira (significa que ja executou a rotina anteriormente achando o valor da co-participacao
		// para compra. Se for passagem pela rotina de mudanca de fase, nao vai entrar nessa rotina pois a variavel lCompra vai estar como
		// falsa.
		// Posiciono no arquivo de critica do BDX desse procedimento
		
		For nX = 1 to Len(AllTrim(cCriPrc)) step 4
			cNovCod += "'"+AllTrim(SubStr(cCriPrc,nX,3))+"',"
		Next
		If At(",",cNovCod) > 0
			cNovCod := SubStr(AllTrim(cNovCod),1,Len(AllTrim(cNovCod))-1)
		EndIf
		cSQL := " SELECT BDX_CODOPE, BDX_CODLDP, BDX_CODPEG, BDX_NUMERO, BDX_SEQUEN, BDX_ORIMOV, "
		cSQL += " BDX_CODPAD, BDX_CODPRO, BDX_CODGLO, COUNT(R_E_C_N_O_) AS NROREG "
		cSQL += " FROM "+RetSQLName("BDX")+" BDX "
		cSQL += " WHERE BDX_FILIAL = '"+xFilial("BDX")+"' "
		cSQL += " AND BDX_CODOPE = '"+PLSINTPAD()+"' "
		cSQL += " AND BDX_CODLDP = '"+BD6->BD6_CODLDP+"' "
		cSQL += " AND BDX_CODPEG = '"+BD6->BD6_CODPEG+"' "
		cSQL += " AND BDX_NUMERO = '"+BD6->BD6_NUMERO+"' "
		cSQL += " AND BDX_ORIMOV = '"+BD6->BD6_ORIMOV+"' "
		cSQL += " AND BDX_SEQUEN = '"+BD6->BD6_SEQUEN+"' "
		//		cSQL += " AND BDX_NIVEL = '1' "
		cSQL += " AND BDX_CODPAD = '"+AllTrim(cCodPad)+"' "
		cSQL += " AND BDX_CODPRO = '"+AllTrim(cCodPro)+"' "
		cSQL += " AND BDX_CODGLO IN ("+cNovCod+") "
		cSQL += " AND BDX_TIPREG = '1' "
		cSQL += " AND BDX.D_E_L_E_T_ = ' ' "
		cSQL += " GROUP BY BDX_CODOPE, BDX_CODLDP, BDX_CODPEG, BDX_NUMERO, BDX_SEQUEN, BDX_ORIMOV, "
		cSQL += " BDX_CODPAD, BDX_CODPRO, BDX_CODGLO "
		
		PlsQuery(cSQL,"TRB1")
		
		If TRB1->NROREG > 0
			lAltPrc := .T.
		EndIf
		TRB1->(DbCloseArea())
		
	EndIf
	
Endif

If lAltPrc
	
	nPerNov := 0
	
	For nCont := 1 to 3
		
		Do Case
			Case nCont == 1
				_cCodProTmp := cCodPro
				
			Case nCont == 2
				_cCodProTmp := Substr(cCodPro,1,4)
				
			OtherWise
				_cCodProTmp := Substr(cCodPro,1,2)
				
		EndCase
		
		cSQL := " SELECT BHD_PERCOP, BHD_VLRCOP, BHD_VALUS, BHD_TXADM, BHD_CODTAB, BHD_LIMFRA, BHD_PAGATO, "
		cSQL += " BHD_PAGDIF, BHD_PAGRDA, COUNT(R_E_C_N_O_) AS NROREG "
		cSQL += " FROM "+RetSQLName("BHD")+" BHD "
		cSQL += " WHERE BHD_FILIAL = '"+xFilial("BHD")+"' "
		cSQL += " AND BHD_CODIGO = '"+BI3->(BI3_CODINT+BI3_CODIGO)+"' "
		cSQL += " AND BHD_VERSAO = '"+BI3->BI3_VERSAO+"' "
		cSQL += " AND BHD_CODPAD = '"+cCodPad+"' "
		If nCont == 1
			cSQL += " AND BHD_CODPSA = '"+_cCodProTmp+"' "
		Else
			cSQL += " AND BHD_CODPSA LIKE '"+_cCodProTmp+"%' "
		Endif
		cSQL += " AND BHD_SOMCOM = '1' "
		cSQL += " AND BHD.D_E_L_E_T_ = ' ' "
		cSQL += " GROUP BY BHD_PERCOP, BHD_VLRCOP, BHD_VALUS, BHD_TXADM, BHD_CODTAB, BHD_LIMFRA, BHD_PAGATO, "
		cSQL += " BHD_PAGDIF, BHD_PAGRDA "
		
		PlsQuery(cSQL,"TRB2")
		
		If TRB2->NROREG > 0
			nCont    := 3
			If TRB2->BHD_PERCOP > 0
				nPerNov := TRB2->BHD_PERCOP
				nValNov := 0
				caliasPF := "BHD"
			ElseIf TRB2->BHD_VLRCOP > 0
				nPerNov := 0
				nValNov := TRB2->BHD_VALCOP
				caliasPF := "BHD"
			EndIf
			
		Endif
		
		TRB2->(DbCloseArea())
		
	Next
	
	If nPerNov == 0 .and. nValNov == 0
		
		BHG->(DbSetOrder(1))
		BHG->(MsSeek(xFilial("BHG")+BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_CONEMP+BD6_VERCON+BD6_SUBCON+BD6_VERSUB)+cCodPla))
		
		While BHG->(BHG_FILIAL+BHG_CODINT+BHG_CODIGO+BHG_NUMCON+BHG_VERCON+BHG_SUBCON+BHG_VERSUB+BHG_CODPRO) == (xFilial("BHG")+BD6->(BD6_OPEUSR+BD6_CODEMP+BD6_CONEMP+BD6_VERCON+BD6_SUBCON+BD6_VERSUB)+cCodPla) .and. ! BHG->(Eof())
			
			If (BHG->BHG_TIPO == cRegAte) .or. (BHG->BHG_TIPO == "3")
				If (BHG->BHG_PERCOP > 0 .or. BHG->BHG_VALCOP > 0) .and. BHG->BHG_SOMCOM == "1"
					If BHG->BHG_PERCOP > 0
						nPerNov := BHG->BHG_PERCOP
						nValNov := 0
						caliasPF := "BHG"
					else
						nPerNov := 0
						nValNov := BHG->BHG_VALCOP
						caliasPF := "BHG"
					EndIf
					Exit
				Endif
			Endif
			
			BHG->(DbSkip())
		EndDo
	EndIf
	
	If nPerNov == 0 .and. nValNov == 0
		
		BHJ->(DbSetOrder(1))
		BHJ->(MsSeek(xFilial("BHJ")+cCodInt+cCodPla+cVerPla))
		
		While BHJ->(BHJ_FILIAL+BHJ_CODINT+BHJ_CODPLA+BHJ_VERSAO) == (xFilial("BHJ")+cCodInt+cCodPla+cVerPla) .and. ! BHJ->(Eof())
			
			If (BHJ->BHJ_TIPO == cRegAte) .or. (BHJ->BHJ_TIPO == "3")
				If (BHJ->BHJ_PERCOP > 0 .or. BHJ->BHJ_VALCOP > 0) .and. BHJ->BHJ_SOMCOM == "1"
					If BHJ->BHJ_PERCOP > 0
						nPerNov := BHJ->BHJ_PERCOP
						nValNov := 0
						caliasPF := "BHJ"
					else
						nPerNov := 0
						nValNov := BHJ->BHJ_VALCOP
						caliasPF := "BHJ"
					EndIf
					Exit
				Endif
			Endif
			
			BHJ->(DbSkip())
		EndDo
		
	Endif
	
	If (nPerNov > 0 .or. nValNov > 0) .and. ( Eval(bCond1))
		
		If ExistBlock("PLSDATAN")
			cPLSREGANVE := ExecBlock("PLSDATAN",.F.,.F.,{cTipoGuia,cPLSREGANVE})
		Endif
		
		If cPLSREGANVE == "1"
			dDatAnalise := dDatPro
		Else
			dDatAnalise := dDataBase
		Endif
		
		If nPerNov > 0
			nPerCop  := nPerNov
			nValCop	 := 0
		ElseIf nValNov > 0
			nPerCop  := 0
			nValCop	 := nValNov
		EndIf
		nTaxa	   := &(caliasPF+"->"+caliasPF+"_TXADM")
		nValUs	   := &(caliasPF+"->"+caliasPF+"_VALUS")
		cAlias     := caliasPF
		lExistia   := .T.
		cPgNoAto   := &(caliasPF+"->"+caliasPF+"_PAGATO")
		cPgDrRDA   := &(caliasPF+"->"+caliasPF+"_PAGRDA")
		nLimFra	   := &(caliasPF+"->"+caliasPF+"_LIMFRA")
		lCompra	   := .F.
		cRegAte    := &(caliasPF+"->"+caliasPF+"_TIPO")
		cCodTabCop := &(caliasPF+"->"+caliasPF+"_CODTAB")
		If &(cAliasPF)->( FieldPos(cAliasPF+"_ANOMES") ) > 0 .and. &(cAliasPF)->( FieldPos(cAliasPF+"_VLRANT") ) > 0
			If Substr(dTos(dDatAnalise),1,6) < &(cAliasPF+"->"+cAliasPF+"_ANOMES")
				nLimFra := &(cAliasPF+"->"+cAliasPF+"_VLRANT")
			Else
				If &(cAliasPF)->(FieldPos(cAliasPF+"_LIMFRA")) > 0
					nLimFra := &(cAliasPF+"->"+cAliasPF+"_LIMFRA")
				Endif
			Endif
		Else
			If &(cAliasPF)->(FieldPos(cAliasPF+"_LIMFRA")) > 0
				nLimFra := &(cAliasPF+"->"+cAliasPF+"_LIMFRA")
			Endif
		Endif
	Endif
Endif

//Trecho de codigo inserido por Luzio para que nao cobre co-participaco dos procedimentos de VISITA do AED/AAG
If Alltrim(cCodPro) $ GetNewPar("MV_YPRAED","86000071,86000201,85030015,86000250,86000233,86000276,86000241,86000268,86000322,86000330")
	//Limpa a cobranca da co-participacao
	aQtd := {}
	cAlias	:= "BF4"
	nPerCop	:= 0
	nValCop	:= 0
	nValUs	:= 0
	nTaxa   	:= 0
	nLimFra	:= 0
	lExistia := .F.
EndIf

If nValCop <>  QRYBD6->BD6_VLRTPF 
                       
 		c_Sql := " INSERT INTO BD6_ERRO2 (BD6_CODOPE, BD6_CODEMP , BD6_MATRIC, BD6_TIPREG, BD6_PREFIX ,BD6_NUMTIT , BD6_CODLDP , BD6_CODPEG,  BD6_COPCOB , BD6_COPDEV, BD6_REC) " 
 //		c_Sql := " INSERT INTO BD6_ERRO2 ('0099', BD6_CODEMP , BD6_MATRIC, BD6_TIPREG, BD6_PREFIX ,BD6_NUMTIT , BD6_CODLDP , BD6_CODPEG,  BD6_COPCOB , BD6_COPDEV, BD6_REC) "
		c_Sql += " VALUES ( '0099',  '" + QRYBD6->BD6_CODEMP + "' , '"+ QRYBD6->BD6_MATRIC +"', '" + QRYBD6->BD6_TIPREG + "', '" + QRYBD6->BD6_PREFIX + "','" + ;
					QRYBD6->BD6_NUMTIT + "' , '" + BD6_CODLDP + "' ,'" + QRYBD6->BD6_CODPEG + "'," + str(QRYBD6->BD6_VLRTPF) + "," + str( nValCop ) + "," + str( QRYBD6->NUMREC ) + ")"

		If TcSqlExec(c_Sql) < 0 
		
			MsgInfo("Erro na sele็ใo de Registros !!!" + c_Sql )
			lContinua := .F.
			Return  
			
		Endif
	
	   //	n_Total += QRYBD6->BD6_VLRTPF  
	
EndIf

Return( c_Memo )

**********************************************************
* Funcao....: fValGuia()                                       *
* Finalidade: verifica se a Guia pertence ao AED				*
**********************************************************
Static Function fValGuia(cGuia)

Local lRet    := .F.
Local aArea   := GetArea()

cQuery:="SELECT ZC_NUMINI, ZC_NUMFIM, ZC_SITUAC FROM "+RetSQLName("SZC")+" "
cQuery+="WHERE D_E_L_E_T_ <> '*' AND '"+cGuia+"' BETWEEN ZC_NUMINI AND ZC_NUMFIM "

TCQUERY cQuery ALIAS "VALTAL" NEW

dbselectarea("VALTAL")
If !Eof() .AND. VALTAL->ZC_SITUAC $ " _1"
	lRet:=.T.
EndIf
VALTAL->(DbCloseArea())

RestArea(aArea)

Return(lRet)

Static Function AnaDataCOP(dDatPro,cAliasPF)
LOCAL lRet := .F.
LOCAL dCpoDat1
LOCAL dCpoDat2

DbSelectArea(cAliasPF)
If FieldPos(cAliasPF+"_VIGDE") == 0 .Or. FieldPos(cAliasPF+"_VIGATE") == 0
	lRet := .T.
Else
	dCpoDat1 := &(cAliasPF+"->"+cAliasPF+"_VIGDE")
	dCpoDat2 := &(cAliasPF+"->"+cAliasPF+"_VIGATE")
	
	If     Empty(dCpoDat1) .And. Empty(dCpoDat2)
		lRet := .T.
	ElseIf dtos(dDatPro) >= dtos(dCpoDat1) .And. dtos(dDatPro) <= dtos(dCpoDat2)
		lRet := .T.
	Endif
Endif

Return(lRet)