#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS264OB  ºAutor  ³Leonardo Portella   º Data ³  18/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE para ordenar as carteirinhas. Como no fonte PLSA264 o re-º±±
±±º          ³torno deste PE eh concatenado com a query principal utilizo º±±
±±º          ³para fazer o filtro de lotacao e assim tambem agiliza a     º±±
±±º          ³emissao pois terao menos registros (ao inves de usar o PE   º±±
±±º          ³PLS264EM).                                                  º±±
±±º          ³Alem disso a rotina de preparacao de carteirinha so eh uti- º±±
±±º          ³zada quando vai mandar para a grafica, quando gera na im-   º±±
±±º          ³pressora da Caberj nao usa, logo preciso ordenar na geracao º±±
±±º          ³mesmo.                                                      º±±
±±º          ³So passa neste PE quando gera, nao na reemissao.            º±±
±±º          ³Chamados IDs: 3566 e 4495                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Caberj                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS264OB

Local aArea		:= GetArea()
Local cOrderBy 	:= CRLF

//Filtro da lotacao Itau somente na Caberj
If cEmpAnt == '01' .and. ( AllTrim(Upper(FunName())) == 'PLSA262' )
	If !empty(M->BDE_XLOATE)
		cOrderBy += "	AND BA1_YLOTAC BETWEEN '" + M->BDE_XLOTDE + "' AND '" + M->BDE_XLOATE + "'"   	+ CRLF
	EndIf
EndIf
                                            
//Debug somente - Inicio
/*
cOrderBy += "	AND BA1_DATBLO = ' ' AND ROWNUM < 100"   	+ CRLF
cOrderBy += "	AND NOT EXISTS"   							+ CRLF
cOrderBy += "	  ("   										+ CRLF
cOrderBy += "	  SELECT BED_VIACAR"   						+ CRLF
cOrderBy += "	  FROM " + RetSqlName('BED')				+ CRLF
cOrderBy += "	  WHERE D_E_L_E_T_ = ' ' "   				+ CRLF
cOrderBy += "	  AND BED_FILIAL = BA1_FILIAL"     			+ CRLF
cOrderBy += "	  AND BED_CODINT = BA1_CODINT"   			+ CRLF
cOrderBy += "	  AND BED_CODEMP = BA1_CODEMP"   			+ CRLF
cOrderBy += "	  AND BED_MATRIC = BA1_MATRIC"   			+ CRLF
cOrderBy += "	  AND BED_TIPREG = BA1_TIPREG"   			+ CRLF
cOrderBy += "	  AND BED_STACAR <> '2'"  				 	+ CRLF
cOrderBy += "	  )"   										+ CRLF
*/
//Debug somente - Fim

cOrderBy += "ORDER BY BA1_CODINT,BA1_CODEMP,BA1_CONEMP,BA1_VERCON,BA1_YLOTAC,BA1_TIPREG,BA1_NOMUSR" 	+ CRLF

RestArea(aArea)

Return cOrderBy

*******************************************************************************************************   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para filtrar as lotacoes do Itau na Caberj. Usado na ³
//³consulta padrao BDEITA.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                                                   
User Function ConsBDE

Local aLot		:= {}
Local lConfirm	:= .F.
Local cLog 		:= ""
Local nOpca		:= 0
Local aCab		:= {"Codigo","Lotacao"}
Local aTam		:= {30,100}
Local nOpca		:= 0
Local cLotacao	:= &(ReadVar())

Private oDlg 	:= nil
Private oBrowse	:= nil

Processa({||aLot := aLotacoes()})

oDlg := MSDialog():New(0,0,530,850,"Lotações",,,.F.,,,,,,.T.,,,.T. )

    bDbClick 	:= {||nOpca := oBrowse:nAt,lConfirm := .T.,oDlg:End()}

	oBrowse := TCBrowse():New(010,010,410,190,,aCab,aTam,oDlg,,,,,bDbClick,,,,,,,.F.,,.T.,,.F.,,, )

    oBrowse:SetArray(aLot)    

    oBrowse:bLine := {||{	aLot[oBrowse:nAt,1]		,;
							aLot[oBrowse:nAt,2] 	}}

	oBrowse:nScrollType := 1 // Scroll VCR

  	oSBtn1     := SButton():New(230,365,1,bDbClick			,oDlg,,"", )
	oSBtn2     := SButton():New(230,395,2,{||oDlg:End()}	,oDlg,,"", )

oDlg:Activate(,,,.T.)

If lConfirm .and. ( nOpca > 0 ) .and. !empty(aLot[nOpca][2]) 
	cLotacao := aLot[nOpca][1]
EndIf

Return cLotacao

*******************************************************************************************************

Static Function aLotacoes

Local cQry 		:= ""
Local aRet		:= {}
Local cAlias	:= GetNextAlias()
Local nI		:= 0
Local nTot		:= 0

ProcRegua(0)

For nI := 1 to 5
	IncProc('Buscando lotações')
Next

cQry := "SELECT DISTINCT BA1_YLOTAC,BA1_YNOMLO" 											+ CRLF
cQry += "FROM " + RetSqlName('BA1') 														+ CRLF
cQry += "WHERE D_E_L_E_T_ = ' '" 															+ CRLF
cQry += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'"										+ CRLF
cQry += "  AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '" + DtoS(dDataBase) + "')" 				+ CRLF
cQry += "  AND BA1_YLOTAC <> ' '" 															+ CRLF
cQry += "  AND BA1_YNOMLO <> ' '" 															+ CRLF
cQry += "  AND BA1_CODEMP BETWEEN '" + M->BDE_EMPDE  + "' AND '" + M->BDE_EMPATE + "'" 	+ CRLF
cQry += "  AND BA1_CONEMP BETWEEN '" + M->BDE_CONDE  + "' AND '" + M->BDE_CONATE + "'" 	+ CRLF
cQry += "  AND BA1_SUBCON BETWEEN '" + M->BDE_SUBDE  + "' AND '" + M->BDE_SUBATE + "'" 	+ CRLF
cQry += "  AND BA1_MATRIC BETWEEN '" + M->BDE_MATDE  + "' AND '" + M->BDE_MATATE + "'" 	+ CRLF
cQry += "ORDER BY BA1_YLOTAC,BA1_YNOMLO" 													+ CRLF

TcQuery cQry New Alias cAlias

COUNT TO nTot

ProcRegua(nTot)

nI := 0

cAlias->(DbGoTop())

While !cAlias->(EOF())

	IncProc('Buscando lotações ' + cValToChar(++nI) + ' de ' + cValToChar(nTot))

	aAdd(aRet,{cAlias->BA1_YLOTAC,cAlias->BA1_YNOMLO})	

	cAlias->(DbSkip())

EndDo

If empty(aRet)
	aAdd(aRet,{'',''})
EndIf

cAlias->(DbCloseArea())

Return aRet