#INCLUDE "TOTVS.CH"
#INCLUDE "rwmake.ch"   
#INCLUDE "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA012   บ Autor ณ Fabio Bianchini    บ Data ณ  12/08/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ IMPORTA TABELA DE MATERIAIS E MEDICAMENTOS SIMPRO          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABA012()

Local cDirLido  := "\INTERFACE\IMPORTA\SIMPRO\PROCESSADOS\"
Local cFileDest 
Local nTipArq
Local _aArea    := GetArea()
Local cArqTmp	:= ""
Local nCont		:= 0  
Local cChar     := space(0)

Private lBD4	:= .F.
Private lBA8	:= .F.
Private lBR8	:= .F.
Private cCodigo := GetNewPar("MV_YCDUNME","VMD")
Private cArqDbf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cString := "TRB"
cPerg	:= "CABA12" 

//Bianchini - 11/08/2014 - Retorna a maior data de tabela existente a fim de validar de estแ sendo incluida a mesma ou a anterior a ela.
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

ValidPerg()

If !Pergunte(cPerg,.T.)
	Return
EndIf 

//Bianchini - 11/08/2014 - Carrega query acima e valida de acordo com a data de inicio de vig๊ncia do parโmetro.
TcQuery cQuery New Alias "QRYMAXDATA"   

if mv_par04 < stod(QRYMAXDATA->DATAINI)
   MsgAlert("Data digitada (" + dtos(mv_par04) +") inferior a Tabela vigente do sistema ("+ QRYMAXDATA->DATAINI +") Operacao abortada!") 
   Return
Endif

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
Local cCodUnid 	:= space(02)
Local nTipEmb 	:= MV_PAR03
Local nTipPrc 	:= MV_PAR02
Local a_Log		:= {}
Local c_MsgLog	:= ''
Local nLidas	:= 0
Local nGravados	:= 0
Local nSCodTUSS	:= 0
Local nI		:= 0

BD4->( dbSetOrder(1) )
BA8->( dbSetOrder(4) )
BF8->( dbSetOrder(1) )

dbSelectArea('TRB')
ProcRegua(RecCount())

dbGoTop()

lSai := .F.

//Begin Transaction
BeginTran()

While !TRB->(Eof())
    
    lBD4		:= .F.
	lBA8		:= .F.
	lBR8		:= .F.
    
    If lSai 
    	Return
    EndIf
    
	nLidas++
	
	dDatAtu := StoD("20501231")
	////Bianchini - 11/08/2014 - SUBSTITUIDO PELO IF ABAIXO, DEVIDO AO DE/PARA TISS 3
	/* 
    If Empty(alltrim(TRB->CD_SIMPRO))
		 TRB->(DbSkip())
		 Loop
    Endif
    */
    
    cDescriTmp := substr(UPPER( ALLTRIM(TRB->DESCRICAO) + " - " + ALLTRIM(TRB->FABRICA) ),1,40)
	cDescriTmp := Replace(cDescriTmp,'(','')
	cDescriTmp := Replace(cDescriTmp,')','')
	cDescriTmp := Replace(cDescriTmp,'.','')
	cDescriTmp := Replace(cDescriTmp,'"','')
	cDescriTmp := Replace(cDescriTmp,"'",'')
	
	cInsTmp := "INSERT INTO TMP_COD_BRASINDICE(EMPRESA,ORIGEM,CARGA,TABELA,CODIGO,DESCR) VALUES ('" + If(cEmpAnt == '01','CAB','INT') + "','SIMPRO','-','  ','"+If(empty(TRB->CD_TUSS),' ',StrZero(val(TRB->CD_TUSS),8,0))+"','"+cDescriTmp+"')"
	
	If TcSqlExec(cInsTmp) < 0
		Alert("Erro TcSqlExec [ " + cInsTmp + " ]" + Chr(10)+Chr(13) + TCSQLError())
		DisarmTransaction()
		return
	Endif
	
    //Bianchini - 11/08/2014 - nova coluna - TISS 3(TUSS)
    If Empty(alltrim(TRB->CD_TUSS))
		 TRB->(DbSkip())
		 nSCodTUSS++
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

	//cCodPro	:= StrZero(val(TRB->CD_SIMPRO),10,0)
	
	//Bianchini - 11/08/2014 - TISS 3 (TUSS)
	cCodPro	:= StrZero(val(TRB->CD_TUSS),8,0)
	
	//Leonardo Portella - 08/09/14 - Inํcio - A tabela em que serแ incluido o procedimento deve ser determinada pela 
	//ANS atrav้s da teminologia TUSS
	
	//Ao inv้s de fazer por query, vou fazer por DbSeek para utilizar o ํndice pois a BTQ possui muitos dados.
		
	BTQ->(DbSetOrder(1))//BTQ_FILIAL+BTQ_CODTAB+BTQ_CDTERM
	
	If BTQ->(DbSeek(xFilial('BTQ') + '18' + cCodPro))//Diแrias, taxas e gases medicinais 
		cCdPaDp := BTQ->BTQ_CODTAB
		If !(_cTpProc $ '3,4,7')//Taxas,Diarias,Gases Medicinais
			_cTpProc := '3'
		EndIf
	ElseIf BTQ->(DbSeek(xFilial('BTQ') + '19' + cCodPro))//OPME e Materiais - SIMPRO SOMENTE MATERIAIS
		cCdPaDp := BTQ->BTQ_CODTAB
		If _cTpProc <> '1'//Material
			_cTpProc := '1'
		EndIf
	ElseIf BTQ->(DbSeek(xFilial('BTQ') + '20' + cCodPro))//Medicamentos
		cCdPaDp := BTQ->BTQ_CODTAB
		If _cTpProc <> '2'//Medicamento
			_cTpProc := '2'
		EndIf
	Else
		//Se nใo encontrar na terminologia ANS (BTQ) nใo inclui
		TRB->(dbSkip())
		Loop
	EndIf
	
	//Leonardo Portella - Inicio - Temporario!!!!!
	If cCdPaDp <> '19'
		TRB->(dbSkip())
		Loop
	EndIf
	//Leonardo Portella - Fim - Temporario!!!!!
	
	//Leonardo Portella - 14/01/15 - Inicio
	BR8->(DbSetOrder(1))//BR8_FILIAL, BR8_CODPAD, BR8_CODPSA, BR8_ANASIN
	If BR8->(DbSeek(xFilial("BR8") + cCdPaDp + cCodPro ))
		//Conforme definido pela Marcia, a parametrizacao mais forte sera a do Brasindice (mais barato) 
		If Substr(BR8->BR8_LEMBRE,1,10) == 'BRASINDICE'
			TRB->(dbSkip())
			Loop
		EndIf
	EndIf
	//Leonardo Portella - 14/01/15 - Fim
	
	BR4->(DbSetOrder(1))
		
	If BR4->(DbSeek(xFilial('BR4') + cCdPaDp))
		BF8->(DbSetOrder(2))//BF8_FILIAL, BF8_CODPAD, BF8_CODINT, BF8_CODIGO
		If BF8->(DbSeek(xFilial('BF8') + cCdPaDp + cOper))
			cCodTab	:= BF8->(BF8_CODINT + BF8_CODIGO)
		Else			
			c_MsgLog := 'Tabela [ ' + cCdPaDp + ' ] nใo localizada na tabela de honorarios (BF8)'
			
			If aScan(a_Log,c_MsgLog) <= 0
				aAdd(a_Log,c_MsgLog)
			EndIf
			
			//Se nใo encontrar na tabela de honorarios (BF8) nใo inclui
			TRB->(dbSkip())
			Loop
		EndIf
	Else
		c_MsgLog := 'Tabela [ ' + cCdPaDp + ' ] nใo localizada na tipos de tabela (BR4)'
			
		If aScan(a_Log,c_MsgLog) <= 0
			aAdd(a_Log,c_MsgLog)
		EndIf
		
		//Se nใo encontrar na tipos de tabela (BR4) nใo inclui
		TRB->(dbSkip())
		Loop
	EndIf
	
	//Leonardo Portella - 08/09/14 - Fim 
	
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
	EndIfด
	
	//Leonardo Portella - 12/12/14 - Inicio - Se o valor estiver zerado, nao importar
	
	If nValor <= 0
		TRB->(dbSkip())
		Loop
	EndIf
	
	//Leonardo Portella - 12/12/14 - Fim	
			
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava BA8 - TDE Cabecalho                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("BA8")
	dbSetOrder(1)
	
	cChvBA8 := xFilial("BA8") + cCodTab + cCdPaDp + cCodPro
	
	//Leonardo Portella - Inicio - Temporario!!!!!
	If BA8->(DbSeek(cChvBA8))
		While !BA8->(EOF()) .and. ( BA8->(BA8_FILIAL + BA8_CODTAB + BA8_CDPADP + BA8_CODPRO) == cChvBA8 )
			If ( cEmpAnt == '01' .and. ( BA8->(RECNO()) < 665266 ) ) .or. ( cEmpAnt == '02' .and. ( BA8->(RECNO()) < 525125 ) ) 
				BA8->(Reclock('BA8',.F.))
				BA8->(DbDelete())
				BA8->(MsUnlock())
				
				BA8->(DbSkip())
				
				lBA8 := .T.
			EndIf
		EndDo
		
		BA8->(DbGoTop())
	EndIf
	//Leonardo Portella - Fim - Temporario!!!!!
	 
	If ! BA8->(DbSeek(cChvBA8))
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
		
		lBA8		:= .T.
	Else
	
		BA8->(RecLock("BA8",.F.))
		BA8->BA8_DESCRI := UPPER( ALLTRIM(TRB->DESCRICAO)+" - "+ALLTRIM(TRB->FABRICA) )
		BA8->BA8_NIVEL  := cNivel
		BA8->BA8_UNIDAD := cCodUnid
		BA8->BA8_ANASIN := cAnaSin
		BA8->BA8_CODPAD := cCdPaDp
		BA8->BA8_CODTAB := cCodTab
		BA8->(msUnLock())
		
		lBA8		:= .T.	
	Endif
		
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava BD4 - TDE Detalhe                                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	//Leonardo Portella - Inicio - Temporario!!!!!
	If BD4->(DbSeek(xFilial("BD4") + cCodTab + cCdPaDp + cCodPro)) .and. (BD4->BD4_CODIGO == cCodigo)
		//While BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO)==(cCodTab+cCdPaDp+cCodPro+ Space(6)+cCodigo) .and. ! BD4->(Eof())
		While ! BD4->(Eof()) .and. BD4->(BD4_CODTAB+BD4_CDPADP+TRIM(BD4_CODPRO)+BD4_CODIGO)==(cCodTab+cCdPaDp+cCodPro+cCodigo)
			
			If ( cEmpAnt == '01' .and. ( BD4->(RECNO()) < 1581938 ) ) .or. ( cEmpAnt == '02' .and. ( BD4->(RECNO()) < 1372116 ) ) 
				BD4->(Reclock('BD4',.F.))
				BD4->(DbDelete())
				BD4->(MsUnlock())
				
				lBD4		:= .T.
			EndIf

			BD4->(DbSkip())
		EndDo
		
		BD4->(DbGoTop())
	EndIf
	//Leonardo Portella - Fim - Temporario!!!!!
	
	//If BD4->(DbSeek(xFilial("BD4") + cCodTab + cCdPaDp + cCodPro + Space(6) + cCodigo ))
	If BD4->(DbSeek(xFilial("BD4") + cCodTab + cCdPaDp + cCodPro)) .and. (BD4->BD4_CODIGO == cCodigo)
		//While BD4->(BD4_CODTAB+BD4_CDPADP+BD4_CODPRO+BD4_CODIGO)==(cCodTab+cCdPaDp+cCodPro+ Space(6)+cCodigo) .and. ! BD4->(Eof())
		While ! BD4->(Eof()) .and. BD4->(BD4_CODTAB+BD4_CDPADP+TRIM(BD4_CODPRO)+BD4_CODIGO)==(cCodTab+cCdPaDp+cCodPro+cCodigo)
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
			
			lBD4		:= .T.
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
				
				lBD4		:= .T.
			Else
				BD4->(RecLock("BD4",.F.))
				BD4->BD4_VIGFIM := dDatAtu
				BD4->(msUnLock())
				
				lBD4		:= .T.
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
		
		lBD4		:= .T.
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava BR8 - Tabela Padrao                                                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If BR8->(DbSeek(xFilial("BR8") + cCdPaDp + cCodPro ))
		BR8->(RecLock("BR8",.F.))
	Else
		BR8->(RecLock("BR8",.T.))
	Endif
	
	lBR8		:= .T.
	
	BR8->BR8_FILIAL := xFilial("BR8")
	BR8->BR8_CODPAD := cCdPaDp
	BR8->BR8_CODPSA := cCodPro
	BR8->BR8_DESCRI := UPPER( ALLTRIM(TRB->DESCRICAO) + " - " + ALLTRIM(TRB->FABRICA) )
	BR8->BR8_ANASIN := cAnaSin
	BR8->BR8_NIVEL  := cNivel
	BR8->BR8_CLASSE := cClasse
	BR8->BR8_BENUTL := "1"
	BR8->BR8_TPPROC := _cTpProc
	BR8->BR8_AUTORI := "1" 
	BR8->BR8_REGATD := "3"
	
	BR8->BR8_LEMBRE	:= 'SIMPRO - ' + DtoC(Date()) + ' [ ' + If(lBD4,'BD4 - ','') + If(lBA8,'BA8 - ','') + If(lBR8,'BR8','') + ' ]'//Leonardo Portella - 14/01/15
	
	BR8->(MSUnLock())
		
	nGravados++
	
	//Leonardo Portella - 12/12/14 - Inicio - Ao importar os arquivos da SIMPRO, que existem na BTQ, 
	//fazer o vinculo da TISS 3
	
	BTU->(DbSetOrder(3))//BTU_FILIAL, BTU_CODTAB, BTU_ALIAS, BTU_CDTERM
	
	lIncAltBTU := !BTU->(MsSeek(xFilial('BTU') + cCdPaDp + "BR8" + cCodPro ) )

	BTU->(Reclock('BTU',lIncAltBTU))

	BTU->BTU_FILIAL := xFilial('BTU')
	BTU->BTU_CODTAB	:= cCdPaDp
	BTU->BTU_VLRSIS	:= ( xFilial('BR8') + cCdPaDp + cCodPro ) 
	BTU->BTU_VLRBUS := cCodPro
	BTU->BTU_CDTERM	:= cCodPro
	BTU->BTU_ALIAS	:= "BR8"
	
	BTU->(MsUnlock())
	
	//Atualizo na terminologia pois o vinculo foi criado
	If BTQ->(Found())
	
		BTQ->(Reclock('BTQ',.F.))
		
		BTQ->BTQ_HASVIN = '1'
		
		BTQ->(MsUnlock())
		
	EndIf
	
	//Leonardo Portella - 12/12/14 - Fim
	
	TRB->(dbSkip())
	
	IncProc()
End            

TRB->(DbCloseArea())

EndTran()
//End Transaction
                  
//Leonardo Portella - 08/09/14 - Inํcio

If !empty(a_Log)
	c_MsgLog := ''
	For nI := 1 to len(a_Log)
		c_MsgLog += a_Log[nI] + CRLF
	Next
	MsgStop('Crํticas: ' + CRLF + c_MsgLog,AllTrim(SM0->M0_NOMECOM))
EndIf

If ( nGravados <> nLidas ) .or. ( nLidas == 0 )
	MsgStop('Registros lidos: ' + cValToChar(nLidas) + ' - Registros gravados: ' + cValToChar(nGravados) + ' - ' + ;
			'Registros sem codifica็ใo TUSS: ' + cValToChar(nSCodTUSS),AllTrim(SM0->M0_NOMECOM))
Else
	MsgInfo('Registros lidos: ' + cValToChar(nLidas) + ' - Registros gravados: ' + cValToChar(nGravados),AllTrim(SM0->M0_NOMECOM))
EndIf

//Leonardo Portella - 08/09/14 - Fim

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