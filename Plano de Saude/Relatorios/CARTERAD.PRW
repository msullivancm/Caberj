#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CARTEAD   ºAutor  ³Jean Schulz         º Data ³  02/04/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao de carta de maioridade (24 anos) para beneficiarioº±±
±±º          ³dependente.                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Repassar matriz de usuarios a imprimir. Impressao carta.   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/

User Function CARTEAD(aCarta)

Local nContArr := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local cNomOpe := ""
Local cCodANS := ""
Local cCGCOpe := ""

local cMask102	:= "@E 999,999.99" 
local nLin		:= 0
Local cPath		:= GetSrvProfString("Startpath","")
Local cContato	:= GetNewPar("MV_Y24TEL","Telefone (21) 3233-8888 / Fax: (21) 2505-6439") 
Local cAssina1	:= GetNewPar("MV_Y24ASS","Dayse de Aragão Gomes Rodrigues")
Local cAssina2	:= GetNewPar("MV_Y24AS2","Gerente de Atendimento")
Local cAssina3	:= GetNewPar("MV_Y24AS3","")
Local cRodape1	:= ""
Local cRodape2	:= GetNewPar("MV_Y24END","Rua Sete de Setembro,32 - 5o Andar - Centro - Rio de Janeiro - CEP: 20050-009" )
Local cRodape3	:= GetNewPar("MV_Y24WEB","Home Page: http://www.caberj.com.br - E-mail: faleconosco@caberj.com.br")
Local cLogoCli	:= ""
Local cLogoANS	:= ""
Local nCont		:= 0
Local bLin		:= { | nLinha,nMult | nLinha+=((12*30/9)*nMult),nLin := nLinha }  
Local nPasso    := 130
Local aFormCobr := {}
Local cSQL		:= ""
Local nCt		:= 0

//Private aCarta := {}
BA0->(DbSetOrder(1))
BA0->(MsSeek(xFilial("BA0")+PLSINTPAD()))

cNomOpe := "CAIXA DE ASSISTÊNCIA À SAÚDE - CABERJ"
cCodANS := Transform(BA0->BA0_SUSEP,"@R !!!!!-!")
cCGCOpe := Transform(BA0->BA0_CGC,"@R !!.!!!.!!!/!!!!-!!")

cRodape1 := GetNewPar("MV_Y24ABC",cNomOpe)

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
oFont2:= TFont():New( "Courier New"		,,11,,.t.,,,,,.f. )
oFont3:= TFont():New( "Courier New"		,,07,,.t.,,,,,.f. )
oFont4:= TFont():New( "Courier New"		,,09,,.t.,,,,,.f. )  
oFont5:= TFont():New( "Courier New"		,,12,,.t.,,,,,.f. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Rotina de impressao da carta...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCont := 1 to Len(aCarta)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿   	
	//³ Caso nao tenha sido parametrizado produto posterior,							  ³
	//³ deve-se ignorar o registro e nao emitir carta.									  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nCt := 1 to 2
		If !Empty(aCarta[nCont,17]) .And. aCarta[nCont,25] == "1"	
	
			aFormCobr := {}
		
			oPrn:StartPage()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Logo da operadora...                                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		    oPrn:SayBitmap( 048, nPasso,cLogoCli,250,208 )
		    
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Busca faixas etárias vigentes...                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
			cSQL := " SELECT * "
			cSQL += " FROM "+RetSQLName("BTN")+" BTN "
			cSQL += " WHERE BTN_FILIAL = '"+xFilial("BTN")+"' "
			cSQL += " AND BTN_CODIGO = '"+PLSINTPAD()+aCarta[nCont,20]+"' "
			cSQL += " AND BTN_NUMCON = '"+aCarta[nCont,21]+"' "
			cSQL += " AND BTN_VERCON = '"+aCarta[nCont,22]+"' "
			cSQL += " AND BTN_SUBCON = '"+aCarta[nCont,23]+"' "
			cSQL += " AND BTN_VERSUB = '"+aCarta[nCont,24]+"' "
			cSQL += " AND BTN_CODPRO = '"+aCarta[nCont,17]+"' "
			cSQL += " AND BTN_VERPRO = '"+aCarta[nCont,18]+"' "		
			cSQL += " AND BTN_CODFOR = '101' "
			cSQL += " AND (BTN_TABVLD = ' ' OR BTN_TABVLD >= '"+DtoS(dDataBase)+"') "
			cSQL += " AND BTN.D_E_L_E_T_ = ' ' "
			PlsQuery(cSQL,"TRBBTN")
		
			nVlrAnt := 0
			nPerDif := 0
			
			While !TRBBTN->(Eof())
				
				aadd(aFormCobr,{"De "+Alltrim(Str(TRBBTN->BTN_IDAINI))+" até "+Alltrim(Str(TRBBTN->BTN_IDAFIN))+" anos",""})
				nVlrAtu := TRBBTN->BTN_VALFAI
		
				If nVlrAnt <> 0
					nPerDif := Round(((nVlrAtu*100)/nVlrAnt),2)-100
				Endif		                               
				
				aFormCobr[Len(aFormCobr),2] := Alltrim(Str(nPerDif))		
				nVlrAnt := nVlrAtu
				
				TRBBTN->(DbSkip())
				
			Enddo
			
			TRBBTN->(DbCloseArea())
		    
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Dados da operadora...                                                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nLin := 048
			oPrn:Say (Eval(bLin,nLin,2), nPasso*4, cNomOpe ,oFont5,100) //NOME OPERADORA
			oPrn:Say (Eval(bLin,nLin,1), nPasso*4, "CNPJ: "+cCGCOpe ,oFont5,100) //CNPJ OPERADORA
			oPrn:Say (Eval(bLin,nLin,1), nPasso*4, "Registro ANS: "+cCodANS ,oFont5,100) //REGISTRO ANS
			 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Dados do cliente...                                                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrn:Say (Eval(bLin,nLin,3), nPasso*7, "TERMO ADITIVO" ,oFont1,100) 
			oPrn:Say (Eval(bLin,nLin,2), nPasso*5, "PLANO COLETIVO POR ADESÃO" ,oFont1,100) 
			oPrn:Say (Eval(bLin,nLin,2), nPasso*7, "VIGÊNCIA 01/01/2004" ,oFont5,100)
				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicio da impressao do texto da carta...                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
			oPrn:Line(Eval(bLin,nLin,3), nPasso, nLin, 2400)	
			
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "Ref: Termo de Adesão de: "+aCarta[nCont,4],oFont5,100)
			
			oPrn:Say (Eval(bLin,nLin,3), nPasso, "Termo Aditivo ao contrato de cobertura de assistência médico-hospitalar que entre si  " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "fazem de um lado, como contratada a CABERJ - Caixa de Assistência à Saúde, e, de " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "outro lado, como contratante "+Alltrim(aCarta[nCont,4])+" " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "o que observará as seguintes cláusulas e condições: " ,oFont5,100)
			
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "CLÁUSULA 1a - DA RETIFICAÇÃO DAS FAIXAS ETÁRIAS" ,oFont5,100)
			
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "Considerando-se o disposto na Lei nro. 10.741, de 1 de outubro de 2003, bem assim     " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "o prescrito na Resolução Normativa nro.63, publicada pela Agência Nacional de Saúde   " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "Suplementar - ANS em 23 de dezembro de 2003, resolvem as partes alterar a redação do  " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "artigo 27o do contrato ora aditado, cujo teor passa a ser o seguinte:                 " ,oFont5,100)	
			                                                                                                                                           
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "Artigo 27o" ,oFont5,100)	
			
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "Faixas Etárias - Compreenderão 10(dez) faixas etárias, com as variações das mensalida-" ,oFont5,100)	
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "des, em razão da idade do usuário e reajustadas quando houver mudança de faixa etária," ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "exceto para beneficiários com mais de 58(cinquenta e oito) anos.                      " ,oFont5,100)
			
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "Parágrafo Único - Mudança de Faixa Etária - Ocorrendo mudança de idade do usuário que " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "implique em deslocamento para outra faixa etária, as mensalidades serão cobradas a    " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "partir do mês subsequente da ocorrência da alteração.                                 " ,oFont5,100)	
			
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "                     +-------------------+ " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "                     | Perc. Reajuste (%)| " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "+--------------------+-------------------+ " ,oFont5,100)
			
		
			
			For nContArr := 1 to Len(aFormCobr)
				
				oPrn:Say (Eval(bLin,nLin,1), nPasso, "| "+aFormCobr[nContArr,1]+Space(18-Len(aFormCobr[nContArr,1]))+" | "+;
			                                          aFormCobr[nContArr,2]+"%"+Space(16-Len(aFormCobr[nContArr,2]))+" | ")
				oPrn:Say (Eval(bLin,nLin,1), nPasso, "+--------------------+-------------------+ " ,oFont5,100)
				
			Next
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "CLÁUSULA 2 - DECLARAÇÃO " ,oFont5,100)
			
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "O responsável pelo contrato e todos os beneficiários maiores delcaram que estão cien-" ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "tes, concordam e aceitam sem reservas todas as condições deste ADITIVO CONTRATUAL, " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "que institui as faixas etárias como apontadas no quadro retro.                         " ,oFont5,100)	
			
			oPrn:Say (Eval(bLin,nLin,2), nPasso, "Permanecem inalteradas, portanto válidas e exigíveis todas as demais cláusulas e " ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, "condições não modificadas por este instrumento.                                             " ,oFont5,100)
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Rodape da pagina impressa                                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrn:Say (Eval(bLin,nLin,2), nPasso*2, "Rio de Janeiro,  _____/_____/_______   ____________________________________________" ,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso*2, "                                                        CONTRATANTE                " ,oFont5,100)    
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Logo ANS + Rodape                                                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oPrn:Line(Eval(bLin,nLin,4), nPasso, nLin, 2200)	
			//oPrn:SayBitmap( Eval(bLin,nLin,2), nPasso,cLogoANS,250,60 )
			
			oPrn:Say (Eval(bLin,nLin,1), nPasso, ALLTRIM(BA0->BA0_NOMINT),oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, cRodape2,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, cRodape3,oFont5,100)
			oPrn:Say (Eval(bLin,nLin,1), nPasso, cContato,oFont5,100)
			
			oPrn:EndPage()
			
		Endif
	Next	
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apresenta o resultado...                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//oPrn:Preview()
	
return