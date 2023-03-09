#INCLUDE "rwmake.ch"
/*--------------------------------------------------------------------------
| Programa  | CABA075  | Autor | Otavio Pinto         | Data |  21/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Protocolo de Prevencao                                        |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
user function CABA075

/*--------------------------------------------------------------------------
| Declaracao de Variaveis                                                   |
 --------------------------------------------------------------------------*/

local cVldAlt   := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
local cVldExc   := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
local aRotAdic  := {} 

private cString := "ZUB"

AAdd( aRotAdic, { "Imprimir", "u_PLSRZUBIMP", 0, 4 } ) 

dbSelectArea(cString)

(cString)->( dbSetOrder(1) )

AxCadastro(cString,"Protocolo de Prevencao",cVldAlt,cVldExc,aRotAdic)

return


user function PLSRZUBIMP

/*--------------------------------------------------------------------------
|  Define Variaveis                                                         |
 --------------------------------------------------------------------------*/
local wnrel
local cDesc1 := "Este programa tem como objetivo imprimir o cadastro"
local cDesc2 := "do Protocolo de Prevencao (ZUB)"
local cDesc3 := ""
local cString := "ZUB"
local Tamanho := "P"

PRIVATE cTitulo:= "Cadastro do Protocolo de Prevencao"
PRIVATE cabec1
PRIVATE cabec2
Private aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
Private cPerg   := ""
Private nomeprog:= "PLSR075" 
Private nLastKey:=0

/*--------------------------------------------------------------------------
|  Definicao dos cabecalhos                                                 |
 --------------------------------------------------------------------------*/

cabec1:= "COD DESCRICAO                       VIG_INIG  VIG_FIN  ID_I ID_F SEXO RISCO "
//        000 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99 99/99/99  999  999   F     X
cabec2:= ""

/*--------------------------------------------------------------------------
|  Envia controle para a funcao SETPRINT                                    |
 --------------------------------------------------------------------------*/
wnrel := "PLSR075"

wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,,.F.)

If nLastKey == 27 ; return ; End

SetDefault(aReturn,cString)

If nLastKey == 27 ; return ( NIL ) ; End

RptStatus({|lEnd| ImpTipInt(@lEnd,wnRel,cString)},cTitulo)
Return


/*--------------------------------------------------------------------------
| Programa  | ImpTipInt | Autor | Otavio Pinto        | Data |  21/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Impressao do cadastro de Protocolo de Prevencao               |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
static function ImpTipInt(lEnd,wnRel,cString)
local cbcont,cbtxt
local tamanho:= "P"
local nTipo 

/*--------------------------------------------------------------------------
|  Variaveis utilizadas para Impressao do Cabecalho e Rodape                |
 --------------------------------------------------------------------------*/
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo    := GetMv("MV_COMP")

dbSelectArea("ZUB")
SetRegua( ZUB->( RecCount() ) )
ZUB->( dbGotop() )
lTitulo := .T.

while ZUB->( !Eof() )
		
	IncRegua()

    IF li > 58 ; CABEC(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo) ; End
	
    @ li,  000 PSAY PADR(ZUB->ZUB_SQPROT,03," ") +" "+ ;
                    PADR(ZUB->ZUB_DESCRI,30," ") +"  "+ ;
                    PADR(ZUB->( DTOC(ZUB_VIGINI) ),08," ") +" "+ ;
                    PADR(ZUB->( DTOC(ZUB_VIGFIN) ),08," ") +" "+ ;
                    PADR(ZUB->(  STR(ZUB_IDINI,3)),03," ") +"  "+ ;
                    PADR(ZUB->(  STR(ZUB_IDFIN,3)),03," ") +"   "+ ;
                    PADR(IF(ZUB->ZUB_SEXO=="1","M","F") ,01," ")+"      "+ ;
                    PADR(ZUB->ZUB_RISCO,1," ")

 	li++	
   	
   	ZUB->( dbSkip() )

End

if li != 80 ; roda(cbcont,cbtxt,tamanho) ; End

/*--------------------------------------------------------------------------
|  Recupera a Integridade dos dados                                         |
 --------------------------------------------------------------------------*/
dbSelectArea("ZUB")

set device to Screen

if aReturn[5] == 1
   Set Printer To
   dbCommitAll()
   OurSpool(wnrel)
endif

MS_FLUSH()

return
