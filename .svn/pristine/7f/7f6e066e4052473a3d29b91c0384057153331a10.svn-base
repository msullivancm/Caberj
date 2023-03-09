#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH" 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA073   ºAutor  ³Leonardo Portella   º Data ³  10/07/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Protocolo de prevencao - Inclusao de procedimentos na previaº±±
±±º          ³Busco no protocolo de prevencao ZUB os procedimentos vincu- º±±
±±º          ³lados a este protocolo ZUC e incluo nos procedimentos da    º±±
±±º          ³previa ZUD.                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA073
     
Local nI			:= 0
Local lContinua		:= .T.

Private oOk      	:= LoadBitMap(GetResources(),"LBOK")
Private oNo      	:= LoadBitMap(GetResources(),"LBNO")
Private oAtivo		:= LoadBitMap(GetResources(),"BR_VERDE")
Private oInativo	:= LoadBitMap(GetResources(),"BR_VERMELHO")

Private aObjects 	:= {}
Private aSizeAut 	:= MsAdvSize(.T.)//Vai usar Enchoice 
Private aCampos		:= {'NUPRE','MATRICULA','BA1_NOMUSR','RISCO'}
Private aStrCpos	:= {}
Private aBrwCpos	:= {}             
Private oProcess    := Nil  
Private cAliasTmp  	:= GetNextAlias()                                   
Private oCBoxNupre	:= Nil
Private cCboNUPRE 	:= ''
Private cNomeBusca	:= Space(TamSx3('BA1_NOMUSR')[1])
Private cPerg		:= 'CAB073'
Private cCboRisco	:= ''
Private idProtSeq	:= ''
Private cQryBas1	:= ''
Private cQryBas2	:= ''
Private oCBox1		:= Nil
Private lMarcDesm	:= .F.
Private cCboPrev	:= ''
Private nLISTA_PROT := (9+1)*5//5 Protocolos max
Private c_Acesso 	:= u_USRxNUPRE(.T.)

If empty(c_Acesso)
	Return
EndIf

PutSx1(cPerg,"01","Prot. Prevenção"	,"","","mv_ch1","C",TamSX3('ZUD_SQPROT')[1] + TamSX3('ZUD_SBPROT')[1],0,0,"G","","ZUBSEQ","",""	,"mv_par01","","","","","","","","","","","","","","","","",{"Informe o protocolode de atendimento"},{""},{""})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MsAdvSize()                          ³
//³-------------------------------------³
//³1 -> Linha inicial area trabalho.    ³
//³2 -> Coluna inicial area trabalho.   ³
//³3 -> Linha final area trabalho.      ³
//³4 -> Coluna final area trabalho.     ³
//³5 -> Coluna final dialog (janela).   ³
//³6 -> Linha final dialog (janela).    ³
//³7 -> Linha inicial dialog (janela).  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
          
lAjustHor	:= .T.
lAjustVert	:= .T.

aAdd( aObjects, { 100,  100, lAjustHor, lAjustVert, .T. } )

nSepHoriz 	:= 5
nSepVert	:= 5
nSepBorHor 	:= 5
nSepBorVert	:= 5
                    
aInfo  		:= { aSizeAut[1], aSizeAut[2], aSizeAut[3], aSizeAut[4], nSepHoriz, nSepVert, nSepBorHor, nSepBorVert }
aPosObj 	:= MsObjSize( aInfo, aObjects, .T. )

SX3->(DbsetOrder(2))

aAdd(aStrCpos,{'OK','C',1,0})
aAdd(aBrwCpos,{' ','OK','C',5,0,'@!'})
aAdd(aStrCpos,{'TIPO','C',10,0})
aAdd(aBrwCpos,{' ','TIPO','C',5,0,'@!'})
aAdd(aStrCpos,{'PROTOCOLO','C',12,0})
aAdd(aStrCpos,{'LISTA_PROT','C',nLISTA_PROT,0})

For nI := 1 to len(aCampos)
	   
	Do case       
	
		Case aCampos[nI] == 'MATRICULA'
		
			aAdd(aStrCpos,{'MATRICULA','C',17,0})
			aAdd(aBrwCpos,{'Matricula','MATRICULA','C',17,0,'@!'})
	
		Case aCampos[nI] == 'NUPRE'
	
			aAdd(aStrCpos,{'NUPRE','C',7,0})
			aAdd(aBrwCpos,{'Nupre','NUPRE','C',7,0,'@!'})
			
		Case aCampos[nI] == 'RISCO'

			aAdd(aStrCpos,{'RISCO','C',20,0})
			aAdd(aBrwCpos,{'Risco','RISCO','C',20,0,''})

		Otherwise 

			If aCampos[nI] == 'IDPROTOC'
			    nTamID := TamSX3('ZUD_SQPROT')[1] + TamSX3('ZUD_SBPROT')[1]

				SX3->(MsSeek("ZUD_SQPROT"))

				aAdd(aStrCpos,{'IDPROTOC',SX3->X3_TIPO,nTamID,SX3->X3_DECIMAL})
				aAdd(aBrwCpos,{SX3->X3_TITULO,'IDPROTOC',SX3->X3_TIPO,nTamID,SX3->X3_DECIMAL,AllTrim(SX3->X3_PICTURE)})      

			ElseIf SX3->(MsSeek(aCampos[nI]))   

				aAdd(aStrCpos,{SX3->X3_CAMPO,SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})

				If !(AllTrim(SX3->X3_CAMPO) $ 'ZUB_SQPROT|ZUB_SBPROT|ZUB_DESCRI' )
					aAdd(aBrwCpos,{SX3->X3_TITULO,SX3->X3_CAMPO,SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL,AllTrim(SX3->X3_PICTURE)})
				EndIf

			EndIf

	EndCase
     
Next 

Processa({||ExecSQL(idProtSeq)},AllTrim(SM0->M0_NOMECOM),"Selecionando registros...")

(cAliasTmp)->(DbGoTop())

If (cAliasTmp)->(Eof())
	MsgStop("Não foram encontrados registros!",AllTrim(SM0->M0_NOMECOM))
	Return
EndIf 

While lContinua

	lContinua := .F.
	
	DbSelectArea(cAliasTmp)
	
	(cAliasTmp)->(DbGoTop())
	
	oDlgProAt := MsDialog():New( aSizeAut[2],aSizeAut[1],aSizeAut[6],aSizeAut[5],"Prévia do protocolo de prevenção",,,.F.,,,,,,.T.,,,.T. )
	
		oBrwProAt := TcBrowse():New(aPosObj[1][1]+40,aPosObj[1][2],aPosObj[1][3],aPosObj[1][4]-45,,,,oDlgProAt,,,,,,,oDlgProAt:oFont,,,,,.T.,/*cAliasTmp*/,.T.,,.F.,,,.F.)
	
		For nI := 1 To len(aBrwCpos)
	
			nTamCpo := If(nI == 1, 15, CalcFieldSize(aBrwCpos[nI,3],aBrwCpos[nI,4],aBrwCpos[nI,5],aBrwCpos[nI,6],aBrwCpos[nI,1],oDlgProAt:oFont))
			
			If nI == 1
								
				oBrwProAt:AddColumn(TcColumn():New(aBrwCpos[nI,1],;
					&("{||If(empty(" + cAliasTmp + "->OK),oNo,oOk)}");
					,,,,"LEFT",nTamCpo,.T.,.F.,,,,,))
					
			ElseIf nI == 2
			 	
			 	oBrwProAt:AddColumn(TcColumn():New(aBrwCpos[nI,1],;
					&("{||If(AllTrim(" + cAliasTmp + "->TIPO) == 'ATIVO',oAtivo,oInativo)}");
					,,,,"LEFT",nTamCpo,.T.,.F.,,,,,)) 
					
			Else
			        
				oBrwProAt:AddColumn(TcColumn():New(aBrwCpos[nI,1],;
					&("{||" + cAliasTmp + "->" + aBrwCpos[nI,2] + "}");
					,,,,"LEFT",nTamCpo,(nI == 1),.F.,,,,,)) 
				
			EndIf
			
		Next
		
		oBrwProAt:bLDblClick   	:= {||MarcaDes()}
		
		oBrwProAt:bHeaderClick	:= {||Alert(oBrwProAt:ColPos)} 
		
		oGrp1      	:= TGroup():New( aPosObj[1][1],aPosObj[1][2],aPosObj[1][1] + 20,aPosObj[1][3] + 5,Nil,oDlgProAt,CLR_BLACK,CLR_WHITE,.T.,.F. )
		
		oCBox1     	:= TCheckBox():New( aPosObj[1][1] + 25,aPosObj[1][2],"Marca/Desmarca todos em exibição",{|u| If(PCount()>0,lMarcDesm:=u,lMarcDesm)},oDlgProAt,140,008,,,,,CLR_BLACK,CLR_WHITE,,.T.,"",, )
        oCBox1:bLClicked := {||U_CB73MAR()}
        
		oSay1	  	:= TSay():New( aPosObj[1][1] + 5,aPosObj[1][2] + 5,{||'NUPRE'},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)
		
		aItens		:= {"Todos","Niteroi","Tijuca","Bangu"}
		
		cCboNUPRE	:= aItens[1]
		oCBoxNupre 	:= TComboBox():New( aPosObj[1][1] + 5,aPosObj[1][2] + 25,{|u|If(PCount()>0,cCboNUPRE:=u,cCboNUPRE)},aItens,70,20,oGrp1,,{||FiltraBrw()},,,,.T.,,,,,,,,,'cCboNUPRE')
		
		//Leonardo Portella - 12/09/13 - Inicio - Implementacao do filtro por login nao permitindo alterar. Solicitacao Dr. Sandro
		
		Do Case 
		
			Case c_Acesso == 'NUPRE NITEROI' 
				cCboNUPRE	:= aItens[2]
				oCBoxNupre:Disable()
		
			Case c_Acesso == 'NUPRE TIJUCA' 
				cCboNUPRE	:= aItens[3]
				oCBoxNupre:Disable()
				
			Case c_Acesso == 'NUPRE BANGU' 
				cCboNUPRE	:= aItens[4]
				oCBoxNupre:Disable()
				
		EndCase
		
		//Leonardo Portella - 12/09/13 - Fim
		
		oSay2      	:= TSay():New( aPosObj[1][1] + 5,aPosObj[1][2] + 115,{||"Nome"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
		oGetNome   	:= TGet():New( aPosObj[1][1] + 5,aPosObj[1][2] + 135,{|u| If(PCount()>0,(cNomeBusca:=u,FiltraBrw()),cNomeBusca)},oGrp1,220,008,'@!',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNomeBusca",,)
		oBrwProAt:nScrollType := 1 // Scroll VCR
		
		cQryRisco 	:= "SELECT TRIM(X5_CHAVE) ||' - '|| TRIM(X5_DESCRI) DESCR_RISCO"										+ CRLF
		cQryRisco 	+= "FROM SX5010" 																						+ CRLF
		cQryRisco 	+= "WHERE D_E_L_E_T_ = ' '" 																			+ CRLF
		cQryRisco 	+= "  AND X5_FILIAL = ' '" 																				+ CRLF
		cQryRisco 	+= "  AND X5_TABELA = '96'" 																			+ CRLF
		cQryRisco 	+= "ORDER BY 1"				 																			+ CRLF
		
		cAliasRisco := GetNextAlias()
		 
		TcQuery cQryRisco New Alias cAliasRisco
		
		aItens2		:= {}
		
		While !cAliasRisco->(EOF())
		
			aAdd(aItens2,cAliasRisco->DESCR_RISCO)
		     
			cAliasRisco->(DbSkip())
			
		EndDo
		
		cAliasRisco->(DbCloseArea())
		
		oSay3	  	:= TSay():New( aPosObj[1][1] + 5,aPosObj[1][2] + 375,{||'Risco'},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)
			
		cCboRisco	:= aItens[4]
		oCBoxRisco 	:= TComboBox():New( aPosObj[1][1] + 5,aPosObj[1][2] + 395,{|u|If(PCount()>0,cCboRisco:=u,cCboRisco)},aItens2,70,20,oGrp1,,{||FiltraBrw()},,,,.T.,,,,,,,,,'cCboRisco')
		oCBoxRisco:Select(4)
		
		oSay4	  	:= TSay():New( aPosObj[1][1] + 5,aPosObj[1][2] + 485,{||'Status da Prévia'},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,236,016)
		
		aItPrev		:= {"Todos","Prévia realizada","Prévia NÃO realizada"}
		cCboPrev	:= aItens[1]
		oCBoxPrev 	:= TComboBox():New( aPosObj[1][1] + 5,aPosObj[1][2] + 530,{|u|If(PCount()>0,cCboPrev:=u,cCboPrev)},aItPrev,70,20,oGrp1,,{||FiltraBrw()},,,,.T.,,,,,,,,,'cCboPrev')
		
		FiltraBrw(.T.)
		
		bOk 	:= {||lContinua := .T.,If(MsgYesNo('Confirma a gravação dos registros?',AllTrim(SM0->M0_NOMECOM)),(Grava(),oDlgProAt:End()),)}
		bCancel := {||lContinua := .F.,oDlgProAt:End()}
			                
		aBut 	:= {{"PARAMETROS"	, {||U_Caba073Leg()}	, "Legenda"	, "Legenda"	}}
		
	oDlgProAt:Activate(,,,.T.,,,EnchoiceBar(oDlgProAt,bOk,bCancel,,aBut))
	
EndDo

If Select(cAliasTmp) <> 0
	(cAliasTmp)->(DbCloseArea())
EndIf

Return

****************************************************************************************************************************
                   
Static Function ExecSQL(idProtSeq,cMatric,lRegua)

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
            
Local nCont		:= 0
Local cQuery 	:= ''
Local cFunction	:= ''
Local cMatrPesq	:= ''
Local cProt		:= ''

Default cMatric	:= ''
Default lRegua	:= .T.

ProcRegua(0)

For nCont := 1 to 5
	IncProc('Selecionando registros...')             
Next 

cQuery := cQryBase()

If Select(cAliasTmp) <> 0
	(cAliasTmp)->(DbCloseArea())
EndIf        

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)

//Ajusta os retornos dos tipos SQL para retorno tipo ADVPL
For nI := 1 to len(aStrCpos)
	If aStrCpos[nI,2] <> 'C'
		TCSetField(cAliasTmp, aStrCpos[nI,1], aStrCpos[nI,2],aStrCpos[nI,3],aStrCpos[nI,4])
	Endif
Next

cTmp := CriaTrab(NIL,.F.)//Preciso criar um trab para dar Reclock

Copy To &cTmp

DbCloseArea()

DbUseArea(.T.,,cTmp,cAliasTmp,.T.,.T.)

(cAliasTmp)->(DbGoTop())

COUNT TO nCont

(cAliasTmp)->(DbGoTop())

ProcRegua(nCont)

While !(cAliasTmp)->(EOF())

	IncProc('Consolidando registros...')
             
    cProt 		+= (cAliasTmp)->(PROTOCOLO) + '|'
	cMatrPesq 	:= (cAliasTmp)->(MATRICULA)

	(cAliasTmp)->(DbSkip())
    
    If (cAliasTmp)->(EOF()) .or. ( cMatrPesq <> (cAliasTmp)->(MATRICULA) )			
    
	    (cAliasTmp)->(DbSkip(-1))
	
		Reclock(cAliasTmp,.F.)
		LISTA_PROT := cProt
		MsUnlock()
		
		cProt 		:= ''
		cMatrPesq 	:= ''
		
		(cAliasTmp)->(DbSkip())
	
	Else
		Reclock(cAliasTmp,.F.) 
	    (cAliasTmp)->(DbDelete())
		MsUnlock()
	EndIf
	
EndDo

Return

**************************************************************************************************************************** 

User Function CB73MAR

Local aArea		:= GetArea()
Local nI 		:= 0

DbGoTop()
                
//Filtro ja esta aplicado e quem nao esta no filtro nao eh exibido no loop abaixo
While !EOF()
              
    Reclock(cAliasTmp,.F.) 
    
	If lMarcDesm
		OK := 'X'
	Else
		OK := ' '
	EndIf 
	
	MsUnlock()
	
	DbSkip()

EndDo

oBrwProAt:DrawSelect()

RestArea(aArea)

Return

**************************************************************************************************************************** 

Static Function cQryBase

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cQuery 		:= ''
Local cSelect		:= ''

cSelect += "SELECT *" 		+ CRLF
cSelect += "FROM" 			+ CRLF
cSelect += "(" 				+ CRLF
cSelect += "SELECT DISTINCT ' ' OK, ZUB_SQPROT||ZUB_SBPROT PROTOCOLO, CASE WHEN BENEF_PREVIA_ATEND(BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO, ZUB_SQPROT||ZUB_SBPROT) = 'N' THEN 'INATIVO' ELSE 'ATIVO' END TIPO" + CRLF 

For nI := 1 to len(aCampos) 

	Do Case

		Case ( aCampos[nI] == 'NUPRE' )
			cSelect += ",DECODE(RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,TO_CHAR(SYSDATE,'YYYYMMDD')),'1','NITEROI','2','TIJUCA','3','BANGU') NUPRE"
	
		Case ( aCampos[nI] == 'MATRICULA' )
			cSelect += ',BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRICULA'
			
		Case ( aCampos[nI] == 'IDPROTOC' )
			cSelect += ",ZUB_SQPROT||ZUB_SBPROT IDPROTOC"
			
		Case ( aCampos[nI] == 'RISCO' )
			//Somente Caberj 
			cSelect += CRLF + ",(SELECT TRIM(X5_CHAVE) ||' - '|| TRIM(X5_DESCRI) FROM SX5010 WHERE D_E_L_E_T_ = ' ' AND X5_FILIAL = ' ' AND X5_TABELA = '96' AND TRIM(X5_CHAVE) = TRIM(RETORNA_RISCO_PROTOCOLO(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG))) RISCO" + CRLF
	
		Otherwise
			cSelect += ',' + aCampos[nI]
						
	EndCase

Next

cSelect += ",'" + Space(nLISTA_PROT) + "' LISTA_PROT" 																								+ CRLF

//Somente Caberj

//Entrevista Qualificada (BXA)
//Respostas do Usuario (BXB)
//CASO 1 - Se o protocolo tiver perguntas, eu so posso coloca-lo se as respostas estiverem conforme parametrizado                                   

cQuery += cSelect 																																	+ CRLF	
cQuery += "FROM ZUB010 ZUB" 	  																		 											+ CRLF 
cQuery += "INNER JOIN ZUA010 ZUA ON ZUA_FILIAL = ' '" 			  																					+ CRLF
cQuery += "  AND ZUB_SQPROT = ZUA_SQPROT" 	  														   												+ CRLF
cQuery += "  AND ZUB_SBPROT = ZUA_SEQUEN" 	  																 										+ CRLF
cQuery += "  AND ZUA.D_E_L_E_T_ = ' '" 	  																											+ CRLF
cQuery += "INNER JOIN BA1010 BA1 ON BA1.D_E_L_E_T_ = ' '" 	  												  										+ CRLF
cQuery += "  AND BA1_DATBLO = ' '" 	  																	  											+ CRLF
cQuery += "  AND ((BA1_SEXO  = ZUB_SEXO) OR ZUB_SEXO = '3')" 	  																					+ CRLF
cQuery += "  AND IDADE_S(BA1_DATNAS) BETWEEN ZUB_IDINI AND ZUB_IDFIN" 	  									  										+ CRLF

//So vai estar em Nupre se estiver no AAG (vide RETORNA_NUCLEO_MS). Colocando este filtro aqui a query executa mais rapido
cQuery += "INNER JOIN BF4010 BF4 ON BF4_FILIAL = '  '" 																								+ CRLF
cQuery += "  AND BF4_CODINT = BA1_CODINT" 																					 						+ CRLF
cQuery += "  AND BF4_CODEMP = BA1_CODEMP" 																						  					+ CRLF
cQuery += "  AND BF4_MATRIC = BA1_MATRIC" 																						 					+ CRLF
cQuery += "  AND BF4_TIPREG = BA1_TIPREG" 																					   						+ CRLF
cQuery += "  AND BF4_CODPRO = '0041'" 																						 						+ CRLF
cQuery += "  AND BF4.D_E_L_E_T_=' '" 																						 						+ CRLF

cQuery += "INNER JOIN BXB010 BXB ON BXB_FILIAL = ZUA_FILIAL" 	  											 										+ CRLF
cQuery += "  AND BXB_PROQUE = ZUA_PROQUE" 	  																										+ CRLF
cQuery += "  AND BXB_CODQUE = ZUA_CODQUE" 	  																										+ CRLF
cQuery += "  AND BXB_CODPER = ZUA_CODPER" 	  															  											+ CRLF
cQuery += "  AND BXB_CODRES = ZUA_CODRES" 	  														   												+ CRLF
cQuery += "  AND BXB.D_E_L_E_T_ = ' '" 	  																	 										+ CRLF
cQuery += "INNER JOIN BXA010 BXA ON BXA_FILIAL = BXB_FILIAL" 	  																					+ CRLF
cQuery += "  AND BA1_FILIAL = BXA_FILIAL" 	  															   											+ CRLF
cQuery += "  AND BXA_NUMERO = BXB_NUMERO" 	  																										+ CRLF
cQuery += "  AND BA1_CODINT = SUBSTR(BXA_USUARI,01,4)" 	  																							+ CRLF
cQuery += "  AND BA1_CODEMP = SUBSTR(BXA_USUARI,05,4)" 	  													 										+ CRLF  
cQuery += "  AND BA1_MATRIC = SUBSTR(BXA_USUARI,09,6)" 	  													 										+ CRLF  
cQuery += "  AND BA1_TIPREG = SUBSTR(BXA_USUARI,15,2)" 	  													 										+ CRLF  
cQuery += "  AND BA1_DIGITO = SUBSTR(BXA_USUARI,17,1)" 	  												  											+ CRLF
cQuery += "  AND BXA.D_E_L_E_T_ = ' '" 	  																   											+ CRLF
cQuery += "  AND BXA_NUMERO = (" 	  																	   											+ CRLF 
cQuery += "                      SELECT MAX(BXA2.BXA_NUMERO)" 	  																					+ CRLF
cQuery += "                      FROM BXA010 BXA2" 	  													  											+ CRLF
cQuery += "                      WHERE BXA2.BXA_FILIAL = BXA.BXA_FILIAL" 	  							   											+ CRLF
cQuery += "                        AND BXA2.BXA_USUARI = BXA.BXA_USUARI" 	  				  														+ CRLF
cQuery += "                        AND BXA2.BXA_PROQUE = BXA.BXA_PROQUE" 	  						 												+ CRLF
cQuery += "                        AND BXA2.BXA_CODQUE = BXA.BXA_CODQUE" 	  					  													+ CRLF
cQuery += "                        AND BXA2.D_E_L_E_T_ = ' '" 	  								   													+ CRLF
cQuery += "                    )" 	  																												+ CRLF
cQuery += "WHERE ZUB_FILIAL = ' '" 	  																		 										+ CRLF
cQuery += "  AND ZUB_SQPROT = ZUA_SQPROT" 	  																  						 				+ CRLF
cQuery += "  AND ZUB_SBPROT = ZUA_SEQUEN" 	  																		 				  				+ CRLF
cQuery += "  AND ( '" + DtoS(dDataBase) + "' >= ZUB_VIGINI AND ( ZUB_VIGFIN = ' '  OR '" + DtoS(dDataBase) + "' <= ZUB_VIGFIN ) )" 				+ CRLF
cQuery += "  AND ZUB.D_E_L_E_T_ = ' '" 	  												   															+ CRLF
cQuery += "GROUP BY BENEF_PREVIA_ATEND(BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO, ZUB_SQPROT||ZUB_SBPROT)," 			  			+ CRLF
cQuery += "  RETORNA_NUCLEO_MS(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,TO_CHAR(SYSDATE,'YYYYMMDD')),"			 					 			+ CRLF
cQuery += "  BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO ,BA1_NOMUSR,ZUB_SQPROT,ZUB_SBPROT,ZUB_DESCRI,"					  			+ CRLF
cQuery += "  RETORNA_RISCO_PROTOCOLO(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG)"	  									   				 			+ CRLF
cQuery += "HAVING COUNT(DISTINCT ZUA_CODPER) = (" 																									+ CRLF
cQuery += "                                      SELECT COUNT(ZUA_FILIAL)" 																			+ CRLF 
cQuery += "                                      FROM " + RetSqlName('ZUA') + " ZUA2"																+ CRLF 
cQuery += "                                      WHERE ZUA2.D_E_L_E_T_ = ' '" 																		+ CRLF 
cQuery += "                                         AND ZUA2.ZUA_SQPROT = ZUB_SQPROT" 																+ CRLF
cQuery += "                                         AND ZUA2.ZUA_SEQUEN = ZUB_SBPROT" 																+ CRLF 
cQuery += "                                     )"																									+ CRLF
cQuery += ")" 																																		+ CRLF
cQuery += "WHERE NUPRE IS NOT NULL"																											   		+ CRLF
cQuery += "  AND RISCO IS NOT NULL"	 																										   		+ CRLF
cQuery += " " 	 																																	+ CRLF

cQuery += "UNION"  																																	+ CRLF
cQuery += " " 	 																																	+ CRLF

//CASO 2 - Se o protocolo NAO tiver perguntas, devo incluir se o beneficiario se enquadrar nos parametros do protocolo.

cQuery += cSelect 																																	+ CRLF
cQuery += "FROM ZUB010 ZUB" 	  																		 											+ CRLF 
cQuery += "INNER JOIN BA1010 BA1 ON BA1.D_E_L_E_T_ = ' '" 	  												  										+ CRLF
cQuery += "  AND BA1_DATBLO = ' '" 	  																	  											+ CRLF
cQuery += "  AND ((BA1_SEXO  = ZUB_SEXO) OR ZUB_SEXO = '3')" 	  																					+ CRLF
cQuery += "  AND IDADE_S(BA1_DATNAS) BETWEEN ZUB_IDINI AND ZUB_IDFIN" 	  									  										+ CRLF

//So vai estar em Nupre se estiver no AAG (vide RETORNA_NUCLEO_MS). Colocando este filtro aqui a query executa mais rapido
cQuery += "INNER JOIN BF4010 BF4 ON BF4_FILIAL = '  '" 																								+ CRLF
cQuery += "  AND BF4_CODINT = BA1_CODINT" 																					 						+ CRLF
cQuery += "  AND BF4_CODEMP = BA1_CODEMP" 																						  					+ CRLF
cQuery += "  AND BF4_MATRIC = BA1_MATRIC" 																						 					+ CRLF
cQuery += "  AND BF4_TIPREG = BA1_TIPREG" 																					   						+ CRLF
cQuery += "  AND BF4_CODPRO = '0041'" 																						 						+ CRLF
cQuery += "  AND BF4.D_E_L_E_T_=' '" 																						 						+ CRLF

cQuery += "WHERE ZUB_FILIAL = ' '" 																													+ CRLF
cQuery += "  AND ( '" + DtoS(dDataBase) + "' >= ZUB_VIGINI AND ( ZUB_VIGFIN = ' '  OR '" + DtoS(dDataBase) + "' <= ZUB_VIGFIN ) )" 				+ CRLF
cQuery += "  AND ZUB.D_E_L_E_T_ = ' '" 	  															 												+ CRLF
cQuery += "  AND NOT EXISTS" 	  															  														+ CRLF
cQuery += "  (" 	  																			   													+ CRLF
cQuery += "  SELECT ZUA_FILIAL" 																													+ CRLF
cQuery += "  FROM ZUA010 ZUA" 	  																		   											+ CRLF
cQuery += "  WHERE ZUA_FILIAL = ' '" 	  																				 							+ CRLF
cQuery += "    AND ZUB_SQPROT = ZUA_SQPROT" 	  																									+ CRLF
cQuery += "    AND ZUB_SBPROT = ZUA_SEQUEN" 	  																									+ CRLF
cQuery += "    AND ZUA.D_E_L_E_T_ = ' '" 	  																			  							+ CRLF
cQuery += "  )"   												  																					+ CRLF
cQuery += "  )"   												  																					+ CRLF
cQuery += "WHERE NUPRE IS NOT NULL"																											   		+ CRLF
cQuery += "  AND RISCO IS NOT NULL"	 																										   		+ CRLF
cQuery += " " 	 																																	+ CRLF
cQuery += "ORDER BY 4,5,6"																															+ CRLF  

Return cQuery

**************************************************************************************************************************** 

Static Function FiltraBrw(lInicio)

Local cBusca 	:= AllTrim(cNomeBusca)
Local aBusca	:= Separa(cBusca,' ',.F.)
Local nK		:= 0
Local lBuscNome	:= !empty(cBusca)
Local cExprFilt	:= ''    
Local cExprFil2	:= ''

Default lInicio	:= .F.

If lBuscNome
	
	cBusca := '('

	For nK := 1 to len(aBusca)
	
		If nK > 1
			cBusca += " .and. "		
		EndIf
		 
		cBusca += "(At('" + aBusca[nK] + "',BA1_NOMUSR) > 0)"
	
	Next
	
	cBusca += ')'
	
EndIf

Do Case

	Case cCboNUPRE == "Todos"
		cExprFil2 := ''
	
	Case cCboNUPRE == "Niteroi"
		cExprFil2 := "(AllTrim(NUPRE) == 'NITEROI')"
	
	Case cCboNUPRE == "Tijuca"
		cExprFil2 := "(AllTrim(NUPRE) == 'TIJUCA')"
		
	Case cCboNUPRE == "Bangu"
		cExprFil2 := "(AllTrim(NUPRE) == 'BANGU')"
		
EndCase 

Do Case

	Case cCboPrev == "Todos"
		cExprFilt := ''

	Case cCboPrev == "Prévia realizada"
		cExprFilt := "(AllTrim(TIPO) == 'ATIVO')"
	
	Case cCboPrev == "Prévia NÃO realizada"
		cExprFilt := "(AllTrim(TIPO) == 'INATIVO')"
		
EndCase 

If lBuscNome
	If empty(cExprFilt)
	 	cExprFilt := cBusca
	Else
		cExprFilt += ' .and. ' + cBusca
	EndIf
EndIf  

If empty(cCboRisco) .or. ( Left(AllTrim(cCboRisco),3) == "4 -" )
	cBusca 	:= ''
Else
	cBusca := '('
	cBusca += "Left(AllTrim(RISCO),3) == '" + Left(AllTrim(cCboRisco),3) + "'"
	cBusca += ')'
EndIf  

If empty(cExprFilt)
 	cExprFilt := cBusca
ElseIf !empty(cBusca)
	cExprFilt += ' .and. ' + cBusca
EndIf

If empty(cExprFilt)
	cExprFilt := cExprFil2
ElseIf !empty(cExprFil2)
	cExprFilt += ' .and. ' + cExprFil2
EndIf

If ( Select() > 0 )
	SET FILTER TO &(cExprFilt)
EndIf

lMarcDesm := .F.
oCBox1:CtrlRefresh()

(cAliasTmp)->(DbGoTop())

oBrwProAt:GoBottom()
oBrwProAt:GoTop()
oBrwProAt:DrawSelect()

Return

**************************************************************************************************************************** 

Static Function Grava

Processa({||PGrava()},AllTrim(SM0->M0_NOMECOM),"Gravando alterações...")

Return

****************************************************************************************************************************

Static Function PGrava

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local nCont			:= 0
Local cQuery2		:= ''
Local cAliasTmp2	:= GetNextAlias() 
Local aArea			

(cAliasTmp)->(DbGoTop())

COUNT TO nCont

(cAliasTmp)->(DbGoTop())

ProcRegua(nCont) 

While !( lSemaforo := LockByName("CABA073.SMF",.T.,.F.) )
	
	If ( Aviso(AllTrim(SM0->M0_NOMECOM),'Existe outro usuário gravando os registros. Aguarde por favor...',{'Aguardar','Cancelar'}) == 1 )
		If MsgYesno('Deseja cancelar a operação? ( Seus dados serão perdidos... )',AllTrim(SM0->M0_NOMECOM))    
			Break		
		EndIf
	Else
		Sleep(1000)
	EndIf
	
EndDo
	
If lSemaforo

	Begin Transaction
	
	While !(cAliasTmp)->(EOF())
	                                                                                                                          
		IncProc('Gravando alterações...') 
		
		If !empty((cAliasTmp)->(OK))
		
			aSeqSubPro := Separa(AllTrim((cAliasTmp)->(LISTA_PROT)),'|',.F.) 
			
			For nI := 1 to len(aSeqSubPro)
		        
				aArea 	:= GetArea()
				
				cQrySEQ := "SELECT NVL(MAX(ZUD_SQPREV),0) SQPREV" 		  																+ CRLF
				cQrySEQ += "FROM " + RetSqlName('ZUD') + " PROTOCOLO_PREVIA" 			   												+ CRLF 
				cQrySEQ += "WHERE PROTOCOLO_PREVIA.D_E_L_E_T_ = '  '" 			 														+ CRLF
				cQrySEQ += "  AND ZUD_FILIAL = '" + xFilial('ZUD') + "'" 																+ CRLF
				cQrySEQ += "  AND ZUD_SQPROT||ZUD_SBPROT = '" + aSeqSubPro[nI] + "'"													+ CRLF
				cQrySEQ += "  AND ZUD_MATRIC = '" + (cAliasTmp)->(MATRICULA) + "'" 													+ CRLF
				
			    cAliasSEQ := GetNextAlias()
			    
			    TcQuery cQrySEQ New Alias cAliasSEQ  
			    
			    nSEQZUD := Val(cAliasSEQ->SQPREV)
			    
			    cAliasSEQ->(DbCloseArea())
			    
			    RestArea(aArea)
			    
				//Se NAO existir na ZUD vou INCLUIR os procedimentos na ZUD (PROTOCOLO_PREVIA) conforme protocolo informado por parametro e buscando os 
				//procedimentos da ZUC (PROCEDIMENTO_PROTOCOLO).
				
				cQuery2 := "SELECT DISTINCT NVL(PROTOCOLO_PREVIA.R_E_C_N_O_,0) REC,ZUB_SQPROT,ZUB_SBPROT,ZUC_SQPROC,BA1_NOMUSR,"		+ CRLF
				cQuery2 += "  ZUC_CODTAB,ZUC_CODPRO,ZUC_DESCRI"					 														+ CRLF
				cQuery2 += "FROM " + RetSqlName('ZUB') + " PROTOCOLO_DE_PREVENCAO" 														+ CRLF
				cQuery2 += "INNER JOIN " + RetSqlName('ZUC') + " PROCEDIMENTO_PROTOCOLO ON PROCEDIMENTO_PROTOCOLO.D_E_L_E_T_ = ' '" 	+ CRLF
				cQuery2 += "  AND ZUC_FILIAL = '" + xFilial('ZUC') + "'"																+ CRLF
				cQuery2 += "  AND ZUC_SQPROT = ZUB_SQPROT" 																				+ CRLF
				cQuery2 += "  AND ZUC_SBPROT = ZUB_SBPROT" 																				+ CRLF
				cQuery2 += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '" 											+ CRLF
				cQuery2 += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = '"  + (cAliasTmp)->(MATRICULA) + "'"	+ CRLF 
				cQuery2 += "LEFT JOIN " + RetSqlName('ZUD') + " PROTOCOLO_PREVIA ON PROTOCOLO_PREVIA.D_E_L_E_T_ = '  '" 				+ CRLF
				cQuery2 += "  AND ZUD_FILIAL = '" + xFilial('ZUD') + "'"																+ CRLF
				cQuery2 += "  AND ZUD_SQPROT = ZUB_SQPROT" 																				+ CRLF
				cQuery2 += "  AND ZUD_SBPROT = ZUC_SBPROT"																				+ CRLF
				cQuery2 += "  AND ZUD_SQPROC = ZUC_SQPROC"																				+ CRLF
				cQuery2 += "  AND ZUD_MATRIC = '" + (cAliasTmp)->(MATRICULA) + "'" 													+ CRLF
				cQuery2 += "  AND ZUD_ATIVO = 'S'"																						+ CRLF
				cQuery2 += "WHERE PROTOCOLO_DE_PREVENCAO.D_E_L_E_T_ = ' '" 																+ CRLF
				cQuery2 += "  AND ZUB_FILIAL = '" + xFilial('ZUB') + "'"																+ CRLF
				cQuery2 += "  AND ZUB_SQPROT||ZUB_SBPROT = '" + aSeqSubPro[nI] + "'" 	  												+ CRLF 
				
				TcQuery cQuery2 New Alias cAliasTmp2
				
				While !cAliasTmp2->(EOF())
				
					If cAliasTmp2->REC == 0
					
						ZUD->(Reclock('ZUD',.T.))
						
						ZUD->ZUD_FILIAL 	:= xFilial('ZUD')
						ZUD->ZUD_SQPROT 	:= cAliasTmp2->ZUB_SQPROT 	//Sequencial do protocolo de prevencao
						ZUD->ZUD_SBPROT		:= cAliasTmp2->ZUB_SBPROT  //Sub-sequencial do protocolo de prevencao
						ZUD->ZUD_SQPROC    	:= cAliasTmp2->ZUC_SQPROC	//Sequencial do procedimento
						ZUD->ZUD_SQPREV		:= StrZero(++nSEQZUD,TamSX3('ZUD_SQPREV')[1]) //Sequencial da previa
						ZUD->ZUD_MATRIC  	:= (cAliasTmp)->(MATRICULA)      
						ZUD->ZUD_USUARI  	:= cAliasTmp2->BA1_NOMUSR 
						ZUD->ZUD_CODTAB  	:= cAliasTmp2->ZUC_CODTAB 
						ZUD->ZUD_CODPRO  	:= cAliasTmp2->ZUC_CODPRO 
						ZUD->ZUD_ATIVO 		:= 'S'
						ZUD->ZUD_USRCRI 	:= UsrRetName(RetCodUsr())                                        
						ZUD->ZUD_DTCRI 		:= Date()
		                ZUD->ZUD_NUPRE 		:= (cAliasTmp)->NUPRE
		                	
						ZUD->(MsUnlock()) 
						 
						//Atualizar o Browse
						(cAliasTmp)->(Reclock(cAliasTmp,.F.))
			
						(cAliasTmp)->(TIPO) 	:= 'ATIVO'
						(cAliasTmp)->(OK) 		:= ' '
							
						(cAliasTmp)->(MsUnlock())
					
					Else
						ZUD->(DbGoTo(cAliasTmp2->REC))	
						
						ZUD->(Reclock('ZUD',.F.))
						
						ZUD->ZUD_ATIVO 		:= 'N'
						ZUD->ZUD_USRALT		:= UsrRetName(RetCodUsr())                                        
						ZUD->ZUD_DTALT 		:= Date() 
						
						ZUD->(MsUnlock()) 
						 
						//Atualizar o Browse
						(cAliasTmp)->(Reclock(cAliasTmp,.F.))
			
						(cAliasTmp)->(TIPO) 	:= 'INATIVO'
						(cAliasTmp)->(OK) 		:= ' '
							
						(cAliasTmp)->(MsUnlock())
						
					EndIf
				
					cAliasTmp2->(DbSkip())
				
				EndDo  
				
				cAliasTmp2->(DbCloseArea())
				
			Next
		
		EndIf
	
		(cAliasTmp)->(DbSkip())
	
	EndDo
	
	End Transaction 
	
	UnLockByName("CABA073.SMF",.T.,.F.)
	
EndIf
	
oBrwProAt:GoBottom()
oBrwProAt:GoTop()
oBrwProAt:DrawSelect()

Return

****************************************************************************************************************************

Static Function MarcaDes

(cAliasTmp)->(Reclock(cAliasTmp,.F.))
	
(cAliasTmp)->(OK) := If(empty((cAliasTmp)->(OK)),'X',' ')
	
(cAliasTmp)->(MsUnlock())

oBrwProAt:DrawSelect() 

Return

****************************************************************************************************************************

User Function Caba073Leg

BrwLegenda('Prévia do Protocolo de Prevenção', "Legenda", {	{"BR_VERDE"		, "Prévia realizada"				},;
															{"BR_VERMELHO"	, "Prévia NÃO realizada"			}})

Return Nil

****************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Leonardo Portella - 12/09/13 - Retorna o NUPRE vinculado ao usuario³
//³logado.                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function USRxNUPRE(lExibeMsg)

Local aArea    		:= GetArea()
Local aAreaBX4		:= BX4->(GetArea())
Local cRet 			:= ''
Local c_CodUsr		:= RetCodUsr()
Local c_UsrName		:= UsrRetName(c_CodUsr)

Default lExibeMsg	:= .F.

If Upper(Alltrim(c_UsrName)) $ Upper(GetNewPar("MV_YGAAAG","ADMIN")) 
	cRet := 'TODOS'
ElseIf c_CodUsr $ GetMV('MV_XGETIN') + '|' + GetMV('MV_XGERIN')
	cRet := 'TODOS'
Else

	BX4->(DbSetOrder(2))  

	If BX4->(MsSeek( xFilial("BX4") + c_CodUsr + "1" ))
	
		While !BX4->(EOF()) .and. ( BX4->(BX4_FILIAL + BX4_CODOPE + BX4_PADRAO) == xFilial("BX4") + c_CodUsr + "1" )
			
			Do Case
			
				Case BX4->BX4_YCDLOC == '053'
					cRet := 'NUPRE TIJUCA'	

				Case BX4->BX4_YCDLOC == '054'
					cRet := 'NUPRE NITEROI'	

				Case BX4->BX4_YCDLOC == '055'
					cRet := 'NUPRE BANGU'	
                
				Case BX4->BX4_YCDLOC == '999'
					cRet := 'TODOS'
				
			EndCase
						
			If !empty(cRet)	
				Exit
			EndIf
			
			BX4->(DbSkip())     
			
		Enddo
	
	Endif
	
EndIf
	
If lExibeMsg .and. empty(cRet)
	Aviso(AllTrim(SM0->M0_NOMECOM),"ATENÇÃO:" + CRLF + "Seu cadastro nao permite acessar nenhum NUPRE!",{ "Ok" })
Endif

BX4->(RestArea(aAreaBX4))
RestArea(aArea) 

Return cRet