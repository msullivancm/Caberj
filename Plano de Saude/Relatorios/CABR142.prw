#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CABR142  ³ Autor ³ Leonardo Portella     ³ Data ³17/07/2014³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de criticas da importacao TISS                   ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CABERJ                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR142

Local oReport 
Private cPerg	:= "CABR142"  

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
Local oRDA
Local oCompet

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()

Pergunte(cPerg,.T.)

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

oReport	:= TReport():New("CABR142","Criticas da importacao TISS","CABR142", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de criticas da importacao TISS")

*'-----------------------------------------------------------------------------------'*
*'SoluÃ§Ã£o para impressÃ£o em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  

*'-----------------------------------------------------------------------------------'*

oRDA := TRSection():New(oReport,"Criticas da importacao TISS")
oRDA:SetTotalInLine(.F.) 
                                                        
TRCell():New(oRDA ,'TEXTO'	,/*ALIAS*/	,'Crítica'	,/*Picture*/	,220,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

//oRDA:SetTotalText("Quantidade de críticas")   

//TRFunction():New(oRDA:Cell("TEXTO")	,NIL,"COUNT",/*oBreak1*/,/*Picture*/,,/*uFormula*/,.T.,.F.)

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

Local nK := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nJ := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local oBreak01                             
Local oBreak02                             
Local oBreak03                             
Local nPosArr 		:= 0
Local aCritica		:= {}

Private oRDA   		:= oReport:Section(1)
Private cAlias  	:= GetNextAlias()
Private cSepCsv		:= If(mv_par06 == 1,';',',')
Private lExcel		:= ( mv_par05 == 1 )
Private cPathCsv 	:= GetTempPath()
Private cBuffer		:= ''
Private cArq		:= ''
Private nCont		:= 0

If lExcel 

	cArq	:= cPathCsv + "CABR142_" + DtoS(dDatabase) + "_" + StrTran(Time(),":","")+".CSV"
	nHdl 	:= FCreate(cArq) 

	cBuffer += 'Crítica' 	+ cSepCsv
	cBuffer += CRLF                                    

EndIf    

MsgRun("Selecionando registros...",AllTrim(SM0->M0_NOMECOM),{||nCont := FilTRep()})

//Se nao tiver esta linha, nao imprime os dados
oRDA:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nLinhas	:= 0
nCont 	:= 0      
aErros	:= {}
aAddBuf	:= {}
cBuffer	:= ''
aTmp	:= {}

While !( cAlias->(Eof()) )

	If oReport:Cancel()  

	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)

	    If lExcel
	    	cBuffer := CRLF + CRLF + 'Cancelado pelo operador!!!' + CRLF
	    	FWrite(nHdl,cBuffer,len(cBuffer))
		EndIf

	    Exit

	EndIf

	oReport:SetMsgPrint("Analisando arquivos " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot)
	oReport:IncMeter()
	
	cCritica 	:= MSMM(cAlias->(BXX_CODREG),999)
	aCritTmp 	:= Separa(cCritica,Chr(13) + Chr(10),.F.)
	cCritica	:= ''
	
	nPosCrit 	:= 0
	
	For nI := 1 to len(aCritTmp)
	
		If ( At('** ERRO [',aCritTmp[nI]) > 0 ) 
		
	    	//Preciso verificar se a critica por completo (string) ja foi colocada no vetor. Adiciono as criticas do outro cabecalho
		    If ( nPosCrit > 0 ) 
		    
				If ( aScan(aAddBuf,cBuffer) <= 0 )
		    		
		    		aAdd(aTmp,' ')
	    			
	    			For nK := 1 to len(aTmp)
				    	aAdd(aCritica[nPosCrit],aTmp[nK])
						nLinhas++
			    	Next
			    	
			    	aAdd(aAddBuf,cBuffer)
			    	aTmp 	:= {}
			    	cBuffer := '' 
			    	
			   Else
			    	aTmp 	:= {}
			    	cBuffer := '' 	
			   EndIf
		    	
		    EndIf
		    
			nPosCrit := aScan(aCritica,{|x|x[1] == aCritTmp[nI]})
				
			//So adiciono o cabecalho da critica se nao existir
			If empty(aCritica) .or. ( nPosCrit <= 0 )
				aAdd(aCritica,{aCritTmp[nI]})
				
				//Atualizo o nPosCrit
				nPosCrit := aScan(aCritica,{|x|x[1] == aCritTmp[nI]})
		    	nLinhas++
			EndIf
			
		Else
			
			cBuffer += Upper(Replace(Replace(Replace(aCritTmp[nI],' ',''),':',''),'/',''))
			aAdd(aTmp,aCritTmp[nI])

		EndIf
			
	Next
	
    	//Preciso verificar se a critica por completo (string) ja foi colocada no vetor. Adiciono as criticas do outro cabecalho
    If ( nPosCrit > 0 ) 
    
		If ( aScan(aAddBuf,cBuffer) <= 0 )
    		
    		aAdd(aTmp,' ')
    			
    		For nK := 1 to len(aTmp)
		    	aAdd(aCritica[nPosCrit],aTmp[nK])
				nLinhas++
	    	Next
	    	
	    	aAdd(aAddBuf,cBuffer)
	    	aTmp 	:= {}
	    	cBuffer := '' 
	    	
	   Else
	    	aTmp 	:= {}
	    	cBuffer := '' 	
	   EndIf
    	
    EndIf
    
   	aTmp 		:= {}
   	cBuffer 	:= ''
	
	cAlias->(DbSkip())

EndDo

cAlias->(DbCloseArea())

oReport:SetMeter(nLinhas)
cTot	:= AllTrim(Transform(nLinhas,'@E 999,999,999,999'))
nLinhas	:= 0 

aSort(aCritica,,,{|x,y| Replace(x[1],'X','') < Replace(y[1],'X','')})

For nI := 1 to len(aCritica)
    
	For nJ := 1 to len(aCritica[nI])
	
		If oReport:Cancel()

		    oReport:FatLine()
		    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	
		    If lExcel
		    	cBuffer := CRLF + CRLF + 'Cancelado pelo operador!!!' + CRLF
		    	FWrite(nHdl,cBuffer,len(cBuffer))
			EndIf
	
		    Exit
	
		EndIf
	
		oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nLinhas,'@E 999,999,999,999')) + " de " + cTot)
		oReport:IncMeter()
	
		oRDA:Cell('TEXTO'):SetValue(aCritica[nI][nJ])
		
		If ( At('** ERRO [',aCritica[nI][nJ]) > 0 ) 
			oReport:FatLine()
		EndIf
		
		If lExcel
	
			cBuffer += aCritica[nI][nJ] + cSepCsv
			cBuffer += CRLF
			
			If ( At('** ERRO [',aCritica[nI][nJ]) > 0 ) 
				cBuffer += Replicate('-',220) + cSepCsv
				cBuffer += CRLF
			EndIf
	
			FWrite(nHdl,cBuffer,len(cBuffer))
	
			cBuffer := ''
			
		EndIf
		
		oRDA:PrintLine()   
		
	Next  
	
Next

oRDA:Finish()

If lExcel
     
	FClose(nHdl)

	ExecExcel(cArq,,'Criticas da importacao TISS' + AllTrim(SM0->M0_NOMECOM))

EndIf

Return   

********************************************************************************************************************************

Static Function FilTRep

Local cQuery := ''  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//BXX_STATUS => 0=Em processamento;1=Acatado;2=Nao acatado;3=Processado

cQuery += "SELECT BXX_CODREG,BXX_ARQIN" 																	+ CRLF
cQuery += "FROM " + RetSqlName('BXX') + " BXX" 																+ CRLF
cQuery += "WHERE BXX_FILIAL = '" + xFilial('BXX') + "'"    													+ CRLF 
cQuery += "  AND BXX.D_E_L_E_T_ = ' '" 																		+ CRLF
cQuery += "  AND BXX_CODRDA BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"								+ CRLF
cQuery += "  AND BXX_DATMOV BETWEEN '" + DtoS(mv_par03) + "' AND '" + DtoS(mv_par04) + "'"					+ CRLF
cQuery += "  AND BXX_STATUS = '2'" 																			+ CRLF
cQuery += "ORDER BY BXX_SEQUEN" 																			+ CRLF

TcQuery cQuery New Alias cAlias

cAlias->(DbGoTop())

nCont := 0

COUNT TO nCont

cAlias->(DbGoTop())

Return nCont

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
aAdd(aHelp, "Informe o RDA inicial")         
PutSX1(cPerg , "01" , "RDA de" 			,"","","mv_ch1","C",TamSx3("BAU_CODIGO")[1],0,0,"G",""	,"BAUNFE","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o RDA final")         
PutSX1(cPerg , "02" , "RDA ate" 		,"","","mv_ch2","C",TamSx3("BAU_CODIGO")[1],0,0,"G","","BAUNFE","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de importação inicial")         
PutSX1(cPerg , "03" , "Data importação de"	,"","","mv_ch3","D",08					,0,0,"G",""	,"","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de importação final")         
PutSX1(cPerg , "04" , "Data importação ate"	,"","","mv_ch4","D",08					,0,0,"G",""	,"","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o se o relatorio devera")
aAdd(aHelp, "ser exportado para Excel"		)
PutSX1(cPerg,"05","Gera Excel"				,"","","mv_ch05","N",01					,0,1,"C","","","","","mv_par05","Sim","","","","Nao","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o separador do Excel"	)
aAdd(aHelp, "Utilizado somente caso a"		)
aAdd(aHelp, "opcao gera Excel esteja como"	)
aAdd(aHelp, "'Sim'"		)
PutSX1(cPerg,"06","Separador Excel"			,"","","mv_ch06","N",01					,0,1,"C","","","","","mv_par06",";","","","",",","","","","","","","","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return   

******************************************************************************************************************************
