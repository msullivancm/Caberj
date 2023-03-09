#INCLUDE "rwmake.ch"

/*------------------------------------------------------------------------
| Funcao    | DVAGENC  | Otavio Pinto                  | Data | 27/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Função para calculo do digito verificador de agencia.       |
|           |                                                             |
|           |                                                             |
|           | 001 BANCO DO BRASIL / 237 BRADESCO                          |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function DVAGENC (cCodBco, cAgencia)
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

/* Fim da rotina DVAGENC.PRW */