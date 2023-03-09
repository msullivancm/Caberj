#INCLUDE "rwmake.ch"   
#INCLUDE "TOPCONN.CH"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA012b  บ Autor ณ Fabio Bianchini    บ Data ณ  25/09/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ IMPORTA TABELA DE MATERIAIS E MEDICAMENTOS SIMPRO          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
///BIANCHINI - 25/09/2014 - Rotina provisoria para manter o funcionamento na tabela velha. O Leonardo esta implementando em CABA012 a gravacao 
///                         para TISS 3  utilizando novas validacoes
User Function CABA012b()

Local cDirLido  := "\INTERFACE\IMPORTA\SIMPRO\PROCESSADOS\"
Local cFileDest 
Local nTipArq
Local _aArea    := GetArea()
Local cArqTmp	:= ""
Local nCont		:= 0  
Local cChar     := space(0)

Private cCodigo := GetNewPar("MV_YCDUNME","VMD")
Private cArqDbf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cString := "TRB"
cPerg	:= "CABA12" 

//Bianchini - 11/08/2014 - Retorna a maior data de tabela existente a fim de validar de estแ sendo incluida a mesma ou a anterior a ela.
/*
cQuery  := "SELECT MAX(BD4_VIGINI) DATAINI "
cQuery  += "FROM "+RETSQLNAME("BA8")+" BA8, "+ RETSQLNAME("BD4")+ " BD4 "
cQuery  += "WHERE BA8_FILIAL = '"+xFilial("BA8")+"' "
cQuery  += "AND BD4_FILIAL = '"+xFilial("BA8")+"' "
cQuery  += "AND BA8_CODTAB = '"+mv_par01+mv_par05+"' "
cQuery  += "AND BA8_CDPADP = '"+mv_par06+"' "
cQuery  += "AND BA8_CDPADP = BD4_CDPADP "
cQuery  += "AND BA8_CODPRO = BD4_CODPRO "
cQuery  += "AND BA8_CODTAB = BD4_CODTAB "
cQuery  += "AND (BD4_VIGFIM = ' ' or BD4_VIGFIM = '20501231' or BD4_VIGFIM = '20491231') "
cQuery  += "AND BA8.D_E_L_E_T_ = ' ' "
cQuery  += "AND BD4.D_E_L_E_T_ = ' ' "
*/
ValidPerg()

If !Pergunte(cPerg, .T.)
	Return
EndIf 

//Bianchini - 11/08/2014 - Carrega query acima e valida de acordo com a data de inicio de vig๊ncia do parโmetro.
/*
TcQuery cQuery New Alias "QRYMAXDATA"   

if mv_par04 < stod(QRYMAXDATA->DATAINI)
   MsgAlert("Data digitada (" + dtos(mv_par04) +") inferior a Tabela vigente do sistema ("+ QRYMAXDATA->DATAINI +") Operacao abortada!") 
   Return
Endif 

QRYMAXDATA->(dbCloseArea())
*/

cArqDbf := AllTrim(mv_par07)
nPos := AT(".DBF",Upper(cArqDbf))
If !File(cArqDbf)
	MsgBox('Arquivo '+cArqDbf+' nao encontrado. Verifique.','Erro no Processo','ALERT')
	Return
EndIf
If nPos == 0
	MsgBox('Arquivo '+cArqDbf+' invalido. So eh possivel importar arquivo com a extensao DBF. Verifique.','Erro no Processo','ALERT')
	Return
EndIf

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Grava BR8 - Tabela Padrao                                                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
BD3->(DbSetOrder(1))
If !BD3->(MsSeek(xFilial("BD3")+mv_par06))
	MsgAlert("Unidade de medida de saude informada invalida. Operacao abortada!")
	Return
Endif
*/

If !MsgBox('Este programa ira importar a tabela de Medicamentos e Materias do SIMPRO. '+CHR(13)+'Deseja Continuar?', "Confirma processamento?","YESNO")
	Return
EndIf

//123123456789012345678901234567890123456789012345123456789012345678901234567890123456789012345678901234567890123456789012345678901234123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123451234
//1...+....0....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+
//0000004662     ;0000004662     ;ACIDO ACETICO 2% 1000ML                                                                                                                                                                                 ;21012009;F       ;300      ;000      ;000      ;0003     ;0000     ;0003     ;GL      ;ML       ;100000    ;100       ;000      ;A      ;D.G.L                         ;0000004662    ;50        ;000      

For nCont := Len(alltrim(cArqdbf)) to 0 step -1
	cChar := Substr(cArqdbf,nCont,1)
	If cChar $ "/\"
		Exit
	Endif
Next
//cArqTmp := Left(cArqDbf,nCont)
cArqTmp := Substr(cArqDbf,nCont+1)

cFileDest := Alltrim(cDirLido+alltrim(cArqTmp))

dbUseArea(.T.,"DBFCDXADS",cArqDbf,"TRB",.F.,.F.)
//dbUseArea(.T.,"DBFCDXADS",cArqDbf,cString,.F.,.F.)
//DBUSEAREA(,__LocalDriver, cArqTot, "TOT",.F.,.F.)


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento da importacao...                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Processa({|| CABA012IMP()},'Importando Arquivo...')

COPY FILE &cArqDbf TO &cFileDest

// Apaga fisicamente arquivo da pasta de origem apos ser copiado.
fErase(cArqdbf)

MsgBox('Importacao concluida','Fim do Processamento','ALERT')

RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA012IMPบAutor  ณFabio Bianchini     บ Data ณ  12/08/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecucao da rotina de atualizacao de TDE, composicao de     บฑฑ
ฑฑบ          ณvalores e tabela padrao.                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABA012IMP()
Local cNivel	:= "4" //"3" ---->>> 3 Era no modelo antigo. Para TUSS eh 4
Local cAnaSin	:= "1"
Local cOper	:= mv_par01
Local cTabela	:= mv_par05
Local cCodTab	:= cOper+mv_par05
Local dVigIni	:= CtoD('  /  /    ')    //mv_par04
Local dDatAtu	:= StoD("20491231")   //CtoD('  /  /    ')    //Data da Vigencia final
//cCodigo	:= mv_par06
Local cCdPaDp	:= mv_par06  //'05'
Local cClasse	:= space(06)  //"000009"
Local cCodPro	:= space(16)
Local nValor	:= 0
Local cCodUnid := space(02)
Local nTipEmb := MV_PAR03
Local nTipPrc := MV_PAR02

BD4->( dbSetOrder(1) )
BA8->( dbSetOrder(4) )
BF8->( dbSetOrder(1) )

dbSelectArea('TRB')
ProcRegua(RecCount())

dbGoTop()

Begin Transaction

While !TRB->(Eof())

	dDatAtu := StoD("20501231")
	////Bianchini - 11/08/2014 - SUBSTITUIDO PELO IF ABAIXO, DEVIDO AO DE/PARA TISS 3
	
	If cCdPaDp == "09"
	 
	    If Empty(alltrim(TRB->CD_SIMPRO))
			 TRB->(DbSkip())
			 Loop
	    Endif
	
	Else     
	    //Bianchini - 11/08/2014 - nova coluna - TISS 3(TUSS)
	    /*
	    If Empty(alltrim(TRB->CD_TUSS))
			 TRB->(DbSkip())
			 Loop
	    Endif
	    */
	    TRB->(DbSkip())
		Loop
	Endif    

	If TRB->CD_MERCADO = '70' //Perfumaria
		 TRB->(DbSkip())
		 Loop
    Endif

    If TRB->TIP_ALT = "L"
		dDatAtu := TRB->VIGENCIA
    Endif

	Do case
		Case TRB->CD_MERCADO = '20' //Material Hospitalar
			_cTpProc:= '2'
			cClasse	:= "000008"
			cCodigo := GetNewPar("MV_YCDUNMA","VMT")    //"VMT"
//		Case TRB->CD_MERCADO = '50' //Medicamentos
//			_cTpProc:= '2'
//			cClasse	:= "000008"
		Otherwise		            //Perfumaria
			_cTpProc:= '1'
			cClasse	:= "000007"                 
			cCodigo := GetNewPar("MV_YCDUNME","VMD")  //"VMD"
	Endcase

	dVigIni	:= TRB->VIGENCIA

	//Bianchini - 11/08/2014 - TISS 3 (TUSS)
	cCodPro	:= StrZero(val(TRB->CD_SIMPRO),10,0)
	//cCodPro	:= StrZero(val(TRB->CD_TUSS),8,0)
	
	nValor := 0
	If nTipEmb == 2      //Tipo de Fracao
        If nTipPrc == 1      //Preco Fabrica Fracao
			nValor	:= TRB->PC_FR_FAB   
		ElseIf nTipPrc == 2  
			nValor	:= TRB->PC_FR_VEN   //Preco Venda Embalagem
		ElseIf nTipPrc == 3  
			nValor	:= TRB->PC_FR_USU   //Preco Usuario Embalagem  //VALOR ZERADO NO ARQUIVO
		EndIf
		cCodUnid := SubStr(AllTrim(TRB->TP_FRACAO),1,2)
    Else
        If nTipPrc == 1  //Preco Fabrica Embalagem
			nValor	:= TRB->PC_EM_FAB   //Preco Fabrica Embalagem
		ElseIf nTipPrc == 2  //Preco Venda Embalagem
			nValor	:= TRB->PC_EM_VEN   //Preco Venda Embalagem
		ElseIf nTipPrc == 3  //Preco Usuario Embalagem
			nValor	:= TRB->PC_EM_USU   //Preco Usuario Embalagem  //VALOR ZERADO NO ARQUIVO
		EndIf
		cCodUnid := SubStr(AllTrim(TRB->TP_EMBAL),1,2)
	EndIf	
			
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava BA8 - TDE Cabecalho                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("BA8")
	dbSetOrder(1)
	If ! BA8->(DbSeek(xFilial("BA8") + cCodTab + cCdPaDp + cCodPro,.F.))
		BA8->(RecLock("BA8",.T.))
		BA8->BA8_FILIAL := xFilial("BA8")
		BA8->BA8_CDPADP := cCdPaDp
		BA8->BA8_CODPRO := cCodPro
		BA8->BA8_DESCRI := UPPER( ALLTRIM(TRB->DESCRICAO)+" - "+ALLTRIM(TRB->FABRICA) )
		BA8->BA8_NIVEL  := cNivel
		BA8->BA8_UNIDAD := cCodUnid
		BA8->BA8_ANASIN := cAnaSin
		BA8->BA8_CODPAD := cCdPaDp
		BA8->BA8_CODTAB := cCodTab
		BA8->BA8_CODANT := ""
		BA8->(msUnLock())
	Else
		BA8->(RecLock("BA8",.F.))
		BA8->BA8_DESCRI := UPPER( ALLTRIM(TRB->DESCRICAO)+" - "+ALLTRIM(TRB->FABRICA) )
		BA8->BA8_NIVEL  := cNivel
		BA8->BA8_UNIDAD := cCodUnid
		BA8->BA8_ANASIN := cAnaSin
		BA8->BA8_CODPAD := cCdPaDp
		BA8->BA8_CODTAB := cCodTab
		BA8->(msUnLock())
	Endif
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava BD4 - TDE Detalhe                                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//If BD4->(DbSeek(xFilial("BD4") + cCodTab + cCdPaDp + cCodPro + Space(6) + cCodigo ))
	If BD4->(DbSeek(xFilial("BD4") + cCodTab + cCdPaDp + cCodPro)) .and. (BD4->BD4_CODIGO == cCodigo)
		//While BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO)==(cCodTab+cCdPaDp+cCodPro+ Space(6)+cCodigo) .and. ! BD4->(Eof())
		While BD4->(BD4_CODTAB+BD4_CDPADP+TRIM(BD4_CODPRO)+BD4_CODIGO)==(cCodTab+cCdPaDp+cCodPro+cCodigo) .and. ! BD4->(Eof())
			BD4->(DbSkip())
		EndDo
		
		BD4->(DbSkip(-1))
		
		If BD4->BD4_VALREF <> nValor .and. nValor > 0
			
			BD4->(RecLock("BD4",.F.))
			BD4->BD4_VIGFIM := (dVigIni - 1)
			BD4->(msUnLock())
			
			BD4->(RecLock("BD4",.T.))
			BD4->BD4_FILIAL := xFilial("BD4")
			BD4->BD4_CODPRO := cCodPro
			BD4->BD4_CODTAB := cCodTab
			BD4->BD4_CDPADP := cCdPaDp
			BD4->BD4_CODIGO := cCodigo
			BD4->BD4_VALREF := nValor
			BD4->BD4_PORMED := ""
			BD4->BD4_VLMED  := 0
			BD4->BD4_PERACI := 0
			BD4->BD4_VIGINI := dVigIni
			BD4->BD4_VIGFIM := dDatAtu
			BD4->(msUnLock())
		Else
			If BD4->BD4_VIGFIM < dVigIni .and. nValor > 0
				BD4->(RecLock("BD4",.T.))
				BD4->BD4_FILIAL := xFilial("BD4")
				BD4->BD4_CODPRO := cCodPro
				BD4->BD4_CODTAB := cCodTab
				BD4->BD4_CDPADP := cCdPaDp
				BD4->BD4_CODIGO := cCodigo
				BD4->BD4_VALREF := nValor
				BD4->BD4_PORMED := ""
				BD4->BD4_VLMED  := 0
				BD4->BD4_PERACI := 0
				BD4->BD4_VIGINI := dVigIni
				BD4->BD4_VIGFIM := dDatAtu
				BD4->(msUnLock())
			Else
				BD4->(RecLock("BD4",.F.))
				BD4->BD4_VIGFIM := dDatAtu
				BD4->(msUnLock())
			Endif
		EndIf
	Else
		BD4->(RecLock("BD4",.T.))
		BD4->BD4_FILIAL := xFilial("BD4")
		BD4->BD4_CODPRO := cCodPro
		BD4->BD4_CODTAB := cCodTab
		BD4->BD4_CDPADP := cCdPaDp
		BD4->BD4_CODIGO := cCodigo
		BD4->BD4_VALREF := nValor
		BD4->BD4_PORMED := ""
		BD4->BD4_VLMED  := 0
		BD4->BD4_PERACI := 0
		BD4->BD4_VIGINI := dVigIni
		BD4->BD4_VIGFIM := dDatAtu
		BD4->(msUnLock())
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava BR8 - Tabela Padrao                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If BR8->(DbSeek(xFilial("BR8") + cCdPaDp + cCodPro ))
		BR8->(RecLock("BR8",.F.))
	Else
		BR8->(RecLock("BR8",.T.))
	Endif
	
	BR8->BR8_FILIAL := xFilial("BR8")
	BR8->BR8_CODPAD := cCdPaDp
	BR8->BR8_CODPSA := cCodPro
	BR8->BR8_DESCRI := UPPER( ALLTRIM(TRB->DESCRICAO)+" - "+ALLTRIM(TRB->FABRICA) )
	BR8->BR8_ANASIN := cAnaSin
	BR8->BR8_NIVEL  := cNivel
	BR8->BR8_CLASSE := cClasse
	BR8->BR8_BENUTL := "1"
	BR8->BR8_TPPROC := _cTpProc
	BR8->BR8_AUTORI := "1" 
	BR8->BR8_REGATD := "3"
	BR8->(MSUnLock())
	
	TRB->(dbSkip())
	IncProc()
End            

TRB->(DbCloseArea())

End Transaction

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บAutor  ณFabio Bianchini     บ Data ณ  12/08/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValidar perguntas de usuario.                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidPerg()
PutSx1(cPerg,"01","Operadora        ","","","mv_ch1","C",04,0,0,"G","NaoVazio()","B89PLS","S","","mv_par01","         ","","","0001","      ","","","       ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"02","Tipo de Preco    ","","","mv_ch2","N",01,0,0,"C","          ","      ","S","","mv_par02","Fabrica  ","","","    ","Venda ","","","Usuario","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"03","Unidade Produto  ","","","mv_ch3","N",01,0,0,"C","          ","      ","S","","mv_par03","Embalagem","","","    ","Fracao","","","       ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"04","Data Vigencia De ","","","mv_ch4","D",08,0,0,"G","          ","      ","S","","mv_par04","         ","","","    ","      ","","","       ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"05","Informe a tabela ","","","mv_ch5","C",03,0,0,"G","NaoVazio()","_F8   ","S","","mv_par05","         ","","","010 ","      ","","","       ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"06","Codigo da Tabela ","","","mv_ch6","C",02,0,0,"G","NaoVazio()","B41   ","S","","mv_par06","         ","","","06  ","      ","","","       ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"07","Arquivo          ","","","mv_ch7","C",50,0,0,"G","NaoVazio()","DIR   ","S","","mv_par07","         ","","","    ","      ","","","       ","","","","","","","","",{},{},{},"")

RETURN