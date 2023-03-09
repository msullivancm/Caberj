/*************************************************************************************************************
* Programa....: CABR136    																				      *
* Tipo........: RELATORIO AUXILIAR DO PROTOCOLO DE ATENDIMENTOS                                               *
* Autor.......: Otavio Pinto                                                                                  *
* Criaçao.....: 09/12/2013                                                                                    *
* Modificado..: Otavio Pinto                                                                                  *
* Alteração...:                                                                                               *	
* Solicitante.:                                                                                               *
* Módulo......: PLS - Plano de Saude                                                                          *
* Chamada.....:                                                                                               *
* Objetivo....: Listar movimentação de atendimentos por periodo e tipo de serviço.                            *
 *************************************************************************************************************/
#include "rwmake.ch"

user function CABR136()

local   aRegs     := {}
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "CABR136"
private nLastKey  := 0   
private cCnt01    := GetMv("MV_CABINTE")

ValidPerg()

If ! Pergunte(cPerg,.T.) ; 	Return(Nil) ; EndIf    

Processa({ ||IMP_REL2()},"Gerando Arquivo ... ")

Return Nil

/*
  IMP_REL2  
  Rotina de impressao
*/

static function IMP_REL2()
local _lCabec       := .T.	
local cCabCSV       := ""

private _cDirDocs   := MsDocPath()
private _cPath		:= Alltrim(cCnt01)+if(right(AllTrim(cCnt01),1) <> "\","\","" )            // "C:\TEMP\"
private _cArquivo  	:= "CABR136.csv"    // Alterada a extensão de TXT para CSV 
private cBuffer		:= ""
private oAbrArq 
private nHandle    

FErase( _cPath+_cArquivo )
	
nHandle := FCreate(_cDirDocs + "\" + _cArquivo)
	
if nHandle == -1
	MsgStop("Erro na criacao do arquivo na estacao local. Contate o administrador do sistema")
	return
EndIf

/*
+--------------------------------------------------+
| PARAMETROS UTILIZADOS                            |
+--------------------------------------------------+
|  01  |  Da Filial           | mv_par01           |
|  02  |  Ate Filial          | mv_par02           |
|  03  |  Da Data Digit       | mv_par03           |
|  04  |  Ate Data Digit      | mv_par04           |
|  05  |  C.CUSTO             | mv_par05           |
|  06  |  Tipos de Servicos   | mv_par06           |
+--------------------------------------------------+
*/

////////////////////////////////////////////////////////////////////////INICIO DA QUERY//////////////////

cStrSQL := "SELECT ZY_TIPOSV   TIPO " + cCRLF  
//cStrSQL += "     , (SELECT PBL_YDSSRV FROM PBL010 PB WHERE PB.D_E_L_E_T_ = ' ' AND PBL_YCDSRV = ZY_TIPOSV AND PBL_YDEPTO = 'OUVIDORIA' ) SERVICO " + cCRLF  // Em 23.07.2014 - OSP
cStrSQL += "     , (SELECT PBL_YDSSRV FROM PBL010 PB WHERE PB.D_E_L_E_T_ = ' ' AND PBL_YCDSRV = ZY_TIPOSV AND PBL_YDEPTO = ZX_YAGENC ) SERVICO " + cCRLF  
cStrSQL += "     , ZX_SEQ      PROTOCOLO " + cCRLF  
cStrSQL += "     , SubStr(ZX_DATDE,7,2)||'/'||SubStr(ZX_DATDE,5,2)||'/'||SubStr(ZX_DATDE,1,4)    DATA_INI " + cCRLF  
cStrSQL += "     , ZX_HORADE   HORA_INI " + cCRLF  
cStrSQL += "     , SubStr(ZX_DATATE,7,2)||'/'||SubStr(ZX_DATATE,5,2)||'/'||SubStr(ZX_DATATE,1,4)  DATA_FIN " + cCRLF  
cStrSQL += "     , ZX_HORATE   HORA_FIN " + cCRLF  
cStrSQL += "     , ZX_NOMUSR   NOME " + cCRLF  
cStrSQL += "     , ZX_CODINT||'.'||ZX_CODEMP||'.'||ZX_MATRIC||'.'||ZX_TIPREG||'-'||ZX_DIGITO MATRICULA " + cCRLF  
cStrSQL += "     , ZX_EMAIL    EMAIL " + cCRLF  
cStrSQL += "     , ( SELECT Trim(X5_DESCRI) " + cCRLF  
cStrSQL += "         FROM SX5010 " + cCRLF  
cStrSQL += "         WHERE TRIM(D_E_L_E_T_) IS NULL " + cCRLF  
cStrSQL += "           AND X5_TABELA  = 'ZT' " + cCRLF  
cStrSQL += "           AND Trim(X5_CHAVE)   = Trim(ZX_TPDEM) " + cCRLF  
cStrSQL += "                 )          MANIFESTA " + cCRLF  
cStrSQL += "     , ( SELECT Trim(X5_DESCRI) " + cCRLF  
cStrSQL += "         FROM SX5010 " + cCRLF  
cStrSQL += "         WHERE TRIM(D_E_L_E_T_) IS NULL " + cCRLF  
cStrSQL += "           AND X5_TABELA  = 'ZU' " + cCRLF  
cStrSQL += "           AND Trim(X5_CHAVE)   = Trim(ZX_VATEND) " + cCRLF  
cStrSQL += "                 )          PORTA_ENT " + cCRLF  
cStrSQL += "     , ZY_YCUSTO   TRANSF_PA " + cCRLF  
cStrSQL += "     , ZX_RDA      RDA " + cCRLF  
cStrSQL += "     , Decode(ZX_TPINTEL,'1','Pendente','2','Encerrado')  STATUS " + cCRLF  
cStrSQL += "     , ZX_CONTATO  CONTATO " + cCRLF  
cStrSQL += "     , ZX_YCUSTO   C_CUSTO " + cCRLF  
cStrSQL += "     , ZX_YAGENC   AGENCIA " + cCRLF  
cStrSQL += "     , SubStr(ZX_YDTNASC,7,2)||'/'||SubStr(ZX_YDTNASC,5,2)||'/'||SubStr(ZX_YDTNASC,1,4)  NASC " + cCRLF  
// Motta 5/4/15 solucao para a diferença entre os nomes das colunas entre Caberj e Integral

// FRED: equalizado os campos
//if cEmpAnt = "01" 
  cStrSQL += "     , SubStr(ZX_YDTINC,7,2)||'/'||SubStr(ZX_YDTINC,5,2)||'/'||SubStr(ZX_YDTINC,1,4)   INCLUSAO " + cCRLF
/*
else
  cStrSQL += "     , SubStr(ZX_YDTINIC,7,2)||'/'||SubStr(ZX_YDTINIC,5,2)||'/'||SubStr(ZX_YDTINIC,1,4)   INCLUSAO " + cCRLF       
endif
*/
// FRED: fim alteração

// Fim Motta 5/4/15    
cStrSQL += "     , Upper(ZX_YPLANO)   PLANO " + cCRLF  
cStrSQL += "     , Upper(ZY_USDIGIT)  DIGITADOR " + cCRLF  
cStrSQL += "     , SubStr(ZY_DTSERV,7,2)||'/'||SubStr(ZY_DTSERV,5,2)||'/'||SubStr(ZY_DTSERV,1,4)   DATA_SRV " + cCRLF  
cStrSQL += "     , ZY_HORASV   HORA_SRV " + cCRLF  
cStrSQL += "     , ZY_OBS      ANOTACOES " + cCRLF 
//cStrSQL += "     , ( SELECT Trim(ZY_OBS)||'.'||(SELECT Trim(ZY_OBS)||'.'||(SELECT Trim(ZY_OBS)||'.'||(SELECT Trim(ZY_OBS) " + cCRLF  
//cStrSQL += "                                                                                          FROM "+RetSQLName("SZY") + " ZY " + cCRLF
//cStrSQL += "                                                                                          WHERE D_E_L_E_T_ = ' ' " + cCRLF  
//cStrSQL += "                                                                                            AND ZY_FILIAL  = '  ' " + cCRLF  
//cStrSQL += "                                                                                            AND ZY_SEQBA   = ZX_SEQ " + cCRLF  
//cStrSQL += "                                                                                            AND ZY_DTSERV  = ZX_DATDE ) " + cCRLF  
//cStrSQL += "                                                                                            AND ZY_SEQSERV = '000004') " + cCRLF  
//cStrSQL += "                                                                FROM "+RetSQLName("SZY") + " ZY " + cCRLF
//cStrSQL += "                                                                WHERE D_E_L_E_T_ = ' ' " + cCRLF  
//cStrSQL += "                                                                  AND ZY_FILIAL  = '  ' " + cCRLF  
//cStrSQL += "                                                                  AND ZY_SEQBA   = ZX_SEQ " + cCRLF  
//cStrSQL += "                                                                  AND ZY_DTSERV  = ZX_DATDE " + cCRLF  
//cStrSQL += "                                                                  AND ZY_SEQSERV = '000003') " + cCRLF  
//cStrSQL += "                                     FROM "+RetSQLName("SZY") + " ZY " + cCRLF
//cStrSQL += "                                     WHERE D_E_L_E_T_ = ' ' " + cCRLF  
//cStrSQL += "                                       AND ZY_FILIAL  = '  ' " + cCRLF  
//cStrSQL += "                                       AND ZY_SEQBA   = ZX_SEQ " + cCRLF  
//cStrSQL += "                                       AND ZY_DTSERV  = ZX_DATDE " + cCRLF  
//cStrSQL += "                                       AND ZY_SEQSERV = '000002') " + cCRLF  
//cStrSQL += "         FROM "+RetSQLName("SZY") + " ZY " + cCRLF
//cStrSQL += "         WHERE D_E_L_E_T_ = ' ' " + cCRLF  
//cStrSQL += "           AND ZY_FILIAL  = '  ' " + cCRLF  
//cStrSQL += "           AND ZY_SEQBA   = ZX_SEQ " + cCRLF  
//cStrSQL += "           AND ZY_DTSERV  = ZX_DATDE " + cCRLF  
//cStrSQL += "           AND ZY_SEQSERV = '000001' " + cCRLF  
//cStrSQL += "             )                                           ANOTACOES " + cCRLF 
 
cStrSQL += "       FROM "+RetSQLName("SZX") + " ZX " + cCRLF    
cStrSQL += "          , "+RetSQLName("SZY") + " ZY " + cCRLF    
cStrSQL += "WHERE " + cCRLF  
cStrSQL += "      ZX_FILIAL BETWEEN '"+ mv_par01 +"'  AND '"+mv_par02+"' " + cCRLF  
cStrSQL += "  AND ZX_DATDE  BETWEEN '"+ Dtos(mv_par03) +"'  AND '"+ Dtos(mv_par04) +"' " + cCRLF  

// Em 23.07.2014 - OSP - Permitir buscar TODOS os centros de custo, caso o parametro vazio...
if !Empty(mv_par05)
   cStrSQL += "  AND ZX_YCUSTO = '"+ mv_par05 +"' " + cCRLF  
endif   

cStrSQL += "  AND zx.d_e_l_e_t_ = ' ' " + cCRLF  
cStrSQL += "  AND zy.d_e_l_e_t_ = ' ' " + cCRLF  

cStrSQL += "  AND zx_seq = zy_seqba " + cCRLF  

if !Empty(mv_par06)
   cCodigo := mv_par06
   cTexto := "("
   cCodigo  := Alltrim( cCodigo )        
   WHIL LEN(cCodigo)>0
      cTexto += ( "'"+PARSE(@cCodigo,',')+"'"+iif( LEN(cCodigo)>0,",","") )      
   ENDDO                                   
   cTexto +=")"
   cStrSQL += "  AND ZY_TIPOSV IN "+Alltrim(cTexto)+cCRLF  //cStrSQL += "  AND ZY_TIPOSV IN ('524','525','526') " + cCRLF  
endif   

cStrSQL += "ORDER BY 1 " + cCRLF  

////////////////////////////////////////////////////////////////////////FINAL DA QUERY//////////////////

//*-----------------------------------------------------------------------*
//* Grava a query com o conteudo dos parametros.                          *
//*-----------------------------------------------------------------------*
MemoWrite(Alltrim(_cPath)+"CABR136.SQL", cStrSQL)
 
cStrSQL := ChangeQuery( cStrSQL )                            

//cEndereco := ALLTRIM(MV_PAR03)+IF( RIGHT(ALLTRIM(MV_PAR03),1) == '\' , "" ,"\"   )

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL), "TRB", .T., .F.)                        

//cDTIni := Substr(Dtos(mv_par03),7,2)+"/"+Substr(Dtos(mv_par03),5,2)+"/"+Substr(Dtos(mv_par03),1,4)
//cDTFIM := Substr(Dtos(mv_par04),7,2)+"/"+Substr(Dtos(mv_par04),5,2)+"/"+Substr(Dtos(mv_par04),1,4)

lGerou := .F.
while TRB->( !Eof() )

    if _lCabec 
       lGerou := .T.
	   cCabCSV := PADR("TIPO"     ,004," ")+";"+;
	              PADR("SERVICO"  ,030," ")+";"+;
				  PADR("PROTOC"   ,006," ")+";"+;
				  PADR("DATA_INI" ,010," ")+";"+;
				  PADR("HORA_INI" ,008," ")+";"+;
				  PADR("DATA_FIN" ,010," ")+";"+;
				  PADR("HORA_FIN" ,008," ")+";"+;
				  PADR("NOME"     ,040," ")+";"+;
				  PADR("MATRICULA",022," ")+";"+;
				  PADR("EMAIL"    ,050," ")+";"+;                  
				  PADR("MANIFESTA",015," ")+";"+;                  
				  PADR("PORTA_ENT",012," ")+";"+;                                    
				  PADR("TRANSF_PA",009," ")+";"+;                                    
				  PADR("RDA"      ,006," ")+";"+;
				  PADR("STATUS"   ,009," ")+";"+;
				  PADR("CONTATO"  ,040," ")+";"+;
				  PADR("C_CUSTO"  ,009," ")+";"+;
				  PADR("AGENCIA"  ,020," ")+";"+;
				  PADR("NASC"     ,010," ")+";"+;
				  PADR("INCLUSAO" ,010," ")+";"+;
				  PADR("PLANO"    ,060," ")+";"+;
				  PADR("DIGITADOR",020," ")+";"+;
				  PADR("DATA_SRV" ,010," ")+";"+;
				  PADR("HORA_SRV" ,004," ")+";"+;			  
				  PADR("ANOTACOES",300," ")   

	   FWrite(nHandle, PADR("",004,"=")+";"+;
                       PADR("",030,"=")+";"+;
					   PADR("",006,"=")+";"+;
					   PADR("",010,"=")+";"+;
					   PADR("",008,"=")+";"+;
                       PADR("",010,"=")+";"+;
                       PADR("",008,"=")+";"+;					   
					   PADR("",040,"=")+";"+;
					   PADR("",022,"=")+";"+;
                       PADR("",050,"=")+";"+;
                       PADR("",015,"=")+";"+;
                       PADR("",012,"=")+";"+;
                       PADR("",009,"=")+";"+;
					   PADR("",006,"=")+";"+;
                       PADR("",009,"=")+";"+;
					   PADR("",040,"=")+";"+;
					   PADR("",009,"=")+";"+;
					   PADR("",020,"=")+";"+;
                       PADR("",010,"=")+";"+;
					   PADR("",010,"=")+";"+;
					   PADR("",060,"=")+";"+;
					   PADR("",020,"=")+";"+;
                       PADR("",010,"=")+";"+;
					   PADR("",008,"=")+";"+;
					   PADL("",300,"=") ) ; FWrite(nHandle, cCRLF)  					  
		
       FWrite(nHandle, PADR("",004,"")+";"+;
                       PADR("",030,"")+";"+;
					   PADR("",006,"")+";"+;
					   PADR("",010,"")+";"+;
					   PADR("",008,"")+";"+;
                       PADR("",010,"")+";"+;
                       PADR("",008,"")+";"+;					   
					   PADR("LISTAGEM AUXILIAR DO PROTOCOLO DE ATENDIMENTOS",040,"")+";"+;
					   PADR("",022,"")+";"+;
                       PADR("",050,"")+";"+;
                       PADR("",015,"")+";"+;
                       PADR("",012,"")+";"+;
                       PADR("",009,"")+";"+;                      
					   PADR("",006,"")+";"+;
                       PADR("",009,"")+";"+;
					   PADR("",020,"")+";"+;
					   PADR("",009,"")+";"+;
					   PADR("",040,"")+";"+;
                       PADR("",010,"")+";"+;
					   PADR("",010,"")+";"+;
					   PADR("",060,"")+";"+;
					   PADR("",020,"")+";"+;
                       PADR("",010,"")+";"+;
					   PADR("",008,"")+";"+;
					   PADL("",300,"") ) ; FWrite(nHandle, cCRLF)  					  

	   FWrite(nHandle, PADR("",004,"=")+";"+;
                       PADR("",030,"=")+";"+;
					   PADR("",006,"=")+";"+;
					   PADR("",010,"=")+";"+;
					   PADR("",008,"=")+";"+;
                       PADR("",010,"=")+";"+;
                       PADR("",008,"=")+";"+;					   
					   PADR("",040,"=")+";"+;
					   PADR("",022,"=")+";"+;
                       PADR("",050,"=")+";"+;
                       PADR("",015,"=")+";"+;
                       PADR("",012,"=")+";"+;
                       PADR("",009,"=")+";"+;                       
					   PADR("",006,"=")+";"+;
                       PADR("",009,"=")+";"+;
					   PADR("",040,"=")+";"+;
					   PADR("",009,"=")+";"+;
					   PADR("",020,"=")+";"+;
                       PADR("",010,"=")+";"+;
					   PADR("",010,"=")+";"+;
					   PADR("",060,"=")+";"+;
					   PADR("",020,"=")+";"+;
                       PADR("",010,"=")+";"+;
					   PADR("",008,"=")+";"+;
					   PADL("",300,"=") ) ; FWrite(nHandle, cCRLF)  					  
		
       FWrite(nHandle, cCabCSV)                                                 ; FWrite(nHandle, cCRLF)       
	   FWrite(nHandle, PADR("",004,"=")+";"+;
                       PADR("",030,"=")+";"+;
					   PADR("",006,"=")+";"+;
					   PADR("",010,"=")+";"+;
					   PADR("",008,"=")+";"+;
                       PADR("",010,"=")+";"+;
                       PADR("",008,"=")+";"+;					   
					   PADR("",040,"=")+";"+;
					   PADR("",022,"=")+";"+;
                       PADR("",050,"=")+";"+;
                       PADR("",015,"=")+";"+;
                       PADR("",012,"=")+";"+;
                       PADR("",009,"=")+";"+;                       
					   PADR("",006,"=")+";"+;
                       PADR("",009,"=")+";"+;
					   PADR("",040,"=")+";"+;
					   PADR("",009,"=")+";"+;
					   PADR("",020,"=")+";"+;
                       PADR("",010,"=")+";"+;
					   PADR("",010,"=")+";"+;
					   PADR("",060,"=")+";"+;
					   PADR("",020,"=")+";"+;
                       PADR("",010,"=")+";"+;
					   PADR("",008,"=")+";"+;
					   PADL("",300,"=") ) ; FWrite(nHandle, cCRLF)  					  


	   _lCabec := .F.
    Endif
	
	cBuffer :=  TRB->( PADR(TIPO     ,004," ")+";"+;
	                   PADR(SERVICO  ,030," ")+";"+;
			           PADR(PROTOCOLO,006," ")+";"+;
                       PADR(DATA_INI ,010," ")+";"+;
                       PADR("'"+HORA_INI ,008," ")+";"+;
                       PADR(DATA_FIN ,010," ")+";"+;
                       PADR("'"+HORA_FIN ,008," ")+";"+;
                       PADR(NOME     ,040," ")+";"+;
                       PADR(MATRICULA,022," ")+";"+;
                       PADR(EMAIL    ,050," ")+";"+;
                       PADR(MANIFESTA,015," ")+";"+;
                       PADR(PORTA_ENT,012," ")+";"+;
                       PADR(TRANSF_PA,009," ")+";"+;                      
                       PADR("'"+RDA      ,006," ")+";"+;
                       PADR(STATUS   ,009," ")+";"+;
                       PADR(CONTATO  ,040," ")+";"+;
                       PADR(C_CUSTO  ,009," ")+";"+;
                       PADR(AGENCIA  ,020," ")+";"+;
                       PADR(NASC     ,010," ")+";"+;
                       PADR(INCLUSAO ,010," ")+";"+;
                       PADR(PLANO    ,060," ")+";"+;
                       PADR(DIGITADOR,020," ")+";"+;
                       PADR(DATA_SRV ,010," ")+";"+;
                       PADR("'"+HORA_SRV ,008," ")+";"+;			  
                       PADR(ANOTACOES,300," ")  ) 

	nConta ++
    FWrite(nHandle, cBuffer)                                
    FWrite(nHandle, cCRLF)

 	TRB->( DbSkip() )               
	
ENDDO          

if lGerou
	   FWrite(nHandle, PADR("",004,"=")+";"+;
                       PADR("",030,"=")+";"+;
					   PADR("",006,"=")+";"+;
					   PADR("",010,"=")+";"+;
					   PADR("",008,"=")+";"+;
                       PADR("",010,"=")+";"+;
                       PADR("",008,"=")+";"+;					   
					   PADR("",040,"=")+";"+;
					   PADR("",022,"=")+";"+;
                       PADR("",050,"=")+";"+;
                       PADR("",015,"=")+";"+;
                       PADR("",012,"=")+";"+;
                       PADR("",009,"=")+";"+;                                              
					   PADR("",006,"=")+";"+;
                       PADR("",009,"=")+";"+;
					   PADR("",040,"=")+";"+;
					   PADR("",009,"=")+";"+;
					   PADR("",020,"=")+";"+;
                       PADR("",010,"=")+";"+;
					   PADR("",010,"=")+";"+;
					   PADR("",060,"=")+";"+;
					   PADR("",020,"=")+";"+;
                       PADR("",010,"=")+";"+;
					   PADR("",008,"=")+";"+;
					   PADL("",300,"=") ) ; FWrite(nHandle, cCRLF)  					  

   FWrite(nHandle, cCRLF)
     
   cBuffer := "Fim "
   FWrite(nHandle, cBuffer)
   FClose(nHandle)

   CpyS2T(_cDirDocs + "\" + _cArquivo, _cPath, .T.)

   if mv_par07 == 1 
      //+---------------------------------------------------------------------+
      //| Gera em planilha                                                    |
      //+---------------------------------------------------------------------+  
              
      //msgstop(_cPath+_cArquivo)
      
      oExcelApp := MsExcel():New()
      oExcelApp:WorkBooks:Open( &( "_cPath+_cArquivo" ) ) // Abre uma planilha
      oExcelApp:SetVisible(.T.)              
   else
      //+---------------------------------------------------------------------+
      //| Gera dados no BBloco de Notas                                       |
      //+---------------------------------------------------------------------+    
      oAbrArq := WinExec("NOTEPAD.EXE "+_cPath+_cArquivo)  // Abre o arquivo Log na Tela do usuario
   endif   
                                                                   
   MsgAlert("Foram listado " + alltrim(str(nConta)) + " registros!!!")
else
   MsgAlert("Nao houve movimento para estes parametros. Verifique!!!")   
endif

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

return

/*--------------------------------------------------------------------------*
* Funcao | ValidPerg     | Autor | Otavio Pinto          | Data | 31/01/2011*
*---------------------------------------------------------------------------*
* Descricao: Verifica a existencia das perguntas criando-as caso seja       *
*            necessario (caso nao existam).                                 *
*---------------------------------------------------------------------------*/
Static Function ValidPerg

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

/*
+--------------------------------------------------+
| PARAMETROS UTILIZADOS                            |
+--------------------------------------------------+
|  01  |  Da Filial           | mv_par01           |
|  02  |  Ate Filial          | mv_par02           |
|  03  |  Da Data Digit       | mv_par03           |
|  04  |  Ate Data Digit      | mv_par04           |
|  05  |  C.CUSTO             | mv_par05           |
|  06  |  Tipos de Servicos   | mv_par06           |
+--------------------------------------------------+
*/

AAdd(aRegs,{cPerg , "01" , "Da Filial                ?" ,"","", "mv_ch1" , "C" , 2 , 0 ,0 , "G" , "" , "mv_par01" , ""     , "" , "" , ""      , "" , ""        , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SM0"   , "" })
AAdd(aRegs,{cPerg , "02" , "Ate Filial               ?" ,"","", "mv_ch2" , "C" , 2 , 0 ,0 , "G" , "" , "mv_par02" , ""     , "" , "" , ""      , "" , ""        , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SM0"   , "" })
AAdd(aRegs,{cPerg , "03" , "Da Data Digit            ?" ,"","", "mv_ch3" , "D" , 8 , 0 ,0 , "G" , "" , "mv_par03" , ""     , "" , "" , ""      , "" , ""        , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
AAdd(aRegs,{cPerg , "04" , "Ate Data Digit           ?" ,"","", "mv_ch4" , "D" , 8 , 0 ,0 , "G" , "" , "mv_par04" , ""     , "" , "" , ""      , "" , ""        , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
AAdd(aRegs,{cPerg , "05" , "C.Custo                  ?" ,"","", "mv_ch5" , "C" , 9 , 0 ,0 , "G" , "" , "mv_par05" , ""     , "" , "" , ""      , "" , ""        , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "CTTBA" , "" })
Aadd(aRegs,{cPerg , "06" , "Tipos de Servicos        ?" ,"","", "mv_ch6" , "C" , 15 ,0 ,0 , "G" , "" , "mv_par06" , ""     , "" , "" , ""      , "" , ""        , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
Aadd(aRegs,{cPerg , "07" , "Tipo de Impressao        ?" ,"","", "mv_ch7" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par07" , "Excel", "" , "" , ""      , "" , "NotePad" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
        RecLock("SX1",.T.)
        For j:=1 to FCount()
            If j <= Len(aRegs[i])
                FieldPut(j,aRegs[i,j])
            Endif
        Next
        MsUnlock()
    Endif
Next
dbSelectArea(_sAlias)
Return

/*--------------------------------------------------------------------------*
* Funcao | Parse         | Autor | Otavio Pinto          | Data | 31/01/2011*
*---------------------------------------------------------------------------*
*  Sintaxe....:  PARSE(<@Frase>,<cDelimitador>)                             *
*  Exemplo....:  Frase := 'Otavio|Manoel|Joao|Ana|Paula|Sonia'              *
*                WHIL LEN(Frase)>0                                          *
*                  Nomes := PARSE(@Frase,'|')                               *
*                  ?Nomes                                                   *
*                ENDDO                                                      *
*  Resultado..:                                                             *
*                Otavio                                                     *
*                Manoel                                                     *
*                Joao                                                       *
*                Ana                                                        *
*                Paula                                                      *
*                Sonia                                                      *
*---------------------------------------------------------------------------*/
static function Parse(cFrase, cDelimit)
local LocaVar1, LocaVar2
if (PCOUNT() < 2) ; cDelimit:= [,] ; endif
LocaVar2:= AT(cDelimit, cFrase)
if (LocaVar2 > 0)
   LocaVar1:= LEFT(cFrase, LocaVar2 - 1)
   cFrase  := substr(cFrase, LocaVar2 + len(cDelimit))
else
   LocaVar1:= cFrase
   cFrase  := ""
endif
return LocaVar1

/*--------------------------------------------------------------------------*
* Funcao | ParseHoriz    | Autor | Otavio Pinto          | Data | 31/01/2011*
*---------------------------------------------------------------------------*
* Descricao: Retorna a string na horizontal com aspas, separado por virgula.*
*            Exemplo de retorno: ('DUP','NF')                               *
*---------------------------------------------------------------------------*/
static function ParseHoriz()
private cCodigo := mv_par09
private _cTexto := "("
   cCodigo  := Alltrim( cCodigo )        
   while LEN(cCodigo)>0
      cTexto += ( "'"+PARSE(@cCodigo,',')+"'"+iif( LEN(cCodigo)>0,",","") )
   enddo                                   
   cTexto +=")"
return Alltrim(cTexto)



// Fim do CABR136.PRW
