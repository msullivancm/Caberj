#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                                              
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR245   º Autor ³Altamiro              º Data ³ 24/10/17  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Acompanhamento do Sib - extrato               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                                                      

User Function CABR245(aDados , cDtref )

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABA245"
Private cTitulo     := "Relatorio de Acompanhamento do Sib - Extrato "        
private aDados1     := {} 
private aDados2     := {}
Private cAliastmp 	:= GetNextAlias()             

cMsg += " Este programa ira Gerar Relatorio de Acompanhamento do Sib - Extrato pela data de Entrega " + CRLF
cMsg += "  " + CRLF

***************************************************************************    
 
Private  acabec1:={"Empresa " , "Tipo ",  "Ação " , "Qtda "  } 
private  Descric := ' '                                                                                                         

if empty(cDtref)   	  
   AjustaSX1(cPerg)

   Pergunte(cPerg,.T.)

   cDtEntr    := dtos(mv_par01)     
   cdata      := substr(cDtEntr,7,2)+'/'+substr(cDtEntr,5,2)+'/'+substr(cDtEntr,1,4)
   nEmpresa   := mv_par02                     
   
   Processa({||Processa1()}, cTitulo, "", .T.)
   
else                      
   acabec1    :={" ", "Empresa " , "Tipo ",  "Ação " , "Qtda "  } 
   cDtEntr    := cDtref     
   cdata      := substr(cDtEntr,7,2)+'/'+substr(cDtEntr,5,2)+'/'+substr(cDtEntr,1,4)
   nEmpresa   := 3
   adados1    := adados
EndIf    


//lexcel	   := .T.    
  
//Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  
  
// faz ecxel

// if lexcel      
         
   DlgToExcel({{"ARRAY","Extrato de Ações Sibão " ,aCabec1,aDados1}})   

// EndIF

fGeraRel2()    

MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Processa1() 

Local cquery := ''       

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
///////////////////////////////////
                                              
cquery := " SELECT 'CABERJ' EMPRESA, '0.1 - MATRÍCULA VINCULADA A CCO DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF  
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_CODCCO <> SIB_CODCCO " + CRLF
cquery += "    AND SIB_CODCCO <> ' ' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '0.2 - CCO VINCULADA A MATRÍCULA DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO <> SIB_MATRIC " + CRLF
cquery += "    AND BA1_CODCCO = SIB_CODCCO " + CRLF
cquery += "    AND SIB_CODCCO <> ' ' " + CRLF 
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '0.1 - MATRÍCULA VINCULADA A CCO DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  INNER JOIN BA1020 ON BA1_FILIAL = ' ' " + CRLF 
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_CODCCO <> SIB_CODCCO " + CRLF
cquery += "    AND SIB_CODCCO <> ' ' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '0.2 - CCO VINCULADA A MATRÍCULA DIFERENTE DA BASE' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1020 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO <> SIB_MATRIC " + CRLF
cquery += "    AND BA1_CODCCO = SIB_CODCCO " + CRLF
cquery += "    AND SIB_CODCCO <> ' ' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' '  " + CRLF 

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1 - ATIVOS ANS' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" '  TIPO , 'ENVIAR BLOQUEIO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' ' " + CRLF
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'CABERJ', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1.1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" SEM TABELA BTS' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 BA1 ON BA1_FILIAL = ' ' " + CRLF 
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' ' " + CRLF 
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'CABERJ', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BTS010 BTS " + CRLF
cquery += "  WHERE BTS_FILIAL = ' ' " + CRLF
cquery += "    AND BTS_MATVID = BA1_MATVID" + CRLF
cquery += "    AND BTS.D_E_L_E_T_ = ' ' " + CRLF
cquery += "      ) " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1.2 - ATIVOS ANS E ATIVOS NA BASE OU BLOQUEADOS APÓS "+cdata+"'  TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1010 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '1.3 - ATIVOS NA ANS QUE NÃO EXISTEM NA BASE' TIPO, 'FABRICAR  BLOQUEIO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BA1010 BA1 " + CRLF 
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "      ) " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1 - ATIVOS ANS' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" ' TIPO, 'ENVIAR BLOQUEIO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  INNER JOIN BA1020 BA1 ON BA1_FILIAL = ' ' " + CRLF 
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' '  " + CRLF
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'INTEGRAL', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1.1.1 - ATIVOS ANS E BLOQUEADOS ATÉ "+cdata+" SEM TABELA BTS' TIPO, 'AJUSTAR BASE' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  INNER JOIN BA1020 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND BA1_DATBLO <> ' ' " + CRLF 
cquery += "    AND BA1_DATBLO <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND SIGA.BLOQUEIO_ANS_SIB( 'INTEGRAL', SIB_MATRIC, '"+cDtEntr+"' ) = 'S' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BTS020 BTS " + CRLF
cquery += "  WHERE BTS_FILIAL = ' '  " + CRLF
cquery += "    AND BTS_MATVID = BA1_MATVID " + CRLF
cquery += "    AND BTS.D_E_L_E_T_ = ' ' " + CRLF
cquery += "      ) " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1.2 - ATIVOS ANS E ATIVOS NA BASE OU BLOQUEADOS APÓS "+cdata+" ' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  INNER JOIN BA1020 BA1 ON BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF

cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '1.3 - ATIVOS NA ANS QUE NÃO EXISTEM NA BASE' TIPO, 'FABRICAR BLOQUEIO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  WHERE SIB_SITUAC = '1' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BA1020 BA1 " + CRLF 
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO = SIB_MATRIC " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "      ) " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '2 - ATIVOS NA BASE OU BLOQUEADOS APÓS "+cdata+" ' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1010 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
cquery += "    AND D_E_L_E_T_ = ' '  " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '2.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" NÃO EXISTEM ANS' TIPO, 'SE NÃO ESTIVEREM COMO ENVIADO INCLUSÃO, ENVIAR A INCLUSÃO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1010 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
  
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM CONFSIB_CAB " + CRLF
cquery += "  WHERE SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "      ) " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '2.2 - ATIVOS QUE EXISTEM COMO INATIVOS NA ANS' TIPO, 'ENVIAR REATIVAÇÃO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1010 " + CRLF
cquery += "  INNER JOIN CONFSIB_CAB ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "    AND SIB_SITUAC <> '1' " + CRLF
cquery += "  WHERE BA1_FILIAL = ' '  " + CRLF
cquery += "    AND BA1_DATBLO = ' '  " + CRLF
cquery += "    AND BA1_CODEMP NOT IN ('0004','0009') " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '2 - ATIVOS NA BASE OU BLOQUEADOS APÓS "+cdata+" ' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1020 " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF 
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF 
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '2.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" NÃO EXISTEM ANS' TIPO, 'SE NÃO ESTIVEREM COMO ENVIADO INCLUSÃO, ENVIAR A INCLUSÃO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1020" + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM CONFSIB_INT " + CRLF
cquery += "  WHERE SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "      ) " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '2.2 - ATIVOS QUE EXISTEM COMO INATIVOS NA ANS' TIPO, 'ENVIAR REATIVAÇÃO' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1020 " + CRLF
cquery += "  INNER JOIN CONFSIB_INT ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "    AND SIB_SITUAC <> '1' " + CRLF
cquery += "  WHERE BA1_FILIAL = ' ' " + CRLF
cquery += "    AND BA1_DATBLO = ' ' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'CABERJ' EMPRESA, '3.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" SEM FAMÍLIA QUE EXISTEM ANS' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1010 " + CRLF
cquery += "  INNER JOIN CONFSIB_CAB ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "  WHERE BA1_FILIAL = ' '  " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BA3010 BA3 " + CRLF
cquery += "  WHERE BA3_FILIAL = ' '" + CRLF
cquery += "    AND BA3_CODINT = BA1_CODINT " + CRLF
cquery += "    AND BA3_CODEMP = BA1_CODEMP " + CRLF
cquery += "    AND BA3_MATRIC = BA1_MATRIC " + CRLF
cquery += "    AND BA3.D_E_L_E_T_ = ' '    " + CRLF 
cquery += "      ) " + CRLF
  
cquery += "  UNION " + CRLF

cquery += " SELECT 'INTEGRAL' EMPRESA, '3.1 - ATIVOS OU BLOQUEADOS APÓS "+cdata+" SEM FAMÍLIA QUE EXISTEM ANS' TIPO, '-' AJUSTE, COUNT(*) QTD " + CRLF
cquery += "   FROM BA1020 " + CRLF
cquery += "  INNER JOIN CONFSIB_INT ON SIB_MATRIC = BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO " + CRLF
cquery += "  WHERE BA1_FILIAL = ' '  " + CRLF
cquery += "    AND ( BA1_DATBLO = ' ' OR BA1_DATBLO > '"+cDtEntr+"' ) " + CRLF
cquery += "    AND BA1_DATINC <= '"+cDtEntr+"' " + CRLF
cquery += "    AND D_E_L_E_T_ = ' ' " + CRLF
cquery += "    AND NOT EXISTS " + CRLF
cquery += "      ( " + CRLF
cquery += " SELECT 1 " + CRLF
cquery += "   FROM BA3020 BA3 " + CRLF
cquery += "  WHERE BA3_FILIAL = ' ' " + CRLF
cquery += "    AND BA3_CODINT = BA1_CODINT " + CRLF
cquery += "    AND BA3_CODEMP = BA1_CODEMP " + CRLF
cquery += "    AND BA3_MATRIC = BA1_MATRIC " + CRLF
cquery += "    AND BA3.D_E_L_E_T_ = ' '    " + CRLF  
cquery += "      ) " + CRLF

cquery += "    ORDER BY 1,2 " + CRLF    

////////////////////////////////////////       
	   	
    TCQuery cQuery New Alias (cAliastmp)
      
    dbSelectArea (cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())   
    
           aaDD(aDados1,{ ' '                          ,;
                  (cAliastmp)->empresa                 ,;      
                  (cAliastmp)->Tipo                    ,;      
                  (cAliastmp)->Ajuste                  ,;                 
                  (cAliastmp)->qtd                     })                                 
                  
       (cAliastmp)->(dbSkip()) 	   
    
    EndDo	                   
 
Return    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR245"                                                           ¦

Private aOrdem 		:= {}//{'RDA','Ano/Mes'}            
Private lTPageBreak := .T.         


//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef2()

Local oReport 
Local oDPJ        
Local oDPJ1                
oReport	:= TReport():New("CABR245","Extrato de Processamento do Sibao - " + cdata  ,, {|oReport| ReportPrt(oReport)},"Extrato de Processamento do Sibao - " + cdata )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(3) //Espacamento entre colunas. 
//oReport:SetLandscape() //Impressao em paisagem.  
oReport:SetPortrait() //Impressao em retrato.  

oReport:SetTotalPageBreak(lTPageBreak)

oDPJ := TRSection():New(oReport,"Listagem de Saldos dos RDAs - por Competencia de Faturamento - Sintetico " ,,aOrdem)              

   TRCell():New(oDPJ ,'EMPRESA'	        	,	,'Empresa  '      ,   	             ,10		,,,,,"LEFT"		) 
   TRCell():New(oDPJ ,'TIPO'         		,	,'Tipo     '      ,                  ,70     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'AJUSTE'         		,	,'Ajuste   '      ,                  ,70     	,,,,,"LEFT"	)  
   TRCell():New(oDPJ ,'QTDA'         		,	,'Qtda     '      ,"@E 999,999"      ,07     	,,,,,"RIGHT"	) 
   


lTotSecBrk	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
  
  
**********************  
  
                                                                                                                         
Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrt(oReport)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local   cImp    :='Não'
Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados     
  oDPJ:init()
  nCont := Len(aDados1)
  
  oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

   For i := 1 To Len(aDados1)

    oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf          

       oDPJ:Cell('EMPRESA'	 		):SetValue((aDados1[i][2]))     
       oDPJ:Cell('TIPO'   		    ):SetValue((aDados1[i][3]))  
       oDPJ:Cell('AJUSTE'   		):SetValue((aDados1[i][4])) 
       oDPJ:Cell('QTDA'   	    	):SetValue((aDados1[i][5]))
  	  
      
       oDPJ:PrintLine()
   
   Next i

   oDPJ:Finish()      

*********************************************************************************


Return  
*********************************************************************************


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Data de Entrega ") 		      ,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Empresa         ")               ,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Caberj","","","","Integral","","","Todas","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return

