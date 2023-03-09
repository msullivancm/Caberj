/*************************************************************************************************************
* Programa....: CABR158  																				      *
* Tipo........: RELATORIO USUARIOS P/SUBCONT-EXECL                                                            *
* Autor.......: Otavio Pinto                                                                                  *
* Criaçao.....: 23/10/2014                                                                                    *
* Modificado..: Otavio Pinto                                                                                  *
* Alteração...:                                                                                               *	
* Solicitante.:                                                                                               *
* Módulo......: PLS - Plano de Saude                                                                          *
* Chamada.....:                                                                                               *
* Objetivo....: Listar movimentação usuários por Sub-Contrato em EXCEL.                                       *
 *************************************************************************************************************/
#include "rwmake.ch"

user function CABR158()

local   aRegs     := {}
private cLIN      := ""
private cCRLF     := CHR(13)+CHR(10)
private nConta    := 0
private cPerg     := "CABR158"
private nLastKey  := 0   
private cCnt01    := GetMv("MV_CABINTE")
private fdia      := {'31','28','31','30','31','30','31','31','30','31','30','31'}                    
private aGrade    := {}

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
private _cArquivo  	:= "CABR158.csv"    // Alterada a extensão de TXT para CSV 
private cBuffer		:= ""
private oAbrArq 
private nHandle    

private _dDtIni     :=  mv_par09
private _dDtFim     :=  CtoD("")

private cPeriodo    := ""
private nMES_ANT    := 0
private nBLOQ       := 0
private nINCL       := 0
private nEFETIVO    := 0
private nTIT        := 0
private nDEP        := 0



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
|  09 |  Data Inicial ?               |  mv_ch9 |  
|  10 |  Quantos meses à frente ?     |  mv_ch0 |  
|  11 |                               |  mv_cha |  
+-----------------------------------------------+
*/

////////////////////////////////////////////////////////////////////////INICIO DA QUERY//////////////////

cStrSQL := "" 

mv_par10 := if( mv_par10 == 0 , 1 , mv_par10 )

_dDtFim := _dDtIni

FOR XX := 1 TO  mv_par10

   _dDtFim := CTOD( If( Mod(Year(_dDtIni),4)=0 .And. Month( _dDtIni ) = 2 , '29', fdia[Month( _dDtIni )] )+ "/" +strzero(month(_dDtIni),2) +"/"+strzero(year(_dDtIni),4) ) 																				

   cStrSQL := " SELECT DISTINCT " + cCRLF  
   cStrSQL += "       '"+substr(dtos(_dDtIni),1,4)+"/"+ substr(dtos(_dDtIni),5,2)+ "' PERIODO" + cCRLF  
   cStrSQL += "     , BA1_CODINT                  OPERADORA " + cCRLF  
   cStrSQL += "     , BA1_CODEMP                  GRUPO " + cCRLF  
   cStrSQL += "     , BA1_CONEMP||'-'||BA1_VERCON CONTRATO " + cCRLF  
   cStrSQL += "     , BA1_SUBCON||'-'||BA1_VERSUB SUBCONTRATO " + cCRLF  
   cStrSQL += "     , (SELECT BQC_DESCRI "  + cCRLF  
   cStrSQL += "        FROM "+RetSQLName("BQC") + " BQ  "  + cCRLF   
   cStrSQL += "        WHERE BQ.D_E_L_E_T_ = ' ' "  + cCRLF   
   cStrSQL += "          AND BQC_FILIAL = ' ' "  + cCRLF   
   cStrSQL += "          AND BQC_CODIGO = BA1_CODINT||BA1_CODEMP  "  + cCRLF  
   cStrSQL += "          AND BQC_NUMCON = BA1_CONEMP "  + cCRLF   
   cStrSQL += "          AND BQC_VERCON = BA1_VERCON "  + cCRLF   
   cStrSQL += "          AND BQC_SUBCON = BA1_SUBCON "  + cCRLF   
   cStrSQL += "          AND BQC_VERSUB = BA1_VERSUB ) DESCRICAO "  + cCRLF  

   cStrSQL += "     , (SELECT Count(*) FROM "+RetSQLName("BA1") + " X  WHERE X.D_E_L_E_T_ = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_FILIAL = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_CODINT = B.BA1_CODINT " + cCRLF  
   cStrSQL += "           AND X.BA1_CODEMP = B.BA1_CODEMP " + cCRLF  
   cStrSQL += "           AND ((    X.BA1_DATINC < '"+ DtoS(_dDtIni) +"' AND  X.BA1_DATBLO = ' ' ) OR ( X.BA1_DATINC < '"+ DtoS(_dDtIni) +"' AND  X.BA1_DATBLO >= '"+ DtoS(_dDtIni) +"' )) " + cCRLF  
   cStrSQL += "           AND X.BA1_CONEMP = B.BA1_CONEMP " + cCRLF  
   cStrSQL += "           AND X.BA1_SUBCON = B.BA1_SUBCON ) MES_ANT " + cCRLF 

   cStrSQL += "     , (SELECT Count(*) FROM "+RetSQLName("BA1") + " X  WHERE X.D_E_L_E_T_ = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_FILIAL = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_CODINT = B.BA1_CODINT " + cCRLF  
   cStrSQL += "           AND X.BA1_CODEMP = B.BA1_CODEMP " + cCRLF  
   cStrSQL += "           AND X.BA1_DATBLO >= '"+ DtoS(_dDtIni) +"' AND X.BA1_DATBLO <= '"+ DtoS(_dDtFim) +"' " + cCRLF  
   cStrSQL += "           AND X.BA1_CONEMP = B.BA1_CONEMP " + cCRLF  
   cStrSQL += "           AND X.BA1_SUBCON = B.BA1_SUBCON  ) BLOQ " + cCRLF  
  
   cStrSQL += "     , (SELECT Count(*) FROM "+RetSQLName("BA1") + " X  WHERE X.D_E_L_E_T_ = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_FILIAL = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_CODINT = B.BA1_CODINT " + cCRLF  
   cStrSQL += "           AND X.BA1_CODEMP = B.BA1_CODEMP " + cCRLF  
   cStrSQL += "           AND X.BA1_DATINC >= '"+ DtoS(_dDtIni) +"' AND X.BA1_DATINC <= '"+ DtoS(_dDtFim) +"' " + cCRLF  
   cStrSQL += "           AND X.BA1_CONEMP = B.BA1_CONEMP " + cCRLF  
   cStrSQL += "           AND X.BA1_SUBCON = B.BA1_SUBCON  ) INCL " + cCRLF  

   cStrSQL += "     , (SELECT Count(*) FROM "+RetSQLName("BA1") + " X  WHERE X.D_E_L_E_T_ = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_FILIAL = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_CODINT = B.BA1_CODINT " + cCRLF  
   cStrSQL += "           AND X.BA1_CODEMP = B.BA1_CODEMP " + cCRLF  
   cStrSQL += "           AND ( (    X.BA1_DATINC <= '"+ DtoS(_dDtFim) +"' AND  X.BA1_DATBLO = ' ' ) OR ( X.BA1_DATINC <= '"+ DtoS(_dDtFim) +"' AND  X.BA1_DATBLO > '"+ DtoS(_dDtFim) +"' )) " + cCRLF  
   cStrSQL += "           AND X.BA1_CONEMP = B.BA1_CONEMP " + cCRLF  
   cStrSQL += "           AND X.BA1_SUBCON = B.BA1_SUBCON ) EFETIVO " + cCRLF  
   
   cStrSQL += "     , (SELECT Count(*) FROM "+RetSQLName("BA1") + " X  WHERE X.D_E_L_E_T_ = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_FILIAL = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_CODINT = B.BA1_CODINT " + cCRLF  
   cStrSQL += "           AND X.BA1_CODEMP = B.BA1_CODEMP " + cCRLF  
   cStrSQL += "           AND ((    X.BA1_DATINC <= '"+ DtoS(_dDtFim) +"' AND  X.BA1_DATBLO = ' ' ) OR ( X.BA1_DATINC <= '"+ DtoS(_dDtFim) +"' AND  X.BA1_DATBLO > '"+ DtoS(_dDtFim) +"' )) " + cCRLF  
   cStrSQL += "           AND X.BA1_CONEMP = B.BA1_CONEMP " + cCRLF  
   cStrSQL += "           AND X.BA1_TIPUSU = 'T' " + cCRLF  
   cStrSQL += "           AND X.BA1_SUBCON = B.BA1_SUBCON  ) TIT " + cCRLF  
   
   cStrSQL += "     , (SELECT Count(*) FROM "+RetSQLName("BA1") + " X  WHERE X.D_E_L_E_T_ = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_FILIAL = ' ' " + cCRLF  
   cStrSQL += "           AND X.BA1_CODINT = B.BA1_CODINT " + cCRLF  
   cStrSQL += "           AND X.BA1_CODEMP = B.BA1_CODEMP " + cCRLF  
   cStrSQL += "           AND ( (    X.BA1_DATINC <= '"+ DtoS(_dDtFim) +"' AND  X.BA1_DATBLO = ' ' ) OR ( X.BA1_DATINC <= '"+ DtoS(_dDtFim) +"' AND  X.BA1_DATBLO > '"+ DtoS(_dDtFim) +"' ) ) " + cCRLF  
   cStrSQL += "           AND X.BA1_CONEMP = B.BA1_CONEMP " + cCRLF  
   cStrSQL += "           AND X.BA1_TIPUSU IN ('D','A') " + cCRLF  
   cStrSQL += "           AND X.BA1_SUBCON = B.BA1_SUBCON  ) DEP " + cCRLF 
   
   cStrSQL += " FROM "+RetSQLName("BA1") + " B " + cCRLF  
   cStrSQL += " WHERE B.D_E_L_E_T_ = ' ' " + cCRLF  
   cStrSQL += "  AND BA1_FILIAL = ' ' " + cCRLF  
   cStrSQL += "  AND BA1_CODINT >= '"+mv_par01+"'         AND BA1_CODINT <= '"+mv_par02+"' " + cCRLF  
   cStrSQL += "  AND BA1_CODEMP >= '"+mv_par03+"'         AND BA1_CODEMP <= '"+mv_par04+"' " + cCRLF  
   cStrSQL += "  AND BA1_DATINC <= '"+ DtoS(_dDtIni) +"'  " + cCRLF  
   cStrSQL += "  AND BA1_CONEMP >= '"+mv_par05+"' AND BA1_CONEMP <= '"+mv_par06+"' " + cCRLF  
   cStrSQL += "  AND BA1_SUBCON >= '"+mv_par07+"'    AND BA1_SUBCON <= '"+mv_par08+"' " + cCRLF  
   cStrSQL += " ORDER BY 1,2,3,4,5  " + cCRLF    

   _dDtIni := CtoD(substr( DtoS(mv_par09),7,2) + "/"+ strzero(Month( _dDtIni + 32 ),2) + "/" + strzero(Year( _dDtIni + 32 ),4)   )  // if ( Month( _dDtIni )== 12, val(fdia[1]),val(fdia[Month( _dDtIni )+1]) )

   cStrSQL := ChangeQuery( cStrSQL )                            
   If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif
   dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL), "TRB", .T., .F.)                        

   while TRB->( !Eof() )
      lGerou := .T.   
	  aadd( aGrade, { TRB->PERIODO,TRB->OPERADORA,TRB->GRUPO,TRB->CONTRATO,TRB->SUBCONTRATO,TRB->DESCRICAO,TRB->MES_ANT,TRB->BLOQ,TRB->INCL,TRB->EFETIVO,TRB->TIT,TRB->DEP} )     
      TRB->( DbSkip() )
   enddo
   

Next
  

////////////////////////////////////////////////////////////////////////FINAL DA QUERY//////////////////

if lGerou

   cCabCSV := PADR("PERIODO"         ,008," ")+";"+;
              PADR("OPERADORA"       ,010," ")+";"+;
              PADR("GRUPO"           ,006," ")+";"+;
              PADR("CONTRATO"        ,013," ")+";"+;
              PADR("SUBCONTRATO"     ,012," ")+";"+;
              PADR("DESCRICAO"       ,040," ")+";"+;
              PADR("MES_ANT"         ,007," ")+";"+;
              PADR("BLOQ"            ,006," ")+";"+;
              PADR("INCL"            ,006," ")+";"+;                        
              PADR("EFETIVO"         ,007," ")+";"+;
              PADR("TIT"             ,006," ")+";"+;
              PADR("DEP"             ,006," ")    

	   _lCabec := .F.
       FWrite(nHandle, cCabCSV) ; FWrite(nHandle, cCRLF)

   cPeriodo := aGrade[1][1]
   FOR WW := 1 TO LEN( aGrade)

       IF aGrade[WW][1] <> cPeriodo .and. WW <= LEN( aGrade )
          cBuffer :=  PADR("" ,008,"=")+";"+;
                      PADR("" ,010,"=")+";"+;
                      PADR("" ,006,"=")+";"+;
                      PADR("" ,013,"=")+";"+;
                      PADR("" ,012,"=")+";"+;
                      PADR("" ,040,"=")+";"+;
                      PADR("" ,007,"=")+";"+;
                      PADR("" ,006,"=")+";"+;
                      PADR("" ,006,"=")+";"+;                        
                      PADR("" ,007,"=")+";"+;
                      PADR("" ,006,"=")+";"+;
                      PADR("" ,006,"=")  			       
          FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)
  
          cTotais :=  PADR(" " ,008," ")+";"+;
                      PADR(" " ,010," ")+";"+;
                      PADR(" " ,006," ")+";"+;
                      PADR(" " ,013," ")+";"+;
                      PADR("Somatorio" ,012," ")+";"+;
                      PADR(" " ,040," ")+";"+;
                      PADR(TRANSFORM(nMES_ANT,"@999999")   ,007," ")+";"+;
                      PADR(TRANSFORM(nBLOQ,"@999999")      ,006," ")+";"+;
                      PADR(TRANSFORM(nINCL,"@999999")      ,006," ")+";"+;                        
                      PADR(TRANSFORM(nEFETIVO,"@999999")   ,007," ")+";"+;
                      PADR(TRANSFORM(nTIT,"@999999")       ,006," ")+";"+;
                      PADR(TRANSFORM(nDEP,"@999999")       ,006," ")  			       
          FWrite(nHandle, cTotais) ; FWrite(nHandle, cCRLF) 

          nMES_ANT    := 0
          nBLOQ       := 0
          nINCL       := 0
          nEFETIVO    := 0
          nTIT        := 0
          nDEP        := 0
       
          cPERIODO    := aGrade[WW][1]
       
          FWrite(nHandle, " ") ; FWrite(nHandle, cCRLF)
       
       endif
 
 
       cBuffer :=  PADR("'"+aGrade[WW][1],008," ")+";"+;
                   PADR("'"+aGrade[WW][2],010," ")+";"+;
                   PADR("'"+aGrade[WW][3],006," ")+";"+;
                   PADR("'"+aGrade[WW][4],013," ")+";"+;
                   PADR("'"+aGrade[WW][5],012," ")+";"+;
                   PADR(aGrade[WW][6]    ,040," ")+";"+;
                   PADR(aGrade[WW][7]    ,007," ")+";"+;
                   PADR(aGrade[WW][8]    ,006," ")+";"+;
                   PADR(aGrade[WW][9]    ,006," ")+";"+;                        
                   PADR(aGrade[WW][10]   ,007," ")+";"+;
                   PADR(aGrade[WW][11]   ,006," ")+";"+;
                   PADR(aGrade[WW][12]   ,006," ") 
  
       FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)   
       
       nConta ++
       nMES_ANT    += aGrade[WW][7]
       nBLOQ       += aGrade[WW][8]
       nINCL       += aGrade[WW][9]
       nEFETIVO    += aGrade[WW][10]
       nTIT        += aGrade[WW][11]
       nDEP        += aGrade[WW][12]

       IF WW = LEN( aGrade ) // Este ultimo bloco e´para fechar a totalização da ultima linha ...
          cBuffer :=  PADR("" ,008,"=")+";"+;
                      PADR("" ,010,"=")+";"+;
                      PADR("" ,006,"=")+";"+;
                      PADR("" ,013,"=")+";"+;
                      PADR("" ,012,"=")+";"+;
                      PADR("" ,040,"=")+";"+;
                      PADR("" ,007,"=")+";"+;
                      PADR("" ,006,"=")+";"+;
                      PADR("" ,006,"=")+";"+;                        
                      PADR("" ,007,"=")+";"+;
                      PADR("" ,006,"=")+";"+;
                      PADR("" ,006,"=")  			       
          FWrite(nHandle, cBuffer) ; FWrite(nHandle, cCRLF)
  
          cTotais :=  PADR(" " ,008," ")+";"+;
                      PADR(" " ,010," ")+";"+;
                      PADR(" " ,006," ")+";"+;
                      PADR(" " ,013," ")+";"+;
                      PADR("Somatorio" ,012," ")+";"+;
                      PADR(" " ,040," ")+";"+;
                      PADR(TRANSFORM(nMES_ANT,"@999999")   ,007," ")+";"+;
                      PADR(TRANSFORM(nBLOQ,"@999999")      ,006," ")+";"+;
                      PADR(TRANSFORM(nINCL,"@999999")      ,006," ")+";"+;                        
                      PADR(TRANSFORM(nEFETIVO,"@999999")   ,007," ")+";"+;
                      PADR(TRANSFORM(nTIT,"@999999")       ,006," ")+";"+;
                      PADR(TRANSFORM(nDEP,"@999999")       ,006," ")  			       
          FWrite(nHandle, cTotais) ; FWrite(nHandle, cCRLF) 

          nMES_ANT    := 0
          nBLOQ       := 0
          nINCL       := 0
          nEFETIVO    := 0
          nTIT        := 0
          nDEP        := 0

          FWrite(nHandle, " ") ; FWrite(nHandle, cCRLF)
       
       endif
  
   
   NEXT

   FWrite(nHandle, " ") ; FWrite(nHandle, cCRLF)     
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
|  09 |  Data Inicial ?               |  mv_ch9 |  
|  10 |  Quantos meses à frente ?     |  mv_ch0 |  
|  11 |                               |  mv_cha |  
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
aadd(aRegs,{cPerg,"09","Data Inicial ?              ","","","mv_ch9","D", 8,0,0,"G","","mv_par09",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","",""      ,""})
aadd(aRegs,{cPerg,"10","Quantos meses à frente ?    ","","","mv_ch0","N", 2,0,0,"G","","mv_par10",""   ,"","","","",""   ,"","","","",""     ,"","","","","","","","","","","","","",""      ,""})

//aadd(aRegs,{cPerg,"11","Bloqueados ?                ","","","mv_cha","N", 1,0,0,"C","","mv_par11","Sim","","","","","Nao","","","","","Ambos","","","","","","","","","","","","","",""      ,""})

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



// Fim do CABR158.PRW
