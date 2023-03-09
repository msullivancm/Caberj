#Include "PROTHEUS.CH"
#Include "UTILIDADES.CH"
#INCLUDE "rwmake.ch"

/*------------------------------------------------------------------------
| Funcao    | MANUT14  | Otavio Pinto                  | Data | 29/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Preencher o campo A2_XDVAGE co digito verificador           |
|-------------------------------------------------------------------------|
| Uso       | DVAGE ( <Banco> , <Agencia>  )                              |
|           |            |          |                                     |
|           |            |          +----------> 4 digitos                |
|           |            +---------------------> 3 digitos                |
|           |                                                             |
|           | 001 BANCO DO BRASIL                                         |
|           | 237 BANCO BRADESCO                                          |
 ------------------------------------------------------------------------*/
user function MANUT14
private xEmpresa  := Strzero(Val(SM0->M0_CODIGO),2)                          
private cAlias2   := 'SA2'
private cLibOpc   := GetNewPar("MV_YESTFAR","000668")   

if ( __cUserID $ AllTrim(cLibOpc) )              
   if MsgBox("Rotina de Manutencao"+Chr(13)+"Atualiza os campos :"+Chr(13)+" A2_AGENCIA"+Chr(13)+" A2_XDVAGE",;
             "Selecione",;
             "YESNO")
      Processa( {|| RunProc() })
   endif
else
   msgstop("Voce não está habilitado a executar esta rotina...")
endif   
return


/*------------------------------------------------------------------------
| Funcao    | RunProc  | Otavio Pinto                  | Data | 29/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina de processamento                                     |
|           |                                                             |
 ------------------------------------------------------------------------*/
static function RunProc
RaDtPrev()
return


/*------------------------------------------------------------------------
| Funcao    | RaDtPrev | Otavio Pinto                  | Data | 29/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Rotina de Atualizacao do campo A2_XDVAGE                    |
|           |                                                             |
 ------------------------------------------------------------------------*/
static function RaDtPrev()
local cRet      := " "
local cQry      := " "
local cAgencia  := ""
private cEol    := CHR(13)+CHR(10)
private cBanco  := ""
dbSelectArea(cAlias2) ; (cAlias2)->( dbSetOrder(1) )

if  Select("TMP") > 0  ; TMP->( dbCloseArea() ) ; endif      
cQry := " SELECT A2_COD  "+cEol
cQry += "      , A2_BANCO "+cEol
cQry += "      , A2_AGENCIA "+cEol
cQry += "      , A2_NUMCON "+cEol
cQry += " FROM "+RetSqlName(cAlias2)+" A2 "+cEol
cQry += " WHERE A2_FILIAL = '"+xFilial(cAlias2)+"'" +cEol
cQry += "   AND A2_BANCO  IN ('001','237') " +cEol
cQry += "   AND A2.D_E_L_E_T_ = ' ' "+cEol
cQry += " ORDER BY A2_COD, A2_BANCO, A2_AGENCIA "+cEol

TcQuery cQry New Alias "TMP"

ProcRegua( TMP->( RecCount() ) )
TMP->( dbGotop() )

Do While TMP->( !Eof() )
   cBanco   := TMP->A2_BANCO
   cAgencia := TMP->A2_AGENCIA
   IncProc( TMP->(A2_COD+"  "+A2_BANCO+"  "+if(A2_BANCO == "001","BANCO DO BRASIL","BRADESCO") ) )
   if (cAlias2)->( dbSeek(xFilial(cAlias2)+TMP->A2_COD) ) 
      if (cAlias2)->(  len(Alltrim( A2_AGENCIA ) ) == 5 .and. Substr( A2_AGENCIA,1,1 ) == '0' )
         if Substr( (cAlias2)->A2_AGENCIA,5,1 ) == DVAGE( cBanco , Substr( (cAlias2)->A2_AGENCIA,1,4 ) )
            cAgencia := Substr( (cAlias2)->A2_AGENCIA,1,4 )
         else   
            cAgencia := Substr( (cAlias2)->A2_AGENCIA,2,4 )            
         endif   
      else   
         cAgencia := PADL( Alltrim(Substr( (cAlias2)->A2_AGENCIA,1,4 )), 4 , "0" )
      endif
      if RecLock(cAlias2,.F.)
         (cAlias2)->A2_AGENCIA:= cAgencia
         (cAlias2)->A2_XDVAGE := DVAGE( cBanco , cAgencia )
         (cAlias2)->( MsUnLock() )
      endif
   endif  
   TMP->( dbSkip() )
enddo
TMP->( dbCloseArea() ) 

return


/*------------------------------------------------------------------------
| Funcao    | DVAGE    | Otavio Pinto                  | Data | 27/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Função para calculo do digito verificador de agencia.       |
|           |                                                             |
|           |                                                             |
|           | 001 BANCO DO BRASIL / 237 BRADESCO                          |
|           |                                                             |
 ------------------------------------------------------------------------*/
static function DVAGE (cCodBco , cAgencia )
local nSoma  := nResto := nDV := 0
local cPeso  := "5432"
local nModulo:= 11
local cRet   := ""
if cCodBco $ "001^237" 
   cAgencia := PADL(Alltrim(cAgencia),4,"0")
   for i:=1 to len(Alltrim(cAgencia))
       nSoma += val(SUBSTR( cAgencia, i,1)) * val(SUBSTR( cPeso,i,1 ))
   next
   nResto := mod(nSoma,nModulo) 
   nDV    := int( nModulo - nResto )
   cRet   := Alltrim(if ( nDV == 10, if(cCodBco == '001','X','P'), if ( nDV == 11, '0', str(nDV) ) ) )   
endif   
return cRet

/* FIM DO MANUT14.PRW */



