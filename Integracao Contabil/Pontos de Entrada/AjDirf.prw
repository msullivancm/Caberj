                                                   
#Define CRLF Chr(13)+Chr(10)
#include "rwmake.ch"
#include "TopConn.ch"

#Include "Colors.ch"
#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}

****************************
User Function AjDirf()
****************************                                                                                  

PRIVATE cChaveE5 := " " 
private cAnoBase := " "      
private conta    := 0       
private cCodRet1 := ' ' // Iif(cTpFornec == "F" '0588','1708') 
private cEmpresa:= Iif(cEmpAnt == '01','C','I') 

Private cAliastmp 	:= GetNextAlias()  

cPerg := "Dirf09"
aSx1  := {}
Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3","DEF01","DEF02"     ,"DEF03" ,"DEF04"  ,"DEF05"})
Aadd(aSx1,{cPerg  ,"01"   ,"Data de Baixa De......?","mv_ch1" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par01",""  ,""     ,""       ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"02"   ,"Data de Baixa Ate.....?","mv_ch2" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par02",""  ,""     ,""       ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"03"   ,"Tipo Fornecedor........?","mv_ch3" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par03",""  ,"Fisico"  ,"Juridico","" ,""       ,""     })
Aadd(aSx1,{cPerg  ,"04"   ,"Prefixo Titulo ........?","mv_ch4" ,"C"   ,03       ,0        ,"G"  ,""     ,"mv_par04",""  ,""    ,""       ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"05"   ,"Numero do Titulo ......?","mv_ch5" ,"C"   ,09       ,0        ,"G"  ,""     ,"mv_par05",""  ,""    ,""       ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"06"   ,"Incluir Titulos ........?","mv_ch6" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par06",""  ,"Sim" ,"Nao","" ,""       ,""     })
Aadd(aSx1,{cPerg  ,"07"   ,"Critica Baixa..........?","mv_ch7" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par07",""  ,"Sim" ,"Nao","" ,""       ,""     })
Aadd(aSx1,{cPerg  ,"08"   ,"Ano Dirf (base) .......?","mv_ch8" ,"C"   ,04       ,0        ,"G"  ,""     ,"mv_par08",""  ,""    ,""       ,""      ,""       ,""     })

fCriaSX1(cPerg,aSX1)

If !Pergunte(cPerg,.T.)
	Return
Endif
                
cAnoBase := mv_par08 
If mv_par03 == 1
	cTpFornec := "F"
	cCodRet1 := '0588'
Else
	cTpFornec := "J"
    cCodRet1 := '1708'
Endif

fSelecao()

Return


***************************
Static Function fSelecao()
***************************
Local cQry := " "

cQry += " SELECT Sum( E2_VALOR+E2_irrf+E2_INSS+E2_VRETPIS+E2_VRETCOF+E2_VRETCSL+E2_ISS ) E2BASE , "
cQry += "  Sum(E2_IRRF) E2IRRF , Sum(E2_INSS) E2INSS , "
cQry += "  Sum(E2_VRETPIS) E2PIS , Sum(E2_VRETCOF) E2COFINS , Sum(E2_VRETCSL) E2CSLL , A2_CGC ,"
  
cQry += "  SUBSTR(E2_BAIXA,1,4) ANO ,SUBSTR(E2_BAIXA,5,2)  MES  , " 

cQry += "  E2_FILIAL , E2_PREFIXO , E2_NUM , E2_PARCELA , E2_TIPO , E2_FORNECE , E2_LOJA ,"  
cQry += "         E2_CODRET , A2_TIPO , SE2.E2_BAIXA "

cQry += "  FROM " + RetSqlName("SE2") + " SE2 , "  +  RetSqlName("SA2")  + " SA2 "
cQry += "  WHERE  SE2.E2_FILIAL = '01' AND SA2.A2_FILIAL = ' ' AND SA2.A2_COD  = SE2.E2_FORNECE "
cQry += "           AND SA2.A2_LOJA = SE2.E2_LOJA "
cQry += "           AND SA2.A2_TIPO =  '" + cTpFornec + "' "
cQry += "           AND SE2.E2_SALDO = 0  "  

/// tratamento para a execção do tratamento do inss da integral do dia 03/01/2017    

If cEmpresa = 'C' 
   cQry += "           AND SE2.E2_BAIXA BETWEEN '" + dTos(mv_par01) + "'AND '" + dTos(mv_par02) + "'"         
Else                                                                                                              
   cQry += "           AND ( SE2.E2_BAIXA BETWEEN '" + dTos(mv_par01) + "' AND '" + dTos(mv_par02) + "')"
 //  cQry += "            OR  ( SE2.E2_BAIXA BETWEEN '20170101'  AND '20170103' and e2_codret = '0588' )) "
EndIf    

cQry += "           and e2_tipo not in ('RC') " // espurgo dos titulos tipo recibo
cQry += "           and E2_ORIGEM NOT IN ('FINA290') "  // espurgo dos titulos parcelados 

//cQry += "         AND SE2.E2_TIPO NOT IN ('NF','DP','TX','INS','ISS', 'PA' , 'DEV', 'AXF', 'FGT', 'REM', 'IRF','OP', 'FOL','RC', 'NDF','FER','RES','PEN','131','132') " 
//cQry += "           AND SE2.E2_TIPO NOT IN ('TX','INS','ISS', 'PA' , 'DEV', 'AXF', 'FGT', 'REM', 'IRF','OP', 'FOL', 'NDF','FER','RES','PEN','131','132') "
//cQry += "           AND SE2.E2_TIPO =('RC') "
cQry += "           AND (SA2.A2_CGC <> '              ' AND  SA2.A2_CGC <>  '00000000000000') "      
cQry += "           AND SE2.D_E_L_E_T_ = ' '   "
cQry += "           AND SA2.D_E_L_E_T_ = ' '   "

//bloquear aki 
//cQry += "    and e2_FORNECE IN ('187987','187896','191202','187887','187988','187986','190216','192495','190217','000902') "       

if  !empty (mv_par04)                              
    cQry += "           AND SE2.e2_prefixo = '"+ mv_par04 +"'"
    cQry += "           AND SE2.e2_num = '"+ mv_par05 +"'"
else
    cQry += "           AND SE2.E2_TIPO NOT IN ('TX','INS','ISS', 'PA' , 'DEV', 'AXF', 'FGT', 'REM', 'IRF','OP', 'FOL', 'NDF','FER','RES','PEN','131','132') "
endIf

cQry += "   and ( e2_origem in ('PLSMPAG', 'PLSM152') or ( EXISTS (select NULL FROM " + RetSqlName("SE2") + " SE21 , "  +  RetSqlName("SA2")  + " SA21 "
cQry += "   WHERE  SE21.E2_FILIAL = '01' AND SA21.A2_FILIAL = ' '  AND Se2.e2_fornece = SE21.E2_FORNECE AND SA21.A2_COD  = SE21.E2_FORNECE "
cQry += "   AND SA21.A2_LOJA = SE21.E2_LOJA "
cQry += "   AND SA2.A2_TIPO =  '" + cTpFornec + "' "
cQry += "   AND SE21.E2_SALDO = 0   "                                                     

If cEmpresa = 'C' 
   
   cQry += "   AND SE21.E2_BAIXA BETWEEN '" + dTos(mv_par01) + "'  AND '" + dTos(mv_par02) + "'"
   
Else

   cQry += "           AND ( SE21.E2_BAIXA BETWEEN '" + dTos(mv_par01) + "' AND '" + dTos(mv_par02) + "')"
 //  cQry += "            OR  ( SE21.E2_BAIXA BETWEEN '20170101'  AND '20170103' and e2_codret = '0588' )) "

EndIf    

cQry += "           and SE21.e2_tipo not in ('RC') " // espurgo dos titulos tipo recibo 
//cQry += "           and SE21.e2_tipo in ('RC') " // espurgo dos titulos tipo recibo
cQry += "           and SE21.E2_ORIGEM NOT IN ('FINA290') "  // espurgo dos titulos parcelados 


cQry += "   AND ( SE21.E2_IRRF > 0 OR SE21.E2_VRETPIS > 0 OR SE21.E2_VRETCOF > 0 OR SE21.E2_VRETCSL  > 0 OR SE21.E2_INSS > 0 ) "

//cQry += "   AND ( SE21.E2_IRRF = 0 AND  SE21.E2_VRETPIS = 0 AND  SE21.E2_VRETCOF = 0 AND  SE21.E2_VRETCSL  = 0 AND  SE21.E2_INSS =  0 )"

cQry += "   AND SE21.D_E_L_E_T_ = ' '   "
cQry += "   AND SA21.D_E_L_E_T_ = ' ' )  )  ) "
 
cQry += "           GROUP BY A2_CGC,SubStr(SE2.E2_BAIXA,5,2) , E2_FILIAL , E2_PREFIXO , E2_NUM , E2_PARCELA , E2_TIPO , E2_FORNECE , E2_LOJA , decode(SUBSTR(E2_BAIXA,1,4), '2016' ,SUBSTR(E2_BAIXA,5,2),'12') ,E2_CODRET , A2_TIPO , SE2.E2_BAIXA   "


/////////////////////////////////////////////
/*cQry := "  SELECT SUM( E2_VALOR+E2_IRRF+E2_INSS+E2_VRETPIS+E2_VRETCOF+E2_VRETCSL+E2_ISS ) E2BASE ,   " 
cQry += "         SUM(E2_IRRF) E2IRRF ,   "
cQry += "         SUM(E2_INSS) E2INSS ,    " 
cQry += "         SUM(E2_VRETPIS) E2PIS ,  " 
cQry += "         SUM(E2_VRETCOF) E2COFINS , "  
cQry += "         SUM(E2_VRETCSL) E2CSLL ,  " 
cQry += "         A2_CGC , "  
cQry += "         DECODE(E2_CODRET,'0588',(DECODE(SUBSTR(E2_BAIXA,5,4),'0504','04',SUBSTR(E2_BAIXA,5,2))),SUBSTR(E2_BAIXA,5,2)) MES , "     
cQry += "         E2_FILIAL , "  
cQry += "         E2_PREFIXO , "  
cQry += "         E2_NUM , E2_PARCELA , E2_TIPO ,  "
cQry += "         E2_FORNECE ,  "
cQry += "         E2_LOJA   ,   "
cQry += "         E2_CODRET , A2_TIPO , SE2.E2_BAIXA "
cQry += "    FROM SE2020 SE2 , SA2020 SA2   "  
cQry += "   WHERE SE2.E2_FILIAL = '01'   "
cQry += "     AND SA2.A2_FILIAL = ' '    "
cQry += "     AND SA2.A2_COD  = SE2.E2_FORNECE  "            
cQry += "     AND SA2.A2_LOJA = SE2.E2_LOJA     "         
cQry += "     AND SE2.E2_SALDO = 0              " 
cQry += "     AND (( SE2.E2_BAIXA BETWEEN '20170101'  AND '20171231' and  e2_codret in ('1708','8045')) "
cQry += "      OR  ( SE2.E2_BAIXA BETWEEN '20170104'  AND '20171231' and e2_codret = '0588' )) " 
     
cQry += "    and e2_tipo not in ('RC') "
cQry += "    and E2_ORIGEM NOT IN ('FINA290') "                                                      

cQry += "    AND (SA2.A2_CGC <> '              ' AND  SA2.A2_CGC <>  '00000000000000') "      
    
cQry += "    AND E2_BAIXA BETWEEN '20170101'  AND '20170531' " 
cQry += "    and e2_FORNECE IN ('131769','131900','140042')  "
 
cQry += "    AND SE2.D_E_L_E_T_ = ' '              AND SA2.D_E_L_E_T_ = ' ' "               
cQry += "    AND SE2.E2_TIPO NOT IN ('TX','INS','ISS', 'PA' , 'DEV', 'AXF', 'FGT', 'REM', 'IRF','OP', 'FOL', 'NDF','FER','RES','PEN','131','132') "   
   
cQry += "    AND ( E2_ORIGEM IN ('PLSMPAG', 'PLSM152') OR   "
cQry += "        ( EXISTS ( select NULL FROM SE2020 SE21 , SA2020 SA21  "   
cQry += "                    WHERE SE21.E2_FILIAL = '01'   "
cQry += "                      AND SA21.A2_FILIAL = ' '    "
cQry += "                      AND SE2.E2_FORNECE = SE21.E2_FORNECE "  
cQry += "                      AND SA21.A2_COD  = SE21.E2_FORNECE   "   
cQry += "                      AND SA21.A2_LOJA = SE21.E2_LOJA      "
cQry += "                      AND SE21.E2_SALDO = 0                "
cQry += "                      AND (SE2.E2_BAIXA BETWEEN '20170101'  AND '20171231' and  e2_codret in ('1708','8045') "
cQry += "                       OR ( SE2.E2_BAIXA BETWEEN '20170104'  AND '20171231' and e2_codret = '0588' )       ) "
cQry += "                      AND ( SE21.E2_IRRF > 0 OR SE21.E2_VRETPIS > 0 OR SE21.E2_VRETCOF > 0 OR SE21.E2_VRETCSL  > 0 OR SE21.E2_INSS > 0 ) "     
cQry += "                      AND SE21.D_E_L_E_T_ = ' ' "       
cQry += "                      AND SA21.D_E_L_E_T_ = ' ' )  )  ) "             
cQry += "  GROUP BY A2_CGC,SUBSTR(SE2.E2_BAIXA,5,2) , E2_FILIAL , E2_PREFIXO , E2_NUM , E2_PARCELA , E2_TIPO , E2_FORNECE , E2_LOJA , E2_CODRET , A2_TIPO , SE2.E2_BAIXA  "

cQry += "  UNION ALL "
cQry += " SELECT SUM( E2_VALOR+E2_IRRF+E2_INSS+E2_VRETPIS+E2_VRETCOF+E2_VRETCSL+E2_ISS ) E2BASE , "   
cQry += "        SUM(E2_IRRF) E2IRRF ,  " 
cQry += "        SUM(E2_INSS) E2INSS ,  "   
cQry += "        SUM(E2_VRETPIS) E2PIS ,"   
cQry += "        SUM(E2_VRETCOF) E2COFINS , "  
cQry += "        SUM(E2_VRETCSL) E2CSLL ,   "
cQry += "        A2_CGC , "  
cQry += "        DECODE(E2_CODRET,'0588',(DECODE(SUBSTR(E2_BAIXA,5,4),'0504','04',SUBSTR(E2_BAIXA,5,2))),SUBSTR(E2_BAIXA,5,2)) MES , "
cQry += "        E2_FILIAL , "  
cQry += "        E2_PREFIXO , " 
cQry += "        E2_NUM , E2_PARCELA , E2_TIPO , " 
cQry += "        E2_FORNECE ,                    "
cQry += "        E2_LOJA   ,                     "
cQry += "        E2_CODRET , A2_TIPO , SE2.E2_BAIXA "
cQry += "   FROM SE2020 SE2 , SA2020 SA2            "
cQry += "  WHERE SE2.E2_FILIAL = '01'               "
cQry += "    AND SA2.A2_FILIAL = ' '                "
cQry += "    AND SA2.A2_COD  = SE2.E2_FORNECE       "       
cQry += "    AND SA2.A2_LOJA = SE2.E2_LOJA          "    

cQry += "  AND SE2.E2_SALDO = 0                     "
cQry += "  AND (( SE2.E2_BAIXA BETWEEN '20170101'  AND '20171231' and  e2_codret in ('1708','8045')) "
cQry += "   OR  ( SE2.E2_BAIXA BETWEEN '20170104'  AND '20171231' and e2_codret = '0588' ))          "
     
cQry += "  and e2_tipo not in ('RC') "
    
cQry += "  and E2_ORIGEM NOT IN ('FINA290') "                                                 

cQry += "  AND (SA2.A2_CGC <> '              ' AND  SA2.A2_CGC <>  '00000000000000') "      
    
cQry += "  and e2_FORNECE NOT IN ('131769','131900','140042') "
 
cQry += "  AND SE2.D_E_L_E_T_ = ' '              AND SA2.D_E_L_E_T_ = ' ' "               
cQry += "  AND SE2.E2_TIPO NOT IN ('TX','INS','ISS', 'PA' , 'DEV', 'AXF', 'FGT', 'REM', 'IRF','OP', 'FOL', 'NDF','FER','RES','PEN','131','132')  " 
   
cQry += "  AND ( E2_ORIGEM IN ('PLSMPAG', 'PLSM152')   "
cQry += "   OR ( EXISTS ( select NULL FROM SE2020 SE21 , SA2020 SA21 "     
cQry += "                  WHERE SE21.E2_FILIAL = '01'   "
cQry += "                    AND SA21.A2_FILIAL = ' '    "
cQry += "                    AND SE2.E2_FORNECE = SE21.E2_FORNECE "  
cQry += "                    AND SA21.A2_COD  = SE21.E2_FORNECE   "   
cQry += "                    AND SA21.A2_LOJA = SE21.E2_LOJA      "
cQry += "                    AND SE21.E2_SALDO = 0                "
cQry += "                    AND (SE2.E2_BAIXA BETWEEN '20170101'  AND '20171231' and  e2_codret in ('1708','8045') "
cQry += "                     OR ( SE2.E2_BAIXA BETWEEN '20170104'  AND '20170131' and e2_codret = '0588' )       ) "
cQry += "                    AND ( SE21.E2_IRRF > 0 OR SE21.E2_VRETPIS > 0 OR SE21.E2_VRETCOF > 0 OR SE21.E2_VRETCSL  > 0 OR SE21.E2_INSS > 0 )    AND SE21.D_E_L_E_T_ = ' ' "      
cQry += "                    AND SA21.D_E_L_E_T_ = ' ' )  )  )  "            
cQry += " GROUP BY A2_CGC,SUBSTR(SE2.E2_BAIXA,5,2) , E2_FILIAL , E2_PREFIXO , E2_NUM , E2_PARCELA , E2_TIPO , E2_FORNECE , E2_LOJA , E2_CODRET , A2_TIPO , SE2.E2_BAIXA  "

cQry += " ORDER BY  8 , 14, 11 "

*/

/////////////////////////////////////////////
MemoWrit("c:\Microsiga\"+cPerg+".Sql",cQry)

If TcSqlExec(cQry) < 0                                                                                                       
	MsgInfo("Erro na seleção de Registros !!!")
	lContinua := .F.
	Return
Endif

If Select("TMP") > 0 ; TMP->(DbCloseArea()) ; Endif
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'TMP', .F., .T.)
SE5->(dbSetOrder(7))
RptStatus({|| fProcessa()},"Aguarde , Atualizando Base de dados...")

Return

**********************************
Static FuncTion fProcessa()
**********************************

DbSelectArea("TMP")
DbGoTop()
ProcRegua(RecCount())

While !Eof()
	IncProc()
	
    //cCodRet := fCodRet(cTpFornec)
	//cChave := fGravaRL(xFilial("SRL"),SM0->M0_CGC,cCodRet,cTpFornec,TMP->A2_CGC,TMP->MES)
	//fGravaDirf("A",cChave,cCodRet,TMP->E2BASE)
	  
		// Pula os títulos de baixados por cancelamento (can), dação (dac) e baixa nao financeiro (bnf)
	//////filtar motivo de baixa    
                                                  

	If fVldBaixa(TMP->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)) $ "DAC|CAN|BNF"      
       TMP->(DbSkip()) ; Loop
    EndIf   

 
	IF (TMP->E2IRRF = 0 .AND. TMP->E2INSS = 0 .AND. TMP->E2PIS = 0 .AND. TMP->E2COFINS = 0 .AND. TMP->E2CSLL = 0)
	//	cCodRet :=  fCodRet(cTpFornec)
	//	cCodRet :=  iif TMP->E2_codret

		cChave  := fGravaRL(xFilial("SRL"),SM0->M0_CGC,cCodRet1,cTpFornec,TMP->A2_CGC,TMP->MES)
	    fGravaDirf("A",cChave,cCodRet1,TMP->E2BASE)
	EndIf

	IF TMP->E2IRRF > 0
//		cCodRet :=  fCodRet(cTpFornec)
		cCodRet :=  TMP->E2_codret
		cChave := fGravaRL(xFilial("SRL"),SM0->M0_CGC,cCodRet1,cTpFornec,TMP->A2_CGC,TMP->MES)
	    fGravaDirf("A",cChave,cCodRet1,TMP->E2BASE)
		fGravaDirf("D",cChave,cCodRet1,TMP->E2IRRF)
	Endif
	
	IF TMP->E2INSS > 0
//		cCodRet :=  fCodRet(cTpFornec)
		cCodRet :=  TMP->E2_codret
	    cChave   := fGravaRL(xFilial("SRL"),SM0->M0_CGC,cCodRet1,cTpFornec,TMP->A2_CGC,TMP->MES)
   	
   	    IF TMP->E2IRRF == 0
	       fGravaDirf("A",cChave,cCodRet1,TMP->E2BASE)
		Endif
		
		fGravaDirf("B",cChave,cCodRet1,TMP->E2INSS)
	Endif 
	
	
	IF TMP->E2PIS  > 0
		cCodRet := "5979"
		cChave := fGravaRL(xFilial("SRL"),SM0->M0_CGC,cCodRet,cTpFornec,TMP->A2_CGC,TMP->MES)
  	   fGravaDirf("A",cChave,cCodRet,TMP->E2BASE)
		fGravaDirf("D",cChave,cCodRet,TMP->E2PIS)
	Endif
	
	IF TMP->E2COFINS > 0
		cCodRet := "5960"
		cChave := fGravaRL(xFilial("SRL"),SM0->M0_CGC,cCodRet,cTpFornec,TMP->A2_CGC,TMP->MES)
	    fGravaDirf("A",cChave,cCodRet,TMP->E2BASE)
		fGravaDirf("D",cChave,cCodRet,TMP->E2COFINS)
	Endif
	
	IF TMP->E2CSLL > 0
		cCodRet := "5987"
		cChave := fGravaRL(xFilial("SRL"),SM0->M0_CGC,cCodRet,cTpFornec,TMP->A2_CGC,TMP->MES)
 	    fGravaDirf("A",cChave,cCodRet,TMP->E2BASE)
		fGravaDirf("D",cChave,cCodRet,TMP->E2CSLL)
	Endif
	
	DbSelectArea("TMP")
	DbSkip()
	
Enddo

Return

********************************************************************************
Static FuncTion fGravaRL (xFil,xEmpresa,xCodret,xTipo,xCgc,xMes)
********************************************************************************
Local cRaMat   := " "
Local lRet     := .T.
Local cChaveR4 := " "

DbSelectArea("SRL")
DbSetOrder(2)

If  mv_par06 = 1 
    If  !SRL->(MsSeek(xFil+xEmpresa+xCodRet+Str(mv_Par03,1)+xCgc)) 
 	
   	    DbSelectArea("SA2")
	    DbSetOrder(3)
	    If DbSeek(xFilial("SA2")+xCgc)
		
		   Reclock("SRL", .T.)
		
		 //cRaMat := GetSxENum("SRL", "RL_MAT")
	       cRaMat := fMaxSrl()

			SRL->RL_FILIAL  := xFilial("SRL")
			SRL->RL_MAT     := cRaMat
			SRL->RL_CODRET  := xCodRet
			SRL->RL_TIPOFJ  := Str(mv_Par03,1)
			SRL->RL_CPFCGC  := xCgc
			SRL->RL_BENEFIC := SubStr(SA2->A2_NOME,1,60)
			SRL->RL_ENDBENE := Alltrim(SA2->A2_END) + Alltrim(SA2->A2_NR_END)
			SRL->RL_UFBENEF := SA2->A2_EST
			SRL->RL_COMPLEM := SA2->A2_BAIRRO
			SRL->RL_CGCFONT := SM0->M0_CGC
			SRL->RL_NOMFONT := SM0->M0_NOMECOM
		
	    	If  SRL->(FieldPos("RL_ORIGEM")) > 0
		        SRL->RL_ORIGEM := "2"
		    Endif
		
		    MsUnlock()
	    Endif
	
    Endif

    Return cChaveR4 := xFilial("SR4")+SRL->RL_MAT+TMP->A2_CGC+xCodRet+cAnoBase+xMes

Else            

    Return cChaveR4

EndIf 

************************************************************************
Static Function fGravaDirf(xTipoRen,cChave,xCodRet,xnValor)
************************************************************************

DbSelectArea("SR4")
DbSetOrder(1)     
conta++
if conta = 57  
   a:='b'  
endIf     

If mv_par06 = 1 
   If !SR4->( MsSeek( trim(cChave) + xTipoRen ))    
	
	Reclock("SR4", .T.)
	
	SR4->R4_FILIAL       := xFilial("SR4")
	SR4->R4_MAT          := SRL->RL_MAT
	SR4->R4_CPFCGC       := TMP->A2_CGC
	SR4->R4_MES          := TMP->MES
	SR4->R4_TIPOREN      := xTipoRen
	SR4->R4_CODRET       := xCodRet
	SR4->R4_ANO          := cAnoBase
	SR4->R4_VALOR        := xnValor   
	SR4->R4_ORIGEM       := "2"    
  Else
	Reclock("SR4", .F.)
	SR4->R4_VALOR   += xnValor
  Endif

  MsUnlock()                     
   
  EndIf
Return

**************************
Static Function fCriaSx1()
**************************

Local Z 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
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
***************************************************************
Static Function fVldBaixa(cChaveE5)
***************************************************************
local cMotBx:= " "	
if mv_par07 = 1
   	If  SE5->( MsSeek(cChaveE5) )

		While ! SE5->(eof()) .and. SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) == cChaveE5

             cMotBx:=SE5->E5_MOTBX	

	   		 SE5->(dbSkip())	
				
	   enddo	
	else
	  cMotBx:=" "
	EndIf      
EndIf	
return ( cMotBx ) 		

***********************************
Static Function fCodRet(xTipo)
**********************************
If xTipo == "J"
	cCodRet := "1708"
Else
	cCodRet := "0588"
Endif

Return cCodRet



Static Function fMaxSrl()
local cQuery := ' ' 
local nSeq   := 0
local cSeq   := ' '

cQuery := CRLF + "    SELECT MAX(RL_MAT) MATSRL " 
cQuery += CRLF + "      FROM "+ RetSqlName("SRL") +" SRL " 
cQuery += CRLF + "     WHERE RL_FILIAL = '" + xFilial("SRL") + "'" 
cQuery += CRLF + "       AND SRL.D_E_L_E_T_ = ' ' " 
   
   If Select((cAliastmp)) <> 0 
   
      (cAliastmp)->(DbCloseArea())  
  
   Endif 
        
   TCQuery cQuery  New Alias (cAliastmp)   

   (cAliastmp)->(dbGoTop()) 
  
    
 If (cAliastmp)->(!EOF()) 

     nseq := val((cAliastmp)->MATSRL)
    
     nseq++  
     
     cSeq := strzero(nseq ,6)
EndIf     


return(cSeq)
 
/*
If "00193125000185|00211733000175|01173071000159|01229226000121|01410045000105|01528526000101|01972465000177|02264664000193|;
 02287595000133|02471574000173|02687118000165|03519897000152|04041925000131|04366417000123|04521883000136|05965034000134|;
 06101246000136|06871629000274|07448144000154|07746888000155|08266776000160|08442945000175|08583580000107|08848810000104|;
 10551940000122|10855883000175|10960932000130|10961319000137|11900386000104|11922508000163|12981612000191|13066273000180|;
 15812370000109|17510562000188|18361017000130|20539121000113|20949556000136|21065973000189|21689212000106|21971978000170|;
 22574887000164|22653807000166|22931911000175|25177938000102|28707917000140|29184900000118|29739786000145|31605892000188|;
 40195745000178|40222077000120|48114367000596|74107483000164"
*/