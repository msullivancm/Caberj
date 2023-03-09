#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.CH "
#Define cCodigosPF "104,116,117,123,124,125,127,134,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177"
Static cCodDB     := PLSRETLADC()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFQMR038   บ Autor ณ Wellington Tonieto บ Data ณ  07/08/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao de faturas c/desmembramento                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABR038()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local aCampoTRB := {}
Private cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Private cDesc2         := "de acordo com os parametros informados pelo usuario."
Private cDesc3         := " "
Private cPict          := " "
Private ctitulo        := "R E L A T O R I O   D E   C O M P O S I C A O   D E   F A T U R A S "
Private nLi            := 80

Private cCabec1      := "Plano                                                                                                                                                                                                               "
Private cCabec2      := "Referencia              Contr.    Opcionais    Tx Adesao      Debitos     Creditos     Participacao       Tarifa     Farmacia        Juros   Guia Medico       Cartใo       Outros          Total                   "
//Private cCabec2      := "Referencia              Contr.    Opcionais    Tx Adesao      Debitos     Creditos     Participacao       Tarifa     Farmacia        Juros   Guia Medico       Cartใo       Outros          Liquido          Baixado"
Private imprime      := .T.
Private aOrd         := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := " "
Private nlimite      := 220
Private ctamanho     := "G"
Private cnomeprog    := "Cabr038" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CabR038" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cPerg        := "Cabr38"
Private cString      := "SE1"
Private cTexto       := " "
Private nTamCol      := 59
Private nCaracter    := 15
Private nVlrEst      := 0
//Crio arquivo de perguntas
aSx1  := {}
Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3","DEF01","DEF02"     ,"DEF03" ,"DEF04"  ,"DEF05"})
Aadd(aSx1,{cPerg  ,"01"   ,"Pagamento De.......?","mv_ch1" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par01",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"02"   ,"Pagamento Ate......?","mv_ch2" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par02",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"03"   ,"Fatura De..........?","mv_ch3" ,"C"   ,06       ,0        ,"G"  ,""     ,"mv_par03",""  ,""  ,"","" ,""       ,""     })
Aadd(aSx1,{cPerg  ,"04"   ,"Fatura Ate.........?","mv_ch4" ,"C"   ,06       ,0        ,"G"  ,""     ,"mv_par04",""  ,""  ,"","" ,""       ,""     })
Aadd(aSx1,{cPerg  ,"05"   ,"Prefixo De.........?","mv_ch5" ,"C"   ,03       ,0        ,"G"  ,""     ,"mv_par05",""  ,""  ,"","" ,""       ,""     })
Aadd(aSx1,{cPerg  ,"06"   ,"Prefixo Ate........?","mv_ch6" ,"C"   ,03       ,0        ,"G"  ,""     ,"mv_par06",""  ,""  ,"","" ,""       ,""     })

fCriaSX1(cPerg,aSX1)

If !Pergunte(cPerg,.T.)
	Return
Endif

cPagIni  := MV_PAR01
cPagFim  := MV_PAR02
cfatIni  := MV_PAR03
cfatFim  := MV_PAR04
cPrefIni := MV_PAR05
cPrefFim := MV_PAR06

aCampoTRB := {	{ "TR1_CODIGO"  , "C", TamSX3("BM1_CODPLA")[1]	, 0 },;
                { "TR1_DESCRI" 	, "C", TamSX3("BM1_DESPLA")[1]	, 0 },;
                { "TR1_ANO" 	, "C", TamSX3("BM1_ANO")[1]		, 0 },;
                { "TR1_MES"		, "C", TamSX3("BM1_MES")[1]		, 0 },;
                { "TR1_TIPCOB"	, "C", TamSX3("E1_FORMREC")[1]	, 0 },;
                { "TR1_BAIXA"	, "D", 8						, 0 },;
                { "TR1_VENCTO"	, "D", 8						, 0 },;
                { "TR1_PREFIX"	, "C", TamSX3("E1_PREFIXO")[1]  , 0 },;
                { "TR1_NUM"		, "C", TamSX3("E1_NUM")[1]		, 0 },;
                { "TR1_PARCEL"	, "C", TamSX3("E1_PARCELA")[1]  , 0 },;
                { "TR1_TIPO"	, "C", TamSX3("E1_TIPO")[1]     , 0 },;
                { "TR1_VALTIT"	, "N", TamSX3("E1_VALOR")[1]	, 2 },;
                { "TR1_DACAO"	, "C", 1						, 0 },;
                { "TR1_VLRBAI"	, "N", TamSX3("E1_VALOR")[1]	, 2 },;
                { "TR1_TOTBAI"	, "N", TamSX3("E1_VALOR")[1]    , 2 },;
                { "TR1_NUMBCO"	, "C", TamSX3("E1_NUMBCO")[1]	, 0 },;
                { "TR1_VLRMEN"	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_VLRDEB"	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_VLRCRE"	, "N", TamSX3("BM1_VALOR")[1]   , 2 },;
                { "TR1_VLROPC"	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_VLRTAX"	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_VLRPF"	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_VLRTAR"	, "N", TamSX3("BM1_VALOR")[1]   , 2 },;
                { "TR1_VLRFAR" 	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_VLRGUI" 	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_VLRCAR" 	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_VLRJUR" 	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_VLROUT" 	, "N", TamSX3("BM1_VALOR")[1]	, 2 },;
                { "TR1_CLIFAT"  , "C", TamSX3("E1_CLIENTE")[1]	, 0 },; 
                { "TR1_NOMCLI"  , "C", TamSX3("E1_NOMCLI")[1]	, 0 },;
                { "TR1_FATURA"  , "C", TamSX3("E1_NUM")   [1]	, 0 },;
                { "TR1_FATPRE"  , "C", TamSX3("E1_PREFIXO")[1]  , 0 },; 
                { "TR1_VALFAT"  , "N", TamSX3("E1_VALOR") [1]   , 2 }}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria o Arquivo de Trabalho que armazenara os valores por produto...      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If Select("TRB1") <> 0 ; TRB1->(DbCloseArea()) ; Endif
cArqTRB   := CriaTrab(aCampoTRB, .T.)
dbUseArea(.T.,,cArqTRB,"TRB1",.F.)
IndRegua("TRB1",cArqTRB,"TR1_DACAO + TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPCOB + dTos(TR1_VENCTO) + TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO",,,"Indexando Arquivo de Trabalho")


dbSelectArea(cString)
dbSetOrder(1)


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,cTamanho,,.T.)

wnrel := SetPrint(cString,wnrel,cPerg,@ctitulo,cDesc1,cDesc2,cDesc3,.F.,"",,cTamanho)

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

RptStatus({|| RunReport(cCabec1,cCabec2,cTitulo,nLi) },cTitulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  07/08/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(cCabec1,cCabec2,cTitulo,nLi)

Local nOrdem
Local cQuery := " "
Local I := 1

cQuery := " SELECT E1_FILIAL,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_NOMCLI,E1_LOJA,"
cQuery += " E1_VALOR,E1_MESBASE,E1_ANOBASE,E5_MOTBX,E5_DTDISPO,E5_VALOR , E5_SEQ"
cQuery += " FROM " + RetSqlName("SE1") + " SE1 ," + RetSqlName("SE5") + " SE5  "
cQuery += " WHERE SE1.D_E_L_E_T_   <> '*'    AND  SE5.D_E_L_E_T_   <> '*'  AND"
cQuery += " SE1.E1_ORIGEM = 'FINA280'        AND "
cQuery += " SE1.E1_PREFIXO BETWEEN '" + cPrefIni       + "' And '" + cPrefFim      +  "' AND "
cQuery += " SE5.E5_NUMERO  BETWEEN '" + cFatIni        + "' And '" + cFatFim       +  "' AND"
cQuery += " SE5.E5_DTDISPO BETWEEN '" + dTos(cPagIni)  + "' And '" + dTos(cPagFim) +  "' AND "
cQuery += " SE5.E5_TIPODOC NOT IN ('DC','D2','JR','J2','TL','MT','M2','CM','C2','TR','TE','ES') AND  "
cQuery += " SE5.E5_FILIAL  = SE1.E1_FILIAL   AND "
cQuery += " SE5.E5_PREFIXO = SE1.E1_PREFIXO  AND "
cQuery += " SE5.E5_NUMERO  = SE1.E1_NUM      AND "
cQuery += " SE5.E5_PARCELA = SE1.E1_PARCELA  AND "
cQuery += " SE5.E5_TIPO    = SE1.E1_TIPO "
	
TcSqlExec(cQuery)
If Select("QRY") <> 0 
   QRY->(DbCloseArea()) 
Endif
DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),"QRY",.T.,.T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())

dbSelectArea("QRY")
QRY->(DbGotop())

nConta := 0

While !eof()
	
	//DbSelectArea("SE1")
	//DbSetOrder(10)
    nVlrEst:=0
  	cQuer:= "SELECT Sum(E5_VALOR) ESTORNO FROM "+RetSqlName("SE5")+" WHERE "
	cQuer += "E5_FILIAL='"+xFilial("SE5")+"' AND "
	cQuer += "E5_PREFIXO='"+QRY->E1_PREFIXO+"' AND "
	cQuer += "E5_NUMERO='"+QRY->E1_NUM+"' AND "
	cQuer += "E5_PARCELA='"+QRY->E1_PARCELA+"' AND "
	cQuer += "E5_TIPO='"+QRY->E1_TIPO+"' AND "
	cQuer += "E5_CLIFOR='"+QRY->E1_CLIENTE+"' AND "
	cQuer += "E5_LOJA='"+QRY->E1_LOJA+"' AND "
	cQuer += "E5_SEQ='"+QRY->E5_SEQ+"' AND "
	cQuer += "E5_TIPODOC='ES' AND "   
	cQuer += "E5_DATA <= '"+dTos(cPagFim) +"' AND "
	cQuer += "D_E_L_E_T_<>'*'"      
				
	TCQuery cQuer Alias "EST" New
								                                                            
    nVlrEst := EST->ESTORNO 
    EST->( dbCloseArea() )
    DbSelectArea("SE1")
	DbSetOrder(10)
    If nVlrEst = 0                       
       If SE1->(DbSeek(xFilial("SE1")+QRY->E1_CLIENTE+QRY->E1_LOJA+QRY->E1_PREFIXO+QRY->E1_NUM))
	     While !EOF() .And. ( QRY->(E1_FILIAL+E1_PREFIXO+E1_NUM)== SE1->(E1_FILIAL+E1_FATPREF+E1_FATURA))
			lDac	:= !(MovBcoBx( QRY->E5_MOTBX, .F. ))
			fComposicao(E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_MESBASE,E1_ANOBASE)
			DbSelectArea("SE1")
			DbSkip()
		 Enddo
	  Endif 
    Endif	  
	
	DbSelectArea("QRY")
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo

fImprime()

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

**************************
Static Function fCriaSx1()
**************************

Local Z  := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local X1 := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

SX1->(DbSetOrder(1))

If !SX1->(DbSeek(cPerg+aSx1[Len(aSx1),2]))
	SX1->(DbSeek(cPerg))
	While SX1->(!Eof()) .And. Alltrim(SX1->X1_GRUPO) == cPerg
		SX1->(Reclock("SX1",.F.,.F.))
		SX1->(DbDelete())
		SX1->(MsunLock())
		SX1->(DbSkip())
	End
	For X1:=2 To Len(aSX1)
		SX1->(RecLock("SX1",.T.))
		For Z:=1 To Len(aSX1[1])
			cCampo := "X1_"+aSX1[1,Z]
			SX1->(FieldPut(FieldPos(cCampo),aSx1[X1,Z] ))
		Next
		SX1->(MsunLock())
	Next
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO4     บAutor  ณMicrosiga           บ Data ณ  08/26/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

********************************************************
Static Function fComposicao(cPrefix,cNum,cParcel,cTipo,_cMes,_cAno)
********************************************************
Local cSql     := " "
Local aArea    := GetArea()
Local nBaixa   := 1
Local nIdent   := 1
Local lListTit := .T.
LocaL nQtd 	   := 0
Local aRateio  := {}
Local lRateio  := .F.
Local lFracao  := .F.
Local cChvTit  := ''

cSql := "SELECT BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_DESTIP    , "
cSql += "BM1_CODEVE, BM1_DESEVE, BM1_VALOR, BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, "
cSql += "BM1_CODPLA, BM1_DESPLA, BM1_VERPLA, BM1_ANO, BM1_MES, BM1_TIPO  "
cSql += "FROM "+RetSqlName("BM1")+" BM1 "
cSql += "WHERE BM1_FILIAL   = '"+xFilial("BM1")+"' "
cSql += "AND BM1_PREFIX     = '"+cPrefix+"' "
cSql += "AND BM1_NUMTIT     = '"+cNum+"' "
cSql += "AND BM1_PARCEL     = '"+cParcel+"' "
cSql += "AND BM1_TIPTIT     = '"+cTipo+"' "
cSql += "AND BM1.D_E_L_E_T_ = ' ' "
cSql += "ORDER BY BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_CODTIP, BM1_CODEVE "

TcSqlExec(cSQL)
If Select("TRB") <> 0 ; TRB->(DbCloseArea()) ; Endif
DbUseArea(.T.,"TopConn",TcGenQry(,,cSQL),"TRB",.T.,.T.)


While !TRB->( Eof() )
	
	nQtd ++
	
	//Posiciona Familiar
	BA3->( MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)) )
	
	//ณ Posiciona o usuario                                           			 ณ
	BA1->( MsSeek(xFilial("BA1")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG)) )
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Defini qual o plano do usuario...                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	_cCodPla := ''
	_cVerPla := ''
	
	// Regra numero um: Utiliza o plano do BM1.
	If !Empty(TRB->BM1_CODPLA) .and. !Empty(TRB->BM1_VERPLA)
		_cCodPla := TRB->BM1_CODPLA
		_cVerPla := TRB->BM1_VERPLA
	Endif
	
	// Regra numero tres: Utiliza o plano do usuario ou da familia.
	If Empty(_cCodPla)
		If !Empty(BA1->BA1_CODPLA)
			_cCodPla := BA1->BA1_CODPLA
			_cVerPla := BA1->BA1_VERSAO
		Else
			_cCodPla := BA3->BA3_CODPLA
			_cVerPla := BA3->BA3_VERSAO
		Endif
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica se foi abortada a impressao...                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If  Interrupcao(lAbortPrint)
		Exit
	Endif
	
	// Posiciona o produto
	BI3->( MsSeek(xFilial("BA3")+ BA3->BA3_CODINT + _cCodPla) )
	
	IIF( lDac,cDacao	:= 'B', cDacao	:= 'A')
	
	If nQtd > 1
		lRateio := .T.
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Alimenta o arquivo temporario...                                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cChave := cDacao + _cCodPla + _cAno + _cMes + SE1->E1_FORMREC + dTos(SE1->E1_VENCTO) +;
	SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO
		
	DbSelectArea("TRB1")
	lFound := MsSeek( cChave ) // Procura registro no arquivo temporario...
	RecLock("TRB1", !lFound)
	
	If !lFound
		
		DbSelectArea("SE5")
		DbSetOrder(7)
		If  DbSeek(SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)
			lDac	:= !(MovBcoBx( QRY->E5_MOTBX, .F. ))
			iF !lDac
				If SE5->E5_RECPAG == 'R'
					nBaixa	:= SE5->E5_VALOR
				Else
					nBaixa	-= SE5->E5_VALOR
				Endif
			Endif
		Endif
		
		TRB1->TR1_CLIFAT    := QRY->E1_CLIENTE  
		TRB1->TR1_NOMCLI    := QRY->E1_NOMCLI
		TRB1->TR1_FATURA    := QRY->E1_NUM
		TRB1->TR1_FATPRE    := QRY->E1_PREFIXO
		TRB1->TR1_VALFAT    := QRY->E1_VALOR
		TRB1->TR1_CODIGO    := _cCodPla
		TRB1->TR1_DESCRI 	:= BI3->BI3_DESCRI
		TRB1->TR1_ANO		:= _cAno
		TRB1->TR1_MES		:= _cMes
		TRB1->TR1_VLRTAR	:= SE1->E1_DECRESC
		TRB1->TR1_BAIXA	    := stod(QRY->E5_DTDISPO)
		TRB1->TR1_VENCTO	:= SE1->E1_VENCTO
		TRB1->TR1_TIPCOB	:= SE1->E1_FORMREC
		TRB1->TR1_PREFIX	:= SE1->E1_PREFIXO
		TRB1->TR1_NUM		:= SE1->E1_NUM
		TRB1->TR1_PARCEL	:= SE1->E1_PARCELA
		TRB1->TR1_TIPO		:= SE1->E1_TIPO
		TRB1->TR1_VALTIT	:= SE1->E1_VALOR
		TRB1->TR1_TOTBAI	:= nBaixa // Valor da baixa real
		TRB1->TR1_DACAO     := cDacao
		
		If !lRateio
			TRB1->TR1_VLRBAI	:= nBaixa		// O vlrbai serแ o valor da baixa rateada...
		Endif
		
		If !Empty(SE1->E1_NUMBCO)
			TRB1->TR1_NUMBCO	:= SE1->E1_NUMBCO
		Else
			TRB1->TR1_NUMBCO	:= SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)
		Endif
		
	Endif
	
	If TRB->BM1_CODTIP $ '101, 118'		// Mensalidade
		TRB1->TR1_VLRMEN += TRB->BM1_VALOR
	Elseif TRB->BM1_CODTIP $ '102,133'	// Opcionais
		TRB1->TR1_VLROPC += TRB->BM1_VALOR
	Elseif TRB->BM1_CODTIP == '103'		// Taxa de adesao
		TRB1->TR1_VLRTAX += TRB->BM1_VALOR
	Elseif TRB->BM1_CODTIP == '909'		// Guia medico
		TRB1->TR1_VLRGUI += TRB->BM1_VALOR
	Elseif TRB->BM1_CODTIP $ '107, 908'	// Cartao de identifica็ao
		TRB1->TR1_VLRCAR += TRB->BM1_VALOR
	Elseif TRB->BM1_CODTIP $ cCodigosPF	// Co-participacoes...
		TRB1->TR1_VLRPF  += TRB->BM1_VALOR
	Elseif Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YLANFAR","998")	// Farmacia
		TRB1->TR1_VLRFAR += TRB->BM1_VALOR
	Elseif Alltrim(TRB->BM1_CODEVE) $ GetNewPar("MV_YCDLJ3","993")	// Juros...
		TRB1->TR1_VLRJUR += TRB->BM1_VALOR
	Elseif TRB->BM1_CODTIP $ cCodDB		// Debitos / creditos...
		If BFQ->( MsSeek(xFilial("BFQ")+TRB->BM1_CODINT + TRB->BM1_CODTIP) )
			If BFQ->BFQ_DEBCRE == '2' 	// Credito.
				TRB1->TR1_VLRCRE += TRB->BM1_VALOR
			Elseif BFQ->BFQ_DEBCRE == '1' // Debitos.
				TRB1->TR1_VLRDEB += TRB->BM1_VALOR
			Endif
		Endif
	Else
		TRB1->TR1_VLROUT += TRB->BM1_VALOR
	Endif
	
	TRB1->( MsUnlock() )
	
	DbSelectArea("TRB")
	DbSkip()
	
Enddo
TRB->( dbCloseArea() )

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR038   บAutor  ณMicrosiga           บ Data ณ  08/28/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
**************************
Static Function fImprime()
**************************

Local nQtdLin     := 58
LOCAL nTotGMen 	:= 0
LOCAL nTotGOpc 	:= 0
LOCAL nTotGAde 	:= 0
LOCAL nTotGDeb 	:= 0
LOCAL nTotGCre 	:= 0
LOCAL nTotGPF  	:= 0
LOCAL nTotGTar 	:= 0
LOCAL nTotGFar 	:= 0
LOCAL nTotGOut 	:= 0
LOCAL nTotGBai		:= 0
LOCAL nTotGJur 	:= 0
LOCAL nTotGGui	   := 0
LOCAL nTotGui	   := 0
LOCAL nTotCar	   := 0
LOCAL nTotGCar	   := 0
LOCAL nTotGeral	:= 0
LOCAL nTotLinha  := 0
LOCAL nTotGrupo  := 0
LOCAL nTotBaixa  := 0
LOCAL nTotPMen   := 0
LOCAL nTotPOpc   := 0
LOCAL nTotPAde   := 0
LOCAL nTotPDeb   := 0
LOCAL nTotPCre   := 0
LOCAL nTotPPf    := 0
LOCAL nTotPTar   := 0
LOCAL nTotPFar   := 0
LOCAL nTotPJur   := 0
LOCAL nTotPOut   := 0
LOCAL nTotPGui   := 0
LOCAL nTotPCar   := 0
LOCAL nTotPGrp   := 0
LOCAL nTotPBai   := 0
LOCAL nVenMen    := 0
LOCAL nVenOpc    := 0
LOCAL nVenAde    := 0
LOCAL nVenDeb    := 0
LOCAL nVenCre    := 0
LOCAL nVenPF     := 0
LOCAL nVenTar    := 0
LOCAL nVenFar    := 0
LOCAL nVenJur    := 0
LOCAL nVenGui    := 0
LOCAL nVenCar    := 0
LOCAL nVenOut    := 0
LOCAL nVenGrupo  := 0
LOCAL nVenBaixa  := 0
LOCAL nRat	     := 0
LOCAL nH	     := 0
LOCAL lLog	     := .F.
LOCAL nTotMen  	 := 0
LOCAL nTotOpc 	 := 0
LOCAL nTotAde 	 := 0
LOCAL nTotDeb 	 := 0
LOCAL nTotCre 	 := 0
LOCAL nTotPar 	 := 0
LOCAL nTotTax 	 := 0
LOCAL nTotTar	 := 0
LOCAL nTotPla	 := 0
LOCAL nTotFar	 := 0
LOCAL nTotPF	 := 0
LOCAL nTotOut 	 := 0
LOCAL nTotJur	 := 0
LOCAL nTotTit	 := 0
LOCAL nTotal	 := 0
LOCAL nBaixaDac	 := 0
LOCAL pMoeda1	 := "@E 999,999.99"
LOCAL pMoeda2	 := "@E 9,999,999.99"
LOCAL pMoeda3	 := "@E 99,999,999.99"
nLi := 1000

DbSelectArea("TRB1")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria Indice 1 do Arquivo de Trabalho com a Grade Curricular do aluno.    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cInd2TRB := CriaTrab(Nil, .F.)
IndRegua("TRB1",cInd2TRB,"+ TR1_FATPREF + TR1_FATURA + TR1_DACAO + TR1_CODIGO + TR1_ANO + TR1_MES + TR1_TIPCOB + dTos(TR1_VENCTO)",,,"Indexando Arquivo de Trabalho")
TRB1->( dbGotop() )

BQL->( dbSetorder(01) )
While !TRB1->( Eof() )
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica o cancelamento pelo usuario...                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If lAbortPrint
		@nLi,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	If Alltrim(TRB1->TR1_DACAO) <> 'A'
		TRB1->( dbSkip() )
		Loop
	Endif
	
	// Controle de saldo de pagina...
	If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
	Endif
	
	// Controle de quebra...
	cQuebra    := TRB1->(TR1_FATPREF+TR1_FATURA)
	cDesQuebr  := " F A T U R A ..: " + TRB1->TR1_FATPREF + " - " + TRB1->TR1_FATURA
	cDesQuebr2 := " V A L O R.....: " + Alltrim(Str(TRB1->TR1_VALFAT,15,2))
	cDesQuebr3 := " P L A N O ....: Nใo a Plano Associado ao titulo"  //+ TRB1->TR1_CODIGO + ' - ' + TRB1->TR1_DESCRI
	cDesQuebr4 := " L I Q U I D A D A  E M ..:  " + DTOC(TRB1->TR1_BAIXA)
	
	@ nLi, 000 Psay cDesQuebr
	nLi++
	@ nLi, 000 Psay cDesQuebr2
	nLi++
	@ nLi, 000 Psay cDesQuebr3
	nLi++
	@ nLi, 000 Psay cDesQuebr4
	nLi++
	@ nLi, 000 Psay Replicate('_', nLimite)
	nLi+= 2
	
	While !TRB1->( Eof() ) .and. TRB1->(TR1_FATPREF+TR1_FATURA) == cQuebra
		
		// Controle de saldo de pagina...
		If  nli > nQtdLin
			nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
			nli++
		Endif
		
		nTotLinha := 0
		@ nLi, 000 Psay '==> '+ Alltrim(TRB1->TR1_ANO) + '/' + Alltrim(TRB1->TR1_MES)
		If nTipo == 1
			nLi++
		Endif
		
		// Inicia a segunda quebra, por data de baixa... a partir deste ponto a quebra fica assim: Preduto + Referencia + Data Baixa.
		_cMes := Alltrim(TRB1->TR1_MES)
		_cAno := Alltrim(TRB1->TR1_ANO)
		
		cDataBaixa := ''
		cTipoCob	  := ''
		cTit		  := TRB1->(TR1_PREFIX+TR1_NUM+TR1_PARCEL+TR1_TIPO)
		lFirst	  := .T.
		
		While !TRB1->( Eof() ) .and. TRB1->(TR1_FATPREF+TR1_FATURA) == cQuebra .And. Alltrim(TRB1->TR1_ANO+TRB1->TR1_MES) == Alltrim( _cAno + _cMes)
			
			If Alltrim(TRB1->TR1_DACAO) <> 'A'
				TRB1->( dbSkip() )
				Loop
			Endif
			
			IF TRB1->TR1_TOTBAI < TRB1->TR1_VALTIT // Se o valor da baixa for menor que o valor do titulo, ativa rateio por coluna...
				// Calcula o fator...
				nFator := (TRB1->TR1_VLRBAI / TRB1->TR1_VALTIT)
				
				// Altera os aplicando o fator sobre os valores ja apurados...
				TRB1->( RecLock("TRB1", .F.) )
				TRB1->TR1_VLRMEN := Round((TRB1->TR1_VLRMEN * nFator),2)
				TRB1->TR1_VLROPC := Round((TRB1->TR1_VLROPC * nFator),2)
				TRB1->TR1_VLRTAX := Round((TRB1->TR1_VLRTAX * nFator),2)
				TRB1->TR1_VLRDEB := Round((TRB1->TR1_VLRDEB * nFator),2)
				TRB1->TR1_VLRCRE := Round((TRB1->TR1_VLRCRE * nFator),2)
				TRB1->TR1_VLRPF  := Round((TRB1->TR1_VLRPF  * nFator),2)
				TRB1->TR1_VLRTAR := Round((TRB1->TR1_VLRTAR * nFator),2)
				TRB1->TR1_VLRFAR := Round((TRB1->TR1_VLRFAR * nFator),2)
				TRB1->TR1_VLRJUR := Round((TRB1->TR1_VLRJUR * nFator),2)
				TRB1->TR1_VLRGUI := Round((TRB1->TR1_VLRGUI * nFator),2)
				TRB1->TR1_VLRCAR := Round((TRB1->TR1_VLRCAR * nFator),2)
				
				// Recalcula valores
				nTotal := TRB1->(TR1_VLRMEN + TR1_VLROPC + TR1_VLRTAX + TR1_VLRDEB + TR1_VLRCRE +;
				TR1_VLRPF + TR1_VLRTAR + TR1_VLRFAR + TR1_VLRJUR + TR1_VLRGUI + TR1_VLRCAR)
				
				// Eh possivel existir diferenca de centavos em funcao do fator...
				nDif := TRB1->TR1_VLRBAI - nTotal
				
				// Se existir diferenca, adicina na coluna de contra prestacao...
				If nDif > 0
					TRB1->TR1_VLRMEN += nDif
				Endif
				
				
				TRB1->( MsUnlock() )
			Endif
			
			// Imprime o tipo de cobranca quando for analitico...
			If BQL->( dbSeek(xFilial("BQL")+TRB1->TR1_TIPCOB) )
				cDesTipCb := BQL->BQL_DESCRI
			Else
				cDesTipCb := "Tipo de cobran็a nao encontrado."
			Endif
			
			nTotLinha := 0
			
			If  nli > nQtdLin
				nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
				nli++
				
				// Imprime o codigo do produto e a descricao quando mudar de pagina...
				@ nLi, 000 Psay '==> ' + cDesQuebr
				nLi+= 2
				
				// Imprime o mes e o ano do movimento quando trocar de pagina...
				@ nLi, 000 Psay '** '+Alltrim(_cAno) + '/' + Alltrim(_cMes)
				
				// Imprime o tipo de cobranca quando for analitico...
				If nTipo == 1
					nLi += 2
					@ nLi, 003 Psay '**** '+cDesTipCb
					cTipoCob := TRB1->TR1_TIPCOB
					
					// Imprime o vencimento quando for analitico...
					nLi += 2
					@ nLi, 006 Psay "Vencimento: " + dToc(TRB1->TR1_VENCTO)
					nLi++
					cDataBaixa := dToc(TRB1->TR1_VENCTO)
				Endif
			Endif
			
			// Imprime o tipo de cobranca quando for analitico...
			If cTipoCob <> TRB1->TR1_TIPCOB
				// Quando imprime os titulo, deve haver uma soma do total do vencimento...
				If (!Empty(cDataBaixa) .and. cDataBaixa <> dToc(TRB1->TR1_VENCTO))
					nLi++
					@ nLi, 000 Psay "Total:"+cDataBaixa
					@ nLi, 016 Psay Transform(nVenMen, pMoeda2)
					@ nLi, 033 Psay Transform(nVenOpc, pMoeda1)
					@ nLi, 046 Psay Transform(nVenAde, pMoeda1)
					@ nLi, 059 Psay Transform(nVenDeb, pMoeda1)
					@ nLi, 072 Psay Transform(nVenCre, pMoeda1)
					@ nLi, 085 Psay Transform(nVenPF , pMoeda2)
					@ nLi, 102 Psay Transform(nVenTar, pMoeda1)
					@ nLi, 115 Psay Transform(nVenFar, pMoeda1)
					@ nLi, 128 Psay Transform(nVenJur, pMoeda1)
					@ nLi, 142 Psay Transform(nVenGui, pMoeda1)
					@ nLi, 155 Psay Transform(nVenCar, pMoeda1)
					@ nLi, 168 Psay Transform(nVenOut, pMoeda1)
					@ nLi, 181 Psay Transform(nVenGrupo, pMoeda2)
				//	@ nLi, 198 Psay Transform(nVenBaixa, pMoeda2)
					
					// Redefine as variaveis...
					nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar := 0
					nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa := 0
					
					nLi++
				Endif
				
				nLi++
				@ nLi, 000 Psay Replicate('_', nLimite)
				
				nLi += 2
				@ nLi, 003 Psay '**** '+cDesTipCb
				cTipoCob := TRB1->TR1_TIPCOB
				
				nLi += 2
				@ nLi, 006 Psay "Vencimento: " + dToc(TRB1->TR1_VENCTO)
				nLi++
				cDataBaixa := dToc(TRB1->TR1_VENCTO)
			Endif
			
			// Imprime o vencimento quando for analitico...
			If (Empty(cDataBaixa) .or. cDataBaixa <> dToc(TRB1->TR1_VENCTO))
				nLi++
				
				@ nLi, 000 Psay "Total..: "+cDataBaixa
				@ nLi, 016 Psay Transform(nVenMen, pMoeda2)
				@ nLi, 033 Psay Transform(nVenOpc, pMoeda1)
				@ nLi, 046 Psay Transform(nVenAde, pMoeda1)
				@ nLi, 059 Psay Transform(nVenDeb, pMoeda1)
				@ nLi, 072 Psay Transform(nVenCre, pMoeda1)
				@ nLi, 085 Psay Transform(nVenPF , pMoeda2)
				@ nLi, 102 Psay Transform(nVenTar, pMoeda1)
				@ nLi, 115 Psay Transform(nVenFar, pMoeda1)
				@ nLi, 128 Psay Transform(nVenJur, pMoeda1)
				@ nLi, 142 Psay Transform(nVenGui, pMoeda1)
				@ nLi, 155 Psay Transform(nVenCar, pMoeda1)
				@ nLi, 168 Psay Transform(nVenOut, pMoeda1)
				@ nLi, 181 Psay Transform(nVenGrupo, pMoeda2)
		  //		@ nLi, 198 Psay Transform(nVenBaixa, pMoeda2)
				
				// Redefine as variaveis...
				nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar := 0
				nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa := 0
				
				nLi += 2
				
				@ nLi, 006 Psay "Vencimento: " + dToc(TRB1->TR1_VENCTO)
				nLi++
				cDataBaixa := dToc(TRB1->TR1_VENCTO)
			Endif
			
			@ nLi, 000 Psay TRB1->(TR1_PREFIX + TR1_NUM + TR1_PARCEL + TR1_TIPO)
			@ nLi, 016 Psay Transform(TRB1->TR1_VLRMEN, pMoeda2); nTotMen += TRB1->TR1_VLRMEN; nTotGMen += TRB1->TR1_VLRMEN; nTotLinha += TRB1->TR1_VLRMEN
			@ nLi, 033 Psay Transform(TRB1->TR1_VLROPC, pMoeda1); nTotOpc += TRB1->TR1_VLROPC; nTotGOpc += TRB1->TR1_VLROPC; nTotLinha += TRB1->TR1_VLROPC
			@ nLi, 046 Psay Transform(TRB1->TR1_VLRTAX, pMoeda1); nTotAde += TRB1->TR1_VLRTAX; nTotGAde += TRB1->TR1_VLRTAX; nTotLinha += TRB1->TR1_VLRTAX
			@ nLi, 059 Psay Transform(TRB1->TR1_VLRDEB, pMoeda1); nTotDeb += TRB1->TR1_VLRDEB; nTotGDeb += TRB1->TR1_VLRDEB; nTotLinha += TRB1->TR1_VLRDEB
			@ nLi, 072 Psay Transform(TRB1->TR1_VLRCRE, pMoeda1); nTotCre += TRB1->TR1_VLRCRE; nTotGCre += TRB1->TR1_VLRCRE; nTotLinha -= TRB1->TR1_VLRCRE
			@ nLi, 085 Psay Transform(TRB1->TR1_VLRPF , pMoeda2); nTotPF  += TRB1->TR1_VLRPF;  nTotGPF	+= TRB1->TR1_VLRPF ; nTotLinha += TRB1->TR1_VLRPF
			@ nLi, 102 Psay Transform(TRB1->TR1_VLRTAR, pMoeda1); nTotTar += TRB1->TR1_VLRTAR; nTotGTar += TRB1->TR1_VLRTAR; nTotLinha += TRB1->TR1_VLRTAR
			@ nLi, 115 Psay Transform(TRB1->TR1_VLRFAR, pMoeda1); nTotFar += TRB1->TR1_VLRFAR; nTotGFar += TRB1->TR1_VLRFAR; nTotLinha += TRB1->TR1_VLRFAR
			@ nLi, 128 Psay Transform(TRB1->TR1_VLRJUR, pMoeda1); nTotJur += TRB1->TR1_VLRJUR; nTotGJur += TRB1->TR1_VLRJUR; nTotLinha += TRB1->TR1_VLRJUR
			@ nLi, 142 Psay Transform(TRB1->TR1_VLRGUI, pMoeda1); nTotGui += TRB1->TR1_VLRGUI; nTotGGui += TRB1->TR1_VLRGUI; nTotLinha += TRB1->TR1_VLRGUI
			@ nLi, 155 Psay Transform(TRB1->TR1_VLRCAR, pMoeda1); nTotCar += TRB1->TR1_VLRCAR; nTotGCar += TRB1->TR1_VLRCAR; nTotLinha += TRB1->TR1_VLRCAR
			@ nLi, 168 Psay Transform(TRB1->TR1_VLROUT, pMoeda1); nTotOut += TRB1->TR1_VLROUT; nTotGOut += TRB1->TR1_VLROUT; nTotLinha += TRB1->TR1_VLROUT
			@ nLi, 181 Psay Transform(nTotLinha, pMoeda2); nTotGrupo += nTotLinha
	  //		@ nLi, 198 Psay Transform(TRB1->TR1_VLRBAI, pMoeda2); nTotBaixa += TRB1->TR1_VLRBAI; nTotGBai += TRB1->TR1_VLRBAI
			
			nVenMen += TRB1->TR1_VLRMEN
			nVenOpc += TRB1->TR1_VLROPC
			nVenAde += TRB1->TR1_VLRTAX
			nVenDeb += TRB1->TR1_VLRDEB
			nVenCre += TRB1->TR1_VLRCRE
			nVenPF  += TRB1->TR1_VLRPF
			nVenTar += TRB1->TR1_VLRTAR
			nVenFar += TRB1->TR1_VLRFAR
			nVenJur += TRB1->TR1_VLRJUR
			nVenGui += TRB1->TR1_VLRGUI
			nVenCar += TRB1->TR1_VLRCAR
			nVenOut += TRB1->TR1_VLROUT
			nVenGrupo += nTotLinha
	//		nVenBaixa += TRB1->TR1_VLRBAI
			
			nLi++
			
			TRB1->( dbSkip() )
		Enddo
		
		// Quando imprime os titulo, deve haver uma soma do total do vencimento...
		nLi++
		@ nLi, 000 Psay "Total:"+cDataBaixa
		@ nLi, 016 Psay Transform(nVenMen, pMoeda2)
		@ nLi, 033 Psay Transform(nVenOpc, pMoeda1)
		@ nLi, 046 Psay Transform(nVenAde, pMoeda1)
		@ nLi, 059 Psay Transform(nVenDeb, pMoeda1)
		@ nLi, 072 Psay Transform(nVenCre, pMoeda1)
		@ nLi, 085 Psay Transform(nVenPF , pMoeda2)
		@ nLi, 102 Psay Transform(nVenTar, pMoeda1)
		@ nLi, 115 Psay Transform(nVenFar, pMoeda1)
		@ nLi, 128 Psay Transform(nVenJur, pMoeda1)
		@ nLi, 142 Psay Transform(nVenGui, pMoeda1)
		@ nLi, 155 Psay Transform(nVenCar, pMoeda1)
		@ nLi, 168 Psay Transform(nVenOut, pMoeda1)
		@ nLi, 181 Psay Transform(nVenGrupo, pMoeda2)
	  //	@ nLi, 198 Psay Transform(nVenBaixa, pMoeda2)
		
		// Redefine as variaveis...
		nVenMen := nVenOpc := nVenAde := nVenDeb := nVenCre := nVenPF  	:= nVenTar 		:= 0
		nVenFar := nVenJur := nVenGui := nVenCar := nVenOut := nVenGrupo	:= nVenBaixa 	:= 0
		
		nLi++
		
		// Imprime o total do plano, finalizando a quebra...
		nLi ++
		@ nLi, 000 Psay "Total:"+ _cAno + '/' + _cMes
		@ nLi, 016 Psay Transform(nTotMen, pMoeda2)
		@ nLi, 033 Psay Transform(nTotOpc, pMoeda1)
		@ nLi, 046 Psay Transform(nTotAde, pMoeda1)
		@ nLi, 059 Psay Transform(nTotDeb, pMoeda1)
		@ nLi, 072 Psay Transform(nTotCre, pMoeda1)
		@ nLi, 085 Psay Transform(nTotPF , pMoeda2)
		@ nLi, 102 Psay Transform(nTotTar, pMoeda1)
		@ nLi, 115 Psay Transform(nTotFar, pMoeda1)
		@ nLi, 128 Psay Transform(nTotJur, pMoeda1)
		@ nLi, 142 Psay Transform(nTotGui, pMoeda1)
		@ nLi, 155 Psay Transform(nTotCar, pMoeda1)
		@ nLi, 168 Psay Transform(nTotOut, pMoeda1)
		@ nLi, 181 Psay Transform(nTotGrupo, pMoeda2)
     //	@ nLi, 198 Psay Transform(nTotBaixa, pMoeda2)
		
		nLi ++
		@ nLi, 000 Psay Replicate('_', nLimite)
		nLi += 2
		//Endif
		// Incrementa total geral do relatorio
		nTotGeral += nTotGrupo
		
		// Incrementa total do plano
		nTotPMen += nTotMen
		nTotPOpc += nTotOpc
		nTotPAde += nTotAde
		nTotPDeb += nTotDeb
		nTotPCre += nTotCre
		nTotPPf  += nTotPF
		nTotPTar += nTotTar
		nTotPFar += nTotFar
		nTotPJur += nTotTit
		nTotPOut += nTotOut
		nTotPGui += nTotGui
		nTotPCar += nTotCar
		nTotPGrp += nTotGrupo
		nTotPBai += nTotBaixa
		
		// Reinicia as variaveis totalizadoras...
		nTotMen := nTotOpc := nTotAde := nTotDeb := 0
		nTotCre := nTotPF  := nTotTar := nTotFar := 0
		nTotJur := nTotTit := nTotOut := nTotGrupo := 0
		nTotGui := nTotCar := nTotBaixa := 0
		
	Enddo
	
	If  nli > nQtdLin
		nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
		nli++
		
		// Imprime o codigo do produto e a descricao quando mudar de pagina...
		@ nLi, 000 Psay '==> ' + cDesQuebr
		nLi+= 2
	Endif
	
	If nTipo == 2
		nLi++
	Endif
	// Imprime o total do plano, finalizando a quebra...
	@ nLi, 000 Psay "Total plano"
	
	@ nLi, 016 Psay Transform(nTotPMen, pMoeda2)
	@ nLi, 033 Psay Transform(nTotPOpc, pMoeda1)
	@ nLi, 046 Psay Transform(nTotPAde, pMoeda1)
	@ nLi, 059 Psay Transform(nTotPDeb, pMoeda1)
	@ nLi, 072 Psay Transform(nTotPCre, pMoeda1)
	@ nLi, 085 Psay Transform(nTotPPF , pMoeda2)
	@ nLi, 102 Psay Transform(nTotPTar, pMoeda1)
	@ nLi, 115 Psay Transform(nTotPFar, pMoeda1)
	@ nLi, 128 Psay Transform(nTotPJur, pMoeda1)
	@ nLi, 142 Psay Transform(nTotPGui, pMoeda1)
	@ nLi, 155 Psay Transform(nTotPCar, pMoeda1)
	@ nLi, 168 Psay Transform(nTotPOut, pMoeda1)
	@ nLi, 181 Psay Transform(nTotPGrp, pMoeda2)
 //	@ nLi, 198 Psay Transform(nTotPBai, pMoeda2)
	
	nLi ++
	@ nLi, 000 Psay Replicate('_', nLimite)
	
	nLi += 2
	
	// Reinicia as variaveis totalizadoras...
	nTotPMen := nTotPOpc := nTotPAde := nTotPDeb := 0
	nTotPCre := nTotPPF  := nTotPTar := nTotPFar := 0
	nTotPJur := nTotPTit := nTotPOut := nTotPGrp:= 0
	nTotPGui := nTotPCar := nTotPBai	:= 0
	
	// Total geral do relatorio
	nTotGeral += nTotGrupo
	
	nTotMen := nTotOpc := nTotAde := nTotDeb := 0
	nTotCre := nTotPF  := nTotTar := nTotFar := 0
	nTotJur := nTotTit := nTotOut := nTotGrupo := 0
	nTotBaixa := 0
	
Enddo

// Imprime os totais gerais
If  nli > nQtdLin
	nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
	nli++
Endif

// Imprime o total do plano, finalizando a quebra...
@ nLi, 000 Psay "Totais gerais "
@ nLi, 016 Psay Transform(nTotGMen, pMoeda3)
@ nLi, 033 Psay Transform(nTotGOpc, pMoeda1)
@ nLi, 046 Psay Transform(nTotGAde, pMoeda1)
@ nLi, 059 Psay Transform(nTotGDeb, pMoeda1)
@ nLi, 072 Psay Transform(nTotGCre, pMoeda1)
@ nLi, 085 Psay Transform(nTotGPF , pMoeda2)
@ nLi, 102 Psay Transform(nTotGTar, pMoeda1)
@ nLi, 115 Psay Transform(nTotGFar, pMoeda1)
@ nLi, 128 Psay Transform(nTotGJur, pMoeda1)
@ nLi, 142 Psay Transform(nTotGGui, pMoeda1)
@ nLi, 155 Psay Transform(nTotGCar, pMoeda1)
@ nLi, 168 Psay Transform(nTotGOut, pMoeda1)
@ nLi, 181 Psay Transform(nTotGeral, pMoeda3)
//@ nLi, 198 Psay Transform(nTotGBai, pMoeda3)

TRB1->( dbGotop() )
ctitulo := "R E S U M O    D A S    F A T U R A S    P A G A S "
nLi     := 80                                                                   
cCabec1 := "Titulo    Cliente                                              Vl Pago        "   
//            1234567890123456789012345678901234567890123456789012345678901234567890
cCabec2 := "                 "
nTotLinha := 0     
cQuebra   :=  " " 

While !TRB1->( Eof() )  
      
      If  nli > nQtdLin
    	  nli := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nCaracter)
          nli++
      EndIf    
      If  cQuebra    <>  TRB1->(TR1_FATPREF+TR1_FATURA)  
	    @ nLi, 000 Psay TRB1->(TR1_FATPRE + TR1_FATURA) + " " + TRB1->TR1_CLIFAT  
	    @ nli, 017 Psay TRB1->TR1_NOMCLI 
        @ nLi, 058 Psay Transform(TRB1->TR1_VALFAT, pMoeda2)
          nTotLinha += TRB1->TR1_VALFAT
          nli++                                        
          cQuebra    :=  TRB1->(TR1_FATPREF+TR1_FATURA) 
      EndIf    
      TRB1->(DbSkip())
EndDo     
	@ nLi, 000 Psay Replicate('_', nLimite)
	 nLi++
	@ nLi, 000 Psay "  Total ---->                    "  
    @ nLi, 058 Psay Transform( nTotLinha , pMoeda2) 
      nLi++
   	@ nLi, 000 Psay Replicate('_', nLimite)
                   
Return
