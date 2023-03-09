#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR164      บAutor  ณ SERGIO CUNHA       บ Data ณ NOV/2014    บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  GERA PLANILHA DE INTERNACOES								 บฑฑ 
ฑฑบ          ณ  		                                                     บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Projeto CABERJ                                                บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR164()   
      
Processa({||PCABR164()},'Processando...')

Return

Static Function PCABR164

Local aSaveArea	:= {} 

Local aCabec := {}
Local aDados := {} 
Local dData1 := CTOD("  /  /  ")
Local dData2 := CTOD("  / /   ")
Local nI 	  := 0   

Private cPerg := "CABR164"

AjustaSX1(cPerg)

If Pergunte(cPerg,.T.)  
    dDatAux := MonthSub(mv_par01,23) 
    dData1 := DtoS(Mv_Par01)
    dData2 := DtoS(Mv_Par02)
else
    Return	
EndIf

/*Monta query */

cQuery := "SELECT BE4_CODOPE||'.'||BE4_CODEMP||'.'||BE4_MATRIC||'-'||BE4_TIPREG||'-'||BE4_DIGITO MATRICULA, " +c_ent
cQuery += "      Trim(BA1_NOMUSR) NOME," +c_ent
cQuery += "        (BI3_NREDUZ)  NOME_PLANO," +c_ent
cQuery += "        BA1.BA1_CODEMP CODIGO_EMPRESA," +c_ent
cQuery += "        BG9_DESCRI DESC_EMPRESA," +c_ent       
If cEmpAnt == '01'
	cQuery += "          (CASE WHEN obter_custo_gr (BE4_SENHA,BE4_DATPRO,' ')= 0" +c_ent
	cQuery += "               THEN 'UTI'" +c_ent
	cQuery += "             WHEN obter_custo_gr (BE4_SENHA,BE4_DATPRO,' ')= 1" +c_ent
	cQuery += "               THEN 'APARTAMENTO'" +c_ent
	cQuery += "             WHEN obter_custo_gr (BE4_SENHA,BE4_DATPRO,' ') = 2" +c_ent
	cQuery += "               THEN 'COLETIVO'" +c_ent
	cQuery += "             WHEN obter_custo_gr (BE4_SENHA,BE4_DATPRO,' ') = 3" +c_ent
	cQuery += "               THEN 'DAY CLINIC'" +c_ent
	cQuery += "             ELSE 'APARTAMENTO'" +c_ent
	cQuery += "        END) ACOMODACAO_REAL," +c_ent
Else  
	cQuery += "          (CASE WHEN obter_custo_gr_int (BE4_SENHA,BE4_DATPRO,' ')= 0" +c_ent
	cQuery += "               THEN 'UTI'" +c_ent
	cQuery += "             WHEN obter_custo_gr_int (BE4_SENHA,BE4_DATPRO,' ')= 1" +c_ent
	cQuery += "               THEN 'APARTAMENTO'" +c_ent
	cQuery += "             WHEN obter_custo_gr_int (BE4_SENHA,BE4_DATPRO,' ') = 2" +c_ent
	cQuery += "               THEN 'COLETIVO'" +c_ent
	cQuery += "             WHEN obter_custo_gr_int (BE4_SENHA,BE4_DATPRO,' ') = 3" +c_ent
	cQuery += "               THEN 'DAY CLINIC'" +c_ent
	cQuery += "             ELSE 'APARTAMENTO'" +c_ent
	cQuery += "        END) ACOMODACAO_REAL," +c_ent
Endif
cQuery += "       Trim(BE4_DATPRO) DT_INTER," +c_ent
cQuery += "       Decode(BE4_GRPINT,'1','INT CLINICA','2','INT CIRURGICA','3','INT OBSTETRICA','4','INT PEDIATRICA','5','INT PSIQUIATRICA') TRATAMENTO " +c_ent
cQuery += "FROM "+RetSqlName('BE4') +" BE4, " +c_ent				
cQuery += "     "+RetSqlName('BA1') +" BA1, " +c_ent         
cQuery += "     "+RetSqlName('BI4') +" BI4, " +c_ent
cQuery += "     "+RetSqlName('BAU') +" BAU, " +c_ent
cQuery += "     "+RetSqlName('BID') +" BID, " +c_ent   
cQuery += "     "+RetSqlName('BI3') +" BI3, " +c_ent
cQuery += "     "+RetSqlName('BTS') +" BTS, " +c_ent
cQuery += "     "+RetSqlName('BQR') +" BQR, " +c_ent
cQuery += "     "+RetSqlName('BG9') +" BG9  " +c_ent
cQuery += "WHERE BE4_DATPRO BETWEEN '"+DData1+"' and '"+DData2+"'" +c_ent   
cQuery += "		 AND BE4.BE4_FILIAL=  '" +xFilial('BE4')+"'" + c_ent
cQuery += "		 AND BA1.BA1_FILIAL=  '" +xFilial('BA1')+"'" + c_ent
cQuery += "		 AND BI4.BI4_FILIAL=  '" +xFilial('BI4')+"'" + c_ent
cQuery += "		 AND BAU.BAU_FILIAL=  '" +xFilial('BAU')+"'" + c_ent
cQuery += "		 AND BID.BID_FILIAL=  '" +xFilial('BID')+"'" + c_ent
cQuery += "		 AND BI3.BI3_FILIAL=  '" +xFilial('BI3')+"'" + c_ent
cQuery += "		 AND BTS.BTS_FILIAL=  '" +xFilial('BTS')+"'" + c_ent
cQuery += "		 AND BQR.BQR_FILIAL=  '" +xFilial('BQR')+"'" + c_ent
cQuery += "		 AND BG9.BG9_FILIAL=  '" +xFilial('BG9')+"'" + c_ent
cQuery += "      AND BE4.D_E_L_E_T_<> '*'" +c_ent
cQuery += "      AND BA1.D_E_L_E_T_<> '*'" +c_ent
cQuery += "      AND BAU.D_E_L_E_T_<> '*'" +c_ent
cQuery += "      AND BID.D_E_L_E_T_<> '*'" +c_ent
cQuery += "      AND BTS.D_E_L_E_T_<> '*'" +c_ent
cQuery += "      AND BI3.D_E_L_E_T_<> '*'" +c_ent
cQuery += "      and BE4.D_E_L_E_T_<> '*'" +c_ent
cQuery += "      and BQR.D_E_L_E_T_<> '*'" +c_ent
cQuery += "      and BG9.D_E_L_E_T_<> '*'  " +c_ent
cQuery += "      and BAU_CODIGO<>'095907'" +c_ent
cQuery += "      AND BE4_SITUAC<>'2'" +c_ent
cQuery += "      and BE4_REGINT<>'2'" +c_ent
cQuery += "      AND  BE4_CODEMP   = BA1.BA1_CODEMP" +c_ent
cQuery += "      AND  BE4_MATRIC   = BA1.BA1_MATRIC" +c_ent
cQuery += "      AND  BE4_TIPREG   = BA1.BA1_TIPREG" +c_ent
cQuery += "      AND  BE4_DIGITO   = BA1.BA1_DIGITO" +c_ent
cQuery += "      AND  BI4_CODACO   = BE4_PADINT" +c_ent
cQuery += "      AND  BE4_GRPINT   = BQR_GRPINT" +c_ent
cQuery += "      AND  BE4_TIPINT   = BQR_TIPINT" +c_ent
cQuery += "      AND  BE4_CODRDA   = BAU_CODIGO" +c_ent
cQuery += "      AND  BAU_MUN      = BID_CODMUN" +c_ent
cQuery += "      AND BI3_CODIGO    = BA1.BA1_CODPLA" +c_ent
cQuery += "      AND BA1.BA1_MATVID = BTS_MATVID" +c_ent
cQuery += "      AND BA1.BA1_CODINT = BG9.BG9_CODINT" +c_ent
cQuery += "      AND BA1.BA1_CODEMP = BG9.BG9_CODIGO" +c_ent


memowrite("C:\cabr164.sql",cQuery)      

If Select("R164") > 0
	dbSelectArea("R164")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R164",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R164->(Eof())
	nSucesso := 0
    // Monta Cabecalho "Fixo"
	aCabec := {"MATRICULA","NOME","NOME_PLANO","CODIGO_EMPRESA","DESC_EMPRESA","ACOMODACAO_REAL","DT_INTER","TRATAMENTO"} 

	
	R164->(DbGoTop())
	While ! R164->(Eof()) 
		IncProc()
		
		AADD(aDados,{R164->MATRICULA,R164->NOME,R164->NOME_PLANO,R164->CODIGO_EMPRESA,R164->DESC_EMPRESA,R164->ACOMODACAO_REAL,STOD(R164->DT_INTER),R164->TRATAMENTO,;
		             })  
		
		R164->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

EndIf	

If Select("R164") > 0
	dbSelectArea("R164")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Perํodo de:  "  ,"","","mv_ch01","D",08,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Perํodo at้:  "  ,"","","mv_ch02","D",08,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1(cPerg,"03","Filtra por:   ","","","mv_ch03","N", 01,0,0,"C","","","","","mv_par04","Mater Aposent","","","","Todos as Cobran็a","","","Mater Empresa","","","Bol 112,175,Sisdeb","","","Emp. Itau","","","","","","","","","","","","","","","")                                                                                                                                                                                           

Return	