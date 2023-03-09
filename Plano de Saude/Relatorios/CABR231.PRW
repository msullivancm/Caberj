#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*                                        

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR155      บAutor  ณ Marcela Coimbra    บ Data ณ 28/08/2015  บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Planilha de titulos em aberto                                บฑฑ 
ฑฑบ          ณ  		                                                     บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Projeto CABERJ                                                บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ'ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR231()   
      
Processa({||PCABR231()},'Processando...')

Return

Static Function PCABR231()
	
	Local aSaveArea	:= {} 
	
	Local aCabec := {}
	Local aDados := {}   
	Local cTipoPes := {}
	Local cCodEmp1 := {}
	Local cCodEmp2 := {}  
	Local cSubCon1 := {} 
	Local cSubCon2 := {} 
	Local cConEmp1 := {} 
	Local cConEmp2 := {} 
	Local cVencto1 := CTOD("  /  /  ")
	Local cVencto2 := CTOD("  /  /  ")
	Local nI 	  := 0   
	
	Private cPerg := "CABR231"
	Private cQuery:= ""
	 
	AjustaSX1(cPerg)
		
	If Pergunte(cPerg,.T.)  
	
		c_Empresa	:= Mv_Par01  
	   
	else
	
	    Return	
	
	EndIf   
	
	cQuery := " Select distinct ba1_codint||ba1_codemp||ba1_matric||ba1_tipreg matricula, "
	cQuery += "       ba1_nomusr nome, "
	cQuery += "      ba1_cpfusr cpf,  "
	cQuery += "      RETORNA_DESC_PLANO_MS('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) plano, "
	cQuery += "      e1_prefixo prefixo, "
	cQuery += "      e1_num numero, "
	cQuery += "      e1_cliente cliente, "
	cQuery += "       to_date(trim(BA1_DATBLO), 'YYYYMMDD') DATBLO, "
	cQuery += "      to_date(e1_emissao, 'YYYYMMDD') emissao, "
	cQuery += "      to_date(e1_vencrea, 'YYYYMMDD') vencimento, "
	cQuery += "      e1_anoBASE ano, "
	cQuery += "      e1_mesbase mes, "
	cQuery += "      e1_valor valor, "
	cQuery += "      e1_saldo  saldo"
	cQuery += " from ba3010 inner join ba1010 on ba1_filial = ' ' and ba1_codint = ba3_codint and ba1_codemp = ba3_codemp and ba1_matric = ba3_matric "
	cQuery += "            inner join se1010 on e1_filial = '01' and e1_cliente = ba3_codcli "
	cQuery += " where ba3_filial = ' ' "
	cQuery += " and ba3_codint = '0001' "
	cQuery += " and ba3_codemp = '" + c_Empresa + "' "
	cQuery += " and e1_tipo    = 'RA' "
	cQuery += " and e1_saldo   <> 0  "
	cQuery += " and BA3010.D_E_L_E_T_ = ' ' "
	cQuery += " and BA1010.D_E_L_E_T_ = ' ' "
	cQuery += " and se1010.D_E_L_E_T_ = ' ' "
	cQuery += " and ba1_tipreg = '00' "           
	cQuery += " order by 7"  "
	
	//cQuery += "   AND BA1.BA1_NOMUSR LIKE ('%ARLETTE CASTANHEIRA DE ALENCAR%')
	
  	cQuery := ChangeQuery( cQuery )
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"R231",.T.,.T.)         

	// Monta Cabecalho "Fixo"
	aCabec := {"MATRICULA", ;
						 "NOME",;
						 "CPF",;
						 "PLANO",; 
						 "PREFIXO",;
						 "NUMERO",;
						 "CLIENTE",;
						 "EMISSAO",;
						 "VENCIMENTO",;
						 "ANO",;
						 "MES",;
						 "VALOR",;
						 "SALDO",;						 
						 "VALOR"}
			
		While ! R231->(Eof()) 
			IncProc()
			
			AADD(aDados,{"'"+R231->MATRICULA, ;
						 R231->NOME,;
						 "'"+R231->cpf,;
						 R231->plano,; 
						 R231->prefixo,;
						 "'"+R231->numero,;
						 "'"+R231->cliente,;
						 R231->emissao,;
						 R231->vencimento,;
						 "'"+R231->ano,;
						 "'"+R231->mes,;
						 R231->valor,;
						 R231->SALDO})  
			
			R231->(DbSkip())       
			
		EndDo

	aAdd(aDados ,{"Fim"} )
	//Abre excel 
    DlgToExcel({{"ARRAY"," " ,aCabec,aDados}})
If Select("R231") > 0
	dbSelectArea("R231")
	dbCloseArea()
EndIf      

 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help

PutSx1(cPerg,"01","Empresa:  "  ,"","","mv_ch01","C",04,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})

Return	