#INCLUDE "rwmake.ch"
/*--------------------------------------------------------------------------
| Programa  | CABA074  | Autor | Otavio Pinto         | Data |  21/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Protocolo de Questionario                                     |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
user function CABA074

/*--------------------------------------------------------------------------
| Declaracao de Variaveis                                                   |
 --------------------------------------------------------------------------*/

local cVldAlt   := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
local cVldExc   := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
local aRotAdic  := {} 

private cString := "ZUA"

AAdd( aRotAdic, { "Imprimir", "u_PLSRZUAIMP", 0, 4 } ) 

dbSelectArea(cString)

(cString)->( dbSetOrder(1) )

AxCadastro(cString,"Protocolo de Questionario",cVldAlt,cVldExc,aRotAdic)

return



user function PLSRZUAIMP
/*--------------------------------------------------------------------------
|  Define Variaveis                                                         |
 --------------------------------------------------------------------------*/
local wnrel
local cDesc1 := "Este programa tem como objetivo imprimir o cadastro"
local cDesc2 := "do Protocolo de Questionario (ZUA)"
local cDesc3 := ""
local cString := "ZUA"
local Tamanho := "G"

PRIVATE cTitulo:= "Cadastro do Protocolo de Questionario"
PRIVATE cabec1
PRIVATE cabec2
Private aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
Private cPerg   := ""
Private nomeprog:= "PLSR074" 
Private nLastKey:=0

/*--------------------------------------------------------------------------
|  Definicao dos cabecalhos                                                 |
 --------------------------------------------------------------------------*/

cabec1:= "PROTOCOLO COD. PERGUNTA                                                                         COD RESPOSTA                                                                         Tp Pergunta"  
//        000000000 9999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  X  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXX
cabec2:= ""


/*--------------------------------------------------------------------------
|  Envia controle para a funcao SETPRINT                                    |
 --------------------------------------------------------------------------*/
wnrel := "PLSR074"

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
local tamanho:= "G"
local nTipo 

/*--------------------------------------------------------------------------
|  Variaveis utilizadas para Impressao do Cabecalho e Rodape                |
 --------------------------------------------------------------------------*/
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo    := GetMv("MV_COMP")

dbSelectArea("ZUA")
SetRegua( ZUA->( RecCount() ) )
ZUA->( dbGotop() )
lTitulo := .T.

while ZUA->( !Eof() )
		
	IncRegua()

    IF li > 58 ; CABEC(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo) ; End

    @ li,  000 PSAY PADR(ZUA->ZUA_SQPROT,009," ") +" "+ ;
                    PADR(ZUA->ZUA_CODPER,004," ") +" "+ ;
                    PADR(ZUA->ZUA_DESPER,080," ") +"  "+ ; 
                    PADR(ZUA->ZUA_CODRES,001," ") +"  "+ ;                    
                    PADR(ZUA->ZUA_DESRES,080," ") +" "+ ;
                    PADR( IF ( ZUA->ZUA_TIPRES == "1","Informada","Sugerida"),009," ") 

 	li++	
   	
   	ZUA->( dbSkip() )

End

if li != 80 ; roda(cbcont,cbtxt,tamanho) ; End

/*--------------------------------------------------------------------------
|  Recupera a Integridade dos dados                                         |
 --------------------------------------------------------------------------*/
dbSelectArea("ZUA")

set device to Screen

if aReturn[5] == 1
   Set Printer To
   dbCommitAll()
   OurSpool(wnrel)
endif

MS_FLUSH()

return


/*--------------------------------------------------------------------------
| Programa  | VldCpo    | Autor | Otavio Pinto        | Data |  30/07/2013  |
|---------------------------------------------------------------------------|
| Descricao | Valida o campo ZUA_NREDUZ, baseado no conteudo de ZUA_RELATO. |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
user function VldCpo( _nTipo )
local lRet := .T.
do Case
   case _nTipo == 1 
        if M->ZUA_RELATO $ 'SN ' 
           Aviso('ATENÇÃO','O campo "Relatorio" determinara a mostragem da comorbidade na carta ao beneficiário...',{'Ok'})
        endif                            
   case _nTipo == 2         
        if M->ZUA_RELATO == 'S' .AND. Empty( M->ZUA_NREDUZ )
           lRet := .F.
           Aviso('ATENÇÃO','Se o campo "Relatorio" foi definido como "SIM", o campo "Nome Reduzido" não podera ficar em branco... Verifique.',{'Ok'})
        endif               
endcase        
return lRet




// Fim do Programa CABA074.PRW





