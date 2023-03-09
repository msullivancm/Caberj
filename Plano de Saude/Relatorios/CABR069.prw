#include "PROTHEUS.CH"
#include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR069  ³ Autor ³ Leonardo Portella    ³ Data ³ 08/08/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de beneficiarios e validade de carteirinha, con- |±±
±±³          ³ forme especificado por Marcos Alves no chamado 2585 e      ³±±
±±³          ³ conforme assinado na RDM 079.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR069           

Local oReport 
Private cPerg		:= "CABR069"  
Private nTamMatric 	:= TamSx3('BA1_CODINT')[1] + TamSx3('BA1_CODEMP')[1] + TamSx3('BA1_MATRIC')[1] + TamSx3('BA1_TIPREG')[1] + TamSx3('BA1_DIGITO')[1]
Private aOrdem 		:= {'Matricula', 'Nome','Data Inclusao','Data Validade','Idade'}

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

oReport	:= TReport():New("CABR069","Carteirinhas emitidas","CABR069", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao beneficiarios e carteiras emitidas")

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

*'-----------------------------------------------------------------------------------'*

oUsr := TRSection():New(oReport,"Carteirinhas emitidas",,aOrdem)
oUsr:SetTotalInLine(.F.)   

cPicture 	:= '@E 999,999,999,999.99'                 

TRCell():New(oUsr ,'MATRIC'			,		,'Matricula'		 					,"@R 9999.9999.999999.99-9"	,nTamMatric	+ 4	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_NOMUSR'		,'BA1'	,'Nome do usuario'						,/*Picture*/				,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'IDADE_DATA'		,		,'Idade em ' + DtoC(mv_par03)			,/*Picture*/				,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_DATINC'		,'BA1'	,										,/*Picture*/				,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_DTVLCR'		,'BA1'	,										,/*Picture*/				,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'BA1_VIACAR'		,'BA1'	,										,/*Picture*/				,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'CART_VAL_OK'	,   	,'Cart. (Valid. OK)'					,/*Picture*/	 			,/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'CRITICA'		,   	,'Critica'								,/*Picture*/				,70				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oUsr:SetTotalText("Total geral")

TRFunction():New(oUsr:Cell("CRITICA")  		,NIL,"COUNT"	,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)

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
Local cPosTit   	:= AllTrim(GetNewPar("MV_PLPOSTI","1")) // 1-titulos em aberto  2-titulos em aberto/baixados

Private oUsr   		:= oReport:Section(1)
Private cAliasCart 	:= GetNextAlias()
Private cQuery		:= ''
Private nCont 		:= 0
Private aReajuste	:= {}
Private aReajAnt	:= {} 	
Private SEMAFORO 	:= '' 
Private lContinua	:= .F.
Private nQtdTitsAtr	:= GetNewPar("MV_YQATRE1",1)//Quantidade maxima de titulos em atraso

//Executa query que alimenta o alias cAliasCart 
Processa({||nCont := FilTRep()},AllTrim(SM0->M0_NOMECOM))

//Se nao tiver esta linha, nao imprime os dados
oUsr:init()

oReport:SetMeter(nCont) 

cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       
nCritic	:= 0

While !( cAliasCart->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Analisando dados do usuário " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot + '... (Criticados: ' + allTrim(Transform(nCritic,'@E 999,999,999,999')) + ')')
	oReport:IncMeter()
    
	lCritica 	:= .F.
	cCritica 	:= ""
    
	aDadUsr 	:= PLSDADUSR(cAliasCart->(MATRIC),"1",.F.,dDataBase,nil,nil,nil)

	//Produtos de Saude
	BI3->(DbSetOrder(1))//BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
	BI3->(MsSeek(xFilial("BI3")+cAliasCart->(BA3_CODINT+BA3_CODPLA+BA3_VERSAO)))
	
	//Grupos Empresas
	BG9->(DbSetOrder(1))//BG9_FILIAL+BG9_CODINT+BG9_CODIGO+BG9_TIPO
	BG9->(MsSeek(xFilial("BG9")+cAliasCart->(BA3_CODINT+BA3_CODEMP)))
    
	//Sub-contrato
    BQC->(DbSetOrder(1))
	BQC->(MsSeek(xFilial("BQC") + cAliasCart->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
	
	//INICIO DAS CRITICAS
	
	Do Case
	
		Case !aDadUsr[1]
	    	lCritica 	:= .T.
		    cCritica 	:= "Usuario invalido"
		    
		Case !BI3->(Found())
	    	lCritica 	:= .T.
		    cCritica 	:= "Produto Saude nao encontrado"

		Case !BG9->(Found())
	    	lCritica 	:= .T.
		    cCritica 	:= "Grupo Empresa nao encontrado"
	
		Case !BQC->(Found())
			lCritica 	:= .T.
	    	cCritica 	:= "Sub-contrato nao encontrado [" + cAliasCart->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB) + "]"
	  	
		Case BQC->BQC_EMICAR == "0"
	  		lCritica 	:= .T.
	    	cCritica 	:= "Sub-contrato parametrizado para NUNCA emitir [" + cAliasCart->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB) + "]"
	
	    Case cAliasCart->(BA1_EMICAR) == '0'//0=Nunca Emitir;1=Cad. Alterado;2=Cartao Preparado;3=Cartao Gerado
	    	lCritica 	:= .T.
		    cCritica 	:= "Carteira parametrizada para NUNCA emitir"

		Case AllTrim(cAliasCart->(LOTE_EMISSAO)) == '-' //0=Nao;1=Sim
	  		lCritica 	:= .T. 
	    	cCritica 	:= 'Lote emissao NAO encontrado'

		Case cAliasCart->(BED_BLOIDE) == '1' //0=Nao;1=Sim       
			lCritica 	:= .T. 
	    	cCritica 	:= 'Lote emissao bloqueado [' + cAliasCart->(LOTE_EMISSAO) + ']'

	    Case cAliasCart->(BDE_MUDVAL) == '0' //0=Nao;1=Sim
	  		lCritica 	:= .T. 
	    	cCritica 	:= 'Lote parametrizado para NAO mudar validade [' + cAliasCart->(LOTE_EMISSAO) + ']'
	    	
	    Case empty(cAliasCart->(BED_DATVAL))
	  		lCritica 	:= .T. 
	    	cCritica 	:= 'Validade nao informada no lote[' + cAliasCart->(LOTE_EMISSAO) + ']'
	    
	    Case !empty(cAliasCart->(BA1_DATBLO)) .and. ( cAliasCart->(BED_DATVAL) > cAliasCart->(BA1_DATBLO) ) .and. ;
	    	 ( cAliasCart->(BA1_DTVLCR) == cAliasCart->(BA1_DATBLO) )//Mudanca feita no PE PLS264DT
			lCritica 	:= .T. 
	    	cCritica 	:= 'Validade alterada para data bloq. usuario [' + DtoC(cAliasCart->(BA1_DATBLO)) + ']'
	    	
	    Case !empty(cAliasCart->(BA3_DATBLO)) .and. ( cAliasCart->(BED_DATVAL) > cAliasCart->(BA3_DATBLO) ) .and. ;
	    	 ( cAliasCart->(BA1_DTVLCR) == cAliasCart->(BA3_DATBLO) )//Mudanca feita no PE PLS264DT
			lCritica 	:= .T. 
	    	cCritica 	:= 'Validade alterada para data bloq. familia [' + DtoC(cAliasCart->(BA3_DATBLO)) + ']'
	
		Case !empty(cAliasCart->(BA1_YDTLIM)) .and. ( cAliasCart->(BED_DATVAL) > cAliasCart->(BA1_YDTLIM) ) .and. ;
	    	 ( cAliasCart->(BA1_DTVLCR) == cAliasCart->(BA1_YDTLIM) )//Mudanca feita no PE PLS264DT
			lCritica 	:= .T. 
	    	cCritica 	:= 'Validade alterada para data limite usuario [' + DtoC(StoD(cAliasCart->(BA1_YDTLIM))) + ']'

		Case !empty(cAliasCart->(BA3_LIMITE)) .and. ( cAliasCart->(BED_DATVAL) > cAliasCart->(BA3_LIMITE) ) .and. ;
	    	 ( cAliasCart->(BA1_DTVLCR) == cAliasCart->(BA3_LIMITE) )//Mudanca feita no PE PLS264DT
	    	cCritica 	:= 'Validade alterada para data limite familia [' + DtoC(StoD(cAliasCart->(BA3_LIMITE))) + ']'
	    		                
        Case ( cAliasCart->(BA1_CODEMP) $ GetNewPar('MV_PLSMP1V','0050') )//Intercambio - vide PLSA264
        	lCritica 	:= .T.
		    
            If ( cAliasCart->(BDE_GERINT) == '0' )
	    		cCritica 	:= "Matricula de Intercambio e lote param. para nao gerar intercambio"
	    	Else
	    		cCritica 	:= "Matricula de Intercambio"
	    	EndIf

	    Case !empty(cAliasCart->(BA1_YMTREP))
	    	lCritica 	:= .T.
		    cCritica 	:= "Matricula de repasse [" + AllTrim(cAliasCart->(BA1_YMTREP)) + ']'

	EndCase
 
	If !lCritica
    
		cCodInt	:= cAliasCart->BA1_CODINT
		cCodEmp	:= cAliasCart->BA1_CODEMP
		cMatrUs	:= cAliasCart->BA1_MATRIC
		cConEmp	:= cAliasCart->BA1_CONEMP
		cSubCon	:= cAliasCart->BA1_SUBCON
		
		cCodCli := aDadUsr[58]
		cLoja   := aDadUsr[59]
		cNivCob	:= aDadUsr[61]
		
		nTits := 0
	
		If cPosTit == "1" // considerar apenas titulos em aberto
	
		    SE1->(dbSetOrder(8))
	
		    If SE1->(MsSeek(xFilial("SE1")+cCodCli+cLoja+"A"))
	
		       While ! SE1->(Eof()) .And. SE1->(E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_STATUS) == xFilial("SE1")+cCodCli+cLoja+"A"
	
		          If DtoS(dDataBase) > DtoS(SE1->E1_VENCREA)
	
		             If ( cNivCob >= "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_MATRIC) == cCodInt+cCodEmp+cMatrUs ) .Or. ;
		                ( cNivCob <  "4" .And. SE1->(E1_CODINT+E1_CODEMP+E1_CONEMP+E1_SUBCON) == cCodInt+cCodEmp+cConEmp+cSubCon )
	
		                nTits++
	
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
		                    nTits++
		                EndIf
		
		             EndIf
		
		          EndIf
		
		          SE1->(DbSkip())
		
		       EndDo
		
		    EndIf
		    	
		EndIf

	EndIf

	If !lCritica .and. ( nTits > nQtdTitsAtr )
    	lCritica 	:= .T.
		cCritica 	:= "Usuário inad.: títulos aberto [ " + cValToChar(nTits) + " ] Máximo [ " + cValToChar(nQtdTitsAtr) + " ]"
	EndIf
	
	If !lCritica .and. ( cAliasCart->(BED_DATVAL) <> cAliasCart->(BA1_DTVLCR) )
    	lCritica 	:= .T.
		cCritica 	:= "Dt valid. lote emissao diferente usuario"
	EndIf

	If lCritica
		++nCritic
	EndIf
    
	//FIM DAS CRITICAS
	     
	If ( mv_par06 == 1 ) .or. ( mv_par06 == 2 .and. lCritica ) .or. ( mv_par06 == 3 .and. !lCritica )
    
		If ( mv_par07 == 1 ) .or. ( mv_par07 == 2 .and. cAliasCart->(CART_VAL_OK) == 'SIM' ) .or. ( mv_par07 == 3 .and. cAliasCart->(CART_VAL_OK) == 'NAO')    
		
			oReport:SetTotalInLine(.T.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
			oReport:SetTotalText('Total Plano') 
			
			*'-----------------------------------------------------------------------------------'*
			*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
			*'-----------------------------------------------------------------------------------'*
			
			oReport:SetColSpace(1) //Espacamento entre colunas. 
			oReport:SetLandscape() //Impressao em paisagem.  
	
			oUsr:Cell('MATRIC'		):SetValue(cAliasCart->(MATRIC))
			oUsr:Cell('BA1_NOMUSR'	):SetValue(cAliasCart->(BA1_NOMUSR))
			oUsr:Cell('IDADE_DATA'	):SetValue(cAliasCart->(IDADE))
			oUsr:Cell('BA1_DATINC'	):SetValue(DtoC(StoD(cAliasCart->(BA1_DATINC))))
			oUsr:Cell('BA1_DTVLCR'	):SetValue(DtoC(StoD(cAliasCart->(BA1_DTVLCR))))
			oUsr:Cell('BA1_VIACAR'	):SetValue(cAliasCart->(BA1_VIACAR))
			oUsr:Cell('CART_VAL_OK'	):SetValue(cAliasCart->(CART_VAL_OK))
		    oUsr:Cell('CRITICA'		):SetValue(If(lCritica,cCritica,'-'))
		    
			oUsr:PrintLine()
		                                                                              
		EndIf
		
	EndIf
		
    cAliasCart->(DbSkip())
    
EndDo

oUsr:Finish()

cAliasCart->(DbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

ProcRegua(0)

For i := 0 to 5
	IncProc('Selecionando registros a serem analisados...')
Next
	 
cQuery := "SELECT BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRIC,BA1_NOMUSR,BA1_DATINC,BA1_DTVLCR,BA1_VIACAR,BA1_DATBLO,BA1_YDTLIM,"	+ CRLF
cQuery += "  CASE WHEN BA1_DTVLCR >= '" + DtoS(mv_par03) + "' THEN 'SIM 'ELSE 'NAO' END CART_VAL_OK,BA3_VERSAO,BA3_CODEMP,BDE_GERINT,BDE_YORIGE,"		+ CRLF
cQuery += "  IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),TO_DATE('" + DtoS(mv_par03) + "','YYYYMMDD')) IDADE,BED_MOTIVO,BA3_CODINT,BA3_CODPLA,"			+ CRLF
cQuery += "  BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_CONEMP,BA1_SUBCON,BA1_EMICAR,BA1_YMTREP,BA1_CONEMP,BA1_VERCON,BA1_SUBCON,BA1_TIPREG,BA3_DATBLO,"		+ CRLF
cQuery += "  BA1_VERSUB,BDE_MUDVAL,BDE_DATVAL,BED_DATVAL,BED_BLOIDE,NVL(BDE_CODIGO,'-') LOTE_EMISSAO,BA1_TIPUSU,BA1_GRAUPA,BDE_YEMISS,BDE_YUSUAR,"		+ CRLF  
cQuery += "  BA3_LIMITE"																																+ CRLF  
cQuery += "FROM " + RetSqlName('BA1') + " BA1"  																		  				  				+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BA3') + " BA3 ON BA3.D_E_L_E_T_ = ' '" 											  				  				+ CRLF
cQuery += "  AND BA3_FILIAL = '" + xFilial('BA3') + "'" 																  				   				+ CRLF
cQuery += "  AND BA3_CODINT = BA1_CODINT" 																					  			   				+ CRLF
cQuery += "  AND BA3_CODEMP = BA1_CODEMP" 																					 				  			+ CRLF
cQuery += "  AND BA3_MATRIC = BA1_MATRIC" 																									   			+ CRLF
cQuery += "  AND ( BA3_DATBLO = ' ' OR BA3_DATBLO > '" + DtoS(mv_par05) + "')" 					

**'Inicio - Marcela Coimbra '**

//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS//+ CRLF

cQuery += "  AND BA1_CODPLA BETWEEN '" + MV_PAR08 + "' AND '" + MV_PAR09 + "' " 											   								+ CRLF

**'Fim - Marcela Coimbra '**

cQuery += "LEFT JOIN " + RetSqlName('BDE') + " BDE_CABECALHO ON BDE_CABECALHO.D_E_L_E_T_ = ' '" 														+ CRLF
cQuery += "  AND BDE_FILIAL = '" + xFilial('BDE') + "'" 											   		  											+ CRLF 
cQuery += "  AND BDE_CODIGO = BA1_CDIDEN" 											   							  										+ CRLF
cQuery += "LEFT JOIN " + RetSqlName('BED') + " BED_ITENS ON BED_ITENS.D_E_L_E_T_ = ' '"  								   								+ CRLF
cQuery += "  AND BED_FILIAL = '" + xFilial('BED') + "'" 																   								+ CRLF
cQuery += "  AND BED_CODINT = BA1_CODINT" 											   																	+ CRLF
cQuery += "  AND BED_CODEMP = BA1_CODEMP" 											   				   													+ CRLF
cQuery += "  AND BED_MATRIC = BA1_MATRIC" 											   																	+ CRLF
cQuery += "  AND BED_TIPREG = BA1_TIPREG" 											   				   													+ CRLF
cQuery += "  AND BED_DIGITO = BA1_DIGITO" 											   					 												+ CRLF
cQuery += "  AND BED_CDIDEN = BA1_CDIDEN" 											   					 												+ CRLF
cQuery += "WHERE BA1.D_E_L_E_T_ = ' '" 																	 												+ CRLF
cQuery += "  AND BA1_FILIAL = '" + xFilial('BA1') + "'" 															  									+ CRLF
cQuery += "  AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '" + DtoS(mv_par05) + "')" 								 											+ CRLF
cQuery += "  AND BA1_DTVLCR BETWEEN '" + DtoS(mv_par04) + "' AND '" + DtoS(mv_par05) + "'" 															+ CRLF
cQuery += "  AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'" 	 						+ CRLF

Do Case

	Case oUsr:nOrder == 1
		cQuery += "ORDER BY BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO"
		
	Case oUsr:nOrder == 2    
		cQuery += "ORDER BY BA1_NOMUSR"
	
	Case oUsr:nOrder == 3
   		cQuery += "ORDER BY BA1_DATINC"
	
	Case oUsr:nOrder == 4
		cQuery += "ORDER BY BA1_DTVLCR"  
		
	Case oUsr:nOrder == 5  
		cQuery += "ORDER BY IDADE(TO_DATE(TRIM(BA1_DATNAS),'YYYYMMDD'),TO_DATE('" + DtoS(mv_par03) + "','YYYYMMDD'))"
	
EndCase

TcQuery cQuery New Alias cAliasCart

cAliasCart->(DbGoTop())

nCont := 0

COUNT TO nCont

cAliasCart->(DbGoTop())

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
aAdd(aHelp, "Informe a matricula inicial")
PutSX1(cPerg , "01" , "Matricula De" 	,"","","mv_ch1","C",nTamMatric,0,0,"G","","B92PLS","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a matricula final")
PutSX1(cPerg , "02" , "Matricula Ate" 	,"","","mv_ch2","C",nTamMatric,0,0,"G","","B92PLS","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a Data base renovacao, usada")
aAdd(aHelp, "para calcular se a carteira foi")
aAdd(aHelp, "gerada nesta data informada, ou ")
aAdd(aHelp, "seja, se a validade de cada carteira")
aAdd(aHelp, "é posterior ou igual a data base de")
aAdd(aHelp, "renovacao.")
aAdd(aHelp, "O relatorio ira considerar a carteira")
aAdd(aHelp, "como gerada se a validade da mesma for")
aAdd(aHelp, "posterior ou igual a data base")
aAdd(aHelp, "renovacao informada.")
PutSX1(cPerg,"03","Dt Base Renov."	,"","","mv_ch03","D",8,0,1,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de Validade inicial")
PutSX1(cPerg,"04","Dt Validade De"	,"","","mv_ch04","D",8,0,1,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de Validade final")
PutSX1(cPerg,"05","Dt Validade Ate"	,"","","mv_ch05","D",8,0,1,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe se deseja visualizar somente")
aAdd(aHelp, "criticados, somente nao criticados")
aAdd(aHelp, "ou ambos")
PutSx1(cPerg,"06","Criticados"      ,"","","mv_ch06","N",1,0,0,"C","","","","","mv_par06","Exibe Ambos","","","","Exibe Somente Criticados","","","Não Exibe Criticados","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe se deseja visualizar beneficiarios")
aAdd(aHelp, "somente com carteira gerada, somente sem a ")
aAdd(aHelp, "carteira gerada ou ambos.")
PutSx1(cPerg,"07","Exibe Carteira"      ,"","","mv_ch07","N",1,0,0,"C","","","","","mv_par07","Ambos","","","","Somente Carteira Gerada","","","Somente sem Cart. Gerada","","","","","","","","",aHelp,aHelp,aHelp)
                                                    
**'Inicio - Marcela Coimbra '**

aHelp := {}
aAdd(aHelp, "Inofrme o plano")
PutSx1(cPerg,"08","Plano Inicial"      ,"","","mv_ch08","C",4,0,0,"C","","BJ5PLS","","","mv_par08","Ambos","","","","Plano","","","Plano","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Inofrme o plano")
PutSx1(cPerg,"09","Plano Final"      ,"","","mv_ch09","C",4,0,0,"C","","BJ5PLS","","","mv_par09","Ambos","","","","Plano","","","Plano","","","","","","","","",aHelp,aHelp,aHelp)

**'Fim - Marcela Coimbra '**


RestArea(aArea2)

Return
