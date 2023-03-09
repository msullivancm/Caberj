#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR282      บAutor  ณ PAULO MOTTA        บ Data ณ SETEMBRO/20 บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  GERA PLANILHA PARA CONFERENCIA VALORES PRATICADOS POR RDA    บฑฑ 
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Projeto CABERJ                                                บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR282()     
      
Processa({||PCABR282()},'Processando...')

Return

Static Function PCABR282

Local aSaveArea	:= {} 

Local aCabec := {}
Local aDados := {} 


Local cLisRDA := " "  
Local cRefDe  := " " 
Local cRefAte := " " 
Local cEmp    := " "
Local cTab282 := " " 
Local cFun282 := " "  
Local cEmp282 := " "      
Local nI 	  := 0     

Private cPerg := "CAB282"

aSaveArea	:= GetArea()
AjustaSX1()    
 
//Monta tabela/parametro das functiions conforme Empresa(Caberj/Integral) 
If cEmpAnt = "01" 
  cTab282 := "V_CUSTO_CAB_ABERTO"  
  cFun282 := "CALC_PROC_X"
  cEmp282 := "'C'"
Else  
  cTab282 := "V_CUSTO_INT_ABERTO"   
  cFun282 := "CALC_PROC_INT_X"   
  cEmp282 := "'I'"
End if  

//ler parametros 
If Pergunte(cPerg,.T.)  
   	cLisRDA := AllTrim(mv_par01)
	cRefDe  := mv_par02
    cRefAte := mv_par03   
else
    Return	
EndIf         

//If cEmpAnt = "01" 

//Monta query 
cQuery := " SELECT CODRDA,   " + c_ent  
cQuery += "        NOME_RDA, " + c_ent   
cQuery += "        TABELA,   " + c_ent   
cQuery += "        COD_PROC, " + c_ent   
cQuery += "        DESPRO,   " + c_ent   
cQuery += "        TIPPROC,  " + c_ent   
cQuery += "        CALC_PROC," + c_ent   
cQuery += "        QTDE,     " + c_ent   
cQuery += "        VL_APROV, " + c_ent   
cQuery += "        VLR_UNIT  " + c_ent  
cQuery += "  FROM            " + c_ent   
cQuery += "  (               " + c_ent 
cQuery += "  SELECT BAU_CODIGO CODRDA,                                    " + c_ent   
cQuery += "         NVL(TRIM(BAU_NFANTA),TRIM(BAU_NOME)) NOME_RDA,        " + c_ent 
cQuery += "         TABELA,                                               " + c_ent   
cQuery += "         COD_PROCED COD_PROC,                                  " + c_ent 
cQuery += "         DESPRO DESPRO,                                        " + c_ent   
cQuery += "         DECODE(BR8_TPPROC,'0','PROCEDIMENTO','1','MATERIAL','2','MEDICAMENTO','3','TAXAS',                              " + c_ent 
cQuery += "                                              '4',DECODE(INSTR(BR8_DESCRI,'ACOMPANHANTE'),0,'DIARIAS','DIARIA ACOMP'),   " + c_ent   
cQuery += "                                              '5','OPME','6','PACOTES','7','GASES MEDICINAIS','8','ALUGUEIS','PROCEDIMENTO') TIPPROC,  " + c_ent 
cQuery += "         " + cFun282 + "(BAU_CODIGO,TABELA,COD_PROCED) CALC_PROC, " + c_ent   
cQuery += "         SUM(QTDE) QTDE,                                           " + c_ent 
cQuery += "         SUM(VL_APROV) VL_APROV ,                                  " + c_ent   
cQuery += "         (CASE WHEN SUM(QTDE) <> 0 THEN                            " + c_ent 
cQuery += "                 ROUND(SUM(VL_APROV)/SUM(QTDE),2)                  " + c_ent   
cQuery += "                ELSE NULL END) VLR_UNIT                            " + c_ent 
cQuery += " FROM   " + cTab282 + " VC, " + RetSqlName("BAU") + " BAU , " + RetSqlName("BR8") + " BR8 "  + c_ent 
cQuery += "  WHERE  BAU.D_E_L_E_T_ = ' '               " + c_ent 
cQuery += "  AND    BR8.D_E_L_E_T_ = ' '               " + c_ent 
cQuery += "  AND    BAU_FILIAL = '  '                  " + c_ent 
cQuery += "  AND    BAU_CODIGO = RDA                   " + c_ent 
cQuery += "  AND    BR8_FILIAL = '  '                  " + c_ent 
cQuery += "  AND    BR8_CODPAD = TABELA                " + c_ent 
cQuery += "  AND    BR8_CODPSA = COD_PROCED            " + c_ent 
cQuery += "  AND    REFER BETWEEN '"+cRefDe+"' AND '"+cRefAte+"'    " + c_ent 
cQuery += "  AND    VL_APROV > 0                       " + c_ent 
cQuery += "  AND    INSTR('"+cLisRDA+"',RDA) > 0       " + c_ent 
cQuery += " GROUP BY BAU_CODIGO,                            " + c_ent 
cQuery += "          NVL(TRIM(BAU_NFANTA),TRIM(BAU_NOME)),  " + c_ent 
cQuery += "          TABELA,                                " + c_ent 
cQuery += "          COD_PROCED,                            " + c_ent 
cQuery += "          DESPRO,                                " + c_ent 
cQuery += "          DECODE(BR8_TPPROC,'0','PROCEDIMENTO','1','MATERIAL','2','MEDICAMENTO','3','TAXAS',                             " + c_ent 
cQuery += "                                               '4',DECODE(INSTR(BR8_DESCRI,'ACOMPANHANTE'),0,'DIARIAS','DIARIA ACOMP'),  " + c_ent 
cQuery += "                                               '5','OPME','6','PACOTES','7','GASES MEDICINAIS','8','ALUGUEIS','PROCEDIMENTO'),  " + c_ent 
cQuery += "          " + cFun282 + "(BAU_CODIGO,TABELA,COD_PROCED) " + c_ent 
cQuery += " )                                                      " + c_ent 
cQuery += " ORDER BY NOME_RDA,   " + c_ent 
cQuery += "          TABELA,     " + c_ent 
cQuery += "          COD_PROC    " 


//memowrite("C:\TEMP\sql282.sql",cQuery)      
                                                  
If Select("R282") > 0
	dbSelectArea("R282")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R282",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R282->(Eof())
	nSucesso := 0
	aCabec := {"CODRDA","NOME_RDA","TABELA","COD_PROC","DESPRO","TIPPROC","TAB_PROC","QTDE","VL_APROV","VLR_UNIT"} 
	R282->(DbGoTop())
	While ! R282->(Eof()) 
		IncProc()		
		aaDD(aDados,{R282->CODRDA , R282->NOME_RDA ,R282->TABELA , R282->COD_PROC , R282->DESPRO ,R282->TIPPROC , R282->CALC_PROC ,;
              	     R282->QTDE ,R282->VL_APROV ,R282->VLR_UNIT})  
		R282->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

EndIf	

If Select("R282") > 0
	dbSelectArea("R282")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelp2821 := {}
Local aHelp2822 := {}
Local aHelp2823 := {}
//Monta Help
Aadd( aHelp2821, 'Informe Lista de RDA ex 123456/234567' ) 
Aadd( aHelp2822, 'Informe Ref inicial AAAAMM ' )
Aadd( aHelp2823, 'Informe Ref final AAAAMM ' )


u_CABASX1(cPerg,"01","Lista RDA   "  ,"","","mv_ch01","C",99,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelp2821,{},{})
u_CABASX1(cPerg,"02","Refer De    "  ,"","","mv_ch02","C",06,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp2822,{},{})
u_CABASX1(cPerg,"03","Refer Ate   "  ,"","","mv_ch03","C",06,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp2823,{},{}) 
PutSX1Help("P."+cPerg+"01.",aHelp2821,{},{})
PutSX1Help("P."+cPerg+"02.",aHelp2822,{},{})
PutSX1Help("P."+cPerg+"03.",aHelp2823,{},{})

Return	