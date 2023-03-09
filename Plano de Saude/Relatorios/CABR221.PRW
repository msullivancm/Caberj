#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO6     บ Autor ณ Marcela Coimbra    บ Data ณ  21/10/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relat๓rio de confer๊ncia de baixas da Previ                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABR221(  )      

c_CodSec := PBT->PBT_SEQUEN


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Private oDlg
Private a_Vet 	:= { }
Private a_VetTit:= { 	"TIPO_INCONCISTENCIA",;
						"TIPO_OPER"          ,;
						"MATRICULA"          ,;
						"CPF_TITULAR"        ,;
						"CPF_USUARIO"        ,;
						"NOME_USUARIO"       ,;
						"CODIGO_PLANO_PREF"  ,;
						"DESC_PLANO_PREF"    ,;
						"PLANO_BASE"         ,;
						"PLANO_MEDICO_PREF"  ,;
						"TITUARIDADE" }
Private c_Perg 	:= "CABR120B"    

c_Qry := " Select 'PLANO DIFERENTE' TIPO_ANALISE , " + CRLF
c_Qry += "        DECODE(TRIM(PBU_OPER), '1', 'INCLUSAO', '2', 'ALTERACAO', '3', 'BLOQUEIO', '0', 'BATIMENTO', 'NAO CLASSIFICADO') TIPO_OPER, " + CRLF
c_Qry += "        BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG MATRICULA, " + CRLF
c_Qry += "        PBU_FUNC CPF_TITULAR, " + CRLF
c_Qry += "               PBU_CPF CPF_USUARIO, " + CRLF
c_Qry += "               PBU_BENEF NOME_USUARIO, " + CRLF
c_Qry += "               PBU_PADRAO CODIGO_PLANO_PREF, " + CRLF
c_Qry += "               DS_PREVIRIO DESC_PLANO_PREF, " + CRLF
c_Qry += "               RETORNA_DESC_PLANO_MS('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) PLANO_BASE, " + CRLF
c_Qry += "               PBU_PADRAO COD_PLA_PREF, " + CRLF
c_Qry += "               BA1_CODPLA COD_PLA_BASE,  " + CRLF
c_Qry += "               to_date(ba1_datinc, 'YYYYMMDD') DT_INCLUSAO_BASE, " + CRLF
c_Qry += "               to_date(TRIM(PBU_DTINCO), 'YYYYMMDD') DT_INCLUSAO_PREF,    " + CRLF    
c_Qry += "               DECODE(PBU_PADRAO, '283 ', PBU_CDBENE, '284 ', PBU_CDBENE, 'T') D, " + CRLF
c_Qry += "               PLANO_MEDICO, " + CRLF
c_Qry += "               BA1_CODPLA, PBU_PADRAO,PBU_CDBENE, BA1_TIPUSU " + CRLF
c_Qry += "        from pbu010 left JOIN SIGA.PLANO_PREF_CAB_NV ON PLANO_PREF = TRIM(PBU_PADRAO) AND DECODE(PBU_PADRAO, '283 ', PBU_CDBENE, '284 ', PBU_CDBENE, 'T') = TIP_USU  " + CRLF
c_Qry += "                    left join ba3010 on ba3_filial = ' ' AND BA3_CODINT = '0001' and BA3_CODEMP = '0024' AND BA3_SUBCON = '000000003' AND  BA3_MATEMP = pbu_func  " + CRLF
c_Qry += "                    left join ba1010 on ba1_filial = ' ' and ba1_codint = ba3_codint and ba1_codemp = ba3_codemp and ba1_matric = ba3_matric and ba1_cpfusr = pbu_cpf  " + CRLF
            
c_Qry += "        where PBU_FILIAL = ' '  " + CRLF
c_Qry += "        AND PBU_SEQUEN = '" + c_CodSec + "' " + CRLF
c_Qry += "        AND  BA1_CODPLA <> PLANO_MEDICO " + CRLF

c_Qry += "        UNION " + CRLF 
                                              


c_Qry += " Select 'NรO EXISTE NA BASE' TIPO_ANALISE , " + CRLF
c_Qry += "        DECODE(TRIM(PBU_OPER), '1', 'INCLUSAO', '2', 'ALTERACAO', '3', 'BLOQUEIO', '0', 'BATIMENTO', 'NAO CLASSIFICADO') TIPO_OPER, " + CRLF
c_Qry += "        BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG MATRICULA, " + CRLF
c_Qry += "        PBU_FUNC CPF_TITULAR, " + CRLF
c_Qry += "               PBU_CPF CPF_USUARIO, " + CRLF
c_Qry += "               PBU_BENEF NOME_USUARIO, " + CRLF
c_Qry += "               PBU_PADRAO CODIGO_PLANO_PREF, " + CRLF
c_Qry += "               DS_PREVIRIO DESC_PLANO_PREF, " + CRLF
c_Qry += "               RETORNA_DESC_PLANO_MS('C',BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG) PLANO_BASE, " + CRLF
c_Qry += "               PBU_PADRAO COD_PLA_PREF, " + CRLF
c_Qry += "               BA1_CODPLA COD_PLA_BASE,  " + CRLF
c_Qry += "               to_date(ba1_datinc, 'YYYYMMDD') DT_INCLUSAO_BASE, " + CRLF
c_Qry += "               to_date(TRIM(PBU_DTINCO), 'YYYYMMDD') DT_INCLUSAO_PREF,    " + CRLF    
c_Qry += "               DECODE(PBU_PADRAO, '283 ', PBU_CDBENE, '284 ', PBU_CDBENE, 'T') D, " + CRLF
c_Qry += "               PLANO_MEDICO, " + CRLF
c_Qry += "               BA1_CODPLA, PBU_PADRAO,PBU_CDBENE, BA1_TIPUSU " + CRLF
c_Qry += "        from pbu010 left JOIN SIGA.PLANO_PREF_CAB_NV ON PLANO_PREF = TRIM(PBU_PADRAO) AND DECODE(PBU_PADRAO, '283 ', PBU_CDBENE, '284 ', PBU_CDBENE, 'T') = TIP_USU  " + CRLF
c_Qry += "                    left join ba3010 on ba3_filial = ' ' AND BA3_CODINT = '0001' and BA3_CODEMP = '0024' AND BA3_SUBCON = '000000003' AND  BA3_MATEMP = pbu_func  " + CRLF
c_Qry += "                    left join ba1010 on ba1_filial = ' ' and ba1_codint = ba3_codint and ba1_codemp = ba3_codemp and ba1_matric = ba3_matric and ba1_cpfusr = pbu_cpf  " + CRLF
            
c_Qry += "        where PBU_FILIAL = ' '  " + CRLF
c_Qry += "        AND PBU_SEQUEN = '" + c_CodSec + "' " + CRLF
c_Qry += "        AND BA1_MATRIC IS NULL" + CRLF
c_Qry += "        ORDER BY 1 DESC " + CRLF 


TCQUERY c_Qry ALIAS "TMPR221" NEW

While !TMPR221->( EOF() )

	aadd( a_Vet, { 	TMPR221->TIPO_ANALISE         ,; 
                    TMPR221->TIPO_OPER      ,; 
					"'"+TMPR221->MATRICULA,; 
					"'"+TMPR221->CPF_TITULAR,;
					"'"+TMPR221->CPF_USUARIO,;
					TMPR221->NOME_USUARIO      ,;
					"'"+TMPR221->CODIGO_PLANO_PREF ,;
					TMPR221->DESC_PLANO_PREF   ,;
					"'"+trim(TMPR221->COD_PLA_BASE)        ,;
					"'"+TMPR221->PLANO_MEDICO ,;
					TMPR221->BA1_TIPUSU        ;
					} )

	TMPR221->( dbSkip() )

    
EndDo   

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ O arquivo texto deve ser fechado, bem como o dialogo criado na fun- ณ
//ณ cao anterior.                                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

DlgToExcel({{"ARRAY","Analise de movimentacao prefeitura. Arquivo: " + c_CodSec + "." ,a_VetTit , a_Vet}})
//DlgToExcel({{"CABECALHO","Rela็ใo de Diferen็a de baixas da Previ" ,a_VetTit , a_Vet}, ;
//{"ARRAY","Rela็ใo de Diferen็a de baixas da Previ" ,a_VetTit , a_Vet}})

Return


Static Function ValidPerg()
                                                                             
      
aHelp := {}
aAdd(aHelp, "Informe o caminho do arquivo")         
PutSX1(c_Perg , "01" , "Caminho do arquivo: " 	,"","","mv_ch1","C",80							,0,0,"G",""	,"DIR"			,"","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Data da disponibilizacao.")         
PutSX1(c_Perg , "02" , "Data Dispo." 		    ,"","","mv_ch2","D",08							,0,0,"G",""	,""			,"","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Ano Competencia")         
PutSX1(c_Perg , "03" , "Ano Competencia" 		,"","","mv_ch3","C",02							,0,0,"G",""	,""			,"","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Mes Competencia")         
PutSX1(c_Perg , "04" , "Mes Competencia" 		,"","","mv_ch4","C",02							,0,0,"G",""	,""			,"","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)


Return
