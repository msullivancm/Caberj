#Include "PROTHEUS.CH"
#INCLUDE "rwmake.ch"

/*------------------------------------------------------------------------
| Funcao    | CABR169 | Otavio Pinto                   | Data | 21/01/15  |
|-------------------------------------------------------------------------|
| Descricao | Relatório de Controle de Validade de Medicamentos           |
|-------------------------------------------------------------------------|
| Uso       |                                                             |
|           |                                                             |
 ------------------------------------------------------------------------*/
user function CABR169
private cPerg   := "CABR169" 

ValidPerg()

If ! Pergunte(cPerg,.T.) ; 	Return(Nil) ; EndIf    

Processa({ ||IMP_REL2()},"Gerando Arquivo ... ") 

Return Nil

/*
  IMP_REL2  
  Rotina de impressao
*/

static function IMP_REL2()
/*--------------------------------------------------------------------------
|  Define Variaveis                                                         |
 --------------------------------------------------------------------------*/
local wnrel
local cDesc1  := "Este programa tem como objetivo imprimir lista de"
local cDesc2  := "medicamentos com data de validade, lote...        "
local cDesc3  := ""
local cString := "SD3"
local Tamanho := "M"

private cTitulo := "Rel. de Controle de Validade de Medicamentos"
private cabec1
private cabec2
private aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
private cPerg   := ""
private nomeprog:= "CABR169" 
private nLastKey:= 0



/*-------------------------------------------------
| PARAMETROS UTILIZADOS                            |
|--------------------------------------------------|
|  01  |  Produto De          | mv_par01           |
|  02  |  Produto Ate         | mv_par02           |
|  03  |  Almoxarifado        | mv_par03           |
 -------------------------------------------------*/

/*--------------------------------------------------------------------------
|  Definicao dos cabecalhos                                                 |
 --------------------------------------------------------------------------*/

cabec1:= "CODPRO          DESCRIÇÃO                          STATUS     UNID LOTE            NUMLOTE VALIDADE   ALMOX. DOC        CUSTO SALDO"
//        999999999999999 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  ** VENDIDO **  CO  XXXXXXXXXXXXXXX XXXXXX  99/99/9999   99   999999    102,10 99999 

cabec2:= ""

/*--------------------------------------------------------------------------
|  Envia controle para a funcao SETPRINT                                    |
 --------------------------------------------------------------------------*/
wnrel := "CABR169"

wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,,.F.)

If nLastKey == 27 ; return ; End

SetDefault(aReturn,cString)

If nLastKey == 27 ; return ( NIL ) ; End

RptStatus({|lEnd| ImpTipInt(@lEnd,wnRel,cString)},cTitulo)
Return


/*--------------------------------------------------------------------------
| Programa  | ImpTipInt | Autor | Otavio Pinto        | Data |  19/01/2015  |
|---------------------------------------------------------------------------|
| Descricao | Impressao do Controle do Estoque da Farmácia                  |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       |                                                               | 
 --------------------------------------------------------------------------*/
static function ImpTipInt(lEnd,wnRel,cString)
local   cbcont,cbtxt
local   tamanho:= "M"
local   nTipo 

private cQry   := ""

/*--------------------------------------------------------------------------
|  Variaveis utilizadas para Impressao do Cabecalho e Rodape                |
 --------------------------------------------------------------------------*/
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

nTipo    := GetMv("MV_COMP")
cMatric  := ""
cNomAss  := ""

cQry := "SELECT D3_COD     "
cQry += "     , D3_LOCAL   "
cQry += "     , D3_LOTECTL "
cQry += "     , D3_NUMLOTE "
cQry += "     , D3_DTVALID "
cQry += "     , D3_DOC     "
cQry += "     , D3_CONTA   "   
//ry += "     , D3_CUSTO1  "
cQry += "     ,(SELECT B2_CM1  "
cQry += "       FROM "+RetSQLName("SB2") + " B2 " 
cQry += "       WHERE B2_FILIAL     = '01' "
cQry += "         AND B2_COD        = D3_COD "
cQry += "         AND B2_LOCAL      = D3_LOCAL "       
cQry += "         AND B2.D_E_L_E_T_ = ' ') D3_CUSTO1 "
cQry += "     ,(SELECT B8_SALDO  "
cQry += "       FROM "+RetSQLName("SB8") + " B8 " 
cQry += "       WHERE B8_FILIAL     = '01' "
cQry += "         AND B8_PRODUTO    = D3_COD "
cQry += "         AND B8_LOCAL      = D3_LOCAL "        
cQry += "         AND B8_LOTECTL    = D3_LOTECTL "
cQry += "         AND B8.D_E_L_E_T_ = ' ') D3_SALDO "
cQry += "FROM "+RetSQLName("SD3") + " D3 " 
cQry += "WHERE D3_FILIAL     = '01' "
cQry += "  AND D3_COD        BETWEEN '"+mv_par01+"' AND '"+mv_par02+"' "
cQry += "  AND SUBSTR(D3_CF,1,1) = 'D' "
cQry += "  AND D3_GRUPO      = '11' "

if !empty(mv_par03)
   cQry += "  AND D3_LOCAL   = '"+mv_par03+"' "
endif

cQry += "  AND D3.D_E_L_E_T_ = ' ' "
cQry += "ORDER BY D3_COD, D3_DTVALID "

If Select("TRB") > 0 ; dbSelectArea("TRB") ; TRB->( dbCloseArea() ) ; Endif

dbUseArea(.T., "TOPCONN", TcGenQry(,, cQry), "TRB", .T., .F.)           


dbSelectArea("TRB")
SetRegua( TRB->( RecCount() ) )
TRB->( dbGotop() )
lTitulo := .T.

while TRB->( !Eof() )
		
	IncRegua()
          
    // Filtro Codigo do Medicamento      
    if ! TRB->(  D3_COD >= mv_par01 .AND. D3_COD <= mv_par02 )
       ZRD->( dbSkip() )
       Loop
    endif       

    // Filtro Almoxarifado
    if !Empty(mv_par03) .AND. TRB->( D3_LOCAL <> mv_par03 )
       ZRD->( dbSkip() )
       Loop
    endif       
    
   
    IF li > 58 ; CABEC(cTitulo,cabec1,cabec2,nomeprog,tamanho,nTipo) ; End

    cDescricao := ""
    cUnid      := ""
    if SB1->( dbSeek(xFILIAL("SB1")+TRB->D3_COD)  )
       cDescricao := SB1->B1_DESC
       cUnid      := SB1->B1_UM
    endif
    cStatus := ""
    if CTOD(SUBSTR(TRB->D3_DTVALID,7,2)+"/"+SUBSTR(TRB->D3_DTVALID,5,2)+"/"+SUBSTR(TRB->D3_DTVALID,1,4)) < dDataBase
       cStatus := "** VENCIDO **"
    endif
   
    @ li,  000 PSAY PADR(TRB->D3_COD           ,015," ") +Space(1)+ ;
                    PADR(cDescricao            ,030," ") +Space(2)+ ;
                    PADR(cStatus               ,013," ") +Space(2)+ ;
                    PADR(cUnid                 ,002," ") +Space(2)+ ;
                    PADR(TRB->D3_LOTECTL       ,015," ") +Space(1)+ ;
                    PADR(TRB->D3_NUMLOTE       ,006," ") +Space(2)+ ;
                    PADR(SUBSTR(TRB->D3_DTVALID,7,2)+"/"+SUBSTR(TRB->D3_DTVALID,5,2)+"/"+SUBSTR(TRB->D3_DTVALID,1,4)       ,010," ") +Space(2)+ ;
                    PADR(TRB->D3_LOCAL         ,002," ") +Space(3)+ ;
                    PADR(TRB->D3_DOC           ,006," ") +Space(1)+ ;
                    PADR(TRANSFORM(TRB->D3_CUSTO1,"@RE 9,999.9999") ,010," ") +Space(1)+ ;
                    PADL(TRANSFORM(TRB->D3_SALDO,"@ 99999") ,005," ")
    li ++
   
    TRB->( dbSkip() )
end

if li != 80 ; roda(cbcont,cbtxt,tamanho) ; End

/*--------------------------------------------------------------------------
|  Recupera a Integridade dos dados                                         |
 --------------------------------------------------------------------------*/
dbSelectArea("TRB")

set device to Screen

if aReturn[5] == 1
   Set Printer To
   dbCommitAll()
   OurSpool(wnrel)
endif

MS_FLUSH()

return


/*-------------------------------------------------------------------------- 
| Funcao | ValidPerg     | Autor | Otavio Pinto          | Data | 31/01/2011|
|---------------------------------------------------------------------------|
| Descricao: Verifica a existencia das perguntas criando-as caso seja       |
|            necessario (caso nao existam).                                 |
 --------------------------------------------------------------------------*/
Static Function ValidPerg

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

AAdd(aRegs,{cPerg , "01" , "Produto De               ?" ,"","", "mv_ch1" , "C" ,15  , 0 ,0 , "G" , "" , "mv_par01" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "PLSB1M" , "" })
AAdd(aRegs,{cPerg , "02" , "Produto Ate              ?" ,"","", "mv_ch2" , "C" ,15  , 0 ,0 , "G" , "" , "mv_par02" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "PLSB1M" , "" })
AAdd(aRegs,{cPerg , "03" , "Almoxarifado             ?" ,"","", "mv_ch3" , "C" ,02  , 0 ,0 , "G" , "" , "mv_par03" , ""      , "" , "" , ""      , "" , ""           , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""       , "" })

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

// FIM DA ROTINA CABR169.PRW
