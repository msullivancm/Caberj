#include "PLSMGER.CH"
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA041   ºAutor  ³Renato Peixoto      º Data ³  10/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Fonte que sera responsavel pelo rateio dos internistas.    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                                                     
//falta só totalizar peg em cada internista/auxiliar
User Function CABA041()

Private cPerg     := "RATEIOINT"  
Private cMesPag   := ""
Private cAnoPag   := ""
Private cCodInt   := "0001"
Private cNomInt   := POSICIONE("BA0",1,XFILIAL("BA0")+cCodInt,"BA0_NOMINT")
Private cOpeRDA   := ""                                                    
Private cCodRDA   := ""
Private cNomRDA   := ""
Private lExistRat := .F.
Private dDtEvento 
Private cCodPad   := ""
Private cCodProc  := ""
Private aArray1   := {} 
Private nValorRDA := 0
Private nVlrPgRDA := 0 //valor ja gerado para o RDA no mes+ano em questao
Private nQtdIntern:= 0
Private nQtdPgRDA := 0
Private nVlrIndRDA:= 0
Private nVlrDecr  := 0 //valor a ser subtraido, caso ja tenha sido gerado o rateio parcialmente
Private lOkAux    := .F.
Private nQtdAux   := 0
Private cRDAcAux  := GetMV("MV_XRDAAUX") //variável que identifica RDA que possui auxiliar, como o Flavio Marra por exemplo (RDA 104841)
Private cCodLDP   := '0017'//"0001"
Private cCodPEG   := ""
Private cGuiaRat  := ""   

Private cCodPla   := ""

INCLUI := .T. //adicionado para solucionar problema no inicializador padrão do campo bd5_opesol

CriaSX1()

If !Pergunte(cPerg,.T.)
	Return
EndIf
		
cMesPag   := MV_PAR01
cAnoPag   := MV_PAR02
dDtEvento := MV_PAR03
		
DbSelectArea("PAR")
DbSetOrder(1)
If DbSeek(XFILIAL("PAR")+cMesPag+cAnoPag)
	If APMSGYESNO("Atenção já existe rateio lançado para a competência informada. Somente serão gerados rateios que ainda não foram processados para essa competência. Deseja continuar?","Existe rateio nessa competência!")
		lExistRat := .T.
		GERARATINT()
	Else
		Return
	EndIf
	
Else
	
	GERARATINT()

EndIf
		

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ GERARATINT ³ Autor ³ Renato Peixoto    ³ Data ³ 15/06/2011 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GERARATINT()
Local lret

Private cTitulo := "Gerando rateio internista"

Processa({|| lret := ProcRatInt() }, cTitulo, "", .T.)

Return lret


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ProcRatInt    ºAutor  ³ Renato Peixoto º Data ³  15/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Processamento do rateio dos internistas.                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ.                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ProcRatInt()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cQuery	  := ""
Local cQuery2     := ""
Local cQuery3     := ""
Local cQuery4     := ""
Local cQuery5     := ""
Local cQryTotPg   := ""                         
Local cQryTotInt  := ""
Local cAliasQry   := GetNextAlias()
Local _2cAliasQry := GetNextAlias()
Local _3cAliasQry := GetNextAlias()
Local _4cAliasQry := GetNextAlias() 
Local _5cAliasQry := GetNextAlias()
Local cArqQryPG   := GetNextAlias()  
Local cArqQryInt  := GetNextAlias()
Local cArqTotGui  := GetNextAlias()
Local cMacroTab   := ""
Local cLocalBB8   := ""
Local cDesLocBB8  := ""
Local cBB8END     := ""
Local cBB8NR_END  := ""
Local cBB8COMEND  := ""
Local cBB8Bairro  := ""
Local cCodEsp     := ""
Local nTotQry	  := 0
Local cCrmSolic   := ""
Local cTipoPgto   := ""
Local cTelefone   := ""
Local cSexo       := "" 
Local lGerouRat   := .F.
Local cSelect     := ""

cCodProc  := GetNewPar("MV_YCODPROC","86000020")
//----<
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao de indices para busca...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("BAU")
BAU->(DbSetOrder(1)) //Tabela das RDAS
//ZZV->(DbSetOrder(1)) //Tabela que guarda os rateios dos internistas / AAG
DbSelectArea("BE4")
BE4->(DbSetOrder(11))//Tabela de internacoes

//Verifico se vai haver rateio para os auxiliares do internista Flavio Marra
cQuery3 := " SELECT Count(DISTINCT(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)) AS TOTAL FROM "+RetSQLName("BD6")
cQuery3 += " WHERE BD6_FILIAL = ' ' AND BD6_CODOPE = '0001' "
cQuery3 += " AND BD6_ANOPAG||BD6_MESPAG = '"+cAnoPag+cMesPag+"' "
cQuery3 += " AND D_E_L_E_T_ <> '*' "
cQuery3 += " AND BD6_CODPRO = '"+cCodProc+"'"
cQuery3 += " AND BD6_CODRDA = '"+cRDAcAux+"'"
cQuery3 += " AND BD6_SITUAC = '1' "       
/*If lExistRat
	cQuery3 += " AND BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO NOT IN (SELECT PAR_CODINT||PAR_CODEMP||PAR_MATRIC||PAR_TIPREG||PAR_DIGITO "
 	cQuery3 += " FROM "+RetSqlName("PAR")+" PAR  "
	cQuery3 += " WHERE D_E_L_E_T_ = ' ' AND PAR_FILIAL = '"+XFILIAL("PAR")+"' AND PAR_CODRDA = '"+cRDAcAux+"' AND PAR_COMPET = '"+cMesPag+cAnoPag+"' ) "
EndIf                                                                                                     
*/
If Select(_3cAliasQry) <> 0 
	(_3cAliasQry)->(DbCloseArea()) 
Endif

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery3),_3cAliasQry,.T.,.T.)
	
If (_3cAliasQry)->TOTAL > 0
	lOkAux    := .T.
	nQtdAux   := (_3cAliasQry)->TOTAL
	nTotQry   := (_3cAliasQry)->TOTAL
	ProcRegua(nTotQry)
	
	//rodo a query que vai servir para qualquer auxiliar de internista
	cSelect := "BD6_CODPLA,BD6_OPERDA,BD6_CODRDA,BD6_CODOPE,BD6_CODPAD,BD6_CODPRO,BD6_DATPRO,BD6_HORPRO,BD6_NOMUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO"//LOCAL DE DIGITACAO, PEG E NUMERO ACRESCENTADOS POR RENATO PEIXOTO EM 28/02/12
	aSelect := strTokArr(cSelect,',')
	aStru := {}
	
	dbSelectArea('SX3')
	dbSetOrder(2)
	
	For i := 1 to len(aSelect)
		
		If dbSeek(aSelect[i])
			aAdd(aStru,{SX3->X3_CAMPO,SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})	
		EndIf
	
	Next
	
	cQuery4 := " SELECT " + cSelect + " FROM "+RetSQLName("BD6")
	cQuery4 += " WHERE BD6_FILIAL = '"+XFILIAL("BD6")+"' AND BD6_CODOPE = '0001' "
	cQuery4 += " AND BD6_ANOPAG||BD6_MESPAG = '"+cAnoPag+cMesPag+"' "
	cQuery4 += " AND D_E_L_E_T_ <> '*' "
	cQuery4 += " AND BD6_CODPRO = '"+cCodProc+"'"
	cQuery4 += " AND BD6_CODRDA = '"+cRDAcAux+"'"
	cQuery4 += " AND BD6_SITUAC = '1' " 
	/*If lExistRat
		cQuery4 += " AND BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO NOT IN (SELECT PAR_CODINT||PAR_CODEMP||PAR_MATRIC||PAR_TIPREG||PAR_DIGITO "
   		cQuery4 += " FROM "+RetSqlName("PAR")+" PAR  "
    	cQuery4 += " WHERE D_E_L_E_T_ = ' ' AND PAR_FILIAL = '"+XFILIAL("PAR")+"' AND PAR_CODRDA = '"+cRDAcAux+"' AND PAR_COMPET = '"+cMesPag+cAnoPag+"' ) "
   	EndIf
	*/
	If Select(_4cAliasQry) <> 0 
		(_4cAliasQry)->(DbCloseArea()) 
	Endif

	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery4),_4cAliasQry,.T.,.T.)
	
	DbSelectArea(_4cAliasQry)
	cArqTrab := CriaTrab(aStru, .T.)
		
	dbUseArea(.T.,__LocalDriver,cArqTrab,_5cAliasQry,.F.)
	
	
	While !(_4cAliasQry)->(EOF())
	
		(_5cAliasQry)->(RecLock((_5cAliasQry),.T.))
		
		For i := 1 to len(aStru)
	
			If aStru[i][2] = "D"
				(_5cAliasQry)->&(aStru[i][1]) := STOD((_4cAliasQry)->&(aStru[i][1]))
			Else
				(_5cAliasQry)->&(aStru[i][1]) := (_4cAliasQry)->&(aStru[i][1])
			EndIf
		
		Next
		
		(_5cAliasQry)->(MsUnlock())
		
		(_4cAliasQry)->(dbSkip())          
		
	EndDo
	
EndIf	


DbSelectArea("PAQ")
DbSetOrder(1)

PAQ->(DbGoTop())     

While !(PAQ->(Eof()))

	If PAQ->PAQ_CODRDA $ "106593|138738"//Chamado ID: 11987 Gerados pelo CABA326
    	PAQ->(DbSkip())
    	Loop
    EndIf
    
	aArray1 	:= {}//zero o vetor a cada loop
    nValorRDA 	:= PAQ->PAQ_VALOR
    
    If PAQ->PAQ_AUX = "S"
    	If !lOkAux
    		PAQ->(DbSkip())
    		Loop
    	EndIf
    EndIf
    
	If BAU->(DbSeek(xFilial("BAU")+PAQ->PAQ_CODRDA))
		cCrmSolic := BAU->BAU_CONREG
		cTipoPgto := BAU->BAU_GRPPAG
		cNomRDA   := BAU->BAU_NOME
		cCodRda   := BAU->BAU_CODIGO
	EndIf
    
	 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consulta para verificar o total de internacoes solicitadas pela RDA ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If PAQ->PAQ_AUX = "N"
		cQuery := " SELECT Count(DISTINCT(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)) AS TOTAL FROM "+RetSQLName("BD6")
		cQuery += " WHERE BD6_FILIAL = ' ' AND BD6_CODOPE = '0001' "
		cQuery += " AND BD6_ANOPAG||BD6_MESPAG = '"+cAnoPag+cMesPag+"' "
		cQuery += " AND D_E_L_E_T_ <> '*' "
		cQuery += " AND BD6_CODPRO = '"+cCodProc+"'"
		cQuery += " AND BD6_CODRDA = '"+cCodRda+"'"
		cQuery += " AND BD6_SITUAC = '1' "
		If lExistRat
			cQuery += " AND BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO NOT IN (SELECT PAR_CODINT||PAR_CODEMP||PAR_MATRIC||PAR_TIPREG||PAR_DIGITO "
   		 	cQuery += "FROM "+RetSqlName("PAR")+" PAR  "
    		cQuery += "WHERE D_E_L_E_T_ = ' ' AND PAR_FILIAL = '"+XFILIAL("PAR")+"' AND PAR_CODRDA = '"+cCodRDA+"' AND PAR_COMPET = '"+cMesPag+cAnoPag+"' ) "
   		EndIf
		//MemoWrite("C:\ratint.txt",cSQL)
		
		If Select(cAliasQry) <> 0 
			(cAliasQry)->(DbCloseArea()) 
		Endif

		DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
	
		nTotQry := (cAliasQry)->TOTAL
			
		If nTotQry == 0
			MsgAlert("Nao existe atendimentos para o RDA "+AllTrim(cNomRDA)+" neste periodo ou o pagamento ja foi gerado anteriormente !!!")
			(cAliasQry)->(DbCloseArea())
			PAQ->(DbSkip())
			Loop
		Else
			lGerouRat := .T. //identifica que houve rateio ao menos para um internista
			ProcRegua(nTotQry)
		EndIf
	
	Else
		ProcRegua(nTotQry)	
	EndIf	
	
	//Estabelece o valor que será rateeado para cada beneficiário atendido
	If PAQ->PAQ_AUX = "N"
		
		DbSelectArea("PAR")
		DbSetOrder(1)
		If DbSeek(XFILIAL("PAR")+cMesPag+cAnoPag+PAQ->PAQ_CODRDA) //se encontrar qualquer rateio gerado para o RDA na competencia em questao, tem que buscar o valor ja gerado
			cQryTotPg := "SELECT SUM(PAR_VLRRAT) TOTPAGO "
			cQryTotPg += "FROM "+RetSqlName("PAR")+" PAR "
			cQryTotPg += "WHERE D_E_L_E_T_ = ' ' "
			cQryTotPg += "AND PAR_FILIAL = '  ' "
			cQryTotPg += "AND PAR_CODRDA = '"+PAQ->PAQ_CODRDA+"' "
			cQryTotPg += "AND PAR_COMPET = '"+cMesPag+cAnoPag+"' "
	    
			If Select(cArqQryPG) <> 0
				(cArqQryPG)->(DbCloseArea())
			EndIf
		
			DbUseArea(.T.,"TopConn",TcGenQry(,,cQryTotPg),cArqQryPG,.T.,.T.)
		
			nVlrPgRDA := (cArqQryPG)->TOTPAGO  //obtenho o valor que ja foi rateado para o RDA no mesmo mes+ano
		
			nVlrIndRDA := (nValorRDA-nVlrPgRDA)/nTotQry	
		Else
			
			nVlrIndRDA := nValorRDA/nTotQry
			
		EndIf
	Else
		
		DbSelectArea("PAR")
		DbSetOrder(1)  //corrigir de maneira que seja feito a query de cima do cquery3 onde a matricula completa nao esteja na PAR nesse competencia
		If DbSeek(XFILIAL("PAR")+cMesPag+cAnoPag+PAQ->PAQ_CODRDA) //se encontrar qualquer rateio gerado para o RDA na competencia em questao, tem que buscar o valor ja gerado
			//query que vai trazer a quantidade total de antedimentos realizada pelo internista flavio marra
			cQryTotInt := "SELECT Count(DISTINCT(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)) AS TOTINT "
 			cQryTotInt += "FROM "+RetSqlName("BD6")+" BD6 " 
 			cQryTotInt += "WHERE BD6_FILIAL = '"+XFILIAL("BD6")+"' AND BD6_CODOPE = '0001'  AND BD6_ANOPAG||BD6_MESPAG = '"+cAnoPag+cMesPag+"'  AND D_E_L_E_T_ <> '*' "
			cQryTotInt += "AND	 BD6_CODPRO = '"+cCodProc+"' AND BD6_CODRDA = '"+cRDAcAUX+"' AND BD6_SITUAC = '1' "
			
			If Select(cArqQryInt)>0
				cArqQryInt->(DbCloseArea())
			EndIf
			
			DbUseArea(.T.,"TopConn",TcGenQry(,,cQryTotInt),cArqQryInt,.T.,.T.)
			
			nQtdIntern := (cArqQryInt)->TOTINT //total de atendimentos realizado pelo internista Flavio Marra
			
			cQryTotPg := "SELECT SUM(PAR_VLRRAT) TOTPAGO, COUNT(PAR_VLRRAT) QTDE "
			cQryTotPg += "FROM "+RetSqlName("PAR")+" PAR "
			cQryTotPg += "WHERE D_E_L_E_T_ = ' ' "
			cQryTotPg += "AND PAR_FILIAL = '"+XFILIAL("PAR")+"' "
			cQryTotPg += "AND PAR_CODRDA = '"+PAQ->PAQ_CODRDA+"' "
			cQryTotPg += "AND PAR_COMPET = '"+cMesPag+cAnoPag+"' "
	    
			If Select(cArqQryPG) <> 0
				(cArqQryPG)->(DbCloseArea())
			EndIf
		
			DbUseArea(.T.,"TopConn",TcGenQry(,,cQryTotPg),cArqQryPG,.T.,.T.)
		
			nVlrPgRDA := (cArqQryPG)->TOTPAGO  //obtenho o valor que ja foi rateado para o RDA no mesmo mes+ano
		    nQtdPgRDA := (cArqQryPG)->QTDE  //obtem o total que ja foi rateado para o RDA no mes+ano
		
			nVlrIndRDA := (nValorRDA-nVlrPgRDA)/(nQtdIntern-nQtdPgRDA)	
		
		Else
			//busco novamente o total de atendimentos do internista Flavio Marra para atualizar o conteudo da variavel nQtdAux no caso de ser o segundo auxiliar, pois a variavel vai estar com o conteudo desatualizado
			cQryTotInt := "SELECT Count(DISTINCT(BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)) AS TOTINT "
 			cQryTotInt += "FROM "+RetSqlName("BD6")+" BD6 " 
 			cQryTotInt += "WHERE BD6_FILIAL = '"+XFILIAL("BD6")+"' AND BD6_CODOPE = '0001'  AND BD6_ANOPAG||BD6_MESPAG = '"+cAnoPag+cMesPag+"'  AND D_E_L_E_T_ <> '*' "
			cQryTotInt += "AND	 BD6_CODPRO = '"+cCodProc+"' AND BD6_CODRDA = '"+cRDAcAUX+"' AND BD6_SITUAC = '1' "
			
			If Select(cArqQryInt)>0
				cArqQryInt->(DbCloseArea())
			EndIf
			
			DbUseArea(.T.,"TopConn",TcGenQry(,,cQryTotInt),cArqQryInt,.T.,.T.)
			
			nQtdAux := (cArqQryInt)->TOTINT
			
			nVlrIndRDA := nValorRDA/nQtdAux
		
		EndIf
		
	EndIf
	
	If Select(cArqQryPG) <> 0
		(cArqQryPG)->(DbCloseArea())
	EndIf
	 
	If Select(cArqQryInt)<>0
		(cArqQryInt)->(DbCloseArea())
	EndIf
	
	If PAQ->PAQ_AUX = "N"
		                   //BD6_CODPLA, BD6_OPERDA, BD6_CODRDA, BD6_CODOPE, BD6_CODPAD, BD6_CODPRO, BD6_DATPRO, BD6_HORPRO, BD6_NOMUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG,BD6_DIGITO,BD6_CODLDP,BD6_CODPEG,BD6_NUMERO
		cQuery2 := " SELECT BD6_CODPLA, BD6_OPERDA, BD6_CODRDA, BD6_CODOPE, BD6_CODPAD, BD6_CODPRO, BD6_DATPRO, BD6_HORPRO, BD6_NOMUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO "
		cQuery2 += "FROM "+RetSQLName("BD6") "
		cQuery2 += " WHERE BD6_FILIAL = '"+XFILIAL("BD6")+"' AND BD6_CODOPE = '0001' "
		cQuery2 += " AND BD6_ANOPAG||BD6_MESPAG = '"+cAnoPag+cMesPag+"' "
		cQuery2 += " AND D_E_L_E_T_ <> '*' "
		cQuery2 += " AND BD6_CODPRO = '"+cCodProc+"'"
		cQuery2 += " AND BD6_CODRDA = '"+cCodRda+"'"
		cQuery2 += " AND BD6_SITUAC = '1' " 
		If lExistRat
			cQuery2 += " AND BD6_CODOPE||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO NOT IN (SELECT PAR_CODINT||PAR_CODEMP||PAR_MATRIC||PAR_TIPREG||PAR_DIGITO "
   		 	cQuery2 += "FROM "+RetSqlName("PAR")+" PAR  "
    		cQuery2 += "WHERE D_E_L_E_T_ = ' ' AND PAR_FILIAL = '"+XFILIAL("PAR")+"' AND PAR_CODRDA = '"+cCodRDA+"' AND PAR_COMPET = '"+cMesPag+cAnoPag+"' ) "
   		EndIf

		If Select(_2cAliasQry) <> 0 
			(_2cAliasQry)->(DbCloseArea()) 
		Endif

		DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery2),_2cAliasQry,.T.,.T.)

    Else
    	(_5cAliasQry)->(DbGoTop())
	EndIf
		
	//busca o local de atendimento e especialidade
    DbSelectArea("BAU")
	DbSetOrder(1)
	If DbSeek(XFILIAL("BAU")+cCodRDA)
		//ver com dr. jose paulo local de atendimento
		cLocalBB8  := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE,"BB8_CODLOC")
		cDesLocBB8 := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE,"BB8_DESLOC")
		cBB8END    := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE,"BB8_END")
		cBB8NR_END := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE,"BB8_NR_END")
		cBB8COMEND := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE,"BB8_COMEND")
		cBB8Bairro := POSICIONE("BB8",3,XFILIAL("BB8")+cCodRDA+cCodInt+PAQ->PAQ_LOCATE,"BB8_BAIRRO")
		cCodEsp    := POSICIONE("BAX",1,XFILIAL("BAX")+cCodRDA+cCodInt+cLocalBB8,"BAX_CODESP")
	EndIf	
	
	If PAQ->PAQ_AUX == "N"
		cMacroTab := '("' + _2cAliasQry + '")'
	Else
		cMacroTab := '("' + _5cAliasQry + '")'
	EndIf

	While !((&cMacroTab)->(Eof()))
	    
	    //Verifico se já existe o registro na PAR, significando que já foi gravado rateio para o registro em questão. Renato Peixoto em 11/07/11
		DbSelectArea("PAR")
	    DbSetOrder(1)
	    If DbSeek(XFILIAL("PAR")+cMesPag+cAnoPag+cCodRDA+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO)
			&cMacroTab->(DbSkip())
			Loop
		EndIf
		
		cOpeRDA := &cMacroTab->BD6_OPERDA
		cCodPad := &cMacroTab->BD6_CODPAD
	
		//busca o telefone do usuário
		cTelefone := POSICIONE("BA1",2,XFILIAL("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_TELEFO")
		//busca o sexo do usuario
		cSexo := POSICIONE("BA1",2,XFILIAL("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_SEXO")
		//busca a matricula anterior
		cMatAnt := POSICIONE("BA1",2,XFILIAL("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_MATANT")
		//busca a matricula da vida
		cMatVid := POSICIONE("BA1",2,XFILIAL("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_MATVID")
    	//busca a empresa do usuario
    	cCodEmpUsu := POSICIONE("BA1",2,XFILIAL("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_CODEMP")
    	//busca dados do contrato e sub-contrato do usuario
    	cConEmp := POSICIONE("BA1",2,XFILIAL("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_CONEMP")
		cVerCon := POSICIONE("BA1",2,XFILIAL("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_VERCON")	
		cSubCon := POSICIONE("BA1",2,XFILIAL("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_SUBCON")
		cVerSub := POSICIONE("BA1",2,XFILIAL("BA1")+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO,"BA1_VERSUB")

        aArray1 := {}//zero o vetor a cada loop
		aAdd ( aArray1  , { {"FILIAL",XFILIAL("BAU")},;
		{"CODRDA",cCodRDA},;
		{"OPERDA",cOpeRDA},;
		{"CODINT",cCodInt},;  
		{"NOMINT",cNomInt},;
		{"DATA",IIF(ValType(&cMacroTab->BD6_DATPRO)=="D",&cMacroTab->BD6_DATPRO,STOD(&cMacroTab->BD6_DATPRO))},; 
		{"DATPRO",IIF(ValType(&cMacroTab->BD6_DATPRO)=="D",&cMacroTab->BD6_DATPRO,STOD(&cMacroTab->BD6_DATPRO))},; 
		{"HORPRO",&cMacroTab->BD6_HORPRO/*STRTRAN(substr(time(),1,5),":","")*/},;
		{"NOMUSR",&cMacroTab->BD6_NOMUSR},;
		{"TELEFO",cTelefone},;
		{"CODESP",cCodEsp},; 
		{"CODLOC",cLocalBB8},; 
		{"LOCAL",PAQ->PAQ_LOCATE},; 
		{"SIGLA",BAU->BAU_SIGLCR},;
		{"ESTCR",BAU->BAU_ESTCR},;  
		{"REGSOL",BAU->BAU_CONREG},;
		{"NOMSOL",BAU->BAU_NOME},;
		{"CDPFSO",BAU->BAU_CODBB0},;
		{"REGEXE",BAU->BAU_CONREG},; 
		{"TIPCON","1"},;  
		{"SEXO",cSexo},;
		{"ANOPAG",cAnoPag},;
		{"MESPAG",cMesPag},;
		{"MATANT",cMatAnt},;    
		{"MATVID",cMatVid},;
		{"OPEUSR",cCodInt},;
		{"TIPRDA",BAU->BAU_TIPPE},;
		{"MATRIC",&cMacroTab->BD6_MATRIC},;  
		{"TIPREG",&cMacroTab->BD6_TIPREG},;	   
		{"CPFRDA",BAU->BAU_CPFCGC},; 
		{"DIGITO",&cMacroTab->BD6_DIGITO},;
		{"NOMRDA",BAU->BAU_NOME},;  
		{"CODEMP",cCodEmpUsu},;  
		{"CONEMP",cConEmp},;
		{"VERCON",cVerCon},;
		{"SUBCON",cSubCon},;	
		{"VERSUB",cVerSub},;
		{"DATDIG",DDATABASE},;
		{"CODPAD","01"},;
		{"CODPRO",cCodProc},;
		{"TIPPRE",BAU->BAU_TIPPRE},;
		{"DTDIG1",DDATABASE},;
		{"VALOR" , nVlrIndRDA},;
		{"YVLTAP", nVlrIndRDA},;
		{"VLRAPR", nVlrIndRDA},;
		{"QTDAPR", 1},;
		{"QTDPRO", 1},;
		{"INDCLI", "Pagamento do Rateio dos auxiliares e dos internistas."},;
		{"BLOCPA", If(&cMacroTab->BD6_CODEMP == '0004','0','1')},;
		{"DESBPF", "RATEIO INTERNISTAS"},; 
		{"TIPSAI", "5"},;
		{"ORIMOV", "1"},; 
		{"DESLOC", cDesLocBB8},;
		{"ENDLOC", AllTrim(cBB8END)+"+"+AllTrim(cBB8NR_END)+"-"+AllTrim(cBB8COMEND)+"-"+AllTrim(cBB8BAIRRO)},; 
		{"MOTBPF", "999"},;     // INFORME O CODIGO DO BLOQUEIO DA COPARTICIPACAO DE ACORDO COM A TABELA DE BLOQUEIO  Na BD5 é MOTBPG
		{"TIPATE", "04"},; //}) //código 04 - Consulta
		{"CODPLA", &cMacroTab->BD6_CODPLA} })  //acrescentado em 05/10/11 por Renato Peixoto para atender especificacoes rateio AED. Alterado para pegar do vetor por Renato Peixoto. 
				
		//{"REGEXE", cCRMProf},;
		//{"OPEEXE", cOperProf},;
		//{"NOMEXE", cNomProf},; 
		//{"CDPFRE", cCodProf},; 
		//{"ESTEXE", cUFProf},; 
		//{"SIGEXE", cSiglaProf},;
		//{"REGPRE", cCRMProf},;
		//{"NOMPRE", cNomProf} }) 
		
		IncProc("Gravando Rateio Internistas...Processando RDA "+BAU->BAU_NOME+".")
		
		//Atualiza o conteudo da variavel cCodPla
		cCodPla := &cMacroTab->BD6_CODPLA       
		
	    //chama a rotina que vai gravar as guias do rateio dos internistas no contas médicas
	    //Begin Transaction
	    U_GERARATINT()
	    
	    //bloqueio o pagamento na BD5, BD6 e BD7 das guias incluidas manualmente pelo contas médicas com valor zerado.
	    DbSelectArea("BD5")
	    DbSetOrder(1)
	    If DbSeek(XFILIAL("BD5")+&cMacroTab->BD6_CODOPE+&cMacroTab->BD6_CODLDP+&cMacroTab->BD6_CODPEG+&cMacroTab->BD6_NUMERO)
	    	RecLock("BD5",.F.)
	    	BD5->BD5_BLOPAG := "1"
	    	BD5->BD5_DESBPG := "Bloqueado automaticamente pela rotina de rateio dos internistas."
	    	BD5->(MsUnlock())
	    EndIf
	    
	    DbSelectArea("BD6")
	    DbSetOrder(1)
	    If DbSeek(XFILIAL("BD6")+&cMacroTab->BD6_CODOPE+&cMacroTab->BD6_CODLDP+&cMacroTab->BD6_CODPEG+&cMacroTab->BD6_NUMERO)
	    	RecLock("BD6",.F.)
	    	BD6->BD6_BLOPAG := "1"
	    	BD6->BD6_DESBPG := "Bloqueado automaticamente pela rotina de rateio dos internistas."
	    	BD6->(MsUnlock())
	    EndIf
	    
	    DbSelectArea("BD7")
	    DbSetOrder(2)
	    BD7->(DbGotop())
	    If DbSeek(XFILIAL("BD7")+&cMacroTab->BD6_CODOPE+&cMacroTab->BD6_CODLDP+&cMacroTab->BD6_CODPEG+&cMacroTab->BD6_NUMERO)
	    	While !(BD7->(Eof())) .AND. (&cMacroTab->BD6_CODOPE+&cMacroTab->BD6_CODLDP+&cMacroTab->BD6_CODPEG+&cMacroTab->BD6_NUMERO = BD7->BD7_CODOPE+BD7->BD7_CODLDP+BD7->BD7_CODPEG+BD7->BD7_NUMERO)
	    		RecLock("BD7",.F.)
	    		BD7->BD7_BLOPAG := "1"
	    		BD7->BD7_DESBLO := "Bloqueado automaticamente pela rotina de rateio dos internistas."
	    		BD7->(MsUnlock())
	    		BD7->(DbSkip())
	    	EndDo
	    EndIf
	    
	    //Gravo o registro que acabei de gerar no contas medicas na tabela PAR, que eh uma tabela de controle para impedir a duplicidade no contas medicas
	    DbSelectArea("PAR")
	    DbSetOrder(1)
	    If !(DbSeek(XFILIAL("PAR")+cMesPag+cAnoPag+cCodRDA+cCodInt+&cMacroTab->BD6_CODEMP+&cMacroTab->BD6_MATRIC+&cMacroTab->BD6_TIPREG+&cMacroTab->BD6_DIGITO))
	    	
	    	RecLock("PAR",.T.)
	    	PAR->PAR_FILIAL  := XFILIAL("PAR")
	    	PAR->PAR_COMPET  := cMesPag+cAnoPag
	    	PAR->PAR_CODRDA  := cCodRDA
	    	PAR->PAR_CODINT  := cCodInt
	    	PAR->PAR_NOMINT  := cNomInt
	    	PAR->PAR_CODEMP  := &cMacroTab->BD6_CODEMP
	    	PAR->PAR_MATRIC  := &cMacroTab->BD6_MATRIC
	    	PAR->PAR_TIPREG  := &cMacroTab->BD6_TIPREG
	    	PAR->PAR_DIGITO  := &cMacroTab->BD6_DIGITO
	    	PAR->PAR_NOMUSR  := &cMacroTab->BD6_NOMUSR
	    	PAR->PAR_VLRRAT  := nVlrIndRDA
	    	PAR->PAR_AUXILI  := PAQ->PAQ_AUX
	    	PAR->PAR_USUSIS  := AllTrim(__cuserid)
	    	PAR->PAR_NOUSIS  := cUserName 
	    	PAR->PAR_CODOPE  := cCodInt
	    	PAR->PAR_CODLDP  := cCodLDP
	    	PAR->PAR_CODPEG  := cCodPEG
	    	PAR->PAR_NUMGUI  := cGuiaRAT
	    	PAR->(MsUnlock())
	    	
	    	lGerouRat := .T. //identifica que houve rateio ao menos para um internista
	    	
	    EndIf
	    	
	    //End Transaction
	    
		&cMacroTab->(DbSkip())
		
	EndDo
	
	//Altera o quantitativo gerado para a PEG que acabou de ser finalizada...
	cQuery5 := "SELECT Count(par_codrda) TOT_GUIAS "
	cQuery5 += "FROM "+RetSqlName("PAR")+" PAR "
	cQuery5 += "WHERE D_E_L_E_T_ = ' ' "
	cQuery5 += "AND par_filial = '"+XFILIAL("PAR")+"' "
	cQuery5 += "AND par_compet = '"+cMesPag+cAnoPag+"' "
	cQuery5 += "AND par_codrda = '"+cCodRDA+"' "
    
	If Select(cArqTotGui)>0
		(cArqTotGui)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery5),cArqTotGui,.T.,.T.)
	
	DbSelectArea("BCI")
	DbSetOrder(1)
	If DbSeek(XFILIAL("BCI")+cCodInt+cCodLDP+cCodPEG)
		If BCI->BCI_QTDEVE <> (cArqTotGui)->TOT_GUIAS
			RecLock("BCI",.F.)
			BCI->BCI_QTDEVE := (cArqTotGui)->TOT_GUIAS
			BCI->(MsUnlock())
		EndIf
	EndIf
	
	(cArqTotGui)->(DbCloseArea())
	//Fim alteracao totalizacao guias dentro da PEG. Renato Peixoto em 21/03/2012
	PAQ->(DbSkip())

	
EndDo

If lGerouRat
	MsgAlert("Rateio da RDA gerado. Verifique os resultados!")
Else
	MsgAlert("Não foi gerado rateio de internista para esta competência. Provavelmente este rateio já foi gerado anteriormente ou o sistema não encontrou nenhuma guia para estes internistas/auxiliares na competência informada. Favor verificar.")
EndIf


If Select(cAliasQry) > 0
	(cAliasQry)->(DbCloseArea())
EndIf

If lGerouRat
	
	If Select(&cMacroTab)> 0
		&cMacroTab->(DbCloseArea())
	EndIf
	
	If Select(_2cAliasQry) > 0
		(_2cAliasQry)->(DbCloseArea())
	EndIf
	
	If Select(_3cAliasQry) > 0
		(_3cAliasQry)->(DbCloseArea())
	EndIf
	
EndIf

Return           


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ CriaSX1  ³ Autor ³ Renato Peixoto        ³ Data ³ 22/06/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Cria/Atualiza perguntas.                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CriaSX1()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CriaSX1()

PutSx1(cPerg,"01",OemToAnsi("Mes Pgto:")     ,"","","mv_ch1","C",02,0,0,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será o mês de Pgto no formato mm"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Ano Pgto:")     ,"","","mv_ch2","C",04,0,0,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será o ano do Pgto no formato aaaa"},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("Data do Evento"),"","","mv_ch3","D",08,0,0,"G","","   ","","","mv_par03",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual será a data do evento que irá aparecer na guia"},{""},{""})

Return                           



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GERARATINTºAutor  ³Renato Peixoto      º Data ³  15/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera o rateio, incluindo uma guia para cada usuário que foi º±±
±±º          ³atendido pelos internistas.                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GERARATINT()

Local I__f := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL nH := PLSAbreSem("GERARATINT.SMF")
LOCAL cNumGuia
LOCAL nFor
LOCAL nAux
LOCAL nQ 
LOCAL aFiles
LOCAL cAliasAux
LOCAL nPos
LOCAL cAliasPri
LOCAL cCpoFase
LOCAL aStruARQ    := {}
LOCAL aHeaderBE2  := {}

LOCAL aRetCal     := PLSXVLDCAL(dDtEvento,cCodInt,.F.)    // Valida o calendario de pagamento da operadora
//Local aPar        := {}
Local aRetAux     := {}
LOCAL nHESP
Local cMacro 
LOCAL nStackSX8   := GetSx8Len()     

PRIVATE cFunGRV
PRIVATE cTipGRV
PRIVATE cTipoGuia
PRIVATE cGuiRel

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe o PEG eletronico do mes para o credenciado...         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("BCI")
BCI->(DbSetOrder(4))

If !(aRetCal[1])
	APMSGSTOP("Atenção, não existe calendario de pagamento para a data em questão ou os parâmetros de pagamento desse mês não foram configurados. Favor Verificar antes de realizar este processo.","Processo não pode ser realizado.")
	Return
EndIf

nHESP := PLSAbreSem("PLSPEG.SMF")
//Ordem 4 da BCI: BCI_FILIAL + BCI_OPERDA + BCI_CODRDA+ BCI_ANO + BCI_MES + BCI_TIPO + BCI_FASE + BCI_SITUAC + BCI_TIPGUI + BCI_CODLDP + BCI_ARQUIV                               
//If ! BCI->(DbSeek(xFilial("BCI")+cOpeRDA+cCodRDA+cAnoPag+cMesPag+"211"+"02"+"0001")) 
If ! BCI->(DbSeek(xFilial("BCI")+cOpeRDA+cCodRDA+cAnoPag+cMesPag+"211"+"02"+"0017")) 
	
	cNewPEG := PLSA175Cod(cOpeRDA,"0001")//GetNewPar("MV_PLSPEGE","0000"))
	
	BCI->(RecLock("BCI",.T.))
	BCI->BCI_FILIAL := xFilial("BCI")
	BCI->BCI_CODOPE := cOpeRDA
	BCI->BCI_PROTOC := CriaVar("BCI_PROTOC")
	BCI->BCI_CODLDP := '0017'//"0001" //GetNewPar("MV_PLSPEGE","0001")
	BCI->BCI_CODPEG := cNewPEG
	BCI->BCI_OPERDA := cOpeRDA
	BCI->BCI_CODRDA := cCodRDA//cOpeRDA  
	BCI->BCI_NOMRDA := cNomRDA
	BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
	BCI->BCI_TIPGUI := GetNewPar("MV_PLSTPGS","01")//GetNewPar("MV_PLSTPGC","01")  alterado para guia de serviços a pedido do Dr. Jose Paulo por Renato Peixoto.
	BCI->BCI_TIPPRE := BAU->BAU_TIPPRE
	
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
	//BCI->BCI_QTDGUI := 1
	BCI->BCI_VLRGUI := nValorRDA //REVER
	BCI->BCI_DATREC := dDataBase//Base
	//BCI->BCI_DTPRPG := ctod("")
	BCI->BCI_DTDIGI := dDtEvento
	BCI->BCI_QTDDIG := 1
	//BCI->BCI_VALDIG := 0 //REVER
	BCI->BCI_CODCOR := BCL->BCL_CODCOR
	BCI->BCI_FASE   := "1"
	BCI->BCI_SITUAC := "1"
	BCI->BCI_MES    := cMesPag
	BCI->BCI_ANO    := cAnoPag
	BCI->BCI_TIPO   := "2" 
	BCI->BCI_STATUS := "1"
	BCI->(MsUnLock())
	
	While GetSx8Len() > nStackSX8
		BCI->( ConfirmSX8() )
	EndDo
	
Else
	BCL->(DbSetOrder(1))
	BCL->(MsSeek(xFilial("BCL")+cOpeRDA+BCI->BCI_TIPGUI))
Endif
PLSFechaSem(nHESP,"PLSPEG.SMF")

cTipoGuia := BCL->(BCL_TIPGUI)
cGuiRel   := BCL->BCL_GUIREL
cFunGRV   := BCL->BCL_FUNGRV
cTipGRV   := BCL->BCL_TIPGRV
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do processo de gravacao das guias...                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFiles := PLSA500Fil(BCI->BCI_CODOPE,BCI->BCI_TIPGUI)

For nQ := 1 to Len(aArray1)  //Loop para gerar uma guia para cada ususario contido no array
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta os Objetivos...                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nFor := 1 To Len(aFiles)
		cAliasAux := aFiles[nFor,1]
		
		If Empty(cAliasPri)
			cAliasPri := aFiles[nFor,1]
			cNumGuia  := PLSA500NUM(cAliasPri,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
		Endif
		If aFiles[nFor,3] == "2"
			aStruARQ := (cAliasAux)->(DbStruct())
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta RegToMemory...                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Copy cAliasAux To Memory Blank
						
			//Dados fixos para todos os arquivos a serem procesados do contas medicas
			&("M->"+cAliasAux+"_CODOPE") := BCI->BCI_CODOPE
			&("M->"+cAliasAux+"_CODLDP") := BCI->BCI_CODLDP
			&("M->"+cAliasAux+"_CODPEG") := BCI->BCI_CODPEG
			&("M->"+cAliasAux+"_NUMERO") := cNumGuia
			&("M->"+cAliasAux+"_TIPGUI") := BCI->BCI_TIPGUI
			
			//Dados variados para cada arquivo que esta sendo processado
			For nAux := 1 To Len(aArray1[nQ])   //Processa a quantida de campos contidos no array do usuario em questao
				nPos := ascan(aStruARQ, {|x| alltrim(x[1]) = cAliasAux+"_"+aArray1[nQ,nAux,1]}) //ascan(aStruARQ,aArray1[nQ,nAux,1])   //Verifica se o campo a ser gravado nesta tabela corresponde ao do array
				If nPos > 0
					&("M->"+cAliasAux+"_"+aArray1[nQ,nAux,1]) := aArray1[nQ,nAux,2]
				Endif
			Next
			
			PLUPTENC(cAliasAux,K_Incluir)
		Else
			CONOUT("Gravacao de itens nao implementada") //
		Endif
	Next
Next

//Crio o vetor aHeaderBE2 com os dados do SX3 para os campos BE2_CODPAD, BE2_CODPRO e BE2_STATUS
DbSelectArea("SX3")
SX3->(DbSetOrder(1))
SX3->(dbSeek("BE2"))
_Recno := Recno()
Do While !Eof() .And. (X3_ARQUIVO == "BE2")
	If X3_CAMPO = "BE2_CODPAD" .or. X3_CAMPO = "BE2_CODPRO" .or. X3_CAMPO = "BE2_STATUS"
		Aadd(aHeaderBE2,{Trim(X3_TITULO), X3_CAMPO, X3_PICTURE, X3_TAMANHO, X3_DECIMAL,".T.", X3_USADO, X3_TIPO, X3_ARQUIVO, X3_CONTEXT})
	Endif
	dbSkip()
Enddo
DbGoto(_Recno)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa funcao de gravacao dos dados...                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cFunGRV)
	aPar   := {K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.,cAliasPri,"01","","1",{{cCodPad,cCodProc,"1"}}, aHeaderBE2 }//{K_Incluir,cOpeRDA,BCI->BCI_CODLDP,BCI->BCI_CODPEG,cNumGuia,.T.}
	cMacro := (AllTrim(cFunGRV)+"(aPar)")
	&(cMacro)
Endif

//Gravo os campos BD6_YVLTAP com o valor correspondente ao NUPRE e o campo QTDAPR
DbSelectArea("BD6")
RecLock("BD6",.F.)
BD6->BD6_YVLTAP := nVlrIndRDA
BD6->BD6_VLRAPR := nVlrIndRDA
//BD6->BD6_QTDAPR := 1   //DESCONTINUADO P12
BD6->BD6_QTDPRO := 1     

**'Beg - Comentado e alterado por Marcela Coimbra para não bloquear a copart para convenio 28/11/2014'**
//BD6->BD6_BLOCPA := "1"
BD6->BD6_BLOCPA := If(BD6->BD6_CODEMP == '0004','0','1')//"1"                              
**'Fim - Comentado e alterado por Marcela Coimbra para não bloquear a copart para convenio 28/11/2014'**      

BD6->BD6_DESBPF := "RATEIO INTERNISTAS"
BD6->BD6_MOTBPF := "501"

//Renato Peixoto em 11/07/12: Verifico se foi gravado na BD6 o codigo do plano correto. Se nao gravou, atualizo com o plano correto.
If BD6->BD6_CODPLA <> cCodPla
	BD6->BD6_CODPLA := cCodPla
EndIf

BD6->(MsUnlock())

//Verifico na BD7 se foi gravado o plano corretamente e altero se necessario
If BD7->BD7_CODPLA <> cCodPla
	RecLock("BD7",.F.)
	BD7->BD7_CODPLA := cCodPla
	BD7->(MsUnlock())
EndIf
//Fim alteração Renato Peixoto. 

 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Muda a fase da guia...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCpoFase := (cAliasPri+"->"+cAliasPri+"_FASE")

If !Empty(BCL->BCL_FUNMFS)
     
     //Leonardo Portella - 14/10/13 - Inicio - Virada P11: alteracao nos parametros. Incluido vetor de glosas
     
     aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri,{}}
     //aPar   := {cAliasPri,"1",cOpeRDA,cTipoGuia,&cCpoFase,BCI->BCI_CODLDP,BCI->BCI_CODPEG,BCL->BCL_GUIREL,.T.,dDataBase,.F.,,,,,cAliasPri}
         
     //Leonardo Portella - 14/10/13 - Fim
     
     cMacro := (AllTrim(BCL->BCL_FUNMFS)+"(aPar)")
     aRetAux := &(cMacro)
Endif 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza transacao fisica...                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PLSFechaSem(nH,"GERARATINT.SMF")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//alimento as variáveis para controle no espelho do rateio
cCodPEG := BCI->BCI_CODPEG
cGuiaRat := cNumGuia

Return .T.
