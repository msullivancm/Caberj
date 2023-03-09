/*************************************************************************************************************
* Programa....: CABR156    																				      *
* Tipo........: RELATORIO USUARIOS REPASSADOS                                                                 *
* Autor.......: Otavio Pinto                                                                                  *
* Criaçao.....: 17/10/2014                                                                                    *
* Modificado..: Otavio Pinto                                                                                  *
* Alteração...:                                                                                               *	
* Solicitante.:                                                                                               *
* Módulo......: PLS - Plano de Saude                                                                          *
* Chamada.....:                                                                                               *
* Objetivo....: Listar movimentação usuários repassados.                                                      *
 *************************************************************************************************************/     
/*
em 12/3/18 tratar tambem o caso 018 nas situaçoes adversas
Motta chamado 56676 
*/ 
 
#include "rwmake.ch"

user function CABR156()

local   aRegs     := {}
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "CABR156"
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
private _cArquivo  	:= "CABR156.csv"    // Alterada a extensão de TXT para CSV 
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
+-----------------------------------------------+
| PARAMETROS UTILIZADOS                         |
+-----------------------------------------------+
|  01 |  Operadora De ?               |  mv_ch1 |  
|  02 |  Operadora Ate ?              |  mv_ch2 |  
|  03 |  Grupo/Empresa De ?           |  mv_ch3 |  
|  04 |  Grupo/Empresa Ate ?          |  mv_ch4 |  
|  05 |  Contrato De ?                |  mv_ch5 |  
|  06 |  Contrato Ate ?               |  mv_ch6 |  
|  07 |  Subcontrato De ?             |  mv_ch7 |  
|  08 |  Subcontrato Ate ?            |  mv_ch8 |  
|  09 |  Data Repasse De ?            |  mv_ch9 |  
|  10 |  Data Repasse Ate ?           |  mv_ch0 |  
|  11 |  Operadora Destino ?          |  mv_cha |  
+-----------------------------------------------+
*/

////////////////////////////////////////////////////////////////////////INICIO DA QUERY//////////////////

cStrSQL := " SELECT BA1.BA1_CODINT||'.'||BA1.BA1_CODEMP||'.'||BA1.BA1_MATRIC||'-'||BA1_TIPREG||BA1_DIGITO MATRICULA " + cCRLF  
cStrSQL += "      , TRIM(BA1_NOMUSR) NOME_USUARIO " + cCRLF  
cStrSQL += "      , (substr(BA1_DATNAS, 7, 2)|| '/' || substr(BA1_DATNAS, 5, 2) ||'/'||substr(BA1_DATNAS, 1, 4)) DATNASC " + cCRLF  
cStrSQL += "      , SIGA.IDADE_S (BA1.BA1_DATNAS) IDADE " + cCRLF  
cStrSQL += "      , BA1_TIPUSU TIPO_USUARIO " + cCRLF  
cStrSQL += "      , CASE when  BA1_SEXO = '1' then 'M' " + cCRLF  
cStrSQL += "             when  BA1_SEXO = '2' then 'F' " + cCRLF  
cStrSQL += "        end CODIGO_SITUACAO " + cCRLF  
cStrSQL += "      , BA1_ESTCIV ESTADO_CIVIL " + cCRLF  
cStrSQL += "      , (SELECT BRP.BRP_DESCRI FROM "+RetSQLName("BRP") + " BRP WHERE BRP.D_E_L_E_T_ = ' ' AND BRP.BRP_CODIGO = BA1.BA1_GRAUPA )GRAU_PARENT " + cCRLF  
cStrSQL += "      , (SELECT BG3.BG3_DESBLO FROM "+RetSQLName("BG3") + " BG3 WHERE BG3.D_E_L_E_T_ = ' ' AND BG3.BG3_CODBLO = BA1.BA1_MOTBLO ) MOT_DESBLO " + cCRLF  
cStrSQL += "      , BA1_MOTBLO MOT_BLOQ " + cCRLF  
cStrSQL += "      , (substr(BA1_DATINC, 7, 2)|| '/' || substr(BA1_DATINC, 5, 2) ||'/'||substr(BA1_DATINC, 1, 4)) BA1_DATINC " + cCRLF  
cStrSQL += "      , (substr(BA1_DATREP, 7, 2)|| '/' || substr(BA1_DATREP, 5, 2) ||'/'||substr(BA1_DATREP, 1, 4)) DAT_REPASSE " + cCRLF  
cStrSQL += "      , (SUBSTR(BA1_DATBLO, 7, 2)|| '/' || SUBSTR(BA1_DATBLO, 5, 2) ||'/'||SUBSTR(BA1_DATBLO, 1, 4)) DATBLOQ " + cCRLF    
cStrSQL += "   	  , TRIM(BA1_CODEMP) CODEMP" + cCRLF  
cStrSQL += "      , TRIM(BA1_CONEMP) CONTRATO" + cCRLF  
cStrSQL += "      , TRIM(BA1_SUBCON) SUBCON" + cCRLF  
cStrSQL += "      , TRIM(BA1_OPEORI) OP_ORIGEM  " + cCRLF  
cStrSQL += "      , ( SELECT BA0.BA0_NOMINT FROM "+RetSQLName("BA0") + " BA0 WHERE BA0.D_E_L_E_T_ = ' ' AND BA0.BA0_CODIDE||BA0.BA0_CODINT = BA1.BA1_OPEORI ) OP_ORIGEM_DESC" + cCRLF  
cStrSQL += "      , TRIM(BA1_OPEDES) OP_DESTINO " + cCRLF  
cStrSQL += "      , ( SELECT BA0.BA0_NOMINT FROM "+RetSQLName("BA0") + " BA0 WHERE BA0.D_E_L_E_T_ = ' ' AND BA0.BA0_CODIDE||BA0.BA0_CODINT = BA1.BA1_OPEDES ) OP_DEST_DESC" + cCRLF  
cStrSQL += "      , BA1_ESTADO ESTADO " + cCRLF  
cStrSQL += "      , TRIM(BA1_YMTREP) MAT_REPASSE " + cCRLF  
cStrSQL += "      , ( SELECT BHH.BHH_CODSAD FROM "+RetSQLName("BHH") + " BHH WHERE BHH.D_E_L_E_T_ = ' ' AND BHH.BHH_FILIAL = BA1.BA1_FILIAL AND BHH.BHH_CODINT = BA1.BA1_CODINT AND BHH.BHH_CODEMP = BA1.BA1_CODEMP AND BHH.BHH_MATRIC = BA1.BA1_MATRIC AND BHH.BHH_TIPREG = BA1.BA1_TIPREG  AND BHH.BHH_CODSAD IN ('009','018') AND ROWNUM < 2 ) SAD_COD " + cCRLF  
cStrSQL += "      , ( SELECT CASE when  Trim(BHH.BHH_CODSAD) IN ('009','018') then 'REPASSE CONVENIO'  end FROM "+RetSQLName("BHH") + " BHH WHERE BHH.D_E_L_E_T_ = ' ' AND BHH.BHH_FILIAL = BA1.BA1_FILIAL AND BHH.BHH_CODINT = BA1.BA1_CODINT AND BHH.BHH_CODEMP = BA1.BA1_CODEMP AND BHH.BHH_MATRIC = BA1.BA1_MATRIC AND BHH.BHH_TIPREG = BA1.BA1_TIPREG  AND BHH.BHH_CODSAD IN ('009','018') AND ROWNUM < 2 ) SAD_DESC " + cCRLF  
cStrSQL += "      , ( SELECT BHH.BHH_OBS1 FROM "+RetSQLName("BHH") + " BHH WHERE BHH.D_E_L_E_T_ = ' ' AND BHH.BHH_FILIAL = BA1.BA1_FILIAL AND BHH.BHH_CODINT = BA1.BA1_CODINT AND BHH.BHH_CODEMP = BA1.BA1_CODEMP AND BHH.BHH_MATRIC = BA1.BA1_MATRIC AND BHH.BHH_TIPREG = BA1.BA1_TIPREG  AND BHH.BHH_CODSAD IN ('009','018') AND ROWNUM < 2 ) OBS_1 " + cCRLF  
cStrSQL += "      , ( SELECT BHH.BHH_OBS2 FROM "+RetSQLName("BHH") + " BHH WHERE BHH.D_E_L_E_T_ = ' ' AND BHH.BHH_FILIAL = BA1.BA1_FILIAL AND BHH.BHH_CODINT = BA1.BA1_CODINT AND BHH.BHH_CODEMP = BA1.BA1_CODEMP AND BHH.BHH_MATRIC = BA1.BA1_MATRIC AND BHH.BHH_TIPREG = BA1.BA1_TIPREG  AND BHH.BHH_CODSAD IN ('009','018') AND ROWNUM < 2 ) OBS_2 " + cCRLF  
cStrSQL += "      , ( SELECT BHH.BHH_OBS3 FROM "+RetSQLName("BHH") + " BHH WHERE BHH.D_E_L_E_T_ = ' ' AND BHH.BHH_FILIAL = BA1.BA1_FILIAL AND BHH.BHH_CODINT = BA1.BA1_CODINT AND BHH.BHH_CODEMP = BA1.BA1_CODEMP AND BHH.BHH_MATRIC = BA1.BA1_MATRIC AND BHH.BHH_TIPREG = BA1.BA1_TIPREG  AND BHH.BHH_CODSAD IN ('009','018') AND ROWNUM < 2 ) OBS_3 " + cCRLF  

//----------------------------------------------------------
//Inicio 	- Angelo Henrique - Data: 05/07/2018
//Chamado: 50922 
//----------------------------------------------------------
cStrSQL += "      , BA1_CPFUSR CPF	 	" + cCRLF
cStrSQL += "      , BA1_MAE MAE 		" + cCRLF
//----------------------------------------------------------
//Fim 		- Angelo Henrique - Data: 05/07/2018
//----------------------------------------------------------

cStrSQL += " FROM "+RetSQLName("BA1") + " BA1 " + cCRLF

cStrSQL += "   WHERE BA1.BA1_CODINT BETWEEN '"+ mv_par01 +"'  AND '"+mv_par02+"' " + cCRLF        // Operadora
cStrSQL += "   AND BA1.BA1_CODEMP BETWEEN '"+ mv_par03 +"'  AND '"+ mv_par04 +"' " + cCRLF      // Grupo/Empresa
cStrSQL += "   AND BA1.BA1_CONEMP BETWEEN '"+ mv_par05 +"'  AND '"+ mv_par06 +"' " + cCRLF      // Contrato
cStrSQL += "   AND BA1.BA1_SUBCON BETWEEN '"+ mv_par07 +"'  AND '"+ mv_par08 +"' " + cCRLF      // Subcontrato

//cStrSQL += "   AND BA1.BA1_DATBLO BETWEEN '"+ Dtos(mv_par09) +"'  AND '"+ Dtos(mv_par10) +"' " + cCRLF  
                                                                           
cStrSQL += "   AND (((BA1.BA1_DATREP BETWEEN '"+Dtos(mv_par09)+"' AND '"+Dtos(mv_par10)+"' ) OR (BA1.BA1_DATINC BETWEEN '        ' AND '20141231' and BA1.BA1_DATREP >= '"+Dtos(mv_par09)+"') OR BA1.BA1_DATBLO BETWEEN '        ' AND '"+Dtos(mv_par10)+"'))

if mv_par11 == 1 
   cStrSQL += "   AND BA1.BA1_MOTBLO <> ' ' " + cCRLF     
elseif mv_par11 == 2 
   cStrSQL += "   AND BA1.BA1_MOTBLO = ' ' " + cCRLF     
endif   

if !Empty(mv_par13)
   cStrSQL += "   AND Trim(BA1.BA1_OPEDES) = '"+mv_par13+"' " + cCRLF  // Operadora Destino
endif 


if !Empty(mv_par12)
   cStrSQL += "   AND Trim(BA1.BA1_OPEORI) = '"+mv_par12+"' " + cCRLF  // Operadora Destino
endif
  


cStrSQL += "   AND BA1.D_E_L_E_T_ = ' ' " + cCRLF  

cStrSQL += " ORDER BY BA1.BA1_CODINT, BA1.BA1_CODEMP, BA1.BA1_MATRIC, BA1.BA1_TIPREG " + cCRLF  

////////////////////////////////////////////////////////////////////////FINAL DA QUERY//////////////////

//*-----------------------------------------------------------------------*
//* Grava a query com o conteudo dos parametros.                          *
//*-----------------------------------------------------------------------*
MemoWrite(Alltrim(_cPath)+"CABR156.SQL", cStrSQL)
 
cStrSQL := ChangeQuery( cStrSQL )                            

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL), "TRB", .T., .F.)                        

lGerou := .F.
while TRB->( !Eof() )

    if _lCabec 
       lGerou := .T.
	   cCabCSV := PADR("MATRICULA"       ,021," ")+";"+;
	              PADR("USUARIO"         ,040," ")+";"+;
				  PADR("DATNASC"         ,010," ")+";"+;  
				  PADR("IDADE"         	 ,005," ")+";"+;
				  PADR("T/D"             ,003," ")+";"+;
				  PADR("M/F"             ,003," ")+";"+;
				  PADR("EST_CIVIL"       ,009," ")+";"+;
				  PADR("GR_PARENT"       ,011," ")+";"+;
				  PADR("CPF"		     ,020," ")+";"+;
				  PADR("MAE"	         ,040," ")+";"+;
                  PADR("DES_BLOC"        ,030," ")+";"+;
				  PADR("MOT_BLOQ"        ,008," ")+";"+;
				  PADR("DATBLOQ"         ,010," ")+";"+;
				  PADR("DATINC"          ,010," ")+";"+;
				  PADR("DT_REPASS"       ,010," ")+";"+;
			 	  PADR("CODEMP"          ,004," ")+";"+;
				  PADR("CONTRATO"        ,015," ")+";"+;
				  PADR("SUBCON"          ,011," ")+";"+;
				  PADR("OP_ORIG"         ,007," ")+";"+;
				  PADR("OP_ORI_DESC"     ,030," ")+";"+;
				  PADR("OP_DEST"         ,007," ")+";"+;
				  PADR("OP_DEST_DESC"    ,030," ")+";"+;
				  PADR("EST"             ,003," ")+";"+;
				  PADR("MAT_REPASSE"     ,020," ")+";"+;
				  PADR("CODSIT"          ,006," ")+";"+;
				  PADR("DESSIT"          ,030," ")+";"+;
				  PADR("OBS_1"           ,070," ")+";"+;
				  PADR("OBS_2"           ,070," ")+";"+;			  
				  PADR("OBS_3"           ,070," ")   

	   _lCabec := .F.
       FWrite(nHandle, cCabCSV) ; FWrite(nHandle, cCRLF)

    Endif

	cBuffer :=  TRB->(  PADR("'"+MATRICULA    ,021," ")+";"+;
	                    PADR(NOME_USUARIO     ,040," ")+";"+;
				        PADR(DATNASC          ,010," ")+";"+;   
				        PADR(IDADE            ,005," ")+";"+;
				        PADR(TIPO_USUARIO     ,003," ")+";"+;
				        PADR(CODIGO_SITUACAO  ,003," ")+";"+;
				        PADR(ESTADO_CIVIL     ,009," ")+";"+;
				        PADR(GRAU_PARENT      ,011," ")+";"+;
				        PADR(CPF        	  ,020," ")+";"+;
				        PADR(MAE      		  ,040," ")+";"+;
                        PADR(MOT_DESBLO       ,030," ")+";"+;
				        PADR("'"+MOT_BLOQ     ,008," ")+";"+;
				        PADR(DATBLOQ          ,012," ")+";"+;                        
				        PADR(BA1_DATINC       ,010," ")+";"+;
				        PADR(DAT_REPASSE      ,010," ")+";"+;   				        
				        PADR("'"+CODEMP     	  ,004," ")+";"+; 
				        PADR("'"+CONTRATO      	  ,015," ")+";"+; 
				        PADR("'"+SUBCON      	  ,011," ")+";"+; 						        
				        PADR("'"+OP_ORIGEM        ,007," ")+";"+;
				        PADR(OP_ORIGEM_DESC   ,030," ")+";"+;
				        PADR(OP_DESTINO       ,007," ")+";"+;
				        PADR(OP_DEST_DESC     ,030," ")+";"+;
				        PADR(ESTADO           ,003," ")+";"+;
				        PADR("'"+MAT_REPASSE  ,020," ")+";"+;
				        PADR("'"+SAD_COD      ,006," ")+";"+;
				        PADR(SAD_DESC         ,030," ")+";"+;
				        PADR(OBS_1            ,070," ")+";"+;
				        PADR(OBS_2            ,070," ")+";"+;			  
				        PADR(OBS_3            ,070," ")    )
				       
	nConta ++
    FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)

 	TRB->( DbSkip() )               
	
ENDDO          

if lGerou
     
   cBuffer := "Fim "
   FWrite(nHandle, cBuffer) ; FClose(nHandle)

   CpyS2T(_cDirDocs + "\" + _cArquivo, _cPath, .T.)

   //+---------------------------------------------------------------------+
   //| Gera em planilha                                                    |
   //+---------------------------------------------------------------------+              
      
   oExcelApp := MsExcel():New()
   oExcelApp:WorkBooks:Open( &( "_cPath+_cArquivo" ) ) // Abre uma planilha
   oExcelApp:SetVisible(.T.)              
                                                                   
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

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
/*
+-----------------------------------------------+
| PARAMETROS UTILIZADOS                         |
+-----------------------------------------------+
|  01 |  Operadora De ?               |  mv_ch1 |  
|  02 |  Operadora Ate ?              |  mv_ch2 |  
|  03 |  Grupo/Empresa De ?           |  mv_ch3 |  
|  04 |  Grupo/Empresa Ate ?          |  mv_ch4 |  
|  05 |  Contrato De ?                |  mv_ch5 |  
|  06 |  Contrato Ate ?               |  mv_ch6 |  
|  07 |  Subcontrato De ?             |  mv_ch7 |  
|  08 |  Subcontrato Ate ?            |  mv_ch8 |  
|  09 |  Data Repasse De ?            |  mv_ch9 |  
|  10 |  Data Repasse Ate ?           |  mv_ch0 |  
|  11 |  Operadora Destino ?          |  mv_cha |  
+-----------------------------------------------+
*/

aadd(aRegs,{cPerg,"01","Operadora De ?              ","","","mv_ch1","C", 4,0,0,"G","","mv_par01",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B89PLS",""})
aadd(aRegs,{cPerg,"02","Operadora Ate ?             ","","","mv_ch2","C", 4,0,0,"G","","mv_par02",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B89PLS",""})
aadd(aRegs,{cPerg,"03","Grupo/Empresa De ?          ","","","mv_ch3","C", 4,0,0,"G","","mv_par03",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B7APLS",""})
aadd(aRegs,{cPerg,"04","Grupo/Empresa Ate ?         ","","","mv_ch4","C", 4,0,0,"G","","mv_par04",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B7APLS",""})
aadd(aRegs,{cPerg,"05","Contrato De ?               ","","","mv_ch5","C",12,0,0,"G","","mv_par05",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B7BPLS",""})
aadd(aRegs,{cPerg,"06","Contrato Ate ?              ","","","mv_ch6","C",12,0,0,"G","","mv_par06",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B7BPLS",""})
aadd(aRegs,{cPerg,"07","Subcontrato De ?            ","","","mv_ch7","C", 9,0,0,"G","","mv_par07",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B7CPLS",""})
aadd(aRegs,{cPerg,"08","Subcontrato Ate ?           ","","","mv_ch8","C", 9,0,0,"G","","mv_par08",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B7CPLS",""})
aadd(aRegs,{cPerg,"09","Data Repasse De ?           ","","","mv_ch9","D", 8,0,0,"G","","mv_par09",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","",""      ,""})
aadd(aRegs,{cPerg,"10","Data Repasse Ate ?          ","","","mv_ch0","D", 8,0,0,"G","","mv_par10",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","",""      ,""}) 
aadd(aRegs,{cPerg,"11","Bloqueados ?                ","","","mv_cha","N", 1,0,0,"C","","mv_par11","Sim","","","","","Nao","","","","","Ambos","","","","","","","","","","","","","",""      ,""})
aadd(aRegs,{cPerg,"12","Operadora Origem ?         ","","","mv_chb","C", 4,0,0,"G","","mv_par12",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B89PLS",""})
aadd(aRegs,{cPerg,"13","Operadora Destino ?         ","","","mv_chc","C", 4,0,0,"G","","mv_par13",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","","B89PLS",""})
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



// Fim do CABR156.PRW
