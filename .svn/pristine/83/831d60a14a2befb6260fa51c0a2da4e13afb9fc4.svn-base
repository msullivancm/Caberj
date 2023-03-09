#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"
#include "TCBROWSE.CH"
#include "PLSMGER.CH"

STATIC cAdmArq

#DEFINE _OPC_cGETFILE ( GETF_RETDIRECTORY + GETF_LOCALHARD + GETF_OVERWRITEPROMPT )
#DEFINE cEnt chr(10)+chr(13)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGatUsuario  บAutor  ณ Jean Schulz      บ Data ณ  25/05/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTroca codigo digitado caso seja matricula antiga, para a    บฑฑ
ฑฑบ          ณnova matricula do siga.                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GatUsuario(cCampo)
	
	Local cRet 		:= BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
	Local aAreaBA1	:= BA1->(GetArea())
	Local cMatAnt	:= Alltrim(&cCampo)
	
	//Leonardo Portella - 21/09/12 - Inicio
	
	//Caso ocorra de ter mais de uma MATANT igual, trazer a com a matricula que nao esta bloqueada. Na liberacao da internacao ocorreu um caso destes e estava trazendo
	//sempre a matricula bloqueada.
	
	//cRet := IIF(LEN(Alltrim(&cCampo))>0,Posicione("BA1",5,xFilial("BA1")+Alltrim(&cCampo),"BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)"),cRet)
	
	If len(cMatAnt) > 0
		
		BA1->(DbSetOrder(5))//BA1_FILIAL+BA1_MATANT+BA1_TIPANT
		
		If BA1->(MsSeek(xFilial('BA1') + cMatAnt))
			
			cRet := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
			
			While !BA1->(EOF()) .and. ( xFilial('BA1') + cMatAnt == BA1->(BA1_FILIAL + AllTrim(BA1_MATANT)) )
				
				If empty(BA1->BA1_DATBLO) .or. ( BA1->BA1_DATBLO > dDataBase)
					cRet := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
					Exit
				Else
					BA1->(DbSkip())
				EndIf
				
			EndDo
			
		Else
			BA1->(RestArea(aAreaBA1))//Reposiciono e restauro os indices somente se nao alterar a matricula
		EndIf
		
	EndIf
	
	//Leonardo Portella - 21/09/12 - Fim
	
Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCarMun    บAutor  ณThiago Machado Correaบ Data ณ  22/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAlimenta descricao da cidade no browse de contas medicas(BD5)บฑฑ
ฑฑบ          ณUtilizado no X3_RELACAO (BD5_YCDRDA) e X3_VLDUSR (BD5_LOCATE)บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณMP8                                           			   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CarMun(lInclui,lGatilho)
	
	Local cRet := ""
	
	If lInclui
		cRet := BB8->BB8_MUN
	Else
		If lGatilho
			M->BD5_YCDRDA := Posicione("BB8",1,xFilial("BB8")+M->(BD5_CODRDA+BD5_OPERDA+BD5_LOCATE),"BB8_MUN")
			Return .T.
		Else
			cRet := Posicione("BB8",3,xFilial("BB8")+BD5->(BD5_CODRDA+BD5_CODOPE+BD5_LOCAL),"BB8_MUN")
		Endif
	Endif
	
Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMultReemb บAutor  ณMicrosiga           บ Data ณ  29/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao chamada por gatilho no reembolso, a fim de possibi-  บฑฑ
ฑฑบ          ณlitar a multiplicacao do valor calculado por um fator.      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MultReemb(nFator)
	Local lRet := .F.
	LOCAL cTabRem := ""
	LOCAL nUsReem := 0
	LOCAL aRetAux := PLSXVLDCAL(dDataBase,plsintpad(),.T.,"","")
	
	If ! aRetAux[1]
		Help("",1,"PLSA500CAL")
		Return
	Endif
	
	If nFator <= 0
		MsgAlert("Fator deve ser maior que zero!","Aten็ใo")
	Else
		
		//Reduz valor do custo do procedimento na tela principal, para recalcular...
		M->BKD_VLRREM -= M->BKE_VLRRBS
		M->BKD_VLRCST -= M->BKE_VLRCST
		
		//Recalcula valor para possibilitar o fator...
		cTabRem := M->BKD_TABREM
		nUsReem := PlsReUsRem(aRetAux,;
			alltrim(M->BKD_CODCRE),;
			alltrim(M->BKE_CODTAB),;
			alltrim(M->BKE_CODPRO),;
			M->BKD_DATA)
		M->BKE_VLRCST := PLSVLRTREM(PLSINTPAD(),cTabRem,M->BKD_USUARI,M->BKD_DATA,"",M->BKE_CODTAB,M->BKE_CODPRO,M->BKE_QTDPRO,;
			nUsReem)
		
		//Recalcula o valor do procedimento, conforme fator.
		M->BKE_VLRCST := M->BKE_VLRCST*nFator
		
		If M->BKE_VLRPAG > 0
			M->BKE_VLRRBS := IF(M->BKE_VLRPAG<M->BKE_VLRCST-((M->BKE_VLRCST*M->BKE_PERREM)/100),M->BKE_VLRPAG,M->BKE_VLRCST-((M->BKE_VLRCST*M->BKE_PERREM)/100))
		Endif
		
		//Apos obtencao do valor do reembolso, adicionar novamente o total do item, a fim de manter consistencia.
		M->BKD_VLRREM += M->BKE_VLRRBS
		M->BKD_VLRCST += M->BKE_VLRCST
		lRet := .T.
		
		lRefresh := .T.
		oEnchoice:Refresh()
		
	Endif
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldQtdPro บAutor  ณMicrosiga           บ Data ณ  10/04/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldQtdPro
	Local nRet := 0
	
	If M->BD6_YVLTAP > 0
		
		//If M->BD6_QTDAPR = 0 .AND. M->BD6_QTDPRO > 0
		If M->BD6_QTDPRO > 0
			nRet := M->(BD6_YVLTAP/BD6_QTDPRO)
		Endif
		
	Endif
	
Return nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldQtdApr บAutor  ณMicrosiga           บ Data ณ  10/04/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldQtdApr
	Local nRet := 0
	
	nRet := If(M->BD6_VLRAPR > 0,M->BD6_VLRAPR,M->BD6_YVLTAP)
	/*
	If M->BD6_YVLTAP > 0
		
		If M->BD6_QTDAPR = 0 .AND. M->BD6_QTDPRO > 0
			nRet := M->(BD6_YVLTAP/BD6_QTDPRO)
		ElseIf M->BD6_QTDAPR > 0
			nRet := M->(BD6_YVLTAP/BD6_QTDAPR)
		Endif
		
	Endif
	*/
Return nRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQtdZZP    บAutor    Leandro            บ Data ณ  02/07/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ total das qtds de guias digitadas.                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protocolo de Remessas digitadas.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function QtdZZP
	
	M->ZZP_QTDTOT := M->(ZZP_QTDCON+ZZP_QTDSAD+ZZP_QTDAMB)//+ZZP_QTDINT+ZZP_QTDEQC+ZZP_QTDCLI+ZZP_QTDAPI+ZZP_QTDODN+ZZP_QTDHON+ZZP_QTDODS)Alterado por Renato Peixoto em 12/04/12
	M->ZZP_QTOTIN := M->(ZZP_QTDINT+ZZP_SADINT+ZZP_QTDHON+ZZP_QTDODS)//Alterado por Renato Peixoto em 12/04/12
	M->ZZP_QTOTGU := M->(ZZP_QTDTOT+ZZP_QTOTIN+ZZP_QTDODN)//Alterado por Renato Peixoto em 12/04/12
	
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVlrZZP    บAutor  ณMicrosiga           บ Data ณ  12/17/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VlrZZP
	
	M->ZZP_VLRTOT := M->(ZZP_VLRCON+ZZP_VLRSAD+ZZP_VLRAMB)//+ZZP_VLRINT+ZZP_VLREQC+ZZP_VLRCLI+ZZP_VLRAPI+ZZP_VLRODN+ZZP_VLRHON+ZZP_VLRODS)alterado por Renato Peixoto em 12/04/12
	M->ZZP_VLTOTI := M->(ZZP_VLRINT+ZZP_VLSDTI+ZZP_VLRHON+ZZP_VLRODS)//Alterado por Renato Peixoto em 12/04/12
	M->ZZP_VLTGUI := M->(ZZP_VLRTOT+ZZP_VLTOTI+ZZP_VLRODN)//Alterado por Renato Peixoto em 12/04/12
	
Return .T.


//---> Leandro 30/04/2007
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PacInt     บAutor  ณ Leandro Brandao  บ Data ณ  30/04/07   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณfuncao que critica se a data de atendimento esta compreendi-บฑฑ
ฑฑบ          ณdo dentro de um perํodo de internacao.                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User function PacInt(dData)
	
	Local dData
	Local cPeg
	Local aAreaBCI := BCI->(GetArea())
	
	//BIANCHINI - INICIO
	//If BCI->BCI_TIPGUI == "03"
	If BCI->BCI_TIPGUI $ "03|05"
		//BIANCHINI - FIM
		IF (dData < BE4->BE4_DATPRO)
			MsgBox("Data da realizacao do procedimento fora do periodo da internacao !","Atencao !","Alert")
			Return(.F.)
		Else
			Return(.T.)
		EndIf
	Else
		IF (dData < M->BD5_DATPRO) .OR. (dData >= dDataBase)
			
			MsgBox("Data da realizacao do procedimento fora do periodo da realizacao do evento !","Atencao !","Alert")
			Return(.F.)
		Else
			Return(.T.)
		EndIf
	EndIf
	
	//TRB->(DbCloseArea())
	
	RestArea(aAreaBCI)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetVencReembบAutor  ณ Raquel Casemiro  บ Data ณ  11/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSoma a quantidade de dias parametrizada no subcontrato x    บฑฑ
ฑฑบ          ณproduto a data de digit., retornando a proxima data util    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function RetVencReemb(cMatricula)
	
	Local dRetorno 	:= MSDATE()
	Local nRet		:= 0
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Marcar areas atualmente em uso...                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Local aAreaBA1 := BA1->(GetArea())
	Local aAreaBA3 := BA3->(GetArea())
	Local aAreaBT6 := BT6->(GetArea())
	
	BA1->(DbSetOrder(2))
	BA3->(DbSetOrder(1))
	BT6->(DbSetOrder(1))
	
	If BA1->(MsSeek(xFilial("BA1")+cMatricula))
		If !Empty(BA1->BA1_CODPLA)
			BT6->(MsSeek(BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)))
			nRet:=BT6->BT6_YQTDPG
		Else
			If BA3->(MsSeek(xFilial("BA3")+Substr(cMatricula,1,14)))
				BT6->(MsSeek(BA3->(BA3_FILIAL+BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)))
				nRet:=BT6->BT6_YQTDPG
			Else
				MsgAlert("Atencao!","Produto no usuแrio/famํlia nใo informado/invแlido. Verifique!")
			Endif
		Endif
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Retornar para areas em uso...                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	RestArea(aAreaBA1)
	RestArea(aAreaBA3)
	RestArea(aAreaBT6)
	
	dRetorno:=MSDATE()+nRet
	dRetorno:=dataValida(dRetorno)
	
	M->BKD_DATVEN := dRetorno
	
Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetFatReemb บAutor  ณ Raquel Casemiro  บ Data ณ  13/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRet. Fator Reembolso parametrizada no subcontrato x         บฑฑ
ฑฑบ          ณproduto e executa a funcao para calcular o valor do reemb   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function RetFatReemb()
	
	Local nFat			:= 1
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Marcar areas atualmente em uso...                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Local aAreaBT6 := BT6->(GetArea())
	
	BT6->(DbSetOrder(1))
	
	If !Empty(BA1->BA1_CODPLA)
		BT6->(MsSeek(xFilial("BT6")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB+BA1_CODPLA+BA1_VERSAO)))
		nFat:=BT6->BT6_YFTREE
	Else
		If BT6->(MsSeek(xFilial("BT6")+BA3->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB+BA3_CODPLA+BA3_VERSAO)))
			nFat:=BT6->BT6_YFTREE
		Else
			MsgAlert("Atencao!","Produto no usuแrio/famํlia nใo informado/invแlido. Verifique!")
		Endif
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Retornar para areas em uso...                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	RestArea(aAreaBT6)
	
	M->BKE_YFTREE := nFat
	U_MultReemb(M->BKE_YFTREE)
	
Return .t.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSomaComp  บAutor  ณ Jean Schulz        บ Data ณ  18/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAdiciona um mes a competencia passada por parametro...      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus SIGAPLS.                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function SomaComp(cAnoMes)
	Local cRet := ""
	
	cRet := Substr(DtoS(StoD(cAnoMes+"15")+30),1,6)
	
Return cRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGerAdNeg  บAutor  ณMicrosiga           บ Data ณ  10/19/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera adicionais de debito ao usuario, conforme negociacao   บฑฑ
ฑฑบ          ณfinanceira (customizacao de baixa) ou ret. Rio Previdencia. บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ.                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GerAdNeg(aDadosPar,aDadosUsr,cNumTit,cNumLot,cChvBDH)

Local lRet			:= .F.
Local nCont			:= 0
Local cNivel		:= ""
Local lCalcNivCob	:= .F.

Private _cNroLote	:= ""

Default cChvBDH		:= ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Legenda Matriz aDadosPar[N,X]                                         ณ
//ณ 1-AnoMes - Caractere - 006 posicoes                                   ณ
//ณ 2-VlrPar - Numerico  - 017,4                                          ณ
//ณ 3-Mes/Ano- Caractere - 007 posicoes (MM/AAAA)                         ณ
//ณ 4-CodLan - Caractere - 003 posicoes                                   ณ
//ณ 5-CCusto - Numerico  - 009 posicoes                                   ณ
//ณ 6-IteCta - Caractere - 009 posicoes                                   ณ
//ณ 7-Observ - Caractere - 100 posicoes                                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Legenda Vetor aDadosUsr[]                                             ณ
//ณ 1-CodInt - Caractere - 04 posicoes                                    ณ
//ณ 2-CodEmp - Caractere - 04 posicoes                                    ณ
//ณ 3-Matric - Caractere - 06 posicoes                                    ณ
//ณ 4-ConEmp - Caractere - 12 posicoes                                    ณ
//ณ 5-VerCon - Caractere - 03 posicoes                                    ณ
//ณ 6-SubCon - Caractere - 09 posicoes                                    ณ
//ณ 7-VerSub - Caractere - 03 posicoes                                    ณ
//ณ 8-NivCob - Caractere - 01 posicao (opcional)                          ณ
//ณ 9-CodUsu - Caractere - 17 posicao (opcional - mat.completa usr)       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

BSQ->(DbSetOrder(1))

_cNroLote := cNumLot

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Obtem nivel de cobranca, caso nao esteja na matriz de usuarios        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Len(aDadosUsr) > 7
	If Empty(aDadosUsr[8])
		lCalcNivCob := .T.
	Endif
Else
	lCalcNivCob := .T.
Endif

If lCalcNivCob
	If !Empty(aDadosUsr[3])
		cNivel := '5'
	Elseif !Empty(aDadosUsr[6])
		cNivel := '3'
	Elseif !Empty(aDadosUsr[4])
		cNivel := '2'
	Elseif !Empty(aDadosUsr[2])
		cNivel := '1'
	Endif
Else
	cNivel := aDadosUsr[8]
Endif

For nCont := 1 to Len(aDadosPar)

	BSP->(DbSetOrder(1))
	If BSP->(MsSeek(xFilial("BSP")+aDadosPar[nCont,4]))

		If aDadosPar[nCont,2] > 0

			If fPesqMovBsq(Substr(aDadosPar[nCont,1],5,2),Substr(aDadosPar[nCont,1],1,4),cNumTit)

				**'Marcela Coimbra'**
				a_AreaBsq := GetArea("BSQ")
				dbSelectArea("BSQ")
				dbOrderNickName("YNMSE1")
				If ( aDadosPar[nCont,4] == "993" .and. !dbSeek(xFilial("BSQ") + cNumTit ) ) .or. aDadosPar[nCont,4] <> "993"

					BSQ->(Reclock("BSQ",.T.))
						BSQ->BSQ_FILIAL	:= xFilial("BSQ")
						BSQ->BSQ_CODSEQ	:= PLSA625Cd("BSQ_CODSEQ","BSQ",1,"D_E_L_E_T_"," ")
						BSQ->BSQ_CODINT	:= aDadosUsr[1]
						BSQ->BSQ_CODEMP	:= aDadosUsr[2]
						BSQ->BSQ_MATRIC	:= aDadosUsr[3]
						BSQ->BSQ_CONEMP	:= aDadosUsr[4]
						BSQ->BSQ_VERCON	:= aDadosUsr[5]
						BSQ->BSQ_SUBCON	:= aDadosUsr[6]
						BSQ->BSQ_VERSUB	:= aDadosUsr[7]
						BSQ->BSQ_COBNIV	:= cNivel

						If Len(aDadosUsr) > 8
							BSQ->BSQ_USUARI	:= aDadosUsr[9]	// Conforme regra de inclusao de debito/credito, quando eh informado o campo BSQ_USUARI, o nivel devera sempre ser 5
							BSQ->BSQ_COBNIV := '5'
						Endif

						BSQ->BSQ_ANO	:= Substr(aDadosPar[nCont,1],1,4)
						BSQ->BSQ_MES	:= Substr(aDadosPar[nCont,1],5,2)
						BSQ->BSQ_CODLAN	:= aDadosPar[nCont,4]
						BSQ->BSQ_VALOR	:= aDadosPar[nCont,2]
						BSQ->BSQ_NPARCE	:= "1"
						BSQ->BSQ_CC		:= aDadosPar[nCont,5]
						BSQ->BSQ_ITECTA	:= aDadosPar[nCont,6]
						BSQ->BSQ_OBS	:= aDadosPar[nCont,7]
						BSQ->BSQ_AUTOMA	:= "1"
						BSQ->BSQ_TIPO	:= BSP->BSP_TIPSER
						BSQ->BSQ_TIPEMP	:= "2"
						BSQ->BSQ_ATOCOO	:= "1"
						BSQ->BSQ_YNMSE1	:= cNumTit
						BSQ->BSQ_YABASE	:= SE1->E1_ANOBASE
						BSQ->BSQ_YMBASE	:= SE1->E1_MESBASE

						If Type("_cNroLote") <> "U"
							BSQ->BSQ_YNMLOT	:= _cNroLote
						Endif

						BSQ->BSQ_ZHIST	:= cChvBDH			// FRED: Gravar RECNO's das BDH que compoe o valor senndo credito neste lan็amento
					
					BSQ->(MsUnlock())
				
				EndIf
			
			Endif

			lRet := .T.
		
		Endif
	
	Else
		lRet	:= .F.
		nCont	:= Len(aDadosPar)
	Endif

Next

Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  10/19/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function TrocaCodAnt(cCodPad,cCodAnt)
	Local cCodigo	:= ""
	Local cSQL		:= ""
	Local aAreaBA8	:= BA8->(GetArea())
	Local cRet := .F.
	Private cCodPadVar
	Private cCodAntVar
	
	cCodPadVar := cCodPad
	cCodAntVar := cCodAnt
	
	If !empty(cCodAnt) .and. !empty(cCodPad)//Leonardo Portella - 10/12/13 - Virada P11 - Mudar somente quando nao for vazio. Inclusao do IF.
		
		cSQL := " SELECT COUNT(*) QTD FROM "+RetSQLName("BA8")
		cSQL += " WHERE BA8_CODANT = '"+cCodAnt+"' "
		cSQL += " AND BA8_CODPAD = '"+cCodPad+"' "
		cSQL += " AND D_E_L_E_T_ = ' ' "
		PlsQuery(cSQL,"TRB")
		
		IF (TRB->QTD) > 1
			MsgAlert("C๓digo antigo digitado. Escolha apenas UM dos c๓digos atuais!","Aten็ใo!")
			cRet := CONPAD1(,,,"BA8TUS",,,.F.)
			M->BD6_CODPAD := BA8->BA8_CODPAD
			M->BD6_CODPRO := BA8->BA8_CODPRO
		ELSE
			TRB->(DbCloseArea())
			cSQL := " SELECT BA8_CODPAD, BA8_CODPRO FROM "+RetSQLName("BA8")
			cSQL += " WHERE BA8_CODANT = '"+cCodAnt+"' "
			cSQL += " AND BA8_CODPAD = '"+cCodPad+"' "
			cSQL += " AND D_E_L_E_T_ = ' ' "
			PlsQuery(cSQL,"TRB")
			
			If !Empty(TRB->BA8_CODPRO)
				MsgAlert("C๓digo antigo digitado. Substituirแ por c๓digo atual!","Aten็ใo!")
				M->BD6_CODPAD := TRB->BA8_CODPAD
				M->BD6_CODPRO := TRB->BA8_CODPRO
			Endif
		ENDIF
		
		TRB->(DbCloseArea())
		
	EndIf //Leonardo Portella - 10/12/13
	
	RestArea(aAreaBA8)
	
Return .T.
/*
User Function TrocaCodAnt(cCodAnt)
	Local cCodigo	:= ""
	Local cSQL		:= ""
	Local aAreaBA8	:= BA8->(GetArea())
	
	cSQL := " SELECT BA8_CODPAD, BA8_CODPRO FROM "+RetSQLName("BA8")
	cSQL += " WHERE BA8_CODANT = '"+cCodAnt+"' "
	cSQL += " AND D_E_L_E_T_ = ' ' "
	PlsQuery(cSQL,"TRB")
	
	If !Empty(TRB->BA8_CODPRO)
		MsgAlert("C๓digo antigo digitado. Substituirแ por c๓digo atual!","Aten็ใo!")
		M->BD6_CODPAD := TRB->BA8_CODPAD
		M->BD6_CODPRO := TRB->BA8_CODPRO
	Endif
	
	TRB->(DbCloseArea())
	
	RestArea(aAreaBA8)
	
Return .T.
*/


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPosicBQCBYZ บAutor  ณ Jean Schulz      บ Data ณ  19/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para atribuir campos por gatilho.                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PosicBQCBYZ(cCampo)
	Local cRet := ""
	
	cRet := Posicione("BQC",1,XFILIAL("BYZ")+M->(Alltrim(BYZ_CGREMP)+Alltrim(BYZ_NUMCON)+Alltrim(BYZ_VERCON)+Alltrim(BYZ_SUBCON)),cCampo)
	
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuStatus   บAutor  ณ Jean Schulz      บ Data ณ  24/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtribui status "0" para um item de autorizacao...           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AtuStatus(cCampo)
	Local lRet := .T.
	Private cLocCam := ""
	
	cLocCam := "M->"+cCampo
	
	&cLocCam := "0"
	
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGetFile  บAutor  ณ Jean Schulz        บ Data ณ  26/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Abre janela para selecionar um determinado arquivo         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fGetFile(cTipo)
	*****************************
	Local cNomeArq
	
	cNomeArq   	 := cGetFile(cTipo,"Selecione o Arquivo")
	If ! Empty(cNomeArq)
		&(__ReadVar) := cNomeArq
	End
	
Return(.t.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  10/30/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function MsgOrtProt(cCodPro)
	Local aAreaBR8 := BR8->(GetArea())
	
	BR8->(DbSetOrder(3))
	
	If BR8->(MsSeek(xFilial("BR8")+cCodPro))
		If BR8->BR8_YMATER == "1"
			MsgAlert("Este procedimento permite o uso de OPME!","Aten็ใo!")
		Endif
	Endif
	
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณRaquel              บ Data ณ  11/01/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Funcao para ser usada na validacao de usuario do campo    บฑฑ
ฑฑบ          ณ  BE2_CODPRO. Foi nescessario criar esta funcao, para       บฑฑ
ฑฑบ          ณ  acrescentar a funcao MsgOrtProt, ja que o tamanho da      บฑฑ
ฑฑบ          ณ  validacao nao permitia acrescentar esta funcao.           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ValProcBE2()
	PLSEXISPAC(M->BE1_OPERDA,M->BE1_CODRDA,M->BE2_CODPAD,M->BE2_CODPRO,"M->BE1_PACOTE","M->BE1_VLRPAC")
	U_MsgOrtProt(M->BE2_CODPRO)
	
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValHisAED บAutor  ณ Jean Schulz        บ Data ณ  08/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida historico AED, proibindo bloqueio/inclusao indevida. บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ValHisAED(cCodSol)
	Local lRet := .T.
	
	If ZZF->(MsSeek(xFilial("ZZF")+cCodSol))
		
		While !ZZF->(Eof()) .And.  ZZF->ZZF_CODIGO == cCodSol
			ZZF->(DbSkip())
		Enddo
		ZZF->(DbSkip(-1))
		
		If ZZF->ZZF_CODIGO == cCodSol
			
			If M->ZZF_DATA < ZZF->ZZF_DATA
				MsgAlert("Data informada menor que ๚ltima data de movimenta็ใo!","Aten็ใo!")
				lRet := .F.
			Else
				If ZZF->ZZF_TIPO == M->ZZF_TIPO
					MsgAlert("Tipo informado igual a ๚ltima movimenta็ใo! Verifique!","Aten็ใo!")
					lRet := .F.
				Endif
			Endif
			
		Endif
	Endif
	
Return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRetNivCob   บ Autor ณ Jean Schulz      บ Data ณ  11/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Retorna Nivel de Cobranca de usuario...                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function RetNivCob(cCodUsr)
	Local aAreaBA1	:= BA1->(GetArea())
	Local aAreaBA3 	:= BA3->(GetArea())
	Local aAreaBQC	:= BQC->(GetArea())
	Local aAreaBT5	:= BT5->(GetArea())
	Local aAreaBG9	:= BG9->(GetArea())
	Local cNivCob	:= ""
	Local cCodCli	:= ""
	Local cLojCli	:= ""
	Local aRet		:= {} //1-Nivel / 2-Cliente / 3-Loja
	
	BA1->(DbSetorder(2))
	BA3->(DbSetorder(1))
	BQC->(DbSetorder(1))
	BT5->(DbSetorder(1))
	BG9->(DbSetorder(1))
	
	If BA1->(MsSeek(xFilial("BA1")+cCodUsr))
		
		If BA1->BA1_COBNIV == '1'
			cNivCob := "5"
			cCodCli	:= BA1->BA1_CODCLI
			cLojCli	:= BA1->BA1_LOJA
		Endif
		
		If Empty(cNivCob)
			If BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))
				If BA3->BA3_COBNIV == '1'
					cNivCob := "4"
					cCodCli	:= BA3->BA3_CODCLI
					cLojCli	:= BA3->BA3_LOJA
				Endif
			Endif
		Endif
		
		If Empty(cNivCob)
			If BQC->(MsSeek(xFilial("BQC")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)))
				If BQC->BQC_COBNIV == '1'
					cNivCob := "3"
					cCodCli	:= BQC->BQC_CODCLI
					cLojCli	:= BQC->BQC_LOJA
				Endif
			Endif
		Endif
		
		If Empty(cNivCob)
			If BT5->(MsSeek(xFilial("BT5")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON)))
				If BT5->BT5_COBNIV == '1'
					cNivCob := "2"
					cCodCli	:= BT5->BT5_CODCLI
					cLojCli	:= BT5->BT5_LOJA
				Endif
			Endif
		Endif
		
		If Empty(cNivCob)
			If BG9->(MsSeek(xFilial("BG9")+BA1->(BA1_CODINT+BA1_CODEMP)))
				If !Empty(BG9->BG9_CODCLI)
					cNivCob := "1"
					cCodCli	:= BG9->BG9_CODCLI
					cLojCli	:= BG9->BG9_LOJA
				Endif
			Endif
		Endif
		
	Endif
	
	RestArea(aAreaBA1)
	RestArea(aAreaBA3)
	RestArea(aAreaBQC)
	RestArea(aAreaBT5)
	RestArea(aAreaBG9)
	
	aadd(aRet,{cNivCob,cCodCli,cLojCli})
	
Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBSQNOME     บAutor  ณ Paulo Motta      บ Data ณ  21/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณObter nome do Usuario BSQ_NOME                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BSQNOME()
	Local cRet := ""
	
	cRet := IIF(!Inclui,IIF(!EMPTY(BSQ->BSQ_MATRIC),POSICIONE("BA1",2,XFILIAL("BA1")+BSQ->(BSQ_USUARI),"BA1_NOMUSR")," ")," ")
	
Return cRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPLSAppend บ Autor ณ Rafael             บ Data ณ  29/10/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao de append no arquivo TXT para o arquivo de trabalho.บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PLSAppendTmp(cNomeArq)
	
	DbSelectArea("TRB")
	Append From &(cNomeArq) SDF
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCria_TXT  บAutor  ณMicrosiga           บ Data ณ  25/11/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCriacao do arquivo texto                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Impressao dos boletos                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Cria_TXT(cNomeArq)
	nHdl    := fCreate(cNomeArq)
	If nHdl == -1
		MsgAlert("O arquivo de nome "+trim(cNomeArq)+" nao pode ser criado!","Atencao!")
		Return(.F.)
	Endif
	
RETURN(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrLinha_TXT บAutor  ณJean Schulz       บ Data ณ  25/11/05   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava e valida linha no TXT.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GrLinha_TXT(cCpo,cLin)
	cLin := Stuff(cLin,01,01,cCpo)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Gravacao no arquivo texto. Testa por erros durante a gravacao da    ณ
	//ณ linha montada.                                                      ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. ","Atencao!")
			return(.f.)
		Endif
	Endif
return(.t.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFecha_TXT   บAutor  ณJean Schulz       บ Data ณ  25/11/05   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFecha arq. TXT                                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User function Fecha_TXT()
	fClose(nHdl)
return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNmRDAAG   บAutor  ณ Jean Schulz        บ Data ณ  05/12/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca nome do RDA para o primeiro RDA encontrado conforme   บฑฑ
ฑฑบ          ณlote de Auto Gerado.                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NmRDAAG(cSequen,cAnoMes)
	Local cNomRDA := ""
	Local aAreaBD7 := BD7->(GetArea())
	
	BD7->(DbSetOrder(8))
	If BD7->(MsSeek(xFilial("BD7")+cSequen+cAnoMes))
		cNomRDA := Posicione("BAU",1,xFilial("BAU")+BD7->BD7_CODRDA,"BAU_NOME" )
	Endif
	
	RestArea(aAreaBD7)
	
Return(cNomRDA)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  10/19/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function TrCodBE2(cCodPad,cCodAnt,cTabRet)
	Local cCodigo	:= ""
	Local cSQL		:= ""
	Local aAreaBA8	:= BA8->(GetArea())
	Local cCampoPad := "M->"+cTabRet+"_CODPAD"
	Local cCampoPro := "M->"+cTabRet+"_CODPRO"
	
	Local cRet := .F.
	Private cCodPadVar
	Private cCodAntVar
	
	cCodPadVar := cCodPad
	cCodAntVar := cCodAnt
	
	cSQL := " SELECT COUNT(*) QTD FROM "+RetSQLName("BA8")
	cSQL += " WHERE BA8_CODANT = '"+cCodAnt+"' "
	cSQL += " AND BA8_CODPAD = '"+cCodPad+"' "
	cSQL += " AND D_E_L_E_T_ = ' ' "
	PlsQuery(cSQL,"TRB")
	
	IF (TRB->QTD) > 1
		MsgAlert("C๓digo antigo digitado. Escolha apenas UM dos c๓digos atuais!","Aten็ใo!")
		cRet := CONPAD1(,,,"BA8TUS",,,.F.)
		&cCampoPad := BA8->BA8_CODPAD
		&cCampoPro := BA8->BA8_CODPRO
	ELSE
		TRB->(DbCloseArea())
		cSQL := " SELECT BA8_CODPAD, BA8_CODPRO FROM "+RetSQLName("BA8")
		cSQL += " WHERE BA8_CODANT = '"+cCodAnt+"' "
		cSQL += " AND BA8_CODPAD = '"+cCodPad+"' "
		cSQL += " AND D_E_L_E_T_ = ' ' "
		PlsQuery(cSQL,"TRB")
		
		If !Empty(TRB->BA8_CODPRO)
			MsgAlert("C๓digo antigo digitado. Substituirแ por c๓digo atual!","Aten็ใo!")
			&cCampoPad := TRB->BA8_CODPAD
			&cCampoPro := TRB->BA8_CODPRO
		Endif
	ENDIF
	
	TRB->(DbCloseArea())
	
	RestArea(aAreaBA8)
	
Return .T.

/*
User Function TrCodBE2(cCodAnt,cTabRet)
	Local cCodigo	:= ""
	Local cSQL		:= ""
	Local aAreaBA8	:= BA8->(GetArea())
	Local cCampoPad := "M->"+cTabRet+"_CODPAD"
	Local cCampoPro := "M->"+cTabRet+"_CODPRO"
	
	cSQL := " SELECT BA8_CODPAD, BA8_CODPRO FROM "+RetSQLName("BA8")
	cSQL += " WHERE BA8_CODANT = '"+cCodAnt+"' "
	cSQL += " AND D_E_L_E_T_ = ' ' "
	PlsQuery(cSQL,"TRB")
	
	If !Empty(TRB->BA8_CODPRO)
		MsgAlert("C๓digo antigo digitado. Substituirแ por c๓digo atual!","Aten็ใo!")
		&cCampoPad := TRB->BA8_CODPAD
		&cCampoPro := TRB->BA8_CODPRO
	Endif
	
	TRB->(DbCloseArea())
	
	RestArea(aAreaBA8)
	
Return .T.

*/


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNmUsrBVX  บAutor  ณ Jean Schulz        บ Data ณ  13/12/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca nome do usuario para browse em BVX (Auditoria Medica) บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NmUsrBVX()
Return POSICIONE("BA1",2,xFilial("BA1")+PLSINTPAD()+BVX->(BVX_CODEMP+BVX_MATRIC+BVX_TIPREG),"BA1_NOMUSR")


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBusVlrGlo บAutor  ณ Jean Schulz        บ Data ณ  15/12/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca valor de glosa conforme regra do cliente.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function BusVlrGlo()
	
	Local aAreaBD6 		:= BD6->(GetArea())
	Local nVlrGlo  		:= 0
	Local cChave   		:= ""
	Local aAreaBDX 		:= {}
	Local nRecBDX  		:= 0
	Local nVlrAprBDx	:= 0
	
	BD6->(DbSetOrder(1))
	If M->BDX_ORIMOV == "1"
		cChave := PLSINTPAD()+BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)+M->(BDX_ORIMOV+BDX_SEQUEN)
	Else
		cChave := PLSINTPAD()+BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)+M->(BDX_ORIMOV+BDX_SEQUEN)
	Endif
	
	BD6->(MsSeek(xFilial("BD6")+cChave))
	
	//Leonardo Portella - 20/11/13 - Inicio - Ponteira no BDX correto
	
	aAreaBDX := BDX->(GetArea())
	
	nRecBDX	:= oBrwCri:aVetTrab[oBrwCri:linha()]//Recno da linha que esta sendo analisada - Vide PLSA500
	
	BDX->(DbGoTo(nRecBDX))
	
	nVlrAprBDx := BDX->BDX_VLRAPR
	
	BDX->(RestArea(aAreaBDX))
	
	//Leonardo Portella - 20/11/13 - Fim
	
	// Atualizacao:	08/11/13 - Vitor Sbano - 08/11/13 - Chamado TI3307 - && variable does not exist BDX_VLRAPR on U_BUSVLRGLO(
	
	//nVlrGlo := M->BDX_VLRMAN-((IIF(BD6->BD6_ENVCON<>"1",M->BDX_VLRMAN,M->BDX_VLRAPR)*M->BDX_PERGLO)/100)
	
	//Leonardo Portella - 20/11/13 - Inicio - Variavel nVlrAprBDx
	
	//nVlrGlo := M->BDX_VLRMAN-((IIF(BD6->BD6_ENVCON<>"1",M->BDX_VLRMAN,BDX->BDX_VLRAPR)*M->BDX_PERGLO)/100)
	nVlrGlo := M->BDX_VLRMAN-((IIF(BD6->BD6_ENVCON<>"1",M->BDX_VLRMAN,nVlrAprBDx)*M->BDX_PERGLO)/100)
	
	//Leonardo Portella - 20/11/13 - Fim
	
	M->BDX_VLRGLO := nVlrGlo
	
	RestArea(aAreaBD6)
	
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPerPacote บAutor  ณMicrosiga           บ Data ณ  12/18/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
/*
User Function PerPacote(nVlrTot,nPerPac)
Return (nVlrTot*nPerPac)/100
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValDtProc บAutor  ณMicrosiga           บ Data ณ  12/20/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ValDtProc(cAlias)
	Local lRet		:= .T.
	
	If M->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO) == BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)
		
		If !Empty(M->BD6_DATPRO) .And. !Empty(BE4->BE4_DTALTA) .And. !Empty(BE4->BE4_DATPRO)
			If !(M->BD6_DATPRO >= BE4->BE4_DATPRO .And. M->BD6_DATPRO <= BE4->BE4_DTALTA)
				lRet := .F.
			Endif
		Endif
		
	Endif
	
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValCod586 บAutor  ณ Jean Schulz        บ Data ณ  10/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValidacao para nao permitir que codigos sinteticos sejam    บฑฑ
ฑฑบ          ณincluidos na composicao de um pacote.                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ValCod586(cCodPro)
	Local lRet := .F.
	Local aAreaBA8 := BA8->(GetArea())
	BA8->(DbSetOrder(4)) //CODPAD+CODPRO
	
	lRet := Iif(Posicione("BA8",4,xFilial("BA8")+cCodPro,"BA8_ANASIN")=="1",.T.,.F.)
	
	RestArea(aAreaBA8)
	
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBusGDtPro บAutor  ณJean Schulz         บ Data ณ  01/17/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPosiciona e retorna o dado repassado por parametro, a partirบฑฑ
ฑฑบ          ณdo item da conta medica (BD6).                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BusBDXBD6(cCampoBD6,cTipo)
	Local aAreaBD6	:= BD6->(GetArea())
	Local xRetorno	:= IIf(cTipo=="C","",Iif(cTipo=="N",0,Iif(cTipo=="D",CtoD(""),.F.)))
	Local cChave	:= ""
	Local cCpBD6	:= "BD6->"+cCampoBD6
	
	//If Type("M->BDX_ORIMOV") <> "U" .And. Type("M->BDX_SEQUEN") <> "U"
	
	
	//If M->BDX_ORIMOV == "1"
	If BCI->BCI_TIPGUI <> "03"
		cChave := PLSINTPAD()+BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)+BDX->(BDX_ORIMOV+BDX_SEQUEN)
	Else
		cChave := PLSINTPAD()+BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)+BDX->(BDX_ORIMOV+BDX_SEQUEN)
	Endif
	
	BD6->(DbSetOrder(1))
	If BD6->(MsSeek(xFilial("BD6")+cChave))
		xRetorno := &cCpBD6
	Endif
	/*
Else
	xRetorno := &cCpBD6
Endif
*/

//RestArea(aAreaBD6)

Return xRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBusGDtPro บAutor  ณJean Schulz         บ Data ณ  01/17/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPosiciona e retorna o dado repassado por parametro, a partirบฑฑ
ฑฑบ          ณdo item da conta medica (BD6).                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BusBD6BDX(cCampoBDX,cTipo)
	
	Local aAreaBDX	:= BDX->(GetArea())
	Local xRetorno	:= IIf(cTipo=="C","",Iif(cTipo=="N",0,Iif(cTipo=="D",CtoD(""),.F.)))
	Local cChave	:= ""
	Local cCpBDX	:= "BDX->"+cCampoBDX
	Local cGloNiv2	:= ''
	Local cQry		:= ''
	//Local cAliasQry := GetNextAlias() 
	//Local aAreaBD6  := BD6->(GetArea())
	//Local aRetorno  := {}
	
	//Fabio Bianchini - 27/02/2019 - Virada P12 - BD6 vem desponteirada aqui
	
	
	BDX->(DbSetOrder(1))//BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_CODPAD+BDX_CODPRO+BDX_SEQUEN+BDX_CODGLO
	
	//Leonardo Portella - 26/11/13 - Virada P11 - Inicio
	//Otimizacao pois ao nao usar o maximo possivel da chave, estava dando muitos loops, gerando lentidao no sistema.
	
	If BD6->BD6_FASE <> '1' //Leonardo Portella - 26/11/13 - Nao buscar glosas em digitacao
		
		//BDX->(MsSeek(xFilial("BDX")+PLSINTPAD()+BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
		BDX->(MsSeek(xFilial("BDX") + BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO+BD6_SEQUEN)))
		
		//While BD6->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV)==BDX->(BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV) .And. !BDX->(Eof())
		While !BDX->(Eof()) .and. 	BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO) == ;
				BDX->(BDX_FILIAL+BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_SEQUEN+BDX_CODPAD+BDX_CODPRO)
			
			//If BDX->BDX_SEQUEN == BD6->BD6_SEQUEN .And. BDX->BDX_NIVEL == "1"
			
			/*If Left(BDX->BDX_INFGLO,11) == 'GLOSA_AUTO:'
			xRetorno 	:= BDX->BDX_INFGLO
			Exit
			
		Else*/
			If BDX->BDX_NIVEL == "1"
				xRetorno := &cCpBDX
				Exit
				
				//Leonardo Portella - 13/02/15 - Inicio
				
			ElseIf BDX->BDX_NIVEL == "2"//Evento
				cGloNiv2	:= &cCpBDX
			Endif
			
			//Leonardo Portella - 13/02/15 - Fim
			
			BDX->(DbSkip())
			
	EndDo
		
		//Leonardo Portella - 13/02/15 - Inicio - Se nao encontrar critica no nivel da guia, utilizar no nivel de evento
		
	If empty(xRetorno) .and. !empty(cGloNiv2)
		xRetorno := cGloNiv2
	EndIf
		
		//Leonardo Portella - 13/02/15 - Fim
		
		//Leonardo Portella - 26/11/13 - Virada P11 - Fim
		
//--------------------------------------------------
/*
		cQry := " SELECT BDX_FILIAL, BDX_CODOPE, BDX_CODLDP, BDX_CODPEG, BDX_NUMERO, BDX_ORIMOV, BDX_SEQUEN, BDX_CODPAD, BDX_CODPRO, BDX_NIVEL "
		cQry += "   FROM "+RetSqlName("BDX")+" BDX "
		cQry += "  WHERE BDX_FILIAL = '" + xFilial("BDX")  + "' "
		cQry += "    AND BDX_CODOPE = '" + BD6->BD6_CODOPE + "' "
		cQry += "    AND BDX_CODLDP = '" + BD6->BD6_CODLDP + "' "
		cQry += "    AND BDX_CODPEG = '" + BD6->BD6_CODPEG + "' "
		cQry += "    AND BDX_NUMERO = '" + BD6->BD6_NUMERO + "' "
		cQry += "    AND BDX_ORIMOV = '" + BD6->BD6_ORIMOV + "' "
		cQry += "    AND BDX_CODPAD = '" + BD6->BD6_CODPAD + "' "
		cQry += "    AND BDX_CODPRO = '" + BD6->BD6_CODPRO + "' "
		cQry += "    AND BDX_SEQUEN = '" + BD6->BD6_SEQUEN + "' "
		cQry += "    AND D_E_L_E_T_ = ' ' "				
		
		memowrite("c:\temp\BusBD6BDX.sql",cQry)
		
		IF SELECT(cAliasQry) > 0
			(cAliasQry)->(dbclosearea())
			cAliasQry := GetNextAlias()
		Endif		
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry,.T.,.T.)
		
		DbSelectArea(cAliasQry)
		
		While !(cAliasQry)->(EOF()) 
			If (cAliasQry)->BDX_NIVEL == "1"
				xRetorno := &cCpBDX
				Exit
				
			ElseIf (cAliasQry)->BDX_NIVEL == "2"//Evento
				cGloNiv2	:= &cCpBDX
			Endif
			
			(cAliasQry)->(DbSkip())
		EndDo

		If empty(xRetorno) .and. !empty(cGloNiv2)
			xRetorno := cGloNiv2
		EndIf
*/
	EndIf
	
	RestArea(aAreaBDX)
	
Return xRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBusTipUsu บAutor  ณMicrosiga           บ Data ณ  19/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca o tipo de usuario conforme cadastro de usuarios       บฑฑ
ฑฑบ          ณpermitidos por subcontrato.                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BusTipUsu(cOpeUsr, cCodEmp, cMatric, cTipReg)
	Local cTipUsu	:= ""
	Local aAreaBA1	:= BA1->(GetArea())
	Local aAreaBA3	:= BA1->(GetArea())
	Local aAreaBT0	:= BA1->(GetArea())
	Local cCodPla	:= ""
	Local cVerPla	:= ""
	
	BT0->(DbSetOrder(1))
	BA1->(DbSetOrder(2))
	BA3->(DbSetOrder(1))
	
	BA3->(MsSeek(xFilial("BA3")+cOpeUsr+cCodEmp+cMatric))
	cCodPla := BA3->BA3_CODPLA
	cVerPla	:= BA3->BA3_VERSAO
	
	If BA1->(MsSeek(xFilial("BA1")+cOpeUsr+cCodEmp+cMatric+cTipReg))
		cCodPla := Iif(!Empty(BA1->BA1_CODPLA),BA1->BA1_CODPLA,cCodPla)
		cVerPla := Iif(!Empty(BA1->BA1_VERSAO),BA1->BA1_VERSAO,cVerPla)
	Endif
	
	If BT0->(MsSeek(xFilial("BT0")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+cCodPla+cVerPla))
		cTipUsu := "A"
		While !BT0->(Eof()) .And. BT0->(BT0_CODIGO+BT0_NUMCON+BT0_VERCON+BT0_SUBCON+BT0_VERSUB+BT0_CODPRO+BT0_VERSAO)==BA1->(BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB)+cCodPla+cVerPla
			
			If BT0->BT0_TIPUSR <> "T"
				cTipUsu := "T"
				Exit
			Endif
			BT0->(DbSkip())
			
		Enddo
	Else
		cTipUsu := "T"
	Endif
	
	RestArea(aAreaBA1)
	RestArea(aAreaBA3)
	RestArea(aAreaBT0)
	
Return cTipUsu


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVALIDEQP  บAutor  ณGeraldo Felix Juniorบ Data ณ  01/15/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Validacao da equipe de venda na familia. Inserida aqui paraบฑฑ
ฑฑบ          ณ corrigir problema da funcao padrao.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER Function VALIDEQP(cAlias)
	LOCAL lRet := .T.
	Local cEquipe := &("M->" + cAlias + "_EQUIPE")
	Local cCodVen := &("M->" + cAlias + "_CODVEN")
	Local cCodVe2 := &("M->" + cAlias + "_CODVE2")
	
	If !Empty(cEquipe)
		BXL->( dbSetorder(01) )
		If BXL->( MsSeek(xFilial("BXL")+cEquipe) )
			BXM->( dbSetorder(01) )
			If !BXM->( MsSeek(xFilial("BXM")+BXL->BXL_SEQ) )
				Help("",1,"PLS260EQP1")
				lRet := .F.
			ElseIf !Empty(cCodVen)
				If !BXM->( MsSeek(xFilial("BXM")+BXL->BXL_SEQ+cCodVen) )
					Help("",1,"PLS260EQP2")
					lRet := .F.
				EndIf
			ElseIf !Empty(cCodVe2)
				If !BXM->( MsSeek(xFilial("BXM")+BXL->BXL_SEQ+cCodVe2) )
					Help("",1,"PLS260EQP3")
					lRet := .F.
				EndIf
			Endif
		Else
			Help("",1,"REGNOIS")
			lRet := .F.
		Endif
	Endif
	
Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |GatRepUsu   บAutor  ณ Raquel           บ Data ณ  09/02/07   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o repasse do usuario                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GatRepUsu(cCodUsr)
	Local cRet := ""
	Local cTemp:=""
	
	**'Marcela Coimbra --- Data: 21/10/10 - Chamado GLPI 623'**
	**'Inicio Comentado- Chamado GLPI 623'**
	//ctemp:= POSICIONE("BA1",2,XFILIAL("BA1")+M->(ZZK_CODINT+ZZK_CODEMP +ZZK_MATRIC + ZZK_TIPREG + ZZK_DIGITO),"BA1->BA1_OPEDES")
	**'Fim Comentado - Chamado GLPI 623'**
	
	**'Inicio Bloco- Chamado GLPI 623'**
	
	If Inclui
		
		ctemp:= POSICIONE("BA1",2,XFILIAL("BA1")+M->(ZZK_CODINT+ZZK_CODEMP +ZZK_MATRIC + ZZK_TIPREG + ZZK_DIGITO),"BA1->BA1_OPEDES")
		
	Else
		
		ctemp:= POSICIONE("BA1",2,XFILIAL("BA1")+ZZK->(ZZK_CODINT+ZZK_CODEMP +ZZK_MATRIC + ZZK_TIPREG + ZZK_DIGITO),"BA1->BA1_OPEDES")
		
	EndIf
	
	**'Fim Bloco- Chamado GLPI 623'**
	
	cRet := POSICIONE("BA0",1,XFILIAL("BA0")+ctemp,"BA0->BA0_CODIDE+'.'+BA0->BA0_CODINT+' - '+BA0->BA0_NOMINT")
	
Return (cRet)




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  12/02/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGravar senha da internacao no campo informado por parametro.บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ValUsrInt(cCodUsr,dDatAnl,cHorPro,cCampo,cAlias)
	Local aInter	:= {}
	Local aAreaBE4	:= BE4->(GetArea())
	
	aInter := PLSUSRINTE(cCodUsr,dDatAnl,cHorPro,.T.,.F.,cAlias)
	
	If Valtype(aInter) == "A" //Angelo Henrique - 11/08/2015 - a Rotina PLSUSRINTE tamb้m pode retornar valor l๓gico.
		
		If Len(aInter) > 0
			If aInter[1]
				
				BE4->(DbSetOrder(1))
				If BE4->(MsSeek(xFilial("BE4")+aInter[2]+aInter[3]+aInter[4]+aInter[5]))
					&cCampo := BE4->BE4_SENHA
				Endif
				
			Endif
		Else
			&cCampo := ""
		Endif
		
	Else
		
		&cCampo := ""
		
	EndIf
	
	RestArea(aAreaBE4)
	
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  02/22/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VlrForca(nValor)
	Local lRet	:= .T.
	
	If nValor < 0
		lRet := .F.
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Somente se vlr forcado maior que 0, atualizar valores...              ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If nValor > 0 .And. nValor < M->BKE_VLRRBS
		M->BKD_VLRREM -= M->BKE_VLRRBS
		M->BKE_VLRRBS := M->BKE_YVLFOR
		M->BKD_VLRREM += M->BKE_VLRRBS
	Endif
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  02/22/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VlrMax(nValor)
	Local lRet	:= .T.
	public _nVlrAnt
	
	If Type("_nVlrAnt") == "U"
		_nVlrAnt := 0
	Endif
	
	If nValor < 0
		lRet := .F.
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Somente se vlr maximo maior que 0, atualizar valor de reembolso...    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If nValor > 0
		
		If nValor < M->BKD_VLRREM
			_nVlrAnt := M->BKD_VLRREM
			M->BKD_VLRREM := nValor
		Endif
		
	Else
		M->BKD_VLRREM := _nVlrAnt
	Endif
	
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  02/22/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CpPag()
	
	MsAguarde({|| U_CpPag1(), "Cแlculo do Reembolso", OemToAnsi("Aguarde, recalculando valores...")})
	
Return .t.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  02/26/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldPerCRe(nPerc,cCampo)
	
	M->BKD_VLRREM -= M->BKE_VLRRBS
	
	If nPerc > 0
		M->BKE_VLRRBS := &cCampo*(nPerc/100)
	Else
		M->BKE_VLRRBS := M->BKE_VLRCST
		
		If M->BKE_VLRRBS > M->BKE_VLRPAG
			M->BKE_VLRRBS := M->BKE_VLRPAG
		Endif
	Endif
	
	M->BKD_VLRREM += M->BKE_VLRRBS
	
	lRefresh := .T.
	oEnchoice:Refresh()
	
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMarca     บAutor  ณMicrosiga           บ Data ณ  26/02/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMarca ou desmarca todos os checkboxs no grid.               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Marca(lMarca)
	Local i := 0
	//marca ou desmarca todos os itens
	For i := 1 To Len(aVetor)
		aVetor[i][1] := lMarca
	Next i
	oLbx:Refresh()
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBB0BE4    บAutor  ณMicrosiga           บ Data ณ  26/02/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida caso BB0 esteja bloqueado em liberacao (BB4)         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BB0BE4(dDataCrit)
	Local lRet		:= .T.
	Local aAreaBB0	:= BB0->(GetArea())
	Local cCodBB0	:= BB0->BB0_CODIGO
	
	BB0->(DbSetOrder(4))
	If BB0->BB0_CODIGO <> M->BE4_CDPFSO .And. BB0->BB0_NUMCR <> M->BE4_REGSOL
		If !BB0->(MsSeek(xFilial("BB0")+M->(BE4_ESTSOL+BE4_REGSOL)))
			Return lRet
		Endif
		
	Endif
	
	If !Empty(BB0->BB0_DATBLO) .And. dDataCrit > BB0->BB0_DATBLO
		lRet := .F.
		MsgAlert("Profissional de sa๚de jแ bloqueado! Data de bloqueio: "+DtoC(BB0->BB0_DATBLO))
	Endif
	
	RestArea(aAreaBB0)
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEdComiss    บAutor  ณ Raquel           บ Data ณ  21/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณControla a edicao na tela de itens de comissao              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function EdComiss(condicao)
	Local lRet := .F.
	if (!(Upper(alltrim(cUserName)) $ GetNewPar("MV_YNMCOMIS","##")) .And. condicao)
		lRet := .T.
	endif
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBB0BE1    บAutor  ณMicrosiga           บ Data ณ  26/02/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida caso BB0 esteja bloqueado em liberacao (BB4)         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BB0BE1(dDataCrit)
	Local lRet		:= .T.
	Local aAreaBB0	:= BB0->(GetArea())
	
	BB0->(DbSetOrder(4))
	
	If BB0->BB0_CODIGO <> M->BE1_CDPFSO .And. BB0->BB0_NUMCR <> M->BE1_REGSOL
		If !BB0->(MsSeek(xFilial("BB0")+M->(BE1_ESTSOL+BE1_REGSOL)))
			Return lRet
		Endif
	Endif
	
	If !Empty(BB0->BB0_DATBLO) .And. dDataCrit > BB0->BB0_DATBLO
		lRet := .F.
		MsgAlert("Solicitante bloqueado! Data de bloqueio: "+DtoC(BB0->BB0_DATBLO))
	Endif
	
	RestArea(aAreaBB0)
	
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCodProd   บAutor  ณ Gedilson Rangel    บ Data ณ  22/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Busca produto do usuario/familia, conforme parametrizado.  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CodProd(cMatricula)
	Local aAreaBA1 	:= BA1->(GetArea())
	Local aAreaBA3 	:= BA3->(GetArea())
	Local cRet		:= ""
	
/*	if !inclui
		alert("nใo ้ inclusใo")
	endif*/
	
	BA1->(MsSeek(xFilial("BA1")+cMatricula))
	BA3->(MsSeek(xFilial("BA3")+Substr(cMatricula,1,14)))
	
	cRet := Iif(!Empty(BA1->BA1_CODPLA),BA1->(BA1_CODPLA+BA1_VERSAO),BA3->(BA3_CODPLA+BA3_VERSAO))
	
	RestArea(aAreaBA1)
	RestArea(aAreaBA3)
	
Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  05/30/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ValSeqBEJ
	Local lRet := .F.
	
	If Type("M->BEJ_SEQUEN")<>"U"
		If M->BEJ_SEQUEN == "001"
			lRet := .T.
		Endif
	Endif
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldCRBau  บAutor  ณMicrosiga           บ Data ณ  06/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldCRBau(cChave)
	
	Local lRet 		:= .T.
	Local aAreaBAU 	:= BAU->(GetArea())
	Local nRecBAU  	:= BAU->(Recno())//Leonardo Portella - 16/07/12
	
	BAU->(DbSetOrder(3))//BAU_FILIAL + BAU_ESTCR + BAU_CONREG + BAU_SIGLCR
	
	//Leonardo Portella - 16/07/12 - Inicio - Nao exibir a critica se estiver no proprio BAU
	
	If (BAU->(MsSeek(xFilial("BAU") + cChave)))
		
		//Continuo buscando para ver se existe outro RDA usando o CRM
		While !BAU->(EOF()) .and. ( BAU->(BAU_FILIAL + BAU_ESTCR + BAU_CONREG + BAU_SIGLCR) == xFilial("BAU") + cChave )
			If ( nRecBAU <> BAU->(Recno()) )
				lRet := .F.
				exit
			EndIf
			
			BAU->(DbSkip())
		EndDo
		
		If !lRet
			MSgStop("CRM ja utilizado em outro Prestador("+ BAU->BAU_CODIGO + " - " + TRIM(BAU->BAU_NOME) + ")",If(cEmpAnt == '01','CABERJ','INTEGRAL'))
		EndIf
		
	EndIf
	
	//Leonardo Portella - 16/07/12 - Fim
	
	RestArea(aAreaBAU)
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldCRBau  บAutor  ณMicrosiga           บ Data ณ  06/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldCRBB0(cSiglCR,cNumCr,cEstCr)
	Local lRet := .T.
	Local aAreaBB0 := BB0->(GetArea())
	
	If !Empty(cSiglCr) .And. !Empty(cNumCr) .And. !Empty(cEstCr)
		
		BB0->(DbSetOrder(4))
		lRet := !(BB0->(MsSeek(xFilial("BB0")+cEstCR+cNumCR+cSiglCR)))
		RestArea(aAreaBB0)
		
	Endif
	
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCadTiRem  บAutor  ณGedilson Rangel     บ Data ณ  18/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAxCadastro para inserir dados na Tabela ZZZ-Cadastro de     บฑฑ
ฑฑบ          ณTipos de Reembolso                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ mp811                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CadTiRem()
	Local cVldExc	:= "U_VldExiZZS()" // Validacao para permitir a Exclusao. Pode-se utilizar ExecBlock.
	Local cVldInc	:= ".T." // Validacao para permitir a Inclusao/Alteracao. Pode-se utilizar ExecBlock.
	
	AxCadastro("ZZZ","Cadastro Tipo Reembolso",cVldExc,cVldInc)
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldExiZZS บAutor  ณ Jean Schulz        บ Data ณ  19/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se existe algum codigo de ZZZ em BKD, antes de     บฑฑ
ฑฑบ          ณremove-lo.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldExiZZS()
	Local _cSQL		:= ""
	Local _lRetorno	:= .T.
	Local _aArea		:= GetArea()
	
	_cSQL := " SELECT COUNT(R_E_C_N_O_) AS TOTAL FROM "+RetSQLName("BKD")
	_cSQL += " WHERE BKD_FILIAL = '"+xFilial("BKD")+"' "
	_cSQL += " AND BKD_ZZZCOD = '"+ZZZ->ZZZ_CODIGO+"' "
	_cSQL += " AND D_E_L_E_T_ = ' '"
	
	PlsQuery(_cSQL,"TRB_ZZZ")
	
	If TRB_ZZZ->TOTAL > 0
		_lRetorno := .F.
		MsgAlert("Jแ existem reembolsos atribuํdos ao registro! Impossํvel excluir.")
	Endif
	
	TRB_ZZZ->(DbCloseArea())
	
	RestArea(_aArea)
	
Return _lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldVlrProtบAutor  ณMicrosiga           บ Data ณ  08/15/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para evitar que valores acima do protocolo sejam     บฑฑ
ฑฑบ          ณdigitados no valor apresentado.                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldVlrProt(nVlrApr)
	Local lRet		:= .T.
	Local nTotPro	:= 0
	Local aAreaZZP	:= ZZP->(GetArea())
	
	Local cCodRDA := Iif(Type("M->BD5_CODRDA")<>"U",M->BD5_CODRDA,M->BE4_CODRDA)
	Local cMesPag := Iif(Type("M->BD5_MESPAG")<>"U",M->BD5_MESPAG,M->BE4_MESPAG)
	Local cAnoPag := Iif(Type("M->BD5_ANOPAG")<>"U",M->BD5_ANOPAG,M->BE4_ANOPAG)
	
	ZZP->(DbSetOrder(1)) //ZZP_FILIAL+ZZP_CODRDA+ZZP_MESPAG+ZZP_ANOPAG
	If ZZP->(MsSeek(xFilial("ZZP")+cCodRDA+cMesPag+cAnoPag))
		While !ZZP->(Eof()) .And. ZZP->(ZZP_CODRDA+ZZP_MESPAG+ZZP_ANOPAG) == cCodRDA+cMesPag+cAnoPag
			nTotPro += ZZP->ZZP_VLRTOT
			ZZP->(DbSkip())
		Enddo
	Endif
	
	//Valor do protocolo menor que valor apresentado, nao libera!
	If nTotPro < nVlrApr
		lRet := .F.
	Endif
	
	RestArea(aAreaZZP)
	
Return lRet


User Function ValidaCodLan
	Local lRet := .T.
	
	IF  Upper(alltrim(cUserName)) $ GetNewPar("MV_YPLSGPS","##")
		IF  (M->BGQ_CODLAN=="050")
			lRet:=.T.
		ELSE
			lRet:=.F.
		endif
	else
		lRet:=.T.
	endif
	
return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAdPrTxAd  บAutor  ณMicrosiga           บ Data ณ  19/09/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para implementar o adicional de percentual de tx adm.บฑฑ
ฑฑบ          ณnas guias que a operadora do RDA for diferente de 0001.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AdPrTxAd(cCampoOri,nVlrApr)
	Local _cAlias	:= BCL->BCL_ALIAS
	Local dDatPro	:= CtoD("")
	Local nVlrTax	:= 0
	Local nCont		:= 0
	Local cCodRDA	:= ""
	Local aAreaBAU	:= BAU->(GetArea())
	Local cAliasTmp	:= Substr(cCampoOri,4,3)
	Local c_CpoTmp	:= ''
	Private _cCamDtPr	:= "M->"+_cAlias+"_DATPRO"
	Private _cCamCRDA	:= "M->"+_cAlias+"_CODRDA"
	
	//Leonardo Portella - 20/03/14 - Inicio - Chamado ID 10716
	
	c_CpoTmp := "M->"+cAliasTmp+"_DATPRO"
	dDatPro	:= If( ( Type(c_CpoTmp) == 'U' ) .or. Empty(&c_CpoTmp), (&_cCamDtPr) , (&c_CpoTmp) )
	//dDatPro	:= Iif(Empty(&("M->"+cAliasTmp+"_DATPRO")),(&_cCamDtPr),&("M->"+cAliasTmp+"_DATPRO"))
	
	//Leonardo Portella - 20/03/14 - Fim
	
	BAU->(DbSetOrder(1))
	If BAU->(MsSeek(xFilial("BAU")+(&_cCamCRDA)))
		
		If !Empty(BAU->BAU_CODOPE) .And. BAU->BAU_CODOPE <> PLSINTPAD()
			BA0->(DbSetOrder(1))
			If BA0->(MsSeek(xFilial("BA0")+BAU->BAU_CODOPE))
				
				BGH->(DbSetOrder(1))
				BGH->(MsSeek(xFilial("BGH")+BA0->BA0_GRUOPE))
				While !BGH->(Eof()) .And. BGH->BGH_GRUOPE == BA0->BA0_GRUOPE
					If Empty(BGH->BGH_DATFIN) .Or. (!Empty(BGH->BGH_DATFIN) .And. dDatPro <= BGH->BGH_DATFIN)
						nVlrTax := BGH->BGH_VLRTAX
						
						BGI->(DbSetOrder(1))
						
						For nCont := 1 to 3 //Busca os 3 niveis...
							Do Case
							Case nCont == 1
								cCodPro := &("M->"+cAliasTmp+"_CODPRO")
							Case nCont == 2
								cCodPro := Substr(&("M->"+cAliasTmp+"_CODPRO"),1,4)+"000"
							Case nCont == 3
								cCodPro := Substr(&("M->"+cAliasTmp+"_CODPRO"),1,2)+"00000"
							EndCase
							If BGI->(MsSeek(xFilial("BGI")+BGH->(BGH_GRUOPE+BGH_CODSEQ)+&("M->"+cAliasTmp+"_CODPAD")+cCodPro))
								nVlrTax := Iif(BGI->BGI_NVVLPP=="1",BGI->BGI_TXADPP,nVlrTax)
								nCont := 3
							Endif
						Next
						
					Endif
					BGH->(DbSkip())
				Enddo
				&cCampoOri := nVlrApr+(nVlrApr*(nVlrTax/100))
				
			Endif
			
		Endif
		
	Endif
	
	If Substr(cCampoOri,4) == "BD6_YVLTAP"
		//M->BD6_VLRAPR := &cCampoOri/(Iif(M->BD6_QTDAPR>0,M->BD6_QTDAPR,Iif(M->BD6_QTDPRO>0,M->BD6_QTDPRO,1)))
		//Bianchini - 29/03/2019 - Mudan็a de fase V12 - Extinsใo do campo BD6_QTDAPR
		M->BD6_VLRAPR := &cCampoOri/(Iif(M->BD6_QTDPRO>0,M->BD6_QTDPRO,1))
		//Alteracao em 15/01/08 - Guardar no campo de valor
		//digitado o conteudo digitado pelo usuario...
		&(Substr(cCampoOri,1,7)+"YVLDG2") := nVlrApr/&("M->"+cAliasTmp+"_QTDPRO")
	Else
		&(Substr(cCampoOri,1,7)+"YVLDG2") := nVlrApr
	Endif
	
	RestArea(aAreaBAU)
	
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRemoveBSQ บAutor  ณJean Schulz         บ Data ณ  27/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTratamento para remover os titulos baixados por cancelamentoบฑฑ
ฑฑบ          ณque tenham adicionais de credito/debito vinculados a eles.  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function RemoveBSQ()
	Local aAreaBSQ	:= BSQ->(GetArea())
	Local aDeletar	:= {}
	Local nContBSQ	:= 0
	
	BSQ->(dbOrderNickName("BSQ_YGRSE1"))
	If BSQ->(MsSeek(xFilial("BSQ")+SE1->(E1_PREFIXO+ trim(E1_NUM)+E1_PARCELA+E1_TIPO)))
		While !BSQ->(Eof()) .And. BSQ->BSQ_YGRSE1 == SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
			If !Empty(BSQ->BSQ_YGRSE1)
				aadd(aDeletar,BSQ->(RecNo()))
				BSQ->(DbSkip())
			Endif
		Enddo
		
		For nContBSQ := 1 to Len(aDeletar)
			BSQ->(DbGoTo(aDeletar[nContBSQ]))
			BSQ->(RecLock("BSQ",.F.))
			BSQ->(DbDelete())
			BSQ->(MsUnlock())
		Next
		// novos campos tratamento altamiro 09/04/2010
		//  BSQ->(BSQ_YGRPREF+BSQ_YGRNUM+BSQ_YGRPARC+BSQ_YGRTIP)
		//Endif
		
	else
		BSQ->(dbOrderNickName("BSQ_YGSE1N"))
		If BSQ->(MsSeek(xFilial("BSQ")+SE1->(E1_PREFIXO+ E1_NUM+E1_PARCELA+E1_TIPO)))
			
			//	While !BSQ->(Eof()) .And. BSQ->BSQ_YGRSE1 == SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
			//		If !Empty(BSQ->BSQ_YGRSE1)
			While !BSQ->(Eof()) .And. BSQ->(BSQ_YGRPREF+BSQ_YGRNUM+BSQ_YGRPARC+BSQ_YGRTIP) == SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
				If !Empty(BSQ->(BSQ_YGRPREF+BSQ_YGRNUM+BSQ_YGRPARC+BSQ_YGRTIP))
					aadd(aDeletar,BSQ->(RecNo()))
					BSQ->(DbSkip())
				Endif
			Enddo
			
			For nContBSQ := 1 to Len(aDeletar)
				BSQ->(DbGoTo(aDeletar[nContBSQ]))
				BSQ->(RecLock("BSQ",.F.))
				BSQ->(DbDelete())
				BSQ->(MsUnlock())
			Next
			//  ate aki altamiro 09/04/2010
		Endif
	Endif
	
	RestArea(aAreaBSQ)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณutor  ณJean Schulz         บ Data ณ  12/11/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao construida para validar o desbloqueio dos usuarios,  บฑฑ
ฑฑบ          ณconforme regra da Caberj.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldCadast(cAliasBA3,lValForCb)
	Local nForCnt	:= 0
	Local cSQL		:= ""
	
	**'Ini Marcela Coimbra - 17/02/2014 VALIDAวรOD E DADOS BANCมRIOS'**
	// Local nTotVld	:= 13
	Local nTotVld	:= 13
	**'Fim Marcela Coimbra - 17/02/2014 VALIDAวรOD E DADOS BANCมRIOS'**
	
	Local aErroDes	:= {}
	Local cNameBA1	:= RetSQLName("BA1")
	Local cNameBA3	:= RetSQLName("BA3")
	Local cNameBDK	:= RetSQLName("BDK")
	Local cNameBBU	:= RetSQLName("BBU")
	Local cNameBTN	:= RetSQLName("BTN")
	
	Private _cAliasBA3 := cAliasBA3
	Private _cCmpTpPag	:= ""
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณMotta teste                 ณ
	//ณvalida็ใo conforme parametroณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If cAliasBA3 = "M"
		_cCmpTpPag := _cAliasBA3+"->BA3_TIPPAG"
	Else
		_cCmpTpPag	:= Iif(Empty(&(_cAliasBA3+"->BA3_YTPPAG")),_cAliasBA3+"->BA3_TIPPAG",_cAliasBA3+"->BA3_YTPPAG")
	end if
	
	//If Alltrim(&(_cAliasBA3+"->BA3_CODEMP")) <> "0004"
	If !Alltrim(&(_cAliasBA3+"->BA3_CODEMP")) $ "0004|0009"
		
		For nForCnt := 1 to nTotVld
			
			IncProc("Valida็ใo: "+StrZero(nForCnt,3)+"/"+StrZero(nTotVld,3))
			
			If nForCnt == 1
				
				//Validacao de faixa etaria preenchida...
				If Alltrim(&(_cAliasBA3+"->BA3_MATRIC")) <> "AUTO" .And. lValForCb
					
					cSQL := " SELECT COUNT(BA1.R_E_C_N_O_) AS TOTERR "
					cSQL += " FROM "+cNameBA1+" BA1, "+cNameBA3+" BA3 "
					cSQL += " WHERE BA1_FILIAL = '"+xFilial("BA1")+"' "
					
					cSQL += " AND BA1_CODINT = '"+&(_cAliasBA3+"->BA3_CODINT")+"' "
					cSQL += " AND BA1_CODEMP = '"+&(_cAliasBA3+"->BA3_CODEMP")+"' "
					cSQL += " AND BA1_MATRIC = '"+&(_cAliasBA3+"->BA3_MATRIC")+"' "
					
					cSQL += " AND BA3_FILIAL = '"+xFilial("BA3")+"' "
					cSQL += " AND BA3_CODINT = BA1_CODINT "  
					cSQL += " AND BA3_CODEMP = BA1_CODEMP "
					cSQL += " AND BA3_MATRIC = BA1_MATRIC "
					cSQL += " AND ( "
					cSQL += "   SELECT Count(R_E_C_N_O_) "
					cSQL += "   FROM "+cNameBDK+" BDK "
					cSQL += "   WHERE BDK_FILIAL = '  ' "
					cSQL += "   AND BDK_CODINT = BA1_CODINT "
					cSQL += "   AND BDK_CODEMP = BA1_CODEMP "
					cSQL += "   AND BDK_MATRIC = BA1_MATRIC "
					cSQL += "   AND BDK_TIPREG = BA1_TIPREG "
					cSQL += "   AND BDK_VALOR > 0 "
					cSQL += "   AND BDK.D_E_L_E_T_ = ' ' "
					cSQL += " ) = 0 "
					cSQL += " AND ( "
					cSQL += "   SELECT Count(R_E_C_N_O_) "
					cSQL += "   FROM "+cNameBBU+" BBU"
					cSQL += "   WHERE BBU_FILIAL = '  ' "
					cSQL += "   AND BBU_CODOPE = BA1_CODINT "
					cSQL += "   AND BBU_CODEMP = BA1_CODEMP "
					cSQL += "   AND BBU_MATRIC = BA1_MATRIC "
					cSQL += "   AND BBU_VALFAI > 0 "
					cSQL += "   AND BBU.D_E_L_E_T_ = ' ' "
					cSQL += " ) = 0 "
					cSQL += " AND BA1.D_E_L_E_T_ = ' ' "
					cSQL += " AND BA3.D_E_L_E_T_ = ' ' "
					
					PlsQuery(cSQL,"TRBTMP")
					
					If TRBTMP->TOTERR > 0
						aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui fx. etแria cadastrada!","Necessแria manuten็ใo do cadastro"})
					Endif
					
					TRBTMP->(DbCloseArea())
					
					//Else
					/*
					cSQL := " SELECT COUNT(BTN.R_E_C_N_O_) AS TOTERR "
					cSQL += " FROM "+cNameBTN+" BTN "
					cSQL += " WHERE BTN_FILIAL = '"+xFilial("BTN")+"' "
					cSQL += " AND BTN_CODIGO = '"+&(_cAliasBA3+"->BA3_CODINT")+&(_cAliasBA3+"->BA3_CODEMP")+"' "
					cSQL += " AND BTN_NUMCON = '"+&(_cAliasBA3+"->BA3_CONEMP")+"' "
					cSQL += " AND BTN_VERCON = '"+&(_cAliasBA3+"->BA3_VERCON")+"' "
					cSQL += " AND BTN_SUBCON = '"+&(_cAliasBA3+"->BA3_SUBCON")+"' "
					cSQL += " AND BTN_VERSUB = '"+&(_cAliasBA3+"->BA3_VERSUB")+"' "
					cSQL += " AND BTN_CODPRO = '"+&(_cAliasBA3+"->BA3_CODPLA")+"' "
					cSQL += " AND BTN_VERPRO = '"+&(_cAliasBA3+"->BA3_VERSAO")+"' "
					cSQL += " AND BTN_CODFOR = '"+&(_cAliasBA3+"->BA3_FORPAG")+"' "
					cSQL += " AND BTN.D_E_L_E_T_ = ' ' "
					*/
				Endif
				
				
			ElseIf nForCnt == 2 //Validacao de forma de cobranca preenchida no BA3..
				If Empty(&(_cAliasBA3+"->BA3_FORPAG"))
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui forma de cobran็a cadastrada!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nForCnt == 3 //Validacao de grupo de cobranca preenchido..
				If Empty(&(_cAliasBA3+"->BA3_GRPCOB")) .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui grupo de cobran็a cadastrado!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nforCnt == 4 //Validacao de forma de pagamento preenchido...
				If Empty(&(_cCmpTpPag)) .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui tipo de pagamento cadastrado!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nforCnt == 5 //Validacao de coerencia Rio Previdencia...
				If &(_cAliasBA3+"->BA3_VALSAL") < GetNewPar("MV_YVLSLP",700) .And. &(_cCmpTpPag) = '01' .And. &(_cAliasBA3+"->BA3_GRPCOB") $ GetNewPar("MV_YGRIOP","'0001','1001','1002','1003'")
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" possui dados incoerentes (salario x tipo pagto x grp. cobran็a)!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nforCnt == 6 //Validacao de grp cobranca x tipo de pagamento...
				//Rio Previdencia
				// Marcela Coimbra If &(_cCmpTpPag) $ "01,08" .And. !(&(_cAliasBA3+"->BA3_GRPCOB") $ GetNewPar("MV_YGRIOP","'0001','1001','1002','1003'"))
				If &(_cAliasBA3+"->BA3_TIPPAG") $ "01,08" .And. !(&(_cAliasBA3+"->BA3_GRPCOB") $ GetNewPar("MV_YGRIOP","'0001','1001','1002','1003'"))
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" possui dados incoerentes para Rio Previdencia (Grp. Cobran็a x Tipo Pagto)!","Necessแria manuten็ใo do cadastro"})
					
					//---------------------------------------------------------------------------------------------
					//Angelo Henrique - Data: 08/07/2020
					//---------------------------------------------------------------------------------------------
					//Removido pois agora qualquer beneficiแrio pode solicitar debito automแtico pelo site
					//ou pode escolher boleto digital, mudando assim a forma de se olhar para o CNAB
					//---------------------------------------------------------------------------------------------
					//CNAB
				//ElseIf &(_cCmpTpPag) $ GetNewPar("MV_YRCCNAB","04") .And. !(&(_cAliasBA3+"->BA3_GRPCOB") $ '0002,0003,0005,0006,5007,5000,5001')
					//aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" possui dados incoerentes para CNAB (Grp. Cobran็a x Tipo Pagto)!","Necessแria manuten็ใo do cadastro"})
					
					//---------------------------------------------------------------------------------------------
					//Angelo Henrique - Data: 08/07/2020
					//---------------------------------------------------------------------------------------------
					//Removido pois agora qualquer beneficiแrio pode solicitar debito automแtico pelo site
					//---------------------------------------------------------------------------------------------
					//Debito automatico 
				//ElseIf &(_cCmpTpPag) $ '06' .And. !(&(_cAliasBA3+"->BA3_GRPCOB") $ '0002,0003,0005,0006,0009,5007')
					//aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" possui dados incoerentes para SISDEB (Grp. Cobran็a x Tipo Pagto)!","Necessแria manuten็ใo do cadastro"})
					
				Endif
				
			ElseIf nforCnt == 7 //Validacao de Rio Previdencia sem matricula da funcional...
				If Empty(&(_cAliasBA3+"->BA3_MATEMP")) .And. &(_cAliasBA3+"->BA3_GRPCOB") $ GetNewPar("MV_YGRIOP","'0001','1001','1002','1003'")
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui funcional, por้m ้ Rio Previd๊ncia!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nforCnt == 8 //Validacao de SISDEB sem dados bancarios corretos...
				If &(_cAliasBA3+"->BA3_GRPCOB") $ '0002,0003,0005,0006,0009' .And. &(_cCmpTpPag) $ '06' .And. (Empty(&(_cAliasBA3+"->BA3_BCOCLI")) .or. Empty(&(_cAliasBA3+"->BA3_AGECLI")) .or. Empty(&(_cAliasBA3+"->BA3_CTACLI")))
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" parametrizado como SISDEB por้m possui dados bancแrios invแlidos!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nforCnt == 9 //Validacao de funcionarios CABERJ sem matricula de integracao com a folha...
				If &(_cAliasBA3+"->BA3_GRPCOB") == '0007' .And. Empty(&(_cAliasBA3+"->BA3_AGMTFU"))
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" possui grp. Cobran็a FOLHA e nใo tem matrํcula funcional!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nForCnt == 10 //Validacao de natureza em branco...
				If Empty(&(_cAliasBA3+"->BA3_NATURE")) .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui natureza cadastrada!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nForCnt == 11 //Valida cliente em branco...
				If (Empty(&(_cAliasBA3+"->BA3_CODCLI")) .Or. Empty(&(_cAliasBA3+"->BA3_LOJA")) ) .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui cliente e/ou loja do cliente!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nForCnt == 12 //Tippag x Grupo/Empresa (01 - 0001, 08 - 0002/0005)...
				If &(_cCmpTpPag) $ '01' .And. !(&(_cAliasBA3+"->BA3_CODEMP") $ "0001") .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" com tipo de pagamento incoerente com a empresa!","Necessแria manuten็ใo do cadastro"})
				ElseIf &(_cCmpTpPag) $ '08' .And. !(&(_cAliasBA3+"->BA3_CODEMP") $ "0002,0005") .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" com tipo de pagamento incoerente com a empresa!","Necessแria manuten็ใo do cadastro"})
				Endif
				
			ElseIf nForCnt == 13 //Se tippag == 175 (boleto) criticar... - Rever possibilidade...
				/*
				If &(_cCmpTpPag) == "05" .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
					aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" estแ configurado como emissใo 175!","Necessแria manuten็ใo do cadastro"})
				Endif
				*/
				**'Marcela Coimbra - 17/02/2014 VALIDAวรOD E DADOS BANCมRIOS'**
				/*
			ElseIf nForCnt == 14
				
				If BA3->BA3_TIPPAG == "06"  .and. BA3->BA3_PORTAD <>  BA3->BA3_BCOCLI
					
					aadd(aErroDes,{"Cobran็a de d้bito em conta cadastrada para a Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" banco do cliente diferente de banco da operadora!","Necessแria manuten็ใo do cadastro"})
					
				EndIf
				*/
				
			Endif
			
		Next
		
	Endif
	
Return aErroDes


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  12/17/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MudaVlrRee(aRet)
	Local nCont := 1
	
	For nCont := 1 to Len(aRet)
		
		//Se nivel esta valido..
		If aRet[nCont,3]
			
			//Caso seja consulta, modificar US...
			If Alltrim(aRet[nCont,8]) $ "00010014"
				If aRet[nCont,1] == "HM"
					
					If Substr(cNumEmp,1,2) == "01"
						aRet[nCont,5,1,3] := 0.38 //Conforme Danielle em 18/12/07
					Else
						aRet[nCont,5,1,3] := 0.34 //Conforme Danielle em 18/12/07
					Endif
				Endif
				
				aRet[nCont,5,1,4] := aRet[nCont,5,1,3]*aRet[nCont,9]
				
				
				//Caso seja tipo de pgto = "PA" - anestesista, US especial...
			ElseIf aRet[nCont,1] == "PA"
				
				If Substr(cNumEmp,1,2) == "01"
					aRet[nCont,5,1,3] := 0.38 //Conforme Danielle em 18/12/07
				Else
					aRet[nCont,5,1,3] := 0.38 //Conforme Danielle em 18/12/07
				Endif
				
				aRet[nCont,5,1,4] := aRet[nCont,5,1,3]*aRet[nCont,5,1,1]
				
				//Modificado para contemplar % via de acesso em 3/1/08 - Jean
				/*
				If M->BKE_YPODVI == "1" .And. (M->BKE_YPERVI > 0 .And. M->BKE_YPERVI < 100)
					aRet[nCont,5,1,4] := (aRet[nCont,5,1,4]*M->BKE_YPERVI)/100
				Endif
				*/
				
			Endif
			
		Endif
		
	Next
	
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMudCodRec บAutor  ณJean Schulz         บ Data ณ  05/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณModifica o codigo digitado na conta medica, conforme cadas- บฑฑ
ฑฑบ          ณtro realizado na tabela de intercambio.                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MdCdRc(cCodRDA,cCodRec,lAtuMem,aRet)
	Local lTrocou := .F.
	Default aRet := {{.F.},{},{}}
	
	SZ7->(DbSetOrder(1))
	If SZ7->(MsSeek(xFilial("SZ7")+cCodRDA+cCodRec))
		cCodigo := SZ7->(Z7_TABPROC+Z7_PROCLOC)
		lTrocou := .T.
		
		If lAtuMem
			M->BD6_CODPAD := SZ7->Z7_TABPROC
			M->BD6_CODPRO := SZ7->Z7_PROCLOC
		Endif
		
		aRet := {{.T.},{SZ7->Z7_TABPROC},{SZ7->Z7_PROCLOC}}
		
	Endif
	

Return .T.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBrwNomUsr บAutor  ณMicrosiga           บ Data ณ  01/23/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BrwNomUsr(cChaveBA1)
	Local cRetorno := ""
	
	cRetorno := Posicione("BA1",2,xFilial("BA1")+cChaveBA1,"BA1_NOMUSR")
	
Return cRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGERABOX	บAutor  ณJean Schulz         บ Data ณ  04/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera box e atualiza coordenadas na impressao.               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GERABOX(nLin,nProxLin,nCol,nTam,cLabel,lPulaLim,cTamFonte,lEspacoBox)
	
	nLin += nProxLin*100
	
	oPrn:Box(nLin,nCol,nLin+100,Iif(lPulaLim,2200,nCol+(nTam*35)))
	oPrn:Say(nLin+15,nCol+15, cLabel ,Iif(cTamFonte=="G",oFont5,oFont4),100)
	
	If lPulaLim
		nCol := 100
	Else
		nCol += (nTam*35)+Iif(lEspacoBox,10,0)
	Endif
	
Return Nil



///////////////////////////////

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ LISTGUIUSR ณ Autor ณ Jean Schulz        ณ Data ณ 14.04.08 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Pesquisa generica de guias por usuario...                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณProgramador ณ Data   ณ BOPS ณ  Motivo da Alterao                    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function LISTGUIUSR()
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Define variaveis...                                                      ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Local cChave     := Space(100)
	Local oDlgPesGui
	Local oTipoPes
	Local oSayGui
	Local nOpca      := 0
	Local aBrowGui   := {}
	Local aVetPad    := { { "ENABLE", "","","","","","",CtoD(""), 0 } }
	Local oBrowGui
	Local bRefresh   := { || If(!Empty(cChave),PLPQGUIA(AllTrim(cChave),Subs(cTipoPes,1,1),lChkChk,aBrowGui,aVetPad,oBrowGui),.T.), If( Empty(aBrowGui[1,2]) .And. !Empty(cChave),.F.,.T. )  }
	Local cValid     := "{|| Eval(bRefresh) }"
	Local bOK        := { || If(!Empty(cChave),(nLin := oBrowGui:nAt, nOpca := 1,oDlgPesGui:End()),Help("",1,"PLSMCON")) }
	Local bCanc      := { || nOpca := 3,oDlgPesGui:End() }
	Local oGetChave
	Local aTipoPes   := {}
	Local nOrdem     := 1
	Local cTipoPes   := ""
	Local oChkChk
	Local lChkChk    := .F.
	Local nLin       := 1
	Local aButtons 	 := {}
	
	aBrowGui := aClone(aVetPad)
	If ExistBlock("PLSBUTDV")
		aButtons := ExecBlock("PLSBUTDV",.F.,.F.)
	EndIf
	
	aTipoPes := { STR0006, STR0007, STR0008, STR0009 } //"1-Nome do Usuแrio"###"2-Matrํcula do Usuแrio"###"3-Matrํcula Antiga"###"4-Nr. da Autoriza็ใo de Interna็ใo"
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Define dialogo...                                                        ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Define MsDialog oDlgPesGui Title STR0010 From 008.2,000 To 025,ndColFin Of GetWndDefault() //"Pesquisa de Guias"
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta objeto que recebera o a chave de pesquisa  ...                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oGetChave := TGet():New(020,103,{ | U | If( PCOUNT() == 0, cChave, cChave := U ) },oDlgPesGui,210,008 ,"@!S30",&cValid,Nil,Nil,Nil,Nil,Nil,.T.,Nil,.F.,Nil,.F.,Nil,Nil,.F.,Nil,Nil,cChave)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta Browse...                                                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oBrowGui := TcBrowse():New( 043, 008, 378, 075,,,, oDlgPesGui,,,,,,,,,,,, .F.,, .T.,, .F., )
	
	oBrowGui:AddColumn(TcColumn():New("",Nil,;
		Nil,Nil,Nil,Nil,055,.T.,.F.,Nil,Nil,Nil,.T.,Nil))
	oBrowGui:ACOLUMNS[1]:BDATA     := { || aBrowGui[oBrowGui:nAt,1] }
	oBrowGui:AddColumn(TcColumn():New(STR0011,Nil,; //"Matrํcula"
	Nil,Nil,Nil,Nil,055,.F.,.F.,Nil,Nil,Nil,.F.,Nil))
	oBrowGui:ACOLUMNS[2]:BDATA     := { || aBrowGui[oBrowGui:nAt,2] }
	oBrowGui:AddColumn(TcColumn():New(STR0012,Nil,; //"Matricula Antiga"
	Nil,Nil,Nil,Nil,055,.F.,.F.,Nil,Nil,Nil,.F.,Nil))
	oBrowGui:ACOLUMNS[3]:BDATA     := { || aBrowGui[oBrowGui:nAt,3] }
	oBrowGui:AddColumn(TcColumn():New(STR0013,Nil,; //"Nome do Usuแrio"
	Nil,Nil,Nil,Nil,090,.F.,.F.,Nil,Nil,Nil,.F.,Nil))
	oBrowGui:ACOLUMNS[4]:BDATA     := { || aBrowGui[oBrowGui:nAt,4] }
	oBrowGui:AddColumn(TcColumn():New(STR0014,Nil,; //"Nr Autoriza็ใo"
	Nil,Nil,Nil,Nil,070,.F.,.F.,Nil,Nil,Nil,.F.,Nil))
	oBrowGui:ACOLUMNS[5]:BDATA     := { || aBrowGui[oBrowGui:nAt,5] }
	oBrowGui:AddColumn(TcColumn():New(STR0015,Nil,; //"Procedimento"
	Nil,Nil,Nil,Nil,040,.F.,.F.,Nil,Nil,Nil,.F.,Nil))
	oBrowGui:ACOLUMNS[6]:BDATA     := { || aBrowGui[oBrowGui:nAt,6] }
	oBrowGui:AddColumn(TcColumn():New(STR0016,Nil,; //"Descri็ใo"
	Nil,Nil,Nil,Nil,120,.F.,.F.,Nil,Nil,Nil,.F.,Nil))
	oBrowGui:ACOLUMNS[7]:BDATA     := { || aBrowGui[oBrowGui:nAt,7] }
	oBrowGui:AddColumn(TcColumn():New(STR0017,Nil,; //"Data Proced"
	Nil,Nil,Nil,Nil,040,.F.,.F.,Nil,Nil,Nil,.F.,Nil))
	oBrowGui:ACOLUMNS[8]:BDATA     := { || aBrowGui[oBrowGui:nAt,8] }
	
	@ 020,008 COMBOBOX oTipoPes  Var cTipoPes ITEMS aTipoPes SIZE 090,010 OF oDlgPesGui PIXEL COLOR CLR_HBLUE
	@ 020,319 CHECKBOX oChkChk   Var lChkChk PROMPT STR0018 PIXEL SIZE 080, 010 OF oDlgPesGui //"Pesquisar Palavra Chave"
	
	oBrowGui:SetArray(aBrowGui)
	oBrowGui:bLDblClick := bOK
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Ativa o Dialogo...                                                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Activate MsDialog oDlgPesGui On Init Eval({ || EnChoiceBar(oDlgPesGui,bOK,bCanc,.F.,aButtons) })
	
	If nOpca == K_OK
		If !Empty(aBrowGui[nLin,2])
			BD6->(dbGoTo(aBrowGui[nLin,9]))
		EndIf
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Retorno da Funcao...                                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Return(nOpca==K_OK)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ PLPQGUIA   ณ Autor ณ Sandro Hoffman Lopes ณ Data ณ 12.12.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Pesquisa as guias na base de dados                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณProgramador ณ Data   ณ BOPS ณ  Motivo da Alterao                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function PLPQGUIA(cChave,cTipoPes,lChkChk,aBrowGui,aVetPad,oBrowGui)
	
	Local aArea     := GetArea()
	Local cSQL      := ""
	Local cRetBA1
	Local cRetBD6
	Local cRetBE4
	Local cStrFil
	Local cAltCus
	
	If '"' $ cChave .Or. ;
			"'" $ cChave
		Aviso( STR0019, STR0020, { "Ok" }, 2 )
		Return(.F.)
	EndIf
	
	cRetBD6 := RetSQLName("BD6")
	cRetBE4 := RetSQLName("BE4")
	cRetBA1 := RetSQLName("BA1")
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Limpa resultado...                                                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aBrowGui := {}
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Efetua busca...                                                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	cSQL := "SELECT BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, "
	cSQL += "       BD6_MATANT, "
	cSQL += "       BD6_NOMUSR, "
	cSQL += "       BD6_CODOPE, BD6_ANOINT, BD6_MESINT, BD6_NUMINT, "
	cSQL += "       BD6_CODPAD, BD6_CODPRO, BD6_DESPRO, BD6_DATPRO, BD6.R_E_C_N_O_ AS RECBD6 "
	cSQL += "  FROM " + cRetBD6 + " BD6 "
	If cTipoPes == "1" // Nome do Usuario
		cSQL += ", " + cRetBE4 + " BE4 "
		cSQL += " WHERE "
		cSQL += "BE4_FILIAL = '"+xFilial("BE4")+"' AND "
		If lChkChk
			cSQL += "BE4_NOMUSR LIKE '%" + AllTrim(cChave) + "%' AND "
		Else
			cSQL += "BE4_NOMUSR LIKE '" + AllTrim(cChave) + "%' AND "
		EndIf
		cSQL += "BE4.D_E_L_E_T_ = ' ' AND "
		cSQL += "BD6_FILIAL = BE4_FILIAL AND "
		cSQL += "BD6_CODOPE = BE4_CODOPE AND "
		cSQL += "BD6_CODLDP = BE4_CODLDP AND "
		cSQL += "BD6_CODPEG = BE4_CODPEG AND "
		cSQL += "BD6_NUMERO = BE4_NUMERO AND "
		cSQL += "BD6_ORIMOV = BE4_ORIMOV AND "
		cSQL += "BD6_SEQPF  = '  '       AND "
		cSQL += "BD6_FASE   IN ('1','2') AND "
		cSQL += "BD6_TIPINT <> '  '      AND "
		cSQL += "BD6.D_E_L_E_T_ = ' '"
		If FindFunction("PLSRESTOP")
			cStrFil := PLSRESTOP("U")   // retorna string com filtro para restricao do operador
			If !Empty(cStrFil)
				cSQL += " AND " + cStrFil
			EndIf
		EndIf
		cSQL += " ORDER BY BD6_FILIAL,BD6_NOMUSR "
		
	ElseIf cTipoPes == "2" // Matricula do Usuario
		cSQL += " WHERE "
		cSQL += "BD6_FILIAL = '"+xFilial("BD6")+"' AND "
		If lChkChk
			cSQL += "BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG LIKE '%" + AllTrim(cChave) + "%' AND "
		Else
			cSQL += "BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG LIKE '" + AllTrim(cChave) + "%' AND "
		EndIf
		cSQL += "BD6_SEQPF  = '  '       AND "
		cSQL += "BD6_FASE   IN ('1','2') AND "
		cSQL += "BD6_TIPINT <> '  '      AND "
		cSQL += "BD6.D_E_L_E_T_ = ' '"
		If FindFunction("PLSRESTOP")
			cStrFil := PLSRESTOP("U")   // retorna string com filtro para restricao do operador
			If !Empty(cStrFil)
				cSQL += " AND " + cStrFil
			EndIf
		EndIf
		cSQL += " ORDER BY BD6_FILIAL,BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG "
	ElseIf cTipoPes == "3" // Matricula Antiga
		cSQL += ", " + cRetBA1 + " BA1 "
		cSQL += " WHERE "
		cSQL += "BA1_FILIAL = '"+xFilial("BA1")+"' AND "
		If lChkChk
			cSQL += "BA1_MATANT LIKE '%" + AllTrim(cChave) + "%' AND "
		Else
			cSQL += "BA1_MATANT LIKE '" + AllTrim(cChave) + "%' AND "
		EndIf
		cSQL += "BA1.D_E_L_E_T_ = ' ' AND "
		cSQL += "BD6_FILIAL = BA1_FILIAL AND "
		cSQL += "BD6_OPEUSR = BA1_CODINT AND "
		cSQL += "BD6_CODEMP = BA1_CODEMP AND "
		cSQL += "BD6_MATRIC = BA1_MATRIC AND "
		cSQL += "BD6_TIPREG = BA1_TIPREG AND "
		cSQL += "BD6_DIGITO = BA1_DIGITO AND "
		cSQL += "BD6_SEQPF  = '  '       AND "
		cSQL += "BD6_FASE   IN ('1','2') AND "
		cSQL += "BD6_TIPINT <> '  '      AND "
		cSQL += "BD6.D_E_L_E_T_ = ' '"
		If FindFunction("PLSRESTOP")
			cStrFil := PLSRESTOP("U")   // retorna string com filtro para restricao do operador
			If !Empty(cStrFil)
				cSQL += " AND " + cStrFil
			EndIf
		EndIf
		cSQL += " ORDER BY BD6_FILIAL,BD6_OPEUSR,BD6_CODEMP,BD6_MATRIC,BD6_TIPREG,BD6_DIGITO"
		
	ElseIf cTipoPes == "4" // Numero da Autorizacao de Internacao
		cSQL += ", " + cRetBE4 + " BE4 "
		cSQL += " WHERE "
		cSQL += "BE4_FILIAL = '"+xFilial("BE4")+"' AND "
		If lChkChk
			cSQL += "BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT LIKE '%" + AllTrim(cChave) + "%' AND "
		Else
			cSQL += "BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT LIKE '" + AllTrim(cChave) + "%' AND "
		EndIf
		cSQL += "BE4.D_E_L_E_T_ = ' ' AND "
		cSQL += "BD6_FILIAL = BE4_FILIAL AND "
		cSQL += "BD6_CODOPE = BE4_CODOPE AND "
		cSQL += "BD6_CODLDP = BE4_CODLDP AND "
		cSQL += "BD6_CODPEG = BE4_CODPEG AND "
		cSQL += "BD6_NUMERO = BE4_NUMERO AND "
		cSQL += "BD6_ORIMOV = BE4_ORIMOV AND "
		cSQL += "BD6_SEQPF  = '  '       AND "
		cSQL += "BD6_FASE   IN ('1','2') AND "
		cSQL += "BD6_TIPINT <> '  '      AND "
		cSQL += "BD6.D_E_L_E_T_ = ' '"
		If FindFunction("PLSRESTOP")
			cStrFil := PLSRESTOP("U")   // retorna string com filtro para restricao do operador
			If !Empty(cStrFil)
				cSQL += " AND " + cStrFil
			EndIf
		EndIf
		cSQL += " ORDER BY BD6_FILIAL,BD6_NOMUSR "
	EndIf
	
	PLSQuery(cSQL,"TrbPes")
	
	TrbPes->(DbGoTop())
	Do While ! TrbPes->(Eof())
		BR8->(dbSetOrder(1))
		If BR8->(MsSeek(xFilial("BR8")+TrbPes->(BD6_CODPAD+BD6_CODPRO)))
			cAltCus := BR8->BR8_ALTCUS
		Else
			cAltCus := ""
		EndIf
		If cAltCus == "1"
			TrbPes->(aAdd(aBrowGui, {  "ENABLE",;
				BD6_OPEUSR+"."+BD6_CODEMP+"."+BD6_MATRIC+"."+BD6_TIPREG+"-"+BD6_DIGITO,;
				BD6_MATANT,;
				BD6_NOMUSR,;
				BD6_CODOPE+"."+BD6_ANOINT+"."+BD6_MESINT+"."+BD6_NUMINT,;
				BD6_CODPRO,;
				BD6_DESPRO,;
				BD6_DATPRO,;
				RECBD6 }))
		EndIf
		TrbPes->(DbSkip())
	EndDo
	
	TrbPes->(DbCloseArea())
	RestArea(aArea)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Testa resultado da pesquisa...                                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If Len(aBrowGui) == 0
		aBrowGui := aClone(aVetPad)
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Atualiza browse...                                                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oBrowGui:nAt := 1 // Configuro nAt para um 1 pois estava ocorrendo erro de "array out of bound" qdo se fazia
	// uma pesquisa mais abrangante e depois uma nova pesquisa menos abrangente
	// Exemplo:
	// 1a. Pesquisa: "A" - Tecle <END> para ir ao final e retorne ate a primeira linha do browse
	// (via seta para cima ou clique na primeira linha)
	// 2a. Pesquisa: "AV" - Ocorria o erro
	oBrowGui:SetArray(aBrowGui)
	oBrowGui:Refresh()
	oBrowGui:SetFocus()
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Fim da Rotina...                                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBusDtBxReeบAutor  ณMicrosiga           บ Data ณ  24/04/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca data de baixa do titulo de reembolso enviado para     บฑฑ
ฑฑบ          ณbanco atraves da troca NCC-SE1 para SE2.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function DtBxRee(cPrefix, cNum, cParcela, cTipo)
	Local dDatBxRee := StoD("")
	Local cSQL := ""
	
	cSQL := " SELECT MAX(E2_BAIXA) DTBAIXA"
	cSQL += " FROM "+RetSQLName("SE2")+" SE2 "
	cSQL += " WHERE E2_FILIAL = '"+xFilial("SE2")+"' "
	cSQL += " AND E2_TITORIG = '"+cPrefix+cNum+cParcela+cTipo+"' "
	cSQL += " AND SE2.D_E_L_E_T_ = ' ' "
	
	PlsQuery(cSQL,"TRBRBS")
	
	If !Empty(TRBRBS->DTBAIXA)
		dDatBxRee := StoD(TRBRBS->DTBAIXA)
	Endif
	
	TRBRBS->(DbCloseArea())
	
Return dDatBxRee


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRGVLFAM   บMotta  ณCaberj              บ Data ณ  05/16/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Regra para uso no gatilho BA3_TIPPAG para alimentar        บฑฑ
ฑฑบ          ณ o campo BA3_VLFAR (Limite Farmacia)                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User function RGVLFAM()
	
	Local nVlFar
	
	If     M->BA3_CODEMP == "0001" // Mater
		If M->BA3_TIPPAG == "01" // ContraCheque
			nVlFar = GetNewPar("MV_YLIFAR1",300)
		Else
			nVlFar = GetNewPar("MV_YLIFAR2",200)
		Endif
	Elseif (M->BA3_CODEMP == "0002" .OR. M->BA3_CODEMP == "0005") // Afin
		nVlFar = GetNewPar("MV_YLIFAR2",200)
	Elseif M->BA3_CODEMP == "0003" // Colaboradores
		nVlFar = ((U_VLSALCOB() - 50) * .2)
		If nVlFar > GetNewPar("MV_YLIFAR1",300)
			nVlFar = GetNewPar("MV_YLIFAR1",300)
		Endif
	Else
		nVlFar = 0
	Endif
	
Return nVlfar


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณListBoxMarบAutor  ณ Jean Schulz        บ Data ณ  26/02/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria listbox para marcar itens de composicao de pagamento   บฑฑ
ฑฑบ          ณda rotina de reembolso.                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function ListBoxMar()
	Local cVar     := Nil
	Local oDlg     := Nil
	Local cTitulo  := "Sele็ใo de comp. pagamento"
	Local lMark    := .F.
	Local oOk      := LoadBitmap( GetResources(), "LBOK" )		//carrega bitmap quadrado com X
	Local oNo      := LoadBitmap( GetResources(), "LBNO" )		//carrega bitmap soh o quadrado
	
	LOCAL aDadUsr	:= PLSGETUSR()
	Local aCodTab	:= {}
	Local aCompo	:= {}
	Local nCont		:= 0
	Local cCodLoc	:= ""
	Local cCodEsp	:= ""
	Local cSubEsp	:= ""
	Local dDatPro	:= M->B45_DATPRO
	Local cHorPro	:= "0800"
	Local cRDARee	:= GetNewPar("MV_YRDAREE","999998")
	Local aAreaBB8	:= BB8->(GetArea())
	Local aAreaBAX	:= BAX->(GetArea())
	Local aAreaBAU	:= BAU->(GetArea())
	Local nReg		:= 1
	Local _cStrYCPPAG := ""
	Local nCont2	:= 0
	Local nI
	//Local aValAcu	:= {}
	
	//pode ser usado o LBCHECK - Coloca o visto
	Local oChk     := Nil
	
	Private lChk     := .F.
	Private oLbx := Nil
	Private aVetor := {}
	Private oLbx     := Nil
	
	BB8->(DbSetOrder(1))
	BAX->(DbSetOrder(1))
	BAU->(DbSetOrder(1))
	
	BAU->(MsSeek(xFilial("BAU")+cRDARee))
	BB8->(MsSeek(xFilial("BB8")+cRDARee+PLSINTPAD()))
	BAX->(MsSeek(xFilial("BAX")+cRDARee+PLSINTPAD()+BB8->BB8_CODLOC))
	
	cCodLoc := BB8->BB8_LOCAL
	cCodEsp := BAX->BAX_CODESP
	cSubEsp	:= BAX->BAX_CODSUB
	
	aCodTab := 	PLSRETTAB(M->B45_CODPAD,M->B45_CODPRO,dDatPro,;
		PLSINTPAD(),cRDARee,cCodEsp,Nil,BB8->(BB8_CODLOC+BB8_LOCAL),; //Nil1: Especialidade, Nil2: Subespecialidade, Nil3:BD6->(BD6_CODLOC+BD6_LOCAL)
	dDatPro,"1",PLSINTPAD(),aDadUsr[11],"1","1")
	
	//Leonardo Portella - 17/07/12 - Inicio
	If empty(aCodTab)
		MsgStop('PLSRETTAB: Tabela de pagamento nao encontrada com os dados informados!',AllTrim(SM0->M0_NOMECOM))
		Return .F.
		//Leonardo Portella - 17/07/12 - Fim
		
	ElseIf !aCodTab[1]
		MsgAlert(aCodTab[2])
	Endif
	
	aCompo	:= PLSCOMEVE(aCodTab[3],M->B45_CODPAD,M->B45_CODPRO,PLSINTPAD(),dDatPro)
	
	If Len(aCompo)==0
		Aviso( cTitulo, "Nao existe composi็ใo de pagamento para este procedimento!", {"Ok"} )
		Return
	Endif
	
	//Leonardo Portella - 18/07/12 - Inicio - Validar a quantidade de auxiliares cadastrados na BP1. Esta validacao foi necessaria pois quando ocorria de nao estar
	//cadastrado gerava erro.
	
	BP1->(DbSetOrder(1))
	BP1->(DbGoTop())
	
	cChaveAux 	:= xFilial('BP1') + PLSINTPAD() + aCodTab[3]
	aAuxs 		:= {}
	lContinua 	:= .T.
	
	If BP1->(MsSeek(cChaveAux))
		While !BP1->(EOF()) .and. ( BP1->(BP1_FILIAL + BP1_CODINT + BP1_CODTAB) == cChaveAux )
			aAdd(aAuxs,BP1->BP1_NUMAUX)
			BP1->(DbSkip())
		EndDo
		
		For nI := 1 to len(aCompo)
			If aCompo[nI,1] == 'AUX'
				If aScan(aAuxs,aCompo[nI,3]) <= 0
					cMsg := 'REFERENCIA DO AUXILIAR [' + cValToChar(aCompo[nI,3]) + '] NAO ENCONTRADA NA TABELA DE AUXILIARES (BP1) [' + aCodTab[3] + '] [' + AllTrim(Posicione("BF8",1,xFilial("BF8")+PLSINTPAD() + aCodTab[3],"BF8_DESCM")) + ']!' + CRLF + CRLF
					cMsg += 'Rede de antendimento: ' + cRDARee + ' [' + AllTrim(Posicione('BAU',1,xFilial('BAU') + cRDARee,'BAU_NOME')) + ']' + CRLF
					cMsg += 'Especialidade: ' +	BAX->BAX_CODESP + ' [' + AllTrim(Posicione('BAQ',1,xFilial('BAQ') + BAX->(BAX_CODINT + BAX_CODESP),'BAQ_DESCRI'))+ ']' + CRLF
					cMsg += 'Local: ' + BB8->BB8_LOCAL + ' [' + AllTrim(BB8->BB8_DESLOC) + ']' + CRLF
					cMsg += 'Tabela Pagamento RDA (conforme local) : ' + BB8->BB8_CODTAB + ' [' + AllTrim(Posicione("BF8",1,xFilial("BF8") + BB8->(BB8_CODINT + BB8_CODTAB),"BF8_DESCM")) + ']'+ CRLF
					cMsg += 'Quantidade de auxiliares existentes na tabela de auxiliares (BP1): ' + cValToChar(len(aAuxs)) + CRLF + CRLF
					cMsg += 'Verifique a quantidade de auxiliares na guia original, a composicao do procedimento na TDE e a quantidade de auxiliares na tabela de auxiliares (BP1)'
					
					MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
					
					lContinua := .F.
					exit
				EndIf
			EndIf
		Next
	Else
		For nI := 1 to len(aCompo)
			If aCompo[nI,1] == 'AUX'
				cMsg := 'Tabela de auxiliares (BP1) nao encontrada para o codigo de tabela [' + aCodTab[3] + ']!' + CRLF + CRLF
				cMsg += 'Rede de antendimento: ' + cRDARee + ' [' + AllTrim(Posicione('BAU',1,xFilial('BAU') + cRDARee,'BAU_NOME')) + ']' + CRLF
				cMsg += 'Especialidade: ' +	BAX->BAX_CODESP + ' [' + AllTrim(Posicione('BAQ',1,xFilial('BAQ') + BAX->(BAX_CODINT + BAX_CODESP),'BAQ_DESCRI'))+ ']' + CRLF
				cMsg += 'Local: ' + BB8->BB8_LOCAL + ' [' + AllTrim(BB8->BB8_DESLOC) + ']' + CRLF
				cMsg += 'Tabela Pagamento RDA (conforme local) : ' + BB8->BB8_CODTAB + ' [' + AllTrim(Posicione("BF8",1,xFilial("BF8") + BB8->(BB8_CODINT + BB8_CODTAB),"BF8_DESCM")) + ']'+ CRLF
				
				MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
				
				lContinua := .F.
				exit
			EndIf
		Next
	EndIf
	
	If !lContinua
		Return
	EndIf
	
	//Leonardo Portella - 18/07/12 - Fim
	
	U_CpPag()
	
	If Type("_aValor") == "U"
		Aviso( cTitulo, "Preencha os campos de procedimento e valor pago, antes de pesquisar a composi็ใo!", {"Ok"} )
		Return
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Carrega o vetor conforme a condicao...								  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	For nCont :=  1 to Len(aCompo)
		//aAdd( aVetor, { lMark, aCompo[nCont,1]+Iif(Alltrim(aCompo[nCont,1])=="AUX",StrZero(aCompo[nCont,3],2),""),"",0,0,0 })
		aAdd( aVetor, { lMark, aCompo[nCont,1]+Iif(Alltrim(aCompo[nCont,1])=="AUX",StrZero(aCompo[nCont,3],2),""),"",0 })
	Next
	
	For nCont := 1 to Len(aVetor)
		For nCont2 := 1 to Len(_aValor[1])
			If Alltrim(_aValor[1,nCont2,1]) == Substr(Alltrim(aVetor[nCont,2]),1,3)
				
				//Leonardo Portella - 18/07/12 - Inicio - Verificacao do tamanho do vetor - Array Out of Bounds - Rever
				
				lContinua := 	(len(_aValor[1,nCont2]) >= 5) .and. ;
					(len(_aValor[1,nCont2,5]) >= 1) .and. ;
					(len(_aValor[1,nCont2,5,1]) >= 3) .and. ;
					(Substr(Alltrim(aVetor[nCont,2]),1,3) == "AUX" .And. Substr(Alltrim(aVetor[nCont,2]),5,1) == Alltrim(Str(_aValor[1,nCont2,5,1,3])))
				
				If Substr(Alltrim(aVetor[nCont,2]),1,3) <> "AUX" .Or. lContinua
					//If Substr(Alltrim(aVetor[nCont,2]),1,3) <> "AUX" .Or. (Substr(Alltrim(aVetor[nCont,2]),1,3) == "AUX" .And. Substr(Alltrim(aVetor[nCont,2]),5,1) == Alltrim(Str(_aValor[1,nCont2,5,1,3])))
					
					//Leonardo Portella - 18/07/12 - Fim
					
					aVetor[nCont,3] := _aValor[1,nCont2,2] //Und. Saude
					aVetor[nCont,4] := _aValor[1,nCont2,9] //Referencia
					//				aVetor[nCont,5] := _aValor[1,nCont2,5,1,3] //Valor Unidade
					//				aVetor[nCont,6] := _aValor[1,nCont2,5,1,4] //Valor Item
					nCont2 := Len(_aValor[1])
				Endif
			Endif
		Next
	Next
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Monta a tela para usuario visualizar consulta						  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If Len( aVetor ) == 0
		Aviso( cTitulo, "Nao existe composi็ใo no procedimento informado! Verifique!", {"Ok"} )
		Return
	Endif
	
	DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se houver duplo clique, recebe ele mesmo negando, depois da um refreshณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	@ 10,10 LISTBOX oLbx VAR cVar FIELDS HEADER ;
		" ", "Comp. Pgto.","Und.Sa๚de","Refer๊ncia" ;
		SIZE 230,095 OF oDlg PIXEL ON dblClick(aVetor[oLbx:nAt,1] := !aVetor[oLbx:nAt,1],oLbx:Refresh())
	
	
	oLbx:SetArray( aVetor )
	oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),;
		aVetor[oLbx:nAt,2],;
		aVetor[oLbx:nAt,3],;
		aVetor[oLbx:nAt,4]}}
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Marca ou desmarca TUDO, chama funcao MARCA							  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	@ 110,10 CHECKBOX oChk VAR lChk PROMPT "Marca/Desmarca" SIZE 60,007 PIXEL OF oDlg;
		ON CLICK(Iif(lChk,U_Marca(lChk),U_Marca(lChk)))
	
	DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg CENTER
	
	For nCont := 1 To Len(aVetor)
		If aVetor[nCont,1]
			_cStrYCPPAG += Iif(nReg==1,"",",")+aVetor[nCont,2]
			nReg++
		Endif
	Next
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava o conteudo do retorno na memoria do campo, para retornar...	  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	M->B45_YCPPAG := _cStrYCPPAG
	
	RestArea(aAreaBB8)
	RestArea(aAreaBAX)
	RestArea(aAreaBAU)
	
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCPPag1    บAutor  ณMicrosiga           บ Data ณ  03/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User function CPPag1()
	Local lRet	:= .T.

	LOCAL aDadUsr	:= PLSGETUSR()
	Local aCodTab	:= {}

	Local aCompo	:= {}
	Local aRdas		:= {}
	Local aValAcu	:= {}
	Local aUnidsBlo	:= {}
	Local aVlBloq	:= {}
	Local nVlrTBlo	:= 0
	Local lCirurgico:= .F. //Via Acesso (SIM,NAO).
	Local nPerVia	:= 100 //Perc. Via Acesso...
	Local cRegPag
	Local cRegCob
	Local nCont		:= 0
	Local cCodLoc	:= ""
	Local cCodMun	:= ""
	Local cCodEsp	:= ""
	Local cSubEsp	:= ""
	Local dDatPro	:= M->B44_DATPRO
	Local cHorPro	:= "0800"
	Local cRDARee	:= GetNewPar("MV_YRDAREE","999998")

	Local _nTotal	:= 0
	Local _nVlrPag	:= 0
	Local _nVlrRem	:= 0
	Local nCtBlo1	:= 0
	Local nCtBlo2	:= 0
	Local nNVlrBlo	:= 0
	Local nPosBlo	:= 0
	Local nContRee

	Local nVlrRbsAnt := 0

	Public _aValor	:= {}

	BB8->(DbSetOrder(1))
	BAX->(DbSetOrder(1))
	BAU->(DbSetOrder(1))

	BAU->(MsSeek(xFilial("BAU")+cRDARee))
	BB8->(MsSeek(xFilial("BB8")+cRDARee+PLSINTPAD()))
	BAX->(MsSeek(xFilial("BAX")+cRDARee+PLSINTPAD()+BB8->BB8_CODLOC))

	cCodLoc	:= BB8->BB8_LOCAL
	cCodMun	:= BB8->BB8_CODMUN
	cCodEsp	:= BAX->BAX_CODESP
	cSubEsp	:= BAX->BAX_CODSUB

	If !(M->B45_VLRAPR == 0 .and. Empty(M->B45_DATPRO) .And. Empty(M->B45_HORPRO))

		If Empty(dDatPro)
			dDatPro := dDataBase
		Endif

		//u_RetFatReemb()
		//Provisorio ate que o sistema seja ajustado.
		//U_MultReemb(M->B45_YFTREE)

		/*	Bianchini - trecho original do PE - Versao 10
		aCodTab := PLSRETTAB(M->B45_CODPAD,M->B45_CODPRO,dDatPro,;
		PLSINTPAD(),cRDARee,cCodEsp,Nil,BB8->(BB8_CODLOC+BB8_LOCAL),; //Nil1: Especialidade, Nil2: Subespecialidade, Nil3:BD6->(BD6_CODLOC+BD6_LOCAL)
		dDatPro,"1",PLSINTPAD(),aDadUsr[11],"1","1")
		*/

		aCodTab := PLSRETTAB(M->B45_CODPAD,M->B45_CODPRO,dDatPro,;
		PLSINTPAD(),cRDARee,cCodEsp,cSubEsp,cCodLoc,;
		dDatPro,"1",PLSINTPAD(),aDadUsr[11],nil,"2",;
		aDadUsr,M->B44_TIPPRE,nil,nil,.T.,M->B44_UFATE,M->B44_MUNATE)

		aCompo	:= PLSCOMEVE(aCodTab[3],M->B45_CODPAD,M->B45_CODPRO,PLSINTPAD(),dDatPro)

		For nCont := 1 to Len(aCompo)

			aadd(aRdas,{aCompo[nCont,1],;
			cRDARee,;
			cCodLoc,; //Local
			cCodEsp,; //Especialidade
			0,;
			BAU->BAU_TIPPRE,; //Classe da rede
			0,;
			Iif(lCirurgico,nPerVia,0)})  //Perm. Via?

		Next

		cString := M->B45_YCPPAG

		While .T.

			nPos := At(",",cString)
			If nPos > 0
				Aadd(aUnidsBlo,{Substr(cString,1,nPos-1),"  "})
				cString := Substr(cString,nPos+1)
			Else
				If !Empty(Alltrim(cString))
					Aadd(aUnidsBlo,{Alltrim(cString),"  "})
				Endif
				Exit
			Endif
		Enddo

		/*	Bianchini - trecho original do PE - Versao 10

		_aValor := 	PLSCALCEVE(M->B45_CODPAD,M->B45_CODPRO,M->B44_MESPAG,M->B44_ANOPAG,;
		PLSINTPAD(),cRDARee,cCodEsp,cSubEsp,;
		cCodLoc,M->B45_QTDPRO,dDatPro,aDadUsr[48],Nil,"2",M->B45_VLRAPR,aDadUsr,Nil,; //Nil1: cPadInt, Nil2: cPadCon  - //"2" - Ambulatorial/"1"-Internacao
		Nil,nil,nil,nil,nil,cHorPro,nil,nil,Nil,0,; //Nil1: aQtdPer,Nil2:BD6_PROREL,NIL3(0): BD6_PRPRRL nil6: aRdas
		aValAcu,nil,dDatPro,cHorPro,Nil,"02",.F.,0,Nil,nil,; //Nil1:aUnidsBlo , Nil2: aVlBloq
		lCirurgico,nPerVia,cRegPag,cRegCob,M->B45_QTDPRO,M->B45_QTDPRO)  

		*/	

		_aValor :=  PLSCALCEVE(M->B45_CODPAD,M->B45_CODPRO,M->B44_MESPAG,M->B44_ANOPAG,;
		PLSINTPAD(),cRDARee,cCodEsp,cSubEsp,;
		cCodLoc,M->B45_QTDPRO,dDatPro,aDadUsr[48],M->B44_PADINT,"2",M->B45_VLRAPR,aDadUsr,M->B44_PADCON,;  //"2" - Ambulatorial/"1"-Internacao
		Nil,aCodTab[3],aCodTab[4],nil,nil,cHorPro,nil,nil,Nil,0,; //Nil1: aQtdPer,Nil2:BD6_PROREL,NIL3(0): BD6_PRPRRL nil6: aRdas
		aValAcu,nil,dDatPro,cHorPro,Nil,"04",.F.,0,Nil,nil,; //Nil1:aUnidsBlo , Nil2: aVlBloq
		lCirurgico,nPerVia,nil,nil,M->B45_QTDPRO,,,,,,,M->B44_REGINT,M->B44_TIPPAC,,M->B44_UFATE,M->B44_MUNATE)	   


		//Ponto de entrada devera ser inserido aqui!
		_aValor[1] := MudaVlrRee(_aValor[1])

		_aValor[2] := 0
		For nContRee := 1 to Len(_aValor[1])
			If _aValor[1,nContRee,3]
				_aValor[2] += _aValor[1,nContRee,5,1,4]
			Endif
		Next

		For nCtBlo1 := 1 To Len(aUnidsBlo)
			For nCtBlo2 := 1 To Len(_aValor[1])
				If _aValor[1,nCtBlo2,1] == Substr(aUnidsBlo[nCtBlo1,1],1,3)
					If Substr(aUnidsBlo[nCtBlo1,1],1,3) <> "AUX" .Or. (Substr(aUnidsBlo[nCtBlo1,1],1,3) == "AUX" .And. Alltrim(Str(_aValor[1,nCtBlo2,5,1,3]))==Substr(aUnidsBlo[nCtBlo1,1],5,1))
						nNVlrBlo += _aValor[1,nCtBlo2,5,1,4]
					Endif
				Endif
			Next
		Next

		//M->BKE_VLRCST := (_aValor[2]-nNVlrBlo)*M->BKE_YFTREE
		//M->BKE_VLRCST := ((_aValor[2]-nNVlrBlo)*M->BKE_YFTREE)*M->BKE_QTDPRO
		nNVlrBlo := 0

		/*
		If M->BKE_VLRCST <> 0
		M->BKE_VLRRBS := Iif(M->BKE_VLRCST<=M->BKE_VLRPAG,M->BKE_VLRCST,M->BKE_VLRPAG)
		Endif
		*/

		/*
		//JA ESTAVA COMENTADO NA FUNCAO ORIGINAL
		_aVetCop    := PLSTABCOP(M->BKE_CODTAB,M->BKE_CODPRO,PLSINTPAD(),cRDARee,cCodEsp,cSubEsp,cCodLoc,;
		"",Substr(aDadUsr[38],1,4),aDadUsr[9],aDadUsr[39],aDadUsr[41],aDadUsr[42],aDadUsr[11],;
		aDadUsr[45],aDadUsr[12],"",BAU->BAU_TIPPRE,cCodMun,.T.,.F.,;
		Substr(aDadUsr[2],9,6),Substr(aDadUsr[2],15,2),dDatPro,aDadUsr[48],.F.,"","",; //cNivAut, cChaveAut
		NIL,Substr(DtoS(dDatPro),5,2),Substr(DtoS(dDatPro),1,4),dDatPro,cHorPro,"2","",0,M->BKE_QTDPRO,{},{},0)

		MsgAlert("_aVetCop[2]"+StrZero(_aVetCop[2],3))
		*/


		/*
		If M->BKE_VLRPAG > 0
		If M->BKE_PERREM > 0
		If M->BKE_VLRCST <= M->BKE_VLRRBS
		M->BKE_VLRRBS := M->BKE_VLRCST*(M->BKE_PERREM/100)
		Endif
		Endif
		If M->BKE_PREPAG > 0
		If M->BKE_VLRPAG <= M->BKE_VLRRBS
		M->BKE_VLRRBS := M->BKE_VLRPAG*(M->BKE_PREPAG/100)
		Endif
		Endif
		Endif
		*/

		/*
		_nTotal  := 0
		_nVlrPag := 0
		_nVlrRem := 0

		For nFor := 1 To Len(oGet01:aCols)
		If nFor == n
		_nTotal  += M->BKE_VLRCST
		_nVlrPag += M->BKE_VLRPAG
		_nVlrRem += M->BKE_VLRRBS
		Else
		_nTotal  += oGet01:FieldGet("BKE_VLRCST",nFor)
		_nVlrPag += oGet01:FieldGet("BKE_VLRPAG",nFor)
		_nVlrRem += oGet01:FieldGet("BKE_VLRRBS",nFor)
		Endif
		Next

		M->BKD_VLRCST := _nTotal
		M->BKD_VLRPAG := _nVlrPag
		M->BKD_VLRREM := _nVlrRem

		//Modificado para forcar o valor conforme usuario...
		If M->BKE_YVLFOR > 0 //.And. M->BKE_YVLFOR < M->BKE_VLRRBS
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Conforme solicitado, consistir valor forcado maior que protocolado... ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If M->BKE_YVLFOR+(M->BKD_VLRREM-M->BKE_VLRRBS) <= ZZQ->ZZQ_VLRTOT
		M->BKE_VLRRBS := M->BKE_YVLFOR

		_nTotal  := 0
		_nVlrPag := 0
		_nVlrRem := 0

		For nFor := 1 To Len(oGet01:aCols)
		If nFor == n
		_nTotal  += M->BKE_VLRCST
		_nVlrPag += M->BKE_VLRPAG
		_nVlrRem += M->BKE_VLRRBS
		Else
		_nTotal  += oGet01:FieldGet("BKE_VLRCST",nFor)
		_nVlrPag += oGet01:FieldGet("BKE_VLRPAG",nFor)
		_nVlrRem += oGet01:FieldGet("BKE_VLRRBS",nFor)
		Endif
		Next

		M->BKD_VLRCST := _nTotal
		M->BKD_VLRPAG := _nVlrPag
		M->BKD_VLRREM := _nVlrRem

		Endif
		Endif
		*/


	Endif

	/*
	lRefresh := .T.
	oEnchoice:Refresh()
	*/

Return lRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValCompReeบAutor  ณ Jean Schulz        บ Data ณ  23/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar a ocorrencia de duplicidade na composi- บฑฑ
ฑฑบ          ณcao de cobranca de um reembolso.                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ValCompRee()
	
	Local nCont			:= 0
	Local lValida		:= .T.
	Local lRet			:= .T.
	Local aAreaZZR		:= ZZR->(GetArea())
	Local cCpPag		:= M->B45_YCPPAG
	Local aVetCpPag	:= {}
	Local cSQL			:= ""
	Private _aCamposV	:= {"M->B45_CODPRO","M->B45_QTDPRO","M->B45_VLRAPR","M->B45_CODPAD","M->B45_DATPRO","M->B45_HORPRO"}
	lValida := M->B44_ZZZCOD <> GetNewPar("MV_YCPLREE","13")
	
	ZZR->(DbSetOrder(1))
	B44->(DbSetOrder(1))
	
	If lValida
		
		cCpPag := M->B45_YCPPAG
		
		While .T.
			
			nPos := At(",",cCpPag)
			If nPos > 0
				Aadd(aVetCpPag,Substr(cCpPag,1,nPos-1))
				cCpPag := Substr(cCpPag,nPos+1)
			Else
				If !Empty(Alltrim(cCpPag))
					Aadd(aVetCpPag,Alltrim(cCpPag))
				Endif
				Exit
			Endif
		Enddo
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Levantamento para ver se item ja foi pago anteriormente...         	  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		//BD6_FILIAL+BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO+DTOS(BD6_DATPRO)+BD6_CODPAD+BD6_CODPRO+BD6_FASE+BD6_SITUAC+BD6_HORPRO
		cSQL := " SELECT BD7_CODUNM, BD7_NLANC, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, BD7_CODUNM, BD7_NLANC "
		cSQL += " FROM "+RetSQLName("BD6")+" BD6, "+RetSQLName("BD7")+" BD7 "
		cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
		cSQL += " AND BD6_OPEUSR = '"+M->B44_OPEUSR+"' "
		cSQL += " AND BD6_CODEMP = '"+M->B44_CODEMP+"' "
		cSQL += " AND BD6_MATRIC = '"+M->B44_MATRIC+"' "
		cSQL += " AND BD6_TIPREG = '"+M->B44_TIPREG+"' "
		cSQL += " AND BD6_DIGITO = '"+M->B44_DIGITO+"' "
		cSQL += " AND BD6_DATPRO = '"+DtoS(M->B45_DATPRO)+"' "
		cSQL += " AND BD6_CODPAD = '"+M->B45_CODPAD+"' "
		cSQL += " AND BD6_CODPRO = '"+M->B45_CODPRO+"' "
		cSQL += " AND BD6_FASE IN ('3','4') "
		cSQL += " AND BD6_SITUAC = '1' "
		
		cSQL += " AND BD7_FILIAL = '"+xFilial("BD7")+"' "
		cSQL += " AND BD7_CODOPE = BD6_CODOPE "
		cSQL += " AND BD7_CODLDP = BD6_CODLDP "
		cSQL += " AND BD7_CODPEG = BD6_CODPEG "
		cSQL += " AND BD7_NUMERO = BD6_NUMERO "
		cSQL += " AND BD7_ORIMOV = BD6_ORIMOV "
		cSQL += " AND BD7_SEQUEN = BD6_SEQUEN "
		cSQL += " AND ( BD7_BLOPAG <> '1' AND BD7_VLRPAG > 0 ) "
		
		cSQL += " AND BD7.D_E_L_E_T_ = ' ' "
		cSQL += " AND BD6.D_E_L_E_T_ = ' ' "
		
		PLSQuery(cSQL,"TRBVLD")
		
		lRet := .T.
		While !TRBVLD->(Eof())
			
			If ascan(aVetCpPag,Alltrim(TRBVLD->BD7_CODUNM)+Alltrim(TRBVLD->BD7_NLANC)) == 0
				lRet := .F.
				Exit
			Endif
			
			TRBVLD->(DbSkip())
			
		Enddo
		
		If !lRet .And. M->B44_ZZZCOD <> GetNewPar("MV_YCPLREE","13")
			lRet := MsgYesNo("Item jแ pago no contas m้dicas! Chave Guia: "+TRBVLD->(BD7_CODOPE+"."+BD7_CODLDP+"."+BD7_CODPEG+"."+BD7_NUMERO+"."+BD7_ORIMOV+"."+BD7_SEQUEN)+" Item: "+Alltrim(TRBVLD->BD7_CODUNM)+Alltrim(TRBVLD->BD7_NLANC)+" Deseja continuar?" )
			//MsgAlert("Item jแ pago no contas m้dicas! Chave Guia: "+TRBVLD->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN)+" Item: "+Alltrim(TRBVLD->BD7_CODUNM)+Alltrim(TRBVLD->BD7_NLANC))
		Endif
		
		TRBVLD->(DbCloseArea())
		
	Endif
	
	RestArea(aAreaZZR)
	
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  07/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida se o protocolo do reembolso pode ser utilizado.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldProtRee()
	Local lRet := .T.
	
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBusRecDes   บAutor  ณ Jean Schulz      บ Data ณ  30/07/08   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca receita e despesa de determinado beneficiแrio, em     บฑฑ
ฑฑบ          ณdeterminada compet๊ncia.                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ cChave : chave de pesquisa.                                บฑฑ
ฑฑบ          ณ cAno: ano de avaliacao.   a                                บฑฑ
ฑฑบ          ณ cNivel: 4-familia / 5-usuario                              บฑฑ
ฑฑบRetorno   ณ 13 posicoes (12 meses + 1 acumulado no ano).               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BusRecDes(cChave,cAno,cNivel)
	Local _aRet 	 := {}
	Local _aArea    := GetArea()
	Local _aAreaBX9 := BX9->(GetArea())
	Local _aMesAbr	 := {"JAN","FEV","MAR","ABR","MAI","JUN","JUL","AGO","SET","OUT","NOV","DEZ","ACU"}
	Local _nVlrCus	 := 0
	Local _nVlrRec	 := 0
	Local _cNmCampo := ""
	Local _nCont	 := 0
	
	DbSelectArea("BX9")
	BX9->(DbSetOrder(6)) //BX9_FILIAL + BX9_TIPO + BX9_ANO + BX9_CODOPE + BX9_CODEMP + BX9_MATRIC + BX9_TIPREG
	If BX9->(MsSeek(xFilial("BX9")+cNivel+cAno+cChave))
		For _nCont := 1 to 13
			_cNmCampo := "BX9->BX9_VRR"+_aMesAbr[_nCont]
			_nVlrRec := &_cNmCampo
			
			_cNmCampo := "BX9->BX9_VRC"+_aMesAbr[_nCont]
			_nVlrCus := &_cNmCampo
			
			aadd(_aRet,{cChave,cNivel,cAno,StrZero(_nCont,2),_nVlrRec,_nVlrCus})
			
		Next
	Endif
	
	RestArea(_aAreaBX9)
	RestArea(_aArea)
	
Return _aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  10/17/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fPesqMovBsq(_cMes,_cAno,cChave)
	Local cQuery := " "
	Local lRet   := .T.
	
	cQuery := " SELECT COUNT(*) QTD FROM " + RetSqlName("BSQ")
	cQuery += " WHERE "
	cQuery += " BSQ_YNMSE1 = '" + cChave + "' AND "
	cQuery += " BSQ_MES    = '" + _cMes  + "' AND "
	cQuery += " BSQ_ANO    = '" + _cAno  + "' AND "
	cQuery += " D_E_L_E_T_ = ' ' "
	
	If Select("TRB2") >0
		dbSelectArea("TRB2")
		dbclosearea()
	Endif
	
	TCQuery cQuery Alias "TRB2" New
	
	dbSelectArea("TRB2")
	
	If TRB2->QTD > 0
		lRet := .F.
		Alert( " O TITULO " + cChave + ", NAO PODE SER GRAVADO NO MOVIMENTO DEBITO/CREDITO , FAVOR VERIFICAR SE EXISTE DUPLICIDADE !!!" )
	Endif
	
Return lRet

/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ fAdmPath      ณ Autor ณ Simone Mie Sato         ณ Data ณ 04/02/03 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Usado no SXB (XB_ALIAS= "DIR") para buscar um determinado arq. ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Siga                                                           ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function fAdmPath()
	
	Local nMaskDef := 2   //mascara JPEG como default
	Local cMask    := "Arquivos Itau(T*.0?)|T*.0?|Todos Arquivos(*.*)|*.*|"
	//Local cDirAtu  := "SERVIDOR\INTERFACE\IMPORTA\ITAUBENEF"        // Diretoria atual
	Local cDirAtu  := GetNewPar("MV_YPTARI","SERVIDOR\INTERFACE\IMPORTA\ITAUBENEF\RECEBIDOS\")
	Local cFile    := ""                                        // path + arquivo
	Local lRet     := .T.                                   // Retorno da funcao
	Local cDrive   := Space(255)                         // Drive onde esta o arquivo
	Local cDir     := Space(255)                         // Diretorio onde esta o arquivo
	
	//cArq    := cGetFile(cExt,SubStr(cExt,1,12),,,.T.,1))
	cAdmArq     := Upper(cGetFile( cMask,OemToAnsi("Selecione arquivo..."),,cDirAtu,.T.,GETF_LOCALHARD+GETF_NETWORKDRIVE,.T.))
	//__cFile := cGetFile( cMask,"Selecione arquivo...",@nMaskDef    , cDirAtu   ,.T., CGETFILE_TYPE )
	
Return !Empty(cAdmArq)

/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ AdmArq       ณ Autor ณ Simone Mie Sato         ณ Data ณ 04/02/03 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Usado no SXB (XB_ALIAS= "DIR") para buscar um determinado arq. ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Siga                                                           ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function fAdmArq()
	Local nPos := At("\TPSA",Upper(cAdmArq))
	
	If nPos > 0
		cAdmArq := Substr(cAdmArq,nPos+1)
	Else
		nPos := At("\TFT",Upper(cAdmArq))
		If nPos > 0
			cAdmArq := Substr(cAdmArq,nPos+1)
		EndIf
	EndIf
	
Return(cAdmArq)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณF050snm   บAltamiroณ AP6 IDE            บ Data ณ  03/04/09  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Valida de E2_num ้ num้rico                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/


USER FUNCTION F050snm()
	
	PRIVATE lverde := .T.
	PRIVATE nnumro := 0
	PRIVATE x  := 1
	//private num := "0123456789ABXCDEFGHIJLMNOPQRSTUVXZabcdefghiflmnopqrstuvxz*"
	x:= 1
	while x <= len(M->e2_num)
		//while x <= len(num)
		if lverde
			nnumro:= Asc (substr(M->e2_num,x , 1))
			// nnumro:= Asc (substr(num,x , 1))
			lverde := ( ( nnumro = 32) .or. ( nnumro > 47 .and. nnumro < 58 ) .or.  ( nnumro > 64 .and. nnumro < 91 ) .or. ( nnumro > 96 .and. nnumro < 123 ) )
		endif
		if  Empty(M->e2_num) .or. !lverde
			// ALERT ("Caractere Invalida na Composi็ใo do Campo ")
			x :=  len(M->e2_num)
			lverde := .F.
		endif
		x++
	enddo
Return(lverde)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGatUsuario  บAutor  ณ altamiro         บ Data ณ25/05/09     บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณmensagem de alerta , quando prefixo = "FIN' e ccusto = 998  บฑฑ
ฑฑบ          ณretornado "S" sim - para atender o gatilho e2_ccd           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MenCcd()
	Local cRet := "S"
	MsgAlert("Verifique o Rateio !","Aten็ใo")
Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณAlexandre Pitta     บ Data ณ  22/09/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao chamada na valida็ใo do campo ZZQ_CODBEN da tela de  บฑฑ
ฑฑบ          ณ protocolo de reembolso, a fim de bloquear assistidos       บฑฑ
ฑฑบ          ณ de reciprocidades.                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ValReeRecipr(cCodemp)
	Local lRet := .F.
	
	//If Trim(cCodemp) == "0004"
	If cEmpAnt =="01" .and. Trim(cCodemp) $ "0004|0009"
		MsgAlert("Plano do associado nใo tem cobertura para reembolso!","Aten็ใo")
	Else
		lRet := .T.
	Endif
	
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPREVIAN   บAutor  ณFabio Bianchini     บ Data ณ  20/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo que grava Valor Previsto de Anestesia para          บฑฑ
ฑฑบ          ณ procedimentos que estejam na senha de interna็ใo.          บฑฑ
ฑฑบ          ณ E gravado na criacao da senha e na aprovacao de auditoria. บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj / Integral                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PreviAn(cCodOpe, cAnoInt, cMesInt, nNumInt, nOpcao, cCODINT, cCODEMP, cMATRIC, cTIPREG, cDIGITO, cCONEMP, cVERCON, cSUBCON, cVERSUB, cRotina)
	Local nPreviAn  := 0
	Local cSQL 	    := ""
	Local cCodPla   := ""
	Local nFatMul   := 1
	Local nChReem   := 0
	Local bLinhaIni := .T.
	Local nValReem  := 0
	
	Local a_AreaBa1 := getArea("BA1")
	Local a_AreaBa3 := getArea("BA3")
	
	cSQL := "SELECT BEJ_CODPAD, BEJ_CODPRO, BEJ_DESPRO, BR8_TPPROC, BD4_VALREF, BKF_COEFIC, BKF_VLRREA "
	cSQL += " FROM "+ RetSQLName("BEJ")+" BEJ, "+RetSQLName("BR8")+" BR8, "+RetSQLName("BD4")+" BD4, "+RetSQLName("BKF")+" BKF "
	cSQL += " WHERE BEJ_FILIAL = '"+xFilial("BEJ")+"' "
	cSQL += "  AND BR8_FILIAL = '"+xFilial("BR8")+"' "
	cSQL += "  AND BD4_FILIAL = '"+xFilial("BD4")+"' "
	cSQL += "  AND BKF_FILIAL = '"+xFilial("BKF")+"' "
	cSQL += "  AND BR8_CODPAD = BEJ_CODPAD "
	cSQL += "  AND BR8_CODPSA = BEJ_CODPRO "
	cSQL += "  AND BR8_CODPAD = BD4_CDPADP "
	cSQL += "  AND BR8_CODPSA = BD4_CODPRO "
	cSQL += "  AND BKF_CODINT = BEJ_CODOPE "
	cSQL += "  AND BKF_CODTAB = SUBSTR(BD4_CODTAB,5,3) "
	cSQL += "  AND BKF_SEQPOR = BD4_VALREF "
	cSQL += "  AND BD4_CODIGO IN ('PA','PAP') "
	cSQL += "  AND BD4_VIGFIM = ' ' "
	cSQL += "  AND BKF_VIGFIN = ' ' "
	cSQL += "  AND BEJ_CODOPE  = '"+ BE4->BE4_CODOPE+"' "
	cSQL += "  AND BEJ_ANOINT  = '"+ BE4->BE4_ANOINT+"' "
	cSQL += "  AND BEJ_MESINT  = '"+ BE4->BE4_MESINT+"' "
	cSQL += "  AND BEJ_NUMINT  = '"+ BE4->BE4_NUMINT+"' "
	cSQL += "  AND BEJ.D_E_L_E_T_ = ' ' "
	cSQL += "  AND BR8.D_E_L_E_T_ = ' ' "
	cSQL += "  AND BD4.D_E_L_E_T_ = ' ' "
	cSQL += "  AND BKF.D_E_L_E_T_ = ' ' "
	
	cSQL += "UNION "
	
	cSQL += "SELECT BQV_CODPAD, BQV_CODPRO, BQV_DESPRO, BR8_TPPROC, BD4_VALREF, BKF_COEFIC, BKF_VLRREA "
	cSQL += " FROM "+ RetSQLName("BQV")+" BQV, "+RetSQLName("BR8")+" BR8, "+RetSQLName("BD4")+" BD4, "+RetSQLName("BKF")+" BKF "
	cSQL += " WHERE BQV_FILIAL = '"+xFilial("BQV")+"' "
	cSQL += "  AND BR8_FILIAL = '"+xFilial("BR8")+"' "
	cSQL += "  AND BD4_FILIAL = '"+xFilial("BD4")+"' "
	cSQL += "  AND BKF_FILIAL = '"+xFilial("BKF")+"' "
	cSQL += "  AND BR8_CODPAD  = BQV_CODPAD "
	cSQL += "  AND BR8_CODPSA  = BQV_CODPRO "
	cSQL += "  AND BR8_CODPAD  = BD4_CDPADP "
	cSQL += "  AND BR8_CODPSA  = BD4_CODPRO "
	cSQL += "  AND BKF_CODINT  = BQV_CODOPE "
	cSQL += "  AND BKF_CODTAB  = SUBSTR(BD4_CODTAB,5,3) "
	cSQL += "  AND BKF_SEQPOR  = BD4_VALREF "
	cSQL += "  AND BD4_CODIGO IN ('PA','PAP') "
	cSQL += "  AND BD4_VIGFIM  = ' ' "
	cSQL += "  AND BKF_VIGFIN = ' ' "
	cSQL += "  AND BQV_CODOPE  = '"+ BE4->BE4_CODOPE+"' "
	cSQL += "  AND BQV_ANOINT  = '"+ BE4->BE4_ANOINT+"' "
	cSQL += "  AND BQV_MESINT  = '"+ BE4->BE4_MESINT+"' "
	cSQL += "  AND BQV_NUMINT  = '"+ BE4->BE4_NUMINT+"' "
	cSQL += "  AND BQV.D_E_L_E_T_  = ' ' "
	cSQL += "  AND BR8.D_E_L_E_T_  = ' ' "
	cSQL += "  AND BD4.D_E_L_E_T_  = ' ' "
	cSQL += "  AND BKF.D_E_L_E_T_  = ' ' "
	
	cSQL += " ORDER BY BD4_VALREF DESC"
	
	PLSQuery(cSQL,"PLSBEJ")
	
	//COUNT TO nQtdRegBEJ
	
	//_nQtdPro := 0
	//aValor   := {}
	
	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"
			
			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "FUNCOES - 1")
			
		EndIf
	EndIf
	
	cCodpla := Posicione("BA1",2,xFilial("BA1")+ cCODINT+cCODEMP+cMATRIC+cTIPREG+cDIGITO,"BA1_CODPLA")
	
	
	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"
			
			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "FUNCOES - 2")
			
		EndIf
	EndIf
	
	if cCodPla = " "
		cCodpla := Posicione("BA3",1,xFilial("BA3")+cCODINT+cCODEMP+cMATRIC+cCONEMP+cVERCON+cSUBCON+cVERSUB,"BA3_CODPLA")
	endif
	
	cSQL2 := "SELECT DISTINCT ZZZ_DESCRI, ZZZ_VLRUS, ZZZ_FATMUL, ZZZ_CODPLA"
	cSQL2 += " FROM "+ RetSQLName("ZZZ")+" ZZZ "
	cSQL2 += " WHERE ZZZ_FILIAL = '"+xFilial("ZZZ")+"' "
	cSQL2 += "  AND ZZZ_DESCRI LIKE '%ANESTESIA%' "
	cSQL2 += "  AND ZZZ_VIGFIN = ' ' "
	cSQL2 += "  AND ZZZ_CODPLA = " + cCodpla
	cSQL2 += "  AND D_E_L_E_T_ = ' ' "
	cSQL2 += "ORDER BY ZZZ_CODPLA "
	
	PLSQuery(cSQL2,"PLSZZZ")
	
	nFatMul := PLSZZZ->(ZZZ_FATMUL)
	
	nChReem := PLSZZZ->(ZZZ_VLRUS)
	
	bLinhaIni := .T.
	
	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"
			
			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "FUNCOES - 3")
			
		EndIf
	EndIf
	
	PLSBEJ->( dbGoTop() )
	while PLSBEJ->( !Eof() )
		// BR8 - Tabela de Tipos de procedimentos     Campo = BR8_TPPROC
		// 0=Procedimento;1=Material;2=Medicamento;3=Taxas;4=Diแrias;5=ำrtese/Pr๓tese;6=Pacote;7=Gases Medicinais;8=Alugu้is
		if PLSBEJ->BR8_TPPROC == '0'
			//BIANCHINI - INICIO
			if bLinhaIni == .T.
				//nValReem += (PLSBEJ->BKF_COEFIC * nChReem) * nFatMul
				//BIANCHINI - 11/10/2018 - AJUSTANDO PARA POEGAR A COLUNA DE VALOR EM REAL
				nValReem += (PLSBEJ->BKF_VLRREA) * nFatMul
				bLinhaIni := .F.
			else
				//nValReem += ((PLSBEJ->BKF_COEFIC * nChReem) * nFatMul) * 0.5
				//BIANCHINI - 11/10/2018 - AJUSTANDO PARA POEGAR A COLUNA DE VALOR EM REAL
				nValReem += ((PLSBEJ->BKF_VLRREA) * nFatMul) * 0.5
			endif
			//BIANCHINI - FIM
			//_nQtdPro += PLSBEJ->( BEJ_QTDPRO )
		endif
		PLSBEJ->( dbSkip() )
	enddo
	
	
	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"
			
			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "FUNCOES - 4")
			
		EndIf
	EndIf
	
	if nValReem > 0
		
		
		If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
			If FunName() == "PLSA092"
				
				u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "FUNCOES - 1")
				
			EndIf
		EndIf
		
		if cRotina $ "PLSA092,TMKA271"
			
			DEFINE FONT oFont NAME "Arial" SIZE 000,-016 BOLD
			DEFINE MSDIALOG oDlg TITLE "Informe Estimado de Anestesia" FROM 008.2,003.3 TO 016,055 OF GetWndDefault()
			@ 18,  10  Say   oSay PROMPT "Valor M้dio Estimado : "	SIZE 160,10 OF oDlg FONT oFont COLOR CLR_HBLUE PIXEL
			@ 18, 120  MSGET oGet VAR nValReem                      SIZE  40,10	OF oDlg FONT oFont PICTURE "@RE 99999.00" WHEN .F. PIXEL
			bInAl   := TButton():New(38, 80,'Ok',,{ || nOpca := 0 , oDlg:End() } , 040, 012 ,,,,.T.)
			//bFechar := TButton():New(38,140,'Rejeitar'   ,,{ || nOpca := 2 , oDlg:End() } , 040, 012 ,,,,.T.)
			ACTIVATE MSDIALOG oDlg CENTERED
			
		endif
		
		nPreviAn := noround(nValReem,0)

		
	else
		
		
		If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
			If FunName() == "PLSA092"
				
				u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "FUNCOES - 6")
				
			EndIf
		EndIf
		
		nPreviAn := 0
		MsgAlert( "Nao ha valor m้dio para anestesia...Verifique !!" )
	endif
	
	
	
	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"
			
			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "FUNCOES - 7")
			
		EndIf
	EndIf
	
	PLSBEJ->(DbCloseArea())
	PLSZZZ->(DbCloseArea())
	
	RestArea( a_AreaBa1 )
	RestArea( a_AreaBa3 )
	
	
	If alltrim( GetNewPar("MV_XLOGINT", '0') ) == '1'
		If FunName() == "PLSA092"
			
			u_LogMatInt(M->BE4_USUARI, M->BE4_NOMUSR, "FUNCOES - 7")
			
		EndIf
	EndIf
	
	
Return nPreviAn

*****************************************************************************************************************************************************

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณLeonardo Portella - 14/11/13 - Virada P11                  ณ
//ณValidacao chamada pelo campo BDX_ACAO no momento da analiseณ
//ณde glosas.                                                 ณ
//ณCampo BDX_GLOSIS nao se encontra como variavel de memoria  ณ
//ณe nao esta no aHeader/aCols e eh necessario para validacao ณ
//ณna Caberj.                                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

User Function VldAnaGlo
	
	Local aArea			:= GetArea()
	Local aAreaBDX		:= BDX->(GetArea())
	Local lOk 			:= .T.
	Local cAcao			:= M->BDX_ACAO
	Local nRecBDX		:= oBrwCri:aVetTrab[oBrwCri:linha()]//Recno da linha que esta sendo analisada - Vide PLSA500
	Local cMsg			:= ''
	Local a_Glosas		:= ''//Leonardo Portella - 22/10/14 - Considerar todas as linhas da glosa e nao apenas a posicionada
	Local c_ChaveBDX	:= ''//Leonardo Portella - 22/10/14 - Considerar todas as linhas da glosa e nao apenas a posicionada
	Local c_Criticados	:= ''//Leonardo Portella - 22/10/14 - Nao repetir a mesma critica
	Local aCritEst		:= IIF((cEmpAnt=='01' .and. BD6->BD6_CODEMP $ '5000|5001|5002') .or. (cEmpAnt=='02' .and. BD6->BD6_CODEMP $ '0180|0183|0188|0189|0190|0259 '),u_aCriEstaleiro(),{.f.,.f.,0})
		
	BDX->(DbGoTo(nRecBDX))
	
	If ( cAcao == "1" )//Glosa
		
		//--------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 09/07/2018
		//--------------------------------------------------------------------------------------------
		//Em alguns momentos a rotina nใo estava preenchendo o campo com os valores
		//--------------------------------------------------------------------------------------------
		If Empty(M->BDX_VLRMAN)
					
			DbSelectArea("BD6")
			DbSetOrder(1) 
			If DbSeek(xFilial("BD6") + M->(BDX_CODOPE+BDX_CODLDP+BDX_CODPEG+BDX_NUMERO+BDX_ORIMOV+BDX_SEQUEN+BDX_CODPAD+BDX_CODPRO)) 
			 
				M->BDX_VLRMAN :=  BD6->BD6_VLRMAN				       
			
			EndIf									
			
		EndIf
				
	ElseIf ( cAcao == "2" )//Reconsidera
		
		//Leonardo Portella - 22/10/14 - Inicio - Considerar todas as linhas da glosa e nao apenas a posicionada
		
		c_ChaveBDX	:= BDX->(BDX_FILIAL + BDX_CODOPE + BDX_CODLDP + BDX_CODPEG + BDX_NUMERO)
		
		BDX->(DbSetOrder(1))
		
		BDX->(DbSeek(c_ChaveBDX))//garantir o ponteiramento na primeira critica e fazer o loop em todas
		
		While !BDX->(EOF()) .and. ( BDX->(BDX_FILIAL + BDX_CODOPE + BDX_CODLDP + BDX_CODPEG + BDX_NUMERO) == c_ChaveBDX )
			
			//Leonardo Portella - 22/10/14 - Fim - Considerar todas as linhas da glosa e nao apenas a posicionada
			
			Do Case
				
				//Leonardo Portella - 25/09/14 - Inicio - Critica do Estaleiro. Vide PE PLSAUT02
				
			Case ( BDX->BDX_GLOSIS == "703" ) .and. !( BDX->BDX_GLOSIS $ c_Criticados )
				
				c_Criticados += BDX->BDX_GLOSIS + '|'
				
				If u_aCriEstaleiro()[1]//Se for criticado pelas regras do Estaleiro
					
					lOk := .F.
					
					cMsg += '- Crํtica da empresa Estaleiro:' 																						+ CRLF
					cMsg += '- Nใo serแ permitido reconsiderar a crํtica [ ' + BDX->BDX_GLOSIS + ' - ' + AllTrim(BDX->BDX_DESGLO) + ' ]' 			+ CRLF
					cMsg += '- Procedimento [ ' + BDX->BDX_CODPAD + ' - ' + AllTrim(BDX->BDX_CODPRO) + ' - ' + AllTrim(BDX->BDX_DESPRO) + ' ]' 	+ CRLF
					cMsg += '- Sequencia [ ' + BDX->BDX_SEQUEN + ' ]'
					
					MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
					
					If RetCodUsr() $ GetMV('MV_XGETIN')
						lOk := MsgYesNo(cMsg + CRLF + CRLF + '- Libera็ใo T.I.: FORวAR?',AllTrim(SM0->M0_NOMECOM))
					Else
						MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
					EndIf
					
				EndIf
				
				//Leonardo Portella - 25/09/14 - Fim
				
			Case ( BDX->BDX_GLOSIS $ Getnewpar("MV_XCODGLO","706") ) .and. !( BDX->BDX_GLOSIS $ c_Criticados )
				
				c_Criticados += BDX->BDX_GLOSIS + '|'
				
				If !u_lPermRep(BCI->BCI_CODRDA)//Permite reconsiderar reciprocidade e repasse
					
					lOk := .F.
					
					cMsg += '- Nใo serแ permitido reconsiderar a crํtica [ ' + BDX->BDX_GLOSIS + ' - ' + AllTrim(BDX->BDX_DESGLO) + ' ]' 			+ CRLF
					cMsg += '- Procedimento [ ' + BDX->BDX_CODPAD + ' - ' + AllTrim(BDX->BDX_CODPRO) + ' - ' + AllTrim(BDX->BDX_DESPRO) + ' ]' 	+ CRLF
					cMsg += '- Sequencia [ ' + BDX->BDX_SEQUEN + ' ]'
					
					//Leonardo Portella - 19/02/14 - Incluindo opcao de forcar para TI (caso de guias de rateio)
					If RetCodUsr() $ GetMV('MV_XGETIN')
						lOk := MsgYesNo(cMsg + CRLF + CRLF + '- Libera็ใo T.I.: FORวAR?',AllTrim(SM0->M0_NOMECOM))
					Else
						MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
					EndIf
					
				EndIf
				
				//Leonardo Portella - 07/03/17 - Inํcio - Impedir reconsiderar glosa de n๚mero impresso
				
			Case ( BDX->BDX_GLOSIS == "099" ) .and. !( BDX->BDX_GLOSIS $ c_Criticados )
				
				c_Criticados += BDX->BDX_GLOSIS + '|'
				
				lOk := .F.
				
				cMsg += '- Crํtica da n๚mero impresso duplicado:' 																				+ CRLF
				cMsg += '- Nใo serแ permitido reconsiderar a crํtica [ ' + BDX->BDX_GLOSIS + ' - ' + AllTrim(BDX->BDX_DESGLO) + ' ]' 			+ CRLF
				cMsg += '- Procedimento [ ' + BDX->BDX_CODPAD + ' - ' + AllTrim(BDX->BDX_CODPRO) + ' - ' + AllTrim(BDX->BDX_DESPRO) + ' ]' 		+ CRLF
				cMsg += '- Sequencia [ ' + BDX->BDX_SEQUEN + ' ]'
				
				MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
				
				If RetCodUsr() $ GetMV('MV_XGETIN')
					lOk := MsgYesNo(cMsg + CRLF + CRLF + '- Libera็ใo T.I.: FORวAR?',AllTrim(SM0->M0_NOMECOM))
				EndIf
				
				//Leonardo Portella - 07/03/17 - Fim - Impedir reconsiderar glosa de n๚mero impresso
				
			EndCase
			
			BDX->(DbSkip())
			
		EndDo
		
	EndIf
	
	BDX->(RestArea(aAreaBDX))
	RestArea(aArea)
	
Return lOk

*****************************************************************************************************************************************************

//Leonardo Portella - 13/06/14 - Repasse Caberj/Integral pode reconsiderar tudo

User Function lPermRep(c_RDA)
	
Return ( ( cEmpAnt == '02' ) .and. ( c_RDA == '999997' ) )
*****************************************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCONVUNTREEบAutor  ณFabio Bianchini     บ Data ณ  07/01/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo que Converte Valor Apresentado do Reembolso         บฑฑ
ฑฑบ          ณ em valor unitแrio, pois na Versao 11 o Valor Apresentado   บฑฑ
ฑฑบ          ณ se Multiplica a Quantidade gerando uma Glosa Absurda.      บฑฑ
ฑฑบ          ณ Se aplica aos eventos Seriados. Para Anestesia nใo havera  บฑฑ
ฑฑบ          ณ impacto, pois sempre sera didivo por 1.  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAltera็ใo ณCONVUNTREEบAutor  ณFabio Bianchini     บ Data ณ  14/07/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Na Versใo 12 foi necessแrio tratar tamb้m a quantidade     บฑฑ
ฑฑบ          ณ As tabelas em que o valor ้ detalhado pela composi็ใo      บฑฑ
ฑฑบ          ณ estใo ficando diferente porque o usuario estแ mudando a    บฑฑ
ฑฑบ          ณ a quantidade ap๓s valorar								  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ Em 15/08/2019 foi retirado do X3_VALID de B45_QTDPRO e     บฑฑ
ฑฑบ          ณ B45_VLRAPR, pois o time de reembolso estava passando       บฑฑ  
ฑฑบ          ณ diversar vezes sobre o campo gerando valores unitarios     บฑฑ
ฑฑบ          ณ errados.													  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Caberj / Integral                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
/*User Function CONVUNTREE
Local lRet 
	
If (M->B45_VLRAPR > 0) .AND. (M->B45_QTDPRO > 0)  
	lRet := .T.
	M->B45_VLRAPR := ROUND(M->B45_VLRAPR/M->B45_QTDPRO,2)
Else
	lRet := .F.
	Alert ('A QUANTIDADE e o VALOR APRESENTADO UNITARIO devem ser maiores do que ZERO(0)!')
Endif
	
RETURN lRet*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldCadIntบAutor  ณValida็๕es Integral  บ Data ณ  07/01/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ          Integral                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VldCadInt(cAliasBA3,lValForCb)
	
	Local aErroDes := {}
	
	Private _cAliasBA3 := cAliasBA3
	Private _cCmpTpPag	:= ""
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณMotta teste                 ณ
	//ณvalida็ใo conforme parametroณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If cAliasBA3 = "M"
		_cCmpTpPag := _cAliasBA3+"->BA3_TIPPAG"
	Else
		_cCmpTpPag	:= Iif(Empty(&(_cAliasBA3+"->BA3_YTPPAG")),_cAliasBA3+"->BA3_TIPPAG",_cAliasBA3+"->BA3_YTPPAG")
	end if
	
	
	//Validacao de forma de pagamento preenchido...
	If Empty(&(_cCmpTpPag)) .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
		aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui tipo de pagamento cadastrado!","Necessแria manuten็ใo do cadastro"})
	Endif
	
	//Validacao de SISDEB sem dados bancarios corretos...
	If &(_cAliasBA3+"->BA3_GRPCOB") $ '0002,0003,0005,0006,0009' .And. &(_cCmpTpPag) $ '06' .And. (Empty(&(_cAliasBA3+"->BA3_BCOCLI")) .or. Empty(&(_cAliasBA3+"->BA3_AGECLI")) .or. Empty(&(_cAliasBA3+"->BA3_CTACLI")))
		aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" parametrizado como SISDEB por้m possui dados bancแrios invแlidos!","Necessแria manuten็ใo do cadastro"})
	Endif
	
	//Validacao de natureza em branco...
	If Empty(&(_cAliasBA3+"->BA3_NATURE")) .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
		aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui natureza cadastrada!","Necessแria manuten็ใo do cadastro"})
	Endif
	
	//Valida cliente em branco...
	If (Empty(&(_cAliasBA3+"->BA3_CODCLI")) .Or. Empty(&(_cAliasBA3+"->BA3_LOJA")) ) .And. &(_cAliasBA3+"->BA3_COBNIV") == "1"
		aadd(aErroDes,{"Familia "+&(_cAliasBA3+"->(BA3_CODINT+BA3_CODEMP+BA3_MATRIC)")+" nใo possui cliente e/ou loja do cliente!","Necessแria manuten็ใo do cadastro"})
	Endif
	
Return aErroDes



*****************************************************************************************************************************************************

//Leonardo Portella - 11/12/14 - Validacao do local de digitacao na inclusao da PEG

User Function ValLDP(cLDP)
	
	Local lOk 	:= .T.
	Local cMsg	:= ''
	
	Do Case
		
	Case cLDP == '0000'
		lOk := .F.
		cMsg := 'Local de digita็ใo 0000 (' + AllTrim(Posicione('BCG',1,xFilial('BCG') + M->BCI_CODLDP,'BCG_DESCRI')) + ')' + CRLF + CRLF + ;
			'Local exclusivo para interna็๕es geradas automaticamente pelo sistema'
		
	Case cLDP == '0002'
		lOk := .F.
		cMsg := 'Local de digita็ใo 0002 (' + AllTrim(Posicione('BCG',1,xFilial('BCG') + M->BCI_CODLDP,'BCG_DESCRI')) + ')' + CRLF + CRLF + ;
			'Local exclusivo para importa็ใo de guias TISS'
		
	Case cLDP == '0011'
		lOk := .F.
		cMsg := 'Local de digita็ใo 0011 (' + AllTrim(Posicione('BCG',1,xFilial('BCG') + M->BCI_CODLDP,'BCG_DESCRI')) + ')' + CRLF + CRLF + ;
			'Local exclusivo para importa็ใo de guias verdes TISS'
		
	Case cLDP  == '0015'
		lOk := .F.
		cMsg := 'Local de digita็ใo 0015 (' + AllTrim(Posicione('BCG',1,xFilial('BCG') + M->BCI_CODLDP,'BCG_DESCRI')) + ')' + CRLF + CRLF + ;
			'Local exclusivo para importa็ใo de guias TISS digitadas pela Medlink'
		
	Case cLDP  == '0016'
		lOk := .F.
		cMsg := 'Local de digita็ใo 0016 (' + AllTrim(Posicione('BCG',1,xFilial('BCG') + M->BCI_CODLDP,'BCG_DESCRI')) + ')' + CRLF + CRLF + ;
			'Local exclusivo para importa็ใo de guias de interna็ใo importadas (TISS 2.02.03) antes da virada de versใo para o Protheus 11'
		
	EndCase
	
	If !lOk
		cMsg += CRLF + CRLF + 'Nใo serแ permitida a inclusใo de PEG neste local de digita็ใo.'
		MsgStop(cMsg, AllTrim(SM0->M0_NOMECOM))
	EndIf
	
Return lOk


//Fabio Bianchini - 30/03/15
//Funcao que retorna tempo de plano do associado para Novas Regras de Renovacao (MATER E AFINIDADE)

User Function RetTempoPlano(cDatInc)
	
	Local cQry 			:= ''
	Local nIdadePla		:= 0
	
	cQry := " SELECT IDADE_S('"+cDatInc+"') IDADE FROM DUAL "
	
	TcQuery cQry New Alias c_Alias
	
	nIdadePla := (c_Alias->IDADE)
	
	c_Alias->(DbCloseArea())
	
Return nIdadePla


//Fabio Bianchini - 09/04/15
//Funcao que retorna .T. OU .F., CASO SEJA ENCONTRADO UM DETERMINADO OPCIONAL EM PELO MENOS UM DOS NIVEIS(USUARIO, FAMILIA, SUBCONTRATO OU PRODUTO SAUDE)
User Function ChkOpc(cCodint, cCodemp, cMatric, cTipreg, cConemp, cVercon, cSubcon, cVersub, cCodpla, cVerpla, cOpcional, cVeropc)
	
	Local lRet 	:= .F.
	Local cQry	:= " "
	
	//Primeiro nivel a Verificar - Nivel do Usuario (BF4)
	cQry := " SELECT COUNT(*) QTD FROM "+RetSQLName("BF4")+ " BF4 "
	cQry += " WHERE BF4_FILIAL = '"+xFilial("BF4")+"'"
	cQry += "   AND BF4_CODINT = '"+cCodint+"' "
	cQry += "   AND BF4_CODEMP = '"+cCodemp+"' "
	cQry += "   AND BF4_MATRIC = '"+cMatric+"' "
	cQry += "   AND BF4_TIPREG = '"+cTipreg+"' "
	cQry += "   AND BF4_CODPRO = '"+cOpcional+"' "
	cQry += "   AND BF4_DATBLO = ' ' "
	
	//--------------------------------------------------------------
	//Angelo Henrique - Data: 13/07/2017 - Chamado: 34205
	//--------------------------------------------------------------
	//Incluindo a valida็ใo do tipo de vinculo, pois estava sempre
	//vindo com ADU para as carteirinhas
	//--------------------------------------------------------------
	cQry += "   AND BF4_TIPVIN = '1' "
	//--------------------------------------------------------------
	
	
	cQry += "   AND BF4.D_E_L_E_T_ = ' ' "
	
	TcQuery cQry New Alias c_Alias
	
	lRet := c_Alias->QTD > 0
	
	c_Alias->(DbCloseArea())
	
	If !lRet
		//Segundo nivel a Verificar - Nivel da Familia (BF1)
		cQry := " SELECT COUNT(*) QTD FROM "+RetSQLName("BF1")+ " BF1 "
		cQry += " WHERE BF1_FILIAL = '"+xFilial("BF1")+"'"
		cQry += "   AND BF1_CODINT = '"+cCodint+"' "
		cQry += "   AND BF1_CODEMP = '"+cCodemp+"' "
		cQry += "   AND BF1_MATRIC = '"+cMatric+"' "
		cQry += "   AND BF1_CODPRO = '"+cOpcional+"' "
		cQry += "   AND BF1_DATBLO = ' ' "
		
		//--------------------------------------------------------------
		//Angelo Henrique - Data: 13/07/2017 - Chamado: 34205
		//--------------------------------------------------------------
		//Incluindo a valida็ใo do tipo de vinculo, pois estava sempre
		//vindo com ADU para as carteirinhas
		//--------------------------------------------------------------
		cQry += "   AND BF1_TIPVIN = '1' "
		//--------------------------------------------------------------
		
		cQry += "   AND BF1.D_E_L_E_T_ = ' ' "
		
		TcQuery cQry New Alias c_Alias
		
		lRet := c_Alias->QTD > 0
		
		c_Alias->(DbCloseArea())
	Endif
	
	If !lRet
		//Terceiro nivel a Verificar - Nivel do Subcontrato (BHS) - OPCIONAIS VINCULADOS
		cQry := " SELECT COUNT(*) QTD FROM "+RetSQLName("BHS")+ " BHS "
		cQry += " WHERE BHS_FILIAL = '"+xFilial("BHS")+"'"
		cQry += "   AND BHS_CODINT = '"+cCodint+"' "
		cQry += "   AND BHS_CODIGO = '"+cCodemp+"' "
		cQry += "   AND BHS_NUMCON = '"+cConemp+"' "
		cQry += "   AND BHS_VERCON = '"+cVercon+"' "
		cQry += "   AND BHS_SUBCON = '"+cSubcon+"' "
		cQry += "   AND BHS_VERSUB = '"+cVersub+"' "
		cQry += "   AND BHS_CODPRO = '"+cOpcional+"' "
		cQry += "   AND BHS_VERPRO = '"+cVerpla+"' "
		cQry += "   AND BHS_TIPVIN = '1' "
		cQry += "   AND BHS.D_E_L_E_T_ = ' ' "
		
		TcQuery cQry New Alias c_Alias
		
		lRet := c_Alias->QTD > 0
		
		c_Alias->(DbCloseArea())
	Endif
	
	If !lRet
		//Quarto nivel a Verificar - Nivel do Produto Saude (BT3) - OPCIONAIS VINCULADOS
		cQry := " SELECT COUNT(*) QTD FROM "+RetSQLName("BT3")+ " BT3 "
		cQry += " WHERE BT3_FILIAL = '"+xFilial("BT3")+"'"
		cQry += "   AND SUBSTR(BT3_CODIGO,1,4) = '"+cCodint+"' "
		cQry += "   AND SUBSTR(BT3_CODIGO,5,4) = '"+cCodpla+"' "
		cQry += "   AND BT3_VERSAO = '"+cVerpla+"' "
		cQry += "   AND BT3_CODPLA = '"+cOpcional+"' "
		cQry += "   AND BT3_VERPLA = '"+cVeropc+"' "
		cQry += "   AND BT3_TIPVIN = '1' "
		cQry += "   AND BT3.D_E_L_E_T_ = ' ' "
		
		TcQuery cQry New Alias c_Alias
		
		lRet := c_Alias->QTD > 0
		
		c_Alias->(DbCloseArea())
	Endif
	
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑฑ
ฑฑณFuncao    ณ nCalcIdade ณ Autor ณ Fabio Bianchini     ณ Data ณ 04.03.15 ณฑฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑฑ
ฑฑณDescricao ณ Calcula Idade. Copia de fCalcIdade, do CABA007             ณฑฑฑ
ฑฑณ          ณ                                                            ณฑฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
//CALCULA A IDADE
User function nCalcIdade( dataN )
	
	Local Idade	:= 0
	
	Idade:=year(DATE())-year(dataN)
	
	if (((month(dataN)*100) + day(dataN))> ((month(DATE())*100)+day(date())))
		
		Idade:=Idade-1
		
	endif
	
Return Idade

*****************************************************************************************************************************************************

//Leonardo Portella - 16/06/15 - Validacao do solicitante

User Function ValSol(cTabela)
	
	Local lOk 		:= .T.
	Local cSigla	:= 'M->' + cTabela + '_SIGLA'
	
	cSigla := &cSigla
	cSigla := Upper(cSigla)
	
	//Leonardo Portella - 26/06/15 - Comentado ate a diretoria definir se a regra sera ou nao aplicada.
	//Vide circular 007/2007
	/*
	If !empty(cSigla) .and. !( cSigla $ 'CRM|CRO' )
		lOk := .F.
		MsgStop('Somente CRM ou CRO podem ser solicitantes!', AllTrim(SM0->M0_NOMECOM))
	EndIf
	*/
	
Return lOk

*****************************************************************************************************************************************************
//Sergio Cunha - 20/10/15 - Validacao do centro de custo PA

User Function ValPaCc(Ccustos)
	
	/*u_ValPaCc(m->ZX_YCUSTO)*/
	
	Local c_ent		:= CHR(13) + CHR(10)
	Local lOk 		:= .T.
	Local cCCusto	:= ALLTRIM(Ccustos)
	Local cUserLog  := cUserName
	Local cArea     := GetNextAlias()
	
	PswOrder(2)
	PswSeek(cUserLog)
	aUsuario := PswRet()
	c_Matric := aUsuario [1,22]
	cQuery := "SELECT CTT.CTT_CUSTO CC"	+c_ent
	cQuery += "FROM SRA010 SRA, CTT010 CTT" +c_ent
	cQuery += "WHERE TRIM(SRA.RA_CC) = TRIM(CTT.CTT_CUSTO)     " +c_ent
	cQuery += "AND SRA.RA_MAT = '"+SUBSTR(c_Matric,5,10)+"'    " +c_ent
	cQuery += "AND CTT.D_E_L_E_T_ <> '*' AND SRA.D_E_L_E_T_ <> '*' " +c_ent
	
	If Select((cArea)) <> 0
		(cArea)->(DbCloseArea())
	Endif
	
	PlsQuery(cQuery,cArea)
	
	If !(cArea)->(Eof())
		
		if ALLTRIM((cArea)->CC) <> cCCusto
			Alert('Somente usuแrios do mesmo centro de custo possuem permissใo para altera็ใo de status do Protocolo de Atendimento.')
			lOk := .F.
		endif
		
	Else
		
		Alert('Usuแrio sem matrํcula vinculada em seu cadastro, contactar a TI para ajuste.')
		
	endif
	
Return lOk

*****************************************************************************************************************************************************



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFUNCOES   บAutor  ณMicrosiga           บ Data ณ  11/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
/*
User Function AltBe4Ad
	
	DbselectArea("BE4")
	DbSetOrder(1)
	DbGoTop()
	
	While !EOF() .And.
		
		
		
		BE4->(DbSkip()
		
	EndDo
	
Return

*/

*******************************************************************************************************************************

//Leonardo Portella - 14/04/16 - Validar o campo BCI_YPTREM contra o Protocolo de Remessa

User Function lPEGxProRem
	
	Local lOk 			:= .T.
	Local aArea			:= GetArea()
	Local cAlias
	Local cQry
	
	If empty(M->BCI_YPTREM)
		
		MsgStop('Informe o protocolo de remessa da PEG [ Aba "Outros" > Campo "Prot. Remes." (BCI_YPTREM) ]',AllTrim(SM0->M0_NOMECOM))
		lOk := .F.
		
	Else
		
		cAlias 	:= GetNextAlias()
		
		cQry	:= "SELECT 1" 													+ CRLF
		cQry 	+= "FROM " + RetSqlName("ZZP") + " ZZP"							+ CRLF
		cQry 	+= "WHERE ZZP_FILIAL = '" + xFilial("ZZP") + "'"				+ CRLF
		cQry 	+= "	AND ZZP_CODRDA = '" + M->BCI_CODRDA + "'"				+ CRLF
		cQry 	+= " 	AND ZZP_NUMREM = '" + cValToChar(M->BCI_YPTREM) + "'"	+ CRLF
		cQry 	+= "	AND D_E_L_E_T_ = ' '"									+ CRLF
		
		TcQuery cQry New Alias cAlias
		
		If cAlias->(EOF())
			
			lOk := .F.
			MsgStop('Protocolo de remessa informado [ ' + M->BCI_YPTREM + ' ] nใo existe para o prestador [ ' + M->BCI_CODRDA + ' ]',AllTrim(SM0->M0_NOMECOM))
			
		EndIf
		
		cAlias->(DbCloseArea())
		
	EndIf
	
	RestArea(aArea)
	
Return lOk
****************************************************************************************************************************************************
///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | ListBox.prw          | AUTOR | SERGIO CUNHA | DATA | 01/08/2017 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_ListBox()                                            |//
//|           | Funcao que demonstra a utilizacao de listbox                    |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR SERGIO CUNHA   | DESCRICAO LISTA COMPOSICAO PGTO REEMBOLSO |//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////

User Function Lbxreem()
	Local aSalvAmb := {}
	Local cVar     := Nil
	Local oDlg     := Nil
	Local cTitulo  := "TIPO PGTO REEMBOLSO"
	Local lMark    := .F.
	Local oOk      := LoadBitmap( GetResources(), "LBOK" )		//carrega bitmap quadrado com X
	Local oNo      := LoadBitmap( GetResources(), "LBNO" )		//carrega bitmap soh o quadrado
	//pode ser usado o LBCHECK - Coloca o visto
	Local oChk     := Nil
	
	Private lChk     := .F.
	Private oLbx := Nil
	Private aVetor := {}
	
	PUBLIC ZZQRETTP := ""
	
	dbSelectArea("SX5")
	aSalvAmb := GetArea()
	dbSetOrder(1)
	dbSeek(xFilial("SX5")+"Z4")
	
	//+-------------------------------------+
	//| Carrega o vetor conforme a condicao |
	//+-------------------------------------+
	While !Eof() .And. SX5->X5_TABELA =="Z4"
		If Alltrim(M->ZZQ_TIPPRO) == SUBSTR(SX5->X5_CHAVE,1,1)
			aAdd( aVetor, {.F., alltrim(SX5->X5_DESCRI)} )
		EndIf
		dbSkip()
	End
	
	//+-----------------------------------------------+
	//| Monta a tela para usuario visualizar consulta |
	//+-----------------------------------------------+
	If Len( aVetor ) == 0
		Aviso( cTitulo, "Nใo existe dados a consultar", {"Ok"} )
		Return
	Endif
	
	DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL
	
	@ 10,10 LISTBOX oLbx VAR cVar FIELDS HEADER ;
		" ", "TIPO_REEMBOLSO";  	//nome do cabecalho
	SIZE 230,095 OF oDlg PIXEL ON dblClick(aVetor[oLbx:nAt,1] := !aVetor[oLbx:nAt,1],oLbx:Refresh())
	
	//se houver duplo clique, recebe ele mesmo negando, depois da um refresh
	
	oLbx:SetArray( aVetor )
	oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),;
		aVetor[oLbx:nAt,2]}}
	
	//marca ou desmarca TUDO, chama funcao MARCA
	@ 110,10 CHECKBOX oChk VAR lChk PROMPT "Marca/Desmarca" SIZE 60,007 PIXEL OF oDlg;
		ON CLICK(Iif(lChk,Marca(lChk),Marca(lChk)))
	
	DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION { || Retlist( aVetor ), oDlg:End() } ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg CENTER
	RestArea( aSalvAmb )
	
	//alert( ZZQRETTP )
	
Return .T.

///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | ListBoxMark.prw      | AUTOR | Robson Luiz  | DATA | 18/01/2004 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_ListBoxMar()                                         |//
//|           | Fonte utilizado no curso oficina de programacao.                |//
//|           | Funcao que marca ou desmarca todos os objetos                   |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
Static Function Marca(lMarca)
	Local i := 0
	//marca ou desmarca todos os itens
	For i := 1 To Len(aVetor)
		aVetor[i][1] := lMarca
	Next i
	oLbx:Refresh()
Return

Static Function Retlist( aVetor )
	
	For nCount:= 1 to Len( aVetor )
		
		If aVetor[nCount][1]
			
			ZZQRETTP += alltrim(aVetor[nCount][2]) + " ,"
			
		EndIf
		
	Next
	
	ZZQRETTP := substr(ZZQRETTP, 1, len( ZZQRETTP ) - 1 )
	
Return

****************************************************************************************************************************************************
/*
///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | VldPerPa.prw       | AUTOR | Fabio Bianchini| DATA | 08/11/2018 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_vldperpa()                                           |//
//|           | Funcao que serแ usada no gatilho  do campo BLE_YPERPR           |//
//|           | para validar os percentuais da composi็ใo do pacote				|//
//|           | Nใo pode ultrapassar os 100%									|//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR 			    | DESCRICAO 								|//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
User Function VldPerPa(pCodpad, pCodpro)

Local aArea	  := GetArea()
Local cQry    := ""
Local cAlias  := GetNextAlias() 
Local nValor  := 0

DbSelectArea("BLE")
DbSetOrder(1)
BLE->(DbGoTop())

If DbSeek(xFilial("BLE")+PLSINTPAD()+pCodpad+pCodpro)

	While !BLE->(EOF()) .and. BLE->(BLD_CODPAD+BLD_CODPRO) == pCodpad+pCodpro
	
		BLE->(DbSkip())
	Enddo 
Endif

RestArea(aArea)

Return 

****************************************************************************************************************************************************
///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | CalPerPa.prw       | AUTOR | Fabio Bianchini| DATA | 08/11/2018 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_calperpa()                                           |//
//|           | Funcao que serแ usada no gatilho  do campo BLE_YPERPR           |//
//|           | para povoar o campo BLE_VALFIX, com base no valor da TDE        |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR 			    | DESCRICAO 								|//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
User Function CalPerPa(pCodpad, pCodpro)

Local aArea	  := GetArea()
Local cQry    := ""
Local cAlias  := GetNextAlias() 
Local nValor  := 0

cQry	:= "SELECT BD4_VALREF " + CRLF
cQry 	+= "  FROM "+RetSqlName("BD4")+" BD4 " + CRLF
cQry 	+= " WHERE BD4_FILIAL = '"+xFilial("BD4")+"'" + CRLF
cQry 	+= "   AND BD4_CDPADP = '"+pCodpad+"'" + CRLF
cQry 	+= "   AND BD4_CODPRO = '"+AllTrim(pCodpro)+"'" + CRLF
cQry 	+= "   AND BD4_CODIGO = 'REA' " + CRLF
cQry 	+= "   AND BD4_VIGFIM = ' '   " + CRLF
cQry 	+= "   AND D_E_L_E_T_ = ' '   " + CRLF

TcQuery cQry New Alias cAlias

If cAlias->(EOF())
	
	MsgStop('Procedimento '+pCodpad+'-'+pCodpro+' nใo encontrado na TDE!')
	
Else

	nValor := cAlias->(BD4_VALREF) * M->BLE_YPERPR/100
	
EndIf

cAlias->(DbCloseArea())

RestArea(aArea)

Return nValor
*/

/*/
///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | uPLSA001BB0.prw    | AUTOR | Fabio Bianchini| DATA | 08/11/2018 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_uPLSA001BB0()                                        |//
//|           | Esta funcao substituirแ provisoriamente a fun็ใo padrใo         |//
//|           | PLSA001BB0 no X3_RELACAO do campo B45_NOMSOL                    |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR 			    | DESCRICAO 								|//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
/*/
User Function uPLA001BB0(cBusca)

	Local cRetorno := ""
	
	BB0->( DbSetOrder(4) ) //BB0_FILIAL + BB0_CODIGO
	BB0->( MsSeek( xFilial("BB0") + cBusca ) )

	If BB0->(Found())
		if(cBusca == BB0->BB0_ESTADO + BB0->BB0_NUMCR + BB0->BB0_CODSIG)
			cRetorno := BB0->BB0_NOME
		endif 
	endif

Return(cRetorno)

/*/
///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | uAlterWhen.prw    | AUTOR | Fabio Bianchini| DATA | 08/11/2018  |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_uAlterWhen()                                         |//
//|           | Esta funcao substituirแ provisoriamente a fun็ใo padrใo         |//
//|           | AlterWhen no X3_WHEN dos campos B45_FADENT e B45_DENREG         |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR 			    | DESCRICAO 								|//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
/*/
user function uAlterWhen()

LOCAL cOdonto:= Posicione("BR8",1,xFilial("BR8") + M->B45_CODPAD + M->B45_CODPRO, "BR8_ODONTO")

If cOdonto == "1"
	Return .T.
Else
	Return .F.
EndIf

Return .F.

/*/
///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | uAtuCmp.prw       | AUTOR | Fabio Bianchini| DATA | 08/11/2018  |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_uAtuCmp()                                            |//
//|           | Esta funcao substituirแ provisoriamente a fun็ใo padrใo         |//
//|           | AtuCmp no X3_VALID do campo B45_CODPRO                          |//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR 			    | DESCRICAO 								|//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
/*/
user function uAtuCmp()

If Readvar() == "M->B45_CODPRO"
	M->B45_DENREG := Space(TamSx3("B45_DENREG")[1])
	M->B45_DESREG := Space(TamSx3("B45_DESREG")[1])
	M->B45_FADENT := Space(TamSx3("B45_FADENT")[1])
	M->B45_FACDES := Space(TamSx3("B45_FACDES")[1])

	//If !EMPTY(M->B44_PROTOC)
	If !EMPTY(M->B44_YCDPTC)
		M->B45_NOMSOL := Posicione("BB0",4,xFilial("BB0")+B1N->B1N_ESTSOL+B1N->B1N_REGSOL+B1N->B1N_SIGLA,"BB0_NOME")
	EndIf
EndIf

Return .T.

/*/
///////////////////////////////////////////////////////////////////////////////////
//+-----------------------------------------------------------------------------+//
//| PROGRAMA  | uBuscaCBO.prw      | AUTOR | Fabio Bianchini| DATA | 26/04/2019 |//
//+-----------------------------------------------------------------------------+//
//| DESCRICAO | Funcao - u_uBuscaCBO()                                          |//
//|           | Esta funcao busca o CBO na tabela BAQ.  Se for Especialidade 097|//
//|           | (Clinica Medica) ou 099 (Casa d eSaude Hospital), o sistema nใo	|//
//|           | gatilharแ e emitirแ um alerta solicitando o devido preenchimento|//
//|           | 																|//
//|           | Conforme Definido com o Max, em 26/04/2019, pegaremos o primeiro|//
//|           | CBOS da lista, se houver mais de um.  O Sistema jแ traz a 		|//
//|           | especialidade principal.										|//
//+-----------------------------------------------------------------------------+//
//| MANUTENCAO DESDE SUA CRIACAO                                                |//
//+-----------------------------------------------------------------------------+//
//| DATA     | AUTOR 			    | DESCRICAO 								|//
//+-----------------------------------------------------------------------------+//
//|          |                      |                                           |//
//+-----------------------------------------------------------------------------+//
///////////////////////////////////////////////////////////////////////////////////
/*/
User Function uBuscaCBO()
Local aAreaBAQ := BAQ->(GetArea())
Local cQry := ""
Local cAlias := GetNextAlias()
Local cRet := ""

	cQry := " SELECT BAQ_CBOS " + cEnt 
	cQry += "   FROM " + RetSqlName("BAQ") + " BAQ "  + cEnt  
	cQry += "  WHERE BAQ_FILIAL = '" + xFilial("BAQ") + "'" + cEnt
	cQry += "    AND BAQ_CODINT = '" + PLSINTPAD()    + "'" + cEnt
	cQry += "    AND BAQ_CODESP = '" + M->BD5_CODESP  + "'" + cEnt
	cQry += "    AND D_E_L_E_T_ = ' ' " + cEnt
	cQry += "    AND ROWNUM = 1 "  + cEnt
	
	TcQuery cQry New Alias cAlias
	
	If cAlias->(EOF())
		MsgStop('CBOS nใo encontrado para a Especialidade ' + M->BD5_CODESP + '.  Favor Contactar a GERED!')
	Else
		cRet := cAlias->(BAQ_CBOS)
	EndIf
	
	cAlias->(DbCloseArea())

RestArea(aAreaBAQ)
Return cRet

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFabio Bianchini - 10/02/15                                            ณ
//ณBusca Grupo de Cobertura referente ao procedimento					 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
User Function BuscaGrupCob(cOpeAtu, cCodpad, cCodpro)
		
	Local cQry 			:= ''
	Local cCodGru		:= ''
	Local c_Alias		:= GetNextAlias()

	cQry := "SELECT BG8_CODGRU " 															+ CRLF
	cQry += "FROM " + RetSqlName('BG8') + " BG8 " 											+ CRLF
	cQry += "WHERE BG8_FILIAL = '" + xFilial('BG8') + "'" 									+ CRLF
	cQry += "  AND BG8_CODINT = '" + cOpeAtu + "'" 											+ CRLF
	cQry += "  AND BG8_CODPAD = '" + cCodpad + "'" 											+ CRLF
	cQry += "  AND BG8_CODPSA = '" + cCodpro + "'" 											+ CRLF
	cQry += "  AND BG8_BENUTL = '1' "			 											+ CRLF
	cQry += "  AND BG8.D_E_L_E_T_ = ' '" 													+ CRLF
		
		//Leonardo Portella - 23/02/15 - Inicio - Evitar erro de "Alias already in use"
		
		//PlsQuery(cQry,"TRB")
	TcQuery cQry New Alias c_Alias
		
		//cCodGru := ( TRB->BG8_CODGRU )
	cCodGru := ( c_Alias->BG8_CODGRU )
		
		//TRB->(DbCloseArea())
	c_Alias->(DbCloseArea())
		
		//Leonardo Portella - 23/02/15 - Fim
Return cCodGru

/*
FUNวรO BASEADA NA PLS260BLQ
09/07/2019
FABIO BIANCHINI
CHAMADA NO X3_INIBRW DE BA1_DESBLO
RETIRANDO O IF !INCLUI
*/

User Function Cab260Blq()

Local cDescri := ""

If BA1->BA1_DATBLO <> ctod("")
	If BA1->BA1_CONSID == "U"
		cDescri := Posicione("BG3",1,xFilial("BG3")+BA1->BA1_MOTBLO,"BG3_DESBLO")
	Elseif BA1->BA1_CONSID == "F"
		cDescri := Posicione("BG1",1,xFilial("BG1")+BA1->BA1_MOTBLO,"BG1_DESBLO")
	Elseif BA1->BA1_CONSID == "S"
		cDescri := Posicione("BQU",1,xFilial("BQU")+BA1->BA1_MOTBLO,"BQU_DESBLO")
	Endif
Endif

Return(cDescri)

User Function uValEmp(cMatric)
Local cHtml := ""
Local cRet  := .T.

If (cEmpAnt == "02") .AND. (SUBS(cMatric,5,4) == '0325')
	cHtml := '<b><font color="#FF0000">EMPRESA 0325 - CASA DA MOEDA DO BRASIL</font></b>'
	cHtml += '<br><b><font color="#FF0000">** FAVOR NรO UTILIZAR O CAMPO TIPO DE REEMBOLSO **</font></b>'
	Alert(cHtml)
Endif

Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCritRecob บAutor  ณJean Schulz         บ Data ณ  12/02/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se houve recobranca e envia para a conferencia...  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

//Static Function CritRecob(cChaveBD6,dDatGui,aCrit,aRetF)
User Function CritRecob(cChaveBD6,dDatGui,aCrit,aRetF,cCodRda,cOpeUsr,cCodEmp,cMatric,cTipReg)

	Local cNivel    := aRetF[3] //Nunca Alterar (Falha na cobranca de copart)...
	Local cChaAut	:= aRetF[4] //Nunca Alterar (Falha na cobranca de copart)...
	//Bianchini - 18/10/2018 - RDM 315 - Variaveis (Inicio)
	Local cCodOpe	:= Subs(cChaveBD6,1,4)
	Local cCodLdp	:= Subs(cChaveBD6,5,4)
	Local cCodPeg	:= Subs(cChaveBD6,9,8)
	Local cNumGui	:= Subs(cChaveBD6,17,8)
	Local cOriMov	:= Subs(cChaveBD6,25,1)
	Local cCodPad	:= Subs(cChaveBD6,26,2)
	Local cCodPro	:= AllTrim(Subs(cChaveBD6,28,16))
	Local cQry 		:= ""
	Local cAliasBD6	:= GetNextalias()
	Local cCodCri   := "702"
	Local cDesCri   := "COBRANวA DE PROCEDMENTO EM DUPLICIDADE: "
	Local lRepetido := .F.
	//Bianchini - 18/10/2018 - RDM 315 - Variaveis (Fim)

	//Bianchini - 18/10/2018 - RDM 315 - Modificado o crit้rio de Crํticas para que seja glosado proce-
	//dimento repetido nใo s๓ dentro da mesma guia, como em outras guias, desde que nใo tenha havido glosa previamente
	cQry := " SELECT BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPAD, " +CRLF
	cQry += "        BD6_CODPRO, BD6_CODRDA, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_NOMUSR, BD6_DATPRO  " +CRLF
	cQry += "   FROM "+RetSqlName("BD5")+" BD5, "  +RetSqlName("BD6")+" BD6 " +CRLF
	cQry += "  WHERE BD6_FILIAL = '"+xFilial("BD6")+"' " +CRLF
	cQry += "    AND BD5_FILIAL = BD6_FILIAL " +CRLF
	cQry += "    AND BD5_CODOPE = BD6_CODOPE " +CRLF
	cQry += "    AND BD5_CODPEG = BD6_CODPEG " +CRLF
	cQry += "    AND BD5_NUMERO = BD6_NUMERO " +CRLF
	cQry += "    AND BD5_ORIMOV = BD6_ORIMOV " +CRLF
	cQry += "    AND BD5_CODRDA = BD6_CODRDA " +CRLF
	cQry += "    AND BD5_GUESTO = ' ' " +CRLF
	cQry += "    AND BD6_CODOPE = '"+cCodOpe+"' " +CRLF
	cQry += "    AND BD6_CODRDA = '"+cCodRda+"' " +CRLF
	cQry += "    AND BD6_OPEUSR = '"+cOpeUsr+"' " +CRLF
	cQry += "    AND BD6_CODEMP = '"+cCodEmp+"' " +CRLF
	cQry += "    AND BD6_MATRIC = '"+cMatric+"' " +CRLF
	cQry += "    AND BD6_TIPREG = '"+cTipReg+"' " +CRLF
	cQry += "    AND BD6_CODPAD = '"+cCodPad+"' " +CRLF
	cQry += "    AND BD6_CODPRO = '"+cCodPro+"' " +CRLF
	cQry += "    AND BD6_VLRGLO = 0 " +CRLF	
	cQry += "    AND BD6_BLOPAG <> '1' " +CRLF
	cQry += "    AND BD6_SITUAC IN ('1','3') " +CRLF
	cQry += "    AND BD6_CODLDP NOT IN ('0000','0010','0017','0020','9999') " +CRLF
	cQry += "    AND BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO||BD6_ORIMOV <> '"+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV)+"'" +CRLF
	cQry += "    AND BD6.D_E_L_E_T_ = ' ' " +CRLF
	cQry += "    UNION " +CRLF
	cQry += " SELECT BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPAD, " +CRLF
	cQry += "        BD6_CODPRO, BD6_CODRDA, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_NOMUSR, BD6_DATPRO  " +CRLF
	cQry += "   FROM ( " +CRLF
	cQry += " 			SELECT COUNT(BD6_CODPAD||BD6_CODPRO), BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPAD, " +CRLF
	cQry += "        		   BD6_CODPRO, BD6_CODRDA, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_NOMUSR, BD6_DATPRO  " +CRLF
	cQry += "   		  FROM "+RetSqlName("BD6")+" BD6 " +CRLF
	cQry += "  			 WHERE BD6_FILIAL = '"+xFilial("BD6")+"' " +CRLF
	cQry += "    		   AND BD6_CODOPE = '"+cCodOpe+"' " +CRLF
	cQry += "    		   AND BD6_CODRDA = '"+cCodRda+"' " +CRLF
	cQry += "    		   AND BD6_OPEUSR = '"+cOpeUsr+"' " +CRLF
	cQry += "    		   AND BD6_CODEMP = '"+cCodEmp+"' " +CRLF
	cQry += "    		   AND BD6_MATRIC = '"+cMatric+"' " +CRLF
	cQry += "    		   AND BD6_TIPREG = '"+cTipReg+"' " +CRLF
	cQry += "    		   AND BD6_CODPAD = '"+cCodPad+"' " +CRLF
	cQry += "    		   AND BD6_CODPRO = '"+cCodPro+"' " +CRLF
	cQry += "    		   AND BD6_VLRGLO = 0 " +CRLF	
	cQry += "    		   AND BD6_BLOPAG <> '1' " +CRLF
	cQry += "    		   AND BD6_SITUAC IN ('1','3') " +CRLF
	cQry += "    		   AND BD6_CODLDP NOT IN ('0000','0010','0017','0020','9999') " +CRLF
	cQry += "    		   AND BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO||BD6_ORIMOV = '"+BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV)+"'" +CRLF
	cQry += "    		   AND BD6.D_E_L_E_T_ = ' ' " +CRLF
	cQry += "    		 GROUP BY BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPAD, " +CRLF
	cQry += "        			  BD6_CODPRO, BD6_CODRDA, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_NOMUSR, BD6_DATPRO " +CRLF
	cQry += " 			HAVING COUNT(BD6_CODPAD||BD6_CODPRO) > 1 " +CRLF
	cQry += "        ) " +CRLF
	cQry += "  ORDER BY BD6_CODOPE, BD6_CODLDP, BD6_CODPEG, BD6_NUMERO, BD6_ORIMOV, BD6_SEQUEN, BD6_CODPAD, BD6_CODPRO, BD6_DATPRO DESC " +CRLF

	MEMOWRITE('c:\temp\critrecob.sql',cQry)

	If Select(cAliasBD6)>0
		(cAliasBD6)->(DbCloseArea())
	EndIf

	DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),cAliasBD6,.T.,.T.)

	DbSelectArea(cAliasBD6)

	While !(cAliasBD6)->(EOF())
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Em todas as guias de servicos, buscar o procedimento ja cobrado...       ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If BR8->(FieldPos("BR8_YPDREC")) > 0
			cPodRep	:= BR8->BR8_YPDREC
		Else
			cPodRep := "0"
		EndIf

		If cPodRep <> "1" .and. Alltrim(FunName()) <> "PLSA001" .and. (cAliasBD6)->(BD6_DATPRO) == DTOS(BD6->BD6_DATPRO)
			cNivel := "BD5"//aRetF[3] //Nunca Alterar (Falha na cobranca de copart)...
			aAdd(aCrit,{ cCodCri,;
			cDesCri,; 
			(cAliasBD6)->(BD6_CODLDP) + "." + (cAliasBD6)->(BD6_CODPEG) + "." + (cAliasBD6)->(BD6_NUMERO) + "-" + (cAliasBD6)->(BD6_SEQUEN),;
			BCT->BCT_NIVEL,;
			BCT->BCT_TIPO,;
			cCodPad,;
			cCodPro;
			})

			aRetF := {.F.,aCrit,cNivel,cChaAut,.F.}
		EndIf
		(cAliasBD6)->(DbSkip())
	Enddo
	(cAliasBD6)->(DbCloseArea())

	If !Empty(aCrit)
		lRepetido := .T.
	Endif

Return lRepetido

///////////

User Function APROVCOM(cPref, cNum, cParc, cTipo , cFornec)
		
	Local cQry 			:= ''
	Local cCodGru		:= ''
	Local c_Alias		:= GetNextAlias()
	local lRet          := .F.

	cQry := CRLF + "    SELECT COUNT(*) QTDA "
    cQry += CRLF + "      FROM siga."+RetSQLName("PDT")+" PDT  "
    cQry += CRLF + "     WHERE PDT_FILIAL = '" + xFilial('PDT') + "' 
    cQry += CRLF + "       AND D_e_l_e_t_ = ' ' "
    cQry += CRLF + "       AND PDT_PREFIX = '"+cPref+"'"
    cQry += CRLF + "       AND PDT_NUM    = '"+cNum+"'"
    cQry += CRLF + "       AND PDT_PARCEL = '"+cParc+"'"
    cQry += CRLF + "       AND PDT_TIPO   = '"+cTipo+"'"
    cQry += CRLF + "       AND PDT_FORNEC = '"+cNum+"'"
    cQry += CRLF + "       and pdt_aprov  = '000047' " 

	TcQuery cQry New Alias (c_Alias)
		
	If (c_Alias)->QTDA > 0
	 
	   lRet          := .T.
	
	EndIf 	
		
	(c_Alias)->(DbCloseArea())
		
Return (lRet)

User Function fCalcTx( nValPag, c_CodEmp, c_Matric, c_TipRg, cTipoTaxa, cCodRDA  )

	Local n_Tx := 0
	Local c_Qry
	Local aAreaBAU := BAU->(GetArea())

	If Empty(cTipoTaxa)
		cTipoTaxa := "R"
	Endif

	If cTipoTaxa == "R"

		c_Qry := " SELECT C.* "
		c_Qry += " FROM " + RETSQLNAME("BA1") + " A, " + RETSQLNAME("BA0") + " B, " + RETSQLNAME("BGH") + " C "
		c_Qry += " WHERE BA1_FILIAL = '" + XFILIAL("BA1") + "' "
		c_Qry += " AND BA1_CODINT = '0001' "
		c_Qry += " AND BA1_CODEMP = '" + c_CodEmp + "' "
		c_Qry += " AND BA1_MATRIC = '" + c_Matric + "' "
		c_Qry += " AND BA1_TIPREG = '" + c_TipRg  + "' "
		c_Qry += " AND ( BGH_DATFIN >= '" + DtoS( dDataBase ) + "' or BGH_DATFIN = ' ' ) " // Marcela Coimbra
		c_Qry += " AND BA1_OPEORI = BA0_CODIDE||BA0_CODINT  "
		c_Qry += " AND BA0_GRUOPE = BGH_GRUOPE  "
		c_Qry += " AND A.D_E_L_E_T_ = ' '  "
		c_Qry += " AND B.D_E_L_E_T_ = ' '  "
		c_Qry += " AND C.D_E_L_E_T_ = ' '  "

	ElseIf cTipoTaxa == "P"

		BAU->(DbSetOrder(1))
		BAU->(DbSeek(xFilial("BAU")+cCodRda))

		c_Qry := " SELECT C.* "
		c_Qry += " FROM " + RETSQLNAME("BAU") + " A, " + RETSQLNAME("BA0") + " B, " + RETSQLNAME("BGH") + " C "
		c_Qry += " WHERE BAU_FILIAL = '" + XFILIAL("BAU") + "' "
		c_Qry += " AND BAU_CODOPE = '"+ BAU->BAU_CODOPE +"' "
		c_Qry += " AND BAU_CODIGO = '"+ cCodRDA +"' "
		c_Qry += " AND BAU_TIPPRE = 'OPE' "
		c_Qry += " AND ( BGH_DATFIN >= '" + DtoS( dDataBase ) + "' or BGH_DATFIN = ' ' ) " // Marcela Coimbra
		c_Qry += " AND BAU_CODOPE = BA0_CODIDE||BA0_CODINT  "
		c_Qry += " AND BA0_GRUOPE = BGH_GRUOPE  "
		c_Qry += " AND A.D_E_L_E_T_ = ' '  "
		c_Qry += " AND B.D_E_L_E_T_ = ' '  "
		c_Qry += " AND C.D_E_L_E_T_ = ' '  "

	Endif

	TcQuery c_Qry Alias "TMPTX" New

	If !TMPTX->( EOF() )

		//**'Marcela Coimbra Inicio- Mudado o campo para pegar o valor da taxa a receber ao inv้s da taxa a pagar'**
		//Bianchini - 22/05/2019 - Criada essa condi็ใo descomentando o trecho que a Marcela Comentou porque na V12 preciso dos 2 valores
		If cTipoTaxa == "P"
			n_Tx := TMPTX->BGH_VLRTAX // (nValPag * TMPTX->BGH_VLRTAX ) / 100
		Else
			n_Tx := TMPTX->BGH_VLRTRC // (nValPag * TMPTX->BGH_VLRTAX ) / 100
		Endif
		//**'Marcela Coimbra FIM - Mudado o campo para pegar o valor da taxa a receber ao inv้s da taxa a pagar'**

		//Leonardo Portella - 19/07/13 - Fim

	EndIf

	TMPTX->( dbCloseArea() )
	BAU->(DbCloseArea())
	RestArea(aAreaBAU)

	Return n_Tx



/**********************************************************************************
* Rotina   : SemAcentos           * Autor: Carlos Aquino       * Data: 16/07/2005 *
***********************************************************************************
* Descricao : Substitui os caracteres invalidos de um texto passado via parametro *
* Parametro : String                                                              *
* Retorno   : String                                                              *
**********************************************************************************/

User Function SemAcentos(cTexto)

Local aDePara 	:= {}
Local cTeTexto 	:= cTexto
Local  x, i
Local cDescItem
// Array de Caracteres Invalidos
aAdd(aDePara,{{192,198},65}	)
aAdd(aDePara,{{199,199},67}	)
aAdd(aDePara,{{200,203},69}	)
aAdd(aDePara,{{204,207},73}	)
aAdd(aDePara,{{208,208},68}	)
aAdd(aDePara,{{209,209},78}	)
aAdd(aDePara,{{210,216},79}	)
aAdd(aDePara,{{217,220},85}	)
aAdd(aDePara,{{221,221},89}	)
aAdd(aDePara,{{222,222},97}	)
aAdd(aDePara,{{223,223},98}	)
aAdd(aDePara,{{224,230},97}	)
aAdd(aDePara,{{231,231},99}	)
aAdd(aDePara,{{232,235},101}	)
aAdd(aDePara,{{236,239},105}	)
aAdd(aDePara,{{240,240},111}	)
aAdd(aDePara,{{241,241},110}	)
aAdd(aDePara,{{242,248},111}	)
aAdd(aDePara,{{249,252},117}	)
aAdd(aDePara,{{253,253},121}	)
aAdd(aDePara,{{254,254},97}	)
aAdd(aDePara,{{255,255},121}	)
aAdd(aDePara,{{166,168},46}	)

For x := 1 to Len(aDePara)
	For i := aDepara[x][1][1] to aDepara[x][1][2]
		cTeTexto := StrTran(cTeTexto,chr(i),chr(aDepara[x][2]))
	Next i
Next x
cTeTexto := StrTran(cTeTexto,"บ",".")

Return((cTeTexto))
