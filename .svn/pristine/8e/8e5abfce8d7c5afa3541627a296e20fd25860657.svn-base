#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR183      บAutor  ณ SERGIO CUNHA       บ Data ณ MAI/2015    บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  RELATORIO SITUACAO ADVERSAS EXCEL 							 บฑฑ 
ฑฑบ          ณ  		                                                     บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Projeto CABERJ                                                บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR183()   
      
Processa({||PCABR183()},'Processando...')

Return

Static Function PCABR183

Local aSaveArea	:= {} 

Local aCabec := {}
Local aDados := {} 
Local dData1 := CTOD("  /  /  ")
Local dData2 := CTOD("  / /   ")
Local nI 	  := 0        
Local sCodSitu := 0  
Local sVigFi := 0

Private cPerg := "CABR183"

AjustaSX1(cPerg)

If Pergunte(cPerg,.T.)  
    sCodSitu := Mv_Par01
    dData1 := DtoS(Mv_Par02)
    dData2 := DtoS(Mv_Par03)
    sVigFi := Mv_Par04 
else
    Return	
EndIf

/*Monta query */
cQuery := "SELECT SIGA.FORMATA_MATRICULA_MS(BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO) MATRICULA, " +c_ent 
cQuery += "BA1.BA1_NOMUSR NOME," +c_ent
cQuery += "BGX.BGX_CODSAD CODIGO, " +c_ent
cQuery += "BGX.BGX_DESCRI DESCRICAO, " +c_ent
cQuery += "TRIM (BHH.BHH_OBS1)||' '||TRIM (BHH.BHH_OBS2)||' '||TRIM (BHH.BHH_OBS3)||' '||TRIM (BHH.BHH_OBS4)||' '||TRIM (BHH.BHH_OBS5)||' '||TRIM (BHH.BHH_OBS6)||' '||TRIM (BHH.BHH_OBS7) OBSERVACAO," +c_ent
cQuery += "TO_DATE(TRIM(BHH.BHH_VIGDE), 'YYYYMMDD') VIGDE," +c_ent         
cQuery += "TO_DATE(TRIM(BHH.BHH_VIGATE), 'YYYYMMDD') VIGATE" +c_ent
cQuery += "FROM "+RetSqlName('BHH') +" BHH, " +c_ent				
cQuery += "     "+RetSqlName('BA1') +" BA1, " +c_ent         
cQuery += "     "+RetSqlName('BGX') +" BGX " +c_ent               
cQuery += "WHERE BA1.D_E_L_E_T_ <> '*'" +c_ent
cQuery += "AND BHH.D_E_L_E_T_ <> '*' " +c_ent
cQuery += "AND BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG = BHH.BHH_CODINT||BHH.BHH_CODEMP||BHH.BHH_MATRIC||BHH.BHH_TIPREG " +c_ent
cQuery += "AND BGX.BGX_CODINT||BGX.BGX_CODSAD =  BHH.BHH_CODINT||BHH.BHH_CODSAD " +c_ent

If !(Empty(Mv_Par02))
	cQuery += "AND BHH.BHH_VIGDE BETWEEN '"+DData1+"' and '"+DData2+"'" +c_ent
EndIf   

If sVigFi == 1
	cQuery += "AND TRIM(BHH.BHH_VIGATE) IS NOT NULL " +c_ent
Endif
If !Empty (sCodSitu)
cQuery += "AND BHH.BHH_CODSAD = '"+sCodSitu+"' " +c_ent 
Endif

memowrite("C:\TEMP\CABR183.sql",cQuery)      

If Select("R183") > 0
	dbSelectArea("R183")
	dbCloseArea()      
	
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R183",.T.,.T.)         

For nI := 1 to 5
	IncProc('Processando...')
Next 

If R183->(Eof())
    
 	Alert ("Nใo existem informa็๕es a serem exibidas")	    
    	
EndIf  

If ! R183->(Eof())
	nSucesso := 0  
	
    // Monta Cabecalho "Fixo"
	aCabec := {"MATRICULA","NOME","CODIGO","DESCRICAO","OBSERVACAO","VIGDE","VIGATE"} 

	
	R183->(DbGoTop())
	While ! R183->(Eof()) 
		IncProc()
		
		AADD(aDados,{R183->MATRICULA,R183->NOME,R183->CODIGO,R183->DESCRICAO,R183->OBSERVACAO,R183->VIGDE,R183->VIGATE})  
		
		R183->(DbSkip())
	End
	 
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})

EndIf	

If Select("R183") > 0
	dbSelectArea("R183")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************

Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Situacao Adversas:  "  	,"","","mv_ch01","C",03,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Perํodo de:  "  			,"","","mv_ch02","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03","Perํodo at้:  "  		,"","","mv_ch03","D",08,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04","Encerrados:  "  			,"","","mv_ch04","C",01,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
//PutSX1(cPerg,"08","Considera Grupo de 	"	,"","","mv_ch08","N",01,0,1,"G","","","","","mv_par08","Sim"	,"","","","Nao"  		,"","","" 			,"","",""				,"","","","","",aHelp,aHelp,aHelp)

Return	