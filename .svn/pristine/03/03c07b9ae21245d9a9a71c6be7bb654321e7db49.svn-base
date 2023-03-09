#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.CH"


/*
*------------------------------------------------------------------------------------------------*
* Programa	         |Autor	         | Data	   |Modulo	      |Tipo    	|Parametro         *
*------------------------------------------------------------------------------------------------*
*  DIRF08.prw        | Wellington      |05/05/2008 |Financeiro	   |Relatorio 	|Sim             *
*------------------------------------------------------------------------------------------------*
* Indices:Sim		                                                                             *
* Tabelas Abertas:                                                                               *
*                   ***DIRF***                                                                   *
*                                                                                                *
* Finalidade:  Emite relat๓rio de reten็ใo de IR, agrupando por Fornecedor X C๓digo de Reten็ใo X*
*------------  M๊s/Ano de Emissใo, conforme especificado pelo cliente                            *                                                                                  *
*                                                                                                *
* -----------				                                                                     *
* Autera็๕es:                                                                                    *
* -----------                                                                                    *
*------------------------------------------------------------------------------------------------*
* Autor        | Data      | Motivo:                                                             *
*------------------------------------------------------------------------------------------------*
*                                                                                                *
*------------------------------------------------------------------------------------------------*
*/

User Function CabDirf()

Local cDesc1       := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := "de acordo com os parametros informados pelo usuario."
Local cDesc3       := ""
Local cPict    	   := ""
Local titulo       := "D I R F"
Local nLin         := 80
Local imprime      := .T.
Local aOrd         := {}

Private lEnd       	:= .F.
Private lAbortPrint	:= .F.
Private CbTxt      	:= ""
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := "DIRF08"
Private nTipo      	:= 15
Private aReturn    	:= { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL      := 01
Private m_pag      	:= 01
Private wnrel      	:= "DIRF91"
Private cString    	:= "SE2"
Private cPerg       := "DIRF08"
Private cNatIrf     := &(SuperGetMV("MV_IRF"))

aReg  := {}
Aadd(aReg,{"GRUPO","ORDEM","PERGUNT"               ,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3","DEF01     ","DEF02           ","DEF03","DEF04","DEF05"})
aAdd(aReg,{cPerg  ,"01"   ,"Data de  	         ?","mv_ch1" ,"D"   ,08       ,0		,"G"  ,""	  ,"mv_par01"      ,"  "  ,"          ","                ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"02"   ,"Data Ate             ?","mv_ch2" ,"D"   ,08       ,0		,"G"  ,""     ,"mv_par02"     ,"  "  ,"          ","                ",""     ,""	  ,""})
aAdd(aReg,{cPerg  ,"03"   ,"Fornecedor De        ?","mv_ch3" ,"C"   ,06       ,0		,"G"  ,""     ,"mv_par03"     ,"SA2" ,"          ","                ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"04"   ,"Fornecedor Ate       ?","mv_ch4" ,"C"   ,06       ,0		,"G"  ,""     ,"mv_par04"     ,"SA2" ,"          ","                ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"05"   ,"Origem               ?","mv_ch5" ,"N"   ,01       ,0		,"C"  ,""     ,"mv_par05"     ,"  "  ,"PLS       ","Financeiro      ","Ambos",""     ,""})
aAdd(aReg,{cPerg  ,"06"   ,"Situacao             ?","mv_ch6" ,"N"   ,01       ,0		,"C"  ,""     ,"mv_par06"     ,"  "  ,"Todos     ","Com IR aberto   ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"07"   ,"Ordenacao            ?","mv_ch7" ,"N"   ,01		  ,0		,"C"  ,""     ,"mv_par07"     ,"  "  ,"Fornecedor","Cod.de Retencao ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"08"   ,"Excluir Codigo       ?","mv_ch8" ,"C"   ,04		  ,0		,"G"  ,""     ,"mv_par08"     ,"  "  ,"          ","                ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"09"   ,"Seleciona titulos    ?","mv_ch9" ,"N"   ,01		  ,0		,"C"  ,""     ,"mv_par09"     ,"  "  ,"Baixados  ","Emitidos        ","Vencidos"     ,""     ,""})
aAdd(aReg,{cPerg  ,"10"   ,"Prefixo de           ?","mv_cha" ,"C"   ,03		  ,0		,"G"  ,""     ,"mv_par10"     ,"  "  ,"          ","                ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"11"   ,"Prefixo Ate          ?","mv_chb" ,"C"   ,03		  ,0		,"G"  ,""     ,"mv_par11"     ,"  "  ,"          ","                ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"12"   ,"Filial de            ?","mv_chc" ,"C"   ,02		  ,0		,"G"  ,""     ,"mv_par12"     ,"SMO" ,"          ","                ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"13"   ,"Filial Ate           ?","mv_chd" ,"C"   ,02		  ,0		,"G"  ,""     ,"mv_par13"     ,"SMO" ,"          ","                ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"14"   ,"Cod.Reten็ใo         ?","mv_che" ,"C"   ,04		  ,0		,"G"  ,""     ,"mv_par14"     ,"  "  ,"          ","                ",""     ,""     ,""})
aAdd(aReg,{cPerg  ,"15"   ,"Imprime Subtotais    ?","mv_chf" ,"N"   ,01		  ,0		,"C"  ,""     ,"mv_par15"     ,"  "  ,"Sim       ","Nao             ",""     ,""     ,""})

fCriaSX1(cPerg,aReg)

If !Pergunte(cPerg,.T.)
	Return
Endif

//+-----------------------------------------------------------
//| Monta tela de paramentos para usuario, se cancelar sair  |
//+-----------------------------------------------------------

dbSelectArea("SE2")
dbSetOrder(1)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

Pergunte(cPerg,.f.)

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| ImpSintetico(Titulo,nLin) },Titulo)

DbSelectArea("TRB")
DbCloseArea()

SET DEVICE TO SCREEN
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDIRF91    บAutor  ณMicrosiga           บ Data ณ  05/11/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

*---------------------------------------*
Static Function ImpSintetico(Titulo,nLin)
*---------------------------------------*
Local nTotGBase := 0
Local nTotGIR   := 0
Local nTotGInss := 0
Local nTotGPis  := 0
Local nTotGCof  := 0
Local nTotGCSLL := 0
Local nTotGeral := 0

Cabec1       := "Fornecedor                                   CNPJ                     Emissao              Base               IRRF           INSS            Pis         Cofins           Csll                 Total Impostos"
Cabec2       := ""

cQuery := " SELECT SA2.A2_NOME,SA2.A2_COD,SA2.A2_LOJA,SE2.E2_CODRET,SA2.A2_CGC, SUBSTR(SE2.E2_EMISSAO,1,6) EMISSAO,"
cQuery += " SUM(SE2.E2_VALOR) E2_VLCRUZ,SUM(SE2.E2_IRRF) E2_IRRF,SUM(E2_INSS) E2_INSS,SUM(E2_PIS) E2_PIS,         "
cQuery += " SUM(E2_COFINS) E2_COFINS,SUM(E2_CSLL) E2_CSLL, SUM(E2_ISS+E2_INSS+E2_CSLL+E2_PIS+E2_COFINS) IMPOSTOS   "
cQuery += " FROM " + RetSQLName("SE2") + " SE2, " +RetSQLName("SA2") + " SA2"
cQuery += " WHERE SE2.E2_FORNECE = SA2.A2_COD AND SE2.E2_LOJA = SA2.A2_LOJA AND "
cQuery += " SE2.D_E_L_E_T_ <> '*' AND SA2.D_E_L_E_T_ <> '*' AND "
cQuery += " SE2.E2_FILIAL  between '" + mv_par12 + "' AND '" + mv_par13 + "' AND"
cQuery += " (SE2.E2_IRRF > 0 OR SE2.E2_PIS > 0 OR SE2.E2_COFINS > 0 OR SE2.E2_CSLL > 0 )  "

If MV_PAR09 == 1    // Titulos Baixados
	cQuery += " AND SE2.E2_BAIXA >= '" + Dtos(MV_PAR01) + "' AND  SE2.E2_BAIXA <= '" + Dtos(MV_PAR02) + "'"
ElseIf MV_PAR09 == 2
	cQuery += " AND SE2.E2_BAIXA = ' ' AND SE2.E2_EMISSAO >= '" + Dtos(MV_PAR01) + "' AND SE2.E2_EMISSAO <= '" + Dtos(MV_PAR02) + "'"
Else
	cQuery += " AND SE2.E2_VENCREA >= '" + Dtos(MV_PAR01) + "' AND  SE2.E2_VENCREA <= '" + Dtos(MV_PAR02) + "'"
Endif

cQuery += " AND SE2.E2_PREFIXO >= '" + MV_PAR10 + "' AND  SE2.E2_PREFIXO <= '" + MV_PAR11 + "'"
cQuery += " AND SE2.E2_FORNECE >= '" + MV_PAR03 + "' AND  SE2.E2_FORNECE <= '" + MV_PAR04 + "'"

If MV_PAR05 == 1 //PLS
   cQuery += "  And E2_ORIGEM = 'PLSMPAG'"
ElseIf mv_par05 == 2                                           
   cQuery += "  And E2_ORIGEM <> 'PLSMPAG'"
Endif

If MV_PAR06 = 2    // Situa็ใo - 1=Todos 2=Com IR nใo pago
	cQuery += " AND SE2.E2_PREFIXO||SE2.E2_NUM||SE2.E2_PARCELA IN (SELECT E2_PREFIXO||E2_NUM||E2_PARCELA FROM " + RetSqlName("SE2") +" E2IRF"
	cQuery += " WHERE E2IRF.D_E_L_E_T_ <> '*'  AND"
	cQuery += " E2IRF.E2_SALDO = E2IRF.E2_VALOR AND E2IRF.E2_NATUREZ = 'IRF' AND"
	cQuery += " SE2.E2_NUM = E2IRF.E2_NUM AND SE2.E2_PREFIXO = E2IRF.E2_PREFIXO AND"
	cQuery += " SE2.E2_PARCIR = E2IRF.E2_PARCELA)"
Endif
If !Empty(MV_PAR14)
	cQuery += " AND EXISTS(SELECT  E2_PREFIXO,E2_NUM,E2_PARCELA,E2_PARCELA,E2_PARCPIS,E2_PARCCOF,E2_PARCSLL,E2_PARCIR " 
   cQuery += " FROM SE2010 E2IRF WHERE E2IRF.D_E_L_E_T_ <> '*' "  
   cQuery += " AND E2IRF.E2_CODRET = '" + MV_PAR14 + "'" 
   cQuery += " AND SE2.E2_NUM      = E2IRF.E2_NUM "
   cQuery += " AND SE2.E2_PREFIXO  = E2IRF.E2_PREFIXO "
   cQuery += " AND (SE2.E2_PARCIR  = E2IRF.E2_PARCELA OR SE2.E2_PARCPIS = E2IRF.E2_PARCELA "
   cQuery += " OR   SE2.E2_PARCCOF = E2IRF.E2_PARCELA  OR SE2.E2_PARCSLL = E2IRF.E2_PARCELA))"
EndIf

If mv_par07=1   // 1=Ordena por Fornecedor ou 2=por C๓digo de Reten็ใo
	cQuery += " GROUP BY SA2.A2_NOME, SA2.A2_COD, SA2.A2_LOJA, SE2.E2_CODRET, SA2.A2_CGC, SUBSTR(SE2.E2_EMISSAO,1,6)"
	cQuery += " ORDER BY SA2.A2_NOME, SA2.A2_COD, SA2.A2_LOJA, SE2.E2_CODRET, SA2.A2_CGC, SUBSTR(SE2.E2_EMISSAO,1,6)"
Else
	cQuery += " GROUP BY SE2.E2_CODRET, SA2.A2_NOME, SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CGC, SUBSTR(SE2.E2_EMISSAO,1,6)"
	cQuery += " ORDER BY SE2.E2_CODRET, SA2.A2_NOME, SA2.A2_COD, SA2.A2_LOJA, SA2.A2_CGC, SUBSTR(SE2.E2_EMISSAO,1,6)"
Endif

Memowrit("c:\dirf08.txt",cQuery)
TCQuery cQuery Alias "TRB" New

@ 0,0 PSAY AVALIMP(220)
cChaveAnt  		:= ""
cCodRetAnt 	:= ""
aTotCodRet 	:= {0,0}
//
nTotMes1   	:= 0
nTotMes2   	:= 0
nTotInss    := 0
nTotPis		:= 0
nTotCofins	:= 0
nTotCsll	:= 0
nTotImp     := 0

dbGoTop()
cChavMesAnt := TRB->E2_CODRET + TRB->A2_NOME + TRB->A2_CGC + left(TRB->EMISSAO,6)
//
While !EOF()
	
	nTotImp := 0
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	If nLin > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif
	
	If cChaveAnt <> TRB->E2_CODRET + TRB->A2_NOME + TRB->A2_CGC
		nlin ++
		//@ nlin,00 Psay TRB->E2_CODRET
		@ nlin,00 Psay TRB->A2_COD + " " + TRB->A2_LOJA + " " + Substr(TRB->A2_NOME,1,30)
		@ nlin,45 Psay TRB->A2_CGC Picture "@R 99.999.999/9999-99"
	Endif
	
	cChaveAnt := TRB->E2_CODRET + TRB->A2_NOME + TRB->A2_CGC
	nBase     := TRB->E2_VLCRUZ+TRB->E2_IRRF+TRB->IMPOSTOS
	
	If TRB->E2_PIS > 0 .AND. TRB->E2_COFINS > 0 .AND. TRB->E2_CSLL > 0
		nTotImp :=   TRB->E2_PIS + TRB->E2_COFINS + TRB->E2_CSLL
	Endif
	
	@ nlin,70  Psay Substr(TRB->EMISSAO,5,2)+"/"+Substr(TRB->EMISSAO,1,4)
	@ nlin,84  Psay nBase           Picture "@E 9999,999.99"
	@ nlin,104 Psay TRB->E2_IRRF    Picture "@E 999,999.99"
	@ nLin,119 Psay TRB->E2_INSS    Picture "@E 999,999.99"
	@ nLin,134 Psay TRB->E2_PIS     Picture "@E 999,999.99"
	@ nLin,149 Psay TRB->E2_COFINS  Picture "@E 999,999.99"
	@ nLin,164 Psay TRB->E2_CSLL    Picture "@E 999,999.99"
	@ nLin,191 Psay nTotImp         Picture "@E 999,999,999.99"
	
	aTotCodRet[1] += nBase
	aTotCodRet[2] += TRB->E2_IRRF
	cCodRetAnt    := TRB->E2_CODRET
	nTotMes1      := nTotMes1   + nBase
	nTotMes2      := nTotMes2   + TRB->E2_IRRF
	nTotInss      := nTotInss   + TRB->E2_INSS
	nTotPis       := nTotPis    + TRB->E2_PIS
	nTotCofins    := nTotCofins + TRB->E2_COFINS
	nTotCsll      := nTotCsll   + TRB->E2_CSLL
	
	nTotGBase       += nBase
	nTotGIR         += TRB->E2_IRRF
	nTotGINSS       += TRB->E2_INSS
	nTotGPis        += TRB->E2_PIS
	nTotGCof        += TRB->E2_COFINS
	nTotGCSLL       += TRB->E2_CSLL
	nTotGeral       += nTotImp
	
	nLin++
	
	dbSkip()
	
	If MV_PAR15 = 1
		If (cChavMesAnt <> TRB->E2_CODRET + TRB->A2_NOME + TRB->A2_CGC + left(TRB->EMISSAO,6)) .or. ;
			(MV_PAR07=2 .and. (cCodRetAnt <> TRB->E2_CODRET .or. Eof()))
			nlin++
			@ nLin,120 Psay Replicate("-",100)
			nLin++
			@ nlin,30  Psay "           Total no Mes : "
			@ nlin,081 Psay nTotMes1    Picture "@E 999,999,999.99"
			@ nlin,104 Psay nTotMes2    Picture "@E 999,999.99"
			@ nlin,119 Psay nTotInss    Picture "@E 999,999.99"
			@ nlin,134 Psay nTotPis     Picture "@E 999,999.99"
			@ nlin,149 Psay nTotCofins  Picture "@E 999,999.99"
			@ nlin,164 Psay nTotCsll  	 Picture "@E 999,999.99"
			@ nlin,191 Psay nTotImp  	 Picture "@E 999,999,999.99"
			
			nLin+=2
			@ nlin,45  Psay Replicate("_",175)
			nLin+=2
			
			cChavMesAnt   := TRB->E2_CODRET + TRB->A2_NOME + TRB->A2_CGC + left(TRB->EMISSAO,6)
			nTotMes1      := 0
			nTotMes2      := 0
			nTotInss      := 0
			nTotPis       := 0
			nTotCofins    := 0
			nTotCsll      := 0
			nTotImp       := 0
		Endif
		//
	EndIf
	
	If MV_PAR07=2 .and. (cCodRetAnt <> TRB->E2_CODRET .or. Eof())
		nlin++
		@ nlin,30  Psay "Total do Codigo de Retencao : " + Substr(cCodRetAnt,1,10)
		@ nlin,81  Psay aTotCodRet[1]  Picture "@E 99,999,999.99"
		@ nlin,104 Psay aTotCodRet[2]  Picture "@E 999,999.99"
		nLin+=2
	   
	   aTotCodRet[1] := 0
		aTotCodRet[2] := 0
	
	Endif
	
EndDo

@ nlin,0 Psay " "
nLin++
@ nLin, 00 Psay Replicate("-",220)
nLin++
@ nLin, 00 Psay "T O T A L ----------------> "
@ nLin, 081 Psay Transform(nTotGBase,"@E 999,999,999.99")
@ nLin, 104 Psay Transform(nTotGIR, "@E 999,999.99")
@ nLin, 119 Psay Transform(nTotGINSS, "@E 999,999.99")
@ nLin, 134 Psay Transform(nTotGPIS,"@E 999,999.99")
@ nLin, 149 Psay Transform(nTotGCof,"@E 999,999.99")
@ nLin, 164 Psay Transform(nTotGCSLL,"@E 999,999.99")
@ nLin, 191 Psay Transform(nTotGeral,"@E 999,999,999.99")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDIRF91    บAutor  ณMicrosiga           บ Data ณ  05/11/08   บฑฑ
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
Static Function fCriaSx1()
**************************

Local Z 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local X1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local X2 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

SX1->(DbSetOrder(1))

If !SX1->(DbSeek(cPerg+aReg[Len(aReg),2]))
	SX1->(DbSeek(cPerg))
	While SX1->(!Eof()) .And. Alltrim(SX1->X1_GRUPO) == cPerg
		SX1->(Reclock("SX1",.F.,.F.))
		SX1->(DbDelete())
		SX1->(MsunLock())
		SX1->(DbSkip())
	End
	For X1:=2 To Len(aReg)
		SX1->(RecLock("SX1",.T.))
		For Z:=1 To Len(aReg[1])
			cCampo := "X1_"+aReg[1,Z]
			SX1->(FieldPut(FieldPos(cCampo),aReg[X1,Z] ))
		Next
		SX1->(MsunLock())
	Next
Endif

Return
