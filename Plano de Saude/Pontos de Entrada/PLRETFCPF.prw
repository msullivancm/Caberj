#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLRETFCPF ºAutor  ³Microsiga           º Data ³  04/30/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Trata parametrizacao de tipo de faturamento (folha x financ)º±±
±±º          ³quando a familia esta bloqueada.                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User function PLRETFCPF()   
Local aRet := {paramixb[10,1],paramixb[10,2]}
Local aAreaSRA := SRA->(GetArea("SRA"))  
**'Marcela Coimbra'**

Local cCodInt := paramixb[1] //Código Operadora da Família
Local cCodEmp := paramixb[2] //Código do Grupo empresa da Família
Local cNumCon := paramixb[3] //Código do Contrato da Família sendo a mesma PJ
Local cVerCon := paramixb[4] //Código da Versão do Contrato da Família sendo a mesma PJ
Local cSubCon := paramixb[5] //Código do SubContrato da Família sendo a mesma PJ
Local cVerSub := paramixb[6] //Código da Versão do SubCOntrato da Família sendo a mesma PJ
Local cCodPla := paramixb[7] //Código do Plano da Família
Local cVerPla := paramixb[8] //Versão do Plano da Família
Local cTipoUs := paramixb[9] //Tipo do Usuário 1=PF ou 2=PJ
 

If Type( "xx_aRecBBt" ) == "U"
     
	Public xx_aRecBBt := {} 

EndIf                 

**'Fim Marcela Coimbra'**


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso seja folha e corresponda as regras, gerar titulo financeiro...³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If paramixb[10,2] == "3" 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Regra: caso bloqueado no PLS ou afastado / demitido, nao gera folha.³
	//³ Importante: regra do perc. desconto no fonte CALCDCAB.PRW.          ³	    
   //³ Verificar também caso Afastado  se a situação de afstamento é para  |
   //| gerar boleto ou não                                                 ³	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	SRA->(DbSetOrder(1)) //RA_FILIAL+RA_MAT
	If Posicione("SRA",1,xFilial("SRA")+BA3->BA3_AGMTFU,"RA_SITFOLH") $ GetNewPar("MV_YFLHFI","A,D")
	  If SRA->RA_SITFOLH $ GetNewPar("MV_YFLHF2","A")
	    If SRA->RA_AFASFGT $ GetNewPar("MV_YFLHF3","O,P,1")
	      	aRet[2] := "2"
	    Endif  	
	  Else
		aRet[2] := "2"
	  Endif			
	Else
		If !Empty(BA3->BA3_DATBLO) .And. Alltrim(Funname())=="PLSA627"
			If M->(BDC_ANOINI+BDC_MESINI) > Substr(DtoS(BA3->BA3_DATBLO),1,6)     
			  If BA3->BA3_DATBLO != CTOD("31/12/2011") //tratar questão do bloquio para a Integral
				   aRet[2] := "2" 
			  Endif					   			
			Endif
		Endif
	Endif
	
	RestArea(aAreaSRA)
	
Endif   
   

**'Marcela Coimbra '**
aRet[1] := "2"   // Para não voltar um mes no lote de custo operacional
	
Return aRet