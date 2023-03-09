#Include 'protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBPLS03  ºAutor  ³Roger Cangianeli    º Data ³  16/02/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Busca dinamica da conta, conforme configuracao flexivel    º±±
±±º          ³ no arquivo especifico SZX - Lanctos Deb/Cred RDA.          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Unimed e cooperativas                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlteracoes³ Inclusao do CRM para busca de contas, facilitando o lancto º±±
±±º          ³ de Integralizacao de Capital. Roger Cangianeli-18/07/06    º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Este programa fara uma busca de conta conforme a string busca³
//³(cBusca) que será montada. Esta string ira variar conforme a ³
//³combinacao de informacoes que serao avaliadas.               ³
//³Os arquivos estao sempre posicionados no momento do          ³
//³lancamento, portanto somente sera posicionado o arquivo de   ³
//³combinacoes de contas.                                       ³
//³Roger Cangianeli.                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function CTBPLS03(cTpLog)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa as variaveis neste ambiente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cRet, cBusca, aArea, cProc

Private cCodPla := Space(4)

Default	cTpLog	:= 'DC/RDA'
aArea	:= GetArea()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³CODIGO DO LANCAMENTO                                   ³
//³Utiliza o codigo do lancamento do cadastro de tipos de ³
//³lancamento Deb/Cred da RDA.                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCodPla := BBB->BBB_YCODPL
cBusca	:= BBB->BBB_CODSER

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³CLASSE DA RDA                                      ³
//³Assume a classe da RDA configurada em RDA Cadastro.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Se for Operadora, nao exige preenchimento
cBusca	+= AllTrim(BAU->BAU_TIPPRE)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DO PRESTADOR                                            ³
//³Identifica qual o tipo de prestador conforme cadastro da RDA.³
//³As opcoes sao:                                               ³
//³1 - Cooperado                                                ³
//³2 - Credenciado                                              ³
//³3 - Funcionario                                              ³
//³4 - Nao Cooperado                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cBusca	+= BAU->BAU_COPCRE



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³CODIGO CONSELHO REGIONAL                               ³
//³Inclue na procura o codigo do conselho regional do RDA.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//cBusca	+= BAU->BAU_CONREG

    DBSelectArea('SZP')
    SZP->(DBSetOrder(1))

    Do Case
        //Verifica chave completa
        Case SZP->(DBSeek(xFilial("SZP")+cBusca+BAU->BAU_CONREG+cCodPla, .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+cBusca+BAU->BAU_CONREG+cCodPla, SZP->ZP_CCRED)	

        //Verifica chave com a conta contábil padrão, levando em consideração o grupo
        Case SZP->(DBSeek(xFilial('SZP')+cBusca+BAU->BAU_CONREG+Space(4), .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+cBusca+BAU->BAU_CONREG+Space(4), SZP->ZP_CCRED)
            
        //Despreza o plano e verifica se existe cadastro com o grupo informado
        Case SZP->(DBSeek(xFilial('SZP')+cBusca+BAU->BAU_CONREG, .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+cBusca+BAU->BAU_CONREG, SZP->ZP_CCRED)            

		//Despreza o CRM e verifica se existe Tipo de Cooperado
        Case SZP->(DBSeek(xFilial('SZP')+cBusca, .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+cBusca, SZP->ZP_CCRED)

		//Despreza o CRM e verifica se existe Tipo de Cooperado
        Case SZP->(DBSeek(xFilial('SZP')+Left(cBusca, 7), .F.))
            cRet := If(Empty(SZP->ZP_CCRED), 'C->'+Left(cBusca, 7), SZP->ZP_CCRED)
		
		//Despreza o tipo de cooperado e tenta achar pelo tipo de prestador
        Case SZP->(DBSeek(xFilial('SZP')+Left(cBusca, 6), .F.))
            cRet := IIf(Empty(SZP->ZP_CCRED), 'C->'+Left(cBusca, 6), SZP->ZP_CCRED)
		
        //Despreza o tipo de prestador e tenta achar pelo tipo de lancamento
        Case dbSeek(xFilial('SZP')+Left(cBusca, 3),.F.)
            cRet := IIf(Empty(SZP->ZP_CCRED), 'C->'+Left(cBusca, 3), SZP->ZP_CCRED)
		
        OtherWise
            If ' ' $ cBusca
                cRet	:= 'L->'+cBusca
            Else
                cRet	:= 'N->'+cBusca
            EndIf
    EndCase

cProc	:= '|Oper.:'+BMS->BMS_OPELOT+'|RDA:'+BMS->BMS_CODRDA+'|Ano:'+BMS->BMS_ANOLOT+'|Mes:'+BMS->BMS_MESLOT
cProc 	+= '|Num.Lote:'+BMS->BMS_NUMLOT+'|Chave:'+cBusca

// Aciona gravacao de Log
If Subs(cRet,1,1) $ 'CLN'
	If Subs(cRet,1,1) $ 'L'
		cProc	+= '|Impossivel montar combinacao'
	ElseIf Subs(cRet,1,1) $ 'C'
		cProc	+= '|Falta Conta para Combinacao'
	ElseIf Subs(cRet,1,1) $ 'N'
		cProc	+= '|Falta Combinacao'
	EndIf
	U_Gravalog(cProc,cTpLog)
	
Else
	// Grava registro ok
	U_GrvLogBom(cProc,cTpLog)
	
EndIf


RestArea(aArea)
Return(cRet)


