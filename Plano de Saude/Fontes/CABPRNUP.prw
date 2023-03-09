#include "PROTHEUS.CH"
#include "TOPCONN.CH"
#include "UTILIDADES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABPRNUP	ºAutor  ³Leonardo Portella   º Data ³  08/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela para gravar os procedimentos da BD6 em uma tabela cus- º±±
±±º          ³tomizada para que alguns procedimentos nao aparecam como do º±±
±±º          ³NUPRE.                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABPRNUP

Local nQtdTot 		:= 0
Local nVlrTot		:= 0
Local nCopTot		:= 0

Private cPerg 		:= "CABPRNUP"
Private aCampTrb	:= {}
Private aCpoMsSel 	:= {}
Private lInverte	:= .F.
Private cMarca 		:= GetMark()
Private cAlias 		:= GetNextAlias()
Private cArqTrab    := ''
Private oFont 		:= TFont():New("Courier New",,15,,.T.,,,,,.F.)
Private oFont2 		:= TFont():New("Courier New",,15,,.F.,,,,,.F.)
Private aCpoCabec 	:= {'TIPO','BD6_DATPRO','BD6_CODPRO','BD6_DESPRO','FREQUENCIA','VL_APROV','VL_PARTIC','BD6_CODRDA','BD6_NOMRDA'}   
Private aCpoTrb 	:= {'TIPO','BD6_DATPRO','BD6_CODPRO','BD6_DESPRO','FREQUENCIA','VL_APROV','VL_PARTIC','BD6_CODRDA','BD6_NOMRDA','BD6_CODLDP','BD6_CODPEG','BD6_NUMERO','PAJ_CODUSR','PAJ_DTEXCL','PAJ_HREXCL','MATRICULA','NOME','NUPRE','BD6_CODOPE','PAJ_MATUSR','PAJ_REFER'}   
Private nRegs		:= 0 
Private cArqTrab	:= " "
Private cMatricula	:= " " 
Private cAnoMesRef	:= " "
Private lMarca		:= .T.
Private oMark		:= Nil

AjustaSX1()
      
If !Pergunte(cPerg,.T.)
	Return                                                                  
EndIf 

cMatricula	:= mv_par06
cAnoMesRef	:= cValToChar(mv_par03) + strZero(mv_par04 ,2)
	
MontaCpoMsSel()          
    
nRegs := GeraAliasSql()

If nRegs > 0

	// Obtem a area de trabalho e tamanho da dialog
	aSize 		:= MsAdvSize()
	
	aObjects	:= {}   
	
	aAdd( aObjects, { 150 , 150	, .T., .T. } ) 
	aAdd( aObjects, { 750 , 750	, .T., .T. } ) 
	aAdd( aObjects, { 100 , 100	, .T., .T. } ) 
	
	// Dados da area de trabalho e separacao
	aInfo 		:= {aSize[1], aSize[2], aSize[3], aSize[4], 3, 3} 
	
	// Chama MsObjSize e recebe array e tamanhos
	aPosObj 	:= MsObjSize( aInfo, aObjects,.T.) 

	DEFINE MSDIALOG oDlg1 TITLE 'Controle de procedimentos - NUPRE' From aSize[7],00 To aSize[6],aSize[5] PIXEL
	
	oScr1   	:= TScrollBox():New(oDlg1,aPosObj[1][1],aPosObj[1][2],aPosObj[1][3]-15,aPosObj[1][4]-3,.T.,.T.,.T.)
	
	nTamLin	:= 08                                        
    nPos 	:= 05
    
    oSay1   := TSay():New(nPos,05,,oScr1,,oFont,,,,.T.,CLR_BLUE	,,200,08)
	oSay1:SetText("Assistido:")    
	   	                           
	oSay2   := TSay():New(nPos,42,,oScr1,,oFont,,,,.T.,CLR_BLACK	,,200,08)
	oSay2:SetText((cAlias)->(MATRICULA) + ' - ' + (cAlias)->(NOME))
	
	nPos += nTamLin
	
	oSay3   := TSay():New(nPos,05,,oScr1,,oFont,,,,.T.,CLR_BLUE	,,200,08)
	oSay3:SetText("Nupre:")
	
	oSay4   := TSay():New(nPos,28,,oScr1,,oFont,,,,.T.,CLR_BLACK	,,200,08)
	oSay4:SetText((cAlias)->(NUPRE))
	
	oScr2  	:= TScrollBox():New(oDlg1,aPosObj[3][1],aPosObj[3][2],aPosObj[3][3]-220,aPosObj[3][4]-3,.T.,.T.,.T.)
	
	nPos 	:= 05 
    
    nQtdTot := 0
    nVlrTot	:= 0
    nCopTot	:= 0
    
    (cAlias)->(dbGoTop())
    
    (cAlias)->(dbEval({||nQtdTot += (cAlias)->(FREQUENCIA),nVlrTot += (cAlias)->(VL_APROV),nCopTot += (cAlias)->(VL_PARTIC)}))
    
    (cAlias)->(dbGoTop())
    
    oSay5   := TSay():New(nPos,05,,oScr2,,oFont,,,,.T.,CLR_GREEN	,,200,08)
	oSay5:SetText("TOTAL NUPRE")    
	   	                           
	oSay6   := TSay():New(nPos,065,,oScr2,,oFont,,,,.T.,CLR_BLACK	,,200,08)
	oSay7   := TSay():New(nPos,265,,oScr2,,oFont,,,,.T.,CLR_BLACK	,,200,08)
	oSay8   := TSay():New(nPos,465,,oScr2,,oFont,,,,.T.,CLR_BLACK	,,200,08)
	
	nPos += nTamLin
	
    oSay9   := TSay():New(nPos,05,,oScr2,,oFont,,,,.T.,CLR_RED	,,200,08)
	oSay9:SetText("TOTAL EXCLUÍDO")    
	   	                           
	oSay10  := TSay():New(nPos,065,,oScr2,,oFont,,,,.T.,CLR_BLACK	,,200,08)
	oSay11  := TSay():New(nPos,265,,oScr2,,oFont,,,,.T.,CLR_BLACK	,,200,08)
	oSay12  := TSay():New(nPos,465,,oScr2,,oFont,,,,.T.,CLR_BLACK	,,200,08)

	aColors := {}
	
	aAdd(aColors,{'u_lPRNUPCor(1)','BR_VERDE'	})
	aAdd(aColors,{'u_lPRNUPCor(2)','BR_VERMELHO'	})
	
	//Obs: MsSelect se encarrega de marcar na tabela temporaria. Nao preciso dar Reclock().
	oMark 	:= MsSelect():New(cAlias,"MARCA","u_lPRNUPMarcaLin()",aCpoMsSel,@lInverte,@cMarca,{aPosObj[2][1],aPosObj[2][2],aPosObj[2][3],aPosObj[2][4]},,,,,aColors)

	oMark:oBrowse:lhasMark 		:= .T.
	oMark:oBrowse:lCanAllmark 	:= .T.      
	
	bCancExcl := {||CancExcl(),AtuTotais(oSay6,oSay7,oSay8,oSay10,oSay11,oSay12)}
    
	aBut := {	{"PENDENTE"		,{||legenda()}								, "Legenda"				, "Legenda"		},;
			 	{"PMSZOOMIN"	,{||InfoProc()}								, "Detalhe"				, "Detalhe"		},;
				{"DEVOLNF"		,{||Processa(bCancExcl,"Aguarde...",,.F.)}	, "Cancela Exclusao"	, "Canc. Excl."	}}
		
	bOk 	:= {||Processa({||ExcluiNUPRE(),AtuTotais(oSay6,oSay7,oSay8,oSay10,oSay11,oSay12)},"Aguarde...",,.F.)}
	bCancel := {||oDlg1:End()}
	
	ACTIVATE MSDIALOG oDlg1 ON INIT ( AtuTotais(oSay6,oSay7,oSay8,oSay10,oSay11,oSay12), EnchoiceBar(oDlg1,bOk,bCancel,,aBut), lMarca := lBloqExcProc() ) CENTERED

	FechaSqlTmp(cAlias)
		
Else
	Aviso('ATENÇÃO','Não há dados para os parâmetros informados',{'Ok'})
EndIf

If Select(cAlias) > 0
	(cAlias)->(dbCloseArea())
EndIf

Return
          
************************************************************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Montagem dos campos do MsSelect aCpoMsSel³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function MontaCpoMsSel

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//{Nome, Tipo, Tamanho, Decimal}
aAdd(aCampTrb	,{"MARCA"		,"C"	,len(cMarca)	   				,0	})
aAdd(aCampTrb	,{"ALTSELECT"	,"C"	,01								,0	})
aAdd(aCampTrb	,{"NUMRECNO"	,"N"	,10								,0	})

//{Nome campo, , Titulo, Picture}
aAdd(aCpoMsSel	,{"MARCA"		,  		," " 		,""						})
              
dbSelectArea("SX3")
dbSetOrder(2)//X3_CAMPO
                       
For i := 1 to len(aCpoCabec)
         
	Do Case
		
		Case aCpoCabec[i] == "VL_APROV"
		
			aAdd(aCpoMsSel	,{"VL_APROV"  		, 		,"Valor" 		,pesqPict('BD6','BD6_VLRPAG')	})

		Case aCpoCabec[i] == "TIPO"
		
			aAdd(aCpoMsSel	,{"TIPO"	  		, 		,"Tipo"	 		,								})
                                          	
   		Case aCpoCabec[i] == "FREQUENCIA"
		
			aAdd(aCpoMsSel	,{"FREQUENCIA" 		, 		,"Qtd"	 		,"@ E 999,999"					})
		
   		Case aCpoCabec[i] == "VL_PARTIC"
		
			aAdd(aCpoMsSel	,{"VL_PARTIC" 		, 		,"Vl Copart"	,pesqPict('BD6','BD6_VLRPAG')	})

		Otherwise
   		    
   			If MsSeek(aCpoCabec[i])
				aAdd(aCpoMsSel	,{X3_CAMPO,			,X3_TITULO	,X3_PICTURE})
			EndIf
   		
	EndCase
		
Next    

For j := 1 to len(aCpoTrb)
         
	Do Case

		Case aCpoTrb[j] == "TIPO"

			aAdd(aCampTrb	,{"TIPO"			,"C"	,15								,0	})

		Case aCpoTrb[j] == "VL_APROV"

			aAdd(aCampTrb	,{"VL_APROV"		,"N"    ,TamSx3('BD6_VLRPAG')[1]		,2	})
		
		Case aCpoTrb[j] == "VL_PARTIC"

			aAdd(aCampTrb	,{"VL_PARTIC"		,"N"    ,TamSx3('BD6_VLRPAG')[1]		,2	})
			
		Case aCpoTrb[j] == "MATRICULA"

			aAdd(aCampTrb	,{"MATRICULA"		,"C"    ,21								,0	})

		Case aCpoTrb[j] == "NOME"

			aAdd(aCampTrb	,{"NOME"			,"C"    ,TamSx3('BD6_NOMUSR')[1]		,0	})

		Case aCpoTrb[j] == "NUPRE"

			aAdd(aCampTrb	,{"NUPRE"			,"C"    ,50								,0	})
	
		Case aCpoTrb[j] == "FREQUENCIA"

			aAdd(aCampTrb	,{"FREQUENCIA"		,"N"    ,6								,0	})

		Otherwise
		
			If MsSeek(aCpoTrb[j])
				aAdd(aCampTrb	,{X3_CAMPO,X3_TIPO	,X3_TAMANHO	,X3_DECIMAL})
			EndIf
	
	EndCase
	
Next    

Return                         

************************************************************************************************************************************

Static Function GeraAliasSql

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cQuery 	:= ''
Local cSelect 	:= ''
Local nCont 	:= 0

For i := 1 to len(aCpoTrb)
    
	If allTrim(Upper(aCpoTrb[i])) $ 'PAJ_CODUSR|PAJ_DTEXCL|PAJ_HREXCL|PAJ_MATUSR|PAJ_REFER'
	     
		cSelect += "NVL(" + aCpoTrb[i] + ",' ') " + aCpoTrb[i] + ','
	
	ElseIf allTrim(Upper(aCpoTrb[i])) $ 'NUPRE'
	
		cSelect += "NVL(" + aCpoTrb[i] + ",'-') " + aCpoTrb[i] + ',' //Caso o NUPRE tenha retornado Null, provavelmente foi um obito
	
	//Leonardo Portella - 31/05/11 - Apos atualizacao do binario e updates, comecou a ocorrer erro de coluna definida ambiguamente. 
	//Solucionado colocando o alias da tabela antes do nome do campo.
	ElseIf upper(left(aCpoTrb[i],3)) == 'BD6'
	
		cSelect += 'BD6.' + aCpoTrb[i] + ','
	
	Else
	
		cSelect += aCpoTrb[i] + ','
		
	EndIf
	
Next                             

//A query devera conter o D_E_L_E_T_ e o R_E_C_N_O_ para utilizar com a funcao SqlToTmp
cSelect += "BD6.D_E_L_E_T_,BD6.R_E_C_N_O_" 

cQuery += "SELECT 	CASE WHEN PAJ_CODUSR IS NULL THEN '" + cMarca + "' ELSE ' ' END MARCA,"																+ CRLF 
cQuery += "			CASE WHEN PAJ_CODUSR IS NULL THEN 'S' ELSE 'N' END ALTSELECT,"																		+ CRLF 
cQuery += "			BD6.R_E_C_N_O_ NUMRECNO," + cSelect 																								+ CRLF
cQuery += "FROM (" + TabNupre() + ")" 	 																												+ CRLF
cQuery += "LEFT JOIN " + RetSqlName('PAJ') + " PAJ ON PAJ.D_E_L_E_T_ = ' ' AND PAJ_FILIAL = '" + xFilial("PAJ") + "'  AND PAJ_RECBD6 = RECNO"			+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BD6') + " BD6 ON BD6.D_E_L_E_T_ = ' ' AND BD6_FILIAL = '" + xFilial("BD6") + "'  AND BD6.R_E_C_N_O_ = RECNO" 	+ CRLF
cQuery += "WHERE BD6.D_E_L_E_T_ = ' '" 																			   										+ CRLF
cQuery += "		AND BD6.BD6_CODPRO  BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'" 																	+ CRLF

//Exclui os procedimentos odontologicos
cQuery += "		AND BD6.BD6_CODPRO NOT LIKE '99%'"					 					   																+ CRLF

cQuery += "ORDER BY NUPRE,MATRICULA,BD6_DATPRO DESC"																									+ CRLF
                
Processa({||nCont := SqlToTmp(cQuery,aCampTrb,cAlias)}) //Executa a query e gera o arquivo temporario

(cAlias)->(dbGoTop())      

Return nCont
 
************************************************************************************************************************************

Static Function legenda

aLeg := {	{"BR_VERDE"		,"Procedimento NUPRE"				},;
			{"BR_VERMELHO"	,"Procedimento excluido NUPRE"		}}

BrwLegenda("Legenda","Legenda",aLeg)

Return

************************************************************************************************************************************

User Function lPRNUPCor(nOPca)

Local lCor := .F.
           
If nOpca == 1 .and. (cAlias)->(ALTSELECT) == 'S' //Verde

	lCor := .T.        

ElseIf nOpca == 2 .and. (cAlias)->(ALTSELECT) == 'N' //Vermelho

	lCor := .T.

EndIf	

Return lCor 

************************************************************************************************************************************

User Function lPRNUPMarcaLin

//MsSelect : .T. -> nao permite marcar; .F. -> permite marcar

Local lRet := .T.

If ( !lMarca .and. Marked('MARCA') )//Bloqueio

	lRet := .T.
		
EndIf	

Return !lMarca

************************************************************************************************************************************

Static Function ExcluiNUPRE

Local cHrExclusao := Time()
        
ProcRegua(nRegs)
                     
(cAlias)->(dbGoTop())

While !(cAlias)->(EOF())
     
	IncProc('Excluindo procedimentos...')
	
	If ( (cAlias)->(ALTSELECT) == 'S' ) .and. Marked('MARCA')
	    
	    aAreaPAJ := GetArea()
	    
	    RecLock("PAJ",.T.)
		          
		PAJ->PAJ_FILIAL := xFilial("PAJ")
		PAJ->PAJ_RECBD6 := (cAlias)->(NUMRECNO)
		PAJ->PAJ_CODUSR := RetCodUsr()
		PAJ->PAJ_DTEXCL := dDataBase
		PAJ->PAJ_HREXCL := cHrExclusao
		PAJ->PAJ_MATUSR := cMatricula	
		PAJ->PAJ_REFER  := cAnoMesRef
		
		MsUnlock()       
		
		RestArea(aAreaPAJ)
		
		RecLock(cAlias,.F.)
		
		(cAlias)->(ALTSELECT) 	:= 'N'
		(cAlias)->(MARCA) 		:= ' ' 
		(cAlias)->(PAJ_RECBD6)	:= (cAlias)->(NUMRECNO)
		(cAlias)->(PAJ_CODUSR)	:= RetCodUsr()
		(cAlias)->(PAJ_DTEXCL)	:= dDataBase
		(cAlias)->(PAJ_HREXCL)	:= cHrExclusao
		(cAlias)->(PAJ_MATUSR) 	:= cMatricula	
		(cAlias)->(PAJ_REFER)  	:= cAnoMesRef
		
		MsUnlock()
		
	EndIf
	
	(cAlias)->(dbSkip())

EndDo                 
                        
(cAlias)->(dbGoTop())

Return

************************************************************************************************************************************

Static Function InfoProc
      
Local aArea := GetArea()

oDlg2      	 	:= MSDialog():New(101,240,400,715,"Procedimento: " + allTrim((cAlias)->(BD6_DESPRO)),,,.F.,,,,,,.T.,,,.T.) 
oDlg2:lEscClose := .F.

oGrp2      	 	:= TGroup():New(05,016,125,224,"Informações do procedimento",oDlg2,CLR_BLUE,CLR_WHITE,.T.,.F.)

oTBitmap1 		:= TBitmap():New(026,024,260,184,,"",.T.,oDlg2,,,.F.,.F.,,,.F.,,.T.,,.F.) 
oTBitmap1:Load(If((cAlias)->(ALTSELECT) == 'S',"BR_VERDE","BR_VERMELHO"),)
oTBitmap1:lAutoSize := .T.  
     
oSay01     	 	:= TSay():New( 026,036,{||"Status: "																			},oGrp2,,oFont	,.F.,.F.,.F.,.T.,CLR_BLUE	,CLR_WHITE,025,008)
oSay02     	 	:= TSay():New( 026,066,{||If((cAlias)->(ALTSELECT) == 'S','Procedimento NUPRE','Procedimento excluido NUPRE')	},oGrp2,,oFont2	,.F.,.F.,.F.,.T.,CLR_BLACK	,CLR_WHITE,100,008)

If (cAlias)->(ALTSELECT) == 'N'

	oSay03     	 	:= TSay():New( 036,036,{||"Usuário: "																		},oGrp2,,oFont	,.F.,.F.,.F.,.T.,CLR_BLUE	,CLR_WHITE,028,008)
	oSay04     	 	:= TSay():New( 036,066,{||Capital(lower(allTrim(UsrFullName((cAlias)->(PAJ_CODUSR)))))					},oGrp2,,oFont2	,.F.,.F.,.F.,.T.,CLR_BLACK	,CLR_WHITE,100,008)

	oSay05     	 	:= TSay():New( 046,036,{||"Data: "																			},oGrp2,,oFont	,.F.,.F.,.F.,.T.,CLR_BLUE	,CLR_WHITE,028,008)
	oSay06     	 	:= TSay():New( 046,066,{||DtoC((cAlias)->(PAJ_DTEXCL))													},oGrp2,,oFont2	,.F.,.F.,.F.,.T.,CLR_BLACK	,CLR_WHITE,100,008)

	oSay07     	 	:= TSay():New( 056,036,{||"Hora: "																			},oGrp2,,oFont	,.F.,.F.,.F.,.T.,CLR_BLUE	,CLR_WHITE,028,008)
	oSay08     	 	:= TSay():New( 056,066,{||(cAlias)->(PAJ_HREXCL)															},oGrp2,,oFont2	,.F.,.F.,.F.,.T.,CLR_BLACK	,CLR_WHITE,100,008)

EndIf
                                                                    
oSBtn2 := SButton():New( 130,198,01,{||oDlg2:End()},oDlg2,.T.,,)

oDlg2:Activate(,,,.T.)    

RestArea(aArea)	

Return

************************************************************************************************************************************
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para cancelar a exclusao. Permite cancelar somente ³
//³em um prazo de n dias uteis apos a exclusao, definido pelo³
//³MV_XDIANUP.                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function CancExcl
              
Local nDiasRet 	:= SuperGetMv('MV_XDIANUP')
Local cLog		:= ''

ProcRegua(nRegs)
                     
(cAlias)->(dbGoTop())

While !(cAlias)->(EOF())
     
	IncProc('Cancelando exclusão de procedimentos...')
	
	If Marked('MARCA') 
	       
		aPodeExcCanc := aPodeExcCanc(nDiasRet)      
		
		If aPodeExcCanc[1]
        
			dbSelectArea('PAJ')
			dbSetOrder(1)
			
			If MsSeek(xFilial('PAJ') + cValToChar((cAlias)->(NUMRECNO)))
		    	
		    	RecLock('PAJ',.F.)
		    	
		    	PAJ->(dbDelete())
		    	
		    	MsUnlock()
		    	
			  	RecLock(cAlias,.F.)
				
				(cAlias)->(ALTSELECT) 	:= 'S'
				(cAlias)->(MARCA) 		:= cMarca 
				(cAlias)->(PAJ_RECBD6)	:= Nil
				(cAlias)->(PAJ_CODUSR)	:= Nil
				(cAlias)->(PAJ_DTEXCL)	:= Nil
				(cAlias)->(PAJ_HREXCL)	:= Nil
				(cAlias)->(PAJ_MATUSR) 	:= Nil
				(cAlias)->(PAJ_REFER)	:= Nil
		
				MsUnlock()
	
		    EndIf
	    
	    ElseIf !empty(aPodeExcCanc[2])
	    	
	    	cLog += '- O procedimento: ' + allTrim((cAlias)->(BD6_CODPRO)) + ' - ' + allTrim((cAlias)->(BD6_DESPRO)) 			
	    	cLog += ' excluído no dia (' + DtoC(aPodeExcCanc[2]) + ') não pode ter sua exclusão cancelada pois sua' 	
	    	cLog += ' data limite para exclusão (' + DtoC(aPodeExcCanc[3]) + ') foi ultrapassada.' + CRLF + CRLF						
	    	
		ElseIf empty(aPodeExcCanc[2])
	    	
	    	cLog += '- O procedimento: ' + allTrim((cAlias)->(BD6_CODPRO)) + ' - ' + allTrim((cAlias)->(BD6_DESPRO)) 			
	    	cLog += ' não se encontra cancelado.' + CRLF + CRLF						
	    
	    EndIf

	EndIf
	
	(cAlias)->(dbSkip())

EndDo                 
                        
(cAlias)->(dbGoTop())

If !empty(cLog)

	LogErros(cLog,'Procedimentos não cancelados - ' + DtoC(dDataBase))

EndIf

Return

************************************************************************************************************************************
                
Static Function aPodeExcCanc(nDiasRetroc)

Local dLimite             
Local dExclusao := (cAlias)->(PAJ_DTEXCL)
Local lRet 		:= .F.     

If !empty(dExclusao)

	dLimite := dataValida(dExclusao + nDiasRetroc, .T.) //Retorna 'nDiasRetroc' dias uteis posteriores a data informada
	
	lRet := ( dDataBase <= dLimite )
	
EndIf
	
Return {lRet,dExclusao,dLimite}

************************************************************************************************************************************

Static Function lBloqExcProc       

Local cLogCanc 	:= 'Não poderão ocorrer exclusões no período referência informado pois o mesmo já teve exclusão conforme abaixo:' + CRLF + CRLF      
Local nDiasRet 	:= SuperGetMv('MV_XDIANUP')
Local lRet		:= .T.

(cAlias)->(dbGoTop())

While !(cAlias)->(EOF())
                     
	aPodeCanc := aPodeCanc(nDiasRet)     
     
	If !aPodeCanc[1] .and. !empty(aPodeCanc[2])//Existe pelo menos 1 que foi cancelado no periodo de referencia e nao esta no prazo de cancelamento
		
		lRet := .F.
				
		cLogCanc += '- Procedimento: ' + allTrim((cAlias)->(BD6_CODPRO)) + ' - ' + allTrim((cAlias)->(BD6_DESPRO)) 			
	    cLogCanc += ' excluído no dia ' + DtoC(aPodeCanc[2]) + '. Data limite para exclusão: ' + DtoC(aPodeCanc[3]) + CRLF + CRLF

	EndIf
	
	(cAlias)->(dbSkip())

EndDo

If !lRet

	LogErros(cLogCanc,'Bloqueio de exclusão de procedimentos - ' + DtoC(dDataBase))
	
	cQryDesm := "UPDATE " + cAlias + " SET MARCA = ' ',ALTSELECT = ' '"
	
	TcSqlExec(cQryDesm)
	
  	(cAlias)->(dbGoTop())
	
	oMark:oBrowse:Refresh() 
	
	oMark:oBrowse:GoTop()

EndIf

(cAlias)->(dbGoTop())

Return lRet

************************************************************************************************************************************

Static Function aPodeCanc(nDiasRetroc)

Local dLimite             
Local dExclusao 	:= (cAlias)->(PAJ_DTEXCL) 
Local lRet 			:= .F.     

If cAnoMesRef == (cAlias)->(PAJ_REFER) .and. cMatricula == (cAlias)->(PAJ_MATUSR)
 
	If !empty(dExclusao)
	
		dLimite := dataValida(dExclusao + nDiasRetroc, .T.) //Retorna 'nDiasRetroc' dias uteis posteriores a data informada
		
		lRet := ( dDataBase <= dLimite )
		
	EndIf

EndIf
	
Return {lRet,dExclusao,dLimite}

************************************************************************************************************************************

Static Function AtuTotais(oSayQtd,oSayVlr,oSayCop,oSayExQtd,oSayExVlr,oSayExCop)

Local nQtdTot 	:= 0
Local nVlrTot	:= 0
Local nCopTot	:= 0
Local nExQtdTot := 0
Local nExVlrTot	:= 0
Local nExCopTot	:= 0
    
(cAlias)->(dbGoTop())
    
(cAlias)->(dbEval({||If((cAlias)->(ALTSELECT) == 'S',;
						( nQtdTot += (cAlias)->(FREQUENCIA)	,nVlrTot += (cAlias)->(VL_APROV)	,nCopTot += (cAlias)->(VL_PARTIC) )	,;
						( nExQtdTot += (cAlias)->(FREQUENCIA)	,nExVlrTot += (cAlias)->(VL_APROV)	,nExCopTot += (cAlias)->(VL_PARTIC) )	)})) 

(cAlias)->(dbGoTop())
    
oSayQtd:SetText("Quantidade: " + allTrim(Transform(nQtdTot,"@ E 999,999")))

oSayVlr:SetText("Valor pago: " + allTrim(Transform(nVlrTot,pesqPict('BD6','BD6_VLRPAG'))))

oSayCop:SetText("Valor Coparticipação: " + allTrim(Transform(nCopTot,pesqPict('BD6','BD6_VLRPAG'))))

oSayExQtd:SetText("Quantidade: " + allTrim(Transform(nExQtdTot,"@ E 999,999")))

oSayExVlr:SetText("Valor pago: " + allTrim(Transform(nExVlrTot,pesqPict('BD6','BD6_VLRPAG'))))

oSayExCop:SetText("Valor Coparticipação: " + allTrim(Transform(nExCopTot,pesqPict('BD6','BD6_VLRPAG'))))

Return

************************************************************************************************************************************
                   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query desenvolvida pela analista Raquel e    ³
//³utilizada com base para os registros a serem ³
//³exibidos.                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function TabNupre
 
Local cAnoMesRef 	:= cValToChar(mv_par03) + strZero(mv_par04,2)
Local cOperUsr		:= mv_par05

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Matricula: Codigo Operadora + Codigo da Empresa + Tipo Registro + Digito Verificador³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cCodEmp 		:= substr(mv_par06	,5	,4)
Local cMatrUsr		:= substr(mv_par06	,9	,6)
Local cTipoReg		:= substr(mv_par06	,15	,2)
Local cDiaMesExtAno	:= '01-' + left(mesExtIng(mv_par04),3) + '-' + right(cValToChar(mv_par03),2)
Local cQryBuffer	:= " "

cQryBuffer := "SELECT * " 																															+ CRLF
cQryBuffer += "FROM (" 																																+ CRLF
cQryBuffer += "  	SELECT  To_Date(SubStr(BD7F.BD7_NUMLOT,1,6)||'01','yyyy/mm/dd') REFERENCIA," 													+ CRLF
cQryBuffer += "				formata_matricula_ms(BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO) Matricula ," 							+ CRLF
cQryBuffer += "				Trim(BD6_NOMUSR) NOME," 																								+ CRLF
cQryBuffer += "				Decode(RETORNA_NUCLEO_MS(BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,TO_CHAR(LAST_DAY(TO_DATE('" 
cQryBuffer += "					" + cAnoMesRef + "','YYYYMM')),'YYYYMMDD')),'1','NUPRE NITEROI','2','NUPRE TIJUCA','3','NUPRE BANGU','') NUPRE,"	+ CRLF
cQryBuffer += "				'Atendimentos' tipo," 																									+ CRLF
cQryBuffer += "	   			BD6_CODPRO," 																											+ CRLF
cQryBuffer += "				BD6_DESPRO," 																											+ CRLF
cQryBuffer += "	   			TO_DATE(BD6_DATPRO,'YYYYMMdd') DATA_PROCED," 																			+ CRLF
cQryBuffer += "				sum(QTD_EVENTO(BD6_CODPRO ,RETORNA_EVENTO_EVOL ( BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,"
cQryBuffer += "					BD6_CODPRO,BD6_MATVID,'C' ),BD6F.BD6_QTDPRO)) FREQUENCIA," 															+ CRLF
cQryBuffer += "	   			Sum(BD7F.VLRPAG) VL_APROV ," 																							+ CRLF
cQryBuffer += "	   			Sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,"
cQryBuffer += "					Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF))))VL_PARTIC," 	   												+ CRLF
cQryBuffer += "	   			BD6_CODRDA," 																											+ CRLF
cQryBuffer += "	   			PLS_RETORNA_NOME_RDA (BD6_CODRDA) NOME_RDA ," 																			+ CRLF
cQryBuffer += "	   			BD6F.R_E_C_N_O_ RECNO" 																									+ CRLF
cQryBuffer += "		FROM (" 																														+ CRLF
cQryBuffer += "      	SELECT BD7.BD7_FILIAL,BD7_CODPLA," 																							+ CRLF
cQryBuffer += "              BD7.BD7_OPELOT,BD7.BD7_NUMLOT," 																						+ CRLF
cQryBuffer += "              BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO," 							+ CRLF
cQryBuffer += "              BD7.BD7_SEQUEN, Sum(BD7.BD7_VLRPAG) AS VLRPAG" 																		+ CRLF
cQryBuffer += "      	FROM " + RetSqlName('BD7') + " BD7" 																						+ CRLF
cQryBuffer += "      	WHERE BD7.BD7_FILIAL = '" + xFilial('BD7') + "'" 																			+ CRLF
cQryBuffer += "  	    	AND BD7.BD7_CODOPE = '0001'" 																							+ CRLF
cQryBuffer += "     	 	AND BD7.BD7_SITUAC = '1'" 																								+ CRLF
cQryBuffer += "      		AND BD7.BD7_FASE = '4'" 																								+ CRLF
cQryBuffer += " 	     	AND BD7.BD7_BLOPAG <> '1'" 																								+ CRLF
cQryBuffer += "     	 	AND BD7.BD7_NUMLOT LIKE '" + cAnoMesRef + "'||'%'" 																		+ CRLF
cQryBuffer += "      		AND PLS_PRA_PROJSERV_ATIVO_MS ( BD7_OPEUSR,BD7_CODEMP,BD7_MATRIC,BD7_TIPREG ,'0041',BD7_DATPRO)='S'" 					+ CRLF
cQryBuffer += "			 	AND  BD7_OPEUSR='" + cOperUsr + "'" 																					+ CRLF
cQryBuffer += " 	     	AND  BD7_CODEMP='" + cCodEmp + "'" 																						+ CRLF
cQryBuffer += "     	 	AND  BD7_MATRIC='" + cMatrUsr + "'" 																					+ CRLF
cQryBuffer += "		      	AND  BD7_TIPREG='" + cTipoReg + "'" 																					+ CRLF
cQryBuffer += "			 	AND BD7.D_E_L_E_T_ = ' '" 																								+ CRLF
cQryBuffer += "      	GROUP BY 	BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT," 														+ CRLF
cQryBuffer += "               		BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV," 										+ CRLF
cQryBuffer += "               		BD7_SEQUEN,BD7_CODPRO) BD7F," 																					+ CRLF
cQryBuffer += "     " + RetSqlName('BD6') + " BD6F," 																								+ CRLF
cQryBuffer += "     " + RetSqlName('BR8') + " BR8" 																									+ CRLF
cQryBuffer += "WHERE BR8_FILIAL='" + xFilial('BR8') + "'" 																							+ CRLF
cQryBuffer += "      AND BD6F.BD6_FILIAL = '" + xFilial('BD6') + "'" 																				+ CRLF
cQryBuffer += "      AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL" 																						+ CRLF
cQryBuffer += "      AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE" 																						+ CRLF
cQryBuffer += "      AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP" 																						+ CRLF
cQryBuffer += "      AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG" 																						+ CRLF
cQryBuffer += "      AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO" 																						+ CRLF
cQryBuffer += "      AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV" 																						+ CRLF
cQryBuffer += "      AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN" 																						+ CRLF
cQryBuffer += "      AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO" 																						+ CRLF
cQryBuffer += "      AND VERIFICA_INICIO_CONTRATO(Nvl(trim(RETORNA_NUCLEO_MS (BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,"
cQryBuffer += "      	ULTIMO_DIA_UTIL('" + cDiaMesExtAno + "'))),RETORNA_NUCLEO_MS (BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DATPRO)),"
cQryBuffer += "      	to_date(trim(BD6_DATPRO),'YYYYMMDD'))=1" 																					+ CRLF
cQryBuffer += "      AND BR8_FILIAL=BD6_FILIAL" 																									+ CRLF
cQryBuffer += "      AND BR8_CODPAD=BD6_CODPAD" 																									+ CRLF
cQryBuffer += "      AND BR8_CODPSA=BD6_CODPRO" 																									+ CRLF
cQryBuffer += "      AND BR8.D_E_L_E_T_ = ' '" 																										+ CRLF
cQryBuffer += "      AND BD6F.D_E_L_E_T_ = ' '" 																									+ CRLF
cQryBuffer += "GROUP BY To_Date(SubStr(BD7F.BD7_NUMLOT,1,6)||'01','yyyy/mm/dd') ," 																	+ CRLF
cQryBuffer += "          formata_matricula_ms(BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)  ," 										+ CRLF
cQryBuffer += "          Trim(BD6_NOMUSR) ," 																										+ CRLF
cQryBuffer += "          Decode(RETORNA_NUCLEO_MS(BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,TO_CHAR(LAST_DAY("
cQryBuffer += "          	TO_DATE('" + cAnoMesRef + "','YYYYMM')),'YYYYMMDD')),'1','NUPRE NITEROI','2','NUPRE TIJUCA','3','NUPRE BANGU','') ," 	+ CRLF
cQryBuffer += "          BD6_CODPRO," 																												+ CRLF
cQryBuffer += "          BD6_DESPRO  ," 																											+ CRLF
cQryBuffer += "          TO_DATE(BD6_DATPRO,'YYYYMMdd') ," 																							+ CRLF
cQryBuffer += "          BD6_CODRDA," 																												+ CRLF
cQryBuffer += "          PLS_RETORNA_NOME_RDA (BD6_CODRDA)  ," 																						+ CRLF
cQryBuffer += "          BD6F.R_E_C_N_O_" 																											+ CRLF
cQryBuffer += "UNION ALL" 																															+ CRLF
cQryBuffer += "--NOVO MATERIAL MICROSIGA" 																											+ CRLF
cQryBuffer += "  SELECT" 																															+ CRLF
cQryBuffer += "             REFERENCIA ," 																											+ CRLF
cQryBuffer += "             Matricula," 																											+ CRLF
cQryBuffer += "             NOME," 																													+ CRLF
cQryBuffer += "             NUPRE," 																												+ CRLF
cQryBuffer += "             tipo," 																													+ CRLF
cQryBuffer += "             BD6_CODPRO," 																											+ CRLF
cQryBuffer += "             BD6_DESPRO ," 																											+ CRLF
cQryBuffer += "             DATA_PROCED," 																											+ CRLF
cQryBuffer += "             Sum(frequencia)," 																										+ CRLF
cQryBuffer += "             Round(Sum(VAL_APROVADO),2) VL_PAGO," 																					+ CRLF
cQryBuffer += "             sum(VL_PARTIC) VL_PARTIC ," 																							+ CRLF
cQryBuffer += "             BD6_CODRDA," 																											+ CRLF
cQryBuffer += "             NOME_RDA," 																												+ CRLF
cQryBuffer += "             RECNO" 																													+ CRLF
cQryBuffer += " FROM (" 																															+ CRLF
cQryBuffer += "  		SELECT  To_Date(SubStr(F1_EMISSAO,1,6)||'01','yyyy/mm/dd') REFERENCIA," 													+ CRLF
cQryBuffer += "          		formata_matricula_ms(BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO) Matricula ," 						+ CRLF
cQryBuffer += " 		        Trim(BD6_NOMUSR) NOME," 																							+ CRLF
cQryBuffer += "          		Decode(RETORNA_NUCLEO_MS(BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,TO_CHAR(LAST_DAY("
cQryBuffer += "          			TO_DATE('" + cAnoMesRef + "','YYYYMM')),'YYYYMMDD')),'1','NUPRE NITEROI','2',"
cQryBuffer += "          			'NUPRE TIJUCA','3','NUPRE BANGU','') NUPRE," 																	+ CRLF
cQryBuffer += "          		'Material' tipo," 																									+ CRLF
cQryBuffer += "          		BD6_CODPRO," 																										+ CRLF
cQryBuffer += "          		BD6_DESPRO  ," 																										+ CRLF
cQryBuffer += "          		TO_DATE(BD6_DATPRO,'YYYYMMdd') DATA_PROCED," 																		+ CRLF
cQryBuffer += "          		Sum(D1_QUANT)frequencia," 																							+ CRLF
cQryBuffer += "          		Sum(D1_TOTAL)-Sum(D1_VALDESC)  VAL_APROVADO," 																		+ CRLF
cQryBuffer += "          		0 VL_PARTIC," 																										+ CRLF
cQryBuffer += "          		BD6_CODRDA," 																										+ CRLF
cQryBuffer += "          		PLS_RETORNA_NOME_RDA (BD6_CODRDA) NOME_RDA ," 																		+ CRLF
cQryBuffer += "          		BD6.R_E_C_N_O_ RECNO" 																								+ CRLF
cQryBuffer += "   		FROM 	" + RetSqlName('B19') + " B19," 																					+ CRLF
cQryBuffer += "  		 		" + RetSqlName('SD1') + " SD1," 																					+ CRLF
cQryBuffer += "   				" + RetSqlName('SF1') + " SF1,"																						+ CRLF
cQryBuffer += "   				" + RetSqlName('BD6') + " BD6," 																					+ CRLF
cQryBuffer += " 		  		" + RetSqlName('SA2') + " SA2," 																					+ CRLF
cQryBuffer += "   				" + RetSqlName('BI3') + " BI3" 																						+ CRLF
cQryBuffer += "  		WHERE BI3_FILIAL = '" + xFilial('BI3') + "'" 																				+ CRLF
cQryBuffer += " 		   	AND A2_FILIAL = '" + xFilial('SA2') + "'" 																				+ CRLF
cQryBuffer += "			    AND F1_EMISSAO LIKE '" + cAnoMesRef + "'||'%'" 																			+ CRLF
cQryBuffer += "    			AND A2_COD = B19_FORNEC" 																								+ CRLF
cQryBuffer += "    			AND D1_FORNECE = A2_COD" 																								+ CRLF
cQryBuffer += "    			AND F1_FORNECE = A2_COD" 																								+ CRLF
cQryBuffer += "    			AND D1_DOC = F1_DOC" 																									+ CRLF
cQryBuffer += "    			AND B19_DOC = D1_DOC" 																									+ CRLF
cQryBuffer += "    			AND D1_ITEM = B19_ITEM" 																								+ CRLF
cQryBuffer += "    			AND BD6_FILIAL = '" + xFilial('BD6') + "'" 																				+ CRLF
cQryBuffer += "    			AND BD6_CODPLA = BI3_CODIGO" 																							+ CRLF
cQryBuffer += "    			AND BD6_CODOPE = SubStr(B19_GUIA,01,04)" 																				+ CRLF
cQryBuffer += "    			AND BD6_CODLDP = SubStr(B19_GUIA,05,04)" 																				+ CRLF
cQryBuffer += "    			AND BD6_CODPEG = SubStr(B19_GUIA,09,08)" 																				+ CRLF
cQryBuffer += "    			AND BD6_NUMERO = SubStr(B19_GUIA,17,08)" 																				+ CRLF
cQryBuffer += "    			AND BD6_ORIMOV = SubStr(B19_GUIA,25,01)" 																				+ CRLF
cQryBuffer += "    			AND BD6_SEQUEN = SubStr(B19_GUIA,26,03)" 																				+ CRLF
cQryBuffer += "    			AND BD6_OPEUSR = '" + cOperUsr + "'" 																					+ CRLF
cQryBuffer += "    			AND BD6_CODEMP = '" + cCodEmp + "'" 																					+ CRLF
cQryBuffer += "    			AND BD6_MATRIC = '" + cMatrUsr + "'" 																					+ CRLF
cQryBuffer += "    			AND BD6_TIPREG = '" + cTipoReg + "'" 																					+ CRLF
cQryBuffer += "    			AND BD6_FASE IN (3,4)" 																									+ CRLF
cQryBuffer += "    			AND BD6_CODLDP='0013'" 																									+ CRLF
cQryBuffer += "    			AND BD6_SITUAC = 1" 																									+ CRLF
cQryBuffer += "    			AND PLS_PRA_PROJSERV_ATIVO_MS ( BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG ,'0041',BD6_DATPRO)='S'" 					+ CRLF
cQryBuffer += "    			AND VERIFICA_INICIO_CONTRATO(Nvl(trim(RETORNA_NUCLEO_MS (BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,"
cQryBuffer += "    				ULTIMO_DIA_UTIL('" + cDiaMesExtAno + "'))),
cQryBuffer += "    				RETORNA_NUCLEO_MS (BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DATPRO)),"
cQryBuffer += "    				to_date(trim(BD6_DATPRO),'YYYYMMDD')) = 1" 																			+ CRLF
cQryBuffer += "    			AND SA2.D_E_L_E_T_ = ' '" 																								+ CRLF
cQryBuffer += "    			AND B19.D_E_L_E_T_ = ' '" 																								+ CRLF
cQryBuffer += "    			AND SD1.D_E_L_E_T_ = ' '" 																								+ CRLF
cQryBuffer += "    			AND SF1.D_E_L_E_T_ = ' '" 																								+ CRLF
cQryBuffer += "    			AND BD6.D_E_L_E_T_ = ' '" 																								+ CRLF
cQryBuffer += "    			AND BI3.D_E_L_E_T_ = ' '" 																								+ CRLF
cQryBuffer += " 		GROUP BY To_Date(SubStr(F1_EMISSAO,1,6)||'01','yyyy/mm/dd') ," 																+ CRLF
cQryBuffer += "   	       	formata_matricula_ms(BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO)  ," 									+ CRLF
cQryBuffer += "          	Trim(BD6_NOMUSR) ," 																									+ CRLF
cQryBuffer += "          	Decode(RETORNA_NUCLEO_MS(BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,"
cQryBuffer += "    				TO_CHAR(LAST_DAY(TO_DATE('" + cAnoMesRef + "','YYYYMM')),'YYYYMMDD')),'1','NUPRE NITEROI','2','NUPRE TIJUCA','3',"
cQryBuffer += "    				'NUPRE BANGU',''),"																									+ CRLF
cQryBuffer += "          	BD6_CODPRO," 																											+ CRLF
cQryBuffer += "          	BD6_DESPRO  ," 																											+ CRLF
cQryBuffer += "          	TO_DATE(BD6_DATPRO,'YYYYMMdd') ," 																						+ CRLF
cQryBuffer += "          	BD6_CODRDA," 																											+ CRLF
cQryBuffer += "          	PLS_RETORNA_NOME_RDA (BD6_CODRDA)  ," 																					+ CRLF
cQryBuffer += "          	BD6.R_E_C_N_O_" 																										+ CRLF
cQryBuffer += "-- coparticipacao material" 																											+ CRLF
cQryBuffer += "UNION ALL" 																															+ CRLF
cQryBuffer += "SELECT" 																																+ CRLF
cQryBuffer += " 		 To_Date(SubStr(F1_EMISSAO,1,6)||'01','yyyy/mm/dd') REFERENCIA," 															+ CRLF
cQryBuffer += "          formata_matricula_ms(BD6_OPEUSR||BD6_CODEMP||BD6_MATRIC||BD6_TIPREG||BD6_DIGITO) Matricula ," 								+ CRLF
cQryBuffer += "          Trim(BD6_NOMUSR) NOME," 																									+ CRLF
cQryBuffer += "          Decode(RETORNA_NUCLEO_MS(BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,"
cQryBuffer += "          	TO_CHAR(LAST_DAY(TO_DATE('" + cAnoMesRef + "','YYYYMM')),'YYYYMMDD')),'1','NUPRE NITEROI','2','NUPRE TIJUCA','3',"
cQryBuffer += "          	'NUPRE BANGU','') NUPRE," 																								+ CRLF
cQryBuffer += "          'Material' tipo," 																											+ CRLF
cQryBuffer += "          BD6_CODPRO," 																												+ CRLF
cQryBuffer += "          BD6_DESPRO  ," 																											+ CRLF
cQryBuffer += "          TO_DATE(BD6_DATPRO,'YYYYMMdd') DATA_PROCED," 																				+ CRLF
cQryBuffer += "          0 frequencia," 																											+ CRLF
cQryBuffer += "          0  VAL_APROVADO," 																											+ CRLF
cQryBuffer += "          Nvl( BD7_VLRTPF,0) VL_PARTIC," 																							+ CRLF
cQryBuffer += "          BD6_CODRDA," 																												+ CRLF
cQryBuffer += "          PLS_RETORNA_NOME_RDA (BD6_CODRDA) NOME_RDA ," 																				+ CRLF
cQryBuffer += "          BD6.R_E_C_N_O_ RECNO" 																										+ CRLF
cQryBuffer += "FROM " 	+ RetSqlName('B19') + " B19," 																								+ CRLF
cQryBuffer += "		" 	+ RetSqlName('SD1') + " SD1," 																								+ CRLF
cQryBuffer += "		" 	+ RetSqlName('SF1') + " SF1," 																								+ CRLF
cQryBuffer += "		" 	+ RetSqlName('BD6') + " BD6," 																								+ CRLF
cQryBuffer += "		" 	+ RetSqlName('SA2') + " SA2,"																								+ CRLF
cQryBuffer += "		" 	+ RetSqlName('BD7') + " BD7" 																								+ CRLF
cQryBuffer += "  WHERE A2_FILIAL = '" + xFilial('SA2') + "'" 																						+ CRLF
cQryBuffer += "    AND BD7_FILIAL = '" + xFilial('BD7') + "'" 																						+ CRLF
cQryBuffer += "    AND F1_EMISSAO LIKE '" + cAnoMesRef + "'||'%'" 																					+ CRLF
cQryBuffer += "	   AND A2_COD = B19_FORNEC" 																										+ CRLF
cQryBuffer += "    AND D1_FORNECE = A2_COD" 																										+ CRLF
cQryBuffer += "    AND F1_FORNECE= A2_COD" 																											+ CRLF
cQryBuffer += "    AND D1_DOC = F1_DOC" 																											+ CRLF
cQryBuffer += "    AND B19_DOC = D1_DOC" 																											+ CRLF
cQryBuffer += "    AND D1_ITEM = B19_ITEM" 																											+ CRLF
cQryBuffer += "    AND BD6_FILIAL = '" + xFilial('BD6') + "'" 																						+ CRLF
cQryBuffer += "    AND BD6_CODOPE = SubStr(B19_GUIA,01,04)" 																						+ CRLF
cQryBuffer += "    AND BD6_CODLDP = SubStr(B19_GUIA,05,04)" 																						+ CRLF
cQryBuffer += "    AND BD6_CODPEG = SubStr(B19_GUIA,09,08)" 																						+ CRLF
cQryBuffer += "    AND BD6_NUMERO = SubStr(B19_GUIA,17,08)" 																						+ CRLF
cQryBuffer += "    AND BD6_ORIMOV = SubStr(B19_GUIA,25,01)" 																						+ CRLF
cQryBuffer += "    AND BD6_OPEUSR = '" + cOperUsr + "'" 																							+ CRLF
cQryBuffer += "    AND BD6_CODEMP = '" + cCodEmp + "'" 																								+ CRLF
cQryBuffer += "    AND BD6_MATRIC = '" + cMatrUsr + "'" 																							+ CRLF
cQryBuffer += "    AND BD6_TIPREG = '" + cTipoReg + "'" 																							+ CRLF
cQryBuffer += "    AND BD6_FASE IN (3,4)" 																											+ CRLF
cQryBuffer += "    AND BD6_CODLDP = '0013'" 																										+ CRLF
cQryBuffer += "    AND BD6_CODPRO IN ('01990012','02990016','03990010')" 																			+ CRLF
cQryBuffer += "    AND PLS_PRA_PROJSERV_ATIVO_MS ( BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG ,'0041',BD6_DATPRO)='S'" 							+ CRLF
cQryBuffer += "    AND VERIFICA_INICIO_CONTRATO(Nvl(trim(RETORNA_NUCLEO_MS (BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,"
cQryBuffer += "    		ULTIMO_DIA_UTIL('" + cDiaMesExtAno + "'))),RETORNA_NUCLEO_MS (BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DATPRO)),"
cQryBuffer += "    		to_date(trim(BD6_DATPRO),'YYYYMMDD'))=1" 																					+ CRLF
cQryBuffer += "    AND BD6_SITUAC = 1" 																												+ CRLF
cQryBuffer += "    AND BD7_CODOPE = BD6_CODOPE" 																									+ CRLF
cQryBuffer += "    AND BD7_CODLDP = BD6_CODLDP" 																									+ CRLF
cQryBuffer += "    AND BD7_CODPEG = BD6_CODPEG" 																									+ CRLF
cQryBuffer += "    AND BD7_NUMERO = BD6_NUMERO" 																									+ CRLF
cQryBuffer += "    AND SA2.D_E_L_E_T_ = ' '" 																										+ CRLF
cQryBuffer += "    AND B19.D_E_L_E_T_ = ' '" 																										+ CRLF
cQryBuffer += "    AND SD1.D_E_L_E_T_ = ' '" 																										+ CRLF
cQryBuffer += "    AND SF1.D_E_L_E_T_ = ' '" 																										+ CRLF
cQryBuffer += "    AND BD6.D_E_L_E_T_ = ' '" 																										+ CRLF
cQryBuffer += "    AND BD7.D_E_L_E_T_ = ' '" 																										+ CRLF
cQryBuffer += "  )" 																																+ CRLF
cQryBuffer += "  GROUP BY REFERENCIA ," 																											+ CRLF
cQryBuffer += "             Matricula," 																											+ CRLF
cQryBuffer += "             NOME," 																													+ CRLF
cQryBuffer += "             NUPRE," 																												+ CRLF
cQryBuffer += "             tipo," 																													+ CRLF
cQryBuffer += "             BD6_CODPRO," 																											+ CRLF
cQryBuffer += "             BD6_DESPRO ," 																											+ CRLF
cQryBuffer += "             DATA_PROCED," 																											+ CRLF
cQryBuffer += "             BD6_CODRDA," 																											+ CRLF
cQryBuffer += "             NOME_RDA," 																												+ CRLF
cQryBuffer += "             RECNO" 																													+ CRLF
cQryBuffer += "--FIM NOVO MATERIAL MICROSIGA" 																										+ CRLF
cQryBuffer += "UNION ALL" 																															+ CRLF
cQryBuffer += "--NOVO REEMBOLSO MICROSIGA" 																											+ CRLF
cQryBuffer += " SELECT  To_Date('" + cAnoMesRef + "','yyyymm' )REFERENCIA," 																		+ CRLF
cQryBuffer += "          formata_matricula_ms(B44_OPEUSR||B44_CODEMP||B44_MATRIC||B44_TIPREG||B44_DIGITO) Matricula ," 								+ CRLF
cQryBuffer += "          Trim(Ba1_NOMUSR) NOME," 																									+ CRLF
cQryBuffer += "          Decode(RETORNA_NUCLEO_MS(B44_OPEUSR,B44_CODEMP,B44_MATRIC,B44_TIPREG,TO_CHAR(LAST_DAY("
cQryBuffer += "          	TO_DATE('" + cAnoMesRef + "','YYYYMM')),'YYYYMMDD')),'1','NUPRE NITEROI','2','NUPRE TIJUCA','3',"
cQryBuffer += "          	'NUPRE BANGU','') NUPRE," 																								+ CRLF
cQryBuffer += "          'Atendimentos' tipo," 																										+ CRLF
cQryBuffer += "          BD6_CODPRO," 																												+ CRLF
cQryBuffer += "          BD6_DESPRO  ," 																											+ CRLF
cQryBuffer += "          TO_DATE(B44_DATPRO,'YYYYMMdd') DATA_PROCED," 																				+ CRLF
cQryBuffer += "          COUNT(B44_OPEMOV||B44_ANOAUT||B44_MESAUT||B44_NUMAUT) FREQUENCIA," 														+ CRLF
cQryBuffer += "          Sum(B45_VLRPAG) VL_APROV ," 																								+ CRLF
cQryBuffer += "          0 VL_PARTIC," 																												+ CRLF
cQryBuffer += "          BD6_CODRDA," 																												+ CRLF
cQryBuffer += "          PLS_RETORNA_NOME_RDA (BD6_CODRDA) NOME_RDA ," 																				+ CRLF
cQryBuffer += "          BD6.R_E_C_N_O_ RECNO" 																										+ CRLF
cQryBuffer += " FROM " + RetSqlName('B44') + " C," 																									+ CRLF
cQryBuffer += "      " + RetSqlName('B45') + " D," 																									+ CRLF
cQryBuffer += "      " + RetSqlName('SE1') + " T," 																									+ CRLF
cQryBuffer += "      " + RetSqlName('BA1') + " U," 																									+ CRLF
cQryBuffer += "      " + RetSqlName('BA3') + " F," 																									+ CRLF
cQryBuffer += "      " + RetSqlName('BI3') + " BI3," 																								+ CRLF
cQryBuffer += "      " + RetSqlName('BG9') + " BG9," 																								+ CRLF
cQryBuffer += "      " + RetSqlName('BD6') + " BD6" 																								+ CRLF
cQryBuffer += " WHERE B45_FILIAL = '" + xFilial('B45') + "'" 																						+ CRLF
cQryBuffer += "         AND B44_FILIAL = '" + xFilial('B44') + "'" 																					+ CRLF
cQryBuffer += "         AND BI3_FILIAL = '" + xFilial('BI3') + "'" 																					+ CRLF
cQryBuffer += "         AND BA3_FILIAL = '" + xFilial('BA3') + "'" 																					+ CRLF
cQryBuffer += "         AND BA1_FILIAL = '" + xFilial('BA1') + "'" 																					+ CRLF
cQryBuffer += "         AND BG9_FILIAL = '" + xFilial('BG9') + "'" 																					+ CRLF
cQryBuffer += "         AND BD6_FILIAL = '" + xFilial('BD6') + "'" 																					+ CRLF
cQryBuffer += "         AND E1_FILIAL = '" + xFilial('SE1') + "'" 																					+ CRLF
cQryBuffer += "         AND E1_PREFIXO = 'RLE'" 																									+ CRLF
cQryBuffer += "         AND B44_CODLDP = B45_CODLDP" 																								+ CRLF
cQryBuffer += "         AND B44_CODPEG = B45_CODPEG" 																								+ CRLF
cQryBuffer += "         AND B44_NUMAUT = B45_NUMAUT" 																								+ CRLF
cQryBuffer += "         AND B44_PREFIX = E1_PREFIXO" 																								+ CRLF
cQryBuffer += "         AND B44_NUM = E1_NUM" 																										+ CRLF
cQryBuffer += "         AND BA1_CODINT = BA3_CODINT" 																								+ CRLF
cQryBuffer += "         AND BA1_CODEMP = BA3_CODEMP" 																								+ CRLF
cQryBuffer += "         AND BA1_MATRIC = BA3_MATRIC" 																								+ CRLF
cQryBuffer += "         AND BA1_CODINT = B44_OPEUSR" 																								+ CRLF
cQryBuffer += "         AND BA1_CODEMP = B44_CODEMP" 																								+ CRLF
cQryBuffer += "         AND BA1_MATRIC = B44_MATRIC" 																								+ CRLF
cQryBuffer += "         AND BA1_TIPREG = B44_TIPREG" 																								+ CRLF
cQryBuffer += "         AND BI3_CODINT = BA1_CODINT" 																								+ CRLF
cQryBuffer += "         AND B44_OPEUSR = BG9_CODINT" 																								+ CRLF
cQryBuffer += "         AND B44_CODEMP = BG9_CODIGO" 																								+ CRLF
cQryBuffer += "         AND BI3_CODIGO = Nvl(Trim(BA1_CODPLA),BA3_CODPLA)" 																			+ CRLF
cQryBuffer += "         -- apartir de junho/2010 contabilização por emissao" 																		+ CRLF
cQryBuffer += "         AND SubStr(E1_EMISSAO,1,6) = '" + cAnoMesRef + "'" 																			+ CRLF
cQryBuffer += "    		AND BD6_OPEUSR = '" + cOperUsr + "'" 																						+ CRLF
cQryBuffer += "   	 	AND BD6_CODEMP = '" + cCodEmp + "'" 																						+ CRLF
cQryBuffer += "    		AND BD6_MATRIC = '" + cMatrUsr + "'" 																						+ CRLF
cQryBuffer += "    		AND BD6_TIPREG = '" + cTipoReg + "'" 																						+ CRLF
cQryBuffer += "         AND BD6_CODOPE = '0001'" 																									+ CRLF
cQryBuffer += "         AND B45_CODLDP = BD6_CODLDP" 																								+ CRLF
cQryBuffer += "         AND B45_CODPEG = BD6_CODPEG" 																								+ CRLF
cQryBuffer += "         AND B45_NUMERO = BD6_NUMERO" 																								+ CRLF
cQryBuffer += "         AND B45_SEQUEN = BD6_SEQUEN" 																								+ CRLF
cQryBuffer += "         AND B45_CODPAD = BD6_CODPAD" 																								+ CRLF
cQryBuffer += "         AND B45_CODPRO = BD6_CODPRO" 																								+ CRLF
cQryBuffer += "         AND PLS_PRA_PROJSERV_ATIVO_MS ( BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG ,'0041',BD6_DATPRO)='S'" 						+ CRLF
cQryBuffer += "         AND VERIFICA_INICIO_CONTRATO(Nvl(trim(RETORNA_NUCLEO_MS (BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,"
cQryBuffer += "         	ULTIMO_DIA_UTIL('" + cDiaMesExtAno + "'))),RETORNA_NUCLEO_MS (BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DATPRO)),"
cQryBuffer += "         	to_date(trim(BD6_DATPRO),'YYYYMMDD'))=1" 																				+ CRLF
cQryBuffer += "         AND C.D_E_L_E_T_=' '" 																										+ CRLF
cQryBuffer += "         AND D.D_E_L_E_T_=' '" 																										+ CRLF
cQryBuffer += "         AND T.D_E_L_E_T_=' '" 																										+ CRLF
cQryBuffer += "         AND U.D_E_L_E_T_=' '" 																										+ CRLF
cQryBuffer += "         AND F.D_E_L_E_T_=' '" 																										+ CRLF
cQryBuffer += "         AND BI3.D_E_L_E_T_ = ' '" 																									+ CRLF
cQryBuffer += "         AND BG9.D_E_L_E_T_ = ' '" 																									+ CRLF
cQryBuffer += "         AND BD6.D_E_L_E_T_ = ' '" 																									+ CRLF
cQryBuffer += " GROUP BY" 																															+ CRLF
cQryBuffer += "          formata_matricula_ms(B44_OPEUSR||B44_CODEMP||B44_MATRIC||B44_TIPREG||B44_DIGITO)  ," 										+ CRLF
cQryBuffer += "          Trim(Ba1_NOMUSR) ," 																										+ CRLF
cQryBuffer += "          Decode(RETORNA_NUCLEO_MS(B44_OPEUSR,B44_CODEMP,B44_MATRIC,B44_TIPREG,"
cQryBuffer += "         	TO_CHAR(LAST_DAY(TO_DATE('" + cAnoMesRef + "','YYYYMM')),'YYYYMMDD')),'1','NUPRE NITEROI','2','NUPRE TIJUCA','3','NUPRE BANGU',''),"+ CRLF
cQryBuffer += "          BD6_CODPRO," 																												+ CRLF
cQryBuffer += "          Bd6_DESPRO  ," 																											+ CRLF
cQryBuffer += "          TO_DATE(B44_DATPRO,'YYYYMMdd') ," 																							+ CRLF
cQryBuffer += "          BD6_CODRDA," 																												+ CRLF
cQryBuffer += "          PLS_RETORNA_NOME_RDA (BD6_CODRDA)  ," 																						+ CRLF
cQryBuffer += "          BD6.R_E_C_N_O_" 																											+ CRLF
cQryBuffer += ")" 																																	+ CRLF
cQryBuffer += "ORDER BY NUPRE,MATRICULA ,DATA_PROCED" 																								+ CRLF

Return cQryBuffer

************************************************************************************************************************************

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()  

aHelp := {}
aHelp := {}
aAdd(aHelp, "Informe o procedimento inicial")      
PutSX1(cPerg , "01" , "Procedimento de" 	,"","","mv_ch1","C",TamSx3('BD6_CODPRO')[1]	,0,0,"G",""	,""	,"","","mv_par01",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o procedimento final")      
PutSX1(cPerg , "02" , "Procedimento até" 	,"","","mv_ch2","C",TamSx3('BD6_CODPRO')[1]	,0,0,"G",""	,""	,"","","mv_par02",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano de referencia")      
aAdd(aHelp, "inicial com 4 digitos")      
PutSX1(cPerg,"03","Ano Referencia"			,"","","mv_ch3","N",04							,0,0,"G","","" ,"","","mv_par03",""			,"","","",""		,"","",""			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o mes de referecia")      
aAdd(aHelp, "final")  
aAdd(aHelp, "1  - Janeiro"						)      
aAdd(aHelp, "2  - Fevereiro"					)      
aAdd(aHelp, "3  - Março"						)      
aAdd(aHelp, "4  - Abril"						)      
aAdd(aHelp, "5  - Maio"							)      
aAdd(aHelp, "6  - Junho"						)      
aAdd(aHelp, "7  - Julho"						)      
aAdd(aHelp, "8  - Agosto"						)      
aAdd(aHelp, "9  - Setembro"						)      
aAdd(aHelp, "10 - Outubro"						)      
aAdd(aHelp, "11 - Novembro"						)      
aAdd(aHelp, "12 - Dezembro"						)      
PutSX1(cPerg , "04" , "Mes Referencia" 		,"","","mv_ch4","N",02							,0,0,"G","",""	,"","","mv_par04",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a operadora do usuario")      
aAdd(aHelp, "(4 primeiros digitos da matricula)")      
PutSX1(cPerg , "05" , "Operadora"  			,"","","mv_ch5","C",TamSx3('BD7_OPEUSR')[1]	,0,0,"G",""	,""	,"","","mv_par05",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

//MATUSR -> consulta especifica
aHelp := {}
aAdd(aHelp, "Informe a matricula do usuario")      
PutSX1(cPerg , "06" , "Matricula usuario" 	,"","","mv_ch6","C",TamSx3('BE4_USUARI')[1]	,0,0,"G",""	,"MATUSR"	,"","","mv_par06",""			,"","","",""		,"","",""				,"","",""		,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)                                                                           

Return   

