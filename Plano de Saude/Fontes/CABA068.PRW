#INCLUDE "rwmake.ch"

/*/
+-------------------------------------------------------------------------+
| Funcao    | CABA068  | Otavio Pinto                  | Data | 28/01/13  |
+-------------------------------------------------------------------------+
| Descricao | AXCadastro da tabela PBL - Tipos de Servicos                |
+-------------------------------------------------------------------------+
| Uso       | Protocolo de Atendimentos                                   |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
+-------------------------------------------------------------------------+
| Alterado  |                                          | Data |   /  /    |
|           |                                                             |
|           |                                                             |
+-------------------------------------------------------------------------+
/*/

user function CABA068
local cVldAlt   := ".T." 
local cVldExc   := ".T." 
local aRotAdic  := {} 
private cLibera := GetNewPar("MV_YTPSERV","000051,000583,000024,000433,000367,000668")   
Private cString := "PBL"
                                 
begin sequence
	// Testa se usuario esta habilitado a acessar esta rotina.
	// 000051 - judy
	// 000583 - sonia.bandeira 
	// 000024 - carlos
	// 000433 - eloiza.couto
	// 000367 - betyc
	// 000668 - Otavio Pinto
	if !( __cUserID $ AllTrim(cLibera) )
	   MsgAlert("Acesso permitido somente aos usuarios habilitados a executar esta rotina!"+CHR(13)+CHR(13)+; 
	            "SOLUCAO: Incluir ID do usuario no parametro MV_YTPSERV."+CHR(13)+CHR(13)+;
	            "Verifique com sua gerencia.", "AVISO" )
	   break
	endif
	AAdd( aRotAdic, { "Imprimir", "u_PLSR068IMP", 0, 4 } ) 
	
    dbSelectArea(cString); (cString)->(dbOrderNickName('PBL_IDX1'))
    AxCadastro(cString,"Tipos de ServiÃ§os",cVldAlt,cVldExc,aRotAdic)
end sequence

Return
                            
/*-----------------------------------------------------------------------
|Funcao    | RetProx   | Autor | Otavio Pinto        | Data | 27/02/2013 |
|------------------------------------------------------------------------|
| Descricao| Pega o ultimo código na tabela PBL                          |
|------------------------------------------------------------------------|
|          | Esta funcao foi criada em substituicao a GETSX8NUM() que    |
|          | apresentou erro na INTEGRAL.                                |
 -----------------------------------------------------------------------*/
user function RetProx()
local cNum := ' '
beginsql Alias "PBLTMP"
  SELECT Max(PBL_YCDSRV) PBL_YCDSRV
  FROM %table:PBL%
  WHERE D_E_L_E_T_ = ' '  
  ORDER BY 1
endsql
cNum := ( Strzero( Val(PBLTMP->PBL_YCDSRV)+1 , 3 ) )

PBLTMP->( DbCloseArea() ) 

Return cNum



/*--------------------------------------------------------------------------
|Funcao    | PLSR068IMP | Autor | Otavio Pinto          | Data | 26/06/2013 |
|---------------------------------------------------------------------------|
| Descricao| Relatorio da tabela PBL                                        |
|---------------------------------------------------------------------------|
|          |                                                                |
|          |                                                                |
 --------------------------------------------------------------------------*/
user function PLSR068IMP
/*--------------------------------------------------------------------------
|  Define Variaveis                                                         |
 --------------------------------------------------------------------------*/
local wnrel
local cDesc1 := "Este programa tem como objetivo imprimir a Tabela PBL"
local cDesc2 := "Tipos de Servicos"
local cDesc3 := ""
local cString := "PBL"
local Tamanho := "P"

PRIVATE cTitulo:= "Cadastro dos Tipos de Servicos"
PRIVATE cabec1
PRIVATE cabec2
Private aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
Private cPerg   := "PLS068"
Private nomeprog:= "PLS068" 
Private nLastKey:=0

ValidPerg()

Pergunte(cPerg,.F.) 

/*--------------------------------------------------------------------------
|  Definicao dos cabecalhos                                                 |
 --------------------------------------------------------------------------*/

cabec1:= "COD DESCRICAO                                DEPTO                BQ DT.BLOQ  MT"  
//        999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX  9 99/99/99  9
cabec2:= ""


/*--------------------------------------------------------------------------
|  Envia controle para a funcao SETPRINT                                    |
 --------------------------------------------------------------------------*/
wnrel := "PLS068"

wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,,.F.)

If nLastKey == 27 ; return ; End

SetDefault(aReturn,cString)

If nLastKey == 27 ; return ( NIL ) ; End

RptStatus({|lEnd| ImpTipInt(@lEnd,wnRel,cString)},cTitulo)
return


/*--------------------------------------------------------------------------
| Programa  | ImpTipInt | Autor | Otavio Pinto        | Data |  26/06/2013  |
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
local cPBL_YSTBLO := "" 


/*--------------------------------------------------------------------------
|  Variaveis utilizadas para Impressao do Cabecalho e Rodape                |
 --------------------------------------------------------------------------*/
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo    := GetMv("MV_COMP")

dbSelectArea("PBL")
SetRegua( PBL->( RecCount() ) )
PBL->( dbGotop() )
lTitulo := .T.


cPBL_YDEPTO := if( empty(mv_par01)," ", PBL->(Posicione("CTT",1,xFilial("CTT")+ALLTRIM(mv_par01),"CTT_DESC01")) )

cPBL_YSTBLO := if(mv_par02==1,"S",if(mv_par02==2,"N"," "))

while PBL->( !Eof() )
    if !empty(cPBL_YDEPTO)
       if alltrim(PBL->PBL_YDEPTO) <> alltrim(cPBL_YDEPTO)
	      PBL->( dbSkip() )
	      loop
       endif	
	endif        
	if !empty(cPBL_YSTBLO)
       if PBL->PBL_YSTBLO <> cPBL_YSTBLO
	      PBL->( dbSkip() )
	      loop
       endif	
	endif   

	IncRegua()

    IF li > 58 ; CABEC(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo) ; End
    
    @ li,  000 PSAY PADR(PBL->PBL_YCDSRV,003," ") +" "+ ;
                    PADR(PBL->PBL_YDSSRV,040," ") +" "+ ;
                    PADR(PBL->PBL_YDEPTO,020," ") +"  "+ ;
                    PADR(PBL->PBL_YSTBLO,001," ") +" "+ ;
                    PADR(DTOC(PBL->PBL_YDTBLO),008," ") +"  "+ ;
                    PADR(PBL->PBL_YMETDA,001," ") 
					
 	li++	
   	
   	PBL->( dbSkip() )

End

if li != 80 ; roda(cbcont,cbtxt,tamanho) ; End

/*--------------------------------------------------------------------------
|  Recupera a Integridade dos dados                                         |
 --------------------------------------------------------------------------*/
dbSelectArea("PBL")

set device to Screen

if aReturn[5] == 1
   Set Printer To
   dbCommitAll()
   OurSpool(wnrel)
endif

MS_FLUSH()

return

/*--------------------------------------------------------------------------
| Funcao    | ValidPerg | Autor | Otavio Pinto        | Data |  26/06/2013  |
|---------------------------------------------------------------------------|
| Descricao | Verifica a existencia das perguntas criando-as caso seja      |
|           | necessario (caso nao existam).                                |
|---------------------------------------------------------------------------|
| Uso       | Projeto Qualidade de Vida                                     | 
 --------------------------------------------------------------------------*/
static function ValidPerg

Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel               /GSC/Valid/Var01/        Def01///Cnt01/Var02/             Def02///Cnt02/Var03/ Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

Aadd(aRegs,{cPerg , "01" , "Departamento        ?" ,"","", "mv_ch1" , "C" , 20 ,0 ,0 , "G" , "" , "mv_par01" , ""            , "" , "" , "" , "" , ""                , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" })
Aadd(aRegs,{cPerg , "02" , "Bloqueado           ?" ,"","", "mv_ch2" , "N" , 01 ,0 ,0 , "C" , "" , "mv_par02" , "SIM"         , "" , "" , "" , "" , "NAO"             , "" , "" , "" , "" , "AMBOS"        , "" , "" , "" , "" , ""             , "" , "" , "" , "" , ""      , "" , "" , "" , "CTTBA" , "" })

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



// Fim da Rotina CABA068.PRW