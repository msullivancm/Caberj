#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR190      ºAutor  ³ SERGIO CUNHA       º Data ³ JUL/2015    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  GERA PLANILHA DE AGENDA MEDICA 								 º±± 
±±º          ³  		                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Projeto CABERJ                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABR190()   
      
Processa({||PPCABR190()},'Processando...')

Return

Static Function PPCABR190

Local aSaveArea	:= {} 
Local   cOperadora		:= ""
Local   cUnidade		:= ""  
Local   cEspec			:= ""
Local   cMedico			:= ""
Local   cDet     		:= ""   
Local   cAAG            := "" 
Local   cNupre          := ""
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Acessa parametros do relatorio...                                        ³
  ³ Variaveis utilizadas para parametros                                     ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
cOpeDe   	:= mv_par01					//-- Codigo da Operadora de
cOpeAte  	:= mv_par02					//-- Codigo da Operadora Ate
cUnidaDe	:= mv_par03					//-- Codigo da Unidade de Atendimento De
cUnidaAte	:= mv_par04					//-- Codigo da Unidade de Atendimento Ate
cMedDe  	:= mv_par05					//-- Codigo Medico De
cMedAte 	:= mv_par06					//-- codigo medico Ate
cEspecDe 	:= mv_par07					//-- Especialidade de 
cEspecAte	:= mv_par08					//-- especialidade Ate
dDataDe		:= mv_par09  				//-- Periodo De
dDataAte	:= mv_Par10					//-- Periodo Ate

cNupre      := mv_Par11					//-- Nupre

Private cPerg := "PCABR190"

AjustaSX1(cPerg)

If Pergunte(cPerg,.T.)  
    dDatAux := MonthSub(mv_par01,23) 
    dData1 := DtoS(Mv_Par01)
    dData2 := DtoS(Mv_Par02)
else
    Return	
EndIf

/*Monta query */
	cSQL := "SELECT TRIM(PLS_PRA_PROJSERV_ATIVO_MS(SubStr(BBD_CODPAC,1,4),SubStr(BBD_CODPAC,5,4),
	cSQL += "			SubStr(BBD_CODPAC,9,6),
	cSQL += "			SubStr(BBD_CODPAC,15,2),'0041',BBD_DATA)) AAG " 
	cSQL += "," + BBD->(RetSQLName("BBD"))+ ".* 
	cSQL += " FROM "+BBD->(RetSQLName("BBD"))+" WHERE "
	cSQL += " BBD_FILIAL = '"+xFilial("BBD")+"' "
	cSQL += " AND D_E_L_E_T_ = ' '  AND "
	cSQL += " BBD_STATUS IN ('1','4','5','6')  AND "
	cSQL += " BBD_CODINT >= '" + cOpeDe          +"' AND BBD_CODINT <= '"+ cOpeAte   +"' AND "
	cSQL += " BBD_CODLOC >= '" + cUnidaDe        +"' AND BBD_CODLOC <= '"+ cUnidaAte +"' AND "
	cSQL += " BBD_CODIGO >= '" + cMedDe          +"' AND BBD_CODIGO <= '"+ cMedAte   +"' AND "
	cSQL += " BBD_CODESP >= '" + cEspecDe        +"' AND BBD_CODESP <= '"+ cEspecAte +"' AND "	
	cSQL += " BBD_DATA   >= '" + DTOS(dDataDe)   +"' AND BBD_DATA   <= '"+ DTOS(dDataAte)+"' "   
	/*nupre*/
	cSQL += " AND BBD_LOCAL = '" + cNupre + "' " // Nupre	
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Se houver filtro executa parse para converter expressoes adv para SQL    ³
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If ! Empty(aReturn[7])
		cSQL += " and " + PLSParSQL(aReturn[7])
	Endif 
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Define order by de acordo com a ordem...                                 ³
      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ */
	//cSQL += " ORDER BY BBD_FILIAL + BBD_CODINT + BBD_CODLOC + BBD_CODESP +  BBD_CODIGO + BBD_DATA"
	cSQL += " ORDER BY BBD_DATA + BBD_HORA"
	cSQL := PLSAvaSQL(cSQL)
	TCQUERY cSQL NEW ALIAS "BBDTrb"

memowrite("C:\PCABR190.sql",cQuery)      

If Select("R190") > 0
	dbSelectArea("R190")
	dbCloseArea()
EndIf                              

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R190",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R190->(Eof())
	nSucesso := 0
    // Monta Cabecalho "Fixo"
	aCabec :=  {"DAT_PROTOCOLO","PROTOCOLO","MATRICULA","NOME","NOME_PLANO","VAL_PROTOCOLADO","LOCAL"} 

	
	R190->(DbGoTop())
	While ! R190->(Eof()) 
		IncProc()     
		
PswOrder(2)
  PswSeek(ALLTRIM(R190->DIGITADOR)) 
  
  aUsuario := PswRet()    
	c_Matric := aUsuario [1,22]  
    cQuery := "SELECT CTT.CTT_DESC01 CC" +c_ent  
    cQuery += "FROM SRA010 SRA, CTT010 CTT" +c_ent 
	cQuery += "WHERE TRIM(SRA.RA_CC) = TRIM(CTT.CTT_CUSTO)" +c_ent 
	cQuery += "AND SRA.RA_MAT = '"+SUBSTR(c_Matric,5,10)+"'" +c_ent 
	
	//PlsQuery(cQuery, "R190B")  
	
    If Select(("R190B")) <> 0 
       ("R190B")->(DbCloseArea()) 
    Endif
  
    TCQuery cQuery New Alias ("R190B")  
    
    dbSelectArea("R190B")
   
    ("R190B")->(dbGoTop())   

	
		If !R190B->(EOF())
			While !R190B->(EOF()) 
				AADD(aDados,{R190->DAT_PROTOCOLO,R190->PROTOCOLO,R190->MATRICULA,R190->NOME,R190->NOME_PLANO,R190->VAL_PROTOCOLADO,R190B->CC,})  	
		
				R190B->(DbSkip())
			Enddo
		Endif
	R190B->(DbCloseArea())
	


	R190->(DbSkip())

	c_Cc := ' '	 
	c_CcDesc := ' '
	End


	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

EndIf	

If Select("R190") > 0
	dbSelectArea("R190")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Período de:  "  ,"","","mv_ch01","D",08,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Período até:  "  ,"","","mv_ch02","D",08,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1(cPerg,"03","Filtra por:   ","","","mv_ch03","N", 01,0,0,"C","","","","","mv_par04","Mater Aposent","","","","Todos as Cobrança","","","Mater Empresa","","","Bol 112,175,Sisdeb","","","Emp. Itau","","","","","","","","","","","","","","","")                                                                                                                                                                                           

Return	