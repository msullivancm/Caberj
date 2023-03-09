#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CARPROP   ºAutor  ³Jean Schulz         º Data ³  02/04/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao de carta de maioridade (24 anos) para beneficiarioº±±
±±º          ³dependente.                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Repassar matriz de usuarios a imprimir. Impressao carta.   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CARPROP(aCarta)
Local cNomOpe := ""
Local cCodANS := ""
Local cCGCOpe := ""
Local bLin		:= { | nLinha,nMult | nLinha+=((12*25/9)*nMult),nLin := nLinha }
local nLin		:= 0
Local cPath		:= GetSrvProfString("Startpath","")
Local cLogoCli	:= ""
Local cLogoANS	:= ""
Local nCont		:= 0
Local nPasso    := 130
Local nCt		:= 0

BA0->(DbSetOrder(1))
BA0->(MsSeek(xFilial("BA0")+PLSINTPAD()))

cNomOpe := BA0->BA0_NOMINT
cCodANS := BA0->BA0_SUSEP
cCGCOpe := BA0->BA0_CGC

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria objeto de impressao grafica...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//oPrn 	:= tAvPrinter():New( "Protheus" )
//oPrn	:Setup()
oPrn	:StartPage()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define logos a serem utilizadas...                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPath := AjuBarPath(cPath)
cLogoCli := cPath+"lgrl01.bmp"
cLogoANS := cPath+"LogoANS.bmp"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define fontes a serem utilizadas...                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oFont1:= TFont():New( "Times New Roman"	,,20,,.t.,,,,,.f. )
oFont2:= TFont():New( "Times New Roman"	,,14,,.t.,,,,,.f. )
oFont3:= TFont():New( "Courier New"		,,07,,.t.,,,,,.f. )
oFont4:= TFont():New( "Courier New"		,,09,,.t.,,,,,.f. )
oFont5:= TFont():New( "Courier New"		,,12,,.t.,,,,,.f. )

//Legenda aCarta
//1-Matricula completa BA1 (Titular)
//2-Nome usuario BA1 (Titular)
//3-Matricula completa BA1 (Dependente 24 anos)
//4-Nome Usuario BA1 (Dependente 24 anos)
//5-Nome do produto reduzido.
//6-Descricao Grau de parentesco.
//7-Data de nascimento.
//8-Data composta.
//9-Data de bloqueio
//10-Endereco de cobranca
//11-Bairro de cobranca
//12-Cidade de cobranca
//13-UF cobranca
//14-Cep cobranca
//15-Cod.Cliente
//16-Loja cliente
//17-Cod. Plano Sugerido
//18-Versao Plano Sugerido
//19-Descricao Plano Sugerido
//20-Cod Emp. Destino
//21-Contrato Emp. destino
//22-Versao Contrato emp. Destino
//23-SubContr. Empr. Destino
//24-Versao Subcontr. Empr. Destino

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Rotina de impressao da carta...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCont := 1 to Len(aCarta)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso nao tenha sido parametrizado produto posterior,					 ³
	//³ deve-se ignorar o registro e nao emitir carta.							 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCt := 1 to 2
		If !Empty(aCarta[nCont,17]) .And. aCarta[nCont,25] == "1"
			
			oPrn:StartPage()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Cabecalho do relatorio...                                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrn:SayBitmap(048,130,cLogoCli,250,208 )
			oPrn:Say(300,130, "ANS Nro.: 32.436-1" ,oFont4,100)
			
			nLin := 600
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "Plano: "+aCarta[nCont,19] ,oFont2,100)
			
			
			nLin := 100
			nCol := 1850
			U_GERABOX(@nLin,1,@nCol,10,"Nro:",.T.,"P",.T.)
			
			oPrn:Box(300,600,520,1750)
			oPrn:Say(345,800, "PROPOSTA DE ADESÃO" ,oFont1,100)
			oPrn:Say(420,615, "CONTRATO SEGUNDO LEI 9656 DE 03/06/1998" ,oFont2,100)
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Desenha Quadro do contratante...                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			U_GERABOX(@nLin,6,@nCol,25,"DADOS DO TITULAR",.t.,"G",.T.)
			
			U_GERABOX(@nLin,2,@nCol,40,"NOME "+aCarta[nCont,4],.f.,"P",.T.)
			U_GERABOX(@nLin,0,@nCol,20,"CPF ",.t.,"P",.T. )
			
			U_GERABOX(@nLin,1,@nCol,18,"ESTADO CIVIL ",.F.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,07,"SEXO ",.F.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,15,"DATA NASC.___/___/_____ ",.F.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,13,"PIS/PASEP ",.T.,"P",.T. )
			
			U_GERABOX(@nLin,1,@nCol,65,"NOME DA MAE ",.t.,"P",.T. )
			
			U_GERABOX(@nLin,1,@nCol,45,"END. RESIDENCIAL ",.f.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,15,"NRO. ",.T.,"P",.T. )
			
			U_GERABOX(@nLin,1,@nCol,30,"COMPLEM. ",.f.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,05,"UF ",.f.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,25,"MUNICIPIO ",.T.,"P",.T. )
			
			U_GERABOX(@nLin,1,@nCol,25,"BAIRRO ",.f.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,15,"CEP ",.f.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,20,"TELEFONES ",.T.,"P",.T. )
			
			U_GERABOX(@nLin,1,@nCol,45,"END. COBRANÇA ",.f.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,15,"NRO. ",.T.,"P",.T. )
			
			U_GERABOX(@nLin,1,@nCol,30,"COMPLEM. ",.f.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,05,"UF ",.f.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,25,"MUNICIPIO ",.T.,"P",.T. )
			
			U_GERABOX(@nLin,1,@nCol,25,"BAIRRO ",.f. ,"P",.T.)
			U_GERABOX(@nLin,0,@nCol,15,"CEP ",.f.,"P",.T. )
			U_GERABOX(@nLin,0,@nCol,20,"TELEFONES ",.T.,"P",.T. )
			
			U_GERABOX(@nLin,1,@nCol,60,"E-MAIL ",.t.,"P",.T. )
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Desenha Quadro do proponente...                                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			U_GERABOX(@nLin,2,@nCol,25,"DADOS DO CONTRATANTE",.t.,"G",.T.)
			
			U_GERABOX(@nLin,2,@nCol,40,"NOME "+aCarta[nCont,2],.f.,"P",.T.)
			U_GERABOX(@nLin,0,@nCol,20,"CPF ",.t.,"P" ,.T.)
			
			U_GERABOX(@nLin,1,@nCol,15,"DATA NASC.___/___/_____ ",.F.,"P" ,.T.)
			U_GERABOX(@nLin,0,@nCol,45,"E-MAIL ",.t.,"P" ,.T.)
			
			U_GERABOX(@nLin,1,@nCol,45,"END. RESIDENCIAL ",.f.,"P" ,.T.)
			U_GERABOX(@nLin,0,@nCol,15,"NRO. ",.T.,"P" ,.T.)
			
			U_GERABOX(@nLin,1,@nCol,30,"COMPLEM. ",.f.,"P" ,.T.)
			U_GERABOX(@nLin,0,@nCol,05,"UF ",.f.,"P" ,.T.)
			U_GERABOX(@nLin,0,@nCol,25,"MUNICIPIO ",.T.,"P" ,.T.)
			
			U_GERABOX(@nLin,1,@nCol,25,"BAIRRO ",.f. ,"P",.T.)
			U_GERABOX(@nLin,0,@nCol,15,"CEP ",.f.,"P" ,.T.)
			U_GERABOX(@nLin,0,@nCol,20,"TELEFONES ",.T.,"P" ,.T.)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Rodape da pagina impressa                                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nLin := 3000
			oPrn:Say (Eval(bLin,nLin,1), nPasso*2, "Data: _____/_____/_______   _____________________________  ___________________________" ,oFont4,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso*2, "                               Assinatura do Contratante      Assinatura do Titular   " ,oFont4,100)
			
			oPrn:EndPage()
			
		Endif
	Next
Next

//oPrn:Preview()

Return

