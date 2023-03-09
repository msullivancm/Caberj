/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPLSBSIDA  บAutor  ณMicrosiga           บ Data ณ  10/06/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Recebe data base para calculo da data base do faturamento  บฑฑ
ฑฑบ          ณe devolve com um mes a menos, assim, quando o usuario mudar บฑฑ
ฑฑบ          ณde faixa, so vou cobrar o novo valor no mes sub sequente... บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
                                 
User Function PLSBSIDA()
LOCAL cTipo 	 := PARAMIXB[1]
LOCAL dDatBasIda := PARAMIXB[2]
LOCAL aUsr		 := aClone(PARAMIXB[3])
LOCAL cMes		 := PARAMIXB[4]
LOCAL cAno		 := PARAMIXB[5]
LOCAL cMatricFam := PARAMIXB[6]
LOCAL nMes		 := 0
LOCAL nAno		 := 0
Local dDataEmis  := dDataBase  
     

//If Substr( cMatricFam, 5,4 ) <> '0024'
	nMes := (Val(cMes)-1)   
	nAno := (Val(cAno))   
	
	If nMes < 1
		nMes := 12
		nAno -= 1
	Endif
	
	cMes := StrZero(nMes, 2)          
	cAno := StrZero(nAno, 4)
	
	**'Verifica emissใo da ultima cobran็a'**
	dbSelectArea( "SE1" )
	dbSetOrder( 14 )         
	If dbSeek( xFilial("SE1") + cMatricFam + cAno + cMes ) 
	
		dDataEmis := SE1->E1_EMISSAO
		
	EndIf
	    /*                                        
	**'Se o reajuste foi posterior a ultima cobran็a'**
	If PercReajuste(cAno + cMes, cMatricFam ) > dDataEmis 
	
		nMes := (Val(cMes)-1)   
		
		If nMes < 1
			nMes := 12
			nAno -= 1
		Endif
		
		cMes := StrZero(nMes, 2)
		cAno := StrZero(nAno, 4)
	
	EndIf   
	  */
	dDatBasIda := ctod("01/"+cMes+"/"+cAno)   
	
//EndIf

Return(dDatBasIda)  


**'---------------------------------------------------------------------------------'**
**'---------------------------------------------------------------------------------'**
**'---------------------------------------------------------------------------------'**
Static Function PercReajuste(cAnoMes,cMatric)
Local dPerRea	:= ""
Local cTipPess	:= "J"

BHW->(DbSetOrder(2)) //Tabela de aplicacao de reajuste
BYC->(DbSetOrder(2)) //Reajustes Fx. Etaria X Subcontrato
BP7->(DbSetOrder(2)) //Reajustes Fx. Etaria X Familia
BYB->(DbSetOrder(2)) //Reajustes Fx. Etaria X Usuario

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Encarar como fisica todos que o nivel de cobranca seja na familia.	ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If BA3->BA3_COBNIV == "1"
	cTipPess := "F"
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Buscar reajustes aplicados no mes...                              	ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If BHW->(MsSeek(xFilial("BHW")+cAnoMes+PLSINTPAD()))

	While ! BHW->(Eof()) .And. BHW->(BHW_ANOMES+BHW_CODINT) == cAnoMes+'0001'//PLSINTPAD()
	
		If Substr(cMatric,5,4) >= BHW->(BHW_EMPDE) .And. Substr(cMatric,5,4) <= BHW->(BHW_EMPATE)			
				//BP7_OPEREA + BP7_CODREA + BP7_CODOPE + BP7_CODEMP + BP7_MATRIC + BP7_CODFAI
				If BP7->(MsSeek(xFilial("BP7")+PLSINTPAD()+BHW->BHW_CODREA+Substr(cMatric,1,14)))
					dPerRea := BP7->BP7_DATREA
				Endif		
				
				//BYB_OPEREA + BYB_CODREA + BYB_CODOPE + BYB_CODEMP + BYB_MATRIC + BYB_TIPREG + BYB_CODFAI
				If BYB->(MsSeek(xFilial("BYB")+cMatric))	
					dPerRea := BYB->BYB_DATREA
				Endif           			
							
		Endif
		
		BHW->(DbSkip())
		
	Enddo
	
Endif

	
Return dPerRea