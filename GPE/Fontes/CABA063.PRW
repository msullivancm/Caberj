/******************************************************************************************************************
 **** Programa....: CABA063  																				   ****
 **** Tipo........: ROTINA DE INTEGRACAO DO FATURAMENTO (PLS) PARA A FOLHA (GPE - Tabela SRC)                  ****
 **** Autor.......: Otavio Pinto                                                                               ****
 **** Criacao.....: 09/05/2012                                                                                 ****
 **** Modificado..:                                                                                            ****
 **** Alteracao...:                                                                                            ****	
 **** Solicitante.: Flavio Oliveira                                                                            ****
 **** Modulo......: GPE - Gestao de Pessoal  																   ****
 **** Chamada.....: Miscelanea >> Calculos >> Integracao PLS x GPE >> Caberj                                   ****
 **** Objetivo....: Exportar dados referentes à Assistencia Medica do PLS para GPE                             ****
 ******************************************************************************************************************/

#include "rwmake.ch" 

user Function CABA063()

private cArqSaida := ""
private cPerg     := "CABA063"   

private cCnt01    := GetMv("MV_CABINTE")
private cStrSQL   := ""

private cEnter    := CHR(13)+CHR(10)
private nLin      := 0
private nCol1     := 150
private _nContSRC := 0 
private _nContRHO := 0
private nHandle     
private cBuffer

ValidPerg()

Pergunte(cPerg,.F.) 

@ 200,001 To 380,430 Dialog oDlg Title OemToAnsi("CABERJ - ROTINA DE INTEGRACAO COM A FOLHA")
@ 002,010 To 060,200
@ 10,017 Say OemToAnsi("             <<<<<   CABERJ - INTEGRACAO COM A FOLHA   >>>>>            ")
@ 18,017 Say OemToAnsi("Esta rotina integra dados do PLS, com informacoes de Assistencia Medica:")
@ 26,017 Say OemToAnsi("Mensalidades, Coparticipacao, Odontologico e Mens.Retroativa com GPE.   ")

@ 70,095 BmpButton Type 01 Action Processa({|| FGeraArq() },"Integracao/Consulta","Processando ...")
@ 70,135 BmpButton Type 02 Action Close(oDlg)          // Cancela
@ 70,175 BmpButton Type 05 Action Pergunte(cPerg,.T.)  // Parametros

Activate Dialog oDlg Centered

Return

/*-----------------------------------------------------------------------*
* Funcao | FGeraArq   | Autor | Otavio Pinto         | Data | 09/02/2012 *
*------------------------------------------------------------------------*
* Objetivo | Gerar a arquivo                                             *
*------------------------------------------------------------------------*/
static function FGeraArq()

Local _lCabec       := .T.	

private _cPath		:= Alltrim(cCnt01)+if(right(AllTrim(cCnt01),1) <> "\","\","" )            // "C:\TEMP\"
private oAbrArq 
private _nCont      := 0 
private _nTotal     := 0
private    cArq     := _cPath+"DESPMEDI.csv" 
private _cDeli      := If( mv_par06 == 1,";"," ")
private _lGerou     := .F. 

//+---------------------------------------------------------------------+
//| Monta o nome do arquivo de saida conforme parametro (Serie)         |
//+---------------------------------------------------------------------+

begin sequence 

if !SM0->M0_CODIGO $ "01,02"
   Msgbox("Empresas permitidas {'01','02'}... Verifique!","Atencao","STOP")
   break  
elseif Lastkey()==27   
   break
endif

if mv_par05 == 2 .and. mv_par06 == 2
   Msgbox("Nada a ser processado... verifique os parametros !","Atencao")
   break  
endif

/*
+---------------------------------------------------------+
| PARAMETROS UTILIZADOS                                   |
+---------------------------------------------------------+
|  01  |  Data Pagamento (SRC)| mv_par01 | 30/06/12       |
|  02  |  Operadora           | mv_par02 | 0001           |
|  03  |  Empresa             | mv_par03 | 0003           |
|  04  |  Prefixo             | mv_par04 | PLS            |
|  05  |  Integra Folha       | mv_par05 | SIM            |
|  06  |  Consultar em Excel  | mv_par06 | SIM            |
|  07  |  Informe Num.Lote    | mv_par07 | 000100016562   |
+---------------------------------------------------------+
*/

dbSelectArea("SRC") ; dbSetOrder(1) //RC_FILIAL+RC_MAT+RC_PD+RC_CC+RC_SEMANA+RC_SEQ
 
if mv_par06 == 1 // Consulta Excel ?                                                        
   //+---------------------------------------------------------------------+
   //| Gera planilha com dados das tabelas BM1 ,BBT e SRA                  |
   //+---------------------------------------------------------------------+  
   if FRelat( cArq )
      oExcelApp := MsExcel():New()
      oExcelApp:WorkBooks:Open( &("cArq" ) ) // Abre uma planilha
      oExcelApp:SetVisible(.T.)              
   endif   
endif   

if mv_par05 == 1 // Integra a Folha ?
   //+---------------------------------------------------------------------+
   //| Faz a integração com a Folha (SRC - Movimentos mensais)             |
   //+---------------------------------------------------------------------+  
   //_nTotal := FGrvSRC()
   _nTotal := FGrvRGB()
endif   

//+---------------------------------------------------------------------+
//| Verifica se houve geracao                                           |
//+---------------------------------------------------------------------+  
if mv_par05 == 1 .AND. _nTotal > 0  
   MsgAlert( "Integrado"+if( _nTotal > 1,"s "," ") + alltrim(str(_nTotal)) + " registro"+if( _nTotal > 1,"s "," ")+" na FOLHA !!! "  )   
elseif mv_par05 == 1 .AND. _nTotal = 0  
   MsgAlert( "Nada foi Integrado... Verifique !!" )   
endif   
  _nTotal := _nCont := 0            

//+---------------------------------------------------------------------+
//| Fecha Arquivo Temporario...                                         |
//+---------------------------------------------------------------------+
If Select("TRAB") > 0 ; dbSelectArea("TRAB") ; TRAB->( dbCloseArea() ) ; Endif 

End sequence
FClose( nHandle ) 
//+---------------------------------------------------------------------+
//| Se impressao em disco, chama o gerenciador de impressao...          |
//+---------------------------------------------------------------------+

dbCommitAll()
SET PRINTER TO

MS_FLUSH()

Close(oDlg)
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
Static Function Parse(cFrase, cDelimit)
Local LocaVar1, LocaVar2
IF (PCOUNT() < 2) ; cDelimit:= [,] ; ENDIF
LocaVar2:= AT(cDelimit, cFrase)
IF (LocaVar2 > 0)
   LocaVar1:= Left(cFrase, LocaVar2 - 1)
   cFrase  := Subs(cFrase, LocaVar2 + LEN(cDelimit))
Else
   LocaVar1:= cFrase
   cFrase  := ""
Endif
Return LocaVar1

/*--------------------------------------------------------------------------*
* Funcao | ParseHoriz    | Autor | Otavio Pinto          | Data | 31/01/2011*
*---------------------------------------------------------------------------*
* Descricao: Retorna a string na horizontal com aspas.                      *
*            Informar no parametro as strings, separadas por um delimitador *
*            Exemplo:                                                       *
*                     Parametro: DUP,NF                                     *
*                     Retorno  : ('DUP','NF')                               *
*---------------------------------------------------------------------------*/
Static Function ParseHoriz(cCodigo)
private _cTexto := "("
   cCodigo  := Alltrim( cCodigo )        
   while LEN(cCodigo)>0
      _cTexto := _cTexto + ( "'"+PARSE(@cCodigo,',')+"'"+iif( LEN(cCodigo)>0,",","") )
   Enddo                                   
   _cTexto := _cTexto + ")"
Return Alltrim(_cTexto)

/*--------------------------------------------------------------------------*
* Funcao | FGrvSRC      | Autor | Otavio Pinto           | Data | 22/03/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Objetivo desta funcao e' gravar no SRC.          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FGrvSRC()
FQuery()

If Select("TRAB") > 0 ; dbSelectArea("TRAB") ; TRAB->( dbCloseArea() ) ; Endif
//+----------------------------------------------------------------+
//| Cria tabela temporaria conforme Query                          |
//+----------------------------------------------------------------+
dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL ),"TRAB" , .T., .F.)
dbSelectArea("TRAB" )
ProcRegua( TRAB->( RecCount() ) )
TRAB->( dbGoTop() )
// Varre o TMP ate o final do arquivo
_nCont := 0
Do While TRAB->( !Eof() ) 

   IncProc( TRAB->FILIAL+" "+TRAB->MATRICULA )
   
   IF TRAB->( Alltrim(SITUACAO) <> "D"  .OR. ( Alltrim(SITUACAO)== "A"  .AND. Alltrim(AFASTAM) $",6,7,8,B,F,Q,Z,ZZ" )   )

      // Se encontrar no SRC, ATUALIZA, senao, INCLUI ...
      lForma := SRC->( dbSeek( TRAB->(ALLTRIM(FILIAL)+ALLTRIM(MATRICULA)+ALLTRIM(VERBA)+ALLTRIM(CCUSTO)) ) )
      _nCont ++      

      If !lForma          
         RecLock( "SRC" , .T. )
         SRC->RC_FILIAL := TRAB->FILIAL
         SRC->RC_MAT    := AllTrim(TRAB->MATRICULA)
         SRC->RC_PD     := TRAB->VERBA
         SRC->RC_TIPO1  := TRAB->TIPO1                                                             
         SRC->RC_VALOR  := TRAB->VALOR
         SRC->RC_TIPO2  := TRAB->TIPO2
         SRC->RC_DATA   := CTOD( Substr(TRAB->DTPGTO,7,2)+"/"+Substr(TRAB->DTPGTO,5,2)+"/"+Substr(TRAB->DTPGTO,1,4) )
         SRC->RC_CC     := TRAB->CCUSTO
         SRC->RC_SEQ    := '1'			            
         SRC->RC_CODB1T := TRAB->CODBBT 
         SRC->RC_PLNUCO := TRAB->PLNUCO          
      Else                            
       * IF SRC->(RC_PLNUCO+RC_CODB1T) <> TRAB->( PLNUCO+CODBBT ) 
       *    RecLock( "SRC" , .T. )
       *    _nCont ++      
       *    SRC->RC_FILIAL := TRAB->FILIAL
       *    SRC->RC_MAT    := AllTrim(TRAB->MATRICULA)
       *    SRC->RC_PD     := TRAB->VERBA
       *    SRC->RC_TIPO1  := TRAB->TIPO1
       *    SRC->RC_VALOR  := TRAB->VALOR
       *    SRC->RC_TIPO2  := TRAB->TIPO2
       *    SRC->RC_DATA   := CTOD( Substr(TRAB->DTPGTO,7,2)+"/"+Substr(TRAB->DTPGTO,5,2)+"/"+Substr(TRAB->DTPGTO,1,4) )
       *    SRC->RC_CC     := TRAB->CCUSTO
       *    SRC->RC_SEQ    := strzero(VAL(strzero(val(SRC->RC_SEQ),1)) + 1,1) 
       *    SRC->RC_CODB1T := TRAB->CODBBT 
       *    SRC->RC_PLNUCO := TRAB->PLNUCO         
       * else                                   
            RecLock( "SRC" , .F. )
            SRC->RC_DATA   := CTOD( Substr(TRAB->DTPGTO,7,2)+"/"+Substr(TRAB->DTPGTO,5,2)+"/"+Substr(TRAB->DTPGTO,1,4) )                                 
            SRC->RC_VALOR  += TRAB->VALOR           
           *SRC->RC_SEQ    := strzero(VAL(strzero(val(SRC->RC_SEQ),1)) + 1,1) 
            SRC->RC_CODB1T := TRAB->CODBBT 
            SRC->RC_PLNUCO := TRAB->PLNUCO                    
       * endif   
      endif   
      SRC->( MsUnLock() )
      
   endif
   TRAB->( dbSkip() )
Enddo                                    

//+---------------------------------------------------------------------+
//| Fecha Arquivo Temporario...                                         |
//+---------------------------------------------------------------------+
If Select("TRAB") > 0 ; dbSelectArea("TRAB") ; TRAB->( dbCloseArea() ) ; Endif
Return _nCont
                                               

/*--------------------------------------------------------------------------*
* Funcao | FGravaRHO    | Autor | Otavio Pinto           | Data | 22/03/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Objetivo desta funcao e' gravar no SRC.          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FGravaRHO()

ProcRegua( TRAB->( RecCount() ) )
TRAB->( dbGotop() )
// Varre o TMP ate o final do arquivo
Do While TRAB->( !Eof() ) 

   IncProc( TRAB->FILIAL+" "+TRAB->MATRICULA )
   IF TRAB->TIPO3 == 'C'
      // Se encontrar no SRC, ATUALIZA, senao, INCLUI ...
      lForma := RHO->( dbSeek( TRAB->(FILIAL+MATRICULA+DTPGTO) ) ) // RHO_FILIAL+RHO_MAT+DTOS(RHO_DTOCOR)

      RecLock( "RHO" , !lForma )
      _nContRHO ++
      If !lForma          
         RHO->RHO_FILIAL := TRAB->FILIAL
         RHO->RHO_MAT    := AllTrim(TRAB->MATRICULA)
         RHO->RHO_DTOCOR := CTOD( Substr(TRAB->DTPGTO,7,2)+"/"+Substr(TRAB->DTPGTO,5,2)+"/"+Substr(TRAB->DTPGTO,1,4) )		 
         RHO->RHO_ORIGEM := '1'
         RHO->RHO_TPFORN := '1' 
         RHO->RHO_CODFOR := TRAB->CODFOR //'001'
         RHO->RHO_CODIGO := TRAB->SEQ    //'02'
         RHO->RHO_TPLAN  := '1'
         RHO->RHO_PD     := TRAB->VERBA
         RHO->RHO_VLRFUN := TRAB->VALOR
         RHO->RHO_VLREMP := 0.00                       
         RHO->RHO_COMPPG := if(empty(mv_par12),strzero(year(dDatabase),4)+strzero(month(dDatabase),2),mv_par12)   //'201201' 
         RHO->RHO_OBSERV := "DESCRICAO DE OBSERVACAO TESTE"                                                                                                             
      Else
         RHO->RHO_DTOCOR := CTOD( Substr(TRAB->DTPGTO,7,2)+"/"+Substr(TRAB->DTPGTO,5,2)+"/"+Substr(TRAB->DTPGTO,1,4) )		 
         RHO->RHO_VLRFUN := TRAB->VALOR
      Endif      
      RHO->( MsUnLock() )
   ENDIF
   TRAB->( dbSkip() )
Enddo  
Return 

/*--------------------------------------------------------------------------*
* Funcao | FGrvRGB      | Autor | Fabio Bianchini        | Data | 23/05/2019*
*---------------------------------------------------------------------------*
* Descricao: Objetivo desta funcao e' gravar no RGB.			            *
*            Exemplo de retorno:                                            *
*---------------------------------------------------------------------------*/
Static Function FGrvRGB()
FQuery()

If Select("TRAB") > 0 ; dbSelectArea("TRAB") ; TRAB->( dbCloseArea() ) ; Endif
//+----------------------------------------------------------------+
//| Cria tabela temporaria conforme Query                          |
//+----------------------------------------------------------------+
dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL ),"TRAB" , .T., .F.)
dbSelectArea("TRAB" )
ProcRegua( TRAB->( RecCount() ) )
TRAB->( dbGoTop() )
// Varre o TMP ate o final do arquivo
_nCont := 0
Do While TRAB->( !Eof() ) 

   IncProc( TRAB->FILIAL+" "+TRAB->MATRICULA )
   
   IF TRAB->( Alltrim(SITUACAO) <> "D"  .OR. ( Alltrim(SITUACAO)== "A"  .AND. Alltrim(AFASTAM) $",6,7,8,B,F,Q,Z,ZZ" )   )

      // Se encontrar no RGB, ATUALIZA, senao, INCLUI ...
      DbSelectArea("RGB")
      DbSetOrder(8) //rgb_filial + rgb_pd + rgb_proces + rgb_period + rgb_roteir + rgb_mat

      lForma := dbSeek( AllTrim(TRAB->FILIAL) + AllTrim(TRAB->VERBA) + '00001' + DTOS(mv_par01) + 'FOL' + AllTrim(TRAB->MATRICULA) )  
      _nCont ++      

      If !lForma          
        RecLock( "RGB" , .T. )
		RGB->RGB_FILIAL := xFilial("RGB")
		RGB->RGB_PROCES := '00001'
		RGB->RGB_PERIOD := DTOS(mv_par01)
		RGB->RGB_SEMANA := '01'
		RGB->RGB_ROTEIR := 'FOL'
		RGB->RGB_MAT 	:= AllTrim(TRAB->MATRICULA)
		RGB->RGB_PD 	:= TRAB->VERBA
		RGB->RGB_TIPO1 	:= TRAB->TIPO1
		RGB->RGB_QTDSEM := 0
		RGB->RGB_HORAS 	:= 0
		RGB->RGB_VALOR 	:= NoRound(TRAB->VALOR,2)
		RGB->RGB_CC 	:= AllTrim(TRAB->CCUSTO)
		RGB->RGB_PARCEL := 0
		RGB->RGB_TIPO2 	:= TRAB->TIPO2
		RGB->RGB_SEQ    := '1'
		RGB->RGB_CODFUN := TRAB->CODFUNC
		RGB->RGB_DUM 	:= 0
		RGB->RGB_DDOIS 	:= 0
		RGB->RGB_DTRES 	:= 0
		RGB->RGB_DQUATR := 0
		RGB->RGB_DCINCO := 0
		RGB->RGB_DSEIS 	:= 0
		RGB->RGB_DSETE 	:= 0
		RGB->RGB_DTREF 	:= Date()  
	  Else
		RGB->RGB_TIPO1 	:= TRAB->TIPO1
		RGB->RGB_VALOR 	:= NoRound(TRAB->VALOR,2)
		RGB->RGB_CC 	:= AllTrim(TRAB->CCUSTO)
		RGB->RGB_TIPO2 	:= TRAB->TIPO2
		RGB->RGB_CODFUN := TRAB->CODFUNC
		RGB->RGB_DTREF 	:= Date()  	  	
      Endif   
      RGB->( MsUnLock() )
      
   endif
   TRAB->( DbSkip() )
Enddo                                    

//+---------------------------------------------------------------------+
//| Fecha Arquivo Temporario...                                         |
//+---------------------------------------------------------------------+
If Select("TRAB") > 0 ; dbSelectArea("TRAB") ; TRAB->( dbCloseArea() ) ; Endif

Return _nCont

/*--------------------------------------------------------------------------*
* Funcao | FRelat       | Autor | Otavio Pinto           | Data | 22/03/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Gera relatorio em excel                          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FRelat( _cArq )
local   lRet     := .F.
private _cSqlQry := ""

begin sequence          

If File( _cArq ) ; FErase( _cArq ) ; Endif     

nHandle := FCreate( _cArq )

if nHandle == -1
   MsgAlert("O arquivo "+AllTrim( _cArq )+" nao pode ser criado! Verifique os parametros.","Atencao !")  
   break
endif                     

If Select("TRAB") > 0 ; dbSelectArea("TRAB") ; TRAB->( dbCloseArea() ) ; Endif

 _cSqlQry := FQuery()

//+----------------------------------------------------------------+
//| Cria tabela temporaria conforme Query                          |
//+----------------------------------------------------------------+
dbUseArea ( .T. , "TOPCONN", TcGenQry( ,, _cSqlQry ), "TRAB" , .T. , .F. )

dbSelectArea("TRAB" )

ProcRegua( TRAB->( RecCount() ) )

TRAB->( dbGoTop() )
//+----------------------------------------------------------------+
//| Se tabela TRAB retornar VAZIO, não gera resumo e exibe mensagem |
//+----------------------------------------------------------------+
if TRAB->( !Eof() )
   _nConta  := 0
   _cCabec  := PADR("FILIAL",6," ")+_cDeli+;
               PADR("MATRICULA",9," ")+_cDeli+;
               PADR("VERBA",5," ")+_cDeli+;
               PADR("TIPO1",5," ")+_cDeli+;
               PADL("VALOR",13," ")+_cDeli+;
               PADR("TIPO2",5," ")+_cDeli+;
               PADR("CCUSTO",9," ")+_cDeli+;
               PADR("DATA",12," ")+_cDeli+;
               PADR("SITUACAO",8,"")+_cDeli+; 
               PADR("AFASTAM",7," ")+_cDeli+;                
               PADR("DESCRICAO",60," ")+_cDeli+; 
               PADR("CODBBT",13," ")+_cDeli+;                
               PADR("PLNUCO",13," ")+_cDeli+;                
               PADR("TITULO",16," ")+_cDeli			   

   nCol1 := len(_cCabec) + 1  

   cBuffer :=  PADR( _cCabec ,nCol1,"") + cEnter	 
   FWrite(nHandle, cBuffer)

   while TRAB->( !Eof() )
      lRet := .T.
      _cLinha := TRAB->(PADR( If( mv_par06 == 1,"'","") +FILIAL,6," ")+_cDeli+""+;
                        PADR( If( mv_par06 == 1,"'","")  +MATRICULA,9," ")+_cDeli+""+;
                        PADR( VERBA,5," ")+_cDeli+""+;
                        PADR( TIPO1,5," ")+_cDeli+""+;
                        PADL( Strtran (Str(VALOR,13,2),".",","),13," ")+_cDeli+""+;
                        PADR( TIPO2,5," ")+_cDeli+""+;
                        PADR( CCUSTO,9," ")+_cDeli+" "+;
                        PADR( substr(DTPGTO,7,2)+"/"+substr(DTPGTO,5,2)+"/"+substr(DTPGTO,1,4),10," ") +_cDeli+""+;
                        PADR( Alltrim(SITUACAO),1,"") +_cDeli+""+;
                        PADR( AFASTAM,1,"")+_cDeli+" "+; 
                        PADR( DESCRICAO,60,"")+_cDeli+" "+;      
                        PADR( If( mv_par06 == 1,"'","")  +CODBBT,13,"")+_cDeli+" "+;   
                        PADR( If( mv_par06 == 1,"'","")  +PLNUCO,13,"")+_cDeli+" "+;   
                        PADR( TITULO,16,"")+_cDeli                             )						

      IncProc()
      _nConta ++    
      cBuffer :=  PADR( _cLinha ,nCol1,"") + cEnter	                                                         
      FWrite(nHandle, cBuffer)                                         
      TRAB->( DbSkip() )               	
      if TRAB->( eof() )
         //+---------------------------------------------------------------------+
         //| Finaliza a listagem                                                 |
         //+---------------------------------------------------------------------+
         cBuffer := "Fim "
         FWrite(nHandle, cBuffer)
      endif
   ENDDO          
endif   
//+---------------------------------------------------------------------+
//| Finaliza a execucao do relatorio...                                 |
//+---------------------------------------------------------------------+
FClose(nHandle)


if !lRet
    MsgAlert("DESP.MED.EMPRESARIAL - Nao ha registro(s) a ser(em) listado(s) ou integrado(s) !!!")         
endif

end sequence
Return lRet


/*--------------------------------------------------------------------------*
* Funcao | FQuery       | Autor | Otavio Pinto           | Data | 09/04/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Querys para apuração das informacoes.            *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FQuery()
local lRet     := .F.   
local _aArea   := GetArea()
local lCase    := .F.          
           

   //+-------------------------------------------------------------------------------------------------------+
   //| Query de PARCELAMENTO DESPESA MEDICA - Mater Empresarial                                              |
   //| xx.0x.2012 - Homologado pelo Flavio Oliveira,                                                         |   
   //|                                                                                                       |      
   //+-------------------------------------------------------------------------------------------------------+

   cStrSQL  := "SELECT '01'       FILIAL " + cEnter
   cStrSQL  += "     , BM1_AGMTFU MATRICULA " + cEnter  
   cStrSQL  += "     , RA_NOME NOME  "     + cEnter  
   cStrSQL  += "     , RA_CODFUNC CODFUNC  "  + cEnter 
     
   //---------------------------------------------------- Montagem dos relacionamentos de VERBAS X CODTIP
   // Em 24/09/2014 - OSP
   dbSelectARea("ZRC") ;  ("ZRC")->( dbSetOrder(1) )
   ("ZRC")->( dbGoTop() )   
   if ("ZRC")->( !Eof() )                            
      cStrSQL  += "     , CASE "                   
      lCase    := .T.
   endif   
   while  ("ZRC")->( !Eof() )

      cStrSQL  += " WHEN " + ("ZRC")->( Alltrim(ZRC_FORMUL) + IF(!Empty(("ZRC")->ZRC_FORMUL)," AND ", "" ) + " BM1_CODTIP IN " + ParseHoriz( ("ZRC")->ZRC_CODTIP) ) + " THEN '"+ ("ZRC")->ZRC_PD +"' " + cEnter 

      ("ZRC")->( dbSkip() )
   enddo
   RestArea(_aArea)

   if lCase
      cStrSQL  += "       end       VERBA " + cEnter 
   endif
   //---------------------------------------------------- Fim da Montagem dos relacionamentos de VERBAS X CODTIP
   
   cStrSQL  += "     , 'V'        TIPO1 " + cEnter
   cStrSQL  += "     , SUM( BM1_VALOR )  VALOR " + cEnter
   cStrSQL  += "     , RA_CC      CCUSTO " + cEnter
   cStrSQL  += "     , 'I'        TIPO2 " + cEnter
   cStrSQL  += "     , '"+DTOS(mv_par01)+"' DTPGTO " + cEnter
   cStrSQL  += "     , RA_SITFOLH SITUACAO " + cEnter
   cStrSQL  += "     , CASE WHEN RA_SITFOLH = 'A' THEN RA_AFASFGT " + cEnter
   cStrSQL  += "            ELSE " + cEnter
   cStrSQL  += "               ' ' " + cEnter
   cStrSQL  += "            END     AFASTAM " + cEnter
   cStrSQL  += "     , CASE WHEN RA_SITFOLH = 'A' THEN (SELECT X5_DESCRI FROM SIGA.SX5010 WHERE D_E_L_E_T_ = ' ' AND X5_TABELA||X5_CHAVE = '30'||RA_AFASFGT) " + cEnter
   cStrSQL  += "            ELSE " + cEnter
   cStrSQL  += "               decode(RA_SITFOLH,' ','Normal','D','Desligado','F','Ferias','A','Afastado') " + cEnter
   cStrSQL  += "            END     DESCRICAO " + cEnter

   cStrSQL  += "     , BBT_CODIGO CODBBT " + cEnter
   cStrSQL  += "     , BM1_PLNUCO PLNUCO " + cEnter
   
   // Solicitado por Paulo Motta Em 17/12/2013 - OSP 
   cStrSQL  += "     , BM1_PREFIX||BM1_NUMTIT||BM1_PARCEL||BM1_TIPTIT TITULO " + cEnter
   
   cStrSQL  += "FROM SIGA.BBT010 BBT " + cEnter
   cStrSQL  += "   , SIGA.BM1010 BM1 " + cEnter
   cStrSQL  += "   , SIGA.SRA010 SRA " + cEnter

   cStrSQL  += "WHERE BBT.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL  += "  AND BM1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL  += "  AND SRA.D_E_L_E_T_ = ' ' " + cEnter

   cStrSQL  += "  AND BBT_FILIAL     = ' ' " + cEnter
   cStrSQL  += "  AND BBT_NIVEL      = '4' " + cEnter
   cStrSQL  += "  AND BBT_CODOPE     = '"+mv_par02+"' " + cEnter
   cStrSQL  += "  AND BBT_CODEMP     = '"+mv_par03+"' " + cEnter
   cStrSQL  += "  AND BM1_PLNUCO     = '"+mv_par07+"' " + cEnter

   cStrSQL  += "  AND BM1_FILIAL     = BBT_FILIAL " + cEnter
   cStrSQL  += "  AND BM1_CODINT     = BBT_CODOPE " + cEnter
   cStrSQL  += "  AND BM1_CODEMP     = BBT_CODEMP " + cEnter
   cStrSQL  += "  AND BM1_MATRIC     = BBT_MATRIC " + cEnter
   cStrSQL  += "  AND BM1_ANO        = BBT_ANOTIT " + cEnter
   cStrSQL  += "  AND BM1_MES        = BBT_MESTIT " + cEnter
   cStrSQL  += "  AND BM1_PREFIX     = '"+mv_par04+"' " + cEnter
   cStrSQL  += "  AND BM1_TIPTIT     = 'DP ' " + cEnter
   cStrSQL  += "  AND BM1_PLNUCO     = BBT_NUMCOB " + cEnter                                    

   cStrSQL  += "  AND BM1_NUMTIT     = BBT_NUMTIT " + cEnter 
                                                                  
   cStrSQL  += "  AND RA_FILIAL      = '01' " + cEnter
   
   //cStrSQL  += "  AND RA_MAT         = SubStr( ( SELECT BA1_MATEMP " + cEnter 
   //cStrSQL  += "                                 FROM   BA1010 BA1 " + cEnter
   //cStrSQL  += "                                 WHERE  BA1.D_E_L_E_T_ = ' ' " + cEnter
   //cStrSQL  += "                                   AND  BA1_CODINT     = BM1_CODINT " + cEnter
   //cStrSQL  += "                                   AND  BA1_CODEMP     = BM1_CODEMP " + cEnter
   //cStrSQL  += "                                   AND  BA1_MATRIC     = BM1_MATRIC " + cEnter
   //cStrSQL  += "                                   AND  BA1_TIPREG     = BM1_TIPREG " + cEnter
   //cStrSQL  += "                                   AND  BA1_DIGITO     = BM1_DIGITO ) ,1,6) " + cEnter

   cStrSQL  += "  AND RA_MAT         = SubStr(BM1_AGMTFU,1,6) " + cEnter 

   cStrSQL  += "GROUP BY '01',BM1_AGMTFU, RA_NOME, RA_CODFUNC, 
   
   // INICIO - 11/12/18 - Mateus Medeiros - GLPI 54785
   dbSelectARea("ZRC") ;  ("ZRC")->( dbSetOrder(1) )
   ("ZRC")->( dbGoTop() )   
   if ("ZRC")->( !Eof() )                            
      cStrSQL  += "     CASE "                   
      lCase    := .T.
   endif   
   while  ("ZRC")->( !Eof() )

      cStrSQL  += " WHEN " + ("ZRC")->( Alltrim(ZRC_FORMUL) + IF(!Empty(("ZRC")->ZRC_FORMUL)," AND ", "" ) + " BM1_CODTIP IN " + ParseHoriz( ("ZRC")->ZRC_CODTIP) ) + " THEN '"+ ("ZRC")->ZRC_PD +"' " + cEnter 

      ("ZRC")->( dbSkip() )
   enddo
   RestArea(_aArea)
	
   if lCase
      cStrSQL  += "       end, " + cEnter 
   endif
   // FIM MATEUS MEDEIROS - GLPI - 54785
   
    cStrSQL  += "BM1_SUBCON, BM1_CODTIP, BM1_XISODO, 'V', RA_CC, 'I', RA_SITFOLH, RA_AFASFGT, BBT_CODIGO, BM1_PLNUCO, BM1_TIPUSU, BM1_PREFIX||BM1_NUMTIT||BM1_PARCEL||BM1_TIPTIT " + cEnter
 
   cStrSQL  += "ORDER BY 1,2,4 " + cEnter 

   //+-----------------------------------------------------+
   //| Salva a query acima para futuras verificacoes       |
   //+-----------------------------------------------------+
   Memowrit( _cPath+"DESPMEDI.sql", cStrSQL )

return  ( cStrSQL )


/*--------------------------------------------------------------------------*
* Funcao | ValidPerg     | Autor | Otavio Pinto          | Data | 31/01/2011*
*---------------------------------------------------------------------------*
* Descricao: Verifica a existencia das perguntas criando-as caso seja       *
*            necessario (caso nao existam).                                 *
*---------------------------------------------------------------------------*/
Static Function ValidPerg

Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel               /GSC/Valid/Var01/        Def01///Cnt01/Var02/             Def02///Cnt02/Var03/ Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

Aadd(aRegs,{cPerg , "01" , "Dt.Pagamento(SRC)   ?" ,"","", "mv_ch1" , "D" , 08 ,0 ,0 , "G" , "" , "mv_par01" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "02" , "Operadora           ?" ,"","", "mv_ch2" , "C" , 04 ,0 ,0 , "G" , "" , "mv_par02" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "03" , "Empresa             ?" ,"","", "mv_ch3" , "C" , 04 ,0 ,0 , "G" , "" , "mv_par03" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "04" , "Prefixo             ?" ,"","", "mv_ch4" , "C" , 03 ,0 ,0 , "G" , "" , "mv_par04" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "05" , "Integra Folha       ?" ,"","", "mv_ch5" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par05" , "SIM"        , "" , "" , "" , "" , "NAO"             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "06" , "Consultar em Excel  ?" ,"","", "mv_ch6" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par06" , "SIM"        , "" , "" , "" , "" , "NAO"             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "07" , "Informe Num.Lote    ?" ,"","", "mv_ch7" , "C" , 12 ,0 ,0 , "G" , "" , "mv_par07" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" }) 
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


// Fim do CABA063.PRW
