#INCLUDE "PROTHEUS.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "PLSMGER.CH"

/*--------------------------------------------------------------------------
| Programa  | CABA077  | Autor | Otavio Pinto         | Data |  21/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Protocolo da Previa                                           |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/

User Function CABA077

/*--------------------------------------------------------------------------
| Declaracao de Variaveis                                                   |
 --------------------------------------------------------------------------*/
Private aRotina   	:=	{	{ "Pesquisar"   , 'AxPesqui'   					, 0 , K_Pesquisar  },;
                            { "Visualizar"  , 'U_CAB77VIS'/*'AxVisual'*/	, 0 , K_Visualizar },;
                            { "Alterar"     , 'U_CAB77ALT'/*'AxAltera'*/   	, 0 , K_Alterar    },;
                            { "Legenda"     , "u_PLSRPLEG" 					, 0 , K_Incluir    } }

Private cCadastro 	:= "Protocolo de Atendimento"


Private aCdCores  	:= { 	{ 'BR_VERDE'   ,'Ativo'    }	,;
                         	{ 'BR_VERMELHO','Bloqueado'}  	}
                         
Private aCores      := { 	{ 'ZUD_ATIVO = "S"',aCdCores[1,1] }		,;
                         	{ 'ZUD_ATIVO = "N"',aCdCores[2,1] } 	}  

Private cPath     	:= ""
Private aErro_	  	:= {}
Private aHeader   	:= {}
Private aTrailler 	:= {}
Private aOk       	:= {}
Private cAlias    	:= "ZUD"
Private cFixos    	:= {}
Private _aArea    	:= GetArea()
Private c_Acesso	:= U_USRxNUPRE(.T.)
Private c_Filtro	:= ''

//Obs: ZUD_MARCA -> Se for marcado o mesmo registro na ZUD por outro usuario, o ZUD_MARCA do usuario que marcou antes sera desmarcado 
//evitando que os 2 editem o mesmo registro
Private cMarcZUD	:= Replace(Time(),':','') + DtoS(Date()) + 'M'  

If empty(c_Acesso)
	Return
EndIf

DbSelectArea(cAlias)

Do Case

	Case c_Acesso == 'NUPRE NITEROI'
		c_Filtro := "AllTrim(ZUD_NUPRE) == 'NITEROI'"
	
	Case c_Acesso == 'NUPRE BANGU'
		c_Filtro := "AllTrim(ZUD_NUPRE) == 'BANGU'"
	
	Case c_Acesso == 'NUPRE TIJUCA'
		c_Filtro := "AllTrim(ZUD_NUPRE) == 'TIJUCA'"
		
EndCase 

If !empty(c_Filtro)
	SET FILTER TO &c_Filtro
EndIf

(cAlias)->( DBSetOrder(1) )

//Leonardo Portella - 14/08/13 - Inicio - Conforme novo escopo, a rotina devera permitir selecionar varias previas e dar manutencao em diversas previas.
//Criacao dos campos ZUD_MARCA e ZUD_BMP

//(cAlias)->( mBrowse(,,,,cAlias , , , , , Nil, aCores, , , ,nil, .T.) )
(cAlias)->( MarkBrowse(cAlias,'ZUD_MARCA','ZUD_BMP',,,cMarcZUD,,,,,,,,,aCores) )

//Leonardo Portella - 14/08/13 - Fim

(cAlias)->( DbClearFilter() )

RestArea(_aArea)

return

/*------------------------------------------------------------------------
| Funcao    | VALIDATA  | Otavio Pinto                 | Data | 05/07/13  |
+-------------------------------------------------------------------------+
| Descricao | VALIDATA                                                    |
+-------------------------------------------------------------------------+
| Uso       |                                                             |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/

User Function VALIDATA( _nTipo, dPIni, dPFim)

Local lRet 	:= .T.
Local x 	:= ""

Default dPIni 	:= M->ZUD_DTPINI
Default dPFim 	:= M->ZUD_DTPFIN

_nTipo := If( _nTipo == Nil, 1, _nTipo )

Do Case  

   Case _nTipo == 1  
   
        Do case
           case dPIni < dDataBase   
                MsgStop( "Data Inicial nao pode ser menor do que a DATA ATUAL."+chr(13)+chr(13)+"Digite novamente !" ) 
                lRet := .F.
           case dPIni > ( dDataBase + 730 )  
                MsgStop( "Data Inicial nao pode ser maior que 2 ANOS a contar da DATA ATUAL."+chr(13)+chr(13)+"Digite novamente !" ) 
                lRet := .F.               
        EndCase 
          
   Case _nTipo <> 1
   
        Do case
           case !(dPFim >= dPIni)  
                MsgStop( "Data Final nao pode ser menor do que a DATA INICIAL"+chr(13)+chr(13)+"Digite novamente !" ) 
                lRet := .F.
           case dPFim > ( dPIni + 730 )  
                MsgStop( "Data Final nao pode ser maior que 2 ANOS a contar da DATA INICIAL"+chr(13)+chr(13)+"Digite novamente !" ) 
                lRet := .F.                
        EndCase
        
EndCase

return lRet

/*------------------------------------------------------------------------
| Funcao    | PLSRPLEG  | Otavio Pinto                 | Data | 05/07/13  |
+-------------------------------------------------------------------------+
| Descricao | PLSRPLEG                                                    |
+-------------------------------------------------------------------------+
| Uso       |                                                             |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/

User Function PLSRPLEG 

local aLegenda                            

aLegenda := {  	{ aCdCores[1,1],aCdCores[1,2] },;
	            { aCdCores[2,1],aCdCores[2,2] } }

BrwLegenda(cCadastro,"Status" ,aLegenda)

Return

/*------------------------------------------------------------------------
| Funcao    | PLSRPLEG  | Otavio Pinto                 | Data | 05/07/13  |
+-------------------------------------------------------------------------+
| Descricao | PLSRPLEG                                                    |
+-------------------------------------------------------------------------+
| Uso       |                                                             |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+------------------------------------------------------------------------*/

User Function CABA077A()

local cRet 	:= Space(TamSX3('ZUD_USUARI')[1])
local aArea	:= BA1->( GetArea() )

BA1->( DbSetOrder(2) )

if BA1->( MsSeek(xFilial('ZUD') + M->ZUD_MATRIC ) )
	cRet := BA1->BA1_NOMUSR 
endIf
                              
M->ZUD_USUARI := cRet

BA1->( RestArea(aArea) )

return 

User Function PLSRZUDIMP

MsgStop( "Ainda não implementado..." ) 

return

**************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 19/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CAB77VIS

Local aButtons := {}

aAdd(aButtons,{'CLOCK03',{||U_TrataZUH(.F.)},'Sug. Prévia'})

AxVisual("ZUD",ZUD->(Recno()),2,,,,,aButtons,.T.)

Return

**************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 19/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CAB77ALT

Local nOpca 
Local aArea		:= GetArea()
Local aButtons 	:= {}
Local cAliasAlt	:= GetNextAlias()
Local cQryAlt	:= ''
Local cCadAntes := cCadastro
Local nNaoAtivo	:= 0
Local aMsgAtiv	:= {}
Local cRecZUDAt	:= ''
Local cBuffer	:= ''
Local cMat		:= ''
Local cNom		:= '' 
Local lAchou	:= .F.
Local lContinua	:= .T. 
Local aInfPrSel	:= {}

cQryAlt := "SELECT ZUD_ATIVO,ZUD_MARCA,ZUD_SQPROT,ZUD_SBPROT,ZUD_SQPREV,ZUD_CODTAB,ZUD_CODPRO,ZUD_MATRIC,ZUD_USUARI,R_E_C_N_O_ RECZUD"	+ CRLF
cQryAlt += "FROM " + RetSqlName('ZUD') + " ZUD"																							+ CRLF
cQryAlt += "WHERE ZUD_FILIAL = '" + xFilial('ZUD') + "'"										 										+ CRLF
cQryAlt += "  AND ZUD_MARCA = '" + cMarcZUD + "'"  													   									+ CRLF
cQryAlt += "  AND D_E_L_E_T_ = ' '"				  														 								+ CRLF
cQryAlt += "ORDER BY ZUD_SQPROT,ZUD_SBPROT,ZUD_SQPREV,ZUD_CODTAB,ZUD_CODPRO"							   								+ CRLF

TcQuery cQryAlt New Alias cAliasAlt

If ( lAchou := cAliasAlt->(EOF()) )
	MsgStop('Selecione pelo menos 1 registro para dar manutenção!',AllTrim(SM0->M0_NOMECOM))
Else
	
	cMat	:= cAliasAlt->ZUD_MATRIC
	cNom	:= cAliasAlt->ZUD_USUARI

	While !cAliasAlt->(EOF())
	    
		If cMat	<> cAliasAlt->ZUD_MATRIC
			MsgStop('Aviso:' + CRLF + 'Não é possível editar mais de 1 matrícula por vez!' + CRLF + 'Selecione apenas prévias da mesma matrícula!',AllTrim(SM0->M0_NOMECOM))	
			lContinua := .F.
			Exit
		EndIf
		
		cBuffer 	:= 'Protocolo: ' + cAliasAlt->ZUD_SQPROT + '.' + cAliasAlt->ZUD_SBPROT + ' '
		cBuffer 	+= 'Tabela: ' + cAliasAlt->ZUD_CODTAB + ' Procedimento: ' + AllTrim(cAliasAlt->ZUD_CODPRO) + ' '
		cBuffer 	+= 'Sequencial: ' + AllTrim(cAliasAlt->ZUD_SQPREV) + ' '
		cBuffer 	+= 'Descr.: ' + AllTrim(Upper(Posicione('BR8',1,xFilial('BR8') + cAliasAlt->ZUD_CODTAB + AllTrim(cAliasAlt->ZUD_CODPRO),'BR8_DESCRI')))
		
		aAdd(aInfPrSel,cBuffer)
	
		If ( cAliasAlt->ZUD_ATIVO == 'S' )
			aAdd(aMsgAtiv,cBuffer)
			cRecZUDAt 	+= cValToChar(cAliasAlt->RECZUD) + ';'
		Else
			nNaoAtivo++
		EndIf
				
		cAliasAlt->(DbSkip())
	EndDo
	
	If lContinua .and. !empty(cRecZUDAt)
		cRecZUDAt := Left(cRecZUDAt,len(cRecZUDAt) - 1)
	EndIf
	
	If lContinua .and. lAchou .and. ( nNaoAtivo > 0 )
		MsgAlert('Aviso:' + CRLF + 'Existem Prévias bloqueadas dentre as selecionadas. Somente será possível editar as prévias ATIVAS.',AllTrim(SM0->M0_NOMECOM))
	EndIf

EndIf

cAliasAlt->(DbCloseArea())

If lContinua .and. len(aMsgAtiv) > 0
	If len(aMsgAtiv) == 1
		ZUD->(DbGoTo(Val(cRecZUDAt)))

		aAdd(aButtons,{'CLOCK03',{||If(U_VALIDATA(1, M->ZUD_DTPINI, M->ZUD_DTPFIN) .and. U_VALIDATA(2, M->ZUD_DTPINI, M->ZUD_DTPFIN),U_TrataZUH(.T.),)},'Sug. Prévia'})
		cCadastro 	:= "Protocolo de Atendimento - Edição Simples"			
		nOpca  		:= AxAltera("ZUD",ZUD->(Recno()),4,,,,,,'U_INCSUG',,aButtons,,,,.T.)

		If ( nOpca == 1 ) 
			GrvZUD()
		EndIf
	Else
		U_EditMult(cMat,cNom,cRecZUDAt,aInfPrSel)
	EndIf
ElseIf lContinua
	MsgStop('Não foram selecionadas prévias ATIVAS. Somente será possível editar as prévias ATIVAS.',AllTrim(SM0->M0_NOMECOM))			
EndIf

RestArea(aArea)

cCadastro := cCadAntes

Return

*******************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 29/07/13 - Inclusao das sugestoes da previa³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sugestao das datas da previa caso nao exista nenhuma sugestao. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function INCSUG(cRecZUD)

Local a_Area 	:= GetArea()
Local c_Alias   := GetNextAlias() 
Local cQry 		:= ''
Local lInsSug	:= .F.
Local lAlterado	:= .F.
Local nQtd		:= 0
Local nValidade	:= 0
Local nPeriodo	:= 0
Local cMsg		:= ''
Local dNova
Local cMesAno
Local nQtd		:= 1
Local aRecs 	:= {}
Local lMult		:= .F. 
Local nI		:= 0
Local nJ		:= 0

Default cRecZUD	:= ''

If !empty(cRecZUD)
	aRecs 	:= Separa(cRecZUD,';',.F.)
	nQtd	:= len(aRecs)
	lMult	:= ( nQtd > 1 )
EndIf

If MsgYesNo('Deseja que o sistema sugira datas de realização para esta prévia?',AllTrim(SM0->M0_NOMECOM))
    
	For nJ := 1 to nQtd
	
		If lMult
			ZUD->(DbGoTo(Val(aRecs[nJ])))
			RegToMemory('ZUD')
		EndIf
	
		cQry := "SELECT COUNT(*) QTD" 							+ CRLF
		cQry += "FROM " + RetSqlName('ZUH') 					+ CRLF
		cQry += "WHERE ZUH_FILIAL = '" + xFilial('ZUH') + "'" 	+ CRLF
		cQry += "  AND ZUH_SQPROT = '" + M->ZUD_SQPROT + "'" 	+ CRLF
		cQry += "  AND ZUH_SBPROT = '" + M->ZUD_SBPROT + "'" 	+ CRLF
		cQry += "  AND ZUH_SQPROC = '" + M->ZUD_SQPROC + "'" 	+ CRLF
		cQry += "  AND ZUH_SQPREV = '" + M->ZUD_SQPREV + "'" 	+ CRLF
		cQry += "  AND D_E_L_E_T_ = ' '" 						+ CRLF
		
		TcQuery cQry New Alias c_Alias 
		
		lInsSug := !c_Alias->(EOF()) .and. ( c_Alias->QTD == 0 )
			
		c_Alias->(DbCloseArea())
		
		If lInsSug //Insere sugestoes
		    
		    //Verifica se existe exame no periodo e verifica seu resultado (normal ou alterado)
			cQry := "SELECT BTH.BTH_CODPAC,BTH.BTH_NOMPAC,BTH.BTH_CODATE,BTI_CODPAD,BTI_CODPRO,BTI_QTD,BTI_YDTREA,BTI_YNORMA," 			+ CRLF
		    cQry += "                             OBTER_TEXTO_EXAME_BTI(BTI.R_E_C_N_O_)  BTI_LAUDO," 									+ CRLF
		    cQry += "                             OBTER_TEXTO_BS7('BTI',BTI_CODATE||BTI_CODPAD||BTI_CODPRO,'BTI_RESULT') BTI_RESULT" 	+ CRLF
			cQry += "FROM " + RetSqlName('BTH') + " BTH," + RetSqlName('BTI') + " BTI" 												+ CRLF
			cQry += "WHERE BTH.D_E_L_E_T_ = ' '" 																						+ CRLF
			cQry += "	AND BTI.D_E_L_E_T_ = ' '" 																						+ CRLF
			cQry += "	AND BTH_FILIAL = '" + xFilial('BTH') + "'" 																		+ CRLF
			cQry += "	AND BTH_CODPAC = '" + M->ZUD_MATRIC + "'" 																		+ CRLF
			cQry += "	AND BTI_FILIAL = BTH_FILIAL" 																					+ CRLF
			cQry += "	AND BTI_CODATE = BTH_CODATE" 																					+ CRLF
			cQry += "	AND BTI.BTI_CODPAD = '" + M->ZUD_CODTAB + "'" 																	+ CRLF
			cQry += "	AND BTI.BTI_CODPRO = '" + M->ZUD_CODPRO + "'" 																	+ CRLF
			cQry += "	AND BTI_YDTREA BETWEEN '" + DtoS(M->ZUD_DTPINI) + "' AND '" + DtoS(M->ZUD_DTPFIN) + "'"						+ CRLF
			cQry += "ORDER BY BTI_YDTREA DESC" 																							+ CRLF
			
			c_Alias := GetNextAlias()
			
			TcQuery cQry New Alias c_Alias
			
			lAlterado := !c_Alias->(EOF()) .and. ( c_Alias->BTI_YNORMA <> 1 )
			
			c_Alias->(DbCloseArea())
			
			//Pego os dados para a sugestao da previa
			cQry := "SELECT ZUC_QUANTI,ZUC_QTDALT,ZUC_VALIDA,ZUC_VLDALT" 	+ CRLF
			cQry += "FROM " + RetSqlName('ZUC')  		  					+ CRLF
			cQry += "WHERE ZUC_FILIAL = '" + xFilial('ZUC') + "'" 		   	+ CRLF
			cQry += "	AND ZUC_SQPROT = '" + M->ZUD_SQPROT + "'" 			+ CRLF
			cQry += "	AND ZUC_SBPROT = '" + M->ZUD_SBPROT + "'" 			+ CRLF
			cQry += "	AND ZUC_CODTAB = '" + M->ZUD_CODTAB + "'" 			+ CRLF
			cQry += "	AND ZUC_CODPRO = '" + M->ZUD_CODPRO + "'" 			+ CRLF
			cQry += "	AND D_E_L_E_T_ = ' '"  								+ CRLF
			
			c_Alias := GetNextAlias()
			
			TcQuery cQry New Alias c_Alias
			
			nValidade	:= If(lAlterado,c_Alias->ZUC_VLDALT,c_Alias->ZUC_VALIDA)
			nQtd		:= Val(If(lAlterado,c_Alias->ZUC_QTDALT,c_Alias->ZUC_QUANTI))
			
			c_Alias->(DbCloseArea())
			
			If nValidade == 0 
			
				If lAlterado
					lInsSug := MsgYesNo('Validade em caso alterado zerada para esta prévia [ ZUC_VLDALT ]. Continua?',AllTrim(SM0->M0_NOMECOM))		
				Else
					lInsSug := MsgYesNo('Validade em caso normal zerada para esta prévia [ ZUC_VALIDA ]. Continua?',AllTrim(SM0->M0_NOMECOM))
				EndIf  
				
			ElseIf nQtd == 0
			
				lInsSug := .F.
		
				If lAlterado 
					cMsg := 'Quantidade em caso alterado zerada para esta prévia [ ZUC_QTDALT ].'  	+ CRLF
					cMsg += 'Corrija o procedimento da prévia!'  									+ CRLF
					cMsg += 'Não será possível incluir sugestão automática!'  						+ CRLF
				Else
					cMsg := 'Quantidade em caso normal zerada para esta prévia [ ZUC_QUANTI ].'  	+ CRLF
					cMsg += 'Corrija o procedimento da prévia!'  									+ CRLF
					cMsg += 'Não será possível incluir sugestão automática!'  						+ CRLF
				EndIf  
				
				MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))		
				
			EndIf
			     
			If lInsSug
			
				nPeriodo := nValidade / nQtd
			
				For nI := 1 to nQtd
				    
		 			dNova 	:= M->ZUD_DTPINI + ( nPeriodo * ( nI - 1 ) * 30 )
		 			
		 			If dNova > M->ZUD_DTPFIN
		 				exit
		 			EndIf
		 			
		 			cMesAno := StrZero(Month(dNova),2) + '/' + cValToChar(Year(dNova))
					
				    ZUH->(Reclock('ZUH',.T.))
						
					ZUH->ZUH_FILIAL := xFilial('ZUH') 
					
					ZUH->ZUH_SQPROT	:= ZUD->ZUD_SQPROT
					ZUH->ZUH_SBPROT	:= ZUD->ZUD_SBPROT
					ZUH->ZUH_SQPROC	:= ZUD->ZUD_SQPROC
					ZUH->ZUH_SQPREV	:= ZUD->ZUD_SQPREV
					ZUH->ZUH_SUGEST	:= cMesAno
					ZUH->ZUH_TIPO 	:= If(lAlterado,'A','N')
					ZUH->ZUH_MODO 	:= 'A'//Automatico
					
					ZUH->(MsUnlock())
					
				Next
				
			EndIf
			
		EndIf
	
	Next
	
	MsgInfo('Sugestões de prévia incluídas automaticamente!',AllTrim(SM0->M0_NOMECOM))

EndIf
	
RestArea(a_Area)

Return

*******************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 19/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function GrvZUD

Local aStrZUD 	:= ZUD->(DbStruct('ZUD'))   
Local nI		:= 0
Local cMacroGrv	:= ""

BEGIN TRANSACTION

//AxInclui ja incluiu um registro em branco que esta ponteirado ou AxAltera ja esta ponteirado
ZUD->(Reclock('ZUD',.F.))

ZUD->ZUD_FILIAL := xFilial('ZUD')

For nI := 2 to len(aStrZUD)
	cMacroGrv := "ZUD->" + aStrZUD[nI][1] + ' := ' + aStrZUD[nI][1]
	&cMacroGrv
Next

ZUD->(MsUnlock())

END TRANSACTION 

Return

****************************************************************************************************************************
                   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 22/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function TrataZUH(lAltera) 

Private aCampos		:= {'ZUH_FILIAL','ZUH_SQPROT','ZUH_SBPROT','ZUH_SQPROC','ZUH_SQPREV','ZUH_SUGEST','ZUH_TIPO','ZUH_MODO'}
Private aStrCpos	:= {}
Private aBrwCpos	:= {}
Private cAliasTmp  	:= GetNextAlias()     
Private aObjects 	:= {}

Processa({||ExecZUH(lAltera)},'Selecionando registros...')

Return

****************************************************************************************************************************
                   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 22/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function ExecZUH(lAltera)
            
Local nCont	   		:= 0
Local aArea			:= GetArea()
Local nOpc 			:= If(lAltera,GD_UPDATE + GD_DELETE,0)

Private oDlg2

ProcRegua(0)

For nCont := 1 to 5
	IncProc('Selecionando registros...')
Next 

oDlg2 := MsDialog():New( 095,232,699,927,"Sugestões de Prévia de Atendimento - " + If(lAltera,'Alterar','Visualizar'),,,.F.,,,,,,.T.,,,.T. )

	aHeader	:= {}
	aCols	:= {}
	
	AtuoBrw1(lAltera)
	
	oBrw1 	:= MsNewGetDados():New(020,008,282,342,nOpc,'U_CAB77LOK',,'',,0,,'U_CAB77COK',Nil,,oDlg2,aHeader,aCols )
    
	//Nao editar o RECNO
	If ( nPosRec := aScan(oBrw1:aHeader,{|x|x[2] == 'RECNO'}) ) > 0
		oBrw1:aInfo[nPosRec][5] := 'V'
	EndIf
    
	If lAltera
		bOk 	:= {||If(Aviso('ATENÇÃO','Confirma a atualização?',{'Sim','Não'}) == 1,If(U_CAB77TOK(),(Processa({||GrvAtu(@oBrw1)}),oDlg2:End()),),)}
	Else
		bok 	:= {||oDlg2:End()} 	
	EndIf
	
	bCancel	:= {||oDlg2:End()} 
	
	aBut 	:= {}
	
	If lAltera
		aAdd(aBut,{"ADICIONAR_001"	, {||IncLinha(@oBrw1)}	, "Incluir"	, "Incluir"	})
	EndIf
		
oDlg2:Activate(,,,.T.,,,EnchoiceBar(oDlg2,bOk,bCancel,,aBut))

RestArea(aArea)
		
Return

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 24/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CAB77COK()

Local c_Campo 	:= AllTrim(Upper(ReadVar()))
Local lOk 		:= .T.

Do Case
		
	Case ( c_Campo == 'M->ZUH_SUGEST' ) .and. ( ( Right(M->ZUH_SUGEST,4) + Left(M->ZUH_SUGEST,2) ) < ( cValToChar(Year(dDataBase)) + StrZero(Month(dDataBase),2) ) )
		MsgStop('- Mês/Ano não pode ser inferior ao mês ano da data base (atual)!',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.
		
EndCase

Return lOk

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 24/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CAB77LOK(nPosBrw)

Local lOk 			:= .T.
Local nPosHeader 	:= aScan(oBrw1:aHeader,{|x|x[2] == 'ZUH_SUGEST'})

If Type('nPosBrw') <> 'N'
	nPosBrw := oBrw1:nAt
EndIf

Do Case
    
	Case oBrw1:aCols[nPosBrw][len(oBrw1:aHeader) + 1]//Deletado
		lOk := .T.		
	
	Case empty(oBrw1:aCols[nPosBrw][nPosHeader])
		MsgStop('Linha ' + StrZero(nPosBrw,2) + ' - Informe a data de sugestão!',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.
		
	Case ( Val(Left(oBrw1:aCols[nPosBrw][nPosHeader],2)) > 12 ) .or. ( Val(Left(oBrw1:aCols[nPosBrw][nPosHeader],2)) < 1 )
		MsgStop('Linha ' + StrZero(nPosBrw,2) + ' - Mês deve estar entre 1 e 12!',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.

EndCase

Return lOk

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 24/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CAB77TOK

Local lOk 	:= .T.
Local nI	:= 0

For nI := 1 to len(oBrw1:aCols)
	
	If !( lOk := U_CAB77LOK(nI) )
	 	Exit
	EndIf
	
Next

Return lOk

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 23/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function IncLinha(oGetNDad)

Local nJ := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aBuffer 	:= {}
Local cVarBuf	:= ''

If U_CAB77TOK()

	For nJ := 1 to len(oGetNDad:aHeader)

	    cVarBuf := AllTrim(oGetNDad:aHeader[nJ][2])

	    If cVarBuf $ 'ZUH_SQPROT,ZUH_SBPROT,ZUH_SQPROC,ZUH_SQPREV'
		    cVarBuf	:= 'ZUD->' + Replace(cVarBuf,'ZUH','ZUD')
		    uBuffer := &cVarBuf 
		ElseIf cVarBuf == 'RECNO'
			uBuffer := -1
		Else
			uBuffer := Space(TamSX3(cVarBuf)[1])
		EndIf
	    
	    If oGetNDad:aHeader[nJ][8] == 'D' .and. ValType(uBuffer) == 'C'
	    	 
	    	uBuffer	:= StoD(uBuffer) 
	    		
	    ElseIf oGetNDad:aHeader[nJ][8] == 'C' .and. ValType(uBuffer) == 'N'
	    
	    	uBuffer	:= cValToChar(uBuffer)	
	    
	    EndIf
	   	
	   	aAdd(aBuffer ,uBuffer)
		
	Next                     
	
	aAdd(aBuffer ,.F.)
	
	aAdd(oGetNDad:aCols,aBuffer)
	
	oGetNDad:ForceRefresh()
	
	oGetNDad:GoBottom()
	
EndIf

Return

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 23/07/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function AtuoBrw1(lAltera)

Local nJ 			:= 0
Local cAliasSgPr 	:= GetNextAlias()
Local cQry			:= ''
Local cSelect 		:= ''
Local aArea			:= GetArea()
Local cVarBuf		:= ''

For nJ := 1 to len(aCampos)
	cSelect += aCampos[nJ] + ','
Next 

cSelect += 'R_E_C_N_O_ RECNO'

cQry := "SELECT " + cSelect + CRLF
cQry += "FROM " + RetSqlName('ZUH')	+ " ZUH"																						+ CRLF
cQry += "WHERE ZUH_FILIAL = '" + xFilial('ZUH') + "'" 																				+ CRLF
cQry += "  AND ZUH_SQPROT = '" + ZUD->ZUD_SQPROT + "'" 							 													+ CRLF
cQry += "  AND ZUH_SBPROT = '" + ZUD->ZUD_SBPROT + "'" 																				+ CRLF
cQry += "  AND ZUH_SQPROC = '" + ZUD->ZUD_SQPROC + "'" 																				+ CRLF
cQry += "  AND ZUH_SQPREV = '" + ZUD->ZUD_SQPREV + "'" 						  														+ CRLF
cQry += "  AND D_E_L_E_T_ = ' '" 											  														+ CRLF
cQry += "ORDER BY ZUH_FILIAL,ZUH_SQPROT,ZUH_SBPROT,ZUH_SQPROC,ZUH_SQPREV,SUBSTR(ZUH_SUGEST,4,4) ASC, SUBSTR(ZUH_SUGEST,1,2) ASC"	+ CRLF

TcQuery cQry New Alias cAliasSgPr

MHoBrw1() //Monta aHeader

If !cAliasSgPr->(EOF())

	While !cAliasSgPr->(EOF()) 
		
		aBuffer := {}
	
		For nJ := 1 to len(aHeader)
		    
		    
		    If AllTrim(aHeader[nJ][2]) == 'RECNO'
				uBuffer := cAliasSgPr->RECNO		
			Else                      
			    uBuffer := cAliasSgPr->&(aHeader[nJ][2])
			Endif
		    
		    If aHeader[nJ][8] == 'D' .and. ValType(uBuffer) == 'C'
		    	uBuffer	:= StoD(uBuffer) 
		    ElseIf aHeader[nJ][8] == 'C' .and. ValType(uBuffer) == 'N'
		    	uBuffer	:= cValToChar(uBuffer)	
		    EndIf
		   	
		   	aAdd(aBuffer ,uBuffer)
			
		Next                     
		
		aAdd(aBuffer ,.F.)
		
		If len(aBuffer) > 1
			aAdd(aCols,aBuffer)
		EndIf
	
		cAliasSgPr->(DbSkip())
	
	EndDo

ElseIf ( lAltera .and. cAliasSgPr->(EOF()) )

	aBuffer := {}
	
	For nJ := 1 to len(aHeader)
	
		cVarBuf := AllTrim(aHeader[nJ][2])
		                              
	    If cVarBuf $ 'ZUH_SQPROT,ZUH_SBPROT,ZUH_SQPROC,ZUH_SQPREV'
		    cVarBuf	:= 'ZUD->' + Replace(cVarBuf,'ZUH','ZUD')
		    uBuffer := &cVarBuf 
		ElseIf cVarBuf == 'RECNO'
			uBuffer := -1		
		Else
			uBuffer := Space(TamSX3(cVarBuf)[1])
		EndIf
	    
	    If aHeader[nJ][8] == 'D' .and. ValType(uBuffer) == 'C'
	    	uBuffer	:= StoD(uBuffer) 
	    ElseIf aHeader[nJ][8] == 'C' .and. ValType(uBuffer) == 'N'
	    	uBuffer	:= cValToChar(uBuffer)	
	    EndIf
	   	
	   	aAdd(aBuffer ,uBuffer)
	   	
	Next
	
   	aAdd(aBuffer ,.F.)
	
	If len(aBuffer) > 1
		aAdd(aCols,aBuffer)
	EndIf
	
EndIf

cAliasSgPr->(DbCloseArea())

RestArea(aArea)

Return 

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 23/07/13  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function GrvAtu(oGetNDad)

Local nI 		:= 0
Local nJ 		:= 0
Local nPosRecno	:= aScan(oBrw1:aHeader,{|x|x[2] == 'RECNO'})
Local n_Recno	:= 0

ProcRegua(0)                        

For nI := 1 to 5
	IncProc('Gravando registros...')
Next 
      
For nI := 1 to len(oGetNDad:aCols)

	n_Recno := oGetNDad:aCols[nI][nPosRecno]

    If oGetNDad:aCols[nI][len(oGetNDad:aHeader) + 1] .and. ( n_Recno <> -1  )//Ultimo campo no aCols informa se esta deletado
	
		//ÚÄÄÄÄÄÄÄ¿
		//³Deletar³
		//ÀÄÄÄÄÄÄÄÙ  
		
		ZUH->(DbGoTo(n_Recno))
		ZUH->(Reclock('ZUH',.F.))
		ZUH->(DbDelete())
		ZUH->(MsUnlock())
			
	ElseIf ( n_Recno == -1  )
	
		//ÚÄÄÄÄÄÄÄ¿
		//³Incluir³
		//ÀÄÄÄÄÄÄÄÙ
		
		ZUH->(Reclock('ZUH',.T.))
		
		ZUH->ZUH_FILIAL := xFilial('ZUH')
		
		For nJ := 1 to len(oGetNDad:aHeader)
		   
			c_CpoInc := oGetNDad:aHeader[nJ][2]
			
			Do Case

				Case AllTrim(c_CpoInc) == 'ZUH_TIPO'
					ZUH->ZUH_TIPO := 'I'//Informado
				
				Case AllTrim(c_CpoInc) == 'ZUH_MODO'
					ZUH->ZUH_MODO 	:= 'I'//Informado
			
				Case c_CpoInc <> 'RECNO'
					ZUH->(&c_CpoInc) := oGetNDad:aCols[nI][nJ]
			
			EndCase
			
		Next	
	
		ZUH->(MsUnlock())
		
	Else
	
		//ÚÄÄÄÄÄÄÄ¿
		//³Alterar³
		//ÀÄÄÄÄÄÄÄÙ  
        
        nJ := aScan(oGetNDad:aHeader,{|x|AllTrim(x[2]) == 'ZUH_SUGEST'})
        
        ZUH->(DbGoTo(n_Recno))
        
		If ( nJ > 0 ) .and. ( ZUH->ZUH_SUGEST <> oGetNDad:aCols[nI][nJ]) //Se houve alteracao na Sugestao
		
			ZUH->(Reclock('ZUH',.F.))
			
			For nJ := 1 to len(oGetNDad:aHeader)
				c_CpoAlt := oGetNDad:aHeader[nJ][2]
				
				Do Case
	
					Case AllTrim(c_CpoAlt) == 'ZUH_TIPO'
						ZUH->ZUH_TIPO := 'I'//Informado
					
					Case AllTrim(c_CpoAlt) == 'ZUH_MODO'
						ZUH->ZUH_MODO 	:= 'I'//Informado
				
					Case ( c_CpoAlt <> 'RECNO' ) .and. ( ZUH->(&c_CpoAlt) <> oGetNDad:aCols[nI][nJ] )
		    			ZUH->(&c_CpoAlt) := oGetNDad:aCols[nI][nJ]
				
				EndCase
				
			Next	
		
			ZUH->(MsUnlock())
			
		EndIf
		
	EndIf   
	
Next

Return

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 23/07/13 - Monta aHeader da MsNewGetDados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function MHoBrw1()    

Local nI 	:= 0
Local aArea	:= GetArea()  

DbSelectArea("SX3")
DbSetOrder(2)//CAMPO

For nI := 1 to len(aCampos)

	If MsSeek(aCampos[nI])
	
	   If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
                                          
	   		aAdd(aHeader,{Trim(X3Titulo())													 		,;
	           SX3->X3_CAMPO				   														,; 
	           SX3->X3_PICTURE																		,;
	           SX3->X3_TAMANHO					 													,;
	           SX3->X3_DECIMAL					  													,;
	           ""																					,;
	           ""							   														,;
	           SX3->X3_TIPO						 													,;
	           ""														  							,;
	           "" } ) 
				           
	   EndIf
	
	   DbSkip()
	   
	EndIf   

Next

aAdd(aHeader,{	'RECNO'		,;
	           	'RECNO'		,;
	           	''	   		,;
	           	10	 		,;
	           	0			,;
	           	""			,;
	           	""			,;
	           	'N'			,;
	           	""			,;
	           	"" } )
	           
RestArea(aArea)

Return

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 19/08/13 - Edicao de varios ZUD na mesma ³
//³matricula.                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function EditMult(cMat,cNom,cRecZUDAt,aInfPrSel)

Local aArea		:= GetArea()                       
Local bOk 		:= {||AltPrMul(cRecZUDAt),U_INCSUG(cRecZUDAt),oDlgM:End()}
Local bCancel 	:= {||oDlgM:End()}

Private cMatric    := cMat
Private cNome      := cNom
Private dPrevFim   := StoD('')
Private dPrevIni   := dDataBase

SetPrvt("oDlgM","oGrp1","oSay1","oSay2","oSay3","oSay4","oGet1","oGet2","oGet3","oGet4")

oDlgM      	:= MSDialog():New( 105,232,405,875,"Protocolo de Atendimento - Edição Múltipla",,,.F.,,,,,,.T.,,,.T. )

oLBox1     	:= TListBox():New( 016,004,,aInfPrSel,315,040,,oDlgM,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )

oGrp1      	:= TGroup():New( 066,004,128,320,"",oDlgM,CLR_BLACK,CLR_WHITE,.T.,.F. )

oSay1      	:= TSay():New( 069,008,{||"Matrícula"} 	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay2      	:= TSay():New( 082,008,{||"Nome"}			,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,024,008)
oSay3      	:= TSay():New( 096,008,{||"Prévia Ini."}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE	,CLR_WHITE,032,008)
oSay4      	:= TSay():New( 110,008,{||"Prévia Fim"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLUE	,CLR_WHITE,032,008)

oGet1      	:= TGet():New( 069,036,{|u| If(PCount()>0,cMatric:=u,cMatric)}	,oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cMatric"		,,)
oGet2      	:= TGet():New( 082,036,{|u| If(PCount()>0,cNome:=u,cNome)}		,oGrp1,272,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.T.,.F.,"","cNome"		,,)
oGet3      	:= TGet():New( 096,036,{|u| If(PCount()>0,dPrevIni:=u,dPrevIni)}	,oGrp1,040,008,'',{||U_VALIDATA(1, dPrevIni, dPrevFim)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dPrevIni"	,,)
oGet4      	:= TGet():New( 110,036,{|u| If(PCount()>0,dPrevFim:=u,dPrevFim)}	,oGrp1,040,008,'',{||U_VALIDATA(2, dPrevIni, dPrevFim)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dPrevFim"	,,)

aButtons 	:= {{'CLOCK03',{||If(U_VALIDATA(1, dPrevIni, dPrevFim) .and. U_VALIDATA(2, dPrevIni, dPrevFim),U_TrZUHMul(.T.,cRecZUDAt,aInfPrSel),)},'Sug. Prévia'}}

oGet3:SetFocus()

oDlgM:Activate(,,,.T.,,,EnchoiceBar(oDlgM,bOk,bCancel,,aButtons))

RestArea(aArea)

Return

****************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 21/08/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function AltPrMul(cRecZUDAt)

Local aRecs := Separa(cRecZUDAt,';',.F.) 
Local nI 	:= 0 
Local nRec	:= 0

For nI := 1 to len(aRecs)
    
	nRec := Val(aRecs[nI])

	ZUD->(DbGoTo(nRec))               
	ZUD->(Reclock('ZUD',.F.))
	
	ZUD->ZUD_DTPINI 	:= dPrevIni
	ZUD->ZUD_DTPFIN 	:= dPrevFim
	
	ZUD->(MsUnlock())
	
Next

Return 

****************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 21/08/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function TrZUHMul(lAltera,cRecZUDAt,aInfPrSel) 

Local cMsg

Private aCampMul	:= {'ZUH_SUGEST','ZUH_TIPO','ZUH_MODO'}
Private aStrCpos	:= {}
Private aBrwCpos	:= {}
Private cAliasTmp  	:= GetNextAlias()     
Private aObjects 	:= {}

cMsg := 'Esta rotina permite incluir sugestões das prévias para várias prévias'  								+ CRLF 
cMsg += 'seguindo alguns critérios:'																			+ CRLF 
cMsg += '1 - Se a prévia já possuir sugestão, as informações para a prévia'										+ CRLF
cMsg += '      são incluídas e as informações já existentes são mantidas.'										+ CRLF
cMsg += '2 - Para alterar as sugestões de uma única prévia e deletar sugestões,'								+ CRLF
cMsg += '      deverá marcar somente a prévia desejada e alterar.'												+ CRLF
cMsg += '3 - Conforme itens 1 e 2, esta tela sempre iniciará vazia.'		 									+ CRLF

Aviso('ATENÇÃO',cMsg,{'Ok'},3)

Processa({||ExZUHMul(lAltera,cRecZUDAt,aInfPrSel)},'Selecionando registros...')

Return

****************************************************************************************************************************
                   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 19/08/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function ExZUHMul(lAltera,cRecZUDAt,aInfPrSel)
            
Local nCont		:= 0
Local aArea		:= GetArea()
Local nOpc 		:= If(lAltera,GD_UPDATE + GD_DELETE,0)

Private oDlg2

ProcRegua(0)

For nCont := 1 to 5
	IncProc('Selecionando registros...')
Next 

oDlg2 := MsDialog():New( 095,232,699,927,"Sugestões de Prévia de Atendimento [Múltipla edição] - " + If(lAltera,'Alterar','Visualizar'),,,.F.,,,,,,.T.,,,.T. )
                
	oLBox1     	:= TListBox():New( 020,008,,aInfPrSel,334,040,,oDlg2,,CLR_BLACK,CLR_WHITE,.T.,,,,"",,,,,,, )
	
	aHeader	:= {}
	aCols	:= {}
	
	AtBrw1Mul(lAltera)
	
	oBrw1 	:= MsNewGetDados():New(066,008,282,342,nOpc,'U_CAB77LOK',,'',,0,,'U_CAB77COK',Nil,,oDlg2,aHeader,aCols )
    
	//Nao editar o RECNO
	If ( nPosRec := aScan(oBrw1:aHeader,{|x|x[2] == 'RECNO'}) ) > 0
		oBrw1:aInfo[nPosRec][5] := 'V'
	EndIf
    
	If lAltera
		bOk 	:= {||If(Aviso('ATENÇÃO','Confirma a atualização?',{'Sim','Não'}) == 1,If(U_CAB77TOK(),(Processa({||GrvAtuMul(@oBrw1,cRecZUDAt)}),oDlg2:End()),),)}
	Else
		bok 	:= {||oDlg2:End()} 	
	EndIf
	
	bCancel	:= {||oDlg2:End()} 
	
	aBut 	:= {}
	
	If lAltera
		aAdd(aBut,{"ADICIONAR_001"	, {||IncLinha(@oBrw1)}	, "Incluir"	, "Incluir"	})
	EndIf
		
oDlg2:Activate(,,,.T.,,,EnchoiceBar(oDlg2,bOk,bCancel,,aBut))

RestArea(aArea)
		
Return

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 19/08/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function AtBrw1Mul(lAltera)

Local nJ 			:= 0
Local cAliasSgPr 	:= GetNextAlias()
Local cQry			:= ''
Local cSelect 		:= ''
Local aArea			:= GetArea()
Local cVarBuf		:= ''

MHBrw1Mul() //Monta aHeader

If lAltera

	aBuffer := {}
	
	For nJ := 1 to len(aHeader)
	
		cVarBuf := AllTrim(aHeader[nJ][2])
		                              
	    If cVarBuf == 'RECNO'
			uBuffer := -1		
		Else
			uBuffer := Space(TamSX3(cVarBuf)[1])
		EndIf
	    
	    If aHeader[nJ][8] == 'D' .and. ValType(uBuffer) == 'C'
	    	uBuffer	:= StoD(uBuffer) 
	    ElseIf aHeader[nJ][8] == 'C' .and. ValType(uBuffer) == 'N'
	    	uBuffer	:= cValToChar(uBuffer)	
	    EndIf
	   	
	   	aAdd(aBuffer ,uBuffer)
	   	
	Next
	
   	aAdd(aBuffer ,.F.)
	
	If len(aBuffer) > 1
		aAdd(aCols,aBuffer)
	EndIf
	
EndIf

RestArea(aArea)

Return 

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 19/08/13³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function GrvAtuMul(oGetNDad,cRecZUDAt)

Local nI 		:= 0
Local nJ 		:= 0
Local nK		:= 0
Local nPosRecno	:= aScan(oBrw1:aHeader,{|x|x[2] == 'RECNO'})
Local n_Recno	:= 0
Local aRecs		:= Separa(cRecZUDAt,';',.F.)

ProcRegua(0)                        

For nI := 1 to 5
	IncProc('Gravando registros...')
Next 
     
For nK := 1 to len(aRecs)
	
	ZUD->(DbGoTo(Val(aRecs[nK])))
	 
	For nI := 1 to len(oGetNDad:aCols)
	
		n_Recno := oGetNDad:aCols[nI][nPosRecno]
	
	    If oGetNDad:aCols[nI][len(oGetNDad:aHeader) + 1] .and. ( n_Recno <> -1  )//Ultimo campo no aCols informa se esta deletado
		
			//ÚÄÄÄÄÄÄÄ¿
			//³Deletar³
			//ÀÄÄÄÄÄÄÄÙ  
			Loop
				
		ElseIf ( n_Recno == -1  )
		
			//ÚÄÄÄÄÄÄÄ¿
			//³Incluir³
			//ÀÄÄÄÄÄÄÄÙ
			
			ZUH->(DbGoTop())
			ZUH->(DbSetOrder(1))
			
			lExistZUH := .F.
			cChaveZUH := xFilial('ZUH') + ZUD->ZUD_SQPROT + ZUD->ZUD_SBPROT + ZUD->ZUD_SQPROC
			
			If ZUH->(MsSeek(cChaveZUH))
			
				nPosSug 	:= aScan(oGetNDad:aHeader,{|x|x[2] == 'ZUH_SUGEST'})
				cNovaSug 	:= oGetNDad:aCols[nI][nPosSug]
				
				While cChaveZUH == ZUH->( ZUH_FILIAL + ZUH_SQPROT + ZUH_SBPROT + ZUH_SQPROC )
					
					If ( ZUH->ZUH_SQPREV == ZUD->ZUD_SQPREV ) .and. ( ZUH->ZUH_SUGEST == cNovaSug )
					   	lExistZUH := .T.
						Exit
					EndIf    
				
					ZUH->(DbSkip()) 
					
				EndDo 
				
			EndIf

			If !lExistZUH
			
				ZUH->(Reclock('ZUH',.T.))
				
				ZUH->ZUH_FILIAL := xFilial('ZUH')
				ZUH->ZUH_SQPROT := ZUD->ZUD_SQPROT
				ZUH->ZUH_SBPROT := ZUD->ZUD_SBPROT
				ZUH->ZUH_SQPROC := ZUD->ZUD_SQPROC
				ZUH->ZUH_SQPREV := ZUD->ZUD_SQPREV
				
				For nJ := 1 to len(oGetNDad:aHeader)
				   
					c_CpoInc := oGetNDad:aHeader[nJ][2]
					
					Do Case
		
						Case AllTrim(c_CpoInc) == 'ZUH_TIPO'
							ZUH->ZUH_TIPO := 'I'//Informado
						
						Case AllTrim(c_CpoInc) == 'ZUH_MODO'
							ZUH->ZUH_MODO 	:= 'I'//Informado
					
						Case c_CpoInc <> 'RECNO'
							ZUH->(&c_CpoInc) := oGetNDad:aCols[nI][nJ]
					
					EndCase
					
				Next	
			
				ZUH->(MsUnlock())
				
			EndIf
			
		Else
		
			//ÚÄÄÄÄÄÄÄ¿
			//³Alterar³
			//ÀÄÄÄÄÄÄÄÙ  
			Loop
			
		EndIf   
		
	Next 
	
Next

Return

***************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 19/08/13 - Monta aHeader da MsNewGetDados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function MHBrw1Mul()    

Local nI 	:= 0
Local aArea	:= GetArea()  

DbSelectArea("SX3")
DbSetOrder(2)//CAMPO

For nI := 1 to len(aCampMul)

	If MsSeek(aCampMul[nI])
	
	   If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
                                          
	   		aAdd(aHeader,{Trim(X3Titulo())													 		,;
	           SX3->X3_CAMPO				   														,; 
	           SX3->X3_PICTURE																		,;
	           SX3->X3_TAMANHO					 													,;
	           SX3->X3_DECIMAL					  													,;
	           ""																					,;
	           ""							   														,;
	           SX3->X3_TIPO						 													,;
	           ""														  							,;
	           "" } ) 
				           
	   EndIf
	
	   DbSkip()
	   
	EndIf   

Next

aAdd(aHeader,{	'RECNO'		,;
	           	'RECNO'		,;
	           	''	   		,;
	           	10	 		,;
	           	0			,;
	           	""			,;
	           	""			,;
	           	'N'			,;
	           	""			,;
	           	"" } )
	           
RestArea(aArea)

Return