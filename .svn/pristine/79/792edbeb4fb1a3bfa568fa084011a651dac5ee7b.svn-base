#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR050  ³ Autor ³ Leonardo Portella    ³ Data ³ 19/07/2011 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de beneficiarios que estao nao estao aptos a     |±±
±±³          ³ terem a carteirinha gerada e o motivo.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR050

Local oReport 
Private cPerg	:= "CABR050"  

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
Local oUsr
Local oUsr2
Local oUsr3
Local oCompet

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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport	:= TReport():New("CABR050","Relatorio de usuários X emissão carteirinha",cPerg, {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de de usuários X emissão carteirinha")

*'-----------------------------------------------------------------------------------'*
*'Solução para impressão em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espaçamento entre colunas. 
oReport:SetLandscape() //Impressão em paisagem.  

*'-----------------------------------------------------------------------------------'*

oUsr := TRSection():New(oReport,"Relatorio de usuários X emissão carteirinha")
oUsr:SetTotalInLine(.F.)   
 
nTamMatric := TamSx3('BA1_CODINT')[1] + TamSx3('BA1_CODEMP')[1] + TamSx3('BA1_MATRIC')[1] + TamSx3('BA1_TIPREG')[1] + TamSx3('BA1_DIGITO')[1] + 4

TRCell():New(oUsr ,'MATRIC'		,		,'Matricula'			,/*Picture*/	,nTamMatric		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_NOMUSR'	,'BA1'	,						,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_CPFUSR'	,'BA1'	,						,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_DATNAS'	,'BA1'	,						,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'VALIDADE'	,		,'Dt. Validade'			,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_DESGRA'	,'BA1'	,'Parentesco'			,/*Picture*/	,15				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_YDTLIM'	,'BA1'	,						,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

//Leonardo Portella - 12/04/12 - Inclusao da via
TRCell():New(oUsr ,'BA1_VIACAR'	,'BA1'	,'Via de carteira'		,/*Picture*/	,/*tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

TRCell():New(oUsr ,'CRITICA'	,    	,'Crítica'				,/*Picture*/	,65				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'TIPOCRITIC'	,    	,'Motivo Crít.'			,/*Picture*/	,8				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		) // em 11.07.2014 - OSP Chamado 12315
//TRCell():New(oUsr ,'TIPOCRITIC'	,    	,'Tipo Crít.'			,/*Picture*/	,8				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

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

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local oBreak01
Local cPosTit   	:= alltrim(GetNewPar("MV_PLPOSTI","1")) // 1-titulos em aberto  2-titulos em aberto/baixados
Local nTits  		:= 0
Local cCodCli   	:= ""
Local cLoja     	:= ""
Local cNivCob		:= ""
Local aDadUsr
Local nMesLim 		:= 2 //Quantidade de meses a considerar a partir da data do subcontrato  
Local nMes			:= Month(dDataBase) + nMesLim
Local cMes			:= strZero( If( nMes > 12, nMes % 12, nMes ),2 )
Local cAno			:= cValToChar( If( nMes > 12, Year(dDataBase) + 1, Year(dDataBase) ) )  
Local dLimite 		:= StoD(cAno + cMes + strZero(Day(dDataBase),2))
Local nTitAtrMax	:= GetNewPar("MV_YQATRE1",1)
Local cEstIni		:= mv_par01
Local cEstFim		:= mv_par02
Local cMunicDe 		:= mv_par03
Local cMunicAte		:= mv_par04
Local cMatUsrD      := mv_par06
Local cMatUsrA      := mv_par07
Local cGrpEmpresa	:= mv_par08
//Local cNomeIni		:= Upper(cLetraDe) + Space(TamSx3('BTS_NOMUSR')[1] - 1)
//Local cNomeFim		:= Upper(cLetraAte) + Replicate('Z',TamSx3('BTS_NOMUSR')[1] - 1)
Local cMatrD		:= Substr(cMatUsrD,9,6)
Local cMatrA		:= Substr(cMatUsrA,9,6)
Local lCritBloq		:= .T.

Private oUsr   		:= oReport:Section(1)
Private cAlias  	:= GetNextAlias()
Private cQuery		:= ''
Private nCont		:= 0

oReport:SetMeter(0)

For i := 1 to 5 
	oReport:SetMsgPrint("Selecionando registros...")
	oReport:IncMeter()
Next

cQuery := "SELECT BA1_DATNAS,BA1_DATINC,BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DIGITO,BA1_NOMUSR,BA1_TIPUSU,BA1_TIPUSU,BA1_ESTCIV,"	+ CRLF
cQuery += "  BA1_DATCAR,BA1_VIACAR,BA1_OPERES,BA1_SEXO,BA1_CODPLA,BA1_GRAUPA,BA3_TIPOUS,BA1_CPFUSR,BA1_YDTLIM,BA1_CONEMP,BA1_SUBCON,BA1_DATBLO,"+ CRLF
cQuery += "  BA1_DTVLCR,BA3_VALID, BA1_EMICAR " 																												+ CRLF
cQuery += "FROM " + RetSqlName('BA1') + " BA1" 																									+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3.D_E_L_E_T_ = ' '"						 											+ CRLF
cQuery += "  AND BA3_FILIAL = '" + xFilial('BA3') + "'"																							+ CRLF
cQuery += "  AND BA3_CODINT = BA1_CODINT" 																										+ CRLF
cQuery += "  AND BA3_CODEMP = BA1_CODEMP" 																										+ CRLF
cQuery += "  AND BA3_MATRIC = BA1_MATRIC" 																										+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BTS') + " BTS ON BTS.D_E_L_E_T_ = ' '" 																	+ CRLF
cQuery += "  AND BA1_MATVID = BTS_MATVID"																										+ CRLF
cQuery += "  AND BTS_FILIAL = '" + xFilial('BTS') + "'"																							+ CRLF
cQuery += "WHERE BA1.D_E_L_E_T_ = ' '"						 																					+ CRLF
cQuery += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'"																							+ CRLF
//cQuery += "  AND BA1_IMAGE = 'ENABLE'"   																											+ CRLF // em 20.03.2014 por OSP
//cQuery += "	 AND BTS_NOMUSR BETWEEN '" + cNomeIni + "' AND '" + cNomeFim + "'"																	+ CRLF
cQuery += "	 AND BTS_CODMUN BETWEEN '" + cMunicDe + "' AND '" + cMunicAte + "'"	 																+ CRLF
cQuery += "	 AND BTS_ESTADO BETWEEN '" + cEstIni + "' AND '" + cEstFim + "'"	 																+ CRLF
//cQuery += "	 AND BA1_CODEMP || BA1_MATRIC = ' '"																			  					+ CRLF // em 20.03.2014 por OSP
cQuery += "	 AND BA1_MOTBLO = ' '"															   								  					+ CRLF 
cQuery += "	 AND BA1_CODEMP = '" + cGrpEmpresa + "'" 								 															+ CRLF

If !empty(mv_par10) .and. !empty(mv_par11)
	cQuery += "	 AND (	BA1_DTVLCR BETWEEN '" + DtoS(mv_par10) + "' AND '" + DtoS(mv_par11) + "' OR " 											+ CRLF
	cQuery += "	 		(BA1_DTVLCR = ' ' AND BA3_VALID BETWEEN '" + DtoS(mv_par10) + "' AND '" + DtoS(mv_par11) + "'))"						+ CRLF
EndIf

If  cMatUsrD >= cMatUsrA .AND. ( !empty(cMatUsrD) .AND. !empty(cMatUsrA) )
	cQuery 	+= "	AND BA1_MATRIC BETWEEN '" + cMatrD + "' AND '" + cMatrA + "' "		                     									+ CRLF
EndIf

cQuery 	+= "ORDER BY BA1_NOMUSR"																												+ CRLF

TcQuery cQuery New Alias cAlias

cAlias->(dbGoTop())

nCont := 0

COUNT TO nCont     

cAlias->(dbGoTop())

oReport:SetMeter(nCont) 

cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0
nCrit	:= 0

oUsr:init()

While !( cAlias->(Eof()) )

	If oReport:Cancel()  

	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)

	    exit

	EndIf

	oReport:SetMsgPrint("Verificando usuário " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot + " (Criticados: " + allTrim(Transform(nCrit,'@E 999,999,999,999')) + ")")
	oReport:IncMeter()

	nIdadeFut	:= nCalcIdade(StoD(cAlias->BA1_DATNAS), dLimite)
	lDepend		:= cAlias->BA1_TIPUSU == 'D'  
	lMater		:= cAlias->BA1_CODPLA == '0001'
	lGrauPar	:= cAlias->BA1_GRAUPA $ '05|06|12|13|23|24' //(BRP) Graus de parentesco aos quais se aplica a regra
	cCodInt		:= cAlias->BA1_CODINT
	cCodEmp		:= cAlias->BA1_CODEMP
	cMatrUs		:= cAlias->BA1_MATRIC
	cConEmp   	:= cAlias->BA1_CONEMP
	cSubCon   	:= cAlias->BA1_SUBCON
	
	//INICIO DAS CRITICAS
    
	lCritBloq	:= .T.
	lCritica 	:= .F.
	cCritica 	:= ""
    
    If !empty(cAlias->BA1_DATBLO) .and. StoD(cAlias->BA1_DATBLO) <= dLimite
		lCritica 	:= .T.
		cCritica 	:= "Data de bloqueio (" + DtoC(StoD(cAlias->BA1_DATBLO)) + ") menor ou igual a data limite (" + DtoC(dLimite) + ")"
    EndIf
    
    If ( lMater .and. lDepend .and. lGrauPar .and. nIdadeFut >= 24 ) .and. !lCritica
    	lCritica 	:= .T.
		cCritica 	:= "Mater, dependente, parentesco (" + allTrim(posicione('BRP',1,xFilial('BRP')+cAlias->BA1_GRAUPA,'BRP_DESCRI')) + ") e " + ;
		"idade >= a 24 anos (em " + DtoC(dLimite) + ")"
	EndIf                                                             

	If ( !empty(cAlias->BA1_YDTLIM) .and. dLimite > StoD(cAlias->BA1_YDTLIM) ) .and. !lCritica
    	lCritica 	:= .T.
		cCritica 	:= "Data limite superior ao parametrizado - BA1_YDTLIM:" + cAlias->(DtoC(StoD(cAlias->BA1_YDTLIM))) + "; data cálculo: " + DtoC(dLimite)
	EndIf
  
    // em 11.07.2014 - OSP chamado 12315
	/*
	If ( cEmpAnt == "02" .and. cGetNivel(cCodInt, cCodEmp, cMatrUs) < "4" ) .and. !lCritica
    	lCritica 	:= .T.
		cCritica 	:= "Empresa INTEGRAL e nível de cobrança menor que 4"
		lCritBloq 	:= .F.
	EndIf
    */
    
	**'Marcela Coimbra'**
	
	If cAlias->(BA1_EMICAR) == '0'
    	lCritica 	:= .T.
		cCritica 	:= "Marcado para NUNCA EMITIR"
		lCritBloq 	:= .T.
	EndIf

	**'Fim Marcela Coimbra'**

	aDadUsr 	:= PLSDADUSR(cAlias->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),"1",.F.,dDataBase,nil,nil,nil)

	If !aDadUsr[1] .and. !lCritica
    	lCritica 	:= .T.
	    cCritica 	:= "Usuário inválido"
    EndIf    
    
    // em 11.07.2014 - OSP chamado 12315
    If cAlias->BA1_TIPUSU = 'D' .AND. cAlias->BA1_ESTCIV $ 'C,M' .AND. cAlias->BA1_YDTLIM <> ' ' 
       lCritica     := .T.
       cCritica     := "Conjuge, Dependente com DATA LIMITE"
       lCritBloq    := .T.
    EndIf
        
    If !lCritica
    
    	cCodCli := aDadUsr[58]
		cLoja   := aDadUsr[59]
		cNivCob	:= aDadUsr[61]
	
		If cPosTit == "1" // considerar apenas titulos em aberto
	
		    SE1->(dbSetOrder(8))
	
		    If SE1->(MsSeek(xFilial("SE1")+cCodCli+cLoja+"A"))
	
		       While ! SE1->(Eof()) .And. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_STATUS) == xFilial("SE1")+cCodCli+cLoja+"A"
	
		          If DtoS(dDataBase) > DtoS(SE1->E1_VENCREA)
	
		             If ( cNivCob >= "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_MATRIC) == cCodInt+cCodEmp+cMatrUs ) .Or. ;
		                ( cNivCob <  "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_CONEMP+E1_SUBCON) == cCodInt+cCodEmp+cConEmp+cSubCon )
	
		                nTits     += 1
	
		             EndIf   
	
		          EndIf
	
		          SE1->(DbSkip())
	
		       EndDo
		
		    EndIf
		
		Else  //Considerar titulos em aberto/baixados
		
		    dDatIni := dDataBase - 365 // verifica ate 1 anos atraso
		
		    SE1->(dbSetOrder(8))
		
		    If SE1->(MsSeek(xFilial("SE1") + cCodCli + cLoja))
		
		       While ! SE1->(Eof()) .And. SE1->(E1_FILIAL + E1_CLIENTE + E1_LOJA) == xFilial("SE1") + cCodCli + cLoja
		
		          If DtoS(dDataBase) > DtoS(SE1->E1_VENCREA) .and. DtoS(dDatIni) <= DtoS(SE1->E1_EMISSAO)
		
		             If ( BA3->BA3_TIPOUS == "1" .And. SE1->(E1_CODINT + E1_CODEMP + E1_MATRIC) == cCodInt + cCodEmp + cMatrUs ) .or. ;
		                ( BA3->BA3_TIPOUS == "2" .And. SE1->(E1_CODINT + E1_CODEMP) == cCodInt + cCodEmp )
		
		                If SE1->E1_SALDO > 0
		                    nTits += 1
		                EndIf
		
		             EndIf
		
		          EndIf
		
		          SE1->(DbSkip())
		
		       EndDo
		
		    EndIf
		    	
		EndIf

	EndIf
		
	If nTits > nTitAtrMax .and. !lCritica
    	lCritica 	:= .T.
		cCritica 	:= "Usuário inadimplente: títulos em aberto (" + cValToChar(nTits) + "), máximo permitido (" + cValToChar(nTitAtrMax) + ")"
	EndIf           
	
	nTits  	:= 0
	
	If lCritica
		++nCrit
	EndIf
    
	//FIM DAS CRITICAS
	     
    lImpSoCrit := mv_par09 == 2 //Imprime somente com criticas     1=Nao ; 2=Sim    
    
    If ( lImpSoCrit .and. lCritica ) .or. !lImpSoCrit 
    
 		oUsr:Cell('MATRIC'		):SetValue(cAlias->(BA1_CODINT + '.' + BA1_CODEMP + '.' + BA1_MATRIC + '.' + BA1_TIPREG + '-' + BA1_DIGITO))
	    oUsr:Cell('BA1_NOMUSR'	):SetValue(cAlias->(BA1_NOMUSR))
		oUsr:Cell('BA1_CPFUSR'	):SetValue(cAlias->(BA1_CPFUSR))
		oUsr:Cell('BA1_DATNAS'	):SetValue(DtoC(StoD(cAlias->(BA1_DATNAS))))
		oUsr:Cell('BA1_DESGRA'	):SetValue(Posicione("BRP",1,xFilial("BRP") + cAlias->(BA1_GRAUPA),"BRP_DESCRI")			)
		oUsr:Cell('BA1_YDTLIM'	):SetValue(DtoC(StoD(cAlias->(BA1_YDTLIM))))
		
		//Leonardo Portella - 12/04/12 - Inclusao da via
		oUsr:Cell('BA1_VIACAR'	):SetValue(cValToChar(cAlias->(BA1_VIACAR)))
		
		If !empty(cAlias->(BA1_DTVLCR)) 
			oUsr:Cell('VALIDADE'	):SetValue(DtoC(StoD(cAlias->(BA1_DTVLCR))))
		Else
		   	oUsr:Cell('VALIDADE'	):SetValue(DtoC(StoD(cAlias->(BA3_VALID))))
		EndIf
		
		oUsr:Cell('CRITICA'		):SetValue(If(lCritica,cCritica,'-'))
		oUsr:Cell('TIPOCRITIC'	):SetValue(If(lCritica,If(lCritBloq,'BLOQUEIA','LIBERA'),'-'))
		
		oUsr:PrintLine()
	 	
	EndIf
	 	
	cAlias->(dbSkip())
	
EndDo

oUsr:Finish()
	 	
cAlias->(dbCloseArea())

Return   

********************************************************************************************************************************

Static Function cGetNivel(cCodInt, cCodEmp, cMatrUs)

Local a_BA1Area := BA1->( GetArea() )
Local a_BA3Area := BA3->( GetArea() )
Local c_Nivel := "10"
                
dbSelectArea("BA1")
dbSetOrder(1)
MsSeek( xFilial("BA1") + cCodInt + cCodEmp + cMatrUs)                           

dbSelectArea("BA3")
dbSetOrder(1)
MsSeek( xFilial("BA3") + cCodInt + cCodEmp + cMatrUs )

aCliente := PLSRETNCB(cCodInt, cCodEmp, cMatrUs, NIL)

c_Nivel := aCliente[5]

RestArea( a_BA1Area )
RestArea( a_BA3Area )

Return c_Nivel

******************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta as perguntas do SX1                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()  

aAdd(aHelp, "Estado (Unidade Federativa) inicial")      
PutSX1(cPerg , "01" , "Do Estado" 		,"","","mv_ch1","C",TamSx3('A1_EST')[1]		,0,0,"G",""	,"12"		,"","","mv_par01",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Estado (Unidade Federativa) final")      
PutSX1(cPerg , "02" , "Até o Estado" 	,"","","mv_ch2","C",TamSx3('A1_EST')[1]		,0,0,"G",""	,"12"		,"","","mv_par02",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o municipio inicial")      
PutSX1(cPerg , "03" , "Município de" 	,"","","mv_ch3","C",TamSx3('BTS_CODMUN')[1]		,0,0,"G",""	,"B57PLS"	,"","","mv_par03",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o municipio final")      
PutSX1(cPerg , "04" , "Município até" 	,"","","mv_ch4","C",TamSx3('BTS_CODMUN')[1]		,0,0,"G",""	,"B57PLS"	,"","","mv_par04",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a operadora do usuario")      
aAdd(aHelp, "(4 primeiros digitos da matricula)")      
PutSX1(cPerg , "05" , "Operadora"  		,"","","mv_ch5","C",TamSx3('BD7_OPEUSR')[1]	,0,0,"G",""	,""			,"","","mv_par05",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

//MATUSR -> consulta especifica
aHelp := {}
aAdd(aHelp, "Informe a matricula do usuario.")      
aAdd(aHelp, "Caso este parametro esteja em")      
aAdd(aHelp, "branco, sera ignorado.")      
PutSX1(cPerg , "06" , "Matríc usuário De" 	,"","","mv_ch6","C",TamSx3('BE4_USUARI')[1],0,0,"G",""	,"MATUSR"	,"","","mv_par06",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a matricula do usuario.")      
aAdd(aHelp, "Caso este parametro esteja em")      
aAdd(aHelp, "branco, sera ignorado.")      
PutSX1(cPerg , "07" , "Matríc usuário Ate" 	,"","","mv_ch7","C",TamSx3('BE4_USUARI')[1],0,0,"G",""	,"MATUSR"	,"","","mv_par07",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

/*
aHelp := {}
aAdd(aHelp, "Informe letra inicial do nome")      
aAdd(aHelp, "do beneficiario.")      
PutSX1(cPerg,"07","Letra inicial de"		,"","","mv_ch7","C",01						,0,0,"G","","" ,"","","mv_par07",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe letra inicial do nome")      
aAdd(aHelp, "do beneficiario.")      
PutSX1(cPerg , "08" , "Letra inicial até" 	,"","","mv_ch8","C",01						,0,0,"G","",""	,"","","mv_par08",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)
*/
aHelp := {}
aAdd(aHelp, "Informe o grupo de empresas")      
PutSX1(cPerg , "08" , "Grupo de empresas" 	,"","","mv_ch8","C",TamSx3('BA1_CODEMP')[1],0,0,"G","",""	,"","","mv_par08",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Imprime somente com críticas?")      
PutSX1(cPerg , "09" , "Somente criticas" 	,"","","mv_ch9","N",1						,0,1,"C","",""	,"","","mv_par09","Não"			,"","","","Sim"		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de validade inicial")      
aAdd(aHelp, "Caso nao seja informado sera")      
aAdd(aHelp, "desconsiderado")      
PutSX1(cPerg , "10" , "Validade inicial" 	,"","","mv_cha","D",8						,0,0,"G","",""	,"","","mv_par10",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de validade final")      
aAdd(aHelp, "Caso nao seja informado sera")      
aAdd(aHelp, "desconsiderado")      
PutSX1(cPerg , "11" , "Validade final" 		,"","","mv_chb","D",8						,0,0,"G","",""	,"","","mv_par11",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return   

******************************************************************************************************************************



