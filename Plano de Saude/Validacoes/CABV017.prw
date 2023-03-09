#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABV017   ºAutor  ³Motta               º Data ³  abril/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Validacoes dos questionários do Projeto Maturidade(UNATI)  º±±     
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function CABV1701(cTempo)  
/*questionario 0009 pergunta 0004*/

Local lRet     := .T.

If Type(Trim(Replace(cTempo,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cTempo)) == 0 .OR. (Val(Trim(cTempo)) > 0 .AND. Val(Trim(cTempo))<200))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet      
//=====================================================================================  

User Function CABV1702(cPantur)  
/*questionario 0009 pergunta 0005*/

Local lRet     := .T.

If Type(Trim(Replace(cPantur,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cPantur)) == 0 .OR. (Val(Trim(cPantur)) > 10 .AND. Val(Trim(cPantur))<60))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet        
//=====================================================================================  

User Function CABV1703(cPontua)  
/*questionario 0009 pergunta 0007*/

Local lRet     := .T.

If Type(Trim(Replace(cPontua,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cPontua)) == 0 .OR. (Val(Trim(cPontua)) > 0 .AND. Val(Trim(cPontua))<11))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet    
//=====================================================================================    

User Function CABV1704(cPeso)  
/*questionario 0009 pergunta 0007*/

Local lRet     := .T.

If Type(Trim(Replace(cPeso,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cPeso)) == 0 .OR. (Val(Trim(cPeso)) > 30 .AND. Val(Trim(cPeso))<250))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet   
//=====================================================================================    

User Function CABV1705(cAltura)  
/*questionario 0009 pergunta 0008*/

Local lRet     := .T.

If Type(Trim(Replace(cAltura,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cAltura)) == 0 .OR. (Val(Trim(cAltura)) > 1 .AND. Val(Trim(cAltura)) <= 2.5))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet   
//=====================================================================================   

User Function CABV1706(cIMC)  
/*questionario 0009 pergunta 0008*/

Local lRet     := .T.

If Type(Trim(Replace(cIMC,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cIMC)) == 0 .OR. (Val(Trim(cIMC)) > 10 .AND. Val(Trim(cIMC)) <= 100))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet
//=====================================================================================   

User Function CABV1707(cEscola)  
/*questionario 0009 pergunta 0029*/

Local lRet     := .T.

If Type(Trim(Replace(cEscola,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cEscola)) == 0 .OR. (Val(Trim(cEscola)) > 0 .AND. Val(Trim(cEscola)) <= 30))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet
//=====================================================================================   

User Function CABV1708(cCoMorb)  
/*questionario 0009 pergunta 0032*/

Local lRet     := .T.

If Type(Trim(Replace(cCoMorb,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cCoMorb)) == 0 .OR. (Val(Trim(cCoMorb)) > 0 .AND. Val(Trim(cCoMorb)) <= 10))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet   
//=====================================================================================   

User Function CABV1709(cTemConj)  
/*questionario 0011 pergunta 0002*/

Local lRet     := .T.

If Type(Trim(Replace(cTemConj,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cTemConj)) == 0 .OR. (Val(Trim(cTemConj)) > 0 .AND. Val(Trim(cTemConj)) <= 100))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet    
//=====================================================================================   

User Function CABV1710(cPontNutr)  
/*questionario 0011 pergunta 0002*/

Local lRet     := .T.

If Type(Trim(Replace(cPontNutr,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cPontNutr)) == 0 .OR. (Val(Trim(cPontNutr)) > 0 .AND. Val(Trim(cPontNutr)) <= 77))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet    
//=====================================================================================  

User Function CABV1711(cDoisDigit)  
/*questionario dois digitos*/

Local lRet     := .T.

If Type(Trim(Replace(cDoisDigit,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cDoisDigit)) == 0 .OR. (Val(Trim(cDoisDigit)) > 0 .AND. Val(Trim(cDoisDigit)) <= 99) .AND. (Len(Trim(cDoisDigit)) < 3))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet    
//=====================================================================================     


User Function CABV1712(cDoisDig1d)  
/*questionario dois digitos uma digimal*/

Local lRet     := .T.

If Type(Trim(Replace(cDoisDig1d,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cDoisDig1d)) == 0 .OR.; 
	        (Val(Trim(cDoisDig1d)) > 0 .AND. Val(Trim(cDoisDig1d)) <= 99) .AND. (Len(Trim(cDoisDig1d)) < 5) .AND. (At(".",Trim(cDoisDig1d)) > 0))
	If !lRet
		Alert("Valor fora de uma faixa permitida / Informe a casa decimal(com ponto) !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet    
//=====================================================================================   

User Function CABV1713(cTresDigit)  
/*questionario tres digitos*/

Local lRet     := .T.

If Type(Trim(Replace(cTresDigit,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cTresDigit)) == 0 .OR. (Val(Trim(cTresDigit)) > 0 .AND. Val(Trim(cTresDigit)) <= 99))
	If !lRet
		Alert("Valor fora de uma faixa permitida !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet    
//=====================================================================================   

User Function CABV1714(cTemper)  
/*questionario dois digitos uma digimal*/

Local lRet     := .T.

If Type(Trim(Replace(cTemper,',','x'))) == "N" //replace pois a conversão aceita virgula
	lRet := (Val(Trim(cTemper)) == 0 .OR.; 
	        (Val(Trim(cTemper)) > 34 .AND. Val(Trim(cTemper)) <= 46) .AND. (Len(Trim(cTemper)) == 4) .AND. (At(".",Trim(cTemper)) > 0))
	If !lRet
		Alert("Valor fora de uma faixa permitida / Informe a casa decimal(com ponto) !!")
	End if
Else
	lRet := .F.
	Alert("Campo numerico, informe PONTO para decimais !!")
End if

Return lRet    
//=====================================================================================  

User Function CABV1715(cPreArt)  
/*questionario dois digitos uma digimal*/

Local lRet     := .T.                                                     

If  ((empty(cPreArt)) .or. (Len(cPreArt) != 5 .AND. !(U_ValPreArt(Replace(cPreArt,'/','')))))    
  	lRet := .F.
  	Alert("Campo inválido, informe no formato 12/08 !!")
End if

Return lRet    
//=====================================================================================      

User Function CABV1716(cCodPac)  
/*valid de uma matric no projeto unati*/
Local lRet     := .F.
Local aAreaBA1 := BA1->(GetArea())
Local aAreaBF4 := BF4->(GetArea())
Local cSQL     := Space(0)
Local cAlias   := "BA1"
LOCAL cProjeto := Space(0)



cCodInt := SubStr(AllTrim(cCodPac),1,4)
cCodEmp := SubStr(AllTrim(cCodPac),5,4)
cMatric := SubStr(AllTrim(cCodPac),9,6)
cTipReg := SubStr(AllTrim(cCodPac),15,2)
cDigito := SubStr(AllTrim(cCodPac),17,1)  


BA1->(DbSetOrder(2))
BA1->(DbSeek(xFilial("BA1")+cCodInt+cCodEmp+cMatric+cTipReg))
While BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG) == cCodInt+cCodEmp+cMatric+cTipReg .And. !BA1->(Eof())
	lRet := (Empty(BA1->BA1_DATBLO) .Or. (!Empty(BA1->BA1_DATBLO) .And. (BA1->BA1_DATBLO > dDataBase)))
	Ba1->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vwerifica se o usuario estiver ativo em projetos, exibe mensagem...      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !lRet   
  Alert("Matricula do Assistido nao localizada ou nao Ativa !!")
Else         
    lRet := .F.
	If BF4->(MsSeek(xFilial("BF4")+cCodInt+cCodEmp+cMatric+cTipReg))
		While BF4->(BF4_CODINT+BF4_CODEMP+BF4_MATRIC+BF4_TIPREG) == cCodInt+cCodEmp+cMatric+cTipReg .And. !BF4->(Eof())
			If BF4->BF4_CODPRO $ GetNewPar("MV_XCODMT",Iif(cEmpAnt == "01","0083","0130"))  // CODIGO DO PROJETO DO MATURIDADE
			  lRet := (Empty(BF4->BF4_DATBLO) .Or. (!Empty(BF4->BF4_DATBLO) .And. (BF4->BF4_DATBLO > dDataBase)))
			  Exit
			Else
			  lRet := .F.
			Endif
			BF4->(DbSkip())
		Enddo
	Endif   
	If !lRet 
	  Alert("Assistido nao esta ativo no Programa !!")
	Endif
Endif     

RestArea(aAreaBA1)
RestArea(aAreaBF4)

Return lRet
//=====================================================================================    