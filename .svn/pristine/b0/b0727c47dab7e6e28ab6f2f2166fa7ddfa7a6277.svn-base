#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
********************************************************************************
***Programa  *CABR270      *Autor  * PAULO MOTTA        * Data * JUNHO/19    ***
********************************************************************************
***Desc.     *  GERA PLANILHA CUSTO RDA EVENTO                              *** 
********************************************************************************
***Uso       * Projeto CABERJ                                                *** 
********************************************************************************
*/
User Function CABR270()   
      
Processa({||PCABR270()},'Processando...')

Return

Static Function PCABR270

Local aSaveArea	:= {} 

Local aCabec := {}
Local aDados := {} 

Local cRefDe  := " "   
Local cRefAte := " " 
Local cEmp    := " "
Local cEmp270 := " " 
Local cTab270 := " "    
Local nI 	  := 0     

Private cPerg := "CAB270"

aSaveArea	:= GetArea()
AjustaSX1()    
 
//Monta tabela/parametro das functiions conforme Empresa(Caberj/Integral) 
If cEmpAnt = "01"  
  cEmp270 := "'C'"
  cTab270 := "TOTAIS_POR_EVENTO_NOVA_RDA"
Else       
  cEmp270 := "'I'"
  cTab270 := "TOTAIS_POR_EVENTO_NOVA_RDA_INT"
End if  

//ler parametros 
If Pergunte(cPerg,.T.)   
       
else
    Return	
EndIf      

//Monta query 
cQuery := " SELECT MES_ANO_REF,   " + c_ent  
cQuery += "        RDA ,    " + c_ent
cQuery += "        NVL(TRIM(BAU_NFANTA),TRIM(BAU_NOME)) NOMERDA,    " + c_ent
cQuery += "        BAU_TIPPRE CLASSE_REDE,    " + c_ent
cQuery += "        BG9_CODIGO CODEMP,    " + c_ent
cQuery += "        BG9_NREDUZ NOMEEMP,    " + c_ent
cQuery += "        BI3_CODIGO CODPLANO,    " + c_ent
cQuery += "        BI3_NREDUZ NOMEPLANO,    " + c_ent
cQuery += "        BI3_SUSEP REGANS,    " + c_ent
cQuery += "        SUM (CASE WHEN TRIM(ZZS_GRPBEN) IN ('CONSULTAS')                              THEN CUSTO  ELSE 0 END) CUSTO_CONSULTAS,  " + c_ent 
cQuery += "        SUM (CASE WHEN TRIM(ZZS_GRPBEN) IN ('EXAMES','EXAMES SIMPLES')                THEN CUSTO  ELSE 0 END) CUSTO_EXAMES,  " + c_ent 
cQuery += "        SUM (CASE WHEN TRIM(ZZS_GRPBEN) IN ('EXAMES ESPECIAIS')                       THEN CUSTO  ELSE 0 END) CUSTO_ESPEXAMES,  " + c_ent 
cQuery += "        SUM (CASE WHEN TRIM(ZZS_GRPBEN) IN ('TERAPIAS')                               THEN CUSTO  ELSE 0 END) CUSTO_TERAPIAS,  " + c_ent 
cQuery += "        SUM (CASE WHEN TRIM(ZZS_GRPBEN) IN ('OUTROS ATENDIM AMBULATORIAIS')           THEN CUSTO  ELSE 0 END) CUSTO_OAA,  " + c_ent 
cQuery += "        SUM (CASE WHEN TRIM(ZZS_GRPBEN) IN ('DEMAIS DESPESAS ASSISTENCIAIS')          THEN CUSTO  ELSE 0 END) CUSTO_DDA,  " + c_ent 
cQuery += "        SUM (CASE WHEN TRIM(ZZS_GRPBEN) IN ('HONORARIOS MEDICOS','INTERNACAO','OPME') THEN CUSTO  ELSE 0 END) CUSTO_INTERNACAO,  " + c_ent
cQuery += "        SUM (CASE WHEN TRIM(ZZS_GRPBEN) IN ('ODONTOLOGIA')                            THEN CUSTO  ELSE 0 END) CUSTO_ODONTOLOGIA  " + c_ent
cQuery += "  FROM "+ cTab270 +" T,ZZS010 TE,"+RetSqlName('BAU')+" BAU,"+RetSqlName('BG9')+" BG9,"+RetSqlName('BI3')+" BI3 " + c_ent 
cQuery += "  WHERE  MES_ANO_REF BETWEEN TO_DATE('" + dToS(MV_PAR04) +"','YYYYMMDD') AND " + c_ent
cQuery += "                             TO_DATE('" + dToS(MV_PAR05) +"','YYYYMMDD') " + c_ent
if !Empty(MV_PAR02)
  cQuery += " AND T.GRUPO_EMPRESA = '" + MV_PAR02 + "'" + c_ent 
end if
if !Empty(MV_PAR03)
  cQuery += " AND T.COD_PLANO = '" + MV_PAR03 + "'" + c_ent 
end if
cQuery += " AND    T.COD_EVENTO=TE.ZZS_CODEVC   " + c_ent
cQuery += " AND    BAU_FILIAL = '  ' " + c_ent
cQuery += " AND    BG9_FILIAL = '  '   " + c_ent
cQuery += " AND    BI3_FILIAL = '  '   " + c_ent
cQuery += " AND    BAU_CODIGO = T.RDA   " + c_ent
cQuery += " AND    BG9_CODIGO = T.GRUPO_EMPRESA   " + c_ent
cQuery += " AND    BI3_CODIGO = T.COD_PLANO  " + c_ent
cQuery += " AND    TE.D_E_L_E_T_ = ' '  " + c_ent
cQuery += " AND    BAU.D_E_L_E_T_ = ' '   " + c_ent
cQuery += " AND    BG9.D_E_L_E_T_ = ' '  " + c_ent
cQuery += " AND    BI3.D_E_L_E_T_ = ' '   " + c_ent
cQuery += " GROUP BY MES_ANO_REF,   " + c_ent
cQuery += "          RDA ,   " + c_ent
cQuery += "          NVL(TRIM(BAU_NFANTA),TRIM(BAU_NOME)) ,  " + c_ent
cQuery += "          BAU_TIPPRE ,  " + c_ent
cQuery += "          BG9_CODIGO ,  " + c_ent
cQuery += "          BG9_NREDUZ ,  " + c_ent
cQuery += "          BI3_CODIGO ,  " + c_ent
cQuery += "          BI3_NREDUZ ,  " + c_ent
cQuery += "          BI3_SUSEP  " + c_ent 
cQuery += "  ORDER BY 1,4,3,6,8 " + c_ent

//memowrite("C:\TEMP\sql270.sql",cQuery)      
                                                 
If Select("R270") > 0
	dbSelectArea("R270")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R270",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R270->(Eof())
	nSucesso := 0
	aCabec := {"MES_ANO_REF","RDA","NOMERDA","CLASSE_REDE","CODEMP","NOMEEMP","CODPLANO",;
	           "NOMEPLANO","REGANS","CUSTO_CONSULTAS","CUSTO_EXAMES","CUSTO_EXAMESESP",;
	           "CUSTO_TERAPIAS","CUSTO_OAA","CUSTO_DDA","CUSTO_INTERNACAO","CUSTO_ODONTOLOGIA"} 

	R270->(DbGoTop())
	While ! R270->(Eof()) 
		IncProc()		
		aaDD(aDados,{R270->MES_ANO_REF,R270->RDA,R270->NOMERDA,R270->CLASSE_REDE,R270->CODEMP,R270->NOMEEMP,R270->CODPLANO,;
		             R270->NOMEPLANO,R270->REGANS,R270->CUSTO_CONSULTAS,R270->CUSTO_EXAMES,R270->CUSTO_ESPEXAMES,;
					 R270->CUSTO_TERAPIAS,R270->CUSTO_OAA,R270->CUSTO_DDA,R270->CUSTO_INTERNACAO,R270->CUSTO_ODONTOLOGIA})  		
		R270->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

EndIf	

If Select("R270") > 0
	dbSelectArea("R270")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help

/*
emp    c 1 mv_par01
codemp c 4 mv_par02
codpla c 4 mv_par03
REFDE  D 8 mv_par04
REFATE D 8 mv_par05
*/

Return	