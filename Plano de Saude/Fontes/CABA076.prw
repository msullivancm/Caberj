#INCLUDE "rwmake.ch"
/*--------------------------------------------------------------------------
| Programa  | CABA076  | Autor | Otavio Pinto         | Data |  24/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Procedimento do Protocolo                                     |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
user function CABA076

/*--------------------------------------------------------------------------
| Declaracao de Variaveis                                                   |
 --------------------------------------------------------------------------*/

local cVldAlt   := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
local cVldExc   := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
local aRotAdic  := {} 

private cString := "ZUC"

AAdd( aRotAdic, { "Imprimir", "u_PLSRZUCIMP", 0, 4 } ) 

dbSelectArea(cString)

(cString)->( dbSetOrder(1) )

AxCadastro(cString,"Procedimento do Protocolo",cVldExc,"ExecBlock('ALTZUC')",aRotAdic)

return



user function PLSRZUCIMP
/*--------------------------------------------------------------------------
|  Define Variaveis                                                         |
 --------------------------------------------------------------------------*/
local wnrel
local cDesc1 := "Este programa tem como objetivo imprimir o cadastro"
local cDesc2 := "do Procedimento do Protocolo (ZUC)"
local cDesc3 := ""
local cString := "ZUC"
local Tamanho := "M"

PRIVATE cTitulo:= "Cadastro do Procedimento do Protocolo"
PRIVATE cabec1
PRIVATE cabec2
Private aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
Private cPerg   := ""
Private nomeprog:= "PLSR076" 
Private nLastKey:=0

/*--------------------------------------------------------------------------
|  Definicao dos cabecalhos                                                 |
 --------------------------------------------------------------------------*/

cabec1:= "PROTOC.   CD.PREVEN PROCED.   DESCRICAO                      ESP DESCRICAO                     TAB VALIDADE  QTDE"
//        000000000 999999999 999999999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99 XXXXXXXX  99999
cabec2:= ""

/*--------------------------------------------------------------------------
|  Envia controle para a funcao SETPRINT                                    |
 --------------------------------------------------------------------------*/
wnrel := "PLSR076"

wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,,.F.)

If nLastKey == 27 ; return ; end

SetDefault(aReturn,cString)

If nLastKey == 27 ; return ( NIL ) ; end

RptStatus({|lEnd| ImpTipInt(@lEnd,wnRel,cString)},cTitulo)
Return


/*--------------------------------------------------------------------------
| Programa  | ImpTipInt | Autor | Otavio Pinto        | Data |  24/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Impressao do cadastro de Protocolo de Prevencao               |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
static function ImpTipInt(lEnd,wnRel,cString)
local cbcont,cbtxt
local tamanho:= "M"
local nTipo 

/*--------------------------------------------------------------------------
|  Variaveis utilizadas para Impressao do Cabecalho e Rodape                |
 --------------------------------------------------------------------------*/
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo    := GetMv("MV_COMP")

dbSelectArea("ZUC")
SetRegua( ZUC->( RecCount() ) )
ZUC->( dbGotop() )
lTitulo := .T.

while ZUC->( !Eof() )
		
	IncRegua()

    IF li > 58 ; CABEC(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo) ; End
	
    @ li,  000 PSAY PADR(ZUC->ZUC_SQPROT,09," ") +" "+ ;
                    PADR(ZUC->ZUC_SBPROT,09," ") +" "+ ; 
					PADR(ZUC->ZUC_SQPROC,09," ") +" "+ ;					
					PADR(ZUC->ZUC_DESCRI,30," ") +" "+ ;
					PADR(ZUC->ZUC_CDESP ,03," ") +" "+ ;
					PADR(ZUC->ZUC_DESESP,30," ") +" "+ ;
					PADR(ZUC->ZUC_CODTAB,02," ") +" "+ ;
			        PADR( if(ALLTRIM(str(ZUC->ZUC_VALIDA,4))<> "0",ALLTRIM(str(ZUC->ZUC_VALIDA,4)),"")+if(!empty(ZUC->ZUC_VALIDA)," MESES",""),08," ") +"     "+ ;
   					PADR(ZUC->ZUC_QUANTI,05," ")
 	li++	
   	
   	ZUC->( dbSkip() )

End

if li != 80 ; roda(cbcont,cbtxt,tamanho) ; End

/*--------------------------------------------------------------------------
|  Recupera a Integridade dos dados                                         |
 --------------------------------------------------------------------------*/
dbSelectArea("ZUC")

set device to Screen

if aReturn[5] == 1
   Set Printer To
   dbCommitAll()
   OurSpool(wnrel)
endif

MS_FLUSH()

return



/*--------------------------------------------------------------------------
| Programa  | ALTZUC    | Autor | Otavio Pinto        | Data |  02/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Critica a duplicidade de registro...                          |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
User Function ALTZUC()
local _lRet	:= .F.
local cQry  := ""

M->ZUC_SQPROT = ALLTRIM(M->ZUC_SQPROT)
M->ZUC_SBPROT = ALLTRIM(M->ZUC_SBPROT)
M->ZUC_CODTAB = ALLTRIM(M->ZUC_CODTAB)
M->ZUC_CODPRO = ALLTRIM(M->ZUC_CODPRO)

//Leonardo Portella - 06/07/13 - Inicio - Alteracao de campos ZUC_ para M->ZUC_ na query pois nao estava pegando o conteudo de memoria (digitado)

cQry := " SELECT ZUC_SQPROT,ZUC_SBPROT,ZUC_CODTAB,ZUC_CODPRO "
cQry += " FROM "+RetSQLName("ZUC")+" ZUC "
cQry += " WHERE ZUC_FILIAL = '"+xFilial("ZUC")+"' "
cQry += "   AND ZUC_SQPROT = '"+M->ZUC_SQPROT+"' " 
cQry += "   AND ZUC_SBPROT = '"+M->ZUC_SBPROT+"' "
cQry += "   AND ZUC_CODTAB = '"+M->ZUC_CODTAB+"' "
cQry += "   AND ZUC_CODPRO = '"+M->ZUC_CODPRO+"' "
cQry += "   AND ZUC.D_E_L_E_T_ = ' ' "

//Leonardo Portella - 06/07/13 - Fim

PLSQuery(cQry,"TMP")    
dbselectarea("TMP")
If Eof()
	_lRet := .T.
Else          
	//Leonardo Portella - 06/09/13 - Critica de registro duplicado estava sendo exibida na alteracao. Chave nao muda logo tenho que verificar somente na INCLUSAO, caso
	//contrario ira criticar com registro duplicado o proprio registro.
	If INCLUI 
		MsgStop("Este registro já existe... Verifique !!",AllTrim(SM0->M0_NOMECOM)) 
	Else
		_lRet := .T.
	EndIf
	//Leonardo Portella - 06/09/13 - Fim
	
EndIf
TMP->( dbCloseArea() )

Return(_lRet)




// Fim do Programa CABA076.PRW
