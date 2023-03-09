#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV042  ºAutor  ³Angelo Henrique     º Data ³  12/01/2018 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação criada para informar ao usuário que o procedimento ±±
±±º          ³prenchido em tela necessita de analise prévia.              º±±
±±º          ³Gatilho chamado na rotina de Liberação.                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABV042(dConteudo,nOpc)

Local _aArea	:= GetArea()
Local _aArZZQ	:= ZZQ->(GetArea())
Local _lRet		:= .T.
Local nTotDias 	:= 0 
Local cPerg 	:= "CABV042"
Local cCodBlo   := "001" // codigo bloqueio obto
//--------------------------------------
// 27/07/2018 - Autorização Judicial
Local cAutJus   := GetNewPar("MV_XREAUTJ","S") // parametro para controlar a liberação do reembolso acima de 12 meses - Autorização Judicial
//--------------------------------------

if nOpc == 1

	nTotDias := ddatabase - dConteudo
	
	if BA1->BA1_MOTBLO == cCodBlo .AND. M->ZZQ_TIPPRO == '4'
		_lRet := .T.
	elseif nTotDias > 365 .and. alltrim(cAutJus) == 'N' 
		_lRet := .F.
		AVISO("Reemb. N. Permit", "Solicitação de reembolso superior a 12 meses, a partir da data de execução do evento.", { "OK" }, 1)
	endif 
	
else

	if empty(M->ZZQ_DTEVEN)

		AVISO("Data do Evento", "Favor informar a data do evento. Caso possua mais de um recibo, informar o de data mais antiga.", { "OK" }, 1)

		PutSx1(cPerg,"01","Informe a data do recibo:",'','',"mv_ch1","D",TamSx3 ("ZZQ_DTEVEN")[1] ,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
		
		if Pergunte(cPerg, .T.)
			M->ZZQ_DTEVEN := MV_PAR01
		endif 
	
	endif
	
	//--------------------------------------------------------
	// Mateus Medeiros - 27/07/2018 - Alteração do Reembolso
	// Mensagem de alerta para o preenchimento do cliente 
	//--------------------------------------------------------
	if cEmpAnt == "01"
		AVISO("PREENCHE CLIENTE", "Favor verificar se os dados do cliente são compatíveis com os dados de quem receberá o reembolso.", { "OK" }, 1)
	else 
		AVISO("PREENCHE CLIENTE", "Favor verificar se os dados do cliente são compatíveis com os dados do titular do plano.", { "OK" }, 1)
	endif 
endif 

RestArea(_aArZZQ)
RestArea(_aArea	)

Return _lRet
