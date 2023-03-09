#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PLSMGER.CH"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Virada P11 - 08/11/13 - Por motivos desconhecidos, nao conseguiamos compilar somente este PE (PLSXMINF). Nao dava ³
//³critica nem quando forcavamos erros de sintaxe, como por exemplo: [ abc :+ while if do ] na mesma linha.          ³
//³Tentamos em outro ambiente, copiamos o conteudo deste fonte para o notepad e depois colocamos novamente no        ³
//³prw, tentando discartar a hipotese de caracter especial. Deletamos do projeto e ate testamos com binario atual da ³
//³Totvs, comentamos os includes, etc. Tudo sem sucesso. Ate User "Power" Function PLSXMINF testamos e nao criticou. ³
//³A unica solucao foi deletar o plsxminf e alterar o nome do prw para plsxminf1 e recompilar.                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSXMINF  ºAutor  ³Leonardo Portella   º Data ³  09/02/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para implementacao de mais informacoes     º±±
±±º          ³para o log do xml                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 

User Function PLSXMINF
  
Local aArea			:= GetArea()
Local aDad			:= paramixb[1]
Local aIte			:= paramixb[2]
Local aMatInf		:= paramixb[3]
Local aAreaBCG		:= BCG->(GetArea())
Local nPos			:= 0
Local cLocal		:= If((nPos := aScan(aDad,{|x|allTrim(x[1]) == 'CODLDP'})) > 0,aDad[nPos][2],'')//BCG  
Local cSep			:= Replicate('-',60) 
Local cCodUsr		:= RetCodUsr()
Local cNomUsr		:= AllTrim(Capital(Lower(UsrFullName(cCodUsr))))
Local nI			:= 0
Local cAmbiente		:= AllTrim(Upper(GetEnvServer()))//Nome do ambiente logado
Local c_PegGuia		:= PLSRETDAD(aDad,'NUMPEG',' ') 
Local cMatric		:= PLSRETDAD(aDad,'USUARIO',' ')

Private cCodLDP		:= GetNewPar('MV_XLDPINT',"0016")//LOCAL PARA GERACAO AUTOMATICA DE GUIA IMPORTACAO INTERNACAO 

aAdd(aMatInf,{cSep,'NIL'})
aAdd(aMatInf,{'INFORMACOES IMPORTACAO','PLSXMINF'})
aAdd(aMatInf,{cSep,'NIL'})

aAdd(aMatInf,{'AMBIENTE IMPORTACAO'	,cAmbiente})

If !empty(cLocal)
	aAdd(aMatInf,{'LOCAL DE IMPORTACAO'	,cLocal + ' - ' + AllTrim(Posicione('BCG',1,xFilial('BCG') + cLocal,'BCG_DESCRI'))})
EndIf

aAdd(aMatInf,{'USUARIO IMPORTACAO'	,cCodUsr + ' - ' + cNomUsr})
aAdd(aMatInf,{'DATA SISTEMA'		,DtoC(dDataBase)})
aAdd(aMatInf,{'DATA REAL'  			,DtoC(Date())})
aAdd(aMatInf,{'HORA'				,Time()})

aAdd(aMatInf,{cSep,'NIL'})

 //Leonardo Portella - 05/11/13 - Inicio - Virada P11 - Importacao no local 0016 nao sera utilizada
/* 
 If 	PLSRETDAD(aDad,'IMPXML',.F.) .and. 			;
 	PLSRETDAD(aDad,'RESINT',.F.) .and. 			;
 	( PLSRETDAD(aDad,'TIPFAT',' ') $ 'P|T' ) .and. ;
 	( PLSRETDAD(aDad,'TIPO',' ') == '3' ) .and.  	;
 	!BE4->(EOF()) .and. 							;
 	!empty(c_PegGuia) .and. 						;
 	!empty(cMatric)
 	
 	aLog := U_IncIntSADT(c_PegGuia,PLSRETDAD(aDad,'CODRDA',''),cMatric)
 
 	If !empty(aLog)
 
 		For n_I := 1 to len(aLog)
 			aAdd(aMatInf,{' ',aLog[n_I]})
 		Next
 
 		aAdd(aMatInf,{cSep,'NIL'})
 
 	EndIf
 
 EndIf
*/
 
//Leonardo Portella - 05/09/14
//LogPBB(aMatInf,aDad,aIte,c_PegGuia)

BCG->(RestArea(aAreaBCG))
RestArea(aArea)

Return aMatInf



Static Function LogPBB(aMatInf,aDad,aIte,cChave)

Local nAux 		:= 0
Local nSeq 		:= 0
Local cXML 		:= AllTrim(PLSRETDAD(aDad,'ARQIMP','Tag nao encontrada'))
Local cQry		:= ""
Local cAlias 	:= GetNextAlias()
Local cCodRDA	:= PLSRETDAD(aDad,'CODRDA',' ')
Local cDatHor	:= DtoS(Date()) + StrTran(Time(),':','')

If empty(cChave)
	cChave := PadR(PLSRETDAD(aMatInf,'OPERADORA',' ')	,4)
	cChave += PadR(PLSRETDAD(aMatInf,'LOCAL DIG.',' ')	,4)
	cChave += PadR(PLSRETDAD(aMatInf,'PEG',' ')			,8)
	cChave += PadR(PLSRETDAD(aMatInf,'GUIA',' ')		,8)
EndIf

If empty(cChave)
	cChave := ' '
EndIf

cQry := "SELECT NVL(MAX(PBB_SEQUEN)+1,1) SEQUEN" 			+ CRLF
cQry += "FROM " + RetSqlName('PBB') 						+ CRLF
cQry += "WHERE D_E_L_E_T_ = ' '" 							+ CRLF 
cQry += "	AND PBB_FILIAL = '" + xFilial('PBB') + "'" 		+ CRLF
cQry += "	AND TRIM(PBB_XML) = '" + AllTrim(cXML) + "'" 	+ CRLF

TcQuery cQry New Alias cAlias

nSeq := cAlias->SEQUEN

cAlias->(DbCloseArea())

BEGIN TRANSACTION 

For nAux := 1 to len(aMatInf)
	
	If ( len(aMatInf[nAux]) == 2 ) .and. ( aMatInf[nAux][2] <> 'NIL' ) .and. !empty(aMatInf[nAux][2])
		
		PBB->(Reclock('PBB',.T.))	
		
		PBB->PBB_FILIAL := xFilial('PBB')
		PBB->PBB_CHAVE	:= cChave
		PBB->PBB_CODRDA	:= cCodRDA
		PBB->PBB_SEQUEN	:= nSeq
		PBB->PBB_XML	:= cXML
		PBB->PBB_TAGLOG	:= aMatInf[nAux][1]
		PBB->PBB_DESLOG	:= aMatInf[nAux][2]
		PBB->PBB_DATHOR	:= cDatHor
		
		PBB->(MsUnlock())     
		
		nSeq++
		
    EndIf
    
Next

END TRANSACTION

Return