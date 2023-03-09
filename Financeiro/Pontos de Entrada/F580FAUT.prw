#INCLUDE "rwmake.ch"
#include "topconn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ F580FAUT บ Autor ณ  Vitor Sbano       บ Data ณ  31/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ 1 - Estabelece Filtro em rotina FINA580 - Liberacao para   บฑฑ
ฑฑบ          ณ     Baixa - nao permite a Liberacao Automatica de Titulos  บฑฑ
ฑฑบ          ณ     com E2_YLIBPLS = ' '                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ 2 - Procede Liberacao de Titulos (E2_DATALIB)              บฑฑ
ฑฑบ          ณ     conforme parametros da rotina Automแtica               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 10 - SIGAFIN - FINA580                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
//
//	Atualizacao:	05/02/13	- Vitor Sbano	- proceder a liberacao de Titulos de retencao (E2_TIPO = TX, ISS, INS)
//												 e Prefixo como RLE e UNI
//
/*/

User Function F580FAUT
//
Local 	cQueryE2    :=" "
Local 	cQueryE3    :=" "
Local 	cArqTmp		:= GetNextAlias()   
Local 	cArqTmp3	:= GetNextAlias()
//
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//    
_cFilRet	:=	ParamIxb[1]
//    
// Fase 1 - Liberacao de Titulos com associa็ใo ao Cadastro de Fornecedor com o campo de Bloqueio Financeiro (A2_XBLQFIN) diferente de 1 - Sim
//  
// Parametros 	1  - Do Fornecedor
//			2  -  Ate Fornecedor
//			3  - Do Portador
//			4  - Ate Portador
//			5  - Do Vencimento
//			6  - Ate Vencimento
//			7  - Do Valor
//			8  - Ate o Valor
//			9  - Do Tipo
//			10 - Ate o Tipo
//   
cQueryE2 := " SELECT R_E_C_N_O_ FROM ( "
/*cQueryE2 += " SELECT SE2.R_E_C_N_O_ R_E_C_N_O_ FROM "+RetSqlName("SE2")+" SE2, "+RetSqlName("SA2")+" SA2"
  cQueryE2 += " WHERE SE2.D_E_L_E_T_ =' ' "
  cQueryE2 += " AND SA2.D_E_L_E_T_ =' ' "
  cQueryE2 += " AND SA2.A2_COD  = SE2.E2_FORNECE "
  cQueryE2 += " AND SA2.A2_LOJA = SE2.E2_LOJA " 
  cQueryE2 += " AND SE2.E2_DATALIB = ' ' "
  cQueryE2 += " AND SA2.A2_XBLQFIN <> '1' " 
  cQueryE2 += " AND SE2.E2_YLIBPLS<> ' ' "         
  cQueryE2 += " AND SA2.A2_YBLQPLS = 'N'"
  cQueryE2 += " AND SE2.E2_FORNECE BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
  cQueryE2 += " AND SE2.E2_PORTADO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
  cQueryE2 += " AND SE2.E2_VENCTO BETWEEN '"+dtos(MV_PAR05)+"' AND '"+dtos(MV_PAR06)+"'"
  cQueryE2 += " AND SE2.E2_VALOR BETWEEN "+ALLTRIM(STR(mv_par07,17,2))+" AND "+ALLTRIM(STR(mv_par08,17,2))+" "
  cQueryE2 += " AND SE2.E2_TIPO BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"'"
  cQueryE2 += " UNION ALL " */
cQueryE2 += " SELECT SE21.R_E_C_N_O_ R_E_C_N_O_ FROM "+RetSqlName("SE2")+" SE21 " 
cQueryE2 += " WHERE SE21.D_E_L_E_T_ =' ' "
cQueryE2 += " AND SE21.E2_DATALIB = ' ' "
cQueryE2 += " AND SE21.E2_VENCREA  BETWEEN '"+dtos(MV_PAR05)+"' AND '"+dtos(MV_PAR06)+"' "
//cQueryE2 += " AND ( SE21.E2_PREFIXO IN ('RLE','UNI') OR  SE21.E2_TIPO IN ('ISS','INS','TX') 
//altamiro 240413        
//A2_YBLQPLS = 'N'                                                                   
cQueryE2 += " and Trim(e2_prefixo)||Trim(e2_tipo)|| Trim(e2_origem)  NOT IN   ('AEDFTPLSMPAG' ,'CLIFTPLSMPAG' ,'CONFTPLSMPAG' ,'HOSFTPLSMPAG' ,'INTFTPLSMPAG' , "
cQueryE2 += "'LABFTPLSMPAG' ,'MEDFTPLSMPAG' ,'NFENFMATA100' ,'NUPFTPLSMPAG' ,'ODNFTPLSMPAG' ,'OPEFTPLSMPAG' ,'REMFTPLSMPAG' ,'SVDFTPLSMPAG' ,'UINNFMATA100') "
// fim 
cQueryE2 += " ) QRY ORDER BY R_E_C_N_O_ "
// 
//memowrite("C:\TMP\F580AUT.TXT",cQueryE2)
If Select(cArqTmp) > 0
	dbSelectArea(cArqTmp)
	dbCloseArea()
EndIf
DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQueryE2), cArqTmp, .F., .T.)
dbSelectArea(cArqTmp)
dbGoTop()
ProcRegua((cArqTmp)->(RecCount()))
//                                  
  cQueryE3 := " SELECT SE2.R_E_C_N_O_ R_E_C_N_O_ FROM "+RetSqlName("SE2")+" SE2, "+RetSqlName("SA2")+" SA2"
  cQueryE3 += " WHERE SE2.D_E_L_E_T_ =' ' "
  cQueryE3 += " AND SA2.D_E_L_E_T_ =' ' "
  cQueryE3 += " AND SA2.A2_COD  = SE2.E2_FORNECE "
  cQueryE3 += " AND SA2.A2_LOJA = SE2.E2_LOJA " 
//  cQueryE3 += " AND SE2.E2_DATALIB = ' ' "
  //cQueryE3 += " AND SA2.A2_XBLQFIN <> '1' " 
  cQueryE3 += " AND SE2.E2_YLIBPLS <> 'S' "         
  cQueryE3 += " AND (SA2.A2_YBLQPLS = 'N' OR SA2.A2_TIPO = 'F' or SA2.A2_YTPTITU = '6' ) "
  cQueryE3 += " AND SE2.E2_FORNECE BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
  cQueryE3 += " AND SE2.E2_PORTADO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
  cQueryE3 += " AND SE2.E2_VENCREA BETWEEN '"+dtos(MV_PAR05)+"' AND '"+dtos(MV_PAR06)+"'"
  cQueryE3 += " AND SE2.E2_VALOR BETWEEN "+ALLTRIM(STR(mv_par07,17,2))+" AND "+ALLTRIM(STR(mv_par08,17,2))+" "
  cQueryE3 += " AND SE2.E2_TIPO BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"'" 
  cQueryE3 += " and Trim(e2_prefixo)||Trim(e2_tipo)|| Trim(e2_origem)  IN   ('AEDFTPLSMPAG' ,'CLIFTPLSMPAG' ,'CONFTPLSMPAG' ,'HOSFTPLSMPAG' ,'INTFTPLSMPAG' , "
  cQueryE3 += "'LABFTPLSMPAG' ,'MEDFTPLSMPAG' ,'NFENFMATA100' ,'NUPFTPLSMPAG' ,'ODNFTPLSMPAG' ,'OPEFTPLSMPAG' ,'REMFTPLSMPAG' ,'SVDFTPLSMPAG' ,'UINNFMATA100') "
  cQueryE3 += " ORDER BY R_E_C_N_O_ "
   If Select(cArqTmp3) > 0
      dbSelectArea(cArqTmp3)
	  dbCloseArea()
   EndIf
   DbUseArea(.T., 'TOPCONN', TCGenQry(,,cQueryE3), cArqTmp3, .F., .T.)
   dbSelectArea(cArqTmp3)
   dbGoTop()          

Do While (cArqTmp3)->(!Eof()) 
	//	
	_RECSE2:=	(cArqTmp3)->R_E_C_N_O_
	//
	IncProc("Ajustando Pessoa Fisica ")
	//
	DbSelectArea("SE2")
	DbGoto(_RECSE2)
	Reclock("SE2",.F.)
	SE2->E2_YLIBPLS	:=	"S"
	MsUnlock()
	DbSelectArea(cArqTmp3)
	(cArqTmp3)->(DbSkip())
	//
Enddo
// 
dbSelectArea(cArqTmp3)
dbCloseArea()

dbSelectArea(cArqTmp)
dbGoTop()

//
Do While (cArqTmp)->(!Eof()) 
	//	
	_RECSE2:=	(cArqTmp)->R_E_C_N_O_
	//
	IncProc("Liberando Registro ")
	//
	DbSelectArea("SE2")
	DbGoto(_RECSE2)
	Reclock("SE2",.F.)
	SE2->E2_DATALIB	:=	dDataBase
	MsUnlock()
	DbSelectArea(cArqTmp)
	(cArqTmp)->(DbSkip())
	
	//
Enddo
// 
dbSelectArea(cArqTmp)
dbCloseArea()
////  
// =====================================================================================================================
//
// Fase 2 - Definicao de Filtro de Processamento
//
_cFilRet:=	alltrim(_cFilRet)+" AND (E2_YLIBPLS in ( 'S' , 'M'  , 'L'))"//OR A2_YBLQPLS = 'N')"// <> ' ' "
//

Return(_cFilRet)
