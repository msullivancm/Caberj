#Define CRLF Chr(13)+Chr(10)
#include "rwmake.ch"
#include "TopConn.ch"

#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}

****************************
User Function Dirfnt()
****************************

cPerg := "DIRFNT"
aSx1  := {}
Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3","DEF01","DEF02"     ,"DEF03" ,"DEF04"  ,"DEF05"})
Aadd(aSx1,{cPerg  ,"01"   ,"Data de Baixa De......?","mv_ch1" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par01",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"02"   ,"Data de Baixa Ate.....?","mv_ch2" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par02",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"03"   ,"Tipo Fornecedor........?","mv_ch3" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par03",""  ,"Fisico"  ,"Juridico","" ,""       ,""     })

fCriaSX1(cPerg,aSX1)

If !Pergunte(cPerg,.T.)
	Return
Endif

dDataIni := mv_par01
dDataFim := mv_par02
cTpFor   := IIF(mv_par03 == 1 , "F","J")

MsgRun("Aguarde... Selecionando dados para Gravação..."," ",{|| fSelecao()})

Return

**************************
Static Function fSelecao()
**************************

Private cQuery := " "
Private cAbatim 	 := MV_CRNEG+"|"+MV_CPNEG+"|"+MVIRABT+"|"+MVCSABT+"|"+MVCFABT+"|"+MVPIABT+"|"+MVABATIM
Private cImpostos  := MVISS+"|"+MVTAXA+"|"+MVTXA+"|"+MVINSS+"|"+"SES"
Private cNotIn     := FormatIn(cAbatim+"|"+cImpostos+"|"+MVPROVIS+"|"+MVPAGANT,"|")
Private cChaveR4   := ""

cQuery := "SELECT B.E2_FILIAL FILIAL,"
cQuery += "       B.E2_PREFIXO PREFIXO,"
cQuery += "       B.E2_NUM NUMERO,"
cQuery += "       Sum(B.E2_VALOR+B.E2_IRRF+B.E2_INSS+B.E2_VRETPIS+B.E2_VRETCOF+B.E2_VRETCSL+B.E2_ISS ) BASE,"
cQuery += "       Sum(B.E2_IRRF) IRRF,"
cQuery += "       Sum(B.E2_INSS) INSS,"
cQuery += "       Sum(B.E2_PIS) PIS,"
cQuery += "       Sum(B.E2_COFINS) COFINS,"
cQuery += "       Sum(B.E2_CSLL) CSLL,"
cQuery += "       A.A2_CGC CGC,"
cQuery += "       B.E2_FORNECE COD_FORNEC,"
cQuery += "       SubStr(E2_BAIXA,5,2) MES,"
cQuery += "       'N' TIPO,"
cQuery += "       Sum(B.E2_VALOR) VALOR"

cQuery += "  FROM " + RetSqlName("SE2") + " B , "

cQuery += "       (SELECT SE2.E2_FORNECE,"
cQuery += "               SA2.A2_CGC"

cQuery += "          FROM " + RetSqlName("SE2") + " SE2 , "
cQuery += "               " + RetSqlName("SA2") + " SA2 "

cQuery += "         WHERE SA2.A2_COD  = SE2.E2_FORNECE"
cQuery += "           AND SA2.A2_LOJA = SE2.E2_LOJA"
cQuery += "           AND SA2.A2_TIPO = '"+ cTpFor + "'"
cQuery += "           AND SE2.E2_SALDO = 0"
cQuery += "           AND SE2.E2_BAIXA BETWEEN '" + dtos(dDataIni) + "' AND '" + dtos(dDataFim) + "'"
cQuery += "           AND ( SE2.E2_IRRF > 0 OR SE2.E2_VRETPIS > 0 OR SE2.E2_VRETCOF > 0 OR SE2.E2_VRETCSL  > 0 OR SE2.E2_INSS > 0 )"
cQuery += "           AND SE2.E2_TIPO NOT IN " + cNotIn  
cQuery += "           AND SE2.D_E_L_E_T_ = ' '"
cQuery += "           AND SA2.D_E_L_E_T_ = ' '"
cQuery += "           AND SE2.E2_CODRET <> ' '"

cQuery += "         GROUP BY SE2.E2_FORNECE,"
cQuery += "                  SA2.A2_CGC) A"

cQuery += "   WHERE B.D_E_L_E_T_ = ' '"
cQuery += "     AND B.E2_FORNECE  = A.E2_FORNECE"
cQuery += "     AND B.E2_TIPO NOT IN " + cNotIn  
cQuery += "     AND B.E2_BAIXA BETWEEN '" + dtos(dDataIni) + "' AND '" + dtos(dDataFim) + "'"
cQuery += "     AND B.E2_IRRF = 0"
cQuery += "     AND B.E2_INSS = 0"

cQuery += "   GROUP BY B.E2_FILIAL,"
cQuery += "         B.E2_PREFIXO,"
cQuery += "         B.E2_NUM,"
cQuery += "         A.A2_CGC,"
cQuery += "         B.E2_FORNECE,"
cQuery += "         SubStr(E2_BAIXA,5,2)"

cQuery += "   ORDER BY A.A2_CGC,"
cQuery += "         SubStr(E2_BAIXA,5,2),"
cQuery += "         B.E2_FILIAL,"
cQuery += "         B.E2_PREFIXO,"
cQuery += "         B.E2_NUM"


cCaminho:='c:\microsiga\"
MemoWrit(cCaminho+cPerg+".Sql",cQuery)

If TcSqlExec(cQuery) < 0
	MsgInfo("Erro na seleção de Registros !!!")
	lContinua := .F.
	Return
Endif

If Select("TMP") > 0 ; TMP->(DbCloseArea()) ; Endif
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'TMP', .F., .T.)


DbSelectArea("TMP")
DbGoTop()

While !eof()
	
	cChaveR4 := ""
	
	fGravaRL(xFilial("SRL"),SM0->M0_CGC,IIF(cTpFor == "J",'1708','0588'),cTpFor,TMP->CGC,TMP->MES)
	fGravaDirf('A',cChaveR4,IIF(cTpFor == "J",'1708','0588'),TMP->BASE)
	
	dbSelectArea("TMP")
	DBSkip()
Enddo

********************************************************************************
Static FuncTion fGravaRL(xFil,xEmpresa,xCodret,xTipo,xCgc,xMes)
********************************************************************************
Local cRaMat := " "
Local lRet       := .T.

DbSelectArea("SRL")
DbSetOrder(2)

If !SRL->(MsSeek(xFil+xEmpresa+xCodRet+Str(mv_Par03,1)+xCgc))
	
	DbSelectArea("SA2")
	DbSetOrder(3)
	If DbSeek(xFilial("SA2")+xCgc)
		
		Reclock("SRL", .T.)
		cRaMat := GetSxENum("SRL", "RL_MAT")
		
		SRL->RL_FILIAL   := xFilial("SRL")
		SRL->RL_MAT      := cRaMat
		SRL->RL_CODRET   := xCodRet
		SRL->RL_TIPOFJ   := Str(mv_Par03,1)
		SRL->RL_CPFCGC   := xCgc
		SRL->RL_BENEFIC  := SubStr(SA2->A2_NOME,1,60)
		SRL->RL_ENDBENE  := Alltrim(SA2->A2_END) + Alltrim(SA2->A2_NR_END)
		SRL->RL_UFBENEF  := SA2->A2_EST
		SRL->RL_COMPLEM  := SA2->A2_BAIRRO
		SRL->RL_CGCFONT  := SM0->M0_CGC
		SRL->RL_NOMFONT  := SM0->M0_NOMECOM
		
		If SRL->(FieldPos("RL_ORIGEM")) > 0
			SRL->RL_ORIGEM := "2"
		Endif
		
		MsUnlock()
	Endif
	
Endif

Return cChaveR4 := xFilial("SR4")+SRL->RL_MAT+TMP->CGC+xCodRet+"2009"+xMes

************************************************************************
Static Function fGravaDirf(xTipoRen,cChave,xCodRet,xnValor)
************************************************************************

DbSelectArea("SR4")
DbSetOrder(1)

If !SR4->( MsSeek( cChave + xTipoRen ))
	
	Reclock("SR4", .T.)
	
	SR4->R4_FILIAL       := xFilial("SR4")
	SR4->R4_MAT          := SRL->RL_MAT
	SR4->R4_CPFCGC       := TMP->CGC
	SR4->R4_MES          := TMP->MES
	SR4->R4_TIPOREN      := xTipoRen
	SR4->R4_CODRET       := xCodRet
	SR4->R4_ANO          := "2009"
	SR4->R4_VALOR        := xnValor
Else
	Reclock("SR4", .F.)
	SR4->R4_VALOR   += xnValor
Endif

MsUnlock()

Return


**************************
Static Function fCriaSx1()
**************************

Local z 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local X1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

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
