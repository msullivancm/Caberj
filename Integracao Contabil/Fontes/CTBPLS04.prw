#include 'protheus.ch'
#include 'topconn.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBPLS04  ºAutor  ³Roger Cangianeli    º Data ³  05/12/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Busca dinamica da conta, conforme configuracao flexivel    º±±
±±º          ³ no arquivo especifico SZR para contabilizar comissoes.     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Unimed e cooperativas                                      º±±
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

User Function CTBPLS04(nTipo,cChaCT5,cCtaFix,cDebCre)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa Parametros:                                            ³
//³MV_YCTPL05 --> Codigo dos Tipos de Planos Individuais / Familiares³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cCtpl05	:= GetNewPar('MV_YCTPL05','1')
Local cCodPla   := Space(4)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa as variaveis neste ambiente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cRet, cBusca, aArea, nHand, cFile, cBi3ModPag,cBi3ApoSrg,cBi3TipCon,cBi3Tipo,cBi3CodSeg
Local cLog, cLog1, cPlano, cBi3TpBen, cBG9Tipo, cCT5Vlr, cCT5Dsc

Local aRegCT5   := CT5->(GetArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Esta variável nTipo identifica se o campo tratado para retorno da conta³
//³será:                                                                  ³
//³1 --> ZR_CONTA - conta débito contra-partida da transitória do controle³
//³de comissões na geração das faturas.                                   ³
//³2 --> ZR_CTAENC - conta débito contra-partida dos encargos na baixa    ³
//³dos títulos.                                                           ³
//³3 --> ZR_CONTA -conta crédito contra-partida da transitória do controle³
//³de comissões na exclsão das faturas. Para este caso, em relação a opção³
//³do código 1, somente modifica o log.                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Default nTipo := 1		

// Salva ambiente original
aArea	:= GetArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³POSICIONAR PRODUTO -  BI3           		³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Identifica se o plano esta no usuario ou na familia
If Empty(BA1->BA1_CODPLA)
	cPlano	:= BA3->BA3_CODPLA+BA3->BA3_VERSAO
	cCodPla := BA3->BA3_CODPLA
Else
	cPlano	:= BA1->BA1_CODPLA+BA1->BA1_VERSAO
	cCodPla := BA1->BA1_CODPLA
EndIf

cBi3ModPag		:= BI3->BI3_MODPAG		// Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_MODPAG")
cBi3ApoSrg		:= BI3->BI3_APOSRG		// Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_APOSRG")
cBi3TipCon		:= BI3->BI3_TIPCON		// Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_TIPCON")
cBi3Tipo		:= BI3->BI3_TIPO		// Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_TIPO")
cBi3CodSeg		:= BI3->BI3_CODSEG		// Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_CODSEG")
cBi3TpBen		:= BI3->BI3_YTPBEN		// Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+cPlano,"BI3_YTPBEN")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DO BENEFICIARIO                                                    ³
//³Verifica conteudo do campo BI3_YTPBEN ( Char(1) ), especifico que indica³
//³o tipo de beneficiario do contrato. As opcoes sao:                      ³
//³1 - BE - Beneficiario Exposto                                           ³
//³2 - ENB - Exposto Nao Beneficiario                                      ³
//³3 - BNE - Beneficiario Nao Exposto                                      ³
//³4 - PS - Prestacao de Servicos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cBusca	:= cBi3TpBen			//BI3->BI3_YTPBEN


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MODALIDADE DE COBRANCA                                      ³
//³Verifica se a modalidade eh Pre-Pagamento, senao classifica ³
//³direto em demais modalidades.                               ³
//³1 - Pre-Pagamento                                           ³
//³2 - Demais Modalidades                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cBusca	+= IIf( AllTrim(cBi3ModPag) $'1', '1', '2' )


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³PLANO REGULAMENTADO                                   ³
//³Analisa se o plano do usuario e regulamentado. Opcoes:³
//³0 - Nao                                               ³
//³1 - Sim                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cBusca	+= IIf( AllTrim(cBi3ApoSrg) == '1', '1', '0' )


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TIPO DE PLANO / CONTRATO                                     ³
//³Analisa o tipo de plano / contrato do usuario. As opcoes sao:³
//³1 - Individual / Familiar                                    ³
//³2 - Coletivo                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cBG9Tipo	:= Posicione("BG9",1,xFilial("BG9")+PLSINTPAD()+BA1->BA1_CODEMP,"BG9_TIPO")

If cBi3Tipo == "3" //Ambos
	If cBG9Tipo == "1" //Pessoa Fisica
		cBusca	+= "1"
	Else
		cBusca	+= "2"
	Endif
Else
	cBusca	+= IIf( AllTrim(cBi3TipCon) $ cCtpl05, '1', '2' )
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³PATROCINIO                                              ³
//³Analisa se o plano tem patrocinio ou nao. As opcoes sao:³
//³0 - Sem patrocinio                                      ³
//³1 - Com patrocinio                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cBi3Tipo == "3" //Ambos
	If cBG9Tipo == "1" //Pessoa Fisica
		cBusca	+= "0"
	Else
		cBusca	+= IIf( AllTrim(BQC->BQC_PATROC) == '1', '1', '0' )
	Endif
Else
	If AllTrim(cBi3Tipo) == '1'			// Plano Individual/Familiar, nunca tera patrocinio
		cBusca	+= '0'
	Else
		// Plano coletivo, forca que o campo esteja preenchido ou retorna sem patrocinio
		cBusca	+= IIf( AllTrim(BQC->BQC_PATROC) == '1', '1', '0' )
	EndIf
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³SEGMENTACAO                                                ³
//³Segue a segmentacao conforme o cadastro no proprio produto.³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    cBusca	+= cBi3CodSeg

    If nTipo = 0
        cRet := cCtaFix
    Else
        DBSelectArea('SZR')
        SZR->(DBSetOrder(1))
        If SZR->(DBSeek(xFilial('SZR')+cBusca+cCodPla, .F.))
            If nTipo == 2
                cRet := If(Empty(SZR->ZR_CTAENC), 'C->'+cBusca, SZR->ZR_CTAENC)
            Else
                cRet := If(Empty(SZR->ZR_CONTA), 'C->'+cBusca, SZR->ZR_CONTA)
            EndIf
        ElseIf SZR->(DBSeek(xFilial('SZR')+cBusca+Space(4), .F.))
            If nTipo == 2
                cRet := If(Empty(SZR->ZR_CTAENC), 'C->'+cBusca, SZR->ZR_CTAENC)
            Else
                cRet := If(Empty(SZR->ZR_CONTA), 'C->'+cBusca, SZR->ZR_CONTA)
            EndIf            
        Else
            If ' ' $ cBusca
                cRet := 'L->'+cBusca
            Else
                cRet := 'N->'+cBusca
            EndIf
        EndIf
    Endif

CT5->(DbSetOrder(1))
CT5->(MsSeek(xFilial("CT5")+cChaCT5)) 

cCT5Vlr := CT5->CT5_VLR01
cCT5Dsc := CT5->CT5_HIST

// Aciona gravacao de Log
cLog	:= 'Chave:'+cBusca+'|Conta:'+AllTrim(cRet)
cLog	+= '|Comp:'+BXQ->BXQ_MES+'/'+BXQ->BXQ_ANO+'|Titulo:'+BXQ->(BXQ_PREFIX+BXQ_NUM+BXQ_PARC+BXQ_TIPO)
cLog	+= '|Cod.Vend:'+AllTrim(BXQ->BXQ_CODVEN)+'|Cod.Eqp:'+AllTrim(BXQ->BXQ_CODEQU)+'|Parcela:'+BXQ->BXQ_NUMPAR
cLog	+= '|Dt.Ger.:'+DTOC(BXQ->BXQ_DATA)
cLog	+= '|Valor:'+Stuff( StrZero(&cCT5Vlr,14,2), AT('.',StrZero(&cCT5Vlr,14,2)), 1, ',' )


cLog1	:= '|Matric:'+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
cLog1	+= '|MatAnt:'+BA1->BA1_MATANT
cLog1	+= '|Cod.Plano:'+BI3->BI3_CODIGO+'/'+BI3->BI3_VERSAO
If cBG9Tipo == "1" //Pessoa Fisica
	cLog1	+= '|Grp.Fis:'+BA1->BA1_CODEMP
Else
	cLog1	+= '|Grp.Emp:'+BA1->BA1_CODEMP+'|Contr:'+BQC->BQC_NUMCON+'/'+BQC->BQC_VERCON
	cLog1	+= '|Subcont:'+BQC->BQC_SUBCON+'/'+BQC->BQC_VERSUB
EndIf
cLog1 += '|Desc:'+&cCT5Dsc
cLog1 += '|Tipo:'

Do Case
	Case substr(cChaCT5,1,3)=="P80"
		cLog1 += 'Geração'
	Case substr(cChaCT5,1,3)=="P81"
		cLog1 += 'Pagamento'
	Case substr(cChaCT5,1,3)=="P82"
		cLog1 += 'Cancelamento'
EndCase

cLog1 += '|Deb/Cre:'+IIF(cDebCre=="D","Débito","Crédito")

If Subs(cRet,1,1) $ 'CLN'
	
	If Subs(cRet,1,1) $ 'C'
		cLog1	+= '|Falta Conta para Combinacao'
	ElseIf Subs(cRet,1,1) $ 'N'
		cLog1	+= '|Falta Combinacao'
	Else
		cLog1	+= '|Combinacao Invalida'
	EndIf
	// Grava log de registro com problema
	U_Gravalog( cLog+cLog1, IIf(nTipo==2,"COM|ENC", IIf(nTipo==3,"COM|EXC", "COM|GER" ) ) )
		
Else
	// Grava registro ok 
	U_GrvLogBom( cLog+cLog1, IIf(nTipo==2,"COM|ENC", IIf(nTipo==3,"COM|EXC", "COM|GER" ) ) )
	
EndIf

RestArea(aRegCT5)
RestArea(aArea)
Return(cRet)
