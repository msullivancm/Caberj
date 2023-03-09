#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR209      บAutor  ณ SERGIO CUNHA       บ Data ณ NOV/2014    บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  RELATORIO ANALISTA X RDA									 บฑฑ 
ฑฑบ          ณ  		                                                     บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Projeto CABERJ                                                บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR209()   
      
Processa({||PCABR209()},'Processando...')

Return

Static Function PCABR209

Local aSaveArea	:= {} 

Local aCabec := {}
Local aDados := {} 
Local nI 	  := 0 
Local c_MesIni := 0  
Local c_AnoIni := 0   
Local c_MesFim := 0    
Local c_AnoFim := 0 
Local c_TpAna  := 0   
Local c_StAtiv := 0  
Local c_CodAna := 0
Local c_RdaIni := 0 
Local c_RdaFim := 0  
Local c_RdaVin:= 0  



Private cPerg := "CABR209"

AjustaSX1(cPerg)

If Pergunte(cPerg,.T.)  
    c_MesIni := ALLTRIM(Mv_Par01)
   	c_AnoIni := ALLTRIM(Mv_Par02)   
   	c_MesFim := ALLTRIM(Mv_Par03)
   	c_AnoFim := ALLTRIM(Mv_Par04)
   	c_TpAna  := Mv_Par05
   	c_StAtiv := Mv_Par06
	c_CodAna := ALLTRIM(Mv_Par07)      
	c_RdaIni := ALLTRIM(Mv_Par08)
	c_RdaFim := ALLTRIM(Mv_Par09)   
	c_RdaVin := Mv_Par10
else
    Return	
EndIf
/*Monta query */
cQuery := " SELECT ZN_CODRDA RDA," +c_ent
cQuery += "UPPER(BAU_NOME) RDA_NOME," +c_ent
cQuery += "ZN_CODANA COD_ANALISTA," +c_ent
cQuery += "UPPER(ZN_NOMANA) ANALISTA," +c_ent
cQuery += "ZN_VIGINI VIG_INICIAL," +c_ent
cQuery += "ZN_VIGFIM VIG_FINAL,"  +c_ent
cQuery += "CASE"  +c_ent
cQuery += "WHEN ZN_TIPOAN = '1' THEN 'GEARI' "+c_ent
cQuery += "ELSE 'GERED' END SETOR," +c_ent
cQuery += "CASE"  +c_ent
cQuery += "WHEN ZN_ATIVO='0' THEN 'ATIVO' "+c_ent
cQuery += "ELSE 'INATIVO' END SITUACAO" +c_ent

cQuery += " FROM "+RetSqlName('BAU') +" BAU LEFT JOIN SZN010 SZN ON ZN_CODRDA = BAU_CODIGO " +c_ent
                                   cQuery += "   AND SZN.D_E_L_E_T_ <> '*'" +c_ent
                                   cQuery += "   AND ZN_TIPOAN = '1'" +c_ent      
                             		If c_TpAna = 1   //TIPO ANALISTA 1= GEARI / 2= GERED
										cQuery += "AND ZN_TIPOAN = '1'" +c_ent
									EndIf
									If c_TpAna = 2
										cQuery += "AND ZN_TIPOAN = '2'" +c_ent
									EndIf
									If c_TpAna = 3
										cQuery += "AND ZN_TIPOAN <> ' '" +c_ent
									EndIf
									If c_StAtiv = 1   //Status 0 = Ativo / 1 = Inativo
										cQuery += "AND ZN_ATIVO = '0'" +c_ent
									EndIf
									If c_StAtiv = 2
										cQuery += "AND ZN_ATIVO = '1'" +c_ent
									EndIf
									If c_StAtiv = 3
										cQuery += "AND ZN_ATIVO <> ' '" +c_ent
									EndIf
									If !Empty(c_CodAna)
										cQuery += "AND ZN_CODANA = '"+c_CodAna+"'" +c_ent
									EndIf
									If !Empty(c_RdaIni) .and. !Empty(c_RdaFim)
										cQuery += "AND ZN_CODRDA BETWEEN '"+c_RdaIni+"' AND '"+c_RdaFim+"'" +c_ent
									Else
										cQuery += "AND ZN_CODRDA  <> ' '" +c_ent
									EndIf
									cQuery += "AND SUBSTR(ZN_VIGINI,3,6)||SUBSTR(ZN_VIGINI,1,2) BETWEEN '"+c_AnoIni+c_MesIni+"'  AND '"+c_AnoFim+c_MesFim+"'" +c_ent
                              
cQuery += "WHERE " +c_ent

cQuery += " BAU.D_E_L_E_T_ <> '*'" +c_ent     


If 	c_RdaVin = 1   // 1 = SEM VINCULO , 2 =COM VINCULO,
	cQuery += "AND ZN_CODRDA IS NULL " +c_ent 
EndIf
If 	c_RdaVin = 2
	cQuery += "AND ZN_CODRDA IS NOT NULL " +c_ent 
EndIf     
If 	c_RdaVin = 3
	cQuery += "AND (ZN_CODRDA IS NULL OR ZN_CODRDA IS NOT NULL)" +c_ent
EndIf

cQuery += "ORDER BY ZN_CODINT,SZN.ZN_CODRDA,ZN_CODANA,ZN_VIGINI,ZN_VIGFIM" +c_ent

memowrite("C:\temp\CABR209.sql",cQuery)
 
If Select("R209") > 0
	dbSelectArea("R209")
	dbCloseArea() 
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R209",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R209->(Eof()) 

	nSucesso := 0
    // Monta Cabecalho "Fixo"
	aCabec := {"RDA","RDA_NOME","COD_ANALISTA","ANALISTA","VIG_INICIAL","VIG_FINAL","SETOR","SITUACAO"} 

	
	R209->(DbGoTop())
	While ! R209->(Eof()) 
		IncProc()
		
		AADD(aDados,{iIf(!Empty(R209->RDA),"'"+R209->RDA,' '),; 
					 R209->RDA_NOME,;  
					 iIf(!Empty(R209->COD_ANALISTA),"'"+R209->COD_ANALISTA,' '),; 
		             R209->ANALISTA,;    
		             iIf(!Empty(R209->VIG_INICIAL),"'"+R209->VIG_INICIAL,' '),; 
		             iIf(!Empty(R209->VIG_FINAL),"'"+R209->VIG_FINAL,' '),;   
		             R209->SETOR,;
		             R209->SITUACAO;
		             })  
		
		R209->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY","RELATORIO ANALISTA X RDA " ,aCabec,aDados}})
Else
	MsgAlert( "Por favor verifique os parametros e tente novamente", "Aviso" )
EndIf	

If Select("R209") > 0
	dbSelectArea("R209")
	dbCloseArea()
EndIf      

*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1


Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","M๊s de:   "  ,"","","mv_ch01","C",02,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Ano de:  "  ,"","","mv_ch02","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03","M๊s At้:"  ,"","","mv_ch03","C",02,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04","Ano At้: "  ,"","","mv_ch04","C",04,0,0,"C","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05","Setor:   "  ,"","","mv_ch05","N",01,0,0,"C","","","","","mv_par05","Geari","","","","Gered ","","","Ambos ","","","","","","","","", "", "", "" )                                    
PutSx1(cPerg,"06","Ativo:   "  ,"","","mv_ch06","N",01,0,0,"C","","","","","mv_par06","Sim ","","","","Nใo ","","","Ambos ","","","","","","","","", "", "", "" )                                    
PutSx1(cPerg,"07","Cod. Analista: "  ,"","","mv_ch07","C",06,0,0,"C","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"08","Cod. RDA de: "  ,"","","mv_ch08","C",06,0,0,"C","","","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"09","Cod. RDA At้: "  ,"","","mv_ch09","C",06,0,0,"C","","","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})       
PutSx1(cPerg,"10","RDA sem vinculo   "  ,"","","mv_ch10","N",01,0,0,"C","","","","","mv_par10","Sim ","","","","Nใo ","","","Ambos ","","","","","","","","", "", "", "" )                                    

Return
