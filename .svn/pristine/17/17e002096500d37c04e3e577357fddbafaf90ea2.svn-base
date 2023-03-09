#include "PROTHEUS.CH"
#include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR053  ³ Autor ³ Leonardo Portella    ³ Data ³ 31/08/2011 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de reajuste de beneficiarios na data informada,  |±±
±±³          ³ com o calculo da idade do usuario na data informada.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR053           

Local oReport 
Private cPerg	:= "CABR053"  

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
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef()

Local oReport 
Local oUsr     

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

oReport	:= TReport():New("CABR053","Reajuste de beneficiarios na data informada","CABR053", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de reajuste de beneficiarios na data informada")

*'-----------------------------------------------------------------------------------'*
*'SoluÃ§Ã£o para impressÃ£o em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //EspaÃ§amento entre colunas. 
oReport:SetLandscape() //ImpressÃ£o em paisagem.  
//oReport:SetPortrait() //ImpressÃ£o em retrato.  

*'-----------------------------------------------------------------------------------'*

oUsr := TRSection():New(oReport,"Reajuste de beneficiarios na data informada")
oUsr:SetTotalInLine(.F.)   
 
nTamMatric 	:= TamSx3('BA1_CODINT')[1] + TamSx3('BA1_CODEMP')[1] + TamSx3('BA1_MATRIC')[1] + TamSx3('BA1_TIPREG')[1] + TamSx3('BA1_DIGITO')[1] + 4
cPicture 	:= '@E 999,999,999,999.99'

TRCell():New(oUsr ,'MATRIC'		,		,'Matricula'		 					,/*Picture*/	,nTamMatric		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_NOMUSR'	,'BA1'	,										,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'IDADE_DATA'	,		,'Idade na data'   						,/*Picture*/	,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'VLR_ANTES'	,		,'Valor	antes'							,cPicture		,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'VLR_APOS'	,		,'Valor	após'	   						,cPicture		,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'INDICE'		,		,'Indice'		   						,cPicture		,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'OBS'		,		,'Obs'	 								,/*Picture*/	,30				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'STATUS'		,		,'Status'		   						,/*Picture*/	,50				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BLOQUEADO'	,		,'Bloqueado (' + DtoC(dDatabase) + ')'	,/*Picture*/	,50				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oUsr:SetTotalText("Total geral")

TRFunction():New(oUsr:Cell("BA1_NOMUSR")  		,NIL,"COUNT"	,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)
TRFunction():New(oUsr:Cell("VLR_ANTES")  		,NIL,"SUM"  	,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)
TRFunction():New(oUsr:Cell("VLR_APOS")  		,NIL,"SUM" 		,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)

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

Local oBreak01                             

Private oUsr   		:= oReport:Section(1)
Private cAliasEleg 	:= GetNextAlias()
Private cQuery		:= ''
Private nCont 		:= 0
Private aReajuste	:= {}
Private aReajAnt	:= {} 	
Private SEMAFORO 	:= '' 
Private lContinua	:= .F.

Processa({||nCont := FilTRep()},"Grupo Caberj")

//Se nao tiver esta linha, nÃ£o imprime os dados
oUsr:init()

oReport:SetMeter(nCont) 

cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       
nCritic	:= 0

While !( cAliasEleg->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Analisando dados do usuário " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot + '... (Criticados: ' + allTrim(Transform(nCritic,'@E 999,999,999,999')) + ')')
	oReport:IncMeter()

	cMatUsr := cAliasEleg->(BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO)

	//Busco por reajustes no usuario
	aReajuste := GetReajUsr(cMatUsr)
	
	//Se nao encontrei reajuste no usuario, busco por reajuste na familia
	If empty(aReajuste)
		aReajuste := GetReajFam(cMatUsr)		
	EndIf

	//Achei o rejuste e agora vou buscar pelo reajuste anterior, do usuario, para comparar.
	If !empty(aReajuste)
		aReajAnt := GetReajUsr(cMatUsr,.T.)	
		
		//Se nao encontrei reajuste no usuario, agora vou buscar pelo reajuste anterior, da familia, para comparar.			
		If empty(aReajAnt)
			aReajAnt := GetReajFam(cMatUsr,.T.)
			
			//Se nao encontrei reajuste na familia, agora vou buscar pela ultima mensalidade paga, para comparar.			
			If empty(aReajAnt)
				aReajAnt := GetMensPaga(cMatUsr)
			EndIf			
		EndIf
	EndIf                 

	cStatus := ''
	lOk 	:= .F.
	
	Do Case 
	
		Case !empty(aReajuste) .and. !empty(aReajAnt)
			nPercReaj := Round(((aReajuste[2]/aReajAnt[2]) - 1) * 100,2)
			
			If nPercReaj > 0 
				If !empty(mv_par06) .and. nPercReaj > mv_par06
					cStatus := 'REAJUSTADO MAIOR QUE O LIMITE INFORMADO'
				ElseIf !empty(mv_par06) .and. nPercReaj < mv_par06
					cStatus := 'REAJUSTADO MENOR QUE O LIMITE INFORMADO'
				Else
					cStatus := 'REAJUSTADO' 
					lOk 	:= .T.
				EndIf
			ElseIf aReajAnt[2] == 0
				nPercReaj *= -1
				cStatus := 'ERRO - VALOR ANTERIOR ZERADO'
			Else
				cStatus := 'ERRO - VALOR ANTES MENOR OU IGUAL AO POSTERIOR'
			EndIf	
		
		Case !empty(aReajuste) .and. empty(aReajAnt)
			cStatus := 'REAJUSTADO SEM PAGAMENTO ANTERIOR'
			lOk 	:= .T.
			
		Case empty(aReajuste) .and. empty(aReajAnt)
			cStatus := 'ERRO - ELETIVO SEM REAJUSTE'
		
	EndCase                                                     
	
	If !lOk
		++nCritic
	EndIf
	
	If mv_par05 != 1//Nao for todos
		If (mv_par05 == 2 .and. lOk) .or. (mv_par05 == 3 .and. !lOk)//(Somente erros e esta Ok) ou (somente Ok e nao esta Ok)
			cAliasEleg->(dbSkip())
			loop			
		EndIf
	EndIf 
	
	oUsr:Cell('MATRIC'		):SetValue(cAliasEleg->(BA1_CODINT + '.' + BA1_CODEMP + '.' + BA1_MATRIC + '.' + BA1_TIPREG + '-' + BA1_DIGITO))
	oUsr:Cell('BA1_NOMUSR'	):SetValue(cAliasEleg->(BA1_NOMUSR))
	oUsr:Cell('IDADE_DATA'	):SetValue(cAliasEleg->(IDADE))
	
	If !empty(aReajAnt)
		oUsr:Cell('VLR_ANTES'	):Show()
		oUsr:Cell('VLR_ANTES'	):SetValue(aReajAnt[2])
	Else
		oUsr:Cell('VLR_ANTES'	):Hide() 
		oUsr:Cell('VLR_ANTES'	):SetValue(0)//Se nao zerar, o TReport totaliza errado	
	EndIf
	
	If !empty(aReajuste)
		oUsr:Cell('VLR_APOS'	):Show()
		oUsr:Cell('VLR_APOS'	):SetValue(aReajuste[2])
	Else
		oUsr:Cell('VLR_APOS'	):Hide()
		oUsr:Cell('VLR_APOS'	):SetValue(0)//Se nao zerar, o TReport totaliza errado
	EndIf
	
	If !empty(aReajuste) .and. !empty(aReajAnt)
		oUsr:Cell('INDICE'		):Show()  
		oUsr:Cell('INDICE'		):SetValue(nPercReaj)
		oUsr:Cell('OBS'	   		):Show()
		oUsr:Cell('OBS'	   		):SetValue(aReajuste[1] + '/' + aReajAnt[1])
	Else 
		oUsr:Cell('OBS'	   		):Hide()
		oUsr:Cell('INDICE'		):Hide()
	EndIf   
	
	oUsr:Cell('STATUS'		):SetValue(cStatus)
	
	oUsr:Cell('BLOQUEADO'	):SetValue(cAliasEleg->(BLOQUEADO))
		    
	oUsr:PrintLine()
	
    cAliasEleg->(dbSkip())
    
    aReajuste 	:= {}
    aReajAnt	:= {}

EndDo

oUsr:Finish()

cAliasEleg->(dbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

ProcRegua(0)

For i := 0 to 5
	IncProc('Selecionando registros...')
Next

cQuery := "SELECT 'ELEGIVEL' IDENTIFICADOR,BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DIGITO,BA1_NOMUSR,"		+ CRLF
cQuery += "  IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),TO_DATE('" + DtoS(mv_par01) + "','YYYYMMDD')) IDADE," 		+ CRLF
cQuery += "  DECODE(BA1_IMAGE,'DISABLE','SIM','ENABLE','NÃO') BLOQUEADO"											+ CRLF
cQuery += "FROM " + RetSqlName('BA3') + " BA3"																		+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '"										+ CRLF
cQuery += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'"																+ CRLF
cQuery += "  AND BA1_CODINT = BA3_CODINT"																			+ CRLF
cQuery += "  AND BA1_CODEMP = BA3_CODEMP"																			+ CRLF
cQuery += "  AND BA1_MATRIC = BA3_MATRIC"	   																		+ CRLF
cQuery += "  AND (BA1_TIPUSU = 'T' OR BA1_TIPREG = '00')"  															+ CRLF
cQuery += "  AND BA1_DATINC <= '" + DtoS(mv_par01) + "'"  															+ CRLF
cQuery += "WHERE BA3.D_E_L_E_T_ = ' '"	   																			+ CRLF
cQuery += "  AND BA3_FILIAL = '" + xFilial('BA3') + "'"																+ CRLF
cQuery += "  AND BA3_CONEMP BETWEEN '" + mv_par07 + "' AND '" + mv_par08 + "'"										+ CRLF     
cQuery += "  AND BA3_SUBCON BETWEEN '" + mv_par09 + "' AND '" + mv_par10 + "'"										+ CRLF     

//Somente na Caberj
If cEmpAnt == '01'
	cQuery += "  AND BA3_CODEMP IN ('0001','0002','0003','0005','0006','0010')"	 									+ CRLF
EndIf
	
cQuery += "  AND BA3_MESREA = '" + StrZero(Month(mv_par01),2) + "'"												+ CRLF
cQuery += "  AND (TO_DATE('" + DtoS(mv_par01) + "','YYYYMMDD') - TO_DATE(TRIM(BA3_DATCIV),'YYYYMMDD')) >= 365" 		+ CRLF
cQuery += "  AND BA1_CODINT = '" + mv_par02 + "'" 																	+ CRLF
cQuery += "  AND BA1_CODEMP BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"										+ CRLF

cQuery += "ORDER BY BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DIGITO,BA1_NOMUSR"	   							+ CRLF

TcQuery cQuery New Alias cAliasEleg

cAliasEleg->(dbGoTop())

nCont := 0

cAliasEleg->(dbEval({||++nCont}))

cAliasEleg->(dbGoTop())

Return nCont

********************************************************************************************************************************

//Retorna um array com os dados do reajuste do usuario, se existir.

Static Function GetReajUsr(cMatUsr,lMesAnterior)

Local aRet 			:= {}
Local cAlReajUsr 	:= GetNextAlias()

Default lMesAnterior := .F.

cQryUsr := "SELECT 'REAJUSTE USUARIO' IDENTIFICADOR,BDK_CODFAI,BDK_VALOR," 																		+ CRLF
cQryUsr += "  IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),TO_DATE('" + DtoS(mv_par01) + "','YYYYMMDD')) IDADE" 									+ CRLF
cQryUsr += "FROM " + RetSqlName('BHO') + " BHO" 																				  				+ CRLF
cQryUsr += "INNER JOIN " + RetSqlName('BDK') + " BDK ON BDK.D_E_L_E_T_ = ' '" 													  				+ CRLF
cQryUsr += "  AND BDK_FILIAL = '" + xFilial('BDK') + "'" 																	   					+ CRLF
cQryUsr += "  AND BHO_CODOPE||BHO_CODEMP||BHO_MATRIC||BHO_TIPREG = BDK_CODINT||BDK_CODEMP||BDK_MATRIC||BDK_TIPREG" 			   					+ CRLF
cQryUsr += "  AND BHO_ANOREA||BHO_MESREA = BDK_ANOMES" 																							+ CRLF
cQryUsr += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '" 																	+ CRLF
cQryUsr += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'"				 																		+ CRLF
cQryUsr += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG = BDK_CODINT||BDK_CODEMP||BDK_MATRIC||BDK_TIPREG" 								+ CRLF
cQryUsr += "WHERE BHO.D_E_L_E_T_ = ' '" 																										+ CRLF
cQryUsr += "  AND BHO_FILIAL = '" + xFilial('BHO') + "'" 																						+ CRLF
cQryUsr += "  AND BHO_ANOREA||BHO_MESREA " + If(lMesAnterior,'<','=') + " '" + Left(DtoS(mv_par01),6) + "'"									+ CRLF
cQryUsr += "  AND SUBSTR(BA1_DATINC,1,6) <= BHO_ANOREA||BHO_MESREA " 															 				+ CRLF
cQryUsr += "  AND IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),TO_DATE('" + DtoS(mv_par01) + "','YYYYMMDD')) BETWEEN BDK_IDAINI AND BDK_IDAFIN" 	+ CRLF
cQryUsr += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + cMatUsr + "'" 									  			+ CRLF

TcQuery cQryUsr New Alias cAlReajUsr	

cAlReajUsr->(DbGoTop())

If !cAlReajUsr->(EOF())
	aRet := {cAlReajUsr->(IDENTIFICADOR),cAlReajUsr->(BDK_VALOR),cAlReajUsr->(IDADE)}
EndIf

cAlReajUsr->(DbCloseArea())
	
Return aRet

********************************************************************************************************************************

//Retorna um array com os dados do reajuste da Familia, se existir.

Static Function GetReajFam(cMatUsr,lMesAnterior)

Local aRet 			:= {}
Local cAlReajFam 	:= GetNextAlias()

Default lMesAnterior := .F.

cQryFam := "SELECT 'REAJUSTE FAMILIA' IDENTIFICADOR,BBU_CODFAI FAIXA,BBU_VALFAI," 																	+ CRLF
cQryFam += "  IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),TO_DATE('" + DtoS(mv_par01) + "','YYYYMMDD')) IDADE" 										+ CRLF
cQryFam += "FROM " + RetSqlName('BHL') + " BHL" 																									+ CRLF
cQryFam += "INNER JOIN " + RetSqlName('BBU') + " BBU ON BBU.D_E_L_E_T_ = ' '" 																		+ CRLF
cQryFam += "  AND BBU_FILIAL = '" + xFilial('BBU') + "'" 																							+ CRLF
cQryFam += "  AND BHL_CODOPE||BHL_CODEMP||BHL_MATRIC = BBU_CODOPE||BBU_CODEMP||BBU_MATRIC" 															+ CRLF
cQryFam += "  AND BHL_ANOREA||BHL_MESREA = BBU_ANOMES" 																								+ CRLF
cQryFam += "  AND (SUBSTR(BBU_TABVLD,1,6) >= BHL_ANOREA||BHL_MESREA OR BBU_TABVLD = ' ')" 															+ CRLF
cQryFam += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '" 																		+ CRLF
cQryFam += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'" 																							+ CRLF
cQryFam += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC = BBU_CODOPE||BBU_CODEMP||BBU_MATRIC" 															+ CRLF
cQryFam += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + cMatUsr + "'" 													+ CRLF
cQryFam += "WHERE BHL.D_E_L_E_T_ = ' '" 																											+ CRLF
cQryFam += "  AND BHL_FILIAL = '" + xFilial('BHL') + "'" 																							+ CRLF
cQryFam += "  AND BHL_ANOREA||BHL_MESREA " + If(lMesAnterior,'<','=') + " '" + Left(DtoS(mv_par01),6) + "'" 										+ CRLF
cQryFam += "  AND SUBSTR(BA1_DATINC,1,6) <=  BHL_ANOREA||BHL_MESREA" 																				+ CRLF
cQryFam += "  AND IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),TO_DATE('" + DtoS(mv_par01) + "','YYYYMMDD')) BETWEEN BBU_IDAINI AND BBU_IDAFIN" 		+ CRLF								

TcQuery cQryFam New Alias cAlReajFam

cAlReajFam->(DbGoTop())

If !cAlReajFam->(EOF())
	aRet := {cAlReajFam->(IDENTIFICADOR),cAlReajFam->(BBU_VALFAI),cAlReajFam->(IDADE)}
EndIf

cAlReajFam->(DbCloseArea())

Return aRet                 

********************************************************************************************************************************

//Retorna o ultimo pagamento do usuario antes do mes/ano informado
Static Function GetMensPaga(cMatUsr)

Local aRet := {}
Local cAliasPgto := GetNextAlias()

cQryPgto := "SELECT BM1_VALOR,BM1_ANO||BM1_MES,"																			 	+ CRLF
cQryPgto += "  IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),TO_DATE('" + DtoS(mv_par01) + "','YYYYMMDD')) IDADE" 					+ CRLF
cQryPgto += "FROM " + RetSqlName('BA1') + " BA1" 																				+ CRLF 
cQryPgto += "LEFT JOIN " + RetSqlName('BM1') + " BM1 ON BM1.D_E_L_E_T_ = ' '" 													+ CRLF
cQryPgto += "  AND BM1_FILIAL = '" + xFilial('BM1') + "'" 																		+ CRLF
cQryPgto += "  AND BM1_CODINT = BA1_CODINT" 																					+ CRLF
cQryPgto += "  AND BM1_CODEMP = BA1_CODEMP" 																					+ CRLF
cQryPgto += "  AND BM1_MATRIC = BA1_MATRIC" 																					+ CRLF
cQryPgto += "  AND BM1_TIPREG = BA1_TIPREG" 																					+ CRLF
cQryPgto += "  AND BM1_ANO||BM1_MES < '" + Left(DtoS(mv_par01),6) + "' " 														+ CRLF
cQryPgto += "  AND BM1_CODTIP = '101'" 																							+ CRLF
cQryPgto += "WHERE BA1.D_E_L_E_T_ = ' '" 																						+ CRLF
cQryPgto += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'" 																		+ CRLF
cQryPgto += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '" + cMatUsr + "'" 								+ CRLF
cQryPgto += "ORDER BY BM1_ANO||BM1_MES DESC" 																					+ CRLF

TcQuery cQryPgto New Alias cAliasPgto

cAliasPgto->(DbGoTop())

If !cAliasPgto->(EOF())
	aRet := {'PAGAMENTO',cAliasPgto->(BM1_VALOR),cAliasPgto->(IDADE)}
EndIf
    
cAliasPgto->(DbCloseArea())

Return aRet

********************************************************************************************************************************

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

aHelp := {}
aAdd(aHelp, "Informe a competencia")
PutSX1(cPerg , "01" , "Competencia" 	,"","","mv_ch1","D",8,0,0,"G",""	,"","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a operadora")
PutSX1(cPerg , "02" , "Operadora" 		,"","","mv_ch2","C",TamSx3("BA1_CODINT")[1],0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o grupo/empresa inicial"	)
PutSX1(cPerg,"03","Grupo/Empresa De"	,"","","mv_ch03","C",TamSx3("BA1_CODEMP")[1],0,1,"G","",""			,"","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o grupo/empresa final"	)
PutSX1(cPerg,"04","Grupo/Empresa Ate"	,"","","mv_ch04","C",TamSx3("BA1_CODEMP")[1],0,1,"G","",""			,"","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o filtro")
PutSX1(cPerg,"05","Filtro"				,"","","mv_ch05","N",01	,0,1,"C","","","","","mv_par05","Todos"	,"","","","Erro"  		,"","","Ok" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o percentual limite")
aAdd(aHelp, "para critica de excedente do")
aAdd(aHelp, "percentual. Se este parametro")
aAdd(aHelp, "nao for informado, nao sera")
aAdd(aHelp, "exibida esta critica.")
PutSX1(cPerg,"06","Perc. limite"		,"","","mv_ch06","N",5,2,1,"G","","","","","mv_par06",""	,"","","",""  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o contrato inicial")
PutSX1(cPerg,"07","Contrato de"		,"","","mv_ch07","C",TamSx3("BA3_CONEMP")[1],0,1,"G","","","","","mv_par07",""	,"","","",""  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o contrato final")
PutSX1(cPerg,"08","Contrato ate"	,"","","mv_ch08","C",TamSx3("BA3_CONEMP")[1],0,1,"G","","","","","mv_par08",""	,"","","",""  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o subcontrato inicial")
PutSX1(cPerg,"09","Subcontrato de"	,"","","mv_ch09","C",TamSx3("BA3_SUBCON")[1],0,1,"G","","","","","mv_par09",""	,"","","",""  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o subcontrato final")
PutSX1(cPerg,"10","Subcontrato ate"	,"","","mv_ch10","C",TamSx3("BA3_SUBCON")[1],0,1,"G","","","","","mv_par10",""	,"","","",""  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return

******************************************************************************************************************************
