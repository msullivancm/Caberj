#include "rwmake.ch"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// funcao:    SRAVTTXT()                                                                                       //
// descricao: gera arquivo texto com informacoes dos usuarios para a FETRANPOR versão 03.00                    //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

User Function SRAVTTXT()

// Declaracao de Variaveis
Local _aArea     := GetArea()
Local _aAreaSRA  := SRA->(GetArea())
Local _aAreaSR0  := SR0->(GetArea())
Local _aStru     := {}
Private _oGeraTxt
Private _cString := "SRA"
Private _cPerg   := "SRATXT"

dbSelectArea("SRA")
dbSetOrder(1)
_aStru := SRA->(DbStruct())

// verifica se existe o campo RA_MSEXP
_nPos := ASCAN(_aStru,{|x| x[1] == "RA_MSEXP"})
If _nPos <= 0
	MsgAlert("Nao existe o campo RA_MSEXP. Impossivel continuar!")
	Return
Endif

// verifica se existe o campo RA_RIOCARD
_nPos := ASCAN(_aStru,{|x| x[1] == "RA_RIOCARD"})
If _nPos <= 0
	MsgAlert("Nao existe o campo RA_RIOCARD. Impossivel continuar!")
	Return
Endif

// cria perguntas
ValidPerg()
Pergunte(_cPerg,.F.)

// Montagem da tela de processamento
@ 200,001 TO 380,380 DIALOG _oGeraTxt TITLE OemToAnsi("Geração de Arquivo Texto")
@ 002,010 TO 080,190
@ 010,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 018,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 026,018 Say " funcionarios para a FETRANSPOR - RioCard                      "
@ 070,098 BMPBUTTON TYPE 05 ACTION Pergunte(_cPerg,.T.)
@ 070,128 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
@ 070,158 BMPBUTTON TYPE 02 ACTION Close(_oGeraTxt)
ACTIVATE DIALOG _oGeraTxt CENTERED

// retorna
RestArea(_aAreaSRA)
RestArea(_aAreaSR0)
RestArea(_aArea)
Return

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function OkGeraTxt()

// declaracao de variaveis
Private _cArquivo
Private _nHdl
Private _cEOL   := &("CHR(13)+CHR(10)")
Private _cDia   := StrZero(Day(date()),2)
Private _cMes   := StrZero(Month(date()),2)
Private _cAno   := StrZero(Year(date()),4)
Private _cData  := _cDia+_cMes+_cAno
Private _cHora  := Substr(Time(),1,2)+Substr(Time(),4,2)
Private _cCGC   := StrZero(Val(MV_PAR01),14)
Private _nExp   := 0

// verifica local de gravacao do arquivo TXT
If Right(AllTrim(MV_PAR06),1) <> "\"
	MsgAlert("Local de gravação do arquivo incorreto, Verifique!")
	Return
Endif

// cria arquito TXT
If MV_PAR09 == 1  //"03.01"
	_cArquivo := AllTrim(MV_PAR06) + "CADUSU_0301_"+_cCGC+"_"+_cData+"_"+_cHora+".txt"
Else
	_cArquivo := AllTrim(MV_PAR06) + "CADUSU_0200_"+_cCGC+"_"+_cData+"_"+_cHora+".txt"
Endif
_nHdl     := fCreate(_cArquivo)
If _nHdl == -1
	MsgAlert("O arquivo de nome "+ _cArquivo +" nao pode ser executado! Verifique os parametros.","Atencao!")
	Return
Endif

// inicia processamento
Processa({|| fRunCont() },"Processando...")
Close(_oGeraTxt)

Return


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function fRunCont()

// declaracao de variaveis
Local _cLin
Local _cSeq  := "00001"

dbSelectArea("SRA")
SRA->(dbGoTop())

// cria header do arquivo
If MV_PAR09 == 1 //"03.01"
	_cLin := _cSeq			// sequencia das linhas
	_cLin += "01"			// tipo de registro (constante 01)
	_cLin += "CADUSU"		// nome do arquivo
	_cLin += "03.01"		// numero da versao do layout
	_cLin += _cCGC			// CNPJ da empresa
Else
	_cLin := "01"			// tipo de registro (constante 01)
	_cLin += "CADUSU"		// nome do arquivo
	_cLin += "02.00"		// numero da versao do layout
	_cLin += _cCGC			// CNPJ da empresa
	_cLin += _cData      // data da geracao
	_cLin += _cHora      // hora da geracao
Endif
_cLin += _cEOL

// grava linha no TXT
If fWrite(_nHdl,_cLin,Len(_cLin)) != Len(_cLin)
	If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
		Return
	Endif
Endif

// posiciona no primeiro registro caso filial e matricula forem informados
If MV_PAR10 <> "  "
   If !DbSeek(MV_PAR10+MV_PAR03)
      DbSeek(MV_PAR10,.T.)
   Endif
Endif

// Numero de registros a processar
ProcRegua(SRA->(RecCount()))
While !SRA->(EOF()) .And. SRA->RA_FILIAL >= MV_PAR10 .And. SRA->RA_FILIAL <= MV_PAR11
	
	// incrementa regua
	IncProc(SRA->RA_FILIAL + " " + SRA->RA_MAT + " " + SRA->RA_NOME)
	
	// filtra funcionarios que ja foram enviados
	If MV_PAR02 == 1  // somente registros nao enviados
		If !Empty(SRA->RA_MSEXP)
			SRA->(DbSkip())
			Loop
		Endif
		_lNew := .T.
	Else
		If Empty(SRA->RA_MSEXP)
			_lNew := .T.
		Else
			_lNew := .F.
		Endif
	Endif
	
	// filra funcionarios de/ate
	If SRA->RA_MAT < MV_PAR03 .Or. SRA->RA_MAT > MV_PAR04
		SRA->(DbSkip())
		Loop
	Endif
	
	// filtra funcionarios demitidos
	If SRA->RA_SITFOLH == "D"
		SRA->(DbSkip())
		Loop
	Endif
	
	// verifica se funcionario possui vale transporte de cartao
	DbSelectArea("SR0")
	DbSetOrder(1)  // R0_FILIAL + R0_MAT + R0_MEIO
	DbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
	_lValeCard := .F.
	While !SR0->(Eof()) .And. SR0->R0_FILIAL+SR0->R0_MAT == SRA->RA_FILIAL+SRA->RA_MAT
		If SR0->R0_TIPOVAL == "C"
			_lValeCard := .T.
			Exit
		Endif
		SR0->(DbSkip())
	End
	
	DbSelectArea("SRA")
	If !_lValeCard
		SRA->(DbSkip())
		Loop
	Endif
	
	// soma linhas
	_cSeq := Soma1(_cSeq)
	
	// busca valor total de vale transporte usado por dia
	// definido para enviar zerado juntamente com
	_nValor := 0
	_cValor := StrZero(Int(_nValor*100),6)
	
	// busca codigo da cidade onde sera feita  a recarga
	// Ver codigos na tabela 01, e disponibilidade na tabela 03
	_cCidade := "02"  // rio de janeiro
	
	// busca codigo da rede de recarga
	// ver codigos na tabela 02, e disponibilidade na tabela 03
	_cRede := "01"  // onibus
	
	// busca codigo do tipo de impressao que sera feita no cartao solicitado
	// ver codigos na tabela 04
	_cImpressao := StrZero(MV_PAR05,2)
	
	// data de nascimento do funcionario
	_cDiaN     := StrZero(Day(SRA->RA_NASC),2)
	_cMesN     := StrZero(Month(SRA->RA_NASC),2)
	_cAnoN     := StrZero(Year(SRA->RA_NASC),4)
	_cDataNasc := _cDiaN+_cMesN+_cAnoN
	
	// header do usuario - dados principais
	If MV_PAR09 == 1 //"03.01"
		_cLin := _cSeq											// sequencia - numero da linha
		If _lNew
			_cLin += "02"										// tipo reg: 02 - inclusao de usuario, dados principais
		Else
			_cLin += "03"										// tipo reg: 04 - alteracao de uuario, dados principais
		Endif
		//_cLin += SRA->RA_MAT+Space(15-Len(SRA->RA_MAT))			// matricula com brancos a direita
		_cLin += STR(VAL(SRA->RA_MAT),15)                       // Alterado em 21/07/2005 por Cleverson
		_cLin += LEFT(SRA->RA_NOME,40)							// nome com brancos a direita
		_cLin += SRA->RA_CIC									// cpf
		_cLin += _cValor										// valor do uso diario em centavos
		_cLin += _cCidade    									// codigo da cidade
		_cLin += _cRede											// codigo da rede
		_cLin += SRA->RA_RIOCARD								// numero do cartao RioCard caso for reutilizado
		_cLin += _cImpressao									// codigo do tipo de impressao
		If _cImpressao <> "04"
			_cLin += Space(08) 										// data de nascimento
			_cLin += " "          									// sexo
			_cLin += Space(15)										// carteira de identidade
			_cLin += Space(06)							   		    // orgao emissor
			_cLin += Space(03)										// ddd do telefone
			_cLin += Space(10)										// telefone de contato
			_cLin += Space(60)										// e-mail
		Else
			_cLin += _cDataNasc										// data de nascimento
			_cLin += SRA->RA_SEXO									// sexo
			_cLin += SRA->RA_RG										// carteira de identidade
			_cLin += "      "							   		    // orgao emissor
			_cLin += MV_PAR07										// ddd do telefone
			_cLin += MV_PAR08										// telefone de contato
			_cLin += SRA->RA_EMAIL+Space(60-Len(SRA->RA_EMAIL))	// e-mail
		Endif
	Else
		_cLin := "02"												// tipo reg: 02 - inclusao de usuario, dados principais
		//_cLin += SRA->RA_MAT+Space(15-Len(SRA->RA_MAT))			// matricula com brancos a direita
		_cLin += STR(VAL(SRA->RA_MAT),15)                       // Alterado em 21/07/2005 por Cleverson
		_cLin += SRA->RA_NOME+Space(60-Len(SRA->RA_NOME))							// nome com brancos a direita
		_cLin += SRA->RA_CIC									// cpf
		_cLin += _cValor										// valor do uso diario em centavos
		_cLin += _cCidade    									// codigo da cidade
		_cLin += _cRede											// codigo da rede
		_cLin += SRA->RA_RIOCARD								// numero do cartao RioCard caso for reutilizado
	Endif
	_cLin += _cEOL
	
	// grava linha no TXT
	If fWrite(_nHdl,_cLin,Len(_cLin)) != Len(_cLin)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
			Exit
		Endif
	Endif
	
	// grava campo de registro ja exportado
	DbSelectArea("SRA")
	If RecLock("SRA",.F.)
		SRA->RA_MSEXP := DTOS(dDataBase)
		SRA->(MsUnlock())
	Endif
	
	// proximo registro
	_nExp++
	SRA->(dbSkip())
	
End

// cria linha final do arquivo
_cSeq := Soma1(_cSeq)
If MV_PAR09 == 1 //"03.01"
   _cLin := _cSeq			// sequencia das linhas
   _cLin += "99"			// tipo de registro (constante 99)
Else
   _cLin := "99"
   _cLin += _cSeq			// quantidade de linhas incluindo header e trailler
Endif
_cLin += _cEOL

// grava linha no TXT
If fWrite(_nHdl,_cLin,Len(_cLin)) != Len(_cLin)
	If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
		Return
	Endif
Endif

// fecha arquivo texto
fClose(_nHdl)

// exibe mensagem de total de funcionarios exportados
If _nExp <= 0
	MsgAlert("Nao foi exportado nenhum funcionario." + _cEOL + "Arquivo nao foi gerado!")
	fErase(_cArquivo)
Else
	MsgInfo("Exportado " + AllTrim(Str(_nExp)) + " funcionario(s) no arquivo: " + _cEOL +;
	"Verifique arquivo gerado no diretorio " + AllTrim(MV_PAR06))
Endif

Return


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Static Function ValidPerg()
Local aRegs := {}
Local i,j
dbSelectArea("SX1")
dbSetOrder(1)

//cPerg := PADR(_cPerg,6)  Alterado de 6 para Len(SX1->X1_GRUPO) em 23/09/2013 OSP
cPerg := PADR(_cPerg, Len(SX1->X1_GRUPO) )  

AADD(aRegs,{cPerg,"01","CGC cadastrado:     ","","","MV_CH1","C",014,0,1,"G","","MV_PAR01",""           ,"","","","",""            ,"","","","",""              ,"","","","",""             ,"","","","","","","","",""   ,""})
AADD(aRegs,{cPerg,"02","Envia somente novos:","","","MV_CH2","N",001,0,1,"C","","MV_PAR02","Sim"        ,"","","","","Nao"         ,"","","","",""              ,"","","","",""             ,"","","","","","","","",""   ,""})
AADD(aRegs,{cPerg,"03","Funcionario de:     ","","","MV_CH3","C",006,0,1,"G","","MV_PAR03",""           ,"","","","",""            ,"","","","",""              ,"","","","",""             ,"","","","","","","","","SRA",""})
AADD(aRegs,{cPerg,"04","Funcionario ate:    ","","","MV_CH4","C",006,0,1,"G","","MV_PAR04",""           ,"","","","",""            ,"","","","",""              ,"","","","",""             ,"","","","","","","","","SRA",""})
AADD(aRegs,{cPerg,"05","Tipo Impressão:     ","","","MV_CH5","N",001,0,1,"C","","MV_PAR05","01-PORTADOR","","","","","02-COMPRADOR","","","","","03-FUNCIONARIO","","","","","04-INDIVIDUAL","","","","","","","","",""   ,""})
AADD(aRegs,{cPerg,"06","Local gravacao arq: ","","","MV_CH6","C",030,0,1,"G","","MV_PAR06",""           ,"","","","",""            ,"","","","",""              ,"","","","",""             ,"","","","","","","","",""   ,""})
AADD(aRegs,{cPerg,"07","DDD (para contato): ","","","MV_CH7","C",003,0,1,"G","","MV_PAR07",""           ,"","","","",""            ,"","","","",""              ,"","","","",""             ,"","","","","","","","",""   ,""})
AADD(aRegs,{cPerg,"08","Telefone p/ contato:","","","MV_CH8","C",015,0,1,"G","","MV_PAR08",""           ,"","","","",""            ,"","","","",""              ,"","","","",""             ,"","","","","","","","",""   ,""})
AADD(aRegs,{cPerg,"09","LayOut do arquivo:  ","","","MV_CH9","N",001,0,1,"C","","MV_PAR09","03.01"      ,"","","","","02.00"       ,"","","","",""              ,"","","","",""             ,"","","","","","","","",""   ,""})
AADD(aRegs,{cPerg,"10","Filial de:          ","","","MV_CHA","C",002,0,1,"G","","MV_PAR10",""           ,"","","","",""            ,"","","","",""              ,"","","","",""             ,"","","","","","","","","SM0",""})
AADD(aRegs,{cPerg,"11","Filial ate:         ","","","MV_CHB","C",002,0,1,"G","","MV_PAR11",""           ,"","","","",""            ,"","","","",""              ,"","","","",""             ,"","","","","","","","","SM0",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
	If aRegs[i,2] == "01"
		RecLock("SX1",.F.)
		SX1->X1_CNT01 := SM0->M0_CGC
		SX1->(MsUnlock())
	Endif
Next
Return
