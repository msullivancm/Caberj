/******************************************************************************************************************
 **** Programa....: CABA061                                              I N T E G R A L                       ****
 **** Tipo........: ROTINA DE INTEGRACAO DE ASS.MEDICA, ODONTO (PLS) PARA IMPORTACAO NA FOLHA (GPE)            ****
 **** Autor.......: Otavio Pinto                                                                               ****
 **** Criacao.....: 09/02/2012                                                                                 ****
 **** Modificado..: 19/04/2013                                                                                 ****
 **** Alteracao...: Reestruturadas as query, minimizacao de parametros, acertos nas rotinas de gravacao no SRC.****	
 **** Solicitante.: Flavio Oliveira                                                                            ****
 **** Modulo......: GPE - Gestao de Pessoal  																   ****
 **** Chamada.....: Miscelanea >> Calculos >> Integracao PLS x GPE                                             ****
 **** Objetivo....: Exportar dados referentes à Assistencia Medica do PLS para GPE                             ****
 ******************************************************************************************************************/

#include "rwmake.ch" 

user Function CABA061()

private cArqSaida := ""
private cPerg     := "CABA061"   

private cCnt01    := GetMv("MV_CABINTE")
private cStrSQL   := ""
private cEnter    := CHR(13)+CHR(10)
private nLin      := 0
private nCol1     := 150
private _nContSRC := 0 
private _nContRHO := 0
private cStrSQL1  := "" 
private cStrSQL2  := ""
private cStrSQL3  := ""
private cStrSQL4  := ""
private nHandle1    
private nHandle2    
private nHandle3    
private nHandle4    

ValidPerg()

Pergunte(cPerg,.F.) 

@ 200,001 To 380,430 Dialog oDlg Title OemToAnsi("I N T E G R A L - ROTINA DE INTEGRACAO COM A FOLHA")
@ 002,010 To 060,200
@ 10,017 Say OemToAnsi("            <<<<<   INTEGRACAO COM A FOLHA - INTEGRAL  >>>>>            ")
@ 18,017 Say OemToAnsi("Esta rotina integra dados do PLS, com informacoes de Assistencia Medica:")
@ 26,017 Say OemToAnsi("Mensalidades, Coparticipacao, Odontologico e Agregados com GPE.         ")

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

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

private _cPath		:= Alltrim(cCnt01)+if(right(AllTrim(cCnt01),1) <> "\","\","" )            // "C:\TEMP\"
private oAbrArq 
private _nCont_1    := _nCont_2    := _nCont_3    := _nCont_4    := 0
private    cArq1    := _cPath+"MENSALID.csv" 
private    cArq2    := _cPath+"COPARTIC.csv"
private    cArq3    := _cPath+"ODONTOLO.csv" 
private    cArq4    := _cPath+"AGREGADO.csv"
private    _cDeli   := If( mv_par07 == 1,";"," ")
private _lGerou_1   := .F. 
private _lGerou_2   := .F.
private _lGerou_3   := .F.
private _lGerou_4   := .F.

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

if mv_par06 == 2 .and. mv_par07 == 2
   Msgbox("Nada a ser processado... verifique os parametros !","Atencao")
   break  
endif

/*
+---------------------------------------------------------+
| PARAMETROS UTILIZADOS                                   |
+---------------------------------------------------------+
|  01  |  Data Pagamento (SRC)| mv_par01 | 30/04/12       |
|  02  |  Ano  (PLS)          | mv_par02 | 2012           |
|  03  |  Mes  (PLS)          | mv_par03 | 04             |
|  04  |  Tipo Lancamento     | mv_par04 | (M,C,O)        |
|  05  |  Gera informacoes de | mv_par05 | Coparticipacao |
|  06  |  Integra Folha       | mv_par06 | SIM            |
|  07  |  Consultar em Excel  | mv_par07 | SIM            |
|  08  |  Informe Num.Titulo  | mv_par08 | 000012512      |
+---------------------------------------------------------+
*/

dbSelectArea("SRC") ; dbSetOrder(1) //RC_FILIAL+RC_MAT+RC_PD

FQueryes( mv_par05 )
                          
if mv_par05 == 1 ; _lGerou_1 := FRelat_1( cArq1 ) ; endif                              
if mv_par05 == 2 ; _lGerou_2 := FRelat_2( cArq2 ) ; endif                                
if mv_par05 == 3 ; _lGerou_3 := FRelat_3( cArq3 ) ; endif                              
if mv_par05 == 4 ; _lGerou_4 := FRelat_4( cArq4 ) ; endif                                 
   
if mv_par07 == 1 // Consulta Excel ?                                                        
   For x:= 1 TO 4
      if &("_lGerou_"+StrZero(x,1))                
      
         oExcelApp := MsExcel():New()
         oExcelApp:WorkBooks:Open( &("cArq"+StrZero(X,1)) ) // Abre uma planilha
         oExcelApp:SetVisible(.T.)         
      
      endif   
   Next         
 else 
   if mv_par06 == 1 // Integra a Folha ?
      //+---------------------------------------------------------------------+
      //| Faz a integração com a Folha (SRC - Movimentos mensais)             |
      //+---------------------------------------------------------------------+  
       if _lGerou_1 ; FGrvMensa() ; endif
       if _lGerou_2 ; FGrvCopar() ; endif         
       if _lGerou_3 ; FGrvOdont() ; endif    
       if _lGerou_4 ; FGrvAgreg() ; endif            
      _nTotal := _nCont_1 + _nCont_2 + _nCont_3 + _nCont_4
      if _nTotal > 0  
         MsgAlert( "Integrado"+if( _nTotal > 1,"s "," ") + alltrim(str(_nTotal)) + " registro"+if( _nTotal > 1,"s "," ")+" na FOLHA !!! "  )   
         _nTotal := _nCont_1 := _nCont_2 := _nCont_3 := _nCont_4 := 0            
      else   
         MsgAlert( "Nada foi Integrado... Verifique !!" )   
      endif  
   endif      
endif   
//+---------------------------------------------------------------------+
//| Fecha Arquivo Temporario...                                         |
//+---------------------------------------------------------------------+
If Select("TRB1") > 0 ; dbSelectArea("TRB1") ; TRB1->( dbCloseArea() ) ; Endif 
If Select("TRB2") > 0 ; dbSelectArea("TRB2") ; TRB2->( dbCloseArea() ) ; Endif
If Select("TRB3") > 0 ; dbSelectArea("TRB3") ; TRB3->( dbCloseArea() ) ; Endif
If Select("TRB4") > 0 ; dbSelectArea("TRB4") ; TRB4->( dbCloseArea() ) ; Endif   

End sequence
FClose( nHandle1 ) 
FClose( nHandle2 )
FClose( nHandle3 )
FClose( nHandle4 )

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
Static Function ParseHoriz()
private cCodigo := mv_par04
private _cTexto := "("
   cCodigo  := Alltrim( cCodigo )        
   while LEN(cCodigo)>0
      _cTexto := _cTexto + ( "'"+PARSE(@cCodigo,',')+"'"+iif( LEN(cCodigo)>0,",","") )
   Enddo                                   
   _cTexto := _cTexto + ")"
Return Alltrim(_cTexto)

/*--------------------------------------------------------------------------*
* Funcao | FGrvMensa    | Autor | Otavio Pinto           | Data | 22/03/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Objetivo desta funcao e' gravar no SRC.          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FGrvMensa()

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

ProcRegua( TRB1->( RecCount() ) )
TRB1->( dbGotop() )
// Varre o TMP ate o final do arquivo
_nCont_1 := 0
Do While TRB1->( !Eof() ) 
   if TRB1->( SITUACAO <> 'D' ) 
      IncProc( TRB1->FILIAL+" "+TRB1->MATRICULA )
   
      FOR x := 1 to 2

         // Se encontrar no SRC, ATUALIZA, senao, INCLUI ...
         lForma := SRC->( dbSeek( TRB1->(FILIAL+MATRICULA+IF( x == 1 ,VERBA, IF( x == 2 .AND. VERBA$'477','AMT', IF( x == 2 .AND. VERBA$'478','AMD'," " )))) ) )

         RecLock( "SRC" , !lForma )
         _nCont_1 ++      
         If !lForma          
            SRC->RC_FILIAL := TRB1->FILIAL
            SRC->RC_MAT    := AllTrim(TRB1->MATRICULA)
            SRC->RC_PD     := IF( x == 1 ,TRB1->VERBA, IF( x == 2 .AND. TRB1->VERBA$'477','AMT', IF( x == 2 .AND. TRB1->VERBA$'478','AMD'," " ))) 
            SRC->RC_TIPO1  := TRB1->TIPO1
            SRC->RC_VALOR  := IF( x == 1,TRB1->VLR_PG,TRB1->VLR_ORIG )
            SRC->RC_TIPO2  := TRB1->TIPO2
            SRC->RC_DATA   := CTOD( Substr(TRB1->DTPGTO,7,2)+"/"+Substr(TRB1->DTPGTO,5,2)+"/"+Substr(TRB1->DTPGTO,1,4) )
            SRC->RC_CC     := TRB1->CCUSTO
			SRC->RC_SEQ    := '1'			
         Else                            
            SRC->RC_DATA   := CTOD( Substr(TRB1->DTPGTO,7,2)+"/"+Substr(TRB1->DTPGTO,5,2)+"/"+Substr(TRB1->DTPGTO,1,4) )                                 
            SRC->RC_VALOR  += IF( x == 1,TRB1->VLR_PG,TRB1->VLR_ORIG )
         Endif      
         SRC->( MsUnLock() )
   Next
   endif
   TRB1->( dbSkip() )
Enddo                                    

//+---------------------------------------------------------------------+
//| Fecha Arquivo Temporario...                                         |
//+---------------------------------------------------------------------+
If Select("TRB1") > 0 ; dbSelectArea("TRB1") ; TRB1->( dbCloseArea() ) ; Endif
Return 

/*--------------------------------------------------------------------------*
* Funcao | FGrvCopar    | Autor | Otavio Pinto           | Data | 09/04/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Objetivo desta funcao e' gravar no SRC.          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FGrvCopar()

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

ProcRegua( TRB2->( RecCount() ) )
TRB2->( dbGotop() )
// Varre o TMP ate o final do arquivo
_nCont_2 := 0
Do While TRB2->( !Eof() ) 
   if TRB2->( SITUACAO <> 'D' ) 
      IncProc( TRB2->FILIAL+" "+TRB2->MATRICULA )
      FOR x := 1 to 1 //2
	
         // Se encontrar no SRC, ATUALIZA, senao, INCLUI ...
         lForma := SRC->( dbSeek( TRB2->(FILIAL+MATRICULA+VERBA) ) )
	
         RecLock( "SRC" , !lForma )
         _nCont_2 ++
         If !lForma
            SRC->RC_FILIAL := TRB2->FILIAL
            SRC->RC_MAT    := AllTrim(TRB2->MATRICULA)
            SRC->RC_PD     := TRB2->VERBA // cVerba
            SRC->RC_TIPO1  := TRB2->TIPO1
            SRC->RC_VALOR  := TRB2->VALOR
            SRC->RC_TIPO2  := TRB2->TIPO2
            SRC->RC_DATA   := CTOD( Substr(TRB2->DTPGTO,7,2)+"/"+Substr(TRB2->DTPGTO,5,2)+"/"+Substr(TRB2->DTPGTO,1,4) )
            SRC->RC_CC     := TRB2->CCUSTO
            SRC->RC_SEQ    := '1'
         Else
            SRC->RC_DATA   := CTOD( Substr(TRB2->DTPGTO,7,2)+"/"+Substr(TRB2->DTPGTO,5,2)+"/"+Substr(TRB2->DTPGTO,1,4) )
            SRC->RC_VALOR  += TRB2->VALOR
         Endif
         SRC->( MsUnLock() )
      Next	
   ENDIF
   TRB2->( dbSkip() )
Enddo                                    

//+---------------------------------------------------------------------+
//| Fecha Arquivo Temporario...                                         |
//+---------------------------------------------------------------------+
If Select("TRB2") > 0 ; dbSelectArea("TRB2") ; TRB2->( dbCloseArea() ) ; Endif
Return 



/*--------------------------------------------------------------------------*
* Funcao | FGrvOdont    | Autor | Otavio Pinto           | Data | 22/03/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Objetivo desta funcao e' gravar no SRC.          *
*            Exemplo de retorno: NIL                                        *

<<<<      PRECISA VER A LOGICA PARA ESTE CODEBLOCK    >>>>>


*---------------------------------------------------------------------------*/
Static Function FGrvOdont()

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

ProcRegua( TRB3->( RecCount() ) )
TRB3->( dbGotop() )
// Varre o TMP ate o final do arquivo
_nCont_3 := 0
Do While TRB3->( !Eof() ) 
   if TRB3->( SITUACAO <> 'D' ) 
      IncProc( TRB3->FILIAL+" "+TRB3->MATRICULA )
      FOR x := 1 to 2
         do case
            case TRB3->VERBA == '474'
				// Se encontrar no SRC, ATUALIZA, senao, INCLUI ...
				lForma := SRC->( dbSeek( TRB3->(FILIAL+MATRICULA+IF( x == 1 ,TRB3->VERBA, IF( x == 2 .AND. TRB3->VERBA$'474','AOD'," " ))) ) )
				RecLock( "SRC" , !lForma )
				_nCont_3 ++      
				If !lForma  
				   SRC->RC_FILIAL := TRB3->FILIAL
				   SRC->RC_MAT    := AllTrim(TRB3->MATRICULA)
				   SRC->RC_PD     := IF( x == 1 ,TRB3->VERBA, IF( x == 2 .AND. TRB3->VERBA$'474','AOD'," " )) 
				   SRC->RC_TIPO1  := TRB3->TIPO1
				   SRC->RC_VALOR  := TRB3->VALOR
				   SRC->RC_TIPO2  := TRB3->TIPO2
				   SRC->RC_DATA   := CTOD( Substr(TRB3->DTPGTO,7,2)+"/"+Substr(TRB3->DTPGTO,5,2)+"/"+Substr(TRB3->DTPGTO,1,4) )
				   SRC->RC_CC     := TRB3->CCUSTO
				   SRC->RC_SEQ    := '1'			
				Else                            
				   SRC->RC_DATA   := CTOD( Substr(TRB3->DTPGTO,7,2)+"/"+Substr(TRB3->DTPGTO,5,2)+"/"+Substr(TRB3->DTPGTO,1,4) )                                 
				   SRC->RC_VALOR  += TRB3->VALOR
				Endif      
				SRC->( MsUnLock() )
	        case TRB3->VERBA == '473' .and. x == 2 		
				// Se encontrar no SRC, ATUALIZA, senao, INCLUI ...
				lForma := SRC->( dbSeek( TRB3->(FILIAL+MATRICULA+'AOT') ) )
				RecLock( "SRC" , !lForma )
				_nCont_3 ++      
				If !lForma  
				   SRC->RC_FILIAL := TRB3->FILIAL
				   SRC->RC_MAT    := AllTrim(TRB3->MATRICULA)
				   SRC->RC_PD     := 'AOT'
				   SRC->RC_TIPO1  := TRB3->TIPO1
				   SRC->RC_VALOR  := TRB3->VAL_BM1
				   SRC->RC_TIPO2  := TRB3->TIPO2
				   SRC->RC_DATA   := CTOD( Substr(TRB3->DTPGTO,7,2)+"/"+Substr(TRB3->DTPGTO,5,2)+"/"+Substr(TRB3->DTPGTO,1,4) )
				   SRC->RC_CC     := TRB3->CCUSTO
				   SRC->RC_SEQ    := '1'			
				Else                            
				   SRC->RC_DATA   := CTOD( Substr(TRB3->DTPGTO,7,2)+"/"+Substr(TRB3->DTPGTO,5,2)+"/"+Substr(TRB3->DTPGTO,1,4) )                                 
				   SRC->RC_VALOR  += TRB3->VAL_BM1
				Endif      
				SRC->( MsUnLock() )	 
         endcase
      Next
   endif
   TRB3->( dbSkip() )
Enddo  
//+---------------------------------------------------------------------+
//| Fecha Arquivo Temporario...                                         |
//+---------------------------------------------------------------------+
If Select("TRB3") > 0 ; dbSelectArea("TRB3") ; TRB3->( dbCloseArea() ) ; Endif
Return 

/*--------------------------------------------------------------------------*
* Funcao | FGrvAgreg    | Autor | Otavio Pinto           | Data | 09/04/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Objetivo desta funcao e' gravar no SRC.          *
*            Exemplo de retorno: NIL                                        * 
* Em 24.04.2012 Ja esta sendo usada na rotina de mensalidades               *
*---------------------------------------------------------------------------*/
Static Function FGrvAgreg()

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

ProcRegua( TRB4->( RecCount() ) )
TRB4->( dbGotop() )
// Varre o TMP ate o final do arquivo
_nCont_4 := 0
Do While TRB4->( !Eof() ) 
   if TRB4->( SITUACAO <> 'D' ) 
      FOR x := 1 to 2
         IncProc( TRB4->FILIAL+" "+TRB4->MATRICULA+IF( x == 1 ,TRB4->VERBA, IF( x == 2 .AND. TRB4->VERBA$'478','AGR'," " )) )

         cVERBA := IF( x == 1 ,TRB4->VERBA, IF( x == 2 .AND. TRB4->VERBA$'478','AGR'," " )) 

         // Se encontrar no SRC, ATUALIZA, senao, INCLUI ...
         lForma := SRC->( dbSeek( TRB4->(FILIAL+MATRICULA+cVERBA) ) )

         RecLock( "SRC" , !lForma )
         _nCont_4 ++      
         If !lForma          
            SRC->RC_FILIAL := TRB4->FILIAL
            SRC->RC_MAT    := AllTrim(TRB4->MATRICULA)
            SRC->RC_PD     := cVERBA
            SRC->RC_TIPO1  := TRB4->TIPO1
            SRC->RC_VALOR  := TRB4->VLR_PG
            SRC->RC_TIPO2  := TRB4->TIPO2
            SRC->RC_DATA   := CTOD( Substr(TRB4->DTPGTO,7,2)+"/"+Substr(TRB4->DTPGTO,5,2)+"/"+Substr(TRB4->DTPGTO,1,4) )
            SRC->RC_CC     := TRB4->CCUSTO
			SRC->RC_SEQ    := '1'			
         Else                            
            SRC->RC_DATA   := CTOD( Substr(TRB4->DTPGTO,7,2)+"/"+Substr(TRB4->DTPGTO,5,2)+"/"+Substr(TRB4->DTPGTO,1,4) )                                 
            SRC->RC_VALOR  += TRB4->VLR_PG
         Endif      
         SRC->( MsUnLock() )
      Next
   endif	  
   TRB4->( dbSkip() )
Enddo                                    

//+---------------------------------------------------------------------+
//| Fecha Arquivo Temporario...                                         |
//+---------------------------------------------------------------------+
If Select("TRB4") > 0 ; dbSelectArea("TRB4") ; TRB4->( dbCloseArea() ) ; Endif
Return 


                                               

/*--------------------------------------------------------------------------*
* Funcao | FGravaRHO    | Autor | Otavio Pinto           | Data | 22/03/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Objetivo desta funcao e' gravar no SRC.          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FGravaRHO()

ProcRegua( TRB->( RecCount() ) )
TRB->( dbGotop() )
// Varre o TMP ate o final do arquivo
Do While TRB->( !Eof() ) 

   IncProc( TRB->FILIAL+" "+TRB->MATRICULA )
   IF TRB->TIPO3 == 'C'
      // Se encontrar no SRC, ATUALIZA, senao, INCLUI ...
      lForma := RHO->( dbSeek( TRB->(FILIAL+MATRICULA+DTPGTO) ) ) // RHO_FILIAL+RHO_MAT+DTOS(RHO_DTOCOR)

      RecLock( "RHO" , !lForma )
      _nContRHO ++
      If !lForma          
         RHO->RHO_FILIAL := TRB->FILIAL
         RHO->RHO_MAT    := AllTrim(TRB->MATRICULA)
         RHO->RHO_DTOCOR := CTOD( Substr(TRB->DTPGTO,7,2)+"/"+Substr(TRB->DTPGTO,5,2)+"/"+Substr(TRB->DTPGTO,1,4) )		 
         RHO->RHO_ORIGEM := '1'
         RHO->RHO_TPFORN := '1' 
         RHO->RHO_CODFOR := TRB->CODFOR //'001'
         RHO->RHO_CODIGO := TRB->SEQ    //'02'
         RHO->RHO_TPLAN  := '1'
         RHO->RHO_PD     := TRB->VERBA
         RHO->RHO_VLRFUN := TRB->VALOR
         RHO->RHO_VLREMP := 0.00                       
         RHO->RHO_COMPPG := if(empty(mv_par12),strzero(year(dDatabase),4)+strzero(month(dDatabase),2),mv_par12)   //'201201' parametro mv_par12 nao existe mais
         RHO->RHO_OBSERV := 'DESCRICAO DE OBSERVACAO TESTE"                                                                                                             
      Else
         RHO->RHO_DTOCOR := CTOD( Substr(TRB->DTPGTO,7,2)+"/"+Substr(TRB->DTPGTO,5,2)+"/"+Substr(TRB->DTPGTO,1,4) )		 
         RHO->RHO_VLRFUN := TRB->VALOR
      Endif      
      RHO->( MsUnLock() )
   ENDIF
   TRB->( dbSkip() )
Enddo  
Return 


/*--------------------------------------------------------------------------*
* Funcao | FRelat_1     | Autor | Otavio Pinto           | Data | 22/03/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Gera relatorio em excel                          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FRelat_1( _cArq )
local lRet := .F.

begin sequence          

If File( _cArq ) ; FErase( _cArq ) ; Endif     

nHandle1 := FCreate( _cArq )

if nHandle1 == -1
   MsgAlert("O arquivo "+AllTrim( _cArq )+" nao pode ser criado! Verifique os parametros.","Atencao !")  
   break
endif

if mv_par05 == 1 
   If Select("TRB1") > 0 ; dbSelectArea("TRB1") ; TRB1->( dbCloseArea() ) ; Endif
   //+----------------------------------------------------------------+
   //| Cria tabela temporaria conforme Query                          |
   //+----------------------------------------------------------------+
   dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL1),"TRB1", .T., .F.)

   dbSelectArea("TRB1")
   ProcRegua( TRB1->( RecCount() ) )
   TRB1->( dbGoTop() )

   //+----------------------------------------------------------------+
   //| Se tabela TRB retornar VAZIO, não gera resumo e exibe mensagem |
   //+----------------------------------------------------------------+

   if TRB1->( !Eof() )
      _nConta1 := 0
      _cCabec  := PADR("FILIAL",6," ")+_cDeli+" "+;
                  PADR("MATRICULA",9," ")+_cDeli+" "+;
                  PADR("VERBA",5," ")+_cDeli+" "+;
                  PADR("TIPO1",5," ")+_cDeli+" "+;   
                  PADL("VLR_BM1",13," ")+_cDeli+" "+;                    
                  PADL("VLR_ORIG",13," ")+_cDeli+" "+;  
                  PADL("VLR_PG",13," ")+_cDeli+" "+;
                  PADR("TIPO2",5," ")+_cDeli+" "+;
                  PADR("CCUSTO",9," ")+_cDeli+" "+;
                  PADR("DATA",10," ")+_cDeli+" "+;
                  PADR("SITUACAO",8," ")                  
      cBuffer1 :=  PAD( _cCabec ,nCol1," ") + cEnter	 
      FWrite(nHandle1, cBuffer1)
      while TRB1->( !Eof() )
         lret := .T.
         _cLinha := TRB1->(PADR( If( mv_par07 == 1,"'","")+FILIAL,6," ")+_cDeli+" "+;
                           PADR( If( mv_par07 == 1,"'","")+MATRICULA,9," ")+_cDeli+" "+;
                           PADR( VERBA,5," ")+_cDeli+" "+;
                           PADR( TIPO1,5," ")+_cDeli+" "+;    
                           PADL( Str(VLR_BM1,13,2),13," ")+_cDeli+" "+;                             
                           PADL( Str(VLR_ORIG,13,2),13," ")+_cDeli+" "+;  
                           PADL( Str(VLR_PG,13,2),13," ")+_cDeli+" "+;                            
                           PADR( TIPO2,5," ")+_cDeli+" "+;
                           PADR( CCUSTO,9," ")+_cDeli+" "+;
                           PADR( substr(DTPGTO,7,2)+"/"+substr(DTPGTO,5,2)+"/"+substr(DTPGTO,1,4),10," ")+_cDeli+" "+;
                           PADR( SITUACAO,8," ") )
         IncProc()
         _nConta1 ++    
         cBuffer1 :=  PAD( _cLinha ,nCol1," ") + cEnter	 
         FWrite(nHandle1, cBuffer1)                                         
         TRB1->( DbSkip() )               	
         if TRB1->( eof() )
            //+---------------------------------------------------------------------+
            //| Finaliza a listagem                                                 |
            //+---------------------------------------------------------------------+
            cBuffer1 := "Fim "
            FWrite(nHandle1, cBuffer1)         
         endif
      ENDDO          
   endif   
   //+---------------------------------------------------------------------+
   //| Finaliza a execucao do relatorio...                                 |
   //+---------------------------------------------------------------------+
   FClose(nHandle1)
endif

if !lret
    MsgAlert("MENSALIDADES - Nao ha registro(s) a ser(em) listado(s) ou integrado(s) !!!")         
endif

end sequence
Return lRet


/*--------------------------------------------------------------------------*
* Funcao | FRelat_2     | Autor | Otavio Pinto           | Data | 09/04/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Gera relatorio em excel                          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FRelat_2( _cArq )
local lRet := .F.

begin sequence 

If File( _cArq ) ; FErase( _cArq ) ; Endif     

nHandle2 := FCreate( _cArq )

if nHandle2 == -1
   MsgAlert("O arquivo "+AllTrim( _cArq )+" nao pode ser criado! Verifique os parametros.","Atencao !")  
   break
endif

if mv_par05 == 2 
   If Select("TRB2") > 0 ; dbSelectArea("TRB2") ; TRB2->( dbCloseArea() ) ; Endif
   //+----------------------------------------------------------------+
   //| Cria tabela temporaria conforme Query                          |
   //+----------------------------------------------------------------+
   dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL2),"TRB2", .T., .F.)

   dbSelectArea("TRB2")
   ProcRegua( TRB2->( RecCount() ) )
   TRB2->( dbGoTop() )
                                                                      
   //+----------------------------------------------------------------+
   //| Se tabela TRB retornar VAZIO, não gera resumo e exibe mensagem |
   //+----------------------------------------------------------------+
   if TRB2->( !Eof() )
      _nConta2 := 0
      _cCabec  := PADR("FILIAL",6," ")+_cDeli+" "+;
                  PADR("MATRICULA",9," ")+_cDeli+" "+;
                  PADR("VERBA",5," ")+_cDeli+" "+;
                  PADR("TIPO1",5," ")+_cDeli+" "+;
                  PADL("VALOR",13," ")+_cDeli+" "+;
                  PADR("TIPO2",5," ")+_cDeli+" "+;
                  PADR("CCUSTO",9," ")+_cDeli+" "+;
                  PADR("DATA",10," ")+_cDeli+" "+; 
                  PADR("SITUACAO",8," ")
      cBuffer2 :=  PAD( _cCabec ,nCol1," ") + cEnter	 
      FWrite(nHandle2, cBuffer2)
      while TRB2->( !Eof() )
         lret := .T.
         _cLinha := TRB2->(PADR( If( mv_par07 == 1,"'","") +FILIAL,6," ")+_cDeli+" "+;
                           PADR( If( mv_par07 == 1,"'","")  +MATRICULA,9," ")+_cDeli+" "+;
                           PADR( VERBA,5," ")+_cDeli+" "+;
                           PADR( TIPO1,5," ")+_cDeli+" "+;
                           PADL( Str(VALOR,13,2),13," ")+_cDeli+" "+; 
                           PADR( TIPO2,5," ")+_cDeli+" "+;
                           PADR( CCUSTO,9," ")+_cDeli+" "+;
                           PADR( substr(DTPGTO,7,2)+"/"+substr(DTPGTO,5,2)+"/"+substr(DTPGTO,1,4),10," ")+_cDeli+" "+;
                           PADR( SITUACAO,8," ") )
         IncProc()
         _nConta2 ++    
         cBuffer2 :=  PAD( _cLinha ,nCol1," ") + cEnter	 
         FWrite(nHandle2, cBuffer2)                                         
         TRB2->( DbSkip() )               	
         if TRB2->( eof() )
            //+---------------------------------------------------------------------+
            //| Finaliza a listagem                                                 |
            //+---------------------------------------------------------------------+
            cBuffer2 := "Fim "
            FWrite(nHandle2, cBuffer2)         
         endif
      ENDDO          
   endif   
   //+---------------------------------------------------------------------+
   //| Finaliza a execucao do relatorio...                                 |
   //+---------------------------------------------------------------------+
   FClose(nHandle2)
endif

if !lret
    MsgAlert("CO-PARTICIPACAO - Nao ha registro(s) a ser(em) listado(s) ou integrado(s) !!!")         
endif

end sequence
Return lRet


/*--------------------------------------------------------------------------*
* Funcao | FRelat_3     | Autor | Otavio Pinto           | Data | 09/04/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Gera relatorio em excel                          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FRelat_3( _cArq )
local lRet := .F.

begin sequence

If File( _cArq ) ; FErase( _cArq ) ; Endif     

nHandle3 := FCreate( _cArq )

if nHandle3 == -1
   MsgAlert("O arquivo "+AllTrim( _cArq )+" nao pode ser criado! Verifique os parametros.","Atencao !")  
   break
endif

if mv_par05 == 3 
   If Select("TRB3") > 0 ; dbSelectArea("TRB3") ; TRB3->( dbCloseArea() ) ; Endif
   //+----------------------------------------------------------------+
   //| Cria tabela temporaria conforme Query                          |
   //+----------------------------------------------------------------+
   dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL3),"TRB3", .T., .F.)

   dbSelectArea("TRB3")
   ProcRegua( TRB3->( RecCount() ) )
   TRB3->( dbGoTop() )

   //+----------------------------------------------------------------+
   //| Se tabela TRB retornar VAZIO, não gera resumo e exibe mensagem |
   //+----------------------------------------------------------------+
   if TRB3->( !Eof() )
      _nConta3 := 0
      _cCabec  := PADR("FILIAL",6," ")+_cDeli+" "+;
                  PADR("MATRICULA",9," ")+_cDeli+" "+;
                  PADR("VERBA",5," ")+_cDeli+" "+;
                  PADR("TIPO1",5," ")+_cDeli+" "+;
				  PADL("VAL_BM1",13," ")+_cDeli+" "+; 
                  PADL("VALOR",13," ")+_cDeli+" "+; 
                  PADR("TIPO2",5," ")+_cDeli+" "+;                  
                  PADR("CCUSTO",9," ")+_cDeli+" "+;                  
                  PADR("DATA",10," ")+_cDeli+" "+;
                  PADR("SITUACAO",8," ")                   
      cBuffer3 :=  PAD( _cCabec ,nCol1," ") + cEnter	 
      FWrite(nHandle3, cBuffer3)                                         
      while TRB3->( !Eof() )
         lret := .T.
         _cLinha := TRB3->(PADR( If( mv_par07 == 1,"'","") +FILIAL,6," ")+_cDeli+" "+;
                           PADR( If( mv_par07 == 1,"'","")  +MATRICULA,9," ")+_cDeli+" "+;
                           PADR( VERBA,5," ")+_cDeli+" "+;
                           PADR( TIPO1,5," ")+_cDeli+" "+;
						   PADL( Str(VAL_BM1,13,2),13," ")+_cDeli+" "+; 
                           PADL( Str(VALOR,13,2),13," ")+_cDeli+" "+; 
                           PADR( TIPO2,5," ")+_cDeli+" "+;
                           PADR( CCUSTO,9," ")+_cDeli+" "+;
                           PADR( substr(DTPGTO,7,2)+"/"+substr(DTPGTO,5,2)+"/"+substr(DTPGTO,1,4),10," ")+_cDeli+" "+;
                           PADR( SITUACAO,8," ") )
         IncProc()
         _nConta3 ++    
         cBuffer3 :=  PAD( _cLinha ,nCol1," ") + cEnter	 
         FWrite(nHandle3, cBuffer3)                                         
         TRB3->( DbSkip() )               	
         if TRB3->( eof() )
            //+---------------------------------------------------------------------+
            //| Finaliza a listagem                                                 |
            //+---------------------------------------------------------------------+
            cBuffer3 := "Fim "
            FWrite(nHandle3, cBuffer3)         
         endif
      ENDDO          
   endif   
   //+---------------------------------------------------------------------+
   //| Finaliza a execucao do relatorio...                                 |
   //+---------------------------------------------------------------------+
   FClose(nHandle3)
endif

if !lret
    MsgAlert("ODONTOLOGICO - Nao ha registros a ser(em) listado(s) ou integrado(s) !!!")         
endif

end sequence
Return lRet

/*--------------------------------------------------------------------------*
* Funcao | FRelat_4     | Autor | Otavio Pinto           | Data | 22/03/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Gera relatorio em excel                          *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FRelat_4( _cArq )
local lRet := .F.

begin sequence          

If File( _cArq ) ; FErase( _cArq ) ; Endif     

nHandle4 := FCreate( _cArq )

if nHandle4 == -1
   MsgAlert("O arquivo "+AllTrim( _cArq )+" nao pode ser criado! Verifique os parametros.","Atencao !")  
   break
endif

if mv_par05 == 4 
   If Select("TRB4") > 0 ; dbSelectArea("TRB4") ; TRB4->( dbCloseArea() ) ; Endif
   //+----------------------------------------------------------------+
   //| Cria tabela temporaria conforme Query                          |
   //+----------------------------------------------------------------+
   dbUseArea(.T., "TOPCONN", TcGenQry(,, cStrSQL4),"TRB4", .T., .F.)

   dbSelectArea("TRB4") 
   ProcRegua( TRB4->( RecCount() ) )
   TRB4->( dbGoTop() )

   //+----------------------------------------------------------------+
   //| Se tabela TRB retornar VAZIO, não gera resumo e exibe mensagem |
   //+----------------------------------------------------------------+

   if TRB4->( !Eof() )
      _nConta4 := 0
      _cCabec  := PADR("FILIAL",6," ")+_cDeli+" "+;
                  PADR("MATRICULA",9," ")+_cDeli+" "+;
                  PADR("VERBA",5," ")+_cDeli+" "+;
                  PADR("TIPO1",5," ")+_cDeli+" "+;   
                  PADL("VLR_BM1",13," ")+_cDeli+" "+;                    
                  PADL("VLR_ORIG",13," ")+_cDeli+" "+;  
                  PADL("VLR_PG",13," ")+_cDeli+" "+;                   
                  PADR("TIPO2",5," ")+_cDeli+" "+;                  
                  PADR("CCUSTO",9," ")+_cDeli+" "+;                  
                  PADR("DATA",10," ")+_cDeli+" "+;
                  PADR("SITUACAO",8," ")                   
      cBuffer4 :=  PAD( _cCabec ,nCol1," ") + cEnter	 
      FWrite(nHandle4, cBuffer4)
      while TRB4->( !Eof() )
         lret := .T.
         _cLinha := TRB4->(PADR( If( mv_par07 == 1,"'","")+FILIAL,6," ")+_cDeli+" "+;
                           PADR( If( mv_par07 == 1,"'","")+MATRICULA,9," ")+_cDeli+" "+;
                           PADR( VERBA,5," ")+_cDeli+" "+;
                           PADR( TIPO1,5," ")+_cDeli+" "+;    
                           PADL( Str(VLR_BM1,13,2),13," ")+_cDeli+" "+;                             
                           PADL( Str(VLR_ORIG,13,2),13," ")+_cDeli+" "+;  
                           PADL( Str(VLR_PG,13,2),13," ")+_cDeli+" "+;                            
                           PADR( TIPO2,5," ")+_cDeli+" "+;
                           PADR( CCUSTO,9," ")+_cDeli+" "+;
                           PADR( substr(DTPGTO,7,2)+"/"+substr(DTPGTO,5,2)+"/"+substr(DTPGTO,1,4),10," ")+_cDeli+" "+;
                           PADR( SITUACAO,8," ") )
         IncProc()
         _nConta4 ++    
         cBuffer4 :=  PAD( _cLinha ,nCol1," ") + cEnter	 
         FWrite(nHandle4, cBuffer4)                                         
         TRB4->( DbSkip() )               	
         if TRB4->( eof() )
            //+---------------------------------------------------------------------+
            //| Finaliza a listagem                                                 |
            //+---------------------------------------------------------------------+
            cBuffer4 := "Fim "
            FWrite(nHandle4, cBuffer4)         
         endif
      ENDDO          
   endif   
   //+---------------------------------------------------------------------+
   //| Finaliza a execucao do relatorio...                                 |
   //+---------------------------------------------------------------------+
   FClose(nHandle4)
endif

if !lret
    MsgAlert("AGREGADOS - Nao ha registro(s) a ser(em) listado(s) ou integrado(s) !!!")         
endif

end sequence
Return lRet



/*--------------------------------------------------------------------------*
* Funcao | FQueryes     | Autor | Otavio Pinto           | Data | 09/04/2012*
*---------------------------------------------------------------------------*
* Descricao: Retorna Nil - Querys para apuração das informacoes.            *
*            Exemplo de retorno: NIL                                        *
*---------------------------------------------------------------------------*/
Static Function FQueryes( _nOpcao )
local lRet := .F.               

if  _nOpcao = 1

   //+-------------------------------------------------------------------------------------------------------+
   //| Query de M E N S A L I D A D E S                                                                      |
   //+-------------------------------------------------------------------------------------------------------+
   cStrSQL1 := "SELECT RA_FILIAL  FILIAL  " + cEnter
   cStrSQL1 += "    , SubStr(BA1_MATEMP,1,6)   MATRICULA  " + cEnter
   cStrSQL1 += "    , Decode( BM1_CODTIP, '910','191','102','485','101','477')  VERBA  " + cEnter
   cStrSQL1 += "    , 'V'        TIPO1  " + cEnter
   cStrSQL1 += "    , Sum ( BM1_VALOR ) VLR_BM1  " + cEnter
   cStrSQL1 += "    , Sum (  (SELECT BTN_VALFAI  " + cEnter
   cStrSQL1 += "                        FROM SIGA.BTN020 BTN  " + cEnter
   cStrSQL1 += "                        WHERE BTN.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "                          AND BTN_FILIAL = '  '  " + cEnter
   cStrSQL1 += "                          AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP  " + cEnter
   cStrSQL1 += "                          AND BTN_NUMCON = BM1_CONEMP  " + cEnter
   cStrSQL1 += "                          AND BTN_VERCON = BM1_VERCON  " + cEnter
   cStrSQL1 += "                          AND BTN_SUBCON = BM1_SUBCON  " + cEnter
   cStrSQL1 += "                          AND BTN_VERSUB = BM1_VERSUB  " + cEnter
   cStrSQL1 += "                          AND BTN_CODPRO = BM1_CODPLA  " + cEnter
   cStrSQL1 += "                          AND BTN_VERPRO = BM1_VERPLA  " + cEnter
   cStrSQL1 += "                          AND BTN_CODFOR = BM1_CODTIP  " + cEnter
   cStrSQL1 += "                          AND BTN_CODQTD = '001'  " + cEnter
   cStrSQL1 += "                          AND BTN_IDAINI = BM1_IDAINI  " + cEnter
   cStrSQL1 += "                          AND BTN_IDAFIN = BM1_IDAFIN  " + cEnter
   cStrSQL1 += "                          AND BTN_CODFAI = BM1_CODFAI)      ) VLR_ORIG  " + cEnter
   cStrSQL1 += "    , Sum ( ( CASE WHEN BM1_CODPLA = '0063' AND BM1_CODTIP <> '102'  THEN 1.00  " + cEnter 
   cStrSQL1 += "                   WHEN BM1_CODPLA = '0063' AND BM1_CODTIP  = '102'  THEN BM1_VALOR  " + cEnter   
   cStrSQL1 += "                   ELSE  " + cEnter
   cStrSQL1 += "                      (BM1_VALOR - (SELECT BTN_VALFAI  " + cEnter
   cStrSQL1 += "                                    FROM SIGA.BTN020 BTN  " + cEnter
   cStrSQL1 += "                                    WHERE BTN.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "                                      AND BTN_FILIAL = '  '  " + cEnter
   cStrSQL1 += "                                      AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP  " + cEnter
   cStrSQL1 += "                                      AND BTN_NUMCON = BM1_CONEMP  " + cEnter
   cStrSQL1 += "                                      AND BTN_VERCON = BM1_VERCON  " + cEnter
   cStrSQL1 += "                                      AND BTN_SUBCON = BM1_SUBCON  " + cEnter
   cStrSQL1 += "                                      AND BTN_VERSUB = BM1_VERSUB  " + cEnter
   cStrSQL1 += "                                      AND BTN_CODPRO = '0063'      " + cEnter
   cStrSQL1 += "                                      AND BTN_VERPRO = BM1_VERPLA  " + cEnter
   cStrSQL1 += "                                      AND BTN_CODFOR = BM1_CODTIP  " + cEnter
   cStrSQL1 += "                                      AND BTN_CODQTD = '001'  " + cEnter
   cStrSQL1 += "                                      AND BTN_IDAINI = BM1_IDAINI  " + cEnter
   cStrSQL1 += "                                      AND BTN_IDAFIN = BM1_IDAFIN  " + cEnter
   cStrSQL1 += "                                      AND BTN_CODFAI = BM1_CODFAI) ) + 1  " + cEnter
   cStrSQL1 += "       END    )   ) VLR_PG  " + cEnter
   cStrSQL1 += "    , RA_CC       CCUSTO  " + cEnter
   cStrSQL1 += "    , 'I'         TIPO2  " + cEnter
   cStrSQL1 += "    , '"+DTOS(mv_par01)+"'  DTPGTO " + cEnter
   cStrSQL1 += "    , RA_SITFOLH  SITUACAO  " + cEnter
   cStrSQL1 += "FROM SIGA.BM1020 BM1  " + cEnter
   cStrSQL1 += "   , SIGA.BA1020 BA1  " + cEnter
   cStrSQL1 += "   , SIGA.BA3020 BA3  " + cEnter
   cStrSQL1 += "   , SIGA.BFQ020 BFQ  " + cEnter
   cStrSQL1 += "   , SIGA.BRP020 BRP  " + cEnter
   cStrSQL1 += "   , SIGA.SRA010 SRA  " + cEnter
   cStrSQL1 += "WHERE BM1_FILIAL  =  ' '  " + cEnter
   cStrSQL1 += "  AND (BA1_TIPUSU =  'T' AND BA1_NOMTIT  = ' ')  " + cEnter
   cStrSQL1 += "  AND BM1_PREFIX  =  'PLS'  " + cEnter
   cStrSQL1 += "  AND BM1_TIPTIT  =  'DP'  " + cEnter
   cStrSQL1 += "  AND BM1_NUMTIT  =  '"+mv_par08+"' " + cEnter  
   cStrSQL1 += "  AND BA1_NOMTIT  = ' '  " + cEnter
   cStrSQL1 += "  AND BFQ_YTPANL  = 'M'  " + cEnter
   cStrSQL1 += "  AND BM1_TIPO    = '1'  " + cEnter
   cStrSQL1 += "  AND BM1_CODPLA IN ('0063','0065')  " + cEnter
   cStrSQL1 += "  AND BM1_CODTIP IN ('101','102','910')  " + cEnter
   cStrSQL1 += "  AND BA1_FILIAL  =  BM1_FILIAL  " + cEnter
   cStrSQL1 += "  AND BA1_CODINT  =  BM1_CODINT  " + cEnter
   cStrSQL1 += "  AND BA1_CODEMP  =  BM1_CODEMP  " + cEnter
   cStrSQL1 += "  AND BA1_MATRIC  =  BM1_MATRIC  " + cEnter
   cStrSQL1 += "  AND BA1_TIPREG  =  BM1_TIPREG  " + cEnter
   cStrSQL1 += "  AND BA1_DIGITO  =  BM1_DIGITO  " + cEnter
   cStrSQL1 += "  AND BA3_FILIAL  =  BA1_FILIAL  " + cEnter
   cStrSQL1 += "  AND BA3_CODINT  =  BA1_CODINT  " + cEnter
   cStrSQL1 += "  AND BA3_CODEMP  =  BA1_CODEMP  " + cEnter
   cStrSQL1 += "  AND BA3_MATRIC  =  BA1_MATRIC  " + cEnter
   cStrSQL1 += "  AND BA3_CONEMP  =  BA1_CONEMP  " + cEnter
   cStrSQL1 += "  AND BA3_VERCON  =  '001'  " + cEnter
   cStrSQL1 += "  AND BFQ_FILIAL  =  BM1_FILIAL  " + cEnter
   cStrSQL1 += "  AND BFQ_CODINT  =  BM1_CODINT  " + cEnter
   cStrSQL1 += "  AND BFQ_PROPRI || BFQ_CODLAN = BM1_CODTIP  " + cEnter
   cStrSQL1 += "  AND BRP_FILIAL  = ' '  " + cEnter
   cStrSQL1 += "  AND BRP_CODIGO  = BA1_GRAUPA  " + cEnter
   cStrSQL1 += "  AND RA_FILIAL   = '01'  " + cEnter
   cStrSQL1 += "  AND RA_MAT      = SUBSTR(BA1_MATEMP,1,6)  " + cEnter
   cStrSQL1 += "  AND BM1.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BA1.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BA3.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BFQ.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BRP.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND SRA.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), BM1_CODTIP, 'V', 'I', RA_SITFOLH , RA_CC  " + cEnter

   cStrSQL1 += "UNION ALL  " + cEnter

   cStrSQL1 += "SELECT RA_FILIAL FILIAL  " + cEnter
   cStrSQL1 += "    , SubStr(BA1_MATEMP,1,6) MATRICULA  " + cEnter
   cStrSQL1 += "    , Decode( BM1_CODTIP, '910','191','102','485','101','478')  VERBA  " + cEnter
*  cStrSQL1 += "    , '478'      VERBA  " + cEnter
   cStrSQL1 += "    , 'V'        TIPO1  " + cEnter
   cStrSQL1 += "    , Sum ( BM1_VALOR ) VLR_BM1  " + cEnter
   cStrSQL1 += "    , SUM (   (SELECT BTN_VALFAI  " + cEnter
   cStrSQL1 += "               FROM SIGA.BTN020 BTN  " + cEnter
   cStrSQL1 += "               WHERE BTN.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "                 AND BTN_FILIAL = '  '  " + cEnter
   cStrSQL1 += "                 AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP  " + cEnter
   cStrSQL1 += "                 AND BTN_NUMCON = BM1_CONEMP  " + cEnter
   cStrSQL1 += "                 AND BTN_VERCON = BM1_VERCON  " + cEnter
   cStrSQL1 += "                 AND BTN_SUBCON = BM1_SUBCON  " + cEnter
   cStrSQL1 += "                 AND BTN_VERSUB = BM1_VERSUB  " + cEnter
   cStrSQL1 += "                 AND BTN_CODPRO = BM1_CODPLA  " + cEnter
   cStrSQL1 += "                 AND BTN_VERPRO = BM1_VERPLA  " + cEnter
   cStrSQL1 += "                 AND BTN_CODFOR = BM1_CODTIP  " + cEnter
   cStrSQL1 += "                 AND BTN_CODQTD = '001'  " + cEnter
   cStrSQL1 += "                 AND BTN_IDAINI = BM1_IDAINI  " + cEnter
   cStrSQL1 += "                 AND BTN_IDAFIN = BM1_IDAFIN  " + cEnter
   cStrSQL1 += "                 AND BTN_CODFAI = BM1_CODFAI)      ) VLR_ORIG  " + cEnter
   cStrSQL1 += "    , Sum ( ( CASE WHEN BM1_CODPLA = '0063' AND BM1_CODTIP <> '102'  THEN 1.00  " + cEnter 
   cStrSQL1 += "                   WHEN BM1_CODPLA = '0063' AND BM1_CODTIP  = '102'  THEN BM1_VALOR  " + cEnter   
   cStrSQL1 += "                   ELSE  " + cEnter
   cStrSQL1 += "                      ( BM1_VALOR - (SELECT BTN_VALFAI  " + cEnter
   cStrSQL1 += "                                     FROM SIGA.BTN020 BTN  " + cEnter
   cStrSQL1 += "                                     WHERE BTN.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "                                     AND BTN_FILIAL = '  '  " + cEnter
   cStrSQL1 += "                                     AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP  " + cEnter
   cStrSQL1 += "                                     AND BTN_NUMCON = BM1_CONEMP  " + cEnter
   cStrSQL1 += "                                     AND BTN_VERCON = BM1_VERCON  " + cEnter
   cStrSQL1 += "                                     AND BTN_SUBCON = BM1_SUBCON  " + cEnter
   cStrSQL1 += "                                     AND BTN_VERSUB = BM1_VERSUB  " + cEnter
   cStrSQL1 += "                                     AND BTN_CODPRO = '0063'      " + cEnter
   cStrSQL1 += "                                     AND BTN_VERPRO = BM1_VERPLA  " + cEnter
   cStrSQL1 += "                                     AND BTN_CODFOR = BM1_CODTIP  " + cEnter
   cStrSQL1 += "                                     AND BTN_CODQTD = '001'  " + cEnter
   cStrSQL1 += "                                     AND BTN_IDAINI = BM1_IDAINI  " + cEnter
   cStrSQL1 += "                                     AND BTN_IDAFIN = BM1_IDAFIN  " + cEnter
   cStrSQL1 += "                                     AND BTN_CODFAI = BM1_CODFAI)) + 1  " + cEnter
   cStrSQL1 += "                 END   )    ) VLR_PG  " + cEnter
   cStrSQL1 += "    , RA_CC       CCUSTO  " + cEnter
   cStrSQL1 += "    , 'I'         TIPO2  " + cEnter
   cStrSQL1 += "    , '"+DTOS(mv_par01)+"'  DTPGTO " + cEnter
   cStrSQL1 += "    , RA_SITFOLH  SITUACAO  " + cEnter
   cStrSQL1 += "FROM SIGA.BM1020 BM1  " + cEnter
   cStrSQL1 += "  , SIGA.BA1020 BA1  " + cEnter
   cStrSQL1 += "  , SIGA.BA3020 BA3  " + cEnter
   cStrSQL1 += "  , SIGA.BFQ020 BFQ  " + cEnter
   cStrSQL1 += "  , SIGA.BRP020 BRP  " + cEnter
   cStrSQL1 += "  , SIGA.SRA010 SRA  " + cEnter
   cStrSQL1 += "WHERE BM1_FILIAL  =  ' '  " + cEnter
   cStrSQL1 += "  AND ( (BA1_TIPUSU  =  'D')  OR (BA1_TIPUSU  =  'T' and BA1_NOMTIT  <> ' ') )  " + cEnter
   cStrSQL1 += "  AND BM1_PREFIX  =  'PLS'  " + cEnter
   cStrSQL1 += "  AND BM1_TIPTIT  =  'DP'  " + cEnter
   cStrSQL1 += "  AND BM1_NUMTIT  =  '"+mv_par08+"' " + cEnter  
   cStrSQL1 += "  AND BFQ_YTPANL  = 'M'  " + cEnter
   cStrSQL1 += "  AND BM1_TIPO    = '1'  " + cEnter
   cStrSQL1 += "  AND BM1_CODPLA IN ('0063','0065')  " + cEnter
*  cStrSQL1 += "  AND BM1_CODTIP IN ('101')  " + cEnter
   cStrSQL1 += "  AND BM1_CODTIP IN ('101','102','910')  " + cEnter
   cStrSQL1 += "  AND BA1_FILIAL  =  BM1_FILIAL  " + cEnter
   cStrSQL1 += "  AND BA1_CODINT  =  BM1_CODINT  " + cEnter
   cStrSQL1 += "  AND BA1_CODEMP  =  BM1_CODEMP  " + cEnter
   cStrSQL1 += "  AND BA1_MATRIC  =  BM1_MATRIC  " + cEnter
   cStrSQL1 += "  AND BA1_TIPREG  =  BM1_TIPREG  " + cEnter
   cStrSQL1 += "  AND BA1_DIGITO  =  BM1_DIGITO  " + cEnter
   cStrSQL1 += "  AND BA3_FILIAL  =  BA1_FILIAL  " + cEnter
   cStrSQL1 += "  AND BA3_CODINT  =  BA1_CODINT  " + cEnter
   cStrSQL1 += "  AND BA3_CODEMP  =  BA1_CODEMP  " + cEnter
   cStrSQL1 += "  AND BA3_MATRIC  =  BA1_MATRIC  " + cEnter
   cStrSQL1 += "  AND BA3_CONEMP  =  BA1_CONEMP  " + cEnter
   cStrSQL1 += "  AND BA3_VERCON  =  '001'  " + cEnter
   cStrSQL1 += "  AND BFQ_FILIAL  =  BM1_FILIAL  " + cEnter
   cStrSQL1 += "  AND BFQ_CODINT  =  BM1_CODINT  " + cEnter
   cStrSQL1 += "  AND BFQ_PROPRI || BFQ_CODLAN = BM1_CODTIP  " + cEnter
   cStrSQL1 += "  AND BRP_FILIAL  = ' '  " + cEnter
   cStrSQL1 += "  AND BRP_CODIGO  = BA1_GRAUPA  " + cEnter
   cStrSQL1 += "  AND RA_FILIAL   = '01'  " + cEnter
   cStrSQL1 += "  AND RA_MAT      = SUBSTR(BA1_MATEMP,1,6)  " + cEnter
   cStrSQL1 += "  AND BM1.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BA1.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BA3.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BFQ.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BRP.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND SRA.D_E_L_E_T_ = ' '  " + cEnter
*  cStrSQL1 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), '478', 'V', 'I', RA_SITFOLH , RA_CC  " + cEnter 
   cStrSQL1 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), BM1_CODTIP, 'V', 'I', RA_SITFOLH , RA_CC  " + cEnter   
   cStrSQL1 += "UNION ALL  " + cEnter
   cStrSQL1 += "SELECT RA_FILIAL FILIAL  " + cEnter
   cStrSQL1 += "     , SubStr(BA1_MATEMP,1,6) MATRICULA  " + cEnter
   cStrSQL1 += "     , '476'      VERBA  " + cEnter
   cStrSQL1 += "     , 'V'        TIPO1  " + cEnter
   cStrSQL1 += "     , Sum ( BM1_VALOR ) VLR_BM1  " + cEnter
   cStrSQL1 += "     , SUM ( (SELECT BTN_VALFAI  " + cEnter
   cStrSQL1 += "              FROM SIGA.BTN020 BTN  " + cEnter
   cStrSQL1 += "              WHERE BTN.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "                    AND BTN_FILIAL = '  '  " + cEnter
   cStrSQL1 += "                    AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP  " + cEnter
   cStrSQL1 += "                    AND BTN_NUMCON = BM1_CONEMP  " + cEnter
   cStrSQL1 += "                    AND BTN_VERCON = BM1_VERCON  " + cEnter
   cStrSQL1 += "                    AND BTN_SUBCON = BM1_SUBCON  " + cEnter
   cStrSQL1 += "                    AND BTN_VERSUB = BM1_VERSUB  " + cEnter
   cStrSQL1 += "                    AND BTN_CODPRO = BM1_CODPLA  " + cEnter
   cStrSQL1 += "                    AND BTN_VERPRO = BM1_VERPLA  " + cEnter
   cStrSQL1 += "                    AND BTN_CODFOR = BM1_CODTIP  " + cEnter
   cStrSQL1 += "                    AND BTN_CODQTD = '001'  " + cEnter
   cStrSQL1 += "                    AND BTN_IDAINI = BM1_IDAINI  " + cEnter
   cStrSQL1 += "                    AND BTN_IDAFIN = BM1_IDAFIN  " + cEnter
   cStrSQL1 += "                    AND BTN_CODFAI = BM1_CODFAI)       ) VLR_ORIG  " + cEnter
   cStrSQL1 += "    , Sum ( ( CASE WHEN BM1_CODPLA = '0063'   THEN 1.00  " + cEnter
   cStrSQL1 += "                  ELSE  " + cEnter
   cStrSQL1 += "                 ( BM1_VALOR - (SELECT BTN_VALFAI  " + cEnter
   cStrSQL1 += "                  FROM SIGA.BTN020 BTN  " + cEnter
   cStrSQL1 += "                  WHERE BTN.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "                    AND BTN_FILIAL = '  '  " + cEnter
   cStrSQL1 += "                    AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP  " + cEnter
   cStrSQL1 += "                    AND BTN_NUMCON = BM1_CONEMP  " + cEnter
   cStrSQL1 += "                    AND BTN_VERCON = BM1_VERCON  " + cEnter
   cStrSQL1 += "                    AND BTN_SUBCON = BM1_SUBCON  " + cEnter
   cStrSQL1 += "                    AND BTN_VERSUB = BM1_VERSUB  " + cEnter
   cStrSQL1 += "                    AND BTN_CODPRO = '0063'      " + cEnter
   cStrSQL1 += "                    AND BTN_VERPRO = BM1_VERPLA  " + cEnter
   cStrSQL1 += "                    AND BTN_CODFOR = BM1_CODTIP  " + cEnter
   cStrSQL1 += "                    AND BTN_CODQTD = '001'  " + cEnter
   cStrSQL1 += "                    AND BTN_IDAINI = BM1_IDAINI  " + cEnter
   cStrSQL1 += "                    AND BTN_IDAFIN = BM1_IDAFIN  " + cEnter
   cStrSQL1 += "                    AND BTN_CODFAI = BM1_CODFAI)) + 1  " + cEnter
   cStrSQL1 += "        END   )    ) VLR_PG  " + cEnter
   cStrSQL1 += "    , RA_CC       CCUSTO  " + cEnter
   cStrSQL1 += "    , 'I'         TIPO2  " + cEnter
   cStrSQL1 += "    , '"+DTOS(mv_par01)+"'  DTPGTO " + cEnter
   cStrSQL1 += "    , RA_SITFOLH  SITUACAO  " + cEnter
   cStrSQL1 += "FROM SIGA.BM1020 BM1  " + cEnter
   cStrSQL1 += "  , SIGA.BA1020 BA1  " + cEnter
   cStrSQL1 += "  , SIGA.BA3020 BA3  " + cEnter
   cStrSQL1 += "  , SIGA.BFQ020 BFQ  " + cEnter
   cStrSQL1 += "  , SIGA.BRP020 BRP  " + cEnter
   cStrSQL1 += "  , SIGA.SRA010 SRA  " + cEnter
   cStrSQL1 += "WHERE BM1_FILIAL  =  ' '  " + cEnter
   cStrSQL1 += "  AND BM1_PREFIX  =  'PLS'  " + cEnter
   cStrSQL1 += "  AND BM1_TIPTIT  =  'DP'  " + cEnter
   cStrSQL1 += "  AND BM1_NUMTIT  =  '"+mv_par08+"' " + cEnter  
   cStrSQL1 += "  AND BFQ_YTPANL  = 'M'  " + cEnter
   cStrSQL1 += "  AND BM1_TIPO    = '1'  " + cEnter
   cStrSQL1 += "  AND BM1_CODPLA IN ('0063','0065')  " + cEnter
   cStrSQL1 += "  AND BM1_CODTIP IN ('118','902','904')  " + cEnter
   cStrSQL1 += "  AND BA1_FILIAL  =  BM1_FILIAL  " + cEnter
   cStrSQL1 += "  AND BA1_CODINT  =  BM1_CODINT  " + cEnter
   cStrSQL1 += "  AND BA1_CODEMP  =  BM1_CODEMP  " + cEnter
   cStrSQL1 += "  AND BA1_MATRIC  =  BM1_MATRIC  " + cEnter
   cStrSQL1 += "  AND BA1_TIPREG  =  BM1_TIPREG  " + cEnter
   cStrSQL1 += "  AND BA1_DIGITO  =  BM1_DIGITO  " + cEnter
   cStrSQL1 += "  AND BA3_FILIAL  =  BA1_FILIAL  " + cEnter
   cStrSQL1 += "  AND BA3_CODINT  =  BA1_CODINT  " + cEnter
   cStrSQL1 += "  AND BA3_CODEMP  =  BA1_CODEMP  " + cEnter
   cStrSQL1 += "  AND BA3_MATRIC  =  BA1_MATRIC  " + cEnter
   cStrSQL1 += "  AND BA3_CONEMP  =  BA1_CONEMP  " + cEnter
   cStrSQL1 += "  AND BA3_VERCON  =  '001'  " + cEnter
   cStrSQL1 += "  AND BFQ_FILIAL  =  BM1_FILIAL  " + cEnter
   cStrSQL1 += "  AND BFQ_CODINT  =  BM1_CODINT  " + cEnter
   cStrSQL1 += "  AND BFQ_PROPRI || BFQ_CODLAN = BM1_CODTIP  " + cEnter
   cStrSQL1 += "  AND BRP_FILIAL  = ' '  " + cEnter
   cStrSQL1 += "  AND BRP_CODIGO  = BA1_GRAUPA  " + cEnter
   cStrSQL1 += "  AND RA_FILIAL   = '01'  " + cEnter
   cStrSQL1 += "  AND RA_MAT      = SUBSTR(BA1_MATEMP,1,6)  " + cEnter
   cStrSQL1 += "  AND BM1.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BA1.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BA3.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BFQ.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND BRP.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "  AND SRA.D_E_L_E_T_ = ' '  " + cEnter
   cStrSQL1 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), '476', 'V' , 'I', RA_SITFOLH , RA_CC  " + cEnter
   cStrSQL1 += "ORDER BY 1, 2, 3  " + cEnter
   //+-----------------------------------------------------+
   //| Salva a query acima para futuras verificacoes       |
   //+-----------------------------------------------------+
   Memowrit( _cPath+"MENSALID.sql", cStrSQL1 )

endif  //Query de M E N S A L I D A D E S



if _nOpcao = 2 

   //+-------------------------------------------------------------------------------------------------------+
   //| Query de C O - P A R T I C I P A C A O                                                                |
   //+-------------------------------------------------------------------------------------------------------+
   cStrSQL2 := "SELECT RA_FILIAL  FILIAL " + cEnter
   cStrSQL2 += "     , SubStr(BA1_MATEMP,1,6)MATRICULA " + cEnter
   cStrSQL2 += "     , '479'      VERBA " + cEnter
   cStrSQL2 += "     , 'V'        TIPO1 " + cEnter
   cStrSQL2 += "     , Sum (  BM1_VALOR  )   VALOR " + cEnter
   cStrSQL2 += "     , RA_CC      CCUSTO " + cEnter
   cStrSQL2 += "     , 'I'        TIPO2 " + cEnter
   cStrSQL2 += "     , '"+DTOS(mv_par01)+"'  DTPGTO " + cEnter
   cStrSQL2 += "     , RA_SITFOLH SITUACAO " + cEnter
   cStrSQL2 += "FROM SIGA.BM1020 BM1 " + cEnter
   cStrSQL2 += "   , SIGA.BA1020 BA1 " + cEnter
   cStrSQL2 += "   , SIGA.BA3020 BA3 " + cEnter
   cStrSQL2 += ", SIGA.BFQ020 BFQ " + cEnter
   cStrSQL2 += "   , SIGA.BRP020 BRP " + cEnter
   cStrSQL2 += "   , SIGA.SRA010 SRA " + cEnter
   cStrSQL2 += "WHERE BM1_FILIAL  =  ' ' " + cEnter
   cStrSQL2 += "  AND (BA1_TIPUSU =  'T' AND BA1_NOMTIT  = ' ') " + cEnter
   cStrSQL2 += "AND BM1_PREFIX  =  'PLS' " + cEnter
   cStrSQL2 += "  AND BM1_TIPTIT  =  'DP' " + cEnter
   cStrSQL2 += "  AND BM1_NUMTIT  =  '"+mv_par08+"' " + cEnter
   cStrSQL2 += "  AND BA1_NOMTIT  =  ' ' " + cEnter
   cStrSQL2 += "  AND BFQ_YTPANL  =  'C' " + cEnter
   cStrSQL2 += "  AND BM1_TIPO    =  '1' " + cEnter
   cStrSQL2 += "  AND BM1_CODPLA IN  ('0063','0065') " + cEnter
   cStrSQL2 += "  AND BM1_CODTIP IN  ('151', '904') " + cEnter
   cStrSQL2 += "  AND BA1_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL2 += "  AND BA1_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL2 += "  AND BA1_CODEMP  =  BM1_CODEMP " + cEnter
   cStrSQL2 += "  AND BA1_MATRIC  =  BM1_MATRIC " + cEnter
   cStrSQL2 += "  AND BA1_TIPREG  =  BM1_TIPREG " + cEnter
   cStrSQL2 += "  AND BA1_DIGITO  =  BM1_DIGITO " + cEnter
   cStrSQL2 += "  AND BA3_FILIAL  =  BA1_FILIAL " + cEnter
   cStrSQL2 += "  AND BA3_CODINT  =  BA1_CODINT " + cEnter
   cStrSQL2 += "  AND BA3_CODEMP  =  BA1_CODEMP " + cEnter
   cStrSQL2 += "  AND BA3_MATRIC  =  BA1_MATRIC " + cEnter
   cStrSQL2 += "  AND BA3_CONEMP  =  BA1_CONEMP " + cEnter
   cStrSQL2 += "  AND BA3_VERCON  =  '001' " + cEnter
   cStrSQL2 += "  AND BFQ_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL2 += "  AND BFQ_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL2 += "  AND BFQ_PROPRI || BFQ_CODLAN = BM1_CODTIP " + cEnter
   cStrSQL2 += "  AND BRP_FILIAL  = ' ' " + cEnter
   cStrSQL2 += "  AND BRP_CODIGO  = BA1_GRAUPA " + cEnter
   cStrSQL2 += "  AND RA_FILIAL   = '01' " + cEnter
   cStrSQL2 += "  AND RA_MAT      = SUBSTR(BA1_MATEMP,1,6) " + cEnter
   cStrSQL2 += "  AND BM1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BA1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BA3.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BFQ.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BRP.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND SRA.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), '479', 'V', 'I', RA_SITFOLH , RA_CC " + cEnter

   cStrSQL2 += "UNION ALL " + cEnter

   cStrSQL2 += "SELECT RA_FILIAL FILIAL " + cEnter
   cStrSQL2 += "     , SubStr(BA1_MATEMP,1,6) MATRICULA " + cEnter
   cStrSQL2 += "     , '481'      VERBA " + cEnter
   cStrSQL2 += "     , 'V'        TIPO1 " + cEnter
   cStrSQL2 += "     , SUM ( BM1_VALOR  )  VALOR " + cEnter
   cStrSQL2 += "     , RA_CC      CCUSTO " + cEnter
   cStrSQL2 += "     , 'I'        TIPO2 " + cEnter
   cStrSQL2 += "     , '"+DTOS(mv_par01)+"'  DTPGTO " + cEnter 
   cStrSQL2 += "     , RA_SITFOLH SITUACAO " + cEnter
   cStrSQL2 += "FROM SIGA.BM1020 BM1 " + cEnter
   cStrSQL2 += "   , SIGA.BA1020 BA1 " + cEnter
   cStrSQL2 += "   , SIGA.BA3020 BA3 " + cEnter
   cStrSQL2 += "   , SIGA.BFQ020 BFQ " + cEnter
   cStrSQL2 += "   , SIGA.BRP020 BRP " + cEnter
   cStrSQL2 += "   , SIGA.SRA010 SRA " + cEnter
   cStrSQL2 += "WHERE BM1_FILIAL  =  ' ' " + cEnter
   cStrSQL2 += "  AND ((BA1_TIPUSU  =  'D')  OR (BA1_TIPUSU  =  'T' and BA1_NOMTIT  <> ' ')) " + cEnter
   cStrSQL2 += "  AND BM1_PREFIX  =  'PLS' " + cEnter
   cStrSQL2 += "  AND BM1_TIPTIT  =  'DP' " + cEnter
   cStrSQL2 += "  AND BM1_NUMTIT  =  '"+mv_par08+"' " + cEnter
   cStrSQL2 += "  AND BFQ_YTPANL  =  'C' " + cEnter
   cStrSQL2 += "  AND BM1_TIPO    =  '1' " + cEnter
   cStrSQL2 += "  AND BM1_CODPLA IN  ('0063','0065') " + cEnter
   cStrSQL2 += "  AND BM1_CODTIP IN  ('151','904' ) " + cEnter
   cStrSQL2 += "  AND BA1_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL2 += "  AND BA1_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL2 += "  AND BA1_CODEMP  =  BM1_CODEMP " + cEnter
   cStrSQL2 += "  AND BA1_MATRIC  =  BM1_MATRIC " + cEnter
   cStrSQL2 += "  AND BA1_TIPREG  =  BM1_TIPREG " + cEnter
   cStrSQL2 += "  AND BA1_DIGITO  =  BM1_DIGITO " + cEnter
   cStrSQL2 += "  AND BA3_FILIAL  =  BA1_FILIAL " + cEnter
   cStrSQL2 += "  AND BA3_CODINT  =  BA1_CODINT " + cEnter
   cStrSQL2 += "  AND BA3_CODEMP  =  BA1_CODEMP " + cEnter
   cStrSQL2 += "  AND BA3_MATRIC  =  BA1_MATRIC " + cEnter
   cStrSQL2 += "  AND BA3_CONEMP  =  BA1_CONEMP " + cEnter
   cStrSQL2 += "  AND BA3_VERCON  =  '001' " + cEnter
   cStrSQL2 += "  AND BFQ_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL2 += "  AND BFQ_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL2 += "  AND BFQ_PROPRI || BFQ_CODLAN = BM1_CODTIP " + cEnter
   cStrSQL2 += "  AND BRP_FILIAL  = ' ' " + cEnter
   cStrSQL2 += "  AND BRP_CODIGO  = BA1_GRAUPA " + cEnter
   cStrSQL2 += "  AND RA_FILIAL   = '01' " + cEnter
   cStrSQL2 += "  AND RA_MAT      = SUBSTR(BA1_MATEMP,1,6) " + cEnter
   cStrSQL2 += "  AND BM1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BA1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BA3.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BFQ.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BRP.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND SRA.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), '481', 'V', 'I', RA_SITFOLH , RA_CC " + cEnter

   cStrSQL2 += "UNION ALL " + cEnter

   cStrSQL2 += "SELECT RA_FILIAL  FILIAL " + cEnter
   cStrSQL2 += "     , SubStr(BA1_MATEMP,1,6)MATRICULA " + cEnter
   cStrSQL2 += "     , '191'      VERBA " + cEnter
   cStrSQL2 += "     , 'V'        TIPO1 " + cEnter
   cStrSQL2 += "     , Sum (  BM1_VALOR  )   VALOR " + cEnter
   cStrSQL2 += "     , RA_CC      CCUSTO " + cEnter
   cStrSQL2 += "     , 'I'        TIPO2 " + cEnter
   cStrSQL2 += "     , '"+DTOS(mv_par01)+"'  DTPGTO " + cEnter
   cStrSQL2 += "     , RA_SITFOLH SITUACAO " + cEnter
   cStrSQL2 += "FROM SIGA.BM1020 BM1 " + cEnter
   cStrSQL2 += "   , SIGA.BA1020 BA1 " + cEnter
   cStrSQL2 += "   , SIGA.BA3020 BA3 " + cEnter
   cStrSQL2 += "   , SIGA.BFQ020 BFQ " + cEnter
   cStrSQL2 += "   , SIGA.BRP020 BRP " + cEnter
   cStrSQL2 += "   , SIGA.SRA010 SRA " + cEnter
   cStrSQL2 += "WHERE BM1_FILIAL  =  ' ' " + cEnter
*  cStrSQL2 += "  AND (BA1_TIPUSU =  'T' AND BA1_NOMTIT  = ' ') " + cEnter
   cStrSQL2 += "  AND BM1_PREFIX  =  'PLS' " + cEnter
   cStrSQL2 += "  AND BM1_TIPTIT  =  'DP' " + cEnter
   cStrSQL2 += "  AND BM1_NUMTIT  =  '"+mv_par08+"' " + cEnter
   cStrSQL2 += "  AND BA1_NOMTIT  =  ' ' " + cEnter
   cStrSQL2 += "  AND BFQ_YTPANL  =  'C' " + cEnter
   cStrSQL2 += "  AND BM1_TIPO    =  '2' " + cEnter
   cStrSQL2 += "  AND BM1_CODPLA IN  ('0063','0065') " + cEnter
   cStrSQL2 += "  AND BM1_CODTIP IN  ('901', '905') " + cEnter
   cStrSQL2 += "  AND BA1_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL2 += "  AND BA1_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL2 += "  AND BA1_CODEMP  =  BM1_CODEMP " + cEnter
   cStrSQL2 += "  AND BA1_MATRIC  =  BM1_MATRIC " + cEnter
   cStrSQL2 += "  AND BA1_TIPREG  =  BM1_TIPREG " + cEnter
   cStrSQL2 += "  AND BA1_DIGITO  =  BM1_DIGITO " + cEnter
   cStrSQL2 += "  AND BA3_FILIAL  =  BA1_FILIAL " + cEnter
   cStrSQL2 += "  AND BA3_CODINT  =  BA1_CODINT " + cEnter
   cStrSQL2 += "  AND BA3_CODEMP  =  BA1_CODEMP " + cEnter
   cStrSQL2 += "  AND BA3_MATRIC  =  BA1_MATRIC " + cEnter
   cStrSQL2 += "  AND BA3_CONEMP  =  BA1_CONEMP " + cEnter
   cStrSQL2 += "  AND BA3_VERCON  =  '001' " + cEnter
   cStrSQL2 += "  AND BFQ_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL2 += "  AND BFQ_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL2 += "  AND BFQ_PROPRI || BFQ_CODLAN = BM1_CODTIP " + cEnter
   cStrSQL2 += "  AND BRP_FILIAL  = ' ' " + cEnter
   cStrSQL2 += "  AND BRP_CODIGO  = BA1_GRAUPA " + cEnter
   cStrSQL2 += "  AND RA_FILIAL   = '01' " + cEnter
   cStrSQL2 += "  AND RA_MAT      = SUBSTR(BA1_MATEMP,1,6) " + cEnter
   cStrSQL2 += "  AND BM1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BA1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BA3.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BFQ.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND BRP.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "  AND SRA.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL2 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), '191', 'V', 'I', RA_SITFOLH , RA_CC " + cEnter
   cStrSQL2 += "ORDER BY 1, 2, 3 " + cEnter
   //+-----------------------------------------------------+
   //| Salva a query acima para futuras verificacoes       |
   //+-----------------------------------------------------+
   Memowrit( _cPath+"COPARTIC.sql", cStrSQL2 )

endif  //Query de C O - P A R T I C I P A C O



if _nOpcao = 3 

   //+-------------------------------------------------------------------------------------------------------+
   //| Query de O D O N T O L O G I C O                                                                      | 
   //+-------------------------------------------------------------------------------------------------------+
   cStrSQL3 := "SELECT RA_FILIAL  FILIAL " + cEnter
   cStrSQL3 += "     , SubStr(BA1_MATEMP,1,6)   MATRICULA " + cEnter
   cStrSQL3 += "     , '473'      VERBA " + cEnter
   cStrSQL3 += "     , 'V'        TIPO1 " + cEnter
   cStrSQL3 += "     , 'I'        TIPO2 " + cEnter
   cStrSQL3 += "     , RA_CC      CCUSTO " + cEnter
   cStrSQL3 += "     , Sum (  BM1_VALOR  )   VAL_BM1 " + cEnter
   cStrSQL3 += "     , SUM ( ( CASE WHEN BM1_CODPLA IN ('0037') THEN " + cEnter
   cStrSQL3 += "                 BM1_VALOR - (SELECT BTN_VALFAI " + cEnter
   cStrSQL3 += "                              FROM SIGA.BTN020 BTN " + cEnter
   cStrSQL3 += "                           WHERE BTN.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "                                AND BTN_FILIAL = '  ' " + cEnter
   cStrSQL3 += "                                AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP " + cEnter
   cStrSQL3 += "                                AND BTN_NUMCON = BM1_CONEMP " + cEnter
   cStrSQL3 += "                                AND BTN_VERCON = BM1_VERCON " + cEnter
   cStrSQL3 += "                                AND BTN_SUBCON = BM1_SUBCON " + cEnter
   cStrSQL3 += "                                AND BTN_VERSUB = BM1_VERSUB " + cEnter
   cStrSQL3 += "                                AND BTN_CODPRO = '0037' " + cEnter
   cStrSQL3 += "                                AND BTN_VERPRO = BM1_VERPLA " + cEnter
   cStrSQL3 += "                                AND BTN_CODFOR = BM1_CODTIP " + cEnter
   cStrSQL3 += "                                AND BTN_CODQTD = '001' " + cEnter
   cStrSQL3 += "                                AND BTN_IDAINI = BM1_IDAINI " + cEnter
   cStrSQL3 += "                                AND BTN_IDAFIN = BM1_IDAFIN " + cEnter
   cStrSQL3 += "                                AND BTN_CODFAI = BM1_CODFAI) " + cEnter
   cStrSQL3 += "         END    )   ) VALOR " + cEnter
   cStrSQL3 += "     , '"+DTOS(mv_par01)+"'    DTPGTO " + cEnter   
   cStrSQL3 += "     , RA_SITFOLH SITUACAO " + cEnter
   cStrSQL3 += "FROM SIGA.BM1020 BM1 " + cEnter
   cStrSQL3 += "   , SIGA.BA1020 BA1 " + cEnter
   cStrSQL3 += "   , SIGA.BA3020 BA3 " + cEnter
   cStrSQL3 += "   , SIGA.BFQ020 BFQ " + cEnter
   cStrSQL3 += "   , SIGA.BRP020 BRP " + cEnter
   cStrSQL3 += "   , SIGA.SRA010 SRA " + cEnter
   cStrSQL3 += "WHERE BM1_FILIAL  =  ' ' " + cEnter
   cStrSQL3 += "  AND (BA1_TIPUSU =  'T' AND BA1_NOMTIT  = ' ') " + cEnter
   cStrSQL3 += "  AND BM1_PREFIX  =  'PLS' " + cEnter
   cStrSQL3 += "  AND BM1_TIPTIT  =  'DP' " + cEnter
   cStrSQL3 += "  AND BM1_NUMTIT  =  '"+mv_par08+"' " + cEnter   
   cStrSQL3 += "  AND BA1_NOMTIT  = ' ' " + cEnter
   cStrSQL3 += "  AND BFQ_YTPANL  = 'M' " + cEnter
   cStrSQL3 += "  AND BM1_TIPO    = '1' " + cEnter
   cStrSQL3 += "  AND BM1_CODPLA IN ('0037') " + cEnter
   cStrSQL3 += "  AND BM1_CODTIP IN ('101','118') " + cEnter
   cStrSQL3 += "  AND BA1_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL3 += "  AND BA1_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL3 += "  AND BA1_CODEMP  =  BM1_CODEMP " + cEnter
   cStrSQL3 += "  AND BA1_MATRIC  =  BM1_MATRIC " + cEnter
   cStrSQL3 += "  AND BA1_TIPREG  =  BM1_TIPREG " + cEnter
   cStrSQL3 += "  AND BA1_DIGITO  =  BM1_DIGITO " + cEnter
   cStrSQL3 += "  AND BA3_FILIAL  =  BA1_FILIAL " + cEnter
   cStrSQL3 += "  AND BA3_CODINT  =  BA1_CODINT " + cEnter
   cStrSQL3 += "  AND BA3_CODEMP  =  BA1_CODEMP " + cEnter
   cStrSQL3 += "  AND BA3_MATRIC  =  BA1_MATRIC " + cEnter
   cStrSQL3 += "  AND BA3_CONEMP  =  BA1_CONEMP " + cEnter
   cStrSQL3 += "  AND BA3_VERCON  =  '001' " + cEnter
   cStrSQL3 += "  AND BFQ_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL3 += "  AND BFQ_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL3 += "  AND BFQ_PROPRI || BFQ_CODLAN = BM1_CODTIP " + cEnter
   cStrSQL3 += "  AND BRP_FILIAL  = ' ' " + cEnter
   cStrSQL3 += "  AND BRP_CODIGO  = BA1_GRAUPA " + cEnter
   cStrSQL3 += "  AND RA_FILIAL   = '01' " + cEnter
   cStrSQL3 += "  AND RA_MAT      = SUBSTR(BA1_MATEMP,1,6) " + cEnter
   cStrSQL3 += "  AND BM1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND BA1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND BA3.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND BFQ.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND BRP.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND SRA.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), '473', 'V', 'I', RA_CC, RA_SITFOLH " + cEnter
 
   cStrSQL3 += "UNION ALL " + cEnter

   cStrSQL3 += "SELECT RA_FILIAL  FILIAL " + cEnter
   cStrSQL3 += "     , SubStr(BA1_MATEMP,1,6) MATRICULA " + cEnter
   cStrSQL3 += "     , '474'      VERBA " + cEnter
   cStrSQL3 += "     , 'V'        TIPO1 " + cEnter
   cStrSQL3 += "     , 'I'        TIPO2 " + cEnter
   cStrSQL3 += "     , RA_CC      CCUSTO " + cEnter
   cStrSQL3 += "     , Sum (  BM1_VALOR  )   VAL_BM1 " + cEnter
   cStrSQL3 += "     , Sum ( ( CASE WHEN BM1_CODPLA IN ('0037') THEN BM1_VALOR " + cEnter
   cStrSQL3 += "              ELSE " + cEnter
   cStrSQL3 += "                  (SELECT BTN_VALFAI " + cEnter
   cStrSQL3 += "                   FROM SIGA.BTN020 BTN " + cEnter
   cStrSQL3 += "                   WHERE BTN.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "                     AND BTN_FILIAL = '  ' " + cEnter
   cStrSQL3 += "                     AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP " + cEnter
   cStrSQL3 += "                     AND BTN_NUMCON = BM1_CONEMP " + cEnter
   cStrSQL3 += "                     AND BTN_VERCON = BM1_VERCON " + cEnter
   cStrSQL3 += "                     AND BTN_SUBCON = BM1_SUBCON " + cEnter
   cStrSQL3 += "                     AND BTN_VERSUB = BM1_VERSUB " + cEnter
   cStrSQL3 += "                     AND BTN_CODPRO = '0037' " + cEnter
   cStrSQL3 += "                     AND BTN_VERPRO = BM1_VERPLA " + cEnter
   cStrSQL3 += "                     AND BTN_CODFOR = BM1_CODTIP " + cEnter
   cStrSQL3 += "                     AND BTN_CODQTD = '001' " + cEnter
   cStrSQL3 += "                     AND BTN_IDAINI = BM1_IDAINI " + cEnter
   cStrSQL3 += "                     AND BTN_IDAFIN = BM1_IDAFIN " + cEnter
   cStrSQL3 += "                     AND BTN_CODFAI = BM1_CODFAI) " + cEnter
   cStrSQL3 += "        END   )    ) VALOR " + cEnter
   cStrSQL3 += "     , '"+DTOS(mv_par01)+"'    DTPGTO " + cEnter   
   cStrSQL3 += "     , RA_SITFOLH SITUACAO " + cEnter
   cStrSQL3 += "FROM SIGA.BM1020 BM1 " + cEnter
   cStrSQL3 += "   , SIGA.BA1020 BA1 " + cEnter
   cStrSQL3 += "   , SIGA.BA3020 BA3 " + cEnter
   cStrSQL3 += "   , SIGA.BFQ020 BFQ " + cEnter
   cStrSQL3 += "   , SIGA.BRP020 BRP " + cEnter
   cStrSQL3 += "   , SIGA.SRA010 SRA " + cEnter
   cStrSQL3 += "WHERE BM1_FILIAL  =  ' ' " + cEnter
   cStrSQL3 += "  AND ((BA1_TIPUSU  =  'D') " + cEnter
   cStrSQL3 += "   OR ( BA1_TIPUSU  =  'T' AND BA1_NOMTIT  <> ' ') ) " + cEnter
   cStrSQL3 += "  AND BM1_PREFIX  =  'PLS' " + cEnter
   cStrSQL3 += "  AND BM1_TIPTIT  =  'DP' " + cEnter
   cStrSQL3 += "  AND BM1_NUMTIT  =  '"+mv_par08+"' " + cEnter     
   cStrSQL3 += "  AND BFQ_YTPANL  = 'M' " + cEnter
   cStrSQL3 += "  AND BM1_TIPO    = '1' " + cEnter
   cStrSQL3 += "  AND BM1_CODPLA IN ('0037') " + cEnter
   cStrSQL3 += "  AND BM1_CODTIP IN ('101','118') " + cEnter
   cStrSQL3 += "  AND BA1_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL3 += "  AND BA1_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL3 += "  AND BA1_CODEMP  =  BM1_CODEMP " + cEnter
   cStrSQL3 += "  AND BA1_MATRIC  =  BM1_MATRIC " + cEnter
   cStrSQL3 += "  AND BA1_TIPREG  =  BM1_TIPREG " + cEnter
   cStrSQL3 += "  AND BA1_DIGITO  =  BM1_DIGITO " + cEnter
   cStrSQL3 += "  AND BA3_FILIAL  =  BA1_FILIAL " + cEnter
   cStrSQL3 += "  AND BA3_CODINT  =  BA1_CODINT " + cEnter
   cStrSQL3 += "  AND BA3_CODEMP  =  BA1_CODEMP " + cEnter
   cStrSQL3 += "  AND BA3_MATRIC  =  BA1_MATRIC " + cEnter
   cStrSQL3 += "  AND BA3_CONEMP  =  BA1_CONEMP " + cEnter
   cStrSQL3 += "  AND BA3_VERCON  =  '001' " + cEnter
   cStrSQL3 += "  AND BFQ_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL3 += "  AND BFQ_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL3 += "  AND BFQ_PROPRI || BFQ_CODLAN = BM1_CODTIP " + cEnter
   cStrSQL3 += "  AND BRP_FILIAL  = ' ' " + cEnter
   cStrSQL3 += "  AND BRP_CODIGO  = BA1_GRAUPA " + cEnter
   cStrSQL3 += "  AND RA_FILIAL   = '01' " + cEnter
   cStrSQL3 += "  AND RA_MAT      = SUBSTR(BA1_MATEMP,1,6) " + cEnter
   cStrSQL3 += "  AND BM1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND BA1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND BA3.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND BFQ.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND BRP.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "  AND SRA.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL3 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), '474', 'V', 'I', RA_CC, RA_SITFOLH " + cEnter
   cStrSQL3 += "ORDER BY 1, 2, 3 " + cEnter
   //+-----------------------------------------------------+
   //| Salva a query acima para futuras verificacoes       |
   //+-----------------------------------------------------+
   Memowrit( _cPath+"ODONTOLO.sql", cStrSQL3 )

endif   // Query de O D O N T O L O G I C O



if _nOpcao = 4

   //+-------------------------------------------------------------------------------------------------------+
   //| Query de A G R E G A D O S                                                                            |
   //+-------------------------------------------------------------------------------------------------------+
   cStrSQL4 := "SELECT RA_FILIAL  FILIAL " + cEnter
   cStrSQL4 += "     , SubStr(BA1_MATEMP,1,6)   MATRICULA " + cEnter
   cStrSQL4 += "     , '478'      VERBA " + cEnter
   cStrSQL4 += "     , 'V'        TIPO1 " + cEnter
   cStrSQL4 += "     , Sum( BM1_VALOR )   VLR_BM1 " + cEnter
   cStrSQL4 += "     , Sum ( (SELECT BTN_VALFAI " + cEnter
   cStrSQL4 += "              FROM SIGA.BTN020 BTN " + cEnter
   cStrSQL4 += "              WHERE BTN.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL4 += "                AND BTN_FILIAL = '  ' " + cEnter
   cStrSQL4 += "                AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP " + cEnter
   cStrSQL4 += "                AND BTN_NUMCON = BM1_CONEMP " + cEnter
   cStrSQL4 += "                AND BTN_VERCON = BM1_VERCON " + cEnter
   cStrSQL4 += "                AND BTN_SUBCON = BM1_SUBCON " + cEnter
   cStrSQL4 += "                AND BTN_VERSUB = BM1_VERSUB " + cEnter
   cStrSQL4 += "                AND BTN_CODPRO = BM1_CODPLA " + cEnter
   cStrSQL4 += "                AND BTN_VERPRO = BM1_VERPLA " + cEnter
   cStrSQL4 += "                AND BTN_CODFOR = BM1_CODTIP " + cEnter
   cStrSQL4 += "                AND BTN_CODQTD = '001' " + cEnter
   cStrSQL4 += "                AND BTN_IDAINI = BM1_IDAINI " + cEnter
   cStrSQL4 += "                AND BTN_IDAFIN = BM1_IDAFIN " + cEnter
   cStrSQL4 += "                AND BTN_CODFAI = BM1_CODFAI ) )  VLR_ORIG " + cEnter
   cStrSQL4 += "     , Sum ( (SELECT BTN_VALFAI " + cEnter
   cStrSQL4 += "              FROM SIGA.BTN020 BTN " + cEnter
   cStrSQL4 += "              WHERE BTN.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL4 += "                AND BTN_FILIAL = '  ' " + cEnter
   cStrSQL4 += "                AND BTN_CODIGO = BM1_CODINT||BM1_CODEMP " + cEnter
   cStrSQL4 += "                AND BTN_NUMCON = BM1_CONEMP " + cEnter
   cStrSQL4 += "                AND BTN_VERCON = BM1_VERCON " + cEnter
   cStrSQL4 += "                AND BTN_SUBCON = BM1_SUBCON " + cEnter
   cStrSQL4 += "                AND BTN_VERSUB = BM1_VERSUB " + cEnter
   cStrSQL4 += "                AND BTN_CODPRO = '0063'      " + cEnter
   cStrSQL4 += "                AND BTN_VERPRO = BM1_VERPLA " + cEnter
   cStrSQL4 += "                AND BTN_CODFOR = BM1_CODTIP " + cEnter
   cStrSQL4 += "                AND BTN_CODQTD = '001' " + cEnter
   cStrSQL4 += "                AND BTN_IDAINI = BM1_IDAINI " + cEnter
   cStrSQL4 += "                AND BTN_IDAFIN = BM1_IDAFIN " + cEnter
   cStrSQL4 += "                AND BTN_CODFAI = BM1_CODFAI ) ) VLR_PG " + cEnter
   cStrSQL4 += "     , RA_CC      CCUSTO " + cEnter
   cStrSQL4 += "     , 'I'        TIPO2 " + cEnter
   cStrSQL4 += "     , '"+DTOS(mv_par01)+"'    DTPGTO " + cEnter
   cStrSQL4 += "     , RA_SITFOLH    SITUACAO " + cEnter
   cStrSQL4 += "FROM SIGA.BA1020  BA1 " + cEnter
   cStrSQL4 += "   , SIGA.BM1020  BM1 " + cEnter
   cStrSQL4 += "   , SIGA.SRA010  SRA " + cEnter
   cStrSQL4 += "WHERE BA1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL4 += "  AND BM1.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL4 += "  AND SRA.D_E_L_E_T_ = ' ' " + cEnter
   cStrSQL4 += "  AND BA1_BLOFAT    <> '1' " + cEnter
   cStrSQL4 += "  AND BA1_FILIAL  =  BM1_FILIAL " + cEnter
   cStrSQL4 += "  AND BA1_CODINT  =  BM1_CODINT " + cEnter
   cStrSQL4 += "  AND BA1_CODEMP  =  BM1_CODEMP " + cEnter
   cStrSQL4 += "  AND BA1_MATRIC  =  BM1_MATRIC " + cEnter
   cStrSQL4 += "  AND BA1_CONEMP  =  BM1_CONEMP " + cEnter
   cStrSQL4 += "  AND BA1_VERCON  =  '001' " + cEnter
   cStrSQL4 += "  AND BM1_PREFIX  =  'PLS' " + cEnter
   cStrSQL4 += "  AND BM1_TIPTIT  =  'DP' " + cEnter
   cStrSQL4 += "  AND BM1_NUMTIT  =  '"+mv_par08+"' " + cEnter  
   cStrSQL4 += "  AND BM1_TIPUSU  =  'T' " + cEnter
   cStrSQL4 += "  AND BM1_TIPO    = '1' " + cEnter
   cStrSQL4 += "  AND BM1_CODPLA IN ('0063','0065') " + cEnter
   cStrSQL4 += "  AND BM1_CODTIP IN ('101') " + cEnter
   cStrSQL4 += "  AND RA_FILIAL   = '01' " + cEnter
   cStrSQL4 += "  AND RA_MAT      = SUBSTR(BA1_MATEMP,1,6) " + cEnter
   cStrSQL4 += "  AND ( BM1_NOMUSR LIKE  'MARIA DAS GRACAS BANDEIRA%' " + cEnter
   cStrSQL4 += "  OR    BM1_NOMUSR LIKE  'RAPHAEL DE AQUINO%' " + cEnter
   cStrSQL4 += "  OR    BM1_NOMUSR LIKE  'JOSELLY MARA SANTOS%' " + cEnter
   cStrSQL4 += "  OR    BM1_NOMUSR LIKE  'MARIA JULIA   %' " + cEnter
   cStrSQL4 += "  OR    BM1_NOMUSR LIKE  'ANDRE CAVALCANTE SOARES%' ) " + cEnter
   cStrSQL4 += "GROUP BY RA_FILIAL, SubStr(BA1_MATEMP,1,6), '478', 'V', 'I', RA_SITFOLH, RA_CC " + cEnter
   cStrSQL4 += "ORDER BY 1,2,3 " + cEnter
   //+-----------------------------------------------------+
   //| Salva a query acima para futuras verificacoes       |
   //+-----------------------------------------------------+
   Memowrit( _cPath+"AGREGADO.SQL", cStrSQL4 )

endif  //Query de A G R E G A D O S 

return  


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
Aadd(aRegs,{cPerg , "02" , "Informe o ANO (PLS) ?" ,"","", "mv_ch2" , "C" , 04 ,0 ,0 , "G" , "" , "mv_par02" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "03" , "Informe o MES (PLS) ?" ,"","", "mv_ch3" , "C" , 02 ,0 ,0 , "G" , "" , "mv_par03" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "04" , "Tipo Lancamento     ?" ,"","", "mv_ch4" , "C" , 12 ,0 ,0 , "G" , "" , "mv_par04" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "05" , "Gera informacoes de ?" ,"","", "mv_ch5" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par05" , "Mensalidade" , "" , "" , "" , "" , "Co-participacao" , "" , "" , "" , "" , "Odontologico" , "" , "" , "" , "" , "Agregados"    , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "06" , "Integra Folha       ?" ,"","", "mv_ch6" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par06" , "SIM"         , "" , "" , "" , "" , "NAO"             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "07" , "Consultar em Excel  ?" ,"","", "mv_ch7" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par07" , "SIM"         , "" , "" , "" , "" , "NAO"             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "08" , "Informe Num.Titulo  ?" ,"","", "mv_ch8" , "C" , 09 ,0 ,0 , "G" , "" , "mv_par08" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "     " , "" }) 
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


// Fim do CABA061.PRW
