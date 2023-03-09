#Include "protheus.ch"
#Include "rwmake.ch"
/*------------------------------------------------------------------------- 
| Programa  |VldGrauPar    |Autor  |Otavio Pinto        | Data |  20/06/12 |
|--------------------------------------------------------------------------|
| Desc.     | Validacao para grau de parentesco - se consta no parametro   |
|           | MV_GRAUPAR                                                   |
|--------------------------------------------------------------------------|
| Uso       | inclusao de usuario                                          |
 -------------------------------------------------------------------------*/
user function VldGrauPar( _cParam )      
local   lRet     := .T.
local   cCodEmp 
private cGrauPar := GetMv("MV_GRAUPAR")

if !( _cParam $ AllTrim(cGrauPar)+", " ) .AND. cCodEmp == "0001"
   MsgAlert( "GRAU DE PARENTESCO "+M->BA1_GRAUPA+" nao pertence ao PLANO MATER...             "+CHR(13)+CHR(13)+;
             "Codigos disponiveis: "+cGrauPar   )
   lRet := .F.
endif

return lRet