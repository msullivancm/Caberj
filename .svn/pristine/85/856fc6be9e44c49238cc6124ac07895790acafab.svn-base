#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁPLS264CA  ╨Autor  Ё Jean Schulz        ╨ Data Ё  16/10/06   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁImprime dados conforme matriz pre-definida para customizar  ╨╠╠
╠╠╨          Ёo cartao de identificacao...                                ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё CABERJ                                                     ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/                    
User Function PLS264CA

Local nOrd := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aRet		:= Array(9)
Local aAreaBA1	:= BA3->(GetArea())
Local aAreaBA3	:= BA1->(GetArea())
Local aAreaBI3	:= BI3->(GetArea())
Local aAreaBA0	:= BA0->(GetArea())

Local nFor		  := 0
Local nFor1		  := 0
Local nTamPro    := 9
Local nPos		  := 0
Local cCodPla	  := ""
Local cVersao	  := ""
Local aClaCar	  := {}
Local aClasses	  := {}
Local aClaImp	  := {}
Local aRetCar    := {}
Local aCodCar    := {} 
Local aOrdCar    := {}
Local aLixo      := {}
Local nTamRetCar := 0
Local _cCodCar   := ""
Local _cTexto    := ""
Local wTexto     := ""

Local wOrdGrpCar := ""
Local wLixo := ""
          
wOrdGrpCar := GetNewPar("MV_YORDCAR","008;007;004;005")
wLixo := wOrdGrpCar

wTam := at(";",wOrdGrpCar)-1
If wTam <= 0
	wTam := Len(alltrim(wOrdGrpCar))
EndIf	
	
While .t.
      wTexto := substr(alltrim(wOrdGrpCar),1,wTam)
		If !Empty(wTexto)
         aadd(aOrdCar,wTexto)
      EndIf
      wOrdGrpCar := substr(alltrim(wOrdGrpCar),wTam+2)
      If empty(wOrdGrpCar)
         Exit
      EndIf
EndDo

BA3->(DbSetOrder(1))
BA1->(DbSetOrder(1))
BA0->(DbSetOrder(1))
BI3->(DbSetOrder(1))

BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))

cCodPla := BA3->BA3_CODPLA
cVersao := BA3->BA3_VERSAO

If !Empty(BA1->BA1_CODPLA)
	cCodPla := BA1->BA1_CODPLA
	cVersao := BA1->BA1_VERSAO
Endif

BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+cCodPla+cVersao))

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Descricao da acomodacao do plano do usuario...                      Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды 

//Leonardo Portella - 27/09/13 - Inicio - Virada P11

//Ret[1]	:= Posicione("BI4",1,xFilial("BI4")+BI3->BI3_CODACO,"BI4_DESCRI")
aRet[1]	:= Posicione("BI4",1,xFilial("BI4")+BI3->BI3_CODACO,"BI4_DESCRI")

//Leonardo Portella - 27/09/13 - Fim

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta array com classes de carencia                                 Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
BAY->(msSeek(xFilial("BAY")+BA1->BA1_CODINT+cCodPla+cVersao))

While ! BAY->(eof()) .and. BAY->(BAY_FILIAL+BAY_CODIGO+BAY_VERSAO) == xFilial("BAY")+BA1->BA1_CODINT+cCodPla+cVersao

	BAT->(dbsetOrder(1))
	BAT->(msSeek(xFilial("BAT")+BA1->BA1_CODINT+BAY->BAY_CODGRU))

	BAE->(dbsetOrder(1))
	BAE->(msSeek(xFilial("BAE")+BA1->BA1_CODINT+cCodPla+cVersao+BAY->BAY_CODGRU))

	While ! BAE->(eof()) .and. BAE->(BAE_FILIAL+BAE_CODIGO+BAE_VERSAO+BAE_CODGRU) == 	xFilial("BAE")+BA1->BA1_CODINT+cCodPla+cVersao+BAY->BAY_CODGRU
//		aadd(aClaCar,{BAE->BAE_CLACAR,BAT->BAT_SEXO, BAT->BAT_SEXO })
// Alterado por Luzio em 21/01/08 para guardar no mesmo array o nome do grupo da classe e que devera ser 
// impresso no cartao de identificacao.
//		aadd(aClaCar,{BAE->BAE_CLACAR,BAT->BAT_SEXO,BAT->BAT_DESCRI})
		aadd(aClaCar,{BAE->BAE_CLACAR,BAT->BAT_SEXO,BAT->BAT_CODIGO})
		BAE->(dbSkip())
	Enddo
	BAY->(dbSkip())
Enddo

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Compara as classes de carteira com classes de carencia, e imprime somente as parametrizadas...   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aClasses := PLSCLACAR(BA1->BA1_CODINT,BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),BA1->BA1_DATCAR)

If aClasses[1]
	For nFor := 1 to len(aClaCar)
		For nFor1 := 1 to Len(aClasses[2])
			If  aClaCar[nFor,1] == aClasses[2,nFor1,1] .and. ;
				(aClaCar[nFor,2] == BA1->BA1_SEXO .or. aClaCar[nFor,2] == "3") .and. ;
				aScan(aClaImp,{ |x| x[1] == aClaCar[nFor,1]}) == 0 
// Aletrado por Luzio em 21/01/08, aumentando o array em mais 2 elementos para que armazene no array
// o codigo do grupo da classe de carencia e a ordem de prioridade de impressao de acordo com o array aOrdCar
				asize(aclasses[2][nfor1],len(aclasses[2][nfor1])+1)
				aclasses[2][nfor1][6]:= aClaCar[nFor,3]

				asize(aclasses[2][nfor1],len(aclasses[2][nfor1])+1)
				For nOrd := 1 to len(aOrdCar)
				    If aClaCar[nFor,3] == aOrdCar[nOrd]
       				 aclasses[2][nfor1][7]:= strzero(nOrd,2)
    				 EndIf
				Next

				aadd(aClaImp,aClone(aClasses[2,nFor1]))
			Endif
		Next
	Next
Endif

// Verifica se alguma carencia ficou sem a ordem de impressao, incluindo com as ultimas carencias a serem impressas
For nFor := 1 to Len(aClaImp)
    If Empty(alltrim(aClaImp[nFor,7]))
		 aClaImp[nFor,7] := '99'
	 EndIf
Next	 

//aSortClaImp := asort(aClaImp,,,{|x,y| dtos(x[3])+x[6] > dtos(y[3])+y[6] })
aSortClaImp := asort(aClaImp,,,{|x,y| dtos(x[3])+x[6] > dtos(y[3])+y[6] })

For nFor := 1 to Len(aClaImp)       `
	If ascan(aLixo,{ |x| dtos(x[3])+x[6] == dtos(aClaImp[nFor,3])+aClaImp[nFor,6] }) = 0
		aadd(aLixo,aClone(aClaImp[nFor]))
   EndIf	
Next

aClaImp := aclone(aLixo)

aSortClaImp := asort(aClaImp,,,{|x,y| x[7]+dtos(x[3]) < y[7]+dtos(y[3]) })

For nFor := 1 to Len(aClaImp)
	If nFor > nTamPro
		Exit
	EndIf
	If aClaImp[nFor,3] > BA1->BA1_DATINC+1 .and. aClaImp[nFor,3] > dDataBase
		cData     := DtoC(aClaImp[nFor,3])
		_cCodCar := aClaImp[nFor,6]
//Comentado por Luzio em 09/06/08 para que nao apresetne as carencias zeradas. 
		If ascan(aCodCar,{ |x| UPPER(alltrim(x)) == UPPER(alltrim(_cCodCar)) }) = 0 
	     	aadd(aRetCar, cData)
	    	aadd(aCodCar, _cCodCar)
	   EndIf	
/*
	Else
		cData := "00/00/00"
		_cCodCar := aClaImp[nFor,6]  //""
	EndIf
	If ascan(aCodCar,{ |x| UPPER(alltrim(x)) == UPPER(alltrim(_cCodCar)) }) = 0 
     	aadd(aRetCar, cData)
    	aadd(aCodCar, _cCodCar)
   EndIf	                    
*/   
   EndIf
Next

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Segundo solicitacao de usuario, informar apenas as 3 primeiras carencias...    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nTamRetCar := Iif(Len(aRetCar)>3,3,Len(aRetCar))
For nFor := 1 to nTamRetCar
	aRet[nFor+1] := aRetCar[nFor]
Next

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Posicao 5 (4a carencia) posicao 6 (padrao de internacao)		    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aRet[5] := "" 
aRet[6] := "" 

aRet[5] := DtoC(BA1->BA1_DTVLCR) //Dt. Val. Cartao com 2 posicoes no ano
aRet[6] := DtoC(BA1->BA1_DATNAS) //Dt. Nascto com 2 posicoes no ano.


//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprimir data de inclusao no plano do usuario...				    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aRet[7] := DtoC(BA1->BA1_DATINC)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Observacoes livres (10 posicoes maximo)             			    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aRet[8] := ""

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Campo livre 9 (utilizar as seguintes regras):       			    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
/*
1-SE O CAMPO BI3_DESCAR ESTIVER PREENCHIDO E DIFERENTE DE "CABERJ", DEVERA INSERIR O CONTEUDO NO CAMPO.
2-SE O CAMPO BI3_DESCAR ESTIVER PREECHIDO COM CABERJ, DEVERA:
  - VERIFICAR SE O PRODUTO POSSUI O GRUPO DE COBERTURA 007 (INTERNACAO).
  - BUSCAR PELA CLASSE DE CARENCIA 016, E VERIFICAR SE ESTA EM CARENCIA.
  - SE ESTIVER EM CARENCIA, DEVERA ESCREVER "CABERJ"+"CARENCIA P/ INTERNACAO", RESPEITANDO A ORDEM INFORMADA PELO CODIGO (001,002,003)
3-SE O CAMPO DE USUARIO BA1_OPEORI <> PLSINTPAD(), ENTAO:
  - BUSCAR NO CADASTRO DE OPERADORAS A OPERADORA RELATIVA AO CAMPO BA1_OPEORI (CAMPO BA0_NOMINT)
  
aRet[1] := "ACOMODACAO" //ACOMODACAO (TRATAR CONFORME TIPO DE LAYOUT) - CAMPO: BI3_CODACO 
aRet[2] := "01/01/70" //CARENCIA 1 - GRUPO DE COBERTURA X CLASSE DE CARENCIA X CAMPO CUSTOMIZADO PARA CLASSIFICAR SE VAI SER IMPRESSO...
aRet[3] := "01/02/70" //CARENCIA 2 - GRUPO DE COBERTURA X CLASSE DE CARENCIA X CAMPO CUSTOMIZADO PARA CLASSIFICAR SE VAI SER IMPRESSO...
aRet[4] := "01/03/70" //CARENCIA 3 - GRUPO DE COBERTURA X CLASSE DE CARENCIA X CAMPO CUSTOMIZADO PARA CLASSIFICAR SE VAI SER IMPRESSO...
aRet[5] := "01/04/70" //NAO SERA NECESSARIO
aRet[6] := "PAD INTERN" //NAO SERA NECESSARIO
aRet[7] := "01/05/70" //DATA INICIO VIGENCIA (INCLUSAO NO PLANO)
aRet[8] := "LIVRE 01"  //OBS. 10 POSICOES...
aRet[9] := "LIVRE 02" //50 POSICOES... VERIFICAR REGRAS ABAIXO:
*/

nTamRetCar := 0

If BA1->BA1_OPEORI <> PLSINTPAD() .And. BA1->BA1_OPEDES == PLSINTPAD() .And. BA1->BA1_LOCEMI == "2"
	aRet[9] := Posicione("BA0",1,xFilial("BA0")+BA1->BA1_OPEORI,"BA0_NOMINT") 
Else
	If BA1->BA1_OPEORI == PLSINTPAD()
		If Alltrim(BI3->BI3_DESCAR) <> "CABERJ" .And. !Empty(BI3->BI3_DESCAR)
		   If Alltrim(BI3->BI3_DESCAR) == "INTEGRAL" .or. BI3->BI3_YIMPCA == "1"     // Somente para os produtos da Integral Saude. Implementado por Luzio em 18/01/08
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Segundo solicitacao de usuario, informar apenas as 3 primeiras carencias...    Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				nTamRetCar := Iif(Len(aRetCar)>3,3,Len(aRetCar))
				If nTamRetCar > 0
					For nFor := 1 to nTamRetCar
					    If !Empty(alltrim(aCodCar[nFor]))
						_cTexto := _cTexto + alltrim(UPPER(aCodCar[nFor]))+"_"                          //Descricao da Carencia1, descricao da carencia2, descricao da carencia3
						EndIf
					Next
 					aRet[9] := _cTexto
				Else                              
					//Leonardo Portella - 14/10/11 - Remover a descricao "sem carencia"
					aRet[9] := " "//"SEM CARENCIA"
				EndIf
			Else	
    			aRet[9] := Alltrim(BI3->BI3_DESCAR)
    		EndIf	
		ElseIf Alltrim(BI3->BI3_DESCAR) == "CABERJ"
			aRet[9] := Alltrim(BI3->BI3_DESCAR)

			//Leonardo Portella - 14/10/11 - Inicio
			//Tratamento das mensagens de carencia em internacao e parto

			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//ЁSe a data de carencia for maior que ou igual a data de inclusao.Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			If BA1->BA1_DATCAR >= BA1->BA1_DATINC

				//Procuro na classe de carencia 016 (INTERNACAO) o tempo de carencia
				nCarInter := Posicione('BDL',1,xFilial('BDL') + BA1->BA1_CODINT + GetNewPar("MV_YCOBINT","016"),'BDL_CARENC')

				cDesCarInt := ""

				If dDataBase < ( BA1->BA1_DATINC + nCarInter ) 
					cDesCarInt := "INTERN. (" + DtoC(BA1->BA1_DATINC + nCarInter) + ")"   
				EndIf

				//Procuro na classe de carencia 019 (PARTO) o tempo de carencia
				nCarParto := Posicione('BDL',1,xFilial('BDL') + BA1->BA1_CODINT + GetNewPar("MV_YCOBPAR","019"),'BDL_CARENC')

				cDesCarParto := ""

				If BA1->BA1_SEXO == '2' .and. dDataBase < ( BA1->BA1_DATINC + nCarParto ) 
					cDesCarParto := "PARTO (" + DtoC(BA1->BA1_DATINC + nCarParto) + ")"     
				EndIf   

				If !empty(cDesCarInt) .or. !empty(cDesCarParto)
					aRet[9] := 'CARENCIAS: '
					If !empty(cDesCarInt)
						aRet[9] += cDesCarInt + " "
					EndIf
					If !empty(cDesCarParto)
						aRet[9] += cDesCarParto
					EndIf
				EndIf

			EndIf

			/*
			nPos :=  aScan(aClaImp,{ |x| x[1] == GetNewPar("MV_YCOBINT","016")})
			If nPos <> 0
				If (aClaImp[nPos,3] > BA1->BA1_DATINC+1 .and. aClaImp[nPos,3] > dDataBase)
					aRet[9] := aRet[9]+" + CARENCIA P/ INTERNACAO"
				Endif
			Endif
			*/

			//Leonardo Portella - 14/10/11 - Fim

		Else
			If Alltrim(BI3->BI3_DESCAR) == "INTEGRAL" .or. BI3->BI3_YIMPCA == "1"   // Somente para os produtos da Integral Saude. Implementado por Luzio em 18/01/08
				//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
				//Ё Segundo solicitacao de usuario, informar apenas as 3 primeiras carencias...    Ё
				//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
				nTamRetCar := Iif(Len(aRetCar)>3,3,Len(aRetCar))
				If nTamRetCar > 0
					For nFor := 1 to nTamRetCar
					    If !Empty(alltrim(aCodCar[nFor]))
						_cTexto := _cTexto + alltrim(UPPER(aCodCar[nFor]))+"_"                          //Descricao da Carencia1, descricao da carencia2, descricao da carencia3
						EndIf
					Next
						aRet[9] := _cTexto
				Else 
					//Leonardo Portella - 14/10/11 - Remover a descricao "sem carencia"
					aRet[9] := " "//"SEM CARENCIA"
				EndIf
			Else	
	  			aRet[9] := Alltrim(BI3->BI3_DESCAR)
	  		EndIf	
		Endif
	Endif
Endif

RestArea(aAreaBA1)
RestArea(aAreaBA3)
RestArea(aAreaBI3)
RestArea(aAreaBA0)

Return aRet