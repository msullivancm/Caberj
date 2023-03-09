#include "rwmake.ch"

/*-----------------------------------------------------------------------*
* Funcao: FETRANS   | Autor : Mauricio Siqueira       | Data: 13/08/02   *
*------------------------------------------------------------------------*
* Descricao: Gera arquivo texto para aquisição de vale transporte        *
*            de acortdo com o lay-out da FETRANSPOR                      *
*------------------------------------------------------------------------*
*          ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL              *
*------------------------------------------------------------------------*
*  PROGRAMADOR  |   DATA   | MOTIVO DA ALTERACAO                         *
*------------------------------------------------------------------------*
* Siqueira      | 18/09/02 | Opção de escolher a ordem: C.Custo + Nome   *
*               |          | ou Alfabética.                              *
*------------------------------------------------------------------------*
* Siqueira      | 05/04/05 | Adaptação ao RIOCARD                        *
*------------------------------------------------------------------------*
* Hruschka      | 12/04/05 | Novas Adaptação ao RIOCARD                  *
*------------------------------------------------------------------------*/

User Function FETRANS2()

cTipo       := ""
cSeq        := "00000"
aInfo       := {}
cNL         := CHR(13)+CHR(10)
lAbortPrint := .F.
cPerg       := "FETRA3"

ValidPerg()
Pergunte(cPerg,.F.)

@ 200,001 To 380,430 Dialog oDlg Title OemToAnsi("Geracao do Arquivo FETRANSPOR")
@ 002,010 To 060,200
@ 10,017 Say OemToAnsi("Este programa ira gerar um arquivo texto, conforme a para-")
@ 18,017 Say OemToAnsi("metrizacao definida pelo usuario e Lay-Out  definido  pela")
@ 26,017 Say OemToAnsi("FETRANSPOR/RJ, visando  a  aquisicao  de  vales-transporte")
@ 34,017 Say OemToAnsi("atraves da emissao de pedido em meio magnetico.           ")

@ 70,095 BmpButton Type 01 Action CriaTXT()
@ 70,135 BmpButton Type 02 Action Close(oDlg)
@ 70,175 BmpButton Type 05 Action Pergunte(cPerg,.T.)

Activate Dialog oDlg Centered

Return

/*-----------------------------------------------------------------------*
* Funcao: CriaTXT    Autor : Mauricio Siqueira          Data: 08/10/01   *
*------------------------------------------------------------------------*
* Descrição: Criar o arquivo TXT                                         *
*------------------------------------------------------------------------*/
Static Function CriaTXT()

Private _nTot := 0
Private nHdl 
Private _cArquivo 

If Right(AllTrim(mv_par07),1) <> "\"
   MsgAlert("Local de gravacao invalido!")
   Return
Endif

_cArquivo := alltrim(mv_par07) + "vt_pedido_"
_cArquivo += iif(mv_par14==1,"cartao","papel")
_cArquivo += "_" + dtos(dDataBase) + ".txt"

nHdl := fCreate(_cArquivo)

If nHdl == -1
	MsgAlert("O arquivo "+ _cArquivo + " não pôde ser criado! Verifique os parâmetros.","Atenção !")
	Return
Endif

dbSelectArea("SRA")
If mv_par13 = 1
	dbSetOrder(8)
Else
	dbSetOrder(3)
EndIf
dbSeek(mv_par01,.t.)


// Verifica Layout a ser gerado ...
If mv_par14 = 1
	Fet_Cartao()
Else
	Fet_Papel()
EndIf

fClose(nHdl)

If _nTot <= 0
	MsgAlert("Não foi exportado nenhum registro. Verifique parametros!")
	fErase(_cArquivo)
Else
	MsgInfo("Exportado pedido de " + AllTrim(Str(_nTot)) + " funcionario(s)." + Chr(13)+Chr(10) + ;
	"Verique arquivo gerado em: " + AllTrim(MV_PAR07))
Endif
Close(oDlg)

Return


/*--------------------------------------------------------------------------*
* Função | Fet_Papel     | Autor | MAURICIO SIQUEIRA      | Data | 05/04/05 *
*---------------------------------------------------------------------------*
* Descrição: Monta arquivo para compra do Vale em Papel                     *
*---------------------------------------------------------------------------*/
Static Function Fet_Papel()

dbSelectArea("SRA")
While !EOF() .And. RA_FILIAL <= mv_par02
	cFil := RA_FILIAL
	nRegSRA := Recno()
	
	aFunc    := {}
	dbSelectArea("SR0")  // Lançamentos de Vale Transporte
	dbSetOrder(1)
	If !dbSeek(cFil)
		dbSelectArea("SRA")
		While !Eof() .and. RA_FILIAL = cFil
			dbSkip()
		Enddo
		Loop
	Else
		While !Eof() .and. R0_FILIAL = cFil
			If SR0->R0_QDIACAL <= 0 .or. SR0->R0_TIPOVAL <> "P"
				DbSkip()
				Loop
			Endif
			
			// Verifica se Funcionario está dentro dos parametros
			lSRA_Ok := .t.
			dbSelectArea("SRA")
			If !dbSeek(cFil+SR0->R0_CC+SR0->R0_MAT)
				lSRA_Ok := .f.
			Else
				// Consiste parametros
				If ((SRA->RA_MAT) < mv_par05 .Or. (SRA->RA_MAT) > mv_par06) .or. ;
					(SRA->RA_SITFOLH = "D")   .Or. !(SRA->RA_CATFUNC $ mv_par08)
					lSRA_Ok := .f.
				EndIf
			EndIf
			
			dbSelectArea("SR0")
			If lSRA_Ok
				If aScan(aFunc, SR0->R0_MAT) == 0 // Funcionario ainda nao contado
					aAdd(aFunc , SR0->R0_MAT)
				EndIf
			EndIf
			dbSkip()
		EndDo
	EndIF
	
	// Gera o primeiro registro da filial. Tipo 1   ...
	fMInfo()
	cRazao    := PADR( aInfo[03] , 40 )
	cEndereco := PADR( aInfo[04] , 38 )
	cCidade   := PADR( aInfo[05] , 20 )
	cBairro   := PADR( aInfo[13] , 17 )
	cUF       := PADR( aInfo[06] , 02 )
	cInscr    := PADL( AllTrim(aInfo[08]) , 14 , "0")
	cCep      := PADL( AllTrim(aInfo[07]) , 08 , "0")
	cAtivid   := PADL( AllTrim(aInfo[20]) , 04 , "0")
	cTelefone := StrZero(mv_par11,11)
	cMesAno   := Substr(Dtos(mv_par09),5,2)+Substr(Dtos(mv_par09),1,4)
	cSeq      := StrZero(Val(cSeq)+1,5)
	cTipo     := "1"
	cLin      := cSeq  + cInscr  + cTipo   + "0000001"+ cRazao + cEndereco + cMesAno + StrZero(Len(aFunc),5) +;
	cCep  + cBairro + cCidade + cUF      + cAtivid + cTelefone+ mv_par12 + "0000" + cNL
	
	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		If !MsgYesNo("Ocorreu um erro na gravação do arquivo "+mv_par08+".   Continua?","Atenção !")
			lContinua := .F.
			Loop
		Endif
	Endif
	
	nQtdTipo2 := 0
	nQtdVal   := 0
	nTotalVal := 0
	
	dbSelectArea("SRA")
	dbGoTo(nRegSRA)
	While !Eof() .And. RA_FILIAL = cFil
		// Consiste parametros
		If ((SRA->RA_MAT) < mv_par05 .Or. (SRA->RA_MAT) > mv_par06) .or. ;
			(SRA->RA_SITFOLH = "D")   .Or. !(SRA->RA_CATFUNC $ mv_par08)
			dbSkip()
			Loop
		EndIf
		
		DbSelectArea("SR0")  // Lançamentos de Vale Transporte
		DbSetOrder(1)
		If !DbSeek(SRA->RA_FILIAL+SRA->RA_MAT)
			dbSelectArea("SRA")
			dbSkip()
			loop
		EndIf
		
		// Gera os registros dos vales dos funcionarios. Tipo 2  ...
		_lFunc := .T.
		While !EOF() .And. SR0->R0_FILIAL == cFil .And. SR0->R0_MAT = SRA->RA_MAT
			If SR0->R0_QDIACAL <= 0 .or. SR0->R0_TIPOVAL <> "P"
				DbSkip()
				Loop
			Endif
			
			cTipo := "2"
			dbSelectArea("SRN")
			dbSetOrder(1)
			dbSeek(If(xFilial("SRN")=="  ","  ",SR0->R0_FILIAL)+SR0->R0_MEIO)
			dbSelectArea("SR0")
			
			Do Case
				Case "METRO" $ Upper(SRN->RN_DESC)
					cMod  := "M"
				Case "ONIBUS" $ Upper(SRN->RN_DESC)
					cMod  := "O"
				Case "TREM" $ Upper(SRN->RN_DESC)
					cMod  := "T"
				Case "BARCA" $ Upper(SRN->RN_DESC)
					cMod  := "B"
				OtherWise
					cMod  := "O"
			EndCase
			
			cSeq      := StrZero(Val(cSeq)+1,5)
			cQtdVal   := PADL(AllTrim(Transform(SR0->R0_QDIACAL , "9999999999999")),09,"0")
			cValTar   := PADL(AllTrim(Transform(SRN->RN_VUNIATU, "999999999999.99")),09,"0")
			nPosPonto := At(".",cValTar)
			cValTar   := Substr(cValTar,1,nPosPonto-1)+Substr(cValTar,nPosPonto+1)
			cUsoEmp   := SRA->RA_MAT + " " + Left(SRA->RA_NOME,15)
			
			cLin      := cSeq  + cInscr  + cTipo  + cMod + cQtdVal + cValTar + Space(144) + cUsoEmp + cNL
			
			If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
				Alert("Atenção ! ERRO gravando dados do funcionaario")
			Endif
			
			// contador para exibir mensagem
			If _lFunc
				_nTot++
				_lFunc := .F.
			Endif
			
			nQtdTipo2 ++
			nTotalVal += SR0->R0_VALCAL
			nQtdVal   += SR0->R0_QDIACAL
			
			DbSkip()
		EndDo
		dbSelectArea("SRA")
		dbSkip()
	EndDo
	
	cTipo     := "3"
	cSeq      := StrZero(Val(cSeq)+1,5)
	cQtdVal   := PADL(AllTrim(Transform(nQtdVal,"999999999999999")),09,"0")
	cTotalVal := PADL(AllTrim(Transform(nTotalVal,"99999999999999.99")),16,"0")
	nPosPonto := At(".",cTotalVal)
	cTotalVal := Substr(cTotalVal,1,nPosPonto-1)+Substr(cTotalVal,nPosPonto+1)
	cQtdTipo2 := PADL(AllTrim(Transform(nQtdTipo2 , "99999")),05,"0")
	cUsoEmp   := mv_par12
	cLin      := cSeq  + cInscr  + cTipo   + cQtdTipo2 + cQtdVal + cTotalVal + Space(133) + cUsoEmp + cNL
	
	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		Alert("Atenção ! ERRO gravando dados do TRAILER")
	Endif
	
	dbSelectArea("SRA")
EndDo

cLin := Replic("9",207)
If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
	Alert("Atenção ! ERRO gravando dados finais")
Endif

Return


/*--------------------------------------------------------------------------*
* Função | Fet_Cartao    | Autor | MAURICIO SIQUEIRA      | Data | 05/04/05 *
*---------------------------------------------------------------------------*
* Descrição: Monta arquivo para compra do Vale em cartao                    *
*---------------------------------------------------------------------------*/
Static Function Fet_Cartao()
Local cQrySRA := ""
Local cEnt    := CHR(13)+CHR(10)

	cSeq = "00000"
	nTot_Carga := 0

	// HEADER ...
	// Gera o primeiro registro da filial. Tipo 1   ...
	fMInfo()
	cSeq := StrZero(Val(cSeq)+1,5)
	cNr_seq_reg  := cSeq
	cTp_registro := "01"   		// Fixo
	cNm_arquivo  := "PEDIDO"	// Fixo
	cNr_versao   := mv_par15
	cNr_doc_comp := PADL( AllTrim(aInfo[08]) , 14 , "0")	// CNPJ

	cLin := cNr_seq_reg + cTp_registro + cNm_arquivo + cNr_versao + cNr_doc_comp + cNL

	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		Alert("Atenção ! ERRO gravando dados do HEADER")
		Return .F.
	EndIf

	// ITEM DO PEDIDO ...
	// Trata Registro Detalhe Tipo 02 ...
	cQrySRA := " SELECT RA_MAT, RA_CATFUNC, R0_DIASPRO, SUM(R0_QDIAINF) QDIAINF, R0_CC, R0_SALBASE, SUM(R0_VALCAL) VALCAL "	+ cEnt 
	//cQrySRA := " SELECT RA_MAT, RA_CATFUNC, R0_DIASPRO, R0_QDIAINF, R0_CC, R0_SALBASE, SUM(R0_VALCAL) VALCAL "	+ cEnt 
	//cQrySRA := " SELECT * "	+ cEnt 
	cQrySRA += "   FROM " + RetSqlName("SRA") + " SRA " + cEnt
	cQrySRA += "      , " + RetSqlName("SR0") + " SR0 " + cEnt
	cQrySRA += "  WHERE SRA.RA_FILIAL BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " + cEnt
	cQrySRA += "    AND SRA.RA_CC BETWEEN '"     + MV_PAR03 + "' AND '" + MV_PAR04 + "' " + cEnt
	cQrySRA += "    AND SRA.RA_MAT BETWEEN '"    + MV_PAR05 + "' AND '" + MV_PAR06 + "' " + cEnt
	cQrySRA += "    AND SRA.RA_SITFOLH <> 'D' "  + cEnt
	cQrySRA += "    AND SRA.RA_FILIAL  = SR0.R0_FILIAL " + cEnt
	cQrySRA += "    AND SRA.RA_MAT     = SR0.R0_MAT    " + cEnt
	cQrySRA += "    AND SRA.RA_CC      = SR0.R0_CC     " + cEnt
	cQrySRA += "    AND SR0.R0_QDIACAL <> 0            " + cEnt
	cQrySRA += "    AND SR0.R0_TPVALE  = '0'           " + cEnt
	cQrySRA += "    AND SR0.R0_PERIOD  = '" + SUBS(Dtos(mv_par17),1,6) + "'"   + cEnt
	cQrySRA += "    AND SRA.D_E_L_E_T_ = ' '           " + cEnt
	cQrySRA += "    AND SR0.D_E_L_E_T_ = ' '           " + cEnt
	//cQrySRA += "  GROUP BY RA_MAT, RA_CATFUNC, R0_DIASPRO, R0_QDIAINF, R0_CC, R0_SALBASE " + cEnt
	//cQrySRA += "  ORDER BY RA_MAT, R0_DIASPRO, R0_QDIAINF, R0_CC, R0_SALBASE " + cEnt
	cQrySRA += "  GROUP BY RA_MAT, RA_CATFUNC, R0_DIASPRO, R0_CC, R0_SALBASE " + cEnt
	cQrySRA += "  ORDER BY RA_MAT, R0_DIASPRO, R0_CC, R0_SALBASE " + cEnt

	If Select("QRYSRA") > 0 
		QRYSRA->(DbCloseArea()) 
	Endif  

	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQrySRA), 'QRYSRA', .F., .T.)

	QRYSRA->(DbGoTop())

	nVl_Carga := 0

	While !QRYSRA->(EOF())
		If QRYSRA->RA_CATFUNC $ MV_PAR08  
			//nVl_Carga := QRYSRA->R0_VALCAL
			nVl_Carga := QRYSRA->VALCAL

			If nVl_Carga > 0   
				nTot_Carga += nVl_Carga
				cSeq := StrZero(Val(cSeq)+1,5)
				cNr_seq_reg  := cSeq
				cTp_registro := "02"   		// Fixo       
				cNr_matricul := STR(VAL(QRYSRA->RA_MAT),15)  //Necessario devido a cadastro ja feito na Riocard
				cVl_carga    := PADL(AllTrim(Transform(nVl_Carga, "999999999999.99")),09,"0")
				nPosPonto    := At(".",cVl_carga)
				cVl_carga    := Substr(cVl_carga,1,nPosPonto-1)+Substr(cVl_carga,nPosPonto+1)
				
				cLin := cNr_seq_reg + cTp_registro + cNr_matricul + cVl_carga + cNL
				
				If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
					Alert("Atenção ! ERRO gravando dados do funcionario")
					Exit
				Endif
				
				// contador para exibir mensagem
				_nTot++
				_lFunc := .F.
				
			EndIf

		Endif
		QRYSRA->(DbSkip())
	Enddo
		
	// DADOS DA ENTREGA ...
	// Trata Registro Detalhe Tipo 03 ...
	If mv_par16 = 1
		cSeq := StrZero(Val(cSeq)+1,5)
		cNr_seq_reg  := cSeq
		cTp_registro := "03"   		// Fixo
		cDt_liber    := Dtos(mv_par17)
		cDt_liber    := Substr(cDt_liber,7,2)+Substr(cDt_liber,5,2)+Substr(cDt_liber,1,4)
		cTp_entrega  := If(mv_par18=1,"D","A")
		cNr_agencia  := If(mv_par18=1,"    ",mv_par19)
		cLin := cNr_seq_reg + cTp_registro + cDt_liber + cTp_entrega + cNr_agencia + cNL
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			Alert("Atenção ! ERRO gravando dados da ENTREGA")
			Return .F.
		Endif
	EndIf

	// TRAILER ...
	// Trata Registro Tipo 99 ...
	cSeq := StrZero(Val(cSeq)+1,5)
	cNr_seq_reg  := cSeq
	cTp_registro := "99"   		// Fixo
	cVl_pedido   := PADL(AllTrim(Transform(nTot_Carga, "999999999999.99")),09,"0")
	nPosPonto    := At(".",cVl_pedido)
	cVl_pedido   := Substr(cVl_pedido,1,nPosPonto-1)+Substr(cVl_pedido,nPosPonto+1)
	cLin := cNr_seq_reg + cTp_registro + "00" + cVl_pedido + cNL

	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		Alert("Atenção ! ERRO gravando dados do TRAILER")
		Return .F.
	Endif

Return

/*--------------------------------------------------------------------------*
* Função | ValidPerg     | Autor | MAURICIO SIQUEIRA      | Data | 13/08/02 *
*---------------------------------------------------------------------------*
* Descrição: Verifica a existencia das perguntas criando-as caso não existam*
*---------------------------------------------------------------------------*/
Static Function ValidPerg

Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,6)

// Grupo/Ordem/Pergunta///Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
Aadd(aRegs,{cPerg , "01" , "Filial de          ?" ,"","", "mv_ch1" , "C" , 02 ,0 ,0 , "G" , "" , "mv_par01" , "" , "00"             , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","","SM0",""})
Aadd(aRegs,{cPerg , "02" , "Filial Ate         ?" ,"","", "mv_ch2" , "C" , 02 ,0 ,0 , "G" , "" , "mv_par02" , "" , "99"             , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","","SM0",""})
Aadd(aRegs,{cPerg , "03" , "Centro Custo de    ?" ,"","", "mv_ch3" , "C" , 09 ,0 ,0 , "G" , "" , "mv_par03" , "" , "000000000"      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","","SI3",""})
Aadd(aRegs,{cPerg , "04" , "Centro Custo Ate   ?" ,"","", "mv_ch4" , "C" , 09 ,0 ,0 , "G" , "" , "mv_par04" , "" , "999999999"      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","","SI3",""})
Aadd(aRegs,{cPerg , "05" , "Matricula de       ?" ,"","", "mv_ch5" , "C" , 06 ,0 ,0 , "G" , "" , "mv_par05" , "" , "000000"         , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","","SRA",""})
Aadd(aRegs,{cPerg , "06" , "Matricula Ate      ?" ,"","", "mv_ch6" , "C" , 06 ,0 ,0 , "G" , "" , "mv_par06" , "" , "999999"         , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","","SRA",""})
Aadd(aRegs,{cPerg , "07" , "Local Gravacao Arq ?" ,"","", "mv_ch7" , "C" , 30 ,0 ,0 , "G" , "" , "mv_par07" , "" , "A:\FETRANS.TXT" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","",""   ,""})
Aadd(aRegs,{cPerg , "08" , "Categorias         ?" ,"","", "mv_ch8" , "C" , 08 ,0 ,0 , "G" , "FCategoria","mv_par08" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "","","","","","","","","","",""   ,""})
Aadd(aRegs,{cPerg , "09" , "Data Requisicao    ?" ,"","", "mv_ch9" , "D" , 08 ,0 ,0 , "G" , "naovazio" , "mv_par09" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "","","","","","","","","","",""   ,""})
Aadd(aRegs,{cPerg , "10" , "Numero do Pedido   ?" ,"","", "mv_ch0" , "C" , 07 ,0 ,0 , "G" , "" , "mv_par10" , "" , "       "         , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","","",""})
Aadd(aRegs,{cPerg , "11" , "DDD / Telefone     ?" ,"","", "mv_cha" , "N" , 25 ,0 ,0 , "G" , "" , "mv_par11" , "" , "       "         , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","","",""})
Aadd(aRegs,{cPerg , "12" , "Uso da Empresa     ?" ,"","", "mv_chb" , "C" , 25 ,0 ,0 , "G" , "" , "mv_par12" , "" , "       "         , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "   ","","","","","","","","","","",""})
Aadd(aRegs,{cPerg , "13" , "Ordem              ?" ,"","", "mv_chc" , "N" , 03 ,0 ,0 , "C" , "" , "mv_par13" , "CENTRO DE CUSTO" , "" , "" , "" , "" , "ALFABETICA",  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "14" , "Tipo               ?" ,"","", "mv_chd" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par14" , "CARTAO" , "" , "" , "" , "" , "PAPEL",  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "15" , "Versao Layout      ?" ,"","", "mv_che" , "C" , 05 ,0 ,0 , "G" , "" , "mv_par15" , "01.00" , "" , "" , "" , "" , "",  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "16" , "Gerar Dados Entrega?" ,"","", "mv_chf" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par16" , "SIM" , "" , "" , "" , "" , "NAO",  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "17" , "Data Liberacao     ?" ,"","", "mv_chg" , "D" , 08 ,0 ,0 , "G" , "naovazio" , "mv_par17" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "","","","","","","","","","",""   ,""})
Aadd(aRegs,{cPerg , "18" , "Tipo de Entrega    ?" ,"","", "mv_chh" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par18" , "DOMICILIAR" , "" , "" , "" , "" , "AGENCIA",  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "19" , "Numero Agencia     ?" ,"","", "mv_chi" , "C" , 04 ,0 ,0 , "G" , "" , "mv_par19" , "0000" , "" , "" , "" , "" , "",  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "20" , "CGC Cadastrado     ?" ,"","", "mv_chj" , "C" , 14 ,0 ,0 , "G" , "" , "mv_par20" , "" , "" , "" , "" , "" , "",  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" })
For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+"    "+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			EndIf
		Next
		MsUnlock()
	EndIf
    If aRegs[i,2] == "20"
       RecLock("SX1",.F.)
       SX1->X1_CNT01 := SM0->M0_CGC
       SX1->(MsUnlock())
    Endif

Next
dbSelectArea(_sAlias)
Return


/*-----------------------------------------------------------------------*
* Funcao: fMInfo     Autor : Mauricio Siqueira          Data: 08/10/01   *
*------------------------------------------------------------------------*
* Descrição: Recupera Dados da Empresa                                   *
*------------------------------------------------------------------------*/
Static Function fMInfo()

dbSelectArea("SM0")
While !Eof() .and. SM0->M0_CODFIL <= mv_par02
	If SM0->M0_CODFIL = xFilial("SRA") //cFil
		aInfo := {}
		Aadd(aInfo,SM0->M0_FILIAL)
		Aadd(aInfo,SM0->M0_NOME)
		Aadd(aInfo,SM0->M0_NOMECOM)
		Aadd(aInfo,SM0->M0_ENDCOB)
		Aadd(aInfo,SM0->M0_CIDCOB)
		Aadd(aInfo,SM0->M0_ESTCOB)
		Aadd(aInfo,SM0->M0_CEPCOB)
//		Aadd(aInfo,SM0->M0_CGC)
      AADD(aInfo,MV_PAR20)
		Aadd(aInfo,SM0->M0_INSC)
		Aadd(aInfo,SM0->M0_TEL)
		Aadd(aInfo,SM0->M0_FAX)
		Aadd(aInfo,SM0->M0_PRODRUR)
		Aadd(aInfo,SM0->M0_BAIRCOB)
		Aadd(aInfo,SM0->M0_COMPCOB)
		Aadd(aInfo,SM0->M0_TPINSC)
		Aadd(aInfo,SM0->M0_CNAE)
		Aadd(aInfo,SM0->M0_FPAS)
		Aadd(aInfo,SM0->M0_ACTRAB)
		Aadd(aInfo,SM0->M0_CODMUN)
		Aadd(aInfo,SM0->M0_NATJUR)
		Aadd(aInfo,SM0->M0_DTBASE)
		Aadd(aInfo,SM0->M0_NUMPROP)
		Aadd(aInfo,SM0->M0_MODEND)
		Aadd(aInfo,SM0->M0_MODINSC)
		Aadd(aInfo,SM0->M0_CAUSA)
		Aadd(aInfo,SM0->M0_INSCANT)
		Exit
	Endif
	dbSkip()
EndDo
Return


/*--------------------------------------------------------------------*
* Lay-Out do arquivo Texto gerado (PAPEL):                            *
*---------------------------------------------------------------------*
* Tipo do registro: 1 - Cabecalho                                     *
*---------------------------------------------------------------------*
* Campo          | Posicao | Tamanho | Tipo         | Formato         *
*---------------------------------------------------------------------*
* No. Sequencial | 001-005 |   05    | Numerico     | 99999           *
*---------------------------------------------------------------------*
* Inscricao      | 006-019 |   14    | Numerico     | 99999999999999  *
*---------------------------------------------------------------------*
* Fixo - 1       | 020-020 |   01    | Numerico     | 9               *
*---------------------------------------------------------------------*
* Razao Social   | 028-067 |   40    | Alfanumerico | !!!!!!!!!...    *
*---------------------------------------------------------------------*
* Endereco       | 068-105 |   38    | Alfanumerico | !!!!!!!!!...    *
*---------------------------------------------------------------------*
* Mes/Ano        | 108-111 |   06    | Numerico     | 9999            *
*---------------------------------------------------------------------*
* Quant.Funcion. | 112-116 |   05    | Numerico     | 99999           *
*---------------------------------------------------------------------*
* Cep            | 117-124 |   08    | Numerico     | 99999999        *
*---------------------------------------------------------------------*
* Bairro         | 125-141 |   17    | Alfanumerico | !!!!!!!...      *
*---------------------------------------------------------------------*
* Cidade         | 142-161 |   20    | Alfanumerico | !!!!!!!...      *
*---------------------------------------------------------------------*
* UF             | 162-163 |   02    | Alfanumerico | !!              *
*---------------------------------------------------------------------*
* Ativid.Princip.| 164-167 |   04    | Numerico     | 9999            *
*---------------------------------------------------------------------*
* DDD            | 168-171 |   04    | Numerico     | 9999            *
*---------------------------------------------------------------------*
* Complemento    | 172-178 |   07    | Numerico     | 9999999         *
*---------------------------------------------------------------------*
* Ramal          | 179-182 |   04    | Numerico     | 9999            *
*---------------------------------------------------------------------*
* Uso do Emprega.| 183-207 |   25    | Alfanumerico | !!!!!...        *
*=====================================================================*
* Tipo do registro: 2 - Item de Detalhe                               ³
*=====================================================================*
* No. Sequencial | 001-005 |   05    | Numerico     | 99999           *
*---------------------------------------------------------------------*
* Inscricao      | 006-019 |   14    | Numerico     | 99999999999999  *
*---------------------------------------------------------------------*
* Fixo - 2       | 020-020 |   01    | Numerico     | 9               *
*---------------------------------------------------------------------*
* Modulo         | 021-021 |   01    | Numerico     | 9               *
*                |         |         |              | Onde:           *
*                |         |         |              |      M - Metro  *
*                |         |         |              |      O - Onibus *
*                |         |         |              |      O - Bonde  *
*                |         |         |              |      B - Barca  *
*                |         |         |              |      T - Trem   *
*---------------------------------------------------------------------*
* Quant.de Vales | 022-030 |   09    | Numerico     | 999999999       *
*---------------------------------------------------------------------*
* Vl.da Tarifa   | 031-038 |   08    | Numerico     | 99999999        *
*---------------------------------------------------------------------*
* Uso do Empreg. | 183-207 |   25    | Alfanumerico | !!!!!...        *
*=====================================================================*
* Tipo do registro: 3 - Registro finalizador                          *
*=====================================================================*
* No. Sequencial | 001-005 |   05    | Numerico     | 99999           *
*---------------------------------------------------------------------*
* Inscricao      | 006-019 |   14    | Numerico     | 99999999999999  *
*---------------------------------------------------------------------*
* Fixo - 3       | 020-020 |   01    | Numerico     | 9               *
*---------------------------------------------------------------------*
* Qtd.Registros 2| 021-025 |   05    | Numerico     | 99999           *
*---------------------------------------------------------------------*
* Qtd. de Vales  | 026-034 |   09    | Numerico     | 999999999       *
*---------------------------------------------------------------------*
* Valor Total    | 035-049 |   08    | Numerico     | 99999999        *
*---------------------------------------------------------------------*
* Uso Empregador | 183-207 |   25    | Alfanumerico | !!!!!...        *
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Lay-Out do arquivo Texto gerado (RIOCARD):                          *
*---------------------------------------------------------------------*
* Tipo do registro: 01 - Header                                       *
*---------------------------------------------------------------------*
* Campo          | Posicao | Tamanho | Tipo         | Conteudo        *
*---------------------------------------------------------------------*
* Nr_seq_reg     | 001-005 |   05    | Numerico     | 00001           *
*---------------------------------------------------------------------*
* Tp_registro    | 006-007 |   02    | Numerico     | 01              *
*---------------------------------------------------------------------*
* Nm_arquivo     | 008-013 |   06    | Alfa         | PEDIDO          *
*---------------------------------------------------------------------*
* Nr_versao      | 014-018 |   05    | Alfa         | 01.00           * mv_par15
*---------------------------------------------------------------------*
* Nr_doc_comrd   | 019-032 |   14    | Alfa         | 00000000000000  * CNPJ
*=====================================================================*
* Tipo do registro: 02- Item do Pedido                                *
*=====================================================================*
* Campo          | Posicao | Tamanho | Tipo         | Conteudo        *
*---------------------------------------------------------------------*
* Nr_seq_reg     | 001-005 |   05    | Numerico     | 00001           *
*---------------------------------------------------------------------*
* Tp_registro    | 006-007 |   02    | Numerico     | 01              *
*---------------------------------------------------------------------*
* Nr_matricula   | 008-022 |   15    | Alfa         | 000000000999999 *
*---------------------------------------------------------------------*
* Vl_carga       | 023-030 |   08    | Alfa         | 00000000        *
*---------------------------------------------------------------------*
* Nr_doc_comrd   | 019-032 |   14    | Alfa         | 00000000000000  * CNPJ*/

