
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'APWEBSRV.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'AP5MAIL.CH' 
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA614  บAutor  ณAngelo Henrique     บ Data ณ  22/03/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina criada para atender a RN412 ANS.                     บฑฑ
ฑฑบ          ณProcesso de Cancelamento de Plano e retorno de relat๓rio    บฑฑ
ฑฑบ          ณe realiza a inser็ใo do protocolo de atendimento.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA614()

	Local _aArea 		:= GetArea()

	Private c_ChvBenef	:= ""
	Private c_Canal		:= ""
	Private _cPerg		:= "CABA614"

	CABA614A(_cPerg)

	If Pergunte(_cPerg,.T.)

		If !(Empty(AllTrim(MV_PAR01)))

			c_ChvBenef  := MV_PAR01
			c_Email     := MV_PAR02
			c_PtEnt		:= MV_PAR03
			c_Canal		:= MV_PAR04

			Processa({||U_CABA614B(c_ChvBenef, c_PtEnt, c_Canal)},'Processando...')

		Else

			Aviso("Aten็ใo","Favor preencher a matricula do beneficiแrio.",{"OK"})

		EndIf

	EndIf

	RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR614A  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABA614A(cGrpPerg)

	Local aHelpPor := {} //help da pergunta
	Local _nTamMat := 0
	Local _nTamCan := 0	
	Local _nTamPot := 0	

	_nTamMat := TamSx3("BA1_CODINT")[1]
	_nTamMat += TamSx3("BA1_CODEMP")[1]
	_nTamMat += TamSx3("BA1_MATRIC")[1]

	_nTamCan := TamSx3("ZX_CANAL")[1]
	_nTamPot := TamSx3("ZX_PTENT")[1]
	_nTamEmai:= TamSx3("BA1_EMAIL")[1]


	aHelpPor := {}
	AADD(aHelpPor,"Informe o beneficiario para 	")
	AADD(aHelpPor,"realizar o bloqueio - RN 412	")	

	PutSx1(cGrpPerg,"01","Beneficiแrio: ?"			,"a","a","MV_CH1"	,"C",_nTamMat 	,0,0,"G","","CAB614","","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"02","E-mail: ?"		        ,"a","a","MV_CH2"	,"C",_nTamEmai	,0,0,"G","",""	,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
	PutSx1(cGrpPerg,"03","Porta de Entrada: ?"		,"a","a","MV_CH3"	,"C",_nTamPot	,0,0,"G","","PCA1"	,"","","MV_PAR03","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")	
	PutSx1(cGrpPerg,"04","Canal: ?"					,"a","a","MV_CH4"	,"C",_nTamCan	,0,0,"G","","PCB"	,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA614B บAutor  ณMarcela Coimbra     บ Data ณ  22/03/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina que irแ montar a tela para que as matruculas sejam  บฑฑ
ฑฑบ          ณ informadas.                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA614B(c_ChvBenef, c_PtEnt, c_Canal)

	Local _aArea 		:= GetArea()
	Local _aArBA1 		:= BA1->(GetArea())     
	Local n_Total 		:= 0
	
	Private a_Anexos := {}
	
	a_Matric := AUTPROMATR(c_ChvBenef)        
	
	For n_Count := 1 to Len( a_Matric ) 
	    c_Matric := replace(a_Matric[n_Count][2], '.', '')
	    c_Matric := replace(c_Matric, '-', '')
	 	U_BOL_BRADES(a_Matric[n_Count][10], @a_Anexos, .t.) 
	
	Next       
	
	If len(a_Anexos) > 0   
		
		c_Pro := CriaProt(c_ChvBenef, c_PtEnt, c_Canal, a_Anexos, @n_Total )       
	
		ResumoBol(c_Pro, a_Anexos[1][2], posicione( "BA1", 2, xFilial("BA1") + ALLTRIM(c_ChvBenef), "BA1_NOMUSR" ), c_ChvBenef, a_Anexos, 	AllTrim(Transform(n_Total, "@E 999,999,999.99")) )
		
	EndIf
	
	RestArea(_aArea)

Return a_Matric

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ DISP     บAutor  ณAngelo Henrique     บ Data ณ  22/03/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ marcar/desmarcar um registro.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/   
Static Function Disp()

	RecLock((_cAliTmp),.F.)

	If Marked("OK")

		(_cAliTmp)->OK := cMarca

	Else

		(_cAliTmp)->OK := ""

	Endif

	MSUNLOCK()

	oBrwTrb:oBrowse:Refresh()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA614E บAutor  ณAngelo Henrique     บ Data ณ  22/03/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ executar a cria็ใo do protocolo de atendimentoฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CriaProt(_cChvBenf, c_PtEnt, c_Canal, a_Anexo, n_Total) 

	Local _nSla 	:= 0
	Local _cSeq		:= ""
	Local _cCdAre	:= ""
	Local _cDia		:= ""
	Local _cCntPA	:= ""	
	Local _cRegAns	:= ""
	Local _aArea 	:= GetArea()
	Local _aArZX 	:= SZX->(GetArea())
	Local _aArZY 	:= SZY->(GetArea())
	Local _aArB1 	:= BA1->(GetArea())	
	Local _aArBI 	:= BI3->(GetArea())
	Local _aArCG 	:= PCG->(GetArea())
	Local _aArBL 	:= PBL->(GetArea())
	Local _aArBC 	:= BCA->(GetArea())
	Local _aArPF 	:= PCF->(GetArea())		
	Local _cTpSv	:= "1000" //Boleto
	Local _cDia	 	:= GetMV("MV_XDIAPA" ) //Possui a data atual da PA
	Local _cCntPA	:= GetMV("MV_XCNTPA" ) //Possui o contador atual da PA
	Local _cRegAns 	:= GetMV("MV_XREGANS") //Possui o n๚mero do registro na ANS
	Local c_TpDm	:= "T" //Solicita็ใo (SX5) Tipo da Demanda
	Local _cHst 	:= "000132" //Motivos Particulares
	Local _cAgenc	:= "" //Descri็ใo da Area responsแvel
	Local cAliQry	:= GetNextAlias()
	Local cQry 		:= ""              
	
	n_Total := 0

	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(xFilial("BA1") + _cChvBenf)		

		//------------------------------------------------------------------------------------------
		//Angelo Henrique - Data: 06/12/2017
		//------------------------------------------------------------------------------------------
		//Mudan็a no processo de gera็ใo do sequencial
		//conforme RN 395 - ANS
		//Novo sequencial serแ composto de:
		//------------------------------------------------------------------------------------------
		//XXXXXXAAAAMMDDNNNNNN
		//------------------------------------------------------------------------------------------
		//XXXXXX = REGISTRO DA ANS DA OPERADORA
		//AAAA = ANO
		//MM = MES
		//DD = DIA
		//NNNNNN = SEQUENCIAL QUE IDENTIFIQUE A ORDEM DE ENTRADA DA RECLAMAวรO NA OPERADORA		
		//------------------------------------------------------------------------------------------	

		_cCntPA := SOMA1(_cCntPA)

		PUTMV("MV_XCNTPA",_cCntPA) //Colocando para o Webservice sempre contar um a mais

		If cValToChar(Day(dDatabase)) <> _cDia

			_cCntPA	 := SOMA1("000000")

			PUTMV("MV_XDIAPA",cValToChar(Day(dDatabase)))				
			PUTMV("MV_XCNTPA",_cCntPA)											

		EndIf

		_cSeq := _cRegAns + DTOS(dDatabase) + _cCntPA

		//------------------------------------------
		//Pegando a quantidade de SLA
		//------------------------------------------
		DbSelectArea("PCG")
		DbSetOrder(1)
		If DbSeek(xFilial("PCG") + PADR(AllTrim(c_TpDm),TAMSX3("PCG_CDDEMA")[1]) + c_PtEnt + c_Canal + PADR(AllTrim(_cTpSv),TAMSX3("PCG_CDSERV")[1]) )

			_nSla := PCG->PCG_QTDSLA

		Else

			_nSla := 0

		EndIf

		//----------------------------------------------
		//Ponterar na Tabela de PBL (Tipo de Servi็o)
		//Pegando assim a Area
		//----------------------------------------------
		DbSelectArea("PBL")
		DbSetOrder(1)
		If DbSeek(xFilial("PBL") + PADR(AllTrim(_cTpSv),TAMSX3("PBL_YCDSRV")[1]))

			_cCdAre := PBL->PBL_AREA

			//-----------------------------------------
			//Pegando a Descri็ใo da area responsแvel
			//-----------------------------------------
			DbSelectArea("PCF")
			DbSetOrder(1)
			If DbSeek(xFilial("PCF") + PADR(AllTrim(PBL->PBL_AREA),TAMSX3("PCF_COD")[1]))

				_cAgenc := PCF->PCF_DESCRI				

			EndIf

		EndIf

		//------------------------------------------------------------------------------
		//Inicio do Processo de leitura das informa็๕es encaminhadas para grava็ใo
		//------------------------------------------------------------------------------

		DbSelectArea("SZX")
		DbSetOrder(1)
		_lAchou := DbSeek( xFilial("SZX") + _cSeq)	

		While _lAchou 

			_cCntPA	:= GetMV("MV_XCNTPA")

			PUTMV("MV_XCNTPA",SOMA1(_cCntPA))

			_cSeq := _cRegAns + DTOS(dDatabase) + _cCntPA 

			//-----------------------------------
			//Cabe็alho
			//-----------------------------------
			DbSelectArea("SZX")
			DbSetOrder(1)
			_lAchou := DbSeek( xFilial("SZX") + _cSeq)				

		EndDo 

		RecLock("SZX",.T.)

		SZX->ZX_FILIAL 	:= xFilial("SZX") 
		SZX->ZX_SEQ 	:= _cSeq
		SZX->ZX_DATDE 	:= dDataBase
		SZX->ZX_DATATE 	:= dDataBase
		SZX->ZX_HORADE 	:= STRTRAN(TIME(),":","")		
		SZX->ZX_HORATE 	:= STRTRAN(TIME(),":","")		
		SZX->ZX_NOMUSR 	:= BA1->BA1_NOMUSR
		SZX->ZX_CODINT 	:= BA1->BA1_CODINT
		SZX->ZX_CODEMP 	:= BA1->BA1_CODEMP
		SZX->ZX_MATRIC 	:= BA1->BA1_MATRIC
		SZX->ZX_TIPREG 	:= BA1->BA1_TIPREG
		SZX->ZX_DIGITO 	:= BA1->BA1_DIGITO
		SZX->ZX_TPINTEL	:= "2" //Status fechado
		SZX->ZX_YDTNASC	:= BA1->BA1_DATNAS
		SZX->ZX_EMAIL 	:= BA1->BA1_EMAIL
		SZX->ZX_CONTATO	:= AllTrim(BA1->BA1_TELEFO) + " - " + AllTrim(BA1->BA1_YTEL2) + " - " + AllTrim(BA1->BA1_YCEL) 
		SZX->ZX_YPLANO 	:= POSICIONE("BI3",1,BA1->(BA1_FILIAL+BA1_CODINT+BA1_CODPLA+BA1_VERSAO),"BI3_CODIGO+' '+BI3_DESCRI")
		SZX->ZX_TPDEM	:= c_TpDm 	//Tipo de Demanda
		SZX->ZX_CANAL	:= c_Canal  //Canal selecionado no momento da montagem da rotina
		SZX->ZX_SLA  	:= _nSla	//SLA			
		SZX->ZX_PTENT 	:= c_PtEnt  //Porta de Entrada 
		SZX->ZX_CODAREA := _cCdAre	//Codigo da Area
		SZX->ZX_YAGENC	:= _cAgenc  //Descri็ใo da Ag๊ncia
		SZX->ZX_VATEND	:= "3"    	//Seguindo o protocolo anterior (Novo PA nใo utiliza este campo)
		SZX->ZX_TPATEND := "1"		
		
		// FRED: equalizado os campos
		//If cEmpAnt = "01"
			SZX->ZX_YDTINC	:= dDataBase
		/*
		Else
			SZX->ZX_YDTINIC	:= dDataBase
		EndIf
		*/
		// FRED: fim altera็ใo
		
		SZX->ZX_RN412	:= "N" 		//Sim para facilitar a RN 412 nos processos de relat๓rios e filtros
		SZX->ZX_USDIGIT := CUSERNAME//Usuแrio que realizou a opera็ใo 

		SZX->(MsUnLock())

		//-----------------------------------
		//Itens
		//-----------------------------------
		DbSelectArea("SZY")
        
        For n_Count := 1 to Len( a_Anexo )
			
			RecLock("SZY",.T.)
	
			SZY->ZY_FILIAL 	:= xFilial("SZY") 
			SZY->ZY_SEQBA	:= _cSeq
			SZY->ZY_SEQSERV	:= strzero(n_Count, 6)
			SZY->ZY_DTSERV	:= dDataBase	
			SZY->ZY_HORASV	:= STRTRAN(TIME(),":","")
			SZY->ZY_TIPOSV	:= _cTpSv	
			SZY->ZY_OBS		:= "Segunda via do boleto Matricula: "	+ a_Anexo[n_Count][3] + " Compet๊ncia: " + a_Anexo[n_Count][4] + " Valor: "	+ a_Anexo[n_Count][5]
			SZY->ZY_HISTPAD	:= _cHst //000132
	
			SZY->(MsUnLock())  
			
			n_Total += val( a_Anexo[n_Count][5] )
			
		Next

	EndIf	

	RestArea(_aArPF)
	RestArea(_aArBC)
	RestArea(_aArBL)	
	RestArea(_aArCG) 	
	RestArea(_aArZX)
	RestArea(_aArZY)
	RestArea(_aArB1)
	RestArea(_aArBI)
	RestArea(_aArea)

Return _cSeq


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ValdTl   บAutor  ณAngelo Henrique     บ Data ณ  26/04/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ validar os campos preenchidos no envio de    oฑฑ
ฑฑบ          ณe-mail                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ValdTl( _cMail )

	Local _lRet := .T.
	Local _cMsg := ""

	If Empty(_cMail) 

		_cMsg := "Campo e-mail nใo esta preenchido, favor preencher para que o e-mail possa ser enviado."

		Aviso("Aten็ใo",_cMsg,{"OK"})

		_lRet := .F.

	EndIf

Return _lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABA614F บAutor  ณAngelo Henrique     บ Data ณ  26/04/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ enviar e-mail para o beneficiแrio.           oฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณCABERJ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABA614F(_cParam, _cParam2)

	Local _aArea 	:= GetArea()
	Local _aArBa1	:= BA1->(GetArea()) 
	Local _aArSZX	:= SZX->(GetArea())
	Local _aArSZY	:= SZY->(GetArea())
	Local _aArBI3	:= BI3->(GetArea())
	Local a_Htm		:= "" //Variavel que irแ receber o template do HTML a ser utilizado.
	Local _cTpSrv	:= "" //Primeiro tipo de servi็o criado no protocolo
	Local _nCntZy 	:= 0  //Contador utilizado para pegar o pr๓ximo n๚mero sequencial do protocolo
	Local _cTpSv 	:= "" //Tipo de Servi็o gravado no protocolo
	Local _cHst		:= "" //Hist๓rico Padrใo gravado no protocolo 
	Local _cAlias 	:= GetNextAlias()	 
	Local cQuery	:= ""
	Local _cDscPln	:= "" //Descri็ใo do plano do beneficiแrio
	Local _cMat 	:= "" //Matricula do beneficiแrio que abriu o protocolo
	Local _cTexto 	:= "" //Variแvel que irแ receber os beneficiแrios bloqueados
	Local c_To		:= _cMail //Pegando o e-mail digitado na tela
	Local c_CC		:= ""
	Local c_Assunto := "Encerramento de Plano"
	Local a_Msg		:= {}	
	Local _cCanDp	:= ""	
	Local _cEmArea	:= GetNewPar("MV_XEMAREA","hugo.paiva@caberj.com.br")

	Default _cParam := ""
	Default _cParam2:= "" //Utilizado para montar o layout do e-mail das แreas

	//NESTA ROTINA DEVO ENTRAR NO PROTOCOLO, PEGAR AS INFORMAวีES DELE PARA MONTAR O HTML.
	//DEVO VISUALIZAR SE ษ REFERENTE A TITULAR O BLOQUEIO E DESTA FORMA PEGAR TODOS OS
	//BENEFICIมRIOS QUE FORAM BLOQUEADOS NA MESMA DATA DO TITULAR E PREENCHER NO HTML

	If !Empty(_cParam)

		//Abrindo o protocolo de atendimento
		DbSelectArea("SZX")
		DbSetOrder(1)
		If DbSeek(xFilial("SZX") + _cParam )

			If Empty(_cParam2)

				If cEmpAnt == "01"

					If SZX->ZX_CODEMP $ "0024|0025|0027|0028"

						a_Htm := "\HTML\PAPREF412.HTML"

					Else   

						a_Htm := "\HTML\PAGERAL412.HTML"

					Endif

				Else

					a_Htm := "\HTML\PAINTEGRAL412.HTML"

				EndIf

			Else

				a_Htm := "\HTML\RN412.HTML" //TEMPLATE criado para as areas

			EndIf

			//----------------------------------------------------------------
			//Caso o protocolo seja para um beneficiแrio registrado 
			//irแ pegar informa็๕es pertinentes ao plano, 
			//caso contrแrio nใo irแ preenche-lo
			//----------------------------------------------------------------
			DbSelectArea("BA1")
			DbSetOrder(2)
			If DbSeek(xFilial("SZX") + SZX->ZX_CODINT + SZX->ZX_CODEMP + SZX->ZX_MATRIC + SZX->ZX_TIPREG + SZX->ZX_DIGITO)

				_cMat := SZX->ZX_CODINT + "." + SZX->ZX_CODEMP + "." + SZX->ZX_MATRIC + "-" + SZX->ZX_TIPREG + "." + SZX->ZX_DIGITO

				DbSelectArea("BI3")
				DbSetOrder(1) //BI3_FILIAL+BI3_CODINT+BI3_CODIGO+BI3_VERSAO
				If DbSeek(xFilial("BI3") + BA1->BA1_CODINT + BA1->BA1_CODPLA)

					_cDscPln := AllTrim(BI3->BI3_DESCRI)

				Else

					_cDscPln := ""

				EndIf

				//------------------------------------------------------------------------------------------------------------------------
				//Query utilizada para pegar os beneficiแrios que foram bloqueados no processo
				//caso a solicita็ใo tenha partido do titular, onde pela regra da CABERJ
				//ao bloquear o tํtular a familia inteira ้ bloqueada
				//------------------------------------------------------------------------------------------------------------------------				
				cQuery := " SELECT " 																						+ CRLF
				cQuery += "   TRIM(BA1.BA1_NOMUSR) NOME, " 																	+ CRLF
				cQuery += "   BA1.BA1_CODPLA PLANO, " 																		+ CRLF
				cQuery += "   TRIM(BI3.BI3_DESCRI) DESC_PLAN, " 															+ CRLF
				cQuery += "   BA1_CODINT||'.'||BA1_CODEMP||'.'||BA1_MATRIC||'-'||BA1_TIPREG||'.'||BA1_DIGITO MATRICULA " 	+ CRLF
				cQuery += " FROM  " 																						+ CRLF
				cQuery += "   " + RetSqlName("BA1") + " BA1 " 																+ CRLF
				cQuery += "   INNER JOIN  " 																				+ CRLF
				cQuery += "     " + RetSqlName("BI3") + " BI3 " 																+ CRLF
				cQuery += "   ON " 																							+ CRLF
				cQuery += "     BI3.BI3_FILIAL = BA1.BA1_FILIAL " 															+ CRLF
				cQuery += "     AND BI3.BI3_CODINT = BA1.BA1_CODINT  " 														+ CRLF
				cQuery += "     AND BI3.BI3_CODIGO = BA1.BA1_CODPLA  " 														+ CRLF
				cQuery += " WHERE " 																						+ CRLF
				cQuery += "   BA1.D_E_L_E_T_ = ' ' " 																		+ CRLF
				cQuery += "   AND BA1.BA1_CODINT = '" + BA1->BA1_CODINT + "' " 												+ CRLF
				cQuery += "   AND BA1.BA1_CODEMP = '" + BA1->BA1_CODEMP + "' " 												+ CRLF
				cQuery += "   AND BA1.BA1_MATRIC = '" + BA1->BA1_MATRIC + "' " 												+ CRLF				

				//---------------------------------------------------------------------------------------------
				//Se for tํtular deverแ buscar os dependentes que foram bloqueados juntamente com o titular
				//---------------------------------------------------------------------------------------------
				If BA1->BA1_TIPUSU = "T"

					cQuery += "   AND BA1.BA1_DATBLO = '" + DTOS(BA1->BA1_DATBLO) + "' "									+ CRLF

				Else

					cQuery += "   AND BA1.BA1_TIPREG = '" + BA1->BA1_TIPREG + "' " 											+ CRLF
					cQuery += "   AND BA1.BA1_DIGITO = '" + BA1->BA1_DIGITO + "' " 											+ CRLF

				EndIf

				_cTexto := "" //Limpando a variแvel	

				//-----------------------------------------------------------------------------
				//Neste momento caso tenho sido bloqueio de familia
				//vou alimentar o html na mใo vแrias vezes, para mostrar 
				//todos os beneficiแrios que foram bloqueados dentro da famํlia
				//-----------------------------------------------------------------------------
				TCQuery cQuery new Alias (_cAlias)							

				While (_cAlias)->(!Eof())

					_cTexto += '<span style="font-size: 10pt;"><strong>Nome&#58; </strong>' + (_cAlias)->NOME + '</span><br>' + CRLF
					_cTexto += '<span style="font-size: 10pt;"><strong>Plano&#58; </strong>' + (_cAlias)->DESC_PLAN + '</span><br>' + CRLF
					_cTexto += '<span style="font-size: 10pt;"><strong>Matr&iacute;cula&#58; </strong>' + (_cAlias)->MATRICULA + '</span><br><br>' + CRLF

					(_cAlias)->(DbSkip())

				EndDo

				//Pegando o primeiro registro do tipo de servi็o 
				//para poder encaminhar no e-mail
				DbSelectArea("SZY")
				DbSetOrder(1)
				If DbSeek(xFilial("SZY") + SZX->ZX_SEQ)

					DbSelectArea("PBL")
					DbSetOrder(1)
					If DBSeek(xFilial("PBL") + SZY->ZY_TIPOSV)

						_cTpSrv := PBL_YDSSRV

					EndIf

				EndIf

				_cHora := SUBSTR(SZX->ZX_HORADE,1,2) + ":" + SUBSTR(SZX->ZX_HORADE,3,2)

				_cCanDp := GetAdvFVal("PCA","PCA_DESCRI",xFilial("PCA")+SZX->ZX_PTENT,1)//IIF(SZX->ZX_PTENT = "000006", "TELEFONE", "PRESENCIAL")

				aAdd( a_Msg, { "_cBenef"	, SZX->ZX_NOMUSR			}) //Nome do Beneficiแrio			
				aAdd( a_Msg, { "_cDtDe"		, DTOC(SZX->ZX_DATDE)		}) //Data de Abertura do Protocolo
				aAdd( a_Msg, { "_cHora"		, _cHora					}) //Hora de Abertura do Protocolo
				aAdd( a_Msg, { "_cDtOnt"	, DTOC(DATE())				}) //Data da Mensalidade (Um dia anterior)
				aAdd( a_Msg, { "c_PtEnt"	, _cCanDp					}) //Descri็ใo do CANAL
				aAdd( a_Msg, { "_cProtoc"	, SZX->ZX_SEQ 				}) //N๚mero do Protocolo
				aAdd( a_Msg, { "_cPlan"		, _cDscPln 					}) //Descri็ใo do Plano do Beneficiแrio			
				aAdd( a_Msg, { "_cMat"		, _cMat						}) //Matricula do Beneficiแrio
				aAdd( a_Msg, { "_cTexto"	, _cTexto					}) //Informa็๕es beneficiแrios bloqueados																			

				//-----------------------------------------------------
				//Caso seja e-mail para as areas 
				//acrescentar aqui os emails dos responsแveis
				//-----------------------------------------------------
				If !(Empty(_cParam2))

					c_To := _cEmArea
					
				Else

					c_To += ";protocolodeatendimento@caberj.com.br"

				EndIf				

				//-----------------------------------------------------
				//Fun็ใo para envio de e-mail
				//-----------------------------------------------------
				If Env_1(a_Htm, c_To, c_CC, c_Assunto, a_Msg )

					If Empty(_cParam2)

						Aviso("Aten็ใo", "Protocolo enviado com sucesso!",{"OK"})

					EndIf

				EndIf

				//--------------------------------------------------------------------------------------------------
				//Se for e-mail para as areas nใo irแ alimentar a informa็ใo no protocolo gerado no sistema
				//--------------------------------------------------------------------------------------------------
				If Empty(_cParam2)

					//-----------------------------------------------------------------
					//Gravando mais uma linha na SZY de hist๓rico do envio de e-mail.
					//-----------------------------------------------------------------
					DbSelectArea("SZY")
					DbSetOrder(1)
					If DbSeek(xFilial("SZY") + SZX->ZX_SEQ)

						_nCntZy := 1 

						While !Eof() .And. SZX->ZX_SEQ == SZY->ZY_SEQBA						

							_nCntZy ++

							_cTpSv 	:= SZY->ZY_TIPOSV 
							_cHst	:= SZY->ZY_HISTPAD	 												

							SZY->(DbSkip())

						EndDo

						RecLock("SZY", .T.)

						SZY->ZY_SEQBA 	:= SZX->ZX_SEQ
						SZY->ZY_SEQSERV	:= STRZERO(_nCntZy,TAMSX3("ZY_SEQSERV")[1])
						SZY->ZY_DTSERV	:= dDatabase
						SZY->ZY_HORASV	:= SUBSTR(TIME(),1,2) + SUBSTR(TIME(),4,2) 
						SZY->ZY_TIPOSV	:= _cTpSv
						SZY->ZY_OBS		:= "E-mail enviado para: " + c_To
						SZY->ZY_HISTPAD	:= 	_cHst								

						SZY->(MsUnLock())

					EndIf

				EndIf

			EndIf

		EndIf

	EndIf  

	RestArea(_aArBI3)
	RestArea(_aArSZY)
	RestArea(_aArSZX)
	RestArea(_aArBa1)
	RestArea(_aArea	)

Return 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnv_1     บAutor  ณAngelo Henrique     บ Data ณ  30/03/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo generica responsavel pelo envio de e-mails.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Env_1(c_ArqTxt, c_To, c_CC, c_Assunto, a_Msg )

	Local n_It 			:= 0

	Local oMsg
	Local _cError     	:= ""
	Local l_Result    	:= .F.                   		// resultado de uma conexใo ou envio
	Local nHdl        	:= fOpen(c_ArqTxt,68)
	Local c_Body      	:= space(99999)

	Private _cServer  	:= Trim(GetMV("MV_RELSERV")) 	// smtp.ig.com.br ou 200.181.100.51

	Private _cUser    	:= GetNewPar("MV_XMAILPA", "protocolodeatendimento@caberj.com.br")
	Private _cPass    	:= GetNewPar("MV_XPSWPA" , "Caberj2017@!") 

	Private _cFrom    	:= "CABERJ PROTHEUS"
	Private cMsg      	:= ""	

	If !(nHdl == -1)

		nBtLidos := fRead(nHdl,@c_Body,99999)
		fClose(nHdl)

		For n_It:= 1 to Len( a_Msg )

			c_Body  := StrTran(c_Body, a_Msg[n_It][1] , a_Msg[n_It][2])		

		Next

		// Tira quebras de linha para nao dar problema no WebMail da Caberj
		c_Body  := StrTran(c_Body,CHR(13)+CHR(10) , "")

		// Contecta o servidor de e-mail
		CONNECT SMTP SERVER _cServer ACCOUNT _cUser PASSWORD _cPass RESULT l_Result

		If !l_Result

			GET MAIL ERROR _cError

			DISCONNECT SMTP SERVER RESULT lOk			

		Else

			SEND MAIL FROM _cUser TO c_To SUBJECT c_Assunto BODY c_Body  RESULT l_Result

			If !l_Result

				GET MAIL ERROR _cError			

			Endif

		EndIf

	Endif

Return l_Result


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA614G  บAutor  ณAngelo Henrique     บ Data ณ  28/02/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para gerar o relat๓rio presencial para o            บฑฑ
ฑฑบ          ณ benficiแrio.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABA614G(_cProtoc)

	Local _aArea 	:= GetArea()	

	Private cParams	:= ""                                                 

	Private cParIpr	:="1;0;1;Protocolo de Solicita็ใo de Cancelamento"

	cParams := SUBSTR(cEmpAnt,2,1) + ";" + _cProtoc

	DbSelectArea("SZX")
	DbSetOrder(1)		
	If DbSeek(XFilial("SZX") + _cProtoc)

		If UPPER(SZX->ZX_RN412) == "S"

			CallCrys("PROT_AT_CANC",cParams,cParIpr)

		Else

			Aviso("Aten็ใo","Este protocolo nใo ้ de cancelamento da rotina RN 412",{"OK"})

		EndIf

	EndIf

	RestArea(_aArea)

Return

// Marcela Coimbra
Static Function AUTPROMATR( c_ChvBenef )

Local aSaveArea := GetArea()
Local oDlg
Local oLbx
Local aNumRec := {}
Local oMatric
Local cMatric := CriaVar("BA1_MATANT")     
Local l_Prima := .T.

Aadd( aNumRec, {"", "", "","","","","",0,"",0, 0} )

DEFINE MSDIALOG oDlg TITLE "Usuแrios" FROM 0,0 TO 330,920 PIXEL  

dbSelectArea("BA1")
dbSetOrder(1)
If dbSeek( xFilial("BA1") + substr(c_ChvBenef, 1, 14) + "T" )
     
 	c_xMatric := BA1->( BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO )

EndIf


@ 018,005 SAY "Matricula" OF oDlg PIXEL
@ 018,030 MSGET oMatric VAR cMatric OF oDlg SIZE 100,09 PIXEL WHEN .T. PICTURE "@!" VALID VALMAT(oLbx, oMatric, cMatric) F3 "B614PL"

@ 035,005 LISTBOX oLbx FIELDS HEADER " ", "Matricula", "Nome", "Ano", "Mes", "Emissao", "Vencimento", "Valor","Descri", "RercordSE1", "RecordBA1" SIZE 501, 112 NOSCROLL OF oDlg PIXEL
oLbx:SetArray(aNumRec)
oLbx:bLine:={||{ aNumRec[oLbx:nAt,01], aNumRec[oLbx:nAt,02], aNumRec[oLbx:nAt,03], aNumRec[oLbx:nAt,04], aNumRec[oLbx:nAt,05], aNumRec[oLbx:nAt,06], aNumRec[oLbx:nAt,07], aNumRec[oLbx:nAt,08],aNumRec[oLbx:nAt,09] }}
oLbx:nAt := 1
oLbx:aColSizes := {1,70, 20, 4, 3, 10, 10, 30, 200, 30, 30}
oLbx:BLDBLCLICK := { || AUTPROExcl(oLbx) }    

If l_Prima

	l_Prima := .F.
	VALMAT(oLbx, oMatric, c_xMatric)

EndIf
              


ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg,{||oDlg:End()},{||(aNumRec:={},oDlg:End())}))
 
RestArea(aSaveArea)

Return aNumRec  


*****************************                                                                          
Static Function VALMAT(oLbx, oMatric, cMatric)   

Local (c_AliQry) := GetNextAlias()

BA1->( DbSetOrder(2) )		// BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO

If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
	BA1->( DbSetOrder(5) )		// BA1_FILIAL + BA1_MATANT + BA1_TIPANT
	If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
		MsgStop("Matricula informada nใo cadastrada...")
		oMatric:SetFocus()
	Endif
Endif

If BA1->(Found())
	
	If aScan(oLbx:AARRAY,{|x|x[11] == BA1->(RecNo())}) <= 0
	
		If !Empty( oLbx:AARRAY[1][2] )
			Aadd( oLbx:AARRAY, {"", "", "","","","","",0,"",0, 0} )
		Endif  
		
		c_Qry := " Select distinct ba1_codint, ba1_codemp, ba1_matric, ba1_tipreg , ba1_digito, "
		c_Qry += " BA1_NOMUSR nome , "
		c_Qry += " e1_anobase ano, "
		c_Qry += " e1_mesbase mes, "
		c_Qry += " e1_saldo saldo, "
		c_Qry += " to_date(e1_vencrea, 'YYYYMMDD') vencimento, "
		c_Qry += " to_date(e1_emissao, 'YYYYMMDD') emissao, "
		c_Qry += " E1_YTPEDSC descbco, "
		c_Qry += " se1.r_e_c_n_o_ recse1 "

		c_Qry += " from " + RetSqlName("BA1") + " ba1 inner join " + RetSqlName("BM1") + " bm1 on bm1_filial = ' ' "
		c_Qry += "                       and bm1_codint = ba1_codint "
		c_Qry += "                       and bm1_codemp = ba1_codemp "
		c_Qry += "                       and bm1_matric = ba1_matric   "                    
		c_Qry += "                       and bm1.d_e_l_e_t_ = ' '  "
                      
		c_Qry += "             inner join " + RetSqlName("SE1") + " se1 on e1_filial = '01' "
		c_Qry += "                       and e1_prefixo = bm1_prefix "
		c_Qry += "                       and e1_num     = bm1_numtit "
		c_Qry += "                       and e1_saldo   > 0 "
		c_Qry += "                       and E1_YTPEXP in ('L','D','H' ) "
		c_Qry += "                       and se1.d_e_l_e_t_ = ' ' "

		c_Qry += " where ba1_filial = ' ' "
		c_Qry += "       and ba1.r_e_c_n_o_ = " + str( BA1->(RecNo()) )+ " "
		c_Qry += "       and ba1.d_e_l_e_t_ = ' ' "     
		
		If Select(c_AliQry) > 0
			(c_AliQry)->(DbCloseArea())
		EndIf
		
		DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),c_AliQry,.T.,.T.)
							
		                              
		If ( c_AliQry )->( EOF() )  
		              
			Alert("Matrํcula selecionada nใo possui boletos em aberto")
			Return .T.
		
		EndIf
		
		While !( c_AliQry )->( EOF() )
                                       
			oLbx:AARRAY[Len(oLbx:AARRAY)][1] := " "
	
			oLbx:AARRAY[Len(oLbx:AARRAY)][2] := ( c_AliQry )->BA1_CODINT + "." +;
							( c_AliQry )->BA1_CODEMP + "." +;
							( c_AliQry )->BA1_MATRIC + "." +;
							( c_AliQry )->BA1_TIPREG + "-" +;
							( c_AliQry )->BA1_DIGITO
							
			oLbx:AARRAY[Len(oLbx:AARRAY)][3] := ( c_AliQry )->nome
			oLbx:AARRAY[Len(oLbx:AARRAY)][4] := ( c_AliQry )->ano
			oLbx:AARRAY[Len(oLbx:AARRAY)][5] := ( c_AliQry )->mes
			oLbx:AARRAY[Len(oLbx:AARRAY)][6] := ( c_AliQry )->emissao
			oLbx:AARRAY[Len(oLbx:AARRAY)][7] := ( c_AliQry )->vencimento
			oLbx:AARRAY[Len(oLbx:AARRAY)][8] := ( c_AliQry )->saldo 
			oLbx:AARRAY[Len(oLbx:AARRAY)][9] := ( c_AliQry )->descbco
			oLbx:AARRAY[Len(oLbx:AARRAY)][10] := ( c_AliQry )->recse1
			oLbx:AARRAY[Len(oLbx:AARRAY)][11] := BA1->( RecNo() )
			     
			( c_AliQry )->( dbSkip() )
		
		EndDo
	                  	
	EndIf
	
	oLbx:nAt := 1
	oLbx:Refresh()
	oMatric:SetFocus()
Endif

Return .T.

********************************

Static Function AUTPROExcl(oLbx)

Local aArray := Aclone( oLbx:AARRAY )     



If MsgYesNo("Deseja excluir este usuแrio ?")
	If Len(aArray) > 0
		Adel(aArray, oLbx:nAt) // deleta o item
		Asize(aArray, Len(aArray) - 1) //redimensiona o array
	Endif
Endif

If Len(aArray) == 0
	Aadd( aArray, {"", "", 0} )
Endif

oLbx:AARRAY := Aclone( aArray )
oLbx:Refresh()

Return .T.





#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ         ณ Autor ณ                       ณ Data ณ           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณLocacao   ณ                  ณContato ณ                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณAplicacao ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤยฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณAnalista Resp.ณ  Data  ณ                                               ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤลฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ              ณ  /  /  ณ                                               ณฑฑ
ฑฑณ              ณ  /  /  ณ                                               ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function ResumoBol(c_Pro, c_Em, c_No, c_Ma, a_Anexos, c_Total )

/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑ Declara็ใo de cVariable dos componentes                                 ฑฑ
ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/

Private c_Email    := c_Em
Private c_Matricul := c_Ma
Private c_Nome     := c_No
Private c_Protocol := c_Pro
Private c_Valor    := c_Total     

Private c_Tot := 0    


oFont10 	:= TFont():New("MS Sans Serif",10,10,.T.,.T.,5,.T.,5,.T.,.F.)
oFont10n 	:= TFont():New("MS Sans Serif",10,10,.T.,.F.,5,.T.,5,.T.,.F.)

oFont13F := TFont():New("MS Sans Serif",10,13,.T.,.f.,5,.T.,5,.T.,.F.)
oFont13n:= TFont():New("MS Sans Serif",10,13,.T.,.F.,5,.T.,5,.T.,.F.)
oFont15n:= TFont():New("MS Sans Serif",10,15,.T.,.T.,5,.T.,5,.T.,.F.)
oFont16 := TFont():New("MS Sans Serif",10,16,.T.,.T.,5,.T.,5,.T.,.F.)
oFont16n:= TFont():New("MS Sans Serif",10,16,.T.,.F.,5,.T.,5,.T.,.F.)
oFont21 := TFont():New("MS Sans Serif",10,21,.T.,.T.,5,.T.,5,.T.,.F.)



/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑ Declara็ใo de Variaveis Private dos Objetos                             ฑฑ
ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
SetPrvt("oDlg1","oPanel1","oSay1","oSay4","o_Protocolo","oPanel2","oSay2","o_Matricula","oSay3","o_Nome")
SetPrvt("oSay5","oSay7","o_Valor","oBrw1","oPanel4","oSay6","o_Email","oPanel5","oConfirma","oFechar")


/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑ Definicao do Dialog e todos os seus componentes.                        ฑฑ
ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
oDlg1      := MSDialog():New( 101,348,595,1029,"oDlg1",,,.F.,,,,,,.T.,,,.T. )
oPanel1    := TPanel():New( 004,004,"",oDlg1,,.F.,.F.,,,328,020,.T.,.F. )
oSay1      := TSay():New( 008,004,{||"Envio de segunda via de Boleto"},oPanel1,,oFont13F,.F.,.F.,.F.,.T.,CLR_GREEN,CLR_WHITE,124,008)
oSay4      := TSay():New( 008,184,{||"Protocolo: "	},oPanel1,,oFont10N,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
o_Protocolo:= TSay():New( 008,225,{||c_Protocol		},oPanel1,,oFont15n,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,108,008) 


oPanel2    := TPanel():New( 028,004,"",oDlg1,,.F.,.F.,,,328,020,.T.,.F. )                                  
oSay2      := TSay():New( 008,004,{||"Matrํcula:"	},oPanel2,,oFont10N,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)  
o_Matricul := TSay():New( 008,035,{||c_Matricul		},oPanel2,,oFont10,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,070,008)
oSay3      := TSay():New( 008,108,{||"Nome:"		},oPanel2,,oFont10N,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
o_Nome     := TSay():New( 008,130,{||c_Nome			},oPanel2,,oFont10,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,196,008)

oPanel3    := TPanel():New( 052,004,"",oDlg1,,.F.,.F.,,,328,136,.T.,.F. )
oSay5      := TSay():New( 008,004,{||"Dados dos Boletos"},oPanel3,,oFont10,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,086,008)
  
										
@ 074,10 LISTBOX oLbx FIELDS HEADER ;
   "Matrํcula", "Nome", "Competencia","Valor" ;  	//nome do cabecalho
   SIZE 315 , 100 OF oDlg1 PIXEL	      
   
//define com qual vetor devera trabalhar
oLbx:SetArray( a_Anexos )
//lista o conteudo dos vetores, variavel nAt eh a linha pintada (foco) e o numero da coluna
oLbx:bLine := {|| {a_Anexos[oLbx:nAt,3],;
                   a_Anexos[oLbx:nAt,6],;
                   a_Anexos[oLbx:nAt,4],;
                   a_Anexos[oLbx:nAt,5]}}										 

oPanel4    := TPanel():New( 192,004,"",oDlg1,,.F.,.F.,,,328,020,.T.,.F. )
oSay6      := TSay():New( 008,004,{||"E-mail:"},oPanel4,,oFont10N,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
o_Email    := TSay():New( 008,032,{||c_Email},oPanel4,,oFont13n,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,288,008)

oPanel5    := TPanel():New( 216,004,"",oDlg1,,.F.,.F.,,,328,020,.T.,.F. )
oConfirma  := TButton():New( 004,264,"Confirma envio",oPanel5,{|| fEnviaBol( c_Nome, c_Protocol, c_Email, a_Anexos ) , oDlg1:End()},057,012,,,,.T.,,"",,,,.F. )  

oFechar    := TButton():New( 004,192,"Cancela",oPanel5,,065,012,,,,.T.,,"",,,,.F. )
oVisualiza := TButton():New( 004,004,"Visualizar Boletos",oPanel5,,076,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.)

Return      


Static Function fEnviaBol(c_Nome, c_Prot, c_Email, a_Anexos )
**'---------------------------------------------------------------------'**
	Local cHtmlModelo  	:= " "                                              
	Local cCodProcesso 	:= "000001"                     
	Local c_Assunto		:= " "   
	Local c_ItGuias		:= " "                                
	Local c_ItApro		:= " "                                       
	Local c_ItFin 		:= " "  
	Local c_Html        := " " 
	
   	//Prepare Environment Empresa "02" Filial "01" 
	
 	c_To := c_Email //;esther_csm@hotmail.com;alanjpl@yahoo.com.br" 
//	c_To := "coimbra.marcela@gmail.com"//;esther_csm@hotmail.com;alanjpl@yahoo.com.br" 
	//c_To := "coimbra.marcela@gmail.com;esther_csm@hotmail.com;alanjpl@yahoo.com.br" 

	cHtmlModelo  	:= "\HTML\BLT_SEGUNDA.HTML"
	c_Assunto		:= "Segunda via de boleto Caberj"      
	
	oProcess := TWFProcess():New(cCodProcesso, c_Assunto) 
	oProcess:NewTask(c_Assunto, cHtmlModelo)  
				
	oProcess:oHtml:ValByName( "c_Nome" 		, c_Nome 	) 		
	oProcess:oHtml:ValByName( "c_Prot"		, c_Prot 	) 		
	oProcess:oHtml:ValByName( "c_Dia" 		, dtoc(date()) 	) 		

	  //Percorre os anexos
        For n_Atual := 1 To Len(a_Anexos)
            //Se o arquivo existir
            If File(a_Anexos[n_Atual][1])
             
                //Anexa o arquivo na mensagem de e-Mail
                nRet := oProcess:AttachFile(a_Anexos[n_Atual][1])  
                
                If !nRet
                   // cLog += "002 - Nao foi possivel anexar o arquivo '"+a_Anexos[n_Atual]+"'!" 
                EndIf
             
            //Senao, acrescenta no log
            Else
                //cLog += "003 - Arquivo '"+a_Anexos[nAtual]+"' nao encontrado!" 
            EndIf
        Next
                   

   //	xRet := oProcess:AttachFile(c_PDF)   
	

		oProcess:cSubject := c_Assunto
		oProcess:cTo := c_To

		cMailID := oProcess:Start("\workflow\boleto_lote")   
		
		//c_Processo    := oProcess:fProcessID 
		
		oProcess:Finish()         
		
		Aviso("Aten็ใo","E-mail enviado para " + c_To +".",{"OK"})
		
  	   //	RESET ENVIRONMENT
		
	   //	C:= 1 + AAAA

Return cMailID  
