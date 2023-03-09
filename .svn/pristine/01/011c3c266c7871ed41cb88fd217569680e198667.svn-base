#Define CRLF Chr(13)+Chr(10)
#INCLUDE "rwmake.ch"
#include "PROTHEUS.CH"
#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CABR185  บ Autor ณ Altamiro Affonso   บ Data ณ  10/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de extrato de comissใo - conferencia             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CABR277()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//   @ nLin,001 PSAY ctraco80
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de audiencias dos processos juridicos por origem , tipo  "
	Local cDesc3         := "fazendo tratando alguns filtro a serem definidos "
	Local titulo         := "Relatorio de audiencia de processos  Analitico "
//Local titulo         := "Relatorio de audiencia de processos  Analitico - Escritorio : < Nome Estritorio >"

	Local Cabec1         := " Autor                        Num. Processo              Tp Vara   Munic. Vara      Bairro          Endere็o Vara                             U.F  Ass.Processo          Data Aud     Hora Aud   St Audiencia     Realizada"
//                       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       0        1         2         3         4         5         6         7         8         9         10        1         2         3         4         5         6          7        8         9         10        1         2         3         4         5         6          7         8         9         10
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 

	Local Cabec2         := " "
	Local aOrd           := {}

	Private lDebug := .F.

	Private nLin         := 220
	Private lEnd         := .F.
	Private lAbortPrint  := .F.
	Private limite       := 100
	Private tamanho      := "G"
	Private nomeprog     := "CABR277"
	Private nTipo        := 15
	Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey     := 0
	Private cbtxt        := Space(10)
	Private cbcont       := 00
	Private CONTFL       := 01
	Private m_pag        := 01
	Private wnrel        := "CABR277"
	Private cString      := "SE2"
	Private cPerg        := "CABR277   "
	private ctraco222     := replicate("_",220)
	Private cAliastmp    := GetNextAlias()
	private cRealiz      := ' '
	Private cQuery       := " "
	private ncont        := 0
	private nContt       := 0
	Private cEscadv      := ' '

	Private  acabec1:={ "Reu "          ,;
		"Num. Processo" ,;
		"Tp Vara"       ,;
		"Municipio Vara",;
		"Bairro"        ,;
		"Endere็o Vara" ,;
		"U.F "          ,;
		"Cep "          ,;
		"Assunto Processo" ,;
		"Dt. Audiencia" ,;
		"Hora Audiencia",;
		"Real./AReal."  ,;
		"St. Audiencia."}        // Alterar aqui 1

	ValidPerg()

	If Pergunte(cPerg,.T.) = .F.
		Return
	Endif


//Pergunte(cPerg,.T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
	ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  31/08/07   บฑฑ
	ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
	ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
	ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
	ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
	ฑฑบUso       ณ Programa principal                                         บฑฑ
	ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

	Local cQuery := ' '

	dbSelectArea(cString)
	dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	SetRegua(RecCount())
/****************************************************/
/* CQUERY  - QUERY DE CARGA DE CALCULO DA COMISSAO  */
/* CQYERY1 - Dados do(s) Titulo(S) a receber        */
/* CQYERY2 - compossi็ใo da cobran็a                */
/****************************************************/   
///--- rela็ใo de audiencias  ---    

	cQuery := " select substr(Pbw.Pbw_Nomau1,1,30) Autor , "
	cQuery += CRLF + " Pbx.Pbx_Proces Num_proc , "
	cQuery += CRLF + " Pbw.Pbw_Tipvar Tp_Vara  , "
	cQuery += CRLF + " Pbw.Pbw_Munvar MunVar   , "
	cQuery += CRLF + " Pbw.Pbw_Brovar Bairro , "
	cQuery += CRLF + " Pbw.Pbw_Endvar Endereco , "
	cQuery += CRLF + " Pbw.Pbw_Numvar Numero , "
	cQuery += CRLF + " Pbw.Pbw_Ufvara UF , "
	cQuery += CRLF + " Pbw.Pbw_Cepvar Cep , "
	cQuery += CRLF + " substr(Pbw.Pbw_Asspro,1,30) Ass_Proc , "
	cQuery += CRLF + " substr(Pbx.Pbx_Dtincp,7,2)||'/'||substr(Pbx.Pbx_Dtincp,5,2)||'/'||substr(Pbx.Pbx_Dtincp,1,4) datinc ,"
	cQuery += CRLF + " substr(Pbx.Pbx_hrincp,1,2)||':'||substr(Pbx.Pbx_hrincp,3,2) HORAINC , "
	cQuery += CRLF + " substr(Pbx.Pbx_DtFIMP,7,2)||'/'||substr(Pbx.Pbx_DtFIMP,5,2)||'/'||substr(Pbx.Pbx_DtFIMP,1,4) datfim ,"
	cQuery += CRLF + " substr(Pbx.Pbx_hrFIMP,1,2)||':'||substr(Pbx.Pbx_hrFIMP,3,2) HORAfim , PBX.PBX_TPSMT1 TPSOLC , PBX.PBX_STAUD STAUD, Pbx.Pbx_Dtincp dtinc1, pbw.pbw_escadv escadv"
	cQuery += CRLF + "   from " + RetSqlName("PBW") +" PBW ,  " + RetSqlName("PBX") +" PBX  "
	cQuery += CRLF+  "  where PBX_filial    = '"+xFilial('PBX')+ "'  and PBX.d_E_L_E_T_     = ' ' "
	cQuery += CRLF+  "    AND PBW_filial    = '"+xFilial('PBW')+ "'  and PBW.d_E_L_E_T_     = ' ' "

	cQuery += CRLF+  "   and pbx.pbx_numpro = Pbw.Pbw_Numpro AND TRIM(Pbx.Pbx_Asspro) = 'Audiencia' "

	cQuery += CRLF+  "   and substr(pbw_tpacao,1,4) In ('ALER','DECO','MINI','PROC','RECE','ACAO','EXEC')"

	cQuery += CRLF+  "   and Pbx.Pbx_Dtincp >= '"+DTOS(MV_PAR01)+"'"
	cQuery += CRLF+  "   and Pbx.Pbx_Dtincp <= '"+DTOS(MV_PAR02)+"'"

	If MV_PAR03 == 1
		cQuery += CRLF+  "   Order by  pbw.pbw_escadv , Pbx.Pbx_Dtincp "
	Else
		cQuery += CRLF+  "   Order by  Pbx.Pbx_Dtincp "
	EndIf

	If Select((cAliastmp)) <> 0
		(cAliastmp)->(DbCloseArea())
	Endif

	TCQuery cQuery  New Alias (cAliastmp)

	If mv_par03 == 1
		titulo := "Relatorio de audiencia de processos  Analitico - Escritorio : " + (cAliastmp)->escadv
		cescadv:= (cAliastmp)->escadv
	EndIf
	(cAliastmp)->(dbGoTop())
//While (cAliastmp)->(!EOF()) .and. (cAliastmp1)->(!EOF()) .and. (cAliastmp2)->(!EOF()) .and. (cAliastmp3)->(!EOF()) .and. (cAliastmp4)->(!EOF())
	If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
		nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin ++
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica o cancelamento pelo usuario...                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		//	Exit
	Endif

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do cabecalho do relatorio. . .                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//identificacao da empresa (contratante)

	While (cAliastmp)->(!EOF())

		If mv_par03 == 1  .and. cescadv != (cAliastmp)->escadv

			titulo  := "Relatorio de audiencia de processos  Analitico - Escritorio : "+(cAliastmp)->escadv
			cescadv := (cAliastmp)->escadv

			@ nLin,000 PSAY ctraco222
			nLin ++
			@ nLin,170 PSAY 'Total Parcial (Qtda)------> '
			@ nLin,200 PSAY ncont  Picture "@E 99,999"

			nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin ++
		EndIf

		If DtoS(date()) > (cAliastmp)->dtinc1
			cRealiz := 'Sim'
		else
			cRealiz := 'Nใo'
		EndIf

		@ nLin,001 PSAY substr((cAliastmp)->Autor,1,30)
		@ nLin,033 PSAY (cAliastmp)->num_proc
		@ nLin,060 PSAY substr((cAliastmp)->Tp_Vara,1,8)
		@ nLin,070 PSAY substr((cAliastmp)->MunVar,1,15)
		@ nLin,087 PSAY substr((cAliastmp)->Bairro,1,15)
		@ nLin,103 PSAY substr((cAliastmp)->Endereco,1,40)
		@ nLin,145 PSAY substr((cAliastmp)->UF,1,3)
		@ nLin,150 PSAY substr((cAliastmp)->Ass_Proc,1,20)
		@ nLin,172 PSAY (cAliastmp)->datinc
		@ nLin,186 PSAY (cAliastmp)->HORAINC
//           @ nLin,196 PSAY (cAliastmp)->TPSOLC     // Alterar aqui 2
		@ nLin,196 PSAY (cAliastmp)->STAUD    // Alterar aqui 2

		@ nLin,215 PSAY cRealiz
		ncont++
		nContt++
		nlin++

		If nLin > 65 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...

			@ nLin,000 PSAY ctraco222
			nLin ++
			@ nLin,170 PSAY 'Total Parcial (Qtda)------> '
			@ nLin,200 PSAY ncont  Picture "@E 99,999"

			nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin ++
		Endif

		(cAliastmp)->(dbSkip())

	EndDo

	@ nLin,000 PSAY ctraco222
	nLin ++
	@ nLin,170 PSAY 'Total Geral  (Qtda)------> '
	@ nLin,200 PSAY ncontt  Picture "@E 999,999"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()



Return



/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
	ฑฑบPrograma  ณValidPerg บ Autor ณ Jose Carlos Noronhaบ Data ณ 01/08/07    บฑฑ
	ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
	ฑฑบDescricao ณ Parametros para selecao dos titulos do PLS                 บฑฑ
	ฑฑบ          ณ                                                            บฑฑ
	ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
	ฑฑบUso       ณ                                                            บฑฑ
	ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ValidPerg()

	Local aAreaAtu := GetArea()
	Local aRegs    := {}
	Local i,j

	DbSelectArea("SX1")
	dbSetOrder(1)
	cPerg := PADR(cPerg,10)

	aAdd(aRegs,{cPerg,"01","Data De  : ","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" })
	aAdd(aRegs,{cPerg,"02","Data Ate : ","","","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" })
	aadd(aRegs,{cPerg,"03","Quebra Por escritorio ?","","","mv_ch3","N", 1,0,0,"C","","mv_par03","Sim","","","","","Nao","","","","","","","","","","","","","","","","","" , "" ,""  , "", "", "" })

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
	Next

	RestArea( aAreaAtu )

Return(.T.)
