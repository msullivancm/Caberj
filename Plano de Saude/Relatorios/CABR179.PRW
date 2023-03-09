#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR179      บAutor  ?SERGIO CUNHA       ?Data ?ABR/2015    บฑ?
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ? GERA PLANILHA DE REEMBOLSO  								 บฑ?
ฑฑ?         ? 		                                                     บฑ?
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ?Projeto CABERJ                                                บฑ?
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR179()

Processa({||PPCABR179()},'Processando...')

Return

Static Function PPCABR179

Local aSaveArea	:= {}

Local aCabec := {}
Local aDados := {}
Local dData1 := CTOD("  /  /  ")
Local dData2 := CTOD("  / /   ")
Local nI 	  := 0
Local c_Matric := ' '
Local c_Cc := ' '
Local c_CcDesc := ' '
Local nHandle := 0

Private cPerg := "PCABR179"

AjustaSX1(cPerg)
                                                
If Pergunte(cPerg,.T.)
	dDatAux := MonthSub(mv_par01,23)
	dData1 := DtoS(Mv_Par01)
	dData2 := DtoS(Mv_Par02)
else
	Return
EndIf

/*Monta query */

cQuery :=" SELECT TO_CHAR(TO_DATE(TRIM(ZZQ.ZZQ_DATDIG),'YYYYMMDD'),'DD/MM/YYYY') DAT_PROTOCOLO,														" +c_ent
cQuery +=" ZZQ.ZZQ_SEQUEN PROTOCOLO,																												" +c_ent
cQuery +=" SIGA.FORMATA_MATRICULA_MS(BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO) MATRICULA, 					" +c_ent
cQuery +=" TRIM(BA1.BA1_NOMUSR) NOME,																												" +c_ent
cQuery +=" RETORNA_DESC_PLANO_MS('"+iif(cEmpAnt == '01', 'C', 'I')+"',BA1.BA1_CODINT,BA1.BA1_CODEMP,BA1.BA1_MATRIC,BA1.BA1_TIPREG) NOME_PLANO,		" +c_ent
cQuery +=" EXIBE_MOEDA (ZZQ.ZZQ_VLRTOT) VAL_PROTOCOLADO,																							" +c_ent
cQuery +=" ZZQ.ZZQ_USRDIG DIGITADOR,																												" +c_ent
cQuery += "		 (SELECT TRIM(PCA_DESCRI) FROM PCA010 PCA WHERE PCA_FILIAL = ' ' AND PCA.D_E_L_E_T_ = ' ' AND PCA_COD = ZZQ_XWEB) PORTA_ENTRADA,	" +c_ent 
cQuery +=" CASE WHEN ZZQ_TPSOL= '1' THEN 'SOL.REEMBOLSO'																							" +c_ent
cQuery +=" ELSE 'SOL.ESPECIAL'																														" +c_ent
cQuery +=" END TIPO_SOLICITA,																														" +c_ent
cQuery +=" (SELECT TRIM(PCB_DESCRI)  FROM "+RetSqlName('PCB') +" PCB																				" +c_ent
cQuery +=" WHERE D_E_L_E_T_ = ' '																													" +c_ent
cQuery +=" AND PCB_COD = ZZQ_CANAL)CANAL,																											" +c_ent
cQuery +=" BOW_XRESPO ANALISTA 																														" +c_ent
cQuery +=" FROM "+RetSqlName('ZZQ') +" ZZQ 																											" +c_ent
cQuery +="      INNER JOIN "+RetSqlName('BA1') +" BA1 ON (BA1_FILIAL = ZZQ_FILIAL AND BA1.D_E_L_E_T_=' ' AND BA1_CODINT = ZZQ_CODINT				" +c_ent
cQuery +="      								AND BA1_CODEMP = ZZQ_CODEMP AND BA1_MATRIC = ZZQ_MATRIC AND BA1_TIPREG = ZZQ_TIPREG)				" +c_ent
cQuery +="      LEFT JOIN "+RetSqlName('BOW') +" BOW ON ( BOW.D_E_L_E_T_ = ' ' AND BOW_FILIAL = ZZQ_FILIAL AND BOW_PROTOC = ZZQ_XNUMPA )			" +c_ent
cQuery +=" WHERE ZZQ.ZZQ_FILIAL = ' '																												" +c_ent
cQuery +=" AND ZZQ.D_E_L_E_T_ = ' ' 																												" +c_ent
cQuery +=" AND ZZQ.ZZQ_STATUS <> '2' 																												" +c_ent        
cQuery +=" AND ZZQ.ZZQ_TIPPRO <> '4' 																												" +c_ent
cQuery +=" AND ZZQ.ZZQ_DATDIG BETWEEN '"+DData1+"' and '"+DData2+"'																					" +c_ent
cQuery +=" AND ZZQ.ZZQ_STATUS<>'3'																													" +c_ent
cQuery +=" UNION 																																	" +c_ent
cQuery +=" SELECT  TO_CHAR(TO_DATE(TRIM(ZZQ.ZZQ_DATDIG),'YYYYMMDD'),'DD/MM/YYYY') DAT_PROTOCOLO,													" +c_ent
cQuery +=" TRIM(B44.B44_YCDPTC) PROTOCOLO , 																										" +c_ent
cQuery +=" SIGA.FORMATA_MATRICULA_MS(BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO) MATRICULA, 					" +c_ent
cQuery +=" TRIM(BA1.BA1_NOMUSR) NOME,																												" +c_ent
cQuery +=" RETORNA_DESC_PLANO_MS('"+iif(cEmpAnt == '01', 'C', 'I')+"',BA1.BA1_CODINT,BA1.BA1_CODEMP,BA1.BA1_MATRIC,BA1.BA1_TIPREG) NOME_PLANO,		" +c_ent
cQuery +=" EXIBE_MOEDA (ZZQ.ZZQ_VLRTOT) VAL_PROTOCOLADO,																							" +c_ent
cQuery +=" ZZQ.ZZQ_USRDIG DIGITADOR,																												" +c_ent
cQuery +=" CASE																																		" +c_ent
/*
cQuery +=" WHEN (ZZQ_DATDIG <='20180131' AND ZZQ.ZZQ_XWEB =' ')OR  ZZQ.ZZQ_XWEB ='2' THEN 'PRESENCIAL'												" +c_ent
cQuery +=" WHEN ZZQ.ZZQ_XWEB ='1' THEN 'WEB'																										" +c_ent
cQuery +=" WHEN ZZQ.ZZQ_XWEB ='3' THEN 'TELEFONE'																									" +c_ent
cQuery +=" WHEN ZZQ.ZZQ_XWEB ='4'THEN 'CORREIOS'																									" +c_ent 
*/
cQuery +=" WHEN (ZZQ_DATDIG <='20180131' AND ZZQ.ZZQ_XWEB =' ')OR  ZZQ.ZZQ_XWEB ='000007' THEN 'PRESENCIAL'											" +c_ent
cQuery +=" WHEN ZZQ.ZZQ_XWEB ='000012' THEN 'WEB'																									" +c_ent
cQuery +=" WHEN ZZQ.ZZQ_XWEB ='000006' THEN 'TELEFONE'																								" +c_ent  
cQuery +=" WHEN ZZQ.ZZQ_XWEB ='000002' THEN 'EMAIL'																									" +c_ent
cQuery +=" WHEN ZZQ.ZZQ_XWEB ='000005'THEN 'CORREIOS'																								" +c_ent 
cQuery +=" END  PORTA_ENTRADA,																														" +c_ent
cQuery +=" CASE WHEN ZZQ_TPSOL= '1' THEN 'SOL.REEMBOLSO'																							" +c_ent
cQuery +=" ELSE 'SOL.ESPECIAL'																														" +c_ent
cQuery +=" END TIPO_SOLICITA,																														" +c_ent
cQuery +=" (SELECT TRIM(PCB_DESCRI)  FROM "+RetSqlName('PCB') +" PCB																				" +c_ent
cQuery +=" WHERE D_E_L_E_T_ = ' '																													" +c_ent
cQuery +=" AND PCB_COD = ZZQ_CANAL)CANAL,																											" +c_ent
cQuery +=" BOW_XRESPO ANALISTA 																														" +c_ent
cQuery +=" FROM "+RetSqlName('ZZQ') +" ZZQ 																											" +c_ent
cQuery +="     INNER JOIN "+RetSqlName('BA1') +" BA1 ON (BA1_FILIAL = ZZQ_FILIAL AND BA1.D_E_L_E_T_= ' ') 											" +c_ent
cQuery +="     INNER JOIN "+RetSqlName('B44') +" B44 ON (B44_FILIAL = ZZQ_FILIAL AND ZZQ_SEQUEN = B44_YCDPTC AND BA1_CODINT = B44_OPEUSR 			" +c_ent
cQuery +="      					AND BA1_CODEMP = B44_CODEMP AND BA1_MATRIC = B44_MATRIC AND BA1_TIPREG = B44_TIPREG AND B44.D_E_L_E_T_= ' ')	" +c_ent
cQuery +="     INNER JOIN "+RetSqlName('B45') +" B45 ON (B45_FILIAL = ZZQ_FILIAL AND B45_CODLDP = B44_CODLDP AND B45_CODPEG = B44_CODPEG 			" +c_ent
cQuery +="     																				AND B45_NUMAUT = B44_NUMAUT AND B45.D_E_L_E_T_= ' ') 	" +c_ent
cQuery +="     INNER JOIN "+RetSqlName('SA1') +" SA1 ON (A1_FILIAL = ZZQ_FILIAL AND SA1.D_E_L_E_T_ = ' ') 											" +c_ent
cQuery +="     INNER JOIN "+RetSqlName('SE1') +" SE1 ON (E1_FILIAL='01' AND B44_PREFIX = E1_PREFIXO AND B44_NUM = E1_NUM AND A1_COD = E1_CLIENTE 	" +c_ent
cQuery +="      																										AND SE1.D_E_L_E_T_ = ' ' ) 	" +c_ent
cQuery +="     INNER JOIN "+RetSqlName('BR8') +" BR8 ON (BR8_FILIAL = ZZQ_FILIAL AND B45_CODPAD = BR8_CODPAD AND B45_CODPRO = BR8_CODPSA 			" +c_ent
cQuery +="      																										AND BR8.D_E_L_E_T_= ' ' ) 	" +c_ent
cQuery +="      LEFT JOIN "+RetSqlName('BOW') +" BOW ON ( BOW.D_E_L_E_T_ = ' ' AND BOW_FILIAL = ZZQ_FILIAL AND BOW_PROTOC = ZZQ_XNUMPA )			" +c_ent
cQuery +=" WHERE ZZQ.ZZQ_FILIAL = ' ' 																												" +c_ent
cQuery +=" AND ZZQ.ZZQ_STATUS = '3'																													" +c_ent   
cQuery +=" AND ZZQ.ZZQ_TIPPRO <> '4' 																												" +c_ent
cQuery +=" AND ZZQ.ZZQ_DATDIG BETWEEN '"+DData1+"' and '"+DData2+"'																					" +c_ent
cQuery +=" AND ZZQ.D_E_L_E_T_= ' ' 																													" +c_ent

memowrite("C:\temp\PCABR179.sql",cQuery)

If Select("R179") > 0
	dbSelectArea("R179")
	dbCloseArea()
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R179",.T.,.T.)

For nI := 1 to 5
	IncProc('Processando...')
Next

If ! R179->(Eof())
	nSucesso := 0
	// Monta Cabecalho "Fixo"
	aCabec :=  {"DAT_PROTOCOLO","PROTOCOLO","MATRICULA","NOME","NOME_PLANO","VAL_PROTOCOLADO","DIGITADOR", "PORTA_ENTRADA","TIPO_SOLICITA","CANAL","ANALISTA"}
	
	// Nome do arquivo criado, o nome ้ composto por uma descri็ใo
	//a data e a hora da cria็ใo, para que nใo existam nomes iguais
	If !ApOleClient("MSExcel")
		cNomeArq := "C:\TEMP\Relatorio_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
		
		// criar arquivo texto vazio a partir do root path no servidor
		
		nHandle := FCREATE(cNomeArq)
		
		If nHandle > 0
			
			cMontaTxt := "DATA_PROTOCOLO ;"
			cMontaTxt += "PROTOCOLO ;"
			cMontaTxt += "MATRICULA ;"
			cMontaTxt += "NOME ;"
			cMontaTxt += "NOME_PLANO ;"
			cMontaTxt += "VAL_PROTOCOLADO ;"
			//cMontaTxt += "CC ;"
			cMontaTxt += "DIGITADOR ;"
			cMontaTxt += "PORTA_ENTRADA ;"
			cMontaTxt += "TIPO_SOLICITA ;"
			cMontaTxt += "CANAL ;"
			cMontaTxt += "ANALISTA ;"
			
			cMontaTxt += CRLF // Salto de linha para .csv (excel)
			
			FWrite(nHandle,cMontaTxt)
			
		EndIf
		
	EndIf
	
	R179->(DbGoTop())
	While ! R179->(Eof())
		
		/*
		IncProc()
		PswOrder(2)
		PswSeek(ALLTRIM(R179->DIGITADOR))
		
		aUsuario := PswRet()
		c_Matric := aUsuario [1,22]
		cQuery := "SELECT CTT.CTT_DESC01 CC" +c_ent
		cQuery += "FROM SRA010 SRA, CTT010 CTT" +c_ent
		cQuery += "WHERE TRIM(SRA.RA_CC) = TRIM(CTT.CTT_CUSTO)" +c_ent
		cQuery += "AND SRA.RA_MAT = '"+SUBSTR(c_Matric,5,10)+"'" +c_ent
		
		//PlsQuery(cQuery, "R179B")
		
		If Select(("R179B")) <> 0
		("R179B")->(DbCloseArea())
		Endif
		
		TCQuery cQuery New Alias ("R179B")
		
		dbSelectArea("R179B")
		
		("R179B")->(dbGoTop())
		
		If !R179B->(EOF())
		While !R179B->(EOF())
		*/
		AADD(aDados,{R179->DAT_PROTOCOLO,R179->PROTOCOLO,R179->MATRICULA,R179->NOME,R179->NOME_PLANO,R179->VAL_PROTOCOLADO,R179->DIGITADOR,R179->PORTA_ENTRADA,R179->TIPO_SOLICITA,R179->CANAL,IIF(R179->ANALISTA = ' ', " ",UPPER(USRFULLNAME(R179->ANALISTA)))})
		
		If !ApOleClient("MSExcel")
			
			If nHandle > 0
				
				cMontaTxt := R179->DAT_PROTOCOLO + ";"
				cMontaTxt += R179->PROTOCOLO + ";"
				cMontaTxt += R179->MATRICULA + ";"
				cMontaTxt += R179->NOME + ";"
				cMontaTxt += R179->NOME_PLANO + ";"
				cMontaTxt += R179->VAL_PROTOCOLADO + ";"
				//cMontaTxt += R179B->CC + ";"
				cMontaTxt += R179->DIGITADOR+ ";"
				
				cMontaTxt += R179->PORTA_ENTRADA+ ";"
				cMontaTxt += R179->TIPO_SOLICITA+ ";"
				cMontaTxt += R179->CANAL+ ";"
				cMontaTxt += IIF(R179->ANALISTA = ' ', ";",UPPER(USRFULLNAME(R179->ANALISTA))+ ";")
				
				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			EndIf
			
		EndIf
		
		/*
		R179B->(DbSkip())
		Enddo
		*/
		
		//Endif
		
		//R179B->(DbCloseArea())
		
		R179->(DbSkip())
		
		c_Cc := ' '
		c_CcDesc := ' '
	End
	
	_cTit := "REEMBOLSO DE " + DTOS(mv_par01) + " ATE " + DTOS(mv_par02) + " AS " + TIME()
	
	//Abre excel
	If ApOleClient("MSExcel")
		
		DlgToExcel({{"ARRAY",_cTit,aCabec,aDados}})
		
		
		
	EndIf
	If !ApOleClient("MSExcel")
		If nHandle > 0
			
			// encerra grava็ใo no arquivo
			FClose(nHandle)
			
			MsgAlert("Relatorio salvo em: "+cNomeArq)
			
		EndIf
		
	EndIf
	
EndIf

If Select("R179") > 0
	dbSelectArea("R179")
	dbCloseArea()
EndIf


*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1


Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Perํodo de:  "  ,"","","mv_ch01","D",08,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02","Perํodo at?  "  ,"","","mv_ch02","D",08,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1(cPerg,"03","Filtra por:   ","","","mv_ch03","N", 01,0,0,"C","","","","","mv_par04","Mater Aposent","","","","Todos as Cobran็a","","","Mater Empresa","","","Bol 112,175,Sisdeb","","","Emp. Itau","","","","","","","","","","","","","","","")

Return
